Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE64C3BA5
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Feb 2022 03:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiBYCYM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Feb 2022 21:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiBYCYC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Feb 2022 21:24:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E991E5202
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x11so3533409pll.10
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7/uIG1u3IrsOPFkzkpIRn8ZSNAUd93XqoWx9RDMAAg=;
        b=cCxu32Yv+LsiLaubfo5IsfYFqSzAW9xI7k4r5c7ZCnbGjWRQVa63DXt9vCF47qZ2ng
         7lbAxr3zdC66BVgvhDUA6ixg/cXL4oxRBkb06paPhIbTEbcaAH3kqndWeYWSiDJJdHY3
         gr00n4KX2y72QiTVLLjoQz7owCWBj6wvaf2tyxjaqknIyqmpm6VOIbB8ebmGHPFM/ssN
         JjNui6gXQ2wvvmuOtmHECVQ/rQQtWqYN447ChHVXAY/kawheg7HKaNWz0mPge7dWS9M8
         8TYnfXnsal/afL+XpczSD/CkV3uD+AlNXS1KNz1WVg3bsEPXYmEHD4+bQmJYzKVZ8Exq
         Wx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7/uIG1u3IrsOPFkzkpIRn8ZSNAUd93XqoWx9RDMAAg=;
        b=F3kviUaKtTb1IkG7OMU86Qyctb/pbCqr+MOcvs55xXbpSxc3Y9cFkgmZjuA+87ECid
         wQ8mbiKgpaj/at+yNpcovwF3e0oB+12puLSlADQtPcQQr2btpEThgr5qxvFA5eCT9ufw
         0B7y27yt9vAHuRWkIkYJapkG5LNJrBy44QzwdCgxKoeil7HgspJDp9AihEEWvF30rrJO
         TAEMPtdBVx8F6OLq2zA9xjoYZQ1EfANQsXMuDy3+dfIiTFOJ3MsEtC+UMRCw1cZ3SaAA
         Q39VTGDYjky/waYGgL4FAzuqCpFymSsR0e9p39jdOXkswgwmJxTpQzzM3ZYUdKVP8kIR
         rOIw==
X-Gm-Message-State: AOAM531wtkcztSYgZFhgKug95wKbTJVktHevN5w5sTsIt1Iz7nbe0ixv
        9QUiBaJnpOMnhA9y2VsWIJiufyl1Fuw=
X-Google-Smtp-Source: ABdhPJyiFNt6uLFFR5IrBx/f5qm65KsRdBEf6B6PpKvCG3tLWPt4OUW0XTgax8g6YPZ7RED4NDwJdg==
X-Received: by 2002:a17:903:1ce:b0:150:2117:16b3 with SMTP id e14-20020a17090301ce00b00150211716b3mr3096468plh.26.1645755806903;
        Thu, 24 Feb 2022 18:23:26 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f3b355dcb1sm845596pfh.58.2022.02.24.18.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:23:26 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 11/17] lpfc: SLI path split: refactor misc ELS paths
Date:   Thu, 24 Feb 2022 18:23:02 -0800
Message-Id: <20220225022308.16486-12-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220225022308.16486-1-jsmart2021@gmail.com>
References: <20220225022308.16486-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch refactors the remaining ELS paths to use SLI-4 as the primary
interface. Paths include RRQ, RSCN, unsolicited els rqst and rsp paths,
els timeouts, etc.

Changes include:
- remove unused routines lpfc_sli4_bpl2sgl and lpfc_sli4_iocb2wqe
- conversion away from using sli-3 iocb structures to set/access fields
  in common routines. Use the new generic get/set routines that were added.
  This move changes code from indirect structure references to using
  local variables with the generic routines.
- refactor routines when setting non-generic fields, to have both
  both sli3 and sli4 specific sections. This replaces the set-as-sli3
  then translate to sli4 behavior of the past.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c       | 224 +++++---
 drivers/scsi/lpfc/lpfc_hbadisc.c   |  44 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c |  38 +-
 drivers/scsi/lpfc/lpfc_sli.c       | 809 ++---------------------------
 4 files changed, 241 insertions(+), 874 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 789259fadf6c..8be071696ad8 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1228,18 +1228,20 @@ static void
 lpfc_cmpl_els_link_down(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			struct lpfc_iocbq *rspiocb)
 {
-	IOCB_t *irsp;
 	uint32_t *pcmd;
 	uint32_t cmd;
+	u32 ulp_status, ulp_word4;
 
 	pcmd = (uint32_t *)(((struct lpfc_dmabuf *)cmdiocb->context2)->virt);
 	cmd = *pcmd;
-	irsp = &rspiocb->iocb;
+
+	ulp_status = get_job_ulpstatus(phba, rspiocb);
+	ulp_word4 = get_job_word4(phba, rspiocb);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
 			"6445 ELS completes after LINK_DOWN: "
 			" Status %x/%x cmd x%x flg x%x\n",
-			irsp->ulpStatus, irsp->un.ulpWord[4], cmd,
+			ulp_status, ulp_word4, cmd,
 			cmdiocb->cmd_flag);
 
 	if (cmdiocb->cmd_flag & LPFC_IO_FABRIC) {
@@ -1905,43 +1907,43 @@ lpfc_end_rscn(struct lpfc_vport *vport)
 
 static void
 lpfc_cmpl_els_rrq(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
-		    struct lpfc_iocbq *rspiocb)
+		  struct lpfc_iocbq *rspiocb)
 {
 	struct lpfc_vport *vport = cmdiocb->vport;
-	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp = cmdiocb->context1;
 	struct lpfc_node_rrq *rrq;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	rrq = cmdiocb->context_un.rrq;
 	cmdiocb->context_un.rsp_iocb = rspiocb;
 
-	irsp = &rspiocb->iocb;
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
 		"RRQ cmpl:      status:x%x/x%x did:x%x",
-		irsp->ulpStatus, irsp->un.ulpWord[4],
-		irsp->un.elsreq64.remoteID);
+		ulp_status, ulp_word4,
+		get_job_els_rsp64_did(phba, cmdiocb));
+
 
 	/* rrq completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "2880 RRQ completes to DID x%x "
 			 "Data: x%x x%x x%x x%x x%x\n",
-			 irsp->un.elsreq64.remoteID,
-			 irsp->ulpStatus, irsp->un.ulpWord[4],
-			 irsp->ulpTimeout, rrq->xritag, rrq->rxid);
+			 ndlp->nlp_DID, ulp_status, ulp_word4,
+			 get_wqe_tmo(cmdiocb), rrq->xritag, rrq->rxid);
 
-	if (irsp->ulpStatus) {
+	if (ulp_status) {
 		/* Check for retry */
 		/* RRQ failed Don't print the vport to vport rjts */
-		if (irsp->ulpStatus != IOSTAT_LS_RJT ||
-			(((irsp->un.ulpWord[4]) >> 16 != LSRJT_INVALID_CMD) &&
-			((irsp->un.ulpWord[4]) >> 16 != LSRJT_UNABLE_TPC)) ||
-			(phba)->pport->cfg_log_verbose & LOG_ELS)
+		if (ulp_status != IOSTAT_LS_RJT ||
+		    (((ulp_word4) >> 16 != LSRJT_INVALID_CMD) &&
+		     ((ulp_word4) >> 16 != LSRJT_UNABLE_TPC)) ||
+		    (phba)->pport->cfg_log_verbose & LOG_ELS)
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "2881 RRQ failure DID:%06X Status:"
 					 "x%x/x%x\n",
-					 ndlp->nlp_DID, irsp->ulpStatus,
-					 irsp->un.ulpWord[4]);
+					 ndlp->nlp_DID, ulp_status,
+					 ulp_word4);
 	}
 
 	lpfc_clr_rrq_active(phba, rrq->xritag, rrq);
@@ -5340,7 +5342,9 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		    && (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
 			if (!lpfc_unreg_rpi(vport, ndlp) &&
 			    (!(vport->fc_flag & FC_PT2PT))) {
-				if (ndlp->nlp_state == NLP_STE_REG_LOGIN_ISSUE) {
+				if (ndlp->nlp_state ==  NLP_STE_PLOGI_ISSUE ||
+				    ndlp->nlp_state ==
+				     NLP_STE_REG_LOGIN_ISSUE) {
 					lpfc_printf_vlog(vport, KERN_INFO,
 							 LOG_DISCOVERY,
 							 "0314 PLOGI recov "
@@ -5421,12 +5425,15 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	    (vport && vport->port_type == LPFC_NPIV_PORT) &&
 	    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD) &&
 	    ndlp->nlp_flag & NLP_RELEASE_RPI) {
-		lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
-		ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
-		spin_unlock_irq(&ndlp->lock);
-		lpfc_drop_node(vport, ndlp);
+		if (ndlp->nlp_state !=  NLP_STE_PLOGI_ISSUE &&
+		    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
+			lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
+			spin_lock_irq(&ndlp->lock);
+			ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
+			ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
+			spin_unlock_irq(&ndlp->lock);
+			lpfc_drop_node(vport, ndlp);
+		}
 	}
 
 	/* Release the originating I/O reference. */
@@ -7920,6 +7927,13 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 			lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb,
 				ndlp, NULL);
+			/* Restart disctmo if its already running */
+			if (vport->fc_flag & FC_DISC_TMO) {
+				tmo = ((phba->fc_ratov * 3) + 3);
+				mod_timer(&vport->fc_disctmo,
+					  jiffies +
+					  msecs_to_jiffies(1000 * tmo));
+			}
 			return 0;
 		}
 	}
@@ -9278,6 +9292,7 @@ lpfc_els_timeout_handler(struct lpfc_vport *vport)
 	uint32_t timeout;
 	uint32_t remote_ID = 0xffffffff;
 	LIST_HEAD(abort_list);
+	u32 ulp_command = 0, ulp_context = 0, did = 0, iotag = 0;
 
 
 	timeout = (uint32_t)(phba->fc_ratov << 1);
@@ -9294,11 +9309,21 @@ lpfc_els_timeout_handler(struct lpfc_vport *vport)
 		spin_lock(&pring->ring_lock);
 
 	list_for_each_entry_safe(piocb, tmp_iocb, &pring->txcmplq, list) {
-		cmd = &piocb->iocb;
+		ulp_command = get_job_cmnd(phba, piocb);
+		ulp_context = get_job_ulpcontext(phba, piocb);
+		did = get_job_els_rsp64_did(phba, piocb);
+
+		if (phba->sli_rev == LPFC_SLI_REV4) {
+			iotag = get_wqe_reqtag(piocb);
+		} else {
+			cmd = &piocb->iocb;
+			iotag = cmd->ulpIoTag;
+		}
 
 		if ((piocb->cmd_flag & LPFC_IO_LIBDFC) != 0 ||
-		    piocb->iocb.ulpCommand == CMD_ABORT_XRI_CN ||
-		    piocb->iocb.ulpCommand == CMD_CLOSE_XRI_CN)
+		    ulp_command == CMD_ABORT_XRI_CX ||
+		    ulp_command == CMD_ABORT_XRI_CN ||
+		    ulp_command == CMD_CLOSE_XRI_CN)
 			continue;
 
 		if (piocb->vport != vport)
@@ -9322,11 +9347,11 @@ lpfc_els_timeout_handler(struct lpfc_vport *vport)
 		}
 
 		remote_ID = 0xffffffff;
-		if (cmd->ulpCommand != CMD_GEN_REQUEST64_CR)
-			remote_ID = cmd->un.elsreq64.remoteID;
-		else {
+		if (ulp_command != CMD_GEN_REQUEST64_CR) {
+			remote_ID = did;
+		} else {
 			struct lpfc_nodelist *ndlp;
-			ndlp = __lpfc_findnode_rpi(vport, cmd->ulpContext);
+			ndlp = __lpfc_findnode_rpi(vport, ulp_context);
 			if (ndlp)
 				remote_ID = ndlp->nlp_DID;
 		}
@@ -9337,11 +9362,11 @@ lpfc_els_timeout_handler(struct lpfc_vport *vport)
 	spin_unlock_irq(&phba->hbalock);
 
 	list_for_each_entry_safe(piocb, tmp_iocb, &abort_list, dlist) {
-		cmd = &piocb->iocb;
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0127 ELS timeout Data: x%x x%x x%x "
 			 "x%x\n", els_command,
-			 remote_ID, cmd->ulpCommand, cmd->ulpIoTag);
+			 remote_ID, ulp_command, iotag);
+
 		spin_lock_irq(&phba->hbalock);
 		list_del_init(&piocb->dlist);
 		lpfc_sli_issue_abort_iotag(phba, pring, piocb, NULL);
@@ -9384,7 +9409,7 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *tmp_iocb, *piocb;
-	IOCB_t *cmd = NULL;
+	u32 ulp_command;
 	unsigned long iflags = 0;
 
 	lpfc_fabric_abort_vport(vport);
@@ -9421,8 +9446,8 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 		/* On the ELS ring we can have ELS_REQUESTs or
 		 * GEN_REQUESTs waiting for a response.
 		 */
-		cmd = &piocb->iocb;
-		if (cmd->ulpCommand == CMD_ELS_REQUEST64_CR) {
+		ulp_command = get_job_cmnd(phba, piocb);
+		if (ulp_command == CMD_ELS_REQUEST64_CR) {
 			list_add_tail(&piocb->dlist, &abort_list);
 
 			/* If the link is down when flushing ELS commands
@@ -9435,7 +9460,7 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 			if (phba->link_state == LPFC_LINK_DOWN)
 				piocb->cmd_cmpl = lpfc_cmpl_els_link_down;
 		}
-		if (cmd->ulpCommand == CMD_GEN_REQUEST64_CR)
+		if (ulp_command == CMD_GEN_REQUEST64_CR)
 			list_add_tail(&piocb->dlist, &abort_list);
 	}
 
@@ -9466,16 +9491,17 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	 * just queue them up for lpfc_sli_cancel_iocbs
 	 */
 	list_for_each_entry_safe(piocb, tmp_iocb, &pring->txq, list) {
-		cmd = &piocb->iocb;
+		ulp_command = get_job_cmnd(phba, piocb);
 
 		if (piocb->cmd_flag & LPFC_IO_LIBDFC)
 			continue;
 
 		/* Do not flush out the QUE_RING and ABORT/CLOSE iocbs */
-		if (cmd->ulpCommand == CMD_QUE_RING_BUF_CN ||
-		    cmd->ulpCommand == CMD_QUE_RING_BUF64_CN ||
-		    cmd->ulpCommand == CMD_CLOSE_XRI_CN ||
-		    cmd->ulpCommand == CMD_ABORT_XRI_CN)
+		if (ulp_command == CMD_QUE_RING_BUF_CN ||
+		    ulp_command == CMD_QUE_RING_BUF64_CN ||
+		    ulp_command == CMD_CLOSE_XRI_CN ||
+		    ulp_command == CMD_ABORT_XRI_CN ||
+		    ulp_command == CMD_ABORT_XRI_CX)
 			continue;
 
 		if (piocb->vport != vport)
@@ -9489,7 +9515,6 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 	if (vport == phba->pport) {
 		list_for_each_entry_safe(piocb, tmp_iocb,
 					 &phba->fabric_iocb_list, list) {
-			cmd = &piocb->iocb;
 			list_del_init(&piocb->list);
 			list_add_tail(&piocb->list, &abort_list);
 		}
@@ -9557,12 +9582,16 @@ lpfc_send_els_failure_event(struct lpfc_hba *phba,
 	struct ls_rjt stat;
 	struct lpfc_nodelist *ndlp;
 	uint32_t *pcmd;
+	u32 ulp_status, ulp_word4;
 
 	ndlp = cmdiocbp->context1;
 	if (!ndlp)
 		return;
 
-	if (rspiocbp->iocb.ulpStatus == IOSTAT_LS_RJT) {
+	ulp_status = get_job_ulpstatus(phba, rspiocbp);
+	ulp_word4 = get_job_word4(phba, rspiocbp);
+
+	if (ulp_status == IOSTAT_LS_RJT) {
 		lsrjt_event.header.event_type = FC_REG_ELS_EVENT;
 		lsrjt_event.header.subcategory = LPFC_EVENT_LSRJT_RCV;
 		memcpy(lsrjt_event.header.wwpn, &ndlp->nlp_portname,
@@ -9572,7 +9601,7 @@ lpfc_send_els_failure_event(struct lpfc_hba *phba,
 		pcmd = (uint32_t *) (((struct lpfc_dmabuf *)
 			cmdiocbp->context2)->virt);
 		lsrjt_event.command = (pcmd != NULL) ? *pcmd : 0;
-		stat.un.lsRjtError = be32_to_cpu(rspiocbp->iocb.un.ulpWord[4]);
+		stat.un.ls_rjt_error_be = cpu_to_be32(ulp_word4);
 		lsrjt_event.reason_code = stat.un.b.lsRjtRsnCode;
 		lsrjt_event.explanation = stat.un.b.lsRjtRsnCodeExp;
 		fc_host_post_vendor_event(shost,
@@ -9582,10 +9611,10 @@ lpfc_send_els_failure_event(struct lpfc_hba *phba,
 			LPFC_NL_VENDOR_ID);
 		return;
 	}
-	if ((rspiocbp->iocb.ulpStatus == IOSTAT_NPORT_BSY) ||
-		(rspiocbp->iocb.ulpStatus == IOSTAT_FABRIC_BSY)) {
+	if (ulp_status == IOSTAT_NPORT_BSY ||
+	    ulp_status == IOSTAT_FABRIC_BSY) {
 		fabric_event.event_type = FC_REG_FABRIC_EVENT;
-		if (rspiocbp->iocb.ulpStatus == IOSTAT_NPORT_BSY)
+		if (ulp_status == IOSTAT_NPORT_BSY)
 			fabric_event.subcategory = LPFC_EVENT_PORT_BUSY;
 		else
 			fabric_event.subcategory = LPFC_EVENT_FABRIC_BUSY;
@@ -10098,27 +10127,32 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 {
 	struct lpfc_nodelist *ndlp;
 	struct ls_rjt stat;
-	uint32_t *payload, payload_len;
-	uint32_t cmd, did, newnode;
+	u32 *payload, payload_len;
+	u32 cmd = 0, did = 0, newnode, status = 0;
 	uint8_t rjt_exp, rjt_err = 0, init_link = 0;
-	IOCB_t *icmd = &elsiocb->iocb;
+	struct lpfc_wcqe_complete *wcqe_cmpl = NULL;
 	LPFC_MBOXQ_t *mbox;
 
 	if (!vport || !(elsiocb->context2))
 		goto dropit;
 
 	newnode = 0;
+	wcqe_cmpl = &elsiocb->wcqe_cmpl;
 	payload = ((struct lpfc_dmabuf *)elsiocb->context2)->virt;
-	payload_len = elsiocb->iocb.unsli3.rcvsli3.acc_len;
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		payload_len = wcqe_cmpl->total_data_placed;
+	else
+		payload_len = elsiocb->iocb.unsli3.rcvsli3.acc_len;
+	status = get_job_ulpstatus(phba, elsiocb);
 	cmd = *payload;
 	if ((phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) == 0)
 		lpfc_sli3_post_buffer(phba, pring, 1);
 
-	did = icmd->un.rcvels.remoteID;
-	if (icmd->ulpStatus) {
+	did = get_job_els_rsp64_did(phba, elsiocb);
+	if (status) {
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
 			"RCV Unsol ELS:  status:x%x/x%x did:x%x",
-			icmd->ulpStatus, icmd->un.ulpWord[4], did);
+			status, get_job_word4(phba, elsiocb), did);
 		goto dropit;
 	}
 
@@ -10204,7 +10238,9 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			 * the vfi. This is done in lpfc_rcv_plogi but
 			 * that is called after the reg_vfi.
 			 */
-			vport->fc_myDID = elsiocb->iocb.un.rcvels.parmRo;
+			vport->fc_myDID =
+				bf_get(els_rsp64_sid,
+				       &elsiocb->wqe.xmit_els_rsp);
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 					 "3312 Remote port assigned DID x%x "
 					 "%x\n", vport->fc_myDID,
@@ -10549,8 +10585,9 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	if (vport && !(vport->load_flag & FC_UNLOADING))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0111 Dropping received ELS cmd "
-			"Data: x%x x%x x%x\n",
-			icmd->ulpStatus, icmd->un.ulpWord[4], icmd->ulpTimeout);
+			"Data: x%x x%x x%x x%x\n",
+			cmd, status, get_job_word4(phba, elsiocb), did);
+
 	phba->fc_stat.elsRcvDrop++;
 }
 
@@ -10570,20 +10607,31 @@ void
 lpfc_els_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		     struct lpfc_iocbq *elsiocb)
 {
-	struct lpfc_vport *vport = phba->pport;
-	IOCB_t *icmd = &elsiocb->iocb;
-	dma_addr_t paddr;
+	struct lpfc_vport *vport = elsiocb->vport;
+	u32 ulp_command, status, parameter, bde_count = 0;
+	IOCB_t *icmd;
+	struct lpfc_wcqe_complete *wcqe_cmpl = NULL;
 	struct lpfc_dmabuf *bdeBuf1 = elsiocb->context2;
 	struct lpfc_dmabuf *bdeBuf2 = elsiocb->context3;
+	dma_addr_t paddr;
 
 	elsiocb->context1 = NULL;
 	elsiocb->context2 = NULL;
 	elsiocb->context3 = NULL;
 
-	if (icmd->ulpStatus == IOSTAT_NEED_BUFFER) {
+	wcqe_cmpl = &elsiocb->wcqe_cmpl;
+	ulp_command = get_job_cmnd(phba, elsiocb);
+	status = get_job_ulpstatus(phba, elsiocb);
+	parameter = get_job_word4(phba, elsiocb);
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		bde_count = wcqe_cmpl->word3;
+	else
+		bde_count = elsiocb->iocb.ulpBdeCount;
+
+	if (status == IOSTAT_NEED_BUFFER) {
 		lpfc_sli_hbqbuf_add_hbqs(phba, LPFC_ELS_HBQ);
-	} else if (icmd->ulpStatus == IOSTAT_LOCAL_REJECT &&
-		   (icmd->un.ulpWord[4] & IOERR_PARAM_MASK) ==
+	} else if (status == IOSTAT_LOCAL_REJECT &&
+		   (parameter & IOERR_PARAM_MASK) ==
 		   IOERR_RCV_BUFFER_WAITING) {
 		phba->fc_stat.NoRcvBuf++;
 		/* Not enough posted buffers; Try posting more buffers */
@@ -10592,32 +10640,43 @@ lpfc_els_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		return;
 	}
 
-	if ((phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) &&
-	    (icmd->ulpCommand == CMD_IOCB_RCV_ELS64_CX ||
-	     icmd->ulpCommand == CMD_IOCB_RCV_SEQ64_CX)) {
-		if (icmd->unsli3.rcvsli3.vpi == 0xffff)
-			vport = phba->pport;
-		else
-			vport = lpfc_find_vport_by_vpid(phba,
+	if (phba->sli_rev == LPFC_SLI_REV3) {
+		icmd = &elsiocb->iocb;
+		if ((phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) &&
+		    (ulp_command == CMD_IOCB_RCV_ELS64_CX ||
+		     ulp_command == CMD_IOCB_RCV_SEQ64_CX)) {
+			if (icmd->unsli3.rcvsli3.vpi == 0xffff)
+				vport = phba->pport;
+			else
+				vport = lpfc_find_vport_by_vpid(phba,
 						icmd->unsli3.rcvsli3.vpi);
+		}
 	}
 
 	/* If there are no BDEs associated
 	 * with this IOCB, there is nothing to do.
 	 */
-	if (icmd->ulpBdeCount == 0)
+	if (bde_count == 0)
 		return;
 
-	/* type of ELS cmd is first 32bit word
-	 * in packet
-	 */
+	/* Account for SLI2 or SLI3 and later unsolicited buffering */
 	if (phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) {
 		elsiocb->context2 = bdeBuf1;
+		if (bde_count == 2)
+			elsiocb->context3 = bdeBuf2;
 	} else {
+		icmd = &elsiocb->iocb;
 		paddr = getPaddr(icmd->un.cont64[0].addrHigh,
 				 icmd->un.cont64[0].addrLow);
 		elsiocb->context2 = lpfc_sli_ringpostbuf_get(phba, pring,
 							     paddr);
+		if (bde_count == 2) {
+			paddr = getPaddr(icmd->un.cont64[1].addrHigh,
+					 icmd->un.cont64[1].addrLow);
+			elsiocb->context3 = lpfc_sli_ringpostbuf_get(phba,
+								       pring,
+								       paddr);
+		}
 	}
 
 	lpfc_els_unsol_buffer(phba, pring, vport, elsiocb);
@@ -10630,16 +10689,9 @@ lpfc_els_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		elsiocb->context2 = NULL;
 	}
 
-	/* RCV_ELS64_CX provide for 2 BDEs - process 2nd if included */
-	if ((phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) &&
-	    icmd->ulpBdeCount == 2) {
-		elsiocb->context2 = bdeBuf2;
-		lpfc_els_unsol_buffer(phba, pring, vport, elsiocb);
-		/* free mp if we are done with it */
-		if (elsiocb->context2) {
-			lpfc_in_buf_free(phba, elsiocb->context2);
-			elsiocb->context2 = NULL;
-		}
+	if (elsiocb->context3) {
+		lpfc_in_buf_free(phba, elsiocb->context3);
+		elsiocb->context3 = NULL;
 	}
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 816fc406135b..d94435494281 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5059,7 +5059,8 @@ lpfc_can_disctmo(struct lpfc_vport *vport)
 		vport->port_state, vport->fc_ns_retry, vport->fc_flag);
 
 	/* Turn off discovery timer if its running */
-	if (vport->fc_flag & FC_DISC_TMO) {
+	if (vport->fc_flag & FC_DISC_TMO ||
+	    timer_pending(&vport->fc_disctmo)) {
 		spin_lock_irqsave(shost->host_lock, iflags);
 		vport->fc_flag &= ~FC_DISC_TMO;
 		spin_unlock_irqrestore(shost->host_lock, iflags);
@@ -5088,20 +5089,26 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 		    struct lpfc_iocbq *iocb,
 		    struct lpfc_nodelist *ndlp)
 {
-	IOCB_t *icmd = &iocb->iocb;
-	struct lpfc_vport    *vport = ndlp->vport;
+	struct lpfc_vport *vport = ndlp->vport;
+	u8 ulp_command;
+	u16 ulp_context;
+	u32 remote_id;
 
 	if (iocb->vport != vport)
 		return 0;
 
+	ulp_command = get_job_cmnd(phba, iocb);
+	ulp_context = get_job_ulpcontext(phba, iocb);
+	remote_id = get_job_els_rsp64_did(phba, iocb);
+
 	if (pring->ringno == LPFC_ELS_RING) {
-		switch (icmd->ulpCommand) {
+		switch (ulp_command) {
 		case CMD_GEN_REQUEST64_CR:
 			if (iocb->context_un.ndlp == ndlp)
 				return 1;
 			fallthrough;
 		case CMD_ELS_REQUEST64_CR:
-			if (icmd->un.elsreq64.remoteID == ndlp->nlp_DID)
+			if (remote_id == ndlp->nlp_DID)
 				return 1;
 			fallthrough;
 		case CMD_XMIT_ELS_RSP64_CX:
@@ -5114,9 +5121,8 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 		    (ndlp->nlp_flag & NLP_DELAY_TMO)) {
 			return 0;
 		}
-		if (icmd->ulpContext == (volatile ushort)ndlp->nlp_rpi) {
+		if (ulp_context == ndlp->nlp_rpi)
 			return 1;
-		}
 	}
 	return 0;
 }
@@ -6027,9 +6033,9 @@ static void
 lpfc_free_tx(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 {
 	LIST_HEAD(completions);
-	IOCB_t     *icmd;
 	struct lpfc_iocbq    *iocb, *next_iocb;
 	struct lpfc_sli_ring *pring;
+	u32 ulp_command;
 
 	pring = lpfc_phba_elsring(phba);
 	if (unlikely(!pring))
@@ -6040,12 +6046,13 @@ lpfc_free_tx(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	 */
 	spin_lock_irq(&phba->hbalock);
 	list_for_each_entry_safe(iocb, next_iocb, &pring->txq, list) {
-		if (iocb->context1 != ndlp) {
+		if (iocb->context1 != ndlp)
 			continue;
-		}
-		icmd = &iocb->iocb;
-		if ((icmd->ulpCommand == CMD_ELS_REQUEST64_CR) ||
-		    (icmd->ulpCommand == CMD_XMIT_ELS_RSP64_CX)) {
+
+		ulp_command = get_job_cmnd(phba, iocb);
+
+		if (ulp_command == CMD_ELS_REQUEST64_CR ||
+		    ulp_command == CMD_XMIT_ELS_RSP64_CX) {
 
 			list_move_tail(&iocb->list, &completions);
 		}
@@ -6053,12 +6060,13 @@ lpfc_free_tx(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 
 	/* Next check the txcmplq */
 	list_for_each_entry_safe(iocb, next_iocb, &pring->txcmplq, list) {
-		if (iocb->context1 != ndlp) {
+		if (iocb->context1 != ndlp)
 			continue;
-		}
-		icmd = &iocb->iocb;
-		if (icmd->ulpCommand == CMD_ELS_REQUEST64_CR ||
-		    icmd->ulpCommand == CMD_XMIT_ELS_RSP64_CX) {
+
+		ulp_command = get_job_cmnd(phba, iocb);
+
+		if (ulp_command == CMD_ELS_REQUEST64_CR ||
+		    ulp_command == CMD_XMIT_ELS_RSP64_CX) {
 			lpfc_sli_issue_abort_iotag(phba, pring, iocb, NULL);
 		}
 	}
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 8964518d89f9..3af58346602a 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -171,9 +171,8 @@ lpfc_check_elscmpl_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_dmabuf *pcmd, *prsp;
 	uint32_t *lp;
 	void     *ptr = NULL;
-	IOCB_t   *irsp;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	irsp = &rspiocb->iocb;
 	pcmd = (struct lpfc_dmabuf *) cmdiocb->context2;
 
 	/* For lpfc_els_abort, context2 could be zero'ed to delay
@@ -187,10 +186,16 @@ lpfc_check_elscmpl_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			ptr = (void *)((uint8_t *)lp + sizeof(uint32_t));
 		}
 	} else {
-		/* Force ulpStatus error since we are returning NULL ptr */
-		if (!(irsp->ulpStatus)) {
-			irsp->ulpStatus = IOSTAT_LOCAL_REJECT;
-			irsp->un.ulpWord[4] = IOERR_SLI_ABORTED;
+		/* Force ulp_status error since we are returning NULL ptr */
+		if (!(ulp_status)) {
+			if (phba->sli_rev == LPFC_SLI_REV4) {
+				bf_set(lpfc_wcqe_c_status, &rspiocb->wcqe_cmpl,
+				       IOSTAT_LOCAL_REJECT);
+				rspiocb->wcqe_cmpl.parameter = IOERR_SLI_ABORTED;
+			} else {
+				rspiocb->iocb.ulpStatus = IOSTAT_LOCAL_REJECT;
+				rspiocb->iocb.un.ulpWord[4] = IOERR_SLI_ABORTED;
+			}
 		}
 		ptr = NULL;
 	}
@@ -325,6 +330,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	struct lpfc_dmabuf *mp;
 	uint64_t nlp_portwwn = 0;
 	uint32_t *lp;
+	union lpfc_wqe128 *wqe;
 	IOCB_t *icmd;
 	struct serv_parm *sp;
 	uint32_t ed_tov;
@@ -334,6 +340,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	struct ls_rjt stat;
 	uint32_t vid, flag;
 	int rc;
+	u32 remote_did;
 
 	memset(&stat, 0, sizeof (struct ls_rjt));
 	pcmd = (struct lpfc_dmabuf *) cmdiocb->context2;
@@ -367,7 +374,11 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			NULL);
 		return 0;
 	}
-	icmd = &cmdiocb->iocb;
+
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		wqe = &cmdiocb->wqe;
+	else
+		icmd = &cmdiocb->iocb;
 
 	/* PLOGI chkparm OK */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
@@ -457,7 +468,12 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if ((vport->fc_flag & FC_PT2PT) &&
 	    !(vport->fc_flag & FC_PT2PT_PLOGI)) {
 		/* rcv'ed PLOGI decides what our NPortId will be */
-		vport->fc_myDID = icmd->un.rcvels.parmRo;
+		if (phba->sli_rev == LPFC_SLI_REV4) {
+			vport->fc_myDID = bf_get(els_rsp64_sid,
+						 &cmdiocb->wqe.xmit_els_rsp);
+		} else {
+			vport->fc_myDID = icmd->un.rcvels.parmRo;
+		}
 
 		/* If there is an outstanding FLOGI, abort it now.
 		 * The remote NPort is not going to ACC our FLOGI
@@ -538,7 +554,11 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* Issue REG_LOGIN first, before ACCing the PLOGI, thus we will
 	 * always be deferring the ACC.
 	 */
-	rc = lpfc_reg_rpi(phba, vport->vpi, icmd->un.rcvels.remoteID,
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		remote_did = bf_get(wqe_els_did, &wqe->xmit_els_rsp.wqe_dest);
+	else
+		remote_did = icmd->un.rcvels.remoteID;
+	rc = lpfc_reg_rpi(phba, vport->vpi, remote_did,
 			    (uint8_t *)sp, login_mbox, ndlp->nlp_rpi);
 	if (rc)
 		goto out;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index d2f5c8c80491..89a0f8cea1ff 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1535,16 +1535,20 @@ lpfc_sli_cancel_iocbs(struct lpfc_hba *phba, struct list_head *iocblist,
 	while (!list_empty(iocblist)) {
 		list_remove_head(iocblist, piocb, struct lpfc_iocbq, list);
 		if (piocb->cmd_cmpl) {
-			if (piocb->cmd_flag & LPFC_IO_NVME)
+			if (piocb->cmd_flag & LPFC_IO_NVME) {
 				lpfc_nvme_cancel_iocb(phba, piocb,
 						      ulpstatus, ulpWord4);
-			else
-				lpfc_sli_release_iocbq(phba, piocb);
-
-		} else if (piocb->cmd_cmpl) {
-			piocb->iocb.ulpStatus = ulpstatus;
-			piocb->iocb.un.ulpWord[4] = ulpWord4;
-			(piocb->cmd_cmpl) (phba, piocb, piocb);
+			} else {
+				if (phba->sli_rev == LPFC_SLI_REV4) {
+					bf_set(lpfc_wcqe_c_status,
+					       &piocb->wcqe_cmpl, ulpstatus);
+					piocb->wcqe_cmpl.parameter = ulpWord4;
+				} else {
+					piocb->iocb.ulpStatus = ulpstatus;
+					piocb->iocb.un.ulpWord[4] = ulpWord4;
+				}
+				(piocb->cmd_cmpl) (phba, piocb, piocb);
+			}
 		} else {
 			lpfc_sli_release_iocbq(phba, piocb);
 		}
@@ -10196,715 +10200,6 @@ __lpfc_sli_issue_iocb_s3(struct lpfc_hba *phba, uint32_t ring_number,
 	return IOCB_BUSY;
 }
 
-/**
- * lpfc_sli4_bpl2sgl - Convert the bpl/bde to a sgl.
- * @phba: Pointer to HBA context object.
- * @piocbq: Pointer to command iocb.
- * @sglq: Pointer to the scatter gather queue object.
- *
- * This routine converts the bpl or bde that is in the IOCB
- * to a sgl list for the sli4 hardware. The physical address
- * of the bpl/bde is converted back to a virtual address.
- * If the IOCB contains a BPL then the list of BDE's is
- * converted to sli4_sge's. If the IOCB contains a single
- * BDE then it is converted to a single sli_sge.
- * The IOCB is still in cpu endianess so the contents of
- * the bpl can be used without byte swapping.
- *
- * Returns valid XRI = Success, NO_XRI = Failure.
-**/
-static uint16_t
-lpfc_sli4_bpl2sgl(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq,
-		struct lpfc_sglq *sglq)
-{
-	uint16_t xritag = NO_XRI;
-	struct ulp_bde64 *bpl = NULL;
-	struct ulp_bde64 bde;
-	struct sli4_sge *sgl  = NULL;
-	struct lpfc_dmabuf *dmabuf;
-	IOCB_t *icmd;
-	int numBdes = 0;
-	int i = 0;
-	uint32_t offset = 0; /* accumulated offset in the sg request list */
-	int inbound = 0; /* number of sg reply entries inbound from firmware */
-
-	if (!piocbq || !sglq)
-		return xritag;
-
-	sgl  = (struct sli4_sge *)sglq->sgl;
-	icmd = &piocbq->iocb;
-	if (icmd->ulpCommand == CMD_XMIT_BLS_RSP64_CX)
-		return sglq->sli4_xritag;
-	if (icmd->un.genreq64.bdl.bdeFlags == BUFF_TYPE_BLP_64) {
-		numBdes = icmd->un.genreq64.bdl.bdeSize /
-				sizeof(struct ulp_bde64);
-		/* The addrHigh and addrLow fields within the IOCB
-		 * have not been byteswapped yet so there is no
-		 * need to swap them back.
-		 */
-		if (piocbq->context3)
-			dmabuf = (struct lpfc_dmabuf *)piocbq->context3;
-		else
-			return xritag;
-
-		bpl  = (struct ulp_bde64 *)dmabuf->virt;
-		if (!bpl)
-			return xritag;
-
-		for (i = 0; i < numBdes; i++) {
-			/* Should already be byte swapped. */
-			sgl->addr_hi = bpl->addrHigh;
-			sgl->addr_lo = bpl->addrLow;
-
-			sgl->word2 = le32_to_cpu(sgl->word2);
-			if ((i+1) == numBdes)
-				bf_set(lpfc_sli4_sge_last, sgl, 1);
-			else
-				bf_set(lpfc_sli4_sge_last, sgl, 0);
-			/* swap the size field back to the cpu so we
-			 * can assign it to the sgl.
-			 */
-			bde.tus.w = le32_to_cpu(bpl->tus.w);
-			sgl->sge_len = cpu_to_le32(bde.tus.f.bdeSize);
-			/* The offsets in the sgl need to be accumulated
-			 * separately for the request and reply lists.
-			 * The request is always first, the reply follows.
-			 */
-			if (piocbq->iocb.ulpCommand == CMD_GEN_REQUEST64_CR) {
-				/* add up the reply sg entries */
-				if (bpl->tus.f.bdeFlags == BUFF_TYPE_BDE_64I)
-					inbound++;
-				/* first inbound? reset the offset */
-				if (inbound == 1)
-					offset = 0;
-				bf_set(lpfc_sli4_sge_offset, sgl, offset);
-				bf_set(lpfc_sli4_sge_type, sgl,
-					LPFC_SGE_TYPE_DATA);
-				offset += bde.tus.f.bdeSize;
-			}
-			sgl->word2 = cpu_to_le32(sgl->word2);
-			bpl++;
-			sgl++;
-		}
-	} else if (icmd->un.genreq64.bdl.bdeFlags == BUFF_TYPE_BDE_64) {
-			/* The addrHigh and addrLow fields of the BDE have not
-			 * been byteswapped yet so they need to be swapped
-			 * before putting them in the sgl.
-			 */
-			sgl->addr_hi =
-				cpu_to_le32(icmd->un.genreq64.bdl.addrHigh);
-			sgl->addr_lo =
-				cpu_to_le32(icmd->un.genreq64.bdl.addrLow);
-			sgl->word2 = le32_to_cpu(sgl->word2);
-			bf_set(lpfc_sli4_sge_last, sgl, 1);
-			sgl->word2 = cpu_to_le32(sgl->word2);
-			sgl->sge_len =
-				cpu_to_le32(icmd->un.genreq64.bdl.bdeSize);
-	}
-	return sglq->sli4_xritag;
-}
-
-/**
- * lpfc_sli4_iocb2wqe - Convert the IOCB to a work queue entry.
- * @phba: Pointer to HBA context object.
- * @iocbq: Pointer to command iocb.
- * @wqe: Pointer to the work queue entry.
- *
- * This routine converts the iocb command to its Work Queue Entry
- * equivalent. The wqe pointer should not have any fields set when
- * this routine is called because it will memcpy over them.
- * This routine does not set the CQ_ID or the WQEC bits in the
- * wqe.
- *
- * Returns: 0 = Success, IOCB_ERROR = Failure.
- **/
-static int
-lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
-		union lpfc_wqe128 *wqe)
-{
-	uint32_t xmit_len = 0, total_len = 0;
-	uint8_t ct = 0;
-	uint32_t fip;
-	uint32_t abort_tag;
-	uint8_t command_type = ELS_COMMAND_NON_FIP;
-	uint8_t cmnd;
-	uint16_t xritag;
-	uint16_t abrt_iotag;
-	struct lpfc_iocbq *abrtiocbq;
-	struct ulp_bde64 *bpl = NULL;
-	uint32_t els_id = LPFC_ELS_ID_DEFAULT;
-	int numBdes, i;
-	struct ulp_bde64 bde;
-	struct lpfc_nodelist *ndlp;
-	uint32_t *pcmd;
-	uint32_t if_type;
-
-	fip = phba->hba_flag & HBA_FIP_SUPPORT;
-	/* The fcp commands will set command type */
-	if (iocbq->cmd_flag &  LPFC_IO_FCP)
-		command_type = FCP_COMMAND;
-	else if (fip && (iocbq->cmd_flag & LPFC_FIP_ELS_ID_MASK))
-		command_type = ELS_COMMAND_FIP;
-	else
-		command_type = ELS_COMMAND_NON_FIP;
-
-	if (phba->fcp_embed_io)
-		memset(wqe, 0, sizeof(union lpfc_wqe128));
-	/* Some of the fields are in the right position already */
-	memcpy(wqe, &iocbq->iocb, sizeof(union lpfc_wqe));
-	/* The ct field has moved so reset */
-	wqe->generic.wqe_com.word7 = 0;
-	wqe->generic.wqe_com.word10 = 0;
-
-	abort_tag = (uint32_t) iocbq->iotag;
-	xritag = iocbq->sli4_xritag;
-	/* words0-2 bpl convert bde */
-	if (iocbq->iocb.un.genreq64.bdl.bdeFlags == BUFF_TYPE_BLP_64) {
-		numBdes = iocbq->iocb.un.genreq64.bdl.bdeSize /
-				sizeof(struct ulp_bde64);
-		bpl  = (struct ulp_bde64 *)
-			((struct lpfc_dmabuf *)iocbq->context3)->virt;
-		if (!bpl)
-			return IOCB_ERROR;
-
-		/* Should already be byte swapped. */
-		wqe->generic.bde.addrHigh =  le32_to_cpu(bpl->addrHigh);
-		wqe->generic.bde.addrLow =  le32_to_cpu(bpl->addrLow);
-		/* swap the size field back to the cpu so we
-		 * can assign it to the sgl.
-		 */
-		wqe->generic.bde.tus.w  = le32_to_cpu(bpl->tus.w);
-		xmit_len = wqe->generic.bde.tus.f.bdeSize;
-		total_len = 0;
-		for (i = 0; i < numBdes; i++) {
-			bde.tus.w  = le32_to_cpu(bpl[i].tus.w);
-			total_len += bde.tus.f.bdeSize;
-		}
-	} else
-		xmit_len = iocbq->iocb.un.fcpi64.bdl.bdeSize;
-
-	iocbq->iocb.ulpIoTag = iocbq->iotag;
-	cmnd = iocbq->iocb.ulpCommand;
-
-	switch (iocbq->iocb.ulpCommand) {
-	case CMD_ELS_REQUEST64_CR:
-		if (iocbq->cmd_flag & LPFC_IO_LIBDFC)
-			ndlp = iocbq->context_un.ndlp;
-		else
-			ndlp = (struct lpfc_nodelist *)iocbq->context1;
-		if (!iocbq->iocb.ulpLe) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"2007 Only Limited Edition cmd Format"
-				" supported 0x%x\n",
-				iocbq->iocb.ulpCommand);
-			return IOCB_ERROR;
-		}
-
-		wqe->els_req.payload_len = xmit_len;
-		/* Els_reguest64 has a TMO */
-		bf_set(wqe_tmo, &wqe->els_req.wqe_com,
-			iocbq->iocb.ulpTimeout);
-		/* Need a VF for word 4 set the vf bit*/
-		bf_set(els_req64_vf, &wqe->els_req, 0);
-		/* And a VFID for word 12 */
-		bf_set(els_req64_vfid, &wqe->els_req, 0);
-		ct = ((iocbq->iocb.ulpCt_h << 1) | iocbq->iocb.ulpCt_l);
-		bf_set(wqe_ctxt_tag, &wqe->els_req.wqe_com,
-		       iocbq->iocb.ulpContext);
-		bf_set(wqe_ct, &wqe->els_req.wqe_com, ct);
-		bf_set(wqe_pu, &wqe->els_req.wqe_com, 0);
-		/* CCP CCPE PV PRI in word10 were set in the memcpy */
-		if (command_type == ELS_COMMAND_FIP)
-			els_id = ((iocbq->cmd_flag & LPFC_FIP_ELS_ID_MASK)
-					>> LPFC_FIP_ELS_ID_SHIFT);
-		pcmd = (uint32_t *) (((struct lpfc_dmabuf *)
-					iocbq->context2)->virt);
-		if_type = bf_get(lpfc_sli_intf_if_type,
-					&phba->sli4_hba.sli_intf);
-		if (if_type >= LPFC_SLI_INTF_IF_TYPE_2) {
-			if (pcmd && (*pcmd == ELS_CMD_FLOGI ||
-				*pcmd == ELS_CMD_SCR ||
-				*pcmd == ELS_CMD_RDF ||
-				*pcmd == ELS_CMD_EDC ||
-				*pcmd == ELS_CMD_RSCN_XMT ||
-				*pcmd == ELS_CMD_FDISC ||
-				*pcmd == ELS_CMD_LOGO ||
-				*pcmd == ELS_CMD_QFPA ||
-				*pcmd == ELS_CMD_UVEM ||
-				*pcmd == ELS_CMD_PLOGI)) {
-				bf_set(els_req64_sp, &wqe->els_req, 1);
-				bf_set(els_req64_sid, &wqe->els_req,
-					iocbq->vport->fc_myDID);
-				if ((*pcmd == ELS_CMD_FLOGI) &&
-					!(phba->fc_topology ==
-						LPFC_TOPOLOGY_LOOP))
-					bf_set(els_req64_sid, &wqe->els_req, 0);
-				bf_set(wqe_ct, &wqe->els_req.wqe_com, 1);
-				bf_set(wqe_ctxt_tag, &wqe->els_req.wqe_com,
-					phba->vpi_ids[iocbq->vport->vpi]);
-			} else if (pcmd && iocbq->context1) {
-				bf_set(wqe_ct, &wqe->els_req.wqe_com, 0);
-				bf_set(wqe_ctxt_tag, &wqe->els_req.wqe_com,
-					phba->sli4_hba.rpi_ids[ndlp->nlp_rpi]);
-			}
-		}
-		bf_set(wqe_temp_rpi, &wqe->els_req.wqe_com,
-		       phba->sli4_hba.rpi_ids[ndlp->nlp_rpi]);
-		bf_set(wqe_els_id, &wqe->els_req.wqe_com, els_id);
-		bf_set(wqe_dbde, &wqe->els_req.wqe_com, 1);
-		bf_set(wqe_iod, &wqe->els_req.wqe_com, LPFC_WQE_IOD_READ);
-		bf_set(wqe_qosd, &wqe->els_req.wqe_com, 1);
-		bf_set(wqe_lenloc, &wqe->els_req.wqe_com, LPFC_WQE_LENLOC_NONE);
-		bf_set(wqe_ebde_cnt, &wqe->els_req.wqe_com, 0);
-		wqe->els_req.max_response_payload_len = total_len - xmit_len;
-		break;
-	case CMD_XMIT_SEQUENCE64_CX:
-		bf_set(wqe_ctxt_tag, &wqe->xmit_sequence.wqe_com,
-		       iocbq->iocb.un.ulpWord[3]);
-		bf_set(wqe_rcvoxid, &wqe->xmit_sequence.wqe_com,
-		       iocbq->iocb.unsli3.rcvsli3.ox_id);
-		/* The entire sequence is transmitted for this IOCB */
-		xmit_len = total_len;
-		cmnd = CMD_XMIT_SEQUENCE64_CR;
-		if (phba->link_flag & LS_LOOPBACK_MODE)
-			bf_set(wqe_xo, &wqe->xmit_sequence.wge_ctl, 1);
-		fallthrough;
-	case CMD_XMIT_SEQUENCE64_CR:
-		/* word3 iocb=io_tag32 wqe=reserved */
-		wqe->xmit_sequence.rsvd3 = 0;
-		/* word4 relative_offset memcpy */
-		/* word5 r_ctl/df_ctl memcpy */
-		bf_set(wqe_pu, &wqe->xmit_sequence.wqe_com, 0);
-		bf_set(wqe_dbde, &wqe->xmit_sequence.wqe_com, 1);
-		bf_set(wqe_iod, &wqe->xmit_sequence.wqe_com,
-		       LPFC_WQE_IOD_WRITE);
-		bf_set(wqe_lenloc, &wqe->xmit_sequence.wqe_com,
-		       LPFC_WQE_LENLOC_WORD12);
-		bf_set(wqe_ebde_cnt, &wqe->xmit_sequence.wqe_com, 0);
-		wqe->xmit_sequence.xmit_len = xmit_len;
-		command_type = OTHER_COMMAND;
-		break;
-	case CMD_XMIT_BCAST64_CN:
-		/* word3 iocb=iotag32 wqe=seq_payload_len */
-		wqe->xmit_bcast64.seq_payload_len = xmit_len;
-		/* word4 iocb=rsvd wqe=rsvd */
-		/* word5 iocb=rctl/type/df_ctl wqe=rctl/type/df_ctl memcpy */
-		/* word6 iocb=ctxt_tag/io_tag wqe=ctxt_tag/xri */
-		bf_set(wqe_ct, &wqe->xmit_bcast64.wqe_com,
-			((iocbq->iocb.ulpCt_h << 1) | iocbq->iocb.ulpCt_l));
-		bf_set(wqe_dbde, &wqe->xmit_bcast64.wqe_com, 1);
-		bf_set(wqe_iod, &wqe->xmit_bcast64.wqe_com, LPFC_WQE_IOD_WRITE);
-		bf_set(wqe_lenloc, &wqe->xmit_bcast64.wqe_com,
-		       LPFC_WQE_LENLOC_WORD3);
-		bf_set(wqe_ebde_cnt, &wqe->xmit_bcast64.wqe_com, 0);
-		break;
-	case CMD_FCP_IWRITE64_CR:
-		command_type = FCP_COMMAND_DATA_OUT;
-		/* word3 iocb=iotag wqe=payload_offset_len */
-		/* Add the FCP_CMD and FCP_RSP sizes to get the offset */
-		bf_set(payload_offset_len, &wqe->fcp_iwrite,
-		       xmit_len + sizeof(struct fcp_rsp));
-		bf_set(cmd_buff_len, &wqe->fcp_iwrite,
-		       0);
-		/* word4 iocb=parameter wqe=total_xfer_length memcpy */
-		/* word5 iocb=initial_xfer_len wqe=initial_xfer_len memcpy */
-		bf_set(wqe_erp, &wqe->fcp_iwrite.wqe_com,
-		       iocbq->iocb.ulpFCP2Rcvy);
-		bf_set(wqe_lnk, &wqe->fcp_iwrite.wqe_com, iocbq->iocb.ulpXS);
-		/* Always open the exchange */
-		bf_set(wqe_iod, &wqe->fcp_iwrite.wqe_com, LPFC_WQE_IOD_WRITE);
-		bf_set(wqe_lenloc, &wqe->fcp_iwrite.wqe_com,
-		       LPFC_WQE_LENLOC_WORD4);
-		bf_set(wqe_pu, &wqe->fcp_iwrite.wqe_com, iocbq->iocb.ulpPU);
-		bf_set(wqe_dbde, &wqe->fcp_iwrite.wqe_com, 1);
-		if (iocbq->cmd_flag & LPFC_IO_OAS) {
-			bf_set(wqe_oas, &wqe->fcp_iwrite.wqe_com, 1);
-			bf_set(wqe_ccpe, &wqe->fcp_iwrite.wqe_com, 1);
-			if (iocbq->priority) {
-				bf_set(wqe_ccp, &wqe->fcp_iwrite.wqe_com,
-				       (iocbq->priority << 1));
-			} else {
-				bf_set(wqe_ccp, &wqe->fcp_iwrite.wqe_com,
-				       (phba->cfg_XLanePriority << 1));
-			}
-		}
-		/* Note, word 10 is already initialized to 0 */
-
-		/* Don't set PBDE for Perf hints, just lpfc_enable_pbde */
-		if (phba->cfg_enable_pbde)
-			bf_set(wqe_pbde, &wqe->fcp_iwrite.wqe_com, 1);
-		else
-			bf_set(wqe_pbde, &wqe->fcp_iwrite.wqe_com, 0);
-
-		if (phba->fcp_embed_io) {
-			struct lpfc_io_buf *lpfc_cmd;
-			struct sli4_sge *sgl;
-			struct fcp_cmnd *fcp_cmnd;
-			uint32_t *ptr;
-
-			/* 128 byte wqe support here */
-
-			lpfc_cmd = iocbq->context1;
-			sgl = (struct sli4_sge *)lpfc_cmd->dma_sgl;
-			fcp_cmnd = lpfc_cmd->fcp_cmnd;
-
-			/* Word 0-2 - FCP_CMND */
-			wqe->generic.bde.tus.f.bdeFlags =
-				BUFF_TYPE_BDE_IMMED;
-			wqe->generic.bde.tus.f.bdeSize = sgl->sge_len;
-			wqe->generic.bde.addrHigh = 0;
-			wqe->generic.bde.addrLow =  88;  /* Word 22 */
-
-			bf_set(wqe_wqes, &wqe->fcp_iwrite.wqe_com, 1);
-			bf_set(wqe_dbde, &wqe->fcp_iwrite.wqe_com, 0);
-
-			/* Word 22-29  FCP CMND Payload */
-			ptr = &wqe->words[22];
-			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
-		}
-		break;
-	case CMD_FCP_IREAD64_CR:
-		/* word3 iocb=iotag wqe=payload_offset_len */
-		/* Add the FCP_CMD and FCP_RSP sizes to get the offset */
-		bf_set(payload_offset_len, &wqe->fcp_iread,
-		       xmit_len + sizeof(struct fcp_rsp));
-		bf_set(cmd_buff_len, &wqe->fcp_iread,
-		       0);
-		/* word4 iocb=parameter wqe=total_xfer_length memcpy */
-		/* word5 iocb=initial_xfer_len wqe=initial_xfer_len memcpy */
-		bf_set(wqe_erp, &wqe->fcp_iread.wqe_com,
-		       iocbq->iocb.ulpFCP2Rcvy);
-		bf_set(wqe_lnk, &wqe->fcp_iread.wqe_com, iocbq->iocb.ulpXS);
-		/* Always open the exchange */
-		bf_set(wqe_iod, &wqe->fcp_iread.wqe_com, LPFC_WQE_IOD_READ);
-		bf_set(wqe_lenloc, &wqe->fcp_iread.wqe_com,
-		       LPFC_WQE_LENLOC_WORD4);
-		bf_set(wqe_pu, &wqe->fcp_iread.wqe_com, iocbq->iocb.ulpPU);
-		bf_set(wqe_dbde, &wqe->fcp_iread.wqe_com, 1);
-		if (iocbq->cmd_flag & LPFC_IO_OAS) {
-			bf_set(wqe_oas, &wqe->fcp_iread.wqe_com, 1);
-			bf_set(wqe_ccpe, &wqe->fcp_iread.wqe_com, 1);
-			if (iocbq->priority) {
-				bf_set(wqe_ccp, &wqe->fcp_iread.wqe_com,
-				       (iocbq->priority << 1));
-			} else {
-				bf_set(wqe_ccp, &wqe->fcp_iread.wqe_com,
-				       (phba->cfg_XLanePriority << 1));
-			}
-		}
-		/* Note, word 10 is already initialized to 0 */
-
-		/* Don't set PBDE for Perf hints, just lpfc_enable_pbde */
-		if (phba->cfg_enable_pbde)
-			bf_set(wqe_pbde, &wqe->fcp_iread.wqe_com, 1);
-		else
-			bf_set(wqe_pbde, &wqe->fcp_iread.wqe_com, 0);
-
-		if (phba->fcp_embed_io) {
-			struct lpfc_io_buf *lpfc_cmd;
-			struct sli4_sge *sgl;
-			struct fcp_cmnd *fcp_cmnd;
-			uint32_t *ptr;
-
-			/* 128 byte wqe support here */
-
-			lpfc_cmd = iocbq->context1;
-			sgl = (struct sli4_sge *)lpfc_cmd->dma_sgl;
-			fcp_cmnd = lpfc_cmd->fcp_cmnd;
-
-			/* Word 0-2 - FCP_CMND */
-			wqe->generic.bde.tus.f.bdeFlags =
-				BUFF_TYPE_BDE_IMMED;
-			wqe->generic.bde.tus.f.bdeSize = sgl->sge_len;
-			wqe->generic.bde.addrHigh = 0;
-			wqe->generic.bde.addrLow =  88;  /* Word 22 */
-
-			bf_set(wqe_wqes, &wqe->fcp_iread.wqe_com, 1);
-			bf_set(wqe_dbde, &wqe->fcp_iread.wqe_com, 0);
-
-			/* Word 22-29  FCP CMND Payload */
-			ptr = &wqe->words[22];
-			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
-		}
-		break;
-	case CMD_FCP_ICMND64_CR:
-		/* word3 iocb=iotag wqe=payload_offset_len */
-		/* Add the FCP_CMD and FCP_RSP sizes to get the offset */
-		bf_set(payload_offset_len, &wqe->fcp_icmd,
-		       xmit_len + sizeof(struct fcp_rsp));
-		bf_set(cmd_buff_len, &wqe->fcp_icmd,
-		       0);
-		/* word3 iocb=IO_TAG wqe=reserved */
-		bf_set(wqe_pu, &wqe->fcp_icmd.wqe_com, 0);
-		/* Always open the exchange */
-		bf_set(wqe_dbde, &wqe->fcp_icmd.wqe_com, 1);
-		bf_set(wqe_iod, &wqe->fcp_icmd.wqe_com, LPFC_WQE_IOD_WRITE);
-		bf_set(wqe_qosd, &wqe->fcp_icmd.wqe_com, 1);
-		bf_set(wqe_lenloc, &wqe->fcp_icmd.wqe_com,
-		       LPFC_WQE_LENLOC_NONE);
-		bf_set(wqe_erp, &wqe->fcp_icmd.wqe_com,
-		       iocbq->iocb.ulpFCP2Rcvy);
-		if (iocbq->cmd_flag & LPFC_IO_OAS) {
-			bf_set(wqe_oas, &wqe->fcp_icmd.wqe_com, 1);
-			bf_set(wqe_ccpe, &wqe->fcp_icmd.wqe_com, 1);
-			if (iocbq->priority) {
-				bf_set(wqe_ccp, &wqe->fcp_icmd.wqe_com,
-				       (iocbq->priority << 1));
-			} else {
-				bf_set(wqe_ccp, &wqe->fcp_icmd.wqe_com,
-				       (phba->cfg_XLanePriority << 1));
-			}
-		}
-		/* Note, word 10 is already initialized to 0 */
-
-		if (phba->fcp_embed_io) {
-			struct lpfc_io_buf *lpfc_cmd;
-			struct sli4_sge *sgl;
-			struct fcp_cmnd *fcp_cmnd;
-			uint32_t *ptr;
-
-			/* 128 byte wqe support here */
-
-			lpfc_cmd = iocbq->context1;
-			sgl = (struct sli4_sge *)lpfc_cmd->dma_sgl;
-			fcp_cmnd = lpfc_cmd->fcp_cmnd;
-
-			/* Word 0-2 - FCP_CMND */
-			wqe->generic.bde.tus.f.bdeFlags =
-				BUFF_TYPE_BDE_IMMED;
-			wqe->generic.bde.tus.f.bdeSize = sgl->sge_len;
-			wqe->generic.bde.addrHigh = 0;
-			wqe->generic.bde.addrLow =  88;  /* Word 22 */
-
-			bf_set(wqe_wqes, &wqe->fcp_icmd.wqe_com, 1);
-			bf_set(wqe_dbde, &wqe->fcp_icmd.wqe_com, 0);
-
-			/* Word 22-29  FCP CMND Payload */
-			ptr = &wqe->words[22];
-			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
-		}
-		break;
-	case CMD_GEN_REQUEST64_CR:
-		/* For this command calculate the xmit length of the
-		 * request bde.
-		 */
-		xmit_len = 0;
-		numBdes = iocbq->iocb.un.genreq64.bdl.bdeSize /
-			sizeof(struct ulp_bde64);
-		for (i = 0; i < numBdes; i++) {
-			bde.tus.w = le32_to_cpu(bpl[i].tus.w);
-			if (bde.tus.f.bdeFlags != BUFF_TYPE_BDE_64)
-				break;
-			xmit_len += bde.tus.f.bdeSize;
-		}
-		/* word3 iocb=IO_TAG wqe=request_payload_len */
-		wqe->gen_req.request_payload_len = xmit_len;
-		/* word4 iocb=parameter wqe=relative_offset memcpy */
-		/* word5 [rctl, type, df_ctl, la] copied in memcpy */
-		/* word6 context tag copied in memcpy */
-		if (iocbq->iocb.ulpCt_h  || iocbq->iocb.ulpCt_l) {
-			ct = ((iocbq->iocb.ulpCt_h << 1) | iocbq->iocb.ulpCt_l);
-			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"2015 Invalid CT %x command 0x%x\n",
-				ct, iocbq->iocb.ulpCommand);
-			return IOCB_ERROR;
-		}
-		bf_set(wqe_ct, &wqe->gen_req.wqe_com, 0);
-		bf_set(wqe_tmo, &wqe->gen_req.wqe_com, iocbq->iocb.ulpTimeout);
-		bf_set(wqe_pu, &wqe->gen_req.wqe_com, iocbq->iocb.ulpPU);
-		bf_set(wqe_dbde, &wqe->gen_req.wqe_com, 1);
-		bf_set(wqe_iod, &wqe->gen_req.wqe_com, LPFC_WQE_IOD_READ);
-		bf_set(wqe_qosd, &wqe->gen_req.wqe_com, 1);
-		bf_set(wqe_lenloc, &wqe->gen_req.wqe_com, LPFC_WQE_LENLOC_NONE);
-		bf_set(wqe_ebde_cnt, &wqe->gen_req.wqe_com, 0);
-		wqe->gen_req.max_response_payload_len = total_len - xmit_len;
-		command_type = OTHER_COMMAND;
-		break;
-	case CMD_XMIT_ELS_RSP64_CX:
-		ndlp = (struct lpfc_nodelist *)iocbq->context1;
-		/* words0-2 BDE memcpy */
-		/* word3 iocb=iotag32 wqe=response_payload_len */
-		wqe->xmit_els_rsp.response_payload_len = xmit_len;
-		/* word4 */
-		wqe->xmit_els_rsp.word4 = 0;
-		/* word5 iocb=rsvd wge=did */
-		bf_set(wqe_els_did, &wqe->xmit_els_rsp.wqe_dest,
-			 iocbq->iocb.un.xseq64.xmit_els_remoteID);
-
-		if_type = bf_get(lpfc_sli_intf_if_type,
-					&phba->sli4_hba.sli_intf);
-		if (if_type >= LPFC_SLI_INTF_IF_TYPE_2) {
-			if (iocbq->vport->fc_flag & FC_PT2PT) {
-				bf_set(els_rsp64_sp, &wqe->xmit_els_rsp, 1);
-				bf_set(els_rsp64_sid, &wqe->xmit_els_rsp,
-					iocbq->vport->fc_myDID);
-				if (iocbq->vport->fc_myDID == Fabric_DID) {
-					bf_set(wqe_els_did,
-						&wqe->xmit_els_rsp.wqe_dest, 0);
-				}
-			}
-		}
-		bf_set(wqe_ct, &wqe->xmit_els_rsp.wqe_com,
-		       ((iocbq->iocb.ulpCt_h << 1) | iocbq->iocb.ulpCt_l));
-		bf_set(wqe_pu, &wqe->xmit_els_rsp.wqe_com, iocbq->iocb.ulpPU);
-		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
-		       iocbq->iocb.unsli3.rcvsli3.ox_id);
-		if (!iocbq->iocb.ulpCt_h && iocbq->iocb.ulpCt_l)
-			bf_set(wqe_ctxt_tag, &wqe->xmit_els_rsp.wqe_com,
-			       phba->vpi_ids[iocbq->vport->vpi]);
-		bf_set(wqe_dbde, &wqe->xmit_els_rsp.wqe_com, 1);
-		bf_set(wqe_iod, &wqe->xmit_els_rsp.wqe_com, LPFC_WQE_IOD_WRITE);
-		bf_set(wqe_qosd, &wqe->xmit_els_rsp.wqe_com, 1);
-		bf_set(wqe_lenloc, &wqe->xmit_els_rsp.wqe_com,
-		       LPFC_WQE_LENLOC_WORD3);
-		bf_set(wqe_ebde_cnt, &wqe->xmit_els_rsp.wqe_com, 0);
-		bf_set(wqe_rsp_temp_rpi, &wqe->xmit_els_rsp,
-		       phba->sli4_hba.rpi_ids[ndlp->nlp_rpi]);
-		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
-				bf_set(els_rsp64_sp, &wqe->xmit_els_rsp, 1);
-				bf_set(els_rsp64_sid, &wqe->xmit_els_rsp,
-					iocbq->vport->fc_myDID);
-				bf_set(wqe_ct, &wqe->xmit_els_rsp.wqe_com, 1);
-				bf_set(wqe_ctxt_tag, &wqe->xmit_els_rsp.wqe_com,
-					phba->vpi_ids[phba->pport->vpi]);
-		}
-		command_type = OTHER_COMMAND;
-		break;
-	case CMD_CLOSE_XRI_CN:
-	case CMD_ABORT_XRI_CN:
-	case CMD_ABORT_XRI_CX:
-		/* words 0-2 memcpy should be 0 rserved */
-		/* port will send abts */
-		abrt_iotag = iocbq->iocb.un.acxri.abortContextTag;
-		if (abrt_iotag != 0 && abrt_iotag <= phba->sli.last_iotag) {
-			abrtiocbq = phba->sli.iocbq_lookup[abrt_iotag];
-			fip = abrtiocbq->cmd_flag & LPFC_FIP_ELS_ID_MASK;
-		} else
-			fip = 0;
-
-		if ((iocbq->iocb.ulpCommand == CMD_CLOSE_XRI_CN) || fip)
-			/*
-			 * The link is down, or the command was ELS_FIP
-			 * so the fw does not need to send abts
-			 * on the wire.
-			 */
-			bf_set(abort_cmd_ia, &wqe->abort_cmd, 1);
-		else
-			bf_set(abort_cmd_ia, &wqe->abort_cmd, 0);
-		bf_set(abort_cmd_criteria, &wqe->abort_cmd, T_XRI_TAG);
-		/* word5 iocb=CONTEXT_TAG|IO_TAG wqe=reserved */
-		wqe->abort_cmd.rsrvd5 = 0;
-		bf_set(wqe_ct, &wqe->abort_cmd.wqe_com,
-			((iocbq->iocb.ulpCt_h << 1) | iocbq->iocb.ulpCt_l));
-		abort_tag = iocbq->iocb.un.acxri.abortIoTag;
-		/*
-		 * The abort handler will send us CMD_ABORT_XRI_CN or
-		 * CMD_CLOSE_XRI_CN and the fw only accepts CMD_ABORT_XRI_CX
-		 */
-		bf_set(wqe_cmnd, &wqe->abort_cmd.wqe_com, CMD_ABORT_XRI_CX);
-		bf_set(wqe_qosd, &wqe->abort_cmd.wqe_com, 1);
-		bf_set(wqe_lenloc, &wqe->abort_cmd.wqe_com,
-		       LPFC_WQE_LENLOC_NONE);
-		cmnd = CMD_ABORT_XRI_CX;
-		command_type = OTHER_COMMAND;
-		xritag = 0;
-		break;
-	case CMD_XMIT_BLS_RSP64_CX:
-		ndlp = (struct lpfc_nodelist *)iocbq->context1;
-		/* As BLS ABTS RSP WQE is very different from other WQEs,
-		 * we re-construct this WQE here based on information in
-		 * iocbq from scratch.
-		 */
-		memset(wqe, 0, sizeof(*wqe));
-		/* OX_ID is invariable to who sent ABTS to CT exchange */
-		bf_set(xmit_bls_rsp64_oxid, &wqe->xmit_bls_rsp,
-		       bf_get(lpfc_abts_oxid, &iocbq->iocb.un.bls_rsp));
-		if (bf_get(lpfc_abts_orig, &iocbq->iocb.un.bls_rsp) ==
-		    LPFC_ABTS_UNSOL_INT) {
-			/* ABTS sent by initiator to CT exchange, the
-			 * RX_ID field will be filled with the newly
-			 * allocated responder XRI.
-			 */
-			bf_set(xmit_bls_rsp64_rxid, &wqe->xmit_bls_rsp,
-			       iocbq->sli4_xritag);
-		} else {
-			/* ABTS sent by responder to CT exchange, the
-			 * RX_ID field will be filled with the responder
-			 * RX_ID from ABTS.
-			 */
-			bf_set(xmit_bls_rsp64_rxid, &wqe->xmit_bls_rsp,
-			       bf_get(lpfc_abts_rxid, &iocbq->iocb.un.bls_rsp));
-		}
-		bf_set(xmit_bls_rsp64_seqcnthi, &wqe->xmit_bls_rsp, 0xffff);
-		bf_set(wqe_xmit_bls_pt, &wqe->xmit_bls_rsp.wqe_dest, 0x1);
-
-		/* Use CT=VPI */
-		bf_set(wqe_els_did, &wqe->xmit_bls_rsp.wqe_dest,
-			ndlp->nlp_DID);
-		bf_set(xmit_bls_rsp64_temprpi, &wqe->xmit_bls_rsp,
-			iocbq->iocb.ulpContext);
-		bf_set(wqe_ct, &wqe->xmit_bls_rsp.wqe_com, 1);
-		bf_set(wqe_ctxt_tag, &wqe->xmit_bls_rsp.wqe_com,
-			phba->vpi_ids[phba->pport->vpi]);
-		bf_set(wqe_qosd, &wqe->xmit_bls_rsp.wqe_com, 1);
-		bf_set(wqe_lenloc, &wqe->xmit_bls_rsp.wqe_com,
-		       LPFC_WQE_LENLOC_NONE);
-		/* Overwrite the pre-set comnd type with OTHER_COMMAND */
-		command_type = OTHER_COMMAND;
-		if (iocbq->iocb.un.xseq64.w5.hcsw.Rctl == FC_RCTL_BA_RJT) {
-			bf_set(xmit_bls_rsp64_rjt_vspec, &wqe->xmit_bls_rsp,
-			       bf_get(lpfc_vndr_code, &iocbq->iocb.un.bls_rsp));
-			bf_set(xmit_bls_rsp64_rjt_expc, &wqe->xmit_bls_rsp,
-			       bf_get(lpfc_rsn_expln, &iocbq->iocb.un.bls_rsp));
-			bf_set(xmit_bls_rsp64_rjt_rsnc, &wqe->xmit_bls_rsp,
-			       bf_get(lpfc_rsn_code, &iocbq->iocb.un.bls_rsp));
-		}
-
-		break;
-	case CMD_SEND_FRAME:
-		bf_set(wqe_cmnd, &wqe->generic.wqe_com, CMD_SEND_FRAME);
-		bf_set(wqe_sof, &wqe->generic.wqe_com, 0x2E); /* SOF byte */
-		bf_set(wqe_eof, &wqe->generic.wqe_com, 0x41); /* EOF byte */
-		bf_set(wqe_lenloc, &wqe->generic.wqe_com, 1);
-		bf_set(wqe_xbl, &wqe->generic.wqe_com, 1);
-		bf_set(wqe_dbde, &wqe->generic.wqe_com, 1);
-		bf_set(wqe_xc, &wqe->generic.wqe_com, 1);
-		bf_set(wqe_cmd_type, &wqe->generic.wqe_com, 0xA);
-		bf_set(wqe_cqid, &wqe->generic.wqe_com, LPFC_WQE_CQ_ID_DEFAULT);
-		bf_set(wqe_xri_tag, &wqe->generic.wqe_com, xritag);
-		bf_set(wqe_reqtag, &wqe->generic.wqe_com, iocbq->iotag);
-		return 0;
-	case CMD_XRI_ABORTED_CX:
-	case CMD_CREATE_XRI_CR: /* Do we expect to use this? */
-	case CMD_IOCB_FCP_IBIDIR64_CR: /* bidirectional xfer */
-	case CMD_FCP_TSEND64_CX: /* Target mode send xfer-ready */
-	case CMD_FCP_TRSP64_CX: /* Target mode rcv */
-	case CMD_FCP_AUTO_TRSP_CX: /* Auto target rsp */
-	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"2014 Invalid command 0x%x\n",
-				iocbq->iocb.ulpCommand);
-		return IOCB_ERROR;
-	}
-
-	if (iocbq->cmd_flag & LPFC_IO_DIF_PASS)
-		bf_set(wqe_dif, &wqe->generic.wqe_com, LPFC_WQE_DIF_PASSTHRU);
-	else if (iocbq->cmd_flag & LPFC_IO_DIF_STRIP)
-		bf_set(wqe_dif, &wqe->generic.wqe_com, LPFC_WQE_DIF_STRIP);
-	else if (iocbq->cmd_flag & LPFC_IO_DIF_INSERT)
-		bf_set(wqe_dif, &wqe->generic.wqe_com, LPFC_WQE_DIF_INSERT);
-	iocbq->cmd_flag &= ~(LPFC_IO_DIF_PASS | LPFC_IO_DIF_STRIP |
-			      LPFC_IO_DIF_INSERT);
-	bf_set(wqe_xri_tag, &wqe->generic.wqe_com, xritag);
-	bf_set(wqe_reqtag, &wqe->generic.wqe_com, iocbq->iotag);
-	wqe->generic.wqe_com.abort_tag = abort_tag;
-	bf_set(wqe_cmd_type, &wqe->generic.wqe_com, command_type);
-	bf_set(wqe_cmnd, &wqe->generic.wqe_com, cmnd);
-	bf_set(wqe_class, &wqe->generic.wqe_com, iocbq->iocb.ulpClass);
-	bf_set(wqe_cqid, &wqe->generic.wqe_com, LPFC_WQE_CQ_ID_DEFAULT);
-	return 0;
-}
-
 /**
  * __lpfc_sli_issue_fcp_io_s3 - SLI3 device for sending fcp io iocb
  * @phba: Pointer to HBA context object.
@@ -11057,28 +10352,19 @@ __lpfc_sli_issue_iocb_s4(struct lpfc_hba *phba, uint32_t ring_number,
 	lockdep_assert_held(&pring->ring_lock);
 	wqe = &piocb->wqe;
 	if (piocb->sli4_xritag == NO_XRI) {
-		if (ulp_command == CMD_ABORT_XRI_WQE)
+		if (ulp_command == CMD_ABORT_XRI_CX)
 			sglq = NULL;
 		else {
-			if (!list_empty(&pring->txq)) {
+			sglq = __lpfc_sli_get_els_sglq(phba, piocb);
+			if (!sglq) {
 				if (!(flag & SLI_IOCB_RET_IOCB)) {
 					__lpfc_sli_ringtx_put(phba,
-						pring, piocb);
+							pring,
+							piocb);
 					return IOCB_SUCCESS;
 				} else {
 					return IOCB_BUSY;
 				}
-			} else {
-				sglq = __lpfc_sli_get_els_sglq(phba, piocb);
-				if (!sglq) {
-					if (!(flag & SLI_IOCB_RET_IOCB)) {
-						__lpfc_sli_ringtx_put(phba,
-								pring,
-								piocb);
-						return IOCB_SUCCESS;
-					} else
-						return IOCB_BUSY;
-				}
 			}
 		}
 	} else if (piocb->cmd_flag &  LPFC_IO_FCP) {
@@ -11117,6 +10403,7 @@ __lpfc_sli_issue_iocb_s4(struct lpfc_hba *phba, uint32_t ring_number,
 
 	if (lpfc_sli4_wq_put(wq, wqe))
 		return IOCB_ERROR;
+
 	lpfc_sli_ringtxcmpl_put(phba, pring, piocb);
 
 	return 0;
@@ -12427,19 +11714,31 @@ lpfc_ignore_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		     struct lpfc_iocbq *rspiocb)
 {
 	struct lpfc_nodelist *ndlp = NULL;
-	IOCB_t *irsp = &rspiocb->iocb;
+	IOCB_t *irsp;
+	u32 ulp_command, ulp_status, ulp_word4, iotag;
+
+	ulp_command = get_job_cmnd(phba, cmdiocb);
+	ulp_status = get_job_ulpstatus(phba, rspiocb);
+	ulp_word4 = get_job_word4(phba, rspiocb);
+
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		iotag = get_wqe_reqtag(cmdiocb);
+	} else {
+		irsp = &rspiocb->iocb;
+		iotag = irsp->ulpIoTag;
+	}
 
 	/* ELS cmd tag <ulpIoTag> completes */
 	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
 			"0139 Ignoring ELS cmd code x%x completion Data: "
 			"x%x x%x x%x\n",
-			irsp->ulpIoTag, irsp->ulpStatus,
-			irsp->un.ulpWord[4], irsp->ulpTimeout);
+			ulp_command, ulp_status, ulp_word4, iotag);
+
 	/*
 	 * Deref the ndlp after free_iocb. sli_release_iocb will access the ndlp
 	 * if exchange is busy.
 	 */
-	if (cmdiocb->iocb.ulpCommand == CMD_GEN_REQUEST64_CR) {
+	if (ulp_command == CMD_GEN_REQUEST64_CR) {
 		ndlp = cmdiocb->context_un.ndlp;
 		lpfc_ct_free_iocb(phba, cmdiocb);
 	} else {
@@ -21129,10 +20428,9 @@ lpfc_drain_txq(struct lpfc_hba *phba)
 	struct lpfc_iocbq *piocbq = NULL;
 	unsigned long iflags = 0;
 	char *fail_msg = NULL;
-	struct lpfc_sglq *sglq;
-	union lpfc_wqe128 wqe;
 	uint32_t txq_cnt = 0;
 	struct lpfc_queue *wq;
+	int ret = 0;
 
 	if (phba->link_flag & LS_MDS_LOOPBACK) {
 		/* MDS WQE are posted only to first WQ*/
@@ -21171,44 +20469,33 @@ lpfc_drain_txq(struct lpfc_hba *phba)
 				txq_cnt);
 			break;
 		}
-		sglq = __lpfc_sli_get_els_sglq(phba, piocbq);
-		if (!sglq) {
-			__lpfc_sli_ringtx_put(phba, pring, piocbq);
-			spin_unlock_irqrestore(&pring->ring_lock, iflags);
-			break;
-		}
 		txq_cnt--;
 
-		/* The xri and iocb resources secured,
-		 * attempt to issue request
-		 */
-		piocbq->sli4_lxritag = sglq->sli4_lxritag;
-		piocbq->sli4_xritag = sglq->sli4_xritag;
-		if (NO_XRI == lpfc_sli4_bpl2sgl(phba, piocbq, sglq))
-			fail_msg = "to convert bpl to sgl";
-		else if (lpfc_sli4_iocb2wqe(phba, piocbq, &wqe))
-			fail_msg = "to convert iocb to wqe";
-		else if (lpfc_sli4_wq_put(wq, &wqe))
-			fail_msg = " - Wq is full";
-		else
-			lpfc_sli_ringtxcmpl_put(phba, pring, piocbq);
+		ret = __lpfc_sli_issue_iocb(phba, pring->ringno, piocbq, 0);
 
+		if (ret && ret != IOCB_BUSY) {
+			fail_msg = " - Cannot send IO ";
+			piocbq->cmd_flag &= ~LPFC_DRIVER_ABORTED;
+		}
 		if (fail_msg) {
+			piocbq->cmd_flag |= LPFC_DRIVER_ABORTED;
 			/* Failed means we can't issue and need to cancel */
 			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2822 IOCB failed %s iotag 0x%x "
-					"xri 0x%x\n",
-					fail_msg,
-					piocbq->iotag, piocbq->sli4_xritag);
+					"xri 0x%x %d flg x%x\n",
+					fail_msg, piocbq->iotag,
+					piocbq->sli4_xritag, ret,
+					piocbq->cmd_flag);
 			list_add_tail(&piocbq->list, &completions);
 			fail_msg = NULL;
 		}
 		spin_unlock_irqrestore(&pring->ring_lock, iflags);
+		if (txq_cnt == 0 || ret == IOCB_BUSY)
+			break;
 	}
-
 	/* Cancel all the IOCBs that cannot be issued */
 	lpfc_sli_cancel_iocbs(phba, &completions, IOSTAT_LOCAL_REJECT,
-				IOERR_SLI_ABORTED);
+			      IOERR_SLI_ABORTED);
 
 	return txq_cnt;
 }
-- 
2.26.2

