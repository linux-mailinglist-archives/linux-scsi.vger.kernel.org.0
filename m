Return-Path: <linux-scsi+bounces-7261-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9FE94D4EB
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2024 18:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83447B222D0
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6AE210EE;
	Fri,  9 Aug 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="TliwG3jV"
X-Original-To: linux-scsi@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4B20DC5;
	Fri,  9 Aug 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221930; cv=none; b=lyUWkYZnFfImJeKFPcu1u2sogyLakWnXWDjU9gyofr57mNQh+6LxG/JxZH5kwblbjo+KENs9iDzkp3zeW4j7StfhfLmJQ/HidEkTDDOXNtqA+DbEW5Zqyx26pl7jhrzNZsBJXTAa5KdffMtwLAw9tWtI0x+37fqUp8K09YwdQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221930; c=relaxed/simple;
	bh=S23KrKvfomk7LO6MpuYG1WQbsIWMq7NuV7DPPPqB+IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFy4AVtMalqxhxGQgVBbghQElLzowp6FttV5PD+4epZ783uTu+pEThC/Re6Y4n/s3gkRh5ZQCMIm917vxXOwz3dYdDB9CdUrKvlLsa1SyZYYKB2dCbY+PWDlirvIf9hutvlvP4fEIVU0j3AaR9FrH38+gq+7ORYDQmZWbDpEbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=TliwG3jV; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=75879; q=dns/txt;
  s=iport; t=1723221926; x=1724431526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9mYrw1MIvZfzfaSasfYYgcEsYS0/rW/ghcKTyZt3mU=;
  b=TliwG3jVd3xOjVkfbqinql/1piH8DsGVoDcIMP3V9BTLZreSTX6b5ppa
   rosjzqD1Q+ECq2nGRKPBMkf97whKgjZSGN85Ih4NTUJl5e2LdV8fJnAgk
   /w1p72maKP1vzuVfhcMWoVPesYqQZ0WdMTtN3POjNpryulEccLCbvPsC6
   4=;
X-CSE-ConnectionGUID: WV2txL/8TfKYk0+gQHXBSw==
X-CSE-MsgGUID: 2nJ2U2/eRAuV8TaQwRnvxg==
X-IronPort-AV: E=Sophos;i="6.09,276,1716249600"; 
   d="scan'208";a="337401397"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 16:44:17 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPSA id 479Ggo2Y031305
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 9 Aug 2024 16:44:16 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, aeasi@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karan Tilak Kumar <kartilak@cisco.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 03/14] scsi: fnic: Add support for fabric based solicited requests and responses
Date: Fri,  9 Aug 2024 09:42:29 -0700
Message-Id: <20240809164240.47561-4-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240809164240.47561-1-kartilak@cisco.com>
References: <20240809164240.47561-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-5.cisco.com

Add fdls_disc.c to support fabric based solicited requests
and responses.
Clean up obsolete code but keep the function template so
as to not break compilation.
Remove duplicate definitions from header files.
Modify definitions of data members.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202406120201.VakI9Dly-lkp@
intel.com/

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v1 and v2:
    Incorporate review comments from Hannes:
	Remove double newline.
	Fix indentation in fnic_send_frame.
	Use the correct kernel-doc format.
	Replace htonll() with get_unaligned_be64().
	Add fnic_del_fabric_timer_sync as an inline function.
	Add fnic_del_tport_timer_sync as an inline function.
	Modify fc_abts_s variable name to fc_fabric_abts_s.
	Modify fc_fabric_abts_s to be a global frame.
	Rename pfc_abts to fabric_abts.
	Replace definitions with standard definitions from
	fc_els.h.
    Incorporate review comments from John:
	Replace kmalloc with kzalloc.
	Modify fnic_send_fcoe_frame to not send a return value.
    Replace simultaneous use of pointer and structure with just
    pointer.
    Fix issue found by kernel test robot.
---
 drivers/scsi/fnic/Makefile    |    1 +
 drivers/scsi/fnic/fdls_disc.c | 1576 +++++++++++++++++++++++++++++++++
 drivers/scsi/fnic/fnic.h      |   26 +-
 drivers/scsi/fnic/fnic_fcs.c  |  400 +++++----
 drivers/scsi/fnic/fnic_fdls.h |    7 +-
 drivers/scsi/fnic/fnic_io.h   |   11 -
 drivers/scsi/fnic/fnic_main.c |   10 +-
 drivers/scsi/fnic/fnic_scsi.c |    6 +-
 8 files changed, 1844 insertions(+), 193 deletions(-)
 create mode 100644 drivers/scsi/fnic/fdls_disc.c

diff --git a/drivers/scsi/fnic/Makefile b/drivers/scsi/fnic/Makefile
index 6214a6b2e96d..3bd6b1c8b643 100644
--- a/drivers/scsi/fnic/Makefile
+++ b/drivers/scsi/fnic/Makefile
@@ -7,6 +7,7 @@ fnic-y	:= \
 	fnic_main.o \
 	fnic_res.o \
 	fnic_fcs.o \
+	fdls_disc.o \
 	fnic_scsi.o \
 	fnic_trace.o \
 	fnic_debugfs.o \
diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
new file mode 100644
index 000000000000..2dda1ce9a55f
--- /dev/null
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -0,0 +1,1576 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2008 Cisco Systems, Inc.  All rights reserved.
+ * Copyright 2007 Nuova Systems, Inc.  All rights reserved.
+ */
+
+#include <linux/workqueue.h>
+#include "fnic.h"
+#include "fdls_fc.h"
+#include "fnic_fdls.h"
+#include <scsi/fc/fc_fcp.h>
+#include <linux/utsname.h>
+
+static void fdls_send_rpn_id(struct fnic_iport_s *iport);
+
+/* Frame initialization */
+/*
+ * Variables:
+ * sid
+ */
+struct fc_els_s fnic_flogi_req = {
+	.fchdr = {.r_ctl = 0x22, .did = {0xFF,  0xFF,  0xFE},
+			  .type = 0x01, .f_ctl = FNIC_ELS_REQ_FCTL,
+			  .ox_id = FNIC_FLOGI_OXID, .rx_id = 0xFFFF},
+	.command = ELS_FLOGI,
+	.u.csp_flogi = {.fc_ph_ver = FNIC_FC_PH_VER,
+					.b2b_credits = FNIC_FC_B2B_CREDIT,
+					.b2b_rdf_size = FNIC_FC_B2B_RDF_SZ},
+	.spc3 = {0x88, 0x00}
+};
+
+/*
+ * Variables:
+ * sid, did(nport logins), ox_id(nport logins), nport_name, node_name
+ */
+struct fc_els_s fnic_plogi_req = {
+	.fchdr = {.r_ctl = 0x22, .did = {0xFF, 0xFF, 0xFC}, .type = 0x01,
+			  .f_ctl = FNIC_ELS_REQ_FCTL, .ox_id = FNIC_PLOGI_FABRIC_OXID,
+			  .rx_id = 0xFFFF},
+	.command = ELS_PLOGI,
+	.u.csp_plogi = {.fc_ph_ver = FNIC_FC_PH_VER,
+					.b2b_credits = FNIC_FC_B2B_CREDIT, .features = 0x0080,
+					.b2b_rdf_size = FNIC_FC_B2B_RDF_SZ,
+					.total_concur_seqs = FNIC_FC_CONCUR_SEQS,
+					.ro_info = FNIC_FC_RO_INFO, .e_d_tov = FNIC_E_D_TOV},
+	.spc3 = {0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0xFF,
+			 0x00, 0x00, 0x00, 0x01, 0x00, 0x00}
+};
+
+/*
+ * Variables:
+ * sid, port_id, port_name
+ */
+struct fc_rpn_id_s fnic_rpn_id_req = {
+	.fchdr = {.r_ctl = 0x02, .did = {0xFF, 0xFF, 0xFC}, .type = 0x20,
+			  .f_ctl = FNIC_ELS_REQ_FCTL, .ox_id = FNIC_RPN_REQ_OXID,
+			  .rx_id = 0xFFFF},
+	.fc_ct_hdr = {.rev = 0x01, .fs_type = 0xFC, .fs_subtype = 0x02,
+				  .command = FC_CT_RPN_CMD}
+};
+
+/*
+ * Variables:
+ * fh_s_id, port_id, port_name
+ */
+struct fc_rft_id fnic_rft_id_req = {
+	.fchdr = {.r_ctl = 0x02, .did = {0xFF, 0xFF, 0xFC}, .type = 0x20,
+			  .f_ctl = FNIC_ELS_REQ_FCTL, .ox_id = FNIC_RFT_REQ_OXID,
+			  .rx_id = 0xFFFF},
+	.fc_ct_hdr = {.rev = 0x01, .fs_type = 0xFC, .fs_subtype = 0x02,
+				  .command = FC_CT_RFT_CMD}
+};
+
+/*
+ * Variables:
+ * fh_s_id, port_id, port_name
+ */
+struct fc_rff_id fnic_rff_id_req = {
+	.fchdr = {.r_ctl = 0x02, .did = {0xFF, 0xFF, 0xFC}, .type = 0x20,
+			  .f_ctl = FNIC_ELS_REQ_FCTL, .ox_id = FNIC_RFF_REQ_OXID,
+			  .rx_id = 0xFFFF},
+	.fc_ct_hdr = {.rev = 0x01, .fs_type = 0xFC, .fs_subtype = 0x02,
+				  .command = FC_CT_RFF_CMD},
+	.tgt = 0x2,
+	.fc4_type = 0x28
+};
+
+/*
+ * Variables:
+ * sid
+ */
+struct fc_gpn_ft_s fnic_gpn_ft_req = {
+	.fchdr = {.r_ctl = 0x02, .did = {0xFF, 0xFF, 0xFC}, .type = 0x20,
+			  .f_ctl = FNIC_ELS_REQ_FCTL, .ox_id = FNIC_GPN_FT_OXID,
+			  .rx_id = 0xFFFF},
+	.fc_ct_hdr = {.rev = 0x01, .fs_type = 0xFC, .fs_subtype = 0x02,
+				  .command = FC_CT_GPN_FT_CMD},
+	.fc4_type = 0x08
+};
+
+/*
+ * Variables:
+ * sid
+ */
+struct fc_scr_s fnic_scr_req = {
+	.fchdr = {.r_ctl = 0x22, .did = {0xFF, 0xFF, 0xFD}, .type = 0x01,
+			  .f_ctl = FNIC_ELS_REQ_FCTL, .ox_id = FNIC_SCR_REQ_OXID,
+			  .rx_id = 0xFFFF},
+	.command = ELS_SCR,
+	.reg_func = 0x03
+};
+
+/*
+ * Variables:
+ * did, ox_id, rx_id, fcid, wwpn
+ */
+struct fc_logo_req_s fnic_logo_req = {
+	.fchdr = {.r_ctl = 0x22, .type = 0x01,
+			  .f_ctl = FNIC_ELS_REQ_FCTL},
+	.command = ELS_LOGO,
+};
+
+struct fc_hdr_s fc_fabric_abts_s = {
+	.r_ctl = 0x81,			/* ABTS */
+	.did = {0xFF, 0xFF, 0xFF}, .sid = {0x00, 0x00, 0x00}, .cs_ctl =
+			0x00, .type = 0x00, .f_ctl = FNIC_REQ_ABTS_FCTL, .seq_id =
+			0x00, .df_ctl = 0x00, .seq_cnt = 0x0000, .rx_id = 0xFFFF,
+	.param = 0x00000000,	/* bit:0 = 0 Abort a exchange */
+};
+
+#define RETRIES_EXHAUSTED(iport)      \
+	(iport->fabric.retry_counter == FABRIC_LOGO_MAX_RETRY)
+
+static void fdls_process_flogi_rsp(struct fnic_iport_s *iport,
+		   struct fc_hdr_s *fchdr, void *rx_frame);
+static void fnic_fdls_start_plogi(struct fnic_iport_s *iport);
+static void fdls_start_fabric_timer(struct fnic_iport_s *iport,
+			int timeout);
+
+inline void fnic_del_fabric_timer_sync(struct fnic *fnic)
+{
+	fnic->iport.fabric.del_timer_inprogress = 1;
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+	del_timer_sync(&fnic->iport.fabric.retry_timer);
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	fnic->iport.fabric.del_timer_inprogress = 0;
+}
+
+inline void fnic_del_tport_timer_sync(struct fnic *fnic,
+						struct fnic_tport_s *tport)
+{
+	tport->del_timer_inprogress = 1;
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+	del_timer_sync(&tport->retry_timer);
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	tport->del_timer_inprogress = 0;
+}
+
+static void
+fdls_start_fabric_timer(struct fnic_iport_s *iport, int timeout)
+{
+	u64 fabric_tov;
+	struct fnic *fnic = iport->fnic;
+
+	if (iport->fabric.timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "iport fcid: 0x%x: Canceling fabric disc timer\n",
+					 iport->fcid);
+		fnic_del_fabric_timer_sync(fnic);
+		iport->fabric.timer_pending = 0;
+	}
+
+	if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+		iport->fabric.retry_counter++;
+
+	fabric_tov = jiffies + msecs_to_jiffies(timeout);
+	mod_timer(&iport->fabric.retry_timer, round_jiffies(fabric_tov));
+	iport->fabric.timer_pending = 1;
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "fabric timer is %d ", timeout);
+}
+
+static void fdls_send_fabric_abts(struct fnic_iport_s *iport)
+{
+	uint8_t fcid[3];
+	struct fnic *fnic = iport->fnic;
+	struct fc_hdr_s *fabric_abts = &fc_fabric_abts_s;
+
+	switch (iport->fabric.state) {
+	case FDLS_STATE_FABRIC_LOGO:
+		fabric_abts->ox_id = FNIC_FLOGO_REQ_OXID;
+		fabric_abts->did[2] = 0xFE;
+		break;
+
+	case FDLS_STATE_FABRIC_FLOGI:
+		fabric_abts->ox_id = FNIC_FLOGI_OXID;
+		fabric_abts->did[2] = 0xFE;
+		break;
+
+	case FDLS_STATE_FABRIC_PLOGI:
+		hton24(fcid, iport->fcid);
+		FNIC_SET_S_ID(fabric_abts, fcid);
+		fabric_abts->ox_id = FNIC_PLOGI_FABRIC_OXID;
+		fabric_abts->did[2] = 0xFC;
+		break;
+
+	case FDLS_STATE_RPN_ID:
+		hton24(fcid, iport->fcid);
+		FNIC_SET_S_ID(fabric_abts, fcid);
+		fabric_abts->ox_id = FNIC_RPN_REQ_OXID;
+		fabric_abts->did[2] = 0xFC;
+		break;
+
+	case FDLS_STATE_SCR:
+		hton24(fcid, iport->fcid);
+		FNIC_SET_S_ID(fabric_abts, fcid);
+		fabric_abts->ox_id = FNIC_SCR_REQ_OXID;
+		fabric_abts->did[2] = 0xFD;
+		break;
+
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		hton24(fcid, iport->fcid);
+		FNIC_SET_S_ID(fabric_abts, fcid);
+		fabric_abts->ox_id = FNIC_RFT_REQ_OXID;
+		fabric_abts->did[2] = 0xFC;
+		break;
+
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		hton24(fcid, iport->fcid);
+		FNIC_SET_S_ID(fabric_abts, fcid);
+		fabric_abts->ox_id = FNIC_RFF_REQ_OXID;
+		fabric_abts->did[2] = 0xFC;
+		break;
+
+	case FDLS_STATE_GPN_FT:
+		hton24(fcid, iport->fcid);
+		FNIC_SET_S_ID(fabric_abts, fcid);
+		fabric_abts->ox_id = FNIC_GPN_FT_OXID;
+		fabric_abts->did[2] = 0xFC;
+		break;
+	default:
+		return;
+	}
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FDLS sending fabric abts. iport->fabric.state: %d",
+				 iport->fabric.state);
+
+	iport->fabric.flags |= FNIC_FDLS_FABRIC_ABORT_ISSUED;
+	fnic_send_fcoe_frame(iport, &fc_fabric_abts_s, sizeof(struct fc_hdr_s));
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+
+	fdls_start_fabric_timer(iport, 2 * iport->r_a_tov);
+	iport->fabric.timer_pending = 1;
+}
+
+static void fdls_send_fabric_flogi(struct fnic_iport_s *iport)
+{
+	struct fc_els_s flogi;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send fabric FLOGI", iport->fcid);
+
+	memcpy(&flogi, &fnic_flogi_req, sizeof(struct fc_els_s));
+	FNIC_SET_NPORT_NAME(flogi, iport->wwpn);
+	FNIC_SET_NODE_NAME(flogi, iport->wwnn);
+	FNIC_SET_RDF_SIZE(flogi.u.csp_flogi, iport->max_payload_size);
+	FNIC_SET_R_A_TOV(flogi.u.csp_flogi, iport->r_a_tov);
+	FNIC_SET_E_D_TOV(flogi.u.csp_flogi, iport->e_d_tov);
+
+	fnic_send_fcoe_frame(iport, &flogi, sizeof(struct fc_els_s));
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_fabric_plogi(struct fnic_iport_s *iport)
+{
+	struct fc_els_s plogi;
+	struct fc_hdr_s *fchdr = &plogi.fchdr;
+	uint8_t fcid[3];
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send fabric PLOGI", iport->fcid);
+
+	memcpy(&plogi, &fnic_plogi_req, sizeof(struct fc_els_s));
+
+	hton24(fcid, iport->fcid);
+
+	FNIC_SET_S_ID(fchdr, fcid);
+	FNIC_SET_NPORT_NAME(plogi, iport->wwpn);
+	FNIC_SET_NODE_NAME(plogi, iport->wwnn);
+	FNIC_SET_RDF_SIZE(plogi.u.csp_plogi, iport->max_payload_size);
+
+	fnic_send_fcoe_frame(iport, &plogi, sizeof(struct fc_els_s));
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_rpn_id(struct fnic_iport_s *iport)
+{
+	struct fc_rpn_id_s rpn_id;
+	uint8_t fcid[3];
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send RPN ID", iport->fcid);
+
+	memcpy(&rpn_id, &fnic_rpn_id_req, sizeof(struct fc_rpn_id_s));
+
+	hton24(fcid, iport->fcid);
+
+	FNIC_SET_S_ID((&rpn_id.fchdr), fcid);
+	FNIC_SET_RPN_PORT_ID((&rpn_id), fcid);
+	FNIC_SET_RPN_PORT_NAME((&rpn_id), iport->wwpn);
+
+	fnic_send_fcoe_frame(iport, &rpn_id, sizeof(struct fc_rpn_id_s));
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_scr(struct fnic_iport_s *iport)
+{
+	struct fc_scr_s scr_req;
+	uint8_t fcid[3];
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send SCR", iport->fcid);
+
+	memcpy(&scr_req, &fnic_scr_req, sizeof(struct fc_scr_s));
+
+	hton24(fcid, iport->fcid);
+	FNIC_SET_S_ID((&scr_req.fchdr), fcid);
+
+	fnic_send_fcoe_frame(iport, &scr_req, sizeof(struct fc_scr_s));
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_gpn_ft(struct fnic_iport_s *iport, int fdls_state)
+{
+	struct fc_gpn_ft_s gpn_ft;
+	uint8_t fcid[3];
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send GPN FT", iport->fcid);
+
+	memcpy(&gpn_ft, &fnic_gpn_ft_req, sizeof(struct fc_gpn_ft_s));
+
+	hton24(fcid, iport->fcid);
+	FNIC_SET_S_ID((&gpn_ft.fchdr), fcid);
+	fnic_send_fcoe_frame(iport, &gpn_ft, sizeof(struct fc_gpn_ft_s));
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+	fdls_set_state((&iport->fabric), fdls_state);
+}
+
+static void fdls_send_register_fc4_types(struct fnic_iport_s *iport)
+{
+	struct fc_rft_id rft_id;
+	uint8_t fcid[3];
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS sending FC4 Types", iport->fcid);
+
+	memset(&rft_id, 0, sizeof(struct fc_rft_id));
+	memcpy(&rft_id, &fnic_rft_id_req, sizeof(struct fc_rft_id));
+	hton24(fcid, iport->fcid);
+
+	FNIC_SET_S_ID((&rft_id.fchdr), fcid);
+	FNIC_SET_PORT_ID((&rft_id), fcid);
+	if (IS_FNIC_FCP_INITIATOR(fnic))
+		rft_id.fc4_types[2] = 1;
+
+	rft_id.fc4_types[7] = 1;
+	fnic_send_fcoe_frame(iport, &rft_id, sizeof(struct fc_rft_id));
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_register_fc4_features(struct fnic_iport_s *iport)
+{
+	struct fc_rff_id rff_id;
+	uint8_t fcid[3];
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS sending FC4 features", iport->fcid);
+	memcpy(&rff_id, &fnic_rff_id_req, sizeof(struct fc_rff_id));
+
+	hton24(fcid, iport->fcid);
+
+	FNIC_SET_S_ID((&rff_id.fchdr), fcid);
+	FNIC_SET_PORT_ID((&rff_id), fcid);
+
+	if (IS_FNIC_FCP_INITIATOR(fnic)) {
+		rff_id.fc4_type = 0x08;
+	} else {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: Unknown type", iport->fcid);
+	}
+
+	fnic_send_fcoe_frame(iport, &rff_id, sizeof(struct fc_rff_id));
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+/**
+ * fdls_send_fabric_logo - Send flogo to the fcf
+ * @iport: Handle to fnic iport
+ *
+ * This function does not change or check the fabric state.
+ * It the caller's responsibility to set the appropriate iport fabric
+ * state when this is called. Normally it is FDLS_STATE_FABRIC_LOGO.
+ * Currently this assumes to be called with fnic lock held.
+ */
+void fdls_send_fabric_logo(struct fnic_iport_s *iport)
+{
+	struct fc_logo_req_s logo;
+	uint8_t s_id[3];
+	uint8_t d_id[3] = { 0xFF, 0xFF, 0xFE };
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Sending logo to fabric from iport->fcid: 0x%x",
+				 iport->fcid);
+	memcpy(&logo, &fnic_logo_req, sizeof(struct fc_logo_req_s));
+
+	hton24(s_id, iport->fcid);
+
+	FNIC_SET_S_ID((&logo.fchdr), s_id);
+	FNIC_SET_D_ID((&logo.fchdr), d_id);
+	FNIC_SET_OX_ID((&logo.fchdr), FNIC_FLOGO_REQ_OXID);
+
+	memcpy(&logo.fcid, s_id, 3);
+	logo.wwpn = get_unaligned_be64(&iport->wwpn);
+
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+
+	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+	fnic_send_fcoe_frame(iport, &logo, sizeof(struct fc_logo_req_s));
+}
+
+void fdls_fabric_timer_callback(struct timer_list *t)
+{
+	struct fnic_fdls_fabric_s *fabric = from_timer(fabric, t, retry_timer);
+	struct fnic_iport_s *iport =
+		container_of(fabric, struct fnic_iport_s, fabric);
+	struct fnic *fnic = iport->fnic;
+	unsigned long flags;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "tp: %d fab state: %d fab retry counter: %d max_flogi_retries: %d",
+		 iport->fabric.timer_pending, iport->fabric.state,
+		 iport->fabric.retry_counter, iport->max_flogi_retries);
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+
+	if (!iport->fabric.timer_pending) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		return;
+	}
+
+	if (iport->fabric.del_timer_inprogress) {
+		iport->fabric.del_timer_inprogress = 0;
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "fabric_del_timer inprogress(%d). Skip timer cb",
+					 iport->fabric.del_timer_inprogress);
+		return;
+	}
+
+	iport->fabric.timer_pending = 0;
+
+	/* The fabric state indicates which frames have time out, and we retry */
+	switch (iport->fabric.state) {
+	case FDLS_STATE_FABRIC_FLOGI:
+		/* Flogi received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < iport->max_flogi_retries)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_fabric_flogi(iport);
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			return;
+		}
+		/* Flogi has time out 2*ed_tov send abts */
+		if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* Flogi ABTS has timed out and we have waited
+			 * (2 * ra_tov), we can retry safely with same
+			 * exchange id
+			 */
+			if (iport->fabric.retry_counter < iport->max_flogi_retries) {
+				iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+				fdls_send_fabric_flogi(iport);
+			} else
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Exceeded max FLOGI retries");
+		}
+		break;
+	case FDLS_STATE_FABRIC_PLOGI:
+		/* Plogi received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < iport->max_plogi_retries)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_fabric_plogi(iport);
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			return;
+		}
+		/* Plogi has timed out 2*ed_tov send abts */
+		if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* plogi ABTS has timed out and we have waited
+			 * (2 * ra_tov) can retry safely with same
+			 * exchange id
+			 */
+			if (iport->fabric.retry_counter < iport->max_plogi_retries) {
+				iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+				fdls_send_fabric_plogi(iport);
+			} else
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Exceeded max PLOGI retries");
+		}
+		break;
+	case FDLS_STATE_RPN_ID:
+		/* Rpn_id received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_rpn_id(iport);
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			return;
+		}
+		/* RPN have timed out send abts */
+		if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+			fdls_send_fabric_abts(iport);
+		else
+			/* ABTS has timed out (2*ra_tov) */
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		break;
+	case FDLS_STATE_SCR:
+		/* scr received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_scr(iport);
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			return;
+		}
+		/* scr have timed out send abts */
+		if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+			fdls_send_fabric_abts(iport);
+		else {
+			/* ABTS has timed out (2*ra_tov), we give up */
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "ABTS timed out. Starting PLOGI: %p", iport);
+			fnic_fdls_start_plogi(iport);
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		/* scr received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_register_fc4_types(iport);
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			return;
+		}
+		/* RFT_ID timed out send abts */
+		if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* ABTS has timed out (2*ra_tov), we give up */
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "ABTS timed out. Starting PLOGI: %p", iport);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		/* scr received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_register_fc4_features(iport);
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			return;
+		}
+		/* scr have timed out send abts */
+		if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+			fdls_send_fabric_abts(iport);
+		else {
+			/* ABTS has timed out (2*ra_tov), we give up */
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "ABTS timed out. Starting PLOGI %p", iport);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FDLS_STATE_RSCN_GPN_FT:
+	case FDLS_STATE_SEND_GPNFT:
+	case FDLS_STATE_GPN_FT:
+		/* GPN_FT received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_gpn_ft(iport, iport->fabric.state);
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			return;
+		}
+		/* gpn_gt have timed out send abts */
+		if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			fdls_send_fabric_abts(iport);
+		} else {
+			/*
+			 * ABTS has timed out have waited (2*ra_tov) can
+			 * retry safely with same exchange id
+			 */
+			if (iport->fabric.retry_counter < FDLS_RETRY_COUNT) {
+				fdls_send_gpn_ft(iport, iport->fabric.state);
+			} else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "ABTS timeout for fabric GPN_FT. Check name server: %p",
+					 iport);
+			}
+		}
+		break;
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+}
+
+static void fnic_fdls_start_flogi(struct fnic_iport_s *iport)
+{
+	iport->fabric.retry_counter = 0;
+	fdls_send_fabric_flogi(iport);
+	fdls_set_state((&iport->fabric), FDLS_STATE_FABRIC_FLOGI);
+	iport->fabric.flags = 0;
+}
+
+static void fnic_fdls_start_plogi(struct fnic_iport_s *iport)
+{
+	iport->fabric.retry_counter = 0;
+	fdls_send_fabric_plogi(iport);
+	fdls_set_state((&iport->fabric), FDLS_STATE_FABRIC_PLOGI);
+	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+}
+
+static void
+fdls_process_rff_id_rsp(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_rff_id *rff_rsp = (struct fc_rff_id *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+
+	if (fdls_get_state(fdls) != FDLS_STATE_REGISTER_FC4_FEATURES) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RFF_ID resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+
+	rsp = FNIC_GET_FC_CT_CMD((&rff_rsp->fc_ct_hdr));
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS process RFF ID response: 0x%04x", iport->fcid,
+				 (uint32_t) rsp);
+
+	switch (rsp) {
+	case FC_CT_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls_set_state((&iport->fabric), FDLS_STATE_SCR);
+		fdls_send_scr(iport);
+		break;
+	case FC_CT_REJ:
+		reason_code = rff_rsp->fc_ct_hdr.reason_code;
+		if (((reason_code == FC_CT_RJT_LOGICAL_BUSY)
+			 || (reason_code == FC_CT_RJT_BUSY))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RFF_ID ret ELS_LS_RJT BUSY. Retry from timer routine %p",
+					 iport);
+
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RFF_ID returned ELS_LS_RJT. Halting discovery %p", iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+fdls_process_rft_id_rsp(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_rft_id *rft_rsp = (struct fc_rft_id *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+	struct fnic *fnic = iport->fnic;
+
+	if (fdls_get_state(fdls) != FDLS_STATE_REGISTER_FC4_TYPES) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RFT_ID resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+
+	rsp = FNIC_GET_FC_CT_CMD((&rft_rsp->fc_ct_hdr));
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS process RFT ID response: 0x%04x", iport->fcid,
+				 (uint32_t) rsp);
+
+	switch (rsp) {
+	case FC_CT_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls_send_register_fc4_features(iport);
+		fdls_set_state((&iport->fabric), FDLS_STATE_REGISTER_FC4_FEATURES);
+		break;
+	case FC_CT_REJ:
+		reason_code = rft_rsp->fc_ct_hdr.reason_code;
+		if (((reason_code == FC_CT_RJT_LOGICAL_BUSY)
+			 || (reason_code == FC_CT_RJT_BUSY))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: RFT_ID ret ELS_LS_RJT BUSY. Retry from timer routine",
+				 iport->fcid);
+
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: RFT_ID REJ. Halting discovery reason %d expl %d",
+				 iport->fcid, reason_code,
+				 rft_rsp->fc_ct_hdr.reason_expl);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+fdls_process_rpn_id_rsp(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_rpn_id_s *rpn_rsp = (struct fc_rpn_id_s *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+	struct fnic *fnic = iport->fnic;
+
+	if (fdls_get_state(fdls) != FDLS_STATE_RPN_ID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RPN_ID resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+
+	rsp = FNIC_GET_FC_CT_CMD((&rpn_rsp->fc_ct_hdr));
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS process RPN ID response: 0x%04x", iport->fcid,
+				 (uint32_t) rsp);
+
+	switch (rsp) {
+	case FC_CT_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls_send_register_fc4_types(iport);
+		fdls_set_state((&iport->fabric), FDLS_STATE_REGISTER_FC4_TYPES);
+		break;
+	case FC_CT_REJ:
+		reason_code = rpn_rsp->fc_ct_hdr.reason_code;
+		if (((reason_code == FC_CT_RJT_LOGICAL_BUSY)
+			 || (reason_code == FC_CT_RJT_BUSY))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RPN_ID returned REJ BUSY. Retry from timer routine %p",
+					 iport);
+
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "RPN_ID ELS_LS_RJT. Halting discovery %p", iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+fdls_process_scr_rsp(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_scr_s *scr_rsp = (struct fc_scr_s *) fchdr;
+	struct fc_els_reject_s *els_rjt = (struct fc_els_reject_s *) fchdr;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FDLS process SCR response: 0x%04x",
+				 (uint32_t) scr_rsp->command);
+
+	if (fdls_get_state(fdls) != FDLS_STATE_SCR) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "SCR resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+
+	switch (scr_rsp->command) {
+	case ELS_LS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		iport->fabric.retry_counter = 0;
+		fdls_send_gpn_ft(iport, FDLS_STATE_GPN_FT);
+		break;
+
+	case ELS_LS_RJT:
+		if (((els_rjt->reason_code == FC_ELS_RJT_LOGICAL_BUSY)
+			 || (els_rjt->reason_code == FC_ELS_RJT_BUSY))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "SCR ELS_LS_RJT BUSY. Retry from timer routine %p",
+						 iport);
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "SCR returned ELS_LS_RJT. Halting discovery %p",
+						 iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void
+fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr,
+						int len)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_gpn_ft_s *gpn_ft_rsp = (struct fc_gpn_ft_s *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FDLS process GPN_FT response: iport state: %d len: %d",
+				 iport->state, len);
+
+	/*
+	 * GPNFT response :-
+	 *  FDLS_STATE_GPN_FT      : GPNFT send after SCR state
+	 *  during fabric discovery(FNIC_IPORT_STATE_FABRIC_DISC)
+	 *  FDLS_STATE_RSCN_GPN_FT : GPNFT send in response to RSCN
+	 *  FDLS_STATE_SEND_GPNFT  : GPNFT send after deleting a Target,
+	 *  e.g. after receiving Target LOGO
+	 *  FDLS_STATE_TGT_DISCOVERY :Target discovery is currently in progress
+	 *  from previous GPNFT response,a new GPNFT response has come.
+	 */
+	if (!(((iport->state == FNIC_IPORT_STATE_FABRIC_DISC)
+		   && (fdls_get_state(fdls) == FDLS_STATE_GPN_FT))
+		  || ((iport->state == FNIC_IPORT_STATE_READY)
+			  && ((fdls_get_state(fdls) == FDLS_STATE_RSCN_GPN_FT)
+				  || (fdls_get_state(fdls) == FDLS_STATE_SEND_GPNFT)
+				  || (fdls_get_state(fdls) == FDLS_STATE_TGT_DISCOVERY))))) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "GPNFT resp recvd in fab state(%d) iport_state(%d). Dropping.",
+			 fdls_get_state(fdls), iport->state);
+		return;
+	}
+
+	iport->state = FNIC_IPORT_STATE_READY;
+	rsp = FNIC_GET_FC_CT_CMD((&gpn_ft_rsp->fc_ct_hdr));
+
+	switch (rsp) {
+
+	case FC_CT_ACC:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: GPNFT_RSP accept", iport->fcid);
+		break;
+
+	case FC_CT_REJ:
+		reason_code = gpn_ft_rsp->fc_ct_hdr.reason_code;
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: GPNFT_RSP Reject", iport->fcid);
+		break;
+
+	default:
+		break;
+	}
+}
+
+/**
+ * fdls_process_fabric_logo_rsp - Handle an flogo response from the fcf
+ * @iport: Handle to fnic iport
+ * @fchdr: Incoming frame
+ */
+static void
+fdls_process_fabric_logo_rsp(struct fnic_iport_s *iport,
+							 struct fc_hdr_s *fchdr)
+{
+	struct fc_els_s *flogo_rsp = (struct fc_els_s *) fchdr;
+	struct fnic *fnic = iport->fnic;
+
+	switch (flogo_rsp->command) {
+	case ELS_LS_ACC:
+		if (iport->fabric.state != FDLS_STATE_FABRIC_LOGO) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Flogo response. Fabric not in LOGO state. Dropping! %p",
+				 iport);
+			return;
+		}
+
+		iport->fabric.state = FDLS_STATE_FLOGO_DONE;
+		iport->state = FNIC_IPORT_STATE_LINK_WAIT;
+
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "lport 0x%p Canceling fabric disc timer\n",
+						 iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Flogo response from Fabric for did: 0x%x",
+					 ntoh24(fchdr->did));
+		return;
+
+	case ELS_LS_RJT:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Flogo response from Fabric for did: 0x%x returned ELS_LS_RJT",
+			 ntoh24(fchdr->did));
+		return;
+
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGO response not accepted or rejected: 0x%x",
+					 flogo_rsp->command);
+	}
+}
+
+static void
+fdls_process_flogi_rsp(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr,
+					   void *rx_frame)
+{
+	struct fnic_fdls_fabric_s *fabric = &iport->fabric;
+	struct fc_els_s *flogi_rsp = (struct fc_els_s *) fchdr;
+	uint8_t *fcid;
+	int rdf_size;
+	struct fc_els_reject_s *els_rjt;
+	uint8_t fcmac[6] = { 0x0E, 0XFC, 0x00, 0x00, 0x00, 0x00 };
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS processing FLOGI response", iport->fcid);
+
+	if (fdls_get_state(fabric) != FDLS_STATE_FABRIC_FLOGI) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGI response received in state (%d). Dropping frame",
+					 fdls_get_state(fabric));
+		return;
+	}
+
+	switch (flogi_rsp->command) {
+	case ELS_LS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "iport fcid: 0x%x Canceling fabric disc timer\n",
+						 iport->fcid);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+
+		iport->fabric.timer_pending = 0;
+		iport->fabric.retry_counter = 0;
+		fcid = FNIC_GET_D_ID(fchdr);
+		iport->fcid = ntoh24(fcid);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: FLOGI response accepted", iport->fcid);
+
+		/* Learn the Service Params */
+		rdf_size = ntohs(flogi_rsp->u.csp_flogi.b2b_rdf_size);
+		if ((rdf_size >= FNIC_MIN_DATA_FIELD_SIZE)
+			&& (rdf_size < FNIC_FC_MAX_PAYLOAD_LEN))
+			iport->max_payload_size = MIN(rdf_size,
+								  iport->max_payload_size);
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "max_payload_size from fabric: %d set: %d", rdf_size,
+					 iport->max_payload_size);
+
+		iport->r_a_tov = ntohl(flogi_rsp->u.csp_flogi.r_a_tov);
+		iport->e_d_tov = ntohl(flogi_rsp->u.csp_flogi.e_d_tov);
+
+		if (flogi_rsp->u.csp_flogi.features & FNIC_FC_EDTOV_NSEC)
+			iport->e_d_tov = iport->e_d_tov / FNIC_NSEC_TO_MSEC;
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "From fabric: R_A_TOV: %d E_D_TOV: %d",
+					 iport->r_a_tov, iport->e_d_tov);
+
+		if (IS_FNIC_FCP_INITIATOR(fnic)) {
+			fc_host_fabric_name(iport->fnic->lport->host) =
+				get_unaligned_be64(&flogi_rsp->node_name);
+			fc_host_port_id(iport->fnic->lport->host) = iport->fcid;
+		}
+
+		fnic_fdls_learn_fcoe_macs(iport, rx_frame, fcid);
+
+		memcpy(&fcmac[3], fcid, 3);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Adding vNIC device MAC addr: %02x:%02x:%02x:%02x:%02x:%02x",
+			 fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4],
+			 fcmac[5]);
+		vnic_dev_add_addr(iport->fnic->vdev, fcmac);
+
+		if (fdls_get_state(fabric) == FDLS_STATE_FABRIC_FLOGI) {
+			fnic_fdls_start_plogi(iport);
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "FLOGI response received. Starting PLOGI");
+		} else {
+			/* From FDLS_STATE_FABRIC_FLOGI state fabric can only go to
+			 * FDLS_STATE_LINKDOWN
+			 * state, hence we don't have to worry about undoing:
+			 * the fnic_fdls_register_portid and vnic_dev_add_addr
+			 */
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FLOGI response received in state (%d). Dropping frame",
+				 fdls_get_state(fabric));
+		}
+		break;
+
+	case ELS_LS_RJT:
+		els_rjt = (struct fc_els_reject_s *) fchdr;
+		if (fabric->retry_counter < iport->max_flogi_retries) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FLOGI returned ELS_LS_RJT BUSY. Retry from timer routine %p",
+				 iport);
+
+			/* Retry Flogi again from the timer routine. */
+			fabric->flags |= FNIC_FDLS_RETRY_FRAME;
+
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGI returned ELS_LS_RJT. Halting discovery %p", iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "iport 0x%p Canceling fabric disc timer\n",
+							 iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fabric->timer_pending = 0;
+			fabric->retry_counter = 0;
+		}
+		break;
+
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGI response not accepted: 0x%x",
+					 flogi_rsp->command);
+		break;
+	}
+}
+
+static void
+fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
+							  struct fc_hdr_s *fchdr)
+{
+	struct fc_els_s *plogi_rsp = (struct fc_els_s *) fchdr;
+	struct fc_els_reject_s *els_rjt = (struct fc_els_reject_s *) fchdr;
+	struct fnic *fnic = iport->fnic;
+
+	if (fdls_get_state((&iport->fabric)) != FDLS_STATE_FABRIC_PLOGI) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Fabric PLOGI response received in state (%d). Dropping frame",
+			 fdls_get_state(&iport->fabric));
+		return;
+	}
+
+	switch (plogi_rsp->command) {
+	case ELS_LS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "iport fcid: 0x%x fabric PLOGI response: Accepted\n",
+				 iport->fcid);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		iport->fabric.retry_counter = 0;
+		fdls_set_state(&iport->fabric, FDLS_STATE_RPN_ID);
+		fdls_send_rpn_id(iport);
+		break;
+	case ELS_LS_RJT:
+		if (((els_rjt->reason_code == FC_ELS_RJT_LOGICAL_BUSY)
+			 || (els_rjt->reason_code == FC_ELS_RJT_BUSY))
+			&& (iport->fabric.retry_counter < iport->max_plogi_retries)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: Fabric PLOGI ELS_LS_RJT BUSY. Retry from timer routine",
+				 iport->fcid);
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: Fabric PLOGI ELS_LS_RJT. Halting discovery",
+				 iport->fcid);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "iport fcid: 0x%x Canceling fabric disc timer\n",
+							 iport->fcid);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			iport->fabric.timer_pending = 0;
+			iport->fabric.retry_counter = 0;
+			return;
+		}
+		break;
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PLOGI response not accepted: 0x%x",
+					 plogi_rsp->command);
+		break;
+	}
+}
+
+static void
+fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
+							 struct fc_hdr_s *fchdr)
+{
+	uint32_t s_id;
+	struct fc_abts_ba_acc_s *ba_acc = (struct fc_abts_ba_acc_s *) fchdr;
+	struct fc_abts_ba_rjt_s *ba_rjt;
+	uint32_t fabric_state = iport->fabric.state;
+	struct fnic *fnic = iport->fnic;
+
+	s_id = ntoh24(fchdr->sid);
+	ba_rjt = (struct fc_abts_ba_rjt_s *) fchdr;
+
+	if (!((s_id == FC_DIR_SERVER) || (s_id == FC_DOMAIN_CONTR)
+		  || (s_id == FC_FABRIC_CONTROLLER))) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Received abts rsp with invalid SID: 0x%x. Dropping frame",
+			 s_id);
+		return;
+	}
+
+	if (iport->fabric.timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Canceling fabric disc timer %p\n", iport);
+		fnic_del_fabric_timer_sync(fnic);
+	}
+	iport->fabric.timer_pending = 0;
+	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+
+	if (fchdr->r_ctl == FNIC_BA_ACC_RCTL) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Received abts rsp BA_ACC for fabric_state: %d OX_ID: 0x%x",
+			 fabric_state, ba_acc->ox_id);
+	} else if (fchdr->r_ctl == FNIC_BA_RJT_RCTL) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "BA_RJT fs: %d OX_ID: 0x%x rc: 0x%x rce: 0x%x",
+			 fabric_state, ba_rjt->fchdr.ox_id,
+			 ba_rjt->reason_code, ba_rjt->reason_explanation);
+	}
+
+	/* currently error handling/retry logic is same for ABTS BA_ACC & BA_RJT */
+	switch (fabric_state) {
+	case FDLS_STATE_FABRIC_FLOGI:
+		if (fchdr->ox_id == FNIC_FLOGI_OXID) {
+			if (iport->fabric.retry_counter < iport->max_flogi_retries)
+				fdls_send_fabric_flogi(iport);
+			else
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Exceeded max FLOGI retries");
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x FABRIC_FLOGI state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+	case FDLS_STATE_FABRIC_LOGO:
+		if (fchdr->ox_id == FNIC_FLOGO_REQ_OXID) {
+			if (!RETRIES_EXHAUSTED(iport))
+				fdls_send_fabric_logo(iport);
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x FABRIC_FLOGI state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+	case FDLS_STATE_FABRIC_PLOGI:
+		if (fchdr->ox_id == FNIC_PLOGI_FABRIC_OXID) {
+			if (iport->fabric.retry_counter < iport->max_plogi_retries)
+				fdls_send_fabric_plogi(iport);
+			else
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Exceeded max PLOGI retries");
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x FABRIC_PLOGI state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+
+	case FDLS_STATE_RPN_ID:
+		if (fchdr->ox_id == FNIC_RPN_REQ_OXID) {
+			if (iport->fabric.retry_counter < FDLS_RETRY_COUNT) {
+				fdls_send_rpn_id(iport);
+			} else {
+				/* go back to fabric Plogi */
+				fnic_fdls_start_plogi(iport);
+			}
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x RPN_ID state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+
+	case FDLS_STATE_SCR:
+		if (fchdr->ox_id == FNIC_SCR_REQ_OXID) {
+			if (iport->fabric.retry_counter <= FDLS_RETRY_COUNT)
+				fdls_send_scr(iport);
+			else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "abts rsp fab SCR after two tries. Start fabric PLOGI %p",
+					 iport);
+				fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+			}
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x SCR state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		if (fchdr->ox_id == FNIC_RFT_REQ_OXID) {
+			if (iport->fabric.retry_counter <= FDLS_RETRY_COUNT) {
+				fdls_send_register_fc4_types(iport);
+			} else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "abts rsp fab RFT_ID two tries. Start fabric PLOGI %p",
+					 iport);
+				fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+			}
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x RFT state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		if (fchdr->ox_id == FNIC_RFF_REQ_OXID) {
+			if (iport->fabric.retry_counter <= FDLS_RETRY_COUNT)
+				fdls_send_register_fc4_features(iport);
+			else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "abts rsp fab SCR after two tries. Start fabric PLOGI %p",
+					 iport);
+				fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+			}
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x RFF state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+
+	case FDLS_STATE_GPN_FT:
+		if (fchdr->ox_id == FNIC_GPN_FT_OXID) {
+			if (iport->fabric.retry_counter <= FDLS_RETRY_COUNT) {
+				fdls_send_gpn_ft(iport, fabric_state);
+			} else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "abts rsp fab GPN_FT after two tries %p",
+					 iport);
+			}
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unknown abts rsp OX_ID: 0x%x GPN_FT state. Drop frame",
+				 fchdr->ox_id);
+		}
+		break;
+
+	default:
+		return;
+	}
+}
+
+/*
+ * Performs a validation for all FCOE frames and return the frame type
+ */
+int
+fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
+									  void *rx_frame, int len,
+									  int fchdr_offset)
+{
+	struct fc_hdr_s *fchdr;
+	uint8_t type;
+	uint8_t *fc_payload;
+	uint16_t oxid;
+	uint32_t s_id;
+	uint32_t d_id;
+	struct fnic *fnic = iport->fnic;
+	struct fnic_fdls_fabric_s *fabric = &iport->fabric;
+
+	fchdr = (struct fc_hdr_s *) ((uint8_t *) rx_frame + fchdr_offset);
+	oxid = FNIC_GET_OX_ID(fchdr);
+	fc_payload = (uint8_t *) fchdr + sizeof(struct fc_hdr_s);
+	type = *fc_payload;
+	s_id = ntoh24(fchdr->sid);
+	d_id = ntoh24(fchdr->did);
+
+	/* some common validation */
+	if (iport->fcid)
+		if (fdls_get_state(fabric) > FDLS_STATE_FABRIC_FLOGI) {
+			if ((iport->fcid != d_id) || (!FNIC_FC_FRAME_CS_CTL(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "invalid frame received. Dropping frame");
+				return -1;
+			}
+		}
+
+	/*  ABTS response */
+	if ((fchdr->r_ctl == FNIC_BA_ACC_RCTL)
+		|| (fchdr->r_ctl == FNIC_BA_RJT_RCTL)) {
+		if (!(FNIC_FC_FRAME_TYPE_BLS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Received ABTS invalid frame. Dropping frame");
+			return -1;
+
+		}
+		return FNIC_BLS_ABTS_RSP;
+	}
+	if ((fchdr->r_ctl == FC_ABTS_RCTL) && (FNIC_FC_FRAME_TYPE_BLS(fchdr))) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Receiving Abort Request from s_id: 0x%x", s_id);
+		return FNIC_BLS_ABTS_REQ;
+	}
+
+	/* unsolicited requests frames */
+	if (FNIC_FC_FRAME_UNSOLICITED(fchdr)) {
+		switch (type) {
+		case ELS_LOGO:
+			if ((!FNIC_FC_FRAME_FCTL_FIRST_LAST_SEQINIT(fchdr))
+				|| (!FNIC_FC_FRAME_UNSOLICITED(fchdr))
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Received LOGO invalid frame. Dropping frame");
+				return -1;
+			}
+			return FNIC_ELS_LOGO_REQ;
+		case ELS_RSCN:
+			if ((!FNIC_FC_FRAME_FCTL_FIRST_LAST_SEQINIT(fchdr))
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))
+				|| (!FNIC_FC_FRAME_UNSOLICITED(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Received RSCN invalid FCTL. Dropping frame");
+				return -1;
+			}
+			if (s_id != FC_FABRIC_CONTROLLER)
+				return FNIC_ELS_RSCN_REQ;
+			break;
+		case ELS_PLOGI:
+			return FNIC_ELS_PLOGI_REQ;
+		case ELS_ECHO:
+			return FNIC_ELS_ECHO_REQ;
+		case ELS_ADISC:
+			return FNIC_ELS_ADISC;
+		case ELS_RLS:
+			return FNIC_ELS_RLS;
+		case ELS_RRQ:
+			return FNIC_ELS_RRQ;
+		default:
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unsupported frame (type:0x%02x) from fcid: 0x%x",
+				 type, s_id);
+			return FNIC_ELS_UNSUPPORTED_REQ;
+		}
+	}
+
+	/*response from fabric */
+	switch (oxid) {
+
+	case FNIC_FLOGO_REQ_OXID:
+		return FNIC_FABRIC_LOGO_RSP;
+
+	case FNIC_FLOGI_OXID:
+		if (type == ELS_LS_ACC) {
+			if ((s_id != FC_DOMAIN_CONTR)
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+				return -1;
+			}
+		}
+		return FNIC_FABRIC_FLOGI_RSP;
+
+	case FNIC_PLOGI_FABRIC_OXID:
+		if (type == ELS_LS_ACC) {
+			if ((s_id != FC_DIR_SERVER)
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+				return -1;
+			}
+		}
+		return FNIC_FABRIC_PLOGI_RSP;
+
+	case FNIC_SCR_REQ_OXID:
+		if (type == ELS_LS_ACC) {
+			if ((s_id != FC_FABRIC_CONTROLLER)
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+				return -1;
+			}
+		}
+		return FNIC_FABRIC_SCR_RSP;
+
+	case FNIC_RPN_REQ_OXID:
+		if ((s_id != FC_DIR_SERVER) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_RPN_RSP;
+	case FNIC_RFT_REQ_OXID:
+		if ((s_id != FC_DIR_SERVER) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_RFT_RSP;
+	case FNIC_RFF_REQ_OXID:
+		if ((s_id != FC_DIR_SERVER) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_RFF_RSP;
+
+	case FNIC_GPN_FT_OXID:
+		if ((s_id != FC_DIR_SERVER) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_GPN_FT_RSP;
+
+	default:
+		/* Drop the Rx frame and log/stats it */
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Solicited response: unknown OXID: 0x%x", oxid);
+		return -1;
+	}
+	return -1;
+}
+
+void fnic_fdls_recv_frame(struct fnic_iport_s *iport, void *rx_frame,
+						  int len, int fchdr_offset)
+{
+	uint16_t oxid;
+	struct fc_hdr_s *fchdr;
+	uint32_t s_id = 0;
+	uint32_t d_id = 0;
+	struct fnic *fnic = iport->fnic;
+	int frame_type;
+
+	fchdr = (struct fc_hdr_s *) ((uint8_t *) rx_frame + fchdr_offset);
+	s_id = ntoh24(fchdr->sid);
+	d_id = ntoh24(fchdr->did);
+
+	frame_type =
+		fnic_fdls_validate_and_get_frame_type(iport, rx_frame, len,
+					  fchdr_offset);
+
+	/*if we are in flogo drop everything else */
+	if (iport->fabric.state == FDLS_STATE_FABRIC_LOGO &&
+		frame_type != FNIC_FABRIC_LOGO_RSP)
+		return;
+
+	switch (frame_type) {
+	case FNIC_FABRIC_FLOGI_RSP:
+		fdls_process_flogi_rsp(iport, fchdr, rx_frame);
+		break;
+	case FNIC_FABRIC_PLOGI_RSP:
+		fdls_process_fabric_plogi_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_RPN_RSP:
+		fdls_process_rpn_id_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_RFT_RSP:
+		fdls_process_rft_id_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_RFF_RSP:
+		fdls_process_rff_id_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_SCR_RSP:
+		fdls_process_scr_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_GPN_FT_RSP:
+		fdls_process_gpn_ft_rsp(iport, fchdr, len);
+		break;
+	case FNIC_FABRIC_LOGO_RSP:
+		fdls_process_fabric_logo_rsp(iport, fchdr);
+		break;
+
+	case FNIC_BLS_ABTS_RSP:
+		oxid = FNIC_GET_OX_ID(fchdr);
+		if ((iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)
+			&& (oxid >= FNIC_FLOGI_OXID && oxid <= FNIC_RFF_REQ_OXID)) {
+			fdls_process_fabric_abts_rsp(iport, fchdr);
+		}
+		break;
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Received unknown FCoE frame of len: %d. Dropping frame", len);
+		break;
+	}
+}
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index ce73f08ee889..2d5f438f2cc4 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -24,6 +24,7 @@
 #include "vnic_intr.h"
 #include "vnic_stats.h"
 #include "vnic_scsi.h"
+#include "fnic_fdls.h"
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
@@ -31,6 +32,7 @@
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
+#define FABRIC_LOGO_MAX_RETRY 3
 #define DESC_CLEAN_LOW_WATERMARK 8
 #define FNIC_UCSM_DFLT_THROTTLE_CNT_BLD	16 /* UCSM default throttle count */
 #define FNIC_MIN_IO_REQ			256 /* Min IO throttle count */
@@ -75,6 +77,8 @@
 #define FNIC_DEV_RST_TERM_DONE          BIT(20)
 #define FNIC_DEV_RST_ABTS_PENDING       BIT(21)
 
+#define IS_FNIC_FCP_INITIATOR(fnic) (fnic->role == FNIC_ROLE_FCP_INITIATOR)
+
 /*
  * fnic private data per SCSI command.
  * These fields are locked by the hashed io_req_lock.
@@ -213,12 +217,26 @@ enum fnic_state {
 
 struct mempool;
 
+enum fnic_role_e {
+	FNIC_ROLE_FCP_INITIATOR = 0,
+};
+
 enum fnic_evt {
 	FNIC_EVT_START_VLAN_DISC = 1,
 	FNIC_EVT_START_FCF_DISC = 2,
 	FNIC_EVT_MAX,
 };
 
+struct fnic_frame_list {
+	/*
+	 * Link to frame lists
+	 */
+	struct list_head links;
+	void *fp;
+	int frame_len;
+	int rx_ethhdr_stripped;
+};
+
 struct fnic_event {
 	struct list_head list;
 	struct fnic *fnic;
@@ -235,6 +253,8 @@ struct fnic_cpy_wq {
 /* Per-instance private data structure */
 struct fnic {
 	int fnic_num;
+	enum fnic_role_e role;
+	struct fnic_iport_s iport;
 	struct fc_lport *lport;
 	struct fcoe_ctlr ctlr;		/* FIP FCoE controller structure */
 	struct vnic_dev_bar bar0;
@@ -278,6 +298,7 @@ struct fnic {
 	unsigned long state_flags;	/* protected by host lock */
 	enum fnic_state state;
 	spinlock_t fnic_lock;
+	unsigned long lock_flags;
 
 	u16 vlan_id;	                /* VLAN tag including priority */
 	u8 data_src_addr[ETH_ALEN];
@@ -307,7 +328,7 @@ struct fnic {
 	struct work_struct frame_work;
 	struct work_struct flush_work;
 	struct sk_buff_head frame_queue;
-	struct sk_buff_head tx_queue;
+	struct list_head tx_queue;
 
 	/*** FIP related data members  -- start ***/
 	void (*set_vlan)(struct fnic *, u16 vlan);
@@ -397,7 +418,6 @@ void fnic_handle_fip_frame(struct work_struct *work);
 void fnic_handle_fip_event(struct fnic *fnic);
 void fnic_fcoe_reset_vlans(struct fnic *fnic);
 void fnic_fcoe_evlist_free(struct fnic *fnic);
-extern void fnic_handle_fip_timer(struct fnic *fnic);
 
 static inline int
 fnic_chk_state_flags_locked(struct fnic *fnic, unsigned long st_flags)
@@ -406,4 +426,6 @@ fnic_chk_state_flags_locked(struct fnic *fnic, unsigned long st_flags)
 }
 void __fnic_set_state_flags(struct fnic *, unsigned long, unsigned long);
 void fnic_dump_fchost_stats(struct Scsi_Host *, struct fc_host_statistics *);
+void fnic_free_txq(struct list_head *head);
+
 #endif /* _FNIC_H_ */
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index a08293b2ad9f..e5d5a63e0281 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -20,6 +20,8 @@
 #include "fnic_io.h"
 #include "fnic.h"
 #include "fnic_fip.h"
+#include "fnic_fdls.h"
+#include "fdls_fc.h"
 #include "cq_enet_desc.h"
 #include "cq_exch_desc.h"
 
@@ -28,12 +30,90 @@ struct workqueue_struct *fnic_fip_queue;
 struct workqueue_struct *fnic_event_queue;
 
 static void fnic_set_eth_mode(struct fnic *);
-static void fnic_fcoe_send_vlan_req(struct fnic *fnic);
 static void fnic_fcoe_start_fcf_disc(struct fnic *fnic);
 static void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct sk_buff *);
 static int fnic_fcoe_vlan_check(struct fnic *fnic, u16 flag);
 static int fnic_fcoe_handle_fip_frame(struct fnic *fnic, struct sk_buff *skb);
 
+/* Frame initialization */
+/*
+ * Variables:
+ * dst_mac, src_mac
+ */
+struct fnic_eth_hdr_s fnic_eth_hdr_fcoe = {
+	.ether_type = 0x0689
+};
+
+/*
+ * Variables:
+ * None
+ */
+struct fnic_fcoe_hdr_s fnic_fcoe_hdr = {
+	.sof = 0x2E
+};
+
+uint8_t FCOE_ALL_FCF_MAC[6] = { 0x0e, 0xfc, 0x00, 0xff, 0xff, 0xfe };
+
+/*
+ * Internal Functions
+ * This function will initialize the src_mac address to be
+ * used in outgoing frames
+ */
+static inline void fnic_fdls_set_fcoe_srcmac(struct fnic *fnic,
+							 uint8_t *src_mac)
+{
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Setting src mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 src_mac[0], src_mac[1], src_mac[2], src_mac[3],
+				 src_mac[4], src_mac[5]);
+
+	memcpy(fnic->iport.fpma, src_mac, 6);
+}
+
+/*
+ * This function will initialize the dst_mac address to be
+ * used in outgoing frames
+ */
+static inline  void fnic_fdls_set_fcoe_dstmac(struct fnic *fnic,
+							 uint8_t *dst_mac)
+{
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Setting dst mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 dst_mac[0], dst_mac[1], dst_mac[2], dst_mac[3],
+				 dst_mac[4], dst_mac[5]);
+
+	memcpy(fnic->iport.fcfmac, dst_mac, 6);
+}
+
+/*
+ * FPMA can be either taken from ethhdr(dst_mac) or flogi resp
+ * or derive from FC_MAP and FCID combination. While it should be
+ * same, revisit this if there is any possibility of not-correct.
+ */
+void fnic_fdls_learn_fcoe_macs(struct fnic_iport_s *iport, void *rx_frame,
+							   uint8_t *fcid)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fnic_eth_hdr_s *ethhdr = (struct fnic_eth_hdr_s *) rx_frame;
+	uint8_t fcmac[6] = { 0x0E, 0xFC, 0x00, 0x00, 0x00, 0x00 };
+
+	memcpy(&fcmac[3], fcid, 3);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "learn fcoe: dst_mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 ethhdr->dst_mac[0], ethhdr->dst_mac[1],
+				 ethhdr->dst_mac[2], ethhdr->dst_mac[3],
+				 ethhdr->dst_mac[4], ethhdr->dst_mac[5]);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "learn fcoe: fc_mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4],
+				 fcmac[5]);
+
+	fnic_fdls_set_fcoe_srcmac(fnic, fcmac);
+	fnic_fdls_set_fcoe_dstmac(fnic, ethhdr->src_mac);
+}
+
 void fnic_handle_link(struct work_struct *work)
 {
 	struct fnic *fnic = container_of(work, struct fnic, link_work);
@@ -363,7 +443,7 @@ static inline int is_fnic_fip_flogi_reject(struct fcoe_ctlr *fip,
 	return 0;
 }
 
-static void fnic_fcoe_send_vlan_req(struct fnic *fnic)
+void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 {
 	struct fcoe_ctlr *fip = &fnic->ctlr;
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
@@ -1068,116 +1148,119 @@ void fnic_eth_send(struct fcoe_ctlr *fip, struct sk_buff *skb)
 /*
  * Send FC frame.
  */
-static int fnic_send_frame(struct fnic *fnic, struct fc_frame *fp)
+static int fnic_send_frame(struct fnic *fnic, void *frame, int frame_len)
 {
 	struct vnic_wq *wq = &fnic->wq[0];
-	struct sk_buff *skb;
 	dma_addr_t pa;
-	struct ethhdr *eth_hdr;
-	struct vlan_ethhdr *vlan_hdr;
-	struct fcoe_hdr *fcoe_hdr;
-	struct fc_frame_header *fh;
-	u32 tot_len, eth_hdr_len;
 	int ret = 0;
 	unsigned long flags;
 
-	fh = fc_frame_header_get(fp);
-	skb = fp_skb(fp);
-
-	if (unlikely(fh->fh_r_ctl == FC_RCTL_ELS_REQ) &&
-	    fcoe_ctlr_els_send(&fnic->ctlr, fnic->lport, skb))
-		return 0;
-
-	if (!fnic->vlan_hw_insert) {
-		eth_hdr_len = sizeof(*vlan_hdr) + sizeof(*fcoe_hdr);
-		vlan_hdr = skb_push(skb, eth_hdr_len);
-		eth_hdr = (struct ethhdr *)vlan_hdr;
-		vlan_hdr->h_vlan_proto = htons(ETH_P_8021Q);
-		vlan_hdr->h_vlan_encapsulated_proto = htons(ETH_P_FCOE);
-		vlan_hdr->h_vlan_TCI = htons(fnic->vlan_id);
-		fcoe_hdr = (struct fcoe_hdr *)(vlan_hdr + 1);
-	} else {
-		eth_hdr_len = sizeof(*eth_hdr) + sizeof(*fcoe_hdr);
-		eth_hdr = skb_push(skb, eth_hdr_len);
-		eth_hdr->h_proto = htons(ETH_P_FCOE);
-		fcoe_hdr = (struct fcoe_hdr *)(eth_hdr + 1);
-	}
-
-	if (fnic->ctlr.map_dest)
-		fc_fcoe_set_mac(eth_hdr->h_dest, fh->fh_d_id);
-	else
-		memcpy(eth_hdr->h_dest, fnic->ctlr.dest_addr, ETH_ALEN);
-	memcpy(eth_hdr->h_source, fnic->data_src_addr, ETH_ALEN);
-
-	tot_len = skb->len;
-	BUG_ON(tot_len % 4);
+	pa = dma_map_single(&fnic->pdev->dev, frame, frame_len, DMA_TO_DEVICE);
 
-	memset(fcoe_hdr, 0, sizeof(*fcoe_hdr));
-	fcoe_hdr->fcoe_sof = fr_sof(fp);
-	if (FC_FCOE_VER)
-		FC_FCOE_ENCAPS_VER(fcoe_hdr, FC_FCOE_VER);
-
-	pa = dma_map_single(&fnic->pdev->dev, eth_hdr, tot_len, DMA_TO_DEVICE);
-	if (dma_mapping_error(&fnic->pdev->dev, pa)) {
-		ret = -ENOMEM;
-		printk(KERN_ERR "DMA map failed with error %d\n", ret);
-		goto free_skb_on_err;
-	}
-
-	if ((fnic_fc_trace_set_data(fnic->lport->host->host_no, FNIC_FC_SEND,
-				(char *)eth_hdr, tot_len)) != 0) {
-		printk(KERN_ERR "fnic ctlr frame trace error!!!");
+	if ((fnic_fc_trace_set_data(fnic->fnic_num,
+				FNIC_FC_SEND | 0x80, (char *) frame,
+				frame_len)) != 0) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "fnic ctlr frame trace error");
 	}
 
 	spin_lock_irqsave(&fnic->wq_lock[0], flags);
 
 	if (!vnic_wq_desc_avail(wq)) {
-		dma_unmap_single(&fnic->pdev->dev, pa, tot_len, DMA_TO_DEVICE);
+		dma_unmap_single(&fnic->pdev->dev, pa, frame_len, DMA_TO_DEVICE);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "vnic work queue descriptor is not available");
 		ret = -1;
-		goto irq_restore;
+		goto fnic_send_frame_end;
 	}
 
-	fnic_queue_wq_desc(wq, skb, pa, tot_len, fr_eof(fp),
-			   0 /* hw inserts cos value */,
-			   fnic->vlan_id, 1, 1, 1);
+	/* hw inserts cos value */
+	fnic_queue_wq_desc(wq, frame, pa, frame_len, FNIC_FCOE_EOF,
+					   0, fnic->vlan_id, 1, 1, 1);
 
-irq_restore:
+fnic_send_frame_end:
 	spin_unlock_irqrestore(&fnic->wq_lock[0], flags);
-
-free_skb_on_err:
-	if (ret)
-		dev_kfree_skb_any(fp_skb(fp));
-
 	return ret;
 }
 
-/*
- * fnic_send
- * Routine to send a raw frame
- */
-int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
+static int
+fdls_send_fcoe_frame(struct fnic *fnic, void *payload, int payload_sz,
+					 uint8_t *srcmac, uint8_t *dstmac)
 {
-	struct fnic *fnic = lport_priv(lp);
-	unsigned long flags;
+	uint8_t *frame;
+	struct fnic_eth_hdr_s *ethhdr;
+	struct fnic_frame_list *frame_elem;
+	int max_framesz = FNIC_FCOE_FRAME_MAXSZ;
+	int len = 0;
+	int ret;
 
-	if (fnic->in_remove) {
-		dev_kfree_skb(fp_skb(fp));
-		return -1;
+	frame = kzalloc(max_framesz, GFP_ATOMIC);
+	if (!frame) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Failed to allocate frame for flogi\n");
+		return -ENOMEM;
 	}
+	ethhdr = (struct fnic_eth_hdr_s *) frame;
+
+	memcpy(frame, (uint8_t *) &fnic_eth_hdr_fcoe,
+		   sizeof(struct fnic_eth_hdr_s));
+	len = sizeof(struct fnic_eth_hdr_s);
+
+	memcpy(ethhdr->src_mac, srcmac, ETH_ALEN);
+	memcpy(ethhdr->dst_mac, dstmac, ETH_ALEN);
+
+	memcpy(frame + len, (uint8_t *) &fnic_fcoe_hdr,
+		   sizeof(struct fnic_fcoe_hdr_s));
+	len += sizeof(struct fnic_fcoe_hdr_s);
+
+	memcpy(frame + len, (uint8_t *) payload, payload_sz);
+	len += payload_sz;
 
 	/*
 	 * Queue frame if in a transitional state.
 	 * This occurs while registering the Port_ID / MAC address after FLOGI.
 	 */
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (fnic->state != FNIC_IN_FC_MODE && fnic->state != FNIC_IN_ETH_MODE) {
-		skb_queue_tail(&fnic->tx_queue, fp_skb(fp));
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	if ((fnic->state != FNIC_IN_FC_MODE)
+		&& (fnic->state != FNIC_IN_ETH_MODE)) {
+		frame_elem = kzalloc(sizeof(struct fnic_frame_list), GFP_ATOMIC);
+		if (!frame_elem) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Failed to allocate memory for fnic_frame_list: %lu\n",
+						 sizeof(struct fnic_frame_list));
+			return -ENOMEM;
+		}
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Queuing frame: 0x%p\n", frame);
+
+		frame_elem->fp = frame;
+		frame_elem->frame_len = len;
+		list_add_tail(&frame_elem->links, &fnic->tx_queue);
 		return 0;
 	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	return fnic_send_frame(fnic, fp);
+	ret = fnic_send_frame(fnic, frame, len);
+	return ret;
+}
+
+void fnic_send_fcoe_frame(struct fnic_iport_s *iport, void *payload,
+						 int payload_sz)
+{
+	struct fnic *fnic = iport->fnic;
+	uint8_t *dstmac, *srcmac;
+
+	/* If module unload is in-progress, don't send */
+	if (fnic->in_remove)
+		return;
+
+	if (iport->fabric.flags & FNIC_FDLS_FPMA_LEARNT) {
+		srcmac = iport->fpma;
+		dstmac = iport->fcfmac;
+	} else {
+		srcmac = iport->hwmac;
+		dstmac = FCOE_ALL_FCF_MAC;
+	}
+
+	fdls_send_fcoe_frame(fnic, payload, payload_sz, srcmac, dstmac);
 }
 
 /**
@@ -1193,15 +1276,66 @@ int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
 void fnic_flush_tx(struct work_struct *work)
 {
 	struct fnic *fnic = container_of(work, struct fnic, flush_work);
-	struct sk_buff *skb;
 	struct fc_frame *fp;
+	struct fnic_frame_list *cur_frame, *next;
 
-	while ((skb = skb_dequeue(&fnic->tx_queue))) {
-		fp = (struct fc_frame *)skb;
-		fnic_send_frame(fnic, fp);
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Flush queued frames");
+
+	list_for_each_entry_safe(cur_frame, next, &fnic->tx_queue, links) {
+		fp = cur_frame->fp;
+		list_del(&cur_frame->links);
+		fnic_send_frame(fnic, fp, cur_frame->frame_len);
 	}
 }
 
+int
+fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
+						  void *fp)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fnic_eth_hdr_s *ethhdr;
+	int ret;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Setting port id: 0x%x fp: 0x%p fnic state: %d", port_id,
+				 fp, fnic->state);
+
+	if (fp) {
+		ethhdr = (struct fnic_eth_hdr_s *) fp;
+		vnic_dev_add_addr(fnic->vdev, ethhdr->dst_mac);
+	}
+
+	/* Change state to reflect transition to FC mode */
+	if (fnic->state == FNIC_IN_ETH_MODE || fnic->state == FNIC_IN_FC_MODE)
+		fnic->state = FNIC_IN_ETH_TRANS_FC_MODE;
+	else {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Unexpected fnic state while processing FLOGI response\n");
+		return -1;
+	}
+
+	/*
+	 * Send FLOGI registration to firmware to set up FC mode.
+	 * The new address will be set up when registration completes.
+	 */
+	ret = fnic_flogi_reg_handler(fnic, port_id);
+	if (ret < 0) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGI registration error ret: %d fnic state: %d\n",
+					 ret, fnic->state);
+		if (fnic->state == FNIC_IN_ETH_TRANS_FC_MODE)
+			fnic->state = FNIC_IN_ETH_MODE;
+
+		return -1;
+	}
+	iport->fabric.flags |= FNIC_FDLS_FPMA_LEARNT;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FLOGI registration success\n");
+	return 0;
+}
+
 /**
  * fnic_set_eth_mode() - put fnic into ethernet mode.
  * @fnic: fnic device
@@ -1240,6 +1374,17 @@ static void fnic_set_eth_mode(struct fnic *fnic)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 }
 
+void fnic_free_txq(struct list_head *head)
+{
+	struct fnic_frame_list *cur_frame, *next;
+
+	list_for_each_entry_safe(cur_frame, next, head, links) {
+		list_del(&cur_frame->links);
+		kfree(cur_frame->fp);
+		kfree(cur_frame);
+	}
+}
+
 static void fnic_wq_complete_frame_send(struct vnic_wq *wq,
 					struct cq_desc *cq_desc,
 					struct vnic_wq_buf *buf, void *opaque)
@@ -1319,88 +1464,3 @@ void fnic_fcoe_reset_vlans(struct fnic *fnic)
 	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
 }
 
-void fnic_handle_fip_timer(struct fnic *fnic)
-{
-	unsigned long flags;
-	struct fcoe_vlan *vlan;
-	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
-	u64 sol_time;
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (fnic->stop_rx_link_events) {
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-
-	if (fnic->ctlr.mode == FIP_MODE_NON_FIP)
-		return;
-
-	spin_lock_irqsave(&fnic->vlans_lock, flags);
-	if (list_empty(&fnic->vlans)) {
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		/* no vlans available, try again */
-		if (unlikely(fnic_log_level & FNIC_FCS_LOGGING))
-			if (printk_ratelimit())
-				shost_printk(KERN_DEBUG, fnic->lport->host,
-						"Start VLAN Discovery\n");
-		fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
-		return;
-	}
-
-	vlan = list_first_entry(&fnic->vlans, struct fcoe_vlan, list);
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-		  "fip_timer: vlan %d state %d sol_count %d\n",
-		  vlan->vid, vlan->state, vlan->sol_count);
-	switch (vlan->state) {
-	case FIP_VLAN_USED:
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-			  "FIP VLAN is selected for FC transaction\n");
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		break;
-	case FIP_VLAN_FAILED:
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		/* if all vlans are in failed state, restart vlan disc */
-		if (unlikely(fnic_log_level & FNIC_FCS_LOGGING))
-			if (printk_ratelimit())
-				shost_printk(KERN_DEBUG, fnic->lport->host,
-					  "Start VLAN Discovery\n");
-		fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
-		break;
-	case FIP_VLAN_SENT:
-		if (vlan->sol_count >= FCOE_CTLR_MAX_SOL) {
-			/*
-			 * no response on this vlan, remove  from the list.
-			 * Try the next vlan
-			 */
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-				  "Dequeue this VLAN ID %d from list\n",
-				  vlan->vid);
-			list_del(&vlan->list);
-			kfree(vlan);
-			vlan = NULL;
-			if (list_empty(&fnic->vlans)) {
-				/* we exhausted all vlans, restart vlan disc */
-				spin_unlock_irqrestore(&fnic->vlans_lock,
-							flags);
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-					  "fip_timer: vlan list empty, "
-					  "trigger vlan disc\n");
-				fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
-				return;
-			}
-			/* check the next vlan */
-			vlan = list_first_entry(&fnic->vlans, struct fcoe_vlan,
-							list);
-			fnic->set_vlan(fnic, vlan->vid);
-			vlan->state = FIP_VLAN_SENT; /* sent now */
-		}
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		atomic64_inc(&fnic_stats->vlan_stats.sol_expiry_count);
-		vlan->sol_count++;
-		sol_time = jiffies + msecs_to_jiffies
-					(FCOE_CTLR_START_DELAY);
-		mod_timer(&fnic->fip_timer, round_jiffies(sol_time));
-		break;
-	}
-}
diff --git a/drivers/scsi/fnic/fnic_fdls.h b/drivers/scsi/fnic/fnic_fdls.h
index c31c9abc9d3f..f64a2ba2e10d 100644
--- a/drivers/scsi/fnic/fnic_fdls.h
+++ b/drivers/scsi/fnic/fnic_fdls.h
@@ -308,18 +308,21 @@ void fdls_tgt_logout(struct fnic_iport_s *iport, struct fnic_tport_s *tport);
 inline void fnic_del_fabric_timer_sync(struct fnic *fnic);
 inline void fnic_del_tport_timer_sync(struct fnic *fnic,
 							struct fnic_tport_s *tport);
+void fdls_send_fabric_logo(struct fnic_iport_s *iport);
+int fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
+								  void *rx_frame, int len,
+								  int fchdr_offset);
 void fdls_fdmi_timer_callback(struct timer_list *t);
 
 /* fnic_fcs.c */
 void fnic_fdls_init(struct fnic *fnic, int usefip);
 void fnic_send_fcoe_frame(struct fnic_iport_s *iport, void *payload,
 	int payload_sz);
-
+void fnic_fcoe_send_vlan_req(struct fnic *fnic);
 int fnic_send_fip_frame(struct fnic_iport_s *iport,
 	void *payload, int payload_sz);
 void fnic_fdls_learn_fcoe_macs(struct fnic_iport_s *iport, void *rx_frame,
 	uint8_t *fcid);
-
 void fnic_fdls_add_tport(struct fnic_iport_s *iport,
 		struct fnic_tport_s *tport, unsigned long flags);
 void fnic_fdls_remove_tport(struct fnic_iport_s *iport,
diff --git a/drivers/scsi/fnic/fnic_io.h b/drivers/scsi/fnic/fnic_io.h
index 5895ead20e14..6fe642cb387b 100644
--- a/drivers/scsi/fnic/fnic_io.h
+++ b/drivers/scsi/fnic/fnic_io.h
@@ -55,15 +55,4 @@ struct fnic_io_req {
 	unsigned int tag;
 	struct scsi_cmnd *sc; /* midlayer's cmd pointer */
 };
-
-enum fnic_port_speeds {
-	DCEM_PORTSPEED_NONE = 0,
-	DCEM_PORTSPEED_1G    = 1000,
-	DCEM_PORTSPEED_10G   = 10000,
-	DCEM_PORTSPEED_20G   = 20000,
-	DCEM_PORTSPEED_25G   = 25000,
-	DCEM_PORTSPEED_40G   = 40000,
-	DCEM_PORTSPEED_4x10G = 41000,
-	DCEM_PORTSPEED_100G  = 100000,
-};
 #endif /* _FNIC_IO_H_ */
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 2933b4c36e58..fd0b00fea813 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -31,6 +31,8 @@
 #include "fnic_io.h"
 #include "fnic_fip.h"
 #include "fnic.h"
+#include "fnic_fdls.h"
+#include "fdls_fc.h"
 
 #define PCI_DEVICE_ID_CISCO_FNIC	0x0045
 
@@ -80,7 +82,6 @@ module_param(fnic_max_qdepth, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(fnic_max_qdepth, "Queue depth to report for each LUN");
 
 static struct libfc_function_template fnic_transport_template = {
-	.frame_send = fnic_send,
 	.lport_set_port_id = fnic_set_port_id,
 	.fcp_abort_io = fnic_empty_scsi_cleanup,
 	.fcp_cleanup = fnic_empty_scsi_cleanup,
@@ -413,7 +414,7 @@ static void fnic_fip_notify_timer(struct timer_list *t)
 {
 	struct fnic *fnic = from_timer(fnic, t, fip_timer);
 
-	fnic_handle_fip_timer(fnic);
+	/* Placeholder function */
 }
 
 static void fnic_notify_timer_start(struct fnic *fnic)
@@ -921,7 +922,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&fnic->link_work, fnic_handle_link);
 	INIT_WORK(&fnic->frame_work, fnic_handle_frame);
 	skb_queue_head_init(&fnic->frame_queue);
-	skb_queue_head_init(&fnic->tx_queue);
+	INIT_LIST_HEAD(&fnic->tx_queue);
 
 	fc_fabric_login(lp);
 
@@ -1004,7 +1005,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	 */
 	flush_workqueue(fnic_event_queue);
 	skb_queue_purge(&fnic->frame_queue);
-	skb_queue_purge(&fnic->tx_queue);
+	fnic_free_txq(&fnic->tx_queue);
 
 	if (fnic->config.flags & VFCF_FIP_CAPABLE) {
 		del_timer_sync(&fnic->fip_timer);
@@ -1036,7 +1037,6 @@ static void fnic_remove(struct pci_dev *pdev)
 	fnic_cleanup(fnic);
 
 	BUG_ON(!skb_queue_empty(&fnic->frame_queue));
-	BUG_ON(!skb_queue_empty(&fnic->tx_queue));
 
 	spin_lock_irqsave(&fnic_list_lock, flags);
 	list_del(&fnic->list);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 2ba61dba4569..295dcda4ec16 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -184,7 +184,7 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 	fnic_set_state_flags(fnic, FNIC_FLAGS_FWRESET);
 
 	skb_queue_purge(&fnic->frame_queue);
-	skb_queue_purge(&fnic->tx_queue);
+	fnic_free_txq(&fnic->tx_queue);
 
 	/* wait for io cmpl */
 	while (atomic_read(&fnic->in_flight))
@@ -674,7 +674,7 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 	 */
 	if (fnic->remove_wait || ret) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		skb_queue_purge(&fnic->tx_queue);
+		fnic_free_txq(&fnic->tx_queue);
 		goto reset_cmpl_handler_end;
 	}
 
@@ -1717,7 +1717,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 	return true;
 }
 
-static void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
+void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
 {
 	struct terminate_stats *term_stats = &fnic->fnic_stats.term_stats;
 	struct fnic_rport_abort_io_iter_data iter_data = {
-- 
2.31.1


