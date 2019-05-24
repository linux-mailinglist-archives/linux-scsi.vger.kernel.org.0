Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621E829E61
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbfEXSsi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:38 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56406 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391503AbfEXSsh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 69CEC204199;
        Fri, 24 May 2019 20:48:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MHdKQfX1G0HB; Fri, 24 May 2019 20:48:33 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id CFBBD204165;
        Fri, 24 May 2019 20:48:26 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 13/19] sg: sgat_elem_sz and sum_fd_dlens
Date:   Fri, 24 May 2019 14:48:03 -0400
Message-Id: <20190524184809.25121-14-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Wire up some more capabilities of ioctl(SG_SET_GET_EXTENDED). One
is the size of each internal scatter gather list element. This
defaults to 2^15 and was fixed in previous versions of this
driver. If the user provides a value, it must be a power of
2 (bytes) and no less than PAGE_SIZE.

sum_fd_dlens provides user control over a mechanism designed to
stop the starvation of the host machine's memory. Since requests
per file descriptor are no longer limited to 16, thousands could
be queued up by a badly designed program. If each one requests
a large buffer (say 128 KB each for READs) then without this
mechanism, the OOM killer may be called on to save the machine.
The driver counts the cumulative size of data buffers
outstanding held by each file descriptor. Once that figure
exceeds a default size of 16 MB, further submissions on that
file descriptor are failed with E2BIG.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 64 +++++++++++++++++++++++++++++++++++++++---
 include/uapi/scsi/sg.h |  1 +
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c014fb24eca1..64e9de67ccd4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -88,7 +88,11 @@ enum sg_rq_state {
 	SG_RS_BUSY,		/* temporary state should rarely be seen */
 };
 
+/* If sum_of(dlen) of a fd exceeds this, write() will yield E2BIG */
+#define SG_TOT_FD_THRESHOLD (32 * 1024 * 1024)
+
 #define SG_TIME_UNIT_MS 0	/* milliseconds */
+/* #define SG_TIME_UNIT_NS 1	   nanoseconds */
 #define SG_DEF_TIME_UNIT SG_TIME_UNIT_MS
 #define SG_DEFAULT_TIMEOUT mult_frac(SG_DEFAULT_TIMEOUT_USER, HZ, USER_HZ)
 #define SG_FD_Q_AT_HEAD 0
@@ -223,7 +227,9 @@ struct sg_fd {		/* holds the state of a file descriptor */
 	struct list_head rq_fl; /* head of sg_request free list */
 	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
+	int tot_fd_thresh;      /* E2BIG if sum_of(dlen) > this, 0: ignore */
 	int sgat_elem_sz;	/* initialized to scatter_elem_sz */
+	atomic_t sum_fd_dlens;	/* when tot_fd_thresh>0 this is sum_of(dlen) */
 	atomic_t submitted;	/* number inflight or awaiting read */
 	atomic_t waiting;	/* number of requests awaiting read */
 	unsigned long ffd_bm[1];	/* see SG_FFD_* defines above */
@@ -1939,8 +1945,8 @@ sg_ctl_extended(struct sg_fd *sfp, void __user *p)
 {
 	int result = 0;
 	int ret = 0;
-	int s_wr_mask, s_rd_mask;
-	u32 or_masks;
+	int n, j, s_wr_mask, s_rd_mask;
+	u32 uv, or_masks;
 	struct sg_device *sdp = sfp->parentdp;
 	struct sg_extended_info *seip;
 	struct sg_extended_info sei;
@@ -1957,6 +1963,17 @@ sg_ctl_extended(struct sg_fd *sfp, void __user *p)
 	}
 	SG_LOG(3, sdp, "%s: wr_mask=0x%x rd_mask=0x%x\n", __func__, s_wr_mask,
 	       s_rd_mask);
+	/* tot_fd_thresh (u32), [raw] [sum of active cmd dlen_s] */
+	if (or_masks & SG_SEIM_TOT_FD_THRESH) {
+		if (s_wr_mask & SG_SEIM_TOT_FD_THRESH) {
+			uv = seip->tot_fd_thresh;
+			if (uv > 0 && uv < PAGE_SIZE)
+				uv = PAGE_SIZE;
+			sfp->tot_fd_thresh = uv;
+		}
+		if (s_rd_mask & SG_SEIM_TOT_FD_THRESH)
+			seip->tot_fd_thresh = sfp->tot_fd_thresh;
+	}
 	/* check all boolean flags for either wr or rd mask set in or_mask */
 	if (or_masks & SG_SEIM_CTL_FLAGS)
 		sg_extended_bool_flags(sfp, seip);
@@ -1971,6 +1988,23 @@ sg_ctl_extended(struct sg_fd *sfp, void __user *p)
 	}
 	if ((s_rd_mask & SG_SEIM_READ_VAL) && (s_wr_mask & SG_SEIM_READ_VAL))
 		sg_extended_read_value(sfp, seip);
+	/* override scatter gather element size [rbw] (def: SG_SCATTER_SZ) */
+	if (or_masks & SG_SEIM_SGAT_ELEM_SZ) {
+		n = sfp->sgat_elem_sz;
+		if (s_wr_mask & SG_SEIM_SGAT_ELEM_SZ) {
+			j = (int)seip->sgat_elem_sz;
+			if (j != (1 << ilog2(j)) || j < (int)PAGE_SIZE) {
+				SG_LOG(1, sdp, "%s: %s not power of 2, %s\n",
+				       __func__, "sgat element size",
+				       "or less than PAGE_SIZE");
+				ret = -EINVAL;
+			} else {
+				sfp->sgat_elem_sz = j;
+			}
+		}
+		if (s_rd_mask & SG_SEIM_SGAT_ELEM_SZ)
+			seip->sgat_elem_sz = n; /* prior value if rw */
+	}
 	/* reserved_sz [raw], since may be reduced by other limits */
 	if (s_wr_mask & SG_SEIM_RESERVED_SIZE) {
 		mutex_lock(&sfp->f_mutex);
@@ -3289,6 +3323,8 @@ sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen)
 	if (unlikely(rem_sz > 0))       /* must have failed */
 		return -ENOMEM;
 	schp->buflen = align_sz;
+	if (sfp->tot_fd_thresh > 0)
+		atomic_add(align_sz, &sfp->sum_fd_dlens);
 	return 0;
 err_out:
 	for (j = 0; j < k; ++j)
@@ -3335,6 +3371,15 @@ sg_remove_sgat(struct sg_request *srp)
 	if (!test_bit(SG_FRQ_DIO_IN_USE, srp->frq_bm))
 		sg_remove_sgat_helper(sdp, schp);
 
+	if (sfp->tot_fd_thresh > 0) {
+		/* this is a subtraction, error if it goes negative */
+		if (atomic_add_negative(-schp->buflen, &sfp->sum_fd_dlens)) {
+			SG_LOG(2, sfp->parentdp,
+			       "%s: logic error: this dlen > %s\n",
+			       __func__, "sum_fd_dlens");
+			atomic_set(&sfp->sum_fd_dlens, 0);
+		}
+	}
 	memset(schp, 0, sizeof(*schp));         /* zeros buflen and dlen */
 }
 
@@ -3560,6 +3605,7 @@ sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
 {
 	bool act_empty = false;
 	bool mk_new_srp = true;
+	u32 sum_dlen;
 	unsigned long iflags;
 	enum sg_rq_state sr_st;
 	struct sg_fd *fp = cwrp->sfp;
@@ -3613,6 +3659,13 @@ sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
 			r_srp = ERR_PTR(-EDOM);
 			SG_LOG(6, sdp, "%s: trying 2nd req but cmd_q=false\n",
 			       __func__);
+		} else if (fp->tot_fd_thresh > 0) {
+			sum_dlen = atomic_read(&fp->sum_fd_dlens) + dxfr_len;
+			if (sum_dlen > (u32)fp->tot_fd_thresh) {
+				r_srp = ERR_PTR(-E2BIG);
+				SG_LOG(2, sdp, "%s: sum_of_dlen(%u) > %s\n",
+				       __func__, sum_dlen, "tot_fd_thresh");
+			}
 		}
 		spin_unlock_irqrestore(&fp->rq_list_lock, iflags);
 		if (IS_ERR(r_srp))        /* NULL is not an ERR here */
@@ -3742,6 +3795,8 @@ sg_add_sfp(struct sg_device *sdp)
 	assign_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm, SG_DEF_KEEP_ORPHAN);
 	assign_bit(SG_FFD_TIME_IN_NS, sfp->ffd_bm, SG_DEF_TIME_UNIT);
 	assign_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm, SG_DEFAULT_Q_AT);
+	sfp->tot_fd_thresh = SG_TOT_FD_THRESHOLD;
+	atomic_set(&sfp->sum_fd_dlens, 0);
 	atomic_set(&sfp->submitted, 0);
 	atomic_set(&sfp->waiting, 0);
 	/*
@@ -4237,8 +4292,9 @@ sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len)
 		       (int)test_bit(SG_FFD_FORCE_PACKID, fp->ffd_bm),
 		       (int)test_bit(SG_FFD_KEEP_ORPHAN, fp->ffd_bm),
 		       fp->ffd_bm[0]);
-	n += scnprintf(obp + n, len - n, "   mmap_called=%d\n",
-		       test_bit(SG_FFD_MMAP_CALLED, fp->ffd_bm));
+	n += scnprintf(obp + n, len - n, "   mmap_called=%d sum_fd_dlens=%u\n",
+		       test_bit(SG_FFD_MMAP_CALLED, fp->ffd_bm),
+		       atomic_read(&fp->sum_fd_dlens));
 	n += scnprintf(obp + n, len - n,
 		       "   submitted=%d waiting=%d   open thr_id=%d\n",
 		       atomic_read(&fp->submitted),
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index ca2b4819ddcd..378cf0532756 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -167,6 +167,7 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 #define SG_SEIM_CTL_FLAGS	0x1	/* ctl_flags_mask bits in ctl_flags */
 #define SG_SEIM_READ_VAL	0x2	/* write SG_SEIRV_*, read back value */
 #define SG_SEIM_RESERVED_SIZE	0x4	/* reserved_sz of reserve request */
+#define SG_SEIM_TOT_FD_THRESH	0x8	/* tot_fd_thresh of data buffers */
 #define SG_SEIM_MINOR_INDEX	0x10	/* sg device minor index number */
 #define SG_SEIM_SGAT_ELEM_SZ	0x80	/* sgat element size (>= PAGE_SIZE) */
 #define SG_SEIM_ALL_BITS	0xff	/* should be OR of previous items */
-- 
2.17.1

