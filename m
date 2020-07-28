Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B02300E9
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Jul 2020 07:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgG1FBe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Jul 2020 01:01:34 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:40291 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgG1FBe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Jul 2020 01:01:34 -0400
IronPort-SDR: Fyk/wJDUDjjzWdiBFt/+P2dQCWjLdDrUiNn2KieoowoCNL8w7opDEe8AdCw96tytJKheze9ibe
 6ezf0QyZeyKpHFjmmGCgobkUKXmlyidetvvR7l8Iffg2x+dKoTMOZXfjMNQZ4zxfFG27dcv7Ce
 DbPuMJ8gwFFzXYhQOGFUf/eJW6P2JuIGwRAeXOOB1sRZ7rQGdKVEPXYUR7BCSX1oJDAWyo9Lgt
 NIwzMpvH7MNqaAe1tVbfHhte6q767m87/CP9zz8gjHlItMAoJmJOZzaEtqD94p9CFyc3ZYIZUI
 QtM=
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="29056444"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by labrats.qualcomm.com with ESMTP; 27 Jul 2020 22:01:33 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg01-sd.qualcomm.com with ESMTP; 27 Jul 2020 22:01:32 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id E4EC622DA6; Mon, 27 Jul 2020 22:01:32 -0700 (PDT)
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
Subject: [PATCH v7 7/8] scsi: ufs: Move dumps in IRQ handler to error handler
Date:   Mon, 27 Jul 2020 22:00:58 -0700
Message-Id: <1595912460-8860-8-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595912460-8860-1-git-send-email-cang@codeaurora.org>
References: <1595912460-8860-1-git-send-email-cang@codeaurora.org>
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
index c480823..b2bafa3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5682,6 +5682,21 @@ static void ufshcd_err_handler(struct work_struct *work)
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
@@ -5900,22 +5915,6 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
 
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

