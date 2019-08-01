Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAE7E1B8
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbfHAR5d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34526 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbfHAR5d (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so34506838pfo.1
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4nQc0QOC9CQBdMP47Sf/y57e9qrK3dgSM4ssBB5cxI=;
        b=L3FQJQOYUPLmRYunwaWT4mHsIMGX02y3TzVthQUAJZk+mvongr9stq/PSS7EAbvYcd
         Ra+BTZ0rPTA2zvToBty8oEAkMGXRfgE77LwMMETnuS8xx6OJsk2YmI9Vnpwc9QFbeuLD
         C62hdXjOJX0RzaUaEaPap6v0BBkkuPVoe421MkVSVRTzRhhRNE95nFwXEGvzqbdgDs90
         Pln60VLmdlfyyMG5tUaWGbtBlmLrmtQ+lh382mPKOlKEgzWAp8Y9RhPOJxS8G7i0DbnA
         ORiZr0mj4Uwuqnt2t7qRZ1e+UD7GiIsT2FFmCTz4tAZ819XHOF7qDkfoLCawOkaVf0cK
         WDbQ==
X-Gm-Message-State: APjAAAWIqrTcQXZLVSGL6v4hQpYxsD86UjFnLRAtl75qRcdf562eGnCa
        4xcFELpj6pdckj5I3gTSJ5fp2TbN
X-Google-Smtp-Source: APXvYqyyHjk9m2bw036rRLw0C5+PpGBAJA4H5nZOO5Xk07sTOBkil+nJ6jyM3zHj1EzsN8RZrbpLeA==
X-Received: by 2002:a65:4103:: with SMTP id w3mr101931690pgp.1.1564682252541;
        Thu, 01 Aug 2019 10:57:32 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 52/59] qla2xxx: Let the compiler check the type of the SCSI command context pointer
Date:   Thu,  1 Aug 2019 10:56:07 -0700
Message-Id: <20190801175614.73655-53-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Split srb_cmd.ctx into two pointers such that the compiler can check
the type of that pointer.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |  4 ++--
 drivers/scsi/qla2xxx/qla_iocb.c | 20 +++++++++-----------
 drivers/scsi/qla2xxx/qla_nx.c   |  2 +-
 drivers/scsi/qla2xxx/qla_os.c   | 24 ++++++++----------------
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 3ffe7661a25b..527b2a2708a1 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -317,7 +317,8 @@ struct srb_cmd {
 	uint32_t request_sense_length;
 	uint32_t fw_sense_length;
 	uint8_t *request_sense_ptr;
-	void *ctx;
+	struct ct6_dsd *ct6_ctx;
+	struct crc_context *crc_ctx;
 };
 
 /*
@@ -630,7 +631,6 @@ typedef struct srb {
 } srb_t;
 
 #define GET_CMD_SP(sp) (sp->u.scmd.cmd)
-#define GET_CMD_CTX_SP(sp) (sp->u.scmd.ctx)
 
 #define GET_CMD_SENSE_LEN(sp) \
 	(sp->u.scmd.request_sense_length)
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 22d875222321..6acf92d19951 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -621,7 +621,7 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
 	}
 
 	cur_seg = scsi_sglist(cmd);
-	ctx = GET_CMD_CTX_SP(sp);
+	ctx = sp->u.scmd.ct6_ctx;
 
 	while (tot_dsds) {
 		avail_dsds = (tot_dsds > QLA_DSDS_PER_IOCB) ?
@@ -954,8 +954,7 @@ qla24xx_walk_and_build_sglist_no_difb(struct qla_hw_data *ha, srb_t *sp,
 
 			if (sp) {
 				list_add_tail(&dsd_ptr->list,
-				    &((struct crc_context *)
-					    sp->u.scmd.ctx)->dsd_list);
+					      &sp->u.scmd.crc_ctx->dsd_list);
 
 				sp->flags |= SRB_CRC_CTX_DSD_VALID;
 			} else {
@@ -1052,8 +1051,7 @@ qla24xx_walk_and_build_sglist(struct qla_hw_data *ha, srb_t *sp,
 
 			if (sp) {
 				list_add_tail(&dsd_ptr->list,
-				    &((struct crc_context *)
-					    sp->u.scmd.ctx)->dsd_list);
+					      &sp->u.scmd.crc_ctx->dsd_list);
 
 				sp->flags |= SRB_CRC_CTX_DSD_VALID;
 			} else {
@@ -1099,7 +1097,7 @@ qla24xx_walk_and_build_prot_sglist(struct qla_hw_data *ha, srb_t *sp,
 
 		sgl = scsi_prot_sglist(cmd);
 		vha = sp->vha;
-		difctx = sp->u.scmd.ctx;
+		difctx = sp->u.scmd.crc_ctx;
 		direction_to_device = cmd->sc_data_direction == DMA_TO_DEVICE;
 		ql_dbg(ql_dbg_tgt + ql_dbg_verbose, vha, 0xe021,
 		  "%s: scsi_cmnd: %p, crc_ctx: %p, sp: %p\n",
@@ -1439,7 +1437,7 @@ qla24xx_build_scsi_crc_2_iocbs(srb_t *sp, struct cmd_type_crc_2 *cmd_pkt,
 		bundling = 0;
 
 	/* Allocate CRC context from global pool */
-	crc_ctx_pkt = sp->u.scmd.ctx =
+	crc_ctx_pkt = sp->u.scmd.crc_ctx =
 	    dma_pool_zalloc(ha->dl_dma_pool, GFP_ATOMIC, &crc_ctx_dma);
 
 	if (!crc_ctx_pkt)
@@ -3188,7 +3186,7 @@ qla82xx_start_scsi(srb_t *sp)
 				goto queuing_error;
 		}
 
-		ctx = sp->u.scmd.ctx =
+		ctx = sp->u.scmd.ct6_ctx =
 		    mempool_alloc(ha->ctx_mempool, GFP_ATOMIC);
 		if (!ctx) {
 			ql_log(ql_log_fatal, vha, 0x3010,
@@ -3384,9 +3382,9 @@ qla82xx_start_scsi(srb_t *sp)
 	if (tot_dsds)
 		scsi_dma_unmap(cmd);
 
-	if (sp->u.scmd.ctx) {
-		mempool_free(sp->u.scmd.ctx, ha->ctx_mempool);
-		sp->u.scmd.ctx = NULL;
+	if (sp->u.scmd.crc_ctx) {
+		mempool_free(sp->u.scmd.crc_ctx, ha->ctx_mempool);
+		sp->u.scmd.crc_ctx = NULL;
 	}
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index a91d426add75..372355bfcbb6 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -3686,7 +3686,7 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
 			for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
 				sp = req->outstanding_cmds[cnt];
 				if (sp) {
-					if ((!sp->u.scmd.ctx ||
+					if ((!sp->u.scmd.crc_ctx ||
 					    (sp->flags &
 						SRB_FCP_CMND_DMA_VALID)) &&
 						!ha->flags.isp82xx_fw_hung) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 05e63bde22e3..eac922051a50 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -656,7 +656,6 @@ void qla2x00_sp_free_dma(srb_t *sp)
 {
 	struct qla_hw_data *ha = sp->vha->hw;
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
-	void *ctx = GET_CMD_CTX_SP(sp);
 
 	if (sp->flags & SRB_DMA_VALID) {
 		scsi_dma_unmap(cmd);
@@ -669,24 +668,21 @@ void qla2x00_sp_free_dma(srb_t *sp)
 		sp->flags &= ~SRB_CRC_PROT_DMA_VALID;
 	}
 
-	if (!ctx)
-		return;
-
 	if (sp->flags & SRB_CRC_CTX_DSD_VALID) {
 		/* List assured to be having elements */
-		qla2x00_clean_dsd_pool(ha, ctx);
+		qla2x00_clean_dsd_pool(ha, sp->u.scmd.crc_ctx);
 		sp->flags &= ~SRB_CRC_CTX_DSD_VALID;
 	}
 
 	if (sp->flags & SRB_CRC_CTX_DMA_VALID) {
-		struct crc_context *ctx0 = ctx;
+		struct crc_context *ctx0 = sp->u.scmd.crc_ctx;
 
 		dma_pool_free(ha->dl_dma_pool, ctx0, ctx0->crc_ctx_dma);
 		sp->flags &= ~SRB_CRC_CTX_DMA_VALID;
 	}
 
 	if (sp->flags & SRB_FCP_CMND_DMA_VALID) {
-		struct ct6_dsd *ctx1 = ctx;
+		struct ct6_dsd *ctx1 = sp->u.scmd.ct6_ctx;
 
 		dma_pool_free(ha->fcp_cmnd_dma_pool, ctx1->fcp_cmnd,
 		    ctx1->fcp_cmnd_dma);
@@ -719,7 +715,6 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 {
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct qla_hw_data *ha = sp->fcport->vha->hw;
-	void *ctx = GET_CMD_CTX_SP(sp);
 
 	if (sp->flags & SRB_DMA_VALID) {
 		scsi_dma_unmap(cmd);
@@ -732,17 +727,14 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 		sp->flags &= ~SRB_CRC_PROT_DMA_VALID;
 	}
 
-	if (!ctx)
-		return;
-
 	if (sp->flags & SRB_CRC_CTX_DSD_VALID) {
 		/* List assured to be having elements */
-		qla2x00_clean_dsd_pool(ha, ctx);
+		qla2x00_clean_dsd_pool(ha, sp->u.scmd.crc_ctx);
 		sp->flags &= ~SRB_CRC_CTX_DSD_VALID;
 	}
 
 	if (sp->flags & SRB_DIF_BUNDL_DMA_VALID) {
-		struct crc_context *difctx = ctx;
+		struct crc_context *difctx = sp->u.scmd.crc_ctx;
 		struct dsd_dma *dif_dsd, *nxt_dsd;
 
 		list_for_each_entry_safe(dif_dsd, nxt_dsd,
@@ -778,7 +770,7 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 	}
 
 	if (sp->flags & SRB_FCP_CMND_DMA_VALID) {
-		struct ct6_dsd *ctx1 = ctx;
+		struct ct6_dsd *ctx1 = sp->u.scmd.ct6_ctx;
 
 		dma_pool_free(ha->fcp_cmnd_dma_pool, ctx1->fcp_cmnd,
 		    ctx1->fcp_cmnd_dma);
@@ -790,9 +782,9 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 	}
 
 	if (sp->flags & SRB_CRC_CTX_DMA_VALID) {
-		struct crc_context *ctx0 = ctx;
+		struct crc_context *ctx0 = sp->u.scmd.crc_ctx;
 
-		dma_pool_free(ha->dl_dma_pool, ctx, ctx0->crc_ctx_dma);
+		dma_pool_free(ha->dl_dma_pool, ctx0, ctx0->crc_ctx_dma);
 		sp->flags &= ~SRB_CRC_CTX_DMA_VALID;
 	}
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

