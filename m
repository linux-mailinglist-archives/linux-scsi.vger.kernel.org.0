Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DB3123CF
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 12:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGLkZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 06:40:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12481 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGLkT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 06:40:19 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYRx0317czjKVY;
        Sun,  7 Feb 2021 19:38:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:39:27 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH for-next 07/32] scsi: a2091: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:36:38 +0800
Message-ID: <1612697823-8073-8-git-send-email-tanxiaofei@huawei.com>
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
 drivers/scsi/a2091.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/a2091.c b/drivers/scsi/a2091.c
index 5853db3..5b23602 100644
--- a/drivers/scsi/a2091.c
+++ b/drivers/scsi/a2091.c
@@ -27,14 +27,13 @@ static irqreturn_t a2091_intr(int irq, void *data)
 	struct Scsi_Host *instance = data;
 	struct a2091_hostdata *hdata = shost_priv(instance);
 	unsigned int status = hdata->regs->ISTR;
-	unsigned long flags;
 
 	if (!(status & (ISTR_INT_F | ISTR_INT_P)) || !(status & ISTR_INTS))
 		return IRQ_NONE;
 
-	spin_lock_irqsave(instance->host_lock, flags);
+	spin_lock(instance->host_lock);
 	wd33c93_intr(instance);
-	spin_unlock_irqrestore(instance->host_lock, flags);
+	spin_unlock(instance->host_lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.8.1

