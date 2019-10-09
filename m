Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6473D16AB
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Oct 2019 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbfJIRX7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Oct 2019 13:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfJIRX5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Oct 2019 13:23:57 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556E621D56;
        Wed,  9 Oct 2019 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641836;
        bh=Ap0R0u+BPYY+mMHbAVes4DfMCXhd8ei/7HF44I4neFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+yIvg26n/3+yCNSZ5ZxeCHnHFAGWumJR0O2ohQWFun9cZ/gEtFgouY6IW79cmNlN
         Y2Syv0fDm28UMqy8g6L6rZ298c0MVa95ISC4aZ4174jS3ctWIvRoiY37OzzNKcG8E7
         s316N5UxskdVThH4uhsIfEpOPRKNm2pV7zFwmTcw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 11/68] scsi: qla2xxx: Fix stale mem access on driver unload
Date:   Wed,  9 Oct 2019 13:04:50 -0400
Message-Id: <20191009170547.32204-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit fd5564ba54e0d8a9e3e823d311b764232e09eb5f ]

On driver unload, 'remove_one' thread was allowed to advance, while session
cleanup still lag behind.  This patch ensures session deletion will finish
before remove_one can advance.

Link: https://lore.kernel.org/r/20190912180918.6436-4-hmadhani@marvell.com
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c     |  1 +
 drivers/scsi/qla2xxx/qla_target.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 4fda308c3ef5c..084e39e415ff5 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1153,6 +1153,7 @@ qla2x00_wait_for_sess_deletion(scsi_qla_host_t *vha)
 	qla2x00_mark_all_devices_lost(vha, 0);
 
 	wait_event_timeout(vha->fcport_waitQ, test_fcport_count(vha), 10*HZ);
+	flush_workqueue(vha->hw->wq);
 }
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index f77baf107024f..1bb0fc9324ead 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -954,7 +954,7 @@ void qlt_free_session_done(struct work_struct *work)
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
 	bool logout_started = false;
-	scsi_qla_host_t *base_vha;
+	scsi_qla_host_t *base_vha = pci_get_drvdata(ha->pdev);
 	struct qlt_plogi_ack_t *own =
 		sess->plogi_link[QLT_PLOGI_LINK_SAME_WWN];
 
@@ -1106,6 +1106,7 @@ void qlt_free_session_done(struct work_struct *work)
 	}
 
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+	sess->free_pending = 0;
 
 	ql_dbg(ql_dbg_tgt_mgt, vha, 0xf001,
 	    "Unregistration of sess %p %8phC finished fcp_cnt %d\n",
@@ -1114,17 +1115,8 @@ void qlt_free_session_done(struct work_struct *work)
 	if (tgt && (tgt->sess_count == 0))
 		wake_up_all(&tgt->waitQ);
 
-	if (vha->fcport_count == 0)
-		wake_up_all(&vha->fcport_waitQ);
-
-	base_vha = pci_get_drvdata(ha->pdev);
-
-	sess->free_pending = 0;
-
-	if (test_bit(PFLG_DRIVER_REMOVING, &base_vha->pci_flags))
-		return;
-
-	if ((!tgt || !tgt->tgt_stop) && !LOOP_TRANSITION(vha)) {
+	if (!test_bit(PFLG_DRIVER_REMOVING, &base_vha->pci_flags) &&
+	    (!tgt || !tgt->tgt_stop) && !LOOP_TRANSITION(vha)) {
 		switch (vha->host->active_mode) {
 		case MODE_INITIATOR:
 		case MODE_DUAL:
@@ -1137,6 +1129,9 @@ void qlt_free_session_done(struct work_struct *work)
 			break;
 		}
 	}
+
+	if (vha->fcport_count == 0)
+		wake_up_all(&vha->fcport_waitQ);
 }
 
 /* ha->tgt.sess_lock supposed to be held on entry */
@@ -1166,7 +1161,7 @@ void qlt_unreg_sess(struct fc_port *sess)
 	sess->last_login_gen = sess->login_gen;
 
 	INIT_WORK(&sess->free_work, qlt_free_session_done);
-	schedule_work(&sess->free_work);
+	queue_work(sess->vha->hw->wq, &sess->free_work);
 }
 EXPORT_SYMBOL(qlt_unreg_sess);
 
-- 
2.20.1

