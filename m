Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBC4FB1E1
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Apr 2022 04:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiDKCel (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 Apr 2022 22:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbiDKCcZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 10 Apr 2022 22:32:25 -0400
Received: from smtp.infotech.no (smtp.infotech.no [82.134.31.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 324EB38BEA
        for <linux-scsi@vger.kernel.org>; Sun, 10 Apr 2022 19:29:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id A015E2041E3;
        Mon, 11 Apr 2022 04:29:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2AJkkeJukcOS; Mon, 11 Apr 2022 04:29:27 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        by smtp.infotech.no (Postfix) with ESMTPA id 072822041CB;
        Mon, 11 Apr 2022 04:29:26 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org
Subject: [PATCH v24 40/46] sg: remove rcv_done request state
Date:   Sun, 10 Apr 2022 22:28:30 -0400
Message-Id: <20220411022836.11871-41-dgilbert@interlog.com>
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

Remove SG_RQ_RCV_DONE request state. Also remember the position of
the last used request array element and start subsequent searches
for completed requests and new requests from that index.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 166 +++++++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 70 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index e10148f2fba3..b9fdfcfc18ee 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -94,7 +94,6 @@ enum sg_rq_state {	/* N.B. sg_rq_state_arr assumes SG_RS_AWAIT_RCV==2 */
 	SG_RS_INACTIVE = 0,	/* request not in use (e.g. on fl) */
 	SG_RS_INFLIGHT,		/* active: cmd/req issued, no response yet */
 	SG_RS_AWAIT_RCV,	/* have response from LLD, awaiting receive */
-	SG_RS_RCV_DONE,		/* receive is ongoing or done */
 	SG_RS_BUSY,		/* temporary state should rarely be seen */
 };
 
@@ -229,6 +228,7 @@ struct sg_fd {		/* holds the state of a file descriptor */
 	struct mutex f_mutex;	/* serialize ioctls on this fd */
 	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
+	int prev_used_idx;	/* previous used index */
 	u32 idx;		/* my index within parent's sfp_arr */
 	atomic_t submitted;	/* number inflight or awaiting receive */
 	atomic_t waiting;	/* number of requests awaiting receive */
@@ -302,7 +302,9 @@ static struct sg_device *sg_get_dev(int min_dev);
 static void sg_device_destroy(struct kref *kref);
 static struct sg_request *sg_mk_srp_sgat(struct sg_fd *sfp, bool first,
 					 int db_len);
+#if IS_ENABLED(CONFIG_SCSI_LOGGING) && IS_ENABLED(SG_DEBUG)
 static const char *sg_rq_st_str(enum sg_rq_state rq_st, bool long_str);
+#endif
 
 #define SG_WRITE_COUNT_LIMIT (32 * 1024 * 1024)
 
@@ -872,20 +874,18 @@ sg_ctl_iosubmit_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
 #if IS_ENABLED(SG_LOG_ACTIVE)
 static void
 sg_rq_state_fail_msg(struct sg_fd *sfp, enum sg_rq_state exp_old_st,
-		     enum sg_rq_state want_st, enum sg_rq_state act_old_st,
-		     const char *fromp)
+		     enum sg_rq_state want_st, const char *fromp)
 {
-	const char *eaw_rs = "expected_old,actual_old,wanted rq_st";
+	const char *eaw_rs = "expected_old,wanted rq_st";
 
 	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
-		SG_LOG(1, sfp, "%s: %s: %s: %s,%s,%s\n",
+		SG_LOG(1, sfp, "%s: %s: %s,%s,%s\n",
 		       __func__, fromp, eaw_rs,
 		       sg_rq_st_str(exp_old_st, false),
-		       sg_rq_st_str(act_old_st, false),
 		       sg_rq_st_str(want_st, false));
 	else
-		pr_info("sg: %s: %s: %s: %d,%d,%d\n", __func__, fromp, eaw_rs,
-			(int)exp_old_st, (int)act_old_st, (int)want_st);
+		pr_info("sg: %s: %s: %s: %d,%d\n", __func__, fromp, eaw_rs,
+			(int)exp_old_st, (int)want_st);
 }
 #endif
 
@@ -929,8 +929,8 @@ sg_rq_state_helper(struct xarray *xafp, struct sg_request *srp, int indic)
 }
 
 /* Following array indexed by enum sg_rq_state, 0 means no xa mark change */
-static const int sg_rq_state_arr[] = {1, 0, 4, 0, 0};
-static const int sg_rq_state_mul2arr[] = {2, 0, 8, 0, 0};
+static const int sg_rq_state_arr[] = {1, 0, 4, 0};
+static const int sg_rq_state_mul2arr[] = {2, 0, 8, 0};
 
 /*
  * This function keeps the srp->rq_st state and associated marks on the
@@ -945,39 +945,47 @@ static const int sg_rq_state_mul2arr[] = {2, 0, 8, 0, 0};
  */
 static int
 sg_rq_state_chg(struct sg_request *srp, enum sg_rq_state old_st,
-		enum sg_rq_state new_st, bool force, const char *fromp)
+		enum sg_rq_state new_st)
 {
 	enum sg_rq_state act_old_st;
 	int indic;
 	unsigned long iflags;
-	struct xarray *xafp = &srp->parentfp->srp_arr;
+	struct sg_fd *sfp = srp->parentfp;
+	struct xarray *xafp = &sfp->srp_arr;
 
-	if (force) {
-		xa_lock_irqsave(xafp, iflags);
-		sg_rq_state_force(srp, new_st);
-		xa_unlock_irqrestore(xafp, iflags);
-		return 0;
-	}
 	indic = sg_rq_state_arr[(int)old_st] +
 		sg_rq_state_mul2arr[(int)new_st];
 	act_old_st = (enum sg_rq_state)atomic_cmpxchg(&srp->rq_st, old_st,
 						      new_st);
 	if (act_old_st != old_st) {
-#if IS_ENABLED(SG_LOG_ACTIVE)
-		if (fromp)
-			sg_rq_state_fail_msg(srp->parentfp, old_st, new_st,
-					     act_old_st, fromp);
-#endif
+		SG_LOG(1, sfp, "%s: unexpected old state: %s\n", __func__,
+		       sg_rq_st_str(act_old_st, false));
 		return -EPROTOTYPE;	/* only used for this error type */
 	}
 	if (indic) {
 		xa_lock_irqsave(xafp, iflags);
+		if (new_st == SG_RS_INACTIVE)
+			WRITE_ONCE(sfp->prev_used_idx, srp->rq_idx);
 		sg_rq_state_helper(xafp, srp, indic);
 		xa_unlock_irqrestore(xafp, iflags);
 	}
 	return 0;
 }
 
+static void
+sg_rq_state_chg_force(struct sg_request *srp, enum sg_rq_state new_st)
+{
+	unsigned long iflags;
+	struct sg_fd *sfp = srp->parentfp;
+	struct xarray *xafp = &sfp->srp_arr;
+
+	xa_lock_irqsave(xafp, iflags);
+	if (new_st == SG_RS_INACTIVE)
+		WRITE_ONCE(sfp->prev_used_idx, srp->rq_idx);
+	sg_rq_state_force(srp, new_st);
+	xa_unlock_irqrestore(xafp, iflags);
+}
+
 static void
 sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 {
@@ -998,8 +1006,7 @@ sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 		at_head = !(srp->rq_flags & SG_FLAG_Q_AT_TAIL);
 
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
-	sg_rq_state_chg(srp, SG_RS_BUSY /* ignored */, SG_RS_INFLIGHT,
-			true, __func__);
+	sg_rq_state_chg_force(srp, SG_RS_INFLIGHT);
 
 	/* >>>>>>> send cmd/req off to other levels <<<<<<<< */
 	if (!sync)
@@ -1200,10 +1207,6 @@ sg_receive_v3(struct sg_fd *sfp, struct sg_request *srp, size_t count,
 	hp->driver_status = driver_byte(rq_result);
 	err2 = put_sg_io_hdr(hp, p);
 	err = err ? err : err2;
-	err2 = sg_rq_state_chg(srp, atomic_read(&srp->rq_st), SG_RS_RCV_DONE,
-			       false, __func__);
-	if (err2)
-		err = err ? err : err2;
 err_out:
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
@@ -1214,7 +1217,7 @@ static int
 sg_receive_v4(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	      struct sg_io_v4 *h4p)
 {
-	int err, err2;
+	int err;
 	u32 rq_result = srp->rq_result;
 
 	SG_LOG(3, sfp, "%s: p=%s, h4p=%s\n", __func__,
@@ -1249,10 +1252,6 @@ sg_receive_v4(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 		if (copy_to_user(p, h4p, SZ_SG_IO_V4))
 			err = err ? err : -EFAULT;
 	}
-	err2 = sg_rq_state_chg(srp, atomic_read(&srp->rq_st), SG_RS_RCV_DONE,
-			       false, __func__);
-	if (err2)
-		err = err ? err : err2;
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
 	return err < 0 ? err : 0;
@@ -1448,7 +1447,6 @@ sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 		res = (h2p->result == 0) ? 0 : -EIO;
 	}
 fini:
-	atomic_set(&srp->rq_st, SG_RS_RCV_DONE);
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
 	return res;
@@ -1622,7 +1620,6 @@ sg_get_dur(struct sg_request *srp, const enum sg_rq_state *sr_stp,
 		res = sg_calc_rq_dur(srp);
 		break;
 	case SG_RS_AWAIT_RCV:
-	case SG_RS_RCV_DONE:
 	case SG_RS_INACTIVE:
 		res = srp->duration;
 		is_dur = true;	/* completion has occurred, timing finished */
@@ -1693,9 +1690,13 @@ sg_wait_event_srp(struct file *filp, struct sg_fd *sfp, void __user *p,
 	sr_st = atomic_read(&srp->rq_st);
 	if (unlikely(sr_st != SG_RS_AWAIT_RCV))
 		return -EPROTO;         /* Logic error */
-	res = sg_rq_state_chg(srp, sr_st, SG_RS_BUSY, false, __func__);
-	if (unlikely(res))
+	res = sg_rq_state_chg(srp, sr_st, SG_RS_BUSY);
+	if (unlikely(res)) {
+#if IS_ENABLED(SG_LOG_ACTIVE)
+		sg_rq_state_fail_msg(sfp, sr_st, SG_RS_BUSY, __func__);
+#endif
 		return res;
+	}
 	if (test_bit(SG_FRQ_IS_V4I, srp->frq_bm))
 		res = sg_receive_v4(sfp, srp, p, h4p);
 	else
@@ -2457,8 +2458,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	}
 	if (!test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
 		atomic_inc(&sfp->waiting);
-	if (unlikely(sg_rq_state_chg(srp, SG_RS_INFLIGHT, rqq_state,
-				     false, __func__)))
+	if (unlikely(sg_rq_state_chg(srp, SG_RS_INFLIGHT, rqq_state)))
 		pr_warn("%s: can't set rq_st\n", __func__);
 	/*
 	 * Free the mid-level resources apart from the bio (if any). The bio's
@@ -3156,9 +3156,10 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 	__maybe_unused bool is_bad_st = false;
 	__maybe_unused enum sg_rq_state bad_sr_st = SG_RS_INACTIVE;
 	bool search_for_1 = (pack_id != SG_PACK_ID_WILDCARD);
+	bool second = false;
 	int res;
 	int num_waiting = atomic_read(&sfp->waiting);
-	unsigned long idx;
+	unsigned long idx, start_idx, end_idx;
 	struct sg_request *srp = NULL;
 	struct xarray *xafp = &sfp->srp_arr;
 
@@ -3170,8 +3171,7 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 				continue;
 			if (srp->pack_id != pack_id)
 				continue;
-			res = sg_rq_state_chg(srp, SG_RS_AWAIT_RCV, SG_RS_BUSY,
-					      false, __func__);
+			res = sg_rq_state_chg(srp, SG_RS_AWAIT_RCV, SG_RS_BUSY);
 			if (likely(res == 0))
 				goto good;
 			/* else another caller got it, move on */
@@ -3181,14 +3181,37 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 			}
 			break;
 		}
-	} else {        /* search for any request is more likely */
-		xa_for_each_marked(xafp, idx, srp, SG_XA_RQ_AWAIT) {
+	} else {
+		/*
+		 * Searching for _any_ request is the more likely usage. Start searching with the
+		 * last xarray index that was used. In the case of a large-ish IO depth, it is
+		 * likely that the second (relative) position will be the request we want, if it
+		 * is ready. If there is no queuing and the "last used" has been re-used then the
+		 * first (relative) position will be the request we want.
+		 */
+		start_idx = READ_ONCE(sfp->prev_used_idx);
+		end_idx = ULONG_MAX;
+second_time:
+		idx = start_idx;
+		for (srp = xa_find(xafp, &idx, end_idx, SG_XA_RQ_AWAIT);
+		     srp;
+		     srp = xa_find_after(xafp, &idx, end_idx, SG_XA_RQ_AWAIT)) {
 			if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
 				continue;
-			res = sg_rq_state_chg(srp, SG_RS_AWAIT_RCV, SG_RS_BUSY,
-					      false, __func__);
+			res = sg_rq_state_chg(srp, SG_RS_AWAIT_RCV, SG_RS_BUSY);
 			if (likely(res == 0))
 				goto good;
+#if IS_ENABLED(SG_LOG_ACTIVE)
+			else
+				sg_rq_state_fail_msg(sfp, SG_RS_AWAIT_RCV, SG_RS_BUSY, __func__);
+#endif
+		}
+		/* If not found so far, need to wrap around and search [0 ... start_idx) */
+		if (!srp && !second && start_idx > 0) {
+			end_idx = start_idx - 1;
+			start_idx = 0;
+			second = true;
+			goto second_time;
 		}
 	}
 	/* here if one of above loops does _not_ find a match */
@@ -3306,8 +3329,9 @@ sg_setup_req(struct sg_comm_wr_t *cwrp, int dxfr_len)
 	bool found = false;
 	bool mk_new_srp = true;
 	bool try_harder = false;
+	bool second = false;
 	int num_inactive = 0;
-	unsigned long idx, last_idx, iflags;
+	unsigned long idx, start_idx, end_idx, iflags;
 	struct sg_fd *fp = cwrp->sfp;
 	struct sg_request *r_srp = NULL;	/* request to return */
 	struct sg_request *last_srp = NULL;
@@ -3320,45 +3344,48 @@ sg_setup_req(struct sg_comm_wr_t *cwrp, int dxfr_len)
 		act_empty = true;
 		mk_new_srp = true;
 	} else if (!try_harder && dxfr_len < SG_DEF_SECTOR_SZ) {
-		last_idx = ~0UL;
 		xa_for_each_marked(xafp, idx, r_srp, SG_XA_RQ_INACTIVE) {
-			if (!r_srp)
-				continue;
 			++num_inactive;
-			if (dxfr_len < SG_DEF_SECTOR_SZ) {
-				last_idx = idx;
+			if (dxfr_len < SG_DEF_SECTOR_SZ)
 				last_srp = r_srp;
-				continue;
-			}
 		}
 		/* If dxfr_len is small, use last inactive request */
-		if (last_idx != ~0UL && last_srp) {
+		if (last_srp) {
 			r_srp = last_srp;
-			if (sg_rq_state_chg(r_srp, SG_RS_INACTIVE, SG_RS_BUSY,
-					    false, __func__))
+			if (sg_rq_state_chg(r_srp, SG_RS_INACTIVE, SG_RS_BUSY))
 				goto start_again; /* gone to another thread */
 			cp = "toward end of srp_arr";
 			found = true;
 		}
 	} else {
-		xa_for_each_marked(xafp, idx, r_srp, SG_XA_RQ_INACTIVE) {
-			if (!r_srp)
-				continue;
+		start_idx = READ_ONCE(fp->prev_used_idx);
+		end_idx = ULONG_MAX;
+second_time:
+		idx = start_idx;
+		for (r_srp = xa_find(xafp, &idx, end_idx, SG_XA_RQ_INACTIVE);
+		     r_srp;
+		     r_srp = xa_find_after(xafp, &idx, end_idx, SG_XA_RQ_INACTIVE)) {
 			if (r_srp->sgat_h.buflen >= dxfr_len) {
-				if (sg_rq_state_chg
-					(r_srp, SG_RS_INACTIVE, SG_RS_BUSY,
-					 false, __func__))
+				if (sg_rq_state_chg(r_srp, SG_RS_INACTIVE, SG_RS_BUSY))
 					continue;
-				cp = "from front of srp_arr";
+				cp = "near front of srp_arr";
 				found = true;
 				break;
 			}
 		}
+		/* If not found so far, need to wrap around and search [0 ... start_idx) */
+		if (!r_srp && !second && start_idx > 0) {
+			end_idx = start_idx - 1;
+			start_idx = 0;
+			second = true;
+			goto second_time;
+		}
 	}
 	if (found) {
 		r_srp->in_resid = 0;
 		r_srp->rq_info = 0;
 		r_srp->sense_len = 0;
+		WRITE_ONCE(fp->prev_used_idx, r_srp->rq_idx);
 		mk_new_srp = false;
 	} else {
 		mk_new_srp = true;
@@ -3431,7 +3458,7 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	sbp = srp->sense_bp;
 	srp->sense_bp = NULL;
 	WRITE_ONCE(srp->frq_bm[0], 0);
-	sg_rq_state_chg(srp, 0, SG_RS_INACTIVE, true /* force */, __func__);
+	sg_rq_state_chg_force(srp, SG_RS_INACTIVE);
 	/* maybe orphaned req, thus never read */
 	if (sbp)
 		mempool_free(sbp, sg_sense_pool);
@@ -3522,7 +3549,7 @@ sg_add_sfp(struct sg_device *sdp)
 		}
 		srp->rq_idx = idx;
 		srp->parentfp = sfp;
-		sg_rq_state_chg(srp, 0, SG_RS_INACTIVE, true, __func__);
+		sg_rq_state_chg_force(srp, SG_RS_INACTIVE);
 	}
 	if (!reduced) {
 		SG_LOG(4, sfp, "%s: built reserve buflen=%d\n", __func__,
@@ -3671,8 +3698,6 @@ sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 		return long_str ? "inflight" : "act";
 	case SG_RS_AWAIT_RCV:
 		return long_str ? "await_receive" : "rcv";
-	case SG_RS_RCV_DONE:
-		return long_str ? "receive_done" : "fin";
 	case SG_RS_BUSY:
 		return long_str ? "busy" : "bsy";
 	default:
@@ -3949,7 +3974,8 @@ sg_proc_debug_fd(struct sg_fd *fp, char *obp, int len, unsigned long idx)
 		       (int)test_bit(SG_FFD_FORCE_PACKID, fp->ffd_bm),
 		       (int)test_bit(SG_FFD_KEEP_ORPHAN, fp->ffd_bm),
 		       fp->ffd_bm[0]);
-	n += scnprintf(obp + n, len - n, "   mmap_sz=%d\n", fp->mmap_sz);
+	n += scnprintf(obp + n, len - n, "   mmap_sz=%d prev_used_idx=%d\n",
+		       fp->mmap_sz, fp->prev_used_idx);
 	n += scnprintf(obp + n, len - n,
 		       "   submitted=%d waiting=%d   open thr_id=%d\n",
 		       atomic_read(&fp->submitted),
-- 
2.25.1

