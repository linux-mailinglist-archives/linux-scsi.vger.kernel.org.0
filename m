Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA11632381C
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Feb 2021 08:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBXHyF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Feb 2021 02:54:05 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33370 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhBXHyB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Feb 2021 02:54:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UPRToA5_1614153194;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPRToA5_1614153194)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 15:53:18 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: remove unneeded semicolon
Date:   Wed, 24 Feb 2021 15:53:12 +0800
Message-Id: <1614153192-109283-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/aha1542.c:300:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/aha1542.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index 21aab9f..5e68982 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -297,7 +297,7 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev_id)
 		if (flag & SCRD)
 			printk("SCRD ");
 		printk("status %02x\n", inb(STATUS(sh->io_port)));
-	};
+	}
 #endif
 	number_serviced = 0;
 
@@ -339,7 +339,7 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev_id)
 			if (!number_serviced)
 				shost_printk(KERN_WARNING, sh, "interrupt received, but no mail.\n");
 			return IRQ_HANDLED;
-		};
+		}
 
 		mbo = (scsi2int(mb[mbi].ccbptr) - (unsigned long)aha1542->ccb_handle) / sizeof(struct ccb);
 		mbistatus = mb[mbi].status;
-- 
1.8.3.1

