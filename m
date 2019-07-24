Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6C7278D
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 07:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfGXFua (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 01:50:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56498 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfGXFua (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Jul 2019 01:50:30 -0400
X-UUID: 8b9ef7c430ba4bd5a03df294ec5da49c-20190724
X-UUID: 8b9ef7c430ba4bd5a03df294ec5da49c-20190724
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 667413503; Wed, 24 Jul 2019 13:50:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 13:50:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 13:50:20 +0800
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
Subject: [PATCH v2 1/3] scsi: ufs: clean-up task resource immediately only if task is responded
Date:   Wed, 24 Jul 2019 13:50:16 +0800
Message-ID: <1563947418-16394-2-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1563947418-16394-1-git-send-email-stanley.chu@mediatek.com>
References: <1563947418-16394-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In __ufshcd_issue_tm_cmd(), if host is unable to clear TM command by
setting "clear register", the TM command may be still "outstanding"
in the device. In this case, it may be better to do cleanup after reset
is done. Therefore let __ufshcd_issue_tm_cmd() clean-up task resource
immediately only if task is responded.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3804a704e565..66c8e7402001 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5628,6 +5628,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 	struct Scsi_Host *host = hba->host;
 	unsigned long flags;
 	int free_slot, task_tag, err;
+	bool cleanup = true;
 
 	/*
 	 * Get free slot, sleep if slots are unavailable.
@@ -5667,26 +5668,33 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete_err");
 		dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
 				__func__, tm_function);
-		if (ufshcd_clear_tm_cmd(hba, free_slot))
+		if (ufshcd_clear_tm_cmd(hba, free_slot)) {
 			dev_WARN(hba->dev, "%s: unable clear tm cmd (slot %d) after timeout\n",
 					__func__, free_slot);
+			/*
+			 * unable to clear task, cleanup shall be done
+			 * during error handling
+			 */
+			cleanup = false;
+		}
 		err = -ETIMEDOUT;
 	} else {
 		err = 0;
 		memcpy(treq, hba->utmrdl_base_addr + free_slot, sizeof(*treq));
 
 		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete");
+	}
 
+	if (likely(cleanup)) {
 		spin_lock_irqsave(hba->host->host_lock, flags);
 		__clear_bit(free_slot, &hba->outstanding_tasks);
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 
+		clear_bit(free_slot, &hba->tm_condition);
+		ufshcd_put_tm_slot(hba, free_slot);
+		wake_up(&hba->tm_tag_wq);
 	}
 
-	clear_bit(free_slot, &hba->tm_condition);
-	ufshcd_put_tm_slot(hba, free_slot);
-	wake_up(&hba->tm_tag_wq);
-
 	ufshcd_release(hba);
 	return err;
 }
-- 
2.18.0

