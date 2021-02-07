Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2007C3123F5
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 12:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhBGLn5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 06:43:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12454 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBGLlV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 06:41:21 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DYRxV26cvzjJmM;
        Sun,  7 Feb 2021 19:38:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:39:34 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH for-next 21/32] scsi: myrs: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:36:52 +0800
Message-ID: <1612697823-8073-22-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612697823-8073-1-git-send-email-tanxiaofei@huawei.com>
References: <1612697823-8073-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It is redundant to do irqsave and irqrestore in hardIRQ context, where
it has been in a irq-disabled context.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/scsi/myrs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 4adf9de..59379fc 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -2615,9 +2615,8 @@ static irqreturn_t DAC960_GEM_intr_handler(int irq, void *arg)
 	struct myrs_hba *cs = arg;
 	void __iomem *base = cs->io_base;
 	struct myrs_stat_mbox *next_stat_mbox;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cs->queue_lock, flags);
+	spin_lock(&cs->queue_lock);
 	DAC960_GEM_ack_intr(base);
 	next_stat_mbox = cs->next_stat_mbox;
 	while (next_stat_mbox->id > 0) {
@@ -2654,7 +2653,7 @@ static irqreturn_t DAC960_GEM_intr_handler(int irq, void *arg)
 		}
 	}
 	cs->next_stat_mbox = next_stat_mbox;
-	spin_unlock_irqrestore(&cs->queue_lock, flags);
+	spin_unlock(&cs->queue_lock);
 	return IRQ_HANDLED;
 }
 
@@ -2865,9 +2864,8 @@ static irqreturn_t DAC960_BA_intr_handler(int irq, void *arg)
 	struct myrs_hba *cs = arg;
 	void __iomem *base = cs->io_base;
 	struct myrs_stat_mbox *next_stat_mbox;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cs->queue_lock, flags);
+	spin_lock(&cs->queue_lock);
 	DAC960_BA_ack_intr(base);
 	next_stat_mbox = cs->next_stat_mbox;
 	while (next_stat_mbox->id > 0) {
@@ -2904,7 +2902,7 @@ static irqreturn_t DAC960_BA_intr_handler(int irq, void *arg)
 		}
 	}
 	cs->next_stat_mbox = next_stat_mbox;
-	spin_unlock_irqrestore(&cs->queue_lock, flags);
+	spin_unlock(&cs->queue_lock);
 	return IRQ_HANDLED;
 }
 
@@ -3115,9 +3113,8 @@ static irqreturn_t DAC960_LP_intr_handler(int irq, void *arg)
 	struct myrs_hba *cs = arg;
 	void __iomem *base = cs->io_base;
 	struct myrs_stat_mbox *next_stat_mbox;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cs->queue_lock, flags);
+	spin_lock(&cs->queue_lock);
 	DAC960_LP_ack_intr(base);
 	next_stat_mbox = cs->next_stat_mbox;
 	while (next_stat_mbox->id > 0) {
@@ -3154,7 +3151,7 @@ static irqreturn_t DAC960_LP_intr_handler(int irq, void *arg)
 		}
 	}
 	cs->next_stat_mbox = next_stat_mbox;
-	spin_unlock_irqrestore(&cs->queue_lock, flags);
+	spin_unlock(&cs->queue_lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.8.1

