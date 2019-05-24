Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957EE29E58
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbfEXSs1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:27 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56354 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391503AbfEXSs1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 40B85204199;
        Fri, 24 May 2019 20:48:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EshWVel4bZfI; Fri, 24 May 2019 20:48:25 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 8B1DF204165;
        Fri, 24 May 2019 20:48:18 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 06/19] sg: sense buffer cleanup
Date:   Fri, 24 May 2019 14:47:56 -0400
Message-Id: <20190524184809.25121-7-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Only a smaller percentage of SCSI commands should require a sense
buffer. Allocate as needed and delete as soon as possible.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 72ce51b3198c..a58875198c16 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -852,20 +852,21 @@ sg_copy_sense(struct sg_request *srp)
 	    (driver_byte(srp->rq_result) & DRIVER_SENSE)) {
 		int sb_len = min_t(int, SCSI_SENSE_BUFFERSIZE, srp->sense_len);
 		int mx_sb_len;
+		u8 *sbp = srp->sense_bp;
 		void __user *up;
 
+		srp->sense_bp = NULL;
 		up = (void __user *)srp->s_hdr3.sbp;
 		mx_sb_len = srp->s_hdr3.mx_sb_len;
-		if (up && mx_sb_len > 0 && srp->sense_bp) {
+		if (up && mx_sb_len > 0 && sbp) {
 			sb_len = min_t(int, sb_len, mx_sb_len);
 			/* Additional sense length field */
-			sb_len_wr = 8 + (int)srp->sense_bp[7];
+			sb_len_wr = 8 + (int)sbp[7];
 			sb_len_wr = min_t(int, sb_len, sb_len_wr);
-			if (copy_to_user(up, srp->sense_bp, sb_len_wr))
+			if (copy_to_user(up, sbp, sb_len_wr))
 				sb_len_wr = -EFAULT;
 		}
-		kfree(srp->sense_bp);
-		srp->sense_bp = NULL;
+		kfree(sbp);
 	}
 	return sb_len_wr;
 }
@@ -972,12 +973,9 @@ sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	h2p->driver_status = driver_byte(rq_result);
 	if ((CHECK_CONDITION & status_byte(rq_result)) ||
 	    (DRIVER_SENSE & driver_byte(rq_result))) {
-		if (srp->sense_bp) {
+		if (srp->sense_bp)
 			memcpy(h2p->sense_buffer, srp->sense_bp,
 			       sizeof(h2p->sense_buffer));
-			kfree(srp->sense_bp);
-			srp->sense_bp = NULL;
-		}
 	}
 	switch (host_byte(rq_result)) {
 	/*
@@ -1013,17 +1011,22 @@ sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 
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
+			if (sg_rd_append(srp, buf, count - SZ_SG_HEADER)) {
+				res = -EFAULT;
+				goto fini;
+			}
 		}
 	} else
 		res = (h2p->result == 0) ? 0 : -EIO;
+fini:
 	atomic_set(&srp->rq_st, SG_RS_DONE_RD);
 	sg_finish_scsi_blk_rq(srp);
 	sg_deact_request(sfp, srp);
@@ -2991,6 +2994,7 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 	bool on_fl = false;
 	int dlen, buflen;
 	unsigned long iflags;
+	u8 *sbp;
 	struct sg_request *t_srp;
 	struct sg_scatter_hold *schp;
 	const char *cp = "head";
@@ -2999,8 +3003,11 @@ sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
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
@@ -3145,6 +3152,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		list_del(&srp->rq_entry);
 		if (srp->sgat_h.buflen > 0)
 			sg_remove_sgat(srp);
+		kfree(srp->sense_bp);   /* abnormal close: device detached */
 		SG_LOG(6, sdp, "%s:%s%p --\n", __func__, cp, srp);
 		kfree(srp);
 	}
@@ -3156,6 +3164,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 		list_del(&srp->fl_entry);
 		if (srp->sgat_h.buflen > 0)
 			sg_remove_sgat(srp);
+		kfree(srp->sense_bp);
 		SG_LOG(6, sdp, "%s: fl%s%p --\n", __func__, cp, srp);
 		kfree(srp);
 	}
-- 
2.17.1

