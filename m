Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623892CEB6B
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 10:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbgLDJva (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 04:51:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34563 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387943AbgLDJva (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Dec 2020 04:51:30 -0500
X-UUID: 902dbe041348442a95987fa5f3a24b80-20201204
X-UUID: 902dbe041348442a95987fa5f3a24b80-20201204
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1510284807; Fri, 04 Dec 2020 17:50:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 17:50:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 17:50:06 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, <chaotian.jing@mediatek.com>,
        <cc.chou@mediatek.com>, <jiajie.hao@mediatek.com>,
        <alice.chao@mediatek.com>, <huadian.liu@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3 6/8] scsi: ufs: Refine error history functions
Date:   Fri, 4 Dec 2020 17:50:05 +0800
Message-ID: <20201204095007.20639-7-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201204095007.20639-1-stanley.chu@mediatek.com>
References: <20201204095007.20639-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8A6DE03B4DACEDEA79F46C1EA18A0D050E89DE2D2BC68B966F9F642A3C73531A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Nowadays UFS error history does not only have "history of errors"
but also have history of some other events which are not defined
as errors.

This patch fixes the confused naming of related functions,
and change the way for updating and printing history as preparation
of next patch.

This patch shall not change any functionality.

Reviewed-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 118 +++++++++++++++++++++-----------------
 drivers/scsi/ufs/ufshcd.h |  71 ++++++++++-------------
 2 files changed, 97 insertions(+), 92 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 922d68bca345..1a7d31849511 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -411,20 +411,25 @@ static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
 	}
 }
 
-static void ufshcd_print_err_hist(struct ufs_hba *hba,
-				  struct ufs_err_reg_hist *err_hist,
-				  char *err_name)
+static void ufshcd_print_evt(struct ufs_hba *hba, u32 id,
+			     char *err_name)
 {
 	int i;
 	bool found = false;
+	struct ufs_event_hist *e;
 
-	for (i = 0; i < UFS_ERR_REG_HIST_LENGTH; i++) {
-		int p = (i + err_hist->pos) % UFS_ERR_REG_HIST_LENGTH;
+	if (id >= UFS_EVT_CNT)
+		return;
+
+	e = &hba->ufs_stats.event[id];
 
-		if (err_hist->tstamp[p] == 0)
+	for (i = 0; i < UFS_EVENT_HIST_LENGTH; i++) {
+		int p = (i + e->pos) % UFS_EVENT_HIST_LENGTH;
+
+		if (e->tstamp[p] == 0)
 			continue;
 		dev_err(hba->dev, "%s[%d] = 0x%x at %lld us\n", err_name, p,
-			err_hist->reg[p], ktime_to_us(err_hist->tstamp[p]));
+			e->val[p], ktime_to_us(e->tstamp[p]));
 		found = true;
 	}
 
@@ -432,26 +437,26 @@ static void ufshcd_print_err_hist(struct ufs_hba *hba,
 		dev_err(hba->dev, "No record of %s\n", err_name);
 }
 
-static void ufshcd_print_host_regs(struct ufs_hba *hba)
+static void ufshcd_print_evt_hist(struct ufs_hba *hba)
 {
 	ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
 
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.pa_err, "pa_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.dl_err, "dl_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.nl_err, "nl_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.tl_err, "tl_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.dme_err, "dme_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.auto_hibern8_err,
-			      "auto_hibern8_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.fatal_err, "fatal_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.link_startup_err,
-			      "link_startup_fail");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.resume_err, "resume_fail");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.suspend_err,
-			      "suspend_fail");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.dev_reset, "dev_reset");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.host_reset, "host_reset");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.task_abort, "task_abort");
+	ufshcd_print_evt(hba, UFS_EVT_PA_ERR, "pa_err");
+	ufshcd_print_evt(hba, UFS_EVT_DL_ERR, "dl_err");
+	ufshcd_print_evt(hba, UFS_EVT_NL_ERR, "nl_err");
+	ufshcd_print_evt(hba, UFS_EVT_TL_ERR, "tl_err");
+	ufshcd_print_evt(hba, UFS_EVT_DME_ERR, "dme_err");
+	ufshcd_print_evt(hba, UFS_EVT_AUTO_HIBERN8_ERR,
+			 "auto_hibern8_err");
+	ufshcd_print_evt(hba, UFS_EVT_FATAL_ERR, "fatal_err");
+	ufshcd_print_evt(hba, UFS_EVT_LINK_STARTUP_FAIL,
+			 "link_startup_fail");
+	ufshcd_print_evt(hba, UFS_EVT_RESUME_ERR, "resume_fail");
+	ufshcd_print_evt(hba, UFS_EVT_SUSPEND_ERR,
+			 "suspend_fail");
+	ufshcd_print_evt(hba, UFS_EVT_DEV_RESET, "dev_reset");
+	ufshcd_print_evt(hba, UFS_EVT_HOST_RESET, "host_reset");
+	ufshcd_print_evt(hba, UFS_EVT_ABORT, "task_abort");
 
 	ufshcd_vops_dbg_register_dump(hba);
 }
@@ -3852,7 +3857,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	if (ret) {
 		ufshcd_print_host_state(hba);
 		ufshcd_print_pwr_info(hba);
-		ufshcd_print_host_regs(hba);
+		ufshcd_print_evt_hist(hba);
 	}
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -4464,14 +4469,19 @@ static inline int ufshcd_disable_device_tx_lcc(struct ufs_hba *hba)
 	return ufshcd_disable_tx_lcc(hba, true);
 }
 
-void ufshcd_update_reg_hist(struct ufs_err_reg_hist *reg_hist,
-			    u32 reg)
+void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val)
 {
-	reg_hist->reg[reg_hist->pos] = reg;
-	reg_hist->tstamp[reg_hist->pos] = ktime_get();
-	reg_hist->pos = (reg_hist->pos + 1) % UFS_ERR_REG_HIST_LENGTH;
+	struct ufs_event_hist *e;
+
+	if (id >= UFS_EVT_CNT)
+		return;
+
+	e = &hba->ufs_stats.event[id];
+	e->val[e->pos] = val;
+	e->tstamp[e->pos] = ktime_get();
+	e->pos = (e->pos + 1) % UFS_EVENT_HIST_LENGTH;
 }
-EXPORT_SYMBOL_GPL(ufshcd_update_reg_hist);
+EXPORT_SYMBOL_GPL(ufshcd_update_evt_hist);
 
 /**
  * ufshcd_link_startup - Initialize unipro link startup
@@ -4500,7 +4510,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 
 		/* check if device is detected by inter-connect layer */
 		if (!ret && !ufshcd_is_device_present(hba)) {
-			ufshcd_update_reg_hist(&hba->ufs_stats.link_startup_err,
+			ufshcd_update_evt_hist(hba,
+					       UFS_EVT_LINK_STARTUP_FAIL,
 					       0);
 			dev_err(hba->dev, "%s: Device not present\n", __func__);
 			ret = -ENXIO;
@@ -4513,7 +4524,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 		 * succeeds. So reset the local Uni-Pro and try again.
 		 */
 		if (ret && ufshcd_hba_enable(hba)) {
-			ufshcd_update_reg_hist(&hba->ufs_stats.link_startup_err,
+			ufshcd_update_evt_hist(hba,
+					       UFS_EVT_LINK_STARTUP_FAIL,
 					       (u32)ret);
 			goto out;
 		}
@@ -4521,7 +4533,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 
 	if (ret) {
 		/* failed to get the link up... retire */
-		ufshcd_update_reg_hist(&hba->ufs_stats.link_startup_err,
+		ufshcd_update_evt_hist(hba,
+				       UFS_EVT_LINK_STARTUP_FAIL,
 				       (u32)ret);
 		goto out;
 	}
@@ -4555,7 +4568,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 		dev_err(hba->dev, "link startup failed %d\n", ret);
 		ufshcd_print_host_state(hba);
 		ufshcd_print_pwr_info(hba);
-		ufshcd_print_host_regs(hba);
+		ufshcd_print_evt_hist(hba);
 	}
 	return ret;
 }
@@ -4910,7 +4923,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		dev_err(hba->dev,
 				"OCS error from controller = %x for tag %d\n",
 				ocs, lrbp->task_tag);
-		ufshcd_print_host_regs(hba);
+		ufshcd_print_evt_hist(hba);
 		ufshcd_print_host_state(hba);
 		break;
 	} /* end of switch */
@@ -5792,7 +5805,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 		ufshcd_print_host_state(hba);
 		ufshcd_print_pwr_info(hba);
-		ufshcd_print_host_regs(hba);
+		ufshcd_print_evt_hist(hba);
 		ufshcd_print_tmrs(hba, hba->outstanding_tasks);
 		ufshcd_print_trs(hba, hba->outstanding_reqs, pr_prdt);
 		spin_lock_irqsave(hba->host->host_lock, flags);
@@ -5937,7 +5950,7 @@ static irqreturn_t ufshcd_update_uic_error(struct ufs_hba *hba)
 	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER);
 	if ((reg & UIC_PHY_ADAPTER_LAYER_ERROR) &&
 	    (reg & UIC_PHY_ADAPTER_LAYER_ERROR_CODE_MASK)) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.pa_err, reg);
+		ufshcd_update_evt_hist(hba, UFS_EVT_PA_ERR, reg);
 		/*
 		 * To know whether this error is fatal or not, DB timeout
 		 * must be checked but this error is handled separately.
@@ -5967,7 +5980,7 @@ static irqreturn_t ufshcd_update_uic_error(struct ufs_hba *hba)
 	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_DATA_LINK_LAYER);
 	if ((reg & UIC_DATA_LINK_LAYER_ERROR) &&
 	    (reg & UIC_DATA_LINK_LAYER_ERROR_CODE_MASK)) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.dl_err, reg);
+		ufshcd_update_evt_hist(hba, UFS_EVT_DL_ERR, reg);
 
 		if (reg & UIC_DATA_LINK_LAYER_ERROR_PA_INIT)
 			hba->uic_error |= UFSHCD_UIC_DL_PA_INIT_ERROR;
@@ -5986,7 +5999,7 @@ static irqreturn_t ufshcd_update_uic_error(struct ufs_hba *hba)
 	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_NETWORK_LAYER);
 	if ((reg & UIC_NETWORK_LAYER_ERROR) &&
 	    (reg & UIC_NETWORK_LAYER_ERROR_CODE_MASK)) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.nl_err, reg);
+		ufshcd_update_evt_hist(hba, UFS_EVT_NL_ERR, reg);
 		hba->uic_error |= UFSHCD_UIC_NL_ERROR;
 		retval |= IRQ_HANDLED;
 	}
@@ -5994,7 +6007,7 @@ static irqreturn_t ufshcd_update_uic_error(struct ufs_hba *hba)
 	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_TRANSPORT_LAYER);
 	if ((reg & UIC_TRANSPORT_LAYER_ERROR) &&
 	    (reg & UIC_TRANSPORT_LAYER_ERROR_CODE_MASK)) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.tl_err, reg);
+		ufshcd_update_evt_hist(hba, UFS_EVT_TL_ERR, reg);
 		hba->uic_error |= UFSHCD_UIC_TL_ERROR;
 		retval |= IRQ_HANDLED;
 	}
@@ -6002,7 +6015,7 @@ static irqreturn_t ufshcd_update_uic_error(struct ufs_hba *hba)
 	reg = ufshcd_readl(hba, REG_UIC_ERROR_CODE_DME);
 	if ((reg & UIC_DME_ERROR) &&
 	    (reg & UIC_DME_ERROR_CODE_MASK)) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.dme_err, reg);
+		ufshcd_update_evt_hist(hba, UFS_EVT_DME_ERR, reg);
 		hba->uic_error |= UFSHCD_UIC_DME_ERROR;
 		retval |= IRQ_HANDLED;
 	}
@@ -6044,7 +6057,8 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
 	irqreturn_t retval = IRQ_NONE;
 
 	if (hba->errors & INT_FATAL_ERRORS) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.fatal_err, hba->errors);
+		ufshcd_update_evt_hist(hba, UFS_EVT_FATAL_ERR,
+				       hba->errors);
 		queue_eh_work = true;
 	}
 
@@ -6061,7 +6075,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
 			__func__, (hba->errors & UIC_HIBERNATE_ENTER) ?
 			"Enter" : "Exit",
 			hba->errors, ufshcd_get_upmcrs(hba));
-		ufshcd_update_reg_hist(&hba->ufs_stats.auto_hibern8_err,
+		ufshcd_update_evt_hist(hba, UFS_EVT_AUTO_HIBERN8_ERR,
 				       hba->errors);
 		ufshcd_set_link_broken(hba);
 		queue_eh_work = true;
@@ -6602,7 +6616,7 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 
 out:
 	hba->req_abort_count = 0;
-	ufshcd_update_reg_hist(&hba->ufs_stats.dev_reset, (u32)err);
+	ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, (u32)err);
 	if (!err) {
 		err = SUCCESS;
 	} else {
@@ -6739,7 +6753,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * handling stage: reset and restore.
 	 */
 	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.task_abort, lrbp->lun);
+		ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, lrbp->lun);
 		return ufshcd_eh_host_reset_handler(cmd);
 	}
 
@@ -6765,8 +6779,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 */
 	scsi_print_command(hba->lrb[tag].cmd);
 	if (!hba->req_abort_count) {
-		ufshcd_update_reg_hist(&hba->ufs_stats.task_abort, tag);
-		ufshcd_print_host_regs(hba);
+		ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, tag);
+		ufshcd_print_evt_hist(hba);
 		ufshcd_print_host_state(hba);
 		ufshcd_print_pwr_info(hba);
 		ufshcd_print_trs(hba, 1 << tag, true);
@@ -6849,7 +6863,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 out:
 	if (err)
 		dev_err(hba->dev, "%s: Host init failed %d\n", __func__, err);
-	ufshcd_update_reg_hist(&hba->ufs_stats.host_reset, (u32)err);
+	ufshcd_update_evt_hist(hba, UFS_EVT_HOST_RESET, (u32)err);
 	return err;
 }
 
@@ -8689,7 +8703,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	hba->pm_op_in_progress = 0;
 
 	if (ret)
-		ufshcd_update_reg_hist(&hba->ufs_stats.suspend_err, (u32)ret);
+		ufshcd_update_evt_hist(hba, UFS_EVT_SUSPEND_ERR, (u32)ret);
 	return ret;
 }
 
@@ -8813,7 +8827,7 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 out:
 	hba->pm_op_in_progress = 0;
 	if (ret)
-		ufshcd_update_reg_hist(&hba->ufs_stats.resume_err, (u32)ret);
+		ufshcd_update_evt_hist(hba, UFS_EVT_RESUME_ERR, (u32)ret);
 	return ret;
 }
 
@@ -9265,7 +9279,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	err = ufshcd_hba_enable(hba);
 	if (err) {
 		dev_err(hba->dev, "Host controller enable failed\n");
-		ufshcd_print_host_regs(hba);
+		ufshcd_print_evt_hist(hba);
 		ufshcd_print_host_state(hba);
 		goto free_tmf_queue;
 	}
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 384a042ccb46..b55a71c10fa6 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -58,6 +58,29 @@ enum dev_cmd_type {
 	DEV_CMD_TYPE_QUERY		= 0x1,
 };
 
+enum ufs_event_type {
+	/* uic specific errors */
+	UFS_EVT_PA_ERR = 0,
+	UFS_EVT_DL_ERR,
+	UFS_EVT_NL_ERR,
+	UFS_EVT_TL_ERR,
+	UFS_EVT_DME_ERR,
+
+	/* fatal errors */
+	UFS_EVT_AUTO_HIBERN8_ERR,
+	UFS_EVT_FATAL_ERR,
+	UFS_EVT_LINK_STARTUP_FAIL,
+	UFS_EVT_RESUME_ERR,
+	UFS_EVT_SUSPEND_ERR,
+
+	/* abnormal events */
+	UFS_EVT_DEV_RESET,
+	UFS_EVT_HOST_RESET,
+	UFS_EVT_ABORT,
+
+	UFS_EVT_CNT,
+};
+
 /**
  * struct uic_command - UIC command structure
  * @command: UIC command
@@ -409,17 +432,17 @@ struct ufs_clk_scaling {
 	bool is_suspended;
 };
 
-#define UFS_ERR_REG_HIST_LENGTH 8
+#define UFS_EVENT_HIST_LENGTH 8
 /**
- * struct ufs_err_reg_hist - keeps history of errors
+ * struct ufs_event_hist - keeps history of errors
  * @pos: index to indicate cyclic buffer position
  * @reg: cyclic buffer for registers value
  * @tstamp: cyclic buffer for time stamp
  */
-struct ufs_err_reg_hist {
+struct ufs_event_hist {
 	int pos;
-	u32 reg[UFS_ERR_REG_HIST_LENGTH];
-	ktime_t tstamp[UFS_ERR_REG_HIST_LENGTH];
+	u32 val[UFS_EVENT_HIST_LENGTH];
+	ktime_t tstamp[UFS_EVENT_HIST_LENGTH];
 };
 
 /**
@@ -430,19 +453,6 @@ struct ufs_err_reg_hist {
  *		reset this after link-startup.
  * @last_hibern8_exit_tstamp: Set time after the hibern8 exit.
  *		Clear after the first successful command completion.
- * @pa_err: tracks pa-uic errors
- * @dl_err: tracks dl-uic errors
- * @nl_err: tracks nl-uic errors
- * @tl_err: tracks tl-uic errors
- * @dme_err: tracks dme errors
- * @auto_hibern8_err: tracks auto-hibernate errors
- * @fatal_err: tracks fatal errors
- * @linkup_err: tracks link-startup errors
- * @resume_err: tracks resume errors
- * @suspend_err: tracks suspend errors
- * @dev_reset: tracks device reset events
- * @host_reset: tracks host reset events
- * @tsk_abort: tracks task abort events
  */
 struct ufs_stats {
 	u32 last_intr_status;
@@ -450,25 +460,7 @@ struct ufs_stats {
 
 	u32 hibern8_exit_cnt;
 	ktime_t last_hibern8_exit_tstamp;
-
-	/* uic specific errors */
-	struct ufs_err_reg_hist pa_err;
-	struct ufs_err_reg_hist dl_err;
-	struct ufs_err_reg_hist nl_err;
-	struct ufs_err_reg_hist tl_err;
-	struct ufs_err_reg_hist dme_err;
-
-	/* fatal errors */
-	struct ufs_err_reg_hist auto_hibern8_err;
-	struct ufs_err_reg_hist fatal_err;
-	struct ufs_err_reg_hist link_startup_err;
-	struct ufs_err_reg_hist resume_err;
-	struct ufs_err_reg_hist suspend_err;
-
-	/* abnormal events */
-	struct ufs_err_reg_hist dev_reset;
-	struct ufs_err_reg_hist host_reset;
-	struct ufs_err_reg_hist task_abort;
+	struct ufs_event_hist event[UFS_EVT_CNT];
 };
 
 enum ufshcd_quirks {
@@ -912,8 +904,7 @@ int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
 				u32 val, unsigned long interval_us,
 				unsigned long timeout_ms);
 void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk);
-void ufshcd_update_reg_hist(struct ufs_err_reg_hist *reg_hist,
-			    u32 reg);
+void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
 
 static inline void check_upiu_size(void)
 {
@@ -1219,7 +1210,7 @@ static inline void ufshcd_vops_device_reset(struct ufs_hba *hba)
 		if (!err)
 			ufshcd_set_ufs_dev_active(hba);
 		if (err != -EOPNOTSUPP)
-			ufshcd_update_reg_hist(&hba->ufs_stats.dev_reset, err);
+			ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err);
 	}
 }
 
-- 
2.18.0

