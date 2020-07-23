Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6322A559
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Jul 2020 04:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbgGWCey (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jul 2020 22:34:54 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:1953 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgGWCey (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Jul 2020 22:34:54 -0400
IronPort-SDR: 4YMtuW61e2WoCBKgqyINgBtiI4yCbohLK63H0C/kmrEdBdrAPmBAbYVuTHVdxEamCPOJyDRjMt
 A1HX/6UspjFgPpm68KIly3g5J4U3IBY0fH2LesAJCT4FKPb8OaR/fptkzwdjhONYHDyUKQxk/d
 M2qdReeJWxfnXz8DAJVov96SkN+2VWVfKAJv6uxTqbcWQkZUqiJnIXY/HhX9odJ2+6LP48w25w
 jJcAy9tzOyBEClJhtkOQnlv4jlm3EVYYLNl29Bms34GEPvx4g/NqWsDirlAaSe2cNwLTkuPWM+
 6xo=
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="29047798"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 22 Jul 2020 19:34:53 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg04-sd.qualcomm.com with ESMTP; 22 Jul 2020 19:34:52 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id 6101C22A4D; Wed, 22 Jul 2020 19:34:52 -0700 (PDT)
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
Subject: [PATCH v5 9/9] scsi: ufs: Fix a racing problem btw error handler and runtime PM ops
Date:   Wed, 22 Jul 2020 19:34:08 -0700
Message-Id: <1595471649-25675-10-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595471649-25675-1-git-send-email-cang@codeaurora.org>
References: <1595471649-25675-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Current IRQ handler blocks scsi requests before scheduling eh_work, when
error handler calls pm_runtime_get_sync, if ufshcd_suspend/resume sends a
scsi cmd, most likely the SSU cmd, since scsi requests are blocked,
pm_runtime_get_sync() will never return because ufshcd_suspend/reusme is
blocked by the scsi cmd. Some changes and code re-arrangement can be made
to resolve it.

o In queuecommand path, hba->ufshcd_state check and ufshcd_send_command
  should stay into the same spin lock. This is to make sure that no more
  commands leak into doorbell after hba->ufshcd_state is changed.
o Don't block scsi requests before scheduling eh_work, let error handler
  block scsi requests when it is ready to start error recovery.
o Don't let scsi layer keep requeuing the scsi cmds sent from hba runtime
  PM ops, let them pass or fail them. Let them pass if eh_work is scheduled
  due to non-fatal errors. Fail them fail if eh_work is scheduled due to
  fatal errors, otherwise the cmds may eventually time out since UFS is in
  bad state, which gets error handler blocked for too long. If we fail the
  scsi cmds sent from hba runtime PM ops, hba runtime PM ops fails too, but
  it does not hurt since error handler can recover hba runtime PM error.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 84 +++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index ae78d5d..e9d8c4f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -126,7 +126,8 @@ enum {
 	UFSHCD_STATE_RESET,
 	UFSHCD_STATE_ERROR,
 	UFSHCD_STATE_OPERATIONAL,
-	UFSHCD_STATE_EH_SCHEDULED,
+	UFSHCD_STATE_EH_SCHEDULED_FATAL,
+	UFSHCD_STATE_EH_SCHEDULED_NON_FATAL,
 };
 
 /* UFSHCD error handling flags */
@@ -2515,34 +2516,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	if (!down_read_trylock(&hba->clk_scaling_lock))
 		return SCSI_MLQUEUE_HOST_BUSY;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	switch (hba->ufshcd_state) {
-	case UFSHCD_STATE_OPERATIONAL:
-		break;
-	case UFSHCD_STATE_EH_SCHEDULED:
-	case UFSHCD_STATE_RESET:
-		err = SCSI_MLQUEUE_HOST_BUSY;
-		goto out_unlock;
-	case UFSHCD_STATE_ERROR:
-		set_host_byte(cmd, DID_ERROR);
-		cmd->scsi_done(cmd);
-		goto out_unlock;
-	default:
-		dev_WARN_ONCE(hba->dev, 1, "%s: invalid state %d\n",
-				__func__, hba->ufshcd_state);
-		set_host_byte(cmd, DID_BAD_TARGET);
-		cmd->scsi_done(cmd);
-		goto out_unlock;
-	}
-
-	/* if error handling is in progress, don't issue commands */
-	if (ufshcd_eh_in_progress(hba)) {
-		set_host_byte(cmd, DID_ERROR);
-		cmd->scsi_done(cmd);
-		goto out_unlock;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
 	hba->req_abort_count = 0;
 
 	err = ufshcd_hold(hba, true);
@@ -2578,11 +2551,50 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	/* Make sure descriptors are ready before ringing the doorbell */
 	wmb();
 
-	/* issue command to the controller */
 	spin_lock_irqsave(hba->host->host_lock, flags);
+	switch (hba->ufshcd_state) {
+	case UFSHCD_STATE_OPERATIONAL:
+	case UFSHCD_STATE_EH_SCHEDULED_NON_FATAL:
+		break;
+	case UFSHCD_STATE_EH_SCHEDULED_FATAL:
+		/*
+		 * If we are here, eh_work is either scheduled or running.
+		 * Before eh_work sets ufshcd_state to STATE_RESET, it flushes
+		 * runtime PM ops by calling pm_runtime_get_sync(). If a scsi
+		 * cmd, e.g. the SSU cmd, is sent by PM ops, it can never be
+		 * finished if we let SCSI layer keep retrying it, which gets
+		 * eh_work stuck forever. Neither can we let it pass, because
+		 * ufs now is not in good status, so the SSU cmd may eventually
+		 * time out, blocking eh_work for too long. So just let it fail.
+		 */
+		if (hba->pm_op_in_progress) {
+			hba->force_reset = true;
+			set_host_byte(cmd, DID_BAD_TARGET);
+			goto out_compl_cmd;
+		}
+	case UFSHCD_STATE_RESET:
+		err = SCSI_MLQUEUE_HOST_BUSY;
+		goto out_compl_cmd;
+	case UFSHCD_STATE_ERROR:
+		set_host_byte(cmd, DID_ERROR);
+		goto out_compl_cmd;
+	default:
+		dev_WARN_ONCE(hba->dev, 1, "%s: invalid state %d\n",
+				__func__, hba->ufshcd_state);
+		set_host_byte(cmd, DID_BAD_TARGET);
+		goto out_compl_cmd;
+	}
 	ufshcd_send_command(hba, tag);
-out_unlock:
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	goto out;
+
+out_compl_cmd:
+	scsi_dma_unmap(lrbp->cmd);
+	lrbp->cmd = NULL;
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ufshcd_release(hba);
+	if (!err)
+		cmd->scsi_done(cmd);
 out:
 	up_read(&hba->clk_scaling_lock);
 	return err;
@@ -5553,7 +5565,11 @@ static inline void ufshcd_schedule_eh_work(struct ufs_hba *hba)
 {
 	/* handle fatal errors only when link is not in error state */
 	if (hba->ufshcd_state != UFSHCD_STATE_ERROR) {
-		hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED;
+		if (hba->force_reset || ufshcd_is_link_broken(hba) ||
+		    ufshcd_is_saved_err_fatal(hba))
+			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_FATAL;
+		else
+			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_NON_FATAL;
 		queue_work(hba->eh_wq, &hba->eh_work);
 	}
 }
@@ -5658,6 +5674,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_err_handler_prepare(hba);
 	spin_lock_irqsave(hba->host->host_lock, flags);
+	ufshcd_scsi_block_requests(hba);
 	hba->ufshcd_state = UFSHCD_STATE_RESET;
 
 	/* Complete requests that have door-bell cleared by h/w */
@@ -5911,9 +5928,6 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
 		 */
 		hba->saved_err |= hba->errors;
 		hba->saved_uic_err |= hba->uic_error;
-
-		/* block commands from scsi mid-layer */
-		ufshcd_scsi_block_requests(hba);
 		ufshcd_schedule_eh_work(hba);
 		retval |= IRQ_HANDLED;
 	}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

