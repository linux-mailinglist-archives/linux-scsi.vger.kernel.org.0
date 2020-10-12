Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87E228C4EB
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Oct 2020 00:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbgJLWwI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Oct 2020 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390499AbgJLWwE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Oct 2020 18:52:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671AC0613D1
        for <linux-scsi@vger.kernel.org>; Mon, 12 Oct 2020 15:52:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so15109906pfb.4
        for <linux-scsi@vger.kernel.org>; Mon, 12 Oct 2020 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ggb6JiJA9w+2jt/TucZoq9lV8my+GkG+LnYOENOZS5I=;
        b=TxSeGWenfTQd4DmgXsUrTRJQ50sXYsEvYnzMm6hbp4rNAAg16/HSFmQmcjuuz6uZOH
         KnmY0ppnb19IeOK3t1BGWe3LEynliR+YJahxTG1AiSNRNT72XNPvMvsdMzy8EFHu703B
         PrGSBHnKJBS1dzPOegYy6BgEjKUjkXiK/WZ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ggb6JiJA9w+2jt/TucZoq9lV8my+GkG+LnYOENOZS5I=;
        b=Ek8WO6Ls+ImYiqeIYoZDXGai2qf4S2cDEW+GFirOno2CosYW2jGeLf4Nh7QVRowEn3
         aE2f1HNdmSOUVoGk/1cTtwosXGS/GFnMnBIbC3N2/IJ1l5bfAXkhn98gQlvKTTa0jGqB
         GZ+1MXi79clqbWe/J8/aDIY+K1qXBoepzibDjpimU9iaPfS+8W7lqqCqLPfI/Sv8Pv2X
         IJ1z2HHpJ2/5rjWh+oAcydh8dnoqwxyi6JSogW5IlTwf0XCtNkYobehKUeufqagdILPJ
         4NqfHPDCQCa/Nmw3lKUq0Ch+V2n5gTPPEUFwSLt3ZmOeY7jYN0BEQX2+NA99YM3O8GQ7
         pLKw==
X-Gm-Message-State: AOAM531XEDJUiD4edbTH/sZZalMzTG7+gmzkAad1LHXPBVlIY9tE4Ntj
        nRilKt3sQSEMwk3ydps69Ha5/owjH+DK9aNqs2APwWJLBjfp7CHmHRHyz+gHLB2DJQBdn5dkGBA
        ZQVIS11h4hMmlNrbBl5JxToTvH6Sz+MBR65EhIPH9YdJKBSagOcjlGOpS1utC2YP8SCWXm1XHm3
        jyWms=
X-Google-Smtp-Source: ABdhPJzcBA0pjk+6471fCh1JfdeYTTTCby0NtlqTGLlrW8NGDl+Do/weV27gRVY0SVzmfLMN9QaClw==
X-Received: by 2002:a17:90a:6582:: with SMTP id k2mr22343450pjj.139.1602543122735;
        Mon, 12 Oct 2020 15:52:02 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x5sm21222287pfr.83.2020.10.12.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:52:01 -0700 (PDT)
From:   James Smart <james.smart@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [PATCH v4 05/31] elx: libefc_sli: Populate and post different WQEs
Date:   Mon, 12 Oct 2020 15:51:21 -0700
Message-Id: <20201012225147.54404-6-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012225147.54404-1-james.smart@broadcom.com>
References: <20201012225147.54404-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009f1f5205b181255f"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000009f1f5205b181255f
Content-Transfer-Encoding: 8bit

This patch continues the libefc_sli SLI-4 library population.

This patch adds service routines to create different WQEs and adds
APIs to issue iread, iwrite, treceive, tsend and other work queue
entries.

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>

---
v4:
  Reduce function parameters for WQE filling functions
---
 drivers/scsi/elx/libefc_sli/sli4.c | 1499 ++++++++++++++++++++++++++++
 1 file changed, 1499 insertions(+)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 3678cf69e1dd..a9126f3a2343 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -1382,3 +1382,1502 @@ sli_cq_parse(struct sli4 *sli4, struct sli4_queue *cq, u8 *cqe,
 
 	return rc;
 }
+
+int
+sli_abort_wqe(struct sli4 *sli, void *buf, enum sli4_abort_type type,
+	      bool send_abts, u32 ids, u32 mask, u16 tag, u16 cq_id)
+{
+	struct sli4_abort_wqe *abort = buf;
+
+	memset(buf, 0, sli->wqe_size);
+
+	switch (type) {
+	case SLI4_ABORT_XRI:
+		abort->criteria = SLI4_ABORT_CRITERIA_XRI_TAG;
+		if (mask) {
+			efc_log_warn(sli, "%#x aborting XRI %#x warning non-zero mask",
+				mask, ids);
+			mask = 0;
+		}
+		break;
+	case SLI4_ABORT_ABORT_ID:
+		abort->criteria = SLI4_ABORT_CRITERIA_ABORT_TAG;
+		break;
+	case SLI4_ABORT_REQUEST_ID:
+		abort->criteria = SLI4_ABORT_CRITERIA_REQUEST_TAG;
+		break;
+	default:
+		efc_log_info(sli, "unsupported type %#x\n", type);
+		return EFC_FAIL;
+	}
+
+	abort->ia_ir_byte |= send_abts ? 0 : 1;
+
+	/* Suppress ABTS retries */
+	abort->ia_ir_byte |= SLI4_ABRT_WQE_IR;
+
+	abort->t_mask = cpu_to_le32(mask);
+	abort->t_tag  = cpu_to_le32(ids);
+	abort->command = SLI4_WQE_ABORT;
+	abort->request_tag = cpu_to_le16(tag);
+
+	abort->dw10w0_flags = cpu_to_le16(SLI4_ABRT_WQE_QOSD);
+
+	abort->cq_id = cpu_to_le16(cq_id);
+	abort->cmdtype_wqec_byte |= SLI4_CMD_ABORT_WQE;
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_els_request64_wqe(struct sli4 *sli, void *buf, struct efc_dma *sgl,
+		      struct sli_els_params *params)
+{
+	struct sli4_els_request64_wqe *els = buf;
+	struct sli4_sge *sge = sgl->virt;
+	bool is_fabric = false;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, sli->wqe_size);
+
+	bptr = &els->els_request_payload;
+	if (sli->params.sgl_pre_registered) {
+		els->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_REQ_WQE_XBL;
+
+		els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_DBDE;
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				    (params->xmit_len & SLI4_BDE_LEN_MASK));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(BLP)) |
+				    ((2 * sizeof(struct sli4_sge)) &
+				     SLI4_BDE_LEN_MASK));
+		bptr->u.blp.low  = cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high = cpu_to_le32(upper_32_bits(sgl->phys));
+	}
+
+	els->els_request_payload_length = cpu_to_le32(params->xmit_len);
+	els->max_response_payload_length = cpu_to_le32(params->rsp_len);
+
+	els->xri_tag = cpu_to_le16(params->xri);
+	els->timer = params->timeout;
+	els->class_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	els->command = SLI4_WQE_ELS_REQUEST64;
+
+	els->request_tag = cpu_to_le16(params->tag);
+
+	els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_IOD;
+
+	els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_QOSD;
+
+	/* figure out the ELS_ID value from the request buffer */
+
+	switch (params->cmd) {
+	case ELS_LOGO:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_LOGO << SLI4_REQ_WQE_ELSID_SHFT;
+		if (params->rpi_registered) {
+			els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_RPI << SLI4_REQ_WQE_CT_SHFT;
+			els->context_tag = cpu_to_le16(params->rpi);
+		} else {
+			els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+			els->context_tag = cpu_to_le16(params->vpi);
+		}
+		if (params->d_id == FC_FID_FLOGI)
+			is_fabric = true;
+		break;
+	case ELS_FDISC:
+		if (params->d_id == FC_FID_FLOGI)
+			is_fabric = true;
+		if (params->s_id == 0) {
+			els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_FDISC << SLI4_REQ_WQE_ELSID_SHFT;
+			is_fabric = true;
+		} else {
+			els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_OTHER << SLI4_REQ_WQE_ELSID_SHFT;
+		}
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+		els->context_tag = cpu_to_le16(params->vpi);
+		els->sid_sp_dword |= cpu_to_le32(1 << SLI4_REQ_WQE_SP_SHFT);
+		break;
+	case ELS_FLOGI:
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+		els->context_tag = cpu_to_le16(params->vpi);
+		/*
+		 * Set SP here ... we haven't done a REG_VPI yet
+		 * need to maybe not set this when we have
+		 * completed VFI/VPI registrations ...
+		 *
+		 * Use the FC_ID of the SPORT if it has been allocated,
+		 * otherwise use an S_ID of zero.
+		 */
+		els->sid_sp_dword |= cpu_to_le32(1 << SLI4_REQ_WQE_SP_SHFT);
+		if (params->s_id != U32_MAX)
+			els->sid_sp_dword |= cpu_to_le32(params->s_id);
+		break;
+	case ELS_PLOGI:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_PLOGI << SLI4_REQ_WQE_ELSID_SHFT;
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+		els->context_tag = cpu_to_le16(params->vpi);
+		break;
+	case ELS_SCR:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_OTHER << SLI4_REQ_WQE_ELSID_SHFT;
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+		els->context_tag = cpu_to_le16(params->vpi);
+		break;
+	default:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_OTHER << SLI4_REQ_WQE_ELSID_SHFT;
+		if (params->rpi_registered) {
+			els->ct_byte |= (SLI4_GENERIC_CONTEXT_RPI <<
+					 SLI4_REQ_WQE_CT_SHFT);
+			els->context_tag = cpu_to_le16(params->vpi);
+		} else {
+			els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+			els->context_tag = cpu_to_le16(params->vpi);
+		}
+		break;
+	}
+
+	if (is_fabric)
+		els->cmdtype_elsid_byte |= SLI4_ELS_REQUEST64_CMD_FABRIC;
+	else
+		els->cmdtype_elsid_byte |= SLI4_ELS_REQUEST64_CMD_NON_FABRIC;
+
+	els->cq_id = cpu_to_le16(SLI4_CQ_DEFAULT);
+
+	if (((els->ct_byte & SLI4_REQ_WQE_CT) >> SLI4_REQ_WQE_CT_SHFT) !=
+					SLI4_GENERIC_CONTEXT_RPI)
+		els->remote_id_dword = cpu_to_le32(params->d_id);
+
+	if (((els->ct_byte & SLI4_REQ_WQE_CT) >> SLI4_REQ_WQE_CT_SHFT) ==
+					SLI4_GENERIC_CONTEXT_VPI)
+		els->temporary_rpi = cpu_to_le16(params->rpi);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_fcp_icmnd64_wqe(struct sli4 *sli, void *buf, struct efc_dma *sgl, u16 xri,
+		    u16 tag, u16 cq_id, u32 rpi, u32 rnode_fcid, u8 timeout)
+{
+	struct sli4_fcp_icmnd64_wqe *icmnd = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+	u32 len;
+
+	memset(buf, 0, sli->wqe_size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return EFC_FAIL;
+	}
+	sge = sgl->virt;
+	bptr = &icmnd->bde;
+	if (sli->params.sgl_pre_registered) {
+		icmnd->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_ICMD_WQE_XBL;
+
+		icmnd->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_ICMD_WQE_DBDE;
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				    (le32_to_cpu(sge[0].buffer_length) &
+				     SLI4_BDE_LEN_MASK));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		icmnd->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_ICMD_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(BLP)) |
+				    (sgl->size & SLI4_BDE_LEN_MASK));
+
+		bptr->u.blp.low  = cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high = cpu_to_le32(upper_32_bits(sgl->phys));
+	}
+
+	len = le32_to_cpu(sge[0].buffer_length) +
+	      le32_to_cpu(sge[1].buffer_length);
+	icmnd->payload_offset_length = cpu_to_le16(len);
+	icmnd->xri_tag = cpu_to_le16(xri);
+	icmnd->context_tag = cpu_to_le16(rpi);
+	icmnd->timer = timeout;
+
+	/* WQE word 4 contains read transfer length */
+	icmnd->class_pu_byte |= 2 << SLI4_ICMD_WQE_PU_SHFT;
+	icmnd->class_pu_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+	icmnd->command = SLI4_WQE_FCP_ICMND64;
+	icmnd->dif_ct_bs_byte |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_ICMD_WQE_CT_SHFT;
+
+	icmnd->abort_tag = cpu_to_le32(xri);
+
+	icmnd->request_tag = cpu_to_le16(tag);
+	icmnd->len_loc1_byte |= SLI4_ICMD_WQE_LEN_LOC_BIT1;
+	icmnd->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_ICMD_WQE_LEN_LOC_BIT2;
+	icmnd->cmd_type_byte |= SLI4_CMD_FCP_ICMND64_WQE;
+	icmnd->cq_id = cpu_to_le16(cq_id);
+
+	return  EFC_SUCCESS;
+}
+
+int
+sli_fcp_iread64_wqe(struct sli4 *sli, void *buf, struct efc_dma *sgl,
+		    u32 first_data_sge, u32 xfer_len, u16 xri, u16 tag,
+		    u16 cq_id, u32 rpi, u32 rnode_fcid,
+		    u8 dif, u8 bs, u8 timeout)
+{
+	struct sli4_fcp_iread64_wqe *iread = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+	u32 sge_flags, len;
+
+	memset(buf, 0, sli->wqe_size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return EFC_FAIL;
+	}
+
+	sge = sgl->virt;
+	bptr = &iread->bde;
+	if (sli->params.sgl_pre_registered) {
+		iread->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_IR_WQE_XBL;
+
+		iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_DBDE;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				    (le32_to_cpu(sge[0].buffer_length) &
+				     SLI4_BDE_LEN_MASK));
+
+		bptr->u.blp.low  = sge[0].buffer_address_low;
+		bptr->u.blp.high = sge[0].buffer_address_high;
+	} else {
+		iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(BLP)) |
+				    (sgl->size & SLI4_BDE_LEN_MASK));
+
+		bptr->u.blp.low  =
+				cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high =
+				cpu_to_le32(upper_32_bits(sgl->phys));
+
+		/*
+		 * fill out fcp_cmnd buffer len and change resp buffer to be of
+		 * type "skip" (note: response will still be written to sge[1]
+		 * if necessary)
+		 */
+		len = le32_to_cpu(sge[0].buffer_length);
+		iread->fcp_cmd_buffer_length = cpu_to_le16(len);
+
+		sge_flags = le32_to_cpu(sge[1].dw2_flags);
+		sge_flags &= (~SLI4_SGE_TYPE_MASK);
+		sge_flags |= (SLI4_SGE_TYPE_SKIP << SLI4_SGE_TYPE_SHIFT);
+		sge[1].dw2_flags = cpu_to_le32(sge_flags);
+	}
+
+	len = le32_to_cpu(sge[0].buffer_length) +
+	      le32_to_cpu(sge[1].buffer_length);
+	iread->payload_offset_length = cpu_to_le16(len);
+	iread->total_transfer_length = cpu_to_le32(xfer_len);
+
+	iread->xri_tag = cpu_to_le16(xri);
+	iread->context_tag = cpu_to_le16(rpi);
+
+	iread->timer = timeout;
+
+	/* WQE word 4 contains read transfer length */
+	iread->class_pu_byte |= 2 << SLI4_IR_WQE_PU_SHFT;
+	iread->class_pu_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+	iread->command = SLI4_WQE_FCP_IREAD64;
+	iread->dif_ct_bs_byte |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_IR_WQE_CT_SHFT;
+	iread->dif_ct_bs_byte |= dif;
+	iread->dif_ct_bs_byte  |= bs << SLI4_IR_WQE_BS_SHFT;
+
+	iread->abort_tag = cpu_to_le32(xri);
+
+	iread->request_tag = cpu_to_le16(tag);
+	iread->len_loc1_byte |= SLI4_IR_WQE_LEN_LOC_BIT1;
+	iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_LEN_LOC_BIT2;
+	iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_IOD;
+	iread->cmd_type_byte |= SLI4_CMD_FCP_IREAD64_WQE;
+	iread->cq_id = cpu_to_le16(cq_id);
+
+	if (sli->params.perf_hint) {
+		bptr = &iread->first_data_bde;
+		bptr->bde_type_buflen =	cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			  (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_LEN_MASK));
+		bptr->u.data.low =
+			sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high =
+			sge[first_data_sge].buffer_address_high;
+	}
+
+	return  EFC_SUCCESS;
+}
+
+int
+sli_fcp_iwrite64_wqe(struct sli4 *sli, void *buf, struct efc_dma *sgl,
+		     u32 first_data_sge, u32 xfer_len,
+		     u32 first_burst, u16 xri, u16 tag,
+		     u16 cq_id, u32 rpi,
+		     u32 rnode_fcid,
+		     u8 dif, u8 bs, u8 timeout)
+{
+	struct sli4_fcp_iwrite64_wqe *iwrite = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+	u32 sge_flags, min, len;
+
+	memset(buf, 0, sli->wqe_size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return EFC_FAIL;
+	}
+	sge = sgl->virt;
+	bptr = &iwrite->bde;
+	if (sli->params.sgl_pre_registered) {
+		iwrite->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_IWR_WQE_XBL;
+
+		iwrite->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IWR_WQE_DBDE;
+		bptr->bde_type_buflen = cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+		       (le32_to_cpu(sge[0].buffer_length) & SLI4_BDE_LEN_MASK));
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		iwrite->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IWR_WQE_XBL;
+
+		bptr->bde_type_buflen =	cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+					(sgl->size & SLI4_BDE_LEN_MASK));
+
+		bptr->u.blp.low  = cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high = cpu_to_le32(upper_32_bits(sgl->phys));
+
+		/*
+		 * fill out fcp_cmnd buffer len and change resp buffer to be of
+		 * type "skip" (note: response will still be written to sge[1]
+		 * if necessary)
+		 */
+		len = le32_to_cpu(sge[0].buffer_length);
+		iwrite->fcp_cmd_buffer_length = cpu_to_le16(len);
+		sge_flags = le32_to_cpu(sge[1].dw2_flags);
+		sge_flags &= ~SLI4_SGE_TYPE_MASK;
+		sge_flags |= (SLI4_SGE_TYPE_SKIP << SLI4_SGE_TYPE_SHIFT);
+		sge[1].dw2_flags = cpu_to_le32(sge_flags);
+	}
+
+	len = le32_to_cpu(sge[0].buffer_length) +
+	      le32_to_cpu(sge[1].buffer_length);
+	iwrite->payload_offset_length = cpu_to_le16(len);
+	iwrite->total_transfer_length = cpu_to_le16(xfer_len);
+	min = (xfer_len < first_burst) ? xfer_len : first_burst;
+	iwrite->initial_transfer_length = cpu_to_le16(min);
+
+	iwrite->xri_tag = cpu_to_le16(xri);
+	iwrite->context_tag = cpu_to_le16(rpi);
+
+	iwrite->timer = timeout;
+	/* WQE word 4 contains read transfer length */
+	iwrite->class_pu_byte |= 2 << SLI4_IWR_WQE_PU_SHFT;
+	iwrite->class_pu_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+	iwrite->command = SLI4_WQE_FCP_IWRITE64;
+	iwrite->dif_ct_bs_byte |=
+			SLI4_GENERIC_CONTEXT_RPI << SLI4_IWR_WQE_CT_SHFT;
+	iwrite->dif_ct_bs_byte |= dif;
+	iwrite->dif_ct_bs_byte |= bs << SLI4_IWR_WQE_BS_SHFT;
+
+	iwrite->abort_tag = cpu_to_le32(xri);
+
+	iwrite->request_tag = cpu_to_le16(tag);
+	iwrite->len_loc1_byte |= SLI4_IWR_WQE_LEN_LOC_BIT1;
+	iwrite->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IWR_WQE_LEN_LOC_BIT2;
+	iwrite->cmd_type_byte |= SLI4_CMD_FCP_IWRITE64_WQE;
+	iwrite->cq_id = cpu_to_le16(cq_id);
+
+	if (sli->params.perf_hint) {
+		bptr = &iwrite->first_data_bde;
+
+		bptr->bde_type_buflen =	cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			 (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_LEN_MASK));
+
+		bptr->u.data.low = sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high = sge[first_data_sge].buffer_address_high;
+	}
+
+	return  EFC_SUCCESS;
+}
+
+int
+sli_fcp_treceive64_wqe(struct sli4 *sli, void *buf, struct efc_dma *sgl,
+		       u32 first_data_sge, u16 cq_id, u8 dif, u8 bs,
+		       struct sli_fcp_tgt_params *params)
+{
+	struct sli4_fcp_treceive64_wqe *trecv = buf;
+	struct sli4_fcp_128byte_wqe *trecv_128 = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, sli->wqe_size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return EFC_FAIL;
+	}
+	sge = sgl->virt;
+	bptr = &trecv->bde;
+	if (sli->params.sgl_pre_registered) {
+		trecv->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_TRCV_WQE_XBL;
+
+		trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_DBDE;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				    (le32_to_cpu(sge[0].buffer_length)
+					& SLI4_BDE_LEN_MASK));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+
+		trecv->payload_offset_length = sge[0].buffer_length;
+	} else {
+		trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_XBL;
+
+		/* if data is a single physical address, use a BDE */
+		if (!dif &&
+			params->xmit_len <= le32_to_cpu(sge[2].buffer_length)) {
+			trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_DBDE;
+			bptr->bde_type_buflen =
+			      cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+					  (le32_to_cpu(sge[2].buffer_length)
+					  & SLI4_BDE_LEN_MASK));
+
+			bptr->u.data.low = sge[2].buffer_address_low;
+			bptr->u.data.high = sge[2].buffer_address_high;
+		} else {
+			bptr->bde_type_buflen =
+				cpu_to_le32((SLI4_BDE_TYPE_VAL(BLP)) |
+				(sgl->size & SLI4_BDE_LEN_MASK));
+			bptr->u.blp.low = cpu_to_le32(lower_32_bits(sgl->phys));
+			bptr->u.blp.high =
+				cpu_to_le32(upper_32_bits(sgl->phys));
+		}
+	}
+
+	trecv->relative_offset = cpu_to_le32(params->offset);
+
+	if (params->flags & SLI4_IO_CONTINUATION)
+		trecv->eat_xc_ccpe |= SLI4_TRCV_WQE_XC;
+
+	trecv->xri_tag = cpu_to_le16(params->xri);
+
+	trecv->context_tag = cpu_to_le16(params->rpi);
+
+	/* WQE uses relative offset */
+	trecv->class_ar_pu_byte |= 1 << SLI4_TRCV_WQE_PU_SHFT;
+
+	if (params->flags & SLI4_IO_AUTO_GOOD_RESPONSE)
+		trecv->class_ar_pu_byte |= SLI4_TRCV_WQE_AR;
+
+	trecv->command = SLI4_WQE_FCP_TRECEIVE64;
+	trecv->class_ar_pu_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+	trecv->dif_ct_bs_byte |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_TRCV_WQE_CT_SHFT;
+	trecv->dif_ct_bs_byte |= bs << SLI4_TRCV_WQE_BS_SHFT;
+
+	trecv->remote_xid = cpu_to_le16(params->ox_id);
+
+	trecv->request_tag = cpu_to_le16(params->tag);
+
+	trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_IOD;
+
+	trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_LEN_LOC_BIT2;
+
+	trecv->cmd_type_byte |= SLI4_CMD_FCP_TRECEIVE64_WQE;
+
+	trecv->cq_id = cpu_to_le16(cq_id);
+
+	trecv->fcp_data_receive_length = cpu_to_le32(params->xmit_len);
+
+	if (sli->params.perf_hint) {
+		bptr = &trecv->first_data_bde;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			    (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_LEN_MASK));
+		bptr->u.data.low = sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high = sge[first_data_sge].buffer_address_high;
+	}
+
+	/* The upper 7 bits of csctl is the priority */
+	if (params->cs_ctl & SLI4_MASK_CCP) {
+		trecv->eat_xc_ccpe |= SLI4_TRCV_WQE_CCPE;
+		trecv->ccp = (params->cs_ctl & SLI4_MASK_CCP);
+	}
+
+	if (params->app_id && sli->wqe_size == SLI4_WQE_EXT_BYTES &&
+	    !(trecv->eat_xc_ccpe & SLI4_TRSP_WQE_EAT)) {
+		trecv->lloc1_appid |= SLI4_TRCV_WQE_APPID;
+		trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_WQES;
+		trecv_128->dw[31] = params->app_id;
+	}
+	return EFC_SUCCESS;
+}
+
+int
+sli_fcp_cont_treceive64_wqe(struct sli4 *sli, void *buf,
+			    struct efc_dma *sgl, u32 first_data_sge,
+			    u16 sec_xri, u16 cq_id, u8 dif, u8 bs,
+			    struct sli_fcp_tgt_params *params)
+{
+	int rc;
+
+	rc = sli_fcp_treceive64_wqe(sli, buf, sgl, first_data_sge,
+				    cq_id, dif, bs, params);
+	if (!rc) {
+		struct sli4_fcp_treceive64_wqe *trecv = buf;
+
+		trecv->command = SLI4_WQE_FCP_CONT_TRECEIVE64;
+		trecv->dword5.sec_xri_tag = cpu_to_le16(sec_xri);
+	}
+	return rc;
+}
+
+int
+sli_fcp_trsp64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		   u16 cq_id, u8 port_owned, struct sli_fcp_tgt_params *params)
+{
+	struct sli4_fcp_trsp64_wqe *trsp = buf;
+	struct sli4_fcp_128byte_wqe *trsp_128 = buf;
+
+	memset(buf, 0, sli4->wqe_size);
+
+	if (params->flags & SLI4_IO_AUTO_GOOD_RESPONSE) {
+		trsp->class_ag_byte |= SLI4_TRSP_WQE_AG;
+	} else {
+		struct sli4_sge	*sge = sgl->virt;
+		struct sli4_bde *bptr;
+
+		if (sli4->params.sgl_pre_registered || port_owned)
+			trsp->qosd_xbl_hlm_dbde_wqes |= SLI4_TRSP_WQE_DBDE;
+		else
+			trsp->qosd_xbl_hlm_dbde_wqes |= SLI4_TRSP_WQE_XBL;
+		bptr = &trsp->bde;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				     (le32_to_cpu(sge[0].buffer_length) &
+				      SLI4_BDE_LEN_MASK));
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+
+		trsp->fcp_response_length = cpu_to_le32(params->xmit_len);
+	}
+
+	if (params->flags & SLI4_IO_CONTINUATION)
+		trsp->eat_xc_ccpe |= SLI4_TRSP_WQE_XC;
+
+	trsp->xri_tag = cpu_to_le16(params->xri);
+	trsp->rpi = cpu_to_le16(params->rpi);
+
+	trsp->command = SLI4_WQE_FCP_TRSP64;
+	trsp->class_ag_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	trsp->remote_xid = cpu_to_le16(params->ox_id);
+	trsp->request_tag = cpu_to_le16(params->tag);
+	if (params->flags & SLI4_IO_DNRX)
+		trsp->ct_dnrx_byte |= SLI4_TRSP_WQE_DNRX;
+	else
+		trsp->ct_dnrx_byte &= ~SLI4_TRSP_WQE_DNRX;
+
+	trsp->lloc1_appid |= 0x1;
+	trsp->cq_id = cpu_to_le16(cq_id);
+	trsp->cmd_type_byte = SLI4_CMD_FCP_TRSP64_WQE;
+
+	/* The upper 7 bits of csctl is the priority */
+	if (params->cs_ctl & SLI4_MASK_CCP) {
+		trsp->eat_xc_ccpe |= SLI4_TRSP_WQE_CCPE;
+		trsp->ccp = (params->cs_ctl & SLI4_MASK_CCP);
+	}
+
+	if (params->app_id && sli4->wqe_size == SLI4_WQE_EXT_BYTES &&
+	    !(trsp->eat_xc_ccpe & SLI4_TRSP_WQE_EAT)) {
+		trsp->lloc1_appid |= SLI4_TRSP_WQE_APPID;
+		trsp->qosd_xbl_hlm_dbde_wqes |= SLI4_TRSP_WQE_WQES;
+		trsp_128->dw[31] = params->app_id;
+	}
+	return EFC_SUCCESS;
+}
+
+int
+sli_fcp_tsend64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		    u32 first_data_sge, u16 cq_id, u8 dif, u8 bs,
+		    struct sli_fcp_tgt_params *params)
+{
+	struct sli4_fcp_tsend64_wqe *tsend = buf;
+	struct sli4_fcp_128byte_wqe *tsend_128 = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, sli4->wqe_size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return EFC_FAIL;
+	}
+	sge = sgl->virt;
+
+	bptr = &tsend->bde;
+	if (sli4->params.sgl_pre_registered) {
+		tsend->ll_qd_xbl_hlm_iod_dbde &= ~SLI4_TSEND_WQE_XBL;
+
+		tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQE_DBDE;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				   (le32_to_cpu(sge[2].buffer_length) &
+				    SLI4_BDE_LEN_MASK));
+
+		/* TSEND64_WQE specifies first two SGE are skipped (3rd is
+		 * valid)
+		 */
+		bptr->u.data.low  = sge[2].buffer_address_low;
+		bptr->u.data.high = sge[2].buffer_address_high;
+	} else {
+		tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQE_XBL;
+
+		/* if data is a single physical address, use a BDE */
+		if (!dif &&
+			params->xmit_len <= le32_to_cpu(sge[2].buffer_length)) {
+			tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQE_DBDE;
+
+			bptr->bde_type_buflen =
+			    cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+					(le32_to_cpu(sge[2].buffer_length) &
+					SLI4_BDE_LEN_MASK));
+			/*
+			 * TSEND64_WQE specifies first two SGE are skipped
+			 * (i.e. 3rd is valid)
+			 */
+			bptr->u.data.low =
+				sge[2].buffer_address_low;
+			bptr->u.data.high =
+				sge[2].buffer_address_high;
+		} else {
+			bptr->bde_type_buflen =
+				cpu_to_le32((SLI4_BDE_TYPE_VAL(BLP)) |
+					    (sgl->size &
+					     SLI4_BDE_LEN_MASK));
+			bptr->u.blp.low =
+				cpu_to_le32(lower_32_bits(sgl->phys));
+			bptr->u.blp.high =
+				cpu_to_le32(upper_32_bits(sgl->phys));
+		}
+	}
+
+	tsend->relative_offset = cpu_to_le32(params->offset);
+
+	if (params->flags & SLI4_IO_CONTINUATION)
+		tsend->dw10byte2 |= SLI4_TSEND_XC;
+
+	tsend->xri_tag = cpu_to_le16(params->xri);
+
+	tsend->rpi = cpu_to_le16(params->rpi);
+	/* WQE uses relative offset */
+	tsend->class_pu_ar_byte |= 1 << SLI4_TSEND_WQE_PU_SHFT;
+
+	if (params->flags & SLI4_IO_AUTO_GOOD_RESPONSE)
+		tsend->class_pu_ar_byte |= SLI4_TSEND_WQE_AR;
+
+	tsend->command = SLI4_WQE_FCP_TSEND64;
+	tsend->class_pu_ar_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+	tsend->ct_byte |= SLI4_GENERIC_CONTEXT_RPI << SLI4_TSEND_CT_SHFT;
+	tsend->ct_byte |= dif;
+	tsend->ct_byte |= bs << SLI4_TSEND_BS_SHFT;
+
+	tsend->remote_xid = cpu_to_le16(params->ox_id);
+
+	tsend->request_tag = cpu_to_le16(params->tag);
+
+	tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_LEN_LOC_BIT2;
+
+	tsend->cq_id = cpu_to_le16(cq_id);
+
+	tsend->cmd_type_byte |= SLI4_CMD_FCP_TSEND64_WQE;
+
+	tsend->fcp_data_transmit_length = cpu_to_le32(params->xmit_len);
+
+	if (sli4->params.perf_hint) {
+		bptr = &tsend->first_data_bde;
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			    (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_LEN_MASK));
+		bptr->u.data.low =
+			sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high =
+			sge[first_data_sge].buffer_address_high;
+	}
+
+	/* The upper 7 bits of csctl is the priority */
+	if (params->cs_ctl & SLI4_MASK_CCP) {
+		tsend->dw10byte2 |= SLI4_TSEND_CCPE;
+		tsend->ccp = (params->cs_ctl & SLI4_MASK_CCP);
+	}
+
+	if (params->app_id && sli4->wqe_size == SLI4_WQE_EXT_BYTES &&
+	    !(tsend->dw10byte2 & SLI4_TSEND_EAT)) {
+		tsend->dw10byte0 |= SLI4_TSEND_APPID_VALID;
+		tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQES;
+		tsend_128->dw[31] = params->app_id;
+	}
+	return EFC_SUCCESS;
+}
+
+int
+sli_gen_request64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		      struct sli_ct_params *params)
+{
+	struct sli4_gen_request64_wqe *gen = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, sli4->wqe_size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return EFC_FAIL;
+	}
+	sge = sgl->virt;
+	bptr = &gen->bde;
+
+	if (sli4->params.sgl_pre_registered) {
+		gen->dw10flags1 &= ~SLI4_GEN_REQ64_WQE_XBL;
+
+		gen->dw10flags1 |= SLI4_GEN_REQ64_WQE_DBDE;
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				    (params->xmit_len & SLI4_BDE_LEN_MASK));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		gen->dw10flags1 |= SLI4_GEN_REQ64_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(BLP)) |
+				    ((2 * sizeof(struct sli4_sge)) &
+				     SLI4_BDE_LEN_MASK));
+
+		bptr->u.blp.low =
+			cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high =
+			cpu_to_le32(upper_32_bits(sgl->phys));
+	}
+
+	gen->request_payload_length = cpu_to_le32(params->xmit_len);
+	gen->max_response_payload_length = cpu_to_le32(params->rsp_len);
+
+	gen->df_ctl = params->df_ctl;
+	gen->type = params->type;
+	gen->r_ctl = params->r_ctl;
+
+	gen->xri_tag = cpu_to_le16(params->xri);
+
+	gen->ct_byte = SLI4_GENERIC_CONTEXT_RPI << SLI4_GEN_REQ64_CT_SHFT;
+	gen->context_tag = cpu_to_le16(params->rpi);
+
+	gen->class_byte = SLI4_GENERIC_CLASS_CLASS_3;
+
+	gen->command = SLI4_WQE_GEN_REQUEST64;
+
+	gen->timer = params->timeout;
+
+	gen->request_tag = cpu_to_le16(params->tag);
+
+	gen->dw10flags1 |= SLI4_GEN_REQ64_WQE_IOD;
+
+	gen->dw10flags0 |= SLI4_GEN_REQ64_WQE_QOSD;
+
+	gen->cmd_type_byte = SLI4_CMD_GEN_REQUEST64_WQE;
+
+	gen->cq_id = cpu_to_le16(SLI4_CQ_DEFAULT);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_send_frame_wqe(struct sli4 *sli, void *buf, u8 sof, u8 eof, u32 *hdr,
+			struct efc_dma *payload, u32 req_len,
+			u8 timeout, u16 xri, u16 req_tag)
+{
+	struct sli4_send_frame_wqe *sf = buf;
+
+	memset(buf, 0, sli->wqe_size);
+
+	sf->dw10flags1 |= SLI4_SF_WQE_DBDE;
+	sf->bde.bde_type_buflen = cpu_to_le32(req_len &
+					      SLI4_BDE_LEN_MASK);
+	sf->bde.u.data.low = cpu_to_le32(lower_32_bits(payload->phys));
+	sf->bde.u.data.high = cpu_to_le32(upper_32_bits(payload->phys));
+
+	/* Copy FC header */
+	sf->fc_header_0_1[0] = cpu_to_le32(hdr[0]);
+	sf->fc_header_0_1[1] = cpu_to_le32(hdr[1]);
+	sf->fc_header_2_5[0] = cpu_to_le32(hdr[2]);
+	sf->fc_header_2_5[1] = cpu_to_le32(hdr[3]);
+	sf->fc_header_2_5[2] = cpu_to_le32(hdr[4]);
+	sf->fc_header_2_5[3] = cpu_to_le32(hdr[5]);
+
+	sf->frame_length = cpu_to_le32(req_len);
+
+	sf->xri_tag = cpu_to_le16(xri);
+	sf->dw7flags0 &= ~SLI4_SF_PU;
+	sf->context_tag = 0;
+
+	sf->ct_byte &= ~SLI4_SF_CT;
+	sf->command = SLI4_WQE_SEND_FRAME;
+	sf->dw7flags0 |= SLI4_GENERIC_CLASS_CLASS_3;
+	sf->timer = timeout;
+
+	sf->request_tag = cpu_to_le16(req_tag);
+	sf->eof = eof;
+	sf->sof = sof;
+
+	sf->dw10flags1 &= ~SLI4_SF_QOSD;
+	sf->dw10flags0 |= SLI4_SF_LEN_LOC_BIT1;
+	sf->dw10flags2 &= ~SLI4_SF_XC;
+
+	sf->dw10flags1 |= SLI4_SF_XBL;
+
+	sf->cmd_type_byte |= SLI4_CMD_SEND_FRAME_WQE;
+	sf->cq_id = cpu_to_le16(0xffff);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_xmit_bls_rsp64_wqe(struct sli4 *sli, void *buf,
+		struct sli_bls_payload *payload, struct sli_bls_params *params)
+{
+	struct sli4_xmit_bls_rsp_wqe *bls = buf;
+	u32 dw_ridflags = 0;
+
+	/*
+	 * Callers can either specify RPI or S_ID, but not both
+	 */
+	if (params->rpi_registered && params->s_id != U32_MAX) {
+		efc_log_info(sli, "S_ID specified for attached remote node %d\n",
+			params->rpi);
+		return EFC_FAIL;
+	}
+
+	memset(buf, 0, sli->wqe_size);
+
+	if (payload->type == SLI4_SLI_BLS_ACC) {
+		bls->payload_word0 =
+			cpu_to_le32((payload->u.acc.seq_id_last << 16) |
+				    (payload->u.acc.seq_id_validity << 24));
+		bls->high_seq_cnt = payload->u.acc.high_seq_cnt;
+		bls->low_seq_cnt = payload->u.acc.low_seq_cnt;
+	} else if (payload->type == SLI4_SLI_BLS_RJT) {
+		bls->payload_word0 =
+				cpu_to_le32(*((u32 *)&payload->u.rjt));
+		dw_ridflags |= SLI4_BLS_RSP_WQE_AR;
+	} else {
+		efc_log_info(sli, "bad BLS type %#x\n", payload->type);
+		return EFC_FAIL;
+	}
+
+	bls->ox_id = payload->ox_id;
+	bls->rx_id = payload->rx_id;
+
+	if (params->rpi_registered) {
+		bls->dw8flags0 |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_BLS_RSP_WQE_CT_SHFT;
+		bls->context_tag = cpu_to_le16(params->rpi);
+	} else {
+		bls->dw8flags0 |=
+		SLI4_GENERIC_CONTEXT_VPI << SLI4_BLS_RSP_WQE_CT_SHFT;
+		bls->context_tag = cpu_to_le16(params->vpi);
+
+		if (params->s_id != U32_MAX)
+			bls->local_n_port_id_dword |=
+				cpu_to_le32(params->s_id & 0x00ffffff);
+		else
+			bls->local_n_port_id_dword |=
+				cpu_to_le32(params->s_id & 0x00ffffff);
+
+		dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
+			       (params->d_id & SLI4_BLS_RSP_RID);
+
+		bls->temporary_rpi = cpu_to_le16(params->rpi);
+	}
+
+	bls->xri_tag = cpu_to_le16(params->xri);
+
+	bls->dw8flags1 |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	bls->command = SLI4_WQE_XMIT_BLS_RSP;
+
+	bls->request_tag = cpu_to_le16(params->tag);
+
+	bls->dw11flags1 |= SLI4_BLS_RSP_WQE_QOSD;
+
+	bls->remote_id_dword = cpu_to_le32(dw_ridflags);
+	bls->cq_id = cpu_to_le16(SLI4_CQ_DEFAULT);
+
+	bls->dw12flags0 |= SLI4_CMD_XMIT_BLS_RSP64_WQE;
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_xmit_els_rsp64_wqe(struct sli4 *sli, void *buf, struct efc_dma *rsp,
+		       struct sli_els_params *params)
+{
+	struct sli4_xmit_els_rsp64_wqe *els = buf;
+
+	memset(buf, 0, sli->wqe_size);
+
+	if (sli->params.sgl_pre_registered)
+		els->flags2 |= SLI4_ELS_DBDE;
+	else
+		els->flags2 |= SLI4_ELS_XBL;
+
+	els->els_response_payload.bde_type_buflen =
+		cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			    (params->rsp_len & SLI4_BDE_LEN_MASK));
+	els->els_response_payload.u.data.low =
+		cpu_to_le32(lower_32_bits(rsp->phys));
+	els->els_response_payload.u.data.high =
+		cpu_to_le32(upper_32_bits(rsp->phys));
+
+	els->els_response_payload_length = cpu_to_le32(params->rsp_len);
+
+	els->xri_tag = cpu_to_le16(params->xri);
+
+	els->class_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	els->command = SLI4_WQE_ELS_RSP64;
+
+	els->request_tag = cpu_to_le16(params->tag);
+
+	els->ox_id = cpu_to_le16(params->ox_id);
+
+	els->flags2 |= SLI4_ELS_IOD & SLI4_ELS_REQUEST64_DIR_WRITE;
+
+	els->flags2 |= SLI4_ELS_QOSD;
+
+	els->cmd_type_wqec = SLI4_ELS_REQUEST64_CMD_GEN;
+
+	els->cq_id = cpu_to_le16(SLI4_CQ_DEFAULT);
+
+	if (params->rpi_registered) {
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_RPI << SLI4_ELS_CT_OFFSET;
+		els->context_tag = cpu_to_le16(params->rpi);
+		return EFC_SUCCESS;
+	}
+
+	els->ct_byte |= SLI4_GENERIC_CONTEXT_VPI << SLI4_ELS_CT_OFFSET;
+	els->context_tag = cpu_to_le16(params->vpi);
+	els->rid_dw = cpu_to_le32(params->d_id & SLI4_ELS_RID);
+	els->temporary_rpi = cpu_to_le16(params->rpi);
+	if (params->s_id != U32_MAX) {
+		els->sid_dw |=
+		      cpu_to_le32(SLI4_ELS_SP | (params->s_id & SLI4_ELS_SID));
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_xmit_sequence64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *payload,
+		struct sli_ct_params *params)
+{
+	struct sli4_xmit_sequence64_wqe *xmit = buf;
+
+	memset(buf, 0, sli4->wqe_size);
+
+	if (!payload || !payload->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       payload, payload ? payload->virt : NULL);
+		return EFC_FAIL;
+	}
+
+	if (sli4->params.sgl_pre_registered)
+		xmit->dw10w0 |= cpu_to_le16(SLI4_SEQ_WQE_DBDE);
+	else
+		xmit->dw10w0 |= cpu_to_le16(SLI4_SEQ_WQE_XBL);
+
+	xmit->bde.bde_type_buflen =
+		cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			(params->rsp_len & SLI4_BDE_LEN_MASK));
+	xmit->bde.u.data.low  =
+			cpu_to_le32(lower_32_bits(payload->phys));
+	xmit->bde.u.data.high =
+			cpu_to_le32(upper_32_bits(payload->phys));
+	xmit->sequence_payload_len = cpu_to_le32(params->rsp_len);
+
+	xmit->remote_n_port_id_dword |= cpu_to_le32(params->d_id & 0x00ffffff);
+
+	xmit->relative_offset = 0;
+
+	/* sequence initiative - this matches what is seen from
+	 * FC switches in response to FCGS commands
+	 */
+	xmit->dw5flags0 &= (~SLI4_SEQ_WQE_SI);
+	xmit->dw5flags0 &= (~SLI4_SEQ_WQE_FT);/* force transmit */
+	xmit->dw5flags0 &= (~SLI4_SEQ_WQE_XO);/* exchange responder */
+	xmit->dw5flags0 |= SLI4_SEQ_WQE_LS;/* last in seqence */
+	xmit->df_ctl = params->df_ctl;
+	xmit->type = params->type;
+	xmit->r_ctl = params->r_ctl;
+
+	xmit->xri_tag = cpu_to_le16(params->xri);
+	xmit->context_tag = cpu_to_le16(params->rpi);
+
+	xmit->dw7flags0 &= ~SLI4_SEQ_WQE_DIF;
+	xmit->dw7flags0 |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_SEQ_WQE_CT_SHIFT;
+	xmit->dw7flags0 &= ~SLI4_SEQ_WQE_BS;
+
+	xmit->command = SLI4_WQE_XMIT_SEQUENCE64;
+	xmit->dw7flags1 |= SLI4_GENERIC_CLASS_CLASS_3;
+	xmit->dw7flags1 &= ~SLI4_SEQ_WQE_PU;
+	xmit->timer = params->timeout;
+
+	xmit->abort_tag = 0;
+	xmit->request_tag = cpu_to_le16(params->tag);
+	xmit->remote_xid = cpu_to_le16(params->ox_id);
+
+	xmit->dw10w0 |=
+	cpu_to_le16(SLI4_ELS_REQUEST64_DIR_READ << SLI4_SEQ_WQE_IOD_SHIFT);
+
+	xmit->cmd_type_wqec_byte |= SLI4_CMD_XMIT_SEQUENCE64_WQE;
+
+	xmit->dw10w0 |= cpu_to_le16(2 << SLI4_SEQ_WQE_LEN_LOC_SHIFT);
+
+	xmit->cq_id = cpu_to_le16(0xFFFF);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_requeue_xri_wqe(struct sli4 *sli4, void *buf, u16 xri, u16 tag, u16 cq_id)
+{
+	struct sli4_requeue_xri_wqe *requeue = buf;
+
+	memset(buf, 0, sli4->wqe_size);
+
+	requeue->command = SLI4_WQE_REQUEUE_XRI;
+	requeue->xri_tag = cpu_to_le16(xri);
+	requeue->request_tag = cpu_to_le16(tag);
+	requeue->flags2 |= cpu_to_le16(SLI4_REQU_XRI_WQE_XC);
+	requeue->flags1 |= cpu_to_le16(SLI4_REQU_XRI_WQE_QOSD);
+	requeue->cq_id = cpu_to_le16(cq_id);
+	requeue->cmd_type_wqec_byte = SLI4_CMD_REQUEUE_XRI_WQE;
+	return EFC_SUCCESS;
+}
+
+int
+sli_fc_process_link_attention(struct sli4 *sli4, void *acqe)
+{
+	struct sli4_link_attention *link_attn = acqe;
+	struct sli4_link_event event = { 0 };
+
+	efc_log_info(sli4, "link=%d attn_type=%#x top=%#x speed=%#x pfault=%#x\n",
+		link_attn->link_number, link_attn->attn_type,
+		      link_attn->topology, link_attn->port_speed,
+		      link_attn->port_fault);
+	efc_log_info(sli4, "shared_lnk_status=%#x logl_lnk_speed=%#x evttag=%#x\n",
+		link_attn->shared_link_status,
+		      le16_to_cpu(link_attn->logical_link_speed),
+		      le32_to_cpu(link_attn->event_tag));
+
+	if (!sli4->link)
+		return EFC_FAIL;
+
+	event.medium   = SLI4_LINK_MEDIUM_FC;
+
+	switch (link_attn->attn_type) {
+	case SLI4_LNK_ATTN_TYPE_LINK_UP:
+		event.status = SLI4_LINK_STATUS_UP;
+		break;
+	case SLI4_LNK_ATTN_TYPE_LINK_DOWN:
+		event.status = SLI4_LINK_STATUS_DOWN;
+		break;
+	case SLI4_LNK_ATTN_TYPE_NO_HARD_ALPA:
+		efc_log_info(sli4, "attn_type: no hard alpa\n");
+		event.status = SLI4_LINK_STATUS_NO_ALPA;
+		break;
+	default:
+		efc_log_info(sli4, "attn_type: unknown\n");
+		break;
+	}
+
+	switch (link_attn->event_type) {
+	case SLI4_EVENT_LINK_ATTENTION:
+		break;
+	case SLI4_EVENT_SHARED_LINK_ATTENTION:
+		efc_log_info(sli4, "event_type: FC shared link event\n");
+		break;
+	default:
+		efc_log_info(sli4, "event_type: unknown\n");
+		break;
+	}
+
+	switch (link_attn->topology) {
+	case SLI4_LNK_ATTN_P2P:
+		event.topology = SLI4_LINK_TOPO_NPORT;
+		break;
+	case SLI4_LNK_ATTN_FC_AL:
+		event.topology = SLI4_LINK_TOPO_LOOP;
+		break;
+	case SLI4_LNK_ATTN_INTERNAL_LOOPBACK:
+		efc_log_info(sli4, "topology Internal loopback\n");
+		event.topology = SLI4_LINK_TOPO_LOOPBACK_INTERNAL;
+		break;
+	case SLI4_LNK_ATTN_SERDES_LOOPBACK:
+		efc_log_info(sli4, "topology serdes loopback\n");
+		event.topology = SLI4_LINK_TOPO_LOOPBACK_EXTERNAL;
+		break;
+	default:
+		efc_log_info(sli4, "topology: unknown\n");
+		break;
+	}
+
+	event.speed = link_attn->port_speed * 1000;
+
+	sli4->link(sli4->link_arg, (void *)&event);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_fc_cqe_parse(struct sli4 *sli4, struct sli4_queue *cq,
+		 u8 *cqe, enum sli4_qentry *etype, u16 *r_id)
+{
+	u8 code = cqe[SLI4_CQE_CODE_OFFSET];
+	int rc;
+
+	switch (code) {
+	case SLI4_CQE_CODE_WORK_REQUEST_COMPLETION:
+	{
+		struct sli4_fc_wcqe *wcqe = (void *)cqe;
+
+		*etype = SLI4_QENTRY_WQ;
+		*r_id = le16_to_cpu(wcqe->request_tag);
+		rc = wcqe->status;
+
+		/* Flag errors except for FCP_RSP_FAILURE */
+		if (rc && rc != SLI4_FC_WCQE_STATUS_FCP_RSP_FAILURE) {
+			efc_log_info(sli4, "WCQE: status=%#x hw_status=%#x tag=%#x\n",
+				wcqe->status, wcqe->hw_status,
+				le16_to_cpu(wcqe->request_tag));
+			efc_log_info(sli4, "w1=%#x w2=%#x xb=%d\n",
+				le32_to_cpu(wcqe->wqe_specific_1),
+				     le32_to_cpu(wcqe->wqe_specific_2),
+				     (wcqe->flags & SLI4_WCQE_XB));
+			efc_log_info(sli4, "      %08X %08X %08X %08X\n",
+				((u32 *)cqe)[0],
+				     ((u32 *)cqe)[1],
+				     ((u32 *)cqe)[2],
+				     ((u32 *)cqe)[3]);
+		}
+
+		break;
+	}
+	case SLI4_CQE_CODE_RQ_ASYNC:
+	{
+		struct sli4_fc_async_rcqe *rcqe = (void *)cqe;
+
+		*etype = SLI4_QENTRY_RQ;
+		*r_id = le16_to_cpu(rcqe->fcfi_rq_id_word) & SLI4_RACQE_RQ_ID;
+		rc = rcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_RQ_ASYNC_V1:
+	{
+		struct sli4_fc_async_rcqe_v1 *rcqe = (void *)cqe;
+
+		*etype = SLI4_QENTRY_RQ;
+		*r_id = le16_to_cpu(rcqe->rq_id);
+		rc = rcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_OPTIMIZED_WRITE_CMD:
+	{
+		struct sli4_fc_optimized_write_cmd_cqe *optcqe = (void *)cqe;
+
+		*etype = SLI4_QENTRY_OPT_WRITE_CMD;
+		*r_id = le16_to_cpu(optcqe->rq_id);
+		rc = optcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_OPTIMIZED_WRITE_DATA:
+	{
+		struct sli4_fc_optimized_write_data_cqe *dcqe = (void *)cqe;
+
+		*etype = SLI4_QENTRY_OPT_WRITE_DATA;
+		*r_id = le16_to_cpu(dcqe->xri);
+		rc = dcqe->status;
+
+		/* Flag errors */
+		if (rc != SLI4_FC_WCQE_STATUS_SUCCESS) {
+			efc_log_info(sli4, "Optimized DATA CQE: status=%#x\n",
+				dcqe->status);
+			efc_log_info(sli4, "hstat=%#x xri=%#x dpl=%#x w3=%#x xb=%d\n",
+				dcqe->hw_status, le16_to_cpu(dcqe->xri),
+				le32_to_cpu(dcqe->total_data_placed),
+				((u32 *)cqe)[3],
+				(dcqe->flags & SLI4_OCQE_XB));
+		}
+		break;
+	}
+	case SLI4_CQE_CODE_RQ_COALESCING:
+	{
+		struct sli4_fc_coalescing_rcqe *rcqe = (void *)cqe;
+
+		*etype = SLI4_QENTRY_RQ;
+		*r_id = le16_to_cpu(rcqe->rq_id);
+		rc = rcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_XRI_ABORTED:
+	{
+		struct sli4_fc_xri_aborted_cqe *xa = (void *)cqe;
+
+		*etype = SLI4_QENTRY_XABT;
+		*r_id = le16_to_cpu(xa->xri);
+		rc = EFC_SUCCESS;
+		break;
+	}
+	case SLI4_CQE_CODE_RELEASE_WQE: {
+		struct sli4_fc_wqec *wqec = (void *)cqe;
+
+		*etype = SLI4_QENTRY_WQ_RELEASE;
+		*r_id = le16_to_cpu(wqec->wq_id);
+		rc = EFC_SUCCESS;
+		break;
+	}
+	default:
+		efc_log_info(sli4, "CQE completion code %d not handled\n",
+			code);
+		*etype = SLI4_QENTRY_MAX;
+		*r_id = U16_MAX;
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+u32
+sli_fc_response_length(struct sli4 *sli4, u8 *cqe)
+{
+	struct sli4_fc_wcqe *wcqe = (void *)cqe;
+
+	return le32_to_cpu(wcqe->wqe_specific_1);
+}
+
+u32
+sli_fc_io_length(struct sli4 *sli4, u8 *cqe)
+{
+	struct sli4_fc_wcqe *wcqe = (void *)cqe;
+
+	return le32_to_cpu(wcqe->wqe_specific_1);
+}
+
+int
+sli_fc_els_did(struct sli4 *sli4, u8 *cqe, u32 *d_id)
+{
+	struct sli4_fc_wcqe *wcqe = (void *)cqe;
+
+	*d_id = 0;
+
+	if (wcqe->status)
+		return EFC_FAIL;
+	*d_id = le32_to_cpu(wcqe->wqe_specific_2) & 0x00ffffff;
+	return EFC_SUCCESS;
+}
+
+u32
+sli_fc_ext_status(struct sli4 *sli4, u8 *cqe)
+{
+	struct sli4_fc_wcqe *wcqe = (void *)cqe;
+	u32	mask;
+
+	switch (wcqe->status) {
+	case SLI4_FC_WCQE_STATUS_FCP_RSP_FAILURE:
+		mask = U32_MAX;
+		break;
+	case SLI4_FC_WCQE_STATUS_LOCAL_REJECT:
+	case SLI4_FC_WCQE_STATUS_CMD_REJECT:
+		mask = 0xff;
+		break;
+	case SLI4_FC_WCQE_STATUS_NPORT_RJT:
+	case SLI4_FC_WCQE_STATUS_FABRIC_RJT:
+	case SLI4_FC_WCQE_STATUS_NPORT_BSY:
+	case SLI4_FC_WCQE_STATUS_FABRIC_BSY:
+	case SLI4_FC_WCQE_STATUS_LS_RJT:
+		mask = U32_MAX;
+		break;
+	case SLI4_FC_WCQE_STATUS_DI_ERROR:
+		mask = U32_MAX;
+		break;
+	default:
+		mask = 0;
+	}
+
+	return le32_to_cpu(wcqe->wqe_specific_2) & mask;
+}
+
+int
+sli_fc_rqe_rqid_and_index(struct sli4 *sli4, u8 *cqe, u16 *rq_id, u32 *index)
+{
+	int rc = EFC_FAIL;
+	u8 code = 0;
+	u16 rq_element_index;
+
+	*rq_id = 0;
+	*index = U32_MAX;
+
+	code = cqe[SLI4_CQE_CODE_OFFSET];
+
+	/* Retrieve the RQ index from the completion */
+	if (code == SLI4_CQE_CODE_RQ_ASYNC) {
+		struct sli4_fc_async_rcqe *rcqe = (void *)cqe;
+
+		*rq_id = le16_to_cpu(rcqe->fcfi_rq_id_word) & SLI4_RACQE_RQ_ID;
+		rq_element_index =
+		le16_to_cpu(rcqe->rq_elmt_indx_word) & SLI4_RACQE_RQ_EL_INDX;
+		*index = rq_element_index;
+		if (rcqe->status == SLI4_FC_ASYNC_RQ_SUCCESS) {
+			rc = EFC_SUCCESS;
+		} else {
+			rc = rcqe->status;
+			efc_log_info(sli4, "status=%02x (%s) rq_id=%d\n",
+				rcqe->status,
+				sli_fc_get_status_string(rcqe->status),
+				le16_to_cpu(rcqe->fcfi_rq_id_word) &
+				SLI4_RACQE_RQ_ID);
+
+			efc_log_info(sli4, "pdpl=%x sof=%02x eof=%02x hdpl=%x\n",
+				le16_to_cpu(rcqe->data_placement_length),
+				rcqe->sof_byte, rcqe->eof_byte,
+				rcqe->hdpl_byte & SLI4_RACQE_HDPL);
+		}
+	} else if (code == SLI4_CQE_CODE_RQ_ASYNC_V1) {
+		struct sli4_fc_async_rcqe_v1 *rcqe_v1 = (void *)cqe;
+
+		*rq_id = le16_to_cpu(rcqe_v1->rq_id);
+		rq_element_index =
+			(le16_to_cpu(rcqe_v1->rq_elmt_indx_word) &
+			 SLI4_RACQE_RQ_EL_INDX);
+		*index = rq_element_index;
+		if (rcqe_v1->status == SLI4_FC_ASYNC_RQ_SUCCESS) {
+			rc = EFC_SUCCESS;
+		} else {
+			rc = rcqe_v1->status;
+			efc_log_info(sli4, "status=%02x (%s) rq_id=%d, index=%x\n",
+				rcqe_v1->status,
+				sli_fc_get_status_string(rcqe_v1->status),
+				le16_to_cpu(rcqe_v1->rq_id), rq_element_index);
+
+			efc_log_info(sli4, "pdpl=%x sof=%02x eof=%02x hdpl=%x\n",
+				le16_to_cpu(rcqe_v1->data_placement_length),
+			rcqe_v1->sof_byte, rcqe_v1->eof_byte,
+			rcqe_v1->hdpl_byte & SLI4_RACQE_HDPL);
+		}
+	} else if (code == SLI4_CQE_CODE_OPTIMIZED_WRITE_CMD) {
+		struct sli4_fc_optimized_write_cmd_cqe *optcqe = (void *)cqe;
+
+		*rq_id = le16_to_cpu(optcqe->rq_id);
+		*index = le16_to_cpu(optcqe->w1) & SLI4_OCQE_RQ_EL_INDX;
+		if (optcqe->status == SLI4_FC_ASYNC_RQ_SUCCESS) {
+			rc = EFC_SUCCESS;
+		} else {
+			rc = optcqe->status;
+			efc_log_info(sli4, "stat=%02x (%s) rqid=%d, idx=%x pdpl=%x\n",
+				optcqe->status,
+				sli_fc_get_status_string(optcqe->status),
+				le16_to_cpu(optcqe->rq_id), *index,
+				le16_to_cpu(optcqe->data_placement_length));
+
+			efc_log_info(sli4, "hdpl=%x oox=%d agxr=%d xri=0x%x rpi=%x\n",
+				(optcqe->hdpl_vld & SLI4_OCQE_HDPL),
+				(optcqe->flags1 & SLI4_OCQE_OOX),
+				(optcqe->flags1 & SLI4_OCQE_AGXR), optcqe->xri,
+				le16_to_cpu(optcqe->rpi));
+		}
+	} else if (code == SLI4_CQE_CODE_RQ_COALESCING) {
+		struct sli4_fc_coalescing_rcqe  *rcqe = (void *)cqe;
+
+		rq_element_index = (le16_to_cpu(rcqe->rq_elmt_indx_word) &
+				    SLI4_RCQE_RQ_EL_INDX);
+
+		*rq_id = le16_to_cpu(rcqe->rq_id);
+		if (rcqe->status == SLI4_FC_COALESCE_RQ_SUCCESS) {
+			*index = rq_element_index;
+			rc = EFC_SUCCESS;
+		} else {
+			*index = U32_MAX;
+			rc = rcqe->status;
+
+			efc_log_info(sli4, "stat=%02x (%s) rq_id=%d, idx=%x\n",
+				rcqe->status,
+				sli_fc_get_status_string(rcqe->status),
+				le16_to_cpu(rcqe->rq_id), rq_element_index);
+			efc_log_info(sli4, "rq_id=%#x sdpl=%x\n",
+				le16_to_cpu(rcqe->rq_id),
+		    le16_to_cpu(rcqe->sequence_reporting_placement_length));
+		}
+	} else {
+		struct sli4_fc_async_rcqe *rcqe = (void *)cqe;
+
+		*index = U32_MAX;
+		rc = rcqe->status;
+
+		efc_log_info(sli4, "status=%02x rq_id=%d, index=%x pdpl=%x\n",
+			rcqe->status,
+		le16_to_cpu(rcqe->fcfi_rq_id_word) & SLI4_RACQE_RQ_ID,
+		(le16_to_cpu(rcqe->rq_elmt_indx_word) & SLI4_RACQE_RQ_EL_INDX),
+		le16_to_cpu(rcqe->data_placement_length));
+		efc_log_info(sli4, "sof=%02x eof=%02x hdpl=%x\n",
+			rcqe->sof_byte, rcqe->eof_byte,
+			rcqe->hdpl_byte & SLI4_RACQE_HDPL);
+	}
+
+	return rc;
+}
-- 
2.26.2


--0000000000009f1f5205b181255f
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQglDYnuIi8zJU1uOHM
nBim/J7pBunH8tFxSL9ik/dhSrQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDEyMjI1MjAzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFHgin5ru2lKQg9cK/pEbufZC4xhGmfi9WvP
bnbiPlqPldzIVvR13OclcGwrxvdOD5SdMfA9p8fsDnEAqbByl1qPHDKcgNFjtOMv6BKKrhKv5VBz
4KpWLuzqLoPgqOpsy0sAnjp59DygEHLzkbbXeWdEFdjsUT8kUgDUpfLCdEZnHbwLJYTD/uci9Lhu
SMk8Y5y4IYMnqTjD4+TP0uVrNni+6w7VTG/rGdTRVC262MqliWIj8rOS1w3xDKiylmWRb4H175YD
TBkSH4UtorJLnPbkPE33UE2ezMSLcDKH1SER4BkfjAaLHfoEh/5YMa5mr/ztpP5UtpjZYN82eN7m
Mnk=
--0000000000009f1f5205b181255f--
