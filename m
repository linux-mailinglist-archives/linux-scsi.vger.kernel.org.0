Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D08940619B
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Sep 2021 02:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhIJAnP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 20:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhIJAUt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Sep 2021 20:20:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EFF4610A3;
        Fri, 10 Sep 2021 00:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233179;
        bh=U2vm5uFwhZPfkvyfGCnDR5B12SB86RWKtOX+OuwR4Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BglMRIYkR0aUHC14qu9PRq1cwhA/KPptrsmE6rrkrB/UosN8OfrZmKK5Ka4get2NG
         PrtP6G1l0b1p9qFwiNzUxdkYTsBZG/edqBu+V2RZvx1x9Q/SmUgElqVGpIUZHH0WuV
         w1JL9qCf0yVrGpABI1/dabjNuE95w7/chNKc6+ek6ou7ymDFfE2TVeHnW8w1Insxev
         SMrY9ryLs+IFSgNAxZhNv5KgzK9pqGBMD2GY2JZHkhIcCX1HDIE8QJSz6GIRmTi23U
         Z+QRtKgzXkVTZcIyin36RO1eV9CIYEh5gbpUgixwBxqYAISY8pfD2wCRgeljKJ41ne
         d7z/5hljCerSg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arun Easi <aeasi@marvell.com>, Nilesh Javali <njavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 55/88] scsi: qla2xxx: Fix hang on NVMe command timeouts
Date:   Thu,  9 Sep 2021 20:17:47 -0400
Message-Id: <20210910001820.174272-55-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001820.174272-1-sashal@kernel.org>
References: <20210910001820.174272-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

[ Upstream commit 2cabf10dbbe380e2ef27a69ce2059bcab7c8b419 ]

The abort callback gets called only when it gets posted to firmware. The
refcounting is done properly in the callback. On internal errors, the
callback is not invoked leading to a hung I/O. Fix this by having separate
error code when command gets returned from firmware.

Link: https://lore.kernel.org/r/20210817051315.2477-9-njavali@marvell.com
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |  3 +++
 drivers/scsi/qla2xxx/qla_init.c |  6 +++---
 drivers/scsi/qla2xxx/qla_mbx.c  |  4 ++--
 drivers/scsi/qla2xxx/qla_nvme.c | 26 +++++++++++++++++---------
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 0cd1f820b111..1d2293a3ed31 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -5052,6 +5052,9 @@ struct secure_flash_update_block_pk {
 #define QLA_BUSY			0x107
 #define QLA_ALREADY_REGISTERED		0x109
 #define QLA_OS_TIMER_EXPIRED		0x10a
+#define QLA_ERR_NO_QPAIR		0x10b
+#define QLA_ERR_NOT_FOUND		0x10c
+#define QLA_ERR_FROM_FW			0x10d
 
 #define NVRAM_DELAY()		udelay(10)
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index bd74ec862832..708bc331edfb 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -158,7 +158,7 @@ int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	sp = qla2xxx_get_qpair_sp(cmd_sp->vha, cmd_sp->qpair, cmd_sp->fcport,
 				  GFP_ATOMIC);
 	if (!sp)
-		return rval;
+		return QLA_MEMORY_ALLOC_FAILED;
 
 	abt_iocb = &sp->u.iocb_cmd;
 	sp->type = SRB_ABT_CMD;
@@ -191,7 +191,7 @@ int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	if (wait) {
 		wait_for_completion(&abt_iocb->u.abt.comp);
 		rval = abt_iocb->u.abt.comp_status == CS_COMPLETE ?
-			QLA_SUCCESS : QLA_FUNCTION_FAILED;
+			QLA_SUCCESS : QLA_ERR_FROM_FW;
 		sp->free(sp);
 	}
 
@@ -1903,7 +1903,7 @@ qla24xx_async_abort_command(srb_t *sp)
 
 	if (handle == req->num_outstanding_cmds) {
 		/* Command not found. */
-		return QLA_FUNCTION_FAILED;
+		return QLA_ERR_NOT_FOUND;
 	}
 	if (sp->type == SRB_FXIOCB_DCMD)
 		return qlafx00_fx_disc(vha, &vha->hw->mr.fcport,
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 0bcd8afdc0ff..423864b08e10 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3231,7 +3231,7 @@ qla24xx_abort_command(srb_t *sp)
 	if (sp->qpair)
 		req = sp->qpair->req;
 	else
-		return QLA_FUNCTION_FAILED;
+		return QLA_ERR_NO_QPAIR;
 
 	if (ql2xasynctmfenable)
 		return qla24xx_async_abort_command(sp);
@@ -3244,7 +3244,7 @@ qla24xx_abort_command(srb_t *sp)
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 	if (handle == req->num_outstanding_cmds) {
 		/* Command not found. */
-		return QLA_FUNCTION_FAILED;
+		return QLA_ERR_NOT_FOUND;
 	}
 
 	abt = dma_pool_zalloc(ha->s_dma_pool, GFP_KERNEL, &abt_dma);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 955af14e948a..f7b0292b75a5 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -221,11 +221,11 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	srb_t *sp = priv->sp;
 	fc_port_t *fcport = sp->fcport;
 	struct qla_hw_data *ha = fcport->vha->hw;
-	int rval;
+	int rval, abts_done_called = 1;
 
 	ql_dbg(ql_dbg_io, fcport->vha, 0xffff,
-	       "%s called for sp=%p, hndl=%x on fcport=%p deleted=%d\n",
-	       __func__, sp, sp->handle, fcport, fcport->deleted);
+	       "%s called for sp=%p, hndl=%x on fcport=%p desc=%p deleted=%d\n",
+	       __func__, sp, sp->handle, fcport, sp->u.iocb_cmd.u.nvme.desc, fcport->deleted);
 
 	if (!ha->flags.fw_started || fcport->deleted == QLA_SESS_DELETED)
 		goto out;
@@ -245,12 +245,20 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	    __func__, (rval != QLA_SUCCESS) ? "Failed to abort" : "Aborted",
 	    sp, sp->handle, fcport, rval);
 
+	/*
+	 * If async tmf is enabled, the abort callback is called only on
+	 * return codes QLA_SUCCESS and QLA_ERR_FROM_FW.
+	 */
+	if (ql2xasynctmfenable &&
+	    rval != QLA_SUCCESS && rval != QLA_ERR_FROM_FW)
+		abts_done_called = 0;
+
 	/*
 	 * Returned before decreasing kref so that I/O requests
 	 * are waited until ABTS complete. This kref is decreased
 	 * at qla24xx_abort_sp_done function.
 	 */
-	if (ql2xabts_wait_nvme && QLA_ABTS_WAIT_ENABLED(sp))
+	if (abts_done_called && ql2xabts_wait_nvme && QLA_ABTS_WAIT_ENABLED(sp))
 		return;
 out:
 	/* kref_get was done before work was schedule. */
@@ -799,14 +807,14 @@ void qla_nvme_abort_process_comp_status(struct abort_entry_24xx *abt, srb_t *ori
 	case CS_PORT_LOGGED_OUT:
 	/* BA_RJT was received for the ABTS */
 	case CS_PORT_CONFIG_CHG:
-		ql_dbg(ql_dbg_async + ql_dbg_mbx, vha, 0xf09d,
+		ql_dbg(ql_dbg_async, vha, 0xf09d,
 		       "Abort I/O IOCB completed with error, comp_status=%x\n",
 		comp_status);
 		break;
 
 	/* BA_RJT was received for the ABTS */
 	case CS_REJECT_RECEIVED:
-		ql_dbg(ql_dbg_async + ql_dbg_mbx, vha, 0xf09e,
+		ql_dbg(ql_dbg_async, vha, 0xf09e,
 		       "BA_RJT was received for the ABTS rjt_vendorUnique = %u",
 			abt->fw.ba_rjt_vendorUnique);
 		ql_dbg(ql_dbg_async + ql_dbg_mbx, vha, 0xf09e,
@@ -815,18 +823,18 @@ void qla_nvme_abort_process_comp_status(struct abort_entry_24xx *abt, srb_t *ori
 		break;
 
 	case CS_COMPLETE:
-		ql_dbg(ql_dbg_async + ql_dbg_mbx, vha, 0xf09f,
+		ql_dbg(ql_dbg_async + ql_dbg_verbose, vha, 0xf09f,
 		       "IOCB request is completed successfully comp_status=%x\n",
 		comp_status);
 		break;
 
 	case CS_IOCB_ERROR:
-		ql_dbg(ql_dbg_async + ql_dbg_mbx, vha, 0xf0a0,
+		ql_dbg(ql_dbg_async, vha, 0xf0a0,
 		       "IOCB request is failed, comp_status=%x\n", comp_status);
 		break;
 
 	default:
-		ql_dbg(ql_dbg_async + ql_dbg_mbx, vha, 0xf0a1,
+		ql_dbg(ql_dbg_async, vha, 0xf0a1,
 		       "Invalid Abort IO IOCB Completion Status %x\n",
 		comp_status);
 		break;
-- 
2.30.2

