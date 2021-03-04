Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0332CFA9
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbhCDJaG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Mar 2021 04:30:06 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:20470 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237553AbhCDJ3f (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Mar 2021 04:29:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UQMzAus_1614850125;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UQMzAus_1614850125)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Mar 2021 17:28:52 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tyreld@linux.ibm.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: ibmvfc: Switch to using the new API kobj_to_dev()
Date:   Thu,  4 Mar 2021 17:28:44 +0800
Message-Id: <1614850124-54111-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/ibmvscsi/ibmvfc.c:3483:60-61: WARNING opportunity for
kobj_to_dev().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 755313b..e5f1ca7 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3480,7 +3480,7 @@ static ssize_t ibmvfc_read_trace(struct file *filp, struct kobject *kobj,
 				 struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 	unsigned long flags = 0;
-- 
1.8.3.1

