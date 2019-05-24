Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9129E63
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbfEXSsk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:40 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56406 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403773AbfEXSsk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id ADF7D204170;
        Fri, 24 May 2019 20:48:38 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yZaMq-yW3Ioz; Fri, 24 May 2019 20:48:35 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 050FB20419A;
        Fri, 24 May 2019 20:48:27 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 14/19] sg: tag and more_async
Date:   Fri, 24 May 2019 14:48:04 -0400
Message-Id: <20190524184809.25121-15-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Wire up some more capabilities of ioctl(SG_SET_GET_EXTENDED). One
is to use a LLD or block layer generated tag rather than the user
provided pack_id to track requests. Tags to the user space for
an async interface may be considered as work in progress as there
doesn't seem to be a safe mechanism to get that tag. When this
driver fetches that tag it could be too early (so it should get
a default value) or too late (i.e. the request has completed, at
least internally). Well, pack_id has been in the sg since version
1 of the driver and works well ...

The more_async flag when set instructs the blk_get_request() not
to block which is does in the current driver on rare occasions
for some obscure reason. IMO it should not block in async mode
but there is backward compatibilty to consider.

Note to kernel janitors: please do not change setting like
GFP_ATOMIC to GFP_KERNEL in async code paths unless you
really understand the implications to user space programs.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 278 +++++++++++++++++++++++++++++------------
 include/uapi/scsi/sg.h |   3 +
 2 files changed, 199 insertions(+), 82 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 64e9de67ccd4..6a26aa483d8e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -44,6 +44,7 @@ static char *sg_version_date = "20190520";
 #include <linux/cred.h>		/* for sg_check_file_access() */
 #include <linux/bsg.h>
 #include <linux/proc_fs.h>	/* used if CONFIG_SCSI_PROC_FS */
+#include <linux/rculist.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_eh.h>
@@ -106,6 +107,7 @@ enum sg_rq_state {
 #define SG_SHARE_FD_MASTER (-2)		/* values >= 0 imply FD_SLAVE */
 
 #define SG_PACK_ID_WILDCARD (-1)
+#define SG_TAG_WILDCARD (-1)
 
 #define SG_ADD_RQ_MAX_RETRIES 40	/* to stop infinite _trylock(s) */
 
@@ -126,7 +128,9 @@ enum sg_rq_state {
 #define SG_FFD_MMAP_CALLED	3	/* mmap(2) system call made on fd */
 #define SG_FFD_TIME_IN_NS	4	/* set: time in nanoseconds, else ms */
 #define SG_FFD_Q_AT_TAIL	5	/* set: queue reqs at tail of blk q */
+#define SG_FFD_PREFER_TAG	7	/* prefer tag over pack_id (def) */
 #define SG_FFD_NO_DURATION	9	/* don't do command duration calc */
+#define SG_FFD_MORE_ASYNC	10	/* yield EBUSY more often */
 
 
 int sg_big_buff = SG_DEF_RESERVED_SIZE;
@@ -199,15 +203,16 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 		struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
 		struct sg_slice_hdr4 s_hdr4; /* reduced size struct sg_io_v4 */
 	};
-	u32 duration;		/* cmd duration in milliseconds */
-	u32 rq_flags;		/* hold user supplied flags */
+	u32 duration;		/* cmd duration in milli or nano seconds */
+	u32 rq_flags;		/* flags given in v3 and v4 */
 	u32 rq_info;		/* info supplied by v3 and v4 interfaces */
 	u32 rq_result;		/* packed scsi request result from LLD */
 	int in_resid;		/* requested-actual byte count on data-in */
-	int pack_id;		/* user provided packet identifier field */
+	int pack_id;		/* v3 pack_id or in v4 request_extra field */
 	int sense_len;		/* actual sense buffer length (data-in) */
 	atomic_t rq_st;		/* request state, holds a enum sg_rq_state */
 	u8 cmd_opcode;		/* first byte of SCSI cdb */
+	int tag;		/* block layer identifier of request */
 	u64 start_ns;		/* starting point of command duration calc */
 	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
 	u8 *sense_bp;		/* alloc-ed sense buffer, as needed */
@@ -227,7 +232,7 @@ struct sg_fd {		/* holds the state of a file descriptor */
 	struct list_head rq_fl; /* head of sg_request free list */
 	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
-	int tot_fd_thresh;      /* E2BIG if sum_of(dlen) > this, 0: ignore */
+	int tot_fd_thresh;	/* E2BIG if sum_of(dlen) > this, 0: ignore */
 	int sgat_elem_sz;	/* initialized to scatter_elem_sz */
 	atomic_t sum_fd_dlens;	/* when tot_fd_thresh>0 this is sum_of(dlen) */
 	atomic_t submitted;	/* number inflight or awaiting read */
@@ -290,7 +295,8 @@ static int sg_rd_append(struct sg_request *srp, void __user *outp,
 static void sg_remove_sgat(struct sg_request *srp);
 static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
 static void sg_remove_sfp(struct kref *);
-static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id);
+static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id,
+					    bool is_tag);
 static struct sg_request *sg_add_request(struct sg_comm_wr_t *cwrp,
 					 int dxfr_len);
 static void sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
@@ -391,8 +397,8 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 			mutex_unlock(&sdp->open_rel_lock);
 			res = wait_event_interruptible
 				(sdp->open_wait,
-				 (unlikely(atomic_read(&sdp->detaching)) ||
-				 !atomic_read(&sdp->open_cnt)));
+				 unlikely(atomic_read(&sdp->detaching)) ||
+				 !atomic_read(&sdp->open_cnt));
 			mutex_lock(&sdp->open_rel_lock);
 
 			if (unlikely(res)) /* -ERESTARTSYS */
@@ -801,6 +807,11 @@ sg_v4_submit(struct file *filp, struct sg_fd *sfp, void __user *p,
 		return PTR_ERR(srp);
 	if (o_srp)
 		*o_srp = srp;
+	if (p && !sync && (srp->rq_flags & SGV4_FLAG_YIELD_TAG)) {
+		struct sg_io_v4 __user *h4_up = (struct sg_io_v4 __user *)p;
+
+		res = put_user(srp->tag, &h4_up->request_tag);
+	}
 	return res;
 }
 
@@ -826,7 +837,7 @@ static int
 sg_ctl_iosubmit_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
 {
 	int res;
-	u8 hdr_store[SZ_SG_IO_V4];      /* max(v3interface, v4interface) */
+	u8 hdr_store[SZ_SG_IO_V4];	/* max(v3interface, v4interface) */
 	struct sg_io_hdr *h3p = (struct sg_io_hdr *)hdr_store;
 	struct sg_device *sdp = sfp->parentdp;
 
@@ -844,6 +855,7 @@ static void
 sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 {
 	bool at_head, is_v4h, sync;
+	unsigned long iflags;
 	struct sg_device *sdp = sfp->parentdp;
 
 	is_v4h = test_bit(SG_FRQ_IS_V4I, srp->frq_bm);
@@ -870,6 +882,17 @@ sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 		atomic_inc(&sfp->submitted);
 	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
 			      srp->rq, (int)at_head, sg_rq_end_io);
+
+	/* Should we try to find the req's tag? Only pay if answer is yes */
+	if (is_v4h && (srp->rq_flags & SGV4_FLAG_YIELD_TAG)) {
+		spin_lock_irqsave(&srp->req_lck, iflags);
+		{		/* we might be too late or too early! */
+			struct request *rq = srp->rq;
+
+			srp->tag = rq ? rq->tag : SG_TAG_WILDCARD;
+		}
+		spin_unlock_irqrestore(&srp->req_lck, iflags);
+	}
 }
 
 static inline int
@@ -987,7 +1010,8 @@ sg_common_write(struct sg_comm_wr_t *cwrp)
  * returns true (or an event like a signal (e.g. control-C) occurs).
  */
 static inline bool
-sg_get_ready_srp(struct sg_fd *sfp, struct sg_request **srpp, int pack_id)
+sg_get_ready_srp(struct sg_fd *sfp, struct sg_request **srpp, int id,
+		 bool is_tag)
 {
 	struct sg_request *srp;
 
@@ -995,7 +1019,7 @@ sg_get_ready_srp(struct sg_fd *sfp, struct sg_request **srpp, int pack_id)
 		*srpp = NULL;
 		return true;
 	}
-	srp = sg_find_srp_by_id(sfp, pack_id);
+	srp = sg_find_srp_by_id(sfp, id, is_tag);
 	*srpp = srp;
 	return !!srp;
 }
@@ -1040,7 +1064,7 @@ sg_copy_sense(struct sg_request *srp, bool v4_active)
 	return sb_len_wr;
 }
 
-#if IS_ENABLED(CONFIG_SCSI_LOGGING)
+#if IS_ENABLED(SG_LOG_ACTIVE)
 static void
 sg_rep_rq_state_fail(struct sg_device *sdp, enum sg_rq_state exp_old_st,
 		     enum sg_rq_state want_st, enum sg_rq_state act_old_st)
@@ -1178,8 +1202,10 @@ static int
 sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 {
 	bool non_block = !!(filp->f_flags & O_NONBLOCK);
+	bool use_tag = false;
 	int res, id;
 	int pack_id = SG_PACK_ID_WILDCARD;
+	int tag = SG_TAG_WILDCARD;
 	u8 v4_holder[SZ_SG_IO_V4];
 	struct sg_io_v4 *h4p = (struct sg_io_v4 *)v4_holder;
 	struct sg_device *sdp = sfp->parentdp;
@@ -1198,8 +1224,10 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 		non_block = true;	/* set by either this or O_NONBLOCK */
 	SG_LOG(3, sdp, "%s: non_block(+IMMED)=%d\n", __func__, non_block);
 	/* read in part of v3 or v4 header for pack_id or tag based find */
-	id = pack_id;
-	srp = sg_find_srp_by_id(sfp, id);
+	if (test_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm))
+		use_tag = test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm);
+	id = use_tag ? tag : pack_id;
+	srp = sg_find_srp_by_id(sfp, id, use_tag);
 	if (!srp) {     /* nothing available so wait on packet or */
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
@@ -1207,7 +1235,7 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 			return -EAGAIN;
 		res = wait_event_interruptible(sfp->read_wait,
 					       sg_get_ready_srp(sfp, &srp,
-								id));
+								id, use_tag));
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
 		if (unlikely(res))
@@ -1250,7 +1278,7 @@ sg_ctl_ioreceive_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
 	if (test_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm))
 		pack_id = h3p->pack_id;
 
-	srp = sg_find_srp_by_id(sfp, pack_id);
+	srp = sg_find_srp_by_id(sfp, pack_id, false);
 	if (!srp) {     /* nothing available so wait on packet or */
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
@@ -1258,7 +1286,7 @@ sg_ctl_ioreceive_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
 			return -EAGAIN;
 		res = wait_event_interruptible
 				(sfp->read_wait,
-				 sg_get_ready_srp(sfp, &srp, pack_id));
+				 sg_get_ready_srp(sfp, &srp, pack_id, false));
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
 		if (unlikely(res))
@@ -1414,15 +1442,15 @@ sg_read(struct file *filp, char __user *p, size_t count, loff_t *ppos)
 			want_id = h2p->pack_id;
 		}
 	}
-	srp = sg_find_srp_by_id(sfp, want_id);
+	srp = sg_find_srp_by_id(sfp, want_id, false);
 	if (!srp) {     /* nothing available so wait on packet to arrive or */
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
 		if (non_block) /* O_NONBLOCK or v3::flags & SGV4_FLAG_IMMED */
 			return -EAGAIN;
-		ret = wait_event_interruptible(sfp->read_wait,
-					       sg_get_ready_srp(sfp, &srp,
-								want_id));
+		ret = wait_event_interruptible
+				(sfp->read_wait,
+				 sg_get_ready_srp(sfp, &srp, want_id, false));
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
 		if (ret)	/* -ERESTARTSYS as signal hit process */
@@ -1555,10 +1583,10 @@ sg_fill_request_element(struct sg_fd *sfp, struct sg_request *srp,
 	rip->orphan = test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm);
 	rip->sg_io_owned = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
 	rip->problem = !!(srp->rq_result & SG_ML_RESULT_MSK);
-	rip->pack_id = srp->pack_id;
+	rip->pack_id = test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm) ?
+				srp->tag : srp->pack_id;
 	rip->usr_ptr = test_bit(SG_FRQ_IS_V4I, srp->frq_bm) ?
 			uptr64(srp->s_hdr4.usr_ptr) : srp->s_hdr3.usr_ptr;
-	rip->usr_ptr = srp->s_hdr3.usr_ptr;
 	spin_unlock(&srp->req_lck);
 }
 
@@ -1660,8 +1688,9 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 	return res;
 }
 
+/* When use_tag is true then id is a tag, else it is a pack_id. */
 static struct sg_request *
-sg_match_request(struct sg_fd *sfp, int id)
+sg_match_request(struct sg_fd *sfp, bool use_tag, int id)
 {
 	bool found = false;
 	struct sg_request *srp;
@@ -1671,10 +1700,19 @@ sg_match_request(struct sg_fd *sfp, int id)
 	if (id == SG_PACK_ID_WILDCARD)	/* both wildcards same value: -1 */
 		return list_first_entry_or_null(&sfp->rq_list,
 						struct sg_request, rq_entry);
-	list_for_each_entry(srp, &sfp->rq_list, rq_entry) {
-		if (id == srp->pack_id) {
-			found = true;
-			break;
+	if (use_tag) {
+		list_for_each_entry(srp, &sfp->rq_list, rq_entry) {
+			if (id == srp->tag) {
+				found = true;
+				break;
+			}
+		}
+	} else {
+		list_for_each_entry(srp, &sfp->rq_list, rq_entry) {
+			if (id == srp->pack_id) {
+				found = true;
+				break;
+			}
 		}
 	}
 	return found ? srp : NULL;
@@ -1683,7 +1721,8 @@ sg_match_request(struct sg_fd *sfp, int id)
 static int
 sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 {
-	int res, pack_id, id;
+	bool use_tag;
+	int res, pack_id, tag, id;
 	unsigned long iflags;
 	struct sg_fd *o_sfp;
 	struct sg_request *srp;
@@ -1695,10 +1734,12 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 	if (h4p->guard != 'Q' || h4p->protocol != 0 || h4p->subprotocol != 0)
 		return -EPERM;
 	pack_id = h4p->request_extra;
-	id = pack_id;
+	tag = h4p->request_tag;
+	use_tag = test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm);
+	id = use_tag ? tag : pack_id;
 
 	spin_lock(&sfp->rq_list_lock);
-	srp = sg_match_request(sfp, id);
+	srp = sg_match_request(sfp, use_tag, id);
 	if (srp) {
 		spin_lock_irqsave(&srp->req_lck, iflags);
 		spin_unlock(&sfp->rq_list_lock);
@@ -1709,7 +1750,7 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 			if (o_sfp == sfp)
 				continue;	/* already checked */
 			spin_lock(&o_sfp->rq_list_lock);
-			srp = sg_match_request(o_sfp, id);
+			srp = sg_match_request(o_sfp, use_tag, id);
 			if (srp) {
 				spin_lock_irqsave(&srp->req_lck, iflags);
 				spin_unlock(&o_sfp->rq_list_lock);
@@ -1850,6 +1891,16 @@ sg_extended_bool_flags(struct sg_fd *sfp, struct sg_extended_info *seip)
 		else
 			*c_flgsp &= ~SG_CTL_FLAGM_TIME_IN_NS;
 	}
+	/* TAG_FOR_PACK_ID boolean, [raw] search by tag or pack_id (def) */
+	if (c_flgs_wm & SG_CTL_FLAGM_TAG_FOR_PACK_ID)
+		assign_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm,
+			   !!(*c_flgsp & SG_CTL_FLAGM_TIME_IN_NS));
+	if (c_flgs_rm & SG_CTL_FLAGM_TAG_FOR_PACK_ID) {
+		if (test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm))
+			*c_flgsp |= SG_CTL_FLAGM_TAG_FOR_PACK_ID;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_TAG_FOR_PACK_ID;
+	}
 	/* OTHER_OPENS boolean, [ro] any other sg open fds on this dev? */
 	if (c_flgs_rm & SG_CTL_FLAGM_OTHER_OPENS) {
 		if (atomic_read(&sdp->open_cnt) > 1)
@@ -1879,6 +1930,18 @@ sg_extended_bool_flags(struct sg_fd *sfp, struct sg_extended_info *seip)
 		else
 			*c_flgsp &= ~SG_CTL_FLAGM_NO_DURATION;
 	}
+	/* MORE_ASYNC boolean, [rbw] */
+	if (c_flgs_rm & SG_CTL_FLAGM_MORE_ASYNC)
+		flg = test_bit(SG_FFD_MORE_ASYNC, sfp->ffd_bm);
+	if (c_flgs_wm & SG_CTL_FLAGM_MORE_ASYNC)
+		assign_bit(SG_FFD_MORE_ASYNC, sfp->ffd_bm,
+			   !!(*c_flgsp & SG_CTL_FLAGM_MORE_ASYNC));
+	if (c_flgs_rm & SG_CTL_FLAGM_MORE_ASYNC) {
+		if (flg)
+			*c_flgsp |= SG_CTL_FLAGM_MORE_ASYNC;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_MORE_ASYNC;
+	}
 }
 
 static void
@@ -2166,11 +2229,23 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_GET_PACK_ID:    /* or tag of oldest "read"-able, -1 if none */
 		rcu_read_lock();
 		val = -1;
-		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
-			if (SG_RS_AWAIT_READ(srp) &&
-			    !test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm)) {
-				val = srp->pack_id;
-				break;
+		if (test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm)) {
+			list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+				if (SG_RS_AWAIT_READ(srp) &&
+				    !test_bit(SG_FRQ_SYNC_INVOC,
+					      srp->frq_bm)) {
+					val = srp->tag;
+					break;
+				}
+			}
+		} else {
+			list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+				if (SG_RS_AWAIT_READ(srp) &&
+				    !test_bit(SG_FRQ_SYNC_INVOC,
+					      srp->frq_bm)) {
+					val = srp->pack_id;
+					break;
+				}
 			}
 		}
 		rcu_read_unlock();
@@ -2370,11 +2445,12 @@ sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
+	SG_LOG(3, sdp, "%s: cmd=0x%x\n", __func__, (int)cmd_in);
 	if (unlikely(!sdp))
 		return -ENXIO;
 
 	sdev = sdp->device;
-	if (sdev->host->hostt->compat_ioctl) { 
+	if (sdev->host->hostt->compat_ioctl) {
 		int ret;
 
 		ret = sdev->host->hostt->compat_ioctl(sdev, cmd_in, (void __user *)arg);
@@ -3059,6 +3135,7 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 	int res = 0;
 	int dxfer_len = 0;
 	int r0w = READ;
+	int flgs;
 	unsigned int iov_count = 0;
 	void __user *up;
 	struct request *rq;
@@ -3108,17 +3185,15 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 	q = sdp->device->request_queue;
 
 	/*
-	 * NOTE
-	 *
-	 * With scsi-mq enabled, there are a fixed number of preallocated
-	 * requests equal in number to shost->can_queue.  If all of the
-	 * preallocated requests are already in use, then blk_get_request()
-	 * will sleep until an active command completes, freeing up a request.
-	 * Although waiting in an asynchronous interface is less than ideal, we
-	 * do not want to use BLK_MQ_REQ_NOWAIT here because userspace might
-	 * not expect an EWOULDBLOCK from this condition.
+	 * For backward compatibility default to using blocking variant even
+	 * when in non-blocking (async) mode. If the SG_CTL_FLAGM_MORE_ASYNC
+	 * boolean set on this file descriptor, returns -EAGAIN if
+	 * blk_get_request(BLK_MQ_REQ_NOWAIT) yields EAGAIN (aka EWOULDBLOCK).
 	 */
-	rq = blk_get_request(q, (r0w ? REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN), 0);
+	flgs = (test_bit(SG_FFD_MORE_ASYNC, sfp->ffd_bm)) ?
+						BLK_MQ_REQ_NOWAIT : 0;
+	rq = blk_get_request(q, (r0w ? REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN),
+			     flgs);
 	if (unlikely(IS_ERR(rq))) {
 		kfree(long_cmdp);
 		return PTR_ERR(rq);
@@ -3427,17 +3502,18 @@ sg_rd_append(struct sg_request *srp, void __user *outp, int num_xfer)
 
 /*
  * If there are multiple requests outstanding, the speed of this function is
- * important. SG_PACK_ID_WILDCARD is -1 and that case is typically
+ * important. 'id' is pack_id when is_tag=false, otherwise it is a tag. Both
+ * SG_PACK_ID_WILDCARD and SG_TAG_WILDCARD are -1 and that case is typically
  * the fast path. This function is only used in the non-blocking cases.
  * Returns pointer to (first) matching sg_request or NULL. If found,
  * sg_request state is moved from SG_RS_AWAIT_RD to SG_RS_BUSY.
  */
 static struct sg_request *
-sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
+sg_find_srp_by_id(struct sg_fd *sfp, int id, bool is_tag)
 {
 	__maybe_unused bool is_bad_st = false;
 	__maybe_unused enum sg_rq_state bad_sr_st;
-	bool search_for_1 = (pack_id != SG_PACK_ID_WILDCARD);
+	bool search_for_1 = (id != SG_TAG_WILDCARD);
 	enum sg_rq_state sr_st;
 	int res;
 	struct sg_request *srp = NULL;
@@ -3447,8 +3523,13 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
 			if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
 				continue;
-			if (srp->pack_id != pack_id)
-				continue;
+			if (is_tag) {
+				if (srp->tag != id)
+					continue;
+			} else {
+				if (srp->pack_id != id)
+					continue;
+			}
 			sr_st = atomic_read(&srp->rq_st);
 			switch (sr_st) {
 			case SG_RS_AWAIT_RD:
@@ -3488,16 +3569,17 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 	rcu_read_unlock();
 	if (IS_ENABLED(CONFIG_SCSI_PROC_FS)) {
 		if (search_for_1) {
-			struct sg_device *sdp = sfp->parentdp;
-			const char *cptp = "pack_id=";
+			__maybe_unused struct sg_device *sdp = sfp->parentdp;
+			__maybe_unused const char *cptp = is_tag ? "tag=" :
+								   "pack_id=";
 
 			if (is_bad_st)
 				SG_LOG(1, sdp, "%s: %s%d wrong state: %s\n",
-				       __func__, cptp, pack_id,
+				       __func__, cptp, id,
 				       sg_rq_st_str(bad_sr_st, true));
 			else
 				SG_LOG(6, sdp, "%s: %s%d not awaiting read\n",
-				       __func__, cptp, pack_id);
+				       __func__, cptp, id);
 		}
 	}
 	return NULL;
@@ -3505,7 +3587,7 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 	rcu_read_unlock();
 	if (search_for_1) {
 		SG_LOG(6, sfp->parentdp, "%s: %s%d found [srp=0x%p]\n",
-		       __func__, "pack_id=", pack_id, srp);
+		       __func__, (is_tag ? "tag=" : "pack_id="), id, srp);
 	}
 	return srp;
 }
@@ -3530,6 +3612,7 @@ sg_mk_srp(struct sg_fd *sfp, bool first)
 		spin_lock_init(&srp->req_lck);
 		atomic_set(&srp->rq_st, SG_RS_INACTIVE);
 		srp->parentfp = sfp;
+		srp->tag = SG_TAG_WILDCARD;
 		return srp;
 	} else {
 		return ERR_PTR(-ENOMEM);
@@ -3731,7 +3814,7 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	srp->sense_bp = NULL;
 	atomic_set(&srp->rq_st, SG_RS_BUSY);
 	list_del_rcu(&srp->rq_entry);
-	kfree(sbp);     /* maybe orphaned req, thus never read */
+	kfree(sbp);	/* maybe orphaned req, thus never read */
 	/*
 	 * N.B. sg_request object is not de-allocated (freed). The contents
 	 * of the rq_list and rq_fl lists are de-allocated (freed) when
@@ -3881,7 +3964,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		list_del(&srp->rq_entry);
 		if (srp->sgat_h.buflen > 0)
 			sg_remove_sgat(srp);
-		kfree(srp->sense_bp);   /* abnormal close: device detached */
+		kfree(srp->sense_bp);	/* abnormal close: device detached */
 		SG_LOG(6, sdp, "%s:%s%p --\n", __func__, cp, srp);
 		kfree(srp);
 	}
@@ -3940,14 +4023,18 @@ sg_lookup_dev(int dev)
 	return idr_find(&sg_index_idr, dev);
 }
 
+/*
+ * Returns valid pointer to a sg_device object on success or a negated
+ * errno value on failure. Does not return NULL.
+ */
 static struct sg_device *
-sg_get_dev(int dev)
+sg_get_dev(int min_dev)
 {
 	struct sg_device *sdp;
-	unsigned long flags;
+	unsigned long iflags;
 
-	read_lock_irqsave(&sg_index_lock, flags);
-	sdp = sg_lookup_dev(dev);
+	read_lock_irqsave(&sg_index_lock, iflags);
+	sdp = sg_lookup_dev(min_dev);
 	if (!sdp)
 		sdp = ERR_PTR(-ENXIO);
 	else if (atomic_read(&sdp->detaching)) {
@@ -3957,8 +4044,7 @@ sg_get_dev(int dev)
 		sdp = ERR_PTR(-ENODEV);
 	} else
 		kref_get(&sdp->d_ref);
-	read_unlock_irqrestore(&sg_index_lock, flags);
-
+	read_unlock_irqrestore(&sg_index_lock, iflags);
 	return sdp;
 }
 
@@ -3994,7 +4080,7 @@ static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
 static int sg_proc_single_open_adio(struct inode *inode, struct file *filp);
 static ssize_t sg_proc_write_adio(struct file *filp, const char __user *buffer,
-			          size_t count, loff_t *off);
+				  size_t count, loff_t *off);
 static const struct file_operations adio_fops = {
 	.owner = THIS_MODULE,
 	.open = sg_proc_single_open_adio,
@@ -4037,12 +4123,20 @@ static const struct seq_operations devstrs_seq_ops = {
 	.show  = sg_proc_seq_show_devstrs,
 };
 
-static int sg_proc_seq_show_dbg(struct seq_file *s, void *v);
-static const struct seq_operations dbg_seq_ops = {
+static int sg_proc_seq_show_full_dbg(struct seq_file *s, void *v);
+static const struct seq_operations full_dbg_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
 	.stop  = dev_seq_stop,
-	.show  = sg_proc_seq_show_dbg,
+	.show  = sg_proc_seq_show_full_dbg,
+};
+
+static int sg_proc_seq_show_red_dbg(struct seq_file *s, void *v);
+static const struct seq_operations red_dbg_seq_ops = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = sg_proc_seq_show_red_dbg,
 };
 
 static int
@@ -4055,11 +4149,12 @@ sg_proc_init(void)
 		return 1;
 
 	proc_create("allow_dio", 0644, p, &adio_fops);
-	proc_create_seq("debug", 0444, p, &dbg_seq_ops);
+	proc_create_seq("debug", 0444, p, &full_dbg_seq_ops);
 	proc_create("def_reserved_size", 0644, p, &dressz_fops);
 	proc_create_single("device_hdr", 0444, p, sg_proc_seq_show_devhdr);
 	proc_create_seq("devices", 0444, p, &dev_seq_ops);
 	proc_create_seq("device_strs", 0444, p, &devstrs_seq_ops);
+	proc_create_seq("red_debug", 0444, p, &red_dbg_seq_ops);
 	proc_create_single("version", 0444, p, sg_proc_seq_show_version);
 	return 0;
 }
@@ -4089,7 +4184,7 @@ sg_proc_single_open_adio(struct inode *inode, struct file *filp)
 	return single_open(filp, sg_proc_seq_show_int, &sg_allow_dio);
 }
 
-static ssize_t 
+static ssize_t
 sg_proc_write_adio(struct file *filp, const char __user *buffer,
 		   size_t count, loff_t *off)
 {
@@ -4111,7 +4206,7 @@ sg_proc_single_open_dressz(struct inode *inode, struct file *filp)
 	return single_open(filp, sg_proc_seq_show_int, &sg_big_buff);
 }
 
-static ssize_t 
+static ssize_t
 sg_proc_write_dressz(struct file *filp, const char __user *buffer,
 		     size_t count, loff_t *off)
 {
@@ -4174,7 +4269,7 @@ dev_seq_next(struct seq_file *s, void *v, loff_t *pos)
 	struct sg_proc_deviter *it = s->private;
 
 	*pos = ++it->index;
-	return (it->index < it->max) ? it : NULL;
+	return (it->index < (int)it->max) ? it : NULL;
 }
 
 static void
@@ -4193,8 +4288,7 @@ sg_proc_seq_show_dev(struct seq_file *s, void *v)
 
 	read_lock_irqsave(&sg_index_lock, iflags);
 	sdp = it ? sg_lookup_dev(it->index) : NULL;
-	if ((NULL == sdp) || (NULL == sdp->device) ||
-	    (atomic_read(&sdp->detaching)))
+	if (!sdp || !sdp->device || atomic_read(&sdp->detaching))
 		seq_puts(s, "-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\n");
 	else {
 		scsidp = sdp->device;
@@ -4260,9 +4354,14 @@ sg_proc_dbg_sreq(struct sg_request *srp, int to, bool t_in_ns, char *obp,
 		       srp->sgat_h.buflen, (int)srp->pack_id);
 	if (is_dur)	/* cmd/req has completed, waiting for ... */
 		n += scnprintf(obp + n, len - n, " dur=%u%s", dur, tp);
-	else if (dur < U32_MAX)	/* in-flight or busy (so ongoing) */
+	else if (dur < U32_MAX) { /* in-flight or busy (so ongoing) */
+		if ((srp->rq_flags & SGV4_FLAG_YIELD_TAG) &&
+		    srp->tag != SG_TAG_WILDCARD)
+			n += scnprintf(obp + n, len - n, " tag=0x%x",
+				       srp->tag);
 		n += scnprintf(obp + n, len - n, " t_o/elap=%us/%u%s",
 			       to / 1000, dur, tp);
+	}
 	n += scnprintf(obp + n, len - n, " sgat=%d op=0x%02x\n",
 		       srp->sgat_h.num_sgat, srp->cmd_opcode);
 	return n;
@@ -4270,7 +4369,7 @@ sg_proc_dbg_sreq(struct sg_request *srp, int to, bool t_in_ns, char *obp,
 
 /* Writes debug info for one sg fd (including its sg requests) in obp buffer */
 static int
-sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len)
+sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len, bool reduced)
 	__must_hold(&sfp->rq_list_lock)
 {
 	bool first_fl;
@@ -4299,6 +4398,8 @@ sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len)
 		       "   submitted=%d waiting=%d   open thr_id=%d\n",
 		       atomic_read(&fp->submitted),
 		       atomic_read(&fp->waiting), fp->tid);
+	if (reduced)
+		return n;
 	list_for_each_entry_rcu(srp, &fp->rq_list, rq_entry) {
 		spin_lock(&srp->req_lck);
 		n += sg_proc_dbg_sreq(srp, fp->timeout,
@@ -4325,7 +4426,8 @@ sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len)
 
 /* Writes debug info for one sg device (including its sg fds) in obp buffer */
 static int
-sg_proc_dbg_sdev(struct sg_device *sdp, char *obp, int len, int *fd_counterp)
+sg_proc_dbg_sdev(struct sg_device *sdp, char *obp, int len,
+		 int *fd_counterp, bool reduced)
 	__must_hold(&sdp->sfd_llock)
 {
 	int n = 0;
@@ -4348,7 +4450,7 @@ sg_proc_dbg_sdev(struct sg_device *sdp, char *obp, int len, int *fd_counterp)
 		++*countp;
 		rcu_read_lock(); /* assume irqs disabled */
 		n += scnprintf(obp + n, len - n, "  FD(%d): ", *countp);
-		n += sg_proc_dbg_fd(fp, obp + n, len - n);
+		n += sg_proc_dbg_fd(fp, obp + n, len - n, reduced);
 		rcu_read_unlock();
 	}
 	return n;
@@ -4356,7 +4458,7 @@ sg_proc_dbg_sdev(struct sg_device *sdp, char *obp, int len, int *fd_counterp)
 
 /* Called via dbg_seq_ops once for each sg device */
 static int
-sg_proc_seq_show_dbg(struct seq_file *s, void *v)
+sg_proc_seq_show_dbg(struct seq_file *s, void *v, bool reduced)
 {
 	bool found = false;
 	bool trunc = false;
@@ -4394,7 +4496,7 @@ sg_proc_seq_show_dbg(struct seq_file *s, void *v)
 			snprintf(b1, sizeof(b1), " >>> device=%s  %s\n",
 				 disk_name, "detaching pending close\n");
 		else if (sdp->device) {
-			n = sg_proc_dbg_sdev(sdp, bp, bp_len, fdi_p);
+			n = sg_proc_dbg_sdev(sdp, bp, bp_len, fdi_p, reduced);
 			if (n >= bp_len - 1) {
 				trunc = true;
 				if (bp[bp_len - 2] != '\n')
@@ -4427,7 +4529,19 @@ sg_proc_seq_show_dbg(struct seq_file *s, void *v)
 	return 0;
 }
 
-#endif			/* CONFIG_SCSI_PROC_FS (~600 lines back) */
+static int
+sg_proc_seq_show_full_dbg(struct seq_file *s, void *v)
+{
+	return sg_proc_seq_show_dbg(s, v, false);
+}
+
+static int
+sg_proc_seq_show_red_dbg(struct seq_file *s, void *v)
+{
+	return sg_proc_seq_show_dbg(s, v, true);
+}
+
+#endif				/* CONFIG_SCSI_PROC_FS (~600 lines back) */
 
 module_init(init_sg);
 module_exit(exit_sg);
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 378cf0532756..5223ba33fb8d 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -106,6 +106,7 @@ typedef struct sg_io_hdr {
  */
 #define SGV4_FLAG_DIRECT_IO SG_FLAG_DIRECT_IO
 #define SGV4_FLAG_MMAP_IO SG_FLAG_MMAP_IO
+#define SGV4_FLAG_YIELD_TAG 0x8  /* sg_io_v4::request_tag set after SG_IOS */
 #define SGV4_FLAG_Q_AT_TAIL SG_FLAG_Q_AT_TAIL
 #define SGV4_FLAG_Q_AT_HEAD SG_FLAG_Q_AT_HEAD
 #define SGV4_FLAG_IMMED 0x400 /* for polling with SG_IOR, ignored in SG_IOS */
@@ -174,10 +175,12 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 
 /* flag and mask values for boolean fields follow */
 #define SG_CTL_FLAGM_TIME_IN_NS	0x1	/* time: nanosecs (def: millisecs) */
+#define SG_CTL_FLAGM_TAG_FOR_PACK_ID 0x2 /* prefer tag over pack_id (def) */
 #define SG_CTL_FLAGM_OTHER_OPENS 0x4	/* rd: other sg fd_s on this dev */
 #define SG_CTL_FLAGM_ORPHANS	0x8	/* rd: orphaned requests on this fd */
 #define SG_CTL_FLAGM_Q_TAIL	0x10	/* used for future cmds on this fd */
 #define SG_CTL_FLAGM_NO_DURATION 0x400	/* don't calc command duration */
+#define SG_CTL_FLAGM_MORE_ASYNC	0x800	/* yield EAGAIN in more cases */
 #define SG_CTL_FLAGM_ALL_BITS	0xfff	/* should be OR of previous items */
 
 /* Write one of the following values to sg_extended_info::read_value, get... */
-- 
2.17.1

