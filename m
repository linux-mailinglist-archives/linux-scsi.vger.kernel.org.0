Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5B1B3531
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2020 04:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgDVCvN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 Apr 2020 22:51:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2829 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbgDVCvN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 21 Apr 2020 22:51:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5EDFA9E2B7CFECE1E29E;
        Wed, 22 Apr 2020 10:51:11 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Apr 2020 10:51:01 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] scsi: aacraid: Use memdup_user() as a cleanup
Date:   Wed, 22 Apr 2020 10:57:12 +0800
Message-ID: <1587524232-118733-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix coccicheck warning which recommends to use memdup_user().

This patch fixes the following coccicheck warnings:

drivers/scsi/aacraid/commctrl.c:516:15-22: WARNING opportunity for memdup_user

Fixes: 4645df1035b3 ("[PATCH] aacraid: swapped kmalloc args.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/scsi/aacraid/commctrl.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index ffe41bc..1ce1620 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -513,17 +513,9 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		goto cleanup;
 	}
 
-	user_srbcmd = kmalloc(fibsize, GFP_KERNEL);
-	if (!user_srbcmd) {
-		dprintk((KERN_DEBUG"aacraid: Could not make a copy of the srb\n"));
-		rcode = -ENOMEM;
-		goto cleanup;
-	}
-	if(copy_from_user(user_srbcmd, user_srb,fibsize)){
-		dprintk((KERN_DEBUG"aacraid: Could not copy srb from user\n"));
-		rcode = -EFAULT;
-		goto cleanup;
-	}
+	user_srbcmd = memdup_user(user_srb, fibsize);
+	if (IS_ERR(user_srbcmd))
+		return PTR_ERR(user_srbcmd);
 
 	flags = user_srbcmd->flags; /* from user in cpu order */
 	switch (flags & (SRB_DataIn | SRB_DataOut)) {
-- 
2.6.2

