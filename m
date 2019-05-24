Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDDC29E62
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403785AbfEXSsj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:39 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56410 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391612AbfEXSsi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 08CF2204165;
        Fri, 24 May 2019 20:48:36 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KBsTs+w-ug-B; Fri, 24 May 2019 20:48:32 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id A595320417E;
        Fri, 24 May 2019 20:48:25 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 12/19] sg: add sg_set_get_extended ioctl
Date:   Fri, 24 May 2019 14:48:02 -0400
Message-Id: <20190524184809.25121-13-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add ioctl(SG_SET_GET_EXTENDED) together with its interface:
struct sg_extended_info which is 96 bytes long, only half
of which is currently used. The "SET_GET" component of the
name is to stress data flows towards and back from the ioctl.

That ioctl has three sections: one for getting and setting 32
bit quantities, a second section for manipulating boolean
(bit) flags, and a final section for reading 32 bit
quantities where a well known value is written and the
corresponding value is read back. Several settings can be
made in one invocation.

See the webpage at: http://sg.danny.cz/sg/sg_v40.html
specifically the section titled: "13 IOCTLs".

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 252 +++++++++++++++++++++++++++++++++++++----
 include/uapi/scsi/sg.h |  67 +++++++++++
 2 files changed, 295 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index a261ad2c4567..c014fb24eca1 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -41,9 +41,9 @@ static char *sg_version_date = "20190520";
 #include <linux/atomic.h>
 #include <linux/ratelimit.h>
 #include <linux/uio.h>
-#include <linux/cred.h>			/* for sg_check_file_access() */
+#include <linux/cred.h>		/* for sg_check_file_access() */
 #include <linux/bsg.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_fs.h>	/* used if CONFIG_SCSI_PROC_FS */
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_eh.h>
@@ -120,7 +120,9 @@ enum sg_rq_state {
 #define SG_FFD_CMD_Q		1	/* clear: only 1 active req per fd */
 #define SG_FFD_KEEP_ORPHAN	2	/* policy for this fd */
 #define SG_FFD_MMAP_CALLED	3	/* mmap(2) system call made on fd */
+#define SG_FFD_TIME_IN_NS	4	/* set: time in nanoseconds, else ms */
 #define SG_FFD_Q_AT_TAIL	5	/* set: queue reqs at tail of blk q */
+#define SG_FFD_NO_DURATION	9	/* don't do command duration calc */
 
 
 int sg_big_buff = SG_DEF_RESERVED_SIZE;
@@ -271,13 +273,12 @@ static void sg_rq_end_io(struct request *rq, blk_status_t status);
 static int sg_proc_init(void);
 static int sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp,
 			int dxfer_dir);
-// static int sg_finish_rem_req(struct sg_request *srp);
 static void sg_finish_scsi_blk_rq(struct sg_request *srp);
 static int sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen);
 static int sg_v3_submit(struct file *filp, struct sg_fd *sfp,
 			struct sg_io_hdr *hp, bool sync,
 			struct sg_request **o_srp);
-static struct sg_request *sg_common_write(struct sg_comm_wr_t *cwp);
+static struct sg_request *sg_common_write(struct sg_comm_wr_t *cwrp);
 static int sg_rd_append(struct sg_request *srp, void __user *outp,
 			int num_xfer);
 static void sg_remove_sgat(struct sg_request *srp);
@@ -302,6 +303,7 @@ static void sg_rep_rq_state_fail(struct sg_device *sdp,
 #define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
 #define SZ_SG_IO_V4 ((int)sizeof(struct sg_io_v4))  /* v4 header (in bsg.h) */
 #define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
+#define SZ_SG_EXTENDED_INFO ((int)sizeof(struct sg_extended_info))
 
 /* There is a assert that SZ_SG_IO_V4 >= SZ_SG_IO_HDR in first function */
 
@@ -440,11 +442,11 @@ static int
 sg_open(struct inode *inode, struct file *filp)
 {
 	bool o_excl, non_block;
+	int res;
 	int min_dev = iminor(inode);
 	int op_flags = filp->f_flags;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
-	int res;
 
 	nonseekable_open(inode, filp);
 	o_excl = !!(op_flags & O_EXCL);
@@ -508,7 +510,6 @@ sg_open(struct inode *inode, struct file *filp)
 
 	filp->private_data = sfp;
 	sfp->tid = (current ? current->pid : -1);
-	sfp->tid = (current ? current->pid : -1);
 	atomic_inc(&sdp->open_cnt);
 	mutex_unlock(&sdp->open_rel_lock);
 
@@ -842,7 +843,10 @@ sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 	is_v4h = test_bit(SG_FRQ_IS_V4I, srp->frq_bm);
 	sync = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
 	SG_LOG(3, sdp, "%s: is_v4h=%d\n", __func__, (int)is_v4h);
-	srp->start_ns = ktime_get_boot_ns();
+	if (test_bit(SG_FFD_NO_DURATION, sfp->ffd_bm))
+		srp->start_ns = 0;
+	else
+		srp->start_ns = ktime_get_boot_ns();	/* assume always > 0 */
 	srp->duration = 0;
 
 	if (!is_v4h && srp->s_hdr3.interface_id == '\0')
@@ -1473,29 +1477,42 @@ sg_calc_sgat_param(struct sg_device *sdp)
 	sdp->max_sgat_sz = sz;
 }
 
+/*
+ * Returns duration since srp->start_ns (using boot time as an epoch). Unit
+ * is nanoseconds when time_in_ns==true; else it is in milliseconds.
+ * For backward compatibility the duration is placed in a 32 bit unsigned
+ * integer. This limits the maximum nanosecond duration that can be
+ * represented (without wrapping) to about 4.3 seconds. If that is exceeded
+ * return equivalent of 3.999.. secs as it is more eye catching than the real
+ * number. Negative durations should not be possible but if they occur set
+ * duration to an unlikely 2 nanosec. Stalls in a request setup will have
+ * ts0==U64_MAX and will return 1 for an unlikely 1 nanosecond duration.
+ */
 static u32
-sg_calc_rq_dur(const struct sg_request *srp)
+sg_calc_rq_dur(const struct sg_request *srp, bool time_in_ns)
 {
 	ktime_t ts0 = srp->start_ns;
 	ktime_t now_ts;
 	s64 diff;
 
-	if (ts0 == 0)
+	if (ts0 == 0)	/* only when SG_FFD_NO_DURATION is set */
 		return 0;
 	if (unlikely(ts0 == U64_MAX))	/* _prior_ to issuing req */
-		return 999999999;	/* eye catching */
+		return time_in_ns ? 1 : 999999999;
 	now_ts = ktime_get_boot_ns();
 	if (unlikely(ts0 > now_ts))
-		return 999999998;
-	/* unlikely req duration will exceed 2**32 milliseconds */
-	diff = ktime_ms_delta(now_ts, ts0);
+		return time_in_ns ? 2 : 999999998;
+	if (time_in_ns)
+		diff = ktime_to_ns(ktime_sub(now_ts, ts0));
+	else	/* unlikely req duration will exceed 2**32 milliseconds */
+		diff = ktime_ms_delta(now_ts, ts0);
 	return (diff > (s64)U32_MAX) ? 3999999999U : (u32)diff;
 }
 
 /* Return of U32_MAX means srp is inactive or in slave waiting state */
 static u32
 sg_get_dur(struct sg_request *srp, const enum sg_rq_state *sr_stp,
-	   bool *is_durp)
+	   bool time_in_ns, bool *is_durp)
 {
 	bool is_dur = false;
 	u32 res = U32_MAX;
@@ -1503,7 +1520,7 @@ sg_get_dur(struct sg_request *srp, const enum sg_rq_state *sr_stp,
 	switch (sr_stp ? *sr_stp : atomic_read(&srp->rq_st)) {
 	case SG_RS_INFLIGHT:
 	case SG_RS_BUSY:
-		res = sg_calc_rq_dur(srp);
+		res = sg_calc_rq_dur(srp, time_in_ns);
 		break;
 	case SG_RS_AWAIT_RD:
 	case SG_RS_DONE_RD:
@@ -1525,7 +1542,8 @@ sg_fill_request_element(struct sg_fd *sfp, struct sg_request *srp,
 		__must_hold(&sfp->rq_list_lock)
 {
 	spin_lock(&srp->req_lck);
-	rip->duration = sg_get_dur(srp, NULL, NULL);
+	rip->duration = sg_get_dur(srp, NULL, test_bit(SG_FFD_TIME_IN_NS,
+						       sfp->ffd_bm), NULL);
 	if (rip->duration == U32_MAX)
 		rip->duration = 0;
 	rip->orphan = test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm);
@@ -1802,6 +1820,177 @@ sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
 	return res;
 }
 
+/*
+ * Processing of ioctl(SG_SET_GET_EXTENDED(SG_SEIM_CTL_FLAGS)) which is a set
+ * of boolean flags. Access abbreviations: [rw], read-write; [ro], read-only;
+ * [wo], write-only; [raw], read after write; [rbw], read before write.
+ */
+static void
+sg_extended_bool_flags(struct sg_fd *sfp, struct sg_extended_info *seip)
+{
+	bool flg = false;
+	u32 c_flgs_wm = seip->ctl_flags_wr_mask;
+	u32 c_flgs_rm = seip->ctl_flags_rd_mask;
+	u32 *c_flgsp = &seip->ctl_flags;
+	struct sg_device *sdp = sfp->parentdp;
+
+	/* TIME_IN_NS boolean, [raw] time in nanoseconds (def: millisecs) */
+	if (c_flgs_wm & SG_CTL_FLAGM_TIME_IN_NS)
+		assign_bit(SG_FFD_TIME_IN_NS, sfp->ffd_bm,
+			   !!(*c_flgsp & SG_CTL_FLAGM_TIME_IN_NS));
+	if (c_flgs_rm & SG_CTL_FLAGM_TIME_IN_NS) {
+		if (test_bit(SG_FFD_TIME_IN_NS, sfp->ffd_bm))
+			*c_flgsp |= SG_CTL_FLAGM_TIME_IN_NS;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_TIME_IN_NS;
+	}
+	/* OTHER_OPENS boolean, [ro] any other sg open fds on this dev? */
+	if (c_flgs_rm & SG_CTL_FLAGM_OTHER_OPENS) {
+		if (atomic_read(&sdp->open_cnt) > 1)
+			*c_flgsp |= SG_CTL_FLAGM_OTHER_OPENS;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_OTHER_OPENS;
+	}
+	/* Q_TAIL boolean, [raw] 1: queue at tail; 0: head (def: depends) */
+	if (c_flgs_wm & SG_CTL_FLAGM_Q_TAIL)
+		assign_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm,
+			   !!(*c_flgsp & SG_CTL_FLAGM_Q_TAIL));
+	if (c_flgs_rm & SG_CTL_FLAGM_Q_TAIL) {
+		if (test_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm))
+			*c_flgsp |= SG_CTL_FLAGM_Q_TAIL;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_Q_TAIL;
+	}
+	/* NO_DURATION boolean, [rbw] */
+	if (c_flgs_rm & SG_CTL_FLAGM_NO_DURATION)
+		flg = test_bit(SG_FFD_NO_DURATION, sfp->ffd_bm);
+	if (c_flgs_wm & SG_CTL_FLAGM_NO_DURATION)
+		assign_bit(SG_FFD_NO_DURATION, sfp->ffd_bm,
+			   !!(*c_flgsp & SG_CTL_FLAGM_NO_DURATION));
+	if (c_flgs_rm & SG_CTL_FLAGM_NO_DURATION) {
+		if (flg)
+			*c_flgsp |= SG_CTL_FLAGM_NO_DURATION;
+		else
+			*c_flgsp &= ~SG_CTL_FLAGM_NO_DURATION;
+	}
+}
+
+static void
+sg_extended_read_value(struct sg_fd *sfp, struct sg_extended_info *seip)
+{
+	u32 uv;
+	unsigned long iflags;
+	struct sg_fd *a_sfp;
+	struct sg_device *sdp = sfp->parentdp;
+	struct sg_request *srp;
+
+	switch (seip->read_value) {
+	case SG_SEIRV_INT_MASK:
+		seip->read_value = SG_SEIM_ALL_BITS;
+		break;
+	case SG_SEIRV_BOOL_MASK:
+		seip->read_value = SG_CTL_FLAGM_ALL_BITS;
+		break;
+	case SG_SEIRV_VERS_NUM:
+		seip->read_value = sg_version_num;
+		break;
+	case SG_SEIRV_FL_RQS:
+		uv = 0;
+		rcu_read_lock();
+		list_for_each_entry_rcu(srp, &sfp->rq_fl, fl_entry)
+			++uv;
+		rcu_read_unlock();
+		seip->read_value = uv;
+		break;
+	case SG_SEIRV_DEV_FL_RQS:
+		uv = 0;
+		read_lock_irqsave(&sdp->sfd_llock, iflags);
+		list_for_each_entry(a_sfp, &sdp->sfds, sfd_entry) {
+			rcu_read_lock();
+			list_for_each_entry_rcu(srp, &a_sfp->rq_fl, fl_entry)
+				++uv;
+			rcu_read_unlock();
+		}
+		read_unlock_irqrestore(&sdp->sfd_llock, iflags);
+		seip->read_value = uv;
+		break;
+	case SG_SEIRV_SUBMITTED:  /* counts all non-blocking on active list */
+		seip->read_value = (u32)atomic_read(&sfp->submitted);
+		break;
+	case SG_SEIRV_DEV_SUBMITTED: /* sum(submitted) on all fd's siblings */
+		uv = 0;
+		read_lock_irqsave(&sdp->sfd_llock, iflags);
+		list_for_each_entry(a_sfp, &sdp->sfds, sfd_entry)
+			uv += (u32)atomic_read(&a_sfp->submitted);
+		read_unlock_irqrestore(&sdp->sfd_llock, iflags);
+		seip->read_value = uv;
+		break;
+	default:
+		SG_LOG(6, sdp, "%s: can't decode %d --> read_value\n",
+		       __func__, seip->read_value);
+		seip->read_value = 0;
+		break;
+	}
+}
+
+/* Called when processing ioctl(SG_SET_GET_EXTENDED) */
+static int
+sg_ctl_extended(struct sg_fd *sfp, void __user *p)
+{
+	int result = 0;
+	int ret = 0;
+	int s_wr_mask, s_rd_mask;
+	u32 or_masks;
+	struct sg_device *sdp = sfp->parentdp;
+	struct sg_extended_info *seip;
+	struct sg_extended_info sei;
+
+	seip = &sei;
+	if (copy_from_user(seip, p, SZ_SG_EXTENDED_INFO))
+		return -EFAULT;
+	s_wr_mask = seip->sei_wr_mask;
+	s_rd_mask = seip->sei_rd_mask;
+	or_masks = s_wr_mask | s_rd_mask;
+	if (or_masks == 0) {
+		SG_LOG(2, sdp, "%s: both masks 0, do nothing\n", __func__);
+		return 0;
+	}
+	SG_LOG(3, sdp, "%s: wr_mask=0x%x rd_mask=0x%x\n", __func__, s_wr_mask,
+	       s_rd_mask);
+	/* check all boolean flags for either wr or rd mask set in or_mask */
+	if (or_masks & SG_SEIM_CTL_FLAGS)
+		sg_extended_bool_flags(sfp, seip);
+	/* yields minor_index (type: u32) [ro] */
+	if (or_masks & SG_SEIM_MINOR_INDEX) {
+		if (s_wr_mask & SG_SEIM_MINOR_INDEX) {
+			SG_LOG(2, sdp, "%s: writing to minor_index ignored\n",
+			       __func__);
+		}
+		if (s_rd_mask & SG_SEIM_MINOR_INDEX)
+			seip->minor_index = sdp->index;
+	}
+	if ((s_rd_mask & SG_SEIM_READ_VAL) && (s_wr_mask & SG_SEIM_READ_VAL))
+		sg_extended_read_value(sfp, seip);
+	/* reserved_sz [raw], since may be reduced by other limits */
+	if (s_wr_mask & SG_SEIM_RESERVED_SIZE) {
+		mutex_lock(&sfp->f_mutex);
+		result = sg_set_reserved_sz(sfp, (int)seip->reserved_sz);
+		if (ret == 0 && result)
+			ret = result;
+		mutex_unlock(&sfp->f_mutex);
+	}
+	if (s_rd_mask & SG_SEIM_RESERVED_SIZE)
+		seip->reserved_sz = (u32)min_t(int,
+					       sfp->rsv_srp->sgat_h.buflen,
+					       sdp->max_sgat_sz);
+	/* copy to user space if int or boolean read mask non-zero */
+	if (s_rd_mask || seip->ctl_flags_rd_mask) {
+		if (copy_to_user(p, seip, SZ_SG_EXTENDED_INFO))
+			ret = ret ? ret : -EFAULT;
+	}
+	return ret;
+}
+
 /*
  * For backward compatibility, output SG_MAX_QUEUE sg_req_info objects. First
  * fetch from the active list then, if there is still room, from the free
@@ -1928,6 +2117,9 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		res = sg_ctl_abort(sdp, sfp, p);
 		mutex_unlock(&sfp->f_mutex);
 		return res;
+	case SG_SET_GET_EXTENDED:
+		SG_LOG(3, sdp, "%s:    SG_SET_GET_EXTENDED\n", __func__);
+		return sg_ctl_extended(sfp, p);
 	case SG_GET_SCSI_ID:
 		return sg_ctl_scsi_id(sdev, sdp, p);
 	case SG_SET_FORCE_PACK_ID:
@@ -2452,7 +2644,9 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 
 	SG_LOG(6, sdp, "%s: pack_id=%d, res=0x%x\n", __func__, srp->pack_id,
 	       srp->rq_result);
-	srp->duration = sg_calc_rq_dur(srp);
+	if (srp->start_ns > 0)	/* zero only when SG_FFD_NO_DURATION is set */
+		srp->duration = sg_calc_rq_dur(srp, test_bit(SG_FFD_TIME_IN_NS,
+							     sfp->ffd_bm));
 	if (unlikely((srp->rq_result & SG_ML_RESULT_MSK) && slen > 0))
 		sg_check_sense(sdp, srp, slen);
 	if (slen > 0) {
@@ -3441,6 +3635,9 @@ sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
 	r_srp->frq_bm[0] = cwrp->frq_bm[0];	/* assumes <= 32 req flags */
 	r_srp->sgat_h.dlen = dxfr_len;/* must be <= r_srp->sgat_h.buflen */
 	r_srp->cmd_opcode = 0xff;  /* set invalid opcode (VS), 0x0 is TUR */
+	/* If setup stalls (e.g. blk_get_request()) debug shows 'elap=1 ns' */
+	if (test_bit(SG_FFD_TIME_IN_NS, fp->ffd_bm))
+		r_srp->start_ns = U64_MAX;
 	if (mk_new_srp)
 		spin_lock_irqsave(&fp->rq_list_lock, iflags);
 	list_add_tail_rcu(&r_srp->rq_entry, &fp->rq_list);
@@ -3543,6 +3740,7 @@ sg_add_sfp(struct sg_device *sdp)
 	assign_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm, SG_DEF_FORCE_PACK_ID);
 	assign_bit(SG_FFD_CMD_Q, sfp->ffd_bm, SG_DEF_COMMAND_Q);
 	assign_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm, SG_DEF_KEEP_ORPHAN);
+	assign_bit(SG_FFD_TIME_IN_NS, sfp->ffd_bm, SG_DEF_TIME_UNIT);
 	assign_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm, SG_DEFAULT_Q_AT);
 	atomic_set(&sfp->submitted, 0);
 	atomic_set(&sfp->waiting, 0);
@@ -3979,7 +4177,8 @@ sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 
 /* Writes debug info for one sg_request in obp buffer */
 static int
-sg_proc_dbg_sreq(struct sg_request *srp, int to, char *obp, int len)
+sg_proc_dbg_sreq(struct sg_request *srp, int to, bool t_in_ns, char *obp,
+		 int len)
 	__must_hold(&srp->req_lck)
 {
 	bool is_v3v4, v4, is_dur;
@@ -3987,6 +4186,7 @@ sg_proc_dbg_sreq(struct sg_request *srp, int to, char *obp, int len)
 	u32 dur;
 	enum sg_rq_state rq_st;
 	const char *cp;
+	const char *tp = t_in_ns ? "ns" : "ms";
 
 	if (len < 1)
 		return 0;
@@ -3999,15 +4199,15 @@ sg_proc_dbg_sreq(struct sg_request *srp, int to, char *obp, int len)
 		cp = (srp->rq_info & SG_INFO_DIRECT_IO_MASK) ?
 				"     dio>> " : "     ";
 	rq_st = atomic_read(&srp->rq_st);
-	dur = sg_get_dur(srp, &rq_st, &is_dur);
+	dur = sg_get_dur(srp, &rq_st, t_in_ns, &is_dur);
 	n += scnprintf(obp + n, len - n, "%s%s: dlen=%d/%d id=%d", cp,
 		       sg_rq_st_str(rq_st, false), srp->sgat_h.dlen,
 		       srp->sgat_h.buflen, (int)srp->pack_id);
 	if (is_dur)	/* cmd/req has completed, waiting for ... */
-		n += scnprintf(obp + n, len - n, " dur=%ums", dur);
+		n += scnprintf(obp + n, len - n, " dur=%u%s", dur, tp);
 	else if (dur < U32_MAX)	/* in-flight or busy (so ongoing) */
-		n += scnprintf(obp + n, len - n, " t_o/elap=%us/%ums",
-			       to / 1000, dur);
+		n += scnprintf(obp + n, len - n, " t_o/elap=%us/%u%s",
+			       to / 1000, dur, tp);
 	n += scnprintf(obp + n, len - n, " sgat=%d op=0x%02x\n",
 		       srp->sgat_h.num_sgat, srp->cmd_opcode);
 	return n;
@@ -4045,7 +4245,9 @@ sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len)
 		       atomic_read(&fp->waiting), fp->tid);
 	list_for_each_entry_rcu(srp, &fp->rq_list, rq_entry) {
 		spin_lock(&srp->req_lck);
-		n += sg_proc_dbg_sreq(srp, fp->timeout, obp + n, len - n);
+		n += sg_proc_dbg_sreq(srp, fp->timeout,
+				      test_bit(SG_FFD_TIME_IN_NS, fp->ffd_bm),
+				      obp + n, len - n);
 		spin_unlock(&srp->req_lck);
 	}
 	if (list_empty(&fp->rq_list))
@@ -4057,7 +4259,9 @@ sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len)
 			first_fl = false;
 		}
 		spin_lock(&srp->req_lck);
-		n += sg_proc_dbg_sreq(srp, fp->timeout, obp + n, len - n);
+		n += sg_proc_dbg_sreq(srp, fp->timeout,
+				      test_bit(SG_FFD_TIME_IN_NS, fp->ffd_bm),
+				      obp + n, len - n);
 		spin_unlock(&srp->req_lck);
 	}
 	return n;
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 8181e36442a8..ca2b4819ddcd 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -154,6 +154,70 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 	int unused;
 } sg_req_info_t;
 
+/*
+ * The following defines are for manipulating struct sg_extended_info which
+ * is abbreviated to "SEI". A following "M" (i.e. "_SEIM_") indicates a
+ * mask. Most mask values correspond to a integer (usually a uint32_t) apart
+ * from SG_SEIM_CTL_FLAGS which is for boolean values packed into an integer.
+ * The mask values for those booleans start with "SG_CTL_FLAGM_". The scope
+ * of these settings, like most other ioctls, is usually that of the file
+ * descriptor the ioctl is executed on. The "rd:" indication means read-only,
+ * attempts to write to them are ignored. "rd>" means action when reading.
+ */
+#define SG_SEIM_CTL_FLAGS	0x1	/* ctl_flags_mask bits in ctl_flags */
+#define SG_SEIM_READ_VAL	0x2	/* write SG_SEIRV_*, read back value */
+#define SG_SEIM_RESERVED_SIZE	0x4	/* reserved_sz of reserve request */
+#define SG_SEIM_MINOR_INDEX	0x10	/* sg device minor index number */
+#define SG_SEIM_SGAT_ELEM_SZ	0x80	/* sgat element size (>= PAGE_SIZE) */
+#define SG_SEIM_ALL_BITS	0xff	/* should be OR of previous items */
+
+/* flag and mask values for boolean fields follow */
+#define SG_CTL_FLAGM_TIME_IN_NS	0x1	/* time: nanosecs (def: millisecs) */
+#define SG_CTL_FLAGM_OTHER_OPENS 0x4	/* rd: other sg fd_s on this dev */
+#define SG_CTL_FLAGM_ORPHANS	0x8	/* rd: orphaned requests on this fd */
+#define SG_CTL_FLAGM_Q_TAIL	0x10	/* used for future cmds on this fd */
+#define SG_CTL_FLAGM_NO_DURATION 0x400	/* don't calc command duration */
+#define SG_CTL_FLAGM_ALL_BITS	0xfff	/* should be OR of previous items */
+
+/* Write one of the following values to sg_extended_info::read_value, get... */
+#define SG_SEIRV_INT_MASK	0x0	/* get SG_SEIM_ALL_BITS */
+#define SG_SEIRV_BOOL_MASK	0x1	/* get SG_CTL_FLAGM_ALL_BITS */
+#define SG_SEIRV_VERS_NUM	0x2	/* get driver version number as int */
+#define SG_SEIRV_FL_RQS		0x3	/* number of requests in free list */
+#define SG_SEIRV_DEV_FL_RQS	0x4	/* sum(fl rqs) on all dev's fds */
+#define SG_SEIRV_SUBMITTED	0x5	/* number of mrqs submitted+unread */
+#define SG_SEIRV_DEV_SUBMITTED	0x6	/* sum(submitted) on all dev's fds */
+
+/*
+ * A pointer to the following structure is passed as the third argument to
+ * ioctl(SG_SET_GET_EXTENDED). Each bit in the *_wr_mask fields causes the
+ * corresponding integer (e.g. reserved_sz) or bit (e.g. the
+ * SG_CTL_FLAG_TIME_IN_NS bit in ctl_flags) to be read from the user space
+ * and modify the driver. Each bit in the *_rd_mask fields causes the
+ * corresponding integer or bit to be fetched from the driver and written
+ * back to the user space. If the same bit is set in both the *_wr_mask and
+ * corresponding *_rd_mask fields, then which one comes first depends on the
+ * setting but no other operation will split the two. This structure is
+ * padded to 96 bytes to allow for new values to be added in the future.
+ */
+
+/* If both sei_wr_mask and sei_rd_mask are 0, this ioctl does nothing */
+struct sg_extended_info {
+	__u32	sei_wr_mask;	/* OR-ed SG_SEIM_* user->driver values */
+	__u32	sei_rd_mask;	/* OR-ed SG_SEIM_* driver->user values */
+	__u32	ctl_flags_wr_mask;	/* OR-ed SG_CTL_FLAGM_* values */
+	__u32	ctl_flags_rd_mask;	/* OR-ed SG_CTL_FLAGM_* values */
+	__u32	ctl_flags;	/* bit values OR-ed, see SG_CTL_FLAGM_* */
+	__u32	read_value;	/* write SG_SEIRV_*, read back related */
+
+	__u32	reserved_sz;	/* data/sgl size of pre-allocated request */
+	__u32	tot_fd_thresh;	/* total data/sgat for this fd, 0: no limit */
+	__u32	minor_index;	/* rd: kernel's sg device minor number */
+	__u32	share_fd;	/* SHARE_FD and CHG_SHARE_FD use this */
+	__u32	sgat_elem_sz;	/* sgat element size (must be power of 2) */
+	__u8	pad_to_96[52];	/* pad so struct is 96 bytes long */
+};
+
 /*
  * IOCTLs: Those ioctls that are relevant to the SG 3.x drivers follow.
  * [Those that only apply to the SG 2.x drivers are at the end of the file.]
@@ -183,6 +247,9 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
  */
 #define SG_IOCTL_MAGIC_NUM 0x22
 
+#define SG_SET_GET_EXTENDED _IOWR(SG_IOCTL_MAGIC_NUM, 0x51,	\
+				  struct sg_extended_info)
+
 /* The following ioctl has a 'sg_scsi_id_t *' object as its 3rd argument. */
 #define SG_GET_SCSI_ID 0x2276   /* Yields fd's bus, chan, dev, lun + type */
 /* SCSI id information can also be obtained from SCSI_IOCTL_GET_IDLUN */
-- 
2.17.1

