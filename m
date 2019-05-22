Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6185D25B49
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfEVAt3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34942 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfEVAt2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so182991plo.2
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nU9bGb+ZDTI7rIQtHz9KYet0VysucJK8jffF6oR+4jk=;
        b=KeTo/TEVB5GDLqq95a80Z7PyoHCr5Cj3NuH2qXPtXxGFEBdDJErul+q685MXltwmiW
         Bc2uey2xIxtGOpJFyflm/URMu2VmpDXa70w3WeSIuDsourQpFkycj6/0G+MsJF6Kx0eG
         F+YTmyUma0VTcnK2niNtGG9T4DZ5LfTlGAsuPHiBy3rsJgBq9RnKIvS3NbPjzDAwXHj+
         KEQ8Sn9PRcpEih54Qcyou0zDvlTSTt7FkqrkNxxvMZkIxrvcUIFv0cmXn7y4GOm3cpdP
         2zkGtJrRnIEs385tpSylyvBxV1bicXIZBKHyZhCRgrUEHpDc7WnIOZWov1sIhdAosR9Y
         cPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nU9bGb+ZDTI7rIQtHz9KYet0VysucJK8jffF6oR+4jk=;
        b=PU8GT6hvyAjFkpo8rCtou+cRWw6K7yWpoLu5HsZzDoqBzYI/eYYeX8dzAQpc2Zwx36
         VdERmkiQfBTgBxwkRTiUq+SVt3By4lfXQZN6cuwhqdUboFY07SIJVR9cogiiHNIgDjts
         9VrVFJms6v41oKIMXKKO6A2vhFoJ2UBZNT/emiAMGGR4uXnsDmHskMBQHYcpud0YIITE
         VuLSW4V9vhhgN35MC27C24AxS64XpLdtIvSnMsXnsePPKMfAI/ZHKJBhOIxGgkQ0agop
         18y5t3IrEA1PvrVFKlvmeenww2+Iwt2sgzLjpa5IqzFHxFWEX5t4by9J5M85V3G2DeBH
         BkDw==
X-Gm-Message-State: APjAAAWSS9PE3xBUR39R/eIGfIeegeNouxZTXF9ihp6wZANZEQ4nVX/j
        Wd6mgutsU7MLPKAxGfk+3/odlXwA
X-Google-Smtp-Source: APXvYqxZ6PnotmRAwAoczk7IucUS/O3MWdv9CSt+VYo9xYK6GeQ0VScXlTSE8l0hIdkt0D6Nuf8xCA==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr64003746plb.86.1558486166237;
        Tue, 21 May 2019 17:49:26 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:25 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 05/21] lpfc: Separate CQ processing for nvmet_fc upcalls
Date:   Tue, 21 May 2019 17:48:55 -0700
Message-Id: <20190522004911.573-6-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently the driver is notified of new command frame receipt by
CQE's. As part of the CQE processing, the driver upcalls the
nvmet_fc transport to deliver the command. nvmet_fc, as part of
receiving the command builds out a context for it, where one of
the first steps is to allocate memory for the io.

When running with tests that do large ios (1MB), it was found on
some systems, the total number of outstanding I/O's, at 1MB per,
completely consumed the systems memory. Thus additional ios were
getting blocked in the memory allocator.  Given that this blocked
the lpfc thread processing cqes, there were lots of other commands
that were received and which are then held up, and given CQEs are
serially processed, the aggregate delays for an IO waiting behind
the others became cummulative - enough so that the initiator hit
timeouts for the ios.

The basic fix is to avoid the direct upcall and instead schedule a
work item for each io as it is received. This allows the cq processing
to complete very quickly, and each io can then run or block on it's
own.  However, this general solution hurts latency when there are
few ios.  As such, implemented the fix such that the driver watches
how many cqes it has processed sequentially in one run. As long as
the count is below a threshold, the direct nvmet_fc upcall will be
made. Only when the count is exceeded will it revert to work
scheduling.

Given that debug of this showed a surprisingly long delay in cq
processing, the io timer stats were updated to better reflect
the processing of the different points.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_crtn.h  |  3 +-
 drivers/scsi/lpfc/lpfc_nvmet.c | 67 +++++++++++++++++++++++++++++-------------
 drivers/scsi/lpfc/lpfc_sli.c   | 22 ++++++++------
 drivers/scsi/lpfc/lpfc_sli4.h  |  2 ++
 4 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index e0b14d791b8c..97f0ef236661 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -568,7 +568,8 @@ void lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba);
 void lpfc_nvmet_unsol_ls_event(struct lpfc_hba *phba,
 			struct lpfc_sli_ring *pring, struct lpfc_iocbq *piocb);
 void lpfc_nvmet_unsol_fcp_event(struct lpfc_hba *phba, uint32_t idx,
-				struct rqb_dmabuf *nvmebuf, uint64_t isr_ts);
+				struct rqb_dmabuf *nvmebuf, uint64_t isr_ts,
+				uint8_t cqflag);
 void lpfc_nvme_mod_param_dep(struct lpfc_hba *phba);
 void lpfc_nvme_abort_fcreq_cmpl(struct lpfc_hba *phba,
 				struct lpfc_iocbq *cmdiocb,
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 3a11861b7ad6..95386f90a874 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -395,8 +395,9 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 		spin_lock_init(&ctxp->ctxlock);
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-		if (ctxp->ts_cmd_nvme) {
-			ctxp->ts_cmd_nvme = ktime_get_ns();
+		/* NOTE: isr time stamp is stale when context is re-assigned*/
+		if (ctxp->ts_isr_cmd) {
+			ctxp->ts_cmd_nvme = 0;
 			ctxp->ts_nvme_data = 0;
 			ctxp->ts_data_wqput = 0;
 			ctxp->ts_isr_data = 0;
@@ -1877,6 +1878,10 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 
 	payload = (uint32_t *)(nvmebuf->dbuf.virt);
 	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+	if (ctxp->ts_isr_cmd)
+		ctxp->ts_cmd_nvme = ktime_get_ns();
+#endif
 	/*
 	 * The calling sequence should be:
 	 * nvmet_fc_rcv_fcp_req->lpfc_nvmet_xmt_fcp_op/cmp- req->done
@@ -2015,6 +2020,8 @@ lpfc_nvmet_replenish_context(struct lpfc_hba *phba,
  * @phba: pointer to lpfc hba data structure.
  * @idx: relative index of MRQ vector
  * @nvmebuf: pointer to lpfc nvme command HBQ data structure.
+ * @isr_timestamp: in jiffies.
+ * @cqflag: cq processing information regarding workload.
  *
  * This routine is used for processing the WQE associated with a unsolicited
  * event. It first determines whether there is an existing ndlp that matches
@@ -2027,7 +2034,8 @@ static void
 lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 			    uint32_t idx,
 			    struct rqb_dmabuf *nvmebuf,
-			    uint64_t isr_timestamp)
+			    uint64_t isr_timestamp,
+			    uint8_t cqflag)
 {
 	struct lpfc_nvmet_rcv_ctx *ctxp;
 	struct lpfc_nvmet_tgtport *tgtp;
@@ -2136,24 +2144,41 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 	spin_lock_init(&ctxp->ctxlock);
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-	if (isr_timestamp) {
+	if (isr_timestamp)
 		ctxp->ts_isr_cmd = isr_timestamp;
-		ctxp->ts_cmd_nvme = ktime_get_ns();
-		ctxp->ts_nvme_data = 0;
-		ctxp->ts_data_wqput = 0;
-		ctxp->ts_isr_data = 0;
-		ctxp->ts_data_nvme = 0;
-		ctxp->ts_nvme_status = 0;
-		ctxp->ts_status_wqput = 0;
-		ctxp->ts_isr_status = 0;
-		ctxp->ts_status_nvme = 0;
-	} else {
-		ctxp->ts_cmd_nvme = 0;
-	}
+	ctxp->ts_cmd_nvme = 0;
+	ctxp->ts_nvme_data = 0;
+	ctxp->ts_data_wqput = 0;
+	ctxp->ts_isr_data = 0;
+	ctxp->ts_data_nvme = 0;
+	ctxp->ts_nvme_status = 0;
+	ctxp->ts_status_wqput = 0;
+	ctxp->ts_isr_status = 0;
+	ctxp->ts_status_nvme = 0;
 #endif
 
 	atomic_inc(&tgtp->rcv_fcp_cmd_in);
-	lpfc_nvmet_process_rcv_fcp_req(ctx_buf);
+	/* check for cq processing load */
+	if (!cqflag) {
+		lpfc_nvmet_process_rcv_fcp_req(ctx_buf);
+		return;
+	}
+
+	if (!queue_work(phba->wq, &ctx_buf->defer_work)) {
+		atomic_inc(&tgtp->rcv_fcp_cmd_drop);
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+				"6325 Unable to queue work for oxid x%x. "
+				"FCP Drop IO [x%x x%x x%x]\n",
+				ctxp->oxid,
+				atomic_read(&tgtp->rcv_fcp_cmd_in),
+				atomic_read(&tgtp->rcv_fcp_cmd_out),
+				atomic_read(&tgtp->xmt_fcp_release));
+
+		spin_lock_irqsave(&ctxp->ctxlock, iflag);
+		lpfc_nvmet_defer_release(phba, ctxp);
+		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
+		lpfc_nvmet_unsol_fcp_issue_abort(phba, ctxp, sid, oxid);
+	}
 }
 
 /**
@@ -2190,6 +2215,8 @@ lpfc_nvmet_unsol_ls_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
  * @phba: pointer to lpfc hba data structure.
  * @idx: relative index of MRQ vector
  * @nvmebuf: pointer to received nvme data structure.
+ * @isr_timestamp: in jiffies.
+ * @cqflag: cq processing information regarding workload.
  *
  * This routine is used to process an unsolicited event received from a SLI
  * (Service Level Interface) ring. The actual processing of the data buffer
@@ -2201,14 +2228,14 @@ void
 lpfc_nvmet_unsol_fcp_event(struct lpfc_hba *phba,
 			   uint32_t idx,
 			   struct rqb_dmabuf *nvmebuf,
-			   uint64_t isr_timestamp)
+			   uint64_t isr_timestamp,
+			   uint8_t cqflag)
 {
 	if (phba->nvmet_support == 0) {
 		lpfc_rq_buf_free(phba, &nvmebuf->hbuf);
 		return;
 	}
-	lpfc_nvmet_unsol_fcp_buffer(phba, idx, nvmebuf,
-				    isr_timestamp);
+	lpfc_nvmet_unsol_fcp_buffer(phba, idx, nvmebuf, isr_timestamp, cqflag);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 2acda188b0dc..946f3024d4db 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13582,14 +13582,9 @@ __lpfc_sli4_process_cq(struct lpfc_hba *phba, struct lpfc_queue *cq,
 		goto rearm_and_exit;
 
 	/* Process all the entries to the CQ */
+	cq->q_flag = 0;
 	cqe = lpfc_sli4_cq_get(cq);
 	while (cqe) {
-#if defined(CONFIG_SCSI_LPFC_DEBUG_FS) && defined(BUILD_NVME)
-		if (phba->ktime_on)
-			cq->isr_timestamp = ktime_get_ns();
-		else
-			cq->isr_timestamp = 0;
-#endif
 		workposted |= handler(phba, cq, cqe);
 		__lpfc_sli4_consume_cqe(phba, cq, cqe);
 
@@ -13603,6 +13598,9 @@ __lpfc_sli4_process_cq(struct lpfc_hba *phba, struct lpfc_queue *cq,
 			consumed = 0;
 		}
 
+		if (count == LPFC_NVMET_CQ_NOTIFY)
+			cq->q_flag |= HBA_NVMET_CQ_NOTIFY;
+
 		cqe = lpfc_sli4_cq_get(cq);
 	}
 	if (count >= phba->cfg_cq_poll_threshold) {
@@ -13918,10 +13916,10 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 			goto drop;
 
 		if (fc_hdr->fh_type == FC_TYPE_FCP) {
-			dma_buf->bytes_recv = bf_get(lpfc_rcqe_length,  rcqe);
+			dma_buf->bytes_recv = bf_get(lpfc_rcqe_length, rcqe);
 			lpfc_nvmet_unsol_fcp_event(
-				phba, idx, dma_buf,
-				cq->isr_timestamp);
+				phba, idx, dma_buf, cq->isr_timestamp,
+				cq->q_flag & HBA_NVMET_CQ_NOTIFY);
 			return false;
 		}
 drop:
@@ -14087,6 +14085,12 @@ lpfc_sli4_hba_handle_eqe(struct lpfc_hba *phba, struct lpfc_queue *eq,
 	}
 
 work_cq:
+#if defined(CONFIG_SCSI_LPFC_DEBUG_FS)
+	if (phba->ktime_on)
+		cq->isr_timestamp = ktime_get_ns();
+	else
+		cq->isr_timestamp = 0;
+#endif
 	if (!queue_work_on(cq->chann, phba->wq, &cq->irqwork))
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 				"0363 Cannot schedule soft IRQ "
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 8e4fd1a98023..fbc1f1880d53 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -197,6 +197,8 @@ struct lpfc_queue {
 #define LPFC_DB_LIST_FORMAT	0x02
 	uint8_t q_flag;
 #define HBA_NVMET_WQFULL	0x1 /* We hit WQ Full condition for NVMET */
+#define HBA_NVMET_CQ_NOTIFY	0x1 /* LPFC_NVMET_CQ_NOTIFY CQEs this EQE */
+#define LPFC_NVMET_CQ_NOTIFY	4
 	void __iomem *db_regaddr;
 	uint16_t dpp_enable;
 	uint16_t dpp_id;
-- 
2.13.7

