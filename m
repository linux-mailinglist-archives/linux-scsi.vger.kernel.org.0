Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A7C194EAA
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Mar 2020 02:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgC0B7L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Mar 2020 21:59:11 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:12695 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgC0B7L (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Mar 2020 21:59:11 -0400
IronPort-SDR: sceStHUxbTExeoMoi3X1XquwHPh1T9zG3OG+7wxL5o2k0kmfKdCWQWNesjUgHoPgZ/yAE9H3Co
 V3oKxvnY07z14QYfjtp7Uk2RFt+qGBnslg7XKoH5a9Gfh5t8qLJclqs9+IJriyKUUgusHxVpBz
 7yIXTavOlaIstujGkUO6lVlynJUdAPKjOJkDn4aXOgTCvQRf09lVtD3QCqOrEErJw+gaDxQIG0
 GRX/xjcGVW4I49BDUdTcjbjG+7kVRMGyUoUfD7WVI63GMdPrGI0xZmv+lDdSlN8I29SPUbdWIU
 cSc=
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200"; 
   d="scan'208";a="28616316"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 26 Mar 2020 02:26:06 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg03-sd.qualcomm.com with ESMTP; 26 Mar 2020 02:26:05 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id C69FF3AA6; Thu, 26 Mar 2020 02:26:05 -0700 (PDT)
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
Subject: [PATCH v6 1/2] scsi: ufs: Clean up ufshcd_scale_clks() and clock scaling error out path
Date:   Thu, 26 Mar 2020 02:25:40 -0700
Message-Id: <1585214742-5466-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585214742-5466-1-git-send-email-cang@codeaurora.org>
References: <1585214742-5466-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

This change introduces a func ufshcd_set_clk_freq() to explicitly
set clock frequency so that it can be used in reset_and_resotre path and
in ufshcd_scale_clks(). Meanwhile, this change cleans up the clock scaling
error out path.

Fixes: a3cd5ec55f6c ("scsi: ufs: add load based scaling of UFS gear")
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 65 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2a2a63b..148e73a 100644
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
@@ -914,11 +914,37 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
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
+	ktime_t start = ktime_get();
+
+	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, PRE_CHANGE);
+	if (ret)
+		goto out;
+
+	ret = ufshcd_set_clk_freq(hba, scale_up);
+	if (ret)
+		goto out;
+
 	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
+	if (ret)
+		ufshcd_set_clk_freq(hba, !scale_up);
 
 out:
-	if (clk_state_changed)
-		trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
+	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 			(scale_up ? "up" : "down"),
 			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
 	return ret;
@@ -1106,35 +1132,32 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 
 	ret = ufshcd_clock_scaling_prepare(hba);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* scale down the gear before scaling down clocks */
 	if (!scale_up) {
 		ret = ufshcd_scale_gear(hba, false);
 		if (ret)
-			goto out;
+			goto out_unprepare;
 	}
 
 	ret = ufshcd_scale_clks(hba, scale_up);
 	if (ret) {
 		if (!scale_up)
 			ufshcd_scale_gear(hba, true);
-		goto out;
+		goto out_unprepare;
 	}
 
 	/* scale up the gear after scaling up clocks */
 	if (scale_up) {
 		ret = ufshcd_scale_gear(hba, true);
-		if (ret) {
+		if (ret)
 			ufshcd_scale_clks(hba, false);
-			goto out;
-		}
 	}
 
-	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
-
-out:
+out_unprepare:
 	ufshcd_clock_scaling_unprepare(hba);
+out:
 	ufshcd_release(hba);
 	return ret;
 }
@@ -6251,7 +6274,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, true);
+	ufshcd_set_clk_freq(hba, true);
 
 	err = ufshcd_hba_enable(hba);
 	if (err)
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

