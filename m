Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDA29E65
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbfEXSso (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:44 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56431 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391503AbfEXSso (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1A186204162;
        Fri, 24 May 2019 20:48:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5-HtJXPAkSQT; Fri, 24 May 2019 20:48:39 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 87F0D204190;
        Fri, 24 May 2019 20:48:31 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 17/19] sg: add multiple request support
Date:   Fri, 24 May 2019 14:48:07 -0400
Message-Id: <20190524184809.25121-18-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Before the write() and read() system calls were removed from
the bsg driver (around lk 4.15) bsg supported multiple SCSI
requests being submitted in a single invocation. It did this
by passing an array of struct sg_io_v4 objects to the write()
whose third argument (the size the second argument points to)
is then a multiple of sizeof(sg_io_v4).

Doing the same with ioctl(SG_IOSUBMIT) is not practical since
with an ioctl() there is no "length of passed object" argument.
Further the __IOWR macro used to generate the ioctl number for
SG_IOSUBMIT encodes the expected length of the passed object,
and that is the size of a _single_ struct sg_io_v4 object.
So an indirect approach is taken: any object passed to
ioctl(SG_IO), ioctl(SG_IOSUBMIT) and ioctl(SG_IORECEIVE) with
SGV4_FLAG_MULTIPLE_REQS set is interpreted as a "controlling
object". It is parsed differently from other struct sg_io_v4
objects. Its data-out buffer contains an array of "normal"
struct sg_io_v4 objects.

Multiple requests can be combined with shared file
descriptors with SGV4_FLAG_DO_ON_OTHER indicating the other
file descriptor (in the share) is to be used for the
command it appears with. Multiple requests can be combined
with shared requests.

As a further optimisation, an array of SCSI commands can
be passed from the user space via the controlling object's
request "pointer". Without that, the multiple request
logic would need to visit the user space once per command
to pick up each SCSI command (cdb).

See the webpage at: http://sg.danny.cz/sg/sg_v40.html
in the section titled: "9 Multiple requests"

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 616 ++++++++++++++++++++++++++++++++++++++++-
 include/uapi/scsi/sg.h |  11 +-
 2 files changed, 624 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 9adca3988c58..92a0226cabc2 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -62,6 +62,7 @@ static char *sg_version_date = "20190520";
 #define SG_ALLOW_DIO_DEF 0
 
 #define SG_MAX_DEVS 32768
+#define SG_MAX_MULTI_REQ_SZ (2 * 1024 * 1024)
 
 /* Comment out the following line to compile out SCSI_LOGGING stuff */
 #define SG_DEBUG 1
@@ -132,6 +133,7 @@ enum sg_shr_var {
 #define SG_FRQ_NO_US_XFER	4	/* no user space transfer of data */
 #define SG_FRQ_ABORTING		5	/* in process of aborting this cmd */
 #define SG_FRQ_DEACT_ORPHAN	7	/* not keeping orphan so de-activate */
+#define SG_FRQ_MULTI_REQ	8	/* part of a multiple request series */
 #define SG_FRQ_BLK_PUT_REQ	9	/* set when blk_put_request() called */
 
 /* Bit positions (flags) for sg_fd::ffd_bm bitmask follow */
@@ -196,6 +198,7 @@ struct sg_slice_hdr4 {	/* parts of sg_io_v4 object needed in async usage */
 	s16 dir;		/* data xfer direction; SG_DXFER_*  */
 	u16 cmd_len;		/* truncated of sg_io_v4::request_len */
 	u16 max_sb_len;		/* truncated of sg_io_v4::max_response_len */
+	u16 mrq_ind;		/* position in parentfp->mrq_arr */
 };
 
 struct sg_scatter_hold {     /* holding area for scsi scatter gather info */
@@ -311,6 +314,10 @@ static int sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp,
 static int sg_v3_submit(struct sg_fd *sfp, struct sg_io_hdr *hp, bool sync,
 			struct sg_request **o_srp);
 static struct sg_request *sg_common_write(struct sg_comm_wr_t *cwrp);
+static int sg_wait_event_srp(struct sg_fd *sfp, void __user *p,
+			     struct sg_io_v4 *h4p, struct sg_request *srp);
+static int sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp,
+			 void __user *p, struct sg_io_v4 *h4p);
 static int sg_rd_append(struct sg_request *srp, void __user *outp,
 			int num_xfer);
 static void sg_remove_sgat(struct sg_request *srp);
@@ -318,6 +325,7 @@ static struct sg_fd *sg_add_sfp(struct sg_device *sdp, struct file *filp);
 static void sg_remove_sfp(struct kref *);
 static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id,
 					    bool is_tag);
+static bool sg_mrq_get_ready_srp(struct sg_fd *sfp, struct sg_request **srpp);
 static struct sg_request *sg_add_request(struct sg_comm_wr_t *cwrp,
 					 enum sg_shr_var sh_var, int dxfr_len);
 static int sg_rq_map_kern(struct sg_request *srp, struct request_queue *q,
@@ -765,6 +773,8 @@ sg_v3_submit(struct sg_fd *sfp, struct sg_io_hdr *hp, bool sync,
 	struct sg_comm_wr_t cwr;
 
 	/* now doing v3 blocking (sync) or non-blocking submission */
+	if (hp->flags & SGV4_FLAG_MULTIPLE_REQS)
+		return -ERANGE;		/* need to use v4 interface */
 	if (hp->flags & SG_FLAG_MMAP_IO) {
 		if (!list_empty(&sfp->rq_list))
 			return -EBUSY;  /* already active requests on fd */
@@ -792,6 +802,432 @@ sg_v3_submit(struct sg_fd *sfp, struct sg_io_hdr *hp, bool sync,
 	return 0;
 }
 
+static void
+sg_sgv4_out_zero(struct sg_io_v4 *h4p)
+{
+	h4p->driver_status = 0;
+	h4p->transport_status = 0;
+	h4p->device_status = 0;
+	h4p->retry_delay = 0;
+	h4p->info = 0;
+	h4p->response_len = 0;
+	h4p->duration = 0;
+	h4p->din_resid = 0;
+	h4p->dout_resid = 0;
+	h4p->generated_tag = 0;
+	h4p->spare_out = 0;
+}
+
+/*
+ * Takes a pointer to the controlling multiple request (mrq) object and a
+ * pointer to the command array. The command array (with tot_reqs elements)
+ * is written out (flushed) to user space pointer cv4p->din_xferp. The
+ * secondary error value (s_res) is placed in the array last element's
+ * spare_out field iff it was zero. Returns 0 on success.
+ */
+static int
+sg_mrq_arr_flush(struct sg_io_v4 *cv4p, struct sg_io_v4 *arr_siv4p,
+		 u32 tot_reqs, int s_res)
+{
+	u32 sz = tot_reqs * SZ_SG_IO_V4;
+	void __user *p = uptr64(cv4p->din_xferp);
+
+	if (s_res) {
+		arr_siv4p[tot_reqs - 1].spare_out = s_res;
+		cv4p->spare_out = s_res;
+	}
+	if (!p)
+		return 0;
+	if (sz > cv4p->din_xfer_len)
+		sz = cv4p->din_xfer_len;
+	if (sz > 0) {
+		if (copy_to_user(p, arr_siv4p, sz))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int
+sg_mrq_1complet(struct sg_io_v4 *cv4p, struct sg_io_v4 *arr_siv4p,
+		struct sg_fd *w_sfp, struct sg_fd *sec_sfp, int tot_reqs,
+		struct sg_request *srp)
+{
+	int s_res, indx;
+	struct sg_io_v4 *siv4p;
+
+	SG_LOG(3, w_sfp->parentdp, "%s: start\n", __func__);
+	if (!srp)
+		return -EPROTO;
+	indx = srp->s_hdr4.mrq_ind;
+	if (indx < 0 || indx >= tot_reqs)
+		return -EPROTO;
+	siv4p = arr_siv4p + indx;
+	s_res = sg_v4_receive(w_sfp, srp, NULL, siv4p);
+	if (s_res == -EFAULT)
+		return s_res;
+	siv4p->info |= SG_INFO_MRQ_FINI;
+	if (siv4p->flags & SGV4_FLAG_SIG_ON_OTHER) {
+		s_res = sg_mrq_arr_flush(cv4p, arr_siv4p, tot_reqs, s_res);
+		if (unlikely(s_res))	/* can only be -EFAULT */
+			return s_res;
+		kill_fasync(&sec_sfp->async_qp, SIGPOLL, POLL_IN);
+	}
+	return 0;
+}
+
+/*
+ * This is a fair-ish algorithm for an interruptible wait on two file
+ * descriptors. It favours the main fd over the secondary fd (sec_sfp).
+ */
+static int
+sg_mrq_complets(struct sg_io_v4 *cv4p, struct sg_io_v4 *arr_siv4p,
+		struct sg_fd *sfp, struct sg_fd *sec_sfp, int tot_reqs,
+		int mreqs, int sec_reqs)
+{
+	int res;
+	int sum_inflight = mreqs + sec_reqs;	/* may be < tot_reqs */
+	struct sg_request *srp;
+
+	SG_LOG(3, sfp->parentdp, "%s: mreqs=%d, sec_reqs=%d\n", __func__,
+	       mreqs, sec_reqs);
+	for ( ; sum_inflight > 0; --sum_inflight) {
+		srp = NULL;
+		if (mreqs > 0 && sg_mrq_get_ready_srp(sfp, &srp)) {
+			if (IS_ERR(srp)) {	/* -ENODATA: no mrqs here */
+				mreqs = 0;
+			} else {
+				--mreqs;
+				res = sg_mrq_1complet(cv4p, arr_siv4p, sfp,
+						      sec_sfp, tot_reqs, srp);
+				if (unlikely(res))
+					return res;
+			}
+		} else if (sec_reqs > 0 &&
+			   sg_mrq_get_ready_srp(sec_sfp, &srp)) {
+			if (IS_ERR(srp)) {
+				sec_reqs = 0;
+			} else {
+				--sec_reqs;
+				res = sg_mrq_1complet(cv4p, arr_siv4p, sec_sfp,
+						      sec_sfp, tot_reqs, srp);
+				if (unlikely(res))
+					return res;
+			}
+		} else if (mreqs > 0) {
+			res = wait_event_interruptible
+					(sfp->read_wait,
+					 sg_mrq_get_ready_srp(sfp, &srp));
+			if (unlikely(res))
+				return res;	/* signal --> -ERESTARTSYS */
+			if (IS_ERR(srp)) {
+				mreqs = 0;
+			} else {
+				--mreqs;
+				res = sg_mrq_1complet(cv4p, arr_siv4p, sfp,
+						      sec_sfp, tot_reqs, srp);
+				if (unlikely(res))
+					return res;
+			}
+		} else if (sec_reqs > 0) {
+			res = wait_event_interruptible
+					(sfp->read_wait,
+					 sg_mrq_get_ready_srp(sec_sfp, &srp));
+			if (unlikely(res))
+				return res;	/* signal --> -ERESTARTSYS */
+			if (IS_ERR(srp)) {
+				sec_reqs = 0;
+			} else {
+				--sec_reqs;
+				res = sg_mrq_1complet(cv4p, arr_siv4p, sec_sfp,
+						      sec_sfp, tot_reqs, srp);
+				if (unlikely(res))
+					return res;
+			}
+		} else { /* expect one of the above conditions to be true */
+			return -EPROTO;
+		}
+		if (cv4p->din_xfer_len > 0)
+			--cv4p->din_resid;
+	}
+	return 0;
+}
+
+static int
+sg_mrq_sanity(struct sg_device *sdp, struct sg_io_v4 *cv4p,
+	      struct sg_io_v4 *arr_siv4p, u8 *cdb_ap, struct sg_fd *o_sfp,
+	      u8 tot_reqs)
+{
+	bool immed = !!(cv4p->flags & SGV4_FLAG_IMMED);
+	bool have_mrq_sense = (cv4p->response && cv4p->max_response_len);
+	int k;
+	u32 cdb_alen = cv4p->request_len;
+	u32 cdb_mxlen = cdb_alen / tot_reqs;
+	u32 flags;
+	struct sg_io_v4 *siv4p;
+	__maybe_unused const char *rip = "request index";
+
+	/* Pre-check each request for anomalies */
+	for (k = 0, siv4p = arr_siv4p; k < tot_reqs; ++k, ++siv4p) {
+		flags = siv4p->flags;
+		sg_sgv4_out_zero(siv4p);
+		if (siv4p->guard != 'Q' || siv4p->protocol != 0 ||
+		    siv4p->subprotocol != 0) {
+			SG_LOG(1, sdp, "%s: req index %u: %s or protocol\n",
+			       __func__, k, "bad guard");
+			return -ERANGE;
+		}
+		if (flags & SGV4_FLAG_MULTIPLE_REQS) {
+			SG_LOG(1, sdp, "%s: %s %u: no nested multi-reqs\n",
+			       __func__, rip, k);
+			return -ERANGE;
+		}
+		if (immed) {	/* only accept async submits on current fd */
+			if (flags & SGV4_FLAG_DO_ON_OTHER) {
+				SG_LOG(1, sdp, "%s: %s %u, %s\n", __func__,
+				       rip, k, "no IMMED with ON_OTHER");
+				return -ERANGE;
+			} else if (flags & SGV4_FLAG_SHARE) {
+				SG_LOG(1, sdp, "%s: %s %u, %s\n", __func__,
+				       rip, k, "no IMMED with FLAG_SHARE");
+				return -ERANGE;
+			} else if (flags & SGV4_FLAG_COMPLETE_B4) {
+				SG_LOG(1, sdp, "%s: %s %u, %s\n", __func__,
+				       rip, k, "no IMMED with COMPLETE_B4");
+				return -ERANGE;
+			}
+		}
+		if (!o_sfp) {
+			if (flags & SGV4_FLAG_SHARE) {
+				SG_LOG(1, sdp, "%s: %s %u, no share\n",
+				       __func__, rip, k);
+				return -ERANGE;
+			} else if (flags & SGV4_FLAG_SIG_ON_OTHER) {
+				SG_LOG(1, sdp, "%s: %s %u, %s signal on\n",
+				       __func__, rip, k, "no other fd to");
+				return -ERANGE;
+			} else if (flags & SGV4_FLAG_DO_ON_OTHER) {
+				SG_LOG(1, sdp, "%s: %s %u, %s do on\n",
+				       __func__, rip, k, "no other fd to");
+				return -ERANGE;
+			}
+		}
+		if (cdb_ap) {
+			if (siv4p->request_len > cdb_mxlen) {
+				SG_LOG(1, sdp, "%s: %s %u, cdb too long\n",
+				       __func__, rip, k);
+				return -ERANGE;
+			}
+		}
+		if (have_mrq_sense && siv4p->response == 0 &&
+		    siv4p->max_response_len == 0) {
+			siv4p->response = cv4p->response;
+			siv4p->max_response_len = cv4p->max_response_len;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Implements the multiple request functionality. When blocking is true
+ * invocation was via ioctl(SG_IO), otherwise it was via ioctl(SG_IOSUBMIT).
+ * Only fully non-blocking if IMMED flag given or when ioctl(SG_IOSUBMIT)
+ * is used with O_NONBLOCK set on its file descriptor.
+ */
+static int
+sg_do_multi_req(struct sg_comm_wr_t *cwrp, bool blocking)
+{
+	bool set_this, set_other, immed, stop_if, f_non_block;
+	int res = 0;
+	int s_res = 0;	/* for partial error, some good then ... */
+	int other_fp_sent = 0;
+	int this_fp_sent = 0;
+	const int shr_complet_b4 = SGV4_FLAG_SHARE | SGV4_FLAG_COMPLETE_B4;
+	unsigned long ul_timeout;
+	struct sg_io_v4 *cv4p = cwrp->h4p;
+	u32 k, n, flags, cdb_mxlen;
+	u32 blen = cv4p->dout_xfer_len;
+	u32 cdb_alen = cv4p->request_len;
+	u32 tot_reqs = blen / SZ_SG_IO_V4;
+	struct sg_io_v4 *siv4p;
+	u8 *cdb_ap = NULL;
+	struct sg_io_v4 *arr_siv4p;
+	struct sg_fd *fp = cwrp->sfp;
+	struct sg_fd *o_sfp = fp->share_sfp;
+	struct sg_fd *rq_sfp;
+	struct sg_request *srp;
+	struct sg_device *sdp = fp->parentdp;
+
+	f_non_block = !!(fp->filp->f_flags & O_NONBLOCK);
+	immed = !!(cv4p->flags & SGV4_FLAG_IMMED);
+	stop_if = !!(cv4p->flags & SGV4_FLAG_STOP_IF);
+	if (blocking) {		/* came from ioctl(SG_IO) */
+		if (unlikely(immed)) {
+			SG_LOG(1, sdp, "%s: ioctl(SG_IO) %s contradicts\n",
+			       __func__, "with SGV4_FLAG_IMMED");
+			return -ERANGE;
+		}
+		if (unlikely(f_non_block)) {
+			SG_LOG(6, sdp, "%s: ioctl(SG_IO) %s O_NONBLOCK\n",
+			       __func__, "ignoring");
+			f_non_block = false;
+		}
+	}
+	if (!immed && f_non_block)
+		immed = true;
+	SG_LOG(3, sdp, "%s: %s, tot_reqs=%u, cdb_alen=%u\n", __func__,
+	       (immed ? "IMMED" : (blocking ?  "ordered blocking" :
+				   "variable blocking")), tot_reqs, cdb_alen);
+	sg_sgv4_out_zero(cv4p);
+
+	if (unlikely(tot_reqs > U16_MAX)) {
+		return -ERANGE;
+	} else if (unlikely(blen > SG_MAX_MULTI_REQ_SZ ||
+			    cdb_alen > SG_MAX_MULTI_REQ_SZ)) {
+		return  -E2BIG;
+	} else if (unlikely(immed && stop_if)) {
+		return -ERANGE;
+	} else if (unlikely(tot_reqs == 0)) {
+		return 0;
+	} else if (unlikely(!!cdb_alen != !!cv4p->request)) {
+		return -ERANGE;	/* both must be zero or both non-zero */
+	} else if (cdb_alen) {
+		if (unlikely(cdb_alen % tot_reqs))
+			return -ERANGE;
+		cdb_mxlen = cdb_alen / tot_reqs;
+		if (unlikely(cdb_mxlen < 6))
+			return -ERANGE;	/* too short for SCSI cdbs */
+	} else {
+		cdb_mxlen = 0;
+	}
+
+	if (unlikely(atomic_read(&sdp->detaching)))
+		return -ENODEV;
+	else if (unlikely(o_sfp && atomic_read(&o_sfp->parentdp->detaching)))
+		return -ENODEV;
+
+	arr_siv4p = kcalloc(tot_reqs, SZ_SG_IO_V4, GFP_KERNEL | __GFP_NOWARN);
+	if (!arr_siv4p)
+		return -ENOMEM;
+	n = tot_reqs * SZ_SG_IO_V4;
+	if (copy_from_user(arr_siv4p, cuptr64(cv4p->dout_xferp), n)) {
+		res = -EFAULT;
+		goto fini;
+	}
+	if (cdb_alen > 0) {
+		cdb_ap = kcalloc(tot_reqs, cdb_alen / tot_reqs,
+				 GFP_KERNEL | __GFP_NOWARN);
+		if (unlikely(!cdb_ap)) {
+			res = -ENOMEM;
+			goto fini;
+		}
+		if (copy_from_user(cdb_ap, cuptr64(cv4p->request), cdb_alen)) {
+			res = -EFAULT;
+			goto fini;
+		}
+	}
+	/* do sanity checks on all requests before starting */
+	res = sg_mrq_sanity(sdp, cv4p, arr_siv4p, cdb_ap, o_sfp, tot_reqs);
+	if (unlikely(res))
+		goto fini;
+	set_this = false;
+	set_other = false;
+	/* Dispatch requests and optionally wait for response */
+	for (k = 0, siv4p = arr_siv4p; k < tot_reqs; ++k, ++siv4p) {
+		flags = siv4p->flags;
+		if (flags & SGV4_FLAG_DO_ON_OTHER) {
+			rq_sfp = o_sfp;
+			if (!set_other) {
+				set_other = true;
+				set_bit(SG_FFD_CMD_Q, rq_sfp->ffd_bm);
+			}
+		} else {
+			rq_sfp = fp;
+			if (!set_this) {
+				set_this = true;
+				set_bit(SG_FFD_CMD_Q, rq_sfp->ffd_bm);
+			}
+		}
+		if (cdb_ap) {	/* already have array of cdbs */
+			cwrp->cmdp = cdb_ap + (k * cdb_mxlen);
+			cwrp->u_cmdp = NULL;
+		} else {	/* fetch each cdb from user space */
+			cwrp->cmdp = NULL;
+			cwrp->u_cmdp = cuptr64(siv4p->request);
+		}
+		cwrp->cmd_len = siv4p->request_len;
+		ul_timeout = msecs_to_jiffies(siv4p->timeout);
+		cwrp->frq_bm[0] = 0;
+		assign_bit(SG_FRQ_SYNC_INVOC, cwrp->frq_bm, (int)blocking);
+		set_bit(SG_FRQ_IS_V4I, cwrp->frq_bm);
+		set_bit(SG_FRQ_MULTI_REQ, cwrp->frq_bm);
+		cwrp->h4p = siv4p;
+		cwrp->timeout = min_t(unsigned long, ul_timeout, INT_MAX);
+		cwrp->sfp = rq_sfp;
+		srp = sg_common_write(cwrp);
+		if (IS_ERR(srp)) {
+			s_res = PTR_ERR(srp);
+			break;
+		}
+		srp->s_hdr4.mrq_ind = k;
+		if (immed || (!(blocking || (flags & shr_complet_b4)))) {
+			if (fp == rq_sfp)
+				++this_fp_sent;
+			else
+				++other_fp_sent;
+			continue;  /* defer completion until all submitted */
+		}
+		s_res = sg_wait_event_srp(rq_sfp, NULL, siv4p, srp);
+		if (s_res) {
+			if (s_res == -ERESTARTSYS) {
+				res = s_res;
+				goto fini;
+			}
+			break;
+		}
+		if (!srp) {
+			s_res = -EPROTO;
+			break;
+		}
+		siv4p->info |= SG_INFO_MRQ_FINI;
+		if (stop_if && (siv4p->driver_status ||
+				siv4p->transport_status ||
+				siv4p->device_status)) {
+			SG_LOG(2, sdp, "%s: %s=0x%x/0x%x/0x%x] cause exit\n",
+			       __func__, "STOP_IF and status [drv/tran/scsi",
+			       siv4p->driver_status, siv4p->transport_status,
+			       siv4p->device_status);
+			break;	/* cv4p::driver_status <-- 0 in this case */
+		}
+		if (siv4p->flags & SGV4_FLAG_SIG_ON_OTHER) {
+			res = sg_mrq_arr_flush(cv4p, arr_siv4p, tot_reqs,
+					       s_res);
+			if (unlikely(res))
+				break;
+			kill_fasync(&o_sfp->async_qp, SIGPOLL, POLL_IN);
+		}
+	}	/* end of dispatch request and optionally wait loop */
+	cv4p->dout_resid = tot_reqs - k;
+	cv4p->info = k;
+	if (cv4p->din_xfer_len > 0)
+		cv4p->din_resid = cv4p->din_xfer_len / SZ_SG_IO_V4;
+
+	if (immed)
+		goto fini;
+
+	if (res == 0 && (this_fp_sent + other_fp_sent) > 0) {
+		s_res = sg_mrq_complets(cv4p, arr_siv4p, fp, o_sfp, tot_reqs,
+					this_fp_sent, other_fp_sent);
+		if (s_res == -EFAULT || s_res == -ERESTARTSYS)
+			res = s_res;	/* this may leave orphans */
+	}
+fini:
+	if (res == 0 && !immed)
+		res = sg_mrq_arr_flush(cv4p, arr_siv4p, tot_reqs, s_res);
+	kfree(cdb_ap);
+	kfree(arr_siv4p);
+	return res;
+}
+
 static int
 sg_v4_submit(struct sg_fd *sfp, void __user *p, struct sg_io_v4 *h4p,
 	     bool sync, struct sg_request **o_srp)
@@ -804,6 +1240,24 @@ sg_v4_submit(struct sg_fd *sfp, void __user *p, struct sg_io_v4 *h4p,
 	memset(&cwr, 0, sizeof(cwr));
 	cwr.sfp = sfp;
 	cwr.h4p = h4p;
+	if (h4p->flags & SGV4_FLAG_MULTIPLE_REQS) {
+		/* want v4 async or sync with guard, din and dout and flags */
+		if (!h4p->dout_xferp || h4p->din_iovec_count ||
+		    h4p->dout_iovec_count ||
+		    (h4p->dout_xfer_len % SZ_SG_IO_V4))
+			return -ERANGE;
+		if (o_srp)
+			*o_srp = NULL;
+		res = sg_do_multi_req(&cwr, sync);
+		if (unlikely(res))
+			return res;
+		if (p) {
+			/* Write back sg_io_v4 object for error/warning info */
+			if (copy_to_user(p, h4p, SZ_SG_IO_V4))
+				return -EFAULT;
+		}
+		return 0;
+	}
 	if (h4p->flags & SG_FLAG_MMAP_IO) {
 		int len = 0;
 
@@ -1021,7 +1475,11 @@ sg_common_write(struct sg_comm_wr_t *cwrp)
 			dxfr_len = h4p->dout_xfer_len;
 			dir = SG_DXFER_TO_DEV;
 		}
-	} else {                /* sg v3 interface so hi_p valid */
+		/* Only allow SGV4_FLAG_DO_ON_OTHER on mrq */
+		if (!test_bit(SG_FRQ_MULTI_REQ, cwrp->frq_bm) &&
+		    (rq_flags & SGV4_FLAG_DO_ON_OTHER))
+			return ERR_PTR(-ERANGE);
+	} else {			/* sg v3 interface so hi_p valid */
 		h4p = NULL;
 		hi_p = cwrp->h3p;
 		dir = hi_p->dxfer_direction;
@@ -1029,6 +1487,8 @@ sg_common_write(struct sg_comm_wr_t *cwrp)
 		rq_flags = hi_p->flags;
 		pack_id = hi_p->pack_id;
 	}
+	if (rq_flags & SGV4_FLAG_MULTIPLE_REQS)
+		return ERR_PTR(-ERANGE);
 	if (fp->shr_fd == SG_SHARE_FD_UNUSED) {
 		/* no sharing established on this fd */
 		sh_var = SG_SHR_NONE;
@@ -1314,6 +1774,103 @@ sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	return err < 0 ? err : 0;
 }
 
+/*
+ * Returns negative on error including -ENODATA if there are no mrqs submitted
+ * nor waiting. Otherwise it returns the number of elements written to
+ * rsp_arr, which may be 0 if mrqs submitted but none waiting
+ */
+static int
+sg_mrq_iorec_complets(struct sg_fd *sfp, bool non_block, int max_mrqs,
+		      struct sg_io_v4 *rsp_arr)
+{
+	int k;
+	int res = 0;
+	struct sg_request *srp;
+
+	SG_LOG(3, sfp->parentdp, "%s: max_mrqs=%d\n", __func__, max_mrqs);
+	for (k = 0; k < max_mrqs; ++k) {
+		if (!sg_mrq_get_ready_srp(sfp, &srp))
+			break;
+		if (!srp)
+			return -EPROTO;
+		if (IS_ERR(srp))
+			return k ? k : PTR_ERR(srp);
+		res = sg_v4_receive(sfp, srp, NULL, rsp_arr + k);
+		if (unlikely(res))
+			return res;
+		rsp_arr[k].info |= SG_INFO_MRQ_FINI;
+	}
+	if (non_block)
+		return k;
+
+	for ( ; k < max_mrqs; ++k) {
+		res = wait_event_interruptible
+				(sfp->read_wait,
+				 sg_mrq_get_ready_srp(sfp, &srp));
+		if (unlikely(res))
+			return res;	/* signal --> -ERESTARTSYS */
+		if (unlikely(!srp))
+			return -EPROTO;
+		if (IS_ERR(srp))
+			return k ? k : PTR_ERR(srp);
+		res = sg_v4_receive(sfp, srp, NULL, rsp_arr + k);
+		if (unlikely(res))
+			return res;
+		rsp_arr[k].info |= SG_INFO_MRQ_FINI;
+	}
+	return k;
+}
+
+/*
+ * Expected race as multiple concurrent calls with the same pack_id/tag can
+ * occur. Only one should succeed per request (more may succeed but will get
+ * different requests).
+ */
+static int
+sg_mrq_ioreceive(struct sg_fd *sfp, struct sg_io_v4 *cv4p, void __user *p,
+		 bool non_block)
+{
+	int res = 0;
+	u32 len, n;
+	struct sg_io_v4 *rsp_v4_arr;
+	void __user *pp;
+
+	SG_LOG(3, sfp->parentdp, "%s: non_block=%d\n", __func__, !!non_block);
+	n = cv4p->din_xfer_len;
+	if (n > SG_MAX_MULTI_REQ_SZ)
+		return -E2BIG;
+	if (!cv4p->din_xferp || n < SZ_SG_IO_V4 || (n % SZ_SG_IO_V4))
+		return -ERANGE;
+	n /= SZ_SG_IO_V4;
+	len = n * SZ_SG_IO_V4;
+	SG_LOG(3, sfp->parentdp, "%s: %s, num_reqs=%u\n", __func__,
+	       (non_block ? "IMMED" : "blocking"), n);
+	rsp_v4_arr = kcalloc(n, SZ_SG_IO_V4, GFP_KERNEL);
+	if (!rsp_v4_arr)
+		return -ENOMEM;
+
+	sg_sgv4_out_zero(cv4p);
+	cv4p->din_resid = n;
+	res = sg_mrq_iorec_complets(sfp, non_block, n, rsp_v4_arr);
+	if (unlikely(res < 0))
+		goto fini;
+	cv4p->din_resid -= res;
+	cv4p->info = res;
+	if (copy_to_user(p, cv4p, sizeof(*cv4p)))
+		return -EFAULT;
+	res = 0;
+	pp = uptr64(cv4p->din_xferp);
+	if (pp) {
+		if (copy_to_user(pp, rsp_v4_arr, len))
+			res = -EFAULT;
+	} else {
+		pr_info("%s: cv4p->din_xferp==NULL ?_?\n", __func__);
+	}
+fini:
+	kfree(rsp_v4_arr);
+	return res;
+}
+
 /*
  * Called when ioctl(SG_IORECEIVE) received. Expects a v4 interface object.
  * Checks if O_NONBLOCK file flag given, if not checks given 'flags' field
@@ -1346,6 +1903,8 @@ sg_ctl_ioreceive(struct sg_fd *sfp, void __user *p)
 	if (h4p->flags & SGV4_FLAG_IMMED)
 		non_block = true;	/* set by either this or O_NONBLOCK */
 	SG_LOG(3, sdp, "%s: non_block(+IMMED)=%d\n", __func__, non_block);
+	if (h4p->flags & SGV4_FLAG_MULTIPLE_REQS)
+		return sg_mrq_ioreceive(sfp, h4p, p, non_block);
 	/* read in part of v3 or v4 header for pack_id or tag based find */
 	if (test_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm))
 		use_tag = test_bit(SG_FFD_PREFER_TAG, sfp->ffd_bm);
@@ -1397,6 +1956,8 @@ sg_ctl_ioreceive_v3(struct sg_fd *sfp, void __user *p)
 	if (h3p->flags & SGV4_FLAG_IMMED)
 		non_block = true;	/* set by either this or O_NONBLOCK */
 	SG_LOG(3, sdp, "%s: non_block(+IMMED)=%d\n", __func__, non_block);
+	if (h3p->flags & SGV4_FLAG_MULTIPLE_REQS)
+		return -EINVAL;
 
 	if (test_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm))
 		pack_id = h3p->pack_id;
@@ -4328,6 +4889,57 @@ sg_find_srp_by_id(struct sg_fd *sfp, int id, bool is_tag)
 	return srp;
 }
 
+/*
+ * Returns pointer to first non-sync_invoc req waiting to be read. If none
+ * found returns NULL unless there were no such reqs on active list, in which
+ * case it returns ERR_PTR(-ENODATA).
+ */
+static struct sg_request *
+sg_mrq_get_rq(struct sg_fd *sfp)
+{
+	bool any_rqs = false;
+	bool got1 = false;
+	enum sg_rq_state sr_st;
+	struct sg_request *srp;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+		if (SG_IS_SYNC_INVOC(srp))
+			continue;
+		any_rqs = true;		/* only count async reqs */
+		sr_st = atomic_read(&srp->rq_st);
+		if (sr_st == SG_RS_AWAIT_RD) {
+			if (likely(sg_rstate_chg(srp, sr_st,
+						 SG_RS_BUSY) == 0)) {
+				got1 = true;
+				break;
+			}
+		}
+	}
+	rcu_read_unlock();
+	if (got1)
+		return srp;
+	else if (any_rqs)
+		return NULL;
+	else
+		return ERR_PTR(-ENODATA);
+}
+
+/* Note, *srpp may not be a valid pointer, might be ERR_PTR(-ENODATA) */
+static bool
+sg_mrq_get_ready_srp(struct sg_fd *sfp, struct sg_request **srpp)
+{
+	struct sg_request *srp;
+
+	if (unlikely(atomic_read(&sfp->parentdp->detaching))) {
+		*srpp = NULL;
+		return true;
+	}
+	srp = sg_mrq_get_rq(sfp);
+	*srpp = srp;
+	return !!srp;
+}
+
 /*
  * Makes a new sg_request object. If 'first' is set then use GFP_KERNEL which
  * may take time but has improved chance of success, otherwise use GFP_ATOMIC.
@@ -5434,7 +6046,7 @@ sg_proc_seq_show_red_dbg(struct seq_file *s, void *v)
 	return sg_proc_seq_show_dbg(s, v, true);
 }
 
-#endif				/* CONFIG_SCSI_PROC_FS (~600 lines back) */
+#endif				/* CONFIG_SCSI_PROC_FS (~500 lines back) */
 
 module_init(init_sg);
 module_exit(exit_sg);
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 19d7321e7df6..b299e7d1b51d 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -31,7 +31,11 @@
 #include <linux/types.h>
 #include <linux/major.h>
 
-/* bsg.h contains the sg v4 user space interface structure (sg_io_v4). */
+/*
+ * bsg.h contains the sg v4 user space interface structure (sg_io_v4).
+ * That structure is also used as the controlling object when multiple
+ * requests are issued with one ioctl() call.
+ */
 #include <linux/bsg.h>
 
 /*
@@ -109,10 +113,15 @@ typedef struct sg_io_hdr {
 #define SGV4_FLAG_YIELD_TAG 0x8  /* sg_io_v4::request_tag set after SG_IOS */
 #define SGV4_FLAG_Q_AT_TAIL SG_FLAG_Q_AT_TAIL
 #define SGV4_FLAG_Q_AT_HEAD SG_FLAG_Q_AT_HEAD
+#define SGV4_FLAG_COMPLETE_B4  0x100
+#define SGV4_FLAG_SIG_ON_OTHER  0x200
 #define SGV4_FLAG_IMMED 0x400 /* for polling with SG_IOR, ignored in SG_IOS */
+#define SGV4_FLAG_STOP_IF 0x800	/* Stops sync mrq if error or warning */
 #define SGV4_FLAG_DEV_SCOPE 0x1000 /* permit SG_IOABORT to have wider scope */
 #define SGV4_FLAG_SHARE 0x2000	/* share IO buffer; needs SG_SEIM_SHARE_FD */
+#define SGV4_FLAG_DO_ON_OTHER 0x4000 /* available on either of shared pair */
 #define SGV4_FLAG_NO_DXFER SG_FLAG_NO_DXFER	/* needed for sharing */
+#define SGV4_FLAG_MULTIPLE_REQS 0x20000	/* n sg_io_v4s in data-in */
 
 /* Output (potentially OR-ed together) in v3::info or v4::info field */
 #define SG_INFO_OK_MASK 0x1
-- 
2.17.1

