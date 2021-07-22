Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B973F3D1C77
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Jul 2021 05:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhGVCzR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Jul 2021 22:55:17 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:40896 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhGVCzQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Jul 2021 22:55:16 -0400
Received: by mail-pj1-f52.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2283213pja.5
        for <linux-scsi@vger.kernel.org>; Wed, 21 Jul 2021 20:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fb2RY2/wstAyuLtAtIt20ooGDzmuUYR3su3nCi4Jx+0=;
        b=aSXbGIMOHoW8+AEiGtvd1qQg1jpkvHq92vDkdIX4fryw+fkAVdO9UF0uKZeeUb5Sxd
         gryboD4Q9Q8t1/dnMA7VqafeJ/vXg+7ia2J48+AQVtPAX14e+APC/LMfMEAXDEUx4Jd4
         CcQjDlfeH57LkEqU/KvGL0Ba312L1l/gElUkGgNG8CBbXHiGcUoWe5LD1TfkY252USvL
         WB4ao3a3Wo3aY7kfP6aRs8xMLmkxm/sc1LhR3PaACIS0+EoB9bAuJ++Iogx75CuY60ok
         3nqhU0bFm5TbZcSbdILMtaSLBs4TFKRnYKA2jmtSW63aPskTj1j8nGKS2leP5BTeW8YY
         MUzg==
X-Gm-Message-State: AOAM531LeKjYljlO1ZbwDKPCx/g7lOEoWdd4F/H8RVtUxrsM/LbFEpyk
        0hQV0G9f+RLom72WBQ8V27g=
X-Google-Smtp-Source: ABdhPJxB2H+SLTrb6ekNeROP4kLxnutyY2vInxEcC+U8rwzZbCVNDoN6kCjhJr65quXLVZo6h34Lww==
X-Received: by 2002:a62:be18:0:b029:318:df2e:c17c with SMTP id l24-20020a62be180000b0290318df2ec17cmr40368164pff.30.1626924951670;
        Wed, 21 Jul 2021 20:35:51 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:30e2:954a:f4a0:3224])
        by smtp.gmail.com with ESMTPSA id n6sm32060258pgb.60.2021.07.21.20.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 20:35:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 14/18] scsi: ufs: Fix the SCSI abort handler
Date:   Wed, 21 Jul 2021 20:34:35 -0700
Message-Id: <20210722033439.26550-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722033439.26550-1-bvanassche@acm.org>
References: <20210722033439.26550-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make the following changes in ufshcd_abort():
- Return FAILED instead of SUCCESS if the abort handler notices that a SCSI
  command has already been completed. Returning SUCCESS in this case
  triggers a use-after-free and may trigger a kernel crash.
- Fix the code for aborting SCSI commands submitted to a WLUN.

The current approach for aborting SCSI commands that have been submitted to
a WLUN and that timed out is as follows:
- Report to the SCSI core that the command has completed successfully.
  Let the block layer free any data buffers associated with the command.
- Mark the command as outstanding in 'outstanding_reqs'.
- If the block layer tries to reuse the tag associated with the aborted
  command, busy-wait until the tag is freed.

This approach can result in:
- Memory corruption if the controller accesses the data buffer after the
  block layer has freed the associated data buffers.
- A race condition if ufshcd_queuecommand() or ufshcd_exec_dev_cmd()
  checks the bit that corresponds to an aborted command in 'outstanding_reqs'
  after it has been cleared and before it is reset.
- High energy consumption if ufshcd_queuecommand() repeatedly returns
  SCSI_MLQUEUE_HOST_BUSY.

Fix this by reporting to the SCSI error handler that aborting a SCSI
command failed if the SCSI command was submitted to a WLUN.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Cc: Avri Altman <avri.altman@wdc.com>
Fixes: 7a7e66c65d41 ("scsi: ufs: Fix a race condition between ufshcd_abort() and eh_work()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ufs/ufshcd.c | 54 ++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a3ad83a3bae0..c35e101c5834 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2724,15 +2724,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
 		(hba->clk_gating.state != CLKS_ON));
 
-	if (unlikely(test_bit(tag, &hba->outstanding_reqs))) {
-		if (hba->pm_op_in_progress)
-			set_host_byte(cmd, DID_BAD_TARGET);
-		else
-			err = SCSI_MLQUEUE_HOST_BUSY;
-		ufshcd_release(hba);
-		goto out;
-	}
-
 	lrbp = &hba->lrb[tag];
 	WARN_ON(lrbp->cmd);
 	lrbp->cmd = cmd;
@@ -2929,11 +2920,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	req->timeout = msecs_to_jiffies(2 * timeout);
 	blk_mq_start_request(req);
 
-	if (unlikely(test_bit(tag, &hba->outstanding_reqs))) {
-		err = -EBUSY;
-		goto out;
-	}
-
 	lrbp = &hba->lrb[tag];
 	WARN_ON(lrbp->cmd);
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
@@ -6922,19 +6908,19 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	unsigned int tag = cmd->request->tag;
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	unsigned long flags;
-	int err = 0;
+	int err = FAILED;
 	u32 reg;
 
 	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
 
 	ufshcd_hold(hba, false);
 	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	/* If command is already aborted/completed, return SUCCESS */
+	/* If command is already aborted/completed, return FAILED. */
 	if (!(test_bit(tag, &hba->outstanding_reqs))) {
 		dev_err(hba->dev,
 			"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
 			__func__, tag, hba->outstanding_reqs, reg);
-		goto out;
+		goto release;
 	}
 
 	/* Print Transfer Request of aborted task */
@@ -6963,7 +6949,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		dev_err(hba->dev,
 		"%s: cmd was completed, but without a notifying intr, tag = %d",
 		__func__, tag);
-		goto cleanup;
+		__ufshcd_transfer_req_compl(hba, 1UL << tag);
+		goto release;
 	}
 
 	/*
@@ -6976,36 +6963,33 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 */
 	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
 		ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, lrbp->lun);
-		__ufshcd_transfer_req_compl(hba, (1UL << tag));
-		set_bit(tag, &hba->outstanding_reqs);
+
 		spin_lock_irqsave(host->host_lock, flags);
 		hba->force_reset = true;
 		ufshcd_schedule_eh_work(hba);
 		spin_unlock_irqrestore(host->host_lock, flags);
-		goto out;
+		goto release;
 	}
 
 	/* Skip task abort in case previous aborts failed and report failure */
-	if (lrbp->req_abort_skip)
-		err = -EIO;
-	else
-		err = ufshcd_try_to_abort_task(hba, tag);
+	if (lrbp->req_abort_skip) {
+		dev_err(hba->dev, "%s: skipping abort\n", __func__);
+		ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
+		goto release;
+	}
 
-	if (!err) {
-cleanup:
-		__ufshcd_transfer_req_compl(hba, (1UL << tag));
-out:
-		err = SUCCESS;
-	} else {
+	err = ufshcd_try_to_abort_task(hba, tag);
+	if (err) {
 		dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
 		ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
 		err = FAILED;
+		goto release;
 	}
 
-	/*
-	 * This ufshcd_release() corresponds to the original scsi cmd that got
-	 * aborted here (as we won't get any IRQ for it).
-	 */
+	err = SUCCESS;
+
+release:
+	/* Matches the ufshcd_hold() call at the start of this function. */
 	ufshcd_release(hba);
 	return err;
 }
