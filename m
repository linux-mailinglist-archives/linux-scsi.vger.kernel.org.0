Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8FE6B91
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Oct 2019 04:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfJ1Du4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 27 Oct 2019 23:50:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfJ1Duz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 27 Oct 2019 23:50:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 908F060D7C; Mon, 28 Oct 2019 03:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572234654;
        bh=EIWkMT3gvUX77BQCTSbURXZVaTuCAlizzMnxoMOJpxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jb0nUPHo/HP9yct2/dEgm2s3/I5D+uEBJKXr+BE4Vp/Oe5OXOHTBxJaMpszaojwYb
         y9eZOZ+qeNs8pL8EI+RxuqFAGtkTD6sGB+Zi3cKUNwGY5qCkiPjKMAn7qQS1Q16mT1
         mDZY58KLMekSmsESJFsNgKyssx1RTaxgzDO8H+sI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DB4960C8C;
        Mon, 28 Oct 2019 03:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572234652;
        bh=EIWkMT3gvUX77BQCTSbURXZVaTuCAlizzMnxoMOJpxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0l3abc9+fvuRDskRPFggtCHfHL5cqLcrcdM7F+ORdRLy5hXk/kI8WvWZkdPhXqBd
         rtrM0EcCBLQ34RX2iufIQHNupaykftPlfY4c315b97hpJs2SV0ueruHyu4BQ7DoUh2
         dAzOegsK8G/vzhiol6y6Id03KP8ya0vYFsEOXeK0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DB4960C8C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 5/5] scsi: ufs: Do not free irq in suspend
Date:   Sun, 27 Oct 2019 20:50:07 -0700
Message-Id: <1572234608-32654-6-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572234608-32654-1-git-send-email-cang@codeaurora.org>
References: <1572234608-32654-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If PM QoS is enabled and we set request type to PM_QOS_REQ_AFFINE_IRQ then
freeing up the irq makes the free_irq() print out warning with call stack.
We don't really need to free up irq during suspend, disabling it during
suspend and reenabling it during resume should be good enough.

Change-Id: I4c4033552ae2cd849aeccd98dd517fdeb91c5cb7
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 34efa8a..fb36a51 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -266,26 +266,18 @@ static inline bool ufshcd_valid_tag(struct ufs_hba *hba, int tag)
 	return tag >= 0 && tag < hba->nutrs;
 }
 
-static inline int ufshcd_enable_irq(struct ufs_hba *hba)
+static inline void ufshcd_enable_irq(struct ufs_hba *hba)
 {
-	int ret = 0;
-
 	if (!hba->is_irq_enabled) {
-		ret = request_irq(hba->irq, ufshcd_intr, IRQF_SHARED, UFSHCD,
-				hba);
-		if (ret)
-			dev_err(hba->dev, "%s: request_irq failed, ret=%d\n",
-				__func__, ret);
+		enable_irq(hba->irq);
 		hba->is_irq_enabled = true;
 	}
-
-	return ret;
 }
 
 static inline void ufshcd_disable_irq(struct ufs_hba *hba)
 {
 	if (hba->is_irq_enabled) {
-		free_irq(hba->irq, hba);
+		disable_irq(hba->irq);
 		hba->is_irq_enabled = false;
 	}
 }
@@ -7927,9 +7919,7 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		goto out;
 
 	/* enable the host irq as host controller would be active soon */
-	ret = ufshcd_enable_irq(hba);
-	if (ret)
-		goto disable_irq_and_vops_clks;
+	ufshcd_enable_irq(hba);
 
 	ret = ufshcd_vreg_set_hpm(hba);
 	if (ret)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

