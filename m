Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA83579B3
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 03:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhDHBqS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Apr 2021 21:46:18 -0400
Received: from smtp.infotech.no ([82.134.31.41]:45149 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhDHBqO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 7 Apr 2021 21:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 194D4204279;
        Thu,  8 Apr 2021 03:46:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4hmp-l3IJGPx; Thu,  8 Apr 2021 03:45:59 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id D992920425B;
        Thu,  8 Apr 2021 03:45:54 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v17 17/45] sg: replace sg_allow_access
Date:   Wed,  7 Apr 2021 21:45:03 -0400
Message-Id: <20210408014531.248890-18-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408014531.248890-1-dgilbert@interlog.com>
References: <20210408014531.248890-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace the sg_allow_access() function with sg_fetch_cmnd()
which does a little more. Change sg_finish_scsi_blk_rq() from an
int to a void returning function. Rename sg_remove_request()
to sg_deact_request(). Other changes, mainly cosmetic.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 150 +++++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 68 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c3c458bf36da..610cd69e5201 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -186,7 +186,7 @@ static void sg_rq_end_io(struct request *rq, blk_status_t status);
 /* Declarations of other static functions used before they are defined */
 static int sg_proc_init(void);
 static int sg_start_req(struct sg_request *srp, u8 *cmd);
-static int sg_finish_scsi_blk_rq(struct sg_request *srp);
+static void sg_finish_scsi_blk_rq(struct sg_request *srp);
 static int sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
 			     int buff_size);
 static ssize_t sg_submit(struct sg_fd *sfp, struct file *filp,
@@ -204,7 +204,7 @@ static void sg_unlink_reserve(struct sg_fd *sfp, struct sg_request *srp);
 static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
 static void sg_remove_sfp(struct kref *);
 static struct sg_request *sg_setup_req(struct sg_fd *sfp);
-static int sg_remove_request(struct sg_fd *sfp, struct sg_request *srp);
+static int sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
 static struct sg_device *sg_get_dev(int dev);
 static void sg_device_destroy(struct kref *kref);
 
@@ -539,7 +539,7 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	mutex_lock(&sfp->f_mutex);
 	if (sfp->next_cmd_len > 0) {
 		cmd_size = sfp->next_cmd_len;
-		sfp->next_cmd_len = 0;	/* reset so only this write() effected */
+		sfp->next_cmd_len = 0;	/* reset, only this write() effected */
 	} else {
 		cmd_size = COMMAND_SIZE(opcode);  /* old: SCSI command group */
 		if (opcode >= 0xc0 && ohp->twelve_byte)
@@ -553,7 +553,7 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	mxsize -= SZ_SG_HEADER;
 	input_size -= SZ_SG_HEADER;
 	if (input_size < 0) {
-		sg_remove_request(sfp, srp);
+		sg_deact_request(sfp, srp);
 		return -EIO;	/* User did not pass enough bytes for this command. */
 	}
 	h3p = &srp->header;
@@ -570,7 +570,7 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	h3p->dxfer_len = mxsize;
 	if (h3p->dxfer_direction == SG_DXFER_TO_DEV ||
 	    h3p->dxfer_direction == SG_DXFER_TO_FROM_DEV)
-		h3p->dxferp = (char __user *)p + cmd_size;
+		h3p->dxferp = (u8 __user *)p + cmd_size;
 	else
 		h3p->dxferp = NULL;
 	h3p->sbp = NULL;
@@ -579,7 +579,7 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	h3p->pack_id = ohp->pack_id;
 	h3p->usr_ptr = NULL;
 	if (copy_from_user(cmnd, p, cmd_size)) {
-		sg_remove_request(sfp, srp);
+		sg_deact_request(sfp, srp);
 		return -EFAULT;
 	}
 	/*
@@ -606,14 +606,24 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 }
 
 static int
-sg_allow_access(struct file *filp, u8 *cmd)
+sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
+	      int len, u8 *cdbp)
 {
-	struct sg_fd *sfp = filp->private_data;
-
-	if (sfp->parentdp->device->type == TYPE_SCANNER)
-		return 0;
-
-	return blk_verify_command(cmd, filp->f_mode);
+	if (!u_cdbp || len < 6 || len > SG_MAX_CDB_SIZE)
+		return -EMSGSIZE;
+	if (copy_from_user(cdbp, u_cdbp, len))
+		return -EFAULT;
+	if (O_RDWR != (filp->f_flags & O_ACCMODE)) {	/* read-only */
+		switch (sfp->parentdp->device->type) {
+		case TYPE_DISK:
+		case TYPE_RBC:
+		case TYPE_ZBC:
+			return blk_verify_command(cdbp, filp->f_mode);
+		default:	/* SSC, SES, etc cbd_s may differ from SBC */
+			break;
+		}
+	}
+	return 0;
 }
 
 static ssize_t
@@ -621,12 +631,11 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 	  size_t count, bool blocking, bool read_only, bool sg_io_owned,
 	  struct sg_request **o_srp)
 {
-	int k;
+	int k, res, timeout;
 	struct sg_request *srp;
 	struct sg_io_hdr *hp;
 	struct sg_comm_wr_t cwr;
 	u8 cmnd[SG_MAX_CDB_SIZE];
-	int timeout;
 	unsigned long ul_timeout;
 
 	if (count < SZ_SG_IO_HDR)
@@ -639,41 +648,35 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 	}
 	srp->sg_io_owned = sg_io_owned;
 	hp = &srp->header;
+	/* get_sg_io_hdr() is defined in block/scsi_ioctl.c */
 	if (get_sg_io_hdr(hp, buf)) {
-		sg_remove_request(sfp, srp);
+		sg_deact_request(sfp, srp);
 		return -EFAULT;
 	}
 	if (hp->interface_id != 'S') {
-		sg_remove_request(sfp, srp);
+		sg_deact_request(sfp, srp);
 		return -ENOSYS;
 	}
 	if (hp->flags & SG_FLAG_MMAP_IO) {
 		if (hp->dxfer_len > sfp->reserve.buflen) {
-			sg_remove_request(sfp, srp);
+			sg_deact_request(sfp, srp);
 			return -ENOMEM;	/* MMAP_IO size must fit in reserve buffer */
 		}
 		if (hp->flags & SG_FLAG_DIRECT_IO) {
-			sg_remove_request(sfp, srp);
+			sg_deact_request(sfp, srp);
 			return -EINVAL;	/* either MMAP_IO or DIRECT_IO (not both) */
 		}
 		if (sfp->res_in_use) {
-			sg_remove_request(sfp, srp);
+			sg_deact_request(sfp, srp);
 			return -EBUSY;	/* reserve buffer already being used */
 		}
 	}
 	ul_timeout = msecs_to_jiffies(srp->header.timeout);
 	timeout = (ul_timeout < INT_MAX) ? ul_timeout : INT_MAX;
-	if ((!hp->cmdp) || (hp->cmd_len < 6) || (hp->cmd_len > sizeof (cmnd))) {
-		sg_remove_request(sfp, srp);
-		return -EMSGSIZE;
-	}
-	if (copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
-		sg_remove_request(sfp, srp);
-		return -EFAULT;
-	}
-	if (read_only && sg_allow_access(filp, cmnd)) {
-		sg_remove_request(sfp, srp);
-		return -EPERM;
+	res = sg_fetch_cmnd(filp, sfp, hp->cmdp, hp->cmd_len, cmnd);
+	if (res) {
+		sg_deact_request(sfp, srp);
+		return res;
 	}
 	cwr.timeout = timeout;
 	cwr.blocking = blocking;
@@ -708,7 +711,7 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	       (int)cwrp->cmnd[0], hp->cmd_len);
 
 	if (hp->dxfer_len >= SZ_256M) {
-		sg_remove_request(sfp, srp);
+		sg_deact_request(sfp, srp);
 		return -EINVAL;
 	}
 
@@ -716,7 +719,7 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	if (k) {
 		SG_LOG(1, sfp, "%s: start_req err=%d\n", __func__, k);
 		sg_finish_scsi_blk_rq(srp);
-		sg_remove_request(sfp, srp);
+		sg_deact_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
 	}
 	if (SG_IS_DETACHING(sdp)) {
@@ -727,7 +730,7 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 		}
 
 		sg_finish_scsi_blk_rq(srp);
-		sg_remove_request(sfp, srp);
+		sg_deact_request(sfp, srp);
 		return -ENODEV;
 	}
 
@@ -772,12 +775,24 @@ sg_get_rq_mark(struct sg_fd *sfp, int pack_id)
 	return NULL;
 }
 
+static int
+srp_done(struct sg_fd *sfp, struct sg_request *srp)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&sfp->rq_list_lock, flags);
+	ret = srp->done;
+	spin_unlock_irqrestore(&sfp->rq_list_lock, flags);
+	return ret;
+}
+
 static ssize_t
 sg_receive_v3(struct sg_fd *sfp, char __user *buf, size_t count,
 	      struct sg_request *srp)
 {
 	struct sg_io_hdr *hp = &srp->header;
-	int err = 0, err2;
+	int err = 0;
 	int len;
 
 	if (in_compat_syscall()) {
@@ -811,21 +826,9 @@ sg_receive_v3(struct sg_fd *sfp, char __user *buf, size_t count,
 		hp->info |= SG_INFO_CHECK;
 	err = put_sg_io_hdr(hp, buf);
 err_out:
-	err2 = sg_finish_scsi_blk_rq(srp);
-	sg_remove_request(sfp, srp);
-	return err ? : err2 ? : count;
-}
-
-static int
-srp_done(struct sg_fd *sfp, struct sg_request *srp)
-{
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&sfp->rq_list_lock, flags);
-	ret = srp->done;
-	spin_unlock_irqrestore(&sfp->rq_list_lock, flags);
-	return ret;
+	sg_finish_scsi_blk_rq(srp);
+	sg_deact_request(sfp, srp);
+	return err;
 }
 
 static int
@@ -898,7 +901,7 @@ sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 		res = (h2p->result == 0) ? 0 : -EIO;
 	}
 	sg_finish_scsi_blk_rq(srp);
-	sg_remove_request(sfp, srp);
+	sg_deact_request(sfp, srp);
 	return res;
 }
 
@@ -1546,7 +1549,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 	struct sg_fd *sfp = srp->parentfp;
 
 	sg_finish_scsi_blk_rq(srp);
-	sg_remove_request(sfp, srp);
+	sg_deact_request(sfp, srp);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
 
@@ -1671,7 +1674,7 @@ static const struct file_operations sg_fops = {
 
 static struct class *sg_sysfs_class;
 
-static int sg_sysfs_valid = 0;
+static bool sg_sysfs_valid;
 
 static struct sg_device *
 sg_add_device_helper(struct gendisk *disk, struct scsi_device *scsidp)
@@ -1904,7 +1907,7 @@ init_sg(void)
 		rc = PTR_ERR(sg_sysfs_class);
 		goto err_out;
         }
-	sg_sysfs_valid = 1;
+	sg_sysfs_valid = true;
 	rc = scsi_register_interface(&sg_interface);
 	if (0 == rc) {
 		sg_proc_init();
@@ -1931,7 +1934,7 @@ exit_sg(void)
 		remove_proc_subtree("scsi/sg", NULL);
 	scsi_unregister_interface(&sg_interface);
 	class_destroy(sg_sysfs_class);
-	sg_sysfs_valid = 0;
+	sg_sysfs_valid = false;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				 SG_MAX_DEVS);
 	idr_destroy(&sg_index_idr);
@@ -2066,10 +2069,10 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 	return res;
 }
 
-static int
+static void
 sg_finish_scsi_blk_rq(struct sg_request *srp)
 {
-	int ret = 0;
+	int ret;
 
 	struct sg_fd *sfp = srp->parentfp;
 	struct sg_scatter_hold *req_schp = &srp->data;
@@ -2080,8 +2083,13 @@ sg_finish_scsi_blk_rq(struct sg_request *srp)
 		atomic_dec(&sfp->submitted);
 		atomic_dec(&sfp->waiting);
 	}
-	if (srp->bio)
+	if (srp->bio) {
 		ret = blk_rq_unmap_user(srp->bio);
+		if (ret)	/* -EINTR (-4) can be ignored */
+			SG_LOG(6, sfp, "%s: blk_rq_unmap_user() --> %d\n",
+			       __func__, ret);
+		srp->bio = NULL;
+	}
 
 	if (srp->rq) {
 		scsi_req_free_cmd(scsi_req(srp->rq));
@@ -2092,8 +2100,6 @@ sg_finish_scsi_blk_rq(struct sg_request *srp)
 		sg_unlink_reserve(sfp, srp);
 	else
 		sg_remove_scat(sfp, req_schp);
-
-	return ret;
 }
 
 static int
@@ -2337,7 +2343,7 @@ sg_setup_req(struct sg_fd *sfp)
 
 /* Return of 1 for found; 0 for not found */
 static int
-sg_remove_request(struct sg_fd *sfp, struct sg_request *srp)
+sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 {
 	unsigned long iflags;
 	int res = 0;
@@ -2357,9 +2363,9 @@ sg_remove_request(struct sg_fd *sfp, struct sg_request *srp)
 static struct sg_fd *
 sg_add_sfp(struct sg_device *sdp)
 {
-	struct sg_fd *sfp;
 	unsigned long iflags;
 	int bufflen;
+	struct sg_fd *sfp;
 
 	sfp = kzalloc(sizeof(*sfp), GFP_ATOMIC | __GFP_NOWARN);
 	if (!sfp)
@@ -2405,10 +2411,16 @@ sg_add_sfp(struct sg_device *sdp)
 static void
 sg_remove_sfp_usercontext(struct work_struct *work)
 {
+	unsigned long iflags;
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew_fd.work);
-	struct sg_device *sdp = sfp->parentdp;
+	struct sg_device *sdp;
 	struct sg_request *srp;
-	unsigned long iflags;
+
+	if (!sfp) {
+		pr_warn("sg: %s: sfp is NULL\n", __func__);
+		return;
+	}
+	sdp = sfp->parentdp;
 
 	/* Cleanup any responses which were never read(). */
 	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
@@ -2429,17 +2441,19 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 	SG_LOG(6, sfp, "%s: sfp=0x%p\n", __func__, sfp);
 	kfree(sfp);
 
-	scsi_device_put(sdp->device);
-	kref_put(&sdp->d_ref, sg_device_destroy);
+	if (sdp) {
+		scsi_device_put(sdp->device);
+		kref_put(&sdp->d_ref, sg_device_destroy);
+	}
 	module_put(THIS_MODULE);
 }
 
 static void
 sg_remove_sfp(struct kref *kref)
 {
+	unsigned long iflags;
 	struct sg_fd *sfp = container_of(kref, struct sg_fd, f_ref);
 	struct sg_device *sdp = sfp->parentdp;
-	unsigned long iflags;
 
 	write_lock_irqsave(&sdp->sfd_lock, iflags);
 	list_del(&sfp->sfd_entry);
@@ -2652,7 +2666,7 @@ struct sg_proc_deviter {
 static void *
 dev_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct sg_proc_deviter * it = kmalloc(sizeof(*it), GFP_KERNEL);
+	struct sg_proc_deviter *it = kzalloc(sizeof(*it), GFP_KERNEL);
 
 	s->private = it;
 	if (! it)
-- 
2.25.1

