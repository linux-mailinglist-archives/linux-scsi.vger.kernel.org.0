Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75C29E5C
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391656AbfEXSsd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:33 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56384 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391612AbfEXSsd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D4826204199;
        Fri, 24 May 2019 20:48:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6VpX4cisSR0e; Fri, 24 May 2019 20:48:29 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 52E28204170;
        Fri, 24 May 2019 20:48:23 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 10/19] sg: add sg_ioabort ioctl
Date:   Fri, 24 May 2019 14:48:00 -0400
Message-Id: <20190524184809.25121-11-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add ioctl(SG_IOABORT) that acts as a front-end to
blk_abort_request() which is only called if the request
is "inflight". The request to abort is matched via its
pack_id and the scope of the search is the current
device.

That scope will be fine tuned in a later patch to being
either all file descriptors belonging to the current
device, or just the current file descriptor.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 158 +++++++++++++++++++++++++++++++++--------
 include/uapi/scsi/sg.h |   3 +
 2 files changed, 132 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 638368ed9e11..7575dd66dbef 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -111,6 +111,7 @@ enum sg_rq_state {
 #define SG_FRQ_SYNC_INVOC	2	/* synchronous (blocking) invocation */
 #define SG_FRQ_DIO_IN_USE	3	/* false->indirect_IO,mmap; 1->dio */
 #define SG_FRQ_NO_US_XFER	4	/* no user space transfer of data */
+#define SG_FRQ_ABORTING		5	/* in process of aborting this cmd */
 #define SG_FRQ_DEACT_ORPHAN	7	/* not keeping orphan so de-activate */
 #define SG_FRQ_BLK_PUT_REQ	9	/* set when blk_put_request() called */
 
@@ -1566,6 +1567,97 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 	return res;
 }
 
+static struct sg_request *
+sg_match_request(struct sg_fd *sfp, int id)
+{
+	bool found = false;
+	struct sg_request *srp;
+
+	if (list_empty(&sfp->rq_list))
+		return NULL;
+	if (id == SG_PACK_ID_WILDCARD)	/* both wildcards same value: -1 */
+		return list_first_entry_or_null(&sfp->rq_list,
+						struct sg_request, rq_entry);
+	list_for_each_entry(srp, &sfp->rq_list, rq_entry) {
+		if (id == srp->pack_id) {
+			found = true;
+			break;
+		}
+	}
+	return found ? srp : NULL;
+}
+
+static int
+sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
+{
+	int res, pack_id, id;
+	unsigned long iflags;
+	struct sg_fd *o_sfp;
+	struct sg_request *srp;
+	struct sg_io_v4 io_v4;
+	struct sg_io_v4 *h4p = &io_v4;
+
+	if (copy_from_user(h4p, p, SZ_SG_IO_V4))
+		return -EFAULT;
+	if (h4p->guard != 'Q' || h4p->protocol != 0 || h4p->subprotocol != 0)
+		return -EPERM;
+	pack_id = h4p->request_extra;
+	id = pack_id;
+
+	spin_lock(&sfp->rq_list_lock);
+	srp = sg_match_request(sfp, id);
+	if (srp) {
+		spin_lock_irqsave(&srp->req_lck, iflags);
+		spin_unlock(&sfp->rq_list_lock);
+	} else {	/* assume device (not just fd) scope */
+		spin_unlock(&sfp->rq_list_lock);
+		read_lock(&sdp->sfd_llock);
+		list_for_each_entry(o_sfp, &sdp->sfds, sfd_entry) {
+			if (o_sfp == sfp)
+				continue;	/* already checked */
+			spin_lock(&o_sfp->rq_list_lock);
+			srp = sg_match_request(o_sfp, id);
+			if (srp) {
+				spin_lock_irqsave(&srp->req_lck, iflags);
+				spin_unlock(&o_sfp->rq_list_lock);
+				sfp = o_sfp;
+				break;
+			}
+			spin_unlock(&o_sfp->rq_list_lock);
+		}
+		read_unlock(&sdp->sfd_llock);
+	}
+	if (!srp)
+		return -ENODATA;
+
+	set_bit(SG_FRQ_ABORTING, srp->frq_bm);
+	res = 0;
+	switch (atomic_read(&srp->rq_st)) {
+	case SG_RS_BUSY:
+		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
+		res = -EBUSY;	/* shouldn't occur often */
+		break;
+	case SG_RS_INACTIVE:	/* inactive on rq_list not good */
+		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
+		res = -EPROTO;
+		break;
+	case SG_RS_AWAIT_RD:	/* user should still do completion */
+	case SG_RS_DONE_RD:
+		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
+		break;		/* nothing to do here, return 0 */
+	case SG_RS_INFLIGHT:	/* only attempt abort if inflight */
+		srp->rq_result |= (DRIVER_SOFT << 24);
+		if (srp->rq)
+			blk_abort_request(srp->rq);
+		break;
+	default:
+		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
+		break;
+	}
+	spin_unlock_irqrestore(&srp->req_lck, iflags);
+	return res;
+}
+
 /*
  * First normalize want_rsv_sz to be >= sfp->sgat_elem_sz and
  * <= max_segment_size. Exit if that is the same as old size; otherwise
@@ -1725,7 +1817,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	bool read_only = O_RDWR != (filp->f_flags & O_ACCMODE);
 	bool check_detach = false;
 	int val;
-	int result = 0;
+	int res = 0;
 	void __user *p = uptr64(arg);
 	int __user *ip = p;
 	struct sg_device *sdp;
@@ -1753,13 +1845,21 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_IORECEIVE:
 		SG_LOG(3, sdp, "%s:    SG_IORECEIVE\n", __func__);
 		return sg_ctl_ioreceive(filp, sfp, p);
+	case SG_IOABORT:
+		SG_LOG(3, sdp, "%s:    SG_IOABORT\n", __func__);
+		if (read_only)
+			return -EPERM;
+		mutex_lock(&sfp->f_mutex);
+		res = sg_ctl_abort(sdp, sfp, p);
+		mutex_unlock(&sfp->f_mutex);
+		return res;
 	case SG_GET_SCSI_ID:
 		return sg_ctl_scsi_id(sdev, sdp, p);
 	case SG_SET_FORCE_PACK_ID:
 		SG_LOG(3, sdp, "%s:    SG_SET_FORCE_PACK_ID\n", __func__);
-		result = get_user(val, ip);
-		if (unlikely(result))
-			return result;
+		res = get_user(val, ip);
+		if (unlikely(res))
+			return res;
 		assign_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm, !!val);
 		return 0;
 	case SG_GET_PACK_ID:    /* or tag of oldest "read"-able, -1 if none */
@@ -1787,31 +1887,31 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		return put_user(sdp->max_sgat_elems, ip);
 	case SG_SET_RESERVED_SIZE:
 		mutex_lock(&sfp->f_mutex);
-		result = get_user(val, ip);
-		if (likely(!result)) {
+		res = get_user(val, ip);
+		if (likely(!res)) {
 			if (val >= 0 && val <= (1024 * 1024 * 1024)) {
-				result = sg_set_reserved_sz(sfp, val);
+				res = sg_set_reserved_sz(sfp, val);
 			} else {
 				SG_LOG(3, sdp, "%s: invalid size\n", __func__);
-				result = -EINVAL;
+				res = -EINVAL;
 			}
 		}
 		mutex_unlock(&sfp->f_mutex);
-		return result;
+		return res;
 	case SG_GET_RESERVED_SIZE:
 		mutex_lock(&sfp->f_mutex);
 		val = min_t(int, sfp->rsv_srp->sgat_h.buflen,
 			    sdp->max_sgat_sz);
 		SG_LOG(3, sdp, "%s:    SG_GET_RESERVED_SIZE=%d\n",
 		       __func__, val);
-		result = put_user(val, ip);
+		res = put_user(val, ip);
 		mutex_unlock(&sfp->f_mutex);
-		return result;
+		return res;
 	case SG_SET_COMMAND_Q:
 		SG_LOG(3, sdp, "%s:    SG_SET_COMMAND_Q\n", __func__);
-		result = get_user(val, ip);
-		if (unlikely(result))
-			return result;
+		res = get_user(val, ip);
+		if (unlikely(res))
+			return res;
 		assign_bit(SG_FFD_CMD_Q, sfp->ffd_bm, !!val);
 		return 0;
 	case SG_GET_COMMAND_Q:
@@ -1819,9 +1919,9 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		return put_user(test_bit(SG_FFD_CMD_Q, sfp->ffd_bm), ip);
 	case SG_SET_KEEP_ORPHAN:
 		SG_LOG(3, sdp, "%s:    SG_SET_KEEP_ORPHAN\n", __func__);
-		result = get_user(val, ip);
-		if (unlikely(result))
-			return result;
+		res = get_user(val, ip);
+		if (unlikely(res))
+			return res;
 		assign_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm, !!val);
 		return 0;
 	case SG_GET_KEEP_ORPHAN:
@@ -1839,9 +1939,9 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		break;
 	case SG_SET_TIMEOUT:
 		SG_LOG(3, sdp, "%s:    SG_SET_TIMEOUT\n", __func__);
-		result = get_user(val, ip);
-		if (unlikely(result))
-			return result;
+		res = get_user(val, ip);
+		if (unlikely(res))
+			return res;
 		if (val < 0)
 			return -EIO;
 		if (val >= mult_frac((s64)INT_MAX, USER_HZ, HZ))
@@ -1867,9 +1967,9 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		return put_user((int)sdev->host->unchecked_isa_dma, ip);
 	case SG_NEXT_CMD_LEN:   /* active only in v2 interface */
 		SG_LOG(3, sdp, "%s:    SG_NEXT_CMD_LEN\n", __func__);
-		result = get_user(val, ip);
-		if (unlikely(result))
-			return result;
+		res = get_user(val, ip);
+		if (unlikely(res))
+			return res;
 		if (val > SG_MAX_CDB_SIZE)
 			return -ENOMEM;
 		mutex_lock(&sfp->f_mutex);
@@ -1894,9 +1994,9 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 				     filp->f_mode, p);
 	case SG_SET_DEBUG:
 		SG_LOG(3, sdp, "%s:    SG_SET_DEBUG\n", __func__);
-		result = get_user(val, ip);
-		if (unlikely(result))
-			return result;
+		res = get_user(val, ip);
+		if (unlikely(res))
+			return res;
 		sdp->sgdebug = (u8)val;
 		return 0;
 	case BLKSECTGET:
@@ -1952,9 +2052,9 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
 	}
-	result = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NDELAY));
-	if (unlikely(result))
-		return result;
+	res = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NDELAY));
+	if (unlikely(res))
+		return res;
 	/* ioctl that reach here are forwarded to the mid-level */
 	return scsi_ioctl(sdev, cmd_in, p);
 }
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index db86d1ae7e29..cd58f918a784 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -356,6 +356,9 @@ struct sg_header {
 /* Gives some v4 identifying info to driver, receives associated response */
 #define SG_IORECEIVE _IOWR(SG_IOCTL_MAGIC_NUM, 0x42, struct sg_io_v4)
 
+/* Provides identifying info about a prior submission (e.g. a tag) */
+#define SG_IOABORT _IOW(SG_IOCTL_MAGIC_NUM, 0x43, struct sg_io_v4)
+
 /* command queuing is always on when the v3 or v4 interface is used */
 #define SG_DEF_COMMAND_Q 0
 
-- 
2.17.1

