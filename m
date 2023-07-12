Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA942751013
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jul 2023 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGLRyP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jul 2023 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjGLRxu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Jul 2023 13:53:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C84211C
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jul 2023 10:53:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b89c09521dso8778645ad.0
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jul 2023 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689184425; x=1689789225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx/Jf4e2+y9G2p/tuS6GsfFoY/gArJ7gLbH1sPvcGkc=;
        b=K6HGYA5tKlOemTax0gE9F7vWorE07509sLrYyEnyXBTctWj7aEJcCApywGZIoVHcKf
         kI4YIxRLhdbjfNaG2kiNZtcfOxsR1T2wzWwR1EiwREelRKzC4UuNlr7Z27vqoKx/FngN
         tKMOvG1Jkfpf3z7yelDzNoTlhKdJRGePZKbXvxM9ByywuLI9itw7lFJDchCKX1QmLf5k
         OB+a7f+ueUr4XzK7VvwLiI+Ay7iA0wCvHgKWnKiTPzI0lhOO+4shaTBoQG6IB277GlDv
         5Jkl4GCqvhmjVZJMXGvaseiRxGk+B92IOIs6iMCQ0QOQMEhtEAGmhPIkEGbRXdMtu+oW
         L+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184425; x=1689789225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx/Jf4e2+y9G2p/tuS6GsfFoY/gArJ7gLbH1sPvcGkc=;
        b=bghwUwif+vLnx+6r+vxg+goqZaOJtenULTRKmJyAHnj263KJ5RxiC8am7r9/eeZkVW
         YibBOJZ+cFwU+dU1Zv+fg9gZK+FONDK3dAnp5ULebtoircpi6P8jFK9DFNckhE+8gX/a
         BiDPzRUkamZoCGZksF2YGlD8f6K0ePCDjV5FmehJRVej+ZCL2rGjUWm1408Mg3lgTQm2
         56EYHv6p+I71L/CazKvG5WgSzC0rW7rf+HOlrzNAvRnwWzfeXHHk9VQ4fl1Ta7c4byC3
         JG4iP6FvS1gb0jpZX1tQl50a/+YA7CoQPThCZsdZxsq5LIXuppqwIOux5kL8m0K0MfqF
         RaIA==
X-Gm-Message-State: ABy/qLZl4Yrl/FLtLHrrf6J1U+blGAquDzrgGLJX2nbScQOV3GEy6TQf
        8PmUZk1ErAwvjiVvs/WIZKm03BYYXeU=
X-Google-Smtp-Source: APBJJlGjFoubBRWMYOJ21w+05FvO2Dl6ZPIbbCr8gX8mCyC5UNtmJAjfQu015mWDxa1JKGfweUP0pA==
X-Received: by 2002:a17:903:32c4:b0:1b8:a469:53d8 with SMTP id i4-20020a17090332c400b001b8a46953d8mr162913plr.0.1689184424844;
        Wed, 12 Jul 2023 10:53:44 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902b70b00b001b898595be7sm4218459pls.291.2023.07.12.10.53.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:53:44 -0700 (PDT)
From:   Justin Tee <justintee8345@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     jsmart2021@gmail.com, justin.tee@broadcom.com,
        Justin Tee <justintee8345@gmail.com>
Subject: [PATCH 08/12] lpfc: Abort outstanding ELS cmds when mailbox timeout error is detected
Date:   Wed, 12 Jul 2023 11:05:18 -0700
Message-Id: <20230712180522.112722-9-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230712180522.112722-1-justintee8345@gmail.com>
References: <20230712180522.112722-1-justintee8345@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A mailbox timeout error usually indicates something has gone wrong, and
a follow up reset of the HBA is a typical recovery mechanism.  Introduce a
MBX_TMO_ERR flag to detect such cases and have lpfc_els_flush_cmd abort
ELS commands if the MBX_TMO_ERR flag condition was set.  This ensures
all of the registered SGL resources meant for ELS traffic are not leaked
after an HBA reset.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
---
 drivers/scsi/lpfc/lpfc.h      |  1 +
 drivers/scsi/lpfc/lpfc_els.c  | 25 ++++++++++++++++++-------
 drivers/scsi/lpfc/lpfc_init.c | 20 +++++++++++++++++---
 drivers/scsi/lpfc/lpfc_sli.c  |  8 +++++++-
 4 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 9a8963684369..e8d7eeeb2185 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -872,6 +872,7 @@ enum lpfc_irq_chann_mode {
 enum lpfc_hba_bit_flags {
 	FABRIC_COMANDS_BLOCKED,
 	HBA_PCI_ERR,
+	MBX_TMO_ERR,
 };
 
 struct lpfc_hba {
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index f37757449f3c..b5cd6d1c0a5a 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9603,11 +9603,13 @@ void
 lpfc_els_flush_cmd(struct lpfc_vport *vport)
 {
 	LIST_HEAD(abort_list);
+	LIST_HEAD(cancel_list);
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *tmp_iocb, *piocb;
 	u32 ulp_command;
 	unsigned long iflags = 0;
+	bool mbx_tmo_err;
 
 	lpfc_fabric_abort_vport(vport);
 
@@ -9629,15 +9631,16 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		spin_lock(&pring->ring_lock);
 
+	mbx_tmo_err = test_bit(MBX_TMO_ERR, &phba->bit_flags);
 	/* First we need to issue aborts to outstanding cmds on txcmpl */
 	list_for_each_entry_safe(piocb, tmp_iocb, &pring->txcmplq, list) {
-		if (piocb->cmd_flag & LPFC_IO_LIBDFC)
+		if (piocb->cmd_flag & LPFC_IO_LIBDFC && !mbx_tmo_err)
 			continue;
 
 		if (piocb->vport != vport)
 			continue;
 
-		if (piocb->cmd_flag & LPFC_DRIVER_ABORTED)
+		if (piocb->cmd_flag & LPFC_DRIVER_ABORTED && !mbx_tmo_err)
 			continue;
 
 		/* On the ELS ring we can have ELS_REQUESTs or
@@ -9656,8 +9659,8 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 			 */
 			if (phba->link_state == LPFC_LINK_DOWN)
 				piocb->cmd_cmpl = lpfc_cmpl_els_link_down;
-		}
-		if (ulp_command == CMD_GEN_REQUEST64_CR)
+		} else if (ulp_command == CMD_GEN_REQUEST64_CR ||
+			   mbx_tmo_err)
 			list_add_tail(&piocb->dlist, &abort_list);
 	}
 
@@ -9669,11 +9672,19 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	list_for_each_entry_safe(piocb, tmp_iocb, &abort_list, dlist) {
 		spin_lock_irqsave(&phba->hbalock, iflags);
 		list_del_init(&piocb->dlist);
-		lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
+		if (mbx_tmo_err)
+			list_move_tail(&piocb->list, &cancel_list);
+		else
+			lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
+
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	}
-	/* Make sure HBA is alive */
-	lpfc_issue_hb_tmo(phba);
+	if (!list_empty(&cancel_list))
+		lpfc_sli_cancel_iocbs(phba, &cancel_list, IOSTAT_LOCAL_REJECT,
+				      IOERR_SLI_ABORTED);
+	else
+		/* Make sure HBA is alive */
+		lpfc_issue_hb_tmo(phba);
 
 	if (!list_empty(&abort_list))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 041d6f0f2097..c878fb99dc4c 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7550,6 +7550,8 @@ lpfc_disable_pci_dev(struct lpfc_hba *phba)
 void
 lpfc_reset_hba(struct lpfc_hba *phba)
 {
+	int rc = 0;
+
 	/* If resets are disabled then set error state and return. */
 	if (!phba->cfg_enable_hba_reset) {
 		phba->link_state = LPFC_HBA_ERROR;
@@ -7560,13 +7562,25 @@ lpfc_reset_hba(struct lpfc_hba *phba)
 	if (phba->sli.sli_flag & LPFC_SLI_ACTIVE) {
 		lpfc_offline_prep(phba, LPFC_MBX_WAIT);
 	} else {
+		if (test_bit(MBX_TMO_ERR, &phba->bit_flags)) {
+			/* Perform a PCI function reset to start from clean */
+			rc = lpfc_pci_function_reset(phba);
+			lpfc_els_flush_all_cmd(phba);
+		}
 		lpfc_offline_prep(phba, LPFC_MBX_NO_WAIT);
 		lpfc_sli_flush_io_rings(phba);
 	}
 	lpfc_offline(phba);
-	lpfc_sli_brdrestart(phba);
-	lpfc_online(phba);
-	lpfc_unblock_mgmt_io(phba);
+	clear_bit(MBX_TMO_ERR, &phba->bit_flags);
+	if (unlikely(rc)) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				"8888 PCI function reset failed rc %x\n",
+				rc);
+	} else {
+		lpfc_sli_brdrestart(phba);
+		lpfc_online(phba);
+		lpfc_unblock_mgmt_io(phba);
+	}
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 58d10f8f75a7..4dfadf254a72 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3935,6 +3935,8 @@ void lpfc_poll_eratt(struct timer_list *t)
 	uint64_t sli_intr, cnt;
 
 	phba = from_timer(phba, t, eratt_poll);
+	if (!(phba->hba_flag & HBA_SETUP))
+		return;
 
 	/* Here we will also keep track of interrupts per sec of the hba */
 	sli_intr = phba->sli.slistat.sli_intr;
@@ -7693,7 +7695,9 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 		spin_unlock_irq(&phba->hbalock);
 	} else {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"3161 Failure to post sgl to port.\n");
+				"3161 Failure to post sgl to port,status %x "
+				"blkcnt %d totalcnt %d postcnt %d\n",
+				status, block_cnt, total_cnt, post_cnt);
 		return -EIO;
 	}
 
@@ -8478,6 +8482,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 			spin_unlock_irq(&phba->hbalock);
 		}
 	}
+	phba->hba_flag &= ~HBA_SETUP;
 
 	lpfc_sli4_dip(phba);
 
@@ -9282,6 +9287,7 @@ lpfc_mbox_timeout_handler(struct lpfc_hba *phba)
 	 * would get IOCB_ERROR from lpfc_sli_issue_iocb, allowing
 	 * it to fail all outstanding SCSI IO.
 	 */
+	set_bit(MBX_TMO_ERR, &phba->bit_flags);
 	spin_lock_irq(&phba->pport->work_port_lock);
 	phba->pport->work_port_events &= ~WORKER_MBOX_TMO;
 	spin_unlock_irq(&phba->pport->work_port_lock);
-- 
2.38.0

