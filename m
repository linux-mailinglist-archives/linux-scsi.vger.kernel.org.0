Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3CEBC17
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Nov 2019 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfKACwZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Oct 2019 22:52:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKACwY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 31 Oct 2019 22:52:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C1A760B69; Fri,  1 Nov 2019 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572576743;
        bh=9PnKWDr3wS+f9/GKAVPQtiDuMYcQwzXgn+4d0lAkM9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPAmkVoZha2n8Yur+AIcXK0FMoenZQ4CDSKlkVPfIfkvrJFDQni+O2EuOyDx/jlOG
         uLrg5fA9AUa5CXp7cTKC/gtGzMrV0aU0KtQe192QeLp5cdGJNQADXaUPxlPA6SS6k+
         3uhGltqRCtVE5XvOD4UVWK2epYI78LYN/OM3JWfs=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BCFD60913;
        Fri,  1 Nov 2019 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572576741;
        bh=9PnKWDr3wS+f9/GKAVPQtiDuMYcQwzXgn+4d0lAkM9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgtEU7+eQJeBywoAncUMy/7WtQeJF6LZvn5ots7MlxNDSKlsoH2saPpu3fTzyhQG6
         mKsg2bjc/ahEWXvk1l7jhCnRXMpIChpoBHDAt6H0uYCqd2t13NEpPMldS1IDA9nLnO
         sTJ80LE/s+3IWqShWgCg0/1+j6io+F6BQORKYzQo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BCFD60913
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] scsi: ufs: Fix up clock scaling
Date:   Thu, 31 Oct 2019 19:52:04 -0700
Message-Id: <1572576725-31092-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572576725-31092-1-git-send-email-cang@codeaurora.org>
References: <1572576725-31092-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

In host reset and restore path, after hba is stopped but before it is
enabled back again, we scale up clocks to their max frequencies.
If clock scale notify vendor specific ops happens to have any operations
to hba, DME commands for example, it would fail due to hba is stopped at
this moment. This change introduces another func to explicitly set clock
frequency so that it can be used here and also in ufshcd_scale_clks().
Meanwhile, this change modifies the clock scaling preparation error out
path so that clock is released before it returns.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 74 +++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c28c144..54ae643 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -903,28 +903,29 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
 		return false;
 }
 
-static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
+/**
+ * ufshcd_set_clk_freq - set UFS controller clock frequencies
+ * @hba: per adapter instance
+ * @scale_up: If True, set max possible frequency othewise set low frequency
+ *
+ * Returns 0 if successful
+ * Returns < 0 for any other errors
+ */
+static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 {
 	int ret = 0;
 	struct ufs_clk_info *clki;
 	struct list_head *head = &hba->clk_list_head;
-	ktime_t start = ktime_get();
-	bool clk_state_changed = false;
 
 	if (list_empty(head))
 		goto out;
 
-	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, PRE_CHANGE);
-	if (ret)
-		return ret;
-
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
 			if (scale_up && clki->max_freq) {
 				if (clki->curr_freq == clki->max_freq)
 					continue;
 
-				clk_state_changed = true;
 				ret = clk_set_rate(clki->clk, clki->max_freq);
 				if (ret) {
 					dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
@@ -943,7 +944,6 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 				if (clki->curr_freq == clki->min_freq)
 					continue;
 
-				clk_state_changed = true;
 				ret = clk_set_rate(clki->clk, clki->min_freq);
 				if (ret) {
 					dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
@@ -962,13 +962,36 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 				clki->name, clk_get_rate(clki->clk));
 	}
 
+out:
+	return ret;
+}
+
+/**
+ * ufshcd_scale_clks - scale up or scale down UFS controller clocks
+ * @hba: per adapter instance
+ * @scale_up: True if scaling up and false if scaling down
+ *
+ * Returns 0 if successful
+ * Returns < 0 for any other errors
+ */
+static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
+{
+	int ret = 0;
+
+	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, PRE_CHANGE);
+	if (ret)
+		return ret;
+
+	ret = ufshcd_set_clk_freq(hba, scale_up);
+	if (ret)
+		return ret;
+
 	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
+	if (ret) {
+		ufshcd_set_clk_freq(hba, !scale_up);
+		return ret;
+	}
 
-out:
-	if (clk_state_changed)
-		trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
-			(scale_up ? "up" : "down"),
-			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
 	return ret;
 }
 
@@ -1154,35 +1177,36 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 
 	ret = ufshcd_clock_scaling_prepare(hba);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* scale down the gear before scaling down clocks */
 	if (!scale_up) {
 		ret = ufshcd_scale_gear(hba, false);
 		if (ret)
-			goto out;
+			goto clk_scaling_unprepare;
 	}
 
 	ret = ufshcd_scale_clks(hba, scale_up);
-	if (ret) {
-		if (!scale_up)
-			ufshcd_scale_gear(hba, true);
-		goto out;
-	}
+	if (ret)
+		goto scale_up_gear;
 
 	/* scale up the gear after scaling up clocks */
 	if (scale_up) {
 		ret = ufshcd_scale_gear(hba, true);
 		if (ret) {
 			ufshcd_scale_clks(hba, false);
-			goto out;
+			goto clk_scaling_unprepare;
 		}
 	}
 
-	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
+	goto clk_scaling_unprepare;
 
-out:
+scale_up_gear:
+	if (!scale_up)
+		ufshcd_scale_gear(hba, true);
+clk_scaling_unprepare:
 	ufshcd_clock_scaling_unprepare(hba);
+out:
 	ufshcd_release(hba);
 	return ret;
 }
@@ -6207,7 +6231,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, true);
+	ufshcd_set_clk_freq(hba, true);
 
 	err = ufshcd_hba_enable(hba);
 	if (err)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

