Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF32EC780
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 01:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAGAwF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jan 2021 19:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGAwE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jan 2021 19:52:04 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F1C0612FF
        for <linux-scsi@vger.kernel.org>; Wed,  6 Jan 2021 16:50:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v19so3475173pgj.12
        for <linux-scsi@vger.kernel.org>; Wed, 06 Jan 2021 16:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPqgSLQXVJ00p+ndTCcLfXN14kKLmaH/RXT1koE7AoE=;
        b=fD8y3lQx/dbQHzQlAiTjwmzvD8kIcHFdCFSZVEqrAOaLQp0vFZ53laTo/TnZtNo+bV
         ho+SlQS5bzAqJehbt4AksDlvXdgSmWQ6VwTDI20zCL6HOKXplQz4EMTrVC8DQwlEEIk7
         O8JHUbAj9U3XVylO/H8va35ppqbYTOELNsD4bp+HrHk1GXo/yW0ngu4pe4P+GD3KXWiq
         iourD206yl0awM9+w0LEidfwiD4uz9LRh/2gAowP9QcOcxpwf4tff7bDgf8QmWns6t6y
         xuL1ukKCZEDiF0u2nMZCi2Anrf8hQ9ltSPtrnOcuG+JOt/qBobe5Zg6pcfth3giUd4SK
         3ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPqgSLQXVJ00p+ndTCcLfXN14kKLmaH/RXT1koE7AoE=;
        b=W08nXwZ2bPHdkrXlp3eojONmHnN8gpNbGBidO0lGjtgVI0xWwGIoLeAGp3ZGNiJQze
         UU4UAs4mY6sYpmONiDXm8SDacmRuxQpOQzm3AikRekp/NSnyH1sGBYShfwPIR1on4uOU
         hiOwZMgGS1Njmc1tq4YXR05u5V8n3ObG9KpUcW6sXTvZJ3VvnnviUt1J2xfaqdoDyBFe
         cxzDNGB1GxBOF5ZL+rFkg36QnG4MNkYEnRQki5LesOPhg061gu5cMXM5XJH2zWKULmyZ
         9CCysOzkKO8yVwTsmGwmTurEz8jT7ktjyFlazHDPr0SrCrJrUphqcuSzn2mqOBwrXtcq
         jqrA==
X-Gm-Message-State: AOAM5313rbP7RxcY7PBhJdVYjV4rTBE+VVyzcjXXWhTsWHhlPBjP6JYK
        EO9Ee4XO9mIVzi7RGEpIhA3dS0Tx9b5Ouw==
X-Google-Smtp-Source: ABdhPJzyRk+g1jmVGCpx1gaLj6oAccYGV/OvTfW3fdgVeQDmjRlJcQ+KEkXy4QCZm1b36o1n5bRxeA==
X-Received: by 2002:a63:1707:: with SMTP id x7mr7116524pgl.266.1609980648514;
        Wed, 06 Jan 2021 16:50:48 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w27sm3600634pfq.104.2021.01.06.16.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 16:50:47 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 14/31] elx: libefc: FC node ELS and state handling
Date:   Wed,  6 Jan 2021 16:50:13 -0800
Message-Id: <20210107005030.2929-15-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210107005030.2929-1-jsmart2021@gmail.com>
References: <20210107005030.2929-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the libefc library population.

This patch adds library interface definitions for:
- FC node PRLI handling and state management

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>

---
v5:
 Topology naming changes.
---
 drivers/scsi/elx/libefc/efc_device.c | 1600 ++++++++++++++++++++++++++
 drivers/scsi/elx/libefc/efc_device.h |   72 ++
 2 files changed, 1672 insertions(+)
 create mode 100644 drivers/scsi/elx/libefc/efc_device.c
 create mode 100644 drivers/scsi/elx/libefc/efc_device.h

diff --git a/drivers/scsi/elx/libefc/efc_device.c b/drivers/scsi/elx/libefc/efc_device.c
new file mode 100644
index 000000000000..26de8ad79067
--- /dev/null
+++ b/drivers/scsi/elx/libefc/efc_device.c
@@ -0,0 +1,1600 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+/*
+ * device_sm Node State Machine: Remote Device States
+ */
+
+#include "efc.h"
+#include "efc_device.h"
+#include "efc_fabric.h"
+
+void
+efc_d_send_prli_rsp(struct efc_node *node, uint16_t ox_id)
+{
+	u32 rc = EFC_SCSI_CALL_COMPLETE;
+	struct efc *efc = node->efc;
+
+	node->ls_acc_oxid = ox_id;
+	node->send_ls_acc = EFC_NODE_SEND_LS_ACC_PRLI;
+
+	/*
+	 * Wait for backend session registration
+	 * to complete before sending PRLI resp
+	 */
+
+	if (node->init) {
+		efc_log_info(efc, "[%s] found(initiator) WWPN:%s WWNN:%s\n",
+			node->display_name, node->wwpn, node->wwnn);
+		if (node->nport->enable_tgt)
+			rc = efc->tt.scsi_new_node(efc, node);
+	}
+
+	if (rc == EFC_SCSI_CALL_COMPLETE)
+		efc_node_post_event(node, EFC_EVT_NODE_SESS_REG_OK, NULL);
+}
+
+static void
+__efc_d_common(const char *funcname, struct efc_sm_ctx *ctx,
+	       enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = NULL;
+	struct efc *efc = NULL;
+
+	node = ctx->app;
+	efc = node->efc;
+
+	switch (evt) {
+	/* Handle shutdown events */
+	case EFC_EVT_SHUTDOWN:
+		efc_log_debug(efc, "[%s] %-20s %-20s\n", node->display_name,
+			      funcname, efc_sm_event_name(evt));
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_DEFAULT;
+		efc_node_transition(node, __efc_d_initiate_shutdown, NULL);
+		break;
+	case EFC_EVT_SHUTDOWN_EXPLICIT_LOGO:
+		efc_log_debug(efc, "[%s] %-20s %-20s\n",
+			      node->display_name, funcname,
+				efc_sm_event_name(evt));
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_EXPLICIT_LOGO;
+		efc_node_transition(node, __efc_d_initiate_shutdown, NULL);
+		break;
+	case EFC_EVT_SHUTDOWN_IMPLICIT_LOGO:
+		efc_log_debug(efc, "[%s] %-20s %-20s\n", node->display_name,
+			      funcname, efc_sm_event_name(evt));
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_IMPLICIT_LOGO;
+		efc_node_transition(node, __efc_d_initiate_shutdown, NULL);
+		break;
+
+	default:
+		/* call default event handler common to all nodes */
+		__efc_node_common(funcname, ctx, evt, arg);
+	}
+}
+
+static void
+__efc_d_wait_del_node(struct efc_sm_ctx *ctx,
+		      enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	/*
+	 * State is entered when a node sends a delete initiator/target call
+	 * to the target-server/initiator-client and needs to wait for that
+	 * work to complete.
+	 */
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		fallthrough;
+
+	case EFC_EVT_NODE_ACTIVE_IO_LIST_EMPTY:
+	case EFC_EVT_ALL_CHILD_NODES_FREE:
+		/* These are expected events. */
+		break;
+
+	case EFC_EVT_NODE_DEL_INI_COMPLETE:
+	case EFC_EVT_NODE_DEL_TGT_COMPLETE:
+		/*
+		 * node has either been detached or is in the process
+		 * of being detached,
+		 * call common node's initiate cleanup function
+		 */
+		efc_node_initiate_cleanup(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_FAIL:
+		/* Can happen as ELS IO IO's complete */
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		break;
+
+	/* ignore shutdown events as we're already in shutdown path */
+	case EFC_EVT_SHUTDOWN:
+		/* have default shutdown event take precedence */
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_DEFAULT;
+		fallthrough;
+
+	case EFC_EVT_SHUTDOWN_EXPLICIT_LOGO:
+	case EFC_EVT_SHUTDOWN_IMPLICIT_LOGO:
+		node_printf(node, "%s received\n", efc_sm_event_name(evt));
+		break;
+	case EFC_EVT_DOMAIN_ATTACH_OK:
+		/* don't care about domain_attach_ok */
+		break;
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+static void
+__efc_d_wait_del_ini_tgt(struct efc_sm_ctx *ctx,
+			 enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		fallthrough;
+
+	case EFC_EVT_NODE_ACTIVE_IO_LIST_EMPTY:
+	case EFC_EVT_ALL_CHILD_NODES_FREE:
+		/* These are expected events. */
+		break;
+
+	case EFC_EVT_NODE_DEL_INI_COMPLETE:
+	case EFC_EVT_NODE_DEL_TGT_COMPLETE:
+		efc_node_transition(node, __efc_d_wait_del_node, NULL);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_FAIL:
+		/* Can happen as ELS IO IO's complete */
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		break;
+
+	/* ignore shutdown events as we're already in shutdown path */
+	case EFC_EVT_SHUTDOWN:
+		/* have default shutdown event take precedence */
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_DEFAULT;
+		fallthrough;
+
+	case EFC_EVT_SHUTDOWN_EXPLICIT_LOGO:
+	case EFC_EVT_SHUTDOWN_IMPLICIT_LOGO:
+		node_printf(node, "%s received\n", efc_sm_event_name(evt));
+		break;
+	case EFC_EVT_DOMAIN_ATTACH_OK:
+		/* don't care about domain_attach_ok */
+		break;
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_initiate_shutdown(struct efc_sm_ctx *ctx,
+			  enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+	struct efc *efc = node->efc;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER: {
+		int rc = EFC_SCSI_CALL_COMPLETE;
+
+		/* assume no wait needed */
+		WRITE_ONCE(node->els_io_enabled, false);
+
+		/* make necessary delete upcall(s) */
+		if (node->init && !node->targ) {
+			efc_log_info(node->efc,
+				     "[%s] delete (initiator) WWPN %s WWNN %s\n",
+				node->display_name,
+				node->wwpn, node->wwnn);
+			efc_node_transition(node,
+					    __efc_d_wait_del_node,
+					     NULL);
+			if (node->nport->enable_tgt)
+				rc = efc->tt.scsi_del_node(efc, node,
+					EFC_SCSI_INITIATOR_DELETED);
+
+			if (rc == EFC_SCSI_CALL_COMPLETE)
+				efc_node_post_event(node,
+					EFC_EVT_NODE_DEL_INI_COMPLETE, NULL);
+
+		} else if (node->targ && !node->init) {
+			efc_log_info(node->efc,
+				     "[%s] delete (target) WWPN %s WWNN %s\n",
+				node->display_name,
+				node->wwpn, node->wwnn);
+			efc_node_transition(node,
+					    __efc_d_wait_del_node,
+					     NULL);
+			if (node->nport->enable_ini)
+				rc = efc->tt.scsi_del_node(efc, node,
+					EFC_SCSI_TARGET_DELETED);
+
+			if (rc == EFC_SCSI_CALL_COMPLETE)
+				efc_node_post_event(node,
+					EFC_EVT_NODE_DEL_TGT_COMPLETE, NULL);
+
+		} else if (node->init && node->targ) {
+			efc_log_info(node->efc,
+				     "[%s] delete (I+T) WWPN %s WWNN %s\n",
+				node->display_name, node->wwpn, node->wwnn);
+			efc_node_transition(node, __efc_d_wait_del_ini_tgt,
+					    NULL);
+			if (node->nport->enable_tgt)
+				rc = efc->tt.scsi_del_node(efc, node,
+						EFC_SCSI_INITIATOR_DELETED);
+
+			if (rc == EFC_SCSI_CALL_COMPLETE)
+				efc_node_post_event(node,
+					EFC_EVT_NODE_DEL_INI_COMPLETE, NULL);
+			/* assume no wait needed */
+			rc = EFC_SCSI_CALL_COMPLETE;
+			if (node->nport->enable_ini)
+				rc = efc->tt.scsi_del_node(efc, node,
+						EFC_SCSI_TARGET_DELETED);
+
+			if (rc == EFC_SCSI_CALL_COMPLETE)
+				efc_node_post_event(node,
+					EFC_EVT_NODE_DEL_TGT_COMPLETE, NULL);
+		}
+
+		/* we've initiated the upcalls as needed, now kick off the node
+		 * detach to precipitate the aborting of outstanding exchanges
+		 * associated with said node
+		 *
+		 * Beware: if we've made upcall(s), we've already transitioned
+		 * to a new state by the time we execute this.
+		 * consider doing this before the upcalls?
+		 */
+		if (node->attached) {
+			/* issue hw node free; don't care if succeeds right
+			 * away or sometime later, will check node->attached
+			 * later in shutdown process
+			 */
+			rc = efc_cmd_node_detach(efc, &node->rnode);
+			if (rc != EFC_HW_RTN_SUCCESS &&
+			    rc != EFC_HW_RTN_SUCCESS_SYNC)
+				node_printf(node,
+					    "Failed freeing HW node, rc=%d\n",
+					rc);
+		}
+
+		/* if neither initiator nor target, proceed to cleanup */
+		if (!node->init && !node->targ) {
+			/*
+			 * node has either been detached or is in
+			 * the process of being detached,
+			 * call common node's initiate cleanup function
+			 */
+			efc_node_initiate_cleanup(node);
+		}
+		break;
+	}
+	case EFC_EVT_ALL_CHILD_NODES_FREE:
+		/* Ignore, this can happen if an ELS is
+		 * aborted while in a delay/retry state
+		 */
+		break;
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_loop(struct efc_sm_ctx *ctx,
+		  enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_DOMAIN_ATTACH_OK: {
+		/* send PLOGI automatically if initiator */
+		efc_node_init_device(node, true);
+		break;
+	}
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+efc_send_ls_acc_after_attach(struct efc_node *node,
+			     struct fc_frame_header *hdr,
+			     enum efc_node_send_ls_acc ls)
+{
+	u16 ox_id = be16_to_cpu(hdr->fh_ox_id);
+
+	/* Save the OX_ID for sending LS_ACC sometime later */
+	WARN_ON(node->send_ls_acc != EFC_NODE_SEND_LS_ACC_NONE);
+
+	node->ls_acc_oxid = ox_id;
+	node->send_ls_acc = ls;
+	node->ls_acc_did = ntoh24(hdr->fh_d_id);
+}
+
+void
+efc_process_prli_payload(struct efc_node *node, void *prli)
+{
+	struct {
+		struct fc_els_prli prli;
+		struct fc_els_spp sp;
+	} *pp;
+
+	pp = prli;
+	node->init = (pp->sp.spp_flags & FCP_SPPF_INIT_FCN) != 0;
+	node->targ = (pp->sp.spp_flags & FCP_SPPF_TARG_FCN) != 0;
+}
+
+void
+__efc_d_wait_plogi_acc_cmpl(struct efc_sm_ctx *ctx,
+			    enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_SRRS_ELS_CMPL_FAIL:
+		WARN_ON(!node->els_cmpl_cnt);
+		node->els_cmpl_cnt--;
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_DEFAULT;
+		efc_node_transition(node, __efc_d_initiate_shutdown, NULL);
+		break;
+
+	case EFC_EVT_SRRS_ELS_CMPL_OK:	/* PLOGI ACC completions */
+		WARN_ON(!node->els_cmpl_cnt);
+		node->els_cmpl_cnt--;
+		efc_node_transition(node, __efc_d_port_logged_in, NULL);
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_logo_rsp(struct efc_sm_ctx *ctx,
+		      enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_OK:
+	case EFC_EVT_SRRS_ELS_REQ_RJT:
+	case EFC_EVT_SRRS_ELS_REQ_FAIL:
+		/* LOGO response received, sent shutdown */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_LOGO,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		node_printf(node,
+			    "LOGO sent (evt=%s), shutdown node\n",
+			efc_sm_event_name(evt));
+		/* sm: / post explicit logout */
+		efc_node_post_event(node, EFC_EVT_SHUTDOWN_EXPLICIT_LOGO,
+				    NULL);
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+efc_node_init_device(struct efc_node *node, bool send_plogi)
+{
+	node->send_plogi = send_plogi;
+	if ((node->efc->nodedb_mask & EFC_NODEDB_PAUSE_NEW_NODES) &&
+	    (node->rnode.fc_id != FC_FID_DOM_MGR)) {
+		node->nodedb_state = __efc_d_init;
+		efc_node_transition(node, __efc_node_paused, NULL);
+	} else {
+		efc_node_transition(node, __efc_d_init, NULL);
+	}
+}
+
+static void
+efc_d_check_plogi_topology(struct efc_node *node, u32 d_id)
+{
+	switch (node->nport->topology) {
+	case EFC_NPORT_TOPO_P2P:
+		/* we're not attached and nport is p2p,
+		 * need to attach
+		 */
+		efc_domain_attach(node->nport->domain, d_id);
+		efc_node_transition(node, __efc_d_wait_domain_attach, NULL);
+		break;
+	case EFC_NPORT_TOPO_FABRIC:
+		/* we're not attached and nport is fabric, domain
+		 * attach should have already been requested as part
+		 * of the fabric state machine, wait for it
+		 */
+		efc_node_transition(node, __efc_d_wait_domain_attach, NULL);
+		break;
+	case EFC_NPORT_TOPO_UNKNOWN:
+		/* Two possibilities:
+		 * 1. received a PLOGI before our FLOGI has completed
+		 *    (possible since completion comes in on another
+		 *    CQ), thus we don't know what we're connected to
+		 *    yet; transition to a state to wait for the
+		 *    fabric node to tell us;
+		 * 2. PLOGI received before link went down and we
+		 * haven't performed domain attach yet.
+		 * Note: we cannot distinguish between 1. and 2.
+		 * so have to assume PLOGI
+		 * was received after link back up.
+		 */
+		node_printf(node, "received PLOGI, unknown topology did=0x%x\n",
+				  d_id);
+		efc_node_transition(node, __efc_d_wait_topology_notify, NULL);
+		break;
+	default:
+		node_printf(node, "received PLOGI, unexpected topology %d\n",
+				  node->nport->topology);
+	}
+}
+
+void
+__efc_d_init(struct efc_sm_ctx *ctx, enum efc_sm_event evt, void *arg)
+{
+	struct efc_node_cb *cbdata = arg;
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	/*
+	 * This state is entered when a node is instantiated,
+	 * either having been discovered from a name services query,
+	 * or having received a PLOGI/FLOGI.
+	 */
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		if (!node->send_plogi)
+			break;
+		/* only send if we have initiator capability,
+		 * and domain is attached
+		 */
+		if (node->nport->enable_ini &&
+		    node->nport->domain->attached) {
+			efc_send_plogi(node);
+
+			efc_node_transition(node, __efc_d_wait_plogi_rsp, NULL);
+		} else {
+			node_printf(node, "not sending plogi nport.ini=%d,",
+				    node->nport->enable_ini);
+			node_printf(node, "domain attached=%d\n",
+				    node->nport->domain->attached);
+		}
+		break;
+	case EFC_EVT_PLOGI_RCVD: {
+		/* T, or I+T */
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+		int rc;
+
+		efc_node_save_sparms(node, cbdata->payload->dma.virt);
+		efc_send_ls_acc_after_attach(node,
+					     cbdata->header->dma.virt,
+					     EFC_NODE_SEND_LS_ACC_PLOGI);
+
+		/* domain not attached; several possibilities: */
+		if (!node->nport->domain->attached) {
+			efc_d_check_plogi_topology(node, ntoh24(hdr->fh_d_id));
+			break;
+		}
+
+		/* domain already attached */
+		rc = efc_node_attach(node);
+		efc_node_transition(node, __efc_d_wait_node_attach, NULL);
+		if (rc == EFC_HW_RTN_SUCCESS_SYNC)
+			efc_node_post_event(node, EFC_EVT_NODE_ATTACH_OK, NULL);
+
+		break;
+	}
+
+	case EFC_EVT_FDISC_RCVD: {
+		__efc_d_common(__func__, ctx, evt, arg);
+		break;
+	}
+
+	case EFC_EVT_FLOGI_RCVD: {
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+		u32 d_id = ntoh24(hdr->fh_d_id);
+
+		/* sm: / save sparams, send FLOGI acc */
+		memcpy(node->nport->domain->flogi_service_params,
+		       cbdata->payload->dma.virt,
+		       sizeof(struct fc_els_flogi));
+
+		/* send FC LS_ACC response, override s_id */
+		efc_fabric_set_topology(node, EFC_NPORT_TOPO_P2P);
+
+		efc_send_flogi_p2p_acc(node, be16_to_cpu(hdr->fh_ox_id), d_id);
+
+		if (efc_p2p_setup(node->nport)) {
+			node_printf(node, "p2p failed, shutting down node\n");
+			efc_node_post_event(node, EFC_EVT_SHUTDOWN, NULL);
+			break;
+		}
+
+		efc_node_transition(node,  __efc_p2p_wait_flogi_acc_cmpl, NULL);
+		break;
+	}
+
+	case EFC_EVT_LOGO_RCVD: {
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+
+		if (!node->nport->domain->attached) {
+			/* most likely a frame left over from before a link
+			 * down; drop and
+			 * shut node down w/ "explicit logout" so pending
+			 * frames are processed
+			 */
+			node_printf(node, "%s domain not attached, dropping\n",
+				    efc_sm_event_name(evt));
+			efc_node_post_event(node,
+					EFC_EVT_SHUTDOWN_EXPLICIT_LOGO, NULL);
+			break;
+		}
+
+		efc_send_logo_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		efc_node_transition(node, __efc_d_wait_logo_acc_cmpl, NULL);
+		break;
+	}
+
+	case EFC_EVT_PRLI_RCVD:
+	case EFC_EVT_PRLO_RCVD:
+	case EFC_EVT_PDISC_RCVD:
+	case EFC_EVT_ADISC_RCVD:
+	case EFC_EVT_RSCN_RCVD: {
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+
+		if (!node->nport->domain->attached) {
+			/* most likely a frame left over from before a link
+			 * down; drop and shut node down w/ "explicit logout"
+			 * so pending frames are processed
+			 */
+			node_printf(node, "%s domain not attached, dropping\n",
+				    efc_sm_event_name(evt));
+
+			efc_node_post_event(node,
+					    EFC_EVT_SHUTDOWN_EXPLICIT_LOGO,
+					    NULL);
+			break;
+		}
+		node_printf(node, "%s received, sending reject\n",
+			    efc_sm_event_name(evt));
+
+		efc_send_ls_rjt(node, be16_to_cpu(hdr->fh_ox_id),
+				ELS_RJT_UNAB, ELS_EXPL_PLOGI_REQD, 0);
+
+		break;
+	}
+
+	case EFC_EVT_FCP_CMD_RCVD: {
+		/* note: problem, we're now expecting an ELS REQ completion
+		 * from both the LOGO and PLOGI
+		 */
+		if (!node->nport->domain->attached) {
+			/* most likely a frame left over from before a
+			 * link down; drop and
+			 * shut node down w/ "explicit logout" so pending
+			 * frames are processed
+			 */
+			node_printf(node, "%s domain not attached, dropping\n",
+				    efc_sm_event_name(evt));
+			efc_node_post_event(node,
+					    EFC_EVT_SHUTDOWN_EXPLICIT_LOGO,
+					    NULL);
+			break;
+		}
+
+		/* Send LOGO */
+		node_printf(node, "FCP_CMND received, send LOGO\n");
+		if (efc_send_logo(node)) {
+			/*
+			 * failed to send LOGO, go ahead and cleanup node
+			 * anyways
+			 */
+			node_printf(node, "Failed to send LOGO\n");
+			efc_node_post_event(node,
+					    EFC_EVT_SHUTDOWN_EXPLICIT_LOGO,
+					    NULL);
+		} else {
+			/* sent LOGO, wait for response */
+			efc_node_transition(node,
+					    __efc_d_wait_logo_rsp, NULL);
+		}
+		break;
+	}
+	case EFC_EVT_DOMAIN_ATTACH_OK:
+		/* don't care about domain_attach_ok */
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_plogi_rsp(struct efc_sm_ctx *ctx,
+		       enum efc_sm_event evt, void *arg)
+{
+	int rc;
+	struct efc_node_cb *cbdata = arg;
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_PLOGI_RCVD: {
+		/* T, or I+T */
+		/* received PLOGI with svc parms, go ahead and attach node
+		 * when PLOGI that was sent ultimately completes, it'll be a
+		 * no-op
+		 *
+		 * If there is an outstanding PLOGI sent, can we set a flag
+		 * to indicate that we don't want to retry it if it times out?
+		 */
+		efc_node_save_sparms(node, cbdata->payload->dma.virt);
+		efc_send_ls_acc_after_attach(node,
+					     cbdata->header->dma.virt,
+				EFC_NODE_SEND_LS_ACC_PLOGI);
+		/* sm: domain->attached / efc_node_attach */
+		rc = efc_node_attach(node);
+		efc_node_transition(node, __efc_d_wait_node_attach, NULL);
+		if (rc == EFC_HW_RTN_SUCCESS_SYNC)
+			efc_node_post_event(node,
+					    EFC_EVT_NODE_ATTACH_OK, NULL);
+
+		break;
+	}
+
+	case EFC_EVT_PRLI_RCVD:
+		/* I, or I+T */
+		/* sent PLOGI and before completion was seen, received the
+		 * PRLI from the remote node (WCQEs and RCQEs come in on
+		 * different queues and order of processing cannot be assumed)
+		 * Save OXID so PRLI can be sent after the attach and continue
+		 * to wait for PLOGI response
+		 */
+		efc_process_prli_payload(node, cbdata->payload->dma.virt);
+		efc_send_ls_acc_after_attach(node,
+					     cbdata->header->dma.virt,
+				EFC_NODE_SEND_LS_ACC_PRLI);
+		efc_node_transition(node, __efc_d_wait_plogi_rsp_recvd_prli,
+				    NULL);
+		break;
+
+	case EFC_EVT_LOGO_RCVD: /* why don't we do a shutdown here?? */
+	case EFC_EVT_PRLO_RCVD:
+	case EFC_EVT_PDISC_RCVD:
+	case EFC_EVT_FDISC_RCVD:
+	case EFC_EVT_ADISC_RCVD:
+	case EFC_EVT_RSCN_RCVD:
+	case EFC_EVT_SCR_RCVD: {
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+
+		node_printf(node, "%s received, sending reject\n",
+			    efc_sm_event_name(evt));
+
+		efc_send_ls_rjt(node, be16_to_cpu(hdr->fh_ox_id),
+				ELS_RJT_UNAB, ELS_EXPL_PLOGI_REQD, 0);
+
+		break;
+	}
+
+	case EFC_EVT_SRRS_ELS_REQ_OK:	/* PLOGI response received */
+		/* Completion from PLOGI sent */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PLOGI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		/* sm: / save sparams, efc_node_attach */
+		efc_node_save_sparms(node, cbdata->els_rsp.virt);
+		rc = efc_node_attach(node);
+		efc_node_transition(node, __efc_d_wait_node_attach, NULL);
+		if (rc == EFC_HW_RTN_SUCCESS_SYNC)
+			efc_node_post_event(node,
+					    EFC_EVT_NODE_ATTACH_OK, NULL);
+
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_FAIL:	/* PLOGI response received */
+		/* PLOGI failed, shutdown the node */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PLOGI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		efc_node_post_event(node, EFC_EVT_SHUTDOWN, NULL);
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_RJT:
+		/* Our PLOGI was rejected, this is ok in some cases */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PLOGI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		break;
+
+	case EFC_EVT_FCP_CMD_RCVD: {
+		/* not logged in yet and outstanding PLOGI so don't send LOGO,
+		 * just drop
+		 */
+		node_printf(node, "FCP_CMND received, drop\n");
+		break;
+	}
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_plogi_rsp_recvd_prli(struct efc_sm_ctx *ctx,
+				  enum efc_sm_event evt, void *arg)
+{
+	int rc;
+	struct efc_node_cb *cbdata = arg;
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		/*
+		 * Since we've received a PRLI, we have a port login and will
+		 * just need to wait for the PLOGI response to do the node
+		 * attach and then we can send the LS_ACC for the PRLI. If,
+		 * during this time, we receive FCP_CMNDs (which is possible
+		 * since we've already sent a PRLI and our peer may have
+		 * accepted). At this time, we are not waiting on any other
+		 * unsolicited frames to continue with the login process. Thus,
+		 * it will not hurt to hold frames here.
+		 */
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_OK:	/* PLOGI response received */
+		/* Completion from PLOGI sent */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PLOGI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		/* sm: / save sparams, efc_node_attach */
+		efc_node_save_sparms(node, cbdata->els_rsp.virt);
+		rc = efc_node_attach(node);
+		efc_node_transition(node, __efc_d_wait_node_attach, NULL);
+		if (rc == EFC_HW_RTN_SUCCESS_SYNC)
+			efc_node_post_event(node, EFC_EVT_NODE_ATTACH_OK,
+					    NULL);
+
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_FAIL:	/* PLOGI response received */
+	case EFC_EVT_SRRS_ELS_REQ_RJT:
+		/* PLOGI failed, shutdown the node */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PLOGI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		efc_node_post_event(node, EFC_EVT_SHUTDOWN, NULL);
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_domain_attach(struct efc_sm_ctx *ctx,
+			   enum efc_sm_event evt, void *arg)
+{
+	int rc;
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_DOMAIN_ATTACH_OK:
+		WARN_ON(!node->nport->domain->attached);
+		/* sm: / efc_node_attach */
+		rc = efc_node_attach(node);
+		efc_node_transition(node, __efc_d_wait_node_attach, NULL);
+		if (rc == EFC_HW_RTN_SUCCESS_SYNC)
+			efc_node_post_event(node, EFC_EVT_NODE_ATTACH_OK,
+					    NULL);
+
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_topology_notify(struct efc_sm_ctx *ctx,
+			     enum efc_sm_event evt, void *arg)
+{
+	int rc;
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_NPORT_TOPOLOGY_NOTIFY: {
+		enum efc_nport_topology topology =
+					(enum efc_nport_topology)arg;
+
+		WARN_ON(node->nport->domain->attached);
+
+		WARN_ON(node->send_ls_acc != EFC_NODE_SEND_LS_ACC_PLOGI);
+
+		node_printf(node, "topology notification, topology=%d\n",
+			    topology);
+
+		/* At the time the PLOGI was received, the topology was unknown,
+		 * so we didn't know which node would perform the domain attach:
+		 * 1. The node from which the PLOGI was sent (p2p) or
+		 * 2. The node to which the FLOGI was sent (fabric).
+		 */
+		if (topology == EFC_NPORT_TOPO_P2P) {
+			/* if this is p2p, need to attach to the domain using
+			 * the d_id from the PLOGI received
+			 */
+			efc_domain_attach(node->nport->domain,
+					  node->ls_acc_did);
+		}
+		/* else, if this is fabric, the domain attach
+		 * should be performed by the fabric node (node sending FLOGI);
+		 * just wait for attach to complete
+		 */
+
+		efc_node_transition(node, __efc_d_wait_domain_attach, NULL);
+		break;
+	}
+	case EFC_EVT_DOMAIN_ATTACH_OK:
+		WARN_ON(!node->nport->domain->attached);
+		node_printf(node, "domain attach ok\n");
+		/* sm: / efc_node_attach */
+		rc = efc_node_attach(node);
+		efc_node_transition(node, __efc_d_wait_node_attach, NULL);
+		if (rc == EFC_HW_RTN_SUCCESS_SYNC)
+			efc_node_post_event(node,
+					    EFC_EVT_NODE_ATTACH_OK, NULL);
+
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_node_attach(struct efc_sm_ctx *ctx,
+			 enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_NODE_ATTACH_OK:
+		node->attached = true;
+		switch (node->send_ls_acc) {
+		case EFC_NODE_SEND_LS_ACC_PLOGI: {
+			/* sm: send_plogi_acc is set / send PLOGI acc */
+			/* Normal case for T, or I+T */
+			efc_send_plogi_acc(node, node->ls_acc_oxid);
+			efc_node_transition(node, __efc_d_wait_plogi_acc_cmpl,
+					    NULL);
+			node->send_ls_acc = EFC_NODE_SEND_LS_ACC_NONE;
+			node->ls_acc_io = NULL;
+			break;
+		}
+		case EFC_NODE_SEND_LS_ACC_PRLI: {
+			efc_d_send_prli_rsp(node, node->ls_acc_oxid);
+			node->send_ls_acc = EFC_NODE_SEND_LS_ACC_NONE;
+			node->ls_acc_io = NULL;
+			break;
+		}
+		case EFC_NODE_SEND_LS_ACC_NONE:
+		default:
+			/* Normal case for I */
+			/* sm: send_plogi_acc is not set / send PLOGI acc */
+			efc_node_transition(node,
+					    __efc_d_port_logged_in, NULL);
+			break;
+		}
+		break;
+
+	case EFC_EVT_NODE_ATTACH_FAIL:
+		/* node attach failed, shutdown the node */
+		node->attached = false;
+		node_printf(node, "node attach failed\n");
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_DEFAULT;
+		efc_node_transition(node, __efc_d_initiate_shutdown, NULL);
+		break;
+
+	/* Handle shutdown events */
+	case EFC_EVT_SHUTDOWN:
+		node_printf(node, "%s received\n", efc_sm_event_name(evt));
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_DEFAULT;
+		efc_node_transition(node, __efc_d_wait_attach_evt_shutdown,
+				    NULL);
+		break;
+	case EFC_EVT_SHUTDOWN_EXPLICIT_LOGO:
+		node_printf(node, "%s received\n", efc_sm_event_name(evt));
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_EXPLICIT_LOGO;
+		efc_node_transition(node, __efc_d_wait_attach_evt_shutdown,
+				    NULL);
+		break;
+	case EFC_EVT_SHUTDOWN_IMPLICIT_LOGO:
+		node_printf(node, "%s received\n", efc_sm_event_name(evt));
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_IMPLICIT_LOGO;
+		efc_node_transition(node,
+				    __efc_d_wait_attach_evt_shutdown, NULL);
+		break;
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_attach_evt_shutdown(struct efc_sm_ctx *ctx,
+				 enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	/* wait for any of these attach events and then shutdown */
+	case EFC_EVT_NODE_ATTACH_OK:
+		node->attached = true;
+		node_printf(node, "Attach evt=%s, proceed to shutdown\n",
+			    efc_sm_event_name(evt));
+		efc_node_transition(node, __efc_d_initiate_shutdown, NULL);
+		break;
+
+	case EFC_EVT_NODE_ATTACH_FAIL:
+		/* node attach failed, shutdown the node */
+		node->attached = false;
+		node_printf(node, "Attach evt=%s, proceed to shutdown\n",
+			    efc_sm_event_name(evt));
+		efc_node_transition(node, __efc_d_initiate_shutdown, NULL);
+		break;
+
+	/* ignore shutdown events as we're already in shutdown path */
+	case EFC_EVT_SHUTDOWN:
+		/* have default shutdown event take precedence */
+		node->shutdown_reason = EFC_NODE_SHUTDOWN_DEFAULT;
+		fallthrough;
+
+	case EFC_EVT_SHUTDOWN_EXPLICIT_LOGO:
+	case EFC_EVT_SHUTDOWN_IMPLICIT_LOGO:
+		node_printf(node, "%s received\n", efc_sm_event_name(evt));
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_port_logged_in(struct efc_sm_ctx *ctx,
+		       enum efc_sm_event evt, void *arg)
+{
+	struct efc_node_cb *cbdata = arg;
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		/* Normal case for I or I+T */
+		if (node->nport->enable_ini &&
+		    !(node->rnode.fc_id != FC_FID_DOM_MGR)) {
+			/* sm: if enable_ini / send PRLI */
+			efc_send_prli(node);
+			/* can now expect ELS_REQ_OK/FAIL/RJT */
+		}
+		break;
+
+	case EFC_EVT_FCP_CMD_RCVD: {
+		break;
+	}
+
+	case EFC_EVT_PRLI_RCVD: {
+		/* Normal case for T or I+T */
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+		struct {
+			struct fc_els_prli prli;
+			struct fc_els_spp sp;
+		} *pp;
+
+		pp = cbdata->payload->dma.virt;
+		if (pp->sp.spp_type != FC_TYPE_FCP) {
+			/*Only FCP is supported*/
+			efc_send_ls_rjt(node, be16_to_cpu(hdr->fh_ox_id),
+					ELS_RJT_UNAB, ELS_EXPL_UNSUPR, 0);
+			break;
+		}
+
+		efc_process_prli_payload(node, cbdata->payload->dma.virt);
+		efc_d_send_prli_rsp(node, be16_to_cpu(hdr->fh_ox_id));
+		break;
+	}
+
+	case EFC_EVT_NODE_SESS_REG_OK:
+		if (node->send_ls_acc == EFC_NODE_SEND_LS_ACC_PRLI)
+			efc_send_prli_acc(node, node->ls_acc_oxid);
+
+		node->send_ls_acc = EFC_NODE_SEND_LS_ACC_NONE;
+		efc_node_transition(node, __efc_d_device_ready, NULL);
+		break;
+
+	case EFC_EVT_NODE_SESS_REG_FAIL:
+		efc_send_ls_rjt(node, node->ls_acc_oxid, ELS_RJT_UNAB,
+				ELS_EXPL_UNSUPR, 0);
+		node->send_ls_acc = EFC_NODE_SEND_LS_ACC_NONE;
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_OK: {	/* PRLI response */
+		/* Normal case for I or I+T */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PRLI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		/* sm: / process PRLI payload */
+		efc_process_prli_payload(node, cbdata->els_rsp.virt);
+		efc_node_transition(node, __efc_d_device_ready, NULL);
+		break;
+	}
+
+	case EFC_EVT_SRRS_ELS_REQ_FAIL: {	/* PRLI response failed */
+		/* I, I+T, assume some link failure, shutdown node */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PRLI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		efc_node_post_event(node, EFC_EVT_SHUTDOWN, NULL);
+		break;
+	}
+
+	case EFC_EVT_SRRS_ELS_REQ_RJT: {
+		/* PRLI rejected by remote
+		 * Normal for I, I+T (connected to an I)
+		 * Node doesn't want to be a target, stay here and wait for a
+		 * PRLI from the remote node
+		 * if it really wants to connect to us as target
+		 */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_PRLI,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		break;
+	}
+
+	case EFC_EVT_SRRS_ELS_CMPL_OK: {
+		/* Normal T, I+T, target-server rejected the process login */
+		/* This would be received only in the case where we sent
+		 * LS_RJT for the PRLI, so
+		 * do nothing.   (note: as T only we could shutdown the node)
+		 */
+		WARN_ON(!node->els_cmpl_cnt);
+		node->els_cmpl_cnt--;
+		break;
+	}
+
+	case EFC_EVT_PLOGI_RCVD: {
+		/*sm: / save sparams, set send_plogi_acc,
+		 *post implicit logout
+		 * Save plogi parameters
+		 */
+		efc_node_save_sparms(node, cbdata->payload->dma.virt);
+		efc_send_ls_acc_after_attach(node,
+					     cbdata->header->dma.virt,
+				EFC_NODE_SEND_LS_ACC_PLOGI);
+
+		/* Restart node attach with new service parameters,
+		 * and send ACC
+		 */
+		efc_node_post_event(node, EFC_EVT_SHUTDOWN_IMPLICIT_LOGO,
+				    NULL);
+		break;
+	}
+
+	case EFC_EVT_LOGO_RCVD: {
+		/* I, T, I+T */
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+
+		node_printf(node, "%s received attached=%d\n",
+			    efc_sm_event_name(evt),
+					node->attached);
+		/* sm: / send LOGO acc */
+		efc_send_logo_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		efc_node_transition(node, __efc_d_wait_logo_acc_cmpl, NULL);
+		break;
+	}
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_logo_acc_cmpl(struct efc_sm_ctx *ctx,
+			   enum efc_sm_event evt, void *arg)
+{
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		efc_node_hold_frames(node);
+		break;
+
+	case EFC_EVT_EXIT:
+		efc_node_accept_frames(node);
+		break;
+
+	case EFC_EVT_SRRS_ELS_CMPL_OK:
+	case EFC_EVT_SRRS_ELS_CMPL_FAIL:
+		/* sm: / post explicit logout */
+		WARN_ON(!node->els_cmpl_cnt);
+		node->els_cmpl_cnt--;
+		efc_node_post_event(node,
+				    EFC_EVT_SHUTDOWN_EXPLICIT_LOGO, NULL);
+		break;
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_device_ready(struct efc_sm_ctx *ctx,
+		     enum efc_sm_event evt, void *arg)
+{
+	struct efc_node_cb *cbdata = arg;
+	struct efc_node *node = ctx->app;
+	struct efc *efc = node->efc;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	if (evt != EFC_EVT_FCP_CMD_RCVD)
+		node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER:
+		node->fcp_enabled = true;
+		if (node->targ) {
+			efc_log_info(efc,
+				     "[%s] found (target) WWPN %s WWNN %s\n",
+				node->display_name,
+				node->wwpn, node->wwnn);
+			if (node->nport->enable_ini)
+				efc->tt.scsi_new_node(efc, node);
+		}
+		break;
+
+	case EFC_EVT_EXIT:
+		node->fcp_enabled = false;
+		break;
+
+	case EFC_EVT_PLOGI_RCVD: {
+		/* sm: / save sparams, set send_plogi_acc, post implicit
+		 * logout
+		 * Save plogi parameters
+		 */
+		efc_node_save_sparms(node, cbdata->payload->dma.virt);
+		efc_send_ls_acc_after_attach(node,
+					     cbdata->header->dma.virt,
+				EFC_NODE_SEND_LS_ACC_PLOGI);
+
+		/*
+		 * Restart node attach with new service parameters,
+		 * and send ACC
+		 */
+		efc_node_post_event(node,
+				    EFC_EVT_SHUTDOWN_IMPLICIT_LOGO, NULL);
+		break;
+	}
+
+	case EFC_EVT_PRLI_RCVD: {
+		/* T, I+T: remote initiator is slow to get started */
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+		struct {
+			struct fc_els_prli prli;
+			struct fc_els_spp sp;
+		} *pp;
+
+		pp = cbdata->payload->dma.virt;
+		if (pp->sp.spp_type != FC_TYPE_FCP) {
+			/*Only FCP is supported*/
+			efc_send_ls_rjt(node, be16_to_cpu(hdr->fh_ox_id),
+					ELS_RJT_UNAB, ELS_EXPL_UNSUPR, 0);
+			break;
+		}
+
+		efc_process_prli_payload(node, cbdata->payload->dma.virt);
+		efc_send_prli_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		break;
+	}
+
+	case EFC_EVT_PRLO_RCVD: {
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+		/* sm: / send PRLO acc */
+		efc_send_prlo_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		/* need implicit logout? */
+		break;
+	}
+
+	case EFC_EVT_LOGO_RCVD: {
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+
+		node_printf(node, "%s received attached=%d\n",
+			    efc_sm_event_name(evt), node->attached);
+		/* sm: / send LOGO acc */
+		efc_send_logo_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		efc_node_transition(node, __efc_d_wait_logo_acc_cmpl, NULL);
+		break;
+	}
+
+	case EFC_EVT_ADISC_RCVD: {
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+		/* sm: / send ADISC acc */
+		efc_send_adisc_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		break;
+	}
+
+	case EFC_EVT_ABTS_RCVD:
+		/* sm: / process ABTS */
+		efc_log_err(efc, "Unexpected event:%s\n",
+					efc_sm_event_name(evt));
+		break;
+
+	case EFC_EVT_NODE_ACTIVE_IO_LIST_EMPTY:
+		break;
+
+	case EFC_EVT_NODE_REFOUND:
+		break;
+
+	case EFC_EVT_NODE_MISSING:
+		if (node->nport->enable_rscn)
+			efc_node_transition(node, __efc_d_device_gone, NULL);
+
+		break;
+
+	case EFC_EVT_SRRS_ELS_CMPL_OK:
+		/* T, or I+T, PRLI accept completed ok */
+		WARN_ON(!node->els_cmpl_cnt);
+		node->els_cmpl_cnt--;
+		break;
+
+	case EFC_EVT_SRRS_ELS_CMPL_FAIL:
+		/* T, or I+T, PRLI accept failed to complete */
+		WARN_ON(!node->els_cmpl_cnt);
+		node->els_cmpl_cnt--;
+		node_printf(node, "Failed to send PRLI LS_ACC\n");
+		break;
+
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_device_gone(struct efc_sm_ctx *ctx,
+		    enum efc_sm_event evt, void *arg)
+{
+	struct efc_node_cb *cbdata = arg;
+	struct efc_node *node = ctx->app;
+	struct efc *efc = node->efc;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_ENTER: {
+		int rc = EFC_SCSI_CALL_COMPLETE;
+		int rc_2 = EFC_SCSI_CALL_COMPLETE;
+		static char const *labels[] = {"none", "initiator", "target",
+							"initiator+target"};
+
+		efc_log_info(efc, "[%s] missing (%s)    WWPN %s WWNN %s\n",
+			     node->display_name,
+				labels[(node->targ << 1) | (node->init)],
+						node->wwpn, node->wwnn);
+
+		switch (efc_node_get_enable(node)) {
+		case EFC_NODE_ENABLE_T_TO_T:
+		case EFC_NODE_ENABLE_I_TO_T:
+		case EFC_NODE_ENABLE_IT_TO_T:
+			rc = efc->tt.scsi_del_node(efc, node,
+				EFC_SCSI_TARGET_MISSING);
+			break;
+
+		case EFC_NODE_ENABLE_T_TO_I:
+		case EFC_NODE_ENABLE_I_TO_I:
+		case EFC_NODE_ENABLE_IT_TO_I:
+			rc = efc->tt.scsi_del_node(efc, node,
+				EFC_SCSI_INITIATOR_MISSING);
+			break;
+
+		case EFC_NODE_ENABLE_T_TO_IT:
+			rc = efc->tt.scsi_del_node(efc, node,
+				EFC_SCSI_INITIATOR_MISSING);
+			break;
+
+		case EFC_NODE_ENABLE_I_TO_IT:
+			rc = efc->tt.scsi_del_node(efc, node,
+						  EFC_SCSI_TARGET_MISSING);
+			break;
+
+		case EFC_NODE_ENABLE_IT_TO_IT:
+			rc = efc->tt.scsi_del_node(efc, node,
+				EFC_SCSI_INITIATOR_MISSING);
+			rc_2 = efc->tt.scsi_del_node(efc, node,
+				EFC_SCSI_TARGET_MISSING);
+			break;
+
+		default:
+			rc = EFC_SCSI_CALL_COMPLETE;
+			break;
+		}
+
+		if (rc == EFC_SCSI_CALL_COMPLETE &&
+		    rc_2 == EFC_SCSI_CALL_COMPLETE)
+			efc_node_post_event(node, EFC_EVT_SHUTDOWN, NULL);
+
+		break;
+	}
+	case EFC_EVT_NODE_REFOUND:
+		/* two approaches, reauthenticate with PLOGI/PRLI, or ADISC */
+
+		/* reauthenticate with PLOGI/PRLI */
+		/* efc_node_transition(node, __efc_d_discovered, NULL); */
+
+		/* reauthenticate with ADISC */
+		/* sm: / send ADISC */
+		efc_send_adisc(node);
+		efc_node_transition(node, __efc_d_wait_adisc_rsp, NULL);
+		break;
+
+	case EFC_EVT_PLOGI_RCVD: {
+		/* sm: / save sparams, set send_plogi_acc, post implicit
+		 * logout
+		 * Save plogi parameters
+		 */
+		efc_node_save_sparms(node, cbdata->payload->dma.virt);
+		efc_send_ls_acc_after_attach(node,
+					     cbdata->header->dma.virt,
+				EFC_NODE_SEND_LS_ACC_PLOGI);
+
+		/*
+		 * Restart node attach with new service parameters, and send
+		 * ACC
+		 */
+		efc_node_post_event(node, EFC_EVT_SHUTDOWN_IMPLICIT_LOGO,
+				    NULL);
+		break;
+	}
+
+	case EFC_EVT_FCP_CMD_RCVD: {
+		/* most likely a stale frame (received prior to link down),
+		 * if attempt to send LOGO, will probably timeout and eat
+		 * up 20s; thus, drop FCP_CMND
+		 */
+		node_printf(node, "FCP_CMND received, drop\n");
+		break;
+	}
+	case EFC_EVT_LOGO_RCVD: {
+		/* I, T, I+T */
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+
+		node_printf(node, "%s received attached=%d\n",
+			    efc_sm_event_name(evt), node->attached);
+		/* sm: / send LOGO acc */
+		efc_send_logo_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		efc_node_transition(node, __efc_d_wait_logo_acc_cmpl, NULL);
+		break;
+	}
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
+
+void
+__efc_d_wait_adisc_rsp(struct efc_sm_ctx *ctx,
+		       enum efc_sm_event evt, void *arg)
+{
+	struct efc_node_cb *cbdata = arg;
+	struct efc_node *node = ctx->app;
+
+	efc_node_evt_set(ctx, evt, __func__);
+
+	node_sm_trace();
+
+	switch (evt) {
+	case EFC_EVT_SRRS_ELS_REQ_OK:
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_ADISC,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		efc_node_transition(node, __efc_d_device_ready, NULL);
+		break;
+
+	case EFC_EVT_SRRS_ELS_REQ_RJT:
+		/* received an LS_RJT, in this case, send shutdown
+		 * (explicit logo) event which will unregister the node,
+		 * and start over with PLOGI
+		 */
+		if (efc_node_check_els_req(ctx, evt, arg, ELS_ADISC,
+					   __efc_d_common, __func__))
+			return;
+
+		WARN_ON(!node->els_req_cnt);
+		node->els_req_cnt--;
+		/* sm: / post explicit logout */
+		efc_node_post_event(node,
+				    EFC_EVT_SHUTDOWN_EXPLICIT_LOGO,
+				     NULL);
+		break;
+
+	case EFC_EVT_LOGO_RCVD: {
+		/* In this case, we have the equivalent of an LS_RJT for
+		 * the ADISC, so we need to abort the ADISC, and re-login
+		 * with PLOGI
+		 */
+		/* sm: / request abort, send LOGO acc */
+		struct fc_frame_header *hdr = cbdata->header->dma.virt;
+
+		node_printf(node, "%s received attached=%d\n",
+			    efc_sm_event_name(evt), node->attached);
+
+		efc_send_logo_acc(node, be16_to_cpu(hdr->fh_ox_id));
+		efc_node_transition(node, __efc_d_wait_logo_acc_cmpl, NULL);
+		break;
+	}
+	default:
+		__efc_d_common(__func__, ctx, evt, arg);
+	}
+}
diff --git a/drivers/scsi/elx/libefc/efc_device.h b/drivers/scsi/elx/libefc/efc_device.h
new file mode 100644
index 000000000000..3cf1d8c6698f
--- /dev/null
+++ b/drivers/scsi/elx/libefc/efc_device.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Node state machine functions for remote device node sm
+ */
+
+#ifndef __EFCT_DEVICE_H__
+#define __EFCT_DEVICE_H__
+void
+efc_node_init_device(struct efc_node *node, bool send_plogi);
+void
+efc_process_prli_payload(struct efc_node *node,
+			 void *prli);
+void
+efc_d_send_prli_rsp(struct efc_node *node, uint16_t ox_id);
+void
+efc_send_ls_acc_after_attach(struct efc_node *node,
+			     struct fc_frame_header *hdr,
+			     enum efc_node_send_ls_acc ls);
+void
+__efc_d_wait_loop(struct efc_sm_ctx *ctx,
+		  enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_plogi_acc_cmpl(struct efc_sm_ctx *ctx,
+			    enum efc_sm_event evt, void *arg);
+void
+__efc_d_init(struct efc_sm_ctx *ctx, enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_plogi_rsp(struct efc_sm_ctx *ctx,
+		       enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_plogi_rsp_recvd_prli(struct efc_sm_ctx *ctx,
+				  enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_domain_attach(struct efc_sm_ctx *ctx,
+			   enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_topology_notify(struct efc_sm_ctx *ctx,
+			     enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_node_attach(struct efc_sm_ctx *ctx,
+			 enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_attach_evt_shutdown(struct efc_sm_ctx *ctx,
+				 enum efc_sm_event evt, void *arg);
+void
+__efc_d_initiate_shutdown(struct efc_sm_ctx *ctx,
+			  enum efc_sm_event evt, void *arg);
+void
+__efc_d_port_logged_in(struct efc_sm_ctx *ctx,
+		       enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_logo_acc_cmpl(struct efc_sm_ctx *ctx,
+			   enum efc_sm_event evt, void *arg);
+void
+__efc_d_device_ready(struct efc_sm_ctx *ctx,
+		     enum efc_sm_event evt, void *arg);
+void
+__efc_d_device_gone(struct efc_sm_ctx *ctx,
+		    enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_adisc_rsp(struct efc_sm_ctx *ctx,
+		       enum efc_sm_event evt, void *arg);
+void
+__efc_d_wait_logo_rsp(struct efc_sm_ctx *ctx,
+		      enum efc_sm_event evt, void *arg);
+
+#endif /* __EFCT_DEVICE_H__ */
-- 
2.26.2

