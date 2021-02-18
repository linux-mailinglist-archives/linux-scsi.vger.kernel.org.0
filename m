Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7431EA0F
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Feb 2021 13:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhBRMwA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Feb 2021 07:52:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51898 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232670AbhBRKRH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Feb 2021 05:17:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UOtb0X6_1613643372;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UOtb0X6_1613643372)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Feb 2021 18:16:20 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: mvumi: Use true and false for bool variable
Date:   Thu, 18 Feb 2021 18:16:11 +0800
Message-Id: <1613643371-122635-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/mvumi.c:69:9-10: WARNING: return of 0/1 in function
'tag_is_empty' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/mvumi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 71b6a1f..7cc1143 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -66,9 +66,9 @@ static void tag_release_one(struct mvumi_hba *mhba, struct mvumi_tag *st,
 static bool tag_is_empty(struct mvumi_tag *st)
 {
 	if (st->top == 0)
-		return 1;
+		return true;
 	else
-		return 0;
+		return false;
 }
 
 static void mvumi_unmap_pci_addr(struct pci_dev *dev, void **addr_array)
-- 
1.8.3.1

