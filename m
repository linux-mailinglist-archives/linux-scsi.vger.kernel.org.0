Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259304C3BAE
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Feb 2022 03:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiBYCYo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Feb 2022 21:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiBYCYD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Feb 2022 21:24:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858931E697F
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:29 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m11so3554870pls.5
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DrDMT66UhhtKBW/MVetXfzmUvDtnG+fdLmzpNC3Nhs8=;
        b=V/LshO5ZTg+J37H9j12Ew2EdLEBOkSZYnfcz/ibqKQZnGSWLL/c97/sOSs3ySEnIp4
         wpNWgOShoNhDhZW04MHA3hPSPu/cDOvv9rLcEPwpkMZRZYAXCRaw6kY7r92xqiomMedU
         5neX65uAI3l6FTEwY5UjuF2krgb4h+JR5NZL7G8JklY0B7wduDw+vdRbMsp99aILWThq
         p/d405CB5VSaFJL+TSPk45hy3BLQMBdsZxQawVf7HjLm2XoFjaLqZqrj2korM/SFexDk
         dlsbqm2rtn4c3psZFhwjnugvsBxmvdRd9ktovjf1JNA2a0OIDHdrPSdARKPIWkEGay56
         /v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DrDMT66UhhtKBW/MVetXfzmUvDtnG+fdLmzpNC3Nhs8=;
        b=VYNimxtBCxopPl8pZ66XHsJBpX5dLLFZOr9OSxOVzLp0sQNoe7R7IhPFn6PRps6H/5
         Sz07Uf1RakoJIzmlOX8GD44b8wUBDyt6Ou5v6YVWkLp0w8mEO/hrZS+0JTj6yTo8neWN
         82g/f2BF5gF299bEctFxAYAoIQF+7i/S0zaGr0liqTrhI8xmWvsRRdhqWtg+USBdeGlW
         yvXgjQzG0ZbJjXgtkXXLUW74o8UGDBI2/QHsMK30QMOWIxLt4XRNQthI1VxN2n0OuAM2
         xysnyevMAb8ZeTRVHkNg7kns0pNVyDkmVHpLuMHzfarme5lbDzEFGbTkBbJYONieOm6/
         t79Q==
X-Gm-Message-State: AOAM532zRgAbMJOOOGaEuENZrNZxS22FGtKcntSl79hZ3PfNs8uEfe0a
        2WZm0mru3NNgsvg+lfjSUsVV+6xgMEk=
X-Google-Smtp-Source: ABdhPJzITK5wG2Dytpq62HH9BlomYVAKhorog44z5NTNLBI9h6hmv9gBpUegZPSLASW4YnIgnh8blg==
X-Received: by 2002:a17:90a:fe86:b0:1bc:6935:346 with SMTP id co6-20020a17090afe8600b001bc69350346mr1011921pjb.150.1645755807739;
        Thu, 24 Feb 2022 18:23:27 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f3b355dcb1sm845596pfh.58.2022.02.24.18.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:23:27 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 12/17] lpfc: SLI path split: refactor CT paths
Date:   Thu, 24 Feb 2022 18:23:03 -0800
Message-Id: <20220225022308.16486-13-jsmart2021@gmail.com>
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

This patch refactors the CT paths to use SLI-4 as the primary interface.

Changes include:
- introduced generic lpfc_sli_prep_gen_req jump table routine
- introduced generic lpfc_sli_prep_xmit_seq64 jump table routine
- renamed lpfcdiag_loop_post_rxbufs to lpfcdiag_sli3_loop_post_rxbufs to
  indicate that it is an SLI3 only path
- create new prep_wqe routine for unsolicited ELS rsp WQEs.
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
 drivers/scsi/lpfc/lpfc.h      |  16 ++
 drivers/scsi/lpfc/lpfc_bsg.c  | 266 +++++++++--------------
 drivers/scsi/lpfc/lpfc_crtn.h |   8 +
 drivers/scsi/lpfc/lpfc_ct.c   | 333 ++++++++++++++---------------
 drivers/scsi/lpfc/lpfc_sli.c  | 390 ++++++++++++++++++++++++++++------
 drivers/scsi/lpfc/lpfc_sli.h  |   1 +
 6 files changed, 616 insertions(+), 398 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 3da9551c651e..28b1d5b7df08 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -969,6 +969,13 @@ struct lpfc_hba {
 					    struct lpfc_dmabuf *bmp,
 					    u16 cmd_size, u32 did, u32 elscmd,
 					    u8 tmo, u8 expect_rsp);
+	void (*__lpfc_sli_prep_gen_req)(struct lpfc_iocbq *cmdiocbq,
+					struct lpfc_dmabuf *bmp, u16 rpi,
+					u32 num_entry, u8 tmo);
+	void (*__lpfc_sli_prep_xmit_seq64)(struct lpfc_iocbq *cmdiocbq,
+					   struct lpfc_dmabuf *bmp, u16 rpi,
+					   u16 ox_id, u32 num_entry, u8 rctl,
+					   u8 last_seq, u8 cr_cx_cmd);
 
 	/* expedite pool */
 	struct lpfc_epd_pool epd_pool;
@@ -1853,6 +1860,15 @@ u16 get_job_rcvoxid(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 		return iocbq->iocb.unsli3.rcvsli3.ox_id;
 }
 
+static inline
+u32 get_job_data_placed(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
+{
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		return iocbq->wcqe_cmpl.total_data_placed;
+	else
+		return iocbq->iocb.un.genreq64.bdl.bdeSize;
+}
+
 static inline
 u32 get_job_els_rsp64_did(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 {
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 1a97426e72de..8d49e4b2ebfe 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -303,13 +303,12 @@ lpfc_bsg_send_mgmt_cmd_cmp(struct lpfc_hba *phba,
 	struct bsg_job_data *dd_data;
 	struct bsg_job *job;
 	struct fc_bsg_reply *bsg_reply;
-	IOCB_t *rsp;
 	struct lpfc_dmabuf *bmp, *cmp, *rmp;
 	struct lpfc_nodelist *ndlp;
 	struct lpfc_bsg_iocb *iocb;
 	unsigned long flags;
-	unsigned int rsp_size;
 	int rc = 0;
+	u32 ulp_status, ulp_word4, total_data_placed;
 
 	dd_data = cmdiocbq->context1;
 
@@ -333,14 +332,16 @@ lpfc_bsg_send_mgmt_cmd_cmp(struct lpfc_hba *phba,
 	rmp = iocb->rmp;
 	cmp = cmdiocbq->context2;
 	bmp = cmdiocbq->context3;
-	rsp = &rspiocbq->iocb;
+	ulp_status = get_job_ulpstatus(phba, rspiocbq);
+	ulp_word4 = get_job_word4(phba, rspiocbq);
+	total_data_placed = get_job_data_placed(phba, rspiocbq);
 
 	/* Copy the completed data or set the error status */
 
 	if (job) {
-		if (rsp->ulpStatus) {
-			if (rsp->ulpStatus == IOSTAT_LOCAL_REJECT) {
-				switch (rsp->un.ulpWord[4] & IOERR_PARAM_MASK) {
+		if (ulp_status) {
+			if (ulp_status == IOSTAT_LOCAL_REJECT) {
+				switch (ulp_word4 & IOERR_PARAM_MASK) {
 				case IOERR_SEQUENCE_TIMEOUT:
 					rc = -ETIMEDOUT;
 					break;
@@ -355,10 +356,9 @@ lpfc_bsg_send_mgmt_cmd_cmp(struct lpfc_hba *phba,
 				rc = -EACCES;
 			}
 		} else {
-			rsp_size = rsp->un.genreq64.bdl.bdeSize;
 			bsg_reply->reply_payload_rcv_len =
 				lpfc_bsg_copy_data(rmp, &job->reply_payload,
-						   rsp_size, 0);
+						   total_data_placed, 0);
 		}
 	}
 
@@ -388,22 +388,21 @@ static int
 lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 {
 	struct lpfc_vport *vport = shost_priv(fc_bsg_to_shost(job));
-	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_rport_data *rdata = fc_bsg_to_rport(job)->dd_data;
+	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_nodelist *ndlp = rdata->pnode;
 	struct fc_bsg_reply *bsg_reply = job->reply;
 	struct ulp_bde64 *bpl = NULL;
-	uint32_t timeout;
 	struct lpfc_iocbq *cmdiocbq = NULL;
-	IOCB_t *cmd;
 	struct lpfc_dmabuf *bmp = NULL, *cmp = NULL, *rmp = NULL;
-	int request_nseg;
-	int reply_nseg;
+	int request_nseg, reply_nseg;
+	u32 num_entry;
 	struct bsg_job_data *dd_data;
 	unsigned long flags;
 	uint32_t creg_val;
 	int rc = 0;
 	int iocb_stat;
+	u16 ulp_context;
 
 	/* in case no data is transferred */
 	bsg_reply->reply_payload_rcv_len = 0;
@@ -426,8 +425,6 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 		goto free_dd;
 	}
 
-	cmd = &cmdiocbq->iocb;
-
 	bmp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
 	if (!bmp) {
 		rc = -ENOMEM;
@@ -461,29 +458,21 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 		goto free_cmp;
 	}
 
-	cmd->un.genreq64.bdl.ulpIoTag32 = 0;
-	cmd->un.genreq64.bdl.addrHigh = putPaddrHigh(bmp->phys);
-	cmd->un.genreq64.bdl.addrLow = putPaddrLow(bmp->phys);
-	cmd->un.genreq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
-	cmd->un.genreq64.bdl.bdeSize =
-		(request_nseg + reply_nseg) * sizeof(struct ulp_bde64);
-	cmd->ulpCommand = CMD_GEN_REQUEST64_CR;
-	cmd->un.genreq64.w5.hcsw.Fctl = (SI | LA);
-	cmd->un.genreq64.w5.hcsw.Dfctl = 0;
-	cmd->un.genreq64.w5.hcsw.Rctl = FC_RCTL_DD_UNSOL_CTL;
-	cmd->un.genreq64.w5.hcsw.Type = FC_TYPE_CT;
-	cmd->ulpBdeCount = 1;
-	cmd->ulpLe = 1;
-	cmd->ulpClass = CLASS3;
-	cmd->ulpContext = ndlp->nlp_rpi;
+	num_entry = request_nseg + reply_nseg;
+
 	if (phba->sli_rev == LPFC_SLI_REV4)
-		cmd->ulpContext = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
-	cmd->ulpOwner = OWN_CHIP;
+		ulp_context = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
+	else
+		ulp_context = ndlp->nlp_rpi;
+
+	lpfc_sli_prep_gen_req(phba, cmdiocbq, bmp, ulp_context, num_entry,
+			      phba->fc_ratov * 2);
+
+	cmdiocbq->num_bdes = num_entry;
 	cmdiocbq->vport = phba->pport;
+	cmdiocbq->context2 = cmp;
 	cmdiocbq->context3 = bmp;
 	cmdiocbq->cmd_flag |= LPFC_IO_LIBDFC;
-	timeout = phba->fc_ratov * 2;
-	cmd->ulpTimeout = timeout;
 
 	cmdiocbq->cmd_cmpl = lpfc_bsg_send_mgmt_cmd_cmp;
 	cmdiocbq->context1 = dd_data;
@@ -916,6 +905,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	struct lpfc_bsg_event *evt;
 	struct event_data *evt_dat = NULL;
 	struct lpfc_iocbq *iocbq;
+	IOCB_t *iocb = NULL;
 	size_t offset = 0;
 	struct list_head head;
 	struct ulp_bde64 *bde;
@@ -923,13 +913,13 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	int i;
 	struct lpfc_dmabuf *bdeBuf1 = piocbq->context2;
 	struct lpfc_dmabuf *bdeBuf2 = piocbq->context3;
-	struct lpfc_hbq_entry *hbqe;
 	struct lpfc_sli_ct_request *ct_req;
 	struct bsg_job *job = NULL;
 	struct fc_bsg_reply *bsg_reply;
 	struct bsg_job_data *dd_data = NULL;
 	unsigned long flags;
 	int size = 0;
+	u32 bde_count = 0;
 
 	INIT_LIST_HEAD(&head);
 	list_add_tail(&head, &piocbq->list);
@@ -959,12 +949,17 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		if (phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) {
 			/* take accumulated byte count from the last iocbq */
 			iocbq = list_entry(head.prev, typeof(*iocbq), list);
-			evt_dat->len = iocbq->iocb.unsli3.rcvsli3.acc_len;
+			if (phba->sli_rev == LPFC_SLI_REV4)
+				evt_dat->len = iocbq->wcqe_cmpl.total_data_placed;
+			else
+				evt_dat->len = iocbq->iocb.unsli3.rcvsli3.acc_len;
 		} else {
 			list_for_each_entry(iocbq, &head, list) {
-				for (i = 0; i < iocbq->iocb.ulpBdeCount; i++)
+				iocb = &iocbq->iocb;
+				for (i = 0; i < iocb->ulpBdeCount;
+				     i++)
 					evt_dat->len +=
-					iocbq->iocb.un.cont64[i].tus.f.bdeSize;
+					iocb->un.cont64[i].tus.f.bdeSize;
 			}
 		}
 
@@ -986,20 +981,20 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			if (phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) {
 				bdeBuf1 = iocbq->context2;
 				bdeBuf2 = iocbq->context3;
+
 			}
-			for (i = 0; i < iocbq->iocb.ulpBdeCount; i++) {
+			if (phba->sli_rev == LPFC_SLI_REV4)
+				bde_count = iocbq->wcqe_cmpl.word3;
+			else
+				bde_count = iocbq->iocb.ulpBdeCount;
+			for (i = 0; i < bde_count; i++) {
 				if (phba->sli3_options &
 				    LPFC_SLI3_HBQ_ENABLED) {
 					if (i == 0) {
-						hbqe = (struct lpfc_hbq_entry *)
-						  &iocbq->iocb.un.ulpWord[0];
-						size = hbqe->bde.tus.f.bdeSize;
+						size = iocbq->wqe.gen_req.bde.tus.f.bdeSize;
 						dmabuf = bdeBuf1;
 					} else if (i == 1) {
-						hbqe = (struct lpfc_hbq_entry *)
-							&iocbq->iocb.unsli3.
-							sli3Words[4];
-						size = hbqe->bde.tus.f.bdeSize;
+						size = iocbq->unsol_rcv_len;
 						dmabuf = bdeBuf2;
 					}
 					if ((offset + size) > evt_dat->len)
@@ -1054,16 +1049,16 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 									dmabuf);
 						} else {
 							lpfc_sli3_post_buffer(phba,
-									 pring,
-									 1);
+									      pring,
+									      1);
 						}
 						break;
 					default:
 						if (!(phba->sli3_options &
 						      LPFC_SLI3_HBQ_ENABLED))
 							lpfc_sli3_post_buffer(phba,
-									 pring,
-									 1);
+									      pring,
+									      1);
 						break;
 					}
 				}
@@ -1086,14 +1081,15 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 						phba->ct_ctx[
 						    evt_dat->immed_dat].SID);
 			phba->ct_ctx[evt_dat->immed_dat].rxid =
-				piocbq->iocb.ulpContext;
+				get_job_ulpcontext(phba, piocbq);
 			phba->ct_ctx[evt_dat->immed_dat].oxid =
-				piocbq->iocb.unsli3.rcvsli3.ox_id;
+				get_job_rcvoxid(phba, piocbq);
 			phba->ct_ctx[evt_dat->immed_dat].SID =
-				piocbq->iocb.un.rcvels.remoteID;
+				bf_get(wqe_els_did,
+				       &piocbq->wqe.xmit_els_rsp.wqe_dest);
 			phba->ct_ctx[evt_dat->immed_dat].valid = UNSOL_VALID;
 		} else
-			evt_dat->immed_dat = piocbq->iocb.ulpContext;
+			evt_dat->immed_dat = get_job_ulpcontext(phba, piocbq);
 
 		evt_dat->type = FC_REG_CT_EVENT;
 		list_add(&evt_dat->node, &evt->events_to_see);
@@ -1459,13 +1455,13 @@ lpfc_issue_ct_rsp(struct lpfc_hba *phba, struct bsg_job *job, uint32_t tag,
 		  struct lpfc_dmabuf *cmp, struct lpfc_dmabuf *bmp,
 		  int num_entry)
 {
-	IOCB_t *icmd;
 	struct lpfc_iocbq *ctiocb = NULL;
 	int rc = 0;
 	struct lpfc_nodelist *ndlp = NULL;
 	struct bsg_job_data *dd_data;
 	unsigned long flags;
 	uint32_t creg_val;
+	u16 ulp_context, iotag;
 
 	ndlp = lpfc_findnode_did(phba->pport, phba->ct_ctx[tag].SID);
 	if (!ndlp) {
@@ -1492,62 +1488,36 @@ lpfc_issue_ct_rsp(struct lpfc_hba *phba, struct bsg_job *job, uint32_t tag,
 		goto no_ctiocb;
 	}
 
-	icmd = &ctiocb->iocb;
-	icmd->un.xseq64.bdl.ulpIoTag32 = 0;
-	icmd->un.xseq64.bdl.addrHigh = putPaddrHigh(bmp->phys);
-	icmd->un.xseq64.bdl.addrLow = putPaddrLow(bmp->phys);
-	icmd->un.xseq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
-	icmd->un.xseq64.bdl.bdeSize = (num_entry * sizeof(struct ulp_bde64));
-	icmd->un.xseq64.w5.hcsw.Fctl = (LS | LA);
-	icmd->un.xseq64.w5.hcsw.Dfctl = 0;
-	icmd->un.xseq64.w5.hcsw.Rctl = FC_RCTL_DD_SOL_CTL;
-	icmd->un.xseq64.w5.hcsw.Type = FC_TYPE_CT;
-
-	/* Fill in rest of iocb */
-	icmd->ulpCommand = CMD_XMIT_SEQUENCE64_CX;
-	icmd->ulpBdeCount = 1;
-	icmd->ulpLe = 1;
-	icmd->ulpClass = CLASS3;
 	if (phba->sli_rev == LPFC_SLI_REV4) {
 		/* Do not issue unsol response if oxid not marked as valid */
 		if (phba->ct_ctx[tag].valid != UNSOL_VALID) {
 			rc = IOCB_ERROR;
 			goto issue_ct_rsp_exit;
 		}
-		icmd->ulpContext = phba->ct_ctx[tag].rxid;
-		icmd->unsli3.rcvsli3.ox_id = phba->ct_ctx[tag].oxid;
-		ndlp = lpfc_findnode_did(phba->pport, phba->ct_ctx[tag].SID);
-		if (!ndlp) {
-			lpfc_printf_log(phba, KERN_WARNING, LOG_ELS,
-				 "2721 ndlp null for oxid %x SID %x\n",
-					icmd->ulpContext,
-					phba->ct_ctx[tag].SID);
-			rc = IOCB_ERROR;
-			goto issue_ct_rsp_exit;
-		}
-
-		/* get a refernece count so the ndlp doesn't go away while
-		 * we respond
-		 */
-		if (!lpfc_nlp_get(ndlp)) {
-			rc = IOCB_ERROR;
-			goto issue_ct_rsp_exit;
-		}
 
-		icmd->un.ulpWord[3] =
-				phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
+		lpfc_sli_prep_xmit_seq64(phba, ctiocb, bmp,
+					 phba->sli4_hba.rpi_ids[ndlp->nlp_rpi],
+					 phba->ct_ctx[tag].oxid, num_entry,
+					 FC_RCTL_DD_SOL_CTL, 1,
+					 CMD_XMIT_SEQUENCE64_WQE);
 
 		/* The exchange is done, mark the entry as invalid */
 		phba->ct_ctx[tag].valid = UNSOL_INVALID;
-	} else
-		icmd->ulpContext = (ushort) tag;
+		iotag = get_wqe_reqtag(ctiocb);
+	} else {
+		lpfc_sli_prep_xmit_seq64(phba, ctiocb, bmp, 0, tag, num_entry,
+					 FC_RCTL_DD_SOL_CTL, 1,
+					 CMD_XMIT_SEQUENCE64_CX);
+		ctiocb->num_bdes = num_entry;
+		iotag = ctiocb->iocb.ulpIoTag;
+	}
 
-	icmd->ulpTimeout = phba->fc_ratov * 2;
+	ulp_context = get_job_ulpcontext(phba, ctiocb);
 
 	/* Xmit CT response on exchange <xid> */
 	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
-		"2722 Xmit CT response on exchange x%x Data: x%x x%x x%x\n",
-		icmd->ulpContext, icmd->ulpIoTag, tag, phba->link_state);
+			"2722 Xmit CT response on exchange x%x Data: x%x x%x x%x\n",
+			ulp_context, iotag, tag, phba->link_state);
 
 	ctiocb->cmd_flag |= LPFC_IO_LIBDFC;
 	ctiocb->vport = phba->pport;
@@ -2633,7 +2603,6 @@ static int lpfcdiag_loop_get_xri(struct lpfc_hba *phba, uint16_t rpi,
 {
 	struct lpfc_bsg_event *evt;
 	struct lpfc_iocbq *cmdiocbq, *rspiocbq;
-	IOCB_t *cmd, *rsp;
 	struct lpfc_dmabuf *dmabuf;
 	struct ulp_bde64 *bpl = NULL;
 	struct lpfc_sli_ct_request *ctreq = NULL;
@@ -2641,6 +2610,7 @@ static int lpfcdiag_loop_get_xri(struct lpfc_hba *phba, uint16_t rpi,
 	int time_left;
 	int iocb_stat = IOCB_SUCCESS;
 	unsigned long flags;
+	u32 status;
 
 	*txxri = 0;
 	*rxxri = 0;
@@ -2684,9 +2654,6 @@ static int lpfcdiag_loop_get_xri(struct lpfc_hba *phba, uint16_t rpi,
 		goto err_get_xri_exit;
 	}
 
-	cmd = &cmdiocbq->iocb;
-	rsp = &rspiocbq->iocb;
-
 	memset(ctreq, 0, ELX_LOOPBACK_HEADER_SZ);
 
 	ctreq->RevisionId.bits.Revision = SLI_CT_REVISION;
@@ -2696,36 +2663,24 @@ static int lpfcdiag_loop_get_xri(struct lpfc_hba *phba, uint16_t rpi,
 	ctreq->CommandResponse.bits.CmdRsp = ELX_LOOPBACK_XRI_SETUP;
 	ctreq->CommandResponse.bits.Size = 0;
 
-
-	cmd->un.xseq64.bdl.addrHigh = putPaddrHigh(dmabuf->phys);
-	cmd->un.xseq64.bdl.addrLow = putPaddrLow(dmabuf->phys);
-	cmd->un.xseq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
-	cmd->un.xseq64.bdl.bdeSize = sizeof(*bpl);
-
-	cmd->un.xseq64.w5.hcsw.Fctl = LA;
-	cmd->un.xseq64.w5.hcsw.Dfctl = 0;
-	cmd->un.xseq64.w5.hcsw.Rctl = FC_RCTL_DD_UNSOL_CTL;
-	cmd->un.xseq64.w5.hcsw.Type = FC_TYPE_CT;
-
-	cmd->ulpCommand = CMD_XMIT_SEQUENCE64_CR;
-	cmd->ulpBdeCount = 1;
-	cmd->ulpLe = 1;
-	cmd->ulpClass = CLASS3;
-	cmd->ulpContext = rpi;
-
+	cmdiocbq->context3 = dmabuf;
 	cmdiocbq->cmd_flag |= LPFC_IO_LIBDFC;
 	cmdiocbq->vport = phba->pport;
 	cmdiocbq->cmd_cmpl = NULL;
 
+	lpfc_sli_prep_xmit_seq64(phba, cmdiocbq, dmabuf, rpi, 0, 1,
+				 FC_RCTL_DD_SOL_CTL, 0, CMD_XMIT_SEQUENCE64_CR);
+
 	iocb_stat = lpfc_sli_issue_iocb_wait(phba, LPFC_ELS_RING, cmdiocbq,
-				rspiocbq,
-				(phba->fc_ratov * 2)
-				+ LPFC_DRVR_TIMEOUT);
-	if ((iocb_stat != IOCB_SUCCESS) || (rsp->ulpStatus != IOSTAT_SUCCESS)) {
+					     rspiocbq, (phba->fc_ratov * 2)
+					     + LPFC_DRVR_TIMEOUT);
+
+	status = get_job_ulpstatus(phba, rspiocbq);
+	if (iocb_stat != IOCB_SUCCESS || status != IOCB_SUCCESS) {
 		ret_val = -EIO;
 		goto err_get_xri_exit;
 	}
-	*txxri =  rsp->ulpContext;
+	*txxri = get_job_ulpcontext(phba, rspiocbq);
 
 	evt->waiting = 1;
 	evt->wait_time_stamp = jiffies;
@@ -2926,7 +2881,7 @@ diag_cmd_data_alloc(struct lpfc_hba *phba,
 }
 
 /**
- * lpfcdiag_loop_post_rxbufs - post the receive buffers for an unsol CT cmd
+ * lpfcdiag_sli3_loop_post_rxbufs - post the receive buffers for an unsol CT cmd
  * @phba: Pointer to HBA context object
  * @rxxri: Receive exchange id
  * @len: Number of data bytes
@@ -2934,8 +2889,8 @@ diag_cmd_data_alloc(struct lpfc_hba *phba,
  * This function allocates and posts a data buffer of sufficient size to receive
  * an unsolicted CT command.
  **/
-static int lpfcdiag_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
-			     size_t len)
+static int lpfcdiag_sli3_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
+					  size_t len)
 {
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *cmdiocbq;
@@ -2972,7 +2927,6 @@ static int lpfcdiag_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 	/* Queue buffers for the receive exchange */
 	num_bde = (uint32_t)rxbuffer->flag;
 	dmp = &rxbuffer->dma;
-
 	cmd = &cmdiocbq->iocb;
 	i = 0;
 
@@ -3040,7 +2994,6 @@ static int lpfcdiag_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 			ret_val = -EIO;
 			goto err_post_rxbufs_exit;
 		}
-
 		cmd = &cmdiocbq->iocb;
 		i = 0;
 	}
@@ -3092,7 +3045,7 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 	size_t segment_len = 0, segment_offset = 0, current_offset = 0;
 	uint16_t rpi = 0;
 	struct lpfc_iocbq *cmdiocbq, *rspiocbq = NULL;
-	IOCB_t *cmd, *rsp = NULL;
+	union lpfc_wqe128 *cmdwqe, *rspwqe;
 	struct lpfc_sli_ct_request *ctreq;
 	struct lpfc_dmabuf *txbmp;
 	struct ulp_bde64 *txbpl = NULL;
@@ -3185,7 +3138,7 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 			goto loopback_test_exit;
 		}
 
-		rc = lpfcdiag_loop_post_rxbufs(phba, rxxri, full_size);
+		rc = lpfcdiag_sli3_loop_post_rxbufs(phba, rxxri, full_size);
 		if (rc) {
 			lpfcdiag_loop_self_unreg(phba, rpi);
 			goto loopback_test_exit;
@@ -3228,9 +3181,12 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 		goto err_loopback_test_exit;
 	}
 
-	cmd = &cmdiocbq->iocb;
-	if (phba->sli_rev < LPFC_SLI_REV4)
-		rsp = &rspiocbq->iocb;
+	cmdwqe = &cmdiocbq->wqe;
+	memset(cmdwqe, 0, sizeof(union lpfc_wqe));
+	if (phba->sli_rev < LPFC_SLI_REV4) {
+		rspwqe = &rspiocbq->wqe;
+		memset(rspwqe, 0, sizeof(union lpfc_wqe));
+	}
 
 	INIT_LIST_HEAD(&head);
 	list_add_tail(&head, &txbuffer->dma.list);
@@ -3262,42 +3218,32 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 	/* Build the XMIT_SEQUENCE iocb */
 	num_bde = (uint32_t)txbuffer->flag;
 
-	cmd->un.xseq64.bdl.addrHigh = putPaddrHigh(txbmp->phys);
-	cmd->un.xseq64.bdl.addrLow = putPaddrLow(txbmp->phys);
-	cmd->un.xseq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
-	cmd->un.xseq64.bdl.bdeSize = (num_bde * sizeof(struct ulp_bde64));
-
-	cmd->un.xseq64.w5.hcsw.Fctl = (LS | LA);
-	cmd->un.xseq64.w5.hcsw.Dfctl = 0;
-	cmd->un.xseq64.w5.hcsw.Rctl = FC_RCTL_DD_UNSOL_CTL;
-	cmd->un.xseq64.w5.hcsw.Type = FC_TYPE_CT;
-
-	cmd->ulpCommand = CMD_XMIT_SEQUENCE64_CX;
-	cmd->ulpBdeCount = 1;
-	cmd->ulpLe = 1;
-	cmd->ulpClass = CLASS3;
+	cmdiocbq->num_bdes = num_bde;
+	cmdiocbq->cmd_flag |= LPFC_IO_LIBDFC;
+	cmdiocbq->cmd_flag |= LPFC_IO_LOOPBACK;
+	cmdiocbq->vport = phba->pport;
+	cmdiocbq->cmd_cmpl = NULL;
+	cmdiocbq->context3 = txbmp;
 
 	if (phba->sli_rev < LPFC_SLI_REV4) {
-		cmd->ulpContext = txxri;
+		lpfc_sli_prep_xmit_seq64(phba, cmdiocbq, txbmp, 0, txxri,
+					 num_bde, FC_RCTL_DD_UNSOL_CTL, 1,
+					 CMD_XMIT_SEQUENCE64_CX);
+
 	} else {
-		cmd->un.xseq64.bdl.ulpIoTag32 = 0;
-		cmd->un.ulpWord[3] = phba->sli4_hba.rpi_ids[rpi];
-		cmdiocbq->context3 = txbmp;
+		lpfc_sli_prep_xmit_seq64(phba, cmdiocbq, txbmp,
+					 phba->sli4_hba.rpi_ids[rpi], 0xffff,
+					 full_size, FC_RCTL_DD_UNSOL_CTL, 1,
+					 CMD_XMIT_SEQUENCE64_WQE);
 		cmdiocbq->sli4_xritag = NO_XRI;
-		cmd->unsli3.rcvsli3.ox_id = 0xffff;
 	}
-	cmdiocbq->cmd_flag |= LPFC_IO_LIBDFC;
-	cmdiocbq->cmd_flag |= LPFC_IO_LOOPBACK;
-	cmdiocbq->vport = phba->pport;
-	cmdiocbq->cmd_cmpl = NULL;
 
 	iocb_stat = lpfc_sli_issue_iocb_wait(phba, LPFC_ELS_RING, cmdiocbq,
 					     rspiocbq, (phba->fc_ratov * 2) +
 					     LPFC_DRVR_TIMEOUT);
-
-	if ((iocb_stat != IOCB_SUCCESS) ||
-	    ((phba->sli_rev < LPFC_SLI_REV4) &&
-	     (rsp->ulpStatus != IOSTAT_SUCCESS))) {
+	if (iocb_stat != IOCB_SUCCESS ||
+	    (phba->sli_rev < LPFC_SLI_REV4 &&
+	     (get_job_ulpstatus(phba, rspiocbq) != IOSTAT_SUCCESS))) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_LIBDFC,
 				"3126 Failed loopback test issue iocb: "
 				"iocb_stat:x%x\n", iocb_stat);
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 9d2c611c6466..62c37df83f6c 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -358,6 +358,14 @@ void lpfc_sli_prep_els_req_rsp(struct lpfc_hba *phba,
 			       struct lpfc_vport *vport,
 			       struct lpfc_dmabuf *bmp, u16 cmd_size, u32 did,
 			       u32 elscmd, u8 tmo, u8 expect_rsp);
+void lpfc_sli_prep_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocbq,
+			   struct lpfc_dmabuf *bmp, u16 rpi, u32 num_entry,
+			   u8 tmo);
+void lpfc_sli_prep_xmit_seq64(struct lpfc_hba *phba,
+			      struct lpfc_iocbq *cmdiocbq,
+			      struct lpfc_dmabuf *bmp, u16 rpi, u16 ox_id,
+			      u32 num_entry, u8 rctl, u8 last_seq,
+			      u8 cr_cx_cmd);
 struct lpfc_sglq *__lpfc_clear_active_sglq(struct lpfc_hba *phba, uint16_t xri);
 struct lpfc_sglq *__lpfc_sli_get_nvmet_sglq(struct lpfc_hba *phba,
 					    struct lpfc_iocbq *piocbq);
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index b78823a305cc..31f185a11bcb 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -87,12 +87,12 @@ lpfc_ct_ignore_hbq_buffer(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq,
 		lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
 				"0146 Ignoring unsolicited CT No HBQ "
 				"status = x%x\n",
-				piocbq->iocb.ulpStatus);
+				get_job_ulpstatus(phba, piocbq));
 	}
 	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
 			"0145 Ignoring unsolicted CT HBQ Size:%d "
 			"status = x%x\n",
-			size, piocbq->iocb.ulpStatus);
+			size, get_job_ulpstatus(phba, piocbq));
 }
 
 static void
@@ -143,7 +143,7 @@ lpfc_ct_unsol_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
  * lpfc_ct_reject_event - Issue reject for unhandled CT MIB commands
  * @ndlp: pointer to a node-list data structure.
  * @ct_req: pointer to the CT request data structure.
- * @rx_id: rx_id of the received UNSOL CT command
+ * @ulp_context: context of received UNSOL CT command
  * @ox_id: ox_id of the UNSOL CT command
  *
  * This routine is invoked by the lpfc_ct_handle_mibreq routine for sending
@@ -152,7 +152,7 @@ lpfc_ct_unsol_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 static void
 lpfc_ct_reject_event(struct lpfc_nodelist *ndlp,
 		     struct lpfc_sli_ct_request *ct_req,
-		     u16 rx_id, u16 ox_id)
+		     u16 ulp_context, u16 ox_id)
 {
 	struct lpfc_vport *vport = ndlp->vport;
 	struct lpfc_hba *phba = vport->phba;
@@ -161,8 +161,8 @@ lpfc_ct_reject_event(struct lpfc_nodelist *ndlp,
 	struct lpfc_dmabuf *bmp = NULL;
 	struct lpfc_dmabuf *mp = NULL;
 	struct ulp_bde64 *bpl;
-	IOCB_t *icmd;
 	u8 rc = 0;
+	u32 tmo;
 
 	/* fill in BDEs for command */
 	mp = kmalloc(sizeof(*mp), GFP_KERNEL);
@@ -220,43 +220,41 @@ lpfc_ct_reject_event(struct lpfc_nodelist *ndlp,
 		goto ct_free_bmpvirt;
 	}
 
-	icmd = &cmdiocbq->iocb;
-	icmd->un.genreq64.bdl.ulpIoTag32 = 0;
-	icmd->un.genreq64.bdl.addrHigh = putPaddrHigh(bmp->phys);
-	icmd->un.genreq64.bdl.addrLow = putPaddrLow(bmp->phys);
-	icmd->un.genreq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
-	icmd->un.genreq64.bdl.bdeSize = sizeof(struct ulp_bde64);
-	icmd->un.genreq64.w5.hcsw.Fctl = (LS | LA);
-	icmd->un.genreq64.w5.hcsw.Dfctl = 0;
-	icmd->un.genreq64.w5.hcsw.Rctl = FC_RCTL_DD_SOL_CTL;
-	icmd->un.genreq64.w5.hcsw.Type = FC_TYPE_CT;
-	icmd->ulpCommand = CMD_XMIT_SEQUENCE64_CX;
-	icmd->ulpBdeCount = 1;
-	icmd->ulpLe = 1;
-	icmd->ulpClass = CLASS3;
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		lpfc_sli_prep_xmit_seq64(phba, cmdiocbq, bmp,
+					 phba->sli4_hba.rpi_ids[ndlp->nlp_rpi],
+					 ox_id, 1, FC_RCTL_DD_SOL_CTL, 1,
+					 CMD_XMIT_SEQUENCE64_WQE);
+	} else {
+		lpfc_sli_prep_xmit_seq64(phba, cmdiocbq, bmp, 0, ulp_context, 1,
+					 FC_RCTL_DD_SOL_CTL, 1,
+					 CMD_XMIT_SEQUENCE64_CX);
+	}
 
 	/* Save for completion so we can release these resources */
-	cmdiocbq->context1 = lpfc_nlp_get(ndlp);
 	cmdiocbq->context2 = (uint8_t *)mp;
 	cmdiocbq->context3 = (uint8_t *)bmp;
 	cmdiocbq->cmd_cmpl = lpfc_ct_unsol_cmpl;
-	icmd->ulpContext = rx_id;  /* Xri / rx_id */
-	icmd->unsli3.rcvsli3.ox_id = ox_id;
-	icmd->un.ulpWord[3] =
-		phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
-	icmd->ulpTimeout = (3 * phba->fc_ratov);
+	tmo = (3 * phba->fc_ratov);
 
 	cmdiocbq->retry = 0;
 	cmdiocbq->vport = vport;
 	cmdiocbq->context_un.ndlp = NULL;
-	cmdiocbq->drvrTimeout = icmd->ulpTimeout + LPFC_DRVR_TIMEOUT;
+	cmdiocbq->drvrTimeout = tmo + LPFC_DRVR_TIMEOUT;
+
+	cmdiocbq->context1 = lpfc_nlp_get(ndlp);
+	if (!cmdiocbq->context1)
+		goto ct_no_ndlp;
 
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, cmdiocbq, 0);
-	if (!rc)
-		return;
+	if (rc) {
+		lpfc_nlp_put(ndlp);
+		goto ct_no_ndlp;
+	}
+	return;
 
+ct_no_ndlp:
 	rc = 6;
-	lpfc_nlp_put(ndlp);
 	lpfc_sli_release_iocbq(phba, cmdiocbq);
 ct_free_bmpvirt:
 	lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
@@ -286,25 +284,17 @@ lpfc_ct_handle_mibreq(struct lpfc_hba *phba, struct lpfc_iocbq *ctiocbq)
 {
 	struct lpfc_sli_ct_request *ct_req;
 	struct lpfc_nodelist *ndlp = NULL;
-	struct lpfc_vport *vport = NULL;
-	IOCB_t *icmd = &ctiocbq->iocb;
-	u32 mi_cmd, vpi;
-	u32 did = 0;
-
-	vpi = ctiocbq->iocb.unsli3.rcvsli3.vpi;
-	vport = lpfc_find_vport_by_vpid(phba, vpi);
-	if (!vport) {
-		lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
-				"6437 Unsol CT: VPORT NULL vpi : x%x\n",
-				vpi);
-		return;
-	}
-
-	did = ctiocbq->iocb.un.rcvels.remoteID;
-	if (icmd->ulpStatus) {
+	struct lpfc_vport *vport = ctiocbq->vport;
+	u32 ulp_status = get_job_ulpstatus(phba, ctiocbq);
+	u32 ulp_word4 = get_job_word4(phba, ctiocbq);
+	u32 did;
+	u32 mi_cmd;
+
+	did = bf_get(els_rsp64_sid, &ctiocbq->wqe.xmit_els_rsp);
+	if (ulp_status) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "6438 Unsol CT: status:x%x/x%x did : x%x\n",
-				 icmd->ulpStatus, icmd->un.ulpWord[4], did);
+				 ulp_status, ulp_word4, did);
 		return;
 	}
 
@@ -322,13 +312,14 @@ lpfc_ct_handle_mibreq(struct lpfc_hba *phba, struct lpfc_iocbq *ctiocbq)
 
 	ct_req = ((struct lpfc_sli_ct_request *)
 		 (((struct lpfc_dmabuf *)ctiocbq->context2)->virt));
-
 	mi_cmd = ct_req->CommandResponse.bits.CmdRsp;
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "6442 : MI Cmd : x%x Not Supported\n", mi_cmd);
 	lpfc_ct_reject_event(ndlp, ct_req,
-			     ctiocbq->iocb.ulpContext,
-			     ctiocbq->iocb.unsli3.rcvsli3.ox_id);
+			     bf_get(wqe_ctxt_tag,
+				    &ctiocbq->wqe.xmit_els_rsp.wqe_com),
+			     bf_get(wqe_rcvoxid,
+				    &ctiocbq->wqe.xmit_els_rsp.wqe_com));
 }
 
 /**
@@ -351,21 +342,32 @@ lpfc_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	IOCB_t *icmd = &ctiocbq->iocb;
 	int i;
 	struct lpfc_iocbq *iocbq;
+	struct lpfc_iocbq *iocb;
 	dma_addr_t dma_addr;
 	uint32_t size;
 	struct list_head head;
 	struct lpfc_sli_ct_request *ct_req;
 	struct lpfc_dmabuf *bdeBuf1 = ctiocbq->context2;
 	struct lpfc_dmabuf *bdeBuf2 = ctiocbq->context3;
+	u32 status, parameter, bde_count = 0;
+	struct lpfc_wcqe_complete *wcqe_cmpl = NULL;
 
 	ctiocbq->context1 = NULL;
 	ctiocbq->context2 = NULL;
 	ctiocbq->context3 = NULL;
 
-	if (unlikely(icmd->ulpStatus == IOSTAT_NEED_BUFFER)) {
+	wcqe_cmpl = &ctiocbq->wcqe_cmpl;
+	status = get_job_ulpstatus(phba, ctiocbq);
+	parameter = get_job_word4(phba, ctiocbq);
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		bde_count = wcqe_cmpl->word3;
+	else
+		bde_count = icmd->ulpBdeCount;
+
+	if (unlikely(status == IOSTAT_NEED_BUFFER)) {
 		lpfc_sli_hbqbuf_add_hbqs(phba, LPFC_ELS_HBQ);
-	} else if ((icmd->ulpStatus == IOSTAT_LOCAL_REJECT) &&
-		   ((icmd->un.ulpWord[4] & IOERR_PARAM_MASK) ==
+	} else if ((status == IOSTAT_LOCAL_REJECT) &&
+		   ((parameter & IOERR_PARAM_MASK) ==
 		   IOERR_RCV_BUFFER_WAITING)) {
 		/* Not enough posted buffers; Try posting more buffers */
 		phba->fc_stat.NoRcvBuf++;
@@ -377,26 +379,12 @@ lpfc_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	/* If there are no BDEs associated
 	 * with this IOCB, there is nothing to do.
 	 */
-	if (icmd->ulpBdeCount == 0)
+	if (bde_count == 0)
 		return;
 
-	if (phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) {
-		ctiocbq->context2 = bdeBuf1;
-		if (icmd->ulpBdeCount == 2)
-			ctiocbq->context3 = bdeBuf2;
-	} else {
-		dma_addr = getPaddr(icmd->un.cont64[0].addrHigh,
-				    icmd->un.cont64[0].addrLow);
-		ctiocbq->context2 = lpfc_sli_ringpostbuf_get(phba, pring,
-							     dma_addr);
-		if (icmd->ulpBdeCount == 2) {
-			dma_addr = getPaddr(icmd->un.cont64[1].addrHigh,
-					    icmd->un.cont64[1].addrLow);
-			ctiocbq->context3 = lpfc_sli_ringpostbuf_get(phba,
-								     pring,
-								     dma_addr);
-		}
-	}
+	ctiocbq->context2 = bdeBuf1;
+	if (bde_count == 2)
+		ctiocbq->context3 = bdeBuf2;
 
 	ct_req = ((struct lpfc_sli_ct_request *)
 		 (((struct lpfc_dmabuf *)ctiocbq->context2)->virt));
@@ -412,19 +400,29 @@ lpfc_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	if (phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) {
 		INIT_LIST_HEAD(&head);
 		list_add_tail(&head, &ctiocbq->list);
-		list_for_each_entry(iocbq, &head, list) {
-			icmd = &iocbq->iocb;
-			if (icmd->ulpBdeCount == 0)
+		list_for_each_entry(iocb, &head, list) {
+			if (phba->sli_rev == LPFC_SLI_REV4)
+				bde_count = iocb->wcqe_cmpl.word3;
+			else
+				bde_count = iocb->iocb.ulpBdeCount;
+
+			if (!bde_count)
 				continue;
-			bdeBuf1 = iocbq->context2;
-			iocbq->context2 = NULL;
-			size  = icmd->un.cont64[0].tus.f.bdeSize;
+			bdeBuf1 = iocb->context2;
+			iocb->context2 = NULL;
+			if (phba->sli_rev == LPFC_SLI_REV4)
+				size = iocb->wqe.gen_req.bde.tus.f.bdeSize;
+			else
+				size  = iocb->iocb.un.cont64[0].tus.f.bdeSize;
 			lpfc_ct_unsol_buffer(phba, ctiocbq, bdeBuf1, size);
 			lpfc_in_buf_free(phba, bdeBuf1);
-			if (icmd->ulpBdeCount == 2) {
-				bdeBuf2 = iocbq->context3;
-				iocbq->context3 = NULL;
-				size  = icmd->unsli3.rcvsli3.bde2.tus.f.bdeSize;
+			if (bde_count == 2) {
+				bdeBuf2 = iocb->context3;
+				iocb->context3 = NULL;
+				if (phba->sli_rev == LPFC_SLI_REV4)
+					size = iocb->unsol_rcv_len;
+				else
+					size = iocb->iocb.unsli3.rcvsli3.bde2.tus.f.bdeSize;
 				lpfc_ct_unsol_buffer(phba, ctiocbq, bdeBuf2,
 						     size);
 				lpfc_in_buf_free(phba, bdeBuf2);
@@ -588,15 +586,15 @@ lpfc_ct_free_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *ctiocb)
 static int
 lpfc_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 	     struct lpfc_dmabuf *inp, struct lpfc_dmabuf *outp,
-	     void (*cmpl) (struct lpfc_hba *, struct lpfc_iocbq *,
-		     struct lpfc_iocbq *),
+	     void (*cmpl)(struct lpfc_hba *, struct lpfc_iocbq *,
+			  struct lpfc_iocbq *),
 	     struct lpfc_nodelist *ndlp, uint32_t event_tag, uint32_t num_entry,
 	     uint32_t tmo, uint8_t retry)
 {
 	struct lpfc_hba  *phba = vport->phba;
-	IOCB_t *icmd;
 	struct lpfc_iocbq *geniocb;
 	int rc;
+	u16 ulp_context;
 
 	/* Allocate buffer for  command iocb */
 	geniocb = lpfc_sli_get_iocbq(phba);
@@ -604,12 +602,8 @@ lpfc_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 	if (geniocb == NULL)
 		return 1;
 
-	icmd = &geniocb->iocb;
-	icmd->un.genreq64.bdl.ulpIoTag32 = 0;
-	icmd->un.genreq64.bdl.addrHigh = putPaddrHigh(bmp->phys);
-	icmd->un.genreq64.bdl.addrLow = putPaddrLow(bmp->phys);
-	icmd->un.genreq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
-	icmd->un.genreq64.bdl.bdeSize = (num_entry * sizeof(struct ulp_bde64));
+	/* Update the num_entry bde count */
+	geniocb->num_bdes = num_entry;
 
 	geniocb->context3 = (uint8_t *) bmp;
 
@@ -619,41 +613,26 @@ lpfc_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 
 	geniocb->event_tag = event_tag;
 
-	/* Fill in payload, bp points to frame payload */
-	icmd->ulpCommand = CMD_GEN_REQUEST64_CR;
-
-	/* Fill in rest of iocb */
-	icmd->un.genreq64.w5.hcsw.Fctl = (SI | LA);
-	icmd->un.genreq64.w5.hcsw.Dfctl = 0;
-	icmd->un.genreq64.w5.hcsw.Rctl = FC_RCTL_DD_UNSOL_CTL;
-	icmd->un.genreq64.w5.hcsw.Type = FC_TYPE_CT;
-
 	if (!tmo) {
 		 /* FC spec states we need 3 * ratov for CT requests */
 		tmo = (3 * phba->fc_ratov);
 	}
-	icmd->ulpTimeout = tmo;
-	icmd->ulpBdeCount = 1;
-	icmd->ulpLe = 1;
-	icmd->ulpClass = CLASS3;
-	icmd->ulpContext = ndlp->nlp_rpi;
+
 	if (phba->sli_rev == LPFC_SLI_REV4)
-		icmd->ulpContext = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
+		ulp_context = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
+	else
+		ulp_context = ndlp->nlp_rpi;
 
-	if (phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) {
-		/* For GEN_REQUEST64_CR, use the RPI */
-		icmd->ulpCt_h = 0;
-		icmd->ulpCt_l = 0;
-	}
+	lpfc_sli_prep_gen_req(phba, geniocb, bmp, ulp_context, num_entry, tmo);
 
 	/* Issue GEN REQ IOCB for NPORT <did> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0119 Issue GEN REQ IOCB to NPORT x%x "
 			 "Data: x%x x%x\n",
-			 ndlp->nlp_DID, icmd->ulpIoTag,
+			 ndlp->nlp_DID, geniocb->iotag,
 			 vport->port_state);
 	geniocb->cmd_cmpl = cmpl;
-	geniocb->drvrTimeout = icmd->ulpTimeout + LPFC_DRVR_TIMEOUT;
+	geniocb->drvrTimeout = tmo + LPFC_DRVR_TIMEOUT;
 	geniocb->vport = vport;
 	geniocb->retry = retry;
 	geniocb->context_un.ndlp = lpfc_nlp_get(ndlp);
@@ -661,9 +640,7 @@ lpfc_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 		goto out;
 
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, geniocb, 0);
-
 	if (rc == IOCB_ERROR) {
-		geniocb->context_un.ndlp = NULL;
 		lpfc_nlp_put(ndlp);
 		goto out;
 	}
@@ -939,12 +916,13 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 {
 	struct lpfc_vport *vport = cmdiocb->vport;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
-	IOCB_t *irsp;
 	struct lpfc_dmabuf *outp;
 	struct lpfc_dmabuf *inp;
 	struct lpfc_sli_ct_request *CTrsp;
 	struct lpfc_sli_ct_request *CTreq;
 	struct lpfc_nodelist *ndlp;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 	int rc, type;
 
 	/* First save ndlp, before we overwrite it */
@@ -952,13 +930,13 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
+
 	inp = (struct lpfc_dmabuf *) cmdiocb->context1;
 	outp = (struct lpfc_dmabuf *) cmdiocb->context2;
-	irsp = &rspiocb->iocb;
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 		 "GID_FT cmpl:     status:x%x/x%x rtry:%d",
-		irsp->ulpStatus, irsp->un.ulpWord[4], vport->fc_ns_retry);
+		ulp_status, ulp_word4, vport->fc_ns_retry);
 
 	/* Ignore response if link flipped after this request was made */
 	if (cmdiocb->event_tag != phba->fc_eventTag) {
@@ -982,7 +960,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 		goto out;
 	}
-	if (lpfc_error_lost_link(irsp->ulpStatus, irsp->un.ulpWord[4])) {
+	if (lpfc_error_lost_link(ulp_status, ulp_word4)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "0226 NS query failed due to link event\n");
 		if (vport->fc_flag & FC_RSCN_MODE)
@@ -1014,11 +992,11 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 	spin_unlock_irq(shost->host_lock);
 
-	if (irsp->ulpStatus) {
+	if (ulp_status) {
 		/* Check for retry */
 		if (vport->fc_ns_retry < LPFC_MAX_NS_RETRY) {
-			if (irsp->ulpStatus != IOSTAT_LOCAL_REJECT ||
-			    (irsp->un.ulpWord[4] & IOERR_PARAM_MASK) !=
+			if (ulp_status != IOSTAT_LOCAL_REJECT ||
+			    (ulp_word4 & IOERR_PARAM_MASK) !=
 			    IOERR_NO_RESOURCES)
 				vport->fc_ns_retry++;
 
@@ -1041,7 +1019,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0257 GID_FT Query error: 0x%x 0x%x\n",
-				 irsp->ulpStatus, vport->fc_ns_retry);
+				 ulp_status, vport->fc_ns_retry);
 	} else {
 		/* Good status, continue checking */
 		CTreq = (struct lpfc_sli_ct_request *) inp->virt;
@@ -1055,12 +1033,12 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					 CTreq->un.gid.Fc4Type,
 					 vport->num_disc_nodes,
 					 vport->gidft_inp,
-					 irsp->un.genreq64.bdl.bdeSize);
+					 get_job_data_placed(phba, rspiocb));
 
 			lpfc_ns_rsp(vport,
 				    outp,
 				    CTreq->un.gid.Fc4Type,
-				    (uint32_t) (irsp->un.genreq64.bdl.bdeSize));
+				    get_job_data_placed(phba, rspiocb));
 		} else if (CTrsp->CommandResponse.bits.CmdRsp ==
 			   be16_to_cpu(SLI_CT_RESPONSE_FS_RJT)) {
 			/* NameServer Rsp Error */
@@ -1155,12 +1133,13 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 {
 	struct lpfc_vport *vport = cmdiocb->vport;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
-	IOCB_t *irsp;
 	struct lpfc_dmabuf *outp;
 	struct lpfc_dmabuf *inp;
 	struct lpfc_sli_ct_request *CTrsp;
 	struct lpfc_sli_ct_request *CTreq;
 	struct lpfc_nodelist *ndlp;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 	int rc;
 
 	/* First save ndlp, before we overwrite it */
@@ -1170,11 +1149,10 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	cmdiocb->context_un.rsp_iocb = rspiocb;
 	inp = (struct lpfc_dmabuf *)cmdiocb->context1;
 	outp = (struct lpfc_dmabuf *)cmdiocb->context2;
-	irsp = &rspiocb->iocb;
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 			      "GID_PT cmpl:     status:x%x/x%x rtry:%d",
-			      irsp->ulpStatus, irsp->un.ulpWord[4],
+			      ulp_status, ulp_word4,
 			      vport->fc_ns_retry);
 
 	/* Ignore response if link flipped after this request was made */
@@ -1199,7 +1177,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 		goto out;
 	}
-	if (lpfc_error_lost_link(irsp->ulpStatus, irsp->un.ulpWord[4])) {
+	if (lpfc_error_lost_link(ulp_status, ulp_word4)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "4166 NS query failed due to link event\n");
 		if (vport->fc_flag & FC_RSCN_MODE)
@@ -1231,11 +1209,11 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 	spin_unlock_irq(shost->host_lock);
 
-	if (irsp->ulpStatus) {
+	if (ulp_status) {
 		/* Check for retry */
 		if (vport->fc_ns_retry < LPFC_MAX_NS_RETRY) {
-			if (irsp->ulpStatus != IOSTAT_LOCAL_REJECT ||
-			    (irsp->un.ulpWord[4] & IOERR_PARAM_MASK) !=
+			if (ulp_status != IOSTAT_LOCAL_REJECT ||
+			    (ulp_word4 & IOERR_PARAM_MASK) !=
 			    IOERR_NO_RESOURCES)
 				vport->fc_ns_retry++;
 
@@ -1254,7 +1232,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "4103 GID_FT Query error: 0x%x 0x%x\n",
-				 irsp->ulpStatus, vport->fc_ns_retry);
+				 ulp_status, vport->fc_ns_retry);
 	} else {
 		/* Good status, continue checking */
 		CTreq = (struct lpfc_sli_ct_request *)inp->virt;
@@ -1268,12 +1246,12 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					 CTreq->un.gid.Fc4Type,
 					 vport->num_disc_nodes,
 					 vport->gidft_inp,
-					 irsp->un.genreq64.bdl.bdeSize);
+					 get_job_data_placed(phba, rspiocb));
 
 			lpfc_ns_rsp(vport,
 				    outp,
 				    CTreq->un.gid.Fc4Type,
-				    (uint32_t)(irsp->un.genreq64.bdl.bdeSize));
+				    get_job_data_placed(phba, rspiocb));
 		} else if (CTrsp->CommandResponse.bits.CmdRsp ==
 			   be16_to_cpu(SLI_CT_RESPONSE_FS_RJT)) {
 			/* NameServer Rsp Error */
@@ -1368,20 +1346,21 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 {
 	struct lpfc_vport *vport = cmdiocb->vport;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_dmabuf *inp = (struct lpfc_dmabuf *) cmdiocb->context1;
 	struct lpfc_dmabuf *outp = (struct lpfc_dmabuf *) cmdiocb->context2;
 	struct lpfc_sli_ct_request *CTrsp;
 	int did, rc, retry;
 	uint8_t fbits;
 	struct lpfc_nodelist *ndlp = NULL, *free_ndlp = NULL;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 
 	did = ((struct lpfc_sli_ct_request *) inp->virt)->un.gff.PortId;
 	did = be32_to_cpu(did);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 		"GFF_ID cmpl:     status:x%x/x%x did:x%x",
-		irsp->ulpStatus, irsp->un.ulpWord[4], did);
+		ulp_status, ulp_word4, did);
 
 	/* Ignore response if link flipped after this request was made */
 	if (cmdiocb->event_tag != phba->fc_eventTag) {
@@ -1390,7 +1369,7 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto iocb_free;
 	}
 
-	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
+	if (ulp_status == IOSTAT_SUCCESS) {
 		/* Good status, continue checking */
 		CTrsp = (struct lpfc_sli_ct_request *) outp->virt;
 		fbits = CTrsp->un.gff_acc.fbits[FCP_TYPE_FEATURE_OFFSET];
@@ -1420,8 +1399,8 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Check for retry */
 		if (cmdiocb->retry < LPFC_MAX_NS_RETRY) {
 			retry = 1;
-			if (irsp->ulpStatus == IOSTAT_LOCAL_REJECT) {
-				switch ((irsp->un.ulpWord[4] &
+			if (ulp_status == IOSTAT_LOCAL_REJECT) {
+				switch ((ulp_word4 &
 					IOERR_PARAM_MASK)) {
 
 				case IOERR_NO_RESOURCES:
@@ -1457,7 +1436,7 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0267 NameServer GFF Rsp "
 				 "x%x Error (%d %d) Data: x%x x%x\n",
-				 did, irsp->ulpStatus, irsp->un.ulpWord[4],
+				 did, ulp_status, ulp_word4,
 				 vport->fc_flag, vport->fc_rscn_id_cnt);
 	}
 
@@ -1512,10 +1491,9 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 static void
 lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
-				struct lpfc_iocbq *rspiocb)
+			struct lpfc_iocbq *rspiocb)
 {
 	struct lpfc_vport *vport = cmdiocb->vport;
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_dmabuf *inp = (struct lpfc_dmabuf *)cmdiocb->context1;
 	struct lpfc_dmabuf *outp = (struct lpfc_dmabuf *)cmdiocb->context2;
 	struct lpfc_sli_ct_request *CTrsp;
@@ -1523,13 +1501,15 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp = NULL;
 	struct lpfc_nodelist *ns_ndlp = NULL;
 	uint32_t fc4_data_0, fc4_data_1;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 
 	did = ((struct lpfc_sli_ct_request *)inp->virt)->un.gft.PortId;
 	did = be32_to_cpu(did);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 			      "GFT_ID cmpl: status:x%x/x%x did:x%x",
-			      irsp->ulpStatus, irsp->un.ulpWord[4], did);
+			      ulp_status, ulp_word4, did);
 
 	/* Ignore response if link flipped after this request was made */
 	if ((uint32_t) cmdiocb->event_tag != phba->fc_eventTag) {
@@ -1541,7 +1521,7 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* Preserve the nameserver node to release the reference. */
 	ns_ndlp = cmdiocb->context_un.ndlp;
 
-	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
+	if (ulp_status == IOSTAT_SUCCESS) {
 		/* Good status, continue checking */
 		CTrsp = (struct lpfc_sli_ct_request *)outp->virt;
 		fc4_data_0 = be32_to_cpu(CTrsp->un.gft_acc.fc4_types[0]);
@@ -1602,7 +1582,7 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		}
 	} else
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
-				 "3065 GFT_ID failed x%08x\n", irsp->ulpStatus);
+				 "3065 GFT_ID failed x%08x\n", ulp_status);
 
 out:
 	lpfc_ct_free_iocb(phba, cmdiocb);
@@ -1616,12 +1596,13 @@ lpfc_cmpl_ct(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_vport *vport = cmdiocb->vport;
 	struct lpfc_dmabuf *inp;
 	struct lpfc_dmabuf *outp;
-	IOCB_t *irsp;
 	struct lpfc_sli_ct_request *CTrsp;
 	struct lpfc_nodelist *ndlp;
 	int cmdcode, rc;
 	uint8_t retry;
 	uint32_t latt;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 
 	/* First save ndlp, before we overwrite it */
 	ndlp = cmdiocb->context_un.ndlp;
@@ -1631,7 +1612,6 @@ lpfc_cmpl_ct(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	inp = (struct lpfc_dmabuf *) cmdiocb->context1;
 	outp = (struct lpfc_dmabuf *) cmdiocb->context2;
-	irsp = &rspiocb->iocb;
 
 	cmdcode = be16_to_cpu(((struct lpfc_sli_ct_request *) inp->virt)->
 					CommandResponse.bits.CmdRsp);
@@ -1639,28 +1619,28 @@ lpfc_cmpl_ct(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	latt = lpfc_els_chk_latt(vport);
 
-	/* RFT request completes status <ulpStatus> CmdRsp <CmdRsp> */
+	/* RFT request completes status <ulp_status> CmdRsp <CmdRsp> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 			 "0209 CT Request completes, latt %d, "
-			 "ulpStatus x%x CmdRsp x%x, Context x%x, Tag x%x\n",
-			 latt, irsp->ulpStatus,
+			 "ulp_status x%x CmdRsp x%x, Context x%x, Tag x%x\n",
+			 latt, ulp_status,
 			 CTrsp->CommandResponse.bits.CmdRsp,
-			 cmdiocb->iocb.ulpContext, cmdiocb->iocb.ulpIoTag);
+			 get_job_ulpcontext(phba, cmdiocb), cmdiocb->iotag);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 		"CT cmd cmpl:     status:x%x/x%x cmd:x%x",
-		irsp->ulpStatus, irsp->un.ulpWord[4], cmdcode);
+		ulp_status, ulp_word4, cmdcode);
 
-	if (irsp->ulpStatus) {
+	if (ulp_status) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0268 NS cmd x%x Error (x%x x%x)\n",
-				 cmdcode, irsp->ulpStatus, irsp->un.ulpWord[4]);
+				 cmdcode, ulp_status, ulp_word4);
 
-		if ((irsp->ulpStatus == IOSTAT_LOCAL_REJECT) &&
-			(((irsp->un.ulpWord[4] & IOERR_PARAM_MASK) ==
-			  IOERR_SLI_DOWN) ||
-			 ((irsp->un.ulpWord[4] & IOERR_PARAM_MASK) ==
-			  IOERR_SLI_ABORTED)))
+		if (ulp_status == IOSTAT_LOCAL_REJECT &&
+		    (((ulp_word4 & IOERR_PARAM_MASK) ==
+		      IOERR_SLI_DOWN) ||
+		     ((ulp_word4 & IOERR_PARAM_MASK) ==
+		      IOERR_SLI_ABORTED)))
 			goto out;
 
 		retry = cmdiocb->retry;
@@ -1685,10 +1665,10 @@ static void
 lpfc_cmpl_ct_cmd_rft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			struct lpfc_iocbq *rspiocb)
 {
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_vport *vport = cmdiocb->vport;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
+	if (ulp_status == IOSTAT_SUCCESS) {
 		struct lpfc_dmabuf *outp;
 		struct lpfc_sli_ct_request *CTrsp;
 
@@ -1706,10 +1686,10 @@ static void
 lpfc_cmpl_ct_cmd_rnn_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			struct lpfc_iocbq *rspiocb)
 {
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_vport *vport = cmdiocb->vport;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
+	if (ulp_status == IOSTAT_SUCCESS) {
 		struct lpfc_dmabuf *outp;
 		struct lpfc_sli_ct_request *CTrsp;
 
@@ -1727,10 +1707,10 @@ static void
 lpfc_cmpl_ct_cmd_rspn_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 struct lpfc_iocbq *rspiocb)
 {
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_vport *vport = cmdiocb->vport;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
+	if (ulp_status == IOSTAT_SUCCESS) {
 		struct lpfc_dmabuf *outp;
 		struct lpfc_sli_ct_request *CTrsp;
 
@@ -1748,10 +1728,10 @@ static void
 lpfc_cmpl_ct_cmd_rsnn_nn(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 struct lpfc_iocbq *rspiocb)
 {
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_vport *vport = cmdiocb->vport;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
+	if (ulp_status == IOSTAT_SUCCESS) {
 		struct lpfc_dmabuf *outp;
 		struct lpfc_sli_ct_request *CTrsp;
 
@@ -1781,10 +1761,10 @@ static void
 lpfc_cmpl_ct_cmd_rff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			struct lpfc_iocbq *rspiocb)
 {
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_vport *vport = cmdiocb->vport;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
+	if (ulp_status == IOSTAT_SUCCESS) {
 		struct lpfc_dmabuf *outp;
 		struct lpfc_sli_ct_request *CTrsp;
 
@@ -2195,20 +2175,21 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_sli_ct_request *CTrsp = outp->virt;
 	uint16_t fdmi_cmd = CTcmd->CommandResponse.bits.CmdRsp;
 	uint16_t fdmi_rsp = CTrsp->CommandResponse.bits.CmdRsp;
-	IOCB_t *irsp = &rspiocb->iocb;
 	struct lpfc_nodelist *ndlp, *free_ndlp = NULL;
 	uint32_t latt, cmd, err;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
 
 	latt = lpfc_els_chk_latt(vport);
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 		"FDMI cmpl:       status:x%x/x%x latt:%d",
-		irsp->ulpStatus, irsp->un.ulpWord[4], latt);
+		ulp_status, ulp_word4, latt);
 
-	if (latt || irsp->ulpStatus) {
+	if (latt || ulp_status) {
 
 		/* Look for a retryable error */
-		if (irsp->ulpStatus == IOSTAT_LOCAL_REJECT) {
-			switch ((irsp->un.ulpWord[4] & IOERR_PARAM_MASK)) {
+		if (ulp_status == IOSTAT_LOCAL_REJECT) {
+			switch ((ulp_word4 & IOERR_PARAM_MASK)) {
 			case IOERR_SLI_ABORTED:
 			case IOERR_SLI_DOWN:
 				/* Driver aborted this IO.  No retry as error
@@ -2238,9 +2219,9 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "0229 FDMI cmd %04x failed, latt = %d "
-				 "ulpStatus: x%x, rid x%x\n",
-				 be16_to_cpu(fdmi_cmd), latt, irsp->ulpStatus,
-				 irsp->un.ulpWord[4]);
+				 "ulp_status: x%x, rid x%x\n",
+				 be16_to_cpu(fdmi_cmd), latt, ulp_status,
+				 ulp_word4);
 	}
 
 	free_ndlp = cmdiocb->context_un.ndlp;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 89a0f8cea1ff..8c031fc8891d 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1255,20 +1255,15 @@ __lpfc_sli_get_els_sglq(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq)
 	struct lpfc_sglq *start_sglq = NULL;
 	struct lpfc_io_buf *lpfc_cmd;
 	struct lpfc_nodelist *ndlp;
-	struct lpfc_sli_ring *pring = NULL;
 	int found = 0;
+	u8 cmnd;
 
-	if (piocbq->cmd_flag & LPFC_IO_NVME_LS)
-		pring =  phba->sli4_hba.nvmels_wq->pring;
-	else
-		pring = lpfc_phba_elsring(phba);
-
-	lockdep_assert_held(&pring->ring_lock);
+	cmnd = get_job_cmnd(phba, piocbq);
 
 	if (piocbq->cmd_flag &  LPFC_IO_FCP) {
 		lpfc_cmd = (struct lpfc_io_buf *) piocbq->context1;
 		ndlp = lpfc_cmd->rdata->pnode;
-	} else  if ((piocbq->iocb.ulpCommand == CMD_GEN_REQUEST64_CR) &&
+	} else  if ((cmnd == CMD_GEN_REQUEST64_CR) &&
 			!(piocbq->cmd_flag & LPFC_IO_LIBDFC)) {
 		ndlp = piocbq->context_un.ndlp;
 	} else  if (piocbq->cmd_flag & LPFC_IO_LIBDFC) {
@@ -3367,6 +3362,56 @@ lpfc_complete_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	return 0;
 }
 
+static void
+lpfc_sli_prep_unsol_wqe(struct lpfc_hba *phba,
+			struct lpfc_iocbq *saveq)
+{
+	IOCB_t *irsp;
+	union lpfc_wqe128 *wqe;
+	u16 i = 0;
+
+	irsp = &saveq->iocb;
+	wqe = &saveq->wqe;
+
+	/* Fill wcqe with the IOCB status fields */
+	bf_set(lpfc_wcqe_c_status, &saveq->wcqe_cmpl, irsp->ulpStatus);
+	saveq->wcqe_cmpl.word3 = irsp->ulpBdeCount;
+	saveq->wcqe_cmpl.parameter = irsp->un.ulpWord[4];
+	saveq->wcqe_cmpl.total_data_placed = irsp->unsli3.rcvsli3.acc_len;
+
+	/* Source ID */
+	bf_set(els_rsp64_sid, &wqe->xmit_els_rsp, irsp->un.rcvels.parmRo);
+
+	/* rx-id of the response frame */
+	bf_set(wqe_ctxt_tag, &wqe->xmit_els_rsp.wqe_com, irsp->ulpContext);
+
+	/* ox-id of the frame */
+	bf_set(wqe_rcvoxid, &wqe->xmit_els_rsp.wqe_com,
+	       irsp->unsli3.rcvsli3.ox_id);
+
+	/* DID */
+	bf_set(wqe_els_did, &wqe->xmit_els_rsp.wqe_dest,
+	       irsp->un.rcvels.remoteID);
+
+	/* unsol data len */
+	for (i = 0; i < irsp->ulpBdeCount; i++) {
+		struct lpfc_hbq_entry *hbqe = NULL;
+
+		if (phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) {
+			if (i == 0) {
+				hbqe = (struct lpfc_hbq_entry *)
+					&irsp->un.ulpWord[0];
+				saveq->wqe.gen_req.bde.tus.f.bdeSize =
+					hbqe->bde.tus.f.bdeSize;
+			} else if (i == 1) {
+				hbqe = (struct lpfc_hbq_entry *)
+					&irsp->unsli3.sli3Words[4];
+				saveq->unsol_rcv_len = hbqe->bde.tus.f.bdeSize;
+			}
+		}
+	}
+}
+
 /**
  * lpfc_sli_process_unsol_iocb - Unsolicited iocb handler
  * @phba: Pointer to HBA context object.
@@ -3387,11 +3432,13 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 {
 	IOCB_t           * irsp;
 	WORD5            * w5p;
+	dma_addr_t	 paddr;
 	uint32_t           Rctl, Type;
 	struct lpfc_iocbq *iocbq;
 	struct lpfc_dmabuf *dmzbuf;
 
-	irsp = &(saveq->iocb);
+	irsp = &saveq->iocb;
+	saveq->vport = phba->pport;
 
 	if (irsp->ulpCommand == CMD_ASYNC_STATUS) {
 		if (pring->lpfc_sli_rcv_async_status)
@@ -3409,22 +3456,22 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	}
 
 	if ((irsp->ulpCommand == CMD_IOCB_RET_XRI64_CX) &&
-		(phba->sli3_options & LPFC_SLI3_HBQ_ENABLED)) {
+	    (phba->sli3_options & LPFC_SLI3_HBQ_ENABLED)) {
 		if (irsp->ulpBdeCount > 0) {
 			dmzbuf = lpfc_sli_get_buff(phba, pring,
-					irsp->un.ulpWord[3]);
+						   irsp->un.ulpWord[3]);
 			lpfc_in_buf_free(phba, dmzbuf);
 		}
 
 		if (irsp->ulpBdeCount > 1) {
 			dmzbuf = lpfc_sli_get_buff(phba, pring,
-					irsp->unsli3.sli3Words[3]);
+						   irsp->unsli3.sli3Words[3]);
 			lpfc_in_buf_free(phba, dmzbuf);
 		}
 
 		if (irsp->ulpBdeCount > 2) {
 			dmzbuf = lpfc_sli_get_buff(phba, pring,
-				irsp->unsli3.sli3Words[7]);
+						   irsp->unsli3.sli3Words[7]);
 			lpfc_in_buf_free(phba, dmzbuf);
 		}
 
@@ -3457,9 +3504,10 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 					irsp->unsli3.sli3Words[7]);
 		}
 		list_for_each_entry(iocbq, &saveq->list, list) {
-			irsp = &(iocbq->iocb);
+			irsp = &iocbq->iocb;
 			if (irsp->ulpBdeCount != 0) {
-				iocbq->context2 = lpfc_sli_get_buff(phba, pring,
+				iocbq->context2 = lpfc_sli_get_buff(phba,
+							pring,
 							irsp->un.ulpWord[3]);
 				if (!iocbq->context2)
 					lpfc_printf_log(phba,
@@ -3471,7 +3519,8 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 						irsp->un.ulpWord[3]);
 			}
 			if (irsp->ulpBdeCount == 2) {
-				iocbq->context3 = lpfc_sli_get_buff(phba, pring,
+				iocbq->context3 = lpfc_sli_get_buff(phba,
+						pring,
 						irsp->unsli3.sli3Words[7]);
 				if (!iocbq->context3)
 					lpfc_printf_log(phba,
@@ -3484,7 +3533,20 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 						irsp->unsli3.sli3Words[7]);
 			}
 		}
+	} else {
+		paddr = getPaddr(irsp->un.cont64[0].addrHigh,
+				 irsp->un.cont64[0].addrLow);
+		saveq->context2 = lpfc_sli_ringpostbuf_get(phba, pring,
+							     paddr);
+		if (irsp->ulpBdeCount == 2) {
+			paddr = getPaddr(irsp->un.cont64[1].addrHigh,
+					 irsp->un.cont64[1].addrLow);
+			saveq->context3 = lpfc_sli_ringpostbuf_get(phba,
+								   pring,
+								   paddr);
+		}
 	}
+
 	if (irsp->ulpBdeCount != 0 &&
 	    (irsp->ulpCommand == CMD_IOCB_RCV_CONT64_CX ||
 	     irsp->ulpStatus == IOSTAT_INTERMED_RSP)) {
@@ -3502,12 +3564,14 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		if (!found)
 			list_add_tail(&saveq->clist,
 				      &pring->iocb_continue_saveq);
+
 		if (saveq->iocb.ulpStatus != IOSTAT_INTERMED_RSP) {
 			list_del_init(&iocbq->clist);
 			saveq = iocbq;
-			irsp = &(saveq->iocb);
-		} else
+			irsp = &saveq->iocb;
+		} else {
 			return 0;
+		}
 	}
 	if ((irsp->ulpCommand == CMD_RCV_ELS_REQ64_CX) ||
 	    (irsp->ulpCommand == CMD_RCV_ELS_REQ_CX) ||
@@ -3530,6 +3594,19 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		}
 	}
 
+	if ((phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) &&
+	    (irsp->ulpCommand == CMD_IOCB_RCV_ELS64_CX ||
+	    irsp->ulpCommand == CMD_IOCB_RCV_SEQ64_CX)) {
+		if (irsp->unsli3.rcvsli3.vpi == 0xffff)
+			saveq->vport = phba->pport;
+		else
+			saveq->vport = lpfc_find_vport_by_vpid(phba,
+					       irsp->unsli3.rcvsli3.vpi);
+	}
+
+	/* Prepare WQE with Unsol frame */
+	lpfc_sli_prep_unsol_wqe(phba, saveq);
+
 	if (!lpfc_complete_unsol_iocb(phba, pring, saveq, Rctl, Type))
 		lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
 				"0313 Ring %d handler: unexpected Rctl x%x "
@@ -10570,6 +10647,195 @@ lpfc_sli_prep_els_req_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocbq,
 					  elscmd, tmo, expect_rsp);
 }
 
+static void
+__lpfc_sli_prep_gen_req_s3(struct lpfc_iocbq *cmdiocbq, struct lpfc_dmabuf *bmp,
+			   u16 rpi, u32 num_entry, u8 tmo)
+{
+	IOCB_t *cmd;
+
+	cmd = &cmdiocbq->iocb;
+	memset(cmd, 0, sizeof(*cmd));
+
+	cmd->un.genreq64.bdl.addrHigh = putPaddrHigh(bmp->phys);
+	cmd->un.genreq64.bdl.addrLow = putPaddrLow(bmp->phys);
+	cmd->un.genreq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
+	cmd->un.genreq64.bdl.bdeSize = num_entry * sizeof(struct ulp_bde64);
+
+	cmd->un.genreq64.w5.hcsw.Rctl = FC_RCTL_DD_UNSOL_CTL;
+	cmd->un.genreq64.w5.hcsw.Type = FC_TYPE_CT;
+	cmd->un.genreq64.w5.hcsw.Fctl = (SI | LA);
+
+	cmd->ulpContext = rpi;
+	cmd->ulpClass = CLASS3;
+	cmd->ulpCommand = CMD_GEN_REQUEST64_CR;
+	cmd->ulpBdeCount = 1;
+	cmd->ulpLe = 1;
+	cmd->ulpOwner = OWN_CHIP;
+	cmd->ulpTimeout = tmo;
+}
+
+static void
+__lpfc_sli_prep_gen_req_s4(struct lpfc_iocbq *cmdiocbq, struct lpfc_dmabuf *bmp,
+			   u16 rpi, u32 num_entry, u8 tmo)
+{
+	union lpfc_wqe128 *cmdwqe;
+	struct ulp_bde64_le *bde, *bpl;
+	u32 xmit_len = 0, total_len = 0, size, type, i;
+
+	cmdwqe = &cmdiocbq->wqe;
+	memset(cmdwqe, 0, sizeof(*cmdwqe));
+
+	/* Calculate total_len and xmit_len */
+	bpl = (struct ulp_bde64_le *)bmp->virt;
+	for (i = 0; i < num_entry; i++) {
+		size = le32_to_cpu(bpl[i].type_size) & ULP_BDE64_SIZE_MASK;
+		total_len += size;
+	}
+	for (i = 0; i < num_entry; i++) {
+		size = le32_to_cpu(bpl[i].type_size) & ULP_BDE64_SIZE_MASK;
+		type = le32_to_cpu(bpl[i].type_size) & ULP_BDE64_TYPE_MASK;
+		if (type != ULP_BDE64_TYPE_BDE_64)
+			break;
+		xmit_len += size;
+	}
+
+	/* Words 0 - 2 */
+	bde = (struct ulp_bde64_le *)&cmdwqe->generic.bde;
+	bde->addr_low = cpu_to_le32(putPaddrLow(bmp->phys));
+	bde->addr_high = cpu_to_le32(putPaddrHigh(bmp->phys));
+	bde->type_size = cpu_to_le32(xmit_len);
+	bde->type_size |= cpu_to_le32(ULP_BDE64_TYPE_BLP_64);
+
+	/* Word 3 */
+	cmdwqe->gen_req.request_payload_len = xmit_len;
+
+	/* Word 5 */
+	bf_set(wqe_type, &cmdwqe->gen_req.wge_ctl, FC_TYPE_CT);
+	bf_set(wqe_rctl, &cmdwqe->gen_req.wge_ctl, FC_RCTL_DD_UNSOL_CTL);
+	bf_set(wqe_si, &cmdwqe->gen_req.wge_ctl, 1);
+	bf_set(wqe_la, &cmdwqe->gen_req.wge_ctl, 1);
+
+	/* Word 6 */
+	bf_set(wqe_ctxt_tag, &cmdwqe->gen_req.wqe_com, rpi);
+
+	/* Word 7 */
+	bf_set(wqe_tmo, &cmdwqe->gen_req.wqe_com, tmo);
+	bf_set(wqe_class, &cmdwqe->gen_req.wqe_com, CLASS3);
+	bf_set(wqe_cmnd, &cmdwqe->gen_req.wqe_com, CMD_GEN_REQUEST64_CR);
+	bf_set(wqe_ct, &cmdwqe->gen_req.wqe_com, SLI4_CT_RPI);
+
+	/* Word 12 */
+	cmdwqe->gen_req.max_response_payload_len = total_len - xmit_len;
+}
+
+void
+lpfc_sli_prep_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocbq,
+		      struct lpfc_dmabuf *bmp, u16 rpi, u32 num_entry, u8 tmo)
+{
+	phba->__lpfc_sli_prep_gen_req(cmdiocbq, bmp, rpi, num_entry, tmo);
+}
+
+static void
+__lpfc_sli_prep_xmit_seq64_s3(struct lpfc_iocbq *cmdiocbq,
+			      struct lpfc_dmabuf *bmp, u16 rpi, u16 ox_id,
+			      u32 num_entry, u8 rctl, u8 last_seq, u8 cr_cx_cmd)
+{
+	IOCB_t *icmd;
+
+	icmd = &cmdiocbq->iocb;
+	memset(icmd, 0, sizeof(*icmd));
+
+	icmd->un.xseq64.bdl.addrHigh = putPaddrHigh(bmp->phys);
+	icmd->un.xseq64.bdl.addrLow = putPaddrLow(bmp->phys);
+	icmd->un.xseq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
+	icmd->un.xseq64.bdl.bdeSize = (num_entry * sizeof(struct ulp_bde64));
+	icmd->un.xseq64.w5.hcsw.Fctl = LA;
+	if (last_seq)
+		icmd->un.xseq64.w5.hcsw.Fctl |= LS;
+	icmd->un.xseq64.w5.hcsw.Dfctl = 0;
+	icmd->un.xseq64.w5.hcsw.Rctl = rctl;
+	icmd->un.xseq64.w5.hcsw.Type = FC_TYPE_CT;
+
+	icmd->ulpBdeCount = 1;
+	icmd->ulpLe = 1;
+	icmd->ulpClass = CLASS3;
+
+	switch (cr_cx_cmd) {
+	case CMD_XMIT_SEQUENCE64_CR:
+		icmd->ulpContext = rpi;
+		icmd->ulpCommand = CMD_XMIT_SEQUENCE64_CR;
+		break;
+	case CMD_XMIT_SEQUENCE64_CX:
+		icmd->ulpContext = ox_id;
+		icmd->ulpCommand = CMD_XMIT_SEQUENCE64_CX;
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+__lpfc_sli_prep_xmit_seq64_s4(struct lpfc_iocbq *cmdiocbq,
+			      struct lpfc_dmabuf *bmp, u16 rpi, u16 ox_id,
+			      u32 full_size, u8 rctl, u8 last_seq, u8 cr_cx_cmd)
+{
+	union lpfc_wqe128 *wqe;
+	struct ulp_bde64 *bpl;
+	struct ulp_bde64_le *bde;
+
+	wqe = &cmdiocbq->wqe;
+	memset(wqe, 0, sizeof(*wqe));
+
+	/* Words 0 - 2 */
+	bpl = (struct ulp_bde64 *)bmp->virt;
+	if (cmdiocbq->cmd_flag & (LPFC_IO_LIBDFC | LPFC_IO_LOOPBACK)) {
+		wqe->xmit_sequence.bde.addrHigh = bpl->addrHigh;
+		wqe->xmit_sequence.bde.addrLow = bpl->addrLow;
+		wqe->xmit_sequence.bde.tus.w = bpl->tus.w;
+	} else {
+		bde = (struct ulp_bde64_le *)&wqe->xmit_sequence.bde;
+		bde->addr_low = cpu_to_le32(putPaddrLow(bmp->phys));
+		bde->addr_high = cpu_to_le32(putPaddrHigh(bmp->phys));
+		bde->type_size = cpu_to_le32(bpl->tus.f.bdeSize);
+		bde->type_size |= cpu_to_le32(ULP_BDE64_TYPE_BDE_64);
+	}
+
+	/* Word 5 */
+	bf_set(wqe_ls, &wqe->xmit_sequence.wge_ctl, last_seq);
+	bf_set(wqe_la, &wqe->xmit_sequence.wge_ctl, 1);
+	bf_set(wqe_dfctl, &wqe->xmit_sequence.wge_ctl, 0);
+	bf_set(wqe_rctl, &wqe->xmit_sequence.wge_ctl, rctl);
+	bf_set(wqe_type, &wqe->xmit_sequence.wge_ctl, FC_TYPE_CT);
+
+	/* Word 6 */
+	bf_set(wqe_ctxt_tag, &wqe->xmit_sequence.wqe_com, rpi);
+
+	bf_set(wqe_cmnd, &wqe->xmit_sequence.wqe_com,
+	       CMD_XMIT_SEQUENCE64_WQE);
+
+	/* Word 7 */
+	bf_set(wqe_class, &wqe->xmit_sequence.wqe_com, CLASS3);
+
+	/* Word 9 */
+	bf_set(wqe_rcvoxid, &wqe->xmit_sequence.wqe_com, ox_id);
+
+	/* Word 12 */
+	if (cmdiocbq->cmd_flag & (LPFC_IO_LIBDFC | LPFC_IO_LOOPBACK))
+		wqe->xmit_sequence.xmit_len = full_size;
+	else
+		wqe->xmit_sequence.xmit_len =
+			wqe->xmit_sequence.bde.tus.f.bdeSize;
+}
+
+void
+lpfc_sli_prep_xmit_seq64(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocbq,
+			 struct lpfc_dmabuf *bmp, u16 rpi, u16 ox_id,
+			 u32 num_entry, u8 rctl, u8 last_seq, u8 cr_cx_cmd)
+{
+	phba->__lpfc_sli_prep_xmit_seq64(cmdiocbq, bmp, rpi, ox_id, num_entry,
+					 rctl, last_seq, cr_cx_cmd);
+}
+
 /**
  * lpfc_sli_api_table_setup - Set up sli api function jump table
  * @phba: The hba struct for which this call is being executed.
@@ -10589,12 +10855,16 @@ lpfc_sli_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->__lpfc_sli_release_iocbq = __lpfc_sli_release_iocbq_s3;
 		phba->__lpfc_sli_issue_fcp_io = __lpfc_sli_issue_fcp_io_s3;
 		phba->__lpfc_sli_prep_els_req_rsp = __lpfc_sli_prep_els_req_rsp_s3;
+		phba->__lpfc_sli_prep_gen_req = __lpfc_sli_prep_gen_req_s3;
+		phba->__lpfc_sli_prep_xmit_seq64 = __lpfc_sli_prep_xmit_seq64_s3;
 		break;
 	case LPFC_PCI_DEV_OC:
 		phba->__lpfc_sli_issue_iocb = __lpfc_sli_issue_iocb_s4;
 		phba->__lpfc_sli_release_iocbq = __lpfc_sli_release_iocbq_s4;
 		phba->__lpfc_sli_issue_fcp_io = __lpfc_sli_issue_fcp_io_s4;
 		phba->__lpfc_sli_prep_els_req_rsp = __lpfc_sli_prep_els_req_rsp_s4;
+		phba->__lpfc_sli_prep_gen_req = __lpfc_sli_prep_gen_req_s4;
+		phba->__lpfc_sli_prep_xmit_seq64 = __lpfc_sli_prep_xmit_seq64_s4;
 		break;
 	default:
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
@@ -18469,7 +18739,6 @@ lpfc_prep_seq(struct lpfc_vport *vport, struct hbq_dmabuf *seq_dmabuf)
 	struct fc_frame_header *fc_hdr;
 	uint32_t sid;
 	uint32_t len, tot_len;
-	struct ulp_bde64 *pbde;
 
 	fc_hdr = (struct fc_frame_header *)seq_dmabuf->hbuf.virt;
 	/* remove from receive buffer list */
@@ -18482,40 +18751,40 @@ lpfc_prep_seq(struct lpfc_vport *vport, struct hbq_dmabuf *seq_dmabuf)
 	first_iocbq = lpfc_sli_get_iocbq(vport->phba);
 	if (first_iocbq) {
 		/* Initialize the first IOCB. */
-		first_iocbq->iocb.unsli3.rcvsli3.acc_len = 0;
-		first_iocbq->iocb.ulpStatus = IOSTAT_SUCCESS;
+		first_iocbq->wcqe_cmpl.total_data_placed = 0;
+		bf_set(lpfc_wcqe_c_status, &first_iocbq->wcqe_cmpl,
+		       IOSTAT_SUCCESS);
 		first_iocbq->vport = vport;
 
 		/* Check FC Header to see what TYPE of frame we are rcv'ing */
 		if (sli4_type_from_fc_hdr(fc_hdr) == FC_TYPE_ELS) {
-			first_iocbq->iocb.ulpCommand = CMD_IOCB_RCV_ELS64_CX;
-			first_iocbq->iocb.un.rcvels.parmRo =
-				sli4_did_from_fc_hdr(fc_hdr);
-			first_iocbq->iocb.ulpPU = PARM_NPIV_DID;
-		} else
-			first_iocbq->iocb.ulpCommand = CMD_IOCB_RCV_SEQ64_CX;
-		first_iocbq->iocb.ulpContext = NO_XRI;
-		first_iocbq->iocb.unsli3.rcvsli3.ox_id =
-			be16_to_cpu(fc_hdr->fh_ox_id);
-		/* iocbq is prepped for internal consumption.  Physical vpi. */
-		first_iocbq->iocb.unsli3.rcvsli3.vpi =
-			vport->phba->vpi_ids[vport->vpi];
-		/* put the first buffer into the first IOCBq */
+			bf_set(els_rsp64_sid, &first_iocbq->wqe.xmit_els_rsp,
+			       sli4_did_from_fc_hdr(fc_hdr));
+		}
+
+		bf_set(wqe_ctxt_tag, &first_iocbq->wqe.xmit_els_rsp.wqe_com,
+		       NO_XRI);
+		bf_set(wqe_rcvoxid, &first_iocbq->wqe.xmit_els_rsp.wqe_com,
+		       be16_to_cpu(fc_hdr->fh_ox_id));
+
+		/* put the first buffer into the first iocb */
 		tot_len = bf_get(lpfc_rcqe_length,
-				       &seq_dmabuf->cq_event.cqe.rcqe_cmpl);
+				 &seq_dmabuf->cq_event.cqe.rcqe_cmpl);
 
 		first_iocbq->context2 = &seq_dmabuf->dbuf;
 		first_iocbq->context3 = NULL;
-		first_iocbq->iocb.ulpBdeCount = 1;
+		/* Keep track of the BDE count */
+		first_iocbq->wcqe_cmpl.word3 = 1;
+
 		if (tot_len > LPFC_DATA_BUF_SIZE)
-			first_iocbq->iocb.un.cont64[0].tus.f.bdeSize =
-							LPFC_DATA_BUF_SIZE;
+			first_iocbq->wqe.gen_req.bde.tus.f.bdeSize =
+				LPFC_DATA_BUF_SIZE;
 		else
-			first_iocbq->iocb.un.cont64[0].tus.f.bdeSize = tot_len;
+			first_iocbq->wqe.gen_req.bde.tus.f.bdeSize = tot_len;
 
-		first_iocbq->iocb.un.rcvels.remoteID = sid;
-
-		first_iocbq->iocb.unsli3.rcvsli3.acc_len = tot_len;
+		first_iocbq->wcqe_cmpl.total_data_placed = tot_len;
+		bf_set(wqe_els_did, &first_iocbq->wqe.xmit_els_rsp.wqe_dest,
+		       sid);
 	}
 	iocbq = first_iocbq;
 	/*
@@ -18529,28 +18798,23 @@ lpfc_prep_seq(struct lpfc_vport *vport, struct hbq_dmabuf *seq_dmabuf)
 		}
 		if (!iocbq->context3) {
 			iocbq->context3 = d_buf;
-			iocbq->iocb.ulpBdeCount++;
+			iocbq->wcqe_cmpl.word3++;
 			/* We need to get the size out of the right CQE */
 			hbq_buf = container_of(d_buf, struct hbq_dmabuf, dbuf);
 			len = bf_get(lpfc_rcqe_length,
 				       &hbq_buf->cq_event.cqe.rcqe_cmpl);
-			pbde = (struct ulp_bde64 *)
-					&iocbq->iocb.unsli3.sli3Words[4];
-			if (len > LPFC_DATA_BUF_SIZE)
-				pbde->tus.f.bdeSize = LPFC_DATA_BUF_SIZE;
-			else
-				pbde->tus.f.bdeSize = len;
-
-			iocbq->iocb.unsli3.rcvsli3.acc_len += len;
+			iocbq->unsol_rcv_len = len;
+			iocbq->wcqe_cmpl.total_data_placed += len;
 			tot_len += len;
 		} else {
 			iocbq = lpfc_sli_get_iocbq(vport->phba);
 			if (!iocbq) {
 				if (first_iocbq) {
-					first_iocbq->iocb.ulpStatus =
-							IOSTAT_FCP_RSP_ERROR;
-					first_iocbq->iocb.un.ulpWord[4] =
-							IOERR_NO_RESOURCES;
+					bf_set(lpfc_wcqe_c_status,
+					       &first_iocbq->wcqe_cmpl,
+					       IOSTAT_SUCCESS);
+					first_iocbq->wcqe_cmpl.parameter =
+						IOERR_NO_RESOURCES;
 				}
 				lpfc_in_buf_free(vport->phba, d_buf);
 				continue;
@@ -18561,17 +18825,19 @@ lpfc_prep_seq(struct lpfc_vport *vport, struct hbq_dmabuf *seq_dmabuf)
 				       &hbq_buf->cq_event.cqe.rcqe_cmpl);
 			iocbq->context2 = d_buf;
 			iocbq->context3 = NULL;
-			iocbq->iocb.ulpBdeCount = 1;
+			iocbq->wcqe_cmpl.word3 = 1;
+
 			if (len > LPFC_DATA_BUF_SIZE)
-				iocbq->iocb.un.cont64[0].tus.f.bdeSize =
-							LPFC_DATA_BUF_SIZE;
+				iocbq->wqe.xmit_els_rsp.bde.tus.f.bdeSize =
+					LPFC_DATA_BUF_SIZE;
 			else
-				iocbq->iocb.un.cont64[0].tus.f.bdeSize = len;
+				iocbq->wqe.xmit_els_rsp.bde.tus.f.bdeSize =
+					len;
 
 			tot_len += len;
-			iocbq->iocb.unsli3.rcvsli3.acc_len = tot_len;
-
-			iocbq->iocb.un.rcvels.remoteID = sid;
+			iocbq->wcqe_cmpl.total_data_placed = tot_len;
+			bf_set(wqe_els_did, &iocbq->wqe.xmit_els_rsp.wqe_dest,
+			       sid);
 			list_add_tail(&iocbq->list, &first_iocbq->list);
 		}
 	}
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 06682ad8bbe1..9f5b6574e638 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -75,6 +75,7 @@ struct lpfc_iocbq {
 	IOCB_t iocb;		/* SLI-3 */
 	struct lpfc_wcqe_complete wcqe_cmpl;	/* WQE cmpl */
 
+	u32 unsol_rcv_len;	/* Receive len in usol path */
 	uint8_t num_bdes;
 	uint8_t abort_bls;	/* ABTS by initiator or responder */
 
-- 
2.26.2

