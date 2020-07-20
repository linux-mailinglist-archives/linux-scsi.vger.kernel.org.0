Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49D22257DF
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 08:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGTGge (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Jul 2020 02:36:34 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:7802 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgGTGge (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Jul 2020 02:36:34 -0400
IronPort-SDR: w9b4HOP1wGMxuQmQ0jEn/cBYRUbt9ArG/95B2CyxNLpctjsZ77RD/JYyHg3m4cuQXWGLJ6E+Qe
 Tj5QzWFBT+6M2JQ4Ss1wNL33B2DKPaPL/8YIZCer5/VCsDKtuYQj7oIUiy+ctYiADIHfkLRNOt
 w8pTiicp5sT/6/FZBqj8eNsALl3rYI7qXQo4O+CaV895Zn6T70RV2tWaOehhnnvJ79WAdr50xc
 ibjMvEjzrWIeMPaFeMpSojVXekZIdoSSFHO9aNQII8G+6eknm48sn7IRZMUDVsUIjgZUla7FJk
 +JU=
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="47226984"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 19 Jul 2020 23:36:34 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg03-sd.qualcomm.com with ESMTP; 19 Jul 2020 23:36:33 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id B00CD22DA5; Sun, 19 Jul 2020 23:36:33 -0700 (PDT)
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
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 7/8] scsi: ufs: Move dumps in IRQ handler to error handler
Date:   Sun, 19 Jul 2020 23:35:54 -0700
Message-Id: <1595226956-7779-8-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595226956-7779-1-git-send-email-cang@codeaurora.org>
References: <1595226956-7779-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sometime dumps in IRQ handler are heavy enough to cause system stability
issues, move them to error handler.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 68705a1..ae78d5d 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5681,6 +5681,21 @@ static void ufshcd_err_handler(struct work_struct *work)
 				    UFSHCD_UIC_DL_TCx_REPLAY_ERROR))))
 		needs_reset = true;
 
+	if (hba->saved_err & (INT_FATAL_ERRORS | UIC_ERROR |
+			      UFSHCD_UIC_HIBERN8_MASK)) {
+		bool pr_prdt = !!(hba->saved_err & SYSTEM_BUS_FATAL_ERROR);
+
+		dev_err(hba->dev, "%s: saved_err 0x%x saved_uic_err 0x%x\n",
+				__func__, hba->saved_err, hba->saved_uic_err);
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		ufshcd_print_host_state(hba);
+		ufshcd_print_pwr_info(hba);
+		ufshcd_print_host_regs(hba);
+		ufshcd_print_tmrs(hba, hba->outstanding_tasks);
+		ufshcd_print_trs(hba, hba->outstanding_reqs, pr_prdt);
+		spin_lock_irqsave(hba->host->host_lock, flags);
+	}
+
 	/*
 	 * if host reset is required then skip clearing the pending
 	 * transfers forcefully because they will get cleared during
@@ -5899,22 +5914,6 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
 
 		/* block commands from scsi mid-layer */
 		ufshcd_scsi_block_requests(hba);
-
-		/* dump controller state before resetting */
-		if (hba->saved_err & (INT_FATAL_ERRORS | UIC_ERROR)) {
-			bool pr_prdt = !!(hba->saved_err &
-					SYSTEM_BUS_FATAL_ERROR);
-
-			dev_err(hba->dev, "%s: saved_err 0x%x saved_uic_err 0x%x\n",
-					__func__, hba->saved_err,
-					hba->saved_uic_err);
-
-			ufshcd_print_host_regs(hba);
-			ufshcd_print_pwr_info(hba);
-			ufshcd_print_tmrs(hba, hba->outstanding_tasks);
-			ufshcd_print_trs(hba, hba->outstanding_reqs,
-					pr_prdt);
-		}
 		ufshcd_schedule_eh_work(hba);
 		retval |= IRQ_HANDLED;
 	}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

