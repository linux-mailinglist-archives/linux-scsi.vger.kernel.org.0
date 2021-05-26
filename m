Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648873914EB
	for <lists+linux-scsi@lfdr.de>; Wed, 26 May 2021 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhEZKa5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 May 2021 06:30:57 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47544 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233830AbhEZKa4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 May 2021 06:30:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ua9losT_1622024957;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ua9losT_1622024957)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 18:29:23 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alim.akhtar@samsung.com
Cc:     avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: ufs: Fix missing error code in ufshcd_hba_init_crypto_capabilities()
Date:   Wed, 26 May 2021 18:29:16 +0800
Message-Id: <1622024956-39680-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Eliminate the follow smatch warning:

drivers/scsi/ufs/ufshcd-crypto.c:167
ufshcd_hba_init_crypto_capabilities() warn: missing error code 'err'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/ufs/ufshcd-crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
index d70cdcd..c0163a3 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.c
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -163,8 +163,10 @@ int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba)
 	 * hasn't advertised that crypto is supported.
 	 */
 	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT) ||
-	    !(hba->caps & UFSHCD_CAP_CRYPTO))
+	    !(hba->caps & UFSHCD_CAP_CRYPTO)) {
+		err = -EINVAL;
 		goto out;
+	}
 
 	hba->crypto_capabilities.reg_val =
 			cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
-- 
1.8.3.1

