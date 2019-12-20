Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95560128509
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 23:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLTWiA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 17:38:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40840 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfLTWh7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Dec 2019 17:37:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so5636825pgt.7
        for <linux-scsi@vger.kernel.org>; Fri, 20 Dec 2019 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HqmjWsFIwz1PVHx2KATusHxMl1p4WOMbmZBZyGsdzk=;
        b=Hbhm57iza7+zEPLNjwu3nm6mEUj/ZvvxrnJ7z8p3go/YilLBMRASCbzew6xuV2f8NL
         fT41ZHnETwy0fCZnRO9ituMU5gn64lxF4hnMI7d38TwYWwyLvdlCkG6YqXGFzlD2RAom
         ETe+6PmfUDQ+aMBWckHiF8YGSP0+ZXcMpIIP0tg8bzGGeGqvGDHz6pmepKA7wWVqiK1s
         1TcR+yLzG5dNyCVh7U5I/z+zJhGvqMhyGTJyhp+dpdLVIqZYNxgraB5WFoxNjd9l838B
         dENQV+MKH5XVzsS4H+pyZRtGgr2svggYVivhtEuqdSdE9cQGAIOEj7fFTu+j74mguGt3
         NRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HqmjWsFIwz1PVHx2KATusHxMl1p4WOMbmZBZyGsdzk=;
        b=EqzNqGjP/Ri0wm+R8IxiaSYhDt6+rxyGE5Zx1NrY3+WCcGUwf0coewneda+oeYQW35
         bJmDu4jrTsmChU6doT7pJjntir1tIbdfK4xZHBg1PJyi/Rs7OUhXH0btf1hHxhAvkIeE
         CxBO056n+KkhKoTZuAIvO7OvmlPsBdc4PsF/9OoNyenXtZPLyvCXNVvYtbWnzzer+IpN
         rJjSb2DYnoZ16rTLcmU+q8UOdPwxohH0VDbfabLN9+/RygfpokRiXC9COlpgvyMDvRQ2
         mTOKTcPuylMTvj7l0TgrfXYiYoJsW9L3CGwZa5LhtvZWOTwiWxs5OPFhdnDWeUtgp6K4
         QJNw==
X-Gm-Message-State: APjAAAUpx7DDnjRNL6gIrOIi2NbbOadklzHoOwXweNLGEN5HjSQ+2/qV
        tZgxl74MAHZrEZ6mMuMylkQ2aEMw
X-Google-Smtp-Source: APXvYqyaek353yjIJ35nj5PcXHzbhksfuHw4Ik3S1Ujz2jODPm0J3XScNvLy/Y0RaV129rfOb3vEYQ==
X-Received: by 2002:a63:5807:: with SMTP id m7mr16256151pgb.83.1576881476779;
        Fri, 20 Dec 2019 14:37:56 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j28sm12219877pgb.36.2019.12.20.14.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 14:37:56 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     maier@linux.ibm.com, dwagner@suse.de, bvanassche@acm.org,
        James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [PATCH v2 22/32] elx: efct: Extended link Service IO handling
Date:   Fri, 20 Dec 2019 14:37:13 -0800
Message-Id: <20191220223723.26563-23-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191220223723.26563-1-jsmart2021@gmail.com>
References: <20191220223723.26563-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the efct driver population.

This patch adds driver definitions for:
Functions to build and send ELS/CT/BLS commands and responses.

Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/elx/efct/efct_els.c | 1953 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/elx/efct/efct_els.h |  136 +++
 2 files changed, 2089 insertions(+)
 create mode 100644 drivers/scsi/elx/efct/efct_els.c
 create mode 100644 drivers/scsi/elx/efct/efct_els.h

diff --git a/drivers/scsi/elx/efct/efct_els.c b/drivers/scsi/elx/efct/efct_els.c
new file mode 100644
index 000000000000..9c964302505b
--- /dev/null
+++ b/drivers/scsi/elx/efct/efct_els.c
@@ -0,0 +1,1953 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Functions to build and send ELS/CT/BLS commands and responses.
+ */
+
+#include "efct_driver.h"
+#include "efct_els.h"
+
+#define ELS_IOFMT "[i:%04x t:%04x h:%04x]"
+
+#define node_els_trace()  \
+	do { \
+		if (EFCT_LOG_ENABLE_ELS_TRACE(efct)) \
+			efc_log_info(efct, "[%s] %-20s\n", \
+				node->display_name, __func__); \
+	} while (0)
+
+#define els_io_printf(els, fmt, ...) \
+	efc_log_debug((struct efct *)els->node->efc->base,\
+		      "[%s]" ELS_IOFMT " %-8s " fmt, \
+		      els->node->display_name,\
+		      els->init_task_tag, els->tgt_task_tag, els->hw_tag,\
+		      els->display_name, ##__VA_ARGS__)
+
+#define EFCT_ELS_RSP_LEN		1024
+#define EFCT_ELS_GID_PT_RSP_LEN		8096
+
+void *
+efct_els_req_send(struct efc *efc, struct efc_node *node, u32 cmd,
+		  u32 timeout_sec, u32 retries)
+{
+	struct efct *efct = efc->base;
+
+	switch (cmd) {
+	case ELS_PLOGI:
+		efc_log_debug(efct, "send efct_send_plogi\n");
+		efct_send_plogi(node, timeout_sec, retries, NULL, NULL);
+		break;
+	case ELS_FLOGI:
+		efc_log_debug(efct, "send efct_send_flogi\n");
+		efct_send_flogi(node, timeout_sec, retries, NULL, NULL);
+		break;
+	case ELS_LOGO:
+		efc_log_debug(efct, "send efct_send_logo\n");
+		efct_send_logo(node, timeout_sec, retries, NULL, NULL);
+		break;
+	case ELS_PRLI:
+		efc_log_debug(efct, "send efct_send_prli\n");
+		efct_send_prli(node, timeout_sec, retries, NULL, NULL);
+		break;
+	case ELS_ADISC:
+		efc_log_debug(efct, "send efct_send_prli\n");
+		efct_send_adisc(node, timeout_sec, retries, NULL, NULL);
+		break;
+	case ELS_SCR:
+		efc_log_debug(efct, "send efct_send_scr\n");
+		efct_send_scr(node, timeout_sec, retries, NULL, NULL);
+		break;
+	default:
+		efc_log_debug(efct, "Unhandled command cmd: %x\n", cmd);
+	}
+
+	return NULL;
+}
+
+void *
+efct_els_resp_send(struct efc *efc, struct efc_node *node,
+		   u32 cmd, u16 ox_id)
+{
+	struct efct *efct = efc->base;
+
+	switch (cmd) {
+	case ELS_PLOGI:
+		efct_send_plogi_acc(node, ox_id, NULL, NULL);
+		break;
+	case ELS_FLOGI:
+		efct_send_flogi_acc(node, ox_id, 0, NULL, NULL);
+		break;
+	case ELS_LOGO:
+		efct_send_logo_acc(node, ox_id, NULL, NULL);
+		break;
+	case ELS_PRLI:
+		efct_send_prli_acc(node, ox_id, NULL, NULL);
+		break;
+	case ELS_PRLO:
+		efct_send_prlo_acc(node, ox_id, NULL, NULL);
+		break;
+	case ELS_ADISC:
+		efct_send_adisc_acc(node, ox_id, NULL, NULL);
+		break;
+	case ELS_LS_ACC:
+		efct_send_ls_acc(node, ox_id, NULL, NULL);
+		break;
+	case ELS_PDISC:
+	case ELS_FDISC:
+	case ELS_RSCN:
+	case ELS_SCR:
+		efct_send_ls_rjt(efc, node, ox_id, ELS_RJT_UNAB,
+				 ELS_EXPL_NONE, 0);
+		break;
+	default:
+		efc_log_err(efct, "Unhandled command cmd: %x\n", cmd);
+	}
+
+	return NULL;
+}
+
+struct efct_io *
+efct_els_io_alloc(struct efc_node *node, u32 reqlen,
+		  enum efct_els_role role)
+{
+	return efct_els_io_alloc_size(node, reqlen, EFCT_ELS_RSP_LEN, role);
+}
+
+struct efct_io *
+efct_els_io_alloc_size(struct efc_node *node, u32 reqlen,
+		       u32 rsplen, enum efct_els_role role)
+{
+	struct efct *efct;
+	struct efct_xport *xport;
+	struct efct_io *els;
+	unsigned long flags = 0;
+
+	efct = node->efc->base;
+
+	xport = efct->xport;
+
+	spin_lock_irqsave(&node->active_ios_lock, flags);
+
+	if (!node->io_alloc_enabled) {
+		efc_log_debug(efct,
+			       "called with io_alloc_enabled = FALSE\n");
+		spin_unlock_irqrestore(&node->active_ios_lock, flags);
+		return NULL;
+	}
+
+	els = efct_io_pool_io_alloc(efct->xport->io_pool);
+	if (!els) {
+		atomic_add_return(1, &xport->io_alloc_failed_count);
+		spin_unlock_irqrestore(&node->active_ios_lock, flags);
+		return NULL;
+	}
+
+	/* initialize refcount */
+	kref_init(&els->ref);
+	els->release = _efct_els_io_free;
+
+	switch (role) {
+	case EFCT_ELS_ROLE_ORIGINATOR:
+		els->cmd_ini = true;
+		els->cmd_tgt = false;
+		break;
+	case EFCT_ELS_ROLE_RESPONDER:
+		els->cmd_ini = false;
+		els->cmd_tgt = true;
+		break;
+	}
+
+	/* IO should not have an associated HW IO yet.
+	 * Assigned below.
+	 */
+	if (els->hio) {
+		efc_log_err(efct,
+			     "assertion failed.  HIO is not null\n");
+		efct_io_pool_io_free(efct->xport->io_pool, els);
+		spin_unlock_irqrestore(&node->active_ios_lock, flags);
+		return NULL;
+	}
+
+	/* populate generic io fields */
+	els->efct = efct;
+	els->node = node;
+
+	/* set type and ELS-specific fields */
+	els->io_type = EFCT_IO_TYPE_ELS;
+	els->display_name = "pending";
+
+	/* now allocate DMA for request and response */
+	els->els_req.size = reqlen;
+	els->els_req.virt = dma_alloc_coherent(&efct->pcidev->dev,
+					       els->els_req.size,
+					       &els->els_req.phys,
+					       GFP_DMA);
+	if (els->els_req.virt) {
+		els->els_rsp.size = rsplen;
+		els->els_rsp.virt = dma_alloc_coherent(&efct->pcidev->dev,
+						       els->els_rsp.size,
+						       &els->els_rsp.phys,
+						       GFP_DMA);
+		if (!els->els_rsp.virt) {
+			efc_log_err(efct, "dma_alloc rsp\n");
+			dma_free_coherent(&efct->pcidev->dev,
+					  els->els_req.size,
+				els->els_req.virt, els->els_req.phys);
+			efct_io_pool_io_free(efct->xport->io_pool, els);
+			els = NULL;
+		}
+	} else {
+		efc_log_err(efct, "dma_alloc req\n");
+		efct_io_pool_io_free(efct->xport->io_pool, els);
+		els = NULL;
+	}
+
+	if (els) {
+		/* initialize fields */
+		els->els_retries_remaining =
+					EFCT_FC_ELS_DEFAULT_RETRIES;
+		els->els_pend = false;
+		els->els_active = false;
+
+		/* add els structure to ELS IO list */
+		INIT_LIST_HEAD(&els->list_entry);
+		list_add_tail(&els->list_entry,
+			      &node->els_io_pend_list);
+		els->els_pend = true;
+	}
+
+	spin_unlock_irqrestore(&node->active_ios_lock, flags);
+	return els;
+}
+
+void
+efct_els_io_free(struct efct_io *els)
+{
+	kref_put(&els->ref, els->release);
+}
+
+void
+_efct_els_io_free(struct kref *arg)
+{
+	struct efct_io *els = container_of(arg, struct efct_io, ref);
+	struct efct *efct;
+	struct efc_node *node;
+	int send_empty_event = false;
+	unsigned long flags = 0;
+
+	node = els->node;
+	efct = node->efc->base;
+
+	spin_lock_irqsave(&node->active_ios_lock, flags);
+		if (els->els_active) {
+			/* if active, remove from active list and check empty */
+			list_del(&els->list_entry);
+			/* Send list empty event if the IO allocator
+			 * is disabled, and the list is empty
+			 * If node->io_alloc_enabled was not checked,
+			 * the event would be posted continually
+			 */
+			send_empty_event = (!node->io_alloc_enabled) &&
+				list_empty(&node->els_io_active_list);
+			els->els_active = false;
+		} else if (els->els_pend) {
+			/* if pending, remove from pending list;
+			 * node shutdown isn't gated off the
+			 * pending list (only the active list),
+			 * so no need to check if pending list is empty
+			 */
+			list_del(&els->list_entry);
+			els->els_pend = 0;
+		} else {
+			efc_log_err(efct,
+				     "assertion fail: niether els_pend nor active set\n");
+			spin_unlock_irqrestore(&node->active_ios_lock, flags);
+			return;
+		}
+
+	spin_unlock_irqrestore(&node->active_ios_lock, flags);
+
+	/* free ELS request and response buffers */
+	dma_free_coherent(&efct->pcidev->dev, els->els_rsp.size,
+			  els->els_rsp.virt, els->els_rsp.phys);
+	dma_free_coherent(&efct->pcidev->dev, els->els_req.size,
+			  els->els_req.virt, els->els_req.phys);
+
+	efct_io_pool_io_free(efct->xport->io_pool, els);
+
+	if (send_empty_event)
+		efc_scsi_io_list_empty(node->efc, node);
+
+	efct_scsi_check_pending(efct);
+}
+
+static void
+efct_els_make_active(struct efct_io *els)
+{
+	struct efc_node *node = els->node;
+	unsigned long flags = 0;
+
+	/* move ELS from pending list to active list */
+	spin_lock_irqsave(&node->active_ios_lock, flags);
+		if (els->els_pend) {
+			if (els->els_active) {
+				efc_log_err(node->efc,
+					     "assertion fail:both els_pend and active set\n");
+				spin_unlock_irqrestore(&node->active_ios_lock,
+						       flags);
+				return;
+			}
+			/* remove from pending list */
+			list_del(&els->list_entry);
+			els->els_pend = false;
+
+			/* add els structure to ELS IO list */
+			INIT_LIST_HEAD(&els->list_entry);
+			list_add_tail(&els->list_entry,
+				      &node->els_io_active_list);
+			els->els_active = true;
+		} else {
+			/* must be retrying; make sure it's already active */
+			if (!els->els_active) {
+				efc_log_err(node->efc,
+					     "assertion fail: niether els_pend nor active set\n");
+			}
+		}
+	spin_unlock_irqrestore(&node->active_ios_lock, flags);
+}
+
+static int efct_els_send(struct efct_io *els, u32 reqlen,
+			 u32 timeout_sec, efct_hw_srrs_cb_t cb)
+{
+	struct efc_node *node = els->node;
+
+	/* update ELS request counter */
+	node->els_req_cnt++;
+
+	/* move ELS from pending list to active list */
+	efct_els_make_active(els);
+
+	els->wire_len = reqlen;
+	return efct_scsi_io_dispatch(els, cb);
+}
+
+static void
+efct_els_retry(struct efct_io *els);
+
+static void
+efct_els_delay_timer_cb(struct timer_list *t)
+{
+	struct efct_io *els = from_timer(els, t, delay_timer);
+	struct efc_node *node = els->node;
+
+	/* Retry delay timer expired, retry the ELS request,
+	 * Free the HW IO so that a new oxid is used.
+	 */
+	if (els->state == EFCT_ELS_REQUEST_DELAY_ABORT) {
+		node->els_req_cnt++;
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_FAIL,
+					    NULL);
+	} else {
+		efct_els_retry(els);
+	}
+}
+
+static void
+efct_els_abort_cleanup(struct efct_io *els)
+{
+	/* handle event for ABORT_WQE
+	 * whatever state ELS happened to be in, propagate aborted even
+	 * up to node state machine in lieu of EFC_HW_SRRS_ELS_* event
+	 */
+	struct efc_node_cb cbdata;
+
+	cbdata.status = 0;
+	cbdata.ext_status = 0;
+	cbdata.els_rsp = els->els_rsp;
+	els_io_printf(els, "Request aborted\n");
+	efct_els_io_cleanup(els, EFC_HW_ELS_REQ_ABORTED, &cbdata);
+}
+
+static int
+efct_els_req_cb(struct efct_hw_io *hio, struct efc_remote_node *rnode,
+		u32 length, int status, u32 ext_status, void *arg)
+{
+	struct efct_io *els;
+	struct efc_node *node;
+	struct efct *efct;
+	struct efc_node_cb cbdata;
+	u32 reason_code;
+
+	els = arg;
+	node = els->node;
+	efct = node->efc->base;
+
+	if (status != 0)
+		els_io_printf(els, "status x%x ext x%x\n", status, ext_status);
+
+	/* set the response len element of els->rsp */
+	els->els_rsp.len = length;
+
+	cbdata.status = status;
+	cbdata.ext_status = ext_status;
+	cbdata.header = NULL;
+	cbdata.els_rsp = els->els_rsp;
+
+	/* FW returns the number of bytes received on the link in
+	 * the WCQE, not the amount placed in the buffer; use this info to
+	 * check if there was an overrun.
+	 */
+	if (length > els->els_rsp.size) {
+		efc_log_warn(efct,
+			      "ELS response returned len=%d > buflen=%zu\n",
+			     length, els->els_rsp.size);
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_FAIL, &cbdata);
+		return 0;
+	}
+
+	/* Post event to ELS IO object */
+	switch (status) {
+	case SLI4_FC_WCQE_STATUS_SUCCESS:
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_OK, &cbdata);
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
+				      "LS_RJT Logical Busy response,delay and retry\n");
+			timer_setup(&els->delay_timer,
+				    efct_els_delay_timer_cb, 0);
+			mod_timer(&els->delay_timer,
+				  jiffies + msecs_to_jiffies(5000));
+			els->state = EFCT_ELS_REQUEST_DELAYED;
+			break;
+		default:
+			efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_RJT,
+					    &cbdata);
+			break;
+		}
+		break;
+
+	case SLI4_FC_WCQE_STATUS_LOCAL_REJECT:
+		switch (ext_status) {
+		case SLI4_FC_LOCAL_REJECT_SEQUENCE_TIMEOUT:
+			efct_els_retry(els);
+			break;
+
+		case SLI4_FC_LOCAL_REJECT_ABORT_REQUESTED:
+			if (els->state == EFCT_ELS_ABORT_IO_COMPL) {
+				/* completion for ELS that was aborted */
+				efct_els_abort_cleanup(els);
+			} else {
+				/* completion for ELS received first,
+				 * transition to wait for abort cmpl
+				 */
+				els->state = EFCT_ELS_REQ_ABORTED;
+			}
+
+			break;
+		default:
+			efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_FAIL,
+					    &cbdata);
+			break;
+		}
+		break;
+	default:	/* Other error */
+		efc_log_warn(efct,
+			      "els req failed status x%x, ext_status, x%x\n",
+					status, ext_status);
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_FAIL, &cbdata);
+		break;
+	}
+
+	return 0;
+}
+
+static void efct_els_send_req(struct efc_node *node, struct efct_io *els)
+{
+	int rc = 0;
+	struct efct *efct;
+
+	efct = node->efc->base;
+	rc = efct_els_send(els, els->els_req.size,
+			   els->els_timeout_sec, efct_els_req_cb);
+
+	if (rc) {
+		struct efc_node_cb cbdata;
+
+		cbdata.status = INT_MAX;
+		cbdata.ext_status = INT_MAX;
+		cbdata.els_rsp = els->els_rsp;
+		efc_log_err(efct, "efct_els_send failed: %d\n", rc);
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_FAIL,
+				    &cbdata);
+	}
+}
+
+static void
+efct_els_retry(struct efct_io *els)
+{
+	struct efct *efct;
+	struct efc_node_cb cbdata;
+
+	efct = els->node->efc->base;
+	cbdata.status = INT_MAX;
+	cbdata.ext_status = INT_MAX;
+	cbdata.els_rsp = els->els_rsp;
+
+	if (!els->els_retries_remaining) {
+		efc_log_err(efct, "ELS retries exhausted\n");
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_FAIL,
+				    &cbdata);
+		return;
+	}
+
+	els->els_retries_remaining--;
+	 /* Free the HW IO so that a new oxid is used.*/
+	if (els->hio) {
+		efct_hw_io_free(&efct->hw, els->hio);
+		els->hio = NULL;
+	}
+
+	efct_els_send_req(els->node, els);
+}
+
+static int
+efct_els_acc_cb(struct efct_hw_io *hio, struct efc_remote_node *rnode,
+		u32 length, int status, u32 ext_status, void *arg)
+{
+	struct efct_io *els;
+	struct efc_node *node;
+	struct efct *efct;
+	struct efc_node_cb cbdata;
+
+	els = arg;
+	node = els->node;
+	efct = node->efc->base;
+
+	cbdata.status = status;
+	cbdata.ext_status = ext_status;
+	cbdata.header = NULL;
+	cbdata.els_rsp = els->els_rsp;
+
+	/* Post node event */
+	switch (status) {
+	case SLI4_FC_WCQE_STATUS_SUCCESS:
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_CMPL_OK, &cbdata);
+		break;
+
+	default:	/* Other error */
+		efc_log_warn(efct,
+			      "[%s] %-8s failed status x%x, ext_status x%x\n",
+			    node->display_name, els->display_name,
+			    status, ext_status);
+		efc_log_warn(efct,
+			      "els acc complete: failed status x%x, ext_status, x%x\n",
+		     status, ext_status);
+		efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_CMPL_FAIL, &cbdata);
+		break;
+	}
+
+	return 0;
+}
+
+static int
+efct_els_send_rsp(struct efct_io *els, u32 rsplen)
+{
+	struct efc_node *node = els->node;
+
+	/* increment ELS completion counter */
+	node->els_cmpl_cnt++;
+
+	/* move ELS from pending list to active list */
+	efct_els_make_active(els);
+
+	els->wire_len = rsplen;
+	return efct_scsi_io_dispatch(els, efct_els_acc_cb);
+}
+
+struct efct_io *
+efct_send_plogi(struct efc_node *node, u32 timeout_sec,
+		u32 retries,
+	      void (*cb)(struct efc_node *node,
+			 struct efc_node_cb *cbdata, void *arg), void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct = node->efc->base;
+	struct fc_els_flogi  *plogi;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*plogi), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "plogi";
+
+		/* Build PLOGI request */
+		plogi = els->els_req.virt;
+
+		memcpy(plogi, node->sport->service_params, sizeof(*plogi));
+
+		plogi->fl_cmd = ELS_PLOGI;
+		memset(plogi->_fl_resvd, 0, sizeof(plogi->_fl_resvd));
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_flogi(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct;
+	struct fc_els_flogi  *flogi;
+
+	efct = node->efc->base;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*flogi), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "flogi";
+
+		/* Build FLOGI request */
+		flogi = els->els_req.virt;
+
+		memcpy(flogi, node->sport->service_params, sizeof(*flogi));
+		flogi->fl_cmd = ELS_FLOGI;
+		memset(flogi->_fl_resvd, 0, sizeof(flogi->_fl_resvd));
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_fdisc(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct;
+	struct fc_els_flogi *fdisc;
+
+	efct = node->efc->base;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*fdisc), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "fdisc";
+
+		/* Build FDISC request */
+		fdisc = els->els_req.virt;
+
+		memcpy(fdisc, node->sport->service_params, sizeof(*fdisc));
+		fdisc->fl_cmd = ELS_FDISC;
+		memset(fdisc->_fl_resvd, 0, sizeof(fdisc->_fl_resvd));
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_prli(struct efc_node *node, u32 timeout_sec, u32 retries,
+	       els_cb_t cb, void *cbarg)
+{
+	struct efct *efct = node->efc->base;
+	struct efct_io *els;
+	struct {
+		struct fc_els_prli prli;
+		struct fc_els_spp spp;
+	} *pp;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*pp), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "prli";
+
+		/* Build PRLI request */
+		pp = els->els_req.virt;
+
+		memset(pp, 0, sizeof(*pp));
+
+		pp->prli.prli_cmd = ELS_PRLI;
+		pp->prli.prli_spp_len = 16;
+		pp->prli.prli_len = cpu_to_be16(sizeof(*pp));
+		pp->spp.spp_type = FC_TYPE_FCP;
+		pp->spp.spp_type_ext = 0;
+		pp->spp.spp_flags = FC_SPP_EST_IMG_PAIR;
+		pp->spp.spp_params = cpu_to_be32(FCP_SPPF_RD_XRDY_DIS |
+				       (node->sport->enable_ini ?
+				       FCP_SPPF_INIT_FCN : 0) |
+				       (node->sport->enable_tgt ?
+				       FCP_SPPF_TARG_FCN : 0));
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+
+	return els;
+}
+
+struct efct_io *
+efct_send_prlo(struct efc_node *node, u32 timeout_sec, u32 retries,
+	       els_cb_t cb, void *cbarg)
+{
+	struct efct *efct = node->efc->base;
+	struct efct_io *els;
+	struct {
+		struct fc_els_prlo prlo;
+		struct fc_els_spp spp;
+	} *pp;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*pp), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "prlo";
+
+		/* Build PRLO request */
+		pp = els->els_req.virt;
+
+		memset(pp, 0, sizeof(*pp));
+		pp->prlo.prlo_cmd = ELS_PRLO;
+		pp->prlo.prlo_obs = 0x10;
+		pp->prlo.prlo_len = cpu_to_be16(sizeof(*pp));
+
+		pp->spp.spp_type = FC_TYPE_FCP;
+		pp->spp.spp_type_ext = 0;
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_logo(struct efc_node *node, u32 timeout_sec, u32 retries,
+	       els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct;
+	struct fc_els_logo *logo;
+	struct fc_els_flogi  *sparams;
+
+	efct = node->efc->base;
+
+	node_els_trace();
+
+	sparams = (struct fc_els_flogi *)node->sport->service_params;
+
+	els = efct_els_io_alloc(node, sizeof(*logo), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "logo";
+
+		/* Build LOGO request */
+
+		logo = els->els_req.virt;
+
+		memset(logo, 0, sizeof(*logo));
+		logo->fl_cmd = ELS_LOGO;
+		hton24(logo->fl_n_port_id, node->rnode.sport->fc_id);
+		logo->fl_n_port_wwn = sparams->fl_wwpn;
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_adisc(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct;
+	struct fc_els_adisc *adisc;
+	struct fc_els_flogi  *sparams;
+	struct efc_sli_port *sport = node->sport;
+
+	efct = node->efc->base;
+
+	node_els_trace();
+
+	sparams = (struct fc_els_flogi *)node->sport->service_params;
+
+	els = efct_els_io_alloc(node, sizeof(*adisc), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "adisc";
+
+		/* Build ADISC request */
+
+		adisc = els->els_req.virt;
+
+		memset(adisc, 0, sizeof(*adisc));
+		adisc->adisc_cmd = ELS_ADISC;
+		hton24(adisc->adisc_hard_addr, sport->fc_id);
+		adisc->adisc_wwpn = sparams->fl_wwpn;
+		adisc->adisc_wwnn = sparams->fl_wwnn;
+		hton24(adisc->adisc_port_id, node->rnode.sport->fc_id);
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_pdisc(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct = node->efc->base;
+	struct fc_els_flogi  *pdisc;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*pdisc), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "pdisc";
+
+		pdisc = els->els_req.virt;
+
+		memcpy(pdisc, node->sport->service_params, sizeof(*pdisc));
+
+		pdisc->fl_cmd = ELS_PDISC;
+		memset(pdisc->_fl_resvd, 0, sizeof(pdisc->_fl_resvd));
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_scr(struct efc_node *node, u32 timeout_sec, u32 retries,
+	      els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct = node->efc->base;
+	struct fc_els_scr *req;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*req), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "scr";
+
+		req = els->els_req.virt;
+
+		memset(req, 0, sizeof(*req));
+		req->scr_cmd = ELS_SCR;
+		req->scr_reg_func = ELS_SCRF_FULL;
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_rrq(struct efc_node *node, u32 timeout_sec, u32 retries,
+	      els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct = node->efc->base;
+	struct fc_els_scr *req;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*req), EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "scr";
+
+		req = els->els_req.virt;
+
+		memset(req, 0, sizeof(*req));
+		req->scr_cmd = ELS_RRQ;
+		req->scr_reg_func = ELS_SCRF_FULL;
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_send_rscn(struct efc_node *node, u32 timeout_sec, u32 retries,
+	       void *port_ids, u32 port_ids_count, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct = node->efc->base;
+	struct fc_els_rscn *req;
+	struct fc_els_rscn_page *rscn_page;
+	u32 length = sizeof(*rscn_page) * port_ids_count;
+
+	length += sizeof(*req);
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, length, EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->els_timeout_sec = timeout_sec;
+		els->els_retries_remaining = retries;
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "rscn";
+
+		req = els->els_req.virt;
+
+		req->rscn_cmd = ELS_RSCN;
+		req->rscn_page_len = sizeof(struct fc_els_rscn_page);
+		req->rscn_plen = cpu_to_be16(length);
+
+		els->hio_type = EFCT_HW_ELS_REQ;
+		els->iparam.els.timeout = timeout_sec;
+
+		/* copy in the payload */
+		rscn_page = els->els_req.virt + sizeof(*req);
+		memcpy(rscn_page, port_ids,
+		       port_ids_count * sizeof(*rscn_page));
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+void *
+efct_send_ls_rjt(struct efc *efc, struct efc_node *node,
+		 u32 ox_id, u32 reason_code,
+		u32 reason_code_expl, u32 vendor_unique)
+{
+	struct efct_io *io = NULL;
+	int rc;
+	struct efct *efct = node->efc->base;
+	struct fc_els_ls_rjt *rjt;
+
+	io = efct_els_io_alloc(node, sizeof(*rjt), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	node_els_trace();
+
+	io->els_callback = NULL;
+	io->els_callback_arg = NULL;
+	io->display_name = "ls_rjt";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els.ox_id = ox_id;
+
+	rjt = io->els_req.virt;
+	memset(rjt, 0, sizeof(*rjt));
+
+	rjt->er_cmd = ELS_LS_RJT;
+	rjt->er_reason = reason_code;
+	rjt->er_explan = reason_code_expl;
+
+	io->hio_type = EFCT_HW_ELS_RSP;
+	rc = efct_els_send_rsp(io, sizeof(*rjt));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+struct efct_io *
+efct_send_plogi_acc(struct efc_node *node, u32 ox_id,
+		    els_cb_t cb, void *cbarg)
+{
+	int rc;
+	struct efct *efct = node->efc->base;
+	struct efct_io *io = NULL;
+	struct fc_els_flogi  *plogi;
+	struct fc_els_flogi  *req = (struct fc_els_flogi *)node->service_params;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*plogi), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	io->els_callback = cb;
+	io->els_callback_arg = cbarg;
+	io->display_name = "plog_acc";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els.ox_id = ox_id;
+
+	plogi = io->els_req.virt;
+
+	/* copy our port's service parameters to payload */
+	memcpy(plogi, node->sport->service_params, sizeof(*plogi));
+	plogi->fl_cmd = ELS_LS_ACC;
+	memset(plogi->_fl_resvd, 0, sizeof(plogi->_fl_resvd));
+
+	/* Set Application header support bit if requested */
+	if (req->fl_csp.sp_features & cpu_to_be16(FC_SP_FT_BCAST))
+		plogi->fl_csp.sp_features |= cpu_to_be16(FC_SP_FT_BCAST);
+
+	io->hio_type = EFCT_HW_ELS_RSP;
+	rc = efct_els_send_rsp(io, sizeof(*plogi));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+	return io;
+}
+
+void *
+efct_send_flogi_p2p_acc(struct efc *efc, struct efc_node *node,
+			u32 ox_id, u32 s_id)
+{
+	struct efct_io *io = NULL;
+	int rc;
+	struct efct *efct = node->efc->base;
+	struct fc_els_flogi  *flogi;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*flogi), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	io->els_callback = NULL;
+	io->els_callback_arg = NULL;
+	io->display_name = "flogi_p2p_acc";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els_sid.ox_id = ox_id;
+	io->iparam.els_sid.s_id = s_id;
+
+	flogi = io->els_req.virt;
+
+	/* copy our port's service parameters to payload */
+	memcpy(flogi, node->sport->service_params, sizeof(*flogi));
+	flogi->fl_cmd = ELS_LS_ACC;
+	memset(flogi->_fl_resvd, 0, sizeof(flogi->_fl_resvd));
+
+	memset(flogi->fl_cssp, 0, sizeof(flogi->fl_cssp));
+
+	io->hio_type = EFCT_HW_ELS_RSP_SID;
+	rc = efct_els_send_rsp(io, sizeof(*flogi));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+struct efct_io *
+efct_send_flogi_acc(struct efc_node *node, u32 ox_id, u32 is_fport,
+		    els_cb_t cb, void *cbarg)
+{
+	int rc;
+	struct efct *efct = node->efc->base;
+	struct efct_io *io = NULL;
+	struct fc_els_flogi  *flogi;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*flogi), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+	io->els_callback = cb;
+	io->els_callback_arg = cbarg;
+	io->display_name = "flogi_acc";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els_sid.ox_id = ox_id;
+	io->iparam.els_sid.s_id = io->node->sport->fc_id;
+
+	flogi = io->els_req.virt;
+
+	/* copy our port's service parameters to payload */
+	memcpy(flogi, node->sport->service_params, sizeof(*flogi));
+
+	/* Set F_port */
+	if (is_fport) {
+		/* Set F_PORT and Multiple N_PORT_ID Assignment */
+		flogi->fl_csp.sp_r_a_tov |=  cpu_to_be32(3U << 28);
+	}
+
+	flogi->fl_cmd = ELS_LS_ACC;
+	memset(flogi->_fl_resvd, 0, sizeof(flogi->_fl_resvd));
+
+	memset(flogi->fl_cssp, 0, sizeof(flogi->fl_cssp));
+
+	io->hio_type = EFCT_HW_ELS_RSP_SID;
+	rc = efct_els_send_rsp(io, sizeof(*flogi));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+struct efct_io *efct_send_prli_acc(struct efc_node *node,
+				     u32 ox_id, els_cb_t cb, void *cbarg)
+{
+	int rc;
+	struct efct *efct = node->efc->base;
+	struct efct_io *io = NULL;
+	struct {
+		struct fc_els_prli prli;
+		struct fc_els_spp spp;
+	} *pp;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*pp), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	io->els_callback = cb;
+	io->els_callback_arg = cbarg;
+	io->display_name = "prli_acc";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els.ox_id = ox_id;
+
+	pp = io->els_req.virt;
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
+					(node->sport->enable_ini ?
+					 FCP_SPPF_INIT_FCN : 0) |
+					(node->sport->enable_tgt ?
+					 FCP_SPPF_TARG_FCN : 0));
+
+	io->hio_type = EFCT_HW_ELS_RSP;
+	rc = efct_els_send_rsp(io, sizeof(*pp));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+struct efct_io *
+efct_send_prlo_acc(struct efc_node *node, u32 ox_id,
+		   els_cb_t cb, void *cbarg)
+{
+	int rc;
+	struct efct *efct = node->efc->base;
+	struct efct_io *io = NULL;
+	struct {
+		struct fc_els_prlo prlo;
+		struct fc_els_spp spp;
+	} *pp;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*pp), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	io->els_callback = cb;
+	io->els_callback_arg = cbarg;
+	io->display_name = "prlo_acc";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els.ox_id = ox_id;
+
+	pp = io->els_req.virt;
+	memset(pp, 0, sizeof(*pp));
+	pp->prlo.prlo_cmd = ELS_LS_ACC;
+	pp->prlo.prlo_obs = 0x10;
+	pp->prlo.prlo_len = cpu_to_be16(sizeof(*pp));
+
+	pp->spp.spp_type = FC_TYPE_FCP;
+	pp->spp.spp_type_ext = 0;
+	pp->spp.spp_flags = FC_SPP_RESP_ACK;
+
+	io->hio_type = EFCT_HW_ELS_RSP;
+	rc = efct_els_send_rsp(io, sizeof(*pp));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+struct efct_io *
+efct_send_ls_acc(struct efc_node *node, u32 ox_id, els_cb_t cb,
+		 void *cbarg)
+{
+	int rc;
+	struct efct *efct = node->efc->base;
+	struct efct_io *io = NULL;
+	struct fc_els_ls_acc *acc;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*acc), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	io->els_callback = cb;
+	io->els_callback_arg = cbarg;
+	io->display_name = "ls_acc";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els.ox_id = ox_id;
+
+	acc = io->els_req.virt;
+	memset(acc, 0, sizeof(*acc));
+
+	acc->la_cmd = ELS_LS_ACC;
+
+	io->hio_type = EFCT_HW_ELS_RSP;
+	rc = efct_els_send_rsp(io, sizeof(*acc));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+struct efct_io *
+efct_send_logo_acc(struct efc_node *node, u32 ox_id,
+		   els_cb_t cb, void *cbarg)
+{
+	int rc;
+	struct efct_io *io = NULL;
+	struct efct *efct = node->efc->base;
+	struct fc_els_ls_acc *logo;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*logo), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	io->els_callback = cb;
+	io->els_callback_arg = cbarg;
+	io->display_name = "logo_acc";
+	io->init_task_tag = ox_id;
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els.ox_id = ox_id;
+
+	logo = io->els_req.virt;
+	memset(logo, 0, sizeof(*logo));
+
+	logo->la_cmd = ELS_LS_ACC;
+
+	io->hio_type = EFCT_HW_ELS_RSP;
+	rc = efct_els_send_rsp(io, sizeof(*logo));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+struct efct_io *
+efct_send_adisc_acc(struct efc_node *node, u32 ox_id,
+		    els_cb_t cb, void *cbarg)
+{
+	int rc;
+	struct efct_io *io = NULL;
+	struct fc_els_adisc *adisc;
+	struct fc_els_flogi  *sparams;
+	struct efct *efct;
+
+	efct = node->efc->base;
+
+	node_els_trace();
+
+	io = efct_els_io_alloc(node, sizeof(*adisc), EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efct, "els IO alloc failed\n");
+		return io;
+	}
+
+	io->els_callback = cb;
+	io->els_callback_arg = cbarg;
+	io->display_name = "adisc_acc";
+	io->init_task_tag = ox_id;
+
+	/* Go ahead and send the ELS_ACC */
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.els.ox_id = ox_id;
+
+	sparams = (struct fc_els_flogi  *)node->sport->service_params;
+	adisc = io->els_req.virt;
+	memset(adisc, 0, sizeof(*adisc));
+	adisc->adisc_cmd = ELS_LS_ACC;
+	adisc->adisc_wwpn = sparams->fl_wwpn;
+	adisc->adisc_wwnn = sparams->fl_wwnn;
+	hton24(adisc->adisc_port_id, node->rnode.sport->fc_id);
+
+	io->hio_type = EFCT_HW_ELS_RSP;
+	rc = efct_els_send_rsp(io, sizeof(*adisc));
+	if (rc) {
+		efct_els_io_free(io);
+		io = NULL;
+	}
+
+	return io;
+}
+
+void *
+efct_els_send_ct(struct efc *efc, struct efc_node *node, u32 cmd,
+		 u32 timeout_sec, u32 retries)
+{
+	struct efct *efct = efc->base;
+
+	switch (cmd) {
+	case FC_RCTL_ELS_REQ:
+		efc_log_err(efct, "send efct_ns_send_rftid\n");
+		efct_ns_send_rftid(node, timeout_sec, retries, NULL, NULL);
+		break;
+	case FC_NS_RFF_ID:
+		efc_log_err(efct, "send efct_ns_send_rffid\n");
+		efct_ns_send_rffid(node, timeout_sec, retries, NULL, NULL);
+		break;
+	case FC_NS_GID_PT:
+		efc_log_err(efct, "send efct_ns_send_gidpt\n");
+		efct_ns_send_gidpt(node, timeout_sec, retries, NULL, NULL);
+		break;
+	default:
+		efc_log_err(efct, "Unhandled command cmd: %x\n", cmd);
+	}
+
+	return NULL;
+}
+
+static inline void fcct_build_req_header(struct fc_ct_hdr  *hdr,
+					 u16 cmd, u16 max_size)
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
+struct efct_io *
+efct_ns_send_rftid(struct efc_node *node, u32 timeout_sec,
+		   u32 retries, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct = node->efc->base;
+	struct fc_ct_hdr *ct;
+	struct fc_ns_rft_id *rftid;
+
+	node_els_trace();
+
+	els = efct_els_io_alloc(node, sizeof(*ct) + sizeof(*rftid),
+				EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->iparam.fc_ct.r_ctl = FC_RCTL_ELS_REQ;
+		els->iparam.fc_ct.type = FC_TYPE_CT;
+		els->iparam.fc_ct.df_ctl = 0;
+		els->iparam.fc_ct.timeout = timeout_sec;
+
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "rftid";
+
+		ct = els->els_req.virt;
+		memset(ct, 0, sizeof(*ct));
+		fcct_build_req_header(ct, FC_NS_RFT_ID, sizeof(*rftid));
+
+		rftid = els->els_req.virt + sizeof(*ct);
+		memset(rftid, 0, sizeof(*rftid));
+		hton24(rftid->fr_fid.fp_fid, node->rnode.sport->fc_id);
+		rftid->fr_fts.ff_type_map[FC_TYPE_FCP / FC_NS_BPW] =
+			cpu_to_be32(1 << (FC_TYPE_FCP % FC_NS_BPW));
+
+		els->hio_type = EFCT_HW_FC_CT;
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_ns_send_rffid(struct efc_node *node, u32 timeout_sec,
+		   u32 retries, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els;
+	struct efct *efct = node->efc->base;
+	struct fc_ct_hdr *ct;
+	struct fc_ns_rff_id *rffid;
+	u32 size = 0;
+
+	node_els_trace();
+
+	size = sizeof(*ct) + sizeof(*rffid);
+
+	els = efct_els_io_alloc(node, size, EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+	} else {
+		els->iparam.fc_ct.r_ctl = FC_RCTL_ELS_REQ;
+		els->iparam.fc_ct.type = FC_TYPE_CT;
+		els->iparam.fc_ct.df_ctl = 0;
+		els->iparam.fc_ct.timeout = timeout_sec;
+
+		els->els_callback = cb;
+		els->els_callback_arg = cbarg;
+		els->display_name = "rffid";
+		ct = els->els_req.virt;
+
+		memset(ct, 0, sizeof(*ct));
+		fcct_build_req_header(ct, FC_NS_RFF_ID, sizeof(*rffid));
+
+		rffid = els->els_req.virt + sizeof(*ct);
+		memset(rffid, 0, sizeof(*rffid));
+
+		hton24(rffid->fr_fid.fp_fid, node->rnode.sport->fc_id);
+		if (node->sport->enable_ini)
+			rffid->fr_feat |= FCP_FEAT_INIT;
+		if (node->sport->enable_tgt)
+			rffid->fr_feat |= FCP_FEAT_TARG;
+		rffid->fr_type = FC_TYPE_FCP;
+
+		els->hio_type = EFCT_HW_FC_CT;
+
+		efct_els_send_req(node, els);
+	}
+	return els;
+}
+
+struct efct_io *
+efct_ns_send_gidpt(struct efc_node *node, u32 timeout_sec,
+		   u32 retries, els_cb_t cb, void *cbarg)
+{
+	struct efct_io *els = NULL;
+	struct efct *efct = node->efc->base;
+	struct fc_ct_hdr *ct;
+	struct fc_ns_gid_pt *gidpt;
+	u32 size = 0;
+
+	node_els_trace();
+
+	size = sizeof(*ct) + sizeof(*gidpt);
+	els = efct_els_io_alloc_size(node, size,
+				     EFCT_ELS_GID_PT_RSP_LEN,
+				   EFCT_ELS_ROLE_ORIGINATOR);
+	if (!els) {
+		efc_log_err(efct, "IO alloc failed\n");
+		return els;
+	}
+
+	els->iparam.fc_ct.r_ctl = FC_RCTL_ELS_REQ;
+	els->iparam.fc_ct.type = FC_TYPE_CT;
+	els->iparam.fc_ct.df_ctl = 0;
+	els->iparam.fc_ct.timeout = timeout_sec;
+
+	els->els_callback = cb;
+	els->els_callback_arg = cbarg;
+	els->display_name = "gidpt";
+
+	ct = els->els_req.virt;
+
+	memset(ct, 0, sizeof(*ct));
+	fcct_build_req_header(ct, FC_NS_GID_PT, sizeof(*gidpt));
+
+	gidpt = els->els_req.virt + sizeof(*ct);
+	memset(gidpt, 0, sizeof(*gidpt));
+	gidpt->fn_pt_type = FC_TYPE_FCP;
+
+	els->hio_type = EFCT_HW_FC_CT;
+
+	efct_els_send_req(node, els);
+
+	return els;
+}
+
+static int efct_bls_send_rjt_cb(struct efct_hw_io *hio,
+				struct efc_remote_node *rnode, u32 length,
+		int status, u32 ext_status, void *app)
+{
+	struct efct_io *io = app;
+
+	efct_scsi_io_free(io);
+	return 0;
+}
+
+static struct efct_io *
+efct_bls_send_rjt(struct efct_io *io, u32 s_id,
+		  u16 ox_id, u16 rx_id)
+{
+	struct efc_node *node = io->node;
+	int rc;
+	struct fc_ba_rjt *acc;
+	struct efct *efct;
+
+	efct = node->efc->base;
+
+	if (node->rnode.sport->fc_id == s_id)
+		s_id = U32_MAX;
+
+	/* fill out generic fields */
+	io->efct = efct;
+	io->node = node;
+	io->cmd_tgt = true;
+
+	/* fill out BLS Response-specific fields */
+	io->io_type = EFCT_IO_TYPE_BLS_RESP;
+	io->display_name = "ba_rjt";
+	io->hio_type = EFCT_HW_BLS_RJT;
+	io->init_task_tag = ox_id;
+
+	/* fill out iparam fields */
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.bls_sid.ox_id = ox_id;
+	io->iparam.bls_sid.rx_id = rx_id;
+
+	acc = (void *)io->iparam.bls_sid.payload;
+
+	memset(io->iparam.bls_sid.payload, 0,
+	       sizeof(io->iparam.bls_sid.payload));
+	acc->br_reason = ELS_RJT_UNAB;
+	acc->br_explan = ELS_EXPL_NONE;
+
+	rc = efct_scsi_io_dispatch(io, efct_bls_send_rjt_cb);
+	if (rc) {
+		efc_log_err(efct, "efct_scsi_io_dispatch() failed: %d\n", rc);
+		efct_scsi_io_free(io);
+		io = NULL;
+	}
+	return io;
+}
+
+struct efct_io *
+efct_bls_send_rjt_hdr(struct efct_io *io, struct fc_frame_header *hdr)
+{
+	u16 ox_id = be16_to_cpu(hdr->fh_ox_id);
+	u16 rx_id = be16_to_cpu(hdr->fh_rx_id);
+	u32 d_id = ntoh24(hdr->fh_d_id);
+
+	return efct_bls_send_rjt(io, d_id, ox_id, rx_id);
+}
+
+static int efct_bls_send_acc_cb(struct efct_hw_io *hio,
+				struct efc_remote_node *rnode, u32 length,
+		int status, u32 ext_status, void *app)
+{
+	struct efct_io *io = app;
+
+	efct_scsi_io_free(io);
+	return 0;
+}
+
+static struct efct_io *
+efct_bls_send_acc(struct efct_io *io, u32 s_id,
+		  u16 ox_id, u16 rx_id)
+{
+	struct efc_node *node = io->node;
+	int rc;
+	struct fc_ba_acc *acc;
+	struct efct *efct;
+
+	efct = node->efc->base;
+
+	if (node->rnode.sport->fc_id == s_id)
+		s_id = U32_MAX;
+
+	/* fill out generic fields */
+	io->efct = efct;
+	io->node = node;
+	io->cmd_tgt = true;
+
+	/* fill out BLS Response-specific fields */
+	io->io_type = EFCT_IO_TYPE_BLS_RESP;
+	io->display_name = "ba_acc";
+	io->hio_type = EFCT_HW_BLS_ACC_SID;
+	io->init_task_tag = ox_id;
+
+	/* fill out iparam fields */
+	memset(&io->iparam, 0, sizeof(io->iparam));
+	io->iparam.bls_sid.s_id = s_id;
+	io->iparam.bls_sid.ox_id = ox_id;
+	io->iparam.bls_sid.rx_id = rx_id;
+
+	acc = (void *)io->iparam.bls_sid.payload;
+
+	memset(io->iparam.bls_sid.payload, 0,
+	       sizeof(io->iparam.bls_sid.payload));
+	acc->ba_ox_id = cpu_to_be16(io->iparam.bls_sid.ox_id);
+	acc->ba_rx_id = cpu_to_be16(io->iparam.bls_sid.rx_id);
+	acc->ba_high_seq_cnt = cpu_to_be16(U16_MAX);
+
+	rc = efct_scsi_io_dispatch(io, efct_bls_send_acc_cb);
+	if (rc) {
+		efc_log_err(efct, "efct_scsi_io_dispatch() failed: %d\n", rc);
+		efct_scsi_io_free(io);
+		io = NULL;
+	}
+	return io;
+}
+
+void *
+efct_bls_send_acc_hdr(struct efc *efc, struct efc_node *node,
+		      struct fc_frame_header *hdr)
+{
+	struct efct_io *io = NULL;
+	u16 ox_id = be16_to_cpu(hdr->fh_ox_id);
+	u16 rx_id = be16_to_cpu(hdr->fh_rx_id);
+	u32 d_id = ntoh24(hdr->fh_d_id);
+
+	io = efct_scsi_io_alloc(node, EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efc, "els IO alloc failed\n");
+		return io;
+	}
+
+	return efct_bls_send_acc(io, d_id, ox_id, rx_id);
+}
+
+static int
+efct_els_abort_cb(struct efct_hw_io *hio, struct efc_remote_node *rnode,
+		  u32 length, int status, u32 ext_status,
+		 void *app)
+{
+	struct efct_io *els;
+	struct efct_io *abort_io = NULL; /* IO structure used to abort ELS */
+	struct efct *efct;
+
+	abort_io = app;
+	els = abort_io->io_to_abort;
+
+	if (!els || !els->node || !els->node->efc)
+		return -1;
+
+	efct = els->node->efc->base;
+
+	if (status != 0)
+		efc_log_warn(efct, "status x%x ext x%x\n", status, ext_status);
+
+	/* now free the abort IO */
+	efct_io_pool_io_free(efct->xport->io_pool, abort_io);
+
+	/* send completion event to indicate abort process is complete
+	 * Note: The ELS SM will already be receiving
+	 * ELS_REQ_OK/FAIL/RJT/ABORTED
+	 */
+	if (els->state == EFCT_ELS_REQ_ABORTED) {
+		/* completion for ELS that was aborted */
+		efct_els_abort_cleanup(els);
+	} else {
+		/* completion for abort was received first,
+		 * transition to wait for req cmpl
+		 */
+		els->state = EFCT_ELS_ABORT_IO_COMPL;
+	}
+
+	/* done with ELS IO to abort */
+	kref_put(&els->ref, els->release);
+	return 0;
+}
+
+static struct efct_io *
+efct_els_abort_io(struct efct_io *els, bool send_abts)
+{
+	struct efct *efct;
+	struct efct_xport *xport;
+	int rc;
+	struct efct_io *abort_io = NULL;
+
+	efct = els->node->efc->base;
+	xport = efct->xport;
+
+	/* take a reference on IO being aborted */
+	if ((kref_get_unless_zero(&els->ref) == 0)) {
+		/* command no longer active */
+		efc_log_debug(efct, "els no longer active\n");
+		return NULL;
+	}
+
+	/* allocate IO structure to send abort */
+	abort_io = efct_io_pool_io_alloc(efct->xport->io_pool);
+	if (!abort_io) {
+		atomic_add_return(1, &xport->io_alloc_failed_count);
+	} else {
+		/* set generic fields */
+		abort_io->efct = efct;
+		abort_io->node = els->node;
+		abort_io->cmd_ini = true;
+
+		/* set type and ABORT-specific fields */
+		abort_io->io_type = EFCT_IO_TYPE_ABORT;
+		abort_io->display_name = "abort_els";
+		abort_io->io_to_abort = els;
+		abort_io->send_abts = send_abts;
+
+		/* now dispatch IO */
+		rc = efct_scsi_io_dispatch_abort(abort_io, efct_els_abort_cb);
+		if (rc) {
+			efc_log_err(efct,
+				     "efct_scsi_io_dispatch failed: %d\n", rc);
+			efct_io_pool_io_free(efct->xport->io_pool, abort_io);
+			abort_io = NULL;
+		}
+	}
+
+	/* if something failed, put reference on ELS to abort */
+	if (!abort_io)
+		kref_put(&els->ref, els->release);
+	return abort_io;
+}
+
+void
+efct_els_abort(struct efct_io *els, struct efc_node_cb *arg)
+{
+	struct efct_io *io = NULL;
+	struct efc_node *node;
+	struct efct *efct;
+
+	node = els->node;
+	efct = node->efc->base;
+
+	/* request to abort this ELS without an ABTS */
+	els_io_printf(els, "ELS abort requested\n");
+	/* Set retries to zero,we are done */
+	els->els_retries_remaining = 0;
+	if (els->state == EFCT_ELS_REQUEST) {
+		els->state = EFCT_ELS_REQ_ABORT;
+		io = efct_els_abort_io(els, false);
+		if (!io) {
+			efc_log_err(efct, "efct_els_abort_io failed\n");
+			efct_els_io_cleanup(els, EFC_HW_SRRS_ELS_REQ_FAIL,
+					    arg);
+		}
+
+	} else if (els->state == EFCT_ELS_REQUEST_DELAYED) {
+		/* mod/resched the timer for a short duration */
+		mod_timer(&els->delay_timer,
+			  jiffies + msecs_to_jiffies(1));
+
+		els->state = EFCT_ELS_REQUEST_DELAY_ABORT;
+	}
+}
+
+void
+efct_els_io_cleanup(struct efct_io *els,
+		    enum efc_hw_node_els_event node_evt, void *arg)
+{
+	/* don't want further events that could come; e.g. abort requests
+	 * from the node state machine; thus, disable state machine
+	 */
+	els->els_req_free = true;
+	efc_node_post_els_resp(els->node, node_evt, arg);
+
+	/* If this IO has a callback, invoke it */
+	if (els->els_callback) {
+		(*els->els_callback)(els->node, arg,
+				    els->els_callback_arg);
+	}
+	efct_els_io_free(els);
+}
+
+int
+efct_els_io_list_empty(struct efc_node *node, struct list_head *list)
+{
+	int empty;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&node->active_ios_lock, flags);
+		empty = list_empty(list);
+	spin_unlock_irqrestore(&node->active_ios_lock, flags);
+	return empty;
+}
+
+static int
+efct_ct_acc_cb(struct efct_hw_io *hio, struct efc_remote_node *rnode,
+	       u32 length, int status, u32 ext_status,
+	      void *arg)
+{
+	struct efct_io *io = arg;
+
+	efct_els_io_free(io);
+
+	return 0;
+}
+
+int
+efct_send_ct_rsp(struct efc *efc, struct efc_node *node, u16 ox_id,
+		 struct fc_ct_hdr  *ct_hdr, u32 cmd_rsp_code,
+		u32 reason_code, u32 reason_code_explanation)
+{
+	struct efct_io *io = NULL;
+	struct fc_ct_hdr  *rsp = NULL;
+
+	io = efct_els_io_alloc(node, 256, EFCT_ELS_ROLE_RESPONDER);
+	if (!io) {
+		efc_log_err(efc, "IO alloc failed\n");
+		return -1;
+	}
+
+	rsp = io->els_rsp.virt;
+	io->io_type = EFCT_IO_TYPE_CT_RESP;
+
+	*rsp = *ct_hdr;
+
+	fcct_build_req_header(rsp, cmd_rsp_code, 0);
+	rsp->ct_reason = reason_code;
+	rsp->ct_explan = reason_code_explanation;
+
+	io->display_name = "ct response";
+	io->init_task_tag = ox_id;
+	io->wire_len += sizeof(*rsp);
+
+	memset(&io->iparam, 0, sizeof(io->iparam));
+
+	io->io_type = EFCT_IO_TYPE_CT_RESP;
+	io->hio_type = EFCT_HW_FC_CT_RSP;
+	io->iparam.fc_ct_rsp.ox_id = ox_id;
+	io->iparam.fc_ct_rsp.r_ctl = 3;
+	io->iparam.fc_ct_rsp.type = FC_TYPE_CT;
+	io->iparam.fc_ct_rsp.df_ctl = 0;
+	io->iparam.fc_ct_rsp.timeout = 5;
+
+	if (efct_scsi_io_dispatch(io, efct_ct_acc_cb) < 0) {
+		efct_els_io_free(io);
+		return -1;
+	}
+	return 0;
+}
diff --git a/drivers/scsi/elx/efct/efct_els.h b/drivers/scsi/elx/efct/efct_els.h
new file mode 100644
index 000000000000..b7d587050264
--- /dev/null
+++ b/drivers/scsi/elx/efct/efct_els.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#if !defined(__EFCT_ELS_H__)
+#define __EFCT_ELS_H__
+
+enum efct_els_role {
+	EFCT_ELS_ROLE_ORIGINATOR,
+	EFCT_ELS_ROLE_RESPONDER,
+};
+
+void _efct_els_io_free(struct kref *arg);
+extern struct efct_io *
+efct_els_io_alloc(struct efc_node *node, u32 reqlen,
+		  enum efct_els_role role);
+extern struct efct_io *
+efct_els_io_alloc_size(struct efc_node *node, u32 reqlen,
+		       u32 rsplen,
+				       enum efct_els_role role);
+void efct_els_io_free(struct efct_io *els);
+
+extern void *
+efct_els_req_send(struct efc *efc, struct efc_node *node,
+		  u32 cmd, u32 timeout_sec, u32 retries);
+extern void *
+efct_els_send_ct(struct efc *efc, struct efc_node *node,
+		 u32 cmd, u32 timeout_sec, u32 retries);
+extern void *
+efct_els_resp_send(struct efc *efc, struct efc_node *node,
+		   u32 cmd, u16 ox_id);
+void
+efct_els_abort(struct efct_io *els, struct efc_node_cb *arg);
+/* ELS command send */
+typedef void (*els_cb_t)(struct efc_node *node,
+			 struct efc_node_cb *cbdata, void *arg);
+extern struct efct_io *
+efct_send_plogi(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_flogi(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_fdisc(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_prli(struct efc_node *node, u32 timeout_sec,
+	       u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_prlo(struct efc_node *node, u32 timeout_sec,
+	       u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_logo(struct efc_node *node, u32 timeout_sec,
+	       u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_adisc(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_pdisc(struct efc_node *node, u32 timeout_sec,
+		u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_scr(struct efc_node *node, u32 timeout_sec,
+	      u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_rrq(struct efc_node *node, u32 timeout_sec,
+	      u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_ns_send_rftid(struct efc_node *node,
+		   u32 timeout_sec,
+		  u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_ns_send_rffid(struct efc_node *node,
+		   u32 timeout_sec,
+		  u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_ns_send_gidpt(struct efc_node *node, u32 timeout_sec,
+		   u32 retries, els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_rscn(struct efc_node *node, u32 timeout_sec,
+	       u32 retries, void *port_ids,
+	      u32 port_ids_count, els_cb_t cb, void *cbarg);
+extern void
+efct_els_io_cleanup(struct efct_io *els, enum efc_hw_node_els_event,
+		    void *arg);
+
+/* ELS acc send */
+extern struct efct_io *
+efct_send_ls_acc(struct efc_node *node, u32 ox_id,
+		 els_cb_t cb, void *cbarg);
+
+extern void *
+efct_send_ls_rjt(struct efc *efc, struct efc_node *node, u32 ox_id,
+		 u32 reason_cod, u32 reason_code_expl,
+		u32 vendor_unique);
+extern void *
+efct_send_flogi_p2p_acc(struct efc *efc, struct efc_node *node,
+			u32 ox_id, u32 s_id);
+extern struct efct_io *
+efct_send_flogi_acc(struct efc_node *node, u32 ox_id,
+		    u32 is_fport, els_cb_t cb,
+		   void *cbarg);
+extern struct efct_io *
+efct_send_plogi_acc(struct efc_node *node, u32 ox_id,
+		    els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_prli_acc(struct efc_node *node, u32 ox_id,
+		   els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_logo_acc(struct efc_node *node, u32 ox_id,
+		   els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_prlo_acc(struct efc_node *node, u32 ox_id,
+		   els_cb_t cb, void *cbarg);
+extern struct efct_io *
+efct_send_adisc_acc(struct efc_node *node, u32 ox_id,
+		    els_cb_t cb, void *cbarg);
+
+extern void *
+efct_bls_send_acc_hdr(struct efc *efc, struct efc_node *node,
+		      struct fc_frame_header *hdr);
+extern struct efct_io *
+efct_bls_send_rjt_hdr(struct efct_io *io, struct fc_frame_header *hdr);
+
+extern int
+efct_els_io_list_empty(struct efc_node *node, struct list_head *list);
+
+/* CT */
+extern int
+efct_send_ct_rsp(struct efc *efc, struct efc_node *node, u16 ox_id,
+		 struct fc_ct_hdr *ct_hdr,
+		 u32 cmd_rsp_code, u32 reason_code,
+		 u32 reason_code_explanation);
+
+#endif /* __EFCT_ELS_H__ */
-- 
2.13.7

