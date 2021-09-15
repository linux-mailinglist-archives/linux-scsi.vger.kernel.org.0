Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3A40CF9B
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhIOWmu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Sep 2021 18:42:50 -0400
Received: from smtp.infotech.no ([82.134.31.41]:36535 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232950AbhIOWme (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Sep 2021 18:42:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id C25A4204269;
        Thu, 16 Sep 2021 00:33:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M6JNh48KebC9; Thu, 16 Sep 2021 00:33:52 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-207-107.dyn.295.ca [45.78.207.107])
        by smtp.infotech.no (Postfix) with ESMTPA id 14EED204257;
        Thu, 16 Sep 2021 00:33:46 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v20 42/46] sg: remove unit attention check for device changed
Date:   Wed, 15 Sep 2021 18:33:01 -0400
Message-Id: <20210915223305.256429-43-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915223305.256429-1-dgilbert@interlog.com>
References: <20210915223305.256429-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The SCSI mid-layer now checks for SCSI UNIT ATTENTIONs and takes
the appropriate actions. This means that the sg driver no longer
needs to do this check.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 49 ++++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index b5e73205e997..ab4662867d0f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2371,39 +2371,6 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
 
-static void
-sg_check_sense(struct sg_device *sdp, struct sg_request *srp, int sense_len)
-{
-	int driver_stat;
-	u32 rq_res = srp->rq_result;
-	struct scsi_request *scsi_rp = scsi_req(READ_ONCE(srp->rqq));
-	u8 *sbp = scsi_rp ? scsi_rp->sense : NULL;
-
-	if (!sbp)
-		return;
-	driver_stat = driver_byte(rq_res);
-	if (driver_stat & DRIVER_SENSE) {
-		struct scsi_sense_hdr ssh;
-
-		if (scsi_normalize_sense(sbp, sense_len, &ssh)) {
-			if (!scsi_sense_is_deferred(&ssh)) {
-				if (ssh.sense_key == UNIT_ATTENTION) {
-					if (sdp->device->removable)
-						sdp->device->changed = 1;
-				}
-			}
-		}
-	}
-	if (test_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm) > 0) {
-		int scsi_stat = rq_res & 0xff;
-
-		if (scsi_stat == SAM_STAT_CHECK_CONDITION ||
-		    scsi_stat == SAM_STAT_COMMAND_TERMINATED)
-			__scsi_print_sense(sdp->device, __func__, sbp,
-					   sense_len);
-	}
-}
-
 /*
  * This "bottom half" (soft interrupt) handler is called by the mid-level
  * when a request has completed or failed. This callback is registered in a
@@ -2415,6 +2382,7 @@ sg_rq_end_io(struct request *rqq, blk_status_t status)
 {
 	enum sg_rq_state rqq_state = SG_RS_AWAIT_RCV;
 	int a_resid, slen;
+	u32 rq_result;
 	unsigned long iflags;
 	struct sg_request *srp = rqq->end_io_data;
 	struct scsi_request *scsi_rp = scsi_req(rqq);
@@ -2424,7 +2392,8 @@ sg_rq_end_io(struct request *rqq, blk_status_t status)
 	sfp = srp->parentfp;
 	sdp = sfp->parentdp;
 
-	srp->rq_result = scsi_rp->result;
+	rq_result = scsi_rp->result;
+	srp->rq_result = rq_result;
 	slen = min_t(int, scsi_rp->sense_len, SCSI_SENSE_BUFFERSIZE);
 	a_resid = scsi_rp->resid_len;
 
@@ -2440,10 +2409,16 @@ sg_rq_end_io(struct request *rqq, blk_status_t status)
 	}
 
 	SG_LOG(6, sfp, "%s: pack_id=%d, res=0x%x\n", __func__, srp->pack_id,
-	       srp->rq_result);
+	       rq_result);
 	srp->duration = sg_calc_rq_dur(srp);
-	if (unlikely((srp->rq_result & SG_ML_RESULT_MSK) && slen > 0))
-		sg_check_sense(sdp, srp, slen);
+	if (unlikely((rq_result & SG_ML_RESULT_MSK) && slen > 0 &&
+		     test_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm))) {
+		u32 scsi_stat = rq_result & 0xff;
+
+		if (scsi_stat == SAM_STAT_CHECK_CONDITION ||
+		    scsi_stat == SAM_STAT_COMMAND_TERMINATED)
+			__scsi_print_sense(sdp->device, __func__, scsi_rp->sense, slen);
+	}
 	if (slen > 0) {
 		if (scsi_rp->sense && !srp->sense_bp) {
 			srp->sense_bp = mempool_alloc(sg_sense_pool,
-- 
2.25.1

