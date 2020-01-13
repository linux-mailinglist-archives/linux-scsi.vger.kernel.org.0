Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA41388EC
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jan 2020 00:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbgALX6b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Jan 2020 18:58:31 -0500
Received: from smtp.infotech.no ([82.134.31.41]:52055 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387552AbgALX6a (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 12 Jan 2020 18:58:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 75E80204255;
        Mon, 13 Jan 2020 00:58:28 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BTUdaY1BNdZX; Mon, 13 Jan 2020 00:58:26 +0100 (CET)
Received: from xtwo70.bingwo.ca (unknown [213.52.86.138])
        by smtp.infotech.no (Postfix) with ESMTPA id 5128B2042A2;
        Mon, 13 Jan 2020 00:58:00 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v6 24/37] sg: xarray for reqs in fd
Date:   Mon, 13 Jan 2020 00:57:42 +0100
Message-Id: <20200112235755.14197-25-dgilbert@interlog.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112235755.14197-1-dgilbert@interlog.com>
References: <20200112235755.14197-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace the linked list and the fix arrays of requests (max 16)
with an xarray. The xarray (srp_arr) has two marks: one for
INACTIVE state (i.e. available for re-use) requests; the other
is AWAIT state which is after the internal completion point of
a request and before the user space has fetched the response.

Of the five states in sg_request::rq_st, two are marked. They are
SG_RS_INACTIVE and SG_RS_AWAIT_RCV. This allows the request xarray
(sg_fd::srp_arr) to be searched (with xa_for_each_mark) on two
embedded sub-lists. The SG_RS_INACTIVE sub-list replaces the free
list. The SG_RS_AWAIT_RCV sub-list contains requests that have
reached their internal completion point but have not been read/
received by the user space. Add support functions for this and
partially wire them up.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 325 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 238 insertions(+), 87 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index a303d78a7110..6e363d4177fd 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -73,7 +73,7 @@ static char *sg_version_date = "20190606";
 #define SG_MAX_CDB_SIZE 252
 
 /* Following enum contains the states of sg_request::rq_st */
-enum sg_rq_state {
+enum sg_rq_state {	/* N.B. sg_rq_state_arr assumes SG_RS_AWAIT_RCV==2 */
 	SG_RS_INACTIVE = 0,	/* request not in use (e.g. on fl) */
 	SG_RS_INFLIGHT,		/* active: cmd/req issued, no response yet */
 	SG_RS_AWAIT_RCV,	/* have response from LLD, awaiting receive */
@@ -115,6 +115,11 @@ enum sg_rq_state {
 #define SG_FDEV_DETACHING	1	/* may be unexpected device removal */
 #define SG_FDEV_LOG_SENSE	2	/* set by ioctl(SG_SET_DEBUG) */
 
+/* xarray 'mark's allow sub-lists within main array/list. */
+#define SG_XA_RQ_FREE XA_MARK_0	/* xarray sets+clears */
+#define SG_XA_RQ_INACTIVE XA_MARK_1
+#define SG_XA_RQ_AWAIT XA_MARK_2
+
 int sg_big_buff = SG_DEF_RESERVED_SIZE;
 /*
  * This variable is accessible via /proc/scsi/sg/def_reserved_size . Each
@@ -154,11 +159,11 @@ struct sg_device;		/* forward declarations */
 struct sg_fd;
 
 struct sg_request {	/* SG_MAX_QUEUE requests outstanding per file */
-	struct list_head entry;	/* list entry */
 	struct sg_scatter_hold data;	/* hold buffer, perhaps scatter list */
 	struct sg_io_hdr header;  /* scsi command+info, see <scsi/sg.h> */
 	u8 sense_b[SCSI_SENSE_BUFFERSIZE];
 	u32 duration;		/* cmd duration in milliseconds */
+	u32 rq_idx;		/* my index within parent's srp_arr */
 	char res_used;		/* 1 -> using reserve buffer, 0 -> not ... */
 	char orphan;		/* 1 -> drop on sight, 0 -> normal */
 	u32 rq_result;		/* packed scsi request result from LLD */
@@ -177,24 +182,23 @@ struct sg_request {	/* SG_MAX_QUEUE requests outstanding per file */
 struct sg_fd {		/* holds the state of a file descriptor */
 	struct sg_device *parentdp;	/* owning device */
 	wait_queue_head_t read_wait;	/* queue read until command done */
-	spinlock_t rq_list_lock;	/* protect access to list in req_arr */
 	struct mutex f_mutex;	/* protect against changes in this fd */
 	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
 	u32 idx;		/* my index within parent's sfp_arr */
-	atomic_t submitted;	/* number inflight or awaiting read */
-	atomic_t waiting;	/* number of requests awaiting read */
+	atomic_t submitted;	/* number inflight or awaiting receive */
+	atomic_t waiting;	/* number of requests awaiting receive */
+	atomic_t req_cnt;	/* number of requests */
 	int sgat_elem_sz;	/* initialized to scatter_elem_sz */
 	struct sg_scatter_hold reserve;	/* buffer for this file descriptor */
-	struct list_head rq_list; /* head of request list */
-	struct fasync_struct *async_qp;	/* used by asynchronous notification */
-	struct sg_request req_arr[SG_MAX_QUEUE];/* use as singly-linked list */
 	char force_packid;	/* 1 -> pack_id input to read(), 0 -> ignored */
 	char cmd_q;		/* 1 -> allow command queuing, 0 -> don't */
 	u8 next_cmd_len;	/* 0: automatic, >0: use on next write() */
 	char keep_orphan;	/* 0 -> drop orphan (def), 1 -> keep for read() */
 	char mmap_called;	/* 0 -> mmap() never called on this fd */
 	char res_in_use;	/* 1 -> 'reserve' array in use */
+	struct fasync_struct *async_qp;	/* used by asynchronous notification */
+	struct xarray srp_arr;
 	struct kref f_ref;
 	struct execute_work ew_fd;  /* harvest all fd resources and lists */
 };
@@ -273,6 +277,7 @@ static const char *sg_rq_st_str(enum sg_rq_state rq_st, bool long_str);
 
 #if IS_ENABLED(CONFIG_SCSI_LOGGING) && IS_ENABLED(SG_DEBUG)
 #define SG_LOG_BUFF_SZ 48
+#define SG_LOG_ACTIVE 1
 
 #define SG_LOG(depth, sfp, fmt, a...)					\
 	do {								\
@@ -730,6 +735,119 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 	return count;
 }
 
+#if IS_ENABLED(SG_LOG_ACTIVE)
+static void
+sg_rq_state_fail(struct sg_fd *sfp, enum sg_rq_state exp_old_st,
+		 enum sg_rq_state want_st, enum sg_rq_state act_old_st,
+		 const char *fromp)
+{
+	const char *eaw_rs = "expected_old,actual_old,wanted rq_st";
+
+	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
+		SG_LOG(1, sfp, "%s: %s: %s: %s,%s,%s\n",
+		       __func__, fromp, eaw_rs,
+		       sg_rq_st_str(exp_old_st, false),
+		       sg_rq_st_str(act_old_st, false),
+		       sg_rq_st_str(want_st, false));
+	else
+		pr_info("sg: %s: %s: %s: %d,%d,%d\n", __func__, fromp, eaw_rs,
+			(int)exp_old_st, (int)act_old_st, (int)want_st);
+}
+#endif
+
+static void
+sg_rq_state_force(struct sg_request *srp, enum sg_rq_state new_st)
+{
+	bool prev, want;
+	struct xarray *xafp = &srp->parentfp->srp_arr;
+
+	atomic_set(&srp->rq_st, new_st);
+	want = (new_st == SG_RS_AWAIT_RCV);
+	prev = xa_get_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
+	if (prev != want) {
+		if (want)
+			__xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
+		else
+			__xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
+	}
+	want = (new_st == SG_RS_INACTIVE);
+	prev = xa_get_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
+	if (prev != want) {
+		if (want)
+			__xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
+		else
+			__xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
+	}
+}
+
+/* Following array indexed by enum sg_rq_state, 0 means no xa mark change */
+static int sg_rq_state_arr[] = {1, 0, 4, 0, 0};
+
+static void
+sg_rq_state_helper(struct sg_request *srp, enum sg_rq_state old_st,
+		   enum sg_rq_state new_st)
+{
+	int indic = sg_rq_state_arr[(int)old_st] +
+		    (sg_rq_state_arr[(int)new_st] << 1);
+	struct xarray *xafp = &srp->parentfp->srp_arr;
+
+	if (indic == 0)
+		return;
+	if (indic & 1)		/* from inactive state */
+		__xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
+	else if (indic & 2)	/* to inactive state */
+		__xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
+	if ((indic & (4 | 8)) == 0)
+		return;
+	if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
+		return;		/* skip AWAIT mark for sync invocations */
+	if (indic & 4)		/* from await state */
+		__xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
+	else if (indic & 8)	/* to await state */
+		__xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
+}
+
+/*
+ * This function keeps the srp->rq_st state and associated marks on the
+ * owning xarray's element in sync. If force is true then new_st is stored
+ * in srp->rq_st and xarray marks are set accordingly (and old_st is
+ * ignored); and 0 is returned.
+ * If force is false, then atomic_cmpxchg() is called. If the actual
+ * srp->rq_st is not old_st, then -EPROTOTYPE is returned. If the actual
+ * srp->rq_st is old_st then it is replaced by new_st and the xarray marks
+ * are setup accordingly and 0 is returned. This assumes srp_arr xarray
+ * spinlock is held.
+ */
+static int
+sg_rq_state_chg(struct sg_request *srp, enum sg_rq_state old_st,
+		enum sg_rq_state new_st, bool force, const char *fromp)
+{
+	unsigned long iflags;
+	enum sg_rq_state act_old_st;
+	struct xarray *xafp = &srp->parentfp->srp_arr;
+
+	if (force) {
+		xa_lock_irqsave(xafp, iflags);
+		sg_rq_state_force(srp, new_st);
+		xa_unlock_irqrestore(xafp, iflags);
+		return 0;
+	}
+	act_old_st = (enum sg_rq_state)atomic_cmpxchg(&srp->rq_st, old_st,
+						      new_st);
+	if (act_old_st != old_st) {
+#if IS_ENABLED(SG_LOG_ACTIVE)
+		if (fromp)
+			sg_rq_state_fail(srp->parentfp, old_st, new_st,
+					 act_old_st, fromp);
+#endif
+		return -EPROTOTYPE;	/* only used for this error type */
+	}
+	xa_lock_irqsave(xafp, iflags);
+	sg_rq_state_helper(srp, old_st, new_st);
+	xa_unlock_irqrestore(xafp, iflags);
+	return 0;
+}
+
 /*
  * All writes and submits converge on this function to launch the SCSI
  * command/request (via blk_execute_rq_nowait). Returns a pointer to a
@@ -766,17 +884,8 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 		sg_deact_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
 	}
-	if (SG_IS_DETACHING(sdp)) {
-		if (srp->bio) {
-			scsi_req_free_cmd(scsi_req(srp->rq));
-			blk_put_request(srp->rq);
-			srp->rq = NULL;
-		}
-
-		sg_finish_scsi_blk_rq(srp);
-		sg_deact_request(sfp, srp);
-		return -ENODEV;
-	}
+	if (SG_IS_DETACHING(sdp))
+		goto err_out;
 
 	hp->duration = jiffies_to_msecs(jiffies);
 	if (hp->interface_id != '\0' &&	/* v3 (or later) interface */
@@ -785,6 +894,10 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	else
 		at_head = true;
 
+	if (!xa_get_mark(&sfp->srp_arr, srp->rq_idx, SG_XA_RQ_FREE)) {
+		SG_LOG(1, sfp, "%s: ahhh, request erased!!!\n", __func__);
+		goto err_out;
+	}
 	if (!srp->sg_io_owned)
 		atomic_inc(&sfp->submitted);
 	srp->rq->timeout = cwrp->timeout;
@@ -792,6 +905,22 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
 			      srp->rq, at_head, sg_rq_end_io);
 	return 0;
+err_out:
+	if (srp->bio) {
+		scsi_req_free_cmd(scsi_req(srp->rq));
+		blk_put_request(srp->rq);
+		srp->rq = NULL;
+	}
+	sg_finish_scsi_blk_rq(srp);
+	sg_deact_request(sfp, srp);
+	return -ENODEV;
+}
+
+static inline int
+sg_rstate_chg(struct sg_request *srp, enum sg_rq_state old_st,
+	      enum sg_rq_state new_st)
+{
+	return sg_rq_state_chg(srp, old_st, new_st, false, __func__);
 }
 
 /*
@@ -1156,12 +1285,9 @@ sg_fill_request_element(struct sg_fd *sfp, struct sg_request *srp,
 static int
 srp_done(struct sg_fd *sfp, struct sg_request *srp)
 {
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&sfp->rq_list_lock, flags);
 	ret = srp->done;
-	spin_unlock_irqrestore(&sfp->rq_list_lock, flags);
 	return ret;
 }
 
@@ -1188,15 +1314,12 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		(sfp->read_wait, (srp_done(sfp, srp) || SG_IS_DETACHING(sdp)));
 	if (SG_IS_DETACHING(sdp))
 		return -ENODEV;
-	spin_lock_irq(&sfp->rq_list_lock);
 	if (srp->done) {
 		srp->done = 2;
-		spin_unlock_irq(&sfp->rq_list_lock);
 		res = sg_receive_v3(sfp, srp, p);
 		return (res < 0) ? res : 0;
 	}
 	srp->orphan = 1;
-	spin_unlock_irq(&sfp->rq_list_lock);
 	return res;
 }
 
@@ -1245,7 +1368,7 @@ static int
 sg_ctl_req_tbl(struct sg_fd *sfp, void __user *p)
 {
 	int result, val;
-	unsigned long iflags;
+	unsigned long idx;
 	struct sg_request *srp;
 	sg_req_info_t *rinfop;
 
@@ -1253,15 +1376,17 @@ sg_ctl_req_tbl(struct sg_fd *sfp, void __user *p)
 			 GFP_KERNEL);
 	if (!rinfop)
 		return -ENOMEM;
-	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	val = 0;
-	list_for_each_entry(srp, &sfp->rq_list, entry) {
+	xa_for_each(&sfp->srp_arr, idx, srp) {
+		if (!srp)
+			continue;
+		if (xa_get_mark(&sfp->srp_arr, idx, SG_XA_RQ_AWAIT))
+			continue;
 		if (val >= SG_MAX_QUEUE)
 			break;
 		sg_fill_request_element(sfp, srp, rinfop + val);
 		val++;
 	}
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 #ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
 		result = put_compat_request_table(p, rinfop);
@@ -1309,7 +1434,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	struct sg_fd *sfp;
 	struct sg_request *srp;
 	struct scsi_device *sdev;
-	unsigned long iflags;
+	unsigned long idx;
 	__maybe_unused const char *pmlp = ", pass to mid-level";
 
 	sfp = filp->private_data;
@@ -1336,14 +1461,15 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		return 0;
 	case SG_GET_PACK_ID:    /* or tag of oldest "read"-able, -1 if none */
 		val = -1;
-		spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-		list_for_each_entry(srp, &sfp->rq_list, entry) {
+		srp = NULL;
+		xa_for_each_marked(&sfp->srp_arr, idx, srp, SG_XA_RQ_AWAIT) {
+			if (!srp)
+				continue;
 			if ((1 == srp->done) && (!srp->sg_io_owned)) {
 				val = srp->header.pack_id;
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 		SG_LOG(3, sfp, "%s:    SG_GET_PACK_ID=%d\n", __func__, val);
 		return put_user(val, ip);
 	case SG_GET_NUM_WAITING:
@@ -1744,10 +1870,10 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	struct scsi_request *scsi_rp = scsi_req(rq);
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
-	unsigned long iflags;
 	unsigned int ms;
 	int resid, slen;
 	int done = 1;
+	unsigned long iflags;
 
 	if (WARN_ON(srp->done != 0))
 		return;
@@ -1791,7 +1917,6 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	scsi_req_free_cmd(scsi_req(rq));
 	blk_put_request(rq);
 
-	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	if (unlikely(srp->orphan)) {
 		if (sfp->keep_orphan)
 			srp->sg_io_owned = 0;
@@ -1799,12 +1924,14 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 			done = 0;
 	}
 	srp->done = done;
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (likely(done)) {
 		/* Now wake up any sg_read() that is waiting for this
 		 * packet.
 		 */
+		xa_lock_irqsave(&sfp->srp_arr, iflags);
+		__xa_set_mark(&sfp->srp_arr, srp->rq_idx, SG_XA_RQ_AWAIT);
+		xa_unlock_irqrestore(&sfp->srp_arr, iflags);
 		wake_up_interruptible(&sfp->read_wait);
 		kill_fasync(&sfp->async_qp, SIGPOLL, POLL_IN);
 		kref_put(&sfp->f_ref, sg_remove_sfp);
@@ -2421,20 +2548,19 @@ sg_read_append(struct sg_request *srp, void __user *outp, int num_xfer)
 static struct sg_request *
 sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 {
-	unsigned long iflags;
+	unsigned long idx;
 	struct sg_request *resp;
 
-	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-	list_for_each_entry(resp, &sfp->rq_list, entry) {
+	xa_for_each_marked(&sfp->srp_arr, idx, resp, SG_XA_RQ_AWAIT) {
+		if (!resp)
+			continue;
 		/* look for requests that are ready + not SG_IO owned */
 		if (resp->done == 1 && !resp->sg_io_owned &&
 		    (-1 == pack_id || resp->header.pack_id == pack_id)) {
 			resp->done = 2;	/* guard against other readers */
-			spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 			return resp;
 		}
 	}
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 	return NULL;
 }
 
@@ -2504,31 +2630,51 @@ sg_build_reserve(struct sg_fd *sfp, int req_size)
 static struct sg_request *
 sg_add_request(struct sg_fd *sfp)
 {
-	int k;
-	unsigned long iflags;
-	struct sg_request *rp = sfp->req_arr;
-
-	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-	if (!list_empty(&sfp->rq_list)) {
-		if (!sfp->cmd_q)
-			goto out_unlock;
-
-		for (k = 0; k < SG_MAX_QUEUE; ++k, ++rp) {
-			if (!rp->parentfp)
-				break;
+	bool found = false;
+	int res;
+	unsigned long idx, iflags;
+	struct sg_request *rp;
+	struct xarray *xafp = &sfp->srp_arr;
+
+	if (!xa_empty(xafp)) {
+		xa_for_each_marked(xafp, idx, rp, SG_XA_RQ_INACTIVE) {
+			if (!rp)
+				continue;
+			if (sg_rstate_chg(rp, SG_RS_INACTIVE, SG_RS_BUSY))
+				continue;
+			memset(rp, 0, sizeof(*rp));
+			rp->rq_idx = idx;
+			xa_lock_irqsave(xafp, iflags);
+			__xa_clear_mark(xafp, idx, SG_XA_RQ_INACTIVE);
+			xa_unlock_irqrestore(xafp, iflags);
+			found = true;
+			break;
 		}
-		if (k >= SG_MAX_QUEUE)
-			goto out_unlock;
 	}
-	memset(rp, 0, sizeof(struct sg_request));
+	if (!found) {
+		rp = kzalloc(sizeof(*rp), GFP_KERNEL);
+		if (!rp)
+			return NULL;
+	}
 	rp->parentfp = sfp;
 	rp->header.duration = jiffies_to_msecs(jiffies);
-	list_add_tail(&rp->entry, &sfp->rq_list);
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	if (!found) {
+		u32 n_idx;
+		struct xa_limit xal = { .max = 0, .min = 0 };
+
+		atomic_set(&rp->rq_st, SG_RS_BUSY);
+		xa_lock_irqsave(xafp, iflags);
+		xal.max = atomic_inc_return(&sfp->req_cnt);
+		res = __xa_alloc(xafp, &n_idx, rp, xal, GFP_KERNEL);
+		xa_unlock_irqrestore(xafp, iflags);
+		if (res < 0) {
+			pr_warn("%s: don't expect xa_alloc() to fail, errno=%d\n",
+				__func__,  -res);
+			return NULL;
+		}
+		rp->rq_idx = n_idx;
+	}
 	return rp;
-out_unlock:
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return NULL;
 }
 
 static void
@@ -2538,14 +2684,10 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 
 	if (WARN_ON(!sfp || !srp))
 		return;
-	if (list_empty(&sfp->rq_list))
-		return;
-	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-	if (!list_empty(&srp->entry)) {
-		list_del(&srp->entry);
-		srp->parentfp = NULL;
-	}
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	xa_lock_irqsave(&sfp->srp_arr, iflags);
+	__xa_set_mark(&sfp->srp_arr, srp->rq_idx, SG_XA_RQ_INACTIVE);
+	xa_unlock_irqrestore(&sfp->srp_arr, iflags);
+	atomic_set(&srp->rq_st, SG_RS_INACTIVE);
 }
 
 static struct sg_fd *
@@ -2562,8 +2704,7 @@ sg_add_sfp(struct sg_device *sdp)
 		return ERR_PTR(-ENOMEM);
 
 	init_waitqueue_head(&sfp->read_wait);
-	spin_lock_init(&sfp->rq_list_lock);
-	INIT_LIST_HEAD(&sfp->rq_list);
+	xa_init_flags(&sfp->srp_arr, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	kref_init(&sfp->f_ref);
 	mutex_init(&sfp->f_mutex);
 	sfp->timeout = SG_DEFAULT_TIMEOUT;
@@ -2582,6 +2723,7 @@ sg_add_sfp(struct sg_device *sdp)
 	sfp->parentdp = sdp;
 	atomic_set(&sfp->submitted, 0);
 	atomic_set(&sfp->waiting, 0);
+	atomic_set(&sfp->req_cnt, 0);
 
 	if (SG_IS_DETACHING(sdp)) {
 		kfree(sfp);
@@ -2628,11 +2770,13 @@ static void
 sg_remove_sfp_usercontext(struct work_struct *work)
 {
 	__maybe_unused int o_count;
-	unsigned long iflags;
+	unsigned long idx, iflags;
 	struct sg_device *sdp;
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew_fd.work);
 	struct sg_fd *e_sfp;
 	struct sg_request *srp;
+	struct sg_request *e_srp;
+	struct xarray *xafp = &sfp->srp_arr;
 
 	if (!sfp) {
 		pr_warn("sg: %s: sfp is NULL\n", __func__);
@@ -2641,15 +2785,20 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 	sdp = sfp->parentdp;
 
 	/* Cleanup any responses which were never read(). */
-	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-	while (!list_empty(&sfp->rq_list)) {
-		srp = list_first_entry(&sfp->rq_list, struct sg_request, entry);
-		sg_finish_scsi_blk_rq(srp);
-		list_del(&srp->entry);
-		srp->parentfp = NULL;
-	}
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-
+	xa_for_each(xafp, idx, srp) {
+		if (!srp)
+			continue;
+		if (!xa_get_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE))
+			sg_finish_scsi_blk_rq(srp);
+		xa_lock_irqsave(xafp, iflags);
+		e_srp = __xa_erase(xafp, srp->rq_idx);
+		xa_unlock_irqrestore(xafp, iflags);
+		if (srp != e_srp)
+			SG_LOG(1, sfp, "%s: xa_erase() return unexpected\n",
+			       __func__);
+		kfree(srp);
+	}
+	xa_destroy(xafp);
 	if (sfp->reserve.buflen > 0) {
 		SG_LOG(6, sfp, "%s:    buflen=%d, num_sgat=%d\n", __func__,
 		       (int)sfp->reserve.buflen, (int)sfp->reserve.num_sgat);
@@ -2742,7 +2891,9 @@ sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 		return long_str ? "unknown" : "unk";
 	}
 }
-#else
+
+#elif IS_ENABLED(SG_LOG_ACTIVE)
+
 static const char *
 sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 {
@@ -2994,7 +3145,7 @@ static void
 sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
 {
 	int k, new_interface, blen, usg;
-	unsigned long idx;
+	unsigned long idx, idx2;
 	struct sg_request *srp;
 	struct sg_fd *fp;
 	const struct sg_io_hdr *hp;
@@ -3006,7 +3157,6 @@ sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
 		if (!fp)
 			continue;
 		k++;
-		spin_lock(&fp->rq_list_lock); /* irqs already disabled */
 		seq_printf(s, "   FD(%d): timeout=%dms buflen=%d (res)sgat=%d low_dma=%d idx=%lu\n",
 			   k, jiffies_to_msecs(fp->timeout),
 			   fp->reserve.buflen, (int)fp->reserve.num_sgat,
@@ -3017,7 +3167,9 @@ sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
 		seq_printf(s, "   submitted=%d waiting=%d\n",
 			   atomic_read(&fp->submitted),
 			   atomic_read(&fp->waiting));
-		list_for_each_entry(srp, &fp->rq_list, entry) {
+		xa_for_each(&fp->srp_arr, idx2, srp) {
+			if (!srp)
+				continue;
 			hp = &srp->header;
 			new_interface = (hp->interface_id == '\0') ? 0 : 1;
 			if (srp->res_used) {
@@ -3053,9 +3205,8 @@ sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
 				   (int)srp->data.cmd_opcode,
 				   sg_rq_st_str(SG_RS_INACTIVE, false));
 		}
-		if (list_empty(&fp->rq_list))
+		if (xa_empty(&fp->srp_arr))
 			seq_puts(s, "     No requests active\n");
-		spin_unlock(&fp->rq_list_lock);
 	}
 }
 
-- 
2.24.1

