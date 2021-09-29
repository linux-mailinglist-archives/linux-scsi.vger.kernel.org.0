Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A641C472
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Sep 2021 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbhI2MQe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Sep 2021 08:16:34 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1604 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343731AbhI2MQ0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Sep 2021 08:16:26 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T8daaf008069;
        Wed, 29 Sep 2021 05:12:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=LTTpMZwrPv+EPQNNGBvbLFWj0Qmgbrxp5wDy5nZnRiA=;
 b=LxO1jy9XiJ8ZY84rEJXhV44lBvQKGy0EQViYiyxydhQMdsCi9ZhzFZ8cMq5c3OnAIVCa
 2gBnLmhjFAXMOcA3iLpRE1r3uhGoa4W6jf/sHbWpsqOKrGyV7qtNMljjd9SpclW/jzWx
 Hfh0mwKBU6/WNi4A4vdcTQAcp3FKxnpW6QsOzlTMd4fgaXrl8qX7fKPEUS97g9hM5mq2
 5+yby0Az1fgx8B8tMHrYhFJQqkS3OCPwzg6+LMFTc9B7F1+Av9p5tyAda0CIKMcYYxb0
 Pn44cu3oKD4jI47lnageIYtztEWvErnakvO13a4F0mj24CFACgdJLIxPGTetX/ri5RJe xQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bcfd4a09e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 05:12:36 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Sep
 2021 05:12:34 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Wed, 29 Sep 2021 05:12:30 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <aelior@marvell.com>,
        <smalin@marvell.com>, <jhasan@marvell.com>,
        <mrangankar@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>,
        Omkar Kulkarni <okulkarni@marvell.com>
Subject: [PATCH 02/12] qed: Split huge qed_hsi.h header file
Date:   Wed, 29 Sep 2021 15:12:05 +0300
Message-ID: <20210929121215.17864-3-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210929121215.17864-1-pkushwaha@marvell.com>
References: <20210929121215.17864-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: -Ur1Is6-gWbdapAyXH8ZKIIOuxEcVx71
X-Proofpoint-ORIG-GUID: -Ur1Is6-gWbdapAyXH8ZKIIOuxEcVx71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_05,2021-09-29_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Omkar Kulkarni <okulkarni@marvell.com>

The qed_hsi.h is a huge header file containing HSI (Hardware Software
Interface) definitions of storm memory access, debug related, general
and management firmware specific. In order to have a better
code-organization HSI definition, this patch split the code across
multiple files, i.e.
- storm memory access HSI : qed_iro_hsi.h
- debug related HSI       : qed_dbg_hsi.h
- Management firmware HSI : qed_mfg_hsi.h
- General HSI             : qed_hsi.h

In addition, this patch also fixes existing checkpatch warnings and
few important checks.

Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed.h         |    2 +
 drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h | 1478 +++++++
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h    |   11 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c   |    1 +
 drivers/net/ethernet/qlogic/qed/qed_dev.c     |    1 +
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h |    6 +-
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c    |    1 +
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     | 3709 -----------------
 .../ethernet/qlogic/qed/qed_init_fw_funcs.c   |    1 +
 drivers/net/ethernet/qlogic/qed/qed_iro_hsi.h |  339 ++
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c   |    1 +
 drivers/net/ethernet/qlogic/qed/qed_l2.c      |    1 +
 drivers/net/ethernet/qlogic/qed/qed_ll2.c     |    7 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.h     |    1 -
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     |    1 +
 drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h | 1928 +++++++++
 drivers/net/ethernet/qlogic/qed/qed_rdma.c    |    3 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.h    |    7 +-
 drivers/net/ethernet/qlogic/qed/qed_roce.c    |    1 -
 drivers/net/ethernet/qlogic/qed/qed_spq.c     |    1 +
 drivers/net/ethernet/qlogic/qed/qed_sriov.c   |    1 +
 drivers/net/ethernet/qlogic/qed/qed_vf.c      |   11 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.h      |   11 +-
 23 files changed, 3786 insertions(+), 3737 deletions(-)
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_iro_hsi.h
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index 25b31d1128cc..4693379a4105 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -23,6 +23,8 @@
 #include <linux/qed/qed_if.h>
 #include "qed_debug.h"
 #include "qed_hsi.h"
+#include "qed_dbg_hsi.h"
+#include "qed_mfw_hsi.h"
 
 extern const struct qed_common_ops qed_common_ops_pass;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h
new file mode 100644
index 000000000000..c4525a9dbb1f
--- /dev/null
+++ b/drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h
@@ -0,0 +1,1478 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/* QLogic qed NIC Driver
+ * Copyright (c) 2019-2021 Marvell International Ltd.
+ */
+#ifndef _QED_DBG_HSI_H
+#define _QED_DBG_HSI_H
+
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+/****************************************/
+/* Debug Tools HSI constants and macros */
+/****************************************/
+
+enum block_id {
+	BLOCK_GRC,
+	BLOCK_MISCS,
+	BLOCK_MISC,
+	BLOCK_DBU,
+	BLOCK_PGLUE_B,
+	BLOCK_CNIG,
+	BLOCK_CPMU,
+	BLOCK_NCSI,
+	BLOCK_OPTE,
+	BLOCK_BMB,
+	BLOCK_PCIE,
+	BLOCK_MCP,
+	BLOCK_MCP2,
+	BLOCK_PSWHST,
+	BLOCK_PSWHST2,
+	BLOCK_PSWRD,
+	BLOCK_PSWRD2,
+	BLOCK_PSWWR,
+	BLOCK_PSWWR2,
+	BLOCK_PSWRQ,
+	BLOCK_PSWRQ2,
+	BLOCK_PGLCS,
+	BLOCK_DMAE,
+	BLOCK_PTU,
+	BLOCK_TCM,
+	BLOCK_MCM,
+	BLOCK_UCM,
+	BLOCK_XCM,
+	BLOCK_YCM,
+	BLOCK_PCM,
+	BLOCK_QM,
+	BLOCK_TM,
+	BLOCK_DORQ,
+	BLOCK_BRB,
+	BLOCK_SRC,
+	BLOCK_PRS,
+	BLOCK_TSDM,
+	BLOCK_MSDM,
+	BLOCK_USDM,
+	BLOCK_XSDM,
+	BLOCK_YSDM,
+	BLOCK_PSDM,
+	BLOCK_TSEM,
+	BLOCK_MSEM,
+	BLOCK_USEM,
+	BLOCK_XSEM,
+	BLOCK_YSEM,
+	BLOCK_PSEM,
+	BLOCK_RSS,
+	BLOCK_TMLD,
+	BLOCK_MULD,
+	BLOCK_YULD,
+	BLOCK_XYLD,
+	BLOCK_PRM,
+	BLOCK_PBF_PB1,
+	BLOCK_PBF_PB2,
+	BLOCK_RPB,
+	BLOCK_BTB,
+	BLOCK_PBF,
+	BLOCK_RDIF,
+	BLOCK_TDIF,
+	BLOCK_CDU,
+	BLOCK_CCFC,
+	BLOCK_TCFC,
+	BLOCK_IGU,
+	BLOCK_CAU,
+	BLOCK_UMAC,
+	BLOCK_XMAC,
+	BLOCK_MSTAT,
+	BLOCK_DBG,
+	BLOCK_NIG,
+	BLOCK_WOL,
+	BLOCK_BMBN,
+	BLOCK_IPC,
+	BLOCK_NWM,
+	BLOCK_NWS,
+	BLOCK_MS,
+	BLOCK_PHY_PCIE,
+	BLOCK_LED,
+	BLOCK_AVS_WRAP,
+	BLOCK_PXPREQBUS,
+	BLOCK_BAR0_MAP,
+	BLOCK_MCP_FIO,
+	BLOCK_LAST_INIT,
+	BLOCK_PRS_FC,
+	BLOCK_PBF_FC,
+	BLOCK_NIG_LB_FC,
+	BLOCK_NIG_LB_FC_PLLH,
+	BLOCK_NIG_TX_FC_PLLH,
+	BLOCK_NIG_TX_FC,
+	BLOCK_NIG_RX_FC_PLLH,
+	BLOCK_NIG_RX_FC,
+	MAX_BLOCK_ID
+};
+
+/* binary debug buffer types */
+enum bin_dbg_buffer_type {
+	BIN_BUF_DBG_MODE_TREE,
+	BIN_BUF_DBG_DUMP_REG,
+	BIN_BUF_DBG_DUMP_MEM,
+	BIN_BUF_DBG_IDLE_CHK_REGS,
+	BIN_BUF_DBG_IDLE_CHK_IMMS,
+	BIN_BUF_DBG_IDLE_CHK_RULES,
+	BIN_BUF_DBG_IDLE_CHK_PARSING_DATA,
+	BIN_BUF_DBG_ATTN_BLOCKS,
+	BIN_BUF_DBG_ATTN_REGS,
+	BIN_BUF_DBG_ATTN_INDEXES,
+	BIN_BUF_DBG_ATTN_NAME_OFFSETS,
+	BIN_BUF_DBG_BLOCKS,
+	BIN_BUF_DBG_BLOCKS_CHIP_DATA,
+	BIN_BUF_DBG_BUS_LINES,
+	BIN_BUF_DBG_BLOCKS_USER_DATA,
+	BIN_BUF_DBG_BLOCKS_CHIP_USER_DATA,
+	BIN_BUF_DBG_BUS_LINE_NAME_OFFSETS,
+	BIN_BUF_DBG_RESET_REGS,
+	BIN_BUF_DBG_PARSING_STRINGS,
+	MAX_BIN_DBG_BUFFER_TYPE
+};
+
+/* Attention bit mapping */
+struct dbg_attn_bit_mapping {
+	u16 data;
+#define DBG_ATTN_BIT_MAPPING_VAL_MASK			0x7FFF
+#define DBG_ATTN_BIT_MAPPING_VAL_SHIFT			0
+#define DBG_ATTN_BIT_MAPPING_IS_UNUSED_BIT_CNT_MASK	0x1
+#define DBG_ATTN_BIT_MAPPING_IS_UNUSED_BIT_CNT_SHIFT	15
+};
+
+/* Attention block per-type data */
+struct dbg_attn_block_type_data {
+	u16 names_offset;
+	u16 reserved1;
+	u8 num_regs;
+	u8 reserved2;
+	u16 regs_offset;
+
+};
+
+/* Block attentions */
+struct dbg_attn_block {
+	struct dbg_attn_block_type_data per_type_data[2];
+};
+
+/* Attention register result */
+struct dbg_attn_reg_result {
+	u32 data;
+#define DBG_ATTN_REG_RESULT_STS_ADDRESS_MASK	0xFFFFFF
+#define DBG_ATTN_REG_RESULT_STS_ADDRESS_SHIFT	0
+#define DBG_ATTN_REG_RESULT_NUM_REG_ATTN_MASK	0xFF
+#define DBG_ATTN_REG_RESULT_NUM_REG_ATTN_SHIFT	24
+	u16 block_attn_offset;
+	u16 reserved;
+	u32 sts_val;
+	u32 mask_val;
+};
+
+/* Attention block result */
+struct dbg_attn_block_result {
+	u8 block_id;
+	u8 data;
+#define DBG_ATTN_BLOCK_RESULT_ATTN_TYPE_MASK	0x3
+#define DBG_ATTN_BLOCK_RESULT_ATTN_TYPE_SHIFT	0
+#define DBG_ATTN_BLOCK_RESULT_NUM_REGS_MASK	0x3F
+#define DBG_ATTN_BLOCK_RESULT_NUM_REGS_SHIFT	2
+	u16 names_offset;
+	struct dbg_attn_reg_result reg_results[15];
+};
+
+/* Mode header */
+struct dbg_mode_hdr {
+	u16 data;
+#define DBG_MODE_HDR_EVAL_MODE_MASK		0x1
+#define DBG_MODE_HDR_EVAL_MODE_SHIFT		0
+#define DBG_MODE_HDR_MODES_BUF_OFFSET_MASK	0x7FFF
+#define DBG_MODE_HDR_MODES_BUF_OFFSET_SHIFT	1
+};
+
+/* Attention register */
+struct dbg_attn_reg {
+	struct dbg_mode_hdr mode;
+	u16 block_attn_offset;
+	u32 data;
+#define DBG_ATTN_REG_STS_ADDRESS_MASK	0xFFFFFF
+#define DBG_ATTN_REG_STS_ADDRESS_SHIFT	0
+#define DBG_ATTN_REG_NUM_REG_ATTN_MASK	0xFF
+#define DBG_ATTN_REG_NUM_REG_ATTN_SHIFT 24
+	u32 sts_clr_address;
+	u32 mask_address;
+};
+
+/* Attention types */
+enum dbg_attn_type {
+	ATTN_TYPE_INTERRUPT,
+	ATTN_TYPE_PARITY,
+	MAX_DBG_ATTN_TYPE
+};
+
+/* Block debug data */
+struct dbg_block {
+	u8 name[15];
+	u8 associated_storm_letter;
+};
+
+/* Chip-specific block debug data */
+struct dbg_block_chip {
+	u8 flags;
+#define DBG_BLOCK_CHIP_IS_REMOVED_MASK		 0x1
+#define DBG_BLOCK_CHIP_IS_REMOVED_SHIFT		 0
+#define DBG_BLOCK_CHIP_HAS_RESET_REG_MASK	 0x1
+#define DBG_BLOCK_CHIP_HAS_RESET_REG_SHIFT	 1
+#define DBG_BLOCK_CHIP_UNRESET_BEFORE_DUMP_MASK  0x1
+#define DBG_BLOCK_CHIP_UNRESET_BEFORE_DUMP_SHIFT 2
+#define DBG_BLOCK_CHIP_HAS_DBG_BUS_MASK		 0x1
+#define DBG_BLOCK_CHIP_HAS_DBG_BUS_SHIFT	 3
+#define DBG_BLOCK_CHIP_HAS_LATENCY_EVENTS_MASK	 0x1
+#define DBG_BLOCK_CHIP_HAS_LATENCY_EVENTS_SHIFT  4
+#define DBG_BLOCK_CHIP_RESERVED0_MASK		 0x7
+#define DBG_BLOCK_CHIP_RESERVED0_SHIFT		 5
+	u8 dbg_client_id;
+	u8 reset_reg_id;
+	u8 reset_reg_bit_offset;
+	struct dbg_mode_hdr dbg_bus_mode;
+	u16 reserved1;
+	u8 reserved2;
+	u8 num_of_dbg_bus_lines;
+	u16 dbg_bus_lines_offset;
+	u32 dbg_select_reg_addr;
+	u32 dbg_dword_enable_reg_addr;
+	u32 dbg_shift_reg_addr;
+	u32 dbg_force_valid_reg_addr;
+	u32 dbg_force_frame_reg_addr;
+};
+
+/* Chip-specific block user debug data */
+struct dbg_block_chip_user {
+	u8 num_of_dbg_bus_lines;
+	u8 has_latency_events;
+	u16 names_offset;
+};
+
+/* Block user debug data */
+struct dbg_block_user {
+	u8 name[16];
+};
+
+/* Block Debug line data */
+struct dbg_bus_line {
+	u8 data;
+#define DBG_BUS_LINE_NUM_OF_GROUPS_MASK		0xF
+#define DBG_BUS_LINE_NUM_OF_GROUPS_SHIFT	0
+#define DBG_BUS_LINE_IS_256B_MASK		0x1
+#define DBG_BUS_LINE_IS_256B_SHIFT		4
+#define DBG_BUS_LINE_RESERVED_MASK		0x7
+#define DBG_BUS_LINE_RESERVED_SHIFT		5
+	u8 group_sizes;
+};
+
+/* Condition header for registers dump */
+struct dbg_dump_cond_hdr {
+	struct dbg_mode_hdr mode; /* Mode header */
+	u8 block_id; /* block ID */
+	u8 data_size; /* size in dwords of the data following this header */
+};
+
+/* Memory data for registers dump */
+struct dbg_dump_mem {
+	u32 dword0;
+#define DBG_DUMP_MEM_ADDRESS_MASK	0xFFFFFF
+#define DBG_DUMP_MEM_ADDRESS_SHIFT	0
+#define DBG_DUMP_MEM_MEM_GROUP_ID_MASK	0xFF
+#define DBG_DUMP_MEM_MEM_GROUP_ID_SHIFT	24
+	u32 dword1;
+#define DBG_DUMP_MEM_LENGTH_MASK	0xFFFFFF
+#define DBG_DUMP_MEM_LENGTH_SHIFT	0
+#define DBG_DUMP_MEM_WIDE_BUS_MASK	0x1
+#define DBG_DUMP_MEM_WIDE_BUS_SHIFT	24
+#define DBG_DUMP_MEM_RESERVED_MASK	0x7F
+#define DBG_DUMP_MEM_RESERVED_SHIFT	25
+};
+
+/* Register data for registers dump */
+struct dbg_dump_reg {
+	u32 data;
+#define DBG_DUMP_REG_ADDRESS_MASK	0x7FFFFF
+#define DBG_DUMP_REG_ADDRESS_SHIFT	0
+#define DBG_DUMP_REG_WIDE_BUS_MASK	0x1
+#define DBG_DUMP_REG_WIDE_BUS_SHIFT	23
+#define DBG_DUMP_REG_LENGTH_MASK	0xFF
+#define DBG_DUMP_REG_LENGTH_SHIFT	24
+};
+
+/* Split header for registers dump */
+struct dbg_dump_split_hdr {
+	u32 hdr;
+#define DBG_DUMP_SPLIT_HDR_DATA_SIZE_MASK	0xFFFFFF
+#define DBG_DUMP_SPLIT_HDR_DATA_SIZE_SHIFT	0
+#define DBG_DUMP_SPLIT_HDR_SPLIT_TYPE_ID_MASK	0xFF
+#define DBG_DUMP_SPLIT_HDR_SPLIT_TYPE_ID_SHIFT	24
+};
+
+/* Condition header for idle check */
+struct dbg_idle_chk_cond_hdr {
+	struct dbg_mode_hdr mode; /* Mode header */
+	u16 data_size; /* size in dwords of the data following this header */
+};
+
+/* Idle Check condition register */
+struct dbg_idle_chk_cond_reg {
+	u32 data;
+#define DBG_IDLE_CHK_COND_REG_ADDRESS_MASK	0x7FFFFF
+#define DBG_IDLE_CHK_COND_REG_ADDRESS_SHIFT	0
+#define DBG_IDLE_CHK_COND_REG_WIDE_BUS_MASK	0x1
+#define DBG_IDLE_CHK_COND_REG_WIDE_BUS_SHIFT	23
+#define DBG_IDLE_CHK_COND_REG_BLOCK_ID_MASK	0xFF
+#define DBG_IDLE_CHK_COND_REG_BLOCK_ID_SHIFT	24
+	u16 num_entries;
+	u8 entry_size;
+	u8 start_entry;
+};
+
+/* Idle Check info register */
+struct dbg_idle_chk_info_reg {
+	u32 data;
+#define DBG_IDLE_CHK_INFO_REG_ADDRESS_MASK	0x7FFFFF
+#define DBG_IDLE_CHK_INFO_REG_ADDRESS_SHIFT	0
+#define DBG_IDLE_CHK_INFO_REG_WIDE_BUS_MASK	0x1
+#define DBG_IDLE_CHK_INFO_REG_WIDE_BUS_SHIFT	23
+#define DBG_IDLE_CHK_INFO_REG_BLOCK_ID_MASK	0xFF
+#define DBG_IDLE_CHK_INFO_REG_BLOCK_ID_SHIFT	24
+	u16 size; /* register size in dwords */
+	struct dbg_mode_hdr mode; /* Mode header */
+};
+
+/* Idle Check register */
+union dbg_idle_chk_reg {
+	struct dbg_idle_chk_cond_reg cond_reg; /* condition register */
+	struct dbg_idle_chk_info_reg info_reg; /* info register */
+};
+
+/* Idle Check result header */
+struct dbg_idle_chk_result_hdr {
+	u16 rule_id; /* Failing rule index */
+	u16 mem_entry_id; /* Failing memory entry index */
+	u8 num_dumped_cond_regs; /* number of dumped condition registers */
+	u8 num_dumped_info_regs; /* number of dumped condition registers */
+	u8 severity; /* from dbg_idle_chk_severity_types enum */
+	u8 reserved;
+};
+
+/* Idle Check result register header */
+struct dbg_idle_chk_result_reg_hdr {
+	u8 data;
+#define DBG_IDLE_CHK_RESULT_REG_HDR_IS_MEM_MASK  0x1
+#define DBG_IDLE_CHK_RESULT_REG_HDR_IS_MEM_SHIFT 0
+#define DBG_IDLE_CHK_RESULT_REG_HDR_REG_ID_MASK  0x7F
+#define DBG_IDLE_CHK_RESULT_REG_HDR_REG_ID_SHIFT 1
+	u8 start_entry; /* index of the first checked entry */
+	u16 size; /* register size in dwords */
+};
+
+/* Idle Check rule */
+struct dbg_idle_chk_rule {
+	u16 rule_id; /* Idle Check rule ID */
+	u8 severity; /* value from dbg_idle_chk_severity_types enum */
+	u8 cond_id; /* Condition ID */
+	u8 num_cond_regs; /* number of condition registers */
+	u8 num_info_regs; /* number of info registers */
+	u8 num_imms; /* number of immediates in the condition */
+	u8 reserved1;
+	u16 reg_offset; /* offset of this rules registers in the idle check
+			 * register array (in dbg_idle_chk_reg units).
+			 */
+	u16 imm_offset; /* offset of this rules immediate values in the
+			 * immediate values array (in dwords).
+			 */
+};
+
+/* Idle Check rule parsing data */
+struct dbg_idle_chk_rule_parsing_data {
+	u32 data;
+#define DBG_IDLE_CHK_RULE_PARSING_DATA_HAS_FW_MSG_MASK	0x1
+#define DBG_IDLE_CHK_RULE_PARSING_DATA_HAS_FW_MSG_SHIFT	0
+#define DBG_IDLE_CHK_RULE_PARSING_DATA_STR_OFFSET_MASK	0x7FFFFFFF
+#define DBG_IDLE_CHK_RULE_PARSING_DATA_STR_OFFSET_SHIFT	1
+};
+
+/* Idle check severity types */
+enum dbg_idle_chk_severity_types {
+	/* idle check failure should cause an error */
+	IDLE_CHK_SEVERITY_ERROR,
+	/* idle check failure should cause an error only if theres no traffic */
+	IDLE_CHK_SEVERITY_ERROR_NO_TRAFFIC,
+	/* idle check failure should cause a warning */
+	IDLE_CHK_SEVERITY_WARNING,
+	MAX_DBG_IDLE_CHK_SEVERITY_TYPES
+};
+
+/* Reset register */
+struct dbg_reset_reg {
+	u32 data;
+#define DBG_RESET_REG_ADDR_MASK        0xFFFFFF
+#define DBG_RESET_REG_ADDR_SHIFT       0
+#define DBG_RESET_REG_IS_REMOVED_MASK  0x1
+#define DBG_RESET_REG_IS_REMOVED_SHIFT 24
+#define DBG_RESET_REG_RESERVED_MASK    0x7F
+#define DBG_RESET_REG_RESERVED_SHIFT   25
+};
+
+/* Debug Bus block data */
+struct dbg_bus_block_data {
+	u8 enable_mask;
+	u8 right_shift;
+	u8 force_valid_mask;
+	u8 force_frame_mask;
+	u8 dword_mask;
+	u8 line_num;
+	u8 hw_id;
+	u8 flags;
+#define DBG_BUS_BLOCK_DATA_IS_256B_LINE_MASK  0x1
+#define DBG_BUS_BLOCK_DATA_IS_256B_LINE_SHIFT 0
+#define DBG_BUS_BLOCK_DATA_RESERVED_MASK      0x7F
+#define DBG_BUS_BLOCK_DATA_RESERVED_SHIFT     1
+};
+
+enum dbg_bus_clients {
+	DBG_BUS_CLIENT_RBCN,
+	DBG_BUS_CLIENT_RBCP,
+	DBG_BUS_CLIENT_RBCR,
+	DBG_BUS_CLIENT_RBCT,
+	DBG_BUS_CLIENT_RBCU,
+	DBG_BUS_CLIENT_RBCF,
+	DBG_BUS_CLIENT_RBCX,
+	DBG_BUS_CLIENT_RBCS,
+	DBG_BUS_CLIENT_RBCH,
+	DBG_BUS_CLIENT_RBCZ,
+	DBG_BUS_CLIENT_OTHER_ENGINE,
+	DBG_BUS_CLIENT_TIMESTAMP,
+	DBG_BUS_CLIENT_CPU,
+	DBG_BUS_CLIENT_RBCY,
+	DBG_BUS_CLIENT_RBCQ,
+	DBG_BUS_CLIENT_RBCM,
+	DBG_BUS_CLIENT_RBCB,
+	DBG_BUS_CLIENT_RBCW,
+	DBG_BUS_CLIENT_RBCV,
+	MAX_DBG_BUS_CLIENTS
+};
+
+/* Debug Bus constraint operation types */
+enum dbg_bus_constraint_ops {
+	DBG_BUS_CONSTRAINT_OP_EQ,
+	DBG_BUS_CONSTRAINT_OP_NE,
+	DBG_BUS_CONSTRAINT_OP_LT,
+	DBG_BUS_CONSTRAINT_OP_LTC,
+	DBG_BUS_CONSTRAINT_OP_LE,
+	DBG_BUS_CONSTRAINT_OP_LEC,
+	DBG_BUS_CONSTRAINT_OP_GT,
+	DBG_BUS_CONSTRAINT_OP_GTC,
+	DBG_BUS_CONSTRAINT_OP_GE,
+	DBG_BUS_CONSTRAINT_OP_GEC,
+	MAX_DBG_BUS_CONSTRAINT_OPS
+};
+
+/* Debug Bus trigger state data */
+struct dbg_bus_trigger_state_data {
+	u8 msg_len;
+	u8 constraint_dword_mask;
+	u8 storm_id;
+	u8 reserved;
+};
+
+/* Debug Bus memory address */
+struct dbg_bus_mem_addr {
+	u32 lo;
+	u32 hi;
+};
+
+/* Debug Bus PCI buffer data */
+struct dbg_bus_pci_buf_data {
+	struct dbg_bus_mem_addr phys_addr; /* PCI buffer physical address */
+	struct dbg_bus_mem_addr virt_addr; /* PCI buffer virtual address */
+	u32 size; /* PCI buffer size in bytes */
+};
+
+/* Debug Bus Storm EID range filter params */
+struct dbg_bus_storm_eid_range_params {
+	u8 min; /* Minimal event ID to filter on */
+	u8 max; /* Maximal event ID to filter on */
+};
+
+/* Debug Bus Storm EID mask filter params */
+struct dbg_bus_storm_eid_mask_params {
+	u8 val; /* Event ID value */
+	u8 mask; /* Event ID mask. 1s in the mask = dont care bits. */
+};
+
+/* Debug Bus Storm EID filter params */
+union dbg_bus_storm_eid_params {
+	struct dbg_bus_storm_eid_range_params range;
+	struct dbg_bus_storm_eid_mask_params mask;
+};
+
+/* Debug Bus Storm data */
+struct dbg_bus_storm_data {
+	u8 enabled;
+	u8 mode;
+	u8 hw_id;
+	u8 eid_filter_en;
+	u8 eid_range_not_mask;
+	u8 cid_filter_en;
+	union dbg_bus_storm_eid_params eid_filter_params;
+	u32 cid;
+};
+
+/* Debug Bus data */
+struct dbg_bus_data {
+	u32 app_version;
+	u8 state;
+	u8 mode_256b_en;
+	u8 num_enabled_blocks;
+	u8 num_enabled_storms;
+	u8 target;
+	u8 one_shot_en;
+	u8 grc_input_en;
+	u8 timestamp_input_en;
+	u8 filter_en;
+	u8 adding_filter;
+	u8 filter_pre_trigger;
+	u8 filter_post_trigger;
+	u8 trigger_en;
+	u8 filter_constraint_dword_mask;
+	u8 next_trigger_state;
+	u8 next_constraint_id;
+	struct dbg_bus_trigger_state_data trigger_states[3];
+	u8 filter_msg_len;
+	u8 rcv_from_other_engine;
+	u8 blocks_dword_mask;
+	u8 blocks_dword_overlap;
+	u32 hw_id_mask;
+	struct dbg_bus_pci_buf_data pci_buf;
+	struct dbg_bus_block_data blocks[132];
+	struct dbg_bus_storm_data storms[6];
+};
+
+/* Debug bus states */
+enum dbg_bus_states {
+	DBG_BUS_STATE_IDLE,
+	DBG_BUS_STATE_READY,
+	DBG_BUS_STATE_RECORDING,
+	DBG_BUS_STATE_STOPPED,
+	MAX_DBG_BUS_STATES
+};
+
+/* Debug Bus Storm modes */
+enum dbg_bus_storm_modes {
+	DBG_BUS_STORM_MODE_PRINTF,
+	DBG_BUS_STORM_MODE_PRAM_ADDR,
+	DBG_BUS_STORM_MODE_DRA_RW,
+	DBG_BUS_STORM_MODE_DRA_W,
+	DBG_BUS_STORM_MODE_LD_ST_ADDR,
+	DBG_BUS_STORM_MODE_DRA_FSM,
+	DBG_BUS_STORM_MODE_FAST_DBGMUX,
+	DBG_BUS_STORM_MODE_RH,
+	DBG_BUS_STORM_MODE_RH_WITH_STORE,
+	DBG_BUS_STORM_MODE_FOC,
+	DBG_BUS_STORM_MODE_EXT_STORE,
+	MAX_DBG_BUS_STORM_MODES
+};
+
+/* Debug bus target IDs */
+enum dbg_bus_targets {
+	DBG_BUS_TARGET_ID_INT_BUF,
+	DBG_BUS_TARGET_ID_NIG,
+	DBG_BUS_TARGET_ID_PCI,
+	MAX_DBG_BUS_TARGETS
+};
+
+/* GRC Dump data */
+struct dbg_grc_data {
+	u8 params_initialized;
+	u8 reserved1;
+	u16 reserved2;
+	u32 param_val[48];
+};
+
+/* Debug GRC params */
+enum dbg_grc_params {
+	DBG_GRC_PARAM_DUMP_TSTORM,
+	DBG_GRC_PARAM_DUMP_MSTORM,
+	DBG_GRC_PARAM_DUMP_USTORM,
+	DBG_GRC_PARAM_DUMP_XSTORM,
+	DBG_GRC_PARAM_DUMP_YSTORM,
+	DBG_GRC_PARAM_DUMP_PSTORM,
+	DBG_GRC_PARAM_DUMP_REGS,
+	DBG_GRC_PARAM_DUMP_RAM,
+	DBG_GRC_PARAM_DUMP_PBUF,
+	DBG_GRC_PARAM_DUMP_IOR,
+	DBG_GRC_PARAM_DUMP_VFC,
+	DBG_GRC_PARAM_DUMP_CM_CTX,
+	DBG_GRC_PARAM_DUMP_PXP,
+	DBG_GRC_PARAM_DUMP_RSS,
+	DBG_GRC_PARAM_DUMP_CAU,
+	DBG_GRC_PARAM_DUMP_QM,
+	DBG_GRC_PARAM_DUMP_MCP,
+	DBG_GRC_PARAM_DUMP_DORQ,
+	DBG_GRC_PARAM_DUMP_CFC,
+	DBG_GRC_PARAM_DUMP_IGU,
+	DBG_GRC_PARAM_DUMP_BRB,
+	DBG_GRC_PARAM_DUMP_BTB,
+	DBG_GRC_PARAM_DUMP_BMB,
+	DBG_GRC_PARAM_RESERVD1,
+	DBG_GRC_PARAM_DUMP_MULD,
+	DBG_GRC_PARAM_DUMP_PRS,
+	DBG_GRC_PARAM_DUMP_DMAE,
+	DBG_GRC_PARAM_DUMP_TM,
+	DBG_GRC_PARAM_DUMP_SDM,
+	DBG_GRC_PARAM_DUMP_DIF,
+	DBG_GRC_PARAM_DUMP_STATIC,
+	DBG_GRC_PARAM_UNSTALL,
+	DBG_GRC_PARAM_RESERVED2,
+	DBG_GRC_PARAM_MCP_TRACE_META_SIZE,
+	DBG_GRC_PARAM_EXCLUDE_ALL,
+	DBG_GRC_PARAM_CRASH,
+	DBG_GRC_PARAM_PARITY_SAFE,
+	DBG_GRC_PARAM_DUMP_CM,
+	DBG_GRC_PARAM_DUMP_PHY,
+	DBG_GRC_PARAM_NO_MCP,
+	DBG_GRC_PARAM_NO_FW_VER,
+	DBG_GRC_PARAM_RESERVED3,
+	DBG_GRC_PARAM_DUMP_MCP_HW_DUMP,
+	DBG_GRC_PARAM_DUMP_ILT_CDUC,
+	DBG_GRC_PARAM_DUMP_ILT_CDUT,
+	DBG_GRC_PARAM_DUMP_CAU_EXT,
+	MAX_DBG_GRC_PARAMS
+};
+
+/* Debug status codes */
+enum dbg_status {
+	DBG_STATUS_OK,
+	DBG_STATUS_APP_VERSION_NOT_SET,
+	DBG_STATUS_UNSUPPORTED_APP_VERSION,
+	DBG_STATUS_DBG_BLOCK_NOT_RESET,
+	DBG_STATUS_INVALID_ARGS,
+	DBG_STATUS_OUTPUT_ALREADY_SET,
+	DBG_STATUS_INVALID_PCI_BUF_SIZE,
+	DBG_STATUS_PCI_BUF_ALLOC_FAILED,
+	DBG_STATUS_PCI_BUF_NOT_ALLOCATED,
+	DBG_STATUS_INVALID_FILTER_TRIGGER_DWORDS,
+	DBG_STATUS_NO_MATCHING_FRAMING_MODE,
+	DBG_STATUS_VFC_READ_ERROR,
+	DBG_STATUS_STORM_ALREADY_ENABLED,
+	DBG_STATUS_STORM_NOT_ENABLED,
+	DBG_STATUS_BLOCK_ALREADY_ENABLED,
+	DBG_STATUS_BLOCK_NOT_ENABLED,
+	DBG_STATUS_NO_INPUT_ENABLED,
+	DBG_STATUS_NO_FILTER_TRIGGER_256B,
+	DBG_STATUS_FILTER_ALREADY_ENABLED,
+	DBG_STATUS_TRIGGER_ALREADY_ENABLED,
+	DBG_STATUS_TRIGGER_NOT_ENABLED,
+	DBG_STATUS_CANT_ADD_CONSTRAINT,
+	DBG_STATUS_TOO_MANY_TRIGGER_STATES,
+	DBG_STATUS_TOO_MANY_CONSTRAINTS,
+	DBG_STATUS_RECORDING_NOT_STARTED,
+	DBG_STATUS_DATA_DIDNT_TRIGGER,
+	DBG_STATUS_NO_DATA_RECORDED,
+	DBG_STATUS_DUMP_BUF_TOO_SMALL,
+	DBG_STATUS_DUMP_NOT_CHUNK_ALIGNED,
+	DBG_STATUS_UNKNOWN_CHIP,
+	DBG_STATUS_VIRT_MEM_ALLOC_FAILED,
+	DBG_STATUS_BLOCK_IN_RESET,
+	DBG_STATUS_INVALID_TRACE_SIGNATURE,
+	DBG_STATUS_INVALID_NVRAM_BUNDLE,
+	DBG_STATUS_NVRAM_GET_IMAGE_FAILED,
+	DBG_STATUS_NON_ALIGNED_NVRAM_IMAGE,
+	DBG_STATUS_NVRAM_READ_FAILED,
+	DBG_STATUS_IDLE_CHK_PARSE_FAILED,
+	DBG_STATUS_MCP_TRACE_BAD_DATA,
+	DBG_STATUS_MCP_TRACE_NO_META,
+	DBG_STATUS_MCP_COULD_NOT_HALT,
+	DBG_STATUS_MCP_COULD_NOT_RESUME,
+	DBG_STATUS_RESERVED0,
+	DBG_STATUS_SEMI_FIFO_NOT_EMPTY,
+	DBG_STATUS_IGU_FIFO_BAD_DATA,
+	DBG_STATUS_MCP_COULD_NOT_MASK_PRTY,
+	DBG_STATUS_FW_ASSERTS_PARSE_FAILED,
+	DBG_STATUS_REG_FIFO_BAD_DATA,
+	DBG_STATUS_PROTECTION_OVERRIDE_BAD_DATA,
+	DBG_STATUS_DBG_ARRAY_NOT_SET,
+	DBG_STATUS_RESERVED1,
+	DBG_STATUS_NON_MATCHING_LINES,
+	DBG_STATUS_INSUFFICIENT_HW_IDS,
+	DBG_STATUS_DBG_BUS_IN_USE,
+	DBG_STATUS_INVALID_STORM_DBG_MODE,
+	DBG_STATUS_OTHER_ENGINE_BB_ONLY,
+	DBG_STATUS_FILTER_SINGLE_HW_ID,
+	DBG_STATUS_TRIGGER_SINGLE_HW_ID,
+	DBG_STATUS_MISSING_TRIGGER_STATE_STORM,
+	MAX_DBG_STATUS
+};
+
+/* Debug Storms IDs */
+enum dbg_storms {
+	DBG_TSTORM_ID,
+	DBG_MSTORM_ID,
+	DBG_USTORM_ID,
+	DBG_XSTORM_ID,
+	DBG_YSTORM_ID,
+	DBG_PSTORM_ID,
+	MAX_DBG_STORMS
+};
+
+/* Idle Check data */
+struct idle_chk_data {
+	u32 buf_size;
+	u8 buf_size_set;
+	u8 reserved1;
+	u16 reserved2;
+};
+
+struct pretend_params {
+	u8 split_type;
+	u8 reserved;
+	u16 split_id;
+};
+
+/* Debug Tools data (per HW function)
+ */
+struct dbg_tools_data {
+	struct dbg_grc_data grc;
+	struct dbg_bus_data bus;
+	struct idle_chk_data idle_chk;
+	u8 mode_enable[40];
+	u8 block_in_reset[132];
+	u8 chip_id;
+	u8 hw_type;
+	u8 num_ports;
+	u8 num_pfs_per_port;
+	u8 num_vfs;
+	u8 initialized;
+	u8 use_dmae;
+	u8 reserved;
+	struct pretend_params pretend;
+	u32 num_regs_read;
+};
+
+/* ILT Clients */
+enum ilt_clients {
+	ILT_CLI_CDUC,
+	ILT_CLI_CDUT,
+	ILT_CLI_QM,
+	ILT_CLI_TM,
+	ILT_CLI_SRC,
+	ILT_CLI_TSDM,
+	ILT_CLI_RGFS,
+	ILT_CLI_TGFS,
+	MAX_ILT_CLIENTS
+};
+
+/***************************** Public Functions *******************************/
+
+/**
+ * @brief qed_dbg_set_bin_ptr - Sets a pointer to the binary data with debug
+ *	arrays.
+ *
+ * @param p_hwfn -	    HW device data
+ * @param bin_ptr - a pointer to the binary data with debug arrays.
+ */
+enum dbg_status qed_dbg_set_bin_ptr(struct qed_hwfn *p_hwfn,
+				    const u8 * const bin_ptr);
+
+/**
+ * @brief qed_read_regs - Reads registers into a buffer (using GRC).
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf - Destination buffer.
+ * @param addr - Source GRC address in dwords.
+ * @param len - Number of registers to read.
+ */
+void qed_read_regs(struct qed_hwfn *p_hwfn,
+		   struct qed_ptt *p_ptt, u32 *buf, u32 addr, u32 len);
+
+/**
+ * @brief qed_read_fw_info - Reads FW info from the chip.
+ *
+ * The FW info contains FW-related information, such as the FW version,
+ * FW image (main/L2B/kuku), FW timestamp, etc.
+ * The FW info is read from the internal RAM of the first Storm that is not in
+ * reset.
+ *
+ * @param p_hwfn -	    HW device data
+ * @param p_ptt -	    Ptt window used for writing the registers.
+ * @param fw_info -	Out: a pointer to write the FW info into.
+ *
+ * @return true if the FW info was read successfully from one of the Storms,
+ * or false if all Storms are in reset.
+ */
+bool qed_read_fw_info(struct qed_hwfn *p_hwfn,
+		      struct qed_ptt *p_ptt, struct fw_info *fw_info);
+/**
+ * @brief qed_dbg_grc_config - Sets the value of a GRC parameter.
+ *
+ * @param p_hwfn -	HW device data
+ * @param grc_param -	GRC parameter
+ * @param val -		Value to set.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- grc_param is invalid
+ *	- val is outside the allowed boundaries
+ */
+enum dbg_status qed_dbg_grc_config(struct qed_hwfn *p_hwfn,
+				   enum dbg_grc_params grc_param, u32 val);
+
+/**
+ * @brief qed_dbg_grc_set_params_default - Reverts all GRC parameters to their
+ *	default value.
+ *
+ * @param p_hwfn		- HW device data
+ */
+void qed_dbg_grc_set_params_default(struct qed_hwfn *p_hwfn);
+/**
+ * @brief qed_dbg_grc_get_dump_buf_size - Returns the required buffer size for
+ *	GRC Dump.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf_size - OUT: required buffer size (in dwords) for the GRC Dump
+ *	data.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_grc_get_dump_buf_size(struct qed_hwfn *p_hwfn,
+					      struct qed_ptt *p_ptt,
+					      u32 *buf_size);
+
+/**
+ * @brief qed_dbg_grc_dump - Dumps GRC data into the specified buffer.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param dump_buf - Pointer to write the collected GRC data into.
+ * @param buf_size_in_dwords - Size of the specified buffer in dwords.
+ * @param num_dumped_dwords - OUT: number of dumped dwords.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the specified dump buffer is too small
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_grc_dump(struct qed_hwfn *p_hwfn,
+				 struct qed_ptt *p_ptt,
+				 u32 *dump_buf,
+				 u32 buf_size_in_dwords,
+				 u32 *num_dumped_dwords);
+
+/**
+ * @brief qed_dbg_idle_chk_get_dump_buf_size - Returns the required buffer size
+ *	for idle check results.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf_size - OUT: required buffer size (in dwords) for the idle check
+ *	data.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_idle_chk_get_dump_buf_size(struct qed_hwfn *p_hwfn,
+						   struct qed_ptt *p_ptt,
+						   u32 *buf_size);
+
+/**
+ * @brief qed_dbg_idle_chk_dump - Performs idle check and writes the results
+ *	into the specified buffer.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param dump_buf - Pointer to write the idle check data into.
+ * @param buf_size_in_dwords - Size of the specified buffer in dwords.
+ * @param num_dumped_dwords - OUT: number of dumped dwords.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the specified buffer is too small
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_idle_chk_dump(struct qed_hwfn *p_hwfn,
+				      struct qed_ptt *p_ptt,
+				      u32 *dump_buf,
+				      u32 buf_size_in_dwords,
+				      u32 *num_dumped_dwords);
+
+/**
+ * @brief qed_dbg_mcp_trace_get_dump_buf_size - Returns the required buffer size
+ *	for mcp trace results.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf_size - OUT: required buffer size (in dwords) for mcp trace data.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the trace data in MCP scratchpad contain an invalid signature
+ *	- the bundle ID in NVRAM is invalid
+ *	- the trace meta data cannot be found (in NVRAM or image file)
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_mcp_trace_get_dump_buf_size(struct qed_hwfn *p_hwfn,
+						    struct qed_ptt *p_ptt,
+						    u32 *buf_size);
+
+/**
+ * @brief qed_dbg_mcp_trace_dump - Performs mcp trace and writes the results
+ *	into the specified buffer.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param dump_buf - Pointer to write the mcp trace data into.
+ * @param buf_size_in_dwords - Size of the specified buffer in dwords.
+ * @param num_dumped_dwords - OUT: number of dumped dwords.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the specified buffer is too small
+ *	- the trace data in MCP scratchpad contain an invalid signature
+ *	- the bundle ID in NVRAM is invalid
+ *	- the trace meta data cannot be found (in NVRAM or image file)
+ *	- the trace meta data cannot be read (from NVRAM or image file)
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_mcp_trace_dump(struct qed_hwfn *p_hwfn,
+				       struct qed_ptt *p_ptt,
+				       u32 *dump_buf,
+				       u32 buf_size_in_dwords,
+				       u32 *num_dumped_dwords);
+
+/**
+ * @brief qed_dbg_reg_fifo_get_dump_buf_size - Returns the required buffer size
+ *	for grc trace fifo results.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf_size - OUT: required buffer size (in dwords) for reg fifo data.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_reg_fifo_get_dump_buf_size(struct qed_hwfn *p_hwfn,
+						   struct qed_ptt *p_ptt,
+						   u32 *buf_size);
+
+/**
+ * @brief qed_dbg_reg_fifo_dump - Reads the reg fifo and writes the results into
+ *	the specified buffer.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param dump_buf - Pointer to write the reg fifo data into.
+ * @param buf_size_in_dwords - Size of the specified buffer in dwords.
+ * @param num_dumped_dwords - OUT: number of dumped dwords.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the specified buffer is too small
+ *	- DMAE transaction failed
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_reg_fifo_dump(struct qed_hwfn *p_hwfn,
+				      struct qed_ptt *p_ptt,
+				      u32 *dump_buf,
+				      u32 buf_size_in_dwords,
+				      u32 *num_dumped_dwords);
+
+/**
+ * @brief qed_dbg_igu_fifo_get_dump_buf_size - Returns the required buffer size
+ *	for the IGU fifo results.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf_size - OUT: required buffer size (in dwords) for the IGU fifo
+ *	data.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_igu_fifo_get_dump_buf_size(struct qed_hwfn *p_hwfn,
+						   struct qed_ptt *p_ptt,
+						   u32 *buf_size);
+
+/**
+ * @brief qed_dbg_igu_fifo_dump - Reads the IGU fifo and writes the results into
+ *	the specified buffer.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param dump_buf - Pointer to write the IGU fifo data into.
+ * @param buf_size_in_dwords - Size of the specified buffer in dwords.
+ * @param num_dumped_dwords - OUT: number of dumped dwords.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the specified buffer is too small
+ *	- DMAE transaction failed
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_igu_fifo_dump(struct qed_hwfn *p_hwfn,
+				      struct qed_ptt *p_ptt,
+				      u32 *dump_buf,
+				      u32 buf_size_in_dwords,
+				      u32 *num_dumped_dwords);
+
+/**
+ * @brief qed_dbg_protection_override_get_dump_buf_size - Returns the required
+ *	buffer size for protection override window results.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf_size - OUT: required buffer size (in dwords) for protection
+ *	override data.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status
+qed_dbg_protection_override_get_dump_buf_size(struct qed_hwfn *p_hwfn,
+					      struct qed_ptt *p_ptt,
+					      u32 *buf_size);
+/**
+ * @brief qed_dbg_protection_override_dump - Reads protection override window
+ *	entries and writes the results into the specified buffer.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param dump_buf - Pointer to write the protection override data into.
+ * @param buf_size_in_dwords - Size of the specified buffer in dwords.
+ * @param num_dumped_dwords - OUT: number of dumped dwords.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the specified buffer is too small
+ *	- DMAE transaction failed
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_protection_override_dump(struct qed_hwfn *p_hwfn,
+						 struct qed_ptt *p_ptt,
+						 u32 *dump_buf,
+						 u32 buf_size_in_dwords,
+						 u32 *num_dumped_dwords);
+/**
+ * @brief qed_dbg_fw_asserts_get_dump_buf_size - Returns the required buffer
+ *	size for FW Asserts results.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param buf_size - OUT: required buffer size (in dwords) for FW Asserts data.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_fw_asserts_get_dump_buf_size(struct qed_hwfn *p_hwfn,
+						     struct qed_ptt *p_ptt,
+						     u32 *buf_size);
+/**
+ * @brief qed_dbg_fw_asserts_dump - Reads the FW Asserts and writes the results
+ *	into the specified buffer.
+ *
+ * @param p_hwfn - HW device data
+ * @param p_ptt - Ptt window used for writing the registers.
+ * @param dump_buf - Pointer to write the FW Asserts data into.
+ * @param buf_size_in_dwords - Size of the specified buffer in dwords.
+ * @param num_dumped_dwords - OUT: number of dumped dwords.
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ *	- the specified buffer is too small
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_fw_asserts_dump(struct qed_hwfn *p_hwfn,
+					struct qed_ptt *p_ptt,
+					u32 *dump_buf,
+					u32 buf_size_in_dwords,
+					u32 *num_dumped_dwords);
+
+/**
+ * @brief qed_dbg_read_attn - Reads the attention registers of the specified
+ * block and type, and writes the results into the specified buffer.
+ *
+ * @param p_hwfn -	 HW device data
+ * @param p_ptt -	 Ptt window used for writing the registers.
+ * @param block -	 Block ID.
+ * @param attn_type -	 Attention type.
+ * @param clear_status - Indicates if the attention status should be cleared.
+ * @param results -	 OUT: Pointer to write the read results into
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_read_attn(struct qed_hwfn *p_hwfn,
+				  struct qed_ptt *p_ptt,
+				  enum block_id block,
+				  enum dbg_attn_type attn_type,
+				  bool clear_status,
+				  struct dbg_attn_block_result *results);
+
+/**
+ * @brief qed_dbg_print_attn - Prints attention registers values in the
+ *	specified results struct.
+ *
+ * @param p_hwfn
+ * @param results - Pointer to the attention read results
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_print_attn(struct qed_hwfn *p_hwfn,
+				   struct dbg_attn_block_result *results);
+
+/******************************* Data Types **********************************/
+
+struct mcp_trace_format {
+	u32 data;
+#define MCP_TRACE_FORMAT_MODULE_MASK	0x0000ffff
+#define MCP_TRACE_FORMAT_MODULE_OFFSET	0
+#define MCP_TRACE_FORMAT_LEVEL_MASK	0x00030000
+#define MCP_TRACE_FORMAT_LEVEL_OFFSET	16
+#define MCP_TRACE_FORMAT_P1_SIZE_MASK	0x000c0000
+#define MCP_TRACE_FORMAT_P1_SIZE_OFFSET 18
+#define MCP_TRACE_FORMAT_P2_SIZE_MASK	0x00300000
+#define MCP_TRACE_FORMAT_P2_SIZE_OFFSET 20
+#define MCP_TRACE_FORMAT_P3_SIZE_MASK	0x00c00000
+#define MCP_TRACE_FORMAT_P3_SIZE_OFFSET 22
+#define MCP_TRACE_FORMAT_LEN_MASK	0xff000000
+#define MCP_TRACE_FORMAT_LEN_OFFSET	24
+
+	char *format_str;
+};
+
+/* MCP Trace Meta data structure */
+struct mcp_trace_meta {
+	u32 modules_num;
+	char **modules;
+	u32 formats_num;
+	struct mcp_trace_format *formats;
+	bool is_allocated;
+};
+
+/* Debug Tools user data */
+struct dbg_tools_user_data {
+	struct mcp_trace_meta mcp_trace_meta;
+	const u32 *mcp_trace_user_meta_buf;
+};
+
+/******************************** Constants **********************************/
+
+#define MAX_NAME_LEN	16
+
+/***************************** Public Functions *******************************/
+
+/**
+ * @brief qed_dbg_user_set_bin_ptr - Sets a pointer to the binary data with
+ *	debug arrays.
+ *
+ * @param p_hwfn - HW device data
+ * @param bin_ptr - a pointer to the binary data with debug arrays.
+ */
+enum dbg_status qed_dbg_user_set_bin_ptr(struct qed_hwfn *p_hwfn,
+					 const u8 * const bin_ptr);
+
+/**
+ * @brief qed_dbg_alloc_user_data - Allocates user debug data.
+ *
+ * @param p_hwfn -		 HW device data
+ * @param user_data_ptr - OUT: a pointer to the allocated memory.
+ */
+enum dbg_status qed_dbg_alloc_user_data(struct qed_hwfn *p_hwfn,
+					void **user_data_ptr);
+
+/**
+ * @brief qed_dbg_get_status_str - Returns a string for the specified status.
+ *
+ * @param status - a debug status code.
+ *
+ * @return a string for the specified status
+ */
+const char *qed_dbg_get_status_str(enum dbg_status status);
+
+/**
+ * @brief qed_get_idle_chk_results_buf_size - Returns the required buffer size
+ *	for idle check results (in bytes).
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - idle check dump buffer.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
+ *	results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_get_idle_chk_results_buf_size(struct qed_hwfn *p_hwfn,
+						  u32 *dump_buf,
+						  u32  num_dumped_dwords,
+						  u32 *results_buf_size);
+/**
+ * @brief qed_print_idle_chk_results - Prints idle check results
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - idle check dump buffer.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf - buffer for printing the idle check results.
+ * @param num_errors - OUT: number of errors found in idle check.
+ * @param num_warnings - OUT: number of warnings found in idle check.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_idle_chk_results(struct qed_hwfn *p_hwfn,
+					   u32 *dump_buf,
+					   u32 num_dumped_dwords,
+					   char *results_buf,
+					   u32 *num_errors,
+					   u32 *num_warnings);
+
+/**
+ * @brief qed_dbg_mcp_trace_set_meta_data - Sets the MCP Trace meta data.
+ *
+ * Needed in case the MCP Trace dump doesn't contain the meta data (e.g. due to
+ * no NVRAM access).
+ *
+ * @param data - pointer to MCP Trace meta data
+ * @param size - size of MCP Trace meta data in dwords
+ */
+void qed_dbg_mcp_trace_set_meta_data(struct qed_hwfn *p_hwfn,
+				     const u32 *meta_buf);
+
+/**
+ * @brief qed_get_mcp_trace_results_buf_size - Returns the required buffer size
+ *	for MCP Trace results (in bytes).
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - MCP Trace dump buffer.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
+ *	results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_get_mcp_trace_results_buf_size(struct qed_hwfn *p_hwfn,
+						   u32 *dump_buf,
+						   u32 num_dumped_dwords,
+						   u32 *results_buf_size);
+
+/**
+ * @brief qed_print_mcp_trace_results - Prints MCP Trace results
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - mcp trace dump buffer, starting from the header.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf - buffer for printing the mcp trace results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_mcp_trace_results(struct qed_hwfn *p_hwfn,
+					    u32 *dump_buf,
+					    u32 num_dumped_dwords,
+					    char *results_buf);
+
+/**
+ * @brief qed_print_mcp_trace_results_cont - Prints MCP Trace results, and
+ * keeps the MCP trace meta data allocated, to support continuous MCP Trace
+ * parsing. After the continuous parsing ends, mcp_trace_free_meta_data should
+ * be called to free the meta data.
+ *
+ * @param p_hwfn -	      HW device data
+ * @param dump_buf -	      mcp trace dump buffer, starting from the header.
+ * @param results_buf -	      buffer for printing the mcp trace results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_mcp_trace_results_cont(struct qed_hwfn *p_hwfn,
+						 u32 *dump_buf,
+						 char *results_buf);
+
+/**
+ * @brief print_mcp_trace_line - Prints MCP Trace results for a single line
+ *
+ * @param p_hwfn -	      HW device data
+ * @param dump_buf -	      mcp trace dump buffer, starting from the header.
+ * @param num_dumped_bytes -  number of bytes that were dumped.
+ * @param results_buf -	      buffer for printing the mcp trace results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_mcp_trace_line(struct qed_hwfn *p_hwfn,
+					 u8 *dump_buf,
+					 u32 num_dumped_bytes,
+					 char *results_buf);
+
+/**
+ * @brief mcp_trace_free_meta_data - Frees the MCP Trace meta data.
+ * Should be called after continuous MCP Trace parsing.
+ *
+ * @param p_hwfn - HW device data
+ */
+void qed_mcp_trace_free_meta_data(struct qed_hwfn *p_hwfn);
+
+/**
+ * @brief qed_get_reg_fifo_results_buf_size - Returns the required buffer size
+ *	for reg_fifo results (in bytes).
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - reg fifo dump buffer.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
+ *	results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_get_reg_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
+						  u32 *dump_buf,
+						  u32 num_dumped_dwords,
+						  u32 *results_buf_size);
+
+/**
+ * @brief qed_print_reg_fifo_results - Prints reg fifo results
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - reg fifo dump buffer, starting from the header.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf - buffer for printing the reg fifo results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_reg_fifo_results(struct qed_hwfn *p_hwfn,
+					   u32 *dump_buf,
+					   u32 num_dumped_dwords,
+					   char *results_buf);
+
+/**
+ * @brief qed_get_igu_fifo_results_buf_size - Returns the required buffer size
+ *	for igu_fifo results (in bytes).
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - IGU fifo dump buffer.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
+ *	results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_get_igu_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
+						  u32 *dump_buf,
+						  u32 num_dumped_dwords,
+						  u32 *results_buf_size);
+
+/**
+ * @brief qed_print_igu_fifo_results - Prints IGU fifo results
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - IGU fifo dump buffer, starting from the header.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf - buffer for printing the IGU fifo results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_igu_fifo_results(struct qed_hwfn *p_hwfn,
+					   u32 *dump_buf,
+					   u32 num_dumped_dwords,
+					   char *results_buf);
+
+/**
+ * @brief qed_get_protection_override_results_buf_size - Returns the required
+ *	buffer size for protection override results (in bytes).
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - protection override dump buffer.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
+ *	results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status
+qed_get_protection_override_results_buf_size(struct qed_hwfn *p_hwfn,
+					     u32 *dump_buf,
+					     u32 num_dumped_dwords,
+					     u32 *results_buf_size);
+
+/**
+ * @brief qed_print_protection_override_results - Prints protection override
+ *	results.
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - protection override dump buffer, starting from the header.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf - buffer for printing the reg fifo results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_protection_override_results(struct qed_hwfn *p_hwfn,
+						      u32 *dump_buf,
+						      u32 num_dumped_dwords,
+						      char *results_buf);
+
+/**
+ * @brief qed_get_fw_asserts_results_buf_size - Returns the required buffer size
+ *	for FW Asserts results (in bytes).
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - FW Asserts dump buffer.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
+ *	results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_get_fw_asserts_results_buf_size(struct qed_hwfn *p_hwfn,
+						    u32 *dump_buf,
+						    u32 num_dumped_dwords,
+						    u32 *results_buf_size);
+
+/**
+ * @brief qed_print_fw_asserts_results - Prints FW Asserts results
+ *
+ * @param p_hwfn - HW device data
+ * @param dump_buf - FW Asserts dump buffer, starting from the header.
+ * @param num_dumped_dwords - number of dwords that were dumped.
+ * @param results_buf - buffer for printing the FW Asserts results.
+ *
+ * @return error if the parsing fails, ok otherwise.
+ */
+enum dbg_status qed_print_fw_asserts_results(struct qed_hwfn *p_hwfn,
+					     u32 *dump_buf,
+					     u32 num_dumped_dwords,
+					     char *results_buf);
+
+/**
+ * @brief qed_dbg_parse_attn - Parses and prints attention registers values in
+ * the specified results struct.
+ *
+ * @param p_hwfn -  HW device data
+ * @param results - Pointer to the attention read results
+ *
+ * @return error if one of the following holds:
+ *	- the version wasn't set
+ * Otherwise, returns ok.
+ */
+enum dbg_status qed_dbg_parse_attn(struct qed_hwfn *p_hwfn,
+				   struct dbg_attn_block_result *results);
+
+#endif
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
index e1798925b444..ea839e605577 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
@@ -84,16 +84,17 @@ struct qed_dcbx_mib_meta_data {
 extern const struct qed_eth_dcbnl_ops qed_dcbnl_ops_pass;
 
 #ifdef CONFIG_DCB
-int qed_dcbx_get_config_params(struct qed_hwfn *, struct qed_dcbx_set *);
+int qed_dcbx_get_config_params(struct qed_hwfn *p_hwfn,
+			       struct qed_dcbx_set *params);
 
-int qed_dcbx_config_params(struct qed_hwfn *,
-			   struct qed_ptt *, struct qed_dcbx_set *, bool);
+int qed_dcbx_config_params(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
+			   struct qed_dcbx_set *params, bool hw_commit);
 #endif
 
 /* QED local interface routines */
 int
-qed_dcbx_mib_update_event(struct qed_hwfn *,
-			  struct qed_ptt *, enum qed_mib_read_type);
+qed_dcbx_mib_update_event(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
+			  enum qed_mib_read_type type);
 
 int qed_dcbx_info_alloc(struct qed_hwfn *p_hwfn);
 void qed_dcbx_info_free(struct qed_hwfn *p_hwfn);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index 380cf4963cbb..e6e5c7721701 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -10,6 +10,7 @@
 #include "qed.h"
 #include "qed_cxt.h"
 #include "qed_hsi.h"
+#include "qed_dbg_hsi.h"
 #include "qed_hw.h"
 #include "qed_mcp.h"
 #include "qed_reg_addr.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 0410c3604abd..3db1a5512b9b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -25,6 +25,7 @@
 #include "qed_dev_api.h"
 #include "qed_fcoe.h"
 #include "qed_hsi.h"
+#include "qed_iro_hsi.h"
 #include "qed_hw.h"
 #include "qed_init_ops.h"
 #include "qed_int.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev_api.h b/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
index d3c1f3879be8..1d64d86692bb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev_api.h
@@ -153,7 +153,6 @@ int qed_hw_stop_fastpath(struct qed_dev *cdev);
  */
 int qed_hw_start_fastpath(struct qed_hwfn *p_hwfn);
 
-
 /**
  * @brief qed_hw_prepare -
  *
@@ -223,7 +222,7 @@ qed_dmae_host2grc(struct qed_hwfn *p_hwfn,
 		  u32 size_in_dwords,
 		  struct qed_dmae_params *p_params);
 
- /**
+/**
  * @brief qed_dmae_grc2host - Read data from dmae data offset
  * to source address using the given ptt
  *
@@ -239,7 +238,7 @@ int qed_dmae_grc2host(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 
 /**
  * @brief qed_dmae_host2host - copy data from to source address
- * to a destination adress (for SRIOV) using the given ptt
+ * to a destination address (for SRIOV) using the given ptt
  *
  * @param p_hwfn
  * @param p_ptt
@@ -483,6 +482,5 @@ int qed_db_recovery_add(struct qed_dev *cdev,
 int qed_db_recovery_del(struct qed_dev *cdev,
 			void __iomem *db_addr, void *db_data);
 
-
 const char *qed_hw_get_resc_name(enum qed_resources res_id);
 #endif
diff --git a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
index ba246d90344a..c46d809040bd 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
@@ -30,6 +30,7 @@
 #include "qed_hsi.h"
 #include "qed_hw.h"
 #include "qed_int.h"
+#include "qed_iro_hsi.h"
 #include "qed_ll2.h"
 #include "qed_mcp.h"
 #include "qed_reg_addr.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index c90f03b91893..ad828c7a58cb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -1831,769 +1831,6 @@ struct virt_mem_desc {
 	u32 size;		/* In bytes */
 };
 
-/****************************************/
-/* Debug Tools HSI constants and macros */
-/****************************************/
-
-enum block_id {
-	BLOCK_GRC,
-	BLOCK_MISCS,
-	BLOCK_MISC,
-	BLOCK_DBU,
-	BLOCK_PGLUE_B,
-	BLOCK_CNIG,
-	BLOCK_CPMU,
-	BLOCK_NCSI,
-	BLOCK_OPTE,
-	BLOCK_BMB,
-	BLOCK_PCIE,
-	BLOCK_MCP,
-	BLOCK_MCP2,
-	BLOCK_PSWHST,
-	BLOCK_PSWHST2,
-	BLOCK_PSWRD,
-	BLOCK_PSWRD2,
-	BLOCK_PSWWR,
-	BLOCK_PSWWR2,
-	BLOCK_PSWRQ,
-	BLOCK_PSWRQ2,
-	BLOCK_PGLCS,
-	BLOCK_DMAE,
-	BLOCK_PTU,
-	BLOCK_TCM,
-	BLOCK_MCM,
-	BLOCK_UCM,
-	BLOCK_XCM,
-	BLOCK_YCM,
-	BLOCK_PCM,
-	BLOCK_QM,
-	BLOCK_TM,
-	BLOCK_DORQ,
-	BLOCK_BRB,
-	BLOCK_SRC,
-	BLOCK_PRS,
-	BLOCK_TSDM,
-	BLOCK_MSDM,
-	BLOCK_USDM,
-	BLOCK_XSDM,
-	BLOCK_YSDM,
-	BLOCK_PSDM,
-	BLOCK_TSEM,
-	BLOCK_MSEM,
-	BLOCK_USEM,
-	BLOCK_XSEM,
-	BLOCK_YSEM,
-	BLOCK_PSEM,
-	BLOCK_RSS,
-	BLOCK_TMLD,
-	BLOCK_MULD,
-	BLOCK_YULD,
-	BLOCK_XYLD,
-	BLOCK_PRM,
-	BLOCK_PBF_PB1,
-	BLOCK_PBF_PB2,
-	BLOCK_RPB,
-	BLOCK_BTB,
-	BLOCK_PBF,
-	BLOCK_RDIF,
-	BLOCK_TDIF,
-	BLOCK_CDU,
-	BLOCK_CCFC,
-	BLOCK_TCFC,
-	BLOCK_IGU,
-	BLOCK_CAU,
-	BLOCK_UMAC,
-	BLOCK_XMAC,
-	BLOCK_MSTAT,
-	BLOCK_DBG,
-	BLOCK_NIG,
-	BLOCK_WOL,
-	BLOCK_BMBN,
-	BLOCK_IPC,
-	BLOCK_NWM,
-	BLOCK_NWS,
-	BLOCK_MS,
-	BLOCK_PHY_PCIE,
-	BLOCK_LED,
-	BLOCK_AVS_WRAP,
-	BLOCK_PXPREQBUS,
-	BLOCK_BAR0_MAP,
-	BLOCK_MCP_FIO,
-	BLOCK_LAST_INIT,
-	BLOCK_PRS_FC,
-	BLOCK_PBF_FC,
-	BLOCK_NIG_LB_FC,
-	BLOCK_NIG_LB_FC_PLLH,
-	BLOCK_NIG_TX_FC_PLLH,
-	BLOCK_NIG_TX_FC,
-	BLOCK_NIG_RX_FC_PLLH,
-	BLOCK_NIG_RX_FC,
-	MAX_BLOCK_ID
-};
-
-/* binary debug buffer types */
-enum bin_dbg_buffer_type {
-	BIN_BUF_DBG_MODE_TREE,
-	BIN_BUF_DBG_DUMP_REG,
-	BIN_BUF_DBG_DUMP_MEM,
-	BIN_BUF_DBG_IDLE_CHK_REGS,
-	BIN_BUF_DBG_IDLE_CHK_IMMS,
-	BIN_BUF_DBG_IDLE_CHK_RULES,
-	BIN_BUF_DBG_IDLE_CHK_PARSING_DATA,
-	BIN_BUF_DBG_ATTN_BLOCKS,
-	BIN_BUF_DBG_ATTN_REGS,
-	BIN_BUF_DBG_ATTN_INDEXES,
-	BIN_BUF_DBG_ATTN_NAME_OFFSETS,
-	BIN_BUF_DBG_BLOCKS,
-	BIN_BUF_DBG_BLOCKS_CHIP_DATA,
-	BIN_BUF_DBG_BUS_LINES,
-	BIN_BUF_DBG_BLOCKS_USER_DATA,
-	BIN_BUF_DBG_BLOCKS_CHIP_USER_DATA,
-	BIN_BUF_DBG_BUS_LINE_NAME_OFFSETS,
-	BIN_BUF_DBG_RESET_REGS,
-	BIN_BUF_DBG_PARSING_STRINGS,
-	MAX_BIN_DBG_BUFFER_TYPE
-};
-
-
-/* Attention bit mapping */
-struct dbg_attn_bit_mapping {
-	u16 data;
-#define DBG_ATTN_BIT_MAPPING_VAL_MASK			0x7FFF
-#define DBG_ATTN_BIT_MAPPING_VAL_SHIFT			0
-#define DBG_ATTN_BIT_MAPPING_IS_UNUSED_BIT_CNT_MASK	0x1
-#define DBG_ATTN_BIT_MAPPING_IS_UNUSED_BIT_CNT_SHIFT	15
-};
-
-/* Attention block per-type data */
-struct dbg_attn_block_type_data {
-	u16 names_offset;
-	u16 reserved1;
-	u8 num_regs;
-	u8 reserved2;
-	u16 regs_offset;
-
-};
-
-/* Block attentions */
-struct dbg_attn_block {
-	struct dbg_attn_block_type_data per_type_data[2];
-};
-
-/* Attention register result */
-struct dbg_attn_reg_result {
-	u32 data;
-#define DBG_ATTN_REG_RESULT_STS_ADDRESS_MASK	0xFFFFFF
-#define DBG_ATTN_REG_RESULT_STS_ADDRESS_SHIFT	0
-#define DBG_ATTN_REG_RESULT_NUM_REG_ATTN_MASK	0xFF
-#define DBG_ATTN_REG_RESULT_NUM_REG_ATTN_SHIFT	24
-	u16 block_attn_offset;
-	u16 reserved;
-	u32 sts_val;
-	u32 mask_val;
-};
-
-/* Attention block result */
-struct dbg_attn_block_result {
-	u8 block_id;
-	u8 data;
-#define DBG_ATTN_BLOCK_RESULT_ATTN_TYPE_MASK	0x3
-#define DBG_ATTN_BLOCK_RESULT_ATTN_TYPE_SHIFT	0
-#define DBG_ATTN_BLOCK_RESULT_NUM_REGS_MASK	0x3F
-#define DBG_ATTN_BLOCK_RESULT_NUM_REGS_SHIFT	2
-	u16 names_offset;
-	struct dbg_attn_reg_result reg_results[15];
-};
-
-/* Mode header */
-struct dbg_mode_hdr {
-	u16 data;
-#define DBG_MODE_HDR_EVAL_MODE_MASK		0x1
-#define DBG_MODE_HDR_EVAL_MODE_SHIFT		0
-#define DBG_MODE_HDR_MODES_BUF_OFFSET_MASK	0x7FFF
-#define DBG_MODE_HDR_MODES_BUF_OFFSET_SHIFT	1
-};
-
-/* Attention register */
-struct dbg_attn_reg {
-	struct dbg_mode_hdr mode;
-	u16 block_attn_offset;
-	u32 data;
-#define DBG_ATTN_REG_STS_ADDRESS_MASK	0xFFFFFF
-#define DBG_ATTN_REG_STS_ADDRESS_SHIFT	0
-#define DBG_ATTN_REG_NUM_REG_ATTN_MASK	0xFF
-#define DBG_ATTN_REG_NUM_REG_ATTN_SHIFT 24
-	u32 sts_clr_address;
-	u32 mask_address;
-};
-
-/* Attention types */
-enum dbg_attn_type {
-	ATTN_TYPE_INTERRUPT,
-	ATTN_TYPE_PARITY,
-	MAX_DBG_ATTN_TYPE
-};
-
-/* Block debug data */
-struct dbg_block {
-	u8 name[15];
-	u8 associated_storm_letter;
-};
-
-/* Chip-specific block debug data */
-struct dbg_block_chip {
-	u8 flags;
-#define DBG_BLOCK_CHIP_IS_REMOVED_MASK		 0x1
-#define DBG_BLOCK_CHIP_IS_REMOVED_SHIFT		 0
-#define DBG_BLOCK_CHIP_HAS_RESET_REG_MASK	 0x1
-#define DBG_BLOCK_CHIP_HAS_RESET_REG_SHIFT	 1
-#define DBG_BLOCK_CHIP_UNRESET_BEFORE_DUMP_MASK  0x1
-#define DBG_BLOCK_CHIP_UNRESET_BEFORE_DUMP_SHIFT 2
-#define DBG_BLOCK_CHIP_HAS_DBG_BUS_MASK		 0x1
-#define DBG_BLOCK_CHIP_HAS_DBG_BUS_SHIFT	 3
-#define DBG_BLOCK_CHIP_HAS_LATENCY_EVENTS_MASK	 0x1
-#define DBG_BLOCK_CHIP_HAS_LATENCY_EVENTS_SHIFT  4
-#define DBG_BLOCK_CHIP_RESERVED0_MASK		 0x7
-#define DBG_BLOCK_CHIP_RESERVED0_SHIFT		 5
-	u8 dbg_client_id;
-	u8 reset_reg_id;
-	u8 reset_reg_bit_offset;
-	struct dbg_mode_hdr dbg_bus_mode;
-	u16 reserved1;
-	u8 reserved2;
-	u8 num_of_dbg_bus_lines;
-	u16 dbg_bus_lines_offset;
-	u32 dbg_select_reg_addr;
-	u32 dbg_dword_enable_reg_addr;
-	u32 dbg_shift_reg_addr;
-	u32 dbg_force_valid_reg_addr;
-	u32 dbg_force_frame_reg_addr;
-};
-
-/* Chip-specific block user debug data */
-struct dbg_block_chip_user {
-	u8 num_of_dbg_bus_lines;
-	u8 has_latency_events;
-	u16 names_offset;
-};
-
-/* Block user debug data */
-struct dbg_block_user {
-	u8 name[16];
-};
-
-/* Block Debug line data */
-struct dbg_bus_line {
-	u8 data;
-#define DBG_BUS_LINE_NUM_OF_GROUPS_MASK		0xF
-#define DBG_BUS_LINE_NUM_OF_GROUPS_SHIFT	0
-#define DBG_BUS_LINE_IS_256B_MASK		0x1
-#define DBG_BUS_LINE_IS_256B_SHIFT		4
-#define DBG_BUS_LINE_RESERVED_MASK		0x7
-#define DBG_BUS_LINE_RESERVED_SHIFT		5
-	u8 group_sizes;
-};
-
-/* Condition header for registers dump */
-struct dbg_dump_cond_hdr {
-	struct dbg_mode_hdr mode; /* Mode header */
-	u8 block_id; /* block ID */
-	u8 data_size; /* size in dwords of the data following this header */
-};
-
-/* Memory data for registers dump */
-struct dbg_dump_mem {
-	u32 dword0;
-#define DBG_DUMP_MEM_ADDRESS_MASK	0xFFFFFF
-#define DBG_DUMP_MEM_ADDRESS_SHIFT	0
-#define DBG_DUMP_MEM_MEM_GROUP_ID_MASK	0xFF
-#define DBG_DUMP_MEM_MEM_GROUP_ID_SHIFT	24
-	u32 dword1;
-#define DBG_DUMP_MEM_LENGTH_MASK	0xFFFFFF
-#define DBG_DUMP_MEM_LENGTH_SHIFT	0
-#define DBG_DUMP_MEM_WIDE_BUS_MASK	0x1
-#define DBG_DUMP_MEM_WIDE_BUS_SHIFT	24
-#define DBG_DUMP_MEM_RESERVED_MASK	0x7F
-#define DBG_DUMP_MEM_RESERVED_SHIFT	25
-};
-
-/* Register data for registers dump */
-struct dbg_dump_reg {
-	u32 data;
-#define DBG_DUMP_REG_ADDRESS_MASK	0x7FFFFF
-#define DBG_DUMP_REG_ADDRESS_SHIFT	0
-#define DBG_DUMP_REG_WIDE_BUS_MASK	0x1
-#define DBG_DUMP_REG_WIDE_BUS_SHIFT	23
-#define DBG_DUMP_REG_LENGTH_MASK	0xFF
-#define DBG_DUMP_REG_LENGTH_SHIFT	24
-};
-
-/* Split header for registers dump */
-struct dbg_dump_split_hdr {
-	u32 hdr;
-#define DBG_DUMP_SPLIT_HDR_DATA_SIZE_MASK	0xFFFFFF
-#define DBG_DUMP_SPLIT_HDR_DATA_SIZE_SHIFT	0
-#define DBG_DUMP_SPLIT_HDR_SPLIT_TYPE_ID_MASK	0xFF
-#define DBG_DUMP_SPLIT_HDR_SPLIT_TYPE_ID_SHIFT	24
-};
-
-/* Condition header for idle check */
-struct dbg_idle_chk_cond_hdr {
-	struct dbg_mode_hdr mode; /* Mode header */
-	u16 data_size; /* size in dwords of the data following this header */
-};
-
-/* Idle Check condition register */
-struct dbg_idle_chk_cond_reg {
-	u32 data;
-#define DBG_IDLE_CHK_COND_REG_ADDRESS_MASK	0x7FFFFF
-#define DBG_IDLE_CHK_COND_REG_ADDRESS_SHIFT	0
-#define DBG_IDLE_CHK_COND_REG_WIDE_BUS_MASK	0x1
-#define DBG_IDLE_CHK_COND_REG_WIDE_BUS_SHIFT	23
-#define DBG_IDLE_CHK_COND_REG_BLOCK_ID_MASK	0xFF
-#define DBG_IDLE_CHK_COND_REG_BLOCK_ID_SHIFT	24
-	u16 num_entries;
-	u8 entry_size;
-	u8 start_entry;
-};
-
-/* Idle Check info register */
-struct dbg_idle_chk_info_reg {
-	u32 data;
-#define DBG_IDLE_CHK_INFO_REG_ADDRESS_MASK	0x7FFFFF
-#define DBG_IDLE_CHK_INFO_REG_ADDRESS_SHIFT	0
-#define DBG_IDLE_CHK_INFO_REG_WIDE_BUS_MASK	0x1
-#define DBG_IDLE_CHK_INFO_REG_WIDE_BUS_SHIFT	23
-#define DBG_IDLE_CHK_INFO_REG_BLOCK_ID_MASK	0xFF
-#define DBG_IDLE_CHK_INFO_REG_BLOCK_ID_SHIFT	24
-	u16 size; /* register size in dwords */
-	struct dbg_mode_hdr mode; /* Mode header */
-};
-
-/* Idle Check register */
-union dbg_idle_chk_reg {
-	struct dbg_idle_chk_cond_reg cond_reg; /* condition register */
-	struct dbg_idle_chk_info_reg info_reg; /* info register */
-};
-
-/* Idle Check result header */
-struct dbg_idle_chk_result_hdr {
-	u16 rule_id; /* Failing rule index */
-	u16 mem_entry_id; /* Failing memory entry index */
-	u8 num_dumped_cond_regs; /* number of dumped condition registers */
-	u8 num_dumped_info_regs; /* number of dumped condition registers */
-	u8 severity; /* from dbg_idle_chk_severity_types enum */
-	u8 reserved;
-};
-
-/* Idle Check result register header */
-struct dbg_idle_chk_result_reg_hdr {
-	u8 data;
-#define DBG_IDLE_CHK_RESULT_REG_HDR_IS_MEM_MASK  0x1
-#define DBG_IDLE_CHK_RESULT_REG_HDR_IS_MEM_SHIFT 0
-#define DBG_IDLE_CHK_RESULT_REG_HDR_REG_ID_MASK  0x7F
-#define DBG_IDLE_CHK_RESULT_REG_HDR_REG_ID_SHIFT 1
-	u8 start_entry; /* index of the first checked entry */
-	u16 size; /* register size in dwords */
-};
-
-/* Idle Check rule */
-struct dbg_idle_chk_rule {
-	u16 rule_id; /* Idle Check rule ID */
-	u8 severity; /* value from dbg_idle_chk_severity_types enum */
-	u8 cond_id; /* Condition ID */
-	u8 num_cond_regs; /* number of condition registers */
-	u8 num_info_regs; /* number of info registers */
-	u8 num_imms; /* number of immediates in the condition */
-	u8 reserved1;
-	u16 reg_offset; /* offset of this rules registers in the idle check
-			 * register array (in dbg_idle_chk_reg units).
-			 */
-	u16 imm_offset; /* offset of this rules immediate values in the
-			 * immediate values array (in dwords).
-			 */
-};
-
-/* Idle Check rule parsing data */
-struct dbg_idle_chk_rule_parsing_data {
-	u32 data;
-#define DBG_IDLE_CHK_RULE_PARSING_DATA_HAS_FW_MSG_MASK	0x1
-#define DBG_IDLE_CHK_RULE_PARSING_DATA_HAS_FW_MSG_SHIFT	0
-#define DBG_IDLE_CHK_RULE_PARSING_DATA_STR_OFFSET_MASK	0x7FFFFFFF
-#define DBG_IDLE_CHK_RULE_PARSING_DATA_STR_OFFSET_SHIFT	1
-};
-
-/* Idle check severity types */
-enum dbg_idle_chk_severity_types {
-	/* idle check failure should cause an error */
-	IDLE_CHK_SEVERITY_ERROR,
-	/* idle check failure should cause an error only if theres no traffic */
-	IDLE_CHK_SEVERITY_ERROR_NO_TRAFFIC,
-	/* idle check failure should cause a warning */
-	IDLE_CHK_SEVERITY_WARNING,
-	MAX_DBG_IDLE_CHK_SEVERITY_TYPES
-};
-
-/* Reset register */
-struct dbg_reset_reg {
-	u32 data;
-#define DBG_RESET_REG_ADDR_MASK        0xFFFFFF
-#define DBG_RESET_REG_ADDR_SHIFT       0
-#define DBG_RESET_REG_IS_REMOVED_MASK  0x1
-#define DBG_RESET_REG_IS_REMOVED_SHIFT 24
-#define DBG_RESET_REG_RESERVED_MASK    0x7F
-#define DBG_RESET_REG_RESERVED_SHIFT   25
-};
-
-/* Debug Bus block data */
-struct dbg_bus_block_data {
-	u8 enable_mask;
-	u8 right_shift;
-	u8 force_valid_mask;
-	u8 force_frame_mask;
-	u8 dword_mask;
-	u8 line_num;
-	u8 hw_id;
-	u8 flags;
-#define DBG_BUS_BLOCK_DATA_IS_256B_LINE_MASK  0x1
-#define DBG_BUS_BLOCK_DATA_IS_256B_LINE_SHIFT 0
-#define DBG_BUS_BLOCK_DATA_RESERVED_MASK      0x7F
-#define DBG_BUS_BLOCK_DATA_RESERVED_SHIFT     1
-};
-
-enum dbg_bus_clients {
-	DBG_BUS_CLIENT_RBCN,
-	DBG_BUS_CLIENT_RBCP,
-	DBG_BUS_CLIENT_RBCR,
-	DBG_BUS_CLIENT_RBCT,
-	DBG_BUS_CLIENT_RBCU,
-	DBG_BUS_CLIENT_RBCF,
-	DBG_BUS_CLIENT_RBCX,
-	DBG_BUS_CLIENT_RBCS,
-	DBG_BUS_CLIENT_RBCH,
-	DBG_BUS_CLIENT_RBCZ,
-	DBG_BUS_CLIENT_OTHER_ENGINE,
-	DBG_BUS_CLIENT_TIMESTAMP,
-	DBG_BUS_CLIENT_CPU,
-	DBG_BUS_CLIENT_RBCY,
-	DBG_BUS_CLIENT_RBCQ,
-	DBG_BUS_CLIENT_RBCM,
-	DBG_BUS_CLIENT_RBCB,
-	DBG_BUS_CLIENT_RBCW,
-	DBG_BUS_CLIENT_RBCV,
-	MAX_DBG_BUS_CLIENTS
-};
-
-/* Debug Bus constraint operation types */
-enum dbg_bus_constraint_ops {
-	DBG_BUS_CONSTRAINT_OP_EQ,
-	DBG_BUS_CONSTRAINT_OP_NE,
-	DBG_BUS_CONSTRAINT_OP_LT,
-	DBG_BUS_CONSTRAINT_OP_LTC,
-	DBG_BUS_CONSTRAINT_OP_LE,
-	DBG_BUS_CONSTRAINT_OP_LEC,
-	DBG_BUS_CONSTRAINT_OP_GT,
-	DBG_BUS_CONSTRAINT_OP_GTC,
-	DBG_BUS_CONSTRAINT_OP_GE,
-	DBG_BUS_CONSTRAINT_OP_GEC,
-	MAX_DBG_BUS_CONSTRAINT_OPS
-};
-
-/* Debug Bus trigger state data */
-struct dbg_bus_trigger_state_data {
-	u8 msg_len;
-	u8 constraint_dword_mask;
-	u8 storm_id;
-	u8 reserved;
-};
-
-/* Debug Bus memory address */
-struct dbg_bus_mem_addr {
-	u32 lo;
-	u32 hi;
-};
-
-/* Debug Bus PCI buffer data */
-struct dbg_bus_pci_buf_data {
-	struct dbg_bus_mem_addr phys_addr; /* PCI buffer physical address */
-	struct dbg_bus_mem_addr virt_addr; /* PCI buffer virtual address */
-	u32 size; /* PCI buffer size in bytes */
-};
-
-/* Debug Bus Storm EID range filter params */
-struct dbg_bus_storm_eid_range_params {
-	u8 min; /* Minimal event ID to filter on */
-	u8 max; /* Maximal event ID to filter on */
-};
-
-/* Debug Bus Storm EID mask filter params */
-struct dbg_bus_storm_eid_mask_params {
-	u8 val; /* Event ID value */
-	u8 mask; /* Event ID mask. 1s in the mask = dont care bits. */
-};
-
-/* Debug Bus Storm EID filter params */
-union dbg_bus_storm_eid_params {
-	struct dbg_bus_storm_eid_range_params range;
-	struct dbg_bus_storm_eid_mask_params mask;
-};
-
-/* Debug Bus Storm data */
-struct dbg_bus_storm_data {
-	u8 enabled;
-	u8 mode;
-	u8 hw_id;
-	u8 eid_filter_en;
-	u8 eid_range_not_mask;
-	u8 cid_filter_en;
-	union dbg_bus_storm_eid_params eid_filter_params;
-	u32 cid;
-};
-
-/* Debug Bus data */
-struct dbg_bus_data {
-	u32 app_version;
-	u8 state;
-	u8 mode_256b_en;
-	u8 num_enabled_blocks;
-	u8 num_enabled_storms;
-	u8 target;
-	u8 one_shot_en;
-	u8 grc_input_en;
-	u8 timestamp_input_en;
-	u8 filter_en;
-	u8 adding_filter;
-	u8 filter_pre_trigger;
-	u8 filter_post_trigger;
-	u8 trigger_en;
-	u8 filter_constraint_dword_mask;
-	u8 next_trigger_state;
-	u8 next_constraint_id;
-	struct dbg_bus_trigger_state_data trigger_states[3];
-	u8 filter_msg_len;
-	u8 rcv_from_other_engine;
-	u8 blocks_dword_mask;
-	u8 blocks_dword_overlap;
-	u32 hw_id_mask;
-	struct dbg_bus_pci_buf_data pci_buf;
-	struct dbg_bus_block_data blocks[132];
-	struct dbg_bus_storm_data storms[6];
-};
-
-/* Debug bus states */
-enum dbg_bus_states {
-	DBG_BUS_STATE_IDLE,
-	DBG_BUS_STATE_READY,
-	DBG_BUS_STATE_RECORDING,
-	DBG_BUS_STATE_STOPPED,
-	MAX_DBG_BUS_STATES
-};
-
-/* Debug Bus Storm modes */
-enum dbg_bus_storm_modes {
-	DBG_BUS_STORM_MODE_PRINTF,
-	DBG_BUS_STORM_MODE_PRAM_ADDR,
-	DBG_BUS_STORM_MODE_DRA_RW,
-	DBG_BUS_STORM_MODE_DRA_W,
-	DBG_BUS_STORM_MODE_LD_ST_ADDR,
-	DBG_BUS_STORM_MODE_DRA_FSM,
-	DBG_BUS_STORM_MODE_FAST_DBGMUX,
-	DBG_BUS_STORM_MODE_RH,
-	DBG_BUS_STORM_MODE_RH_WITH_STORE,
-	DBG_BUS_STORM_MODE_FOC,
-	DBG_BUS_STORM_MODE_EXT_STORE,
-	MAX_DBG_BUS_STORM_MODES
-};
-
-/* Debug bus target IDs */
-enum dbg_bus_targets {
-	DBG_BUS_TARGET_ID_INT_BUF,
-	DBG_BUS_TARGET_ID_NIG,
-	DBG_BUS_TARGET_ID_PCI,
-	MAX_DBG_BUS_TARGETS
-};
-
-/* GRC Dump data */
-struct dbg_grc_data {
-	u8 params_initialized;
-	u8 reserved1;
-	u16 reserved2;
-	u32 param_val[48];
-};
-
-/* Debug GRC params */
-enum dbg_grc_params {
-	DBG_GRC_PARAM_DUMP_TSTORM,
-	DBG_GRC_PARAM_DUMP_MSTORM,
-	DBG_GRC_PARAM_DUMP_USTORM,
-	DBG_GRC_PARAM_DUMP_XSTORM,
-	DBG_GRC_PARAM_DUMP_YSTORM,
-	DBG_GRC_PARAM_DUMP_PSTORM,
-	DBG_GRC_PARAM_DUMP_REGS,
-	DBG_GRC_PARAM_DUMP_RAM,
-	DBG_GRC_PARAM_DUMP_PBUF,
-	DBG_GRC_PARAM_DUMP_IOR,
-	DBG_GRC_PARAM_DUMP_VFC,
-	DBG_GRC_PARAM_DUMP_CM_CTX,
-	DBG_GRC_PARAM_DUMP_PXP,
-	DBG_GRC_PARAM_DUMP_RSS,
-	DBG_GRC_PARAM_DUMP_CAU,
-	DBG_GRC_PARAM_DUMP_QM,
-	DBG_GRC_PARAM_DUMP_MCP,
-	DBG_GRC_PARAM_DUMP_DORQ,
-	DBG_GRC_PARAM_DUMP_CFC,
-	DBG_GRC_PARAM_DUMP_IGU,
-	DBG_GRC_PARAM_DUMP_BRB,
-	DBG_GRC_PARAM_DUMP_BTB,
-	DBG_GRC_PARAM_DUMP_BMB,
-	DBG_GRC_PARAM_RESERVD1,
-	DBG_GRC_PARAM_DUMP_MULD,
-	DBG_GRC_PARAM_DUMP_PRS,
-	DBG_GRC_PARAM_DUMP_DMAE,
-	DBG_GRC_PARAM_DUMP_TM,
-	DBG_GRC_PARAM_DUMP_SDM,
-	DBG_GRC_PARAM_DUMP_DIF,
-	DBG_GRC_PARAM_DUMP_STATIC,
-	DBG_GRC_PARAM_UNSTALL,
-	DBG_GRC_PARAM_RESERVED2,
-	DBG_GRC_PARAM_MCP_TRACE_META_SIZE,
-	DBG_GRC_PARAM_EXCLUDE_ALL,
-	DBG_GRC_PARAM_CRASH,
-	DBG_GRC_PARAM_PARITY_SAFE,
-	DBG_GRC_PARAM_DUMP_CM,
-	DBG_GRC_PARAM_DUMP_PHY,
-	DBG_GRC_PARAM_NO_MCP,
-	DBG_GRC_PARAM_NO_FW_VER,
-	DBG_GRC_PARAM_RESERVED3,
-	DBG_GRC_PARAM_DUMP_MCP_HW_DUMP,
-	DBG_GRC_PARAM_DUMP_ILT_CDUC,
-	DBG_GRC_PARAM_DUMP_ILT_CDUT,
-	DBG_GRC_PARAM_DUMP_CAU_EXT,
-	MAX_DBG_GRC_PARAMS
-};
-
-/* Debug status codes */
-enum dbg_status {
-	DBG_STATUS_OK,
-	DBG_STATUS_APP_VERSION_NOT_SET,
-	DBG_STATUS_UNSUPPORTED_APP_VERSION,
-	DBG_STATUS_DBG_BLOCK_NOT_RESET,
-	DBG_STATUS_INVALID_ARGS,
-	DBG_STATUS_OUTPUT_ALREADY_SET,
-	DBG_STATUS_INVALID_PCI_BUF_SIZE,
-	DBG_STATUS_PCI_BUF_ALLOC_FAILED,
-	DBG_STATUS_PCI_BUF_NOT_ALLOCATED,
-	DBG_STATUS_INVALID_FILTER_TRIGGER_DWORDS,
-	DBG_STATUS_NO_MATCHING_FRAMING_MODE,
-	DBG_STATUS_VFC_READ_ERROR,
-	DBG_STATUS_STORM_ALREADY_ENABLED,
-	DBG_STATUS_STORM_NOT_ENABLED,
-	DBG_STATUS_BLOCK_ALREADY_ENABLED,
-	DBG_STATUS_BLOCK_NOT_ENABLED,
-	DBG_STATUS_NO_INPUT_ENABLED,
-	DBG_STATUS_NO_FILTER_TRIGGER_256B,
-	DBG_STATUS_FILTER_ALREADY_ENABLED,
-	DBG_STATUS_TRIGGER_ALREADY_ENABLED,
-	DBG_STATUS_TRIGGER_NOT_ENABLED,
-	DBG_STATUS_CANT_ADD_CONSTRAINT,
-	DBG_STATUS_TOO_MANY_TRIGGER_STATES,
-	DBG_STATUS_TOO_MANY_CONSTRAINTS,
-	DBG_STATUS_RECORDING_NOT_STARTED,
-	DBG_STATUS_DATA_DIDNT_TRIGGER,
-	DBG_STATUS_NO_DATA_RECORDED,
-	DBG_STATUS_DUMP_BUF_TOO_SMALL,
-	DBG_STATUS_DUMP_NOT_CHUNK_ALIGNED,
-	DBG_STATUS_UNKNOWN_CHIP,
-	DBG_STATUS_VIRT_MEM_ALLOC_FAILED,
-	DBG_STATUS_BLOCK_IN_RESET,
-	DBG_STATUS_INVALID_TRACE_SIGNATURE,
-	DBG_STATUS_INVALID_NVRAM_BUNDLE,
-	DBG_STATUS_NVRAM_GET_IMAGE_FAILED,
-	DBG_STATUS_NON_ALIGNED_NVRAM_IMAGE,
-	DBG_STATUS_NVRAM_READ_FAILED,
-	DBG_STATUS_IDLE_CHK_PARSE_FAILED,
-	DBG_STATUS_MCP_TRACE_BAD_DATA,
-	DBG_STATUS_MCP_TRACE_NO_META,
-	DBG_STATUS_MCP_COULD_NOT_HALT,
-	DBG_STATUS_MCP_COULD_NOT_RESUME,
-	DBG_STATUS_RESERVED0,
-	DBG_STATUS_SEMI_FIFO_NOT_EMPTY,
-	DBG_STATUS_IGU_FIFO_BAD_DATA,
-	DBG_STATUS_MCP_COULD_NOT_MASK_PRTY,
-	DBG_STATUS_FW_ASSERTS_PARSE_FAILED,
-	DBG_STATUS_REG_FIFO_BAD_DATA,
-	DBG_STATUS_PROTECTION_OVERRIDE_BAD_DATA,
-	DBG_STATUS_DBG_ARRAY_NOT_SET,
-	DBG_STATUS_RESERVED1,
-	DBG_STATUS_NON_MATCHING_LINES,
-	DBG_STATUS_INSUFFICIENT_HW_IDS,
-	DBG_STATUS_DBG_BUS_IN_USE,
-	DBG_STATUS_INVALID_STORM_DBG_MODE,
-	DBG_STATUS_OTHER_ENGINE_BB_ONLY,
-	DBG_STATUS_FILTER_SINGLE_HW_ID,
-	DBG_STATUS_TRIGGER_SINGLE_HW_ID,
-	DBG_STATUS_MISSING_TRIGGER_STATE_STORM,
-	MAX_DBG_STATUS
-};
-
-/* Debug Storms IDs */
-enum dbg_storms {
-	DBG_TSTORM_ID,
-	DBG_MSTORM_ID,
-	DBG_USTORM_ID,
-	DBG_XSTORM_ID,
-	DBG_YSTORM_ID,
-	DBG_PSTORM_ID,
-	MAX_DBG_STORMS
-};
-
-/* Idle Check data */
-struct idle_chk_data {
-	u32 buf_size;
-	u8 buf_size_set;
-	u8 reserved1;
-	u16 reserved2;
-};
-
-struct pretend_params {
-	u8 split_type;
-	u8 reserved;
-	u16 split_id;
-};
-
-/* Debug Tools data (per HW function)
- */
-struct dbg_tools_data {
-	struct dbg_grc_data grc;
-	struct dbg_bus_data bus;
-	struct idle_chk_data idle_chk;
-	u8 mode_enable[40];
-	u8 block_in_reset[132];
-	u8 chip_id;
-	u8 hw_type;
-	u8 num_ports;
-	u8 num_pfs_per_port;
-	u8 num_vfs;
-	u8 initialized;
-	u8 use_dmae;
-	u8 reserved;
-	struct pretend_params pretend;
-	u32 num_regs_read;
-};
-
-/* ILT Clients */
-enum ilt_clients {
-	ILT_CLI_CDUC,
-	ILT_CLI_CDUT,
-	ILT_CLI_QM,
-	ILT_CLI_TM,
-	ILT_CLI_SRC,
-	ILT_CLI_TSDM,
-	ILT_CLI_RGFS,
-	ILT_CLI_TGFS,
-	MAX_ILT_CLIENTS
-};
-
 /********************************/
 /* HSI Init Functions constants */
 /********************************/
@@ -3009,706 +2246,6 @@ struct iro {
 	u16 size;
 };
 
-/***************************** Public Functions *******************************/
-
-/**
- * @brief qed_dbg_set_bin_ptr - Sets a pointer to the binary data with debug
- *	arrays.
- *
- * @param p_hwfn -	    HW device data
- * @param bin_ptr - a pointer to the binary data with debug arrays.
- */
-enum dbg_status qed_dbg_set_bin_ptr(struct qed_hwfn *p_hwfn,
-				    const u8 * const bin_ptr);
-
-/**
- * @brief qed_read_regs - Reads registers into a buffer (using GRC).
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf - Destination buffer.
- * @param addr - Source GRC address in dwords.
- * @param len - Number of registers to read.
- */
-void qed_read_regs(struct qed_hwfn *p_hwfn,
-		   struct qed_ptt *p_ptt, u32 *buf, u32 addr, u32 len);
-
-/**
- * @brief qed_read_fw_info - Reads FW info from the chip.
- *
- * The FW info contains FW-related information, such as the FW version,
- * FW image (main/L2B/kuku), FW timestamp, etc.
- * The FW info is read from the internal RAM of the first Storm that is not in
- * reset.
- *
- * @param p_hwfn -	    HW device data
- * @param p_ptt -	    Ptt window used for writing the registers.
- * @param fw_info -	Out: a pointer to write the FW info into.
- *
- * @return true if the FW info was read successfully from one of the Storms,
- * or false if all Storms are in reset.
- */
-bool qed_read_fw_info(struct qed_hwfn *p_hwfn,
-		      struct qed_ptt *p_ptt, struct fw_info *fw_info);
-/**
- * @brief qed_dbg_grc_config - Sets the value of a GRC parameter.
- *
- * @param p_hwfn -	HW device data
- * @param grc_param -	GRC parameter
- * @param val -		Value to set.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- grc_param is invalid
- *	- val is outside the allowed boundaries
- */
-enum dbg_status qed_dbg_grc_config(struct qed_hwfn *p_hwfn,
-				   enum dbg_grc_params grc_param, u32 val);
-
-/**
- * @brief qed_dbg_grc_set_params_default - Reverts all GRC parameters to their
- *	default value.
- *
- * @param p_hwfn		- HW device data
- */
-void qed_dbg_grc_set_params_default(struct qed_hwfn *p_hwfn);
-/**
- * @brief qed_dbg_grc_get_dump_buf_size - Returns the required buffer size for
- *	GRC Dump.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for the GRC Dump
- *	data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_grc_get_dump_buf_size(struct qed_hwfn *p_hwfn,
-					      struct qed_ptt *p_ptt,
-					      u32 *buf_size);
-
-/**
- * @brief qed_dbg_grc_dump - Dumps GRC data into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the collected GRC data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified dump buffer is too small
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_grc_dump(struct qed_hwfn *p_hwfn,
-				 struct qed_ptt *p_ptt,
-				 u32 *dump_buf,
-				 u32 buf_size_in_dwords,
-				 u32 *num_dumped_dwords);
-
-/**
- * @brief qed_dbg_idle_chk_get_dump_buf_size - Returns the required buffer size
- *	for idle check results.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for the idle check
- *	data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_idle_chk_get_dump_buf_size(struct qed_hwfn *p_hwfn,
-						   struct qed_ptt *p_ptt,
-						   u32 *buf_size);
-
-/**
- * @brief qed_dbg_idle_chk_dump - Performs idle check and writes the results
- *	into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the idle check data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_idle_chk_dump(struct qed_hwfn *p_hwfn,
-				      struct qed_ptt *p_ptt,
-				      u32 *dump_buf,
-				      u32 buf_size_in_dwords,
-				      u32 *num_dumped_dwords);
-
-/**
- * @brief qed_dbg_mcp_trace_get_dump_buf_size - Returns the required buffer size
- *	for mcp trace results.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for mcp trace data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the trace data in MCP scratchpad contain an invalid signature
- *	- the bundle ID in NVRAM is invalid
- *	- the trace meta data cannot be found (in NVRAM or image file)
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_mcp_trace_get_dump_buf_size(struct qed_hwfn *p_hwfn,
-						    struct qed_ptt *p_ptt,
-						    u32 *buf_size);
-
-/**
- * @brief qed_dbg_mcp_trace_dump - Performs mcp trace and writes the results
- *	into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the mcp trace data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- the trace data in MCP scratchpad contain an invalid signature
- *	- the bundle ID in NVRAM is invalid
- *	- the trace meta data cannot be found (in NVRAM or image file)
- *	- the trace meta data cannot be read (from NVRAM or image file)
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_mcp_trace_dump(struct qed_hwfn *p_hwfn,
-				       struct qed_ptt *p_ptt,
-				       u32 *dump_buf,
-				       u32 buf_size_in_dwords,
-				       u32 *num_dumped_dwords);
-
-/**
- * @brief qed_dbg_reg_fifo_get_dump_buf_size - Returns the required buffer size
- *	for grc trace fifo results.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for reg fifo data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_reg_fifo_get_dump_buf_size(struct qed_hwfn *p_hwfn,
-						   struct qed_ptt *p_ptt,
-						   u32 *buf_size);
-
-/**
- * @brief qed_dbg_reg_fifo_dump - Reads the reg fifo and writes the results into
- *	the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the reg fifo data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- DMAE transaction failed
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_reg_fifo_dump(struct qed_hwfn *p_hwfn,
-				      struct qed_ptt *p_ptt,
-				      u32 *dump_buf,
-				      u32 buf_size_in_dwords,
-				      u32 *num_dumped_dwords);
-
-/**
- * @brief qed_dbg_igu_fifo_get_dump_buf_size - Returns the required buffer size
- *	for the IGU fifo results.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for the IGU fifo
- *	data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_igu_fifo_get_dump_buf_size(struct qed_hwfn *p_hwfn,
-						   struct qed_ptt *p_ptt,
-						   u32 *buf_size);
-
-/**
- * @brief qed_dbg_igu_fifo_dump - Reads the IGU fifo and writes the results into
- *	the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the IGU fifo data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- DMAE transaction failed
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_igu_fifo_dump(struct qed_hwfn *p_hwfn,
-				      struct qed_ptt *p_ptt,
-				      u32 *dump_buf,
-				      u32 buf_size_in_dwords,
-				      u32 *num_dumped_dwords);
-
-/**
- * @brief qed_dbg_protection_override_get_dump_buf_size - Returns the required
- *	buffer size for protection override window results.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for protection
- *	override data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status
-qed_dbg_protection_override_get_dump_buf_size(struct qed_hwfn *p_hwfn,
-					      struct qed_ptt *p_ptt,
-					      u32 *buf_size);
-/**
- * @brief qed_dbg_protection_override_dump - Reads protection override window
- *	entries and writes the results into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the protection override data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- *	- DMAE transaction failed
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_protection_override_dump(struct qed_hwfn *p_hwfn,
-						 struct qed_ptt *p_ptt,
-						 u32 *dump_buf,
-						 u32 buf_size_in_dwords,
-						 u32 *num_dumped_dwords);
-/**
- * @brief qed_dbg_fw_asserts_get_dump_buf_size - Returns the required buffer
- *	size for FW Asserts results.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param buf_size - OUT: required buffer size (in dwords) for FW Asserts data.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_fw_asserts_get_dump_buf_size(struct qed_hwfn *p_hwfn,
-						     struct qed_ptt *p_ptt,
-						     u32 *buf_size);
-/**
- * @brief qed_dbg_fw_asserts_dump - Reads the FW Asserts and writes the results
- *	into the specified buffer.
- *
- * @param p_hwfn - HW device data
- * @param p_ptt - Ptt window used for writing the registers.
- * @param dump_buf - Pointer to write the FW Asserts data into.
- * @param buf_size_in_dwords - Size of the specified buffer in dwords.
- * @param num_dumped_dwords - OUT: number of dumped dwords.
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- *	- the specified buffer is too small
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_fw_asserts_dump(struct qed_hwfn *p_hwfn,
-					struct qed_ptt *p_ptt,
-					u32 *dump_buf,
-					u32 buf_size_in_dwords,
-					u32 *num_dumped_dwords);
-
-/**
- * @brief qed_dbg_read_attn - Reads the attention registers of the specified
- * block and type, and writes the results into the specified buffer.
- *
- * @param p_hwfn -	 HW device data
- * @param p_ptt -	 Ptt window used for writing the registers.
- * @param block -	 Block ID.
- * @param attn_type -	 Attention type.
- * @param clear_status - Indicates if the attention status should be cleared.
- * @param results -	 OUT: Pointer to write the read results into
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_read_attn(struct qed_hwfn *p_hwfn,
-				  struct qed_ptt *p_ptt,
-				  enum block_id block,
-				  enum dbg_attn_type attn_type,
-				  bool clear_status,
-				  struct dbg_attn_block_result *results);
-
-/**
- * @brief qed_dbg_print_attn - Prints attention registers values in the
- *	specified results struct.
- *
- * @param p_hwfn
- * @param results - Pointer to the attention read results
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_print_attn(struct qed_hwfn *p_hwfn,
-				   struct dbg_attn_block_result *results);
-
-/******************************* Data Types **********************************/
-
-struct mcp_trace_format {
-	u32 data;
-#define MCP_TRACE_FORMAT_MODULE_MASK	0x0000ffff
-#define MCP_TRACE_FORMAT_MODULE_OFFSET	0
-#define MCP_TRACE_FORMAT_LEVEL_MASK	0x00030000
-#define MCP_TRACE_FORMAT_LEVEL_OFFSET	16
-#define MCP_TRACE_FORMAT_P1_SIZE_MASK	0x000c0000
-#define MCP_TRACE_FORMAT_P1_SIZE_OFFSET 18
-#define MCP_TRACE_FORMAT_P2_SIZE_MASK	0x00300000
-#define MCP_TRACE_FORMAT_P2_SIZE_OFFSET 20
-#define MCP_TRACE_FORMAT_P3_SIZE_MASK	0x00c00000
-#define MCP_TRACE_FORMAT_P3_SIZE_OFFSET 22
-#define MCP_TRACE_FORMAT_LEN_MASK	0xff000000
-#define MCP_TRACE_FORMAT_LEN_OFFSET	24
-
-	char *format_str;
-};
-
-/* MCP Trace Meta data structure */
-struct mcp_trace_meta {
-	u32 modules_num;
-	char **modules;
-	u32 formats_num;
-	struct mcp_trace_format *formats;
-	bool is_allocated;
-};
-
-/* Debug Tools user data */
-struct dbg_tools_user_data {
-	struct mcp_trace_meta mcp_trace_meta;
-	const u32 *mcp_trace_user_meta_buf;
-};
-
-/******************************** Constants **********************************/
-
-#define MAX_NAME_LEN	16
-
-/***************************** Public Functions *******************************/
-
-/**
- * @brief qed_dbg_user_set_bin_ptr - Sets a pointer to the binary data with
- *	debug arrays.
- *
- * @param p_hwfn - HW device data
- * @param bin_ptr - a pointer to the binary data with debug arrays.
- */
-enum dbg_status qed_dbg_user_set_bin_ptr(struct qed_hwfn *p_hwfn,
-					 const u8 * const bin_ptr);
-
-/**
- * @brief qed_dbg_alloc_user_data - Allocates user debug data.
- *
- * @param p_hwfn -		 HW device data
- * @param user_data_ptr - OUT: a pointer to the allocated memory.
- */
-enum dbg_status qed_dbg_alloc_user_data(struct qed_hwfn *p_hwfn,
-					void **user_data_ptr);
-
-/**
- * @brief qed_dbg_get_status_str - Returns a string for the specified status.
- *
- * @param status - a debug status code.
- *
- * @return a string for the specified status
- */
-const char *qed_dbg_get_status_str(enum dbg_status status);
-
-/**
- * @brief qed_get_idle_chk_results_buf_size - Returns the required buffer size
- *	for idle check results (in bytes).
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - idle check dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_get_idle_chk_results_buf_size(struct qed_hwfn *p_hwfn,
-						  u32 *dump_buf,
-						  u32  num_dumped_dwords,
-						  u32 *results_buf_size);
-/**
- * @brief qed_print_idle_chk_results - Prints idle check results
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - idle check dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the idle check results.
- * @param num_errors - OUT: number of errors found in idle check.
- * @param num_warnings - OUT: number of warnings found in idle check.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_idle_chk_results(struct qed_hwfn *p_hwfn,
-					   u32 *dump_buf,
-					   u32 num_dumped_dwords,
-					   char *results_buf,
-					   u32 *num_errors,
-					   u32 *num_warnings);
-
-/**
- * @brief qed_dbg_mcp_trace_set_meta_data - Sets the MCP Trace meta data.
- *
- * Needed in case the MCP Trace dump doesn't contain the meta data (e.g. due to
- * no NVRAM access).
- *
- * @param data - pointer to MCP Trace meta data
- * @param size - size of MCP Trace meta data in dwords
- */
-void qed_dbg_mcp_trace_set_meta_data(struct qed_hwfn *p_hwfn,
-				     const u32 *meta_buf);
-
-/**
- * @brief qed_get_mcp_trace_results_buf_size - Returns the required buffer size
- *	for MCP Trace results (in bytes).
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - MCP Trace dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_get_mcp_trace_results_buf_size(struct qed_hwfn *p_hwfn,
-						   u32 *dump_buf,
-						   u32 num_dumped_dwords,
-						   u32 *results_buf_size);
-
-/**
- * @brief qed_print_mcp_trace_results - Prints MCP Trace results
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - mcp trace dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the mcp trace results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_mcp_trace_results(struct qed_hwfn *p_hwfn,
-					    u32 *dump_buf,
-					    u32 num_dumped_dwords,
-					    char *results_buf);
-
-/**
- * @brief qed_print_mcp_trace_results_cont - Prints MCP Trace results, and
- * keeps the MCP trace meta data allocated, to support continuous MCP Trace
- * parsing. After the continuous parsing ends, mcp_trace_free_meta_data should
- * be called to free the meta data.
- *
- * @param p_hwfn -	      HW device data
- * @param dump_buf -	      mcp trace dump buffer, starting from the header.
- * @param results_buf -	      buffer for printing the mcp trace results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_mcp_trace_results_cont(struct qed_hwfn *p_hwfn,
-						 u32 *dump_buf,
-						 char *results_buf);
-
-/**
- * @brief print_mcp_trace_line - Prints MCP Trace results for a single line
- *
- * @param p_hwfn -	      HW device data
- * @param dump_buf -	      mcp trace dump buffer, starting from the header.
- * @param num_dumped_bytes -  number of bytes that were dumped.
- * @param results_buf -	      buffer for printing the mcp trace results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_mcp_trace_line(struct qed_hwfn *p_hwfn,
-					 u8 *dump_buf,
-					 u32 num_dumped_bytes,
-					 char *results_buf);
-
-/**
- * @brief mcp_trace_free_meta_data - Frees the MCP Trace meta data.
- * Should be called after continuous MCP Trace parsing.
- *
- * @param p_hwfn - HW device data
- */
-void qed_mcp_trace_free_meta_data(struct qed_hwfn *p_hwfn);
-
-/**
- * @brief qed_get_reg_fifo_results_buf_size - Returns the required buffer size
- *	for reg_fifo results (in bytes).
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - reg fifo dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_get_reg_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
-						  u32 *dump_buf,
-						  u32 num_dumped_dwords,
-						  u32 *results_buf_size);
-
-/**
- * @brief qed_print_reg_fifo_results - Prints reg fifo results
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - reg fifo dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the reg fifo results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_reg_fifo_results(struct qed_hwfn *p_hwfn,
-					   u32 *dump_buf,
-					   u32 num_dumped_dwords,
-					   char *results_buf);
-
-/**
- * @brief qed_get_igu_fifo_results_buf_size - Returns the required buffer size
- *	for igu_fifo results (in bytes).
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - IGU fifo dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_get_igu_fifo_results_buf_size(struct qed_hwfn *p_hwfn,
-						  u32 *dump_buf,
-						  u32 num_dumped_dwords,
-						  u32 *results_buf_size);
-
-/**
- * @brief qed_print_igu_fifo_results - Prints IGU fifo results
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - IGU fifo dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the IGU fifo results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_igu_fifo_results(struct qed_hwfn *p_hwfn,
-					   u32 *dump_buf,
-					   u32 num_dumped_dwords,
-					   char *results_buf);
-
-/**
- * @brief qed_get_protection_override_results_buf_size - Returns the required
- *	buffer size for protection override results (in bytes).
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - protection override dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status
-qed_get_protection_override_results_buf_size(struct qed_hwfn *p_hwfn,
-					     u32 *dump_buf,
-					     u32 num_dumped_dwords,
-					     u32 *results_buf_size);
-
-/**
- * @brief qed_print_protection_override_results - Prints protection override
- *	results.
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - protection override dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the reg fifo results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_protection_override_results(struct qed_hwfn *p_hwfn,
-						      u32 *dump_buf,
-						      u32 num_dumped_dwords,
-						      char *results_buf);
-
-/**
- * @brief qed_get_fw_asserts_results_buf_size - Returns the required buffer size
- *	for FW Asserts results (in bytes).
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - FW Asserts dump buffer.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf_size - OUT: required buffer size (in bytes) for the parsed
- *	results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_get_fw_asserts_results_buf_size(struct qed_hwfn *p_hwfn,
-						    u32 *dump_buf,
-						    u32 num_dumped_dwords,
-						    u32 *results_buf_size);
-
-/**
- * @brief qed_print_fw_asserts_results - Prints FW Asserts results
- *
- * @param p_hwfn - HW device data
- * @param dump_buf - FW Asserts dump buffer, starting from the header.
- * @param num_dumped_dwords - number of dwords that were dumped.
- * @param results_buf - buffer for printing the FW Asserts results.
- *
- * @return error if the parsing fails, ok otherwise.
- */
-enum dbg_status qed_print_fw_asserts_results(struct qed_hwfn *p_hwfn,
-					     u32 *dump_buf,
-					     u32 num_dumped_dwords,
-					     char *results_buf);
-
-/**
- * @brief qed_dbg_parse_attn - Parses and prints attention registers values in
- * the specified results struct.
- *
- * @param p_hwfn -  HW device data
- * @param results - Pointer to the attention read results
- *
- * @return error if one of the following holds:
- *	- the version wasn't set
- * Otherwise, returns ok.
- */
-enum dbg_status qed_dbg_parse_attn(struct qed_hwfn *p_hwfn,
-				   struct dbg_attn_block_result *results);
-
 /* Win 2 */
 #define GTT_BAR0_MAP_REG_IGU_CMD	0x00f000UL
 
@@ -4064,334 +2601,6 @@ void qed_fw_overlay_init_ram(struct qed_hwfn *p_hwfn,
 void qed_fw_overlay_mem_free(struct qed_hwfn *p_hwfn,
 			     struct phys_mem_desc *fw_overlay_mem);
 
-/* Ystorm flow control mode. Use enum fw_flow_ctrl_mode */
-#define YSTORM_FLOW_CONTROL_MODE_OFFSET			(IRO[0].base)
-#define YSTORM_FLOW_CONTROL_MODE_SIZE			(IRO[0].size)
-
-/* Tstorm port statistics */
-#define TSTORM_PORT_STAT_OFFSET(port_id) \
-	(IRO[1].base + ((port_id) * IRO[1].m1))
-#define TSTORM_PORT_STAT_SIZE				(IRO[1].size)
-
-/* Tstorm ll2 port statistics */
-#define TSTORM_LL2_PORT_STAT_OFFSET(port_id) \
-	(IRO[2].base + ((port_id) * IRO[2].m1))
-#define TSTORM_LL2_PORT_STAT_SIZE			(IRO[2].size)
-
-/* Ustorm VF-PF Channel ready flag */
-#define USTORM_VF_PF_CHANNEL_READY_OFFSET(vf_id) \
-	(IRO[3].base + ((vf_id) * IRO[3].m1))
-#define USTORM_VF_PF_CHANNEL_READY_SIZE			(IRO[3].size)
-
-/* Ustorm Final flr cleanup ack */
-#define USTORM_FLR_FINAL_ACK_OFFSET(pf_id) \
-	(IRO[4].base + ((pf_id) * IRO[4].m1))
-#define USTORM_FLR_FINAL_ACK_SIZE			(IRO[4].size)
-
-/* Ustorm Event ring consumer */
-#define USTORM_EQE_CONS_OFFSET(pf_id) \
-	(IRO[5].base + ((pf_id) * IRO[5].m1))
-#define USTORM_EQE_CONS_SIZE				(IRO[5].size)
-
-/* Ustorm eth queue zone */
-#define USTORM_ETH_QUEUE_ZONE_OFFSET(queue_zone_id) \
-	(IRO[6].base + ((queue_zone_id) * IRO[6].m1))
-#define USTORM_ETH_QUEUE_ZONE_SIZE			(IRO[6].size)
-
-/* Ustorm Common Queue ring consumer */
-#define USTORM_COMMON_QUEUE_CONS_OFFSET(queue_zone_id) \
-	(IRO[7].base + ((queue_zone_id) * IRO[7].m1))
-#define USTORM_COMMON_QUEUE_CONS_SIZE			(IRO[7].size)
-
-/* Xstorm common PQ info */
-#define XSTORM_PQ_INFO_OFFSET(pq_id) \
-	(IRO[8].base + ((pq_id) * IRO[8].m1))
-#define XSTORM_PQ_INFO_SIZE				(IRO[8].size)
-
-/* Xstorm Integration Test Data */
-#define XSTORM_INTEG_TEST_DATA_OFFSET			(IRO[9].base)
-#define XSTORM_INTEG_TEST_DATA_SIZE			(IRO[9].size)
-
-/* Ystorm Integration Test Data */
-#define YSTORM_INTEG_TEST_DATA_OFFSET			(IRO[10].base)
-#define YSTORM_INTEG_TEST_DATA_SIZE			(IRO[10].size)
-
-/* Pstorm Integration Test Data */
-#define PSTORM_INTEG_TEST_DATA_OFFSET			(IRO[11].base)
-#define PSTORM_INTEG_TEST_DATA_SIZE			(IRO[11].size)
-
-/* Tstorm Integration Test Data */
-#define TSTORM_INTEG_TEST_DATA_OFFSET			(IRO[12].base)
-#define TSTORM_INTEG_TEST_DATA_SIZE			(IRO[12].size)
-
-/* Mstorm Integration Test Data */
-#define MSTORM_INTEG_TEST_DATA_OFFSET			(IRO[13].base)
-#define MSTORM_INTEG_TEST_DATA_SIZE			(IRO[13].size)
-
-/* Ustorm Integration Test Data */
-#define USTORM_INTEG_TEST_DATA_OFFSET			(IRO[14].base)
-#define USTORM_INTEG_TEST_DATA_SIZE			(IRO[14].size)
-
-/* Xstorm overlay buffer host address */
-#define XSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[15].base)
-#define XSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[15].size)
-
-/* Ystorm overlay buffer host address */
-#define YSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[16].base)
-#define YSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[16].size)
-
-/* Pstorm overlay buffer host address */
-#define PSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[17].base)
-#define PSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[17].size)
-
-/* Tstorm overlay buffer host address */
-#define TSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[18].base)
-#define TSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[18].size)
-
-/* Mstorm overlay buffer host address */
-#define MSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[19].base)
-#define MSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[19].size)
-
-/* Ustorm overlay buffer host address */
-#define USTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[20].base)
-#define USTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[20].size)
-
-/* Tstorm producers */
-#define TSTORM_LL2_RX_PRODS_OFFSET(core_rx_queue_id) \
-	(IRO[21].base + ((core_rx_queue_id) * IRO[21].m1))
-#define TSTORM_LL2_RX_PRODS_SIZE			(IRO[21].size)
-
-/* Tstorm LightL2 queue statistics */
-#define CORE_LL2_TSTORM_PER_QUEUE_STAT_OFFSET(core_rx_queue_id) \
-	(IRO[22].base + ((core_rx_queue_id) * IRO[22].m1))
-#define CORE_LL2_TSTORM_PER_QUEUE_STAT_SIZE		(IRO[22].size)
-
-/* Ustorm LiteL2 queue statistics */
-#define CORE_LL2_USTORM_PER_QUEUE_STAT_OFFSET(core_rx_queue_id) \
-	(IRO[23].base + ((core_rx_queue_id) * IRO[23].m1))
-#define CORE_LL2_USTORM_PER_QUEUE_STAT_SIZE		(IRO[23].size)
-
-/* Pstorm LiteL2 queue statistics */
-#define CORE_LL2_PSTORM_PER_QUEUE_STAT_OFFSET(core_tx_stats_id) \
-	(IRO[24].base + ((core_tx_stats_id) * IRO[24].m1))
-#define CORE_LL2_PSTORM_PER_QUEUE_STAT_SIZE		(IRO[24].size)
-
-/* Mstorm queue statistics */
-#define MSTORM_QUEUE_STAT_OFFSET(stat_counter_id) \
-	(IRO[25].base + ((stat_counter_id) * IRO[25].m1))
-#define MSTORM_QUEUE_STAT_SIZE				(IRO[25].size)
-
-/* TPA agregation timeout in us resolution (on ASIC) */
-#define MSTORM_TPA_TIMEOUT_US_OFFSET			(IRO[26].base)
-#define MSTORM_TPA_TIMEOUT_US_SIZE			(IRO[26].size)
-
-/* Mstorm ETH VF queues producers offset in RAM. Used in default VF zone size
- * mode
- */
-#define MSTORM_ETH_VF_PRODS_OFFSET(vf_id, vf_queue_id) \
-	(IRO[27].base + ((vf_id) * IRO[27].m1) + ((vf_queue_id) * IRO[27].m2))
-#define MSTORM_ETH_VF_PRODS_SIZE			(IRO[27].size)
-
-/* Mstorm ETH PF queues producers */
-#define MSTORM_ETH_PF_PRODS_OFFSET(queue_id) \
-	(IRO[28].base + ((queue_id) * IRO[28].m1))
-#define MSTORM_ETH_PF_PRODS_SIZE			(IRO[28].size)
-
-/* Mstorm pf statistics */
-#define MSTORM_ETH_PF_STAT_OFFSET(pf_id) \
-	(IRO[29].base + ((pf_id) * IRO[29].m1))
-#define MSTORM_ETH_PF_STAT_SIZE				(IRO[29].size)
-
-/* Ustorm queue statistics */
-#define USTORM_QUEUE_STAT_OFFSET(stat_counter_id) \
-	(IRO[30].base + ((stat_counter_id) * IRO[30].m1))
-#define USTORM_QUEUE_STAT_SIZE				(IRO[30].size)
-
-/* Ustorm pf statistics */
-#define USTORM_ETH_PF_STAT_OFFSET(pf_id) \
-	(IRO[31].base + ((pf_id) * IRO[31].m1))
-#define USTORM_ETH_PF_STAT_SIZE				(IRO[31].size)
-
-/* Pstorm queue statistics */
-#define PSTORM_QUEUE_STAT_OFFSET(stat_counter_id)	\
-	(IRO[32].base + ((stat_counter_id) * IRO[32].m1))
-#define PSTORM_QUEUE_STAT_SIZE				(IRO[32].size)
-
-/* Pstorm pf statistics */
-#define PSTORM_ETH_PF_STAT_OFFSET(pf_id) \
-	(IRO[33].base + ((pf_id) * IRO[33].m1))
-#define PSTORM_ETH_PF_STAT_SIZE				(IRO[33].size)
-
-/* Control frame's EthType configuration for TX control frame security */
-#define PSTORM_CTL_FRAME_ETHTYPE_OFFSET(eth_type_id)	\
-	(IRO[34].base + ((eth_type_id) * IRO[34].m1))
-#define PSTORM_CTL_FRAME_ETHTYPE_SIZE			(IRO[34].size)
-
-/* Tstorm last parser message */
-#define TSTORM_ETH_PRS_INPUT_OFFSET			(IRO[35].base)
-#define TSTORM_ETH_PRS_INPUT_SIZE			(IRO[35].size)
-
-/* Tstorm Eth limit Rx rate */
-#define ETH_RX_RATE_LIMIT_OFFSET(pf_id)	\
-	(IRO[36].base + ((pf_id) * IRO[36].m1))
-#define ETH_RX_RATE_LIMIT_SIZE				(IRO[36].size)
-
-/* RSS indirection table entry update command per PF offset in TSTORM PF BAR0.
- * Use eth_tstorm_rss_update_data for update
- */
-#define TSTORM_ETH_RSS_UPDATE_OFFSET(pf_id) \
-	(IRO[37].base + ((pf_id) * IRO[37].m1))
-#define TSTORM_ETH_RSS_UPDATE_SIZE			(IRO[37].size)
-
-/* Xstorm queue zone */
-#define XSTORM_ETH_QUEUE_ZONE_OFFSET(queue_id) \
-	(IRO[38].base + ((queue_id) * IRO[38].m1))
-#define XSTORM_ETH_QUEUE_ZONE_SIZE			(IRO[38].size)
-
-/* Ystorm cqe producer */
-#define YSTORM_TOE_CQ_PROD_OFFSET(rss_id) \
-	(IRO[39].base + ((rss_id) * IRO[39].m1))
-#define YSTORM_TOE_CQ_PROD_SIZE				(IRO[39].size)
-
-/* Ustorm cqe producer */
-#define USTORM_TOE_CQ_PROD_OFFSET(rss_id) \
-	(IRO[40].base + ((rss_id) * IRO[40].m1))
-#define USTORM_TOE_CQ_PROD_SIZE				(IRO[40].size)
-
-/* Ustorm grq producer */
-#define USTORM_TOE_GRQ_PROD_OFFSET(pf_id) \
-	(IRO[41].base + ((pf_id) * IRO[41].m1))
-#define USTORM_TOE_GRQ_PROD_SIZE			(IRO[41].size)
-
-/* Tstorm cmdq-cons of given command queue-id */
-#define TSTORM_SCSI_CMDQ_CONS_OFFSET(cmdq_queue_id) \
-	(IRO[42].base + ((cmdq_queue_id) * IRO[42].m1))
-#define TSTORM_SCSI_CMDQ_CONS_SIZE			(IRO[42].size)
-
-/* Tstorm (reflects M-Storm) bdq-external-producer of given function ID,
- * BDqueue-id
- */
-#define TSTORM_SCSI_BDQ_EXT_PROD_OFFSET(storage_func_id, bdq_id) \
-	(IRO[43].base + ((storage_func_id) * IRO[43].m1) + \
-	 ((bdq_id) * IRO[43].m2))
-#define TSTORM_SCSI_BDQ_EXT_PROD_SIZE			(IRO[43].size)
-
-/* Mstorm bdq-external-producer of given BDQ resource ID, BDqueue-id */
-#define MSTORM_SCSI_BDQ_EXT_PROD_OFFSET(storage_func_id, bdq_id) \
-	(IRO[44].base + ((storage_func_id) * IRO[44].m1) + \
-	 ((bdq_id) * IRO[44].m2))
-#define MSTORM_SCSI_BDQ_EXT_PROD_SIZE			(IRO[44].size)
-
-/* Tstorm iSCSI RX stats */
-#define TSTORM_ISCSI_RX_STATS_OFFSET(storage_func_id) \
-	(IRO[45].base + ((storage_func_id) * IRO[45].m1))
-#define TSTORM_ISCSI_RX_STATS_SIZE			(IRO[45].size)
-
-/* Mstorm iSCSI RX stats */
-#define MSTORM_ISCSI_RX_STATS_OFFSET(storage_func_id) \
-	(IRO[46].base + ((storage_func_id) * IRO[46].m1))
-#define MSTORM_ISCSI_RX_STATS_SIZE			(IRO[46].size)
-
-/* Ustorm iSCSI RX stats */
-#define USTORM_ISCSI_RX_STATS_OFFSET(storage_func_id) \
-	(IRO[47].base + ((storage_func_id) * IRO[47].m1))
-#define USTORM_ISCSI_RX_STATS_SIZE			(IRO[47].size)
-
-/* Xstorm iSCSI TX stats */
-#define XSTORM_ISCSI_TX_STATS_OFFSET(storage_func_id) \
-	(IRO[48].base + ((storage_func_id) * IRO[48].m1))
-#define XSTORM_ISCSI_TX_STATS_SIZE			(IRO[48].size)
-
-/* Ystorm iSCSI TX stats */
-#define YSTORM_ISCSI_TX_STATS_OFFSET(storage_func_id) \
-	(IRO[49].base + ((storage_func_id) * IRO[49].m1))
-#define YSTORM_ISCSI_TX_STATS_SIZE			(IRO[49].size)
-
-/* Pstorm iSCSI TX stats */
-#define PSTORM_ISCSI_TX_STATS_OFFSET(storage_func_id) \
-	(IRO[50].base + ((storage_func_id) * IRO[50].m1))
-#define PSTORM_ISCSI_TX_STATS_SIZE			(IRO[50].size)
-
-/* Tstorm FCoE RX stats */
-#define TSTORM_FCOE_RX_STATS_OFFSET(pf_id) \
-	(IRO[51].base + ((pf_id) * IRO[51].m1))
-#define TSTORM_FCOE_RX_STATS_SIZE			(IRO[51].size)
-
-/* Pstorm FCoE TX stats */
-#define PSTORM_FCOE_TX_STATS_OFFSET(pf_id) \
-	(IRO[52].base + ((pf_id) * IRO[52].m1))
-#define PSTORM_FCOE_TX_STATS_SIZE			(IRO[52].size)
-
-/* Pstorm RDMA queue statistics */
-#define PSTORM_RDMA_QUEUE_STAT_OFFSET(rdma_stat_counter_id) \
-	(IRO[53].base + ((rdma_stat_counter_id) * IRO[53].m1))
-#define PSTORM_RDMA_QUEUE_STAT_SIZE			(IRO[53].size)
-
-/* Tstorm RDMA queue statistics */
-#define TSTORM_RDMA_QUEUE_STAT_OFFSET(rdma_stat_counter_id) \
-	(IRO[54].base + ((rdma_stat_counter_id) * IRO[54].m1))
-#define TSTORM_RDMA_QUEUE_STAT_SIZE			(IRO[54].size)
-
-/* Xstorm error level for assert */
-#define XSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
-	(IRO[55].base + ((pf_id) * IRO[55].m1))
-#define XSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[55].size)
-
-/* Ystorm error level for assert */
-#define YSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
-	(IRO[56].base + ((pf_id) * IRO[56].m1))
-#define YSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[56].size)
-
-/* Pstorm error level for assert */
-#define PSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
-	(IRO[57].base + ((pf_id) * IRO[57].m1))
-#define PSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[57].size)
-
-/* Tstorm error level for assert */
-#define TSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
-	(IRO[58].base + ((pf_id) * IRO[58].m1))
-#define TSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[58].size)
-
-/* Mstorm error level for assert */
-#define MSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
-	(IRO[59].base + ((pf_id) * IRO[59].m1))
-#define MSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[59].size)
-
-/* Ustorm error level for assert */
-#define USTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
-	(IRO[60].base + ((pf_id) * IRO[60].m1))
-#define USTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[60].size)
-
-/* Xstorm iWARP rxmit stats */
-#define XSTORM_IWARP_RXMIT_STATS_OFFSET(pf_id) \
-	(IRO[61].base + ((pf_id) * IRO[61].m1))
-#define XSTORM_IWARP_RXMIT_STATS_SIZE			(IRO[61].size)
-
-/* Tstorm RoCE Event Statistics */
-#define TSTORM_ROCE_EVENTS_STAT_OFFSET(roce_pf_id)	\
-	(IRO[62].base + ((roce_pf_id) * IRO[62].m1))
-#define TSTORM_ROCE_EVENTS_STAT_SIZE			(IRO[62].size)
-
-/* DCQCN Received Statistics */
-#define YSTORM_ROCE_DCQCN_RECEIVED_STATS_OFFSET(roce_pf_id)\
-	(IRO[63].base + ((roce_pf_id) * IRO[63].m1))
-#define YSTORM_ROCE_DCQCN_RECEIVED_STATS_SIZE		(IRO[63].size)
-
-/* RoCE Error Statistics */
-#define YSTORM_ROCE_ERROR_STATS_OFFSET(roce_pf_id)	\
-	(IRO[64].base + ((roce_pf_id) * IRO[64].m1))
-#define YSTORM_ROCE_ERROR_STATS_SIZE			(IRO[64].size)
-
-/* DCQCN Sent Statistics */
-#define PSTORM_ROCE_DCQCN_SENT_STATS_OFFSET(roce_pf_id)	\
-	(IRO[65].base + ((roce_pf_id) * IRO[65].m1))
-#define PSTORM_ROCE_DCQCN_SENT_STATS_SIZE		(IRO[65].size)
-
-/* RoCE CQEs Statistics */
-#define USTORM_ROCE_CQE_STATS_OFFSET(roce_pf_id)	\
-	(IRO[66].base + ((roce_pf_id) * IRO[66].m1))
-#define USTORM_ROCE_CQE_STATS_SIZE			(IRO[66].size)
-
 /* Runtime array offsets */
 #define DORQ_REG_PF_MAX_ICID_0_RT_OFFSET				0
 #define DORQ_REG_PF_MAX_ICID_1_RT_OFFSET				1
@@ -11477,1922 +9686,4 @@ struct ystorm_iscsi_conn_ag_ctx {
 	__le32 reg3;
 };
 
-#define MFW_TRACE_SIGNATURE     0x25071946
-
-/* The trace in the buffer */
-#define MFW_TRACE_EVENTID_MASK          0x00ffff
-#define MFW_TRACE_PRM_SIZE_MASK         0x0f0000
-#define MFW_TRACE_PRM_SIZE_OFFSET	16
-#define MFW_TRACE_ENTRY_SIZE            3
-
-struct mcp_trace {
-	u32 signature;		/* Help to identify that the trace is valid */
-	u32 size;		/* the size of the trace buffer in bytes */
-	u32 curr_level;		/* 2 - all will be written to the buffer
-				 * 1 - debug trace will not be written
-				 * 0 - just errors will be written to the buffer
-				 */
-	u32 modules_mask[2];	/* a bit per module, 1 means write it, 0 means
-				 * mask it.
-				 */
-
-	/* Warning: the following pointers are assumed to be 32bits as they are
-	 * used only in the MFW.
-	 */
-	u32 trace_prod; /* The next trace will be written to this offset */
-	u32 trace_oldest; /* The oldest valid trace starts at this offset
-			   * (usually very close after the current producer).
-			   */
-};
-
-#define VF_MAX_STATIC 192
-
-#define MCP_GLOB_PATH_MAX	2
-#define MCP_PORT_MAX		2
-#define MCP_GLOB_PORT_MAX	4
-#define MCP_GLOB_FUNC_MAX	16
-
-typedef u32 offsize_t;		/* In DWORDS !!! */
-/* Offset from the beginning of the MCP scratchpad */
-#define OFFSIZE_OFFSET_SHIFT	0
-#define OFFSIZE_OFFSET_MASK	0x0000ffff
-/* Size of specific element (not the whole array if any) */
-#define OFFSIZE_SIZE_SHIFT	16
-#define OFFSIZE_SIZE_MASK	0xffff0000
-
-#define SECTION_OFFSET(_offsize) ((((_offsize &			\
-				     OFFSIZE_OFFSET_MASK) >>	\
-				    OFFSIZE_OFFSET_SHIFT) << 2))
-
-#define QED_SECTION_SIZE(_offsize) (((_offsize &		\
-				      OFFSIZE_SIZE_MASK) >>	\
-				     OFFSIZE_SIZE_SHIFT) << 2)
-
-#define SECTION_ADDR(_offsize, idx) (MCP_REG_SCRATCH +			\
-				     SECTION_OFFSET(_offsize) +		\
-				     (QED_SECTION_SIZE(_offsize) * idx))
-
-#define SECTION_OFFSIZE_ADDR(_pub_base, _section)	\
-	(_pub_base + offsetof(struct mcp_public_data, sections[_section]))
-
-/* PHY configuration */
-struct eth_phy_cfg {
-	u32					speed;
-#define ETH_SPEED_AUTONEG			0x0
-#define ETH_SPEED_SMARTLINQ			0x8
-
-	u32					pause;
-#define ETH_PAUSE_NONE				0x0
-#define ETH_PAUSE_AUTONEG			0x1
-#define ETH_PAUSE_RX				0x2
-#define ETH_PAUSE_TX				0x4
-
-	u32					adv_speed;
-
-	u32					loopback_mode;
-#define ETH_LOOPBACK_NONE			0x0
-#define ETH_LOOPBACK_INT_PHY			0x1
-#define ETH_LOOPBACK_EXT_PHY			0x2
-#define ETH_LOOPBACK_EXT			0x3
-#define ETH_LOOPBACK_MAC			0x4
-#define ETH_LOOPBACK_CNIG_AH_ONLY_0123		0x5
-#define ETH_LOOPBACK_CNIG_AH_ONLY_2301		0x6
-#define ETH_LOOPBACK_PCS_AH_ONLY		0x7
-#define ETH_LOOPBACK_REVERSE_MAC_AH_ONLY	0x8
-#define ETH_LOOPBACK_INT_PHY_FEA_AH_ONLY	0x9
-
-	u32					eee_cfg;
-#define EEE_CFG_EEE_ENABLED			BIT(0)
-#define EEE_CFG_TX_LPI				BIT(1)
-#define EEE_CFG_ADV_SPEED_1G			BIT(2)
-#define EEE_CFG_ADV_SPEED_10G			BIT(3)
-#define EEE_TX_TIMER_USEC_MASK			0xfffffff0
-#define EEE_TX_TIMER_USEC_OFFSET		4
-#define EEE_TX_TIMER_USEC_BALANCED_TIME		0xa00
-#define EEE_TX_TIMER_USEC_AGGRESSIVE_TIME	0x100
-#define EEE_TX_TIMER_USEC_LATENCY_TIME		0x6000
-
-	u32					deprecated;
-
-	u32					fec_mode;
-#define FEC_FORCE_MODE_MASK			0x000000ff
-#define FEC_FORCE_MODE_OFFSET			0
-#define FEC_FORCE_MODE_NONE			0x00
-#define FEC_FORCE_MODE_FIRECODE			0x01
-#define FEC_FORCE_MODE_RS			0x02
-#define FEC_FORCE_MODE_AUTO			0x07
-#define FEC_EXTENDED_MODE_MASK			0xffffff00
-#define FEC_EXTENDED_MODE_OFFSET		8
-#define ETH_EXT_FEC_NONE			0x00000100
-#define ETH_EXT_FEC_10G_NONE			0x00000200
-#define ETH_EXT_FEC_10G_BASE_R			0x00000400
-#define ETH_EXT_FEC_20G_NONE			0x00000800
-#define ETH_EXT_FEC_20G_BASE_R			0x00001000
-#define ETH_EXT_FEC_25G_NONE			0x00002000
-#define ETH_EXT_FEC_25G_BASE_R			0x00004000
-#define ETH_EXT_FEC_25G_RS528			0x00008000
-#define ETH_EXT_FEC_40G_NONE			0x00010000
-#define ETH_EXT_FEC_40G_BASE_R			0x00020000
-#define ETH_EXT_FEC_50G_NONE			0x00040000
-#define ETH_EXT_FEC_50G_BASE_R			0x00080000
-#define ETH_EXT_FEC_50G_RS528			0x00100000
-#define ETH_EXT_FEC_50G_RS544			0x00200000
-#define ETH_EXT_FEC_100G_NONE			0x00400000
-#define ETH_EXT_FEC_100G_BASE_R			0x00800000
-#define ETH_EXT_FEC_100G_RS528			0x01000000
-#define ETH_EXT_FEC_100G_RS544			0x02000000
-
-	u32					extended_speed;
-#define ETH_EXT_SPEED_MASK			0x0000ffff
-#define ETH_EXT_SPEED_OFFSET			0
-#define ETH_EXT_SPEED_AN			0x00000001
-#define ETH_EXT_SPEED_1G			0x00000002
-#define ETH_EXT_SPEED_10G			0x00000004
-#define ETH_EXT_SPEED_20G			0x00000008
-#define ETH_EXT_SPEED_25G			0x00000010
-#define ETH_EXT_SPEED_40G			0x00000020
-#define ETH_EXT_SPEED_50G_BASE_R		0x00000040
-#define ETH_EXT_SPEED_50G_BASE_R2		0x00000080
-#define ETH_EXT_SPEED_100G_BASE_R2		0x00000100
-#define ETH_EXT_SPEED_100G_BASE_R4		0x00000200
-#define ETH_EXT_SPEED_100G_BASE_P4		0x00000400
-#define ETH_EXT_ADV_SPEED_MASK			0xffff0000
-#define ETH_EXT_ADV_SPEED_OFFSET		16
-#define ETH_EXT_ADV_SPEED_RESERVED		0x00010000
-#define ETH_EXT_ADV_SPEED_1G			0x00020000
-#define ETH_EXT_ADV_SPEED_10G			0x00040000
-#define ETH_EXT_ADV_SPEED_20G			0x00080000
-#define ETH_EXT_ADV_SPEED_25G			0x00100000
-#define ETH_EXT_ADV_SPEED_40G			0x00200000
-#define ETH_EXT_ADV_SPEED_50G_BASE_R		0x00400000
-#define ETH_EXT_ADV_SPEED_50G_BASE_R2		0x00800000
-#define ETH_EXT_ADV_SPEED_100G_BASE_R2		0x01000000
-#define ETH_EXT_ADV_SPEED_100G_BASE_R4		0x02000000
-#define ETH_EXT_ADV_SPEED_100G_BASE_P4		0x04000000
-};
-
-struct port_mf_cfg {
-	u32 dynamic_cfg;
-#define PORT_MF_CFG_OV_TAG_MASK		0x0000ffff
-#define PORT_MF_CFG_OV_TAG_SHIFT	0
-#define PORT_MF_CFG_OV_TAG_DEFAULT	PORT_MF_CFG_OV_TAG_MASK
-
-	u32 reserved[1];
-};
-
-struct eth_stats {
-	u64 r64;
-	u64 r127;
-	u64 r255;
-	u64 r511;
-	u64 r1023;
-	u64 r1518;
-
-	union {
-		struct {
-			u64 r1522;
-			u64 r2047;
-			u64 r4095;
-			u64 r9216;
-			u64 r16383;
-		} bb0;
-		struct {
-			u64 unused1;
-			u64 r1519_to_max;
-			u64 unused2;
-			u64 unused3;
-			u64 unused4;
-		} ah0;
-	} u0;
-
-	u64 rfcs;
-	u64 rxcf;
-	u64 rxpf;
-	u64 rxpp;
-	u64 raln;
-	u64 rfcr;
-	u64 rovr;
-	u64 rjbr;
-	u64 rund;
-	u64 rfrg;
-	u64 t64;
-	u64 t127;
-	u64 t255;
-	u64 t511;
-	u64 t1023;
-	u64 t1518;
-
-	union {
-		struct {
-			u64 t2047;
-			u64 t4095;
-			u64 t9216;
-			u64 t16383;
-		} bb1;
-		struct {
-			u64 t1519_to_max;
-			u64 unused6;
-			u64 unused7;
-			u64 unused8;
-		} ah1;
-	} u1;
-
-	u64 txpf;
-	u64 txpp;
-
-	union {
-		struct {
-			u64 tlpiec;
-			u64 tncl;
-		} bb2;
-		struct {
-			u64 unused9;
-			u64 unused10;
-		} ah2;
-	} u2;
-
-	u64 rbyte;
-	u64 rxuca;
-	u64 rxmca;
-	u64 rxbca;
-	u64 rxpok;
-	u64 tbyte;
-	u64 txuca;
-	u64 txmca;
-	u64 txbca;
-	u64 txcf;
-};
-
-struct brb_stats {
-	u64 brb_truncate[8];
-	u64 brb_discard[8];
-};
-
-struct port_stats {
-	struct brb_stats brb;
-	struct eth_stats eth;
-};
-
-struct couple_mode_teaming {
-	u8 port_cmt[MCP_GLOB_PORT_MAX];
-#define PORT_CMT_IN_TEAM	(1 << 0)
-
-#define PORT_CMT_PORT_ROLE	(1 << 1)
-#define PORT_CMT_PORT_INACTIVE	(0 << 1)
-#define PORT_CMT_PORT_ACTIVE	(1 << 1)
-
-#define PORT_CMT_TEAM_MASK	(1 << 2)
-#define PORT_CMT_TEAM0		(0 << 2)
-#define PORT_CMT_TEAM1		(1 << 2)
-};
-
-#define LLDP_CHASSIS_ID_STAT_LEN	4
-#define LLDP_PORT_ID_STAT_LEN		4
-#define DCBX_MAX_APP_PROTOCOL		32
-#define MAX_SYSTEM_LLDP_TLV_DATA	32
-
-enum _lldp_agent {
-	LLDP_NEAREST_BRIDGE = 0,
-	LLDP_NEAREST_NON_TPMR_BRIDGE,
-	LLDP_NEAREST_CUSTOMER_BRIDGE,
-	LLDP_MAX_LLDP_AGENTS
-};
-
-struct lldp_config_params_s {
-	u32 config;
-#define LLDP_CONFIG_TX_INTERVAL_MASK	0x000000ff
-#define LLDP_CONFIG_TX_INTERVAL_SHIFT	0
-#define LLDP_CONFIG_HOLD_MASK		0x00000f00
-#define LLDP_CONFIG_HOLD_SHIFT		8
-#define LLDP_CONFIG_MAX_CREDIT_MASK	0x0000f000
-#define LLDP_CONFIG_MAX_CREDIT_SHIFT	12
-#define LLDP_CONFIG_ENABLE_RX_MASK	0x40000000
-#define LLDP_CONFIG_ENABLE_RX_SHIFT	30
-#define LLDP_CONFIG_ENABLE_TX_MASK	0x80000000
-#define LLDP_CONFIG_ENABLE_TX_SHIFT	31
-	u32 local_chassis_id[LLDP_CHASSIS_ID_STAT_LEN];
-	u32 local_port_id[LLDP_PORT_ID_STAT_LEN];
-};
-
-struct lldp_status_params_s {
-	u32 prefix_seq_num;
-	u32 status;
-	u32 peer_chassis_id[LLDP_CHASSIS_ID_STAT_LEN];
-	u32 peer_port_id[LLDP_PORT_ID_STAT_LEN];
-	u32 suffix_seq_num;
-};
-
-struct dcbx_ets_feature {
-	u32 flags;
-#define DCBX_ETS_ENABLED_MASK	0x00000001
-#define DCBX_ETS_ENABLED_SHIFT	0
-#define DCBX_ETS_WILLING_MASK	0x00000002
-#define DCBX_ETS_WILLING_SHIFT	1
-#define DCBX_ETS_ERROR_MASK	0x00000004
-#define DCBX_ETS_ERROR_SHIFT	2
-#define DCBX_ETS_CBS_MASK	0x00000008
-#define DCBX_ETS_CBS_SHIFT	3
-#define DCBX_ETS_MAX_TCS_MASK	0x000000f0
-#define DCBX_ETS_MAX_TCS_SHIFT	4
-#define DCBX_OOO_TC_MASK	0x00000f00
-#define DCBX_OOO_TC_SHIFT	8
-	u32 pri_tc_tbl[1];
-#define DCBX_TCP_OOO_TC		(4)
-
-#define NIG_ETS_ISCSI_OOO_CLIENT_OFFSET	(DCBX_TCP_OOO_TC + 1)
-#define DCBX_CEE_STRICT_PRIORITY	0xf
-	u32 tc_bw_tbl[2];
-	u32 tc_tsa_tbl[2];
-#define DCBX_ETS_TSA_STRICT	0
-#define DCBX_ETS_TSA_CBS	1
-#define DCBX_ETS_TSA_ETS	2
-};
-
-#define DCBX_TCP_OOO_TC			(4)
-#define DCBX_TCP_OOO_K2_4PORT_TC	(3)
-
-struct dcbx_app_priority_entry {
-	u32 entry;
-#define DCBX_APP_PRI_MAP_MASK		0x000000ff
-#define DCBX_APP_PRI_MAP_SHIFT		0
-#define DCBX_APP_PRI_0			0x01
-#define DCBX_APP_PRI_1			0x02
-#define DCBX_APP_PRI_2			0x04
-#define DCBX_APP_PRI_3			0x08
-#define DCBX_APP_PRI_4			0x10
-#define DCBX_APP_PRI_5			0x20
-#define DCBX_APP_PRI_6			0x40
-#define DCBX_APP_PRI_7			0x80
-#define DCBX_APP_SF_MASK		0x00000300
-#define DCBX_APP_SF_SHIFT		8
-#define DCBX_APP_SF_ETHTYPE		0
-#define DCBX_APP_SF_PORT		1
-#define DCBX_APP_SF_IEEE_MASK		0x0000f000
-#define DCBX_APP_SF_IEEE_SHIFT		12
-#define DCBX_APP_SF_IEEE_RESERVED	0
-#define DCBX_APP_SF_IEEE_ETHTYPE	1
-#define DCBX_APP_SF_IEEE_TCP_PORT	2
-#define DCBX_APP_SF_IEEE_UDP_PORT	3
-#define DCBX_APP_SF_IEEE_TCP_UDP_PORT	4
-
-#define DCBX_APP_PROTOCOL_ID_MASK	0xffff0000
-#define DCBX_APP_PROTOCOL_ID_SHIFT	16
-};
-
-struct dcbx_app_priority_feature {
-	u32 flags;
-#define DCBX_APP_ENABLED_MASK		0x00000001
-#define DCBX_APP_ENABLED_SHIFT		0
-#define DCBX_APP_WILLING_MASK		0x00000002
-#define DCBX_APP_WILLING_SHIFT		1
-#define DCBX_APP_ERROR_MASK		0x00000004
-#define DCBX_APP_ERROR_SHIFT		2
-#define DCBX_APP_MAX_TCS_MASK		0x0000f000
-#define DCBX_APP_MAX_TCS_SHIFT		12
-#define DCBX_APP_NUM_ENTRIES_MASK	0x00ff0000
-#define DCBX_APP_NUM_ENTRIES_SHIFT	16
-	struct dcbx_app_priority_entry app_pri_tbl[DCBX_MAX_APP_PROTOCOL];
-};
-
-struct dcbx_features {
-	struct dcbx_ets_feature ets;
-	u32 pfc;
-#define DCBX_PFC_PRI_EN_BITMAP_MASK	0x000000ff
-#define DCBX_PFC_PRI_EN_BITMAP_SHIFT	0
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_0	0x01
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_1	0x02
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_2	0x04
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_3	0x08
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_4	0x10
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_5	0x20
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_6	0x40
-#define DCBX_PFC_PRI_EN_BITMAP_PRI_7	0x80
-
-#define DCBX_PFC_FLAGS_MASK		0x0000ff00
-#define DCBX_PFC_FLAGS_SHIFT		8
-#define DCBX_PFC_CAPS_MASK		0x00000f00
-#define DCBX_PFC_CAPS_SHIFT		8
-#define DCBX_PFC_MBC_MASK		0x00004000
-#define DCBX_PFC_MBC_SHIFT		14
-#define DCBX_PFC_WILLING_MASK		0x00008000
-#define DCBX_PFC_WILLING_SHIFT		15
-#define DCBX_PFC_ENABLED_MASK		0x00010000
-#define DCBX_PFC_ENABLED_SHIFT		16
-#define DCBX_PFC_ERROR_MASK		0x00020000
-#define DCBX_PFC_ERROR_SHIFT		17
-
-	struct dcbx_app_priority_feature app;
-};
-
-struct dcbx_local_params {
-	u32 config;
-#define DCBX_CONFIG_VERSION_MASK	0x00000007
-#define DCBX_CONFIG_VERSION_SHIFT	0
-#define DCBX_CONFIG_VERSION_DISABLED	0
-#define DCBX_CONFIG_VERSION_IEEE	1
-#define DCBX_CONFIG_VERSION_CEE		2
-#define DCBX_CONFIG_VERSION_STATIC	4
-
-	u32 flags;
-	struct dcbx_features features;
-};
-
-struct dcbx_mib {
-	u32 prefix_seq_num;
-	u32 flags;
-	struct dcbx_features features;
-	u32 suffix_seq_num;
-};
-
-struct lldp_system_tlvs_buffer_s {
-	u16 valid;
-	u16 length;
-	u32 data[MAX_SYSTEM_LLDP_TLV_DATA];
-};
-
-struct dcb_dscp_map {
-	u32 flags;
-#define DCB_DSCP_ENABLE_MASK	0x1
-#define DCB_DSCP_ENABLE_SHIFT	0
-#define DCB_DSCP_ENABLE	1
-	u32 dscp_pri_map[8];
-};
-
-struct public_global {
-	u32 max_path;
-	u32 max_ports;
-#define MODE_1P 1
-#define MODE_2P 2
-#define MODE_3P 3
-#define MODE_4P 4
-	u32 debug_mb_offset;
-	u32 phymod_dbg_mb_offset;
-	struct couple_mode_teaming cmt;
-	s32 internal_temperature;
-	u32 mfw_ver;
-	u32 running_bundle_id;
-	s32 external_temperature;
-	u32 mdump_reason;
-	u64 reserved;
-	u32 data_ptr;
-	u32 data_size;
-};
-
-struct fw_flr_mb {
-	u32 aggint;
-	u32 opgen_addr;
-	u32 accum_ack;
-};
-
-struct public_path {
-	struct fw_flr_mb flr_mb;
-	u32 mcp_vf_disabled[VF_MAX_STATIC / 32];
-
-	u32 process_kill;
-#define PROCESS_KILL_COUNTER_MASK	0x0000ffff
-#define PROCESS_KILL_COUNTER_SHIFT	0
-#define PROCESS_KILL_GLOB_AEU_BIT_MASK	0xffff0000
-#define PROCESS_KILL_GLOB_AEU_BIT_SHIFT	16
-#define GLOBAL_AEU_BIT(aeu_reg_id, aeu_bit) (aeu_reg_id * 32 + aeu_bit)
-};
-
-struct public_port {
-	u32						validity_map;
-
-	u32						link_status;
-#define LINK_STATUS_LINK_UP				0x00000001
-#define LINK_STATUS_SPEED_AND_DUPLEX_MASK		0x0000001e
-#define LINK_STATUS_SPEED_AND_DUPLEX_1000THD		(1 << 1)
-#define LINK_STATUS_SPEED_AND_DUPLEX_1000TFD		(2 << 1)
-#define LINK_STATUS_SPEED_AND_DUPLEX_10G		(3 << 1)
-#define LINK_STATUS_SPEED_AND_DUPLEX_20G		(4 << 1)
-#define LINK_STATUS_SPEED_AND_DUPLEX_40G		(5 << 1)
-#define LINK_STATUS_SPEED_AND_DUPLEX_50G		(6 << 1)
-#define LINK_STATUS_SPEED_AND_DUPLEX_100G		(7 << 1)
-#define LINK_STATUS_SPEED_AND_DUPLEX_25G		(8 << 1)
-#define LINK_STATUS_AUTO_NEGOTIATE_ENABLED		0x00000020
-#define LINK_STATUS_AUTO_NEGOTIATE_COMPLETE		0x00000040
-#define LINK_STATUS_PARALLEL_DETECTION_USED		0x00000080
-#define LINK_STATUS_PFC_ENABLED				0x00000100
-#define LINK_STATUS_LINK_PARTNER_1000TFD_CAPABLE	0x00000200
-#define LINK_STATUS_LINK_PARTNER_1000THD_CAPABLE	0x00000400
-#define LINK_STATUS_LINK_PARTNER_10G_CAPABLE		0x00000800
-#define LINK_STATUS_LINK_PARTNER_20G_CAPABLE		0x00001000
-#define LINK_STATUS_LINK_PARTNER_40G_CAPABLE		0x00002000
-#define LINK_STATUS_LINK_PARTNER_50G_CAPABLE		0x00004000
-#define LINK_STATUS_LINK_PARTNER_100G_CAPABLE		0x00008000
-#define LINK_STATUS_LINK_PARTNER_25G_CAPABLE		0x00010000
-#define LINK_STATUS_LINK_PARTNER_FLOW_CONTROL_MASK	0x000c0000
-#define LINK_STATUS_LINK_PARTNER_NOT_PAUSE_CAPABLE	(0 << 18)
-#define LINK_STATUS_LINK_PARTNER_SYMMETRIC_PAUSE	(1 << 18)
-#define LINK_STATUS_LINK_PARTNER_ASYMMETRIC_PAUSE	(2 << 18)
-#define LINK_STATUS_LINK_PARTNER_BOTH_PAUSE		(3 << 18)
-#define LINK_STATUS_SFP_TX_FAULT			0x00100000
-#define LINK_STATUS_TX_FLOW_CONTROL_ENABLED		0x00200000
-#define LINK_STATUS_RX_FLOW_CONTROL_ENABLED		0x00400000
-#define LINK_STATUS_RX_SIGNAL_PRESENT			0x00800000
-#define LINK_STATUS_MAC_LOCAL_FAULT			0x01000000
-#define LINK_STATUS_MAC_REMOTE_FAULT			0x02000000
-#define LINK_STATUS_UNSUPPORTED_SPD_REQ			0x04000000
-
-#define LINK_STATUS_FEC_MODE_MASK			0x38000000
-#define LINK_STATUS_FEC_MODE_NONE			(0 << 27)
-#define LINK_STATUS_FEC_MODE_FIRECODE_CL74		(1 << 27)
-#define LINK_STATUS_FEC_MODE_RS_CL91			(2 << 27)
-
-	u32 link_status1;
-	u32 ext_phy_fw_version;
-	u32 drv_phy_cfg_addr;
-
-	u32 port_stx;
-
-	u32 stat_nig_timer;
-
-	struct port_mf_cfg port_mf_config;
-	struct port_stats stats;
-
-	u32 media_type;
-#define MEDIA_UNSPECIFIED	0x0
-#define MEDIA_SFPP_10G_FIBER	0x1
-#define MEDIA_XFP_FIBER		0x2
-#define MEDIA_DA_TWINAX		0x3
-#define MEDIA_BASE_T		0x4
-#define MEDIA_SFP_1G_FIBER	0x5
-#define MEDIA_MODULE_FIBER	0x6
-#define MEDIA_KR		0xf0
-#define MEDIA_NOT_PRESENT	0xff
-
-	u32 lfa_status;
-	u32 link_change_count;
-
-	struct lldp_config_params_s lldp_config_params[LLDP_MAX_LLDP_AGENTS];
-	struct lldp_status_params_s lldp_status_params[LLDP_MAX_LLDP_AGENTS];
-	struct lldp_system_tlvs_buffer_s system_lldp_tlvs_buf;
-
-	/* DCBX related MIB */
-	struct dcbx_local_params local_admin_dcbx_mib;
-	struct dcbx_mib remote_dcbx_mib;
-	struct dcbx_mib operational_dcbx_mib;
-
-	u32 reserved[2];
-
-	u32						transceiver_data;
-#define ETH_TRANSCEIVER_STATE_MASK			0x000000ff
-#define ETH_TRANSCEIVER_STATE_SHIFT			0x00000000
-#define ETH_TRANSCEIVER_STATE_OFFSET			0x00000000
-#define ETH_TRANSCEIVER_STATE_UNPLUGGED			0x00000000
-#define ETH_TRANSCEIVER_STATE_PRESENT			0x00000001
-#define ETH_TRANSCEIVER_STATE_VALID			0x00000003
-#define ETH_TRANSCEIVER_STATE_UPDATING			0x00000008
-#define ETH_TRANSCEIVER_TYPE_MASK			0x0000ff00
-#define ETH_TRANSCEIVER_TYPE_OFFSET			0x8
-#define ETH_TRANSCEIVER_TYPE_NONE			0x00
-#define ETH_TRANSCEIVER_TYPE_UNKNOWN			0xff
-#define ETH_TRANSCEIVER_TYPE_1G_PCC			0x01
-#define ETH_TRANSCEIVER_TYPE_1G_ACC			0x02
-#define ETH_TRANSCEIVER_TYPE_1G_LX			0x03
-#define ETH_TRANSCEIVER_TYPE_1G_SX			0x04
-#define ETH_TRANSCEIVER_TYPE_10G_SR			0x05
-#define ETH_TRANSCEIVER_TYPE_10G_LR			0x06
-#define ETH_TRANSCEIVER_TYPE_10G_LRM			0x07
-#define ETH_TRANSCEIVER_TYPE_10G_ER			0x08
-#define ETH_TRANSCEIVER_TYPE_10G_PCC			0x09
-#define ETH_TRANSCEIVER_TYPE_10G_ACC			0x0a
-#define ETH_TRANSCEIVER_TYPE_XLPPI			0x0b
-#define ETH_TRANSCEIVER_TYPE_40G_LR4			0x0c
-#define ETH_TRANSCEIVER_TYPE_40G_SR4			0x0d
-#define ETH_TRANSCEIVER_TYPE_40G_CR4			0x0e
-#define ETH_TRANSCEIVER_TYPE_100G_AOC			0x0f
-#define ETH_TRANSCEIVER_TYPE_100G_SR4			0x10
-#define ETH_TRANSCEIVER_TYPE_100G_LR4			0x11
-#define ETH_TRANSCEIVER_TYPE_100G_ER4			0x12
-#define ETH_TRANSCEIVER_TYPE_100G_ACC			0x13
-#define ETH_TRANSCEIVER_TYPE_100G_CR4			0x14
-#define ETH_TRANSCEIVER_TYPE_4x10G_SR			0x15
-#define ETH_TRANSCEIVER_TYPE_25G_CA_N			0x16
-#define ETH_TRANSCEIVER_TYPE_25G_ACC_S			0x17
-#define ETH_TRANSCEIVER_TYPE_25G_CA_S			0x18
-#define ETH_TRANSCEIVER_TYPE_25G_ACC_M			0x19
-#define ETH_TRANSCEIVER_TYPE_25G_CA_L			0x1a
-#define ETH_TRANSCEIVER_TYPE_25G_ACC_L			0x1b
-#define ETH_TRANSCEIVER_TYPE_25G_SR			0x1c
-#define ETH_TRANSCEIVER_TYPE_25G_LR			0x1d
-#define ETH_TRANSCEIVER_TYPE_25G_AOC			0x1e
-#define ETH_TRANSCEIVER_TYPE_4x10G			0x1f
-#define ETH_TRANSCEIVER_TYPE_4x25G_CR			0x20
-#define ETH_TRANSCEIVER_TYPE_1000BASET			0x21
-#define ETH_TRANSCEIVER_TYPE_10G_BASET			0x22
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_40G_SR	0x30
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_40G_CR	0x31
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_40G_LR	0x32
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_SR	0x33
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_CR	0x34
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_LR	0x35
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_AOC	0x36
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_25G_SR	0x37
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_25G_LR	0x38
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_1G_10G_SR	0x39
-#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_1G_10G_LR	0x3a
-
-	u32 wol_info;
-	u32 wol_pkt_len;
-	u32 wol_pkt_details;
-	struct dcb_dscp_map dcb_dscp_map;
-
-	u32 eee_status;
-#define EEE_ACTIVE_BIT			BIT(0)
-#define EEE_LD_ADV_STATUS_MASK		0x000000f0
-#define EEE_LD_ADV_STATUS_OFFSET	4
-#define EEE_1G_ADV			BIT(1)
-#define EEE_10G_ADV			BIT(2)
-#define EEE_LP_ADV_STATUS_MASK		0x00000f00
-#define EEE_LP_ADV_STATUS_OFFSET	8
-#define EEE_SUPPORTED_SPEED_MASK	0x0000f000
-#define EEE_SUPPORTED_SPEED_OFFSET	12
-#define EEE_1G_SUPPORTED		BIT(1)
-#define EEE_10G_SUPPORTED		BIT(2)
-
-	u32 eee_remote;
-#define EEE_REMOTE_TW_TX_MASK   0x0000ffff
-#define EEE_REMOTE_TW_TX_OFFSET 0
-#define EEE_REMOTE_TW_RX_MASK   0xffff0000
-#define EEE_REMOTE_TW_RX_OFFSET 16
-
-	u32 reserved1;
-	u32 oem_cfg_port;
-#define OEM_CFG_CHANNEL_TYPE_MASK                       0x00000003
-#define OEM_CFG_CHANNEL_TYPE_OFFSET                     0
-#define OEM_CFG_CHANNEL_TYPE_VLAN_PARTITION             0x1
-#define OEM_CFG_CHANNEL_TYPE_STAGGED                    0x2
-#define OEM_CFG_SCHED_TYPE_MASK                         0x0000000C
-#define OEM_CFG_SCHED_TYPE_OFFSET                       2
-#define OEM_CFG_SCHED_TYPE_ETS                          0x1
-#define OEM_CFG_SCHED_TYPE_VNIC_BW                      0x2
-};
-
-struct public_func {
-	u32 reserved0[2];
-
-	u32 mtu_size;
-
-	u32 reserved[7];
-
-	u32 config;
-#define FUNC_MF_CFG_FUNC_HIDE			0x00000001
-#define FUNC_MF_CFG_PAUSE_ON_HOST_RING		0x00000002
-#define FUNC_MF_CFG_PAUSE_ON_HOST_RING_SHIFT	0x00000001
-
-#define FUNC_MF_CFG_PROTOCOL_MASK	0x000000f0
-#define FUNC_MF_CFG_PROTOCOL_SHIFT	4
-#define FUNC_MF_CFG_PROTOCOL_ETHERNET	0x00000000
-#define FUNC_MF_CFG_PROTOCOL_ISCSI              0x00000010
-#define FUNC_MF_CFG_PROTOCOL_FCOE               0x00000020
-#define FUNC_MF_CFG_PROTOCOL_ROCE               0x00000030
-#define FUNC_MF_CFG_PROTOCOL_NVMETCP    0x00000040
-#define FUNC_MF_CFG_PROTOCOL_MAX	0x00000040
-
-#define FUNC_MF_CFG_MIN_BW_MASK		0x0000ff00
-#define FUNC_MF_CFG_MIN_BW_SHIFT	8
-#define FUNC_MF_CFG_MIN_BW_DEFAULT	0x00000000
-#define FUNC_MF_CFG_MAX_BW_MASK		0x00ff0000
-#define FUNC_MF_CFG_MAX_BW_SHIFT	16
-#define FUNC_MF_CFG_MAX_BW_DEFAULT	0x00640000
-
-	u32 status;
-#define FUNC_STATUS_VIRTUAL_LINK_UP	0x00000001
-
-	u32 mac_upper;
-#define FUNC_MF_CFG_UPPERMAC_MASK	0x0000ffff
-#define FUNC_MF_CFG_UPPERMAC_SHIFT	0
-#define FUNC_MF_CFG_UPPERMAC_DEFAULT	FUNC_MF_CFG_UPPERMAC_MASK
-	u32 mac_lower;
-#define FUNC_MF_CFG_LOWERMAC_DEFAULT	0xffffffff
-
-	u32 fcoe_wwn_port_name_upper;
-	u32 fcoe_wwn_port_name_lower;
-
-	u32 fcoe_wwn_node_name_upper;
-	u32 fcoe_wwn_node_name_lower;
-
-	u32 ovlan_stag;
-#define FUNC_MF_CFG_OV_STAG_MASK	0x0000ffff
-#define FUNC_MF_CFG_OV_STAG_SHIFT	0
-#define FUNC_MF_CFG_OV_STAG_DEFAULT	FUNC_MF_CFG_OV_STAG_MASK
-
-	u32 pf_allocation;
-
-	u32 preserve_data;
-
-	u32 driver_last_activity_ts;
-
-	u32 drv_ack_vf_disabled[VF_MAX_STATIC / 32];
-
-	u32 drv_id;
-#define DRV_ID_PDA_COMP_VER_MASK	0x0000ffff
-#define DRV_ID_PDA_COMP_VER_SHIFT	0
-
-#define LOAD_REQ_HSI_VERSION		2
-#define DRV_ID_MCP_HSI_VER_MASK		0x00ff0000
-#define DRV_ID_MCP_HSI_VER_SHIFT	16
-#define DRV_ID_MCP_HSI_VER_CURRENT	(LOAD_REQ_HSI_VERSION << \
-					 DRV_ID_MCP_HSI_VER_SHIFT)
-
-#define DRV_ID_DRV_TYPE_MASK		0x7f000000
-#define DRV_ID_DRV_TYPE_SHIFT		24
-#define DRV_ID_DRV_TYPE_UNKNOWN		(0 << DRV_ID_DRV_TYPE_SHIFT)
-#define DRV_ID_DRV_TYPE_LINUX		(1 << DRV_ID_DRV_TYPE_SHIFT)
-
-#define DRV_ID_DRV_INIT_HW_MASK		0x80000000
-#define DRV_ID_DRV_INIT_HW_SHIFT	31
-#define DRV_ID_DRV_INIT_HW_FLAG		(1 << DRV_ID_DRV_INIT_HW_SHIFT)
-
-	u32 oem_cfg_func;
-#define OEM_CFG_FUNC_TC_MASK                    0x0000000F
-#define OEM_CFG_FUNC_TC_OFFSET                  0
-#define OEM_CFG_FUNC_TC_0                       0x0
-#define OEM_CFG_FUNC_TC_1                       0x1
-#define OEM_CFG_FUNC_TC_2                       0x2
-#define OEM_CFG_FUNC_TC_3                       0x3
-#define OEM_CFG_FUNC_TC_4                       0x4
-#define OEM_CFG_FUNC_TC_5                       0x5
-#define OEM_CFG_FUNC_TC_6                       0x6
-#define OEM_CFG_FUNC_TC_7                       0x7
-
-#define OEM_CFG_FUNC_HOST_PRI_CTRL_MASK         0x00000030
-#define OEM_CFG_FUNC_HOST_PRI_CTRL_OFFSET       4
-#define OEM_CFG_FUNC_HOST_PRI_CTRL_VNIC         0x1
-#define OEM_CFG_FUNC_HOST_PRI_CTRL_OS           0x2
-};
-
-struct mcp_mac {
-	u32 mac_upper;
-	u32 mac_lower;
-};
-
-struct mcp_val64 {
-	u32 lo;
-	u32 hi;
-};
-
-struct mcp_file_att {
-	u32 nvm_start_addr;
-	u32 len;
-};
-
-struct bist_nvm_image_att {
-	u32 return_code;
-	u32 image_type;
-	u32 nvm_start_addr;
-	u32 len;
-};
-
-#define MCP_DRV_VER_STR_SIZE 16
-#define MCP_DRV_VER_STR_SIZE_DWORD (MCP_DRV_VER_STR_SIZE / sizeof(u32))
-#define MCP_DRV_NVM_BUF_LEN 32
-struct drv_version_stc {
-	u32 version;
-	u8 name[MCP_DRV_VER_STR_SIZE - 4];
-};
-
-struct lan_stats_stc {
-	u64 ucast_rx_pkts;
-	u64 ucast_tx_pkts;
-	u32 fcs_err;
-	u32 rserved;
-};
-
-struct fcoe_stats_stc {
-	u64 rx_pkts;
-	u64 tx_pkts;
-	u32 fcs_err;
-	u32 login_failure;
-};
-
-struct ocbb_data_stc {
-	u32 ocbb_host_addr;
-	u32 ocsd_host_addr;
-	u32 ocsd_req_update_interval;
-};
-
-#define MAX_NUM_OF_SENSORS 7
-struct temperature_status_stc {
-	u32 num_of_sensors;
-	u32 sensor[MAX_NUM_OF_SENSORS];
-};
-
-/* crash dump configuration header */
-struct mdump_config_stc {
-	u32 version;
-	u32 config;
-	u32 epoc;
-	u32 num_of_logs;
-	u32 valid_logs;
-};
-
-enum resource_id_enum {
-	RESOURCE_NUM_SB_E = 0,
-	RESOURCE_NUM_L2_QUEUE_E = 1,
-	RESOURCE_NUM_VPORT_E = 2,
-	RESOURCE_NUM_VMQ_E = 3,
-	RESOURCE_FACTOR_NUM_RSS_PF_E = 4,
-	RESOURCE_FACTOR_RSS_PER_VF_E = 5,
-	RESOURCE_NUM_RL_E = 6,
-	RESOURCE_NUM_PQ_E = 7,
-	RESOURCE_NUM_VF_E = 8,
-	RESOURCE_VFC_FILTER_E = 9,
-	RESOURCE_ILT_E = 10,
-	RESOURCE_CQS_E = 11,
-	RESOURCE_GFT_PROFILES_E = 12,
-	RESOURCE_NUM_TC_E = 13,
-	RESOURCE_NUM_RSS_ENGINES_E = 14,
-	RESOURCE_LL2_QUEUE_E = 15,
-	RESOURCE_RDMA_STATS_QUEUE_E = 16,
-	RESOURCE_BDQ_E = 17,
-	RESOURCE_QCN_E = 18,
-	RESOURCE_LLH_FILTER_E = 19,
-	RESOURCE_VF_MAC_ADDR = 20,
-	RESOURCE_LL2_CQS_E = 21,
-	RESOURCE_VF_CNQS = 22,
-	RESOURCE_MAX_NUM,
-	RESOURCE_NUM_INVALID = 0xFFFFFFFF
-};
-
-/* Resource ID is to be filled by the driver in the MB request
- * Size, offset & flags to be filled by the MFW in the MB response
- */
-struct resource_info {
-	enum resource_id_enum res_id;
-	u32 size;		/* number of allocated resources */
-	u32 offset;		/* Offset of the 1st resource */
-	u32 vf_size;
-	u32 vf_offset;
-	u32 flags;
-#define RESOURCE_ELEMENT_STRICT (1 << 0)
-};
-
-#define DRV_ROLE_NONE           0
-#define DRV_ROLE_PREBOOT        1
-#define DRV_ROLE_OS             2
-#define DRV_ROLE_KDUMP          3
-
-struct load_req_stc {
-	u32 drv_ver_0;
-	u32 drv_ver_1;
-	u32 fw_ver;
-	u32 misc0;
-#define LOAD_REQ_ROLE_MASK              0x000000FF
-#define LOAD_REQ_ROLE_SHIFT             0
-#define LOAD_REQ_LOCK_TO_MASK           0x0000FF00
-#define LOAD_REQ_LOCK_TO_SHIFT          8
-#define LOAD_REQ_LOCK_TO_DEFAULT        0
-#define LOAD_REQ_LOCK_TO_NONE           255
-#define LOAD_REQ_FORCE_MASK             0x000F0000
-#define LOAD_REQ_FORCE_SHIFT            16
-#define LOAD_REQ_FORCE_NONE             0
-#define LOAD_REQ_FORCE_PF               1
-#define LOAD_REQ_FORCE_ALL              2
-#define LOAD_REQ_FLAGS0_MASK            0x00F00000
-#define LOAD_REQ_FLAGS0_SHIFT           20
-#define LOAD_REQ_FLAGS0_AVOID_RESET     (0x1 << 0)
-};
-
-struct load_rsp_stc {
-	u32 drv_ver_0;
-	u32 drv_ver_1;
-	u32 fw_ver;
-	u32 misc0;
-#define LOAD_RSP_ROLE_MASK              0x000000FF
-#define LOAD_RSP_ROLE_SHIFT             0
-#define LOAD_RSP_HSI_MASK               0x0000FF00
-#define LOAD_RSP_HSI_SHIFT              8
-#define LOAD_RSP_FLAGS0_MASK            0x000F0000
-#define LOAD_RSP_FLAGS0_SHIFT           16
-#define LOAD_RSP_FLAGS0_DRV_EXISTS      (0x1 << 0)
-};
-
-struct mdump_retain_data_stc {
-	u32 valid;
-	u32 epoch;
-	u32 pf;
-	u32 status;
-};
-
-union drv_union_data {
-	u32 ver_str[MCP_DRV_VER_STR_SIZE_DWORD];
-	struct mcp_mac wol_mac;
-
-	struct eth_phy_cfg drv_phy_cfg;
-
-	struct mcp_val64 val64;
-
-	u8 raw_data[MCP_DRV_NVM_BUF_LEN];
-
-	struct mcp_file_att file_att;
-
-	u32 ack_vf_disabled[VF_MAX_STATIC / 32];
-
-	struct drv_version_stc drv_version;
-
-	struct lan_stats_stc lan_stats;
-	struct fcoe_stats_stc fcoe_stats;
-	struct ocbb_data_stc ocbb_info;
-	struct temperature_status_stc temp_info;
-	struct resource_info resource;
-	struct bist_nvm_image_att nvm_image_att;
-	struct mdump_config_stc mdump_config;
-};
-
-struct public_drv_mb {
-	u32 drv_mb_header;
-#define DRV_MSG_CODE_MASK			0xffff0000
-#define DRV_MSG_CODE_LOAD_REQ			0x10000000
-#define DRV_MSG_CODE_LOAD_DONE			0x11000000
-#define DRV_MSG_CODE_INIT_HW			0x12000000
-#define DRV_MSG_CODE_CANCEL_LOAD_REQ            0x13000000
-#define DRV_MSG_CODE_UNLOAD_REQ			0x20000000
-#define DRV_MSG_CODE_UNLOAD_DONE		0x21000000
-#define DRV_MSG_CODE_INIT_PHY			0x22000000
-#define DRV_MSG_CODE_LINK_RESET			0x23000000
-#define DRV_MSG_CODE_SET_DCBX			0x25000000
-#define DRV_MSG_CODE_OV_UPDATE_CURR_CFG         0x26000000
-#define DRV_MSG_CODE_OV_UPDATE_BUS_NUM          0x27000000
-#define DRV_MSG_CODE_OV_UPDATE_BOOT_PROGRESS    0x28000000
-#define DRV_MSG_CODE_OV_UPDATE_STORM_FW_VER     0x29000000
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE     0x31000000
-#define DRV_MSG_CODE_BW_UPDATE_ACK              0x32000000
-#define DRV_MSG_CODE_OV_UPDATE_MTU              0x33000000
-#define DRV_MSG_GET_RESOURCE_ALLOC_MSG		0x34000000
-#define DRV_MSG_SET_RESOURCE_VALUE_MSG		0x35000000
-#define DRV_MSG_CODE_OV_UPDATE_WOL              0x38000000
-#define DRV_MSG_CODE_OV_UPDATE_ESWITCH_MODE     0x39000000
-#define DRV_MSG_CODE_GET_OEM_UPDATES            0x41000000
-
-#define DRV_MSG_CODE_BW_UPDATE_ACK		0x32000000
-#define DRV_MSG_CODE_NIG_DRAIN			0x30000000
-#define DRV_MSG_CODE_S_TAG_UPDATE_ACK		0x3b000000
-#define DRV_MSG_CODE_GET_NVM_CFG_OPTION		0x003e0000
-#define DRV_MSG_CODE_SET_NVM_CFG_OPTION		0x003f0000
-#define DRV_MSG_CODE_INITIATE_PF_FLR            0x02010000
-#define DRV_MSG_CODE_VF_DISABLED_DONE		0xc0000000
-#define DRV_MSG_CODE_CFG_VF_MSIX		0xc0010000
-#define DRV_MSG_CODE_CFG_PF_VFS_MSIX		0xc0020000
-#define DRV_MSG_CODE_NVM_PUT_FILE_BEGIN		0x00010000
-#define DRV_MSG_CODE_NVM_PUT_FILE_DATA		0x00020000
-#define DRV_MSG_CODE_NVM_GET_FILE_ATT		0x00030000
-#define DRV_MSG_CODE_NVM_READ_NVRAM		0x00050000
-#define DRV_MSG_CODE_NVM_WRITE_NVRAM		0x00060000
-#define DRV_MSG_CODE_MCP_RESET			0x00090000
-#define DRV_MSG_CODE_SET_VERSION		0x000f0000
-#define DRV_MSG_CODE_MCP_HALT                   0x00100000
-#define DRV_MSG_CODE_SET_VMAC                   0x00110000
-#define DRV_MSG_CODE_GET_VMAC                   0x00120000
-#define DRV_MSG_CODE_VMAC_TYPE_SHIFT            4
-#define DRV_MSG_CODE_VMAC_TYPE_MASK             0x30
-#define DRV_MSG_CODE_VMAC_TYPE_MAC              1
-#define DRV_MSG_CODE_VMAC_TYPE_WWNN             2
-#define DRV_MSG_CODE_VMAC_TYPE_WWPN             3
-
-#define DRV_MSG_CODE_GET_STATS                  0x00130000
-#define DRV_MSG_CODE_STATS_TYPE_LAN             1
-#define DRV_MSG_CODE_STATS_TYPE_FCOE            2
-#define DRV_MSG_CODE_STATS_TYPE_ISCSI           3
-#define DRV_MSG_CODE_STATS_TYPE_RDMA            4
-
-#define DRV_MSG_CODE_TRANSCEIVER_READ           0x00160000
-
-#define DRV_MSG_CODE_MASK_PARITIES              0x001a0000
-
-#define DRV_MSG_CODE_BIST_TEST			0x001e0000
-#define DRV_MSG_CODE_SET_LED_MODE		0x00200000
-#define DRV_MSG_CODE_RESOURCE_CMD		0x00230000
-/* Send crash dump commands with param[3:0] - opcode */
-#define DRV_MSG_CODE_MDUMP_CMD			0x00250000
-#define DRV_MSG_CODE_GET_TLV_DONE		0x002f0000
-#define DRV_MSG_CODE_GET_ENGINE_CONFIG		0x00370000
-#define DRV_MSG_CODE_GET_PPFID_BITMAP		0x43000000
-
-#define DRV_MSG_CODE_DEBUG_DATA_SEND		0xc0040000
-
-#define RESOURCE_CMD_REQ_RESC_MASK		0x0000001F
-#define RESOURCE_CMD_REQ_RESC_SHIFT		0
-#define RESOURCE_CMD_REQ_OPCODE_MASK		0x000000E0
-#define RESOURCE_CMD_REQ_OPCODE_SHIFT		5
-#define RESOURCE_OPCODE_REQ			1
-#define RESOURCE_OPCODE_REQ_WO_AGING		2
-#define RESOURCE_OPCODE_REQ_W_AGING		3
-#define RESOURCE_OPCODE_RELEASE			4
-#define RESOURCE_OPCODE_FORCE_RELEASE		5
-#define RESOURCE_CMD_REQ_AGE_MASK		0x0000FF00
-#define RESOURCE_CMD_REQ_AGE_SHIFT		8
-
-#define RESOURCE_CMD_RSP_OWNER_MASK		0x000000FF
-#define RESOURCE_CMD_RSP_OWNER_SHIFT		0
-#define RESOURCE_CMD_RSP_OPCODE_MASK		0x00000700
-#define RESOURCE_CMD_RSP_OPCODE_SHIFT		8
-#define RESOURCE_OPCODE_GNT			1
-#define RESOURCE_OPCODE_BUSY			2
-#define RESOURCE_OPCODE_RELEASED		3
-#define RESOURCE_OPCODE_RELEASED_PREVIOUS	4
-#define RESOURCE_OPCODE_WRONG_OWNER		5
-#define RESOURCE_OPCODE_UNKNOWN_CMD		255
-
-#define RESOURCE_DUMP				0
-
-/* DRV_MSG_CODE_MDUMP_CMD parameters */
-#define MDUMP_DRV_PARAM_OPCODE_MASK             0x0000000f
-#define DRV_MSG_CODE_MDUMP_ACK                  0x01
-#define DRV_MSG_CODE_MDUMP_SET_VALUES           0x02
-#define DRV_MSG_CODE_MDUMP_TRIGGER              0x03
-#define DRV_MSG_CODE_MDUMP_GET_CONFIG           0x04
-#define DRV_MSG_CODE_MDUMP_SET_ENABLE           0x05
-#define DRV_MSG_CODE_MDUMP_CLEAR_LOGS           0x06
-#define DRV_MSG_CODE_MDUMP_GET_RETAIN           0x07
-#define DRV_MSG_CODE_MDUMP_CLR_RETAIN           0x08
-
-#define DRV_MSG_CODE_HW_DUMP_TRIGGER            0x0a
-#define DRV_MSG_CODE_MDUMP_GEN_MDUMP2           0x0b
-#define DRV_MSG_CODE_MDUMP_FREE_MDUMP2          0x0c
-
-#define DRV_MSG_CODE_GET_PF_RDMA_PROTOCOL	0x002b0000
-#define DRV_MSG_CODE_OS_WOL			0x002e0000
-
-#define DRV_MSG_CODE_FEATURE_SUPPORT		0x00300000
-#define DRV_MSG_CODE_GET_MFW_FEATURE_SUPPORT	0x00310000
-#define DRV_MSG_SEQ_NUMBER_MASK			0x0000ffff
-
-	u32 drv_mb_param;
-#define DRV_MB_PARAM_UNLOAD_WOL_UNKNOWN         0x00000000
-#define DRV_MB_PARAM_UNLOAD_WOL_MCP             0x00000001
-#define DRV_MB_PARAM_UNLOAD_WOL_DISABLED        0x00000002
-#define DRV_MB_PARAM_UNLOAD_WOL_ENABLED         0x00000003
-#define DRV_MB_PARAM_DCBX_NOTIFY_MASK		0x000000FF
-#define DRV_MB_PARAM_DCBX_NOTIFY_SHIFT		3
-
-#define DRV_MB_PARAM_NVM_PUT_FILE_BEGIN_MBI     0x3
-#define DRV_MB_PARAM_NVM_OFFSET_OFFSET          0
-#define DRV_MB_PARAM_NVM_OFFSET_MASK            0x00FFFFFF
-#define DRV_MB_PARAM_NVM_LEN_OFFSET		24
-#define DRV_MB_PARAM_NVM_LEN_MASK               0xFF000000
-
-#define DRV_MB_PARAM_CFG_VF_MSIX_VF_ID_SHIFT	0
-#define DRV_MB_PARAM_CFG_VF_MSIX_VF_ID_MASK	0x000000FF
-#define DRV_MB_PARAM_CFG_VF_MSIX_SB_NUM_SHIFT	8
-#define DRV_MB_PARAM_CFG_VF_MSIX_SB_NUM_MASK	0x0000FF00
-#define DRV_MB_PARAM_LLDP_SEND_MASK		0x00000001
-#define DRV_MB_PARAM_LLDP_SEND_SHIFT		0
-
-#define DRV_MB_PARAM_OV_CURR_CFG_SHIFT		0
-#define DRV_MB_PARAM_OV_CURR_CFG_MASK		0x0000000F
-#define DRV_MB_PARAM_OV_CURR_CFG_NONE		0
-#define DRV_MB_PARAM_OV_CURR_CFG_OS		1
-#define DRV_MB_PARAM_OV_CURR_CFG_VENDOR_SPEC	2
-#define DRV_MB_PARAM_OV_CURR_CFG_OTHER		3
-
-#define DRV_MB_PARAM_OV_STORM_FW_VER_SHIFT	0
-#define DRV_MB_PARAM_OV_STORM_FW_VER_MASK	0xFFFFFFFF
-#define DRV_MB_PARAM_OV_STORM_FW_VER_MAJOR_MASK	0xFF000000
-#define DRV_MB_PARAM_OV_STORM_FW_VER_MINOR_MASK	0x00FF0000
-#define DRV_MB_PARAM_OV_STORM_FW_VER_BUILD_MASK	0x0000FF00
-#define DRV_MB_PARAM_OV_STORM_FW_VER_DROP_MASK	0x000000FF
-
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_SHIFT	0
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_MASK	0xF
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_UNKNOWN	0x1
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_NOT_LOADED	0x2
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_LOADING	0x3
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_DISABLED	0x4
-#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_ACTIVE	0x5
-
-#define DRV_MB_PARAM_OV_MTU_SIZE_SHIFT	0
-#define DRV_MB_PARAM_OV_MTU_SIZE_MASK	0xFFFFFFFF
-
-#define DRV_MB_PARAM_WOL_MASK	(DRV_MB_PARAM_WOL_DEFAULT | \
-				 DRV_MB_PARAM_WOL_DISABLED | \
-				 DRV_MB_PARAM_WOL_ENABLED)
-#define DRV_MB_PARAM_WOL_DEFAULT	DRV_MB_PARAM_UNLOAD_WOL_MCP
-#define DRV_MB_PARAM_WOL_DISABLED	DRV_MB_PARAM_UNLOAD_WOL_DISABLED
-#define DRV_MB_PARAM_WOL_ENABLED	DRV_MB_PARAM_UNLOAD_WOL_ENABLED
-
-#define DRV_MB_PARAM_ESWITCH_MODE_MASK	(DRV_MB_PARAM_ESWITCH_MODE_NONE | \
-					 DRV_MB_PARAM_ESWITCH_MODE_VEB | \
-					 DRV_MB_PARAM_ESWITCH_MODE_VEPA)
-#define DRV_MB_PARAM_ESWITCH_MODE_NONE	0x0
-#define DRV_MB_PARAM_ESWITCH_MODE_VEB	0x1
-#define DRV_MB_PARAM_ESWITCH_MODE_VEPA	0x2
-
-#define DRV_MB_PARAM_DUMMY_OEM_UPDATES_MASK	0x1
-#define DRV_MB_PARAM_DUMMY_OEM_UPDATES_OFFSET	0
-
-#define DRV_MB_PARAM_SET_LED_MODE_OPER		0x0
-#define DRV_MB_PARAM_SET_LED_MODE_ON		0x1
-#define DRV_MB_PARAM_SET_LED_MODE_OFF		0x2
-
-#define DRV_MB_PARAM_TRANSCEIVER_PORT_OFFSET			0
-#define DRV_MB_PARAM_TRANSCEIVER_PORT_MASK			0x00000003
-#define DRV_MB_PARAM_TRANSCEIVER_SIZE_OFFSET			2
-#define DRV_MB_PARAM_TRANSCEIVER_SIZE_MASK			0x000000fc
-#define DRV_MB_PARAM_TRANSCEIVER_I2C_ADDRESS_OFFSET		8
-#define DRV_MB_PARAM_TRANSCEIVER_I2C_ADDRESS_MASK		0x0000ff00
-#define DRV_MB_PARAM_TRANSCEIVER_OFFSET_OFFSET			16
-#define DRV_MB_PARAM_TRANSCEIVER_OFFSET_MASK			0xffff0000
-
-	/* Resource Allocation params - Driver version support */
-#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_MASK		0xffff0000
-#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_SHIFT		16
-#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_MASK		0x0000ffff
-#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_SHIFT		0
-
-#define DRV_MB_PARAM_BIST_REGISTER_TEST				1
-#define DRV_MB_PARAM_BIST_CLOCK_TEST				2
-#define DRV_MB_PARAM_BIST_NVM_TEST_NUM_IMAGES			3
-#define DRV_MB_PARAM_BIST_NVM_TEST_IMAGE_BY_INDEX		4
-
-#define DRV_MB_PARAM_BIST_RC_UNKNOWN				0
-#define DRV_MB_PARAM_BIST_RC_PASSED				1
-#define DRV_MB_PARAM_BIST_RC_FAILED				2
-#define DRV_MB_PARAM_BIST_RC_INVALID_PARAMETER			3
-
-#define DRV_MB_PARAM_BIST_TEST_INDEX_SHIFT			0
-#define DRV_MB_PARAM_BIST_TEST_INDEX_MASK			0x000000ff
-#define DRV_MB_PARAM_BIST_TEST_IMAGE_INDEX_SHIFT		8
-#define DRV_MB_PARAM_BIST_TEST_IMAGE_INDEX_MASK			0x0000ff00
-
-#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_MASK			0x0000ffff
-#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_OFFSET		0
-#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EEE			0x00000002
-#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_FEC_CONTROL		0x00000004
-#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EXT_SPEED_FEC_CONTROL	0x00000008
-#define DRV_MB_PARAM_FEATURE_SUPPORT_FUNC_VLINK			0x00010000
-
-/* DRV_MSG_CODE_DEBUG_DATA_SEND parameters */
-#define DRV_MSG_CODE_DEBUG_DATA_SEND_SIZE_OFFSET		0
-#define DRV_MSG_CODE_DEBUG_DATA_SEND_SIZE_MASK			0xff
-
-/* Driver attributes params */
-#define DRV_MB_PARAM_ATTRIBUTE_KEY_OFFSET			0
-#define DRV_MB_PARAM_ATTRIBUTE_KEY_MASK				0x00ffffff
-#define DRV_MB_PARAM_ATTRIBUTE_CMD_OFFSET			24
-#define DRV_MB_PARAM_ATTRIBUTE_CMD_MASK				0xff000000
-
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_OFFSET			0
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_SHIFT			0
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_MASK			0x0000ffff
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ALL_SHIFT			16
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ALL_MASK			0x00010000
-#define DRV_MB_PARAM_NVM_CFG_OPTION_INIT_SHIFT			17
-#define DRV_MB_PARAM_NVM_CFG_OPTION_INIT_MASK			0x00020000
-#define DRV_MB_PARAM_NVM_CFG_OPTION_COMMIT_SHIFT		18
-#define DRV_MB_PARAM_NVM_CFG_OPTION_COMMIT_MASK			0x00040000
-#define DRV_MB_PARAM_NVM_CFG_OPTION_FREE_SHIFT			19
-#define DRV_MB_PARAM_NVM_CFG_OPTION_FREE_MASK			0x00080000
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_SEL_SHIFT		20
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_SEL_MASK		0x00100000
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_ID_SHIFT		24
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_ID_MASK		0x0f000000
-
-	u32 fw_mb_header;
-#define FW_MSG_CODE_MASK			0xffff0000
-#define FW_MSG_CODE_UNSUPPORTED                 0x00000000
-#define FW_MSG_CODE_DRV_LOAD_ENGINE		0x10100000
-#define FW_MSG_CODE_DRV_LOAD_PORT		0x10110000
-#define FW_MSG_CODE_DRV_LOAD_FUNCTION		0x10120000
-#define FW_MSG_CODE_DRV_LOAD_REFUSED_PDA	0x10200000
-#define FW_MSG_CODE_DRV_LOAD_REFUSED_HSI_1	0x10210000
-#define FW_MSG_CODE_DRV_LOAD_REFUSED_DIAG	0x10220000
-#define FW_MSG_CODE_DRV_LOAD_REFUSED_HSI        0x10230000
-#define FW_MSG_CODE_DRV_LOAD_REFUSED_REQUIRES_FORCE 0x10300000
-#define FW_MSG_CODE_DRV_LOAD_REFUSED_REJECT     0x10310000
-#define FW_MSG_CODE_DRV_LOAD_DONE		0x11100000
-#define FW_MSG_CODE_DRV_UNLOAD_ENGINE		0x20110000
-#define FW_MSG_CODE_DRV_UNLOAD_PORT		0x20120000
-#define FW_MSG_CODE_DRV_UNLOAD_FUNCTION		0x20130000
-#define FW_MSG_CODE_DRV_UNLOAD_DONE		0x21100000
-#define FW_MSG_CODE_RESOURCE_ALLOC_OK           0x34000000
-#define FW_MSG_CODE_RESOURCE_ALLOC_UNKNOWN      0x35000000
-#define FW_MSG_CODE_RESOURCE_ALLOC_DEPRECATED   0x36000000
-#define FW_MSG_CODE_S_TAG_UPDATE_ACK_DONE	0x3b000000
-#define FW_MSG_CODE_DRV_CFG_VF_MSIX_DONE	0xb0010000
-
-#define FW_MSG_CODE_NVM_OK			0x00010000
-#define FW_MSG_CODE_NVM_PUT_FILE_FINISH_OK	0x00400000
-#define FW_MSG_CODE_PHY_OK			0x00110000
-#define FW_MSG_CODE_OK				0x00160000
-#define FW_MSG_CODE_ERROR			0x00170000
-#define FW_MSG_CODE_TRANSCEIVER_DIAG_OK		0x00160000
-#define FW_MSG_CODE_TRANSCEIVER_DIAG_ERROR	0x00170000
-#define FW_MSG_CODE_TRANSCEIVER_NOT_PRESENT	0x00020000
-
-#define FW_MSG_CODE_OS_WOL_SUPPORTED            0x00800000
-#define FW_MSG_CODE_OS_WOL_NOT_SUPPORTED        0x00810000
-#define FW_MSG_CODE_DRV_CFG_PF_VFS_MSIX_DONE	0x00870000
-#define FW_MSG_SEQ_NUMBER_MASK			0x0000ffff
-
-#define FW_MSG_CODE_DEBUG_DATA_SEND_INV_ARG	0xb0070000
-#define FW_MSG_CODE_DEBUG_DATA_SEND_BUF_FULL	0xb0080000
-#define FW_MSG_CODE_DEBUG_DATA_SEND_NO_BUF	0xb0090000
-#define FW_MSG_CODE_DEBUG_NOT_ENABLED		0xb00a0000
-#define FW_MSG_CODE_DEBUG_DATA_SEND_OK		0xb00b0000
-
-#define FW_MSG_CODE_MDUMP_INVALID_CMD		0x00030000
-
-	u32							fw_mb_param;
-#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_MASK		0xffff0000
-#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_SHIFT		16
-#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_MASK		0x0000ffff
-#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_SHIFT		0
-
-	/* Get PF RDMA protocol command response */
-#define FW_MB_PARAM_GET_PF_RDMA_NONE				0x0
-#define FW_MB_PARAM_GET_PF_RDMA_ROCE				0x1
-#define FW_MB_PARAM_GET_PF_RDMA_IWARP				0x2
-#define FW_MB_PARAM_GET_PF_RDMA_BOTH				0x3
-
-	/* Get MFW feature support response */
-#define FW_MB_PARAM_FEATURE_SUPPORT_SMARTLINQ			BIT(0)
-#define FW_MB_PARAM_FEATURE_SUPPORT_EEE				BIT(1)
-#define FW_MB_PARAM_FEATURE_SUPPORT_FEC_CONTROL			BIT(5)
-#define FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL	BIT(6)
-#define FW_MB_PARAM_FEATURE_SUPPORT_VLINK			BIT(16)
-
-#define FW_MB_PARAM_LOAD_DONE_DID_EFUSE_ERROR			BIT(0)
-
-#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALID_MASK		0x00000001
-#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALID_SHIFT		0
-#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALUE_MASK		0x00000002
-#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALUE_SHIFT		1
-#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALID_MASK			0x00000004
-#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALID_SHIFT		2
-#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALUE_MASK			0x00000008
-#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALUE_SHIFT		3
-
-#define FW_MB_PARAM_PPFID_BITMAP_MASK				0xff
-#define FW_MB_PARAM_PPFID_BITMAP_SHIFT				0
-
-	u32							drv_pulse_mb;
-#define DRV_PULSE_SEQ_MASK					0x00007fff
-#define DRV_PULSE_SYSTEM_TIME_MASK				0xffff0000
-#define DRV_PULSE_ALWAYS_ALIVE					0x00008000
-
-	u32							mcp_pulse_mb;
-#define MCP_PULSE_SEQ_MASK					0x00007fff
-#define MCP_PULSE_ALWAYS_ALIVE					0x00008000
-#define MCP_EVENT_MASK						0xffff0000
-#define MCP_EVENT_OTHER_DRIVER_RESET_REQ			0x00010000
-
-	union drv_union_data					union_data;
-};
-
-#define FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET_MASK		0x00ffffff
-#define FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET_SHIFT		0
-#define FW_MB_PARAM_NVM_PUT_FILE_REQ_SIZE_MASK			0xff000000
-#define FW_MB_PARAM_NVM_PUT_FILE_REQ_SIZE_SHIFT			24
-
-enum MFW_DRV_MSG_TYPE {
-	MFW_DRV_MSG_LINK_CHANGE,
-	MFW_DRV_MSG_FLR_FW_ACK_FAILED,
-	MFW_DRV_MSG_VF_DISABLED,
-	MFW_DRV_MSG_LLDP_DATA_UPDATED,
-	MFW_DRV_MSG_DCBX_REMOTE_MIB_UPDATED,
-	MFW_DRV_MSG_DCBX_OPERATIONAL_MIB_UPDATED,
-	MFW_DRV_MSG_ERROR_RECOVERY,
-	MFW_DRV_MSG_BW_UPDATE,
-	MFW_DRV_MSG_S_TAG_UPDATE,
-	MFW_DRV_MSG_GET_LAN_STATS,
-	MFW_DRV_MSG_GET_FCOE_STATS,
-	MFW_DRV_MSG_GET_ISCSI_STATS,
-	MFW_DRV_MSG_GET_RDMA_STATS,
-	MFW_DRV_MSG_FAILURE_DETECTED,
-	MFW_DRV_MSG_TRANSCEIVER_STATE_CHANGE,
-	MFW_DRV_MSG_CRITICAL_ERROR_OCCURRED,
-	MFW_DRV_MSG_RESERVED,
-	MFW_DRV_MSG_GET_TLV_REQ,
-	MFW_DRV_MSG_OEM_CFG_UPDATE,
-	MFW_DRV_MSG_MAX
-};
-
-#define MFW_DRV_MSG_MAX_DWORDS(msgs)	(((msgs - 1) >> 2) + 1)
-#define MFW_DRV_MSG_DWORD(msg_id)	(msg_id >> 2)
-#define MFW_DRV_MSG_OFFSET(msg_id)	((msg_id & 0x3) << 3)
-#define MFW_DRV_MSG_MASK(msg_id)	(0xff << MFW_DRV_MSG_OFFSET(msg_id))
-
-struct public_mfw_mb {
-	u32 sup_msgs;
-	u32 msg[MFW_DRV_MSG_MAX_DWORDS(MFW_DRV_MSG_MAX)];
-	u32 ack[MFW_DRV_MSG_MAX_DWORDS(MFW_DRV_MSG_MAX)];
-};
-
-enum public_sections {
-	PUBLIC_DRV_MB,
-	PUBLIC_MFW_MB,
-	PUBLIC_GLOBAL,
-	PUBLIC_PATH,
-	PUBLIC_PORT,
-	PUBLIC_FUNC,
-	PUBLIC_MAX_SECTIONS
-};
-
-struct mcp_public_data {
-	u32 num_sections;
-	u32 sections[PUBLIC_MAX_SECTIONS];
-	struct public_drv_mb drv_mb[MCP_GLOB_FUNC_MAX];
-	struct public_mfw_mb mfw_mb[MCP_GLOB_FUNC_MAX];
-	struct public_global global;
-	struct public_path path[MCP_GLOB_PATH_MAX];
-	struct public_port port[MCP_GLOB_PORT_MAX];
-	struct public_func func[MCP_GLOB_FUNC_MAX];
-};
-
-#define MAX_I2C_TRANSACTION_SIZE	16
-
-/* OCBB definitions */
-enum tlvs {
-	/* Category 1: Device Properties */
-	DRV_TLV_CLP_STR,
-	DRV_TLV_CLP_STR_CTD,
-	/* Category 6: Device Configuration */
-	DRV_TLV_SCSI_TO,
-	DRV_TLV_R_T_TOV,
-	DRV_TLV_R_A_TOV,
-	DRV_TLV_E_D_TOV,
-	DRV_TLV_CR_TOV,
-	DRV_TLV_BOOT_TYPE,
-	/* Category 8: Port Configuration */
-	DRV_TLV_NPIV_ENABLED,
-	/* Category 10: Function Configuration */
-	DRV_TLV_FEATURE_FLAGS,
-	DRV_TLV_LOCAL_ADMIN_ADDR,
-	DRV_TLV_ADDITIONAL_MAC_ADDR_1,
-	DRV_TLV_ADDITIONAL_MAC_ADDR_2,
-	DRV_TLV_LSO_MAX_OFFLOAD_SIZE,
-	DRV_TLV_LSO_MIN_SEGMENT_COUNT,
-	DRV_TLV_PROMISCUOUS_MODE,
-	DRV_TLV_TX_DESCRIPTORS_QUEUE_SIZE,
-	DRV_TLV_RX_DESCRIPTORS_QUEUE_SIZE,
-	DRV_TLV_NUM_OF_NET_QUEUE_VMQ_CFG,
-	DRV_TLV_FLEX_NIC_OUTER_VLAN_ID,
-	DRV_TLV_OS_DRIVER_STATES,
-	DRV_TLV_PXE_BOOT_PROGRESS,
-	/* Category 12: FC/FCoE Configuration */
-	DRV_TLV_NPIV_STATE,
-	DRV_TLV_NUM_OF_NPIV_IDS,
-	DRV_TLV_SWITCH_NAME,
-	DRV_TLV_SWITCH_PORT_NUM,
-	DRV_TLV_SWITCH_PORT_ID,
-	DRV_TLV_VENDOR_NAME,
-	DRV_TLV_SWITCH_MODEL,
-	DRV_TLV_SWITCH_FW_VER,
-	DRV_TLV_QOS_PRIORITY_PER_802_1P,
-	DRV_TLV_PORT_ALIAS,
-	DRV_TLV_PORT_STATE,
-	DRV_TLV_FIP_TX_DESCRIPTORS_QUEUE_SIZE,
-	DRV_TLV_FCOE_RX_DESCRIPTORS_QUEUE_SIZE,
-	DRV_TLV_LINK_FAILURE_COUNT,
-	DRV_TLV_FCOE_BOOT_PROGRESS,
-	/* Category 13: iSCSI Configuration */
-	DRV_TLV_TARGET_LLMNR_ENABLED,
-	DRV_TLV_HEADER_DIGEST_FLAG_ENABLED,
-	DRV_TLV_DATA_DIGEST_FLAG_ENABLED,
-	DRV_TLV_AUTHENTICATION_METHOD,
-	DRV_TLV_ISCSI_BOOT_TARGET_PORTAL,
-	DRV_TLV_MAX_FRAME_SIZE,
-	DRV_TLV_PDU_TX_DESCRIPTORS_QUEUE_SIZE,
-	DRV_TLV_PDU_RX_DESCRIPTORS_QUEUE_SIZE,
-	DRV_TLV_ISCSI_BOOT_PROGRESS,
-	/* Category 20: Device Data */
-	DRV_TLV_PCIE_BUS_RX_UTILIZATION,
-	DRV_TLV_PCIE_BUS_TX_UTILIZATION,
-	DRV_TLV_DEVICE_CPU_CORES_UTILIZATION,
-	DRV_TLV_LAST_VALID_DCC_TLV_RECEIVED,
-	DRV_TLV_NCSI_RX_BYTES_RECEIVED,
-	DRV_TLV_NCSI_TX_BYTES_SENT,
-	/* Category 22: Base Port Data */
-	DRV_TLV_RX_DISCARDS,
-	DRV_TLV_RX_ERRORS,
-	DRV_TLV_TX_ERRORS,
-	DRV_TLV_TX_DISCARDS,
-	DRV_TLV_RX_FRAMES_RECEIVED,
-	DRV_TLV_TX_FRAMES_SENT,
-	/* Category 23: FC/FCoE Port Data */
-	DRV_TLV_RX_BROADCAST_PACKETS,
-	DRV_TLV_TX_BROADCAST_PACKETS,
-	/* Category 28: Base Function Data */
-	DRV_TLV_NUM_OFFLOADED_CONNECTIONS_TCP_IPV4,
-	DRV_TLV_NUM_OFFLOADED_CONNECTIONS_TCP_IPV6,
-	DRV_TLV_TX_DESCRIPTOR_QUEUE_AVG_DEPTH,
-	DRV_TLV_RX_DESCRIPTORS_QUEUE_AVG_DEPTH,
-	DRV_TLV_PF_RX_FRAMES_RECEIVED,
-	DRV_TLV_RX_BYTES_RECEIVED,
-	DRV_TLV_PF_TX_FRAMES_SENT,
-	DRV_TLV_TX_BYTES_SENT,
-	DRV_TLV_IOV_OFFLOAD,
-	DRV_TLV_PCI_ERRORS_CAP_ID,
-	DRV_TLV_UNCORRECTABLE_ERROR_STATUS,
-	DRV_TLV_UNCORRECTABLE_ERROR_MASK,
-	DRV_TLV_CORRECTABLE_ERROR_STATUS,
-	DRV_TLV_CORRECTABLE_ERROR_MASK,
-	DRV_TLV_PCI_ERRORS_AECC_REGISTER,
-	DRV_TLV_TX_QUEUES_EMPTY,
-	DRV_TLV_RX_QUEUES_EMPTY,
-	DRV_TLV_TX_QUEUES_FULL,
-	DRV_TLV_RX_QUEUES_FULL,
-	/* Category 29: FC/FCoE Function Data */
-	DRV_TLV_FCOE_TX_DESCRIPTOR_QUEUE_AVG_DEPTH,
-	DRV_TLV_FCOE_RX_DESCRIPTORS_QUEUE_AVG_DEPTH,
-	DRV_TLV_FCOE_RX_FRAMES_RECEIVED,
-	DRV_TLV_FCOE_RX_BYTES_RECEIVED,
-	DRV_TLV_FCOE_TX_FRAMES_SENT,
-	DRV_TLV_FCOE_TX_BYTES_SENT,
-	DRV_TLV_CRC_ERROR_COUNT,
-	DRV_TLV_CRC_ERROR_1_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_CRC_ERROR_1_TIMESTAMP,
-	DRV_TLV_CRC_ERROR_2_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_CRC_ERROR_2_TIMESTAMP,
-	DRV_TLV_CRC_ERROR_3_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_CRC_ERROR_3_TIMESTAMP,
-	DRV_TLV_CRC_ERROR_4_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_CRC_ERROR_4_TIMESTAMP,
-	DRV_TLV_CRC_ERROR_5_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_CRC_ERROR_5_TIMESTAMP,
-	DRV_TLV_LOSS_OF_SYNC_ERROR_COUNT,
-	DRV_TLV_LOSS_OF_SIGNAL_ERRORS,
-	DRV_TLV_PRIMITIVE_SEQUENCE_PROTOCOL_ERROR_COUNT,
-	DRV_TLV_DISPARITY_ERROR_COUNT,
-	DRV_TLV_CODE_VIOLATION_ERROR_COUNT,
-	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_1,
-	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_2,
-	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_3,
-	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_4,
-	DRV_TLV_LAST_FLOGI_TIMESTAMP,
-	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_1,
-	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_2,
-	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_3,
-	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_4,
-	DRV_TLV_LAST_FLOGI_ACC_TIMESTAMP,
-	DRV_TLV_LAST_FLOGI_RJT,
-	DRV_TLV_LAST_FLOGI_RJT_TIMESTAMP,
-	DRV_TLV_FDISCS_SENT_COUNT,
-	DRV_TLV_FDISC_ACCS_RECEIVED,
-	DRV_TLV_FDISC_RJTS_RECEIVED,
-	DRV_TLV_PLOGI_SENT_COUNT,
-	DRV_TLV_PLOGI_ACCS_RECEIVED,
-	DRV_TLV_PLOGI_RJTS_RECEIVED,
-	DRV_TLV_PLOGI_1_SENT_DESTINATION_FC_ID,
-	DRV_TLV_PLOGI_1_TIMESTAMP,
-	DRV_TLV_PLOGI_2_SENT_DESTINATION_FC_ID,
-	DRV_TLV_PLOGI_2_TIMESTAMP,
-	DRV_TLV_PLOGI_3_SENT_DESTINATION_FC_ID,
-	DRV_TLV_PLOGI_3_TIMESTAMP,
-	DRV_TLV_PLOGI_4_SENT_DESTINATION_FC_ID,
-	DRV_TLV_PLOGI_4_TIMESTAMP,
-	DRV_TLV_PLOGI_5_SENT_DESTINATION_FC_ID,
-	DRV_TLV_PLOGI_5_TIMESTAMP,
-	DRV_TLV_PLOGI_1_ACC_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_PLOGI_1_ACC_TIMESTAMP,
-	DRV_TLV_PLOGI_2_ACC_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_PLOGI_2_ACC_TIMESTAMP,
-	DRV_TLV_PLOGI_3_ACC_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_PLOGI_3_ACC_TIMESTAMP,
-	DRV_TLV_PLOGI_4_ACC_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_PLOGI_4_ACC_TIMESTAMP,
-	DRV_TLV_PLOGI_5_ACC_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_PLOGI_5_ACC_TIMESTAMP,
-	DRV_TLV_LOGOS_ISSUED,
-	DRV_TLV_LOGO_ACCS_RECEIVED,
-	DRV_TLV_LOGO_RJTS_RECEIVED,
-	DRV_TLV_LOGO_1_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_LOGO_1_TIMESTAMP,
-	DRV_TLV_LOGO_2_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_LOGO_2_TIMESTAMP,
-	DRV_TLV_LOGO_3_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_LOGO_3_TIMESTAMP,
-	DRV_TLV_LOGO_4_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_LOGO_4_TIMESTAMP,
-	DRV_TLV_LOGO_5_RECEIVED_SOURCE_FC_ID,
-	DRV_TLV_LOGO_5_TIMESTAMP,
-	DRV_TLV_LOGOS_RECEIVED,
-	DRV_TLV_ACCS_ISSUED,
-	DRV_TLV_PRLIS_ISSUED,
-	DRV_TLV_ACCS_RECEIVED,
-	DRV_TLV_ABTS_SENT_COUNT,
-	DRV_TLV_ABTS_ACCS_RECEIVED,
-	DRV_TLV_ABTS_RJTS_RECEIVED,
-	DRV_TLV_ABTS_1_SENT_DESTINATION_FC_ID,
-	DRV_TLV_ABTS_1_TIMESTAMP,
-	DRV_TLV_ABTS_2_SENT_DESTINATION_FC_ID,
-	DRV_TLV_ABTS_2_TIMESTAMP,
-	DRV_TLV_ABTS_3_SENT_DESTINATION_FC_ID,
-	DRV_TLV_ABTS_3_TIMESTAMP,
-	DRV_TLV_ABTS_4_SENT_DESTINATION_FC_ID,
-	DRV_TLV_ABTS_4_TIMESTAMP,
-	DRV_TLV_ABTS_5_SENT_DESTINATION_FC_ID,
-	DRV_TLV_ABTS_5_TIMESTAMP,
-	DRV_TLV_RSCNS_RECEIVED,
-	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_1,
-	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_2,
-	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_3,
-	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_4,
-	DRV_TLV_LUN_RESETS_ISSUED,
-	DRV_TLV_ABORT_TASK_SETS_ISSUED,
-	DRV_TLV_TPRLOS_SENT,
-	DRV_TLV_NOS_SENT_COUNT,
-	DRV_TLV_NOS_RECEIVED_COUNT,
-	DRV_TLV_OLS_COUNT,
-	DRV_TLV_LR_COUNT,
-	DRV_TLV_LRR_COUNT,
-	DRV_TLV_LIP_SENT_COUNT,
-	DRV_TLV_LIP_RECEIVED_COUNT,
-	DRV_TLV_EOFA_COUNT,
-	DRV_TLV_EOFNI_COUNT,
-	DRV_TLV_SCSI_STATUS_CHECK_CONDITION_COUNT,
-	DRV_TLV_SCSI_STATUS_CONDITION_MET_COUNT,
-	DRV_TLV_SCSI_STATUS_BUSY_COUNT,
-	DRV_TLV_SCSI_STATUS_INTERMEDIATE_COUNT,
-	DRV_TLV_SCSI_STATUS_INTERMEDIATE_CONDITION_MET_COUNT,
-	DRV_TLV_SCSI_STATUS_RESERVATION_CONFLICT_COUNT,
-	DRV_TLV_SCSI_STATUS_TASK_SET_FULL_COUNT,
-	DRV_TLV_SCSI_STATUS_ACA_ACTIVE_COUNT,
-	DRV_TLV_SCSI_STATUS_TASK_ABORTED_COUNT,
-	DRV_TLV_SCSI_CHECK_CONDITION_1_RECEIVED_SK_ASC_ASCQ,
-	DRV_TLV_SCSI_CHECK_1_TIMESTAMP,
-	DRV_TLV_SCSI_CHECK_CONDITION_2_RECEIVED_SK_ASC_ASCQ,
-	DRV_TLV_SCSI_CHECK_2_TIMESTAMP,
-	DRV_TLV_SCSI_CHECK_CONDITION_3_RECEIVED_SK_ASC_ASCQ,
-	DRV_TLV_SCSI_CHECK_3_TIMESTAMP,
-	DRV_TLV_SCSI_CHECK_CONDITION_4_RECEIVED_SK_ASC_ASCQ,
-	DRV_TLV_SCSI_CHECK_4_TIMESTAMP,
-	DRV_TLV_SCSI_CHECK_CONDITION_5_RECEIVED_SK_ASC_ASCQ,
-	DRV_TLV_SCSI_CHECK_5_TIMESTAMP,
-	/* Category 30: iSCSI Function Data */
-	DRV_TLV_PDU_TX_DESCRIPTOR_QUEUE_AVG_DEPTH,
-	DRV_TLV_PDU_RX_DESCRIPTORS_QUEUE_AVG_DEPTH,
-	DRV_TLV_ISCSI_PDU_RX_FRAMES_RECEIVED,
-	DRV_TLV_ISCSI_PDU_RX_BYTES_RECEIVED,
-	DRV_TLV_ISCSI_PDU_TX_FRAMES_SENT,
-	DRV_TLV_ISCSI_PDU_TX_BYTES_SENT
-};
-
-struct nvm_cfg_mac_address {
-	u32							mac_addr_hi;
-#define NVM_CFG_MAC_ADDRESS_HI_MASK				0x0000ffff
-#define NVM_CFG_MAC_ADDRESS_HI_OFFSET				0
-
-	u32							mac_addr_lo;
-};
-
-struct nvm_cfg1_glob {
-	u32							generic_cont0;
-#define NVM_CFG1_GLOB_MF_MODE_MASK				0x00000ff0
-#define NVM_CFG1_GLOB_MF_MODE_OFFSET				4
-#define NVM_CFG1_GLOB_MF_MODE_MF_ALLOWED			0x0
-#define NVM_CFG1_GLOB_MF_MODE_DEFAULT				0x1
-#define NVM_CFG1_GLOB_MF_MODE_SPIO4				0x2
-#define NVM_CFG1_GLOB_MF_MODE_NPAR1_0				0x3
-#define NVM_CFG1_GLOB_MF_MODE_NPAR1_5				0x4
-#define NVM_CFG1_GLOB_MF_MODE_NPAR2_0				0x5
-#define NVM_CFG1_GLOB_MF_MODE_BD				0x6
-#define NVM_CFG1_GLOB_MF_MODE_UFP				0x7
-
-	u32							engineering_change[3];
-	u32							manufacturing_id;
-	u32							serial_number[4];
-	u32							pcie_cfg;
-	u32							mgmt_traffic;
-
-	u32							core_cfg;
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_MASK			0x000000ff
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_OFFSET			0
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_2X40G		0x0
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_2X50G			0x1
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_1X100G		0x2
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_4X10G_F			0x3
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_4X10G_E		0x4
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_4X20G		0x5
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_1X40G			0xb
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_2X25G			0xc
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_1X25G			0xd
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_4X25G			0xe
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_2X10G			0xf
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_2X50G_R1		0x11
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_4X50G_R1		0x12
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_1X100G_R2		0x13
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_2X100G_R2		0x14
-#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_1X100G_R4		0x15
-
-	u32							e_lane_cfg1;
-	u32							e_lane_cfg2;
-	u32							f_lane_cfg1;
-	u32							f_lane_cfg2;
-	u32							mps10_preemphasis;
-	u32							mps10_driver_current;
-	u32							mps25_preemphasis;
-	u32							mps25_driver_current;
-	u32							pci_id;
-	u32							pci_subsys_id;
-	u32							bar;
-	u32							mps10_txfir_main;
-	u32							mps10_txfir_post;
-	u32							mps25_txfir_main;
-	u32							mps25_txfir_post;
-	u32							manufacture_ver;
-	u32							manufacture_time;
-	u32							led_global_settings;
-	u32							generic_cont1;
-
-	u32							mbi_version;
-#define NVM_CFG1_GLOB_MBI_VERSION_0_MASK			0x000000ff
-#define NVM_CFG1_GLOB_MBI_VERSION_0_OFFSET			0
-#define NVM_CFG1_GLOB_MBI_VERSION_1_MASK			0x0000ff00
-#define NVM_CFG1_GLOB_MBI_VERSION_1_OFFSET			8
-#define NVM_CFG1_GLOB_MBI_VERSION_2_MASK			0x00ff0000
-#define NVM_CFG1_GLOB_MBI_VERSION_2_OFFSET			16
-
-	u32							mbi_date;
-	u32							misc_sig;
-
-	u32							device_capabilities;
-#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_ETHERNET		0x1
-#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_FCOE			0x2
-#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_ISCSI			0x4
-#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_ROCE			0x8
-
-	u32							power_dissipated;
-	u32							power_consumed;
-	u32							efi_version;
-	u32							multi_net_modes_cap;
-	u32							reserved[41];
-};
-
-struct nvm_cfg1_path {
-	u32							reserved[30];
-};
-
-struct nvm_cfg1_port {
-	u32							rel_to_opt123;
-	u32							rel_to_opt124;
-
-	u32							generic_cont0;
-#define NVM_CFG1_PORT_DCBX_MODE_MASK				0x000f0000
-#define NVM_CFG1_PORT_DCBX_MODE_OFFSET				16
-#define NVM_CFG1_PORT_DCBX_MODE_DISABLED			0x0
-#define NVM_CFG1_PORT_DCBX_MODE_IEEE				0x1
-#define NVM_CFG1_PORT_DCBX_MODE_CEE				0x2
-#define NVM_CFG1_PORT_DCBX_MODE_DYNAMIC				0x3
-#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_MASK		0x00f00000
-#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_OFFSET		20
-#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_ETHERNET	0x1
-#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_FCOE		0x2
-#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_ISCSI		0x4
-
-	u32							pcie_cfg;
-	u32							features;
-
-	u32							speed_cap_mask;
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_MASK		0x0000ffff
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_OFFSET		0
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_1G		0x1
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_10G		0x2
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_20G		0x4
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_25G		0x8
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_40G		0x10
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_50G		0x20
-#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_BB_100G		0x40
-
-	u32							link_settings;
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_MASK			0x0000000f
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_OFFSET			0
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_AUTONEG			0x0
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_1G				0x1
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_10G			0x2
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_20G			0x3
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_25G			0x4
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_40G			0x5
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_50G			0x6
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_BB_100G			0x7
-#define NVM_CFG1_PORT_DRV_LINK_SPEED_SMARTLINQ			0x8
-#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_MASK			0x00000070
-#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_OFFSET			4
-#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_AUTONEG			0x1
-#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_RX			0x2
-#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_TX			0x4
-#define NVM_CFG1_PORT_FEC_FORCE_MODE_MASK			0x000e0000
-#define NVM_CFG1_PORT_FEC_FORCE_MODE_OFFSET			17
-#define NVM_CFG1_PORT_FEC_FORCE_MODE_NONE			0x0
-#define NVM_CFG1_PORT_FEC_FORCE_MODE_FIRECODE			0x1
-#define NVM_CFG1_PORT_FEC_FORCE_MODE_RS				0x2
-#define NVM_CFG1_PORT_FEC_FORCE_MODE_AUTO			0x7
-
-	u32							phy_cfg;
-	u32							mgmt_traffic;
-
-	u32							ext_phy;
-	/* EEE power saving mode */
-#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_MASK		0x00ff0000
-#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_OFFSET		16
-#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_DISABLED		0x0
-#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_BALANCED		0x1
-#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_AGGRESSIVE		0x2
-#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_LOW_LATENCY		0x3
-
-	u32							mba_cfg1;
-	u32							mba_cfg2;
-	u32							vf_cfg;
-	struct nvm_cfg_mac_address				lldp_mac_address;
-	u32							led_port_settings;
-	u32							transceiver_00;
-	u32							device_ids;
-
-	u32							board_cfg;
-#define NVM_CFG1_PORT_PORT_TYPE_MASK				0x000000ff
-#define NVM_CFG1_PORT_PORT_TYPE_OFFSET				0
-#define NVM_CFG1_PORT_PORT_TYPE_UNDEFINED			0x0
-#define NVM_CFG1_PORT_PORT_TYPE_MODULE				0x1
-#define NVM_CFG1_PORT_PORT_TYPE_BACKPLANE			0x2
-#define NVM_CFG1_PORT_PORT_TYPE_EXT_PHY				0x3
-#define NVM_CFG1_PORT_PORT_TYPE_MODULE_SLAVE			0x4
-
-	u32							mnm_10g_cap;
-	u32							mnm_10g_ctrl;
-	u32							mnm_10g_misc;
-	u32							mnm_25g_cap;
-	u32							mnm_25g_ctrl;
-	u32							mnm_25g_misc;
-	u32							mnm_40g_cap;
-	u32							mnm_40g_ctrl;
-	u32							mnm_40g_misc;
-	u32							mnm_50g_cap;
-	u32							mnm_50g_ctrl;
-	u32							mnm_50g_misc;
-	u32							mnm_100g_cap;
-	u32							mnm_100g_ctrl;
-	u32							mnm_100g_misc;
-
-	u32							temperature;
-	u32							ext_phy_cfg1;
-
-	u32							extended_speed;
-#define NVM_CFG1_PORT_EXTENDED_SPEED_MASK			0x0000ffff
-#define NVM_CFG1_PORT_EXTENDED_SPEED_OFFSET			0
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_AN		0x1
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_1G		0x2
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_10G		0x4
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_20G		0x8
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_25G		0x10
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_40G		0x20
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R		0x40
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R2		0x80
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R2		0x100
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R4		0x200
-#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_P4		0x400
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_MASK			0xffff0000
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_OFFSET			16
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_RESERVED	0x1
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_1G		0x2
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_10G		0x4
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_20G		0x8
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_25G		0x10
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_40G		0x20
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R	0x40
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R2	0x80
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R2	0x100
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R4	0x200
-#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_P4	0x400
-
-	u32							extended_fec_mode;
-
-	u32							reserved[112];
-};
-
-struct nvm_cfg1_func {
-	struct nvm_cfg_mac_address mac_address;
-	u32 rsrv1;
-	u32 rsrv2;
-	u32 device_id;
-	u32 cmn_cfg;
-	u32 pci_cfg;
-	struct nvm_cfg_mac_address fcoe_node_wwn_mac_addr;
-	struct nvm_cfg_mac_address fcoe_port_wwn_mac_addr;
-	u32 preboot_generic_cfg;
-	u32 reserved[8];
-};
-
-struct nvm_cfg1 {
-	struct nvm_cfg1_glob glob;
-	struct nvm_cfg1_path path[MCP_GLOB_PATH_MAX];
-	struct nvm_cfg1_port port[MCP_GLOB_PORT_MAX];
-	struct nvm_cfg1_func func[MCP_GLOB_FUNC_MAX];
-};
-
-enum spad_sections {
-	SPAD_SECTION_TRACE,
-	SPAD_SECTION_NVM_CFG,
-	SPAD_SECTION_PUBLIC,
-	SPAD_SECTION_PRIVATE,
-	SPAD_SECTION_MAX
-};
-
-#define MCP_TRACE_SIZE          2048	/* 2kb */
-
-/* This section is located at a fixed location in the beginning of the
- * scratchpad, to ensure that the MCP trace is not run over during MFW upgrade.
- * All the rest of data has a floating location which differs from version to
- * version, and is pointed by the mcp_meta_data below.
- * Moreover, the spad_layout section is part of the MFW firmware, and is loaded
- * with it from nvram in order to clear this portion.
- */
-struct static_init {
-	u32 num_sections;
-	offsize_t sections[SPAD_SECTION_MAX];
-#define SECTION(_sec_) (*((offsize_t *)(STRUCT_OFFSET(sections[_sec_]))))
-
-	struct mcp_trace trace;
-#define MCP_TRACE_P ((struct mcp_trace *)(STRUCT_OFFSET(trace)))
-	u8 trace_buffer[MCP_TRACE_SIZE];
-#define MCP_TRACE_BUF ((u8 *)(STRUCT_OFFSET(trace_buffer)))
-	/* running_mfw has the same definition as in nvm_map.h.
-	 * This bit indicate both the running dir, and the running bundle.
-	 * It is set once when the LIM is loaded.
-	 */
-	u32 running_mfw;
-#define RUNNING_MFW (*((u32 *)(STRUCT_OFFSET(running_mfw))))
-	u32 build_time;
-#define MFW_BUILD_TIME (*((u32 *)(STRUCT_OFFSET(build_time))))
-	u32 reset_type;
-#define RESET_TYPE (*((u32 *)(STRUCT_OFFSET(reset_type))))
-	u32 mfw_secure_mode;
-#define MFW_SECURE_MODE (*((u32 *)(STRUCT_OFFSET(mfw_secure_mode))))
-	u16 pme_status_pf_bitmap;
-#define PME_STATUS_PF_BITMAP (*((u16 *)(STRUCT_OFFSET(pme_status_pf_bitmap))))
-	u16 pme_enable_pf_bitmap;
-#define PME_ENABLE_PF_BITMAP (*((u16 *)(STRUCT_OFFSET(pme_enable_pf_bitmap))))
-	u32 mim_nvm_addr;
-	u32 mim_start_addr;
-	u32 ah_pcie_link_params;
-#define AH_PCIE_LINK_PARAMS_LINK_SPEED_MASK     (0x000000ff)
-#define AH_PCIE_LINK_PARAMS_LINK_SPEED_SHIFT    (0)
-#define AH_PCIE_LINK_PARAMS_LINK_WIDTH_MASK     (0x0000ff00)
-#define AH_PCIE_LINK_PARAMS_LINK_WIDTH_SHIFT    (8)
-#define AH_PCIE_LINK_PARAMS_ASPM_MODE_MASK      (0x00ff0000)
-#define AH_PCIE_LINK_PARAMS_ASPM_MODE_SHIFT     (16)
-#define AH_PCIE_LINK_PARAMS_ASPM_CAP_MASK       (0xff000000)
-#define AH_PCIE_LINK_PARAMS_ASPM_CAP_SHIFT      (24)
-#define AH_PCIE_LINK_PARAMS (*((u32 *)(STRUCT_OFFSET(ah_pcie_link_params))))
-
-	u32 rsrv_persist[5];	/* Persist reserved for MFW upgrades */
-};
-
-#define NVM_MAGIC_VALUE		0x669955aa
-
-enum nvm_image_type {
-	NVM_TYPE_TIM1 = 0x01,
-	NVM_TYPE_TIM2 = 0x02,
-	NVM_TYPE_MIM1 = 0x03,
-	NVM_TYPE_MIM2 = 0x04,
-	NVM_TYPE_MBA = 0x05,
-	NVM_TYPE_MODULES_PN = 0x06,
-	NVM_TYPE_VPD = 0x07,
-	NVM_TYPE_MFW_TRACE1 = 0x08,
-	NVM_TYPE_MFW_TRACE2 = 0x09,
-	NVM_TYPE_NVM_CFG1 = 0x0a,
-	NVM_TYPE_L2B = 0x0b,
-	NVM_TYPE_DIR1 = 0x0c,
-	NVM_TYPE_EAGLE_FW1 = 0x0d,
-	NVM_TYPE_FALCON_FW1 = 0x0e,
-	NVM_TYPE_PCIE_FW1 = 0x0f,
-	NVM_TYPE_HW_SET = 0x10,
-	NVM_TYPE_LIM = 0x11,
-	NVM_TYPE_AVS_FW1 = 0x12,
-	NVM_TYPE_DIR2 = 0x13,
-	NVM_TYPE_CCM = 0x14,
-	NVM_TYPE_EAGLE_FW2 = 0x15,
-	NVM_TYPE_FALCON_FW2 = 0x16,
-	NVM_TYPE_PCIE_FW2 = 0x17,
-	NVM_TYPE_AVS_FW2 = 0x18,
-	NVM_TYPE_INIT_HW = 0x19,
-	NVM_TYPE_DEFAULT_CFG = 0x1a,
-	NVM_TYPE_MDUMP = 0x1b,
-	NVM_TYPE_META = 0x1c,
-	NVM_TYPE_ISCSI_CFG = 0x1d,
-	NVM_TYPE_FCOE_CFG = 0x1f,
-	NVM_TYPE_ETH_PHY_FW1 = 0x20,
-	NVM_TYPE_ETH_PHY_FW2 = 0x21,
-	NVM_TYPE_BDN = 0x22,
-	NVM_TYPE_8485X_PHY_FW = 0x23,
-	NVM_TYPE_PUB_KEY = 0x24,
-	NVM_TYPE_RECOVERY = 0x25,
-	NVM_TYPE_PLDM = 0x26,
-	NVM_TYPE_UPK1 = 0x27,
-	NVM_TYPE_UPK2 = 0x28,
-	NVM_TYPE_MASTER_KC = 0x29,
-	NVM_TYPE_BACKUP_KC = 0x2a,
-	NVM_TYPE_HW_DUMP = 0x2b,
-	NVM_TYPE_HW_DUMP_OUT = 0x2c,
-	NVM_TYPE_BIN_NVM_META = 0x30,
-	NVM_TYPE_ROM_TEST = 0xf0,
-	NVM_TYPE_88X33X0_PHY_FW = 0x31,
-	NVM_TYPE_88X33X0_PHY_SLAVE_FW = 0x32,
-	NVM_TYPE_MAX,
-};
-
-#define DIR_ID_1    (0)
-
 #endif
diff --git a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
index 30c0b5502670..7dad91049cc0 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c
@@ -13,6 +13,7 @@
 #include "qed_hsi.h"
 #include "qed_hw.h"
 #include "qed_init_ops.h"
+#include "qed_iro_hsi.h"
 #include "qed_reg_addr.h"
 
 #define CDU_VALIDATION_DEFAULT_CFG	61
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iro_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_iro_hsi.h
new file mode 100644
index 000000000000..4999d524930f
--- /dev/null
+++ b/drivers/net/ethernet/qlogic/qed/qed_iro_hsi.h
@@ -0,0 +1,339 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/* QLogic qed NIC Driver
+ * Copyright (c) 2019-2021 Marvell International Ltd.
+ */
+
+#ifndef _QED_IRO_HSI_H
+#define _QED_IRO_HSI_H
+
+#include <linux/types.h>
+
+/* Ystorm flow control mode. Use enum fw_flow_ctrl_mode */
+#define YSTORM_FLOW_CONTROL_MODE_OFFSET			(IRO[0].base)
+#define YSTORM_FLOW_CONTROL_MODE_SIZE			(IRO[0].size)
+
+/* Tstorm port statistics */
+#define TSTORM_PORT_STAT_OFFSET(port_id) \
+	(IRO[1].base + ((port_id) * IRO[1].m1))
+#define TSTORM_PORT_STAT_SIZE				(IRO[1].size)
+
+/* Tstorm ll2 port statistics */
+#define TSTORM_LL2_PORT_STAT_OFFSET(port_id) \
+	(IRO[2].base + ((port_id) * IRO[2].m1))
+#define TSTORM_LL2_PORT_STAT_SIZE			(IRO[2].size)
+
+/* Ustorm VF-PF Channel ready flag */
+#define USTORM_VF_PF_CHANNEL_READY_OFFSET(vf_id) \
+	(IRO[3].base + ((vf_id) * IRO[3].m1))
+#define USTORM_VF_PF_CHANNEL_READY_SIZE			(IRO[3].size)
+
+/* Ustorm Final flr cleanup ack */
+#define USTORM_FLR_FINAL_ACK_OFFSET(pf_id) \
+	(IRO[4].base + ((pf_id) * IRO[4].m1))
+#define USTORM_FLR_FINAL_ACK_SIZE			(IRO[4].size)
+
+/* Ustorm Event ring consumer */
+#define USTORM_EQE_CONS_OFFSET(pf_id) \
+	(IRO[5].base + ((pf_id) * IRO[5].m1))
+#define USTORM_EQE_CONS_SIZE				(IRO[5].size)
+
+/* Ustorm eth queue zone */
+#define USTORM_ETH_QUEUE_ZONE_OFFSET(queue_zone_id) \
+	(IRO[6].base + ((queue_zone_id) * IRO[6].m1))
+#define USTORM_ETH_QUEUE_ZONE_SIZE			(IRO[6].size)
+
+/* Ustorm Common Queue ring consumer */
+#define USTORM_COMMON_QUEUE_CONS_OFFSET(queue_zone_id) \
+	(IRO[7].base + ((queue_zone_id) * IRO[7].m1))
+#define USTORM_COMMON_QUEUE_CONS_SIZE			(IRO[7].size)
+
+/* Xstorm common PQ info */
+#define XSTORM_PQ_INFO_OFFSET(pq_id) \
+	(IRO[8].base + ((pq_id) * IRO[8].m1))
+#define XSTORM_PQ_INFO_SIZE				(IRO[8].size)
+
+/* Xstorm Integration Test Data */
+#define XSTORM_INTEG_TEST_DATA_OFFSET			(IRO[9].base)
+#define XSTORM_INTEG_TEST_DATA_SIZE			(IRO[9].size)
+
+/* Ystorm Integration Test Data */
+#define YSTORM_INTEG_TEST_DATA_OFFSET			(IRO[10].base)
+#define YSTORM_INTEG_TEST_DATA_SIZE			(IRO[10].size)
+
+/* Pstorm Integration Test Data */
+#define PSTORM_INTEG_TEST_DATA_OFFSET			(IRO[11].base)
+#define PSTORM_INTEG_TEST_DATA_SIZE			(IRO[11].size)
+
+/* Tstorm Integration Test Data */
+#define TSTORM_INTEG_TEST_DATA_OFFSET			(IRO[12].base)
+#define TSTORM_INTEG_TEST_DATA_SIZE			(IRO[12].size)
+
+/* Mstorm Integration Test Data */
+#define MSTORM_INTEG_TEST_DATA_OFFSET			(IRO[13].base)
+#define MSTORM_INTEG_TEST_DATA_SIZE			(IRO[13].size)
+
+/* Ustorm Integration Test Data */
+#define USTORM_INTEG_TEST_DATA_OFFSET			(IRO[14].base)
+#define USTORM_INTEG_TEST_DATA_SIZE			(IRO[14].size)
+
+/* Xstorm overlay buffer host address */
+#define XSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[15].base)
+#define XSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[15].size)
+
+/* Ystorm overlay buffer host address */
+#define YSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[16].base)
+#define YSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[16].size)
+
+/* Pstorm overlay buffer host address */
+#define PSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[17].base)
+#define PSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[17].size)
+
+/* Tstorm overlay buffer host address */
+#define TSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[18].base)
+#define TSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[18].size)
+
+/* Mstorm overlay buffer host address */
+#define MSTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[19].base)
+#define MSTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[19].size)
+
+/* Ustorm overlay buffer host address */
+#define USTORM_OVERLAY_BUF_ADDR_OFFSET			(IRO[20].base)
+#define USTORM_OVERLAY_BUF_ADDR_SIZE			(IRO[20].size)
+
+/* Tstorm producers */
+#define TSTORM_LL2_RX_PRODS_OFFSET(core_rx_queue_id) \
+	(IRO[21].base + ((core_rx_queue_id) * IRO[21].m1))
+#define TSTORM_LL2_RX_PRODS_SIZE			(IRO[21].size)
+
+/* Tstorm LightL2 queue statistics */
+#define CORE_LL2_TSTORM_PER_QUEUE_STAT_OFFSET(core_rx_queue_id) \
+	(IRO[22].base + ((core_rx_queue_id) * IRO[22].m1))
+#define CORE_LL2_TSTORM_PER_QUEUE_STAT_SIZE		(IRO[22].size)
+
+/* Ustorm LiteL2 queue statistics */
+#define CORE_LL2_USTORM_PER_QUEUE_STAT_OFFSET(core_rx_queue_id) \
+	(IRO[23].base + ((core_rx_queue_id) * IRO[23].m1))
+#define CORE_LL2_USTORM_PER_QUEUE_STAT_SIZE		(IRO[23].size)
+
+/* Pstorm LiteL2 queue statistics */
+#define CORE_LL2_PSTORM_PER_QUEUE_STAT_OFFSET(core_tx_stats_id) \
+	(IRO[24].base + ((core_tx_stats_id) * IRO[24].m1))
+#define CORE_LL2_PSTORM_PER_QUEUE_STAT_SIZE		(IRO[24].size)
+
+/* Mstorm queue statistics */
+#define MSTORM_QUEUE_STAT_OFFSET(stat_counter_id) \
+	(IRO[25].base + ((stat_counter_id) * IRO[25].m1))
+#define MSTORM_QUEUE_STAT_SIZE				(IRO[25].size)
+
+/* TPA agregation timeout in us resolution (on ASIC) */
+#define MSTORM_TPA_TIMEOUT_US_OFFSET			(IRO[26].base)
+#define MSTORM_TPA_TIMEOUT_US_SIZE			(IRO[26].size)
+
+/* Mstorm ETH VF queues producers offset in RAM. Used in default VF zone size
+ * mode
+ */
+#define MSTORM_ETH_VF_PRODS_OFFSET(vf_id, vf_queue_id) \
+	(IRO[27].base + ((vf_id) * IRO[27].m1) + ((vf_queue_id) * IRO[27].m2))
+#define MSTORM_ETH_VF_PRODS_SIZE			(IRO[27].size)
+
+/* Mstorm ETH PF queues producers */
+#define MSTORM_ETH_PF_PRODS_OFFSET(queue_id) \
+	(IRO[28].base + ((queue_id) * IRO[28].m1))
+#define MSTORM_ETH_PF_PRODS_SIZE			(IRO[28].size)
+
+/* Mstorm pf statistics */
+#define MSTORM_ETH_PF_STAT_OFFSET(pf_id) \
+	(IRO[29].base + ((pf_id) * IRO[29].m1))
+#define MSTORM_ETH_PF_STAT_SIZE				(IRO[29].size)
+
+/* Ustorm queue statistics */
+#define USTORM_QUEUE_STAT_OFFSET(stat_counter_id) \
+	(IRO[30].base + ((stat_counter_id) * IRO[30].m1))
+#define USTORM_QUEUE_STAT_SIZE				(IRO[30].size)
+
+/* Ustorm pf statistics */
+#define USTORM_ETH_PF_STAT_OFFSET(pf_id) \
+	(IRO[31].base + ((pf_id) * IRO[31].m1))
+#define USTORM_ETH_PF_STAT_SIZE				(IRO[31].size)
+
+/* Pstorm queue statistics */
+#define PSTORM_QUEUE_STAT_OFFSET(stat_counter_id)	\
+	(IRO[32].base + ((stat_counter_id) * IRO[32].m1))
+#define PSTORM_QUEUE_STAT_SIZE				(IRO[32].size)
+
+/* Pstorm pf statistics */
+#define PSTORM_ETH_PF_STAT_OFFSET(pf_id) \
+	(IRO[33].base + ((pf_id) * IRO[33].m1))
+#define PSTORM_ETH_PF_STAT_SIZE				(IRO[33].size)
+
+/* Control frame's EthType configuration for TX control frame security */
+#define PSTORM_CTL_FRAME_ETHTYPE_OFFSET(eth_type_id)	\
+	(IRO[34].base + ((eth_type_id) * IRO[34].m1))
+#define PSTORM_CTL_FRAME_ETHTYPE_SIZE			(IRO[34].size)
+
+/* Tstorm last parser message */
+#define TSTORM_ETH_PRS_INPUT_OFFSET			(IRO[35].base)
+#define TSTORM_ETH_PRS_INPUT_SIZE			(IRO[35].size)
+
+/* Tstorm Eth limit Rx rate */
+#define ETH_RX_RATE_LIMIT_OFFSET(pf_id)	\
+	(IRO[36].base + ((pf_id) * IRO[36].m1))
+#define ETH_RX_RATE_LIMIT_SIZE				(IRO[36].size)
+
+/* RSS indirection table entry update command per PF offset in TSTORM PF BAR0.
+ * Use eth_tstorm_rss_update_data for update
+ */
+#define TSTORM_ETH_RSS_UPDATE_OFFSET(pf_id) \
+	(IRO[37].base + ((pf_id) * IRO[37].m1))
+#define TSTORM_ETH_RSS_UPDATE_SIZE			(IRO[37].size)
+
+/* Xstorm queue zone */
+#define XSTORM_ETH_QUEUE_ZONE_OFFSET(queue_id) \
+	(IRO[38].base + ((queue_id) * IRO[38].m1))
+#define XSTORM_ETH_QUEUE_ZONE_SIZE			(IRO[38].size)
+
+/* Ystorm cqe producer */
+#define YSTORM_TOE_CQ_PROD_OFFSET(rss_id) \
+	(IRO[39].base + ((rss_id) * IRO[39].m1))
+#define YSTORM_TOE_CQ_PROD_SIZE				(IRO[39].size)
+
+/* Ustorm cqe producer */
+#define USTORM_TOE_CQ_PROD_OFFSET(rss_id) \
+	(IRO[40].base + ((rss_id) * IRO[40].m1))
+#define USTORM_TOE_CQ_PROD_SIZE				(IRO[40].size)
+
+/* Ustorm grq producer */
+#define USTORM_TOE_GRQ_PROD_OFFSET(pf_id) \
+	(IRO[41].base + ((pf_id) * IRO[41].m1))
+#define USTORM_TOE_GRQ_PROD_SIZE			(IRO[41].size)
+
+/* Tstorm cmdq-cons of given command queue-id */
+#define TSTORM_SCSI_CMDQ_CONS_OFFSET(cmdq_queue_id) \
+	(IRO[42].base + ((cmdq_queue_id) * IRO[42].m1))
+#define TSTORM_SCSI_CMDQ_CONS_SIZE			(IRO[42].size)
+
+/* Tstorm (reflects M-Storm) bdq-external-producer of given function ID,
+ * BDqueue-id
+ */
+#define TSTORM_SCSI_BDQ_EXT_PROD_OFFSET(storage_func_id, bdq_id) \
+	(IRO[43].base + ((storage_func_id) * IRO[43].m1) + \
+	 ((bdq_id) * IRO[43].m2))
+#define TSTORM_SCSI_BDQ_EXT_PROD_SIZE			(IRO[43].size)
+
+/* Mstorm bdq-external-producer of given BDQ resource ID, BDqueue-id */
+#define MSTORM_SCSI_BDQ_EXT_PROD_OFFSET(storage_func_id, bdq_id) \
+	(IRO[44].base + ((storage_func_id) * IRO[44].m1) + \
+	 ((bdq_id) * IRO[44].m2))
+#define MSTORM_SCSI_BDQ_EXT_PROD_SIZE			(IRO[44].size)
+
+/* Tstorm iSCSI RX stats */
+#define TSTORM_ISCSI_RX_STATS_OFFSET(storage_func_id) \
+	(IRO[45].base + ((storage_func_id) * IRO[45].m1))
+#define TSTORM_ISCSI_RX_STATS_SIZE			(IRO[45].size)
+
+/* Mstorm iSCSI RX stats */
+#define MSTORM_ISCSI_RX_STATS_OFFSET(storage_func_id) \
+	(IRO[46].base + ((storage_func_id) * IRO[46].m1))
+#define MSTORM_ISCSI_RX_STATS_SIZE			(IRO[46].size)
+
+/* Ustorm iSCSI RX stats */
+#define USTORM_ISCSI_RX_STATS_OFFSET(storage_func_id) \
+	(IRO[47].base + ((storage_func_id) * IRO[47].m1))
+#define USTORM_ISCSI_RX_STATS_SIZE			(IRO[47].size)
+
+/* Xstorm iSCSI TX stats */
+#define XSTORM_ISCSI_TX_STATS_OFFSET(storage_func_id) \
+	(IRO[48].base + ((storage_func_id) * IRO[48].m1))
+#define XSTORM_ISCSI_TX_STATS_SIZE			(IRO[48].size)
+
+/* Ystorm iSCSI TX stats */
+#define YSTORM_ISCSI_TX_STATS_OFFSET(storage_func_id) \
+	(IRO[49].base + ((storage_func_id) * IRO[49].m1))
+#define YSTORM_ISCSI_TX_STATS_SIZE			(IRO[49].size)
+
+/* Pstorm iSCSI TX stats */
+#define PSTORM_ISCSI_TX_STATS_OFFSET(storage_func_id) \
+	(IRO[50].base + ((storage_func_id) * IRO[50].m1))
+#define PSTORM_ISCSI_TX_STATS_SIZE			(IRO[50].size)
+
+/* Tstorm FCoE RX stats */
+#define TSTORM_FCOE_RX_STATS_OFFSET(pf_id) \
+	(IRO[51].base + ((pf_id) * IRO[51].m1))
+#define TSTORM_FCOE_RX_STATS_SIZE			(IRO[51].size)
+
+/* Pstorm FCoE TX stats */
+#define PSTORM_FCOE_TX_STATS_OFFSET(pf_id) \
+	(IRO[52].base + ((pf_id) * IRO[52].m1))
+#define PSTORM_FCOE_TX_STATS_SIZE			(IRO[52].size)
+
+/* Pstorm RDMA queue statistics */
+#define PSTORM_RDMA_QUEUE_STAT_OFFSET(rdma_stat_counter_id) \
+	(IRO[53].base + ((rdma_stat_counter_id) * IRO[53].m1))
+#define PSTORM_RDMA_QUEUE_STAT_SIZE			(IRO[53].size)
+
+/* Tstorm RDMA queue statistics */
+#define TSTORM_RDMA_QUEUE_STAT_OFFSET(rdma_stat_counter_id) \
+	(IRO[54].base + ((rdma_stat_counter_id) * IRO[54].m1))
+#define TSTORM_RDMA_QUEUE_STAT_SIZE			(IRO[54].size)
+
+/* Xstorm error level for assert */
+#define XSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
+	(IRO[55].base + ((pf_id) * IRO[55].m1))
+#define XSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[55].size)
+
+/* Ystorm error level for assert */
+#define YSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
+	(IRO[56].base + ((pf_id) * IRO[56].m1))
+#define YSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[56].size)
+
+/* Pstorm error level for assert */
+#define PSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
+	(IRO[57].base + ((pf_id) * IRO[57].m1))
+#define PSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[57].size)
+
+/* Tstorm error level for assert */
+#define TSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
+	(IRO[58].base + ((pf_id) * IRO[58].m1))
+#define TSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[58].size)
+
+/* Mstorm error level for assert */
+#define MSTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
+	(IRO[59].base + ((pf_id) * IRO[59].m1))
+#define MSTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[59].size)
+
+/* Ustorm error level for assert */
+#define USTORM_RDMA_ASSERT_LEVEL_OFFSET(pf_id) \
+	(IRO[60].base + ((pf_id) * IRO[60].m1))
+#define USTORM_RDMA_ASSERT_LEVEL_SIZE			(IRO[60].size)
+
+/* Xstorm iWARP rxmit stats */
+#define XSTORM_IWARP_RXMIT_STATS_OFFSET(pf_id) \
+	(IRO[61].base + ((pf_id) * IRO[61].m1))
+#define XSTORM_IWARP_RXMIT_STATS_SIZE			(IRO[61].size)
+
+/* Tstorm RoCE Event Statistics */
+#define TSTORM_ROCE_EVENTS_STAT_OFFSET(roce_pf_id)	\
+	(IRO[62].base + ((roce_pf_id) * IRO[62].m1))
+#define TSTORM_ROCE_EVENTS_STAT_SIZE			(IRO[62].size)
+
+/* DCQCN Received Statistics */
+#define YSTORM_ROCE_DCQCN_RECEIVED_STATS_OFFSET(roce_pf_id)\
+	(IRO[63].base + ((roce_pf_id) * IRO[63].m1))
+#define YSTORM_ROCE_DCQCN_RECEIVED_STATS_SIZE		(IRO[63].size)
+
+/* RoCE Error Statistics */
+#define YSTORM_ROCE_ERROR_STATS_OFFSET(roce_pf_id)	\
+	(IRO[64].base + ((roce_pf_id) * IRO[64].m1))
+#define YSTORM_ROCE_ERROR_STATS_SIZE			(IRO[64].size)
+
+/* DCQCN Sent Statistics */
+#define PSTORM_ROCE_DCQCN_SENT_STATS_OFFSET(roce_pf_id)	\
+	(IRO[65].base + ((roce_pf_id) * IRO[65].m1))
+#define PSTORM_ROCE_DCQCN_SENT_STATS_SIZE		(IRO[65].size)
+
+/* RoCE CQEs Statistics */
+#define USTORM_ROCE_CQE_STATS_OFFSET(roce_pf_id)	\
+	(IRO[66].base + ((roce_pf_id) * IRO[66].m1))
+#define USTORM_ROCE_CQE_STATS_SIZE			(IRO[66].size)
+
+#endif
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
index db926d8b3033..b116b3183939 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
@@ -29,6 +29,7 @@
 #include "qed_hsi.h"
 #include "qed_hw.h"
 #include "qed_int.h"
+#include "qed_iro_hsi.h"
 #include "qed_iscsi.h"
 #include "qed_ll2.h"
 #include "qed_mcp.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index ba8c7a31cce1..991bf4313da6 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -28,6 +28,7 @@
 #include "qed_dev_api.h"
 #include <linux/qed/qed_eth_if.h>
 #include "qed_hsi.h"
+#include "qed_iro_hsi.h"
 #include "qed_hw.h"
 #include "qed_int.h"
 #include "qed_l2.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index bf48a66704bd..5e586a1cf4aa 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -28,6 +28,7 @@
 #include "qed_cxt.h"
 #include "qed_dev_api.h"
 #include "qed_hsi.h"
+#include "qed_iro_hsi.h"
 #include "qed_hw.h"
 #include "qed_int.h"
 #include "qed_ll2.h"
@@ -106,7 +107,7 @@ static int qed_ll2_alloc_buffer(struct qed_dev *cdev,
 }
 
 static int qed_ll2_dealloc_buffer(struct qed_dev *cdev,
-				 struct qed_ll2_buffer *buffer)
+				  struct qed_ll2_buffer *buffer)
 {
 	spin_lock_bh(&cdev->ll2->lock);
 
@@ -1124,6 +1125,7 @@ static int qed_sp_ll2_tx_queue_stop(struct qed_hwfn *p_hwfn,
 	struct qed_spq_entry *p_ent = NULL;
 	struct qed_sp_init_data init_data;
 	int rc = -EINVAL;
+
 	qed_db_recovery_del(p_hwfn->cdev, p_tx->doorbell_addr, &p_tx->db_msg);
 
 	/* Get SPQ entry */
@@ -1762,7 +1764,7 @@ int qed_ll2_post_rx_buffer(void *cxt,
 		}
 	}
 
-	/* If we're lacking entires, let's try to flush buffers to FW */
+	/* If we're lacking entries, let's try to flush buffers to FW */
 	if (!p_curp || !p_curb) {
 		rc = -EBUSY;
 		p_curp = NULL;
@@ -2609,7 +2611,6 @@ static int qed_ll2_start(struct qed_dev *cdev, struct qed_ll2_params *params)
 			DP_NOTICE(cdev, "Failed to add an LLH filter\n");
 			goto err3;
 		}
-
 	}
 
 	ether_addr_copy(cdev->ll2_mac_address, params->ll2_mac_address);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.h b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
index df88d00053a2..fa5086498c25 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -32,7 +32,6 @@
 #define QED_LL2_LEGACY_CONN_BASE_PF     0
 #define QED_LL2_CTX_CONN_BASE_PF        QED_MAX_NUM_OF_LEGACY_LL2_CONNS_PF
 
-
 struct qed_ll2_rx_packet {
 	struct list_head list_entry;
 	struct core_rx_bd_with_buff_len *rxq_bd;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 2b39fa294d32..24582977f2d4 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -17,6 +17,7 @@
 #include "qed_cxt.h"
 #include "qed_dcbx.h"
 #include "qed_hsi.h"
+#include "qed_mfw_hsi.h"
 #include "qed_hw.h"
 #include "qed_mcp.h"
 #include "qed_reg_addr.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h
new file mode 100644
index 000000000000..e419d1577d5c
--- /dev/null
+++ b/drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h
@@ -0,0 +1,1928 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/* QLogic qed NIC Driver
+ * Copyright (c) 2019-2021 Marvell International Ltd.
+ */
+
+#ifndef _QED_MFW_HSI_H
+#define _QED_MFW_HSI_H
+
+#define MFW_TRACE_SIGNATURE     0x25071946
+
+/* The trace in the buffer */
+#define MFW_TRACE_EVENTID_MASK          0x00ffff
+#define MFW_TRACE_PRM_SIZE_MASK         0x0f0000
+#define MFW_TRACE_PRM_SIZE_OFFSET	16
+#define MFW_TRACE_ENTRY_SIZE            3
+
+struct mcp_trace {
+	u32 signature;		/* Help to identify that the trace is valid */
+	u32 size;		/* the size of the trace buffer in bytes */
+	u32 curr_level;		/* 2 - all will be written to the buffer
+				 * 1 - debug trace will not be written
+				 * 0 - just errors will be written to the buffer
+				 */
+	u32 modules_mask[2];	/* a bit per module, 1 means write it, 0 means
+				 * mask it.
+				 */
+
+	/* Warning: the following pointers are assumed to be 32bits as they are
+	 * used only in the MFW.
+	 */
+	u32 trace_prod; /* The next trace will be written to this offset */
+	u32 trace_oldest; /* The oldest valid trace starts at this offset
+			   * (usually very close after the current producer).
+			   */
+};
+
+#define VF_MAX_STATIC 192
+
+#define MCP_GLOB_PATH_MAX	2
+#define MCP_PORT_MAX		2
+#define MCP_GLOB_PORT_MAX	4
+#define MCP_GLOB_FUNC_MAX	16
+
+typedef u32 offsize_t;		/* In DWORDS !!! */
+/* Offset from the beginning of the MCP scratchpad */
+#define OFFSIZE_OFFSET_SHIFT	0
+#define OFFSIZE_OFFSET_MASK	0x0000ffff
+/* Size of specific element (not the whole array if any) */
+#define OFFSIZE_SIZE_SHIFT	16
+#define OFFSIZE_SIZE_MASK	0xffff0000
+
+#define SECTION_OFFSET(_offsize) (((((_offsize) &			\
+				     OFFSIZE_OFFSET_MASK) >>	\
+				    OFFSIZE_OFFSET_SHIFT) << 2))
+
+#define QED_SECTION_SIZE(_offsize) ((((_offsize) &		\
+				      OFFSIZE_SIZE_MASK) >>	\
+				     OFFSIZE_SIZE_SHIFT) << 2)
+
+#define SECTION_ADDR(_offsize, idx) (MCP_REG_SCRATCH +			\
+				     SECTION_OFFSET((_offsize)) +	\
+				     (QED_SECTION_SIZE((_offsize)) * (idx)))
+
+#define SECTION_OFFSIZE_ADDR(_pub_base, _section)	\
+	((_pub_base) + offsetof(struct mcp_public_data, sections[_section]))
+
+/* PHY configuration */
+struct eth_phy_cfg {
+	u32					speed;
+#define ETH_SPEED_AUTONEG			0x0
+#define ETH_SPEED_SMARTLINQ			0x8
+
+	u32					pause;
+#define ETH_PAUSE_NONE				0x0
+#define ETH_PAUSE_AUTONEG			0x1
+#define ETH_PAUSE_RX				0x2
+#define ETH_PAUSE_TX				0x4
+
+	u32					adv_speed;
+
+	u32					loopback_mode;
+#define ETH_LOOPBACK_NONE			0x0
+#define ETH_LOOPBACK_INT_PHY			0x1
+#define ETH_LOOPBACK_EXT_PHY			0x2
+#define ETH_LOOPBACK_EXT			0x3
+#define ETH_LOOPBACK_MAC			0x4
+#define ETH_LOOPBACK_CNIG_AH_ONLY_0123		0x5
+#define ETH_LOOPBACK_CNIG_AH_ONLY_2301		0x6
+#define ETH_LOOPBACK_PCS_AH_ONLY		0x7
+#define ETH_LOOPBACK_REVERSE_MAC_AH_ONLY	0x8
+#define ETH_LOOPBACK_INT_PHY_FEA_AH_ONLY	0x9
+
+	u32					eee_cfg;
+#define EEE_CFG_EEE_ENABLED			BIT(0)
+#define EEE_CFG_TX_LPI				BIT(1)
+#define EEE_CFG_ADV_SPEED_1G			BIT(2)
+#define EEE_CFG_ADV_SPEED_10G			BIT(3)
+#define EEE_TX_TIMER_USEC_MASK			0xfffffff0
+#define EEE_TX_TIMER_USEC_OFFSET		4
+#define EEE_TX_TIMER_USEC_BALANCED_TIME		0xa00
+#define EEE_TX_TIMER_USEC_AGGRESSIVE_TIME	0x100
+#define EEE_TX_TIMER_USEC_LATENCY_TIME		0x6000
+
+	u32					deprecated;
+
+	u32					fec_mode;
+#define FEC_FORCE_MODE_MASK			0x000000ff
+#define FEC_FORCE_MODE_OFFSET			0
+#define FEC_FORCE_MODE_NONE			0x00
+#define FEC_FORCE_MODE_FIRECODE			0x01
+#define FEC_FORCE_MODE_RS			0x02
+#define FEC_FORCE_MODE_AUTO			0x07
+#define FEC_EXTENDED_MODE_MASK			0xffffff00
+#define FEC_EXTENDED_MODE_OFFSET		8
+#define ETH_EXT_FEC_NONE			0x00000100
+#define ETH_EXT_FEC_10G_NONE			0x00000200
+#define ETH_EXT_FEC_10G_BASE_R			0x00000400
+#define ETH_EXT_FEC_20G_NONE			0x00000800
+#define ETH_EXT_FEC_20G_BASE_R			0x00001000
+#define ETH_EXT_FEC_25G_NONE			0x00002000
+#define ETH_EXT_FEC_25G_BASE_R			0x00004000
+#define ETH_EXT_FEC_25G_RS528			0x00008000
+#define ETH_EXT_FEC_40G_NONE			0x00010000
+#define ETH_EXT_FEC_40G_BASE_R			0x00020000
+#define ETH_EXT_FEC_50G_NONE			0x00040000
+#define ETH_EXT_FEC_50G_BASE_R			0x00080000
+#define ETH_EXT_FEC_50G_RS528			0x00100000
+#define ETH_EXT_FEC_50G_RS544			0x00200000
+#define ETH_EXT_FEC_100G_NONE			0x00400000
+#define ETH_EXT_FEC_100G_BASE_R			0x00800000
+#define ETH_EXT_FEC_100G_RS528			0x01000000
+#define ETH_EXT_FEC_100G_RS544			0x02000000
+
+	u32					extended_speed;
+#define ETH_EXT_SPEED_MASK			0x0000ffff
+#define ETH_EXT_SPEED_OFFSET			0
+#define ETH_EXT_SPEED_AN			0x00000001
+#define ETH_EXT_SPEED_1G			0x00000002
+#define ETH_EXT_SPEED_10G			0x00000004
+#define ETH_EXT_SPEED_20G			0x00000008
+#define ETH_EXT_SPEED_25G			0x00000010
+#define ETH_EXT_SPEED_40G			0x00000020
+#define ETH_EXT_SPEED_50G_BASE_R		0x00000040
+#define ETH_EXT_SPEED_50G_BASE_R2		0x00000080
+#define ETH_EXT_SPEED_100G_BASE_R2		0x00000100
+#define ETH_EXT_SPEED_100G_BASE_R4		0x00000200
+#define ETH_EXT_SPEED_100G_BASE_P4		0x00000400
+#define ETH_EXT_ADV_SPEED_MASK			0xffff0000
+#define ETH_EXT_ADV_SPEED_OFFSET		16
+#define ETH_EXT_ADV_SPEED_RESERVED		0x00010000
+#define ETH_EXT_ADV_SPEED_1G			0x00020000
+#define ETH_EXT_ADV_SPEED_10G			0x00040000
+#define ETH_EXT_ADV_SPEED_20G			0x00080000
+#define ETH_EXT_ADV_SPEED_25G			0x00100000
+#define ETH_EXT_ADV_SPEED_40G			0x00200000
+#define ETH_EXT_ADV_SPEED_50G_BASE_R		0x00400000
+#define ETH_EXT_ADV_SPEED_50G_BASE_R2		0x00800000
+#define ETH_EXT_ADV_SPEED_100G_BASE_R2		0x01000000
+#define ETH_EXT_ADV_SPEED_100G_BASE_R4		0x02000000
+#define ETH_EXT_ADV_SPEED_100G_BASE_P4		0x04000000
+};
+
+struct port_mf_cfg {
+	u32 dynamic_cfg;
+#define PORT_MF_CFG_OV_TAG_MASK		0x0000ffff
+#define PORT_MF_CFG_OV_TAG_SHIFT	0
+#define PORT_MF_CFG_OV_TAG_DEFAULT	PORT_MF_CFG_OV_TAG_MASK
+
+	u32 reserved[1];
+};
+
+struct eth_stats {
+	u64 r64;
+	u64 r127;
+	u64 r255;
+	u64 r511;
+	u64 r1023;
+	u64 r1518;
+
+	union {
+		struct {
+			u64 r1522;
+			u64 r2047;
+			u64 r4095;
+			u64 r9216;
+			u64 r16383;
+		} bb0;
+		struct {
+			u64 unused1;
+			u64 r1519_to_max;
+			u64 unused2;
+			u64 unused3;
+			u64 unused4;
+		} ah0;
+	} u0;
+
+	u64 rfcs;
+	u64 rxcf;
+	u64 rxpf;
+	u64 rxpp;
+	u64 raln;
+	u64 rfcr;
+	u64 rovr;
+	u64 rjbr;
+	u64 rund;
+	u64 rfrg;
+	u64 t64;
+	u64 t127;
+	u64 t255;
+	u64 t511;
+	u64 t1023;
+	u64 t1518;
+
+	union {
+		struct {
+			u64 t2047;
+			u64 t4095;
+			u64 t9216;
+			u64 t16383;
+		} bb1;
+		struct {
+			u64 t1519_to_max;
+			u64 unused6;
+			u64 unused7;
+			u64 unused8;
+		} ah1;
+	} u1;
+
+	u64 txpf;
+	u64 txpp;
+
+	union {
+		struct {
+			u64 tlpiec;
+			u64 tncl;
+		} bb2;
+		struct {
+			u64 unused9;
+			u64 unused10;
+		} ah2;
+	} u2;
+
+	u64 rbyte;
+	u64 rxuca;
+	u64 rxmca;
+	u64 rxbca;
+	u64 rxpok;
+	u64 tbyte;
+	u64 txuca;
+	u64 txmca;
+	u64 txbca;
+	u64 txcf;
+};
+
+struct brb_stats {
+	u64 brb_truncate[8];
+	u64 brb_discard[8];
+};
+
+struct port_stats {
+	struct brb_stats brb;
+	struct eth_stats eth;
+};
+
+struct couple_mode_teaming {
+	u8 port_cmt[MCP_GLOB_PORT_MAX];
+#define PORT_CMT_IN_TEAM	BIT(0)
+
+#define PORT_CMT_PORT_ROLE	BIT(1)
+#define PORT_CMT_PORT_INACTIVE	(0 << 1)
+#define PORT_CMT_PORT_ACTIVE	BIT(1)
+
+#define PORT_CMT_TEAM_MASK	BIT(2)
+#define PORT_CMT_TEAM0		(0 << 2)
+#define PORT_CMT_TEAM1		BIT(2)
+};
+
+#define LLDP_CHASSIS_ID_STAT_LEN	4
+#define LLDP_PORT_ID_STAT_LEN		4
+#define DCBX_MAX_APP_PROTOCOL		32
+#define MAX_SYSTEM_LLDP_TLV_DATA	32
+
+enum _lldp_agent {
+	LLDP_NEAREST_BRIDGE = 0,
+	LLDP_NEAREST_NON_TPMR_BRIDGE,
+	LLDP_NEAREST_CUSTOMER_BRIDGE,
+	LLDP_MAX_LLDP_AGENTS
+};
+
+struct lldp_config_params_s {
+	u32 config;
+#define LLDP_CONFIG_TX_INTERVAL_MASK	0x000000ff
+#define LLDP_CONFIG_TX_INTERVAL_SHIFT	0
+#define LLDP_CONFIG_HOLD_MASK		0x00000f00
+#define LLDP_CONFIG_HOLD_SHIFT		8
+#define LLDP_CONFIG_MAX_CREDIT_MASK	0x0000f000
+#define LLDP_CONFIG_MAX_CREDIT_SHIFT	12
+#define LLDP_CONFIG_ENABLE_RX_MASK	0x40000000
+#define LLDP_CONFIG_ENABLE_RX_SHIFT	30
+#define LLDP_CONFIG_ENABLE_TX_MASK	0x80000000
+#define LLDP_CONFIG_ENABLE_TX_SHIFT	31
+	u32 local_chassis_id[LLDP_CHASSIS_ID_STAT_LEN];
+	u32 local_port_id[LLDP_PORT_ID_STAT_LEN];
+};
+
+struct lldp_status_params_s {
+	u32 prefix_seq_num;
+	u32 status;
+	u32 peer_chassis_id[LLDP_CHASSIS_ID_STAT_LEN];
+	u32 peer_port_id[LLDP_PORT_ID_STAT_LEN];
+	u32 suffix_seq_num;
+};
+
+struct dcbx_ets_feature {
+	u32 flags;
+#define DCBX_ETS_ENABLED_MASK	0x00000001
+#define DCBX_ETS_ENABLED_SHIFT	0
+#define DCBX_ETS_WILLING_MASK	0x00000002
+#define DCBX_ETS_WILLING_SHIFT	1
+#define DCBX_ETS_ERROR_MASK	0x00000004
+#define DCBX_ETS_ERROR_SHIFT	2
+#define DCBX_ETS_CBS_MASK	0x00000008
+#define DCBX_ETS_CBS_SHIFT	3
+#define DCBX_ETS_MAX_TCS_MASK	0x000000f0
+#define DCBX_ETS_MAX_TCS_SHIFT	4
+#define DCBX_OOO_TC_MASK	0x00000f00
+#define DCBX_OOO_TC_SHIFT	8
+	u32 pri_tc_tbl[1];
+#define DCBX_TCP_OOO_TC		(4)
+
+#define NIG_ETS_ISCSI_OOO_CLIENT_OFFSET	(DCBX_TCP_OOO_TC + 1)
+#define DCBX_CEE_STRICT_PRIORITY	0xf
+	u32 tc_bw_tbl[2];
+	u32 tc_tsa_tbl[2];
+#define DCBX_ETS_TSA_STRICT	0
+#define DCBX_ETS_TSA_CBS	1
+#define DCBX_ETS_TSA_ETS	2
+};
+
+#define DCBX_TCP_OOO_TC			(4)
+#define DCBX_TCP_OOO_K2_4PORT_TC	(3)
+
+struct dcbx_app_priority_entry {
+	u32 entry;
+#define DCBX_APP_PRI_MAP_MASK		0x000000ff
+#define DCBX_APP_PRI_MAP_SHIFT		0
+#define DCBX_APP_PRI_0			0x01
+#define DCBX_APP_PRI_1			0x02
+#define DCBX_APP_PRI_2			0x04
+#define DCBX_APP_PRI_3			0x08
+#define DCBX_APP_PRI_4			0x10
+#define DCBX_APP_PRI_5			0x20
+#define DCBX_APP_PRI_6			0x40
+#define DCBX_APP_PRI_7			0x80
+#define DCBX_APP_SF_MASK		0x00000300
+#define DCBX_APP_SF_SHIFT		8
+#define DCBX_APP_SF_ETHTYPE		0
+#define DCBX_APP_SF_PORT		1
+#define DCBX_APP_SF_IEEE_MASK		0x0000f000
+#define DCBX_APP_SF_IEEE_SHIFT		12
+#define DCBX_APP_SF_IEEE_RESERVED	0
+#define DCBX_APP_SF_IEEE_ETHTYPE	1
+#define DCBX_APP_SF_IEEE_TCP_PORT	2
+#define DCBX_APP_SF_IEEE_UDP_PORT	3
+#define DCBX_APP_SF_IEEE_TCP_UDP_PORT	4
+
+#define DCBX_APP_PROTOCOL_ID_MASK	0xffff0000
+#define DCBX_APP_PROTOCOL_ID_SHIFT	16
+};
+
+struct dcbx_app_priority_feature {
+	u32 flags;
+#define DCBX_APP_ENABLED_MASK		0x00000001
+#define DCBX_APP_ENABLED_SHIFT		0
+#define DCBX_APP_WILLING_MASK		0x00000002
+#define DCBX_APP_WILLING_SHIFT		1
+#define DCBX_APP_ERROR_MASK		0x00000004
+#define DCBX_APP_ERROR_SHIFT		2
+#define DCBX_APP_MAX_TCS_MASK		0x0000f000
+#define DCBX_APP_MAX_TCS_SHIFT		12
+#define DCBX_APP_NUM_ENTRIES_MASK	0x00ff0000
+#define DCBX_APP_NUM_ENTRIES_SHIFT	16
+	struct dcbx_app_priority_entry app_pri_tbl[DCBX_MAX_APP_PROTOCOL];
+};
+
+struct dcbx_features {
+	struct dcbx_ets_feature ets;
+	u32 pfc;
+#define DCBX_PFC_PRI_EN_BITMAP_MASK	0x000000ff
+#define DCBX_PFC_PRI_EN_BITMAP_SHIFT	0
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_0	0x01
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_1	0x02
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_2	0x04
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_3	0x08
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_4	0x10
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_5	0x20
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_6	0x40
+#define DCBX_PFC_PRI_EN_BITMAP_PRI_7	0x80
+
+#define DCBX_PFC_FLAGS_MASK		0x0000ff00
+#define DCBX_PFC_FLAGS_SHIFT		8
+#define DCBX_PFC_CAPS_MASK		0x00000f00
+#define DCBX_PFC_CAPS_SHIFT		8
+#define DCBX_PFC_MBC_MASK		0x00004000
+#define DCBX_PFC_MBC_SHIFT		14
+#define DCBX_PFC_WILLING_MASK		0x00008000
+#define DCBX_PFC_WILLING_SHIFT		15
+#define DCBX_PFC_ENABLED_MASK		0x00010000
+#define DCBX_PFC_ENABLED_SHIFT		16
+#define DCBX_PFC_ERROR_MASK		0x00020000
+#define DCBX_PFC_ERROR_SHIFT		17
+
+	struct dcbx_app_priority_feature app;
+};
+
+struct dcbx_local_params {
+	u32 config;
+#define DCBX_CONFIG_VERSION_MASK	0x00000007
+#define DCBX_CONFIG_VERSION_SHIFT	0
+#define DCBX_CONFIG_VERSION_DISABLED	0
+#define DCBX_CONFIG_VERSION_IEEE	1
+#define DCBX_CONFIG_VERSION_CEE		2
+#define DCBX_CONFIG_VERSION_STATIC	4
+
+	u32 flags;
+	struct dcbx_features features;
+};
+
+struct dcbx_mib {
+	u32 prefix_seq_num;
+	u32 flags;
+	struct dcbx_features features;
+	u32 suffix_seq_num;
+};
+
+struct lldp_system_tlvs_buffer_s {
+	u16 valid;
+	u16 length;
+	u32 data[MAX_SYSTEM_LLDP_TLV_DATA];
+};
+
+struct dcb_dscp_map {
+	u32 flags;
+#define DCB_DSCP_ENABLE_MASK	0x1
+#define DCB_DSCP_ENABLE_SHIFT	0
+#define DCB_DSCP_ENABLE	1
+	u32 dscp_pri_map[8];
+};
+
+struct public_global {
+	u32 max_path;
+	u32 max_ports;
+#define MODE_1P 1
+#define MODE_2P 2
+#define MODE_3P 3
+#define MODE_4P 4
+	u32 debug_mb_offset;
+	u32 phymod_dbg_mb_offset;
+	struct couple_mode_teaming cmt;
+	s32 internal_temperature;
+	u32 mfw_ver;
+	u32 running_bundle_id;
+	s32 external_temperature;
+	u32 mdump_reason;
+	u64 reserved;
+	u32 data_ptr;
+	u32 data_size;
+};
+
+struct fw_flr_mb {
+	u32 aggint;
+	u32 opgen_addr;
+	u32 accum_ack;
+};
+
+struct public_path {
+	struct fw_flr_mb flr_mb;
+	u32 mcp_vf_disabled[VF_MAX_STATIC / 32];
+
+	u32 process_kill;
+#define PROCESS_KILL_COUNTER_MASK	0x0000ffff
+#define PROCESS_KILL_COUNTER_SHIFT	0
+#define PROCESS_KILL_GLOB_AEU_BIT_MASK	0xffff0000
+#define PROCESS_KILL_GLOB_AEU_BIT_SHIFT	16
+#define GLOBAL_AEU_BIT(aeu_reg_id, aeu_bit) ((aeu_reg_id) * 32 + (aeu_bit))
+};
+
+struct public_port {
+	u32						validity_map;
+
+	u32						link_status;
+#define LINK_STATUS_LINK_UP				0x00000001
+#define LINK_STATUS_SPEED_AND_DUPLEX_MASK		0x0000001e
+#define LINK_STATUS_SPEED_AND_DUPLEX_1000THD		BIT(1)
+#define LINK_STATUS_SPEED_AND_DUPLEX_1000TFD		(2 << 1)
+#define LINK_STATUS_SPEED_AND_DUPLEX_10G		(3 << 1)
+#define LINK_STATUS_SPEED_AND_DUPLEX_20G		(4 << 1)
+#define LINK_STATUS_SPEED_AND_DUPLEX_40G		(5 << 1)
+#define LINK_STATUS_SPEED_AND_DUPLEX_50G		(6 << 1)
+#define LINK_STATUS_SPEED_AND_DUPLEX_100G		(7 << 1)
+#define LINK_STATUS_SPEED_AND_DUPLEX_25G		(8 << 1)
+#define LINK_STATUS_AUTO_NEGOTIATE_ENABLED		0x00000020
+#define LINK_STATUS_AUTO_NEGOTIATE_COMPLETE		0x00000040
+#define LINK_STATUS_PARALLEL_DETECTION_USED		0x00000080
+#define LINK_STATUS_PFC_ENABLED				0x00000100
+#define LINK_STATUS_LINK_PARTNER_1000TFD_CAPABLE	0x00000200
+#define LINK_STATUS_LINK_PARTNER_1000THD_CAPABLE	0x00000400
+#define LINK_STATUS_LINK_PARTNER_10G_CAPABLE		0x00000800
+#define LINK_STATUS_LINK_PARTNER_20G_CAPABLE		0x00001000
+#define LINK_STATUS_LINK_PARTNER_40G_CAPABLE		0x00002000
+#define LINK_STATUS_LINK_PARTNER_50G_CAPABLE		0x00004000
+#define LINK_STATUS_LINK_PARTNER_100G_CAPABLE		0x00008000
+#define LINK_STATUS_LINK_PARTNER_25G_CAPABLE		0x00010000
+#define LINK_STATUS_LINK_PARTNER_FLOW_CONTROL_MASK	0x000c0000
+#define LINK_STATUS_LINK_PARTNER_NOT_PAUSE_CAPABLE	(0 << 18)
+#define LINK_STATUS_LINK_PARTNER_SYMMETRIC_PAUSE	BIT(18)
+#define LINK_STATUS_LINK_PARTNER_ASYMMETRIC_PAUSE	(2 << 18)
+#define LINK_STATUS_LINK_PARTNER_BOTH_PAUSE		(3 << 18)
+#define LINK_STATUS_SFP_TX_FAULT			0x00100000
+#define LINK_STATUS_TX_FLOW_CONTROL_ENABLED		0x00200000
+#define LINK_STATUS_RX_FLOW_CONTROL_ENABLED		0x00400000
+#define LINK_STATUS_RX_SIGNAL_PRESENT			0x00800000
+#define LINK_STATUS_MAC_LOCAL_FAULT			0x01000000
+#define LINK_STATUS_MAC_REMOTE_FAULT			0x02000000
+#define LINK_STATUS_UNSUPPORTED_SPD_REQ			0x04000000
+
+#define LINK_STATUS_FEC_MODE_MASK			0x38000000
+#define LINK_STATUS_FEC_MODE_NONE			(0 << 27)
+#define LINK_STATUS_FEC_MODE_FIRECODE_CL74		BIT(27)
+#define LINK_STATUS_FEC_MODE_RS_CL91			(2 << 27)
+
+	u32 link_status1;
+	u32 ext_phy_fw_version;
+	u32 drv_phy_cfg_addr;
+
+	u32 port_stx;
+
+	u32 stat_nig_timer;
+
+	struct port_mf_cfg port_mf_config;
+	struct port_stats stats;
+
+	u32 media_type;
+#define MEDIA_UNSPECIFIED	0x0
+#define MEDIA_SFPP_10G_FIBER	0x1
+#define MEDIA_XFP_FIBER		0x2
+#define MEDIA_DA_TWINAX		0x3
+#define MEDIA_BASE_T		0x4
+#define MEDIA_SFP_1G_FIBER	0x5
+#define MEDIA_MODULE_FIBER	0x6
+#define MEDIA_KR		0xf0
+#define MEDIA_NOT_PRESENT	0xff
+
+	u32 lfa_status;
+	u32 link_change_count;
+
+	struct lldp_config_params_s lldp_config_params[LLDP_MAX_LLDP_AGENTS];
+	struct lldp_status_params_s lldp_status_params[LLDP_MAX_LLDP_AGENTS];
+	struct lldp_system_tlvs_buffer_s system_lldp_tlvs_buf;
+
+	/* DCBX related MIB */
+	struct dcbx_local_params local_admin_dcbx_mib;
+	struct dcbx_mib remote_dcbx_mib;
+	struct dcbx_mib operational_dcbx_mib;
+
+	u32 reserved[2];
+
+	u32						transceiver_data;
+#define ETH_TRANSCEIVER_STATE_MASK			0x000000ff
+#define ETH_TRANSCEIVER_STATE_SHIFT			0x00000000
+#define ETH_TRANSCEIVER_STATE_OFFSET			0x00000000
+#define ETH_TRANSCEIVER_STATE_UNPLUGGED			0x00000000
+#define ETH_TRANSCEIVER_STATE_PRESENT			0x00000001
+#define ETH_TRANSCEIVER_STATE_VALID			0x00000003
+#define ETH_TRANSCEIVER_STATE_UPDATING			0x00000008
+#define ETH_TRANSCEIVER_TYPE_MASK			0x0000ff00
+#define ETH_TRANSCEIVER_TYPE_OFFSET			0x8
+#define ETH_TRANSCEIVER_TYPE_NONE			0x00
+#define ETH_TRANSCEIVER_TYPE_UNKNOWN			0xff
+#define ETH_TRANSCEIVER_TYPE_1G_PCC			0x01
+#define ETH_TRANSCEIVER_TYPE_1G_ACC			0x02
+#define ETH_TRANSCEIVER_TYPE_1G_LX			0x03
+#define ETH_TRANSCEIVER_TYPE_1G_SX			0x04
+#define ETH_TRANSCEIVER_TYPE_10G_SR			0x05
+#define ETH_TRANSCEIVER_TYPE_10G_LR			0x06
+#define ETH_TRANSCEIVER_TYPE_10G_LRM			0x07
+#define ETH_TRANSCEIVER_TYPE_10G_ER			0x08
+#define ETH_TRANSCEIVER_TYPE_10G_PCC			0x09
+#define ETH_TRANSCEIVER_TYPE_10G_ACC			0x0a
+#define ETH_TRANSCEIVER_TYPE_XLPPI			0x0b
+#define ETH_TRANSCEIVER_TYPE_40G_LR4			0x0c
+#define ETH_TRANSCEIVER_TYPE_40G_SR4			0x0d
+#define ETH_TRANSCEIVER_TYPE_40G_CR4			0x0e
+#define ETH_TRANSCEIVER_TYPE_100G_AOC			0x0f
+#define ETH_TRANSCEIVER_TYPE_100G_SR4			0x10
+#define ETH_TRANSCEIVER_TYPE_100G_LR4			0x11
+#define ETH_TRANSCEIVER_TYPE_100G_ER4			0x12
+#define ETH_TRANSCEIVER_TYPE_100G_ACC			0x13
+#define ETH_TRANSCEIVER_TYPE_100G_CR4			0x14
+#define ETH_TRANSCEIVER_TYPE_4x10G_SR			0x15
+#define ETH_TRANSCEIVER_TYPE_25G_CA_N			0x16
+#define ETH_TRANSCEIVER_TYPE_25G_ACC_S			0x17
+#define ETH_TRANSCEIVER_TYPE_25G_CA_S			0x18
+#define ETH_TRANSCEIVER_TYPE_25G_ACC_M			0x19
+#define ETH_TRANSCEIVER_TYPE_25G_CA_L			0x1a
+#define ETH_TRANSCEIVER_TYPE_25G_ACC_L			0x1b
+#define ETH_TRANSCEIVER_TYPE_25G_SR			0x1c
+#define ETH_TRANSCEIVER_TYPE_25G_LR			0x1d
+#define ETH_TRANSCEIVER_TYPE_25G_AOC			0x1e
+#define ETH_TRANSCEIVER_TYPE_4x10G			0x1f
+#define ETH_TRANSCEIVER_TYPE_4x25G_CR			0x20
+#define ETH_TRANSCEIVER_TYPE_1000BASET			0x21
+#define ETH_TRANSCEIVER_TYPE_10G_BASET			0x22
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_40G_SR	0x30
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_40G_CR	0x31
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_40G_LR	0x32
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_SR	0x33
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_CR	0x34
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_LR	0x35
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_40G_100G_AOC	0x36
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_25G_SR	0x37
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_10G_25G_LR	0x38
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_1G_10G_SR	0x39
+#define ETH_TRANSCEIVER_TYPE_MULTI_RATE_1G_10G_LR	0x3a
+
+	u32 wol_info;
+	u32 wol_pkt_len;
+	u32 wol_pkt_details;
+	struct dcb_dscp_map dcb_dscp_map;
+
+	u32 eee_status;
+#define EEE_ACTIVE_BIT			BIT(0)
+#define EEE_LD_ADV_STATUS_MASK		0x000000f0
+#define EEE_LD_ADV_STATUS_OFFSET	4
+#define EEE_1G_ADV			BIT(1)
+#define EEE_10G_ADV			BIT(2)
+#define EEE_LP_ADV_STATUS_MASK		0x00000f00
+#define EEE_LP_ADV_STATUS_OFFSET	8
+#define EEE_SUPPORTED_SPEED_MASK	0x0000f000
+#define EEE_SUPPORTED_SPEED_OFFSET	12
+#define EEE_1G_SUPPORTED		BIT(1)
+#define EEE_10G_SUPPORTED		BIT(2)
+
+	u32 eee_remote;
+#define EEE_REMOTE_TW_TX_MASK   0x0000ffff
+#define EEE_REMOTE_TW_TX_OFFSET 0
+#define EEE_REMOTE_TW_RX_MASK   0xffff0000
+#define EEE_REMOTE_TW_RX_OFFSET 16
+
+	u32 reserved1;
+	u32 oem_cfg_port;
+#define OEM_CFG_CHANNEL_TYPE_MASK                       0x00000003
+#define OEM_CFG_CHANNEL_TYPE_OFFSET                     0
+#define OEM_CFG_CHANNEL_TYPE_VLAN_PARTITION             0x1
+#define OEM_CFG_CHANNEL_TYPE_STAGGED                    0x2
+#define OEM_CFG_SCHED_TYPE_MASK                         0x0000000C
+#define OEM_CFG_SCHED_TYPE_OFFSET                       2
+#define OEM_CFG_SCHED_TYPE_ETS                          0x1
+#define OEM_CFG_SCHED_TYPE_VNIC_BW                      0x2
+};
+
+struct public_func {
+	u32 reserved0[2];
+
+	u32 mtu_size;
+
+	u32 reserved[7];
+
+	u32 config;
+#define FUNC_MF_CFG_FUNC_HIDE			0x00000001
+#define FUNC_MF_CFG_PAUSE_ON_HOST_RING		0x00000002
+#define FUNC_MF_CFG_PAUSE_ON_HOST_RING_SHIFT	0x00000001
+
+#define FUNC_MF_CFG_PROTOCOL_MASK	0x000000f0
+#define FUNC_MF_CFG_PROTOCOL_SHIFT	4
+#define FUNC_MF_CFG_PROTOCOL_ETHERNET	0x00000000
+#define FUNC_MF_CFG_PROTOCOL_ISCSI              0x00000010
+#define FUNC_MF_CFG_PROTOCOL_FCOE               0x00000020
+#define FUNC_MF_CFG_PROTOCOL_ROCE               0x00000030
+#define FUNC_MF_CFG_PROTOCOL_NVMETCP    0x00000040
+#define FUNC_MF_CFG_PROTOCOL_MAX	0x00000040
+
+#define FUNC_MF_CFG_MIN_BW_MASK		0x0000ff00
+#define FUNC_MF_CFG_MIN_BW_SHIFT	8
+#define FUNC_MF_CFG_MIN_BW_DEFAULT	0x00000000
+#define FUNC_MF_CFG_MAX_BW_MASK		0x00ff0000
+#define FUNC_MF_CFG_MAX_BW_SHIFT	16
+#define FUNC_MF_CFG_MAX_BW_DEFAULT	0x00640000
+
+	u32 status;
+#define FUNC_STATUS_VIRTUAL_LINK_UP	0x00000001
+
+	u32 mac_upper;
+#define FUNC_MF_CFG_UPPERMAC_MASK	0x0000ffff
+#define FUNC_MF_CFG_UPPERMAC_SHIFT	0
+#define FUNC_MF_CFG_UPPERMAC_DEFAULT	FUNC_MF_CFG_UPPERMAC_MASK
+	u32 mac_lower;
+#define FUNC_MF_CFG_LOWERMAC_DEFAULT	0xffffffff
+
+	u32 fcoe_wwn_port_name_upper;
+	u32 fcoe_wwn_port_name_lower;
+
+	u32 fcoe_wwn_node_name_upper;
+	u32 fcoe_wwn_node_name_lower;
+
+	u32 ovlan_stag;
+#define FUNC_MF_CFG_OV_STAG_MASK	0x0000ffff
+#define FUNC_MF_CFG_OV_STAG_SHIFT	0
+#define FUNC_MF_CFG_OV_STAG_DEFAULT	FUNC_MF_CFG_OV_STAG_MASK
+
+	u32 pf_allocation;
+
+	u32 preserve_data;
+
+	u32 driver_last_activity_ts;
+
+	u32 drv_ack_vf_disabled[VF_MAX_STATIC / 32];
+
+	u32 drv_id;
+#define DRV_ID_PDA_COMP_VER_MASK	0x0000ffff
+#define DRV_ID_PDA_COMP_VER_SHIFT	0
+
+#define LOAD_REQ_HSI_VERSION		2
+#define DRV_ID_MCP_HSI_VER_MASK		0x00ff0000
+#define DRV_ID_MCP_HSI_VER_SHIFT	16
+#define DRV_ID_MCP_HSI_VER_CURRENT	(LOAD_REQ_HSI_VERSION << \
+					 DRV_ID_MCP_HSI_VER_SHIFT)
+
+#define DRV_ID_DRV_TYPE_MASK		0x7f000000
+#define DRV_ID_DRV_TYPE_SHIFT		24
+#define DRV_ID_DRV_TYPE_UNKNOWN		(0 << DRV_ID_DRV_TYPE_SHIFT)
+#define DRV_ID_DRV_TYPE_LINUX		BIT(DRV_ID_DRV_TYPE_SHIFT)
+
+#define DRV_ID_DRV_INIT_HW_MASK		0x80000000
+#define DRV_ID_DRV_INIT_HW_SHIFT	31
+#define DRV_ID_DRV_INIT_HW_FLAG		BIT(DRV_ID_DRV_INIT_HW_SHIFT)
+
+	u32 oem_cfg_func;
+#define OEM_CFG_FUNC_TC_MASK                    0x0000000F
+#define OEM_CFG_FUNC_TC_OFFSET                  0
+#define OEM_CFG_FUNC_TC_0                       0x0
+#define OEM_CFG_FUNC_TC_1                       0x1
+#define OEM_CFG_FUNC_TC_2                       0x2
+#define OEM_CFG_FUNC_TC_3                       0x3
+#define OEM_CFG_FUNC_TC_4                       0x4
+#define OEM_CFG_FUNC_TC_5                       0x5
+#define OEM_CFG_FUNC_TC_6                       0x6
+#define OEM_CFG_FUNC_TC_7                       0x7
+
+#define OEM_CFG_FUNC_HOST_PRI_CTRL_MASK         0x00000030
+#define OEM_CFG_FUNC_HOST_PRI_CTRL_OFFSET       4
+#define OEM_CFG_FUNC_HOST_PRI_CTRL_VNIC         0x1
+#define OEM_CFG_FUNC_HOST_PRI_CTRL_OS           0x2
+};
+
+struct mcp_mac {
+	u32 mac_upper;
+	u32 mac_lower;
+};
+
+struct mcp_val64 {
+	u32 lo;
+	u32 hi;
+};
+
+struct mcp_file_att {
+	u32 nvm_start_addr;
+	u32 len;
+};
+
+struct bist_nvm_image_att {
+	u32 return_code;
+	u32 image_type;
+	u32 nvm_start_addr;
+	u32 len;
+};
+
+#define MCP_DRV_VER_STR_SIZE 16
+#define MCP_DRV_VER_STR_SIZE_DWORD (MCP_DRV_VER_STR_SIZE / sizeof(u32))
+#define MCP_DRV_NVM_BUF_LEN 32
+struct drv_version_stc {
+	u32 version;
+	u8 name[MCP_DRV_VER_STR_SIZE - 4];
+};
+
+struct lan_stats_stc {
+	u64 ucast_rx_pkts;
+	u64 ucast_tx_pkts;
+	u32 fcs_err;
+	u32 rserved;
+};
+
+struct fcoe_stats_stc {
+	u64 rx_pkts;
+	u64 tx_pkts;
+	u32 fcs_err;
+	u32 login_failure;
+};
+
+struct ocbb_data_stc {
+	u32 ocbb_host_addr;
+	u32 ocsd_host_addr;
+	u32 ocsd_req_update_interval;
+};
+
+#define MAX_NUM_OF_SENSORS 7
+struct temperature_status_stc {
+	u32 num_of_sensors;
+	u32 sensor[MAX_NUM_OF_SENSORS];
+};
+
+/* crash dump configuration header */
+struct mdump_config_stc {
+	u32 version;
+	u32 config;
+	u32 epoc;
+	u32 num_of_logs;
+	u32 valid_logs;
+};
+
+enum resource_id_enum {
+	RESOURCE_NUM_SB_E = 0,
+	RESOURCE_NUM_L2_QUEUE_E = 1,
+	RESOURCE_NUM_VPORT_E = 2,
+	RESOURCE_NUM_VMQ_E = 3,
+	RESOURCE_FACTOR_NUM_RSS_PF_E = 4,
+	RESOURCE_FACTOR_RSS_PER_VF_E = 5,
+	RESOURCE_NUM_RL_E = 6,
+	RESOURCE_NUM_PQ_E = 7,
+	RESOURCE_NUM_VF_E = 8,
+	RESOURCE_VFC_FILTER_E = 9,
+	RESOURCE_ILT_E = 10,
+	RESOURCE_CQS_E = 11,
+	RESOURCE_GFT_PROFILES_E = 12,
+	RESOURCE_NUM_TC_E = 13,
+	RESOURCE_NUM_RSS_ENGINES_E = 14,
+	RESOURCE_LL2_QUEUE_E = 15,
+	RESOURCE_RDMA_STATS_QUEUE_E = 16,
+	RESOURCE_BDQ_E = 17,
+	RESOURCE_QCN_E = 18,
+	RESOURCE_LLH_FILTER_E = 19,
+	RESOURCE_VF_MAC_ADDR = 20,
+	RESOURCE_LL2_CQS_E = 21,
+	RESOURCE_VF_CNQS = 22,
+	RESOURCE_MAX_NUM,
+	RESOURCE_NUM_INVALID = 0xFFFFFFFF
+};
+
+/* Resource ID is to be filled by the driver in the MB request
+ * Size, offset & flags to be filled by the MFW in the MB response
+ */
+struct resource_info {
+	enum resource_id_enum res_id;
+	u32 size;		/* number of allocated resources */
+	u32 offset;		/* Offset of the 1st resource */
+	u32 vf_size;
+	u32 vf_offset;
+	u32 flags;
+#define RESOURCE_ELEMENT_STRICT BIT(0)
+};
+
+#define DRV_ROLE_NONE           0
+#define DRV_ROLE_PREBOOT        1
+#define DRV_ROLE_OS             2
+#define DRV_ROLE_KDUMP          3
+
+struct load_req_stc {
+	u32 drv_ver_0;
+	u32 drv_ver_1;
+	u32 fw_ver;
+	u32 misc0;
+#define LOAD_REQ_ROLE_MASK              0x000000FF
+#define LOAD_REQ_ROLE_SHIFT             0
+#define LOAD_REQ_LOCK_TO_MASK           0x0000FF00
+#define LOAD_REQ_LOCK_TO_SHIFT          8
+#define LOAD_REQ_LOCK_TO_DEFAULT        0
+#define LOAD_REQ_LOCK_TO_NONE           255
+#define LOAD_REQ_FORCE_MASK             0x000F0000
+#define LOAD_REQ_FORCE_SHIFT            16
+#define LOAD_REQ_FORCE_NONE             0
+#define LOAD_REQ_FORCE_PF               1
+#define LOAD_REQ_FORCE_ALL              2
+#define LOAD_REQ_FLAGS0_MASK            0x00F00000
+#define LOAD_REQ_FLAGS0_SHIFT           20
+#define LOAD_REQ_FLAGS0_AVOID_RESET     (0x1 << 0)
+};
+
+struct load_rsp_stc {
+	u32 drv_ver_0;
+	u32 drv_ver_1;
+	u32 fw_ver;
+	u32 misc0;
+#define LOAD_RSP_ROLE_MASK              0x000000FF
+#define LOAD_RSP_ROLE_SHIFT             0
+#define LOAD_RSP_HSI_MASK               0x0000FF00
+#define LOAD_RSP_HSI_SHIFT              8
+#define LOAD_RSP_FLAGS0_MASK            0x000F0000
+#define LOAD_RSP_FLAGS0_SHIFT           16
+#define LOAD_RSP_FLAGS0_DRV_EXISTS      (0x1 << 0)
+};
+
+struct mdump_retain_data_stc {
+	u32 valid;
+	u32 epoch;
+	u32 pf;
+	u32 status;
+};
+
+union drv_union_data {
+	u32 ver_str[MCP_DRV_VER_STR_SIZE_DWORD];
+	struct mcp_mac wol_mac;
+
+	struct eth_phy_cfg drv_phy_cfg;
+
+	struct mcp_val64 val64;
+
+	u8 raw_data[MCP_DRV_NVM_BUF_LEN];
+
+	struct mcp_file_att file_att;
+
+	u32 ack_vf_disabled[VF_MAX_STATIC / 32];
+
+	struct drv_version_stc drv_version;
+
+	struct lan_stats_stc lan_stats;
+	struct fcoe_stats_stc fcoe_stats;
+	struct ocbb_data_stc ocbb_info;
+	struct temperature_status_stc temp_info;
+	struct resource_info resource;
+	struct bist_nvm_image_att nvm_image_att;
+	struct mdump_config_stc mdump_config;
+};
+
+struct public_drv_mb {
+	u32 drv_mb_header;
+#define DRV_MSG_CODE_MASK			0xffff0000
+#define DRV_MSG_CODE_LOAD_REQ			0x10000000
+#define DRV_MSG_CODE_LOAD_DONE			0x11000000
+#define DRV_MSG_CODE_INIT_HW			0x12000000
+#define DRV_MSG_CODE_CANCEL_LOAD_REQ            0x13000000
+#define DRV_MSG_CODE_UNLOAD_REQ			0x20000000
+#define DRV_MSG_CODE_UNLOAD_DONE		0x21000000
+#define DRV_MSG_CODE_INIT_PHY			0x22000000
+#define DRV_MSG_CODE_LINK_RESET			0x23000000
+#define DRV_MSG_CODE_SET_DCBX			0x25000000
+#define DRV_MSG_CODE_OV_UPDATE_CURR_CFG         0x26000000
+#define DRV_MSG_CODE_OV_UPDATE_BUS_NUM          0x27000000
+#define DRV_MSG_CODE_OV_UPDATE_BOOT_PROGRESS    0x28000000
+#define DRV_MSG_CODE_OV_UPDATE_STORM_FW_VER     0x29000000
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE     0x31000000
+#define DRV_MSG_CODE_BW_UPDATE_ACK              0x32000000
+#define DRV_MSG_CODE_OV_UPDATE_MTU              0x33000000
+#define DRV_MSG_GET_RESOURCE_ALLOC_MSG		0x34000000
+#define DRV_MSG_SET_RESOURCE_VALUE_MSG		0x35000000
+#define DRV_MSG_CODE_OV_UPDATE_WOL              0x38000000
+#define DRV_MSG_CODE_OV_UPDATE_ESWITCH_MODE     0x39000000
+#define DRV_MSG_CODE_GET_OEM_UPDATES            0x41000000
+
+#define DRV_MSG_CODE_BW_UPDATE_ACK		0x32000000
+#define DRV_MSG_CODE_NIG_DRAIN			0x30000000
+#define DRV_MSG_CODE_S_TAG_UPDATE_ACK		0x3b000000
+#define DRV_MSG_CODE_GET_NVM_CFG_OPTION		0x003e0000
+#define DRV_MSG_CODE_SET_NVM_CFG_OPTION		0x003f0000
+#define DRV_MSG_CODE_INITIATE_PF_FLR            0x02010000
+#define DRV_MSG_CODE_VF_DISABLED_DONE		0xc0000000
+#define DRV_MSG_CODE_CFG_VF_MSIX		0xc0010000
+#define DRV_MSG_CODE_CFG_PF_VFS_MSIX		0xc0020000
+#define DRV_MSG_CODE_NVM_PUT_FILE_BEGIN		0x00010000
+#define DRV_MSG_CODE_NVM_PUT_FILE_DATA		0x00020000
+#define DRV_MSG_CODE_NVM_GET_FILE_ATT		0x00030000
+#define DRV_MSG_CODE_NVM_READ_NVRAM		0x00050000
+#define DRV_MSG_CODE_NVM_WRITE_NVRAM		0x00060000
+#define DRV_MSG_CODE_MCP_RESET			0x00090000
+#define DRV_MSG_CODE_SET_VERSION		0x000f0000
+#define DRV_MSG_CODE_MCP_HALT                   0x00100000
+#define DRV_MSG_CODE_SET_VMAC                   0x00110000
+#define DRV_MSG_CODE_GET_VMAC                   0x00120000
+#define DRV_MSG_CODE_VMAC_TYPE_SHIFT            4
+#define DRV_MSG_CODE_VMAC_TYPE_MASK             0x30
+#define DRV_MSG_CODE_VMAC_TYPE_MAC              1
+#define DRV_MSG_CODE_VMAC_TYPE_WWNN             2
+#define DRV_MSG_CODE_VMAC_TYPE_WWPN             3
+
+#define DRV_MSG_CODE_GET_STATS                  0x00130000
+#define DRV_MSG_CODE_STATS_TYPE_LAN             1
+#define DRV_MSG_CODE_STATS_TYPE_FCOE            2
+#define DRV_MSG_CODE_STATS_TYPE_ISCSI           3
+#define DRV_MSG_CODE_STATS_TYPE_RDMA            4
+
+#define DRV_MSG_CODE_TRANSCEIVER_READ           0x00160000
+
+#define DRV_MSG_CODE_MASK_PARITIES              0x001a0000
+
+#define DRV_MSG_CODE_BIST_TEST			0x001e0000
+#define DRV_MSG_CODE_SET_LED_MODE		0x00200000
+#define DRV_MSG_CODE_RESOURCE_CMD		0x00230000
+/* Send crash dump commands with param[3:0] - opcode */
+#define DRV_MSG_CODE_MDUMP_CMD			0x00250000
+#define DRV_MSG_CODE_GET_TLV_DONE		0x002f0000
+#define DRV_MSG_CODE_GET_ENGINE_CONFIG		0x00370000
+#define DRV_MSG_CODE_GET_PPFID_BITMAP		0x43000000
+
+#define DRV_MSG_CODE_DEBUG_DATA_SEND		0xc0040000
+
+#define RESOURCE_CMD_REQ_RESC_MASK		0x0000001F
+#define RESOURCE_CMD_REQ_RESC_SHIFT		0
+#define RESOURCE_CMD_REQ_OPCODE_MASK		0x000000E0
+#define RESOURCE_CMD_REQ_OPCODE_SHIFT		5
+#define RESOURCE_OPCODE_REQ			1
+#define RESOURCE_OPCODE_REQ_WO_AGING		2
+#define RESOURCE_OPCODE_REQ_W_AGING		3
+#define RESOURCE_OPCODE_RELEASE			4
+#define RESOURCE_OPCODE_FORCE_RELEASE		5
+#define RESOURCE_CMD_REQ_AGE_MASK		0x0000FF00
+#define RESOURCE_CMD_REQ_AGE_SHIFT		8
+
+#define RESOURCE_CMD_RSP_OWNER_MASK		0x000000FF
+#define RESOURCE_CMD_RSP_OWNER_SHIFT		0
+#define RESOURCE_CMD_RSP_OPCODE_MASK		0x00000700
+#define RESOURCE_CMD_RSP_OPCODE_SHIFT		8
+#define RESOURCE_OPCODE_GNT			1
+#define RESOURCE_OPCODE_BUSY			2
+#define RESOURCE_OPCODE_RELEASED		3
+#define RESOURCE_OPCODE_RELEASED_PREVIOUS	4
+#define RESOURCE_OPCODE_WRONG_OWNER		5
+#define RESOURCE_OPCODE_UNKNOWN_CMD		255
+
+#define RESOURCE_DUMP				0
+
+/* DRV_MSG_CODE_MDUMP_CMD parameters */
+#define MDUMP_DRV_PARAM_OPCODE_MASK             0x0000000f
+#define DRV_MSG_CODE_MDUMP_ACK                  0x01
+#define DRV_MSG_CODE_MDUMP_SET_VALUES           0x02
+#define DRV_MSG_CODE_MDUMP_TRIGGER              0x03
+#define DRV_MSG_CODE_MDUMP_GET_CONFIG           0x04
+#define DRV_MSG_CODE_MDUMP_SET_ENABLE           0x05
+#define DRV_MSG_CODE_MDUMP_CLEAR_LOGS           0x06
+#define DRV_MSG_CODE_MDUMP_GET_RETAIN           0x07
+#define DRV_MSG_CODE_MDUMP_CLR_RETAIN           0x08
+
+#define DRV_MSG_CODE_HW_DUMP_TRIGGER            0x0a
+#define DRV_MSG_CODE_MDUMP_GEN_MDUMP2           0x0b
+#define DRV_MSG_CODE_MDUMP_FREE_MDUMP2          0x0c
+
+#define DRV_MSG_CODE_GET_PF_RDMA_PROTOCOL	0x002b0000
+#define DRV_MSG_CODE_OS_WOL			0x002e0000
+
+#define DRV_MSG_CODE_FEATURE_SUPPORT		0x00300000
+#define DRV_MSG_CODE_GET_MFW_FEATURE_SUPPORT	0x00310000
+#define DRV_MSG_SEQ_NUMBER_MASK			0x0000ffff
+
+	u32 drv_mb_param;
+#define DRV_MB_PARAM_UNLOAD_WOL_UNKNOWN         0x00000000
+#define DRV_MB_PARAM_UNLOAD_WOL_MCP             0x00000001
+#define DRV_MB_PARAM_UNLOAD_WOL_DISABLED        0x00000002
+#define DRV_MB_PARAM_UNLOAD_WOL_ENABLED         0x00000003
+#define DRV_MB_PARAM_DCBX_NOTIFY_MASK		0x000000FF
+#define DRV_MB_PARAM_DCBX_NOTIFY_SHIFT		3
+
+#define DRV_MB_PARAM_NVM_PUT_FILE_BEGIN_MBI     0x3
+#define DRV_MB_PARAM_NVM_OFFSET_OFFSET          0
+#define DRV_MB_PARAM_NVM_OFFSET_MASK            0x00FFFFFF
+#define DRV_MB_PARAM_NVM_LEN_OFFSET		24
+#define DRV_MB_PARAM_NVM_LEN_MASK               0xFF000000
+
+#define DRV_MB_PARAM_CFG_VF_MSIX_VF_ID_SHIFT	0
+#define DRV_MB_PARAM_CFG_VF_MSIX_VF_ID_MASK	0x000000FF
+#define DRV_MB_PARAM_CFG_VF_MSIX_SB_NUM_SHIFT	8
+#define DRV_MB_PARAM_CFG_VF_MSIX_SB_NUM_MASK	0x0000FF00
+#define DRV_MB_PARAM_LLDP_SEND_MASK		0x00000001
+#define DRV_MB_PARAM_LLDP_SEND_SHIFT		0
+
+#define DRV_MB_PARAM_OV_CURR_CFG_SHIFT		0
+#define DRV_MB_PARAM_OV_CURR_CFG_MASK		0x0000000F
+#define DRV_MB_PARAM_OV_CURR_CFG_NONE		0
+#define DRV_MB_PARAM_OV_CURR_CFG_OS		1
+#define DRV_MB_PARAM_OV_CURR_CFG_VENDOR_SPEC	2
+#define DRV_MB_PARAM_OV_CURR_CFG_OTHER		3
+
+#define DRV_MB_PARAM_OV_STORM_FW_VER_SHIFT	0
+#define DRV_MB_PARAM_OV_STORM_FW_VER_MASK	0xFFFFFFFF
+#define DRV_MB_PARAM_OV_STORM_FW_VER_MAJOR_MASK	0xFF000000
+#define DRV_MB_PARAM_OV_STORM_FW_VER_MINOR_MASK	0x00FF0000
+#define DRV_MB_PARAM_OV_STORM_FW_VER_BUILD_MASK	0x0000FF00
+#define DRV_MB_PARAM_OV_STORM_FW_VER_DROP_MASK	0x000000FF
+
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_SHIFT	0
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_MASK	0xF
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_UNKNOWN	0x1
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_NOT_LOADED	0x2
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_LOADING	0x3
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_DISABLED	0x4
+#define DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE_ACTIVE	0x5
+
+#define DRV_MB_PARAM_OV_MTU_SIZE_SHIFT	0
+#define DRV_MB_PARAM_OV_MTU_SIZE_MASK	0xFFFFFFFF
+
+#define DRV_MB_PARAM_WOL_MASK	(DRV_MB_PARAM_WOL_DEFAULT | \
+				 DRV_MB_PARAM_WOL_DISABLED | \
+				 DRV_MB_PARAM_WOL_ENABLED)
+#define DRV_MB_PARAM_WOL_DEFAULT	DRV_MB_PARAM_UNLOAD_WOL_MCP
+#define DRV_MB_PARAM_WOL_DISABLED	DRV_MB_PARAM_UNLOAD_WOL_DISABLED
+#define DRV_MB_PARAM_WOL_ENABLED	DRV_MB_PARAM_UNLOAD_WOL_ENABLED
+
+#define DRV_MB_PARAM_ESWITCH_MODE_MASK	(DRV_MB_PARAM_ESWITCH_MODE_NONE | \
+					 DRV_MB_PARAM_ESWITCH_MODE_VEB | \
+					 DRV_MB_PARAM_ESWITCH_MODE_VEPA)
+#define DRV_MB_PARAM_ESWITCH_MODE_NONE	0x0
+#define DRV_MB_PARAM_ESWITCH_MODE_VEB	0x1
+#define DRV_MB_PARAM_ESWITCH_MODE_VEPA	0x2
+
+#define DRV_MB_PARAM_DUMMY_OEM_UPDATES_MASK	0x1
+#define DRV_MB_PARAM_DUMMY_OEM_UPDATES_OFFSET	0
+
+#define DRV_MB_PARAM_SET_LED_MODE_OPER		0x0
+#define DRV_MB_PARAM_SET_LED_MODE_ON		0x1
+#define DRV_MB_PARAM_SET_LED_MODE_OFF		0x2
+
+#define DRV_MB_PARAM_TRANSCEIVER_PORT_OFFSET			0
+#define DRV_MB_PARAM_TRANSCEIVER_PORT_MASK			0x00000003
+#define DRV_MB_PARAM_TRANSCEIVER_SIZE_OFFSET			2
+#define DRV_MB_PARAM_TRANSCEIVER_SIZE_MASK			0x000000fc
+#define DRV_MB_PARAM_TRANSCEIVER_I2C_ADDRESS_OFFSET		8
+#define DRV_MB_PARAM_TRANSCEIVER_I2C_ADDRESS_MASK		0x0000ff00
+#define DRV_MB_PARAM_TRANSCEIVER_OFFSET_OFFSET			16
+#define DRV_MB_PARAM_TRANSCEIVER_OFFSET_MASK			0xffff0000
+
+	/* Resource Allocation params - Driver version support */
+#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_MASK		0xffff0000
+#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_SHIFT		16
+#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_MASK		0x0000ffff
+#define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_SHIFT		0
+
+#define DRV_MB_PARAM_BIST_REGISTER_TEST				1
+#define DRV_MB_PARAM_BIST_CLOCK_TEST				2
+#define DRV_MB_PARAM_BIST_NVM_TEST_NUM_IMAGES			3
+#define DRV_MB_PARAM_BIST_NVM_TEST_IMAGE_BY_INDEX		4
+
+#define DRV_MB_PARAM_BIST_RC_UNKNOWN				0
+#define DRV_MB_PARAM_BIST_RC_PASSED				1
+#define DRV_MB_PARAM_BIST_RC_FAILED				2
+#define DRV_MB_PARAM_BIST_RC_INVALID_PARAMETER			3
+
+#define DRV_MB_PARAM_BIST_TEST_INDEX_SHIFT			0
+#define DRV_MB_PARAM_BIST_TEST_INDEX_MASK			0x000000ff
+#define DRV_MB_PARAM_BIST_TEST_IMAGE_INDEX_SHIFT		8
+#define DRV_MB_PARAM_BIST_TEST_IMAGE_INDEX_MASK			0x0000ff00
+
+#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_MASK			0x0000ffff
+#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_OFFSET		0
+#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EEE			0x00000002
+#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_FEC_CONTROL		0x00000004
+#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EXT_SPEED_FEC_CONTROL	0x00000008
+#define DRV_MB_PARAM_FEATURE_SUPPORT_FUNC_VLINK			0x00010000
+
+/* DRV_MSG_CODE_DEBUG_DATA_SEND parameters */
+#define DRV_MSG_CODE_DEBUG_DATA_SEND_SIZE_OFFSET		0
+#define DRV_MSG_CODE_DEBUG_DATA_SEND_SIZE_MASK			0xff
+
+/* Driver attributes params */
+#define DRV_MB_PARAM_ATTRIBUTE_KEY_OFFSET			0
+#define DRV_MB_PARAM_ATTRIBUTE_KEY_MASK				0x00ffffff
+#define DRV_MB_PARAM_ATTRIBUTE_CMD_OFFSET			24
+#define DRV_MB_PARAM_ATTRIBUTE_CMD_MASK				0xff000000
+
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_OFFSET			0
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_SHIFT			0
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_MASK			0x0000ffff
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ALL_SHIFT			16
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ALL_MASK			0x00010000
+#define DRV_MB_PARAM_NVM_CFG_OPTION_INIT_SHIFT			17
+#define DRV_MB_PARAM_NVM_CFG_OPTION_INIT_MASK			0x00020000
+#define DRV_MB_PARAM_NVM_CFG_OPTION_COMMIT_SHIFT		18
+#define DRV_MB_PARAM_NVM_CFG_OPTION_COMMIT_MASK			0x00040000
+#define DRV_MB_PARAM_NVM_CFG_OPTION_FREE_SHIFT			19
+#define DRV_MB_PARAM_NVM_CFG_OPTION_FREE_MASK			0x00080000
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_SEL_SHIFT		20
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_SEL_MASK		0x00100000
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_ID_SHIFT		24
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_ID_MASK		0x0f000000
+
+	u32 fw_mb_header;
+#define FW_MSG_CODE_MASK			0xffff0000
+#define FW_MSG_CODE_UNSUPPORTED                 0x00000000
+#define FW_MSG_CODE_DRV_LOAD_ENGINE		0x10100000
+#define FW_MSG_CODE_DRV_LOAD_PORT		0x10110000
+#define FW_MSG_CODE_DRV_LOAD_FUNCTION		0x10120000
+#define FW_MSG_CODE_DRV_LOAD_REFUSED_PDA	0x10200000
+#define FW_MSG_CODE_DRV_LOAD_REFUSED_HSI_1	0x10210000
+#define FW_MSG_CODE_DRV_LOAD_REFUSED_DIAG	0x10220000
+#define FW_MSG_CODE_DRV_LOAD_REFUSED_HSI        0x10230000
+#define FW_MSG_CODE_DRV_LOAD_REFUSED_REQUIRES_FORCE 0x10300000
+#define FW_MSG_CODE_DRV_LOAD_REFUSED_REJECT     0x10310000
+#define FW_MSG_CODE_DRV_LOAD_DONE		0x11100000
+#define FW_MSG_CODE_DRV_UNLOAD_ENGINE		0x20110000
+#define FW_MSG_CODE_DRV_UNLOAD_PORT		0x20120000
+#define FW_MSG_CODE_DRV_UNLOAD_FUNCTION		0x20130000
+#define FW_MSG_CODE_DRV_UNLOAD_DONE		0x21100000
+#define FW_MSG_CODE_RESOURCE_ALLOC_OK           0x34000000
+#define FW_MSG_CODE_RESOURCE_ALLOC_UNKNOWN      0x35000000
+#define FW_MSG_CODE_RESOURCE_ALLOC_DEPRECATED   0x36000000
+#define FW_MSG_CODE_S_TAG_UPDATE_ACK_DONE	0x3b000000
+#define FW_MSG_CODE_DRV_CFG_VF_MSIX_DONE	0xb0010000
+
+#define FW_MSG_CODE_NVM_OK			0x00010000
+#define FW_MSG_CODE_NVM_PUT_FILE_FINISH_OK	0x00400000
+#define FW_MSG_CODE_PHY_OK			0x00110000
+#define FW_MSG_CODE_OK				0x00160000
+#define FW_MSG_CODE_ERROR			0x00170000
+#define FW_MSG_CODE_TRANSCEIVER_DIAG_OK		0x00160000
+#define FW_MSG_CODE_TRANSCEIVER_DIAG_ERROR	0x00170000
+#define FW_MSG_CODE_TRANSCEIVER_NOT_PRESENT	0x00020000
+
+#define FW_MSG_CODE_OS_WOL_SUPPORTED            0x00800000
+#define FW_MSG_CODE_OS_WOL_NOT_SUPPORTED        0x00810000
+#define FW_MSG_CODE_DRV_CFG_PF_VFS_MSIX_DONE	0x00870000
+#define FW_MSG_SEQ_NUMBER_MASK			0x0000ffff
+
+#define FW_MSG_CODE_DEBUG_DATA_SEND_INV_ARG	0xb0070000
+#define FW_MSG_CODE_DEBUG_DATA_SEND_BUF_FULL	0xb0080000
+#define FW_MSG_CODE_DEBUG_DATA_SEND_NO_BUF	0xb0090000
+#define FW_MSG_CODE_DEBUG_NOT_ENABLED		0xb00a0000
+#define FW_MSG_CODE_DEBUG_DATA_SEND_OK		0xb00b0000
+
+#define FW_MSG_CODE_MDUMP_INVALID_CMD		0x00030000
+
+	u32							fw_mb_param;
+#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_MASK		0xffff0000
+#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_SHIFT		16
+#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_MASK		0x0000ffff
+#define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_SHIFT		0
+
+	/* Get PF RDMA protocol command response */
+#define FW_MB_PARAM_GET_PF_RDMA_NONE				0x0
+#define FW_MB_PARAM_GET_PF_RDMA_ROCE				0x1
+#define FW_MB_PARAM_GET_PF_RDMA_IWARP				0x2
+#define FW_MB_PARAM_GET_PF_RDMA_BOTH				0x3
+
+	/* Get MFW feature support response */
+#define FW_MB_PARAM_FEATURE_SUPPORT_SMARTLINQ			BIT(0)
+#define FW_MB_PARAM_FEATURE_SUPPORT_EEE				BIT(1)
+#define FW_MB_PARAM_FEATURE_SUPPORT_FEC_CONTROL			BIT(5)
+#define FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL	BIT(6)
+#define FW_MB_PARAM_FEATURE_SUPPORT_VLINK			BIT(16)
+
+#define FW_MB_PARAM_LOAD_DONE_DID_EFUSE_ERROR			BIT(0)
+
+#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALID_MASK		0x00000001
+#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALID_SHIFT		0
+#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALUE_MASK		0x00000002
+#define FW_MB_PARAM_ENG_CFG_FIR_AFFIN_VALUE_SHIFT		1
+#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALID_MASK			0x00000004
+#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALID_SHIFT		2
+#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALUE_MASK			0x00000008
+#define FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALUE_SHIFT		3
+
+#define FW_MB_PARAM_PPFID_BITMAP_MASK				0xff
+#define FW_MB_PARAM_PPFID_BITMAP_SHIFT				0
+
+	u32							drv_pulse_mb;
+#define DRV_PULSE_SEQ_MASK					0x00007fff
+#define DRV_PULSE_SYSTEM_TIME_MASK				0xffff0000
+#define DRV_PULSE_ALWAYS_ALIVE					0x00008000
+
+	u32							mcp_pulse_mb;
+#define MCP_PULSE_SEQ_MASK					0x00007fff
+#define MCP_PULSE_ALWAYS_ALIVE					0x00008000
+#define MCP_EVENT_MASK						0xffff0000
+#define MCP_EVENT_OTHER_DRIVER_RESET_REQ			0x00010000
+
+	union drv_union_data					union_data;
+};
+
+#define FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET_MASK		0x00ffffff
+#define FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET_SHIFT		0
+#define FW_MB_PARAM_NVM_PUT_FILE_REQ_SIZE_MASK			0xff000000
+#define FW_MB_PARAM_NVM_PUT_FILE_REQ_SIZE_SHIFT			24
+
+enum MFW_DRV_MSG_TYPE {
+	MFW_DRV_MSG_LINK_CHANGE,
+	MFW_DRV_MSG_FLR_FW_ACK_FAILED,
+	MFW_DRV_MSG_VF_DISABLED,
+	MFW_DRV_MSG_LLDP_DATA_UPDATED,
+	MFW_DRV_MSG_DCBX_REMOTE_MIB_UPDATED,
+	MFW_DRV_MSG_DCBX_OPERATIONAL_MIB_UPDATED,
+	MFW_DRV_MSG_ERROR_RECOVERY,
+	MFW_DRV_MSG_BW_UPDATE,
+	MFW_DRV_MSG_S_TAG_UPDATE,
+	MFW_DRV_MSG_GET_LAN_STATS,
+	MFW_DRV_MSG_GET_FCOE_STATS,
+	MFW_DRV_MSG_GET_ISCSI_STATS,
+	MFW_DRV_MSG_GET_RDMA_STATS,
+	MFW_DRV_MSG_FAILURE_DETECTED,
+	MFW_DRV_MSG_TRANSCEIVER_STATE_CHANGE,
+	MFW_DRV_MSG_CRITICAL_ERROR_OCCURRED,
+	MFW_DRV_MSG_RESERVED,
+	MFW_DRV_MSG_GET_TLV_REQ,
+	MFW_DRV_MSG_OEM_CFG_UPDATE,
+	MFW_DRV_MSG_MAX
+};
+
+#define MFW_DRV_MSG_MAX_DWORDS(msgs)	((((msgs) - 1) >> 2) + 1)
+#define MFW_DRV_MSG_DWORD(msg_id)	((msg_id) >> 2)
+#define MFW_DRV_MSG_OFFSET(msg_id)	(((msg_id) & 0x3) << 3)
+#define MFW_DRV_MSG_MASK(msg_id)	(0xff << MFW_DRV_MSG_OFFSET(msg_id))
+
+struct public_mfw_mb {
+	u32 sup_msgs;
+	u32 msg[MFW_DRV_MSG_MAX_DWORDS(MFW_DRV_MSG_MAX)];
+	u32 ack[MFW_DRV_MSG_MAX_DWORDS(MFW_DRV_MSG_MAX)];
+};
+
+enum public_sections {
+	PUBLIC_DRV_MB,
+	PUBLIC_MFW_MB,
+	PUBLIC_GLOBAL,
+	PUBLIC_PATH,
+	PUBLIC_PORT,
+	PUBLIC_FUNC,
+	PUBLIC_MAX_SECTIONS
+};
+
+struct mcp_public_data {
+	u32 num_sections;
+	u32 sections[PUBLIC_MAX_SECTIONS];
+	struct public_drv_mb drv_mb[MCP_GLOB_FUNC_MAX];
+	struct public_mfw_mb mfw_mb[MCP_GLOB_FUNC_MAX];
+	struct public_global global;
+	struct public_path path[MCP_GLOB_PATH_MAX];
+	struct public_port port[MCP_GLOB_PORT_MAX];
+	struct public_func func[MCP_GLOB_FUNC_MAX];
+};
+
+#define MAX_I2C_TRANSACTION_SIZE	16
+
+/* OCBB definitions */
+enum tlvs {
+	/* Category 1: Device Properties */
+	DRV_TLV_CLP_STR,
+	DRV_TLV_CLP_STR_CTD,
+	/* Category 6: Device Configuration */
+	DRV_TLV_SCSI_TO,
+	DRV_TLV_R_T_TOV,
+	DRV_TLV_R_A_TOV,
+	DRV_TLV_E_D_TOV,
+	DRV_TLV_CR_TOV,
+	DRV_TLV_BOOT_TYPE,
+	/* Category 8: Port Configuration */
+	DRV_TLV_NPIV_ENABLED,
+	/* Category 10: Function Configuration */
+	DRV_TLV_FEATURE_FLAGS,
+	DRV_TLV_LOCAL_ADMIN_ADDR,
+	DRV_TLV_ADDITIONAL_MAC_ADDR_1,
+	DRV_TLV_ADDITIONAL_MAC_ADDR_2,
+	DRV_TLV_LSO_MAX_OFFLOAD_SIZE,
+	DRV_TLV_LSO_MIN_SEGMENT_COUNT,
+	DRV_TLV_PROMISCUOUS_MODE,
+	DRV_TLV_TX_DESCRIPTORS_QUEUE_SIZE,
+	DRV_TLV_RX_DESCRIPTORS_QUEUE_SIZE,
+	DRV_TLV_NUM_OF_NET_QUEUE_VMQ_CFG,
+	DRV_TLV_FLEX_NIC_OUTER_VLAN_ID,
+	DRV_TLV_OS_DRIVER_STATES,
+	DRV_TLV_PXE_BOOT_PROGRESS,
+	/* Category 12: FC/FCoE Configuration */
+	DRV_TLV_NPIV_STATE,
+	DRV_TLV_NUM_OF_NPIV_IDS,
+	DRV_TLV_SWITCH_NAME,
+	DRV_TLV_SWITCH_PORT_NUM,
+	DRV_TLV_SWITCH_PORT_ID,
+	DRV_TLV_VENDOR_NAME,
+	DRV_TLV_SWITCH_MODEL,
+	DRV_TLV_SWITCH_FW_VER,
+	DRV_TLV_QOS_PRIORITY_PER_802_1P,
+	DRV_TLV_PORT_ALIAS,
+	DRV_TLV_PORT_STATE,
+	DRV_TLV_FIP_TX_DESCRIPTORS_QUEUE_SIZE,
+	DRV_TLV_FCOE_RX_DESCRIPTORS_QUEUE_SIZE,
+	DRV_TLV_LINK_FAILURE_COUNT,
+	DRV_TLV_FCOE_BOOT_PROGRESS,
+	/* Category 13: iSCSI Configuration */
+	DRV_TLV_TARGET_LLMNR_ENABLED,
+	DRV_TLV_HEADER_DIGEST_FLAG_ENABLED,
+	DRV_TLV_DATA_DIGEST_FLAG_ENABLED,
+	DRV_TLV_AUTHENTICATION_METHOD,
+	DRV_TLV_ISCSI_BOOT_TARGET_PORTAL,
+	DRV_TLV_MAX_FRAME_SIZE,
+	DRV_TLV_PDU_TX_DESCRIPTORS_QUEUE_SIZE,
+	DRV_TLV_PDU_RX_DESCRIPTORS_QUEUE_SIZE,
+	DRV_TLV_ISCSI_BOOT_PROGRESS,
+	/* Category 20: Device Data */
+	DRV_TLV_PCIE_BUS_RX_UTILIZATION,
+	DRV_TLV_PCIE_BUS_TX_UTILIZATION,
+	DRV_TLV_DEVICE_CPU_CORES_UTILIZATION,
+	DRV_TLV_LAST_VALID_DCC_TLV_RECEIVED,
+	DRV_TLV_NCSI_RX_BYTES_RECEIVED,
+	DRV_TLV_NCSI_TX_BYTES_SENT,
+	/* Category 22: Base Port Data */
+	DRV_TLV_RX_DISCARDS,
+	DRV_TLV_RX_ERRORS,
+	DRV_TLV_TX_ERRORS,
+	DRV_TLV_TX_DISCARDS,
+	DRV_TLV_RX_FRAMES_RECEIVED,
+	DRV_TLV_TX_FRAMES_SENT,
+	/* Category 23: FC/FCoE Port Data */
+	DRV_TLV_RX_BROADCAST_PACKETS,
+	DRV_TLV_TX_BROADCAST_PACKETS,
+	/* Category 28: Base Function Data */
+	DRV_TLV_NUM_OFFLOADED_CONNECTIONS_TCP_IPV4,
+	DRV_TLV_NUM_OFFLOADED_CONNECTIONS_TCP_IPV6,
+	DRV_TLV_TX_DESCRIPTOR_QUEUE_AVG_DEPTH,
+	DRV_TLV_RX_DESCRIPTORS_QUEUE_AVG_DEPTH,
+	DRV_TLV_PF_RX_FRAMES_RECEIVED,
+	DRV_TLV_RX_BYTES_RECEIVED,
+	DRV_TLV_PF_TX_FRAMES_SENT,
+	DRV_TLV_TX_BYTES_SENT,
+	DRV_TLV_IOV_OFFLOAD,
+	DRV_TLV_PCI_ERRORS_CAP_ID,
+	DRV_TLV_UNCORRECTABLE_ERROR_STATUS,
+	DRV_TLV_UNCORRECTABLE_ERROR_MASK,
+	DRV_TLV_CORRECTABLE_ERROR_STATUS,
+	DRV_TLV_CORRECTABLE_ERROR_MASK,
+	DRV_TLV_PCI_ERRORS_AECC_REGISTER,
+	DRV_TLV_TX_QUEUES_EMPTY,
+	DRV_TLV_RX_QUEUES_EMPTY,
+	DRV_TLV_TX_QUEUES_FULL,
+	DRV_TLV_RX_QUEUES_FULL,
+	/* Category 29: FC/FCoE Function Data */
+	DRV_TLV_FCOE_TX_DESCRIPTOR_QUEUE_AVG_DEPTH,
+	DRV_TLV_FCOE_RX_DESCRIPTORS_QUEUE_AVG_DEPTH,
+	DRV_TLV_FCOE_RX_FRAMES_RECEIVED,
+	DRV_TLV_FCOE_RX_BYTES_RECEIVED,
+	DRV_TLV_FCOE_TX_FRAMES_SENT,
+	DRV_TLV_FCOE_TX_BYTES_SENT,
+	DRV_TLV_CRC_ERROR_COUNT,
+	DRV_TLV_CRC_ERROR_1_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_CRC_ERROR_1_TIMESTAMP,
+	DRV_TLV_CRC_ERROR_2_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_CRC_ERROR_2_TIMESTAMP,
+	DRV_TLV_CRC_ERROR_3_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_CRC_ERROR_3_TIMESTAMP,
+	DRV_TLV_CRC_ERROR_4_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_CRC_ERROR_4_TIMESTAMP,
+	DRV_TLV_CRC_ERROR_5_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_CRC_ERROR_5_TIMESTAMP,
+	DRV_TLV_LOSS_OF_SYNC_ERROR_COUNT,
+	DRV_TLV_LOSS_OF_SIGNAL_ERRORS,
+	DRV_TLV_PRIMITIVE_SEQUENCE_PROTOCOL_ERROR_COUNT,
+	DRV_TLV_DISPARITY_ERROR_COUNT,
+	DRV_TLV_CODE_VIOLATION_ERROR_COUNT,
+	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_1,
+	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_2,
+	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_3,
+	DRV_TLV_LAST_FLOGI_ISSUED_COMMON_PARAMETERS_WORD_4,
+	DRV_TLV_LAST_FLOGI_TIMESTAMP,
+	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_1,
+	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_2,
+	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_3,
+	DRV_TLV_LAST_FLOGI_ACC_COMMON_PARAMETERS_WORD_4,
+	DRV_TLV_LAST_FLOGI_ACC_TIMESTAMP,
+	DRV_TLV_LAST_FLOGI_RJT,
+	DRV_TLV_LAST_FLOGI_RJT_TIMESTAMP,
+	DRV_TLV_FDISCS_SENT_COUNT,
+	DRV_TLV_FDISC_ACCS_RECEIVED,
+	DRV_TLV_FDISC_RJTS_RECEIVED,
+	DRV_TLV_PLOGI_SENT_COUNT,
+	DRV_TLV_PLOGI_ACCS_RECEIVED,
+	DRV_TLV_PLOGI_RJTS_RECEIVED,
+	DRV_TLV_PLOGI_1_SENT_DESTINATION_FC_ID,
+	DRV_TLV_PLOGI_1_TIMESTAMP,
+	DRV_TLV_PLOGI_2_SENT_DESTINATION_FC_ID,
+	DRV_TLV_PLOGI_2_TIMESTAMP,
+	DRV_TLV_PLOGI_3_SENT_DESTINATION_FC_ID,
+	DRV_TLV_PLOGI_3_TIMESTAMP,
+	DRV_TLV_PLOGI_4_SENT_DESTINATION_FC_ID,
+	DRV_TLV_PLOGI_4_TIMESTAMP,
+	DRV_TLV_PLOGI_5_SENT_DESTINATION_FC_ID,
+	DRV_TLV_PLOGI_5_TIMESTAMP,
+	DRV_TLV_PLOGI_1_ACC_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_PLOGI_1_ACC_TIMESTAMP,
+	DRV_TLV_PLOGI_2_ACC_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_PLOGI_2_ACC_TIMESTAMP,
+	DRV_TLV_PLOGI_3_ACC_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_PLOGI_3_ACC_TIMESTAMP,
+	DRV_TLV_PLOGI_4_ACC_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_PLOGI_4_ACC_TIMESTAMP,
+	DRV_TLV_PLOGI_5_ACC_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_PLOGI_5_ACC_TIMESTAMP,
+	DRV_TLV_LOGOS_ISSUED,
+	DRV_TLV_LOGO_ACCS_RECEIVED,
+	DRV_TLV_LOGO_RJTS_RECEIVED,
+	DRV_TLV_LOGO_1_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_LOGO_1_TIMESTAMP,
+	DRV_TLV_LOGO_2_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_LOGO_2_TIMESTAMP,
+	DRV_TLV_LOGO_3_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_LOGO_3_TIMESTAMP,
+	DRV_TLV_LOGO_4_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_LOGO_4_TIMESTAMP,
+	DRV_TLV_LOGO_5_RECEIVED_SOURCE_FC_ID,
+	DRV_TLV_LOGO_5_TIMESTAMP,
+	DRV_TLV_LOGOS_RECEIVED,
+	DRV_TLV_ACCS_ISSUED,
+	DRV_TLV_PRLIS_ISSUED,
+	DRV_TLV_ACCS_RECEIVED,
+	DRV_TLV_ABTS_SENT_COUNT,
+	DRV_TLV_ABTS_ACCS_RECEIVED,
+	DRV_TLV_ABTS_RJTS_RECEIVED,
+	DRV_TLV_ABTS_1_SENT_DESTINATION_FC_ID,
+	DRV_TLV_ABTS_1_TIMESTAMP,
+	DRV_TLV_ABTS_2_SENT_DESTINATION_FC_ID,
+	DRV_TLV_ABTS_2_TIMESTAMP,
+	DRV_TLV_ABTS_3_SENT_DESTINATION_FC_ID,
+	DRV_TLV_ABTS_3_TIMESTAMP,
+	DRV_TLV_ABTS_4_SENT_DESTINATION_FC_ID,
+	DRV_TLV_ABTS_4_TIMESTAMP,
+	DRV_TLV_ABTS_5_SENT_DESTINATION_FC_ID,
+	DRV_TLV_ABTS_5_TIMESTAMP,
+	DRV_TLV_RSCNS_RECEIVED,
+	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_1,
+	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_2,
+	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_3,
+	DRV_TLV_LAST_RSCN_RECEIVED_N_PORT_4,
+	DRV_TLV_LUN_RESETS_ISSUED,
+	DRV_TLV_ABORT_TASK_SETS_ISSUED,
+	DRV_TLV_TPRLOS_SENT,
+	DRV_TLV_NOS_SENT_COUNT,
+	DRV_TLV_NOS_RECEIVED_COUNT,
+	DRV_TLV_OLS_COUNT,
+	DRV_TLV_LR_COUNT,
+	DRV_TLV_LRR_COUNT,
+	DRV_TLV_LIP_SENT_COUNT,
+	DRV_TLV_LIP_RECEIVED_COUNT,
+	DRV_TLV_EOFA_COUNT,
+	DRV_TLV_EOFNI_COUNT,
+	DRV_TLV_SCSI_STATUS_CHECK_CONDITION_COUNT,
+	DRV_TLV_SCSI_STATUS_CONDITION_MET_COUNT,
+	DRV_TLV_SCSI_STATUS_BUSY_COUNT,
+	DRV_TLV_SCSI_STATUS_INTERMEDIATE_COUNT,
+	DRV_TLV_SCSI_STATUS_INTERMEDIATE_CONDITION_MET_COUNT,
+	DRV_TLV_SCSI_STATUS_RESERVATION_CONFLICT_COUNT,
+	DRV_TLV_SCSI_STATUS_TASK_SET_FULL_COUNT,
+	DRV_TLV_SCSI_STATUS_ACA_ACTIVE_COUNT,
+	DRV_TLV_SCSI_STATUS_TASK_ABORTED_COUNT,
+	DRV_TLV_SCSI_CHECK_CONDITION_1_RECEIVED_SK_ASC_ASCQ,
+	DRV_TLV_SCSI_CHECK_1_TIMESTAMP,
+	DRV_TLV_SCSI_CHECK_CONDITION_2_RECEIVED_SK_ASC_ASCQ,
+	DRV_TLV_SCSI_CHECK_2_TIMESTAMP,
+	DRV_TLV_SCSI_CHECK_CONDITION_3_RECEIVED_SK_ASC_ASCQ,
+	DRV_TLV_SCSI_CHECK_3_TIMESTAMP,
+	DRV_TLV_SCSI_CHECK_CONDITION_4_RECEIVED_SK_ASC_ASCQ,
+	DRV_TLV_SCSI_CHECK_4_TIMESTAMP,
+	DRV_TLV_SCSI_CHECK_CONDITION_5_RECEIVED_SK_ASC_ASCQ,
+	DRV_TLV_SCSI_CHECK_5_TIMESTAMP,
+	/* Category 30: iSCSI Function Data */
+	DRV_TLV_PDU_TX_DESCRIPTOR_QUEUE_AVG_DEPTH,
+	DRV_TLV_PDU_RX_DESCRIPTORS_QUEUE_AVG_DEPTH,
+	DRV_TLV_ISCSI_PDU_RX_FRAMES_RECEIVED,
+	DRV_TLV_ISCSI_PDU_RX_BYTES_RECEIVED,
+	DRV_TLV_ISCSI_PDU_TX_FRAMES_SENT,
+	DRV_TLV_ISCSI_PDU_TX_BYTES_SENT
+};
+
+struct nvm_cfg_mac_address {
+	u32 mac_addr_hi;
+#define NVM_CFG_MAC_ADDRESS_HI_MASK 0x0000ffff
+#define NVM_CFG_MAC_ADDRESS_HI_OFFSET 0
+
+	u32 mac_addr_lo;
+};
+
+struct nvm_cfg1_glob {
+	u32 generic_cont0;
+#define NVM_CFG1_GLOB_MF_MODE_MASK 0x00000ff0
+#define NVM_CFG1_GLOB_MF_MODE_OFFSET 4
+#define NVM_CFG1_GLOB_MF_MODE_MF_ALLOWED 0x0
+#define NVM_CFG1_GLOB_MF_MODE_DEFAULT 0x1
+#define NVM_CFG1_GLOB_MF_MODE_SPIO4 0x2
+#define NVM_CFG1_GLOB_MF_MODE_NPAR1_0 0x3
+#define NVM_CFG1_GLOB_MF_MODE_NPAR1_5 0x4
+#define NVM_CFG1_GLOB_MF_MODE_NPAR2_0 0x5
+#define NVM_CFG1_GLOB_MF_MODE_BD 0x6
+#define NVM_CFG1_GLOB_MF_MODE_UFP 0x7
+
+	u32 engineering_change[3];
+	u32 manufacturing_id;
+	u32 serial_number[4];
+	u32 pcie_cfg;
+	u32 mgmt_traffic;
+
+	u32 core_cfg;
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_MASK 0x000000ff
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_OFFSET 0
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_2X40G 0x0
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_2X50G 0x1
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_1X100G 0x2
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_4X10G_F 0x3
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_4X10G_E 0x4
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_BB_4X20G 0x5
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_1X40G 0xb
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_2X25G 0xc
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_1X25G 0xd
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_4X25G 0xe
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_2X10G 0xf
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_2X50G_R1 0x11
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_4X50G_R1 0x12
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_1X100G_R2 0x13
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_2X100G_R2 0x14
+#define NVM_CFG1_GLOB_NETWORK_PORT_MODE_AHP_1X100G_R4 0x15
+
+	u32 e_lane_cfg1;
+	u32 e_lane_cfg2;
+	u32 f_lane_cfg1;
+	u32 f_lane_cfg2;
+	u32 mps10_preemphasis;
+	u32 mps10_driver_current;
+	u32 mps25_preemphasis;
+	u32 mps25_driver_current;
+	u32 pci_id;
+	u32 pci_subsys_id;
+	u32 bar;
+	u32 mps10_txfir_main;
+	u32 mps10_txfir_post;
+	u32 mps25_txfir_main;
+	u32 mps25_txfir_post;
+	u32 manufacture_ver;
+	u32 manufacture_time;
+	u32 led_global_settings;
+	u32 generic_cont1;
+
+	u32 mbi_version;
+#define NVM_CFG1_GLOB_MBI_VERSION_0_MASK 0x000000ff
+#define NVM_CFG1_GLOB_MBI_VERSION_0_OFFSET 0
+#define NVM_CFG1_GLOB_MBI_VERSION_1_MASK 0x0000ff00
+#define NVM_CFG1_GLOB_MBI_VERSION_1_OFFSET 8
+#define NVM_CFG1_GLOB_MBI_VERSION_2_MASK 0x00ff0000
+#define NVM_CFG1_GLOB_MBI_VERSION_2_OFFSET 16
+
+	u32 mbi_date;
+	u32 misc_sig;
+
+	u32 device_capabilities;
+#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_ETHERNET 0x1
+#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_FCOE 0x2
+#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_ISCSI 0x4
+#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_ROCE 0x8
+#define NVM_CFG1_GLOB_DEVICE_CAPABILITIES_IWARP 0x10
+
+	u32 power_dissipated;
+	u32 power_consumed;
+	u32 efi_version;
+	u32 multi_network_modes_capability;
+	u32 reserved[41];
+};
+
+struct nvm_cfg1_path {
+	u32 reserved[30];
+};
+
+struct nvm_cfg1_port {
+	u32 rel_to_opt123;
+	u32 rel_to_opt124;
+
+	u32 generic_cont0;
+#define NVM_CFG1_PORT_DCBX_MODE_MASK 0x000f0000
+#define NVM_CFG1_PORT_DCBX_MODE_OFFSET 16
+#define NVM_CFG1_PORT_DCBX_MODE_DISABLED 0x0
+#define NVM_CFG1_PORT_DCBX_MODE_IEEE 0x1
+#define NVM_CFG1_PORT_DCBX_MODE_CEE 0x2
+#define NVM_CFG1_PORT_DCBX_MODE_DYNAMIC 0x3
+#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_MASK 0x00f00000
+#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_OFFSET 20
+#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_ETHERNET 0x1
+#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_FCOE 0x2
+#define NVM_CFG1_PORT_DEFAULT_ENABLED_PROTOCOLS_ISCSI 0x4
+
+	u32 pcie_cfg;
+	u32 features;
+
+	u32 speed_cap_mask;
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_MASK 0x0000ffff
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_OFFSET 0
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_1G 0x1
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_10G 0x2
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_20G 0x4
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_25G 0x8
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_40G 0x10
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_50G 0x20
+#define NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_BB_100G 0x40
+
+	u32 link_settings;
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_MASK 0x0000000f
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_OFFSET 0
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_AUTONEG 0x0
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_1G 0x1
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_10G 0x2
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_20G 0x3
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_25G 0x4
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_40G 0x5
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_50G 0x6
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_BB_100G 0x7
+#define NVM_CFG1_PORT_DRV_LINK_SPEED_SMARTLINQ 0x8
+#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_MASK 0x00000070
+#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_OFFSET 4
+#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_AUTONEG 0x1
+#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_RX 0x2
+#define NVM_CFG1_PORT_DRV_FLOW_CONTROL_TX 0x4
+#define NVM_CFG1_PORT_FEC_FORCE_MODE_MASK 0x000e0000
+#define NVM_CFG1_PORT_FEC_FORCE_MODE_OFFSET 17
+#define NVM_CFG1_PORT_FEC_FORCE_MODE_NONE 0x0
+#define NVM_CFG1_PORT_FEC_FORCE_MODE_FIRECODE 0x1
+#define NVM_CFG1_PORT_FEC_FORCE_MODE_RS 0x2
+#define NVM_CFG1_PORT_FEC_FORCE_MODE_AUTO 0x7
+
+	u32 phy_cfg;
+	u32 mgmt_traffic;
+
+	u32 ext_phy;
+	/* EEE power saving mode */
+#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_MASK 0x00ff0000
+#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_OFFSET 16
+#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_DISABLED 0x0
+#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_BALANCED 0x1
+#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_AGGRESSIVE 0x2
+#define NVM_CFG1_PORT_EEE_POWER_SAVING_MODE_LOW_LATENCY 0x3
+
+	u32 mba_cfg1;
+	u32 mba_cfg2;
+	u32							vf_cfg;
+	struct nvm_cfg_mac_address lldp_mac_address;
+	u32 led_port_settings;
+	u32 transceiver_00;
+	u32 device_ids;
+
+	u32 board_cfg;
+#define NVM_CFG1_PORT_PORT_TYPE_MASK 0x000000ff
+#define NVM_CFG1_PORT_PORT_TYPE_OFFSET 0
+#define NVM_CFG1_PORT_PORT_TYPE_UNDEFINED 0x0
+#define NVM_CFG1_PORT_PORT_TYPE_MODULE 0x1
+#define NVM_CFG1_PORT_PORT_TYPE_BACKPLANE 0x2
+#define NVM_CFG1_PORT_PORT_TYPE_EXT_PHY 0x3
+#define NVM_CFG1_PORT_PORT_TYPE_MODULE_SLAVE 0x4
+
+	u32 mnm_10g_cap;
+	u32 mnm_10g_ctrl;
+	u32 mnm_10g_misc;
+	u32 mnm_25g_cap;
+	u32 mnm_25g_ctrl;
+	u32 mnm_25g_misc;
+	u32 mnm_40g_cap;
+	u32 mnm_40g_ctrl;
+	u32 mnm_40g_misc;
+	u32 mnm_50g_cap;
+	u32 mnm_50g_ctrl;
+	u32 mnm_50g_misc;
+	u32 mnm_100g_cap;
+	u32 mnm_100g_ctrl;
+	u32 mnm_100g_misc;
+
+	u32 temperature;
+	u32 ext_phy_cfg1;
+
+	u32 extended_speed;
+#define NVM_CFG1_PORT_EXTENDED_SPEED_MASK 0x0000ffff
+#define NVM_CFG1_PORT_EXTENDED_SPEED_OFFSET 0
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_AN 0x1
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_1G 0x2
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_10G 0x4
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_20G 0x8
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_25G 0x10
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_40G 0x20
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R 0x40
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R2 0x80
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R2 0x100
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R4 0x200
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_P4 0x400
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_MASK 0xffff0000
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_OFFSET 16
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_RESERVED 0x1
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_1G 0x2
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_10G 0x4
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_20G 0x8
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_25G 0x10
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_40G 0x20
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R 0x40
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R2 0x80
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R2 0x100
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R4 0x200
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_P4 0x400
+
+	u32 extended_fec_mode;
+
+	u32 reserved[112];
+};
+
+struct nvm_cfg1_func {
+	struct nvm_cfg_mac_address mac_address;
+	u32 rsrv1;
+	u32 rsrv2;
+	u32 device_id;
+	u32 cmn_cfg;
+	u32 pci_cfg;
+	struct nvm_cfg_mac_address fcoe_node_wwn_mac_addr;
+	struct nvm_cfg_mac_address fcoe_port_wwn_mac_addr;
+	u32 preboot_generic_cfg;
+	u32 reserved[8];
+};
+
+struct nvm_cfg1 {
+	struct nvm_cfg1_glob glob;
+	struct nvm_cfg1_path path[MCP_GLOB_PATH_MAX];
+	struct nvm_cfg1_port port[MCP_GLOB_PORT_MAX];
+	struct nvm_cfg1_func func[MCP_GLOB_FUNC_MAX];
+};
+
+enum spad_sections {
+	SPAD_SECTION_TRACE,
+	SPAD_SECTION_NVM_CFG,
+	SPAD_SECTION_PUBLIC,
+	SPAD_SECTION_PRIVATE,
+	SPAD_SECTION_MAX
+};
+
+#define MCP_TRACE_SIZE          2048	/* 2kb */
+
+/* This section is located at a fixed location in the beginning of the
+ * scratchpad, to ensure that the MCP trace is not run over during MFW upgrade.
+ * All the rest of data has a floating location which differs from version to
+ * version, and is pointed by the mcp_meta_data below.
+ * Moreover, the spad_layout section is part of the MFW firmware, and is loaded
+ * with it from nvram in order to clear this portion.
+ */
+struct static_init {
+	u32 num_sections;
+	offsize_t sections[SPAD_SECTION_MAX];
+#define SECTION(_sec_) (*((offsize_t *)(STRUCT_OFFSET(sections[_sec_]))))
+
+	struct mcp_trace trace;
+#define MCP_TRACE_P ((struct mcp_trace *)(STRUCT_OFFSET(trace)))
+	u8 trace_buffer[MCP_TRACE_SIZE];
+#define MCP_TRACE_BUF ((u8 *)(STRUCT_OFFSET(trace_buffer)))
+	/* running_mfw has the same definition as in nvm_map.h.
+	 * This bit indicate both the running dir, and the running bundle.
+	 * It is set once when the LIM is loaded.
+	 */
+	u32 running_mfw;
+#define RUNNING_MFW (*((u32 *)(STRUCT_OFFSET(running_mfw))))
+	u32 build_time;
+#define MFW_BUILD_TIME (*((u32 *)(STRUCT_OFFSET(build_time))))
+	u32 reset_type;
+#define RESET_TYPE (*((u32 *)(STRUCT_OFFSET(reset_type))))
+	u32 mfw_secure_mode;
+#define MFW_SECURE_MODE (*((u32 *)(STRUCT_OFFSET(mfw_secure_mode))))
+	u16 pme_status_pf_bitmap;
+#define PME_STATUS_PF_BITMAP (*((u16 *)(STRUCT_OFFSET(pme_status_pf_bitmap))))
+	u16 pme_enable_pf_bitmap;
+#define PME_ENABLE_PF_BITMAP (*((u16 *)(STRUCT_OFFSET(pme_enable_pf_bitmap))))
+	u32 mim_nvm_addr;
+	u32 mim_start_addr;
+	u32 ah_pcie_link_params;
+#define AH_PCIE_LINK_PARAMS_LINK_SPEED_MASK     (0x000000ff)
+#define AH_PCIE_LINK_PARAMS_LINK_SPEED_SHIFT    (0)
+#define AH_PCIE_LINK_PARAMS_LINK_WIDTH_MASK     (0x0000ff00)
+#define AH_PCIE_LINK_PARAMS_LINK_WIDTH_SHIFT    (8)
+#define AH_PCIE_LINK_PARAMS_ASPM_MODE_MASK      (0x00ff0000)
+#define AH_PCIE_LINK_PARAMS_ASPM_MODE_SHIFT     (16)
+#define AH_PCIE_LINK_PARAMS_ASPM_CAP_MASK       (0xff000000)
+#define AH_PCIE_LINK_PARAMS_ASPM_CAP_SHIFT      (24)
+#define AH_PCIE_LINK_PARAMS (*((u32 *)(STRUCT_OFFSET(ah_pcie_link_params))))
+
+	u32 rsrv_persist[5];	/* Persist reserved for MFW upgrades */
+};
+
+#define NVM_MAGIC_VALUE		0x669955aa
+
+enum nvm_image_type {
+	NVM_TYPE_TIM1 = 0x01,
+	NVM_TYPE_TIM2 = 0x02,
+	NVM_TYPE_MIM1 = 0x03,
+	NVM_TYPE_MIM2 = 0x04,
+	NVM_TYPE_MBA = 0x05,
+	NVM_TYPE_MODULES_PN = 0x06,
+	NVM_TYPE_VPD = 0x07,
+	NVM_TYPE_MFW_TRACE1 = 0x08,
+	NVM_TYPE_MFW_TRACE2 = 0x09,
+	NVM_TYPE_NVM_CFG1 = 0x0a,
+	NVM_TYPE_L2B = 0x0b,
+	NVM_TYPE_DIR1 = 0x0c,
+	NVM_TYPE_EAGLE_FW1 = 0x0d,
+	NVM_TYPE_FALCON_FW1 = 0x0e,
+	NVM_TYPE_PCIE_FW1 = 0x0f,
+	NVM_TYPE_HW_SET = 0x10,
+	NVM_TYPE_LIM = 0x11,
+	NVM_TYPE_AVS_FW1 = 0x12,
+	NVM_TYPE_DIR2 = 0x13,
+	NVM_TYPE_CCM = 0x14,
+	NVM_TYPE_EAGLE_FW2 = 0x15,
+	NVM_TYPE_FALCON_FW2 = 0x16,
+	NVM_TYPE_PCIE_FW2 = 0x17,
+	NVM_TYPE_AVS_FW2 = 0x18,
+	NVM_TYPE_INIT_HW = 0x19,
+	NVM_TYPE_DEFAULT_CFG = 0x1a,
+	NVM_TYPE_MDUMP = 0x1b,
+	NVM_TYPE_META = 0x1c,
+	NVM_TYPE_ISCSI_CFG = 0x1d,
+	NVM_TYPE_FCOE_CFG = 0x1f,
+	NVM_TYPE_ETH_PHY_FW1 = 0x20,
+	NVM_TYPE_ETH_PHY_FW2 = 0x21,
+	NVM_TYPE_BDN = 0x22,
+	NVM_TYPE_8485X_PHY_FW = 0x23,
+	NVM_TYPE_PUB_KEY = 0x24,
+	NVM_TYPE_RECOVERY = 0x25,
+	NVM_TYPE_PLDM = 0x26,
+	NVM_TYPE_UPK1 = 0x27,
+	NVM_TYPE_UPK2 = 0x28,
+	NVM_TYPE_MASTER_KC = 0x29,
+	NVM_TYPE_BACKUP_KC = 0x2a,
+	NVM_TYPE_HW_DUMP = 0x2b,
+	NVM_TYPE_HW_DUMP_OUT = 0x2c,
+	NVM_TYPE_BIN_NVM_META = 0x30,
+	NVM_TYPE_ROM_TEST = 0xf0,
+	NVM_TYPE_88X33X0_PHY_FW = 0x31,
+	NVM_TYPE_88X33X0_PHY_SLAVE_FW = 0x32,
+	NVM_TYPE_MAX,
+};
+
+#define DIR_ID_1    (0)
+
+#endif
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 4f4b79250a2b..05658e66a20b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -22,6 +22,7 @@
 #include "qed.h"
 #include "qed_cxt.h"
 #include "qed_hsi.h"
+#include "qed_iro_hsi.h"
 #include "qed_hw.h"
 #include "qed_init_ops.h"
 #include "qed_int.h"
@@ -33,7 +34,6 @@
 #include "qed_roce.h"
 #include "qed_sp.h"
 
-
 int qed_rdma_bmap_alloc(struct qed_hwfn *p_hwfn,
 			struct qed_bmap *bmap, u32 max_count, char *name)
 {
@@ -1903,7 +1903,6 @@ void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 		   val, p_hwfn->dcbx_no_edpm, p_hwfn->db_bar_no_edpm);
 }
 
-
 void qed_rdma_dpm_bar(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
 	p_hwfn->db_bar_no_edpm = true;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.h b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
index 6a1de3a25257..2753723011dd 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
@@ -168,16 +168,19 @@ static inline bool qed_rdma_is_xrc_qp(struct qed_rdma_qp *qp)
 
 	return false;
 }
+
 #if IS_ENABLED(CONFIG_QED_RDMA)
 void qed_rdma_dpm_bar(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn);
 void qed_rdma_info_free(struct qed_hwfn *p_hwfn);
 #else
-static inline void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt) {}
+static inline void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn,
+				     struct qed_ptt *p_ptt) {}
 static inline void qed_rdma_dpm_bar(struct qed_hwfn *p_hwfn,
 				    struct qed_ptt *p_ptt) {}
-static inline int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn) {return -EINVAL;}
+static inline int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn)
+				      {return -EINVAL; }
 static inline void qed_rdma_info_free(struct qed_hwfn *p_hwfn) {}
 #endif
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_roce.c b/drivers/net/ethernet/qlogic/qed/qed_roce.c
index cf5baa5e59bc..071b4aeaddf2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -792,7 +792,6 @@ static int qed_roce_sp_destroy_qp_requester(struct qed_hwfn *p_hwfn,
 	if (rc)
 		goto err;
 
-
 	/* Free ORQ - only if ramrod succeeded, in case FW is still using it */
 	dma_free_coherent(&p_hwfn->cdev->pdev->dev,
 			  qp->orq_num_pages * RDMA_RING_PAGE_SIZE,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index fa8385178538..8bef53ca7597 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -20,6 +20,7 @@
 #include "qed_cxt.h"
 #include "qed_dev_api.h"
 #include "qed_hsi.h"
+#include "qed_iro_hsi.h"
 #include "qed_hw.h"
 #include "qed_int.h"
 #include "qed_iscsi.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index 08d92711c7a2..2a67b1308fe0 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -11,6 +11,7 @@
 #include <linux/qed/qed_iov_if.h>
 #include "qed_cxt.h"
 #include "qed_hsi.h"
+#include "qed_iro_hsi.h"
 #include "qed_hw.h"
 #include "qed_init_ops.h"
 #include "qed_int.h"
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 72a38d53d33f..220a95fa96e1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -27,7 +27,7 @@ static void *qed_vf_pf_prep(struct qed_hwfn *p_hwfn, u16 type, u16 length)
 		   "preparing to send 0x%04x tlv over vf pf channel\n",
 		   type);
 
-	/* Reset Requst offset */
+	/* Reset Request offset */
 	p_iov->offset = (u8 *)p_iov->vf2pf_request;
 
 	/* Clear mailbox - both request and reply */
@@ -444,7 +444,7 @@ int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn)
 	u32 reg;
 	int rc;
 
-	/* Set number of hwfns - might be overriden once leading hwfn learns
+	/* Set number of hwfns - might be overridden once leading hwfn learns
 	 * actual configuration from PF.
 	 */
 	if (IS_LEAD_HWFN(p_hwfn))
@@ -504,7 +504,7 @@ int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn)
 		   QED_MSG_IOV,
 		   "VF's Request mailbox [%p virt 0x%llx phys], Response mailbox [%p virt 0x%llx phys]\n",
 		   p_iov->vf2pf_request,
-		   (u64) p_iov->vf2pf_request_phys,
+		   (u64)p_iov->vf2pf_request_phys,
 		   p_iov->pf2vf_reply, (u64)p_iov->pf2vf_reply_phys);
 
 	/* Allocate Bulletin board */
@@ -561,6 +561,7 @@ int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn)
 
 	return -ENOMEM;
 }
+
 #define TSTORM_QZONE_START   PXP_VF_BAR0_START_SDM_ZONE_A
 #define MSTORM_QZONE_START(dev)   (TSTORM_QZONE_START +	\
 				   (TSTORM_QZONE_SIZE * NUM_OF_L2_QUEUES(dev)))
@@ -1285,8 +1286,8 @@ int qed_vf_pf_filter_ucast(struct qed_hwfn *p_hwfn,
 
 	/* clear mailbox and prep first tlv */
 	req = qed_vf_pf_prep(p_hwfn, CHANNEL_TLV_UCAST_FILTER, sizeof(*req));
-	req->opcode = (u8) p_ucast->opcode;
-	req->type = (u8) p_ucast->type;
+	req->opcode = (u8)p_ucast->opcode;
+	req->type = (u8)p_ucast->type;
 	memcpy(req->mac, p_ucast->mac, ETH_ALEN);
 	req->vlan = p_ucast->vlan;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.h b/drivers/net/ethernet/qlogic/qed/qed_vf.h
index 60d2bb64e65f..1c952781ec12 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.h
@@ -48,7 +48,7 @@ struct channel_tlv {
 	u16 length;
 };
 
-/* header of first vf->pf tlv carries the offset used to calculate reponse
+/* header of first vf->pf tlv carries the offset used to calculate response
  * buffer address
  */
 struct vfpf_first_tlv {
@@ -85,8 +85,8 @@ struct vfpf_acquire_tlv {
 	struct vfpf_first_tlv first_tlv;
 
 	struct vf_pf_vfdev_info {
-#define VFPF_ACQUIRE_CAP_PRE_FP_HSI     (1 << 0) /* VF pre-FP hsi version */
-#define VFPF_ACQUIRE_CAP_100G		(1 << 1) /* VF can support 100g */
+#define VFPF_ACQUIRE_CAP_PRE_FP_HSI     BIT(0) /* VF pre-FP hsi version */
+#define VFPF_ACQUIRE_CAP_100G		BIT(1) /* VF can support 100g */
 	/* A requirement for supporting multi-Tx queues on a single queue-zone,
 	 * VF would pass qids as additional information whenever passing queue
 	 * references.
@@ -724,7 +724,7 @@ int qed_vf_pf_get_coalesce(struct qed_hwfn *p_hwfn,
 int qed_vf_read_bulletin(struct qed_hwfn *p_hwfn, u8 *p_change);
 
 /**
- * @brief Get link paramters for VF from qed
+ * @brief Get link parameters for VF from qed
  *
  * @param p_hwfn
  * @param params - the link params structure to be filled for the VF
@@ -810,7 +810,8 @@ void qed_vf_get_num_mac_filters(struct qed_hwfn *p_hwfn, u8 *num_mac_filters);
 bool qed_vf_check_mac(struct qed_hwfn *p_hwfn, u8 *mac);
 
 /**
- * @brief Set firmware version information in dev_info from VFs acquire response tlv
+ * @brief Set firmware version information in dev_info from VFs acquire
+ * response tlv
  *
  * @param p_hwfn
  * @param fw_major
-- 
2.24.1

