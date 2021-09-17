Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC48D40FA97
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Sep 2021 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhIQOod (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Sep 2021 10:44:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:22868 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhIQOod (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 17 Sep 2021 10:44:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="286493984"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="286493984"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 07:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="530742021"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.84])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2021 07:43:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Li <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] Revert "scsi: ufs: Synchronize SCSI and UFS error handling"
Date:   Fri, 17 Sep 2021 17:43:49 +0300
Message-Id: <20210917144349.14058-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This reverts commit a113eaaf86373362b053279049907ff82b5df6c8.

There are a couple of issues with the commit:
1. it causes deadlocks
2. it causes the shost->eh_cmd_q list of failed requests not to be
   processed ever
So revert it.

1. Deadlocks

The SCSI error handler runs with requests blocked beginning when
scsi_schedule_eh() sets SHOST_RECOVERY state, continuing through
scsi_error_handler() callback ->eh_strategy_handler() until
scsi_restart_operations() is called.  By setting eh_strategy_handler
to ufshcd_err_handler, the patch changed the UFS error handler to run with
requests blocked, including PM requests, for the entire run of the error
handler.

That conflicts with UFS error handler existing synchronization with UFS
device PM operations.  The UFS error handler synchronizes with runtime PM
by doing pm_runtime_get_sync() prior to blocking requests itself.  It
synchronizes with system PM by use of hba->host_sem, again before blocking
requests itself.  However, if requests are already blocked, then PM
operations will block.  So:
   the UFS error handler blocks waiting on PM
 + PM blocks waiting on SCSI PM requests to process or fail
 + PM requests are blocked waiting on error handling to finish
 =  deadlock

This happens both for runtime PM and system PM.

Prior to the patch, these deadlocks could not happen even if SCSI error
handling was running, because the presence of requests in shost->eh_cmd_q
would mean the queues could not be suspended, which would mean that, should
the UFS error handler run at the same time, it would not need to wait for
PM or vice versa.

Please note these scenarios are not just theoretical, they were found
during testing on a Samsung Galaxy Book S.

2. ->eh_strategy_handler() must process shost->eh_cmd_q list of failed
requests, as all other eh_strategy_handler's do except UFS error
handler.  Refer for example: scsi_unjam_host(), ata_scsi_error() and
sas_scsi_recover_host().

Fixes: a113eaaf863733 ("scsi: ufs: Synchronize SCSI and UFS error handling")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd.c | 111 +++++++++++++++++++-------------------
 drivers/scsi/ufs/ufshcd.h |   4 ++
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 67889d74761c..a3df5804b2c7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -17,8 +17,6 @@
 #include <linux/blk-pm.h>
 #include <linux/blkdev.h>
 #include <scsi/scsi_driver.h>
-#include <scsi/scsi_transport.h>
-#include "../scsi_transport_api.h"
 #include "ufshcd.h"
 #include "ufs_quirks.h"
 #include "unipro.h"
@@ -237,6 +235,7 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
 static irqreturn_t ufshcd_intr(int irq, void *__hba);
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
 			     struct ufs_pa_layer_attr *pwr_mode);
+static void ufshcd_schedule_eh_work(struct ufs_hba *hba);
 static int ufshcd_setup_hba_vreg(struct ufs_hba *hba, bool on);
 static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
@@ -2759,8 +2758,13 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 out:
 	up_read(&hba->clk_scaling_lock);
 
-	if (ufs_trigger_eh())
-		scsi_schedule_eh(hba->host);
+	if (ufs_trigger_eh()) {
+		unsigned long flags;
+
+		spin_lock_irqsave(hba->host->host_lock, flags);
+		ufshcd_schedule_eh_work(hba);
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+	}
 
 	return err;
 }
@@ -3919,35 +3923,6 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 }
 EXPORT_SYMBOL_GPL(ufshcd_dme_get_attr);
 
-static inline bool ufshcd_is_saved_err_fatal(struct ufs_hba *hba)
-{
-	lockdep_assert_held(hba->host->host_lock);
-
-	return (hba->saved_uic_err & UFSHCD_UIC_DL_PA_INIT_ERROR) ||
-	       (hba->saved_err & (INT_FATAL_ERRORS | UFSHCD_UIC_HIBERN8_MASK));
-}
-
-static void ufshcd_schedule_eh(struct ufs_hba *hba)
-{
-	bool schedule_eh = false;
-	unsigned long flags;
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	/* handle fatal errors only when link is not in error state */
-	if (hba->ufshcd_state != UFSHCD_STATE_ERROR) {
-		if (hba->force_reset || ufshcd_is_link_broken(hba) ||
-		    ufshcd_is_saved_err_fatal(hba))
-			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_FATAL;
-		else
-			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_NON_FATAL;
-		schedule_eh = true;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
-	if (schedule_eh)
-		scsi_schedule_eh(hba->host);
-}
-
 /**
  * ufshcd_uic_pwr_ctrl - executes UIC commands (which affects the link power
  * state) and waits for it to take effect.
@@ -3968,7 +3943,6 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 {
 	DECLARE_COMPLETION_ONSTACK(uic_async_done);
 	unsigned long flags;
-	bool schedule_eh = false;
 	u8 status;
 	int ret;
 	bool reenable_intr = false;
@@ -4038,14 +4012,10 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		ufshcd_enable_intr(hba, UIC_COMMAND_COMPL);
 	if (ret) {
 		ufshcd_set_link_broken(hba);
-		schedule_eh = true;
+		ufshcd_schedule_eh_work(hba);
 	}
-
 out_unlock:
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
-	if (schedule_eh)
-		ufshcd_schedule_eh(hba);
 	mutex_unlock(&hba->uic_cmd_mutex);
 
 	return ret;
@@ -5911,6 +5881,27 @@ static bool ufshcd_quirk_dl_nac_errors(struct ufs_hba *hba)
 	return err_handling;
 }
 
+/* host lock must be held before calling this func */
+static inline bool ufshcd_is_saved_err_fatal(struct ufs_hba *hba)
+{
+	return (hba->saved_uic_err & UFSHCD_UIC_DL_PA_INIT_ERROR) ||
+	       (hba->saved_err & (INT_FATAL_ERRORS | UFSHCD_UIC_HIBERN8_MASK));
+}
+
+/* host lock must be held before calling this func */
+static inline void ufshcd_schedule_eh_work(struct ufs_hba *hba)
+{
+	/* handle fatal errors only when link is not in error state */
+	if (hba->ufshcd_state != UFSHCD_STATE_ERROR) {
+		if (hba->force_reset || ufshcd_is_link_broken(hba) ||
+		    ufshcd_is_saved_err_fatal(hba))
+			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_FATAL;
+		else
+			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_NON_FATAL;
+		queue_work(hba->eh_wq, &hba->eh_work);
+	}
+}
+
 static void ufshcd_clk_scaling_allow(struct ufs_hba *hba, bool allow)
 {
 	down_write(&hba->clk_scaling_lock);
@@ -6044,11 +6035,11 @@ static bool ufshcd_is_pwr_mode_restore_needed(struct ufs_hba *hba)
 
 /**
  * ufshcd_err_handler - handle UFS errors that require s/w attention
- * @host: SCSI host pointer
+ * @work: pointer to work structure
  */
-static void ufshcd_err_handler(struct Scsi_Host *host)
+static void ufshcd_err_handler(struct work_struct *work)
 {
-	struct ufs_hba *hba = shost_priv(host);
+	struct ufs_hba *hba;
 	unsigned long flags;
 	bool err_xfer = false;
 	bool err_tm = false;
@@ -6056,9 +6047,10 @@ static void ufshcd_err_handler(struct Scsi_Host *host)
 	int tag;
 	bool needs_reset = false, needs_restore = false;
 
+	hba = container_of(work, struct ufs_hba, eh_work);
+
 	down(&hba->host_sem);
 	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->host->host_eh_scheduled = 0;
 	if (ufshcd_err_handling_should_stop(hba)) {
 		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
 			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
@@ -6371,6 +6363,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 					 "host_regs: ");
 			ufshcd_print_pwr_info(hba);
 		}
+		ufshcd_schedule_eh_work(hba);
 		retval |= IRQ_HANDLED;
 	}
 	/*
@@ -6382,10 +6375,6 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 	hba->errors = 0;
 	hba->uic_error = 0;
 	spin_unlock(hba->host->host_lock);
-
-	if (queue_eh_work)
-		ufshcd_schedule_eh(hba);
-
 	return retval;
 }
 
@@ -7048,17 +7037,15 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * will be to send LU reset which, again, is a spec violation.
 	 * To avoid these unnecessary/illegal steps, first we clean up
 	 * the lrb taken by this cmd and re-set it in outstanding_reqs,
-	 * then queue the error handler and bail.
+	 * then queue the eh_work and bail.
 	 */
 	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
 		ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, lrbp->lun);
 
 		spin_lock_irqsave(host->host_lock, flags);
 		hba->force_reset = true;
+		ufshcd_schedule_eh_work(hba);
 		spin_unlock_irqrestore(host->host_lock, flags);
-
-		ufshcd_schedule_eh(hba);
-
 		goto release;
 	}
 
@@ -7191,10 +7178,11 @@ static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd)
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->force_reset = true;
+	ufshcd_schedule_eh_work(hba);
 	dev_err(hba->dev, "%s: reset in progress - 1\n", __func__);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
-	ufshcd_err_handler(hba->host);
+	flush_work(&hba->eh_work);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (hba->ufshcd_state == UFSHCD_STATE_ERROR)
@@ -8604,6 +8592,8 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 	if (hba->is_powered) {
 		ufshcd_exit_clk_scaling(hba);
 		ufshcd_exit_clk_gating(hba);
+		if (hba->eh_wq)
+			destroy_workqueue(hba->eh_wq);
 		ufs_debugfs_hba_exit(hba);
 		ufshcd_variant_hba_exit(hba);
 		ufshcd_setup_vreg(hba, false);
@@ -9448,10 +9438,6 @@ static int ufshcd_set_dma_mask(struct ufs_hba *hba)
 	return dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(32));
 }
 
-static struct scsi_transport_template ufshcd_transport_template = {
-	.eh_strategy_handler = ufshcd_err_handler,
-};
-
 /**
  * ufshcd_alloc_host - allocate Host Bus Adapter (HBA)
  * @dev: pointer to device handle
@@ -9478,7 +9464,6 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 		err = -ENOMEM;
 		goto out_error;
 	}
-	host->transportt = &ufshcd_transport_template;
 	hba = shost_priv(host);
 	hba->host = host;
 	hba->dev = dev;
@@ -9518,6 +9503,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	int err;
 	struct Scsi_Host *host = hba->host;
 	struct device *dev = hba->dev;
+	char eh_wq_name[sizeof("ufs_eh_wq_00")];
 
 	if (!mmio_base) {
 		dev_err(hba->dev,
@@ -9571,6 +9557,17 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	hba->max_pwr_info.is_valid = false;
 
+	/* Initialize work queues */
+	snprintf(eh_wq_name, sizeof(eh_wq_name), "ufs_eh_wq_%d",
+		 hba->host->host_no);
+	hba->eh_wq = create_singlethread_workqueue(eh_wq_name);
+	if (!hba->eh_wq) {
+		dev_err(hba->dev, "%s: failed to create eh workqueue\n",
+			__func__);
+		err = -ENOMEM;
+		goto out_disable;
+	}
+	INIT_WORK(&hba->eh_work, ufshcd_err_handler);
 	INIT_WORK(&hba->eeh_work, ufshcd_exception_event_handler);
 
 	sema_init(&hba->host_sem, 1);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 4723f27a55d1..f0da5d3db1fa 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -741,6 +741,8 @@ struct ufs_hba_monitor {
  * @is_powered: flag to check if HBA is powered
  * @shutting_down: flag to check if shutdown has been invoked
  * @host_sem: semaphore used to serialize concurrent contexts
+ * @eh_wq: Workqueue that eh_work works on
+ * @eh_work: Worker to handle UFS errors that require s/w attention
  * @eeh_work: Worker to handle exception events
  * @errors: HBA errors
  * @uic_error: UFS interconnect layer error status
@@ -843,6 +845,8 @@ struct ufs_hba {
 	struct semaphore host_sem;
 
 	/* Work Queues */
+	struct workqueue_struct *eh_wq;
+	struct work_struct eh_work;
 	struct work_struct eeh_work;
 
 	/* HBA Errors */
-- 
2.17.1

