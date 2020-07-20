Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0E2257D9
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 08:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGTGgQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Jul 2020 02:36:16 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:25378 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGTGgP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Jul 2020 02:36:15 -0400
IronPort-SDR: hXgtaggXXP3eodIe9el3Zs4QZSbkBoH8Iw15ywU7y+AczReFOSRw6RqmcZLXPAQC3wK8lh/6r4
 WQo48WOzZtP/oECEUe8c9U+LhcTW8kAZ5VA3ccL+UPDE7AsQAcb3GONMqXobL54Kz6VwwYxTiw
 Jasd0SSfNeERYRb7yJM055O+ZdhVCfW+ANntTEJfKcpDKgGfx+t4Acq8nZzcSVcuEQL1elawgV
 iWkR97B2rg1/qs8XOx3YjrK6w/RTDzJBbJvXS/TVseEOiN/qjthBvEVBb52/jrO8lMluge4spH
 dD4=
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="29044591"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 19 Jul 2020 23:36:14 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg04-sd.qualcomm.com with ESMTP; 19 Jul 2020 23:36:14 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id 1E09E22DA5; Sun, 19 Jul 2020 23:36:14 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        sh425.lee@samsung.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/8] scsi: ufs: Add some debug infos to ufshcd_print_host_state
Date:   Sun, 19 Jul 2020 23:35:51 -0700
Message-Id: <1595226956-7779-5-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595226956-7779-1-git-send-email-cang@codeaurora.org>
References: <1595226956-7779-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The infos of the last interrupt status and its timestamp are very helpful
when debug system stability issues, e.g. IRQ starvation, so add them to
ufshcd_print_host_state. Meanwhile, UFS device infos like model name and
its FW version also come in handy during debug. In addition, this change
makes cleanup to some prints in ufshcd_print_host_regs as similar prints
are already available in ufshcd_print_host_state.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 31 ++++++++++++++++++-------------
 drivers/scsi/ufs/ufshcd.h |  5 +++++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2907828..a22414b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -411,15 +411,6 @@ static void ufshcd_print_err_hist(struct ufs_hba *hba,
 static void ufshcd_print_host_regs(struct ufs_hba *hba)
 {
 	ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
-	dev_err(hba->dev, "hba->ufs_version = 0x%x, hba->capabilities = 0x%x\n",
-		hba->ufs_version, hba->capabilities);
-	dev_err(hba->dev,
-		"hba->outstanding_reqs = 0x%x, hba->outstanding_tasks = 0x%x\n",
-		(u32)hba->outstanding_reqs, (u32)hba->outstanding_tasks);
-	dev_err(hba->dev,
-		"last_hibern8_exit_tstamp at %lld us, hibern8_exit_cnt = %d\n",
-		ktime_to_us(hba->ufs_stats.last_hibern8_exit_tstamp),
-		hba->ufs_stats.hibern8_exit_cnt);
 
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.pa_err, "pa_err");
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.dl_err, "dl_err");
@@ -438,8 +429,6 @@ static void ufshcd_print_host_regs(struct ufs_hba *hba)
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.host_reset, "host_reset");
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.task_abort, "task_abort");
 
-	ufshcd_print_clk_freqs(hba);
-
 	ufshcd_vops_dbg_register_dump(hba);
 }
 
@@ -499,6 +488,8 @@ static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
 
 static void ufshcd_print_host_state(struct ufs_hba *hba)
 {
+	struct scsi_device *sdev_ufs = hba->sdev_ufs_device;
+
 	dev_err(hba->dev, "UFS Host state=%d\n", hba->ufshcd_state);
 	dev_err(hba->dev, "outstanding reqs=0x%lx tasks=0x%lx\n",
 		hba->outstanding_reqs, hba->outstanding_tasks);
@@ -511,12 +502,24 @@ static void ufshcd_print_host_state(struct ufs_hba *hba)
 	dev_err(hba->dev, "Auto BKOPS=%d, Host self-block=%d\n",
 		hba->auto_bkops_enabled, hba->host->host_self_blocked);
 	dev_err(hba->dev, "Clk gate=%d\n", hba->clk_gating.state);
+	dev_err(hba->dev,
+		"last_hibern8_exit_tstamp at %lld us, hibern8_exit_cnt=%d\n",
+		ktime_to_us(hba->ufs_stats.last_hibern8_exit_tstamp),
+		hba->ufs_stats.hibern8_exit_cnt);
+	dev_err(hba->dev, "last intr at %lld us, last intr status=0x%x\n",
+		ktime_to_us(hba->ufs_stats.last_intr_ts),
+		hba->ufs_stats.last_intr_status);
 	dev_err(hba->dev, "error handling flags=0x%x, req. abort count=%d\n",
 		hba->eh_flags, hba->req_abort_count);
-	dev_err(hba->dev, "Host capabilities=0x%x, caps=0x%x\n",
-		hba->capabilities, hba->caps);
+	dev_err(hba->dev, "hba->ufs_version=0x%x, Host capabilities=0x%x, caps=0x%x\n",
+		hba->ufs_version, hba->capabilities, hba->caps);
 	dev_err(hba->dev, "quirks=0x%x, dev. quirks=0x%x\n", hba->quirks,
 		hba->dev_quirks);
+	if (sdev_ufs)
+		dev_err(hba->dev, "UFS dev info: %.8s %.16s rev %.4s\n",
+			sdev_ufs->vendor, sdev_ufs->model, sdev_ufs->rev);
+
+	ufshcd_print_clk_freqs(hba);
 }
 
 /**
@@ -5951,6 +5954,8 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 
 	spin_lock(hba->host->host_lock);
 	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
+	hba->ufs_stats.last_intr_status = intr_status;
+	hba->ufs_stats.last_intr_ts = ktime_get();
 
 	/*
 	 * There could be max of hba->nutrs reqs in flight and in worst case
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 656c069..5b2cdaf 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -406,6 +406,8 @@ struct ufs_err_reg_hist {
 
 /**
  * struct ufs_stats - keeps usage/err statistics
+ * @last_intr_status: record the last interrupt status.
+ * @last_intr_ts: record the last interrupt timestamp.
  * @hibern8_exit_cnt: Counter to keep track of number of exits,
  *		reset this after link-startup.
  * @last_hibern8_exit_tstamp: Set time after the hibern8 exit.
@@ -425,6 +427,9 @@ struct ufs_err_reg_hist {
  * @tsk_abort: tracks task abort events
  */
 struct ufs_stats {
+	u32 last_intr_status;
+	ktime_t last_intr_ts;
+
 	u32 hibern8_exit_cnt;
 	ktime_t last_hibern8_exit_tstamp;
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

