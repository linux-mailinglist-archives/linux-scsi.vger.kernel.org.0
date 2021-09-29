Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CE41C491
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Sep 2021 14:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbhI2MRk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Sep 2021 08:17:40 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:42064 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343757AbhI2MQg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Sep 2021 08:16:36 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T8e7Fi008377;
        Wed, 29 Sep 2021 05:13:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=7FZ6V0DsriNVWngLxJOmVY51Xf2lFnoQzrUh3rmBX/0=;
 b=JlOb0BsbyBuKLxuq2kUV25jc9c0XvnaVWEHk7JnCfgZxcW9TRHzrjU4ntRMfvHfCj0Lp
 hvMEH1tI0It/zUqGFzIPtiWdobW0mBnVQmarGGVm/2pe0bKw8SYOt3YykxuHIHbXlDTm
 XSZw+OyuH3SymBJCgXF889PH/B7FEeSLRsTvOMD5nahXUjGy9pa3ZIL31hqkOPTQjygd
 16d/vS3v+7Jal7hC0SSo2ekoOo89K50fdLCK85ywKIssSKFXdtRKRxSBpWN4NEESFS/O
 W8RT67PFRcbkmEvYPtPn+xHGV7EK6Xq/eUv9lQOjv2lp/YZJAMzFndACVj1Iii6TTibq vg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bcfd4a0b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 05:13:07 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Sep
 2021 05:13:04 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Wed, 29 Sep 2021 05:13:01 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <aelior@marvell.com>,
        <smalin@marvell.com>, <jhasan@marvell.com>,
        <mrangankar@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>,
        Omkar Kulkarni <okulkarni@marvell.com>
Subject: [PATCH 09/12] qed: Update debug related changes
Date:   Wed, 29 Sep 2021 15:12:12 +0300
Message-ID: <20210929121215.17864-10-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210929121215.17864-1-pkushwaha@marvell.com>
References: <20210929121215.17864-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: W66eFa_DNQWJqnian9VYsBj-ScHFaC7K
X-Proofpoint-ORIG-GUID: W66eFa_DNQWJqnian9VYsBj-ScHFaC7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_05,2021-09-29_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

qed_debug features are updated to support FW version 8.59.1.0 along
with few enhancements.
  - Removal of _BB_K2 from register defines.
  - Add new condition cond14.
  - Add dump of new area sw-platform, epoch, iscsi_task_pages,
    fcoe_task_pages, roce_task_pages and eth_task_pages.
  - Introduced new functions qed_dbg_phy_size().
  - Update in qed_mcp_nvm_rd_cmd() declaration.
  - Allow QED to control init/exit at pf level.
  - Dump partial "ILT-dump" if buffer size is not sufficient.

This patch also fixes the existing checkpatch warnings and few important
checks.

Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed.h         |    1 +
 drivers/net/ethernet/qlogic/qed/qed_cxt.h     |    5 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c   | 1389 +++++++++++------
 drivers/net/ethernet/qlogic/qed/qed_debug.h   |    7 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c    |    5 +
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     |   48 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h     |   11 +-
 .../net/ethernet/qlogic/qed/qed_reg_addr.h    |   81 +-
 8 files changed, 1038 insertions(+), 509 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index 91d5ce75a549..b9c4cb13d64c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -1002,4 +1002,5 @@ int qed_llh_add_dst_tcp_port_filter(struct qed_dev *cdev, u16 dest_port);
 void qed_llh_remove_src_tcp_port_filter(struct qed_dev *cdev, u16 src_port);
 void qed_llh_remove_dst_tcp_port_filter(struct qed_dev *cdev, u16 src_port);
 void qed_llh_clear_all_filters(struct qed_dev *cdev);
+unsigned long qed_get_epoch_time(void);
 #endif /* _QED_H */
diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.h b/drivers/net/ethernet/qlogic/qed/qed_cxt.h
index 8adb7ed0c12d..cd0bf739b2e3 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.h
@@ -334,7 +334,10 @@ struct qed_cxt_mngr {
 	/* Maximal number of L2 steering filters */
 	u32 arfs_count;
 
-	u8 task_type_id;
+	u16 iscsi_task_pages;
+	u16 fcoe_task_pages;
+	u16 roce_task_pages;
+	u16 eth_task_pages;
 	u16 task_ctx_size;
 	u16 conn_ctx_size;
 };
diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index e6e5c7721701..77fda7893b0a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 /* QLogic qed NIC Driver
  * Copyright (c) 2015 QLogic Corporation
- * Copyright (c) 2019-2020 Marvell International Ltd.
+ * Copyright (c) 2019-2021 Marvell International Ltd.
  */
 
 #include <linux/module.h>
@@ -122,6 +122,11 @@ static u32 cond0(const u32 *r, const u32 *imm)
 	return (r[0] & ~r[1]) != imm[0];
 }
 
+static u32 cond14(const u32 *r, const u32 *imm)
+{
+	return (r[0] | imm[0]) != imm[1];
+}
+
 static u32 cond1(const u32 *r, const u32 *imm)
 {
 	return r[0] != imm[0];
@@ -173,6 +178,7 @@ static u32(*cond_arr[]) (const u32 *r, const u32 *imm) = {
 	cond11,
 	cond12,
 	cond13,
+	cond14,
 };
 
 #define NUM_PHYS_BLOCKS 84
@@ -209,10 +215,61 @@ enum dbg_bus_frame_modes {
 	DBG_BUS_NUM_FRAME_MODES
 };
 
+/* Debug bus SEMI frame modes */
+enum dbg_bus_semi_frame_modes {
+	DBG_BUS_SEMI_FRAME_MODE_4FAST = 0,	/* 4 fast dw */
+	DBG_BUS_SEMI_FRAME_MODE_2FAST_2SLOW = 1, /* 2 fast dw, 2 slow dw */
+	DBG_BUS_SEMI_FRAME_MODE_1FAST_3SLOW = 2, /* 1 fast dw,3 slow dw */
+	DBG_BUS_SEMI_FRAME_MODE_4SLOW = 3,	/* 4 slow dw */
+	DBG_BUS_SEMI_NUM_FRAME_MODES
+};
+
+/* Debug bus filter types */
+enum dbg_bus_filter_types {
+	DBG_BUS_FILTER_TYPE_OFF,	/* Filter always off */
+	DBG_BUS_FILTER_TYPE_PRE,	/* Filter before trigger only */
+	DBG_BUS_FILTER_TYPE_POST,	/* Filter after trigger only */
+	DBG_BUS_FILTER_TYPE_ON	/* Filter always on */
+};
+
+/* Debug bus pre-trigger recording types */
+enum dbg_bus_pre_trigger_types {
+	DBG_BUS_PRE_TRIGGER_FROM_ZERO,	/* Record from time 0 */
+	DBG_BUS_PRE_TRIGGER_NUM_CHUNKS,	/* Record some chunks before trigger */
+	DBG_BUS_PRE_TRIGGER_DROP	/* Drop data before trigger */
+};
+
+/* Debug bus post-trigger recording types */
+enum dbg_bus_post_trigger_types {
+	DBG_BUS_POST_TRIGGER_RECORD,	/* Start recording after trigger */
+	DBG_BUS_POST_TRIGGER_DROP	/* Drop data after trigger */
+};
+
+/* Debug bus other engine mode */
+enum dbg_bus_other_engine_modes {
+	DBG_BUS_OTHER_ENGINE_MODE_NONE,
+	DBG_BUS_OTHER_ENGINE_MODE_DOUBLE_BW_TX,
+	DBG_BUS_OTHER_ENGINE_MODE_DOUBLE_BW_RX,
+	DBG_BUS_OTHER_ENGINE_MODE_CROSS_ENGINE_TX,
+	DBG_BUS_OTHER_ENGINE_MODE_CROSS_ENGINE_RX
+};
+
+/* DBG block Framing mode definitions */
+struct framing_mode_defs {
+	u8 id;
+	u8 blocks_dword_mask;
+	u8 storms_dword_mask;
+	u8 semi_framing_mode_id;
+	u8 full_buf_thr;
+};
+
 /* Chip constant definitions */
 struct chip_defs {
 	const char *name;
+	u8 dwords_per_cycle;
+	u8 num_framing_modes;
 	u32 num_ilt_pages;
+	struct framing_mode_defs *framing_modes;
 };
 
 /* HW type constant definitions */
@@ -335,7 +392,7 @@ struct split_type_defs {
 #define FIELD_BIT_OFFSET(type, field)	type ## _ ## field ## _ ## OFFSET
 #define FIELD_BIT_SIZE(type, field)	type ## _ ## field ## _ ## SIZE
 #define FIELD_DWORD_OFFSET(type, field) \
-	 (int)(FIELD_BIT_OFFSET(type, field) / 32)
+	 ((int)(FIELD_BIT_OFFSET(type, field) / 32))
 #define FIELD_DWORD_SHIFT(type, field)	(FIELD_BIT_OFFSET(type, field) % 32)
 #define FIELD_BIT_MASK(type, field) \
 	(((1 << FIELD_BIT_SIZE(type, field)) - 1) << \
@@ -432,11 +489,13 @@ struct split_type_defs {
 
 #define STATIC_DEBUG_LINE_DWORDS	9
 
-#define NUM_COMMON_GLOBAL_PARAMS	9
+#define NUM_COMMON_GLOBAL_PARAMS	11
 
 #define MAX_RECURSION_DEPTH		10
 
+#define FW_IMG_KUKU                     0
 #define FW_IMG_MAIN			1
+#define FW_IMG_L2B                      2
 
 #define REG_FIFO_ELEMENT_DWORDS		2
 #define REG_FIFO_DEPTH_ELEMENTS		32
@@ -465,10 +524,25 @@ struct split_type_defs {
 
 /***************************** Constant Arrays *******************************/
 
+/* DBG block framing mode definitions, in descending preference order */
+static struct framing_mode_defs s_framing_mode_defs[4] = {
+	{DBG_BUS_FRAME_MODE_4ST, 0x0, 0xf,
+	 DBG_BUS_SEMI_FRAME_MODE_4FAST,
+	 10},
+	{DBG_BUS_FRAME_MODE_4HW, 0xf, 0x0, DBG_BUS_SEMI_FRAME_MODE_4SLOW,
+	 10},
+	{DBG_BUS_FRAME_MODE_2ST_2HW, 0x3, 0xc,
+	 DBG_BUS_SEMI_FRAME_MODE_2FAST_2SLOW, 10},
+	{DBG_BUS_FRAME_MODE_1ST_3HW, 0x7, 0x8,
+	 DBG_BUS_SEMI_FRAME_MODE_1FAST_3SLOW, 10}
+};
+
 /* Chip constant definitions array */
 static struct chip_defs s_chip_defs[MAX_CHIP_IDS] = {
-	{"bb", PSWRQ2_REG_ILT_MEMORY_SIZE_BB / 2},
-	{"ah", PSWRQ2_REG_ILT_MEMORY_SIZE_K2 / 2}
+	{"bb", 4, DBG_BUS_NUM_FRAME_MODES, PSWRQ2_REG_ILT_MEMORY_SIZE_BB / 2,
+	 s_framing_mode_defs},
+	{"ah", 4, DBG_BUS_NUM_FRAME_MODES, PSWRQ2_REG_ILT_MEMORY_SIZE_K2 / 2,
+	 s_framing_mode_defs}
 };
 
 /* Storm constant definitions array */
@@ -478,8 +552,8 @@ static struct storm_defs s_storm_defs[] = {
 		{DBG_BUS_CLIENT_RBCT, DBG_BUS_CLIENT_RBCT},
 		true,
 		TSEM_REG_FAST_MEMORY,
-		TSEM_REG_DBG_FRAME_MODE_BB_K2, TSEM_REG_SLOW_DBG_ACTIVE_BB_K2,
-		TSEM_REG_SLOW_DBG_MODE_BB_K2, TSEM_REG_DBG_MODE1_CFG_BB_K2,
+		TSEM_REG_DBG_FRAME_MODE, TSEM_REG_SLOW_DBG_ACTIVE,
+		TSEM_REG_SLOW_DBG_MODE, TSEM_REG_DBG_MODE1_CFG,
 		TSEM_REG_SYNC_DBG_EMPTY, TSEM_REG_DBG_GPRE_VECT,
 		TCM_REG_CTX_RBC_ACCS,
 		{TCM_REG_AGG_CON_CTX, TCM_REG_SM_CON_CTX, TCM_REG_AGG_TASK_CTX,
@@ -492,10 +566,10 @@ static struct storm_defs s_storm_defs[] = {
 		{DBG_BUS_CLIENT_RBCT, DBG_BUS_CLIENT_RBCM},
 		false,
 		MSEM_REG_FAST_MEMORY,
-		MSEM_REG_DBG_FRAME_MODE_BB_K2,
-		MSEM_REG_SLOW_DBG_ACTIVE_BB_K2,
-		MSEM_REG_SLOW_DBG_MODE_BB_K2,
-		MSEM_REG_DBG_MODE1_CFG_BB_K2,
+		MSEM_REG_DBG_FRAME_MODE,
+		MSEM_REG_SLOW_DBG_ACTIVE,
+		MSEM_REG_SLOW_DBG_MODE,
+		MSEM_REG_DBG_MODE1_CFG,
 		MSEM_REG_SYNC_DBG_EMPTY,
 		MSEM_REG_DBG_GPRE_VECT,
 		MCM_REG_CTX_RBC_ACCS,
@@ -509,10 +583,10 @@ static struct storm_defs s_storm_defs[] = {
 		{DBG_BUS_CLIENT_RBCU, DBG_BUS_CLIENT_RBCU},
 		false,
 		USEM_REG_FAST_MEMORY,
-		USEM_REG_DBG_FRAME_MODE_BB_K2,
-		USEM_REG_SLOW_DBG_ACTIVE_BB_K2,
-		USEM_REG_SLOW_DBG_MODE_BB_K2,
-		USEM_REG_DBG_MODE1_CFG_BB_K2,
+		USEM_REG_DBG_FRAME_MODE,
+		USEM_REG_SLOW_DBG_ACTIVE,
+		USEM_REG_SLOW_DBG_MODE,
+		USEM_REG_DBG_MODE1_CFG,
 		USEM_REG_SYNC_DBG_EMPTY,
 		USEM_REG_DBG_GPRE_VECT,
 		UCM_REG_CTX_RBC_ACCS,
@@ -526,10 +600,10 @@ static struct storm_defs s_storm_defs[] = {
 		{DBG_BUS_CLIENT_RBCX, DBG_BUS_CLIENT_RBCX},
 		false,
 		XSEM_REG_FAST_MEMORY,
-		XSEM_REG_DBG_FRAME_MODE_BB_K2,
-		XSEM_REG_SLOW_DBG_ACTIVE_BB_K2,
-		XSEM_REG_SLOW_DBG_MODE_BB_K2,
-		XSEM_REG_DBG_MODE1_CFG_BB_K2,
+		XSEM_REG_DBG_FRAME_MODE,
+		XSEM_REG_SLOW_DBG_ACTIVE,
+		XSEM_REG_SLOW_DBG_MODE,
+		XSEM_REG_DBG_MODE1_CFG,
 		XSEM_REG_SYNC_DBG_EMPTY,
 		XSEM_REG_DBG_GPRE_VECT,
 		XCM_REG_CTX_RBC_ACCS,
@@ -542,10 +616,10 @@ static struct storm_defs s_storm_defs[] = {
 		{DBG_BUS_CLIENT_RBCX, DBG_BUS_CLIENT_RBCY},
 		false,
 		YSEM_REG_FAST_MEMORY,
-		YSEM_REG_DBG_FRAME_MODE_BB_K2,
-		YSEM_REG_SLOW_DBG_ACTIVE_BB_K2,
-		YSEM_REG_SLOW_DBG_MODE_BB_K2,
-		YSEM_REG_DBG_MODE1_CFG_BB_K2,
+		YSEM_REG_DBG_FRAME_MODE,
+		YSEM_REG_SLOW_DBG_ACTIVE,
+		YSEM_REG_SLOW_DBG_MODE,
+		YSEM_REG_DBG_MODE1_CFG,
 		YSEM_REG_SYNC_DBG_EMPTY,
 		YSEM_REG_DBG_GPRE_VECT,
 		YCM_REG_CTX_RBC_ACCS,
@@ -559,10 +633,10 @@ static struct storm_defs s_storm_defs[] = {
 		{DBG_BUS_CLIENT_RBCS, DBG_BUS_CLIENT_RBCS},
 		true,
 		PSEM_REG_FAST_MEMORY,
-		PSEM_REG_DBG_FRAME_MODE_BB_K2,
-		PSEM_REG_SLOW_DBG_ACTIVE_BB_K2,
-		PSEM_REG_SLOW_DBG_MODE_BB_K2,
-		PSEM_REG_DBG_MODE1_CFG_BB_K2,
+		PSEM_REG_DBG_FRAME_MODE,
+		PSEM_REG_SLOW_DBG_ACTIVE,
+		PSEM_REG_SLOW_DBG_MODE,
+		PSEM_REG_DBG_MODE1_CFG,
 		PSEM_REG_SYNC_DBG_EMPTY,
 		PSEM_REG_DBG_GPRE_VECT,
 		PCM_REG_CTX_RBC_ACCS,
@@ -576,7 +650,8 @@ static struct hw_type_defs s_hw_type_defs[] = {
 	{"asic", 1, 256, 32768},
 	{"reserved", 0, 0, 0},
 	{"reserved2", 0, 0, 0},
-	{"reserved3", 0, 0, 0}
+	{"reserved3", 0, 0, 0},
+	{"reserved4", 0, 0, 0}
 };
 
 static struct grc_param_defs s_grc_param_defs[] = {
@@ -773,25 +848,25 @@ static struct rbc_reset_defs s_rbc_reset_defs[] = {
 
 static struct phy_defs s_phy_defs[] = {
 	{"nw_phy", NWS_REG_NWS_CMU_K2,
-	 PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_7_0_K2_E5,
-	 PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_15_8_K2_E5,
-	 PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_7_0_K2_E5,
-	 PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_11_8_K2_E5},
-	{"sgmii_phy", MS_REG_MS_CMU_K2_E5,
-	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X132_K2_E5,
-	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X133_K2_E5,
-	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X130_K2_E5,
-	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X131_K2_E5},
-	{"pcie_phy0", PHY_PCIE_REG_PHY0_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X132_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X133_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X130_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X131_K2_E5},
-	{"pcie_phy1", PHY_PCIE_REG_PHY1_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X132_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X133_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X130_K2_E5,
-	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X131_K2_E5},
+	 PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_7_0_K2,
+	 PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_15_8_K2,
+	 PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_7_0_K2,
+	 PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_11_8_K2},
+	{"sgmii_phy", MS_REG_MS_CMU_K2,
+	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X132_K2,
+	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X133_K2,
+	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X130_K2,
+	 PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X131_K2},
+	{"pcie_phy0", PHY_PCIE_REG_PHY0_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X132_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X133_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X130_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X131_K2},
+	{"pcie_phy1", PHY_PCIE_REG_PHY1_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X132_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X133_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X130_K2,
+	 PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X131_K2},
 };
 
 static struct split_type_defs s_split_type_defs[] = {
@@ -811,8 +886,17 @@ static struct split_type_defs s_split_type_defs[] = {
 	{"vf"}
 };
 
+/******************************** Variables **********************************/
+
+/* The version of the calling app */
+static u32 s_app_ver;
+
 /**************************** Private Functions ******************************/
 
+static void qed_static_asserts(void)
+{
+}
+
 /* Reads and returns a single dword from the specified unaligned buffer */
 static u32 qed_read_unaligned_dword(u8 *buf)
 {
@@ -871,6 +955,9 @@ static enum dbg_status qed_dbg_dev_init(struct qed_hwfn *p_hwfn)
 	if (dev_data->initialized)
 		return DBG_STATUS_OK;
 
+	if (!s_app_ver)
+		return DBG_STATUS_APP_VERSION_NOT_SET;
+
 	/* Set chip */
 	if (QED_IS_K2(p_hwfn->cdev)) {
 		dev_data->chip_id = CHIP_K2;
@@ -991,11 +1078,6 @@ static void qed_read_storm_fw_info(struct qed_hwfn *p_hwfn,
 	for (i = 0; i < size; i++, addr += BYTES_IN_DWORD)
 		dest[i] = qed_rd(p_hwfn, p_ptt, addr);
 
-	/* qed_rq() fetches data in CPU byteorder. Swap it back to
-	 * the device's to get right structure layout.
-	 */
-	cpu_to_le32_array(dest, size);
-
 	/* Read FW version info from Storm RAM */
 	size = le32_to_cpu(fw_info_location.size);
 	if (!size || size > sizeof(*fw_info))
@@ -1007,8 +1089,6 @@ static void qed_read_storm_fw_info(struct qed_hwfn *p_hwfn,
 
 	for (i = 0; i < size; i++, addr += BYTES_IN_DWORD)
 		dest[i] = qed_rd(p_hwfn, p_ptt, addr);
-
-	cpu_to_le32_array(dest, size);
 }
 
 /* Dumps the specified string to the specified buffer.
@@ -1118,9 +1198,15 @@ static u32 qed_dump_fw_ver_param(struct qed_hwfn *p_hwfn,
 			DP_NOTICE(p_hwfn,
 				  "Unexpected debug error: invalid FW version string\n");
 		switch (fw_info.ver.image_id) {
+		case FW_IMG_KUKU:
+			strcpy(fw_img_str, "kuku");
+			break;
 		case FW_IMG_MAIN:
 			strcpy(fw_img_str, "main");
 			break;
+		case FW_IMG_L2B:
+			strcpy(fw_img_str, "l2b");
+			break;
 		default:
 			strcpy(fw_img_str, "unknown");
 			break;
@@ -1229,6 +1315,7 @@ static u32 qed_dump_common_global_params(struct qed_hwfn *p_hwfn,
 					 u8 num_specific_global_params)
 {
 	struct dbg_tools_data *dev_data = &p_hwfn->dbg_info;
+	char sw_platform_str[MAX_SW_PLTAFORM_STR_SIZE];
 	u32 offset = 0;
 	u8 num_params;
 
@@ -1254,8 +1341,12 @@ static u32 qed_dump_common_global_params(struct qed_hwfn *p_hwfn,
 				     dump,
 				     "platform",
 				     s_hw_type_defs[dev_data->hw_type].name);
+	offset += qed_dump_str_param(dump_buf + offset,
+				     dump, "sw-platform", sw_platform_str);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump, "pci-func", p_hwfn->abs_pf_id);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump, "epoch", qed_get_epoch_time());
 	if (dev_data->chip_id == CHIP_BB)
 		offset += qed_dump_num_param(dump_buf + offset,
 					     dump, "path", QED_PATH_ID(p_hwfn));
@@ -1591,7 +1682,7 @@ static void qed_grc_stall_storms(struct qed_hwfn *p_hwfn,
 			continue;
 
 		reg_addr = s_storm_defs[storm_id].sem_fast_mem_addr +
-		    SEM_FAST_REG_STALL_0_BB_K2;
+		    SEM_FAST_REG_STALL_0;
 		qed_wr(p_hwfn, p_ptt, reg_addr, stall ? 1 : 0);
 	}
 
@@ -1704,8 +1795,8 @@ static void qed_grc_clear_all_prty(struct qed_hwfn *p_hwfn,
 {
 	struct dbg_tools_data *dev_data = &p_hwfn->dbg_info;
 	const struct dbg_attn_reg *attn_reg_arr;
+	u32 block_id, sts_clr_address;
 	u8 reg_idx, num_attn_regs;
-	u32 block_id;
 
 	for (block_id = 0; block_id < NUM_PHYS_BLOCKS; block_id++) {
 		if (dev_data->block_in_reset[block_id])
@@ -1729,16 +1820,103 @@ static void qed_grc_clear_all_prty(struct qed_hwfn *p_hwfn,
 				GET_FIELD(reg_data->mode.data,
 					  DBG_MODE_HDR_MODES_BUF_OFFSET);
 
+			sts_clr_address = reg_data->sts_clr_address;
 			/* If Mode match: clear parity status */
 			if (!eval_mode ||
 			    qed_is_mode_match(p_hwfn, &modes_buf_offset))
 				qed_rd(p_hwfn, p_ptt,
-				       DWORDS_TO_BYTES(reg_data->
-						       sts_clr_address));
+				       DWORDS_TO_BYTES(sts_clr_address));
 		}
 	}
 }
 
+/* Finds the meta data image in NVRAM */
+static enum dbg_status qed_find_nvram_image(struct qed_hwfn *p_hwfn,
+					    struct qed_ptt *p_ptt,
+					    u32 image_type,
+					    u32 *nvram_offset_bytes,
+					    u32 *nvram_size_bytes)
+{
+	u32 ret_mcp_resp, ret_mcp_param, ret_txn_size;
+	struct mcp_file_att file_att;
+	int nvm_result;
+
+	/* Call NVRAM get file command */
+	nvm_result = qed_mcp_nvm_rd_cmd(p_hwfn,
+					p_ptt,
+					DRV_MSG_CODE_NVM_GET_FILE_ATT,
+					image_type,
+					&ret_mcp_resp,
+					&ret_mcp_param,
+					&ret_txn_size,
+					(u32 *)&file_att, false);
+
+	/* Check response */
+	if (nvm_result || (ret_mcp_resp & FW_MSG_CODE_MASK) !=
+	    FW_MSG_CODE_NVM_OK)
+		return DBG_STATUS_NVRAM_GET_IMAGE_FAILED;
+
+	/* Update return values */
+	*nvram_offset_bytes = file_att.nvm_start_addr;
+	*nvram_size_bytes = file_att.len;
+
+	DP_VERBOSE(p_hwfn,
+		   QED_MSG_DEBUG,
+		   "find_nvram_image: found NVRAM image of type %d in NVRAM offset %d bytes with size %d bytes\n",
+		   image_type, *nvram_offset_bytes, *nvram_size_bytes);
+
+	/* Check alignment */
+	if (*nvram_size_bytes & 0x3)
+		return DBG_STATUS_NON_ALIGNED_NVRAM_IMAGE;
+
+	return DBG_STATUS_OK;
+}
+
+/* Reads data from NVRAM */
+static enum dbg_status qed_nvram_read(struct qed_hwfn *p_hwfn,
+				      struct qed_ptt *p_ptt,
+				      u32 nvram_offset_bytes,
+				      u32 nvram_size_bytes, u32 *ret_buf)
+{
+	u32 ret_mcp_resp, ret_mcp_param, ret_read_size, bytes_to_copy;
+	s32 bytes_left = nvram_size_bytes;
+	u32 read_offset = 0, param = 0;
+
+	DP_VERBOSE(p_hwfn,
+		   QED_MSG_DEBUG,
+		   "nvram_read: reading image of size %d bytes from NVRAM\n",
+		   nvram_size_bytes);
+
+	do {
+		bytes_to_copy =
+		    (bytes_left >
+		     MCP_DRV_NVM_BUF_LEN) ? MCP_DRV_NVM_BUF_LEN : bytes_left;
+
+		/* Call NVRAM read command */
+		SET_MFW_FIELD(param,
+			      DRV_MB_PARAM_NVM_OFFSET,
+			      nvram_offset_bytes + read_offset);
+		SET_MFW_FIELD(param, DRV_MB_PARAM_NVM_LEN, bytes_to_copy);
+		if (qed_mcp_nvm_rd_cmd(p_hwfn, p_ptt,
+				       DRV_MSG_CODE_NVM_READ_NVRAM, param,
+				       &ret_mcp_resp,
+				       &ret_mcp_param, &ret_read_size,
+				       (u32 *)((u8 *)ret_buf + read_offset),
+				       false))
+			return DBG_STATUS_NVRAM_READ_FAILED;
+
+		/* Check response */
+		if ((ret_mcp_resp & FW_MSG_CODE_MASK) != FW_MSG_CODE_NVM_OK)
+			return DBG_STATUS_NVRAM_READ_FAILED;
+
+		/* Update read offset */
+		read_offset += ret_read_size;
+		bytes_left -= ret_read_size;
+	} while (bytes_left > 0);
+
+	return DBG_STATUS_OK;
+}
+
 /* Dumps GRC registers section header. Returns the dumped size in dwords.
  * the following parameters are dumped:
  * - count: no. of dumped entries
@@ -3190,17 +3368,6 @@ static u32 qed_grc_dump_phy(struct qed_hwfn *p_hwfn,
 	return offset;
 }
 
-static enum dbg_status qed_find_nvram_image(struct qed_hwfn *p_hwfn,
-					    struct qed_ptt *p_ptt,
-					    u32 image_type,
-					    u32 *nvram_offset_bytes,
-					    u32 *nvram_size_bytes);
-
-static enum dbg_status qed_nvram_read(struct qed_hwfn *p_hwfn,
-				      struct qed_ptt *p_ptt,
-				      u32 nvram_offset_bytes,
-				      u32 nvram_size_bytes, u32 *ret_buf);
-
 /* Dumps the MCP HW dump from NVRAM. Returns the dumped size in dwords. */
 static u32 qed_grc_dump_mcp_hw_dump(struct qed_hwfn *p_hwfn,
 				    struct qed_ptt *p_ptt,
@@ -3284,10 +3451,6 @@ static u32 qed_grc_dump_static_debug(struct qed_hwfn *p_hwfn,
 		has_dbg_bus = GET_FIELD(block_per_chip->flags,
 					DBG_BLOCK_CHIP_HAS_DBG_BUS);
 
-		/* read+clear for NWS parity is not working, skip NWS block */
-		if (block_id == BLOCK_NWS)
-			continue;
-
 		if (!is_removed && has_dbg_bus &&
 		    GET_FIELD(block_per_chip->dbg_bus_mode.data,
 			      DBG_MODE_HDR_EVAL_MODE) > 0) {
@@ -3376,8 +3539,8 @@ static enum dbg_status qed_grc_dump(struct qed_hwfn *p_hwfn,
 				    bool dump, u32 *num_dumped_dwords)
 {
 	struct dbg_tools_data *dev_data = &p_hwfn->dbg_info;
-	u32 dwords_read, offset = 0;
 	bool parities_masked = false;
+	u32 dwords_read, offset = 0;
 	u8 i;
 
 	*num_dumped_dwords = 0;
@@ -3546,8 +3709,7 @@ static enum dbg_status qed_grc_dump(struct qed_hwfn *p_hwfn,
  */
 static u32 qed_idle_chk_dump_failure(struct qed_hwfn *p_hwfn,
 				     struct qed_ptt *p_ptt,
-				     u32 *
-				     dump_buf,
+				     u32 *dump_buf,
 				     bool dump,
 				     u16 rule_id,
 				     const struct dbg_idle_chk_rule *rule,
@@ -3895,91 +4057,6 @@ static u32 qed_idle_chk_dump(struct qed_hwfn *p_hwfn,
 	return offset;
 }
 
-/* Finds the meta data image in NVRAM */
-static enum dbg_status qed_find_nvram_image(struct qed_hwfn *p_hwfn,
-					    struct qed_ptt *p_ptt,
-					    u32 image_type,
-					    u32 *nvram_offset_bytes,
-					    u32 *nvram_size_bytes)
-{
-	u32 ret_mcp_resp, ret_mcp_param, ret_txn_size;
-	struct mcp_file_att file_att;
-	int nvm_result;
-
-	/* Call NVRAM get file command */
-	nvm_result = qed_mcp_nvm_rd_cmd(p_hwfn,
-					p_ptt,
-					DRV_MSG_CODE_NVM_GET_FILE_ATT,
-					image_type,
-					&ret_mcp_resp,
-					&ret_mcp_param,
-					&ret_txn_size, (u32 *)&file_att);
-
-	/* Check response */
-	if (nvm_result ||
-	    (ret_mcp_resp & FW_MSG_CODE_MASK) != FW_MSG_CODE_NVM_OK)
-		return DBG_STATUS_NVRAM_GET_IMAGE_FAILED;
-
-	/* Update return values */
-	*nvram_offset_bytes = file_att.nvm_start_addr;
-	*nvram_size_bytes = file_att.len;
-
-	DP_VERBOSE(p_hwfn,
-		   QED_MSG_DEBUG,
-		   "find_nvram_image: found NVRAM image of type %d in NVRAM offset %d bytes with size %d bytes\n",
-		   image_type, *nvram_offset_bytes, *nvram_size_bytes);
-
-	/* Check alignment */
-	if (*nvram_size_bytes & 0x3)
-		return DBG_STATUS_NON_ALIGNED_NVRAM_IMAGE;
-
-	return DBG_STATUS_OK;
-}
-
-/* Reads data from NVRAM */
-static enum dbg_status qed_nvram_read(struct qed_hwfn *p_hwfn,
-				      struct qed_ptt *p_ptt,
-				      u32 nvram_offset_bytes,
-				      u32 nvram_size_bytes, u32 *ret_buf)
-{
-	u32 ret_mcp_resp, ret_mcp_param, ret_read_size, bytes_to_copy;
-	s32 bytes_left = nvram_size_bytes;
-	u32 read_offset = 0, param = 0;
-
-	DP_VERBOSE(p_hwfn,
-		   QED_MSG_DEBUG,
-		   "nvram_read: reading image of size %d bytes from NVRAM\n",
-		   nvram_size_bytes);
-
-	do {
-		bytes_to_copy =
-		    (bytes_left >
-		     MCP_DRV_NVM_BUF_LEN) ? MCP_DRV_NVM_BUF_LEN : bytes_left;
-
-		/* Call NVRAM read command */
-		SET_MFW_FIELD(param,
-			      DRV_MB_PARAM_NVM_OFFSET,
-			      nvram_offset_bytes + read_offset);
-		SET_MFW_FIELD(param, DRV_MB_PARAM_NVM_LEN, bytes_to_copy);
-		if (qed_mcp_nvm_rd_cmd(p_hwfn, p_ptt,
-				       DRV_MSG_CODE_NVM_READ_NVRAM, param,
-				       &ret_mcp_resp,
-				       &ret_mcp_param, &ret_read_size,
-				       (u32 *)((u8 *)ret_buf + read_offset)))
-			return DBG_STATUS_NVRAM_READ_FAILED;
-
-		/* Check response */
-		if ((ret_mcp_resp & FW_MSG_CODE_MASK) != FW_MSG_CODE_NVM_OK)
-			return DBG_STATUS_NVRAM_READ_FAILED;
-
-		/* Update read offset */
-		read_offset += ret_read_size;
-		bytes_left -= ret_read_size;
-	} while (bytes_left > 0);
-
-	return DBG_STATUS_OK;
-}
-
 /* Get info on the MCP Trace data in the scratchpad:
  * - trace_data_grc_addr (OUT): trace data GRC address in bytes
  * - trace_data_size (OUT): trace data size in bytes (without the header)
@@ -4481,14 +4558,18 @@ static u32 qed_fw_asserts_dump(struct qed_hwfn *p_hwfn,
 /* Dumps the specified ILT pages to the specified buffer.
  * Returns the dumped size in dwords.
  */
-static u32 qed_ilt_dump_pages_range(u32 *dump_buf,
-				    bool dump,
-				    u32 start_page_id,
+static u32 qed_ilt_dump_pages_range(u32 *dump_buf, u32 *given_offset,
+				    bool *dump, u32 start_page_id,
 				    u32 num_pages,
 				    struct phys_mem_desc *ilt_pages,
-				    bool dump_page_ids)
+				    bool dump_page_ids, u32 buf_size_in_dwords,
+				    u32 *given_actual_dump_size_in_dwords)
 {
-	u32 page_id, end_page_id, offset = 0;
+	u32 actual_dump_size_in_dwords = *given_actual_dump_size_in_dwords;
+	u32 page_id, end_page_id, offset = *given_offset;
+	struct phys_mem_desc *mem_desc = NULL;
+	bool continue_dump = *dump;
+	u32 partial_page_size = 0;
 
 	if (num_pages == 0)
 		return offset;
@@ -4496,31 +4577,51 @@ static u32 qed_ilt_dump_pages_range(u32 *dump_buf,
 	end_page_id = start_page_id + num_pages - 1;
 
 	for (page_id = start_page_id; page_id <= end_page_id; page_id++) {
-		struct phys_mem_desc *mem_desc = &ilt_pages[page_id];
-
-		/**
-		 *
-		 * if (page_id >= ->p_cxt_mngr->ilt_shadow_size)
-		 *     break;
-		 */
-
+		mem_desc = &ilt_pages[page_id];
 		if (!ilt_pages[page_id].virt_addr)
 			continue;
 
 		if (dump_page_ids) {
-			/* Copy page ID to dump buffer */
-			if (dump)
+			/* Copy page ID to dump buffer
+			 * (if dump is needed and buffer is not full)
+			 */
+			if ((continue_dump) &&
+			    (offset + 1 > buf_size_in_dwords)) {
+				continue_dump = false;
+				actual_dump_size_in_dwords = offset;
+			}
+			if (continue_dump)
 				*(dump_buf + offset) = page_id;
 			offset++;
 		} else {
 			/* Copy page memory to dump buffer */
-			if (dump)
+			if ((continue_dump) &&
+			    (offset + BYTES_TO_DWORDS(mem_desc->size) >
+			     buf_size_in_dwords)) {
+				if (offset + BYTES_TO_DWORDS(mem_desc->size) >
+				    buf_size_in_dwords) {
+					partial_page_size =
+					    buf_size_in_dwords - offset;
+					memcpy(dump_buf + offset,
+					       mem_desc->virt_addr,
+					       partial_page_size);
+					continue_dump = false;
+					actual_dump_size_in_dwords =
+					    offset + partial_page_size;
+				}
+			}
+
+			if (continue_dump)
 				memcpy(dump_buf + offset,
 				       mem_desc->virt_addr, mem_desc->size);
 			offset += BYTES_TO_DWORDS(mem_desc->size);
 		}
 	}
 
+	*dump = continue_dump;
+	*given_offset = offset;
+	*given_actual_dump_size_in_dwords = actual_dump_size_in_dwords;
+
 	return offset;
 }
 
@@ -4529,21 +4630,30 @@ static u32 qed_ilt_dump_pages_range(u32 *dump_buf,
  */
 static u32 qed_ilt_dump_pages_section(struct qed_hwfn *p_hwfn,
 				      u32 *dump_buf,
-				      bool dump,
+				      u32 *given_offset,
+				      bool *dump,
 				      u32 valid_conn_pf_pages,
 				      u32 valid_conn_vf_pages,
 				      struct phys_mem_desc *ilt_pages,
-				      bool dump_page_ids)
+				      bool dump_page_ids,
+				      u32 buf_size_in_dwords,
+				      u32 *given_actual_dump_size_in_dwords)
 {
 	struct qed_ilt_client_cfg *clients = p_hwfn->p_cxt_mngr->clients;
-	u32 pf_start_line, start_page_id, offset = 0;
+	u32 pf_start_line, start_page_id, offset = *given_offset;
 	u32 cdut_pf_init_pages, cdut_vf_init_pages;
 	u32 cdut_pf_work_pages, cdut_vf_work_pages;
 	u32 base_data_offset, size_param_offset;
+	u32 src_pages;
+	u32 section_header_and_param_size;
 	u32 cdut_pf_pages, cdut_vf_pages;
+	u32 actual_dump_size_in_dwords;
+	bool continue_dump = *dump;
+	bool update_size = *dump;
 	const char *section_name;
-	u8 i;
+	u32 i;
 
+	actual_dump_size_in_dwords = *given_actual_dump_size_in_dwords;
 	section_name = dump_page_ids ? "ilt_page_ids" : "ilt_page_mem";
 	cdut_pf_init_pages = qed_get_cdut_num_pf_init_pages(p_hwfn);
 	cdut_vf_init_pages = qed_get_cdut_num_vf_init_pages(p_hwfn);
@@ -4552,13 +4662,26 @@ static u32 qed_ilt_dump_pages_section(struct qed_hwfn *p_hwfn,
 	cdut_pf_pages = cdut_pf_init_pages + cdut_pf_work_pages;
 	cdut_vf_pages = cdut_vf_init_pages + cdut_vf_work_pages;
 	pf_start_line = p_hwfn->p_cxt_mngr->pf_start_line;
+	section_header_and_param_size = qed_dump_section_hdr(NULL,
+							     false,
+							     section_name,
+							     1) +
+	qed_dump_num_param(NULL, false, "size", 0);
+
+	if ((continue_dump) &&
+	    (offset + section_header_and_param_size > buf_size_in_dwords)) {
+		continue_dump = false;
+		update_size = false;
+		actual_dump_size_in_dwords = offset;
+	}
 
-	offset +=
-	    qed_dump_section_hdr(dump_buf + offset, dump, section_name, 1);
+	offset += qed_dump_section_hdr(dump_buf + offset,
+				       continue_dump, section_name, 1);
 
 	/* Dump size parameter (0 for now, overwritten with real size later) */
 	size_param_offset = offset;
-	offset += qed_dump_num_param(dump_buf + offset, dump, "size", 0);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     continue_dump, "size", 0);
 	base_data_offset = offset;
 
 	/* CDUC pages are ordered as follows:
@@ -4571,22 +4694,22 @@ static u32 qed_ilt_dump_pages_section(struct qed_hwfn *p_hwfn,
 	if (qed_grc_get_param(p_hwfn, DBG_GRC_PARAM_DUMP_ILT_CDUC)) {
 		/* Dump connection PF pages */
 		start_page_id = clients[ILT_CLI_CDUC].first.val - pf_start_line;
-		offset += qed_ilt_dump_pages_range(dump_buf + offset,
-						   dump,
-						   start_page_id,
-						   valid_conn_pf_pages,
-						   ilt_pages, dump_page_ids);
+		qed_ilt_dump_pages_range(dump_buf, &offset, &continue_dump,
+					 start_page_id, valid_conn_pf_pages,
+					 ilt_pages, dump_page_ids,
+					 buf_size_in_dwords,
+					 &actual_dump_size_in_dwords);
 
 		/* Dump connection VF pages */
 		start_page_id += clients[ILT_CLI_CDUC].pf_total_lines;
 		for (i = 0; i < p_hwfn->p_cxt_mngr->vf_count;
 		     i++, start_page_id += clients[ILT_CLI_CDUC].vf_total_lines)
-			offset += qed_ilt_dump_pages_range(dump_buf + offset,
-							   dump,
-							   start_page_id,
-							   valid_conn_vf_pages,
-							   ilt_pages,
-							   dump_page_ids);
+			qed_ilt_dump_pages_range(dump_buf, &offset,
+						 &continue_dump, start_page_id,
+						 valid_conn_vf_pages,
+						 ilt_pages, dump_page_ids,
+						 buf_size_in_dwords,
+						 &actual_dump_size_in_dwords);
 	}
 
 	/* CDUT pages are ordered as follows:
@@ -4600,63 +4723,85 @@ static u32 qed_ilt_dump_pages_section(struct qed_hwfn *p_hwfn,
 		/* Dump task PF pages */
 		start_page_id = clients[ILT_CLI_CDUT].first.val +
 		    cdut_pf_init_pages - pf_start_line;
-		offset += qed_ilt_dump_pages_range(dump_buf + offset,
-						   dump,
-						   start_page_id,
-						   cdut_pf_work_pages,
-						   ilt_pages, dump_page_ids);
+		qed_ilt_dump_pages_range(dump_buf, &offset, &continue_dump,
+					 start_page_id, cdut_pf_work_pages,
+					 ilt_pages, dump_page_ids,
+					 buf_size_in_dwords,
+					 &actual_dump_size_in_dwords);
 
 		/* Dump task VF pages */
 		start_page_id = clients[ILT_CLI_CDUT].first.val +
 		    cdut_pf_pages + cdut_vf_init_pages - pf_start_line;
 		for (i = 0; i < p_hwfn->p_cxt_mngr->vf_count;
 		     i++, start_page_id += cdut_vf_pages)
-			offset += qed_ilt_dump_pages_range(dump_buf + offset,
-							   dump,
-							   start_page_id,
-							   cdut_vf_work_pages,
-							   ilt_pages,
-							   dump_page_ids);
+			qed_ilt_dump_pages_range(dump_buf, &offset,
+						 &continue_dump, start_page_id,
+						 cdut_vf_work_pages, ilt_pages,
+						 dump_page_ids,
+						 buf_size_in_dwords,
+						 &actual_dump_size_in_dwords);
+	}
+
+	/*Dump Searcher pages */
+	if (clients[ILT_CLI_SRC].active) {
+		start_page_id = clients[ILT_CLI_SRC].first.val - pf_start_line;
+		src_pages = clients[ILT_CLI_SRC].last.val -
+		    clients[ILT_CLI_SRC].first.val + 1;
+		qed_ilt_dump_pages_range(dump_buf, &offset, &continue_dump,
+					 start_page_id, src_pages, ilt_pages,
+					 dump_page_ids, buf_size_in_dwords,
+					 &actual_dump_size_in_dwords);
 	}
 
 	/* Overwrite size param */
-	if (dump)
-		qed_dump_num_param(dump_buf + size_param_offset,
-				   dump, "size", offset - base_data_offset);
+	if (update_size) {
+		u32 section_size = (*dump == continue_dump) ?
+		    offset - base_data_offset :
+		    actual_dump_size_in_dwords - base_data_offset;
+		if (section_size > 0)
+			qed_dump_num_param(dump_buf + size_param_offset,
+					   *dump, "size", section_size);
+		else if ((section_size == 0) && (*dump != continue_dump))
+			actual_dump_size_in_dwords -=
+			    section_header_and_param_size;
+	}
+
+	*dump = continue_dump;
+	*given_offset = offset;
+	*given_actual_dump_size_in_dwords = actual_dump_size_in_dwords;
 
 	return offset;
 }
 
-/* Performs ILT Dump to the specified buffer.
+/**
+ * Dumps a section containing the global parameters.
+ * Part of ilt dump process
  * Returns the dumped size in dwords.
  */
-static u32 qed_ilt_dump(struct qed_hwfn *p_hwfn,
-			struct qed_ptt *p_ptt, u32 *dump_buf, bool dump)
+static u32
+qed_ilt_dump_dump_common_global_params(struct qed_hwfn *p_hwfn,
+				       struct qed_ptt *p_ptt,
+				       u32 *dump_buf,
+				       bool dump,
+				       u32 cduc_page_size,
+				       u32 conn_ctx_size,
+				       u32 cdut_page_size,
+				       u32 *full_dump_size_param_offset,
+				       u32 *actual_dump_size_param_offset)
 {
 	struct qed_ilt_client_cfg *clients = p_hwfn->p_cxt_mngr->clients;
-	u32 valid_conn_vf_cids, valid_conn_vf_pages, offset = 0;
-	u32 valid_conn_pf_cids, valid_conn_pf_pages, num_pages;
-	u32 num_cids_per_page, conn_ctx_size;
-	u32 cduc_page_size, cdut_page_size;
-	struct phys_mem_desc *ilt_pages;
-	u8 conn_type;
-
-	cduc_page_size = 1 <<
-	    (clients[ILT_CLI_CDUC].p_size.val + PXP_ILT_PAGE_SIZE_NUM_BITS_MIN);
-	cdut_page_size = 1 <<
-	    (clients[ILT_CLI_CDUT].p_size.val + PXP_ILT_PAGE_SIZE_NUM_BITS_MIN);
-	conn_ctx_size = p_hwfn->p_cxt_mngr->conn_ctx_size;
-	num_cids_per_page = (int)(cduc_page_size / conn_ctx_size);
-	ilt_pages = p_hwfn->p_cxt_mngr->ilt_shadow;
+	u32 offset = 0;
 
-	/* Dump global params - 22 must match number of params below */
 	offset += qed_dump_common_global_params(p_hwfn, p_ptt,
-						dump_buf + offset, dump, 22);
+						dump_buf + offset,
+						dump, 30);
 	offset += qed_dump_str_param(dump_buf + offset,
-				     dump, "dump-type", "ilt-dump");
+				     dump,
+				     "dump-type", "ilt-dump");
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
-				     "cduc-page-size", cduc_page_size);
+				     "cduc-page-size",
+				     cduc_page_size);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
 				     "cduc-first-page-id",
@@ -4668,20 +4813,19 @@ static u32 qed_ilt_dump(struct qed_hwfn *p_hwfn,
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
 				     "cduc-num-pf-pages",
-				     clients
-				     [ILT_CLI_CDUC].pf_total_lines);
+				     clients[ILT_CLI_CDUC].pf_total_lines);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
 				     "cduc-num-vf-pages",
-				     clients
-				     [ILT_CLI_CDUC].vf_total_lines);
+				     clients[ILT_CLI_CDUC].vf_total_lines);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
 				     "max-conn-ctx-size",
 				     conn_ctx_size);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
-				     "cdut-page-size", cdut_page_size);
+				     "cdut-page-size",
+				     cdut_page_size);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
 				     "cdut-first-page-id",
@@ -4710,21 +4854,18 @@ static u32 qed_ilt_dump(struct qed_hwfn *p_hwfn,
 				     dump,
 				     "max-task-ctx-size",
 				     p_hwfn->p_cxt_mngr->task_ctx_size);
-	offset += qed_dump_num_param(dump_buf + offset,
-				     dump,
-				     "task-type-id",
-				     p_hwfn->p_cxt_mngr->task_type_id);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
 				     "first-vf-id-in-pf",
 				     p_hwfn->p_cxt_mngr->first_vf_in_pf);
-	offset += /* 18 */ qed_dump_num_param(dump_buf + offset,
-					      dump,
-					      "num-vfs-in-pf",
-					      p_hwfn->p_cxt_mngr->vf_count);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
-				     "ptr-size-bytes", sizeof(void *));
+				     "num-vfs-in-pf",
+				     p_hwfn->p_cxt_mngr->vf_count);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "ptr-size-bytes",
+				     sizeof(void *));
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump,
 				     "pf-start-line",
@@ -4737,58 +4878,284 @@ static u32 qed_ilt_dump(struct qed_hwfn *p_hwfn,
 				     dump,
 				     "ilt-shadow-size",
 				     p_hwfn->p_cxt_mngr->ilt_shadow_size);
+
+	*full_dump_size_param_offset = offset;
+
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump, "dump-size-full", 0);
+
+	*actual_dump_size_param_offset = offset;
+
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "dump-size-actual", 0);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "iscsi_task_pages",
+				     p_hwfn->p_cxt_mngr->iscsi_task_pages);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "fcoe_task_pages",
+				     p_hwfn->p_cxt_mngr->fcoe_task_pages);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "roce_task_pages",
+				     p_hwfn->p_cxt_mngr->roce_task_pages);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "eth_task_pages",
+				     p_hwfn->p_cxt_mngr->eth_task_pages);
+	offset += qed_dump_num_param(dump_buf + offset,
+				      dump,
+				      "src-first-page-id",
+				      clients[ILT_CLI_SRC].first.val);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "src-last-page-id",
+				     clients[ILT_CLI_SRC].last.val);
+	offset += qed_dump_num_param(dump_buf + offset,
+				     dump,
+				     "src-is-active",
+				     clients[ILT_CLI_SRC].active);
+
 	/* Additional/Less parameters require matching of number in call to
 	 * dump_common_global_params()
 	 */
 
-	/* Dump section containing number of PF CIDs per connection type */
+	return offset;
+}
+
+/**
+ * Dump section containing number of PF CIDs per connection type.
+ * Part of ilt dump process.
+ * Returns the dumped size in dwords.
+ */
+static u32 qed_ilt_dump_dump_num_pf_cids(struct qed_hwfn *p_hwfn,
+					 u32 *dump_buf,
+					 bool dump, u32 *valid_conn_pf_cids)
+{
+	u32 num_pf_cids = 0;
+	u32 offset = 0;
+	u8 conn_type;
+
 	offset += qed_dump_section_hdr(dump_buf + offset,
 				       dump, "num_pf_cids_per_conn_type", 1);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump, "size", NUM_OF_CONNECTION_TYPES);
-	for (conn_type = 0, valid_conn_pf_cids = 0;
+	for (conn_type = 0, *valid_conn_pf_cids = 0;
 	     conn_type < NUM_OF_CONNECTION_TYPES; conn_type++, offset++) {
-		u32 num_pf_cids =
-		    p_hwfn->p_cxt_mngr->conn_cfg[conn_type].cid_count;
-
+		num_pf_cids = p_hwfn->p_cxt_mngr->conn_cfg[conn_type].cid_count;
 		if (dump)
 			*(dump_buf + offset) = num_pf_cids;
-		valid_conn_pf_cids += num_pf_cids;
+		*valid_conn_pf_cids += num_pf_cids;
 	}
 
-	/* Dump section containing number of VF CIDs per connection type */
-	offset += qed_dump_section_hdr(dump_buf + offset,
-				       dump, "num_vf_cids_per_conn_type", 1);
+	return offset;
+}
+
+/**
+ * Dump section containing number of VF CIDs per connection type
+ * Part of ilt dump process.
+ * Returns the dumped size in dwords.
+ */
+static u32 qed_ilt_dump_dump_num_vf_cids(struct qed_hwfn *p_hwfn,
+					 u32 *dump_buf,
+					 bool dump, u32 *valid_conn_vf_cids)
+{
+	u32 num_vf_cids = 0;
+	u32 offset = 0;
+	u8 conn_type;
+
+	offset += qed_dump_section_hdr(dump_buf + offset, dump,
+				       "num_vf_cids_per_conn_type", 1);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump, "size", NUM_OF_CONNECTION_TYPES);
-	for (conn_type = 0, valid_conn_vf_cids = 0;
+	for (conn_type = 0, *valid_conn_vf_cids = 0;
 	     conn_type < NUM_OF_CONNECTION_TYPES; conn_type++, offset++) {
-		u32 num_vf_cids =
+		num_vf_cids =
 		    p_hwfn->p_cxt_mngr->conn_cfg[conn_type].cids_per_vf;
-
 		if (dump)
 			*(dump_buf + offset) = num_vf_cids;
-		valid_conn_vf_cids += num_vf_cids;
+		*valid_conn_vf_cids += num_vf_cids;
+	}
+
+	return offset;
+}
+
+/**
+ * Performs ILT Dump to the specified buffer.
+ * buf_size_in_dwords - The dumped buffer size.
+ * Returns the dumped size in dwords.
+ */
+static u32 qed_ilt_dump(struct qed_hwfn *p_hwfn,
+			struct qed_ptt *p_ptt,
+			u32 *dump_buf, u32 buf_size_in_dwords, bool dump)
+{
+#if ((!defined VMWARE) && (!defined UEFI))
+	struct qed_ilt_client_cfg *clients = p_hwfn->p_cxt_mngr->clients;
+#endif
+	u32 valid_conn_vf_cids = 0,
+	    valid_conn_vf_pages, offset = 0, real_dumped_size = 0;
+	u32 valid_conn_pf_cids = 0, valid_conn_pf_pages, num_pages;
+	u32 num_cids_per_page, conn_ctx_size;
+	u32 cduc_page_size, cdut_page_size;
+	u32 actual_dump_size_in_dwords = 0;
+	struct phys_mem_desc *ilt_pages;
+	u32 actul_dump_off = 0;
+	u32 last_section_size;
+	u32 full_dump_off = 0;
+	u32 section_size = 0;
+	bool continue_dump;
+	u32 page_id;
+
+	last_section_size = qed_dump_last_section(NULL, 0, false);
+	cduc_page_size = 1 <<
+	    (clients[ILT_CLI_CDUC].p_size.val + PXP_ILT_PAGE_SIZE_NUM_BITS_MIN);
+	cdut_page_size = 1 <<
+	    (clients[ILT_CLI_CDUT].p_size.val + PXP_ILT_PAGE_SIZE_NUM_BITS_MIN);
+	conn_ctx_size = p_hwfn->p_cxt_mngr->conn_ctx_size;
+	num_cids_per_page = (int)(cduc_page_size / conn_ctx_size);
+	ilt_pages = p_hwfn->p_cxt_mngr->ilt_shadow;
+	continue_dump = dump;
+
+	/* if need to dump then save memory for the last section
+	 * (last section calculates CRC of dumped data)
+	 */
+	if (dump) {
+		if (buf_size_in_dwords >= last_section_size) {
+			buf_size_in_dwords -= last_section_size;
+		} else {
+			continue_dump = false;
+			actual_dump_size_in_dwords = offset;
+		}
 	}
 
-	/* Dump section containing physical memory descs for each ILT page */
+	/* Dump global params */
+
+	/* if need to dump then first check that there is enough memory
+	 * in dumped buffer for this section calculate the size of this
+	 * section without dumping. if there is not enough memory - then
+	 * stop the dumping.
+	 */
+	if (continue_dump) {
+		section_size =
+			qed_ilt_dump_dump_common_global_params(p_hwfn,
+							       p_ptt,
+							       NULL,
+							       false,
+							       cduc_page_size,
+							       conn_ctx_size,
+							       cdut_page_size,
+							       &full_dump_off,
+							       &actul_dump_off);
+		if (offset + section_size > buf_size_in_dwords) {
+			continue_dump = false;
+			actual_dump_size_in_dwords = offset;
+		}
+	}
+
+	offset += qed_ilt_dump_dump_common_global_params(p_hwfn,
+							 p_ptt,
+							 dump_buf + offset,
+							 continue_dump,
+							 cduc_page_size,
+							 conn_ctx_size,
+							 cdut_page_size,
+							 &full_dump_off,
+							 &actul_dump_off);
+
+	/* Dump section containing number of PF CIDs per connection type
+	 * If need to dump then first check that there is enough memory in
+	 * dumped buffer for this section.
+	 */
+	if (continue_dump) {
+		section_size =
+			qed_ilt_dump_dump_num_pf_cids(p_hwfn,
+						      NULL,
+						      false,
+						      &valid_conn_pf_cids);
+		if (offset + section_size > buf_size_in_dwords) {
+			continue_dump = false;
+			actual_dump_size_in_dwords = offset;
+		}
+	}
+
+	offset += qed_ilt_dump_dump_num_pf_cids(p_hwfn,
+						dump_buf + offset,
+						continue_dump,
+						&valid_conn_pf_cids);
+
+	/* Dump section containing number of VF CIDs per connection type
+	 * If need to dump then first check that there is enough memory in
+	 * dumped buffer for this section.
+	 */
+	if (continue_dump) {
+		section_size =
+			qed_ilt_dump_dump_num_vf_cids(p_hwfn,
+						      NULL,
+						      false,
+						      &valid_conn_vf_cids);
+		if (offset + section_size > buf_size_in_dwords) {
+			continue_dump = false;
+			actual_dump_size_in_dwords = offset;
+		}
+	}
+
+	offset += qed_ilt_dump_dump_num_vf_cids(p_hwfn,
+						dump_buf + offset,
+						continue_dump,
+						&valid_conn_vf_cids);
+
+	/* Dump section containing physical memory descriptors for each
+	 * ILT page.
+	 */
 	num_pages = p_hwfn->p_cxt_mngr->ilt_shadow_size;
+
+	/* If need to dump then first check that there is enough memory
+	 * in dumped buffer for the section header.
+	 */
+	if (continue_dump) {
+		section_size = qed_dump_section_hdr(NULL,
+						    false,
+						    "ilt_page_desc",
+						    1) +
+		    qed_dump_num_param(NULL,
+				       false,
+				       "size",
+				       num_pages * PAGE_MEM_DESC_SIZE_DWORDS);
+		if (offset + section_size > buf_size_in_dwords) {
+			continue_dump = false;
+			actual_dump_size_in_dwords = offset;
+		}
+	}
+
 	offset += qed_dump_section_hdr(dump_buf + offset,
-				       dump, "ilt_page_desc", 1);
+				       continue_dump, "ilt_page_desc", 1);
 	offset += qed_dump_num_param(dump_buf + offset,
-				     dump,
+				     continue_dump,
 				     "size",
 				     num_pages * PAGE_MEM_DESC_SIZE_DWORDS);
 
-	/* Copy memory descriptors to dump buffer */
-	if (dump) {
-		u32 page_id;
-
+	/* Copy memory descriptors to dump buffer
+	 * If need to dump then dump till the dump buffer size
+	 */
+	if (continue_dump) {
 		for (page_id = 0; page_id < num_pages;
-		     page_id++, offset += PAGE_MEM_DESC_SIZE_DWORDS)
-			memcpy(dump_buf + offset,
-			       &ilt_pages[page_id],
-			       DWORDS_TO_BYTES(PAGE_MEM_DESC_SIZE_DWORDS));
+		     page_id++, offset += PAGE_MEM_DESC_SIZE_DWORDS) {
+			if (continue_dump &&
+			    (offset + PAGE_MEM_DESC_SIZE_DWORDS <=
+			     buf_size_in_dwords)) {
+				memcpy(dump_buf + offset,
+				       &ilt_pages[page_id],
+				       DWORDS_TO_BYTES
+				       (PAGE_MEM_DESC_SIZE_DWORDS));
+			} else {
+				if (continue_dump) {
+					continue_dump = false;
+					actual_dump_size_in_dwords = offset;
+				}
+			}
+		}
 	} else {
 		offset += num_pages * PAGE_MEM_DESC_SIZE_DWORDS;
 	}
@@ -4799,25 +5166,31 @@ static u32 qed_ilt_dump(struct qed_hwfn *p_hwfn,
 					   num_cids_per_page);
 
 	/* Dump ILT pages IDs */
-	offset += qed_ilt_dump_pages_section(p_hwfn,
-					     dump_buf + offset,
-					     dump,
-					     valid_conn_pf_pages,
-					     valid_conn_vf_pages,
-					     ilt_pages, true);
+	qed_ilt_dump_pages_section(p_hwfn, dump_buf, &offset, &continue_dump,
+				   valid_conn_pf_pages, valid_conn_vf_pages,
+				   ilt_pages, true, buf_size_in_dwords,
+				   &actual_dump_size_in_dwords);
 
 	/* Dump ILT pages memory */
-	offset += qed_ilt_dump_pages_section(p_hwfn,
-					     dump_buf + offset,
-					     dump,
-					     valid_conn_pf_pages,
-					     valid_conn_vf_pages,
-					     ilt_pages, false);
+	qed_ilt_dump_pages_section(p_hwfn, dump_buf, &offset, &continue_dump,
+				   valid_conn_pf_pages, valid_conn_vf_pages,
+				   ilt_pages, false, buf_size_in_dwords,
+				   &actual_dump_size_in_dwords);
+
+	real_dumped_size =
+	    (continue_dump == dump) ? offset : actual_dump_size_in_dwords;
+	qed_dump_num_param(dump_buf + full_dump_off, dump,
+			   "full-dump-size", offset + last_section_size);
+	qed_dump_num_param(dump_buf + actul_dump_off,
+			   dump,
+			   "actual-dump-size",
+			   real_dumped_size + last_section_size);
 
 	/* Dump last section */
-	offset += qed_dump_last_section(dump_buf, offset, dump);
+	real_dumped_size += qed_dump_last_section(dump_buf,
+						  real_dumped_size, dump);
 
-	return offset;
+	return real_dumped_size;
 }
 
 /***************************** Public Functions *******************************/
@@ -4838,6 +5211,16 @@ enum dbg_status qed_dbg_set_bin_ptr(struct qed_hwfn *p_hwfn,
 	return DBG_STATUS_OK;
 }
 
+static enum dbg_status qed_dbg_set_app_ver(u32 ver)
+{
+	if (ver < TOOLS_VERSION)
+		return DBG_STATUS_UNSUPPORTED_APP_VERSION;
+
+	s_app_ver = ver;
+
+	return DBG_STATUS_OK;
+}
+
 bool qed_read_fw_info(struct qed_hwfn *p_hwfn,
 		      struct qed_ptt *p_ptt, struct fw_info *fw_info)
 {
@@ -4880,7 +5263,7 @@ enum dbg_status qed_dbg_grc_config(struct qed_hwfn *p_hwfn,
 	 */
 	qed_dbg_grc_init_params(p_hwfn);
 
-	if (grc_param >= MAX_DBG_GRC_PARAMS)
+	if (grc_param >= MAX_DBG_GRC_PARAMS || grc_param < 0)
 		return DBG_STATUS_INVALID_ARGS;
 	if (val < s_grc_param_defs[grc_param].min ||
 	    val > s_grc_param_defs[grc_param].max)
@@ -4976,6 +5359,9 @@ enum dbg_status qed_dbg_grc_dump(struct qed_hwfn *p_hwfn,
 	if (buf_size_in_dwords < needed_buf_size_in_dwords)
 		return DBG_STATUS_DUMP_BUF_TOO_SMALL;
 
+	/* Doesn't do anything, needed for compile time asserts */
+	qed_static_asserts();
+
 	/* GRC Dump */
 	status = qed_grc_dump(p_hwfn, p_ptt, dump_buf, true, num_dumped_dwords);
 
@@ -5297,7 +5683,7 @@ static enum dbg_status qed_dbg_ilt_get_dump_buf_size(struct qed_hwfn *p_hwfn,
 	if (status != DBG_STATUS_OK)
 		return status;
 
-	*buf_size = qed_ilt_dump(p_hwfn, p_ptt, NULL, false);
+	*buf_size = qed_ilt_dump(p_hwfn, p_ptt, NULL, 0, false);
 
 	return DBG_STATUS_OK;
 }
@@ -5308,21 +5694,9 @@ static enum dbg_status qed_dbg_ilt_dump(struct qed_hwfn *p_hwfn,
 					u32 buf_size_in_dwords,
 					u32 *num_dumped_dwords)
 {
-	u32 needed_buf_size_in_dwords;
-	enum dbg_status status;
-
-	*num_dumped_dwords = 0;
-
-	status = qed_dbg_ilt_get_dump_buf_size(p_hwfn,
-					       p_ptt,
-					       &needed_buf_size_in_dwords);
-	if (status != DBG_STATUS_OK)
-		return status;
-
-	if (buf_size_in_dwords < needed_buf_size_in_dwords)
-		return DBG_STATUS_DUMP_BUF_TOO_SMALL;
-
-	*num_dumped_dwords = qed_ilt_dump(p_hwfn, p_ptt, dump_buf, true);
+	*num_dumped_dwords = qed_ilt_dump(p_hwfn,
+					  p_ptt,
+					  dump_buf, buf_size_in_dwords, true);
 
 	/* Reveret GRC params to their default */
 	qed_dbg_grc_set_params_default(p_hwfn);
@@ -5725,7 +6099,46 @@ static const char * const s_status_str[] = {
 	"The configured filter mode requires that all the constraints of a single trigger state will be defined on a single Storm/block input",
 
 	/* DBG_STATUS_MISSING_TRIGGER_STATE_STORM */
-	"When triggering on Storm data, the Storm to trigger on must be specified"
+	"When triggering on Storm data, the Storm to trigger on must be specified",
+
+	/* DBG_STATUS_MDUMP2_FAILED_TO_REQUEST_OFFSIZE */
+	"Failed to request MDUMP2 Offsize",
+
+	/* DBG_STATUS_MDUMP2_FAILED_VALIDATION_OF_DATA_CRC */
+	"Expected CRC (part of the MDUMP2 data) is different than the calculated CRC over that data",
+
+	/* DBG_STATUS_MDUMP2_INVALID_SIGNATURE */
+	"Invalid Signature found at start of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_INVALID_LOG_SIZE */
+	"Invalid Log Size of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_INVALID_LOG_HDR */
+	"Invalid Log Header of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_INVALID_LOG_DATA */
+	"Invalid Log Data of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_ERROR_EXTRACTING_NUM_PORTS */
+	"Could not extract number of ports from regval buf of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_ERROR_EXTRACTING_MFW_STATUS */
+	"Could not extract MFW (link) status from regval buf of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_ERROR_DISPLAYING_LINKDUMP */
+	"Could not display linkdump of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_ERROR_READING_PHY_CFG */
+	"Could not read PHY CFG of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_ERROR_READING_PLL_MODE */
+	"Could not read PLL Mode of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_ERROR_READING_LANE_REGS */
+	"Could not read TSCF/TSCE Lane Regs of MDUMP2",
+
+	/* DBG_STATUS_MDUMP2_ERROR_ALLOCATING_BUF */
+	"Could not allocate MDUMP2 reg-val internal buffer"
 };
 
 /* Idle check severity names array */
@@ -5875,6 +6288,10 @@ static char s_temp_buf[MAX_MSG_LEN];
 
 /**************************** Private Functions ******************************/
 
+static void qed_user_static_asserts(void)
+{
+}
+
 static u32 qed_cyclic_add(u32 a, u32 b, u32 size)
 {
 	return (a + b) % size;
@@ -6154,9 +6571,8 @@ static u32 qed_parse_idle_chk_dump_rules(struct qed_hwfn *p_hwfn,
 			/* Skip register names until the required reg_id is
 			 * reached.
 			 */
-			for (; reg_id > curr_reg_id;
-			     curr_reg_id++,
-			     parsing_str += strlen(parsing_str) + 1);
+			for (; reg_id > curr_reg_id; curr_reg_id++)
+				parsing_str += strlen(parsing_str) + 1;
 
 			results_offset +=
 			    sprintf(qed_get_buf_ptr(results_buf,
@@ -6209,9 +6625,9 @@ static enum dbg_status qed_parse_idle_chk_dump(struct qed_hwfn *p_hwfn,
 					       u32 *num_errors,
 					       u32 *num_warnings)
 {
+	u32 num_section_params = 0, num_rules, num_rules_not_dumped;
 	const char *section_name, *param_name, *param_str_val;
 	u32 *dump_buf_end = dump_buf + num_dumped_dwords;
-	u32 num_section_params = 0, num_rules;
 
 	/* Offset in results_buf in bytes */
 	u32 results_offset = 0;
@@ -6235,15 +6651,31 @@ static enum dbg_status qed_parse_idle_chk_dump(struct qed_hwfn *p_hwfn,
 					     num_section_params,
 					     results_buf, &results_offset);
 
-	/* Read idle_chk section */
+	/* Read idle_chk section
+	 * There may be 1 or 2 idle_chk section parameters:
+	 * - 1st is "num_rules"
+	 * - 2nd is "num_rules_not_dumped" (optional)
+	 */
+
 	dump_buf += qed_read_section_hdr(dump_buf,
 					 &section_name, &num_section_params);
-	if (strcmp(section_name, "idle_chk") || num_section_params != 1)
+	if (strcmp(section_name, "idle_chk") ||
+	    (num_section_params != 2 && num_section_params != 1))
 		return DBG_STATUS_IDLE_CHK_PARSE_FAILED;
 	dump_buf += qed_read_param(dump_buf,
 				   &param_name, &param_str_val, &num_rules);
 	if (strcmp(param_name, "num_rules"))
 		return DBG_STATUS_IDLE_CHK_PARSE_FAILED;
+	if (num_section_params > 1) {
+		dump_buf += qed_read_param(dump_buf,
+					   &param_name,
+					   &param_str_val,
+					   &num_rules_not_dumped);
+		if (strcmp(param_name, "num_rules_not_dumped"))
+			return DBG_STATUS_IDLE_CHK_PARSE_FAILED;
+	} else {
+		num_rules_not_dumped = 0;
+	}
 
 	if (num_rules) {
 		u32 rules_print_size;
@@ -6310,6 +6742,13 @@ static enum dbg_status qed_parse_idle_chk_dump(struct qed_hwfn *p_hwfn,
 					    results_offset),
 			    "\nIdle Check completed successfully\n");
 
+	if (num_rules_not_dumped)
+		results_offset +=
+		    sprintf(qed_get_buf_ptr(results_buf,
+					    results_offset),
+			    "\nIdle Check Partially dumped : num_rules_not_dumped = %d\n",
+			    num_rules_not_dumped);
+
 	/* Add 1 for string NULL termination */
 	*parsed_results_bytes = results_offset + 1;
 
@@ -7161,6 +7600,9 @@ enum dbg_status qed_print_mcp_trace_results(struct qed_hwfn *p_hwfn,
 {
 	u32 parsed_buf_size;
 
+	/* Doesn't do anything, needed for compile time asserts */
+	qed_user_static_asserts();
+
 	return qed_parse_mcp_trace_dump(p_hwfn,
 					dump_buf,
 					results_buf, &parsed_buf_size, true);
@@ -7337,7 +7779,7 @@ enum dbg_status qed_dbg_parse_attn(struct qed_hwfn *p_hwfn,
 		    reg_result->block_attn_offset;
 
 		/* Go over attention status bits */
-		for (j = 0; j < num_reg_attn; j++, bit_idx++) {
+		for (j = 0; j < num_reg_attn; j++) {
 			u16 attn_idx_val = GET_FIELD(bit_mapping[j].data,
 						     DBG_ATTN_BIT_MAPPING_VAL);
 			const char *attn_name, *attn_type_str, *masked_str;
@@ -7354,35 +7796,36 @@ enum dbg_status qed_dbg_parse_attn(struct qed_hwfn *p_hwfn,
 			}
 
 			/* Check current bit index */
-			if (!(reg_result->sts_val & BIT(bit_idx)))
-				continue;
+			if (reg_result->sts_val & BIT(bit_idx)) {
+				/* An attention bit with value=1 was found
+				 * Find attention name
+				 */
+				attn_name_offset =
+					block_attn_name_offsets[attn_idx_val];
+				attn_name = attn_name_base + attn_name_offset;
+				attn_type_str =
+					(attn_type ==
+					 ATTN_TYPE_INTERRUPT ? "Interrupt" :
+					 "Parity");
+				masked_str = reg_result->mask_val &
+					     BIT(bit_idx) ?
+					     " [masked]" : "";
+				sts_addr =
+				GET_FIELD(reg_result->data,
+					  DBG_ATTN_REG_RESULT_STS_ADDRESS);
+				DP_NOTICE(p_hwfn,
+					  "%s (%s) : %s [address 0x%08x, bit %d]%s\n",
+					  block_name, attn_type_str, attn_name,
+					  sts_addr * 4, bit_idx, masked_str);
+			}
 
-			/* An attention bit with value=1 was found
-			 * Find attention name
-			 */
-			attn_name_offset =
-				block_attn_name_offsets[attn_idx_val];
-			attn_name = attn_name_base + attn_name_offset;
-			attn_type_str =
-				(attn_type ==
-				 ATTN_TYPE_INTERRUPT ? "Interrupt" :
-				 "Parity");
-			masked_str = reg_result->mask_val & BIT(bit_idx) ?
-				     " [masked]" : "";
-			sts_addr = GET_FIELD(reg_result->data,
-					     DBG_ATTN_REG_RESULT_STS_ADDRESS);
-			DP_NOTICE(p_hwfn,
-				  "%s (%s) : %s [address 0x%08x, bit %d]%s\n",
-				  block_name, attn_type_str, attn_name,
-				  sts_addr * 4, bit_idx, masked_str);
+			bit_idx++;
 		}
 	}
 
 	return DBG_STATUS_OK;
 }
 
-static DEFINE_MUTEX(qed_dbg_lock);
-
 /* Wrapper for unifying the idle_chk and mcp_trace api */
 static enum dbg_status
 qed_print_idle_chk_results_wrapper(struct qed_hwfn *p_hwfn,
@@ -7397,9 +7840,26 @@ qed_print_idle_chk_results_wrapper(struct qed_hwfn *p_hwfn,
 					  &num_warnnings);
 }
 
+static DEFINE_MUTEX(qed_dbg_lock);
+
+#define MAX_PHY_RESULT_BUFFER 9000
+
+/******************************** Feature Meta data section ******************/
+
+#define GRC_NUM_STR_FUNCS 2
+#define IDLE_CHK_NUM_STR_FUNCS 1
+#define MCP_TRACE_NUM_STR_FUNCS 1
+#define REG_FIFO_NUM_STR_FUNCS 1
+#define IGU_FIFO_NUM_STR_FUNCS 1
+#define PROTECTION_OVERRIDE_NUM_STR_FUNCS 1
+#define FW_ASSERTS_NUM_STR_FUNCS 1
+#define ILT_NUM_STR_FUNCS 1
+#define PHY_NUM_STR_FUNCS 20
+
 /* Feature meta data lookup table */
 static struct {
 	char *name;
+	u32 num_funcs;
 	enum dbg_status (*get_size)(struct qed_hwfn *p_hwfn,
 				    struct qed_ptt *p_ptt, u32 *size);
 	enum dbg_status (*perform_dump)(struct qed_hwfn *p_hwfn,
@@ -7412,40 +7872,46 @@ static struct {
 					    u32 *dump_buf,
 					    u32 num_dumped_dwords,
 					    u32 *results_buf_size);
+	const struct qed_func_lookup *hsi_func_lookup;
 } qed_features_lookup[] = {
 	{
-	"grc", qed_dbg_grc_get_dump_buf_size,
-		    qed_dbg_grc_dump, NULL, NULL}, {
-	"idle_chk",
+	"grc", GRC_NUM_STR_FUNCS, qed_dbg_grc_get_dump_buf_size,
+		    qed_dbg_grc_dump, NULL, NULL, NULL}, {
+	"idle_chk", IDLE_CHK_NUM_STR_FUNCS,
 		    qed_dbg_idle_chk_get_dump_buf_size,
 		    qed_dbg_idle_chk_dump,
 		    qed_print_idle_chk_results_wrapper,
-		    qed_get_idle_chk_results_buf_size}, {
-	"mcp_trace",
+		    qed_get_idle_chk_results_buf_size,
+		    NULL}, {
+	"mcp_trace", MCP_TRACE_NUM_STR_FUNCS,
 		    qed_dbg_mcp_trace_get_dump_buf_size,
 		    qed_dbg_mcp_trace_dump, qed_print_mcp_trace_results,
-		    qed_get_mcp_trace_results_buf_size}, {
-	"reg_fifo",
+		    qed_get_mcp_trace_results_buf_size,
+		    NULL}, {
+	"reg_fifo", REG_FIFO_NUM_STR_FUNCS,
 		    qed_dbg_reg_fifo_get_dump_buf_size,
 		    qed_dbg_reg_fifo_dump, qed_print_reg_fifo_results,
-		    qed_get_reg_fifo_results_buf_size}, {
-	"igu_fifo",
+		    qed_get_reg_fifo_results_buf_size,
+		    NULL}, {
+	"igu_fifo", IGU_FIFO_NUM_STR_FUNCS,
 		    qed_dbg_igu_fifo_get_dump_buf_size,
 		    qed_dbg_igu_fifo_dump, qed_print_igu_fifo_results,
-		    qed_get_igu_fifo_results_buf_size}, {
-	"protection_override",
+		    qed_get_igu_fifo_results_buf_size,
+		    NULL}, {
+	"protection_override", PROTECTION_OVERRIDE_NUM_STR_FUNCS,
 		    qed_dbg_protection_override_get_dump_buf_size,
 		    qed_dbg_protection_override_dump,
 		    qed_print_protection_override_results,
-		    qed_get_protection_override_results_buf_size}, {
-	"fw_asserts",
+		    qed_get_protection_override_results_buf_size,
+		    NULL}, {
+	"fw_asserts", FW_ASSERTS_NUM_STR_FUNCS,
 		    qed_dbg_fw_asserts_get_dump_buf_size,
 		    qed_dbg_fw_asserts_dump,
 		    qed_print_fw_asserts_results,
-		    qed_get_fw_asserts_results_buf_size}, {
-	"ilt",
-		    qed_dbg_ilt_get_dump_buf_size,
-		    qed_dbg_ilt_dump, NULL, NULL},};
+		    qed_get_fw_asserts_results_buf_size,
+		    NULL}, {
+	"ilt", ILT_NUM_STR_FUNCS, qed_dbg_ilt_get_dump_buf_size,
+		    qed_dbg_ilt_dump, NULL, NULL, NULL},};
 
 static void qed_dbg_print_feature(u8 *p_text_buf, u32 text_size)
 {
@@ -7467,7 +7933,8 @@ static enum dbg_status format_feature(struct qed_hwfn *p_hwfn,
 {
 	struct qed_dbg_feature *feature =
 	    &p_hwfn->cdev->dbg_features[feature_idx];
-	u32 text_size_bytes, null_char_pos, i;
+	u32 txt_size_bytes, null_char_pos, i;
+	u32 *dbuf, dwords;
 	enum dbg_status rc;
 	char *text_buf;
 
@@ -7475,33 +7942,43 @@ static enum dbg_status format_feature(struct qed_hwfn *p_hwfn,
 	if (!qed_features_lookup[feature_idx].results_buf_size)
 		return DBG_STATUS_OK;
 
+	dbuf = (u32 *)feature->dump_buf;
+	dwords = feature->dumped_dwords;
+
 	/* Obtain size of formatted output */
-	rc = qed_features_lookup[feature_idx].
-		results_buf_size(p_hwfn, (u32 *)feature->dump_buf,
-				 feature->dumped_dwords, &text_size_bytes);
+	rc = qed_features_lookup[feature_idx].results_buf_size(p_hwfn,
+							       dbuf,
+							       dwords,
+							       &txt_size_bytes);
 	if (rc != DBG_STATUS_OK)
 		return rc;
 
-	/* Make sure that the allocated size is a multiple of dword (4 bytes) */
-	null_char_pos = text_size_bytes - 1;
-	text_size_bytes = (text_size_bytes + 3) & ~0x3;
+	/* Make sure that the allocated size is a multiple of dword
+	 * (4 bytes).
+	 */
+	null_char_pos = txt_size_bytes - 1;
+	txt_size_bytes = (txt_size_bytes + 3) & ~0x3;
 
-	if (text_size_bytes < QED_RESULTS_BUF_MIN_SIZE) {
+	if (txt_size_bytes < QED_RESULTS_BUF_MIN_SIZE) {
 		DP_NOTICE(p_hwfn->cdev,
 			  "formatted size of feature was too small %d. Aborting\n",
-			  text_size_bytes);
+			  txt_size_bytes);
 		return DBG_STATUS_INVALID_ARGS;
 	}
 
-	/* Allocate temp text buf */
-	text_buf = vzalloc(text_size_bytes);
-	if (!text_buf)
+	/* allocate temp text buf */
+	text_buf = vzalloc(txt_size_bytes);
+	if (!text_buf) {
+		DP_NOTICE(p_hwfn->cdev,
+			  "failed to allocate text buffer. Aborting\n");
 		return DBG_STATUS_VIRT_MEM_ALLOC_FAILED;
+	}
 
 	/* Decode feature opcodes to string on temp buf */
-	rc = qed_features_lookup[feature_idx].
-		print_results(p_hwfn, (u32 *)feature->dump_buf,
-			      feature->dumped_dwords, text_buf);
+	rc = qed_features_lookup[feature_idx].print_results(p_hwfn,
+							    dbuf,
+							    dwords,
+							    text_buf);
 	if (rc != DBG_STATUS_OK) {
 		vfree(text_buf);
 		return rc;
@@ -7511,26 +7988,27 @@ static enum dbg_status format_feature(struct qed_hwfn *p_hwfn,
 	 * The bytes that were added as a result of the dword alignment are also
 	 * padded with '\n' characters.
 	 */
-	for (i = null_char_pos; i < text_size_bytes; i++)
+	for (i = null_char_pos; i < txt_size_bytes; i++)
 		text_buf[i] = '\n';
 
 	/* Dump printable feature to log */
 	if (p_hwfn->cdev->print_dbg_data)
-		qed_dbg_print_feature(text_buf, text_size_bytes);
+		qed_dbg_print_feature(text_buf, txt_size_bytes);
 
-	/* Just return the original binary buffer if requested */
+	/* Dump binary data as is to the output file */
 	if (p_hwfn->cdev->dbg_bin_dump) {
 		vfree(text_buf);
-		return DBG_STATUS_OK;
+		return rc;
 	}
 
-	/* Free the old dump_buf and point the dump_buf to the newly allocagted
+	/* Free the old dump_buf and point the dump_buf to the newly allocated
 	 * and formatted text buffer.
 	 */
 	vfree(feature->dump_buf);
 	feature->dump_buf = text_buf;
-	feature->buf_size = text_size_bytes;
-	feature->dumped_dwords = text_size_bytes / 4;
+	feature->buf_size = txt_size_bytes;
+	feature->dumped_dwords = txt_size_bytes / 4;
+
 	return rc;
 }
 
@@ -7543,7 +8021,7 @@ static enum dbg_status qed_dbg_dump(struct qed_hwfn *p_hwfn,
 {
 	struct qed_dbg_feature *feature =
 	    &p_hwfn->cdev->dbg_features[feature_idx];
-	u32 buf_size_dwords;
+	u32 buf_size_dwords, *dbuf, *dwords;
 	enum dbg_status rc;
 
 	DP_NOTICE(p_hwfn->cdev, "Collecting a debug feature [\"%s\"]\n",
@@ -7581,13 +8059,16 @@ static enum dbg_status qed_dbg_dump(struct qed_hwfn *p_hwfn,
 	if (!feature->dump_buf)
 		return DBG_STATUS_VIRT_MEM_ALLOC_FAILED;
 
-	rc = qed_features_lookup[feature_idx].
-		perform_dump(p_hwfn, p_ptt, (u32 *)feature->dump_buf,
-			     feature->buf_size / sizeof(u32),
-			     &feature->dumped_dwords);
+	dbuf = (u32 *)feature->dump_buf;
+	dwords = &feature->dumped_dwords;
+	rc = qed_features_lookup[feature_idx].perform_dump(p_hwfn, p_ptt,
+							   dbuf,
+							   feature->buf_size /
+							   sizeof(u32),
+							   dwords);
 
 	/* If mcp is stuck we get DBG_STATUS_NVRAM_GET_IMAGE_FAILED error.
-	 * In this case the buffer holds valid binary data, but we wont able
+	 * In this case the buffer holds valid binary data, but we won't able
 	 * to parse it (since parsing relies on data in NVRAM which is only
 	 * accessible when MFW is responsive). skip the formatting but return
 	 * success so that binary data is provided.
@@ -7778,7 +8259,8 @@ enum debug_print_features {
 
 static u32 qed_calc_regdump_header(struct qed_dev *cdev,
 				   enum debug_print_features feature,
-				   int engine, u32 feature_size, u8 omit_engine)
+				   int engine, u32 feature_size,
+				   u8 omit_engine, u8 dbg_bin_dump)
 {
 	u32 res = 0;
 
@@ -7789,7 +8271,7 @@ static u32 qed_calc_regdump_header(struct qed_dev *cdev,
 			  feature, feature_size);
 
 	SET_FIELD(res, REGDUMP_HEADER_FEATURE, feature);
-	SET_FIELD(res, REGDUMP_HEADER_BIN_DUMP, 1);
+	SET_FIELD(res, REGDUMP_HEADER_BIN_DUMP, dbg_bin_dump);
 	SET_FIELD(res, REGDUMP_HEADER_OMIT_ENGINE, omit_engine);
 	SET_FIELD(res, REGDUMP_HEADER_ENGINE, engine);
 
@@ -7799,12 +8281,10 @@ static u32 qed_calc_regdump_header(struct qed_dev *cdev,
 int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 {
 	u8 cur_engine, omit_engine = 0, org_engine;
-	struct qed_hwfn *p_hwfn =
-		&cdev->hwfns[cdev->engine_for_debug];
+	struct qed_hwfn *p_hwfn = &cdev->hwfns[cdev->engine_for_debug];
 	struct dbg_tools_data *dev_data = &p_hwfn->dbg_info;
-	int grc_params[MAX_DBG_GRC_PARAMS], i;
+	int grc_params[MAX_DBG_GRC_PARAMS], rc, i;
 	u32 offset = 0, feature_size;
-	int rc;
 
 	for (i = 0; i < MAX_DBG_GRC_PARAMS; i++)
 		grc_params[i] = dev_data->grc.param_val[i];
@@ -7812,8 +8292,8 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 	if (!QED_IS_CMT(cdev))
 		omit_engine = 1;
 
+	cdev->dbg_bin_dump = 1;
 	mutex_lock(&qed_dbg_lock);
-	cdev->dbg_bin_dump = true;
 
 	org_engine = qed_get_debug_engine(cdev);
 	for (cur_engine = 0; cur_engine < cdev->num_hwfns; cur_engine++) {
@@ -7827,8 +8307,11 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 				      REGDUMP_HEADER_SIZE, &feature_size);
 		if (!rc) {
 			*(u32 *)((u8 *)buffer + offset) =
-			    qed_calc_regdump_header(cdev, IDLE_CHK, cur_engine,
-						    feature_size, omit_engine);
+			    qed_calc_regdump_header(cdev, IDLE_CHK,
+						    cur_engine,
+						    feature_size,
+						    omit_engine,
+						    cdev->dbg_bin_dump);
 			offset += (feature_size + REGDUMP_HEADER_SIZE);
 		} else {
 			DP_ERR(cdev, "qed_dbg_idle_chk failed. rc = %d\n", rc);
@@ -7839,8 +8322,11 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 				      REGDUMP_HEADER_SIZE, &feature_size);
 		if (!rc) {
 			*(u32 *)((u8 *)buffer + offset) =
-			    qed_calc_regdump_header(cdev, IDLE_CHK, cur_engine,
-						    feature_size, omit_engine);
+			    qed_calc_regdump_header(cdev, IDLE_CHK,
+						    cur_engine,
+						    feature_size,
+						    omit_engine,
+						    cdev->dbg_bin_dump);
 			offset += (feature_size + REGDUMP_HEADER_SIZE);
 		} else {
 			DP_ERR(cdev, "qed_dbg_idle_chk failed. rc = %d\n", rc);
@@ -7851,8 +8337,11 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 				      REGDUMP_HEADER_SIZE, &feature_size);
 		if (!rc) {
 			*(u32 *)((u8 *)buffer + offset) =
-			    qed_calc_regdump_header(cdev, REG_FIFO, cur_engine,
-						    feature_size, omit_engine);
+			    qed_calc_regdump_header(cdev, REG_FIFO,
+						    cur_engine,
+						    feature_size,
+						    omit_engine,
+						    cdev->dbg_bin_dump);
 			offset += (feature_size + REGDUMP_HEADER_SIZE);
 		} else {
 			DP_ERR(cdev, "qed_dbg_reg_fifo failed. rc = %d\n", rc);
@@ -7863,8 +8352,11 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 				      REGDUMP_HEADER_SIZE, &feature_size);
 		if (!rc) {
 			*(u32 *)((u8 *)buffer + offset) =
-			    qed_calc_regdump_header(cdev, IGU_FIFO, cur_engine,
-						    feature_size, omit_engine);
+			    qed_calc_regdump_header(cdev, IGU_FIFO,
+						    cur_engine,
+						    feature_size,
+						    omit_engine,
+						    cdev->dbg_bin_dump);
 			offset += (feature_size + REGDUMP_HEADER_SIZE);
 		} else {
 			DP_ERR(cdev, "qed_dbg_igu_fifo failed. rc = %d", rc);
@@ -7876,9 +8368,12 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 						 &feature_size);
 		if (!rc) {
 			*(u32 *)((u8 *)buffer + offset) =
-			    qed_calc_regdump_header(cdev, PROTECTION_OVERRIDE,
+			    qed_calc_regdump_header(cdev,
+						    PROTECTION_OVERRIDE,
 						    cur_engine,
-						    feature_size, omit_engine);
+						    feature_size,
+						    omit_engine,
+						    cdev->dbg_bin_dump);
 			offset += (feature_size + REGDUMP_HEADER_SIZE);
 		} else {
 			DP_ERR(cdev,
@@ -7892,8 +8387,10 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 		if (!rc) {
 			*(u32 *)((u8 *)buffer + offset) =
 			    qed_calc_regdump_header(cdev, FW_ASSERTS,
-						    cur_engine, feature_size,
-						    omit_engine);
+						    cur_engine,
+						    feature_size,
+						    omit_engine,
+						    cdev->dbg_bin_dump);
 			offset += (feature_size + REGDUMP_HEADER_SIZE);
 		} else {
 			DP_ERR(cdev, "qed_dbg_fw_asserts failed. rc = %d\n",
@@ -7901,8 +8398,8 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 		}
 
 		feature_size = qed_dbg_ilt_size(cdev);
-		if (!cdev->disable_ilt_dump &&
-		    feature_size < ILT_DUMP_MAX_SIZE) {
+		if (!cdev->disable_ilt_dump && feature_size <
+		    ILT_DUMP_MAX_SIZE) {
 			rc = qed_dbg_ilt(cdev, (u8 *)buffer + offset +
 					 REGDUMP_HEADER_SIZE, &feature_size);
 			if (!rc) {
@@ -7910,15 +8407,16 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 				    qed_calc_regdump_header(cdev, ILT_DUMP,
 							    cur_engine,
 							    feature_size,
-							    omit_engine);
-				offset += feature_size + REGDUMP_HEADER_SIZE;
+							    omit_engine,
+							    cdev->dbg_bin_dump);
+				offset += (feature_size + REGDUMP_HEADER_SIZE);
 			} else {
 				DP_ERR(cdev, "qed_dbg_ilt failed. rc = %d\n",
 				       rc);
 			}
 		}
 
-		/* GRC dump - must be last because when mcp stuck it will
+		/* Grc dump - must be last because when mcp stuck it will
 		 * clutter idle_chk, reg_fifo, ...
 		 */
 		for (i = 0; i < MAX_DBG_GRC_PARAMS; i++)
@@ -7930,7 +8428,9 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 			*(u32 *)((u8 *)buffer + offset) =
 			    qed_calc_regdump_header(cdev, GRC_DUMP,
 						    cur_engine,
-						    feature_size, omit_engine);
+						    feature_size,
+						    omit_engine,
+						    cdev->dbg_bin_dump);
 			offset += (feature_size + REGDUMP_HEADER_SIZE);
 		} else {
 			DP_ERR(cdev, "qed_dbg_grc failed. rc = %d", rc);
@@ -7945,16 +8445,13 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 	if (!rc) {
 		*(u32 *)((u8 *)buffer + offset) =
 		    qed_calc_regdump_header(cdev, MCP_TRACE, cur_engine,
-					    feature_size, omit_engine);
+					    feature_size, omit_engine,
+					    cdev->dbg_bin_dump);
 		offset += (feature_size + REGDUMP_HEADER_SIZE);
 	} else {
 		DP_ERR(cdev, "qed_dbg_mcp_trace failed. rc = %d\n", rc);
 	}
 
-	/* Re-populate nvm attribute info */
-	qed_mcp_nvm_info_free(p_hwfn);
-	qed_mcp_nvm_info_populate(p_hwfn);
-
 	/* nvm cfg1 */
 	rc = qed_dbg_nvm_image(cdev,
 			       (u8 *)buffer + offset +
@@ -7963,43 +8460,51 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 	if (!rc) {
 		*(u32 *)((u8 *)buffer + offset) =
 		    qed_calc_regdump_header(cdev, NVM_CFG1, cur_engine,
-					    feature_size, omit_engine);
+					    feature_size, omit_engine,
+					    cdev->dbg_bin_dump);
 		offset += (feature_size + REGDUMP_HEADER_SIZE);
 	} else if (rc != -ENOENT) {
 		DP_ERR(cdev,
 		       "qed_dbg_nvm_image failed for image  %d (%s), rc = %d\n",
-		       QED_NVM_IMAGE_NVM_CFG1, "QED_NVM_IMAGE_NVM_CFG1", rc);
+		       QED_NVM_IMAGE_NVM_CFG1, "QED_NVM_IMAGE_NVM_CFG1",
+		       rc);
 	}
 
-	/* nvm default */
+		/* nvm default */
 	rc = qed_dbg_nvm_image(cdev,
-			       (u8 *)buffer + offset + REGDUMP_HEADER_SIZE,
-			       &feature_size, QED_NVM_IMAGE_DEFAULT_CFG);
+			       (u8 *)buffer + offset +
+			       REGDUMP_HEADER_SIZE, &feature_size,
+			       QED_NVM_IMAGE_DEFAULT_CFG);
 	if (!rc) {
 		*(u32 *)((u8 *)buffer + offset) =
-		    qed_calc_regdump_header(cdev, DEFAULT_CFG, cur_engine,
-					    feature_size, omit_engine);
+		    qed_calc_regdump_header(cdev, DEFAULT_CFG,
+					    cur_engine, feature_size,
+					    omit_engine,
+					    cdev->dbg_bin_dump);
 		offset += (feature_size + REGDUMP_HEADER_SIZE);
 	} else if (rc != -ENOENT) {
 		DP_ERR(cdev,
 		       "qed_dbg_nvm_image failed for image %d (%s), rc = %d\n",
-		       QED_NVM_IMAGE_DEFAULT_CFG, "QED_NVM_IMAGE_DEFAULT_CFG",
-		       rc);
+		       QED_NVM_IMAGE_DEFAULT_CFG,
+		       "QED_NVM_IMAGE_DEFAULT_CFG", rc);
 	}
 
 	/* nvm meta */
 	rc = qed_dbg_nvm_image(cdev,
-			       (u8 *)buffer + offset + REGDUMP_HEADER_SIZE,
-			       &feature_size, QED_NVM_IMAGE_NVM_META);
+			       (u8 *)buffer + offset +
+			       REGDUMP_HEADER_SIZE, &feature_size,
+			       QED_NVM_IMAGE_NVM_META);
 	if (!rc) {
 		*(u32 *)((u8 *)buffer + offset) =
-			qed_calc_regdump_header(cdev, NVM_META, cur_engine,
-						feature_size, omit_engine);
+		    qed_calc_regdump_header(cdev, NVM_META, cur_engine,
+					    feature_size, omit_engine,
+					    cdev->dbg_bin_dump);
 		offset += (feature_size + REGDUMP_HEADER_SIZE);
 	} else if (rc != -ENOENT) {
 		DP_ERR(cdev,
 		       "qed_dbg_nvm_image failed for image %d (%s), rc = %d\n",
-		       QED_NVM_IMAGE_NVM_META, "QED_NVM_IMAGE_NVM_META", rc);
+		       QED_NVM_IMAGE_NVM_META, "QED_NVM_IMAGE_NVM_META",
+		       rc);
 	}
 
 	/* nvm mdump */
@@ -8008,8 +8513,9 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 			       QED_NVM_IMAGE_MDUMP);
 	if (!rc) {
 		*(u32 *)((u8 *)buffer + offset) =
-			qed_calc_regdump_header(cdev, MDUMP, cur_engine,
-						feature_size, omit_engine);
+		    qed_calc_regdump_header(cdev, MDUMP, cur_engine,
+					    feature_size, omit_engine,
+					    cdev->dbg_bin_dump);
 		offset += (feature_size + REGDUMP_HEADER_SIZE);
 	} else if (rc != -ENOENT) {
 		DP_ERR(cdev,
@@ -8017,17 +8523,16 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
 		       QED_NVM_IMAGE_MDUMP, "QED_NVM_IMAGE_MDUMP", rc);
 	}
 
-	cdev->dbg_bin_dump = false;
 	mutex_unlock(&qed_dbg_lock);
+	cdev->dbg_bin_dump = 0;
 
 	return 0;
 }
 
 int qed_dbg_all_data_size(struct qed_dev *cdev)
 {
-	struct qed_hwfn *p_hwfn =
-		&cdev->hwfns[cdev->engine_for_debug];
 	u32 regs_len = 0, image_len = 0, ilt_len = 0, total_ilt_len = 0;
+	struct qed_hwfn *p_hwfn = &cdev->hwfns[cdev->engine_for_debug];
 	u8 cur_engine, org_engine;
 
 	cdev->disable_ilt_dump = false;
@@ -8038,14 +8543,13 @@ int qed_dbg_all_data_size(struct qed_dev *cdev)
 			   "calculating idle_chk and grcdump register length for current engine\n");
 		qed_set_debug_engine(cdev, cur_engine);
 		regs_len += REGDUMP_HEADER_SIZE + qed_dbg_idle_chk_size(cdev) +
-			    REGDUMP_HEADER_SIZE + qed_dbg_idle_chk_size(cdev) +
-			    REGDUMP_HEADER_SIZE + qed_dbg_grc_size(cdev) +
-			    REGDUMP_HEADER_SIZE + qed_dbg_reg_fifo_size(cdev) +
-			    REGDUMP_HEADER_SIZE + qed_dbg_igu_fifo_size(cdev) +
-			    REGDUMP_HEADER_SIZE +
-			    qed_dbg_protection_override_size(cdev) +
-			    REGDUMP_HEADER_SIZE + qed_dbg_fw_asserts_size(cdev);
-
+		    REGDUMP_HEADER_SIZE + qed_dbg_idle_chk_size(cdev) +
+		    REGDUMP_HEADER_SIZE + qed_dbg_grc_size(cdev) +
+		    REGDUMP_HEADER_SIZE + qed_dbg_reg_fifo_size(cdev) +
+		    REGDUMP_HEADER_SIZE + qed_dbg_igu_fifo_size(cdev) +
+		    REGDUMP_HEADER_SIZE +
+		    qed_dbg_protection_override_size(cdev) +
+		    REGDUMP_HEADER_SIZE + qed_dbg_fw_asserts_size(cdev);
 		ilt_len = REGDUMP_HEADER_SIZE + qed_dbg_ilt_size(cdev);
 		if (ilt_len < ILT_DUMP_MAX_SIZE) {
 			total_ilt_len += ilt_len;
@@ -8056,7 +8560,8 @@ int qed_dbg_all_data_size(struct qed_dev *cdev)
 	qed_set_debug_engine(cdev, org_engine);
 
 	/* Engine common */
-	regs_len += REGDUMP_HEADER_SIZE + qed_dbg_mcp_trace_size(cdev);
+	regs_len += REGDUMP_HEADER_SIZE + qed_dbg_mcp_trace_size(cdev) +
+	    REGDUMP_HEADER_SIZE + qed_dbg_phy_size(cdev);
 	qed_dbg_nvm_image_length(p_hwfn, QED_NVM_IMAGE_NVM_CFG1, &image_len);
 	if (image_len)
 		regs_len += REGDUMP_HEADER_SIZE + image_len;
@@ -8084,10 +8589,8 @@ int qed_dbg_all_data_size(struct qed_dev *cdev)
 int qed_dbg_feature(struct qed_dev *cdev, void *buffer,
 		    enum qed_dbg_features feature, u32 *num_dumped_bytes)
 {
-	struct qed_hwfn *p_hwfn =
-		&cdev->hwfns[cdev->engine_for_debug];
-	struct qed_dbg_feature *qed_feature =
-		&cdev->dbg_features[feature];
+	struct qed_dbg_feature *qed_feature = &cdev->dbg_features[feature];
+	struct qed_hwfn *p_hwfn = &cdev->hwfns[cdev->engine_for_debug];
 	enum dbg_status dbg_rc;
 	struct qed_ptt *p_ptt;
 	int rc = 0;
@@ -8120,9 +8623,8 @@ int qed_dbg_feature(struct qed_dev *cdev, void *buffer,
 
 int qed_dbg_feature_size(struct qed_dev *cdev, enum qed_dbg_features feature)
 {
-	struct qed_hwfn *p_hwfn =
-		&cdev->hwfns[cdev->engine_for_debug];
 	struct qed_dbg_feature *qed_feature = &cdev->dbg_features[feature];
+	struct qed_hwfn *p_hwfn = &cdev->hwfns[cdev->engine_for_debug];
 	struct qed_ptt *p_ptt = qed_ptt_acquire(p_hwfn);
 	u32 buf_size_dwords;
 	enum dbg_status rc;
@@ -8144,6 +8646,14 @@ int qed_dbg_feature_size(struct qed_dev *cdev, enum qed_dbg_features feature)
 	return qed_feature->buf_size;
 }
 
+int qed_dbg_phy_size(struct qed_dev *cdev)
+{
+	/* return max size of phy info and
+	 * phy mac_stat multiplied by the number of ports
+	 */
+	return MAX_PHY_RESULT_BUFFER * (1 + qed_device_num_ports(cdev));
+}
+
 u8 qed_get_debug_engine(struct qed_dev *cdev)
 {
 	return cdev->engine_for_debug;
@@ -8161,6 +8671,9 @@ void qed_dbg_pf_init(struct qed_dev *cdev)
 	const u8 *dbg_values = NULL;
 	int i;
 
+	/* Sync ver with debugbus qed code */
+	qed_dbg_set_app_ver(TOOLS_VERSION);
+
 	/* Debug values are after init values.
 	 * The offset is the first dword of the file.
 	 */
diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.h b/drivers/net/ethernet/qlogic/qed/qed_debug.h
index e71af82d3200..b0d4b937cf4a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* QLogic qed NIC Driver
  * Copyright (c) 2015 QLogic Corporation
- * Copyright (c) 2019-2020 Marvell International Ltd.
+ * Copyright (c) 2019-2021 Marvell International Ltd.
  */
 
-#ifndef _QED_DEBUGFS_H
-#define _QED_DEBUGFS_H
+#ifndef _QED_DEBUG_H
+#define _QED_DEBUG_H
 
 enum qed_dbg_features {
 	DBG_FEATURE_GRC,
@@ -45,6 +45,7 @@ int qed_dbg_ilt_size(struct qed_dev *cdev);
 int qed_dbg_mcp_trace(struct qed_dev *cdev, void *buffer,
 		      u32 *num_dumped_bytes);
 int qed_dbg_mcp_trace_size(struct qed_dev *cdev);
+int qed_dbg_phy_size(struct qed_dev *cdev);
 int qed_dbg_all_data(struct qed_dev *cdev, void *buffer);
 int qed_dbg_all_data_size(struct qed_dev *cdev);
 u8 qed_get_debug_engine(struct qed_dev *cdev);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 7e0e162df2b9..51fa649e2265 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -3160,3 +3160,8 @@ int qed_mfw_fill_tlv_data(struct qed_hwfn *hwfn, enum qed_mfw_tlv_type type,
 
 	return 0;
 }
+
+unsigned long qed_get_epoch_time(void)
+{
+	return ktime_get_real_seconds();
+}
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index f1ffbfd06184..11a52a4a673b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -31,11 +31,11 @@
 #define QED_MCP_RESET_RETRIES	(50 * 1000)	/* Account for 500 msec */
 
 #define DRV_INNER_WR(_p_hwfn, _p_ptt, _ptr, _offset, _val)	     \
-	qed_wr(_p_hwfn, _p_ptt, (_p_hwfn->mcp_info->_ptr + _offset), \
+	qed_wr(_p_hwfn, _p_ptt, (_p_hwfn->mcp_info->_ptr + (_offset)), \
 	       _val)
 
 #define DRV_INNER_RD(_p_hwfn, _p_ptt, _ptr, _offset) \
-	qed_rd(_p_hwfn, _p_ptt, (_p_hwfn->mcp_info->_ptr + _offset))
+	qed_rd(_p_hwfn, _p_ptt, (_p_hwfn->mcp_info->_ptr + (_offset)))
 
 #define DRV_MB_WR(_p_hwfn, _p_ptt, _field, _val)  \
 	DRV_INNER_WR(p_hwfn, _p_ptt, drv_mb_addr, \
@@ -385,7 +385,7 @@ qed_mcp_update_pending_cmd(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 	p_mb_params->mcp_param = DRV_MB_RD(p_hwfn, p_ptt, fw_mb_param);
 
 	/* Get the union data */
-	if (p_mb_params->p_data_dst != NULL && p_mb_params->data_dst_size) {
+	if (p_mb_params->p_data_dst && p_mb_params->data_dst_size) {
 		u32 union_data_addr = p_hwfn->mcp_info->drv_mb_addr +
 				      offsetof(struct public_drv_mb,
 					       union_data);
@@ -411,7 +411,7 @@ static void __qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 	union_data_addr = p_hwfn->mcp_info->drv_mb_addr +
 			  offsetof(struct public_drv_mb, union_data);
 	memset(&union_data, 0, sizeof(union_data));
-	if (p_mb_params->p_data_src != NULL && p_mb_params->data_src_size)
+	if (p_mb_params->p_data_src && p_mb_params->data_src_size)
 		memcpy(&union_data, p_mb_params->p_data_src,
 		       p_mb_params->data_src_size);
 	qed_memcpy_to(p_hwfn, p_ptt, union_data_addr, &union_data,
@@ -672,7 +672,8 @@ int qed_mcp_nvm_rd_cmd(struct qed_hwfn *p_hwfn,
 		       u32 cmd,
 		       u32 param,
 		       u32 *o_mcp_resp,
-		       u32 *o_mcp_param, u32 *o_txn_size, u32 *o_buf)
+		       u32 *o_mcp_param,
+		       u32 *o_txn_size, u32 *o_buf, bool b_can_sleep)
 {
 	struct qed_mcp_mb_params mb_params;
 	u8 raw_data[MCP_DRV_NVM_BUF_LEN];
@@ -685,6 +686,8 @@ int qed_mcp_nvm_rd_cmd(struct qed_hwfn *p_hwfn,
 
 	/* Use the maximal value since the actual one is part of the response */
 	mb_params.data_dst_size = MCP_DRV_NVM_BUF_LEN;
+	if (b_can_sleep)
+		mb_params.flags = QED_MB_FLAG_CAN_SLEEP;
 
 	rc = qed_mcp_cmd_and_union(p_hwfn, p_ptt, &mb_params);
 	if (rc)
@@ -917,7 +920,6 @@ enum qed_load_req_force {
 };
 
 static void qed_get_mfw_force_cmd(struct qed_hwfn *p_hwfn,
-
 				  enum qed_load_req_force force_cmd,
 				  u8 *p_mfw_force_cmd)
 {
@@ -2078,7 +2080,7 @@ int qed_mcp_get_mfw_ver(struct qed_hwfn *p_hwfn,
 			struct qed_ptt *p_ptt,
 			u32 *p_mfw_ver, u32 *p_running_bundle_id)
 {
-	u32 global_offsize;
+	u32 global_offsize, public_base;
 
 	if (IS_VF(p_hwfn->cdev)) {
 		if (p_hwfn->vf_iov_info) {
@@ -2095,16 +2097,16 @@ int qed_mcp_get_mfw_ver(struct qed_hwfn *p_hwfn,
 		}
 	}
 
+	public_base = p_hwfn->mcp_info->public_base;
 	global_offsize = qed_rd(p_hwfn, p_ptt,
-				SECTION_OFFSIZE_ADDR(p_hwfn->
-						     mcp_info->public_base,
+				SECTION_OFFSIZE_ADDR(public_base,
 						     PUBLIC_GLOBAL));
 	*p_mfw_ver =
 	    qed_rd(p_hwfn, p_ptt,
 		   SECTION_ADDR(global_offsize,
 				0) + offsetof(struct public_global, mfw_ver));
 
-	if (p_running_bundle_id != NULL) {
+	if (p_running_bundle_id) {
 		*p_running_bundle_id = qed_rd(p_hwfn, p_ptt,
 					      SECTION_ADDR(global_offsize, 0) +
 					      offsetof(struct public_global,
@@ -2206,6 +2208,7 @@ int qed_mcp_get_transceiver_data(struct qed_hwfn *p_hwfn,
 
 	return 0;
 }
+
 static bool qed_is_transceiver_ready(u32 transceiver_state,
 				     u32 transceiver_type)
 {
@@ -2375,7 +2378,7 @@ qed_mcp_get_shmem_proto_legacy(struct qed_hwfn *p_hwfn,
 
 	DP_VERBOSE(p_hwfn, NETIF_MSG_IFUP,
 		   "According to Legacy capabilities, L2 personality is %08x\n",
-		   (u32) *p_proto);
+		   (u32)*p_proto);
 }
 
 static int
@@ -2420,7 +2423,7 @@ qed_mcp_get_shmem_proto_mfw(struct qed_hwfn *p_hwfn,
 	DP_VERBOSE(p_hwfn,
 		   NETIF_MSG_IFUP,
 		   "According to capabilities, L2 personality is %08x [resp %08x param %08x]\n",
-		   (u32) *p_proto, resp, param);
+		   (u32)*p_proto, resp, param);
 	return 0;
 }
 
@@ -3020,7 +3023,7 @@ int qed_mcp_nvm_read(struct qed_dev *cdev, u32 addr, u8 *p_buf, u32 len)
 					 DRV_MB_PARAM_NVM_LEN_OFFSET),
 					&resp, &resp_param,
 					&read_len,
-					(u32 *)(p_buf + offset));
+					(u32 *)(p_buf + offset), false);
 
 		if (rc || (resp != FW_MSG_CODE_NVM_OK)) {
 			DP_NOTICE(cdev, "MCP command rc = %d\n", rc);
@@ -3028,7 +3031,7 @@ int qed_mcp_nvm_read(struct qed_dev *cdev, u32 addr, u8 *p_buf, u32 len)
 		}
 
 		/* This can be a lengthy process, and it's possible scheduler
-		 * isn't preemptable. Sleep a bit to prevent CPU hogging.
+		 * isn't preemptible. Sleep a bit to prevent CPU hogging.
 		 */
 		if (bytes_left % 0x1000 <
 		    (bytes_left - read_len) % 0x1000)
@@ -3123,10 +3126,12 @@ int qed_mcp_nvm_write(struct qed_dev *cdev,
 		 * to be delivered to MFW.
 		 */
 		if (param && cmd == QED_PUT_FILE_DATA) {
-			buf_idx = QED_MFW_GET_FIELD(param,
-					FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET);
-			buf_size = QED_MFW_GET_FIELD(param,
-					 FW_MB_PARAM_NVM_PUT_FILE_REQ_SIZE);
+			buf_idx =
+			QED_MFW_GET_FIELD(param,
+					  FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET);
+			buf_size =
+			QED_MFW_GET_FIELD(param,
+					  FW_MB_PARAM_NVM_PUT_FILE_REQ_SIZE);
 		} else {
 			buf_idx += buf_size;
 			buf_size = min_t(u32, (len - buf_idx),
@@ -3170,7 +3175,7 @@ int qed_mcp_phy_sfp_read(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 		rc = qed_mcp_nvm_rd_cmd(p_hwfn, p_ptt,
 					DRV_MSG_CODE_TRANSCEIVER_READ,
 					nvm_offset, &resp, &param, &buf_size,
-					(u32 *)(p_buf + offset));
+					(u32 *)(p_buf + offset), true);
 		if (rc) {
 			DP_NOTICE(p_hwfn,
 				  "Failed to send a transceiver read command to the MFW. rc = %d.\n",
@@ -3269,7 +3274,7 @@ int qed_mcp_bist_nvm_get_image_att(struct qed_hwfn *p_hwfn,
 				DRV_MSG_CODE_BIST_TEST, param,
 				&resp, &resp_param,
 				&buf_size,
-				(u32 *)p_image_att);
+				(u32 *)p_image_att, false);
 	if (rc)
 		return rc;
 
@@ -3992,7 +3997,8 @@ int qed_mcp_nvm_get_cfg(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 
 	rc = qed_mcp_nvm_rd_cmd(p_hwfn, p_ptt,
 				DRV_MSG_CODE_GET_NVM_CFG_OPTION,
-				mb_param, &resp, &param, p_len, (u32 *)p_buf);
+				mb_param, &resp, &param, p_len,
+				(u32 *)p_buf, false);
 
 	return rc;
 }
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.h b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
index 8edb450d0abf..9ef4fd4e3384 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -272,7 +272,7 @@ union qed_mfw_tlv_data {
  *
  * @returns pointer to link params
  */
-struct qed_mcp_link_params *qed_mcp_get_link_params(struct qed_hwfn *);
+struct qed_mcp_link_params *qed_mcp_get_link_params(struct qed_hwfn *p_hwfn);
 
 /**
  * @brief - return the link state of the hw function
@@ -281,7 +281,7 @@ struct qed_mcp_link_params *qed_mcp_get_link_params(struct qed_hwfn *);
  *
  * @returns pointer to link state
  */
-struct qed_mcp_link_state *qed_mcp_get_link_state(struct qed_hwfn *);
+struct qed_mcp_link_state *qed_mcp_get_link_state(struct qed_hwfn *p_hwfn);
 
 /**
  * @brief - return the link capabilities of the hw function
@@ -294,7 +294,7 @@ struct qed_mcp_link_capabilities
 	*qed_mcp_get_link_capabilities(struct qed_hwfn *p_hwfn);
 
 /**
- * @brief Request the MFW to set the the link according to 'link_input'.
+ * @brief Request the MFW to set the link according to 'link_input'.
  *
  * @param p_hwfn
  * @param p_ptt
@@ -749,7 +749,7 @@ struct qed_mcp_info {
 	u16					mfw_mb_length;
 	u32					mcp_hist;
 
-	/* Capabilties negotiated with the MFW */
+	/* Capabilities negotiated with the MFW */
 	u32					capabilities;
 
 	/* S/N for debug data mailbox commands */
@@ -964,7 +964,8 @@ int qed_mcp_nvm_rd_cmd(struct qed_hwfn *p_hwfn,
 		       u32 cmd,
 		       u32 param,
 		       u32 *o_mcp_resp,
-		       u32 *o_mcp_param, u32 *o_txn_size, u32 *o_buf);
+		       u32 *o_mcp_param,
+		       u32 *o_txn_size, u32 *o_buf, bool b_can_sleep);
 
 /**
  * @brief Read from sfp
diff --git a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
index 7f668ecd73fe..6f1a52e6beb2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -600,7 +600,6 @@
 #define DORQ_REG_L2_EDPM_TUNNEL_NGE_IP_EN_K2		0x10092cUL
 #define DORQ_REG_L2_EDPM_TUNNEL_NGE_ETH_EN_K2		0x100930UL
 
-
 #define NIG_REG_NGE_IP_ENABLE			0x508b28UL
 #define NIG_REG_NGE_ETH_ENABLE			0x508b2cUL
 #define NIG_REG_NGE_COMP_VER			0x508b30UL
@@ -1443,29 +1442,29 @@
 	0x1401140UL
 #define XSEM_REG_SYNC_DBG_EMPTY	\
 	0x1401160UL
-#define XSEM_REG_SLOW_DBG_ACTIVE_BB_K2 \
+#define XSEM_REG_SLOW_DBG_ACTIVE \
 	0x1401400UL
-#define XSEM_REG_SLOW_DBG_MODE_BB_K2 \
+#define XSEM_REG_SLOW_DBG_MODE \
 	0x1401404UL
-#define XSEM_REG_DBG_FRAME_MODE_BB_K2	\
+#define XSEM_REG_DBG_FRAME_MODE	\
 	0x1401408UL
 #define XSEM_REG_DBG_GPRE_VECT \
 	0x1401410UL
-#define XSEM_REG_DBG_MODE1_CFG_BB_K2 \
+#define XSEM_REG_DBG_MODE1_CFG \
 	0x1401420UL
 #define XSEM_REG_FAST_MEMORY \
 	0x1440000UL
 #define YSEM_REG_SYNC_DBG_EMPTY	\
 	0x1501160UL
-#define YSEM_REG_SLOW_DBG_ACTIVE_BB_K2 \
+#define YSEM_REG_SLOW_DBG_ACTIVE \
 	0x1501400UL
-#define YSEM_REG_SLOW_DBG_MODE_BB_K2 \
+#define YSEM_REG_SLOW_DBG_MODE \
 	0x1501404UL
-#define YSEM_REG_DBG_FRAME_MODE_BB_K2	\
+#define YSEM_REG_DBG_FRAME_MODE	\
 	0x1501408UL
 #define YSEM_REG_DBG_GPRE_VECT \
 	0x1501410UL
-#define YSEM_REG_DBG_MODE1_CFG_BB_K2 \
+#define YSEM_REG_DBG_MODE1_CFG \
 	0x1501420UL
 #define YSEM_REG_FAST_MEMORY \
 	0x1540000UL
@@ -1473,15 +1472,15 @@
 	0x1601140UL
 #define PSEM_REG_SYNC_DBG_EMPTY	\
 	0x1601160UL
-#define PSEM_REG_SLOW_DBG_ACTIVE_BB_K2 \
+#define PSEM_REG_SLOW_DBG_ACTIVE \
 	0x1601400UL
-#define PSEM_REG_SLOW_DBG_MODE_BB_K2 \
+#define PSEM_REG_SLOW_DBG_MODE \
 	0x1601404UL
-#define PSEM_REG_DBG_FRAME_MODE_BB_K2	\
+#define PSEM_REG_DBG_FRAME_MODE	\
 	0x1601408UL
 #define PSEM_REG_DBG_GPRE_VECT \
 	0x1601410UL
-#define PSEM_REG_DBG_MODE1_CFG_BB_K2 \
+#define PSEM_REG_DBG_MODE1_CFG \
 	0x1601420UL
 #define PSEM_REG_FAST_MEMORY \
 	0x1640000UL
@@ -1489,15 +1488,15 @@
 	0x1701140UL
 #define TSEM_REG_SYNC_DBG_EMPTY	\
 	0x1701160UL
-#define TSEM_REG_SLOW_DBG_ACTIVE_BB_K2 \
+#define TSEM_REG_SLOW_DBG_ACTIVE \
 	0x1701400UL
-#define TSEM_REG_SLOW_DBG_MODE_BB_K2 \
+#define TSEM_REG_SLOW_DBG_MODE \
 	0x1701404UL
-#define TSEM_REG_DBG_FRAME_MODE_BB_K2	\
+#define TSEM_REG_DBG_FRAME_MODE	\
 	0x1701408UL
 #define TSEM_REG_DBG_GPRE_VECT \
 	0x1701410UL
-#define TSEM_REG_DBG_MODE1_CFG_BB_K2 \
+#define TSEM_REG_DBG_MODE1_CFG \
 	0x1701420UL
 #define TSEM_REG_FAST_MEMORY \
 	0x1740000UL
@@ -1505,15 +1504,15 @@
 	0x1801140UL
 #define MSEM_REG_SYNC_DBG_EMPTY	\
 	0x1801160UL
-#define MSEM_REG_SLOW_DBG_ACTIVE_BB_K2 \
+#define MSEM_REG_SLOW_DBG_ACTIVE \
 	0x1801400UL
-#define MSEM_REG_SLOW_DBG_MODE_BB_K2 \
+#define MSEM_REG_SLOW_DBG_MODE \
 	0x1801404UL
-#define MSEM_REG_DBG_FRAME_MODE_BB_K2	\
+#define MSEM_REG_DBG_FRAME_MODE	\
 	0x1801408UL
 #define MSEM_REG_DBG_GPRE_VECT \
 	0x1801410UL
-#define MSEM_REG_DBG_MODE1_CFG_BB_K2 \
+#define MSEM_REG_DBG_MODE1_CFG \
 	0x1801420UL
 #define MSEM_REG_FAST_MEMORY \
 	0x1840000UL
@@ -1523,15 +1522,15 @@
 	20480
 #define USEM_REG_SYNC_DBG_EMPTY	\
 	0x1901160UL
-#define USEM_REG_SLOW_DBG_ACTIVE_BB_K2 \
+#define USEM_REG_SLOW_DBG_ACTIVE \
 	0x1901400UL
-#define USEM_REG_SLOW_DBG_MODE_BB_K2 \
+#define USEM_REG_SLOW_DBG_MODE \
 	0x1901404UL
-#define USEM_REG_DBG_FRAME_MODE_BB_K2	\
+#define USEM_REG_DBG_FRAME_MODE	\
 	0x1901408UL
 #define USEM_REG_DBG_GPRE_VECT \
 	0x1901410UL
-#define USEM_REG_DBG_MODE1_CFG_BB_K2 \
+#define USEM_REG_DBG_MODE1_CFG \
 	0x1901420UL
 #define USEM_REG_FAST_MEMORY \
 	0x1940000UL
@@ -1567,7 +1566,7 @@
 	0x341500UL
 #define BRB_REG_BIG_RAM_DATA_SIZE \
 	64
-#define SEM_FAST_REG_STALL_0_BB_K2 \
+#define SEM_FAST_REG_STALL_0 \
 	0x000488UL
 #define SEM_FAST_REG_STALLED \
 	0x000494UL
@@ -1625,35 +1624,35 @@
 	0x008c14UL
 #define NWS_REG_NWS_CMU_K2	\
 	0x720000UL
-#define PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_7_0_K2_E5 \
+#define PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_7_0_K2 \
 	0x000680UL
-#define PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_15_8_K2_E5 \
+#define PHY_NW_IP_REG_PHY0_TOP_TBUS_ADDR_15_8_K2 \
 	0x000684UL
-#define PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_7_0_K2_E5 \
+#define PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_7_0_K2 \
 	0x0006c0UL
-#define PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_11_8_K2_E5 \
+#define PHY_NW_IP_REG_PHY0_TOP_TBUS_DATA_11_8_K2 \
 	0x0006c4UL
-#define MS_REG_MS_CMU_K2_E5 \
+#define MS_REG_MS_CMU_K2 \
 	0x6a4000UL
-#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X130_K2_E5 \
+#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X130_K2 \
 	0x000208UL
-#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X131_K2_E5 \
+#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X131_K2 \
 	0x00020cUL
-#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X132_K2_E5 \
+#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X132_K2 \
 	0x000210UL
-#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X133_K2_E5 \
+#define PHY_SGMII_IP_REG_AHB_CMU_CSR_0_X133_K2 \
 	0x000214UL
-#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X130_K2_E5 \
+#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X130_K2 \
 	0x000208UL
-#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X131_K2_E5 \
+#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X131_K2 \
 	0x00020cUL
-#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X132_K2_E5 \
+#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X132_K2 \
 	0x000210UL
-#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X133_K2_E5 \
+#define PHY_PCIE_IP_REG_AHB_CMU_CSR_0_X133_K2 \
 	0x000214UL
-#define PHY_PCIE_REG_PHY0_K2_E5 \
+#define PHY_PCIE_REG_PHY0_K2 \
 	0x620000UL
-#define PHY_PCIE_REG_PHY1_K2_E5 \
+#define PHY_PCIE_REG_PHY1_K2 \
 	0x624000UL
 #define NIG_REG_ROCE_DUPLICATE_TO_HOST 0x5088f0UL
 #define NIG_REG_PPF_TO_ENGINE_SEL 0x508900UL
-- 
2.24.1

