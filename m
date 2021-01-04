Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48362E9C95
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Jan 2021 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhADSEW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 13:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbhADSEV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Jan 2021 13:04:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5781BC0617A5
        for <linux-scsi@vger.kernel.org>; Mon,  4 Jan 2021 10:03:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be12so14955314plb.4
        for <linux-scsi@vger.kernel.org>; Mon, 04 Jan 2021 10:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgypVmJl5uhBEkalN3KFNqfc2S4+SqLTK/4QAVwZFZg=;
        b=tJrBYAGhtDoQ0M7xHpQ15h4D6Bh1UUob3e7oVpfxG2aMwiQ1KHaUGZ5KRPNmnMH3yz
         1Hy8S4ZW/vrphqTDGlcsMcVEeZbnVkD3ag6ZjtG20tWfXFq0bvw2CymJWGdA4ql8UIoA
         iD3ZX3RNgF2tCZS1jpJfdzQWNvXCGyooULadcnxT3SdVPRBDb2H8R9cCY6lOMmRtadnn
         3LT+mYGgaM56pBNTb1nf2Vbx+e/hNRY+XBxHq11/AOj/LwrTOzn0n32KEpy2lak2N8+2
         xyQdvw/+cvcPJDcgWw6lPev5ScKltpfvn7jGwiilMKjEtK9RoRuxT8SscsKNgD85HYt4
         RKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgypVmJl5uhBEkalN3KFNqfc2S4+SqLTK/4QAVwZFZg=;
        b=oj/7oNYHVbUxTxVC2NDGDBZjBuD8ps3N30bxXnyP7Vc7NMMGidiWd684pvaxXhS3oD
         7YINobY5BA/YkcFUQHMzFMFfj643WDEE8xUxCV0gwPpJJw+3WPvtWt0bRmkHlJzxRNFu
         pfo+b7zGII6kcWrDMCurtjXhlzy/NLM0vgRWx4dedc6JQuIYBQAdekhgUnJQPZaL4dmj
         iGkHlf1JKhrvjmqdVvBFhk1V8VR3vVczi/1Pw6E3siFK5s7rt5XtC9yzpkcxvVNWTjvQ
         u8MwfMZ+tarspIxzGKgndeCDnYAtF6dZkHRPJeGqlnlE+zwaGF/+D5Ksm9lkXKK+nb8P
         wE7g==
X-Gm-Message-State: AOAM5312GmyLla31WlFNz6+Hr0rKjHdbVmLG/bt2eb2woLvC+dDIcJGg
        +nIpelZD0nAjXPH9J2mVy8sRDEfGUVM=
X-Google-Smtp-Source: ABdhPJx15FgEb/1SQ4A8VEPi1177anlbZDMjZCPZoC/oHnuC3d4CoE/Q2PC2zyewf1xXmnvSYeBvAw==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr73616pjb.188.1609783404588;
        Mon, 04 Jan 2021 10:03:24 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q23sm57570885pfg.18.2021.01.04.10.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:03:24 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH v2 13/15] lpfc: Implement health checking when aborting io
Date:   Mon,  4 Jan 2021 10:02:38 -0800
Message-Id: <20210104180240.46824-14-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210104180240.46824-1-jsmart2021@gmail.com>
References: <20210104180240.46824-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Several errors have occurred where the adapter stops or fails but does
not raise the register values for the driver to detect failure. Thus
driver is unaware of the failure. The failure typically results in io
timeouts, the io timeout handler failing (after several seconds), and
the error handler escalating recovery policy and resulting in more
errors. Eventually, the driver is in a position where things have
spiraled and it can't do recovery because other recovery ops are still
outstanding and it becomes unusable.

Resolve the situation by having the io timeout handler (actually a els,
scsi io, nvme ls, or nvme io timeout), in addition to aborting the io,
perform a mailbox command and look for a response from the hardware.
if the mailbox command fails, it will mark the adapter offline and then
invoke the adapter reset handler to clean up.

The new io timeout test will be limited to a test every 5s. If there are
multiple io timeouts concurrently, only the 1st io timeout will generate
the mailbox command. Further testing will only occur once a timeout
occurs after a 5s delay from the last mailbox command has expired.

Co-developed-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h           |   3 +-
 drivers/scsi/lpfc/lpfc_attr.c      |   2 +
 drivers/scsi/lpfc/lpfc_crtn.h      |   2 +
 drivers/scsi/lpfc/lpfc_els.c       |   9 ++
 drivers/scsi/lpfc/lpfc_hbadisc.c   |   3 +
 drivers/scsi/lpfc/lpfc_init.c      | 177 +++++++++++++++++------------
 drivers/scsi/lpfc/lpfc_nportdisc.c |   2 +
 drivers/scsi/lpfc/lpfc_nvme.c      |   8 ++
 drivers/scsi/lpfc/lpfc_scsi.c      |   3 +
 drivers/scsi/lpfc/lpfc_sli.c       |  44 ++++++-
 10 files changed, 178 insertions(+), 75 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 7875552c07d3..6ba5fa08c47a 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -780,6 +780,8 @@ struct lpfc_hba {
 #define HBA_FLOGI_ISSUED	0x100000 /* FLOGI was issued */
 #define HBA_DEFER_FLOGI		0x800000 /* Defer FLOGI till read_sparm cmpl */
 #define HBA_NEEDS_CFG_PORT	0x2000000 /* SLI3 - needs a CONFIG_PORT mbox */
+#define HBA_HBEAT_INP		0x4000000 /* mbox HBEAT is in progress */
+#define HBA_HBEAT_TMO		0x8000000 /* HBEAT initiated after timeout */
 
 	uint32_t fcp_ring_in_use; /* When polling test if intr-hndlr active*/
 	struct lpfc_dmabuf slim2p;
@@ -1136,7 +1138,6 @@ struct lpfc_hba {
 	unsigned long last_completion_time;
 	unsigned long skipped_hb;
 	struct timer_list hb_tmofunc;
-	uint8_t hb_outstanding;
 	struct timer_list rrq_tmr;
 	enum hba_temp_state over_temp_state;
 	/*
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index f8bb6a4f780c..bdd9a29f4201 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1788,6 +1788,8 @@ lpfc_board_mode_store(struct device *dev, struct device_attribute *attr,
 	else if (strncmp(buf, "pci_bus_reset", sizeof("pci_bus_reset") - 1)
 		 == 0)
 		status = lpfc_reset_pci_bus(phba);
+	else if (strncmp(buf, "heartbeat", sizeof("heartbeat") - 1) == 0)
+		lpfc_issue_hb_tmo(phba);
 	else if (strncmp(buf, "trunk", sizeof("trunk") - 1) == 0)
 		status = lpfc_set_trunking(phba, (char *)buf + sizeof("trunk"));
 	else
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index e70db9ec7da4..a0aad4896a45 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -359,6 +359,8 @@ lpfc_sli_abort_taskmgmt(struct lpfc_vport *, struct lpfc_sli_ring *,
 
 void lpfc_mbox_timeout(struct timer_list *t);
 void lpfc_mbox_timeout_handler(struct lpfc_hba *);
+int lpfc_issue_hb_mbox(struct lpfc_hba *phba);
+void lpfc_issue_hb_tmo(struct lpfc_hba *phba);
 
 struct lpfc_nodelist *lpfc_findnode_did(struct lpfc_vport *, uint32_t);
 struct lpfc_nodelist *lpfc_findnode_wwpn(struct lpfc_vport *,
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index c944f220406e..d1bb99220495 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1428,6 +1428,9 @@ lpfc_els_abort_flogi(struct lpfc_hba *phba)
 							   NULL);
 		}
 	}
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 	spin_unlock_irq(&phba->hbalock);
 
 	return 0;
@@ -8127,6 +8130,9 @@ lpfc_els_timeout_handler(struct lpfc_vport *vport)
 		spin_unlock_irq(&phba->hbalock);
 	}
 
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 	if (!list_empty(&pring->txcmplq))
 		if (!(phba->pport->load_flag & FC_UNLOADING))
 			mod_timer(&vport->els_tmofunc,
@@ -8226,6 +8232,9 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 		lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	}
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 	if (!list_empty(&abort_list))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "3387 abort list for txq not empty\n");
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index bcb5bf7e19dc..f890b5b7e6ca 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5619,6 +5619,9 @@ lpfc_free_tx(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	}
 	spin_unlock_irq(&phba->hbalock);
 
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 	/* Cancel all the IOCBs from the completions list */
 	lpfc_sli_cancel_iocbs(phba, &completions, IOSTAT_LOCAL_REJECT,
 			      IOERR_SLI_ABORTED);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c2619d56be12..dbd7e40f67f9 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -591,7 +591,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 	/* Set up heart beat (HB) timer */
 	mod_timer(&phba->hb_tmofunc,
 		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
-	phba->hb_outstanding = 0;
+	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
 	phba->last_completion_time = jiffies;
 	/* Set up error attention (ERATT) polling timer */
 	mod_timer(&phba->eratt_poll,
@@ -1204,10 +1204,10 @@ lpfc_hb_mbox_cmpl(struct lpfc_hba * phba, LPFC_MBOXQ_t * pmboxq)
 	unsigned long drvr_flag;
 
 	spin_lock_irqsave(&phba->hbalock, drvr_flag);
-	phba->hb_outstanding = 0;
+	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
 	spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
 
-	/* Check and reset heart-beat timer is necessary */
+	/* Check and reset heart-beat timer if necessary */
 	mempool_free(pmboxq, phba->mbox_mem_pool);
 	if (!(phba->pport->fc_flag & FC_OFFLINE_MODE) &&
 		!(phba->link_state == LPFC_HBA_ERROR) &&
@@ -1380,6 +1380,60 @@ static void lpfc_hb_mxp_handler(struct lpfc_hba *phba)
 	}
 }
 
+/**
+ * lpfc_issue_hb_mbox - Issues heart-beat mailbox command
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * If a HB mbox is not already in progrees, this routine will allocate
+ * a LPFC_MBOXQ_t, populate it with a MBX_HEARTBEAT (0x31) command,
+ * and issue it. The HBA_HBEAT_INP flag means the command is in progress.
+ **/
+int
+lpfc_issue_hb_mbox(struct lpfc_hba *phba)
+{
+	LPFC_MBOXQ_t *pmboxq;
+	int retval;
+
+	/* Is a Heartbeat mbox already in progress */
+	if (phba->hba_flag & HBA_HBEAT_INP)
+		return 0;
+
+	pmboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
+	if (!pmboxq)
+		return -ENOMEM;
+
+	lpfc_heart_beat(phba, pmboxq);
+	pmboxq->mbox_cmpl = lpfc_hb_mbox_cmpl;
+	pmboxq->vport = phba->pport;
+	retval = lpfc_sli_issue_mbox(phba, pmboxq, MBX_NOWAIT);
+
+	if (retval != MBX_BUSY && retval != MBX_SUCCESS) {
+		mempool_free(pmboxq, phba->mbox_mem_pool);
+		return -ENXIO;
+	}
+	phba->hba_flag |= HBA_HBEAT_INP;
+
+	return 0;
+}
+
+/**
+ * lpfc_issue_hb_tmo - Signals heartbeat timer to issue mbox command
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * The heartbeat timer (every 5 sec) will fire. If the HBA_HBEAT_TMO
+ * flag is set, it will force a MBX_HEARTBEAT mbox command, regardless
+ * of the value of lpfc_enable_hba_heartbeat.
+ * If lpfc_enable_hba_heartbeat is set, the timeout routine will always
+ * try to issue a MBX_HEARTBEAT mbox command.
+ **/
+void
+lpfc_issue_hb_tmo(struct lpfc_hba *phba)
+{
+	if (phba->cfg_enable_hba_heartbeat)
+		return;
+	phba->hba_flag |= HBA_HBEAT_TMO;
+}
+
 /**
  * lpfc_hb_timeout_handler - The HBA-timer timeout handler
  * @phba: pointer to lpfc hba data structure.
@@ -1400,9 +1454,9 @@ void
 lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 {
 	struct lpfc_vport **vports;
-	LPFC_MBOXQ_t *pmboxq;
 	struct lpfc_dmabuf *buf_ptr;
-	int retval, i;
+	int retval = 0;
+	int i, tmo;
 	struct lpfc_sli *psli = &phba->sli;
 	LIST_HEAD(completions);
 
@@ -1424,24 +1478,6 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 		(phba->pport->fc_flag & FC_OFFLINE_MODE))
 		return;
 
-	spin_lock_irq(&phba->pport->work_port_lock);
-
-	if (time_after(phba->last_completion_time +
-			msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL),
-			jiffies)) {
-		spin_unlock_irq(&phba->pport->work_port_lock);
-		if (!phba->hb_outstanding)
-			mod_timer(&phba->hb_tmofunc,
-				jiffies +
-				msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
-		else
-			mod_timer(&phba->hb_tmofunc,
-				jiffies +
-				msecs_to_jiffies(1000 * LPFC_HB_MBOX_TIMEOUT));
-		return;
-	}
-	spin_unlock_irq(&phba->pport->work_port_lock);
-
 	if (phba->elsbuf_cnt &&
 		(phba->elsbuf_cnt == phba->elsbuf_prev_cnt)) {
 		spin_lock_irq(&phba->hbalock);
@@ -1461,37 +1497,43 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 
 	/* If there is no heart beat outstanding, issue a heartbeat command */
 	if (phba->cfg_enable_hba_heartbeat) {
-		if (!phba->hb_outstanding) {
+		/* If IOs are completing, no need to issue a MBX_HEARTBEAT */
+		spin_lock_irq(&phba->pport->work_port_lock);
+		if (time_after(phba->last_completion_time +
+				msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL),
+				jiffies)) {
+			spin_unlock_irq(&phba->pport->work_port_lock);
+			if (phba->hba_flag & HBA_HBEAT_INP)
+				tmo = (1000 * LPFC_HB_MBOX_TIMEOUT);
+			else
+				tmo = (1000 * LPFC_HB_MBOX_INTERVAL);
+			goto out;
+		}
+		spin_unlock_irq(&phba->pport->work_port_lock);
+
+		/* Check if a MBX_HEARTBEAT is already in progress */
+		if (phba->hba_flag & HBA_HBEAT_INP) {
+			/*
+			 * If heart beat timeout called with HBA_HBEAT_INP set
+			 * we need to give the hb mailbox cmd a chance to
+			 * complete or TMO.
+			 */
+			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
+				"0459 Adapter heartbeat still outstanding: "
+				"last compl time was %d ms.\n",
+				jiffies_to_msecs(jiffies
+					 - phba->last_completion_time));
+			tmo = (1000 * LPFC_HB_MBOX_TIMEOUT);
+		} else {
 			if ((!(psli->sli_flag & LPFC_SLI_MBOX_ACTIVE)) &&
 				(list_empty(&psli->mboxq))) {
-				pmboxq = mempool_alloc(phba->mbox_mem_pool,
-							GFP_KERNEL);
-				if (!pmboxq) {
-					mod_timer(&phba->hb_tmofunc,
-						 jiffies +
-						 msecs_to_jiffies(1000 *
-						 LPFC_HB_MBOX_INTERVAL));
-					return;
-				}
 
-				lpfc_heart_beat(phba, pmboxq);
-				pmboxq->mbox_cmpl = lpfc_hb_mbox_cmpl;
-				pmboxq->vport = phba->pport;
-				retval = lpfc_sli_issue_mbox(phba, pmboxq,
-						MBX_NOWAIT);
-
-				if (retval != MBX_BUSY &&
-					retval != MBX_SUCCESS) {
-					mempool_free(pmboxq,
-							phba->mbox_mem_pool);
-					mod_timer(&phba->hb_tmofunc,
-						jiffies +
-						msecs_to_jiffies(1000 *
-						LPFC_HB_MBOX_INTERVAL));
-					return;
+				retval = lpfc_issue_hb_mbox(phba);
+				if (retval) {
+					tmo = (1000 * LPFC_HB_MBOX_INTERVAL);
+					goto out;
 				}
 				phba->skipped_hb = 0;
-				phba->hb_outstanding = 1;
 			} else if (time_before_eq(phba->last_completion_time,
 					phba->skipped_hb)) {
 				lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
@@ -1502,30 +1544,23 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 			} else
 				phba->skipped_hb = jiffies;
 
-			mod_timer(&phba->hb_tmofunc,
-				 jiffies +
-				 msecs_to_jiffies(1000 * LPFC_HB_MBOX_TIMEOUT));
-			return;
-		} else {
-			/*
-			* If heart beat timeout called with hb_outstanding set
-			* we need to give the hb mailbox cmd a chance to
-			* complete or TMO.
-			*/
-			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
-					"0459 Adapter heartbeat still out"
-					"standing:last compl time was %d ms.\n",
-					jiffies_to_msecs(jiffies
-						 - phba->last_completion_time));
-			mod_timer(&phba->hb_tmofunc,
-				jiffies +
-				msecs_to_jiffies(1000 * LPFC_HB_MBOX_TIMEOUT));
+			tmo = (1000 * LPFC_HB_MBOX_TIMEOUT);
+			goto out;
 		}
 	} else {
-			mod_timer(&phba->hb_tmofunc,
-				jiffies +
-				msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
+		/* Check to see if we want to force a MBX_HEARTBEAT */
+		if (phba->hba_flag & HBA_HBEAT_TMO) {
+			retval = lpfc_issue_hb_mbox(phba);
+			if (retval)
+				tmo = (1000 * LPFC_HB_MBOX_INTERVAL);
+			else
+				tmo = (1000 * LPFC_HB_MBOX_TIMEOUT);
+			goto out;
+		}
+		tmo = (1000 * LPFC_HB_MBOX_INTERVAL);
 	}
+out:
+	mod_timer(&phba->hb_tmofunc, jiffies + msecs_to_jiffies(tmo));
 }
 
 /**
@@ -2989,7 +3024,7 @@ lpfc_stop_hba_timers(struct lpfc_hba *phba)
 		del_timer_sync(&phba->rrq_tmr);
 		phba->hba_flag &= ~HBA_RRQ_ACTIVE;
 	}
-	phba->hb_outstanding = 0;
+	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
 
 	switch (phba->pci_dev_grp) {
 	case LPFC_PCI_DEV_LP:
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 0d0d2ca1a5d8..135d8e8a42ba 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -250,6 +250,8 @@ lpfc_els_abort(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 			lpfc_sli_issue_abort_iotag(phba, pring, iocb, NULL);
 			spin_unlock_irq(&phba->hbalock);
 	}
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
 
 	INIT_LIST_HEAD(&abort_list);
 
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index e72c4cd3a97a..5e990f4c1ca6 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1847,6 +1847,10 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 
 	spin_unlock(&lpfc_nbuf->buf_lock);
 	spin_unlock_irqrestore(&phba->hbalock, flags);
+
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 	if (ret_val != WQE_SUCCESS) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6137 Failed abts issue_wqe with status x%x "
@@ -2593,6 +2597,10 @@ lpfc_nvme_wait_for_io_drain(struct lpfc_hba *phba)
 			}
 		}
 	}
+
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 }
 
 void
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 4ee890de556b..1b0e1df9545f 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5479,6 +5479,9 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 						     lpfc_sli_abort_fcp_cmpl);
 	}
 
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 	if (ret_val != IOCB_SUCCESS) {
 		/* Indicate the IO is not being aborted by the driver. */
 		lpfc_cmd->waitq = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 176706aaebf5..d51d86959bbc 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4246,6 +4246,8 @@ lpfc_sli_abort_iocb_ring(struct lpfc_hba *phba, struct lpfc_sli_ring *pring)
 			lpfc_sli_issue_abort_iotag(phba, pring, iocb, NULL);
 		spin_unlock_irq(&phba->hbalock);
 	}
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
 
 	/* Cancel all the IOCBs from the completions list */
 	lpfc_sli_cancel_iocbs(phba, &completions, IOSTAT_LOCAL_REJECT,
@@ -8044,7 +8046,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Start heart beat timer */
 	mod_timer(&phba->hb_tmofunc,
 		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
-	phba->hb_outstanding = 0;
+	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
 	phba->last_completion_time = jiffies;
 
 	/* start eq_delay heartbeat */
@@ -11218,6 +11220,9 @@ lpfc_sli_host_down(struct lpfc_vport *vport)
 	}
 	spin_unlock_irqrestore(&phba->hbalock, flags);
 
+	/* Make sure HBA is alive */
+	lpfc_issue_hb_tmo(phba);
+
 	/* Cancel all the IOCBs from the completions list */
 	lpfc_sli_cancel_iocbs(phba, &completions, IOSTAT_LOCAL_REJECT,
 			      IOERR_SLI_DOWN);
@@ -13029,7 +13034,21 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 				spin_unlock_irqrestore(
 						&phba->pport->work_port_lock,
 						iflag);
-				lpfc_mbox_cmpl_put(phba, pmb);
+
+				/* Do NOT queue MBX_HEARTBEAT to the worker
+				 * thread for processing.
+				 */
+				if (pmbox->mbxCommand == MBX_HEARTBEAT) {
+					/* Process mbox now */
+					phba->sli.mbox_active = NULL;
+					phba->sli.sli_flag &=
+						~LPFC_SLI_MBOX_ACTIVE;
+					if (pmb->mbox_cmpl)
+						pmb->mbox_cmpl(phba, pmb);
+				} else {
+					/* Queue to worker thread to process */
+					lpfc_mbox_cmpl_put(phba, pmb);
+				}
 			}
 		} else
 			spin_unlock_irqrestore(&phba->hbalock, iflag);
@@ -13625,7 +13644,26 @@ lpfc_sli4_sp_handle_mbox_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 	phba->pport->work_port_events &= ~WORKER_MBOX_TMO;
 	spin_unlock_irqrestore(&phba->pport->work_port_lock, iflags);
 
-	/* There is mailbox completion work to do */
+	/* Do NOT queue MBX_HEARTBEAT to the worker thread for processing. */
+	if (pmbox->mbxCommand == MBX_HEARTBEAT) {
+		spin_lock_irqsave(&phba->hbalock, iflags);
+		/* Release the mailbox command posting token */
+		phba->sli.sli_flag &= ~LPFC_SLI_MBOX_ACTIVE;
+		phba->sli.mbox_active = NULL;
+		if (bf_get(lpfc_trailer_consumed, mcqe))
+			lpfc_sli4_mq_release(phba->sli4_hba.mbx_wq);
+		spin_unlock_irqrestore(&phba->hbalock, iflags);
+
+		/* Post the next mbox command, if there is one */
+		lpfc_sli4_post_async_mbox(phba);
+
+		/* Process cmpl now */
+		if (pmb->mbox_cmpl)
+			pmb->mbox_cmpl(phba, pmb);
+		return false;
+	}
+
+	/* There is mailbox completion work to queue to the worker thread */
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	__lpfc_mbox_cmpl_put(phba, pmb);
 	phba->work_ha |= HA_MBATT;
-- 
2.26.2

