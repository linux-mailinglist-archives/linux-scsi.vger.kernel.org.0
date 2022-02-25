Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3BD4C3B9E
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Feb 2022 03:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiBYCYK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Feb 2022 21:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiBYCYB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Feb 2022 21:24:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606271C74D2
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c9so3589489pll.0
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+VtzZgXWytJmbtHVd+M+AumIRhDTeiCYTJvtKBJMP8=;
        b=qfuzzYWqt+PUPWWe22N4wBVV7uC3vvrbC+uYolI5cmjk98++VxO+j1wArIL8oGkr9p
         jwwV1zNi/gGGkVCs5Ii3HTaEY81Bw8zfLXgrUQV0x8s/XJAkBTohxVvqYTV76tWjIGhC
         Rfaj4SB1bZRmJrsD9xj3I64HB/r2e49Pt8Vfx6vTGqDT21RDwrv5Rk30p0IK+xMr6yn/
         T7u5kDoyIYwO9Rvrf7HzghNNx04u+aeUj0jP8Rgq+16YqVnlkep8MlFCQIag0LbLjPkr
         hLBa9DFpMbM+olo01MNZ3k8wf7VI521uQF6TW33EgJ1QVDTlvK7BQnstldjoiMhzoQk6
         L/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+VtzZgXWytJmbtHVd+M+AumIRhDTeiCYTJvtKBJMP8=;
        b=OuGyaYLtd34acEe2SOLfrCH/Df8BIf9LkCmY2AMAR6czfEuWFfOeSXUQ5jfWN+D58y
         1aNc08VDCwaC+018xYtr8anovqBjoun50cBZZddLHkkd2BOl+eWPzgjS2qWv5zDQ8qBX
         73ETUwkXT/9mZJ69TER/gCpA/TSSnPTsaL/gwkY9Nb6wZHRp65gjH3PnB24HgQmc36jZ
         e164B893MZTk/1E4+JMkc0EIdLnIvvzmEitjE6M2/1Xj1eQy58i0iOksf1POXJFwJzgT
         JadXk8SFMz7TI3x2sknLguD8EvqXczGRNcSYZEcB4La+w/OnctpWBs23ECWazqilBSTB
         kuKQ==
X-Gm-Message-State: AOAM532qLiZIsyAvIUJWcfdX+lW6YKjus1wks7oT1tt+vgaMokWFkVKW
        V9YUuVTZSbTsE9yUjyEDcutQRIFyZ0M=
X-Google-Smtp-Source: ABdhPJwbqqveiS5JVOhxJBrkhd//9v2M2nw9F1TparrT3gQ+TyasZj/oAGiVnkCfireXVCrwcDI87Q==
X-Received: by 2002:a17:902:6bc5:b0:14f:ae30:3b6f with SMTP id m5-20020a1709026bc500b0014fae303b6fmr5384359plt.60.1645755803665;
        Thu, 24 Feb 2022 18:23:23 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f3b355dcb1sm845596pfh.58.2022.02.24.18.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:23:23 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 07/17] lpfc: SLI path split: refactor LS_ACC paths
Date:   Thu, 24 Feb 2022 18:22:58 -0800
Message-Id: <20220225022308.16486-8-jsmart2021@gmail.com>
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

This patch refactors the LS_ACC paths to use SLI-4 as the primary
interface.

Changes include:
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
 drivers/scsi/lpfc/lpfc_els.c | 244 +++++++++++++++++++++++++----------
 1 file changed, 177 insertions(+), 67 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 365580abcb5b..04aac285a677 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5158,12 +5158,14 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 {
 	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *) cmdiocb->context1;
 	struct lpfc_vport *vport = cmdiocb->vport;
-	IOCB_t *irsp;
+	u32 ulp_status, ulp_word4;
+
+	ulp_status = get_job_ulpstatus(phba, rspiocb);
+	ulp_word4 = get_job_word4(phba, rspiocb);
 
-	irsp = &rspiocb->iocb;
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
 		"ACC LOGO cmpl:   status:x%x/x%x did:x%x",
-		irsp->ulpStatus, irsp->un.ulpWord[4], ndlp->nlp_DID);
+		ulp_status, ulp_word4, ndlp->nlp_DID);
 	/* ACC to LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0109 ACC to LOGO completes to NPort x%x refcnt %d "
@@ -5181,7 +5183,6 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto out;
 
 	if (ndlp->nlp_state == NLP_STE_NPR_NODE) {
-
 		/* If PLOGI is being retried, PLOGI completion will cleanup the
 		 * node. The NLP_NPR_2B_DISC flag needs to be retained to make
 		 * progress on nodes discovered from last RSCN.
@@ -5288,8 +5289,7 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	IOCB_t  *irsp;
 	LPFC_MBOXQ_t *mbox = NULL;
 	struct lpfc_dmabuf *mp = NULL;
-
-	irsp = &rspiocb->iocb;
+	u32 ulp_status, ulp_word4, tmo, did, iotag;
 
 	if (!vport) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
@@ -5299,6 +5299,19 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	if (cmdiocb->context_un.mbox)
 		mbox = cmdiocb->context_un.mbox;
 
+	ulp_status = get_job_ulpstatus(phba, rspiocb);
+	ulp_word4 = get_job_word4(phba, rspiocb);
+	did = get_job_els_rsp64_did(phba, cmdiocb);
+
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		tmo = get_wqe_tmo(cmdiocb);
+		iotag = get_wqe_reqtag(cmdiocb);
+	} else {
+		irsp = &rspiocb->iocb;
+		tmo = irsp->ulpTimeout;
+		iotag = irsp->ulpIoTag;
+	}
+
 	/* Check to see if link went down during discovery */
 	if (!ndlp || lpfc_els_chk_latt(vport)) {
 		if (mbox) {
@@ -5314,19 +5327,17 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
 		"ELS rsp cmpl:    status:x%x/x%x did:x%x",
-		irsp->ulpStatus, irsp->un.ulpWord[4],
-		cmdiocb->iocb.un.elsreq64.remoteID);
+		ulp_status, ulp_word4, did);
 	/* ELS response tag <ulpIoTag> completes */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0110 ELS response tag x%x completes "
-			 "Data: x%x x%x x%x x%x x%x x%x x%x x%x x%px\n",
-			 cmdiocb->iocb.ulpIoTag, rspiocb->iocb.ulpStatus,
-			 rspiocb->iocb.un.ulpWord[4], rspiocb->iocb.ulpTimeout,
+			 "Data: x%x x%x x%x x%x x%x x%x x%x x%x %p %p\n",
+			 iotag, ulp_status, ulp_word4, tmo,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
-			 ndlp->nlp_rpi, kref_read(&ndlp->kref), mbox);
+			 ndlp->nlp_rpi, kref_read(&ndlp->kref), mbox, ndlp);
 	if (mbox) {
-		if ((rspiocb->iocb.ulpStatus == 0) &&
-		    (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
+		if (ulp_status == 0
+		    && (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
 			if (!lpfc_unreg_rpi(vport, ndlp) &&
 			    (!(vport->fc_flag & FC_PT2PT))) {
 				if (ndlp->nlp_state == NLP_STE_REG_LOGIN_ISSUE) {
@@ -5819,6 +5830,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_els_edc_rsp *edc_rsp;
 	struct lpfc_iocbq *elsiocb;
 	IOCB_t *icmd, *cmd;
+	union lpfc_wqe128 *wqe;
 	uint8_t *pcmd;
 	int cmdsize, rc;
 
@@ -5828,11 +5840,21 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	if (!elsiocb)
 		return 1;
 
-	icmd = &elsiocb->iocb;
-	cmd = &cmdiocb->iocb;
-	icmd->ulpContext = cmd->ulpContext;     /* Xri / rx_id */
-	icmd->unsli3.rcvsli3.ox_id = cmd->unsli3.rcvsli3.ox_id;
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com,
+		       get_job_ulpcontext(phba, cmdiocb)); /* Xri / rx_id */
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       get_job_rcvoxid(phba, cmdiocb));
+	} else {
+		icmd = &elsiocb->iocb;
+		cmd = &cmdiocb->iocb;
+		icmd->ulpContext = cmd->ulpContext; /* Xri / rx_id */
+		icmd->unsli3.rcvsli3.ox_id = cmd->unsli3.rcvsli3.ox_id;
+	}
+
 	pcmd = (((struct lpfc_dmabuf *)elsiocb->context2)->virt);
+
 	memset(pcmd, 0, cmdsize);
 
 	edc_rsp = (struct lpfc_els_edc_rsp *)pcmd;
@@ -6179,10 +6201,12 @@ lpfc_els_rsp_rnid_acc(struct lpfc_vport *vport, uint8_t format,
 	struct lpfc_hba  *phba = vport->phba;
 	RNID *rn;
 	IOCB_t *icmd, *oldcmd;
+	union lpfc_wqe128 *wqe;
 	struct lpfc_iocbq *elsiocb;
 	uint8_t *pcmd;
 	uint16_t cmdsize;
 	int rc;
+	u32 ulp_context;
 
 	cmdsize = sizeof(uint32_t) + sizeof(uint32_t)
 					+ (2 * sizeof(struct lpfc_name));
@@ -6194,15 +6218,26 @@ lpfc_els_rsp_rnid_acc(struct lpfc_vport *vport, uint8_t format,
 	if (!elsiocb)
 		return 1;
 
-	icmd = &elsiocb->iocb;
-	oldcmd = &oldiocb->iocb;
-	icmd->ulpContext = oldcmd->ulpContext;	/* Xri / rx_id */
-	icmd->unsli3.rcvsli3.ox_id = oldcmd->unsli3.rcvsli3.ox_id;
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com,
+		       get_job_ulpcontext(phba, oldiocb)); /* Xri / rx_id */
+		ulp_context = get_job_ulpcontext(phba, elsiocb);
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       get_job_rcvoxid(phba, oldiocb));
+	} else {
+		icmd = &elsiocb->iocb;
+		oldcmd = &oldiocb->iocb;
+		icmd->ulpContext = oldcmd->ulpContext; /* Xri / rx_id */
+		ulp_context = elsiocb->iocb.ulpContext;
+		icmd->unsli3.rcvsli3.ox_id =
+			oldcmd->unsli3.rcvsli3.ox_id;
+	}
 
 	/* Xmit RNID ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0132 Xmit RNID ACC response tag x%x xri x%x\n",
-			 elsiocb->iotag, elsiocb->iocb.ulpContext);
+			 elsiocb->iotag, ulp_context);
 	pcmd = (uint8_t *) (((struct lpfc_dmabuf *) elsiocb->context2)->virt);
 	*((uint32_t *) (pcmd)) = ELS_CMD_ACC;
 	pcmd += sizeof(uint32_t);
@@ -6285,7 +6320,8 @@ lpfc_els_clear_rrq(struct lpfc_vport *vport,
 			be32_to_cpu(bf_get(rrq_did, rrq)),
 			bf_get(rrq_oxid, rrq),
 			rxid,
-			iocb->iotag, iocb->iocb.ulpContext);
+			get_wqe_reqtag(iocb),
+			get_job_ulpcontext(phba, iocb));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
 		"Clear RRQ:  did:x%x flg:x%x exchg:x%.08x",
@@ -6954,12 +6990,14 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 	struct lpfc_iocbq *elsiocb;
 	struct ulp_bde64 *bpl;
 	IOCB_t *icmd;
+	union lpfc_wqe128 *wqe;
 	uint8_t *pcmd;
 	struct ls_rjt *stat;
 	struct fc_rdp_res_frame *rdp_res;
 	uint32_t cmdsize, len;
 	uint16_t *flag_ptr;
 	int rc;
+	u32 ulp_context;
 
 	if (status != SUCCESS)
 		goto error;
@@ -6968,19 +7006,29 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 	cmdsize = sizeof(struct fc_rdp_res_frame);
 
 	elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize,
-			lpfc_max_els_tries, rdp_context->ndlp,
-			rdp_context->ndlp->nlp_DID, ELS_CMD_ACC);
+				lpfc_max_els_tries, rdp_context->ndlp,
+				rdp_context->ndlp->nlp_DID, ELS_CMD_ACC);
 	if (!elsiocb)
 		goto free_rdp_context;
 
-	icmd = &elsiocb->iocb;
-	icmd->ulpContext = rdp_context->rx_id;
-	icmd->unsli3.rcvsli3.ox_id = rdp_context->ox_id;
+	ulp_context = get_job_ulpcontext(phba, elsiocb);
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		/* ox-id of the frame */
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       rdp_context->ox_id);
+		bf_set(wqe_ctxt_tag, &wqe->xmit_els_rsp.wqe_com,
+		       rdp_context->rx_id);
+	} else {
+		icmd = &elsiocb->iocb;
+		icmd->ulpContext = rdp_context->rx_id;
+		icmd->unsli3.rcvsli3.ox_id = rdp_context->ox_id;
+	}
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			"2171 Xmit RDP response tag x%x xri x%x, "
 			"did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x",
-			elsiocb->iotag, elsiocb->iocb.ulpContext,
+			elsiocb->iotag, ulp_context,
 			ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			ndlp->nlp_rpi);
 	rdp_res = (struct fc_rdp_res_frame *)
@@ -7064,9 +7112,20 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 	if (!elsiocb)
 		goto free_rdp_context;
 
-	icmd = &elsiocb->iocb;
-	icmd->ulpContext = rdp_context->rx_id;
-	icmd->unsli3.rcvsli3.ox_id = rdp_context->ox_id;
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		/* ox-id of the frame */
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       rdp_context->ox_id);
+		bf_set(wqe_ctxt_tag,
+		       &wqe->xmit_els_rsp.wqe_com,
+		       rdp_context->rx_id);
+	} else {
+		icmd = &elsiocb->iocb;
+		icmd->ulpContext = rdp_context->rx_id;
+		icmd->unsli3.rcvsli3.ox_id = rdp_context->ox_id;
+	}
+
 	pcmd = (uint8_t *) (((struct lpfc_dmabuf *) elsiocb->context2)->virt);
 
 	*((uint32_t *) (pcmd)) = ELS_CMD_LS_RJT;
@@ -7089,7 +7148,7 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 
 free_rdp_context:
 	/* This reference put is for the original unsolicited RDP. If the
-	 * iocb prep failed, there is no reference to remove.
+	 * prep failed, there is no reference to remove.
 	 */
 	lpfc_nlp_put(ndlp);
 	kfree(rdp_context);
@@ -7155,7 +7214,7 @@ lpfc_els_rcv_rdp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	uint8_t rjt_err, rjt_expl = LSEXP_NOTHING_MORE;
 	struct fc_rdp_req_frame *rdp_req;
 	struct lpfc_rdp_context *rdp_context;
-	IOCB_t *cmd = NULL;
+	union lpfc_wqe128 *cmd = NULL;
 	struct ls_rjt stat;
 
 	if (phba->sli_rev < LPFC_SLI_REV4 ||
@@ -7197,15 +7256,17 @@ lpfc_els_rcv_rdp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		goto error;
 	}
 
-	cmd = &cmdiocb->iocb;
+	cmd = &cmdiocb->wqe;
 	rdp_context->ndlp = lpfc_nlp_get(ndlp);
 	if (!rdp_context->ndlp) {
 		kfree(rdp_context);
 		rjt_err = LSRJT_UNABLE_TPC;
 		goto error;
 	}
-	rdp_context->ox_id = cmd->unsli3.rcvsli3.ox_id;
-	rdp_context->rx_id = cmd->ulpContext;
+	rdp_context->ox_id = bf_get(wqe_rcvoxid,
+				    &cmd->xmit_els_rsp.wqe_com);
+	rdp_context->rx_id = bf_get(wqe_ctxt_tag,
+				    &cmd->xmit_els_rsp.wqe_com);
 	rdp_context->cmpl = lpfc_els_rdp_cmpl;
 	if (lpfc_get_rdp_info(phba, rdp_context)) {
 		lpfc_printf_vlog(ndlp->vport, KERN_WARNING, LOG_ELS,
@@ -7235,6 +7296,7 @@ lpfc_els_lcb_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	MAILBOX_t *mb;
 	IOCB_t *icmd;
+	union lpfc_wqe128 *wqe;
 	uint8_t *pcmd;
 	struct lpfc_iocbq *elsiocb;
 	struct lpfc_nodelist *ndlp;
@@ -7285,9 +7347,17 @@ lpfc_els_lcb_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
 
 	memset(lcb_res, 0, sizeof(struct fc_lcb_res_frame));
-	icmd = &elsiocb->iocb;
-	icmd->ulpContext = lcb_context->rx_id;
-	icmd->unsli3.rcvsli3.ox_id = lcb_context->ox_id;
+
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com, lcb_context->rx_id);
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       lcb_context->ox_id);
+	} else {
+		icmd = &elsiocb->iocb;
+		icmd->ulpContext = lcb_context->rx_id;
+		icmd->unsli3.rcvsli3.ox_id = lcb_context->ox_id;
+	}
 
 	pcmd = (uint8_t *)(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
 	*((uint32_t *)(pcmd)) = ELS_CMD_ACC;
@@ -7317,15 +7387,23 @@ lpfc_els_lcb_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 error:
 	cmdsize = sizeof(struct fc_lcb_res_frame);
 	elsiocb = lpfc_prep_els_iocb(phba->pport, 0, cmdsize,
-			lpfc_max_els_tries, ndlp,
-			ndlp->nlp_DID, ELS_CMD_LS_RJT);
+				     lpfc_max_els_tries, ndlp,
+				     ndlp->nlp_DID, ELS_CMD_LS_RJT);
 	lpfc_nlp_put(ndlp);
 	if (!elsiocb)
 		goto free_lcb_context;
 
-	icmd = &elsiocb->iocb;
-	icmd->ulpContext = lcb_context->rx_id;
-	icmd->unsli3.rcvsli3.ox_id = lcb_context->ox_id;
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com, lcb_context->rx_id);
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       lcb_context->ox_id);
+	} else {
+		icmd = &elsiocb->iocb;
+		icmd->ulpContext = lcb_context->rx_id;
+		icmd->unsli3.rcvsli3.ox_id = lcb_context->ox_id;
+	}
+
 	pcmd = (uint8_t *)(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
 
 	*((uint32_t *)(pcmd)) = ELS_CMD_LS_RJT;
@@ -7490,8 +7568,8 @@ lpfc_els_rcv_lcb(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	lcb_context->type = beacon->lcb_type;
 	lcb_context->frequency = beacon->lcb_frequency;
 	lcb_context->duration = beacon->lcb_duration;
-	lcb_context->ox_id = cmdiocb->iocb.unsli3.rcvsli3.ox_id;
-	lcb_context->rx_id = cmdiocb->iocb.ulpContext;
+	lcb_context->ox_id = get_job_rcvoxid(phba, cmdiocb);
+	lcb_context->rx_id = get_job_ulpcontext(phba, cmdiocb);
 	lcb_context->ndlp = lpfc_nlp_get(ndlp);
 	if (!lcb_context->ndlp) {
 		rjt_err = LSRJT_UNABLE_TPC;
@@ -8346,6 +8424,7 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	int rc = 0;
 	MAILBOX_t *mb;
 	IOCB_t *icmd;
+	union lpfc_wqe128 *wqe;
 	struct RLS_RSP *rls_rsp;
 	uint8_t *pcmd;
 	struct lpfc_iocbq *elsiocb;
@@ -8353,6 +8432,7 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	uint16_t oxid;
 	uint16_t rxid;
 	uint32_t cmdsize;
+	u32 ulp_context;
 
 	mb = &pmb->u.mb;
 
@@ -8380,9 +8460,17 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		return;
 	}
 
-	icmd = &elsiocb->iocb;
-	icmd->ulpContext = rxid;
-	icmd->unsli3.rcvsli3.ox_id = oxid;
+	ulp_context = get_job_ulpcontext(phba, elsiocb);
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		/* Xri / rx_id */
+		bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com, rxid);
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com, oxid);
+	} else {
+		icmd = &elsiocb->iocb;
+		icmd->ulpContext = rxid;
+		icmd->unsli3.rcvsli3.ox_id = oxid;
+	}
 
 	pcmd = (uint8_t *) (((struct lpfc_dmabuf *) elsiocb->context2)->virt);
 	*((uint32_t *) (pcmd)) = ELS_CMD_ACC;
@@ -8400,7 +8488,7 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_ELS,
 			 "2874 Xmit ELS RLS ACC response tag x%x xri x%x, "
 			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x\n",
-			 elsiocb->iotag, elsiocb->iocb.ulpContext,
+			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_rsp;
@@ -8444,6 +8532,8 @@ lpfc_els_rcv_rls(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_hba *phba = vport->phba;
 	LPFC_MBOXQ_t *mbox;
 	struct ls_rjt stat;
+	u32 ctx = get_job_ulpcontext(phba, cmdiocb);
+	u32 ox_id = get_job_rcvoxid(phba, cmdiocb);
 
 	if ((ndlp->nlp_state != NLP_STE_UNMAPPED_NODE) &&
 	    (ndlp->nlp_state != NLP_STE_MAPPED_NODE))
@@ -8454,8 +8544,7 @@ lpfc_els_rcv_rls(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	if (mbox) {
 		lpfc_read_lnk_stat(phba, mbox);
 		mbox->ctx_buf = (void *)((unsigned long)
-			((cmdiocb->iocb.unsli3.rcvsli3.ox_id << 16) |
-			cmdiocb->iocb.ulpContext)); /* rx_id */
+					 (ox_id << 16 | ctx));
 		mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
 		if (!mbox->ctx_ndlp)
 			goto node_err;
@@ -8508,13 +8597,15 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		 struct lpfc_nodelist *ndlp)
 {
 	int rc = 0;
+	IOCB_t *icmd;
+	union lpfc_wqe128 *wqe;
 	struct lpfc_hba *phba = vport->phba;
 	struct ls_rjt stat;
 	struct RTV_RSP *rtv_rsp;
 	uint8_t *pcmd;
 	struct lpfc_iocbq *elsiocb;
 	uint32_t cmdsize;
-
+	u32 ulp_context;
 
 	if ((ndlp->nlp_state != NLP_STE_UNMAPPED_NODE) &&
 	    (ndlp->nlp_state != NLP_STE_MAPPED_NODE))
@@ -8533,9 +8624,19 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	*((uint32_t *) (pcmd)) = ELS_CMD_ACC;
 	pcmd += sizeof(uint32_t); /* Skip past command */
 
+	ulp_context = get_job_ulpcontext(phba, elsiocb);
 	/* use the command's xri in the response */
-	elsiocb->iocb.ulpContext = cmdiocb->iocb.ulpContext;  /* Xri / rx_id */
-	elsiocb->iocb.unsli3.rcvsli3.ox_id = cmdiocb->iocb.unsli3.rcvsli3.ox_id;
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com,
+		       get_job_ulpcontext(phba, cmdiocb));
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       get_job_rcvoxid(phba, cmdiocb));
+	} else {
+		icmd = &elsiocb->iocb;
+		icmd->ulpContext = get_job_ulpcontext(phba, cmdiocb);
+		icmd->unsli3.rcvsli3.ox_id = get_job_rcvoxid(phba, cmdiocb);
+	}
 
 	rtv_rsp = (struct RTV_RSP *)pcmd;
 
@@ -8551,7 +8652,7 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 			 "2875 Xmit ELS RTV ACC response tag x%x xri x%x, "
 			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x, "
 			 "Data: x%x x%x x%x\n",
-			 elsiocb->iotag, elsiocb->iocb.ulpContext,
+			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi,
 			rtv_rsp->ratov, rtv_rsp->edtov, rtv_rsp->qtov);
@@ -8700,10 +8801,12 @@ lpfc_els_rsp_rpl_acc(struct lpfc_vport *vport, uint16_t cmdsize,
 {
 	int rc = 0;
 	struct lpfc_hba *phba = vport->phba;
-	IOCB_t *icmd, *oldcmd;
+	IOCB_t *icmd;
+	union lpfc_wqe128 *wqe;
 	RPL_RSP rpl_rsp;
 	struct lpfc_iocbq *elsiocb;
 	uint8_t *pcmd;
+	u32 ulp_context;
 
 	elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize, oldiocb->retry, ndlp,
 				     ndlp->nlp_DID, ELS_CMD_ACC);
@@ -8711,10 +8814,19 @@ lpfc_els_rsp_rpl_acc(struct lpfc_vport *vport, uint16_t cmdsize,
 	if (!elsiocb)
 		return 1;
 
-	icmd = &elsiocb->iocb;
-	oldcmd = &oldiocb->iocb;
-	icmd->ulpContext = oldcmd->ulpContext;	/* Xri / rx_id */
-	icmd->unsli3.rcvsli3.ox_id = oldcmd->unsli3.rcvsli3.ox_id;
+	ulp_context = get_job_ulpcontext(phba, elsiocb);
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wqe = &elsiocb->wqe;
+		/* Xri / rx_id */
+		bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com,
+		       get_job_ulpcontext(phba, oldiocb));
+		bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+		       get_job_rcvoxid(phba, oldiocb));
+	} else {
+		icmd = &elsiocb->iocb;
+		icmd->ulpContext = get_job_ulpcontext(phba, oldiocb);
+		icmd->unsli3.rcvsli3.ox_id = get_job_rcvoxid(phba, oldiocb);
+	}
 
 	pcmd = (((struct lpfc_dmabuf *) elsiocb->context2)->virt);
 	*((uint32_t *) (pcmd)) = ELS_CMD_ACC;
@@ -8735,7 +8847,7 @@ lpfc_els_rsp_rpl_acc(struct lpfc_vport *vport, uint16_t cmdsize,
 			 "0120 Xmit ELS RPL ACC response tag x%x "
 			 "xri x%x, did x%x, nlp_flag x%x, nlp_state x%x, "
 			 "rpi x%x\n",
-			 elsiocb->iotag, elsiocb->iocb.ulpContext,
+			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_rsp;
@@ -8844,12 +8956,10 @@ lpfc_els_rcv_farp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 {
 	struct lpfc_dmabuf *pcmd;
 	uint32_t *lp;
-	IOCB_t *icmd;
 	FARP *fp;
 	uint32_t cnt, did;
 
-	icmd = &cmdiocb->iocb;
-	did = icmd->un.elsreq64.remoteID;
+	did = get_job_els_rsp64_did(vport->phba, cmdiocb);
 	pcmd = (struct lpfc_dmabuf *) cmdiocb->context2;
 	lp = (uint32_t *) pcmd->virt;
 
-- 
2.26.2

