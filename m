Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1156211B7DD
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Dec 2019 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfLKQKw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Dec 2019 11:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbfLKPLx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Dec 2019 10:11:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6787E222C4;
        Wed, 11 Dec 2019 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077112;
        bh=oBUjJzCoe8zgacm8z7ZITBOVvNWJ1Ca3PatKMSnOb9g=;
        h=From:To:Cc:Subject:Date:From;
        b=18ZYV2shQzxpBxBXgt8iKcbNRQgrvEn769hlMaJkc1aJNUyW3JR9gdjv5YNBYRsXJ
         LpTMFZNXJQRkb/RLKJY0X8iBaAhTX2nrz7uzArWYD9zr2znBRL19dsimrwWmHn1IA4
         sGDPh89kp2zMhtl/OZFXIphdZSMff+sFqBvwGlNE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 001/134] scsi: lpfc: Fix spinlock_irq issues in lpfc_els_flush_cmd()
Date:   Wed, 11 Dec 2019 10:09:37 -0500
Message-Id: <20191211151150.19073-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit d38b4a527fe898f859f74a3a43d4308f48ac7855 ]

While reviewing the CT behavior, issues with spinlock_irq were seen. The
driver should be using spinlock_irqsave/irqrestore in the els flush
routine.

Changed to spinlock_irqsave/irqrestore.

Link: https://lore.kernel.org/r/20190922035906.10977-15-jsmart2021@gmail.com
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index d5303994bfd62..0052b341587d9 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7986,20 +7986,22 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *tmp_iocb, *piocb;
 	IOCB_t *cmd = NULL;
+	unsigned long iflags = 0;
 
 	lpfc_fabric_abort_vport(vport);
+
 	/*
 	 * For SLI3, only the hbalock is required.  But SLI4 needs to coordinate
 	 * with the ring insert operation.  Because lpfc_sli_issue_abort_iotag
 	 * ultimately grabs the ring_lock, the driver must splice the list into
 	 * a working list and release the locks before calling the abort.
 	 */
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irqsave(&phba->hbalock, iflags);
 	pring = lpfc_phba_elsring(phba);
 
 	/* Bail out if we've no ELS wq, like in PCI error recovery case. */
 	if (unlikely(!pring)) {
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irqrestore(&phba->hbalock, iflags);
 		return;
 	}
 
@@ -8037,21 +8039,21 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		spin_unlock(&pring->ring_lock);
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irqrestore(&phba->hbalock, iflags);
 
 	/* Abort each txcmpl iocb on aborted list and remove the dlist links. */
 	list_for_each_entry_safe(piocb, tmp_iocb, &abort_list, dlist) {
-		spin_lock_irq(&phba->hbalock);
+		spin_lock_irqsave(&phba->hbalock, iflags);
 		list_del_init(&piocb->dlist);
 		lpfc_sli_issue_abort_iotag(phba, pring, piocb);
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	}
 	if (!list_empty(&abort_list))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
 				 "3387 abort list for txq not empty\n");
 	INIT_LIST_HEAD(&abort_list);
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		spin_lock(&pring->ring_lock);
 
@@ -8091,7 +8093,7 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		spin_unlock(&pring->ring_lock);
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irqrestore(&phba->hbalock, iflags);
 
 	/* Cancel all the IOCBs from the completions list */
 	lpfc_sli_cancel_iocbs(phba, &abort_list,
-- 
2.20.1

