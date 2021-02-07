Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85943123EB
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 12:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBGLnA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 06:43:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12091 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhBGLlJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 06:41:09 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYRwg5m1FzMWS6;
        Sun,  7 Feb 2021 19:37:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:39:30 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH for-next 12/32] scsi: gvp11: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:36:43 +0800
Message-ID: <1612697823-8073-13-git-send-email-tanxiaofei@huawei.com>
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
 drivers/scsi/gvp11.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/gvp11.c b/drivers/scsi/gvp11.c
index 727f8c8..f164a68 100644
--- a/drivers/scsi/gvp11.c
+++ b/drivers/scsi/gvp11.c
@@ -29,14 +29,13 @@ static irqreturn_t gvp11_intr(int irq, void *data)
 	struct Scsi_Host *instance = data;
 	struct gvp11_hostdata *hdata = shost_priv(instance);
 	unsigned int status = hdata->regs->CNTR;
-	unsigned long flags;
 
 	if (!(status & GVP11_DMAC_INT_PENDING))
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

