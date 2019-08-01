Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C567E1B6
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbfHAR5b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45043 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbfHAR5a (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so34475139pfe.11
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRzRaP8Qo8FvzCEMg/8RzizUHxRaemQZ+Ru/lTrjkQo=;
        b=Goo2utWDZBeltP7f3fV5eQOTZorgnmhTzmaCrDNfgMlkEnb1AgWJf6x3dlXJs+v4JF
         ov/oiWNP6jekzZJf4aDrFSX+cfoFPU/7TVsGmTf8fTdWB0Bp4gdkXmlpMzu+1x6/n9nQ
         wOGA0x2y/L2Tw/RsOhSvaMd4iDOZJiSIAKnOWeRilPFX6foe/IUl5QG+1QL5EGheTMXP
         j6+XZ7vi/ovh5NhGQgNrisxXUTryHJOapgtGXFoTJc30Unc55UadOYkz03X3v/vJnk0g
         oWVJCyyfu5Wxf1nxR79H+FSLolisZnBDhiAgFA19NfebueOZNMa2KJC9svpHGe2Cpy9t
         6Msg==
X-Gm-Message-State: APjAAAW5Re+18hj0TCOtbWvOaKb0p5Nxi7OVighYqE/I4ahEPRbsaRBy
        Kav8RgQ1NL5SjHKPS+UfteE=
X-Google-Smtp-Source: APXvYqwdTZ9h6E1foWFSR34QqJ7l05cmDH2QoI5Y1bC2WNv662WyqJbCo6/o5jtPksHhOblKciqbcQ==
X-Received: by 2002:a17:90a:30cf:: with SMTP id h73mr54987pjb.42.1564682249826;
        Thu, 01 Aug 2019 10:57:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 50/59] qla2xxx: Make sure that aborted commands are freed
Date:   Thu,  1 Aug 2019 10:56:05 -0700
Message-Id: <20190801175614.73655-51-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
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
index cc0c99b5f3fb..0ffda6171614 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3206,7 +3206,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 	if (!qpair->fw_started || (cmd->reset_count != qpair->chip_reset) ||
 	    (cmd->sess && cmd->sess->deleted)) {
 		cmd->state = QLA_TGT_STATE_PROCESSED;
-		return 0;
+		res = 0;
+		goto free;
 	}
 
 	ql_dbg_qp(ql_dbg_tgt, qpair, 0xe018,
@@ -3217,9 +3218,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 
 	res = qlt_pre_xmit_response(cmd, &prm, xmit_type, scsi_status,
 	    &full_req_cnt);
-	if (unlikely(res != 0)) {
-		return res;
-	}
+	if (unlikely(res != 0))
+		goto free;
 
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 
@@ -3239,7 +3239,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 			vha->flags.online, qla2x00_reset_active(vha),
 			cmd->reset_count, qpair->chip_reset);
 		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-		return 0;
+		res = 0;
+		goto free;
 	}
 
 	/* Does F/W have an IOCBs for this request */
@@ -3342,6 +3343,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 	qlt_unmap_sg(vha, cmd);
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
+free:
+	vha->hw->tgt.tgt_ops->free_cmd(cmd);
 	return res;
 }
 EXPORT_SYMBOL(qlt_xmit_response);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 963c220f8ba8..042a24314edc 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -620,6 +620,7 @@ static int tcm_qla2xxx_queue_data_in(struct se_cmd *se_cmd)
 {
 	struct qla_tgt_cmd *cmd = container_of(se_cmd,
 				struct qla_tgt_cmd, se_cmd);
+	struct scsi_qla_host *vha = cmd->vha;
 
 	if (cmd->aborted) {
 		/* Cmd can loop during Q-full.  tcm_qla2xxx_aborted_task
@@ -632,6 +633,7 @@ static int tcm_qla2xxx_queue_data_in(struct se_cmd *se_cmd)
 			cmd->se_cmd.transport_state,
 			cmd->se_cmd.t_state,
 			cmd->se_cmd.se_cmd_flags);
+		vha->hw->tgt.tgt_ops->free_cmd(cmd);
 		return 0;
 	}
 
@@ -659,6 +661,7 @@ static int tcm_qla2xxx_queue_status(struct se_cmd *se_cmd)
 {
 	struct qla_tgt_cmd *cmd = container_of(se_cmd,
 				struct qla_tgt_cmd, se_cmd);
+	struct scsi_qla_host *vha = cmd->vha;
 	int xmit_type = QLA_TGT_XMIT_STATUS;
 
 	if (cmd->aborted) {
@@ -672,6 +675,7 @@ static int tcm_qla2xxx_queue_status(struct se_cmd *se_cmd)
 		    cmd, kref_read(&cmd->se_cmd.cmd_kref),
 		    cmd->se_cmd.transport_state, cmd->se_cmd.t_state,
 		    cmd->se_cmd.se_cmd_flags);
+		vha->hw->tgt.tgt_ops->free_cmd(cmd);
 		return 0;
 	}
 	cmd->bufflen = se_cmd->data_length;
-- 
2.22.0.770.g0f2c4a37fd-goog

