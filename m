Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5C87002
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2019 05:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405336AbfHIDDq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Aug 2019 23:03:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405025AbfHIDDp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Aug 2019 23:03:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id z14so7869595pga.5
        for <linux-scsi@vger.kernel.org>; Thu, 08 Aug 2019 20:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dicEH76HmLjK6O9L5Bk17c7YpzZyrQwUSyTIyiw3k8k=;
        b=PhWBT0S3D51yaF2z9qcYx7raDmbCTDntw9O/nWJwNrudGDLpntWIqjgSnzPjSJKkms
         mdbTCYOQaWGmXK8Pf0yUfEaQIYL6btSSayjbGkVRxStsI7vZZ00qf8IuzrtbTF6clwSe
         9gnKHRJKMtjOkQKg7uakFeLbDorCWgPBB8GfH+6rlmQn8KLO6UYv72jsJEUy/XHaK6gq
         t77u8wocon+YcL3IlB17k8AuGf5d5JRicE3Afb5X28Pk9Edzhzpbqq3SUAsFz/bCqjra
         aHF/g9YROwJ5Bx3PFqAuce2EJzSOn45mhAZUUCkMGQGQ1by/vWpAWEjId2j1X8t0L0A8
         rMMQ==
X-Gm-Message-State: APjAAAVY9nDkHFOBFp5pChzsTvFFSJSmG4YN3eEA1QkabA4F0jmW/4BK
        2sl8COu9iyoSm8ivRqlxXAVS4HX7
X-Google-Smtp-Source: APXvYqx9gTve5QfMXrfRs8m29Kdz0jZX4p8ACPDaR6hHwCE0oHQCO4yOKfBdjot9EPR3VyVGv436KQ==
X-Received: by 2002:a65:6891:: with SMTP id e17mr15812728pgt.305.1565319824840;
        Thu, 08 Aug 2019 20:03:44 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4001:6530:8f02:649d:771a:4703])
        by smtp.gmail.com with ESMTPSA id g2sm111787580pfi.26.2019.08.08.20.03.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:03:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: [PATCH v2 51/58] qla2xxx: Let the compiler check the type of the SCSI command context pointer
Date:   Thu,  8 Aug 2019 20:02:12 -0700
Message-Id: <20190809030219.11296-52-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809030219.11296-1-bvanassche@acm.org>
References: <20190809030219.11296-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Split srb_cmd.ctx into two pointers such that the compiler can check
the type of that pointer.

Cc: Himanshu Madhani <hmadhani@marvell.com>
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
index 5ca7f7913258..5cb0bb65ace3 100644
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
2.22.0

