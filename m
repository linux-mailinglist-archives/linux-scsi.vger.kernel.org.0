Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4515C3123CE
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 12:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBGLkV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 06:40:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12480 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGLkS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 06:40:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYRx03jNFzjKnM;
        Sun,  7 Feb 2021 19:38:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:39:26 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH for-next 05/32] scsi: BusLogic: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:36:36 +0800
Message-ID: <1612697823-8073-6-git-send-email-tanxiaofei@huawei.com>
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
 drivers/scsi/BusLogic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index ccb061a..005809e 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2880,11 +2880,10 @@ static void blogic_process_ccbs(struct blogic_adapter *adapter)
 static irqreturn_t blogic_inthandler(int irq_ch, void *devid)
 {
 	struct blogic_adapter *adapter = (struct blogic_adapter *) devid;
-	unsigned long processor_flag;
 	/*
 	   Acquire exclusive access to Host Adapter.
 	 */
-	spin_lock_irqsave(adapter->scsi_host->host_lock, processor_flag);
+	spin_lock(adapter->scsi_host->host_lock);
 	/*
 	   Handle Interrupts appropriately for each Host Adapter type.
 	 */
@@ -2952,7 +2951,7 @@ static irqreturn_t blogic_inthandler(int irq_ch, void *devid)
 	/*
 	   Release exclusive access to Host Adapter.
 	 */
-	spin_unlock_irqrestore(adapter->scsi_host->host_lock, processor_flag);
+	spin_unlock(adapter->scsi_host->host_lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.8.1

