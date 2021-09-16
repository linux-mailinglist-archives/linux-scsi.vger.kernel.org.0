Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EE940E5AA
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 19:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbhIPROA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Sep 2021 13:14:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:64655 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350684AbhIPRL4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Sep 2021 13:11:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209703353"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="209703353"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 10:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="583723816"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2021 10:01:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <huobean@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Li <liwei213@huawei.com>, linux-scsi@vger.kernel.org
Subject: [PATCH V4 3/3] scsi: ufs: Let devices remain runtime suspended during system suspend
Date:   Thu, 16 Sep 2021 20:02:11 +0300
Message-Id: <20210916170211.8564-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210916170211.8564-1-adrian.hunter@intel.com>
References: <20210916170211.8564-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If the UFS Device WLUN is runtime suspended and is in the same power
mode, link state and b_rpm_dev_flush_capable (BKOP or WB buffer flush etc)
state, then it can remain runtime suspended instead of being runtime
resumed and then system suspended.

The following patches have cleared the way for that to happen:
  scsi: ufs: Fix runtime PM dependencies getting broken
  scsi: ufs: Fix error handler clear ua deadlock

So amend the logic accordingly.

Note, the ufs-hisi driver uses different RPM and SPM, but it is made
explicit by a new parameter to suspend prepare.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufs-hisi.c |  8 +++++-
 drivers/scsi/ufs/ufshcd.c   | 53 ++++++++++++++++++++++++++++---------
 drivers/scsi/ufs/ufshcd.h   | 12 ++++++++-
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 6b706de8354b..4a08fb35642c 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -396,6 +396,12 @@ static int ufs_hisi_pwr_change_notify(struct ufs_hba *hba,
 	return ret;
 }
 
+static int ufs_hisi_suspend_prepare(struct device *dev)
+{
+	/* RPM and SPM are different. Refer ufs_hisi_suspend() */
+	return __ufshcd_suspend_prepare(dev, false);
+}
+
 static int ufs_hisi_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
@@ -574,7 +580,7 @@ static int ufs_hisi_remove(struct platform_device *pdev)
 static const struct dev_pm_ops ufs_hisi_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
 	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
-	.prepare	 = ufshcd_suspend_prepare,
+	.prepare	 = ufs_hisi_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9c9df2ad2a34..56542b09eca6 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9806,14 +9806,30 @@ void ufshcd_resume_complete(struct device *dev)
 		ufshcd_rpm_put(hba);
 		hba->complete_put = false;
 	}
-	if (hba->rpmb_complete_put) {
-		ufshcd_rpmb_rpm_put(hba);
-		hba->rpmb_complete_put = false;
-	}
 }
 EXPORT_SYMBOL_GPL(ufshcd_resume_complete);
 
-int ufshcd_suspend_prepare(struct device *dev)
+static bool ufshcd_rpm_ok_for_spm(struct ufs_hba *hba)
+{
+	struct device *dev = &hba->sdev_ufs_device->sdev_gendev;
+	enum ufs_dev_pwr_mode dev_pwr_mode;
+	enum uic_link_state link_state;
+	unsigned long flags;
+	bool res;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev_pwr_mode = ufs_get_pm_lvl_to_dev_pwr_mode(hba->spm_lvl);
+	link_state = ufs_get_pm_lvl_to_link_pwr_state(hba->spm_lvl);
+	res = pm_runtime_suspended(dev) &&
+	      hba->curr_dev_pwr_mode == dev_pwr_mode &&
+	      hba->uic_link_state == link_state &&
+	      !hba->dev_info.b_rpm_dev_flush_capable;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return res;
+}
+
+int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	int ret;
@@ -9825,19 +9841,30 @@ int ufshcd_suspend_prepare(struct device *dev)
 	 * Refer ufshcd_resume_complete()
 	 */
 	if (hba->sdev_ufs_device) {
-		ret = ufshcd_rpm_get_sync(hba);
-		if (ret < 0 && ret != -EACCES) {
-			ufshcd_rpm_put(hba);
-			return ret;
+		/* Prevent runtime suspend */
+		ufshcd_rpm_get_noresume(hba);
+		/*
+		 * Check if already runtime suspended in same state as system
+		 * suspend would be.
+		 */
+		if (!rpm_ok_for_spm || !ufshcd_rpm_ok_for_spm(hba)) {
+			/* RPM state is not ok for SPM, so runtime resume */
+			ret = ufshcd_rpm_resume(hba);
+			if (ret < 0 && ret != -EACCES) {
+				ufshcd_rpm_put(hba);
+				return ret;
+			}
 		}
 		hba->complete_put = true;
 	}
-	if (hba->sdev_rpmb) {
-		ufshcd_rpmb_rpm_get_sync(hba);
-		hba->rpmb_complete_put = true;
-	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__ufshcd_suspend_prepare);
+
+int ufshcd_suspend_prepare(struct device *dev)
+{
+	return __ufshcd_suspend_prepare(dev, true);
+}
 EXPORT_SYMBOL_GPL(ufshcd_suspend_prepare);
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 82c0f689cbdb..49e8dd70eb5e 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -924,7 +924,6 @@ struct ufs_hba {
 #endif
 	u32 luns_avail;
 	bool complete_put;
-	bool rpmb_complete_put;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
@@ -1184,6 +1183,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
+int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
 void ufshcd_resume_complete(struct device *dev);
 
 /* Wrapper functions for safely calling variant operations */
@@ -1392,6 +1392,16 @@ static inline int ufshcd_rpm_put_sync(struct ufs_hba *hba)
 	return pm_runtime_put_sync(&hba->sdev_ufs_device->sdev_gendev);
 }
 
+static inline void ufshcd_rpm_get_noresume(struct ufs_hba *hba)
+{
+	pm_runtime_get_noresume(&hba->sdev_ufs_device->sdev_gendev);
+}
+
+static inline int ufshcd_rpm_resume(struct ufs_hba *hba)
+{
+	return pm_runtime_resume(&hba->sdev_ufs_device->sdev_gendev);
+}
+
 static inline int ufshcd_rpm_put(struct ufs_hba *hba)
 {
 	return pm_runtime_put(&hba->sdev_ufs_device->sdev_gendev);
-- 
2.17.1

