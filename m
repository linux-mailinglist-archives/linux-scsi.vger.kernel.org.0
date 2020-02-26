Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88A170BBA
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Feb 2020 23:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBZWk4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Feb 2020 17:40:56 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28258 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727887AbgBZWk4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Feb 2020 17:40:56 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QMWIDi004407;
        Wed, 26 Feb 2020 14:40:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=igvvsNQEvGGl6qfd4cEsvC4BGo4wxFBqjBg37AzkqZM=;
 b=JJrJF+e6pAkcmFX+Fqc9FA5YOnPTMQwS9qdCtfhT7gfTFe27fPLJ7yvVb7C3DcaALRKH
 oHtgt4neL7C54iM9aSMLlMbsd7+wXiFOy2oJknn63fCN74O9hHO5RWXhLji40uU//G/5
 DhFBxaZWz1qGuNFUkb7bkvc+XPIkPNqTkc9TkH2ykGmNJLaKeHZzg//yb1C/GA5MZj6k
 wn2jQtUx8DKaRzu7MAlEugpLLNj+ujDI/mh+ZqE+PUcx9E2Sf7ovjYxYY97SdoaVUB6x
 II6C1Hgiu4fJoXdJqk5akN+Amw0s8TCViGbtPp2ayij9rSpKRihNj0etvfGjkXG6iCa5 1w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ydcm15b8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 14:40:53 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Feb
 2020 14:40:52 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Feb 2020 14:40:51 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 2A8D73F703F;
        Wed, 26 Feb 2020 14:40:52 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 01QMepjK024597;
        Wed, 26 Feb 2020 14:40:51 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 01QMep8b024596;
        Wed, 26 Feb 2020 14:40:51 -0800
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 09/18] qla2xxx: Update BPM enablement semantics.
Date:   Wed, 26 Feb 2020 14:40:13 -0800
Message-ID: <20200226224022.24518-10-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200226224022.24518-1-hmadhani@marvell.com>
References: <20200226224022.24518-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Andrew Vasquez <andrewv@marvell.com>

commit e4e3a2ce9556cc4da40dadaf94c0d3395b6e91d9
("scsi: qla2xxx: Add ability to autodetect SFP type") takes a
heavy handed approach to BPM (Buffer Plus Management) enablement:

1) During hardware initialization, if an LR-capable transceiver is
   recognized, the driver schedules a disruptive post-initialization
   chip-reset (ISP-ABORT) to allow the BPM settings to be sent to the
   firmware.  This chip-reset will result in (short-term) path-loss
   to all fc-rports and their attached SCSI devices.

2) LR-detection is triggered during any link-up event, resulting in a
   refresh and potential chip-reset

Based on firmware-team guidance, upon LR-capable transceiver
recognition, the driver's hardware initialization code will now
re-execute firmware with the new BPM settings, then continue-on with
driver initialization.  To address the second issue, the driver performs
LR-capable detection upon the driver receiving a transceiver-insertion
asynchronous event from firmware.  No short-term path loss is needed
with this new semantic.

Signed-off-by: Andrew Vasquez <andrewv@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  | 20 +++++----
 drivers/scsi/qla2xxx/qla_fw.h   |  3 +-
 drivers/scsi/qla2xxx/qla_gbl.h  |  2 +-
 drivers/scsi/qla2xxx/qla_init.c | 90 +++++++++++++++++++++++++++++------------
 drivers/scsi/qla2xxx/qla_isr.c  |  9 +++--
 drivers/scsi/qla2xxx/qla_mbx.c  | 48 ++++------------------
 drivers/scsi/qla2xxx/qla_os.c   | 22 ++++------
 7 files changed, 98 insertions(+), 96 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 1104b7837450..920518231601 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -1049,6 +1049,7 @@ static inline bool qla2xxx_is_valid_mbs(unsigned int mbs)
 #define MBA_TEMPERATURE_ALERT	0x8070	/* Temperature Alert */
 #define MBA_DPORT_DIAGNOSTICS	0x8080	/* D-port Diagnostics */
 #define MBA_TRANS_INSERT	0x8130	/* Transceiver Insertion */
+#define MBA_TRANS_REMOVE	0x8131	/* Transceiver Removal */
 #define MBA_FW_INIT_FAILURE	0x8401	/* Firmware initialization failure */
 #define MBA_MIRROR_LUN_CHANGE	0x8402	/* Mirror LUN State Change
 					   Notification */
@@ -3802,8 +3803,8 @@ struct qla_hw_data {
 		uint32_t	fw_started:1;
 		uint32_t	fw_init_done:1;
 
-		uint32_t	detected_lr_sfp:1;
-		uint32_t	using_lr_setting:1;
+		uint32_t	lr_detected:1;
+
 		uint32_t	rida_fmt2:1;
 		uint32_t	purge_mbox:1;
 		uint32_t        n2n_bigger:1;
@@ -3812,7 +3813,7 @@ struct qla_hw_data {
 	} flags;
 
 	uint16_t max_exchg;
-	uint16_t long_range_distance;	/* 32G & above */
+	uint16_t lr_distance;	/* 32G & above */
 #define LR_DISTANCE_5K  1
 #define LR_DISTANCE_10K 0
 
@@ -4971,11 +4972,14 @@ struct sff_8247_a0 {
 	u8 resv2[128];
 };
 
-#define AUTO_DETECT_SFP_SUPPORT(_vha)\
-	(ql2xautodetectsfp && !_vha->vp_idx &&		\
-	(IS_QLA25XX(_vha->hw) || IS_QLA81XX(_vha->hw) ||\
-	IS_QLA83XX(_vha->hw) || IS_QLA27XX(_vha->hw) || \
-	 IS_QLA28XX(_vha->hw)))
+/* BPM -- Buffer Plus Management support. */
+#define IS_BPM_CAPABLE(ha) \
+	(IS_QLA25XX(ha) || IS_QLA81XX(ha) || IS_QLA83XX(ha) || \
+	 IS_QLA27XX(ha) || IS_QLA28XX(ha))
+#define IS_BPM_RANGE_CAPABLE(ha) \
+	(IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha))
+#define IS_BPM_ENABLED(vha) \
+	(ql2xautodetectsfp && !vha->vp_idx && IS_BPM_CAPABLE(vha->hw))
 
 #define FLASH_SEMAPHORE_REGISTER_ADDR   0x00101016
 
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index 8af5bc4e2cc6..f9bad5bd7198 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -1867,9 +1867,8 @@ struct access_chip_rsp_84xx {
 
 /* LR Distance bit positions */
 #define LR_DIST_NV_POS		2
+#define LR_DIST_NV_MASK		0xf
 #define LR_DIST_FW_POS		12
-#define LR_DIST_FW_SHIFT	(LR_DIST_FW_POS - LR_DIST_NV_POS)
-#define LR_DIST_FW_FIELD(x)	((x) << LR_DIST_FW_SHIFT & 0xf000)
 
 /* FAC semaphore defines */
 #define FAC_SEMAPHORE_UNLOCK    0
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 33ea79181dd7..1b93f5b4d77d 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -109,7 +109,7 @@ int qla24xx_async_notify_ack(scsi_qla_host_t *, fc_port_t *,
 int qla24xx_post_newsess_work(struct scsi_qla_host *, port_id_t *, u8 *, u8*,
     void *, u8);
 int qla24xx_fcport_handle_login(struct scsi_qla_host *, fc_port_t *);
-int qla24xx_detect_sfp(scsi_qla_host_t *vha);
+int qla24xx_detect_sfp(scsi_qla_host_t *);
 int qla24xx_post_gpdb_work(struct scsi_qla_host *, fc_port_t *, u8);
 
 extern void qla28xx_get_aux_images(struct scsi_qla_host *,
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index b440a4fdba36..453b47006a59 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3550,53 +3550,77 @@ static void qla2xxx_print_sfp_info(struct scsi_qla_host *vha)
 }
 
 
-/*
- * Return Code:
- *   QLA_SUCCESS: no action
- *   QLA_INTERFACE_ERROR: SFP is not there.
- *   QLA_FUNCTION_FAILED: detected New SFP
+/**
+ * qla24xx_detect_sfp()
+ *
+ * @vha: adapter state pointer.
+ *
+ * @return
+ *	0 -- Configure firmware to use short-range settings -- normal
+ *	     buffer-to-buffer credits.
+ *
+ *	1 -- Configure firmware to use long-range settings -- extra
+ *	     buffer-to-buffer credits should be allocated with
+ *	     ha->lr_distance containing distance settings from NVRAM or SFP
+ *	     (if supported).
  */
 int
 qla24xx_detect_sfp(scsi_qla_host_t *vha)
 {
-	int rc = QLA_SUCCESS;
+	int rc, used_nvram;
 	struct sff_8247_a0 *a;
 	struct qla_hw_data *ha = vha->hw;
-
-	if (!AUTO_DETECT_SFP_SUPPORT(vha))
+	struct nvram_81xx *nv = ha->nvram;
+#define LR_DISTANCE_UNKNOWN	2
+	static char *types[] = { "Short", "Long" };
+	static char *lengths[] = { "(10km)", "(5km)", "" };
+	u8 ll = 0;
+
+	/* Seed with NVRAM settings. */
+	used_nvram = 0;
+	ha->flags.lr_detected = 0;
+	if (IS_BPM_RANGE_CAPABLE(ha) &&
+	    (nv->enhanced_features & NEF_LR_DIST_ENABLE)) {
+		used_nvram = 1;
+		ha->flags.lr_detected = 1;
+		ha->lr_distance =
+		    (nv->enhanced_features >> LR_DIST_NV_POS)
+		     & LR_DIST_NV_MASK;
+	}
+
+	if (!IS_BPM_ENABLED(vha))
 		goto out;
-
+	/* Determine SR/LR capabilities of SFP/Transceiver. */
 	rc = qla2x00_read_sfp_dev(vha, NULL, 0);
 	if (rc)
 		goto out;
 
+	used_nvram = 0;
 	a = (struct sff_8247_a0 *)vha->hw->sfp_data;
 	qla2xxx_print_sfp_info(vha);
 
-	if (a->fc_ll_cc7 & FC_LL_VL || a->fc_ll_cc7 & FC_LL_L) {
-		/* long range */
-		ha->flags.detected_lr_sfp = 1;
+	ha->flags.lr_detected = 0;
+	ll = a->fc_ll_cc7;
+	if (ll & FC_LL_VL || ll & FC_LL_L) {
+		/* Long range, track length. */
+		ha->flags.lr_detected = 1;
 
 		if (a->length_km > 5 || a->length_100m > 50)
-			ha->long_range_distance = LR_DISTANCE_10K;
+			ha->lr_distance = LR_DISTANCE_10K;
 		else
-			ha->long_range_distance = LR_DISTANCE_5K;
-
-		if (ha->flags.detected_lr_sfp != ha->flags.using_lr_setting)
-			ql_dbg(ql_dbg_async, vha, 0x507b,
-			    "Detected Long Range SFP.\n");
-	} else {
-		/* short range */
-		ha->flags.detected_lr_sfp = 0;
-		if (ha->flags.using_lr_setting)
-			ql_dbg(ql_dbg_async, vha, 0x5084,
-			    "Detected Short Range SFP.\n");
+			ha->lr_distance = LR_DISTANCE_5K;
 	}
 
 	if (!vha->flags.init_done)
 		rc = QLA_SUCCESS;
 out:
-	return rc;
+	ql_dbg(ql_dbg_async, vha, 0x507b,
+	    "SFP detect: %s-Range SFP %s (nvr=%x ll=%x lr=%x lrd=%x).\n",
+	    types[ha->flags.lr_detected],
+	    ha->flags.lr_detected ? lengths[ha->lr_distance] :
+	       lengths[LR_DISTANCE_UNKNOWN],
+	    used_nvram, ll, ha->flags.lr_detected, ha->lr_distance);
+	return ha->flags.lr_detected;
 }
 
 /**
@@ -3614,6 +3638,7 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 	unsigned long flags;
 	uint16_t fw_major_version;
+	int done_once = 0;
 
 	if (IS_P3P_TYPE(ha)) {
 		rval = ha->isp_ops->load_risc(vha, &srisc_address);
@@ -3634,6 +3659,7 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 
 	qla81xx_mpi_sync(vha);
 
+execute_fw_with_lr:
 	/* Load firmware sequences */
 	rval = ha->isp_ops->load_risc(vha, &srisc_address);
 	if (rval == QLA_SUCCESS) {
@@ -3655,7 +3681,15 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 			rval = qla2x00_execute_fw(vha, srisc_address);
 			/* Retrieve firmware information. */
 			if (rval == QLA_SUCCESS) {
-				qla24xx_detect_sfp(vha);
+				/* Enable BPM support? */
+				if (!done_once++ && qla24xx_detect_sfp(vha)) {
+					ql_dbg(ql_dbg_init, vha, 0x00ca,
+					    "Re-starting firmware -- BPM.\n");
+					/* Best-effort - re-init. */
+					ha->isp_ops->reset_chip(vha);
+					ha->isp_ops->chip_diag(vha);
+					goto execute_fw_with_lr;
+				}
 
 				if ((IS_QLA83XX(ha) || IS_QLA27XX(ha) ||
 				    IS_QLA28XX(ha)) &&
@@ -3932,6 +3966,10 @@ qla24xx_update_fw_options(scsi_qla_host_t *vha)
 	if (ql2xrdpenable)
 		ha->fw_options[1] |= ADD_FO1_ENABLE_PUREX_IOCB;
 
+	/* Enable Async 8130/8131 events -- transceiver insertion/removal */
+	if (IS_BPM_RANGE_CAPABLE(ha))
+		ha->fw_options[3] |= BIT_10;
+
 	ql_dbg(ql_dbg_init, vha, 0x00e8,
 	    "%s, add FW options 1-3 = 0x%04x 0x%04x 0x%04x mode %x\n",
 	    __func__, ha->fw_options[1], ha->fw_options[2],
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 2c6e25f831f3..785f5319aa1b 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -960,10 +960,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		vha->flags.management_server_logged_in = 0;
 		qla2x00_post_aen_work(vha, FCH_EVT_LINKUP, ha->link_data_rate);
 
-		if (AUTO_DETECT_SFP_SUPPORT(vha)) {
-			set_bit(DETECT_SFP_CHANGE, &vha->dpc_flags);
-			qla2xxx_wake_dpc(vha);
-		}
 		break;
 
 	case MBA_LOOP_DOWN:		/* Loop Down Event */
@@ -1436,6 +1432,11 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 	case MBA_TRANS_INSERT:
 		ql_dbg(ql_dbg_async, vha, 0x5091,
 		    "Transceiver Insertion: %04x\n", mb[1]);
+		set_bit(DETECT_SFP_CHANGE, &vha->dpc_flags);
+		break;
+
+	case MBA_TRANS_REMOVE:
+		ql_dbg(ql_dbg_async, vha, 0x5091, "Transceiver Removal\n");
 		break;
 
 	default:
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index d0297bc4fe0d..09531b9ab517 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -644,28 +644,6 @@ qla2x00_load_ram(scsi_qla_host_t *vha, dma_addr_t req_dma, uint32_t risc_addr,
 }
 
 #define	NVME_ENABLE_FLAG	BIT_3
-static inline uint16_t qla25xx_set_sfp_lr_dist(struct qla_hw_data *ha)
-{
-	uint16_t mb4 = BIT_0;
-
-	if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha))
-		mb4 |= ha->long_range_distance << LR_DIST_FW_POS;
-
-	return mb4;
-}
-
-static inline uint16_t qla25xx_set_nvr_lr_dist(struct qla_hw_data *ha)
-{
-	uint16_t mb4 = BIT_0;
-
-	if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
-		struct nvram_81xx *nv = ha->nvram;
-
-		mb4 |= LR_DIST_FW_FIELD(nv->enhanced_features);
-	}
-
-	return mb4;
-}
 
 /*
  * qla2x00_execute_fw
@@ -702,25 +680,13 @@ qla2x00_execute_fw(scsi_qla_host_t *vha, uint32_t risc_addr)
 		mcp->mb[3] = 0;
 		mcp->mb[4] = 0;
 		mcp->mb[11] = 0;
-		ha->flags.using_lr_setting = 0;
-		if (IS_QLA25XX(ha) || IS_QLA81XX(ha) || IS_QLA83XX(ha) ||
-		    IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
-			if (ql2xautodetectsfp) {
-				if (ha->flags.detected_lr_sfp) {
-					mcp->mb[4] |=
-					    qla25xx_set_sfp_lr_dist(ha);
-					ha->flags.using_lr_setting = 1;
-				}
-			} else {
-				struct nvram_81xx *nv = ha->nvram;
-				/* set LR distance if specified in nvram */
-				if (nv->enhanced_features &
-				    NEF_LR_DIST_ENABLE) {
-					mcp->mb[4] |=
-					    qla25xx_set_nvr_lr_dist(ha);
-					ha->flags.using_lr_setting = 1;
-				}
-			}
+
+		/* Enable BPM? */
+		if (ha->flags.lr_detected) {
+			mcp->mb[4] = BIT_0;
+			if (IS_BPM_RANGE_CAPABLE(ha))
+				mcp->mb[4] |=
+				    ha->lr_distance << LR_DIST_FW_POS;
 		}
 
 		if (ql2xnvmeenable && (IS_QLA27XX(ha) || IS_QLA28XX(ha)))
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index f3244c8f2179..5772f788661b 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3461,13 +3461,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (test_bit(UNLOADING, &base_vha->dpc_flags))
 		return -ENODEV;
 
-	if (ha->flags.detected_lr_sfp) {
-		ql_log(ql_log_info, base_vha, 0xffff,
-		    "Reset chip to pick up LR SFP setting\n");
-		set_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags);
-		qla2xxx_wake_dpc(base_vha);
-	}
-
 	return 0;
 
 probe_failed:
@@ -6880,13 +6873,14 @@ qla2x00_do_dpc(void *data)
 		}
 
 		if (test_and_clear_bit(DETECT_SFP_CHANGE,
-			&base_vha->dpc_flags) &&
-		    !test_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags)) {
-			qla24xx_detect_sfp(base_vha);
-
-			if (ha->flags.detected_lr_sfp !=
-			    ha->flags.using_lr_setting)
-				set_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags);
+		    &base_vha->dpc_flags)) {
+			/* Semantic:
+			 *  - NO-OP -- await next ISP-ABORT. Preferred method
+			 *             to minimize disruptions that will occur
+			 *             when a forced chip-reset occurs.
+			 *  - Force -- ISP-ABORT scheduled.
+			 */
+			/* set_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags); */
 		}
 
 		if (test_and_clear_bit
-- 
2.12.0

