Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A44BC09B
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Feb 2022 20:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiBRTwo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Feb 2022 14:52:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiBRTwe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Feb 2022 14:52:34 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68288237FC
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:52:16 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id i10so7987979plr.2
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NeNAG1Ei27GsQ9hxdSmu4jwEVUfh7t45yBwVciL8Ws=;
        b=ZzsFxpgqH+KOSkDAv+4VeGX+A1cqQl7S0h8F3UI/daXIczHQFXo/BAMKUg3Hc9BBYU
         T9I3uNy8QWjJZbK4xjd5BtQO/ROQxqNbEIFUI0EJY6I+M9M22wxK0oD/635LWSaExhKw
         wd5JveIQb5fYcqlNId1vaYEXMTWIwwuFdcbm3EGl5NmQx8vTrPQSwpMWxv2Tl1170cPG
         BRxJzSAiT3UW8GwG3oNoIilPKQN6XbAmoRxdO0w/Xuh4mRWcubaCyVhGk6ve7apU602E
         kCVlO9bFP021fgMYpwW+08BVojdVx2CCOcNBdOdixaef4mOEZB+vywY9kTdX+H+YHYIZ
         cEcA==
X-Gm-Message-State: AOAM532bU55tK+12K/LddohFOnq5dz9DVoxa4RYQhvOZ+/Es/6Wb23Rh
        5L1PIAW3Om7dbzPJJ66Xzq0=
X-Google-Smtp-Source: ABdhPJytd/RQavtfpHbvetTeu0uoSs2TLKTZnPIGrhyhihtYHWJW5dMv4VlL3kL+/Y1pQ2iQNSY0Rw==
X-Received: by 2002:a17:902:9a41:b0:149:a13f:af62 with SMTP id x1-20020a1709029a4100b00149a13faf62mr8813854plv.147.1645213935541;
        Fri, 18 Feb 2022 11:52:15 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id e15sm3930523pfv.104.2022.02.18.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:52:14 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 22/49] scsi: fnic: Stop using the SCSI pointer
Date:   Fri, 18 Feb 2022 11:50:50 -0800
Message-Id: <20220218195117.25689-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218195117.25689-1-bvanassche@acm.org>
References: <20220218195117.25689-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set .cmd_size in the SCSI host template instead of using the SCSI pointer
from struct scsi_cmnd. This patch prepares for removal of the SCSI pointer
from struct scsi_cmnd.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/fnic/fnic.h      |  27 +++-
 drivers/scsi/fnic/fnic_main.c |   1 +
 drivers/scsi/fnic/fnic_scsi.c | 289 +++++++++++++++++-----------------
 3 files changed, 163 insertions(+), 154 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index b95d0063dedb..aa07189fb5fb 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -89,15 +89,28 @@
 #define FNIC_DEV_RST_ABTS_PENDING       BIT(21)
 
 /*
- * Usage of the scsi_cmnd scratchpad.
+ * fnic private data per SCSI command.
  * These fields are locked by the hashed io_req_lock.
  */
-#define CMD_SP(Cmnd)		((Cmnd)->SCp.ptr)
-#define CMD_STATE(Cmnd)		((Cmnd)->SCp.phase)
-#define CMD_ABTS_STATUS(Cmnd)	((Cmnd)->SCp.Message)
-#define CMD_LR_STATUS(Cmnd)	((Cmnd)->SCp.have_data_in)
-#define CMD_TAG(Cmnd)           ((Cmnd)->SCp.sent_command)
-#define CMD_FLAGS(Cmnd)         ((Cmnd)->SCp.Status)
+struct fnic_cmd_priv {
+	struct fnic_io_req *io_req;
+	enum fnic_ioreq_state state;
+	u32 flags;
+	u16 abts_status;
+	u16 lr_status;
+};
+
+static inline struct fnic_cmd_priv *fnic_priv(struct scsi_cmnd *cmd)
+{
+	return scsi_cmd_priv(cmd);
+}
+
+static inline u64 fnic_flags_and_state(struct scsi_cmnd *cmd)
+{
+	struct fnic_cmd_priv *fcmd = fnic_priv(cmd);
+
+	return ((u64)fcmd->flags << 32) | fcmd->state;
+}
 
 #define FCPIO_INVALID_CODE 0x100 /* hdr_status value unused by firmware */
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 44dbaa662d94..9161bd2fd421 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -124,6 +124,7 @@ static struct scsi_host_template fnic_host_template = {
 	.max_sectors = 0xffff,
 	.shost_groups = fnic_host_groups,
 	.track_queue_depth = 1,
+	.cmd_size = sizeof(struct fnic_cmd_priv),
 };
 
 static void
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 549754245f7a..3c00e5b88350 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -497,8 +497,8 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	 * caller disabling them.
 	 */
 	spin_unlock(lp->host->host_lock);
-	CMD_STATE(sc) = FNIC_IOREQ_NOT_INITED;
-	CMD_FLAGS(sc) = FNIC_NO_FLAGS;
+	fnic_priv(sc)->state = FNIC_IOREQ_NOT_INITED;
+	fnic_priv(sc)->flags = FNIC_NO_FLAGS;
 
 	/* Get a new io_req for this SCSI IO */
 	io_req = mempool_alloc(fnic->io_req_pool, GFP_ATOMIC);
@@ -513,7 +513,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	sg_count = scsi_dma_map(sc);
 	if (sg_count < 0) {
 		FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
-			  tag, sc, 0, sc->cmnd[0], sg_count, CMD_STATE(sc));
+			  tag, sc, 0, sc->cmnd[0], sg_count, fnic_priv(sc)->state);
 		mempool_free(io_req, fnic->io_req_pool);
 		goto out;
 	}
@@ -558,9 +558,9 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	io_lock_acquired = 1;
 	io_req->port_id = rport->port_id;
 	io_req->start_time = jiffies;
-	CMD_STATE(sc) = FNIC_IOREQ_CMD_PENDING;
-	CMD_SP(sc) = (char *)io_req;
-	CMD_FLAGS(sc) |= FNIC_IO_INITIALIZED;
+	fnic_priv(sc)->state = FNIC_IOREQ_CMD_PENDING;
+	fnic_priv(sc)->io_req = io_req;
+	fnic_priv(sc)->flags |= FNIC_IO_INITIALIZED;
 
 	/* create copy wq desc and enqueue it */
 	wq = &fnic->wq_copy[0];
@@ -571,11 +571,10 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 		 * refetch the pointer under the lock.
 		 */
 		FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
-			  tag, sc, 0, 0, 0,
-			  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
-		CMD_SP(sc) = NULL;
-		CMD_STATE(sc) = FNIC_IOREQ_CMD_COMPLETE;
+			  tag, sc, 0, 0, 0, fnic_flags_and_state(sc));
+		io_req = fnic_priv(sc)->io_req;
+		fnic_priv(sc)->io_req = NULL;
+		fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
 		spin_unlock_irqrestore(io_lock, flags);
 		if (io_req) {
 			fnic_release_ioreq_buf(fnic, io_req, sc);
@@ -594,7 +593,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 			     atomic64_read(&fnic_stats->io_stats.active_ios));
 
 		/* REVISIT: Use per IO lock in the final code */
-		CMD_FLAGS(sc) |= FNIC_IO_ISSUED;
+		fnic_priv(sc)->flags |= FNIC_IO_ISSUED;
 	}
 out:
 	cmd_trace = ((u64)sc->cmnd[0] << 56 | (u64)sc->cmnd[7] << 40 |
@@ -603,8 +602,8 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 			sc->cmnd[5]);
 
 	FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
-		  tag, sc, io_req, sg_count, cmd_trace,
-		  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+		   tag, sc, io_req, sg_count, cmd_trace,
+		   fnic_flags_and_state(sc));
 
 	/* if only we issued IO, will we have the io lock */
 	if (io_lock_acquired)
@@ -867,11 +866,11 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 
 	io_lock = fnic_io_lock_hash(fnic, sc);
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	WARN_ON_ONCE(!io_req);
 	if (!io_req) {
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
-		CMD_FLAGS(sc) |= FNIC_IO_REQ_NULL;
+		fnic_priv(sc)->flags |= FNIC_IO_REQ_NULL;
 		spin_unlock_irqrestore(io_lock, flags);
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "icmnd_cmpl io_req is null - "
@@ -888,17 +887,17 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 	 *  if SCSI-ML has already issued abort on this command,
 	 *  set completion of the IO. The abts path will clean it up
 	 */
-	if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
+	if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
 
 		/*
 		 * set the FNIC_IO_DONE so that this doesn't get
 		 * flagged as 'out of order' if it was not aborted
 		 */
-		CMD_FLAGS(sc) |= FNIC_IO_DONE;
-		CMD_FLAGS(sc) |= FNIC_IO_ABTS_PENDING;
+		fnic_priv(sc)->flags |= FNIC_IO_DONE;
+		fnic_priv(sc)->flags |= FNIC_IO_ABTS_PENDING;
 		spin_unlock_irqrestore(io_lock, flags);
 		if(FCPIO_ABORTED == hdr_status)
-			CMD_FLAGS(sc) |= FNIC_IO_ABORTED;
+			fnic_priv(sc)->flags |= FNIC_IO_ABORTED;
 
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
 			"icmnd_cmpl abts pending "
@@ -912,7 +911,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 	}
 
 	/* Mark the IO as complete */
-	CMD_STATE(sc) = FNIC_IOREQ_CMD_COMPLETE;
+	fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
 
 	icmnd_cmpl = &desc->u.icmnd_cmpl;
 
@@ -983,8 +982,8 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 	}
 
 	/* Break link with the SCSI command */
-	CMD_SP(sc) = NULL;
-	CMD_FLAGS(sc) |= FNIC_IO_DONE;
+	fnic_priv(sc)->io_req = NULL;
+	fnic_priv(sc)->flags |= FNIC_IO_DONE;
 
 	spin_unlock_irqrestore(io_lock, flags);
 
@@ -1009,8 +1008,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 		  ((u64)icmnd_cmpl->_resvd0[1] << 56 |
 		  (u64)icmnd_cmpl->_resvd0[0] << 48 |
 		  jiffies_to_msecs(jiffies - start_time)),
-		  desc, cmd_trace,
-		  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+		  desc, cmd_trace, fnic_flags_and_state(sc));
 
 	if (sc->sc_data_direction == DMA_FROM_DEVICE) {
 		fnic->lport->host_stats.fcp_input_requests++;
@@ -1095,12 +1093,12 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 	}
 	io_lock = fnic_io_lock_hash(fnic, sc);
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	WARN_ON_ONCE(!io_req);
 	if (!io_req) {
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
 		spin_unlock_irqrestore(io_lock, flags);
-		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_REQ_NULL;
+		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_REQ_NULL;
 		shost_printk(KERN_ERR, fnic->lport->host,
 			  "itmf_cmpl io_req is null - "
 			  "hdr status = %s tag = 0x%x sc 0x%p\n",
@@ -1115,9 +1113,9 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			      "dev reset abts cmpl recd. id %x status %s\n",
 			      id, fnic_fcpio_status_to_str(hdr_status));
-		CMD_STATE(sc) = FNIC_IOREQ_ABTS_COMPLETE;
-		CMD_ABTS_STATUS(sc) = hdr_status;
-		CMD_FLAGS(sc) |= FNIC_DEV_RST_DONE;
+		fnic_priv(sc)->state = FNIC_IOREQ_ABTS_COMPLETE;
+		fnic_priv(sc)->abts_status = hdr_status;
+		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
 		if (io_req->abts_done)
 			complete(io_req->abts_done);
 		spin_unlock_irqrestore(io_lock, flags);
@@ -1127,7 +1125,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		case FCPIO_SUCCESS:
 			break;
 		case FCPIO_TIMEOUT:
-			if (CMD_FLAGS(sc) & FNIC_IO_ABTS_ISSUED)
+			if (fnic_priv(sc)->flags & FNIC_IO_ABTS_ISSUED)
 				atomic64_inc(&abts_stats->abort_fw_timeouts);
 			else
 				atomic64_inc(
@@ -1139,34 +1137,34 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 				(int)(id & FNIC_TAG_MASK));
 			break;
 		case FCPIO_IO_NOT_FOUND:
-			if (CMD_FLAGS(sc) & FNIC_IO_ABTS_ISSUED)
+			if (fnic_priv(sc)->flags & FNIC_IO_ABTS_ISSUED)
 				atomic64_inc(&abts_stats->abort_io_not_found);
 			else
 				atomic64_inc(
 					&term_stats->terminate_io_not_found);
 			break;
 		default:
-			if (CMD_FLAGS(sc) & FNIC_IO_ABTS_ISSUED)
+			if (fnic_priv(sc)->flags & FNIC_IO_ABTS_ISSUED)
 				atomic64_inc(&abts_stats->abort_failures);
 			else
 				atomic64_inc(
 					&term_stats->terminate_failures);
 			break;
 		}
-		if (CMD_STATE(sc) != FNIC_IOREQ_ABTS_PENDING) {
+		if (fnic_priv(sc)->state != FNIC_IOREQ_ABTS_PENDING) {
 			/* This is a late completion. Ignore it */
 			spin_unlock_irqrestore(io_lock, flags);
 			return;
 		}
 
-		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_DONE;
-		CMD_ABTS_STATUS(sc) = hdr_status;
+		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_DONE;
+		fnic_priv(sc)->abts_status = hdr_status;
 
 		/* If the status is IO not found consider it as success */
 		if (hdr_status == FCPIO_IO_NOT_FOUND)
-			CMD_ABTS_STATUS(sc) = FCPIO_SUCCESS;
+			fnic_priv(sc)->abts_status = FCPIO_SUCCESS;
 
-		if (!(CMD_FLAGS(sc) & (FNIC_IO_ABORTED | FNIC_IO_DONE)))
+		if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE)))
 			atomic64_inc(&misc_stats->no_icmnd_itmf_cmpls);
 
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
@@ -1185,7 +1183,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		} else {
 			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				      "abts cmpl, completing IO\n");
-			CMD_SP(sc) = NULL;
+			fnic_priv(sc)->io_req = NULL;
 			sc->result = (DID_ERROR << 16);
 
 			spin_unlock_irqrestore(io_lock, flags);
@@ -1202,8 +1200,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 				    (u64)sc->cmnd[2] << 24 |
 				    (u64)sc->cmnd[3] << 16 |
 				    (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
-				   (((u64)CMD_FLAGS(sc) << 32) |
-				    CMD_STATE(sc)));
+				   fnic_flags_and_state(sc));
 			scsi_done(sc);
 			atomic64_dec(&fnic_stats->io_stats.active_ios);
 			if (atomic64_read(&fnic->io_cmpl_skip))
@@ -1213,15 +1210,14 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 		}
 	} else if (id & FNIC_TAG_DEV_RST) {
 		/* Completion of device reset */
-		CMD_LR_STATUS(sc) = hdr_status;
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
+		fnic_priv(sc)->lr_status = hdr_status;
+		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
 			spin_unlock_irqrestore(io_lock, flags);
-			CMD_FLAGS(sc) |= FNIC_DEV_RST_ABTS_PENDING;
+			fnic_priv(sc)->flags |= FNIC_DEV_RST_ABTS_PENDING;
 			FNIC_TRACE(fnic_fcpio_itmf_cmpl_handler,
 				  sc->device->host->host_no, id, sc,
 				  jiffies_to_msecs(jiffies - start_time),
-				  desc, 0,
-				  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+				  desc, 0, fnic_flags_and_state(sc));
 			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				"Terminate pending "
 				"dev reset cmpl recd. id %d status %s\n",
@@ -1229,14 +1225,13 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 				fnic_fcpio_status_to_str(hdr_status));
 			return;
 		}
-		if (CMD_FLAGS(sc) & FNIC_DEV_RST_TIMED_OUT) {
+		if (fnic_priv(sc)->flags & FNIC_DEV_RST_TIMED_OUT) {
 			/* Need to wait for terminate completion */
 			spin_unlock_irqrestore(io_lock, flags);
 			FNIC_TRACE(fnic_fcpio_itmf_cmpl_handler,
 				  sc->device->host->host_no, id, sc,
 				  jiffies_to_msecs(jiffies - start_time),
-				  desc, 0,
-				  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+				  desc, 0, fnic_flags_and_state(sc));
 			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				"dev reset cmpl recd after time out. "
 				"id %d status %s\n",
@@ -1244,8 +1239,8 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 				fnic_fcpio_status_to_str(hdr_status));
 			return;
 		}
-		CMD_STATE(sc) = FNIC_IOREQ_CMD_COMPLETE;
-		CMD_FLAGS(sc) |= FNIC_DEV_RST_DONE;
+		fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
+		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			      "dev reset cmpl recd. id %d status %s\n",
 			      (int)(id & FNIC_TAG_MASK),
@@ -1257,7 +1252,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic,
 	} else {
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "Unexpected itmf io state %s tag %x\n",
-			     fnic_ioreq_state_to_str(CMD_STATE(sc)), id);
+			     fnic_ioreq_state_to_str(fnic_priv(sc)->state), id);
 		spin_unlock_irqrestore(io_lock, flags);
 	}
 
@@ -1370,21 +1365,21 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data,
 	io_lock = fnic_io_lock_tag(fnic, tag);
 	spin_lock_irqsave(io_lock, flags);
 
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
-	if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
-	    !(CMD_FLAGS(sc) & FNIC_DEV_RST_DONE)) {
+	io_req = fnic_priv(sc)->io_req;
+	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
+	    !(fnic_priv(sc)->flags & FNIC_DEV_RST_DONE)) {
 		/*
 		 * We will be here only when FW completes reset
 		 * without sending completions for outstanding ios.
 		 */
-		CMD_FLAGS(sc) |= FNIC_DEV_RST_DONE;
+		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
 		if (io_req && io_req->dr_done)
 			complete(io_req->dr_done);
 		else if (io_req && io_req->abts_done)
 			complete(io_req->abts_done);
 		spin_unlock_irqrestore(io_lock, flags);
 		return true;
-	} else if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
+	} else if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
 		spin_unlock_irqrestore(io_lock, flags);
 		return true;
 	}
@@ -1393,7 +1388,7 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data,
 		goto cleanup_scsi_cmd;
 	}
 
-	CMD_SP(sc) = NULL;
+	fnic_priv(sc)->io_req = NULL;
 
 	spin_unlock_irqrestore(io_lock, flags);
 
@@ -1417,7 +1412,7 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data,
 		atomic64_inc(&fnic_stats->io_stats.io_completions);
 
 	/* Complete the command to SCSI */
-	if (!(CMD_FLAGS(sc) & FNIC_IO_ISSUED))
+	if (!(fnic_priv(sc)->flags & FNIC_IO_ISSUED))
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "Calling done for IO not issued to fw: tag:0x%x sc:0x%p\n",
 			     tag, sc);
@@ -1429,7 +1424,7 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data,
 		       (u64)sc->cmnd[2] << 24 |
 		       (u64)sc->cmnd[3] << 16 |
 		       (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
-		   (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+		   fnic_flags_and_state(sc));
 
 	scsi_done(sc);
 
@@ -1468,7 +1463,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 	spin_lock_irqsave(io_lock, flags);
 
 	/* Get the IO context which this desc refers to */
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 
 	/* fnic interrupts are turned off by now */
 
@@ -1477,7 +1472,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 		goto wq_copy_cleanup_scsi_cmd;
 	}
 
-	CMD_SP(sc) = NULL;
+	fnic_priv(sc)->io_req = NULL;
 
 	spin_unlock_irqrestore(io_lock, flags);
 
@@ -1496,7 +1491,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 		   0, ((u64)sc->cmnd[0] << 32 |
 		       (u64)sc->cmnd[2] << 24 | (u64)sc->cmnd[3] << 16 |
 		       (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
-		   (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+		   fnic_flags_and_state(sc));
 
 	scsi_done(sc);
 }
@@ -1571,15 +1566,15 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data,
 	io_lock = fnic_io_lock_tag(fnic, abt_tag);
 	spin_lock_irqsave(io_lock, flags);
 
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 
 	if (!io_req || io_req->port_id != iter_data->port_id) {
 		spin_unlock_irqrestore(io_lock, flags);
 		return true;
 	}
 
-	if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
-	    (!(CMD_FLAGS(sc) & FNIC_DEV_RST_ISSUED))) {
+	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
+	    !(fnic_priv(sc)->flags & FNIC_DEV_RST_ISSUED)) {
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"fnic_rport_exch_reset dev rst not pending sc 0x%p\n",
 			sc);
@@ -1591,7 +1586,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data,
 	 * Found IO that is still pending with firmware and
 	 * belongs to rport that went away
 	 */
-	if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
+	if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
 		spin_unlock_irqrestore(io_lock, flags);
 		return true;
 	}
@@ -1599,20 +1594,20 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data,
 		shost_printk(KERN_ERR, fnic->lport->host,
 			"fnic_rport_exch_reset: io_req->abts_done is set "
 			"state is %s\n",
-			fnic_ioreq_state_to_str(CMD_STATE(sc)));
+			fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 	}
 
-	if (!(CMD_FLAGS(sc) & FNIC_IO_ISSUED)) {
+	if (!(fnic_priv(sc)->flags & FNIC_IO_ISSUED)) {
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "rport_exch_reset "
 			     "IO not yet issued %p tag 0x%x flags "
 			     "%x state %d\n",
-			     sc, abt_tag, CMD_FLAGS(sc), CMD_STATE(sc));
+			     sc, abt_tag, fnic_priv(sc)->flags, fnic_priv(sc)->state);
 	}
-	old_ioreq_state = CMD_STATE(sc);
-	CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
-	CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
-	if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
+	old_ioreq_state = fnic_priv(sc)->state;
+	fnic_priv(sc)->state = FNIC_IOREQ_ABTS_PENDING;
+	fnic_priv(sc)->abts_status = FCPIO_INVALID_CODE;
+	if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
 		atomic64_inc(&reset_stats->device_reset_terminates);
 		abt_tag |= FNIC_TAG_DEV_RST;
 	}
@@ -1638,15 +1633,15 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data,
 		 * lun reset
 		 */
 		spin_lock_irqsave(io_lock, flags);
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-			CMD_STATE(sc) = old_ioreq_state;
+		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
+			fnic_priv(sc)->state = old_ioreq_state;
 		spin_unlock_irqrestore(io_lock, flags);
 	} else {
 		spin_lock_irqsave(io_lock, flags);
-		if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET)
-			CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
+		if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET)
+			fnic_priv(sc)->flags |= FNIC_DEV_RST_TERM_ISSUED;
 		else
-			CMD_FLAGS(sc) |= FNIC_IO_INTERNAL_TERM_ISSUED;
+			fnic_priv(sc)->flags |= FNIC_IO_INTERNAL_TERM_ISSUED;
 		spin_unlock_irqrestore(io_lock, flags);
 		atomic64_inc(&term_stats->terminates);
 		iter_data->term_cnt++;
@@ -1754,9 +1749,9 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	FNIC_SCSI_DBG(KERN_DEBUG,
 		fnic->lport->host,
 		"Abort Cmd called FCID 0x%x, LUN 0x%llx TAG %x flags %x\n",
-		rport->port_id, sc->device->lun, tag, CMD_FLAGS(sc));
+		rport->port_id, sc->device->lun, tag, fnic_priv(sc)->flags);
 
-	CMD_FLAGS(sc) = FNIC_NO_FLAGS;
+	fnic_priv(sc)->flags = FNIC_NO_FLAGS;
 
 	if (lp->state != LPORT_ST_READY || !(lp->link_up)) {
 		ret = FAILED;
@@ -1773,11 +1768,11 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	 * happened, the completion wont actually complete the command
 	 * and it will be considered as an aborted command
 	 *
-	 * The CMD_SP will not be cleared except while holding io_req_lock.
+	 * .io_req will not be cleared except while holding io_req_lock.
 	 */
 	io_lock = fnic_io_lock_hash(fnic, sc);
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(io_lock, flags);
 		goto fnic_abort_cmd_end;
@@ -1785,7 +1780,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 
 	io_req->abts_done = &tm_done;
 
-	if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
+	if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
 		spin_unlock_irqrestore(io_lock, flags);
 		goto wait_pending;
 	}
@@ -1814,9 +1809,9 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	 * the completion wont be done till mid-layer, since abort
 	 * has already started.
 	 */
-	old_ioreq_state = CMD_STATE(sc);
-	CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
-	CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
+	old_ioreq_state = fnic_priv(sc)->state;
+	fnic_priv(sc)->state = FNIC_IOREQ_ABTS_PENDING;
+	fnic_priv(sc)->abts_status = FCPIO_INVALID_CODE;
 
 	spin_unlock_irqrestore(io_lock, flags);
 
@@ -1838,9 +1833,9 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	if (fnic_queue_abort_io_req(fnic, tag, task_req, fc_lun.scsi_lun,
 				    io_req)) {
 		spin_lock_irqsave(io_lock, flags);
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-			CMD_STATE(sc) = old_ioreq_state;
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
+			fnic_priv(sc)->state = old_ioreq_state;
+		io_req = fnic_priv(sc)->io_req;
 		if (io_req)
 			io_req->abts_done = NULL;
 		spin_unlock_irqrestore(io_lock, flags);
@@ -1848,10 +1843,10 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 		goto fnic_abort_cmd_end;
 	}
 	if (task_req == FCPIO_ITMF_ABT_TASK) {
-		CMD_FLAGS(sc) |= FNIC_IO_ABTS_ISSUED;
+		fnic_priv(sc)->flags |= FNIC_IO_ABTS_ISSUED;
 		atomic64_inc(&fnic_stats->abts_stats.aborts);
 	} else {
-		CMD_FLAGS(sc) |= FNIC_IO_TERM_ISSUED;
+		fnic_priv(sc)->flags |= FNIC_IO_TERM_ISSUED;
 		atomic64_inc(&fnic_stats->term_stats.terminates);
 	}
 
@@ -1869,32 +1864,32 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	/* Check the abort status */
 	spin_lock_irqsave(io_lock, flags);
 
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
 		spin_unlock_irqrestore(io_lock, flags);
-		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_REQ_NULL;
+		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_REQ_NULL;
 		ret = FAILED;
 		goto fnic_abort_cmd_end;
 	}
 	io_req->abts_done = NULL;
 
 	/* fw did not complete abort, timed out */
-	if (CMD_ABTS_STATUS(sc) == FCPIO_INVALID_CODE) {
+	if (fnic_priv(sc)->abts_status == FCPIO_INVALID_CODE) {
 		spin_unlock_irqrestore(io_lock, flags);
 		if (task_req == FCPIO_ITMF_ABT_TASK) {
 			atomic64_inc(&abts_stats->abort_drv_timeouts);
 		} else {
 			atomic64_inc(&term_stats->terminate_drv_timeouts);
 		}
-		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_TIMED_OUT;
+		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_TIMED_OUT;
 		ret = FAILED;
 		goto fnic_abort_cmd_end;
 	}
 
 	/* IO out of order */
 
-	if (!(CMD_FLAGS(sc) & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
+	if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
 		spin_unlock_irqrestore(io_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"Issuing Host reset due to out of order IO\n");
@@ -1903,7 +1898,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 		goto fnic_abort_cmd_end;
 	}
 
-	CMD_STATE(sc) = FNIC_IOREQ_ABTS_COMPLETE;
+	fnic_priv(sc)->state = FNIC_IOREQ_ABTS_COMPLETE;
 
 	start_time = io_req->start_time;
 	/*
@@ -1911,9 +1906,9 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	 * free the io_req if successful. If abort fails,
 	 * Device reset will clean the I/O.
 	 */
-	if (CMD_ABTS_STATUS(sc) == FCPIO_SUCCESS)
-		CMD_SP(sc) = NULL;
-	else {
+	if (fnic_priv(sc)->abts_status == FCPIO_SUCCESS) {
+		fnic_priv(sc)->io_req = NULL;
+	} else {
 		ret = FAILED;
 		spin_unlock_irqrestore(io_lock, flags);
 		goto fnic_abort_cmd_end;
@@ -1939,7 +1934,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 		  0, ((u64)sc->cmnd[0] << 32 |
 		  (u64)sc->cmnd[2] << 24 | (u64)sc->cmnd[3] << 16 |
 		  (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
-		  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+		  fnic_flags_and_state(sc));
 
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 		      "Returning from abort cmd type %x %s\n", task_req,
@@ -2030,7 +2025,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
 
 	io_lock = fnic_io_lock_tag(fnic, abt_tag);
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(io_lock, flags);
 		return true;
@@ -2042,14 +2037,14 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
 	 */
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 		      "Found IO in %s on lun\n",
-		      fnic_ioreq_state_to_str(CMD_STATE(sc)));
+		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 
-	if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
+	if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING) {
 		spin_unlock_irqrestore(io_lock, flags);
 		return true;
 	}
-	if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
-	    (!(CMD_FLAGS(sc) & FNIC_DEV_RST_ISSUED))) {
+	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
+	    (!(fnic_priv(sc)->flags & FNIC_DEV_RST_ISSUED))) {
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
 			      "%s dev rst not pending sc 0x%p\n", __func__,
 			      sc);
@@ -2060,8 +2055,8 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
 	if (io_req->abts_done)
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "%s: io_req->abts_done is set state is %s\n",
-			     __func__, fnic_ioreq_state_to_str(CMD_STATE(sc)));
-	old_ioreq_state = CMD_STATE(sc);
+			     __func__, fnic_ioreq_state_to_str(fnic_priv(sc)->state));
+	old_ioreq_state = fnic_priv(sc)->state;
 	/*
 	 * Any pending IO issued prior to reset is expected to be
 	 * in abts pending state, if not we need to set
@@ -2069,17 +2064,17 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
 	 * When IO is completed, the IO will be handed over and
 	 * handled in this function.
 	 */
-	CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
+	fnic_priv(sc)->state = FNIC_IOREQ_ABTS_PENDING;
 
 	BUG_ON(io_req->abts_done);
 
-	if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
+	if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
 		abt_tag |= FNIC_TAG_DEV_RST;
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
 			      "%s: dev rst sc 0x%p\n", __func__, sc);
 	}
 
-	CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
+	fnic_priv(sc)->abts_status = FCPIO_INVALID_CODE;
 	io_req->abts_done = &tm_done;
 	spin_unlock_irqrestore(io_lock, flags);
 
@@ -2090,48 +2085,48 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
 				    FCPIO_ITMF_ABT_TASK_TERM,
 				    fc_lun.scsi_lun, io_req)) {
 		spin_lock_irqsave(io_lock, flags);
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+		io_req = fnic_priv(sc)->io_req;
 		if (io_req)
 			io_req->abts_done = NULL;
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-			CMD_STATE(sc) = old_ioreq_state;
+		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
+			fnic_priv(sc)->state = old_ioreq_state;
 		spin_unlock_irqrestore(io_lock, flags);
 		iter_data->ret = FAILED;
 		return false;
 	} else {
 		spin_lock_irqsave(io_lock, flags);
-		if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET)
-			CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
+		if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET)
+			fnic_priv(sc)->flags |= FNIC_DEV_RST_TERM_ISSUED;
 		spin_unlock_irqrestore(io_lock, flags);
 	}
-	CMD_FLAGS(sc) |= FNIC_IO_INTERNAL_TERM_ISSUED;
+	fnic_priv(sc)->flags |= FNIC_IO_INTERNAL_TERM_ISSUED;
 
 	wait_for_completion_timeout(&tm_done, msecs_to_jiffies
 				    (fnic->config.ed_tov));
 
 	/* Recheck cmd state to check if it is now aborted */
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(io_lock, flags);
-		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_REQ_NULL;
+		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_REQ_NULL;
 		return true;
 	}
 
 	io_req->abts_done = NULL;
 
 	/* if abort is still pending with fw, fail */
-	if (CMD_ABTS_STATUS(sc) == FCPIO_INVALID_CODE) {
+	if (fnic_priv(sc)->abts_status == FCPIO_INVALID_CODE) {
 		spin_unlock_irqrestore(io_lock, flags);
-		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_DONE;
+		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_DONE;
 		iter_data->ret = FAILED;
 		return false;
 	}
-	CMD_STATE(sc) = FNIC_IOREQ_ABTS_COMPLETE;
+	fnic_priv(sc)->state = FNIC_IOREQ_ABTS_COMPLETE;
 
 	/* original sc used for lr is handled by dev reset code */
 	if (sc != iter_data->lr_sc)
-		CMD_SP(sc) = NULL;
+		fnic_priv(sc)->io_req = NULL;
 	spin_unlock_irqrestore(io_lock, flags);
 
 	/* original sc used for lr is handled by dev reset code */
@@ -2272,7 +2267,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		goto fnic_device_reset_end;
 	}
 
-	CMD_FLAGS(sc) = FNIC_DEVICE_RESET;
+	fnic_priv(sc)->flags = FNIC_DEVICE_RESET;
 	/* Allocate tag if not present */
 
 	if (unlikely(tag < 0)) {
@@ -2288,7 +2283,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	}
 	io_lock = fnic_io_lock_hash(fnic, sc);
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 
 	/*
 	 * If there is a io_req attached to this command, then use it,
@@ -2302,11 +2297,11 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		}
 		memset(io_req, 0, sizeof(*io_req));
 		io_req->port_id = rport->port_id;
-		CMD_SP(sc) = (char *)io_req;
+		fnic_priv(sc)->io_req = io_req;
 	}
 	io_req->dr_done = &tm_done;
-	CMD_STATE(sc) = FNIC_IOREQ_CMD_PENDING;
-	CMD_LR_STATUS(sc) = FCPIO_INVALID_CODE;
+	fnic_priv(sc)->state = FNIC_IOREQ_CMD_PENDING;
+	fnic_priv(sc)->lr_status = FCPIO_INVALID_CODE;
 	spin_unlock_irqrestore(io_lock, flags);
 
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, "TAG %x\n", tag);
@@ -2317,13 +2312,13 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	 */
 	if (fnic_queue_dr_io_req(fnic, sc, io_req)) {
 		spin_lock_irqsave(io_lock, flags);
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+		io_req = fnic_priv(sc)->io_req;
 		if (io_req)
 			io_req->dr_done = NULL;
 		goto fnic_device_reset_clean;
 	}
 	spin_lock_irqsave(io_lock, flags);
-	CMD_FLAGS(sc) |= FNIC_DEV_RST_ISSUED;
+	fnic_priv(sc)->flags |= FNIC_DEV_RST_ISSUED;
 	spin_unlock_irqrestore(io_lock, flags);
 
 	/*
@@ -2334,7 +2329,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 				    msecs_to_jiffies(FNIC_LUN_RESET_TIMEOUT));
 
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(io_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
@@ -2343,7 +2338,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	}
 	io_req->dr_done = NULL;
 
-	status = CMD_LR_STATUS(sc);
+	status = fnic_priv(sc)->lr_status;
 
 	/*
 	 * If lun reset not completed, bail out with failed. io_req
@@ -2353,7 +2348,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		atomic64_inc(&reset_stats->device_reset_timeouts);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			      "Device reset timed out\n");
-		CMD_FLAGS(sc) |= FNIC_DEV_RST_TIMED_OUT;
+		fnic_priv(sc)->flags |= FNIC_DEV_RST_TIMED_OUT;
 		spin_unlock_irqrestore(io_lock, flags);
 		int_to_scsilun(sc->device->lun, &fc_lun);
 		/*
@@ -2362,7 +2357,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		 */
 		while (1) {
 			spin_lock_irqsave(io_lock, flags);
-			if (CMD_FLAGS(sc) & FNIC_DEV_RST_TERM_ISSUED) {
+			if (fnic_priv(sc)->flags & FNIC_DEV_RST_TERM_ISSUED) {
 				spin_unlock_irqrestore(io_lock, flags);
 				break;
 			}
@@ -2375,8 +2370,8 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 				msecs_to_jiffies(FNIC_ABT_TERM_DELAY_TIMEOUT));
 			} else {
 				spin_lock_irqsave(io_lock, flags);
-				CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
-				CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
+				fnic_priv(sc)->flags |= FNIC_DEV_RST_TERM_ISSUED;
+				fnic_priv(sc)->state = FNIC_IOREQ_ABTS_PENDING;
 				io_req->abts_done = &tm_done;
 				spin_unlock_irqrestore(io_lock, flags);
 				FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
@@ -2387,13 +2382,13 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		}
 		while (1) {
 			spin_lock_irqsave(io_lock, flags);
-			if (!(CMD_FLAGS(sc) & FNIC_DEV_RST_DONE)) {
+			if (!(fnic_priv(sc)->flags & FNIC_DEV_RST_DONE)) {
 				spin_unlock_irqrestore(io_lock, flags);
 				wait_for_completion_timeout(&tm_done,
 				msecs_to_jiffies(FNIC_LUN_RESET_TIMEOUT));
 				break;
 			} else {
-				io_req = (struct fnic_io_req *)CMD_SP(sc);
+				io_req = fnic_priv(sc)->io_req;
 				io_req->abts_done = NULL;
 				goto fnic_device_reset_clean;
 			}
@@ -2408,7 +2403,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		FNIC_SCSI_DBG(KERN_DEBUG,
 			      fnic->lport->host,
 			      "Device reset completed - failed\n");
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+		io_req = fnic_priv(sc)->io_req;
 		goto fnic_device_reset_clean;
 	}
 
@@ -2421,7 +2416,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	 */
 	if (fnic_clean_pending_aborts(fnic, sc, new_sc)) {
 		spin_lock_irqsave(io_lock, flags);
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+		io_req = fnic_priv(sc)->io_req;
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			      "Device reset failed"
 			      " since could not abort all IOs\n");
@@ -2430,14 +2425,14 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 
 	/* Clean lun reset command */
 	spin_lock_irqsave(io_lock, flags);
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	if (io_req)
 		/* Completed, and successful */
 		ret = SUCCESS;
 
 fnic_device_reset_clean:
 	if (io_req)
-		CMD_SP(sc) = NULL;
+		fnic_priv(sc)->io_req = NULL;
 
 	spin_unlock_irqrestore(io_lock, flags);
 
@@ -2453,7 +2448,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		  0, ((u64)sc->cmnd[0] << 32 |
 		  (u64)sc->cmnd[2] << 24 | (u64)sc->cmnd[3] << 16 |
 		  (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
-		  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+		  fnic_flags_and_state(sc));
 
 	/* free tag if it is allocated */
 	if (unlikely(tag_gen_flag))
@@ -2698,7 +2693,7 @@ static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data,
 	io_lock = fnic_io_lock_hash(fnic, sc);
 	spin_lock_irqsave(io_lock, flags);
 
-	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(io_lock, flags);
 		return true;
@@ -2710,8 +2705,8 @@ static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data,
 	 */
 	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
 		      "Found IO in %s on lun\n",
-		      fnic_ioreq_state_to_str(CMD_STATE(sc)));
-	cmd_state = CMD_STATE(sc);
+		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
+	cmd_state = fnic_priv(sc)->state;
 	spin_unlock_irqrestore(io_lock, flags);
 	if (cmd_state == FNIC_IOREQ_ABTS_PENDING)
 		iter_data->ret = 1;
