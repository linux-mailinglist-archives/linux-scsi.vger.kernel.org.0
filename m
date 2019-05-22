Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB825B47
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfEVAt3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37663 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfEVAt2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so179136pll.4
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7P7rAcRLVwcT//Zl7ym7fSP8NHGnFsvFpulcejwWEU8=;
        b=ok/lhFCbTbRxx7gA6ZNESQM/6wHUhx8OaXqWgSpuKs8v5k3jqEJkY6quA/rAB+LIfp
         yxxmtNFvMUADblP7s3atnc1uefubmi6oBYlyBTd/7urd3vznWkj86MnPqDtLbEMZJr9T
         4r5M3j7ak9ynDsVeRebzdB0wFzWHfUgzmk3Xsabf1xyFYCIeYd/nJJzI88BlsZIcT/e9
         j+jwMNBL2V/eyJuYN4PgJvlOjsaKk0SAp6n8PURMOO246EnpKCYqgv/quHin2DoloQ47
         S+PnilRrp+FtP9Dlkc/o/LacZUEg42UwVqufOP+aIrdH6Ka4Z95w27kglmv94qaOtI7k
         vSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7P7rAcRLVwcT//Zl7ym7fSP8NHGnFsvFpulcejwWEU8=;
        b=qSD58+jGCWtOliV1WaMOMgGPIEkcB1CnGpzXLpNHZQcf5FRF3rYvk+RoBjKg2cQnpI
         QwWjTZ/auviugUJCHN8EsIk5AU8YrW1ThNa6vEIeYHDGKKiHC6wOFWOMeivGXj3oxdqJ
         Ejou/E/C9qEEHSPltxAV+y/K1ldglOPUdTsctVRsnh6bsn3r1vfnKW1sOTgBu0UV0Cbe
         2NvyCplXBgv0eOFqRjdQG8CHaLi+qSBNgYYtWI7E73hMzBjD3/ZLJKpQP7zbMS5T3nvs
         r5BH1Pczng+QCpKzobqmSm1S3WsDEVSb7HXEcRZ4rZle+18TEeFqkyWFpRLtKBTVGsVl
         NNXg==
X-Gm-Message-State: APjAAAV0j9cw1kGdGy650UXbnkw7knZj/K/E3WrKDOIs6t/cWVJk/Mya
        BD/eU8QABTixgoug72N5cQJZFeRh
X-Google-Smtp-Source: APXvYqz4tAsyYLn8bQldTc16FX4acgRRkdJlZ3Y52GifiOTwnHm9aN5jKNTe0/IYg+Y2+lJ1LuOSfQ==
X-Received: by 2002:a17:902:7406:: with SMTP id g6mr85170351pll.328.1558486166984;
        Tue, 21 May 2019 17:49:26 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:26 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 06/21] lpfc: Fix nvmet handling of received ABTS for unmapped frames
Date:   Tue, 21 May 2019 17:48:56 -0700
Message-Id: <20190522004911.573-7-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver currently is relying on firmware to match ABTS's to
existing exchanges. This works fine as long as an exchange has
been assigned to the io and work posted to it. However, for
unmapped frames (rxid=0xFFFF), the driver has yet to assign an
xri. The driver was blindly saying it couldn't match the ABTS
and sending the BA_xxx. However, the command frame may have been
in queues waiting on xri's before posting to the nvmet_fc layer.
When xri's became available, the command frame would still be
pushed to the transport and that io would execute, even though
the io had been killed by ABTS. The initiator, seeing the io
ABTS'd, would reuse the exchange for a different io which would
be received on the target and pushed up. If the "zombie" io then
came back down and started transmitting, the initiator would
match the oxid and accept erroneous data. Bad things happened.

Add tracking of active exchanges in the target to allow matching of
a received ABTS against active or pending IO requests. If the ABTS is
matched to a pending or active IO, the drive initiates cleanup and
conditionally notifies the transport.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c  |   2 +
 drivers/scsi/lpfc/lpfc_nvmet.c | 234 ++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/lpfc/lpfc_nvmet.h |   1 +
 drivers/scsi/lpfc/lpfc_sli4.h  |   2 +
 4 files changed, 214 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index eaaef682de25..70afa585b027 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -6551,6 +6551,8 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		spin_lock_init(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		INIT_LIST_HEAD(&phba->sli4_hba.lpfc_abts_nvmet_ctx_list);
 		INIT_LIST_HEAD(&phba->sli4_hba.lpfc_nvmet_io_wait_list);
+		spin_lock_init(&phba->sli4_hba.t_active_list_lock);
+		INIT_LIST_HEAD(&phba->sli4_hba.t_active_ctx_list);
 	}
 
 	/* This abort list used by worker thread */
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 95386f90a874..a943b2a20001 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -220,19 +220,66 @@ lpfc_nvmet_cmd_template(void)
 	/* Word 12, 13, 14, 15 - is zero */
 }
 
+struct lpfc_nvmet_rcv_ctx *
+lpfc_nvmet_get_ctx_for_xri(struct lpfc_hba *phba, u16 xri)
+{
+	struct lpfc_nvmet_rcv_ctx *ctxp;
+	unsigned long iflag;
+	bool found = false;
+
+	spin_lock_irqsave(&phba->sli4_hba.t_active_list_lock, iflag);
+	list_for_each_entry(ctxp, &phba->sli4_hba.t_active_ctx_list, list) {
+		if (ctxp->ctxbuf->sglq->sli4_xritag != xri)
+			continue;
+
+		found = true;
+		break;
+	}
+	spin_unlock_irqrestore(&phba->sli4_hba.t_active_list_lock, iflag);
+	if (found)
+		return ctxp;
+
+	return NULL;
+}
+
+struct lpfc_nvmet_rcv_ctx *
+lpfc_nvmet_get_ctx_for_oxid(struct lpfc_hba *phba, u16 oxid, u32 sid)
+{
+	struct lpfc_nvmet_rcv_ctx *ctxp;
+	unsigned long iflag;
+	bool found = false;
+
+	spin_lock_irqsave(&phba->sli4_hba.t_active_list_lock, iflag);
+	list_for_each_entry(ctxp, &phba->sli4_hba.t_active_ctx_list, list) {
+		if (ctxp->oxid != oxid || ctxp->sid != sid)
+			continue;
+
+		found = true;
+		break;
+	}
+	spin_unlock_irqrestore(&phba->sli4_hba.t_active_list_lock, iflag);
+	if (found)
+		return ctxp;
+
+	return NULL;
+}
+
 static void
 lpfc_nvmet_defer_release(struct lpfc_hba *phba, struct lpfc_nvmet_rcv_ctx *ctxp)
 {
 	lockdep_assert_held(&ctxp->ctxlock);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6313 NVMET Defer ctx release xri x%x flg x%x\n",
+			"6313 NVMET Defer ctx release oxid x%x flg x%x\n",
 			ctxp->oxid, ctxp->flag);
 
 	if (ctxp->flag & LPFC_NVMET_CTX_RLS)
 		return;
 
 	ctxp->flag |= LPFC_NVMET_CTX_RLS;
+	spin_lock(&phba->sli4_hba.t_active_list_lock);
+	list_del(&ctxp->list);
+	spin_unlock(&phba->sli4_hba.t_active_list_lock);
 	spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 	list_add_tail(&ctxp->list, &phba->sli4_hba.lpfc_abts_nvmet_ctx_list);
 	spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
@@ -410,9 +457,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 #endif
 		atomic_inc(&tgtp->rcv_fcp_cmd_in);
 
-		/*  flag new work queued, replacement buffer has already
-		 *  been reposted
-		 */
+		/* Indicate that a replacement buffer has been posted */
 		spin_lock_irqsave(&ctxp->ctxlock, iflag);
 		ctxp->flag |= LPFC_NVMET_CTX_REUSE_WQ;
 		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
@@ -441,6 +486,9 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 	 * Use the CPU context list, from the MRQ the IO was received on
 	 * (ctxp->idx), to save context structure.
 	 */
+	spin_lock_irqsave(&phba->sli4_hba.t_active_list_lock, iflag);
+	list_del_init(&ctxp->list);
+	spin_unlock_irqrestore(&phba->sli4_hba.t_active_list_lock, iflag);
 	cpu = raw_smp_processor_id();
 	infop = lpfc_get_ctx_list(phba, cpu, ctxp->idx);
 	spin_lock_irqsave(&infop->nvmet_ctx_list_lock, iflag);
@@ -708,8 +756,10 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		}
 
 		lpfc_printf_log(phba, KERN_INFO, logerr,
-				"6315 IO Error Cmpl xri x%x: %x/%x XBUSY:x%x\n",
-				ctxp->oxid, status, result, ctxp->flag);
+				"6315 IO Error Cmpl oxid: x%x xri: x%x %x/%x "
+				"XBUSY:x%x\n",
+				ctxp->oxid, ctxp->ctxbuf->sglq->sli4_xritag,
+				status, result, ctxp->flag);
 
 	} else {
 		rsp->fcp_error = NVME_SC_SUCCESS;
@@ -930,7 +980,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	    (ctxp->state == LPFC_NVMET_STE_ABORT)) {
 		atomic_inc(&lpfc_nvmep->xmt_fcp_drop);
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6102 IO xri x%x aborted\n",
+				"6102 IO oxid x%x aborted\n",
 				ctxp->oxid);
 		rc = -ENXIO;
 		goto aerr;
@@ -1030,7 +1080,7 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 		ctxp->hdwq = &phba->sli4_hba.hdwq[0];
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6103 NVMET Abort op: oxri x%x flg x%x ste %d\n",
+			"6103 NVMET Abort op: oxid x%x flg x%x ste %d\n",
 			ctxp->oxid, ctxp->flag, ctxp->state);
 
 	lpfc_nvmeio_data(phba, "NVMET FCP ABRT: xri x%x flg x%x ste x%x\n",
@@ -1043,7 +1093,7 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 	/* Since iaab/iaar are NOT set, we need to check
 	 * if the firmware is in process of aborting IO
 	 */
-	if (ctxp->flag & LPFC_NVMET_XBUSY) {
+	if (ctxp->flag & (LPFC_NVMET_XBUSY | LPFC_NVMET_ABORT_OP)) {
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		return;
 	}
@@ -1106,6 +1156,7 @@ lpfc_nvmet_xmt_fcp_release(struct nvmet_fc_target_port *tgtport,
 			 ctxp->state, aborting);
 
 	atomic_inc(&lpfc_nvmep->xmt_fcp_release);
+	ctxp->flag &= ~LPFC_NVMET_TNOTIFY;
 
 	if (aborting)
 		return;
@@ -1130,7 +1181,7 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 
 	if (!nvmebuf) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
-				"6425 Defer rcv: no buffer xri x%x: "
+				"6425 Defer rcv: no buffer oxid x%x: "
 				"flg %x ste %x\n",
 				ctxp->oxid, ctxp->flag, ctxp->state);
 		return;
@@ -1510,6 +1561,7 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 	uint16_t rxid = bf_get(lpfc_wcqe_xa_remote_xid, axri);
 	struct lpfc_nvmet_rcv_ctx *ctxp, *next_ctxp;
 	struct lpfc_nvmet_tgtport *tgtp;
+	struct nvmefc_tgt_fcp_req *req = NULL;
 	struct lpfc_nodelist *ndlp;
 	unsigned long iflag = 0;
 	int rrq_empty = 0;
@@ -1540,7 +1592,7 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 		 */
 		if (ctxp->flag & LPFC_NVMET_CTX_RLS &&
 		    !(ctxp->flag & LPFC_NVMET_ABORT_OP)) {
-			list_del(&ctxp->list);
+			list_del_init(&ctxp->list);
 			released = true;
 		}
 		ctxp->flag &= ~LPFC_NVMET_XBUSY;
@@ -1560,7 +1612,7 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 		}
 
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-				"6318 XB aborted oxid %x flg x%x (%x)\n",
+				"6318 XB aborted oxid x%x flg x%x (%x)\n",
 				ctxp->oxid, ctxp->flag, released);
 		if (released)
 			lpfc_nvmet_ctxbuf_post(phba, ctxp->ctxbuf);
@@ -1571,6 +1623,32 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 	}
 	spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
+
+	ctxp = lpfc_nvmet_get_ctx_for_xri(phba, xri);
+	if (ctxp) {
+		/*
+		 *  Abort already done by FW, so BA_ACC sent.
+		 *  However, the transport may be unaware.
+		 */
+		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
+				"6323 NVMET Rcv ABTS xri x%x ctxp state x%x "
+				"flag x%x oxid x%x rxid x%x\n",
+				xri, ctxp->state, ctxp->flag, ctxp->oxid,
+				rxid);
+
+		spin_lock_irqsave(&ctxp->ctxlock, iflag);
+		ctxp->flag |= LPFC_NVMET_ABTS_RCV;
+		ctxp->state = LPFC_NVMET_STE_ABORT;
+		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
+
+		lpfc_nvmeio_data(phba,
+				 "NVMET ABTS RCV: xri x%x CPU %02x rjt %d\n",
+				 xri, smp_processor_id(), 0);
+
+		req = &ctxp->ctx.fcp_req;
+		if (req)
+			nvmet_fc_rcv_fcp_abort(phba->targetport, req);
+	}
 #endif
 }
 
@@ -1583,18 +1661,18 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 	struct lpfc_nvmet_rcv_ctx *ctxp, *next_ctxp;
 	struct nvmefc_tgt_fcp_req *rsp;
 	uint32_t sid;
-	uint16_t xri;
+	uint16_t oxid, xri;
 	unsigned long iflag = 0;
 
-	xri = be16_to_cpu(fc_hdr->fh_ox_id);
 	sid = sli4_sid_from_fc_hdr(fc_hdr);
+	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
 
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 	list_for_each_entry_safe(ctxp, next_ctxp,
 				 &phba->sli4_hba.lpfc_abts_nvmet_ctx_list,
 				 list) {
-		if (ctxp->oxid != xri || ctxp->sid != sid)
+		if (ctxp->oxid != oxid || ctxp->sid != sid)
 			continue;
 
 		xri = ctxp->ctxbuf->sglq->sli4_xritag;
@@ -1623,11 +1701,92 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 	spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
 
-	lpfc_nvmeio_data(phba, "NVMET ABTS RCV: xri x%x CPU %02x rjt %d\n",
-			 xri, raw_smp_processor_id(), 1);
+	/* check the wait list */
+	if (phba->sli4_hba.nvmet_io_wait_cnt) {
+		struct rqb_dmabuf *nvmebuf;
+		struct fc_frame_header *fc_hdr_tmp;
+		u32 sid_tmp;
+		u16 oxid_tmp;
+		bool found = false;
+
+		spin_lock_irqsave(&phba->sli4_hba.nvmet_io_wait_lock, iflag);
+
+		/* match by oxid and s_id */
+		list_for_each_entry(nvmebuf,
+				    &phba->sli4_hba.lpfc_nvmet_io_wait_list,
+				    hbuf.list) {
+			fc_hdr_tmp = (struct fc_frame_header *)
+					(nvmebuf->hbuf.virt);
+			oxid_tmp = be16_to_cpu(fc_hdr_tmp->fh_ox_id);
+			sid_tmp = sli4_sid_from_fc_hdr(fc_hdr_tmp);
+			if (oxid_tmp != oxid || sid_tmp != sid)
+				continue;
+
+			lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
+					"6321 NVMET Rcv ABTS oxid x%x from x%x "
+					"is waiting for a ctxp\n",
+					oxid, sid);
+
+			list_del_init(&nvmebuf->hbuf.list);
+			phba->sli4_hba.nvmet_io_wait_cnt--;
+			found = true;
+			break;
+		}
+		spin_unlock_irqrestore(&phba->sli4_hba.nvmet_io_wait_lock,
+				       iflag);
+
+		/* free buffer since already posted a new DMA buffer to RQ */
+		if (found) {
+			nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
+			/* Respond with BA_ACC accordingly */
+			lpfc_sli4_seq_abort_rsp(vport, fc_hdr, 1);
+			return 0;
+		}
+	}
+
+	/* check active list */
+	ctxp = lpfc_nvmet_get_ctx_for_oxid(phba, oxid, sid);
+	if (ctxp) {
+		xri = ctxp->ctxbuf->sglq->sli4_xritag;
+
+		spin_lock_irqsave(&ctxp->ctxlock, iflag);
+		ctxp->flag |= (LPFC_NVMET_ABTS_RCV | LPFC_NVMET_ABORT_OP);
+		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
+
+		lpfc_nvmeio_data(phba,
+				 "NVMET ABTS RCV: xri x%x CPU %02x rjt %d\n",
+				 xri, raw_smp_processor_id(), 0);
+
+		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
+				"6322 NVMET Rcv ABTS:acc oxid x%x xri x%x "
+				"flag x%x state x%x\n",
+				ctxp->oxid, xri, ctxp->flag, ctxp->state);
+
+		if (ctxp->flag & LPFC_NVMET_TNOTIFY) {
+			/* Notify the transport */
+			nvmet_fc_rcv_fcp_abort(phba->targetport,
+					       &ctxp->ctx.fcp_req);
+		} else {
+			spin_lock_irqsave(&ctxp->ctxlock, iflag);
+			lpfc_nvmet_defer_release(phba, ctxp);
+			spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
+		}
+		if (ctxp->state == LPFC_NVMET_STE_RCV)
+			lpfc_nvmet_unsol_fcp_issue_abort(phba, ctxp, ctxp->sid,
+							 ctxp->oxid);
+		else
+			lpfc_nvmet_sol_fcp_issue_abort(phba, ctxp, ctxp->sid,
+						       ctxp->oxid);
+
+		lpfc_sli4_seq_abort_rsp(vport, fc_hdr, 0);
+		return 0;
+	}
+
+	lpfc_nvmeio_data(phba, "NVMET ABTS RCV: oxid x%x CPU %02x rjt %d\n",
+			 oxid, raw_smp_processor_id(), 1);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6320 NVMET Rcv ABTS:rjt xid x%x\n", xri);
+			"6320 NVMET Rcv ABTS:rjt oxid x%x\n", oxid);
 
 	/* Respond with BA_RJT accordingly */
 	lpfc_sli4_seq_abort_rsp(vport, fc_hdr, 0);
@@ -1711,6 +1870,18 @@ lpfc_nvmet_wqfull_process(struct lpfc_hba *phba,
 			spin_unlock_irqrestore(&pring->ring_lock, iflags);
 			return;
 		}
+		if (rc == WQE_SUCCESS) {
+#ifdef CONFIG_SCSI_LPFC_DEBUG_FS
+			if (ctxp->ts_cmd_nvme) {
+				if (ctxp->ctx.fcp_req.op == NVMET_FCOP_RSP)
+					ctxp->ts_status_wqput = ktime_get_ns();
+				else
+					ctxp->ts_data_wqput = ktime_get_ns();
+			}
+#endif
+		} else {
+			WARN_ON(rc);
+		}
 	}
 	wq->q_flag &= ~HBA_NVMET_WQFULL;
 	spin_unlock_irqrestore(&pring->ring_lock, iflags);
@@ -1876,8 +2047,16 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 		return;
 	}
 
+	if (ctxp->flag & LPFC_NVMET_ABTS_RCV) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+				"6324 IO oxid x%x aborted\n",
+				ctxp->oxid);
+		return;
+	}
+
 	payload = (uint32_t *)(nvmebuf->dbuf.virt);
 	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
+	ctxp->flag |= LPFC_NVMET_TNOTIFY;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (ctxp->ts_isr_cmd)
 		ctxp->ts_cmd_nvme = ktime_get_ns();
@@ -1931,6 +2110,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 			phba->sli4_hba.nvmet_mrq_data[qno], 1, qno);
 		return;
 	}
+	ctxp->flag &= ~LPFC_NVMET_TNOTIFY;
 	atomic_inc(&tgtp->rcv_fcp_cmd_drop);
 	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 			"2582 FCP Drop IO x%x: err x%x: x%x x%x x%x\n",
@@ -2122,6 +2302,9 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 	sid = sli4_sid_from_fc_hdr(fc_hdr);
 
 	ctxp = (struct lpfc_nvmet_rcv_ctx *)ctx_buf->context;
+	spin_lock_irqsave(&phba->sli4_hba.t_active_list_lock, iflag);
+	list_add_tail(&ctxp->list, &phba->sli4_hba.t_active_ctx_list);
+	spin_unlock_irqrestore(&phba->sli4_hba.t_active_list_lock, iflag);
 	if (ctxp->state != LPFC_NVMET_STE_FREE) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6414 NVMET Context corrupt %d %d oxid x%x\n",
@@ -2773,7 +2956,7 @@ lpfc_nvmet_sol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	if ((ctxp->flag & LPFC_NVMET_CTX_RLS) &&
 	    !(ctxp->flag & LPFC_NVMET_XBUSY)) {
 		spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
-		list_del(&ctxp->list);
+		list_del_init(&ctxp->list);
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		released = true;
 	}
@@ -2782,7 +2965,7 @@ lpfc_nvmet_sol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	atomic_inc(&tgtp->xmt_abort_rsp);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6165 ABORT cmpl: xri x%x flg x%x (%d) "
+			"6165 ABORT cmpl: oxid x%x flg x%x (%d) "
 			"WCQE: %08x %08x %08x %08x\n",
 			ctxp->oxid, ctxp->flag, released,
 			wcqe->word0, wcqe->total_data_placed,
@@ -2857,7 +3040,7 @@ lpfc_nvmet_unsol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	if ((ctxp->flag & LPFC_NVMET_CTX_RLS) &&
 	    !(ctxp->flag & LPFC_NVMET_XBUSY)) {
 		spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
-		list_del(&ctxp->list);
+		list_del_init(&ctxp->list);
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		released = true;
 	}
@@ -2866,7 +3049,7 @@ lpfc_nvmet_unsol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	atomic_inc(&tgtp->xmt_abort_rsp);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6316 ABTS cmpl xri x%x flg x%x (%x) "
+			"6316 ABTS cmpl oxid x%x flg x%x (%x) "
 			"WCQE: %08x %08x %08x %08x\n",
 			ctxp->oxid, ctxp->flag, released,
 			wcqe->word0, wcqe->total_data_placed,
@@ -3237,7 +3420,7 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 	spin_lock_irqsave(&ctxp->ctxlock, flags);
 	if (ctxp->flag & LPFC_NVMET_CTX_RLS) {
 		spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
-		list_del(&ctxp->list);
+		list_del_init(&ctxp->list);
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		released = true;
 	}
@@ -3246,8 +3429,9 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 
 	atomic_inc(&tgtp->xmt_abort_rsp_error);
 	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
-			"6135 Failed to Issue ABTS for oxid x%x. Status x%x\n",
-			ctxp->oxid, rc);
+			"6135 Failed to Issue ABTS for oxid x%x. Status x%x "
+			"(%x)\n",
+			ctxp->oxid, rc, released);
 	if (released)
 		lpfc_nvmet_ctxbuf_post(phba, ctxp->ctxbuf);
 	return 1;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
index 2f3f603d94c4..8ff67deac10a 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.h
+++ b/drivers/scsi/lpfc/lpfc_nvmet.h
@@ -140,6 +140,7 @@ struct lpfc_nvmet_rcv_ctx {
 #define LPFC_NVMET_ABTS_RCV		0x10  /* ABTS received on exchange */
 #define LPFC_NVMET_CTX_REUSE_WQ		0x20  /* ctx reused via WQ */
 #define LPFC_NVMET_DEFER_WQFULL		0x40  /* Waiting on a free WQE */
+#define LPFC_NVMET_TNOTIFY		0x80  /* notify transport of abts */
 	struct rqb_dmabuf *rqb_buffer;
 	struct lpfc_nvmet_ctxbuf *ctxbuf;
 	struct lpfc_sli4_hdw_queue *hdwq;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index fbc1f1880d53..12ffe5736921 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -845,6 +845,8 @@ struct lpfc_sli4_hba {
 	struct list_head lpfc_nvmet_sgl_list;
 	spinlock_t abts_nvmet_buf_list_lock; /* list of aborted NVMET IOs */
 	struct list_head lpfc_abts_nvmet_ctx_list;
+	spinlock_t t_active_list_lock; /* list of active NVMET IOs */
+	struct list_head t_active_ctx_list;
 	struct list_head lpfc_nvmet_io_wait_list;
 	struct lpfc_nvmet_ctx_info *nvmet_ctx_info;
 	struct lpfc_sglq **lpfc_sglq_active_list;
-- 
2.13.7

