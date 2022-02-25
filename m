Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92CB4C3BAD
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Feb 2022 03:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiBYCYm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Feb 2022 21:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiBYCYD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Feb 2022 21:24:03 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A91ED4D3
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:30 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g1so3496615pfv.1
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6UpdiXywUPLfTWIHaPfxkp0usNwggWyK8+W5l9PYa4=;
        b=exb1Bst/yZzZkfH3AgmRVrx+MSwuBWLG9gkdBmkZNrmveh7oYXy034vTGJvAut7QIV
         X7QkL47yAEYQnTKrhAxC0U2BmLmlorW3rQnL8uHfXZ4BH0W67EmeSvhUkXRA1L0NAZK0
         rnyvu3fL2G1SjzvFi+yZqkqs8jAPC24JAlFtWAkrJ1WwKO2ggqSYdpr752+HCMWyZvp3
         LGajETaqP0PDUmpmIBTVrFtcmQRteaCFPin4JoP835irQ2dT9IQPqmeTX/m6svhBs5ha
         cojCx8g7gjd5JsiHOIPD6FCa067A/Dqvhof8i9LyUbVh20w+zePWUjJrQ7+kvvMA+8r3
         RQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6UpdiXywUPLfTWIHaPfxkp0usNwggWyK8+W5l9PYa4=;
        b=cobMp1MlfyZdHwABIfVtd+N9W8UL2SiBbWVUx+fzWq5+5va0QuDvu48lCXVwQZ/MgI
         Q67rWmujjxFHT8e7IG6IPRs9gBZU3gEdL9p2vEpTE5ZOjVv+TZdN/xv4AN/m3bb5OfdU
         hbTRRv0a3WZ+HWGhr1o6nCkLIddxc5Fjqxfd/eZAUIJvQZaHM2g11hj/sngX44IQjt3B
         CkoiYcq1SxSODeTHo1nThyoQrCMBKCqWiXb6cGygsZqi6gKDQQyDv5HXYWLVmBNJT3qj
         u/HAI39BrOqpFGw1z38kSznWe3av4C3a2SlA0cx9v2WF/SGqv3X3uGDesgtbiSaLqSas
         V+wA==
X-Gm-Message-State: AOAM532S18Fpe3/NrzOqjWui2hxytrlZDexvfSI/8QwnUoZpFPAvUwkr
        T+jbQF3uZtVQzG903dX7KIVhI3n6FVg=
X-Google-Smtp-Source: ABdhPJwUxU0U+8ZJLpsEiWNbX3o0oE9PhVI5t8EjrRmPZLs0rl6SlpMEZacVM9SAuGylIxMuu5f5YA==
X-Received: by 2002:a63:1554:0:b0:363:794c:9e31 with SMTP id 20-20020a631554000000b00363794c9e31mr4423525pgv.66.1645755809765;
        Thu, 24 Feb 2022 18:23:29 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f3b355dcb1sm845596pfh.58.2022.02.24.18.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:23:29 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 14/17] lpfc: SLI path split: refactor Abort paths
Date:   Thu, 24 Feb 2022 18:23:05 -0800
Message-Id: <20220225022308.16486-15-jsmart2021@gmail.com>
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

This patch refactors the Abort paths to use SLI-4 as the primary
interface.

Changes include:
- introduced generic lpfc_sli_prep_abort_xri jump table routine
- consolidated lpfc_sli4_issue_abort_iotag and lpfc_sli_issue_abort_iotag
  into a single generic lpfc_sli_issue_abort_iotag routine
- consolidated lpfc_sli4_abort_fcp_cmpl and lpfc_sli_abort_fcp_cmpl into a
  single generic lpfc_sli_abort_fcp_cmpl routine
- remove unused routine lpfc_get_iocb_from_iocbq
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
 drivers/scsi/lpfc/lpfc.h      |  14 +-
 drivers/scsi/lpfc/lpfc_crtn.h |   3 +
 drivers/scsi/lpfc/lpfc_nvme.c |   5 +-
 drivers/scsi/lpfc/lpfc_scsi.c |  12 +-
 drivers/scsi/lpfc/lpfc_sli.c  | 382 +++++++++++++++++++---------------
 drivers/scsi/lpfc/lpfc_sli.h  |   4 +-
 6 files changed, 236 insertions(+), 184 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 66e492ec0c2c..311b8472d8c6 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -932,8 +932,6 @@ struct lpfc_hba {
 	void (*__lpfc_sli_release_iocbq)(struct lpfc_hba *,
 			 struct lpfc_iocbq *);
 	int (*lpfc_hba_down_post)(struct lpfc_hba *phba);
-	IOCB_t * (*lpfc_get_iocb_from_iocbq)
-		(struct lpfc_iocbq *);
 	void (*lpfc_scsi_cmd_iocb_cmpl)
 		(struct lpfc_hba *, struct lpfc_iocbq *, struct lpfc_iocbq *);
 
@@ -980,6 +978,9 @@ struct lpfc_hba {
 					   struct lpfc_dmabuf *bmp, u16 rpi,
 					   u16 ox_id, u32 num_entry, u8 rctl,
 					   u8 last_seq, u8 cr_cx_cmd);
+	void (*__lpfc_sli_prep_abort_xri)(struct lpfc_iocbq *cmdiocbq,
+					  u16 ulp_context, u16 iotag,
+					  u8 ulp_class, u16 cqid, bool ia);
 
 	/* expedite pool */
 	struct lpfc_epd_pool epd_pool;
@@ -1873,6 +1874,15 @@ u32 get_job_data_placed(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 		return iocbq->iocb.un.genreq64.bdl.bdeSize;
 }
 
+static inline
+u32 get_job_abtsiotag(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
+{
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		return iocbq->wqe.abort_cmd.wqe_com.abort_tag;
+	else
+		return iocbq->iocb.un.acxri.abortIoTag;
+}
+
 static inline
 u32 get_job_els_rsp64_did(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 {
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 62c37df83f6c..131b7a44f8c7 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -366,6 +366,9 @@ void lpfc_sli_prep_xmit_seq64(struct lpfc_hba *phba,
 			      struct lpfc_dmabuf *bmp, u16 rpi, u16 ox_id,
 			      u32 num_entry, u8 rctl, u8 last_seq,
 			      u8 cr_cx_cmd);
+void lpfc_sli_prep_abort_xri(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocbq,
+			     u16 ulp_context, u16 iotag, u8 ulp_class, u16 cqid,
+			     bool ia);
 struct lpfc_sglq *__lpfc_clear_active_sglq(struct lpfc_hba *phba, uint16_t xri);
 struct lpfc_sglq *__lpfc_sli_get_nvmet_sglq(struct lpfc_hba *phba,
 					    struct lpfc_iocbq *piocbq);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 3a1231d48261..559c5718b495 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1746,9 +1746,8 @@ lpfc_nvme_abort_fcreq_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			"6145 ABORT_XRI_CN completing on rpi x%x "
 			"original iotag x%x, abort cmd iotag x%x "
 			"req_tag x%x, status x%x, hwstatus x%x\n",
-			cmdiocb->iocb.un.acxri.abortContextTag,
-			cmdiocb->iocb.un.acxri.abortIoTag,
-			cmdiocb->iotag,
+			bf_get(wqe_ctxt_tag, &cmdiocb->wqe.generic.wqe_com),
+			get_job_abtsiotag(phba, cmdiocb), cmdiocb->iotag,
 			bf_get(lpfc_wcqe_c_request_tag, abts_cmpl),
 			bf_get(lpfc_wcqe_c_status, abts_cmpl),
 			bf_get(lpfc_wcqe_c_hw_status, abts_cmpl));
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 52de61f2ac92..c0999256cb19 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5928,15 +5928,13 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 	}
 
 	lpfc_cmd->waitq = &waitq;
-	if (phba->sli_rev == LPFC_SLI_REV4) {
+	if (phba->sli_rev == LPFC_SLI_REV4)
 		spin_unlock(&pring_s4->ring_lock);
-		ret_val = lpfc_sli4_issue_abort_iotag(phba, iocb,
-						      lpfc_sli4_abort_fcp_cmpl);
-	} else {
+	else
 		pring = &phba->sli.sli3_ring[LPFC_FCP_RING];
-		ret_val = lpfc_sli_issue_abort_iotag(phba, pring, iocb,
-						     lpfc_sli_abort_fcp_cmpl);
-	}
+
+	ret_val = lpfc_sli_issue_abort_iotag(phba, pring, iocb,
+					     lpfc_sli_abort_fcp_cmpl);
 
 	/* Make sure HBA is alive */
 	lpfc_issue_hb_tmo(phba);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 53926dc68cdf..23dc2cec6bf5 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -98,12 +98,6 @@ union lpfc_wqe128 lpfc_iread_cmd_template;
 union lpfc_wqe128 lpfc_iwrite_cmd_template;
 union lpfc_wqe128 lpfc_icmnd_cmd_template;
 
-static IOCB_t *
-lpfc_get_iocb_from_iocbq(struct lpfc_iocbq *iocbq)
-{
-	return &iocbq->iocb;
-}
-
 /* Setup WQE templates for IOs */
 void lpfc_wqe_cmd_template(void)
 {
@@ -1727,20 +1721,18 @@ static int
 lpfc_sli_ringtxcmpl_put(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			struct lpfc_iocbq *piocb)
 {
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		lockdep_assert_held(&pring->ring_lock);
-	else
-		lockdep_assert_held(&phba->hbalock);
+	u32 ulp_command = 0;
 
 	BUG_ON(!piocb);
+	ulp_command = get_job_cmnd(phba, piocb);
 
 	list_add_tail(&piocb->list, &pring->txcmplq);
 	piocb->cmd_flag |= LPFC_IO_ON_TXCMPLQ;
 	pring->txcmplq_cnt++;
-
 	if ((unlikely(pring->ringno == LPFC_ELS_RING)) &&
-	   (piocb->iocb.ulpCommand != CMD_ABORT_XRI_CN) &&
-	   (piocb->iocb.ulpCommand != CMD_CLOSE_XRI_CN)) {
+	   (ulp_command != CMD_ABORT_XRI_WQE) &&
+	   (ulp_command != CMD_ABORT_XRI_CN) &&
+	   (ulp_command != CMD_CLOSE_XRI_CN)) {
 		BUG_ON(!piocb->vport);
 		if (!(piocb->vport->load_flag & FC_UNLOADING))
 			mod_timer(&piocb->vport->els_tmofunc,
@@ -10836,6 +10828,77 @@ lpfc_sli_prep_xmit_seq64(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocbq,
 					 rctl, last_seq, cr_cx_cmd);
 }
 
+static void
+__lpfc_sli_prep_abort_xri_s3(struct lpfc_iocbq *cmdiocbq, u16 ulp_context,
+			     u16 iotag, u8 ulp_class, u16 cqid, bool ia)
+{
+	IOCB_t *icmd = NULL;
+
+	icmd = &cmdiocbq->iocb;
+	memset(icmd, 0, sizeof(*icmd));
+
+	/* Word 5 */
+	icmd->un.acxri.abortContextTag = ulp_context;
+	icmd->un.acxri.abortIoTag = iotag;
+
+	if (ia) {
+		/* Word 7 */
+		icmd->ulpCommand = CMD_CLOSE_XRI_CN;
+	} else {
+		/* Word 3 */
+		icmd->un.acxri.abortType = ABORT_TYPE_ABTS;
+
+		/* Word 7 */
+		icmd->ulpClass = ulp_class;
+		icmd->ulpCommand = CMD_ABORT_XRI_CN;
+	}
+
+	/* Word 7 */
+	icmd->ulpLe = 1;
+}
+
+static void
+__lpfc_sli_prep_abort_xri_s4(struct lpfc_iocbq *cmdiocbq, u16 ulp_context,
+			     u16 iotag, u8 ulp_class, u16 cqid, bool ia)
+{
+	union lpfc_wqe128 *wqe;
+
+	wqe = &cmdiocbq->wqe;
+	memset(wqe, 0, sizeof(*wqe));
+
+	/* Word 3 */
+	bf_set(abort_cmd_criteria, &wqe->abort_cmd, T_XRI_TAG);
+	if (ia)
+		bf_set(abort_cmd_ia, &wqe->abort_cmd, 1);
+	else
+		bf_set(abort_cmd_ia, &wqe->abort_cmd, 0);
+
+	/* Word 7 */
+	bf_set(wqe_cmnd, &wqe->abort_cmd.wqe_com, CMD_ABORT_XRI_WQE);
+
+	/* Word 8 */
+	wqe->abort_cmd.wqe_com.abort_tag = ulp_context;
+
+	/* Word 9 */
+	bf_set(wqe_reqtag, &wqe->abort_cmd.wqe_com, iotag);
+
+	/* Word 10 */
+	bf_set(wqe_qosd, &wqe->abort_cmd.wqe_com, 1);
+
+	/* Word 11 */
+	bf_set(wqe_cqid, &wqe->abort_cmd.wqe_com, cqid);
+	bf_set(wqe_cmd_type, &wqe->abort_cmd.wqe_com, OTHER_COMMAND);
+}
+
+void
+lpfc_sli_prep_abort_xri(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocbq,
+			u16 ulp_context, u16 iotag, u8 ulp_class, u16 cqid,
+			bool ia)
+{
+	phba->__lpfc_sli_prep_abort_xri(cmdiocbq, ulp_context, iotag, ulp_class,
+					cqid, ia);
+}
+
 /**
  * lpfc_sli_api_table_setup - Set up sli api function jump table
  * @phba: The hba struct for which this call is being executed.
@@ -10857,6 +10920,7 @@ lpfc_sli_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->__lpfc_sli_prep_els_req_rsp = __lpfc_sli_prep_els_req_rsp_s3;
 		phba->__lpfc_sli_prep_gen_req = __lpfc_sli_prep_gen_req_s3;
 		phba->__lpfc_sli_prep_xmit_seq64 = __lpfc_sli_prep_xmit_seq64_s3;
+		phba->__lpfc_sli_prep_abort_xri = __lpfc_sli_prep_abort_xri_s3;
 		break;
 	case LPFC_PCI_DEV_OC:
 		phba->__lpfc_sli_issue_iocb = __lpfc_sli_issue_iocb_s4;
@@ -10865,6 +10929,7 @@ lpfc_sli_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->__lpfc_sli_prep_els_req_rsp = __lpfc_sli_prep_els_req_rsp_s4;
 		phba->__lpfc_sli_prep_gen_req = __lpfc_sli_prep_gen_req_s4;
 		phba->__lpfc_sli_prep_xmit_seq64 = __lpfc_sli_prep_xmit_seq64_s4;
+		phba->__lpfc_sli_prep_abort_xri = __lpfc_sli_prep_abort_xri_s4;
 		break;
 	default:
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
@@ -10872,7 +10937,6 @@ lpfc_sli_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 				dev_grp);
 		return -ENODEV;
 	}
-	phba->lpfc_get_iocb_from_iocbq = lpfc_get_iocb_from_iocbq;
 	return 0;
 }
 
@@ -11072,8 +11136,8 @@ lpfc_sli_abts_err_handler(struct lpfc_hba *phba,
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 			"3095 Event Context not found, no "
 			"action on vpi %d rpi %d status 0x%x, reason 0x%x\n",
-			iocbq->iocb.ulpContext, iocbq->iocb.ulpStatus,
-			vpi, rpi);
+			vpi, rpi, iocbq->iocb.ulpStatus,
+			iocbq->iocb.ulpContext);
 }
 
 /* lpfc_sli4_abts_err_handler - handle a failed ABTS request from an SLI4 port.
@@ -11921,47 +11985,33 @@ static void
 lpfc_sli_abort_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			struct lpfc_iocbq *rspiocb)
 {
-	IOCB_t *irsp = &rspiocb->iocb;
-	uint16_t abort_iotag, abort_context;
-	struct lpfc_iocbq *abort_iocb = NULL;
-
-	if (irsp->ulpStatus) {
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
+	u32 ulp_word4 = get_job_word4(phba, rspiocb);
+	u8 cmnd = get_job_cmnd(phba, cmdiocb);
 
+	if (ulp_status) {
 		/*
 		 * Assume that the port already completed and returned, or
 		 * will return the iocb. Just Log the message.
 		 */
-		abort_context = cmdiocb->iocb.un.acxri.abortContextTag;
-		abort_iotag = cmdiocb->iocb.un.acxri.abortIoTag;
-
-		spin_lock_irq(&phba->hbalock);
 		if (phba->sli_rev < LPFC_SLI_REV4) {
-			if (irsp->ulpCommand == CMD_ABORT_XRI_CX &&
-			    irsp->ulpStatus == IOSTAT_LOCAL_REJECT &&
-			    irsp->un.ulpWord[4] == IOERR_ABORT_REQUESTED) {
-				spin_unlock_irq(&phba->hbalock);
+			if (cmnd == CMD_ABORT_XRI_CX &&
+			    ulp_status == IOSTAT_LOCAL_REJECT &&
+			    ulp_word4 == IOERR_ABORT_REQUESTED) {
 				goto release_iocb;
 			}
-			if (abort_iotag != 0 &&
-				abort_iotag <= phba->sli.last_iotag)
-				abort_iocb =
-					phba->sli.iocbq_lookup[abort_iotag];
-		} else
-			/* For sli4 the abort_tag is the XRI,
-			 * so the abort routine puts the iotag  of the iocb
-			 * being aborted in the context field of the abort
-			 * IOCB.
-			 */
-			abort_iocb = phba->sli.iocbq_lookup[abort_context];
+		}
 
 		lpfc_printf_log(phba, KERN_WARNING, LOG_ELS | LOG_SLI,
 				"0327 Cannot abort els iocb x%px "
-				"with tag %x context %x, abort status %x, "
-				"abort code %x\n",
-				abort_iocb, abort_iotag, abort_context,
-				irsp->ulpStatus, irsp->un.ulpWord[4]);
+				"with io cmd xri %x abort tag : x%x, "
+				"abort status %x abort code %x\n",
+				cmdiocb, get_job_abtsiotag(phba, cmdiocb),
+				(phba->sli_rev == LPFC_SLI_REV4) ?
+				get_wqe_reqtag(cmdiocb) :
+				cmdiocb->iocb.un.acxri.abortContextTag,
+				ulp_status, ulp_word4);
 
-		spin_unlock_irq(&phba->hbalock);
 	}
 release_iocb:
 	lpfc_sli_release_iocbq(phba, cmdiocb);
@@ -12040,20 +12090,21 @@ lpfc_sli_issue_abort_iotag(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 {
 	struct lpfc_vport *vport = cmdiocb->vport;
 	struct lpfc_iocbq *abtsiocbp;
-	IOCB_t *icmd = NULL;
-	IOCB_t *iabt = NULL;
 	int retval = IOCB_ERROR;
 	unsigned long iflags;
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp = NULL;
+	u32 ulp_command = get_job_cmnd(phba, cmdiocb);
+	u16 ulp_context, iotag;
+	bool ia;
 
 	/*
 	 * There are certain command types we don't want to abort.  And we
 	 * don't want to abort commands that are already in the process of
 	 * being aborted.
 	 */
-	icmd = &cmdiocb->iocb;
-	if (icmd->ulpCommand == CMD_ABORT_XRI_CN ||
-	    icmd->ulpCommand == CMD_CLOSE_XRI_CN ||
+	if (ulp_command == CMD_ABORT_XRI_WQE ||
+	    ulp_command == CMD_ABORT_XRI_CN ||
+	    ulp_command == CMD_CLOSE_XRI_CN ||
 	    cmdiocb->cmd_flag & LPFC_DRIVER_ABORTED)
 		return IOCB_ABORTING;
 
@@ -12088,37 +12139,40 @@ lpfc_sli_issue_abort_iotag(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	 */
 	cmdiocb->cmd_flag |= LPFC_DRIVER_ABORTED;
 
-	iabt = &abtsiocbp->iocb;
-	iabt->un.acxri.abortType = ABORT_TYPE_ABTS;
-	iabt->un.acxri.abortContextTag = icmd->ulpContext;
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		iabt->un.acxri.abortIoTag = cmdiocb->sli4_xritag;
-		if (pring->ringno == LPFC_ELS_RING)
-			iabt->un.acxri.abortContextTag = cmdiocb->iotag;
+		ulp_context = cmdiocb->sli4_xritag;
+		iotag = abtsiocbp->iotag;
 	} else {
-		iabt->un.acxri.abortIoTag = icmd->ulpIoTag;
+		iotag = cmdiocb->iocb.ulpIoTag;
 		if (pring->ringno == LPFC_ELS_RING) {
 			ndlp = (struct lpfc_nodelist *)(cmdiocb->context1);
-			iabt->un.acxri.abortContextTag = ndlp->nlp_rpi;
+			ulp_context = ndlp->nlp_rpi;
+		} else {
+			ulp_context = cmdiocb->iocb.ulpContext;
 		}
 	}
-	iabt->ulpLe = 1;
-	iabt->ulpClass = icmd->ulpClass;
+
+	if (phba->link_state < LPFC_LINK_UP ||
+	    (phba->sli_rev == LPFC_SLI_REV4 &&
+	     phba->sli4_hba.link_state.status == LPFC_FC_LA_TYPE_LINK_DOWN))
+		ia = true;
+	else
+		ia = false;
+
+	lpfc_sli_prep_abort_xri(phba, abtsiocbp, ulp_context, iotag,
+				cmdiocb->iocb.ulpClass,
+				LPFC_WQE_CQ_ID_DEFAULT, ia);
+
+	abtsiocbp->vport = vport;
 
 	/* ABTS WQE must go to the same WQ as the WQE to be aborted */
 	abtsiocbp->hba_wqidx = cmdiocb->hba_wqidx;
 	if (cmdiocb->cmd_flag & LPFC_IO_FCP)
 		abtsiocbp->cmd_flag |= (LPFC_IO_FCP | LPFC_USE_FCPWQIDX);
+
 	if (cmdiocb->cmd_flag & LPFC_IO_FOF)
 		abtsiocbp->cmd_flag |= LPFC_IO_FOF;
 
-	if (phba->link_state < LPFC_LINK_UP ||
-	    (phba->sli_rev == LPFC_SLI_REV4 &&
-	     phba->sli4_hba.link_state.status == LPFC_FC_LA_TYPE_LINK_DOWN))
-		iabt->ulpCommand = CMD_CLOSE_XRI_CN;
-	else
-		iabt->ulpCommand = CMD_ABORT_XRI_CN;
-
 	if (cmpl)
 		abtsiocbp->cmd_cmpl = cmpl;
 	else
@@ -12142,12 +12196,12 @@ lpfc_sli_issue_abort_iotag(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 abort_iotag_exit:
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI,
-			 "0339 Abort xri x%x, original iotag x%x, "
-			 "abort cmd iotag x%x retval x%x\n",
-			 iabt->un.acxri.abortIoTag,
-			 iabt->un.acxri.abortContextTag,
-			 abtsiocbp->iotag, retval);
-
+			 "0339 Abort IO XRI x%x, Original iotag x%x, "
+			 "abort tag x%x Cmdjob : x%px Abortjob : x%px "
+			 "retval x%x\n",
+			 ulp_context, (phba->sli_rev == LPFC_SLI_REV4) ?
+			 cmdiocb->iotag : iotag, iotag, cmdiocb, abtsiocbp,
+			 retval);
 	if (retval) {
 		cmdiocb->cmd_flag &= ~LPFC_DRIVER_ABORTED;
 		__lpfc_sli_release_iocbq(phba, abtsiocbp);
@@ -12207,7 +12261,7 @@ static int
 lpfc_sli_validate_fcp_iocb_for_abort(struct lpfc_iocbq *iocbq,
 				     struct lpfc_vport *vport)
 {
-	IOCB_t *icmd = NULL;
+	u8 ulp_command;
 
 	/* No null ptr vports */
 	if (!iocbq || iocbq->vport != vport)
@@ -12216,12 +12270,13 @@ lpfc_sli_validate_fcp_iocb_for_abort(struct lpfc_iocbq *iocbq,
 	/* iocb must be for FCP IO, already exists on the TX cmpl queue,
 	 * can't be premarked as driver aborted, nor be an ABORT iocb itself
 	 */
-	icmd = &iocbq->iocb;
+	ulp_command = get_job_cmnd(vport->phba, iocbq);
 	if (!(iocbq->cmd_flag & LPFC_IO_FCP) ||
 	    !(iocbq->cmd_flag & LPFC_IO_ON_TXCMPLQ) ||
 	    (iocbq->cmd_flag & LPFC_DRIVER_ABORTED) ||
-	    (icmd->ulpCommand == CMD_ABORT_XRI_CN ||
-	     icmd->ulpCommand == CMD_CLOSE_XRI_CN))
+	    (ulp_command == CMD_ABORT_XRI_CN ||
+	     ulp_command == CMD_CLOSE_XRI_CN ||
+	     ulp_command == CMD_ABORT_XRI_WQE))
 		return -EINVAL;
 
 	return 0;
@@ -12313,9 +12368,9 @@ lpfc_sli_sum_iocb(struct lpfc_vport *vport, uint16_t tgt_id, uint64_t lun_id,
 {
 	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_iocbq *iocbq;
-	IOCB_t *icmd = NULL;
 	int sum, i;
 	unsigned long iflags;
+	u8 ulp_command;
 
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	for (i = 1, sum = 0; i <= phba->sli.last_iotag; i++) {
@@ -12328,9 +12383,10 @@ lpfc_sli_sum_iocb(struct lpfc_vport *vport, uint16_t tgt_id, uint64_t lun_id,
 			continue;
 
 		/* Include counting outstanding aborts */
-		icmd = &iocbq->iocb;
-		if (icmd->ulpCommand == CMD_ABORT_XRI_CN ||
-		    icmd->ulpCommand == CMD_CLOSE_XRI_CN) {
+		ulp_command = get_job_cmnd(phba, iocbq);
+		if (ulp_command == CMD_ABORT_XRI_CN ||
+		    ulp_command == CMD_CLOSE_XRI_CN ||
+		    ulp_command == CMD_ABORT_XRI_WQE) {
 			sum++;
 			continue;
 		}
@@ -12344,33 +12400,6 @@ lpfc_sli_sum_iocb(struct lpfc_vport *vport, uint16_t tgt_id, uint64_t lun_id,
 	return sum;
 }
 
-/**
- * lpfc_sli4_abort_fcp_cmpl - Completion handler function for aborted FCP IOCBs
- * @phba: Pointer to HBA context object
- * @cmdiocb: Pointer to command iocb object.
- * @wcqe: pointer to the complete wcqe
- *
- * This function is called when an aborted FCP iocb completes. This
- * function is called by the ring event handler with no lock held.
- * This function frees the iocb. It is called for sli-4 adapters.
- **/
-void
-lpfc_sli4_abort_fcp_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
-			 struct lpfc_wcqe_complete *wcqe)
-{
-	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
-			"3017 ABORT_XRI_CN completing on rpi x%x "
-			"original iotag x%x, abort cmd iotag x%x "
-			"status 0x%x, reason 0x%x\n",
-			cmdiocb->iocb.un.acxri.abortContextTag,
-			cmdiocb->iocb.un.acxri.abortIoTag,
-			cmdiocb->iotag,
-			(bf_get(lpfc_wcqe_c_status, wcqe)
-			& LPFC_IOCB_STATUS_MASK),
-			wcqe->parameter);
-	lpfc_sli_release_iocbq(phba, cmdiocb);
-}
-
 /**
  * lpfc_sli_abort_fcp_cmpl - Completion handler function for aborted FCP IOCBs
  * @phba: Pointer to HBA context object
@@ -12386,13 +12415,15 @@ lpfc_sli_abort_fcp_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			struct lpfc_iocbq *rspiocb)
 {
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
-			"3096 ABORT_XRI_CN completing on rpi x%x "
+			"3096 ABORT_XRI_CX completing on rpi x%x "
 			"original iotag x%x, abort cmd iotag x%x "
 			"status 0x%x, reason 0x%x\n",
+			(phba->sli_rev == LPFC_SLI_REV4) ?
+			cmdiocb->sli4_xritag :
 			cmdiocb->iocb.un.acxri.abortContextTag,
-			cmdiocb->iocb.un.acxri.abortIoTag,
-			cmdiocb->iotag, rspiocb->iocb.ulpStatus,
-			rspiocb->iocb.un.ulpWord[4]);
+			get_job_abtsiotag(phba, cmdiocb),
+			cmdiocb->iotag, get_job_ulpstatus(phba, rspiocb),
+			get_job_word4(phba, rspiocb));
 	lpfc_sli_release_iocbq(phba, cmdiocb);
 	return;
 }
@@ -12433,7 +12464,6 @@ lpfc_sli_abort_iocb(struct lpfc_vport *vport, u16 tgt_id, u64 lun_id,
 	int errcnt = 0, ret_val = 0;
 	unsigned long iflags;
 	int i;
-	void *fcp_cmpl = NULL;
 
 	/* all I/Os are in process of being flushed */
 	if (phba->hba_flag & HBA_IOQ_FLUSH)
@@ -12452,13 +12482,11 @@ lpfc_sli_abort_iocb(struct lpfc_vport *vport, u16 tgt_id, u64 lun_id,
 		spin_lock_irqsave(&phba->hbalock, iflags);
 		if (phba->sli_rev == LPFC_SLI_REV3) {
 			pring = &phba->sli.sli3_ring[LPFC_FCP_RING];
-			fcp_cmpl = lpfc_sli_abort_fcp_cmpl;
 		} else if (phba->sli_rev == LPFC_SLI_REV4) {
 			pring = lpfc_sli4_calc_ring(phba, iocbq);
-			fcp_cmpl = lpfc_sli4_abort_fcp_cmpl;
 		}
 		ret_val = lpfc_sli_issue_abort_iotag(phba, pring, iocbq,
-						     fcp_cmpl);
+						     lpfc_sli_abort_fcp_cmpl);
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 		if (ret_val != IOCB_SUCCESS)
 			errcnt++;
@@ -12500,12 +12528,13 @@ lpfc_sli_abort_taskmgmt(struct lpfc_vport *vport, struct lpfc_sli_ring *pring,
 	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_io_buf *lpfc_cmd;
 	struct lpfc_iocbq *abtsiocbq;
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp = NULL;
 	struct lpfc_iocbq *iocbq;
-	IOCB_t *icmd;
 	int sum, i, ret_val;
 	unsigned long iflags;
 	struct lpfc_sli_ring *pring_s4 = NULL;
+	u16 ulp_context, iotag, cqid = LPFC_WQE_CQ_ID_DEFAULT;
+	bool ia;
 
 	spin_lock_irqsave(&phba->hbalock, iflags);
 
@@ -12567,16 +12596,32 @@ lpfc_sli_abort_taskmgmt(struct lpfc_vport *vport, struct lpfc_sli_ring *pring,
 			continue;
 		}
 
-		icmd = &iocbq->iocb;
-		abtsiocbq->iocb.un.acxri.abortType = ABORT_TYPE_ABTS;
-		abtsiocbq->iocb.un.acxri.abortContextTag = icmd->ulpContext;
-		if (phba->sli_rev == LPFC_SLI_REV4)
-			abtsiocbq->iocb.un.acxri.abortIoTag =
-							 iocbq->sli4_xritag;
+		if (phba->sli_rev == LPFC_SLI_REV4) {
+			iotag = abtsiocbq->iotag;
+			ulp_context = iocbq->sli4_xritag;
+			cqid = lpfc_cmd->hdwq->io_cq_map;
+		} else {
+			iotag = iocbq->iocb.ulpIoTag;
+			if (pring->ringno == LPFC_ELS_RING) {
+				ndlp = (struct lpfc_nodelist *)(iocbq->context1);
+				ulp_context = ndlp->nlp_rpi;
+			} else {
+				ulp_context = iocbq->iocb.ulpContext;
+			}
+		}
+
+		ndlp = lpfc_cmd->rdata->pnode;
+
+		if (lpfc_is_link_up(phba) &&
+		    (ndlp && ndlp->nlp_state == NLP_STE_MAPPED_NODE))
+			ia = false;
 		else
-			abtsiocbq->iocb.un.acxri.abortIoTag = icmd->ulpIoTag;
-		abtsiocbq->iocb.ulpLe = 1;
-		abtsiocbq->iocb.ulpClass = icmd->ulpClass;
+			ia = true;
+
+		lpfc_sli_prep_abort_xri(phba, abtsiocbq, ulp_context, iotag,
+					iocbq->iocb.ulpClass, cqid,
+					ia);
+
 		abtsiocbq->vport = vport;
 
 		/* ABTS WQE must go to the same WQ as the WQE to be aborted */
@@ -12586,14 +12631,6 @@ lpfc_sli_abort_taskmgmt(struct lpfc_vport *vport, struct lpfc_sli_ring *pring,
 		if (iocbq->cmd_flag & LPFC_IO_FOF)
 			abtsiocbq->cmd_flag |= LPFC_IO_FOF;
 
-		ndlp = lpfc_cmd->rdata->pnode;
-
-		if (lpfc_is_link_up(phba) &&
-		    (ndlp && ndlp->nlp_state == NLP_STE_MAPPED_NODE))
-			abtsiocbq->iocb.ulpCommand = CMD_ABORT_XRI_CN;
-		else
-			abtsiocbq->iocb.ulpCommand = CMD_CLOSE_XRI_CN;
-
 		/* Setup callback routine and issue the command. */
 		abtsiocbq->cmd_cmpl = lpfc_sli_abort_fcp_cmpl;
 
@@ -18456,8 +18493,8 @@ lpfc_sli4_seq_abort_rsp_cmpl(struct lpfc_hba *phba,
 	if (rsp_iocbq && rsp_iocbq->iocb.ulpStatus)
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"3154 BLS ABORT RSP failed, data:  x%x/x%x\n",
-			rsp_iocbq->iocb.ulpStatus,
-			rsp_iocbq->iocb.un.ulpWord[4]);
+			get_job_ulpstatus(phba, rsp_iocbq),
+			get_job_word4(phba, rsp_iocbq));
 }
 
 /**
@@ -18499,7 +18536,7 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	struct lpfc_nodelist *ndlp;
 	uint16_t oxid, rxid, xri, lxri;
 	uint32_t sid, fctl;
-	IOCB_t *icmd;
+	union lpfc_wqe128 *icmd;
 	int rc;
 
 	if (!lpfc_is_link_up(phba))
@@ -18527,22 +18564,11 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	if (!ctiocb)
 		return;
 
+	icmd = &ctiocb->wqe;
+
 	/* Extract the F_CTL field from FC_HDR */
 	fctl = sli4_fctl_from_fc_hdr(fc_hdr);
 
-	icmd = &ctiocb->iocb;
-	icmd->un.xseq64.bdl.bdeSize = 0;
-	icmd->un.xseq64.bdl.ulpIoTag32 = 0;
-	icmd->un.xseq64.w5.hcsw.Dfctl = 0;
-	icmd->un.xseq64.w5.hcsw.Rctl = FC_RCTL_BA_ACC;
-	icmd->un.xseq64.w5.hcsw.Type = FC_TYPE_BLS;
-
-	/* Fill in the rest of iocb fields */
-	icmd->ulpCommand = CMD_XMIT_BLS_RSP64_CX;
-	icmd->ulpBdeCount = 0;
-	icmd->ulpLe = 1;
-	icmd->ulpClass = CLASS3;
-	icmd->ulpContext = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
 	ctiocb->context1 = lpfc_nlp_get(ndlp);
 	if (!ctiocb->context1) {
 		lpfc_sli_release_iocbq(phba, ctiocb);
@@ -18553,17 +18579,15 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	ctiocb->cmd_cmpl = lpfc_sli4_seq_abort_rsp_cmpl;
 	ctiocb->sli4_lxritag = NO_XRI;
 	ctiocb->sli4_xritag = NO_XRI;
+	ctiocb->abort_rctl = FC_RCTL_BA_ACC;
 
-	if (fctl & FC_FC_EX_CTX) {
+	if (fctl & FC_FC_EX_CTX)
 		/* Exchange responder sent the abort so we
 		 * own the oxid.
 		 */
-		ctiocb->abort_bls = LPFC_ABTS_UNSOL_RSP;
 		xri = oxid;
-	} else {
-		ctiocb->abort_bls = LPFC_ABTS_UNSOL_INT;
+	else
 		xri = rxid;
-	}
 	lxri = lpfc_sli4_xri_inrange(phba, xri);
 	if (lxri != NO_XRI)
 		lpfc_set_rrq_active(phba, ndlp, lxri,
@@ -18575,10 +18599,12 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	 */
 	if ((fctl & FC_FC_EX_CTX) &&
 	    (lxri > lpfc_sli4_get_iocb_cnt(phba))) {
-		icmd->un.xseq64.w5.hcsw.Rctl = FC_RCTL_BA_RJT;
-		bf_set(lpfc_vndr_code, &icmd->un.bls_rsp, 0);
-		bf_set(lpfc_rsn_expln, &icmd->un.bls_rsp, FC_BA_RJT_INV_XID);
-		bf_set(lpfc_rsn_code, &icmd->un.bls_rsp, FC_BA_RJT_UNABLE);
+		ctiocb->abort_rctl = FC_RCTL_BA_RJT;
+		bf_set(xmit_bls_rsp64_rjt_vspec, &icmd->xmit_bls_rsp, 0);
+		bf_set(xmit_bls_rsp64_rjt_expc, &icmd->xmit_bls_rsp,
+		       FC_BA_RJT_INV_XID);
+		bf_set(xmit_bls_rsp64_rjt_rsnc, &icmd->xmit_bls_rsp,
+		       FC_BA_RJT_UNABLE);
 	}
 
 	/* If BA_ABTS failed to abort a partially assembled receive sequence,
@@ -18586,10 +18612,12 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	 * the IOCB for a BA_RJT.
 	 */
 	if (aborted == false) {
-		icmd->un.xseq64.w5.hcsw.Rctl = FC_RCTL_BA_RJT;
-		bf_set(lpfc_vndr_code, &icmd->un.bls_rsp, 0);
-		bf_set(lpfc_rsn_expln, &icmd->un.bls_rsp, FC_BA_RJT_INV_XID);
-		bf_set(lpfc_rsn_code, &icmd->un.bls_rsp, FC_BA_RJT_UNABLE);
+		ctiocb->abort_rctl = FC_RCTL_BA_RJT;
+		bf_set(xmit_bls_rsp64_rjt_vspec, &icmd->xmit_bls_rsp, 0);
+		bf_set(xmit_bls_rsp64_rjt_expc, &icmd->xmit_bls_rsp,
+		       FC_BA_RJT_INV_XID);
+		bf_set(xmit_bls_rsp64_rjt_rsnc, &icmd->xmit_bls_rsp,
+		       FC_BA_RJT_UNABLE);
 	}
 
 	if (fctl & FC_FC_EX_CTX) {
@@ -18597,28 +18625,40 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 		 * of BA_ACC will use OX_ID from ABTS for the XRI_TAG
 		 * field and RX_ID from ABTS for RX_ID field.
 		 */
-		bf_set(lpfc_abts_orig, &icmd->un.bls_rsp, LPFC_ABTS_UNSOL_RSP);
+		ctiocb->abort_bls = LPFC_ABTS_UNSOL_RSP;
+		bf_set(xmit_bls_rsp64_rxid, &icmd->xmit_bls_rsp, rxid);
 	} else {
 		/* ABTS sent by initiator to CT exchange, construction
 		 * of BA_ACC will need to allocate a new XRI as for the
 		 * XRI_TAG field.
 		 */
-		bf_set(lpfc_abts_orig, &icmd->un.bls_rsp, LPFC_ABTS_UNSOL_INT);
+		ctiocb->abort_bls = LPFC_ABTS_UNSOL_INT;
 	}
-	bf_set(lpfc_abts_rxid, &icmd->un.bls_rsp, rxid);
-	bf_set(lpfc_abts_oxid, &icmd->un.bls_rsp, oxid);
+
+	/* OX_ID is invariable to who sent ABTS to CT exchange */
+	bf_set(xmit_bls_rsp64_oxid, &icmd->xmit_bls_rsp, oxid);
+	bf_set(xmit_bls_rsp64_oxid, &icmd->xmit_bls_rsp, rxid);
+
+	/* Use CT=VPI */
+	bf_set(wqe_els_did, &icmd->xmit_bls_rsp.wqe_dest,
+	       ndlp->nlp_DID);
+	bf_set(xmit_bls_rsp64_temprpi, &icmd->xmit_bls_rsp,
+	       phba->sli4_hba.rpi_ids[ndlp->nlp_rpi]);
+	bf_set(wqe_cmnd, &icmd->generic.wqe_com, CMD_XMIT_BLS_RSP64_CX);
+
 
 	/* Xmit CT abts response on exchange <xid> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "1200 Send BLS cmd x%x on oxid x%x Data: x%x\n",
-			 icmd->un.xseq64.w5.hcsw.Rctl, oxid, phba->link_state);
+			 ctiocb->abort_rctl, oxid, phba->link_state);
 
+	lpfc_sli_prep_wqe(phba, ctiocb);
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, ctiocb, 0);
 	if (rc == IOCB_ERROR) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2925 Failed to issue CT ABTS RSP x%x on "
 				 "xri x%x, Data x%x\n",
-				 icmd->un.xseq64.w5.hcsw.Rctl, oxid,
+				 ctiocb->abort_rctl, oxid,
 				 phba->link_state);
 		lpfc_nlp_put(ndlp);
 		ctiocb->context1 = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 9f5b6574e638..d5c26995ba39 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -76,11 +76,13 @@ struct lpfc_iocbq {
 	struct lpfc_wcqe_complete wcqe_cmpl;	/* WQE cmpl */
 
 	u32 unsol_rcv_len;	/* Receive len in usol path */
+
 	uint8_t num_bdes;
 	uint8_t abort_bls;	/* ABTS by initiator or responder */
-
+	u8 abort_rctl;		/* ACC or RJT flag */
 	uint8_t priority;	/* OAS priority */
 	uint8_t retry;		/* retry counter for IOCB cmd - if needed */
+
 	u32 cmd_flag;
 #define LPFC_IO_LIBDFC		1	/* libdfc iocb */
 #define LPFC_IO_WAKE		2	/* Synchronous I/O completed */
-- 
2.26.2

