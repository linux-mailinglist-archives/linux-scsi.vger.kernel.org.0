Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4335B7AC84D
	for <lists+linux-scsi@lfdr.de>; Sun, 24 Sep 2023 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIXNQD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Sep 2023 09:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjIXNQB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 24 Sep 2023 09:16:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31552112;
        Sun, 24 Sep 2023 06:15:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4F2C433C9;
        Sun, 24 Sep 2023 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561348;
        bh=e7wyZIRClwx6QhrA542JsvhuuvAQutUANRmOL4kP9x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJmOslMrOWKG+O7K7ao3dwSdofJ5/unTC9PFFGXGUBoaXX3AWXH21Cn3u1vgvILdI
         2MzVorzqLAUwQKsxtFevQkBMx/KNEQji8+HG2nFHOdf5KIFWL/RVTsEQlImymBLq7r
         4PEXoT0YaZDRlh76FqfBnHePqasnq07KLkE73zxZur+epnUdFl3qnlQ9A2SWEii6tA
         qCxlUUTTQgS//5zIjp80t2zzfqspjE3fippt5Iv+ZNujzR/j5YhVREUV44wbqbvqyk
         iAMD34wA0x4WOeOgmsf9e9j1h+PyQrD+wX5BG+JDmt9OYtYywZaVvt/GQOiVFGrElQ
         xr3HNQkpHmSNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Javed Hasan <jhasan@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 08/41] scsi: qedf: Add synchronization between I/O completions and abort
Date:   Sun, 24 Sep 2023 09:14:56 -0400
Message-Id: <20230924131529.1275335-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit 7df0b2605489bef3f4223ad66f1f9bb8d50d4cd2 ]

Avoid race condition between I/O completion and abort processing by
protecting the cmd_type with the rport lock.

Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Link: https://lore.kernel.org/r/20230901060646.27885-1-skashyap@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedf/qedf_io.c   | 10 ++++++++--
 drivers/scsi/qedf/qedf_main.c |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 4750ec5789a80..10fe3383855c0 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -1904,6 +1904,7 @@ int qedf_initiate_abts(struct qedf_ioreq *io_req, bool return_scsi_cmd_on_abts)
 		goto drop_rdata_kref;
 	}
 
+	spin_lock_irqsave(&fcport->rport_lock, flags);
 	if (!test_bit(QEDF_CMD_OUTSTANDING, &io_req->flags) ||
 	    test_bit(QEDF_CMD_IN_CLEANUP, &io_req->flags) ||
 	    test_bit(QEDF_CMD_IN_ABORT, &io_req->flags)) {
@@ -1911,17 +1912,20 @@ int qedf_initiate_abts(struct qedf_ioreq *io_req, bool return_scsi_cmd_on_abts)
 			 "io_req xid=0x%x sc_cmd=%p already in cleanup or abort processing or already completed.\n",
 			 io_req->xid, io_req->sc_cmd);
 		rc = 1;
+		spin_unlock_irqrestore(&fcport->rport_lock, flags);
 		goto drop_rdata_kref;
 	}
 
+	/* Set the command type to abort */
+	io_req->cmd_type = QEDF_ABTS;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
+
 	kref_get(&io_req->refcount);
 
 	xid = io_req->xid;
 	qedf->control_requests++;
 	qedf->packet_aborts++;
 
-	/* Set the command type to abort */
-	io_req->cmd_type = QEDF_ABTS;
 	io_req->return_scsi_cmd_on_abts = return_scsi_cmd_on_abts;
 
 	set_bit(QEDF_CMD_IN_ABORT, &io_req->flags);
@@ -2210,7 +2214,9 @@ int qedf_initiate_cleanup(struct qedf_ioreq *io_req,
 		  refcount, fcport, fcport->rdata->ids.port_id);
 
 	/* Cleanup cmds re-use the same TID as the original I/O */
+	spin_lock_irqsave(&fcport->rport_lock, flags);
 	io_req->cmd_type = QEDF_CLEANUP;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
 	io_req->return_scsi_cmd_on_abts = return_scsi_cmd_on_abts;
 
 	init_completion(&io_req->cleanup_done);
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 7825765c936cd..91f3f1d7098eb 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -2805,6 +2805,8 @@ void qedf_process_cqe(struct qedf_ctx *qedf, struct fcoe_cqe *cqe)
 	struct qedf_ioreq *io_req;
 	struct qedf_rport *fcport;
 	u32 comp_type;
+	u8 io_comp_type;
+	unsigned long flags;
 
 	comp_type = (cqe->cqe_data >> FCOE_CQE_CQE_TYPE_SHIFT) &
 	    FCOE_CQE_CQE_TYPE_MASK;
@@ -2838,11 +2840,14 @@ void qedf_process_cqe(struct qedf_ctx *qedf, struct fcoe_cqe *cqe)
 		return;
 	}
 
+	spin_lock_irqsave(&fcport->rport_lock, flags);
+	io_comp_type = io_req->cmd_type;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
 
 	switch (comp_type) {
 	case FCOE_GOOD_COMPLETION_CQE_TYPE:
 		atomic_inc(&fcport->free_sqes);
-		switch (io_req->cmd_type) {
+		switch (io_comp_type) {
 		case QEDF_SCSI_CMD:
 			qedf_scsi_completion(qedf, cqe, io_req);
 			break;
-- 
2.40.1

