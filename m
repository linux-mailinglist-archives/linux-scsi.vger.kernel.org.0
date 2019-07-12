Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8E665DA
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 06:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfGLEo3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 00:44:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40737 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726610AbfGLEo3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Jul 2019 00:44:29 -0400
X-UUID: 8068812d9f2549b4b8cb8dce42c8fd7d-20190712
X-UUID: 8068812d9f2549b4b8cb8dce42c8fd7d-20190712
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 860509783; Fri, 12 Jul 2019 12:44:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Jul 2019 12:44:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 12:44:17 +0800
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
Subject: [PATCH v1 1/2] scsi: ufs: Make new function for clearing outstanding task bits
Date:   Fri, 12 Jul 2019 12:44:15 +0800
Message-ID: <1562906656-27154-2-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
References: <1562906656-27154-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make a new function "ufshcd_outstanding_task_clear()" used to
clear bits in hba->outstanding_tasks for future wider usage.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8f0426a36b0b..a667dbb547f2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -723,6 +723,17 @@ static inline void ufshcd_outstanding_req_clear(struct ufs_hba *hba, int tag)
 	__clear_bit(tag, &hba->outstanding_reqs);
 }
 
+/**
+ * ufshcd_outstanding_task_clear - Clear a bit in outstanding task field
+ * @hba: per adapter instance
+ * @tag: position of the bit to be cleared
+ */
+static inline void ufshcd_outstanding_task_clear(struct ufs_hba *hba, int tag)
+{
+	__clear_bit(tag, &hba->outstanding_tasks);
+	dev_info(hba->dev, "clear outstanding_tasks: %d\n", tag);
+}
+
 /**
  * ufshcd_get_lists_status - Check UCRDY, UTRLRDY and UTMRLRDY
  * @reg: Register value of host controller status
@@ -5679,7 +5690,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete");
 
 		spin_lock_irqsave(hba->host->host_lock, flags);
-		__clear_bit(free_slot, &hba->outstanding_tasks);
+		ufshcd_outstanding_task_clear(hba, free_slot);
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	}
-- 
2.18.0

