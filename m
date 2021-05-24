Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0238E290
	for <lists+linux-scsi@lfdr.de>; Mon, 24 May 2021 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhEXItM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 May 2021 04:49:12 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:4217 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhEXItL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 May 2021 04:49:11 -0400
IronPort-SDR: jS6wZypjTF42lEwBuWhq953tIWL54Ys0KUDpYG+RYeEelmQZPRnDNo/f9MPc9Eek4mNzndMSwg
 YoRq/vEXlEDHSlIJkJKyZCd8I3fUGYoNbiCqiW7poRmc5AvCNhTyf5Xht8GYjKionQMLMZWjeP
 1vNNNy8OU8UewSKEzqnRBhAinKct2E2hVZDy6D6JlYmRJZrAa3iO7vWtAD88XUvlaErdjEJ++v
 RHgzekbWWZoGXb0K2ecilD+hHyu1KY3kDVvRCth7EMnZ56bd6qs6elNF1+U4NuKosKAjSYyOJh
 tqI=
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="29772336"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 24 May 2021 01:47:43 -0700
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 24 May 2021 01:47:43 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 15E3B21AD7; Mon, 24 May 2021 01:47:43 -0700 (PDT)
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
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] scsi: ufs: Simplify error handling preparation
Date:   Mon, 24 May 2021 01:47:22 -0700
Message-Id: <1621846046-22204-4-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621846046-22204-1-git-send-email-cang@codeaurora.org>
References: <1621846046-22204-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Commit cb7e6f05fce67c965194ac04467e1ba7bc70b069 ("scsi: ufs: core: Enable
power management for wlun") moves UFS operations out of ufshcd_resume(), so
in error handling preparation, if ufshcd hba has failed to resume, there is
no point to re-enable IRQ/clk/pwr.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 61 ++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 809d0cb..301304b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2721,8 +2721,8 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		break;
 	case UFSHCD_STATE_EH_SCHEDULED_FATAL:
 		/*
-		 * pm_runtime_get_sync() is used at error handling preparation
-		 * stage. If a scsi cmd, e.g. the SSU cmd, is sent from hba's
+		 * ufshcd_rpm_get_sync() is used at error handling preparation
+		 * stage. If a scsi cmd, e.g., the SSU cmd, is sent from the
 		 * PM ops, it can never be finished if we let SCSI layer keep
 		 * retrying it, which gets err handler stuck forever. Neither
 		 * can we let the scsi cmd pass through, because UFS is in bad
@@ -5908,28 +5908,33 @@ static void ufshcd_clk_scaling_suspend(struct ufs_hba *hba, bool suspend)
 	}
 }
 
-static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
+static int ufshcd_err_handling_prepare(struct ufs_hba *hba)
 {
+	unsigned long flags;
+
+	/*
+	 * Exclusively call pm_runtime_get_sync(hba->dev) once, in case
+	 * following ufshcd_rpm_get_sync() fails.
+	 */
+	pm_runtime_get_sync(hba->dev);
+	/*
+	 * IRQ, clocks and powers are supposed to be ON by now, unless error
+	 * happened to ufshcd_resume(), which is out of our control.
+	 */
+	if (pm_runtime_suspended(hba->dev) || hba->is_sys_suspended) {
+		spin_lock_irqsave(hba->host->host_lock, flags);
+		hba->ufshcd_state = UFSHCD_STATE_ERROR;
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		pm_runtime_put(hba->dev);
+		return -EINVAL;
+	}
+
 	ufshcd_rpm_get_sync(hba);
-	if (pm_runtime_status_suspended(&hba->sdev_ufs_device->sdev_gendev) ||
+	if (pm_runtime_suspended(&hba->sdev_ufs_device->sdev_gendev) ||
 	    hba->is_wl_sys_suspended) {
-		enum ufs_pm_op pm_op;
+		enum ufs_pm_op pm_op = hba->is_wl_sys_suspended ?
+				       UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 
-		/*
-		 * Don't assume anything of resume, if
-		 * resume fails, irq and clocks can be OFF, and powers
-		 * can be OFF or in LPM.
-		 */
-		ufshcd_setup_hba_vreg(hba, true);
-		ufshcd_enable_irq(hba);
-		ufshcd_setup_vreg(hba, true);
-		ufshcd_config_vreg_hpm(hba, hba->vreg_info.vccq);
-		ufshcd_config_vreg_hpm(hba, hba->vreg_info.vccq2);
-		ufshcd_hold(hba, false);
-		if (!ufshcd_is_clkgating_allowed(hba))
-			ufshcd_setup_clocks(hba, true);
-		ufshcd_release(hba);
-		pm_op = hba->is_wl_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
 		ufshcd_hold(hba, false);
@@ -5943,6 +5948,7 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 	down_write(&hba->clk_scaling_lock);
 	up_write(&hba->clk_scaling_lock);
 	cancel_work_sync(&hba->eeh_work);
+	return 0;
 }
 
 static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
@@ -5953,6 +5959,7 @@ static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 		ufshcd_clk_scaling_suspend(hba, false);
 	ufshcd_clear_ua_wluns(hba);
 	ufshcd_rpm_put(hba);
+	pm_runtime_put(hba->dev);
 }
 
 static inline bool ufshcd_err_handling_should_stop(struct ufs_hba *hba)
@@ -6044,12 +6051,17 @@ static void ufshcd_err_handler(struct work_struct *work)
 		up(&hba->host_sem);
 		return;
 	}
-	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	ufshcd_err_handling_prepare(hba);
+	if (ufshcd_err_handling_prepare(hba)) {
+		dev_err(hba->dev, "%s: error handling preparation failed\n",
+				__func__);
+		up(&hba->host_sem);
+		return;
+	}
 	/* Complete requests that have door-bell cleared by h/w */
 	ufshcd_complete_requests(hba);
 	spin_lock_irqsave(hba->host->host_lock, flags);
+	ufshcd_set_eh_in_progress(hba);
 	if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
 		hba->ufshcd_state = UFSHCD_STATE_RESET;
 	/*
@@ -8987,6 +8999,9 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
+
+	hba->clk_gating.is_suspended = false;
+	ufshcd_release(hba);
 	goto out;
 
 set_old_link_state:
@@ -8996,8 +9011,6 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 out:
 	if (ret)
 		ufshcd_update_evt_hist(hba, UFS_EVT_WL_RES_ERR, (u32)ret);
-	hba->clk_gating.is_suspended = false;
-	ufshcd_release(hba);
 	hba->wl_pm_op_in_progress = false;
 	return ret <= 0 ? ret : -EINVAL;
 }
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

