Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412EF2FCF67
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Jan 2021 13:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbhATLYk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Jan 2021 06:24:40 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:46624 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbhATKFq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 Jan 2021 05:05:46 -0500
IronPort-SDR: r4ye5IA695R6YHvw7H0scg0p5v3Own68jfWVlDCP8w2RIJplXO055WuoyBu3Dd3NPDcHeupbk9
 MHB0Mr//BnP1N7Rxr/nd5D63b+6UvCP8nLwbUqTDiBcXYNttFR6EPjRkM+gPSkpNYnhs5KYbHS
 oOdsS58lMkwioc+3asoea53Sgxow0RC6AD+Ou0a572W69fRvKQcCdl+kBtq/HUMT4jDyWBh6B4
 OFl9FMjIvTAiqYohZubx5q1uHfaBMlVwTHoZPo/ELxNajBcoNNIXVVuIQtUST72UX6RvwD2gAa
 Kms=
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="47682877"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 20 Jan 2021 02:04:58 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg04-sd.qualcomm.com with ESMTP; 20 Jan 2021 02:04:57 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 87C8921941; Wed, 20 Jan 2021 02:04:57 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Satya Tangirala <satyat@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 1/3] scsi: ufs: Protect some contexts from unexpected clock scaling
Date:   Wed, 20 Jan 2021 02:04:21 -0800
Message-Id: <1611137065-14266-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611137065-14266-1-git-send-email-cang@codeaurora.org>
References: <1611137065-14266-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In contexts like suspend, shutdown and error handling, we need to suspend
devfreq to make sure these contexts won't be disturbed by clock scaling.
However, suspending devfreq is not enough since users can still trigger a
clock scaling by manipulating the devfreq sysfs nodes like min/max_freq and
governor even after devfreq is suspended. Moreover, mere suspending devfreq
cannot synchroinze a clock scaling which has already been invoked through
these sysfs nodes. Add one more flag in struct clk_scaling and wrap the
entire func ufshcd_devfreq_scale() with the clk_scaling_lock, so that we
can use this flag and clk_scaling_lock to control and synchronize clock
scaling invoked through devfreq sysfs nodes.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 80 +++++++++++++++++++++++++++++------------------
 drivers/scsi/ufs/ufshcd.h |  6 +++-
 2 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 82ad317..8dc4a3a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1181,19 +1181,30 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
 	 */
 	ufshcd_scsi_block_requests(hba);
 	down_write(&hba->clk_scaling_lock);
-	if (ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
+
+	if (!hba->clk_scaling.is_allowed ||
+	    ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
 		ret = -EBUSY;
 		up_write(&hba->clk_scaling_lock);
 		ufshcd_scsi_unblock_requests(hba);
+		goto out;
 	}
 
+	/* let's not get into low power until clock scaling is completed */
+	ufshcd_hold(hba, false);
+
+out:
 	return ret;
 }
 
-static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba)
+static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
 {
-	up_write(&hba->clk_scaling_lock);
+	if (writelock)
+		up_write(&hba->clk_scaling_lock);
+	else
+		up_read(&hba->clk_scaling_lock);
 	ufshcd_scsi_unblock_requests(hba);
+	ufshcd_release(hba);
 }
 
 /**
@@ -1208,13 +1219,11 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba)
 static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 {
 	int ret = 0;
-
-	/* let's not get into low power until clock scaling is completed */
-	ufshcd_hold(hba, false);
+	bool is_writelock = true;
 
 	ret = ufshcd_clock_scaling_prepare(hba);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* scale down the gear before scaling down clocks */
 	if (!scale_up) {
@@ -1240,14 +1249,12 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 	}
 
 	/* Enable Write Booster if we have scaled up else disable it */
-	up_write(&hba->clk_scaling_lock);
+	downgrade_write(&hba->clk_scaling_lock);
+	is_writelock = false;
 	ufshcd_wb_ctrl(hba, scale_up);
-	down_write(&hba->clk_scaling_lock);
 
 out_unprepare:
-	ufshcd_clock_scaling_unprepare(hba);
-out:
-	ufshcd_release(hba);
+	ufshcd_clock_scaling_unprepare(hba, is_writelock);
 	return ret;
 }
 
@@ -1521,7 +1528,7 @@ static ssize_t ufshcd_clkscale_enable_show(struct device *dev,
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", hba->clk_scaling.is_allowed);
+	return snprintf(buf, PAGE_SIZE, "%d\n", hba->clk_scaling.is_enabled);
 }
 
 static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
@@ -1535,7 +1542,7 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 		return -EINVAL;
 
 	value = !!value;
-	if (value == hba->clk_scaling.is_allowed)
+	if (value == hba->clk_scaling.is_enabled)
 		goto out;
 
 	pm_runtime_get_sync(hba->dev);
@@ -1544,7 +1551,7 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 	cancel_work_sync(&hba->clk_scaling.suspend_work);
 	cancel_work_sync(&hba->clk_scaling.resume_work);
 
-	hba->clk_scaling.is_allowed = value;
+	hba->clk_scaling.is_enabled = value;
 
 	if (value) {
 		ufshcd_resume_clkscaling(hba);
@@ -1882,8 +1889,6 @@ static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
 	snprintf(wq_name, sizeof(wq_name), "ufs_clkscaling_%d",
 		 hba->host->host_no);
 	hba->clk_scaling.workq = create_singlethread_workqueue(wq_name);
-
-	ufshcd_clkscaling_init_sysfs(hba);
 }
 
 static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
@@ -1891,6 +1896,8 @@ static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return;
 
+	if (hba->clk_scaling.enable_attr.attr.name)
+		device_remove_file(hba->dev, &hba->clk_scaling.enable_attr);
 	destroy_workqueue(hba->clk_scaling.workq);
 	ufshcd_devfreq_remove(hba);
 }
@@ -1955,7 +1962,7 @@ static void ufshcd_clk_scaling_start_busy(struct ufs_hba *hba)
 	if (!hba->clk_scaling.active_reqs++)
 		queue_resume_work = true;
 
-	if (!hba->clk_scaling.is_allowed || hba->pm_op_in_progress)
+	if (!hba->clk_scaling.is_enabled || hba->pm_op_in_progress)
 		return;
 
 	if (queue_resume_work)
@@ -5737,18 +5744,24 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
 		ufshcd_hold(hba, false);
-		if (hba->clk_scaling.is_allowed) {
+		if (hba->clk_scaling.is_enabled) {
 			cancel_work_sync(&hba->clk_scaling.suspend_work);
 			cancel_work_sync(&hba->clk_scaling.resume_work);
 			ufshcd_suspend_clkscaling(hba);
 		}
+		down_write(&hba->clk_scaling_lock);
+		hba->clk_scaling.is_allowed = false;
+		up_write(&hba->clk_scaling_lock);
 	}
 }
 
 static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 {
 	ufshcd_release(hba);
-	if (hba->clk_scaling.is_allowed)
+	down_write(&hba->clk_scaling_lock);
+	hba->clk_scaling.is_allowed = true;
+	up_write(&hba->clk_scaling_lock);
+	if (hba->clk_scaling.is_enabled)
 		ufshcd_resume_clkscaling(hba);
 	pm_runtime_put(hba->dev);
 }
@@ -7728,12 +7741,14 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 			sizeof(struct ufs_pa_layer_attr));
 		hba->clk_scaling.saved_pwr_info.is_valid = true;
 		if (!hba->devfreq) {
+			hba->clk_scaling.is_allowed = true;
 			ret = ufshcd_devfreq_init(hba);
 			if (ret)
 				goto out;
-		}
 
-		hba->clk_scaling.is_allowed = true;
+			hba->clk_scaling.is_enabled = true;
+			ufshcd_clkscaling_init_sysfs(hba);
+		}
 	}
 
 	ufs_bsg_probe(hba);
@@ -8650,11 +8665,14 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ufshcd_hold(hba, false);
 	hba->clk_gating.is_suspended = true;
 
-	if (hba->clk_scaling.is_allowed) {
+	if (hba->clk_scaling.is_enabled) {
 		cancel_work_sync(&hba->clk_scaling.suspend_work);
 		cancel_work_sync(&hba->clk_scaling.resume_work);
 		ufshcd_suspend_clkscaling(hba);
 	}
+	down_write(&hba->clk_scaling_lock);
+	hba->clk_scaling.is_allowed = false;
+	up_write(&hba->clk_scaling_lock);
 
 	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
 			req_link_state == UIC_LINK_ACTIVE_STATE) {
@@ -8751,8 +8769,6 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	goto out;
 
 set_link_active:
-	if (hba->clk_scaling.is_allowed)
-		ufshcd_resume_clkscaling(hba);
 	ufshcd_vreg_set_hpm(hba);
 	/*
 	 * Device hardware reset is required to exit DeepSleep. Also, for
@@ -8776,7 +8792,10 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (!ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE))
 		ufshcd_disable_auto_bkops(hba);
 enable_gating:
-	if (hba->clk_scaling.is_allowed)
+	down_write(&hba->clk_scaling_lock);
+	hba->clk_scaling.is_allowed = true;
+	up_write(&hba->clk_scaling_lock);
+	if (hba->clk_scaling.is_enabled)
 		ufshcd_resume_clkscaling(hba);
 	hba->clk_gating.is_suspended = false;
 	hba->dev_info.b_rpm_dev_flush_capable = false;
@@ -8879,7 +8898,10 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	hba->clk_gating.is_suspended = false;
 
-	if (hba->clk_scaling.is_allowed)
+	down_write(&hba->clk_scaling_lock);
+	hba->clk_scaling.is_allowed = true;
+	up_write(&hba->clk_scaling_lock);
+	if (hba->clk_scaling.is_enabled)
 		ufshcd_resume_clkscaling(hba);
 
 	/* Enable Auto-Hibernate if configured */
@@ -8903,8 +8925,6 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ufshcd_vreg_set_lpm(hba);
 disable_irq_and_vops_clks:
 	ufshcd_disable_irq(hba);
-	if (hba->clk_scaling.is_allowed)
-		ufshcd_suspend_clkscaling(hba);
 	ufshcd_setup_clocks(hba, false);
 	if (ufshcd_is_clkgating_allowed(hba)) {
 		hba->clk_gating.state = CLKS_OFF;
@@ -9131,8 +9151,6 @@ void ufshcd_remove(struct ufs_hba *hba)
 
 	ufshcd_exit_clk_scaling(hba);
 	ufshcd_exit_clk_gating(hba);
-	if (ufshcd_is_clkscaling_supported(hba))
-		device_remove_file(hba->dev, &hba->clk_scaling.enable_attr);
 	ufshcd_hba_exit(hba);
 }
 EXPORT_SYMBOL_GPL(ufshcd_remove);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index aa9ea35..2863af1 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -419,7 +419,10 @@ struct ufs_saved_pwr_info {
  * @suspend_work: worker to suspend devfreq
  * @resume_work: worker to resume devfreq
  * @min_gear: lowest HS gear to scale down to
- * @is_allowed: tracks if scaling is currently allowed or not
+ * @is_enabled: tracks if scaling is currently enabled or not, controlled by
+		clkscale_enable sysfs node
+ * @is_allowed: tracks if scaling is currently allowed or not, used to block
+		clock scaling which is not invoked from devfreq governor
  * @is_busy_started: tracks if busy period has started or not
  * @is_suspended: tracks if devfreq is suspended or not
  */
@@ -434,6 +437,7 @@ struct ufs_clk_scaling {
 	struct work_struct suspend_work;
 	struct work_struct resume_work;
 	u32 min_gear;
+	bool is_enabled;
 	bool is_allowed;
 	bool is_busy_started;
 	bool is_suspended;
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

