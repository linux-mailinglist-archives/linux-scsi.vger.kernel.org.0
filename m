Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E213A2399
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Jun 2021 06:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFJEqe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Jun 2021 00:46:34 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:10071 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhFJEq0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Jun 2021 00:46:26 -0400
IronPort-SDR: 2gIJujVIYJSQw4eYn9kR8Wq5wR1nw6W01+zg/OC+002gLNKEVyuyQq7oQKxHWtA2xg37YbvDm0
 Pm10nRbCjxt+SrQEuHlsprFd4FPQUnnXB66FQVPlNrfNbh7kTOBVeNxd0gzLzMm1DKOyQfzG/S
 AwM3+eSb/rV5ujqeJIUVH1WG5aJVGZwTF42qJXIAlHPrnvkk86rMDimuHsb07zGJmXj82XW+11
 TPiPjcgzdC7THRddi5aFQ+EBG7eyrE8pJQ/Eis3A2zVAQvYT32G3UtMMpSe3MBrRkxNZfcdwsu
 HaA=
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="29778432"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 09 Jun 2021 21:44:30 -0700
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 09 Jun 2021 21:44:29 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id D86D021AF7; Wed,  9 Jun 2021 21:44:29 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 8/9] scsi: ufs: Update the fast abort path in ufshcd_abort() for PM requests
Date:   Wed,  9 Jun 2021 21:43:36 -0700
Message-Id: <1623300218-9454-9-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623300218-9454-1-git-send-email-cang@codeaurora.org>
References: <1623300218-9454-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If PM requests fail during runtime suspend/resume, RPM framework saves the
error to dev->power.runtime_error. Before the runtime_error gets cleared,
runtime PM on this specific device won't work again, leaving the device
either runtime active or runtime suspended permanently.

When task abort happens to a PM request sent during runtime suspend/resume,
even if it can be successfully aborted, RPM framework anyways saves the
(TIMEOUT) error. In this situation, we can leverage error handling to
recover and clear the runtime_error. So, let PM requests take the fast
abort path in ufshcd_abort().

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 861942b..cf24ec2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2737,7 +2737,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		 * err handler blocked for too long. So, just fail the scsi cmd
 		 * sent from PM ops, err handler can recover PM error anyways.
 		 */
-		if (hba->wl_pm_op_in_progress) {
+		if (cmd->request->rq_flags & RQF_PM) {
 			hba->force_reset = true;
 			set_host_byte(cmd, DID_BAD_TARGET);
 			cmd->scsi_done(cmd);
@@ -2760,7 +2760,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	}
 
 	if (unlikely(test_bit(tag, &hba->outstanding_reqs))) {
-		if (hba->wl_pm_op_in_progress) {
+		if (cmd->request->rq_flags & RQF_PM) {
 			set_host_byte(cmd, DID_BAD_TARGET);
 			cmd->scsi_done(cmd);
 		} else {
@@ -6985,11 +6985,14 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	int err = 0;
 	struct ufshcd_lrb *lrbp;
 	u32 reg;
+	bool need_eh = false;
 
 	host = cmd->device->host;
 	hba = shost_priv(host);
 	tag = cmd->request->tag;
 	lrbp = &hba->lrb[tag];
+
+	dev_info(hba->dev, "%s: Device abort task at tag %d\n", __func__, tag);
 	if (!ufshcd_valid_tag(hba, tag)) {
 		dev_err(hba->dev,
 			"%s: invalid command tag %d: cmd=0x%p, cmd->request=0x%p",
@@ -7007,9 +7010,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto out;
 	}
 
-	/* Print Transfer Request of aborted task */
-	dev_info(hba->dev, "%s: Device abort task at tag %d\n", __func__, tag);
-
 	/*
 	 * Print detailed info about aborted request.
 	 * As more than one request might get aborted at the same time,
@@ -7037,21 +7037,21 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	}
 
 	/*
-	 * Task abort to the device W-LUN is illegal. When this command
-	 * will fail, due to spec violation, scsi err handling next step
-	 * will be to send LU reset which, again, is a spec violation.
-	 * To avoid these unnecessary/illegal steps, first we clean up
-	 * the lrb taken by this cmd and re-set it in outstanding_reqs,
-	 * then queue the eh_work and bail.
+	 * This fast path guarantees the cmd always gets aborted successfully,
+	 * meanwhile it invokes the error handler. It allows contexts, which
+	 * are blocked by this cmd, to fail fast. It serves multiple purposes:
+	 * #1 To avoid unnecessary/illagal abort attempts to the W-LU.
+	 * #2 To avoid live lock between eh_work and specific contexts, i.e.,
+	 *    suspend/resume and eh_work itself.
+	 * #3 To let eh_work recover runtime PM error in case abort happens
+	 *    to cmds sent from runtime suspend/resume ops.
 	 */
-	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
+	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN ||
+	    (cmd->request->rq_flags & RQF_PM)) {
 		ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, lrbp->lun);
 		__ufshcd_transfer_req_compl(hba, (1UL << tag));
 		set_bit(tag, &hba->outstanding_reqs);
-		spin_lock_irqsave(host->host_lock, flags);
-		hba->force_reset = true;
-		ufshcd_schedule_eh_work(hba);
-		spin_unlock_irqrestore(host->host_lock, flags);
+		need_eh = true;
 		goto out;
 	}
 
@@ -7065,6 +7065,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 cleanup:
 		__ufshcd_transfer_req_compl(hba, (1UL << tag));
 out:
+		if (cmd->request->rq_flags & RQF_PM || need_eh) {
+			spin_lock_irqsave(host->host_lock, flags);
+			hba->force_reset = true;
+			ufshcd_schedule_eh_work(hba);
+			spin_unlock_irqrestore(host->host_lock, flags);
+		}
 		err = SUCCESS;
 	} else {
 		dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

