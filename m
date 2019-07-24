Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD44C72790
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfGXFuj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 01:50:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6410 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfGXFuj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Jul 2019 01:50:39 -0400
X-UUID: 1e8e5e4f5f654e0b94068a072d405a64-20190724
X-UUID: 1e8e5e4f5f654e0b94068a072d405a64-20190724
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 75692955; Wed, 24 Jul 2019 13:50:34 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 13:50:26 +0800
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
Subject: [PATCH v2 2/3] scsi: ufs: introduce ufshcd_tm_cmd_compl() to refactor task cleanup
Date:   Wed, 24 Jul 2019 13:50:17 +0800
Message-ID: <1563947418-16394-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1563947418-16394-1-git-send-email-stanley.chu@mediatek.com>
References: <1563947418-16394-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D701BA5A8A78953634D797ACCDCDFF18970D1593BE770D737F9A6BAB1F5FE6532000:8
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce ufshcd_tm_cmd_compl() to re-factor taks cleanup jobs
to make code more readable and for future wider usage by task error
handling.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 66c8e7402001..114c15ed75f7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5522,6 +5522,13 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
 	 */
 }
 
+static void ufshcd_tm_cmd_compl(struct ufs_hba *hba, int tag)
+{
+	__clear_bit(tag, &hba->outstanding_tasks);
+	__clear_bit(tag, &hba->tm_condition);
+	ufshcd_put_tm_slot(hba, tag);
+}
+
 /**
  * ufshcd_tmc_handler - handle task management function completion
  * @hba: per adapter instance
@@ -5687,11 +5694,9 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 
 	if (likely(cleanup)) {
 		spin_lock_irqsave(hba->host->host_lock, flags);
-		__clear_bit(free_slot, &hba->outstanding_tasks);
+		ufshcd_tm_cmd_compl(hba, free_slot);
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 
-		clear_bit(free_slot, &hba->tm_condition);
-		ufshcd_put_tm_slot(hba, free_slot);
 		wake_up(&hba->tm_tag_wq);
 	}
 
-- 
2.18.0

