Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8E29E55
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391473AbfEXSsY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:24 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56331 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbfEXSsY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 960DC20418A;
        Fri, 24 May 2019 20:48:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dYLBmpPQywUV; Fri, 24 May 2019 20:48:19 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id BC090204172;
        Fri, 24 May 2019 20:48:14 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 03/19] sg: sg_log and is_enabled
Date:   Fri, 24 May 2019 14:47:53 -0400
Message-Id: <20190524184809.25121-4-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace SCSI_LOG_TIMEOUT macros with SG_LOG macros across the driver.
The definition of SG_LOG calls SCSI_LOG_TIMEOUT if scsi_device
pointer is non-zero, calls pr_info otherwise. Prints the thread id
if current is non-zero, -1 otherwise.

Also replace #if and #ifdef conditional compilations with
the IS_ENABLED macro.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 254 ++++++++++++++++++++++------------------------
 1 file changed, 123 insertions(+), 131 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 7be3d777dbd4..291c278451ef 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -173,8 +173,8 @@ static ssize_t sg_new_write(struct sg_fd *sfp, struct file *file,
 			struct sg_request **o_srp);
 static int sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 			   u8 *cmnd, int timeout, int blocking);
-static int sg_read_oxfer(struct sg_request *srp, char __user *outp,
-			 int num_read_xfer);
+static int sg_rd_append(struct sg_request *srp, char __user *outp,
+			int num_xfer);
 static void sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp);
 static void sg_build_reserve(struct sg_fd *sfp, int req_size);
 static void sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp,
@@ -192,6 +192,26 @@ static void sg_device_destroy(struct kref *kref);
 #define SZ_SG_IOVEC sizeof(sg_iovec_t)
 #define SZ_SG_REQ_INFO sizeof(sg_req_info_t)
 
+#if IS_ENABLED(CONFIG_SCSI_LOGGING)
+#define SG_LOG(depth, sdp, fmt, a...)					\
+	do {								\
+		char _b[160];						\
+		int _tid = (current ? current->pid : -1);		\
+									\
+		if ((sdp) && (sdp)->disk) {				\
+			snprintf(_b, sizeof(_b), "%s: tid=%d",		\
+				 (sdp)->disk->disk_name, _tid);		\
+			SCSI_LOG_TIMEOUT(depth,				\
+					 sdev_prefix_printk(KERN_INFO,	\
+					 (sdp)->device, _b, fmt, ##a));	\
+		} else							\
+			pr_info("sg: sdp=NULL_or_ERR, " fmt, ##a);	\
+	} while (0)
+#else
+#define SG_LOG(depth, sdp, fmt, a...)
+#endif	/* end of CONFIG_SCSI_LOGGING conditional */
+
+
 #define sg_printk(prefix, sdp, fmt, a...) \
 	sdev_prefix_printk(prefix, (sdp)->device,		\
 			   (sdp)->disk->disk_name, fmt, ##a)
@@ -286,8 +306,9 @@ sg_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(sdp))
 		return PTR_ERR(sdp);
 
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_open: flags=0x%x\n", op_flags));
+	SG_LOG(3, sdp, "%s: minor=%d, op_flags=0x%x; %s count prior=%d%s\n",
+	       __func__, min_dev, op_flags, "device open", sdp->open_cnt,
+	       ((op_flags & O_NONBLOCK) ? " O_NONBLOCK" : ""));
 
 	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
@@ -376,9 +397,10 @@ sg_release(struct inode *inode, struct file *filp)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
+	SG_LOG(3, sdp, "%s: device open count prior=%d\n", __func__,
+	       sdp->open_cnt);
 	if (!sdp)
 		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp, "sg_release\n"));
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
@@ -423,10 +445,9 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
+	SG_LOG(3, sdp, "%s: write(3rd arg) count=%d\n", __func__, (int)count);
 	if (!sdp)
 		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_write: count=%d\n", (int) count));
 	if (atomic_read(&sdp->detaching))
 		return -ENODEV;
 	if (!((filp->f_flags & O_NONBLOCK) ||
@@ -447,8 +468,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 		return -EIO;	/* The minimum scsi command length is 6 bytes. */
 
 	if (!(srp = sg_add_request(sfp))) {
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sdp,
-					      "sg_write: queue full\n"));
+		SG_LOG(1, sdp, "%s: queue full\n", __func__);
 		return -EDOM;
 	}
 	buf += SZ_SG_HEADER;
@@ -463,11 +483,10 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 			cmd_size = 12;
 	}
 	mutex_unlock(&sfp->f_mutex);
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sdp,
-		"sg_write:   scsi opcode=0x%02x, cmd_size=%d\n", (int) opcode, cmd_size));
-/* Determine buffer size.  */
+	SG_LOG(4, sdp, "%s:   scsi opcode=0x%02x, cmd_size=%d\n", __func__,
+	       (unsigned int)opcode, cmd_size);
 	input_size = count - cmd_size;
-	mxsize = (input_size > old_hdr.reply_len) ? input_size : old_hdr.reply_len;
+	mxsize = max_t(int, input_size, old_hdr.reply_len);
 	mxsize -= SZ_SG_HEADER;
 	input_size -= SZ_SG_HEADER;
 	if (input_size < 0) {
@@ -546,8 +565,7 @@ sg_new_write(struct sg_fd *sfp, struct file *file, const char __user *buf,
 
 	sfp->cmd_q = 1;	/* when sg_io_hdr seen, set command queuing on */
 	if (!(srp = sg_add_request(sfp))) {
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
-					      "sg_new_write: queue full\n"));
+		SG_LOG(1, sfp->parentdp, "%s: queue full\n", __func__);
 		return -EDOM;
 	}
 	srp->sg_io_owned = sg_io_owned;
@@ -616,17 +634,16 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 	hp->host_status = 0;
 	hp->driver_status = 0;
 	hp->resid = 0;
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
-			(int) cmnd[0], (int) hp->cmd_len));
+	SG_LOG(4, sfp->parentdp, "%s:  opcode=0x%02x, cmd_sz=%d\n", __func__,
+	       (int)cmnd[0], hp->cmd_len);
 
 	if (hp->dxfer_len >= SZ_256M)
 		return -EINVAL;
 
 	k = sg_start_req(srp, cmnd);
 	if (k) {
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
-			"sg_common_write: start_req err=%d\n", k));
+		SG_LOG(1, sfp->parentdp, "%s: start_req err=%d\n", __func__,
+		       k);
 		sg_finish_rem_req(srp);
 		sg_remove_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
@@ -759,9 +776,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "%s: count=%d\n", __func__,
-				      (int) count));
+	SG_LOG(3, sdp, "%s: read() count=%d\n", __func__, (int)count);
 	if (!sdp)
 		return -ENXIO;
 
@@ -885,7 +900,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 		if (count > old_hdr->reply_len)
 			count = old_hdr->reply_len;
 		if (count > SZ_SG_HEADER) {
-			if (sg_read_oxfer(srp, buf, count - SZ_SG_HEADER)) {
+			if (sg_rd_append(srp, buf, count - SZ_SG_HEADER)) {
 				retval = -EFAULT;
 				goto free_old_hdr;
 			}
@@ -958,8 +973,8 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	sdp = sfp->parentdp;
 	if (!sdp)
 		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
+	SG_LOG(6, sdp, "%s: cmd=0x%x, O_NONBLOCK=%d\n", __func__, cmd_in,
+	       !!(filp->f_flags & O_NONBLOCK));
 	read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
 
 	switch (cmd_in) {
@@ -1191,7 +1206,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	return scsi_ioctl(sdp->device, cmd_in, p);
 }
 
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT)
 static long
 sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 {
@@ -1220,7 +1235,7 @@ sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 static __poll_t
 sg_poll(struct file *filp, poll_table * wait)
 {
-	__poll_t res = 0;
+	__poll_t p_res = 0;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
 	struct sg_request *srp;
@@ -1237,22 +1252,21 @@ sg_poll(struct file *filp, poll_table * wait)
 	read_lock_irqsave(&sfp->rq_list_lock, iflags);
 	list_for_each_entry(srp, &sfp->rq_list, entry) {
 		/* if any read waiting, flag it */
-		if ((0 == res) && (1 == srp->done) && (!srp->sg_io_owned))
-			res = EPOLLIN | EPOLLRDNORM;
+		if ((p_res == 0) && (srp->done == 1) && (!srp->sg_io_owned))
+			p_res = EPOLLIN | EPOLLRDNORM;
 		++count;
 	}
 	read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (atomic_read(&sdp->detaching))
-		res |= EPOLLHUP;
+		p_res |= EPOLLHUP;
 	else if (!sfp->cmd_q) {
 		if (0 == count)
-			res |= EPOLLOUT | EPOLLWRNORM;
+			p_res |= EPOLLOUT | EPOLLWRNORM;
 	} else if (count < SG_MAX_QUEUE)
-		res |= EPOLLOUT | EPOLLWRNORM;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_poll: res=0x%x\n", (__force u32) res));
-	return res;
+		p_res |= EPOLLOUT | EPOLLWRNORM;
+	SG_LOG(3, sdp, "%s: p_res=0x%x\n", __func__, (__force u32)p_res);
+	return p_res;
 }
 
 static int
@@ -1263,11 +1277,9 @@ sg_fasync(int fd, struct file *filp, int mode)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
+	SG_LOG(3, sdp, "%s: mode(%s)\n", __func__, (mode ? "add" : "remove"));
 	if (!sdp)
 		return -ENXIO;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_fasync: mode=%d\n", mode));
-
 	return fasync_helper(fd, filp, mode, &sfp->async_qp);
 }
 
@@ -1275,6 +1287,7 @@ static vm_fault_t
 sg_vma_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct sg_device *sdp;
 	struct sg_fd *sfp;
 	unsigned long offset, len, sa;
 	struct sg_scatter_hold *rsv_schp;
@@ -1290,14 +1303,13 @@ sg_vma_fault(struct vm_fault *vmf)
 		pr_warn("%s: sfp%s\n", __func__, nbp);
 		goto out_err;
 	}
+	sdp = sfp->parentdp;
 	rsv_schp = &sfp->reserve;
 	offset = vmf->pgoff << PAGE_SHIFT;
 	if (offset >= rsv_schp->bufflen)
 		return VM_FAULT_SIGBUS;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_vma_fault: offset=%lu, scatg=%d\n",
-				      offset, rsv_schp->k_use_sg));
 	sa = vma->vm_start;
+	SG_LOG(3, sdp, "%s: vm_start=0x%lx, off=%lu\n", __func__, sa, offset);
 	length = 1 << (PAGE_SHIFT + rsv_schp->page_order);
 	for (k = 0; k < rsv_schp->k_use_sg && sa < vma->vm_end; k++) {
 		len = vma->vm_end - sa;
@@ -1337,9 +1349,8 @@ sg_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -ENXIO;
 	}
 	req_sz = vma->vm_end - vma->vm_start;
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_mmap starting, vm_start=%p, len=%d\n",
-				      (void *) vma->vm_start, (int) req_sz));
+	SG_LOG(3, sfp->parentdp, "%s: vm_start=%p, len=%d\n", __func__,
+	       (void *)vma->vm_start, (int)req_sz);
 	if (vma->vm_pgoff)
 		return -EINVAL;	/* want no offset */
 	rsv_schp = &sfp->reserve;
@@ -1408,10 +1419,9 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	result = req->result;
 	resid = req->resid_len;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sdp,
-				      "sg_cmd_done: pack_id=%d, res=0x%x\n",
-				      srp->header.pack_id, result));
 	srp->header.resid = resid;
+	SG_LOG(6, sdp, "%s: pack_id=%d, res=0x%x\n", __func__,
+	       srp->header.pack_id, result);
 	ms = jiffies_to_msecs(jiffies);
 	srp->header.duration = (ms > srp->header.duration) ?
 				(ms - srp->header.duration) : 0;
@@ -1485,7 +1495,7 @@ static const struct file_operations sg_fops = {
 	.write = sg_write,
 	.poll = sg_poll,
 	.unlocked_ioctl = sg_ioctl,
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT)
 	.compat_ioctl = sg_compat_ioctl,
 #endif
 	.open = sg_open,
@@ -1532,7 +1542,7 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	k = error;
 
 	SCSI_LOG_TIMEOUT(3, sdev_printk(KERN_INFO, scsidp,
-					"sg_alloc: dev=%d \n", k));
+			 "%s: dev=%d, sdp=0x%p ++\n", __func__, k, sdp));
 	sprintf(disk->disk_name, "sg%d", k);
 	disk->first_minor = k;
 	sdp->disk = disk;
@@ -1651,8 +1661,7 @@ sg_device_destroy(struct kref *kref)
 	idr_remove(&sg_index_idr, sdp->index);
 	write_unlock_irqrestore(&sg_index_lock, flags);
 
-	SCSI_LOG_TIMEOUT(3,
-		sg_printk(KERN_INFO, sdp, "sg_device_destroy\n"));
+	SG_LOG(3, sdp, "%s: sdp=0x%p --\n", __func__, sdp);
 
 	put_disk(sdp->disk);
 	kfree(sdp);
@@ -1674,8 +1683,7 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 	if (val > 1)
 		return; /* only want to do following once per device */
 
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "%s\n", __func__));
+	SG_LOG(3, sdp, "%s: 0x%p\n", __func__, sdp);
 
 	read_lock_irqsave(&sdp->sfd_lock, iflags);
 	list_for_each_entry(sfp, &sdp->sfds, sfd_siblings) {
@@ -1744,7 +1752,7 @@ init_sg(void)
 	return rc;
 }
 
-#ifndef CONFIG_SCSI_PROC_FS
+#if !IS_ENABLED(CONFIG_SCSI_PROC_FS)
 static int
 sg_proc_init(void)
 {
@@ -1755,9 +1763,8 @@ sg_proc_init(void)
 static void __exit
 exit_sg(void)
 {
-#ifdef CONFIG_SCSI_PROC_FS
-	remove_proc_subtree("scsi/sg", NULL);
-#endif				/* CONFIG_SCSI_PROC_FS */
+	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
+		remove_proc_subtree("scsi/sg", NULL);
 	scsi_unregister_interface(&sg_interface);
 	class_destroy(sg_sysfs_class);
 	sg_sysfs_valid = 0;
@@ -1772,6 +1779,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 	int res;
 	struct request *rq;
 	struct scsi_request *req;
+	struct sg_device *sdp;
 	struct sg_fd *sfp = srp->parentfp;
 	sg_io_hdr_t *hp = &srp->header;
 	int dxfer_len = (int) hp->dxfer_len;
@@ -1781,18 +1789,18 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 	struct sg_scatter_hold *rsv_schp = &sfp->reserve;
 	struct request_queue *q = sfp->parentdp->device->request_queue;
 	struct rq_map_data *md, map_data;
-	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
+	int r0w = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
 	u8 *long_cmdp = NULL;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_start_req: dxfer_len=%d\n",
-				      dxfer_len));
-
+	sdp = sfp->parentdp;
 	if (hp->cmd_len > BLK_MAX_CDB) {
 		long_cmdp = kzalloc(hp->cmd_len, GFP_KERNEL);
 		if (!long_cmdp)
 			return -ENOMEM;
+		SG_LOG(5, sdp, "%s: long_cmdp=0x%p ++\n", __func__, long_cmdp);
 	}
+	SG_LOG(4, sdp, "%s: dxfer_len=%d, data-%s\n", __func__, dxfer_len,
+	       (r0w ? "OUT" : "IN"));
 
 	/*
 	 * NOTE
@@ -1869,7 +1877,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 		struct iovec *iov = NULL;
 		struct iov_iter i;
 
-		res = import_iovec(rw, hp->dxferp, iov_count, 0, &iov, &i);
+		res = import_iovec(r0w, hp->dxferp, iov_count, 0, &iov, &i);
 		if (res < 0)
 			return res;
 
@@ -1904,9 +1912,8 @@ sg_finish_rem_req(struct sg_request *srp)
 	struct sg_fd *sfp = srp->parentfp;
 	struct sg_scatter_hold *req_schp = &srp->data;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-				      "sg_finish_rem_req: res_used=%d\n",
-				      (int) srp->res_used));
+	SG_LOG(4, sfp->parentdp, "%s: srp=0x%p%s\n", __func__, srp,
+	       (srp->res_used) ? " rsv" : "");
 	if (srp->bio)
 		ret = blk_rq_unmap_user(srp->bio);
 
@@ -1953,9 +1960,8 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 		++blk_size;	/* don't know why */
 	/* round request up to next highest SG_SECTOR_SZ byte boundary */
 	blk_size = ALIGN(blk_size, SG_SECTOR_SZ);
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-		"sg_build_indirect: buff_size=%d, blk_size=%d\n",
-		buff_size, blk_size));
+	SG_LOG(4, sfp->parentdp, "%s: buff_size=%d, blk_size=%d\n",
+	       __func__, buff_size, blk_size);
 
 	/* N.B. ret_sz carried into this block ... */
 	mx_sc_elems = sg_build_sgat(schp, sfp, sg_tablesize);
@@ -1994,18 +2000,14 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 				scatter_elem_sz_prev = ret_sz;
 			}
 		}
-
-		SCSI_LOG_TIMEOUT(5, sg_printk(KERN_INFO, sfp->parentdp,
-				 "sg_build_indirect: k=%d, num=%d, ret_sz=%d\n",
-				 k, num, ret_sz));
+		SG_LOG(5, sfp->parentdp, "%s: k=%d, num=%d, ret_sz=%d\n",
+		       __func__, k, num, ret_sz);
 	}		/* end of for loop */
 
 	schp->page_order = order;
 	schp->k_use_sg = k;
-	SCSI_LOG_TIMEOUT(5, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_build_indirect: k_use_sg=%d, rem_sz=%d\n",
-			 k, rem_sz));
-
+	SG_LOG(5, sfp->parentdp, "%s: k_use_sg=%d, order=%d\n", __func__,
+	       k, order);
 	schp->bufflen = blk_size;
 	if (rem_sz > 0)	/* must have failed */
 		return -ENOMEM;
@@ -2023,51 +2025,53 @@ sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 static void
 sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp)
 {
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_remove_scat: k_use_sg=%d\n", schp->k_use_sg));
+	SG_LOG(4, sfp->parentdp, "%s: num_sgat=%d\n", __func__,
+	       schp->k_use_sg);
 	if (schp->pages && schp->sglist_len > 0) {
 		if (!schp->dio_in_use) {
 			int k;
 
 			for (k = 0; k < schp->k_use_sg && schp->pages[k]; k++) {
-				SCSI_LOG_TIMEOUT(5,
-					sg_printk(KERN_INFO, sfp->parentdp,
-					"sg_remove_scat: k=%d, pg=0x%p\n",
-					k, schp->pages[k]));
+				SG_LOG(5, sfp->parentdp,
+				       "%s: pg[%d]=0x%p --\n", __func__, k,
+				       schp->pages[k]);
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
-sg_read_oxfer(struct sg_request *srp, char __user *outp, int num_read_xfer)
+sg_rd_append(struct sg_request *srp, char __user *outp, int num_xfer)
 {
 	struct sg_scatter_hold *schp = &srp->data;
 	int k, num;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, srp->parentfp->parentdp,
-			 "sg_read_oxfer: num_read_xfer=%d\n",
-			 num_read_xfer));
-	if ((!outp) || (num_read_xfer <= 0))
+	SG_LOG(4, srp->parentfp->parentdp, "%s: num_xfer=%d\n", __func__,
+	       num_xfer);
+	if ((!outp) || (num_xfer <= 0))
 		return 0;
 
 	num = 1 << (PAGE_SHIFT + schp->page_order);
 	for (k = 0; k < schp->k_use_sg && schp->pages[k]; k++) {
-		if (num > num_read_xfer) {
+		if (num > num_xfer) {
 			if (__copy_to_user(outp, page_address(schp->pages[k]),
-					   num_read_xfer))
+					   num_xfer))
 				return -EFAULT;
 			break;
 		} else {
 			if (__copy_to_user(outp, page_address(schp->pages[k]),
 					   num))
 				return -EFAULT;
-			num_read_xfer -= num;
-			if (num_read_xfer <= 0)
+			num_xfer -= num;
+			if (num_xfer <= 0)
 				break;
 			outp += num;
 		}
@@ -2081,8 +2085,8 @@ sg_build_reserve(struct sg_fd *sfp, int req_size)
 {
 	struct sg_scatter_hold *schp = &sfp->reserve;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_build_reserve: req_size=%d\n", req_size));
+	SG_LOG(3, sfp ? sfp->parentdp : NULL, "%s: buflen=%d\n", __func__,
+	       req_size);
 	do {
 		if (req_size < PAGE_SIZE)
 			req_size = PAGE_SIZE;
@@ -2102,8 +2106,7 @@ sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp, int size)
 	int k, num, rem;
 
 	srp->res_used = 1;
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
-			 "sg_link_reserve: size=%d\n", size));
+	SG_LOG(4, sfp->parentdp, "%s: size=%d\n", __func__, size);
 	rem = size;
 
 	num = 1 << (PAGE_SHIFT + rsv_schp->page_order);
@@ -2121,8 +2124,7 @@ sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp, int size)
 	}
 
 	if (k >= rsv_schp->k_use_sg)
-		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
-				 "sg_link_reserve: BAD size\n"));
+		SG_LOG(1, sfp->parentdp, "%s: BAD size\n", __func__);
 }
 
 static void
@@ -2130,9 +2132,8 @@ sg_unlink_reserve(struct sg_fd *sfp, struct sg_request *srp)
 {
 	struct sg_scatter_hold *req_schp = &srp->data;
 
-	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, srp->parentfp->parentdp,
-				      "sg_unlink_reserve: req->k_use_sg=%d\n",
-				      (int) req_schp->k_use_sg));
+	SG_LOG(4, srp->parentfp->parentdp, "%s: req->k_use_sg=%d\n", __func__,
+	       (int)req_schp->k_use_sg);
 	req_schp->k_use_sg = 0;
 	req_schp->bufflen = 0;
 	req_schp->pages = NULL;
@@ -2223,18 +2224,15 @@ sg_add_sfp(struct sg_device *sdp)
 	}
 	list_add_tail(&sfp->sfd_siblings, &sdp->sfds);
 	write_unlock_irqrestore(&sdp->sfd_lock, iflags);
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_add_sfp: sfp=0x%p\n", sfp));
+	SG_LOG(3, sdp, "%s: sfp=0x%p\n", __func__, sfp);
 	if (unlikely(sg_big_buff != def_reserved_size))
 		sg_big_buff = def_reserved_size;
 
 	bufflen = min_t(int, sg_big_buff,
 			max_sectors_bytes(sdp->device->request_queue));
 	sg_build_reserve(sfp, bufflen);
-	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
-				      "sg_add_sfp: bufflen=%d, k_use_sg=%d\n",
-				      sfp->reserve.bufflen,
-				      sfp->reserve.k_use_sg));
+	SG_LOG(3, sdp, "%s: bufflen=%d, k_use_sg=%d\n", __func__,
+	       sfp->reserve.bufflen, sfp->reserve.k_use_sg);
 
 	kref_get(&sdp->d_ref);
 	__module_get(THIS_MODULE);
@@ -2260,15 +2258,12 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (sfp->reserve.bufflen > 0) {
-		SCSI_LOG_TIMEOUT(6, sg_printk(KERN_INFO, sdp,
-				"sg_remove_sfp:    bufflen=%d, k_use_sg=%d\n",
-				(int) sfp->reserve.bufflen,
-				(int) sfp->reserve.k_use_sg));
+		SG_LOG(6, sdp, "%s:    bufflen=%d, k_use_sg=%d\n", __func__,
+		       (int)sfp->reserve.bufflen, (int)sfp->reserve.k_use_sg);
 		sg_remove_scat(sfp, &sfp->reserve);
 	}
 
-	SCSI_LOG_TIMEOUT(6, sg_printk(KERN_INFO, sdp,
-			"sg_remove_sfp: sfp=0x%p\n", sfp));
+	SG_LOG(6, sdp, "%s: sfp=0x%p\n", __func__, sfp);
 	kfree(sfp);
 
 	scsi_device_put(sdp->device);
@@ -2291,7 +2286,6 @@ sg_remove_sfp(struct kref *kref)
 	schedule_work(&sfp->ew.work);
 }
 
-#ifdef CONFIG_SCSI_PROC_FS
 static int
 sg_idr_max_id(int id, void *p, void *data)
 {
@@ -2303,19 +2297,6 @@ sg_idr_max_id(int id, void *p, void *data)
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
@@ -2345,7 +2326,7 @@ sg_get_dev(int dev)
 	return sdp;
 }
 
-#ifdef CONFIG_SCSI_PROC_FS
+#if IS_ENABLED(CONFIG_SCSI_PROC_FS)     /* long, almost to end of file */
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
 static int sg_proc_single_open_adio(struct inode *inode, struct file *file);
@@ -2420,6 +2401,17 @@ sg_proc_init(void)
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
@@ -2678,7 +2670,7 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	return 0;
 }
 
-#endif				/* CONFIG_SCSI_PROC_FS */
+#endif				/* CONFIG_SCSI_PROC_FS (~800 lines back) */
 
 module_init(init_sg);
 module_exit(exit_sg);
-- 
2.17.1

