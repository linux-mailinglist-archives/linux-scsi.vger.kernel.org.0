Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E174729E68
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbfEXSss (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:48 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56437 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391669AbfEXSsr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 07062204165;
        Fri, 24 May 2019 20:48:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nm9gZHUYl-6v; Fri, 24 May 2019 20:48:38 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 5AF27204198;
        Fri, 24 May 2019 20:48:30 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 16/19] sg: add shared requests
Date:   Fri, 24 May 2019 14:48:06 -0400
Message-Id: <20190524184809.25121-17-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add request sharing which is invoked on a shared file
descriptor by using SGV4_FLAG_SHARE. The file share is
asymmetric: the master side is assumed to do data-in
command (e.g. READ) first, followed by the slave side
doing a data-out command (e.g. WRITE). The master side
may also set SG_FLAG_NO_DXFER and the slave side must
set that flag. If both sides set that flag then a
single bio is used and the user space doesn't "see"
the data. If the master side does not set
SG_FLAG_NO_DXFER then the read data is copied to the
user space. And that copy to user space can displaced
by using SG_FLAG_MMAP_IO (but that adds some other
overheads).

See the webpage at: http://sg.danny.cz/sg/sg_v40.html
in the section titled: "7 Request sharing".

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 812 +++++++++++++++++++++++++++++++++++------
 include/uapi/scsi/sg.h |   8 +
 2 files changed, 705 insertions(+), 115 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 44f09c65e0b9..9adca3988c58 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -89,6 +89,17 @@ enum sg_rq_state {
 	SG_RS_AWAIT_RD,		/* response received, awaiting read */
 	SG_RS_DONE_RD,		/* read is ongoing or done */
 	SG_RS_BUSY,		/* temporary state should rarely be seen */
+	SG_RS_SHR_SWAP,		/* swap: master finished, awaiting slave */
+	SG_RS_SHR_SLAVE,	/* master waits while slave inflight */
+};
+
+/* slave sets up sharing: ioctl(sl_fd,SG_SET_GET_EXTENDED(SHARE_FD(ma_fd))) */
+enum sg_shr_var {
+	SG_SHR_NONE = 0,	/* no sharing on owning fd */
+	SG_SHR_MA_FD_NOT_RQ,	/* master sharing on fd but not this req */
+	SG_SHR_MA_RQ,		/* master sharing on this req */
+	SG_SHR_SL_FD_NOT_RQ,	/* slave sharing on fd but not this req */
+	SG_SHR_SL_RQ,		/* slave sharing on this req */
 };
 
 /* If sum_of(dlen) of a fd exceeds this, write() will yield E2BIG */
@@ -130,6 +141,7 @@ enum sg_rq_state {
 #define SG_FFD_MMAP_CALLED	3	/* mmap(2) system call made on fd */
 #define SG_FFD_TIME_IN_NS	4	/* set: time in nanoseconds, else ms */
 #define SG_FFD_Q_AT_TAIL	5	/* set: queue reqs at tail of blk q */
+#define SG_FFD_MASTER_ERR	6	/* master side of share had error */
 #define SG_FFD_PREFER_TAG	7	/* prefer tag over pack_id (def) */
 #define SG_FFD_RELEASE		8	/* release (close) underway */
 #define SG_FFD_NO_DURATION	9	/* don't do command duration calc */
@@ -202,6 +214,7 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 	struct list_head fl_entry;	/* member of rq_fl */
 	spinlock_t req_lck;
 	struct sg_scatter_hold sgat_h;	/* hold buffer, perhaps scatter list */
+	struct sg_scatter_hold *sgatp;	/* ptr to prev unless slave shr req */
 	union {
 		struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
 		struct sg_slice_hdr4 s_hdr4; /* reduced size struct sg_io_v4 */
@@ -214,6 +227,7 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 	int pack_id;		/* v3 pack_id or in v4 request_extra field */
 	int sense_len;		/* actual sense buffer length (data-in) */
 	atomic_t rq_st;		/* request state, holds a enum sg_rq_state */
+	enum sg_shr_var sh_var;	/* sharing variety, SG_SHR_NONE=0 if none */
 	u8 cmd_opcode;		/* first byte of SCSI cdb */
 	int tag;		/* block layer identifier of request */
 	u64 start_ns;		/* starting point of command duration calc */
@@ -246,6 +260,7 @@ struct sg_fd {		/* holds the state of a file descriptor */
 	u8 next_cmd_len;	/* 0: automatic, >0: use on next write() */
 	struct file *filp;	/* my identity when sharing */
 	struct sg_request *rsv_srp;/* one reserve request per fd */
+	struct sg_request *slave_srp;	/* non-NULL when rsv SG_SHR_MA_RQ */
 	struct sg_fd *share_sfp;/* master+slave shares set this, else NULL */
 	struct fasync_struct *async_qp; /* used by asynchronous notification */
 	struct kref f_ref;
@@ -304,7 +319,9 @@ static void sg_remove_sfp(struct kref *);
 static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id,
 					    bool is_tag);
 static struct sg_request *sg_add_request(struct sg_comm_wr_t *cwrp,
-					 int dxfr_len);
+					 enum sg_shr_var sh_var, int dxfr_len);
+static int sg_rq_map_kern(struct sg_request *srp, struct request_queue *q,
+			  struct request *rq);
 static void sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
 static struct sg_device *sg_get_dev(int min_dev);
 static void sg_device_destroy(struct kref *kref);
@@ -312,6 +329,7 @@ static struct sg_request *sg_mk_srp_sgat(struct sg_fd *sfp, bool first,
 					 int db_len);
 static void sg_calc_sgat_param(struct sg_device *sdp);
 static const char *sg_rq_st_str(enum sg_rq_state rq_st, bool long_str);
+static const char *sg_shr_str(enum sg_shr_var sh_var, bool long_str);
 static void sg_rep_rq_state_fail(struct sg_device *sdp,
 				 enum sg_rq_state exp_old_st,
 				 enum sg_rq_state want_st,
@@ -327,6 +345,8 @@ static void sg_rep_rq_state_fail(struct sg_device *sdp,
 
 #define SG_RS_ACTIVE(srp) (atomic_read(&(srp)->rq_st) != SG_RS_INACTIVE)
 #define SG_RS_AWAIT_READ(srp) (atomic_read(&(srp)->rq_st) == SG_RS_AWAIT_RD)
+#define SG_MA_THIS_RQ(srp) ((srp)->sh_var == SG_SHR_MA_RQ)
+#define SG_IS_SYNC_INVOC(srp) test_bit(SG_FRQ_SYNC_INVOC, (srp)->frq_bm)
 
 /*
  * Kernel needs to be built with CONFIG_SCSI_LOGGING to see log messages.
@@ -417,8 +437,8 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 			mutex_unlock(&sdp->open_rel_lock);
 			res = wait_event_interruptible
 				(sdp->open_wait,
-				 unlikely((atomic_read(&sdp->detaching)) ||
-					  !sdp->exclude));
+				 unlikely(atomic_read(&sdp->detaching)) ||
+				 !sdp->exclude);
 			mutex_lock(&sdp->open_rel_lock);
 
 			if (unlikely(res)) /* -ERESTARTSYS */
@@ -469,7 +489,7 @@ sg_open(struct inode *inode, struct file *filp)
 	nonseekable_open(inode, filp);
 	o_excl = !!(op_flags & O_EXCL);
 	non_block = !!(op_flags & O_NONBLOCK);
-	if (o_excl && ((op_flags & O_ACCMODE) == O_RDONLY))
+	if (unlikely(o_excl) && ((op_flags & O_ACCMODE) == O_RDONLY))
 		return -EPERM;/* not permitted, need write access for O_EXCL */
 	sdp = sg_get_dev(min_dev);
 	if (IS_ERR(sdp))
@@ -595,6 +615,10 @@ sg_release(struct inode *inode, struct file *filp)
  * of the synchronous ioctl(SG_IO) system call.
  */
 
+/*
+ * This is the write(2) system call entry point. v4 interface disallowed.
+ * Returns count or a negated errno value.
+ */
 static ssize_t
 sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 {
@@ -719,7 +743,7 @@ sg_fetch_cmnd(struct sg_fd *sfp, const u8 __user *u_cdbp, int len, u8 *cdbp)
 		return -EMSGSIZE;
 	if (copy_from_user(cdbp, u_cdbp, len))
 		return -EFAULT;
-	if (O_RDWR != (sfp->filp->f_flags & O_ACCMODE)) { /* read-only */
+	if (O_RDWR != (sfp->filp->f_flags & O_ACCMODE)) {	/* read-only */
 		switch (sfp->parentdp->device->type) {
 		case TYPE_DISK:
 		case TYPE_RBC:
@@ -744,7 +768,7 @@ sg_v3_submit(struct sg_fd *sfp, struct sg_io_hdr *hp, bool sync,
 	if (hp->flags & SG_FLAG_MMAP_IO) {
 		if (!list_empty(&sfp->rq_list))
 			return -EBUSY;  /* already active requests on fd */
-		if (hp->dxfer_len > sfp->rsv_srp->sgat_h.buflen)
+		if (hp->dxfer_len > sfp->rsv_srp->sgatp->buflen)
 			return -ENOMEM; /* MMAP_IO size must fit in reserve */
 		if (hp->flags & SG_FLAG_DIRECT_IO)
 			return -EINVAL; /* not both MMAP_IO and DIRECT_IO */
@@ -789,7 +813,7 @@ sg_v4_submit(struct sg_fd *sfp, void __user *p, struct sg_io_v4 *h4p,
 			len = h4p->dout_xfer_len;
 		if (!list_empty(&sfp->rq_list))
 			return -EBUSY;  /* already active requests on fd */
-		if (len > sfp->rsv_srp->sgat_h.buflen)
+		if (len > sfp->rsv_srp->sgatp->buflen)
 			return -ENOMEM; /* MMAP_IO size must fit in reserve */
 		if (h4p->flags & SG_FLAG_DIRECT_IO)
 			return -EINVAL; /* not both MMAP_IO and DIRECT_IO */
@@ -854,6 +878,53 @@ sg_ctl_iosubmit_v3(struct sg_fd *sfp, void __user *p)
 	return -EPERM;
 }
 
+/*
+ * Assumes sharing has been established at the file descriptor level and now we
+ * check the rq_flags of a new request/command. SGV4_FLAG_NO_DXFER may or may
+ * not be used on the master side, it must be used on the slave side. Also
+ * returns (via *sh_varp) the proposed sg_request::sh_var of the new request
+ * yet to be built/re-used.
+ */
+static int
+sg_share_chk_flags(struct sg_fd *sfp, u32 rq_flags, int dxfer_len, int dir,
+		   enum sg_shr_var *sh_varp)
+{
+	bool is_master = (sfp->shr_fd == SG_SHARE_FD_MASTER);
+	int result = 0;
+	enum sg_shr_var sh_var = SG_SHR_NONE;
+
+	if (rq_flags & SGV4_FLAG_SHARE) {
+		if (rq_flags & SG_FLAG_DIRECT_IO)
+			result = -EINVAL; /* since no control of data buffer */
+		else if (dxfer_len < 1)
+			result = -ENODATA;
+		else if (is_master) {		/* fd is reader */
+			sh_var = SG_SHR_MA_RQ;
+			if (dir != SG_DXFER_FROM_DEV)
+				result = -ENOMSG;
+			if (rq_flags & SGV4_FLAG_NO_DXFER) {
+				/* rule out some contradictions */
+				if (rq_flags & SG_FL_MMAP_DIRECT)
+					result = -ENODATA;
+			}
+		} else {			/* fd is slave, writer */
+			sh_var = SG_SHR_SL_RQ;
+			if (dir != SG_DXFER_TO_DEV)
+				result = -ENOMSG;
+			if (!(rq_flags & SGV4_FLAG_NO_DXFER))
+				result = -ENOMSG;
+			if (rq_flags & SG_FL_MMAP_DIRECT)
+				result = -ENODATA;
+		}
+	} else if (is_master) {
+		sh_var = SG_SHR_MA_FD_NOT_RQ;
+	} else {
+		sh_var = SG_SHR_SL_FD_NOT_RQ;
+	}
+	*sh_varp = sh_var;
+	return result;
+}
+
 static void
 sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 {
@@ -862,7 +933,7 @@ sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 	struct sg_device *sdp = sfp->parentdp;
 
 	is_v4h = test_bit(SG_FRQ_IS_V4I, srp->frq_bm);
-	sync = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
+	sync = SG_IS_SYNC_INVOC(srp);
 	SG_LOG(3, sdp, "%s: is_v4h=%d\n", __func__, (int)is_v4h);
 	if (test_bit(SG_FFD_NO_DURATION, sfp->ffd_bm))
 		srp->start_ns = 0;
@@ -927,6 +998,7 @@ sg_common_write(struct sg_comm_wr_t *cwrp)
 	int dxfr_len, dir;
 	int pack_id = SG_PACK_ID_WILDCARD;
 	u32 rq_flags;
+	enum sg_shr_var sh_var;
 	struct sg_fd *fp = cwrp->sfp;
 	struct sg_device *sdp = fp->parentdp;
 	struct sg_request *srp;
@@ -957,10 +1029,20 @@ sg_common_write(struct sg_comm_wr_t *cwrp)
 		rq_flags = hi_p->flags;
 		pack_id = hi_p->pack_id;
 	}
+	if (fp->shr_fd == SG_SHARE_FD_UNUSED) {
+		/* no sharing established on this fd */
+		sh_var = SG_SHR_NONE;
+		if (rq_flags & SGV4_FLAG_SHARE)
+			return ERR_PTR(-ENOMSG);
+	} else {
+		res = sg_share_chk_flags(fp, rq_flags, dxfr_len, dir, &sh_var);
+		if (unlikely(res < 0))
+			return ERR_PTR(res);
+	}
 	if (dxfr_len >= SZ_256M)
 		return ERR_PTR(-EINVAL);
 
-	srp = sg_add_request(cwrp, dxfr_len);
+	srp = sg_add_request(cwrp, sh_var, dxfr_len);
 	if (IS_ERR(srp))
 		return srp;
 	srp->rq_flags = rq_flags;
@@ -1099,17 +1181,92 @@ sg_rec_v3v4_state(struct sg_fd *sfp, struct sg_request *srp, bool v4_active)
 	int err = 0;
 	int sb_len_wr;
 	u32 rq_res = srp->rq_result;
+	enum sg_shr_var sh_var = srp->sh_var;
 
 	sb_len_wr = sg_copy_sense(srp, v4_active);
 	if (sb_len_wr < 0)
 		return sb_len_wr;
 	if (rq_res & SG_ML_RESULT_MSK)
 		srp->rq_info |= SG_INFO_CHECK;
+	if (test_bit(SG_FRQ_ABORTING, srp->frq_bm))
+		srp->rq_info |= SG_INFO_ABORTED;
+
+	if (sh_var == SG_SHR_SL_RQ && sfp->share_sfp) {
+		struct sg_request *ma_srp = sfp->share_sfp->rsv_srp;
+		enum sg_rq_state mar_st = atomic_read(&ma_srp->rq_st);
+
+		switch (mar_st) {
+		case SG_RS_SHR_SWAP:
+		case SG_RS_SHR_SLAVE:
+			/* already on master's free list, make re-usable */
+			ma_srp->tag = SG_TAG_WILDCARD;
+			ma_srp->sh_var = SG_SHR_NONE;
+			err = sg_rstate_chg(ma_srp, mar_st, SG_RS_INACTIVE);
+			break;
+		case SG_RS_INACTIVE:
+		case SG_RS_AWAIT_RD:
+			sfp->share_sfp->slave_srp = NULL;
+			break;	/* nothing to do */
+		default:
+			err = -EPROTO;	/* Logic error */
+			SG_LOG(1, sfp->parentdp,
+			       "%s: SHR_SL_ACTIVE, bad master state: %s\n",
+			       __func__, sg_rq_st_str(mar_st, true));
+			break;	/* nothing to do */
+		}
+	}
 	if (unlikely(atomic_read(&sfp->parentdp->detaching)))
 		srp->rq_info |= SG_INFO_DEVICE_DETACHING;
 	return err;
 }
 
+static int
+sg_v3v4_complete(struct sg_fd *sfp, struct sg_request *srp, bool other_err)
+{
+	int err = 0;
+	enum sg_rq_state sr_st = atomic_read(&srp->rq_st);
+
+	/* advance state machine, send signal to slave if appropriate */
+	switch (srp->sh_var) {
+	case SG_SHR_MA_RQ:
+		{
+			int poll_type = POLL_OUT;
+
+			if ((srp->rq_result & SG_ML_RESULT_MSK) || other_err) {
+				set_bit(SG_FFD_MASTER_ERR, sfp->ffd_bm);
+				err = sg_rstate_chg(srp, sr_st, SG_RS_DONE_RD);
+				poll_type = POLL_HUP;	/* "Hang-UP flag */
+			} else if (sr_st != SG_RS_SHR_SWAP) {
+				err = sg_rstate_chg(srp, sr_st,
+						    SG_RS_SHR_SWAP);
+			}
+			if (sfp->share_sfp)
+				kill_fasync(&sfp->share_sfp->async_qp,
+					    SIGPOLL, poll_type);
+		}
+		break;
+	case SG_SHR_SL_RQ:	/* cleanup both on slave completion */
+		{
+			struct sg_fd *ma_sfp = sfp->share_sfp;
+
+			if (ma_sfp) {
+				ma_sfp->slave_srp = NULL;
+				if (ma_sfp->rsv_srp)
+					ma_sfp->rsv_srp->sh_var =
+							 SG_SHR_MA_FD_NOT_RQ;
+			}
+		}
+		srp->sh_var = SG_SHR_SL_FD_NOT_RQ;
+		srp->sgatp = &srp->sgat_h;
+		err = sg_rstate_chg(srp, sr_st, SG_RS_DONE_RD);
+		break;
+	default:
+		err = sg_rstate_chg(srp, sr_st, SG_RS_DONE_RD);
+		break;
+	}
+	return err;
+}
+
 static int
 sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	      struct sg_io_v4 *h4p)
@@ -1132,10 +1289,10 @@ sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	h4p->duration = srp->duration;
 	switch (srp->s_hdr4.dir) {
 	case SG_DXFER_FROM_DEV:
-		h4p->din_xfer_len = srp->sgat_h.dlen;
+		h4p->din_xfer_len = srp->sgatp->dlen;
 		break;
 	case SG_DXFER_TO_DEV:
-		h4p->dout_xfer_len = srp->sgat_h.dlen;
+		h4p->dout_xfer_len = srp->sgatp->dlen;
 		break;
 	default:
 		break;
@@ -1149,7 +1306,7 @@ sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 		if (copy_to_user(p, h4p, SZ_SG_IO_V4))
 			err = err ? err : -EFAULT;
 	}
-	err2 = sg_rstate_chg(srp, atomic_read(&srp->rq_st), SG_RS_DONE_RD);
+	err2 = sg_v3v4_complete(sfp, srp, err < 0);
 	if (err2)
 		err = err ? err : err2;
 	sg_finish_scsi_blk_rq(srp);
@@ -1199,9 +1356,9 @@ sg_ctl_ioreceive(struct sg_fd *sfp, void __user *p)
 			return -ENODEV;
 		if (non_block)
 			return -EAGAIN;
-		res = wait_event_interruptible(sfp->read_wait,
-					       sg_get_ready_srp(sfp, &srp,
-								id, use_tag));
+		res = wait_event_interruptible
+				(sfp->read_wait,
+				 sg_get_ready_srp(sfp, &srp, id, use_tag));
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
 		if (unlikely(res))
@@ -1401,6 +1558,19 @@ sg_read(struct file *filp, char __user *p, size_t count, loff_t *ppos)
 				ret = get_user(want_id, &h3_up->pack_id);
 				if (ret)
 					return ret;
+				if (!non_block) {
+					int flgs;
+
+					ret = get_user(flgs, &h3_up->flags);
+					if (ret)
+						return ret;
+					if (flgs & SGV4_FLAG_IMMED)
+						non_block = true;
+				}
+			} else if (v3_hdr->interface_id == 'Q') {
+				pr_info_once("sg: %s: v4 interface%s here\n",
+					     __func__, " disallowed");
+				return -EPERM;
 			} else {
 				return -EPERM;
 			}
@@ -1448,7 +1618,8 @@ sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p)
 	struct sg_io_hdr hdr3;
 	struct sg_io_hdr *hp = &hdr3;
 
-	SG_LOG(3, sfp->parentdp, "%s: srp=0x%p\n", __func__, srp);
+	SG_LOG(3, sfp->parentdp, "%s: sh_var: %s srp=0x%p\n", __func__,
+	       sg_shr_str(srp->sh_var, false), srp);
 	err = sg_rec_v3v4_state(sfp, srp, false);
 	memset(hp, 0, sizeof(*hp));
 	memcpy(hp, &srp->s_hdr3, sizeof(srp->s_hdr3));
@@ -1464,7 +1635,7 @@ sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p)
 	/* copy_*_user() [without leading underscores] checks access */
 	if (copy_to_user(p, hp, SZ_SG_IO_HDR))
 		err = err ? err : -EFAULT;
-	err2 = sg_rstate_chg(srp, atomic_read(&srp->rq_st), SG_RS_DONE_RD);
+	err2 = sg_v3v4_complete(sfp, srp, err < 0);
 	if (err2)
 		err = err ? err : err2;
 	sg_finish_scsi_blk_rq(srp);
@@ -1514,11 +1685,77 @@ sg_calc_sgat_param(struct sg_device *sdp)
 	sdp->max_sgat_sz = sz;
 }
 
+/*
+ * Only valid for shared file descriptors, else -EINVAL. Should only be
+ * called after a master side request has successfully completed so that
+ * there is valid data in reserve buffer. If fini1_again0 is true then
+ * master is taken out of the state waiting for a slave request and the
+ * master is put in the inactive state. If fini1_again0 is false (0) then
+ * the master (assuming it is inactive) is put in a state waiting for
+ * a slave request. This function is called when the write mask is set on
+ * ioctl(SG_SET_GET_EXTENDED(SG_CTL_FLAGM_MASTER_FINI)).
+ */
+static int
+sg_change_after_master_rq(struct sg_fd *sfp, bool fini1_again0)
+{
+	int res = 0;
+	enum sg_rq_state sr_st;
+	struct sg_request *ma_rsv_srp = NULL;
+
+	rcu_read_lock();
+	if (sfp->shr_fd == SG_SHARE_FD_MASTER) {	/* from master */
+		ma_rsv_srp = sfp->rsv_srp;
+	} else if (sfp->shr_fd == SG_SHARE_FD_UNUSED) {
+		res = -EINVAL;
+	} else {					/* from slave */
+		if (sfp->share_sfp)
+			ma_rsv_srp = sfp->share_sfp->rsv_srp;
+		else
+			res = -EINVAL;
+	}
+	if (res == 0 && ma_rsv_srp) {
+		spin_lock(&ma_rsv_srp->req_lck);
+		sr_st = atomic_read(&ma_rsv_srp->rq_st);
+		if (fini1_again0) {
+			switch (sr_st) {
+			case SG_RS_SHR_SWAP:
+				ma_rsv_srp->sh_var = SG_SHR_MA_FD_NOT_RQ;
+				ma_rsv_srp = NULL;
+				res = sg_rstate_chg(ma_rsv_srp, sr_st,
+						    SG_RS_INACTIVE);
+				break;
+			case SG_RS_SHR_SLAVE:	/* too late, slave rq active */
+			case SG_RS_BUSY:
+				res = -EAGAIN;
+				break;
+			default:	/* master in SG_RS_SHR_SWAIT is bad */
+				res = -EINVAL;
+				break;
+			}
+		} else if (sr_st == SG_RS_INACTIVE) {
+			ma_rsv_srp->sh_var = SG_SHR_MA_RQ;
+			res = sg_rstate_chg(ma_rsv_srp, sr_st, SG_RS_SHR_SWAP);
+		} else {
+			res = -EBUSY;	/* master busy doing something else */
+		}
+		spin_unlock(&ma_rsv_srp->req_lck);
+	}
+	rcu_read_unlock();
+	if (unlikely(res)) {
+		SG_LOG(1, sfp->parentdp, "%s: err=%d\n", __func__, -res);
+	} else {
+		SG_LOG(6, sfp->parentdp, "%s: okay, fini1_again0=%d\n",
+		       __func__, fini1_again0);
+	}
+	return res;
+}
+
 static void
 sg_unshare_fds(struct sg_fd *ma_sfp, struct sg_fd *sl_sfp)
 {
 	if (ma_sfp) {
 		ma_sfp->share_sfp = NULL;
+		ma_sfp->slave_srp = NULL;
 		ma_sfp->shr_fd = SG_SHARE_FD_UNUSED;
 	}
 	if (sl_sfp) {
@@ -1527,6 +1764,64 @@ sg_unshare_fds(struct sg_fd *ma_sfp, struct sg_fd *sl_sfp)
 	}
 }
 
+/* Placed here with other share/unshare processing functions */
+static void
+sg_remove_sfp_share(struct sg_fd *sfp)
+{
+	bool o_sfp_is_master = false;
+	int res = 0;
+	enum sg_rq_state sr_st;
+	struct sg_fd *o_sfp = sfp->share_sfp;
+	struct sg_request *rsv_srp = NULL;
+
+	SG_LOG(3, sfp->parentdp, "%s: sfp=0x%p, o_sfp=0x%p%s\n", __func__,
+	       sfp, o_sfp,
+	       ((sfp->shr_fd == SG_SHARE_FD_MASTER) ? " master" : ""));
+	if (!o_sfp)
+		return;
+	if (sfp->shr_fd == SG_SHARE_FD_MASTER) {	/* close on master */
+		rsv_srp = sfp->rsv_srp;
+	} else if (sfp->shr_fd == SG_SHARE_FD_UNUSED) {
+		return;
+	} else {					/* close on slave */
+		o_sfp_is_master = true;
+		rsv_srp = o_sfp->rsv_srp;
+	}
+	spin_lock(&o_sfp->rq_list_lock);
+	sg_unshare_fds(o_sfp, NULL);
+	spin_unlock(&o_sfp->rq_list_lock);
+	if (!rsv_srp) {
+		res = -EPROTO;
+		goto fini;
+	}
+	spin_lock(&rsv_srp->req_lck);
+	if (o_sfp_is_master) {
+		if (rsv_srp->sh_var == SG_SHR_MA_RQ) {
+			sr_st = atomic_read(&rsv_srp->rq_st);
+			switch (sr_st) {
+			case SG_RS_SHR_SLAVE:
+			case SG_RS_SHR_SWAP:
+				res = sg_rstate_chg(rsv_srp, sr_st,
+						    SG_RS_INACTIVE);
+				break;
+			case SG_RS_BUSY:
+				res = -EBUSY;
+			default:
+				break;
+			}
+			rsv_srp->sh_var = SG_SHR_NONE;
+		}
+	} else {
+		rsv_srp->sh_var = SG_SHR_NONE;
+	}
+	spin_unlock(&rsv_srp->req_lck);
+fini:
+	if (unlikely(res)) {
+		SG_LOG(1, sfp->parentdp, "%s: internal err=%d\n", __func__,
+		       -res);
+	}
+}
+
 /*
  * Active when writing 1 to ioctl(SG_SET_GET_EXTENDED(CTL_FLAGS(UNSHARE))),
  * writing 0 has no effect. Undoes the configuration that has done by
@@ -1538,6 +1833,7 @@ sg_chk_unshare(struct sg_fd *sfp, bool unshare_val)
 	bool retry;
 	int retry_count = 0;
 	unsigned long iflags;
+	struct sg_request *ma_rsv_srp;
 	struct sg_fd *ma_sfp;
 	struct sg_fd *sl_sfp;
 	struct sg_fd *o_sfp = sfp->share_sfp;/* other side of existing share */
@@ -1552,17 +1848,20 @@ sg_chk_unshare(struct sg_fd *sfp, bool unshare_val)
 	if (sfp->shr_fd == SG_SHARE_FD_MASTER) {  /* called on master fd */
 		ma_sfp = sfp;
 		sl_sfp = o_sfp;
-		if (!spin_trylock(&sl_sfp->rq_list_lock)) {
-			if (++retry_count > SG_ADD_RQ_MAX_RETRIES)
-				SG_LOG(1, sfp->parentdp,
-				       "%s: cannot get slave lock\n",
-				       __func__);
-			else
-				retry = true;
-			goto fini;
+		ma_rsv_srp = ma_sfp->rsv_srp;
+		if (ma_rsv_srp && !SG_MA_THIS_RQ(ma_rsv_srp)) {
+			if (!spin_trylock(&sl_sfp->rq_list_lock)) {
+				if (++retry_count > SG_ADD_RQ_MAX_RETRIES)
+					SG_LOG(1, sfp->parentdp,
+					       "%s: cannot get slave lock\n",
+					       __func__);
+				else
+					retry = true;
+				goto fini;
+			}
+			sg_unshare_fds(ma_sfp, sl_sfp);
+			spin_unlock(&sl_sfp->rq_list_lock);
 		}
-		sg_unshare_fds(ma_sfp, sl_sfp);
-		spin_unlock(&sl_sfp->rq_list_lock);
 	} else {			/* called on slave fd */
 		ma_sfp = o_sfp;
 		sl_sfp = sfp;
@@ -1575,7 +1874,9 @@ sg_chk_unshare(struct sg_fd *sfp, bool unshare_val)
 				retry = true;
 			goto fini;
 		}
-		sg_unshare_fds(ma_sfp, sl_sfp);
+		ma_rsv_srp = ma_sfp->rsv_srp;
+		if (!SG_MA_THIS_RQ(ma_rsv_srp))
+			sg_unshare_fds(ma_sfp, sl_sfp);
 		spin_unlock(&ma_sfp->rq_list_lock);
 	}
 fini:
@@ -1633,6 +1934,8 @@ sg_get_dur(struct sg_request *srp, const enum sg_rq_state *sr_stp,
 		break;
 	case SG_RS_AWAIT_RD:
 	case SG_RS_DONE_RD:
+	case SG_RS_SHR_SWAP:
+	case SG_RS_SHR_SLAVE:
 		res = srp->duration;
 		is_dur = true;	/* completion has occurred, timing finished */
 		break;
@@ -1656,7 +1959,7 @@ sg_fill_request_element(struct sg_fd *sfp, struct sg_request *srp,
 	if (rip->duration == U32_MAX)
 		rip->duration = 0;
 	rip->orphan = test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm);
-	rip->sg_io_owned = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
+	rip->sg_io_owned = SG_IS_SYNC_INVOC(srp);
 	rip->problem = !!(srp->rq_result & SG_ML_RESULT_MSK);
 	rip->pack_id = test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm) ?
 				srp->tag : srp->pack_id;
@@ -1718,18 +2021,17 @@ sg_wait_event_srp(struct sg_fd *sfp, void __user *p, struct sg_io_v4 *h4p,
  * Returns 0 on success else a negated errno.
  */
 static int
-sg_ctl_sg_io(struct sg_device *sdp, struct sg_fd *sfp,
-	     void __user *p)
+sg_ctl_sg_io(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 {
 	int res;
 	struct sg_request *srp = NULL;
-	u8 hu8arr[SZ_SG_IO_V4];
+	u8 hu8arr[SZ_SG_IO_V4];		/* v4 header larger than v3 */
 	struct sg_io_hdr *h3p = (struct sg_io_hdr *)hu8arr;
 	struct sg_io_v4 *h4p = (struct sg_io_v4 *)hu8arr;
 
 	SG_LOG(3, sdp, "%s:  SG_IO%s\n", __func__,
 	       ((sfp->filp->f_flags & O_NONBLOCK) ?
-				 " O_NONBLOCK ignored" : ""));
+				" O_NONBLOCK ignored" : ""));
 	res = sg_allow_if_err_recovery(sdp, false);
 	if (unlikely(res))
 		return res;
@@ -1757,14 +2059,18 @@ sg_ctl_sg_io(struct sg_device *sdp, struct sg_fd *sfp,
 		return res;
 	res = sg_wait_event_srp(sfp, p, h4p, srp);
 	if (unlikely(res)) {
-		SG_LOG(1, sdp, "%s: %s=0x%p  state: %s\n", __func__,
-		       "unexpected srp", srp,
-		       sg_rq_st_str(atomic_read(&srp->rq_st), false));
+		SG_LOG(1, sdp, "%s: %s=0x%p  state: %s, share: %s\n",
+		       __func__, "unexpected srp", srp,
+		       sg_rq_st_str(atomic_read(&srp->rq_st), false),
+		       sg_shr_str(srp->sh_var, false));
 	}
 	return res;
 }
 
-/* When use_tag is true then id is a tag, else it is a pack_id. */
+/*
+ * When use_tag is true then id is a tag, else it is a pack_id. Returns
+ * valid srp if match, else returns NULL.
+ */
 static struct sg_request *
 sg_match_request(struct sg_fd *sfp, bool use_tag, int id)
 {
@@ -1819,7 +2125,7 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 	if (srp) {
 		spin_lock_irqsave(&srp->req_lck, iflags);
 		spin_unlock(&sfp->rq_list_lock);
-	} else {	/* assume device (not just fd) scope */
+	} else if (h4p->flags & SGV4_FLAG_DEV_SCOPE) {
 		spin_unlock(&sfp->rq_list_lock);
 		read_lock(&sdp->sfd_llock);
 		list_for_each_entry(o_sfp, &sdp->sfds, sfd_entry) {
@@ -1836,16 +2142,18 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 			spin_unlock(&o_sfp->rq_list_lock);
 		}
 		read_unlock(&sdp->sfd_llock);
-	}
-	if (!srp)
+		if (!srp)
+			return -ENODATA;
+	} else {
+		spin_unlock(&sfp->rq_list_lock);
 		return -ENODATA;
-
+	}
 	set_bit(SG_FRQ_ABORTING, srp->frq_bm);
 	res = 0;
 	switch (atomic_read(&srp->rq_st)) {
 	case SG_RS_BUSY:
 		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
-		res = -EBUSY;	/* shouldn't occur often */
+		res = -EBUSY;	/* should not occur often */
 		break;
 	case SG_RS_INACTIVE:	/* inactive on rq_list not good */
 		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
@@ -1853,6 +2161,8 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 		break;
 	case SG_RS_AWAIT_RD:	/* user should still do completion */
 	case SG_RS_DONE_RD:
+	case SG_RS_SHR_SWAP:
+	case SG_RS_SHR_SLAVE:
 		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
 		break;		/* nothing to do here, return 0 */
 	case SG_RS_INFLIGHT:	/* only attempt abort if inflight */
@@ -1870,12 +2180,12 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 
 static int
 sg_idr_max_id(int id, void *p, void *data)
+	__must_hold(&sg_index_lock)
 {
 	int *k = data;
 
 	if (*k < id)
 		*k = id;
-
 	return 0;
 }
 
@@ -2031,8 +2341,10 @@ sg_fd_reshare(struct sg_fd *ma_sfp, int new_sl_fd)
 		res = -EPROTO;	/* Internal error */
 	rcu_read_lock();
 	rq_st = atomic_read(&ma_sfp->rsv_srp->rq_st);
-	if (rq_st != SG_RS_INACTIVE)
-		res = -EBUSY;
+	if (!(rq_st == SG_RS_INACTIVE || rq_st == SG_RS_SHR_SWAP))
+		res = -EBUSY;		/* master reserve buffer busy */
+	if (ma_sfp->slave_srp)
+		res = -EBUSY;	/* previous slave request not finished */
 	rcu_read_unlock();
 	if (unlikely(res))
 		return res;
@@ -2098,6 +2410,8 @@ sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
 	struct sg_request *t_srp;       /* other fl entries */
 	struct sg_device *sdp = sfp->parentdp;
 
+	if (sfp->shr_fd != SG_SHARE_FD_UNUSED)
+		return -EBUSY;	/* this fd can't be either side of share */
 	rcu_read_lock();
 	o_srp = sfp->rsv_srp;
 	if (!o_srp) {
@@ -2106,7 +2420,7 @@ sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
 	}
 	new_sz = min_t(int, want_rsv_sz, sdp->max_sgat_sz);
 	new_sz = max_t(int, new_sz, sfp->sgat_elem_sz);
-	blen = o_srp->sgat_h.buflen;
+	blen = o_srp->sgatp->buflen;
 	rcu_read_unlock();
 	SG_LOG(3, sdp, "%s: was=%d, ask=%d, new=%d (sgat_elem_sz=%d)\n",
 	       __func__, blen, want_rsv_sz, new_sz, sfp->sgat_elem_sz);
@@ -2129,7 +2443,7 @@ sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
 	}
 	use_new_srp = true;
 	list_for_each_entry(t_srp, &sfp->rq_fl, fl_entry) {
-		if (t_srp != o_srp && new_sz <= t_srp->sgat_h.buflen &&
+		if (t_srp != o_srp && new_sz <= t_srp->sgatp->buflen &&
 		    !SG_RS_ACTIVE(t_srp)) {
 			/* good candidate on free list, use */
 			use_new_srp = false;
@@ -2152,6 +2466,25 @@ sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
 	return res;
 }
 
+static bool
+sg_any_persistent_orphans(struct sg_fd *sfp)
+{
+	bool res = false;
+	struct sg_request *srp;
+
+	if (!test_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm))
+		return false;
+	rcu_read_lock();
+	list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+		if (test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm)) {
+			res = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return res;
+}
+
 /*
  * Processing of ioctl(SG_SET_GET_EXTENDED(SG_SEIM_CTL_FLAGS)) which is a set
  * of boolean flags. Access abbreviations: [rw], read-write; [ro], read-only;
@@ -2164,6 +2497,7 @@ sg_extended_bool_flags(struct sg_fd *sfp, struct sg_extended_info *seip)
 	u32 c_flgs_wm = seip->ctl_flags_wr_mask;
 	u32 c_flgs_rm = seip->ctl_flags_rd_mask;
 	u32 *c_flgsp = &seip->ctl_flags;
+	struct sg_fd *ma_sfp = sfp->share_sfp;
 	struct sg_device *sdp = sfp->parentdp;
 
 	/* TIME_IN_NS boolean, [raw] time in nanoseconds (def: millisecs) */
@@ -2186,6 +2520,13 @@ sg_extended_bool_flags(struct sg_fd *sfp, struct sg_extended_info *seip)
 		else
 			*c_flgsp &= ~SG_CTL_FLAGM_TAG_FOR_PACK_ID;
 	}
+	/* ORPHANS boolean, [ro] does this fd have any orphan requests? */
+	if (c_flgs_rm & SG_CTL_FLAGM_ORPHANS) {
+		if (sg_any_persistent_orphans(sfp))
+			*c_flgsp |= SG_CTL_FLAGM_ORPHANS;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_ORPHANS;
+	}
 	/* OTHER_OPENS boolean, [ro] any other sg open fds on this dev? */
 	if (c_flgs_rm & SG_CTL_FLAGM_OTHER_OPENS) {
 		if (atomic_read(&sdp->open_cnt) > 1)
@@ -2212,7 +2553,50 @@ sg_extended_bool_flags(struct sg_fd *sfp, struct sg_extended_info *seip)
 	if (c_flgs_wm & SG_CTL_FLAGM_UNSHARE)
 		sg_chk_unshare(sfp, !!(*c_flgsp & SG_CTL_FLAGM_UNSHARE));
 	if (c_flgs_rm & SG_CTL_FLAGM_UNSHARE)
-		*c_flgsp &= ~SG_CTL_FLAGM_UNSHARE;      /* clear bit */
+		*c_flgsp &= ~SG_CTL_FLAGM_UNSHARE;	/* clear bit */
+	/* IS_SHARE boolean: [ro] true if fd may be master or slave share */
+	if (c_flgs_rm & SG_CTL_FLAGM_IS_SHARE) {
+		if (sfp->shr_fd == SG_SHARE_FD_UNUSED)
+			*c_flgsp &= ~SG_CTL_FLAGM_IS_SHARE;
+		else
+			*c_flgsp |= SG_CTL_FLAGM_IS_SHARE;
+	}
+	/* IS_MASTER boolean: [ro] true if this fd may be a master share */
+	if (c_flgs_rm & SG_CTL_FLAGM_IS_MASTER) {
+		if (sfp->shr_fd == SG_SHARE_FD_MASTER)
+			*c_flgsp |= SG_CTL_FLAGM_IS_MASTER;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_IS_MASTER;
+	}
+	/*
+	 * MASTER_FINI boolean, [rbw] should be called by slave; when
+	 * reading: master is finished, awaiting action by slave;
+	 * when written: 1 --> slave doesn't want to continue
+	 */
+	if (c_flgs_rm & SG_CTL_FLAGM_MASTER_FINI) {
+		if (ma_sfp && ma_sfp->rsv_srp) {
+			struct sg_request *res_srp = ma_sfp->rsv_srp;
+
+			if (atomic_read(&res_srp->rq_st) == SG_RS_SHR_SWAP)
+				*c_flgsp |= SG_CTL_FLAGM_MASTER_FINI;
+			else
+				*c_flgsp &= ~SG_CTL_FLAGM_MASTER_FINI;
+		} else {
+			*c_flgsp &= ~SG_CTL_FLAGM_MASTER_FINI;
+		}
+	}
+	if (c_flgs_wm & SG_CTL_FLAGM_MASTER_FINI) {
+		bool ma_fini_wm = !!(*c_flgsp & SG_CTL_FLAGM_MASTER_FINI);
+
+		sg_change_after_master_rq(sfp, ma_fini_wm);
+	}
+	/* MASTER_ERR boolean, [ro] share: master finished with error */
+	if (c_flgs_rm & SG_CTL_FLAGM_MASTER_ERR) {
+		if (ma_sfp && test_bit(SG_FFD_MASTER_ERR, ma_sfp->ffd_bm))
+			*c_flgsp |= SG_CTL_FLAGM_MASTER_ERR;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_MASTER_ERR;
+	}
 	/* NO_DURATION boolean, [rbw] */
 	if (c_flgs_rm & SG_CTL_FLAGM_NO_DURATION)
 		flg = test_bit(SG_FFD_NO_DURATION, sfp->ffd_bm);
@@ -2399,7 +2783,7 @@ sg_ctl_extended(struct sg_fd *sfp, void __user *p)
 	}
 	if (s_rd_mask & SG_SEIM_RESERVED_SIZE)
 		seip->reserved_sz = (u32)min_t(int,
-					       sfp->rsv_srp->sgat_h.buflen,
+					       sfp->rsv_srp->sgatp->buflen,
 					       sdp->max_sgat_sz);
 	/* copy to user space if int or boolean read mask non-zero */
 	if (s_rd_mask || seip->ctl_flags_rd_mask) {
@@ -2553,8 +2937,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		if (test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm)) {
 			list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
 				if (SG_RS_AWAIT_READ(srp) &&
-				    !test_bit(SG_FRQ_SYNC_INVOC,
-					      srp->frq_bm)) {
+				    !SG_IS_SYNC_INVOC(srp)) {
 					val = srp->tag;
 					break;
 				}
@@ -2562,8 +2945,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		} else {
 			list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
 				if (SG_RS_AWAIT_READ(srp) &&
-				    !test_bit(SG_FRQ_SYNC_INVOC,
-					      srp->frq_bm)) {
+				    !SG_IS_SYNC_INVOC(srp)) {
 					val = srp->pack_id;
 					break;
 				}
@@ -2597,7 +2979,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		return res;
 	case SG_GET_RESERVED_SIZE:
 		mutex_lock(&sfp->f_mutex);
-		val = min_t(int, sfp->rsv_srp->sgat_h.buflen,
+		val = min_t(int, sfp->rsv_srp->sgatp->buflen,
 			    sdp->max_sgat_sz);
 		SG_LOG(3, sdp, "%s:    SG_GET_RESERVED_SIZE=%d\n",
 		       __func__, val);
@@ -2774,11 +3156,10 @@ sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	if (sdev->host->hostt->compat_ioctl) {
 		int ret;
 
-		ret = sdev->host->hostt->compat_ioctl(sdev, cmd_in, (void __user *)arg);
-
+		ret = sdev->host->hostt->compat_ioctl(sdev, cmd_in,
+						      uptr64(arg));
 		return ret;
 	}
-	
 	return -ENOIOCTLCMD;
 }
 #endif
@@ -2860,7 +3241,7 @@ sg_vma_fault(struct vm_fault *vmf)
 		goto out_err;
 	}
 	spin_lock_irqsave(&srp->req_lck, iflags);
-	rsv_schp = &srp->sgat_h;
+	rsv_schp = srp->sgatp;
 	offset = vmf->pgoff << PAGE_SHIFT;
 	if (unlikely(offset >= (unsigned int)rsv_schp->buflen)) {
 		SG_LOG(1, sdp, "%s: offset[%lu] >= rsv.buflen\n", __func__,
@@ -2928,7 +3309,7 @@ sg_mmap(struct file *filp, struct vm_area_struct *vma)
 		ret = -EBUSY;
 		goto out;
 	}
-	rsv_schp = &srp->sgat_h;
+	rsv_schp = srp->sgatp;
 	if (unlikely(req_sz > (unsigned long)rsv_schp->buflen)) {
 		ret = -ENOMEM;
 		goto out;
@@ -3072,9 +3453,11 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 			srp->in_resid = a_resid;
 		}
 	}
+	if (test_bit(SG_FRQ_ABORTING, srp->frq_bm) && srp->rq_result == 0)
+		srp->rq_result |= (DRIVER_HARD << 24);
 
-	SG_LOG(6, sdp, "%s: pack_id=%d, res=0x%x\n", __func__, srp->pack_id,
-	       srp->rq_result);
+	SG_LOG(6, sdp, "%s: pack_id=%d, tag=%d, res=0x%x\n", __func__,
+	       srp->pack_id, srp->tag, srp->rq_result);
 	if (srp->start_ns > 0)	/* zero only when SG_FFD_NO_DURATION is set */
 		srp->duration = sg_calc_rq_dur(srp, test_bit(SG_FFD_TIME_IN_NS,
 							     sfp->ffd_bm));
@@ -3083,7 +3466,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	if (slen > 0) {
 		if (scsi_rp->sense) {
 			srp->sense_bp = kzalloc(SCSI_SENSE_BUFFERSIZE,
-						GFP_ATOMIC);
+						GFP_ATOMIC /* <-- leave */);
 			if (srp->sense_bp)
 				memcpy(srp->sense_bp, scsi_rp->sense, slen);
 		} else {
@@ -3102,7 +3485,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 		}
 		spin_unlock(&srp->req_lck);
 	}
-	if (!test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
+	if (!SG_IS_SYNC_INVOC(srp))
 		atomic_inc(&sfp->waiting);
 	if (unlikely(sg_rstate_chg(srp, SG_RS_INFLIGHT, rqq_state)))
 		pr_warn("%s: can't set rq_st\n", __func__);
@@ -3250,7 +3633,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 		goto cdev_add_err;
 
 	sdp->cdev = cdev;
-	if (sg_sysfs_valid) {
+	if (likely(sg_sysfs_valid)) {
 		struct device *sg_class_member;
 
 		sg_class_member = device_create(sg_sysfs_class, cl_dev->parent,
@@ -3264,7 +3647,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 		}
 		error = sysfs_create_link(&scsidp->sdev_gendev.kobj,
 					  &sg_class_member->kobj, "generic");
-		if (error)
+		if (unlikely(error))
 			pr_err("%s: unable to make symlink 'generic' back "
 			       "to sg%d\n", __func__, sdp->index);
 	} else
@@ -3274,7 +3657,6 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 		    "type %d\n", sdp->index, scsidp->type);
 
 	dev_set_drvdata(cl_dev, sdp);
-
 	return 0;
 
 cdev_add_err:
@@ -3294,16 +3676,16 @@ static void
 sg_device_destroy(struct kref *kref)
 {
 	struct sg_device *sdp = container_of(kref, struct sg_device, d_ref);
-	unsigned long flags;
+	unsigned long iflags;
 
 	/* CAUTION!  Note that the device can still be found via idr_find()
 	 * even though the refcount is 0.  Therefore, do idr_remove() BEFORE
 	 * any other cleanup.
 	 */
 
-	write_lock_irqsave(&sg_index_lock, flags);
+	write_lock_irqsave(&sg_index_lock, iflags);
 	idr_remove(&sg_index_idr, sdp->index);
-	write_unlock_irqrestore(&sg_index_lock, flags);
+	write_unlock_irqrestore(&sg_index_lock, iflags);
 
 	SG_LOG(3, sdp, "%s: sdp=0x%p --\n", __func__, sdp);
 
@@ -3356,9 +3738,10 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(SG_VERSION_STR);
 MODULE_ALIAS_CHARDEV_MAJOR(SCSI_GENERIC_MAJOR);
 
-MODULE_PARM_DESC(scatter_elem_sz, "scatter gather element "
-                "size (default: max(SG_SCATTER_SZ, PAGE_SIZE))");
-MODULE_PARM_DESC(def_reserved_size, "size of buffer reserved for each fd");
+MODULE_PARM_DESC
+	(scatter_elem_sz,
+	 "scatter gather element size (def: max(SG_SCATTER_SZ, PAGE_SIZE))");
+MODULE_PARM_DESC(def_reserved_size, "size of request reserved for each fd");
 MODULE_PARM_DESC(allow_dio, "allow direct I/O (default: 0 (disallow))");
 
 static int __init
@@ -3424,6 +3807,33 @@ exit_sg(void)
 	idr_destroy(&sg_index_idr);
 }
 
+/*
+ * Setup to move data between kernel buffers managed by this driver and a SCSI
+ * device. Note that there is no corresponding 'unmap' call as is required by
+ * blk_rq_map_user() . blk_rq has already been told direction of transfer.
+ */
+static int
+sg_rq_map_kern(struct sg_request *srp, struct request_queue *q,
+	       struct request *rq)
+{
+	int k, pg_sz, dlen, ln;
+	int res = 0;
+	struct sg_scatter_hold *schp = srp->sgatp;
+
+	dlen = schp->dlen;
+	pg_sz = 1 << (PAGE_SHIFT + schp->page_order);
+	SG_LOG(4, srp->parentfp->parentdp, "%s: dlen=%d, pg_sz=%d\n",
+	       __func__, dlen, pg_sz);
+	for (k = 0; k < schp->num_sgat && dlen > 0; ++k, dlen -= ln) {
+		ln = min_t(int, dlen, pg_sz);
+		res = blk_rq_map_kern(q, rq, page_address(schp->pages[k]),
+				      ln, GFP_ATOMIC);
+		if (unlikely(res))
+			break;
+	}
+	return res;
+}
+
 static inline bool
 sg_chk_dio_allowed(struct sg_device *sdp, struct sg_fd *sfp,
 		   struct sg_request *srp, int iov_count, int dir)
@@ -3543,7 +3953,7 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 	reserved = (sfp->rsv_srp == srp);
 	rq->end_io_data = srp;
 	scsi_rp->retries = SG_DEFAULT_RETRIES;
-	req_schp = &srp->sgat_h;
+	req_schp = srp->sgatp;
 
 	if (dxfer_len <= 0 || dxfer_dir == SG_DXFER_NONE) {
 		SG_LOG(4, sdp, "%s: no data xfer [0x%p]\n", __func__, srp);
@@ -3602,6 +4012,9 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 		if (IS_ENABLED(CONFIG_SCSI_PROC_FS) && res)
 			SG_LOG(1, sdp, "%s: blk_rq_map_user() res=%d\n",
 			       __func__, res);
+	} else {
+		/* transfer data to/from kernel buffers */
+		res = sg_rq_map_kern(srp, q, rq);
 	}
 fini:
 	if (likely(res == 0)) {
@@ -3617,8 +4030,8 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 			blk_put_request(rq);
 		}
 	}
-	SG_LOG((res ? 1 : 4), sdp, "%s: %s res=%d [0x%p]\n", __func__, cp,
-	       res, srp);
+	SG_LOG((res ? 1 : 4), sdp, "%s: %s %s res=%d [0x%p]\n", __func__,
+	       sg_shr_str(srp->sh_var, false), cp, res, srp);
 	return res;
 }
 
@@ -3637,7 +4050,7 @@ sg_finish_scsi_blk_rq(struct sg_request *srp)
 
 	SG_LOG(4, sfp->parentdp, "%s: srp=0x%p%s\n", __func__, srp,
 	       (srp->parentfp->rsv_srp == srp) ? " rsv" : "");
-	if (!test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm)) {
+	if (!SG_IS_SYNC_INVOC(srp)) {
 		atomic_dec(&sfp->submitted);
 		atomic_dec(&sfp->waiting);
 	}
@@ -3681,7 +4094,7 @@ sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen)
 	gfp_t mask_ap = GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN | __GFP_ZERO;
 	gfp_t mask_kz = GFP_ATOMIC | __GFP_NOWARN;
 	struct sg_device *sdp = sfp->parentdp;
-	struct sg_scatter_hold *schp = &srp->sgat_h;
+	struct sg_scatter_hold *schp = srp->sgatp;
 
 	if (unlikely(m_size < 0))
 		return -EFAULT;
@@ -3789,7 +4202,7 @@ sg_rd_append(struct sg_request *srp, void __user *outp, int num_xfer)
 {
 	int k, num, res;
 	struct page *pgp;
-	struct sg_scatter_hold *schp = &srp->sgat_h;
+	struct sg_scatter_hold *schp = srp->sgatp;
 
 	SG_LOG(4, srp->parentfp->parentdp, "%s: num_xfer=%d\n", __func__,
 	       num_xfer);
@@ -3842,7 +4255,7 @@ sg_find_srp_by_id(struct sg_fd *sfp, int id, bool is_tag)
 	rcu_read_lock();
 	if (unlikely(search_for_1)) {
 		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
-			if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
+			if (SG_IS_SYNC_INVOC(srp))
 				continue;
 			if (is_tag) {
 				if (srp->tag != id)
@@ -3863,6 +4276,8 @@ sg_find_srp_by_id(struct sg_fd *sfp, int id, bool is_tag)
 					bad_sr_st = atomic_read(&srp->rq_st);
 				}
 				break;
+			case SG_RS_SHR_SLAVE:
+				goto good;
 			case SG_RS_INFLIGHT:
 				break;
 			default:
@@ -3876,7 +4291,7 @@ sg_find_srp_by_id(struct sg_fd *sfp, int id, bool is_tag)
 		}
 	} else {        /* search for any request is more likely */
 		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
-			if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
+			if (SG_IS_SYNC_INVOC(srp))
 				continue;
 			sr_st = atomic_read(&srp->rq_st);
 			if (sr_st == SG_RS_AWAIT_RD) {
@@ -3932,8 +4347,10 @@ sg_mk_srp(struct sg_fd *sfp, bool first)
 	if (srp) {
 		spin_lock_init(&srp->req_lck);
 		atomic_set(&srp->rq_st, SG_RS_INACTIVE);
+		srp->sh_var =  SG_SHR_NONE;
 		srp->parentfp = sfp;
 		srp->tag = SG_TAG_WILDCARD;
+		srp->sgatp = &srp->sgat_h; /* only slave share changes sgatp */
 		return srp;
 	} else {
 		return ERR_PTR(-ENOMEM);
@@ -3962,7 +4379,7 @@ sg_mk_srp_sgat(struct sg_fd *sfp, bool first, int db_len)
  * Irrespective of the given reserve request size, the minimum size requested
  * will be PAGE_SIZE (often 4096 bytes). Returns a pointer to reserve object or
  * a negated errno value twisted by ERR_PTR() macro. The actual number of bytes
- * allocated (maybe less than buflen) is in srp->sgat_h.buflen . Note that this
+ * allocated (maybe less than buflen) is in srp->sgatp->buflen . Note that this
  * function is only called in contexts where locking is not required.
  */
 static struct sg_request *
@@ -4005,31 +4422,130 @@ sg_build_reserve(struct sg_fd *sfp, int buflen)
  * failure returns a negated errno value twisted by ERR_PTR() macro.
  */
 static struct sg_request *
-sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
+sg_add_request(struct sg_comm_wr_t *cwrp, enum sg_shr_var sh_var, int dxfr_len)
 {
 	bool act_empty = false;
+	bool allow_rsv = true;
 	bool mk_new_srp = true;
+	bool sl_req = false;
 	u32 sum_dlen;
 	unsigned long iflags;
 	enum sg_rq_state sr_st;
+	enum sg_rq_state ma_sr_st;
 	struct sg_fd *fp = cwrp->sfp;
 	struct sg_request *r_srp = NULL;	/* request to return */
 	struct sg_request *rsv_srp;	/* current fd's reserve request */
+	struct sg_request *uninitialized_var(ma_rsv_srp);
+	struct sg_fd *uninitialized_var(ma_sfp);
 	__maybe_unused struct sg_device *sdp;
 	__maybe_unused const char *cp;
+	char b[48];
 
 	spin_lock_irqsave(&fp->rq_list_lock, iflags);
+	b[0] = '\0';
 	sdp = fp->parentdp;
 	rsv_srp = fp->rsv_srp;
+
+	switch (sh_var) {
+	case SG_SHR_NONE:
+	case SG_SHR_SL_FD_NOT_RQ:
+		break;
+	case SG_SHR_MA_RQ:
+		sr_st = atomic_read(&rsv_srp->rq_st);
+		if (sr_st == SG_RS_INACTIVE) {
+			if (likely(sg_rstate_chg(rsv_srp, sr_st,
+						 SG_RS_BUSY) == 0)) {
+				r_srp = rsv_srp;
+				mk_new_srp = false;
+				cp = "ma_rq";
+				goto good_fini;
+			}
+		}
+		r_srp = ERR_PTR(-EBUSY);
+		break;
+	case SG_SHR_MA_FD_NOT_RQ:
+		allow_rsv = false;
+		break;
+	case SG_SHR_SL_RQ:
+		ma_sfp = fp->share_sfp;
+		if (!ma_sfp) {
+			r_srp = ERR_PTR(-EPROTO);
+			break;
+		}
+		/*
+		 * Contention here may be with another potential slave trying
+		 * to pair with this master. The loser will receive an
+		 * EADDRINUSE errno. The winner advances master's rq_state:
+		 *     SG_RS_SHR_SWAP --> SG_RS_SHR_SLAVE
+		 */
+		ma_rsv_srp = ma_sfp->rsv_srp;
+		ma_sr_st = atomic_read(&ma_rsv_srp->rq_st);
+		switch (ma_sr_st) {
+		case SG_RS_AWAIT_RD:
+		case SG_RS_DONE_RD:
+			if (ma_rsv_srp->rq_result & SG_ML_RESULT_MSK) {
+				r_srp = ERR_PTR(-ENOSTR);
+				break;
+			}
+			/* fallthrough */
+		case SG_RS_SHR_SWAP:
+			sl_req = true;
+			if (ma_sr_st == SG_RS_AWAIT_RD)
+				break;
+			if (unlikely(sg_rstate_chg(ma_rsv_srp, ma_sr_st,
+						   SG_RS_SHR_SLAVE) != 0))
+				r_srp = ERR_PTR(-EADDRINUSE);
+			break;
+		case  SG_RS_INFLIGHT:
+			sl_req = true;
+			break;
+		case SG_RS_INACTIVE:
+			r_srp = ERR_PTR(-EADDRNOTAVAIL);
+			break;
+		case SG_RS_BUSY:
+			r_srp = ERR_PTR(-EBUSY);
+			break;
+		case SG_RS_SHR_SLAVE:
+		default:
+			r_srp = ERR_PTR(-EADDRINUSE);
+			break;
+		}
+		break;
+	}
+	if (IS_ERR(r_srp)) {
+		if (sh_var == SG_SHR_MA_RQ)
+			snprintf(b, sizeof(b), "SG_SHR_MA_RQ --> sr_st=%s",
+				 sg_rq_st_str(sr_st, false));
+		else if (sh_var == SG_SHR_SL_RQ && ma_sfp)
+			snprintf(b, sizeof(b), "SG_SHR_SL_RQ-->ma_sr_st=%s",
+				 sg_rq_st_str(ma_sr_st, false));
+		else
+			snprintf(b, sizeof(b), "sh_var=%s",
+				 sg_shr_str(sh_var, false));
+		goto err_out;
+	}
 	cp = "";
+	if (sl_req) {	/* slave dlen may be smaller than master's dlen */
+		if (dxfr_len > ma_rsv_srp->sgatp->dlen) {
+			SG_LOG(4, sdp, "%s: slave dlen [%d] > master dlen\n",
+			       __func__, dxfr_len);
+			r_srp = ERR_PTR(-E2BIG);
+			goto err_out;
+		}
+		dxfr_len = 0;	/* any srp for slave will do, pick smallest */
+	}
+
 	/*
-	 * Check the free list (fl) for candidates. Pick zero data length
+	 * Check the free list (fl) for candidates. If SG_SHR_MA_FD_NOT_RQ
+	 * then do not re-use the reserve request. Pick zero data length
 	 * requests from the back of the fl, the rest from the front.
 	 */
-	if (list_empty(&fp->rq_fl)) {
+	if (list_empty(&fp->rq_fl))
 		act_empty = true;
-	} else if (dxfr_len < 1) {  /* 0 data length requests at back of fl */
+	else if (dxfr_len < 1) {    /* 0 data length requests at back of fl */
 		list_for_each_entry_reverse(r_srp, &fp->rq_fl, fl_entry) {
+			if (!allow_rsv && rsv_srp == r_srp)
+				continue;
 			sr_st = atomic_read(&r_srp->rq_st);
 			if (sr_st == SG_RS_INACTIVE) {
 				if (likely(sg_rstate_chg(r_srp, sr_st,
@@ -4042,9 +4558,11 @@ sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
 		}
 	} else { /*     find request with large enough dlen */
 		list_for_each_entry(r_srp, &fp->rq_fl, fl_entry) {
+			if (!allow_rsv && rsv_srp == r_srp)
+				continue;
 			sr_st = atomic_read(&r_srp->rq_st);
 			if (sr_st == SG_RS_INACTIVE &&
-			    r_srp->sgat_h.buflen >= dxfr_len) {
+			    r_srp->sgatp->buflen >= dxfr_len) {
 				if (likely(sg_rstate_chg(r_srp, sr_st,
 							 SG_RS_BUSY) == 0)) {
 					cp = "from front of fl";
@@ -4055,6 +4573,7 @@ sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
 		}
 	}
 
+good_fini:
 	if (mk_new_srp) {	/* Need new sg_request object */
 		bool allow_cmd_q = test_bit(SG_FFD_CMD_Q, fp->ffd_bm);
 
@@ -4090,20 +4609,27 @@ sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
 	if (!mk_new_srp)
 		spin_lock(&r_srp->req_lck);
 	r_srp->frq_bm[0] = cwrp->frq_bm[0];	/* assumes <= 32 req flags */
-	r_srp->sgat_h.dlen = dxfr_len;/* must be <= r_srp->sgat_h.buflen */
+	r_srp->sgatp->dlen = dxfr_len;/* must be <= r_srp->sgatp->buflen */
+	r_srp->sh_var = sh_var;
 	r_srp->cmd_opcode = 0xff;  /* set invalid opcode (VS), 0x0 is TUR */
 	/* If setup stalls (e.g. blk_get_request()) debug shows 'elap=1 ns' */
 	if (test_bit(SG_FFD_TIME_IN_NS, fp->ffd_bm))
 		r_srp->start_ns = U64_MAX;
+	if (sl_req && ma_rsv_srp) {
+		ma_sfp->slave_srp = r_srp;
+		/* slave "shares" the master reserve request's data buffer */
+		r_srp->sgatp = &ma_rsv_srp->sgat_h;
+	}
 	if (mk_new_srp)
 		spin_lock_irqsave(&fp->rq_list_lock, iflags);
 	list_add_tail_rcu(&r_srp->rq_entry, &fp->rq_list);
 	if (!mk_new_srp)
 		spin_unlock(&r_srp->req_lck);
+err_out:
 	spin_unlock_irqrestore(&fp->rq_list_lock, iflags);
 err_no_lock:
-	if (IS_ERR(r_srp))
-		SG_LOG(1, sdp, "%s: err=%ld\n", __func__, PTR_ERR(r_srp));
+	if (IS_ERR(r_srp) && b[0])
+		SG_LOG(1, sdp, "%s: bad %s\n", __func__, b);
 	if (!IS_ERR(r_srp))
 		SG_LOG(4, sdp, "%s: %s %sr_srp=0x%p\n", __func__, cp,
 		       ((r_srp == rsv_srp) ? "[rsv] " : ""), r_srp);
@@ -4122,10 +4648,11 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	bool on_fl = false;
 	int dlen, buflen;
 	unsigned long iflags;
+	enum sg_rq_state sr_st;
 	u8 *sbp;
 	struct sg_request *t_srp;
 	struct sg_scatter_hold *schp;
-	const char *cp = "head";
+	__maybe_unused const char *cp = "head";
 
 	if (WARN_ON(!sfp || !srp))
 		return;
@@ -4133,7 +4660,9 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	sbp = srp->sense_bp;
 	srp->sense_bp = NULL;
-	atomic_set(&srp->rq_st, SG_RS_BUSY);
+	sr_st = atomic_read(&srp->rq_st);
+	if (sr_st != SG_RS_SHR_SWAP) /* mark _BUSY then _INACTIVE at end */
+		atomic_set(&srp->rq_st, SG_RS_BUSY);
 	list_del_rcu(&srp->rq_entry);
 	kfree(sbp);	/* maybe orphaned req, thus never read */
 	/*
@@ -4166,7 +4695,10 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	SG_LOG(5, sfp->parentdp, "%s: %ssrp=0x%p move to fl %s\n", __func__,
 	       ((sfp->rsv_srp == srp) ? "rsv " : ""), srp, cp);
 	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	atomic_set(&srp->rq_st, SG_RS_INACTIVE);
+	if (sr_st != SG_RS_SHR_SWAP) {
+		atomic_set(&srp->rq_st, SG_RS_INACTIVE);
+		srp->tag = SG_TAG_WILDCARD;
+	}
 }
 
 /* Returns pointer to sg_fd object or negated errno twisted by ERR_PTR */
@@ -4218,6 +4750,7 @@ sg_add_sfp(struct sg_device *sdp, struct file *filp)
 		SG_LOG(1, sdp, "%s: detaching\n", __func__);
 		return ERR_PTR(-ENODEV);
 	}
+	sg_unshare_fds(sfp, NULL);
 	if (unlikely(sg_big_buff != def_reserved_size))
 		sg_big_buff = def_reserved_size;
 
@@ -4231,11 +4764,11 @@ sg_add_sfp(struct sg_device *sdp, struct file *filp)
 			       -err);
 			return ERR_PTR(err);
 		}
-		if (srp->sgat_h.buflen < rbuf_len) {
+		if (srp->sgatp->buflen < rbuf_len) {
 			reduced = true;
 			SG_LOG(2, sdp,
 			       "%s: reserve reduced from %d to buflen=%d\n",
-			       __func__, rbuf_len, srp->sgat_h.buflen);
+			       __func__, rbuf_len, srp->sgatp->buflen);
 		}
 		/* will be first element so head or tail doesn't matter */
 		list_add_tail_rcu(&srp->fl_entry, &sfp->rq_fl);
@@ -4284,7 +4817,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			continue;
 		sg_finish_scsi_blk_rq(srp);
 		list_del(&srp->rq_entry);
-		if (srp->sgat_h.buflen > 0)
+		if (srp->sgatp->buflen > 0)
 			sg_remove_sgat(srp);
 		kfree(srp->sense_bp);	/* abnormal close: device detached */
 		SG_LOG(6, sdp, "%s:%s%p --\n", __func__, cp, srp);
@@ -4296,7 +4829,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		if (!srp)
 			continue;
 		list_del(&srp->fl_entry);
-		if (srp->sgat_h.buflen > 0)
+		if (srp->sgatp->buflen > 0)
 			sg_remove_sgat(srp);
 		kfree(srp->sense_bp);
 		SG_LOG(6, sdp, "%s: fl%s%p --\n", __func__, cp, srp);
@@ -4318,7 +4851,14 @@ sg_remove_sfp(struct kref *kref)
 	unsigned long iflags;
 	struct sg_fd *sfp = container_of(kref, struct sg_fd, f_ref);
 	struct sg_device *sdp = sfp->parentdp;
+	struct sg_fd *o_sfp = (sfp->shr_fd != SG_SHARE_FD_UNUSED) ?
+				sfp->share_sfp : NULL;
 
+	if (o_sfp && !test_bit(SG_FFD_RELEASE, o_sfp->ffd_bm)) {
+		mutex_lock(&o_sfp->f_mutex);
+		sg_remove_sfp_share(sfp);
+		mutex_unlock(&o_sfp->f_mutex);
+	}
 	write_lock_irqsave(&sdp->sfd_llock, iflags);
 	list_del(&sfp->sfd_entry);
 	write_unlock_irqrestore(&sdp->sfd_llock, iflags);
@@ -4327,9 +4867,9 @@ sg_remove_sfp(struct kref *kref)
 	schedule_work(&sfp->ew_fd.work);
 }
 
-/* must be called with sg_index_lock held */
 static struct sg_device *
 sg_lookup_dev(int dev)
+	__must_hold(&sg_index_lock)
 {
 	return idr_find(&sg_index_idr, dev);
 }
@@ -4374,19 +4914,50 @@ sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 		return long_str ? "done_read" : "fin";
 	case SG_RS_BUSY:
 		return long_str ? "busy" : "bsy";
+	case SG_RS_SHR_SWAP:	/* only an active master has this */
+		return long_str ? "share swap" : "s_wp";
+	case SG_RS_SHR_SLAVE:	/* only an active master has this */
+		return long_str ? "share slave active" : "sl_a";
+	default:
+		return long_str ? "unknown" : "unk";
+	}
+}
+
+static const char *
+sg_shr_str(enum sg_shr_var sh_var, bool long_str)
+{
+	switch (sh_var) {	/* share variety of request */
+	case SG_SHR_NONE:
+		return long_str ? "none" :  "-";
+	case SG_SHR_MA_RQ:
+		return long_str ? "master request" :  "m_rq";
+	case SG_SHR_MA_FD_NOT_RQ:
+		return long_str ? "master fd, not request" :  "m_nr";
+	case SG_SHR_SL_RQ:
+		return long_str ? "slave request" :  "s_rq";
+	case SG_SHR_SL_FD_NOT_RQ:
+		return long_str ? "slave fd, not request" :  "s_nr";
 	default:
 		return long_str ? "unknown" : "unk";
 	}
 }
+
 #else
+
 static const char *
 sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 {
 	return "";
 }
+
+static const char *
+sg_shr_str(enum sg_shr_var sh_var, bool long_str)
+{
+	return "";
+}
 #endif
 
-#if IS_ENABLED(CONFIG_SCSI_PROC_FS)     /* long, almost to end of file */
+#if IS_ENABLED(CONFIG_SCSI_PROC_FS)	/* long, almost to end of file */
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
 static int sg_proc_single_open_adio(struct inode *inode, struct file *filp);
@@ -4402,8 +4973,9 @@ static const struct file_operations adio_fops = {
 };
 
 static int sg_proc_single_open_dressz(struct inode *inode, struct file *filp);
-static ssize_t sg_proc_write_dressz(struct file *filp, 
-		const char __user *buffer, size_t count, loff_t *off);
+static ssize_t sg_proc_write_dressz(struct file *filp,
+				    const char __user *buffer, size_t count,
+				    loff_t *off);
 static const struct file_operations dressz_fops = {
 	.owner = THIS_MODULE,
 	.open = sg_proc_single_open_dressz,
@@ -4416,6 +4988,7 @@ static const struct file_operations dressz_fops = {
 static int sg_proc_seq_show_version(struct seq_file *s, void *v);
 static int sg_proc_seq_show_devhdr(struct seq_file *s, void *v);
 static int sg_proc_seq_show_dev(struct seq_file *s, void *v);
+
 static void * dev_seq_start(struct seq_file *s, loff_t *pos);
 static void * dev_seq_next(struct seq_file *s, void *v, loff_t *pos);
 static void dev_seq_stop(struct seq_file *s, void *v);
@@ -4534,7 +5107,7 @@ sg_proc_write_dressz(struct file *filp, const char __user *buffer,
 		sg_big_buff = k;
 		return count;
 	}
-	return -ERANGE;
+	return -EDOM;
 }
 
 static int
@@ -4553,8 +5126,8 @@ sg_proc_seq_show_devhdr(struct seq_file *s, void *v)
 }
 
 struct sg_proc_deviter {
-	loff_t	index;
-	size_t	max;
+	loff_t index;
+	size_t max;
 	int fd_index;
 };
 
@@ -4569,7 +5142,7 @@ dev_seq_start(struct seq_file *s, loff_t *pos)
 
 	it->index = *pos;
 	it->max = sg_last_dev();
-	if (it->index >= it->max)
+	if (it->index >= (int)it->max)
 		return NULL;
 	return it;
 }
@@ -4605,11 +5178,11 @@ sg_proc_seq_show_dev(struct seq_file *s, void *v)
 		scsidp = sdp->device;
 		seq_printf(s, "%d\t%d\t%d\t%llu\t%d\t%d\t%d\t%d\t%d\n",
 			      scsidp->host->host_no, scsidp->channel,
-			      scsidp->id, scsidp->lun, (int) scsidp->type,
+			      scsidp->id, scsidp->lun, (int)scsidp->type,
 			      1,
-			      (int) scsidp->queue_depth,
-			      (int) atomic_read(&scsidp->device_busy),
-			      (int) scsi_device_online(scsidp));
+			      (int)scsidp->queue_depth,
+			      (int)atomic_read(&scsidp->device_busy),
+			      (int)scsi_device_online(scsidp));
 	}
 	read_unlock_irqrestore(&sg_index_lock, iflags);
 	return 0;
@@ -4661,8 +5234,8 @@ sg_proc_dbg_sreq(struct sg_request *srp, int to, bool t_in_ns, char *obp,
 	rq_st = atomic_read(&srp->rq_st);
 	dur = sg_get_dur(srp, &rq_st, t_in_ns, &is_dur);
 	n += scnprintf(obp + n, len - n, "%s%s: dlen=%d/%d id=%d", cp,
-		       sg_rq_st_str(rq_st, false), srp->sgat_h.dlen,
-		       srp->sgat_h.buflen, (int)srp->pack_id);
+		       sg_rq_st_str(rq_st, false), srp->sgatp->dlen,
+		       srp->sgatp->buflen, (int)srp->pack_id);
 	if (is_dur)	/* cmd/req has completed, waiting for ... */
 		n += scnprintf(obp + n, len - n, " dur=%u%s", dur, tp);
 	else if (dur < U32_MAX) { /* in-flight or busy (so ongoing) */
@@ -4673,8 +5246,11 @@ sg_proc_dbg_sreq(struct sg_request *srp, int to, bool t_in_ns, char *obp,
 		n += scnprintf(obp + n, len - n, " t_o/elap=%us/%u%s",
 			       to / 1000, dur, tp);
 	}
+	if (srp->sh_var != SG_SHR_NONE)
+		n += scnprintf(obp + n, len - n, " shr=%s",
+			       sg_shr_str(srp->sh_var, false));
 	n += scnprintf(obp + n, len - n, " sgat=%d op=0x%02x\n",
-		       srp->sgat_h.num_sgat, srp->cmd_opcode);
+		       srp->sgatp->num_sgat, srp->cmd_opcode);
 	return n;
 }
 
@@ -4686,16 +5262,22 @@ sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len, bool reduced)
 	bool first_fl;
 	int n = 0;
 	int to;
+	const char *cp;
 	struct sg_request *srp;
 
+	if (fp->shr_fd == SG_SHARE_FD_UNUSED)
+		cp = "";
+	else
+		cp = (fp->shr_fd == SG_SHARE_FD_MASTER) ?
+			" shr_mast" : " shr_slv";
 	/* sgat=-1 means unavailable */
 	to = jiffies_to_msecs(fp->timeout);
 	if (to % 1000)
 		n += scnprintf(obp + n, len - n, "timeout=%dms rs", to);
 	else
 		n += scnprintf(obp + n, len - n, "timeout=%ds rs", to / 1000);
-	n += scnprintf(obp + n, len - n, "v_buflen=%d\n   cmd_q=%d ",
-		       fp->rsv_srp->sgat_h.buflen,
+	n += scnprintf(obp + n, len - n, "v_buflen=%d%s\n   cmd_q=%d ",
+		       fp->rsv_srp->sgatp->buflen, cp,
 		       (int)test_bit(SG_FFD_CMD_Q, fp->ffd_bm));
 	n += scnprintf(obp + n, len - n,
 		       "f_packid=%d k_orphan=%d ffd_bm=0x%lx\n",
@@ -4803,10 +5385,10 @@ sg_proc_seq_show_dbg(struct seq_file *s, void *v, bool reduced)
 	if (!list_empty(&sdp->sfds)) {
 		found = true;
 		disk_name = (sdp->disk ? sdp->disk->disk_name : "?_?");
-		if (atomic_read(&sdp->detaching))
+		if (atomic_read(&sdp->detaching)) {
 			snprintf(b1, sizeof(b1), " >>> device=%s  %s\n",
 				 disk_name, "detaching pending close\n");
-		else if (sdp->device) {
+		} else if (sdp->device) {
 			n = sg_proc_dbg_sdev(sdp, bp, bp_len, fdi_p, reduced);
 			if (n >= bp_len - 1) {
 				trunc = true;
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index a3fa26644496..19d7321e7df6 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -110,6 +110,9 @@ typedef struct sg_io_hdr {
 #define SGV4_FLAG_Q_AT_TAIL SG_FLAG_Q_AT_TAIL
 #define SGV4_FLAG_Q_AT_HEAD SG_FLAG_Q_AT_HEAD
 #define SGV4_FLAG_IMMED 0x400 /* for polling with SG_IOR, ignored in SG_IOS */
+#define SGV4_FLAG_DEV_SCOPE 0x1000 /* permit SG_IOABORT to have wider scope */
+#define SGV4_FLAG_SHARE 0x2000	/* share IO buffer; needs SG_SEIM_SHARE_FD */
+#define SGV4_FLAG_NO_DXFER SG_FLAG_NO_DXFER	/* needed for sharing */
 
 /* Output (potentially OR-ed together) in v3::info or v4::info field */
 #define SG_INFO_OK_MASK 0x1
@@ -181,7 +184,12 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 #define SG_CTL_FLAGM_OTHER_OPENS 0x4	/* rd: other sg fd_s on this dev */
 #define SG_CTL_FLAGM_ORPHANS	0x8	/* rd: orphaned requests on this fd */
 #define SG_CTL_FLAGM_Q_TAIL	0x10	/* used for future cmds on this fd */
+#define SG_CTL_FLAGM_IS_SHARE	0x20	/* rd: fd is master or slave share */
+#define SG_CTL_FLAGM_IS_MASTER	0x40	/* rd: this fd is share master */
 #define SG_CTL_FLAGM_UNSHARE	0x80	/* undo share after inflight cmd */
+/* rd> 1: master finished 0: not; wr> 1: finish share post master */
+#define SG_CTL_FLAGM_MASTER_FINI 0x100	/* wr> 0: setup for repeat slave req */
+#define SG_CTL_FLAGM_MASTER_ERR 0x200	/* rd: sharing, master got error */
 #define SG_CTL_FLAGM_NO_DURATION 0x400	/* don't calc command duration */
 #define SG_CTL_FLAGM_MORE_ASYNC	0x800	/* yield EAGAIN in more cases */
 #define SG_CTL_FLAGM_ALL_BITS	0xfff	/* should be OR of previous items */
-- 
2.17.1

