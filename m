Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBB2EC415
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jan 2021 20:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbhAFThm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jan 2021 14:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbhAFThm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 6 Jan 2021 14:37:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B8A52312A;
        Wed,  6 Jan 2021 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609961821;
        bh=/N+HY2j5p0wEOpVVQbzCfebTwQcxxvXY4UdraFzZiNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eR0wJDdb4qUp7STWwiCfLxEOejSL2xP4FoAOGKyBFUd1pHt8XHxwRR1nHi4WOBBYC
         nrCa32jQ0EbCc2xsuyvx3JeitDzzGz1JDJGSzQXasnbhgFb+/y5GyGPtGQkE5LPQ15
         eBixUQr/Qn8oPuh4xZAxgzfFGeksTqiUUBpS+Nk5H0yWhF+vjkVuCPbIzNidVKbqAw
         +hekan22XUmstJCi+ta+dnnu1ddnQL1aSfxKtgmPLzS023ydlUCQ4a+JqMwJG8xQMz
         Z1dOablVXwyqG8k6ly5c5wtGQCsiCbnpCU9yfxgdw60ETJ+7p2SPZ2heMbS7y2Pya1
         hwC0AxcnqiIOQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, Jaegeuk Kim <jaegeuk@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] scsi: ufs: handle LINERESET with correct tm_cmd
Date:   Wed,  6 Jan 2021 11:36:49 -0800
Message-Id: <20210106193649.3348230-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210106193649.3348230-1-jaegeuk@kernel.org>
References: <20210106193649.3348230-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@google.com>

This fixes a warning caused by wrong reserve tag usage in __ufshcd_issue_tm_cmd.

WARNING: CPU: 7 PID: 7 at block/blk-core.c:630 blk_get_request+0x68/0x70
WARNING: CPU: 4 PID: 157 at block/blk-mq-tag.c:82 blk_mq_get_tag+0x438/0x46c

And, in ufshcd_err_handler(), we can avoid to send tm_cmd before aborting
outstanding commands by waiting a bit for IO completion like this.

__ufshcd_issue_tm_cmd: task management cmd 0x80 timed-out

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1678cec08b51..377da8e98d9b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -44,6 +44,9 @@
 /* Query request timeout */
 #define QUERY_REQ_TIMEOUT 1500 /* 1.5 seconds */
 
+/* LINERESET TIME OUT */
+#define LINERESET_IO_TIMEOUT_MS			(30000) /* 30 sec */
+
 /* Task management command timeout */
 #define TM_CMD_TIMEOUT	100 /* msecs */
 
@@ -5899,6 +5902,8 @@ static void ufshcd_err_handler(struct work_struct *work)
 	 * check if power mode restore is needed.
 	 */
 	if (hba->saved_uic_err & UFSHCD_UIC_PA_GENERIC_ERROR) {
+		ktime_t start = ktime_get();
+
 		hba->saved_uic_err &= ~UFSHCD_UIC_PA_GENERIC_ERROR;
 		if (!hba->saved_uic_err)
 			hba->saved_err &= ~UIC_ERROR;
@@ -5906,6 +5911,20 @@ static void ufshcd_err_handler(struct work_struct *work)
 		if (ufshcd_is_pwr_mode_restore_needed(hba))
 			needs_restore = true;
 		spin_lock_irqsave(hba->host->host_lock, flags);
+		/* Wait for IO completion to avoid aborting IOs */
+		while (hba->outstanding_reqs) {
+			ufshcd_complete_requests(hba);
+			spin_unlock_irqrestore(hba->host->host_lock, flags);
+			schedule();
+			spin_lock_irqsave(hba->host->host_lock, flags);
+			if (ktime_to_ms(ktime_sub(ktime_get(), start)) >
+						LINERESET_IO_TIMEOUT_MS) {
+				dev_err(hba->dev, "%s: timeout, outstanding=%x\n",
+					__func__, hba->outstanding_reqs);
+				break;
+			}
+		}
+
 		if (!hba->saved_err && !needs_restore)
 			goto skip_err_handling;
 	}
@@ -6302,9 +6321,13 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	}
 
-	if (enabled_intr_status && retval == IRQ_NONE) {
-		dev_err(hba->dev, "%s: Unhandled interrupt 0x%08x\n",
-					__func__, intr_status);
+	if (enabled_intr_status && retval == IRQ_NONE &&
+				!ufshcd_eh_in_progress(hba)) {
+		dev_err(hba->dev, "%s: Unhandled interrupt 0x%08x (0x%08x, 0x%08x)\n",
+					__func__,
+					intr_status,
+					hba->ufs_stats.last_intr_status,
+					enabled_intr_status);
 		ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
 	}
 
@@ -6348,7 +6371,11 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 	 * Even though we use wait_event() which sleeps indefinitely,
 	 * the maximum wait time is bounded by %TM_CMD_TIMEOUT.
 	 */
-	req = blk_get_request(q, REQ_OP_DRV_OUT, BLK_MQ_REQ_RESERVED);
+	req = blk_get_request(q, REQ_OP_DRV_OUT, BLK_MQ_REQ_RESERVED |
+						BLK_MQ_REQ_NOWAIT);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
 	req->end_io_data = &wait;
 	free_slot = req->tag;
 	WARN_ON_ONCE(free_slot < 0 || free_slot >= hba->nutmrs);
@@ -9355,6 +9382,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	hba->tmf_tag_set = (struct blk_mq_tag_set) {
 		.nr_hw_queues	= 1,
+		.reserved_tags	= 1,
 		.queue_depth	= hba->nutmrs,
 		.ops		= &ufshcd_tmf_ops,
 		.flags		= BLK_MQ_F_NO_SCHED,
-- 
2.29.2.729.g45daf8777d-goog

