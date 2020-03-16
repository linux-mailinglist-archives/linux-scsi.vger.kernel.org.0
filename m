Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952E518A242
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2020 19:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCRSWQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Mar 2020 14:22:16 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:11629 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCRSWQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Mar 2020 14:22:16 -0400
IronPort-SDR: PtQYAqYmSU0V13VozZJzT3/D/k3Aw4DWrLHK9jvJkfDjc7Uk3homh3/D233H7+zWukP/i0yQKL
 wp/+b68cT7IFCY38LwOmf1gwPpR8cnMHcgIzjLAbe//7kaVpbnS4xtArEuE7JhZZaX9g2rYbtx
 cOZWUXGZkvFoFmSfrF2hQi7wRmUwSTcNsIB28g9c9J9L/Dekjuu0TSwiqAb6HuutnC5F6qW3iU
 yHzocVmXAsSGvKRiqwL15u0/S+I1fN0VxBbaPPBmP5TV64ejczCwQ47DCSau5WTT/Ra6MkYzcu
 /Z0=
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="46713605"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by labrats.qualcomm.com with ESMTP; 16 Mar 2020 00:06:27 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg01-sd.qualcomm.com with ESMTP; 16 Mar 2020 00:06:25 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id CC1EC3A63; Mon, 16 Mar 2020 00:06:25 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] scsi: ufs: Clean up ufshcd_scale_clks() and clock scaling error out path
Date:   Mon, 16 Mar 2020 00:06:10 -0700
Message-Id: <1584342373-10282-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584342373-10282-1-git-send-email-cang@codeaurora.org>
References: <1584342373-10282-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

This change introduces a func ufshcd_set_clk_freq() to explicitly
set clock frequency so that it can be used in reset_and_resotre path and
in ufshcd_scale_clks(). Meanwhile, this change cleans up the clock scaling
error out path.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2a2a63b..63aaa88f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -855,28 +855,29 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
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
@@ -895,7 +896,6 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 				if (clki->curr_freq == clki->min_freq)
 					continue;
 
-				clk_state_changed = true;
 				ret = clk_set_rate(clki->clk, clki->min_freq);
 				if (ret) {
 					dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
@@ -914,13 +914,36 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
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
 
@@ -1106,35 +1129,36 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 
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
@@ -6251,7 +6275,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, true);
+	ufshcd_set_clk_freq(hba, true);
 
 	err = ufshcd_hba_enable(hba);
 	if (err)
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

