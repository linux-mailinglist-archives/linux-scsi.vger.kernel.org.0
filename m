Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28FF49FA
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2019 13:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbfKHMG3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Nov 2019 07:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389195AbfKHLlR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F75622459;
        Fri,  8 Nov 2019 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213275;
        bh=zuLtBxqoShOEKBcibThSP4Me7FHzULUBCV1I9HlOyVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X35TPaAv4j/ZNNTtK7pk4j+9iJ4rQM/NGL3Uer57rnUrCmNEpZpbEIxI6LS9eocQp
         QnLWEZqE321rLkLuU6DAjUZS9ThF458ylSNc+mwvo00n2Ml/LyjxBqtdFsLYR4Gt2v
         rH1u0Azx3R43vFTS6cSSVZcqXn2dkxCkf7FIvihI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 137/205] scsi: qla2xxx: Use correct qpair for ABTS/CMD
Date:   Fri,  8 Nov 2019 06:36:44 -0500
Message-Id: <20191108113752.12502-137-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 49cecca7dd49e2950ed6d973acfa84e7c8c7a480 ]

On Abort of initiator scsi command, the abort needs to follow the same qpair
as the the scsi command to prevent out of order processing.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 15 +++++----------
 drivers/scsi/qla2xxx/qla_iocb.c | 12 +++++++-----
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index bee9cfb291529..e5ecef94aebdb 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1772,18 +1772,18 @@ int
 qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 {
 	scsi_qla_host_t *vha = cmd_sp->vha;
-	fc_port_t *fcport = cmd_sp->fcport;
 	struct srb_iocb *abt_iocb;
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
 
-	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
+	sp = qla2xxx_get_qpair_sp(cmd_sp->qpair, cmd_sp->fcport, GFP_KERNEL);
 	if (!sp)
 		goto done;
 
 	abt_iocb = &sp->u.iocb_cmd;
 	sp->type = SRB_ABT_CMD;
 	sp->name = "abort";
+	sp->qpair = cmd_sp->qpair;
 	if (wait)
 		sp->flags = SRB_WAKEUP_ON_COMP;
 
@@ -1792,18 +1792,13 @@ qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha));
 
 	abt_iocb->u.abt.cmd_hndl = cmd_sp->handle;
-
-	if (vha->flags.qpairs_available && cmd_sp->qpair)
-		abt_iocb->u.abt.req_que_no =
-		    cpu_to_le16(cmd_sp->qpair->req->id);
-	else
-		abt_iocb->u.abt.req_que_no = cpu_to_le16(vha->req->id);
+	abt_iocb->u.abt.req_que_no = cpu_to_le16(cmd_sp->qpair->req->id);
 
 	sp->done = qla24xx_abort_sp_done;
 
 	ql_dbg(ql_dbg_async, vha, 0x507c,
-	    "Abort command issued - hdl=%x, target_id=%x\n",
-	    cmd_sp->handle, fcport->tgt_id);
+	    "Abort command issued - hdl=%x, type=%x\n",
+	    cmd_sp->handle, cmd_sp->type);
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS)
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 119927220299e..c699bbb8485bb 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3297,19 +3297,21 @@ qla24xx_abort_iocb(srb_t *sp, struct abort_entry_24xx *abt_iocb)
 {
 	struct srb_iocb *aio = &sp->u.iocb_cmd;
 	scsi_qla_host_t *vha = sp->vha;
-	struct req_que *req = vha->req;
+	struct req_que *req = sp->qpair->req;
 
 	memset(abt_iocb, 0, sizeof(struct abort_entry_24xx));
 	abt_iocb->entry_type = ABORT_IOCB_TYPE;
 	abt_iocb->entry_count = 1;
 	abt_iocb->handle = cpu_to_le32(MAKE_HANDLE(req->id, sp->handle));
-	abt_iocb->nport_handle = cpu_to_le16(sp->fcport->loop_id);
+	if (sp->fcport) {
+		abt_iocb->nport_handle = cpu_to_le16(sp->fcport->loop_id);
+		abt_iocb->port_id[0] = sp->fcport->d_id.b.al_pa;
+		abt_iocb->port_id[1] = sp->fcport->d_id.b.area;
+		abt_iocb->port_id[2] = sp->fcport->d_id.b.domain;
+	}
 	abt_iocb->handle_to_abort =
 	    cpu_to_le32(MAKE_HANDLE(aio->u.abt.req_que_no,
 				    aio->u.abt.cmd_hndl));
-	abt_iocb->port_id[0] = sp->fcport->d_id.b.al_pa;
-	abt_iocb->port_id[1] = sp->fcport->d_id.b.area;
-	abt_iocb->port_id[2] = sp->fcport->d_id.b.domain;
 	abt_iocb->vp_index = vha->vp_idx;
 	abt_iocb->req_que_no = cpu_to_le16(aio->u.abt.req_que_no);
 	/* Send the command to the firmware */
-- 
2.20.1

