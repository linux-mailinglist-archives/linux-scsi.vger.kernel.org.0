Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226137764F
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jul 2019 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfG0DiA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 23:38:00 -0400
Received: from smtp.infotech.no ([82.134.31.41]:54612 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfG0DiA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 23:38:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B833520419A;
        Sat, 27 Jul 2019 05:37:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3MUEUamq+6e6; Sat, 27 Jul 2019 05:37:57 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id A71EB2041AF;
        Sat, 27 Jul 2019 05:37:55 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH v2 12/18] sg: sense buffer rework
Date:   Fri, 26 Jul 2019 23:37:22 -0400
Message-Id: <20190727033728.21134-13-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190727033728.21134-1-dgilbert@interlog.com>
References: <20190727033728.21134-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The biggest single item in the sg_request object is the sense
buffer array which is SCSI_SENSE_BUFFERSIZE bytes long. That
constant started out at 18 bytes 20 years ago and is 96 bytes
now and might grow in the future. On the other hand the sense
buffer is only used by a small number of SCSI commands: those
that fail and those that want to return more information
other than a SCSI status of GOOD.

Allocate sense buffer as needed on the heap and delete as soon as
possible.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 00b8553e0038..4d6635af7da7 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -176,7 +176,6 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 	spinlock_t req_lck;
 	struct sg_scatter_hold sgat_h;	/* hold buffer, perhaps scatter list */
 	struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
-	u8 sense_b[SCSI_SENSE_BUFFERSIZE];
 	u32 duration;		/* cmd duration in milliseconds */
 	u32 rq_flags;		/* hold user supplied flags */
 	u32 rq_info;		/* info supplied by v3 and v4 interfaces */
@@ -188,6 +187,7 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
 	u8 cmd_opcode;		/* first byte of SCSI cdb */
 	u64 start_ns;		/* starting point of command duration calc */
 	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
+	u8 *sense_bp;		/* alloc-ed sense buffer, as needed */
 	struct sg_fd *parentfp;	/* pointer to owning fd, even when on fl */
 	struct request *rq;	/* released in sg_rq_end_io(), bio kept */
 	struct bio *bio;	/* kept until this req -->SG_RS_INACTIVE */
@@ -845,18 +845,21 @@ sg_copy_sense(struct sg_request *srp)
 	    (driver_byte(srp->rq_result) & DRIVER_SENSE)) {
 		int sb_len = min_t(int, SCSI_SENSE_BUFFERSIZE, srp->sense_len);
 		int mx_sb_len;
+		u8 *sbp = srp->sense_bp;
 		void __user *up;
 
+		srp->sense_bp = NULL;
 		up = (void __user *)srp->s_hdr3.sbp;
 		mx_sb_len = srp->s_hdr3.mx_sb_len;
-		if (up && mx_sb_len > 0) {
+		if (up && mx_sb_len > 0 && sbp) {
 			sb_len = min_t(int, sb_len, mx_sb_len);
 			/* Additional sense length field */
-			sb_len_wr = 8 + (int)srp->sense_b[7];
+			sb_len_wr = 8 + (int)sbp[7];
 			sb_len_wr = min_t(int, sb_len, sb_len_wr);
-			if (copy_to_user(up, srp->sense_b, sb_len_wr))
+			if (copy_to_user(up, sbp, sb_len_wr))
 				sb_len_wr = -EFAULT;
 		}
+		kfree(sbp);
 	}
 	return sb_len_wr;
 }
@@ -963,8 +966,9 @@ sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	h2p->driver_status = driver_byte(rq_result);
 	if ((CHECK_CONDITION & status_byte(rq_result)) ||
 	    (DRIVER_SENSE & driver_byte(rq_result))) {
-		memcpy(h2p->sense_buffer, srp->sense_b,
-		       sizeof(h2p->sense_buffer));
+		if (srp->sense_bp)
+			memcpy(h2p->sense_buffer, srp->sense_bp,
+			       sizeof(h2p->sense_buffer));
 	}
 	switch (host_byte(rq_result)) {
 	/*
@@ -999,17 +1003,21 @@ sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 
 	/* Now copy the result back to the user buffer.  */
 	if (count >= SZ_SG_HEADER) {
-		if (copy_to_user(buf, h2p, SZ_SG_HEADER))
-			return -EFAULT;
+		if (copy_to_user(buf, h2p, SZ_SG_HEADER)) {
+			res = -EFAULT;
+			goto fini;
+		}
 		buf += SZ_SG_HEADER;
 		if (count > h2p->reply_len)
 			count = h2p->reply_len;
 		if (count > SZ_SG_HEADER) {
-			if (sg_rd_append(srp, buf, count - SZ_SG_HEADER))
-				return -EFAULT;
+			res = sg_rd_append(srp, buf, count - SZ_SG_HEADER);
+			if (res)
+				goto fini;
 		}
 	} else
 		res = (h2p->result == 0) ? 0 : -EIO;
+fini:
 	atomic_set(&srp->rq_st, SG_RS_DONE_RD);
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
@@ -1977,8 +1985,17 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	srp->duration = sg_calc_rq_dur(srp);
 	if (unlikely((srp->rq_result & SG_ML_RESULT_MSK) && slen > 0))
 		sg_check_sense(sdp, srp, slen);
-	if (slen > 0)
-		memcpy(srp->sense_b, scsi_rp->sense, slen);
+	if (slen > 0) {
+		if (scsi_rp->sense) {
+			srp->sense_bp = kzalloc(SCSI_SENSE_BUFFERSIZE,
+						GFP_ATOMIC);
+			if (srp->sense_bp)
+				memcpy(srp->sense_bp, scsi_rp->sense, slen);
+		} else {
+			pr_warn("%s: scsi_request::sense==NULL\n", __func__);
+			slen = 0;
+		}
+	}
 	srp->sense_len = slen;
 	if (unlikely(test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm))) {
 		spin_lock(&srp->req_lck);
@@ -2940,6 +2957,7 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	bool on_fl = false;
 	int dlen, buflen;
 	unsigned long iflags;
+	u8 *sbp;
 	struct sg_request *t_srp;
 	struct sg_scatter_hold *schp;
 	const char *cp = "head";
@@ -2948,8 +2966,11 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 		return;
 	schp = &srp->sgat_h;	/* make sure it is own data buffer */
 	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	sbp = srp->sense_bp;
+	srp->sense_bp = NULL;
 	atomic_set(&srp->rq_st, SG_RS_BUSY);
 	list_del_rcu(&srp->rq_entry);
+	kfree(sbp);     /* maybe orphaned req, thus never read */
 	/*
 	 * N.B. sg_request object is not de-allocated (freed). The contents
 	 * of the rq_list and rq_fl lists are de-allocated (freed) when
@@ -3092,6 +3113,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		list_del(&srp->rq_entry);
 		if (srp->sgat_h.buflen > 0)
 			sg_remove_sgat(srp);
+		kfree(srp->sense_bp);	/* abnormal close: device detached */
 		SG_LOG(6, sfp, "%s:%s%p --\n", __func__, cp, srp);
 		kfree(srp);
 	}
@@ -3103,6 +3125,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		list_del(&srp->fl_entry);
 		if (srp->sgat_h.buflen > 0)
 			sg_remove_sgat(srp);
+		kfree(srp->sense_bp);
 		SG_LOG(6, sfp, "%s: fl%s%p --\n", __func__, cp, srp);
 		kfree(srp);
 	}
-- 
2.17.1

