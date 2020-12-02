Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5730B2CB717
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 09:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgLBI1j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 03:27:39 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:22598 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBI1j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Dec 2020 03:27:39 -0500
IronPort-SDR: Bofvg2LNW/XIzeaNhQwGsTNmGKEV3P8hS+ziRLEog9Ojp8ZwWYQrkacZvQrZrWl6blTbLQHcy8
 qQeslpsQLulle4UWGwHy1LgjBDlk6ez4oMnXphMwliz/moeC+2QM3HpwjDhBVbh1tJzPqlAA/Z
 CFG1vqC9yOfIX2/BZoFLMa1zL6egto4KlWGbCPEHTOrRLWuM2Z+tTyJGWQttQ0YxzpxQh09i/Y
 mDbF4T7GQsAjRdDu+arOv+GFBfgpXO1Ag800YJq2FlzjmIhqNP9nZkLY5vBgANW3OYKUlsZ3ty
 Zco=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="47539708"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 02 Dec 2020 00:26:59 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg03-sd.qualcomm.com with ESMTP; 02 Dec 2020 00:26:58 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 1BDA82107E; Wed,  2 Dec 2020 00:26:58 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 1/3] scsi: ufs: Serialize eh_work with system PM events and async scan
Date:   Wed,  2 Dec 2020 00:24:32 -0800
Message-Id: <1606897475-16907-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606897475-16907-1-git-send-email-cang@codeaurora.org>
References: <1606897475-16907-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Serialize eh_work with system PM events and async scan to make sure eh_work
does not run in parallel with them.

Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
Reviewed-by: Hongwu Su<hongwus@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 64 +++++++++++++++++++++++++++++------------------
 drivers/scsi/ufs/ufshcd.h |  1 +
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 47c544d..f0bb3fc 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5597,7 +5597,9 @@ static inline void ufshcd_schedule_eh_work(struct ufs_hba *hba)
 static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 {
 	pm_runtime_get_sync(hba->dev);
-	if (pm_runtime_suspended(hba->dev)) {
+	if (pm_runtime_status_suspended(hba->dev) || hba->is_sys_suspended) {
+		enum ufs_pm_op pm_op;
+
 		/*
 		 * Don't assume anything of pm_runtime_get_sync(), if
 		 * resume fails, irq and clocks can be OFF, and powers
@@ -5612,7 +5614,8 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		if (!ufshcd_is_clkgating_allowed(hba))
 			ufshcd_setup_clocks(hba, true);
 		ufshcd_release(hba);
-		ufshcd_vops_resume(hba, UFS_RUNTIME_PM);
+		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
+		ufshcd_vops_resume(hba, pm_op);
 	} else {
 		ufshcd_hold(hba, false);
 		if (hba->clk_scaling.is_allowed) {
@@ -5633,7 +5636,7 @@ static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 
 static inline bool ufshcd_err_handling_should_stop(struct ufs_hba *hba)
 {
-	return (hba->ufshcd_state == UFSHCD_STATE_ERROR ||
+	return (!hba->is_powered || hba->ufshcd_state == UFSHCD_STATE_ERROR ||
 		(!(hba->saved_err || hba->saved_uic_err || hba->force_reset ||
 			ufshcd_is_link_broken(hba))));
 }
@@ -5646,6 +5649,7 @@ static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 	struct request_queue *q;
 	int ret;
 
+	hba->is_sys_suspended = false;
 	/*
 	 * Set RPM status of hba device to RPM_ACTIVE,
 	 * this also clears its runtime error.
@@ -5704,11 +5708,13 @@ static void ufshcd_err_handler(struct work_struct *work)
 
 	hba = container_of(work, struct ufs_hba, eh_work);
 
+	down(&hba->eh_sem);
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (ufshcd_err_handling_should_stop(hba)) {
 		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
 			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		up(&hba->eh_sem);
 		return;
 	}
 	ufshcd_set_eh_in_progress(hba);
@@ -5716,20 +5722,18 @@ static void ufshcd_err_handler(struct work_struct *work)
 	ufshcd_err_handling_prepare(hba);
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_scsi_block_requests(hba);
-	/*
-	 * A full reset and restore might have happened after preparation
-	 * is finished, double check whether we should stop.
-	 */
-	if (ufshcd_err_handling_should_stop(hba)) {
-		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
-			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
-		goto out;
-	}
 	hba->ufshcd_state = UFSHCD_STATE_RESET;
 
 	/* Complete requests that have door-bell cleared by h/w */
 	ufshcd_complete_requests(hba);
 
+	/*
+	 * A full reset and restore might have happened after preparation
+	 * is finished, double check whether we should stop.
+	 */
+	if (ufshcd_err_handling_should_stop(hba))
+		goto skip_err_handling;
+
 	if (hba->dev_quirks & UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS) {
 		bool ret;
 
@@ -5737,17 +5741,10 @@ static void ufshcd_err_handler(struct work_struct *work)
 		/* release the lock as ufshcd_quirk_dl_nac_errors() may sleep */
 		ret = ufshcd_quirk_dl_nac_errors(hba);
 		spin_lock_irqsave(hba->host->host_lock, flags);
-		if (!ret && !hba->force_reset && ufshcd_is_link_active(hba))
+		if (!ret && ufshcd_err_handling_should_stop(hba))
 			goto skip_err_handling;
 	}
 
-	if (hba->force_reset || ufshcd_is_link_broken(hba) ||
-	    ufshcd_is_saved_err_fatal(hba) ||
-	    ((hba->saved_err & UIC_ERROR) &&
-	     (hba->saved_uic_err & (UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
-				    UFSHCD_UIC_DL_TCx_REPLAY_ERROR))))
-		needs_reset = true;
-
 	if ((hba->saved_err & (INT_FATAL_ERRORS | UFSHCD_UIC_HIBERN8_MASK)) ||
 	    (hba->saved_uic_err &&
 	     (hba->saved_uic_err != UFSHCD_UIC_PA_GENERIC_ERROR))) {
@@ -5767,8 +5764,14 @@ static void ufshcd_err_handler(struct work_struct *work)
 	 * transfers forcefully because they will get cleared during
 	 * host reset and restore
 	 */
-	if (needs_reset)
+	if (hba->force_reset || ufshcd_is_link_broken(hba) ||
+	    ufshcd_is_saved_err_fatal(hba) ||
+	    ((hba->saved_err & UIC_ERROR) &&
+	     (hba->saved_uic_err & (UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
+				    UFSHCD_UIC_DL_TCx_REPLAY_ERROR)))) {
+		needs_reset = true;
 		goto do_reset;
+	}
 
 	/*
 	 * If LINERESET was caught, UFS might have been put to PWM mode,
@@ -5876,12 +5879,11 @@ static void ufshcd_err_handler(struct work_struct *work)
 			dev_err_ratelimited(hba->dev, "%s: exit: saved_err 0x%x saved_uic_err 0x%x",
 			    __func__, hba->saved_err, hba->saved_uic_err);
 	}
-
-out:
 	ufshcd_clear_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_scsi_unblock_requests(hba);
 	ufshcd_err_handling_unprepare(hba);
+	up(&hba->eh_sem);
 }
 
 /**
@@ -6856,6 +6858,7 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba)
 	 */
 	scsi_report_bus_reset(hba->host, 0);
 	if (err) {
+		hba->ufshcd_state = UFSHCD_STATE_ERROR;
 		hba->saved_err |= saved_err;
 		hba->saved_uic_err |= saved_uic_err;
 	}
@@ -7704,8 +7707,10 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
 	struct ufs_hba *hba = (struct ufs_hba *)data;
 	int ret;
 
+	down(&hba->eh_sem);
 	/* Initialize hba, detect and initialize UFS device */
 	ret = ufshcd_probe_hba(hba, true);
+	up(&hba->eh_sem);
 	if (ret)
 		goto out;
 
@@ -8718,6 +8723,7 @@ int ufshcd_system_suspend(struct ufs_hba *hba)
 	int ret = 0;
 	ktime_t start = ktime_get();
 
+	down(&hba->eh_sem);
 	if (!hba || !hba->is_powered)
 		return 0;
 
@@ -8748,6 +8754,8 @@ int ufshcd_system_suspend(struct ufs_hba *hba)
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 	if (!ret)
 		hba->is_sys_suspended = true;
+	else
+		up(&hba->eh_sem);
 	return ret;
 }
 EXPORT_SYMBOL(ufshcd_system_suspend);
@@ -8764,8 +8772,10 @@ int ufshcd_system_resume(struct ufs_hba *hba)
 	int ret = 0;
 	ktime_t start = ktime_get();
 
-	if (!hba)
+	if (!hba) {
+		up(&hba->eh_sem);
 		return -EINVAL;
+	}
 
 	if (!hba->is_powered || pm_runtime_suspended(hba->dev))
 		/*
@@ -8781,6 +8791,7 @@ int ufshcd_system_resume(struct ufs_hba *hba)
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 	if (!ret)
 		hba->is_sys_suspended = false;
+	up(&hba->eh_sem);
 	return ret;
 }
 EXPORT_SYMBOL(ufshcd_system_resume);
@@ -8872,6 +8883,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 {
 	int ret = 0;
 
+	down(&hba->eh_sem);
 	if (!hba->is_powered)
 		goto out;
 
@@ -8888,6 +8900,8 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 out:
 	if (ret)
 		dev_err(hba->dev, "%s failed, err %d\n", __func__, ret);
+	hba->is_powered = false;
+	up(&hba->eh_sem);
 	/* allow force shutdown even in case of errors */
 	return 0;
 }
@@ -9082,6 +9096,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	INIT_WORK(&hba->eh_work, ufshcd_err_handler);
 	INIT_WORK(&hba->eeh_work, ufshcd_exception_event_handler);
 
+	sema_init(&hba->eh_sem, 1);
+
 	/* Initialize UIC command mutex */
 	mutex_init(&hba->uic_cmd_mutex);
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 47eb143..1e680bf 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -728,6 +728,7 @@ struct ufs_hba {
 	u32 intr_mask;
 	u16 ee_ctrl_mask;
 	bool is_powered;
+	struct semaphore eh_sem;
 
 	/* Work Queues */
 	struct workqueue_struct *eh_wq;
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

