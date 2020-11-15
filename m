Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD962B389C
	for <lists+linux-scsi@lfdr.de>; Sun, 15 Nov 2020 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKOT1B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Nov 2020 14:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgKOT06 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 15 Nov 2020 14:26:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA23C0613CF
        for <linux-scsi@vger.kernel.org>; Sun, 15 Nov 2020 11:26:58 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y7so11307364pfq.11
        for <linux-scsi@vger.kernel.org>; Sun, 15 Nov 2020 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=+IvJdfQj+UJrGageMMMzRGv+3zaIN1nFGpYIcSuXTqQ=;
        b=cEaAV7o9e72j5uRtgclELcPWKeMHFeCu7yetFtRLguJMtBsP/y5dIsrb4E9eyubam0
         wGmRX3pHA00Zm7gaSKsSpGaoyKfodkkTehrv/KlJs5cCgG6pBvDCRNyW/w9Nm402+KoK
         LiFPGURvhtWh+ZCpbdV5tJaby74qxdp7enMi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=+IvJdfQj+UJrGageMMMzRGv+3zaIN1nFGpYIcSuXTqQ=;
        b=ArXuprTqcHJWw1sVxSw6Uq3UC7uRg+qAjVhaA4gofbWlQEByREJOGej+pTIECfdp1p
         koL9YKmk/gUXn1UQDBnXDOqPR0B2QBxlqj4TzN7uTa1VLOiXgQrbnglmUj/pJ7S2hPnU
         g0ie3iBOZAbU2jghLzWwjgphqJjjYyVSEXMSVp9r1/Dy7kIR/JeP72czgkgoKjSfFyBM
         tPBkvvlty8wB22N/nGlJzDf41ELMv5LPKpct/lvTiPnarUMCCZqdNHQSyrdp77OHs5ID
         VymASoK1Qt+BZjld4MXAoX/e6FcyBxxg98cxNfvbZ7sPGTMT3IEKdEp+xw7+3hyLl2jQ
         WHZw==
X-Gm-Message-State: AOAM532B/V8NrWmvQnUDxjN9TBN206SrWQWKs+pxacgqDmP02tjnDLLS
        u5ctvGycmCZ2dvL1GIPPCPPyp0zzcyW7rfsD4yJk1dOofrhkdEbxOHOE2OkYw/uKm7ITEkhxEFM
        Ohj2ISypDa419GslcJHj1FeNt+PW1XbIhFhU+Dc5BcccQbzWKXiUZIXe+V+wLCsJIPJf90kAFWW
        VPHHY=
X-Google-Smtp-Source: ABdhPJySsiBMf/ELmVBnTbTZa8IAlH5CVKbROepfjt3Ip1MWsgHkHHFF2XcQZ7JPmrfJbzEOsuJEYw==
X-Received: by 2002:a65:4bcb:: with SMTP id p11mr10295812pgr.358.1605468416083;
        Sun, 15 Nov 2020 11:26:56 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v126sm15864604pfb.137.2020.11.15.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:26:55 -0800 (PST)
From:   James Smart <james.smart@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 02/17] lpfc: Rework locations of ndlp reference taking
Date:   Sun, 15 Nov 2020 11:26:31 -0800
Message-Id: <20201115192646.12977-3-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201115192646.12977-1-james.smart@broadcom.com>
References: <20201115192646.12977-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b44ba105b42a3ee8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000b44ba105b42a3ee8
Content-Transfer-Encoding: 8bit

Now that the driver has gone to a normal ref interface (with no odd logic)
the discovery logic needs to be updated to reworked so that it properly
takes references when it should and give them up when it should.

Rework the driver for the following get/put model:
- Move gets to just before an IO is issued. Add gets for places where
  an IO was issued without one.
- Ensure that failures from lpfc_nlp_get() are handled by the driver.
- Check and fix the placement of lpfc_nlp_puts relative to io completions.
  Note: some of these paths may not release the reference on the exact io
  completion as the reference is held as the code takes another step in
  the discovery thread and which may cause another io to be issued.
- Rearrange some code for error processing and calling lpfc_nlp_put.
- Fix some places of incorrect reference freeing that was causing the
  premature releasing of the structure.
- Nvmet plogi handling performs unreg_rpi's. The reference counts
  were unbalanced resulting in premature node removal. In some cases
  this caused loss of node discovery. Corrected the reftaking around
  nvmet plogis.

Nodes that experience devloss now get released from the node list now that
there is a proper reference taking.

Co-developed-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c       |  71 +--
 drivers/scsi/lpfc/lpfc_ct.c        |  56 ++-
 drivers/scsi/lpfc/lpfc_disc.h      |   3 +-
 drivers/scsi/lpfc/lpfc_els.c       | 693 +++++++++++++++++++----------
 drivers/scsi/lpfc/lpfc_hbadisc.c   |  12 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c |  28 +-
 drivers/scsi/lpfc/lpfc_nvme.c      |  13 +-
 drivers/scsi/lpfc/lpfc_sli.c       |   9 +-
 8 files changed, 569 insertions(+), 316 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index b13e764b484f..e2f87a0d5c4f 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -329,7 +329,7 @@ lpfc_bsg_send_mgmt_cmd_cmp(struct lpfc_hba *phba,
 	spin_unlock_irqrestore(&phba->hbalock, flags);
 
 	iocb = &dd_data->context_un.iocb;
-	ndlp = iocb->ndlp;
+	ndlp = iocb->cmdiocbq->context_un.ndlp;
 	rmp = iocb->rmp;
 	cmp = cmdiocbq->context2;
 	bmp = cmdiocbq->context3;
@@ -366,8 +366,8 @@ lpfc_bsg_send_mgmt_cmd_cmp(struct lpfc_hba *phba,
 	lpfc_free_bsg_buffers(phba, rmp);
 	lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
 	kfree(bmp);
-	lpfc_sli_release_iocbq(phba, cmdiocbq);
 	lpfc_nlp_put(ndlp);
+	lpfc_sli_release_iocbq(phba, cmdiocbq);
 	kfree(dd_data);
 
 	/* Complete the job if the job is still active */
@@ -408,6 +408,9 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 	/* in case no data is transferred */
 	bsg_reply->reply_payload_rcv_len = 0;
 
+	if (ndlp->nlp_flag & NLP_ELS_SND_MASK)
+		return -ENODEV;
+
 	/* allocate our bsg tracking structure */
 	dd_data = kmalloc(sizeof(struct bsg_job_data), GFP_KERNEL);
 	if (!dd_data) {
@@ -417,20 +420,10 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 		goto no_dd_data;
 	}
 
-	if (!lpfc_nlp_get(ndlp)) {
-		rc = -ENODEV;
-		goto no_ndlp;
-	}
-
-	if (ndlp->nlp_flag & NLP_ELS_SND_MASK) {
-		rc = -ENODEV;
-		goto free_ndlp;
-	}
-
 	cmdiocbq = lpfc_sli_get_iocbq(phba);
 	if (!cmdiocbq) {
 		rc = -ENOMEM;
-		goto free_ndlp;
+		goto free_dd;
 	}
 
 	cmd = &cmdiocbq->iocb;
@@ -496,11 +489,10 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 	cmdiocbq->context1 = dd_data;
 	cmdiocbq->context2 = cmp;
 	cmdiocbq->context3 = bmp;
-	cmdiocbq->context_un.ndlp = ndlp;
+
 	dd_data->type = TYPE_IOCB;
 	dd_data->set_job = job;
 	dd_data->context_un.iocb.cmdiocbq = cmdiocbq;
-	dd_data->context_un.iocb.ndlp = ndlp;
 	dd_data->context_un.iocb.rmp = rmp;
 	job->dd_data = dd_data;
 
@@ -514,8 +506,13 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 		readl(phba->HCregaddr); /* flush */
 	}
 
-	iocb_stat = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, cmdiocbq, 0);
+	cmdiocbq->context_un.ndlp = lpfc_nlp_get(ndlp);
+	if (!cmdiocbq->context_un.ndlp) {
+		rc = -ENODEV;
+		goto free_rmp;
+	}
 
+	iocb_stat = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, cmdiocbq, 0);
 	if (iocb_stat == IOCB_SUCCESS) {
 		spin_lock_irqsave(&phba->hbalock, flags);
 		/* make sure the I/O had not been completed yet */
@@ -532,7 +529,7 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 	}
 
 	/* iocb failed so cleanup */
-	job->dd_data = NULL;
+	lpfc_nlp_put(ndlp);
 
 free_rmp:
 	lpfc_free_bsg_buffers(phba, rmp);
@@ -544,9 +541,7 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 	kfree(bmp);
 free_cmdiocbq:
 	lpfc_sli_release_iocbq(phba, cmdiocbq);
-free_ndlp:
-	lpfc_nlp_put(ndlp);
-no_ndlp:
+free_dd:
 	kfree(dd_data);
 no_dd_data:
 	/* make error code available to userspace */
@@ -640,8 +635,9 @@ lpfc_bsg_rport_els_cmp(struct lpfc_hba *phba,
 		}
 	}
 
-	lpfc_nlp_put(ndlp);
 	lpfc_els_free_iocb(phba, cmdiocbq);
+
+	lpfc_nlp_put(ndlp);
 	kfree(dd_data);
 
 	/* Complete the job if the job is still active */
@@ -718,15 +714,14 @@ lpfc_bsg_rport_els(struct bsg_job *job)
 		goto release_ndlp;
 	}
 
-	rpi = ndlp->nlp_rpi;
-
 	/* Transfer the request payload to allocated command dma buffer */
-
 	sg_copy_to_buffer(job->request_payload.sg_list,
 			  job->request_payload.sg_cnt,
 			  ((struct lpfc_dmabuf *)cmdiocbq->context2)->virt,
 			  cmdsize);
 
+	rpi = ndlp->nlp_rpi;
+
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		cmdiocbq->iocb.ulpContext = phba->sli4_hba.rpi_ids[rpi];
 	else
@@ -752,8 +747,13 @@ lpfc_bsg_rport_els(struct bsg_job *job)
 		readl(phba->HCregaddr); /* flush */
 	}
 
-	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, cmdiocbq, 0);
+	cmdiocbq->context1 = lpfc_nlp_get(ndlp);
+	if (!cmdiocbq->context1) {
+		rc = -EIO;
+		goto linkdown_err;
+	}
 
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, cmdiocbq, 0);
 	if (rc == IOCB_SUCCESS) {
 		spin_lock_irqsave(&phba->hbalock, flags);
 		/* make sure the I/O had not been completed/released */
@@ -769,11 +769,9 @@ lpfc_bsg_rport_els(struct bsg_job *job)
 		rc = -EIO;
 	}
 
-	/* iocb failed so cleanup */
-	job->dd_data = NULL;
+	/* IO issue failed.  Cleanup resources. */
 
 linkdown_err:
-	cmdiocbq->context1 = ndlp;
 	lpfc_els_free_iocb(phba, cmdiocbq);
 
 release_ndlp:
@@ -1471,6 +1469,15 @@ lpfc_issue_ct_rsp(struct lpfc_hba *phba, struct bsg_job *job, uint32_t tag,
 	unsigned long flags;
 	uint32_t creg_val;
 
+	ndlp = lpfc_findnode_did(phba->pport, phba->ct_ctx[tag].SID);
+	if (!ndlp) {
+		lpfc_printf_log(phba, KERN_WARNING, LOG_ELS,
+				"2721 ndlp null for oxid %x SID %x\n",
+				phba->ct_ctx[tag].rxid,
+				phba->ct_ctx[tag].SID);
+		return IOCB_ERROR;
+	}
+
 	/* allocate our bsg tracking structure */
 	dd_data = kmalloc(sizeof(struct bsg_job_data), GFP_KERNEL);
 	if (!dd_data) {
@@ -1561,7 +1568,11 @@ lpfc_issue_ct_rsp(struct lpfc_hba *phba, struct bsg_job *job, uint32_t tag,
 	dd_data->type = TYPE_IOCB;
 	dd_data->set_job = job;
 	dd_data->context_un.iocb.cmdiocbq = ctiocb;
-	dd_data->context_un.iocb.ndlp = ndlp;
+	dd_data->context_un.iocb.ndlp = lpfc_nlp_get(ndlp);
+	if (!dd_data->context_un.iocb.ndlp) {
+		rc = -IOCB_ERROR;
+		goto issue_ct_rsp_exit;
+	}
 	dd_data->context_un.iocb.rmp = NULL;
 	job->dd_data = dd_data;
 
@@ -1576,7 +1587,6 @@ lpfc_issue_ct_rsp(struct lpfc_hba *phba, struct bsg_job *job, uint32_t tag,
 	}
 
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, ctiocb, 0);
-
 	if (rc == IOCB_SUCCESS) {
 		spin_lock_irqsave(&phba->hbalock, flags);
 		/* make sure the I/O had not been completed/released */
@@ -1590,6 +1600,7 @@ lpfc_issue_ct_rsp(struct lpfc_hba *phba, struct bsg_job *job, uint32_t tag,
 
 	/* iocb failed so cleanup */
 	job->dd_data = NULL;
+	lpfc_nlp_put(ndlp);
 
 issue_ct_rsp_exit:
 	lpfc_sli_release_iocbq(phba, ctiocb);
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 32f5d8951b8f..ba5b1c42b8a6 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -548,10 +548,8 @@ lpfc_ct_free_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *ctiocb)
 {
 	struct lpfc_dmabuf *buf_ptr;
 
-	if (ctiocb->context_un.ndlp) {
-		lpfc_nlp_put(ctiocb->context_un.ndlp);
-		ctiocb->context_un.ndlp = NULL;
-	}
+	/* IO job is complete so context is now invalid*/
+	ctiocb->context_un.ndlp = NULL;
 	if (ctiocb->context1) {
 		buf_ptr = (struct lpfc_dmabuf *) ctiocb->context1;
 		lpfc_mbuf_free(phba, buf_ptr->virt, buf_ptr->phys);
@@ -618,7 +616,6 @@ lpfc_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 	/* Save for completion so we can release these resources */
 	geniocb->context1 = (uint8_t *) inp;
 	geniocb->context2 = (uint8_t *) outp;
-	geniocb->context_un.ndlp = lpfc_nlp_get(ndlp);
 
 	/* Fill in payload, bp points to frame payload */
 	icmd->ulpCommand = CMD_GEN_REQUEST64_CR;
@@ -657,16 +654,21 @@ lpfc_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 	geniocb->drvrTimeout = icmd->ulpTimeout + LPFC_DRVR_TIMEOUT;
 	geniocb->vport = vport;
 	geniocb->retry = retry;
+	geniocb->context_un.ndlp = lpfc_nlp_get(ndlp);
+	if (!geniocb->context_un.ndlp)
+		goto out;
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, geniocb, 0);
 
 	if (rc == IOCB_ERROR) {
 		geniocb->context_un.ndlp = NULL;
 		lpfc_nlp_put(ndlp);
-		lpfc_sli_release_iocbq(phba, geniocb);
-		return 1;
+		goto out;
 	}
 
 	return 0;
+out:
+	lpfc_sli_release_iocbq(phba, geniocb);
+	return 1;
 }
 
 /*
@@ -1134,8 +1136,8 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_disc_start(vport);
 	}
 out:
-	cmdiocb->context_un.ndlp = ndlp; /* Now restore ndlp for free */
 	lpfc_ct_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 	return;
 }
 
@@ -1341,8 +1343,8 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_disc_start(vport);
 	}
 out:
-	cmdiocb->context_un.ndlp = ndlp; /* Now restore ndlp for free */
 	lpfc_ct_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 }
 
 static void
@@ -1357,7 +1359,7 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_sli_ct_request *CTrsp;
 	int did, rc, retry;
 	uint8_t fbits;
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp = NULL, *free_ndlp = NULL;
 
 	did = ((struct lpfc_sli_ct_request *) inp->virt)->un.gff.PortId;
 	did = be32_to_cpu(did);
@@ -1423,7 +1425,9 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					 cmdiocb->retry, did);
 				if (rc == 0) {
 					/* success */
+					free_ndlp = cmdiocb->context_un.ndlp;
 					lpfc_ct_free_iocb(phba, cmdiocb);
+					lpfc_nlp_put(free_ndlp);
 					return;
 				}
 			}
@@ -1476,7 +1480,10 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		}
 		lpfc_disc_start(vport);
 	}
+
+	free_ndlp = cmdiocb->context_un.ndlp;
 	lpfc_ct_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(free_ndlp);
 	return;
 }
 
@@ -1490,7 +1497,8 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_dmabuf *outp = (struct lpfc_dmabuf *)cmdiocb->context2;
 	struct lpfc_sli_ct_request *CTrsp;
 	int did;
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp = NULL;
+	struct lpfc_nodelist *ns_ndlp = NULL;
 	uint32_t fc4_data_0, fc4_data_1;
 
 	did = ((struct lpfc_sli_ct_request *)inp->virt)->un.gft.PortId;
@@ -1500,6 +1508,9 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			      "GFT_ID cmpl: status:x%x/x%x did:x%x",
 			      irsp->ulpStatus, irsp->un.ulpWord[4], did);
 
+	/* Preserve the nameserver node to release the reference. */
+	ns_ndlp = cmdiocb->context_un.ndlp;
+
 	if (irsp->ulpStatus == IOSTAT_SUCCESS) {
 		/* Good status, continue checking */
 		CTrsp = (struct lpfc_sli_ct_request *)outp->virt;
@@ -1515,6 +1526,10 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				 (fc4_data_1 & LPFC_FC4_TYPE_BITMASK) ?
 				  "NVME" : " ");
 
+		/* Lookup the NPort_ID queried in the GFT_ID and find the
+		 * driver's local node.  It's an error if the driver
+		 * doesn't have one.
+		 */
 		ndlp = lpfc_findnode_did(vport, did);
 		if (ndlp) {
 			/* The bitmask value for FCP and NVME FCP types is
@@ -1560,6 +1575,7 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				 "3065 GFT_ID failed x%08x\n", irsp->ulpStatus);
 
 	lpfc_ct_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ns_ndlp);
 }
 
 static void
@@ -1629,8 +1645,8 @@ lpfc_cmpl_ct(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 
 out:
-	cmdiocb->context_un.ndlp = ndlp; /* Now restore ndlp for free */
 	lpfc_ct_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 	return;
 }
 
@@ -2113,11 +2129,6 @@ lpfc_ns_cmd(struct lpfc_vport *vport, int cmdcode,
 	}
 	rc=6;
 
-	/* Decrement ndlp reference count to release ndlp reference held
-	 * for the failed command's callback function.
-	 */
-	lpfc_nlp_put(ndlp);
-
 ns_cmd_free_bmpvirt:
 	lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
 ns_cmd_free_bmp:
@@ -2154,7 +2165,7 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	uint16_t fdmi_cmd = CTcmd->CommandResponse.bits.CmdRsp;
 	uint16_t fdmi_rsp = CTrsp->CommandResponse.bits.CmdRsp;
 	IOCB_t *irsp = &rspiocb->iocb;
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp, *free_ndlp = NULL;
 	uint32_t latt, cmd, err;
 
 	latt = lpfc_els_chk_latt(vport);
@@ -2200,7 +2211,10 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				 be16_to_cpu(fdmi_cmd), latt, irsp->ulpStatus,
 				 irsp->un.ulpWord[4]);
 	}
+
+	free_ndlp = cmdiocb->context_un.ndlp;
 	lpfc_ct_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(free_ndlp);
 
 	ndlp = lpfc_findnode_did(vport, FDMI_DID);
 	if (!ndlp)
@@ -3582,12 +3596,6 @@ lpfc_fdmi_cmd(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (!lpfc_ct_cmd(vport, mp, bmp, ndlp, cmpl, rsp_size, 0))
 		return 0;
 
-	/*
-	 * Decrement ndlp reference count to release ndlp reference held
-	 * for the failed command's callback function.
-	 */
-	lpfc_nlp_put(ndlp);
-
 fdmi_cmd_free_bmpvirt:
 	lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
 fdmi_cmd_free_bmp:
diff --git a/drivers/scsi/lpfc/lpfc_disc.h b/drivers/scsi/lpfc/lpfc_disc.h
index f8ab001e4f0d..09d4ec2a20db 100644
--- a/drivers/scsi/lpfc/lpfc_disc.h
+++ b/drivers/scsi/lpfc/lpfc_disc.h
@@ -166,8 +166,7 @@ struct lpfc_node_rrq {
 #define NLP_NVMET_RECOV    0x00001000   /* NVMET auditing node for recovery. */
 #define NLP_FCP_PRLI_RJT   0x00002000   /* Rport does not support FCP PRLI. */
 #define NLP_UNREG_INP      0x00008000	/* UNREG_RPI cmd is in progress */
-#define NLP_DEFER_RM       0x00010000	/* Remove this ndlp if no longer used */
-#define NLP_DROPPED        0x00000008	/* Init ref count has been dropped */
+#define NLP_DROPPED        0x00010000	/* Init ref count has been dropped */
 #define NLP_DELAY_TMO      0x00020000	/* delay timeout is running for node */
 #define NLP_NPR_2B_DISC    0x00040000	/* node is included in num_disc_nodes */
 #define NLP_RCV_PLOGI      0x00080000	/* Rcv'ed PLOGI from remote system */
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 9cf0e9d55cdf..2d7a4a920ba4 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -300,10 +300,6 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, uint8_t expectRsp,
 		bpl->tus.w = le32_to_cpu(bpl->tus.w);
 	}
 
-	/* prevent preparing iocb with NULL ndlp reference */
-	elsiocb->context1 = lpfc_nlp_get(ndlp);
-	if (!elsiocb->context1)
-		goto els_iocb_free_pbuf_exit;
 	elsiocb->context2 = pcmd;
 	elsiocb->context3 = pbuflist;
 	elsiocb->retry = retry;
@@ -418,10 +414,14 @@ lpfc_issue_fabric_reglogin(struct lpfc_vport *vport)
 	 * for the callback routine.
 	 */
 	mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
+	if (!mbox->ctx_ndlp) {
+		err = 6;
+		goto fail_no_ndlp;
+	}
 
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		err = 6;
+		err = 7;
 		goto fail_issue_reg_login;
 	}
 
@@ -432,6 +432,7 @@ lpfc_issue_fabric_reglogin(struct lpfc_vport *vport)
 	 * for the failed mbox command.
 	 */
 	lpfc_nlp_put(ndlp);
+fail_no_ndlp:
 	mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
 	lpfc_mbuf_free(phba, mp->virt, mp->phys);
 	kfree(mp);
@@ -1088,6 +1089,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			/* Do not register VFI if the driver aborted FLOGI */
 			if (!lpfc_error_lost_link(irsp))
 				lpfc_issue_reg_vfi(vport);
+
 			lpfc_nlp_put(ndlp);
 			goto out;
 		}
@@ -1149,6 +1151,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				phba->fcf.current_rec.fabric_name[5],
 				phba->fcf.current_rec.fabric_name[6],
 				phba->fcf.current_rec.fabric_name[7]);
+
 			lpfc_nlp_put(ndlp);
 			spin_lock_irq(&phba->hbalock);
 			phba->fcf.fcf_flag &= ~FCF_DISCOVERY;
@@ -1180,7 +1183,6 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	spin_unlock_irq(&phba->hbalock);
 
 	lpfc_nlp_put(ndlp);
-
 	if (!lpfc_error_lost_link(irsp)) {
 		/* FLOGI failed, so just use loop map to make discovery list */
 		lpfc_disc_list_loopmap(vport);
@@ -1198,6 +1200,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 out:
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 }
 
 /**
@@ -1337,7 +1340,13 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		"Issue FLOGI:     opt:x%x",
 		phba->sli3_options, 0, 0);
 
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto out;
+
 	rc = lpfc_issue_fabric_iocb(phba, elsiocb);
+	if (rc == IOCB_ERROR)
+		lpfc_nlp_put(ndlp);
 
 	phba->hba_flag |= HBA_FLOGI_ISSUED;
 
@@ -1367,11 +1376,11 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		vport->fc_myDID = did;
 	}
 
-	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
-	return 0;
+	if (!rc)
+		return 0;
+ out:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -1922,7 +1931,9 @@ lpfc_cmpl_els_rrq(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 out:
 	if (rrq)
 		lpfc_clr_rrq_active(phba, rrq->xritag, rrq);
+
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 	return;
 }
 /**
@@ -1952,7 +1963,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_vport *vport = cmdiocb->vport;
 	struct Scsi_Host  *shost = lpfc_shost_from_vport(vport);
 	IOCB_t *irsp;
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp, *free_ndlp;
 	struct lpfc_dmabuf *prsp;
 	int disc;
 
@@ -2049,7 +2060,15 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 
 out:
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_NODE,
+			      "PLOGI Cmpl PUT:     did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
+
+	/* Release the reference on the original IO request. */
+	free_ndlp = (struct lpfc_nodelist *)cmdiocb->context1;
+
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(free_ndlp);
 	return;
 }
 
@@ -2161,13 +2180,24 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
 
 	phba->fc_stat.elsXmitPLOGI++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_plogi;
-	ret = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
 
-	if (ret == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue PLOGI:     did:x%x refcnt %d",
+			      did, kref_read(&ndlp->kref), 0);
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto io_err;
+
+	ret = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (ret) {
+		lpfc_nlp_put(ndlp);
+		goto io_err;
 	}
 	return 0;
+
+ io_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -2267,6 +2297,7 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 out:
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 	return;
 }
 
@@ -2295,6 +2326,7 @@ int
 lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		    uint8_t retry)
 {
+	int rc = 0;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 	struct lpfc_hba *phba = vport->phba;
 	PRLI *npr;
@@ -2430,10 +2462,6 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		local_nlp_type &= ~NLP_FC4_NVME;
 	}
 
-	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
-		"Issue PRLI:      did:x%x",
-		ndlp->nlp_DID, 0, 0);
-
 	phba->fc_stat.elsXmitPRLI++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_prli;
 	spin_lock_irq(shost->host_lock);
@@ -2446,14 +2474,17 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	vport->fc_prli_sent++;
 	ndlp->fc4_prli_sent++;
 	spin_unlock_irq(shost->host_lock);
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
-		spin_lock_irq(shost->host_lock);
-		ndlp->nlp_flag &= ~NLP_PRLI_SND;
-		spin_unlock_irq(shost->host_lock);
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue PRLI:  did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto io_err;
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto node_err;
 
 
 	/* The driver supports 2 FC4 types.  Make sure
@@ -2462,8 +2493,17 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (phba->sli_rev == LPFC_SLI_REV4 &&
 	    local_nlp_type & (NLP_FC4_FCP | NLP_FC4_NVME))
 		goto send_next_prli;
+	else
+		return 0;
 
-	return 0;
+ node_err:
+	lpfc_nlp_put(ndlp);
+ io_err:
+	spin_lock_irq(shost->host_lock);
+	ndlp->nlp_flag &= ~NLP_PRLI_SND;
+	spin_unlock_irq(shost->host_lock);
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -2672,6 +2712,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_more_adisc(vport);
 out:
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 	return;
 }
 
@@ -2699,6 +2740,7 @@ int
 lpfc_issue_els_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		     uint8_t retry)
 {
+	int rc = 0;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 	struct lpfc_hba  *phba = vport->phba;
 	ADISC *ap;
@@ -2725,24 +2767,31 @@ lpfc_issue_els_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	memcpy(&ap->nodeName, &vport->fc_nodename, sizeof(struct lpfc_name));
 	ap->DID = be32_to_cpu(vport->fc_myDID);
 
-	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
-		"Issue ADISC:     did:x%x",
-		ndlp->nlp_DID, 0, 0);
-
 	phba->fc_stat.elsXmitADISC++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_adisc;
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag |= NLP_ADISC_SND;
 	spin_unlock_irq(shost->host_lock);
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
-		spin_lock_irq(shost->host_lock);
-		ndlp->nlp_flag &= ~NLP_ADISC_SND;
-		spin_unlock_irq(shost->host_lock);
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue ADISC:   did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	spin_lock_irq(shost->host_lock);
+	ndlp->nlp_flag &= ~NLP_ADISC_SND;
+	spin_unlock_irq(shost->host_lock);
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -2827,7 +2876,10 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	lpfc_disc_state_machine(vport, ndlp, cmdiocb, NLP_EVT_CMPL_LOGO);
 
 out:
+	/* Driver is done with the IO.  */
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
+
 	/* If we are in pt2pt mode, we could rcv new S_ID on PLOGI */
 	if ((vport->fc_flag & FC_PT2PT) &&
 		!(vport->fc_flag & FC_PT2PT_PLOGI)) {
@@ -2932,30 +2984,37 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	pcmd += sizeof(uint32_t);
 	memcpy(pcmd, &vport->fc_portname, sizeof(struct lpfc_name));
 
-	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
-		"Issue LOGO:      did:x%x",
-		ndlp->nlp_DID, 0, 0);
-
 	phba->fc_stat.elsXmitLOGO++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_logo;
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag |= NLP_LOGO_SND;
 	ndlp->nlp_flag &= ~NLP_ISSUE_LOGO;
 	spin_unlock_irq(shost->host_lock);
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue LOGO:      did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR) {
-		spin_lock_irq(shost->host_lock);
-		ndlp->nlp_flag &= ~NLP_LOGO_SND;
-		spin_unlock_irq(shost->host_lock);
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	if (rc == IOCB_ERROR)
+		goto io_err;
 
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 	spin_unlock_irq(shost->host_lock);
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_LOGO_ISSUE);
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	spin_lock_irq(shost->host_lock);
+	ndlp->nlp_flag &= ~NLP_LOGO_SND;
+	spin_unlock_irq(shost->host_lock);
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -2978,6 +3037,7 @@ lpfc_cmpl_els_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		  struct lpfc_iocbq *rspiocb)
 {
 	struct lpfc_vport *vport = cmdiocb->vport;
+	struct lpfc_nodelist *free_ndlp;
 	IOCB_t *irsp;
 
 	irsp = &rspiocb->iocb;
@@ -2995,7 +3055,11 @@ lpfc_cmpl_els_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Check to see if link went down during discovery */
 	lpfc_els_chk_latt(vport);
+
+	free_ndlp = (struct lpfc_nodelist *)cmdiocb->context1;
+
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(free_ndlp);
 }
 
 /**
@@ -3019,6 +3083,7 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_dmabuf *pcmd, *prsp;
 	u32 *pdata;
 	u32 cmd;
+	struct lpfc_nodelist *ndlp = cmdiocb->context1;
 
 	irsp = &rspiocb->iocb;
 
@@ -3097,6 +3162,7 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* Check to see if link went down during discovery */
 	lpfc_els_chk_latt(vport);
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 	return;
 }
 
@@ -3124,6 +3190,7 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 int
 lpfc_issue_els_scr(struct lpfc_vport *vport, uint8_t retry)
 {
+	int rc = 0;
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_iocbq *elsiocb;
 	uint8_t *pcmd;
@@ -3143,13 +3210,8 @@ lpfc_issue_els_scr(struct lpfc_vport *vport, uint8_t retry)
 	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
 				     ndlp->nlp_DID, ELS_CMD_SCR);
 
-	if (!elsiocb) {
-		/* This will trigger the release of the node just
-		 * allocated
-		 */
-		lpfc_nlp_put(ndlp);
+	if (!elsiocb)
 		return 1;
-	}
 
 	pcmd = (uint8_t *) (((struct lpfc_dmabuf *) elsiocb->context2)->virt);
 
@@ -3166,22 +3228,26 @@ lpfc_issue_els_scr(struct lpfc_vport *vport, uint8_t retry)
 
 	phba->fc_stat.elsXmitSCR++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_disc_cmd;
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
-		/* The additional lpfc_nlp_put will cause the following
-		 * lpfc_els_free_iocb routine to trigger the rlease of
-		 * the node.
-		 */
-		lpfc_nlp_put(ndlp);
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
-	/* This will cause the callback-function lpfc_cmpl_els_cmd to
-	 * trigger the release of node.
-	 */
-	if (!(vport->fc_flag & FC_PT2PT))
-		lpfc_nlp_put(ndlp);
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue SCR:     did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
+
+	/* Keep the ndlp just in case RDF is being sent */
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -3207,6 +3273,7 @@ lpfc_issue_els_scr(struct lpfc_vport *vport, uint8_t retry)
 int
 lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry)
 {
+	int rc = 0;
 	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_iocbq *elsiocb;
 	struct lpfc_nodelist *ndlp;
@@ -3243,13 +3310,8 @@ lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry)
 	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
 				     ndlp->nlp_DID, ELS_CMD_RSCN_XMT);
 
-	if (!elsiocb) {
-		/* This will trigger the release of the node just
-		 * allocated
-		 */
-		lpfc_nlp_put(ndlp);
+	if (!elsiocb)
 		return 1;
-	}
 
 	event = ((struct lpfc_dmabuf *)elsiocb->context2)->virt;
 
@@ -3264,35 +3326,31 @@ lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry)
 	event->portid.rscn_fid[1] = (nportid & 0x0000FF00) >> 8;
 	event->portid.rscn_fid[2] = nportid & 0x000000FF;
 
+	phba->fc_stat.elsXmitRSCN++;
+	elsiocb->iocb_cmpl = lpfc_cmpl_els_cmd;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
 			      "Issue RSCN:       did:x%x",
 			      ndlp->nlp_DID, 0, 0);
 
-	phba->fc_stat.elsXmitRSCN++;
-	elsiocb->iocb_cmpl = lpfc_cmpl_els_cmd;
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
-		/* The additional lpfc_nlp_put will cause the following
-		 * lpfc_els_free_iocb routine to trigger the rlease of
-		 * the node.
-		 */
-		lpfc_nlp_put(ndlp);
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
-
-	/* Only keep the ndlp if RDF is being sent */
-	if (!phba->cfg_enable_mi ||
-	    phba->sli4_hba.pc_sli4_params.mi_ver < LPFC_MIB3_SUPPORT)
-		return 0;
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
 
 	/* This will cause the callback-function lpfc_cmpl_els_cmd to
 	 * trigger the release of node.
 	 */
 	if (!(vport->fc_flag & FC_PT2PT))
 		lpfc_nlp_put(ndlp);
-
 	return 0;
+io_err:
+	lpfc_nlp_put(ndlp);
+node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -3320,6 +3378,7 @@ lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry)
 static int
 lpfc_issue_els_farpr(struct lpfc_vport *vport, uint32_t nportid, uint8_t retry)
 {
+	int rc = 0;
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_iocbq *elsiocb;
 	FARP *fp;
@@ -3341,13 +3400,8 @@ lpfc_issue_els_farpr(struct lpfc_vport *vport, uint32_t nportid, uint8_t retry)
 
 	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
 				     ndlp->nlp_DID, ELS_CMD_RNID);
-	if (!elsiocb) {
-		/* This will trigger the release of the node just
-		 * allocated
-		 */
-		lpfc_nlp_put(ndlp);
+	if (!elsiocb)
 		return 1;
-	}
 
 	pcmd = (uint8_t *) (((struct lpfc_dmabuf *) elsiocb->context2)->virt);
 
@@ -3379,8 +3433,14 @@ lpfc_issue_els_farpr(struct lpfc_vport *vport, uint32_t nportid, uint8_t retry)
 
 	phba->fc_stat.elsXmitFARPR++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_cmd;
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		return 1;
+	}
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR) {
 		/* The additional lpfc_nlp_put will cause the following
 		 * lpfc_els_free_iocb routine to trigger the release of
 		 * the node.
@@ -3421,6 +3481,7 @@ lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry)
 	struct lpfc_els_rdf_req *prdf;
 	struct lpfc_nodelist *ndlp;
 	uint16_t cmdsize;
+	int rc;
 
 	cmdsize = sizeof(*prdf);
 
@@ -3440,13 +3501,8 @@ lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry)
 
 	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
 				     ndlp->nlp_DID, ELS_CMD_RDF);
-	if (!elsiocb) {
-		/* This will trigger the release of the node just
-		 * allocated
-		 */
-		lpfc_nlp_put(ndlp);
+	if (!elsiocb)
 		return -ENOMEM;
-	}
 
 	/* Configure the payload for the supported FPIN events. */
 	prdf = (struct lpfc_els_rdf_req *)
@@ -3464,31 +3520,29 @@ lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry)
 	prdf->reg_d1.desc_tags[2] = cpu_to_be32(ELS_DTAG_PEER_CONGEST);
 	prdf->reg_d1.desc_tags[3] = cpu_to_be32(ELS_DTAG_CONGESTION);
 
-	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
-			      "Issue RDF:       did:x%x",
-			      ndlp->nlp_DID, 0, 0);
-
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "6444 Xmit RDF to remote NPORT x%x\n",
 			 ndlp->nlp_DID);
 
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_disc_cmd;
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
-		/* The additional lpfc_nlp_put will cause the following
-		 * lpfc_els_free_iocb routine to trigger the rlease of
-		 * the node.
-		 */
-		lpfc_nlp_put(ndlp);
-		lpfc_els_free_iocb(phba, elsiocb);
-		return -EIO;
-	}
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
 
-	/* An RDF was issued - this put ensures the ndlp is cleaned up
-	 * when the RDF completes.
-	 */
-	lpfc_nlp_put(ndlp);
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue RDF:     did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return -EIO;
 }
 
 /**
@@ -4256,27 +4310,10 @@ int
 lpfc_els_free_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *elsiocb)
 {
 	struct lpfc_dmabuf *buf_ptr, *buf_ptr1;
-	struct lpfc_nodelist *ndlp;
 
-	ndlp = (struct lpfc_nodelist *)elsiocb->context1;
-	if (ndlp) {
-		if (ndlp->nlp_flag & NLP_DEFER_RM) {
-			lpfc_nlp_put(ndlp);
+	/* The IO job is complete.  Clear the context1 data. */
+	elsiocb->context1 = NULL;
 
-			/* If the ndlp is not being used by another discovery
-			 * thread, free it.
-			 */
-			if (!lpfc_nlp_not_used(ndlp)) {
-				/* If ndlp is being used by another discovery
-				 * thread, just clear NLP_DEFER_RM
-				 */
-				ndlp->nlp_flag &= ~NLP_DEFER_RM;
-			}
-		}
-		else
-			lpfc_nlp_put(ndlp);
-		elsiocb->context1 = NULL;
-	}
 	/* context2  = cmd,  context2->next = rsp, context3 = bpl */
 	if (elsiocb->context2) {
 		if (elsiocb->iocb_flag & LPFC_DELAY_MEM_FREE) {
@@ -4376,6 +4413,7 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	 * At this point, the driver is done so release the IOCB
 	 */
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 }
 
 /**
@@ -4506,32 +4544,38 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
 	if (mbox) {
-		if ((rspiocb->iocb.ulpStatus == 0)
-		    && (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
+		if ((rspiocb->iocb.ulpStatus == 0) &&
+		    (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
 			if (!lpfc_unreg_rpi(vport, ndlp) &&
-			    (!(vport->fc_flag & FC_PT2PT)) &&
-			    (ndlp->nlp_state ==  NLP_STE_PLOGI_ISSUE ||
-			     ndlp->nlp_state == NLP_STE_REG_LOGIN_ISSUE)) {
-				lpfc_printf_vlog(vport, KERN_INFO,
-					LOG_DISCOVERY,
-					"0314 PLOGI recov DID x%x "
-					"Data: x%x x%x x%x\n",
-					ndlp->nlp_DID, ndlp->nlp_state,
-					ndlp->nlp_rpi, ndlp->nlp_flag);
-				mp = mbox->ctx_buf;
-				if (mp) {
-					lpfc_mbuf_free(phba, mp->virt,
-						       mp->phys);
-					kfree(mp);
+			    (!(vport->fc_flag & FC_PT2PT))) {
+				if (ndlp->nlp_state == NLP_STE_REG_LOGIN_ISSUE) {
+					lpfc_printf_vlog(vport, KERN_INFO,
+							 LOG_DISCOVERY,
+							 "0314 PLOGI recov "
+							 "DID x%x "
+							 "Data: x%x x%x x%x\n",
+							 ndlp->nlp_DID,
+							 ndlp->nlp_state,
+							 ndlp->nlp_rpi,
+							 ndlp->nlp_flag);
+					mp = mbox->ctx_buf;
+					if (mp) {
+						lpfc_mbuf_free(phba, mp->virt,
+							       mp->phys);
+						kfree(mp);
+					}
+					mempool_free(mbox, phba->mbox_mem_pool);
+					goto out;
 				}
-				mempool_free(mbox, phba->mbox_mem_pool);
-				goto out;
 			}
 
 			/* Increment reference count to ndlp to hold the
 			 * reference to ndlp for the callback function.
 			 */
 			mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
+			if (!mbox->ctx_ndlp)
+				goto out;
+
 			mbox->vport = vport;
 			if (ndlp->nlp_flag & NLP_RM_DFLT_RPI) {
 				mbox->mbox_flag |= LPFC_MBX_IMED_UNREG;
@@ -4615,7 +4659,9 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	}
 
+	/* Release the originating IO reference. */
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 	return;
 }
 
@@ -4785,12 +4831,29 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 	}
 
 	phba->fc_stat.elsXmitACC++;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	if (rc == IOCB_ERROR)
+		goto io_err;
+
+	/* Xmit ELS ACC response tag <ulpIoTag> */
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+			 "0128 Xmit ELS ACC response Status: x%x, IoTag: x%x, "
+			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
+			 "RPI: x%x, fc_flag x%x\n",
+			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
+			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
+			 ndlp->nlp_rpi, vport->fc_flag);
 	return 0;
+
+io_err:
+	lpfc_nlp_put(ndlp);
+node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -4820,13 +4883,13 @@ lpfc_els_rsp_reject(struct lpfc_vport *vport, uint32_t rejectError,
 		    struct lpfc_iocbq *oldiocb, struct lpfc_nodelist *ndlp,
 		    LPFC_MBOXQ_t *mbox)
 {
+	int rc;
 	struct lpfc_hba  *phba = vport->phba;
 	IOCB_t *icmd;
 	IOCB_t *oldcmd;
 	struct lpfc_iocbq *elsiocb;
 	uint8_t *pcmd;
 	uint16_t cmdsize;
-	int rc;
 
 	cmdsize = 2 * sizeof(uint32_t);
 	elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize, oldiocb->retry, ndlp,
@@ -4861,13 +4924,21 @@ lpfc_els_rsp_reject(struct lpfc_vport *vport, uint32_t rejectError,
 
 	phba->fc_stat.elsXmitLSRJT++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
 
-	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -4931,16 +5002,18 @@ lpfc_els_rsp_adisc_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	ap->DID = be32_to_cpu(vport->fc_myDID);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Issue ACC ADISC: did:x%x flg:x%x",
-		ndlp->nlp_DID, ndlp->nlp_flag, 0);
+		      "Issue ACC ADISC: did:x%x flg:x%x refcnt %d",
+		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	if (rc == IOCB_ERROR)
+		goto io_err;
 
 	/* Xmit ELS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
@@ -4951,6 +5024,12 @@ lpfc_els_rsp_adisc_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi, vport->fc_flag);
 	return 0;
+
+io_err:
+	lpfc_nlp_put(ndlp);
+node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -5098,18 +5177,25 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 				 ndlp->nlp_DID);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Issue ACC PRLI:  did:x%x flg:x%x",
-		ndlp->nlp_DID, ndlp->nlp_flag, 0);
+		      "Issue ACC PRLI:  did:x%x flg:x%x",
+		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
+	elsiocb->context1 =  lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
 
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	if (rc == IOCB_ERROR)
+		goto io_err;
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -5198,18 +5284,26 @@ lpfc_els_rsp_rnid_acc(struct lpfc_vport *vport, uint8_t format,
 	}
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Issue ACC RNID:  did:x%x flg:x%x",
-		ndlp->nlp_DID, ndlp->nlp_flag, 0);
+		      "Issue ACC RNID:  did:x%x flg:x%x refcnt %d",
+		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
 
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	if (rc == IOCB_ERROR)
+		goto io_err;
+
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -5305,18 +5399,25 @@ lpfc_els_rsp_echo_acc(struct lpfc_vport *vport, uint8_t *data,
 	memcpy(pcmd, data, cmdsize - sizeof(uint32_t));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Issue ACC ECHO:  did:x%x flg:x%x",
-		ndlp->nlp_DID, ndlp->nlp_flag, 0);
+		      "Issue ACC ECHO:  did:x%x flg:x%x refcnt %d",
+		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
+	elsiocb->context1 =  lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
 
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	if (rc == IOCB_ERROR)
+		goto io_err;
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -5879,7 +5980,6 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 	elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize,
 			lpfc_max_els_tries, rdp_context->ndlp,
 			rdp_context->ndlp->nlp_DID, ELS_CMD_ACC);
-	lpfc_nlp_put(ndlp);
 	if (!elsiocb)
 		goto free_rdp_context;
 
@@ -5953,18 +6053,24 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 	bpl->tus.w = le32_to_cpu(bpl->tus.w);
 
 	phba->fc_stat.elsXmitACC++;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		goto free_rdp_context;
+	}
+
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR)
+	if (rc == IOCB_ERROR) {
+		lpfc_nlp_put(ndlp);
 		lpfc_els_free_iocb(phba, elsiocb);
+	}
 
-	kfree(rdp_context);
+	goto free_rdp_context;
 
-	return;
 error:
 	cmdsize = 2 * sizeof(uint32_t);
 	elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize, lpfc_max_els_tries,
 			ndlp, ndlp->nlp_DID, ELS_CMD_LS_RJT);
-	lpfc_nlp_put(ndlp);
 	if (!elsiocb)
 		goto free_rdp_context;
 
@@ -5979,11 +6085,23 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 
 	phba->fc_stat.elsXmitLSRJT++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
-	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		goto free_rdp_context;
+	}
 
-	if (rc == IOCB_ERROR)
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR) {
+		lpfc_nlp_put(ndlp);
 		lpfc_els_free_iocb(phba, elsiocb);
+	}
+
 free_rdp_context:
+	/* This reference put is for the original unsolicited RDP. If the
+	 * iocb prep failed, there is no reference to remove.
+	 */
+	lpfc_nlp_put(ndlp);
 	kfree(rdp_context);
 }
 
@@ -6087,6 +6205,11 @@ lpfc_els_rcv_rdp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 	cmd = &cmdiocb->iocb;
 	rdp_context->ndlp = lpfc_nlp_get(ndlp);
+	if (!rdp_context->ndlp) {
+		kfree(rdp_context);
+		rjt_err = LSRJT_UNABLE_TPC;
+		goto error;
+	}
 	rdp_context->ox_id = cmd->unsli3.rcvsli3.ox_id;
 	rdp_context->rx_id = cmd->ulpContext;
 	rdp_context->cmpl = lpfc_els_rdp_cmpl;
@@ -6181,10 +6304,19 @@ lpfc_els_lcb_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lcb_res->lcb_duration = lcb_context->duration;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
 	phba->fc_stat.elsXmitACC++;
+
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR)
-		lpfc_els_free_iocb(phba, elsiocb);
+	if (!rc)
+		goto out;
 
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+ out:
 	kfree(lcb_context);
 	return;
 
@@ -6211,9 +6343,17 @@ lpfc_els_lcb_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
 	phba->fc_stat.elsXmitLSRJT++;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		goto free_lcb_context;
+	}
+
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-	if (rc == IOCB_ERROR)
+	if (rc == IOCB_ERROR) {
+		lpfc_nlp_put(ndlp);
 		lpfc_els_free_iocb(phba, elsiocb);
+	}
 free_lcb_context:
 	kfree(lcb_context);
 }
@@ -6313,7 +6453,7 @@ lpfc_els_rcv_lcb(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	uint8_t *lp;
 	struct fc_lcb_request_frame *beacon;
 	struct lpfc_lcb_context *lcb_context;
-	uint8_t state, rjt_err;
+	u8 state, rjt_err = 0;
 	struct ls_rjt stat;
 
 	pcmd = (struct lpfc_dmabuf *)cmdiocb->context2;
@@ -6359,6 +6499,11 @@ lpfc_els_rcv_lcb(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	lcb_context->ox_id = cmdiocb->iocb.unsli3.rcvsli3.ox_id;
 	lcb_context->rx_id = cmdiocb->iocb.ulpContext;
 	lcb_context->ndlp = lpfc_nlp_get(ndlp);
+	if (!lcb_context->ndlp) {
+		rjt_err = LSRJT_UNABLE_TPC;
+		goto rjt;
+	}
+
 	if (lpfc_sli4_set_beacon(vport, lcb_context, state)) {
 		lpfc_printf_vlog(ndlp->vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0193 failed to send mail box");
@@ -7208,6 +7353,7 @@ lpfc_els_rcv_rrq(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 static void
 lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
+	int rc = 0;
 	MAILBOX_t *mb;
 	IOCB_t *icmd;
 	struct RLS_RSP *rls_rsp;
@@ -7269,8 +7415,19 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			 ndlp->nlp_rpi);
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
 	phba->fc_stat.elsXmitACC++;
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) == IOCB_ERROR)
-		lpfc_els_free_iocb(phba, elsiocb);
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
+	return;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
 }
 
 /**
@@ -7311,6 +7468,8 @@ lpfc_els_rcv_rls(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 			((cmdiocb->iocb.unsli3.rcvsli3.ox_id << 16) |
 			cmdiocb->iocb.ulpContext)); /* rx_id */
 		mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
+		if (!mbox->ctx_ndlp)
+			goto node_err;
 		mbox->vport = vport;
 		mbox->mbox_cmpl = lpfc_els_rsp_rls_acc;
 		if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT)
@@ -7321,6 +7480,7 @@ lpfc_els_rcv_rls(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		 * command.
 		 */
 		lpfc_nlp_put(ndlp);
+node_err:
 		mempool_free(mbox, phba->mbox_mem_pool);
 	}
 reject_out:
@@ -7358,6 +7518,7 @@ static int
 lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		 struct lpfc_nodelist *ndlp)
 {
+	int rc = 0;
 	struct lpfc_hba *phba = vport->phba;
 	struct ls_rjt stat;
 	struct RTV_RSP *rtv_rsp;
@@ -7407,8 +7568,17 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 			rtv_rsp->ratov, rtv_rsp->edtov, rtv_rsp->qtov);
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
 	phba->fc_stat.elsXmitACC++;
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) == IOCB_ERROR)
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		return 0;
+	}
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR) {
+		lpfc_nlp_put(ndlp);
 		lpfc_els_free_iocb(phba, elsiocb);
+	}
 	return 0;
 
 reject_out:
@@ -7477,13 +7647,20 @@ lpfc_issue_els_rrq(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		did, rrq->xritag, rrq->rxid);
 	elsiocb->context_un.rrq = rrq;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rrq;
-	ret = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
 
-	if (ret == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	ret = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (ret == IOCB_ERROR)
+		goto io_err;
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -7536,6 +7713,7 @@ static int
 lpfc_els_rsp_rpl_acc(struct lpfc_vport *vport, uint16_t cmdsize,
 		     struct lpfc_iocbq *oldiocb, struct lpfc_nodelist *ndlp)
 {
+	int rc = 0;
 	struct lpfc_hba *phba = vport->phba;
 	IOCB_t *icmd, *oldcmd;
 	RPL_RSP rpl_rsp;
@@ -7577,12 +7755,20 @@ lpfc_els_rsp_rpl_acc(struct lpfc_vport *vport, uint16_t cmdsize,
 			 ndlp->nlp_rpi);
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
 	phba->fc_stat.elsXmitACC++;
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -8444,6 +8630,8 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	spin_unlock_irq(shost->host_lock);
 
 	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto dropit;
 	elsiocb->vport = vport;
 
 	if ((cmd & ELS_CMD_MASK) == ELS_CMD_RSCN) {
@@ -8755,7 +8943,10 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		stat.un.b.lsRjtRsnCode = rjt_err;
 		stat.un.b.lsRjtRsnCodeExp = rjt_exp;
 		lpfc_els_rsp_reject(vport, stat.un.lsRjtError, elsiocb, ndlp,
-			NULL);
+				    NULL);
+		/* Remove the reference from above for new nodes. */
+		if (newnode)
+			lpfc_nlp_put(ndlp);
 	}
 
 	lpfc_nlp_put(elsiocb->context1);
@@ -9108,6 +9299,11 @@ lpfc_register_new_vport(struct lpfc_hba *phba, struct lpfc_vport *vport,
 		lpfc_reg_vpi(vport, mbox);
 		mbox->vport = vport;
 		mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
+		if (!mbox->ctx_ndlp) {
+			mempool_free(mbox, phba->mbox_mem_pool);
+			goto mbox_err_exit;
+		}
+
 		mbox->mbox_cmpl = lpfc_cmpl_reg_new_vport;
 		if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT)
 		    == MBX_NOT_FINISHED) {
@@ -9360,9 +9556,9 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 	/* Cancel discovery timer */
 	lpfc_can_disctmo(vport);
-	lpfc_nlp_put(ndlp);
 out:
 	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
 }
 
 /**
@@ -9455,16 +9651,25 @@ lpfc_issue_els_fdisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		"Issue FDISC:     did:x%x",
 		did, 0, 0);
 
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto err_out;
+
 	rc = lpfc_issue_fabric_iocb(phba, elsiocb);
 	if (rc == IOCB_ERROR) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
-				 "0256 Issue FDISC: Cannot send IOCB\n");
-		return 1;
+		lpfc_nlp_put(ndlp);
+		goto err_out;
 	}
+
 	lpfc_vport_set_state(vport, FC_VPORT_INITIALIZING);
 	return 0;
+
+ err_out:
+	lpfc_els_free_iocb(phba, elsiocb);
+	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+			 "0256 Issue FDISC: Cannot send IOCB\n");
+	return 1;
 }
 
 /**
@@ -9496,6 +9701,7 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		"LOGO npiv cmpl:  status:x%x/x%x did:x%x",
 		irsp->ulpStatus, irsp->un.ulpWord[4], irsp->un.rcvels.remoteID);
 
+	lpfc_nlp_put(ndlp);
 	lpfc_els_free_iocb(phba, cmdiocb);
 	vport->unreg_vpi_cmpl = VPORT_ERROR;
 
@@ -9516,6 +9722,7 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		spin_unlock_irq(shost->host_lock);
 		lpfc_can_disctmo(vport);
 	}
+	lpfc_nlp_put(ndlp);
 }
 
 /**
@@ -9537,6 +9744,7 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 int
 lpfc_issue_els_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 {
+	int rc = 0;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_iocbq *elsiocb;
@@ -9566,15 +9774,22 @@ lpfc_issue_els_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag |= NLP_LOGO_SND;
 	spin_unlock_irq(shost->host_lock);
-	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
-	    IOCB_ERROR) {
-		spin_lock_irq(shost->host_lock);
-		ndlp->nlp_flag &= ~NLP_LOGO_SND;
-		spin_unlock_irq(shost->host_lock);
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 1;
-	}
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1)
+		goto node_err;
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR)
+		goto io_err;
 	return 0;
+
+ io_err:
+	lpfc_nlp_put(ndlp);
+ node_err:
+	spin_lock_irq(shost->host_lock);
+	ndlp->nlp_flag &= ~NLP_LOGO_SND;
+	spin_unlock_irq(shost->host_lock);
+	lpfc_els_free_iocb(phba, elsiocb);
+	return 1;
 }
 
 /**
@@ -9660,8 +9875,6 @@ lpfc_resume_fabric_iocbs(struct lpfc_hba *phba)
 			goto repeat;
 		}
 	}
-
-	return;
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 47d26917e10f..9d387fbf65a3 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -178,7 +178,7 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	/* We need to hold the node by incrementing the reference
 	 * count until this queued work is done
 	 */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
+	evtp->evt_arg1 = lpfc_nlp_get(ndlp);
 
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (evtp->evt_arg1) {
@@ -4214,6 +4214,13 @@ lpfc_register_remote_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	rport->supported_classes = ndlp->nlp_class_sup;
 	rdata = rport->dd_data;
 	rdata->pnode = lpfc_nlp_get(ndlp);
+	if (!rdata->pnode) {
+		dev_warn(&phba->pcidev->dev,
+			 "Warning - node ref failed. Unreg rport\n");
+		fc_remote_port_delete(rport);
+		ndlp->rport = NULL;
+		return;
+	}
 
 	if (ndlp->nlp_type & NLP_FCP_TARGET)
 		rport_ids.roles |= FC_PORT_ROLE_FCP_TARGET;
@@ -5157,8 +5164,7 @@ lpfc_nlp_remove(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	int rc;
 
 	lpfc_cancel_retry_delay_tmo(vport, ndlp);
-	if ((ndlp->nlp_flag & NLP_DEFER_RM) &&
-	    !(ndlp->nlp_flag & NLP_REG_LOGIN_SEND) &&
+	if (!(ndlp->nlp_flag & NLP_REG_LOGIN_SEND) &&
 	    !(ndlp->nlp_flag & NLP_RPI_REGISTERED) &&
 	    phba->sli_rev != LPFC_SLI_REV4) {
 		/* For this case we need to cleanup the default rpi
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 16a37c2153ae..5c57aeb1fb0b 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -357,7 +357,6 @@ lpfc_defer_acc_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	 * Complete the unreg rpi mbx request, and update flags.
 	 * This will also restart any deferred events.
 	 */
-	lpfc_nlp_get(ndlp);
 	lpfc_sli4_unreg_rpi_cmpl_clr(phba, pmb);
 
 	if (!piocb) {
@@ -365,7 +364,7 @@ lpfc_defer_acc_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				 "4578 PLOGI ACC fail\n");
 		if (mbox)
 			mempool_free(mbox, phba->mbox_mem_pool);
-		goto out;
+		return;
 	}
 
 	rc = lpfc_els_rsp_acc(vport, ELS_CMD_PLOGI, piocb, ndlp, mbox);
@@ -376,8 +375,6 @@ lpfc_defer_acc_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			mempool_free(mbox, phba->mbox_mem_pool);
 	}
 	kfree(piocb);
-out:
-	lpfc_nlp_put(ndlp);
 }
 
 static int
@@ -588,7 +585,10 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		rpi = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
 		lpfc_unreg_login(phba, vport->vpi, rpi, link_mbox);
 		link_mbox->vport = vport;
-		link_mbox->ctx_ndlp = ndlp;
+		link_mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
+		if (!link_mbox->ctx_ndlp)
+			goto out;
+
 		link_mbox->mbox_cmpl = lpfc_defer_acc_rsp;
 
 		if (((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
@@ -1104,7 +1104,11 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
 		lpfc_unreg_login(phba, vport->vpi, rpi, pmb);
 		pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 		pmb->vport = vport;
-		pmb->ctx_ndlp = ndlp;
+		pmb->ctx_ndlp = lpfc_nlp_get(ndlp);
+		if (!pmb->ctx_ndlp) {
+			mempool_free(pmb, phba->mbox_mem_pool);
+			return;
+		}
 
 		if (((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
 		    (!(vport->fc_flag & FC_OFFLINE_MODE)))
@@ -1342,7 +1346,6 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 			    uint32_t evt)
 {
 	struct lpfc_hba    *phba = vport->phba;
-	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 	struct lpfc_iocbq  *cmdiocb, *rspiocb;
 	struct lpfc_dmabuf *pcmd, *prsp, *mp;
 	uint32_t *lp;
@@ -1488,7 +1491,11 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 			ndlp->nlp_flag |= NLP_REG_LOGIN_SEND;
 			mbox->mbox_cmpl = lpfc_mbx_cmpl_reg_login;
 		}
+
 		mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
+		if (!mbox->ctx_ndlp)
+			goto out;
+
 		mbox->vport = vport;
 		if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT)
 		    != MBX_NOT_FINISHED) {
@@ -1537,9 +1544,6 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(shost->host_lock);
-	ndlp->nlp_flag |= NLP_DEFER_RM;
-	spin_unlock_irq(shost->host_lock);
 	return NLP_STE_FREED_NODE;
 }
 
@@ -2797,16 +2801,12 @@ lpfc_cmpl_plogi_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_iocbq *cmdiocb, *rspiocb;
 	IOCB_t *irsp;
-	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 
 	cmdiocb = (struct lpfc_iocbq *) arg;
 	rspiocb = cmdiocb->context_un.rsp_iocb;
 
 	irsp = &rspiocb->iocb;
 	if (irsp->ulpStatus) {
-		spin_lock_irq(shost->host_lock);
-		ndlp->nlp_flag |= NLP_DEFER_RM;
-		spin_unlock_irq(shost->host_lock);
 		return NLP_STE_FREED_NODE;
 	}
 	return ndlp->nlp_state;
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 19faae83b2c1..9e92fb337abd 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -567,6 +567,13 @@ lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 
 	/* Save for completion so we can release these resources */
 	genwqe->context1 = lpfc_nlp_get(ndlp);
+	if (!genwqe->context1) {
+		dev_warn(&phba->pcidev->dev,
+			 "Warning: Failed node ref, not sending LS_REQ\n");
+		lpfc_sli_release_iocbq(phba, genwqe);
+		return 1;
+	}
+
 	genwqe->context2 = (uint8_t *)pnvme_lsreq;
 	/* Fill in payload, bp points to frame payload */
 
@@ -2466,7 +2473,11 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		spin_unlock_irq(&vport->phba->hbalock);
 	} else {
 		spin_unlock_irq(&vport->phba->hbalock);
-		lpfc_nlp_get(ndlp);
+		if (!lpfc_nlp_get(ndlp)) {
+			dev_warn(&vport->phba->pcidev->dev,
+				 "Warning - No node ref - exit register\n");
+			return 0;
+		}
 	}
 
 	ret = nvme_fc_register_remoteport(localport, &rpinfo, &remote_port);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 4974bf671063..1232fad17d1e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2594,7 +2594,6 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 					 ndlp->nlp_flag,
 					 ndlp);
 				ndlp->nlp_flag &= ~NLP_LOGO_ACC;
-				lpfc_nlp_put(ndlp);
 
 				/* Check to see if there are any deferred
 				 * events to process
@@ -2617,6 +2616,8 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				} else {
 					__lpfc_sli_rpi_release(vport, ndlp);
 				}
+
+				lpfc_nlp_put(ndlp);
 			}
 		}
 	}
@@ -11352,11 +11353,11 @@ lpfc_ignore_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			"x%x x%x x%x\n",
 			irsp->ulpIoTag, irsp->ulpStatus,
 			irsp->un.ulpWord[4], irsp->ulpTimeout);
+	lpfc_nlp_put((struct lpfc_nodelist *)cmdiocb->context1);
 	if (cmdiocb->iocb.ulpCommand == CMD_GEN_REQUEST64_CR)
 		lpfc_ct_free_iocb(phba, cmdiocb);
 	else
 		lpfc_els_free_iocb(phba, cmdiocb);
-	return;
 }
 
 /**
@@ -17924,6 +17925,10 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	icmd->ulpClass = CLASS3;
 	icmd->ulpContext = phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
 	ctiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!ctiocb->context1) {
+		lpfc_sli_release_iocbq(phba, ctiocb);
+		return;
+	}
 
 	ctiocb->vport = phba->pport;
 	ctiocb->iocb_cmpl = lpfc_sli4_seq_abort_rsp_cmpl;
-- 
2.26.2


--000000000000b44ba105b42a3ee8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AanDaJF6fE9TEzbfn5AWgVgHkbqS3VY3Gq05xkLhRugDQ60IGwT29K1B+wGfcujKSaalhQIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUUXCHNA1n5KXj
CXL1nHkJ8oKX5wYwDQYJKoZIhvcNAQELBQADggEBAGQDKmIdULu06w+bE15XZJOwlarihiP2PHos
/4bNU3NRgy/tCQbTpJJr3L7LU9ldcPam9qQsErGZKmb5ypUjVdmS5n5M7KN42mnfLs/p7+lOOY5q
ZwPZfsjYiUuaCWDGMvVpuBgJtdADOE1v24vgyyLZjtCbvSUzsgKKda3/Z/iwLFCRrIogixS1L6Vg
2JU2wwirL0Sy5S1DREQmTMAuHL+M9Qwbl+uh/AprkVqaSYuvUzWFwBVgafOl2XgGdn8r6ubxSZhX
9SybOi1fAXGcISX8GzOd85ygu/3dFqvMyCBpNke4vdweIll52KZIMyWji3y2PKJYfgqO+bxo7BAa
ROYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDH5i
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg00bULPkO+N08WOjD
NU8vRkXgs2M8Xe8kJGt/RXELHFYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMTE1MTkyNjU3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEju/9uwTexlaWdaCQqfJ2r+oCFRSKk3DFoy
ITReh3nt9bYJqxmeYWu6J6ToChoYsvOfFXrpv/p0ovSYPHz7wyKDOFz8xUTekMazWvmNH6TFwBQW
tcnY+MGgej2gcKftSVH2n1Faj0zfsBhLSzhuJ+M07EJ3PffHxDIN2lQ5bRQDSxFHWkU457pPn+rx
9vZAZjwPPH5M4Bma6n/MObZ6XfJyXs1Mzg8Ex0WmPtyUfq9QEh/s33EjVg8viReM1xsTAp0e0D35
beiaXBiB5d5Onkle2Cyp2uBeYGYCPrFGjR1GTTK1dyFyZgiuUOO49YKJAKhooaipp8IzTsqUeIy6
OB4=
--000000000000b44ba105b42a3ee8--
