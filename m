Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03C10C83
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 19:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEAR7l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 13:59:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34306 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEAR7k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 13:59:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck18so4209242plb.1
        for <linux-scsi@vger.kernel.org>; Wed, 01 May 2019 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8G7tKbqgbwDIvr9iL2IvNg23SaE1gsdwnRJ588ACO0=;
        b=Px30DUM4Mc3+YpQj64+xRqMyn8l8IPXxGyfKTlPY6OzG8sQHsW3VMDIJY32ecvJ1hX
         C7kmFCnUYd93X8GD2Z1Jmyua70rLolD8LT4FBxjdBeeuUCANHJL59D6ARY1Lf7elkmdv
         oRJ8/sY0IB9qy0Z9oZePyKrrs4U/5h6zssWlH9mZgHzn4hQZS82r9g81K14G+PHubw9x
         DB2KuHhiYMjhM/jPHHbyDOpPOAI/cIUzMDSh9AwkbRFh4/g0TyDQrMaJLp7y2Ni+mseM
         8o3Tm+4lRTJYNfIZeuXygcb12xNJ5KekpW7SG5Z6aIXvcfoEcTf/7QTQR9GrFwQ+nN/N
         KnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z8G7tKbqgbwDIvr9iL2IvNg23SaE1gsdwnRJ588ACO0=;
        b=PWPmJEIOFJWEXIsz/vyNgTHkJMUZLHq8bzqiIqG2GR0UZ+7PS1cYuHOvAdvAIwHEcE
         ptseEwB57MNUmIJ+4FoN//z96PlfAvnAjycH7cc5lDKfN+sY5gL4Jt9hMgALhYwAhSeY
         70SmRiTcUk/T4xBEfgXQ0fQCGjwYfCZi8laBANCN8UBdbqN/+/GqaqP96opQdfaF5/is
         8zLMNsZJC8SCBVs2wM/cnn8wbL8c/l0fPc2I2dbO3UylYYokg4FwlGY9uRIZMDZZH2S6
         5OOU0jzMHrcfEfhaf6AsR2c8XfZCOwvZsQ0g+FkQ4sUvJak+WEhlSzTdUhbCVGSDQZyk
         Ws8A==
X-Gm-Message-State: APjAAAVY7e3rR1jTpFbdcL1bI96FaCKf3PzJ8nkDIYBV+8esBOwcBGwm
        Y5uyonevjwKHCHw8jU6kIVv6FusA
X-Google-Smtp-Source: APXvYqykBlbUm8izNLaVc1yk/OeLMuTb8+yXblA3fOI4ULbXOvE3ZkodikhtP4Ue+efkFGXiIbY/KQ==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr79705359pla.311.1556733579936;
        Wed, 01 May 2019 10:59:39 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z7sm72906679pgh.81.2019.05.01.10.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:59:39 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/4] lpfc: resolve lockdep warnings
Date:   Wed,  1 May 2019 10:59:23 -0700
Message-Id: <20190501175926.4551-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190501175926.4551-1-jsmart2021@gmail.com>
References: <20190501175926.4551-1-jsmart2021@gmail.com>
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
Fixed comments and removed erroneous hbalock checks

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/lpfc/lpfc_attr.c |  5 +++--
 drivers/scsi/lpfc/lpfc_sli.c  | 48 ++++++++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 19 deletions(-)

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
index 2acda188b0dc..06d1c183266e 100644
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
@@ -2979,7 +2989,11 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
 {
 	struct lpfc_iocbq *cmd_iocb = NULL;
 	uint16_t iotag;
-	lockdep_assert_held(&phba->hbalock);
+
+	if (phba->sli_rev == LPFC_SLI_REV4)
+		lockdep_assert_held(&pring->ring_lock);
+	else
+		lockdep_assert_held(&phba->hbalock);
 
 	iotag = prspiocb->iocb.ulpIoTag;
 
@@ -3009,8 +3023,8 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
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
@@ -3020,7 +3034,7 @@ lpfc_sli_iocbq_lookup_by_tag(struct lpfc_hba *phba,
 {
 	struct lpfc_iocbq *cmd_iocb = NULL;
 
-	lockdep_assert_held(&phba->hbalock);
+	lockdep_assert_held(&pring->ring_lock);
 	if (iotag != 0 && iotag <= phba->sli.last_iotag) {
 		cmd_iocb = phba->sli.iocbq_lookup[iotag];
 		if (cmd_iocb->iocb_flag & LPFC_IO_ON_TXCMPLQ) {
-- 
2.13.7

