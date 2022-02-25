Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57314C3B9B
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Feb 2022 03:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiBYCYC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Feb 2022 21:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiBYCXy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Feb 2022 21:23:54 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CECA1C74CA
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e6so1958738pgn.2
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fz9C0ij9qhaheiICjj7Fuau/5DqG6H7GQ6c1z/5kIVg=;
        b=qnqmpPkJQ47k9larQc0/svHG7EAvI5M1D9f84fP8I7BpUfWmIpVe2o17rJwJFq/LT1
         2Zcv495PLdEKy2ti0fWnMsQmz41hv6gToCCq3UFeMPvYFxtPzFk8I6zM/VCKIHS/cIik
         f9hkhm7qdk7/XWuodf+QzDDMvckm/uWq95BeqUTxOepabrr97N4uXSZG/FpxAkOUpaMc
         n9FPoq/3xNGNW1uaawL8eO4UuyUiXCV69nHQj25reg0XbMe3wWQhNiuE1KfSVDyYe+u/
         z1BwQMsi0YmkoUTxVW9hJBVg+FwxwL610i4oiF9o3I112zHtFLK1D5/lTjGfWi7enkcp
         HeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fz9C0ij9qhaheiICjj7Fuau/5DqG6H7GQ6c1z/5kIVg=;
        b=ooS6IJZ+HOkZN4ZlEB/VGSUmxOIninTzuahmsbdQ6yh3LaYl2T8LzLWKDHQmHmf9Qx
         tJtMNT94PVdiY7udEXo7m30xZ95R7dBvOidvCmB9NckkpuoxGIB84eOq0FrTBugD3Jx6
         IjOOeIuHrqxPcbxbf7MKQqHSKlAR4P9M9iFvZk466fusDpMsXPSOIl81jBTrABQ87tOF
         ysAY8m5ljTjgkAkuF9ZxMClWuO78JFgDArAnl+1lV2EURNtZfJ7zKeq7hssXRT3s987x
         vvwYDgNMrVgdQ95YAAXf39c9VaLezJfdRla5aXZ1UA2Q3QdPWYTS+BhUyWN2e4cFm5LT
         WPQA==
X-Gm-Message-State: AOAM530P0AbVkfRH43e2CTdB9I91k6IsSKD8SVdzBZJnXiGlPQo1MrfT
        lbaQ6sh3weLhMDQmhI5ERIIPWIGTzD0=
X-Google-Smtp-Source: ABdhPJwUwgSRTr350Zl/hcaT3rzWPfHUlqNK9yGicLZ9ASJiYScN1qUTnOuzQZFCf+v0r68r9K7qSA==
X-Received: by 2002:a63:cf52:0:b0:36c:8e67:45c9 with SMTP id b18-20020a63cf52000000b0036c8e6745c9mr4367963pgj.542.1645755799170;
        Thu, 24 Feb 2022 18:23:19 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f3b355dcb1sm845596pfh.58.2022.02.24.18.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:23:18 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 02/17] lpfc: SLI path split: refactor fast and slow paths to native sli4
Date:   Thu, 24 Feb 2022 18:22:53 -0800
Message-Id: <20220225022308.16486-3-jsmart2021@gmail.com>
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

Convert the SLI4 fast and slow paths to use native sli4 wqe constructs
instead of iocb SLI3-isms.

includes the following:
- Create simple get_xxx and set_xxx routines to wrapper access to common
  elements in both sli3 and sli4 commands - allowing calling routines to
  avoid sli-rev-specific structures to access the elements.
- using the wqe in the job structure as the primary element
- use defines from SLI-4, not SLI-3
- Removal of iocb to wqe conversion from fast and slow path
- Add below routines to handle fast path
        lpfc_prep_embed_io - prepares the wqe for fast path
        lpfc_wqe_bpl2sgl   - manages bpl to sgl conversion
        lpfc_sli_wqe2iocb  - converts a WQE to IOCB for sli-3 path
- Add lpfc_sli3_iocb2wcqecmpl in completion path to convert an sli-3
  iocb completion to wcqe completion
- Refactor some of the code that works on both revs for clarity

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |  36 +++
 drivers/scsi/lpfc/lpfc_crtn.h |   1 +
 drivers/scsi/lpfc/lpfc_hw4.h  |   7 +
 drivers/scsi/lpfc/lpfc_sli.c  | 513 ++++++++++++++--------------------
 drivers/scsi/lpfc/lpfc_sli.h  |   2 +
 5 files changed, 257 insertions(+), 302 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 98cabe09c040..e247f9744f61 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1801,3 +1801,39 @@ static inline int lpfc_is_vmid_enabled(struct lpfc_hba *phba)
 {
 	return phba->cfg_vmid_app_header || phba->cfg_vmid_priority_tagging;
 }
+
+static inline
+u8 get_job_ulpstatus(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
+{
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		return bf_get(lpfc_wcqe_c_status, &iocbq->wcqe_cmpl);
+	else
+		return iocbq->iocb.ulpStatus;
+}
+
+static inline
+u32 get_job_word4(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
+{
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		return iocbq->wcqe_cmpl.parameter;
+	else
+		return iocbq->iocb.un.ulpWord[4];
+}
+
+static inline
+u8 get_job_cmnd(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
+{
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		return bf_get(wqe_cmnd, &iocbq->wqe.generic.wqe_com);
+	else
+		return iocbq->iocb.ulpCommand;
+}
+
+static inline
+u16 get_job_ulpcontext(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
+{
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		return bf_get(wqe_ctxt_tag, &iocbq->wqe.generic.wqe_com);
+	else
+		return iocbq->iocb.ulpContext;
+}
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index ef796484a0b2..435428fdaa6e 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -129,6 +129,7 @@ void lpfc_disc_list_loopmap(struct lpfc_vport *);
 void lpfc_disc_start(struct lpfc_vport *);
 void lpfc_cleanup_discovery_resources(struct lpfc_vport *);
 void lpfc_cleanup(struct lpfc_vport *);
+void lpfc_prep_embed_io(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_ncmd);
 void lpfc_disc_timeout(struct timer_list *);
 
 int lpfc_unregister_fcf_prep(struct lpfc_hba *);
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 6ec42991d2ab..32e6ed23f869 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -60,6 +60,13 @@
 	((ptr)->name##_WORD = ((((value) & name##_MASK) << name##_SHIFT) | \
 		 ((ptr)->name##_WORD & ~(name##_MASK << name##_SHIFT))))
 
+#define get_wqe_reqtag(x)	(((x)->wqe.words[9] >>  0) & 0xFFFF)
+
+#define get_job_ulpword(x, y)	((x)->iocb.un.ulpWord[y])
+
+#define set_job_ulpstatus(x, y)	bf_set(lpfc_wcqe_c_status, &(x)->wcqe_cmpl, y)
+#define set_job_ulpword4(x, y)	((&(x)->wcqe_cmpl)->parameter = y)
+
 struct dma_address {
 	uint32_t addr_lo;
 	uint32_t addr_hi;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 1e752e4bb3bb..c87d902862c6 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -70,8 +70,9 @@ static int lpfc_sli_issue_mbox_s4(struct lpfc_hba *, LPFC_MBOXQ_t *,
 				  uint32_t);
 static int lpfc_sli4_read_rev(struct lpfc_hba *, LPFC_MBOXQ_t *,
 			      uint8_t *, uint32_t *);
-static struct lpfc_iocbq *lpfc_sli4_els_wcqe_to_rspiocbq(struct lpfc_hba *,
-							 struct lpfc_iocbq *);
+static struct lpfc_iocbq *
+lpfc_sli4_els_preprocess_rspiocbq(struct lpfc_hba *phba,
+				  struct lpfc_iocbq *rspiocbq);
 static void lpfc_sli4_send_seq_to_ulp(struct lpfc_vport *,
 				      struct hbq_dmabuf *);
 static void lpfc_sli4_handle_mds_loopback(struct lpfc_vport *vport,
@@ -89,6 +90,9 @@ static struct lpfc_cqe *lpfc_sli4_cq_get(struct lpfc_queue *q);
 static void __lpfc_sli4_consume_cqe(struct lpfc_hba *phba,
 				    struct lpfc_queue *cq,
 				    struct lpfc_cqe *cqe);
+static uint16_t lpfc_wqe_bpl2sgl(struct lpfc_hba *phba,
+				 struct lpfc_iocbq *pwqeq,
+				 struct lpfc_sglq *sglq);
 
 union lpfc_wqe128 lpfc_iread_cmd_template;
 union lpfc_wqe128 lpfc_iwrite_cmd_template;
@@ -3550,17 +3554,12 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
 		      struct lpfc_iocbq *prspiocb)
 {
 	struct lpfc_iocbq *cmd_iocb = NULL;
-	uint16_t iotag;
-	spinlock_t *temp_lock = NULL;
-	unsigned long iflag = 0;
+	u16 iotag;
 
 	if (phba->sli_rev == LPFC_SLI_REV4)
-		temp_lock = &pring->ring_lock;
+		iotag = get_wqe_reqtag(prspiocb);
 	else
-		temp_lock = &phba->hbalock;
-
-	spin_lock_irqsave(temp_lock, iflag);
-	iotag = prspiocb->iocb.ulpIoTag;
+		iotag = prspiocb->iocb.ulpIoTag;
 
 	if (iotag != 0 && iotag <= phba->sli.last_iotag) {
 		cmd_iocb = phba->sli.iocbq_lookup[iotag];
@@ -3569,17 +3568,14 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
 			list_del_init(&cmd_iocb->list);
 			cmd_iocb->cmd_flag &= ~LPFC_IO_ON_TXCMPLQ;
 			pring->txcmplq_cnt--;
-			spin_unlock_irqrestore(temp_lock, iflag);
 			return cmd_iocb;
 		}
 	}
 
-	spin_unlock_irqrestore(temp_lock, iflag);
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0317 iotag x%x is out of "
-			"range: max iotag x%x wd0 x%x\n",
-			iotag, phba->sli.last_iotag,
-			*(((uint32_t *) &prspiocb->iocb) + 7));
+			"range: max iotag x%x\n",
+			iotag, phba->sli.last_iotag);
 	return NULL;
 }
 
@@ -3600,15 +3596,7 @@ lpfc_sli_iocbq_lookup_by_tag(struct lpfc_hba *phba,
 			     struct lpfc_sli_ring *pring, uint16_t iotag)
 {
 	struct lpfc_iocbq *cmd_iocb = NULL;
-	spinlock_t *temp_lock = NULL;
-	unsigned long iflag = 0;
 
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		temp_lock = &pring->ring_lock;
-	else
-		temp_lock = &phba->hbalock;
-
-	spin_lock_irqsave(temp_lock, iflag);
 	if (iotag != 0 && iotag <= phba->sli.last_iotag) {
 		cmd_iocb = phba->sli.iocbq_lookup[iotag];
 		if (cmd_iocb->cmd_flag & LPFC_IO_ON_TXCMPLQ) {
@@ -3616,12 +3604,10 @@ lpfc_sli_iocbq_lookup_by_tag(struct lpfc_hba *phba,
 			list_del_init(&cmd_iocb->list);
 			cmd_iocb->cmd_flag &= ~LPFC_IO_ON_TXCMPLQ;
 			pring->txcmplq_cnt--;
-			spin_unlock_irqrestore(temp_lock, iflag);
 			return cmd_iocb;
 		}
 	}
 
-	spin_unlock_irqrestore(temp_lock, iflag);
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0372 iotag x%x lookup error: max iotag (x%x) "
 			"cmd_flag x%x\n",
@@ -3654,18 +3640,29 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	struct lpfc_iocbq *cmdiocbp;
 	int rc = 1;
 	unsigned long iflag;
+	u32 ulp_command, ulp_status, ulp_word4, ulp_context, iotag;
 
 	cmdiocbp = lpfc_sli_iocbq_lookup(phba, pring, saveq);
+
+	ulp_command = get_job_cmnd(phba, saveq);
+	ulp_status = get_job_ulpstatus(phba, saveq);
+	ulp_word4 = get_job_word4(phba, saveq);
+	ulp_context = get_job_ulpcontext(phba, saveq);
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		iotag = get_wqe_reqtag(saveq);
+	else
+		iotag = saveq->iocb.ulpIoTag;
+
 	if (cmdiocbp) {
+		ulp_command = get_job_cmnd(phba, cmdiocbp);
 		if (cmdiocbp->cmd_cmpl) {
 			/*
 			 * If an ELS command failed send an event to mgmt
 			 * application.
 			 */
-			if (saveq->iocb.ulpStatus &&
+			if (ulp_status &&
 			     (pring->ringno == LPFC_ELS_RING) &&
-			     (cmdiocbp->iocb.ulpCommand ==
-				CMD_ELS_REQUEST64_CR))
+			     (ulp_command == CMD_ELS_REQUEST64_CR))
 				lpfc_send_els_failure_event(phba,
 					cmdiocbp, saveq);
 
@@ -3727,20 +3724,20 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 							~LPFC_DRIVER_ABORTED;
 						spin_unlock_irqrestore(
 							&phba->hbalock, iflag);
-						cmdiocbp->iocb.ulpStatus =
-							IOSTAT_LOCAL_REJECT;
-						cmdiocbp->iocb.un.ulpWord[4] =
-							IOERR_ABORT_REQUESTED;
+						set_job_ulpstatus(cmdiocbp,
+								  IOSTAT_LOCAL_REJECT);
+						set_job_ulpword4(cmdiocbp,
+								 IOERR_ABORT_REQUESTED);
 						/*
 						 * For SLI4, irsiocb contains
 						 * NO_XRI in sli_xritag, it
 						 * shall not affect releasing
 						 * sgl (xri) process.
 						 */
-						saveq->iocb.ulpStatus =
-							IOSTAT_LOCAL_REJECT;
-						saveq->iocb.un.ulpWord[4] =
-							IOERR_SLI_ABORTED;
+						set_job_ulpstatus(saveq,
+								  IOSTAT_LOCAL_REJECT);
+						set_job_ulpword4(saveq,
+								 IOERR_SLI_ABORTED);
 						spin_lock_irqsave(
 							&phba->hbalock, iflag);
 						saveq->cmd_flag |=
@@ -3768,12 +3765,8 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 					 "0322 Ring %d handler: "
 					 "unexpected completion IoTag x%x "
 					 "Data: x%x x%x x%x x%x\n",
-					 pring->ringno,
-					 saveq->iocb.ulpIoTag,
-					 saveq->iocb.ulpStatus,
-					 saveq->iocb.un.ulpWord[4],
-					 saveq->iocb.ulpCommand,
-					 saveq->iocb.ulpContext);
+					 pring->ringno, iotag, ulp_status,
+					 ulp_word4, ulp_command, ulp_context);
 		}
 	}
 
@@ -4088,155 +4081,159 @@ lpfc_sli_sp_handle_rspiocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			struct lpfc_iocbq *rspiocbp)
 {
 	struct lpfc_iocbq *saveq;
-	struct lpfc_iocbq *cmdiocbp;
+	struct lpfc_iocbq *cmdiocb;
 	struct lpfc_iocbq *next_iocb;
-	IOCB_t *irsp = NULL;
+	IOCB_t *irsp;
 	uint32_t free_saveq;
-	uint8_t iocb_cmd_type;
+	u8 cmd_type;
 	lpfc_iocb_type type;
 	unsigned long iflag;
+	u32 ulp_status = get_job_ulpstatus(phba, rspiocbp);
+	u32 ulp_word4 = get_job_word4(phba, rspiocbp);
+	u32 ulp_command = get_job_cmnd(phba, rspiocbp);
 	int rc;
 
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	/* First add the response iocb to the countinueq list */
-	list_add_tail(&rspiocbp->list, &(pring->iocb_continueq));
+	list_add_tail(&rspiocbp->list, &pring->iocb_continueq);
 	pring->iocb_continueq_cnt++;
 
-	/* Now, determine whether the list is completed for processing */
-	irsp = &rspiocbp->iocb;
-	if (irsp->ulpLe) {
-		/*
-		 * By default, the driver expects to free all resources
-		 * associated with this iocb completion.
-		 */
-		free_saveq = 1;
-		saveq = list_get_first(&pring->iocb_continueq,
-				       struct lpfc_iocbq, list);
-		irsp = &(saveq->iocb);
-		list_del_init(&pring->iocb_continueq);
-		pring->iocb_continueq_cnt = 0;
+	/*
+	 * By default, the driver expects to free all resources
+	 * associated with this iocb completion.
+	 */
+	free_saveq = 1;
+	saveq = list_get_first(&pring->iocb_continueq,
+			       struct lpfc_iocbq, list);
+	list_del_init(&pring->iocb_continueq);
+	pring->iocb_continueq_cnt = 0;
 
-		pring->stats.iocb_rsp++;
+	pring->stats.iocb_rsp++;
 
-		/*
-		 * If resource errors reported from HBA, reduce
-		 * queuedepths of the SCSI device.
-		 */
-		if ((irsp->ulpStatus == IOSTAT_LOCAL_REJECT) &&
-		    ((irsp->un.ulpWord[4] & IOERR_PARAM_MASK) ==
-		     IOERR_NO_RESOURCES)) {
-			spin_unlock_irqrestore(&phba->hbalock, iflag);
-			phba->lpfc_rampdown_queue_depth(phba);
-			spin_lock_irqsave(&phba->hbalock, iflag);
-		}
+	/*
+	 * If resource errors reported from HBA, reduce
+	 * queuedepths of the SCSI device.
+	 */
+	if (ulp_status == IOSTAT_LOCAL_REJECT &&
+	    ((ulp_word4 & IOERR_PARAM_MASK) ==
+	     IOERR_NO_RESOURCES)) {
+		spin_unlock_irqrestore(&phba->hbalock, iflag);
+		phba->lpfc_rampdown_queue_depth(phba);
+		spin_lock_irqsave(&phba->hbalock, iflag);
+	}
 
-		if (irsp->ulpStatus) {
-			/* Rsp ring <ringno> error: IOCB */
+	if (ulp_status) {
+		/* Rsp ring <ringno> error: IOCB */
+		if (phba->sli_rev < LPFC_SLI_REV4) {
+			irsp = &rspiocbp->iocb;
 			lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
-					"0328 Rsp Ring %d error: "
+					"0328 Rsp Ring %d error: ulp_status x%x "
+					"IOCB Data: "
+					"x%08x x%08x x%08x x%08x "
+					"x%08x x%08x x%08x x%08x "
+					"x%08x x%08x x%08x x%08x "
+					"x%08x x%08x x%08x x%08x\n",
+					pring->ringno, ulp_status,
+					get_job_ulpword(rspiocbp, 0),
+					get_job_ulpword(rspiocbp, 1),
+					get_job_ulpword(rspiocbp, 2),
+					get_job_ulpword(rspiocbp, 3),
+					get_job_ulpword(rspiocbp, 4),
+					get_job_ulpword(rspiocbp, 5),
+					*(((uint32_t *)irsp) + 6),
+					*(((uint32_t *)irsp) + 7),
+					*(((uint32_t *)irsp) + 8),
+					*(((uint32_t *)irsp) + 9),
+					*(((uint32_t *)irsp) + 10),
+					*(((uint32_t *)irsp) + 11),
+					*(((uint32_t *)irsp) + 12),
+					*(((uint32_t *)irsp) + 13),
+					*(((uint32_t *)irsp) + 14),
+					*(((uint32_t *)irsp) + 15));
+		} else {
+			lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
+					"0321 Rsp Ring %d error: "
 					"IOCB Data: "
-					"x%x x%x x%x x%x "
-					"x%x x%x x%x x%x "
-					"x%x x%x x%x x%x "
 					"x%x x%x x%x x%x\n",
 					pring->ringno,
-					irsp->un.ulpWord[0],
-					irsp->un.ulpWord[1],
-					irsp->un.ulpWord[2],
-					irsp->un.ulpWord[3],
-					irsp->un.ulpWord[4],
-					irsp->un.ulpWord[5],
-					*(((uint32_t *) irsp) + 6),
-					*(((uint32_t *) irsp) + 7),
-					*(((uint32_t *) irsp) + 8),
-					*(((uint32_t *) irsp) + 9),
-					*(((uint32_t *) irsp) + 10),
-					*(((uint32_t *) irsp) + 11),
-					*(((uint32_t *) irsp) + 12),
-					*(((uint32_t *) irsp) + 13),
-					*(((uint32_t *) irsp) + 14),
-					*(((uint32_t *) irsp) + 15));
+					rspiocbp->wcqe_cmpl.word0,
+					rspiocbp->wcqe_cmpl.total_data_placed,
+					rspiocbp->wcqe_cmpl.parameter,
+					rspiocbp->wcqe_cmpl.word3);
 		}
+	}
 
-		/*
-		 * Fetch the IOCB command type and call the correct completion
-		 * routine. Solicited and Unsolicited IOCBs on the ELS ring
-		 * get freed back to the lpfc_iocb_list by the discovery
-		 * kernel thread.
-		 */
-		iocb_cmd_type = irsp->ulpCommand & CMD_IOCB_MASK;
-		type = lpfc_sli_iocb_cmd_type(iocb_cmd_type);
-		switch (type) {
-		case LPFC_SOL_IOCB:
-			spin_unlock_irqrestore(&phba->hbalock, iflag);
-			rc = lpfc_sli_process_sol_iocb(phba, pring, saveq);
-			spin_lock_irqsave(&phba->hbalock, iflag);
-			break;
 
-		case LPFC_UNSOL_IOCB:
-			spin_unlock_irqrestore(&phba->hbalock, iflag);
-			rc = lpfc_sli_process_unsol_iocb(phba, pring, saveq);
-			spin_lock_irqsave(&phba->hbalock, iflag);
-			if (!rc)
-				free_saveq = 0;
-			break;
-
-		case LPFC_ABORT_IOCB:
-			cmdiocbp = NULL;
-			if (irsp->ulpCommand != CMD_XRI_ABORTED_CX) {
+	/*
+	 * Fetch the iocb command type and call the correct completion
+	 * routine. Solicited and Unsolicited IOCBs on the ELS ring
+	 * get freed back to the lpfc_iocb_list by the discovery
+	 * kernel thread.
+	 */
+	cmd_type = ulp_command & CMD_IOCB_MASK;
+	type = lpfc_sli_iocb_cmd_type(cmd_type);
+	switch (type) {
+	case LPFC_SOL_IOCB:
+		spin_unlock_irqrestore(&phba->hbalock, iflag);
+		rc = lpfc_sli_process_sol_iocb(phba, pring, saveq);
+		spin_lock_irqsave(&phba->hbalock, iflag);
+		break;
+	case LPFC_UNSOL_IOCB:
+		spin_unlock_irqrestore(&phba->hbalock, iflag);
+		rc = lpfc_sli_process_unsol_iocb(phba, pring, saveq);
+		spin_lock_irqsave(&phba->hbalock, iflag);
+		if (!rc)
+			free_saveq = 0;
+		break;
+	case LPFC_ABORT_IOCB:
+		cmdiocb = NULL;
+		if (ulp_command != CMD_XRI_ABORTED_CX)
+			cmdiocb = lpfc_sli_iocbq_lookup(phba, pring,
+							saveq);
+		if (cmdiocb) {
+			/* Call the specified completion routine */
+			if (cmdiocb->cmd_cmpl) {
 				spin_unlock_irqrestore(&phba->hbalock, iflag);
-				cmdiocbp = lpfc_sli_iocbq_lookup(phba, pring,
-								 saveq);
+				cmdiocb->cmd_cmpl(phba, cmdiocb, saveq);
 				spin_lock_irqsave(&phba->hbalock, iflag);
-			}
-			if (cmdiocbp) {
-				/* Call the specified completion routine */
-				if (cmdiocbp->cmd_cmpl) {
-					spin_unlock_irqrestore(&phba->hbalock,
-							       iflag);
-					(cmdiocbp->cmd_cmpl)(phba, cmdiocbp,
-							      saveq);
-					spin_lock_irqsave(&phba->hbalock,
-							  iflag);
-				} else
-					__lpfc_sli_release_iocbq(phba,
-								 cmdiocbp);
-			}
-			break;
-
-		case LPFC_UNKNOWN_IOCB:
-			if (irsp->ulpCommand == CMD_ADAPTER_MSG) {
-				char adaptermsg[LPFC_MAX_ADPTMSG];
-				memset(adaptermsg, 0, LPFC_MAX_ADPTMSG);
-				memcpy(&adaptermsg[0], (uint8_t *)irsp,
-				       MAX_MSG_DATA);
-				dev_warn(&((phba->pcidev)->dev),
-					 "lpfc%d: %s\n",
-					 phba->brd_no, adaptermsg);
 			} else {
-				/* Unknown IOCB command */
-				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-						"0335 Unknown IOCB "
-						"command Data: x%x "
-						"x%x x%x x%x\n",
-						irsp->ulpCommand,
-						irsp->ulpStatus,
-						irsp->ulpIoTag,
-						irsp->ulpContext);
+				__lpfc_sli_release_iocbq(phba, cmdiocb);
 			}
-			break;
 		}
+		break;
+	case LPFC_UNKNOWN_IOCB:
+		if (ulp_command == CMD_ADAPTER_MSG) {
+			char adaptermsg[LPFC_MAX_ADPTMSG];
+
+			memset(adaptermsg, 0, LPFC_MAX_ADPTMSG);
+			memcpy(&adaptermsg[0], (uint8_t *)&rspiocbp->wqe,
+			       MAX_MSG_DATA);
+			dev_warn(&((phba->pcidev)->dev),
+				 "lpfc%d: %s\n",
+				 phba->brd_no, adaptermsg);
+		} else {
+			/* Unknown command */
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"0335 Unknown IOCB "
+					"command Data: x%x "
+					"x%x x%x x%x\n",
+					ulp_command,
+					ulp_status,
+					get_wqe_reqtag(rspiocbp),
+					get_job_ulpcontext(phba, rspiocbp));
+		}
+		break;
+	}
 
-		if (free_saveq) {
-			list_for_each_entry_safe(rspiocbp, next_iocb,
-						 &saveq->list, list) {
-				list_del_init(&rspiocbp->list);
-				__lpfc_sli_release_iocbq(phba, rspiocbp);
-			}
-			__lpfc_sli_release_iocbq(phba, saveq);
+	if (free_saveq) {
+		list_for_each_entry_safe(rspiocbp, next_iocb,
+					 &saveq->list, list) {
+			list_del_init(&rspiocbp->list);
+			__lpfc_sli_release_iocbq(phba, rspiocbp);
 		}
-		rspiocbp = NULL;
+		__lpfc_sli_release_iocbq(phba, saveq);
 	}
+	rspiocbp = NULL;
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
 	return rspiocbp;
 }
@@ -4429,8 +4426,8 @@ lpfc_sli_handle_slow_ring_event_s4(struct lpfc_hba *phba,
 			irspiocbq = container_of(cq_event, struct lpfc_iocbq,
 						 cq_event);
 			/* Translate ELS WCQE to response IOCBQ */
-			irspiocbq = lpfc_sli4_els_wcqe_to_rspiocbq(phba,
-								   irspiocbq);
+			irspiocbq = lpfc_sli4_els_preprocess_rspiocbq(phba,
+								      irspiocbq);
 			if (irspiocbq)
 				lpfc_sli_sp_handle_rspiocb(phba, pring,
 							   irspiocbq);
@@ -10957,7 +10954,17 @@ __lpfc_sli_issue_fcp_io_s4(struct lpfc_hba *phba, uint32_t ring_number,
 	int rc;
 	struct lpfc_io_buf *lpfc_cmd =
 		(struct lpfc_io_buf *)piocb->context1;
-	union lpfc_wqe128 *wqe = &piocb->wqe;
+
+	lpfc_prep_embed_io(phba, lpfc_cmd);
+	rc = lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
+	return rc;
+}
+
+void
+lpfc_prep_embed_io(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
+{
+	struct lpfc_iocbq *piocb = &lpfc_cmd->cur_iocbq;
+	union lpfc_wqe128 *wqe = &lpfc_cmd->cur_iocbq.wqe;
 	struct sli4_sge *sgl;
 
 	/* 128 byte wqe support here */
@@ -11006,8 +11013,6 @@ __lpfc_sli_issue_fcp_io_s4(struct lpfc_hba *phba, uint32_t ring_number,
 			wqe->words[31] = piocb->vmid_tag.app_id;
 		}
 	}
-	rc = lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
-	return rc;
 }
 
 /**
@@ -11029,9 +11034,10 @@ __lpfc_sli_issue_iocb_s4(struct lpfc_hba *phba, uint32_t ring_number,
 			 struct lpfc_iocbq *piocb, uint32_t flag)
 {
 	struct lpfc_sglq *sglq;
-	union lpfc_wqe128 wqe;
+	union lpfc_wqe128 *wqe;
 	struct lpfc_queue *wq;
 	struct lpfc_sli_ring *pring;
+	u32 ulp_command = get_job_cmnd(phba, piocb);
 
 	/* Get the WQ */
 	if ((piocb->cmd_flag & LPFC_IO_FCP) ||
@@ -11049,10 +11055,9 @@ __lpfc_sli_issue_iocb_s4(struct lpfc_hba *phba, uint32_t ring_number,
 	 */
 
 	lockdep_assert_held(&pring->ring_lock);
-
+	wqe = &piocb->wqe;
 	if (piocb->sli4_xritag == NO_XRI) {
-		if (piocb->iocb.ulpCommand == CMD_ABORT_XRI_CN ||
-		    piocb->iocb.ulpCommand == CMD_CLOSE_XRI_CN)
+		if (ulp_command == CMD_ABORT_XRI_WQE)
 			sglq = NULL;
 		else {
 			if (!list_empty(&pring->txq)) {
@@ -11093,14 +11098,24 @@ __lpfc_sli_issue_iocb_s4(struct lpfc_hba *phba, uint32_t ring_number,
 	if (sglq) {
 		piocb->sli4_lxritag = sglq->sli4_lxritag;
 		piocb->sli4_xritag = sglq->sli4_xritag;
-		if (NO_XRI == lpfc_sli4_bpl2sgl(phba, piocb, sglq))
+
+		/* ABTS sent by initiator to CT exchange, the
+		 * RX_ID field will be filled with the newly
+		 * allocated responder XRI.
+		 */
+		if (ulp_command == CMD_XMIT_BLS_RSP64_CX &&
+		    piocb->abort_bls == LPFC_ABTS_UNSOL_INT)
+			bf_set(xmit_bls_rsp64_rxid, &wqe->xmit_bls_rsp,
+			       piocb->sli4_xritag);
+
+		bf_set(wqe_xri_tag, &wqe->generic.wqe_com,
+		       piocb->sli4_xritag);
+
+		if (lpfc_wqe_bpl2sgl(phba, piocb, sglq) == NO_XRI)
 			return IOCB_ERROR;
 	}
 
-	if (lpfc_sli4_iocb2wqe(phba, piocb, &wqe))
-		return IOCB_ERROR;
-
-	if (lpfc_sli4_wq_put(wq, &wqe))
+	if (lpfc_sli4_wq_put(wq, wqe))
 		return IOCB_ERROR;
 	lpfc_sli_ringtxcmpl_put(phba, pring, piocb);
 
@@ -14098,123 +14113,7 @@ void lpfc_sli4_els_xri_abort_event_proc(struct lpfc_hba *phba)
 }
 
 /**
- * lpfc_sli4_iocb_param_transfer - Transfer pIocbOut and cmpl status to pIocbIn
- * @phba: pointer to lpfc hba data structure
- * @pIocbIn: pointer to the rspiocbq
- * @pIocbOut: pointer to the cmdiocbq
- * @wcqe: pointer to the complete wcqe
- *
- * This routine transfers the fields of a command iocbq to a response iocbq
- * by copying all the IOCB fields from command iocbq and transferring the
- * completion status information from the complete wcqe.
- **/
-static void
-lpfc_sli4_iocb_param_transfer(struct lpfc_hba *phba,
-			      struct lpfc_iocbq *pIocbIn,
-			      struct lpfc_iocbq *pIocbOut,
-			      struct lpfc_wcqe_complete *wcqe)
-{
-	int numBdes, i;
-	unsigned long iflags;
-	uint32_t status, max_response;
-	struct lpfc_dmabuf *dmabuf;
-	struct ulp_bde64 *bpl, bde;
-	size_t offset = offsetof(struct lpfc_iocbq, iocb);
-
-	memcpy((char *)pIocbIn + offset, (char *)pIocbOut + offset,
-	       sizeof(struct lpfc_iocbq) - offset);
-	/* Map WCQE parameters into irspiocb parameters */
-	status = bf_get(lpfc_wcqe_c_status, wcqe);
-	pIocbIn->iocb.ulpStatus = (status & LPFC_IOCB_STATUS_MASK);
-	if (pIocbOut->cmd_flag & LPFC_IO_FCP)
-		if (pIocbIn->iocb.ulpStatus == IOSTAT_FCP_RSP_ERROR)
-			pIocbIn->iocb.un.fcpi.fcpi_parm =
-					pIocbOut->iocb.un.fcpi.fcpi_parm -
-					wcqe->total_data_placed;
-		else
-			pIocbIn->iocb.un.ulpWord[4] = wcqe->parameter;
-	else {
-		pIocbIn->iocb.un.ulpWord[4] = wcqe->parameter;
-		switch (pIocbOut->iocb.ulpCommand) {
-		case CMD_ELS_REQUEST64_CR:
-			dmabuf = (struct lpfc_dmabuf *)pIocbOut->context3;
-			bpl  = (struct ulp_bde64 *)dmabuf->virt;
-			bde.tus.w = le32_to_cpu(bpl[1].tus.w);
-			max_response = bde.tus.f.bdeSize;
-			break;
-		case CMD_GEN_REQUEST64_CR:
-			max_response = 0;
-			if (!pIocbOut->context3)
-				break;
-			numBdes = pIocbOut->iocb.un.genreq64.bdl.bdeSize/
-					sizeof(struct ulp_bde64);
-			dmabuf = (struct lpfc_dmabuf *)pIocbOut->context3;
-			bpl = (struct ulp_bde64 *)dmabuf->virt;
-			for (i = 0; i < numBdes; i++) {
-				bde.tus.w = le32_to_cpu(bpl[i].tus.w);
-				if (bde.tus.f.bdeFlags != BUFF_TYPE_BDE_64)
-					max_response += bde.tus.f.bdeSize;
-			}
-			break;
-		default:
-			max_response = wcqe->total_data_placed;
-			break;
-		}
-		if (max_response < wcqe->total_data_placed)
-			pIocbIn->iocb.un.genreq64.bdl.bdeSize = max_response;
-		else
-			pIocbIn->iocb.un.genreq64.bdl.bdeSize =
-				wcqe->total_data_placed;
-	}
-
-	/* Convert BG errors for completion status */
-	if (status == CQE_STATUS_DI_ERROR) {
-		pIocbIn->iocb.ulpStatus = IOSTAT_LOCAL_REJECT;
-
-		if (bf_get(lpfc_wcqe_c_bg_edir, wcqe))
-			pIocbIn->iocb.un.ulpWord[4] = IOERR_RX_DMA_FAILED;
-		else
-			pIocbIn->iocb.un.ulpWord[4] = IOERR_TX_DMA_FAILED;
-
-		pIocbIn->iocb.unsli3.sli3_bg.bgstat = 0;
-		if (bf_get(lpfc_wcqe_c_bg_ge, wcqe)) /* Guard Check failed */
-			pIocbIn->iocb.unsli3.sli3_bg.bgstat |=
-				BGS_GUARD_ERR_MASK;
-		if (bf_get(lpfc_wcqe_c_bg_ae, wcqe)) /* App Tag Check failed */
-			pIocbIn->iocb.unsli3.sli3_bg.bgstat |=
-				BGS_APPTAG_ERR_MASK;
-		if (bf_get(lpfc_wcqe_c_bg_re, wcqe)) /* Ref Tag Check failed */
-			pIocbIn->iocb.unsli3.sli3_bg.bgstat |=
-				BGS_REFTAG_ERR_MASK;
-
-		/* Check to see if there was any good data before the error */
-		if (bf_get(lpfc_wcqe_c_bg_tdpv, wcqe)) {
-			pIocbIn->iocb.unsli3.sli3_bg.bgstat |=
-				BGS_HI_WATER_MARK_PRESENT_MASK;
-			pIocbIn->iocb.unsli3.sli3_bg.bghm =
-				wcqe->total_data_placed;
-		}
-
-		/*
-		* Set ALL the error bits to indicate we don't know what
-		* type of error it is.
-		*/
-		if (!pIocbIn->iocb.unsli3.sli3_bg.bgstat)
-			pIocbIn->iocb.unsli3.sli3_bg.bgstat |=
-				(BGS_REFTAG_ERR_MASK | BGS_APPTAG_ERR_MASK |
-				BGS_GUARD_ERR_MASK);
-	}
-
-	/* Pick up HBA exchange busy condition */
-	if (bf_get(lpfc_wcqe_c_xb, wcqe)) {
-		spin_lock_irqsave(&phba->hbalock, iflags);
-		pIocbIn->cmd_flag |= LPFC_EXCHANGE_BUSY;
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
-	}
-}
-
-/**
- * lpfc_sli4_els_wcqe_to_rspiocbq - Get response iocbq from els wcqe
+ * lpfc_sli4_els_preprocess_rspiocbq - Get response iocbq from els wcqe
  * @phba: Pointer to HBA context object.
  * @irspiocbq: Pointer to work-queue completion queue entry.
  *
@@ -14225,8 +14124,8 @@ lpfc_sli4_iocb_param_transfer(struct lpfc_hba *phba,
  * Return: Pointer to the receive IOCBQ, NULL otherwise.
  **/
 static struct lpfc_iocbq *
-lpfc_sli4_els_wcqe_to_rspiocbq(struct lpfc_hba *phba,
-			       struct lpfc_iocbq *irspiocbq)
+lpfc_sli4_els_preprocess_rspiocbq(struct lpfc_hba *phba,
+				  struct lpfc_iocbq *irspiocbq)
 {
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *cmdiocbq;
@@ -14238,11 +14137,13 @@ lpfc_sli4_els_wcqe_to_rspiocbq(struct lpfc_hba *phba,
 		return NULL;
 
 	wcqe = &irspiocbq->cq_event.cqe.wcqe_cmpl;
+	spin_lock_irqsave(&pring->ring_lock, iflags);
 	pring->stats.iocb_event++;
 	/* Look up the ELS command IOCB and create pseudo response IOCB */
 	cmdiocbq = lpfc_sli_iocbq_lookup_by_tag(phba, pring,
 				bf_get(lpfc_wcqe_c_request_tag, wcqe));
 	if (unlikely(!cmdiocbq)) {
+		spin_unlock_irqrestore(&pring->ring_lock, iflags);
 		lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
 				"0386 ELS complete with no corresponding "
 				"cmdiocb: 0x%x 0x%x 0x%x 0x%x\n",
@@ -14252,13 +14153,18 @@ lpfc_sli4_els_wcqe_to_rspiocbq(struct lpfc_hba *phba,
 		return NULL;
 	}
 
-	spin_lock_irqsave(&pring->ring_lock, iflags);
+	memcpy(&irspiocbq->wqe, &cmdiocbq->wqe, sizeof(union lpfc_wqe128));
+	memcpy(&irspiocbq->wcqe_cmpl, wcqe, sizeof(*wcqe));
+
 	/* Put the iocb back on the txcmplq */
 	lpfc_sli_ringtxcmpl_put(phba, pring, cmdiocbq);
 	spin_unlock_irqrestore(&pring->ring_lock, iflags);
 
-	/* Fake the irspiocbq and copy necessary response information */
-	lpfc_sli4_iocb_param_transfer(phba, irspiocbq, cmdiocbq, wcqe);
+	if (bf_get(lpfc_wcqe_c_xb, wcqe)) {
+		spin_lock_irqsave(&phba->hbalock, iflags);
+		cmdiocbq->cmd_flag |= LPFC_EXCHANGE_BUSY;
+		spin_unlock_irqrestore(&phba->hbalock, iflags);
+	}
 
 	return irspiocbq;
 }
@@ -15084,9 +14990,9 @@ lpfc_sli4_fp_handle_fcp_wcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 	/* Look up the FCP command IOCB and create pseudo response IOCB */
 	spin_lock_irqsave(&pring->ring_lock, iflags);
 	pring->stats.iocb_event++;
-	spin_unlock_irqrestore(&pring->ring_lock, iflags);
 	cmdiocbq = lpfc_sli_iocbq_lookup_by_tag(phba, pring,
 				bf_get(lpfc_wcqe_c_request_tag, wcqe));
+	spin_unlock_irqrestore(&pring->ring_lock, iflags);
 	if (unlikely(!cmdiocbq)) {
 		lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
 				"0374 FCP complete with no corresponding "
@@ -18947,13 +18853,16 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	ctiocb->sli4_lxritag = NO_XRI;
 	ctiocb->sli4_xritag = NO_XRI;
 
-	if (fctl & FC_FC_EX_CTX)
+	if (fctl & FC_FC_EX_CTX) {
 		/* Exchange responder sent the abort so we
 		 * own the oxid.
 		 */
+		ctiocb->abort_bls = LPFC_ABTS_UNSOL_RSP;
 		xri = oxid;
-	else
+	} else {
+		ctiocb->abort_bls = LPFC_ABTS_UNSOL_INT;
 		xri = rxid;
+	}
 	lxri = lpfc_sli4_xri_inrange(phba, xri);
 	if (lxri != NO_XRI)
 		lpfc_set_rrq_active(phba, ndlp, lxri,
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 968c83182643..06682ad8bbe1 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -76,6 +76,8 @@ struct lpfc_iocbq {
 	struct lpfc_wcqe_complete wcqe_cmpl;	/* WQE cmpl */
 
 	uint8_t num_bdes;
+	uint8_t abort_bls;	/* ABTS by initiator or responder */
+
 	uint8_t priority;	/* OAS priority */
 	uint8_t retry;		/* retry counter for IOCB cmd - if needed */
 	u32 cmd_flag;
-- 
2.26.2

