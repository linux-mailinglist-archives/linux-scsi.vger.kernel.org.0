Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C501284F8
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 23:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLTWhj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 17:37:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35147 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLTWhj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Dec 2019 17:37:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so577731pfo.2
        for <linux-scsi@vger.kernel.org>; Fri, 20 Dec 2019 14:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SeAbtWmlZ9ufgfvbigaaPrP0f+GXCiS8uo2o3H+0kN8=;
        b=RPo3971BaQ7ABxdZmrRu0K9+nfks4s30X8dgx86cO45MpDlwTm3wc5wS9ycb+2M14x
         wkC0k8le93D/jq8Wk3Nw4wwZPCvBvbcKHp1c5armWpbfY/vtX7Tk+i9AOfpPgaXauUAj
         GbpTdq8ghtMO2lujGs7iiUtFQRjMQQy32zNd0bU8GmnfIkppa44gY/AdyBReNFgGB2q2
         r6UyZeweLx9pw7uf1mh2EsqLH2yjnta4hRDT+HbZF+uJuVIxP1r5yN+4AU3SMzq1H8mm
         DeWnaQIVcynP+8/m9MWNV+OUnj4Y7a0Glmk8l3n3n86CdYCrBIz54/kLpCjO9bVjVLsx
         L8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SeAbtWmlZ9ufgfvbigaaPrP0f+GXCiS8uo2o3H+0kN8=;
        b=Ui2B40V4Th+NCWlqPww62VJUfp7dExasPg015i/K7/AZ69SZkPrruqjly/y1WourjS
         IrFduFy4Hey5SoouIuLuUNXOy8NZWKllsnrd0fy5Z3+a3Xaw6GessLbvjD7Ihle8Dtri
         VlYffhdsqqG9MNaQFuY4eLNv2Hsqw50OB4/Kc8oWipxDSWRvuGPFyAq8p1uj2ddpkvru
         WjVBwHG+ftiE2UvWFJTHhrLBgyIEHRm0DxwQ+0EbbKhJZ+LVkhmiqNxpxClxrzUDL3qq
         N0i882oRIMq2lBBF404M5+NFjXdfPQtYYQNWZ4TvglLreoA4krPjAv0ey4LeAf+7NcxM
         CggQ==
X-Gm-Message-State: APjAAAUVLJKsrcZjkJ5TtG5Vfkoj7F/gq/dgllL5HZY9Mb+WSWcrbKXs
        ZrShStFhP3d3v7uOjsELqi14ylnw
X-Google-Smtp-Source: APXvYqza8JCUTDbL8sH7j5z2G6H6Eh0jb4LzysSwLGFBJ/NCP/rAK72eqPBQ5NQlPd2SjZ/dB2F07Q==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr17685832pfk.88.1576881457212;
        Fri, 20 Dec 2019 14:37:37 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j28sm12219877pgb.36.2019.12.20.14.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 14:37:36 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     maier@linux.ibm.com, dwagner@suse.de, bvanassche@acm.org,
        James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [PATCH v2 05/32] elx: libefc_sli: Populate and post different WQEs
Date:   Fri, 20 Dec 2019 14:36:56 -0800
Message-Id: <20191220223723.26563-6-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191220223723.26563-1-jsmart2021@gmail.com>
References: <20191220223723.26563-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the libefc_sli SLI-4 library population.

This patch adds service routines to create different WQEs and adds
APIs to issue iread, iwrite, treceive, tsend and other work queue
entries.

Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/elx/libefc_sli/sli4.c | 1717 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/elx/libefc_sli/sli4.h |    2 +
 2 files changed, 1719 insertions(+)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 7061f7980fad..2ebe0235bc9e 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -1580,3 +1580,1720 @@ sli_cq_parse(struct sli4 *sli4, struct sli4_queue *cq, u8 *cqe,
 
 	return rc;
 }
+
+/* Write an ABORT_WQE work queue entry */
+int
+sli_abort_wqe(struct sli4 *sli4, void *buf, size_t size,
+	      enum sli4_abort_type type, bool send_abts, u32 ids,
+	      u32 mask, u16 tag, u16 cq_id)
+{
+	struct sli4_abort_wqe	*abort = buf;
+
+	memset(buf, 0, size);
+
+	switch (type) {
+	case SLI_ABORT_XRI:
+		abort->criteria = SLI4_ABORT_CRITERIA_XRI_TAG;
+		if (mask) {
+			efc_log_warn(sli4, "%#x aborting XRI %#x warning non-zero mask",
+				mask, ids);
+			mask = 0;
+		}
+		break;
+	case SLI_ABORT_ABORT_ID:
+		abort->criteria = SLI4_ABORT_CRITERIA_ABORT_TAG;
+		break;
+	case SLI_ABORT_REQUEST_ID:
+		abort->criteria = SLI4_ABORT_CRITERIA_REQUEST_TAG;
+		break;
+	default:
+		efc_log_info(sli4, "unsupported type %#x\n", type);
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
+/* Write an ELS_REQUEST64_WQE work queue entry */
+int
+sli_els_request64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		      struct efc_dma *sgl,
+		      u8 req_type, u32 req_len, u32 max_rsp_len,
+		      u8 timeout, u16 xri, u16 tag,
+		      u16 cq_id, u16 rnodeindicator, u16 sportindicator,
+		      bool hlm, bool rnodeattached, u32 rnode_fcid,
+		      u32 sport_fcid)
+{
+	struct sli4_els_request64_wqe	*els = buf;
+	struct sli4_sge *sge = sgl->virt;
+	bool is_fabric = false;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, size);
+
+	bptr = &els->els_request_payload;
+	if (sli4->sgl_pre_registered) {
+		els->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_REQ_WQE_XBL;
+
+		els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_DBDE;
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				    (req_len & SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BLP << BDE_TYPE_SHIFT) |
+				    ((2 * sizeof(struct sli4_sge)) &
+				     SLI4_BDE_MASK_BUFFER_LEN));
+		bptr->u.blp.low  = cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high = cpu_to_le32(upper_32_bits(sgl->phys));
+	}
+
+	els->els_request_payload_length = cpu_to_le32(req_len);
+	els->max_response_payload_length = cpu_to_le32(max_rsp_len);
+
+	els->xri_tag = cpu_to_le16(xri);
+	els->timer = timeout;
+	els->class_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	els->command = SLI4_WQE_ELS_REQUEST64;
+
+	els->request_tag = cpu_to_le16(tag);
+
+	if (hlm) {
+		els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_HLM;
+		els->remote_id_dword = cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+
+	els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_IOD;
+
+	els->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_REQ_WQE_QOSD;
+
+	/* figure out the ELS_ID value from the request buffer */
+
+	switch (req_type) {
+	case ELS_LOGO:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_LOGO << SLI4_REQ_WQE_ELSID_SHFT;
+		if (rnodeattached) {
+			els->ct_byte |= (SLI4_GENERIC_CONTEXT_RPI <<
+					 SLI4_REQ_WQE_CT_SHFT);
+			els->context_tag = cpu_to_le16(rnodeindicator);
+		} else {
+			els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+			els->context_tag =
+				cpu_to_le16(sportindicator);
+		}
+		if (rnode_fcid == FC_FID_FLOGI)
+			is_fabric = true;
+		break;
+	case ELS_FDISC:
+		if (rnode_fcid == FC_FID_FLOGI)
+			is_fabric = true;
+		if (sport_fcid == 0) {
+			els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_FDISC << SLI4_REQ_WQE_ELSID_SHFT;
+			is_fabric = true;
+		} else {
+			els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_OTHER << SLI4_REQ_WQE_ELSID_SHFT;
+		}
+		els->ct_byte |= (SLI4_GENERIC_CONTEXT_VPI <<
+				 SLI4_REQ_WQE_CT_SHFT);
+		els->context_tag = cpu_to_le16(sportindicator);
+		els->sid_sp_dword |= cpu_to_le32(1 << SLI4_REQ_WQE_SP_SHFT);
+		break;
+	case ELS_FLOGI:
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+		els->context_tag = cpu_to_le16(sportindicator);
+		/*
+		 * Set SP here ... we haven't done a REG_VPI yet
+		 * need to maybe not set this when we have
+		 * completed VFI/VPI registrations ...
+		 *
+		 * Use the FC_ID of the SPORT if it has been allocated,
+		 * otherwise use an S_ID of zero.
+		 */
+		els->sid_sp_dword |= cpu_to_le32(1 << SLI4_REQ_WQE_SP_SHFT);
+		if (sport_fcid != U32_MAX)
+			els->sid_sp_dword |= cpu_to_le32(sport_fcid);
+		break;
+	case ELS_PLOGI:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_PLOGI << SLI4_REQ_WQE_ELSID_SHFT;
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+		els->context_tag = cpu_to_le16(sportindicator);
+		break;
+	case ELS_SCR:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_OTHER << SLI4_REQ_WQE_ELSID_SHFT;
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+		els->context_tag = cpu_to_le16(sportindicator);
+		break;
+	default:
+		els->cmdtype_elsid_byte |=
+			SLI4_ELS_REQUEST64_OTHER << SLI4_REQ_WQE_ELSID_SHFT;
+		if (rnodeattached) {
+			els->ct_byte |= (SLI4_GENERIC_CONTEXT_RPI <<
+					 SLI4_REQ_WQE_CT_SHFT);
+			els->context_tag = cpu_to_le16(sportindicator);
+		} else {
+			els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_REQ_WQE_CT_SHFT;
+			els->context_tag =
+				cpu_to_le16(sportindicator);
+		}
+		break;
+	}
+
+	if (is_fabric)
+		els->cmdtype_elsid_byte |= SLI4_ELS_REQUEST64_CMD_FABRIC;
+	else
+		els->cmdtype_elsid_byte |= SLI4_ELS_REQUEST64_CMD_NON_FABRIC;
+
+	els->cq_id = cpu_to_le16(cq_id);
+
+	if (((els->ct_byte & SLI4_REQ_WQE_CT) >> SLI4_REQ_WQE_CT_SHFT) !=
+					SLI4_GENERIC_CONTEXT_RPI)
+		els->remote_id_dword = cpu_to_le32(rnode_fcid);
+
+	if (((els->ct_byte & SLI4_REQ_WQE_CT) >> SLI4_REQ_WQE_CT_SHFT) ==
+					SLI4_GENERIC_CONTEXT_VPI)
+		els->temporary_rpi = cpu_to_le16(rnodeindicator);
+
+	return EFC_SUCCESS;
+}
+
+/* Write an FCP_ICMND64_WQE work queue entry */
+int
+sli_fcp_icmnd64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		    struct efc_dma *sgl, u16 xri, u16 tag,
+		    u16 cq_id, u32 rpi, bool hlm,
+		    u32 rnode_fcid, u8 timeout)
+{
+	struct sli4_fcp_icmnd64_wqe *icmnd = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+	u32 len;
+
+	memset(buf, 0, size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return -1;
+	}
+	sge = sgl->virt;
+	bptr = &icmnd->bde;
+	if (sli4->sgl_pre_registered) {
+		icmnd->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_ICMD_WQE_XBL;
+
+		icmnd->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_ICMD_WQE_DBDE;
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				    (le32_to_cpu(sge[0].buffer_length) &
+				     SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		icmnd->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_ICMD_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BLP << BDE_TYPE_SHIFT) |
+				    (sgl->size & SLI4_BDE_MASK_BUFFER_LEN));
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
+	if (hlm) {
+		icmnd->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_ICMD_WQE_HLM;
+		icmnd->remote_n_port_id_dword =
+				cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+	icmnd->cmd_type_byte |= SLI4_CMD_FCP_ICMND64_WQE;
+	icmnd->cq_id = cpu_to_le16(cq_id);
+
+	return  0;
+}
+
+/* Write an FCP_IREAD64_WQE work queue entry */
+int
+sli_fcp_iread64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		    struct efc_dma *sgl, u32 first_data_sge,
+		    u32 xfer_len, u16 xri, u16 tag,
+		    u16 cq_id, u32 rpi, bool hlm, u32 rnode_fcid,
+		    u8 dif, u8 bs, u8 timeout)
+{
+	struct sli4_fcp_iread64_wqe *iread = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+	u32 sge_flags, len;
+
+	memset(buf, 0, size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return -1;
+	}
+	sge = sgl->virt;
+	bptr = &iread->bde;
+	if (sli4->sgl_pre_registered) {
+		iread->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_IR_WQE_XBL;
+
+		iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_DBDE;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				    (le32_to_cpu(sge[0].buffer_length) &
+				     SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.blp.low  = sge[0].buffer_address_low;
+		bptr->u.blp.high = sge[0].buffer_address_high;
+	} else {
+		iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BLP << BDE_TYPE_SHIFT) |
+				    (sgl->size & SLI4_BDE_MASK_BUFFER_LEN));
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
+	if (hlm) {
+		iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_HLM;
+		iread->remote_n_port_id_dword =
+				cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+	iread->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IR_WQE_IOD;
+	iread->cmd_type_byte |= SLI4_CMD_FCP_IREAD64_WQE;
+	iread->cq_id = cpu_to_le16(cq_id);
+
+	if (sli4->perf_hint) {
+		bptr = &iread->first_data_bde;
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+			  (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_MASK_BUFFER_LEN));
+		bptr->u.data.low =
+			sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high =
+			sge[first_data_sge].buffer_address_high;
+	}
+
+	return  0;
+}
+
+/* Write an FCP_IWRITE64_WQE work queue entry */
+int
+sli_fcp_iwrite64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		     struct efc_dma *sgl,
+		     u32 first_data_sge, u32 xfer_len,
+		     u32 first_burst, u16 xri, u16 tag,
+		     u16 cq_id, u32 rpi,
+		     bool hlm, u32 rnode_fcid,
+		     u8 dif, u8 bs, u8 timeout)
+{
+	struct sli4_fcp_iwrite64_wqe *iwrite = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+	u32 sge_flags, min, len;
+
+	memset(buf, 0, size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return -1;
+	}
+	sge = sgl->virt;
+	bptr = &iwrite->bde;
+	if (sli4->sgl_pre_registered) {
+		iwrite->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_IWR_WQE_XBL;
+
+		iwrite->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IWR_WQE_DBDE;
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				     (le32_to_cpu(sge[0].buffer_length) &
+				      SLI4_BDE_MASK_BUFFER_LEN));
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		iwrite->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IWR_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				    (sgl->size & SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.blp.low  =
+			cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high =
+			cpu_to_le32(upper_32_bits(sgl->phys));
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
+	if (hlm) {
+		iwrite->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_IWR_WQE_HLM;
+		iwrite->remote_n_port_id_dword =
+			cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+	iwrite->cmd_type_byte |= SLI4_CMD_FCP_IWRITE64_WQE;
+	iwrite->cq_id = cpu_to_le16(cq_id);
+
+	if (sli4->perf_hint) {
+		bptr = &iwrite->first_data_bde;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+			 (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.data.low =
+			sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high =
+			sge[first_data_sge].buffer_address_high;
+	}
+
+	return  0;
+}
+
+/* Write an FCP_TRECEIVE64_WQE work queue entry */
+int
+sli_fcp_treceive64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		       struct efc_dma *sgl,
+		       u32 first_data_sge, u32 relative_off,
+		       u32 xfer_len, u16 xri, u16 tag,
+		       u16 cq_id, u16 xid, u32 rpi, bool hlm,
+		       u32 rnode_fcid, u32 flags, u8 dif,
+		       u8 bs, u8 csctl, u32 app_id)
+{
+	struct sli4_fcp_treceive64_wqe *trecv = buf;
+	struct sli4_fcp_128byte_wqe *trecv_128 = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return -1;
+	}
+	sge = sgl->virt;
+	bptr = &trecv->bde;
+	if (sli4->sgl_pre_registered) {
+		trecv->qosd_xbl_hlm_iod_dbde_wqes &= ~SLI4_TRCV_WQE_XBL;
+
+		trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_DBDE;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				    (le32_to_cpu(sge[0].buffer_length)
+					& SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+
+		trecv->payload_offset_length = sge[0].buffer_length;
+	} else {
+		trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_XBL;
+
+		/* if data is a single physical address, use a BDE */
+		if (!dif && xfer_len <= le32_to_cpu(sge[2].buffer_length)) {
+			trecv->qosd_xbl_hlm_iod_dbde_wqes |=
+							SLI4_TRCV_WQE_DBDE;
+			bptr->bde_type_buflen =
+			      cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+					  (le32_to_cpu(sge[2].buffer_length)
+					  & SLI4_BDE_MASK_BUFFER_LEN));
+
+			bptr->u.data.low =
+				sge[2].buffer_address_low;
+			bptr->u.data.high =
+				sge[2].buffer_address_high;
+		} else {
+			bptr->bde_type_buflen =
+				cpu_to_le32((BDE_TYPE_BLP << BDE_TYPE_SHIFT) |
+				(sgl->size & SLI4_BDE_MASK_BUFFER_LEN));
+			bptr->u.blp.low =
+				cpu_to_le32(lower_32_bits(sgl->phys));
+			bptr->u.blp.high =
+				cpu_to_le32(upper_32_bits(sgl->phys));
+		}
+	}
+
+	trecv->relative_offset = cpu_to_le32(relative_off);
+
+	if (flags & SLI4_IO_CONTINUATION)
+		trecv->eat_xc_ccpe |= SLI4_TRCV_WQE_XC;
+
+	trecv->xri_tag = cpu_to_le16(xri);
+
+	trecv->context_tag = cpu_to_le16(rpi);
+
+	/* WQE uses relative offset */
+	trecv->class_ar_pu_byte |= 1 << SLI4_TRCV_WQE_PU_SHFT;
+
+	if (flags & SLI4_IO_AUTO_GOOD_RESPONSE)
+		trecv->class_ar_pu_byte |= SLI4_TRCV_WQE_AR;
+
+	trecv->command = SLI4_WQE_FCP_TRECEIVE64;
+	trecv->class_ar_pu_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+	trecv->dif_ct_bs_byte |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_TRCV_WQE_CT_SHFT;
+	trecv->dif_ct_bs_byte |= bs << SLI4_TRCV_WQE_BS_SHFT;
+
+	trecv->remote_xid = cpu_to_le16(xid);
+
+	trecv->request_tag = cpu_to_le16(tag);
+
+	trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_IOD;
+
+	trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_LEN_LOC_BIT2;
+
+	if (hlm) {
+		trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_HLM;
+		trecv->dword5.dword = cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+
+	trecv->cmd_type_byte |= SLI4_CMD_FCP_TRECEIVE64_WQE;
+
+	trecv->cq_id = cpu_to_le16(cq_id);
+
+	trecv->fcp_data_receive_length = cpu_to_le32(xfer_len);
+
+	if (sli4->perf_hint) {
+		bptr = &trecv->first_data_bde;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+			    (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_MASK_BUFFER_LEN));
+		bptr->u.data.low =
+			sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high =
+			sge[first_data_sge].buffer_address_high;
+	}
+
+	/* The upper 7 bits of csctl is the priority */
+	if (csctl & SLI4_MASK_CCP) {
+		trecv->eat_xc_ccpe |= SLI4_TRCV_WQE_CCPE;
+		trecv->ccp = (csctl & SLI4_MASK_CCP);
+	}
+
+	if (app_id && sli4->wqe_size == SLI4_WQE_EXT_BYTES &&
+	    !(trecv->eat_xc_ccpe & SLI4_TRSP_WQE_EAT)) {
+		trecv->lloc1_appid |= SLI4_TRCV_WQE_APPID;
+		trecv->qosd_xbl_hlm_iod_dbde_wqes |= SLI4_TRCV_WQE_WQES;
+		trecv_128->dw[31] = app_id;
+	}
+	return 0;
+}
+
+/* Write an FCP_CONT_TRECEIVE64_WQE work queue entry */
+int
+sli_fcp_cont_treceive64_wqe(struct sli4 *sli4, void *buf, size_t size,
+			    struct efc_dma *sgl, u32 first_data_sge,
+			    u32 relative_off, u32 xfer_len,
+			    u16 xri, u16 sec_xri, u16 tag,
+			    u16 cq_id, u16 xid, u32 rpi,
+			    bool hlm, u32 rnode_fcid, u32 flags,
+			    u8 dif, u8 bs, u8 csctl,
+			    u32 app_id)
+{
+	int rc;
+
+	rc = sli_fcp_treceive64_wqe(sli4, buf, size, sgl, first_data_sge,
+				    relative_off, xfer_len, xri, tag, cq_id,
+				    xid, rpi, hlm, rnode_fcid, flags, dif, bs,
+				    csctl, app_id);
+	if (rc == 0) {
+		struct sli4_fcp_treceive64_wqe *trecv = buf;
+
+		trecv->command = SLI4_WQE_FCP_CONT_TRECEIVE64;
+		trecv->dword5.sec_xri_tag = cpu_to_le16(sec_xri);
+	}
+	return rc;
+}
+
+/* Write an FCP_TRSP64_WQE work queue entry */
+int
+sli_fcp_trsp64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		   struct efc_dma *sgl,
+		   u32 rsp_len, u16 xri, u16 tag, u16 cq_id,
+		   u16 xid, u32 rpi, bool hlm, u32 rnode_fcid,
+		   u32 flags, u8 csctl, u8 port_owned,
+		   u32 app_id)
+{
+	struct sli4_fcp_trsp64_wqe *trsp = buf;
+	struct sli4_fcp_128byte_wqe *trsp_128 = buf;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, size);
+
+	if (flags & SLI4_IO_AUTO_GOOD_RESPONSE) {
+		trsp->class_ag_byte |= SLI4_TRSP_WQE_AG;
+	} else {
+		struct sli4_sge	*sge = sgl->virt;
+
+		if (sli4->sgl_pre_registered || port_owned)
+			trsp->qosd_xbl_hlm_dbde_wqes |= SLI4_TRSP_WQE_DBDE;
+		else
+			trsp->qosd_xbl_hlm_dbde_wqes |= SLI4_TRSP_WQE_XBL;
+		bptr = &trsp->bde;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				     (le32_to_cpu(sge[0].buffer_length) &
+				      SLI4_BDE_MASK_BUFFER_LEN));
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+
+		trsp->fcp_response_length = cpu_to_le32(rsp_len);
+	}
+
+	if (flags & SLI4_IO_CONTINUATION)
+		trsp->eat_xc_ccpe |= SLI4_TRSP_WQE_XC;
+
+	if (hlm) {
+		trsp->qosd_xbl_hlm_dbde_wqes |= SLI4_TRSP_WQE_HLM;
+		trsp->dword5 = cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+
+	trsp->xri_tag = cpu_to_le16(xri);
+	trsp->rpi = cpu_to_le16(rpi);
+
+	trsp->command = SLI4_WQE_FCP_TRSP64;
+	trsp->class_ag_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	trsp->remote_xid = cpu_to_le16(xid);
+	trsp->request_tag = cpu_to_le16(tag);
+	if (flags & SLI4_IO_DNRX)
+		trsp->ct_dnrx_byte |= SLI4_TRSP_WQE_DNRX;
+	else
+		trsp->ct_dnrx_byte &= ~SLI4_TRSP_WQE_DNRX;
+
+	trsp->lloc1_appid |= 0x1;
+	trsp->cq_id = cpu_to_le16(cq_id);
+	trsp->cmd_type_byte = SLI4_CMD_FCP_TRSP64_WQE;
+
+	/* The upper 7 bits of csctl is the priority */
+	if (csctl & SLI4_MASK_CCP) {
+		trsp->eat_xc_ccpe |= SLI4_TRSP_WQE_CCPE;
+		trsp->ccp = (csctl & SLI4_MASK_CCP);
+	}
+
+	if (app_id && sli4->wqe_size == SLI4_WQE_EXT_BYTES &&
+	    !(trsp->eat_xc_ccpe & SLI4_TRSP_WQE_EAT)) {
+		trsp->lloc1_appid |= SLI4_TRSP_WQE_APPID;
+		trsp->qosd_xbl_hlm_dbde_wqes |= SLI4_TRSP_WQE_WQES;
+		trsp_128->dw[31] = app_id;
+	}
+	return 0;
+}
+
+/* Write an FCP_TSEND64_WQE work queue entry */
+int
+sli_fcp_tsend64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		    struct efc_dma *sgl,
+		    u32 first_data_sge, u32 relative_off,
+		    u32 xfer_len, u16 xri, u16 tag,
+		    u16 cq_id, u16 xid, u32 rpi,
+		    bool hlm, u32 rnode_fcid, u32 flags, u8 dif,
+		    u8 bs, u8 csctl, u32 app_id)
+{
+	struct sli4_fcp_tsend64_wqe *tsend = buf;
+	struct sli4_fcp_128byte_wqe *tsend_128 = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return -1;
+	}
+	sge = sgl->virt;
+
+	bptr = &tsend->bde;
+	if (sli4->sgl_pre_registered) {
+		tsend->ll_qd_xbl_hlm_iod_dbde &= ~SLI4_TSEND_WQE_XBL;
+
+		tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQE_DBDE;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				   (le32_to_cpu(sge[2].buffer_length) &
+				    SLI4_BDE_MASK_BUFFER_LEN));
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
+		if (!dif && xfer_len <= le32_to_cpu(sge[2].buffer_length)) {
+			tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQE_DBDE;
+
+			bptr->bde_type_buflen =
+			    cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+					(le32_to_cpu(sge[2].buffer_length) &
+					SLI4_BDE_MASK_BUFFER_LEN));
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
+				cpu_to_le32((BDE_TYPE_BLP << BDE_TYPE_SHIFT) |
+					    (sgl->size &
+					     SLI4_BDE_MASK_BUFFER_LEN));
+			bptr->u.blp.low =
+				cpu_to_le32(lower_32_bits(sgl->phys));
+			bptr->u.blp.high =
+				cpu_to_le32(upper_32_bits(sgl->phys));
+		}
+	}
+
+	tsend->relative_offset = cpu_to_le32(relative_off);
+
+	if (flags & SLI4_IO_CONTINUATION)
+		tsend->dw10byte2 |= SLI4_TSEND_XC;
+
+	tsend->xri_tag = cpu_to_le16(xri);
+
+	tsend->rpi = cpu_to_le16(rpi);
+	/* WQE uses relative offset */
+	tsend->class_pu_ar_byte |= 1 << SLI4_TSEND_WQE_PU_SHFT;
+
+	if (flags & SLI4_IO_AUTO_GOOD_RESPONSE)
+		tsend->class_pu_ar_byte |= SLI4_TSEND_WQE_AR;
+
+	tsend->command = SLI4_WQE_FCP_TSEND64;
+	tsend->class_pu_ar_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+	tsend->ct_byte |= SLI4_GENERIC_CONTEXT_RPI << SLI4_TSEND_CT_SHFT;
+	tsend->ct_byte |= dif;
+	tsend->ct_byte |= bs << SLI4_TSEND_BS_SHFT;
+
+	tsend->remote_xid = cpu_to_le16(xid);
+
+	tsend->request_tag = cpu_to_le16(tag);
+
+	tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_LEN_LOC_BIT2;
+
+	if (hlm) {
+		tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQE_HLM;
+		tsend->dword5 = cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+
+	tsend->cq_id = cpu_to_le16(cq_id);
+
+	tsend->cmd_type_byte |= SLI4_CMD_FCP_TSEND64_WQE;
+
+	tsend->fcp_data_transmit_length = cpu_to_le32(xfer_len);
+
+	if (sli4->perf_hint) {
+		bptr = &tsend->first_data_bde;
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+			    (le32_to_cpu(sge[first_data_sge].buffer_length) &
+			     SLI4_BDE_MASK_BUFFER_LEN));
+		bptr->u.data.low =
+			sge[first_data_sge].buffer_address_low;
+		bptr->u.data.high =
+			sge[first_data_sge].buffer_address_high;
+	}
+
+	/* The upper 7 bits of csctl is the priority */
+	if (csctl & SLI4_MASK_CCP) {
+		tsend->dw10byte2 |= SLI4_TSEND_CCPE;
+		tsend->ccp = (csctl & SLI4_MASK_CCP);
+	}
+
+	if (app_id && sli4->wqe_size == SLI4_WQE_EXT_BYTES &&
+	    !(tsend->dw10byte2 & SLI4_TSEND_EAT)) {
+		tsend->dw10byte0 |= SLI4_TSEND_APPID_VALID;
+		tsend->ll_qd_xbl_hlm_iod_dbde |= SLI4_TSEND_WQES;
+		tsend_128->dw[31] = app_id;
+	}
+	return 0;
+}
+
+/* Write a GEN_REQUEST64 work queue entry */
+int
+sli_gen_request64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		      struct efc_dma *sgl, u32 req_len,
+		      u32 max_rsp_len, u8 timeout, u16 xri,
+		      u16 tag, u16 cq_id, bool hlm, u32 rnode_fcid,
+		      u16 rnodeindicator, u8 r_ctl,
+		      u8 type, u8 df_ctl)
+{
+	struct sli4_gen_request64_wqe	*gen = buf;
+	struct sli4_sge *sge = NULL;
+	struct sli4_bde *bptr;
+
+	memset(buf, 0, size);
+
+	if (!sgl || !sgl->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       sgl, sgl ? sgl->virt : NULL);
+		return -1;
+	}
+	sge = sgl->virt;
+	bptr = &gen->bde;
+
+	if (sli4->sgl_pre_registered) {
+		gen->dw10flags1 &= ~SLI4_GEN_REQ64_WQE_XBL;
+
+		gen->dw10flags1 |= SLI4_GEN_REQ64_WQE_DBDE;
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+				    (req_len & SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.data.low  = sge[0].buffer_address_low;
+		bptr->u.data.high = sge[0].buffer_address_high;
+	} else {
+		gen->dw10flags1 |= SLI4_GEN_REQ64_WQE_XBL;
+
+		bptr->bde_type_buflen =
+			cpu_to_le32((BDE_TYPE_BLP << BDE_TYPE_SHIFT) |
+				    ((2 * sizeof(struct sli4_sge)) &
+				     SLI4_BDE_MASK_BUFFER_LEN));
+
+		bptr->u.blp.low =
+			cpu_to_le32(lower_32_bits(sgl->phys));
+		bptr->u.blp.high =
+			cpu_to_le32(upper_32_bits(sgl->phys));
+	}
+
+	gen->request_payload_length = cpu_to_le32(req_len);
+	gen->max_response_payload_length = cpu_to_le32(max_rsp_len);
+
+	gen->df_ctl = df_ctl;
+	gen->type = type;
+	gen->r_ctl = r_ctl;
+
+	gen->xri_tag = cpu_to_le16(xri);
+
+	gen->ct_byte = SLI4_GENERIC_CONTEXT_RPI << SLI4_GEN_REQ64_CT_SHFT;
+	gen->context_tag = cpu_to_le16(rnodeindicator);
+
+	gen->class_byte = SLI4_GENERIC_CLASS_CLASS_3;
+
+	gen->command = SLI4_WQE_GEN_REQUEST64;
+
+	gen->timer = timeout;
+
+	gen->request_tag = cpu_to_le16(tag);
+
+	gen->dw10flags1 |= SLI4_GEN_REQ64_WQE_IOD;
+
+	gen->dw10flags0 |= SLI4_GEN_REQ64_WQE_QOSD;
+
+	if (hlm) {
+		gen->dw10flags1 |= SLI4_GEN_REQ64_WQE_HLM;
+		gen->remote_n_port_id_dword =
+			cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+
+	gen->cmd_type_byte = SLI4_CMD_GEN_REQUEST64_WQE;
+
+	gen->cq_id = cpu_to_le16(cq_id);
+
+	return 0;
+}
+
+/* Write a SEND_FRAME work queue entry */
+int
+sli_send_frame_wqe(struct sli4 *sli4, void *buf, size_t size,
+		   u8 sof, u8 eof, u32 *hdr,
+			struct efc_dma *payload, u32 req_len,
+			u8 timeout, u16 xri, u16 req_tag)
+{
+	struct sli4_send_frame_wqe *sf = buf;
+
+	memset(buf, 0, size);
+
+	sf->dw10flags1 |= SLI4_SF_WQE_DBDE;
+	sf->bde.bde_type_buflen = cpu_to_le32(req_len &
+					      SLI4_BDE_MASK_BUFFER_LEN);
+	sf->bde.u.data.low =
+		cpu_to_le32(lower_32_bits(payload->phys));
+	sf->bde.u.data.high =
+		cpu_to_le32(upper_32_bits(payload->phys));
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
+	return 0;
+}
+
+/* Write an XMIT_BLS_RSP64_WQE work queue entry */
+int
+sli_xmit_bls_rsp64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		       struct sli_bls_payload *payload, u16 xri,
+		       u16 tag, u16 cq_id,
+		       bool rnodeattached, bool hlm, u16 rnodeindicator,
+		       u16 sportindicator, u32 rnode_fcid,
+		       u32 sport_fcid, u32 s_id)
+{
+	struct sli4_xmit_bls_rsp_wqe *bls = buf;
+	u32 dw_ridflags = 0;
+
+	/*
+	 * Callers can either specify RPI or S_ID, but not both
+	 */
+	if (rnodeattached && s_id != U32_MAX) {
+		efc_log_info(sli4, "S_ID specified for attached remote node %d\n",
+			rnodeindicator);
+		return -1;
+	}
+
+	memset(buf, 0, size);
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
+		efc_log_info(sli4, "bad BLS type %#x\n", payload->type);
+		return -1;
+	}
+
+	bls->ox_id = payload->ox_id;
+	bls->rx_id = payload->rx_id;
+
+	if (rnodeattached) {
+		bls->dw8flags0 |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_BLS_RSP_WQE_CT_SHFT;
+		bls->context_tag = cpu_to_le16(rnodeindicator);
+	} else {
+		bls->dw8flags0 |=
+		SLI4_GENERIC_CONTEXT_VPI << SLI4_BLS_RSP_WQE_CT_SHFT;
+		bls->context_tag = cpu_to_le16(sportindicator);
+
+		if (s_id != U32_MAX)
+			bls->local_n_port_id_dword |=
+				cpu_to_le32(s_id & 0x00ffffff);
+		else
+			bls->local_n_port_id_dword |=
+				cpu_to_le32(sport_fcid & 0x00ffffff);
+
+		dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
+			       (rnode_fcid & SLI4_BLS_RSP_RID);
+
+		bls->temporary_rpi = cpu_to_le16(rnodeindicator);
+	}
+
+	bls->xri_tag = cpu_to_le16(xri);
+
+	bls->dw8flags1 |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	bls->command = SLI4_WQE_XMIT_BLS_RSP;
+
+	bls->request_tag = cpu_to_le16(tag);
+
+	bls->dw11flags1 |= SLI4_BLS_RSP_WQE_QOSD;
+
+	if (hlm) {
+		bls->dw11flags1 |= SLI4_BLS_RSP_WQE_HLM;
+		dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
+			       (rnode_fcid & SLI4_BLS_RSP_RID);
+	}
+
+	bls->remote_id_dword = cpu_to_le32(dw_ridflags);
+	bls->cq_id = cpu_to_le16(cq_id);
+
+	bls->dw12flags0 |= SLI4_CMD_XMIT_BLS_RSP64_WQE;
+
+	return 0;
+}
+
+/* Write a XMIT_ELS_RSP64_WQE work queue entry */
+int
+sli_xmit_els_rsp64_wqe(struct sli4 *sli4, void *buf, size_t size,
+		       struct efc_dma *rsp, u32 rsp_len,
+				u16 xri, u16 tag, u16 cq_id,
+				u16 ox_id, u16 rnodeindicator,
+				u16 sportindicator, bool hlm,
+				bool rnodeattached, u32 rnode_fcid,
+				u32 flags, u32 s_id)
+{
+	struct sli4_xmit_els_rsp64_wqe *els = buf;
+
+	memset(buf, 0, size);
+
+	if (sli4->sgl_pre_registered)
+		els->flags2 |= SLI4_ELS_DBDE;
+	else
+		els->flags2 |= SLI4_ELS_XBL;
+
+	els->els_response_payload.bde_type_buflen =
+		cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+			    (rsp_len & SLI4_BDE_MASK_BUFFER_LEN));
+	els->els_response_payload.u.data.low =
+		cpu_to_le32(lower_32_bits(rsp->phys));
+	els->els_response_payload.u.data.high =
+		cpu_to_le32(upper_32_bits(rsp->phys));
+
+	els->els_response_payload_length = cpu_to_le32(rsp_len);
+
+	els->xri_tag = cpu_to_le16(xri);
+
+	els->class_byte |= SLI4_GENERIC_CLASS_CLASS_3;
+
+	els->command = SLI4_WQE_ELS_RSP64;
+
+	els->request_tag = cpu_to_le16(tag);
+
+	els->ox_id = cpu_to_le16(ox_id);
+
+	els->flags2 |= (SLI4_ELS_IOD & SLI4_ELS_REQUEST64_DIR_WRITE);
+
+	els->flags2 |= SLI4_ELS_QOSD;
+
+	if (flags & SLI4_IO_CONTINUATION)
+		els->flags3 |= SLI4_ELS_XC;
+
+	if (rnodeattached) {
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_RPI << SLI4_ELS_CT_OFFSET;
+		els->context_tag = cpu_to_le16(rnodeindicator);
+	} else {
+		els->ct_byte |=
+			SLI4_GENERIC_CONTEXT_VPI << SLI4_ELS_CT_OFFSET;
+		els->context_tag = cpu_to_le16(sportindicator);
+		els->rid_dw = cpu_to_le32(rnode_fcid & SLI4_ELS_RID);
+		els->temporary_rpi = cpu_to_le16(rnodeindicator);
+		if (s_id != U32_MAX) {
+			els->sid_dw |= cpu_to_le32(SLI4_ELS_SP |
+						   (s_id & SLI4_ELS_SID));
+		}
+	}
+
+	if (hlm) {
+		els->flags2 |= SLI4_ELS_HLM;
+		els->rid_dw = cpu_to_le32(rnode_fcid & SLI4_ELS_RID);
+	}
+
+	els->cmd_type_wqec = SLI4_ELS_REQUEST64_CMD_GEN;
+
+	els->cq_id = cpu_to_le16(cq_id);
+
+	return 0;
+}
+
+/* Write a XMIT_SEQUENCE64 work queue entry */
+int
+sli_xmit_sequence64_wqe(struct sli4 *sli4, void *buf, size_t size,
+			struct efc_dma *payload, u32 payload_len,
+		u8 timeout, u16 ox_id, u16 xri,
+		u16 tag, bool hlm, u32 rnode_fcid,
+		u16 rnodeindicator, u8 r_ctl,
+		u8 type, u8 df_ctl)
+{
+	struct sli4_xmit_sequence64_wqe *xmit = buf;
+
+	memset(buf, 0, size);
+
+	if (!payload || !payload->virt) {
+		efc_log_err(sli4, "bad parameter sgl=%p virt=%p\n",
+		       payload, payload ? payload->virt : NULL);
+		return -1;
+	}
+
+	if (sli4->sgl_pre_registered)
+		xmit->dw10w0 |= cpu_to_le16(SLI4_SEQ_WQE_DBDE);
+	else
+		xmit->dw10w0 |= cpu_to_le16(SLI4_SEQ_WQE_XBL);
+
+	xmit->bde.bde_type_buflen =
+		cpu_to_le32((BDE_TYPE_BDE_64 << BDE_TYPE_SHIFT) |
+			(payload_len & SLI4_BDE_MASK_BUFFER_LEN));
+	xmit->bde.u.data.low  =
+			cpu_to_le32(lower_32_bits(payload->phys));
+	xmit->bde.u.data.high =
+			cpu_to_le32(upper_32_bits(payload->phys));
+	xmit->sequence_payload_len = cpu_to_le32(payload_len);
+
+	xmit->remote_n_port_id_dword |= cpu_to_le32(rnode_fcid & 0x00ffffff);
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
+	xmit->df_ctl = df_ctl;
+	xmit->type = type;
+	xmit->r_ctl = r_ctl;
+
+	xmit->xri_tag = cpu_to_le16(xri);
+	xmit->context_tag = cpu_to_le16(rnodeindicator);
+
+	xmit->dw7flags0 &= (~SLI4_SEQ_WQE_DIF);
+	xmit->dw7flags0 |=
+		SLI4_GENERIC_CONTEXT_RPI << SLI4_SEQ_WQE_CT_SHIFT;
+	xmit->dw7flags0 &= (~SLI4_SEQ_WQE_BS);
+
+	xmit->command = SLI4_WQE_XMIT_SEQUENCE64;
+	xmit->dw7flags1 |= SLI4_GENERIC_CLASS_CLASS_3;
+	xmit->dw7flags1 &= (~SLI4_SEQ_WQE_PU);
+	xmit->timer = timeout;
+
+	xmit->abort_tag = 0;
+	xmit->request_tag = cpu_to_le16(tag);
+	xmit->remote_xid = cpu_to_le16(ox_id);
+
+	xmit->dw10w0 |=
+	cpu_to_le16(SLI4_ELS_REQUEST64_DIR_READ << SLI4_SEQ_WQE_IOD_SHIFT);
+
+	if (hlm) {
+		xmit->dw10w0 |= cpu_to_le16(SLI4_SEQ_WQE_HLM);
+		xmit->remote_n_port_id_dword |=
+			cpu_to_le32(rnode_fcid & 0x00ffffff);
+	}
+
+	xmit->cmd_type_wqec_byte |= SLI4_CMD_XMIT_SEQUENCE64_WQE;
+
+	xmit->dw10w0 |= cpu_to_le16(2 << SLI4_SEQ_WQE_LEN_LOC_SHIFT);
+
+	xmit->cq_id = cpu_to_le16(0xFFFF);
+
+	return 0;
+}
+
+/* Write a REQUEUE_XRI_WQE work queue entry */
+int
+sli_requeue_xri_wqe(struct sli4 *sli4, void *buf, size_t size,
+		    u16 xri, u16 tag, u16 cq_id)
+{
+	struct sli4_requeue_xri_wqe *requeue = buf;
+
+	memset(buf, 0, size);
+
+	requeue->command = SLI4_WQE_REQUEUE_XRI;
+	requeue->xri_tag = cpu_to_le16(xri);
+	requeue->request_tag = cpu_to_le16(tag);
+	requeue->flags2 |= cpu_to_le16(SLI4_REQU_XRI_WQE_XC);
+	requeue->flags1 |= cpu_to_le16(SLI4_REQU_XRI_WQE_QOSD);
+	requeue->cq_id = cpu_to_le16(cq_id);
+	requeue->cmd_type_wqec_byte = SLI4_CMD_REQUEUE_XRI_WQE;
+	return 0;
+}
+
+/* Process an asynchronous Link State event entry */
+int
+sli_fc_process_link_state(struct sli4 *sli4, void *acqe)
+{
+	struct sli4_link_state *link_state = acqe;
+	struct sli4_link_event event = { 0 };
+	int rc = 0;
+	u8 link_type = (link_state->link_num_type & LINK_TYPE_MASK);
+
+	if (!sli4->link) {
+		/* bail if there is no callback */
+		return 0;
+	}
+
+	if (link_type == LINK_TYPE_ETHERNET) {
+		event.topology = SLI_LINK_TOPO_NPORT;
+		event.medium   = SLI_LINK_MEDIUM_ETHERNET;
+	} else {
+		efc_log_info(sli4, "unsupported link type %#x\n",
+			link_type);
+		event.topology = SLI_LINK_TOPO_MAX;
+		event.medium   = SLI_LINK_MEDIUM_MAX;
+		rc = -1;
+	}
+
+	switch (link_state->port_link_status) {
+	case PORT_LINK_STATUS_PHYSICAL_DOWN:
+	case PORT_LINK_STATUS_LOGICAL_DOWN:
+		event.status = SLI_LINK_STATUS_DOWN;
+		break;
+	case PORT_LINK_STATUS_PHYSICAL_UP:
+	case PORT_LINK_STATUS_LOGICAL_UP:
+		event.status = SLI_LINK_STATUS_UP;
+		break;
+	default:
+		efc_log_info(sli4, "unsupported link status %#x\n",
+			link_state->port_link_status);
+		event.status = SLI_LINK_STATUS_MAX;
+		rc = -1;
+	}
+
+	switch (link_state->port_speed) {
+	case PORT_SPEED_NO_LINK:
+		event.speed = 0;
+		break;
+	case PORT_SPEED_10_MBPS:
+		event.speed = 10;
+		break;
+	case PORT_SPEED_100_MBP:
+		event.speed = 100;
+		break;
+	case PORT_SPEED_1_GBPS:
+		event.speed = 1000;
+		break;
+	case PORT_SPEED_10_GBPS:
+		event.speed = 10000;
+		break;
+	case PORT_SPEED_20_GBPS:
+		event.speed = 20000;
+		break;
+	case PORT_SPEED_25_GBPS:
+		event.speed = 25000;
+		break;
+	case PORT_SPEED_40_GBPS:
+		event.speed = 40000;
+		break;
+	case PORT_SPEED_100_GBPS:
+		event.speed = 100000;
+		break;
+	default:
+		efc_log_info(sli4, "unsupported port_speed %#x\n",
+			link_state->port_speed);
+		rc = -1;
+	}
+
+	sli4->link(sli4->link_arg, (void *)&event);
+
+	return rc;
+}
+
+/* Process an asynchronous Link Attention event entry */
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
+	efc_log_info(sli4, "shared_lnk_status=%#x logl_lnk_speed=%#x evnttag=%#x\n",
+		link_attn->shared_link_status,
+		      le16_to_cpu(link_attn->logical_link_speed),
+		      le32_to_cpu(link_attn->event_tag));
+
+	if (!sli4->link)
+		return 0;
+
+	event.medium   = SLI_LINK_MEDIUM_FC;
+
+	switch (link_attn->attn_type) {
+	case LINK_ATTN_TYPE_LINK_UP:
+		event.status = SLI_LINK_STATUS_UP;
+		break;
+	case LINK_ATTN_TYPE_LINK_DOWN:
+		event.status = SLI_LINK_STATUS_DOWN;
+		break;
+	case LINK_ATTN_TYPE_NO_HARD_ALPA:
+		efc_log_info(sli4, "attn_type: no hard alpa\n");
+		event.status = SLI_LINK_STATUS_NO_ALPA;
+		break;
+	default:
+		efc_log_info(sli4, "attn_type: unknown\n");
+		break;
+	}
+
+	switch (link_attn->event_type) {
+	case FC_EVENT_LINK_ATTENTION:
+		break;
+	case FC_EVENT_SHARED_LINK_ATTENTION:
+		efc_log_info(sli4, "event_type: FC shared link event\n");
+		break;
+	default:
+		efc_log_info(sli4, "event_type: unknown\n");
+		break;
+	}
+
+	switch (link_attn->topology) {
+	case LINK_ATTN_P2P:
+		event.topology = SLI_LINK_TOPO_NPORT;
+		break;
+	case LINK_ATTN_FC_AL:
+		event.topology = SLI_LINK_TOPO_LOOP;
+		break;
+	case LINK_ATTN_INTERNAL_LOOPBACK:
+		efc_log_info(sli4, "topology Internal loopback\n");
+		event.topology = SLI_LINK_TOPO_LOOPBACK_INTERNAL;
+		break;
+	case LINK_ATTN_SERDES_LOOPBACK:
+		efc_log_info(sli4, "topology serdes loopback\n");
+		event.topology = SLI_LINK_TOPO_LOOPBACK_EXTERNAL;
+		break;
+	default:
+		efc_log_info(sli4, "topology: unknown\n");
+		break;
+	}
+
+	event.speed    = link_attn->port_speed * 1000;
+
+	sli4->link(sli4->link_arg, (void *)&event);
+
+	return 0;
+}
+
+/* Parse an FC work queue CQ entry */
+int
+sli_fc_cqe_parse(struct sli4 *sli4, struct sli4_queue *cq,
+		 u8 *cqe, enum sli4_qentry *etype, u16 *r_id)
+{
+	u8 code = cqe[SLI4_CQE_CODE_OFFSET];
+	int rc = -1;
+
+	switch (code) {
+	case SLI4_CQE_CODE_WORK_REQUEST_COMPLETION:
+	{
+		struct sli4_fc_wcqe *wcqe = (void *)cqe;
+
+		*etype = SLI_QENTRY_WQ;
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
+		*etype = SLI_QENTRY_RQ;
+		*r_id = le16_to_cpu(rcqe->fcfi_rq_id_word) & SLI4_RACQE_RQ_ID;
+		rc = rcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_RQ_ASYNC_V1:
+	{
+		struct sli4_fc_async_rcqe_v1 *rcqe = (void *)cqe;
+
+		*etype = SLI_QENTRY_RQ;
+		*r_id = le16_to_cpu(rcqe->rq_id);
+		rc = rcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_OPTIMIZED_WRITE_CMD:
+	{
+		struct sli4_fc_optimized_write_cmd_cqe *optcqe = (void *)cqe;
+
+		*etype = SLI_QENTRY_OPT_WRITE_CMD;
+		*r_id = le16_to_cpu(optcqe->rq_id);
+		rc = optcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_OPTIMIZED_WRITE_DATA:
+	{
+		struct sli4_fc_optimized_write_data_cqe *dcqe = (void *)cqe;
+
+		*etype = SLI_QENTRY_OPT_WRITE_DATA;
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
+		*etype = SLI_QENTRY_RQ;
+		*r_id = le16_to_cpu(rcqe->rq_id);
+		rc = rcqe->status;
+		break;
+	}
+	case SLI4_CQE_CODE_XRI_ABORTED:
+	{
+		struct sli4_fc_xri_aborted_cqe *xa = (void *)cqe;
+
+		*etype = SLI_QENTRY_XABT;
+		*r_id = le16_to_cpu(xa->xri);
+		rc = 0;
+		break;
+	}
+	case SLI4_CQE_CODE_RELEASE_WQE: {
+		struct sli4_fc_wqec *wqec = (void *)cqe;
+
+		*etype = SLI_QENTRY_WQ_RELEASE;
+		*r_id = le16_to_cpu(wqec->wq_id);
+		rc = 0;
+		break;
+	}
+	default:
+		efc_log_info(sli4, "CQE completion code %d not handled\n",
+			code);
+		*etype = SLI_QENTRY_MAX;
+		*r_id = U16_MAX;
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
+		return -1;
+	*d_id = le32_to_cpu(wcqe->wqe_specific_2) & 0x00ffffff;
+	return 0;
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
+/* Retrieve the RQ index from the completion */
+int
+sli_fc_rqe_rqid_and_index(struct sli4 *sli4, u8 *cqe,
+			  u16 *rq_id, u32 *index)
+{
+	struct sli4_fc_async_rcqe *rcqe = (void *)cqe;
+	struct sli4_fc_async_rcqe_v1 *rcqe_v1 = (void *)cqe;
+	int rc = -1;
+	u8 code = 0;
+	u16 rq_element_index;
+
+	*rq_id = 0;
+	*index = U32_MAX;
+
+	code = cqe[SLI4_CQE_CODE_OFFSET];
+
+	if (code == SLI4_CQE_CODE_RQ_ASYNC) {
+		*rq_id = le16_to_cpu(rcqe->fcfi_rq_id_word) & SLI4_RACQE_RQ_ID;
+		rq_element_index =
+		le16_to_cpu(rcqe->rq_elmt_indx_word) & SLI4_RACQE_RQ_EL_INDX;
+		*index = rq_element_index;
+		if (rcqe->status == SLI4_FC_ASYNC_RQ_SUCCESS) {
+			rc = 0;
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
+		*rq_id = le16_to_cpu(rcqe_v1->rq_id);
+		rq_element_index =
+			(le16_to_cpu(rcqe_v1->rq_elmt_indx_word) &
+			 SLI4_RACQE_RQ_EL_INDX);
+		*index = rq_element_index;
+		if (rcqe_v1->status == SLI4_FC_ASYNC_RQ_SUCCESS) {
+			rc = 0;
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
+			rc = 0;
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
+		struct sli4_fc_coalescing_rcqe	*rcqe = (void *)cqe;
+		u16 rq_element_index =
+				(le16_to_cpu(rcqe->rq_elmt_indx_word) &
+				 SLI4_RCQE_RQ_EL_INDX);
+
+		*rq_id = le16_to_cpu(rcqe->rq_id);
+		if (rcqe->status == SLI4_FC_COALESCE_RQ_SUCCESS) {
+			*index = rq_element_index;
+			rc = 0;
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
+		*index = U32_MAX;
+
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
diff --git a/drivers/scsi/elx/libefc_sli/sli4.h b/drivers/scsi/elx/libefc_sli/sli4.h
index 1846a28d5fd8..5c9609e7c72c 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.h
+++ b/drivers/scsi/elx/libefc_sli/sli4.h
@@ -12,6 +12,8 @@
 #ifndef _SLI4_H
 #define _SLI4_H
 
+#include "scsi/fc/fc_els.h"
+#include "scsi/fc/fc_fs.h"
 #include "../include/efc_common.h"
 
 /*************************************************************************
-- 
2.13.7

