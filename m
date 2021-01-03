Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1192E8D81
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Jan 2021 18:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbhACRNO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 3 Jan 2021 12:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbhACRNK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 3 Jan 2021 12:13:10 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62329C06179E
        for <linux-scsi@vger.kernel.org>; Sun,  3 Jan 2021 09:12:10 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x126so14886614pfc.7
        for <linux-scsi@vger.kernel.org>; Sun, 03 Jan 2021 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjy1uJS0fR87ZnzPqMxnANOOPKT7SyZ5paZnJlxkHtg=;
        b=lXdEyzEIETCZ7GZE5JNlC1/owP+godFpD+TbD01x64uqaXv1Md2qeJBmp2tBFKxowA
         IUN2LjrrFe5BBegqnuV8h+ClCPUxNRBC8p9oalY065KqbWqv7wdA8lh7fOpDIc5cpHWd
         /aiFhQ/xtUuSIVz2oc6aXhvYKLHOPPb5f66A8akp+be9mIKgMZ8K9o79f85hB6bSKPzh
         98TCIbyLEHWO6TPrYRBGsvkvPRuiAyXXSqGxBitP0lAJ8B6czo5/8RFRUvWNsA3YKC/M
         jXhMt/yDYCgyDrN/9UAXZSbgEqquA96KL99tJZgLcubroeo1eqFwzeC9Pw6PJrH3nxIS
         ZLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjy1uJS0fR87ZnzPqMxnANOOPKT7SyZ5paZnJlxkHtg=;
        b=A6dMXkSti6fBCmpKd4dZ+cCoqn1P0P24ORIgGZbl8vfCnmRFOmX6o/mrMpvdD8Sh06
         oAxo9lMdBTsjWT1oPVUFm0K8TcgZFk9lpMUbgyzrCumEgxn6SN6jLB/IYT5lB3nQ7Nm1
         bRHjxJ2diFOQE2zbJRtggAUmprOAbuUbYmmlmq+Cbb3X6CHJPU7BHFPLOHlQzpvXYVvi
         nYtF+eq6B8YmM6gKIYzAnAlkba+e3bBfThWHebQUO54DfpvKI4ScFM1YSwtuRtGEtvj2
         dS1BPkSC52I8Vze4XLIF2RsRKNlSglgld96y5ul+EVa/lnB5ojEjKiHd9a140Plbkf77
         uI2w==
X-Gm-Message-State: AOAM532I6p89Qtg36P7QShDZm7cMrWw+U3lBLrNK50gfYmFsZgRUPrgm
        2ZXFmC9Mhk+JACsl7OAX+obDaDY3hlg=
X-Google-Smtp-Source: ABdhPJwRVqdYsz9PVOWkbLFh3kM8ZtayZDLwNyGqOe5wt0Dyoe+yNpLHxqJVZ8hXnmCO3pHJLxn0Fw==
X-Received: by 2002:a05:6a00:885:b029:19b:9057:16f with SMTP id q5-20020a056a000885b029019b9057016fmr62296943pfj.80.1609693929071;
        Sun, 03 Jan 2021 09:12:09 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m4sm33145151pgv.16.2021.01.03.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:12:08 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 07/31] elx: libefc_sli: APIs to setup SLI library
Date:   Sun,  3 Jan 2021 09:11:10 -0800
Message-Id: <20210103171134.39878-8-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103171134.39878-1-jsmart2021@gmail.com>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the libefc_sli SLI-4 library population.

This patch adds APIS to initialize the library, initialize
the SLI Port, reset firmware, terminate the SLI Port, and
terminate the library.

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/elx/libefc_sli/sli4.c | 1135 ++++++++++++++++++++++++++++
 drivers/scsi/elx/libefc_sli/sli4.h |  396 ++++++++++
 2 files changed, 1531 insertions(+)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 1a56cdf9f398..31de54f69366 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -4048,3 +4048,1138 @@ sli_cqe_async(struct sli4 *sli4, void *buf)
 
 	return rc;
 }
+
+bool
+sli_fw_ready(struct sli4 *sli4)
+{
+	u32 val;
+
+	/* Determine if the chip FW is in a ready state */
+	val = sli_reg_read_status(sli4);
+	return (val & SLI4_PORT_STATUS_RDY) ? 1 : 0;
+}
+
+static bool
+sli_wait_for_fw_ready(struct sli4 *sli4, u32 timeout_ms)
+{
+	unsigned long end;
+
+	end = jiffies + msecs_to_jiffies(timeout_ms);
+
+	do {
+		if (sli_fw_ready(sli4))
+			return true;
+
+		usleep_range(1000, 2000);
+	} while (time_before(jiffies, end));
+
+	return false;
+}
+
+static bool
+sli_sliport_reset(struct sli4 *sli4)
+{
+	bool rc;
+	u32 val;
+
+	val = SLI4_PORT_CTRL_IP;
+	/* Initialize port, endian */
+	writel(val, (sli4->reg[0] + SLI4_PORT_CTRL_REG));
+
+	rc = sli_wait_for_fw_ready(sli4, SLI4_FW_READY_TIMEOUT_MSEC);
+	if (!rc)
+		efc_log_crit(sli4, "port failed to become ready after initialization\n");
+
+	return rc;
+}
+
+static bool
+sli_fw_init(struct sli4 *sli4)
+{
+	/*
+	 * Is firmware ready for operation?
+	 */
+	if (!sli_wait_for_fw_ready(sli4, SLI4_FW_READY_TIMEOUT_MSEC)) {
+		efc_log_crit(sli4, "FW status is NOT ready\n");
+		return false;
+	}
+
+	/*
+	 * Reset port to a known state
+	 */
+	return sli_sliport_reset(sli4);
+}
+
+static int
+sli_request_features(struct sli4 *sli4, u32 *features, bool query)
+{
+	struct sli4_cmd_request_features *req_features = sli4->bmbx.virt;
+
+	if (sli_cmd_request_features(sli4, sli4->bmbx.virt, *features, query)) {
+		efc_log_err(sli4, "bad REQUEST_FEATURES write\n");
+		return EFC_FAIL;
+	}
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "%s: bootstrap mailbox write fail\n",
+			__func__);
+		return EFC_FAIL;
+	}
+
+	if (le16_to_cpu(req_features->hdr.status)) {
+		efc_log_err(sli4, "REQUEST_FEATURES bad status %#x\n",
+		       le16_to_cpu(req_features->hdr.status));
+		return EFC_FAIL;
+	}
+
+	*features = le32_to_cpu(req_features->resp);
+	return EFC_SUCCESS;
+}
+
+void
+sli_calc_max_qentries(struct sli4 *sli4)
+{
+	enum sli4_qtype q;
+	u32 qentries;
+
+	for (q = SLI4_QTYPE_EQ; q < SLI4_QTYPE_MAX; q++) {
+		sli4->qinfo.max_qentries[q] =
+			sli_convert_mask_to_count(sli4->qinfo.count_method[q],
+						  sli4->qinfo.count_mask[q]);
+	}
+
+	/* single, continguous DMA allocations will be called for each queue
+	 * of size (max_qentries * queue entry size); since these can be large,
+	 * check against the OS max DMA allocation size
+	 */
+	for (q = SLI4_QTYPE_EQ; q < SLI4_QTYPE_MAX; q++) {
+		qentries = sli4->qinfo.max_qentries[q];
+
+		efc_log_info(sli4, "[%s]: max_qentries from %d to %d\n",
+			     SLI4_QNAME[q],
+			     sli4->qinfo.max_qentries[q], qentries);
+		sli4->qinfo.max_qentries[q] = qentries;
+	}
+}
+
+static int
+sli_get_read_config(struct sli4 *sli4)
+{
+	struct sli4_rsp_read_config *conf = sli4->bmbx.virt;
+	u32 i, total, total_size;
+	u32 *base;
+
+	if (sli_cmd_read_config(sli4, sli4->bmbx.virt)) {
+		efc_log_err(sli4, "bad READ_CONFIG write\n");
+		return EFC_FAIL;
+	}
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "bootstrap mailbox fail (READ_CONFIG)\n");
+		return EFC_FAIL;
+	}
+
+	if (le16_to_cpu(conf->hdr.status)) {
+		efc_log_err(sli4, "READ_CONFIG bad status %#x\n",
+		       le16_to_cpu(conf->hdr.status));
+		return EFC_FAIL;
+	}
+
+	sli4->params.has_extents =
+	  le32_to_cpu(conf->ext_dword) & SLI4_READ_CFG_RESP_RESOURCE_EXT;
+	if (sli4->params.has_extents) {
+		efc_log_err(sli4, "extents not supported\n");
+		return EFC_FAIL;
+	}
+
+	base = sli4->ext[0].base;
+	if (!base) {
+		int size = SLI4_RSRC_MAX * sizeof(u32);
+
+		base = kzalloc(size, GFP_KERNEL);
+		if (!base)
+			return EFC_FAIL;
+	}
+
+	for (i = 0; i < SLI4_RSRC_MAX; i++) {
+		sli4->ext[i].number = 1;
+		sli4->ext[i].n_alloc = 0;
+		sli4->ext[i].base = &base[i];
+	}
+
+	sli4->ext[SLI4_RSRC_VFI].base[0] = le16_to_cpu(conf->vfi_base);
+	sli4->ext[SLI4_RSRC_VFI].size = le16_to_cpu(conf->vfi_count);
+
+	sli4->ext[SLI4_RSRC_VPI].base[0] = le16_to_cpu(conf->vpi_base);
+	sli4->ext[SLI4_RSRC_VPI].size = le16_to_cpu(conf->vpi_count);
+
+	sli4->ext[SLI4_RSRC_RPI].base[0] = le16_to_cpu(conf->rpi_base);
+	sli4->ext[SLI4_RSRC_RPI].size = le16_to_cpu(conf->rpi_count);
+
+	sli4->ext[SLI4_RSRC_XRI].base[0] = le16_to_cpu(conf->xri_base);
+	sli4->ext[SLI4_RSRC_XRI].size = le16_to_cpu(conf->xri_count);
+
+	sli4->ext[SLI4_RSRC_FCFI].base[0] = 0;
+	sli4->ext[SLI4_RSRC_FCFI].size = le16_to_cpu(conf->fcfi_count);
+
+	for (i = 0; i < SLI4_RSRC_MAX; i++) {
+		total = sli4->ext[i].number * sli4->ext[i].size;
+		total_size = BITS_TO_LONGS(total) * sizeof(long);
+		sli4->ext[i].use_map = kzalloc(total_size, GFP_KERNEL);
+		if (!sli4->ext[i].use_map) {
+			efc_log_err(sli4, "bitmap memory allocation failed %d\n",
+			       i);
+			return EFC_FAIL;
+		}
+		sli4->ext[i].map_size = total;
+	}
+
+	sli4->topology = (le32_to_cpu(conf->topology_dword) &
+			  SLI4_READ_CFG_RESP_TOPOLOGY) >> 24;
+	switch (sli4->topology) {
+	case SLI4_READ_CFG_TOPO_FC:
+		efc_log_info(sli4, "FC (unknown)\n");
+		break;
+	case SLI4_READ_CFG_TOPO_NON_FC_AL:
+		efc_log_info(sli4, "FC (direct attach)\n");
+		break;
+	case SLI4_READ_CFG_TOPO_FC_AL:
+		efc_log_info(sli4, "FC (arbitrated loop)\n");
+		break;
+	default:
+		efc_log_info(sli4, "bad topology %#x\n",
+			sli4->topology);
+	}
+
+	sli4->e_d_tov = le16_to_cpu(conf->e_d_tov);
+	sli4->r_a_tov = le16_to_cpu(conf->r_a_tov);
+
+	sli4->link_module_type = le16_to_cpu(conf->lmt);
+
+	sli4->qinfo.max_qcount[SLI4_QTYPE_EQ] =	le16_to_cpu(conf->eq_count);
+	sli4->qinfo.max_qcount[SLI4_QTYPE_CQ] =	le16_to_cpu(conf->cq_count);
+	sli4->qinfo.max_qcount[SLI4_QTYPE_WQ] =	le16_to_cpu(conf->wq_count);
+	sli4->qinfo.max_qcount[SLI4_QTYPE_RQ] =	le16_to_cpu(conf->rq_count);
+
+	/*
+	 * READ_CONFIG doesn't give the max number of MQ. Applications
+	 * will typically want 1, but we may need another at some future
+	 * date. Dummy up a "max" MQ count here.
+	 */
+	sli4->qinfo.max_qcount[SLI4_QTYPE_MQ] = SLI4_USER_MQ_COUNT;
+	return EFC_SUCCESS;
+}
+
+static int
+sli_get_sli4_parameters(struct sli4 *sli4)
+{
+	struct sli4_rsp_cmn_get_sli4_params *parms;
+	u32 dw_loopback;
+	u32 dw_eq_pg_cnt;
+	u32 dw_cq_pg_cnt;
+	u32 dw_mq_pg_cnt;
+	u32 dw_wq_pg_cnt;
+	u32 dw_rq_pg_cnt;
+	u32 dw_sgl_pg_cnt;
+
+	if (sli_cmd_common_get_sli4_parameters(sli4, sli4->bmbx.virt))
+		return EFC_FAIL;
+
+	parms = (struct sli4_rsp_cmn_get_sli4_params *)
+		 (((u8 *)sli4->bmbx.virt) +
+		  offsetof(struct sli4_cmd_sli_config, payload.embed));
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "%s: bootstrap mailbox write fail\n",
+			__func__);
+		return EFC_FAIL;
+	}
+
+	if (parms->hdr.status) {
+		efc_log_err(sli4, "COMMON_GET_SLI4_PARAMETERS bad status %#x",
+		       parms->hdr.status);
+		efc_log_err(sli4, "additional status %#x\n",
+		       parms->hdr.additional_status);
+		return EFC_FAIL;
+	}
+
+	dw_loopback = le32_to_cpu(parms->dw16_loopback_scope);
+	dw_eq_pg_cnt = le32_to_cpu(parms->dw6_eq_page_cnt);
+	dw_cq_pg_cnt = le32_to_cpu(parms->dw8_cq_page_cnt);
+	dw_mq_pg_cnt = le32_to_cpu(parms->dw10_mq_page_cnt);
+	dw_wq_pg_cnt = le32_to_cpu(parms->dw12_wq_page_cnt);
+	dw_rq_pg_cnt = le32_to_cpu(parms->dw14_rq_page_cnt);
+
+	sli4->params.auto_reg =	(dw_loopback & SLI4_PARAM_AREG);
+	sli4->params.auto_xfer_rdy = (dw_loopback & SLI4_PARAM_AGXF);
+	sli4->params.hdr_template_req =	(dw_loopback & SLI4_PARAM_HDRR);
+	sli4->params.t10_dif_inline_capable = (dw_loopback & SLI4_PARAM_TIMM);
+	sli4->params.t10_dif_separate_capable =	(dw_loopback & SLI4_PARAM_TSMM);
+
+	sli4->params.mq_create_version = GET_Q_CREATE_VERSION(dw_mq_pg_cnt);
+	sli4->params.cq_create_version = GET_Q_CREATE_VERSION(dw_cq_pg_cnt);
+
+	sli4->rq_min_buf_size =	le16_to_cpu(parms->min_rq_buffer_size);
+	sli4->rq_max_buf_size = le32_to_cpu(parms->max_rq_buffer_size);
+
+	sli4->qinfo.qpage_count[SLI4_QTYPE_EQ] =
+		(dw_eq_pg_cnt & SLI4_PARAM_EQ_PAGE_CNT_MASK);
+	sli4->qinfo.qpage_count[SLI4_QTYPE_CQ] =
+		(dw_cq_pg_cnt & SLI4_PARAM_CQ_PAGE_CNT_MASK);
+	sli4->qinfo.qpage_count[SLI4_QTYPE_MQ] =
+		(dw_mq_pg_cnt & SLI4_PARAM_MQ_PAGE_CNT_MASK);
+	sli4->qinfo.qpage_count[SLI4_QTYPE_WQ] =
+		(dw_wq_pg_cnt & SLI4_PARAM_WQ_PAGE_CNT_MASK);
+	sli4->qinfo.qpage_count[SLI4_QTYPE_RQ] =
+		(dw_rq_pg_cnt & SLI4_PARAM_RQ_PAGE_CNT_MASK);
+
+	/* save count methods and masks for each queue type */
+
+	sli4->qinfo.count_mask[SLI4_QTYPE_EQ] =
+			le16_to_cpu(parms->eqe_count_mask);
+	sli4->qinfo.count_method[SLI4_QTYPE_EQ] =
+			GET_Q_CNT_METHOD(dw_eq_pg_cnt);
+
+	sli4->qinfo.count_mask[SLI4_QTYPE_CQ] =
+			le16_to_cpu(parms->cqe_count_mask);
+	sli4->qinfo.count_method[SLI4_QTYPE_CQ] =
+			GET_Q_CNT_METHOD(dw_cq_pg_cnt);
+
+	sli4->qinfo.count_mask[SLI4_QTYPE_MQ] =
+			le16_to_cpu(parms->mqe_count_mask);
+	sli4->qinfo.count_method[SLI4_QTYPE_MQ] =
+			GET_Q_CNT_METHOD(dw_mq_pg_cnt);
+
+	sli4->qinfo.count_mask[SLI4_QTYPE_WQ] =
+			le16_to_cpu(parms->wqe_count_mask);
+	sli4->qinfo.count_method[SLI4_QTYPE_WQ] =
+			GET_Q_CNT_METHOD(dw_wq_pg_cnt);
+
+	sli4->qinfo.count_mask[SLI4_QTYPE_RQ] =
+			le16_to_cpu(parms->rqe_count_mask);
+	sli4->qinfo.count_method[SLI4_QTYPE_RQ] =
+			GET_Q_CNT_METHOD(dw_rq_pg_cnt);
+
+	/* now calculate max queue entries */
+	sli_calc_max_qentries(sli4);
+
+	dw_sgl_pg_cnt = le32_to_cpu(parms->dw18_sgl_page_cnt);
+
+	/* max # of pages */
+	sli4->max_sgl_pages = (dw_sgl_pg_cnt & SLI4_PARAM_SGL_PAGE_CNT_MASK);
+
+	/* bit map of available sizes */
+	sli4->sgl_page_sizes = (dw_sgl_pg_cnt &
+				SLI4_PARAM_SGL_PAGE_SZS_MASK) >> 8;
+	/* ignore HLM here. Use value from REQUEST_FEATURES */
+	sli4->sge_supported_length = le32_to_cpu(parms->sge_supported_length);
+	sli4->params.sgl_pre_reg_required = (dw_loopback & SLI4_PARAM_SGLR);
+	/* default to using pre-registered SGL's */
+	sli4->params.sgl_pre_registered = true;
+
+	sli4->params.perf_hint = dw_loopback & SLI4_PARAM_PHON;
+	sli4->params.perf_wq_id_association = (dw_loopback & SLI4_PARAM_PHWQ);
+
+	sli4->rq_batch = (le16_to_cpu(parms->dw15w1_rq_db_window) &
+			  SLI4_PARAM_RQ_DB_WINDOW_MASK) >> 12;
+
+	/* Use the highest available WQE size. */
+	if (((dw_wq_pg_cnt & SLI4_PARAM_WQE_SZS_MASK) >> 8) &
+	    SLI4_128BYTE_WQE_SUPPORT)
+		sli4->wqe_size = SLI4_WQE_EXT_BYTES;
+	else
+		sli4->wqe_size = SLI4_WQE_BYTES;
+
+	return EFC_SUCCESS;
+}
+
+static int
+sli_get_ctrl_attributes(struct sli4 *sli4)
+{
+	struct sli4_rsp_cmn_get_cntl_attributes *attr;
+	struct sli4_rsp_cmn_get_cntl_addl_attributes *add_attr;
+	struct efc_dma data;
+	u32 psize;
+
+	/*
+	 * Issue COMMON_GET_CNTL_ATTRIBUTES to get port_number. Temporarily
+	 * uses VPD DMA buffer as the response won't fit in the embedded
+	 * buffer.
+	 */
+	memset(sli4->vpd_data.virt, 0, sli4->vpd_data.size);
+	if (sli_cmd_common_get_cntl_attributes(sli4, sli4->bmbx.virt,
+				&sli4->vpd_data)) {
+		efc_log_err(sli4, "bad COMMON_GET_CNTL_ATTRIBUTES write\n");
+		return EFC_FAIL;
+	}
+
+	attr =	sli4->vpd_data.virt;
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "%s: bootstrap mailbox write fail\n",
+				__func__);
+		return EFC_FAIL;
+	}
+
+	if (attr->hdr.status) {
+		efc_log_err(sli4, "COMMON_GET_CNTL_ATTRIBUTES bad status %#x",
+		       attr->hdr.status);
+		efc_log_err(sli4, "additional status %#x\n",
+		       attr->hdr.additional_status);
+		return EFC_FAIL;
+	}
+
+	sli4->port_number = attr->port_num_type_flags & SLI4_CNTL_ATTR_PORTNUM;
+
+	memcpy(sli4->bios_version_string, attr->bios_version_str,
+	       sizeof(sli4->bios_version_string));
+
+	/* get additional attributes */
+	psize = sizeof(struct sli4_rsp_cmn_get_cntl_addl_attributes);
+	data.size = psize;
+	data.virt = dma_alloc_coherent(&sli4->pci->dev, data.size,
+				       &data.phys, GFP_DMA);
+	if (!data.virt) {
+		memset(&data, 0, sizeof(struct efc_dma));
+		efc_log_err(sli4, "Failed to allocate memory for GET_CNTL_ADDL_ATTR\n");
+		return EFC_FAIL;
+	}
+
+	if (sli_cmd_common_get_cntl_addl_attributes(sli4, sli4->bmbx.virt,
+						&data)) {
+		efc_log_err(sli4, "bad GET_CNTL_ADDL_ATTR write\n");
+		dma_free_coherent(&sli4->pci->dev, data.size,
+				  data.virt, data.phys);
+		return EFC_FAIL;
+	}
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "mailbox fail (GET_CNTL_ADDL_ATTR)\n");
+		dma_free_coherent(&sli4->pci->dev, data.size,
+				  data.virt, data.phys);
+		return EFC_FAIL;
+	}
+
+	add_attr = data.virt;
+	if (add_attr->hdr.status) {
+		efc_log_err(sli4, "GET_CNTL_ADDL_ATTR bad status %#x\n",
+		       add_attr->hdr.status);
+		dma_free_coherent(&sli4->pci->dev, data.size,
+				  data.virt, data.phys);
+		return EFC_FAIL;
+	}
+
+	memcpy(sli4->ipl_name, add_attr->ipl_file_name, sizeof(sli4->ipl_name));
+
+	efc_log_info(sli4, "IPL:%s\n", (char *)sli4->ipl_name);
+
+	dma_free_coherent(&sli4->pci->dev, data.size, data.virt,
+			  data.phys);
+	memset(&data, 0, sizeof(struct efc_dma));
+	return EFC_SUCCESS;
+}
+
+static int
+sli_get_fw_rev(struct sli4 *sli4)
+{
+	struct sli4_cmd_read_rev	*read_rev = sli4->bmbx.virt;
+
+	if (sli_cmd_read_rev(sli4, sli4->bmbx.virt, &sli4->vpd_data))
+		return EFC_FAIL;
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "bootstrap mailbox write fail (READ_REV)\n");
+		return EFC_FAIL;
+	}
+
+	if (le16_to_cpu(read_rev->hdr.status)) {
+		efc_log_err(sli4, "READ_REV bad status %#x\n",
+		       le16_to_cpu(read_rev->hdr.status));
+		return EFC_FAIL;
+	}
+
+	sli4->fw_rev[0] = le32_to_cpu(read_rev->first_fw_id);
+	memcpy(sli4->fw_name[0], read_rev->first_fw_name,
+		sizeof(sli4->fw_name[0]));
+
+	sli4->fw_rev[1] = le32_to_cpu(read_rev->second_fw_id);
+	memcpy(sli4->fw_name[1], read_rev->second_fw_name,
+	       sizeof(sli4->fw_name[1]));
+
+	sli4->hw_rev[0] = le32_to_cpu(read_rev->first_hw_rev);
+	sli4->hw_rev[1] = le32_to_cpu(read_rev->second_hw_rev);
+	sli4->hw_rev[2] = le32_to_cpu(read_rev->third_hw_rev);
+
+	efc_log_info(sli4, "FW1:%s (%08x) / FW2:%s (%08x)\n",
+		read_rev->first_fw_name, le32_to_cpu(read_rev->first_fw_id),
+		read_rev->second_fw_name, le32_to_cpu(read_rev->second_fw_id));
+
+	efc_log_info(sli4, "HW1: %08x / HW2: %08x\n",
+			le32_to_cpu(read_rev->first_hw_rev),
+			le32_to_cpu(read_rev->second_hw_rev));
+
+	/* Check that all VPD data was returned */
+	if (le32_to_cpu(read_rev->returned_vpd_length) !=
+	    le32_to_cpu(read_rev->actual_vpd_length)) {
+		efc_log_info(sli4, "VPD length: avail=%d return=%d actual=%d\n",
+			le32_to_cpu(read_rev->available_length_dword) &
+				    SLI4_READ_REV_AVAILABLE_LENGTH,
+			le32_to_cpu(read_rev->returned_vpd_length),
+			le32_to_cpu(read_rev->actual_vpd_length));
+	}
+	sli4->vpd_length = le32_to_cpu(read_rev->returned_vpd_length);
+	return EFC_SUCCESS;
+}
+
+static int
+sli_get_config(struct sli4 *sli4)
+{
+	struct sli4_rsp_cmn_get_port_name *port_name;
+	struct sli4_cmd_read_nvparms *read_nvparms;
+
+	/*
+	 * Read the device configuration
+	 */
+	if (sli_get_read_config(sli4))
+		return EFC_FAIL;
+
+	if (sli_get_sli4_parameters(sli4))
+		return EFC_FAIL;
+
+	if (sli_get_ctrl_attributes(sli4))
+		return EFC_FAIL;
+
+	if (sli_cmd_common_get_port_name(sli4, sli4->bmbx.virt))
+		return EFC_FAIL;
+
+	port_name = (struct sli4_rsp_cmn_get_port_name *)
+		    (((u8 *)sli4->bmbx.virt) +
+		    offsetof(struct sli4_cmd_sli_config, payload.embed));
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "bootstrap mailbox fail (GET_PORT_NAME)\n");
+		return EFC_FAIL;
+	}
+
+	sli4->port_name[0] = port_name->port_name[sli4->port_number];
+	sli4->port_name[1] = '\0';
+
+	if (sli_get_fw_rev(sli4))
+		return EFC_FAIL;
+
+	if (sli_cmd_read_nvparms(sli4, sli4->bmbx.virt)) {
+		efc_log_err(sli4, "bad READ_NVPARMS write\n");
+		return EFC_FAIL;
+	}
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "bootstrap mailbox fail (READ_NVPARMS)\n");
+		return EFC_FAIL;
+	}
+
+	read_nvparms = sli4->bmbx.virt;
+	if (le16_to_cpu(read_nvparms->hdr.status)) {
+		efc_log_err(sli4, "READ_NVPARMS bad status %#x\n",
+		       le16_to_cpu(read_nvparms->hdr.status));
+		return EFC_FAIL;
+	}
+
+	memcpy(sli4->wwpn, read_nvparms->wwpn, sizeof(sli4->wwpn));
+	memcpy(sli4->wwnn, read_nvparms->wwnn, sizeof(sli4->wwnn));
+
+	efc_log_info(sli4, "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+		sli4->wwpn[0], sli4->wwpn[1], sli4->wwpn[2], sli4->wwpn[3],
+		sli4->wwpn[4], sli4->wwpn[5], sli4->wwpn[6], sli4->wwpn[7]);
+	efc_log_info(sli4, "WWNN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+		sli4->wwnn[0], sli4->wwnn[1], sli4->wwnn[2], sli4->wwnn[3],
+		sli4->wwnn[4], sli4->wwnn[5], sli4->wwnn[6], sli4->wwnn[7]);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_setup(struct sli4 *sli4, void *os, struct pci_dev  *pdev,
+	  void __iomem *reg[])
+{
+	u32 intf = U32_MAX;
+	u32 pci_class_rev = 0;
+	u32 rev_id = 0;
+	u32 family = 0;
+	u32 asic_id = 0;
+	u32 i;
+	struct sli4_asic_entry_t *asic;
+
+	memset(sli4, 0, sizeof(struct sli4));
+
+	sli4->os = os;
+	sli4->pci = pdev;
+
+	for (i = 0; i < 6; i++)
+		sli4->reg[i] = reg[i];
+	/*
+	 * Read the SLI_INTF register to discover the register layout
+	 * and other capability information
+	 */
+	if (pci_read_config_dword(pdev, SLI4_INTF_REG, &intf))
+		return EFC_FAIL;
+
+	if ((intf & SLI4_INTF_VALID_MASK) != (u32)SLI4_INTF_VALID_VALUE) {
+		efc_log_err(sli4, "SLI_INTF is not valid\n");
+		return EFC_FAIL;
+	}
+
+	/* driver only support SLI-4 */
+	if ((intf & SLI4_INTF_REV_MASK) != SLI4_INTF_REV_S4) {
+		efc_log_err(sli4, "Unsupported SLI revision (intf=%#x)\n",
+		       intf);
+		return EFC_FAIL;
+	}
+
+	sli4->sli_family = intf & SLI4_INTF_FAMILY_MASK;
+
+	sli4->if_type = intf & SLI4_INTF_IF_TYPE_MASK;
+	efc_log_info(sli4, "status=%#x error1=%#x error2=%#x\n",
+		sli_reg_read_status(sli4),
+			sli_reg_read_err1(sli4),
+			sli_reg_read_err2(sli4));
+
+	/*
+	 * set the ASIC type and revision
+	 */
+	if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &pci_class_rev))
+		return EFC_FAIL;
+
+	rev_id = pci_class_rev & 0xff;
+	family = sli4->sli_family;
+	if (family == SLI4_FAMILY_CHECK_ASIC_TYPE) {
+		if (!pci_read_config_dword(pdev, SLI4_ASIC_ID_REG, &asic_id))
+			family = asic_id & SLI4_ASIC_GEN_MASK;
+	}
+
+	for (i = 0, asic = sli4_asic_table; i < ARRAY_SIZE(sli4_asic_table);
+	     i++, asic++) {
+		if (rev_id == asic->rev_id && family == asic->family) {
+			sli4->asic_type = family;
+			sli4->asic_rev = rev_id;
+			break;
+		}
+	}
+	/* Fail if no matching asic type/rev was found */
+	if (!sli4->asic_type || !sli4->asic_rev) {
+		efc_log_err(sli4, "no matching asic family/rev found: %02x/%02x\n",
+		       family, rev_id);
+		return EFC_FAIL;
+	}
+
+	/*
+	 * The bootstrap mailbox is equivalent to a MQ with a single 256 byte
+	 * entry, a CQ with a single 16 byte entry, and no event queue.
+	 * Alignment must be 16 bytes as the low order address bits in the
+	 * address register are also control / status.
+	 */
+	sli4->bmbx.size = SLI4_BMBX_SIZE + sizeof(struct sli4_mcqe);
+	sli4->bmbx.virt = dma_alloc_coherent(&pdev->dev, sli4->bmbx.size,
+					     &sli4->bmbx.phys, GFP_DMA);
+	if (!sli4->bmbx.virt) {
+		memset(&sli4->bmbx, 0, sizeof(struct efc_dma));
+		efc_log_err(sli4, "bootstrap mailbox allocation failed\n");
+		return EFC_FAIL;
+	}
+
+	if (sli4->bmbx.phys & SLI4_BMBX_MASK_LO) {
+		efc_log_err(sli4, "bad alignment for bootstrap mailbox\n");
+		return EFC_FAIL;
+	}
+
+	efc_log_info(sli4, "bmbx v=%p p=0x%x %08x s=%zd\n", sli4->bmbx.virt,
+		upper_32_bits(sli4->bmbx.phys),
+		      lower_32_bits(sli4->bmbx.phys), sli4->bmbx.size);
+
+	/* 4096 is arbitrary. What should this value actually be? */
+	sli4->vpd_data.size = 4096;
+	sli4->vpd_data.virt = dma_alloc_coherent(&pdev->dev,
+						 sli4->vpd_data.size,
+						 &sli4->vpd_data.phys,
+						 GFP_DMA);
+	if (!sli4->vpd_data.virt) {
+		memset(&sli4->vpd_data, 0, sizeof(struct efc_dma));
+		/* Note that failure isn't fatal in this specific case */
+		efc_log_info(sli4, "VPD buffer allocation failed\n");
+	}
+
+	if (!sli_fw_init(sli4)) {
+		efc_log_err(sli4, "FW initialization failed\n");
+		return EFC_FAIL;
+	}
+
+	/*
+	 * Set one of fcpi(initiator), fcpt(target), fcpc(combined) to true
+	 * in addition to any other desired features
+	 */
+	sli4->features = (SLI4_REQFEAT_IAAB | SLI4_REQFEAT_NPIV |
+				 SLI4_REQFEAT_DIF | SLI4_REQFEAT_VF |
+				 SLI4_REQFEAT_FCPC | SLI4_REQFEAT_IAAR |
+				 SLI4_REQFEAT_HLM | SLI4_REQFEAT_PERFH |
+				 SLI4_REQFEAT_RXSEQ | SLI4_REQFEAT_RXRI |
+				 SLI4_REQFEAT_MRQP);
+
+	/* use performance hints if available */
+	if (sli4->params.perf_hint)
+		sli4->features |= SLI4_REQFEAT_PERFH;
+
+	if (sli_request_features(sli4, &sli4->features, true))
+		return EFC_FAIL;
+
+	if (sli_get_config(sli4))
+		return EFC_FAIL;
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_init(struct sli4 *sli4)
+{
+	if (sli4->params.has_extents) {
+		efc_log_info(sli4, "extend allocation not supported\n");
+		return EFC_FAIL;
+	}
+
+	sli4->features &= (~SLI4_REQFEAT_HLM);
+	sli4->features &= (~SLI4_REQFEAT_RXSEQ);
+	sli4->features &= (~SLI4_REQFEAT_RXRI);
+
+	if (sli_request_features(sli4, &sli4->features, false))
+		return EFC_FAIL;
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_reset(struct sli4 *sli4)
+{
+	u32	i;
+
+	if (!sli_fw_init(sli4)) {
+		efc_log_crit(sli4, "FW initialization failed\n");
+		return EFC_FAIL;
+	}
+
+	kfree(sli4->ext[0].base);
+	sli4->ext[0].base = NULL;
+
+	for (i = 0; i < SLI4_RSRC_MAX; i++) {
+		kfree(sli4->ext[i].use_map);
+		sli4->ext[i].use_map = NULL;
+		sli4->ext[i].base = NULL;
+	}
+
+	return sli_get_config(sli4);
+}
+
+int
+sli_fw_reset(struct sli4 *sli4)
+{
+	/*
+	 * Firmware must be ready before issuing the reset.
+	 */
+	if (!sli_wait_for_fw_ready(sli4, SLI4_FW_READY_TIMEOUT_MSEC)) {
+		efc_log_crit(sli4, "FW status is NOT ready\n");
+		return EFC_FAIL;
+	}
+
+	/* Lancer uses PHYDEV_CONTROL */
+	writel(SLI4_PHYDEV_CTRL_FRST, (sli4->reg[0] + SLI4_PHYDEV_CTRL_REG));
+
+	/* wait for the FW to become ready after the reset */
+	if (!sli_wait_for_fw_ready(sli4, SLI4_FW_READY_TIMEOUT_MSEC)) {
+		efc_log_crit(sli4, "Failed to be ready after firmware reset\n");
+		return EFC_FAIL;
+	}
+	return EFC_SUCCESS;
+}
+
+void
+sli_teardown(struct sli4 *sli4)
+{
+	u32 i;
+
+	kfree(sli4->ext[0].base);
+	sli4->ext[0].base = NULL;
+
+	for (i = 0; i < SLI4_RSRC_MAX; i++) {
+		sli4->ext[i].base = NULL;
+
+		kfree(sli4->ext[i].use_map);
+		sli4->ext[i].use_map = NULL;
+	}
+
+	if (!sli_sliport_reset(sli4))
+		efc_log_err(sli4, "FW deinitialization failed\n");
+
+	dma_free_coherent(&sli4->pci->dev, sli4->vpd_data.size,
+			  sli4->vpd_data.virt, sli4->vpd_data.phys);
+	memset(&sli4->vpd_data, 0, sizeof(struct efc_dma));
+
+	dma_free_coherent(&sli4->pci->dev, sli4->bmbx.size,
+			  sli4->bmbx.virt, sli4->bmbx.phys);
+	memset(&sli4->bmbx, 0, sizeof(struct efc_dma));
+}
+
+int
+sli_callback(struct sli4 *sli4, enum sli4_callback which,
+	     void *func, void *arg)
+{
+	if (!func) {
+		efc_log_err(sli4, "bad parameter sli4=%p which=%#x func=%p\n",
+		       sli4, which, func);
+		return EFC_FAIL;
+	}
+
+	switch (which) {
+	case SLI4_CB_LINK:
+		sli4->link = func;
+		sli4->link_arg = arg;
+		break;
+	default:
+		efc_log_info(sli4, "unknown callback %#x\n", which);
+		return EFC_FAIL;
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_eq_modify_delay(struct sli4 *sli4, struct sli4_queue *eq,
+		    u32 num_eq, u32 shift, u32 delay_mult)
+{
+	sli_cmd_common_modify_eq_delay(sli4, sli4->bmbx.virt, eq, num_eq,
+				       shift, delay_mult);
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "bootstrap mailbox write fail (MODIFY EQ DELAY)\n");
+		return EFC_FAIL;
+	}
+	if (sli_res_sli_config(sli4, sli4->bmbx.virt)) {
+		efc_log_err(sli4, "bad status MODIFY EQ DELAY\n");
+		return EFC_FAIL;
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_resource_alloc(struct sli4 *sli4, enum sli4_resource rtype,
+		   u32 *rid, u32 *index)
+{
+	int rc = EFC_SUCCESS;
+	u32 size;
+	u32 ext_idx;
+	u32 item_idx;
+	u32 position;
+
+	*rid = U32_MAX;
+	*index = U32_MAX;
+
+	switch (rtype) {
+	case SLI4_RSRC_VFI:
+	case SLI4_RSRC_VPI:
+	case SLI4_RSRC_RPI:
+	case SLI4_RSRC_XRI:
+		position =
+		find_first_zero_bit(sli4->ext[rtype].use_map,
+				    sli4->ext[rtype].map_size);
+		if (position >= sli4->ext[rtype].map_size) {
+			efc_log_err(sli4, "out of resource %d (alloc=%d)\n",
+				    rtype, sli4->ext[rtype].n_alloc);
+			rc = EFC_FAIL;
+			break;
+		}
+		set_bit(position, sli4->ext[rtype].use_map);
+		*index = position;
+
+		size = sli4->ext[rtype].size;
+
+		ext_idx = *index / size;
+		item_idx   = *index % size;
+
+		*rid = sli4->ext[rtype].base[ext_idx] + item_idx;
+
+		sli4->ext[rtype].n_alloc++;
+		break;
+	default:
+		rc = EFC_FAIL;
+	}
+
+	return rc;
+}
+
+int
+sli_resource_free(struct sli4 *sli4, enum sli4_resource rtype, u32 rid)
+{
+	int rc = EFC_FAIL;
+	u32 x;
+	u32 size, *base;
+
+	switch (rtype) {
+	case SLI4_RSRC_VFI:
+	case SLI4_RSRC_VPI:
+	case SLI4_RSRC_RPI:
+	case SLI4_RSRC_XRI:
+		/*
+		 * Figure out which extent contains the resource ID. I.e. find
+		 * the extent such that
+		 *   extent->base <= resource ID < extent->base + extent->size
+		 */
+		base = sli4->ext[rtype].base;
+		size = sli4->ext[rtype].size;
+
+		/*
+		 * In the case of FW reset, this may be cleared
+		 * but the force_free path will still attempt to
+		 * free the resource. Prevent a NULL pointer access.
+		 */
+		if (!base)
+			break;
+
+		for (x = 0; x < sli4->ext[rtype].number; x++) {
+			if ((rid < base[x] || (rid >= (base[x] + size))))
+				continue;
+
+			rid -= base[x];
+			clear_bit((x * size) + rid, sli4->ext[rtype].use_map);
+			rc = EFC_SUCCESS;
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return rc;
+}
+
+int
+sli_resource_reset(struct sli4 *sli4, enum sli4_resource rtype)
+{
+	int rc = EFC_FAIL;
+	u32 i;
+
+	switch (rtype) {
+	case SLI4_RSRC_VFI:
+	case SLI4_RSRC_VPI:
+	case SLI4_RSRC_RPI:
+	case SLI4_RSRC_XRI:
+		for (i = 0; i < sli4->ext[rtype].map_size; i++)
+			clear_bit(i, sli4->ext[rtype].use_map);
+		rc = EFC_SUCCESS;
+		break;
+	default:
+		break;
+	}
+
+	return rc;
+}
+
+int sli_raise_ue(struct sli4 *sli4, u8 dump)
+{
+	u32 val = 0;
+
+	if (dump == SLI4_FUNC_DESC_DUMP) {
+		val = SLI4_PORT_CTRL_FDD | SLI4_PORT_CTRL_IP;
+		writel(val, (sli4->reg[0] + SLI4_PORT_CTRL_REG));
+	} else {
+		val = SLI4_PHYDEV_CTRL_FRST;
+
+		if (dump == SLI4_CHIP_LEVEL_DUMP)
+			val |= SLI4_PHYDEV_CTRL_DD;
+		writel(val, (sli4->reg[0] + SLI4_PHYDEV_CTRL_REG));
+	}
+
+	return EFC_SUCCESS;
+}
+
+int sli_dump_is_ready(struct sli4 *sli4)
+{
+	int rc = SLI4_DUMP_READY_STATUS_NOT_READY;
+	u32 port_val;
+	u32 bmbx_val;
+
+	/*
+	 * Ensure that the port is ready AND the mailbox is
+	 * ready before signaling that the dump is ready to go.
+	 */
+	port_val = sli_reg_read_status(sli4);
+	bmbx_val = readl(sli4->reg[0] + SLI4_BMBX_REG);
+
+	if ((bmbx_val & SLI4_BMBX_RDY) &&
+	    (port_val & SLI4_PORT_STATUS_RDY)) {
+		if (port_val & SLI4_PORT_STATUS_DIP)
+			rc = SLI4_DUMP_READY_STATUS_DD_PRESENT;
+		else if (port_val & SLI4_PORT_STATUS_FDP)
+			rc = SLI4_DUMP_READY_STATUS_FDB_PRESENT;
+	}
+
+	return rc;
+}
+
+bool sli_reset_required(struct sli4 *sli4)
+{
+	u32 val;
+
+	val = sli_reg_read_status(sli4);
+	return (val & SLI4_PORT_STATUS_RN);
+}
+
+int
+sli_cmd_post_sgl_pages(struct sli4 *sli4, void *buf, u16 xri,
+		       u32 xri_count, struct efc_dma *page0[],
+		       struct efc_dma *page1[], struct efc_dma *dma)
+{
+	struct sli4_rqst_post_sgl_pages *post = NULL;
+	u32 i;
+	__le32 req_len;
+
+	post = sli_config_cmd_init(sli4, buf,
+				   SLI4_CFG_PYLD_LENGTH(post_sgl_pages), dma);
+	if (!post)
+		return EFC_FAIL;
+
+	/* payload size calculation */
+	/* 4 = xri_start + xri_count */
+	/* xri_count = # of XRI's registered */
+	/* sizeof(uint64_t) = physical address size */
+	/* 2 = # of physical addresses per page set */
+	req_len = cpu_to_le32(4 + (xri_count * (sizeof(uint64_t) * 2)));
+	sli_cmd_fill_hdr(&post->hdr, SLI4_OPC_POST_SGL_PAGES, SLI4_SUBSYSTEM_FC,
+			 CMD_V0, req_len);
+	post->xri_start = cpu_to_le16(xri);
+	post->xri_count = cpu_to_le16(xri_count);
+
+	for (i = 0; i < xri_count; i++) {
+		post->page_set[i].page0_low  =
+				cpu_to_le32(lower_32_bits(page0[i]->phys));
+		post->page_set[i].page0_high =
+				cpu_to_le32(upper_32_bits(page0[i]->phys));
+	}
+
+	if (page1) {
+		for (i = 0; i < xri_count; i++) {
+			post->page_set[i].page1_low =
+				cpu_to_le32(lower_32_bits(page1[i]->phys));
+			post->page_set[i].page1_high =
+				cpu_to_le32(upper_32_bits(page1[i]->phys));
+		}
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_post_hdr_templates(struct sli4 *sli4, void *buf, struct efc_dma *dma,
+			   u16 rpi, struct efc_dma *payload_dma)
+{
+	struct sli4_rqst_post_hdr_templates *req = NULL;
+	uintptr_t phys = 0;
+	u32 i = 0;
+	u32 page_count, payload_size;
+
+	page_count = sli_page_count(dma->size, SLI_PAGE_SIZE);
+
+	payload_size = ((sizeof(struct sli4_rqst_post_hdr_templates) +
+		(page_count * SZ_DMAADDR)) - sizeof(struct sli4_rqst_hdr));
+
+	if (page_count > 16) {
+		/*
+		 * We can't fit more than 16 descriptors into an embedded mbox
+		 * command, it has to be non-embedded
+		 */
+		payload_dma->size = payload_size;
+		payload_dma->virt = dma_alloc_coherent(&sli4->pci->dev,
+						       payload_dma->size,
+					     &payload_dma->phys, GFP_DMA);
+		if (!payload_dma->virt) {
+			memset(payload_dma, 0, sizeof(struct efc_dma));
+			efc_log_err(sli4, "mbox payload memory allocation fail\n");
+			return EFC_FAIL;
+		}
+		req = sli_config_cmd_init(sli4, buf, payload_size, payload_dma);
+	} else {
+		req = sli_config_cmd_init(sli4, buf, payload_size, NULL);
+	}
+
+	if (!req)
+		return EFC_FAIL;
+
+	if (rpi == U16_MAX)
+		rpi = sli4->ext[SLI4_RSRC_RPI].base[0];
+
+	sli_cmd_fill_hdr(&req->hdr, SLI4_OPC_POST_HDR_TEMPLATES,
+			 SLI4_SUBSYSTEM_FC, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(post_hdr_templates));
+
+	req->rpi_offset = cpu_to_le16(rpi);
+	req->page_count = cpu_to_le16(page_count);
+	phys = dma->phys;
+	for (i = 0; i < page_count; i++) {
+		req->page_descriptor[i].low  = cpu_to_le32(lower_32_bits(phys));
+		req->page_descriptor[i].high = cpu_to_le32(upper_32_bits(phys));
+
+		phys += SLI_PAGE_SIZE;
+	}
+
+	return EFC_SUCCESS;
+}
+
+u32
+sli_fc_get_rpi_requirements(struct sli4 *sli4, u32 n_rpi)
+{
+	u32 bytes = 0;
+
+	/* Check if header templates needed */
+	if (sli4->params.hdr_template_req)
+		/* round up to a page */
+		bytes = round_up(n_rpi * SLI4_HDR_TEMPLATE_SIZE, SLI_PAGE_SIZE);
+
+	return bytes;
+}
+
+const char *
+sli_fc_get_status_string(u32 status)
+{
+	static struct {
+		u32 code;
+		const char *label;
+	} lookup[] = {
+		{SLI4_FC_WCQE_STATUS_SUCCESS,		"SUCCESS"},
+		{SLI4_FC_WCQE_STATUS_FCP_RSP_FAILURE,	"FCP_RSP_FAILURE"},
+		{SLI4_FC_WCQE_STATUS_REMOTE_STOP,	"REMOTE_STOP"},
+		{SLI4_FC_WCQE_STATUS_LOCAL_REJECT,	"LOCAL_REJECT"},
+		{SLI4_FC_WCQE_STATUS_NPORT_RJT,		"NPORT_RJT"},
+		{SLI4_FC_WCQE_STATUS_FABRIC_RJT,	"FABRIC_RJT"},
+		{SLI4_FC_WCQE_STATUS_NPORT_BSY,		"NPORT_BSY"},
+		{SLI4_FC_WCQE_STATUS_FABRIC_BSY,	"FABRIC_BSY"},
+		{SLI4_FC_WCQE_STATUS_LS_RJT,		"LS_RJT"},
+		{SLI4_FC_WCQE_STATUS_CMD_REJECT,	"CMD_REJECT"},
+		{SLI4_FC_WCQE_STATUS_FCP_TGT_LENCHECK,	"FCP_TGT_LENCHECK"},
+		{SLI4_FC_WCQE_STATUS_RQ_BUF_LEN_EXCEEDED, "BUF_LEN_EXCEEDED"},
+		{SLI4_FC_WCQE_STATUS_RQ_INSUFF_BUF_NEEDED,
+				"RQ_INSUFF_BUF_NEEDED"},
+		{SLI4_FC_WCQE_STATUS_RQ_INSUFF_FRM_DISC, "RQ_INSUFF_FRM_DESC"},
+		{SLI4_FC_WCQE_STATUS_RQ_DMA_FAILURE,	"RQ_DMA_FAILURE"},
+		{SLI4_FC_WCQE_STATUS_FCP_RSP_TRUNCATE,	"FCP_RSP_TRUNCATE"},
+		{SLI4_FC_WCQE_STATUS_DI_ERROR,		"DI_ERROR"},
+		{SLI4_FC_WCQE_STATUS_BA_RJT,		"BA_RJT"},
+		{SLI4_FC_WCQE_STATUS_RQ_INSUFF_XRI_NEEDED,
+				"RQ_INSUFF_XRI_NEEDED"},
+		{SLI4_FC_WCQE_STATUS_RQ_INSUFF_XRI_DISC, "INSUFF_XRI_DISC"},
+		{SLI4_FC_WCQE_STATUS_RX_ERROR_DETECT,	"RX_ERROR_DETECT"},
+		{SLI4_FC_WCQE_STATUS_RX_ABORT_REQUEST,	"RX_ABORT_REQUEST"},
+		};
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(lookup); i++) {
+		if (status == lookup[i].code)
+			return lookup[i].label;
+	}
+	return "unknown";
+}
diff --git a/drivers/scsi/elx/libefc_sli/sli4.h b/drivers/scsi/elx/libefc_sli/sli4.h
index 5bc9e8b8ffd1..94f1dc05ecd1 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.h
+++ b/drivers/scsi/elx/libefc_sli/sli4.h
@@ -3716,4 +3716,400 @@ sli_cmd_fill_hdr(struct sli4_rqst_hdr *hdr, u8 opc, u8 sub, u32 ver, __le32 len)
 	hdr->request_length = len;
 }
 
+/**
+ * Get / set parameter functions
+ */
+
+static inline u32
+sli_get_max_sge(struct sli4 *sli4)
+{
+	return sli4->sge_supported_length;
+}
+
+static inline u32
+sli_get_max_sgl(struct sli4 *sli4)
+{
+	if (sli4->sgl_page_sizes != 1) {
+		efc_log_err(sli4, "unsupported SGL page sizes %#x\n",
+			sli4->sgl_page_sizes);
+		return 0;
+	}
+
+	return (sli4->max_sgl_pages * SLI_PAGE_SIZE) / sizeof(struct sli4_sge);
+}
+
+static inline enum sli4_link_medium
+sli_get_medium(struct sli4 *sli4)
+{
+	switch (sli4->topology) {
+	case SLI4_READ_CFG_TOPO_FC:
+	case SLI4_READ_CFG_TOPO_FC_AL:
+	case SLI4_READ_CFG_TOPO_NON_FC_AL:
+		return SLI4_LINK_MEDIUM_FC;
+	default:
+		return SLI4_LINK_MEDIUM_MAX;
+	}
+}
+
+static inline int
+sli_set_topology(struct sli4 *sli4, u32 value)
+{
+	int	rc = 0;
+
+	switch (value) {
+	case SLI4_READ_CFG_TOPO_FC:
+	case SLI4_READ_CFG_TOPO_FC_AL:
+	case SLI4_READ_CFG_TOPO_NON_FC_AL:
+		sli4->topology = value;
+		break;
+	default:
+		efc_log_err(sli4, "unsupported topology %#x\n", value);
+		rc = -1;
+	}
+
+	return rc;
+}
+
+static inline u32
+sli_convert_mask_to_count(u32 method, u32 mask)
+{
+	u32 count = 0;
+
+	if (method) {
+		count = 1 << (31 - __builtin_clz(mask));
+		count *= 16;
+	} else {
+		count = mask;
+	}
+
+	return count;
+}
+
+static inline u32
+sli_reg_read_status(struct sli4 *sli)
+{
+	return readl(sli->reg[0] + SLI4_PORT_STATUS_REGOFF);
+}
+
+static inline int
+sli_fw_error_status(struct sli4 *sli4)
+{
+	return (sli_reg_read_status(sli4) & SLI4_PORT_STATUS_ERR) ? 1 : 0;
+}
+
+static inline u32
+sli_reg_read_err1(struct sli4 *sli)
+{
+	return readl(sli->reg[0] + SLI4_PORT_ERROR1);
+}
+
+static inline u32
+sli_reg_read_err2(struct sli4 *sli)
+{
+	return readl(sli->reg[0] + SLI4_PORT_ERROR2);
+}
+
+static inline int
+sli_fc_rqe_length(struct sli4 *sli4, void *cqe, u32 *len_hdr,
+		  u32 *len_data)
+{
+	struct sli4_fc_async_rcqe	*rcqe = cqe;
+
+	*len_hdr = *len_data = 0;
+
+	if (rcqe->status == SLI4_FC_ASYNC_RQ_SUCCESS) {
+		*len_hdr  = rcqe->hdpl_byte & SLI4_RACQE_HDPL;
+		*len_data = le16_to_cpu(rcqe->data_placement_length);
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+static inline u8
+sli_fc_rqe_fcfi(struct sli4 *sli4, void *cqe)
+{
+	u8 code = ((u8 *)cqe)[SLI4_CQE_CODE_OFFSET];
+	u8 fcfi = U8_MAX;
+
+	switch (code) {
+	case SLI4_CQE_CODE_RQ_ASYNC: {
+		struct sli4_fc_async_rcqe *rcqe = cqe;
+
+		fcfi = le16_to_cpu(rcqe->fcfi_rq_id_word) & SLI4_RACQE_FCFI;
+		break;
+	}
+	case SLI4_CQE_CODE_RQ_ASYNC_V1: {
+		struct sli4_fc_async_rcqe_v1 *rcqev1 = cqe;
+
+		fcfi = rcqev1->fcfi_byte & SLI4_RACQE_FCFI;
+		break;
+	}
+	case SLI4_CQE_CODE_OPTIMIZED_WRITE_CMD: {
+		struct sli4_fc_optimized_write_cmd_cqe *opt_wr = cqe;
+
+		fcfi = opt_wr->flags0 & SLI4_OCQE_FCFI;
+		break;
+	}
+	}
+
+	return fcfi;
+}
+
+/****************************************************************************
+ * Function prototypes
+ */
+int
+sli_cmd_config_link(struct sli4 *sli4, void *buf);
+int
+sli_cmd_down_link(struct sli4 *sli4, void *buf);
+int
+sli_cmd_dump_type4(struct sli4 *sli4, void *buf, u16 wki);
+int
+sli_cmd_common_read_transceiver_data(struct sli4 *sli4, void *buf,
+				     u32 page_num, struct efc_dma *dma);
+int
+sli_cmd_read_link_stats(struct sli4 *sli4, void *buf, u8 req_stats,
+			u8 clear_overflow_flags, u8 clear_all_counters);
+int
+sli_cmd_read_status(struct sli4 *sli4, void *buf, u8 clear);
+int
+sli_cmd_init_link(struct sli4 *sli4, void *buf, u32 speed,
+		  u8 reset_alpa);
+int
+sli_cmd_init_vfi(struct sli4 *sli4, void *buf, u16 vfi, u16 fcfi,
+		 u16 vpi);
+int
+sli_cmd_init_vpi(struct sli4 *sli4, void *buf, u16 vpi, u16 vfi);
+int
+sli_cmd_post_xri(struct sli4 *sli4, void *buf, u16 base, u16 cnt);
+int
+sli_cmd_release_xri(struct sli4 *sli4, void *buf, u8 num_xri);
+int
+sli_cmd_read_sparm64(struct sli4 *sli4, void *buf,
+		struct efc_dma *dma, u16 vpi);
+int
+sli_cmd_read_topology(struct sli4 *sli4, void *buf, struct efc_dma *dma);
+int
+sli_cmd_read_nvparms(struct sli4 *sli4, void *buf);
+int
+sli_cmd_write_nvparms(struct sli4 *sli4, void *buf, u8 *wwpn,
+		u8 *wwnn, u8 hard_alpa, u32 preferred_d_id);
+int
+sli_cmd_reg_fcfi(struct sli4 *sli4, void *buf, u16 index,
+		 struct sli4_cmd_rq_cfg *rq_cfg);
+int
+sli_cmd_reg_fcfi_mrq(struct sli4 *sli4, void *buf, u8 mode, u16 index,
+		     u8 rq_selection_policy, u8 mrq_bit_mask, u16 num_mrqs,
+		     struct sli4_cmd_rq_cfg *rq_cfg);
+int
+sli_cmd_reg_rpi(struct sli4 *sli4, void *buf, u32 rpi, u32 vpi, u32 fc_id,
+		struct efc_dma *dma, u8 update, u8 enable_t10_pi);
+int
+sli_cmd_unreg_fcfi(struct sli4 *sli4, void *buf, u16 indicator);
+int
+sli_cmd_unreg_rpi(struct sli4 *sli4, void *buf, u16 indicator,
+		  enum sli4_resource which, u32 fc_id);
+int
+sli_cmd_reg_vpi(struct sli4 *sli4, void *buf, u32 fc_id,
+		__be64 sli_wwpn, u16 vpi, u16 vfi, bool update);
+int
+sli_cmd_reg_vfi(struct sli4 *sli4, void *buf, size_t size,
+		u16 vfi, u16 fcfi, struct efc_dma dma,
+		u16 vpi, __be64 sli_wwpn, u32 fc_id);
+int
+sli_cmd_unreg_vpi(struct sli4 *sli4, void *buf, u16 id, u32 type);
+int
+sli_cmd_unreg_vfi(struct sli4 *sli4, void *buf, u16 idx, u32 type);
+int
+sli_cmd_common_nop(struct sli4 *sli4, void *buf, uint64_t context);
+int
+sli_cmd_common_get_resource_extent_info(struct sli4 *sli4, void *buf,
+					u16 rtype);
+int
+sli_cmd_common_get_sli4_parameters(struct sli4 *sli4, void *buf);
+int
+sli_cmd_common_write_object(struct sli4 *sli4, void *buf, u16 noc,
+		u16 eof, u32 len, u32 offset, char *name, struct efc_dma *dma);
+int
+sli_cmd_common_delete_object(struct sli4 *sli4, void *buf, char *object_name);
+int
+sli_cmd_common_read_object(struct sli4 *sli4, void *buf,
+		u32 length, u32 offset, char *name, struct efc_dma *dma);
+int
+sli_cmd_dmtf_exec_clp_cmd(struct sli4 *sli4, void *buf,
+		struct efc_dma *cmd, struct efc_dma *resp);
+int
+sli_cmd_common_set_dump_location(struct sli4 *sli4, void *buf,
+		bool query, bool is_buffer_list, struct efc_dma *dma, u8 fdb);
+int
+sli_cmd_common_set_features(struct sli4 *sli4, void *buf,
+			    u32 feature, u32 param_len, void *parameter);
+
+int sli_cqe_mq(struct sli4 *sli4, void *buf);
+int sli_cqe_async(struct sli4 *sli4, void *buf);
+
+int
+sli_setup(struct sli4 *sli4, void *os, struct pci_dev *pdev, void __iomem *r[]);
+void sli_calc_max_qentries(struct sli4 *sli4);
+int sli_init(struct sli4 *sli4);
+int sli_reset(struct sli4 *sli4);
+int sli_fw_reset(struct sli4 *sli4);
+void sli_teardown(struct sli4 *sli4);
+int
+sli_callback(struct sli4 *sli4, enum sli4_callback cb, void *func, void *arg);
+int
+sli_bmbx_command(struct sli4 *sli4);
+int
+__sli_queue_init(struct sli4 *sli4, struct sli4_queue *q, u32 qtype,
+		size_t size, u32 n_entries, u32 align);
+int
+__sli_create_queue(struct sli4 *sli4, struct sli4_queue *q);
+int
+sli_eq_modify_delay(struct sli4 *sli4, struct sli4_queue *eq, u32 num_eq,
+		u32 shift, u32 delay_mult);
+int
+sli_queue_alloc(struct sli4 *sli4, u32 qtype, struct sli4_queue *q,
+		u32 n_entries, struct sli4_queue *assoc);
+int
+sli_cq_alloc_set(struct sli4 *sli4, struct sli4_queue *qs[], u32 num_cqs,
+		u32 n_entries, struct sli4_queue *eqs[]);
+int
+sli_get_queue_entry_size(struct sli4 *sli4, u32 qtype);
+int
+sli_queue_free(struct sli4 *sli4, struct sli4_queue *q, u32 destroy_queues,
+		u32 free_memory);
+int
+sli_queue_eq_arm(struct sli4 *sli4, struct sli4_queue *q, bool arm);
+int
+sli_queue_arm(struct sli4 *sli4, struct sli4_queue *q, bool arm);
+
+int
+sli_wq_write(struct sli4 *sli4, struct sli4_queue *q, u8 *entry);
+int
+sli_mq_write(struct sli4 *sli4, struct sli4_queue *q, u8 *entry);
+int
+sli_rq_write(struct sli4 *sli4, struct sli4_queue *q, u8 *entry);
+int
+sli_eq_read(struct sli4 *sli4, struct sli4_queue *q, u8 *entry);
+int
+sli_cq_read(struct sli4 *sli4, struct sli4_queue *q, u8 *entry);
+int
+sli_mq_read(struct sli4 *sli4, struct sli4_queue *q, u8 *entry);
+int
+sli_resource_alloc(struct sli4 *sli4, enum sli4_resource rtype, u32 *rid,
+		u32 *index);
+int
+sli_resource_free(struct sli4 *sli4, enum sli4_resource rtype, u32 rid);
+int
+sli_resource_reset(struct sli4 *sli4, enum sli4_resource rtype);
+int
+sli_eq_parse(struct sli4 *sli4, u8 *buf, u16 *cq_id);
+int
+sli_cq_parse(struct sli4 *sli4, struct sli4_queue *cq, u8 *cqe,
+		enum sli4_qentry *etype, u16 *q_id);
+
+int sli_raise_ue(struct sli4 *sli4, u8 dump);
+int sli_dump_is_ready(struct sli4 *sli4);
+bool sli_reset_required(struct sli4 *sli4);
+bool sli_fw_ready(struct sli4 *sli4);
+
+int
+sli_fc_process_link_attention(struct sli4 *sli4, void *acqe);
+int
+sli_fc_cqe_parse(struct sli4 *sli4, struct sli4_queue *cq,
+		 u8 *cqe, enum sli4_qentry *etype,
+		 u16 *rid);
+u32 sli_fc_response_length(struct sli4 *sli4, u8 *cqe);
+u32 sli_fc_io_length(struct sli4 *sli4, u8 *cqe);
+int sli_fc_els_did(struct sli4 *sli4, u8 *cqe, u32 *d_id);
+u32 sli_fc_ext_status(struct sli4 *sli4, u8 *cqe);
+int
+sli_fc_rqe_rqid_and_index(struct sli4 *sli4, u8 *cqe, u16 *rq_id, u32 *index);
+int
+sli_cmd_wq_create(struct sli4 *sli4, void *buf,
+		struct efc_dma *qmem, u16 cq_id);
+int sli_cmd_post_sgl_pages(struct sli4 *sli4, void *buf, u16 xri,
+		u32 xri_count, struct efc_dma *page0[], struct efc_dma *page1[],
+		struct efc_dma *dma);
+int
+sli_cmd_post_hdr_templates(struct sli4 *sli4, void *buf,
+		struct efc_dma *dma, u16 rpi, struct efc_dma *payload_dma);
+int
+sli_fc_rq_alloc(struct sli4 *sli4, struct sli4_queue *q, u32 n_entries,
+		u32 buffer_size, struct sli4_queue *cq, bool is_hdr);
+int
+sli_fc_rq_set_alloc(struct sli4 *sli4, u32 num_rq_pairs, struct sli4_queue *q[],
+		u32 base_cq_id, u32 num, u32 hdr_buf_size, u32 data_buf_size);
+u32 sli_fc_get_rpi_requirements(struct sli4 *sli4, u32 n_rpi);
+int
+sli_abort_wqe(struct sli4 *sli4, void *buf, enum sli4_abort_type type,
+	      bool send_abts, u32 ids, u32 mask, u16 tag, u16 cq_id);
+
+int
+sli_send_frame_wqe(struct sli4 *sli4, void *buf, u8 sof, u8 eof,
+		u32 *hdr, struct efc_dma *payload, u32 req_len, u8 timeout,
+		u16 xri, u16 req_tag);
+
+int
+sli_xmit_els_rsp64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *rsp,
+		struct sli_els_params *params);
+
+int
+sli_els_request64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		struct sli_els_params *params);
+
+int
+sli_fcp_icmnd64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl, u16 xri,
+		u16 tag, u16 cq_id, u32 rpi, u32 rnode_fcid, u8 timeout);
+
+int
+sli_fcp_iread64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		u32 first_data_sge, u32 xfer_len, u16 xri,
+		u16 tag, u16 cq_id, u32 rpi, u32 rnode_fcid, u8 dif, u8 bs,
+		u8 timeout);
+
+int
+sli_fcp_iwrite64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		u32 first_data_sge, u32 xfer_len,
+		u32 first_burst, u16 xri, u16 tag, u16 cq_id, u32 rpi,
+		u32 rnode_fcid, u8 dif, u8 bs, u8 timeout);
+
+int
+sli_fcp_treceive64_wqe(struct sli4 *sli, void *buf, struct efc_dma *sgl,
+		       u32 first_data_sge, u16 cq_id, u8 dif, u8 bs,
+		       struct sli_fcp_tgt_params *params);
+int
+sli_fcp_cont_treceive64_wqe(struct sli4 *sli, void *buf, struct efc_dma *sgl,
+			u32 first_data_sge, u16 sec_xri, u16 cq_id, u8 dif,
+			u8 bs, struct sli_fcp_tgt_params *params);
+
+int
+sli_fcp_trsp64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		   u16 cq_id, u8 port_owned, struct sli_fcp_tgt_params *params);
+
+int
+sli_fcp_tsend64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		    u32 first_data_sge, u16 cq_id, u8 dif, u8 bs,
+		    struct sli_fcp_tgt_params *params);
+int
+sli_gen_request64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *sgl,
+		struct sli_ct_params *params);
+
+int
+sli_xmit_bls_rsp64_wqe(struct sli4 *sli4, void *buf,
+		struct sli_bls_payload *payload, struct sli_bls_params *params);
+
+int
+sli_xmit_sequence64_wqe(struct sli4 *sli4, void *buf, struct efc_dma *payload,
+		struct sli_ct_params *params);
+
+int
+sli_requeue_xri_wqe(struct sli4 *sli4, void *buf, u16 xri, u16 tag, u16 cq_id);
+void
+sli4_cmd_lowlevel_set_watchdog(struct sli4 *sli4, void *buf, size_t size,
+		u16 timeout);
+
+const char *sli_fc_get_status_string(u32 status);
+
 #endif /* !_SLI4_H */
-- 
2.26.2

