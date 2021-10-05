Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5E422A3E
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Oct 2021 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhJEOJv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Oct 2021 10:09:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:47680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236504AbhJEOJS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 5 Oct 2021 10:09:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="212679117"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="212679117"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 06:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="477679536"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 05 Oct 2021 06:45:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <huobean@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Li <liwei213@huawei.com>, linux-scsi@vger.kernel.org
Subject: [PATCH V7 2/2] scsi: ufs: Let devices remain runtime suspended during system suspend
Date:   Tue,  5 Oct 2021 16:44:45 +0300
Message-Id: <20211005134445.234671-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005134445.234671-1-adrian.hunter@intel.com>
References: <20211005134445.234671-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If the UFS Device WLUN is runtime suspended and is in the same power
mode, link state and b_rpm_dev_flush_capable (BKOP or WB buffer flush etc)
state, then it can remain runtime suspended instead of being runtime
resumed and then system suspended.

The following patches have cleared the way for that to happen:
  scsi: ufs: Fix runtime PM dependencies getting broken
  scsi: ufs: core: Stop clearing UNIT ATTENTIONS

So amend the logic accordingly.

Note, the ufs-hisi driver uses different RPM and SPM, but it is made
explicit by a new parameter to suspend prepare.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufs-hisi.c |  8 ++++++-
 drivers/scsi/ufs/ufshcd.c   | 45 ++++++++++++++++++++++++++++++++-----
 drivers/scsi/ufs/ufshcd.h   | 11 +++++++++
 3 files changed, 58 insertions(+), 6 deletions(-)

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
index b70f566f7f8a..f34227add27d 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9681,7 +9681,27 @@ void ufshcd_resume_complete(struct device *dev)
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
@@ -9693,15 +9713,30 @@ int ufshcd_suspend_prepare(struct device *dev)
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
index 782bbe6d5a52..2384da8f30c0 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1191,6 +1191,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
+int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
 void ufshcd_resume_complete(struct device *dev);
 
 /* Wrapper functions for safely calling variant operations */
@@ -1399,6 +1400,16 @@ static inline int ufshcd_rpm_put_sync(struct ufs_hba *hba)
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
2.25.1

