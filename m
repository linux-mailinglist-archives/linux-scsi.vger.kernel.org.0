Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C125B52
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfEVAth (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39616 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfEVAtg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id z26so343819pfg.6
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AB2LPDeIKZ9AUorIfwFGUJw/j2iW9D3eupoHtt/9gyU=;
        b=fpHp18ANP+uGKdaMYf/xDZy0pxrkLS4eADh5CAmgXPccSlWuURBqmSf1RY09dJghUf
         vIFd10kg1YBfDTWfyW25JdDsAnGNi5Ulk8VKQx3W/DXFgFd5LYsGS/z8i62XUc190mBw
         K1AmvtrK8gAekd847kGeYexCOXLTh5UiMNydZVXG9Gq+zZwc9bnHv2S/YqoszPAoqFex
         s4HRdt6exQtr+jAtgXi9D8UlKGaifNyHzKauDsf6w3L3n61X5rNd2xm6JdCKCE5HwLts
         oLlMJ4UCVG2qj/MUrgYkQOtUqwCR+4B3sPA+iuEhuXSGxS3rcTvP+Z5V/PNqh4YqoeF0
         pQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AB2LPDeIKZ9AUorIfwFGUJw/j2iW9D3eupoHtt/9gyU=;
        b=X2yTJHrPvKVMzR+3iI49qseLfTA1MCODqAm8seRFaOBM3af8XkNfALKZUz3mZpVhTY
         s0IPnePNuq4Qu/GWmgLM8+OkDdZfNQShbLc+5qCqeRhzbOhqHQ8ozgQZ8xodcCh64ekv
         TV/dVHbMWs+1oLrz6jqBjcKf22VLJVdH4D6lNjj56fkO2GXPrEkH3QklCfYOPQxKJT/n
         cfPHJLET1m0A7Gw37AniFJMXSP+dmX+r1dQOCLiT3kOE+tIRid+uGb4LadQsGZiT0HnQ
         w5dJq4wKe0D9K8du2xt+LPbcP/jDlyTR5CyRilUMP61L8DPza41J7I+dKzIKfcUcw5Uj
         izug==
X-Gm-Message-State: APjAAAV9vduGHp3E0BgxzsU6HjgJ9vTjGHNVc7IqAyglPmKCeSgcaCbF
        WT24f2BpjTt94G1rytS+KzyHSEIy
X-Google-Smtp-Source: APXvYqxbODzZ5YLs1OcUtucXDNB6mNP11ii+F9FfruK/7WyKTPk8ErEXDZ2rOvqWzFgqSZIrWeOptA==
X-Received: by 2002:a62:d286:: with SMTP id c128mr92664650pfg.159.1558486174716;
        Tue, 21 May 2019 17:49:34 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:34 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 16/21] lpfc: Fix poor use of hardware queues if fewer irq vectors
Date:   Tue, 21 May 2019 17:49:06 -0700
Message-Id: <20190522004911.573-17-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

While fixing the resources per socket, realized the driver was not
using hardware queues (up to 1 per cpu) if there were fewer
interrupt vectors. The driver was only using the hardware queue
assigned to the cpu with the vector.

Rework the affinity map check to use the additional hardware
queue elements that had been allocated.  If the cpu count exceeds
the hardware queue count - share, but choose what is shared with
by: hyperthread peer, core peer, socket peer, or finally similar
cpu in a different socket.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_attr.c |   3 +-
 drivers/scsi/lpfc/lpfc_init.c | 321 +++++++++++++++++++++++++++++-------------
 drivers/scsi/lpfc/lpfc_sli.c  |  42 +++---
 drivers/scsi/lpfc/lpfc_sli4.h |   2 +
 4 files changed, 255 insertions(+), 113 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 58f26e5f3a59..065c526218b2 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5115,7 +5115,8 @@ lpfc_cq_max_proc_limit_store(struct device *dev, struct device_attribute *attr,
 
 	/* set the values on the cq's */
 	for (i = 0; i < phba->cfg_irq_chann; i++) {
-		eq = phba->sli4_hba.hdwq[i].hba_eq;
+		/* Get the EQ corresponding to the IRQ vector */
+		eq = phba->sli4_hba.hba_eq_hdl[i].eq;
 		if (!eq)
 			continue;
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 021b01561597..416f0fb155f5 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -93,7 +93,6 @@ static void lpfc_sli4_cq_event_release_all(struct lpfc_hba *);
 static void lpfc_sli4_disable_intr(struct lpfc_hba *);
 static uint32_t lpfc_sli4_enable_intr(struct lpfc_hba *, uint32_t);
 static void lpfc_sli4_oas_verify(struct lpfc_hba *phba);
-static uint16_t lpfc_find_eq_handle(struct lpfc_hba *, uint16_t);
 static uint16_t lpfc_find_cpu_handle(struct lpfc_hba *, uint16_t, int);
 
 static struct scsi_transport_template *lpfc_transport_template = NULL;
@@ -1274,8 +1273,10 @@ lpfc_hb_eq_delay_work(struct work_struct *work)
 	if (!eqcnt)
 		goto requeue;
 
+	/* Loop thru all IRQ vectors */
 	for (i = 0; i < phba->cfg_irq_chann; i++) {
-		eq = phba->sli4_hba.hdwq[i].hba_eq;
+		/* Get the EQ corresponding to the IRQ vector */
+		eq = phba->sli4_hba.hba_eq_hdl[i].eq;
 		if (eq && eqcnt[eq->last_cpu] < 2)
 			eqcnt[eq->last_cpu]++;
 		continue;
@@ -8748,8 +8749,10 @@ int
 lpfc_sli4_queue_create(struct lpfc_hba *phba)
 {
 	struct lpfc_queue *qdesc;
-	int idx, eqidx, cpu;
+	int idx, cpu, eqcpu;
 	struct lpfc_sli4_hdw_queue *qp;
+	struct lpfc_vector_map_info *cpup;
+	struct lpfc_vector_map_info *eqcpup;
 	struct lpfc_eq_intr_info *eqi;
 
 	/*
@@ -8834,40 +8837,60 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 	INIT_LIST_HEAD(&phba->sli4_hba.lpfc_wq_list);
 
 	/* Create HBA Event Queues (EQs) */
-	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
-		/* determine EQ affinity */
-		eqidx = lpfc_find_eq_handle(phba, idx);
-		cpu = lpfc_find_cpu_handle(phba, eqidx, LPFC_FIND_BY_EQ);
-		/*
-		 * If there are more Hardware Queues than available
-		 * EQs, multiple Hardware Queues may share a common EQ.
+	for_each_present_cpu(cpu) {
+		/* We only want to create 1 EQ per vector, even though
+		 * multiple CPUs might be using that vector. so only
+		 * selects the CPUs that are LPFC_CPU_FIRST_IRQ.
 		 */
-		if (idx >= phba->cfg_irq_chann) {
-			/* Share an existing EQ */
-			phba->sli4_hba.hdwq[idx].hba_eq =
-				phba->sli4_hba.hdwq[eqidx].hba_eq;
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+		if (!(cpup->flag & LPFC_CPU_FIRST_IRQ))
 			continue;
-		}
-		/* Create an EQ */
+
+		/* Get a ptr to the Hardware Queue associated with this CPU */
+		qp = &phba->sli4_hba.hdwq[cpup->hdwq];
+
+		/* Allocate an EQ */
 		qdesc = lpfc_sli4_queue_alloc(phba, LPFC_DEFAULT_PAGE_SIZE,
 					      phba->sli4_hba.eq_esize,
 					      phba->sli4_hba.eq_ecount, cpu);
 		if (!qdesc) {
 			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-					"0497 Failed allocate EQ (%d)\n", idx);
+					"0497 Failed allocate EQ (%d)\n",
+					cpup->hdwq);
 			goto out_error;
 		}
 		qdesc->qe_valid = 1;
-		qdesc->hdwq = idx;
-
-		/* Save the CPU this EQ is affinitised to */
-		qdesc->chann = cpu;
-		phba->sli4_hba.hdwq[idx].hba_eq = qdesc;
+		qdesc->hdwq = cpup->hdwq;
+		qdesc->chann = cpu; /* First CPU this EQ is affinitised to */
 		qdesc->last_cpu = qdesc->chann;
+
+		/* Save the allocated EQ in the Hardware Queue */
+		qp->hba_eq = qdesc;
+
 		eqi = per_cpu_ptr(phba->sli4_hba.eq_info, qdesc->last_cpu);
 		list_add(&qdesc->cpu_list, &eqi->list);
 	}
 
+	/* Now we need to populate the other Hardware Queues, that share
+	 * an IRQ vector, with the associated EQ ptr.
+	 */
+	for_each_present_cpu(cpu) {
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+
+		/* Check for EQ already allocated in previous loop */
+		if (cpup->flag & LPFC_CPU_FIRST_IRQ)
+			continue;
+
+		/* Check for multiple CPUs per hdwq */
+		qp = &phba->sli4_hba.hdwq[cpup->hdwq];
+		if (qp->hba_eq)
+			continue;
+
+		/* We need to share an EQ for this hdwq */
+		eqcpu = lpfc_find_cpu_handle(phba, cpup->eq, LPFC_FIND_BY_EQ);
+		eqcpup = &phba->sli4_hba.cpu_map[eqcpu];
+		qp->hba_eq = phba->sli4_hba.hdwq[eqcpup->hdwq].hba_eq;
+	}
 
 	/* Allocate SCSI SLI4 CQ/WQs */
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
@@ -9130,23 +9153,31 @@ static inline void
 lpfc_sli4_release_hdwq(struct lpfc_hba *phba)
 {
 	struct lpfc_sli4_hdw_queue *hdwq;
+	struct lpfc_queue *eq;
 	uint32_t idx;
 
 	hdwq = phba->sli4_hba.hdwq;
-	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
-		if (idx < phba->cfg_irq_chann)
-			lpfc_sli4_queue_free(hdwq[idx].hba_eq);
-		hdwq[idx].hba_eq = NULL;
 
+	/* Loop thru all Hardware Queues */
+	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
+		/* Free the CQ/WQ corresponding to the Hardware Queue */
 		lpfc_sli4_queue_free(hdwq[idx].fcp_cq);
 		lpfc_sli4_queue_free(hdwq[idx].nvme_cq);
 		lpfc_sli4_queue_free(hdwq[idx].fcp_wq);
 		lpfc_sli4_queue_free(hdwq[idx].nvme_wq);
+		hdwq[idx].hba_eq = NULL;
 		hdwq[idx].fcp_cq = NULL;
 		hdwq[idx].nvme_cq = NULL;
 		hdwq[idx].fcp_wq = NULL;
 		hdwq[idx].nvme_wq = NULL;
 	}
+	/* Loop thru all IRQ vectors */
+	for (idx = 0; idx < phba->cfg_irq_chann; idx++) {
+		/* Free the EQ corresponding to the IRQ vector */
+		eq = phba->sli4_hba.hba_eq_hdl[idx].eq;
+		lpfc_sli4_queue_free(eq);
+		phba->sli4_hba.hba_eq_hdl[idx].eq = NULL;
+	}
 }
 
 /**
@@ -9330,10 +9361,13 @@ lpfc_setup_cq_lookup(struct lpfc_hba *phba)
 	qp = phba->sli4_hba.hdwq;
 	memset(phba->sli4_hba.cq_lookup, 0,
 	       (sizeof(struct lpfc_queue *) * (phba->sli4_hba.cq_max + 1)));
+	/* Loop thru all IRQ vectors */
 	for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
-		eq = qp[qidx].hba_eq;
+		/* Get the EQ corresponding to the IRQ vector */
+		eq = phba->sli4_hba.hba_eq_hdl[qidx].eq;
 		if (!eq)
 			continue;
+		/* Loop through all CQs associated with that EQ */
 		list_for_each_entry(childq, &eq->child_list, list) {
 			if (childq->queue_id > phba->sli4_hba.cq_max)
 				continue;
@@ -9362,9 +9396,10 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 {
 	uint32_t shdr_status, shdr_add_status;
 	union lpfc_sli4_cfg_shdr *shdr;
+	struct lpfc_vector_map_info *cpup;
 	struct lpfc_sli4_hdw_queue *qp;
 	LPFC_MBOXQ_t *mboxq;
-	int qidx;
+	int qidx, cpu;
 	uint32_t length, usdelay;
 	int rc = -ENOMEM;
 
@@ -9425,32 +9460,55 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 		rc = -ENOMEM;
 		goto out_error;
 	}
+
+	/* Loop thru all IRQ vectors */
 	for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
-		if (!qp[qidx].hba_eq) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-					"0522 Fast-path EQ (%d) not "
-					"allocated\n", qidx);
-			rc = -ENOMEM;
-			goto out_destroy;
-		}
-		rc = lpfc_eq_create(phba, qp[qidx].hba_eq,
-				    phba->cfg_fcp_imax);
-		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-					"0523 Failed setup of fast-path EQ "
-					"(%d), rc = 0x%x\n", qidx,
-					(uint32_t)rc);
-			goto out_destroy;
+		/* Create HBA Event Queues (EQs) in order */
+		for_each_present_cpu(cpu) {
+			cpup = &phba->sli4_hba.cpu_map[cpu];
+
+			/* Look for the CPU thats using that vector with
+			 * LPFC_CPU_FIRST_IRQ set.
+			 */
+			if (!(cpup->flag & LPFC_CPU_FIRST_IRQ))
+				continue;
+			if (qidx != cpup->eq)
+				continue;
+
+			/* Create an EQ for that vector */
+			rc = lpfc_eq_create(phba, qp[cpup->hdwq].hba_eq,
+					    phba->cfg_fcp_imax);
+			if (rc) {
+				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+						"0523 Failed setup of fast-path"
+						" EQ (%d), rc = 0x%x\n",
+						cpup->eq, (uint32_t)rc);
+				goto out_destroy;
+			}
+
+			/* Save the EQ for that vector in the hba_eq_hdl */
+			phba->sli4_hba.hba_eq_hdl[cpup->eq].eq =
+				qp[cpup->hdwq].hba_eq;
+
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
+					"2584 HBA EQ setup: queue[%d]-id=%d\n",
+					cpup->eq,
+					qp[cpup->hdwq].hba_eq->queue_id);
 		}
-		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-				"2584 HBA EQ setup: queue[%d]-id=%d\n", qidx,
-				qp[qidx].hba_eq->queue_id);
 	}
 
+	/* Loop thru all Hardware Queues */
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
+			cpu = lpfc_find_cpu_handle(phba, qidx,
+						   LPFC_FIND_BY_HDWQ);
+			cpup = &phba->sli4_hba.cpu_map[cpu];
+
+			/* Create the CQ/WQ corresponding to the
+			 * Hardware Queue
+			 */
 			rc = lpfc_create_wq_cq(phba,
-					qp[qidx].hba_eq,
+					phba->sli4_hba.hdwq[cpup->hdwq].hba_eq,
 					qp[qidx].nvme_cq,
 					qp[qidx].nvme_wq,
 					&phba->sli4_hba.hdwq[qidx].nvme_cq_map,
@@ -9466,8 +9524,12 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	}
 
 	for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
+		cpu = lpfc_find_cpu_handle(phba, qidx, LPFC_FIND_BY_HDWQ);
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+
+		/* Create the CQ/WQ corresponding to the Hardware Queue */
 		rc = lpfc_create_wq_cq(phba,
-				       qp[qidx].hba_eq,
+				       phba->sli4_hba.hdwq[cpup->hdwq].hba_eq,
 				       qp[qidx].fcp_cq,
 				       qp[qidx].fcp_wq,
 				       &phba->sli4_hba.hdwq[qidx].fcp_cq_map,
@@ -9719,6 +9781,7 @@ void
 lpfc_sli4_queue_unset(struct lpfc_hba *phba)
 {
 	struct lpfc_sli4_hdw_queue *qp;
+	struct lpfc_queue *eq;
 	int qidx;
 
 	/* Unset mailbox command work queue */
@@ -9770,14 +9833,20 @@ lpfc_sli4_queue_unset(struct lpfc_hba *phba)
 
 	/* Unset fast-path SLI4 queues */
 	if (phba->sli4_hba.hdwq) {
+		/* Loop thru all Hardware Queues */
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
+			/* Destroy the CQ/WQ corresponding to Hardware Queue */
 			qp = &phba->sli4_hba.hdwq[qidx];
 			lpfc_wq_destroy(phba, qp->fcp_wq);
 			lpfc_wq_destroy(phba, qp->nvme_wq);
 			lpfc_cq_destroy(phba, qp->fcp_cq);
 			lpfc_cq_destroy(phba, qp->nvme_cq);
-			if (qidx < phba->cfg_irq_chann)
-				lpfc_eq_destroy(phba, qp->hba_eq);
+		}
+		/* Loop thru all IRQ vectors */
+		for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
+			/* Destroy the EQ corresponding to the IRQ vector */
+			eq = phba->sli4_hba.hba_eq_hdl[qidx].eq;
+			lpfc_eq_destroy(phba, eq);
 		}
 	}
 
@@ -10567,11 +10636,12 @@ lpfc_sli_disable_intr(struct lpfc_hba *phba)
 }
 
 /**
- * lpfc_find_cpu_handle - Find the CPU that corresponds to the specified EQ
+ * lpfc_find_cpu_handle - Find the CPU that corresponds to the specified Queue
  * @phba: pointer to lpfc hba data structure.
  * @id: EQ vector index or Hardware Queue index
  * @match: LPFC_FIND_BY_EQ = match by EQ
  *         LPFC_FIND_BY_HDWQ = match by Hardware Queue
+ * Return the CPU that matches the selection criteria
  */
 static uint16_t
 lpfc_find_cpu_handle(struct lpfc_hba *phba, uint16_t id, int match)
@@ -10579,40 +10649,27 @@ lpfc_find_cpu_handle(struct lpfc_hba *phba, uint16_t id, int match)
 	struct lpfc_vector_map_info *cpup;
 	int cpu;
 
-	/* Find the desired phys_id for the specified EQ */
+	/* Loop through all CPUs */
 	for_each_present_cpu(cpu) {
 		cpup = &phba->sli4_hba.cpu_map[cpu];
+
+		/* If we are matching by EQ, there may be multiple CPUs using
+		 * using the same vector, so select the one with
+		 * LPFC_CPU_FIRST_IRQ set.
+		 */
 		if ((match == LPFC_FIND_BY_EQ) &&
+		    (cpup->flag & LPFC_CPU_FIRST_IRQ) &&
 		    (cpup->irq != LPFC_VECTOR_MAP_EMPTY) &&
 		    (cpup->eq == id))
 			return cpu;
+
+		/* If matching by HDWQ, select the first CPU that matches */
 		if ((match == LPFC_FIND_BY_HDWQ) && (cpup->hdwq == id))
 			return cpu;
 	}
 	return 0;
 }
 
-/**
- * lpfc_find_eq_handle - Find the EQ that corresponds to the specified
- *                       Hardware Queue
- * @phba: pointer to lpfc hba data structure.
- * @hdwq: Hardware Queue index
- */
-static uint16_t
-lpfc_find_eq_handle(struct lpfc_hba *phba, uint16_t hdwq)
-{
-	struct lpfc_vector_map_info *cpup;
-	int cpu;
-
-	/* Find the desired phys_id for the specified EQ */
-	for_each_present_cpu(cpu) {
-		cpup = &phba->sli4_hba.cpu_map[cpu];
-		if (cpup->hdwq == hdwq)
-			return cpup->eq;
-	}
-	return 0;
-}
-
 #ifdef CONFIG_X86
 /**
  * lpfc_find_hyper - Determine if the CPU map entry is hyper-threaded
@@ -10719,32 +10776,40 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 
 	/* This loop sets up all CPUs that are affinitized with a
 	 * irq vector assigned to the driver. All affinitized CPUs
-	 * will get a link to that vectors IRQ and EQ. For now we
-	 * are assuming all CPUs using the same EQ will all share
-	 * the same hardware queue.
+	 * will get a link to that vectors IRQ and EQ.
 	 */
 	for (idx = 0; idx <  phba->cfg_irq_chann; idx++) {
+		/* Get a CPU mask for all CPUs affinitized to this vector */
 		maskp = pci_irq_get_affinity(phba->pcidev, idx);
 		if (!maskp)
 			continue;
 
+		i = 0;
+		/* Loop through all CPUs associated with vector idx */
 		for_each_cpu_and(cpu, maskp, cpu_present_mask) {
+			/* Set the EQ index and IRQ for that vector */
 			cpup = &phba->sli4_hba.cpu_map[cpu];
 			cpup->eq = idx;
-			cpup->hdwq = idx;
 			cpup->irq = pci_irq_vector(phba->pcidev, idx);
 
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 					"3336 Set Affinity: CPU %d "
-					"hdwq %d irq %d\n",
-					cpu, cpup->hdwq, cpup->irq);
+					"irq %d eq %d\n",
+					cpu, cpup->irq, cpup->eq);
+
+			/* If this is the first CPU thats assigned to this
+			 * vector, set LPFC_CPU_FIRST_IRQ.
+			 */
+			if (!i)
+				cpup->flag |= LPFC_CPU_FIRST_IRQ;
+			i++;
 		}
 	}
 
 	/* After looking at each irq vector assigned to this pcidev, its
 	 * possible to see that not ALL CPUs have been accounted for.
-	 * Next we will set any unassigned cpu map entries to a IRQ
-	 * on the same phys_id
+	 * Next we will set any unassigned (unaffinitized) cpu map
+	 * entries to a IRQ on the same phys_id.
 	 */
 	first_cpu = cpumask_first(cpu_present_mask);
 	start_cpu = first_cpu;
@@ -10757,7 +10822,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			/* Mark CPU as IRQ not assigned by the kernel */
 			cpup->flag |= LPFC_CPU_MAP_UNASSIGN;
 
-			/* If so, find a new_cpup thats on the the same
+			/* If so, find a new_cpup thats on the the SAME
 			 * phys_id as cpup. start_cpu will start where we
 			 * left off so all unassigned entries don't get assgined
 			 * the IRQ of the first entry.
@@ -10779,7 +10844,6 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 found_same:
 			/* We found a matching phys_id, so copy the IRQ info */
 			cpup->eq = new_cpup->eq;
-			cpup->hdwq = new_cpup->hdwq;
 			cpup->irq = new_cpup->irq;
 
 			/* Bump start_cpu to the next slot to minmize the
@@ -10790,12 +10854,11 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			if (start_cpu == nr_cpumask_bits)
 				start_cpu = first_cpu;
 
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 					"3337 Set Affinity: CPU %d "
-					"hdwq %d irq %d from id %d same "
+					"irq %d from id %d same "
 					"phys_id (%d)\n",
-					cpu, cpup->hdwq, cpup->irq,
-					new_cpu, cpup->phys_id);
+					cpu, cpup->irq, new_cpu, cpup->phys_id);
 		}
 	}
 
@@ -10810,7 +10873,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			/* Mark it as IRQ not assigned by the kernel */
 			cpup->flag |= LPFC_CPU_MAP_UNASSIGN;
 
-			/* If so, find a new_cpup thats on any phys_id
+			/* If so, find a new_cpup thats on ANY phys_id
 			 * as the cpup. start_cpu will start where we
 			 * left off so all unassigned entries don't get
 			 * assigned the IRQ of the first entry.
@@ -10829,13 +10892,12 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			/* We should never leave an entry unassigned */
 			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 					"3339 Set Affinity: CPU %d "
-					"hdwq %d irq %d UNASSIGNED\n",
-					cpu, cpup->hdwq, cpup->irq);
+					"irq %d UNASSIGNED\n",
+					cpup->hdwq, cpup->irq);
 			continue;
 found_any:
 			/* We found an available entry, copy the IRQ info */
 			cpup->eq = new_cpup->eq;
-			cpup->hdwq = new_cpup->hdwq;
 			cpup->irq = new_cpup->irq;
 
 			/* Bump start_cpu to the next slot to minmize the
@@ -10846,13 +10908,82 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			if (start_cpu == nr_cpumask_bits)
 				start_cpu = first_cpu;
 
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 					"3338 Set Affinity: CPU %d "
-					"hdwq %d irq %d from id %d (%d/%d)\n",
-					cpu, cpup->hdwq, cpup->irq, new_cpu,
+					"irq %d from id %d (%d/%d)\n",
+					cpu, cpup->irq, new_cpu,
 					new_cpup->phys_id, new_cpup->core_id);
 		}
 	}
+
+	/* Finally we need to associate a hdwq with each cpu_map entry
+	 * This will be 1 to 1 - hdwq to cpu, unless there are less
+	 * hardware queues then CPUs. For that case we will just round-robin
+	 * the available hardware queues as they get assigned to CPUs.
+	 */
+	idx = 0;
+	start_cpu = 0;
+	for_each_present_cpu(cpu) {
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+		if (idx >=  phba->cfg_hdw_queue) {
+			/* We need to reuse a Hardware Queue for another CPU,
+			 * so be smart about it and pick one that has its
+			 * IRQ/EQ mapped to the same phys_id (CPU package).
+			 * and core_id.
+			 */
+			new_cpu = start_cpu;
+			for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
+				new_cpup = &phba->sli4_hba.cpu_map[new_cpu];
+				if ((new_cpup->hdwq != LPFC_VECTOR_MAP_EMPTY) &&
+				    (new_cpup->phys_id == cpup->phys_id) &&
+				    (new_cpup->core_id == cpup->core_id))
+					goto found_hdwq;
+				new_cpu = cpumask_next(
+					new_cpu, cpu_present_mask);
+				if (new_cpu == nr_cpumask_bits)
+					new_cpu = first_cpu;
+			}
+
+			/* If we can't match both phys_id and core_id,
+			 * settle for just a phys_id match.
+			 */
+			new_cpu = start_cpu;
+			for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
+				new_cpup = &phba->sli4_hba.cpu_map[new_cpu];
+				if ((new_cpup->hdwq != LPFC_VECTOR_MAP_EMPTY) &&
+				    (new_cpup->phys_id == cpup->phys_id))
+					goto found_hdwq;
+				new_cpu = cpumask_next(
+					new_cpu, cpu_present_mask);
+				if (new_cpu == nr_cpumask_bits)
+					new_cpu = first_cpu;
+			}
+
+			/* Otherwise just round robin on cfg_hdw_queue */
+			cpup->hdwq = idx % phba->cfg_hdw_queue;
+			goto logit;
+found_hdwq:
+			/* We found an available entry, copy the IRQ info */
+			start_cpu = cpumask_next(new_cpu, cpu_present_mask);
+			if (start_cpu == nr_cpumask_bits)
+				start_cpu = first_cpu;
+			cpup->hdwq = new_cpup->hdwq;
+		} else {
+			/* 1 to 1, CPU to hdwq */
+			cpup->hdwq = idx;
+		}
+logit:
+		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				"3335 Set Affinity: CPU %d (phys %d core %d): "
+				"hdwq %d eq %d irq %d flg x%x\n",
+				cpu, cpup->phys_id, cpup->core_id,
+				cpup->hdwq, cpup->eq, cpup->irq, cpup->flag);
+		idx++;
+	}
+
+	/* The cpu_map array will be used later during initialization
+	 * when EQ / CQ / WQs are allocated and configured.
+	 */
 	return;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 4432060f7315..d55259fc0af5 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -5548,6 +5548,7 @@ lpfc_sli4_arm_cqeq_intr(struct lpfc_hba *phba)
 	int qidx;
 	struct lpfc_sli4_hba *sli4_hba = &phba->sli4_hba;
 	struct lpfc_sli4_hdw_queue *qp;
+	struct lpfc_queue *eq;
 
 	sli4_hba->sli4_write_cq_db(phba, sli4_hba->mbx_cq, 0, LPFC_QUEUE_REARM);
 	sli4_hba->sli4_write_cq_db(phba, sli4_hba->els_cq, 0, LPFC_QUEUE_REARM);
@@ -5555,18 +5556,24 @@ lpfc_sli4_arm_cqeq_intr(struct lpfc_hba *phba)
 		sli4_hba->sli4_write_cq_db(phba, sli4_hba->nvmels_cq, 0,
 					   LPFC_QUEUE_REARM);
 
-	qp = sli4_hba->hdwq;
 	if (sli4_hba->hdwq) {
+		/* Loop thru all Hardware Queues */
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
-			sli4_hba->sli4_write_cq_db(phba, qp[qidx].fcp_cq, 0,
+			qp = &sli4_hba->hdwq[qidx];
+			/* ARM the corresponding CQ */
+			sli4_hba->sli4_write_cq_db(phba, qp->fcp_cq, 0,
 						   LPFC_QUEUE_REARM);
-			sli4_hba->sli4_write_cq_db(phba, qp[qidx].nvme_cq, 0,
+			sli4_hba->sli4_write_cq_db(phba, qp->nvme_cq, 0,
 						   LPFC_QUEUE_REARM);
 		}
 
-		for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++)
-			sli4_hba->sli4_write_eq_db(phba, qp[qidx].hba_eq,
-						0, LPFC_QUEUE_REARM);
+		/* Loop thru all IRQ vectors */
+		for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
+			eq = sli4_hba->hba_eq_hdl[qidx].eq;
+			/* ARM the corresponding EQ */
+			sli4_hba->sli4_write_eq_db(phba, eq,
+						   0, LPFC_QUEUE_REARM);
+		}
 	}
 
 	if (phba->nvmet_support) {
@@ -7858,20 +7865,22 @@ lpfc_sli4_process_missed_mbox_completions(struct lpfc_hba *phba)
 	struct lpfc_sli4_hba *sli4_hba = &phba->sli4_hba;
 	uint32_t eqidx;
 	struct lpfc_queue *fpeq = NULL;
+	struct lpfc_queue *eq;
 	bool mbox_pending;
 
 	if (unlikely(!phba) || (phba->sli_rev != LPFC_SLI_REV4))
 		return false;
 
-	/* Find the eq associated with the mcq */
-
-	if (sli4_hba->hdwq)
-		for (eqidx = 0; eqidx < phba->cfg_irq_chann; eqidx++)
-			if (sli4_hba->hdwq[eqidx].hba_eq->queue_id ==
-			    sli4_hba->mbx_cq->assoc_qid) {
-				fpeq = sli4_hba->hdwq[eqidx].hba_eq;
+	/* Find the EQ associated with the mbox CQ */
+	if (sli4_hba->hdwq) {
+		for (eqidx = 0; eqidx < phba->cfg_irq_chann; eqidx++) {
+			eq = phba->sli4_hba.hba_eq_hdl[eqidx].eq;
+			if (eq->queue_id == sli4_hba->mbx_cq->assoc_qid) {
+				fpeq = eq;
 				break;
 			}
+		}
+	}
 	if (!fpeq)
 		return false;
 
@@ -14217,7 +14226,7 @@ lpfc_sli4_hba_intr_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	/* Get to the EQ struct associated with this vector */
-	fpeq = phba->sli4_hba.hdwq[hba_eqidx].hba_eq;
+	fpeq = phba->sli4_hba.hba_eq_hdl[hba_eqidx].eq;
 	if (unlikely(!fpeq))
 		return IRQ_NONE;
 
@@ -14502,7 +14511,7 @@ lpfc_modify_hba_eq_delay(struct lpfc_hba *phba, uint32_t startq,
 	/* set values by EQ_DELAY register if supported */
 	if (phba->sli.sli_flag & LPFC_SLI_USE_EQDR) {
 		for (qidx = startq; qidx < phba->cfg_irq_chann; qidx++) {
-			eq = phba->sli4_hba.hdwq[qidx].hba_eq;
+			eq = phba->sli4_hba.hba_eq_hdl[qidx].eq;
 			if (!eq)
 				continue;
 
@@ -14511,7 +14520,6 @@ lpfc_modify_hba_eq_delay(struct lpfc_hba *phba, uint32_t startq,
 			if (++cnt >= numq)
 				break;
 		}
-
 		return;
 	}
 
@@ -14539,7 +14547,7 @@ lpfc_modify_hba_eq_delay(struct lpfc_hba *phba, uint32_t startq,
 		dmult = LPFC_DMULT_MAX;
 
 	for (qidx = startq; qidx < phba->cfg_irq_chann; qidx++) {
-		eq = phba->sli4_hba.hdwq[qidx].hba_eq;
+		eq = phba->sli4_hba.hba_eq_hdl[qidx].eq;
 		if (!eq)
 			continue;
 		eq->q_mode = usdelay;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 69c6dba77dce..3aeca387b22a 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -452,6 +452,7 @@ struct lpfc_hba_eq_hdl {
 	uint32_t idx;
 	char handler_name[LPFC_SLI4_HANDLER_NAME_SZ];
 	struct lpfc_hba *phba;
+	struct lpfc_queue *eq;
 };
 
 /*BB Credit recovery value*/
@@ -552,6 +553,7 @@ struct lpfc_vector_map_info {
 	uint16_t	flag;
 #define LPFC_CPU_MAP_HYPER	0x1
 #define LPFC_CPU_MAP_UNASSIGN	0x2
+#define LPFC_CPU_FIRST_IRQ	0x4
 };
 #define LPFC_VECTOR_MAP_EMPTY	0xffff
 
-- 
2.13.7

