Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E44C8E192
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Aug 2019 01:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfHNX55 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Aug 2019 19:57:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40647 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfHNX55 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Aug 2019 19:57:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id w16so333555pfn.7
        for <linux-scsi@vger.kernel.org>; Wed, 14 Aug 2019 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kTRO8gzjPL8TyVIYh/IaeCfSTvZjXA4l6oOmfTdnhhM=;
        b=JKiA+pRxwPrBVHD0bDmCsMLGxJQX0cg4p8GEWrggFbqV8Mr4zJ5/dsUNbivAwROVl+
         rSPZpAL5+al7460G+G1OApg1KQ1Tnukg3gxPFG9MvwUd0MzfvKxHJ5uVQQVLIvZOm17d
         /OKU36xZgjuATDnn9lvLXgtwEeJNtQ9jchvfedBbjQ1VlG9rf+7IknB+eqREQlVbWUhf
         TJPQPReOZXVQhSzzWj2QZLez1DAJ3FHx/tNDgHEqxemtjEh1SbyY6FkHHLWHSNr+YoZR
         VX8901pqNWodQvZl9U9HeLxsQ1+3Fl7B8gre8/DTJwAp/x+Qx0pW1sch3fvTggkms6tq
         458g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kTRO8gzjPL8TyVIYh/IaeCfSTvZjXA4l6oOmfTdnhhM=;
        b=cajOkFDqfa9WBdLy8HfFn0PS0dw9FdbCHy2Nfq/pA8kps6jQoc845zVEnjTGOB3uEo
         DBCR8s7PM8fPeOVQiggjEuH+D1ef0evjxNaC4OaCdBIOuhAY3GkzuS7jk1E3gxg6NUae
         z/T/8jUc/gakOFxoZ4lDbrMFNOmcrP1/rXhyvZZuFBCkAtC4HCWVNbj9+sU4u/vdmudu
         eq5d2lH/gYoOGlt1LFBnCV/AOgV8rBDuSdFYzUUJv2GZtYT4kZCoyap0BFshB/UlgSjW
         UV4u4g8s8mLENk6I8Ma8ed/mQs3SQZE+2cAQecvl+DckdbtlTku3QZBBA0qX67Zi9ySP
         884g==
X-Gm-Message-State: APjAAAU7gXT2txxqdd5mhOux6bqhd797D1nnBSH+gYZIKWMObMvL4gqy
        6rtZka96L19mvuS53vXHj521RGxc
X-Google-Smtp-Source: APXvYqyk7qOGHqIdqBJzlOKn3zj7rVCsS3L73+VLFwAVM1bBqAxqKV9QElIM3BcKP4K7G1B7HzWpNA==
X-Received: by 2002:a63:dc4f:: with SMTP id f15mr1377910pgj.227.1565827074737;
        Wed, 14 Aug 2019 16:57:54 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k22sm987299pfk.157.2019.08.14.16.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 16:57:54 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 41/42] lpfc: Merge per-protocol WQ/CQ pairs into single per-cpu pair
Date:   Wed, 14 Aug 2019 16:57:11 -0700
Message-Id: <20190814235712.4487-42-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190814235712.4487-1-jsmart2021@gmail.com>
References: <20190814235712.4487-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently, each hardware queue, typically allocated per-cpu, consists
of a WQ/CQ pair per protocol. Meaning if both SCSI and NVMe are
supported 2 WQ/CQ pairs will exist for the hardware queue. Separate
queues are unnecessary. The current implementation wastes memory
backing the 2nd set of queues, and the use of double the SLI-4
WQ/CQ's means less hardware queues can be supported which means there
may not always be enough to have a pair per cpu. If there is only
1 pair per cpu, more cpu's may get their own WQ/CQ.

Rework the implementation to use a single WQ/CQ pair by both
protocols.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h         |   3 +-
 drivers/scsi/lpfc/lpfc_crtn.h    |   2 +-
 drivers/scsi/lpfc/lpfc_debugfs.c |  92 ++----------
 drivers/scsi/lpfc/lpfc_debugfs.h |  61 +++-----
 drivers/scsi/lpfc/lpfc_init.c    | 296 ++++++++++-----------------------------
 drivers/scsi/lpfc/lpfc_nvme.c    |  85 ++++-------
 drivers/scsi/lpfc/lpfc_nvmet.c   |   8 +-
 drivers/scsi/lpfc/lpfc_scsi.c    |  54 ++++---
 drivers/scsi/lpfc/lpfc_sli.c     | 145 +++++--------------
 drivers/scsi/lpfc/lpfc_sli4.h    |  29 ++--
 10 files changed, 218 insertions(+), 557 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 8fb43169a445..73540bb13b3e 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -734,14 +734,13 @@ struct lpfc_hba {
 #define HBA_AER_ENABLED		0x1000 /* AER enabled with HBA */
 #define HBA_DEVLOSS_TMO         0x2000 /* HBA in devloss timeout */
 #define HBA_RRQ_ACTIVE		0x4000 /* process the rrq active list */
-#define HBA_FCP_IOQ_FLUSH	0x8000 /* FCP I/O queues being flushed */
+#define HBA_IOQ_FLUSH		0x8000 /* FCP/NVME I/O queues being flushed */
 #define HBA_FW_DUMP_OP		0x10000 /* Skips fn reset before FW dump */
 #define HBA_RECOVERABLE_UE	0x20000 /* Firmware supports recoverable UE */
 #define HBA_FORCED_LINK_SPEED	0x40000 /*
 					 * Firmware supports Forced Link Speed
 					 * capability
 					 */
-#define HBA_NVME_IOQ_FLUSH      0x80000 /* NVME IO queues flushed. */
 #define HBA_FLOGI_ISSUED	0x100000 /* FLOGI was issued */
 
 	uint32_t fcp_ring_in_use; /* When polling test if intr-hndlr active*/
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index bee27bb7123c..8b84acc95a07 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -326,7 +326,7 @@ void lpfc_sli_bemem_bcopy(void *, void *, uint32_t);
 void lpfc_sli_abort_iocb_ring(struct lpfc_hba *, struct lpfc_sli_ring *);
 void lpfc_sli_abort_fcp_rings(struct lpfc_hba *phba);
 void lpfc_sli_hba_iocb_abort(struct lpfc_hba *);
-void lpfc_sli_flush_fcp_rings(struct lpfc_hba *);
+void lpfc_sli_flush_io_rings(struct lpfc_hba *phba);
 int lpfc_sli_ringpostbuf_put(struct lpfc_hba *, struct lpfc_sli_ring *,
 			     struct lpfc_dmabuf *);
 struct lpfc_dmabuf *lpfc_sli_ringpostbuf_get(struct lpfc_hba *,
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 75055ee59e91..45f431fbe0d2 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -416,8 +416,7 @@ lpfc_debugfs_commonxripools_data(struct lpfc_hba *phba, char *buf, int size)
 		qp = &phba->sli4_hba.hdwq[lpfc_debugfs_last_xripool];
 
 		len += scnprintf(buf + len, size - len, "HdwQ %d Info ", i);
-		spin_lock_irqsave(&qp->abts_scsi_buf_list_lock, iflag);
-		spin_lock(&qp->abts_nvme_buf_list_lock);
+		spin_lock_irqsave(&qp->abts_io_buf_list_lock, iflag);
 		spin_lock(&qp->io_buf_list_get_lock);
 		spin_lock(&qp->io_buf_list_put_lock);
 		out = qp->total_io_bufs - (qp->get_io_bufs + qp->put_io_bufs +
@@ -430,8 +429,7 @@ lpfc_debugfs_commonxripools_data(struct lpfc_hba *phba, char *buf, int size)
 			qp->abts_nvme_io_bufs, out);
 		spin_unlock(&qp->io_buf_list_put_lock);
 		spin_unlock(&qp->io_buf_list_get_lock);
-		spin_unlock(&qp->abts_nvme_buf_list_lock);
-		spin_unlock_irqrestore(&qp->abts_scsi_buf_list_lock, iflag);
+		spin_unlock_irqrestore(&qp->abts_io_buf_list_lock, iflag);
 
 		lpfc_debugfs_last_xripool++;
 		if (lpfc_debugfs_last_xripool >= phba->cfg_hdw_queue)
@@ -533,9 +531,7 @@ lpfc_debugfs_multixripools_data(struct lpfc_hba *phba, char *buf, int size)
 			continue;
 		pbl_pool = &multixri_pool->pbl_pool;
 		pvt_pool = &multixri_pool->pvt_pool;
-		txcmplq_cnt = qp->fcp_wq->pring->txcmplq_cnt;
-		if (qp->nvme_wq)
-			txcmplq_cnt += qp->nvme_wq->pring->txcmplq_cnt;
+		txcmplq_cnt = qp->io_wq->pring->txcmplq_cnt;
 
 		scnprintf(tmp, sizeof(tmp),
 			  "%03d: %4d %4d %4d %4d | %10d %10d ",
@@ -3786,23 +3782,13 @@ lpfc_idiag_wqs_for_cq(struct lpfc_hba *phba, char *wqtype, char *pbuffer,
 	int qidx;
 
 	for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
-		qp = phba->sli4_hba.hdwq[qidx].fcp_wq;
+		qp = phba->sli4_hba.hdwq[qidx].io_wq;
 		if (qp->assoc_qid != cq_id)
 			continue;
 		*len = __lpfc_idiag_print_wq(qp, wqtype, pbuffer, *len);
 		if (*len >= max_cnt)
 			return 1;
 	}
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
-			qp = phba->sli4_hba.hdwq[qidx].nvme_wq;
-			if (qp->assoc_qid != cq_id)
-				continue;
-			*len = __lpfc_idiag_print_wq(qp, wqtype, pbuffer, *len);
-			if (*len >= max_cnt)
-				return 1;
-		}
-	}
 	return 0;
 }
 
@@ -3868,9 +3854,9 @@ lpfc_idiag_cqs_for_eq(struct lpfc_hba *phba, char *pbuffer,
 	struct lpfc_queue *qp;
 	int rc;
 
-	qp = phba->sli4_hba.hdwq[eqidx].fcp_cq;
+	qp = phba->sli4_hba.hdwq[eqidx].io_cq;
 
-	*len = __lpfc_idiag_print_cq(qp, "FCP", pbuffer, *len);
+	*len = __lpfc_idiag_print_cq(qp, "IO", pbuffer, *len);
 
 	/* Reset max counter */
 	qp->CQ_max_cqe = 0;
@@ -3878,28 +3864,11 @@ lpfc_idiag_cqs_for_eq(struct lpfc_hba *phba, char *pbuffer,
 	if (*len >= max_cnt)
 		return 1;
 
-	rc = lpfc_idiag_wqs_for_cq(phba, "FCP", pbuffer, len,
+	rc = lpfc_idiag_wqs_for_cq(phba, "IO", pbuffer, len,
 				   max_cnt, qp->queue_id);
 	if (rc)
 		return 1;
 
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		qp = phba->sli4_hba.hdwq[eqidx].nvme_cq;
-
-		*len = __lpfc_idiag_print_cq(qp, "NVME", pbuffer, *len);
-
-		/* Reset max counter */
-		qp->CQ_max_cqe = 0;
-
-		if (*len >= max_cnt)
-			return 1;
-
-		rc = lpfc_idiag_wqs_for_cq(phba, "NVME", pbuffer, len,
-					   max_cnt, qp->queue_id);
-		if (rc)
-			return 1;
-	}
-
 	if ((eqidx < phba->cfg_nvmet_mrq) && phba->nvmet_support) {
 		/* NVMET CQset */
 		qp = phba->sli4_hba.nvmet_cqset[eqidx];
@@ -4348,7 +4317,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 		if (phba->sli4_hba.hdwq) {
 			for (qidx = 0; qidx < phba->cfg_hdw_queue;
 								qidx++) {
-				qp = phba->sli4_hba.hdwq[qidx].fcp_cq;
+				qp = phba->sli4_hba.hdwq[qidx].io_cq;
 				if (qp && qp->queue_id == queid) {
 					/* Sanity check */
 					rc = lpfc_idiag_que_param_check(
@@ -4360,22 +4329,6 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 				}
 			}
 		}
-		/* NVME complete queue */
-		if (phba->sli4_hba.hdwq) {
-			qidx = 0;
-			do {
-				qp = phba->sli4_hba.hdwq[qidx].nvme_cq;
-				if (qp && qp->queue_id == queid) {
-					/* Sanity check */
-					rc = lpfc_idiag_que_param_check(
-						qp, index, count);
-					if (rc)
-						goto error_out;
-					idiag.ptr_private = qp;
-					goto pass_check;
-				}
-			} while (++qidx < phba->cfg_hdw_queue);
-		}
 		goto error_out;
 		break;
 	case LPFC_IDIAG_MQ:
@@ -4419,20 +4372,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 		if (phba->sli4_hba.hdwq) {
 			/* FCP/SCSI work queue */
 			for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
-				qp = phba->sli4_hba.hdwq[qidx].fcp_wq;
-				if (qp && qp->queue_id == queid) {
-					/* Sanity check */
-					rc = lpfc_idiag_que_param_check(
-						qp, index, count);
-					if (rc)
-						goto error_out;
-					idiag.ptr_private = qp;
-					goto pass_check;
-				}
-			}
-			/* NVME work queue */
-			for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
-				qp = phba->sli4_hba.hdwq[qidx].nvme_wq;
+				qp = phba->sli4_hba.hdwq[qidx].io_wq;
 				if (qp && qp->queue_id == queid) {
 					/* Sanity check */
 					rc = lpfc_idiag_que_param_check(
@@ -6442,12 +6382,7 @@ lpfc_debug_dump_all_queues(struct lpfc_hba *phba)
 	lpfc_debug_dump_wq(phba, DUMP_NVMELS, 0);
 
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++)
-		lpfc_debug_dump_wq(phba, DUMP_FCP, idx);
-
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		for (idx = 0; idx < phba->cfg_hdw_queue; idx++)
-			lpfc_debug_dump_wq(phba, DUMP_NVME, idx);
-	}
+		lpfc_debug_dump_wq(phba, DUMP_IO, idx);
 
 	lpfc_debug_dump_hdr_rq(phba);
 	lpfc_debug_dump_dat_rq(phba);
@@ -6459,12 +6394,7 @@ lpfc_debug_dump_all_queues(struct lpfc_hba *phba)
 	lpfc_debug_dump_cq(phba, DUMP_NVMELS, 0);
 
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++)
-		lpfc_debug_dump_cq(phba, DUMP_FCP, idx);
-
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		for (idx = 0; idx < phba->cfg_hdw_queue; idx++)
-			lpfc_debug_dump_cq(phba, DUMP_NVME, idx);
-	}
+		lpfc_debug_dump_cq(phba, DUMP_IO, idx);
 
 	/*
 	 * Dump Event Queues (EQs)
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.h b/drivers/scsi/lpfc/lpfc_debugfs.h
index 34070874616d..20f2537af511 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.h
+++ b/drivers/scsi/lpfc/lpfc_debugfs.h
@@ -291,8 +291,7 @@ struct lpfc_idiag {
 #define LPFC_DUMP_MULTIXRIPOOL_SIZE 8192
 
 enum {
-	DUMP_FCP,
-	DUMP_NVME,
+	DUMP_IO,
 	DUMP_MBX,
 	DUMP_ELS,
 	DUMP_NVMELS,
@@ -415,12 +414,9 @@ lpfc_debug_dump_wq(struct lpfc_hba *phba, int qtype, int wqidx)
 	struct lpfc_queue *wq;
 	char *qtypestr;
 
-	if (qtype == DUMP_FCP) {
-		wq = phba->sli4_hba.hdwq[wqidx].fcp_wq;
-		qtypestr = "FCP";
-	} else if (qtype == DUMP_NVME) {
-		wq = phba->sli4_hba.hdwq[wqidx].nvme_wq;
-		qtypestr = "NVME";
+	if (qtype == DUMP_IO) {
+		wq = phba->sli4_hba.hdwq[wqidx].io_wq;
+		qtypestr = "IO";
 	} else if (qtype == DUMP_MBX) {
 		wq = phba->sli4_hba.mbx_wq;
 		qtypestr = "MBX";
@@ -433,7 +429,7 @@ lpfc_debug_dump_wq(struct lpfc_hba *phba, int qtype, int wqidx)
 	} else
 		return;
 
-	if (qtype == DUMP_FCP || qtype == DUMP_NVME)
+	if (qtype == DUMP_IO)
 		pr_err("%s WQ: WQ[Idx:%d|Qid:%d]\n",
 			qtypestr, wqidx, wq->queue_id);
 	else
@@ -459,17 +455,13 @@ lpfc_debug_dump_cq(struct lpfc_hba *phba, int qtype, int wqidx)
 	char *qtypestr;
 	int eqidx;
 
-	/* fcp/nvme wq and cq are 1:1, thus same indexes */
+	/* io wq and cq are 1:1, thus same indexes */
 	eq = NULL;
 
-	if (qtype == DUMP_FCP) {
-		wq = phba->sli4_hba.hdwq[wqidx].fcp_wq;
-		cq = phba->sli4_hba.hdwq[wqidx].fcp_cq;
-		qtypestr = "FCP";
-	} else if (qtype == DUMP_NVME) {
-		wq = phba->sli4_hba.hdwq[wqidx].nvme_wq;
-		cq = phba->sli4_hba.hdwq[wqidx].nvme_cq;
-		qtypestr = "NVME";
+	if (qtype == DUMP_IO) {
+		wq = phba->sli4_hba.hdwq[wqidx].io_wq;
+		cq = phba->sli4_hba.hdwq[wqidx].io_cq;
+		qtypestr = "IO";
 	} else if (qtype == DUMP_MBX) {
 		wq = phba->sli4_hba.mbx_wq;
 		cq = phba->sli4_hba.mbx_cq;
@@ -496,7 +488,7 @@ lpfc_debug_dump_cq(struct lpfc_hba *phba, int qtype, int wqidx)
 		eq = phba->sli4_hba.hdwq[0].hba_eq;
 	}
 
-	if (qtype == DUMP_FCP || qtype == DUMP_NVME)
+	if (qtype == DUMP_IO)
 		pr_err("%s CQ: WQ[Idx:%d|Qid%d]->CQ[Idx%d|Qid%d]"
 			"->EQ[Idx:%d|Qid:%d]:\n",
 			qtypestr, wqidx, wq->queue_id, wqidx, cq->queue_id,
@@ -572,20 +564,11 @@ lpfc_debug_dump_wq_by_id(struct lpfc_hba *phba, int qid)
 	int wq_idx;
 
 	for (wq_idx = 0; wq_idx < phba->cfg_hdw_queue; wq_idx++)
-		if (phba->sli4_hba.hdwq[wq_idx].fcp_wq->queue_id == qid)
+		if (phba->sli4_hba.hdwq[wq_idx].io_wq->queue_id == qid)
 			break;
 	if (wq_idx < phba->cfg_hdw_queue) {
-		pr_err("FCP WQ[Idx:%d|Qid:%d]\n", wq_idx, qid);
-		lpfc_debug_dump_q(phba->sli4_hba.hdwq[wq_idx].fcp_wq);
-		return;
-	}
-
-	for (wq_idx = 0; wq_idx < phba->cfg_hdw_queue; wq_idx++)
-		if (phba->sli4_hba.hdwq[wq_idx].nvme_wq->queue_id == qid)
-			break;
-	if (wq_idx < phba->cfg_hdw_queue) {
-		pr_err("NVME WQ[Idx:%d|Qid:%d]\n", wq_idx, qid);
-		lpfc_debug_dump_q(phba->sli4_hba.hdwq[wq_idx].nvme_wq);
+		pr_err("IO WQ[Idx:%d|Qid:%d]\n", wq_idx, qid);
+		lpfc_debug_dump_q(phba->sli4_hba.hdwq[wq_idx].io_wq);
 		return;
 	}
 
@@ -654,22 +637,12 @@ lpfc_debug_dump_cq_by_id(struct lpfc_hba *phba, int qid)
 	int cq_idx;
 
 	for (cq_idx = 0; cq_idx < phba->cfg_hdw_queue; cq_idx++)
-		if (phba->sli4_hba.hdwq[cq_idx].fcp_cq->queue_id == qid)
-			break;
-
-	if (cq_idx < phba->cfg_hdw_queue) {
-		pr_err("FCP CQ[Idx:%d|Qid:%d]\n", cq_idx, qid);
-		lpfc_debug_dump_q(phba->sli4_hba.hdwq[cq_idx].fcp_cq);
-		return;
-	}
-
-	for (cq_idx = 0; cq_idx < phba->cfg_hdw_queue; cq_idx++)
-		if (phba->sli4_hba.hdwq[cq_idx].nvme_cq->queue_id == qid)
+		if (phba->sli4_hba.hdwq[cq_idx].io_cq->queue_id == qid)
 			break;
 
 	if (cq_idx < phba->cfg_hdw_queue) {
-		pr_err("NVME CQ[Idx:%d|Qid:%d]\n", cq_idx, qid);
-		lpfc_debug_dump_q(phba->sli4_hba.hdwq[cq_idx].nvme_cq);
+		pr_err("IO CQ[Idx:%d|Qid:%d]\n", cq_idx, qid);
+		lpfc_debug_dump_q(phba->sli4_hba.hdwq[cq_idx].io_cq);
 		return;
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7e620c0b5b4a..55994edc421b 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1082,8 +1082,8 @@ lpfc_hba_down_post_s4(struct lpfc_hba *phba)
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		qp = &phba->sli4_hba.hdwq[idx];
 
-		spin_lock(&qp->abts_scsi_buf_list_lock);
-		list_splice_init(&qp->lpfc_abts_scsi_buf_list,
+		spin_lock(&qp->abts_io_buf_list_lock);
+		list_splice_init(&qp->lpfc_abts_io_buf_list,
 				 &aborts);
 
 		list_for_each_entry_safe(psb, psb_next, &aborts, list) {
@@ -1094,29 +1094,11 @@ lpfc_hba_down_post_s4(struct lpfc_hba *phba)
 		spin_lock(&qp->io_buf_list_put_lock);
 		list_splice_init(&aborts, &qp->lpfc_io_buf_list_put);
 		qp->put_io_bufs += qp->abts_scsi_io_bufs;
+		qp->put_io_bufs += qp->abts_nvme_io_bufs;
 		qp->abts_scsi_io_bufs = 0;
+		qp->abts_nvme_io_bufs = 0;
 		spin_unlock(&qp->io_buf_list_put_lock);
-		spin_unlock(&qp->abts_scsi_buf_list_lock);
-
-		if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-			spin_lock(&qp->abts_nvme_buf_list_lock);
-			list_splice_init(&qp->lpfc_abts_nvme_buf_list,
-					 &nvme_aborts);
-			list_for_each_entry_safe(psb, psb_next, &nvme_aborts,
-						 list) {
-				psb->pCmd = NULL;
-				psb->status = IOSTAT_SUCCESS;
-				cnt++;
-			}
-			spin_lock(&qp->io_buf_list_put_lock);
-			qp->put_io_bufs += qp->abts_nvme_io_bufs;
-			qp->abts_nvme_io_bufs = 0;
-			list_splice_init(&nvme_aborts,
-					 &qp->lpfc_io_buf_list_put);
-			spin_unlock(&qp->io_buf_list_put_lock);
-			spin_unlock(&qp->abts_nvme_buf_list_lock);
-
-		}
+		spin_unlock(&qp->abts_io_buf_list_lock);
 	}
 	spin_unlock_irq(&phba->hbalock);
 
@@ -1546,8 +1528,7 @@ lpfc_sli4_offline_eratt(struct lpfc_hba *phba)
 	spin_unlock_irq(&phba->hbalock);
 
 	lpfc_offline_prep(phba, LPFC_MBX_NO_WAIT);
-	lpfc_sli_flush_fcp_rings(phba);
-	lpfc_sli_flush_nvme_rings(phba);
+	lpfc_sli_flush_io_rings(phba);
 	lpfc_offline(phba);
 	lpfc_hba_down_post(phba);
 	lpfc_unblock_mgmt_io(phba);
@@ -1809,8 +1790,7 @@ lpfc_sli4_port_sta_fn_reset(struct lpfc_hba *phba, int mbx_action,
 				"2887 Reset Needed: Attempting Port "
 				"Recovery...\n");
 	lpfc_offline_prep(phba, mbx_action);
-	lpfc_sli_flush_fcp_rings(phba);
-	lpfc_sli_flush_nvme_rings(phba);
+	lpfc_sli_flush_io_rings(phba);
 	lpfc_offline(phba);
 	/* release interrupt for possible resource change */
 	lpfc_sli4_disable_intr(phba);
@@ -3266,12 +3246,8 @@ static void lpfc_destroy_multixri_pools(struct lpfc_hba *phba)
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
 		lpfc_destroy_expedite_pool(phba);
 
-	if (!(phba->pport->load_flag & FC_UNLOADING)) {
-		lpfc_sli_flush_fcp_rings(phba);
-
-		if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
-			lpfc_sli_flush_nvme_rings(phba);
-	}
+	if (!(phba->pport->load_flag & FC_UNLOADING))
+		lpfc_sli_flush_io_rings(phba);
 
 	hwq_count = phba->cfg_hdw_queue;
 
@@ -6518,11 +6494,9 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	/*
 	 * Initialize the SLI Layer to run with lpfc SLI4 HBAs.
 	 */
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_FCP) {
-		/* Initialize the Abort scsi buffer list used by driver */
-		spin_lock_init(&phba->sli4_hba.abts_scsi_buf_list_lock);
-		INIT_LIST_HEAD(&phba->sli4_hba.lpfc_abts_scsi_buf_list);
-	}
+	/* Initialize the Abort buffer list used by driver */
+	spin_lock_init(&phba->sli4_hba.abts_io_buf_list_lock);
+	INIT_LIST_HEAD(&phba->sli4_hba.lpfc_abts_io_buf_list);
 
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
 		/* Initialize the Abort nvme buffer list used by driver */
@@ -8477,11 +8451,6 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 		 */
 		qmin -= 4;
 
-		/* If NVME is configured, double the number of CQ/WQs needed */
-		if ((phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) &&
-		    !phba->nvmet_support)
-			qmin /= 2;
-
 		/* Check to see if there is enough for NVME */
 		if ((phba->cfg_irq_chann > qmin) ||
 		    (phba->cfg_hdw_queue > qmin)) {
@@ -8738,51 +8707,14 @@ lpfc_sli4_queue_verify(struct lpfc_hba *phba)
 }
 
 static int
-lpfc_alloc_nvme_wq_cq(struct lpfc_hba *phba, int wqidx)
-{
-	struct lpfc_queue *qdesc;
-	int cpu;
-
-	cpu = lpfc_find_cpu_handle(phba, wqidx, LPFC_FIND_BY_HDWQ);
-	qdesc = lpfc_sli4_queue_alloc(phba, LPFC_EXPANDED_PAGE_SIZE,
-				      phba->sli4_hba.cq_esize,
-				      LPFC_CQE_EXP_COUNT, cpu);
-	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-				"0508 Failed allocate fast-path NVME CQ (%d)\n",
-				wqidx);
-		return 1;
-	}
-	qdesc->qe_valid = 1;
-	qdesc->hdwq = wqidx;
-	qdesc->chann = cpu;
-	phba->sli4_hba.hdwq[wqidx].nvme_cq = qdesc;
-
-	qdesc = lpfc_sli4_queue_alloc(phba, LPFC_EXPANDED_PAGE_SIZE,
-				      LPFC_WQE128_SIZE, LPFC_WQE_EXP_COUNT,
-				      cpu);
-	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-				"0509 Failed allocate fast-path NVME WQ (%d)\n",
-				wqidx);
-		return 1;
-	}
-	qdesc->hdwq = wqidx;
-	qdesc->chann = wqidx;
-	phba->sli4_hba.hdwq[wqidx].nvme_wq = qdesc;
-	list_add_tail(&qdesc->wq_list, &phba->sli4_hba.lpfc_wq_list);
-	return 0;
-}
-
-static int
-lpfc_alloc_fcp_wq_cq(struct lpfc_hba *phba, int wqidx)
+lpfc_alloc_io_wq_cq(struct lpfc_hba *phba, int idx)
 {
 	struct lpfc_queue *qdesc;
-	uint32_t wqesize;
+	u32 wqesize;
 	int cpu;
 
-	cpu = lpfc_find_cpu_handle(phba, wqidx, LPFC_FIND_BY_HDWQ);
-	/* Create Fast Path FCP CQs */
+	cpu = lpfc_find_cpu_handle(phba, idx, LPFC_FIND_BY_HDWQ);
+	/* Create Fast Path IO CQs */
 	if (phba->enab_exp_wqcq_pages)
 		/* Increase the CQ size when WQEs contain an embedded cdb */
 		qdesc = lpfc_sli4_queue_alloc(phba, LPFC_EXPANDED_PAGE_SIZE,
@@ -8795,15 +8727,15 @@ lpfc_alloc_fcp_wq_cq(struct lpfc_hba *phba, int wqidx)
 					      phba->sli4_hba.cq_ecount, cpu);
 	if (!qdesc) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-			"0499 Failed allocate fast-path FCP CQ (%d)\n", wqidx);
+			"0499 Failed allocate fast-path IO CQ (%d)\n", idx);
 		return 1;
 	}
 	qdesc->qe_valid = 1;
-	qdesc->hdwq = wqidx;
+	qdesc->hdwq = idx;
 	qdesc->chann = cpu;
-	phba->sli4_hba.hdwq[wqidx].fcp_cq = qdesc;
+	phba->sli4_hba.hdwq[idx].io_cq = qdesc;
 
-	/* Create Fast Path FCP WQs */
+	/* Create Fast Path IO WQs */
 	if (phba->enab_exp_wqcq_pages) {
 		/* Increase the WQ size when WQEs contain an embedded cdb */
 		wqesize = (phba->fcp_embed_io) ?
@@ -8818,13 +8750,13 @@ lpfc_alloc_fcp_wq_cq(struct lpfc_hba *phba, int wqidx)
 
 	if (!qdesc) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-				"0503 Failed allocate fast-path FCP WQ (%d)\n",
-				wqidx);
+				"0503 Failed allocate fast-path IO WQ (%d)\n",
+				idx);
 		return 1;
 	}
-	qdesc->hdwq = wqidx;
-	qdesc->chann = wqidx;
-	phba->sli4_hba.hdwq[wqidx].fcp_wq = qdesc;
+	qdesc->hdwq = idx;
+	qdesc->chann = cpu;
+	phba->sli4_hba.hdwq[idx].io_wq = qdesc;
 	list_add_tail(&qdesc->wq_list, &phba->sli4_hba.lpfc_wq_list);
 	return 0;
 }
@@ -8888,11 +8820,9 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 			qp->get_io_bufs = 0;
 			qp->put_io_bufs = 0;
 			qp->total_io_bufs = 0;
-			spin_lock_init(&qp->abts_scsi_buf_list_lock);
-			INIT_LIST_HEAD(&qp->lpfc_abts_scsi_buf_list);
+			spin_lock_init(&qp->abts_io_buf_list_lock);
+			INIT_LIST_HEAD(&qp->lpfc_abts_io_buf_list);
 			qp->abts_scsi_io_bufs = 0;
-			spin_lock_init(&qp->abts_nvme_buf_list_lock);
-			INIT_LIST_HEAD(&qp->lpfc_abts_nvme_buf_list);
 			qp->abts_nvme_io_bufs = 0;
 			INIT_LIST_HEAD(&qp->sgl_list);
 			INIT_LIST_HEAD(&qp->cmd_rsp_buf_list);
@@ -8993,41 +8923,31 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 		qp->hba_eq = phba->sli4_hba.hdwq[eqcpup->hdwq].hba_eq;
 	}
 
-	/* Allocate SCSI SLI4 CQ/WQs */
+	/* Allocate IO Path SLI4 CQ/WQs */
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
-		if (lpfc_alloc_fcp_wq_cq(phba, idx))
+		if (lpfc_alloc_io_wq_cq(phba, idx))
 			goto out_error;
 	}
 
-	/* Allocate NVME SLI4 CQ/WQs */
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
-			if (lpfc_alloc_nvme_wq_cq(phba, idx))
-				goto out_error;
-		}
-
-		if (phba->nvmet_support) {
-			for (idx = 0; idx < phba->cfg_nvmet_mrq; idx++) {
-				cpu = lpfc_find_cpu_handle(phba, idx,
-							   LPFC_FIND_BY_HDWQ);
-				qdesc = lpfc_sli4_queue_alloc(
-						      phba,
+	if (phba->nvmet_support) {
+		for (idx = 0; idx < phba->cfg_nvmet_mrq; idx++) {
+			cpu = lpfc_find_cpu_handle(phba, idx,
+						   LPFC_FIND_BY_HDWQ);
+			qdesc = lpfc_sli4_queue_alloc(phba,
 						      LPFC_DEFAULT_PAGE_SIZE,
 						      phba->sli4_hba.cq_esize,
 						      phba->sli4_hba.cq_ecount,
 						      cpu);
-				if (!qdesc) {
-					lpfc_printf_log(
-						phba, KERN_ERR, LOG_INIT,
+			if (!qdesc) {
+				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 						"3142 Failed allocate NVME "
 						"CQ Set (%d)\n", idx);
-					goto out_error;
-				}
-				qdesc->qe_valid = 1;
-				qdesc->hdwq = idx;
-				qdesc->chann = cpu;
-				phba->sli4_hba.nvmet_cqset[idx] = qdesc;
+				goto out_error;
 			}
+			qdesc->qe_valid = 1;
+			qdesc->hdwq = idx;
+			qdesc->chann = cpu;
+			phba->sli4_hba.nvmet_cqset[idx] = qdesc;
 		}
 	}
 
@@ -9058,7 +8978,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 		goto out_error;
 	}
 	qdesc->qe_valid = 1;
-	qdesc->chann = 0;
+	qdesc->chann = cpu;
 	phba->sli4_hba.els_cq = qdesc;
 
 
@@ -9076,7 +8996,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				"0505 Failed allocate slow-path MQ\n");
 		goto out_error;
 	}
-	qdesc->chann = 0;
+	qdesc->chann = cpu;
 	phba->sli4_hba.mbx_wq = qdesc;
 
 	/*
@@ -9092,7 +9012,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				"0504 Failed allocate slow-path ELS WQ\n");
 		goto out_error;
 	}
-	qdesc->chann = 0;
+	qdesc->chann = cpu;
 	phba->sli4_hba.els_wq = qdesc;
 	list_add_tail(&qdesc->wq_list, &phba->sli4_hba.lpfc_wq_list);
 
@@ -9106,7 +9026,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					"6079 Failed allocate NVME LS CQ\n");
 			goto out_error;
 		}
-		qdesc->chann = 0;
+		qdesc->chann = cpu;
 		qdesc->qe_valid = 1;
 		phba->sli4_hba.nvmels_cq = qdesc;
 
@@ -9119,7 +9039,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					"6080 Failed allocate NVME LS WQ\n");
 			goto out_error;
 		}
-		qdesc->chann = 0;
+		qdesc->chann = cpu;
 		phba->sli4_hba.nvmels_wq = qdesc;
 		list_add_tail(&qdesc->wq_list, &phba->sli4_hba.lpfc_wq_list);
 	}
@@ -9262,15 +9182,10 @@ lpfc_sli4_release_hdwq(struct lpfc_hba *phba)
 	/* Loop thru all Hardware Queues */
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		/* Free the CQ/WQ corresponding to the Hardware Queue */
-		lpfc_sli4_queue_free(hdwq[idx].fcp_cq);
-		lpfc_sli4_queue_free(hdwq[idx].nvme_cq);
-		lpfc_sli4_queue_free(hdwq[idx].fcp_wq);
-		lpfc_sli4_queue_free(hdwq[idx].nvme_wq);
-		hdwq[idx].hba_eq = NULL;
-		hdwq[idx].fcp_cq = NULL;
-		hdwq[idx].nvme_cq = NULL;
-		hdwq[idx].fcp_wq = NULL;
-		hdwq[idx].nvme_wq = NULL;
+		lpfc_sli4_queue_free(hdwq[idx].io_cq);
+		lpfc_sli4_queue_free(hdwq[idx].io_wq);
+		hdwq[idx].io_cq = NULL;
+		hdwq[idx].io_wq = NULL;
 		if (phba->cfg_xpsgl && !phba->nvmet_support)
 			lpfc_free_sgl_per_hdwq(phba, &hdwq[idx]);
 		lpfc_free_cmd_rsp_buf_per_hdwq(phba, &hdwq[idx]);
@@ -9473,8 +9388,7 @@ lpfc_setup_cq_lookup(struct lpfc_hba *phba)
 		list_for_each_entry(childq, &eq->child_list, list) {
 			if (childq->queue_id > phba->sli4_hba.cq_max)
 				continue;
-			if ((childq->subtype == LPFC_FCP) ||
-			    (childq->subtype == LPFC_NVME))
+			if (childq->subtype == LPFC_IO)
 				phba->sli4_hba.cq_lookup[childq->queue_id] =
 					childq;
 		}
@@ -9600,31 +9514,6 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	}
 
 	/* Loop thru all Hardware Queues */
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
-			cpu = lpfc_find_cpu_handle(phba, qidx,
-						   LPFC_FIND_BY_HDWQ);
-			cpup = &phba->sli4_hba.cpu_map[cpu];
-
-			/* Create the CQ/WQ corresponding to the
-			 * Hardware Queue
-			 */
-			rc = lpfc_create_wq_cq(phba,
-					phba->sli4_hba.hdwq[cpup->hdwq].hba_eq,
-					qp[qidx].nvme_cq,
-					qp[qidx].nvme_wq,
-					&phba->sli4_hba.hdwq[qidx].nvme_cq_map,
-					qidx, LPFC_NVME);
-			if (rc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-					"6123 Failed to setup fastpath "
-					"NVME WQ/CQ (%d), rc = 0x%x\n",
-					qidx, (uint32_t)rc);
-				goto out_destroy;
-			}
-		}
-	}
-
 	for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
 		cpu = lpfc_find_cpu_handle(phba, qidx, LPFC_FIND_BY_HDWQ);
 		cpup = &phba->sli4_hba.cpu_map[cpu];
@@ -9632,14 +9521,15 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 		/* Create the CQ/WQ corresponding to the Hardware Queue */
 		rc = lpfc_create_wq_cq(phba,
 				       phba->sli4_hba.hdwq[cpup->hdwq].hba_eq,
-				       qp[qidx].fcp_cq,
-				       qp[qidx].fcp_wq,
-				       &phba->sli4_hba.hdwq[qidx].fcp_cq_map,
-				       qidx, LPFC_FCP);
+				       qp[qidx].io_cq,
+				       qp[qidx].io_wq,
+				       &phba->sli4_hba.hdwq[qidx].io_cq_map,
+				       qidx,
+				       LPFC_IO);
 		if (rc) {
 			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 					"0535 Failed to setup fastpath "
-					"FCP WQ/CQ (%d), rc = 0x%x\n",
+					"IO WQ/CQ (%d), rc = 0x%x\n",
 					qidx, (uint32_t)rc);
 			goto out_destroy;
 		}
@@ -9939,10 +9829,8 @@ lpfc_sli4_queue_unset(struct lpfc_hba *phba)
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
 			/* Destroy the CQ/WQ corresponding to Hardware Queue */
 			qp = &phba->sli4_hba.hdwq[qidx];
-			lpfc_wq_destroy(phba, qp->fcp_wq);
-			lpfc_wq_destroy(phba, qp->nvme_wq);
-			lpfc_cq_destroy(phba, qp->fcp_cq);
-			lpfc_cq_destroy(phba, qp->nvme_cq);
+			lpfc_wq_destroy(phba, qp->io_wq);
+			lpfc_cq_destroy(phba, qp->io_cq);
 		}
 		/* Loop thru all IRQ vectors */
 		for (qidx = 0; qidx < phba->cfg_irq_chann; qidx++) {
@@ -11418,11 +11306,10 @@ static void
 lpfc_sli4_xri_exchange_busy_wait(struct lpfc_hba *phba)
 {
 	struct lpfc_sli4_hdw_queue *qp;
-	int idx, ccnt, fcnt;
+	int idx, ccnt;
 	int wait_time = 0;
 	int io_xri_cmpl = 1;
 	int nvmet_xri_cmpl = 1;
-	int fcp_xri_cmpl = 1;
 	int els_xri_cmpl = list_empty(&phba->sli4_hba.lpfc_abts_els_sgl_list);
 
 	/* Driver just aborted IOs during the hba_unset process.  Pause
@@ -11436,32 +11323,21 @@ lpfc_sli4_xri_exchange_busy_wait(struct lpfc_hba *phba)
 		lpfc_nvme_wait_for_io_drain(phba);
 
 	ccnt = 0;
-	fcnt = 0;
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		qp = &phba->sli4_hba.hdwq[idx];
-		fcp_xri_cmpl = list_empty(
-			&qp->lpfc_abts_scsi_buf_list);
-		if (!fcp_xri_cmpl) /* if list is NOT empty */
-			fcnt++;
-		if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-			io_xri_cmpl = list_empty(
-				&qp->lpfc_abts_nvme_buf_list);
-			if (!io_xri_cmpl) /* if list is NOT empty */
-				ccnt++;
-		}
+		io_xri_cmpl = list_empty(&qp->lpfc_abts_io_buf_list);
+		if (!io_xri_cmpl) /* if list is NOT empty */
+			ccnt++;
 	}
 	if (ccnt)
 		io_xri_cmpl = 0;
-	if (fcnt)
-		fcp_xri_cmpl = 0;
 
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
 		nvmet_xri_cmpl =
 			list_empty(&phba->sli4_hba.lpfc_abts_nvmet_ctx_list);
 	}
 
-	while (!fcp_xri_cmpl || !els_xri_cmpl || !io_xri_cmpl ||
-	       !nvmet_xri_cmpl) {
+	while (!els_xri_cmpl || !io_xri_cmpl || !nvmet_xri_cmpl) {
 		if (wait_time > LPFC_XRI_EXCH_BUSY_WAIT_TMO) {
 			if (!nvmet_xri_cmpl)
 				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
@@ -11470,12 +11346,7 @@ lpfc_sli4_xri_exchange_busy_wait(struct lpfc_hba *phba)
 						wait_time/1000);
 			if (!io_xri_cmpl)
 				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-						"6100 NVME XRI exchange busy "
-						"wait time: %d seconds.\n",
-						wait_time/1000);
-			if (!fcp_xri_cmpl)
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-						"2877 FCP XRI exchange busy "
+						"6100 IO XRI exchange busy "
 						"wait time: %d seconds.\n",
 						wait_time/1000);
 			if (!els_xri_cmpl)
@@ -11491,24 +11362,15 @@ lpfc_sli4_xri_exchange_busy_wait(struct lpfc_hba *phba)
 		}
 
 		ccnt = 0;
-		fcnt = 0;
 		for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 			qp = &phba->sli4_hba.hdwq[idx];
-			fcp_xri_cmpl = list_empty(
-				&qp->lpfc_abts_scsi_buf_list);
-			if (!fcp_xri_cmpl) /* if list is NOT empty */
-				fcnt++;
-			if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-				io_xri_cmpl = list_empty(
-				    &qp->lpfc_abts_nvme_buf_list);
-				if (!io_xri_cmpl) /* if list is NOT empty */
-					ccnt++;
-			}
+			io_xri_cmpl = list_empty(
+			    &qp->lpfc_abts_io_buf_list);
+			if (!io_xri_cmpl) /* if list is NOT empty */
+				ccnt++;
 		}
 		if (ccnt)
 			io_xri_cmpl = 0;
-		if (fcnt)
-			fcp_xri_cmpl = 0;
 
 		if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
 			nvmet_xri_cmpl = list_empty(
@@ -12303,7 +12165,7 @@ lpfc_sli_prep_dev_for_reset(struct lpfc_hba *phba)
 	lpfc_scsi_dev_block(phba);
 
 	/* Flush all driver's outstanding SCSI I/Os as we are to reset */
-	lpfc_sli_flush_fcp_rings(phba);
+	lpfc_sli_flush_io_rings(phba);
 
 	/* stop all timers */
 	lpfc_stop_hba_timers(phba);
@@ -12333,7 +12195,7 @@ lpfc_sli_prep_dev_for_perm_failure(struct lpfc_hba *phba)
 	lpfc_stop_hba_timers(phba);
 
 	/* Clean up all driver's outstanding SCSI I/Os */
-	lpfc_sli_flush_fcp_rings(phba);
+	lpfc_sli_flush_io_rings(phba);
 }
 
 /**
@@ -13105,12 +12967,8 @@ lpfc_sli4_prep_dev_for_reset(struct lpfc_hba *phba)
 	/* Block all SCSI devices' I/Os on the host */
 	lpfc_scsi_dev_block(phba);
 
-	/* Flush all driver's outstanding SCSI I/Os as we are to reset */
-	lpfc_sli_flush_fcp_rings(phba);
-
-	/* Flush the outstanding NVME IOs if fc4 type enabled. */
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
-		lpfc_sli_flush_nvme_rings(phba);
+	/* Flush all driver's outstanding I/Os as we are to reset */
+	lpfc_sli_flush_io_rings(phba);
 
 	/* stop all timers */
 	lpfc_stop_hba_timers(phba);
@@ -13141,12 +12999,8 @@ lpfc_sli4_prep_dev_for_perm_failure(struct lpfc_hba *phba)
 	/* stop all timers */
 	lpfc_stop_hba_timers(phba);
 
-	/* Clean up all driver's outstanding SCSI I/Os */
-	lpfc_sli_flush_fcp_rings(phba);
-
-	/* Flush the outstanding NVME IOs if fc4 type enabled. */
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
-		lpfc_sli_flush_nvme_rings(phba);
+	/* Clean up all driver's outstanding I/Os */
+	lpfc_sli_flush_io_rings(phba);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index f66859d928ac..a227e36cbdc2 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1830,7 +1830,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	 */
 	spin_lock_irqsave(&phba->hbalock, flags);
 	/* driver queued commands are in process of being flushed */
-	if (phba->hba_flag & HBA_NVME_IOQ_FLUSH) {
+	if (phba->hba_flag & HBA_IOQ_FLUSH) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
 				 "6139 Driver in reset cleanup - flushing "
@@ -2091,11 +2091,11 @@ lpfc_release_nvme_buf(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_ncmd)
 				lpfc_ncmd->cur_iocbq.sli4_xritag,
 				lpfc_ncmd->cur_iocbq.iotag);
 
-		spin_lock_irqsave(&qp->abts_nvme_buf_list_lock, iflag);
+		spin_lock_irqsave(&qp->abts_io_buf_list_lock, iflag);
 		list_add_tail(&lpfc_ncmd->list,
-			&qp->lpfc_abts_nvme_buf_list);
+			&qp->lpfc_abts_io_buf_list);
 		qp->abts_nvme_io_bufs++;
-		spin_unlock_irqrestore(&qp->abts_nvme_buf_list_lock, iflag);
+		spin_unlock_irqrestore(&qp->abts_io_buf_list_lock, iflag);
 	} else
 		lpfc_release_io_buf(phba, (struct lpfc_io_buf *)lpfc_ncmd, qp);
 }
@@ -2220,7 +2220,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 		if (unlikely(!ret)) {
 			pending = 0;
 			for (i = 0; i < phba->cfg_hdw_queue; i++) {
-				pring = phba->sli4_hba.hdwq[i].nvme_wq->pring;
+				pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 				if (!pring)
 					continue;
 				if (pring->txcmplq_cnt)
@@ -2624,6 +2624,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
  * lpfc_sli4_nvme_xri_aborted - Fast-path process of NVME xri abort
  * @phba: pointer to lpfc hba data structure.
  * @axri: pointer to the fcp xri abort wcqe structure.
+ * @lpfc_ncmd: The nvme job structure for the request being aborted.
  *
  * This routine is invoked by the worker thread to process a SLI4 fast-path
  * NVME aborted xri.  Aborted NVME IO commands are completed to the transport
@@ -2631,59 +2632,33 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
  **/
 void
 lpfc_sli4_nvme_xri_aborted(struct lpfc_hba *phba,
-			   struct sli4_wcqe_xri_aborted *axri, int idx)
+			   struct sli4_wcqe_xri_aborted *axri,
+			   struct lpfc_io_buf *lpfc_ncmd)
 {
 	uint16_t xri = bf_get(lpfc_wcqe_xa_xri, axri);
-	struct lpfc_io_buf *lpfc_ncmd, *next_lpfc_ncmd;
 	struct nvmefc_fcp_req *nvme_cmd = NULL;
-	struct lpfc_nodelist *ndlp;
-	struct lpfc_sli4_hdw_queue *qp;
-	unsigned long iflag = 0;
+	struct lpfc_nodelist *ndlp = lpfc_ncmd->ndlp;
 
-	if (!(phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME))
-		return;
-	qp = &phba->sli4_hba.hdwq[idx];
-	spin_lock_irqsave(&phba->hbalock, iflag);
-	spin_lock(&qp->abts_nvme_buf_list_lock);
-	list_for_each_entry_safe(lpfc_ncmd, next_lpfc_ncmd,
-				 &qp->lpfc_abts_nvme_buf_list, list) {
-		if (lpfc_ncmd->cur_iocbq.sli4_xritag == xri) {
-			list_del_init(&lpfc_ncmd->list);
-			qp->abts_nvme_io_bufs--;
-			lpfc_ncmd->flags &= ~LPFC_SBUF_XBUSY;
-			lpfc_ncmd->status = IOSTAT_SUCCESS;
-			spin_unlock(&qp->abts_nvme_buf_list_lock);
-
-			spin_unlock_irqrestore(&phba->hbalock, iflag);
-			ndlp = lpfc_ncmd->ndlp;
-			if (ndlp)
-				lpfc_sli4_abts_err_handler(phba, ndlp, axri);
-
-			lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-					"6311 nvme_cmd x%px xri x%x tag x%x "
-					"abort complete and xri released\n",
-					lpfc_ncmd->nvmeCmd, xri,
-					lpfc_ncmd->cur_iocbq.iotag);
-
-			/* Aborted NVME commands are required to not complete
-			 * before the abort exchange command fully completes.
-			 * Once completed, it is available via the put list.
-			 */
-			if (lpfc_ncmd->nvmeCmd) {
-				nvme_cmd = lpfc_ncmd->nvmeCmd;
-				nvme_cmd->done(nvme_cmd);
-				lpfc_ncmd->nvmeCmd = NULL;
-			}
-			lpfc_release_nvme_buf(phba, lpfc_ncmd);
-			return;
-		}
-	}
-	spin_unlock(&qp->abts_nvme_buf_list_lock);
-	spin_unlock_irqrestore(&phba->hbalock, iflag);
 
-	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6312 XRI Aborted xri x%x not found\n", xri);
+	if (ndlp)
+		lpfc_sli4_abts_err_handler(phba, ndlp, axri);
 
+	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
+			"6311 nvme_cmd %p xri x%x tag x%x abort complete and "
+			"xri released\n",
+			lpfc_ncmd->nvmeCmd, xri,
+			lpfc_ncmd->cur_iocbq.iotag);
+
+	/* Aborted NVME commands are required to not complete
+	 * before the abort exchange command fully completes.
+	 * Once completed, it is available via the put list.
+	 */
+	if (lpfc_ncmd->nvmeCmd) {
+		nvme_cmd = lpfc_ncmd->nvmeCmd;
+		nvme_cmd->done(nvme_cmd);
+		lpfc_ncmd->nvmeCmd = NULL;
+	}
+	lpfc_release_nvme_buf(phba, lpfc_ncmd);
 }
 
 /**
@@ -2705,13 +2680,13 @@ lpfc_nvme_wait_for_io_drain(struct lpfc_hba *phba)
 	if (phba->sli_rev < LPFC_SLI_REV4 || !phba->sli4_hba.hdwq)
 		return;
 
-	/* Cycle through all NVME rings and make sure all outstanding
+	/* Cycle through all IO rings and make sure all outstanding
 	 * WQEs have been removed from the txcmplqs.
 	 */
 	for (i = 0; i < phba->cfg_hdw_queue; i++) {
-		if (!phba->sli4_hba.hdwq[i].nvme_wq)
+		if (!phba->sli4_hba.hdwq[i].io_wq)
 			continue;
-		pring = phba->sli4_hba.hdwq[i].nvme_wq->pring;
+		pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 
 		if (!pring)
 			continue;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 253a9fdd245e..9884228800a5 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1026,7 +1026,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 		 * WQE release CQE
 		 */
 		ctxp->flag |= LPFC_NVMET_DEFER_WQFULL;
-		wq = ctxp->hdwq->nvme_wq;
+		wq = ctxp->hdwq->io_wq;
 		pring = wq->pring;
 		spin_lock_irqsave(&pring->ring_lock, iflags);
 		list_add_tail(&nvmewqeq->list, &wq->wqfull_list);
@@ -1104,7 +1104,7 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		lpfc_nvmet_unsol_fcp_issue_abort(phba, ctxp, ctxp->sid,
 						 ctxp->oxid);
-		wq = ctxp->hdwq->nvme_wq;
+		wq = ctxp->hdwq->io_wq;
 		lpfc_nvmet_wqfull_flush(phba, wq, ctxp);
 		return;
 	}
@@ -1918,7 +1918,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 	if (phba->targetport) {
 		tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
-			wq = phba->sli4_hba.hdwq[qidx].nvme_wq;
+			wq = phba->sli4_hba.hdwq[qidx].io_wq;
 			lpfc_nvmet_wqfull_flush(phba, wq, NULL);
 		}
 		tgtp->tport_unreg_cmp = &tport_unreg_cmp;
@@ -3295,7 +3295,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 	 */
 	spin_lock_irqsave(&phba->hbalock, flags);
 	/* driver queued commands are in process of being flushed */
-	if (phba->hba_flag & HBA_NVME_IOQ_FLUSH) {
+	if (phba->hba_flag & HBA_IOQ_FLUSH) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
 		atomic_inc(&tgtp->xmt_abort_rsp_error);
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index fb7df209c0aa..7c65bd652c4d 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -537,29 +537,32 @@ lpfc_sli4_vport_delete_fcp_xri_aborted(struct lpfc_vport *vport)
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		qp = &phba->sli4_hba.hdwq[idx];
 
-		spin_lock(&qp->abts_scsi_buf_list_lock);
+		spin_lock(&qp->abts_io_buf_list_lock);
 		list_for_each_entry_safe(psb, next_psb,
-					 &qp->lpfc_abts_scsi_buf_list, list) {
+					 &qp->lpfc_abts_io_buf_list, list) {
+			if (psb->cur_iocbq.iocb_flag == LPFC_IO_NVME)
+				continue;
+
 			if (psb->rdata && psb->rdata->pnode &&
 			    psb->rdata->pnode->vport == vport)
 				psb->rdata = NULL;
 		}
-		spin_unlock(&qp->abts_scsi_buf_list_lock);
+		spin_unlock(&qp->abts_io_buf_list_lock);
 	}
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
 }
 
 /**
- * lpfc_sli4_fcp_xri_aborted - Fast-path process of fcp xri abort
+ * lpfc_sli4_io_xri_aborted - Fast-path process of fcp xri abort
  * @phba: pointer to lpfc hba data structure.
  * @axri: pointer to the fcp xri abort wcqe structure.
  *
  * This routine is invoked by the worker thread to process a SLI4 fast-path
- * FCP aborted xri.
+ * FCP or NVME aborted xri.
  **/
 void
-lpfc_sli4_fcp_xri_aborted(struct lpfc_hba *phba,
-			  struct sli4_wcqe_xri_aborted *axri, int idx)
+lpfc_sli4_io_xri_aborted(struct lpfc_hba *phba,
+			 struct sli4_wcqe_xri_aborted *axri, int idx)
 {
 	uint16_t xri = bf_get(lpfc_wcqe_xa_xri, axri);
 	uint16_t rxid = bf_get(lpfc_wcqe_xa_remote_xid, axri);
@@ -577,16 +580,25 @@ lpfc_sli4_fcp_xri_aborted(struct lpfc_hba *phba,
 
 	qp = &phba->sli4_hba.hdwq[idx];
 	spin_lock_irqsave(&phba->hbalock, iflag);
-	spin_lock(&qp->abts_scsi_buf_list_lock);
+	spin_lock(&qp->abts_io_buf_list_lock);
 	list_for_each_entry_safe(psb, next_psb,
-		&qp->lpfc_abts_scsi_buf_list, list) {
+		&qp->lpfc_abts_io_buf_list, list) {
 		if (psb->cur_iocbq.sli4_xritag == xri) {
-			list_del(&psb->list);
-			qp->abts_scsi_io_bufs--;
+			list_del_init(&psb->list);
 			psb->exch_busy = 0;
 			psb->status = IOSTAT_SUCCESS;
-			spin_unlock(
-				&qp->abts_scsi_buf_list_lock);
+#ifdef BUILD_NVME
+			if (psb->cur_iocbq.iocb_flag == LPFC_IO_NVME) {
+				qp->abts_nvme_io_bufs--;
+				spin_unlock(&qp->abts_io_buf_list_lock);
+				spin_unlock_irqrestore(&phba->hbalock, iflag);
+				lpfc_sli4_nvme_xri_aborted(phba, axri, psb);
+				return;
+			}
+#endif
+			qp->abts_scsi_io_bufs--;
+			spin_unlock(&qp->abts_io_buf_list_lock);
+
 			if (psb->rdata && psb->rdata->pnode)
 				ndlp = psb->rdata->pnode;
 			else
@@ -605,12 +617,12 @@ lpfc_sli4_fcp_xri_aborted(struct lpfc_hba *phba,
 			return;
 		}
 	}
-	spin_unlock(&qp->abts_scsi_buf_list_lock);
+	spin_unlock(&qp->abts_io_buf_list_lock);
 	for (i = 1; i <= phba->sli.last_iotag; i++) {
 		iocbq = phba->sli.iocbq_lookup[i];
 
-		if (!(iocbq->iocb_flag &  LPFC_IO_FCP) ||
-			(iocbq->iocb_flag & LPFC_IO_LIBDFC))
+		if (!(iocbq->iocb_flag & LPFC_IO_FCP) ||
+		    (iocbq->iocb_flag & LPFC_IO_LIBDFC))
 			continue;
 		if (iocbq->sli4_xritag != xri)
 			continue;
@@ -836,11 +848,11 @@ lpfc_release_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_io_buf *psb)
 
 	qp = psb->hdwq;
 	if (psb->exch_busy) {
-		spin_lock_irqsave(&qp->abts_scsi_buf_list_lock, iflag);
+		spin_lock_irqsave(&qp->abts_io_buf_list_lock, iflag);
 		psb->pCmd = NULL;
-		list_add_tail(&psb->list, &qp->lpfc_abts_scsi_buf_list);
+		list_add_tail(&psb->list, &qp->lpfc_abts_io_buf_list);
 		qp->abts_scsi_io_bufs++;
-		spin_unlock_irqrestore(&qp->abts_scsi_buf_list_lock, iflag);
+		spin_unlock_irqrestore(&qp->abts_io_buf_list_lock, iflag);
 	} else {
 		lpfc_release_io_buf(phba, (struct lpfc_io_buf *)psb, qp);
 	}
@@ -4800,7 +4812,7 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 
 	spin_lock_irqsave(&phba->hbalock, flags);
 	/* driver queued commands are in process of being flushed */
-	if (phba->hba_flag & HBA_FCP_IOQ_FLUSH) {
+	if (phba->hba_flag & HBA_IOQ_FLUSH) {
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_FCP,
 			"3168 SCSI Layer abort requested I/O has been "
 			"flushed by LLD.\n");
@@ -4821,7 +4833,7 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 
 	iocb = &lpfc_cmd->cur_iocbq;
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].fcp_wq->pring;
+		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring;
 		if (!pring_s4) {
 			ret = FAILED;
 			goto out_unlock_buf;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 56c682be8fe7..d240ea4989e3 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3978,7 +3978,7 @@ lpfc_sli_abort_fcp_rings(struct lpfc_hba *phba)
 	/* Look on all the FCP Rings for the iotag */
 	if (phba->sli_rev >= LPFC_SLI_REV4) {
 		for (i = 0; i < phba->cfg_hdw_queue; i++) {
-			pring = phba->sli4_hba.hdwq[i].fcp_wq->pring;
+			pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 			lpfc_sli_abort_iocb_ring(phba, pring);
 		}
 	} else {
@@ -3988,17 +3988,17 @@ lpfc_sli_abort_fcp_rings(struct lpfc_hba *phba)
 }
 
 /**
- * lpfc_sli_flush_fcp_rings - flush all iocbs in the fcp ring
+ * lpfc_sli_flush_io_rings - flush all iocbs in the IO ring
  * @phba: Pointer to HBA context object.
  *
- * This function flushes all iocbs in the fcp ring and frees all the iocb
+ * This function flushes all iocbs in the IO ring and frees all the iocb
  * objects in txq and txcmplq. This function will not issue abort iocbs
  * for all the iocb commands in txcmplq, they will just be returned with
  * IOERR_SLI_DOWN. This function is invoked with EEH when device's PCI
  * slot has been permanently disabled.
  **/
 void
-lpfc_sli_flush_fcp_rings(struct lpfc_hba *phba)
+lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
 {
 	LIST_HEAD(txq);
 	LIST_HEAD(txcmplq);
@@ -4009,13 +4009,13 @@ lpfc_sli_flush_fcp_rings(struct lpfc_hba *phba)
 
 	spin_lock_irq(&phba->hbalock);
 	/* Indicate the I/O queues are flushed */
-	phba->hba_flag |= HBA_FCP_IOQ_FLUSH;
+	phba->hba_flag |= HBA_IOQ_FLUSH;
 	spin_unlock_irq(&phba->hbalock);
 
 	/* Look on all the FCP Rings for the iotag */
 	if (phba->sli_rev >= LPFC_SLI_REV4) {
 		for (i = 0; i < phba->cfg_hdw_queue; i++) {
-			pring = phba->sli4_hba.hdwq[i].fcp_wq->pring;
+			pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 
 			spin_lock_irq(&pring->ring_lock);
 			/* Retrieve everything on txq */
@@ -4063,56 +4063,6 @@ lpfc_sli_flush_fcp_rings(struct lpfc_hba *phba)
 }
 
 /**
- * lpfc_sli_flush_nvme_rings - flush all wqes in the nvme rings
- * @phba: Pointer to HBA context object.
- *
- * This function flushes all wqes in the nvme rings and frees all resources
- * in the txcmplq. This function does not issue abort wqes for the IO
- * commands in txcmplq, they will just be returned with
- * IOERR_SLI_DOWN. This function is invoked with EEH when device's PCI
- * slot has been permanently disabled.
- **/
-void
-lpfc_sli_flush_nvme_rings(struct lpfc_hba *phba)
-{
-	LIST_HEAD(txcmplq);
-	struct lpfc_sli_ring  *pring;
-	uint32_t i;
-	struct lpfc_iocbq *piocb, *next_iocb;
-
-	if ((phba->sli_rev < LPFC_SLI_REV4) ||
-	    !(phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME))
-		return;
-
-	/* Hint to other driver operations that a flush is in progress. */
-	spin_lock_irq(&phba->hbalock);
-	phba->hba_flag |= HBA_NVME_IOQ_FLUSH;
-	spin_unlock_irq(&phba->hbalock);
-
-	/* Cycle through all NVME rings and complete each IO with
-	 * a local driver reason code.  This is a flush so no
-	 * abort exchange to FW.
-	 */
-	for (i = 0; i < phba->cfg_hdw_queue; i++) {
-		pring = phba->sli4_hba.hdwq[i].nvme_wq->pring;
-
-		spin_lock_irq(&pring->ring_lock);
-		list_for_each_entry_safe(piocb, next_iocb,
-					 &pring->txcmplq, list)
-			piocb->iocb_flag &= ~LPFC_IO_ON_TXCMPLQ;
-		/* Retrieve everything on the txcmplq */
-		list_splice_init(&pring->txcmplq, &txcmplq);
-		pring->txcmplq_cnt = 0;
-		spin_unlock_irq(&pring->ring_lock);
-
-		/* Flush the txcmpq &&&PAE */
-		lpfc_sli_cancel_iocbs(phba, &txcmplq,
-				      IOSTAT_LOCAL_REJECT,
-				      IOERR_SLI_DOWN);
-	}
-}
-
-/**
  * lpfc_sli_brdready_s3 - Check for sli3 host ready status
  * @phba: Pointer to HBA context object.
  * @mask: Bit mask to be checked.
@@ -5603,10 +5553,8 @@ lpfc_sli4_arm_cqeq_intr(struct lpfc_hba *phba)
 		for (qidx = 0; qidx < phba->cfg_hdw_queue; qidx++) {
 			qp = &sli4_hba->hdwq[qidx];
 			/* ARM the corresponding CQ */
-			sli4_hba->sli4_write_cq_db(phba, qp->fcp_cq, 0,
-						   LPFC_QUEUE_REARM);
-			sli4_hba->sli4_write_cq_db(phba, qp->nvme_cq, 0,
-						   LPFC_QUEUE_REARM);
+			sli4_hba->sli4_write_cq_db(phba, qp[qidx].io_cq, 0,
+						LPFC_QUEUE_REARM);
 		}
 
 		/* Loop thru all IRQ vectors */
@@ -7262,7 +7210,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	else
 		phba->hba_flag &= ~HBA_FIP_SUPPORT;
 
-	phba->hba_flag &= ~HBA_FCP_IOQ_FLUSH;
+	phba->hba_flag &= ~HBA_IOQ_FLUSH;
 
 	if (phba->sli_rev != LPFC_SLI_REV4) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
@@ -9930,7 +9878,7 @@ __lpfc_sli_issue_iocb_s4(struct lpfc_hba *phba, uint32_t ring_number,
 	/* Get the WQ */
 	if ((piocb->iocb_flag & LPFC_IO_FCP) ||
 	    (piocb->iocb_flag & LPFC_USE_FCPWQIDX)) {
-		wq = phba->sli4_hba.hdwq[piocb->hba_wqidx].fcp_wq;
+		wq = phba->sli4_hba.hdwq[piocb->hba_wqidx].io_wq;
 	} else {
 		wq = phba->sli4_hba.els_wq;
 	}
@@ -10077,7 +10025,7 @@ lpfc_sli4_calc_ring(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
 			lpfc_cmd = (struct lpfc_io_buf *)piocb->context1;
 			piocb->hba_wqidx = lpfc_cmd->hdwq_no;
 		}
-		return phba->sli4_hba.hdwq[piocb->hba_wqidx].fcp_wq->pring;
+		return phba->sli4_hba.hdwq[piocb->hba_wqidx].io_wq->pring;
 	} else {
 		if (unlikely(!phba->sli4_hba.els_wq))
 			return NULL;
@@ -10530,7 +10478,7 @@ lpfc_sli4_queue_init(struct lpfc_hba *phba)
 	INIT_LIST_HEAD(&psli->mboxq_cmpl);
 	/* Initialize list headers for txq and txcmplq as double linked lists */
 	for (i = 0; i < phba->cfg_hdw_queue; i++) {
-		pring = phba->sli4_hba.hdwq[i].fcp_wq->pring;
+		pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 		pring->flag = 0;
 		pring->ringno = LPFC_FCP_RING;
 		pring->txcmplq_cnt = 0;
@@ -10549,16 +10497,6 @@ lpfc_sli4_queue_init(struct lpfc_hba *phba)
 	spin_lock_init(&pring->ring_lock);
 
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		for (i = 0; i < phba->cfg_hdw_queue; i++) {
-			pring = phba->sli4_hba.hdwq[i].nvme_wq->pring;
-			pring->flag = 0;
-			pring->ringno = LPFC_FCP_RING;
-			pring->txcmplq_cnt = 0;
-			INIT_LIST_HEAD(&pring->txq);
-			INIT_LIST_HEAD(&pring->txcmplq);
-			INIT_LIST_HEAD(&pring->iocb_continueq);
-			spin_lock_init(&pring->ring_lock);
-		}
 		pring = phba->sli4_hba.nvmels_wq->pring;
 		pring->flag = 0;
 		pring->ringno = LPFC_ELS_RING;
@@ -11522,7 +11460,7 @@ lpfc_sli_abort_iocb(struct lpfc_vport *vport, struct lpfc_sli_ring *pring,
 	int i;
 
 	/* all I/Os are in process of being flushed */
-	if (phba->hba_flag & HBA_FCP_IOQ_FLUSH)
+	if (phba->hba_flag & HBA_IOQ_FLUSH)
 		return errcnt;
 
 	for (i = 1; i <= phba->sli.last_iotag; i++) {
@@ -11632,7 +11570,7 @@ lpfc_sli_abort_taskmgmt(struct lpfc_vport *vport, struct lpfc_sli_ring *pring,
 	spin_lock_irqsave(&phba->hbalock, iflags);
 
 	/* all I/Os are in process of being flushed */
-	if (phba->hba_flag & HBA_FCP_IOQ_FLUSH) {
+	if (phba->hba_flag & HBA_IOQ_FLUSH) {
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 		return 0;
 	}
@@ -11656,7 +11594,7 @@ lpfc_sli_abort_taskmgmt(struct lpfc_vport *vport, struct lpfc_sli_ring *pring,
 
 		if (phba->sli_rev == LPFC_SLI_REV4) {
 			pring_s4 =
-			    phba->sli4_hba.hdwq[iocbq->hba_wqidx].fcp_wq->pring;
+			    phba->sli4_hba.hdwq[iocbq->hba_wqidx].io_wq->pring;
 			if (!pring_s4) {
 				spin_unlock(&lpfc_cmd->buf_lock);
 				continue;
@@ -13365,8 +13303,13 @@ lpfc_sli4_sp_handle_abort_xri_wcqe(struct lpfc_hba *phba,
 	unsigned long iflags;
 
 	switch (cq->subtype) {
-	case LPFC_FCP:
-		lpfc_sli4_fcp_xri_aborted(phba, wcqe, cq->hdwq);
+	case LPFC_IO:
+		lpfc_sli4_io_xri_aborted(phba, wcqe, cq->hdwq);
+		if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
+			/* Notify aborted XRI for NVME work queue */
+			if (phba->nvmet_support)
+				lpfc_sli4_nvmet_xri_aborted(phba, wcqe);
+		}
 		workposted = false;
 		break;
 	case LPFC_NVME_LS: /* NVME LS uses ELS resources */
@@ -13384,15 +13327,6 @@ lpfc_sli4_sp_handle_abort_xri_wcqe(struct lpfc_hba *phba,
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 		workposted = true;
 		break;
-	case LPFC_NVME:
-		/* Notify aborted XRI for NVME work queue */
-		if (phba->nvmet_support)
-			lpfc_sli4_nvmet_xri_aborted(phba, wcqe);
-		else
-			lpfc_sli4_nvme_xri_aborted(phba, wcqe, cq->hdwq);
-
-		workposted = false;
-		break;
 	default:
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 				"0603 Invalid CQ subtype %d: "
@@ -13720,7 +13654,7 @@ __lpfc_sli4_sp_process_cq(struct lpfc_queue *cq)
 						&delay);
 		break;
 	case LPFC_WCQ:
-		if (cq->subtype == LPFC_FCP || cq->subtype == LPFC_NVME)
+		if (cq->subtype == LPFC_IO)
 			workposted |= __lpfc_sli4_process_cq(phba, cq,
 						lpfc_sli4_fp_handle_cqe,
 						&delay);
@@ -14037,10 +13971,7 @@ lpfc_sli4_fp_handle_cqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 		cq->CQ_wq++;
 		/* Process the WQ complete event */
 		phba->last_completion_time = jiffies;
-		if ((cq->subtype == LPFC_FCP) || (cq->subtype == LPFC_NVME))
-			lpfc_sli4_fp_handle_fcp_wcqe(phba, cq,
-				(struct lpfc_wcqe_complete *)&wcqe);
-		if (cq->subtype == LPFC_NVME_LS)
+		if (cq->subtype == LPFC_IO || cq->subtype == LPFC_NVME_LS)
 			lpfc_sli4_fp_handle_fcp_wcqe(phba, cq,
 				(struct lpfc_wcqe_complete *)&wcqe);
 		break;
@@ -19507,7 +19438,7 @@ lpfc_drain_txq(struct lpfc_hba *phba)
 
 	if (phba->link_flag & LS_MDS_LOOPBACK) {
 		/* MDS WQE are posted only to first WQ*/
-		wq = phba->sli4_hba.hdwq[0].fcp_wq;
+		wq = phba->sli4_hba.hdwq[0].io_wq;
 		if (unlikely(!wq))
 			return 0;
 		pring = wq->pring;
@@ -19758,10 +19689,10 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 	/* NVME_FCREQ and NVME_ABTS requests */
 	if (pwqe->iocb_flag & LPFC_IO_NVME) {
 		/* Get the IO distribution (hba_wqidx) for WQ assignment. */
-		wq = qp->nvme_wq;
+		wq = qp->io_wq;
 		pring = wq->pring;
 
-		bf_set(wqe_cqid, &wqe->generic.wqe_com, qp->nvme_cq_map);
+		bf_set(wqe_cqid, &wqe->generic.wqe_com, qp->io_cq_map);
 
 		lpfc_qp_spin_lock_irqsave(&pring->ring_lock, iflags,
 					  qp, wq_access);
@@ -19778,7 +19709,7 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 	/* NVMET requests */
 	if (pwqe->iocb_flag & LPFC_IO_NVMET) {
 		/* Get the IO distribution (hba_wqidx) for WQ assignment. */
-		wq = qp->nvme_wq;
+		wq = qp->io_wq;
 		pring = wq->pring;
 
 		ctxp = pwqe->context2;
@@ -19789,7 +19720,7 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 		}
 		bf_set(wqe_xri_tag, &pwqe->wqe.xmit_bls_rsp.wqe_com,
 		       pwqe->sli4_xritag);
-		bf_set(wqe_cqid, &wqe->generic.wqe_com, qp->nvme_cq_map);
+		bf_set(wqe_cqid, &wqe->generic.wqe_com, qp->io_cq_map);
 
 		lpfc_qp_spin_lock_irqsave(&pring->ring_lock, iflags,
 					  qp, wq_access);
@@ -19836,9 +19767,7 @@ void lpfc_snapshot_mxp(struct lpfc_hba *phba, u32 hwqid)
 	if (multixri_pool->stat_snapshot_taken == LPFC_MXP_SNAPSHOT_TAKEN) {
 		pvt_pool = &qp->p_multixri_pool->pvt_pool;
 		pbl_pool = &qp->p_multixri_pool->pbl_pool;
-		txcmplq_cnt = qp->fcp_wq->pring->txcmplq_cnt;
-		if (qp->nvme_wq)
-			txcmplq_cnt += qp->nvme_wq->pring->txcmplq_cnt;
+		txcmplq_cnt = qp->io_wq->pring->txcmplq_cnt;
 
 		multixri_pool->stat_pbl_count = pbl_pool->count;
 		multixri_pool->stat_pvt_count = pvt_pool->count;
@@ -19908,12 +19837,9 @@ void lpfc_adjust_high_watermark(struct lpfc_hba *phba, u32 hwqid)
 	watermark_max = xri_limit;
 	watermark_min = xri_limit / 2;
 
-	txcmplq_cnt = qp->fcp_wq->pring->txcmplq_cnt;
+	txcmplq_cnt = qp->io_wq->pring->txcmplq_cnt;
 	abts_io_bufs = qp->abts_scsi_io_bufs;
-	if (qp->nvme_wq) {
-		txcmplq_cnt += qp->nvme_wq->pring->txcmplq_cnt;
-		abts_io_bufs += qp->abts_nvme_io_bufs;
-	}
+	abts_io_bufs += qp->abts_nvme_io_bufs;
 
 	new_watermark = txcmplq_cnt + abts_io_bufs;
 	new_watermark = min(watermark_max, new_watermark);
@@ -20188,12 +20114,9 @@ void lpfc_release_io_buf(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_ncmd,
 		pbl_pool = &qp->p_multixri_pool->pbl_pool;
 		pvt_pool = &qp->p_multixri_pool->pvt_pool;
 
-		txcmplq_cnt = qp->fcp_wq->pring->txcmplq_cnt;
+		txcmplq_cnt = qp->io_wq->pring->txcmplq_cnt;
 		abts_io_bufs = qp->abts_scsi_io_bufs;
-		if (qp->nvme_wq) {
-			txcmplq_cnt += qp->nvme_wq->pring->txcmplq_cnt;
-			abts_io_bufs += qp->abts_nvme_io_bufs;
-		}
+		abts_io_bufs += qp->abts_nvme_io_bufs;
 
 		xri_owned = pvt_pool->count + txcmplq_cnt + abts_io_bufs;
 		xri_limit = qp->p_multixri_pool->xri_limit;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 02275e49be6f..2d1823e449aa 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -114,9 +114,8 @@ enum lpfc_sli4_queue_type {
 enum lpfc_sli4_queue_subtype {
 	LPFC_NONE,
 	LPFC_MBOX,
-	LPFC_FCP,
+	LPFC_IO,
 	LPFC_ELS,
-	LPFC_NVME,
 	LPFC_NVMET,
 	LPFC_NVME_LS,
 	LPFC_USOL
@@ -646,22 +645,17 @@ struct lpfc_eq_intr_info {
 struct lpfc_sli4_hdw_queue {
 	/* Pointers to the constructed SLI4 queues */
 	struct lpfc_queue *hba_eq;  /* Event queues for HBA */
-	struct lpfc_queue *fcp_cq;  /* Fast-path FCP compl queue */
-	struct lpfc_queue *nvme_cq; /* Fast-path NVME compl queue */
-	struct lpfc_queue *fcp_wq;  /* Fast-path FCP work queue */
-	struct lpfc_queue *nvme_wq; /* Fast-path NVME work queue */
-	uint16_t fcp_cq_map;
-	uint16_t nvme_cq_map;
+	struct lpfc_queue *io_cq;   /* Fast-path FCP & NVME compl queue */
+	struct lpfc_queue *io_wq;   /* Fast-path FCP & NVME work queue */
+	uint16_t io_cq_map;
 
 	/* Keep track of IO buffers for this hardware queue */
 	spinlock_t io_buf_list_get_lock;  /* Common buf alloc list lock */
 	struct list_head lpfc_io_buf_list_get;
 	spinlock_t io_buf_list_put_lock;  /* Common buf free list lock */
 	struct list_head lpfc_io_buf_list_put;
-	spinlock_t abts_scsi_buf_list_lock; /* list of aborted SCSI IOs */
-	struct list_head lpfc_abts_scsi_buf_list;
-	spinlock_t abts_nvme_buf_list_lock; /* list of aborted NVME IOs */
-	struct list_head lpfc_abts_nvme_buf_list;
+	spinlock_t abts_io_buf_list_lock; /* list of aborted IOs */
+	struct list_head lpfc_abts_io_buf_list;
 	uint32_t total_io_bufs;
 	uint32_t get_io_bufs;
 	uint32_t put_io_bufs;
@@ -857,8 +851,8 @@ struct lpfc_sli4_hba {
 	struct lpfc_queue **cq_lookup;
 	struct list_head lpfc_els_sgl_list;
 	struct list_head lpfc_abts_els_sgl_list;
-	spinlock_t abts_scsi_buf_list_lock; /* list of aborted SCSI IOs */
-	struct list_head lpfc_abts_scsi_buf_list;
+	spinlock_t abts_io_buf_list_lock; /* list of aborted SCSI IOs */
+	struct list_head lpfc_abts_io_buf_list;
 	struct list_head lpfc_nvmet_sgl_list;
 	spinlock_t abts_nvmet_buf_list_lock; /* list of aborted NVMET IOs */
 	struct list_head lpfc_abts_nvmet_ctx_list;
@@ -1063,10 +1057,11 @@ int lpfc_sli4_resume_rpi(struct lpfc_nodelist *,
 			void (*)(struct lpfc_hba *, LPFC_MBOXQ_t *), void *);
 void lpfc_sli4_fcp_xri_abort_event_proc(struct lpfc_hba *);
 void lpfc_sli4_els_xri_abort_event_proc(struct lpfc_hba *);
-void lpfc_sli4_fcp_xri_aborted(struct lpfc_hba *,
-			       struct sli4_wcqe_xri_aborted *, int);
 void lpfc_sli4_nvme_xri_aborted(struct lpfc_hba *phba,
-				struct sli4_wcqe_xri_aborted *axri, int idx);
+				struct sli4_wcqe_xri_aborted *axri,
+				struct lpfc_io_buf *lpfc_ncmd);
+void lpfc_sli4_io_xri_aborted(struct lpfc_hba *phba,
+			      struct sli4_wcqe_xri_aborted *axri, int idx);
 void lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 				 struct sli4_wcqe_xri_aborted *axri);
 void lpfc_sli4_els_xri_aborted(struct lpfc_hba *,
-- 
2.13.7

