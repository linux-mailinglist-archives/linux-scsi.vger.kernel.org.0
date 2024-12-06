Return-Path: <linux-scsi+bounces-10603-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0770D9E7A67
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 22:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CCA18878DC
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55273204563;
	Fri,  6 Dec 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="HF4YLZ7T"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BD212F86;
	Fri,  6 Dec 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519554; cv=none; b=JH+w5xBcn0cdWEQKaKWsEbHS+vN0pF+llbqBiMbRAxe/gowBg3oEHv9akdglfU/GmkKrFwUlUmH5srN1DsMb9JKIPuadOA4J+cVGNxEUlD+YPArVZCngoVRf+byEAmYli4SKInVELGtXtZO60+vPooDtdOM07+lvNEM1sJPYV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519554; c=relaxed/simple;
	bh=/wx1kADWA8PFbChn04IdtlqXNMUGh7z31pKYjOVtuFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTXRFC4+r4gDE8rWvB4a9v6SOXw1SRNPNDV5/UWGaaEBMI7mVUSWvXVM6OHgtG/SyvpZ+EM4YDHu/i36+46sci6lY+dwEYBQ+LcNFmcfwEDbMbblj4cZ2lvBlFGiFyGhXwrOJWxnvL+cq3s75ION2OXVkhEyWWjUxM502mg1waY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=HF4YLZ7T; arc=none smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=60708; q=dns/txt;
  s=iport; t=1733519549; x=1734729149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgUlpEiOrgcXwmtsWhQibwZA4PkCD89h8H+CMr/WCOg=;
  b=HF4YLZ7T7yeEpo5iuxMVwRQW2MvisZnYCS/MjzPO3PtX7mcEyknrgcEV
   5ajVL3XE7b9aW/NsGKlcZuUDZ6We+xp5QIRoUcF7V2bZgswkrRasbiLCy
   S/nS9smhBD73zI/sAVznO2HXOyIX6LlZPL/P5rfvJLuW4ZKGxd94oHMBw
   s=;
X-CSE-ConnectionGUID: U4/dPkyCQ5qE/0DTHuvuEg==
X-CSE-MsgGUID: nfic573QR0i7aaFkqVmwoA==
X-IPAS-Result: =?us-ascii?q?A0ADAABwZ1Nn/4//Ja1SCBkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBgX8EAQEBAQELAYIbL3ZZQxkvjHKJUYEWnQUUgREDV?=
 =?us-ascii?q?g8BAQEPOQsEAQGFBwKKaAImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBB?=
 =?us-ascii?q?QEBAQIBBwWBDhOFew2GWwIBAxoBDAsBRhBRRREZgilYAYJkAxGxbIF5M4EB3?=
 =?us-ascii?q?jOBZwaBSAGNSXCEdycVBoFJRIEVgTuBNwdvgQUBTII+DA0ChlwEgzWDI3Ylg?=
 =?us-ascii?q?ROEIYNMgW+JAIJ8HTALgiOMN0iBIQNZIREBVRMNCgsHBYF2A4JNeiuBC4EXO?=
 =?us-ascii?q?oF+gRNKg0qBQkY9gkppSzcCDQI2giR9eIFVhRmEaWMvAwMDA4McIIYlRIE4O?=
 =?us-ascii?q?EADCxgNSBEsFCMUGwY+bgehRQFGg0cDCAYBASwdMQkLKxcJAS99MBYBHguSd?=
 =?us-ascii?q?CMHAgERj3GCIIE0n02EJIwXgliSVRozhASmTZh7jgKURnhNN4RmgWc8gVkzG?=
 =?us-ascii?q?ggbFTuCZxM/GQ+OLQsLFohWuTclMgI6AgcLAQEDCZM8AQECJAduYAEB?=
IronPort-Data: A9a23:lIhBmq5HSvQOl4S07SOu4QxRtB7GchMFZxGqfqrLsTDasY5as4F+v
 jQWXz/XMqzbYDDyfdF+Pdy29EoBusTVy9NkTQBlryg2Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoazhMtfrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eANFf9t50EEp3q
 OU1b2ghUjCemf+bz+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGc6FSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEUUrsUIMpWcOOAhXDlbzxcoVG9rqss6G+Vxwt0uFToGICEII3THpQEwi50o
 ErA8WXyX05BDebHyGWM+1yvn9HKgiTSDdd6+LqQs6QCbEeo7mgQEDUXU0e2pb+yjUvWc9BSK
 UY8/isosLh09UauCNL6WnWQpXeeoh8aHcJdD+Ag8wyL4q3O6g2dCy4PSTspQNgnstImAD8nz
 FmEm/v3CjF19r6YU3SQ8vGTtzzaESwUK3ISIDQPVgot/dbuuscwgwjJQ9IlF7S65uAZAhnqy
 DyM6Sx7jLIJgItTieOw/EvMhHSnoZ2hohMJ2zg7l1mNtmtRDLNJraTxgbQHxZ6s9Lqkc2Q=
IronPort-HdrOrdr: A9a23:h8Zal6FbcH/YgIkqpLqEx8eALOsnbusQ8zAXPo5KJSC9Ffbo8/
 xG88506faZslwssTQb6LO90cq7MBbhHPxOgLX5VI3KNGLbUSmTXeNfBODZrAEIdReSysdtkY
 99bqlzD8DxB1Bmgcu/3BO1CL8bsb66GdiT5ds3CxxWPHhXg2YK1XYeNjqm
X-Talos-CUID: =?us-ascii?q?9a23=3AzVMy6mgyPLcC2FndpTU8L5/FTzJuTyGawE/TMmS?=
 =?us-ascii?q?BVH9ED+W5dX+N5r5JnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AdhsJ+wxdyx9eUnrDJhL9qNQo0dqaqKKgCUtQzs4?=
 =?us-ascii?q?/gZGFaiV5FTSEsjGoRaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="292913994"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Dec 2024 21:11:19 +0000
Received: from fedora.cisco.com (unknown [10.24.83.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id 0157918000254;
	Fri,  6 Dec 2024 21:11:18 +0000 (GMT)
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com,
	djhawar@cisco.com,
	gcboffa@cisco.com,
	mkai2@cisco.com,
	satishkh@cisco.com,
	aeasi@cisco.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karan Tilak Kumar <kartilak@cisco.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 04/15] scsi: fnic: Add support for target based solicited requests and responses
Date: Fri,  6 Dec 2024 13:08:41 -0800
Message-ID: <20241206210852.3251-5-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206210852.3251-1-kartilak@cisco.com>
References: <20241206210852.3251-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.24.83.168, [10.24.83.168]
X-Outbound-Node: rcdn-l-core-06.cisco.com

Add support for target based solicited requests and responses.
Add support for tport definitions and processing.
Add support for restarting the IT nexus.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202406120146.xchlZbqX-lkp@
intel.com/

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Co-developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-developed-by: Arun Easi <aeasi@cisco.com>
Signed-off-by: Arun Easi <aeasi@cisco.com>
Co-developed-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v5 and v6:
    Incorporate review comments from Martin:
        Remove GCC 13.3 warnings.
    Incorporate review comments from Hannes:
	Allocate OXID from a pool.
	Modify frame initialization.
	Modify frame send by avoiding memcpy in hot path.

Changes between v4 and v5:
    Incorporate review comments from Martin:
        Call fdls_get_tgt_oxid_pool.
        Modify attribution appropriately.

Changes between v2 and v3:
    Fix issue found by kernel test robot.
    Remove fnic_std_ba_acc definition to fix compilation
    warning.
    Incorporate review comments from Hannes:
        Replace redundant definitions with standard definitions.
        Replace static OXIDs with pool-based OXIDs for targets.

Changes between v1 and v2:
    Incorporate review comments from Hannes:
        Use the correct kernel-doc format.
        Replace htonll() with get_unaligned_be64().
        Replace fnic_del_fabric_timer_sync macro calls to function
        calls.
        Replace fnic_del_tport_timer_sync macro calls to function
        calls.
        Rename fc_abts_s to fc_tport_abts_s.
        Modify fc_tport_abts_s to be a global frame.
        Rename variable pfc_abts to tport_abts.
        Replace definitions with standard definitions from
        fc_els.h.
        Modify functions with returns in the middle to if else
        clauses.
    Replace simultaneous use of fc_tport_abts_s and tport_abts with
    just tport_abts.
---
 drivers/scsi/fnic/fdls_disc.c | 1535 +++++++++++++++++++++++++++++++--
 drivers/scsi/fnic/fnic.h      |    6 +
 drivers/scsi/fnic/fnic_fdls.h |    2 +-
 3 files changed, 1454 insertions(+), 89 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index a21f103bc9df..d440934f365c 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -32,6 +32,13 @@ static void fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 				   void *rx_frame);
 static void fnic_fdls_start_plogi(struct fnic_iport_s *iport);
 static void fnic_fdls_start_flogi(struct fnic_iport_s *iport);
+static struct fnic_tport_s *fdls_create_tport(struct fnic_iport_s *iport,
+					  uint32_t fcid,
+					  uint64_t wwpn);
+static void fdls_target_restart_nexus(struct fnic_tport_s *tport);
+static void fdls_start_tport_timer(struct fnic_iport_s *iport,
+					struct fnic_tport_s *tport, int timeout);
+static void fdls_tport_timer_callback(struct timer_list *t);
 static void fdls_start_fabric_timer(struct fnic_iport_s *iport,
 			int timeout);
 static void fdls_init_plogi_frame(uint8_t *frame, struct fnic_iport_s *iport);
@@ -382,6 +389,29 @@ fdls_start_fabric_timer(struct fnic_iport_s *iport, int timeout)
 				 "fabric timer is %d ", timeout);
 }
 
+static void
+fdls_start_tport_timer(struct fnic_iport_s *iport,
+					   struct fnic_tport_s *tport, int timeout)
+{
+	u64 fabric_tov;
+	struct fnic *fnic = iport->fnic;
+
+	if (tport->timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "tport fcid 0x%x: Canceling disc timer\n",
+					 tport->fcid);
+		fnic_del_tport_timer_sync(fnic, tport);
+		tport->timer_pending = 0;
+	}
+
+	if (!(tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED))
+		tport->retry_counter++;
+
+	fabric_tov = jiffies + msecs_to_jiffies(timeout);
+	mod_timer(&tport->retry_timer, round_jiffies(fabric_tov));
+	tport->timer_pending = 1;
+}
+
 void fdls_init_plogi_frame(uint8_t *frame,
 		struct fnic_iport_s *iport)
 {
@@ -454,6 +484,52 @@ static void fdls_init_fabric_abts_frame(uint8_t *frame,
 		.fh_parm_offset = 0x00000000,	/* bit:0 = 0 Abort a exchange */
 	};
 }
+void
+fdls_send_tport_abts(struct fnic_iport_s *iport,
+					 struct fnic_tport_s *tport)
+{
+	uint8_t *frame;
+	uint8_t s_id[3];
+	uint8_t d_id[3];
+	struct fnic *fnic = iport->fnic;
+	struct fc_frame_header *ptport_abts;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_frame_header);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"Failed to allocate frame to send tport ABTS");
+		return;
+	}
+
+	ptport_abts = (struct fc_frame_header *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*ptport_abts = (struct fc_frame_header) {
+		.fh_r_ctl = FC_RCTL_BA_ABTS,	/* ABTS */
+		.fh_cs_ctl = 0x00, .fh_type = FC_TYPE_BLS,
+		.fh_f_ctl = {FNIC_REQ_ABTS_FCTL, 0, 0}, .fh_seq_id = 0x00,
+		.fh_df_ctl = 0x00, .fh_seq_cnt = 0x0000,
+		.fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID),
+		.fh_parm_offset = 0x00000000,	/* bit:0 = 0 Abort a exchange */
+	};
+
+	hton24(s_id, iport->fcid);
+	hton24(d_id, tport->fcid);
+	FNIC_STD_SET_S_ID(*ptport_abts, s_id);
+	FNIC_STD_SET_D_ID(*ptport_abts, d_id);
+	tport->flags |= FNIC_FDLS_TGT_ABORT_ISSUED;
+
+	FNIC_STD_SET_OX_ID(*ptport_abts, tport->active_oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send tport abts: tport->state: %d ",
+				 iport->fcid, tport->state);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_tport_timer(iport, tport, 2 * iport->e_d_tov);
+}
 static void fdls_send_fabric_abts(struct fnic_iport_s *iport)
 {
 	uint8_t *frame;
@@ -816,6 +892,196 @@ static void fdls_send_gpn_ft(struct fnic_iport_s *iport, int fdls_state)
 	fdls_set_state((&iport->fabric), fdls_state);
 }
 
+static void
+fdls_send_tgt_adisc(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
+{
+	uint8_t *frame;
+	struct fc_std_els_adisc *padisc;
+	uint8_t s_id[3];
+	uint8_t d_id[3];
+	uint16_t oxid;
+	struct fnic *fnic = iport->fnic;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_els_adisc);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"Failed to allocate frame to send TGT ADISC");
+		tport->flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	padisc = (struct fc_std_els_adisc *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+
+	hton24(s_id, iport->fcid);
+	hton24(d_id, tport->fcid);
+	memcpy(padisc->els.adisc_port_id, s_id, 3);
+	FNIC_STD_SET_S_ID(padisc->fchdr, s_id);
+	FNIC_STD_SET_D_ID(padisc->fchdr, d_id);
+
+	FNIC_STD_SET_F_CTL(padisc->fchdr, FNIC_ELS_REQ_FCTL << 16);
+	FNIC_STD_SET_R_CTL(padisc->fchdr, FC_RCTL_ELS_REQ);
+	FNIC_STD_SET_TYPE(padisc->fchdr, FC_TYPE_ELS);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_ADISC, &tport->active_oxid);
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: Failed to allocate OXID to send TGT ADISC",
+					 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		tport->flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+	FNIC_STD_SET_OX_ID(padisc->fchdr, oxid);
+	FNIC_STD_SET_RX_ID(padisc->fchdr, FNIC_UNASSIGNED_RXID);
+
+	tport->flags &= ~FNIC_FDLS_TGT_ABORT_ISSUED;
+
+	FNIC_STD_SET_NPORT_NAME(&padisc->els.adisc_wwpn,
+				iport->wwpn);
+	FNIC_STD_SET_NODE_NAME(&padisc->els.adisc_wwnn,
+			iport->wwnn);
+
+	padisc->els.adisc_cmd = ELS_ADISC;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send ADISC to tgt fcid: 0x%x",
+				 iport->fcid, tport->fcid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+err_out:
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_tport_timer(iport, tport, 2 * iport->e_d_tov);
+}
+
+bool fdls_delete_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
+{
+	struct fnic_tport_event_s *tport_del_evt;
+	struct fnic *fnic = iport->fnic;
+
+	if ((tport->state == FDLS_TGT_STATE_OFFLINING)
+	    || (tport->state == FDLS_TGT_STATE_OFFLINE)) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "tport fcid 0x%x: tport state is offlining/offline\n",
+			     tport->fcid);
+		return false;
+	}
+
+	fdls_set_tport_state(tport, FDLS_TGT_STATE_OFFLINING);
+	/*
+	 * By setting this flag, the tport will not be seen in a look-up
+	 * in an RSCN. Even if we move to multithreaded model, this tport
+	 * will be destroyed and a new RSCN will have to create a new one
+	 */
+	tport->flags |= FNIC_FDLS_TPORT_TERMINATING;
+
+	if (tport->timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "tport fcid 0x%x: Canceling disc timer\n",
+					 tport->fcid);
+		fnic_del_tport_timer_sync(fnic, tport);
+		tport->timer_pending = 0;
+	}
+
+	if (IS_FNIC_FCP_INITIATOR(fnic)) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+		fnic_rport_exch_reset(iport->fnic, tport->fcid);
+		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+
+		if (tport->flags & FNIC_FDLS_SCSI_REGISTERED) {
+			tport_del_evt =
+				kzalloc(sizeof(struct fnic_tport_event_s), GFP_ATOMIC);
+			if (!tport_del_evt) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Failed to allocate memory for tport fcid: 0x%0x\n",
+					 tport->fcid);
+				return false;
+			}
+			tport_del_evt->event = TGT_EV_RPORT_DEL;
+			tport_del_evt->arg1 = (void *) tport;
+			list_add_tail(&tport_del_evt->links, &fnic->tport_event_list);
+			queue_work(fnic_event_queue, &fnic->tport_work);
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "tport 0x%x not reg with scsi_transport. Freeing locally",
+				 tport->fcid);
+			list_del(&tport->links);
+			kfree(tport);
+		}
+	}
+	return true;
+}
+
+static void
+fdls_send_tgt_plogi(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
+{
+	uint8_t *frame;
+	struct fc_std_flogi *pplogi;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_flogi);
+	uint8_t d_id[3];
+	uint32_t timeout;
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"Failed to allocate frame to send TGT PLOGI");
+		tport->flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	pplogi = (struct fc_std_flogi *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	fdls_init_plogi_frame(frame, iport);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_PLOGI, &tport->active_oxid);
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: Failed to allocate oxid to send PLOGI to fcid: 0x%x",
+				 iport->fcid, tport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		tport->flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+	FNIC_STD_SET_OX_ID(pplogi->fchdr, oxid);
+
+	tport->flags &= ~FNIC_FDLS_TGT_ABORT_ISSUED;
+
+	hton24(d_id, tport->fcid);
+	FNIC_STD_SET_D_ID(pplogi->fchdr, d_id);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS send tgt PLOGI to tgt: 0x%x with oxid: 0x%x",
+				 iport->fcid, tport->fcid, oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+err_out:
+	timeout = max(2 * iport->e_d_tov, iport->plogi_timeout);
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_tport_timer(iport, tport, timeout);
+}
+
+static uint16_t
+fnic_fc_plogi_rsp_rdf(struct fnic_iport_s *iport,
+		      struct fc_std_flogi *plogi_rsp)
+{
+	uint16_t b2b_rdf_size =
+	    be16_to_cpu(FNIC_LOGI_RDF_SIZE(plogi_rsp->els));
+	uint16_t spc3_rdf_size =
+	    be16_to_cpu(plogi_rsp->els.fl_cssp[2].cp_rdfs) & FNIC_FC_C3_RDF;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "MFS: b2b_rdf_size: 0x%x spc3_rdf_size: 0x%x",
+			 b2b_rdf_size, spc3_rdf_size);
+
+	return min(b2b_rdf_size, spc3_rdf_size);
+}
+
 static void fdls_send_register_fc4_types(struct fnic_iport_s *iport)
 {
 	uint8_t *frame;
@@ -940,6 +1206,70 @@ static void fdls_send_register_fc4_features(struct fnic_iport_s *iport)
 	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
 }
 
+static void
+fdls_send_tgt_prli(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
+{
+	uint8_t *frame;
+	struct fc_std_els_prli *pprli;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_els_prli);
+	uint8_t s_id[3];
+	uint8_t d_id[3];
+	uint32_t timeout;
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"Failed to allocate frame to send TGT PRLI");
+		tport->flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	pprli = (struct fc_std_els_prli *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*pprli = (struct fc_std_els_prli) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_ELS_REQ, .fh_type = FC_TYPE_ELS,
+			  .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+			  .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.els_prli = {.prli_cmd = ELS_PRLI,
+			     .prli_spp_len = 16,
+			     .prli_len = cpu_to_be16(0x14)},
+		.sp = {.spp_type = 0x08, .spp_flags = 0x0020,
+		       .spp_params = cpu_to_be32(0xA2)}
+	};
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_PRLI, &tport->active_oxid);
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"0x%x: Failed to allocate OXID to send TGT PRLI to 0x%x",
+			iport->fcid, tport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		tport->flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	tport->flags &= ~FNIC_FDLS_TGT_ABORT_ISSUED;
+
+	hton24(s_id, iport->fcid);
+	hton24(d_id, tport->fcid);
+
+	FNIC_STD_SET_OX_ID(pprli->fchdr, oxid);
+	FNIC_STD_SET_S_ID(pprli->fchdr, s_id);
+	FNIC_STD_SET_D_ID(pprli->fchdr, d_id);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"0x%x: FDLS send PRLI to tgt: 0x%x with oxid: 0x%x",
+			iport->fcid, tport->fcid, oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+err_out:
+	timeout = max(2 * iport->e_d_tov, iport->plogi_timeout);
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_tport_timer(iport, tport, timeout);
+}
+
 /**
  * fdls_send_fabric_logo - Send flogo to the fcf
  * @iport: Handle to fnic iport
@@ -995,36 +1325,253 @@ void fdls_send_fabric_logo(struct fnic_iport_s *iport)
 	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
 }
 
-void fdls_fabric_timer_callback(struct timer_list *t)
+/**
+ * fdls_tgt_logout - Send plogo to the remote port
+ * @iport: Handle to fnic iport
+ * @tport: Handle to remote port
+ *
+ * This function does not change or check the fabric/tport state.
+ * It the caller's responsibility to set the appropriate tport/fabric
+ * state when this is called. Normally that is fdls_tgt_state_plogo.
+ * This could be used to send plogo to nameserver process
+ * also not just target processes
+ */
+void fdls_tgt_logout(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 {
-	struct fnic_fdls_fabric_s *fabric = from_timer(fabric, t, retry_timer);
-	struct fnic_iport_s *iport =
-		container_of(fabric, struct fnic_iport_s, fabric);
+	uint8_t *frame;
+	struct fc_std_logo *plogo;
 	struct fnic *fnic = iport->fnic;
-	unsigned long flags;
+	uint8_t d_id[3];
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_logo);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send fabric LOGO");
+		return;
+	}
+
+	plogo = (struct fc_std_logo *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	fdls_init_logo_frame(frame, iport);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_LOGO, &tport->active_oxid);
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send tgt LOGO",
+		     iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		return;
+	}
+	FNIC_STD_SET_OX_ID(plogo->fchdr, oxid);
+
+	hton24(d_id, tport->fcid);
+	FNIC_STD_SET_D_ID(plogo->fchdr, d_id);
 
 	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-		 "tp: %d fab state: %d fab retry counter: %d max_flogi_retries: %d",
-		 iport->fabric.timer_pending, iport->fabric.state,
-		 iport->fabric.retry_counter, iport->max_flogi_retries);
+		 "0x%x: FDLS send tgt LOGO with oxid: 0x%x",
+		 iport->fcid, oxid);
 
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+}
 
-	if (!iport->fabric.timer_pending) {
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+static void fdls_tgt_discovery_start(struct fnic_iport_s *iport)
+{
+	struct fnic_tport_s *tport, *next;
+	u32 old_link_down_cnt = iport->fnic->link_down_cnt;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: Starting FDLS target discovery", iport->fcid);
+
+	list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
+		if ((old_link_down_cnt != iport->fnic->link_down_cnt)
+			|| (iport->state != FNIC_IPORT_STATE_READY)) {
+			break;
+		}
+		/* if we marked the tport as deleted due to GPN_FT
+		 * We should not send ADISC anymore
+		 */
+		if ((tport->state == FDLS_TGT_STATE_OFFLINING) ||
+			(tport->state == FDLS_TGT_STATE_OFFLINE))
+			continue;
+
+		/* For tports which have received RSCN */
+		if (tport->flags & FNIC_FDLS_TPORT_SEND_ADISC) {
+			tport->retry_counter = 0;
+			fdls_set_tport_state(tport, FDLS_TGT_STATE_ADISC);
+			tport->flags &= ~FNIC_FDLS_TPORT_SEND_ADISC;
+			fdls_send_tgt_adisc(iport, tport);
+			continue;
+		}
+		if (fdls_get_tport_state(tport) != FDLS_TGT_STATE_INIT) {
+			/* Not a new port, skip  */
+			continue;
+		}
+		tport->retry_counter = 0;
+		fdls_set_tport_state(tport, FDLS_TGT_STATE_PLOGI);
+		fdls_send_tgt_plogi(iport, tport);
+	}
+	fdls_set_state((&iport->fabric), FDLS_STATE_TGT_DISCOVERY);
+}
+
+/*
+ * Function to restart the IT nexus if we received any out of
+ * sequence PLOGI/PRLI  response from the target.
+ * The memory for the new tport structure is allocated
+ * inside fdls_create_tport and added to the iport's tport list.
+ * This will get freed later during tport_offline/linkdown
+ * or module unload. The new_tport pointer will go out of scope
+ * safely since the memory it is
+ * pointing to it will be freed later
+ */
+static void fdls_target_restart_nexus(struct fnic_tport_s *tport)
+{
+	struct fnic_iport_s *iport = tport->iport;
+	struct fnic_tport_s *new_tport = NULL;
+	uint32_t fcid;
+	uint64_t wwpn;
+	int nexus_restart_count;
+	struct fnic *fnic = iport->fnic;
+	bool retval = true;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "tport fcid: 0x%x state: %d restart_count: %d",
+				 tport->fcid, tport->state, tport->nexus_restart_count);
+
+	fcid = tport->fcid;
+	wwpn = tport->wwpn;
+	nexus_restart_count = tport->nexus_restart_count;
+
+	retval = fdls_delete_tport(iport, tport);
+	if (retval != true) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			     "Error deleting tport: 0x%x", fcid);
 		return;
 	}
 
-	if (iport->fabric.del_timer_inprogress) {
-		iport->fabric.del_timer_inprogress = 0;
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	if (nexus_restart_count >= FNIC_TPORT_MAX_NEXUS_RESTART) {
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-					 "fabric_del_timer inprogress(%d). Skip timer cb",
-					 iport->fabric.del_timer_inprogress);
+			     "Exceeded nexus restart retries tport: 0x%x",
+			     fcid);
 		return;
 	}
 
-	iport->fabric.timer_pending = 0;
+	/*
+	 * Allocate memory for the new tport and add it to
+	 * iport's tport list.
+	 * This memory will be freed during tport_offline/linkdown
+	 * or module unload. The pointer new_tport is safe to go
+	 * out of scope when this function returns, since the memory
+	 * it is pointing to is guaranteed to be freed later
+	 * as mentioned above.
+	 */
+	new_tport = fdls_create_tport(iport, fcid, wwpn);
+	if (!new_tport) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Error creating new tport: 0x%x", fcid);
+		return;
+	}
+
+	new_tport->nexus_restart_count = nexus_restart_count + 1;
+	fdls_send_tgt_plogi(iport, new_tport);
+	fdls_set_tport_state(new_tport, FDLS_TGT_STATE_PLOGI);
+}
+
+struct fnic_tport_s *fnic_find_tport_by_fcid(struct fnic_iport_s *iport,
+									 uint32_t fcid)
+{
+	struct fnic_tport_s *tport, *next;
+
+	list_for_each_entry_safe(tport, next, &(iport->tport_list), links) {
+		if ((tport->fcid == fcid)
+			&& !(tport->flags & FNIC_FDLS_TPORT_TERMINATING))
+			return tport;
+	}
+	return NULL;
+}
+
+static struct fnic_tport_s *fdls_create_tport(struct fnic_iport_s *iport,
+								  uint32_t fcid, uint64_t wwpn)
+{
+	struct fnic_tport_s *tport;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "FDLS create tport: fcid: 0x%x wwpn: 0x%llx", fcid, wwpn);
+
+	tport = kzalloc(sizeof(struct fnic_tport_s), GFP_ATOMIC);
+	if (!tport) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Memory allocation failure while creating tport: 0x%x\n",
+			 fcid);
+		return NULL;
+	}
+
+	tport->max_payload_size = FNIC_FCOE_MAX_FRAME_SZ;
+	tport->r_a_tov = FC_DEF_R_A_TOV;
+	tport->e_d_tov = FC_DEF_E_D_TOV;
+	tport->fcid = fcid;
+	tport->wwpn = wwpn;
+	tport->iport = iport;
+
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+				 "Need to setup tport timer callback");
+
+	timer_setup(&tport->retry_timer, fdls_tport_timer_callback, 0);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Added tport 0x%x", tport->fcid);
+	fdls_set_tport_state(tport, FDLS_TGT_STATE_INIT);
+	list_add_tail(&tport->links, &iport->tport_list);
+	atomic_set(&tport->in_flight, 0);
+	return tport;
+}
+
+struct fnic_tport_s *fnic_find_tport_by_wwpn(struct fnic_iport_s *iport,
+									 uint64_t wwpn)
+{
+	struct fnic_tport_s *tport, *next;
+
+	list_for_each_entry_safe(tport, next, &(iport->tport_list), links) {
+		if ((tport->wwpn == wwpn)
+			&& !(tport->flags & FNIC_FDLS_TPORT_TERMINATING))
+			return tport;
+	}
+	return NULL;
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
 
 	/* The fabric state indicates which frames have time out, and we retry */
 	switch (iport->fabric.state) {
@@ -1100,89 +1647,571 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 			/* ABTS has timed out */
 			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-						 "ABTS timed out. Starting PLOGI: %p", iport);
-			fnic_fdls_start_plogi(iport);
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
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			/* RFT_ID timed out send abts */
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
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
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+			/* SCR has timed out. Send abts */
+			fdls_send_fabric_abts(iport);
+		else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
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
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			/* gpn_ft has timed out. Send abts */
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
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
+		fnic_fdls_start_flogi(iport);	/* Placeholder call */
+		break;
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+}
+
+static void fdls_send_delete_tport_msg(struct fnic_tport_s *tport)
+{
+	struct fnic_iport_s *iport = (struct fnic_iport_s *) tport->iport;
+	struct fnic *fnic = iport->fnic;
+	struct fnic_tport_event_s *tport_del_evt;
+
+	if (!IS_FNIC_FCP_INITIATOR(fnic))
+		return;
+
+	tport_del_evt = kzalloc(sizeof(struct fnic_tport_event_s), GFP_ATOMIC);
+	if (!tport_del_evt) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Failed to allocate memory for tport event fcid: 0x%x",
+			 tport->fcid);
+		return;
+	}
+	tport_del_evt->event = TGT_EV_TPORT_DELETE;
+	tport_del_evt->arg1 = (void *) tport;
+	list_add_tail(&tport_del_evt->links, &fnic->tport_event_list);
+	queue_work(fnic_event_queue, &fnic->tport_work);
+}
+
+static void fdls_tport_timer_callback(struct timer_list *t)
+{
+	struct fnic_tport_s *tport = from_timer(tport, t, retry_timer);
+	struct fnic_iport_s *iport = (struct fnic_iport_s *) tport->iport;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	if (!tport->timer_pending) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		return;
+	}
+
+	if (iport->state != FNIC_IPORT_STATE_READY) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		return;
+	}
+
+	if (tport->del_timer_inprogress) {
+		tport->del_timer_inprogress = 0;
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "tport_del_timer inprogress. Skip timer cb tport fcid: 0x%x\n",
+			 tport->fcid);
+		return;
+	}
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "tport fcid: 0x%x timer pending: %d state: %d retry counter: %d",
+		 tport->fcid, tport->timer_pending, tport->state,
+		 tport->retry_counter);
+
+	tport->timer_pending = 0;
+	oxid = tport->active_oxid;
+
+	/* We retry plogi/prli/adisc frames depending on the tport state */
+	switch (tport->state) {
+	case FDLS_TGT_STATE_PLOGI:
+		/* PLOGI frame received a LS_RJT with busy, we retry from here */
+		if ((tport->flags & FNIC_FDLS_RETRY_FRAME)
+			&& (tport->retry_counter < iport->max_plogi_retries)) {
+			tport->flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_tgt_plogi(iport, tport);
+		} else if (!(tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
+			/* Plogi frame has timed out, send abts */
+			fdls_send_tport_abts(iport, tport);
+		} else if (tport->retry_counter < iport->max_plogi_retries) {
+			/*
+			 * ABTS has timed out
+			 */
+			fdls_schedule_oxid_free(iport, &tport->active_oxid);
+			fdls_send_tgt_plogi(iport, tport);
+		} else {
+			/* exceeded plogi retry count */
+			fdls_schedule_oxid_free(iport, &tport->active_oxid);
+			fdls_send_delete_tport_msg(tport);
+		}
+		break;
+	case FDLS_TGT_STATE_PRLI:
+		/* PRLI received a LS_RJT with busy , hence we retry from here */
+		if ((tport->flags & FNIC_FDLS_RETRY_FRAME)
+			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
+			tport->flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_tgt_prli(iport, tport);
+		} else if (!(tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
+			/* PRLI has time out, send abts */
+			fdls_send_tport_abts(iport, tport);
+		} else {
+			/* ABTS has timed out for prli, we go back to PLOGI */
+			fdls_schedule_oxid_free(iport, &tport->active_oxid);
+			fdls_send_tgt_plogi(iport, tport);
+			fdls_set_tport_state(tport, FDLS_TGT_STATE_PLOGI);
+		}
+		break;
+	case FDLS_TGT_STATE_ADISC:
+		/* ADISC timed out send an ABTS */
+		if (!(tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
+			fdls_send_tport_abts(iport, tport);
+		} else if ((tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)
+				   && (tport->retry_counter < FDLS_RETRY_COUNT)) {
+			/*
+			 * ABTS has timed out
+			 */
+			fdls_schedule_oxid_free(iport, &tport->active_oxid);
+			fdls_send_tgt_adisc(iport, tport);
+		} else {
+			/* exceeded retry count */
+			fdls_schedule_oxid_free(iport, &tport->active_oxid);
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "ADISC not responding. Deleting target port: 0x%x",
+					 tport->fcid);
+			fdls_send_delete_tport_msg(tport);
+		}
+		break;
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Unknown tport state: 0x%x", tport->state);
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
+static void
+fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
+			   struct fc_frame_header *fchdr)
+{
+	uint32_t tgt_fcid;
+	struct fnic_tport_s *tport;
+	uint8_t *fcid;
+	uint64_t frame_wwnn;
+	uint64_t frame_wwpn;
+	uint16_t oxid;
+	struct fc_std_els_adisc *adisc_rsp = (struct fc_std_els_adisc *)fchdr;
+	struct fc_std_els_rjt_rsp *els_rjt = (struct fc_std_els_rjt_rsp *)fchdr;
+	struct fnic *fnic = iport->fnic;
+
+	fcid = FNIC_STD_GET_S_ID(fchdr);
+	tgt_fcid = ntoh24(fcid);
+	tport = fnic_find_tport_by_fcid(iport, tgt_fcid);
+
+	if (!tport) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Tgt ADISC response tport not found: 0x%x", tgt_fcid);
+		return;
+	}
+	if ((iport->state != FNIC_IPORT_STATE_READY)
+		|| (tport->state != FDLS_TGT_STATE_ADISC)
+		|| (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Dropping this ADISC response");
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "iport state: %d tport state: %d Is abort issued on PRLI? %d",
+			 iport->state, tport->state,
+			 (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED));
+		return;
+	}
+	if (FNIC_STD_GET_OX_ID(fchdr) != tport->active_oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Dropping frame from target: 0x%x",
+			 tgt_fcid);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Reason: Stale ADISC/Aborted ADISC/OOO frame delivery");
+		return;
+	}
+
+	oxid = FNIC_STD_GET_OX_ID(fchdr);
+	fdls_free_oxid(iport, oxid, &tport->active_oxid);
+
+	switch (adisc_rsp->els.adisc_cmd) {
+	case ELS_LS_ACC:
+		if (tport->timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "tport 0x%p Canceling fabric disc timer\n",
+						 tport);
+			fnic_del_tport_timer_sync(fnic, tport);
+		}
+		tport->timer_pending = 0;
+		tport->retry_counter = 0;
+		frame_wwnn = get_unaligned_be64(&adisc_rsp->els.adisc_wwnn);
+		frame_wwpn = get_unaligned_be64(&adisc_rsp->els.adisc_wwpn);
+		if ((frame_wwnn == tport->wwnn) && (frame_wwpn == tport->wwpn)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "ADISC accepted from target: 0x%x. Target logged in",
+				 tgt_fcid);
+			fdls_set_tport_state(tport, FDLS_TGT_STATE_READY);
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Error mismatch frame: ADISC");
+		}
+		break;
+
+	case ELS_LS_RJT:
+		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
+		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
+			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "ADISC ret ELS_LS_RJT BUSY. Retry from timer routine: 0x%x",
+				 tgt_fcid);
+
+			/* Retry ADISC again from the timer routine. */
+			tport->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "ADISC returned ELS_LS_RJT from target: 0x%x",
+						 tgt_fcid);
+			fdls_delete_tport(iport, tport);
+		}
+		break;
+	}
+}
+static void
+fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
+			   struct fc_frame_header *fchdr)
+{
+	uint32_t tgt_fcid;
+	struct fnic_tport_s *tport;
+	uint8_t *fcid;
+	uint16_t oxid;
+	struct fc_std_flogi *plogi_rsp = (struct fc_std_flogi *)fchdr;
+	struct fc_std_els_rjt_rsp *els_rjt = (struct fc_std_els_rjt_rsp *)fchdr;
+	uint16_t max_payload_size;
+	struct fnic *fnic = iport->fnic;
+
+	fcid = FNIC_STD_GET_S_ID(fchdr);
+	tgt_fcid = ntoh24(fcid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FDLS processing target PLOGI response: tgt_fcid: 0x%x",
+				 tgt_fcid);
+
+	tport = fnic_find_tport_by_fcid(iport, tgt_fcid);
+	if (!tport) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "tport not found: 0x%x", tgt_fcid);
+		return;
+	}
+	if ((iport->state != FNIC_IPORT_STATE_READY)
+		|| (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Dropping frame! iport state: %d tport state: %d",
+					 iport->state, tport->state);
+		return;
+	}
+
+	if (tport->state != FDLS_TGT_STATE_PLOGI) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "PLOGI rsp recvd in wrong state. Drop the frame and restart nexus");
+		fdls_target_restart_nexus(tport);
+		return;
+	}
+
+	if (FNIC_STD_GET_OX_ID(fchdr) != tport->active_oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "PLOGI response from target: 0x%x. Dropping frame",
+			 tgt_fcid);
+		return;
+	}
+
+	oxid = FNIC_STD_GET_OX_ID(fchdr);
+	fdls_free_oxid(iport, oxid, &tport->active_oxid);
+
+	switch (plogi_rsp->els.fl_cmd) {
+	case ELS_LS_ACC:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PLOGI accepted by target: 0x%x", tgt_fcid);
+		break;
+
+	case ELS_LS_RJT:
+		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
+		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
+			&& (tport->retry_counter < iport->max_plogi_retries)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "PLOGI ret ELS_LS_RJT BUSY. Retry from timer routine: 0x%x",
+				 tgt_fcid);
+			/* Retry plogi again from the timer routine. */
+			tport->flags |= FNIC_FDLS_RETRY_FRAME;
+			return;
+		}
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PLOGI returned ELS_LS_RJT from target: 0x%x",
+					 tgt_fcid);
+		fdls_delete_tport(iport, tport);
+		return;
+
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PLOGI not accepted from target fcid: 0x%x",
+					 tgt_fcid);
+		return;
+	}
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Found the PLOGI target: 0x%x and state: %d",
+				 (unsigned int) tgt_fcid, tport->state);
+
+	if (tport->timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "tport fcid 0x%x: Canceling disc timer\n",
+					 tport->fcid);
+		fnic_del_tport_timer_sync(fnic, tport);
+	}
+
+	tport->timer_pending = 0;
+	tport->wwpn = get_unaligned_be64(&FNIC_LOGI_PORT_NAME(plogi_rsp->els));
+	tport->wwnn = get_unaligned_be64(&FNIC_LOGI_NODE_NAME(plogi_rsp->els));
+
+	/* Learn the Service Params */
+
+	/* Max frame size - choose the lowest */
+	max_payload_size = fnic_fc_plogi_rsp_rdf(iport, plogi_rsp);
+	tport->max_payload_size =
+		min(max_payload_size, iport->max_payload_size);
+
+	if (tport->max_payload_size < FNIC_MIN_DATA_FIELD_SIZE) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "MFS: tport max frame size below spec bounds: %d",
+			 tport->max_payload_size);
+		tport->max_payload_size = FNIC_MIN_DATA_FIELD_SIZE;
+	}
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "MAX frame size: %u iport max_payload_size: %d tport mfs: %d",
+		 max_payload_size, iport->max_payload_size,
+		 tport->max_payload_size);
+
+	tport->max_concur_seqs = FNIC_FC_PLOGI_RSP_CONCUR_SEQ(plogi_rsp);
+
+	tport->retry_counter = 0;
+	fdls_set_tport_state(tport, FDLS_TGT_STATE_PRLI);
+	fdls_send_tgt_prli(iport, tport);
+}
+static void
+fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
+			  struct fc_frame_header *fchdr)
+{
+	uint32_t tgt_fcid;
+	struct fnic_tport_s *tport;
+	uint8_t *fcid;
+	uint16_t oxid;
+	struct fc_std_els_prli *prli_rsp = (struct fc_std_els_prli *)fchdr;
+	struct fc_std_els_rjt_rsp *els_rjt = (struct fc_std_els_rjt_rsp *)fchdr;
+	struct fnic_tport_event_s *tport_add_evt;
+	struct fnic *fnic = iport->fnic;
+	bool mismatched_tgt = false;
+
+	fcid = FNIC_STD_GET_S_ID(fchdr);
+	tgt_fcid = ntoh24(fcid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FDLS process tgt PRLI response: 0x%x", tgt_fcid);
+
+	tport = fnic_find_tport_by_fcid(iport, tgt_fcid);
+	if (!tport) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "tport not found: 0x%x", tgt_fcid);
+		/* Handle or just drop? */
+		return;
+	}
+
+	if ((iport->state != FNIC_IPORT_STATE_READY)
+		|| (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Dropping frame! iport st: %d tport st: %d tport fcid: 0x%x",
+			 iport->state, tport->state, tport->fcid);
+		return;
+	}
+
+	if (tport->state != FDLS_TGT_STATE_PRLI) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "PRLI rsp recvd in wrong state. Drop frame. Restarting nexus");
+		fdls_target_restart_nexus(tport);
+		return;
+	}
+
+	if (FNIC_STD_GET_OX_ID(fchdr) != tport->active_oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Dropping PRLI response from target: 0x%x ",
+			 tgt_fcid);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Reason: Stale PRLI response/Aborted PDISC/OOO frame delivery");
+		return;
+	}
+
+	oxid = FNIC_STD_GET_OX_ID(fchdr);
+	fdls_free_oxid(iport, oxid, &tport->active_oxid);
+
+	switch (prli_rsp->els_prli.prli_cmd) {
+	case ELS_LS_ACC:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PRLI accepted from target: 0x%x", tgt_fcid);
+
+		if (prli_rsp->sp.spp_type != FC_FC4_TYPE_SCSI) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "mismatched target zoned with FC SCSI initiator: 0x%x",
+				 tgt_fcid);
+			mismatched_tgt = true;
 		}
-		break;
-	case FDLS_STATE_REGISTER_FC4_TYPES:
-		/* scr received a LS_RJT with busy we retry from here */
-		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
-			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
-			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
-			fdls_send_register_fc4_types(iport);
-		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
-			/* RFT_ID timed out send abts */
-			fdls_send_fabric_abts(iport);
-		} else {
-			/* ABTS has timed out */
-			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-						 "ABTS timed out. Starting PLOGI: %p", iport);
-			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		if (mismatched_tgt) {
+			fdls_tgt_logout(iport, tport);
+			fdls_delete_tport(iport, tport);
+			return;
 		}
 		break;
-	case FDLS_STATE_REGISTER_FC4_FEATURES:
-		/* scr received a LS_RJT with busy we retry from here */
-		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
-			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
-			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
-			fdls_send_register_fc4_features(iport);
-		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
-			/* SCR has timed out. Send abts */
-			fdls_send_fabric_abts(iport);
-		else {
-			/* ABTS has timed out */
-			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+	case ELS_LS_RJT:
+		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
+		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
+			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
+
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-						 "ABTS timed out. Starting PLOGI %p", iport);
-			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
-		}
-		break;
-	case FDLS_STATE_RSCN_GPN_FT:
-	case FDLS_STATE_SEND_GPNFT:
-	case FDLS_STATE_GPN_FT:
-		/* GPN_FT received a LS_RJT with busy we retry from here */
-		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
-			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
-			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
-			fdls_send_gpn_ft(iport, iport->fabric.state);
-		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
-			/* gpn_ft has timed out. Send abts */
-			fdls_send_fabric_abts(iport);
+				 "PRLI ret ELS_LS_RJT BUSY. Retry from timer routine: 0x%x",
+				 tgt_fcid);
+
+			/*Retry Plogi again from the timer routine. */
+			tport->flags |= FNIC_FDLS_RETRY_FRAME;
+			return;
 		} else {
-			/* ABTS has timed out */
-			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
-			if (iport->fabric.retry_counter < FDLS_RETRY_COUNT) {
-				fdls_send_gpn_ft(iport, iport->fabric.state);
-			} else {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-					 "ABTS timeout for fabric GPN_FT. Check name server: %p",
-					 iport);
-			}
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "PRLI returned ELS_LS_RJT from target: 0x%x",
+						 tgt_fcid);
+
+			fdls_tgt_logout(iport, tport);
+			fdls_delete_tport(iport, tport);
+			return;
 		}
 		break;
+
 	default:
-		fnic_fdls_start_flogi(iport);	/* Placeholder call */
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PRLI not accepted from target: 0x%x", tgt_fcid);
+		return;
 		break;
 	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-}
 
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Found the PRLI target: 0x%x and state: %d",
+				 (unsigned int) tgt_fcid, tport->state);
+
+	if (tport->timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "tport fcid 0x%x: Canceling disc timer\n",
+					 tport->fcid);
+		fnic_del_tport_timer_sync(fnic, tport);
+	}
+	tport->timer_pending = 0;
 
-static void fnic_fdls_start_flogi(struct fnic_iport_s *iport)
-{
-	iport->fabric.retry_counter = 0;
-	fdls_send_fabric_flogi(iport);
-	fdls_set_state((&iport->fabric), FDLS_STATE_FABRIC_FLOGI);
-	iport->fabric.flags = 0;
-}
+	/* Learn Service Params */
+	tport->fcp_csp = be32_to_cpu(prli_rsp->sp.spp_params);
+	tport->retry_counter = 0;
 
-static void fnic_fdls_start_plogi(struct fnic_iport_s *iport)
-{
-	iport->fabric.retry_counter = 0;
-	fdls_send_fabric_plogi(iport);
-	fdls_set_state((&iport->fabric), FDLS_STATE_FABRIC_PLOGI);
-	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+	if (tport->fcp_csp & FCP_SPPF_RETRY)
+		tport->tgt_flags |= FNIC_FC_RP_FLAGS_RETRY;
+
+	/* Check if the device plays Target Mode Function */
+	if (!(tport->fcp_csp & FCP_PRLI_FUNC_TARGET)) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Remote port(0x%x): no target support. Deleting it\n",
+			 tgt_fcid);
+		fdls_tgt_logout(iport, tport);
+		fdls_delete_tport(iport, tport);
+		return;
+	}
+
+	fdls_set_tport_state(tport, FDLS_TGT_STATE_READY);
+
+	/* Inform the driver about new target added */
+	tport_add_evt = kzalloc(sizeof(struct fnic_tport_event_s), GFP_ATOMIC);
+	if (!tport_add_evt) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "tport event memory allocation failure: 0x%0x\n",
+				 tport->fcid);
+		return;
+	}
+	tport_add_evt->event = TGT_EV_RPORT_ADD;
+	tport_add_evt->arg1 = (void *) tport;
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "iport fcid: 0x%x add tport event fcid: 0x%x\n",
+			 tport->fcid, iport->fcid);
+	list_add_tail(&tport_add_evt->links, &fnic->tport_event_list);
+	queue_work(fnic_event_queue, &fnic->tport_work);
 }
 
 
@@ -1460,7 +2489,8 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 						 iport);
 			if (iport->fabric.timer_pending) {
 				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-							 "Canceling fabric disc timer %p\n", iport);
+					     "Canceling fabric disc timer %p\n",
+					     iport);
 				fnic_del_fabric_timer_sync(fnic);
 			}
 			fdls->timer_pending = 0;
@@ -1473,7 +2503,103 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 	}
 }
 
+static void
+fdls_process_gpn_ft_tgt_list(struct fnic_iport_s *iport,
+			     struct fc_frame_header *fchdr, int len)
+{
+	struct fc_gpn_ft_rsp_iu *gpn_ft_tgt;
+	struct fnic_tport_s *tport, *next;
+	uint32_t fcid;
+	uint64_t wwpn;
+	int rem_len = len;
+	u32 old_link_down_cnt = iport->fnic->link_down_cnt;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS process GPN_FT tgt list", iport->fcid);
+
+	gpn_ft_tgt =
+	    (struct fc_gpn_ft_rsp_iu *)((uint8_t *) fchdr +
+					sizeof(struct fc_frame_header)
+					+ sizeof(struct fc_ct_hdr));
+	len -= sizeof(struct fc_frame_header) + sizeof(struct fc_ct_hdr);
+
+	while (rem_len > 0) {
+
+		fcid = ntoh24(gpn_ft_tgt->fcid);
+		wwpn = be64_to_cpu(gpn_ft_tgt->wwpn);
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "tport: 0x%x: ctrl:0x%x", fcid, gpn_ft_tgt->ctrl);
+
+		if (fcid == iport->fcid) {
+			if (gpn_ft_tgt->ctrl & FC_NS_FID_LAST)
+				break;
+			gpn_ft_tgt++;
+			rem_len -= sizeof(struct fc_gpn_ft_rsp_iu);
+			continue;
+		}
+
+		tport = fnic_find_tport_by_wwpn(iport, wwpn);
+		if (!tport) {
+			/*
+			 * New port registered with the switch or first time query
+			 */
+			tport = fdls_create_tport(iport, fcid, wwpn);
+			if (!tport)
+				return;
+		}
+		/*
+		 * check if this was an existing tport with same fcid
+		 * but whose wwpn has changed now ,then remove it and
+		 * create a new one
+		 */
+		if (tport->fcid != fcid) {
+			fdls_delete_tport(iport, tport);
+			tport = fdls_create_tport(iport, fcid, wwpn);
+			if (!tport)
+				return;
+		}
+
+		/*
+		 * If this GPN_FT rsp is after RSCN then mark the tports which
+		 * matches with the new GPN_FT list, if some tport is not
+		 * found in GPN_FT we went to delete that tport later.
+		 */
+		if (fdls_get_state((&iport->fabric)) == FDLS_STATE_RSCN_GPN_FT)
+			tport->flags |= FNIC_FDLS_TPORT_IN_GPN_FT_LIST;
+
+		if (gpn_ft_tgt->ctrl & FC_NS_FID_LAST)
+			break;
+
+		gpn_ft_tgt++;
+		rem_len -= sizeof(struct fc_gpn_ft_rsp_iu);
+	}
+	if (rem_len <= 0) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "GPN_FT response: malformed/corrupt frame rxlen: %d remlen: %d",
+			 len, rem_len);
+}
+
+	/*remove those ports which was not listed in GPN_FT */
+	if (fdls_get_state((&iport->fabric)) == FDLS_STATE_RSCN_GPN_FT) {
+		list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
 
+			if (!(tport->flags & FNIC_FDLS_TPORT_IN_GPN_FT_LIST)) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Remove port: 0x%x not found in GPN_FT list",
+					 tport->fcid);
+				fdls_delete_tport(iport, tport);
+			} else {
+				tport->flags &= ~FNIC_FDLS_TPORT_IN_GPN_FT_LIST;
+			}
+			if ((old_link_down_cnt != iport->fnic->link_down_cnt)
+				|| (iport->state != FNIC_IPORT_STATE_READY)) {
+				return;
+			}
+		}
+	}
+}
 
 static void
 fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
@@ -1483,6 +2609,9 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 	struct fc_std_gpn_ft *gpn_ft_rsp = (struct fc_std_gpn_ft *) fchdr;
 	uint16_t rsp;
 	uint8_t reason_code;
+	int count = 0;
+	struct fnic_tport_s *tport, *next;
+	u32 old_link_down_cnt = iport->fnic->link_down_cnt;
 	struct fnic *fnic = iport->fnic;
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
@@ -1528,12 +2657,74 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 	case FC_FS_ACC:
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "0x%x: GPNFT_RSP accept", iport->fcid);
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "0x%x: Canceling fabric disc timer\n",
+						 iport->fcid);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		iport->fabric.retry_counter = 0;
+		fdls_process_gpn_ft_tgt_list(iport, fchdr, len);
+
+		/*
+		 * iport state can change only if link down event happened
+		 * We don't need to undo fdls_process_gpn_ft_tgt_list,
+		 * that will be taken care in next link up event
+		 */
+		if (iport->state != FNIC_IPORT_STATE_READY) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Halting target discovery: fab st: %d iport st: %d ",
+				 fdls_get_state(fdls), iport->state);
+			break;
+		}
+		fdls_tgt_discovery_start(iport);
 		break;
 
 	case FC_FS_RJT:
 		reason_code = gpn_ft_rsp->fc_std_ct_hdr.ct_reason;
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			 "0x%x: GPNFT_RSP Reject reason: %d", iport->fcid, reason_code);
+
+		if (((reason_code == FC_FS_RJT_BSY)
+		     || (reason_code == FC_FS_RJT_UNABL))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: GPNFT_RSP ret REJ/BSY. Retry from timer routine",
+				 iport->fcid);
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "0x%x: GPNFT_RSP reject", iport->fcid);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "0x%x: Canceling fabric disc timer\n",
+							 iport->fcid);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			iport->fabric.timer_pending = 0;
+			iport->fabric.retry_counter = 0;
+			/*
+			 * If GPN_FT ls_rjt then we should delete
+			 * all existing tports
+			 */
+			count = 0;
+			list_for_each_entry_safe(tport, next, &iport->tport_list,
+									 links) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "GPN_FT_REJECT: Remove port: 0x%x",
+							 tport->fcid);
+				fdls_delete_tport(iport, tport);
+				if ((old_link_down_cnt != iport->fnic->link_down_cnt)
+					|| (iport->state != FNIC_IPORT_STATE_READY)) {
+					return;
+				}
+				count++;
+			}
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "GPN_FT_REJECT: Removed (0x%x) ports", count);
+		}
 		break;
 
 	default:
@@ -1927,6 +3118,142 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 	}
 }
 
+static void
+fdls_process_tgt_abts_rsp(struct fnic_iport_s *iport,
+			  struct fc_frame_header *fchdr)
+{
+	uint32_t s_id;
+	struct fnic_tport_s *tport;
+	uint32_t tport_state;
+	struct fc_std_abts_ba_acc *ba_acc;
+	struct fc_std_abts_ba_rjt *ba_rjt;
+	uint16_t oxid;
+	struct fnic *fnic = iport->fnic;
+	int frame_type;
+
+	s_id = ntoh24(fchdr->fh_s_id);
+	ba_acc = (struct fc_std_abts_ba_acc *)fchdr;
+	ba_rjt = (struct fc_std_abts_ba_rjt *)fchdr;
+
+	tport = fnic_find_tport_by_fcid(iport, s_id);
+	if (!tport) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+					 "Received tgt abts rsp with invalid SID: 0x%x", s_id);
+		return;
+	}
+	if (tport->timer_pending) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+					 "tport 0x%p Canceling fabric disc timer\n", tport);
+		fnic_del_tport_timer_sync(fnic, tport);
+	}
+	if (iport->state != FNIC_IPORT_STATE_READY) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+					 "Received tgt abts rsp in iport state(%d). Dropping.",
+					 iport->state);
+		return;
+	}
+	tport->timer_pending = 0;
+	tport->flags &= ~FNIC_FDLS_TGT_ABORT_ISSUED;
+	tport_state = tport->state;
+	oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	/*This abort rsp is for ADISC */
+	frame_type = FNIC_FRAME_TYPE(oxid);
+	switch (frame_type) {
+	case FNIC_FRAME_TYPE_TGT_ADISC:
+		if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
+			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				     "OX_ID: 0x%x tgt_fcid: 0x%x rcvd tgt adisc abts resp BA_ACC",
+				     be16_to_cpu(ba_acc->acc.ba_ox_id),
+				     tport->fcid);
+		} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
+			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				 "ADISC BA_RJT rcvd tport_fcid: 0x%x tport_state: %d ",
+				 tport->fcid, tport_state);
+			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				 "reason code: 0x%x reason code explanation:0x%x ",
+				     ba_rjt->rjt.br_reason,
+				     ba_rjt->rjt.br_explan);
+		}
+		if ((tport->retry_counter < FDLS_RETRY_COUNT)
+		    && (fchdr->fh_r_ctl == FC_RCTL_BA_ACC)) {
+			fdls_free_oxid(iport, oxid, &tport->active_oxid);
+			fdls_send_tgt_adisc(iport, tport);
+			return;
+		}
+		fdls_free_oxid(iport, oxid, &tport->active_oxid);
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+					 "ADISC not responding. Deleting target port: 0x%x",
+					 tport->fcid);
+		fdls_delete_tport(iport, tport);
+		/* Restart discovery of targets */
+		if ((iport->state == FNIC_IPORT_STATE_READY)
+			&& (iport->fabric.state != FDLS_STATE_SEND_GPNFT)
+			&& (iport->fabric.state != FDLS_STATE_RSCN_GPN_FT)) {
+			fdls_send_gpn_ft(iport, FDLS_STATE_SEND_GPNFT);
+		}
+		break;
+	case FNIC_FRAME_TYPE_TGT_PLOGI:
+		if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
+			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				 "Received tgt PLOGI abts response BA_ACC tgt_fcid: 0x%x",
+				 tport->fcid);
+		} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "PLOGI BA_RJT received for tport_fcid: 0x%x OX_ID: 0x%x",
+				     tport->fcid, FNIC_STD_GET_OX_ID(fchdr));
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "reason code: 0x%x reason code explanation: 0x%x",
+				     ba_rjt->rjt.br_reason,
+				     ba_rjt->rjt.br_explan);
+		}
+		if ((tport->retry_counter < iport->max_plogi_retries)
+		    && (fchdr->fh_r_ctl == FC_RCTL_BA_ACC)) {
+			fdls_free_oxid(iport, oxid, &tport->active_oxid);
+			fdls_send_tgt_plogi(iport, tport);
+			return;
+		}
+
+		fdls_free_oxid(iport, oxid, &tport->active_oxid);
+		fdls_delete_tport(iport, tport);
+		/* Restart discovery of targets */
+		if ((iport->state == FNIC_IPORT_STATE_READY)
+			&& (iport->fabric.state != FDLS_STATE_SEND_GPNFT)
+			&& (iport->fabric.state != FDLS_STATE_RSCN_GPN_FT)) {
+			fdls_send_gpn_ft(iport, FDLS_STATE_SEND_GPNFT);
+		}
+		break;
+	case FNIC_FRAME_TYPE_TGT_PRLI:
+		if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: Received tgt PRLI abts response BA_ACC",
+				 tport->fcid);
+		} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "PRLI BA_RJT received for tport_fcid: 0x%x OX_ID: 0x%x ",
+				     tport->fcid, FNIC_STD_GET_OX_ID(fchdr));
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "reason code: 0x%x reason code explanation: 0x%x",
+				     ba_rjt->rjt.br_reason,
+				     ba_rjt->rjt.br_explan);
+		}
+		if ((tport->retry_counter < FDLS_RETRY_COUNT)
+		    && (fchdr->fh_r_ctl == FC_RCTL_BA_ACC)) {
+			fdls_free_oxid(iport, oxid, &tport->active_oxid);
+			fdls_send_tgt_prli(iport, tport);
+			return;
+		}
+		fdls_free_oxid(iport, oxid, &tport->active_oxid);
+		fdls_send_tgt_plogi(iport, tport);	/* go back to plogi */
+		fdls_set_tport_state(tport, FDLS_TGT_STATE_PLOGI);
+		break;
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Received ABTS response for unknown frame %p", iport);
+		break;
+	}
+
+}
 /*
  * Performs a validation for all FCOE frames and return the frame type
  */
@@ -2109,6 +3436,20 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 
 	case FNIC_FRAME_TYPE_FABRIC_LOGO:
 		return FNIC_FABRIC_LOGO_RSP;
+	case FNIC_FRAME_TYPE_TGT_PLOGI:
+		return FNIC_TPORT_PLOGI_RSP;
+	case FNIC_FRAME_TYPE_TGT_PRLI:
+		return FNIC_TPORT_PRLI_RSP;
+	case FNIC_FRAME_TYPE_TGT_ADISC:
+		return FNIC_TPORT_ADISC_RSP;
+	case FNIC_FRAME_TYPE_TGT_LOGO:
+		if (!FNIC_FC_FRAME_TYPE_ELS(fchdr)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"Dropping Unknown frame in tport solicited exchange range type: 0x%x.",
+				     fchdr->fh_type);
+			return -1;
+		}
+		return FNIC_TPORT_LOGO_RSP;
 	default:
 		/* Drop the Rx frame and log/stats it */
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
@@ -2164,6 +3505,24 @@ void fnic_fdls_recv_frame(struct fnic_iport_s *iport, void *rx_frame,
 	case FNIC_FABRIC_GPN_FT_RSP:
 		fdls_process_gpn_ft_rsp(iport, fchdr, len);
 		break;
+	case FNIC_TPORT_PLOGI_RSP:
+		fdls_process_tgt_plogi_rsp(iport, fchdr);
+		break;
+	case FNIC_TPORT_PRLI_RSP:
+		fdls_process_tgt_prli_rsp(iport, fchdr);
+		break;
+	case FNIC_TPORT_ADISC_RSP:
+		fdls_process_tgt_adisc_rsp(iport, fchdr);
+		break;
+	case FNIC_TPORT_BLS_ABTS_RSP:
+		fdls_process_tgt_abts_rsp(iport, fchdr);
+		break;
+	case FNIC_TPORT_LOGO_RSP:
+		/* Logo response from tgt which we have deleted */
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Logo response from tgt: 0x%x",
+			     ntoh24(fchdr->fh_s_id));
+		break;
 	case FNIC_FABRIC_LOGO_RSP:
 		fdls_process_fabric_logo_rsp(iport, fchdr);
 		break;
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 5e042138dcf1..1676bd8324fc 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -84,6 +84,9 @@
 
 #define IS_FNIC_FCP_INITIATOR(fnic) (fnic->role == FNIC_ROLE_FCP_INITIATOR)
 
+/* Retry supported by rport (returned by PRLI service parameters) */
+#define FNIC_FC_RP_FLAGS_RETRY            0x1
+
 /*
  * fnic private data per SCSI command.
  * These fields are locked by the hashed io_req_lock.
@@ -138,6 +141,7 @@ static inline u64 fnic_flags_and_state(struct scsi_cmnd *cmd)
 
 extern unsigned int fnic_log_level;
 extern unsigned int io_completions;
+extern struct workqueue_struct *fnic_event_queue;
 
 #define FNIC_MAIN_LOGGING 0x01
 #define FNIC_FCS_LOGGING 0x02
@@ -336,6 +340,8 @@ struct fnic {
 	struct list_head tx_queue;
 	mempool_t *frame_pool;
 	mempool_t *frame_elem_pool;
+	struct work_struct tport_work;
+	struct list_head tport_event_list;
 
 	/*** FIP related data members  -- start ***/
 	void (*set_vlan)(struct fnic *, u16 vlan);
diff --git a/drivers/scsi/fnic/fnic_fdls.h b/drivers/scsi/fnic/fnic_fdls.h
index 14630b051487..943506dba858 100644
--- a/drivers/scsi/fnic/fnic_fdls.h
+++ b/drivers/scsi/fnic/fnic_fdls.h
@@ -388,7 +388,7 @@ void fdls_send_fabric_logo(struct fnic_iport_s *iport);
 int fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 	struct fc_frame_header *fchdr);
 void fdls_send_tport_abts(struct fnic_iport_s *iport,
-			  struct fnic_tport_s *tport);
+						struct fnic_tport_s *tport);
 bool fdls_delete_tport(struct fnic_iport_s *iport,
 		       struct fnic_tport_s *tport);
 void fdls_fdmi_timer_callback(struct timer_list *t);
-- 
2.47.0


