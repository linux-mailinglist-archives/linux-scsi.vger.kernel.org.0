Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA7302024
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbhAYCBJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Jan 2021 21:01:09 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45885 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbhAYB6x (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 24 Jan 2021 20:58:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 814AB2042A7;
        Mon, 25 Jan 2021 02:27:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4+ODJJlItz8S; Mon, 25 Jan 2021 02:27:17 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 997A220425A;
        Mon, 25 Jan 2021 02:27:08 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com
Subject: [PATCH v14 12/45] sg: ioctl handling
Date:   Sun, 24 Jan 2021 20:26:17 -0500
Message-Id: <20210125012650.269411-13-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125012650.269411-1-dgilbert@interlog.com>
References: <20210125012650.269411-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Shorten sg_ioctl() by adding some helper functions. sg_ioctl()
is the main entry point for ioctls used on this driver's
devices.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 328 ++++++++++++++++++++++++++++------------------
 1 file changed, 199 insertions(+), 129 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 01e6961a9c0e..abe8a5cc4ce4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1019,6 +1019,56 @@ sg_fill_request_table(struct sg_fd *sfp, struct sg_req_info *rinfo)
 	}
 }
 
+/*
+ * Handles ioctl(SG_IO) for blocking (sync) usage of v3 or v4 interface.
+ * Returns 0 on success else a negated errno.
+ */
+static int
+sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
+	     void __user *p)
+{
+	bool read_only = O_RDWR != (filp->f_flags & O_ACCMODE);
+	int res;
+	struct sg_request *srp;
+
+	res = sg_allow_if_err_recovery(sdp, false);
+	if (res)
+		return res;
+	res = sg_submit(sfp, filp, p, SZ_SG_IO_HDR, true, read_only,
+			true, &srp);
+	if (res < 0)
+		return res;
+	res = wait_event_interruptible
+		(sfp->read_wait, (srp_done(sfp, srp) || SG_IS_DETACHING(sdp)));
+	if (SG_IS_DETACHING(sdp))
+		return -ENODEV;
+	spin_lock_irq(&sfp->rq_list_lock);
+	if (srp->done) {
+		srp->done = 2;
+		spin_unlock_irq(&sfp->rq_list_lock);
+		res = sg_new_read(sfp, p, SZ_SG_IO_HDR, srp);
+		return (res < 0) ? res : 0;
+	}
+	srp->orphan = 1;
+	spin_unlock_irq(&sfp->rq_list_lock);
+	return res;	/* -ERESTARTSYS because signal hit process */
+}
+
+static int
+sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
+{
+	if (want_rsv_sz != sfp->reserve.buflen) {
+		if (sfp->mmap_called ||
+		    sfp->res_in_use) {
+			return -EBUSY;
+		}
+
+		sg_remove_scat(sfp, &sfp->reserve);
+		sg_build_reserve(sfp, want_rsv_sz);
+	}
+	return 0;
+}
+
 #ifdef CONFIG_COMPAT
 struct compat_sg_req_info { /* used by SG_GET_REQUEST_TABLE ioctl() */
 	char req_state;
@@ -1046,148 +1096,180 @@ static int put_compat_request_table(struct compat_sg_req_info __user *o,
 }
 #endif
 
+static int
+sg_ctl_req_tbl(struct sg_fd *sfp, void __user *p)
+{
+	int result;
+	unsigned long iflags;
+	sg_req_info_t *rinfo;
+
+	rinfo = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
+			GFP_KERNEL);
+	if (!rinfo)
+		return -ENOMEM;
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	sg_fill_request_table(sfp, rinfo);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		result = put_compat_request_table(p, rinfo);
+	else
+		result = copy_to_user(p, rinfo,
+				      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
+#else
+	result = copy_to_user(p, rinfo,
+			      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
+#endif
+	kfree(rinfo);
+	return result;
+}
+
+static int
+sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_fd *sfp, void __user *p)
+{
+	struct sg_scsi_id ss_id;
+
+	SG_LOG(3, sfp, "%s:    SG_GET_SCSI_ID\n", __func__);
+	ss_id.host_no = sdev->host->host_no;
+	ss_id.channel = sdev->channel;
+	ss_id.scsi_id = sdev->id;
+	ss_id.lun = sdev->lun;
+	ss_id.scsi_type = sdev->type;
+	ss_id.h_cmd_per_lun = sdev->host->cmd_per_lun;
+	ss_id.d_queue_depth = sdev->queue_depth;
+	ss_id.unused[0] = 0;
+	ss_id.unused[1] = 0;
+	if (copy_to_user(p, &ss_id, sizeof(struct sg_scsi_id)))
+		return -EFAULT;
+	return 0;
+}
+
 static long
 sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		unsigned int cmd_in, void __user *p)
 {
+	bool read_only = O_RDWR != (filp->f_flags & O_ACCMODE);
+	int val;
+	int result = 0;
 	int __user *ip = p;
-	int result, val, read_only;
 	struct sg_request *srp;
+	struct scsi_device *sdev;
 	unsigned long iflags;
+	__maybe_unused const char *pmlp = ", pass to mid-level";
 
 	SG_LOG(6, sfp, "%s: cmd=0x%x, O_NONBLOCK=%d\n", __func__, cmd_in,
 	       !!(filp->f_flags & O_NONBLOCK));
-	read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
+	if (unlikely(SG_IS_DETACHING(sdp)))
+		return -ENODEV;
+	sdev = sdp->device;
 
 	switch (cmd_in) {
 	case SG_IO:
-		result = sg_allow_if_err_recovery(sdp, false);
-		if (result)
-			return result;
-		result = sg_submit(sfp, filp, p, SZ_SG_IO_HDR, true, read_only,
-				   true, &srp);
-		if (result < 0)
-			return result;
-		result = wait_event_interruptible(sfp->read_wait,
-			(srp_done(sfp, srp) || SG_IS_DETACHING(sdp)));
-		if (SG_IS_DETACHING(sdp))
-			return -ENODEV;
-		spin_lock_irq(&sfp->rq_list_lock);
-		if (srp->done) {
-			srp->done = 2;
-			spin_unlock_irq(&sfp->rq_list_lock);
-			result = sg_new_read(sfp, p, SZ_SG_IO_HDR, srp);
-			return (result < 0) ? result : 0;
-		}
-		srp->orphan = 1;
-		spin_unlock_irq(&sfp->rq_list_lock);
-		return result;	/* -ERESTARTSYS because signal hit process */
-	case SG_SET_TIMEOUT:
-		result = get_user(val, ip);
-		if (result)
-			return result;
-		if (val < 0)
-			return -EIO;
-		if (val >= mult_frac((s64)INT_MAX, USER_HZ, HZ))
-			val = min_t(s64, mult_frac((s64)INT_MAX, USER_HZ, HZ),
-				    INT_MAX);
-		sfp->timeout_user = val;
-		sfp->timeout = mult_frac(val, HZ, USER_HZ);
-
-		return 0;
-	case SG_GET_TIMEOUT:	/* N.B. User receives timeout as return value */
-				/* strange ..., for backward compatibility */
-		return sfp->timeout_user;
-	case SG_SET_FORCE_LOW_DMA:
-		/*
-		 * N.B. This ioctl never worked properly, but failed to
-		 * return an error value. So returning '0' to keep compability
-		 * with legacy applications.
-		 */
-		return 0;
-	case SG_GET_LOW_DMA:
-		return put_user((int) sdp->device->host->unchecked_isa_dma, ip);
+		return sg_ctl_sg_io(filp, sdp, sfp, p);
 	case SG_GET_SCSI_ID:
-		{
-			sg_scsi_id_t v;
-
-			if (SG_IS_DETACHING(sdp))
-				return -ENODEV;
-			memset(&v, 0, sizeof(v));
-			v.host_no = sdp->device->host->host_no;
-			v.channel = sdp->device->channel;
-			v.scsi_id = sdp->device->id;
-			v.lun = sdp->device->lun;
-			v.scsi_type = sdp->device->type;
-			v.h_cmd_per_lun = sdp->device->host->cmd_per_lun;
-			v.d_queue_depth = sdp->device->queue_depth;
-			if (copy_to_user(p, &v, sizeof(sg_scsi_id_t)))
-				return -EFAULT;
-			return 0;
-		}
+		return sg_ctl_scsi_id(sdev, sfp, p);
 	case SG_SET_FORCE_PACK_ID:
+		SG_LOG(3, sfp, "%s:    SG_SET_FORCE_PACK_ID\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
 		sfp->force_packid = val ? 1 : 0;
 		return 0;
 	case SG_GET_PACK_ID:
+		val = -1;
 		spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 		list_for_each_entry(srp, &sfp->rq_list, entry) {
 			if ((1 == srp->done) && (!srp->sg_io_owned)) {
-				spin_unlock_irqrestore(&sfp->rq_list_lock,
-						       iflags);
-				return put_user(srp->header.pack_id, ip);
+				val = srp->header.pack_id;
+				break;
 			}
 		}
 		spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-		return put_user(-1, ip);
+		SG_LOG(3, sfp, "%s:    SG_GET_PACK_ID=%d\n", __func__, val);
+		return put_user(val, ip);
 	case SG_GET_NUM_WAITING:
 		return put_user(atomic_read(&sfp->waiting), ip);
 	case SG_GET_SG_TABLESIZE:
+		SG_LOG(3, sfp, "%s:    SG_GET_SG_TABLESIZE=%d\n", __func__,
+		       sdp->max_sgat_sz);
 		return put_user(sdp->max_sgat_sz, ip);
 	case SG_SET_RESERVED_SIZE:
-		result = get_user(val, ip);
-		if (result)
-			return result;
-                if (val < 0)
-                        return -EINVAL;
-		val = min_t(int, val,
-			    max_sectors_bytes(sdp->device->request_queue));
 		mutex_lock(&sfp->f_mutex);
-		if (val != sfp->reserve.buflen) {
-			if (sfp->mmap_called ||
-			    sfp->res_in_use) {
-				mutex_unlock(&sfp->f_mutex);
-				return -EBUSY;
+		result = get_user(val, ip);
+		if (!result) {
+			if (val >= 0 && val <= (1024 * 1024 * 1024)) {
+				result = sg_set_reserved_sz(sfp, val);
+			} else {
+				SG_LOG(3, sfp, "%s: invalid size\n", __func__);
+				result = -EINVAL;
 			}
-
-			sg_remove_scat(sfp, &sfp->reserve);
-			sg_build_reserve(sfp, val);
 		}
 		mutex_unlock(&sfp->f_mutex);
-		return 0;
+		return result;
 	case SG_GET_RESERVED_SIZE:
 		val = min_t(int, sfp->reserve.buflen,
-			    max_sectors_bytes(sdp->device->request_queue));
+			    max_sectors_bytes(sdev->request_queue));
+		SG_LOG(3, sfp, "%s:    SG_GET_RESERVED_SIZE=%d\n",
+		       __func__, val);
 		return put_user(val, ip);
 	case SG_SET_COMMAND_Q:
+		SG_LOG(3, sfp, "%s:    SG_SET_COMMAND_Q\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
 		sfp->cmd_q = val ? 1 : 0;
 		return 0;
 	case SG_GET_COMMAND_Q:
+		SG_LOG(3, sfp, "%s:    SG_GET_COMMAND_Q\n", __func__);
 		return put_user((int) sfp->cmd_q, ip);
 	case SG_SET_KEEP_ORPHAN:
+		SG_LOG(3, sfp, "%s:    SG_SET_KEEP_ORPHAN\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
 		sfp->keep_orphan = val;
 		return 0;
 	case SG_GET_KEEP_ORPHAN:
+		SG_LOG(3, sfp, "%s:    SG_GET_KEEP_ORPHAN\n", __func__);
 		return put_user((int) sfp->keep_orphan, ip);
+	case SG_GET_VERSION_NUM:
+		SG_LOG(3, sfp, "%s:    SG_GET_VERSION_NUM\n", __func__);
+		return put_user(sg_version_num, ip);
+	case SG_GET_REQUEST_TABLE:
+		return sg_ctl_req_tbl(sfp, p);
+	case SG_SCSI_RESET:
+		SG_LOG(3, sfp, "%s:    SG_SCSI_RESET\n", __func__);
+		break;
+	case SG_SET_TIMEOUT:
+		SG_LOG(3, sfp, "%s:    SG_SET_TIMEOUT\n", __func__);
+		result = get_user(val, ip);
+		if (result)
+			return result;
+		if (val < 0)
+			return -EIO;
+		if (val >= mult_frac((s64)INT_MAX, USER_HZ, HZ))
+			val = min_t(s64, mult_frac((s64)INT_MAX, USER_HZ, HZ),
+				    INT_MAX);
+		sfp->timeout_user = val;
+		sfp->timeout = mult_frac(val, HZ, USER_HZ);
+		return 0;
+	case SG_GET_TIMEOUT:    /* N.B. User receives timeout as return value */
+				/* strange ..., for backward compatibility */
+		SG_LOG(3, sfp, "%s:    SG_GET_TIMEOUT\n", __func__);
+		return sfp->timeout_user;
+	case SG_SET_FORCE_LOW_DMA:
+		/*
+		 * N.B. This ioctl never worked properly, but failed to
+		 * return an error value. So returning '0' to keep
+		 * compatibility with legacy applications.
+		 */
+		SG_LOG(3, sfp, "%s:    SG_SET_FORCE_LOW_DMA\n", __func__);
+		return 0;
+	case SG_GET_LOW_DMA:
+		SG_LOG(3, sfp, "%s:    SG_GET_LOW_DMA\n", __func__);
+		return put_user((int)sdev->host->unchecked_isa_dma, ip);
 	case SG_NEXT_CMD_LEN:
+		SG_LOG(3, sfp, "%s:    SG_NEXT_CMD_LEN\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
@@ -1195,80 +1277,68 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 			return -ENOMEM;
 		sfp->next_cmd_len = (val > 0) ? val : 0;
 		return 0;
-	case SG_GET_VERSION_NUM:
-		return put_user(sg_version_num, ip);
 	case SG_GET_ACCESS_COUNT:
+		SG_LOG(3, sfp, "%s:    SG_GET_ACCESS_COUNT\n", __func__);
 		/* faked - we don't have a real access count anymore */
-		val = (sdp->device ? 1 : 0);
+		val = (sdev ? 1 : 0);
 		return put_user(val, ip);
-	case SG_GET_REQUEST_TABLE:
-		{
-			sg_req_info_t *rinfo;
-
-			rinfo = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
-					GFP_KERNEL);
-			if (!rinfo)
-				return -ENOMEM;
-			spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-			sg_fill_request_table(sfp, rinfo);
-			spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	#ifdef CONFIG_COMPAT
-			if (in_compat_syscall())
-				result = put_compat_request_table(p, rinfo);
-			else
-	#endif
-				result = copy_to_user(p, rinfo,
-						      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
-			result = result ? -EFAULT : 0;
-			kfree(rinfo);
-			return result;
-		}
 	case SG_EMULATED_HOST:
-		if (SG_IS_DETACHING(sdp))
-			return -ENODEV;
-		return put_user(sdp->device->host->hostt->emulated, ip);
+		SG_LOG(3, sfp, "%s:    SG_EMULATED_HOST\n", __func__);
+		return put_user(sdev->host->hostt->emulated, ip);
 	case SCSI_IOCTL_SEND_COMMAND:
-		if (SG_IS_DETACHING(sdp))
-			return -ENODEV;
-		return sg_scsi_ioctl(sdp->device->request_queue, NULL, filp->f_mode, p);
+		SG_LOG(3, sfp, "%s:    SCSI_IOCTL_SEND_COMMAND\n", __func__);
+		return sg_scsi_ioctl(sdev->request_queue, NULL, filp->f_mode,
+				     p);
 	case SG_SET_DEBUG:
+		SG_LOG(3, sfp, "%s:    SG_SET_DEBUG\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
 		assign_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm, val);
 		return 0;
 	case BLKSECTGET:
-		return put_user(max_sectors_bytes(sdp->device->request_queue),
-				ip);
+		SG_LOG(3, sfp, "%s:    BLKSECTGET\n", __func__);
+		return put_user(max_sectors_bytes(sdev->request_queue), ip);
 	case BLKTRACESETUP:
-		return blk_trace_setup(sdp->device->request_queue,
+		SG_LOG(3, sfp, "%s:    BLKTRACESETUP\n", __func__);
+		return blk_trace_setup(sdev->request_queue,
 				       sdp->disk->disk_name,
 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
 				       NULL, p);
 	case BLKTRACESTART:
-		return blk_trace_startstop(sdp->device->request_queue, 1);
+		SG_LOG(3, sfp, "%s:    BLKTRACESTART\n", __func__);
+		return blk_trace_startstop(sdev->request_queue, 1);
 	case BLKTRACESTOP:
-		return blk_trace_startstop(sdp->device->request_queue, 0);
+		SG_LOG(3, sfp, "%s:    BLKTRACESTOP\n", __func__);
+		return blk_trace_startstop(sdev->request_queue, 0);
 	case BLKTRACETEARDOWN:
-		return blk_trace_remove(sdp->device->request_queue);
+		SG_LOG(3, sfp, "%s:    BLKTRACETEARDOWN\n", __func__);
+		return blk_trace_remove(sdev->request_queue);
 	case SCSI_IOCTL_GET_IDLUN:
+		SG_LOG(3, sfp, "%s:    SCSI_IOCTL_GET_IDLUN %s\n", __func__,
+		       pmlp);
+		break;
 	case SCSI_IOCTL_GET_BUS_NUMBER:
+		SG_LOG(3, sfp, "%s:    SCSI_IOCTL_GET_BUS_NUMBER%s\n",
+		       __func__, pmlp);
+		break;
 	case SCSI_IOCTL_PROBE_HOST:
+		SG_LOG(3, sfp, "%s:    SCSI_IOCTL_PROBE_HOST%s",
+		       __func__, pmlp);
+		break;
 	case SG_GET_TRANSFORM:
-	case SG_SCSI_RESET:
-		if (SG_IS_DETACHING(sdp))
-			return -ENODEV;
+		SG_LOG(3, sfp, "%s:    SG_GET_TRANSFORM%s\n", __func__, pmlp);
 		break;
 	default:
+		SG_LOG(3, sfp, "%s:    unrecognized ioctl [0x%x]%s\n",
+		       __func__, cmd_in, pmlp);
 		if (read_only)
-			return -EPERM;	/* don't know so take safe approach */
+			return -EPERM;	/* don't know, so take safer approach */
 		break;
 	}
-
 	result = sg_allow_if_err_recovery(sdp, filp->f_flags & O_NDELAY);
 	if (result)
 		return result;
-
 	return -ENOIOCTLCMD;
 }
 
-- 
2.25.1

