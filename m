Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9A4C1B5
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSTtE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 15:49:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46488 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSTtE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 15:49:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so212507pgr.13
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jun 2019 12:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fT+GP8wuoqIZvVNpIrHXF4NLPmgnDvFIomxIS61gl70=;
        b=IibEzDvvK/Quho6LE5VtfNb/wWtFlxsalEkcL+ZuSC4cQ3trDk9e6WtYzN8QRGQm3A
         dripdpwnYNZPebFiM3w6hqerJhRi/FXWc3zyO+BbNdaLCG6A9uHwHdjqfY0bNuZKM5SW
         HKQ47zADaV3tl4qDkm6o1CuU4DWaFrGUx3Y9jiHN//buD9LCeA2GDuypDuMbTzShMkKG
         SySnpB/E7InFt16iRkH30MmO/wdnAIdkzZcYWq/82T3u5ncC2/A1tUzDITH35jiA4vtf
         BV/HuttWukR7EqEmrAsJQjy+sMT4bct8Ba+tRwNWfkW9XWGAG1xGpfTAtTIP8FcDI6ZS
         heTQ==
X-Gm-Message-State: APjAAAXCMidkahkXZbkAbutPjeK6dp7ULHTm0mnOWheiqspT71LUTmXk
        32Nnv4QtYXoUpe1I0p3MAX0=
X-Google-Smtp-Source: APXvYqy8wKiX2bBQdtdbq9ZqjW5S8/iUfPycBeuh83BLQjKKTjJYzXpBk0uXej0jqyi7QgmhfkU+Vw==
X-Received: by 2002:a63:4e:: with SMTP id 75mr2826003pga.318.1560973743684;
        Wed, 19 Jun 2019 12:49:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v9sm24858415pgj.69.2019.06.19.12.49.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 12:49:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH] qla2xxx: Make sure that aborted commands are freed
Date:   Wed, 19 Jun 2019 12:48:55 -0700
Message-Id: <20190619194855.52199-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The LIO core requires that the target driver callback functions
.queue_data_in() and .queue_status() call target_put_sess_cmd() or
transport_generic_free_cmd(). These calls may happen synchronously or
asynchronously. Make sure that one of these LIO functions is called
in case a command has been aborted. This patch avoids that the code
for removing a session hangs due to commands that do not make progress.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: 694833ee00c4 ("scsi: tcm_qla2xxx: Do not allow aborted cmd to advance.") # v4.13.
Fixes: a07100e00ac4 ("qla2xxx: Fix TMR ABORT interaction issue between qla2xxx and TCM") # v4.5.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c  | 13 ++++++++-----
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |  4 ++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index f559be647c33..08cafaaf6ab2 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3216,7 +3216,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 	if (!qpair->fw_started || (cmd->reset_count != qpair->chip_reset) ||
 	    (cmd->sess && cmd->sess->deleted)) {
 		cmd->state = QLA_TGT_STATE_PROCESSED;
-		return 0;
+		res = 0;
+		goto free;
 	}
 
 	ql_dbg_qp(ql_dbg_tgt, qpair, 0xe018,
@@ -3227,9 +3228,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 
 	res = qlt_pre_xmit_response(cmd, &prm, xmit_type, scsi_status,
 	    &full_req_cnt);
-	if (unlikely(res != 0)) {
-		return res;
-	}
+	if (unlikely(res != 0))
+		goto free;
 
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 
@@ -3249,7 +3249,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 			vha->flags.online, qla2x00_reset_active(vha),
 			cmd->reset_count, qpair->chip_reset);
 		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-		return 0;
+		res = 0;
+		goto free;
 	}
 
 	/* Does F/W have an IOCBs for this request */
@@ -3352,6 +3353,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 	qlt_unmap_sg(vha, cmd);
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
+free:
+	vha->hw->tgt.tgt_ops->free_cmd(cmd);
 	return res;
 }
 EXPORT_SYMBOL(qlt_xmit_response);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 52a3e948ef49..fc10a4d5a8ff 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -628,6 +628,7 @@ static int tcm_qla2xxx_queue_data_in(struct se_cmd *se_cmd)
 {
 	struct qla_tgt_cmd *cmd = container_of(se_cmd,
 				struct qla_tgt_cmd, se_cmd);
+	struct scsi_qla_host *vha = cmd->vha;
 
 	if (cmd->aborted) {
 		/* Cmd can loop during Q-full.  tcm_qla2xxx_aborted_task
@@ -640,6 +641,7 @@ static int tcm_qla2xxx_queue_data_in(struct se_cmd *se_cmd)
 			cmd->se_cmd.transport_state,
 			cmd->se_cmd.t_state,
 			cmd->se_cmd.se_cmd_flags);
+		vha->hw->tgt.tgt_ops->free_cmd(cmd);
 		return 0;
 	}
 
@@ -667,6 +669,7 @@ static int tcm_qla2xxx_queue_status(struct se_cmd *se_cmd)
 {
 	struct qla_tgt_cmd *cmd = container_of(se_cmd,
 				struct qla_tgt_cmd, se_cmd);
+	struct scsi_qla_host *vha = cmd->vha;
 	int xmit_type = QLA_TGT_XMIT_STATUS;
 
 	if (cmd->aborted) {
@@ -680,6 +683,7 @@ static int tcm_qla2xxx_queue_status(struct se_cmd *se_cmd)
 		    cmd, kref_read(&cmd->se_cmd.cmd_kref),
 		    cmd->se_cmd.transport_state, cmd->se_cmd.t_state,
 		    cmd->se_cmd.se_cmd_flags);
+		vha->hw->tgt.tgt_ops->free_cmd(cmd);
 		return 0;
 	}
 	cmd->bufflen = se_cmd->data_length;
-- 
2.22.0.rc3

