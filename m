Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654FB156EC
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 02:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEGA1j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 20:27:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41102 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGA1i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 May 2019 20:27:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so3595795pgp.8
        for <linux-scsi@vger.kernel.org>; Mon, 06 May 2019 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3lZpawu1Gtmqk2uDXX9IrsYG2a6Lu2AdF5rOlYhglak=;
        b=oCtlsgSyt7wJjru3AROITlrFTxczVcamBMOIqdLakF4fB/fqcdRBvQORCjOSNR789n
         2Y5DCRaY1wnxDXKW9GeK0a70Z+y57iTDAMMyvI6POKMoMFZfouzDbTd9TJ5kfHR5iKzD
         CIiAZwDugrmH4KPSm7t4JNvq9pWSoJOHHKUNKLVokhACb2k6gosHctmtrLgIoi3DmXXr
         78Ph4ZAYYkLY6XTkR5v5PPakPCkB0dazuHHMw5pIk5bIhbBmhKTVg3reO9xJqh6t2RcU
         aFMruO0Z1uv+CIUSLP6BEMuy+8em8hgSEfn7L4h7roN70QTj41zv9Er/kmRvVgwirTYV
         +81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3lZpawu1Gtmqk2uDXX9IrsYG2a6Lu2AdF5rOlYhglak=;
        b=D+xgoDZ4vS9v9SW47KeZndc9JqXUK1KCgikngKcZVCwwiExDv0x+dc4HekySyHNbKf
         +31BBfbEwXlqlxYDWA+msRslX2g89jloiBKGz2RVoIThqgNjl5JcfY/SWYnnmEBbNVf0
         d4rV2mcMXxfnrbIx9mSgE24xW8oweFbE+WFIp7RBTsRcIPZzpdrOZBYjfcmuPMTxp559
         WUg3mS+0aQC74K1EO3KXy0rnOUfhKtj1b0pA93/YSEQXqxGSlHv0wKQNL8ZF2hA9B3Ju
         3puiHuIzboZbDmFCbBtWcmJoN4OMetrwy2t2K3SdWv6oMIz+Ml2zpw9M6vi/G1m/PEcp
         rUXA==
X-Gm-Message-State: APjAAAU4TRGvQz9UcpBkP8a20ltkji/Ebh6jKHJ5XgVFeyN3oraokCp6
        X21KyI4ybKS9X96lAmi5Pf7di/mP
X-Google-Smtp-Source: APXvYqyW4Y0JjjDBb6SY/rZ8mUUSn+G2T0hkNNmjtGec414W4av5V7iqgxon9tswX0Tay/ri+GgE8w==
X-Received: by 2002:a62:160b:: with SMTP id 11mr37091472pfw.88.1557188857764;
        Mon, 06 May 2019 17:27:37 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r8sm14756623pfn.11.2019.05.06.17.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 17:27:37 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/4] lpfc: resolve lockdep warnings
Date:   Mon,  6 May 2019 17:26:47 -0700
Message-Id: <20190507002650.23210-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190507002650.23210-1-jsmart2021@gmail.com>
References: <20190507002650.23210-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There were a number of erroneous comments and incorret older lockdep
checks that were causing a number of warnings.

Resolve the following:
Inconsistent lock state warnings in lpfc_nvme_info_show().
Fixed comments and code on sequences where ring lock is now held
  instead of hbalock.
Reworked calling sequences around lpfc_sli_iocbq_lookup(). Rather
  than locking prior to the routine and have routine guess on what
  lock, take the lock within the routine. The lockdep check becomes
  unnecessary.
Fixed comments and removed erroneous hbalock checks

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Bart Van Assche <bvanassche@acm.org>

---
v2: added fixes for lpfc_sli_iocbq_lookup() calling sequences
---
 drivers/scsi/lpfc/lpfc_attr.c |  5 +--
 drivers/scsi/lpfc/lpfc_sli.c  | 84 +++++++++++++++++++++++++++----------------
 2 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index e9adb3f1961d..31b963ae7289 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -176,6 +176,7 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 	int i;
 	int len = 0;
 	char tmp[LPFC_MAX_NVME_INFO_TMP_LEN] = {0};
+	unsigned long iflags = 0;
 
 	if (!(vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME)) {
 		len = scnprintf(buf, PAGE_SIZE, "NVME Disabled\n");
@@ -374,11 +375,11 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
 		nrport = NULL;
-		spin_lock(&vport->phba->hbalock);
+		spin_lock_irqsave(&vport->phba->hbalock, iflags);
 		rport = lpfc_ndlp_get_nrport(ndlp);
 		if (rport)
 			nrport = rport->remoteport;
-		spin_unlock(&vport->phba->hbalock);
+		spin_unlock_irqrestore(&vport->phba->hbalock, iflags);
 		if (!nrport)
 			continue;
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 2acda188b0dc..d1512e4f9791 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -991,15 +991,14 @@ lpfc_cleanup_vports_rrqs(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
  * @ndlp: Targets nodelist pointer for this exchange.
  * @xritag the xri in the bitmap to test.
  *
- * This function is called with hbalock held. This function
- * returns 0 = rrq not active for this xri
- *         1 = rrq is valid for this xri.
+ * This function returns:
+ * 0 = rrq not active for this xri
+ * 1 = rrq is valid for this xri.
  **/
 int
 lpfc_test_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 			uint16_t  xritag)
 {
-	lockdep_assert_held(&phba->hbalock);
 	if (!ndlp)
 		return 0;
 	if (!ndlp->active_rrqs_xri_bitmap)
@@ -1102,10 +1101,11 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
  * @phba: Pointer to HBA context object.
  * @piocb: Pointer to the iocbq.
  *
- * This function is called with the ring lock held. This function
- * gets a new driver sglq object from the sglq list. If the
- * list is not empty then it is successful, it returns pointer to the newly
- * allocated sglq object else it returns NULL.
+ * The driver calls this function with either the nvme ls ring lock
+ * or the fc els ring lock held depending on the iocb usage.  This function
+ * gets a new driver sglq object from the sglq list. If the list is not empty
+ * then it is successful, it returns pointer to the newly allocated sglq
+ * object else it returns NULL.
  **/
 static struct lpfc_sglq *
 __lpfc_sli_get_els_sglq(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq)
@@ -1115,9 +1115,15 @@ __lpfc_sli_get_els_sglq(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq)
 	struct lpfc_sglq *start_sglq = NULL;
 	struct lpfc_io_buf *lpfc_cmd;
 	struct lpfc_nodelist *ndlp;
+	struct lpfc_sli_ring *pring = NULL;
 	int found = 0;
 
-	lockdep_assert_held(&phba->hbalock);
+	if (piocbq->iocb_flag & LPFC_IO_NVME_LS)
+		pring =  phba->sli4_hba.nvmels_wq->pring;
+	else
+		pring = lpfc_phba_elsring(phba);
+
+	lockdep_assert_held(&pring->ring_lock);
 
 	if (piocbq->iocb_flag &  LPFC_IO_FCP) {
 		lpfc_cmd = (struct lpfc_io_buf *) piocbq->context1;
@@ -1560,7 +1566,8 @@ lpfc_sli_ring_map(struct lpfc_hba *phba)
  * @pring: Pointer to driver SLI ring object.
  * @piocb: Pointer to the driver iocb object.
  *
- * This function is called with hbalock held. The function adds the
+ * The driver calls this function with the hbalock held for SLI3 ports or
+ * the ring lock held for SLI4 ports. The function adds the
  * new iocb to txcmplq of the given ring. This function always returns
  * 0. If this function is called for ELS ring, this function checks if
  * there is a vport associated with the ELS command. This function also
@@ -1570,7 +1577,10 @@ static int
 lpfc_sli_ringtxcmpl_put(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			struct lpfc_iocbq *piocb)
 {
-	lockdep_assert_held(&phba->hbalock);
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		lockdep_assert_held(&pring->ring_lock);
+	else
+		lockdep_assert_held(&phba->hbalock);
 
 	BUG_ON(!piocb);
 
@@ -2967,8 +2977,8 @@ lpfc_sli_process_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
  *
  * This function looks up the iocb_lookup table to get the command iocb
  * corresponding to the given response iocb using the iotag of the
- * response iocb. This function is called with the hbalock held
- * for sli3 devices or the ring_lock for sli4 devices.
+ * response iocb. The driver calls this function with the hbalock held
+ * for SLI3 ports or the ring lock held for SLI4 ports.
  * This function returns the command iocb object if it finds the command
  * iocb else returns NULL.
  **/
@@ -2979,8 +2989,15 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
 {
 	struct lpfc_iocbq *cmd_iocb = NULL;
 	uint16_t iotag;
-	lockdep_assert_held(&phba->hbalock);
+	spinlock_t *temp_lock = NULL;
+	unsigned long iflag = 0;
 
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		temp_lock = &pring->ring_lock;
+	else
+		temp_lock = &phba->hbalock;
+
+	spin_lock_irqsave(temp_lock, iflag);
 	iotag = prspiocb->iocb.ulpIoTag;
 
 	if (iotag != 0 && iotag <= phba->sli.last_iotag) {
@@ -2990,10 +3007,12 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
 			list_del_init(&cmd_iocb->list);
 			cmd_iocb->iocb_flag &= ~LPFC_IO_ON_TXCMPLQ;
 			pring->txcmplq_cnt--;
+			spin_unlock_irqrestore(temp_lock, iflag);
 			return cmd_iocb;
 		}
 	}
 
+	spin_unlock_irqrestore(temp_lock, iflag);
 	lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 			"0317 iotag x%x is out of "
 			"range: max iotag x%x wd0 x%x\n",
@@ -3009,8 +3028,8 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
  * @iotag: IOCB tag.
  *
  * This function looks up the iocb_lookup table to get the command iocb
- * corresponding to the given iotag. This function is called with the
- * hbalock held.
+ * corresponding to the given iotag. The driver calls this function with
+ * the ring lock held because this function is an SLI4 port only helper.
  * This function returns the command iocb object if it finds the command
  * iocb else returns NULL.
  **/
@@ -3019,8 +3038,15 @@ lpfc_sli_iocbq_lookup_by_tag(struct lpfc_hba *phba,
 			     struct lpfc_sli_ring *pring, uint16_t iotag)
 {
 	struct lpfc_iocbq *cmd_iocb = NULL;
+	spinlock_t *temp_lock = NULL;
+	unsigned long iflag = 0;
 
-	lockdep_assert_held(&phba->hbalock);
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		temp_lock = &pring->ring_lock;
+	else
+		temp_lock = &phba->hbalock;
+
+	spin_lock_irqsave(temp_lock, iflag);
 	if (iotag != 0 && iotag <= phba->sli.last_iotag) {
 		cmd_iocb = phba->sli.iocbq_lookup[iotag];
 		if (cmd_iocb->iocb_flag & LPFC_IO_ON_TXCMPLQ) {
@@ -3028,10 +3054,12 @@ lpfc_sli_iocbq_lookup_by_tag(struct lpfc_hba *phba,
 			list_del_init(&cmd_iocb->list);
 			cmd_iocb->iocb_flag &= ~LPFC_IO_ON_TXCMPLQ;
 			pring->txcmplq_cnt--;
+			spin_unlock_irqrestore(temp_lock, iflag);
 			return cmd_iocb;
 		}
 	}
 
+	spin_unlock_irqrestore(temp_lock, iflag);
 	lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 			"0372 iotag x%x lookup error: max iotag (x%x) "
 			"iocb_flag x%x\n",
@@ -3065,17 +3093,7 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	int rc = 1;
 	unsigned long iflag;
 
-	/* Based on the iotag field, get the cmd IOCB from the txcmplq */
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		spin_lock_irqsave(&pring->ring_lock, iflag);
-	else
-		spin_lock_irqsave(&phba->hbalock, iflag);
 	cmdiocbp = lpfc_sli_iocbq_lookup(phba, pring, saveq);
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		spin_unlock_irqrestore(&pring->ring_lock, iflag);
-	else
-		spin_unlock_irqrestore(&phba->hbalock, iflag);
-
 	if (cmdiocbp) {
 		if (cmdiocbp->iocb_cmpl) {
 			/*
@@ -3406,8 +3424,10 @@ lpfc_sli_handle_fast_ring_event(struct lpfc_hba *phba,
 				break;
 			}
 
+			spin_unlock_irqrestore(&phba->hbalock, iflag);
 			cmdiocbq = lpfc_sli_iocbq_lookup(phba, pring,
 							 &rspiocbq);
+			spin_lock_irqsave(&phba->hbalock, iflag);
 			if (unlikely(!cmdiocbq))
 				break;
 			if (cmdiocbq->iocb_flag & LPFC_DRIVER_ABORTED)
@@ -3601,9 +3621,12 @@ lpfc_sli_sp_handle_rspiocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 		case LPFC_ABORT_IOCB:
 			cmdiocbp = NULL;
-			if (irsp->ulpCommand != CMD_XRI_ABORTED_CX)
+			if (irsp->ulpCommand != CMD_XRI_ABORTED_CX) {
+				spin_unlock_irqrestore(&phba->hbalock, iflag);
 				cmdiocbp = lpfc_sli_iocbq_lookup(phba, pring,
 								 saveq);
+				spin_lock_irqsave(&phba->hbalock, iflag);
+			}
 			if (cmdiocbp) {
 				/* Call the specified completion routine */
 				if (cmdiocbp->iocb_cmpl) {
@@ -12976,13 +12999,11 @@ lpfc_sli4_els_wcqe_to_rspiocbq(struct lpfc_hba *phba,
 		return NULL;
 
 	wcqe = &irspiocbq->cq_event.cqe.wcqe_cmpl;
-	spin_lock_irqsave(&pring->ring_lock, iflags);
 	pring->stats.iocb_event++;
 	/* Look up the ELS command IOCB and create pseudo response IOCB */
 	cmdiocbq = lpfc_sli_iocbq_lookup_by_tag(phba, pring,
 				bf_get(lpfc_wcqe_c_request_tag, wcqe));
 	if (unlikely(!cmdiocbq)) {
-		spin_unlock_irqrestore(&pring->ring_lock, iflags);
 		lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
 				"0386 ELS complete with no corresponding "
 				"cmdiocb: 0x%x 0x%x 0x%x 0x%x\n",
@@ -12992,6 +13013,7 @@ lpfc_sli4_els_wcqe_to_rspiocbq(struct lpfc_hba *phba,
 		return NULL;
 	}
 
+	spin_lock_irqsave(&pring->ring_lock, iflags);
 	/* Put the iocb back on the txcmplq */
 	lpfc_sli_ringtxcmpl_put(phba, pring, cmdiocbq);
 	spin_unlock_irqrestore(&pring->ring_lock, iflags);
@@ -13762,9 +13784,9 @@ lpfc_sli4_fp_handle_fcp_wcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 	/* Look up the FCP command IOCB and create pseudo response IOCB */
 	spin_lock_irqsave(&pring->ring_lock, iflags);
 	pring->stats.iocb_event++;
+	spin_unlock_irqrestore(&pring->ring_lock, iflags);
 	cmdiocbq = lpfc_sli_iocbq_lookup_by_tag(phba, pring,
 				bf_get(lpfc_wcqe_c_request_tag, wcqe));
-	spin_unlock_irqrestore(&pring->ring_lock, iflags);
 	if (unlikely(!cmdiocbq)) {
 		lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
 				"0374 FCP complete with no corresponding "
-- 
2.13.7

