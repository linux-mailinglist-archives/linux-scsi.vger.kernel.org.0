Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A487D7E1AF
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfHAR5Y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45034 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388063AbfHAR5Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so34474979pfe.11
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qq+9HhHFxc/oF+fhf66nj06VsT0kq4+OPOLvCdU0vEs=;
        b=CAjRmgANDDmsCGxP+RL/s3gCekcdfqEjhF9Si/gSS3SuqBo1igDwpvQ51HBNaRaEwO
         OV5HLMqIws0IEncyDbiZcGl7gnG7PE3FLiheztzbqgYQwtTupRxhVBjMWuf7AEW5kAd+
         xxPssfyZz1vYh18cGWSQFmEWkGZX12i1+mR4xckOUQJSwbe/eVgai0bbPqMalBcVsld4
         s5cPR5oMg4dJOpcpXwaAAFqHM51gGTIwSqRVNOCtk6Qvnc8Y580dvOT8s0+9hCrLDI5r
         XfEVIkZIBXnFrDpHce7vtnlk5wkbSeRJ63xpwU25ScosoMOZEgmsBdTggBMq9+UIS4QV
         XASw==
X-Gm-Message-State: APjAAAX0T2sJp/dswGtA/jVqQsSGW4SEmvw3mGF3+WTfoE7Ck+UnBJBR
        Ml4C+f0qa6vtzRUjRc1pvUo=
X-Google-Smtp-Source: APXvYqzE3ikIIZRTJo2hQRQyWBAoYFasi3GkayOCI8492BrOyUswolZPIGtd4XpUgIJfx2rFNgtNdA==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr120117846pgk.378.1564682243130;
        Thu, 01 Aug 2019 10:57:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 45/59] qla2xxx: Fix a race condition between aborting and completing a SCSI command
Date:   Thu,  1 Aug 2019 10:56:00 -0700
Message-Id: <20190801175614.73655-46-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of allocating a struct srb dynamically from inside .queuecommand(),
set qla2xxx_driver_template.cmd_size such that struct scsi_cmnd and struct
srb are contiguous. Do not call QLA_QPAIR_MARK_BUSY() /
QLA_QPAIR_MARK_NOT_BUSY() for SRBs associated with SCSI commands. That is
safe because scsi_remove_host() is called before queue pairs are deleted
and scsi_remove_host() waits for all outstanding SCSI commands to finish.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h |  1 -
 drivers/scsi/qla2xxx/qla_os.c  | 46 +++++++---------------------------
 2 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 65d79bcb7ccf..3ffe7661a25b 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -630,7 +630,6 @@ typedef struct srb {
 } srb_t;
 
 #define GET_CMD_SP(sp) (sp->u.scmd.cmd)
-#define SET_CMD_SP(sp, cmd) (sp->u.scmd.cmd = cmd)
 #define GET_CMD_CTX_SP(sp) (sp->u.scmd.ctx)
 
 #define GET_CMD_SENSE_LEN(sp) \
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 0b7d4092ea31..835572d7d71a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -713,7 +713,6 @@ void qla2x00_sp_compl(srb_t *sp, int res)
 	cmd->scsi_done(cmd);
 	if (comp)
 		complete(comp);
-	qla2x00_rel_sp(sp);
 }
 
 void qla2xxx_qpair_sp_free_dma(srb_t *sp)
@@ -814,7 +813,6 @@ void qla2xxx_qpair_sp_compl(srb_t *sp, int res)
 	cmd->scsi_done(cmd);
 	if (comp)
 		complete(comp);
-	qla2xxx_rel_qpair_sp(sp->qpair, sp);
 }
 
 static int
@@ -908,9 +906,8 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	else
 		goto qc24_target_busy;
 
-	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
-	if (!sp)
-		goto qc24_host_busy;
+	sp = scsi_cmd_priv(cmd);
+	qla2xxx_init_sp(sp, vha, vha->hw->base_qpair, fcport);
 
 	sp->u.scmd.cmd = cmd;
 	sp->type = SRB_SCSI_CMD;
@@ -931,9 +928,6 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 qc24_host_busy_free_sp:
 	sp->free(sp);
 
-qc24_host_busy:
-	return SCSI_MLQUEUE_HOST_BUSY;
-
 qc24_target_busy:
 	return SCSI_MLQUEUE_TARGET_BUSY;
 
@@ -994,9 +988,8 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 	else
 		goto qc24_target_busy;
 
-	sp = qla2xxx_get_qpair_sp(vha, qpair, fcport, GFP_ATOMIC);
-	if (!sp)
-		goto qc24_host_busy;
+	sp = scsi_cmd_priv(cmd);
+	qla2xxx_init_sp(sp, vha, qpair, fcport);
 
 	sp->u.scmd.cmd = cmd;
 	sp->type = SRB_SCSI_CMD;
@@ -1020,9 +1013,6 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 qc24_host_busy_free_sp:
 	sp->free(sp);
 
-qc24_host_busy:
-	return SCSI_MLQUEUE_HOST_BUSY;
-
 qc24_target_busy:
 	return SCSI_MLQUEUE_TARGET_BUSY;
 
@@ -1257,10 +1247,8 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	int ret;
 	unsigned int id;
 	uint64_t lun;
-	unsigned long flags;
 	int rval;
 	struct qla_hw_data *ha = vha->hw;
-	struct qla_qpair *qpair;
 
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x8042,
@@ -1272,32 +1260,14 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	if (ret != 0)
 		return ret;
 
-	sp = (srb_t *) CMD_SP(cmd);
-	if (!sp)
-		return SUCCESS;
-
-	qpair = sp->qpair;
-	if (!qpair)
-		return SUCCESS;
+	sp = scsi_cmd_priv(cmd);
 
 	if (sp->fcport && sp->fcport->deleted)
 		return SUCCESS;
 
-	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
-	if (sp->type != SRB_SCSI_CMD || GET_CMD_SP(sp) != cmd) {
-		/* there's a chance an interrupt could clear
-		   the ptr as part of done & free */
-		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-		return SUCCESS;
-	}
-
-	/* Get a reference to the sp and drop the lock. */
-	if (sp_get(sp)){
-		/* ref_count is already 0 */
-		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+	/* Return if the command has already finished. */
+	if (sp_get(sp))
 		return SUCCESS;
-	}
-	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
 	id = cmd->device->id;
 	lun = cmd->device->lun;
@@ -1325,6 +1295,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 		uint32_t ratov = ha->r_a_tov/10;
 		uint32_t ratov_j = msecs_to_jiffies(4 * ratov * 1000);
 
+		WARN_ON_ONCE(sp->comp);
 		sp->comp = &comp;
 		if (!wait_for_completion_timeout(&comp, ratov_j)) {
 			ql_dbg(ql_dbg_taskm, vha, 0xffff,
@@ -7151,6 +7122,7 @@ struct scsi_host_template qla2xxx_driver_template = {
 
 	.supported_mode		= MODE_INITIATOR,
 	.track_queue_depth	= 1,
+	.cmd_size		= sizeof(srb_t),
 };
 
 static const struct pci_error_handlers qla2xxx_err_handler = {
-- 
2.22.0.770.g0f2c4a37fd-goog

