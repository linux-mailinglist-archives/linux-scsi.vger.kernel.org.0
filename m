Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC63F291CDE
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Oct 2020 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgJRTXx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 18 Oct 2020 15:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbgJRTXw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 18 Oct 2020 15:23:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F515222EB;
        Sun, 18 Oct 2020 19:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049032;
        bh=XNBNPHCWavZrEu5SlajFZldWJA/rSGH/UWI9X1BQniU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGO2jBEJxoBsIri+pI/P7RjgsIjy8CR6wnpxCaoqSwFn22/Kf7LywUme4Y7x87UYJ
         3MqlemsM3e5gVkkClXh94vRrOSVeSnRUZ5IQ7MeeluO/s+0r8v4aZzSBUqh34DIdhL
         HEc6wqcqaEyJu8PIMbDocxHPwFEa7YZxELiiVki0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 64/80] scsi: qedi: Fix list_del corruption while removing active I/O
Date:   Sun, 18 Oct 2020 15:22:15 -0400
Message-Id: <20201018192231.4054535-64-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192231.4054535-1-sashal@kernel.org>
References: <20201018192231.4054535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 28b35d17f9f8573d4646dd8df08917a4076a6b63 ]

While aborting the I/O, the firmware cleanup task timed out and driver
deleted the I/O from active command list. Some time later the firmware
sent the cleanup task response and driver again deleted the I/O from
active command list causing firmware to send completion for non-existent
I/O and list_del corruption of active command list.

Add fix to check if I/O is present before deleting it from the active
command list to ensure firmware sends valid I/O completion and protect
against list_del corruption.

Link: https://lore.kernel.org/r/20200908095657.26821-4-mrangankar@marvell.com
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_fw.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 32586800620bd..90aa64604ad78 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -825,8 +825,11 @@ static void qedi_process_cmd_cleanup_resp(struct qedi_ctx *qedi,
 			qedi_clear_task_idx(qedi_conn->qedi, rtid);
 
 			spin_lock(&qedi_conn->list_lock);
-			list_del_init(&dbg_cmd->io_cmd);
-			qedi_conn->active_cmd_count--;
+			if (likely(dbg_cmd->io_cmd_in_list)) {
+				dbg_cmd->io_cmd_in_list = false;
+				list_del_init(&dbg_cmd->io_cmd);
+				qedi_conn->active_cmd_count--;
+			}
 			spin_unlock(&qedi_conn->list_lock);
 			qedi_cmd->state = CLEANUP_RECV;
 			wake_up_interruptible(&qedi_conn->wait_queue);
@@ -1244,6 +1247,7 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 		qedi_conn->cmd_cleanup_req++;
 		qedi_iscsi_cleanup_task(ctask, true);
 
+		cmd->io_cmd_in_list = false;
 		list_del_init(&cmd->io_cmd);
 		qedi_conn->active_cmd_count--;
 		QEDI_WARN(&qedi->dbg_ctx,
@@ -1455,8 +1459,11 @@ static void qedi_tmf_work(struct work_struct *work)
 	spin_unlock_bh(&qedi_conn->tmf_work_lock);
 
 	spin_lock(&qedi_conn->list_lock);
-	list_del_init(&cmd->io_cmd);
-	qedi_conn->active_cmd_count--;
+	if (likely(cmd->io_cmd_in_list)) {
+		cmd->io_cmd_in_list = false;
+		list_del_init(&cmd->io_cmd);
+		qedi_conn->active_cmd_count--;
+	}
 	spin_unlock(&qedi_conn->list_lock);
 
 	clear_bit(QEDI_CONN_FW_CLEANUP, &qedi_conn->flags);
-- 
2.25.1

