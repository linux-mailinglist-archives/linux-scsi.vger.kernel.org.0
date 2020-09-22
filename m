Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B0273A4B
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Sep 2020 07:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIVFiv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Sep 2020 01:38:51 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:23288 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIVFiu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Sep 2020 01:38:50 -0400
IronPort-SDR: YRS8wZcoDpLrUC8CTHsFfZfm6FCCD55nYX9x4kcPRAuKnJkS8nf92nwBtF367V9ZI6X/eIR52h
 M7HN6DBtbNnB3wq3Yba93pXaiEm58kXks6RtlZBqEjvfMKuVbd0BdX4EqNstgYK9+P/URpjpTZ
 rUqKxlTjSfM5Lge17CrNi3n/nGp1I1NKS1ZrMzzXlr07xOlg9QKRks8q4u7qEjF9iWbnT14dfi
 ZbwPxs29RtNaF6DU4t6XGSiDo8qhFMia1omLdmCdDp8WVfMZKDdu2gq4XqAir8jiaXR4jRB7cq
 xCM=
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="47332958"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 21 Sep 2020 22:32:46 -0700
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg03-sd.qualcomm.com with ESMTP; 21 Sep 2020 22:32:45 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id EB2A621547; Mon, 21 Sep 2020 22:32:43 -0700 (PDT)
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
Subject: [PATCH v1 2/2] scsi: ufs: Fix a racing problem between ufshcd_abort and eh_work
Date:   Mon, 21 Sep 2020 22:32:26 -0700
Message-Id: <1600752747-31881-3-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600752747-31881-1-git-send-email-cang@codeaurora.org>
References: <1600752747-31881-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In current task abort routine, if task abort happens to the device W-LU,
the code directly jumps to ufshcd_eh_host_reset_handler() to perform a
full reset and restore then returns FAIL or SUCCESS. Commands sent to the
device W-LU are most likely the SSU cmds sent during UFS PM operations. If
such SSU cmd enters task abort routine, when ufshcd_eh_host_reset_handler()
flushes eh_work, there will be racing because err_handler is serialized
with any PM operations.

Since the main idea of aborting one cmd to the device W-LU is to perform
a full reset and restore, in order to resolve the racing problem, we merely
clean up the lrb taken by this cmd, queue the eh_work and abort the cmd.
Since the cmd has been aborted, the PM operation which sends the cmd simply
errors out, thus err_handler will not be blocked by ongoing PM operations
and err_handler can also recover PM error if any, which comes as another
benefit of this change.

Because such cmd is aborted even before it is actually cleared from HW, set
the lrb->in_use flag to prevent subsequent cmds, including SCSI cmds and
dev cmds, from taking the lrb released by this cmd. Flag lrb->in_use shall
evetually be cleared in __ufshcd_transfer_req_compl() invoked by the full
reset and restore from err_handler.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 58 +++++++++++++++++++++++++++++++++++++----------
 drivers/scsi/ufs/ufshcd.h |  2 ++
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 7e764e8..e4cb994 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2539,6 +2539,14 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		(hba->clk_gating.state != CLKS_ON));
 
 	lrbp = &hba->lrb[tag];
+	if (unlikely(lrbp->in_use)) {
+		if (hba->pm_op_in_progress)
+			set_host_byte(cmd, DID_BAD_TARGET);
+		else
+			err = SCSI_MLQUEUE_HOST_BUSY;
+		ufshcd_release(hba);
+		goto out;
+	}
 
 	WARN_ON(lrbp->cmd);
 	lrbp->cmd = cmd;
@@ -2781,6 +2789,11 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	init_completion(&wait);
 	lrbp = &hba->lrb[tag];
+	if (unlikely(lrbp->in_use)) {
+		err = -EBUSY;
+		goto out;
+	}
+
 	WARN_ON(lrbp->cmd);
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
 	if (unlikely(err))
@@ -2797,6 +2810,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
 
+out:
 	ufshcd_add_query_upiu_trace(hba, tag,
 			err ? "query_complete_err" : "query_complete");
 
@@ -4932,6 +4946,7 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 
 	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
 		lrbp = &hba->lrb[index];
+		lrbp->in_use = false;
 		lrbp->compl_time_stamp = ktime_get();
 		cmd = lrbp->cmd;
 		if (cmd) {
@@ -6374,8 +6389,12 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	init_completion(&wait);
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
+	if (unlikely(lrbp->in_use)) {
+		err = -EBUSY;
+		goto out;
+	}
 
+	WARN_ON(lrbp->cmd);
 	lrbp->cmd = NULL;
 	lrbp->sense_bufflen = 0;
 	lrbp->sense_buffer = NULL;
@@ -6447,6 +6466,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 		}
 	}
 
+out:
 	blk_put_request(req);
 out_unlock:
 	up_read(&hba->clk_scaling_lock);
@@ -6696,16 +6716,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		BUG();
 	}
 
-	/*
-	 * Task abort to the device W-LUN is illegal. When this command
-	 * will fail, due to spec violation, scsi err handling next step
-	 * will be to send LU reset which, again, is a spec violation.
-	 * To avoid these unnecessary/illegal step we skip to the last error
-	 * handling stage: reset and restore.
-	 */
-	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN)
-		return ufshcd_eh_host_reset_handler(cmd);
-
 	ufshcd_hold(hba, false);
 	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	/* If command is already aborted/completed, return SUCCESS */
@@ -6726,7 +6736,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * to reduce repeated printouts. For other aborted requests only print
 	 * basic details.
 	 */
-	scsi_print_command(hba->lrb[tag].cmd);
+	scsi_print_command(cmd);
 	if (!hba->req_abort_count) {
 		ufshcd_update_reg_hist(&hba->ufs_stats.task_abort, 0);
 		ufshcd_print_host_regs(hba);
@@ -6745,6 +6755,30 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto cleanup;
 	}
 
+	/*
+	 * Task abort to the device W-LUN is illegal. When this command
+	 * will fail, due to spec violation, scsi err handling next step
+	 * will be to send LU reset which, again, is a spec violation.
+	 * To avoid these unnecessary/illegal steps, first we clean up
+	 * the lrb taken by this cmd and mark the lrb as in_use, then
+	 * queue the eh_work and bail.
+	 */
+	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
+		struct scsi_cmnd *cmd_in_lrb;
+
+		spin_lock_irqsave(host->host_lock, flags);
+		cmd_in_lrb = lrbp->cmd;
+		if (cmd_in_lrb) {
+			__ufshcd_transfer_req_compl(hba, (1UL << tag));
+			__set_bit(tag, &hba->outstanding_reqs);
+			lrbp->in_use = true;
+			hba->force_reset = true;
+			ufshcd_schedule_eh_work(hba);
+		}
+		spin_unlock_irqrestore(host->host_lock, flags);
+		goto out;
+	}
+
 	/* Skip task abort in case previous aborts failed and report failure */
 	if (lrbp->req_abort_skip)
 		err = -EIO;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1e680bf..66e5338 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -163,6 +163,7 @@ struct ufs_pm_lvl_states {
  * @crypto_key_slot: the key slot to use for inline crypto (-1 if none)
  * @data_unit_num: the data unit number for the first block for inline crypto
  * @req_abort_skip: skip request abort task flag
+ * @in_use: indicates that this lrb is still in use
  */
 struct ufshcd_lrb {
 	struct utp_transfer_req_desc *utr_descriptor_ptr;
@@ -192,6 +193,7 @@ struct ufshcd_lrb {
 #endif
 
 	bool req_abort_skip;
+	bool in_use;
 };
 
 /**
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

