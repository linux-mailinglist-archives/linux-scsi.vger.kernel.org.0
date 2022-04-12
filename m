Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7064FEB0C
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Apr 2022 01:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiDLXgr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Apr 2022 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiDLXcy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Apr 2022 19:32:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4384C6252
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 15:20:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u2so3224683pgq.10
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwhpmTnvWnbGAFyUrUw3Mb+tfFvoczzjCXN7agAAJtY=;
        b=Rfr4tzxRz1gNx9vy4/OsUxUdxKYL03qs4uekUr48GHmNE+pIXlbv1BJnrQmgTGC2XF
         eZgbtg4lsZwyiMSDcqH7Iri7H9JHUp/4anTYGP2JChbf3MSOX08Fiw5OqPBRhfohgQWv
         5xzvcbjQJGOw0jLzmO2ZKgZoewL6ouSOz5Tb7d4Q2kvHqa5y6H5LvKvkgTDY1tLzEMAe
         e0oAyQ17ZRCPUGCgmZrUBbgRDnKOmVpHtKIJQDEwI+1ayRS7LRMnSlRKL58DQ3IA1oD+
         lM2uPL1cTn5ZcGxOQkwrDq9rz61Pth04B2ofjEyXgUVWGG2fs5lsCw0QV8n7z1g8RiBZ
         obnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwhpmTnvWnbGAFyUrUw3Mb+tfFvoczzjCXN7agAAJtY=;
        b=IjVAo7TdiLCTDbL0E0It31LeNK2fZfb1UcvH9/UDotUziXfRDVojFTp8yuftOQB3Wq
         kZqTZlNlPirzN93VrwC37j88q/wVktqOQvn27KPdnw7Q4qM7a82blwmyWbeTKgV0XHvV
         MmF1DzsMZoBXGCbkWVZeT5sh115n+KDSiCL9v+JFdvZNcKBe9ts09lnCBKD3LCvSxbnc
         1AHPS3lXhXtYj1GUYfRD+dsiEgpxznKkKl+1tWceKlFiFL9pOVFVe6S+G6x6YIHfm7bV
         JUt7Z02odTk+EkLPB7gFV4asLL3jMQxErQiPeuKHOrzhm7mfP2+acY3l42ogS02tuJIB
         F+og==
X-Gm-Message-State: AOAM533MWtZ5CqEMBDHK6YK9Mks1EmYdrSP6KBfQNGgmh3tI++4rksko
        dZ4de0y2V3pgD9SZqCR6FT4LPjrcdRA=
X-Google-Smtp-Source: ABdhPJyxksMLUeoN883IYSprL1pXjwtMpS6tZwsEVpyBti/keAF+gaa0uUSu8X7DbwLI4WFe/fAttw==
X-Received: by 2002:a63:7d04:0:b0:378:fb34:5162 with SMTP id y4-20020a637d04000000b00378fb345162mr32389495pgc.487.1649802031291;
        Tue, 12 Apr 2022 15:20:31 -0700 (PDT)
Received: from mail-lvn-it-01.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a000b8f00b004fa9dbf27desm40429824pfj.55.2022.04.12.15.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:20:31 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 21/26] lpfc: Refactor cleanup of mailbox commands
Date:   Tue, 12 Apr 2022 15:20:03 -0700
Message-Id: <20220412222008.126521-22-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220412222008.126521-1-jsmart2021@gmail.com>
References: <20220412222008.126521-1-jsmart2021@gmail.com>
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

The intention of this patch is to refactor mailbox memory allocation and
cleanup steps in one routine respectively to prevent memory leaks or
memory errors related to mailbox commands.  There are trivial localized
fixes as well.

Provide lpfc_mbox_rsrc_prep - this routine allocates the dmabuf and the
mbuf associated with it.  It also catches allocation errors and returns
status.

Provide lpfc_mbox_rsrc_cleanup - this routine verifies a dmabuf exists
and if so releases the associated mbuf and the dmabuf memory.  It then
sets the ctx_buf to NULL and releases the mailbox memory to the mailbox
pool.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_crtn.h      |   4 +-
 drivers/scsi/lpfc/lpfc_els.c       | 105 ++++-----------
 drivers/scsi/lpfc/lpfc_hbadisc.c   | 124 +++++-------------
 drivers/scsi/lpfc/lpfc_init.c      |  83 ++++--------
 drivers/scsi/lpfc/lpfc_mbox.c      | 201 +++++++++++++++++------------
 drivers/scsi/lpfc/lpfc_nportdisc.c |  36 ++----
 drivers/scsi/lpfc/lpfc_sli.c       |  55 ++------
 drivers/scsi/lpfc/lpfc_sli.h       |   6 +
 drivers/scsi/lpfc/lpfc_vport.c     |  29 ++---
 9 files changed, 248 insertions(+), 395 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 9897a1aa387b..6f88fd0df8b0 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -32,7 +32,9 @@ int lpfc_dump_static_vport(struct lpfc_hba *, LPFC_MBOXQ_t *, uint16_t);
 int lpfc_sli4_dump_cfg_rg23(struct lpfc_hba *, struct lpfcMboxq *);
 void lpfc_read_nv(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_config_async(struct lpfc_hba *, LPFC_MBOXQ_t *, uint32_t);
-
+int lpfc_mbox_rsrc_prep(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox);
+void lpfc_mbox_rsrc_cleanup(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox,
+			    enum lpfc_mbox_ctx locked);
 void lpfc_heart_beat(struct lpfc_hba *, LPFC_MBOXQ_t *);
 int lpfc_read_topology(struct lpfc_hba *, LPFC_MBOXQ_t *, struct lpfc_dmabuf *);
 void lpfc_clear_la(struct lpfc_hba *, LPFC_MBOXQ_t *);
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 469c3cadffdd..b74f6cdef2c0 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -345,7 +345,6 @@ lpfc_issue_fabric_reglogin(struct lpfc_vport *vport)
 {
 	struct lpfc_hba  *phba = vport->phba;
 	LPFC_MBOXQ_t *mbox;
-	struct lpfc_dmabuf *mp;
 	struct lpfc_nodelist *ndlp;
 	struct serv_parm *sp;
 	int rc;
@@ -395,7 +394,7 @@ lpfc_issue_fabric_reglogin(struct lpfc_vport *vport)
 	mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
 	if (!mbox->ctx_ndlp) {
 		err = 6;
-		goto fail_no_ndlp;
+		goto fail_free_mbox;
 	}
 
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
@@ -411,13 +410,8 @@ lpfc_issue_fabric_reglogin(struct lpfc_vport *vport)
 	 * for the failed mbox command.
 	 */
 	lpfc_nlp_put(ndlp);
-fail_no_ndlp:
-	mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
 fail_free_mbox:
-	mempool_free(mbox, phba->mbox_mem_pool);
-
+	lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 fail:
 	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
@@ -465,45 +459,37 @@ lpfc_issue_reg_vfi(struct lpfc_vport *vport)
 
 	/* Supply CSP's only if we are fabric connect or pt-to-pt connect */
 	if ((vport->fc_flag & FC_FABRIC) || (vport->fc_flag & FC_PT2PT)) {
-		dmabuf = kzalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-		if (!dmabuf) {
-			rc = -ENOMEM;
-			goto fail;
-		}
-		dmabuf->virt = lpfc_mbuf_alloc(phba, MEM_PRI, &dmabuf->phys);
-		if (!dmabuf->virt) {
+		rc = lpfc_mbox_rsrc_prep(phba, mboxq);
+		if (rc) {
 			rc = -ENOMEM;
-			goto fail;
+			goto fail_mbox;
 		}
+		dmabuf = mboxq->ctx_buf;
 		memcpy(dmabuf->virt, &phba->fc_fabparam,
 		       sizeof(struct serv_parm));
 	}
 
 	vport->port_state = LPFC_FABRIC_CFG_LINK;
-	if (dmabuf)
+	if (dmabuf) {
 		lpfc_reg_vfi(mboxq, vport, dmabuf->phys);
-	else
+		/* lpfc_reg_vfi memsets the mailbox.  Restore the ctx_buf. */
+		mboxq->ctx_buf = dmabuf;
+	} else {
 		lpfc_reg_vfi(mboxq, vport, 0);
+	}
 
 	mboxq->mbox_cmpl = lpfc_mbx_cmpl_reg_vfi;
 	mboxq->vport = vport;
-	mboxq->ctx_buf = dmabuf;
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
 		rc = -ENXIO;
-		goto fail;
+		goto fail_mbox;
 	}
 	return 0;
 
+fail_mbox:
+	lpfc_mbox_rsrc_cleanup(phba, mboxq, MBOX_THD_UNLOCKED);
 fail:
-	if (mboxq)
-		mempool_free(mboxq, phba->mbox_mem_pool);
-	if (dmabuf) {
-		if (dmabuf->virt)
-			lpfc_mbuf_free(phba, dmabuf->virt, dmabuf->phys);
-		kfree(dmabuf);
-	}
-
 	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0289 Issue Register VFI failed: Err %d\n", rc);
@@ -3251,7 +3237,6 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_nodelist *ns_ndlp;
 	LPFC_MBOXQ_t *mbox;
-	struct lpfc_dmabuf *mp;
 
 	if (fc_ndlp->nlp_flag & NLP_RPI_REGISTERED)
 		return rc;
@@ -3288,7 +3273,7 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 	mbox->ctx_ndlp = lpfc_nlp_get(fc_ndlp);
 	if (!mbox->ctx_ndlp) {
 		rc = -ENOMEM;
-		goto out_mem;
+		goto out;
 	}
 
 	mbox->vport = vport;
@@ -3296,21 +3281,15 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 	if (rc == MBX_NOT_FINISHED) {
 		rc = -ENODEV;
 		lpfc_nlp_put(fc_ndlp);
-		goto out_mem;
+		goto out;
 	}
 	/* Success path. Exit. */
 	lpfc_nlp_set_state(vport, fc_ndlp,
 			   NLP_STE_REG_LOGIN_ISSUE);
 	return 0;
 
- out_mem:
-	fc_ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
-	mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-
  out:
-	mempool_free(mbox, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
 			 "0938 %s: failed to format reg_login "
 			 "Data: x%x x%x x%x x%x\n", __func__,
@@ -5230,14 +5209,10 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 void
 lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
 	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
 	u32 mbx_flag = pmb->mbox_flag;
 	u32 mbx_cmd = pmb->u.mb.mbxCommand;
 
-	pmb->ctx_buf = NULL;
-	pmb->ctx_ndlp = NULL;
-
 	if (ndlp) {
 		lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
 				 "0006 rpi x%x DID:%x flg:%x %d x%px "
@@ -5260,10 +5235,7 @@ lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		lpfc_drop_node(ndlp->vport, ndlp);
 	}
 
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
-	return;
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 }
 
 /**
@@ -5288,7 +5260,6 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct Scsi_Host  *shost = vport ? lpfc_shost_from_vport(vport) : NULL;
 	IOCB_t  *irsp;
 	LPFC_MBOXQ_t *mbox = NULL;
-	struct lpfc_dmabuf *mp = NULL;
 	u32 ulp_status, ulp_word4, tmo, did, iotag;
 
 	if (!vport) {
@@ -5314,14 +5285,8 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Check to see if link went down during discovery */
 	if (!ndlp || lpfc_els_chk_latt(vport)) {
-		if (mbox) {
-			mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-			if (mp) {
-				lpfc_mbuf_free(phba, mp->virt, mp->phys);
-				kfree(mp);
-			}
-			mempool_free(mbox, phba->mbox_mem_pool);
-		}
+		if (mbox)
+			lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 		goto out;
 	}
 
@@ -5352,14 +5317,7 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 							 ndlp->nlp_state,
 							 ndlp->nlp_rpi,
 							 ndlp->nlp_flag);
-					mp = mbox->ctx_buf;
-					if (mp) {
-						lpfc_mbuf_free(phba, mp->virt,
-							       mp->phys);
-						kfree(mp);
-					}
-					mempool_free(mbox, phba->mbox_mem_pool);
-					goto out;
+					goto out_free_mbox;
 				}
 			}
 
@@ -5368,7 +5326,7 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 */
 			mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
 			if (!mbox->ctx_ndlp)
-				goto out;
+				goto out_free_mbox;
 
 			mbox->vport = vport;
 			if (ndlp->nlp_flag & NLP_RM_DFLT_RPI) {
@@ -5400,12 +5358,8 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 				ndlp->nlp_rpi);
 		}
-		mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-		if (mp) {
-			lpfc_mbuf_free(phba, mp->virt, mp->phys);
-			kfree(mp);
-		}
-		mempool_free(mbox, phba->mbox_mem_pool);
+out_free_mbox:
+		lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 	}
 out:
 	if (ndlp && shost) {
@@ -7170,7 +7124,6 @@ static int
 lpfc_get_rdp_info(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context)
 {
 	LPFC_MBOXQ_t *mbox = NULL;
-	struct lpfc_dmabuf *mp;
 	int rc;
 
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
@@ -7181,21 +7134,19 @@ lpfc_get_rdp_info(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context)
 	}
 
 	if (lpfc_sli4_dump_page_a0(phba, mbox))
-		goto prep_mbox_fail;
+		goto rdp_fail;
 	mbox->vport = rdp_context->ndlp->vport;
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_rdp_page_a0;
 	mbox->ctx_ndlp = (struct lpfc_rdp_context *)rdp_context;
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		goto issue_mbox_fail;
+		lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
+		return 1;
 	}
 
 	return 0;
 
-prep_mbox_fail:
-issue_mbox_fail:
+rdp_fail:
 	mempool_free(mbox, phba->mbox_mem_pool);
 	return 1;
 }
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 46a01801186b..f2baf3bd8dd8 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -1459,7 +1459,6 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport *vport = pmb->vport;
 	LPFC_MBOXQ_t *sparam_mb;
-	struct lpfc_dmabuf *sparam_mp;
 	u16 status = pmb->u.mb.mbxStatus;
 	int rc;
 
@@ -1508,13 +1507,8 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			sparam_mb->mbox_cmpl = lpfc_mbx_cmpl_read_sparam;
 			rc = lpfc_sli_issue_mbox(phba, sparam_mb, MBX_NOWAIT);
 			if (rc == MBX_NOT_FINISHED) {
-				sparam_mp = (struct lpfc_dmabuf *)
-						sparam_mb->ctx_buf;
-				lpfc_mbuf_free(phba, sparam_mp->virt,
-					       sparam_mp->phys);
-				kfree(sparam_mp);
-				sparam_mb->ctx_buf = NULL;
-				mempool_free(sparam_mb, phba->mbox_mem_pool);
+				lpfc_mbox_rsrc_cleanup(phba, sparam_mb,
+						       MBOX_THD_UNLOCKED);
 				goto sparam_out;
 			}
 
@@ -3313,7 +3307,6 @@ lpfc_start_fdiscs(struct lpfc_hba *phba)
 void
 lpfc_mbx_cmpl_reg_vfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 {
-	struct lpfc_dmabuf *dmabuf = mboxq->ctx_buf;
 	struct lpfc_vport *vport = mboxq->vport;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 
@@ -3394,12 +3387,7 @@ lpfc_mbx_cmpl_reg_vfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	}
 
 out_free_mem:
-	mempool_free(mboxq, phba->mbox_mem_pool);
-	if (dmabuf) {
-		lpfc_mbuf_free(phba, dmabuf->virt, dmabuf->phys);
-		kfree(dmabuf);
-	}
-	return;
+	lpfc_mbox_rsrc_cleanup(phba, mboxq, MBOX_THD_UNLOCKED);
 }
 
 static void
@@ -3444,9 +3432,7 @@ lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		memcpy(&phba->wwpn, &vport->fc_portname, sizeof(phba->wwnn));
 	}
 
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 
 	/* Check if sending the FLOGI is being deferred to after we get
 	 * up to date CSPs from MBX_READ_SPARAM.
@@ -3458,12 +3444,8 @@ lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	return;
 
 out:
-	pmb->ctx_buf = NULL;
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 	lpfc_issue_clear_la(phba, vport);
-	mempool_free(pmb, phba->mbox_mem_pool);
-	return;
 }
 
 static void
@@ -3473,7 +3455,6 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 	LPFC_MBOXQ_t *sparam_mbox, *cfglink_mbox = NULL;
 	struct Scsi_Host *shost;
 	int i;
-	struct lpfc_dmabuf *mp;
 	int rc;
 	struct fcf_record *fcf_record;
 	uint32_t fc_flags = 0;
@@ -3601,10 +3582,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 	sparam_mbox->mbox_cmpl = lpfc_mbx_cmpl_read_sparam;
 	rc = lpfc_sli_issue_mbox(phba, sparam_mbox, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		mp = (struct lpfc_dmabuf *)sparam_mbox->ctx_buf;
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
-		mempool_free(sparam_mbox, phba->mbox_mem_pool);
+		lpfc_mbox_rsrc_cleanup(phba, sparam_mbox, MBOX_THD_UNLOCKED);
 		goto out;
 	}
 
@@ -3880,10 +3858,7 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	}
 
 lpfc_mbx_cmpl_read_topology_free_mbuf:
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
-	return;
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 }
 
 /*
@@ -3896,9 +3871,13 @@ void
 lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport  *vport = pmb->vport;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
+	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
 	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 
+	/* The driver calls the state machine with the pmb pointer
+	 * but wants to make sure a stale ctx_buf isn't acted on.
+	 * The ctx_buf is restored later and cleaned up.
+	 */
 	pmb->ctx_buf = NULL;
 	pmb->ctx_ndlp = NULL;
 
@@ -3935,10 +3914,9 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	/* Call state machine */
 	lpfc_disc_state_machine(vport, ndlp, pmb, NLP_EVT_CMPL_REG_LOGIN);
+	pmb->ctx_buf = mp;
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
 	/* decrement the node reference count held for this callback
 	 * function.
 	 */
@@ -4105,11 +4083,15 @@ lpfc_create_static_vport(struct lpfc_hba *phba)
 
 	vport_buff = (uint8_t *) vport_info;
 	do {
-		/* free dma buffer from previous round */
+		/* While loop iteration forces a free dma buffer from
+		 * the previous loop because the mbox is reused and
+		 * the dump routine is a single-use construct.
+		 */
 		if (pmb->ctx_buf) {
 			mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
 			lpfc_mbuf_free(phba, mp->virt, mp->phys);
 			kfree(mp);
+			pmb->ctx_buf = NULL;
 		}
 		if (lpfc_dump_static_vport(phba, pmb, offset))
 			goto out;
@@ -4194,16 +4176,8 @@ lpfc_create_static_vport(struct lpfc_hba *phba)
 
 out:
 	kfree(vport_info);
-	if (mbx_wait_rc != MBX_TIMEOUT) {
-		if (pmb->ctx_buf) {
-			mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
-			lpfc_mbuf_free(phba, mp->virt, mp->phys);
-			kfree(mp);
-		}
-		mempool_free(pmb, phba->mbox_mem_pool);
-	}
-
-	return;
+	if (mbx_wait_rc != MBX_TIMEOUT)
+		lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 }
 
 /*
@@ -4217,22 +4191,16 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport *vport = pmb->vport;
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 	struct Scsi_Host *shost;
 
-	ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 	pmb->ctx_ndlp = NULL;
-	pmb->ctx_buf = NULL;
 
 	if (mb->mbxStatus) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0258 Register Fabric login error: 0x%x\n",
 				 mb->mbxStatus);
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
-		mempool_free(pmb, phba->mbox_mem_pool);
-
+		lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
 			/* FLOGI failed, use loop map to make discovery list */
 			lpfc_disc_list_loopmap(vport);
@@ -4274,9 +4242,7 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		lpfc_do_scr_ns_plogi(phba, vport);
 	}
 
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 
 	/* Drop the reference count from the mbox at the end after
 	 * all the current reference to the ndlp have been done.
@@ -4370,12 +4336,10 @@ void
 lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
 	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 	struct lpfc_vport *vport = pmb->vport;
 	int rc;
 
-	pmb->ctx_buf = NULL;
 	pmb->ctx_ndlp = NULL;
 	vport->gidft_inp = 0;
 
@@ -4389,9 +4353,7 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * callback function.
 		 */
 		lpfc_nlp_put(ndlp);
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
-		mempool_free(pmb, phba->mbox_mem_pool);
+		lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 
 		/* If the node is not registered with the scsi or nvme
 		 * transport, remove the fabric node.  The failed reg_login
@@ -4480,10 +4442,7 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	 * callback function.
 	 */
 	lpfc_nlp_put(ndlp);
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
-
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 	return;
 }
 
@@ -4497,13 +4456,9 @@ lpfc_mbx_cmpl_fc_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport *vport = pmb->vport;
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
-	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 
-	ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 	pmb->ctx_ndlp = NULL;
-	pmb->ctx_buf = NULL;
-
 	if (mb->mbxStatus) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0933 %s: Register FC login error: 0x%x\n",
@@ -4527,9 +4482,7 @@ lpfc_mbx_cmpl_fc_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 
  out:
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 
 	/* Drop the reference count from the mbox at the end after
 	 * all the current reference to the ndlp have been done.
@@ -5570,7 +5523,6 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 {
 	struct lpfc_hba  *phba = vport->phba;
 	LPFC_MBOXQ_t *mb, *nextmb;
-	struct lpfc_dmabuf *mp;
 
 	/* Cleanup node for NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
@@ -5608,16 +5560,11 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   !(mb->mbox_flag & LPFC_MBX_IMED_UNREG) &&
 		    (ndlp == (struct lpfc_nodelist *)mb->ctx_ndlp)) {
-			mp = (struct lpfc_dmabuf *)(mb->ctx_buf);
-			if (mp) {
-				__lpfc_mbuf_free(phba, mp->virt, mp->phys);
-				kfree(mp);
-			}
 			list_del(&mb->list);
-			mempool_free(mb, phba->mbox_mem_pool);
-			/* We shall not invoke the lpfc_nlp_put to decrement
-			 * the ndlp reference count as we are in the process
-			 * of lpfc_nlp_release.
+			lpfc_mbox_rsrc_cleanup(phba, mb, MBOX_THD_LOCKED);
+
+			/* Don't invoke lpfc_nlp_put. The driver is in
+			 * lpfc_nlp_release context.
 			 */
 		}
 	}
@@ -6462,11 +6409,9 @@ void
 lpfc_mbx_cmpl_fdmi_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_dmabuf   *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
 	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 	struct lpfc_vport    *vport = pmb->vport;
 
-	pmb->ctx_buf = NULL;
 	pmb->ctx_ndlp = NULL;
 
 	if (phba->sli_rev < LPFC_SLI_REV4)
@@ -6497,10 +6442,7 @@ lpfc_mbx_cmpl_fdmi_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	 * function.
 	 */
 	lpfc_nlp_put(ndlp);
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
-
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 	return;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 9efe26b5b77a..ae4ea4eccac9 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -443,15 +443,16 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 				"READ_SPARM mbxStatus x%x\n",
 				mb->mbxCommand, mb->mbxStatus);
 		phba->link_state = LPFC_HBA_ERROR;
-		mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
-		mempool_free(pmb, phba->mbox_mem_pool);
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
+		lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 		return -EIO;
 	}
 
 	mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
 
+	/* This dmabuf was allocated by lpfc_read_sparam. The dmabuf is no
+	 * longer needed.  Prevent unintended ctx_buf access as the mbox is
+	 * reused.
+	 */
 	memcpy(&vport->fc_sparam, mp->virt, sizeof (struct serv_parm));
 	lpfc_mbuf_free(phba, mp->virt, mp->phys);
 	kfree(mp);
@@ -2182,7 +2183,6 @@ lpfc_handle_latt(struct lpfc_hba *phba)
 	struct lpfc_sli   *psli = &phba->sli;
 	LPFC_MBOXQ_t *pmb;
 	volatile uint32_t control;
-	struct lpfc_dmabuf *mp;
 	int rc = 0;
 
 	pmb = (LPFC_MBOXQ_t *)mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
@@ -2191,23 +2191,17 @@ lpfc_handle_latt(struct lpfc_hba *phba)
 		goto lpfc_handle_latt_err_exit;
 	}
 
-	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-	if (!mp) {
+	rc = lpfc_mbox_rsrc_prep(phba, pmb);
+	if (rc) {
 		rc = 2;
-		goto lpfc_handle_latt_free_pmb;
-	}
-
-	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-	if (!mp->virt) {
-		rc = 3;
-		goto lpfc_handle_latt_free_mp;
+		mempool_free(pmb, phba->mbox_mem_pool);
+		goto lpfc_handle_latt_err_exit;
 	}
 
 	/* Cleanup any outstanding ELS commands */
 	lpfc_els_flush_all_cmd(phba);
-
 	psli->slistat.link_event++;
-	lpfc_read_topology(phba, pmb, mp);
+	lpfc_read_topology(phba, pmb, (struct lpfc_dmabuf *)pmb->ctx_buf);
 	pmb->mbox_cmpl = lpfc_mbx_cmpl_read_topology;
 	pmb->vport = vport;
 	/* Block ELS IOCBs until we have processed this mbox command */
@@ -2228,11 +2222,7 @@ lpfc_handle_latt(struct lpfc_hba *phba)
 
 lpfc_handle_latt_free_mbuf:
 	phba->sli.sli3_ring[LPFC_ELS_RING].flag &= ~LPFC_STOP_IOCB_EVENT;
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-lpfc_handle_latt_free_mp:
-	kfree(mp);
-lpfc_handle_latt_free_pmb:
-	mempool_free(pmb, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 lpfc_handle_latt_err_exit:
 	/* Enable Link attention interrupts */
 	spin_lock_irq(&phba->hbalock);
@@ -5315,7 +5305,6 @@ static void
 lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 			 struct lpfc_acqe_link *acqe_link)
 {
-	struct lpfc_dmabuf *mp;
 	LPFC_MBOXQ_t *pmb;
 	MAILBOX_t *mb;
 	struct lpfc_mbx_read_top *la;
@@ -5332,18 +5321,13 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 				"0395 The mboxq allocation failed\n");
 		return;
 	}
-	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-	if (!mp) {
+
+	rc = lpfc_mbox_rsrc_prep(phba, pmb);
+	if (rc) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"0396 The lpfc_dmabuf allocation failed\n");
+				"0396 mailbox allocation failed\n");
 		goto out_free_pmb;
 	}
-	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-	if (!mp->virt) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"0397 The mbuf allocation failed\n");
-		goto out_free_dmabuf;
-	}
 
 	/* Cleanup any outstanding ELS commands */
 	lpfc_els_flush_all_cmd(phba);
@@ -5355,7 +5339,7 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	phba->sli.slistat.link_event++;
 
 	/* Create lpfc_handle_latt mailbox command from link ACQE */
-	lpfc_read_topology(phba, pmb, mp);
+	lpfc_read_topology(phba, pmb, (struct lpfc_dmabuf *)pmb->ctx_buf);
 	pmb->mbox_cmpl = lpfc_mbx_cmpl_read_topology;
 	pmb->vport = phba->pport;
 
@@ -5393,10 +5377,8 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	 */
 	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
-		if (rc == MBX_NOT_FINISHED) {
-			lpfc_mbuf_free(phba, mp->virt, mp->phys);
-			goto out_free_dmabuf;
-		}
+		if (rc == MBX_NOT_FINISHED)
+			goto out_free_pmb;
 		return;
 	}
 	/*
@@ -5431,10 +5413,8 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 
 	return;
 
-out_free_dmabuf:
-	kfree(mp);
 out_free_pmb:
-	mempool_free(pmb, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 }
 
 /**
@@ -6245,7 +6225,6 @@ lpfc_update_trunk_link_status(struct lpfc_hba *phba,
 static void
 lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 {
-	struct lpfc_dmabuf *mp;
 	LPFC_MBOXQ_t *pmb;
 	MAILBOX_t *mb;
 	struct lpfc_mbx_read_top *la;
@@ -6305,18 +6284,12 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 				"2897 The mboxq allocation failed\n");
 		return;
 	}
-	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-	if (!mp) {
+	rc = lpfc_mbox_rsrc_prep(phba, pmb);
+	if (rc) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"2898 The lpfc_dmabuf allocation failed\n");
+				"2898 The mboxq prep failed\n");
 		goto out_free_pmb;
 	}
-	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-	if (!mp->virt) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-				"2899 The mbuf allocation failed\n");
-		goto out_free_dmabuf;
-	}
 
 	/* Cleanup any outstanding ELS commands */
 	lpfc_els_flush_all_cmd(phba);
@@ -6328,7 +6301,7 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 	phba->sli.slistat.link_event++;
 
 	/* Create lpfc_handle_latt mailbox command from link ACQE */
-	lpfc_read_topology(phba, pmb, mp);
+	lpfc_read_topology(phba, pmb, (struct lpfc_dmabuf *)pmb->ctx_buf);
 	pmb->mbox_cmpl = lpfc_mbx_cmpl_read_topology;
 	pmb->vport = phba->pport;
 
@@ -6372,16 +6345,12 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 	}
 
 	rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
-	if (rc == MBX_NOT_FINISHED) {
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		goto out_free_dmabuf;
-	}
+	if (rc == MBX_NOT_FINISHED)
+		goto out_free_pmb;
 	return;
 
-out_free_dmabuf:
-	kfree(mp);
 out_free_pmb:
-	mempool_free(pmb, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index e1404ab5000d..712c8f6e4de2 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -43,6 +43,80 @@
 #include "lpfc_crtn.h"
 #include "lpfc_compat.h"
 
+/**
+ * lpfc_mbox_rsrc_prep - Prepare a mailbox with DMA buffer memory.
+ * @phba: pointer to lpfc hba data structure.
+ * @mbox: pointer to the driver internal queue element for mailbox command.
+ *
+ * A mailbox command consists of the pool memory for the command, @mbox, and
+ * one or more DMA buffers for the data transfer.  This routine provides
+ * a standard framework for allocating the dma buffer and assigning to the
+ * @mbox.  Callers should cleanup the mbox with a call to
+ * lpfc_mbox_rsrc_cleanup.
+ *
+ * The lpfc_mbuf_alloc routine acquires the hbalock so the caller is
+ * responsible to ensure the hbalock is released.  Also note that the
+ * driver design is a single dmabuf/mbuf per mbox in the ctx_buf.
+ *
+ **/
+int
+lpfc_mbox_rsrc_prep(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
+{
+	struct lpfc_dmabuf *mp;
+
+	mp = kmalloc(sizeof(*mp), GFP_KERNEL);
+	if (!mp)
+		return -ENOMEM;
+
+	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
+	if (!mp->virt) {
+		kfree(mp);
+		return -ENOMEM;
+	}
+
+	memset(mp->virt, 0, LPFC_BPL_SIZE);
+
+	/* Initialization only.  Driver does not use a list of dmabufs. */
+	INIT_LIST_HEAD(&mp->list);
+	mbox->ctx_buf = mp;
+	return 0;
+}
+
+/**
+ * lpfc_mbox_rsrc_cleanup - Free the mailbox DMA buffer and virtual memory.
+ * @phba: pointer to lpfc hba data structure.
+ * @mbox: pointer to the driver internal queue element for mailbox command.
+ * @locked: value that indicates if the hbalock is held (1) or not (0).
+ *
+ * A mailbox command consists of the pool memory for the command, @mbox, and
+ * possibly a DMA buffer for the data transfer.  This routine provides
+ * a standard framework for releasing any dma buffers and freeing all
+ * memory resources in it as well as releasing the @mbox back to the @phba pool.
+ * Callers should use this routine for cleanup for all mailboxes prepped with
+ * lpfc_mbox_rsrc_prep.
+ *
+ **/
+void
+lpfc_mbox_rsrc_cleanup(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox,
+		       enum lpfc_mbox_ctx locked)
+{
+	struct lpfc_dmabuf *mp;
+
+	mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
+	mbox->ctx_buf = NULL;
+
+	/* Release the generic BPL buffer memory.  */
+	if (mp) {
+		if (locked == MBOX_THD_LOCKED)
+			__lpfc_mbuf_free(phba, mp->virt, mp->phys);
+		else
+			lpfc_mbuf_free(phba, mp->virt, mp->phys);
+		kfree(mp);
+	}
+
+	mempool_free(mbox, phba->mbox_mem_pool);
+}
+
 /**
  * lpfc_dump_static_vport - Dump HBA's static vport information.
  * @phba: pointer to lpfc hba data structure.
@@ -61,6 +135,7 @@ lpfc_dump_static_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb,
 {
 	MAILBOX_t *mb;
 	struct lpfc_dmabuf *mp;
+	int rc;
 
 	mb = &pmb->u.mb;
 
@@ -79,22 +154,15 @@ lpfc_dump_static_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb,
 		return 0;
 	}
 
-	/* For SLI4 HBAs driver need to allocate memory */
-	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-	if (mp)
-		mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-
-	if (!mp || !mp->virt) {
-		kfree(mp);
+	rc = lpfc_mbox_rsrc_prep(phba, pmb);
+	if (rc) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
-			"2605 lpfc_dump_static_vport: memory"
-			" allocation failed\n");
+				"2605 %s: memory allocation failed\n",
+				__func__);
 		return 1;
 	}
-	memset(mp->virt, 0, LPFC_BPL_SIZE);
-	INIT_LIST_HEAD(&mp->list);
-	/* save address for completion */
-	pmb->ctx_buf = (uint8_t *)mp;
+
+	mp = pmb->ctx_buf;
 	mb->un.varWords[3] = putPaddrLow(mp->phys);
 	mb->un.varWords[4] = putPaddrHigh(mp->phys);
 	mb->un.varDmp.sli4_length = sizeof(struct static_vport_info);
@@ -606,26 +674,21 @@ lpfc_read_sparam(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb, int vpi)
 {
 	struct lpfc_dmabuf *mp;
 	MAILBOX_t *mb;
+	int rc;
 
-	mb = &pmb->u.mb;
 	memset(pmb, 0, sizeof (LPFC_MBOXQ_t));
 
-	mb->mbxOwner = OWN_HOST;
-
 	/* Get a buffer to hold the HBAs Service Parameters */
-
-	mp = kmalloc(sizeof (struct lpfc_dmabuf), GFP_KERNEL);
-	if (mp)
-		mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-	if (!mp || !mp->virt) {
-		kfree(mp);
-		mb->mbxCommand = MBX_READ_SPARM64;
-		/* READ_SPARAM: no buffers */
+	rc = lpfc_mbox_rsrc_prep(phba, pmb);
+	if (rc) {
 		lpfc_printf_log(phba, KERN_WARNING, LOG_MBOX,
 			        "0301 READ_SPARAM: no buffers\n");
-		return (1);
+		return 1;
 	}
-	INIT_LIST_HEAD(&mp->list);
+
+	mp = pmb->ctx_buf;
+	mb = &pmb->u.mb;
+	mb->mbxOwner = OWN_HOST;
 	mb->mbxCommand = MBX_READ_SPARM64;
 	mb->un.varRdSparm.un.sp64.tus.f.bdeSize = sizeof (struct serv_parm);
 	mb->un.varRdSparm.un.sp64.addrHigh = putPaddrHigh(mp->phys);
@@ -633,9 +696,6 @@ lpfc_read_sparam(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb, int vpi)
 	if (phba->sli_rev >= LPFC_SLI_REV3)
 		mb->un.varRdSparm.vpi = phba->vpi_ids[vpi];
 
-	/* save address for completion */
-	pmb->ctx_buf = mp;
-
 	return (0);
 }
 
@@ -756,6 +816,7 @@ lpfc_reg_rpi(struct lpfc_hba *phba, uint16_t vpi, uint32_t did,
 	MAILBOX_t *mb = &pmb->u.mb;
 	uint8_t *sparam;
 	struct lpfc_dmabuf *mp;
+	int rc;
 
 	memset(pmb, 0, sizeof (LPFC_MBOXQ_t));
 
@@ -766,12 +827,10 @@ lpfc_reg_rpi(struct lpfc_hba *phba, uint16_t vpi, uint32_t did,
 		mb->un.varRegLogin.vpi = phba->vpi_ids[vpi];
 	mb->un.varRegLogin.did = did;
 	mb->mbxOwner = OWN_HOST;
+
 	/* Get a buffer to hold NPorts Service Parameters */
-	mp = kmalloc(sizeof (struct lpfc_dmabuf), GFP_KERNEL);
-	if (mp)
-		mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-	if (!mp || !mp->virt) {
-		kfree(mp);
+	rc = lpfc_mbox_rsrc_prep(phba, pmb);
+	if (rc) {
 		mb->mbxCommand = MBX_REG_LOGIN64;
 		/* REG_LOGIN: no buffers */
 		lpfc_printf_log(phba, KERN_WARNING, LOG_MBOX,
@@ -779,15 +838,13 @@ lpfc_reg_rpi(struct lpfc_hba *phba, uint16_t vpi, uint32_t did,
 				"rpi x%x\n", vpi, did, rpi);
 		return 1;
 	}
-	INIT_LIST_HEAD(&mp->list);
-	sparam = mp->virt;
 
 	/* Copy param's into a new buffer */
+	mp = pmb->ctx_buf;
+	sparam = mp->virt;
 	memcpy(sparam, param, sizeof (struct serv_parm));
 
-	/* save address for completion */
-	pmb->ctx_buf = (uint8_t *)mp;
-
+	/* Finish initializing the mailbox. */
 	mb->mbxCommand = MBX_REG_LOGIN64;
 	mb->un.varRegLogin.un.sp64.tus.f.bdeSize = sizeof (struct serv_parm);
 	mb->un.varRegLogin.un.sp64.addrHigh = putPaddrHigh(mp->phys);
@@ -1723,7 +1780,9 @@ lpfc_sli4_mbx_sge_get(struct lpfcMboxq *mbox, uint32_t sgentry,
  * @phba: pointer to lpfc hba data structure.
  * @mbox: pointer to lpfc mbox command.
  *
- * This routine frees SLI4 specific mailbox command for sending IOCTL command.
+ * This routine cleans up and releases an SLI4 mailbox command that was
+ * configured using lpfc_sli4_config.  It accounts for the embedded and
+ * non-embedded config types.
  **/
 void
 lpfc_sli4_mbox_cmd_free(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
@@ -2277,33 +2336,24 @@ lpfc_sli4_dump_cfg_rg23(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
 {
 	struct lpfc_dmabuf *mp = NULL;
 	MAILBOX_t *mb;
+	int rc;
 
 	memset(mbox, 0, sizeof(*mbox));
 	mb = &mbox->u.mb;
 
-	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-	if (mp)
-		mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-
-	if (!mp || !mp->virt) {
-		kfree(mp);
-		/* dump config region 23 failed to allocate memory */
+	rc = lpfc_mbox_rsrc_prep(phba, mbox);
+	if (rc) {
 		lpfc_printf_log(phba, KERN_WARNING, LOG_MBOX,
-			"2569 lpfc dump config region 23: memory"
-			" allocation failed\n");
+				"2569 %s: memory allocation failed\n",
+				__func__);
 		return 1;
 	}
 
-	memset(mp->virt, 0, LPFC_BPL_SIZE);
-	INIT_LIST_HEAD(&mp->list);
-
-	/* save address for completion */
-	mbox->ctx_buf = (uint8_t *)mp;
-
 	mb->mbxCommand = MBX_DUMP_MEMORY;
 	mb->un.varDmp.type = DMP_NV_PARAMS;
 	mb->un.varDmp.region_id = DMP_REGION_23;
 	mb->un.varDmp.sli4_length = DMP_RGN23_SIZE;
+	mp = mbox->ctx_buf;
 	mb->un.varWords[3] = putPaddrLow(mp->phys);
 	mb->un.varWords[4] = putPaddrHigh(mp->phys);
 	return 0;
@@ -2326,7 +2376,7 @@ lpfc_mbx_cmpl_rdp_link_stat(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	rc = SUCCESS;
 
 mbx_failed:
-	lpfc_sli4_mbox_cmd_free(phba, mboxq);
+	lpfc_mbox_rsrc_cleanup(phba, mboxq, MBOX_THD_UNLOCKED);
 	rdp_context->cmpl(phba, rdp_context, rc);
 }
 
@@ -2338,30 +2388,25 @@ lpfc_mbx_cmpl_rdp_page_a2(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 			(struct lpfc_rdp_context *)(mbox->ctx_ndlp);
 
 	if (bf_get(lpfc_mqe_status, &mbox->u.mqe))
-		goto error_mbuf_free;
+		goto error_mbox_free;
 
 	lpfc_sli_bemem_bcopy(mp->virt, &rdp_context->page_a2,
 				DMP_SFF_PAGE_A2_SIZE);
 
-	/* We don't need dma buffer for link stat. */
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-
-	memset(mbox, 0, sizeof(*mbox));
 	lpfc_read_lnk_stat(phba, mbox);
 	mbox->vport = rdp_context->ndlp->vport;
+
+	/* Save the dma buffer for cleanup in the final completion. */
+	mbox->ctx_buf = mp;
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_rdp_link_stat;
 	mbox->ctx_ndlp = (struct lpfc_rdp_context *)rdp_context;
 	if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT) == MBX_NOT_FINISHED)
-		goto error_cmd_free;
+		goto error_mbox_free;
 
 	return;
 
-error_mbuf_free:
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-error_cmd_free:
-	lpfc_sli4_mbox_cmd_free(phba, mbox);
+error_mbox_free:
+	lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 	rdp_context->cmpl(phba, rdp_context, FAILURE);
 }
 
@@ -2409,9 +2454,7 @@ lpfc_mbx_cmpl_rdp_page_a0(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 	return;
 
 error:
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	lpfc_sli4_mbox_cmd_free(phba, mbox);
+	lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 	rdp_context->cmpl(phba, rdp_context, FAILURE);
 }
 
@@ -2427,27 +2470,19 @@ lpfc_mbx_cmpl_rdp_page_a0(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 int
 lpfc_sli4_dump_page_a0(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
 {
+	int rc;
 	struct lpfc_dmabuf *mp = NULL;
 
 	memset(mbox, 0, sizeof(*mbox));
 
-	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-	if (mp)
-		mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
-	if (!mp || !mp->virt) {
-		kfree(mp);
+	rc = lpfc_mbox_rsrc_prep(phba, mbox);
+	if (rc) {
 		lpfc_printf_log(phba, KERN_WARNING, LOG_MBOX,
 			"3569 dump type 3 page 0xA0 allocation failed\n");
 		return 1;
 	}
 
-	memset(mp->virt, 0, LPFC_BPL_SIZE);
-	INIT_LIST_HEAD(&mp->list);
-
 	bf_set(lpfc_mqe_command, &mbox->u.mqe, MBX_DUMP_MEMORY);
-	/* save address for completion */
-	mbox->ctx_buf = mp;
-
 	bf_set(lpfc_mbx_memory_dump_type3_type,
 		&mbox->u.mqe.un.mem_dump_type3, DMP_LMSD);
 	bf_set(lpfc_mbx_memory_dump_type3_link,
@@ -2456,6 +2491,8 @@ lpfc_sli4_dump_page_a0(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
 		&mbox->u.mqe.un.mem_dump_type3, DMP_PAGE_A0);
 	bf_set(lpfc_mbx_memory_dump_type3_length,
 		&mbox->u.mqe.un.mem_dump_type3, DMP_SFF_PAGE_A0_SIZE);
+
+	mp = mbox->ctx_buf;
 	mbox->u.mqe.un.mem_dump_type3.addr_lo = putPaddrLow(mp->phys);
 	mbox->u.mqe.un.mem_dump_type3.addr_hi = putPaddrHigh(mp->phys);
 
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index fbfa3252be7a..5829b4dcfb7b 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -327,7 +327,6 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_hba    *phba = vport->phba;
 	struct lpfc_dmabuf *pcmd;
-	struct lpfc_dmabuf *mp;
 	uint64_t nlp_portwwn = 0;
 	uint32_t *lp;
 	union lpfc_wqe128 *wqe;
@@ -592,12 +591,8 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		 * a default RPI.
 		 */
 		if (phba->sli_rev == LPFC_SLI_REV4) {
-			mp = (struct lpfc_dmabuf *)login_mbox->ctx_buf;
-			if (mp) {
-				lpfc_mbuf_free(phba, mp->virt, mp->phys);
-				kfree(mp);
-			}
-			mempool_free(login_mbox, phba->mbox_mem_pool);
+			lpfc_mbox_rsrc_cleanup(phba, login_mbox,
+					       MBOX_THD_UNLOCKED);
 			login_mbox = NULL;
 		} else {
 			/* In order to preserve RPIs, we want to cleanup
@@ -615,14 +610,9 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		stat.un.b.lsRjtRsnCodeExp = LSEXP_NOTHING_MORE;
 		rc = lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb,
 					 ndlp, login_mbox);
-		if (rc) {
-			mp = (struct lpfc_dmabuf *)login_mbox->ctx_buf;
-			if (mp) {
-				lpfc_mbuf_free(phba, mp->virt, mp->phys);
-				kfree(mp);
-			}
-			mempool_free(login_mbox, phba->mbox_mem_pool);
-		}
+		if (rc && login_mbox)
+			lpfc_mbox_rsrc_cleanup(phba, login_mbox,
+					       MBOX_THD_UNLOCKED);
 		return 1;
 	}
 
@@ -1334,7 +1324,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 {
 	struct lpfc_hba    *phba = vport->phba;
 	struct lpfc_iocbq  *cmdiocb, *rspiocb;
-	struct lpfc_dmabuf *pcmd, *prsp, *mp;
+	struct lpfc_dmabuf *pcmd, *prsp;
 	uint32_t *lp;
 	uint32_t vid, flag;
 	struct serv_parm *sp;
@@ -1501,11 +1491,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 		 * command
 		 */
 		lpfc_nlp_put(ndlp);
-		mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
-		mempool_free(mbox, phba->mbox_mem_pool);
-
+		lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0134 PLOGI: cannot issue reg_login "
 				 "Data: x%x x%x x%x x%x\n",
@@ -1856,7 +1842,6 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	struct lpfc_iocbq *cmdiocb = (struct lpfc_iocbq *) arg;
 	LPFC_MBOXQ_t	  *mb;
 	LPFC_MBOXQ_t	  *nextmb;
-	struct lpfc_dmabuf *mp;
 	struct lpfc_nodelist *ns_ndlp;
 
 	cmdiocb = (struct lpfc_iocbq *) arg;
@@ -1876,16 +1861,11 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	list_for_each_entry_safe(mb, nextmb, &phba->sli.mboxq, list) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   (ndlp == (struct lpfc_nodelist *)mb->ctx_ndlp)) {
-			mp = (struct lpfc_dmabuf *)(mb->ctx_buf);
-			if (mp) {
-				__lpfc_mbuf_free(phba, mp->virt, mp->phys);
-				kfree(mp);
-			}
 			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
 			lpfc_nlp_put(ndlp);
 			list_del(&mb->list);
 			phba->sli.mboxq_cnt--;
-			mempool_free(mb, phba->mbox_mem_pool);
+			lpfc_mbox_rsrc_cleanup(phba, mb, MBOX_THD_LOCKED);
 		}
 	}
 	spin_unlock_irq(&phba->hbalock);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index ae26a004552d..c4b00e188f0f 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2848,19 +2848,11 @@ void
 lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport  *vport = pmb->vport;
-	struct lpfc_dmabuf *mp;
 	struct lpfc_nodelist *ndlp;
 	struct Scsi_Host *shost;
 	uint16_t rpi, vpi;
 	int rc;
 
-	mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
-
-	if (mp) {
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
-	}
-
 	/*
 	 * If a REG_LOGIN succeeded  after node is destroyed or node
 	 * is in re-discovery driver need to cleanup the RPI.
@@ -2893,8 +2885,6 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	if (pmb->u.mb.mbxCommand == MBX_REG_LOGIN64) {
 		ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 		lpfc_nlp_put(ndlp);
-		pmb->ctx_buf = NULL;
-		pmb->ctx_ndlp = NULL;
 	}
 
 	if (pmb->u.mb.mbxCommand == MBX_UNREG_LOGIN) {
@@ -2945,7 +2935,7 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	if (bf_get(lpfc_mqe_command, &pmb->u.mqe) == MBX_SLI4_CONFIG)
 		lpfc_sli4_mbox_cmd_free(phba, pmb);
 	else
-		mempool_free(pmb, phba->mbox_mem_pool);
+		lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 }
  /**
  * lpfc_sli4_unreg_rpi_cmpl_clr - mailbox completion handler
@@ -5851,26 +5841,20 @@ lpfc_sli4_read_fcoe_params(struct lpfc_hba *phba)
 			mboxq->mcqe.trailer);
 
 	if (rc) {
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
 		rc = -EIO;
 		goto out_free_mboxq;
 	}
 	data_length = mqe->un.mb_words[5];
 	if (data_length > DMP_RGN23_SIZE) {
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
 		rc = -EIO;
 		goto out_free_mboxq;
 	}
 
 	lpfc_parse_fcoe_conf(phba, mp->virt, data_length);
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
 	rc = 0;
 
 out_free_mboxq:
-	mempool_free(mboxq, phba->mbox_mem_pool);
+	lpfc_mbox_rsrc_cleanup(phba, mboxq, MBOX_THD_UNLOCKED);
 	return rc;
 }
 
@@ -8539,8 +8523,9 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	}
 
 	/*
-	 * This memory was allocated by the lpfc_read_sparam routine. Release
-	 * it to the mbuf pool.
+	 * This memory was allocated by the lpfc_read_sparam routine but is
+	 * no longer needed.  It is released and ctx_buf NULLed to prevent
+	 * unintended pointer access as the mbox is reused.
 	 */
 	lpfc_mbuf_free(phba, mp->virt, mp->phys);
 	kfree(mp);
@@ -12065,7 +12050,6 @@ lpfc_ignore_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp = cmdiocb->ndlp;
 	IOCB_t *irsp;
 	LPFC_MBOXQ_t *mbox;
-	struct lpfc_dmabuf *mp;
 	u32 ulp_command, ulp_status, ulp_word4, iotag;
 
 	ulp_command = get_job_cmnd(phba, cmdiocb);
@@ -12084,12 +12068,7 @@ lpfc_ignore_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 */
 		if (cmdiocb->context_un.mbox) {
 			mbox = cmdiocb->context_un.mbox;
-			mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-			if (mp) {
-				lpfc_mbuf_free(phba, mp->virt, mp->phys);
-				kfree(mp);
-			}
-			mempool_free(mbox, phba->mbox_mem_pool);
+			lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 			cmdiocb->context_un.mbox = NULL;
 		}
 	}
@@ -15744,7 +15723,6 @@ lpfc_modify_hba_eq_delay(struct lpfc_hba *phba, uint32_t startq,
 
 	mbox->vport = phba->pport;
 	mbox->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
-	mbox->ctx_buf = NULL;
 	mbox->ctx_ndlp = NULL;
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_POLL);
 	shdr = (union lpfc_sli4_cfg_shdr *) &eq_delay->header.cfg_shdr;
@@ -20341,11 +20319,7 @@ lpfc_sli4_get_config_region23(struct lpfc_hba *phba, char *rgn23_data)
 	}
 	lpfc_sli_pcimem_bcopy((char *)mp->virt, rgn23_data, data_length);
 out:
-	mempool_free(mboxq, phba->mbox_mem_pool);
-	if (mp) {
-		lpfc_mbuf_free(phba, mp->virt, mp->phys);
-		kfree(mp);
-	}
+	lpfc_mbox_rsrc_cleanup(phba, mboxq, MBOX_THD_UNLOCKED);
 	return data_length;
 }
 
@@ -20660,7 +20634,6 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 {
 	struct lpfc_hba *phba = vport->phba;
 	LPFC_MBOXQ_t *mb, *nextmb;
-	struct lpfc_dmabuf *mp;
 	struct lpfc_nodelist *ndlp;
 	struct lpfc_nodelist *act_mbx_ndlp = NULL;
 	LIST_HEAD(mbox_cmd_list);
@@ -20730,12 +20703,6 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 	while (!list_empty(&mbox_cmd_list)) {
 		list_remove_head(&mbox_cmd_list, mb, LPFC_MBOXQ_t, list);
 		if (mb->u.mb.mbxCommand == MBX_REG_LOGIN64) {
-			mp = (struct lpfc_dmabuf *)(mb->ctx_buf);
-			if (mp) {
-				__lpfc_mbuf_free(phba, mp->virt, mp->phys);
-				kfree(mp);
-			}
-			mb->ctx_buf = NULL;
 			ndlp = (struct lpfc_nodelist *)mb->ctx_ndlp;
 			mb->ctx_ndlp = NULL;
 			if (ndlp) {
@@ -20745,7 +20712,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 				lpfc_nlp_put(ndlp);
 			}
 		}
-		mempool_free(mb, phba->mbox_mem_pool);
+		lpfc_mbox_rsrc_cleanup(phba, mb, MBOX_THD_UNLOCKED);
 	}
 
 	/* Release the ndlp with the cleaned-up active mailbox command */
@@ -21892,7 +21859,6 @@ lpfc_read_object(struct lpfc_hba *phba, char *rdobject, uint32_t *datap,
 
 	mbox->vport = phba->pport;
 	mbox->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
-	mbox->ctx_buf = NULL;
 	mbox->ctx_ndlp = NULL;
 
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_POLL);
@@ -21929,9 +21895,12 @@ lpfc_read_object(struct lpfc_hba *phba, char *rdobject, uint32_t *datap,
 	}
 
  exit:
+	/* This is an embedded SLI4 mailbox with an external buffer allocated.
+	 * Free the pcmd and then cleanup with the correct routine.
+	 */
 	lpfc_mbuf_free(phba, pcmd->virt, pcmd->phys);
 	kfree(pcmd);
-	mempool_free(mbox, phba->mbox_mem_pool);
+	lpfc_sli4_mbox_cmd_free(phba, mbox);
 	return byte_cnt;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 776eb4ab52d2..0af6860b8936 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -35,6 +35,12 @@ typedef enum _lpfc_ctx_cmd {
 	LPFC_CTX_HOST
 } lpfc_ctx_cmd;
 
+/* Enumeration to describe the thread lock context. */
+enum lpfc_mbox_ctx {
+	MBOX_THD_UNLOCKED,
+	MBOX_THD_LOCKED
+};
+
 union lpfc_vmid_tag {
 	uint32_t app_id;
 	uint8_t cs_ctl_vmid;
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index d694d0cff5a5..f635eb8e9711 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -135,12 +135,14 @@ lpfc_vport_sparm(struct lpfc_hba *phba, struct lpfc_vport *vport)
 	}
 
 	/*
-	 * Grab buffer pointer and clear context1 so we can use
-	 * lpfc_sli_issue_box_wait
+	 * Wait for the read_sparams mailbox to complete.  Driver needs
+	 * this per vport to start the FDISC.  If the mailbox fails,
+	 * just cleanup and return an error unless the failure is a
+	 * mailbox timeout.  For MBX_TIMEOUT, allow the default
+	 * mbox completion handler to take care of the cleanup.  This
+	 * is safe as the mailbox command isn't one that triggers
+	 * another mailbox.
 	 */
-	mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
-	pmb->ctx_buf = NULL;
-
 	pmb->vport = vport;
 	rc = lpfc_sli_issue_mbox_wait(phba, pmb, phba->fc_ratov * 2);
 	if (rc != MBX_SUCCESS) {
@@ -148,34 +150,29 @@ lpfc_vport_sparm(struct lpfc_hba *phba, struct lpfc_vport *vport)
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "1830 Signal aborted mbxCmd x%x\n",
 					 mb->mbxCommand);
-			lpfc_mbuf_free(phba, mp->virt, mp->phys);
-			kfree(mp);
 			if (rc != MBX_TIMEOUT)
-				mempool_free(pmb, phba->mbox_mem_pool);
+				lpfc_mbox_rsrc_cleanup(phba, pmb,
+						       MBOX_THD_UNLOCKED);
 			return -EINTR;
 		} else {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "1818 VPort failed init, mbxCmd x%x "
 					 "READ_SPARM mbxStatus x%x, rc = x%x\n",
 					 mb->mbxCommand, mb->mbxStatus, rc);
-			lpfc_mbuf_free(phba, mp->virt, mp->phys);
-			kfree(mp);
 			if (rc != MBX_TIMEOUT)
-				mempool_free(pmb, phba->mbox_mem_pool);
+				lpfc_mbox_rsrc_cleanup(phba, pmb,
+						       MBOX_THD_UNLOCKED);
 			return -EIO;
 		}
 	}
 
+	mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
 	memcpy(&vport->fc_sparam, mp->virt, sizeof (struct serv_parm));
 	memcpy(&vport->fc_nodename, &vport->fc_sparam.nodeName,
 	       sizeof (struct lpfc_name));
 	memcpy(&vport->fc_portname, &vport->fc_sparam.portName,
 	       sizeof (struct lpfc_name));
-
-	lpfc_mbuf_free(phba, mp->virt, mp->phys);
-	kfree(mp);
-	mempool_free(pmb, phba->mbox_mem_pool);
-
+	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
 	return 0;
 }
 
-- 
2.26.2

