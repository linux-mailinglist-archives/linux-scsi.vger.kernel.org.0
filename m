Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C005E665D8
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 06:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfGLEo2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 00:44:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52210 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729407AbfGLEo1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Jul 2019 00:44:27 -0400
X-UUID: 1839d0dd11714fcc927a218b4654d3dc-20190712
X-UUID: 1839d0dd11714fcc927a218b4654d3dc-20190712
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1647407647; Fri, 12 Jul 2019 12:44:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Jul 2019 12:44:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 12:44:18 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <evgreen@chromium.org>, <beanhuo@micron.com>,
        <marc.w.gonzalez@free.fr>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 2/2] scsi: ufs: Fix broken hba->outstanding_tasks
Date:   Fri, 12 Jul 2019 12:44:16 +0800
Message-ID: <1562906656-27154-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
References: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently bits in hba->outstanding_tasks are cleared only after their
corresponding task management commands are successfully done by
__ufshcd_issue_tm_cmd().

If timeout happens in a task management command, its corresponding
bit in hba->outstanding_tasks will not be cleared until next task
management command with the same tag used successfully finishes.‧

This is wrong and can lead to some issues, like power consumpton issue.
For example, ufshcd_release() and ufshcd_gate_work() will do nothing
if hba->outstanding_tasks is not zero even if both UFS host and devices
are actually idle.

Because error handling flow, i.e., ufshcd_reset_and_restore(), will be
triggered after any task management command times out, we fix this by
clearing corresponding hba->outstanding_tasks bits during this flow.
To achieve this, we need a mask to track timed-out commands and thus
error handling flow can clear their tags specifically.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 38 +++++++++++++++++++++++++++++++-------
 drivers/scsi/ufs/ufshcd.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a667dbb547f2..f780066edf26 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -731,7 +731,6 @@ static inline void ufshcd_outstanding_req_clear(struct ufs_hba *hba, int tag)
 static inline void ufshcd_outstanding_task_clear(struct ufs_hba *hba, int tag)
 {
 	__clear_bit(tag, &hba->outstanding_tasks);
-	dev_info(hba->dev, "clear outstanding_tasks: %d\n", tag);
 }
 
 /**
@@ -5540,11 +5539,34 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
  */
 static void ufshcd_tmc_handler(struct ufs_hba *hba)
 {
-	u32 tm_doorbell;
+	u32 tm_doorbell, tag;
+	unsigned long tm_err_handled = 0;
+	unsigned long tm_done;
 
 	tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
 	hba->tm_condition = tm_doorbell ^ hba->outstanding_tasks;
-	wake_up(&hba->tm_wq);
+	tm_done = hba->tm_condition;
+
+	/* clean resources for timed-out tasks */
+	for_each_set_bit(tag, &hba->tm_condition, hba->nutmrs) {
+		if (test_and_clear_bit(tag, &hba->tm_slots_err)) {
+			clear_bit(tag, &hba->tm_condition);
+			ufshcd_put_tm_slot(hba, tag);
+			ufshcd_outstanding_task_clear(hba, tag);
+			__set_bit(tag, &tm_err_handled);
+		}
+	}
+
+	/*
+	 * Now tag waiters can get free tags if tags were occupied
+	 * by timed-out tasks
+	 */
+	if (tm_err_handled)
+		wake_up(&hba->tm_tag_wq);
+
+	/* if we have normal tasks, they shall have post-processing */
+	if (tm_err_handled != tm_done)
+		wake_up(&hba->tm_wq);
 }
 
 /**
@@ -5682,6 +5704,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		if (ufshcd_clear_tm_cmd(hba, free_slot))
 			dev_WARN(hba->dev, "%s: unable clear tm cmd (slot %d) after timeout\n",
 					__func__, free_slot);
+		set_bit(free_slot, &hba->tm_slots_err);
 		err = -ETIMEDOUT;
 	} else {
 		err = 0;
@@ -5692,12 +5715,13 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		spin_lock_irqsave(hba->host->host_lock, flags);
 		ufshcd_outstanding_task_clear(hba, free_slot);
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
-
 	}
 
-	clear_bit(free_slot, &hba->tm_condition);
-	ufshcd_put_tm_slot(hba, free_slot);
-	wake_up(&hba->tm_tag_wq);
+	if (!(test_bit(free_slot, &hba->tm_slots_err))) {
+		clear_bit(free_slot, &hba->tm_condition);
+		ufshcd_put_tm_slot(hba, free_slot);
+		wake_up(&hba->tm_tag_wq);
+	}
 
 	ufshcd_release(hba);
 	return err;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index a43c7135f33d..4e4dfa6e233c 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -645,6 +645,7 @@ struct ufs_hba {
 	wait_queue_head_t tm_tag_wq;
 	unsigned long tm_condition;
 	unsigned long tm_slots_in_use;
+	unsigned long tm_slots_err;
 
 	struct uic_command *active_uic_cmd;
 	struct mutex uic_cmd_mutex;
-- 
2.18.0

