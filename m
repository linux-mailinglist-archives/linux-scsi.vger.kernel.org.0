Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C4E25DB
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Oct 2019 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407576AbfJWV41 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Oct 2019 17:56:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34414 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405999AbfJWV4Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Oct 2019 17:56:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so18570774wrr.1
        for <linux-scsi@vger.kernel.org>; Wed, 23 Oct 2019 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sJ8n5Nafv2CBMUVMvpXXfnULZkzNzYk+4UJiEvPn4mg=;
        b=XToL5X9mWK0kaKyTiBVCAvtYSYg9temG6l01D52tqLcNA8AaYX/rvI2NAeVoAr8WdS
         k/4lhiVsryi/psDEIBYrJ/ht/ip4OnEHcMeSHpF2tgbj1ZoQNOMX4wazCD2P8RF1ErDI
         UDdSLh8MquFUwPfinFCeJXneZc5em7H9E/Vx16l8aGX1RUipGk7388dXe6BUKNOTmXGL
         ieJ5dJItKq/Dv5+qyU0DFik54M/NeVRi6nQ6nSNTTvQ9cXAVp3cfxltpwXjoyt+Zm/hZ
         ASbQ1tsnGxF/InybYt+DokmYphwkYKt24mqSoIeoQd2fkgEmu8yMSpGP/iSupw26Jkc/
         Z73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sJ8n5Nafv2CBMUVMvpXXfnULZkzNzYk+4UJiEvPn4mg=;
        b=sDDO3f+wYr65kFd0STkswAl/wsrb4mt+RJ7zPivcJzbavileLFndGEvM61JW9UXspf
         Jl9ESXvSQ0dCKXIIZyfDDQoKH/hN6cLolso9vdSo77ImiE94NDjBAchJTfMR8RDku9Ty
         nrHEJLBlhFxfeCUu8ByusbQHYiGFasHaYlUU+VnYXGcskVLoEfD5IHZ08Rn8RKzvTXIR
         St7XHtCPO9kxCrbkckD/NCeUWgBOnLyNH+iz2aE59vEwlUP25EKttSJCeFOchBh+BJ7g
         mFN6CMilsbz617RLI0IvfNjoafLNyfUX2rj2c/KKE+N90MXSJNnDVzQOxscjkgQS3EKo
         tPMw==
X-Gm-Message-State: APjAAAWtbXuIwh56dBRbznZueXcf09T0GMIuOQa2c5+P4ipBT3LCBvJ3
        ILfrog5fe7Hp1A2nFYRLXqou06p/
X-Google-Smtp-Source: APXvYqyiwHVhrjeGq9/7y0EF7UWdODqt0GTuo85zKXY3SUFLP8HgP/6rYy1LJUhTU2YDwmGSy4okmg==
X-Received: by 2002:adf:9486:: with SMTP id 6mr750581wrr.28.1571867778827;
        Wed, 23 Oct 2019 14:56:18 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h17sm796775wme.6.2019.10.23.14.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 14:56:18 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [PATCH 07/32] elx: libefc_sli: APIs to setup SLI library
Date:   Wed, 23 Oct 2019 14:55:32 -0700
Message-Id: <20191023215557.12581-8-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191023215557.12581-1-jsmart2021@gmail.com>
References: <20191023215557.12581-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the libefc_sli SLI-4 library population.

This patch adds APIS to initialize the library, initialize
the SLI Port, reset firmware, terminate the SLI Port, and
terminate the library.

Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/elx/libefc_sli/sli4.c | 1472 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/elx/libefc_sli/sli4.h |  578 ++++++++++++++
 2 files changed, 2050 insertions(+)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 1306d0a335c6..e7e7ce6cbd90 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -6048,3 +6048,1475 @@ sli_cqe_async(struct sli4_s *sli4, void *buf)
 
 	return rc;
 }
+
+/**
+ * @ingroup sli
+ * @brief Determine if the chip FW is in a ready state
+ *
+ * @param sli4 SLI context.
+ *
+ * @return
+ * - 0 if call completed correctly and FW is not ready.
+ * - 1 if call completed correctly and FW is ready.
+ * - -1 if call failed.
+ */
+int
+sli_fw_ready(struct sli4_s *sli4)
+{
+	u32 val;
+	/*
+	 * Is firmware ready for operation? Check needed depends on IF_TYPE
+	 */
+	val = sli_reg_read_status(sli4);
+	return (val & SLI4_PORT_STATUS_RDY) ? 1 : 0;
+}
+
+/**
+ * @brief Initialize SLI Port control register.
+ *
+ * @param sli4 SLI context pointer.
+ * @param endian Endian value to write.
+ *
+ * @return Returns 0 on success, or a negative error code value on failure.
+ */
+
+static int
+sli_sliport_reset(struct sli4_s *sli4)
+{
+	u32 iter, val;
+	int rc = -1;
+
+	val = SLI4_PORT_CTRL_IP;
+	/* Initialize port, endian */
+	writel(val, (sli4->reg[0] + SLI4_PORT_CTRL_REG));
+
+	for (iter = 0; iter < 3000; iter++) {
+		mdelay(10);	/* 10 ms */
+		if (sli_fw_ready(sli4) == 1) {
+			rc = 0;
+			break;
+		}
+	}
+
+	if (rc != 0)
+		efc_log_crit(sli4, "port failed to become ready after initialization\n");
+
+	return rc;
+}
+/**
+ * @brief check to see if the FW is ready.
+ *
+ * @par Description
+ * Based on <i>SLI-4 Architecture Specification, Revision 4.x0-13 (2012).</i>.
+ *
+ * @param sli4 SLI context.
+ * @param timeout_ms Time, in milliseconds, to wait for the port to be ready
+ * before failing.
+ *
+ * @return Returns TRUE for ready, or FALSE otherwise.
+ */
+static bool
+sli_wait_for_fw_ready(struct sli4_s *sli4, u32 timeout_ms)
+{
+	u32 iter = timeout_ms / (SLI4_INIT_PORT_DELAY_US / 1000);
+	bool ready = false;
+
+	do {
+		iter--;
+		mdelay(10);	/* 10 ms */
+		if (sli_fw_ready(sli4) == 1)
+			ready = true;
+	} while (!ready && (iter > 0));
+
+	return ready;
+}
+
+/**
+ * @brief Initialize the firmware.
+ *
+ * @par Description
+ * Based on <i>SLI-4 Architecture Specification, Revision 4.x0-13 (2012).</i>.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return Returns 0 on success, or a non-zero value on failure.
+ */
+static int
+sli_fw_init(struct sli4_s *sli4)
+{
+	bool ready;
+
+	/*
+	 * Is firmware ready for operation?
+	 */
+	ready = sli_wait_for_fw_ready(sli4, SLI4_FW_READY_TIMEOUT_MSEC);
+	if (!ready) {
+		efc_log_crit(sli4, "FW status is NOT ready\n");
+		return -1;
+	}
+
+	/*
+	 * Reset port to a known state
+	 */
+	if (sli_sliport_reset(sli4))
+		return -1;
+
+	return 0;
+}
+
+/**
+ * @brief Terminate the firmware.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return Returns 0 on success, or a non-zero value on failure.
+ */
+static int
+sli_fw_term(struct sli4_s *sli4)
+{
+	/* type 2 etc. use SLIPORT_CONTROL to initialize port */
+	sli_sliport_reset(sli4);
+	return 0;
+}
+
+static int
+sli_request_features(struct sli4_s *sli4, u32 *features, bool query)
+{
+	if (!sli_cmd_request_features(sli4, sli4->bmbx.virt, SLI4_BMBX_SIZE,
+				     *features, query)) {
+		struct sli4_cmd_request_features_s *req_features =
+							sli4->bmbx.virt;
+
+		if (sli_bmbx_command(sli4)) {
+			efc_log_crit(sli4, "%s: bootstrap mailbox write fail\n",
+				__func__);
+			return -1;
+		}
+		if (le16_to_cpu(req_features->hdr.status)) {
+			efc_log_err(sli4, "REQUEST_FEATURES bad status %#x\n",
+			       le16_to_cpu(req_features->hdr.status));
+			return -1;
+		}
+		*features = le32_to_cpu(req_features->resp);
+	} else {
+		efc_log_err(sli4, "bad REQUEST_FEATURES write\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * @brief Calculate max queue entries.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return Returns 0 on success, or a non-zero value on failure.
+ */
+void
+sli_calc_max_qentries(struct sli4_s *sli4)
+{
+	enum sli4_qtype_e q;
+	u32 alloc_size, qentries, qentry_size;
+
+	for (q = SLI_QTYPE_EQ; q < SLI_QTYPE_MAX; q++) {
+		sli4->qinfo.max_qentries[q] =
+			sli_convert_mask_to_count(sli4->qinfo.count_method[q],
+						  sli4->qinfo.count_mask[q]);
+	}
+
+	/* single, continguous DMA allocations will be called for each queue
+	 * of size (max_qentries * queue entry size); since these can be large,
+	 * check against the OS max DMA allocation size
+	 */
+	for (q = SLI_QTYPE_EQ; q < SLI_QTYPE_MAX; q++) {
+		qentries = sli4->qinfo.max_qentries[q];
+		qentry_size = sli_get_queue_entry_size(sli4, q);
+		alloc_size = qentries * qentry_size;
+
+		efc_log_info(sli4, "[%s]: max_qentries from %d to %d\n",
+			     SLI_QNAME[q],
+			     sli4->qinfo.max_qentries[q], qentries);
+		sli4->qinfo.max_qentries[q] = qentries;
+	}
+}
+
+static int
+sli_get_config(struct sli4_s *sli4)
+{
+	struct efc_dma_s data;
+	u32 psize;
+
+	/*
+	 * Read the device configuration
+	 */
+	if (!sli_cmd_read_config(sli4, sli4->bmbx.virt, SLI4_BMBX_SIZE)) {
+		struct sli4_rsp_read_config_s	*read_config = sli4->bmbx.virt;
+		u32 i;
+		u32 total, total_size;
+
+		if (sli_bmbx_command(sli4)) {
+			efc_log_crit(sli4, "bootstrap mailbox fail (READ_CONFIG)\n");
+			return -1;
+		}
+		if (le16_to_cpu(read_config->hdr.status)) {
+			efc_log_err(sli4, "READ_CONFIG bad status %#x\n",
+			       le16_to_cpu(read_config->hdr.status));
+			return -1;
+		}
+
+		sli4->has_extents =
+			le32_to_cpu(read_config->ext_dword) &
+				    SLI4_READ_CFG_RESP_RESOURCE_EXT;
+		if (!sli4->has_extents) {
+			u32	i = 0, size = 0;
+			u32	*base = sli4->extent[0].base;
+
+			if (!base) {
+				size = SLI_RSRC_MAX * sizeof(u32);
+				base = kzalloc(size, GFP_ATOMIC);
+				if (!base)
+					return -1;
+
+				memset(base, 0,
+				       SLI_RSRC_MAX * sizeof(u32));
+			}
+
+			for (i = 0; i < SLI_RSRC_MAX; i++) {
+				sli4->extent[i].number = 1;
+				sli4->extent[i].n_alloc = 0;
+				sli4->extent[i].base = &base[i];
+			}
+
+			sli4->extent[SLI_RSRC_VFI].base[0] =
+				le16_to_cpu(read_config->vfi_base);
+			sli4->extent[SLI_RSRC_VFI].size =
+				le16_to_cpu(read_config->vfi_count);
+
+			sli4->extent[SLI_RSRC_VPI].base[0] =
+				le16_to_cpu(read_config->vpi_base);
+			sli4->extent[SLI_RSRC_VPI].size =
+				le16_to_cpu(read_config->vpi_count);
+
+			sli4->extent[SLI_RSRC_RPI].base[0] =
+				le16_to_cpu(read_config->rpi_base);
+			sli4->extent[SLI_RSRC_RPI].size =
+				le16_to_cpu(read_config->rpi_count);
+
+			sli4->extent[SLI_RSRC_XRI].base[0] =
+				le16_to_cpu(read_config->xri_base);
+			sli4->extent[SLI_RSRC_XRI].size =
+				le16_to_cpu(read_config->xri_count);
+
+			sli4->extent[SLI_RSRC_FCFI].base[0] = 0;
+			sli4->extent[SLI_RSRC_FCFI].size =
+				le16_to_cpu(read_config->fcfi_count);
+		} else {
+			;
+		}
+
+		for (i = 0; i < SLI_RSRC_MAX; i++) {
+			total = sli4->extent[i].number *
+				sli4->extent[i].size;
+			total_size = BITS_TO_LONGS(total) * sizeof(long);
+			sli4->extent[i].use_map =
+				kzalloc(total_size, GFP_ATOMIC);
+			if (!sli4->extent[i].use_map) {
+				efc_log_err(sli4, "bitmap memory allocation failed %d\n",
+				       i);
+				return -1;
+			}
+			sli4->extent[i].map_size = total;
+		}
+
+		sli4->topology =
+				(le32_to_cpu(read_config->topology_dword) &
+				 SLI4_READ_CFG_RESP_TOPOLOGY) >> 24;
+		switch (sli4->topology) {
+		case SLI4_READ_CFG_TOPO_FC:
+			efc_log_info(sli4, "FC (unknown)\n");
+			break;
+		case SLI4_READ_CFG_TOPO_FC_DA:
+			efc_log_info(sli4, "FC (direct attach)\n");
+			break;
+		case SLI4_READ_CFG_TOPO_FC_AL:
+			efc_log_info(sli4, "FC (arbitrated loop)\n");
+			break;
+		default:
+			efc_log_info(sli4, "bad topology %#x\n",
+				sli4->topology);
+		}
+
+		sli4->e_d_tov = le16_to_cpu(read_config->e_d_tov);
+		sli4->r_a_tov = le16_to_cpu(read_config->r_a_tov);
+
+		sli4->link_module_type = le16_to_cpu(read_config->lmt);
+
+		sli4->qinfo.max_qcount[SLI_QTYPE_EQ] =
+				le16_to_cpu(read_config->eq_count);
+		sli4->qinfo.max_qcount[SLI_QTYPE_CQ] =
+				le16_to_cpu(read_config->cq_count);
+		sli4->qinfo.max_qcount[SLI_QTYPE_WQ] =
+				le16_to_cpu(read_config->wq_count);
+		sli4->qinfo.max_qcount[SLI_QTYPE_RQ] =
+				le16_to_cpu(read_config->rq_count);
+
+		/*
+		 * READ_CONFIG doesn't give the max number of MQ. Applications
+		 * will typically want 1, but we may need another at some future
+		 * date. Dummy up a "max" MQ count here.
+		 */
+		sli4->qinfo.max_qcount[SLI_QTYPE_MQ] = SLI_USER_MQ_COUNT;
+	} else {
+		efc_log_err(sli4, "bad READ_CONFIG write\n");
+		return -1;
+	}
+
+	if (!sli_cmd_common_get_sli4_parameters(sli4, sli4->bmbx.virt,
+					       SLI4_BMBX_SIZE)) {
+		struct sli4_rsp_cmn_get_sli4_params_s	*parms =
+			(struct sli4_rsp_cmn_get_sli4_params_s *)
+			(((u8 *)sli4->bmbx.virt) +
+			offsetof(struct sli4_cmd_sli_config_s, payload.embed));
+		u32 dwflags_loopback;
+		u32 dwflags_eq_page_cnt;
+		u32 dwflags_cq_page_cnt;
+		u32 dwflags_mq_page_cnt;
+		u32 dwflags_wq_page_cnt;
+		u32 dwflags_rq_page_cnt;
+		u32 dwflags_sgl_page_cnt;
+
+		if (sli_bmbx_command(sli4)) {
+			efc_log_crit(sli4, "%s: bootstrap mailbox write fail\n",
+				__func__);
+			return -1;
+		} else if (parms->hdr.status) {
+			efc_log_err(sli4, "COMMON_GET_SLI4_PARAMETERS bad status %#x",
+			       parms->hdr.status);
+			efc_log_err(sli4, "additional status %#x\n",
+			       parms->hdr.additional_status);
+			return -1;
+		}
+
+		dwflags_loopback = le32_to_cpu(parms->dw16_loopback_scope);
+		dwflags_eq_page_cnt = le32_to_cpu(parms->dw6_eq_page_cnt);
+		dwflags_cq_page_cnt = le32_to_cpu(parms->dw8_cq_page_cnt);
+		dwflags_mq_page_cnt = le32_to_cpu(parms->dw10_mq_page_cnt);
+		dwflags_wq_page_cnt = le32_to_cpu(parms->dw12_wq_page_cnt);
+		dwflags_rq_page_cnt = le32_to_cpu(parms->dw14_rq_page_cnt);
+
+		sli4->auto_reg =
+			(dwflags_loopback & RSP_GET_PARAM_AREG);
+		sli4->auto_xfer_rdy =
+			(dwflags_loopback & RSP_GET_PARAM_AGXF);
+		sli4->hdr_template_req =
+			(dwflags_loopback & RSP_GET_PARAM_HDRR);
+		sli4->t10_dif_inline_capable =
+			(dwflags_loopback & RSP_GET_PARAM_TIMM);
+		sli4->t10_dif_separate_capable =
+			(dwflags_loopback & RSP_GET_PARAM_TSMM);
+
+		sli4->mq_create_version =
+				GET_Q_CREATE_VERSION(dwflags_mq_page_cnt);
+		sli4->cq_create_version =
+				GET_Q_CREATE_VERSION(dwflags_cq_page_cnt);
+
+		sli4->rq_min_buf_size =
+			le16_to_cpu(parms->min_rq_buffer_size);
+		sli4->rq_max_buf_size =
+			le32_to_cpu(parms->max_rq_buffer_size);
+
+		sli4->qinfo.qpage_count[SLI_QTYPE_EQ] =
+			(dwflags_eq_page_cnt & RSP_GET_PARAM_EQ_PAGE_CNT_MASK);
+		sli4->qinfo.qpage_count[SLI_QTYPE_CQ] =
+			(dwflags_cq_page_cnt & RSP_GET_PARAM_CQ_PAGE_CNT_MASK);
+		sli4->qinfo.qpage_count[SLI_QTYPE_MQ] =
+			(dwflags_mq_page_cnt & RSP_GET_PARAM_MQ_PAGE_CNT_MASK);
+		sli4->qinfo.qpage_count[SLI_QTYPE_WQ] =
+			(dwflags_wq_page_cnt & RSP_GET_PARAM_WQ_PAGE_CNT_MASK);
+		sli4->qinfo.qpage_count[SLI_QTYPE_RQ] =
+			(dwflags_rq_page_cnt & RSP_GET_PARAM_RQ_PAGE_CNT_MASK);
+
+		/* save count methods and masks for each queue type */
+
+		sli4->qinfo.count_mask[SLI_QTYPE_EQ] =
+				le16_to_cpu(parms->eqe_count_mask);
+		sli4->qinfo.count_method[SLI_QTYPE_EQ] =
+				GET_Q_CNT_METHOD(dwflags_eq_page_cnt);
+
+		sli4->qinfo.count_mask[SLI_QTYPE_CQ] =
+				le16_to_cpu(parms->cqe_count_mask);
+		sli4->qinfo.count_method[SLI_QTYPE_CQ] =
+				GET_Q_CNT_METHOD(dwflags_cq_page_cnt);
+
+		sli4->qinfo.count_mask[SLI_QTYPE_MQ] =
+				le16_to_cpu(parms->mqe_count_mask);
+		sli4->qinfo.count_method[SLI_QTYPE_MQ] =
+				GET_Q_CNT_METHOD(dwflags_mq_page_cnt);
+
+		sli4->qinfo.count_mask[SLI_QTYPE_WQ] =
+				le16_to_cpu(parms->wqe_count_mask);
+		sli4->qinfo.count_method[SLI_QTYPE_WQ] =
+				GET_Q_CNT_METHOD(dwflags_wq_page_cnt);
+
+		sli4->qinfo.count_mask[SLI_QTYPE_RQ] =
+				le16_to_cpu(parms->rqe_count_mask);
+		sli4->qinfo.count_method[SLI_QTYPE_RQ] =
+				GET_Q_CNT_METHOD(dwflags_rq_page_cnt);
+
+		/* now calculate max queue entries */
+		sli_calc_max_qentries(sli4);
+
+		dwflags_sgl_page_cnt = le32_to_cpu(parms->dw18_sgl_page_cnt);
+
+		/* max # of pages */
+		sli4->max_sgl_pages =
+				(dwflags_sgl_page_cnt &
+				 RSP_GET_PARAM_SGL_PAGE_CNT_MASK);
+
+		/* bit map of available sizes */
+		sli4->sgl_page_sizes =
+				(dwflags_sgl_page_cnt &
+				 RSP_GET_PARAM_SGL_PAGE_SZS_MASK) >> 8;
+		/* ignore HLM here. Use value from REQUEST_FEATURES */
+		sli4->sge_supported_length =
+				le32_to_cpu(parms->sge_supported_length);
+		sli4->sgl_pre_registration_required =
+			(dwflags_loopback & RSP_GET_PARAM_SGLR);
+		/* default to using pre-registered SGL's */
+		sli4->sgl_pre_registered = true;
+
+		sli4->perf_hint =
+			(dwflags_loopback & RSP_GET_PARAM_PHON);
+		sli4->perf_wq_id_association =
+			(dwflags_loopback & RSP_GET_PARAM_PHWQ);
+
+		sli4->rq_batch =
+			(le16_to_cpu(parms->dw15w1_rq_db_window) &
+			 RSP_GET_PARAM_RQ_DB_WINDOW_MASK) >> 12;
+
+		/* Use the highest available WQE size. */
+		if (((dwflags_wq_page_cnt &
+		    RSP_GET_PARAM_WQE_SZS_MASK) >> 8) &
+		    SLI4_128BYTE_WQE_SUPPORT)
+			sli4->wqe_size = SLI4_WQE_EXT_BYTES;
+		else
+			sli4->wqe_size = SLI4_WQE_BYTES;
+	}
+
+	sli4->port_number = 0;
+
+	/*
+	 * Issue COMMON_GET_CNTL_ATTRIBUTES to get port_number. Temporarily
+	 * uses VPD DMA buffer as the response won't fit in the embedded
+	 * buffer.
+	 */
+	if (!sli_cmd_common_get_cntl_attributes(sli4, sli4->bmbx.virt,
+					       SLI4_BMBX_SIZE,
+					       &sli4->vpd_data)) {
+		struct sli4_rsp_cmn_get_cntl_attributes_s *attr =
+			sli4->vpd_data.virt;
+
+		if (sli_bmbx_command(sli4)) {
+			efc_log_crit(sli4, "%s: bootstrap mailbox write fail\n",
+				__func__);
+			return -1;
+		} else if (attr->hdr.status) {
+			efc_log_err(sli4, "COMMON_GET_CNTL_ATTRIBUTES bad status %#x",
+			       attr->hdr.status);
+			efc_log_err(sli4, "additional status %#x\n",
+			       attr->hdr.additional_status);
+			return -1;
+		}
+
+		sli4->port_number = (attr->port_num_type_flags &
+					    SLI4_CNTL_ATTR_PORTNUM);
+
+		memcpy(sli4->bios_version_string,
+		       attr->bios_version_str,
+		       sizeof(sli4->bios_version_string));
+	} else {
+		efc_log_err(sli4, "bad COMMON_GET_CNTL_ATTRIBUTES write\n");
+		return -1;
+	}
+
+	psize = sizeof(struct sli4_rsp_cmn_get_cntl_addl_attributes_s);
+	data.size = psize;
+	data.virt = dma_alloc_coherent(&sli4->pcidev->dev, data.size,
+				       &data.phys, GFP_DMA);
+	if (!data.virt) {
+		memset(&data, 0, sizeof(struct efc_dma_s));
+		efc_log_err(sli4, "Failed to allocate memory for GET_CNTL_ADDL_ATTR\n");
+	} else {
+		if (!sli_cmd_common_get_cntl_addl_attributes(sli4,
+							    sli4->bmbx.virt,
+							    SLI4_BMBX_SIZE,
+							    &data)) {
+			struct sli4_rsp_cmn_get_cntl_addl_attributes_s *attr;
+
+			attr = data.virt;
+			if (sli_bmbx_command(sli4)) {
+				efc_log_crit(sli4, "mailbox fail (GET_CNTL_ADDL_ATTR)\n");
+				dma_free_coherent(&sli4->pcidev->dev, data.size,
+						  data.virt, data.phys);
+				return -1;
+			}
+			if (attr->hdr.status) {
+				efc_log_err(sli4, "GET_CNTL_ADDL_ATTR bad status %#x\n",
+				       attr->hdr.status);
+				dma_free_coherent(&sli4->pcidev->dev, data.size,
+						  data.virt, data.phys);
+				return -1;
+			}
+
+			memcpy(sli4->ipl_name, attr->ipl_file_name,
+			       sizeof(sli4->ipl_name));
+
+			efc_log_info(sli4, "IPL:%s\n",
+				(char *)sli4->ipl_name);
+		} else {
+			efc_log_err(sli4, "bad GET_CNTL_ADDL_ATTR write\n");
+			dma_free_coherent(&sli4->pcidev->dev, data.size,
+					  data.virt, data.phys);
+			return -1;
+		}
+
+		dma_free_coherent(&sli4->pcidev->dev, data.size, data.virt,
+				  data.phys);
+		memset(&data, 0, sizeof(struct efc_dma_s));
+	}
+
+	if (!sli_cmd_common_get_port_name(sli4, sli4->bmbx.virt,
+					 SLI4_BMBX_SIZE)) {
+		struct sli4_rsp_cmn_get_port_name_s	*port_name =
+			(struct sli4_rsp_cmn_get_port_name_s *)
+			(((u8 *)sli4->bmbx.virt) +
+			offsetof(struct sli4_cmd_sli_config_s, payload.embed));
+
+		if (sli_bmbx_command(sli4)) {
+			efc_log_crit(sli4, "%s: bootstrap mailbox write fail\n",
+				__func__);
+			return -1;
+		}
+
+		sli4->port_name[0] =
+			port_name->port_name[sli4->port_number];
+	}
+	sli4->port_name[1] = '\0';
+
+	if (!sli_cmd_read_rev(sli4, sli4->bmbx.virt, SLI4_BMBX_SIZE,
+			     &sli4->vpd_data)) {
+		struct sli4_cmd_read_rev_s	*read_rev = sli4->bmbx.virt;
+
+		if (sli_bmbx_command(sli4)) {
+			efc_log_crit(sli4, "bootstrap mailbox write fail (READ_REV)\n");
+			return -1;
+		}
+		if (le16_to_cpu(read_rev->hdr.status)) {
+			efc_log_err(sli4, "READ_REV bad status %#x\n",
+			       le16_to_cpu(read_rev->hdr.status));
+			return -1;
+		}
+
+		sli4->fw_rev[0] =
+				le32_to_cpu(read_rev->first_fw_id);
+		memcpy(sli4->fw_name[0], read_rev->first_fw_name,
+		       sizeof(sli4->fw_name[0]));
+
+		sli4->fw_rev[1] =
+				le32_to_cpu(read_rev->second_fw_id);
+		memcpy(sli4->fw_name[1], read_rev->second_fw_name,
+		       sizeof(sli4->fw_name[1]));
+
+		sli4->hw_rev[0] = le32_to_cpu(read_rev->first_hw_rev);
+		sli4->hw_rev[1] = le32_to_cpu(read_rev->second_hw_rev);
+		sli4->hw_rev[2] = le32_to_cpu(read_rev->third_hw_rev);
+
+		efc_log_info(sli4, "FW1:%s (%08x) / FW2:%s (%08x)\n",
+			read_rev->first_fw_name,
+			      le32_to_cpu(read_rev->first_fw_id),
+			      read_rev->second_fw_name,
+			      le32_to_cpu(read_rev->second_fw_id));
+
+		efc_log_info(sli4, "HW1: %08x / HW2: %08x\n",
+			le32_to_cpu(read_rev->first_hw_rev),
+			      le32_to_cpu(read_rev->second_hw_rev));
+
+		/* Check that all VPD data was returned */
+		if (le32_to_cpu(read_rev->returned_vpd_length) !=
+		    le32_to_cpu(read_rev->actual_vpd_length)) {
+			efc_log_info(sli4, "VPD length: avail=%d returned=%d actual=%d\n",
+				le32_to_cpu(read_rev->available_length_dword) &
+					    SLI4_READ_REV_AVAILABLE_LENGTH,
+				le32_to_cpu(read_rev->returned_vpd_length),
+				le32_to_cpu(read_rev->actual_vpd_length));
+		}
+		sli4->vpd_length = le32_to_cpu(read_rev->returned_vpd_length);
+	} else {
+		efc_log_err(sli4, "bad READ_REV write\n");
+		return -1;
+	}
+
+	if (!sli_cmd_read_nvparms(sli4, sli4->bmbx.virt, SLI4_BMBX_SIZE)) {
+		struct sli4_cmd_read_nvparms_s *read_nvparms = sli4->bmbx.virt;
+
+		if (sli_bmbx_command(sli4)) {
+			efc_log_crit(sli4, "bootstrap mailbox fail (READ_NVPARMS)\n");
+			return -1;
+		}
+		if (le16_to_cpu(read_nvparms->hdr.status)) {
+			efc_log_err(sli4, "READ_NVPARMS bad status %#x\n",
+			       le16_to_cpu(read_nvparms->hdr.status));
+			return -1;
+		}
+
+		memcpy(sli4->wwpn, read_nvparms->wwpn,
+		       sizeof(sli4->wwpn));
+		memcpy(sli4->wwnn, read_nvparms->wwnn,
+		       sizeof(sli4->wwnn));
+
+		efc_log_info(sli4, "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+			sli4->wwpn[0],
+			      sli4->wwpn[1],
+			      sli4->wwpn[2],
+			      sli4->wwpn[3],
+			      sli4->wwpn[4],
+			      sli4->wwpn[5],
+			      sli4->wwpn[6],
+			      sli4->wwpn[7]);
+		efc_log_info(sli4, "WWNN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+			sli4->wwnn[0],
+			      sli4->wwnn[1],
+			      sli4->wwnn[2],
+			      sli4->wwnn[3],
+			      sli4->wwnn[4],
+			      sli4->wwnn[5],
+			      sli4->wwnn[6],
+			      sli4->wwnn[7]);
+	} else {
+		efc_log_err(sli4, "bad READ_NVPARMS write\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Public functions
+ */
+
+/**
+ * @ingroup sli
+ * @brief Set up the SLI context.
+ *
+ * @param sli4 SLI context.
+ * @param os Device abstraction.
+ * @param port_type Protocol type of port (for example, FC and NIC).
+ *
+ * @return Returns 0 on success, or a non-zero value on failure.
+ */
+int
+sli_setup(struct sli4_s *sli4, void *os, struct pci_dev  *pdev,
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
+	memset(sli4, 0, sizeof(struct sli4_s));
+
+	sli4->os = os;
+	sli4->pcidev = pdev;
+
+	for (i = 0; i < 6; i++)
+		sli4->reg[i] = reg[i];
+	/*
+	 * Read the SLI_INTF register to discover the register layout
+	 * and other capability information
+	 */
+	pci_read_config_dword(pdev, SLI4_INTF_REG, &intf);
+
+	if ((intf & SLI4_INTF_VALID_MASK) != (u32)SLI4_INTF_VALID_VALUE) {
+		efc_log_err(sli4, "SLI_INTF is not valid\n");
+		return -1;
+	}
+
+	/* driver only support SLI-4 */
+	if ((intf & SLI4_INTF_REV_MASK) != SLI4_INTF_REV_S4) {
+		efc_log_err(sli4, "Unsupported SLI revision (intf=%#x)\n",
+		       intf);
+		return -1;
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
+	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &pci_class_rev);
+	rev_id = pci_class_rev & 0xff;
+	family = sli4->sli_family;
+	if (family == SLI4_FAMILY_CHECK_ASIC_TYPE) {
+		pci_read_config_dword(pdev, SLI4_ASIC_ID_REG, &asic_id);
+
+		family = asic_id & SLI4_ASIC_GEN_MASK;
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
+		return -1;
+	}
+
+	/*
+	 * The bootstrap mailbox is equivalent to a MQ with a single 256 byte
+	 * entry, a CQ with a single 16 byte entry, and no event queue.
+	 * Alignment must be 16 bytes as the low order address bits in the
+	 * address register are also control / status.
+	 */
+	sli4->bmbx.size = SLI4_BMBX_SIZE + sizeof(struct sli4_mcqe_s);
+	sli4->bmbx.virt = dma_alloc_coherent(&pdev->dev, sli4->bmbx.size,
+					     &sli4->bmbx.phys, GFP_DMA);
+	if (!sli4->bmbx.virt) {
+		memset(&sli4->bmbx, 0, sizeof(struct efc_dma_s));
+		efc_log_err(sli4, "bootstrap mailbox allocation failed\n");
+		return -1;
+	}
+
+	if (sli4->bmbx.phys & SLI4_BMBX_MASK_LO) {
+		efc_log_err(sli4, "bad alignment for bootstrap mailbox\n");
+		return -1;
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
+		memset(&sli4->vpd_data, 0, sizeof(struct efc_dma_s));
+		/* Note that failure isn't fatal in this specific case */
+		efc_log_info(sli4, "VPD buffer allocation failed\n");
+	}
+
+	if (sli_fw_init(sli4)) {
+		efc_log_err(sli4, "FW initialization failed\n");
+		return -1;
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
+	if (sli4->perf_hint)
+		sli4->features |= SLI4_REQFEAT_PERFH;
+
+	if (sli_request_features(sli4, &sli4->features, true))
+		return -1;
+
+	if (sli_get_config(sli4))
+		return -1;
+
+	return 0;
+}
+
+int
+sli_init(struct sli4_s *sli4)
+{
+	if (sli4->has_extents) {
+		efc_log_info(sli4, "XXX need to implement extent allocation\n");
+		return -1;
+	}
+
+	if (sli4->high_login_mode)
+		sli4->features |= SLI4_REQFEAT_HLM;
+	else
+		sli4->features &= (~SLI4_REQFEAT_HLM);
+	sli4->features &= (~SLI4_REQFEAT_RXSEQ);
+	sli4->features &= (~SLI4_REQFEAT_RXRI);
+
+	if (sli_request_features(sli4, &sli4->features, false))
+		return -1;
+
+	return 0;
+}
+
+int
+sli_reset(struct sli4_s *sli4)
+{
+	u32	i;
+
+	if (sli_fw_init(sli4)) {
+		efc_log_crit(sli4, "FW initialization failed\n");
+		return -1;
+	}
+
+	kfree(sli4->extent[0].base);
+	sli4->extent[0].base = NULL;
+
+	for (i = 0; i < SLI_RSRC_MAX; i++) {
+		kfree(sli4->extent[i].use_map);
+		sli4->extent[i].use_map = NULL;
+		sli4->extent[i].base = NULL;
+	}
+
+	if (sli_get_config(sli4))
+		return -1;
+
+	return 0;
+}
+
+/**
+ * @ingroup sli
+ * @brief Issue a Firmware Reset.
+ *
+ * @par Description
+ * Issues a Firmware Reset to the chip.  This reset affects the entire chip,
+ * so all PCI function on the same PCI bus and device are affected.
+ * @n @n This type of reset can be used to activate newly downloaded firmware.
+ * @n @n The driver should be considered to be in an unknown state after this
+ * reset and should be reloaded.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return Returns 0 on success, or -1 otherwise.
+ */
+
+int
+sli_fw_reset(struct sli4_s *sli4)
+{
+	u32 val;
+	bool ready;
+
+	/*
+	 * Firmware must be ready before issuing the reset.
+	 */
+	ready = sli_wait_for_fw_ready(sli4, SLI4_FW_READY_TIMEOUT_MSEC);
+	if (!ready) {
+		efc_log_crit(sli4, "FW status is NOT ready\n");
+		return -1;
+	}
+	/* Lancer uses PHYDEV_CONTROL */
+
+	val = SLI4_PHYDEV_CTRL_FRST;
+	writel(val, (sli4->reg[0] + SLI4_PHYDEV_CTRL_REG));
+
+	/* wait for the FW to become ready after the reset */
+	ready = sli_wait_for_fw_ready(sli4, SLI4_FW_READY_TIMEOUT_MSEC);
+	if (!ready) {
+		efc_log_crit(sli4, "Failed to become ready after firmware reset\n");
+		return -1;
+	}
+	return 0;
+}
+
+/**
+ * @ingroup sli
+ * @brief Tear down a SLI context.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return Returns 0 on success, or non-zero otherwise.
+ */
+int
+sli_teardown(struct sli4_s *sli4)
+{
+	u32 i;
+
+	kfree(sli4->extent[0].base);
+	sli4->extent[0].base = NULL;
+
+	for (i = 0; i < SLI_RSRC_MAX; i++) {
+		sli4->extent[i].base = NULL;
+
+		kfree(sli4->extent[i].use_map);
+		sli4->extent[i].use_map = NULL;
+	}
+
+	if (sli_fw_term(sli4))
+		efc_log_err(sli4, "FW deinitialization failed\n");
+
+	dma_free_coherent(&sli4->pcidev->dev, sli4->vpd_data.size,
+			  sli4->vpd_data.virt, sli4->vpd_data.phys);
+	dma_free_coherent(&sli4->pcidev->dev, sli4->bmbx.size,
+			  sli4->bmbx.virt, sli4->bmbx.phys);
+
+	return 0;
+}
+
+/**
+ * @ingroup sli
+ * @brief Register a callback for the given event.
+ *
+ * @param sli4 SLI context.
+ * @param which Event of interest.
+ * @param func Function to call when the event occurs.
+ * @param arg Argument passed to the callback function.
+ *
+ * @return Returns 0 on success, or non-zero otherwise.
+ */
+int
+sli_callback(struct sli4_s *sli4, enum sli4_callback_e which,
+	     void *func, void *arg)
+{
+	if (!func) {
+		efc_log_err(sli4, "bad parameter sli4=%p which=%#x func=%p\n",
+		       sli4, which, func);
+		return -1;
+	}
+
+	switch (which) {
+	case SLI4_CB_LINK:
+		sli4->link = func;
+		sli4->link_arg = arg;
+		break;
+	default:
+		efc_log_info(sli4, "unknown callback %#x\n", which);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * @ingroup sli
+ * @brief Modify the delay timer for all the EQs
+ *
+ * @param sli4 SLI context.
+ * @param eq Array of EQs.
+ * @param num_eq Count of EQs.
+ * @param shift Phase shift for staggering interrupts.
+ * @param delay_mult Delay multiplier for limiting interrupt frequency.
+ *
+ * @return Returns 0 on success, or -1 otherwise.
+ */
+int
+sli_eq_modify_delay(struct sli4_s *sli4, struct sli4_queue_s *eq,
+		    u32 num_eq, u32 shift, u32 delay_mult)
+{
+	sli_cmd_common_modify_eq_delay(sli4, sli4->bmbx.virt, SLI4_BMBX_SIZE,
+				       eq, num_eq, shift, delay_mult);
+
+	if (sli_bmbx_command(sli4)) {
+		efc_log_crit(sli4, "bootstrap mailbox write fail (MODIFY EQ DELAY)\n");
+		return -1;
+	}
+	if (sli_res_sli_config(sli4, sli4->bmbx.virt)) {
+		efc_log_err(sli4, "bad status MODIFY EQ DELAY\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * @ingroup sli
+ * @brief Allocate SLI Port resources.
+ *
+ * @par Description
+ * Allocate port-related resources, such as VFI, RPI, XRI, and so on.
+ * Resources are modeled using extents, regardless of whether the underlying
+ * device implements resource extents. If the device does not implement
+ * extents, the SLI layer models this as a single (albeit large) extent.
+ *
+ * @param sli4 SLI context.
+ * @param rtype Resource type (for example, RPI or XRI)
+ * @param rid Allocated resource ID.
+ * @param index Index into the bitmap.
+ *
+ * @return Returns 0 on success, or a non-zero value on failure.
+ */
+int
+sli_resource_alloc(struct sli4_s *sli4, enum sli4_resource_e rtype,
+		   u32 *rid, u32 *index)
+{
+	int rc = 0;
+	u32 size;
+	u32 extent_idx;
+	u32 item_idx;
+	u32 position;
+
+	*rid = U32_MAX;
+	*index = U32_MAX;
+
+	switch (rtype) {
+	case SLI_RSRC_VFI:
+	case SLI_RSRC_VPI:
+	case SLI_RSRC_RPI:
+	case SLI_RSRC_XRI:
+		position =
+		find_first_zero_bit(sli4->extent[rtype].use_map,
+				    sli4->extent[rtype].map_size);
+		if (position >= sli4->extent[rtype].map_size) {
+			efc_log_err(sli4, "out of resource %d (alloc=%d)\n",
+				    rtype, sli4->extent[rtype].n_alloc);
+			rc = -1;
+			break;
+		}
+		set_bit(position, sli4->extent[rtype].use_map);
+		*index = position;
+
+		size = sli4->extent[rtype].size;
+
+		extent_idx = *index / size;
+		item_idx   = *index % size;
+
+		*rid = sli4->extent[rtype].base[extent_idx] + item_idx;
+
+		sli4->extent[rtype].n_alloc++;
+		break;
+	default:
+		rc = -1;
+	}
+
+	return rc;
+}
+
+/**
+ * @ingroup sli
+ * @brief Free the SLI Port resources.
+ *
+ * @par Description
+ * Free port-related resources, such as VFI, RPI, XRI, and so.
+ * See discussion of "extent" usage in sli_resource_alloc.
+ *
+ * @param sli4 SLI context.
+ * @param rtype Resource type (for example, RPI or XRI).
+ * @param rid Allocated resource ID.
+ *
+ * @return Returns 0 on success, or a non-zero value on failure.
+ */
+int
+sli_resource_free(struct sli4_s *sli4,
+		  enum sli4_resource_e rtype, u32 rid)
+{
+	int rc = -1;
+	u32 x;
+	u32 size, *base;
+
+	switch (rtype) {
+	case SLI_RSRC_VFI:
+	case SLI_RSRC_VPI:
+	case SLI_RSRC_RPI:
+	case SLI_RSRC_XRI:
+		/*
+		 * Figure out which extent contains the resource ID. I.e. find
+		 * the extent such that
+		 *   extent->base <= resource ID < extent->base + extent->size
+		 */
+		base = sli4->extent[rtype].base;
+		size = sli4->extent[rtype].size;
+
+		/*
+		 * In the case of FW reset, this may be cleared
+		 * but the force_free path will still attempt to
+		 * free the resource. Prevent a NULL pointer access.
+		 */
+		if (base) {
+			for (x = 0; x < sli4->extent[rtype].number;
+			     x++) {
+				if (rid >= base[x] &&
+				    (rid < (base[x] + size))) {
+					rid -= base[x];
+					clear_bit((x * size) + rid,
+						  sli4->extent[rtype].use_map);
+					rc = 0;
+					break;
+				}
+			}
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
+sli_resource_reset(struct sli4_s *sli4, enum sli4_resource_e rtype)
+{
+	int rc = -1;
+	u32 i;
+
+	switch (rtype) {
+	case SLI_RSRC_VFI:
+	case SLI_RSRC_VPI:
+	case SLI_RSRC_RPI:
+	case SLI_RSRC_XRI:
+		for (i = 0; i < sli4->extent[rtype].map_size; i++)
+			clear_bit(i, sli4->extent[rtype].use_map);
+		rc = 0;
+		break;
+	default:
+		break;
+	}
+
+	return rc;
+}
+
+/**
+ * @ingroup sli
+ * @brief Cause chip to enter an unrecoverable error state.
+ *
+ * @par Description
+ * Cause chip to enter an unrecoverable error state. This is
+ * used when detecting unexpected FW behavior so FW can be
+ * hwted from the driver as soon as error is detected.
+ *
+ * @param sli4 SLI context.
+ * @param dump Generate dump as part of reset.
+ *
+ * @return Returns 0 if call completed correctly,
+ * or -1 if call failed (unsupported chip).
+ */
+int sli_raise_ue(struct sli4_s *sli4, u8 dump)
+{
+	u32 val = 0;
+#define FDD 2
+	if (dump == FDD) {
+		val = SLI4_PORT_CTRL_FDD | SLI4_PORT_CTRL_IP;
+		writel(val, (sli4->reg[0] + SLI4_PORT_CTRL_REG));
+	} else {
+		val = SLI4_PHYDEV_CTRL_FRST;
+
+		if (dump == 1)
+			val |= SLI4_PHYDEV_CTRL_DD;
+		writel(val, (sli4->reg[0] + SLI4_PHYDEV_CTRL_REG));
+	}
+
+	return 0;
+}
+
+/**
+ * @ingroup sli
+ * @brief Read the SLIPORT_STATUS register to to check if a dump is present.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return  Returns 1 if the chip is ready,
+ * or 0 if the chip is not ready, 2 if fdp is present.
+ */
+int sli_dump_is_ready(struct sli4_s *sli4)
+{
+	int rc = 0;
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
+			rc = 1;
+		else if (port_val & SLI4_PORT_STATUS_FDP)
+			rc = 2;
+	}
+
+	return rc;
+}
+
+/**
+ * @ingroup sli
+ * @brief Read the SLIPORT_STATUS register to check if a dump is present.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return
+ * - 0 if call completed correctly and no dump is present.
+ * - 1 if call completed and dump is present.
+ * - -1 if call failed (unsupported chip).
+ */
+int sli_dump_is_present(struct sli4_s *sli4)
+{
+	u32 val;
+	bool ready;
+
+	/* If the chip is not ready, then there cannot be a dump */
+	ready = sli_wait_for_fw_ready(sli4, SLI4_INIT_PORT_DELAY_US);
+	if (!ready)
+		return 0;
+
+	val = sli_reg_read_status(sli4);
+	if (val == U32_MAX) {
+		efc_log_err(sli4, "error reading SLIPORT_STATUS\n");
+		return -1;
+	} else {
+		return (val & SLI4_PORT_STATUS_DIP) ? 1 : 0;
+	}
+}
+
+/**
+ * @ingroup sli
+ * @brief Read the SLIPORT_STATUS register to check if
+ * the reset required is set.
+ *
+ * @param sli4 SLI context.
+ *
+ * @return
+ * - 0 if call completed correctly and reset is not required.
+ * - 1 if call completed and reset is required.
+ * - -1 if call failed.
+ */
+int sli_reset_required(struct sli4_s *sli4)
+{
+	u32 val;
+
+	val = sli_reg_read_status(sli4);
+	if (val == U32_MAX) {
+		efc_log_err(sli4, "error reading SLIPORT_STATUS\n");
+		return -1;
+	} else {
+		return (val & SLI4_PORT_STATUS_RN) ? 1 : 0;
+	}
+}
+
+/**
+ * @ingroup sli_fc
+ * @brief Write an POST_SGL_PAGES command.
+ *
+ * @param sli4 SLI context.
+ * @param buf Destination buffer for the command.
+ * @param size Buffer size, in bytes.
+ * @param xri starting XRI
+ * @param xri_count XRI
+ * @param page0 First SGL memory page.
+ * @param page1 Second SGL memory page (optional).
+ * @param dma DMA buffer for non-embedded mailbox command (options)
+ *
+ * if non-embedded mbx command is used, dma buffer must be at least
+ * (32 + xri_count*16) in length
+ *
+ * @return Returns the number of bytes written.
+ */
+int
+sli_cmd_post_sgl_pages(struct sli4_s *sli4, void *buf, size_t size,
+		       u16 xri,
+		       u32 xri_count, struct efc_dma_s *page0[],
+		       struct efc_dma_s *page1[], struct efc_dma_s *dma)
+{
+	struct sli4_rqst_post_sgl_pages_s *post = NULL;
+	u32 i;
+
+	post = sli_config_cmd_init(sli4, buf, size,
+				   SLI_CONFIG_PYLD_LENGTH(post_sgl_pages),
+				   dma);
+	if (!post)
+		return EFC_FAIL;
+
+	post->hdr.opcode = SLI4_OPC_POST_SGL_PAGES;
+	post->hdr.subsystem = SLI4_SUBSYSTEM_FC;
+	/* payload size calculation */
+	/* 4 = xri_start + xri_count */
+	/* xri_count = # of XRI's registered */
+	/* sizeof(uint64_t) = physical address size */
+	/* 2 = # of physical addresses per page set */
+	post->hdr.request_length =
+		cpu_to_le32(4 + (xri_count * (sizeof(uint64_t) * 2)));
+
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
+				lower_32_bits(page1[i]->phys);
+			post->page_set[i].page1_high =
+				upper_32_bits(page1[i]->phys);
+		}
+	}
+
+	return EFC_SUCCESS;
+}
+
+/**
+ * @ingroup sli_fc
+ * @brief Write an POST_HDR_TEMPLATES command.
+ *
+ * @param sli4 SLI context.
+ * @param buf Destination buffer for the command.
+ * @param size Buffer size, in bytes.
+ * @param dma Pointer to DMA memory structure. This is allocated by the caller.
+ * @param rpi Starting RPI index for the header templates.
+ * @param payload_dma Pointer to DMA memory used to hold larger descriptor
+ * counts.
+ *
+ * @return Returns the number of bytes written.
+ */
+int
+sli_cmd_post_hdr_templates(struct sli4_s *sli4, void *buf,
+			   size_t size, struct efc_dma_s *dma,
+			   u16 rpi,
+			   struct efc_dma_s *payload_dma)
+{
+	struct sli4_rqst_post_hdr_templates_s *template = NULL;
+	uintptr_t phys = 0;
+	u32 i = 0;
+	u32 page_count;
+	u32 payload_size;
+
+	page_count = sli_page_count(dma->size, SLI_PAGE_SIZE);
+
+	payload_size = CFG_RQST_PYLD_LEN_VAR(post_hdr_templates,
+					     page_count * SZ_DMAADDR);
+
+	if (page_count > 16) {
+		/*
+		 * We can't fit more than 16 descriptors into an embedded mbox
+		 * command, it has to be non-embedded
+		 */
+		payload_dma->size = payload_size;
+		payload_dma->virt = dma_alloc_coherent(&sli4->pcidev->dev,
+						       payload_dma->size,
+					     &payload_dma->phys, GFP_DMA);
+		if (!payload_dma->virt) {
+			memset(payload_dma, 0, sizeof(struct efc_dma_s));
+			efc_log_err(sli4, "mbox payload memory allocation fail\n");
+			return EFC_FAIL;
+		}
+		template = sli_config_cmd_init(sli4, buf, size,
+					       payload_size, payload_dma);
+	} else {
+		template = sli_config_cmd_init(sli4, buf, size,
+					       payload_size, NULL);
+	}
+
+	if (!template)
+		return EFC_FAIL;
+
+	if (rpi == U16_MAX)
+		rpi = sli4->extent[SLI_RSRC_RPI].base[0];
+
+	template->hdr.opcode = SLI4_OPC_POST_HDR_TEMPLATES;
+	template->hdr.subsystem = SLI4_SUBSYSTEM_FC;
+	template->hdr.request_length = CFG_RQST_PYLD_LEN(post_hdr_templates);
+
+	template->rpi_offset = cpu_to_le16(rpi);
+	template->page_count = cpu_to_le16(page_count);
+	phys = dma->phys;
+	for (i = 0; i < page_count; i++) {
+		template->page_descriptor[i].low  =
+				cpu_to_le32(lower_32_bits(phys));
+		template->page_descriptor[i].high =
+				cpu_to_le32(upper_32_bits(phys));
+
+		phys += SLI_PAGE_SIZE;
+	}
+
+	return EFC_SUCCESS;
+}
+
+/**
+ * @ingroup sli_fc
+ * @brief Get the RPI resource requirements.
+ *
+ * @param sli4 SLI context.
+ * @param n_rpi Number of RPIs desired.
+ *
+ * @return Returns the number of bytes needed. This value may be zero.
+ */
+u32
+sli_fc_get_rpi_requirements(struct sli4_s *sli4, u32 n_rpi)
+{
+	u32 bytes = 0;
+
+	/* Check if header templates needed */
+	if (sli4->hdr_template_req)
+		/* round up to a page */
+		bytes = SLI_ROUND_PAGE(n_rpi * SLI4_HDR_TEMPLATE_SIZE);
+
+	return bytes;
+}
+
+/**
+ * @ingroup sli_fc
+ * @brief Return a text string corresponding to a CQE status value
+ *
+ * @param status Status value
+ *
+ * @return Returns corresponding string, otherwise "unknown"
+ */
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
index 24ae702f9427..6fff0aaa2463 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.h
+++ b/drivers/scsi/elx/libefc_sli/sli4.h
@@ -4264,4 +4264,582 @@ struct sli4_s {
 	u32	vpd_length;
 };
 
+/**
+ * Get / set parameter functions
+ */
+
+static inline int
+sli_set_hlm(struct sli4_s *sli4, u32 value)
+{
+	if (value && !(sli4->features & SLI4_REQFEAT_HLM)) {
+		efc_log_err(sli4, "HLM not supported\n");
+		return -1;
+	}
+
+	sli4->high_login_mode = value != 0 ? true : false;
+
+	return 0;
+}
+
+static inline int
+sli_set_sgl_preregister(struct sli4_s *sli4, u32 value)
+{
+	if (value == 0 && sli4->sgl_pre_registration_required) {
+		efc_log_err(sli4, "SGL pre-registration required\n");
+		return -1;
+	}
+
+	sli4->sgl_pre_registered = value != 0 ? true : false;
+
+	return 0;
+}
+
+static inline u32
+sli_get_max_sgl(struct sli4_s *sli4)
+{
+	if (sli4->sgl_page_sizes != 1) {
+		efc_log_err(sli4, "unsupported SGL page sizes %#x\n",
+			sli4->sgl_page_sizes);
+		return 0;
+	}
+
+	return ((sli4->max_sgl_pages * SLI_PAGE_SIZE)
+		/ sizeof(struct sli4_sge_s));
+}
+
+static inline enum sli4_link_medium_e
+sli_get_medium(struct sli4_s *sli4)
+{
+	switch (sli4->topology) {
+	case SLI4_READ_CFG_TOPO_FC:
+	case SLI4_READ_CFG_TOPO_FC_DA:
+	case SLI4_READ_CFG_TOPO_FC_AL:
+		return SLI_LINK_MEDIUM_FC;
+	default:
+		return SLI_LINK_MEDIUM_MAX;
+	}
+}
+
+static inline int
+sli_set_topology(struct sli4_s *sli4, u32 value)
+{
+	int	rc = 0;
+
+	switch (value) {
+	case SLI4_READ_CFG_TOPO_FC:
+	case SLI4_READ_CFG_TOPO_FC_DA:
+	case SLI4_READ_CFG_TOPO_FC_AL:
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
+sli_reg_read_status(struct sli4_s *sli)
+{
+	return readl(sli->reg[0] + SLI4_PORT_STATUS_REGOFF);
+}
+
+static inline int
+sli_fw_error_status(struct sli4_s *sli4)
+{
+	return ((sli_reg_read_status(sli4) & SLI4_PORT_STATUS_ERR) ? 1 : 0);
+}
+
+static inline u32
+sli_reg_read_err1(struct sli4_s *sli)
+{
+	return readl(sli->reg[0] + SLI4_PORT_ERROR1);
+}
+
+static inline u32
+sli_reg_read_err2(struct sli4_s *sli)
+{
+	return readl(sli->reg[0] + SLI4_PORT_ERROR2);
+}
+
+/**
+ * @ingroup sli_fc
+ * @brief Retrieve the received header and payload length.
+ *
+ * @param sli4 SLI context.
+ * @param cqe Pointer to the CQ entry.
+ * @param len_hdr Pointer where the header length is written.
+ * @param len_data Pointer where the payload length is written.
+ *
+ * @return Returns 0 on success, or a non-zero value on failure.
+ */
+static inline int
+sli_fc_rqe_length(struct sli4_s *sli4, void *cqe, u32 *len_hdr,
+		  u32 *len_data)
+{
+	struct sli4_fc_async_rcqe_s	*rcqe = cqe;
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
+/**
+ * @ingroup sli_fc
+ * @brief Retrieve the received FCFI.
+ *
+ * @param sli4 SLI context.
+ * @param cqe Pointer to the CQ entry.
+ *
+ * @return Returns the FCFI in the CQE. or U8_MAX if invalid CQE code.
+ */
+static inline u8
+sli_fc_rqe_fcfi(struct sli4_s *sli4, void *cqe)
+{
+	u8 code = ((u8 *)cqe)[SLI4_CQE_CODE_OFFSET];
+	u8 fcfi = U8_MAX;
+
+	switch (code) {
+	case SLI4_CQE_CODE_RQ_ASYNC: {
+		struct sli4_fc_async_rcqe_s *rcqe = cqe;
+
+		fcfi = le16_to_cpu(rcqe->fcfi_rq_id_word) & SLI4_RACQE_FCFI;
+		break;
+	}
+	case SLI4_CQE_CODE_RQ_ASYNC_V1: {
+		struct sli4_fc_async_rcqe_v1_s *rcqev1 = cqe;
+
+		fcfi = rcqev1->fcfi_byte & SLI4_RACQE_FCFI;
+		break;
+	}
+	case SLI4_CQE_CODE_OPTIMIZED_WRITE_CMD: {
+		struct sli4_fc_optimized_write_cmd_cqe_s *opt_wr = cqe;
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
+extern int
+sli_cmd_config_link(struct sli4_s *sli4, void *buf, size_t size);
+extern int
+sli_cmd_down_link(struct sli4_s *sli4, void *buf, size_t size);
+extern int
+sli_cmd_dump_type4(struct sli4_s *sli4, void *buf,
+		   size_t size, u16 wki);
+extern int
+sli_cmd_common_read_transceiver_data(struct sli4_s *sli4, void *buf,
+				     size_t size, u32 page_num,
+				     struct efc_dma_s *dma);
+extern int
+sli_cmd_read_link_stats(struct sli4_s *sli4, void *buf, size_t size,
+			u8 req_ext_counters, u8 clear_overflow_flags,
+			u8 clear_all_counters);
+extern int
+sli_cmd_read_status(struct sli4_s *sli4, void *buf, size_t size,
+		    u8 clear_counters);
+extern int
+sli_cmd_init_link(struct sli4_s *sli4, void *buf, size_t size,
+		  u32 speed, u8 reset_alpa);
+extern int
+sli_cmd_init_vfi(struct sli4_s *sli4, void *buf, size_t size, u16 vfi,
+		 u16 fcfi, u16 vpi);
+extern int
+sli_cmd_init_vpi(struct sli4_s *sli4, void *buf, size_t size, u16 vpi,
+		 u16 vfi);
+extern int
+sli_cmd_post_xri(struct sli4_s *sli4, void *buf, size_t size,
+		 u16 xri_base, u16 xri_count);
+extern int
+sli_cmd_release_xri(struct sli4_s *sli4, void *buf, size_t size,
+		    u8 num_xri);
+extern int
+sli_cmd_read_sparm64(struct sli4_s *sli4, void *buf, size_t size,
+		     struct efc_dma_s *dma, u16 vpi);
+extern int
+sli_cmd_read_topology(struct sli4_s *sli4, void *buf, size_t size,
+		      struct efc_dma_s *dma);
+extern int
+sli_cmd_read_nvparms(struct sli4_s *sli4, void *buf, size_t size);
+extern int
+sli_cmd_write_nvparms(struct sli4_s *sli4, void *buf, size_t size,
+		      u8 *wwpn, u8 *wwnn, u8 hard_alpa,
+		      u32 preferred_d_id);
+struct sli4_cmd_rq_cfg_s {
+	__le16	rq_id;
+	u8	r_ctl_mask;
+	u8	r_ctl_match;
+	u8	type_mask;
+	u8	type_match;
+};
+
+extern int
+sli_cmd_reg_fcfi(struct sli4_s *sli4, void *buf, size_t size,
+		 u16 index,
+		struct sli4_cmd_rq_cfg_s rq_cfg[SLI4_CMD_REG_FCFI_NUM_RQ_CFG]);
+extern int
+sli_cmd_reg_fcfi_mrq(struct sli4_s *sli4, void *buf, size_t size,
+		     u8 mode, u16 fcf_index,
+	    u8 rq_selection_policy, u8 mrq_bit_mask,
+	    u16 num_mrqs,
+	    struct sli4_cmd_rq_cfg_s rq_cfg[SLI4_CMD_REG_FCFI_NUM_RQ_CFG]);
+
+extern int
+sli_cmd_reg_rpi(struct sli4_s *sli4, void *buf, size_t size,
+		u32 nport_id, u16 rpi, u16 vpi,
+		     struct efc_dma_s *dma, u8 update,
+		     u8 enable_t10_pi);
+extern int
+sli_cmd_sli_config(struct sli4_s *sli4, void *buf, size_t size,
+		   u32 length, struct efc_dma_s *dma);
+extern int
+sli_cmd_unreg_fcfi(struct sli4_s *sli4, void *buf, size_t size,
+		   u16 indicator);
+extern int
+sli_cmd_unreg_rpi(struct sli4_s *sli4, void *buf, size_t size,
+		  u16 indicator,
+		  enum sli4_resource_e which, u32 fc_id);
+extern int
+sli_cmd_reg_vpi(struct sli4_s *sli4, void *buf, size_t size,
+		u32 fc_id, __be64 sli_wwpn, u16 vpi, u16 vfi,
+		bool update);
+extern int
+sli_cmd_reg_vfi(struct sli4_s *sli4, void *buf, size_t size,
+		u16 vfi, u16 fcfi, struct efc_dma_s dma,
+		u16 vpi, __be64 sli_wwpn, u32 fc_id);
+extern int
+sli_cmd_unreg_vpi(struct sli4_s *sli4, void *buf, size_t size,
+		  u16 indicator, u32 which);
+extern int
+sli_cmd_unreg_vfi(struct sli4_s *sli4, void *buf, size_t size,
+		  u16 index, u32 which);
+extern int
+sli_cmd_common_nop(struct sli4_s *sli4, void *buf, size_t size,
+		   uint64_t context);
+extern int
+sli_cmd_common_get_resource_extent_info(struct sli4_s *sli4, void *buf,
+					size_t size, u16 rtype);
+extern int
+sli_cmd_common_get_sli4_parameters(struct sli4_s *sli4,
+				   void *buf, size_t size);
+extern int
+sli_cmd_common_write_object(struct sli4_s *sli4, void *buf, size_t size,
+			    u16 noc, u16 eof, u32 desired_write_length,
+		u32 offset, char *object_name, struct efc_dma_s *dma);
+extern int
+sli_cmd_common_delete_object(struct sli4_s *sli4, void *buf, size_t size,
+			     char *object_name);
+extern int
+sli_cmd_common_read_object(struct sli4_s *sli4, void *buf, size_t size,
+			   u32 desired_read_length, u32 offset,
+			   char *object_name, struct efc_dma_s *dma);
+extern int
+sli_cmd_dmtf_exec_clp_cmd(struct sli4_s *sli4, void *buf, size_t size,
+			  struct efc_dma_s *cmd, struct efc_dma_s *resp);
+extern int
+sli_cmd_common_set_dump_location(struct sli4_s *sli4,
+				 void *buf, size_t size, bool query,
+				 bool is_buffer_list,
+				 struct efc_dma_s *buffer, u8 fdb);
+extern int
+sli_cmd_common_set_features(struct sli4_s *sli4, void *buf, size_t size,
+			    u32 feature, u32 param_len,
+			    void *parameter);
+
+int sli_cqe_mq(struct sli4_s *sli4, void *buf);
+int sli_cqe_async(struct sli4_s *sli4, void *buf);
+
+extern int
+sli_setup(struct sli4_s *sli4, void *os, struct pci_dev  *pdev,
+	  void __iomem *reg[]);
+void sli_calc_max_qentries(struct sli4_s *sli4);
+int sli_init(struct sli4_s *sli4);
+int sli_reset(struct sli4_s *sli4);
+int sli_fw_reset(struct sli4_s *sli4);
+int sli_teardown(struct sli4_s *sli4);
+extern int
+sli_callback(struct sli4_s *sli4, enum sli4_callback_e which,
+	     void *func, void *arg);
+extern int
+sli_bmbx_command(struct sli4_s *sli4);
+extern int
+__sli_queue_init(struct sli4_s *sli4, struct sli4_queue_s *q,
+		 u32 qtype, size_t size, u32 n_entries,
+		      u32 align);
+extern int
+__sli_create_queue(struct sli4_s *sli4, struct sli4_queue_s *q);
+extern int
+sli_eq_modify_delay(struct sli4_s *sli4, struct sli4_queue_s *eq,
+		    u32 num_eq, u32 shift, u32 delay_mult);
+extern int
+sli_queue_alloc(struct sli4_s *sli4, u32 qtype,
+		struct sli4_queue_s *q, u32 n_entries,
+		     struct sli4_queue_s *assoc);
+extern int
+sli_cq_alloc_set(struct sli4_s *sli4, struct sli4_queue_s *qs[],
+		 u32 num_cqs, u32 n_entries, struct sli4_queue_s *eqs[]);
+extern int
+sli_get_queue_entry_size(struct sli4_s *sli4, u32 qtype);
+extern int
+sli_queue_free(struct sli4_s *sli4, struct sli4_queue_s *q,
+	       u32 destroy_queues, u32 free_memory);
+extern int
+sli_queue_eq_arm(struct sli4_s *sli4, struct sli4_queue_s *q, bool arm);
+extern int
+sli_queue_arm(struct sli4_s *sli4, struct sli4_queue_s *q, bool arm);
+
+extern int
+sli_wq_write(struct sli4_s *sli4, struct sli4_queue_s *q,
+	     u8 *entry);
+extern int
+sli_mq_write(struct sli4_s *sli4, struct sli4_queue_s *q,
+	     u8 *entry);
+extern int
+sli_rq_write(struct sli4_s *sli4, struct sli4_queue_s *q,
+	     u8 *entry);
+extern int
+sli_eq_read(struct sli4_s *sli4, struct sli4_queue_s *q,
+	    u8 *entry);
+extern int
+sli_cq_read(struct sli4_s *sli4, struct sli4_queue_s *q,
+	    u8 *entry);
+extern int
+sli_mq_read(struct sli4_s *sli4, struct sli4_queue_s *q,
+	    u8 *entry);
+extern int
+sli_queue_index(struct sli4_s *sli4, struct sli4_queue_s *q);
+extern int
+_sli_queue_poke(struct sli4_s *sli4, struct sli4_queue_s *q,
+		u32 index, u8 *entry);
+extern int
+sli_queue_poke(struct sli4_s *sli4, struct sli4_queue_s *q, u32 index,
+	       u8 *entry);
+extern int
+sli_resource_alloc(struct sli4_s *sli4, enum sli4_resource_e rtype,
+		   u32 *rid, u32 *index);
+extern int
+sli_resource_free(struct sli4_s *sli4, enum sli4_resource_e rtype,
+		  u32 rid);
+extern int
+sli_resource_reset(struct sli4_s *sli4, enum sli4_resource_e rtype);
+extern int
+sli_eq_parse(struct sli4_s *sli4, u8 *buf, u16 *cq_id);
+extern int
+sli_cq_parse(struct sli4_s *sli4, struct sli4_queue_s *cq, u8 *cqe,
+	     enum sli4_qentry_e *etype, u16 *q_id);
+
+int sli_raise_ue(struct sli4_s *sli4, u8 dump);
+int sli_dump_is_ready(struct sli4_s *sli4);
+int sli_dump_is_present(struct sli4_s *sli4);
+int sli_reset_required(struct sli4_s *sli4);
+int sli_fw_ready(struct sli4_s *sli4);
+
+extern int
+sli_fc_process_link_state(struct sli4_s *sli4, void *acqe);
+extern int
+sli_fc_process_link_attention(struct sli4_s *sli4, void *acqe);
+extern int
+sli_fc_cqe_parse(struct sli4_s *sli4, struct sli4_queue_s *cq,
+		 u8 *cqe, enum sli4_qentry_e *etype,
+		 u16 *rid);
+u32 sli_fc_response_length(struct sli4_s *sli4, u8 *cqe);
+u32 sli_fc_io_length(struct sli4_s *sli4, u8 *cqe);
+int sli_fc_els_did(struct sli4_s *sli4, u8 *cqe,
+		   u32 *d_id);
+u32 sli_fc_ext_status(struct sli4_s *sli4, u8 *cqe);
+extern int
+sli_fc_rqe_rqid_and_index(struct sli4_s *sli4, u8 *cqe,
+			  u16 *rq_id, u32 *index);
+extern int
+sli_cmd_wq_create(struct sli4_s *sli4, void *buf, size_t size,
+		  struct efc_dma_s *qmem, u16 cq_id);
+extern int
+sli_cmd_wq_create_v1(struct sli4_s *sli4, void *buf, size_t size,
+		     struct efc_dma_s *qmem,
+			  u16 cq_id);
+int sli_cmd_wq_destroy(struct sli4_s *sli4, void *buf,
+		       size_t size, u16 wq_id);
+int sli_cmd_post_sgl_pages(struct sli4_s *sli4, void *buf,
+			   size_t size, u16 xri, u32 xri_count,
+			   struct efc_dma_s *page0[],
+			   struct efc_dma_s *page1[], struct efc_dma_s *dma);
+extern int
+sli_cmd_rq_create(struct sli4_s *sli4, void *buf, size_t size,
+		  struct efc_dma_s *qmem,
+		       u16 cq_id, u16 buffer_size);
+extern int
+sli_cmd_rq_create_v1(struct sli4_s *sli4, void *buf, size_t size,
+		     struct efc_dma_s *qmem, u16 cq_id,
+			  u16 buffer_size);
+int sli_cmd_rq_destroy(struct sli4_s *sli4, void *buf,
+		       size_t size, u16 rq_id);
+extern int
+sli_cmd_read_fcf_table(struct sli4_s *sli4, void *buf, size_t size,
+		       struct efc_dma_s *dma, u16 index);
+extern int
+sli_cmd_post_hdr_templates(struct sli4_s *sli4, void *buf,
+			   size_t size, struct efc_dma_s *dma,
+				     u16 rpi,
+				     struct efc_dma_s *payload_dma);
+extern int
+sli_cmd_rediscover_fcf(struct sli4_s *sli4, void *buf, size_t size,
+		       u16 index);
+extern int
+sli_fc_rq_alloc(struct sli4_s *sli4, struct sli4_queue_s *q,
+		u32 n_entries, u32 buffer_size,
+		struct sli4_queue_s *cq, bool is_hdr);
+extern int
+sli_fc_rq_set_alloc(struct sli4_s *sli4, u32 num_rq_pairs,
+		    struct sli4_queue_s *qs[], u32 base_cq_id,
+		    u32 n_entries, u32 header_buffer_size,
+		    u32 payload_buffer_size);
+u32 sli_fc_get_rpi_requirements(struct sli4_s *sli4,
+				u32 n_rpi);
+extern int
+sli_abort_wqe(struct sli4_s *sli4, void *buf, size_t size,
+	      enum sli4_abort_type_e type, bool send_abts,
+	u32 ids, u32 mask, u16 tag, u16 cq_id);
+
+extern int
+sli_send_frame_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		   u8 sof, u8 eof, u32 *hdr,
+			struct efc_dma_s *payload, u32 req_len,
+			u8 timeout, u16 xri, u16 req_tag);
+
+extern int
+sli_xmit_els_rsp64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		       struct efc_dma_s *rsp, u32 rsp_len,
+		u16 xri, u16 tag, u16 cq_id,
+		u16 ox_id, u16 rnodeindicator,
+		u16 sportindicator, bool hlm, bool rnodeattached,
+		u32 rnode_fcid, u32 flags, u32 s_id);
+
+extern int
+sli_els_request64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		      struct efc_dma_s *sgl,
+		u8 req_type, u32 req_len, u32 max_rsp_len,
+		u8 timeout, u16 xri, u16 tag,
+		u16 cq_id, u16 rnodeindicator,
+		u16 sportindicator, bool hlm, bool rnodeattached,
+		u32 rnode_fcid, u32 sport_fcid);
+
+extern int
+sli_fcp_icmnd64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		    struct efc_dma_s *sgl, u16 xri, u16 tag,
+		u16 cq_id, u32 rpi, bool hlm,
+		u32 rnode_fcid, u8 timeout);
+
+extern int
+sli_fcp_iread64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		    struct efc_dma_s *sgl, u32 first_data_sge,
+		u32 xfer_len, u16 xri, u16 tag,
+		u16 cq_id, u32 rpi, bool hlm, u32 rnode_fcid,
+		u8 dif, u8 bs, u8 timeout);
+
+extern int
+sli_fcp_iwrite64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		     struct efc_dma_s *sgl,
+		u32 first_data_sge, u32 xfer_len,
+		u32 first_burst, u16 xri, u16 tag,
+		u16 cq_id, u32 rpi,
+		bool hlm, u32 rnode_fcid,
+		u8 dif, u8 bs, u8 timeout);
+
+extern int
+sli_fcp_treceive64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		       struct efc_dma_s *sgl,
+		u32 first_data_sge, u32 relative_off,
+		u32 xfer_len, u16 xri, u16 tag,
+		u16 cq_id, u16 xid, u32 rpi, bool hlm,
+		u32 rnode_fcid, u32 flags, u8 dif,
+		u8 bs, u8 csctl, u32 app_id);
+
+extern int
+sli_fcp_cont_treceive64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+			    struct efc_dma_s *sgl, u32 first_data_sge,
+		u32 relative_off, u32 xfer_len,
+		u16 xri, u16 sec_xri, u16 tag,
+		u16 cq_id, u16 xid, u32 rpi,
+		bool hlm, u32 rnode_fcid, u32 flags,
+		u8 dif, u8 bs, u8 csctl,
+		u32 app_id);
+
+extern int
+sli_fcp_trsp64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		   struct efc_dma_s *sgl,
+		u32 rsp_len, u16 xri, u16 tag, u16 cq_id,
+		u16 xid, u32 rpi, bool hlm, u32 rnode_fcid,
+		u32 flags, u8 csctl, u8 port_owned,
+		u32 app_id);
+
+extern int
+sli_fcp_tsend64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		    struct efc_dma_s *sgl,
+		u32 first_data_sge, u32 relative_off,
+		u32 xfer_len, u16 xri, u16 tag,
+		u16 cq_id, u16 xid, u32 rpi,
+		bool hlm, u32 rnode_fcid, u32 flags, u8 dif,
+		u8 bs, u8 csctl, u32 app_id);
+
+extern int
+sli_gen_request64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		      struct efc_dma_s *sgl, u32 req_len,
+		u32 max_rsp_len, u8 timeout, u16 xri,
+		u16 tag, u16 cq_id, bool hlm, u32 rnode_fcid,
+		u16 rnodeindicator, u8 r_ctl, u8 type,
+		u8 df_ctl);
+
+extern int
+sli_xmit_bls_rsp64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		       struct sli_bls_payload_s *payload, u16 xri,
+		u16 tag, u16 cq_id,
+		bool rnodeattached, bool hlm, u16 rnodeindicator,
+		u16 sportindicator, u32 rnode_fcid,
+		u32 sport_fcid, u32 s_id);
+
+extern int
+sli_xmit_sequence64_wqe(struct sli4_s *sli4, void *buf, size_t size,
+			struct efc_dma_s *payload, u32 payload_len,
+		u8 timeout, u16 ox_id, u16 xri,
+		u16 tag, bool hlm, u32 rnode_fcid,
+		u16 rnodeindicator, u8 r_ctl,
+		u8 type, u8 df_ctl);
+
+extern int
+sli_requeue_xri_wqe(struct sli4_s *sli4, void *buf, size_t size,
+		    u16 xri, u16 tag, u16 cq_id);
+extern void
+sli4_cmd_lowlevel_set_watchdog(struct sli4_s *sli4, void *buf,
+			       size_t size, u16 timeout);
+
+const char *sli_fc_get_status_string(u32 status);
+
 #endif /* !_SLI4_H */
-- 
2.13.7

