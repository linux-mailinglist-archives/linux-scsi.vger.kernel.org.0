Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9F37F2B0
	for <lists+linux-scsi@lfdr.de>; Thu, 13 May 2021 07:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEMF5L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 May 2021 01:57:11 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:35000 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhEMF5J (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 May 2021 01:57:09 -0400
IronPort-SDR: 0Mx5liXdtgTZgt1WpgO3cnI9nTNgeuhaHXL18FtucScz4zFIEXgo4OOic00NZyP2gNihKhn2sM
 PqKhvoZd7WpW1ovaF2+6AMCcylEJDi5nDxmvOEcHpJHSzWL97Gt1g4H8DX7dkrDyKinX+CtFDN
 PuH2CAoGAlmUQwekPUAjqiDNh8GGUro6v24EEf+rs0ACPwC8yegI8GwNh5XZE+sZxOtKjuVqPD
 t1wMSwlc256c/tQYn69/gmJmuo3q6zv0w6WPobTTn+pY/NXt74SYjX88jF4gMaYPGq7YuQ/BLK
 1kc=
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="29767598"
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by labrats.qualcomm.com with ESMTP; 12 May 2021 22:55:59 -0700
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg05-sd.qualcomm.com with ESMTP; 12 May 2021 22:55:59 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 8EB6E21A85; Wed, 12 May 2021 22:55:59 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 4/6] scsi: ufs: Update ufshcd_recover_pm_error()
Date:   Wed, 12 May 2021 22:55:17 -0700
Message-Id: <1620885319-15151-6-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620885319-15151-1-git-send-email-cang@codeaurora.org>
References: <1620885319-15151-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Commit cb7e6f05fce67c965194ac04467e1ba7bc70b069 ("scsi: ufs: core: Enable
power management for wlun") makes UFS device W-LU scsi device the supplier
and the others as consumers. If the supplier's runtime pm ops fails or has
failed, not only supplier has the error saved to dev->power.runtime_error,
the error may (most likely) be saved by one or more consumers, see also
rpm_get_suppliers(). Update ufshcd_recover_pm_error() accordingly to clear
the runtime_error of the supplier and its consumers to get runtime PM back
to work on them.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 50 ++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 0edc69f..631c5f8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -242,6 +242,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba);
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
 			     struct ufs_pa_layer_attr *pwr_mode);
 static void ufshcd_schedule_eh_work(struct ufs_hba *hba);
+static void ufshcd_recover_pm_error(struct ufs_hba *hba);
 static int ufshcd_setup_hba_vreg(struct ufs_hba *hba, bool on);
 static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
@@ -5840,12 +5841,14 @@ static int ufshcd_err_handling_prepare(struct ufs_hba *hba)
 	return 0;
 }
 
-static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
+static void ufshcd_err_handling_unprepare(struct ufs_hba *hba, int reset_err)
 {
 	ufshcd_scsi_unblock_requests(hba);
 	ufshcd_release(hba);
 	if (ufshcd_is_clkscaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
+	if (!reset_err)
+		ufshcd_recover_pm_error(hba);
 	ufshcd_clear_ua_wluns(hba);
 	ufshcd_rpm_put(hba);
 	pm_runtime_put(hba->dev);
@@ -5864,34 +5867,26 @@ static inline bool ufshcd_err_handling_should_stop(struct ufs_hba *hba)
 static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 {
 	struct Scsi_Host *shost = hba->host;
-	struct scsi_device *sdev;
-	struct request_queue *q;
+	struct scsi_device *sdev = hba->sdev_ufs_device;
+	struct scsi_target *starget = sdev->sdev_target;
 	int ret;
 
 	hba->is_wl_sys_suspended = false;
-	/*
-	 * Set RPM status of wlun device to RPM_ACTIVE,
-	 * this also clears its runtime error.
-	 */
-	ret = pm_runtime_set_active(&hba->sdev_ufs_device->sdev_gendev);
 
-	/* hba device might have a runtime error otherwise */
-	if (ret)
-		ret = pm_runtime_set_active(hba->dev);
-	/*
-	 * If wlun device had runtime error, we also need to resume those
-	 * consumer scsi devices in case any of them has failed to be
-	 * resumed due to supplier runtime resume failure. This is to unblock
-	 * blk_queue_enter in case there are bios waiting inside it.
-	 */
-	if (!ret) {
-		shost_for_each_device(sdev, shost) {
-			q = sdev->request_queue;
-			if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
-				       q->rpm_status == RPM_SUSPENDING))
-				pm_request_resume(q->dev);
-		}
+	/* Resume parent/target to clear path for pm_runtime_set_active() */
+	pm_runtime_get_sync(&starget->dev);
+	shost_for_each_device(sdev, shost) {
+		struct device *dev = &sdev->sdev_gendev;
+
+		pm_runtime_get_sync(dev);
+		/* Clear saved dev->power.runtime_error */
+		ret = pm_runtime_set_active(dev);
+		if (!ret)
+			/* runtime_error cleared, kick blk_queue_enter() */
+			blk_set_runtime_active(sdev->request_queue);
+		pm_runtime_put(dev);
 	}
+	pm_runtime_put(&starget->dev);
 }
 #else
 static inline void ufshcd_recover_pm_error(struct ufs_hba *hba)
@@ -5925,7 +5920,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 	unsigned long flags;
 	bool err_xfer = false;
 	bool err_tm = false;
-	int err = 0, pmc_err;
+	int err = -1, pmc_err;
 	int tag;
 	bool needs_reset = false, needs_restore = false;
 
@@ -6094,8 +6089,6 @@ static void ufshcd_err_handler(struct work_struct *work)
 		if (err)
 			dev_err(hba->dev, "%s: reset and restore failed with err %d\n",
 					__func__, err);
-		else
-			ufshcd_recover_pm_error(hba);
 		spin_lock_irqsave(hba->host->host_lock, flags);
 	}
 
@@ -6109,7 +6102,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 	}
 	ufshcd_clear_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	ufshcd_err_handling_unprepare(hba);
+	ufshcd_err_handling_unprepare(hba, err);
 	up(&hba->host_sem);
 }
 
@@ -6983,7 +6976,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 			hba->force_reset = true;
 			ufshcd_schedule_eh_work(hba);
 		}
-
 		spin_unlock_irqrestore(host->host_lock, flags);
 		goto out;
 	}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

