Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02E630562C
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Jan 2021 09:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhA0IxV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Jan 2021 03:53:21 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46769 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232797AbhA0Iuu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 27 Jan 2021 03:50:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UN1NS1g_1611737386;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UN1NS1g_1611737386)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Jan 2021 16:50:03 +0800
From:   Abaci Team <abaci-bugfix@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abaci Team <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] scsi: ufs: fix: NULL pointer dereference
Date:   Wed, 27 Jan 2021 16:49:44 +0800
Message-Id: <1611737384-49321-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/scsi/ufs/ufshcd.c:8990:11-17: ERROR: hba is NULL but
dereferenced.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Suggested-by: Yang Li <oswb@linux.alibaba.com>
Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>
---
 drivers/scsi/ufs/ufshcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index fb32d12..9319251 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8990,7 +8990,6 @@ int ufshcd_system_resume(struct ufs_hba *hba)
 	ktime_t start = ktime_get();
 
 	if (!hba) {
-		up(&hba->eh_sem);
 		return -EINVAL;
 	}
 
-- 
1.8.3.1

