Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737F06471E
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfGJNib (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 09:38:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1473 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbfGJNia (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 09:38:30 -0400
X-UUID: 6a28d3545eae47be915b017145822ad8-20190710
X-UUID: 6a28d3545eae47be915b017145822ad8-20190710
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 567317433; Wed, 10 Jul 2019 21:38:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Jul 2019 21:38:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Jul 2019 21:38:24 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <evgreen@chromium.org>, <beanhuo@micron.com>,
        <marc.w.gonzalez@free.fr>, <ygardi@codeaurora.org>,
        <subhashj@codeaurora.org>, <sthumma@codeaurora.org>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3 4/4] scsi: ufs: Add history of fatal events
Date:   Wed, 10 Jul 2019 21:38:21 +0800
Message-ID: <1562765901-18328-5-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562765901-18328-1-git-send-email-stanley.chu@mediatek.com>
References: <1562765901-18328-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently only "interrupt-based" errors have their own history,
however there are some "non-interrupt-based" errors or events
which need history to improve debugging or help know the health
status of UFS devices.

Example of fatal errors,
- Link startup error
- Suspend error
- Resume error

Example of abnormal events,
- Task or request abort
- Device reset (now equals to Logical Unit Reset)
- Host reset

This patch tries to track above errors and events by existed UFS error
history mechanism.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 46 +++++++++++++++++++++++++++++----------
 drivers/scsi/ufs/ufshcd.h | 18 +++++++++++++--
 2 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a46c3d2b2ea3..8f0426a36b0b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -429,9 +429,17 @@ static void ufshcd_print_host_regs(struct ufs_hba *hba)
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.nl_err, "nl_err");
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.tl_err, "tl_err");
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.dme_err, "dme_err");
-	ufshcd_print_err_hist(hba, &hba->ufs_stats.fatal_err, "fatal_err");
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.auto_hibern8_err,
 			      "auto_hibern8_err");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.fatal_err, "fatal_err");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.link_startup_err,
+			      "link_startup_fail");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.resume_err, "resume_fail");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.suspend_err,
+			      "suspend_fail");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.dev_reset, "dev_reset");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.host_reset, "host_reset");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.task_abort, "task_abort");
 
 	ufshcd_print_clk_freqs(hba);
 
@@ -4329,6 +4337,14 @@ static inline int ufshcd_disable_device_tx_lcc(struct ufs_hba *hba)
 	return ufshcd_disable_tx_lcc(hba, true);
 }
 
+static void ufshcd_update_reg_hist(struct ufs_err_reg_hist *reg_hist,
+				   u32 reg)
+{
+	reg_hist->reg[reg_hist->pos] = reg;
+	reg_hist->tstamp[reg_hist->pos] = ktime_get();
+	reg_hist->pos = (reg_hist->pos + 1) % UFS_ERR_REG_HIST_LENGTH;
+}
+
 /**
  * ufshcd_link_startup - Initialize unipro link startup
  * @hba: per adapter instance
@@ -4356,6 +4372,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 
 		/* check if device is detected by inter-connect layer */
 		if (!ret && !ufshcd_is_device_present(hba)) {
+			ufshcd_update_reg_hist(&hba->ufs_stats.link_startup_err,
+					       0);
 			dev_err(hba->dev, "%s: Device not present\n", __func__);
 			ret = -ENXIO;
 			goto out;
@@ -4366,13 +4384,19 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 		 * but we can't be sure if the link is up until link startup
 		 * succeeds. So reset the local Uni-Pro and try again.
 		 */
-		if (ret && ufshcd_hba_enable(hba))
+		if (ret && ufshcd_hba_enable(hba)) {
+			ufshcd_update_reg_hist(&hba->ufs_stats.link_startup_err,
+					       (u32)ret);
 			goto out;
+		}
 	} while (ret && retries--);
 
-	if (ret)
+	if (ret) {
 		/* failed to get the link up... retire */
+		ufshcd_update_reg_hist(&hba->ufs_stats.link_startup_err,
+				       (u32)ret);
 		goto out;
+	}
 
 	if (link_startup_again) {
 		link_startup_again = false;
@@ -5350,14 +5374,6 @@ static void ufshcd_err_handler(struct work_struct *work)
 	pm_runtime_put_sync(hba->dev);
 }
 
-static void ufshcd_update_reg_hist(struct ufs_err_reg_hist *reg_hist,
-				   u32 reg)
-{
-	reg_hist->reg[reg_hist->pos] = reg;
-	reg_hist->tstamp[reg_hist->pos] = ktime_get();
-	reg_hist->pos = (reg_hist->pos + 1) % UFS_ERR_REG_HIST_LENGTH;
-}
-
 /**
  * ufshcd_update_uic_error - check and set fatal UIC error flags.
  * @hba: per-adapter instance
@@ -5950,6 +5966,7 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 
 out:
 	hba->req_abort_count = 0;
+	ufshcd_update_reg_hist(&hba->ufs_stats.dev_reset, (u32)err);
 	if (!err) {
 		err = SUCCESS;
 	} else {
@@ -6043,6 +6060,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 */
 	scsi_print_command(hba->lrb[tag].cmd);
 	if (!hba->req_abort_count) {
+		ufshcd_update_reg_hist(&hba->ufs_stats.task_abort, 0);
 		ufshcd_print_host_regs(hba);
 		ufshcd_print_host_state(hba);
 		ufshcd_print_pwr_info(hba);
@@ -6178,7 +6196,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 out:
 	if (err)
 		dev_err(hba->dev, "%s: Host init failed %d\n", __func__, err);
-
+	ufshcd_update_reg_hist(&hba->ufs_stats.host_reset, (u32)err);
 	return err;
 }
 
@@ -7819,6 +7837,8 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ufshcd_release(hba);
 out:
 	hba->pm_op_in_progress = 0;
+	if (ret)
+		ufshcd_update_reg_hist(&hba->ufs_stats.suspend_err, (u32)ret);
 	return ret;
 }
 
@@ -7921,6 +7941,8 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ufshcd_setup_clocks(hba, false);
 out:
 	hba->pm_op_in_progress = 0;
+	if (ret)
+		ufshcd_update_reg_hist(&hba->ufs_stats.resume_err, (u32)ret);
 	return ret;
 }
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index c6ec5c749ceb..a43c7135f33d 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -436,8 +436,14 @@ struct ufs_err_reg_hist {
  * @nl_err: tracks nl-uic errors
  * @tl_err: tracks tl-uic errors
  * @dme_err: tracks dme errors
- * @fatal_err: tracks fatal errors
  * @auto_hibern8_err: tracks auto-hibernate errors
+ * @fatal_err: tracks fatal errors
+ * @linkup_err: tracks link-startup errors
+ * @resume_err: tracks resume errors
+ * @suspend_err: tracks suspend errors
+ * @dev_reset: tracks device reset events
+ * @host_reset: tracks host reset events
+ * @tsk_abort: tracks task abort events
  */
 struct ufs_stats {
 	u32 hibern8_exit_cnt;
@@ -451,8 +457,16 @@ struct ufs_stats {
 	struct ufs_err_reg_hist dme_err;
 
 	/* fatal errors */
-	struct ufs_err_reg_hist fatal_err;
 	struct ufs_err_reg_hist auto_hibern8_err;
+	struct ufs_err_reg_hist fatal_err;
+	struct ufs_err_reg_hist link_startup_err;
+	struct ufs_err_reg_hist resume_err;
+	struct ufs_err_reg_hist suspend_err;
+
+	/* abnormal events */
+	struct ufs_err_reg_hist dev_reset;
+	struct ufs_err_reg_hist host_reset;
+	struct ufs_err_reg_hist task_abort;
 };
 
 /**
-- 
2.18.0

