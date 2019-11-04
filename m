Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B4ED6F9
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 02:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfKDBgY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 3 Nov 2019 20:36:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfKDBgX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 3 Nov 2019 20:36:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 67A6860F61; Mon,  4 Nov 2019 01:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831383;
        bh=836Jc857UfXfWP4BPIMMn9j23njKiaDe8BLCZ1+/Llw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XadaUhc4uTks096YHsm0/VGYty4+awPyv4qqY/PsnwVIBctCvxD3pwvQ9FlVGWNft
         9DhCOOZeYNlEJyCGLSocX+XPh8TPyU175/VWNE4nc8KA7BO8ZISP/r+OBiwoTQaUDz
         Z72fSorSeYzrHJuEzH62BS+KtpWHU5XfPiaGDWVU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7A2D60EE3;
        Mon,  4 Nov 2019 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831382;
        bh=836Jc857UfXfWP4BPIMMn9j23njKiaDe8BLCZ1+/Llw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bu2omNz8BwYXW5c7sXwHV9yUwjClfAn0uxYmtitsRPAebszMqWJaKVkTNPT5pKhdW
         J0pD1Iq+HddaY9XKQxEvk9HmCzr2CR4HbEMbpCQq9y2sDKKY4nRqZ5317MDLjHTsv3
         4PecI9+IC6R56r1rSoI6u2Ad+GjMxZcieAJt9mZ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7A2D60EE3
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
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/7] scsi: ufs: Fix up auto hibern8 enablement
Date:   Sun,  3 Nov 2019 17:35:58 -0800
Message-Id: <1572831362-22779-4-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572831362-22779-1-git-send-email-cang@codeaurora.org>
References: <1572831362-22779-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix up possible unclocked register access to auto hibern8 register in
resume path and through sysfs entry. Meanwhile, enable auto hibern8
only after device is fully initialized in probe path.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufs-sysfs.c |  5 ++++-
 drivers/scsi/ufs/ufshcd.c    | 12 ++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 969a36b..de124f4 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -129,8 +129,11 @@ static void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 	if (hba->ahit == ahit)
 		goto out_unlock;
 	hba->ahit = ahit;
-	if (!pm_runtime_suspended(hba->dev))
+	if (!pm_runtime_suspended(hba->dev)) {
+		ufshcd_hold(hba, false);
 		ufshcd_writel(hba, hba->ahit, REG_AUTO_HIBERNATE_IDLE_TIMER);
+		ufshcd_release(hba);
+	}
 out_unlock:
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 525f8e6..f12f5a7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6892,9 +6892,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	/* UniPro link is active now */
 	ufshcd_set_link_active(hba);
 
-	/* Enable Auto-Hibernate if configured */
-	ufshcd_auto_hibern8_enable(hba);
-
 	ret = ufshcd_verify_dev_init(hba);
 	if (ret)
 		goto out;
@@ -6945,6 +6942,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	/* set the state as operational after switching to desired gear */
 	hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
 
+	/* Enable Auto-Hibernate if configured */
+	ufshcd_auto_hibern8_enable(hba);
+
 	/*
 	 * If we are in error handling context or in power management callbacks
 	 * context, no need to scan the host
@@ -7962,12 +7962,12 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (hba->clk_scaling.is_allowed)
 		ufshcd_resume_clkscaling(hba);
 
-	/* Schedule clock gating in case of no access to UFS device yet */
-	ufshcd_release(hba);
-
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
+	/* Schedule clock gating in case of no access to UFS device yet */
+	ufshcd_release(hba);
+
 	goto out;
 
 set_old_link_state:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

