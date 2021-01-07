Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002442EE97E
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Jan 2021 00:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbhAGXAx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 18:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbhAGXAu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Jan 2021 18:00:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C0C0612B1
        for <linux-scsi@vger.kernel.org>; Thu,  7 Jan 2021 14:59:38 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j13so5050959pjz.3
        for <linux-scsi@vger.kernel.org>; Thu, 07 Jan 2021 14:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXPLYgPVO4xVGTjQ1rBsd90YPcMTk5mz6yACsgBfuz4=;
        b=tXIPNPB5xLAcF6cIA5QaiSrOW+sAHkK0pMlA3fX06wGLjuIPAXtbSIEyyy4Z48jH+K
         C+n7AVYUunBVwV21B1lBK7h5ebXbTt1xkUJ4Xwiu6axsYjgzSQthExrTQrrYyvYTAE0x
         31tbNe1JpkMOsGfee2HJQ2XlPFuNU0ssWZis8DGzmbPnEt8twqu+JFxQRPe+ClnP8Yj3
         AkijsQiOkiVer2dlpUcUiF0nhlmQwOfMuNCE/BQXQxjfDHziP3kYwvwDt24NF/L/fgmr
         9HXkKSscc+bAkguPr+YXwefa2/AUb3euXk94yUJ7jwAS1wQOO79WRlF7dDqrUcVLIU/5
         TtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXPLYgPVO4xVGTjQ1rBsd90YPcMTk5mz6yACsgBfuz4=;
        b=c28dzzD1Y0nS6OqrGeK0upehnWR4oZQcCRyxfEt3IFrA0vFxTKF8vPyIguowPFoy40
         s+/uGDDfIzLS/Dkj2XPw48TYU1ppeZ7XSOWMdW1mtdOZUWxjsPBaW0c6UVfnX5aqD7K0
         UNQRCBysChzAel/LI1sbhIUETCf5undKJf1dTqdmpG/OXhlcqu9hTStRQJycS55QkSYp
         9nr0WsIBwlBBYXlOZHya44mRXgXGissXBvduBhlAQiE+1VRH7hk9p+IFWU4bIcmSbSU6
         OETkw3Tabx4Ieav78djiIz6BV3tZo5fbNPBGxWv5lXCBN+r3xElGOAGK/F3/+1pgX1cO
         HPqQ==
X-Gm-Message-State: AOAM532SngqaOcm0yNNEYsRWRLgjVm0snLVSXcwlkwwmtblloyaU/T5+
        E8TMDU1v+HbAYrxKAwE3md+s4y83oiMHPw==
X-Google-Smtp-Source: ABdhPJx2MEUeqstQXBuI2+3QMPuRWICnLgBu9KjLt84ISxeeq5Xs2MvS0Mzp+nayg8rC0it0ymOaXw==
X-Received: by 2002:a17:902:8203:b029:dc:3ef7:9321 with SMTP id x3-20020a1709028203b02900dc3ef79321mr973044pln.39.1610060377551;
        Thu, 07 Jan 2021 14:59:37 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l197sm6881405pfd.97.2021.01.07.14.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 14:59:36 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 26/31] elx: efct: Hardware IO submission routines
Date:   Thu,  7 Jan 2021 14:59:00 -0800
Message-Id: <20210107225905.18186-27-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210107225905.18186-1-jsmart2021@gmail.com>
References: <20210107225905.18186-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the efct driver population.

This patch adds driver definitions for:
Routines that write IO to Work queue, send SRRs and raw frames.

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/elx/efct/efct_hw.c | 515 ++++++++++++++++++++++++++++++++
 drivers/scsi/elx/efct/efct_hw.h |  14 +
 2 files changed, 529 insertions(+)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index 95522f0226d9..87d18dd50970 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -2518,3 +2518,518 @@ efct_hw_flush(struct efct_hw *hw)
 
 	return EFC_SUCCESS;
 }
+
+int
+efct_hw_wq_write(struct hw_wq *wq, struct efct_hw_wqe *wqe)
+{
+	int rc = EFC_SUCCESS;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&wq->queue->lock, flags);
+	if (list_empty(&wq->pending_list)) {
+		if (wq->free_count > 0) {
+			rc = _efct_hw_wq_write(wq, wqe);
+		} else {
+			INIT_LIST_HEAD(&wqe->list_entry);
+			list_add_tail(&wqe->list_entry, &wq->pending_list);
+			wq->wq_pending_count++;
+		}
+
+		spin_unlock_irqrestore(&wq->queue->lock, flags);
+		return rc;
+	}
+
+	INIT_LIST_HEAD(&wqe->list_entry);
+	list_add_tail(&wqe->list_entry, &wq->pending_list);
+	wq->wq_pending_count++;
+	while (wq->free_count > 0) {
+		wqe = list_first_entry(&wq->pending_list, struct efct_hw_wqe,
+				      list_entry);
+		if (!wqe)
+			break;
+
+		list_del_init(&wqe->list_entry);
+		rc = _efct_hw_wq_write(wq, wqe);
+		if (rc)
+			break;
+
+		if (wqe->abort_wqe_submit_needed) {
+			wqe->abort_wqe_submit_needed = false;
+			efct_hw_fill_abort_wqe(wq->hw, wqe);
+
+			INIT_LIST_HEAD(&wqe->list_entry);
+			list_add_tail(&wqe->list_entry, &wq->pending_list);
+			wq->wq_pending_count++;
+		}
+	}
+
+	spin_unlock_irqrestore(&wq->queue->lock, flags);
+
+	return rc;
+}
+
+int
+efct_efc_bls_send(struct efc *efc, u32 type, struct sli_bls_params *bls)
+{
+	struct efct *efct = efc->base;
+
+	return efct_hw_bls_send(efct, type, bls, NULL, NULL);
+}
+
+int
+efct_hw_bls_send(struct efct *efct, u32 type, struct sli_bls_params *bls_params,
+		 void *cb, void *arg)
+{
+	struct efct_hw *hw = &efct->hw;
+	struct efct_hw_io *hio;
+	struct sli_bls_payload bls;
+	int rc;
+
+	if (hw->state != EFCT_HW_STATE_ACTIVE) {
+		efc_log_err(hw->os,
+			      "cannot send BLS, HW state=%d\n", hw->state);
+		return EFC_FAIL;
+	}
+
+	hio = efct_hw_io_alloc(hw);
+	if (!hio) {
+		efc_log_err(hw->os, "HIO allocation failed\n");
+		return EFC_FAIL;
+	}
+
+	hio->done = cb;
+	hio->arg  = arg;
+
+	bls_params->xri = hio->indicator;
+	bls_params->tag = hio->reqtag;
+
+	if (type == FC_RCTL_BA_ACC) {
+		hio->type = EFCT_HW_BLS_ACC;
+		bls.type = SLI4_SLI_BLS_ACC;
+		memcpy(&bls.u.acc, bls_params->payload, sizeof(bls.u.acc));
+	} else {
+		hio->type = EFCT_HW_BLS_RJT;
+		bls.type = SLI4_SLI_BLS_RJT;
+		memcpy(&bls.u.rjt, bls_params->payload, sizeof(bls.u.rjt));
+	}
+
+	bls.ox_id = cpu_to_le16(bls_params->ox_id);
+	bls.rx_id = cpu_to_le16(bls_params->rx_id);
+
+	if (sli_xmit_bls_rsp64_wqe(&hw->sli, hio->wqe.wqebuf,
+				   &bls, bls_params)) {
+		efc_log_err(hw->os, "XMIT_BLS_RSP64 WQE error\n");
+		return EFC_FAIL;
+	}
+
+	hio->xbusy = true;
+
+	/*
+	 * Add IO to active io wqe list before submitting, in case the
+	 * wcqe processing preempts this thread.
+	 */
+	hio->wq->use_count++;
+	rc = efct_hw_wq_write(hio->wq, &hio->wqe);
+	if (rc >= 0) {
+		/* non-negative return is success */
+		rc = EFC_SUCCESS;
+	} else {
+		/* failed to write wqe, remove from active wqe list */
+		efc_log_err(hw->os,
+			     "sli_queue_write failed: %d\n", rc);
+		hio->xbusy = false;
+	}
+
+	return rc;
+}
+
+static int
+efct_els_ssrs_send_cb(struct efct_hw_io *hio, u32 length, int status,
+		      u32 ext_status, void *arg)
+{
+	struct efc_disc_io *io = arg;
+
+	efc_disc_io_complete(io, length, status, ext_status);
+	return EFC_SUCCESS;
+}
+
+static inline void
+efct_fill_els_params(struct efc_disc_io *io, struct sli_els_params *params)
+{
+	u8 *cmd = io->req.virt;
+
+	params->cmd = *cmd;
+	params->s_id = io->s_id;
+	params->d_id = io->d_id;
+	params->ox_id = io->iparam.els.ox_id;
+	params->rpi = io->rpi;
+	params->vpi = io->vpi;
+	params->rpi_registered = io->rpi_registered;
+	params->xmit_len = io->xmit_len;
+	params->rsp_len = io->rsp_len;
+	params->timeout = io->iparam.els.timeout;
+}
+
+static inline void
+efct_fill_ct_params(struct efc_disc_io *io, struct sli_ct_params *params)
+{
+	params->r_ctl = io->iparam.ct.r_ctl;
+	params->type = io->iparam.ct.type;
+	params->df_ctl =  io->iparam.ct.df_ctl;
+	params->d_id = io->d_id;
+	params->ox_id = io->iparam.ct.ox_id;
+	params->rpi = io->rpi;
+	params->vpi = io->vpi;
+	params->rpi_registered = io->rpi_registered;
+	params->xmit_len = io->xmit_len;
+	params->rsp_len = io->rsp_len;
+	params->timeout = io->iparam.ct.timeout;
+}
+
+/**
+ * efct_els_hw_srrs_send() - Send a single request and response cmd.
+ * @efc: efc library structure
+ * @io: Discovery IO used to hold els and ct cmd context.
+ *
+ * This routine supports communication sequences consisting of a single
+ * request and single response between two endpoints. Examples include:
+ *  - Sending an ELS request.
+ *  - Sending an ELS response - To send an ELS response, the caller must provide
+ * the OX_ID from the received request.
+ *  - Sending a FC Common Transport (FC-CT) request - To send a FC-CT request,
+ * the caller must provide the R_CTL, TYPE, and DF_CTL
+ * values to place in the FC frame header.
+ *
+ * Return: Status of the request.
+ */
+int
+efct_els_hw_srrs_send(struct efc *efc, struct efc_disc_io *io)
+{
+	struct efct *efct = efc->base;
+	struct efct_hw_io *hio;
+	struct efct_hw *hw = &efct->hw;
+	struct efc_dma *send = &io->req;
+	struct efc_dma *receive = &io->rsp;
+	struct sli4_sge	*sge = NULL;
+	enum efct_hw_rtn rc = EFCT_HW_RTN_SUCCESS;
+	u32 len = io->xmit_len;
+	u32 sge0_flags;
+	u32 sge1_flags;
+
+	hio = efct_hw_io_alloc(hw);
+	if (!hio) {
+		pr_err("HIO alloc failed\n");
+		return EFCT_HW_RTN_ERROR;
+	}
+
+	if (hw->state != EFCT_HW_STATE_ACTIVE) {
+		efc_log_debug(hw->os,
+			      "cannot send SRRS, HW state=%d\n", hw->state);
+		return EFCT_HW_RTN_ERROR;
+	}
+
+	hio->done = efct_els_ssrs_send_cb;
+	hio->arg  = io;
+
+	sge = hio->sgl->virt;
+
+	/* clear both SGE */
+	memset(hio->sgl->virt, 0, 2 * sizeof(struct sli4_sge));
+
+	sge0_flags = le32_to_cpu(sge[0].dw2_flags);
+	sge1_flags = le32_to_cpu(sge[1].dw2_flags);
+	if (send->size) {
+		sge[0].buffer_address_high =
+			cpu_to_le32(upper_32_bits(send->phys));
+		sge[0].buffer_address_low  =
+			cpu_to_le32(lower_32_bits(send->phys));
+
+		sge0_flags |= (SLI4_SGE_TYPE_DATA << SLI4_SGE_TYPE_SHIFT);
+
+		sge[0].buffer_length = cpu_to_le32(len);
+	}
+
+	if (io->io_type == EFC_DISC_IO_ELS_REQ ||
+		io->io_type == EFC_DISC_IO_CT_REQ) {
+		sge[1].buffer_address_high =
+			cpu_to_le32(upper_32_bits(receive->phys));
+		sge[1].buffer_address_low  =
+			cpu_to_le32(lower_32_bits(receive->phys));
+
+		sge1_flags |= (SLI4_SGE_TYPE_DATA << SLI4_SGE_TYPE_SHIFT);
+		sge1_flags |= SLI4_SGE_LAST;
+
+		sge[1].buffer_length = cpu_to_le32(receive->size);
+	} else {
+		sge0_flags |= SLI4_SGE_LAST;
+	}
+
+	sge[0].dw2_flags = cpu_to_le32(sge0_flags);
+	sge[1].dw2_flags = cpu_to_le32(sge1_flags);
+
+	switch (io->io_type) {
+	case EFC_DISC_IO_ELS_REQ: {
+		struct sli_els_params els_params;
+
+		hio->type = EFCT_HW_ELS_REQ;
+		efct_fill_els_params(io, &els_params);
+		els_params.xri = hio->indicator;
+		els_params.tag = hio->reqtag;
+
+		if (sli_els_request64_wqe(&hw->sli, hio->wqe.wqebuf, hio->sgl,
+					  &els_params)) {
+			efc_log_err(hw->os, "REQ WQE error\n");
+			rc = EFCT_HW_RTN_ERROR;
+		}
+		break;
+	}
+	case EFC_DISC_IO_ELS_RESP: {
+		struct sli_els_params els_params;
+
+		hio->type = EFCT_HW_ELS_RSP;
+		efct_fill_els_params(io, &els_params);
+		els_params.xri = hio->indicator;
+		els_params.tag = hio->reqtag;
+		if (sli_xmit_els_rsp64_wqe(&hw->sli, hio->wqe.wqebuf, send,
+					   &els_params)){
+			efc_log_err(hw->os, "RSP WQE error\n");
+			rc = EFCT_HW_RTN_ERROR;
+		}
+		break;
+	}
+	case EFC_DISC_IO_CT_REQ: {
+		struct sli_ct_params ct_params;
+
+		hio->type = EFCT_HW_FC_CT;
+		efct_fill_ct_params(io, &ct_params);
+		ct_params.xri = hio->indicator;
+		ct_params.tag = hio->reqtag;
+		if (sli_gen_request64_wqe(&hw->sli, hio->wqe.wqebuf, hio->sgl,
+					  &ct_params)){
+			efc_log_err(hw->os, "GEN WQE error\n");
+			rc = EFCT_HW_RTN_ERROR;
+		}
+		break;
+	}
+	case EFC_DISC_IO_CT_RESP: {
+		struct sli_ct_params ct_params;
+
+		hio->type = EFCT_HW_FC_CT_RSP;
+		efct_fill_ct_params(io, &ct_params);
+		ct_params.xri = hio->indicator;
+		ct_params.tag = hio->reqtag;
+		if (sli_xmit_sequence64_wqe(&hw->sli, hio->wqe.wqebuf, hio->sgl,
+					    &ct_params)){
+			efc_log_err(hw->os, "XMIT SEQ WQE error\n");
+			rc = EFCT_HW_RTN_ERROR;
+		}
+		break;
+	}
+	default:
+		efc_log_err(hw->os, "bad SRRS type %#x\n", io->io_type);
+		rc = EFCT_HW_RTN_ERROR;
+	}
+
+	if (rc == EFCT_HW_RTN_SUCCESS) {
+
+		hio->xbusy = true;
+
+		/*
+		 * Add IO to active io wqe list before submitting, in case the
+		 * wcqe processing preempts this thread.
+		 */
+		hio->wq->use_count++;
+		rc = efct_hw_wq_write(hio->wq, &hio->wqe);
+		if (rc >= 0) {
+			/* non-negative return is success */
+			rc = 0;
+		} else {
+			/* failed to write wqe, remove from active wqe list */
+			efc_log_err(hw->os,
+				     "sli_queue_write failed: %d\n", rc);
+			hio->xbusy = false;
+		}
+	}
+
+	return rc;
+}
+
+enum efct_hw_rtn
+efct_hw_io_send(struct efct_hw *hw, enum efct_hw_io_type type,
+		struct efct_hw_io *io, union efct_hw_io_param_u *iparam,
+		void *cb, void *arg)
+{
+	enum efct_hw_rtn rc = EFCT_HW_RTN_SUCCESS;
+	bool send_wqe = true;
+
+	if (!io) {
+		pr_err("bad parm hw=%p io=%p\n", hw, io);
+		return EFCT_HW_RTN_ERROR;
+	}
+
+	if (hw->state != EFCT_HW_STATE_ACTIVE) {
+		efc_log_err(hw->os, "cannot send IO, HW state=%d\n", hw->state);
+		return EFCT_HW_RTN_ERROR;
+	}
+
+
+	/*
+	 * Save state needed during later stages
+	 */
+	io->type  = type;
+	io->done  = cb;
+	io->arg   = arg;
+
+	/*
+	 * Format the work queue entry used to send the IO
+	 */
+	switch (type) {
+	case EFCT_HW_IO_TARGET_WRITE: {
+		u16 flags = iparam->fcp_tgt.flags;
+		struct fcp_txrdy *xfer = io->xfer_rdy.virt;
+
+		/*
+		 * Fill in the XFER_RDY for IF_TYPE 0 devices
+		 */
+		xfer->ft_data_ro = cpu_to_be32(iparam->fcp_tgt.offset);
+		xfer->ft_burst_len = cpu_to_be32(iparam->fcp_tgt.xmit_len);
+
+		if (io->xbusy)
+			flags |= SLI4_IO_CONTINUATION;
+		else
+			flags &= ~SLI4_IO_CONTINUATION;
+		iparam->fcp_tgt.xri = io->indicator;
+		iparam->fcp_tgt.tag = io->reqtag;
+
+		if (sli_fcp_treceive64_wqe(&hw->sli, io->wqe.wqebuf,
+					   &io->def_sgl, io->first_data_sge,
+					   SLI4_CQ_DEFAULT,
+					   0, 0, &iparam->fcp_tgt)) {
+			efc_log_err(hw->os, "TRECEIVE WQE error\n");
+			rc = EFCT_HW_RTN_ERROR;
+		}
+		break;
+	}
+	case EFCT_HW_IO_TARGET_READ: {
+		u16 flags = iparam->fcp_tgt.flags;
+
+		if (io->xbusy)
+			flags |= SLI4_IO_CONTINUATION;
+		else
+			flags &= ~SLI4_IO_CONTINUATION;
+
+		iparam->fcp_tgt.xri = io->indicator;
+		iparam->fcp_tgt.tag = io->reqtag;
+
+		if (sli_fcp_tsend64_wqe(&hw->sli, io->wqe.wqebuf,
+					&io->def_sgl, io->first_data_sge,
+					SLI4_CQ_DEFAULT,
+					0, 0, &iparam->fcp_tgt)) {
+			efc_log_err(hw->os, "TSEND WQE error\n");
+			rc = EFCT_HW_RTN_ERROR;
+		}
+		break;
+	}
+	case EFCT_HW_IO_TARGET_RSP: {
+		u16 flags = iparam->fcp_tgt.flags;
+
+		if (io->xbusy)
+			flags |= SLI4_IO_CONTINUATION;
+		else
+			flags &= ~SLI4_IO_CONTINUATION;
+
+		iparam->fcp_tgt.xri = io->indicator;
+		iparam->fcp_tgt.tag = io->reqtag;
+
+		if (sli_fcp_trsp64_wqe(&hw->sli, io->wqe.wqebuf,
+				       &io->def_sgl, SLI4_CQ_DEFAULT,
+				       0, &iparam->fcp_tgt)) {
+			efc_log_err(hw->os, "TRSP WQE error\n");
+			rc = EFCT_HW_RTN_ERROR;
+		}
+
+		break;
+	}
+	default:
+		efc_log_err(hw->os, "unsupported IO type %#x\n", type);
+		rc = EFCT_HW_RTN_ERROR;
+	}
+
+	if (send_wqe && rc == EFCT_HW_RTN_SUCCESS) {
+
+		io->xbusy = true;
+
+		/*
+		 * Add IO to active io wqe list before submitting, in case the
+		 * wcqe processing preempts this thread.
+		 */
+		hw->tcmd_wq_submit[io->wq->instance]++;
+		io->wq->use_count++;
+		rc = efct_hw_wq_write(io->wq, &io->wqe);
+		if (rc >= 0) {
+			/* non-negative return is success */
+			rc = 0;
+		} else {
+			/* failed to write wqe, remove from active wqe list */
+			efc_log_err(hw->os,
+				     "sli_queue_write failed: %d\n", rc);
+			io->xbusy = false;
+		}
+	}
+
+	return rc;
+}
+
+enum efct_hw_rtn
+efct_hw_send_frame(struct efct_hw *hw, struct fc_frame_header *hdr,
+		   u8 sof, u8 eof, struct efc_dma *payload,
+		   struct efct_hw_send_frame_context *ctx,
+		   void (*callback)(void *arg, u8 *cqe, int status),
+		   void *arg)
+{
+	enum efct_hw_rtn rc;
+	struct efct_hw_wqe *wqe;
+	u32 xri;
+	struct hw_wq *wq;
+
+	wqe = &ctx->wqe;
+
+	/* populate the callback object */
+	ctx->hw = hw;
+
+	/* Fetch and populate request tag */
+	ctx->wqcb = efct_hw_reqtag_alloc(hw, callback, arg);
+	if (!ctx->wqcb) {
+		efc_log_err(hw->os, "can't allocate request tag\n");
+		return EFCT_HW_RTN_NO_RESOURCES;
+	}
+
+	wq = hw->hw_wq[0];
+
+	/* Set XRI and RX_ID in the header based on which WQ, and which
+	 * send_frame_io we are using
+	 */
+	xri = wq->send_frame_io->indicator;
+
+	/* Build the send frame WQE */
+	rc = sli_send_frame_wqe(&hw->sli, wqe->wqebuf,
+				sof, eof, (u32 *)hdr, payload, payload->len,
+				EFCT_HW_SEND_FRAME_TIMEOUT, xri,
+				ctx->wqcb->instance_index);
+	if (rc) {
+		efc_log_err(hw->os, "sli_send_frame_wqe failed: %d\n",
+			     rc);
+		return EFCT_HW_RTN_ERROR;
+	}
+
+	/* Write to WQ */
+	rc = efct_hw_wq_write(wq, wqe);
+	if (rc) {
+		efc_log_err(hw->os, "efct_hw_wq_write failed: %d\n", rc);
+		return EFCT_HW_RTN_ERROR;
+	}
+
+	wq->use_count++;
+
+	return EFCT_HW_RTN_SUCCESS;
+}
diff --git a/drivers/scsi/elx/efct/efct_hw.h b/drivers/scsi/elx/efct/efct_hw.h
index bcc8e0443460..a030fc5ac719 100644
--- a/drivers/scsi/elx/efct/efct_hw.h
+++ b/drivers/scsi/elx/efct/efct_hw.h
@@ -706,5 +706,19 @@ int
 efct_hw_process(struct efct_hw *hw, u32 vector, u32 max_isr_time_msec);
 int
 efct_hw_queue_hash_find(struct efct_queue_hash *hash, u16 id);
+int efct_hw_wq_write(struct hw_wq *wq, struct efct_hw_wqe *wqe);
+enum efct_hw_rtn
+efct_hw_send_frame(struct efct_hw *hw, struct fc_frame_header *hdr,
+		   u8 sof, u8 eof, struct efc_dma *payload,
+		struct efct_hw_send_frame_context *ctx,
+		void (*callback)(void *arg, u8 *cqe, int status),
+		void *arg);
+int
+efct_els_hw_srrs_send(struct efc *efc, struct efc_disc_io *io);
+int
+efct_efc_bls_send(struct efc *efc, u32 type, struct sli_bls_params *bls);
+int
+efct_hw_bls_send(struct efct *efct, u32 type, struct sli_bls_params *bls_params,
+		 void *cb, void *arg);
 
 #endif /* __EFCT_H__ */
-- 
2.26.2

