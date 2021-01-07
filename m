Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058E92EE979
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Jan 2021 00:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbhAGXAk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 18:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbhAGXAj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Jan 2021 18:00:39 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426C2C0612A0
        for <linux-scsi@vger.kernel.org>; Thu,  7 Jan 2021 14:59:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be12so4640111plb.4
        for <linux-scsi@vger.kernel.org>; Thu, 07 Jan 2021 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/k3Ffne1RynA6tDI3Hnd5RLT9rDtpXQ9yh8aUydQ2g=;
        b=nDEXAk5u2d4rXK4MnLO1Czr348iuxOrwkFDJTOuR91g6n0sNebXf00yTeqO4jrdy1M
         PcOnVfd7j7ReIC+tCCKtSoobvpEz9yNjZpIEkT5ws6Wm+KSLnFVafqJ3pLqGedjH2IpY
         fTGeaVaNzcNxgDBSSdiFbrRvA8nGa6QZMQe3QXtdUKjP7kovh61Ypp5nDeq/57aA+J5g
         mCacEXeOHoCh2Xug1rYTZ/LFYpYQsitvP2MzBrElUANnv/ixolwJU9JHg79AyhUb7f5M
         qirMN3u4ZPQrA7RJjDykgIemAWZbt/3nyKvoulxA+2wIXACOKhnfG7dPA74wPpbIDV1X
         4wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/k3Ffne1RynA6tDI3Hnd5RLT9rDtpXQ9yh8aUydQ2g=;
        b=g6fTfubCVGbFW2dKBjnNsIvKj1blK6wZDT/ghmtaHyuMqV1PnXT8KVF7b6kaxkVZAe
         j5TeThMDkKNc9On0xVgBI9szdNGDWaXdjw42JOwsLqLxWVtTASuxUylykRXdhFjRyHcu
         o1dBRLyhSMDQoe5qLOIJ3SIcK5uHapktegYmzr8IDcZi/i7WEpwGUDQo6esQNy0VOuKx
         pW6aZ4xxZGLntiwVhyUzH0Paj8g4Y2jx7VO4LpSMeo5kGrBSQV5yIY623ebS4s7tYvZY
         400mlXSRFGsm9BnsnpUUuCLN6CWvLXZ+EVrwomFErI5xUrRMGutUJqOApE3OtRodq7tC
         Iozg==
X-Gm-Message-State: AOAM532iysveP2Z1aIjCW3aaMbjm1y66I+n7klBT/reNLgd2K9ldBkSw
        yVK10h0wgOhmJucWVPum2+j+VTcMPejD7Q==
X-Google-Smtp-Source: ABdhPJxNvh3L47dXCSDmjWdBfAeXn9K25xCcMf15E3mlqKqL//IQGK9rPM9B8l6Fj56ba+aTbKcWBQ==
X-Received: by 2002:a17:90a:970b:: with SMTP id x11mr721055pjo.16.1610060365250;
        Thu, 07 Jan 2021 14:59:25 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l197sm6881405pfd.97.2021.01.07.14.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 14:59:24 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [PATCH v7 15/31] elx: libefc: Extended link Service IO handling
Date:   Thu,  7 Jan 2021 14:58:49 -0800
Message-Id: <20210107225905.18186-16-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210107225905.18186-1-jsmart2021@gmail.com>
References: <20210107225905.18186-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the libefc library population.

This patch adds library interface definitions for:
Functions to build and send ELS/CT/BLS commands and responses.

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v7:
 Change els functions to return status from efc_els_send_rsp()
---
 drivers/scsi/elx/libefc/efc_els.c | 1099 +++++++++++++++++++++++++++++
 drivers/scsi/elx/libefc/efc_els.h |  107 +++
 2 files changed, 1206 insertions(+)
 create mode 100644 drivers/scsi/elx/libefc/efc_els.c
 create mode 100644 drivers/scsi/elx/libefc/efc_els.h

diff --git a/drivers/scsi/elx/libefc/efc_els.c b/drivers/scsi/elx/libefc/efc_els.c
new file mode 100644
index 000000000000..c8a8124d2c94
--- /dev/null
+++ b/drivers/scsi/elx/libefc/efc_els.c
@@ -0,0 +1,1099 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Functions to build and send ELS/CT/BLS commands and responses.
+ */
+
+#include "efc.h"
+#include "efc_els.h"
+#include "../libefc_sli/sli4.h"
+
+#define EFC_LOG_ENABLE_ELS_TRACE(efc)		\
+		(((efc) != NULL) ? (((efc)->logmask & (1U << 1)) != 0) : 0)
+
+#define node_els_trace()  \
+	do { \
+		if (EFC_LOG_ENABLE_ELS_TRACE(efc)) \
+			efc_log_info(efc, "[%s] %-20s\n", \
+				node->display_name, __func__); \
+	} while (0)
+
+#define els_io_printf(els, fmt, ...) \
+	efc_log_err((struct efc *)els->node->efc,\
+		      "[%s] %-8s " fmt, \
+		      els->node->display_name,\
+		      els->display_name, ##__VA_ARGS__)
+
+#define EFC_ELS_RSP_LEN			1024
+#define EFC_ELS_GID_PT_RSP_LEN		8096
+
+struct efc_els_io_req *
+efc_els_io_alloc(struct efc_node *node, u32 reqlen)
+{
+	return efc_els_io_alloc_size(node, reqlen, EFC_ELS_RSP_LEN);
+}
+
+struct efc_els_io_req *
+efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
+{
+	struct efc *efc;
+	struct efc_els_io_req *els;
+	unsigned long flags = 0;
+
+	efc = node->efc;
+
+	spin_lock_irqsave(&node->els_ios_lock, flags);
+
+	if (!READ_ONCE(node->els_io_enabled)) {
+		efc_log_err(efc, "els io alloc disabled\n");
+		spin_unlock_irqrestore(&node->els_ios_lock, flags);
+		return NULL;
+	}
+
+	els = mempool_alloc(efc->els_io_pool, GFP_ATOMIC);
+	if (!els) {
+		atomic_add_return(1, &efc->els_io_alloc_failed_count);
+		spin_unlock_irqrestore(&node->els_ios_lock, flags);
+		return NULL;
+	}
+
+	/* initialize refcount */
+	kref_init(&els->ref);
+	els->release = _efc_els_io_free;
+
+	/* populate generic io fields */
+	els->node = node;
+
+	/* now allocate DMA for request and response */
+	els->io.req.size = reqlen;
+	els->io.req.virt = dma_alloc_coherent(&efc->pci->dev, els->io.req.size,
+					       &els->io.req.phys, GFP_DMA);
+	if (!els->io.req.virt) {
+		mempool_free(els, efc->els_io_pool);
+		spin_unlock_irqrestore(&node->els_ios_lock, flags);
+		return NULL;
+	}
+
+	els->io.rsp.size = rsplen;
+	els->io.rsp.virt = dma_alloc_coherent(&efc->pci->dev, els->io.rsp.size,
+						&els->io.rsp.phys, GFP_DMA);
+	if (!els->io.rsp.virt) {
+		dma_free_coherent(&efc->pci->dev, els->io.req.size,
+					els->io.req.virt, els->io.req.phys);
+		mempool_free(els, efc->els_io_pool);
+		els = NULL;
+	}
+
+	if (els) {
+		/* initialize fields */
+		els->els_retries_remaining = EFC_FC_ELS_DEFAULT_RETRIES;
+
+		/* add els structure to ELS IO list */
+		INIT_LIST_HEAD(&els->list_entry);
+		list_add_tail(&els->list_entry, &node->els_ios_list);
+	}
+
+	spin_unlock_irqrestore(&node->els_ios_lock, flags);
+	return els;
+}
+
+void
+efc_els_io_free(struct efc_els_io_req *els)
+{
+	kref_put(&els->ref, els->release);
+}
+
+void
+_efc_els_io_free(struct kref *arg)
+{
+	struct efc_els_io_req *els =
+				container_of(arg, struct efc_els_io_req, ref);
+	struct efc *efc;
+	struct efc_node *node;
+	int send_empty_event = false;
+	unsigned long flags = 0;
+
+	node = els->node;
+	efc = node->efc;
+
+	spin_lock_irqsave(&node->els_ios_lock, flags);
+
+	list_del(&els->list_entry);
+	/* Send list empty event if the IO allocator
+	 * is disabled, and the list is empty
+	 * If node->els_io_enabled was not checked,
+	 * the event would be posted continually
+	 */
+	send_empty_event = (!READ_ONCE(node->els_io_enabled)) &&
+			   list_empty(&node->els_ios_list);
+
+	spin_unlock_irqrestore(&node->els_ios_lock, flags);
+
+	/* free ELS request and response buffers */
+	dma_free_coherent(&efc->pci->dev, els->io.rsp.size,
+			  els->io.rsp.virt, els->io.rsp.phys);
+	dma_free_coherent(&efc->pci->dev, els->io.req.size,
+			  els->io.req.virt, els->io.req.phys);
+
+	mempool_free(els, efc->els_io_pool);
+
+	if (send_empty_event)
+		efc_scsi_io_list_empty(node->efc, node);
+}
+
+static void
+efc_els_retry(struct efc_els_io_req *els);
+
+static void
+efc_els_delay_timer_cb(struct timer_list *t)
+{
+	struct efc_els_io_req *els = from_timer(els, t, delay_timer);
+
+	/* Retry delay timer expired, retry the ELS request */
+	efc_els_retry(els);
+}
+
+static int
+efc_els_req_cb(void *arg, u32 length, int status, u32 ext_status)
+{
+	struct efc_els_io_req *els;
+	struct efc_node *node;
+	struct efc *efc;
+	struct efc_node_cb cbdata;
+	u32 reason_code;
+
+	els = arg;
+	node = els->node;
+	efc = node->efc;
+
+	if (status)
+		els_io_printf(els, "status x%x ext x%x\n", status, ext_status);
+
+	/* set the response len element of els->rsp */
+	els->io.rsp.len = length;
+
+	cbdata.status = status;
+	cbdata.ext_status = ext_status;
+	cbdata.header = NULL;
+	cbdata.els_rsp = els->io.rsp;
+
+	/* set the response len element of els->rsp */
+	cbdata.rsp_len = length;
+
+	/* FW returns the number of bytes received on the link in
+	 * the WCQE, not the amount placed in the buffer; use this info to
+	 * check if there was an overrun.
+	 */
+	if (length > els->io.rsp.size) {
+		efc_log_warn(efc,
+			      "ELS response returned len=%d > buflen=%zu\n",
+			     length, els->io.rsp.size);
+		efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_REQ_FAIL, &cbdata);
+		return EFC_SUCCESS;
+	}
+
+	/* Post event to ELS IO object */
+	switch (status) {
+	case SLI4_FC_WCQE_STATUS_SUCCESS:
+		efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_REQ_OK, &cbdata);
+		break;
+
+	case SLI4_FC_WCQE_STATUS_LS_RJT:
+		reason_code = (ext_status >> 16) & 0xff;
+
+		/* delay and retry if reason code is Logical Busy */
+		switch (reason_code) {
+		case ELS_RJT_BUSY:
+			els->node->els_req_cnt--;
+			els_io_printf(els,
+				"LS_RJT Logical Busy, delay and retry\n");
+			timer_setup(&els->delay_timer,
+				    efc_els_delay_timer_cb, 0);
+			mod_timer(&els->delay_timer,
+				  jiffies + msecs_to_jiffies(5000));
+			break;
+		default:
+			efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_REQ_RJT,
+					    &cbdata);
+			break;
+		}
+		break;
+
+	case SLI4_FC_WCQE_STATUS_LOCAL_REJECT:
+		switch (ext_status) {
+		case SLI4_FC_LOCAL_REJECT_SEQUENCE_TIMEOUT:
+			efc_els_retry(els);
+			break;
+		default:
+			efc_log_err(efc, "LOCAL_REJECT with ext status:%x\n",
+				    ext_status);
+			efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_REQ_FAIL,
+					    &cbdata);
+			break;
+		}
+		break;
+	default:	/* Other error */
+		efc_log_warn(efc, "els req failed status x%x, ext_status x%x\n",
+			     status, ext_status);
+		efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_REQ_FAIL, &cbdata);
+		break;
+	}
+
+	return EFC_SUCCESS;
+}
+
+void efc_disc_io_complete(struct efc_disc_io *io, u32 len, u32 status,
+			  u32 ext_status)
+{
+	struct efc_els_io_req *els =
+				container_of(io, struct efc_els_io_req, io);
+
+	WARN_ON_ONCE(!els->cb);
+
+	((efc_hw_srrs_cb_t) els->cb) (els, len, status, ext_status);
+}
+
+static int efc_els_send_req(struct efc_node *node, struct efc_els_io_req *els,
+			     enum efc_disc_io_type io_type)
+{
+	int rc = EFC_SUCCESS;
+	struct efc *efc = node->efc;
+	struct efc_node_cb cbdata;
+
+	/* update ELS request counter */
+	els->node->els_req_cnt++;
+
+	/* Prepare the IO request details */
+	els->io.io_type = io_type;
+	els->io.xmit_len = els->io.req.size;
+	els->io.rsp_len = els->io.rsp.size;
+	els->io.rpi = node->rnode.indicator;
+	els->io.vpi = node->nport->indicator;
+	els->io.s_id = node->nport->fc_id;
+	els->io.d_id = node->rnode.fc_id;
+
+	if (node->rnode.attached)
+		els->io.rpi_registered = true;
+
+	els->cb = efc_els_req_cb;
+
+	rc = efc->tt.send_els(efc, &els->io);
+	if (!rc)
+		return rc;
+
+	cbdata.status = EFC_STATUS_INVALID;
+	cbdata.ext_status = EFC_STATUS_INVALID;
+	cbdata.els_rsp = els->io.rsp;
+	efc_log_err(efc, "efc_els_send failed: %d\n", rc);
+	efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_REQ_FAIL, &cbdata);
+
+	return rc;
+}
+
+static void
+efc_els_retry(struct efc_els_io_req *els)
+{
+	struct efc *efc;
+	struct efc_node_cb cbdata;
+	u32 rc;
+
+	efc = els->node->efc;
+	cbdata.status = EFC_STATUS_INVALID;
+	cbdata.ext_status = EFC_STATUS_INVALID;
+	cbdata.els_rsp = els->io.rsp;
+
+
+	if (els->els_retries_remaining) {
+		els->els_retries_remaining--;
+		rc = efc->tt.send_els(efc, &els->io);
+	} else {
+		rc = EFC_FAIL;
+	}
+
+	if (rc) {
+		efc_log_err(efc, "ELS retries exhausted\n");
+		efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_REQ_FAIL, &cbdata);
+	}
+}
+
+static int
+efc_els_acc_cb(void *arg, u32 length, int status, u32 ext_status)
+{
+	struct efc_els_io_req *els;
+	struct efc_node *node;
+	struct efc *efc;
+	struct efc_node_cb cbdata;
+
+	els = arg;
+	node = els->node;
+	efc = node->efc;
+
+	cbdata.status = status;
+	cbdata.ext_status = ext_status;
+	cbdata.header = NULL;
+	cbdata.els_rsp = els->io.rsp;
+
+	/* Post node event */
+	switch (status) {
+	case SLI4_FC_WCQE_STATUS_SUCCESS:
+		efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_CMPL_OK, &cbdata);
+		break;
+
+	default:	/* Other error */
+		efc_log_warn(efc, "[%s] %-8s failed status x%x, ext x%x\n",
+			     node->display_name, els->display_name,
+			     status, ext_status);
+		efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_CMPL_FAIL, &cbdata);
+		break;
+	}
+
+	return EFC_SUCCESS;
+}
+
+static int
+efc_els_send_rsp(struct efc_els_io_req *els, u32 rsplen)
+{
+	int rc = EFC_SUCCESS;
+	struct efc_node_cb cbdata;
+	struct efc_node *node = els->node;
+	struct efc *efc = node->efc;
+
+	/* increment ELS completion counter */
+	node->els_cmpl_cnt++;
+
+	els->io.io_type = EFC_DISC_IO_ELS_RESP;
+	els->cb = efc_els_acc_cb;
+
+	/* Prepare the IO request details */
+	els->io.xmit_len = rsplen;
+	els->io.rsp_len = els->io.rsp.size;
+	els->io.rpi = node->rnode.indicator;
+	els->io.vpi = node->nport->indicator;
+	if (node->nport->fc_id != U32_MAX)
+		els->io.s_id = node->nport->fc_id;
+	else
+		els->io.s_id = els->io.iparam.els.s_id;
+	els->io.d_id = node->rnode.fc_id;
+
+	if (node->attached)
+		els->io.rpi_registered = true;
+
+	rc = efc->tt.send_els(efc, &els->io);
+	if (!rc)
+		return rc;
+
+	cbdata.status = EFC_STATUS_INVALID;
+	cbdata.ext_status = EFC_STATUS_INVALID;
+	cbdata.els_rsp = els->io.rsp;
+	efc_els_io_cleanup(els, EFC_EVT_SRRS_ELS_CMPL_FAIL, &cbdata);
+
+	return rc;
+}
+
+int
+efc_send_plogi(struct efc_node *node)
+{
+	struct efc_els_io_req *els;
+	struct efc *efc = node->efc;
+	struct fc_els_flogi  *plogi;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*plogi));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+	els->display_name = "plogi";
+
+	/* Build PLOGI request */
+	plogi = els->io.req.virt;
+
+	memcpy(plogi, node->nport->service_params, sizeof(*plogi));
+
+	plogi->fl_cmd = ELS_PLOGI;
+	memset(plogi->_fl_resvd, 0, sizeof(plogi->_fl_resvd));
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_ELS_REQ);
+}
+
+int
+efc_send_flogi(struct efc_node *node)
+{
+	struct efc_els_io_req *els;
+	struct efc *efc;
+	struct fc_els_flogi  *flogi;
+
+	efc = node->efc;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*flogi));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "flogi";
+
+	/* Build FLOGI request */
+	flogi = els->io.req.virt;
+
+	memcpy(flogi, node->nport->service_params, sizeof(*flogi));
+	flogi->fl_cmd = ELS_FLOGI;
+	memset(flogi->_fl_resvd, 0, sizeof(flogi->_fl_resvd));
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_ELS_REQ);
+}
+
+int
+efc_send_fdisc(struct efc_node *node)
+{
+	struct efc_els_io_req *els;
+	struct efc *efc;
+	struct fc_els_flogi *fdisc;
+
+	efc = node->efc;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*fdisc));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "fdisc";
+
+	/* Build FDISC request */
+	fdisc = els->io.req.virt;
+
+	memcpy(fdisc, node->nport->service_params, sizeof(*fdisc));
+	fdisc->fl_cmd = ELS_FDISC;
+	memset(fdisc->_fl_resvd, 0, sizeof(fdisc->_fl_resvd));
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_ELS_REQ);
+}
+
+int
+efc_send_prli(struct efc_node *node)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els;
+	struct {
+		struct fc_els_prli prli;
+		struct fc_els_spp spp;
+	} *pp;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*pp));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "prli";
+
+	/* Build PRLI request */
+	pp = els->io.req.virt;
+
+	memset(pp, 0, sizeof(*pp));
+
+	pp->prli.prli_cmd = ELS_PRLI;
+	pp->prli.prli_spp_len = 16;
+	pp->prli.prli_len = cpu_to_be16(sizeof(*pp));
+	pp->spp.spp_type = FC_TYPE_FCP;
+	pp->spp.spp_type_ext = 0;
+	pp->spp.spp_flags = FC_SPP_EST_IMG_PAIR;
+	pp->spp.spp_params = cpu_to_be32(FCP_SPPF_RD_XRDY_DIS |
+			       (node->nport->enable_ini ?
+			       FCP_SPPF_INIT_FCN : 0) |
+			       (node->nport->enable_tgt ?
+			       FCP_SPPF_TARG_FCN : 0));
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_ELS_REQ);
+}
+
+int
+efc_send_logo(struct efc_node *node)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els;
+	struct fc_els_logo *logo;
+	struct fc_els_flogi  *sparams;
+
+	node_els_trace();
+
+	sparams = (struct fc_els_flogi *)node->nport->service_params;
+
+	els = efc_els_io_alloc(node, sizeof(*logo));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "logo";
+
+	/* Build LOGO request */
+
+	logo = els->io.req.virt;
+
+	memset(logo, 0, sizeof(*logo));
+	logo->fl_cmd = ELS_LOGO;
+	hton24(logo->fl_n_port_id, node->rnode.nport->fc_id);
+	logo->fl_n_port_wwn = sparams->fl_wwpn;
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_ELS_REQ);
+}
+
+int
+efc_send_adisc(struct efc_node *node)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els;
+	struct fc_els_adisc *adisc;
+	struct fc_els_flogi  *sparams;
+	struct efc_nport *nport = node->nport;
+
+	node_els_trace();
+
+	sparams = (struct fc_els_flogi *)node->nport->service_params;
+
+	els = efc_els_io_alloc(node, sizeof(*adisc));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "adisc";
+
+	/* Build ADISC request */
+
+	adisc = els->io.req.virt;
+
+	memset(adisc, 0, sizeof(*adisc));
+	adisc->adisc_cmd = ELS_ADISC;
+	hton24(adisc->adisc_hard_addr, nport->fc_id);
+	adisc->adisc_wwpn = sparams->fl_wwpn;
+	adisc->adisc_wwnn = sparams->fl_wwnn;
+	hton24(adisc->adisc_port_id, node->rnode.nport->fc_id);
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_ELS_REQ);
+}
+
+int
+efc_send_scr(struct efc_node *node)
+{
+	struct efc_els_io_req *els;
+	struct efc *efc = node->efc;
+	struct fc_els_scr *req;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*req));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "scr";
+
+	req = els->io.req.virt;
+
+	memset(req, 0, sizeof(*req));
+	req->scr_cmd = ELS_SCR;
+	req->scr_reg_func = ELS_SCRF_FULL;
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_ELS_REQ);
+}
+
+int
+efc_send_ls_rjt(struct efc_node *node, u32 ox_id, u32 reason_code,
+		u32 reason_code_expl, u32 vendor_unique)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els = NULL;
+	struct fc_els_ls_rjt *rjt;
+
+	els = efc_els_io_alloc(node, sizeof(*rjt));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	node_els_trace();
+
+	els->display_name = "ls_rjt";
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+
+	rjt = els->io.req.virt;
+	memset(rjt, 0, sizeof(*rjt));
+
+	rjt->er_cmd = ELS_LS_RJT;
+	rjt->er_reason = reason_code;
+	rjt->er_explan = reason_code_expl;
+
+	return efc_els_send_rsp(els, sizeof(*rjt));
+}
+
+int
+efc_send_plogi_acc(struct efc_node *node, u32 ox_id)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els = NULL;
+	struct fc_els_flogi  *plogi;
+	struct fc_els_flogi  *req = (struct fc_els_flogi *)node->service_params;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*plogi));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "plogi_acc";
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+
+	plogi = els->io.req.virt;
+
+	/* copy our port's service parameters to payload */
+	memcpy(plogi, node->nport->service_params, sizeof(*plogi));
+	plogi->fl_cmd = ELS_LS_ACC;
+	memset(plogi->_fl_resvd, 0, sizeof(plogi->_fl_resvd));
+
+	/* Set Application header support bit if requested */
+	if (req->fl_csp.sp_features & cpu_to_be16(FC_SP_FT_BCAST))
+		plogi->fl_csp.sp_features |= cpu_to_be16(FC_SP_FT_BCAST);
+
+	return efc_els_send_rsp(els, sizeof(*plogi));
+}
+
+int
+efc_send_flogi_p2p_acc(struct efc_node *node, u32 ox_id, u32 s_id)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els = NULL;
+	struct fc_els_flogi  *flogi;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*flogi));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "flogi_p2p_acc";
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+	els->io.iparam.els.s_id = s_id;
+
+	flogi = els->io.req.virt;
+
+	/* copy our port's service parameters to payload */
+	memcpy(flogi, node->nport->service_params, sizeof(*flogi));
+	flogi->fl_cmd = ELS_LS_ACC;
+	memset(flogi->_fl_resvd, 0, sizeof(flogi->_fl_resvd));
+
+	memset(flogi->fl_cssp, 0, sizeof(flogi->fl_cssp));
+
+	return efc_els_send_rsp(els, sizeof(*flogi));
+}
+
+int
+efc_send_prli_acc(struct efc_node *node, u32 ox_id)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els = NULL;
+	struct {
+		struct fc_els_prli prli;
+		struct fc_els_spp spp;
+	} *pp;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*pp));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "prli_acc";
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+
+	pp = els->io.req.virt;
+	memset(pp, 0, sizeof(*pp));
+
+	pp->prli.prli_cmd = ELS_LS_ACC;
+	pp->prli.prli_spp_len = 0x10;
+	pp->prli.prli_len = cpu_to_be16(sizeof(*pp));
+	pp->spp.spp_type = FC_TYPE_FCP;
+	pp->spp.spp_type_ext = 0;
+	pp->spp.spp_flags = FC_SPP_EST_IMG_PAIR | FC_SPP_RESP_ACK;
+
+	pp->spp.spp_params = cpu_to_be32(FCP_SPPF_RD_XRDY_DIS |
+					(node->nport->enable_ini ?
+					 FCP_SPPF_INIT_FCN : 0) |
+					(node->nport->enable_tgt ?
+					 FCP_SPPF_TARG_FCN : 0));
+
+	return efc_els_send_rsp(els, sizeof(*pp));
+}
+
+int
+efc_send_prlo_acc(struct efc_node *node, u32 ox_id)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els = NULL;
+	struct {
+		struct fc_els_prlo prlo;
+		struct fc_els_spp spp;
+	} *pp;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*pp));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "prlo_acc";
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+
+	pp = els->io.req.virt;
+	memset(pp, 0, sizeof(*pp));
+	pp->prlo.prlo_cmd = ELS_LS_ACC;
+	pp->prlo.prlo_obs = 0x10;
+	pp->prlo.prlo_len = cpu_to_be16(sizeof(*pp));
+
+	pp->spp.spp_type = FC_TYPE_FCP;
+	pp->spp.spp_type_ext = 0;
+	pp->spp.spp_flags = FC_SPP_RESP_ACK;
+
+	return efc_els_send_rsp(els, sizeof(*pp));
+}
+
+int
+efc_send_ls_acc(struct efc_node *node, u32 ox_id)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els = NULL;
+	struct fc_els_ls_acc *acc;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*acc));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "ls_acc";
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+
+	acc = els->io.req.virt;
+	memset(acc, 0, sizeof(*acc));
+
+	acc->la_cmd = ELS_LS_ACC;
+
+	return efc_els_send_rsp(els, sizeof(*acc));
+}
+
+int
+efc_send_logo_acc(struct efc_node *node, u32 ox_id)
+{
+	struct efc_els_io_req *els = NULL;
+	struct efc *efc = node->efc;
+	struct fc_els_ls_acc *logo;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*logo));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "logo_acc";
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+
+	logo = els->io.req.virt;
+	memset(logo, 0, sizeof(*logo));
+
+	logo->la_cmd = ELS_LS_ACC;
+
+	return efc_els_send_rsp(els, sizeof(*logo));
+}
+
+int
+efc_send_adisc_acc(struct efc_node *node, u32 ox_id)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els = NULL;
+	struct fc_els_adisc *adisc;
+	struct fc_els_flogi  *sparams;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*adisc));
+	if (!els) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->display_name = "adisc_acc";
+
+	/* Go ahead and send the ELS_ACC */
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+	els->io.iparam.els.ox_id = ox_id;
+
+	sparams = (struct fc_els_flogi  *)node->nport->service_params;
+	adisc = els->io.req.virt;
+	memset(adisc, 0, sizeof(*adisc));
+	adisc->adisc_cmd = ELS_LS_ACC;
+	adisc->adisc_wwpn = sparams->fl_wwpn;
+	adisc->adisc_wwnn = sparams->fl_wwnn;
+	hton24(adisc->adisc_port_id, node->rnode.nport->fc_id);
+
+	return efc_els_send_rsp(els, sizeof(*adisc));
+}
+
+static inline void
+fcct_build_req_header(struct fc_ct_hdr  *hdr, u16 cmd, u16 max_size)
+{
+	hdr->ct_rev = FC_CT_REV;
+	hdr->ct_fs_type = FC_FST_DIR;
+	hdr->ct_fs_subtype = FC_NS_SUBTYPE;
+	hdr->ct_options = 0;
+	hdr->ct_cmd = cpu_to_be16(cmd);
+	/* words */
+	hdr->ct_mr_size = cpu_to_be16(max_size / (sizeof(u32)));
+	hdr->ct_reason = 0;
+	hdr->ct_explan = 0;
+	hdr->ct_vendor = 0;
+}
+
+int
+efc_ns_send_rftid(struct efc_node *node)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els;
+	struct {
+		struct fc_ct_hdr hdr;
+		struct fc_ns_rft_id rftid;
+	} *ct;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*ct));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->io.iparam.ct.r_ctl = FC_RCTL_ELS_REQ;
+	els->io.iparam.ct.type = FC_TYPE_CT;
+	els->io.iparam.ct.df_ctl = 0;
+	els->io.iparam.ct.timeout = EFC_FC_ELS_SEND_DEFAULT_TIMEOUT;
+
+	els->display_name = "rftid";
+
+	ct = els->io.req.virt;
+	memset(ct, 0, sizeof(*ct));
+	fcct_build_req_header(&ct->hdr, FC_NS_RFT_ID,
+				sizeof(struct fc_ns_rft_id));
+
+	hton24(ct->rftid.fr_fid.fp_fid, node->rnode.nport->fc_id);
+	ct->rftid.fr_fts.ff_type_map[FC_TYPE_FCP / FC_NS_BPW] =
+		cpu_to_be32(1 << (FC_TYPE_FCP % FC_NS_BPW));
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_CT_REQ);
+}
+
+int
+efc_ns_send_rffid(struct efc_node *node)
+{
+	struct efc *efc = node->efc;
+	struct efc_els_io_req *els;
+	struct {
+		struct fc_ct_hdr hdr;
+		struct fc_ns_rff_id rffid;
+	} *ct;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc(node, sizeof(*ct));
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->io.iparam.ct.r_ctl = FC_RCTL_ELS_REQ;
+	els->io.iparam.ct.type = FC_TYPE_CT;
+	els->io.iparam.ct.df_ctl = 0;
+	els->io.iparam.ct.timeout = EFC_FC_ELS_SEND_DEFAULT_TIMEOUT;
+
+	els->display_name = "rffid";
+	ct = els->io.req.virt;
+
+	memset(ct, 0, sizeof(*ct));
+	fcct_build_req_header(&ct->hdr, FC_NS_RFF_ID,
+			      sizeof(struct fc_ns_rff_id));
+
+	hton24(ct->rffid.fr_fid.fp_fid, node->rnode.nport->fc_id);
+	if (node->nport->enable_ini)
+		ct->rffid.fr_feat |= FCP_FEAT_INIT;
+	if (node->nport->enable_tgt)
+		ct->rffid.fr_feat |= FCP_FEAT_TARG;
+	ct->rffid.fr_type = FC_TYPE_FCP;
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_CT_REQ);
+}
+
+int
+efc_ns_send_gidpt(struct efc_node *node)
+{
+	struct efc_els_io_req *els = NULL;
+	struct efc *efc = node->efc;
+	struct {
+		struct fc_ct_hdr hdr;
+		struct fc_ns_gid_pt gidpt;
+	} *ct;
+
+	node_els_trace();
+
+	els = efc_els_io_alloc_size(node, sizeof(*ct), EFC_ELS_GID_PT_RSP_LEN);
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	els->io.iparam.ct.r_ctl = FC_RCTL_ELS_REQ;
+	els->io.iparam.ct.type = FC_TYPE_CT;
+	els->io.iparam.ct.df_ctl = 0;
+	els->io.iparam.ct.timeout = EFC_FC_ELS_SEND_DEFAULT_TIMEOUT;
+
+	els->display_name = "gidpt";
+
+	ct = els->io.req.virt;
+
+	memset(ct, 0, sizeof(*ct));
+	fcct_build_req_header(&ct->hdr, FC_NS_GID_PT,
+			      sizeof(struct fc_ns_gid_pt));
+
+	ct->gidpt.fn_pt_type = FC_TYPE_FCP;
+
+	return efc_els_send_req(node, els, EFC_DISC_IO_CT_REQ);
+}
+
+void
+efc_els_io_cleanup(struct efc_els_io_req *els, int evt, void *arg)
+{
+	/* don't want further events that could come; e.g. abort requests
+	 * from the node state machine; thus, disable state machine
+	 */
+	els->els_req_free = true;
+	efc_node_post_els_resp(els->node, evt, arg);
+
+	efc_els_io_free(els);
+}
+
+static int
+efc_ct_acc_cb(void *arg, u32 length, int status, u32 ext_status)
+{
+	struct efc_els_io_req *els = arg;
+
+	efc_els_io_free(els);
+
+	return EFC_SUCCESS;
+}
+
+int
+efc_send_ct_rsp(struct efc *efc, struct efc_node *node, u16 ox_id,
+		 struct fc_ct_hdr *ct_hdr, u32 cmd_rsp_code,
+		 u32 reason_code, u32 reason_code_explanation)
+{
+	struct efc_els_io_req *els = NULL;
+	struct fc_ct_hdr  *rsp = NULL;
+
+	els = efc_els_io_alloc(node, 256);
+	if (!els) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return EFC_FAIL;
+	}
+
+	rsp = els->io.rsp.virt;
+
+	*rsp = *ct_hdr;
+
+	fcct_build_req_header(rsp, cmd_rsp_code, 0);
+	rsp->ct_reason = reason_code;
+	rsp->ct_explan = reason_code_explanation;
+
+	els->display_name = "ct_rsp";
+	els->cb = efc_ct_acc_cb;
+
+	/* Prepare the IO request details */
+	els->io.io_type = EFC_DISC_IO_CT_RESP;
+	els->io.xmit_len = sizeof(*rsp);
+
+	els->io.rpi = node->rnode.indicator;
+	els->io.d_id = node->rnode.fc_id;
+
+	memset(&els->io.iparam, 0, sizeof(els->io.iparam));
+
+	els->io.iparam.ct.ox_id = ox_id;
+	els->io.iparam.ct.r_ctl = 3;
+	els->io.iparam.ct.type = FC_TYPE_CT;
+	els->io.iparam.ct.df_ctl = 0;
+	els->io.iparam.ct.timeout = 5;
+
+	if (efc->tt.send_els(efc, &els->io)) {
+		efc_els_io_free(els);
+		return EFC_FAIL;
+	}
+	return EFC_SUCCESS;
+}
+
+int
+efc_send_bls_acc(struct efc_node *node, struct fc_frame_header *hdr)
+{
+	struct sli_bls_params bls;
+	struct fc_ba_acc *acc;
+	struct efc *efc = node->efc;
+
+	memset(&bls, 0, sizeof(bls));
+	bls.ox_id = be16_to_cpu(hdr->fh_ox_id);
+	bls.rx_id = be16_to_cpu(hdr->fh_rx_id);
+	bls.s_id = ntoh24(hdr->fh_d_id);
+	bls.d_id = node->rnode.fc_id;
+	bls.rpi = node->rnode.indicator;
+	bls.vpi = node->nport->indicator;
+
+	acc = (void *)bls.payload;
+	acc->ba_ox_id = cpu_to_be16(bls.ox_id);
+	acc->ba_rx_id = cpu_to_be16(bls.rx_id);
+	acc->ba_high_seq_cnt = cpu_to_be16(U16_MAX);
+
+	return efc->tt.send_bls(efc, FC_RCTL_BA_ACC, &bls);
+}
diff --git a/drivers/scsi/elx/libefc/efc_els.h b/drivers/scsi/elx/libefc/efc_els.h
new file mode 100644
index 000000000000..29926e690ec4
--- /dev/null
+++ b/drivers/scsi/elx/libefc/efc_els.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#ifndef __EFC_ELS_H__
+#define __EFC_ELS_H__
+
+#define EFC_STATUS_INVALID	INT_MAX
+#define EFC_ELS_IO_POOL_SZ	1024
+
+struct efc_els_io_req {
+	struct list_head	list_entry;
+	struct kref		ref;
+	void			(*release)(struct kref *arg);
+	struct efc_node		*node;
+	void			*cb;
+	uint32_t		els_retries_remaining;
+	bool			els_req_free;
+	struct timer_list       delay_timer;
+
+	const char		*display_name;
+
+	struct efc_disc_io	io;
+};
+
+typedef int(*efc_hw_srrs_cb_t)(void *arg, u32 length, int status,
+			       u32 ext_status);
+
+void _efc_els_io_free(struct kref *arg);
+struct efc_els_io_req *
+efc_els_io_alloc(struct efc_node *node, u32 reqlen);
+struct efc_els_io_req *
+efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen);
+void efc_els_io_free(struct efc_els_io_req *els);
+
+/* ELS command send */
+typedef void (*els_cb_t)(struct efc_node *node,
+			 struct efc_node_cb *cbdata, void *arg);
+int
+efc_send_plogi(struct efc_node *node);
+int
+efc_send_flogi(struct efc_node *node);
+int
+efc_send_fdisc(struct efc_node *node);
+int
+efc_send_prli(struct efc_node *node);
+int
+efc_send_prlo(struct efc_node *node);
+int
+efc_send_logo(struct efc_node *node);
+int
+efc_send_adisc(struct efc_node *node);
+int
+efc_send_pdisc(struct efc_node *node);
+int
+efc_send_scr(struct efc_node *node);
+int
+efc_ns_send_rftid(struct efc_node *node);
+int
+efc_ns_send_rffid(struct efc_node *node);
+int
+efc_ns_send_gidpt(struct efc_node *node);
+void
+efc_els_io_cleanup(struct efc_els_io_req *els, int evt, void *arg);
+
+/* ELS acc send */
+int
+efc_send_ls_acc(struct efc_node *node, u32 ox_id);
+int
+efc_send_ls_rjt(struct efc_node *node, u32 ox_id, u32 reason_cod,
+		u32 reason_code_expl, u32 vendor_unique);
+int
+efc_send_flogi_p2p_acc(struct efc_node *node, u32 ox_id, u32 s_id);
+int
+efc_send_flogi_acc(struct efc_node *node, u32 ox_id, u32 is_fport);
+int
+efc_send_plogi_acc(struct efc_node *node, u32 ox_id);
+int
+efc_send_prli_acc(struct efc_node *node, u32 ox_id);
+int
+efc_send_logo_acc(struct efc_node *node, u32 ox_id);
+int
+efc_send_prlo_acc(struct efc_node *node, u32 ox_id);
+int
+efc_send_adisc_acc(struct efc_node *node, u32 ox_id);
+
+int
+efc_bls_send_acc_hdr(struct efc *efc, struct efc_node *node,
+		     struct fc_frame_header *hdr);
+int
+efc_bls_send_rjt_hdr(struct efc_els_io_req *io, struct fc_frame_header *hdr);
+
+int
+efc_els_io_list_empty(struct efc_node *node, struct list_head *list);
+
+/* CT */
+int
+efc_send_ct_rsp(struct efc *efc, struct efc_node *node, u16 ox_id,
+		 struct fc_ct_hdr *ct_hdr, u32 cmd_rsp_code, u32 reason_code,
+		 u32 reason_code_explanation);
+
+int
+efc_send_bls_acc(struct efc_node *node, struct fc_frame_header *hdr);
+
+#endif /* __EFC_ELS_H__ */
-- 
2.26.2

