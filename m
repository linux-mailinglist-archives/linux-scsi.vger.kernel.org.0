Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1A406087
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Sep 2021 02:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhIJARj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 20:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhIJAR2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Sep 2021 20:17:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35D38610A3;
        Fri, 10 Sep 2021 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631232978;
        bh=/PkyztDvEp+0IfrU+tlili7eeaSZH7STvlUkJM2yhxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRtbWsNlj1dgVr5URm8zp9JJqN8wF9hqtUzmGk7rlMzVxEGYGskwABzwLDJ6isK3/
         sa38hviMu+5mKF2SjyZghQZBR6ZM7gZ2L2qff7aRDGauoO36uKGMYhMOWlOs/TDL2Z
         U174E7Jn08mqaSEkSogMaM+4IFG0kOcuCqaVZ9hkq7dzpLs+O0/ppsgAQw1Ix+J6pq
         rpN0+3V85FIupyoYFAVKHo5jDxYy1c49WR9Y7nco+yQMvxE0XWj0Pdl/1f+pp5YeGZ
         pRM08IgKxcaNkPqBQLMpemfKk3HUaFTfODUvqKGCQQoolo6UCKcOKlSZBz/EHAW/HG
         IsRPFTWWsRQJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 14/99] scsi: lpfc: Clear outstanding active mailbox during PCI function reset
Date:   Thu,  9 Sep 2021 20:14:33 -0400
Message-Id: <20210910001558.173296-14-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001558.173296-1-sashal@kernel.org>
References: <20210910001558.173296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit a9978e3978406ef5e35870b10e677cf75a2620b6 ]

Mailbox commands sent via ioctl/bsg from user applications may be
interrupted from processing by a concurrently triggered PCI function
reset. The command will not generate a completion due to the reset.  This
results in a user application hang waiting for the mailbox command to
complete.

Resolve by changing the function reset handler to detect that there was an
outstanding mailbox command and simulate a mailbox completion.  Add some
additional debug when a mailbox command times out.

Link: https://lore.kernel.org/r/20210707184351.67872-13-jsmart2021@gmail.com
Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_init.c | 11 ++++++++++-
 drivers/scsi/lpfc/lpfc_sli.c  | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c4235699a123..221f22a026e5 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1852,6 +1852,7 @@ lpfc_sli4_port_sta_fn_reset(struct lpfc_hba *phba, int mbx_action,
 {
 	int rc;
 	uint32_t intr_mode;
+	LPFC_MBOXQ_t *mboxq;
 
 	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
 	    LPFC_SLI_INTF_IF_TYPE_2) {
@@ -1871,11 +1872,19 @@ lpfc_sli4_port_sta_fn_reset(struct lpfc_hba *phba, int mbx_action,
 				"Recovery...\n");
 
 	/* If we are no wait, the HBA has been reset and is not
-	 * functional, thus we should clear LPFC_SLI_ACTIVE flag.
+	 * functional, thus we should clear
+	 * (LPFC_SLI_ACTIVE | LPFC_SLI_MBOX_ACTIVE) flags.
 	 */
 	if (mbx_action == LPFC_MBX_NO_WAIT) {
 		spin_lock_irq(&phba->hbalock);
 		phba->sli.sli_flag &= ~LPFC_SLI_ACTIVE;
+		if (phba->sli.mbox_active) {
+			mboxq = phba->sli.mbox_active;
+			mboxq->u.mb.mbxStatus = MBX_NOT_FINISHED;
+			__lpfc_mbox_cmpl_put(phba, mboxq);
+			phba->sli.sli_flag &= ~LPFC_SLI_MBOX_ACTIVE;
+			phba->sli.mbox_active = NULL;
+		}
 		spin_unlock_irq(&phba->hbalock);
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index f530d8fe7a8c..b6f58843c77a 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -8790,8 +8790,11 @@ static int
 lpfc_sli4_async_mbox_block(struct lpfc_hba *phba)
 {
 	struct lpfc_sli *psli = &phba->sli;
+	LPFC_MBOXQ_t *mboxq;
 	int rc = 0;
 	unsigned long timeout = 0;
+	u32 sli_flag;
+	u8 cmd, subsys, opcode;
 
 	/* Mark the asynchronous mailbox command posting as blocked */
 	spin_lock_irq(&phba->hbalock);
@@ -8809,12 +8812,37 @@ lpfc_sli4_async_mbox_block(struct lpfc_hba *phba)
 	if (timeout)
 		lpfc_sli4_process_missed_mbox_completions(phba);
 
-	/* Wait for the outstnading mailbox command to complete */
+	/* Wait for the outstanding mailbox command to complete */
 	while (phba->sli.mbox_active) {
 		/* Check active mailbox complete status every 2ms */
 		msleep(2);
 		if (time_after(jiffies, timeout)) {
-			/* Timeout, marked the outstanding cmd not complete */
+			/* Timeout, mark the outstanding cmd not complete */
+
+			/* Sanity check sli.mbox_active has not completed or
+			 * cancelled from another context during last 2ms sleep,
+			 * so take hbalock to be sure before logging.
+			 */
+			spin_lock_irq(&phba->hbalock);
+			if (phba->sli.mbox_active) {
+				mboxq = phba->sli.mbox_active;
+				cmd = mboxq->u.mb.mbxCommand;
+				subsys = lpfc_sli_config_mbox_subsys_get(phba,
+									 mboxq);
+				opcode = lpfc_sli_config_mbox_opcode_get(phba,
+									 mboxq);
+				sli_flag = psli->sli_flag;
+				spin_unlock_irq(&phba->hbalock);
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+						"2352 Mailbox command x%x "
+						"(x%x/x%x) sli_flag x%x could "
+						"not complete\n",
+						cmd, subsys, opcode,
+						sli_flag);
+			} else {
+				spin_unlock_irq(&phba->hbalock);
+			}
+
 			rc = 1;
 			break;
 		}
-- 
2.30.2

