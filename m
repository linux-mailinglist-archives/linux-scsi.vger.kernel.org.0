Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26E423FE36
	for <lists+linux-scsi@lfdr.de>; Sun,  9 Aug 2020 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHIMRK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 9 Aug 2020 08:17:10 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:38113 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgHIMQp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 9 Aug 2020 08:16:45 -0400
IronPort-SDR: PaHjAOEc/LaMYHAw5/uMGJ22FDXXobzZg4L9rumAZNLAl14YSwHevEf31e5anmc2MtcPZO7UF4
 WK56S+ew/c/uK9kqlJCHQO12EIBxhL2GQlifAfi6ySJ1bMgF+9U0x7F1CGlpD4AFMKLNh2p5mD
 KV28spZLr+WtcQWCL/m7wUx++1GobycolSX+ec21GAEcKzHF0ckyRKllRW5TVE1+B0dgJf0KHp
 sExzUs7qtvwZkgmJ7j/q4OgzTj/PCd5Btq+B6YE2QNCXtGk4cO9qHgEBQvxKPoCMygMJ8MXpvR
 vcE=
X-IronPort-AV: E=Sophos;i="5.75,453,1589266800"; 
   d="scan'208";a="29073790"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 09 Aug 2020 05:16:03 -0700
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 09 Aug 2020 05:16:01 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id ECEB32156E; Sun,  9 Aug 2020 05:16:01 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 1/9] scsi: ufs: Add checks before setting clk-gating states
Date:   Sun,  9 Aug 2020 05:15:47 -0700
Message-Id: <1596975355-39813-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596975355-39813-1-git-send-email-cang@codeaurora.org>
References: <1596975355-39813-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Clock gating features can be turned on/off selectively which means its
state information is only important if it is enabled. This change makes
sure that we only look at state of clk-gating if it is enabled.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Hongwu Su <hongwus@codeaurora.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3076222..5acb38c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1839,6 +1839,8 @@ static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 	if (!ufshcd_is_clkgating_allowed(hba))
 		return;
 
+	hba->clk_gating.state = CLKS_ON;
+
 	hba->clk_gating.delay_ms = 150;
 	INIT_DELAYED_WORK(&hba->clk_gating.gate_work, ufshcd_gate_work);
 	INIT_WORK(&hba->clk_gating.ungate_work, ufshcd_ungate_work);
@@ -2541,7 +2543,8 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		err = SCSI_MLQUEUE_HOST_BUSY;
 		goto out;
 	}
-	WARN_ON(hba->clk_gating.state != CLKS_ON);
+	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
+		(hba->clk_gating.state != CLKS_ON));
 
 	lrbp = &hba->lrb[tag];
 
@@ -8326,8 +8329,11 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		/* If link is active, device ref_clk can't be switched off */
 		__ufshcd_setup_clocks(hba, false, true);
 
-	hba->clk_gating.state = CLKS_OFF;
-	trace_ufshcd_clk_gating(dev_name(hba->dev), hba->clk_gating.state);
+	if (ufshcd_is_clkgating_allowed(hba)) {
+		hba->clk_gating.state = CLKS_OFF;
+		trace_ufshcd_clk_gating(dev_name(hba->dev),
+					hba->clk_gating.state);
+	}
 
 	/* Put the host controller in low power mode if possible */
 	ufshcd_hba_vreg_set_lpm(hba);
@@ -8467,6 +8473,11 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (hba->clk_scaling.is_allowed)
 		ufshcd_suspend_clkscaling(hba);
 	ufshcd_setup_clocks(hba, false);
+	if (ufshcd_is_clkgating_allowed(hba)) {
+		hba->clk_gating.state = CLKS_OFF;
+		trace_ufshcd_clk_gating(dev_name(hba->dev),
+					hba->clk_gating.state);
+	}
 out:
 	hba->pm_op_in_progress = 0;
 	if (ret)
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

