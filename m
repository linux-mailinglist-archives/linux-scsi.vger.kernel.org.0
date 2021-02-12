Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9D3196E2
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Feb 2021 00:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBKXqm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Feb 2021 18:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBKXqQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Feb 2021 18:46:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F0CC0617A9
        for <linux-scsi@vger.kernel.org>; Thu, 11 Feb 2021 15:45:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gb24so4366553pjb.4
        for <linux-scsi@vger.kernel.org>; Thu, 11 Feb 2021 15:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O4odr6JI6gMFgyZB8ERLRgGVnXTqS1MF9Gbv5df7ss=;
        b=nK7xKn0sdRh/ciaNv/bq/8PPp0grcsRYUVFhPnmYxUNI7USfwTgRxz7JWNZn5a+/xG
         4Lvz6CKHaC6trXWawj0Ksr4YN1KMKN1W1/BlZRaO76mY+02CpLy9KP4IGRbIXHgPg8rl
         8mJqlnbNp5VeXdo++ItgEKbsAEbst1IyCK5upWLd8Fep6M281LwD4ExiWeuSvZB8IPWr
         hLrQG4qYGXG4bvWOcbQ5qMQIewp+I49Kg6ZfLFBy6Tsk81O+K1zNq9sgb8QO4CK3NeaD
         TlK95PPCOyczLmROCtQ5O81bq8GbMQCznJntrH9zmSKkY+K0/btU9+xCJwIlqzl9sRxN
         U/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O4odr6JI6gMFgyZB8ERLRgGVnXTqS1MF9Gbv5df7ss=;
        b=Wbai4gmF0nsAjOHsbVeYTOtIxzz6cuXWjgT6K+cYiKM8jhvyOZCIfh29Ar1yaMNYJW
         TO0lRXKq61snLLJIjuGqF0ScjBuiaV3y2YteJhIGa2KNyoT5GMCvDOZiGsz54Sj3xKxy
         KD/CX59U44jpXPkbBw74ghTtp7cMSjYd7m1rktzUFMoCiaNgaACAE2J9TZkpw8jpqSzA
         QXlwGeW+sUWaqarKMribVWANPnHOqT6a3cYLsnbLEedA1XQUbk6A8gaHw233I6NZVK84
         W87h9NzTz/1AQuP05K/59TlBC+BWaa9TEMXhulBtvyV8bWO4UtkPnKDtD5rEnueAkS+/
         25PA==
X-Gm-Message-State: AOAM5302I1ib90HnJzrNHSvitkfBBHesH9EHINpJAsJ/FnfxWMCVlKWg
        d8cryUxBgsBJ4OzXjNzMEhNb0SGqSB8=
X-Google-Smtp-Source: ABdhPJysIyoZs58K6LUE+/hOdO1bhumDo/39L6IeZKJiLrLDUVnKNxevXTYWcx9UxSFhM5c0OFg6sA==
X-Received: by 2002:a17:903:2285:b029:e1:58a2:b937 with SMTP id b5-20020a1709032285b02900e158a2b937mr286065plh.68.1613087099913;
        Thu, 11 Feb 2021 15:44:59 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i67sm6808035pfe.19.2021.02.11.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:44:59 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 13/22] lpfc: Fix PLOGI ACC to be transmit after REG_LOGIN
Date:   Thu, 11 Feb 2021 15:44:34 -0800
Message-Id: <20210211234443.3107-14-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211234443.3107-1-jsmart2021@gmail.com>
References: <20210211234443.3107-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver is seeing a scenario where PLOGI response was issued and
traffic is arriving while the adapter is still setting up the login
context. This is resulting in errors handling the traffic.

Change the driver so that PLOGI response is sent after the login context
has been setup to avoid the situation.

Co-developed-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 239 +++++++++--------------------
 1 file changed, 70 insertions(+), 169 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 57e4aef8a9a3..090a4232bfa8 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -279,106 +279,43 @@ lpfc_els_abort(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	lpfc_cancel_retry_delay_tmo(phba->pport, ndlp);
 }
 
-/* lpfc_defer_pt2pt_acc - Complete SLI3 pt2pt processing on link up
+/* lpfc_defer_plogi_acc - Issue PLOGI ACC after reg_login completes
  * @phba: pointer to lpfc hba data structure.
- * @link_mbox: pointer to CONFIG_LINK mailbox object
+ * @login_mbox: pointer to REG_RPI mailbox object
  *
- * This routine is only called if we are SLI3, direct connect pt2pt
- * mode and the remote NPort issues the PLOGI after link up.
+ * The ACC for a rcv'ed PLOGI is deferred until AFTER the REG_RPI completes
  */
 static void
-lpfc_defer_pt2pt_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *link_mbox)
+lpfc_defer_plogi_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *login_mbox)
 {
-	LPFC_MBOXQ_t *login_mbox;
-	MAILBOX_t *mb = &link_mbox->u.mb;
 	struct lpfc_iocbq *save_iocb;
 	struct lpfc_nodelist *ndlp;
+	MAILBOX_t *mb = &login_mbox->u.mb;
+
 	int rc;
 
-	ndlp = link_mbox->ctx_ndlp;
-	login_mbox = link_mbox->context3;
+	ndlp = login_mbox->ctx_ndlp;
 	save_iocb = login_mbox->context3;
-	link_mbox->context3 = NULL;
-	login_mbox->context3 = NULL;
-
-	/* Check for CONFIG_LINK error */
-	if (mb->mbxStatus) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"4575 CONFIG_LINK fails pt2pt discovery: %x\n",
-				mb->mbxStatus);
-		mempool_free(login_mbox, phba->mbox_mem_pool);
-		mempool_free(link_mbox, phba->mbox_mem_pool);
-		kfree(save_iocb);
-		return;
-	}
 
-	/* Now that CONFIG_LINK completed, and our SID is configured,
-	 * we can now proceed with sending the PLOGI ACC.
-	 */
-	rc = lpfc_els_rsp_acc(link_mbox->vport, ELS_CMD_PLOGI,
-			      save_iocb, ndlp, login_mbox);
-	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"4576 PLOGI ACC fails pt2pt discovery: %x\n",
-				rc);
-		mempool_free(login_mbox, phba->mbox_mem_pool);
+	if (mb->mbxStatus == MBX_SUCCESS) {
+		/* Now that REG_RPI completed successfully,
+		 * we can now proceed with sending the PLOGI ACC.
+		 */
+		rc = lpfc_els_rsp_acc(login_mbox->vport, ELS_CMD_PLOGI,
+				      save_iocb, ndlp, NULL);
+		if (rc) {
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"4576 PLOGI ACC fails pt2pt discovery: "
+					"DID %x Data: %x\n", ndlp->nlp_DID, rc);
+		}
 	}
 
-	mempool_free(link_mbox, phba->mbox_mem_pool);
+	/* Now process the REG_RPI cmpl */
+	lpfc_mbx_cmpl_reg_login(phba, login_mbox);
+	ndlp->nlp_flag &= ~NLP_ACC_REGLOGIN;
 	kfree(save_iocb);
 }
 
-/**
- * lpfc_defer_tgt_acc - Progress SLI4 target rcv PLOGI handler
- * @phba: Pointer to HBA context object.
- * @pmb: Pointer to mailbox object.
- *
- * This function provides the unreg rpi mailbox completion handler for a tgt.
- * The routine frees the memory resources associated with the completed
- * mailbox command and transmits the ELS ACC.
- *
- * This routine is only called if we are SLI4, acting in target
- * mode and the remote NPort issues the PLOGI after link up.
- **/
-static void
-lpfc_defer_acc_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
-{
-	struct lpfc_vport *vport = pmb->vport;
-	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
-	LPFC_MBOXQ_t *mbox = pmb->context3;
-	struct lpfc_iocbq *piocb = NULL;
-	int rc;
-
-	if (mbox) {
-		pmb->context3 = NULL;
-		piocb = mbox->context3;
-		mbox->context3 = NULL;
-	}
-
-	/*
-	 * Complete the unreg rpi mbx request, and update flags.
-	 * This will also restart any deferred events.
-	 */
-	lpfc_sli4_unreg_rpi_cmpl_clr(phba, pmb);
-
-	if (!piocb) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
-				 "4578 PLOGI ACC fail\n");
-		if (mbox)
-			mempool_free(mbox, phba->mbox_mem_pool);
-		return;
-	}
-
-	rc = lpfc_els_rsp_acc(vport, ELS_CMD_PLOGI, piocb, ndlp, mbox);
-	if (rc) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
-				 "4579 PLOGI ACC fail %x\n", rc);
-		if (mbox)
-			mempool_free(mbox, phba->mbox_mem_pool);
-	}
-	kfree(piocb);
-}
-
 static int
 lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	       struct lpfc_iocbq *cmdiocb)
@@ -395,8 +332,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	struct lpfc_iocbq *save_iocb;
 	struct ls_rjt stat;
 	uint32_t vid, flag;
-	u16 rpi;
-	int rc, defer_acc;
+	int rc;
 
 	memset(&stat, 0, sizeof (struct ls_rjt));
 	pcmd = (struct lpfc_dmabuf *) cmdiocb->context2;
@@ -445,7 +381,6 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	else
 		ndlp->nlp_fcp_info |= CLASS3;
 
-	defer_acc = 0;
 	ndlp->nlp_class_sup = 0;
 	if (sp->cls1.classValid)
 		ndlp->nlp_class_sup |= FC_COS_CLASS1;
@@ -549,27 +484,26 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 		memcpy(&phba->fc_fabparam, sp, sizeof(struct serv_parm));
 
-		/* Issue config_link / reg_vfi to account for updated TOV's */
-
+		/* Issue CONFIG_LINK for SLI3 or REG_VFI for SLI4,
+		 * to account for updated TOV's / parameters
+		 */
 		if (phba->sli_rev == LPFC_SLI_REV4)
 			lpfc_issue_reg_vfi(vport);
 		else {
-			defer_acc = 1;
 			link_mbox = mempool_alloc(phba->mbox_mem_pool,
 						  GFP_KERNEL);
 			if (!link_mbox)
 				goto out;
 			lpfc_config_link(phba, link_mbox);
-			link_mbox->mbox_cmpl = lpfc_defer_pt2pt_acc;
+			link_mbox->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 			link_mbox->vport = vport;
 			link_mbox->ctx_ndlp = ndlp;
 
-			save_iocb = kzalloc(sizeof(*save_iocb), GFP_KERNEL);
-			if (!save_iocb)
+			rc = lpfc_sli_issue_mbox(phba, link_mbox, MBX_NOWAIT);
+			if (rc == MBX_NOT_FINISHED) {
+				mempool_free(link_mbox, phba->mbox_mem_pool);
 				goto out;
-			/* Save info from cmd IOCB used in rsp */
-			memcpy((uint8_t *)save_iocb, (uint8_t *)cmdiocb,
-			       sizeof(struct lpfc_iocbq));
+			}
 		}
 
 		lpfc_can_disctmo(vport);
@@ -588,59 +522,28 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (!login_mbox)
 		goto out;
 
-	/* Registering an existing RPI behaves differently for SLI3 vs SLI4 */
-	if (phba->nvmet_support && !defer_acc) {
-		link_mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
-		if (!link_mbox)
-			goto out;
-
-		/* As unique identifiers such as iotag would be overwritten
-		 * with those from the cmdiocb, allocate separate temporary
-		 * storage for the copy.
-		 */
-		save_iocb = kzalloc(sizeof(*save_iocb), GFP_KERNEL);
-		if (!save_iocb)
-			goto out;
-
-		/* Unreg RPI is required for SLI4. */
-		rpi = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
-		lpfc_unreg_login(phba, vport->vpi, rpi, link_mbox);
-		link_mbox->vport = vport;
-		link_mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
-		if (!link_mbox->ctx_ndlp)
-			goto out;
-
-		link_mbox->mbox_cmpl = lpfc_defer_acc_rsp;
-
-		if (((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
-		    (!(vport->fc_flag & FC_OFFLINE_MODE)))
-			ndlp->nlp_flag |= NLP_UNREG_INP;
+	save_iocb = kzalloc(sizeof(*save_iocb), GFP_KERNEL);
+	if (!save_iocb)
+		goto out;
 
-		/* Save info from cmd IOCB used in rsp */
-		memcpy(save_iocb, cmdiocb, sizeof(*save_iocb));
+	/* Save info from cmd IOCB to be used in rsp after all mbox completes */
+	memcpy((uint8_t *)save_iocb, (uint8_t *)cmdiocb,
+	       sizeof(struct lpfc_iocbq));
 
-		/* Delay sending ACC till unreg RPI completes. */
-		defer_acc = 1;
-	} else if (phba->sli_rev == LPFC_SLI_REV4)
+	/* Registering an existing RPI behaves differently for SLI3 vs SLI4 */
+	if (phba->sli_rev == LPFC_SLI_REV4)
 		lpfc_unreg_rpi(vport, ndlp);
 
+	/* Issue REG_LOGIN first, before ACCing the PLOGI, thus we will
+	 * always be deferring the ACC.
+	 */
 	rc = lpfc_reg_rpi(phba, vport->vpi, icmd->un.rcvels.remoteID,
 			    (uint8_t *)sp, login_mbox, ndlp->nlp_rpi);
 	if (rc)
 		goto out;
 
-	/* ACC PLOGI rsp command needs to execute first,
-	 * queue this login_mbox command to be processed later.
-	 */
 	login_mbox->mbox_cmpl = lpfc_mbx_cmpl_reg_login;
-	/*
-	 * login_mbox->ctx_ndlp = lpfc_nlp_get(ndlp) deferred until mailbox
-	 * command issued in lpfc_cmpl_els_acc().
-	 */
 	login_mbox->vport = vport;
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= (NLP_ACC_REGLOGIN | NLP_RCV_PLOGI);
-	spin_unlock_irq(&ndlp->lock);
 
 	/*
 	 * If there is an outstanding PLOGI issued, abort it before
@@ -670,7 +573,8 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		 * to register, then unregister the RPI.
 		 */
 		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_RM_DFLT_RPI;
+		ndlp->nlp_flag |= (NLP_RM_DFLT_RPI | NLP_ACC_REGLOGIN |
+				   NLP_RCV_PLOGI);
 		spin_unlock_irq(&ndlp->lock);
 		stat.un.b.lsRjtRsnCode = LSRJT_INVALID_CMD;
 		stat.un.b.lsRjtRsnCodeExp = LSEXP_NOTHING_MORE;
@@ -680,42 +584,39 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			mempool_free(login_mbox, phba->mbox_mem_pool);
 		return 1;
 	}
-	if (defer_acc) {
-		/* So the order here should be:
-		 * SLI3 pt2pt
-		 *   Issue CONFIG_LINK mbox
-		 *   CONFIG_LINK cmpl
-		 * SLI4 tgt
-		 *   Issue UNREG RPI mbx
-		 *   UNREG RPI cmpl
-		 * Issue PLOGI ACC
-		 * PLOGI ACC cmpl
-		 * Issue REG_LOGIN mbox
-		 */
 
-		/* Save the REG_LOGIN mbox for and rcv IOCB copy later */
-		link_mbox->context3 = login_mbox;
-		login_mbox->context3 = save_iocb;
+	/* So the order here should be:
+	 * SLI3 pt2pt
+	 *   Issue CONFIG_LINK mbox
+	 *   CONFIG_LINK cmpl
+	 * SLI4 pt2pt
+	 *   Issue REG_VFI mbox
+	 *   REG_VFI cmpl
+	 * SLI4
+	 *   Issue UNREG RPI mbx
+	 *   UNREG RPI cmpl
+	 * Issue REG_RPI mbox
+	 * REG RPI cmpl
+	 * Issue PLOGI ACC
+	 * PLOGI ACC cmpl
+	 */
+	login_mbox->mbox_cmpl = lpfc_defer_plogi_acc;
+	login_mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
+	login_mbox->context3 = save_iocb; /* For PLOGI ACC */
 
-		/* Start the ball rolling by issuing CONFIG_LINK here */
-		rc = lpfc_sli_issue_mbox(phba, link_mbox, MBX_NOWAIT);
-		if (rc == MBX_NOT_FINISHED)
-			goto out;
-		return 1;
-	}
+	spin_lock_irq(&ndlp->lock);
+	ndlp->nlp_flag |= (NLP_ACC_REGLOGIN | NLP_RCV_PLOGI);
+	spin_unlock_irq(&ndlp->lock);
+
+	/* Start the ball rolling by issuing REG_LOGIN here */
+	rc = lpfc_sli_issue_mbox(phba, login_mbox, MBX_NOWAIT);
+	if (rc == MBX_NOT_FINISHED)
+		goto out;
+	lpfc_nlp_set_state(vport, ndlp, NLP_STE_REG_LOGIN_ISSUE);
 
-	rc = lpfc_els_rsp_acc(vport, ELS_CMD_PLOGI, cmdiocb, ndlp, login_mbox);
-	if (rc)
-		mempool_free(login_mbox, phba->mbox_mem_pool);
 	return 1;
 out:
-	if (defer_acc)
-		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"4577 discovery failure: %p %p %p\n",
-				save_iocb, link_mbox, login_mbox);
 	kfree(save_iocb);
-	if (link_mbox)
-		mempool_free(link_mbox, phba->mbox_mem_pool);
 	if (login_mbox)
 		mempool_free(login_mbox, phba->mbox_mem_pool);
 
-- 
2.26.2

