Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5672EE985
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Jan 2021 00:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbhAGXBR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 18:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbhAGXBQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Jan 2021 18:01:16 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF73AC061242
        for <linux-scsi@vger.kernel.org>; Thu,  7 Jan 2021 14:59:41 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i7so6336459pgc.8
        for <linux-scsi@vger.kernel.org>; Thu, 07 Jan 2021 14:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKZy92iv0ztLdTL/Hh1LjM9NyQIVIX3Pl+oZy4l70Cg=;
        b=lKiRAr6HJSLq4rT12GCdFxL0PNzLigRzje/HXGwF92zIJFVxqv5JOHgRDKNu9g0qR+
         ADPsTN211+RUmC6/WBenUftzidU4qD2r+ywtN443fW0k+8bZ9zLOnH4lNLzTrHO4tp6G
         WWRXMF7vwnBhVTJsCiLUQUyKIRhZxKFf3GZiN4JUdA1cmUWcFCMMPzyon8isjNDoWqqY
         9nm7rgkKcIu6c+HVtSTkqMB+174RZUa0RRZuNSNxnPTc6wtGZs+0aj6TrVLgWXQVC1K8
         qlEBtMjryS4ua6/xO4yPE/d7186nR4W5Isy2ql/d9TKUWVoO4WsS9RdmaPHcWOZjSy7N
         6j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKZy92iv0ztLdTL/Hh1LjM9NyQIVIX3Pl+oZy4l70Cg=;
        b=WTi5Q2OvrGap7b4bc3a29YM2fNMD9bmfjuozPveKq1lt3+3uIJLyZcFOWKbqgzSbEu
         /GhBNqra48T9p7MkKovdIJaTjdq07hAdUSbn3QEh5TXza6zwyACOyL1wfE+VKMXHHWSG
         S9wVXREcvQKN4GI6XL4i4TtfC61jcy1Jx9q46tpfYRX5C5YjVfIi45wwjFLR+hbBNWut
         gwrEmgv8z832OwNdGfn7O38KnTHVTjLbLrQMCOsR5qvls1/O2hv0w68XpE/1wjYcST6g
         S1dof8c7doo59SgqzQV1oqQVVa7oWXDtFF+BEh84mDEtjKYkVI8RnNE8t3A8vHpDcmq1
         fo8w==
X-Gm-Message-State: AOAM531bcjLGymlBvf+uY5r3LVMRpGlk/p4v2GsrdFwvMUR5vEv1FlpG
        nLmfHQSvqryEiQK1yCdEswAXz1yaoTtfiA==
X-Google-Smtp-Source: ABdhPJyCoM7WEAMhV6eQerNqMXZjaEdb/NCv/BDAyEs+jZGfxdBVPZgR4+L6jj8RDOWNlIy7xXA3Lw==
X-Received: by 2002:a63:6686:: with SMTP id a128mr3990720pgc.96.1610060380920;
        Thu, 07 Jan 2021 14:59:40 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l197sm6881405pfd.97.2021.01.07.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 14:59:40 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 29/31] elx: efct: scsi_transport_fc host interface support
Date:   Thu,  7 Jan 2021 14:59:03 -0800
Message-Id: <20210107225905.18186-30-jsmart2021@gmail.com>
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
Integration with the scsi_fc_transport host interfaces

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/elx/efct/efct_xport.c | 500 +++++++++++++++++++++++++++++
 1 file changed, 500 insertions(+)

diff --git a/drivers/scsi/elx/efct/efct_xport.c b/drivers/scsi/elx/efct/efct_xport.c
index 0cf558c03547..bee13337afbc 100644
--- a/drivers/scsi/elx/efct/efct_xport.c
+++ b/drivers/scsi/elx/efct/efct_xport.c
@@ -778,3 +778,503 @@ int efct_scsi_del_device(struct efct *efct)
 	}
 	return EFC_SUCCESS;
 }
+
+static void
+efct_get_host_port_id(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport = (struct efct_vport *)shost->hostdata;
+	struct efct *efct = vport->efct;
+	struct efc *efc = efct->efcport;
+	struct efc_nport *nport;
+
+	if (efc->domain && efc->domain->nport) {
+		nport = efc->domain->nport;
+		fc_host_port_id(shost) = nport->fc_id;
+	}
+}
+
+static void
+efct_get_host_port_type(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport = (struct efct_vport *)shost->hostdata;
+	struct efct *efct = vport->efct;
+	struct efc *efc = efct->efcport;
+	int type = FC_PORTTYPE_UNKNOWN;
+
+	if (efc->domain && efc->domain->nport) {
+		if (efc->domain->is_loop) {
+			type = FC_PORTTYPE_LPORT;
+		} else {
+			struct efc_nport *nport = efc->domain->nport;
+
+			if (nport->is_vport)
+				type = FC_PORTTYPE_NPIV;
+			else if (nport->topology == EFC_NPORT_TOPO_P2P)
+				type = FC_PORTTYPE_PTP;
+			else if (nport->topology == EFC_NPORT_TOPO_UNKNOWN)
+				type = FC_PORTTYPE_UNKNOWN;
+			else
+				type = FC_PORTTYPE_NPORT;
+		}
+	}
+	fc_host_port_type(shost) = type;
+}
+
+static void
+efct_get_host_vport_type(struct Scsi_Host *shost)
+{
+	fc_host_port_type(shost) = FC_PORTTYPE_NPIV;
+}
+
+static void
+efct_get_host_port_state(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport = (struct efct_vport *)shost->hostdata;
+	struct efct *efct = vport->efct;
+	struct efc *efc = efct->efcport;
+
+	if (efc->domain)
+		fc_host_port_state(shost) = FC_PORTSTATE_ONLINE;
+	else
+		fc_host_port_state(shost) = FC_PORTSTATE_OFFLINE;
+}
+
+static void
+efct_get_host_speed(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport = (struct efct_vport *)shost->hostdata;
+	struct efct *efct = vport->efct;
+	struct efc *efc = efct->efcport;
+	union efct_xport_stats_u speed;
+	u32 fc_speed = FC_PORTSPEED_UNKNOWN;
+	int rc;
+
+	if (!efc->domain || !efc->domain->nport) {
+		fc_host_speed(shost) = fc_speed;
+		return;
+	}
+
+	rc = efct_xport_status(efct->xport, EFCT_XPORT_LINK_SPEED, &speed);
+	if (rc == 0) {
+		switch (speed.value) {
+		case 1000:
+			fc_speed = FC_PORTSPEED_1GBIT;
+			break;
+		case 2000:
+			fc_speed = FC_PORTSPEED_2GBIT;
+			break;
+		case 4000:
+			fc_speed = FC_PORTSPEED_4GBIT;
+			break;
+		case 8000:
+			fc_speed = FC_PORTSPEED_8GBIT;
+			break;
+		case 10000:
+			fc_speed = FC_PORTSPEED_10GBIT;
+			break;
+		case 16000:
+			fc_speed = FC_PORTSPEED_16GBIT;
+			break;
+		case 32000:
+			fc_speed = FC_PORTSPEED_32GBIT;
+			break;
+		}
+	}
+
+	fc_host_speed(shost) = fc_speed;
+}
+
+static void
+efct_get_host_fabric_name(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport = (struct efct_vport *)shost->hostdata;
+	struct efct *efct = vport->efct;
+	struct efc *efc = efct->efcport;
+
+	if (efc->domain) {
+		struct fc_els_flogi  *sp =
+			(struct fc_els_flogi  *)
+				efc->domain->flogi_service_params;
+
+		fc_host_fabric_name(shost) = be64_to_cpu(sp->fl_wwnn);
+	}
+}
+
+static struct fc_host_statistics *
+efct_get_stats(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport = (struct efct_vport *)shost->hostdata;
+	struct efct *efct = vport->efct;
+	union efct_xport_stats_u stats;
+	struct efct_xport *xport = efct->xport;
+	u32 rc = 1;
+
+	rc = efct_xport_status(xport, EFCT_XPORT_LINK_STATISTICS, &stats);
+	if (rc != 0) {
+		pr_err("efct_xport_status returned non 0 - %d\n", rc);
+		return NULL;
+	}
+
+	vport->fc_host_stats.loss_of_sync_count =
+		stats.stats.link_stats.loss_of_sync_error_count;
+	vport->fc_host_stats.link_failure_count =
+		stats.stats.link_stats.link_failure_error_count;
+	vport->fc_host_stats.prim_seq_protocol_err_count =
+		stats.stats.link_stats.primitive_sequence_error_count;
+	vport->fc_host_stats.invalid_tx_word_count =
+		stats.stats.link_stats.invalid_transmission_word_error_count;
+	vport->fc_host_stats.invalid_crc_count =
+		stats.stats.link_stats.crc_error_count;
+	/* mbox returns kbyte count so we need to convert to words */
+	vport->fc_host_stats.tx_words =
+		stats.stats.host_stats.transmit_kbyte_count * 256;
+	/* mbox returns kbyte count so we need to convert to words */
+	vport->fc_host_stats.rx_words =
+		stats.stats.host_stats.receive_kbyte_count * 256;
+	vport->fc_host_stats.tx_frames =
+		stats.stats.host_stats.transmit_frame_count;
+	vport->fc_host_stats.rx_frames =
+		stats.stats.host_stats.receive_frame_count;
+
+	vport->fc_host_stats.fcp_input_requests =
+			xport->fcp_stats.input_requests;
+	vport->fc_host_stats.fcp_output_requests =
+			xport->fcp_stats.output_requests;
+	vport->fc_host_stats.fcp_output_megabytes =
+			xport->fcp_stats.output_bytes >> 20;
+	vport->fc_host_stats.fcp_input_megabytes =
+			xport->fcp_stats.input_bytes >> 20;
+	vport->fc_host_stats.fcp_control_requests =
+			xport->fcp_stats.control_requests;
+
+	return &vport->fc_host_stats;
+}
+
+static void
+efct_reset_stats(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport = (struct efct_vport *)shost->hostdata;
+	struct efct *efct = vport->efct;
+	/* argument has no purpose for this action */
+	union efct_xport_stats_u dummy;
+	u32 rc = 0;
+
+	rc = efct_xport_status(efct->xport, EFCT_XPORT_LINK_STAT_RESET, &dummy);
+	if (rc != 0)
+		pr_err("efct_xport_status returned non 0 - %d\n", rc);
+}
+
+static void
+efct_get_starget_port_id(struct scsi_target *starget)
+{
+	pr_err("%s\n", __func__);
+}
+
+static void
+efct_get_starget_node_name(struct scsi_target *starget)
+{
+	pr_err("%s\n", __func__);
+}
+
+static void
+efct_get_starget_port_name(struct scsi_target *starget)
+{
+	pr_err("%s\n", __func__);
+}
+
+static void
+efct_set_vport_symbolic_name(struct fc_vport *fc_vport)
+{
+	pr_err("%s\n", __func__);
+}
+
+static int
+efct_issue_lip(struct Scsi_Host *shost)
+{
+	struct efct_vport *vport =
+			shost ? (struct efct_vport *)shost->hostdata : NULL;
+	struct efct *efct = vport ? vport->efct : NULL;
+
+	if (!shost || !vport || !efct) {
+		pr_err("%s: shost=%p vport=%p efct=%p\n", __func__,
+		       shost, vport, efct);
+		return -EPERM;
+	}
+
+	/*
+	 * Bring the link down gracefully then re-init the link.
+	 * The firmware will re-initialize the Fibre Channel interface as
+	 * required. It does not issue a LIP.
+	 */
+
+	if (efct_xport_control(efct->xport, EFCT_XPORT_PORT_OFFLINE))
+		efc_log_debug(efct, "EFCT_XPORT_PORT_OFFLINE failed\n");
+
+	if (efct_xport_control(efct->xport, EFCT_XPORT_PORT_ONLINE))
+		efc_log_debug(efct, "EFCT_XPORT_PORT_ONLINE failed\n");
+
+	return EFC_SUCCESS;
+}
+
+struct efct_vport *
+efct_scsi_new_vport(struct efct *efct, struct device *dev)
+{
+	struct Scsi_Host *shost = NULL;
+	int error = 0;
+	struct efct_vport *vport = NULL;
+	union efct_xport_stats_u speed;
+	u32 supported_speeds = 0;
+
+	shost = scsi_host_alloc(&efct_template, sizeof(*vport));
+	if (!shost) {
+		efc_log_err(efct, "failed to allocate Scsi_Host struct\n");
+		return NULL;
+	}
+
+	/* save efct information to shost LLD-specific space */
+	vport = (struct efct_vport *)shost->hostdata;
+	vport->efct = efct;
+	vport->is_vport = true;
+
+	shost->can_queue = efct->hw.config.n_io;
+	shost->max_cmd_len = 16; /* 16-byte CDBs */
+	shost->max_id = 0xffff;
+	shost->max_lun = 0xffffffff;
+
+	/* can only accept (from mid-layer) as many SGEs as we've pre-regited*/
+	shost->sg_tablesize = sli_get_max_sgl(&efct->hw.sli);
+
+	/* attach FC Transport template to shost */
+	shost->transportt = efct_vport_fc_tt;
+	efc_log_debug(efct, "vport transport template=%p\n",
+		       efct_vport_fc_tt);
+
+	/* get pci_dev structure and add host to SCSI ML */
+	error = scsi_add_host_with_dma(shost, dev, &efct->pci->dev);
+	if (error) {
+		efc_log_debug(efct, "failed scsi_add_host_with_dma\n");
+		return NULL;
+	}
+
+	/* Set symbolic name for host port */
+	snprintf(fc_host_symbolic_name(shost),
+		 sizeof(fc_host_symbolic_name(shost)),
+		 "Emulex %s FV%s DV%s", efct->model, efct->hw.sli.fw_name[0],
+		 EFCT_DRIVER_VERSION);
+
+	/* Set host port supported classes */
+	fc_host_supported_classes(shost) = FC_COS_CLASS3;
+
+	speed.value = 1000;
+	if (efct_xport_status(efct->xport, EFCT_XPORT_IS_SUPPORTED_LINK_SPEED,
+			      &speed)) {
+		supported_speeds |= FC_PORTSPEED_1GBIT;
+	}
+	speed.value = 2000;
+	if (efct_xport_status(efct->xport, EFCT_XPORT_IS_SUPPORTED_LINK_SPEED,
+			      &speed)) {
+		supported_speeds |= FC_PORTSPEED_2GBIT;
+	}
+	speed.value = 4000;
+	if (efct_xport_status(efct->xport, EFCT_XPORT_IS_SUPPORTED_LINK_SPEED,
+			      &speed)) {
+		supported_speeds |= FC_PORTSPEED_4GBIT;
+	}
+	speed.value = 8000;
+	if (efct_xport_status(efct->xport, EFCT_XPORT_IS_SUPPORTED_LINK_SPEED,
+			      &speed)) {
+		supported_speeds |= FC_PORTSPEED_8GBIT;
+	}
+	speed.value = 10000;
+	if (efct_xport_status(efct->xport, EFCT_XPORT_IS_SUPPORTED_LINK_SPEED,
+			      &speed)) {
+		supported_speeds |= FC_PORTSPEED_10GBIT;
+	}
+	speed.value = 16000;
+	if (efct_xport_status(efct->xport, EFCT_XPORT_IS_SUPPORTED_LINK_SPEED,
+			      &speed)) {
+		supported_speeds |= FC_PORTSPEED_16GBIT;
+	}
+	speed.value = 32000;
+	if (efct_xport_status(efct->xport, EFCT_XPORT_IS_SUPPORTED_LINK_SPEED,
+			      &speed)) {
+		supported_speeds |= FC_PORTSPEED_32GBIT;
+	}
+
+	fc_host_supported_speeds(shost) = supported_speeds;
+	vport->shost = shost;
+
+	return vport;
+}
+
+int efct_scsi_del_vport(struct efct *efct, struct Scsi_Host *shost)
+{
+	if (shost) {
+		efc_log_debug(efct,
+				"Unregistering vport with Transport Layer\n");
+		efct_xport_remove_host(shost);
+		efc_log_debug(efct, "Unregistering vport with SCSI Midlayer\n");
+		scsi_remove_host(shost);
+		scsi_host_put(shost);
+		return EFC_SUCCESS;
+	}
+	return EFC_FAIL;
+}
+
+static int
+efct_vport_create(struct fc_vport *fc_vport, bool disable)
+{
+	struct Scsi_Host *shost = fc_vport ? fc_vport->shost : NULL;
+	struct efct_vport *pport = shost ?
+					(struct efct_vport *)shost->hostdata :
+					NULL;
+	struct efct *efct = pport ? pport->efct : NULL;
+	struct efct_vport *vport = NULL;
+
+	if (!fc_vport || !shost || !efct)
+		goto fail;
+
+	vport = efct_scsi_new_vport(efct, &fc_vport->dev);
+	if (!vport) {
+		efc_log_err(efct, "failed to create vport\n");
+		goto fail;
+	}
+
+	vport->fc_vport = fc_vport;
+	vport->npiv_wwpn = fc_vport->port_name;
+	vport->npiv_wwnn = fc_vport->node_name;
+	fc_host_node_name(vport->shost) = vport->npiv_wwnn;
+	fc_host_port_name(vport->shost) = vport->npiv_wwpn;
+	*(struct efct_vport **)fc_vport->dd_data = vport;
+
+	return EFC_SUCCESS;
+
+fail:
+	return EFC_FAIL;
+}
+
+static int
+efct_vport_delete(struct fc_vport *fc_vport)
+{
+	struct efct_vport *vport = *(struct efct_vport **)fc_vport->dd_data;
+	struct Scsi_Host *shost = vport ? vport->shost : NULL;
+	struct efct *efct = vport ? vport->efct : NULL;
+	int rc = -1;
+
+	rc = efct_scsi_del_vport(efct, shost);
+
+	if (rc)
+		pr_err("%s: vport delete failed\n", __func__);
+
+	return rc;
+}
+
+static int
+efct_vport_disable(struct fc_vport *fc_vport, bool disable)
+{
+	return EFC_SUCCESS;
+}
+
+static struct fc_function_template efct_xport_functions = {
+	.get_starget_node_name = efct_get_starget_node_name,
+	.get_starget_port_name = efct_get_starget_port_name,
+	.get_starget_port_id  = efct_get_starget_port_id,
+
+	.get_host_port_id = efct_get_host_port_id,
+	.get_host_port_type = efct_get_host_port_type,
+	.get_host_port_state = efct_get_host_port_state,
+	.get_host_speed = efct_get_host_speed,
+	.get_host_fabric_name = efct_get_host_fabric_name,
+
+	.get_fc_host_stats = efct_get_stats,
+	.reset_fc_host_stats = efct_reset_stats,
+
+	.issue_fc_host_lip = efct_issue_lip,
+
+	.set_vport_symbolic_name = efct_set_vport_symbolic_name,
+	.vport_disable = efct_vport_disable,
+
+	/* allocation lengths for host-specific data */
+	.dd_fcrport_size = sizeof(struct efct_rport_data),
+	.dd_fcvport_size = 128, /* should be sizeof(...) */
+
+	/* remote port fixed attributes */
+	.show_rport_maxframe_size = 1,
+	.show_rport_supported_classes = 1,
+	.show_rport_dev_loss_tmo = 1,
+
+	/* target dynamic attributes */
+	.show_starget_node_name = 1,
+	.show_starget_port_name = 1,
+	.show_starget_port_id = 1,
+
+	/* host fixed attributes */
+	.show_host_node_name = 1,
+	.show_host_port_name = 1,
+	.show_host_supported_classes = 1,
+	.show_host_supported_fc4s = 1,
+	.show_host_supported_speeds = 1,
+	.show_host_maxframe_size = 1,
+
+	/* host dynamic attributes */
+	.show_host_port_id = 1,
+	.show_host_port_type = 1,
+	.show_host_port_state = 1,
+	/* active_fc4s is shown but doesn't change (thus no get function) */
+	.show_host_active_fc4s = 1,
+	.show_host_speed = 1,
+	.show_host_fabric_name = 1,
+	.show_host_symbolic_name = 1,
+	.vport_create = efct_vport_create,
+	.vport_delete = efct_vport_delete,
+};
+
+static struct fc_function_template efct_vport_functions = {
+	.get_starget_node_name = efct_get_starget_node_name,
+	.get_starget_port_name = efct_get_starget_port_name,
+	.get_starget_port_id  = efct_get_starget_port_id,
+
+	.get_host_port_id = efct_get_host_port_id,
+	.get_host_port_type = efct_get_host_vport_type,
+	.get_host_port_state = efct_get_host_port_state,
+	.get_host_speed = efct_get_host_speed,
+	.get_host_fabric_name = efct_get_host_fabric_name,
+
+	.get_fc_host_stats = efct_get_stats,
+	.reset_fc_host_stats = efct_reset_stats,
+
+	.issue_fc_host_lip = efct_issue_lip,
+	.set_vport_symbolic_name = efct_set_vport_symbolic_name,
+
+	/* allocation lengths for host-specific data */
+	.dd_fcrport_size = sizeof(struct efct_rport_data),
+	.dd_fcvport_size = 128, /* should be sizeof(...) */
+
+	/* remote port fixed attributes */
+	.show_rport_maxframe_size = 1,
+	.show_rport_supported_classes = 1,
+	.show_rport_dev_loss_tmo = 1,
+
+	/* target dynamic attributes */
+	.show_starget_node_name = 1,
+	.show_starget_port_name = 1,
+	.show_starget_port_id = 1,
+
+	/* host fixed attributes */
+	.show_host_node_name = 1,
+	.show_host_port_name = 1,
+	.show_host_supported_classes = 1,
+	.show_host_supported_fc4s = 1,
+	.show_host_supported_speeds = 1,
+	.show_host_maxframe_size = 1,
+
+	/* host dynamic attributes */
+	.show_host_port_id = 1,
+	.show_host_port_type = 1,
+	.show_host_port_state = 1,
+	/* active_fc4s is shown but doesn't change (thus no get function) */
+	.show_host_active_fc4s = 1,
+	.show_host_speed = 1,
+	.show_host_fabric_name = 1,
+	.show_host_symbolic_name = 1,
+};
-- 
2.26.2

