Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE34B41C48B
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Sep 2021 14:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbhI2MRX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Sep 2021 08:17:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5730 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343752AbhI2MQf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Sep 2021 08:16:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T8e7NT008407;
        Wed, 29 Sep 2021 05:12:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=4JQ7YyrTzMgBDRvrL7vKlwFpYw5lvktHjjH+H1W8A1o=;
 b=FUq0TFMf6Jsxpo/xoY8gNRhCZGHroFjoAcI3Yj9hV5d18zjfi4BvPBNa7ZmJca2x3bST
 ISfEVNoXE/vBJ3Ty3HgqqLl2wSogH3746qHeEOm+ZnxOCYmLHy6oD6TA66nSA6z1oNM1
 AWeEMOdG7102N4+rDZ+XSNpR+vU05HK5405McMQ8OXYkmafQ9Tb9WWfO1WjPAwgluRn7
 /pieQlvra1e+A6H+yBp6IupWiov6U4YnulbIevOlQuwW+hxjSWqYhZ+uymYuSIbsLhNs
 8EPEF/2L0lmhU1713QSyrSbB5T4ydW/SjVGPTMx+vJq7LEL7bbKpJBK9wnwS8SVX5soY UA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bcfd4a0ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 05:12:58 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Sep
 2021 05:12:56 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Wed, 29 Sep 2021 05:12:52 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <aelior@marvell.com>,
        <smalin@marvell.com>, <jhasan@marvell.com>,
        <mrangankar@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>,
        Omkar Kulkarni <okulkarni@marvell.com>
Subject: [PATCH 07/12] qed: Update FW init functions to support FW 8.59.1.0
Date:   Wed, 29 Sep 2021 15:12:10 +0300
Message-ID: <20210929121215.17864-8-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210929121215.17864-1-pkushwaha@marvell.com>
References: <20210929121215.17864-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ka7mBr3dovVXvUeQw_b5k_hkCsGeO5o7
X-Proofpoint-ORIG-GUID: ka7mBr3dovVXvUeQw_b5k_hkCsGeO5o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_05,2021-09-29_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Omkar Kulkarni <okulkarni@marvell.com>

The qed_init_fw_func.c and qed_init_ops.c updated to support FW
version 8.59.1.0.
  - Support 16-bit VPORT WFQ (weighted fair queueing) weights.
  - Support WFQ (weighted fair queueing) weight per VPORT + TC.
  - Support allocation of Tx PQs(physical queues) per PF,VF.
  - Modify Global RL (rate limiter) upper bound configuration.
  - Update FW operation functions.
  - Update iro_arr[] array.

This patch also fixes the existing checkpatch warnings and few important
checks.

Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed.h         |  24 +-
 .../ethernet/qlogic/qed/qed_init_fw_funcs.c   | 365 ++++++++++++------
 .../net/ethernet/qlogic/qed/qed_init_ops.c    |  98 +++--
 .../net/ethernet/qlogic/qed/qed_init_ops.h    |   2 +-
 .../net/ethernet/qlogic/qed/qed_reg_addr.h    |  14 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c   |  69 ++--
 6 files changed, 372 insertions(+), 200 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index 4693379a4105..410c7f72e085 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -91,14 +91,14 @@ static inline u32 qed_db_addr_vf(u32 cid, u32 DEMS)
 }
 
 #define ALIGNED_TYPE_SIZE(type_name, p_hwfn)				     \
-	((sizeof(type_name) + (u32)(1 << (p_hwfn->cdev->cache_shift)) - 1) & \
+	((sizeof(type_name) + (u32)(1 << ((p_hwfn)->cdev->cache_shift)) - 1) & \
 	 ~((1 << (p_hwfn->cdev->cache_shift)) - 1))
 
-#define for_each_hwfn(cdev, i)  for (i = 0; i < cdev->num_hwfns; i++)
+#define for_each_hwfn(cdev, i)  for (i = 0; i < (cdev)->num_hwfns; i++)
 
 #define D_TRINE(val, cond1, cond2, true1, true2, def) \
-	(val == (cond1) ? true1 :		      \
-	 (val == (cond2) ? true2 : def))
+	((val) == (cond1) ? true1 :		      \
+	 ((val) == (cond2) ? true2 : def))
 
 /* forward */
 struct qed_ptt_pool;
@@ -512,7 +512,7 @@ enum qed_hsi_def_type {
 
 struct qed_simd_fp_handler {
 	void	*token;
-	void	(*func)(void *);
+	void	(*func)(void *cookie);
 };
 
 enum qed_slowpath_wq_flag {
@@ -875,7 +875,6 @@ u32 qed_get_hsi_def_val(struct qed_dev *cdev, enum qed_hsi_def_type type);
 #define NUM_OF_BTB_BLOCKS(dev) \
 	qed_get_hsi_def_val(dev, QED_HSI_DEF_MAX_BTB_BLOCKS)
 
-
 /**
  * @brief qed_concrete_to_sw_fid - get the sw function id from
  *        the concrete value.
@@ -902,7 +901,6 @@ static inline u8 qed_concrete_to_sw_fid(struct qed_dev *cdev,
 }
 
 #define PKT_LB_TC	9
-#define MAX_NUM_VOQS	20
 
 int qed_configure_vport_wfq(struct qed_dev *cdev, u16 vp_id, u32 rate);
 void qed_configure_vp_wfq_on_link_change(struct qed_dev *cdev,
@@ -914,7 +912,7 @@ int qed_device_num_engines(struct qed_dev *cdev);
 void qed_set_fw_mac_addr(__le16 *fw_msb,
 			 __le16 *fw_mid, __le16 *fw_lsb, u8 *mac);
 
-#define QED_LEADING_HWFN(dev)   (&dev->hwfns[0])
+#define QED_LEADING_HWFN(dev)   (&(dev)->hwfns[0])
 #define QED_IS_CMT(dev)		((dev)->num_hwfns > 1)
 /* Macros for getting the engine-affinitized hwfn (FIR: fcoe,iscsi,roce) */
 #define QED_FIR_AFFIN_HWFN(dev)		(&(dev)->hwfns[dev->fir_affin])
@@ -935,7 +933,7 @@ void qed_set_fw_mac_addr(__le16 *fw_msb,
 #define PQ_FLAGS_LLT    (BIT(7))
 #define PQ_FLAGS_MTC    (BIT(8))
 
-/* physical queue index for cm context intialization */
+/* physical queue index for cm context initialization */
 u16 qed_get_cm_pq_idx(struct qed_hwfn *p_hwfn, u32 pq_flags);
 u16 qed_get_cm_pq_idx_mcos(struct qed_hwfn *p_hwfn, u8 tc);
 u16 qed_get_cm_pq_idx_vf(struct qed_hwfn *p_hwfn, u16 vf);
@@ -950,9 +948,9 @@ bool qed_edpm_enabled(struct qed_hwfn *p_hwfn);
 /* Other Linux specific common definitions */
 #define DP_NAME(cdev) ((cdev)->name)
 
-#define REG_ADDR(cdev, offset)          (void __iomem *)((u8 __iomem *)\
-						(cdev->regview) + \
-							 (offset))
+#define REG_ADDR(cdev, offset)          ((void __iomem *)((u8 __iomem *)\
+						((cdev)->regview) + \
+							 (offset)))
 
 #define REG_RD(cdev, offset)            readl(REG_ADDR(cdev, offset))
 #define REG_WR(cdev, offset, val)       writel((u32)val, REG_ADDR(cdev, offset))
@@ -960,7 +958,7 @@ bool qed_edpm_enabled(struct qed_hwfn *p_hwfn);
 
 #define DOORBELL(cdev, db_addr, val)			 \
 	writel((u32)val, (void __iomem *)((u8 __iomem *)\
-					  (cdev->doorbells) + (db_addr)))
+					  ((cdev)->doorbells) + (db_addr)))
 
 #define MFW_PORT(_p_hwfn)       ((_p_hwfn)->abs_pf_id %			  \
 				  qed_device_num_ports((_p_hwfn)->cdev))
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
index fb90ad4a9d1f..321c43408153 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 /* QLogic qed NIC Driver
  * Copyright (c) 2015-2017  QLogic Corporation
- * Copyright (c) 2019-2020 Marvell International Ltd.
+ * Copyright (c) 2019-2021 Marvell International Ltd.
  */
 
 #include <linux/types.h>
@@ -16,7 +16,7 @@
 #include "qed_iro_hsi.h"
 #include "qed_reg_addr.h"
 
-#define CDU_VALIDATION_DEFAULT_CFG	61
+#define CDU_VALIDATION_DEFAULT_CFG CDU_CONTEXT_VALIDATION_DEFAULT_CFG
 
 static u16 con_region_offsets[3][NUM_OF_CONNECTION_TYPES] = {
 	{400, 336, 352, 368, 304, 384, 416, 352},	/* region 3 offsets */
@@ -43,25 +43,49 @@ static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
 #define QM_BYPASS_EN	1
 #define QM_BYTE_CRD_EN	1
 
+/* Initial VOQ byte credit */
+#define QM_INITIAL_VOQ_BYTE_CRD         98304
 /* Other PQ constants */
 #define QM_OTHER_PQS_PER_PF	4
 
+/* VOQ constants */
+#define MAX_NUM_VOQS	(MAX_NUM_PORTS_K2 * NUM_TCS_4PORT_K2)
+#define VOQS_BIT_MASK	(BIT(MAX_NUM_VOQS) - 1)
+
 /* WFQ constants */
 
-/* Upper bound in MB, 10 * burst size of 1ms in 50Gbps */
-#define QM_WFQ_UPPER_BOUND	62500000
+/* PF WFQ increment value, 0x9000 = 4*9*1024 */
+#define QM_PF_WFQ_INC_VAL(weight)       ((weight) * 0x9000)
+
+/* PF WFQ Upper bound, in MB, 10 * burst size of 1ms in 50Gbps */
+#define QM_PF_WFQ_UPPER_BOUND           62500000
+
+/* PF WFQ max increment value, 0.7 * upper bound */
+#define QM_PF_WFQ_MAX_INC_VAL           ((QM_PF_WFQ_UPPER_BOUND * 7) / 10)
+
+/* Number of VOQs in E5 PF WFQ credit register (QmWfqCrd) */
+#define QM_PF_WFQ_CRD_E5_NUM_VOQS       16
+
+/* VP WFQ increment value */
+#define QM_VP_WFQ_INC_VAL(weight)       ((weight) * QM_VP_WFQ_MIN_INC_VAL)
 
-/* Bit  of VOQ in WFQ VP PQ map */
-#define QM_WFQ_VP_PQ_VOQ_SHIFT	0
+/* VP WFQ min increment value */
+#define QM_VP_WFQ_MIN_INC_VAL           10800
 
-/* Bit  of PF in WFQ VP PQ map */
-#define QM_WFQ_VP_PQ_PF_SHIFT	5
+/* VP WFQ max increment value, 2^30 */
+#define QM_VP_WFQ_MAX_INC_VAL           0x40000000
 
-/* 0x9000 = 4*9*1024 */
-#define QM_WFQ_INC_VAL(weight)	((weight) * 0x9000)
+/* VP WFQ bypass threshold */
+#define QM_VP_WFQ_BYPASS_THRESH         (QM_VP_WFQ_MIN_INC_VAL - 100)
 
-/* Max WFQ increment value is 0.7 * upper bound */
-#define QM_WFQ_MAX_INC_VAL	((QM_WFQ_UPPER_BOUND * 7) / 10)
+/* VP RL credit task cost */
+#define QM_VP_RL_CRD_TASK_COST          9700
+
+/* Bit of VOQ in VP WFQ PQ map */
+#define QM_VP_WFQ_PQ_VOQ_SHIFT          0
+
+/* Bit of PF in VP WFQ PQ map */
+#define QM_VP_WFQ_PQ_PF_SHIFT   5
 
 /* RL constants */
 
@@ -72,12 +96,13 @@ static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
 #define QM_RL_PERIOD_CLK_25M	(25 * QM_RL_PERIOD)
 
 /* RL increment value - rate is specified in mbps */
-#define QM_RL_INC_VAL(rate) ({ \
-	typeof(rate) __rate = (rate); \
-	max_t(u32, \
-	      (u32)(((__rate ? __rate : 1000000) * QM_RL_PERIOD * 101) / \
-		    (8 * 100)), \
-	      1); })
+#define QM_RL_INC_VAL(rate)                     ({	\
+						typeof(rate) __rate = (rate); \
+						max_t(u32,		\
+						(u32)(((__rate ? __rate : \
+						100000) *		\
+						QM_RL_PERIOD *		\
+						101) / (8 * 100)), 1); })
 
 /* PF RL Upper bound is set to 10 * burst size of 1ms in 50Gbps */
 #define QM_PF_RL_UPPER_BOUND	62500000
@@ -85,16 +110,13 @@ static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
 /* Max PF RL increment value is 0.7 * upper bound */
 #define QM_PF_RL_MAX_INC_VAL	((QM_PF_RL_UPPER_BOUND * 7) / 10)
 
-/* Vport RL Upper bound, link speed is in Mpbs */
-#define QM_VP_RL_UPPER_BOUND(speed)	((u32)max_t(u32, \
-						    QM_RL_INC_VAL(speed), \
-						    9700 + 1000))
-
-/* Max Vport RL increment value is the Vport RL upper bound */
-#define QM_VP_RL_MAX_INC_VAL(speed)	QM_VP_RL_UPPER_BOUND(speed)
-
-/* Vport RL credit threshold in case of QM bypass */
-#define QM_VP_RL_BYPASS_THRESH_SPEED	(QM_VP_RL_UPPER_BOUND(10000) - 1)
+/* QCN RL Upper bound, speed is in Mpbs */
+#define QM_GLOBAL_RL_UPPER_BOUND(speed)         ((u32)max_t( \
+		u32,					    \
+		(u32)(((speed) *			    \
+		       QM_RL_PERIOD * 101) / (8 * 100)),    \
+		QM_VP_RL_CRD_TASK_COST			    \
+		+ 1000))
 
 /* AFullOprtnstcCrdMask constants */
 #define QM_OPPOR_LINE_VOQ_DEF	1
@@ -163,7 +185,7 @@ static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
 		u32 __reg = 0;						      \
 									      \
 		BUILD_BUG_ON(sizeof((map).reg) != sizeof(__reg));	      \
-									      \
+		memset(&(map), 0, sizeof(map));				      \
 		SET_FIELD(__reg, QM_RF_PQ_MAP_PQ_VALID, 1);	      \
 		SET_FIELD(__reg, QM_RF_PQ_MAP_RL_VALID,	      \
 			  !!(rl_valid));				      \
@@ -185,8 +207,8 @@ static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
 	(((rl) >> 8) << 9))
 
 #define PQ_INFO_RAM_GRC_ADDRESS(pq_id) \
-	XSEM_REG_FAST_MEMORY + SEM_FAST_REG_INT_RAM + \
-	XSTORM_PQ_INFO_OFFSET(pq_id)
+	(XSEM_REG_FAST_MEMORY + SEM_FAST_REG_INT_RAM + \
+	XSTORM_PQ_INFO_OFFSET(pq_id))
 
 /******************** INTERNAL IMPLEMENTATION *********************/
 
@@ -237,7 +259,7 @@ static void qed_enable_pf_wfq(struct qed_hwfn *p_hwfn, bool pf_wfq_en)
 	if (pf_wfq_en && QM_BYPASS_EN)
 		STORE_RT_REG(p_hwfn,
 			     QM_REG_AFULLQMBYPTHRPFWFQ_RT_OFFSET,
-			     QM_WFQ_UPPER_BOUND);
+			     QM_PF_WFQ_UPPER_BOUND);
 }
 
 /* Prepare global RL enable/disable runtime init values */
@@ -258,7 +280,7 @@ static void qed_enable_global_rl(struct qed_hwfn *p_hwfn, bool global_rl_en)
 		if (QM_BYPASS_EN)
 			STORE_RT_REG(p_hwfn,
 				     QM_REG_AFULLQMBYPTHRGLBLRL_RT_OFFSET,
-				     QM_VP_RL_BYPASS_THRESH_SPEED);
+				     QM_GLOBAL_RL_UPPER_BOUND(10000) - 1);
 	}
 }
 
@@ -272,7 +294,7 @@ static void qed_enable_vport_wfq(struct qed_hwfn *p_hwfn, bool vport_wfq_en)
 	if (vport_wfq_en && QM_BYPASS_EN)
 		STORE_RT_REG(p_hwfn,
 			     QM_REG_AFULLQMBYPTHRVPWFQ_RT_OFFSET,
-			     QM_WFQ_UPPER_BOUND);
+			     QM_VP_WFQ_BYPASS_THRESH);
 }
 
 /* Prepare runtime init values to allocate PBF command queue lines for
@@ -292,11 +314,11 @@ static void qed_cmdq_lines_voq_rt_init(struct qed_hwfn *p_hwfn,
 }
 
 /* Prepare runtime init values to allocate PBF command queue lines. */
-static void qed_cmdq_lines_rt_init(
-	struct qed_hwfn *p_hwfn,
-	u8 max_ports_per_engine,
-	u8 max_phys_tcs_per_port,
-	struct init_qm_port_params port_params[MAX_NUM_PORTS])
+static void
+qed_cmdq_lines_rt_init(struct qed_hwfn *p_hwfn,
+		       u8 max_ports_per_engine,
+		       u8 max_phys_tcs_per_port,
+		       struct init_qm_port_params port_params[MAX_NUM_PORTS])
 {
 	u8 tc, ext_voq, port_id, num_tcs_in_port;
 	u8 num_ext_voqs = MAX_NUM_VOQS;
@@ -365,11 +387,11 @@ static void qed_cmdq_lines_rt_init(
  * - No optimization for lossy TC (all are considered lossless). Shared space
  *   is not enabled and allocated for each TC.
  */
-static void qed_btb_blocks_rt_init(
-	struct qed_hwfn *p_hwfn,
-	u8 max_ports_per_engine,
-	u8 max_phys_tcs_per_port,
-	struct init_qm_port_params port_params[MAX_NUM_PORTS])
+static void
+qed_btb_blocks_rt_init(struct qed_hwfn *p_hwfn,
+		       u8 max_ports_per_engine,
+		       u8 max_phys_tcs_per_port,
+		       struct init_qm_port_params port_params[MAX_NUM_PORTS])
 {
 	u32 usable_blocks, pure_lb_blocks, phys_blocks;
 	u8 tc, ext_voq, port_id, num_tcs_in_port;
@@ -429,7 +451,7 @@ static void qed_btb_blocks_rt_init(
  */
 static int qed_global_rl_rt_init(struct qed_hwfn *p_hwfn)
 {
-	u32 upper_bound = QM_VP_RL_UPPER_BOUND(QM_MAX_LINK_SPEED) |
+	u32 upper_bound = QM_GLOBAL_RL_UPPER_BOUND(QM_MAX_LINK_SPEED) |
 			  (u32)QM_RL_CRD_REG_SIGN_BIT;
 	u32 inc_val;
 	u16 rl_id;
@@ -451,11 +473,73 @@ static int qed_global_rl_rt_init(struct qed_hwfn *p_hwfn)
 	return 0;
 }
 
+/* Returns the upper bound for the specified Vport RL parameters.
+ * link_speed is in Mbps.
+ * Returns 0 in case of error.
+ */
+static u32 qed_get_vport_rl_upper_bound(enum init_qm_rl_type vport_rl_type,
+					u32 link_speed)
+{
+	switch (vport_rl_type) {
+	case QM_RL_TYPE_NORMAL:
+		return QM_INITIAL_VOQ_BYTE_CRD;
+	case QM_RL_TYPE_QCN:
+		return QM_GLOBAL_RL_UPPER_BOUND(link_speed);
+	default:
+		return 0;
+	}
+}
+
+/* Prepare VPORT RL runtime init values.
+ * Return -1 on error.
+ */
+static int qed_vport_rl_rt_init(struct qed_hwfn *p_hwfn,
+				u16 start_rl,
+				u16 num_rls,
+				u32 link_speed,
+				struct init_qm_rl_params *rl_params)
+{
+	u16 i, rl_id;
+
+	if (num_rls && start_rl + num_rls >= MAX_QM_GLOBAL_RLS) {
+		DP_NOTICE(p_hwfn, "Invalid rate limiter configuration\n");
+		return -1;
+	}
+
+	/* Go over all PF VPORTs */
+	for (i = 0, rl_id = start_rl; i < num_rls; i++, rl_id++) {
+		u32 upper_bound, inc_val;
+
+		upper_bound =
+		    qed_get_vport_rl_upper_bound((enum init_qm_rl_type)
+						 rl_params[i].vport_rl_type,
+						 link_speed);
+
+		inc_val =
+		    QM_RL_INC_VAL(rl_params[i].vport_rl ?
+				  rl_params[i].vport_rl : link_speed);
+		if (inc_val > upper_bound) {
+			DP_NOTICE(p_hwfn,
+				  "Invalid RL rate - limit configuration\n");
+			return -1;
+		}
+
+		STORE_RT_REG(p_hwfn, QM_REG_RLGLBLCRD_RT_OFFSET + rl_id,
+			     (u32)QM_RL_CRD_REG_SIGN_BIT);
+		STORE_RT_REG(p_hwfn, QM_REG_RLGLBLUPPERBOUND_RT_OFFSET + rl_id,
+			     upper_bound | (u32)QM_RL_CRD_REG_SIGN_BIT);
+		STORE_RT_REG(p_hwfn, QM_REG_RLGLBLINCVAL_RT_OFFSET + rl_id,
+			     inc_val);
+	}
+
+	return 0;
+}
+
 /* Prepare Tx PQ mapping runtime init values for the specified PF */
-static void qed_tx_pq_map_rt_init(struct qed_hwfn *p_hwfn,
-				  struct qed_ptt *p_ptt,
-				  struct qed_qm_pf_rt_init_params *p_params,
-				  u32 base_mem_addr_4kb)
+static int qed_tx_pq_map_rt_init(struct qed_hwfn *p_hwfn,
+				 struct qed_ptt *p_ptt,
+				 struct qed_qm_pf_rt_init_params *p_params,
+				 u32 base_mem_addr_4kb)
 {
 	u32 tx_pq_vf_mask[MAX_QM_TX_QUEUES / QM_PF_QUEUE_GROUP_SIZE] = { 0 };
 	struct init_qm_vport_params *vport_params = p_params->vport_params;
@@ -505,8 +589,8 @@ static void qed_tx_pq_map_rt_init(struct qed_hwfn *p_hwfn,
 		    &vport_params[vport_id_in_pf].first_tx_pq_id[tc_id];
 		if (*p_first_tx_pq_id == QM_INVALID_PQ_ID) {
 			u32 map_val =
-				(ext_voq << QM_WFQ_VP_PQ_VOQ_SHIFT) |
-				(p_params->pf_id << QM_WFQ_VP_PQ_PF_SHIFT);
+				(ext_voq << QM_VP_WFQ_PQ_VOQ_SHIFT) |
+				(p_params->pf_id << QM_VP_WFQ_PQ_PF_SHIFT);
 
 			/* Create new VP PQ */
 			*p_first_tx_pq_id = pq_id;
@@ -570,6 +654,8 @@ static void qed_tx_pq_map_rt_init(struct qed_hwfn *p_hwfn,
 			STORE_RT_REG(p_hwfn,
 				     QM_REG_MAXPQSIZETXSEL_0_RT_OFFSET + i,
 				     tx_pq_vf_mask[i]);
+
+	return 0;
 }
 
 /* Prepare Other PQ mapping runtime init values for the specified PF */
@@ -620,7 +706,6 @@ static void qed_other_pq_map_rt_init(struct qed_hwfn *p_hwfn,
  * Return -1 on error.
  */
 static int qed_pf_wfq_rt_init(struct qed_hwfn *p_hwfn,
-
 			      struct qed_qm_pf_rt_init_params *p_params)
 {
 	u16 num_tx_pqs = p_params->num_pf_pqs + p_params->num_vf_pqs;
@@ -629,8 +714,8 @@ static int qed_pf_wfq_rt_init(struct qed_hwfn *p_hwfn,
 	u8 ext_voq;
 	u16 i;
 
-	inc_val = QM_WFQ_INC_VAL(p_params->pf_wfq);
-	if (!inc_val || inc_val > QM_WFQ_MAX_INC_VAL) {
+	inc_val = QM_PF_WFQ_INC_VAL(p_params->pf_wfq);
+	if (!inc_val || inc_val > QM_PF_WFQ_MAX_INC_VAL) {
 		DP_NOTICE(p_hwfn, "Invalid PF WFQ weight configuration\n");
 		return -1;
 	}
@@ -652,7 +737,7 @@ static int qed_pf_wfq_rt_init(struct qed_hwfn *p_hwfn,
 
 	STORE_RT_REG(p_hwfn,
 		     QM_REG_WFQPFUPPERBOUND_RT_OFFSET + p_params->pf_id,
-		     QM_WFQ_UPPER_BOUND | (u32)QM_WFQ_CRD_REG_SIGN_BIT);
+		     QM_PF_WFQ_UPPER_BOUND | (u32)QM_WFQ_CRD_REG_SIGN_BIT);
 	STORE_RT_REG(p_hwfn, QM_REG_WFQPFWEIGHT_RT_OFFSET + p_params->pf_id,
 		     inc_val);
 
@@ -689,34 +774,38 @@ static int qed_vp_wfq_rt_init(struct qed_hwfn *p_hwfn,
 			      u16 num_vports,
 			      struct init_qm_vport_params *vport_params)
 {
-	u16 vport_pq_id, i;
+	u16 vport_pq_id, wfq, i;
 	u32 inc_val;
 	u8 tc;
 
 	/* Go over all PF VPORTs */
 	for (i = 0; i < num_vports; i++) {
-		if (!vport_params[i].wfq)
-			continue;
-
-		inc_val = QM_WFQ_INC_VAL(vport_params[i].wfq);
-		if (inc_val > QM_WFQ_MAX_INC_VAL) {
-			DP_NOTICE(p_hwfn,
-				  "Invalid VPORT WFQ weight configuration\n");
-			return -1;
-		}
-
 		/* Each VPORT can have several VPORT PQ IDs for various TCs */
 		for (tc = 0; tc < NUM_OF_TCS; tc++) {
+			/* Check if VPORT/TC is valid */
 			vport_pq_id = vport_params[i].first_tx_pq_id[tc];
-			if (vport_pq_id != QM_INVALID_PQ_ID) {
-				STORE_RT_REG(p_hwfn,
-					     QM_REG_WFQVPCRD_RT_OFFSET +
-					     vport_pq_id,
-					     (u32)QM_WFQ_CRD_REG_SIGN_BIT);
-				STORE_RT_REG(p_hwfn,
-					     QM_REG_WFQVPWEIGHT_RT_OFFSET +
-					     vport_pq_id, inc_val);
+			if (vport_pq_id == QM_INVALID_PQ_ID)
+				continue;
+
+			/* Find WFQ weight (per VPORT or per VPORT+TC) */
+			wfq = vport_params[i].wfq;
+			wfq = wfq ? wfq : vport_params[i].tc_wfq[tc];
+			inc_val = QM_VP_WFQ_INC_VAL(wfq);
+			if (inc_val > QM_VP_WFQ_MAX_INC_VAL) {
+				DP_NOTICE(p_hwfn,
+					  "Invalid VPORT WFQ weight configuration\n");
+				return -1;
 			}
+
+			/* Config registers */
+			STORE_RT_REG(p_hwfn, QM_REG_WFQVPCRD_RT_OFFSET +
+				     vport_pq_id,
+				     (u32)QM_WFQ_CRD_REG_SIGN_BIT);
+			STORE_RT_REG(p_hwfn, QM_REG_WFQVPUPPERBOUND_RT_OFFSET +
+				     vport_pq_id,
+				     inc_val | QM_WFQ_CRD_REG_SIGN_BIT);
+			STORE_RT_REG(p_hwfn, QM_REG_WFQVPWEIGHT_RT_OFFSET +
+				     vport_pq_id, inc_val);
 		}
 	}
 
@@ -780,11 +869,14 @@ int qed_qm_common_rt_init(struct qed_hwfn *p_hwfn,
 	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_LINEVOQ,
 		  QM_OPPOR_LINE_VOQ_DEF);
 	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_BYTEVOQ, QM_BYTE_CRD_EN);
-	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_PFWFQ, p_params->pf_wfq_en);
-	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_VPWFQ, p_params->vport_wfq_en);
-	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_PFRL, p_params->pf_rl_en);
+	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_PFWFQ,
+		  p_params->pf_wfq_en ? 1 : 0);
+	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_VPWFQ,
+		  p_params->vport_wfq_en ? 1 : 0);
+	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_PFRL,
+		  p_params->pf_rl_en ? 1 : 0);
 	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_VPQCNRL,
-		  p_params->global_rl_en);
+		  p_params->global_rl_en ? 1 : 0);
 	SET_FIELD(mask, QM_RF_OPPORTUNISTIC_MASK_FWPAUSE, QM_OPPOR_FW_STOP_DEF);
 	SET_FIELD(mask,
 		  QM_RF_OPPORTUNISTIC_MASK_QUEUEEMPTY, QM_OPPOR_PQ_EMPTY_DEF);
@@ -830,7 +922,6 @@ int qed_qm_pf_rt_init(struct qed_hwfn *p_hwfn,
 	u16 i;
 	u8 tc;
 
-
 	/* Clear first Tx PQ ID array for each VPORT */
 	for (i = 0; i < p_params->num_vports; i++)
 		for (tc = 0; tc < NUM_OF_TCS; tc++)
@@ -843,7 +934,8 @@ int qed_qm_pf_rt_init(struct qed_hwfn *p_hwfn,
 				 p_params->num_tids, 0);
 
 	/* Map Tx PQs */
-	qed_tx_pq_map_rt_init(p_hwfn, p_ptt, p_params, other_mem_size_4kb);
+	if (qed_tx_pq_map_rt_init(p_hwfn, p_ptt, p_params, other_mem_size_4kb))
+		return -1;
 
 	/* Init PF WFQ */
 	if (p_params->pf_wfq)
@@ -858,15 +950,21 @@ int qed_qm_pf_rt_init(struct qed_hwfn *p_hwfn,
 	if (qed_vp_wfq_rt_init(p_hwfn, p_params->num_vports, vport_params))
 		return -1;
 
+	/* Set VPORT RL */
+	if (qed_vport_rl_rt_init(p_hwfn, p_params->start_rl,
+				 p_params->num_rls, p_params->link_speed,
+				 p_params->rl_params))
+		return -1;
+
 	return 0;
 }
 
 int qed_init_pf_wfq(struct qed_hwfn *p_hwfn,
 		    struct qed_ptt *p_ptt, u8 pf_id, u16 pf_wfq)
 {
-	u32 inc_val = QM_WFQ_INC_VAL(pf_wfq);
+	u32 inc_val = QM_PF_WFQ_INC_VAL(pf_wfq);
 
-	if (!inc_val || inc_val > QM_WFQ_MAX_INC_VAL) {
+	if (!inc_val || inc_val > QM_PF_WFQ_MAX_INC_VAL) {
 		DP_NOTICE(p_hwfn, "Invalid PF WFQ weight configuration\n");
 		return -1;
 	}
@@ -897,24 +995,40 @@ int qed_init_vport_wfq(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
 		       u16 first_tx_pq_id[NUM_OF_TCS], u16 wfq)
 {
+	int result = 0;
 	u16 vport_pq_id;
-	u32 inc_val;
 	u8 tc;
 
-	inc_val = QM_WFQ_INC_VAL(wfq);
-	if (!inc_val || inc_val > QM_WFQ_MAX_INC_VAL) {
+	for (tc = 0; tc < NUM_OF_TCS && !result; tc++) {
+		vport_pq_id = first_tx_pq_id[tc];
+		if (vport_pq_id != QM_INVALID_PQ_ID)
+			result = qed_init_vport_tc_wfq(p_hwfn, p_ptt,
+						       vport_pq_id, wfq);
+	}
+
+	return result;
+}
+
+int qed_init_vport_tc_wfq(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
+			  u16 first_tx_pq_id, u16 wfq)
+{
+	u32 inc_val;
+
+	if (first_tx_pq_id == QM_INVALID_PQ_ID)
+		return -1;
+
+	inc_val = QM_VP_WFQ_INC_VAL(wfq);
+	if (!inc_val || inc_val > QM_VP_WFQ_MAX_INC_VAL) {
 		DP_NOTICE(p_hwfn, "Invalid VPORT WFQ configuration.\n");
 		return -1;
 	}
 
-	/* A VPORT can have several VPORT PQ IDs for various TCs */
-	for (tc = 0; tc < NUM_OF_TCS; tc++) {
-		vport_pq_id = first_tx_pq_id[tc];
-		if (vport_pq_id != QM_INVALID_PQ_ID)
-			qed_wr(p_hwfn,
-			       p_ptt,
-			       QM_REG_WFQVPWEIGHT + vport_pq_id * 4, inc_val);
-	}
+	qed_wr(p_hwfn, p_ptt, QM_REG_WFQVPCRD + first_tx_pq_id * 4,
+	       (u32)QM_WFQ_CRD_REG_SIGN_BIT);
+	qed_wr(p_hwfn, p_ptt, QM_REG_WFQVPUPPERBOUND + first_tx_pq_id * 4,
+	       inc_val | QM_WFQ_CRD_REG_SIGN_BIT);
+	qed_wr(p_hwfn, p_ptt, QM_REG_WFQVPWEIGHT + first_tx_pq_id * 4,
+	       inc_val);
 
 	return 0;
 }
@@ -923,16 +1037,24 @@ int qed_init_global_rl(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt, u16 rl_id, u32 rate_limit,
 		       enum init_qm_rl_type vport_rl_type)
 {
-	u32 inc_val;
+	u32 inc_val, upper_bound;
 
+	upper_bound =
+	    (vport_rl_type ==
+	     QM_RL_TYPE_QCN) ? QM_GLOBAL_RL_UPPER_BOUND(QM_MAX_LINK_SPEED) :
+	    QM_INITIAL_VOQ_BYTE_CRD;
 	inc_val = QM_RL_INC_VAL(rate_limit);
-	if (inc_val > QM_VP_RL_MAX_INC_VAL(rate_limit)) {
-		DP_NOTICE(p_hwfn, "Invalid rate limit configuration.\n");
+	if (inc_val > upper_bound) {
+		DP_NOTICE(p_hwfn, "Invalid VPORT rate limit configuration.\n");
 		return -1;
 	}
 
 	qed_wr(p_hwfn, p_ptt,
 	       QM_REG_RLGLBLCRD + rl_id * 4, (u32)QM_RL_CRD_REG_SIGN_BIT);
+	qed_wr(p_hwfn,
+	       p_ptt,
+	       QM_REG_RLGLBLUPPERBOUND + rl_id * 4,
+	       upper_bound | (u32)QM_RL_CRD_REG_SIGN_BIT);
 	qed_wr(p_hwfn, p_ptt, QM_REG_RLGLBLINCVAL + rl_id * 4, inc_val);
 
 	return 0;
@@ -1014,7 +1136,7 @@ bool qed_send_qm_stop_cmd(struct qed_hwfn *p_hwfn,
 static int qed_dmae_to_grc(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 			   __le32 *p_data, u32 addr, u32 len_in_dwords)
 {
-	struct qed_dmae_params params = {};
+	struct qed_dmae_params params = { 0 };
 	u32 *data_cpu;
 	int rc;
 
@@ -1067,16 +1189,16 @@ void qed_set_vxlan_enable(struct qed_hwfn *p_hwfn,
 
 	/* Update PRS register */
 	reg_val = qed_rd(p_hwfn, p_ptt, PRS_REG_ENCAPSULATION_TYPE_EN);
-	shift = PRS_REG_ENCAPSULATION_TYPE_EN_VXLAN_ENABLE_SHIFT;
-	SET_TUNNEL_TYPE_ENABLE_BIT(reg_val, shift, vxlan_enable);
+	SET_FIELD(reg_val,
+		  PRS_REG_ENCAPSULATION_TYPE_EN_VXLAN_ENABLE, vxlan_enable);
 	qed_wr(p_hwfn, p_ptt, PRS_REG_ENCAPSULATION_TYPE_EN, reg_val);
 	if (reg_val) {
 		reg_val =
-		    qed_rd(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0_BB_K2);
+		    qed_rd(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0);
 
 		/* Update output  only if tunnel blocks not included. */
 		if (reg_val == (u32)PRS_ETH_OUTPUT_FORMAT)
-			qed_wr(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0_BB_K2,
+			qed_wr(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0,
 			       (u32)PRS_ETH_TUNN_OUTPUT_FORMAT);
 	}
 
@@ -1100,18 +1222,20 @@ void qed_set_gre_enable(struct qed_hwfn *p_hwfn,
 
 	/* Update PRS register */
 	reg_val = qed_rd(p_hwfn, p_ptt, PRS_REG_ENCAPSULATION_TYPE_EN);
-	shift = PRS_REG_ENCAPSULATION_TYPE_EN_ETH_OVER_GRE_ENABLE_SHIFT;
-	SET_TUNNEL_TYPE_ENABLE_BIT(reg_val, shift, eth_gre_enable);
-	shift = PRS_REG_ENCAPSULATION_TYPE_EN_IP_OVER_GRE_ENABLE_SHIFT;
-	SET_TUNNEL_TYPE_ENABLE_BIT(reg_val, shift, ip_gre_enable);
+	SET_FIELD(reg_val,
+		  PRS_REG_ENCAPSULATION_TYPE_EN_ETH_OVER_GRE_ENABLE,
+		  eth_gre_enable);
+	SET_FIELD(reg_val,
+		  PRS_REG_ENCAPSULATION_TYPE_EN_IP_OVER_GRE_ENABLE,
+		  ip_gre_enable);
 	qed_wr(p_hwfn, p_ptt, PRS_REG_ENCAPSULATION_TYPE_EN, reg_val);
 	if (reg_val) {
 		reg_val =
-		    qed_rd(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0_BB_K2);
+		    qed_rd(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0);
 
 		/* Update output  only if tunnel blocks not included. */
 		if (reg_val == (u32)PRS_ETH_OUTPUT_FORMAT)
-			qed_wr(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0_BB_K2,
+			qed_wr(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0,
 			       (u32)PRS_ETH_TUNN_OUTPUT_FORMAT);
 	}
 
@@ -1149,22 +1273,23 @@ void qed_set_geneve_enable(struct qed_hwfn *p_hwfn,
 			   bool eth_geneve_enable, bool ip_geneve_enable)
 {
 	u32 reg_val;
-	u8 shift;
 
 	/* Update PRS register */
 	reg_val = qed_rd(p_hwfn, p_ptt, PRS_REG_ENCAPSULATION_TYPE_EN);
-	shift = PRS_REG_ENCAPSULATION_TYPE_EN_ETH_OVER_GENEVE_ENABLE_SHIFT;
-	SET_TUNNEL_TYPE_ENABLE_BIT(reg_val, shift, eth_geneve_enable);
-	shift = PRS_REG_ENCAPSULATION_TYPE_EN_IP_OVER_GENEVE_ENABLE_SHIFT;
-	SET_TUNNEL_TYPE_ENABLE_BIT(reg_val, shift, ip_geneve_enable);
+	SET_FIELD(reg_val,
+		  PRS_REG_ENCAPSULATION_TYPE_EN_ETH_OVER_GENEVE_ENABLE,
+		  eth_geneve_enable);
+	SET_FIELD(reg_val,
+		  PRS_REG_ENCAPSULATION_TYPE_EN_IP_OVER_GENEVE_ENABLE,
+		  ip_geneve_enable);
 	qed_wr(p_hwfn, p_ptt, PRS_REG_ENCAPSULATION_TYPE_EN, reg_val);
 	if (reg_val) {
 		reg_val =
-		    qed_rd(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0_BB_K2);
+		    qed_rd(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0);
 
 		/* Update output  only if tunnel blocks not included. */
 		if (reg_val == (u32)PRS_ETH_OUTPUT_FORMAT)
-			qed_wr(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0_BB_K2,
+			qed_wr(p_hwfn, p_ptt, PRS_REG_OUTPUT_FORMAT_4_0,
 			       (u32)PRS_ETH_TUNN_OUTPUT_FORMAT);
 	}
 
@@ -1180,16 +1305,16 @@ void qed_set_geneve_enable(struct qed_hwfn *p_hwfn,
 	/* Update DORQ registers */
 	qed_wr(p_hwfn,
 	       p_ptt,
-	       DORQ_REG_L2_EDPM_TUNNEL_NGE_ETH_EN_K2_E5,
+	       DORQ_REG_L2_EDPM_TUNNEL_NGE_ETH_EN_K2,
 	       eth_geneve_enable ? 1 : 0);
 	qed_wr(p_hwfn,
 	       p_ptt,
-	       DORQ_REG_L2_EDPM_TUNNEL_NGE_IP_EN_K2_E5,
+	       DORQ_REG_L2_EDPM_TUNNEL_NGE_IP_EN_K2,
 	       ip_geneve_enable ? 1 : 0);
 }
 
 #define PRS_ETH_VXLAN_NO_L2_ENABLE_OFFSET      3
-#define PRS_ETH_VXLAN_NO_L2_OUTPUT_FORMAT   -925189872
+#define PRS_ETH_VXLAN_NO_L2_OUTPUT_FORMAT   0xC8DAB910
 
 void qed_set_vxlan_no_l2_enable(struct qed_hwfn *p_hwfn,
 				struct qed_ptt *p_ptt, bool enable)
@@ -1209,7 +1334,7 @@ void qed_set_vxlan_no_l2_enable(struct qed_hwfn *p_hwfn,
 		/* update PRS FIC  register */
 		qed_wr(p_hwfn,
 		       p_ptt,
-		       PRS_REG_OUTPUT_FORMAT_4_0_BB_K2,
+		       PRS_REG_OUTPUT_FORMAT_4_0,
 		       (u32)PRS_ETH_VXLAN_NO_L2_OUTPUT_FORMAT);
 	} else {
 		/* clear VXLAN_NO_L2_ENABLE flag */
@@ -1230,7 +1355,7 @@ void qed_set_vxlan_no_l2_enable(struct qed_hwfn *p_hwfn,
 
 void qed_gft_disable(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt, u16 pf_id)
 {
-	struct regpair ram_line = { };
+	struct regpair ram_line = { 0 };
 
 	/* Disable gft search for PF */
 	qed_wr(p_hwfn, p_ptt, PRS_REG_SEARCH_GFT, 0);
@@ -1622,6 +1747,8 @@ struct phys_mem_desc *qed_fw_overlay_mem_alloc(struct qed_hwfn *p_hwfn,
 		storm_buf_size = GET_FIELD(hdr->data,
 					   FW_OVERLAY_BUF_HDR_BUF_SIZE);
 		storm_id = GET_FIELD(hdr->data, FW_OVERLAY_BUF_HDR_STORM_ID);
+		if (storm_id >= NUM_STORMS)
+			break;
 		storm_mem_desc = allocated_mem + storm_id;
 		storm_mem_desc->size = storm_buf_size * sizeof(u32);
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_ops.c b/drivers/net/ethernet/qlogic/qed/qed_init_ops.c
index 7e6c6389523b..b3bf9899c1a1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_ops.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_ops.c
@@ -15,6 +15,7 @@
 #include "qed_hsi.h"
 #include "qed_hw.h"
 #include "qed_init_ops.h"
+#include "qed_iro_hsi.h"
 #include "qed_reg_addr.h"
 #include "qed_sriov.h"
 
@@ -46,30 +47,32 @@ static u32 pxp_global_win[] = {
 /* IRO Array */
 static const u32 iro_arr[] = {
 	0x00000000, 0x00000000, 0x00080000,
+	0x00004478, 0x00000008, 0x00080000,
 	0x00003288, 0x00000088, 0x00880000,
-	0x000058e8, 0x00000020, 0x00200000,
+	0x000058a8, 0x00000020, 0x00200000,
+	0x00003188, 0x00000008, 0x00080000,
 	0x00000b00, 0x00000008, 0x00040000,
 	0x00000a80, 0x00000008, 0x00040000,
 	0x00000000, 0x00000008, 0x00020000,
 	0x00000080, 0x00000008, 0x00040000,
 	0x00000084, 0x00000008, 0x00020000,
-	0x00005718, 0x00000004, 0x00040000,
-	0x00004dd0, 0x00000000, 0x00780000,
+	0x00005798, 0x00000004, 0x00040000,
+	0x00004e50, 0x00000000, 0x00780000,
 	0x00003e40, 0x00000000, 0x00780000,
-	0x00004480, 0x00000000, 0x00780000,
+	0x00004500, 0x00000000, 0x00780000,
 	0x00003210, 0x00000000, 0x00780000,
 	0x00003b50, 0x00000000, 0x00780000,
 	0x00007f58, 0x00000000, 0x00780000,
-	0x00005f58, 0x00000000, 0x00080000,
+	0x00005fd8, 0x00000000, 0x00080000,
 	0x00007100, 0x00000000, 0x00080000,
-	0x0000aea0, 0x00000000, 0x00080000,
+	0x0000af20, 0x00000000, 0x00080000,
 	0x00004398, 0x00000000, 0x00080000,
 	0x0000a5a0, 0x00000000, 0x00080000,
 	0x0000bde8, 0x00000000, 0x00080000,
 	0x00000020, 0x00000004, 0x00040000,
-	0x000056c8, 0x00000010, 0x00100000,
+	0x00005688, 0x00000010, 0x00100000,
 	0x0000c210, 0x00000030, 0x00300000,
-	0x0000b088, 0x00000038, 0x00380000,
+	0x0000b108, 0x00000038, 0x00380000,
 	0x00003d20, 0x00000080, 0x00400000,
 	0x0000bf60, 0x00000000, 0x00040000,
 	0x00004560, 0x00040080, 0x00040000,
@@ -77,11 +80,11 @@ static const u32 iro_arr[] = {
 	0x00003d60, 0x00000080, 0x00200000,
 	0x00008960, 0x00000040, 0x00300000,
 	0x0000e840, 0x00000060, 0x00600000,
-	0x00004618, 0x00000080, 0x00380000,
-	0x00010738, 0x000000c0, 0x00c00000,
+	0x00004698, 0x00000080, 0x00380000,
+	0x000107b8, 0x000000c0, 0x00c00000,
 	0x000001f8, 0x00000002, 0x00020000,
-	0x0000a2a0, 0x00000000, 0x01080000,
-	0x0000a3a8, 0x00000008, 0x00080000,
+	0x0000a260, 0x00000000, 0x01080000,
+	0x0000a368, 0x00000008, 0x00080000,
 	0x000001c0, 0x00000008, 0x00080000,
 	0x000001f8, 0x00000008, 0x00080000,
 	0x00000ac0, 0x00000008, 0x00080000,
@@ -90,39 +93,46 @@ static const u32 iro_arr[] = {
 	0x00000280, 0x00000008, 0x00080000,
 	0x00000680, 0x00080018, 0x00080000,
 	0x00000b78, 0x00080018, 0x00020000,
-	0x0000c640, 0x00000050, 0x003c0000,
-	0x00012038, 0x00000018, 0x00100000,
-	0x00011b00, 0x00000040, 0x00180000,
-	0x000095d0, 0x00000050, 0x00200000,
+	0x0000c600, 0x00000058, 0x003c0000,
+	0x00012038, 0x00000020, 0x00100000,
+	0x00011b00, 0x00000048, 0x00180000,
+	0x00009650, 0x00000050, 0x00200000,
 	0x00008b10, 0x00000040, 0x00280000,
-	0x00011640, 0x00000018, 0x00100000,
-	0x0000c828, 0x00000048, 0x00380000,
-	0x00011710, 0x00000020, 0x00200000,
-	0x00004650, 0x00000080, 0x00100000,
+	0x000116c0, 0x00000018, 0x00100000,
+	0x0000c808, 0x00000048, 0x00380000,
+	0x00011790, 0x00000020, 0x00200000,
+	0x000046d0, 0x00000080, 0x00100000,
 	0x00003618, 0x00000010, 0x00100000,
-	0x0000a968, 0x00000008, 0x00010000,
+	0x0000a9e8, 0x00000008, 0x00010000,
 	0x000097a0, 0x00000008, 0x00010000,
-	0x00011990, 0x00000008, 0x00010000,
-	0x0000f018, 0x00000008, 0x00010000,
-	0x00012628, 0x00000008, 0x00010000,
-	0x00011da8, 0x00000008, 0x00010000,
-	0x0000aa78, 0x00000030, 0x00100000,
-	0x0000d768, 0x00000028, 0x00280000,
-	0x00009a58, 0x00000018, 0x00180000,
-	0x00009bd8, 0x00000008, 0x00080000,
-	0x00013a18, 0x00000008, 0x00080000,
-	0x000126e8, 0x00000018, 0x00180000,
-	0x0000e608, 0x00500288, 0x00100000,
-	0x00012970, 0x00000138, 0x00280000,
+	0x00011a10, 0x00000008, 0x00010000,
+	0x0000e9f8, 0x00000008, 0x00010000,
+	0x00012648, 0x00000008, 0x00010000,
+	0x000121c8, 0x00000008, 0x00010000,
+	0x0000af08, 0x00000030, 0x00100000,
+	0x0000d748, 0x00000028, 0x00280000,
+	0x00009e68, 0x00000018, 0x00180000,
+	0x00009fe8, 0x00000008, 0x00080000,
+	0x00013ea8, 0x00000008, 0x00080000,
+	0x00012f18, 0x00000018, 0x00180000,
+	0x0000dfe8, 0x00500288, 0x00100000,
+	0x000131a0, 0x00000138, 0x00280000,
 };
 
 void qed_init_iro_array(struct qed_dev *cdev)
 {
-	cdev->iro_arr = iro_arr;
+	cdev->iro_arr = iro_arr + E4_IRO_ARR_OFFSET;
 }
 
 void qed_init_store_rt_reg(struct qed_hwfn *p_hwfn, u32 rt_offset, u32 val)
 {
+	if (rt_offset >= RUNTIME_ARRAY_SIZE) {
+		DP_ERR(p_hwfn,
+		       "Avoid storing %u in rt_data at index %u!\n",
+		       val, rt_offset);
+		return;
+	}
+
 	p_hwfn->rt_data.init_val[rt_offset] = val;
 	p_hwfn->rt_data.b_valid[rt_offset] = true;
 }
@@ -132,6 +142,14 @@ void qed_init_store_rt_agg(struct qed_hwfn *p_hwfn,
 {
 	size_t i;
 
+	if ((rt_offset + size - 1) >= RUNTIME_ARRAY_SIZE) {
+		DP_ERR(p_hwfn,
+		       "Avoid storing values in rt_data at indices %u-%u!\n",
+		       rt_offset,
+		       (u32)(rt_offset + size - 1));
+		return;
+	}
+
 	for (i = 0; i < size / sizeof(u32); i++) {
 		p_hwfn->rt_data.init_val[rt_offset + i] = p_val[i];
 		p_hwfn->rt_data.b_valid[rt_offset + i]	= true;
@@ -175,7 +193,7 @@ static int qed_init_rt(struct qed_hwfn	*p_hwfn,
 			return rc;
 
 		/* invalidate after writing */
-		for (j = i; j < i + segment; j++)
+		for (j = i; j < (u32)(i + segment); j++)
 			p_valid[j] = false;
 
 		/* Jump over the entire segment, including invalid entry */
@@ -245,7 +263,7 @@ static int qed_init_array_dmae(struct qed_hwfn *p_hwfn,
 
 static int qed_init_fill_dmae(struct qed_hwfn *p_hwfn,
 			      struct qed_ptt *p_ptt,
-			      u32 addr, u32 fill, u32 fill_count)
+			      u32 addr, u32 fill_count)
 {
 	static u32 zero_buffer[DMAE_MAX_RW_SIZE];
 	struct qed_dmae_params params = {};
@@ -372,7 +390,7 @@ static int qed_init_cmd_wr(struct qed_hwfn *p_hwfn,
 	case INIT_SRC_ZEROS:
 		data = le32_to_cpu(p_cmd->args.zeros_count);
 		if (b_must_dmae || (b_can_dmae && (data >= 64)))
-			rc = qed_init_fill_dmae(p_hwfn, p_ptt, addr, 0, data);
+			rc = qed_init_fill_dmae(p_hwfn, p_ptt, addr, data);
 		else
 			qed_init_fill(p_hwfn, p_ptt, addr, 0, data);
 		break;
@@ -419,7 +437,6 @@ static void qed_init_cmd_rd(struct qed_hwfn *p_hwfn,
 	addr = GET_FIELD(data, INIT_READ_OP_ADDRESS) << 2;
 	poll = GET_FIELD(data, INIT_READ_OP_POLL_TYPE);
 
-
 	val = qed_rd(p_hwfn, p_ptt, addr);
 
 	if (poll == INIT_POLL_NONE)
@@ -515,8 +532,7 @@ static u32 qed_init_cmd_mode(struct qed_hwfn *p_hwfn,
 				 INIT_IF_MODE_OP_CMD_OFFSET);
 }
 
-static u32 qed_init_cmd_phase(struct qed_hwfn *p_hwfn,
-			      struct init_if_phase_op *p_cmd,
+static u32 qed_init_cmd_phase(struct init_if_phase_op *p_cmd,
 			      u32 phase, u32 phase_id)
 {
 	u32 data = le32_to_cpu(p_cmd->phase_data);
@@ -563,7 +579,7 @@ int qed_init_run(struct qed_hwfn *p_hwfn,
 						     modes);
 			break;
 		case INIT_OP_IF_PHASE:
-			cmd_num += qed_init_cmd_phase(p_hwfn, &cmd->if_phase,
+			cmd_num += qed_init_cmd_phase(&cmd->if_phase,
 						      phase, phase_id);
 			break;
 		case INIT_OP_DELAY:
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_ops.h b/drivers/net/ethernet/qlogic/qed/qed_init_ops.h
index a573c8921982..e1cc7b9dbc05 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_ops.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_ops.h
@@ -87,7 +87,7 @@ void qed_init_store_rt_agg(struct qed_hwfn *p_hwfn,
 			   size_t size);
 
 #define STORE_RT_REG_AGG(hwfn, offset, val) \
-	qed_init_store_rt_agg(hwfn, offset, (u32 *)&val, sizeof(val))
+	qed_init_store_rt_agg(hwfn, offset, (u32 *)&(val), sizeof(val))
 
 /**
  * @brief
diff --git a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
index fd338a8dbedc..7f668ecd73fe 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -126,6 +126,8 @@
 	0x1009c4UL
 #define  QM_REG_PF_EN \
 	0x2f2ea4UL
+#define QM_REG_RLGLBLUPPERBOUND \
+	0x2f3c00UL
 #define TCFC_REG_WEAK_ENABLE_VF \
 	0x2d0704UL
 #define  TCFC_REG_STRONG_ENABLE_PF \
@@ -576,7 +578,7 @@
 #define PRS_REG_ENCAPSULATION_TYPE_EN	0x1f0730UL
 #define PRS_REG_GRE_PROTOCOL		0x1f0734UL
 #define PRS_REG_VXLAN_PORT		0x1f0738UL
-#define PRS_REG_OUTPUT_FORMAT_4_0_BB_K2	0x1f099cUL
+#define PRS_REG_OUTPUT_FORMAT_4_0	0x1f099cUL
 #define NIG_REG_ENC_TYPE_ENABLE		0x501058UL
 
 #define NIG_REG_ENC_TYPE_ENABLE_ETH_OVER_GRE_ENABLE		(0x1 << 0)
@@ -595,8 +597,9 @@
 #define DORQ_REG_L2_EDPM_TUNNEL_GRE_ETH_EN		0x10090cUL
 #define DORQ_REG_L2_EDPM_TUNNEL_GRE_IP_EN		0x100910UL
 #define DORQ_REG_L2_EDPM_TUNNEL_VXLAN_EN		0x100914UL
-#define DORQ_REG_L2_EDPM_TUNNEL_NGE_IP_EN_K2_E5		0x10092cUL
-#define DORQ_REG_L2_EDPM_TUNNEL_NGE_ETH_EN_K2_E5	0x100930UL
+#define DORQ_REG_L2_EDPM_TUNNEL_NGE_IP_EN_K2		0x10092cUL
+#define DORQ_REG_L2_EDPM_TUNNEL_NGE_ETH_EN_K2		0x100930UL
+
 
 #define NIG_REG_NGE_IP_ENABLE			0x508b28UL
 #define NIG_REG_NGE_ETH_ENABLE			0x508b2cUL
@@ -606,7 +609,10 @@
 
 #define QM_REG_WFQPFWEIGHT	0x2f4e80UL
 #define QM_REG_WFQVPWEIGHT	0x2fa000UL
-
+#define QM_REG_WFQVPUPPERBOUND \
+	0x2fb000UL
+#define QM_REG_WFQVPCRD \
+	0x2fc000UL
 #define PGLCS_REG_DBG_SELECT_K2_E5 \
 	0x001d14UL
 #define PGLCS_REG_DBG_DWORD_ENABLE_K2_E5 \
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index d0104a5e9ecf..47567441be3f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -3580,48 +3580,73 @@ qed_iov_vf_flr_poll_dorq(struct qed_hwfn *p_hwfn,
 	return 0;
 }
 
+#define MAX_NUM_EXT_VOQS        (MAX_NUM_PORTS * NUM_OF_TCS)
+
 static int
 qed_iov_vf_flr_poll_pbf(struct qed_hwfn *p_hwfn,
 			struct qed_vf_info *p_vf, struct qed_ptt *p_ptt)
 {
-	u32 cons[MAX_NUM_VOQS], distance[MAX_NUM_VOQS];
-	int i, cnt;
+	u32 prod, cons[MAX_NUM_EXT_VOQS], distance[MAX_NUM_EXT_VOQS], tmp;
+	u8 max_phys_tcs_per_port = p_hwfn->qm_info.max_phys_tcs_per_port;
+	u8 max_ports_per_engine = p_hwfn->cdev->num_ports_in_engine;
+	u32 prod_voq0_addr = PBF_REG_NUM_BLOCKS_ALLOCATED_PROD_VOQ0;
+	u32 cons_voq0_addr = PBF_REG_NUM_BLOCKS_ALLOCATED_CONS_VOQ0;
+	u8 port_id, tc, tc_id = 0, voq = 0;
+	int cnt;
 
-	/* Read initial consumers & producers */
-	for (i = 0; i < MAX_NUM_VOQS; i++) {
-		u32 prod;
+	memset(cons, 0, MAX_NUM_EXT_VOQS * sizeof(u32));
+	memset(distance, 0, MAX_NUM_EXT_VOQS * sizeof(u32));
 
-		cons[i] = qed_rd(p_hwfn, p_ptt,
-				 PBF_REG_NUM_BLOCKS_ALLOCATED_CONS_VOQ0 +
-				 i * 0x40);
-		prod = qed_rd(p_hwfn, p_ptt,
-			      PBF_REG_NUM_BLOCKS_ALLOCATED_PROD_VOQ0 +
-			      i * 0x40);
-		distance[i] = prod - cons[i];
+	/* Read initial consumers & producers */
+	for (port_id = 0; port_id < max_ports_per_engine; port_id++) {
+		/* "max_phys_tcs_per_port" active TCs + 1 pure LB TC */
+		for (tc = 0; tc < max_phys_tcs_per_port + 1; tc++) {
+			tc_id = (tc < max_phys_tcs_per_port) ? tc : PURE_LB_TC;
+			voq = VOQ(port_id, tc_id, max_phys_tcs_per_port);
+			cons[voq] = qed_rd(p_hwfn, p_ptt,
+					   cons_voq0_addr + voq * 0x40);
+			prod = qed_rd(p_hwfn, p_ptt,
+				      prod_voq0_addr + voq * 0x40);
+			distance[voq] = prod - cons[voq];
+		}
 	}
 
 	/* Wait for consumers to pass the producers */
-	i = 0;
+	port_id = 0;
+	tc = 0;
 	for (cnt = 0; cnt < 50; cnt++) {
-		for (; i < MAX_NUM_VOQS; i++) {
-			u32 tmp;
+		for (; port_id < max_ports_per_engine; port_id++) {
+			/* "max_phys_tcs_per_port" active TCs + 1 pure LB TC */
+			for (; tc < max_phys_tcs_per_port + 1; tc++) {
+				tc_id = (tc < max_phys_tcs_per_port) ?
+				    tc : PURE_LB_TC;
+				voq = VOQ(port_id,
+					  tc_id, max_phys_tcs_per_port);
+				tmp = qed_rd(p_hwfn, p_ptt,
+					     cons_voq0_addr + voq * 0x40);
+				if (distance[voq] > tmp - cons[voq])
+					break;
+			}
 
-			tmp = qed_rd(p_hwfn, p_ptt,
-				     PBF_REG_NUM_BLOCKS_ALLOCATED_CONS_VOQ0 +
-				     i * 0x40);
-			if (distance[i] > tmp - cons[i])
+			if (tc == max_phys_tcs_per_port + 1)
+				tc = 0;
+			else
 				break;
 		}
 
-		if (i == MAX_NUM_VOQS)
+		if (port_id == max_ports_per_engine)
 			break;
 
 		msleep(20);
 	}
 
 	if (cnt == 50) {
-		DP_ERR(p_hwfn, "VF[%d] - pbf polling failed on VOQ %d\n",
-		       p_vf->abs_vf_id, i);
+		DP_ERR(p_hwfn, "VF[%d]: pbf poll failed on VOQ%d\n",
+		       p_vf->abs_vf_id, (int)voq);
+
+		DP_ERR(p_hwfn, "VOQ %d has port_id as %d and tc_id as %d]\n",
+		       (int)voq, (int)port_id, (int)tc_id);
+
 		return -EBUSY;
 	}
 
-- 
2.24.1

