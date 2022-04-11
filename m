Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB374FB1B1
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Apr 2022 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbiDKCbN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 Apr 2022 22:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbiDKCbE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 10 Apr 2022 22:31:04 -0400
Received: from smtp.infotech.no (smtp.infotech.no [82.134.31.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946F838796
        for <linux-scsi@vger.kernel.org>; Sun, 10 Apr 2022 19:28:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id CE7BF2041BD;
        Mon, 11 Apr 2022 04:28:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TC6IrtM1wvXq; Mon, 11 Apr 2022 04:28:47 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        by smtp.infotech.no (Postfix) with ESMTPA id 7B16F2041CB;
        Mon, 11 Apr 2022 04:28:43 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v24 03/46] sg: sg_log and is_enabled
Date:   Sun, 10 Apr 2022 22:27:53 -0400
Message-Id: <20220411022836.11871-4-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411022836.11871-1-dgilbert@interlog.com>
References: <20220411022836.11871-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace SCSI_LOG_TIMEOUT macros with SG_LOG macros across the driver.
The definition of SG_LOG calls SCSI_LOG_TIMEOUT if given and derived
pointers are non-zero, calls pr_info otherwise. SG_LOGS additionally
prints the sg device name and the thread id. The thread id is very
useful, even in single threaded invocations because the driver not
only uses the invocer's thread but also uses work queues and the
main callback (i.e. sg_rq_end_io()) may hit any thread. Some
interesting cases arise when the callback hits its invocer's
thread.

SG_LOGS takes 48 bytes on the stack to build this printf format
string: "sg%u: tid=%d" whose size is clearly bounded above by
the maximum size of those two integers.
Protecting against the 'current' pointer being zero is for safety
and the case where the boot device is SCSI and the sg driver is
built into the kernel. Also when debugging, getting a message
from a compromised kernel can be very useful in pinpointing the
location of the failure.

The simple fact that the SG_LOG macro is shorter than
SCSI_LOG_TIMEOUT macro allow more error message "payload" per line.

Also replace #if and #ifdef conditional compilations with
the IS_ENABLED macro.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 250 +++++++++++++++++++++++-----------------------
 1 file changed, 125 insertions(+), 125 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3def943d6c05..8a75aa81228a 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -62,6 +62,15 @@ static char *sg_version_date = "20190606";
 
 #define SG_MAX_DEVS 32768
 
+/* Comment out the following line to compile out SCSI_LOGGING stuff */
+#define SG_DEBUG 1
+
+#if !IS_ENABLED(SG_DEBUG)
+#if IS_ENABLED(DEBUG)	/* If SG_DEBUG not defined, check for DEBUG */
+#define SG_DEBUG DEBUG
+#endif
+#endif
+
 /* SG_MAX_CDB_SIZE should be 260 (spc4r37 section 3.1.30) however the type
  * of sg_io_hdr::cmd_len can only represent 255. All SCSI commands greater
  * than 16 bytes are "variable length" whose length is a multiple of 4
@@ -179,7 +188,7 @@ static ssize_t sg_new_write(struct sg_fd *sfp, struct file *file,
 static int sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 			   u8 *cmnd, int timeout, int blocking);
 static int sg_read_oxfer(struct sg_request *srp, char __user *outp,
-			 int num_read_xfer);
+			 int num_xfer);
 static void sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp);
 static void sg_build_reserve(struct sg_fd *sfp, int req_size);
 static void sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp,
@@ -192,13 +201,45 @@ static int sg_remove_request(struct sg_fd *sfp, struct sg_request *srp);
 static struct sg_device *sg_get_dev(int dev);
 static void sg_device_destroy(struct kref *kref);
 
-#define SZ_SG_HEADER sizeof(struct sg_header)
-#define SZ_SG_IO_HDR sizeof(sg_io_hdr_t)
-#define SZ_SG_IOVEC sizeof(sg_iovec_t)
-#define SZ_SG_REQ_INFO sizeof(sg_req_info_t)
+#define SZ_SG_HEADER ((int)sizeof(struct sg_header))	/* v1 and v2 header */
+#define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
+#define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
+
+/*
+ * Kernel needs to be built with CONFIG_SCSI_LOGGING to see log messages.
+ * 'depth' is a number between 1 (most severe) and 7 (most noisy, most
+ * information). All messages are logged as informational (KERN_INFO). In
+ * the unexpected situation where sfp or sdp is NULL the macro reverts to
+ * a pr_info and ignores SCSI_LOG_TIMEOUT and always prints to the log.
+ * Example: this invocation: 'scsi_logging_level -s -T 3' will print
+ * depth (aka level) 1 and 2 SG_LOG() messages.
+ */
+
+#define SG_PROC_DEBUG_SZ 8192
+
+#if IS_ENABLED(CONFIG_SCSI_LOGGING) && IS_ENABLED(SG_DEBUG)
+#define SG_LOG_BUFF_SZ 48
+
+#define SG_LOG(depth, sfp, fmt, a...)					\
+	do {								\
+		char _b[SG_LOG_BUFF_SZ];				\
+		int _tid = (current ? current->pid : -1);		\
+		struct sg_fd *_fp = sfp;				\
+		struct sg_device *_sdp = _fp ? _fp->parentdp : NULL;	\
+									\
+		if (likely(_sdp)) {					\
+			snprintf(_b, sizeof(_b), "sg%u: tid=%d",	\
+				 _sdp->index, _tid);			\
+			SCSI_LOG_TIMEOUT(depth,				\
+					 sdev_prefix_printk(KERN_INFO,	\
+					 _sdp->device, _b, fmt, ##a));	\
+		} else							\
+			pr_info("sg: sdp or sfp NULL, " fmt, ##a);	\
+	} while (0)
+#else
+#define SG_LOG(depth, sfp, fmt, a...) do { } while (0)
+#endif	/* end of CONFIG_SCSI_LOGGING && SG_DEBUG conditional */
 
-#define sg_printk(prefix, sdp, fmt, a...) \
-	sdev_prefix_printk(prefix, (sdp)->device, (sdp)->name, fmt, ##a)
 
 /*
  * The SCSI interfaces that use read() and write() as an asynchronous variant of
@@ -285,9 +326,6 @@ sg_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(sdp))
 		return PTR_ERR(sdp);
 
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_open: flags=0x%x\n", op_flags));
-
 	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
 	retval = scsi_device_get(sdp->device);
@@ -345,6 +383,9 @@ sg_open(struct inode *inode, struct file *filp)
 	filp->private_data = sfp;
 	sdp->open_cnt++;
 	mutex_unlock(&sdp->open_rel_lock);
+	SG_LOG(3, sfp, "%s: minor=%d, op_flags=0x%x; %s count prior=%d%s\n",
+	       __func__, min_dev, op_flags, "device open", sdp->open_cnt,
+	       ((op_flags & O_NONBLOCK) ? " O_NONBLOCK" : ""));
 
 	retval = 0;
 sg_put:
@@ -375,9 +416,10 @@ sg_release(struct inode *inode, struct file *filp)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
+	SG_LOG(3, sfp, "%s: device open count prior=%d\n", __func__,
+	       sdp->open_cnt);
 	if (!sdp)
 		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp, "sg_release\n"));
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
@@ -416,10 +458,9 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
+	SG_LOG(3, sfp, "%s: write(3rd arg) count=%d\n", __func__, (int)count);
 	if (!sdp)
 		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_write: count=%d\n", (int) count));
 	if (atomic_read(&sdp->detaching))
 		return -ENODEV;
 	if (!((filp->f_flags & O_NONBLOCK) ||
@@ -442,8 +483,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 		return -EFAULT;
 
 	if (!(srp = sg_add_request(sfp))) {
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sdp,
-					      "sg_write: queue full\n"));
+		SG_LOG(1, sfp, "%s: queue full\n", __func__);
 		return -EDOM;
 	}
 	mutex_lock(&sfp->f_mutex);
@@ -456,9 +496,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 			cmd_size = 12;
 	}
 	mutex_unlock(&sfp->f_mutex);
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sdp,
-		"sg_write:   scsi opcode=0x%02x, cmd_size=%d\n", (int) opcode, cmd_size));
-/* Determine buffer size.  */
+	SG_LOG(4, sfp, "%s:   scsi opcode=0x%02x, cmd_size=%d\n", __func__,
+	       (unsigned int)opcode, cmd_size);
 	input_size = count - cmd_size;
 	mxsize = (input_size > old_hdr.reply_len) ? input_size : old_hdr.reply_len;
 	mxsize -= SZ_SG_HEADER;
@@ -541,8 +580,7 @@ sg_new_write(struct sg_fd *sfp, struct file *file, const char __user *buf,
 
 	sfp->cmd_q = 1;	/* when sg_io_hdr seen, set command queuing on */
 	if (!(srp = sg_add_request(sfp))) {
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
-					      "sg_new_write: queue full\n"));
+		SG_LOG(1, sfp, "%s: queue full\n", __func__);
 		return -EDOM;
 	}
 	srp->sg_io_owned = sg_io_owned;
@@ -607,9 +645,8 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 	hp->host_status = 0;
 	hp->driver_status = 0;
 	hp->resid = 0;
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
-			(int) cmnd[0], (int) hp->cmd_len));
+	SG_LOG(4, sfp, "%s:  opcode=0x%02x, cmd_sz=%d\n", __func__,
+	       (int)cmnd[0], hp->cmd_len);
 
 	if (hp->dxfer_len >= SZ_256M) {
 		sg_remove_request(sfp, srp);
@@ -618,8 +655,7 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 
 	k = sg_start_req(srp, cmnd);
 	if (k) {
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
-			"sg_common_write: start_req err=%d\n", k));
+		SG_LOG(1, sfp, "%s: start_req err=%d\n", __func__, k);
 		sg_finish_rem_req(srp);
 		sg_remove_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
@@ -752,9 +788,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "%s: count=%d\n", __func__,
-				      (int)count));
+	SG_LOG(3, sfp, "%s: read() count=%d\n", __func__, (int)count);
 	if (!sdp)
 		return -ENXIO;
 
@@ -977,8 +1011,8 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 	struct sg_request *srp;
 	unsigned long iflags;
 
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
+	SG_LOG(6, sfp, "%s: cmd=0x%x, O_NONBLOCK=%d\n", __func__, cmd_in,
+	       !!(filp->f_flags & O_NONBLOCK));
 	read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
 
 	switch (cmd_in) {
@@ -1254,24 +1288,16 @@ sg_poll(struct file *filp, poll_table * wait)
 			res |= EPOLLOUT | EPOLLWRNORM;
 	} else if (count < SG_MAX_QUEUE)
 		res |= EPOLLOUT | EPOLLWRNORM;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_poll: res=0x%x\n", (__force u32) res));
+	SG_LOG(3, sfp, "%s: res=0x%x\n", __func__, (__force u32)res);
 	return res;
 }
 
 static int
 sg_fasync(int fd, struct file *filp, int mode)
 {
-	struct sg_device *sdp;
-	struct sg_fd *sfp;
-
-	sfp = filp->private_data;
-	sdp = sfp->parentdp;
-	if (!sdp)
-		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_fasync: mode=%d\n", mode));
+	struct sg_fd *sfp = filp->private_data;
 
+	SG_LOG(3, sfp, "%s: mode(%s)\n", __func__, (mode ? "add" : "remove"));
 	return fasync_helper(fd, filp, mode, &sfp->async_qp);
 }
 
@@ -1298,10 +1324,8 @@ sg_vma_fault(struct vm_fault *vmf)
 	offset = vmf->pgoff << PAGE_SHIFT;
 	if (offset >= rsv_schp->bufflen)
 		return VM_FAULT_SIGBUS;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_vma_fault: offset=%lu, scatg=%d\n",
-				      offset, rsv_schp->k_use_sg));
 	sa = vma->vm_start;
+	SG_LOG(3, sfp, "%s: vm_start=0x%lx, off=%lu\n", __func__, sa, offset);
 	length = 1 << (PAGE_SHIFT + rsv_schp->page_order);
 	for (k = 0; k < rsv_schp->k_use_sg && sa < vma->vm_end; k++) {
 		len = vma->vm_end - sa;
@@ -1341,9 +1365,8 @@ sg_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -ENXIO;
 	}
 	req_sz = vma->vm_end - vma->vm_start;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_mmap starting, vm_start=%p, len=%d\n",
-				      (void *) vma->vm_start, (int) req_sz));
+	SG_LOG(3, sfp, "%s: vm_start=%p, len=%d\n", __func__,
+	       (void *)vma->vm_start, (int)req_sz);
 	if (vma->vm_pgoff)
 		return -EINVAL;	/* want no offset */
 	rsv_schp = &sfp->reserve;
@@ -1412,10 +1435,9 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	result = scmd->result;
 	resid = scmd->resid_len;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sdp,
-				      "sg_cmd_done: pack_id=%d, res=0x%x\n",
-				      srp->header.pack_id, result));
 	srp->header.resid = resid;
+	SG_LOG(6, sfp, "%s: pack_id=%d, res=0x%x\n", __func__,
+	       srp->header.pack_id, result);
 	ms = jiffies_to_msecs(jiffies);
 	srp->header.duration = (ms > srp->header.duration) ?
 				(ms - srp->header.duration) : 0;
@@ -1533,7 +1555,7 @@ sg_alloc(struct scsi_device *scsidp)
 	k = error;
 
 	SCSI_LOG_TIMEOUT(3, sdev_printk(KERN_INFO, scsidp,
-					"sg_alloc: dev=%d \n", k));
+			"%s: dev=%d, sdp=0x%p ++\n", __func__, k, sdp));
 	sprintf(sdp->name, "sg%d", k);
 	sdp->device = scsidp;
 	mutex_init(&sdp->open_rel_lock);
@@ -1632,7 +1654,11 @@ sg_device_destroy(struct kref *kref)
 	struct sg_device *sdp = container_of(kref, struct sg_device, d_ref);
 	unsigned long flags;
 
-	/* CAUTION!  Note that the device can still be found via idr_find()
+	SCSI_LOG_TIMEOUT(1, pr_info("[tid=%d] %s: sdp idx=%d, sdp=0x%p --\n",
+				    (current ? current->pid : -1), __func__,
+				    sdp->index, sdp));
+	/*
+	 * CAUTION!  Note that the device can still be found via idr_find()
 	 * even though the refcount is 0.  Therefore, do idr_remove() BEFORE
 	 * any other cleanup.
 	 */
@@ -1641,9 +1667,6 @@ sg_device_destroy(struct kref *kref)
 	idr_remove(&sg_index_idr, sdp->index);
 	write_unlock_irqrestore(&sg_index_lock, flags);
 
-	SCSI_LOG_TIMEOUT(3,
-		sg_printk(KERN_INFO, sdp, "sg_device_destroy\n"));
-
 	kfree(sdp);
 }
 
@@ -1663,8 +1686,8 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 	if (val > 1)
 		return; /* only want to do following once per device */
 
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "%s\n", __func__));
+	SCSI_LOG_TIMEOUT(3, sdev_printk(KERN_INFO, sdp->device,
+					"%s: 0x%p\n", __func__, sdp));
 
 	read_lock_irqsave(&sdp->sfd_lock, iflags);
 	list_for_each_entry(sfp, &sdp->sfds, sfd_siblings) {
@@ -1765,7 +1788,7 @@ init_sg(void)
 	return rc;
 }
 
-#ifndef CONFIG_SCSI_PROC_FS
+#if !IS_ENABLED(CONFIG_SCSI_PROC_FS)
 static int
 sg_proc_init(void)
 {
@@ -1777,9 +1800,8 @@ static void __exit
 exit_sg(void)
 {
 	unregister_sg_sysctls();
-#ifdef CONFIG_SCSI_PROC_FS
-	remove_proc_subtree("scsi/sg", NULL);
-#endif				/* CONFIG_SCSI_PROC_FS */
+	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
+		remove_proc_subtree("scsi/sg", NULL);
 	scsi_unregister_interface(&sg_interface);
 	class_destroy(sg_sysfs_class);
 	sg_sysfs_valid = 0;
@@ -1805,9 +1827,8 @@ sg_start_req(struct sg_request *srp, unsigned char *cmd)
 	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
 	struct scsi_cmnd *scmd;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_start_req: dxfer_len=%d\n",
-				      dxfer_len));
+	SG_LOG(4, sfp, "%s: dxfer_len=%d, data-%s\n", __func__, dxfer_len,
+	       (rw ? "OUT" : "IN"));
 
 	/*
 	 * NOTE
@@ -1919,9 +1940,8 @@ sg_finish_rem_req(struct sg_request *srp)
 	struct sg_fd *sfp = srp->parentfp;
 	struct sg_scatter_hold *req_schp = &srp->data;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_finish_rem_req: res_used=%d\n",
-				      (int) srp->res_used));
+	SG_LOG(4, sfp, "%s: srp=0x%p%s\n", __func__, srp,
+	       (srp->res_used) ? " rsv" : "");
 	if (srp->bio)
 		ret = blk_rq_unmap_user(srp->bio);
 
@@ -1965,9 +1985,8 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 		++blk_size;	/* don't know why */
 	/* round request up to next highest SG_SECTOR_SZ byte boundary */
 	blk_size = ALIGN(blk_size, SG_SECTOR_SZ);
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-		"sg_build_indirect: buff_size=%d, blk_size=%d\n",
-		buff_size, blk_size));
+	SG_LOG(4, sfp, "%s: buff_size=%d, blk_size=%d\n", __func__, buff_size,
+	       blk_size);
 
 	/* N.B. ret_sz carried into this block ... */
 	mx_sc_elems = sg_build_sgat(schp, sfp, sg_tablesize);
@@ -2003,18 +2022,13 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 				scatter_elem_sz_prev = ret_sz;
 			}
 		}
-
-		SCSI_LOG_TIMEOUT(5, sg_printk(KERN_INFO, sfp->parentdp,
-				 "sg_build_indirect: k=%d, num=%d, ret_sz=%d\n",
-				 k, num, ret_sz));
+		SG_LOG(5, sfp, "%s: k=%d, num=%d, ret_sz=%d\n", __func__, k,
+		       num, ret_sz);
 	}		/* end of for loop */
 
 	schp->page_order = order;
 	schp->k_use_sg = k;
-	SCSI_LOG_TIMEOUT(5, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_build_indirect: k_use_sg=%d, rem_sz=%d\n",
-			 k, rem_sz));
-
+	SG_LOG(5, sfp, "%s: k_use_sg=%d, order=%d\n", __func__, k, order);
 	schp->bufflen = blk_size;
 	if (rem_sz > 0)	/* must have failed */
 		return -ENOMEM;
@@ -2032,35 +2046,34 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 static void
 sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp)
 {
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_remove_scat: k_use_sg=%d\n", schp->k_use_sg));
+	SG_LOG(4, sfp, "%s: num_sgat=%d\n", __func__, schp->k_use_sg);
 	if (schp->pages && schp->sglist_len > 0) {
 		if (!schp->dio_in_use) {
 			int k;
 
 			for (k = 0; k < schp->k_use_sg && schp->pages[k]; k++) {
-				SCSI_LOG_TIMEOUT(5,
-					sg_printk(KERN_INFO, sfp->parentdp,
-					"sg_remove_scat: k=%d, pg=0x%p\n",
-					k, schp->pages[k]));
+				SG_LOG(5, sfp, "%s: pg[%d]=0x%p --\n",
+				       __func__, k, schp->pages[k]);
 				__free_pages(schp->pages[k], schp->page_order);
 			}
-
 			kfree(schp->pages);
 		}
 	}
 	memset(schp, 0, sizeof (*schp));
 }
 
+/*
+ * For sg v1 and v2 interface: with a command yielding a data-in buffer, after
+ * it has arrived in kernel memory, this function copies it to the user space,
+ * appended to given struct sg_header object.
+ */
 static int
 sg_read_oxfer(struct sg_request *srp, char __user *outp, int num_read_xfer)
 {
 	struct sg_scatter_hold *schp = &srp->data;
 	int k, num;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, srp->parentfp->parentdp,
-			 "sg_read_oxfer: num_read_xfer=%d\n",
-			 num_read_xfer));
+	SG_LOG(4, srp->parentfp, "%s: num_xfer=%d\n", __func__, num_read_xfer);
 	if ((!outp) || (num_read_xfer <= 0))
 		return 0;
 
@@ -2090,8 +2103,7 @@ sg_build_reserve(struct sg_fd *sfp, int req_size)
 {
 	struct sg_scatter_hold *schp = &sfp->reserve;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_build_reserve: req_size=%d\n", req_size));
+	SG_LOG(3, sfp, "%s: buflen=%d\n", __func__, req_size);
 	do {
 		if (req_size < PAGE_SIZE)
 			req_size = PAGE_SIZE;
@@ -2111,8 +2123,7 @@ sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp, int size)
 	int k, num, rem;
 
 	srp->res_used = 1;
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_link_reserve: size=%d\n", size));
+	SG_LOG(4, sfp, "%s: size=%d\n", __func__, size);
 	rem = size;
 
 	num = 1 << (PAGE_SHIFT + rsv_schp->page_order);
@@ -2130,8 +2141,7 @@ sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp, int size)
 	}
 
 	if (k >= rsv_schp->k_use_sg) {
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
-				 "sg_link_reserve: BAD size\n"));
+		SG_LOG(1, sfp, "%s: BAD size\n", __func__);
 	}
 }
 
@@ -2140,9 +2150,8 @@ sg_unlink_reserve(struct sg_fd *sfp, struct sg_request *srp)
 {
 	struct sg_scatter_hold *req_schp = &srp->data;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, srp->parentfp->parentdp,
-				      "sg_unlink_reserve: req->k_use_sg=%d\n",
-				      (int) req_schp->k_use_sg));
+	SG_LOG(4, srp->parentfp, "%s: req->k_use_sg=%d\n", __func__,
+	       (int)req_schp->k_use_sg);
 	req_schp->k_use_sg = 0;
 	req_schp->bufflen = 0;
 	req_schp->pages = NULL;
@@ -2233,18 +2242,15 @@ sg_add_sfp(struct sg_device *sdp)
 	}
 	list_add_tail(&sfp->sfd_siblings, &sdp->sfds);
 	write_unlock_irqrestore(&sdp->sfd_lock, iflags);
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_add_sfp: sfp=0x%p\n", sfp));
+	SG_LOG(3, sfp, "%s: sfp=0x%p\n", __func__, sfp);
 	if (unlikely(sg_big_buff != def_reserved_size))
 		sg_big_buff = def_reserved_size;
 
 	bufflen = min_t(int, sg_big_buff,
 			max_sectors_bytes(sdp->device->request_queue));
 	sg_build_reserve(sfp, bufflen);
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_add_sfp: bufflen=%d, k_use_sg=%d\n",
-				      sfp->reserve.bufflen,
-				      sfp->reserve.k_use_sg));
+	SG_LOG(3, sfp, "%s: bufflen=%d, k_use_sg=%d\n", __func__,
+	       sfp->reserve.bufflen, sfp->reserve.k_use_sg);
 
 	kref_get(&sdp->d_ref);
 	__module_get(THIS_MODULE);
@@ -2270,15 +2276,12 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (sfp->reserve.bufflen > 0) {
-		SCSI_LOG_TIMEOUT(6, sg_printk(KERN_INFO, sdp,
-				"sg_remove_sfp:    bufflen=%d, k_use_sg=%d\n",
-				(int) sfp->reserve.bufflen,
-				(int) sfp->reserve.k_use_sg));
+		SG_LOG(6, sfp, "%s:    bufflen=%d, k_use_sg=%d\n", __func__,
+		       (int)sfp->reserve.bufflen, (int)sfp->reserve.k_use_sg);
 		sg_remove_scat(sfp, &sfp->reserve);
 	}
 
-	SCSI_LOG_TIMEOUT(6, sg_printk(KERN_INFO, sdp,
-			"sg_remove_sfp: sfp=0x%p\n", sfp));
+	SG_LOG(6, sfp, "%s: sfp=0x%p\n", __func__, sfp);
 	kfree(sfp);
 
 	scsi_device_put(sdp->device);
@@ -2301,7 +2304,6 @@ sg_remove_sfp(struct kref *kref)
 	schedule_work(&sfp->ew.work);
 }
 
-#ifdef CONFIG_SCSI_PROC_FS
 static int
 sg_idr_max_id(int id, void *p, void *data)
 {
@@ -2313,19 +2315,6 @@ sg_idr_max_id(int id, void *p, void *data)
 	return 0;
 }
 
-static int
-sg_last_dev(void)
-{
-	int k = -1;
-	unsigned long iflags;
-
-	read_lock_irqsave(&sg_index_lock, iflags);
-	idr_for_each(&sg_index_idr, sg_idr_max_id, &k);
-	read_unlock_irqrestore(&sg_index_lock, iflags);
-	return k + 1;		/* origin 1 */
-}
-#endif
-
 /* must be called with sg_index_lock held */
 static struct sg_device *
 sg_lookup_dev(int dev)
@@ -2355,7 +2344,7 @@ sg_get_dev(int dev)
 	return sdp;
 }
 
-#ifdef CONFIG_SCSI_PROC_FS
+#if IS_ENABLED(CONFIG_SCSI_PROC_FS)     /* long, almost to end of file */
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
 static int sg_proc_single_open_adio(struct inode *inode, struct file *file);
@@ -2428,6 +2417,17 @@ sg_proc_init(void)
 	return 0;
 }
 
+static int
+sg_last_dev(void)
+{
+	int k = -1;
+	unsigned long iflags;
+
+	read_lock_irqsave(&sg_index_lock, iflags);
+	idr_for_each(&sg_index_idr, sg_idr_max_id, &k);
+	read_unlock_irqrestore(&sg_index_lock, iflags);
+	return k + 1;		/* origin 1 */
+}
 
 static int
 sg_proc_seq_show_int(struct seq_file *s, void *v)
@@ -2685,7 +2685,7 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	return 0;
 }
 
-#endif				/* CONFIG_SCSI_PROC_FS */
+#endif				/* CONFIG_SCSI_PROC_FS (~300 lines back) */
 
 module_init(init_sg);
 module_exit(exit_sg);
-- 
2.25.1

