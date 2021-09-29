Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0B41C477
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Sep 2021 14:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbhI2MQj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Sep 2021 08:16:39 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:28690 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245720AbhI2MQ3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Sep 2021 08:16:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T8dfEm008084;
        Wed, 29 Sep 2021 05:12:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=oE172QEitCPowVxUktU/r6q0+G2ui+XH+ftPXCKLhXU=;
 b=P3ScNnnZLhRld3NbAEQIX+CYNn+VSUizPMlbdHp4bCF9UfNoZPh1v/kCqzBOsf6lFhFZ
 pjuQhwYhNqyx3PN2JJxXa7FIJQ+uz078R8B9vnfQm3JVFg8bIqN1POeNE+ADrRq4rv2T
 vWshJwMXek15YFugWxEAvCTdAsfpkih9DcR5j4kN+wdN78fgcEHEam43oWRBJofQweUm
 mRuGfleitmZ/gIoBKaabnaLTIgTNkSOb+BNUeKIePEnB/qU/7u3JjeIRXD2/+g+3VoU9
 bLVkyJInkAvHm5QVtz18bfQ8J6zuzz3LS8UsNBfn1HO0DUa1xg+B1MnVZhwD6Dm02kPl zw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bcfd4a09t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 05:12:45 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Sep
 2021 05:12:42 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Wed, 29 Sep 2021 05:12:39 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <aelior@marvell.com>,
        <smalin@marvell.com>, <jhasan@marvell.com>,
        <mrangankar@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>,
        Omkar Kulkarni <okulkarni@marvell.com>
Subject: [PATCH 04/12] qed: Update qed_mfw_hsi.h for FW ver 8.59.1.0
Date:   Wed, 29 Sep 2021 15:12:07 +0300
Message-ID: <20210929121215.17864-5-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210929121215.17864-1-pkushwaha@marvell.com>
References: <20210929121215.17864-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: syCzQjH1Pp4oxzhRQVUbphF6eX3D7Qse
X-Proofpoint-ORIG-GUID: syCzQjH1Pp4oxzhRQVUbphF6eX3D7Qse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_05,2021-09-29_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The qed_mfw_hsi.h contains HSI (Hardware Software Interface) changes
related to management firmware. It has been updated to support new FW
version 8.59.1.0 with below changes.
 - New defines for VF bitmap.
 - fec_mode and extended_speed defines updated in struct eth_phy_cfg.
 - Updated structutres lldp_system_tlvs_buffer_s, public_global,
   public_port, public_func, drv_union_data, public_drv_mb
   with all dependent new structures.
 - Updates in NVM related structures and defines.
 - Msg defines are added in enum drv_msg_code and fw_msg_code.
 - Updated/added new defines.

This patch also fixes the existing checkpatch warnings and few important
checks.

Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c    |   12 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     |   11 +-
 drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h | 1036 +++++++++++++----
 3 files changed, 800 insertions(+), 259 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 15ef59aa34ff..7e0e162df2b9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -148,7 +148,6 @@ static const u32 qed_mfw_ext_100g_base_r4[] __initconst = {
 static struct qed_mfw_speed_map qed_mfw_ext_maps[] __ro_after_init = {
 	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_1G, qed_mfw_ext_1g),
 	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_10G, qed_mfw_ext_10g),
-	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_20G, qed_mfw_ext_20g),
 	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_25G, qed_mfw_ext_25g),
 	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_40G, qed_mfw_ext_40g),
 	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_50G_BASE_R,
@@ -262,7 +261,7 @@ module_exit(qed_exit);
 
 /* Check if the DMA controller on the machine can properly handle the DMA
  * addressing required by the device.
-*/
+ */
 static int qed_set_coherency_mask(struct qed_dev *cdev)
 {
 	struct device *dev = &cdev->pdev->dev;
@@ -547,7 +546,7 @@ static struct qed_dev *qed_probe(struct pci_dev *pdev,
 		goto err2;
 	}
 
-	DP_INFO(cdev, "qed_probe completed successfully\n");
+	DP_INFO(cdev, "%s completed successfully\n", __func__);
 
 	return cdev;
 
@@ -980,7 +979,7 @@ static int qed_slowpath_setup_int(struct qed_dev *cdev,
 
 	rc = qed_set_int_mode(cdev, false);
 	if (rc)  {
-		DP_ERR(cdev, "qed_slowpath_setup_int ERR\n");
+		DP_ERR(cdev, "%s ERR\n", __func__);
 		return rc;
 	}
 
@@ -1161,6 +1160,7 @@ static int qed_slowpath_delayed_work(struct qed_hwfn *hwfn,
 	/* Memory barrier for setting atomic bit */
 	smp_mb__before_atomic();
 	set_bit(wq_flag, &hwfn->slowpath_task_flags);
+	/* Memory barrier after setting atomic bit */
 	smp_mb__after_atomic();
 	queue_delayed_work(hwfn->slowpath_wq, &hwfn->slowpath_task, delay);
 
@@ -1381,7 +1381,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 				      (params->drv_minor << 16) |
 				      (params->drv_rev << 8) |
 				      (params->drv_eng);
-		strlcpy(drv_version.name, params->name,
+		strscpy(drv_version.name, params->name,
 			MCP_DRV_VER_STR_SIZE - 4);
 		rc = qed_mcp_send_drv_version(hwfn, hwfn->p_main_ptt,
 					      &drv_version);
@@ -3078,8 +3078,10 @@ int qed_mfw_tlv_req(struct qed_hwfn *hwfn)
 	DP_VERBOSE(hwfn->cdev, NETIF_MSG_DRV,
 		   "Scheduling slowpath task [Flag: %d]\n",
 		   QED_SLOWPATH_MFW_TLV_REQ);
+	/* Memory barrier for setting atomic bit */
 	smp_mb__before_atomic();
 	set_bit(QED_SLOWPATH_MFW_TLV_REQ, &hwfn->slowpath_task_flags);
+	/* Memory barrier after setting atomic bit */
 	smp_mb__after_atomic();
 	queue_delayed_work(hwfn->slowpath_wq, &hwfn->slowpath_task, 0);
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 24582977f2d4..f1ffbfd06184 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -1527,15 +1527,13 @@ int qed_mcp_set_link(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt, bool b_up)
 	    FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL) {
 		ext_speed = 0;
 		if (params->ext_speed.autoneg)
-			ext_speed |= ETH_EXT_SPEED_AN;
+			ext_speed |= ETH_EXT_SPEED_NONE;
 
 		val = params->ext_speed.forced_speed;
 		if (val & QED_EXT_SPEED_1G)
 			ext_speed |= ETH_EXT_SPEED_1G;
 		if (val & QED_EXT_SPEED_10G)
 			ext_speed |= ETH_EXT_SPEED_10G;
-		if (val & QED_EXT_SPEED_20G)
-			ext_speed |= ETH_EXT_SPEED_20G;
 		if (val & QED_EXT_SPEED_25G)
 			ext_speed |= ETH_EXT_SPEED_25G;
 		if (val & QED_EXT_SPEED_40G)
@@ -1561,8 +1559,6 @@ int qed_mcp_set_link(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt, bool b_up)
 			ext_speed |= ETH_EXT_ADV_SPEED_1G;
 		if (val & QED_EXT_SPEED_MASK_10G)
 			ext_speed |= ETH_EXT_ADV_SPEED_10G;
-		if (val & QED_EXT_SPEED_MASK_20G)
-			ext_speed |= ETH_EXT_ADV_SPEED_20G;
 		if (val & QED_EXT_SPEED_MASK_25G)
 			ext_speed |= ETH_EXT_ADV_SPEED_25G;
 		if (val & QED_EXT_SPEED_MASK_40G)
@@ -2446,9 +2442,6 @@ qed_mcp_get_shmem_proto(struct qed_hwfn *p_hwfn,
 	case FUNC_MF_CFG_PROTOCOL_ISCSI:
 		*p_proto = QED_PCI_ISCSI;
 		break;
-	case FUNC_MF_CFG_PROTOCOL_NVMETCP:
-		*p_proto = QED_PCI_NVMETCP;
-		break;
 	case FUNC_MF_CFG_PROTOCOL_FCOE:
 		*p_proto = QED_PCI_FCOE;
 		break;
@@ -3389,7 +3382,7 @@ qed_mcp_get_nvm_image_att(struct qed_hwfn *p_hwfn,
 		type = NVM_TYPE_DEFAULT_CFG;
 		break;
 	case QED_NVM_IMAGE_NVM_META:
-		type = NVM_TYPE_META;
+		type = NVM_TYPE_NVM_META;
 		break;
 	default:
 		DP_NOTICE(p_hwfn, "Unknown request of image_id %08x\n",
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h
index e419d1577d5c..8a0e3c5d4bda 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h
@@ -35,6 +35,13 @@ struct mcp_trace {
 };
 
 #define VF_MAX_STATIC 192
+#define VF_BITMAP_SIZE_IN_DWORDS (VF_MAX_STATIC / 32)
+#define VF_BITMAP_SIZE_IN_BYTES (VF_BITMAP_SIZE_IN_DWORDS * sizeof(u32))
+
+#define EXT_VF_MAX_STATIC 240
+#define EXT_VF_BITMAP_SIZE_IN_DWORDS (((EXT_VF_MAX_STATIC - 1) / 32) + 1)
+#define EXT_VF_BITMAP_SIZE_IN_BYTES (EXT_VF_BITMAP_SIZE_IN_DWORDS * sizeof(u32))
+#define ADDED_VF_BITMAP_SIZE 2
 
 #define MCP_GLOB_PATH_MAX	2
 #define MCP_PORT_MAX		2
@@ -101,7 +108,7 @@ struct eth_phy_cfg {
 #define EEE_TX_TIMER_USEC_AGGRESSIVE_TIME	0x100
 #define EEE_TX_TIMER_USEC_LATENCY_TIME		0x6000
 
-	u32					deprecated;
+	u32					link_modes;
 
 	u32					fec_mode;
 #define FEC_FORCE_MODE_MASK			0x000000ff
@@ -112,52 +119,47 @@ struct eth_phy_cfg {
 #define FEC_FORCE_MODE_AUTO			0x07
 #define FEC_EXTENDED_MODE_MASK			0xffffff00
 #define FEC_EXTENDED_MODE_OFFSET		8
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
+#define ETH_EXT_FEC_NONE			0x00000000
+#define ETH_EXT_FEC_10G_NONE			0x00000100
+#define ETH_EXT_FEC_10G_BASE_R			0x00000200
+#define ETH_EXT_FEC_25G_NONE			0x00000400
+#define ETH_EXT_FEC_25G_BASE_R			0x00000800
+#define ETH_EXT_FEC_25G_RS528			0x00001000
+#define ETH_EXT_FEC_40G_NONE			0x00002000
+#define ETH_EXT_FEC_40G_BASE_R			0x00004000
+#define ETH_EXT_FEC_50G_NONE			0x00008000
+#define ETH_EXT_FEC_50G_BASE_R			0x00010000
+#define ETH_EXT_FEC_50G_RS528			0x00020000
+#define ETH_EXT_FEC_50G_RS544			0x00040000
+#define ETH_EXT_FEC_100G_NONE			0x00080000
+#define ETH_EXT_FEC_100G_BASE_R			0x00100000
+#define ETH_EXT_FEC_100G_RS528			0x00200000
+#define ETH_EXT_FEC_100G_RS544			0x00400000
 
 	u32					extended_speed;
 #define ETH_EXT_SPEED_MASK			0x0000ffff
 #define ETH_EXT_SPEED_OFFSET			0
-#define ETH_EXT_SPEED_AN			0x00000001
+#define ETH_EXT_SPEED_NONE			0x00000001
 #define ETH_EXT_SPEED_1G			0x00000002
 #define ETH_EXT_SPEED_10G			0x00000004
-#define ETH_EXT_SPEED_20G			0x00000008
-#define ETH_EXT_SPEED_25G			0x00000010
-#define ETH_EXT_SPEED_40G			0x00000020
-#define ETH_EXT_SPEED_50G_BASE_R		0x00000040
-#define ETH_EXT_SPEED_50G_BASE_R2		0x00000080
-#define ETH_EXT_SPEED_100G_BASE_R2		0x00000100
-#define ETH_EXT_SPEED_100G_BASE_R4		0x00000200
-#define ETH_EXT_SPEED_100G_BASE_P4		0x00000400
-#define ETH_EXT_ADV_SPEED_MASK			0xffff0000
+#define ETH_EXT_SPEED_25G			0x00000008
+#define ETH_EXT_SPEED_40G			0x00000010
+#define ETH_EXT_SPEED_50G_BASE_R		0x00000020
+#define ETH_EXT_SPEED_50G_BASE_R2		0x00000040
+#define ETH_EXT_SPEED_100G_BASE_R2		0x00000080
+#define ETH_EXT_SPEED_100G_BASE_R4		0x00000100
+#define ETH_EXT_SPEED_100G_BASE_P4		0x00000200
+#define ETH_EXT_ADV_SPEED_MASK			0xFFFF0000
 #define ETH_EXT_ADV_SPEED_OFFSET		16
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
+#define ETH_EXT_ADV_SPEED_1G			0x00010000
+#define ETH_EXT_ADV_SPEED_10G			0x00020000
+#define ETH_EXT_ADV_SPEED_25G			0x00040000
+#define ETH_EXT_ADV_SPEED_40G			0x00080000
+#define ETH_EXT_ADV_SPEED_50G_BASE_R		0x00100000
+#define ETH_EXT_ADV_SPEED_50G_BASE_R2		0x00200000
+#define ETH_EXT_ADV_SPEED_100G_BASE_R2		0x00400000
+#define ETH_EXT_ADV_SPEED_100G_BASE_R4		0x00800000
+#define ETH_EXT_ADV_SPEED_100G_BASE_P4		0x01000000
 };
 
 struct port_mf_cfg {
@@ -252,6 +254,13 @@ struct eth_stats {
 	u64 txcf;
 };
 
+struct pkt_type_cnt {
+	u64 tc_tx_pkt_cnt[8];
+	u64 tc_tx_oct_cnt[8];
+	u64 priority_rx_pkt_cnt[8];
+	u64 priority_rx_oct_cnt[8];
+};
+
 struct brb_stats {
 	u64 brb_truncate[8];
 	u64 brb_discard[8];
@@ -279,6 +288,7 @@ struct couple_mode_teaming {
 #define LLDP_PORT_ID_STAT_LEN		4
 #define DCBX_MAX_APP_PROTOCOL		32
 #define MAX_SYSTEM_LLDP_TLV_DATA	32
+#define MAX_TLV_BUFFER			128
 
 enum _lldp_agent {
 	LLDP_NEAREST_BRIDGE = 0,
@@ -327,6 +337,7 @@ struct dcbx_ets_feature {
 #define DCBX_OOO_TC_SHIFT	8
 	u32 pri_tc_tbl[1];
 #define DCBX_TCP_OOO_TC		(4)
+#define DCBX_TCP_OOO_K2_4PORT_TC (3)
 
 #define NIG_ETS_ISCSI_OOO_CLIENT_OFFSET	(DCBX_TCP_OOO_TC + 1)
 #define DCBX_CEE_STRICT_PRIORITY	0xf
@@ -434,11 +445,23 @@ struct dcbx_mib {
 };
 
 struct lldp_system_tlvs_buffer_s {
-	u16 valid;
-	u16 length;
+	u32 flags;
+#define LLDP_SYSTEM_TLV_VALID_MASK 0x1
+#define LLDP_SYSTEM_TLV_VALID_OFFSET 0
+#define LLDP_SYSTEM_TLV_MANDATORY_MASK 0x2
+#define LLDP_SYSTEM_TLV_MANDATORY_SHIFT 1
+#define LLDP_SYSTEM_TLV_LENGTH_MASK 0xffff0000
+#define LLDP_SYSTEM_TLV_LENGTH_SHIFT 16
 	u32 data[MAX_SYSTEM_LLDP_TLV_DATA];
 };
 
+struct lldp_received_tlvs_s {
+	u32 prefix_seq_num;
+	u32 length;
+	u32 tlvs_buffer[MAX_TLV_BUFFER];
+	u32 suffix_seq_num;
+};
+
 struct dcb_dscp_map {
 	u32 flags;
 #define DCB_DSCP_ENABLE_MASK	0x1
@@ -447,6 +470,33 @@ struct dcb_dscp_map {
 	u32 dscp_pri_map[8];
 };
 
+struct mcp_val64 {
+	u32 lo;
+	u32 hi;
+};
+
+struct generic_idc_msg_s {
+	u32 source_pf;
+	struct mcp_val64 msg;
+};
+
+struct pcie_stats_stc {
+	u32 sr_cnt_wr_byte_msb;
+	u32 sr_cnt_wr_byte_lsb;
+	u32 sr_cnt_wr_cnt;
+	u32 sr_cnt_rd_byte_msb;
+	u32 sr_cnt_rd_byte_lsb;
+	u32 sr_cnt_rd_cnt;
+};
+
+enum _attribute_commands_e {
+	ATTRIBUTE_CMD_READ = 0,
+	ATTRIBUTE_CMD_WRITE,
+	ATTRIBUTE_CMD_READ_CLEAR,
+	ATTRIBUTE_CMD_CLEAR,
+	ATTRIBUTE_NUM_OF_COMMANDS
+};
+
 struct public_global {
 	u32 max_path;
 	u32 max_ports;
@@ -462,9 +512,22 @@ struct public_global {
 	u32 running_bundle_id;
 	s32 external_temperature;
 	u32 mdump_reason;
-	u64 reserved;
+	u32 ext_phy_upgrade_fw;
+	u8 runtime_port_swap_map[MODE_4P];
 	u32 data_ptr;
 	u32 data_size;
+	u32 bmb_error_status_cnt;
+	u32 bmb_jumbo_frame_cnt;
+	u32 sent_to_bmc_cnt;
+	u32 handled_by_mfw;
+	u32 sent_to_nw_cnt;
+	u32 to_bmc_kb_per_second;
+	u32 bcast_dropped_to_bmc_cnt;
+	u32 mcast_dropped_to_bmc_cnt;
+	u32 ucast_dropped_to_bmc_cnt;
+	u32 ncsi_response_failure_cnt;
+	u32 device_attr;
+	u32 vpd_warning;
 };
 
 struct fw_flr_mb {
@@ -485,6 +548,33 @@ struct public_path {
 #define GLOBAL_AEU_BIT(aeu_reg_id, aeu_bit) ((aeu_reg_id) * 32 + (aeu_bit))
 };
 
+#define FC_NPIV_WWPN_SIZE	8
+#define FC_NPIV_WWNN_SIZE	8
+struct dci_npiv_settings {
+	u8 npiv_wwpn[FC_NPIV_WWPN_SIZE];
+	u8 npiv_wwnn[FC_NPIV_WWNN_SIZE];
+};
+
+struct dci_fc_npiv_cfg {
+	/* hdr used internally by the MFW */
+	u32 hdr;
+	u32 num_of_npiv;
+};
+
+#define MAX_NUMBER_NPIV    64
+struct dci_fc_npiv_tbl {
+	struct dci_fc_npiv_cfg fc_npiv_cfg;
+	struct dci_npiv_settings settings[MAX_NUMBER_NPIV];
+};
+
+struct pause_flood_monitor {
+	u8 period_cnt;
+	u8 any_brb_prs_packet_hist;
+	u8 any_brb_block_is_full_hist;
+	u8 flags;
+	u32 num_of_state_changes;
+};
+
 struct public_port {
 	u32						validity_map;
 
@@ -528,6 +618,7 @@ struct public_port {
 #define LINK_STATUS_FEC_MODE_NONE			(0 << 27)
 #define LINK_STATUS_FEC_MODE_FIRECODE_CL74		BIT(27)
 #define LINK_STATUS_FEC_MODE_RS_CL91			(2 << 27)
+#define LINK_STATUS_EXT_PHY_LINK_UP			BIT(30)
 
 	u32 link_status1;
 	u32 ext_phy_fw_version;
@@ -563,7 +654,8 @@ struct public_port {
 	struct dcbx_mib remote_dcbx_mib;
 	struct dcbx_mib operational_dcbx_mib;
 
-	u32 reserved[2];
+	u32 fc_npiv_nvram_tbl_addr;
+	u32 fc_npiv_nvram_tbl_size;
 
 	u32						transceiver_data;
 #define ETH_TRANSCEIVER_STATE_MASK			0x000000ff
@@ -573,6 +665,7 @@ struct public_port {
 #define ETH_TRANSCEIVER_STATE_PRESENT			0x00000001
 #define ETH_TRANSCEIVER_STATE_VALID			0x00000003
 #define ETH_TRANSCEIVER_STATE_UPDATING			0x00000008
+#define ETH_TRANSCEIVER_STATE_IN_SETUP			0x10
 #define ETH_TRANSCEIVER_TYPE_MASK			0x0000ff00
 #define ETH_TRANSCEIVER_TYPE_OFFSET			0x8
 #define ETH_TRANSCEIVER_TYPE_NONE			0x00
@@ -647,7 +740,8 @@ struct public_port {
 #define EEE_REMOTE_TW_RX_MASK   0xffff0000
 #define EEE_REMOTE_TW_RX_OFFSET 16
 
-	u32 reserved1;
+	u32 module_info;
+
 	u32 oem_cfg_port;
 #define OEM_CFG_CHANNEL_TYPE_MASK                       0x00000003
 #define OEM_CFG_CHANNEL_TYPE_OFFSET                     0
@@ -657,14 +751,39 @@ struct public_port {
 #define OEM_CFG_SCHED_TYPE_OFFSET                       2
 #define OEM_CFG_SCHED_TYPE_ETS                          0x1
 #define OEM_CFG_SCHED_TYPE_VNIC_BW                      0x2
+
+	struct lldp_received_tlvs_s lldp_received_tlvs[LLDP_MAX_LLDP_AGENTS];
+	u32 system_lldp_tlvs_buf2[MAX_SYSTEM_LLDP_TLV_DATA];
+	u32 phy_module_temperature;
+	u32 nig_reg_stat_rx_bmb_packet;
+	u32 nig_reg_rx_llh_ncsi_mcp_mask;
+	u32 nig_reg_rx_llh_ncsi_mcp_mask_2;
+	struct pause_flood_monitor pause_flood_monitor;
+	u32 nig_drain_cnt;
+	struct pkt_type_cnt pkt_tc_priority_cnt;
+};
+
+#define MCP_DRV_VER_STR_SIZE 16
+#define MCP_DRV_VER_STR_SIZE_DWORD (MCP_DRV_VER_STR_SIZE / sizeof(u32))
+#define MCP_DRV_NVM_BUF_LEN 32
+struct drv_version_stc {
+	u32 version;
+	u8 name[MCP_DRV_VER_STR_SIZE - 4];
 };
 
 struct public_func {
-	u32 reserved0[2];
+	u32 iscsi_boot_signature;
+	u32 iscsi_boot_block_offset;
 
 	u32 mtu_size;
 
-	u32 reserved[7];
+	u32 c2s_pcp_map_lower;
+	u32 c2s_pcp_map_upper;
+	u32 c2s_pcp_map_default;
+
+	struct generic_idc_msg_s generic_idc_msg;
+
+	u32 num_of_msix;
 
 	u32 config;
 #define FUNC_MF_CFG_FUNC_HIDE			0x00000001
@@ -677,8 +796,7 @@ struct public_func {
 #define FUNC_MF_CFG_PROTOCOL_ISCSI              0x00000010
 #define FUNC_MF_CFG_PROTOCOL_FCOE               0x00000020
 #define FUNC_MF_CFG_PROTOCOL_ROCE               0x00000030
-#define FUNC_MF_CFG_PROTOCOL_NVMETCP    0x00000040
-#define FUNC_MF_CFG_PROTOCOL_MAX	0x00000040
+#define FUNC_MF_CFG_PROTOCOL_MAX	0x00000030
 
 #define FUNC_MF_CFG_MIN_BW_MASK		0x0000ff00
 #define FUNC_MF_CFG_MIN_BW_SHIFT	8
@@ -751,6 +869,8 @@ struct public_func {
 #define OEM_CFG_FUNC_HOST_PRI_CTRL_OFFSET       4
 #define OEM_CFG_FUNC_HOST_PRI_CTRL_VNIC         0x1
 #define OEM_CFG_FUNC_HOST_PRI_CTRL_OS           0x2
+
+	struct drv_version_stc drv_ver;
 };
 
 struct mcp_mac {
@@ -758,11 +878,6 @@ struct mcp_mac {
 	u32 mac_lower;
 };
 
-struct mcp_val64 {
-	u32 lo;
-	u32 hi;
-};
-
 struct mcp_file_att {
 	u32 nvm_start_addr;
 	u32 len;
@@ -775,14 +890,6 @@ struct bist_nvm_image_att {
 	u32 len;
 };
 
-#define MCP_DRV_VER_STR_SIZE 16
-#define MCP_DRV_VER_STR_SIZE_DWORD (MCP_DRV_VER_STR_SIZE / sizeof(u32))
-#define MCP_DRV_NVM_BUF_LEN 32
-struct drv_version_stc {
-	u32 version;
-	u8 name[MCP_DRV_VER_STR_SIZE - 4];
-};
-
 struct lan_stats_stc {
 	u64 ucast_rx_pkts;
 	u64 ucast_tx_pkts;
@@ -797,12 +904,35 @@ struct fcoe_stats_stc {
 	u32 login_failure;
 };
 
+struct iscsi_stats_stc {
+	u64 rx_pdus;
+	u64 tx_pdus;
+	u64 rx_bytes;
+	u64 tx_bytes;
+};
+
+struct rdma_stats_stc {
+	u64 rx_pkts;
+	u64 tx_pkts;
+	u64 rx_bytes;
+	u64 tx_bytes;
+};
+
 struct ocbb_data_stc {
 	u32 ocbb_host_addr;
 	u32 ocsd_host_addr;
 	u32 ocsd_req_update_interval;
 };
 
+struct fcoe_cap_stc {
+	u32 max_ios;
+	u32 max_log;
+	u32 max_exch;
+	u32 max_npiv;
+	u32 max_tgt;
+	u32 max_outstnd;
+};
+
 #define MAX_NUM_OF_SENSORS 7
 struct temperature_status_stc {
 	u32 num_of_sensors;
@@ -859,6 +989,11 @@ struct resource_info {
 #define RESOURCE_ELEMENT_STRICT BIT(0)
 };
 
+struct mcp_wwn {
+	u32 wwn_upper;
+	u32 wwn_lower;
+};
+
 #define DRV_ROLE_NONE           0
 #define DRV_ROLE_PREBOOT        1
 #define DRV_ROLE_OS             2
@@ -906,8 +1041,30 @@ struct mdump_retain_data_stc {
 	u32 status;
 };
 
+struct attribute_cmd_write_stc {
+	u32 val;
+	u32 mask;
+	u32 offset;
+};
+
+struct lldp_stats_stc {
+	u32 tx_frames_total;
+	u32 rx_frames_total;
+	u32 rx_frames_discarded;
+	u32 rx_age_outs;
+};
+
+struct get_att_ctrl_stc {
+	u32 disabled_attns;
+	u32 controllable_attns;
+};
+
+struct trace_filter_stc {
+	u32 level;
+	u32 modules;
+};
+
 union drv_union_data {
-	u32 ver_str[MCP_DRV_VER_STR_SIZE_DWORD];
 	struct mcp_mac wol_mac;
 
 	struct eth_phy_cfg drv_phy_cfg;
@@ -918,89 +1075,156 @@ union drv_union_data {
 
 	struct mcp_file_att file_att;
 
-	u32 ack_vf_disabled[VF_MAX_STATIC / 32];
+	u32 ack_vf_disabled[EXT_VF_BITMAP_SIZE_IN_DWORDS];
 
 	struct drv_version_stc drv_version;
 
 	struct lan_stats_stc lan_stats;
 	struct fcoe_stats_stc fcoe_stats;
+	struct iscsi_stats_stc iscsi_stats;
+	struct rdma_stats_stc rdma_stats;
 	struct ocbb_data_stc ocbb_info;
 	struct temperature_status_stc temp_info;
 	struct resource_info resource;
 	struct bist_nvm_image_att nvm_image_att;
 	struct mdump_config_stc mdump_config;
+	struct mcp_mac lldp_mac;
+	struct mcp_wwn fcoe_fabric_name;
+	u32 dword;
+
+	struct load_req_stc load_req;
+	struct load_rsp_stc load_rsp;
+	struct mdump_retain_data_stc mdump_retain;
+	struct attribute_cmd_write_stc attribute_cmd_write;
+	struct lldp_stats_stc lldp_stats;
+	struct pcie_stats_stc pcie_stats;
+
+	struct get_att_ctrl_stc get_att_ctrl;
+	struct fcoe_cap_stc fcoe_cap;
+	struct trace_filter_stc trace_filter;
 };
 
 struct public_drv_mb {
 	u32 drv_mb_header;
+#define DRV_MSG_SEQ_NUMBER_MASK			0x0000ffff
+#define DRV_MSG_SEQ_NUMBER_OFFSET		0
 #define DRV_MSG_CODE_MASK			0xffff0000
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
+#define DRV_MSG_CODE_OFFSET			16
+
+	u32 drv_mb_param;
+
+	u32 fw_mb_header;
+#define FW_MSG_SEQ_NUMBER_MASK			0x0000ffff
+#define FW_MSG_SEQ_NUMBER_OFFSET		0
+#define FW_MSG_CODE_MASK			0xffff0000
+#define FW_MSG_CODE_OFFSET			16
+
+	u32 fw_mb_param;
+
+	u32 drv_pulse_mb;
+#define DRV_PULSE_SEQ_MASK			0x00007fff
+#define DRV_PULSE_SYSTEM_TIME_MASK		0xffff0000
+#define DRV_PULSE_ALWAYS_ALIVE			0x00008000
+
+	u32 mcp_pulse_mb;
+#define MCP_PULSE_SEQ_MASK			0x00007fff
+#define MCP_PULSE_ALWAYS_ALIVE			0x00008000
+#define MCP_EVENT_MASK				0xffff0000
+#define MCP_EVENT_OTHER_DRIVER_RESET_REQ	0x00010000
+
+	union drv_union_data union_data;
+};
+
+#define DRV_MSG_CODE(_code_)    ((_code_) << DRV_MSG_CODE_OFFSET)
+enum drv_msg_code_enum {
+	DRV_MSG_CODE_NVM_PUT_FILE_BEGIN = DRV_MSG_CODE(0x0001),
+	DRV_MSG_CODE_NVM_PUT_FILE_DATA = DRV_MSG_CODE(0x0002),
+	DRV_MSG_CODE_NVM_GET_FILE_ATT = DRV_MSG_CODE(0x0003),
+	DRV_MSG_CODE_NVM_READ_NVRAM = DRV_MSG_CODE(0x0005),
+	DRV_MSG_CODE_NVM_WRITE_NVRAM = DRV_MSG_CODE(0x0006),
+	DRV_MSG_CODE_MCP_RESET = DRV_MSG_CODE(0x0009),
+	DRV_MSG_CODE_SET_VERSION = DRV_MSG_CODE(0x000f),
+	DRV_MSG_CODE_MCP_HALT = DRV_MSG_CODE(0x0010),
+	DRV_MSG_CODE_SET_VMAC = DRV_MSG_CODE(0x0011),
+	DRV_MSG_CODE_GET_VMAC = DRV_MSG_CODE(0x0012),
+	DRV_MSG_CODE_GET_STATS = DRV_MSG_CODE(0x0013),
+	DRV_MSG_CODE_TRANSCEIVER_READ = DRV_MSG_CODE(0x0016),
+	DRV_MSG_CODE_MASK_PARITIES = DRV_MSG_CODE(0x001a),
+	DRV_MSG_CODE_BIST_TEST = DRV_MSG_CODE(0x001e),
+	DRV_MSG_CODE_SET_LED_MODE = DRV_MSG_CODE(0x0020),
+	DRV_MSG_CODE_RESOURCE_CMD = DRV_MSG_CODE(0x0023),
+	DRV_MSG_CODE_MDUMP_CMD = DRV_MSG_CODE(0x0025),
+	DRV_MSG_CODE_GET_PF_RDMA_PROTOCOL = DRV_MSG_CODE(0x002b),
+	DRV_MSG_CODE_OS_WOL = DRV_MSG_CODE(0x002e),
+	DRV_MSG_CODE_GET_TLV_DONE = DRV_MSG_CODE(0x002f),
+	DRV_MSG_CODE_FEATURE_SUPPORT = DRV_MSG_CODE(0x0030),
+	DRV_MSG_CODE_GET_MFW_FEATURE_SUPPORT = DRV_MSG_CODE(0x0031),
+	DRV_MSG_CODE_GET_ENGINE_CONFIG = DRV_MSG_CODE(0x0037),
+	DRV_MSG_CODE_GET_NVM_CFG_OPTION = DRV_MSG_CODE(0x003e),
+	DRV_MSG_CODE_SET_NVM_CFG_OPTION = DRV_MSG_CODE(0x003f),
+	DRV_MSG_CODE_INITIATE_PF_FLR = DRV_MSG_CODE(0x0201),
+	DRV_MSG_CODE_LOAD_REQ = DRV_MSG_CODE(0x1000),
+	DRV_MSG_CODE_LOAD_DONE = DRV_MSG_CODE(0x1100),
+	DRV_MSG_CODE_INIT_HW = DRV_MSG_CODE(0x1200),
+	DRV_MSG_CODE_CANCEL_LOAD_REQ = DRV_MSG_CODE(0x1300),
+	DRV_MSG_CODE_UNLOAD_REQ = DRV_MSG_CODE(0x2000),
+	DRV_MSG_CODE_UNLOAD_DONE = DRV_MSG_CODE(0x2100),
+	DRV_MSG_CODE_INIT_PHY = DRV_MSG_CODE(0x2200),
+	DRV_MSG_CODE_LINK_RESET = DRV_MSG_CODE(0x2300),
+	DRV_MSG_CODE_SET_DCBX = DRV_MSG_CODE(0x2500),
+	DRV_MSG_CODE_OV_UPDATE_CURR_CFG = DRV_MSG_CODE(0x2600),
+	DRV_MSG_CODE_OV_UPDATE_BUS_NUM = DRV_MSG_CODE(0x2700),
+	DRV_MSG_CODE_OV_UPDATE_BOOT_PROGRESS = DRV_MSG_CODE(0x2800),
+	DRV_MSG_CODE_OV_UPDATE_STORM_FW_VER = DRV_MSG_CODE(0x2900),
+	DRV_MSG_CODE_NIG_DRAIN = DRV_MSG_CODE(0x3000),
+	DRV_MSG_CODE_OV_UPDATE_DRIVER_STATE = DRV_MSG_CODE(0x3100),
+	DRV_MSG_CODE_BW_UPDATE_ACK = DRV_MSG_CODE(0x3200),
+	DRV_MSG_CODE_OV_UPDATE_MTU = DRV_MSG_CODE(0x3300),
+	DRV_MSG_GET_RESOURCE_ALLOC_MSG = DRV_MSG_CODE(0x3400),
+	DRV_MSG_SET_RESOURCE_VALUE_MSG = DRV_MSG_CODE(0x3500),
+	DRV_MSG_CODE_OV_UPDATE_WOL = DRV_MSG_CODE(0x3800),
+	DRV_MSG_CODE_OV_UPDATE_ESWITCH_MODE = DRV_MSG_CODE(0x3900),
+	DRV_MSG_CODE_S_TAG_UPDATE_ACK = DRV_MSG_CODE(0x3b00),
+	DRV_MSG_CODE_GET_OEM_UPDATES = DRV_MSG_CODE(0x4100),
+	DRV_MSG_CODE_GET_PPFID_BITMAP = DRV_MSG_CODE(0x4300),
+	DRV_MSG_CODE_VF_DISABLED_DONE = DRV_MSG_CODE(0xc000),
+	DRV_MSG_CODE_CFG_VF_MSIX = DRV_MSG_CODE(0xc001),
+	DRV_MSG_CODE_CFG_PF_VFS_MSIX = DRV_MSG_CODE(0xc002),
+	DRV_MSG_CODE_DEBUG_DATA_SEND = DRV_MSG_CODE(0xc004),
+};
+
 #define DRV_MSG_CODE_VMAC_TYPE_SHIFT            4
 #define DRV_MSG_CODE_VMAC_TYPE_MASK             0x30
 #define DRV_MSG_CODE_VMAC_TYPE_MAC              1
 #define DRV_MSG_CODE_VMAC_TYPE_WWNN             2
 #define DRV_MSG_CODE_VMAC_TYPE_WWPN             3
 
-#define DRV_MSG_CODE_GET_STATS                  0x00130000
+/* DRV_MSG_CODE_RETAIN_VMAC parameters */
+#define DRV_MSG_CODE_RETAIN_VMAC_FUNC_SHIFT 0
+#define DRV_MSG_CODE_RETAIN_VMAC_FUNC_MASK 0xf
+
+#define DRV_MSG_CODE_RETAIN_VMAC_TYPE_SHIFT 4
+#define DRV_MSG_CODE_RETAIN_VMAC_TYPE_MASK 0x70
+#define DRV_MSG_CODE_RETAIN_VMAC_TYPE_L2 0
+#define DRV_MSG_CODE_RETAIN_VMAC_TYPE_ISCSI 1
+#define DRV_MSG_CODE_RETAIN_VMAC_TYPE_FCOE 2
+#define DRV_MSG_CODE_RETAIN_VMAC_TYPE_WWNN 3
+#define DRV_MSG_CODE_RETAIN_VMAC_TYPE_WWPN 4
+
+#define DRV_MSG_CODE_MCP_RESET_FORCE 0xf04ce
+
 #define DRV_MSG_CODE_STATS_TYPE_LAN             1
 #define DRV_MSG_CODE_STATS_TYPE_FCOE            2
 #define DRV_MSG_CODE_STATS_TYPE_ISCSI           3
 #define DRV_MSG_CODE_STATS_TYPE_RDMA            4
 
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
+#define BW_MAX_MASK 0x000000ff
+#define BW_MAX_OFFSET 0
+#define BW_MIN_MASK 0x0000ff00
+#define BW_MIN_OFFSET 8
 
-#define DRV_MSG_CODE_DEBUG_DATA_SEND		0xc0040000
+#define DRV_MSG_FAN_FAILURE_TYPE BIT(0)
+#define DRV_MSG_TEMPERATURE_FAILURE_TYPE BIT(1)
 
 #define RESOURCE_CMD_REQ_RESC_MASK		0x0000001F
 #define RESOURCE_CMD_REQ_RESC_SHIFT		0
@@ -1028,7 +1252,7 @@ struct public_drv_mb {
 #define RESOURCE_DUMP				0
 
 /* DRV_MSG_CODE_MDUMP_CMD parameters */
-#define MDUMP_DRV_PARAM_OPCODE_MASK             0x0000000f
+#define MDUMP_DRV_PARAM_OPCODE_MASK             0x000000ff
 #define DRV_MSG_CODE_MDUMP_ACK                  0x01
 #define DRV_MSG_CODE_MDUMP_SET_VALUES           0x02
 #define DRV_MSG_CODE_MDUMP_TRIGGER              0x03
@@ -1039,23 +1263,66 @@ struct public_drv_mb {
 #define DRV_MSG_CODE_MDUMP_CLR_RETAIN           0x08
 
 #define DRV_MSG_CODE_HW_DUMP_TRIGGER            0x0a
-#define DRV_MSG_CODE_MDUMP_GEN_MDUMP2           0x0b
-#define DRV_MSG_CODE_MDUMP_FREE_MDUMP2          0x0c
 
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
+#define DRV_MSG_CODE_MDUMP_FREE_DRIVER_BUF 0x0b
+#define DRV_MSG_CODE_MDUMP_GEN_LINK_DUMP 0x0c
+#define DRV_MSG_CODE_MDUMP_GEN_IDLE_CHK 0x0d
+
+/* DRV_MSG_CODE_MDUMP_CMD options */
+#define MDUMP_DRV_PARAM_OPTION_MASK 0x00000f00
+#define DRV_MSG_CODE_MDUMP_USE_DRIVER_BUF_OFFSET 8
+#define DRV_MSG_CODE_MDUMP_USE_DRIVER_BUF_MASK 0x100
+
+/* DRV_MSG_CODE_EXT_PHY_READ/DRV_MSG_CODE_EXT_PHY_WRITE parameters */
+#define DRV_MB_PARAM_ADDR_SHIFT 0
+#define DRV_MB_PARAM_ADDR_MASK 0x0000FFFF
+#define DRV_MB_PARAM_DEVAD_SHIFT 16
+#define DRV_MB_PARAM_DEVAD_MASK 0x001F0000
+#define DRV_MB_PARAM_PORT_SHIFT 21
+#define DRV_MB_PARAM_PORT_MASK 0x00600000
+
+/* DRV_MSG_CODE_PMBUS_READ/DRV_MSG_CODE_PMBUS_WRITE parameters */
+#define DRV_MB_PARAM_PMBUS_CMD_SHIFT 0
+#define DRV_MB_PARAM_PMBUS_CMD_MASK 0xFF
+#define DRV_MB_PARAM_PMBUS_LEN_SHIFT 8
+#define DRV_MB_PARAM_PMBUS_LEN_MASK 0x300
+#define DRV_MB_PARAM_PMBUS_DATA_SHIFT 16
+#define DRV_MB_PARAM_PMBUS_DATA_MASK 0xFFFF0000
+
+/* UNLOAD_REQ params */
+#define DRV_MB_PARAM_UNLOAD_WOL_UNKNOWN 0x00000000
+#define DRV_MB_PARAM_UNLOAD_WOL_MCP 0x00000001
+#define DRV_MB_PARAM_UNLOAD_WOL_DISABLED 0x00000002
+#define DRV_MB_PARAM_UNLOAD_WOL_ENABLED 0x00000003
+
+/* UNLOAD_DONE_params */
+#define DRV_MB_PARAM_UNLOAD_NON_D3_POWER 0x00000001
+
+/* INIT_PHY params */
+#define DRV_MB_PARAM_INIT_PHY_FORCE 0x00000001
+#define DRV_MB_PARAM_INIT_PHY_DONT_CARE 0x00000002
+
+/* LLDP / DCBX params*/
+#define DRV_MB_PARAM_LLDP_SEND_MASK 0x00000001
+#define DRV_MB_PARAM_LLDP_SEND_SHIFT 0
+#define DRV_MB_PARAM_LLDP_AGENT_MASK 0x00000006
+#define DRV_MB_PARAM_LLDP_AGENT_SHIFT 1
+#define DRV_MB_PARAM_LLDP_TLV_RX_VALID_MASK 0x00000001
+#define DRV_MB_PARAM_LLDP_TLV_RX_VALID_SHIFT 0
+#define DRV_MB_PARAM_LLDP_TLV_RX_TYPE_MASK 0x000007f0
+#define DRV_MB_PARAM_LLDP_TLV_RX_TYPE_SHIFT 4
+#define DRV_MB_PARAM_DCBX_NOTIFY_MASK 0x00000008
+#define DRV_MB_PARAM_DCBX_NOTIFY_SHIFT 3
+#define DRV_MB_PARAM_DCBX_ADMIN_CFG_NOTIFY_MASK 0x00000010
+#define DRV_MB_PARAM_DCBX_ADMIN_CFG_NOTIFY_SHIFT 4
+
+#define DRV_MB_PARAM_NIG_DRAIN_PERIOD_MS_MASK 0x000000FF
+#define DRV_MB_PARAM_NIG_DRAIN_PERIOD_MS_SHIFT 0
+
+#define DRV_MB_PARAM_NVM_PUT_FILE_TYPE_MASK 0x000000ff
+#define DRV_MB_PARAM_NVM_PUT_FILE_TYPE_SHIFT 0
+#define DRV_MB_PARAM_NVM_PUT_FILE_BEGIN_MFW 0x1
+#define DRV_MB_PARAM_NVM_PUT_FILE_BEGIN_IMAGE 0x2
 
 #define DRV_MB_PARAM_NVM_PUT_FILE_BEGIN_MBI     0x3
 #define DRV_MB_PARAM_NVM_OFFSET_OFFSET          0
@@ -1067,8 +1334,6 @@ struct public_drv_mb {
 #define DRV_MB_PARAM_CFG_VF_MSIX_VF_ID_MASK	0x000000FF
 #define DRV_MB_PARAM_CFG_VF_MSIX_SB_NUM_SHIFT	8
 #define DRV_MB_PARAM_CFG_VF_MSIX_SB_NUM_MASK	0x0000FF00
-#define DRV_MB_PARAM_LLDP_SEND_MASK		0x00000001
-#define DRV_MB_PARAM_LLDP_SEND_SHIFT		0
 
 #define DRV_MB_PARAM_OV_CURR_CFG_SHIFT		0
 #define DRV_MB_PARAM_OV_CURR_CFG_MASK		0x0000000F
@@ -1131,6 +1396,7 @@ struct public_drv_mb {
 #define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_MASK		0x0000ffff
 #define DRV_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_SHIFT		0
 
+#define DRV_MB_PARAM_BIST_UNKNOWN_TEST				0
 #define DRV_MB_PARAM_BIST_REGISTER_TEST				1
 #define DRV_MB_PARAM_BIST_CLOCK_TEST				2
 #define DRV_MB_PARAM_BIST_NVM_TEST_NUM_IMAGES			3
@@ -1148,6 +1414,7 @@ struct public_drv_mb {
 
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_MASK			0x0000ffff
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_OFFSET		0
+#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_SMARTLINQ		0x00000001
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EEE			0x00000002
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_FEC_CONTROL		0x00000004
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EXT_SPEED_FEC_CONTROL	0x00000008
@@ -1164,8 +1431,9 @@ struct public_drv_mb {
 #define DRV_MB_PARAM_ATTRIBUTE_CMD_MASK				0xff000000
 
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ID_OFFSET			0
-#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_SHIFT			0
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ID_MASK			0x0000ffff
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_IGNORE			0x0000ffff
+#define DRV_MB_PARAM_NVM_CFG_OPTION_ID_SHIFT			0
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ALL_SHIFT			16
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ALL_MASK			0x00010000
 #define DRV_MB_PARAM_NVM_CFG_OPTION_INIT_SHIFT			17
@@ -1176,72 +1444,85 @@ struct public_drv_mb {
 #define DRV_MB_PARAM_NVM_CFG_OPTION_FREE_MASK			0x00080000
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_SEL_SHIFT		20
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_SEL_MASK		0x00100000
+#define DRV_MB_PARAM_NVM_CFG_OPTION_DEFAULT_RESTORE_ALL_SHIFT	21
+#define DRV_MB_PARAM_NVM_CFG_OPTION_DEFAULT_RESTORE_ALL_MASK 0x00200000
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_ID_SHIFT		24
 #define DRV_MB_PARAM_NVM_CFG_OPTION_ENTITY_ID_MASK		0x0f000000
 
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
+/*DRV_MSG_CODE_GET_PERM_MAC parametres*/
+#define DRV_MSG_CODE_GET_PERM_MAC_TYPE_SHIFT		0
+#define DRV_MSG_CODE_GET_PERM_MAC_TYPE_MASK		0xF
+#define DRV_MSG_CODE_GET_PERM_MAC_TYPE_PF		0
+#define DRV_MSG_CODE_GET_PERM_MAC_TYPE_BMC		1
+#define DRV_MSG_CODE_GET_PERM_MAC_TYPE_VF		2
+#define DRV_MSG_CODE_GET_PERM_MAC_TYPE_LLDP		3
+#define DRV_MSG_CODE_GET_PERM_MAC_TYPE_MAX		4
+#define DRV_MSG_CODE_GET_PERM_MAC_INDEX_SHIFT		8
+#define DRV_MSG_CODE_GET_PERM_MAC_INDEX_MASK		0xFFFF00
+
+#define FW_MSG_CODE(_code_)    ((_code_) << FW_MSG_CODE_OFFSET)
+enum fw_msg_code_enum {
+	FW_MSG_CODE_UNSUPPORTED = FW_MSG_CODE(0x0000),
+	FW_MSG_CODE_NVM_OK = FW_MSG_CODE(0x0001),
+	FW_MSG_CODE_NVM_PUT_FILE_FINISH_OK = FW_MSG_CODE(0x0040),
+	FW_MSG_CODE_PHY_OK = FW_MSG_CODE(0x0011),
+	FW_MSG_CODE_OK = FW_MSG_CODE(0x0016),
+	FW_MSG_CODE_ERROR = FW_MSG_CODE(0x0017),
+	FW_MSG_CODE_TRANSCEIVER_DIAG_OK = FW_MSG_CODE(0x0016),
+	FW_MSG_CODE_TRANSCEIVER_NOT_PRESENT = FW_MSG_CODE(0x0002),
+	FW_MSG_CODE_MDUMP_INVALID_CMD = FW_MSG_CODE(0x0003),
+	FW_MSG_CODE_OS_WOL_SUPPORTED = FW_MSG_CODE(0x0080),
+	FW_MSG_CODE_DRV_CFG_PF_VFS_MSIX_DONE = FW_MSG_CODE(0x0087),
+	FW_MSG_CODE_DRV_LOAD_ENGINE = FW_MSG_CODE(0x1010),
+	FW_MSG_CODE_DRV_LOAD_PORT = FW_MSG_CODE(0x1011),
+	FW_MSG_CODE_DRV_LOAD_FUNCTION = FW_MSG_CODE(0x1012),
+	FW_MSG_CODE_DRV_LOAD_REFUSED_PDA = FW_MSG_CODE(0x1020),
+	FW_MSG_CODE_DRV_LOAD_REFUSED_HSI_1 = FW_MSG_CODE(0x1021),
+	FW_MSG_CODE_DRV_LOAD_REFUSED_DIAG = FW_MSG_CODE(0x1022),
+	FW_MSG_CODE_DRV_LOAD_REFUSED_HSI = FW_MSG_CODE(0x1023),
+	FW_MSG_CODE_DRV_LOAD_REFUSED_REQUIRES_FORCE = FW_MSG_CODE(0x1030),
+	FW_MSG_CODE_DRV_LOAD_REFUSED_REJECT = FW_MSG_CODE(0x1031),
+	FW_MSG_CODE_DRV_LOAD_DONE = FW_MSG_CODE(0x1110),
+	FW_MSG_CODE_DRV_UNLOAD_ENGINE = FW_MSG_CODE(0x2011),
+	FW_MSG_CODE_DRV_UNLOAD_PORT = FW_MSG_CODE(0x2012),
+	FW_MSG_CODE_DRV_UNLOAD_FUNCTION = FW_MSG_CODE(0x2013),
+	FW_MSG_CODE_DRV_UNLOAD_DONE = FW_MSG_CODE(0x2110),
+	FW_MSG_CODE_RESOURCE_ALLOC_OK = FW_MSG_CODE(0x3400),
+	FW_MSG_CODE_RESOURCE_ALLOC_UNKNOWN = FW_MSG_CODE(0x3500),
+	FW_MSG_CODE_S_TAG_UPDATE_ACK_DONE = FW_MSG_CODE(0x3b00),
+	FW_MSG_CODE_DRV_CFG_VF_MSIX_DONE = FW_MSG_CODE(0xb001),
+	FW_MSG_CODE_DEBUG_NOT_ENABLED = FW_MSG_CODE(0xb00a),
+	FW_MSG_CODE_DEBUG_DATA_SEND_OK = FW_MSG_CODE(0xb00b),
+};
 
-	u32							fw_mb_param;
 #define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_MASK		0xffff0000
 #define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MAJOR_SHIFT		16
 #define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_MASK		0x0000ffff
 #define FW_MB_PARAM_RESOURCE_ALLOC_VERSION_MINOR_SHIFT		0
 
-	/* Get PF RDMA protocol command response */
+/* Get PF RDMA protocol command response */
 #define FW_MB_PARAM_GET_PF_RDMA_NONE				0x0
 #define FW_MB_PARAM_GET_PF_RDMA_ROCE				0x1
 #define FW_MB_PARAM_GET_PF_RDMA_IWARP				0x2
 #define FW_MB_PARAM_GET_PF_RDMA_BOTH				0x3
 
-	/* Get MFW feature support response */
+/* Get MFW feature support response */
 #define FW_MB_PARAM_FEATURE_SUPPORT_SMARTLINQ			BIT(0)
 #define FW_MB_PARAM_FEATURE_SUPPORT_EEE				BIT(1)
+#define FW_MB_PARAM_FEATURE_SUPPORT_DRV_LOAD_TO			BIT(2)
+#define FW_MB_PARAM_FEATURE_SUPPORT_LP_PRES_DET			BIT(3)
+#define FW_MB_PARAM_FEATURE_SUPPORT_RELAXED_ORD			BIT(4)
 #define FW_MB_PARAM_FEATURE_SUPPORT_FEC_CONTROL			BIT(5)
 #define FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL	BIT(6)
+#define FW_MB_PARAM_FEATURE_SUPPORT_IGU_CLEANUP			BIT(7)
+#define FW_MB_PARAM_FEATURE_SUPPORT_VF_DPM			BIT(8)
+#define FW_MB_PARAM_FEATURE_SUPPORT_IDLE_CHK			BIT(9)
 #define FW_MB_PARAM_FEATURE_SUPPORT_VLINK			BIT(16)
+#define FW_MB_PARAM_FEATURE_SUPPORT_DISABLE_LLDP		BIT(17)
+#define FW_MB_PARAM_FEATURE_SUPPORT_ENHANCED_SYS_LCK		BIT(18)
+#define FW_MB_PARAM_FEATURE_SUPPORT_RESTORE_DEFAULT_CFG		BIT(19)
+
+#define FW_MB_PARAM_MANAGEMENT_STATUS_LOCKDOWN_ENABLED		0x00000001
 
 #define FW_MB_PARAM_LOAD_DONE_DID_EFUSE_ERROR			BIT(0)
 
@@ -1257,20 +1538,6 @@ struct public_drv_mb {
 #define FW_MB_PARAM_PPFID_BITMAP_MASK				0xff
 #define FW_MB_PARAM_PPFID_BITMAP_SHIFT				0
 
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
 #define FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET_MASK		0x00ffffff
 #define FW_MB_PARAM_NVM_PUT_FILE_REQ_OFFSET_SHIFT		0
 #define FW_MB_PARAM_NVM_PUT_FILE_REQ_SIZE_MASK			0xff000000
@@ -1293,9 +1560,17 @@ enum MFW_DRV_MSG_TYPE {
 	MFW_DRV_MSG_FAILURE_DETECTED,
 	MFW_DRV_MSG_TRANSCEIVER_STATE_CHANGE,
 	MFW_DRV_MSG_CRITICAL_ERROR_OCCURRED,
-	MFW_DRV_MSG_RESERVED,
+	MFW_DRV_MSG_EEE_NEGOTIATION_COMPLETE,
 	MFW_DRV_MSG_GET_TLV_REQ,
 	MFW_DRV_MSG_OEM_CFG_UPDATE,
+	MFW_DRV_MSG_LLDP_RECEIVED_TLVS_UPDATED,
+	MFW_DRV_MSG_GENERIC_IDC,
+	MFW_DRV_MSG_XCVR_TX_FAULT,
+	MFW_DRV_MSG_XCVR_RX_LOS,
+	MFW_DRV_MSG_GET_FCOE_CAP,
+	MFW_DRV_MSG_GEN_LINK_DUMP,
+	MFW_DRV_MSG_GEN_IDLE_CHK,
+	MFW_DRV_MSG_DCBX_ADMIN_CFG_APPLIED,
 	MFW_DRV_MSG_MAX
 };
 
@@ -1320,6 +1595,20 @@ enum public_sections {
 	PUBLIC_MAX_SECTIONS
 };
 
+struct drv_ver_info_stc {
+	u32 ver;
+	u8 name[32];
+};
+
+/* Runtime data needs about 1/2K. We use 2K to be on the safe side.
+ * Please make sure data does not exceed this size.
+ */
+#define NUM_RUNTIME_DWORDS    16
+struct drv_init_hw_stc {
+	u32 init_hw_bitmask[NUM_RUNTIME_DWORDS];
+	u32 init_hw_data[NUM_RUNTIME_DWORDS * 32];
+};
+
 struct mcp_public_data {
 	u32 num_sections;
 	u32 sections[PUBLIC_MAX_SECTIONS];
@@ -1331,7 +1620,9 @@ struct mcp_public_data {
 	struct public_func func[MCP_GLOB_FUNC_MAX];
 };
 
+#define I2C_TRANSCEIVER_ADDR		0xa0
 #define MAX_I2C_TRANSACTION_SIZE	16
+#define MAX_I2C_TRANSCEIVER_PAGE_SIZE	256
 
 /* OCBB definitions */
 enum tlvs {
@@ -1557,9 +1848,34 @@ enum tlvs {
 	DRV_TLV_ISCSI_PDU_RX_FRAMES_RECEIVED,
 	DRV_TLV_ISCSI_PDU_RX_BYTES_RECEIVED,
 	DRV_TLV_ISCSI_PDU_TX_FRAMES_SENT,
-	DRV_TLV_ISCSI_PDU_TX_BYTES_SENT
+	DRV_TLV_ISCSI_PDU_TX_BYTES_SENT,
+	DRV_TLV_RDMA_DRV_VERSION
 };
 
+#define I2C_DEV_ADDR_A2				0xa2
+#define SFP_EEPROM_A2_TEMPERATURE_ADDR		0x60
+#define SFP_EEPROM_A2_TEMPERATURE_SIZE		2
+#define SFP_EEPROM_A2_VCC_ADDR			0x62
+#define SFP_EEPROM_A2_VCC_SIZE			2
+#define SFP_EEPROM_A2_TX_BIAS_ADDR		0x64
+#define SFP_EEPROM_A2_TX_BIAS_SIZE		2
+#define SFP_EEPROM_A2_TX_POWER_ADDR		0x66
+#define SFP_EEPROM_A2_TX_POWER_SIZE		2
+#define SFP_EEPROM_A2_RX_POWER_ADDR		0x68
+#define SFP_EEPROM_A2_RX_POWER_SIZE		2
+
+#define I2C_DEV_ADDR_A0				0xa0
+#define QSFP_EEPROM_A0_TEMPERATURE_ADDR		0x16
+#define QSFP_EEPROM_A0_TEMPERATURE_SIZE		2
+#define QSFP_EEPROM_A0_VCC_ADDR			0x1a
+#define QSFP_EEPROM_A0_VCC_SIZE			2
+#define QSFP_EEPROM_A0_TX1_BIAS_ADDR		0x2a
+#define QSFP_EEPROM_A0_TX1_BIAS_SIZE		2
+#define QSFP_EEPROM_A0_TX1_POWER_ADDR		0x32
+#define QSFP_EEPROM_A0_TX1_POWER_SIZE		2
+#define QSFP_EEPROM_A0_RX1_POWER_ADDR		0x22
+#define QSFP_EEPROM_A0_RX1_POWER_SIZE		2
+
 struct nvm_cfg_mac_address {
 	u32 mac_addr_hi;
 #define NVM_CFG_MAC_ADDRESS_HI_MASK 0x0000ffff
@@ -1649,11 +1965,49 @@ struct nvm_cfg1_glob {
 	u32 power_consumed;
 	u32 efi_version;
 	u32 multi_network_modes_capability;
-	u32 reserved[41];
+	u32 nvm_cfg_version;
+	u32 nvm_cfg_new_option_seq;
+	u32 nvm_cfg_removed_option_seq;
+	u32 nvm_cfg_updated_value_seq;
+	u32 extended_serial_number[8];
+	u32 option_kit_pn[8];
+	u32 spare_pn[8];
+	u32 mps25_active_txfir_pre;
+	u32 mps25_active_txfir_main;
+	u32 mps25_active_txfir_post;
+	u32 features;
+	u32 tx_rx_eq_25g_hlpc;
+	u32 tx_rx_eq_25g_llpc;
+	u32 tx_rx_eq_25g_ac;
+	u32 tx_rx_eq_10g_pc;
+	u32 tx_rx_eq_10g_ac;
+	u32 tx_rx_eq_1g;
+	u32 tx_rx_eq_25g_bt;
+	u32 tx_rx_eq_10g_bt;
+	u32 generic_cont4;
+	u32 preboot_debug_mode_std;
+	u32 preboot_debug_mode_ext;
+	u32 ext_phy_cfg1;
+	u32 clocks;
+	u32 pre2_generic_cont_1;
+	u32 pre2_generic_cont_2;
+	u32 pre2_generic_cont_3;
+	u32 tx_rx_eq_50g_hlpc;
+	u32 tx_rx_eq_50g_mlpc;
+	u32 tx_rx_eq_50g_llpc;
+	u32 tx_rx_eq_50g_ac;
+	u32 trace_modules;
+	u32 pcie_class_code_fcoe;
+	u32 pcie_class_code_iscsi;
+	u32 no_provisioned_mac;
+	u32 lowest_mbi_version;
+	u32 generic_cont5;
+	u32 pre2_generic_cont_4;
+	u32 reserved[40];
 };
 
 struct nvm_cfg1_path {
-	u32 reserved[30];
+	u32 reserved[1];
 };
 
 struct nvm_cfg1_port {
@@ -1788,8 +2142,10 @@ struct nvm_cfg1_port {
 #define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_P4 0x400
 
 	u32 extended_fec_mode;
-
-	u32 reserved[112];
+	u32 port_generic_cont_01;
+	u32 port_generic_cont_02;
+	u32 phy_temp_monitor;
+	u32 reserved[109];
 };
 
 struct nvm_cfg1_func {
@@ -1802,7 +2158,9 @@ struct nvm_cfg1_func {
 	struct nvm_cfg_mac_address fcoe_node_wwn_mac_addr;
 	struct nvm_cfg_mac_address fcoe_port_wwn_mac_addr;
 	u32 preboot_generic_cfg;
-	u32 reserved[8];
+	u32 features;
+	u32 mf_mode_feature;
+	u32 reserved[6];
 };
 
 struct nvm_cfg1 {
@@ -1812,6 +2170,51 @@ struct nvm_cfg1 {
 	struct nvm_cfg1_func func[MCP_GLOB_FUNC_MAX];
 };
 
+struct board_info {
+	u16 vendor_id;
+	u16 eth_did_suffix;
+	u16 sub_vendor_id;
+	u16 sub_device_id;
+	char *board_name;
+	char *friendly_name;
+};
+
+struct trace_module_info {
+	char *module_name;
+};
+
+#define NUM_TRACE_MODULES    25
+
+enum nvm_cfg_sections {
+	NVM_CFG_SECTION_NVM_CFG1,
+	NVM_CFG_SECTION_MAX
+};
+
+struct nvm_cfg {
+	u32 num_sections;
+	u32 sections_offset[NVM_CFG_SECTION_MAX];
+	struct nvm_cfg1 cfg1;
+};
+
+#define PORT_0		0
+#define PORT_1		1
+#define PORT_2		2
+#define PORT_3		3
+
+extern struct spad_layout g_spad;
+struct spad_layout {
+	struct nvm_cfg nvm_cfg;
+	struct mcp_public_data public_data;
+};
+
+#define MCP_SPAD_SIZE    0x00028000	/* 160 KB */
+
+#define SPAD_OFFSET(addr)    (((u32)(addr) - (u32)CPU_SPAD_BASE))
+
+#define TO_OFFSIZE(_offset, _size)                               \
+		((u32)((((u32)(_offset) >> 2) << OFFSIZE_OFFSET_OFFSET) | \
+		 (((u32)(_size) >> 2) << OFFSIZE_SIZE_OFFSET)))
+
 enum spad_sections {
 	SPAD_SECTION_TRACE,
 	SPAD_SECTION_NVM_CFG,
@@ -1820,7 +2223,8 @@ enum spad_sections {
 	SPAD_SECTION_MAX
 };
 
-#define MCP_TRACE_SIZE          2048	/* 2kb */
+#define STRUCT_OFFSET(f)    (STATIC_INIT_BASE + \
+			     __builtin_offsetof(struct static_init, f))
 
 /* This section is located at a fixed location in the beginning of the
  * scratchpad, to ensure that the MCP trace is not run over during MFW upgrade.
@@ -1834,43 +2238,45 @@ struct static_init {
 	offsize_t sections[SPAD_SECTION_MAX];
 #define SECTION(_sec_) (*((offsize_t *)(STRUCT_OFFSET(sections[_sec_]))))
 
+	u32 tim_hash[8];
+#define PRESERVED_TIM_HASH	((u8 *)(STRUCT_OFFSET(tim_hash)))
+	u32 tpu_hash[8];
+#define PRESERVED_TPU_HASH	((u8 *)(STRUCT_OFFSET(tpu_hash)))
+	u32 secure_pcie_fw_ver;
+#define SECURE_PCIE_FW_VER	(*((u32 *)(STRUCT_OFFSET(secure_pcie_fw_ver))))
+	u32 secure_running_mfw;
+#define SECURE_RUNNING_MFW	(*((u32 *)(STRUCT_OFFSET(secure_running_mfw))))
 	struct mcp_trace trace;
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
+};
+
+#define CRC_MAGIC_VALUE		0xDEBB20E3
+#define CRC32_POLYNOMIAL	0xEDB88320
+#define _KB(x)			((x) * 1024)
+#define _MB(x)			(_KB(x) * 1024)
+#define NVM_CRC_SIZE		(sizeof(u32))
+enum nvm_sw_arbitrator {
+	NVM_SW_ARB_HOST,
+	NVM_SW_ARB_MCP,
+	NVM_SW_ARB_UART,
+	NVM_SW_ARB_RESERVED
+};
+
+struct legacy_bootstrap_region {
+	u32 magic_value;
+#define NVM_MAGIC_VALUE    0x669955aa
+	u32 sram_start_addr;
+	u32 code_len;
+	u32 code_start_addr;
+	u32 crc;
+};
+
+struct nvm_code_entry {
+	u32 image_type;
+	u32 nvm_start_addr;
+	u32 len;
+	u32 sram_start_addr;
+	u32 sram_run_addr;
+};
 
 enum nvm_image_type {
 	NVM_TYPE_TIM1 = 0x01,
@@ -1900,7 +2306,7 @@ enum nvm_image_type {
 	NVM_TYPE_INIT_HW = 0x19,
 	NVM_TYPE_DEFAULT_CFG = 0x1a,
 	NVM_TYPE_MDUMP = 0x1b,
-	NVM_TYPE_META = 0x1c,
+	NVM_TYPE_NVM_META = 0x1c,
 	NVM_TYPE_ISCSI_CFG = 0x1d,
 	NVM_TYPE_FCOE_CFG = 0x1f,
 	NVM_TYPE_ETH_PHY_FW1 = 0x20,
@@ -1920,9 +2326,149 @@ enum nvm_image_type {
 	NVM_TYPE_ROM_TEST = 0xf0,
 	NVM_TYPE_88X33X0_PHY_FW = 0x31,
 	NVM_TYPE_88X33X0_PHY_SLAVE_FW = 0x32,
+	NVM_TYPE_IDLE_CHK = 0x33,
 	NVM_TYPE_MAX,
 };
 
+#define MAX_NVM_DIR_ENTRIES 100
+
+struct nvm_dir_meta {
+	u32 dir_id;
+	u32 nvm_dir_addr;
+	u32 num_images;
+	u32 next_mfw_to_run;
+};
+
+struct nvm_dir {
+	s32 seq;
+#define NVM_DIR_NEXT_MFW_MASK 0x00000001
+#define NVM_DIR_SEQ_MASK 0xfffffffe
+#define NVM_DIR_NEXT_MFW(seq) ((seq) & NVM_DIR_NEXT_MFW_MASK)
+#define NVM_DIR_UPDATE_SEQ(_seq, swap_mfw)\
+	({ \
+		_seq =  (((_seq + 2) & \
+			 NVM_DIR_SEQ_MASK) | \
+			 (NVM_DIR_NEXT_MFW(_seq ^ (swap_mfw))));\
+	})
+
+#define IS_DIR_SEQ_VALID(seq) (((seq) & NVM_DIR_SEQ_MASK) != \
+			       NVM_DIR_SEQ_MASK)
+
+	u32 num_images;
+	u32 rsrv;
+	struct nvm_code_entry code[1];	/* Up to MAX_NVM_DIR_ENTRIES */
+};
+
+#define NVM_DIR_SIZE(_num_images) (sizeof(struct nvm_dir) + \
+				   ((_num_images) - 1) *\
+				   sizeof(struct nvm_code_entry) +\
+				   NVM_CRC_SIZE)
+
+struct nvm_vpd_image {
+	u32 format_revision;
+#define VPD_IMAGE_VERSION 1
+
+	u8 vpd_data[1];
+};
+
 #define DIR_ID_1    (0)
+#define DIR_ID_2    (1)
+#define MAX_DIR_IDS (2)
+
+#define MFW_BUNDLE_1 (0)
+#define MFW_BUNDLE_2 (1)
+#define MAX_MFW_BUNDLES (2)
+
+#define FLASH_PAGE_SIZE 0x1000
+#define NVM_DIR_MAX_SIZE (FLASH_PAGE_SIZE)
+#define LEGACY_ASIC_MIM_MAX_SIZE (_KB(1200))
+
+#define FPGA_MIM_MAX_SIZE (0x40000)
+
+#define LIM_MAX_SIZE ((2 * FLASH_PAGE_SIZE) - \
+		      sizeof(struct legacy_bootstrap_region) \
+		      - NVM_RSV_SIZE)
+#define LIM_OFFSET (NVM_OFFSET(lim_image))
+#define NVM_RSV_SIZE (44)
+#define GET_MIM_MAX_SIZE(is_asic, is_e4) (LEGACY_ASIC_MIM_MAX_SIZE)
+#define GET_MIM_OFFSET(idx, is_asic, is_e4) (NVM_OFFSET(dir[MAX_MFW_BUNDLES])\
+					     + (((idx) == NVM_TYPE_MIM2) ? \
+					     GET_MIM_MAX_SIZE(is_asic, is_e4)\
+					     : 0))
+#define GET_NVM_FIXED_AREA_SIZE(is_asic, is_e4)	(sizeof(struct nvm_image) + \
+						 GET_MIM_MAX_SIZE(is_asic,\
+						is_e4) * 2)
+
+union nvm_dir_union {
+	struct nvm_dir dir;
+	u8 page[FLASH_PAGE_SIZE];
+};
+
+struct nvm_image {
+	struct legacy_bootstrap_region bootstrap;
+	u8 rsrv[NVM_RSV_SIZE];
+	u8 lim_image[LIM_MAX_SIZE];
+	union nvm_dir_union dir[MAX_MFW_BUNDLES];
+};
+
+#define NVM_OFFSET(f) ((u32_t)((int_ptr_t)(&(((struct nvm_image *)0)->(f)))))
 
+struct hw_set_info {
+	u32 reg_type;
+#define GRC_REG_TYPE 1
+#define PHY_REG_TYPE 2
+#define PCI_REG_TYPE 4
+
+	u32 bank_num;
+	u32 pf_num;
+	u32 operation;
+#define READ_OP 1
+#define WRITE_OP 2
+#define RMW_SET_OP 3
+#define RMW_CLR_OP 4
+
+	u32 reg_addr;
+	u32 reg_data;
+
+	u32 reset_type;
+#define POR_RESET_TYPE BIT(0)
+#define HARD_RESET_TYPE BIT(1)
+#define CORE_RESET_TYPE BIT(2)
+#define MCP_RESET_TYPE BIT(3)
+#define PERSET_ASSERT BIT(4)
+#define PERSET_DEASSERT BIT(5)
+};
+
+struct hw_set_image {
+	u32 format_version;
+#define HW_SET_IMAGE_VERSION 1
+	u32 no_hw_sets;
+	struct hw_set_info hw_sets[1];
+};
+
+#define MAX_SUPPORTED_NVM_OPTIONS 1000
+
+#define NVM_META_BIN_OPTION_OFFSET_MASK 0x0000ffff
+#define NVM_META_BIN_OPTION_OFFSET_SHIFT 0
+#define NVM_META_BIN_OPTION_LEN_MASK 0x00ff0000
+#define NVM_META_BIN_OPTION_LEN_OFFSET 16
+#define NVM_META_BIN_OPTION_ENTITY_MASK 0x03000000
+#define NVM_META_BIN_OPTION_ENTITY_SHIFT 24
+#define NVM_META_BIN_OPTION_ENTITY_GLOB 0
+#define NVM_META_BIN_OPTION_ENTITY_PORT 1
+#define NVM_META_BIN_OPTION_ENTITY_FUNC 2
+#define NVM_META_BIN_OPTION_CONFIG_TYPE_MASK 0x0c000000
+#define NVM_META_BIN_OPTION_CONFIG_TYPE_SHIFT 26
+#define NVM_META_BIN_OPTION_CONFIG_TYPE_USER 0
+#define NVM_META_BIN_OPTION_CONFIG_TYPE_FIXED 1
+#define NVM_META_BIN_OPTION_CONFIG_TYPE_FORCED 2
+
+struct nvm_meta_bin_t {
+	u32 magic;
+#define NVM_META_BIN_MAGIC 0x669955bb
+	u32 version;
+#define NVM_META_BIN_VERSION 1
+	u32 num_options;
+	u32 options[0];
+};
 #endif
-- 
2.24.1

