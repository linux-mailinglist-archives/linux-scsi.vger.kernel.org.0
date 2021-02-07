Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B496C3123DD
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Feb 2021 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBGLkz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Feb 2021 06:40:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12449 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBGLk1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Feb 2021 06:40:27 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DYRxV0rpyzjJlj;
        Sun,  7 Feb 2021 19:38:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:39:34 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH for-next 22/32] scsi: ncr53c8xx: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:36:53 +0800
Message-ID: <1612697823-8073-23-git-send-email-tanxiaofei@huawei.com>
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
 drivers/scsi/ncr53c8xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index c76e9f0..84e0bb6 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -8069,7 +8069,6 @@ static DEF_SCSI_QCMD(ncr53c8xx_queue_command)
 
 irqreturn_t ncr53c8xx_intr(int irq, void *dev_id)
 {
-     unsigned long flags;
      struct Scsi_Host *shost = (struct Scsi_Host *)dev_id;
      struct host_data *host_data = (struct host_data *)shost->hostdata;
      struct ncb *np = host_data->ncb;
@@ -8081,11 +8080,11 @@ irqreturn_t ncr53c8xx_intr(int irq, void *dev_id)
 
      if (DEBUG_FLAGS & DEBUG_TINY) printk ("[");
 
-     spin_lock_irqsave(&np->smp_lock, flags);
+	spin_lock(&np->smp_lock);
      ncr_exception(np);
      done_list     = np->done_list;
      np->done_list = NULL;
-     spin_unlock_irqrestore(&np->smp_lock, flags);
+	spin_unlock(&np->smp_lock);
 
      if (DEBUG_FLAGS & DEBUG_TINY) printk ("]\n");
 
-- 
2.8.1

