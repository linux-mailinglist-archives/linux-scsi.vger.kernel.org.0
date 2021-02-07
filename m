Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3FA3123E0
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 12:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBGLlL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 06:41:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11696 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBGLkf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 06:40:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DYRwt0SFszlHCX;
        Sun,  7 Feb 2021 19:38:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:39:38 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH for-next 32/32] scsi: advansys: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:37:03 +0800
Message-ID: <1612697823-8073-33-git-send-email-tanxiaofei@huawei.com>
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
 drivers/scsi/advansys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index ec56278..a80f5e2 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -7177,10 +7177,9 @@ static irqreturn_t advansys_interrupt(int irq, void *dev_id)
 	struct Scsi_Host *shost = dev_id;
 	struct asc_board *boardp = shost_priv(shost);
 	irqreturn_t result = IRQ_NONE;
-	unsigned long flags;
 
 	ASC_DBG(2, "boardp 0x%p\n", boardp);
-	spin_lock_irqsave(shost->host_lock, flags);
+	spin_lock(shost->host_lock);
 	if (ASC_NARROW_BOARD(boardp)) {
 		if (AscIsIntPending(shost->io_port)) {
 			result = IRQ_HANDLED;
@@ -7195,7 +7194,7 @@ static irqreturn_t advansys_interrupt(int irq, void *dev_id)
 			ASC_STATS(shost, interrupt);
 		}
 	}
-	spin_unlock_irqrestore(shost->host_lock, flags);
+	spin_unlock(shost->host_lock);
 
 	ASC_DBG(1, "end\n");
 	return result;
-- 
2.8.1

