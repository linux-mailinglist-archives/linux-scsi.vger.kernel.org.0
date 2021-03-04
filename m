Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07DA32CC80
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 07:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhCDGOu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Mar 2021 01:14:50 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:35048 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234733AbhCDGOp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Mar 2021 01:14:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UQK2Dg0_1614838438;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UQK2Dg0_1614838438)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Mar 2021 14:14:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] arcmsr: Switch to using the new API kobj_to_dev()
Date:   Thu,  4 Mar 2021 14:13:57 +0800
Message-Id: <1614838437-98814-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/arcmsr/arcmsr_attr.c:164:58-59: WARNING opportunity for
kobj_to_dev().

./drivers/scsi/arcmsr/arcmsr_attr.c:116:58-59: WARNING opportunity for
kobj_to_dev().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/arcmsr/arcmsr_attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index 57be960..e03326e 100644
--- a/drivers/scsi/arcmsr/arcmsr_attr.c
+++ b/drivers/scsi/arcmsr/arcmsr_attr.c
@@ -113,7 +113,7 @@ static ssize_t arcmsr_sysfs_iop_message_write(struct file *filp,
 					      char *buf, loff_t off,
 					      size_t count)
 {
-	struct device *dev = container_of(kobj,struct device,kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb = (struct AdapterControlBlock *) host->hostdata;
 	int32_t user_len, cnt2end;
@@ -161,7 +161,7 @@ static ssize_t arcmsr_sysfs_iop_message_clear(struct file *filp,
 					      char *buf, loff_t off,
 					      size_t count)
 {
-	struct device *dev = container_of(kobj,struct device,kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb = (struct AdapterControlBlock *) host->hostdata;
 	uint8_t *pQbuffer;
-- 
1.8.3.1

