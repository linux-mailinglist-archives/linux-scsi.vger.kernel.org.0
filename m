Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD343123DB
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhBGLku (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 06:40:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12447 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBGLk1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 06:40:27 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DYRxV0KjWzjJlM;
        Sun,  7 Feb 2021 19:38:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:39:35 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH for-next 24/32] scsi: pmcraid: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:36:55 +0800
Message-ID: <1612697823-8073-25-git-send-email-tanxiaofei@huawei.com>
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
 drivers/scsi/pmcraid.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 834556e..5967284 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4145,7 +4145,6 @@ static irqreturn_t pmcraid_isr_msix(int irq, void *dev_id)
 {
 	struct pmcraid_isr_param *hrrq_vector;
 	struct pmcraid_instance *pinstance;
-	unsigned long lock_flags;
 	u32 intrs_val;
 	int hrrq_id;
 
@@ -4170,12 +4169,9 @@ static irqreturn_t pmcraid_isr_msix(int irq, void *dev_id)
 
 				pmcraid_err("ISR: error interrupts: %x \
 					initiating reset\n", intrs_val);
-				spin_lock_irqsave(pinstance->host->host_lock,
-					lock_flags);
+				spin_lock(pinstance->host->host_lock);
 				pmcraid_initiate_reset(pinstance);
-				spin_unlock_irqrestore(
-					pinstance->host->host_lock,
-					lock_flags);
+				spin_unlock(pinstance->host->host_lock);
 			}
 			/* If interrupt was as part of the ioa initialization,
 			 * clear it. Delete the timer and wakeup the
-- 
2.8.1

