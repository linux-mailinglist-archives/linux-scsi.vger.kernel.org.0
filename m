Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9A420635
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Oct 2021 08:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhJDHBa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Oct 2021 03:01:30 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43702 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232990AbhJDHBR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Oct 2021 03:01:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1943sXix011679;
        Sun, 3 Oct 2021 23:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Br+1Mu1dw825noeqrDKpYfMoUvChG62t5MoOiBNt60g=;
 b=GokQNe2j2gGqp2oqTERzYz7Iae66tR+DpQ770KD0T+H86S0dHhzinzmKW7sww4e3YGT0
 jdeQGgkBhnl9H1cGW/zkKVvrNsY9dX2Ic4ptwsVUt2BGWtkWPPbB6x8/EQ8DkFa1U43a
 Us9JSCjnUgcSfwuJKNKgfegcTYtCRoP5uhqEjtTSvV3lZjGE7NtpPA8NUDKbHLYw+Nkh
 aREsV/LEEB/51cR8eZfEgdLKQJeDV49QsWkkTQ+2krAbt3I078SG9SqxME7E6/HNGXBP
 07KgHHaOlr0SoGzTfYKOqrLBOsXXTNVaA6pU+jTWvqzPTqqa0NNU+2BYT/v6g6KHfL5O gg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bfqptrnrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 23:59:26 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 3 Oct
 2021 23:59:25 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Sun, 3 Oct 2021 23:59:21 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <aelior@marvell.com>,
        <smalin@marvell.com>, <jhasan@marvell.com>,
        <mrangankar@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>,
        Omkar Kulkarni <okulkarni@marvell.com>
Subject: [PATCH v2 06/13] qed: Update qed_hsi.h for fw 8.59.1.0
Date:   Mon, 4 Oct 2021 09:58:44 +0300
Message-ID: <20211004065851.1903-7-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20211004065851.1903-1-pkushwaha@marvell.com>
References: <20211004065851.1903-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: mIwcqUCyetJZ6QpBQRMIu08wu0xkg2YS
X-Proofpoint-ORIG-GUID: mIwcqUCyetJZ6QpBQRMIu08wu0xkg2YS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_02,2021-10-01_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The qed_hsi.h has been updated to support new FW version 8.59.1.0 with
changes.
 - Updates FW HSI (Hardware Software interface) structures.
 - Addition/update in function declaration and defines as per HSI.
 - Add generic infrastructure for FW error reporting as part of
   common event queue handling.
 - Move malicious VF error reporting to FW error reporting
   infrastructure.
 - Move consolidation queue initialization from FW context to ramrod
   message.

qed_hsi.h header file changes lead to change in many files to ensure
compilation.

This patch also fixes the existing checkpatch warnings and few important
checks.

Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c     |  112 +-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     | 1556 +++++++++++++++--
 .../ethernet/qlogic/qed/qed_init_fw_funcs.c   |   14 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c      |    6 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h      |    1 -
 drivers/net/ethernet/qlogic/qed/qed_sp.h      |    8 +-
 .../net/ethernet/qlogic/qed/qed_sp_commands.c |   10 +-
 drivers/net/ethernet/qlogic/qed/qed_spq.c     |   50 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c   |  112 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.h   |   27 +-
 include/linux/qed/eth_common.h                |    1 +
 include/linux/qed/rdma_common.h               |    1 +
 12 files changed, 1590 insertions(+), 308 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 3db1a5512b9b..dad5cd219b0e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -1397,12 +1397,13 @@ void qed_resc_free(struct qed_dev *cdev)
 			qed_rdma_info_free(p_hwfn);
 		}
 
+		qed_spq_unregister_async_cb(p_hwfn, PROTOCOLID_COMMON);
 		qed_iov_free(p_hwfn);
 		qed_l2_free(p_hwfn);
 		qed_dmae_info_free(p_hwfn);
 		qed_dcbx_info_free(p_hwfn);
 		qed_dbg_user_data_free(p_hwfn);
-		qed_fw_overlay_mem_free(p_hwfn, p_hwfn->fw_overlay_mem);
+		qed_fw_overlay_mem_free(p_hwfn, &p_hwfn->fw_overlay_mem);
 
 		/* Destroy doorbell recovery mechanism */
 		qed_db_recovery_teardown(p_hwfn);
@@ -1484,8 +1485,8 @@ static u16 qed_init_qm_get_num_pf_rls(struct qed_hwfn *p_hwfn)
 	u16 num_pf_rls, num_vfs = qed_init_qm_get_num_vfs(p_hwfn);
 
 	/* num RLs can't exceed resource amount of rls or vports */
-	num_pf_rls = (u16) min_t(u32, RESC_NUM(p_hwfn, QED_RL),
-				 RESC_NUM(p_hwfn, QED_VPORT));
+	num_pf_rls = (u16)min_t(u32, RESC_NUM(p_hwfn, QED_RL),
+				RESC_NUM(p_hwfn, QED_VPORT));
 
 	/* Make sure after we reserve there's something left */
 	if (num_pf_rls < num_vfs + NUM_DEFAULT_RLS)
@@ -1533,8 +1534,8 @@ static void qed_init_qm_params(struct qed_hwfn *p_hwfn)
 	bool four_port;
 
 	/* pq and vport bases for this PF */
-	qm_info->start_pq = (u16) RESC_START(p_hwfn, QED_PQ);
-	qm_info->start_vport = (u8) RESC_START(p_hwfn, QED_VPORT);
+	qm_info->start_pq = (u16)RESC_START(p_hwfn, QED_PQ);
+	qm_info->start_vport = (u8)RESC_START(p_hwfn, QED_VPORT);
 
 	/* rate limiting and weighted fair queueing are always enabled */
 	qm_info->vport_rl_en = true;
@@ -1629,9 +1630,9 @@ static void qed_init_qm_advance_vport(struct qed_hwfn *p_hwfn)
  */
 
 /* flags for pq init */
-#define PQ_INIT_SHARE_VPORT     (1 << 0)
-#define PQ_INIT_PF_RL           (1 << 1)
-#define PQ_INIT_VF_RL           (1 << 2)
+#define PQ_INIT_SHARE_VPORT     BIT(0)
+#define PQ_INIT_PF_RL           BIT(1)
+#define PQ_INIT_VF_RL           BIT(2)
 
 /* defines for pq init */
 #define PQ_INIT_DEFAULT_WRR_GROUP       1
@@ -2291,7 +2292,7 @@ int qed_resc_alloc(struct qed_dev *cdev)
 			goto alloc_no_mem;
 		}
 
-		rc = qed_eq_alloc(p_hwfn, (u16) n_eqes);
+		rc = qed_eq_alloc(p_hwfn, (u16)n_eqes);
 		if (rc)
 			goto alloc_err;
 
@@ -2376,6 +2377,49 @@ int qed_resc_alloc(struct qed_dev *cdev)
 	return rc;
 }
 
+static int qed_fw_err_handler(struct qed_hwfn *p_hwfn,
+			      u8 opcode,
+			      u16 echo,
+			      union event_ring_data *data, u8 fw_return_code)
+{
+	if (fw_return_code != COMMON_ERR_CODE_ERROR)
+		goto eqe_unexpected;
+
+	if (data->err_data.recovery_scope == ERR_SCOPE_FUNC &&
+	    le16_to_cpu(data->err_data.entity_id) >= MAX_NUM_PFS) {
+		qed_sriov_vfpf_malicious(p_hwfn, &data->err_data);
+		return 0;
+	}
+
+eqe_unexpected:
+	DP_ERR(p_hwfn,
+	       "Skipping unexpected eqe 0x%02x, FW return code 0x%x, echo 0x%x\n",
+	       opcode, fw_return_code, echo);
+	return -EINVAL;
+}
+
+static int qed_common_eqe_event(struct qed_hwfn *p_hwfn,
+				u8 opcode,
+				__le16 echo,
+				union event_ring_data *data,
+				u8 fw_return_code)
+{
+	switch (opcode) {
+	case COMMON_EVENT_VF_PF_CHANNEL:
+	case COMMON_EVENT_VF_FLR:
+		return qed_sriov_eqe_event(p_hwfn, opcode, echo, data,
+					   fw_return_code);
+	case COMMON_EVENT_FW_ERROR:
+		return qed_fw_err_handler(p_hwfn, opcode,
+					  le16_to_cpu(echo), data,
+					  fw_return_code);
+	default:
+		DP_INFO(p_hwfn->cdev, "Unknown eqe event 0x%02x, echo 0x%x\n",
+			opcode, echo);
+		return -EINVAL;
+	}
+}
+
 void qed_resc_setup(struct qed_dev *cdev)
 {
 	int i;
@@ -2404,6 +2448,8 @@ void qed_resc_setup(struct qed_dev *cdev)
 
 		qed_l2_setup(p_hwfn);
 		qed_iov_setup(p_hwfn);
+		qed_spq_register_async_cb(p_hwfn, PROTOCOLID_COMMON,
+					  qed_common_eqe_event);
 #ifdef CONFIG_QED_LL2
 		if (p_hwfn->using_ll2)
 			qed_ll2_setup(p_hwfn);
@@ -2593,7 +2639,7 @@ static void qed_init_cache_line_size(struct qed_hwfn *p_hwfn,
 			cache_line_size);
 	}
 
-	if (L1_CACHE_BYTES > wr_mbs)
+	if (wr_mbs < L1_CACHE_BYTES)
 		DP_INFO(p_hwfn,
 			"The cache line size for padding is suboptimal for performance [OS cache line size 0x%x, wr mbs 0x%x]\n",
 			L1_CACHE_BYTES, wr_mbs);
@@ -2609,13 +2655,21 @@ static int qed_hw_init_common(struct qed_hwfn *p_hwfn,
 			      struct qed_ptt *p_ptt, int hw_mode)
 {
 	struct qed_qm_info *qm_info = &p_hwfn->qm_info;
-	struct qed_qm_common_rt_init_params params;
+	struct qed_qm_common_rt_init_params *params;
 	struct qed_dev *cdev = p_hwfn->cdev;
 	u8 vf_id, max_num_vfs;
 	u16 num_pfs, pf_id;
 	u32 concrete_fid;
 	int rc = 0;
 
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params) {
+		DP_NOTICE(p_hwfn->cdev,
+			  "Failed to allocate common init params\n");
+
+		return -ENOMEM;
+	}
+
 	qed_init_cau_rt_data(cdev);
 
 	/* Program GTT windows */
@@ -2628,16 +2682,15 @@ static int qed_hw_init_common(struct qed_hwfn *p_hwfn,
 			qm_info->pf_wfq_en = true;
 	}
 
-	memset(&params, 0, sizeof(params));
-	params.max_ports_per_engine = p_hwfn->cdev->num_ports_in_engine;
-	params.max_phys_tcs_per_port = qm_info->max_phys_tcs_per_port;
-	params.pf_rl_en = qm_info->pf_rl_en;
-	params.pf_wfq_en = qm_info->pf_wfq_en;
-	params.global_rl_en = qm_info->vport_rl_en;
-	params.vport_wfq_en = qm_info->vport_wfq_en;
-	params.port_params = qm_info->qm_port_params;
+	params->max_ports_per_engine = p_hwfn->cdev->num_ports_in_engine;
+	params->max_phys_tcs_per_port = qm_info->max_phys_tcs_per_port;
+	params->pf_rl_en = qm_info->pf_rl_en;
+	params->pf_wfq_en = qm_info->pf_wfq_en;
+	params->global_rl_en = qm_info->vport_rl_en;
+	params->vport_wfq_en = qm_info->vport_wfq_en;
+	params->port_params = qm_info->qm_port_params;
 
-	qed_qm_common_rt_init(p_hwfn, &params);
+	qed_qm_common_rt_init(p_hwfn, params);
 
 	qed_cxt_hw_init_common(p_hwfn);
 
@@ -2645,7 +2698,7 @@ static int qed_hw_init_common(struct qed_hwfn *p_hwfn,
 
 	rc = qed_init_run(p_hwfn, p_ptt, PHASE_ENGINE, ANY_PHASE_ID, hw_mode);
 	if (rc)
-		return rc;
+		goto out;
 
 	qed_wr(p_hwfn, p_ptt, PSWRQ2_REG_L2P_VALIDATE_VFID, 0);
 	qed_wr(p_hwfn, p_ptt, PGLUE_B_REG_USE_CLIENTID_IN_TAG, 1);
@@ -2664,7 +2717,7 @@ static int qed_hw_init_common(struct qed_hwfn *p_hwfn,
 	max_num_vfs = QED_IS_AH(cdev) ? MAX_NUM_VFS_K2 : MAX_NUM_VFS_BB;
 	for (vf_id = 0; vf_id < max_num_vfs; vf_id++) {
 		concrete_fid = qed_vfid_to_concrete(p_hwfn, vf_id);
-		qed_fid_pretend(p_hwfn, p_ptt, (u16) concrete_fid);
+		qed_fid_pretend(p_hwfn, p_ptt, (u16)concrete_fid);
 		qed_wr(p_hwfn, p_ptt, CCFC_REG_STRONG_ENABLE_VF, 0x1);
 		qed_wr(p_hwfn, p_ptt, CCFC_REG_WEAK_ENABLE_VF, 0x0);
 		qed_wr(p_hwfn, p_ptt, TCFC_REG_STRONG_ENABLE_VF, 0x1);
@@ -2673,6 +2726,9 @@ static int qed_hw_init_common(struct qed_hwfn *p_hwfn,
 	/* pretend to original PF */
 	qed_fid_pretend(p_hwfn, p_ptt, p_hwfn->rel_pf_id);
 
+out:
+	kfree(params);
+
 	return rc;
 }
 
@@ -2785,7 +2841,7 @@ qed_hw_init_pf_doorbell_bar(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 			qed_rdma_dpm_bar(p_hwfn, p_ptt);
 	}
 
-	p_hwfn->wid_count = (u16) n_cpus;
+	p_hwfn->wid_count = (u16)n_cpus;
 
 	DP_INFO(p_hwfn,
 		"doorbell bar: normal_region_size=%d, pwm_region_size=%d, dpi_size=%d, dpi_count=%d, roce_edpm=%s, page_size=%lu\n",
@@ -3504,8 +3560,8 @@ static void qed_hw_hwfn_prepare(struct qed_hwfn *p_hwfn)
 static void get_function_id(struct qed_hwfn *p_hwfn)
 {
 	/* ME Register */
-	p_hwfn->hw_info.opaque_fid = (u16) REG_RD(p_hwfn,
-						  PXP_PF_ME_OPAQUE_ADDR);
+	p_hwfn->hw_info.opaque_fid = (u16)REG_RD(p_hwfn,
+						 PXP_PF_ME_OPAQUE_ADDR);
 
 	p_hwfn->hw_info.concrete_fid = REG_RD(p_hwfn, PXP_PF_ME_CONCRETE_ADDR);
 
@@ -3671,12 +3727,14 @@ u32 qed_get_hsi_def_val(struct qed_dev *cdev, enum qed_hsi_def_type type)
 
 	return qed_hsi_def_val[type][chip_id];
 }
+
 static int
 qed_hw_set_soft_resc_size(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
 	u32 resc_max_val, mcp_resp;
 	u8 res_id;
 	int rc;
+
 	for (res_id = 0; res_id < QED_MAX_RESC; res_id++) {
 		switch (res_id) {
 		case QED_LL2_RAM_QUEUE:
@@ -3922,7 +3980,7 @@ static int qed_hw_get_resc(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 	 * resources allocation queries should be atomic. Since several PFs can
 	 * run in parallel - a resource lock is needed.
 	 * If either the resource lock or resource set value commands are not
-	 * supported - skip the the max values setting, release the lock if
+	 * supported - skip the max values setting, release the lock if
 	 * needed, and proceed to the queries. Other failures, including a
 	 * failure to acquire the lock, will cause this function to fail.
 	 */
@@ -4776,7 +4834,7 @@ int qed_fw_l2_queue(struct qed_hwfn *p_hwfn, u16 src_id, u16 *dst_id)
 	if (src_id >= RESC_NUM(p_hwfn, QED_L2_QUEUE)) {
 		u16 min, max;
 
-		min = (u16) RESC_START(p_hwfn, QED_L2_QUEUE);
+		min = (u16)RESC_START(p_hwfn, QED_L2_QUEUE);
 		max = min + RESC_NUM(p_hwfn, QED_L2_QUEUE);
 		DP_NOTICE(p_hwfn,
 			  "l2_queue id [%d] is not valid, available indices [%d - %d]\n",
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index 68eaef8ab6e8..f2cedbd9489c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* QLogic qed NIC Driver
  * Copyright (c) 2015-2017  QLogic Corporation
- * Copyright (c) 2019-2020 Marvell International Ltd.
+ * Copyright (c) 2019-2021 Marvell International Ltd.
  */
 
 #ifndef _QED_HSI_H
@@ -38,7 +38,7 @@ enum common_event_opcode {
 	COMMON_EVENT_VF_PF_CHANNEL,
 	COMMON_EVENT_VF_FLR,
 	COMMON_EVENT_PF_UPDATE,
-	COMMON_EVENT_MALICIOUS_VF,
+	COMMON_EVENT_FW_ERROR,
 	COMMON_EVENT_RL_UPDATE,
 	COMMON_EVENT_EMPTY,
 	MAX_COMMON_EVENT_OPCODE
@@ -84,6 +84,13 @@ enum core_l4_pseudo_checksum_mode {
 	MAX_CORE_L4_PSEUDO_CHECKSUM_MODE
 };
 
+/* LL2 SP error code */
+enum core_ll2_error_code {
+	LL2_OK = 0,
+	LL2_ERROR,
+	MAX_CORE_LL2_ERROR_CODE
+};
+
 /* Light-L2 RX Producers in Tstorm RAM */
 struct core_ll2_port_stats {
 	struct regpair gsi_invalid_hdr;
@@ -123,6 +130,15 @@ struct core_ll2_ustorm_per_queue_stat {
 	struct regpair rcv_bcast_pkts;
 };
 
+struct core_ll2_rx_per_queue_stat {
+	struct core_ll2_tstorm_per_queue_stat tstorm_stat;
+	struct core_ll2_ustorm_per_queue_stat ustorm_stat;
+};
+
+struct core_ll2_tx_per_queue_stat {
+	struct core_ll2_pstorm_per_queue_stat pstorm_stat;
+};
+
 /* Structure for doorbell data, in PWM mode, for RX producers update. */
 struct core_pwm_prod_update_data {
 	__le16 icid; /* internal CID */
@@ -135,6 +151,15 @@ struct core_pwm_prod_update_data {
 	struct core_ll2_rx_prod prod; /* Producers */
 };
 
+/* Ramrod data for rx/tx queue statistics query ramrod */
+struct core_queue_stats_query_ramrod_data {
+	u8 rx_stat;
+	u8 tx_stat;
+	__le16 reserved[3];
+	struct regpair rx_stat_addr;
+	struct regpair tx_stat_addr;
+};
+
 /* Core Ramrod Command IDs (light L2) */
 enum core_ramrod_cmd_id {
 	CORE_RAMROD_UNUSED,
@@ -210,7 +235,8 @@ struct core_rx_fast_path_cqe {
 	__le16 vlan;
 	struct core_rx_cqe_opaque_data opaque_data;
 	struct parsing_err_flags err_flags;
-	__le16 reserved0;
+	u8 packet_source;
+	u8 reserved0;
 	__le32 reserved1[3];
 };
 
@@ -226,7 +252,8 @@ struct core_rx_gsi_offload_cqe {
 	__le16 qp_id;
 	__le32 src_qp;
 	struct core_rx_cqe_opaque_data opaque_data;
-	__le32 reserved;
+	u8 packet_source;
+	u8 reserved[3];
 };
 
 /* Core RX CQE for Light L2 */
@@ -245,6 +272,15 @@ union core_rx_cqe_union {
 	struct core_rx_slow_path_cqe rx_cqe_sp;
 };
 
+/* RX packet source. */
+enum core_rx_pkt_source {
+	CORE_RX_PKT_SOURCE_NETWORK = 0,
+	CORE_RX_PKT_SOURCE_LB,
+	CORE_RX_PKT_SOURCE_TX,
+	CORE_RX_PKT_SOURCE_LL2_TX,
+	MAX_CORE_RX_PKT_SOURCE
+};
+
 /* Ramrod data for rx queue start ramrod */
 struct core_rx_start_ramrod_data {
 	struct regpair bd_base;
@@ -362,7 +398,7 @@ struct core_tx_update_ramrod_data {
 	u8 update_qm_pq_id_flg;
 	u8 reserved0;
 	__le16 qm_pq_id;
-	__le32 reserved1;
+	__le32 reserved1[1];
 };
 
 /* Enum flag for what type of dcb data to update */
@@ -386,12 +422,10 @@ struct pstorm_core_conn_st_ctx {
 
 /* Core Slowpath Connection storm context of Xstorm */
 struct xstorm_core_conn_st_ctx {
-	__le32 spq_base_lo;
-	__le32 spq_base_hi;
-	struct regpair consolid_base_addr;
+	struct regpair spq_base_addr;
+	__le32 reserved0[2];
 	__le16 spq_cons;
-	__le16 consolid_cons;
-	__le32 reserved0[55];
+	__le16 reserved1[111];
 };
 
 struct xstorm_core_conn_ag_ctx {
@@ -930,12 +964,12 @@ struct eth_rx_rate_limit {
 
 /* Update RSS indirection table entry command */
 struct eth_tstorm_rss_update_data {
-	u8 valid;
 	u8 vport_id;
 	u8 ind_table_index;
-	u8 reserved;
 	__le16 ind_table_value;
 	__le16 reserved1;
+	u8 reserved;
+	u8 valid;
 };
 
 struct eth_ustorm_per_pf_stat {
@@ -967,19 +1001,20 @@ struct vf_pf_channel_eqe_data {
 	struct regpair msg_addr;
 };
 
-/* Event Ring malicious VF data */
-struct malicious_vf_eqe_data {
-	u8 vf_id;
-	u8 err_id;
-	__le16 reserved[3];
-};
-
 /* Event Ring initial cleanup data */
 struct initial_cleanup_eqe_data {
 	u8 vf_id;
 	u8 reserved[7];
 };
 
+/* FW error data */
+struct fw_err_data {
+	u8 recovery_scope;
+	u8 err_id;
+	__le16 entity_id;
+	u8 reserved[4];
+};
+
 /* Event Data Union */
 union event_ring_data {
 	u8 bytes[8];
@@ -987,8 +1022,8 @@ union event_ring_data {
 	struct iscsi_eqe_data iscsi_info;
 	struct iscsi_connect_done_results iscsi_conn_done_info;
 	union rdma_eqe_data rdma_data;
-	struct malicious_vf_eqe_data malicious_vf;
 	struct initial_cleanup_eqe_data vf_init_cleanup;
+	struct fw_err_data err_data;
 };
 
 /* Event Ring Entry */
@@ -1042,6 +1077,15 @@ struct hsi_fp_ver_struct {
 	u8 major_ver_arr[2];
 };
 
+/* Integration Phase */
+enum integ_phase {
+	INTEG_PHASE_BB_A0_LATEST = 3,
+	INTEG_PHASE_BB_B0_NO_MCP = 10,
+	INTEG_PHASE_BB_B0_WITH_MCP = 11,
+	MAX_INTEG_PHASE
+};
+
+/* Ports mode */
 enum iwarp_ll2_tx_queues {
 	IWARP_LL2_IN_ORDER_TX_QUEUE = 1,
 	IWARP_LL2_ALIGNED_TX_QUEUE,
@@ -1050,9 +1094,9 @@ enum iwarp_ll2_tx_queues {
 	MAX_IWARP_LL2_TX_QUEUES
 };
 
-/* Malicious VF error ID */
-enum malicious_vf_error_id {
-	MALICIOUS_VF_NO_ERROR,
+/* Function error ID */
+enum func_err_id {
+	FUNC_NO_ERROR,
 	VF_PF_CHANNEL_NOT_READY,
 	VF_ZONE_MSG_NOT_VALID,
 	VF_ZONE_FUNC_NOT_ENABLED,
@@ -1087,7 +1131,27 @@ enum malicious_vf_error_id {
 	CORE_PACKET_SIZE_TOO_LARGE,
 	CORE_ILLEGAL_BD_FLAGS,
 	CORE_GSI_PACKET_VIOLATION,
-	MAX_MALICIOUS_VF_ERROR_ID,
+	MAX_FUNC_ERR_ID
+};
+
+/* FW error handling mode */
+enum fw_err_mode {
+	FW_ERR_FATAL_ASSERT,
+	FW_ERR_DRV_REPORT,
+	MAX_FW_ERR_MODE
+};
+
+/* FW error recovery scope */
+enum fw_err_recovery_scope {
+	ERR_SCOPE_INVALID,
+	ERR_SCOPE_TX_Q,
+	ERR_SCOPE_RX_Q,
+	ERR_SCOPE_QP,
+	ERR_SCOPE_VPORT,
+	ERR_SCOPE_FUNC,
+	ERR_SCOPE_PORT,
+	ERR_SCOPE_ENGINE,
+	MAX_FW_ERR_RECOVERY_SCOPE
 };
 
 /* Mstorm non-triggering VF zone */
@@ -1148,7 +1212,7 @@ struct pf_start_tunnel_config {
 /* Ramrod data for PF start ramrod */
 struct pf_start_ramrod_data {
 	struct regpair event_ring_pbl_addr;
-	struct regpair consolid_q_pbl_addr;
+	struct regpair consolid_q_pbl_base_addr;
 	struct pf_start_tunnel_config tunnel_config;
 	__le16 event_ring_sb_id;
 	u8 base_vf_id;
@@ -1166,6 +1230,9 @@ struct pf_start_ramrod_data {
 	u8 reserved0;
 	struct hsi_fp_ver_struct hsi_fp_ver;
 	struct outer_tag_config_struct outer_tag_config;
+	u8 pf_fp_err_mode;
+	u8 consolid_q_num_pages;
+	u8 reserved[6];
 };
 
 /* Data for port update ramrod */
@@ -1230,6 +1297,13 @@ enum ports_mode {
 	MAX_PORTS_MODE
 };
 
+/* Protocol-common error code */
+enum protocol_common_error_code {
+	COMMON_ERR_CODE_OK = 0,
+	COMMON_ERR_CODE_ERROR,
+	MAX_PROTOCOL_COMMON_ERROR_CODE
+};
+
 /* use to index in hsi_fp_[major|minor]_ver_arr per protocol */
 enum protocol_version_array_key {
 	ETH_VER_KEY = 0,
@@ -1704,6 +1778,7 @@ struct igu_msix_vector {
 #define IGU_MSIX_VECTOR_RESERVED1_MASK		0xFF
 #define IGU_MSIX_VECTOR_RESERVED1_SHIFT		24
 };
+
 /* per encapsulation type enabling flags */
 struct prs_reg_encapsulation_type_en {
 	u8 flags;
@@ -1881,6 +1956,9 @@ struct init_nig_pri_tc_map_req {
 
 /* QM per global RL init parameters */
 struct init_qm_global_rl_params {
+	u8 type;
+	u8 reserved0;
+	u16 reserved1;
 	u32 rate_limit;
 };
 
@@ -1895,18 +1973,33 @@ struct init_qm_port_params {
 
 /* QM per-PQ init parameters */
 struct init_qm_pq_params {
-	u8 vport_id;
+	u16 vport_id;
+	u16 rl_id;
+	u8 rl_valid;
 	u8 tc_id;
 	u8 wrr_group;
-	u8 rl_valid;
-	u16 rl_id;
 	u8 port_id;
-	u8 reserved;
+};
+
+/* QM per RL init parameters */
+struct init_qm_rl_params {
+	u32 vport_rl;
+	u8 vport_rl_type;
+	u8 reserved[3];
+};
+
+/* QM Rate Limiter types */
+enum init_qm_rl_type {
+	QM_RL_TYPE_NORMAL,
+	QM_RL_TYPE_QCN,
+	MAX_INIT_QM_RL_TYPE
 };
 
 /* QM per-vport init parameters */
 struct init_qm_vport_params {
 	u16 wfq;
+	u16 reserved;
+	u16 tc_wfq[NUM_OF_TCS];
 	u16 first_tx_pq_id[NUM_OF_TCS];
 };
 
@@ -1965,14 +2058,14 @@ struct fw_info_location {
 };
 
 enum init_modes {
-	MODE_RESERVED,
+	MODE_BB_A0_DEPRECATED,
 	MODE_BB,
 	MODE_K2,
 	MODE_ASIC,
-	MODE_RESERVED2,
-	MODE_RESERVED3,
-	MODE_RESERVED4,
-	MODE_RESERVED5,
+	MODE_EMUL_REDUCED,
+	MODE_EMUL_FULL,
+	MODE_FPGA,
+	MODE_CHIPSIM,
 	MODE_SF,
 	MODE_MF_SD,
 	MODE_MF_SI,
@@ -1980,8 +2073,8 @@ enum init_modes {
 	MODE_PORTS_PER_ENG_2,
 	MODE_PORTS_PER_ENG_4,
 	MODE_100G,
-	MODE_RESERVED6,
-	MODE_RESERVED7,
+	MODE_SKIP_PRAM_INIT,
+	MODE_EMUL_MAC,
 	MAX_INIT_MODES
 };
 
@@ -2282,6 +2375,15 @@ struct iro {
 /* Win 13 */
 #define GTT_BAR0_MAP_REG_PSDM_RAM	0x01a000UL
 
+/* Returns the VOQ based on port and TC */
+#define VOQ(port, tc, max_phys_tcs_per_port)   ((tc) ==                       \
+						PURE_LB_TC ? NUM_OF_PHYS_TCS *\
+						MAX_NUM_PORTS_BB +            \
+						(port) : (port) *             \
+						(max_phys_tcs_per_port) + (tc))
+
+struct init_qm_pq_params;
+
 /**
  * qed_qm_pf_mem_size(): Prepare QM ILT sizes.
  *
@@ -2308,8 +2410,19 @@ struct qed_qm_common_rt_init_params {
 	bool global_rl_en;
 	bool vport_wfq_en;
 	struct init_qm_port_params *port_params;
+	struct init_qm_global_rl_params
+	global_rl_params[COMMON_MAX_QM_GLOBAL_RLS];
 };
 
+/**
+ * qed_qm_common_rt_init(): Prepare QM runtime init values for the
+ *                          engine phase.
+ *
+ * @p_hwfn: HW device data.
+ * @p_params: Parameters.
+ *
+ * Return: 0 on success, -1 on error.
+ */
 int qed_qm_common_rt_init(struct qed_hwfn *p_hwfn,
 			  struct qed_qm_common_rt_init_params *p_params);
 
@@ -2326,15 +2439,28 @@ struct qed_qm_pf_rt_init_params {
 	u16 num_vf_pqs;
 	u16 start_vport;
 	u16 num_vports;
+	u16 start_rl;
+	u16 num_rls;
 	u16 pf_wfq;
 	u32 pf_rl;
+	u32 link_speed;
 	struct init_qm_pq_params *pq_params;
 	struct init_qm_vport_params *vport_params;
+	struct init_qm_rl_params *rl_params;
 };
 
+/**
+ * qed_qm_pf_rt_init(): Prepare QM runtime init values for the PF phase.
+ *
+ * @p_hwfn:  HW device data.
+ * @p_ptt: Ptt window used for writing the registers
+ * @p_params: Parameters.
+ *
+ * Return: 0 on success, -1 on error.
+ */
 int qed_qm_pf_rt_init(struct qed_hwfn *p_hwfn,
-	struct qed_ptt *p_ptt,
-	struct qed_qm_pf_rt_init_params *p_params);
+		      struct qed_ptt *p_ptt,
+		      struct qed_qm_pf_rt_init_params *p_params);
 
 /**
  * qed_init_pf_wfq(): Initializes the WFQ weight of the specified PF.
@@ -2378,6 +2504,22 @@ int qed_init_vport_wfq(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
 		       u16 first_tx_pq_id[NUM_OF_TCS], u16 wfq);
 
+/**
+ * qed_init_vport_tc_wfq(): Initializes the WFQ weight of the specified
+ *                          VPORT and TC.
+ *
+ * @p_hwfn: HW device data.
+ * @p_ptt: Ptt window used for writing the registers.
+ * @first_tx_pq_id: The first Tx PQ ID associated with the VPORT and TC.
+ *                  (filled by qed_qm_pf_rt_init).
+ * @weight: VPORT+TC WFQ weight.
+ *
+ * Return: 0 on success, -1 on error.
+ */
+int qed_init_vport_tc_wfq(struct qed_hwfn *p_hwfn,
+			  struct qed_ptt *p_ptt,
+			  u16 first_tx_pq_id, u16 weight);
+
 /**
  * qed_init_global_rl():  Initializes the rate limit of the specified
  * rate limiter.
@@ -2386,12 +2528,14 @@ int qed_init_vport_wfq(struct qed_hwfn *p_hwfn,
  * @p_ptt: Ptt window used for writing the registers.
  * @rl_id: RL ID.
  * @rate_limit: Rate limit in Mb/sec units
+ * @vport_rl_type: Vport RL type.
  *
  * Return: 0 on success, -1 on error.
  */
 int qed_init_global_rl(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
-		       u16 rl_id, u32 rate_limit);
+		       u16 rl_id, u32 rate_limit,
+		       enum init_qm_rl_type vport_rl_type);
 
 /**
  * qed_send_qm_stop_cmd(): Sends a stop command to the QM.
@@ -2627,7 +2771,19 @@ void qed_fw_overlay_init_ram(struct qed_hwfn *p_hwfn,
  * Return: Void.
  */
 void qed_fw_overlay_mem_free(struct qed_hwfn *p_hwfn,
-			     struct phys_mem_desc *fw_overlay_mem);
+			     struct phys_mem_desc **fw_overlay_mem);
+
+#define PCICFG_OFFSET					0x2000
+#define GRC_CONFIG_REG_PF_INIT_VF			0x624
+
+/* First VF_NUM for PF is encoded in this register.
+ * The number of VFs assigned to a PF is assumed to be a multiple of 8.
+ * Software should program these bits based on Total Number of VFs programmed
+ * for each PF.
+ * Since registers from 0x000-0x7ff are spilt across functions, each PF will
+ * have the same location for the same 4 bits
+ */
+#define GRC_CR_PF_INIT_VF_PF_FIRST_VF_NUM_MASK		0xff
 
 /* Runtime array offsets */
 #define DORQ_REG_PF_MAX_ICID_0_RT_OFFSET				0
@@ -2958,116 +3114,118 @@ void qed_fw_overlay_mem_free(struct qed_hwfn *p_hwfn,
 #define QM_REG_TXPQMAP_RT_SIZE						512
 #define QM_REG_WFQVPWEIGHT_RT_OFFSET					31556
 #define QM_REG_WFQVPWEIGHT_RT_SIZE					512
-#define QM_REG_WFQVPCRD_RT_OFFSET					32068
+#define QM_REG_WFQVPUPPERBOUND_RT_OFFSET				32068
+#define QM_REG_WFQVPUPPERBOUND_RT_SIZE					512
+#define QM_REG_WFQVPCRD_RT_OFFSET					32580
 #define QM_REG_WFQVPCRD_RT_SIZE						512
-#define QM_REG_WFQVPMAP_RT_OFFSET					32580
+#define QM_REG_WFQVPMAP_RT_OFFSET					33092
 #define QM_REG_WFQVPMAP_RT_SIZE						512
-#define QM_REG_PTRTBLTX_RT_OFFSET					33092
+#define QM_REG_PTRTBLTX_RT_OFFSET					33604
 #define QM_REG_PTRTBLTX_RT_SIZE						1024
-#define QM_REG_WFQPFCRD_MSB_RT_OFFSET					34116
+#define QM_REG_WFQPFCRD_MSB_RT_OFFSET					34628
 #define QM_REG_WFQPFCRD_MSB_RT_SIZE					160
-#define NIG_REG_TAG_ETHERTYPE_0_RT_OFFSET				34276
-#define NIG_REG_BRB_GATE_DNTFWD_PORT_RT_OFFSET				34277
-#define NIG_REG_OUTER_TAG_VALUE_LIST0_RT_OFFSET				34278
-#define NIG_REG_OUTER_TAG_VALUE_LIST1_RT_OFFSET				34279
-#define NIG_REG_OUTER_TAG_VALUE_LIST2_RT_OFFSET				34280
-#define NIG_REG_OUTER_TAG_VALUE_LIST3_RT_OFFSET				34281
-#define NIG_REG_LLH_FUNC_TAGMAC_CLS_TYPE_RT_OFFSET			34282
-#define NIG_REG_LLH_FUNC_TAG_EN_RT_OFFSET				34283
+#define NIG_REG_TAG_ETHERTYPE_0_RT_OFFSET				34788
+#define NIG_REG_BRB_GATE_DNTFWD_PORT_RT_OFFSET				34789
+#define NIG_REG_OUTER_TAG_VALUE_LIST0_RT_OFFSET				34790
+#define NIG_REG_OUTER_TAG_VALUE_LIST1_RT_OFFSET				34791
+#define NIG_REG_OUTER_TAG_VALUE_LIST2_RT_OFFSET				34792
+#define NIG_REG_OUTER_TAG_VALUE_LIST3_RT_OFFSET				34793
+#define NIG_REG_LLH_FUNC_TAGMAC_CLS_TYPE_RT_OFFSET			34794
+#define NIG_REG_LLH_FUNC_TAG_EN_RT_OFFSET				34795
 #define NIG_REG_LLH_FUNC_TAG_EN_RT_SIZE					4
-#define NIG_REG_LLH_FUNC_TAG_VALUE_RT_OFFSET				34287
+#define NIG_REG_LLH_FUNC_TAG_VALUE_RT_OFFSET				34799
 #define NIG_REG_LLH_FUNC_TAG_VALUE_RT_SIZE				4
-#define NIG_REG_LLH_FUNC_FILTER_VALUE_RT_OFFSET				34291
+#define NIG_REG_LLH_FUNC_FILTER_VALUE_RT_OFFSET				34803
 #define NIG_REG_LLH_FUNC_FILTER_VALUE_RT_SIZE				32
-#define NIG_REG_LLH_FUNC_FILTER_EN_RT_OFFSET				34323
+#define NIG_REG_LLH_FUNC_FILTER_EN_RT_OFFSET				34835
 #define NIG_REG_LLH_FUNC_FILTER_EN_RT_SIZE				16
-#define NIG_REG_LLH_FUNC_FILTER_MODE_RT_OFFSET				34339
+#define NIG_REG_LLH_FUNC_FILTER_MODE_RT_OFFSET				34851
 #define NIG_REG_LLH_FUNC_FILTER_MODE_RT_SIZE				16
-#define NIG_REG_LLH_FUNC_FILTER_PROTOCOL_TYPE_RT_OFFSET			34355
+#define NIG_REG_LLH_FUNC_FILTER_PROTOCOL_TYPE_RT_OFFSET			34867
 #define NIG_REG_LLH_FUNC_FILTER_PROTOCOL_TYPE_RT_SIZE			16
-#define NIG_REG_LLH_FUNC_FILTER_HDR_SEL_RT_OFFSET			34371
+#define NIG_REG_LLH_FUNC_FILTER_HDR_SEL_RT_OFFSET			34883
 #define NIG_REG_LLH_FUNC_FILTER_HDR_SEL_RT_SIZE				16
-#define NIG_REG_TX_EDPM_CTRL_RT_OFFSET					34387
-#define NIG_REG_PPF_TO_ENGINE_SEL_RT_OFFSET				34388
+#define NIG_REG_TX_EDPM_CTRL_RT_OFFSET					34899
+#define NIG_REG_PPF_TO_ENGINE_SEL_RT_OFFSET				34900
 #define NIG_REG_PPF_TO_ENGINE_SEL_RT_SIZE				8
-#define CDU_REG_CID_ADDR_PARAMS_RT_OFFSET				34396
-#define CDU_REG_SEGMENT0_PARAMS_RT_OFFSET				34397
-#define CDU_REG_SEGMENT1_PARAMS_RT_OFFSET				34398
-#define CDU_REG_PF_SEG0_TYPE_OFFSET_RT_OFFSET				34399
-#define CDU_REG_PF_SEG1_TYPE_OFFSET_RT_OFFSET				34400
-#define CDU_REG_PF_SEG2_TYPE_OFFSET_RT_OFFSET				34401
-#define CDU_REG_PF_SEG3_TYPE_OFFSET_RT_OFFSET				34402
-#define CDU_REG_PF_FL_SEG0_TYPE_OFFSET_RT_OFFSET			34403
-#define CDU_REG_PF_FL_SEG1_TYPE_OFFSET_RT_OFFSET			34404
-#define CDU_REG_PF_FL_SEG2_TYPE_OFFSET_RT_OFFSET			34405
-#define CDU_REG_PF_FL_SEG3_TYPE_OFFSET_RT_OFFSET			34406
-#define CDU_REG_VF_SEG_TYPE_OFFSET_RT_OFFSET				34407
-#define CDU_REG_VF_FL_SEG_TYPE_OFFSET_RT_OFFSET				34408
-#define PBF_REG_TAG_ETHERTYPE_0_RT_OFFSET				34409
-#define PBF_REG_BTB_SHARED_AREA_SIZE_RT_OFFSET				34410
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ0_RT_OFFSET			34411
-#define PBF_REG_BTB_GUARANTEED_VOQ0_RT_OFFSET				34412
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ0_RT_OFFSET			34413
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ1_RT_OFFSET			34414
-#define PBF_REG_BTB_GUARANTEED_VOQ1_RT_OFFSET				34415
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ1_RT_OFFSET			34416
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ2_RT_OFFSET			34417
-#define PBF_REG_BTB_GUARANTEED_VOQ2_RT_OFFSET				34418
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ2_RT_OFFSET			34419
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ3_RT_OFFSET			34420
-#define PBF_REG_BTB_GUARANTEED_VOQ3_RT_OFFSET				34421
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ3_RT_OFFSET			34422
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ4_RT_OFFSET			34423
-#define PBF_REG_BTB_GUARANTEED_VOQ4_RT_OFFSET				34424
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ4_RT_OFFSET			34425
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ5_RT_OFFSET			34426
-#define PBF_REG_BTB_GUARANTEED_VOQ5_RT_OFFSET				34427
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ5_RT_OFFSET			34428
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ6_RT_OFFSET			34429
-#define PBF_REG_BTB_GUARANTEED_VOQ6_RT_OFFSET				34430
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ6_RT_OFFSET			34431
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ7_RT_OFFSET			34432
-#define PBF_REG_BTB_GUARANTEED_VOQ7_RT_OFFSET				34433
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ7_RT_OFFSET			34434
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ8_RT_OFFSET			34435
-#define PBF_REG_BTB_GUARANTEED_VOQ8_RT_OFFSET				34436
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ8_RT_OFFSET			34437
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ9_RT_OFFSET			34438
-#define PBF_REG_BTB_GUARANTEED_VOQ9_RT_OFFSET				34439
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ9_RT_OFFSET			34440
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ10_RT_OFFSET			34441
-#define PBF_REG_BTB_GUARANTEED_VOQ10_RT_OFFSET				34442
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ10_RT_OFFSET			34443
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ11_RT_OFFSET			34444
-#define PBF_REG_BTB_GUARANTEED_VOQ11_RT_OFFSET				34445
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ11_RT_OFFSET			34446
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ12_RT_OFFSET			34447
-#define PBF_REG_BTB_GUARANTEED_VOQ12_RT_OFFSET				34448
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ12_RT_OFFSET			34449
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ13_RT_OFFSET			34450
-#define PBF_REG_BTB_GUARANTEED_VOQ13_RT_OFFSET				34451
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ13_RT_OFFSET			34452
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ14_RT_OFFSET			34453
-#define PBF_REG_BTB_GUARANTEED_VOQ14_RT_OFFSET				34454
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ14_RT_OFFSET			34455
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ15_RT_OFFSET			34456
-#define PBF_REG_BTB_GUARANTEED_VOQ15_RT_OFFSET				34457
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ15_RT_OFFSET			34458
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ16_RT_OFFSET			34459
-#define PBF_REG_BTB_GUARANTEED_VOQ16_RT_OFFSET				34460
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ16_RT_OFFSET			34461
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ17_RT_OFFSET			34462
-#define PBF_REG_BTB_GUARANTEED_VOQ17_RT_OFFSET				34463
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ17_RT_OFFSET			34464
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ18_RT_OFFSET			34465
-#define PBF_REG_BTB_GUARANTEED_VOQ18_RT_OFFSET				34466
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ18_RT_OFFSET			34467
-#define PBF_REG_YCMD_QS_NUM_LINES_VOQ19_RT_OFFSET			34468
-#define PBF_REG_BTB_GUARANTEED_VOQ19_RT_OFFSET				34469
-#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ19_RT_OFFSET			34470
-#define XCM_REG_CON_PHY_Q3_RT_OFFSET					34471
-
-#define RUNTIME_ARRAY_SIZE 34472
+#define CDU_REG_CID_ADDR_PARAMS_RT_OFFSET				34908
+#define CDU_REG_SEGMENT0_PARAMS_RT_OFFSET				34909
+#define CDU_REG_SEGMENT1_PARAMS_RT_OFFSET				34910
+#define CDU_REG_PF_SEG0_TYPE_OFFSET_RT_OFFSET				34911
+#define CDU_REG_PF_SEG1_TYPE_OFFSET_RT_OFFSET				34912
+#define CDU_REG_PF_SEG2_TYPE_OFFSET_RT_OFFSET				34913
+#define CDU_REG_PF_SEG3_TYPE_OFFSET_RT_OFFSET				34914
+#define CDU_REG_PF_FL_SEG0_TYPE_OFFSET_RT_OFFSET			34915
+#define CDU_REG_PF_FL_SEG1_TYPE_OFFSET_RT_OFFSET			34916
+#define CDU_REG_PF_FL_SEG2_TYPE_OFFSET_RT_OFFSET			34917
+#define CDU_REG_PF_FL_SEG3_TYPE_OFFSET_RT_OFFSET			34918
+#define CDU_REG_VF_SEG_TYPE_OFFSET_RT_OFFSET				34919
+#define CDU_REG_VF_FL_SEG_TYPE_OFFSET_RT_OFFSET				34920
+#define PBF_REG_TAG_ETHERTYPE_0_RT_OFFSET				34921
+#define PBF_REG_BTB_SHARED_AREA_SIZE_RT_OFFSET				34922
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ0_RT_OFFSET			34923
+#define PBF_REG_BTB_GUARANTEED_VOQ0_RT_OFFSET				34924
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ0_RT_OFFSET			34925
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ1_RT_OFFSET			34926
+#define PBF_REG_BTB_GUARANTEED_VOQ1_RT_OFFSET				34927
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ1_RT_OFFSET			34928
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ2_RT_OFFSET			34929
+#define PBF_REG_BTB_GUARANTEED_VOQ2_RT_OFFSET				34930
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ2_RT_OFFSET			34931
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ3_RT_OFFSET			34932
+#define PBF_REG_BTB_GUARANTEED_VOQ3_RT_OFFSET				34933
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ3_RT_OFFSET			34934
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ4_RT_OFFSET			34935
+#define PBF_REG_BTB_GUARANTEED_VOQ4_RT_OFFSET				34936
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ4_RT_OFFSET			34937
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ5_RT_OFFSET			34938
+#define PBF_REG_BTB_GUARANTEED_VOQ5_RT_OFFSET				34939
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ5_RT_OFFSET			34940
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ6_RT_OFFSET			34941
+#define PBF_REG_BTB_GUARANTEED_VOQ6_RT_OFFSET				34942
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ6_RT_OFFSET			34943
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ7_RT_OFFSET			34944
+#define PBF_REG_BTB_GUARANTEED_VOQ7_RT_OFFSET				34945
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ7_RT_OFFSET			34946
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ8_RT_OFFSET			34947
+#define PBF_REG_BTB_GUARANTEED_VOQ8_RT_OFFSET				34948
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ8_RT_OFFSET			34949
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ9_RT_OFFSET			34950
+#define PBF_REG_BTB_GUARANTEED_VOQ9_RT_OFFSET				34951
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ9_RT_OFFSET			34952
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ10_RT_OFFSET			34953
+#define PBF_REG_BTB_GUARANTEED_VOQ10_RT_OFFSET				34954
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ10_RT_OFFSET			34955
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ11_RT_OFFSET			34956
+#define PBF_REG_BTB_GUARANTEED_VOQ11_RT_OFFSET				34957
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ11_RT_OFFSET			34958
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ12_RT_OFFSET			34959
+#define PBF_REG_BTB_GUARANTEED_VOQ12_RT_OFFSET				34960
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ12_RT_OFFSET			34961
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ13_RT_OFFSET			34962
+#define PBF_REG_BTB_GUARANTEED_VOQ13_RT_OFFSET				34963
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ13_RT_OFFSET			34964
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ14_RT_OFFSET			34965
+#define PBF_REG_BTB_GUARANTEED_VOQ14_RT_OFFSET				34966
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ14_RT_OFFSET			34967
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ15_RT_OFFSET			34968
+#define PBF_REG_BTB_GUARANTEED_VOQ15_RT_OFFSET				34969
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ15_RT_OFFSET			34970
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ16_RT_OFFSET			34971
+#define PBF_REG_BTB_GUARANTEED_VOQ16_RT_OFFSET				34972
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ16_RT_OFFSET			34973
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ17_RT_OFFSET			34974
+#define PBF_REG_BTB_GUARANTEED_VOQ17_RT_OFFSET				34975
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ17_RT_OFFSET			34976
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ18_RT_OFFSET			34977
+#define PBF_REG_BTB_GUARANTEED_VOQ18_RT_OFFSET				34978
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ18_RT_OFFSET			34979
+#define PBF_REG_YCMD_QS_NUM_LINES_VOQ19_RT_OFFSET			34980
+#define PBF_REG_BTB_GUARANTEED_VOQ19_RT_OFFSET				34981
+#define PBF_REG_BTB_SHARED_AREA_SETUP_VOQ19_RT_OFFSET			34982
+#define XCM_REG_CON_PHY_Q3_RT_OFFSET					34983
+
+#define RUNTIME_ARRAY_SIZE						34984
 
 /* Init Callbacks */
 #define DMAE_READY_CB	0
@@ -3749,7 +3907,7 @@ enum eth_ramrod_cmd_id {
 	ETH_RAMROD_RX_ADD_UDP_FILTER,
 	ETH_RAMROD_RX_DELETE_UDP_FILTER,
 	ETH_RAMROD_RX_CREATE_GFT_ACTION,
-	ETH_RAMROD_GFT_UPDATE_FILTER,
+	ETH_RAMROD_RX_UPDATE_GFT_FILTER,
 	ETH_RAMROD_TX_QUEUE_UPDATE,
 	ETH_RAMROD_RGFS_FILTER_ADD,
 	ETH_RAMROD_RGFS_FILTER_DEL,
@@ -3833,10 +3991,12 @@ struct eth_vport_rss_config {
 	u8 update_rss_ind_table;
 	u8 update_rss_capabilities;
 	u8 tbl_size;
-	__le32 reserved2[2];
+	u8 ind_table_mask_valid;
+	u8 reserved2[3];
 	__le16 indirection_table[ETH_RSS_IND_TABLE_ENTRIES_NUM];
+	__le32 ind_table_mask[ETH_RSS_IND_TABLE_MASK_SIZE_REGS];
 	__le32 rss_key[ETH_RSS_KEY_SIZE_REGS];
-	__le32 reserved3[2];
+	__le32 reserved3;
 };
 
 /* eth vport RSS mode */
@@ -3911,8 +4071,20 @@ enum gft_filter_update_action {
 	MAX_GFT_FILTER_UPDATE_ACTION
 };
 
+/* Ramrod data for rx create gft action */
+struct rx_create_gft_action_ramrod_data {
+	u8 vport_id;
+	u8 reserved[7];
+};
+
+/* Ramrod data for rx create openflow action */
+struct rx_create_openflow_action_ramrod_data {
+	u8 vport_id;
+	u8 reserved[7];
+};
+
 /* Ramrod data for rx add openflow filter */
-struct rx_add_openflow_filter_data {
+struct rx_openflow_filter_ramrod_data {
 	__le16 action_icid;
 	u8 priority;
 	u8 reserved0;
@@ -3935,18 +4107,6 @@ struct rx_add_openflow_filter_data {
 	__le16 l4_src_port;
 };
 
-/* Ramrod data for rx create gft action */
-struct rx_create_gft_action_data {
-	u8 vport_id;
-	u8 reserved[7];
-};
-
-/* Ramrod data for rx create openflow action */
-struct rx_create_openflow_action_data {
-	u8 vport_id;
-	u8 reserved[7];
-};
-
 /* Ramrod data for rx queue start ramrod */
 struct rx_queue_start_ramrod_data {
 	__le16 rx_queue_id;
@@ -4005,7 +4165,7 @@ struct rx_queue_update_ramrod_data {
 };
 
 /* Ramrod data for rx Add UDP Filter */
-struct rx_udp_filter_data {
+struct rx_udp_filter_ramrod_data {
 	__le16 action_icid;
 	__le16 vlan_id;
 	u8 ip_type;
@@ -4021,7 +4181,7 @@ struct rx_udp_filter_data {
 /* Add or delete GFT filter - filter is packet header of type of packet wished
  * to pass certain FW flow.
  */
-struct rx_update_gft_filter_data {
+struct rx_update_gft_filter_ramrod_data {
 	struct regpair pkt_hdr_addr;
 	__le16 pkt_hdr_length;
 	__le16 action_icid;
@@ -4061,7 +4221,8 @@ struct tx_queue_start_ramrod_data {
 	u8 pxp_tph_valid_bd;
 	u8 pxp_tph_valid_pkt;
 	__le16 pxp_st_index;
-	__le16 comp_agg_size;
+	u8 comp_agg_size;
+	u8 reserved3;
 	__le16 queue_zone_id;
 	__le16 reserved2;
 	__le16 pbl_size;
@@ -4182,7 +4343,12 @@ struct vport_update_ramrod_data_cmn {
 	u8 ctl_frame_ethtype_check_en;
 	u8 update_in_to_in_pri_map_mode;
 	u8 in_to_in_pri_map[8];
-	u8 reserved[6];
+	u8 update_tx_dst_port_mode_flg;
+	u8 tx_dst_port_mode_config;
+	u8 dst_vport_id;
+	u8 tx_dst_port_mode;
+	u8 dst_vport_id_valid;
+	u8 reserved[1];
 };
 
 struct vport_update_ramrod_mcast {
@@ -4716,7 +4882,6 @@ struct gft_cam_line_mapped {
 #define GFT_CAM_LINE_MAPPED_RESERVED1_SHIFT			29
 };
 
-
 /* Used in gft_profile_key: Indication for ip version */
 enum gft_profile_ip_version {
 	GFT_PROFILE_IPV4 = 0,
@@ -5077,6 +5242,843 @@ struct rdma_task_context {
 	struct ustorm_rdma_task_ag_ctx ustorm_ag_context;
 };
 
+#define TOE_MAX_RAMROD_PER_PF			8
+#define TOE_TX_PAGE_SIZE_BYTES			4096
+#define TOE_GRQ_PAGE_SIZE_BYTES			4096
+#define TOE_RX_CQ_PAGE_SIZE_BYTES		4096
+
+#define TOE_RX_MAX_RSS_CHAINS			64
+#define TOE_TX_MAX_TSS_CHAINS			64
+#define TOE_RSS_INDIRECTION_TABLE_SIZE		128
+
+/* The toe storm context of Mstorm */
+struct mstorm_toe_conn_st_ctx {
+	__le32 reserved[24];
+};
+
+/* The toe storm context of Pstorm */
+struct pstorm_toe_conn_st_ctx {
+	__le32 reserved[36];
+};
+
+/* The toe storm context of Ystorm */
+struct ystorm_toe_conn_st_ctx {
+	__le32 reserved[8];
+};
+
+/* The toe storm context of Xstorm */
+struct xstorm_toe_conn_st_ctx {
+	__le32 reserved[44];
+};
+
+struct ystorm_toe_conn_ag_ctx {
+	u8 byte0;
+	u8 byte1;
+	u8 flags0;
+#define YSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_MASK		0x1
+#define YSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_SHIFT		0
+#define YSTORM_TOE_CONN_AG_CTX_BIT1_MASK			0x1
+#define YSTORM_TOE_CONN_AG_CTX_BIT1_SHIFT			1
+#define YSTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_MASK		0x3
+#define YSTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_SHIFT		2
+#define YSTORM_TOE_CONN_AG_CTX_RESET_RECEIVED_CF_MASK		0x3
+#define YSTORM_TOE_CONN_AG_CTX_RESET_RECEIVED_CF_SHIFT		4
+#define YSTORM_TOE_CONN_AG_CTX_CF2_MASK				0x3
+#define YSTORM_TOE_CONN_AG_CTX_CF2_SHIFT			6
+	u8 flags1;
+#define YSTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_EN_MASK		0x1
+#define YSTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_EN_SHIFT		0
+#define YSTORM_TOE_CONN_AG_CTX_RESET_RECEIVED_CF_EN_MASK	0x1
+#define YSTORM_TOE_CONN_AG_CTX_RESET_RECEIVED_CF_EN_SHIFT	1
+#define YSTORM_TOE_CONN_AG_CTX_CF2EN_MASK			0x1
+#define YSTORM_TOE_CONN_AG_CTX_CF2EN_SHIFT			2
+#define YSTORM_TOE_CONN_AG_CTX_REL_SEQ_EN_MASK			0x1
+#define YSTORM_TOE_CONN_AG_CTX_REL_SEQ_EN_SHIFT			3
+#define YSTORM_TOE_CONN_AG_CTX_RULE1EN_MASK			0x1
+#define YSTORM_TOE_CONN_AG_CTX_RULE1EN_SHIFT			4
+#define YSTORM_TOE_CONN_AG_CTX_RULE2EN_MASK			0x1
+#define YSTORM_TOE_CONN_AG_CTX_RULE2EN_SHIFT			5
+#define YSTORM_TOE_CONN_AG_CTX_RULE3EN_MASK			0x1
+#define YSTORM_TOE_CONN_AG_CTX_RULE3EN_SHIFT			6
+#define YSTORM_TOE_CONN_AG_CTX_CONS_PROD_EN_MASK		0x1
+#define YSTORM_TOE_CONN_AG_CTX_CONS_PROD_EN_SHIFT		7
+	u8 completion_opcode;
+	u8 byte3;
+	__le16 word0;
+	__le32 rel_seq;
+	__le32 rel_seq_threshold;
+	__le16 app_prod;
+	__le16 app_cons;
+	__le16 word3;
+	__le16 word4;
+	__le32 reg2;
+	__le32 reg3;
+};
+
+struct xstorm_toe_conn_ag_ctx {
+	u8 reserved0;
+	u8 state;
+	u8 flags0;
+#define XSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_SHIFT		0
+#define XSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM1_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM1_SHIFT		1
+#define XSTORM_TOE_CONN_AG_CTX_RESERVED1_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RESERVED1_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM3_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM3_SHIFT		3
+#define XSTORM_TOE_CONN_AG_CTX_TX_DEC_RULE_RES_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_TX_DEC_RULE_RES_SHIFT		4
+#define XSTORM_TOE_CONN_AG_CTX_RESERVED2_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RESERVED2_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_BIT6_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT6_SHIFT			6
+#define XSTORM_TOE_CONN_AG_CTX_BIT7_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT7_SHIFT			7
+	u8 flags1;
+#define XSTORM_TOE_CONN_AG_CTX_BIT8_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT8_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_BIT9_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT9_SHIFT			1
+#define XSTORM_TOE_CONN_AG_CTX_BIT10_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT10_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_BIT11_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT11_SHIFT			3
+#define XSTORM_TOE_CONN_AG_CTX_BIT12_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT12_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_BIT13_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT13_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_BIT14_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT14_SHIFT			6
+#define XSTORM_TOE_CONN_AG_CTX_BIT15_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT15_SHIFT			7
+	u8 flags2;
+#define XSTORM_TOE_CONN_AG_CTX_CF0_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF0_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_CF1_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF1_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_CF2_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF2_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_MASK		0x3
+#define XSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_SHIFT		6
+	u8 flags3;
+#define XSTORM_TOE_CONN_AG_CTX_CF4_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF4_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_CF5_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF5_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_CF6_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF6_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_CF7_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF7_SHIFT			6
+	u8 flags4;
+#define XSTORM_TOE_CONN_AG_CTX_CF8_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF8_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_CF9_MASK				0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF9_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_CF10_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF10_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_CF11_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF11_SHIFT			6
+	u8 flags5;
+#define XSTORM_TOE_CONN_AG_CTX_CF12_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF12_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_CF13_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF13_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_CF14_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF14_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_CF15_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF15_SHIFT			6
+	u8 flags6;
+#define XSTORM_TOE_CONN_AG_CTX_CF16_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF16_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_CF17_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF17_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_CF18_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF18_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_DQ_FLUSH_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_DQ_FLUSH_SHIFT			6
+	u8 flags7;
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q1_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q1_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_SLOW_PATH_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_SLOW_PATH_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_CF0EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF0EN_SHIFT			6
+#define XSTORM_TOE_CONN_AG_CTX_CF1EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF1EN_SHIFT			7
+	u8 flags8;
+#define XSTORM_TOE_CONN_AG_CTX_CF2EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF2EN_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_EN_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_EN_SHIFT		1
+#define XSTORM_TOE_CONN_AG_CTX_CF4EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF4EN_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_CF5EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF5EN_SHIFT			3
+#define XSTORM_TOE_CONN_AG_CTX_CF6EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF6EN_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_CF7EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF7EN_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_CF8EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF8EN_SHIFT			6
+#define XSTORM_TOE_CONN_AG_CTX_CF9EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF9EN_SHIFT			7
+	u8 flags9;
+#define XSTORM_TOE_CONN_AG_CTX_CF10EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF10EN_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_CF11EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF11EN_SHIFT			1
+#define XSTORM_TOE_CONN_AG_CTX_CF12EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF12EN_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_CF13EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF13EN_SHIFT			3
+#define XSTORM_TOE_CONN_AG_CTX_CF14EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF14EN_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_CF15EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF15EN_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_CF16EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF16EN_SHIFT			6
+#define XSTORM_TOE_CONN_AG_CTX_CF17EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF17EN_SHIFT			7
+	u8 flags10;
+#define XSTORM_TOE_CONN_AG_CTX_CF18EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF18EN_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_DQ_FLUSH_EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_DQ_FLUSH_EN_SHIFT		1
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_EN_SHIFT		2
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q1_EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_FLUSH_Q1_EN_SHIFT		3
+#define XSTORM_TOE_CONN_AG_CTX_SLOW_PATH_EN_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_SLOW_PATH_EN_SHIFT		4
+#define XSTORM_TOE_CONN_AG_CTX_CF23EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_CF23EN_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_RULE0EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE0EN_SHIFT			6
+#define XSTORM_TOE_CONN_AG_CTX_MORE_TO_SEND_RULE_EN_MASK	0x1
+#define XSTORM_TOE_CONN_AG_CTX_MORE_TO_SEND_RULE_EN_SHIFT	7
+	u8 flags11;
+#define XSTORM_TOE_CONN_AG_CTX_TX_BLOCKED_EN_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_TX_BLOCKED_EN_SHIFT		0
+#define XSTORM_TOE_CONN_AG_CTX_RULE3EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE3EN_SHIFT			1
+#define XSTORM_TOE_CONN_AG_CTX_RESERVED3_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RESERVED3_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_RULE5EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE5EN_SHIFT			3
+#define XSTORM_TOE_CONN_AG_CTX_RULE6EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE6EN_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_RULE7EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE7EN_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED1_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED1_SHIFT		6
+#define XSTORM_TOE_CONN_AG_CTX_RULE9EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE9EN_SHIFT			7
+	u8 flags12;
+#define XSTORM_TOE_CONN_AG_CTX_RULE10EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE10EN_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_RULE11EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE11EN_SHIFT			1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED2_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED2_SHIFT		2
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED3_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED3_SHIFT		3
+#define XSTORM_TOE_CONN_AG_CTX_RULE14EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE14EN_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_RULE15EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE15EN_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_RULE16EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE16EN_SHIFT			6
+#define XSTORM_TOE_CONN_AG_CTX_RULE17EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE17EN_SHIFT			7
+	u8 flags13;
+#define XSTORM_TOE_CONN_AG_CTX_RULE18EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE18EN_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_RULE19EN_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_RULE19EN_SHIFT			1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED4_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED4_SHIFT		2
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED5_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED5_SHIFT		3
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED6_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED6_SHIFT		4
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED7_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED7_SHIFT		5
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED8_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED8_SHIFT		6
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED9_MASK		0x1
+#define XSTORM_TOE_CONN_AG_CTX_A0_RESERVED9_SHIFT		7
+	u8 flags14;
+#define XSTORM_TOE_CONN_AG_CTX_BIT16_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT16_SHIFT			0
+#define XSTORM_TOE_CONN_AG_CTX_BIT17_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT17_SHIFT			1
+#define XSTORM_TOE_CONN_AG_CTX_BIT18_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT18_SHIFT			2
+#define XSTORM_TOE_CONN_AG_CTX_BIT19_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT19_SHIFT			3
+#define XSTORM_TOE_CONN_AG_CTX_BIT20_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT20_SHIFT			4
+#define XSTORM_TOE_CONN_AG_CTX_BIT21_MASK			0x1
+#define XSTORM_TOE_CONN_AG_CTX_BIT21_SHIFT			5
+#define XSTORM_TOE_CONN_AG_CTX_CF23_MASK			0x3
+#define XSTORM_TOE_CONN_AG_CTX_CF23_SHIFT			6
+	u8 byte2;
+	__le16 physical_q0;
+	__le16 physical_q1;
+	__le16 word2;
+	__le16 word3;
+	__le16 bd_prod;
+	__le16 word5;
+	__le16 word6;
+	u8 byte3;
+	u8 byte4;
+	u8 byte5;
+	u8 byte6;
+	__le32 reg0;
+	__le32 reg1;
+	__le32 reg2;
+	__le32 more_to_send_seq;
+	__le32 local_adv_wnd_seq;
+	__le32 reg5;
+	__le32 reg6;
+	__le16 word7;
+	__le16 word8;
+	__le16 word9;
+	__le16 word10;
+	__le32 reg7;
+	__le32 reg8;
+	__le32 reg9;
+	u8 byte7;
+	u8 byte8;
+	u8 byte9;
+	u8 byte10;
+	u8 byte11;
+	u8 byte12;
+	u8 byte13;
+	u8 byte14;
+	u8 byte15;
+	u8 e5_reserved;
+	__le16 word11;
+	__le32 reg10;
+	__le32 reg11;
+	__le32 reg12;
+	__le32 reg13;
+	__le32 reg14;
+	__le32 reg15;
+	__le32 reg16;
+	__le32 reg17;
+};
+
+struct tstorm_toe_conn_ag_ctx {
+	u8 reserved0;
+	u8 byte1;
+	u8 flags0;
+#define TSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_MASK		0x1
+#define TSTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_SHIFT		0
+#define TSTORM_TOE_CONN_AG_CTX_BIT1_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_BIT1_SHIFT			1
+#define TSTORM_TOE_CONN_AG_CTX_BIT2_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_BIT2_SHIFT			2
+#define TSTORM_TOE_CONN_AG_CTX_BIT3_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_BIT3_SHIFT			3
+#define TSTORM_TOE_CONN_AG_CTX_BIT4_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_BIT4_SHIFT			4
+#define TSTORM_TOE_CONN_AG_CTX_BIT5_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_BIT5_SHIFT			5
+#define TSTORM_TOE_CONN_AG_CTX_TIMEOUT_CF_MASK			0x3
+#define TSTORM_TOE_CONN_AG_CTX_TIMEOUT_CF_SHIFT			6
+	u8 flags1;
+#define TSTORM_TOE_CONN_AG_CTX_CF1_MASK				0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF1_SHIFT			0
+#define TSTORM_TOE_CONN_AG_CTX_CF2_MASK				0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF2_SHIFT			2
+#define TSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_MASK		0x3
+#define TSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_SHIFT		4
+#define TSTORM_TOE_CONN_AG_CTX_CF4_MASK				0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF4_SHIFT			6
+	u8 flags2;
+#define TSTORM_TOE_CONN_AG_CTX_CF5_MASK				0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF5_SHIFT			0
+#define TSTORM_TOE_CONN_AG_CTX_CF6_MASK				0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF6_SHIFT			2
+#define TSTORM_TOE_CONN_AG_CTX_CF7_MASK				0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF7_SHIFT			4
+#define TSTORM_TOE_CONN_AG_CTX_CF8_MASK				0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF8_SHIFT			6
+	u8 flags3;
+#define TSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_MASK			0x3
+#define TSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_SHIFT			0
+#define TSTORM_TOE_CONN_AG_CTX_CF10_MASK			0x3
+#define TSTORM_TOE_CONN_AG_CTX_CF10_SHIFT			2
+#define TSTORM_TOE_CONN_AG_CTX_TIMEOUT_CF_EN_MASK		0x1
+#define TSTORM_TOE_CONN_AG_CTX_TIMEOUT_CF_EN_SHIFT		4
+#define TSTORM_TOE_CONN_AG_CTX_CF1EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF1EN_SHIFT			5
+#define TSTORM_TOE_CONN_AG_CTX_CF2EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF2EN_SHIFT			6
+#define TSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_EN_MASK		0x1
+#define TSTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_EN_SHIFT		7
+	u8 flags4;
+#define TSTORM_TOE_CONN_AG_CTX_CF4EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF4EN_SHIFT			0
+#define TSTORM_TOE_CONN_AG_CTX_CF5EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF5EN_SHIFT			1
+#define TSTORM_TOE_CONN_AG_CTX_CF6EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF6EN_SHIFT			2
+#define TSTORM_TOE_CONN_AG_CTX_CF7EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF7EN_SHIFT			3
+#define TSTORM_TOE_CONN_AG_CTX_CF8EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF8EN_SHIFT			4
+#define TSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_FLUSH_Q0_EN_SHIFT		5
+#define TSTORM_TOE_CONN_AG_CTX_CF10EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_CF10EN_SHIFT			6
+#define TSTORM_TOE_CONN_AG_CTX_RULE0EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE0EN_SHIFT			7
+	u8 flags5;
+#define TSTORM_TOE_CONN_AG_CTX_RULE1EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE1EN_SHIFT			0
+#define TSTORM_TOE_CONN_AG_CTX_RULE2EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE2EN_SHIFT			1
+#define TSTORM_TOE_CONN_AG_CTX_RULE3EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE3EN_SHIFT			2
+#define TSTORM_TOE_CONN_AG_CTX_RULE4EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE4EN_SHIFT			3
+#define TSTORM_TOE_CONN_AG_CTX_RULE5EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE5EN_SHIFT			4
+#define TSTORM_TOE_CONN_AG_CTX_RULE6EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE6EN_SHIFT			5
+#define TSTORM_TOE_CONN_AG_CTX_RULE7EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE7EN_SHIFT			6
+#define TSTORM_TOE_CONN_AG_CTX_RULE8EN_MASK			0x1
+#define TSTORM_TOE_CONN_AG_CTX_RULE8EN_SHIFT			7
+	__le32 reg0;
+	__le32 reg1;
+	__le32 reg2;
+	__le32 reg3;
+	__le32 reg4;
+	__le32 reg5;
+	__le32 reg6;
+	__le32 reg7;
+	__le32 reg8;
+	u8 byte2;
+	u8 byte3;
+	__le16 word0;
+};
+
+struct ustorm_toe_conn_ag_ctx {
+	u8 reserved;
+	u8 byte1;
+	u8 flags0;
+#define USTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_MASK		0x1
+#define USTORM_TOE_CONN_AG_CTX_EXIST_IN_QM0_SHIFT		0
+#define USTORM_TOE_CONN_AG_CTX_BIT1_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_BIT1_SHIFT			1
+#define USTORM_TOE_CONN_AG_CTX_CF0_MASK				0x3
+#define USTORM_TOE_CONN_AG_CTX_CF0_SHIFT			2
+#define USTORM_TOE_CONN_AG_CTX_CF1_MASK				0x3
+#define USTORM_TOE_CONN_AG_CTX_CF1_SHIFT			4
+#define USTORM_TOE_CONN_AG_CTX_PUSH_TIMER_CF_MASK		0x3
+#define USTORM_TOE_CONN_AG_CTX_PUSH_TIMER_CF_SHIFT		6
+	u8 flags1;
+#define USTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_MASK		0x3
+#define USTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_SHIFT		0
+#define USTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_MASK		0x3
+#define USTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_SHIFT		2
+#define USTORM_TOE_CONN_AG_CTX_DQ_CF_MASK			0x3
+#define USTORM_TOE_CONN_AG_CTX_DQ_CF_SHIFT			4
+#define USTORM_TOE_CONN_AG_CTX_CF6_MASK				0x3
+#define USTORM_TOE_CONN_AG_CTX_CF6_SHIFT			6
+	u8 flags2;
+#define USTORM_TOE_CONN_AG_CTX_CF0EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_CF0EN_SHIFT			0
+#define USTORM_TOE_CONN_AG_CTX_CF1EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_CF1EN_SHIFT			1
+#define USTORM_TOE_CONN_AG_CTX_PUSH_TIMER_CF_EN_MASK		0x1
+#define USTORM_TOE_CONN_AG_CTX_PUSH_TIMER_CF_EN_SHIFT		2
+#define USTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_EN_MASK		0x1
+#define USTORM_TOE_CONN_AG_CTX_TIMER_STOP_ALL_EN_SHIFT		3
+#define USTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_EN_MASK		0x1
+#define USTORM_TOE_CONN_AG_CTX_SLOW_PATH_CF_EN_SHIFT		4
+#define USTORM_TOE_CONN_AG_CTX_DQ_CF_EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_DQ_CF_EN_SHIFT			5
+#define USTORM_TOE_CONN_AG_CTX_CF6EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_CF6EN_SHIFT			6
+#define USTORM_TOE_CONN_AG_CTX_RULE0EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE0EN_SHIFT			7
+	u8 flags3;
+#define USTORM_TOE_CONN_AG_CTX_RULE1EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE1EN_SHIFT			0
+#define USTORM_TOE_CONN_AG_CTX_RULE2EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE2EN_SHIFT			1
+#define USTORM_TOE_CONN_AG_CTX_RULE3EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE3EN_SHIFT			2
+#define USTORM_TOE_CONN_AG_CTX_RULE4EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE4EN_SHIFT			3
+#define USTORM_TOE_CONN_AG_CTX_RULE5EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE5EN_SHIFT			4
+#define USTORM_TOE_CONN_AG_CTX_RULE6EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE6EN_SHIFT			5
+#define USTORM_TOE_CONN_AG_CTX_RULE7EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE7EN_SHIFT			6
+#define USTORM_TOE_CONN_AG_CTX_RULE8EN_MASK			0x1
+#define USTORM_TOE_CONN_AG_CTX_RULE8EN_SHIFT			7
+	u8 byte2;
+	u8 byte3;
+	__le16 word0;
+	__le16 word1;
+	__le32 reg0;
+	__le32 reg1;
+	__le32 reg2;
+	__le32 reg3;
+	__le16 word2;
+	__le16 word3;
+};
+
+/* The toe storm context of Tstorm */
+struct tstorm_toe_conn_st_ctx {
+	__le32 reserved[16];
+};
+
+/* The toe storm context of Ustorm */
+struct ustorm_toe_conn_st_ctx {
+	__le32 reserved[52];
+};
+
+/* toe connection context */
+struct toe_conn_context {
+	struct ystorm_toe_conn_st_ctx ystorm_st_context;
+	struct pstorm_toe_conn_st_ctx pstorm_st_context;
+	struct regpair pstorm_st_padding[2];
+	struct xstorm_toe_conn_st_ctx xstorm_st_context;
+	struct regpair xstorm_st_padding[2];
+	struct ystorm_toe_conn_ag_ctx ystorm_ag_context;
+	struct xstorm_toe_conn_ag_ctx xstorm_ag_context;
+	struct tstorm_toe_conn_ag_ctx tstorm_ag_context;
+	struct regpair tstorm_ag_padding[2];
+	struct timers_context timer_context;
+	struct ustorm_toe_conn_ag_ctx ustorm_ag_context;
+	struct tstorm_toe_conn_st_ctx tstorm_st_context;
+	struct mstorm_toe_conn_st_ctx mstorm_st_context;
+	struct ustorm_toe_conn_st_ctx ustorm_st_context;
+};
+
+/* toe init ramrod header */
+struct toe_init_ramrod_header {
+	u8 first_rss;
+	u8 num_rss;
+	u8 reserved[6];
+};
+
+/* toe pf init parameters */
+struct toe_pf_init_params {
+	__le32 push_timeout;
+	__le16 grq_buffer_size;
+	__le16 grq_sb_id;
+	u8 grq_sb_index;
+	u8 max_seg_retransmit;
+	u8 doubt_reachability;
+	u8 ll2_rx_queue_id;
+	__le16 grq_fetch_threshold;
+	u8 reserved1[2];
+	struct regpair grq_page_addr;
+};
+
+/* toe tss parameters */
+struct toe_tss_params {
+	struct regpair curr_page_addr;
+	struct regpair next_page_addr;
+	u8 reserved0;
+	u8 status_block_index;
+	__le16 status_block_id;
+	__le16 reserved1[2];
+};
+
+/* toe rss parameters */
+struct toe_rss_params {
+	struct regpair curr_page_addr;
+	struct regpair next_page_addr;
+	u8 reserved0;
+	u8 status_block_index;
+	__le16 status_block_id;
+	__le16 reserved1[2];
+};
+
+/* toe init ramrod data */
+struct toe_init_ramrod_data {
+	struct toe_init_ramrod_header hdr;
+	struct tcp_init_params tcp_params;
+	struct toe_pf_init_params pf_params;
+	struct toe_tss_params tss_params[TOE_TX_MAX_TSS_CHAINS];
+	struct toe_rss_params rss_params[TOE_RX_MAX_RSS_CHAINS];
+};
+
+/* toe offload parameters */
+struct toe_offload_params {
+	struct regpair tx_bd_page_addr;
+	struct regpair tx_app_page_addr;
+	__le32 more_to_send_seq;
+	__le16 rcv_indication_size;
+	u8 rss_tss_id;
+	u8 ignore_grq_push;
+	struct regpair rx_db_data_ptr;
+};
+
+/* TOE offload ramrod data - DMAed by firmware */
+struct toe_offload_ramrod_data {
+	struct tcp_offload_params tcp_ofld_params;
+	struct toe_offload_params toe_ofld_params;
+};
+
+/* TOE ramrod command IDs */
+enum toe_ramrod_cmd_id {
+	TOE_RAMROD_UNUSED,
+	TOE_RAMROD_FUNC_INIT,
+	TOE_RAMROD_INITATE_OFFLOAD,
+	TOE_RAMROD_FUNC_CLOSE,
+	TOE_RAMROD_SEARCHER_DELETE,
+	TOE_RAMROD_TERMINATE,
+	TOE_RAMROD_QUERY,
+	TOE_RAMROD_UPDATE,
+	TOE_RAMROD_EMPTY,
+	TOE_RAMROD_RESET_SEND,
+	TOE_RAMROD_INVALIDATE,
+	MAX_TOE_RAMROD_CMD_ID
+};
+
+/* Toe RQ buffer descriptor */
+struct toe_rx_bd {
+	struct regpair addr;
+	__le16 size;
+	__le16 flags;
+#define TOE_RX_BD_START_MASK		0x1
+#define TOE_RX_BD_START_SHIFT		0
+#define TOE_RX_BD_END_MASK		0x1
+#define TOE_RX_BD_END_SHIFT		1
+#define TOE_RX_BD_NO_PUSH_MASK		0x1
+#define TOE_RX_BD_NO_PUSH_SHIFT		2
+#define TOE_RX_BD_SPLIT_MASK		0x1
+#define TOE_RX_BD_SPLIT_SHIFT		3
+#define TOE_RX_BD_RESERVED0_MASK	0xFFF
+#define TOE_RX_BD_RESERVED0_SHIFT	4
+	__le32 reserved1;
+};
+
+/* TOE RX completion queue opcodes (opcode 0 is illegal) */
+enum toe_rx_cmp_opcode {
+	TOE_RX_CMP_OPCODE_GA = 1,
+	TOE_RX_CMP_OPCODE_GR = 2,
+	TOE_RX_CMP_OPCODE_GNI = 3,
+	TOE_RX_CMP_OPCODE_GAIR = 4,
+	TOE_RX_CMP_OPCODE_GAIL = 5,
+	TOE_RX_CMP_OPCODE_GRI = 6,
+	TOE_RX_CMP_OPCODE_GJ = 7,
+	TOE_RX_CMP_OPCODE_DGI = 8,
+	TOE_RX_CMP_OPCODE_CMP = 9,
+	TOE_RX_CMP_OPCODE_REL = 10,
+	TOE_RX_CMP_OPCODE_SKP = 11,
+	TOE_RX_CMP_OPCODE_URG = 12,
+	TOE_RX_CMP_OPCODE_RT_TO = 13,
+	TOE_RX_CMP_OPCODE_KA_TO = 14,
+	TOE_RX_CMP_OPCODE_MAX_RT = 15,
+	TOE_RX_CMP_OPCODE_DBT_RE = 16,
+	TOE_RX_CMP_OPCODE_SYN = 17,
+	TOE_RX_CMP_OPCODE_OPT_ERR = 18,
+	TOE_RX_CMP_OPCODE_FW2_TO = 19,
+	TOE_RX_CMP_OPCODE_2WY_CLS = 20,
+	TOE_RX_CMP_OPCODE_RST_RCV = 21,
+	TOE_RX_CMP_OPCODE_FIN_RCV = 22,
+	TOE_RX_CMP_OPCODE_FIN_UPL = 23,
+	TOE_RX_CMP_OPCODE_INIT = 32,
+	TOE_RX_CMP_OPCODE_RSS_UPDATE = 33,
+	TOE_RX_CMP_OPCODE_CLOSE = 34,
+	TOE_RX_CMP_OPCODE_INITIATE_OFFLOAD = 80,
+	TOE_RX_CMP_OPCODE_SEARCHER_DELETE = 81,
+	TOE_RX_CMP_OPCODE_TERMINATE = 82,
+	TOE_RX_CMP_OPCODE_QUERY = 83,
+	TOE_RX_CMP_OPCODE_RESET_SEND = 84,
+	TOE_RX_CMP_OPCODE_INVALIDATE = 85,
+	TOE_RX_CMP_OPCODE_EMPTY = 86,
+	TOE_RX_CMP_OPCODE_UPDATE = 87,
+	MAX_TOE_RX_CMP_OPCODE
+};
+
+/* TOE rx ooo completion data */
+struct toe_rx_cqe_ooo_params {
+	__le32 nbytes;
+	__le16 grq_buff_id;
+	u8 isle_num;
+	u8 reserved0;
+};
+
+/* TOE rx in order completion data */
+struct toe_rx_cqe_in_order_params {
+	__le32 nbytes;
+	__le16 grq_buff_id;
+	__le16 reserved1;
+};
+
+/* Union for TOE rx completion data */
+union toe_rx_cqe_data_union {
+	struct toe_rx_cqe_ooo_params ooo_params;
+	struct toe_rx_cqe_in_order_params in_order_params;
+	struct regpair raw_data;
+};
+
+/* TOE rx completion element */
+struct toe_rx_cqe {
+	__le16 icid;
+	u8 completion_opcode;
+	u8 reserved0;
+	__le32 reserved1;
+	union toe_rx_cqe_data_union data;
+};
+
+/* toe RX doorbel data */
+struct toe_rx_db_data {
+	__le32 local_adv_wnd_seq;
+	__le32 reserved[3];
+};
+
+/* Toe GRQ buffer descriptor */
+struct toe_rx_grq_bd {
+	struct regpair addr;
+	__le16 buff_id;
+	__le16 reserved0;
+	__le32 reserved1;
+};
+
+/* Toe transmission application buffer descriptor */
+struct toe_tx_app_buff_desc {
+	__le32 next_buffer_start_seq;
+	__le32 reserved;
+};
+
+/* Toe transmission application buffer descriptor page pointer */
+struct toe_tx_app_buff_page_pointer {
+	struct regpair next_page_addr;
+};
+
+/* Toe transmission buffer descriptor */
+struct toe_tx_bd {
+	struct regpair addr;
+	__le16 size;
+	__le16 flags;
+#define TOE_TX_BD_PUSH_MASK		0x1
+#define TOE_TX_BD_PUSH_SHIFT		0
+#define TOE_TX_BD_NOTIFY_MASK		0x1
+#define TOE_TX_BD_NOTIFY_SHIFT		1
+#define TOE_TX_BD_LARGE_IO_MASK		0x1
+#define TOE_TX_BD_LARGE_IO_SHIFT	2
+#define TOE_TX_BD_BD_CONS_MASK		0x1FFF
+#define TOE_TX_BD_BD_CONS_SHIFT		3
+	__le32 next_bd_start_seq;
+};
+
+/* TOE completion opcodes */
+enum toe_tx_cmp_opcode {
+	TOE_TX_CMP_OPCODE_DATA,
+	TOE_TX_CMP_OPCODE_TERMINATE,
+	TOE_TX_CMP_OPCODE_EMPTY,
+	TOE_TX_CMP_OPCODE_RESET_SEND,
+	TOE_TX_CMP_OPCODE_INVALIDATE,
+	TOE_TX_CMP_OPCODE_RST_RCV,
+	MAX_TOE_TX_CMP_OPCODE
+};
+
+/* Toe transmission completion element */
+struct toe_tx_cqe {
+	__le16 icid;
+	u8 opcode;
+	u8 reserved;
+	__le32 size;
+};
+
+/* Toe transmission page pointer bd */
+struct toe_tx_page_pointer_bd {
+	struct regpair next_page_addr;
+	struct regpair prev_page_addr;
+};
+
+/* Toe transmission completion element page pointer */
+struct toe_tx_page_pointer_cqe {
+	struct regpair next_page_addr;
+};
+
+/* toe update parameters */
+struct toe_update_params {
+	__le16 flags;
+#define TOE_UPDATE_PARAMS_RCV_INDICATION_SIZE_CHANGED_MASK	0x1
+#define TOE_UPDATE_PARAMS_RCV_INDICATION_SIZE_CHANGED_SHIFT	0
+#define TOE_UPDATE_PARAMS_RESERVED_MASK				0x7FFF
+#define TOE_UPDATE_PARAMS_RESERVED_SHIFT			1
+	__le16 rcv_indication_size;
+	__le16 reserved1[2];
+};
+
+/* TOE update ramrod data - DMAed by firmware */
+struct toe_update_ramrod_data {
+	struct tcp_update_params tcp_upd_params;
+	struct toe_update_params toe_upd_params;
+};
+
+struct mstorm_toe_conn_ag_ctx {
+	u8 byte0;
+	u8 byte1;
+	u8 flags0;
+#define MSTORM_TOE_CONN_AG_CTX_BIT0_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_BIT0_SHIFT	0
+#define MSTORM_TOE_CONN_AG_CTX_BIT1_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_BIT1_SHIFT	1
+#define MSTORM_TOE_CONN_AG_CTX_CF0_MASK		0x3
+#define MSTORM_TOE_CONN_AG_CTX_CF0_SHIFT	2
+#define MSTORM_TOE_CONN_AG_CTX_CF1_MASK		0x3
+#define MSTORM_TOE_CONN_AG_CTX_CF1_SHIFT	4
+#define MSTORM_TOE_CONN_AG_CTX_CF2_MASK		0x3
+#define MSTORM_TOE_CONN_AG_CTX_CF2_SHIFT	6
+	u8 flags1;
+#define MSTORM_TOE_CONN_AG_CTX_CF0EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_CF0EN_SHIFT	0
+#define MSTORM_TOE_CONN_AG_CTX_CF1EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_CF1EN_SHIFT	1
+#define MSTORM_TOE_CONN_AG_CTX_CF2EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_CF2EN_SHIFT	2
+#define MSTORM_TOE_CONN_AG_CTX_RULE0EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_RULE0EN_SHIFT	3
+#define MSTORM_TOE_CONN_AG_CTX_RULE1EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_RULE1EN_SHIFT	4
+#define MSTORM_TOE_CONN_AG_CTX_RULE2EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_RULE2EN_SHIFT	5
+#define MSTORM_TOE_CONN_AG_CTX_RULE3EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_RULE3EN_SHIFT	6
+#define MSTORM_TOE_CONN_AG_CTX_RULE4EN_MASK	0x1
+#define MSTORM_TOE_CONN_AG_CTX_RULE4EN_SHIFT	7
+	__le16 word0;
+	__le16 word1;
+	__le32 reg0;
+	__le32 reg1;
+};
+
+/* TOE doorbell data */
+struct toe_db_data {
+	u8 params;
+#define TOE_DB_DATA_DEST_MASK			0x3
+#define TOE_DB_DATA_DEST_SHIFT			0
+#define TOE_DB_DATA_AGG_CMD_MASK		0x3
+#define TOE_DB_DATA_AGG_CMD_SHIFT		2
+#define TOE_DB_DATA_BYPASS_EN_MASK		0x1
+#define TOE_DB_DATA_BYPASS_EN_SHIFT		4
+#define TOE_DB_DATA_RESERVED_MASK		0x1
+#define TOE_DB_DATA_RESERVED_SHIFT		5
+#define TOE_DB_DATA_AGG_VAL_SEL_MASK		0x3
+#define TOE_DB_DATA_AGG_VAL_SEL_SHIFT		6
+	u8 agg_flags;
+	__le16 bd_prod;
+};
+
 /* rdma function init ramrod data */
 struct rdma_close_func_ramrod_data {
 	u8 cnq_start_offset;
@@ -5148,6 +6150,8 @@ enum rdma_event_opcode {
 	RDMA_EVENT_CREATE_SRQ,
 	RDMA_EVENT_MODIFY_SRQ,
 	RDMA_EVENT_DESTROY_SRQ,
+	RDMA_EVENT_START_NAMESPACE_TRACKING,
+	RDMA_EVENT_STOP_NAMESPACE_TRACKING,
 	MAX_RDMA_EVENT_OPCODE
 };
 
@@ -5172,18 +6176,33 @@ struct rdma_init_func_hdr {
 	u8 relaxed_ordering;
 	__le16 first_reg_srq_id;
 	__le32 reg_srq_base_addr;
-	u8 searcher_mode;
-	u8 pvrdma_mode;
+	u8 flags;
+#define RDMA_INIT_FUNC_HDR_SEARCHER_MODE_MASK		0x1
+#define RDMA_INIT_FUNC_HDR_SEARCHER_MODE_SHIFT		0
+#define RDMA_INIT_FUNC_HDR_PVRDMA_MODE_MASK		0x1
+#define RDMA_INIT_FUNC_HDR_PVRDMA_MODE_SHIFT		1
+#define RDMA_INIT_FUNC_HDR_DPT_MODE_MASK		0x1
+#define RDMA_INIT_FUNC_HDR_DPT_MODE_SHIFT		2
+#define RDMA_INIT_FUNC_HDR_RESERVED0_MASK		0x1F
+#define RDMA_INIT_FUNC_HDR_RESERVED0_SHIFT		3
+	u8 dpt_byte_threshold_log;
+	u8 dpt_common_queue_id;
 	u8 max_num_ns_log;
-	u8 reserved;
 };
 
 /* rdma function init ramrod data */
 struct rdma_init_func_ramrod_data {
 	struct rdma_init_func_hdr params_header;
+	struct rdma_cnq_params dptq_params;
 	struct rdma_cnq_params cnq_params[NUM_OF_GLOBAL_QUEUES];
 };
 
+/* rdma namespace tracking ramrod data */
+struct rdma_namespace_tracking_ramrod_data {
+	u8 name_space;
+	u8 reserved[7];
+};
+
 /* RDMA ramrod command IDs */
 enum rdma_ramrod_cmd_id {
 	RDMA_RAMROD_UNUSED,
@@ -5197,6 +6216,8 @@ enum rdma_ramrod_cmd_id {
 	RDMA_RAMROD_CREATE_SRQ,
 	RDMA_RAMROD_MODIFY_SRQ,
 	RDMA_RAMROD_DESTROY_SRQ,
+	RDMA_RAMROD_START_NS_TRACKING,
+	RDMA_RAMROD_STOP_NS_TRACKING,
 	MAX_RDMA_RAMROD_CMD_ID
 };
 
@@ -5918,8 +6939,10 @@ struct roce_create_qp_req_ramrod_data {
 #define ROCE_CREATE_QP_REQ_RAMROD_DATA_EDPM_MODE_SHIFT			0
 #define ROCE_CREATE_QP_REQ_RAMROD_DATA_VF_ID_VALID_MASK			0x1
 #define ROCE_CREATE_QP_REQ_RAMROD_DATA_VF_ID_VALID_SHIFT		1
-#define ROCE_CREATE_QP_REQ_RAMROD_DATA_RESERVED_MASK			0x3F
-#define ROCE_CREATE_QP_REQ_RAMROD_DATA_RESERVED_SHIFT			2
+#define ROCE_CREATE_QP_REQ_RAMROD_DATA_FORCE_LB_MASK			0x1
+#define ROCE_CREATE_QP_REQ_RAMROD_DATA_FORCE_LB_SHIFT			2
+#define ROCE_CREATE_QP_REQ_RAMROD_DATA_RESERVED_MASK			0x1F
+#define ROCE_CREATE_QP_REQ_RAMROD_DATA_RESERVED_SHIFT			3
 	u8 name_space;
 	u8 reserved3[3];
 	__le16 regular_latency_phy_queue;
@@ -5951,8 +6974,10 @@ struct roce_create_qp_resp_ramrod_data {
 #define ROCE_CREATE_QP_RESP_RAMROD_DATA_XRC_FLAG_SHIFT            16
 #define ROCE_CREATE_QP_RESP_RAMROD_DATA_VF_ID_VALID_MASK	0x1
 #define ROCE_CREATE_QP_RESP_RAMROD_DATA_VF_ID_VALID_SHIFT	17
-#define ROCE_CREATE_QP_RESP_RAMROD_DATA_RESERVED_MASK		0x3FFF
-#define ROCE_CREATE_QP_RESP_RAMROD_DATA_RESERVED_SHIFT		18
+#define ROCE_CREATE_QP_RESP_RAMROD_DATA_FORCE_LB_MASK			0x1
+#define ROCE_CREATE_QP_RESP_RAMROD_DATA_FORCE_LB_SHIFT			18
+#define ROCE_CREATE_QP_RESP_RAMROD_DATA_RESERVED_MASK			0x1FFF
+#define ROCE_CREATE_QP_RESP_RAMROD_DATA_RESERVED_SHIFT			19
 	__le16 xrc_domain;
 	u8 max_ird;
 	u8 traffic_class;
@@ -5989,10 +7014,85 @@ struct roce_create_qp_resp_ramrod_data {
 	u8 reserved3[3];
 };
 
+/* RoCE Create Suspended qp requester runtime ramrod data */
+struct roce_create_suspended_qp_req_runtime_ramrod_data {
+	__le32 flags;
+#define ROCE_CREATE_SUSPENDED_QP_REQ_RUNTIME_RAMROD_DATA_ERR_FLG_MASK 0x1
+#define ROCE_CREATE_SUSPENDED_QP_REQ_RUNTIME_RAMROD_DATA_ERR_FLG_SHIFT 0
+#define ROCE_CREATE_SUSPENDED_QP_REQ_RUNTIME_RAMROD_DATA_RESERVED0_MASK \
+								 0x7FFFFFFF
+#define ROCE_CREATE_SUSPENDED_QP_REQ_RUNTIME_RAMROD_DATA_RESERVED0_SHIFT 1
+	__le32 send_msg_psn;
+	__le32 inflight_sends;
+	__le32 ssn;
+};
+
+/* RoCE Create Suspended QP requester ramrod data */
+struct roce_create_suspended_qp_req_ramrod_data {
+	struct roce_create_qp_req_ramrod_data qp_params;
+	struct roce_create_suspended_qp_req_runtime_ramrod_data
+	 qp_runtime_params;
+};
+
+/* RoCE Create Suspended QP responder runtime params */
+struct roce_create_suspended_qp_resp_runtime_params {
+	__le32 flags;
+#define ROCE_CREATE_SUSPENDED_QP_RESP_RUNTIME_PARAMS_ERR_FLG_MASK 0x1
+#define ROCE_CREATE_SUSPENDED_QP_RESP_RUNTIME_PARAMS_ERR_FLG_SHIFT 0
+#define ROCE_CREATE_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RDMA_ACTIVE_MASK 0x1
+#define ROCE_CREATE_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RDMA_ACTIVE_SHIFT 1
+#define ROCE_CREATE_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RESERVED0_MASK 0x3FFFFFFF
+#define ROCE_CREATE_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RESERVED0_SHIFT 2
+	__le32 receive_msg_psn;
+	__le32 inflight_receives;
+	__le32 rmsn;
+	__le32 rdma_key;
+	struct regpair rdma_va;
+	__le32 rdma_length;
+	__le32 num_rdb_entries;
+	__le32 resreved;
+};
+
+/* RoCE RDB array entry */
+struct roce_resp_qp_rdb_entry {
+	struct regpair atomic_data;
+	struct regpair va;
+	__le32 psn;
+	__le32 rkey;
+	__le32 byte_count;
+	u8 op_type;
+	u8 reserved[3];
+};
+
+/* RoCE Create Suspended QP responder runtime ramrod data */
+struct roce_create_suspended_qp_resp_runtime_ramrod_data {
+	struct roce_create_suspended_qp_resp_runtime_params params;
+	struct roce_resp_qp_rdb_entry
+	 rdb_array_entries[RDMA_MAX_IRQ_ELEMS_IN_PAGE];
+};
+
+/* RoCE Create Suspended QP responder ramrod data */
+struct roce_create_suspended_qp_resp_ramrod_data {
+	struct roce_create_qp_resp_ramrod_data
+	 qp_params;
+	struct roce_create_suspended_qp_resp_runtime_ramrod_data
+	 qp_runtime_params;
+};
+
+/* RoCE create ud qp ramrod data */
+struct roce_create_ud_qp_ramrod_data {
+	__le16 local_mac_addr[3];
+	__le16 vlan_id;
+	__le32 src_qp_id;
+	u8 name_space;
+	u8 reserved[3];
+};
+
 /* roce DCQCN received statistics */
 struct roce_dcqcn_received_stats {
 	struct regpair ecn_pkt_rcv;
 	struct regpair cnp_pkt_rcv;
+	struct regpair cnp_pkt_reject;
 };
 
 /* roce DCQCN sent statistics */
@@ -6024,6 +7124,12 @@ struct roce_destroy_qp_resp_ramrod_data {
 	__le32 reserved;
 };
 
+/* RoCE destroy ud qp ramrod data */
+struct roce_destroy_ud_qp_ramrod_data {
+	__le32 src_qp_id;
+	__le32 reserved;
+};
+
 /* roce error statistics */
 struct roce_error_stats {
 	__le32 resp_remote_access_errors;
@@ -6046,13 +7152,21 @@ struct roce_events_stats {
 
 /* roce slow path EQ cmd IDs */
 enum roce_event_opcode {
-	ROCE_EVENT_CREATE_QP = 11,
+	ROCE_EVENT_CREATE_QP = 13,
 	ROCE_EVENT_MODIFY_QP,
 	ROCE_EVENT_QUERY_QP,
 	ROCE_EVENT_DESTROY_QP,
 	ROCE_EVENT_CREATE_UD_QP,
 	ROCE_EVENT_DESTROY_UD_QP,
 	ROCE_EVENT_FUNC_UPDATE,
+	ROCE_EVENT_SUSPEND_QP,
+	ROCE_EVENT_QUERY_SUSPENDED_QP,
+	ROCE_EVENT_CREATE_SUSPENDED_QP,
+	ROCE_EVENT_RESUME_QP,
+	ROCE_EVENT_SUSPEND_UD_QP,
+	ROCE_EVENT_RESUME_UD_QP,
+	ROCE_EVENT_CREATE_SUSPENDED_UD_QP,
+	ROCE_EVENT_FLUSH_DPT_QP,
 	MAX_ROCE_EVENT_OPCODE
 };
 
@@ -6080,6 +7194,18 @@ struct roce_init_func_ramrod_data {
 	struct roce_init_func_params roce;
 };
 
+/* roce_ll2_cqe_data */
+struct roce_ll2_cqe_data {
+	u8 name_space;
+	u8 flags;
+#define ROCE_LL2_CQE_DATA_QP_SUSPENDED_MASK	0x1
+#define ROCE_LL2_CQE_DATA_QP_SUSPENDED_SHIFT	0
+#define ROCE_LL2_CQE_DATA_RESERVED0_MASK	0x7F
+#define ROCE_LL2_CQE_DATA_RESERVED0_SHIFT	1
+	u8 reserved1[2];
+	__le32 cid;
+};
+
 /* roce modify qp requester ramrod data */
 struct roce_modify_qp_req_ramrod_data {
 	__le16 flags;
@@ -6107,8 +7233,10 @@ struct roce_modify_qp_req_ramrod_data {
 #define ROCE_MODIFY_QP_REQ_RAMROD_DATA_PRI_SHIFT			10
 #define ROCE_MODIFY_QP_REQ_RAMROD_DATA_PHYSICAL_QUEUE_FLG_MASK		0x1
 #define ROCE_MODIFY_QP_REQ_RAMROD_DATA_PHYSICAL_QUEUE_FLG_SHIFT		13
-#define ROCE_MODIFY_QP_REQ_RAMROD_DATA_RESERVED1_MASK			0x3
-#define ROCE_MODIFY_QP_REQ_RAMROD_DATA_RESERVED1_SHIFT			14
+#define ROCE_MODIFY_QP_REQ_RAMROD_DATA_FORCE_LB_MASK			0x1
+#define ROCE_MODIFY_QP_REQ_RAMROD_DATA_FORCE_LB_SHIFT			14
+#define ROCE_MODIFY_QP_REQ_RAMROD_DATA_RESERVED1_MASK			0x1
+#define ROCE_MODIFY_QP_REQ_RAMROD_DATA_RESERVED1_SHIFT			15
 	u8 fields;
 #define ROCE_MODIFY_QP_REQ_RAMROD_DATA_ERR_RETRY_CNT_MASK	0xF
 #define ROCE_MODIFY_QP_REQ_RAMROD_DATA_ERR_RETRY_CNT_SHIFT	0
@@ -6154,8 +7282,10 @@ struct roce_modify_qp_resp_ramrod_data {
 #define ROCE_MODIFY_QP_RESP_RAMROD_DATA_RDMA_OPS_EN_FLG_SHIFT		9
 #define ROCE_MODIFY_QP_RESP_RAMROD_DATA_PHYSICAL_QUEUE_FLG_MASK		0x1
 #define ROCE_MODIFY_QP_RESP_RAMROD_DATA_PHYSICAL_QUEUE_FLG_SHIFT	10
-#define ROCE_MODIFY_QP_RESP_RAMROD_DATA_RESERVED1_MASK			0x1F
-#define ROCE_MODIFY_QP_RESP_RAMROD_DATA_RESERVED1_SHIFT			11
+#define ROCE_MODIFY_QP_RESP_RAMROD_DATA_FORCE_LB_MASK			0x1
+#define ROCE_MODIFY_QP_RESP_RAMROD_DATA_FORCE_LB_SHIFT			11
+#define ROCE_MODIFY_QP_RESP_RAMROD_DATA_RESERVED1_MASK			0xF
+#define ROCE_MODIFY_QP_RESP_RAMROD_DATA_RESERVED1_SHIFT			12
 	u8 fields;
 #define ROCE_MODIFY_QP_RESP_RAMROD_DATA_PRI_MASK		0x7
 #define ROCE_MODIFY_QP_RESP_RAMROD_DATA_PRI_SHIFT		0
@@ -6206,18 +7336,84 @@ struct roce_query_qp_resp_ramrod_data {
 	struct regpair output_params_addr;
 };
 
+/* RoCE Query Suspended QP requester output params */
+struct roce_query_suspended_qp_req_output_params {
+	__le32 psn;
+	__le32 flags;
+#define ROCE_QUERY_SUSPENDED_QP_REQ_OUTPUT_PARAMS_ERR_FLG_MASK		0x1
+#define ROCE_QUERY_SUSPENDED_QP_REQ_OUTPUT_PARAMS_ERR_FLG_SHIFT		0
+#define ROCE_QUERY_SUSPENDED_QP_REQ_OUTPUT_PARAMS_RESERVED0_MASK 0x7FFFFFFF
+#define ROCE_QUERY_SUSPENDED_QP_REQ_OUTPUT_PARAMS_RESERVED0_SHIFT	1
+	__le32 send_msg_psn;
+	__le32 inflight_sends;
+	__le32 ssn;
+	__le32 reserved;
+};
+
+/* RoCE Query Suspended QP requester ramrod data */
+struct roce_query_suspended_qp_req_ramrod_data {
+	struct regpair output_params_addr;
+};
+
+/* RoCE Query Suspended QP responder runtime params */
+struct roce_query_suspended_qp_resp_runtime_params {
+	__le32 psn;
+	__le32 flags;
+#define ROCE_QUERY_SUSPENDED_QP_RESP_RUNTIME_PARAMS_ERR_FLG_MASK 0x1
+#define ROCE_QUERY_SUSPENDED_QP_RESP_RUNTIME_PARAMS_ERR_FLG_SHIFT 0
+#define ROCE_QUERY_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RDMA_ACTIVE_MASK 0x1
+#define ROCE_QUERY_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RDMA_ACTIVE_SHIFT 1
+#define ROCE_QUERY_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RESERVED0_MASK 0x3FFFFFFF
+#define ROCE_QUERY_SUSPENDED_QP_RESP_RUNTIME_PARAMS_RESERVED0_SHIFT 2
+	__le32 receive_msg_psn;
+	__le32 inflight_receives;
+	__le32 rmsn;
+	__le32 rdma_key;
+	struct regpair rdma_va;
+	__le32 rdma_length;
+	__le32 num_rdb_entries;
+};
+
+/* RoCE Query Suspended QP responder output params */
+struct roce_query_suspended_qp_resp_output_params {
+	struct roce_query_suspended_qp_resp_runtime_params runtime_params;
+	struct roce_resp_qp_rdb_entry
+	 rdb_array_entries[RDMA_MAX_IRQ_ELEMS_IN_PAGE];
+};
+
+/* RoCE Query Suspended QP responder ramrod data */
+struct roce_query_suspended_qp_resp_ramrod_data {
+	struct regpair output_params_addr;
+};
+
 /* ROCE ramrod command IDs */
 enum roce_ramrod_cmd_id {
-	ROCE_RAMROD_CREATE_QP = 11,
+	ROCE_RAMROD_CREATE_QP = 13,
 	ROCE_RAMROD_MODIFY_QP,
 	ROCE_RAMROD_QUERY_QP,
 	ROCE_RAMROD_DESTROY_QP,
 	ROCE_RAMROD_CREATE_UD_QP,
 	ROCE_RAMROD_DESTROY_UD_QP,
 	ROCE_RAMROD_FUNC_UPDATE,
+	ROCE_RAMROD_SUSPEND_QP,
+	ROCE_RAMROD_QUERY_SUSPENDED_QP,
+	ROCE_RAMROD_CREATE_SUSPENDED_QP,
+	ROCE_RAMROD_RESUME_QP,
+	ROCE_RAMROD_SUSPEND_UD_QP,
+	ROCE_RAMROD_RESUME_UD_QP,
+	ROCE_RAMROD_CREATE_SUSPENDED_UD_QP,
+	ROCE_RAMROD_FLUSH_DPT_QP,
 	MAX_ROCE_RAMROD_CMD_ID
 };
 
+/* ROCE RDB array entry type */
+enum roce_resp_qp_rdb_entry_type {
+	ROCE_QP_RDB_ENTRY_RDMA_RESPONSE = 0,
+	ROCE_QP_RDB_ENTRY_ATOMIC_RESPONSE = 1,
+	ROCE_QP_RDB_ENTRY_INVALID = 2,
+	MAX_ROCE_RESP_QP_RDB_ENTRY_TYPE
+};
+
 /* RoCE func init ramrod data */
 struct roce_update_func_params {
 	u8 cnp_vlan_priority;
@@ -7968,8 +9164,8 @@ enum iwarp_eqe_async_opcode {
 	IWARP_EVENT_TYPE_ASYNC_EXCEPTION_DETECTED,
 	IWARP_EVENT_TYPE_ASYNC_QP_IN_ERROR_STATE,
 	IWARP_EVENT_TYPE_ASYNC_CQ_OVERFLOW,
-	IWARP_EVENT_TYPE_ASYNC_SRQ_EMPTY,
 	IWARP_EVENT_TYPE_ASYNC_SRQ_LIMIT,
+	IWARP_EVENT_TYPE_ASYNC_SRQ_EMPTY,
 	MAX_IWARP_EQE_ASYNC_OPCODE
 };
 
@@ -7987,8 +9183,7 @@ struct iwarp_eqe_data_tcp_async_completion {
 
 /* iWARP completion queue types */
 enum iwarp_eqe_sync_opcode {
-	IWARP_EVENT_TYPE_TCP_OFFLOAD =
-	11,
+	IWARP_EVENT_TYPE_TCP_OFFLOAD = 13,
 	IWARP_EVENT_TYPE_MPA_OFFLOAD,
 	IWARP_EVENT_TYPE_MPA_OFFLOAD_SEND_RTR,
 	IWARP_EVENT_TYPE_CREATE_QP,
@@ -8020,8 +9215,6 @@ enum iwarp_fw_return_code {
 	IWARP_EXCEPTION_DETECTED_LLP_RESET,
 	IWARP_EXCEPTION_DETECTED_IRQ_FULL,
 	IWARP_EXCEPTION_DETECTED_RQ_EMPTY,
-	IWARP_EXCEPTION_DETECTED_SRQ_EMPTY,
-	IWARP_EXCEPTION_DETECTED_SRQ_LIMIT,
 	IWARP_EXCEPTION_DETECTED_LLP_TIMEOUT,
 	IWARP_EXCEPTION_DETECTED_REMOTE_PROTECTION_ERROR,
 	IWARP_EXCEPTION_DETECTED_CQ_OVERFLOW,
@@ -8115,9 +9308,10 @@ struct iwarp_mpa_offload_ramrod_data {
 	struct regpair async_eqe_output_buf;
 	struct regpair handle_for_async;
 	struct regpair shared_queue_addr;
+	__le32 additional_setup_time;
 	__le16 rcv_wnd;
 	u8 stats_counter_id;
-	u8 reserved3[13];
+	u8 reserved3[9];
 };
 
 /* iWARP TCP connection offload params passed by driver to FW */
@@ -8125,11 +9319,13 @@ struct iwarp_offload_params {
 	struct mpa_ulp_buffer incoming_ulp_buffer;
 	struct regpair async_eqe_output_buf;
 	struct regpair handle_for_async;
+	__le32 additional_setup_time;
 	__le16 physical_q0;
 	__le16 physical_q1;
 	u8 stats_counter_id;
 	u8 mpa_mode;
-	u8 reserved[10];
+	u8 src_vport_id;
+	u8 reserved[5];
 };
 
 /* iWARP query QP output params */
@@ -8149,7 +9345,7 @@ struct iwarp_query_qp_ramrod_data {
 
 /* iWARP Ramrod Command IDs */
 enum iwarp_ramrod_cmd_id {
-	IWARP_RAMROD_CMD_ID_TCP_OFFLOAD = 11,
+	IWARP_RAMROD_CMD_ID_TCP_OFFLOAD = 13,
 	IWARP_RAMROD_CMD_ID_MPA_OFFLOAD,
 	IWARP_RAMROD_CMD_ID_MPA_OFFLOAD_SEND_RTR,
 	IWARP_RAMROD_CMD_ID_CREATE_QP,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
index 7dad91049cc0..fb90ad4a9d1f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
@@ -920,7 +920,8 @@ int qed_init_vport_wfq(struct qed_hwfn *p_hwfn,
 }
 
 int qed_init_global_rl(struct qed_hwfn *p_hwfn,
-		       struct qed_ptt *p_ptt, u16 rl_id, u32 rate_limit)
+		       struct qed_ptt *p_ptt, u16 rl_id, u32 rate_limit,
+		       enum init_qm_rl_type vport_rl_type)
 {
 	u32 inc_val;
 
@@ -1645,7 +1646,7 @@ struct phys_mem_desc *qed_fw_overlay_mem_alloc(struct qed_hwfn *p_hwfn,
 
 	/* If memory allocation has failed, free all allocated memory */
 	if (buf_offset < buf_size) {
-		qed_fw_overlay_mem_free(p_hwfn, allocated_mem);
+		qed_fw_overlay_mem_free(p_hwfn, &allocated_mem);
 		return NULL;
 	}
 
@@ -1679,16 +1680,16 @@ void qed_fw_overlay_init_ram(struct qed_hwfn *p_hwfn,
 }
 
 void qed_fw_overlay_mem_free(struct qed_hwfn *p_hwfn,
-			     struct phys_mem_desc *fw_overlay_mem)
+			     struct phys_mem_desc **fw_overlay_mem)
 {
 	u8 storm_id;
 
-	if (!fw_overlay_mem)
+	if (!fw_overlay_mem || !(*fw_overlay_mem))
 		return;
 
 	for (storm_id = 0; storm_id < NUM_STORMS; storm_id++) {
 		struct phys_mem_desc *storm_mem_desc =
-		    (struct phys_mem_desc *)fw_overlay_mem + storm_id;
+		    (struct phys_mem_desc *)*fw_overlay_mem + storm_id;
 
 		/* Free Storm's physical memory */
 		if (storm_mem_desc->virt_addr)
@@ -1699,5 +1700,6 @@ void qed_fw_overlay_mem_free(struct qed_hwfn *p_hwfn,
 	}
 
 	/* Free allocated virtual memory */
-	kfree(fw_overlay_mem);
+	kfree(*fw_overlay_mem);
+	*fw_overlay_mem = NULL;
 }
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 991bf4313da6..9b3850712797 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -38,7 +38,6 @@
 #include "qed_sp.h"
 #include "qed_sriov.h"
 
-
 #define QED_MAX_SGES_NUM 16
 #define CRC32_POLY 0x1edc6f41
 
@@ -1112,7 +1111,6 @@ qed_eth_pf_tx_queue_start(struct qed_hwfn *p_hwfn,
 {
 	int rc;
 
-
 	rc = qed_eth_txq_start_ramrod(p_hwfn, p_cid,
 				      pbl_addr, pbl_size,
 				      qed_get_cm_pq_idx_mcos(p_hwfn, tc));
@@ -2011,7 +2009,7 @@ qed_configure_rfs_ntuple_filter(struct qed_hwfn *p_hwfn,
 				struct qed_spq_comp_cb *p_cb,
 				struct qed_ntuple_filter_params *p_params)
 {
-	struct rx_update_gft_filter_data *p_ramrod = NULL;
+	struct rx_update_gft_filter_ramrod_data *p_ramrod = NULL;
 	struct qed_spq_entry *p_ent = NULL;
 	struct qed_sp_init_data init_data;
 	u16 abs_rx_q_id = 0;
@@ -2032,7 +2030,7 @@ qed_configure_rfs_ntuple_filter(struct qed_hwfn *p_hwfn,
 	}
 
 	rc = qed_sp_init_request(p_hwfn, &p_ent,
-				 ETH_RAMROD_GFT_UPDATE_FILTER,
+				 ETH_RAMROD_RX_UPDATE_GFT_FILTER,
 				 PROTOCOLID_ETH, &init_data);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.h b/drivers/net/ethernet/qlogic/qed/qed_l2.h
index 2ab7f3f0cf6c..a538cf478c14 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.h
@@ -146,7 +146,6 @@ struct qed_sp_vport_start_params {
 int qed_sp_eth_vport_start(struct qed_hwfn *p_hwfn,
 			   struct qed_sp_vport_start_params *p_params);
 
-
 struct qed_filter_accept_flags {
 	u8	update_rx_mode_config;
 	u8	update_tx_mode_config;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp.h b/drivers/net/ethernet/qlogic/qed/qed_sp.h
index c5a38f3c92b0..4fb02a5579ee 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp.h
@@ -23,9 +23,9 @@ enum spq_mode {
 };
 
 struct qed_spq_comp_cb {
-	void	(*function)(struct qed_hwfn *,
-			    void *,
-			    union event_ring_data *,
+	void	(*function)(struct qed_hwfn *p_hwfn,
+			    void *cookie,
+			    union event_ring_data *data,
 			    u8 fw_return_code);
 	void	*cookie;
 };
@@ -53,7 +53,7 @@ union ramrod_data {
 	struct tx_queue_stop_ramrod_data tx_queue_stop;
 	struct vport_start_ramrod_data vport_start;
 	struct vport_stop_ramrod_data vport_stop;
-	struct rx_update_gft_filter_data rx_update_gft;
+	struct rx_update_gft_filter_ramrod_data rx_update_gft;
 	struct vport_update_ramrod_data vport_update;
 	struct core_rx_start_ramrod_data core_rx_queue_start;
 	struct core_rx_stop_ramrod_data core_rx_queue_stop;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
index b4ed54ffef9b..648176dfb871 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
@@ -369,8 +369,12 @@ int qed_sp_pf_start(struct qed_hwfn *p_hwfn,
 		       qed_chain_get_pbl_phys(&p_hwfn->p_eq->chain));
 	page_cnt = (u8)qed_chain_get_page_cnt(&p_hwfn->p_eq->chain);
 	p_ramrod->event_ring_num_pages = page_cnt;
-	DMA_REGPAIR_LE(p_ramrod->consolid_q_pbl_addr,
+
+	/* Place consolidation queue address in ramrod */
+	DMA_REGPAIR_LE(p_ramrod->consolid_q_pbl_base_addr,
 		       qed_chain_get_pbl_phys(&p_hwfn->p_consq->chain));
+	page_cnt = (u8)qed_chain_get_page_cnt(&p_hwfn->p_consq->chain);
+	p_ramrod->consolid_q_num_pages = page_cnt;
 
 	qed_tunn_set_pf_start_params(p_hwfn, p_tunn, &p_ramrod->tunnel_config);
 
@@ -401,8 +405,8 @@ int qed_sp_pf_start(struct qed_hwfn *p_hwfn,
 	if (p_hwfn->cdev->p_iov_info) {
 		struct qed_hw_sriov_info *p_iov = p_hwfn->cdev->p_iov_info;
 
-		p_ramrod->base_vf_id = (u8) p_iov->first_vf_in_pf;
-		p_ramrod->num_vfs = (u8) p_iov->total_vfs;
+		p_ramrod->base_vf_id = (u8)p_iov->first_vf_in_pf;
+		p_ramrod->num_vfs = (u8)p_iov->total_vfs;
 	}
 	p_ramrod->hsi_fp_ver.major_ver_arr[ETH_VER_KEY] = ETH_HSI_VER_MAJOR;
 	p_ramrod->hsi_fp_ver.minor_ver_arr[ETH_VER_KEY] = ETH_HSI_VER_MINOR;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index 8bef53ca7597..65dbc08196b7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -32,8 +32,8 @@
 #include "qed_rdma.h"
 
 /***************************************************************************
-* Structures & Definitions
-***************************************************************************/
+ * Structures & Definitions
+ ***************************************************************************/
 
 #define SPQ_HIGH_PRI_RESERVE_DEFAULT    (1)
 
@@ -43,8 +43,8 @@
 #define SPQ_BLOCK_SLEEP_MS              (5)
 
 /***************************************************************************
-* Blocking Imp. (BLOCK/EBLOCK mode)
-***************************************************************************/
+ * Blocking Imp. (BLOCK/EBLOCK mode)
+ ***************************************************************************/
 static void qed_spq_blocking_cb(struct qed_hwfn *p_hwfn,
 				void *cookie,
 				union event_ring_data *data, u8 fw_return_code)
@@ -150,8 +150,8 @@ static int qed_spq_block(struct qed_hwfn *p_hwfn,
 }
 
 /***************************************************************************
-* SPQ entries inner API
-***************************************************************************/
+ * SPQ entries inner API
+ ***************************************************************************/
 static int qed_spq_fill_entry(struct qed_hwfn *p_hwfn,
 			      struct qed_spq_entry *p_ent)
 {
@@ -185,8 +185,8 @@ static int qed_spq_fill_entry(struct qed_hwfn *p_hwfn,
 }
 
 /***************************************************************************
-* HSI access
-***************************************************************************/
+ * HSI access
+ ***************************************************************************/
 static void qed_spq_hw_initialize(struct qed_hwfn *p_hwfn,
 				  struct qed_spq *p_spq)
 {
@@ -218,13 +218,10 @@ static void qed_spq_hw_initialize(struct qed_hwfn *p_hwfn,
 	physical_q = qed_get_cm_pq_idx(p_hwfn, PQ_FLAGS_LB);
 	p_cxt->xstorm_ag_context.physical_q0 = cpu_to_le16(physical_q);
 
-	p_cxt->xstorm_st_context.spq_base_lo =
+	p_cxt->xstorm_st_context.spq_base_addr.lo =
 		DMA_LO_LE(p_spq->chain.p_phys_addr);
-	p_cxt->xstorm_st_context.spq_base_hi =
+	p_cxt->xstorm_st_context.spq_base_addr.hi =
 		DMA_HI_LE(p_spq->chain.p_phys_addr);
-
-	DMA_REGPAIR_LE(p_cxt->xstorm_st_context.consolid_base_addr,
-		       p_hwfn->p_consq->chain.p_phys_addr);
 }
 
 static int qed_spq_hw_post(struct qed_hwfn *p_hwfn,
@@ -266,8 +263,8 @@ static int qed_spq_hw_post(struct qed_hwfn *p_hwfn,
 }
 
 /***************************************************************************
-* Asynchronous events
-***************************************************************************/
+ * Asynchronous events
+ ***************************************************************************/
 static int
 qed_async_event_completion(struct qed_hwfn *p_hwfn,
 			   struct event_ring_entry *p_eqe)
@@ -312,8 +309,8 @@ qed_spq_unregister_async_cb(struct qed_hwfn *p_hwfn,
 }
 
 /***************************************************************************
-* EQ API
-***************************************************************************/
+ * EQ API
+ ***************************************************************************/
 void qed_eq_prod_update(struct qed_hwfn *p_hwfn, u16 prod)
 {
 	u32 addr = GTT_BAR0_MAP_REG_USDM_RAM +
@@ -434,8 +431,8 @@ void qed_eq_free(struct qed_hwfn *p_hwfn)
 }
 
 /***************************************************************************
-* CQE API - manipulate EQ functionality
-***************************************************************************/
+ * CQE API - manipulate EQ functionality
+ ***************************************************************************/
 static int qed_cqe_completion(struct qed_hwfn *p_hwfn,
 			      struct eth_slow_path_rx_cqe *cqe,
 			      enum protocol_type protocol)
@@ -465,8 +462,8 @@ int qed_eth_cqe_completion(struct qed_hwfn *p_hwfn,
 }
 
 /***************************************************************************
-* Slow hwfn Queue (spq)
-***************************************************************************/
+ * Slow hwfn Queue (spq)
+ ***************************************************************************/
 void qed_spq_setup(struct qed_hwfn *p_hwfn)
 {
 	struct qed_spq *p_spq = p_hwfn->p_spq;
@@ -549,7 +546,7 @@ int qed_spq_alloc(struct qed_hwfn *p_hwfn)
 	int ret;
 
 	/* SPQ struct */
-	p_spq = kzalloc(sizeof(struct qed_spq), GFP_KERNEL);
+	p_spq = kzalloc(sizeof(*p_spq), GFP_KERNEL);
 	if (!p_spq)
 		return -ENOMEM;
 
@@ -677,7 +674,6 @@ static int qed_spq_add_entry(struct qed_hwfn *p_hwfn,
 	struct qed_spq *p_spq = p_hwfn->p_spq;
 
 	if (p_ent->queue == &p_spq->unlimited_pending) {
-
 		if (list_empty(&p_spq->free_pool)) {
 			list_add_tail(&p_ent->list, &p_spq->unlimited_pending);
 			p_spq->unlimited_pending_count++;
@@ -726,8 +722,8 @@ static int qed_spq_add_entry(struct qed_hwfn *p_hwfn,
 }
 
 /***************************************************************************
-* Accessor
-***************************************************************************/
+ * Accessor
+ ***************************************************************************/
 u32 qed_spq_get_cid(struct qed_hwfn *p_hwfn)
 {
 	if (!p_hwfn->p_spq)
@@ -736,8 +732,8 @@ u32 qed_spq_get_cid(struct qed_hwfn *p_hwfn)
 }
 
 /***************************************************************************
-* Posting new Ramrods
-***************************************************************************/
+ * Posting new Ramrods
+ ***************************************************************************/
 static int qed_spq_post_list(struct qed_hwfn *p_hwfn,
 			     struct list_head *head, u32 keep_reserve)
 {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index 2a67b1308fe0..9556a2c4d3a6 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -20,12 +20,13 @@
 #include "qed_sp.h"
 #include "qed_sriov.h"
 #include "qed_vf.h"
-static int qed_sriov_eqe_event(struct qed_hwfn *p_hwfn,
-			       u8 opcode,
-			       __le16 echo,
-			       union event_ring_data *data, u8 fw_return_code);
 static int qed_iov_bulletin_set_mac(struct qed_hwfn *p_hwfn, u8 *mac, int vfid);
 
+static u16 qed_vf_from_entity_id(__le16 entity_id)
+{
+	return le16_to_cpu(entity_id) - MAX_NUM_PFS;
+}
+
 static u8 qed_vf_calculate_legacy(struct qed_vf_info *p_vf)
 {
 	u8 legacy = 0;
@@ -170,8 +171,8 @@ static struct qed_vf_info *qed_iov_get_vf_info(struct qed_hwfn *p_hwfn,
 				  b_enabled_only, false))
 		vf = &p_hwfn->pf_iov_info->vfs_array[relative_vf_id];
 	else
-		DP_ERR(p_hwfn, "qed_iov_get_vf_info: VF[%d] is not enabled\n",
-		       relative_vf_id);
+		DP_ERR(p_hwfn, "%s: VF[%d] is not enabled\n",
+		       __func__, relative_vf_id);
 
 	return vf;
 }
@@ -309,7 +310,7 @@ static int qed_iov_post_vf_bulletin(struct qed_hwfn *p_hwfn,
 	struct qed_dmae_params params;
 	struct qed_vf_info *p_vf;
 
-	p_vf = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	p_vf = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!p_vf)
 		return -EINVAL;
 
@@ -421,7 +422,7 @@ static void qed_iov_setup_vfdb(struct qed_hwfn *p_hwfn)
 	bulletin_p = p_iov_info->bulletins_phys;
 	if (!p_req_virt_addr || !p_reply_virt_addr || !p_bulletin_virt) {
 		DP_ERR(p_hwfn,
-		       "qed_iov_setup_vfdb called without allocating mem first\n");
+		       "%s called without allocating mem first\n", __func__);
 		return;
 	}
 
@@ -465,7 +466,7 @@ static int qed_iov_allocate_vfdb(struct qed_hwfn *p_hwfn)
 	num_vfs = p_hwfn->cdev->p_iov_info->total_vfs;
 
 	DP_VERBOSE(p_hwfn, QED_MSG_IOV,
-		   "qed_iov_allocate_vfdb for %d VFs\n", num_vfs);
+		   "%s for %d VFs\n", __func__, num_vfs);
 
 	/* Allocate PF Mailbox buffer (per-VF) */
 	p_iov_info->mbx_msg_size = sizeof(union vfpf_tlvs) * num_vfs;
@@ -501,10 +502,10 @@ static int qed_iov_allocate_vfdb(struct qed_hwfn *p_hwfn)
 		   QED_MSG_IOV,
 		   "PF's Requests mailbox [%p virt 0x%llx phys],  Response mailbox [%p virt 0x%llx phys] Bulletins [%p virt 0x%llx phys]\n",
 		   p_iov_info->mbx_msg_virt_addr,
-		   (u64) p_iov_info->mbx_msg_phys_addr,
+		   (u64)p_iov_info->mbx_msg_phys_addr,
 		   p_iov_info->mbx_reply_virt_addr,
-		   (u64) p_iov_info->mbx_reply_phys_addr,
-		   p_iov_info->p_bulletins, (u64) p_iov_info->bulletins_phys);
+		   (u64)p_iov_info->mbx_reply_phys_addr,
+		   p_iov_info->p_bulletins, (u64)p_iov_info->bulletins_phys);
 
 	return 0;
 }
@@ -609,7 +610,7 @@ int qed_iov_hw_info(struct qed_hwfn *p_hwfn)
 	if (rc)
 		return rc;
 
-	/* We want PF IOV to be synonemous with the existance of p_iov_info;
+	/* We want PF IOV to be synonemous with the existence of p_iov_info;
 	 * In case the capability is published but there are no VFs, simply
 	 * de-allocate the struct.
 	 */
@@ -715,12 +716,12 @@ static void qed_iov_vf_igu_reset(struct qed_hwfn *p_hwfn,
 	int i;
 
 	/* Set VF masks and configuration - pretend */
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) vf->concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)vf->concrete_fid);
 
 	qed_wr(p_hwfn, p_ptt, IGU_REG_STATISTIC_NUM_VF_MSG_SENT, 0);
 
 	/* unpretend */
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) p_hwfn->hw_info.concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)p_hwfn->hw_info.concrete_fid);
 
 	/* iterate over all queues, clear sb consumer */
 	for (i = 0; i < vf->num_sbs; i++)
@@ -735,7 +736,7 @@ static void qed_iov_vf_igu_set_int(struct qed_hwfn *p_hwfn,
 {
 	u32 igu_vf_conf;
 
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) vf->concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)vf->concrete_fid);
 
 	igu_vf_conf = qed_rd(p_hwfn, p_ptt, IGU_REG_VF_CONFIGURATION);
 
@@ -747,7 +748,7 @@ static void qed_iov_vf_igu_set_int(struct qed_hwfn *p_hwfn,
 	qed_wr(p_hwfn, p_ptt, IGU_REG_VF_CONFIGURATION, igu_vf_conf);
 
 	/* unpretend */
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) p_hwfn->hw_info.concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)p_hwfn->hw_info.concrete_fid);
 }
 
 static int
@@ -808,7 +809,7 @@ static int qed_iov_enable_vf_access(struct qed_hwfn *p_hwfn,
 	if (rc)
 		return rc;
 
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) vf->concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)vf->concrete_fid);
 
 	SET_FIELD(igu_vf_conf, IGU_VF_CONF_PARENT, p_hwfn->rel_pf_id);
 	STORE_RT_REG(p_hwfn, IGU_REG_VF_CONFIGURATION_RT_OFFSET, igu_vf_conf);
@@ -817,7 +818,7 @@ static int qed_iov_enable_vf_access(struct qed_hwfn *p_hwfn,
 		     p_hwfn->hw_info.hw_mode);
 
 	/* unpretend */
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) p_hwfn->hw_info.concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)p_hwfn->hw_info.concrete_fid);
 
 	vf->state = VF_FREE;
 
@@ -905,7 +906,7 @@ static u8 qed_iov_alloc_vf_igu_sbs(struct qed_hwfn *p_hwfn,
 				  p_block->igu_sb_id * sizeof(u64), 2, NULL);
 	}
 
-	vf->num_sbs = (u8) num_rx_queues;
+	vf->num_sbs = (u8)num_rx_queues;
 
 	return vf->num_sbs;
 }
@@ -989,7 +990,7 @@ static int qed_iov_init_hw_for_vf(struct qed_hwfn *p_hwfn,
 
 	vf = qed_iov_get_vf_info(p_hwfn, p_params->rel_vf_id, false);
 	if (!vf) {
-		DP_ERR(p_hwfn, "qed_iov_init_hw_for_vf : vf is NULL\n");
+		DP_ERR(p_hwfn, "%s : vf is NULL\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1093,7 +1094,7 @@ static int qed_iov_release_hw_for_vf(struct qed_hwfn *p_hwfn,
 
 	vf = qed_iov_get_vf_info(p_hwfn, rel_vf_id, true);
 	if (!vf) {
-		DP_ERR(p_hwfn, "qed_iov_release_hw_for_vf : vf is NULL\n");
+		DP_ERR(p_hwfn, "%s : vf is NULL\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1546,7 +1547,7 @@ static void qed_iov_vf_mbx_acquire(struct qed_hwfn *p_hwfn,
 	memset(resp, 0, sizeof(*resp));
 
 	/* Write the PF version so that VF would know which version
-	 * is supported - might be later overriden. This guarantees that
+	 * is supported - might be later overridden. This guarantees that
 	 * VF could recognize legacy PF based on lack of versions in reply.
 	 */
 	pfdev_info->major_fp_hsi = ETH_HSI_VER_MAJOR;
@@ -1898,7 +1899,7 @@ static void qed_iov_vf_mbx_start_vport(struct qed_hwfn *p_hwfn,
 	int sb_id;
 	int rc;
 
-	vf_info = qed_iov_get_vf_info(p_hwfn, (u16) vf->relative_vf_id, true);
+	vf_info = qed_iov_get_vf_info(p_hwfn, (u16)vf->relative_vf_id, true);
 	if (!vf_info) {
 		DP_NOTICE(p_hwfn->cdev,
 			  "Failed to get VF info, invalid vfid [%d]\n",
@@ -1958,7 +1959,7 @@ static void qed_iov_vf_mbx_start_vport(struct qed_hwfn *p_hwfn,
 	rc = qed_sp_eth_vport_start(p_hwfn, &params);
 	if (rc) {
 		DP_ERR(p_hwfn,
-		       "qed_iov_vf_mbx_start_vport returned error %d\n", rc);
+		       "%s returned error %d\n", __func__, rc);
 		status = PFVF_STATUS_FAILURE;
 	} else {
 		vf->vport_instance++;
@@ -1994,8 +1995,8 @@ static void qed_iov_vf_mbx_stop_vport(struct qed_hwfn *p_hwfn,
 
 	rc = qed_sp_vport_stop(p_hwfn, vf->opaque_fid, vf->vport_id);
 	if (rc) {
-		DP_ERR(p_hwfn, "qed_iov_vf_mbx_stop_vport returned error %d\n",
-		       rc);
+		DP_ERR(p_hwfn, "%s returned error %d\n",
+		       __func__, rc);
 		status = PFVF_STATUS_FAILURE;
 	}
 
@@ -3031,7 +3032,7 @@ static void qed_iov_vf_mbx_vport_update(struct qed_hwfn *p_hwfn,
 		goto out;
 	}
 	p_rss_params = vzalloc(sizeof(*p_rss_params));
-	if (p_rss_params == NULL) {
+	if (!p_rss_params) {
 		status = PFVF_STATUS_FAILURE;
 		goto out;
 	}
@@ -3551,6 +3552,7 @@ static void qed_iov_vf_pf_set_coalesce(struct qed_hwfn *p_hwfn,
 	qed_iov_prepare_resp(p_hwfn, p_ptt, vf, CHANNEL_TLV_COALESCE_UPDATE,
 			     sizeof(struct pfvf_def_resp_tlv), status);
 }
+
 static int
 qed_iov_vf_flr_poll_dorq(struct qed_hwfn *p_hwfn,
 			 struct qed_vf_info *p_vf, struct qed_ptt *p_ptt)
@@ -3558,7 +3560,7 @@ qed_iov_vf_flr_poll_dorq(struct qed_hwfn *p_hwfn,
 	int cnt;
 	u32 val;
 
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) p_vf->concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)p_vf->concrete_fid);
 
 	for (cnt = 0; cnt < 50; cnt++) {
 		val = qed_rd(p_hwfn, p_ptt, DORQ_REG_VF_USAGE_CNT);
@@ -3566,7 +3568,7 @@ qed_iov_vf_flr_poll_dorq(struct qed_hwfn *p_hwfn,
 			break;
 		msleep(20);
 	}
-	qed_fid_pretend(p_hwfn, p_ptt, (u16) p_hwfn->hw_info.concrete_fid);
+	qed_fid_pretend(p_hwfn, p_ptt, (u16)p_hwfn->hw_info.concrete_fid);
 
 	if (cnt == 50) {
 		DP_ERR(p_hwfn,
@@ -3843,7 +3845,7 @@ static void qed_iov_process_mbx_req(struct qed_hwfn *p_hwfn,
 	struct qed_iov_vf_mbx *mbx;
 	struct qed_vf_info *p_vf;
 
-	p_vf = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	p_vf = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!p_vf)
 		return;
 
@@ -3980,7 +3982,7 @@ static void qed_iov_pf_get_pending_events(struct qed_hwfn *p_hwfn, u64 *events)
 static struct qed_vf_info *qed_sriov_get_vf_from_absid(struct qed_hwfn *p_hwfn,
 						       u16 abs_vfid)
 {
-	u8 min = (u8) p_hwfn->cdev->p_iov_info->first_vf_in_pf;
+	u8 min = (u8)p_hwfn->cdev->p_iov_info->first_vf_in_pf;
 
 	if (!_qed_iov_pf_sanity_check(p_hwfn, (int)abs_vfid - min, false)) {
 		DP_VERBOSE(p_hwfn,
@@ -3990,7 +3992,7 @@ static struct qed_vf_info *qed_sriov_get_vf_from_absid(struct qed_hwfn *p_hwfn,
 		return NULL;
 	}
 
-	return &p_hwfn->pf_iov_info->vfs_array[(u8) abs_vfid - min];
+	return &p_hwfn->pf_iov_info->vfs_array[(u8)abs_vfid - min];
 }
 
 static int qed_sriov_vfpf_msg(struct qed_hwfn *p_hwfn,
@@ -4014,13 +4016,13 @@ static int qed_sriov_vfpf_msg(struct qed_hwfn *p_hwfn,
 	return 0;
 }
 
-static void qed_sriov_vfpf_malicious(struct qed_hwfn *p_hwfn,
-				     struct malicious_vf_eqe_data *p_data)
+void qed_sriov_vfpf_malicious(struct qed_hwfn *p_hwfn,
+			      struct fw_err_data *p_data)
 {
 	struct qed_vf_info *p_vf;
 
-	p_vf = qed_sriov_get_vf_from_absid(p_hwfn, p_data->vf_id);
-
+	p_vf = qed_sriov_get_vf_from_absid(p_hwfn, qed_vf_from_entity_id
+					   (p_data->entity_id));
 	if (!p_vf)
 		return;
 
@@ -4037,16 +4039,13 @@ static void qed_sriov_vfpf_malicious(struct qed_hwfn *p_hwfn,
 	}
 }
 
-static int qed_sriov_eqe_event(struct qed_hwfn *p_hwfn, u8 opcode, __le16 echo,
-			       union event_ring_data *data, u8 fw_return_code)
+int qed_sriov_eqe_event(struct qed_hwfn *p_hwfn, u8 opcode, __le16 echo,
+			union event_ring_data *data, u8 fw_return_code)
 {
 	switch (opcode) {
 	case COMMON_EVENT_VF_PF_CHANNEL:
 		return qed_sriov_vfpf_msg(p_hwfn, le16_to_cpu(echo),
 					  &data->vf_pf_channel.msg_addr);
-	case COMMON_EVENT_MALICIOUS_VF:
-		qed_sriov_vfpf_malicious(p_hwfn, &data->malicious_vf);
-		return 0;
 	default:
 		DP_INFO(p_hwfn->cdev, "Unknown sriov eqe event 0x%02x\n",
 			opcode);
@@ -4076,7 +4075,7 @@ static int qed_iov_copy_vf_msg(struct qed_hwfn *p_hwfn, struct qed_ptt *ptt,
 	struct qed_dmae_params params;
 	struct qed_vf_info *vf_info;
 
-	vf_info = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	vf_info = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!vf_info)
 		return -EINVAL;
 
@@ -4177,7 +4176,7 @@ static void qed_iov_bulletin_set_forced_vlan(struct qed_hwfn *p_hwfn,
 	struct qed_vf_info *vf_info;
 	u64 feature;
 
-	vf_info = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	vf_info = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!vf_info) {
 		DP_NOTICE(p_hwfn->cdev,
 			  "Can not set forced MAC, invalid vfid [%d]\n", vfid);
@@ -4227,7 +4226,7 @@ static bool qed_iov_vf_has_vport_instance(struct qed_hwfn *p_hwfn, int vfid)
 {
 	struct qed_vf_info *p_vf_info;
 
-	p_vf_info = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	p_vf_info = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!p_vf_info)
 		return false;
 
@@ -4238,7 +4237,7 @@ static bool qed_iov_is_vf_stopped(struct qed_hwfn *p_hwfn, int vfid)
 {
 	struct qed_vf_info *p_vf_info;
 
-	p_vf_info = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	p_vf_info = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!p_vf_info)
 		return true;
 
@@ -4249,7 +4248,7 @@ static bool qed_iov_spoofchk_get(struct qed_hwfn *p_hwfn, int vfid)
 {
 	struct qed_vf_info *vf_info;
 
-	vf_info = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	vf_info = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!vf_info)
 		return false;
 
@@ -4267,7 +4266,7 @@ static int qed_iov_spoofchk_set(struct qed_hwfn *p_hwfn, int vfid, bool val)
 		goto out;
 	}
 
-	vf = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	vf = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!vf)
 		goto out;
 
@@ -4346,7 +4345,8 @@ static int qed_iov_configure_tx_rate(struct qed_hwfn *p_hwfn,
 		return rc;
 
 	rl_id = abs_vp_id;	/* The "rl_id" is set as the "vport_id" */
-	return qed_init_global_rl(p_hwfn, p_ptt, rl_id, (u32)val);
+	return qed_init_global_rl(p_hwfn, p_ptt, rl_id, (u32)val,
+				  QM_RL_TYPE_NORMAL);
 }
 
 static int
@@ -4377,7 +4377,7 @@ static int qed_iov_get_vf_min_rate(struct qed_hwfn *p_hwfn, int vfid)
 	struct qed_wfq_data *vf_vp_wfq;
 	struct qed_vf_info *vf_info;
 
-	vf_info = qed_iov_get_vf_info(p_hwfn, (u16) vfid, true);
+	vf_info = qed_iov_get_vf_info(p_hwfn, (u16)vfid, true);
 	if (!vf_info)
 		return 0;
 
@@ -4396,8 +4396,10 @@ static int qed_iov_get_vf_min_rate(struct qed_hwfn *p_hwfn, int vfid)
  */
 void qed_schedule_iov(struct qed_hwfn *hwfn, enum qed_iov_wq_flag flag)
 {
+	/* Memory barrier for setting atomic bit */
 	smp_mb__before_atomic();
 	set_bit(flag, &hwfn->iov_task_flags);
+	/* Memory barrier after setting atomic bit */
 	smp_mb__after_atomic();
 	DP_VERBOSE(hwfn, QED_MSG_IOV, "Scheduling iov task [Flag: %d]\n", flag);
 	queue_delayed_work(hwfn->iov_wq, &hwfn->iov_task, 0);
@@ -4408,8 +4410,8 @@ void qed_vf_start_iov_wq(struct qed_dev *cdev)
 	int i;
 
 	for_each_hwfn(cdev, i)
-	    queue_delayed_work(cdev->hwfns[i].iov_wq,
-			       &cdev->hwfns[i].iov_task, 0);
+		queue_delayed_work(cdev->hwfns[i].iov_wq,
+				   &cdev->hwfns[i].iov_task, 0);
 }
 
 int qed_sriov_disable(struct qed_dev *cdev, bool pci_enabled)
@@ -4417,8 +4419,8 @@ int qed_sriov_disable(struct qed_dev *cdev, bool pci_enabled)
 	int i, j;
 
 	for_each_hwfn(cdev, i)
-	    if (cdev->hwfns[i].iov_wq)
-		flush_workqueue(cdev->hwfns[i].iov_wq);
+		if (cdev->hwfns[i].iov_wq)
+			flush_workqueue(cdev->hwfns[i].iov_wq);
 
 	/* Mark VFs for disablement */
 	qed_iov_set_vfs_to_disable(cdev, true);
@@ -5011,7 +5013,7 @@ static void qed_handle_bulletin_post(struct qed_hwfn *hwfn)
 	}
 
 	qed_for_each_vf(hwfn, i)
-	    qed_iov_post_vf_bulletin(hwfn, i, ptt);
+		qed_iov_post_vf_bulletin(hwfn, i, ptt);
 
 	qed_ptt_release(hwfn, ptt);
 }
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.h b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
index 9f81295c6f45..1edf9c44dc67 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
@@ -142,7 +142,7 @@ struct qed_vf_queue {
 
 enum vf_state {
 	VF_FREE = 0,		/* VF ready to be acquired holds no resc */
-	VF_ACQUIRED,		/* VF, acquired, but not initalized */
+	VF_ACQUIRED,		/* VF, acquired, but not initialized */
 	VF_ENABLED,		/* VF, Enabled */
 	VF_RESET,		/* VF, FLR'd, pending cleanup */
 	VF_STOPPED		/* VF, Stopped */
@@ -313,6 +313,31 @@ void *qed_add_tlv(struct qed_hwfn *p_hwfn, u8 **offset, u16 type, u16 length);
  */
 void qed_dp_tlv_list(struct qed_hwfn *p_hwfn, void *tlvs_list);
 
+/**
+ * qed_sriov_vfpf_malicious(): Handle malicious VF/PF.
+ *
+ * @p_hwfn: HW device data.
+ * @p_data: Pointer to data.
+ *
+ * Return: Void.
+ */
+void qed_sriov_vfpf_malicious(struct qed_hwfn *p_hwfn,
+			      struct fw_err_data *p_data);
+
+/**
+ * qed_sriov_eqe_event(): Callback for SRIOV events.
+ *
+ * @p_hwfn: HW device data.
+ * @opcode: Opcode.
+ * @echo: Echo.
+ * @data: data
+ * @fw_return_code: FW return code.
+ *
+ * Return: Int.
+ */
+int qed_sriov_eqe_event(struct qed_hwfn *p_hwfn, u8 opcode, __le16 echo,
+			union event_ring_data *data, u8  fw_return_code);
+
 /**
  * qed_iov_alloc(): allocate sriov related resources
  *
diff --git a/include/linux/qed/eth_common.h b/include/linux/qed/eth_common.h
index cd1207ad4ada..c84e08bc6802 100644
--- a/include/linux/qed/eth_common.h
+++ b/include/linux/qed/eth_common.h
@@ -67,6 +67,7 @@
 /* Ethernet vport update constants */
 #define ETH_FILTER_RULES_COUNT		10
 #define ETH_RSS_IND_TABLE_ENTRIES_NUM	128
+#define ETH_RSS_IND_TABLE_MASK_SIZE_REGS    (ETH_RSS_IND_TABLE_ENTRIES_NUM / 32)
 #define ETH_RSS_KEY_SIZE_REGS		10
 #define ETH_RSS_ENGINE_NUM_K2		207
 #define ETH_RSS_ENGINE_NUM_BB		127
diff --git a/include/linux/qed/rdma_common.h b/include/linux/qed/rdma_common.h
index bab078b25834..6dfed163ab6c 100644
--- a/include/linux/qed/rdma_common.h
+++ b/include/linux/qed/rdma_common.h
@@ -27,6 +27,7 @@
 #define RDMA_MAX_PDS			(64 * 1024)
 #define RDMA_MAX_XRC_SRQS                       (1024)
 #define RDMA_MAX_SRQS                           (32 * 1024)
+#define RDMA_MAX_IRQ_ELEMS_IN_PAGE      (128)
 
 #define RDMA_NUM_STATISTIC_COUNTERS	MAX_NUM_VPORTS
 #define RDMA_NUM_STATISTIC_COUNTERS_K2	MAX_NUM_VPORTS_K2
-- 
2.24.1

