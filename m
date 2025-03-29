Return-Path: <linux-scsi+bounces-13108-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF6A754A6
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Mar 2025 08:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E6E3B0101
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Mar 2025 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEC1A3A95;
	Sat, 29 Mar 2025 07:32:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917781724;
	Sat, 29 Mar 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743233565; cv=none; b=qFb0SmeRaBOkx1cUhAQiBiAm2JYvq3409XDQY+r4mbix2XjOpUQlZidNz84eIOt8HjRBNR8etZofMpFz0r7q2OfgM3Uc+V2m2GX0VWUvbALc44ZmwG2UKV4DVMPpo06LbTce/CS1X8eM+x9qtlCBTykqADNULlrbJKueG10sG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743233565; c=relaxed/simple;
	bh=15W7AwfUnvl44zdDArga5ytR1GwE0p+5I5N7Qii6hYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Flrcfr+qeHBoVGFJc52ST7Spc3FFyZMO9zL/EDKDEK0UVuBy850Lhc8SdaLMC12hv1AA/KOMtn0ScFJdBmrF2XaxIOW/DjHLt7hcVF8cDMEwpCJVU932WxY7qtABrgxM5eJ8SHkqhFtkaAnljLtU31JABlix39FsYmzI3fsuaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZPptQ639vz2CdQD;
	Sat, 29 Mar 2025 15:29:18 +0800 (CST)
Received: from dggpemf100013.china.huawei.com (unknown [7.185.36.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FAD51A016C;
	Sat, 29 Mar 2025 15:32:37 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 dggpemf100013.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Mar 2025 15:32:36 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@huawei.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH 2/5] scsi: hisi_sas: Use macro instead of magic number
Date: Sat, 29 Mar 2025 15:32:33 +0800
Message-ID: <20250329073236.2300582-3-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250329073236.2300582-1-liyihang9@huawei.com>
References: <20250329073236.2300582-1-liyihang9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100013.china.huawei.com (7.185.36.179)

The hisi_sas driver has a large number of magic numbers, which is
unfriendly to code reading, so macro definitions are used instead.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  42 +++--
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  41 +++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 238 +++++++++++++++----------
 3 files changed, 206 insertions(+), 115 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index f93eefe68ccb..0f1bc6445aca 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -46,6 +46,13 @@
 #define HISI_SAS_IOST_ITCT_CACHE_DW_SZ 10
 #define HISI_SAS_FIFO_DATA_DW_SIZE 32
 
+#define HISI_SAS_REG_MEM_SIZE 4
+#define HISI_SAS_MAX_CDB_LEN 16
+#define HISI_SAS_BLK_QUEUE_DEPTH 64
+
+#define BYTE_TO_DW 4
+#define BYTE_TO_DDW 8
+
 #define HISI_SAS_STATUS_BUF_SZ (sizeof(struct hisi_sas_status_buffer))
 #define HISI_SAS_COMMAND_TABLE_SZ (sizeof(union hisi_sas_command_table))
 
@@ -92,6 +99,7 @@
 
 #define HISI_SAS_WAIT_PHYUP_TIMEOUT	(30 * HZ)
 #define HISI_SAS_CLEAR_ITCT_TIMEOUT	(20 * HZ)
+#define HISI_SAS_DELAY_FOR_PHY_DISABLE 100
 
 struct hisi_hba;
 
@@ -167,6 +175,8 @@ struct hisi_sas_debugfs_fifo {
 	u32 rd_data[HISI_SAS_FIFO_DATA_DW_SIZE];
 };
 
+#define FRAME_RCVD_BUF 32
+#define SAS_PHY_RESV_SIZE 2
 struct hisi_sas_phy {
 	struct work_struct	works[HISI_PHYES_NUM];
 	struct hisi_hba	*hisi_hba;
@@ -178,10 +188,10 @@ struct hisi_sas_phy {
 	spinlock_t lock;
 	u64		port_id; /* from hw */
 	u64		frame_rcvd_size;
-	u8		frame_rcvd[32];
+	u8		frame_rcvd[FRAME_RCVD_BUF];
 	u8		phy_attached;
 	u8		in_reset;
-	u8		reserved[2];
+	u8		reserved[SAS_PHY_RESV_SIZE];
 	u32		phy_type;
 	u32		code_violation_err_count;
 	enum sas_linkrate	minimum_linkrate;
@@ -349,6 +359,7 @@ struct hisi_sas_hw {
 };
 
 #define HISI_SAS_MAX_DEBUGFS_DUMP (50)
+#define HISI_SAS_DEFAULT_DEBUGFS_DUMP 1
 
 struct hisi_sas_debugfs_cq {
 	struct hisi_sas_cq *cq;
@@ -529,12 +540,13 @@ struct hisi_sas_cmd_hdr {
 	__le64 dif_prd_table_addr;
 };
 
+#define ITCT_RESV_DDW 12
 struct hisi_sas_itct {
 	__le64 qw0;
 	__le64 sas_addr;
 	__le64 qw2;
 	__le64 qw3;
-	__le64 qw4_15[12];
+	__le64 qw4_15[ITCT_RESV_DDW];
 };
 
 struct hisi_sas_iost {
@@ -544,22 +556,26 @@ struct hisi_sas_iost {
 	__le64 qw3;
 };
 
+#define ERROR_RECORD_BUF_DW 4
 struct hisi_sas_err_record {
-	u32	data[4];
+	u32	data[ERROR_RECORD_BUF_DW];
 };
 
+#define FIS_RESV_DW 3
 struct hisi_sas_initial_fis {
 	struct hisi_sas_err_record err_record;
 	struct dev_to_host_fis fis;
-	u32 rsvd[3];
+	u32 rsvd[FIS_RESV_DW];
 };
 
+#define BREAKPOINT_DATA_SIZE 128
 struct hisi_sas_breakpoint {
-	u8	data[128];
+	u8	data[BREAKPOINT_DATA_SIZE];
 };
 
+#define BREAKPOINT_TAG_NUM 32
 struct hisi_sas_sata_breakpoint {
-	struct hisi_sas_breakpoint tag[32];
+	struct hisi_sas_breakpoint tag[BREAKPOINT_TAG_NUM];
 };
 
 struct hisi_sas_sge {
@@ -570,13 +586,15 @@ struct hisi_sas_sge {
 	__le32 data_off;
 };
 
+#define SMP_CMD_TABLE_SIZE 44
 struct hisi_sas_command_table_smp {
-	u8 bytes[44];
+	u8 bytes[SMP_CMD_TABLE_SIZE];
 };
 
+#define DUMMY_BUF_SIZE 12
 struct hisi_sas_command_table_stp {
 	struct	host_to_dev_fis command_fis;
-	u8	dummy[12];
+	u8	dummy[DUMMY_BUF_SIZE];
 	u8	atapi_cdb[ATAPI_CDB_LEN];
 };
 
@@ -590,12 +608,13 @@ struct hisi_sas_sge_dif_page {
 	struct hisi_sas_sge sge[HISI_SAS_SGE_DIF_PAGE_CNT];
 }  __aligned(16);
 
+#define PROT_BUF_SIZE 7
 struct hisi_sas_command_table_ssp {
 	struct ssp_frame_hdr hdr;
 	union {
 		struct {
 			struct ssp_command_iu task;
-			u32 prot[7];
+			u32 prot[PROT_BUF_SIZE];
 		};
 		struct ssp_tmf_iu ssp_task;
 		struct xfer_rdy_iu xfer_rdy;
@@ -609,9 +628,10 @@ union hisi_sas_command_table {
 	struct hisi_sas_command_table_stp stp;
 }  __aligned(16);
 
+#define IU_BUF_SIZE 1024
 struct hisi_sas_status_buffer {
 	struct hisi_sas_err_record err;
-	u8	iu[1024];
+	u8	iu[IU_BUF_SIZE];
 }  __aligned(16);
 
 struct hisi_sas_slot_buf_table {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 3d2e8ec7f110..9f36037ed1cb 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -7,6 +7,16 @@
 #include "hisi_sas.h"
 #define DRV_NAME "hisi_sas"
 
+#define LINK_RATE_BIT_MASK 2
+#define FIS_BUF_SIZE 20
+#define WAIT_CMD_COMPLETE_DELAY 100
+#define WAIT_CMD_COMPLETE_TMROUT 5000
+#define DELAY_FOR_LINK_READY 2000
+#define BLK_CNT_OPTIMIZE_MARK 64
+#define HZ_TO_MHZ 1000000
+#define DELAY_FOR_SOFTRESET_MAX 1000
+#define DELAY_FOR_SOFTRESET_MIN 900
+
 #define DEV_IS_GONE(dev) \
 	((!dev) || (dev->dev_type == SAS_PHY_UNUSED))
 
@@ -151,7 +161,7 @@ u8 hisi_sas_get_prog_phy_linkrate_mask(enum sas_linkrate max)
 
 	max -= SAS_LINK_RATE_1_5_GBPS;
 	for (i = 0; i <= max; i++)
-		rate |= 1 << (i * 2);
+		rate |= 1 << (i * LINK_RATE_BIT_MASK);
 	return rate;
 }
 EXPORT_SYMBOL_GPL(hisi_sas_get_prog_phy_linkrate_mask);
@@ -902,7 +912,7 @@ int hisi_sas_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 	if (ret)
 		return ret;
 	if (!dev_is_sata(dev))
-		sas_change_queue_depth(sdev, 64);
+		sas_change_queue_depth(sdev, HISI_SAS_BLK_QUEUE_DEPTH);
 
 	return 0;
 }
@@ -1264,7 +1274,7 @@ static int hisi_sas_phy_set_linkrate(struct hisi_hba *hisi_hba, int phy_no,
 	sas_phy->phy->minimum_linkrate = min;
 
 	hisi_sas_phy_enable(hisi_hba, phy_no, 0);
-	msleep(100);
+	msleep(HISI_SAS_DELAY_FOR_PHY_DISABLE);
 	hisi_hba->hw->phy_set_linkrate(hisi_hba, phy_no, &_r);
 	hisi_sas_phy_enable(hisi_hba, phy_no, 1);
 
@@ -1294,7 +1304,7 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 
 	case PHY_FUNC_LINK_RESET:
 		hisi_sas_phy_enable(hisi_hba, phy_no, 0);
-		msleep(100);
+		msleep(HISI_SAS_DELAY_FOR_PHY_DISABLE);
 		hisi_sas_phy_enable(hisi_hba, phy_no, 1);
 		break;
 
@@ -1349,7 +1359,7 @@ static void hisi_sas_fill_ata_reset_cmd(struct ata_device *dev,
 
 static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 {
-	u8 fis[20] = {0};
+	u8 fis[FIS_BUF_SIZE] = {0};
 	struct ata_port *ap = device->sata_dev.ap;
 	struct ata_link *link;
 	int rc = TMF_RESP_FUNC_FAILED;
@@ -1366,7 +1376,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 	}
 
 	if (rc == TMF_RESP_FUNC_COMPLETE) {
-		usleep_range(900, 1000);
+		usleep_range(DELAY_FOR_SOFTRESET_MIN, DELAY_FOR_SOFTRESET_MAX);
 		ata_for_each_link(link, ap, EDGE) {
 			int pmp = sata_srst_pmp(link);
 
@@ -1496,7 +1506,7 @@ static void hisi_sas_send_ata_reset_each_phy(struct hisi_hba *hisi_hba,
 	struct device *dev = hisi_hba->dev;
 	int rc = TMF_RESP_FUNC_FAILED;
 	struct ata_link *link;
-	u8 fis[20] = {0};
+	u8 fis[FIS_BUF_SIZE] = {0};
 	int i;
 
 	for (i = 0; i < hisi_hba->n_phy; i++) {
@@ -1563,7 +1573,9 @@ void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba)
 	hisi_hba->phy_state = hisi_hba->hw->get_phys_state(hisi_hba);
 
 	scsi_block_requests(shost);
-	hisi_hba->hw->wait_cmds_complete_timeout(hisi_hba, 100, 5000);
+	hisi_hba->hw->wait_cmds_complete_timeout(hisi_hba,
+						 WAIT_CMD_COMPLETE_DELAY,
+						 WAIT_CMD_COMPLETE_TMROUT);
 
 	/*
 	 * hisi_hba->timer is only used for v1/v2 hw, and check hw->sht
@@ -1864,7 +1876,7 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 		rc = ata_wait_after_reset(link, jiffies + HISI_SAS_WAIT_PHYUP_TIMEOUT,
 					  smp_ata_check_ready_type);
 	} else {
-		msleep(2000);
+		msleep(DELAY_FOR_LINK_READY);
 	}
 
 	return rc;
@@ -2298,12 +2310,14 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 		goto err_out;
 
 	/* roundup to avoid overly large block size */
-	max_command_entries_ru = roundup(max_command_entries, 64);
+	max_command_entries_ru = roundup(max_command_entries,
+					 BLK_CNT_OPTIMIZE_MARK);
 	if (hisi_hba->prot_mask & HISI_SAS_DIX_PROT_MASK)
 		sz_slot_buf_ru = sizeof(struct hisi_sas_slot_dif_buf_table);
 	else
 		sz_slot_buf_ru = sizeof(struct hisi_sas_slot_buf_table);
-	sz_slot_buf_ru = roundup(sz_slot_buf_ru, 64);
+
+	sz_slot_buf_ru = roundup(sz_slot_buf_ru, BLK_CNT_OPTIMIZE_MARK);
 	s = max(lcm(max_command_entries_ru, sz_slot_buf_ru), PAGE_SIZE);
 	blk_cnt = (max_command_entries_ru * sz_slot_buf_ru) / s;
 	slots_per_blk = s / sz_slot_buf_ru;
@@ -2468,7 +2482,8 @@ int hisi_sas_get_fw_info(struct hisi_hba *hisi_hba)
 	if (IS_ERR(refclk))
 		dev_dbg(dev, "no ref clk property\n");
 	else
-		hisi_hba->refclk_frequency_mhz = clk_get_rate(refclk) / 1000000;
+		hisi_hba->refclk_frequency_mhz = clk_get_rate(refclk) /
+						 HZ_TO_MHZ;
 
 	if (device_property_read_u32(dev, "phy-count", &hisi_hba->n_phy)) {
 		dev_err(dev, "could not get property phy-count\n");
@@ -2590,7 +2605,7 @@ int hisi_sas_probe(struct platform_device *pdev,
 	shost->max_id = HISI_SAS_MAX_DEVICES;
 	shost->max_lun = ~0;
 	shost->max_channel = 1;
-	shost->max_cmd_len = 16;
+	shost->max_cmd_len = HISI_SAS_MAX_CDB_LEN;
 	if (hisi_hba->hw->slot_index_alloc) {
 		shost->can_queue = HISI_SAS_MAX_COMMANDS;
 		shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a1f0a59a8c8d..e739b09aea9a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -536,6 +536,43 @@ struct hisi_sas_err_record_v3 {
 
 #define BASE_VECTORS_V3_HW  16
 #define MIN_AFFINE_VECTORS_V3_HW  (BASE_VECTORS_V3_HW + 1)
+#define IRQ_PHY_UP_DOWN_INDEX 1
+#define IRQ_CHL_INDEX 2
+#define IRQ_AXI_INDEX 11
+
+#define DELAY_FOR_RESET_HW 100
+#define HDR_SG_MOD 0x2
+#define LUN_SIZE 8
+#define ATTR_PRIO_REGION 9
+#define CDB_REGION 12
+#define PRIO_OFF 3
+#define TMF_REGION 10
+#define TAG_MSB 12
+#define TAG_LSB 13
+#define SMP_FRAME_TYPE 2
+#define SMP_CRC_SIZE 4
+#define HDR_TAG_OFF 3
+#define HOST_NO_OFF 6
+#define PHY_NO_OFF 7
+#define IDENTIFY_REG_READ 6
+#define LINK_RESET_TIMEOUT_OFF 4
+#define DECIMALISM_FLAG 10
+#define WAIT_RETRY 100
+#define WAIT_TMROUT 5000
+
+#define ID_DWORD0_INDEX 0
+#define ID_DWORD1_INDEX 1
+#define ID_DWORD2_INDEX 2
+#define ID_DWORD3_INDEX 3
+#define ID_DWORD4_INDEX 4
+#define ID_DWORD5_INDEX 5
+#define TICKS_BIT_INDEX 24
+#define COUNT_BIT_INDEX 8
+
+#define PORT_REG_LENGTH	    0x100
+#define GLOBAL_REG_LENGTH   0x800
+#define	AXI_REG_LENGTH	    0x61
+#define RAS_REG_LENGTH	    0x10
 
 #define CHNL_INT_STS_MSK	0xeeeeeeee
 #define CHNL_INT_STS_PHY_MSK	0xe
@@ -816,17 +853,17 @@ static void config_id_frame_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 	identify_buffer = (u32 *)(&identify_frame);
 
 	hisi_sas_phy_write32(hisi_hba, phy_no, TX_ID_DWORD0,
-			__swab32(identify_buffer[0]));
+			__swab32(identify_buffer[ID_DWORD0_INDEX]));
 	hisi_sas_phy_write32(hisi_hba, phy_no, TX_ID_DWORD1,
-			__swab32(identify_buffer[1]));
+			__swab32(identify_buffer[ID_DWORD1_INDEX]));
 	hisi_sas_phy_write32(hisi_hba, phy_no, TX_ID_DWORD2,
-			__swab32(identify_buffer[2]));
+			__swab32(identify_buffer[ID_DWORD2_INDEX]));
 	hisi_sas_phy_write32(hisi_hba, phy_no, TX_ID_DWORD3,
-			__swab32(identify_buffer[3]));
+			__swab32(identify_buffer[ID_DWORD3_INDEX]));
 	hisi_sas_phy_write32(hisi_hba, phy_no, TX_ID_DWORD4,
-			__swab32(identify_buffer[4]));
+			__swab32(identify_buffer[ID_DWORD4_INDEX]));
 	hisi_sas_phy_write32(hisi_hba, phy_no, TX_ID_DWORD5,
-			__swab32(identify_buffer[5]));
+			__swab32(identify_buffer[ID_DWORD5_INDEX]));
 }
 
 static void setup_itct_v3_hw(struct hisi_hba *hisi_hba,
@@ -946,7 +983,7 @@ static int reset_hw_v3_hw(struct hisi_hba *hisi_hba)
 
 	/* Disable all of the PHYs */
 	hisi_sas_stop_phys(hisi_hba);
-	udelay(50);
+	udelay(HISI_SAS_DELAY_FOR_PHY_DISABLE);
 
 	/* Ensure axi bus idle */
 	ret = hisi_sas_read32_poll_timeout(AXI_CFG, val, !val,
@@ -986,7 +1023,7 @@ static int hw_init_v3_hw(struct hisi_hba *hisi_hba)
 		return rc;
 	}
 
-	msleep(100);
+	msleep(DELAY_FOR_RESET_HW);
 	init_reg_v3_hw(hisi_hba);
 
 	if (guid_parse("D5918B4B-37AE-4E10-A99F-E5E8A6EF4C1F", &guid)) {
@@ -1035,7 +1072,7 @@ static void disable_phy_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 	cfg &= ~PHY_CFG_ENA_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, PHY_CFG, cfg);
 
-	mdelay(50);
+	mdelay(HISI_SAS_DELAY_FOR_PHY_DISABLE);
 
 	state = hisi_sas_read32(hisi_hba, PHY_STATE);
 	if (state & BIT(phy_no)) {
@@ -1071,7 +1108,7 @@ static void phy_hard_reset_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 		hisi_sas_phy_write32(hisi_hba, phy_no, TXID_AUTO,
 					txid_auto | TX_HARDRST_MSK);
 	}
-	msleep(100);
+	msleep(HISI_SAS_DELAY_FOR_PHY_DISABLE);
 	hisi_sas_phy_enable(hisi_hba, phy_no, 1);
 }
 
@@ -1116,7 +1153,8 @@ static int get_wideport_bitmap_v3_hw(struct hisi_hba *hisi_hba, int port_id)
 
 	for (i = 0; i < hisi_hba->n_phy; i++)
 		if (phy_state & BIT(i))
-			if (((phy_port_num_ma >> (i * 4)) & 0xf) == port_id)
+			if (((phy_port_num_ma >> (i * HISI_SAS_REG_MEM_SIZE)) & 0xf) ==
+			    port_id)
 				bitmap |= BIT(i);
 
 	return bitmap;
@@ -1314,9 +1352,9 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 	dw1 |= sas_dev->device_id << CMD_HDR_DEV_ID_OFF;
 
 	dw2 = (((sizeof(struct ssp_command_iu) + sizeof(struct ssp_frame_hdr)
-	      + 3) / 4) << CMD_HDR_CFL_OFF) |
-	      ((HISI_SAS_MAX_SSP_RESP_SZ / 4) << CMD_HDR_MRFL_OFF) |
-	      (2 << CMD_HDR_SG_MOD_OFF);
+	      + 3) / BYTE_TO_DW) << CMD_HDR_CFL_OFF) |
+	      ((HISI_SAS_MAX_SSP_RESP_SZ / BYTE_TO_DW) << CMD_HDR_MRFL_OFF) |
+	      (HDR_SG_MOD << CMD_HDR_SG_MOD_OFF);
 	hdr->dw2 = cpu_to_le32(dw2);
 	hdr->transfer_tags = cpu_to_le32(slot->idx);
 
@@ -1336,18 +1374,19 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 	buf_cmd = hisi_sas_cmd_hdr_addr_mem(slot) +
 		sizeof(struct ssp_frame_hdr);
 
-	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
+	memcpy(buf_cmd, &task->ssp_task.LUN, LUN_SIZE);
 	if (!tmf) {
-		buf_cmd[9] = ssp_task->task_attr;
-		memcpy(buf_cmd + 12, scsi_cmnd->cmnd, scsi_cmnd->cmd_len);
+		buf_cmd[ATTR_PRIO_REGION] = ssp_task->task_attr;
+		memcpy(buf_cmd + CDB_REGION, scsi_cmnd->cmnd,
+		       scsi_cmnd->cmd_len);
 	} else {
-		buf_cmd[10] = tmf->tmf;
+		buf_cmd[TMF_REGION] = tmf->tmf;
 		switch (tmf->tmf) {
 		case TMF_ABORT_TASK:
 		case TMF_QUERY_TASK:
-			buf_cmd[12] =
+			buf_cmd[TAG_MSB] =
 				(tmf->tag_of_task_to_be_managed >> 8) & 0xff;
-			buf_cmd[13] =
+			buf_cmd[TAG_LSB] =
 				tmf->tag_of_task_to_be_managed & 0xff;
 			break;
 		default:
@@ -1380,7 +1419,8 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 			unsigned int interval = scsi_prot_interval(scsi_cmnd);
 			unsigned int ilog2_interval = ilog2(interval);
 
-			len = (task->total_xfer_len >> ilog2_interval) * 8;
+			len = (task->total_xfer_len >> ilog2_interval) *
+			      BYTE_TO_DDW;
 		}
 	}
 
@@ -1400,6 +1440,7 @@ static void prep_smp_v3_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	dma_addr_t req_dma_addr;
 	unsigned int req_len;
+	u32 cfl;
 
 	/* req */
 	sg_req = &task->smp_task.smp_req;
@@ -1410,7 +1451,7 @@ static void prep_smp_v3_hw(struct hisi_hba *hisi_hba,
 	/* dw0 */
 	hdr->dw0 = cpu_to_le32((port->id << CMD_HDR_PORT_OFF) |
 			       (1 << CMD_HDR_PRIORITY_OFF) | /* high pri */
-			       (2 << CMD_HDR_CMD_OFF)); /* smp */
+			       (SMP_FRAME_TYPE << CMD_HDR_CMD_OFF)); /* smp */
 
 	/* map itct entry */
 	hdr->dw1 = cpu_to_le32((sas_dev->device_id << CMD_HDR_DEV_ID_OFF) |
@@ -1418,8 +1459,9 @@ static void prep_smp_v3_hw(struct hisi_hba *hisi_hba,
 			       (DIR_NO_DATA << CMD_HDR_DIR_OFF));
 
 	/* dw2 */
-	hdr->dw2 = cpu_to_le32((((req_len - 4) / 4) << CMD_HDR_CFL_OFF) |
-			       (HISI_SAS_MAX_SMP_RESP_SZ / 4 <<
+	cfl = (req_len - SMP_CRC_SIZE) / BYTE_TO_DW;
+	hdr->dw2 = cpu_to_le32((cfl << CMD_HDR_CFL_OFF) |
+			       (HISI_SAS_MAX_SMP_RESP_SZ / BYTE_TO_DW <<
 			       CMD_HDR_MRFL_OFF));
 
 	hdr->transfer_tags = cpu_to_le32(slot->idx << CMD_HDR_IPTT_OFF);
@@ -1484,12 +1526,13 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 		struct ata_queued_cmd *qc = task->uldd_task;
 
 		hdr_tag = qc->tag;
-		task->ata_task.fis.sector_count |= (u8) (hdr_tag << 3);
+		task->ata_task.fis.sector_count |=
+				(u8)(hdr_tag << HDR_TAG_OFF);
 		dw2 |= hdr_tag << CMD_HDR_NCQ_TAG_OFF;
 	}
 
-	dw2 |= (HISI_SAS_MAX_STP_RESP_SZ / 4) << CMD_HDR_CFL_OFF |
-			2 << CMD_HDR_SG_MOD_OFF;
+	dw2 |= (HISI_SAS_MAX_STP_RESP_SZ / BYTE_TO_DW) << CMD_HDR_CFL_OFF |
+		HDR_SG_MOD << CMD_HDR_SG_MOD_OFF;
 	hdr->dw2 = cpu_to_le32(dw2);
 
 	/* dw3 */
@@ -1549,9 +1592,9 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	hisi_sas_phy_write32(hisi_hba, phy_no, PHYCTRL_PHY_ENA_MSK, 1);
 
 	port_id = hisi_sas_read32(hisi_hba, PHY_PORT_NUM_MA);
-	port_id = (port_id >> (4 * phy_no)) & 0xf;
+	port_id = (port_id >> (HISI_SAS_REG_MEM_SIZE * phy_no)) & 0xf;
 	link_rate = hisi_sas_read32(hisi_hba, PHY_CONN_RATE);
-	link_rate = (link_rate >> (phy_no * 4)) & 0xf;
+	link_rate = (link_rate >> (phy_no * HISI_SAS_REG_MEM_SIZE)) & 0xf;
 
 	if (port_id == 0xf) {
 		dev_err(dev, "phyup: phy%d invalid portid\n", phy_no);
@@ -1584,8 +1627,8 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 
 		sas_phy->oob_mode = SATA_OOB_MODE;
 		attached_sas_addr[0] = 0x50;
-		attached_sas_addr[6] = shost->host_no;
-		attached_sas_addr[7] = phy_no;
+		attached_sas_addr[HOST_NO_OFF] = shost->host_no;
+		attached_sas_addr[PHY_NO_OFF] = phy_no;
 		memcpy(sas_phy->attached_sas_addr,
 		       attached_sas_addr,
 		       SAS_ADDR_SIZE);
@@ -1601,7 +1644,7 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 			(struct sas_identify_frame *)frame_rcvd;
 
 		dev_info(dev, "phyup: phy%d link_rate=%d\n", phy_no, link_rate);
-		for (i = 0; i < 6; i++) {
+		for (i = 0; i < IDENTIFY_REG_READ; i++) {
 			u32 idaf = hisi_sas_phy_read32(hisi_hba, phy_no,
 					       RX_IDAF_DWORD0 + (i * 4));
 			frame_rcvd[i] = __swab32(idaf);
@@ -1871,7 +1914,7 @@ static void handle_chl_int2_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 
 		dev_warn(dev, "phy%d stp link timeout (0x%x)\n",
 			 phy_no, reg_value);
-		if (reg_value & BIT(4))
+		if (reg_value & BIT(LINK_RESET_TIMEOUT_OFF))
 			hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
 	}
 
@@ -2600,7 +2643,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 	struct pci_dev *pdev = hisi_hba->pci_dev;
 	int rc, i;
 
-	rc = devm_request_irq(dev, pci_irq_vector(pdev, 1),
+	rc = devm_request_irq(dev, pci_irq_vector(pdev, IRQ_PHY_UP_DOWN_INDEX),
 			      int_phy_up_down_bcast_v3_hw, 0,
 			      DRV_NAME " phy", hisi_hba);
 	if (rc) {
@@ -2608,7 +2651,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 		return -ENOENT;
 	}
 
-	rc = devm_request_irq(dev, pci_irq_vector(pdev, 2),
+	rc = devm_request_irq(dev, pci_irq_vector(pdev, IRQ_CHL_INDEX),
 			      int_chnl_int_v3_hw, 0,
 			      DRV_NAME " channel", hisi_hba);
 	if (rc) {
@@ -2616,7 +2659,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 		return -ENOENT;
 	}
 
-	rc = devm_request_irq(dev, pci_irq_vector(pdev, 11),
+	rc = devm_request_irq(dev, pci_irq_vector(pdev, IRQ_AXI_INDEX),
 			      fatal_axi_int_v3_hw, 0,
 			      DRV_NAME " fatal", hisi_hba);
 	if (rc) {
@@ -2629,7 +2672,8 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 
 	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
-		int nr = hisi_sas_intr_conv ? 16 : 16 + i;
+		int nr = hisi_sas_intr_conv ? BASE_VECTORS_V3_HW :
+					      BASE_VECTORS_V3_HW + i;
 		unsigned long irqflags = hisi_sas_intr_conv ? IRQF_SHARED :
 							      IRQF_ONESHOT;
 		int cpu;
@@ -2691,14 +2735,14 @@ static void interrupt_disable_v3_hw(struct hisi_hba *hisi_hba)
 	struct pci_dev *pdev = hisi_hba->pci_dev;
 	int i;
 
-	synchronize_irq(pci_irq_vector(pdev, 1));
-	synchronize_irq(pci_irq_vector(pdev, 2));
-	synchronize_irq(pci_irq_vector(pdev, 11));
+	synchronize_irq(pci_irq_vector(pdev, IRQ_PHY_UP_DOWN_INDEX));
+	synchronize_irq(pci_irq_vector(pdev, IRQ_CHL_INDEX));
+	synchronize_irq(pci_irq_vector(pdev, IRQ_AXI_INDEX));
 	for (i = 0; i < hisi_hba->queue_count; i++)
 		hisi_sas_write32(hisi_hba, OQ0_INT_SRC_MSK + 0x4 * i, 0x1);
 
 	for (i = 0; i < hisi_hba->cq_nvecs; i++)
-		synchronize_irq(pci_irq_vector(pdev, i + 16));
+		synchronize_irq(pci_irq_vector(pdev, i + BASE_VECTORS_V3_HW));
 
 	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK1, 0xffffffff);
 	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK2, 0xffffffff);
@@ -2730,7 +2774,7 @@ static int disable_host_v3_hw(struct hisi_hba *hisi_hba)
 
 	hisi_sas_stop_phys(hisi_hba);
 
-	mdelay(10);
+	mdelay(HISI_SAS_DELAY_FOR_PHY_DISABLE);
 
 	reg_val = hisi_sas_read32(hisi_hba, AXI_MASTER_CFG_BASE +
 				  AM_CTRL_GLOBAL);
@@ -2867,13 +2911,13 @@ static ssize_t intr_coal_ticks_v3_hw_store(struct device *dev,
 	u32 intr_coal_ticks;
 	int ret;
 
-	ret = kstrtou32(buf, 10, &intr_coal_ticks);
+	ret = kstrtou32(buf, DECIMALISM_FLAG, &intr_coal_ticks);
 	if (ret) {
 		dev_err(dev, "Input data of interrupt coalesce unmatch\n");
 		return -EINVAL;
 	}
 
-	if (intr_coal_ticks >= BIT(24)) {
+	if (intr_coal_ticks >= BIT(TICKS_BIT_INDEX)) {
 		dev_err(dev, "intr_coal_ticks must be less than 2^24!\n");
 		return -EINVAL;
 	}
@@ -2906,13 +2950,13 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 	u32 intr_coal_count;
 	int ret;
 
-	ret = kstrtou32(buf, 10, &intr_coal_count);
+	ret = kstrtou32(buf, DECIMALISM_FLAG, &intr_coal_count);
 	if (ret) {
 		dev_err(dev, "Input data of interrupt coalesce unmatch\n");
 		return -EINVAL;
 	}
 
-	if (intr_coal_count >= BIT(8)) {
+	if (intr_coal_count >= BIT(COUNT_BIT_INDEX)) {
 		dev_err(dev, "intr_coal_count must be less than 2^8!\n");
 		return -EINVAL;
 	}
@@ -3044,7 +3088,7 @@ static const struct hisi_sas_debugfs_reg_lu debugfs_port_reg_lu[] = {
 
 static const struct hisi_sas_debugfs_reg debugfs_port_reg = {
 	.lu = debugfs_port_reg_lu,
-	.count = 0x100,
+	.count = PORT_REG_LENGTH,
 	.base_off = PORT_BASE,
 };
 
@@ -3118,7 +3162,7 @@ static const struct hisi_sas_debugfs_reg_lu debugfs_global_reg_lu[] = {
 
 static const struct hisi_sas_debugfs_reg debugfs_global_reg = {
 	.lu = debugfs_global_reg_lu,
-	.count = 0x800,
+	.count = GLOBAL_REG_LENGTH,
 };
 
 static const struct hisi_sas_debugfs_reg_lu debugfs_axi_reg_lu[] = {
@@ -3131,7 +3175,7 @@ static const struct hisi_sas_debugfs_reg_lu debugfs_axi_reg_lu[] = {
 
 static const struct hisi_sas_debugfs_reg debugfs_axi_reg = {
 	.lu = debugfs_axi_reg_lu,
-	.count = 0x61,
+	.count = AXI_REG_LENGTH,
 	.base_off = AXI_MASTER_CFG_BASE,
 };
 
@@ -3148,7 +3192,7 @@ static const struct hisi_sas_debugfs_reg_lu debugfs_ras_reg_lu[] = {
 
 static const struct hisi_sas_debugfs_reg debugfs_ras_reg = {
 	.lu = debugfs_ras_reg_lu,
-	.count = 0x10,
+	.count = RAS_REG_LENGTH,
 	.base_off = RAS_BASE,
 };
 
@@ -3157,7 +3201,7 @@ static void debugfs_snapshot_prepare_v3_hw(struct hisi_hba *hisi_hba)
 	struct Scsi_Host *shost = hisi_hba->shost;
 
 	scsi_block_requests(shost);
-	wait_cmds_complete_timeout_v3_hw(hisi_hba, 100, 5000);
+	wait_cmds_complete_timeout_v3_hw(hisi_hba, WAIT_RETRY, WAIT_TMROUT);
 
 	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 	hisi_sas_sync_cqs(hisi_hba);
@@ -3198,7 +3242,7 @@ static void read_iost_itct_cache_v3_hw(struct hisi_hba *hisi_hba,
 		return;
 	}
 
-	memset(buf, 0, cache_dw_size * 4);
+	memset(buf, 0, cache_dw_size * BYTE_TO_DW);
 	buf[0] = val;
 
 	for (i = 1; i < cache_dw_size; i++)
@@ -3245,7 +3289,7 @@ static void hisi_sas_bist_test_restore_v3_hw(struct hisi_hba *hisi_hba)
 	reg_val = hisi_sas_phy_read32(hisi_hba, phy_no, PROG_PHY_LINK_RATE);
 	/* init OOB link rate as 1.5 Gbits */
 	reg_val &= ~CFG_PROG_OOB_PHY_LINK_RATE_MSK;
-	reg_val |= (0x8 << CFG_PROG_OOB_PHY_LINK_RATE_OFF);
+	reg_val |= (SAS_LINK_RATE_1_5_GBPS << CFG_PROG_OOB_PHY_LINK_RATE_OFF);
 	hisi_sas_phy_write32(hisi_hba, phy_no, PROG_PHY_LINK_RATE, reg_val);
 
 	/* enable PHY */
@@ -3254,6 +3298,9 @@ static void hisi_sas_bist_test_restore_v3_hw(struct hisi_hba *hisi_hba)
 
 #define SAS_PHY_BIST_CODE_INIT	0x1
 #define SAS_PHY_BIST_CODE1_INIT	0X80
+#define SAS_PHY_BIST_INIT_DELAY 100
+#define SAS_PHY_BIST_LOOP_TEST_0 1
+#define SAS_PHY_BIST_LOOP_TEST_1 2
 static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 {
 	u32 reg_val, mode_tmp;
@@ -3272,7 +3319,8 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 		 ffe[FFE_SATA_1_5_GBPS], ffe[FFE_SATA_3_0_GBPS],
 		 ffe[FFE_SATA_6_0_GBPS], fix_code[FIXED_CODE],
 		 fix_code[FIXED_CODE_1]);
-	mode_tmp = path_mode ? 2 : 1;
+	mode_tmp = path_mode ? SAS_PHY_BIST_LOOP_TEST_1 :
+			       SAS_PHY_BIST_LOOP_TEST_0;
 	if (enable) {
 		/* some preparations before bist test */
 		hisi_sas_bist_test_prep_v3_hw(hisi_hba);
@@ -3315,13 +3363,13 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 					     SAS_PHY_BIST_CODE1_INIT);
 		}
 
-		mdelay(100);
+		mdelay(SAS_PHY_BIST_INIT_DELAY);
 		reg_val |= (CFG_RX_BIST_EN_MSK | CFG_TX_BIST_EN_MSK);
 		hisi_sas_phy_write32(hisi_hba, phy_no, SAS_PHY_BIST_CTRL,
 				     reg_val);
 
 		/* clear error bit */
-		mdelay(100);
+		mdelay(SAS_PHY_BIST_INIT_DELAY);
 		hisi_sas_phy_read32(hisi_hba, phy_no, SAS_BIST_ERR_CNT);
 	} else {
 		/* disable bist test and recover it */
@@ -3522,7 +3570,7 @@ static void debugfs_snapshot_port_reg_v3_hw(struct hisi_hba *hisi_hba)
 	for (phy_cnt = 0; phy_cnt < hisi_hba->n_phy; phy_cnt++) {
 		databuf = hisi_hba->debugfs_port_reg[dump_index][phy_cnt].data;
 		for (i = 0; i < port->count; i++, databuf++) {
-			offset = port->base_off + 4 * i;
+			offset = port->base_off + HISI_SAS_REG_MEM_SIZE * i;
 			*databuf = hisi_sas_phy_read32(hisi_hba, phy_cnt,
 						       offset);
 		}
@@ -3536,7 +3584,8 @@ static void debugfs_snapshot_global_reg_v3_hw(struct hisi_hba *hisi_hba)
 	int i;
 
 	for (i = 0; i < debugfs_global_reg.count; i++, databuf++)
-		*databuf = hisi_sas_read32(hisi_hba, 4 * i);
+		*databuf = hisi_sas_read32(hisi_hba,
+					   HISI_SAS_REG_MEM_SIZE * i);
 }
 
 static void debugfs_snapshot_axi_reg_v3_hw(struct hisi_hba *hisi_hba)
@@ -3547,7 +3596,9 @@ static void debugfs_snapshot_axi_reg_v3_hw(struct hisi_hba *hisi_hba)
 	int i;
 
 	for (i = 0; i < axi->count; i++, databuf++)
-		*databuf = hisi_sas_read32(hisi_hba, 4 * i + axi->base_off);
+		*databuf = hisi_sas_read32(hisi_hba,
+					   HISI_SAS_REG_MEM_SIZE * i +
+					   axi->base_off);
 }
 
 static void debugfs_snapshot_ras_reg_v3_hw(struct hisi_hba *hisi_hba)
@@ -3558,7 +3609,9 @@ static void debugfs_snapshot_ras_reg_v3_hw(struct hisi_hba *hisi_hba)
 	int i;
 
 	for (i = 0; i < ras->count; i++, databuf++)
-		*databuf = hisi_sas_read32(hisi_hba, 4 * i + ras->base_off);
+		*databuf = hisi_sas_read32(hisi_hba,
+					   HISI_SAS_REG_MEM_SIZE * i +
+					   ras->base_off);
 }
 
 static void debugfs_snapshot_itct_reg_v3_hw(struct hisi_hba *hisi_hba)
@@ -3621,7 +3674,7 @@ static void debugfs_print_reg_v3_hw(u32 *regs_val, struct seq_file *s,
 	int i;
 
 	for (i = 0; i < reg->count; i++) {
-		int off = i * 4;
+		int off = i * HISI_SAS_REG_MEM_SIZE;
 		const char *name;
 
 		name = debugfs_to_reg_name_v3_hw(off, reg->base_off,
@@ -3699,9 +3752,9 @@ static void debugfs_show_row_64_v3_hw(struct seq_file *s, int index,
 
 	/* completion header size not fixed per HW version */
 	seq_printf(s, "index %04d:\n\t", index);
-	for (i = 1; i <= sz / 8; i++, ptr++) {
+	for (i = 1; i <= sz / BYTE_TO_DDW; i++, ptr++) {
 		seq_printf(s, " 0x%016llx", le64_to_cpu(*ptr));
-		if (!(i % 2))
+		if (!(i % TWO_PARA_PER_LINE))
 			seq_puts(s, "\n\t");
 	}
 
@@ -3715,9 +3768,9 @@ static void debugfs_show_row_32_v3_hw(struct seq_file *s, int index,
 
 	/* completion header size not fixed per HW version */
 	seq_printf(s, "index %04d:\n\t", index);
-	for (i = 1; i <= sz / 4; i++, ptr++) {
+	for (i = 1; i <= sz / BYTE_TO_DW; i++, ptr++) {
 		seq_printf(s, " 0x%08x", le32_to_cpu(*ptr));
-		if (!(i % 4))
+		if (!(i % FOUR_PARA_PER_LINE))
 			seq_puts(s, "\n\t");
 	}
 	seq_puts(s, "\n");
@@ -3802,7 +3855,7 @@ static int debugfs_iost_cache_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_iost_cache *debugfs_iost_cache = s->private;
 	struct hisi_sas_iost_itct_cache *iost_cache =
 						debugfs_iost_cache->cache;
-	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * 4;
+	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * BYTE_TO_DW;
 	int i, tab_idx;
 	__le64 *iost;
 
@@ -3850,7 +3903,7 @@ static int debugfs_itct_cache_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_itct_cache *debugfs_itct_cache = s->private;
 	struct hisi_sas_iost_itct_cache *itct_cache =
 						debugfs_itct_cache->cache;
-	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * 4;
+	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * BYTE_TO_DW;
 	int i, tab_idx;
 	__le64 *itct;
 
@@ -3879,12 +3932,12 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba, int index)
 	u64 *debugfs_timestamp;
 	struct dentry *dump_dentry;
 	struct dentry *dentry;
-	char name[256];
+	char name[NAME_BUF_SIZE];
 	int p;
 	int c;
 	int d;
 
-	snprintf(name, 256, "%d", index);
+	snprintf(name, NAME_BUF_SIZE, "%d", index);
 
 	dump_dentry = debugfs_create_dir(name, hisi_hba->debugfs_dump_dentry);
 
@@ -3900,7 +3953,7 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba, int index)
 	/* Create port dir and files */
 	dentry = debugfs_create_dir("port", dump_dentry);
 	for (p = 0; p < hisi_hba->n_phy; p++) {
-		snprintf(name, 256, "%d", p);
+		snprintf(name, NAME_BUF_SIZE, "%d", p);
 
 		debugfs_create_file(name, 0400, dentry,
 				    &hisi_hba->debugfs_port_reg[index][p],
@@ -3910,7 +3963,7 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba, int index)
 	/* Create CQ dir and files */
 	dentry = debugfs_create_dir("cq", dump_dentry);
 	for (c = 0; c < hisi_hba->queue_count; c++) {
-		snprintf(name, 256, "%d", c);
+		snprintf(name, NAME_BUF_SIZE, "%d", c);
 
 		debugfs_create_file(name, 0400, dentry,
 				    &hisi_hba->debugfs_cq[index][c],
@@ -3920,7 +3973,7 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba, int index)
 	/* Create DQ dir and files */
 	dentry = debugfs_create_dir("dq", dump_dentry);
 	for (d = 0; d < hisi_hba->queue_count; d++) {
-		snprintf(name, 256, "%d", d);
+		snprintf(name, NAME_BUF_SIZE, "%d", d);
 
 		debugfs_create_file(name, 0400, dentry,
 				    &hisi_hba->debugfs_dq[index][d],
@@ -3957,9 +4010,9 @@ static ssize_t debugfs_trigger_dump_v3_hw_write(struct file *file,
 						size_t count, loff_t *ppos)
 {
 	struct hisi_hba *hisi_hba = file->f_inode->i_private;
-	char buf[8];
+	char buf[DUMP_BUF_SIZE];
 
-	if (count > 8)
+	if (count > DUMP_BUF_SIZE)
 		return -EFAULT;
 
 	if (copy_from_user(buf, user_buf, count))
@@ -4023,7 +4076,7 @@ static ssize_t debugfs_bist_linkrate_v3_hw_write(struct file *filp,
 {
 	struct seq_file *m = filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
-	char kbuf[16] = {}, *pkbuf;
+	char kbuf[BIST_BUF_SIZE] = {}, *pkbuf;
 	bool found = false;
 	int i;
 
@@ -4040,7 +4093,7 @@ static ssize_t debugfs_bist_linkrate_v3_hw_write(struct file *filp,
 
 	for (i = 0; i < ARRAY_SIZE(debugfs_loop_linkrate_v3_hw); i++) {
 		if (!strncmp(debugfs_loop_linkrate_v3_hw[i].name,
-			     pkbuf, 16)) {
+			     pkbuf, BIST_BUF_SIZE)) {
 			hisi_hba->debugfs_bist_linkrate =
 				debugfs_loop_linkrate_v3_hw[i].value;
 			found = true;
@@ -4098,7 +4151,7 @@ static ssize_t debugfs_bist_code_mode_v3_hw_write(struct file *filp,
 {
 	struct seq_file *m = filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
-	char kbuf[16] = {}, *pkbuf;
+	char kbuf[BIST_BUF_SIZE] = {}, *pkbuf;
 	bool found = false;
 	int i;
 
@@ -4115,7 +4168,7 @@ static ssize_t debugfs_bist_code_mode_v3_hw_write(struct file *filp,
 
 	for (i = 0; i < ARRAY_SIZE(debugfs_loop_code_mode_v3_hw); i++) {
 		if (!strncmp(debugfs_loop_code_mode_v3_hw[i].name,
-			     pkbuf, 16)) {
+			     pkbuf, BIST_BUF_SIZE)) {
 			hisi_hba->debugfs_bist_code_mode =
 				debugfs_loop_code_mode_v3_hw[i].value;
 			found = true;
@@ -4230,7 +4283,7 @@ static ssize_t debugfs_bist_mode_v3_hw_write(struct file *filp,
 {
 	struct seq_file *m = filp->private_data;
 	struct hisi_hba *hisi_hba = m->private;
-	char kbuf[16] = {}, *pkbuf;
+	char kbuf[BIST_BUF_SIZE] = {}, *pkbuf;
 	bool found = false;
 	int i;
 
@@ -4246,7 +4299,8 @@ static ssize_t debugfs_bist_mode_v3_hw_write(struct file *filp,
 	pkbuf = strstrip(kbuf);
 
 	for (i = 0; i < ARRAY_SIZE(debugfs_loop_modes_v3_hw); i++) {
-		if (!strncmp(debugfs_loop_modes_v3_hw[i].name, pkbuf, 16)) {
+		if (!strncmp(debugfs_loop_modes_v3_hw[i].name, pkbuf,
+			     BIST_BUF_SIZE)) {
 			hisi_hba->debugfs_bist_mode =
 				debugfs_loop_modes_v3_hw[i].value;
 			found = true;
@@ -4525,8 +4579,9 @@ static int debugfs_fifo_data_v3_hw_show(struct seq_file *s, void *p)
 
 	debugfs_read_fifo_data_v3_hw(phy);
 
-	debugfs_show_row_32_v3_hw(s, 0, HISI_SAS_FIFO_DATA_DW_SIZE * 4,
-				  (__le32 *)phy->fifo.rd_data);
+	debugfs_show_row_32_v3_hw(s, 0,
+			HISI_SAS_FIFO_DATA_DW_SIZE * HISI_SAS_REG_MEM_SIZE,
+			phy->fifo.rd_data);
 
 	return 0;
 }
@@ -4658,14 +4713,14 @@ static int debugfs_alloc_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
 		struct hisi_sas_debugfs_regs *regs =
 				&hisi_hba->debugfs_regs[dump_index][r];
 
-		sz = debugfs_reg_array_v3_hw[r]->count * 4;
+		sz = debugfs_reg_array_v3_hw[r]->count * HISI_SAS_REG_MEM_SIZE;
 		regs->data = devm_kmalloc(dev, sz, GFP_KERNEL);
 		if (!regs->data)
 			goto fail;
 		regs->hisi_hba = hisi_hba;
 	}
 
-	sz = debugfs_port_reg.count * 4;
+	sz = debugfs_port_reg.count * HISI_SAS_REG_MEM_SIZE;
 	for (p = 0; p < hisi_hba->n_phy; p++) {
 		struct hisi_sas_debugfs_port *port =
 				&hisi_hba->debugfs_port_reg[dump_index][p];
@@ -4775,11 +4830,11 @@ static void debugfs_phy_down_cnt_init_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct dentry *dir = debugfs_create_dir("phy_down_cnt",
 						hisi_hba->debugfs_dir);
-	char name[16];
+	char name[NAME_BUF_SIZE];
 	int phy_no;
 
 	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
-		snprintf(name, 16, "%d", phy_no);
+		snprintf(name, NAME_BUF_SIZE, "%d", phy_no);
 		debugfs_create_file(name, 0600, dir,
 				    &hisi_hba->phy[phy_no],
 				    &debugfs_phy_down_cnt_v3_hw_fops);
@@ -4964,7 +5019,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_id = HISI_SAS_MAX_DEVICES;
 	shost->max_lun = ~0;
 	shost->max_channel = 1;
-	shost->max_cmd_len = 16;
+	shost->max_cmd_len = HISI_SAS_MAX_CDB_LEN;
 	shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
 	shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
 	if (hisi_hba->iopoll_q_cnt)
@@ -5042,12 +5097,13 @@ hisi_sas_v3_destroy_irqs(struct pci_dev *pdev, struct hisi_hba *hisi_hba)
 {
 	int i;
 
-	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, 1), hisi_hba);
-	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, 2), hisi_hba);
-	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, 11), hisi_hba);
+	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, IRQ_PHY_UP_DOWN_INDEX), hisi_hba);
+	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, IRQ_CHL_INDEX), hisi_hba);
+	devm_free_irq(&pdev->dev, pci_irq_vector(pdev, IRQ_AXI_INDEX), hisi_hba);
 	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
-		int nr = hisi_sas_intr_conv ? 16 : 16 + i;
+		int nr = hisi_sas_intr_conv ? BASE_VECTORS_V3_HW :
+					      BASE_VECTORS_V3_HW + i;
 
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, nr), cq);
 	}
-- 
2.33.0


