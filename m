Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C115B2FA
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Feb 2020 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgBLVrE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Feb 2020 16:47:04 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36010 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbgBLVrE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Feb 2020 16:47:04 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CLeYCm001625;
        Wed, 12 Feb 2020 13:45:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=LBX3ePmH+66sNrmQ/6w12banNpeSlOHguRdNYTJdtrU=;
 b=wnLTDAqDEXaNu6Wa7eaExi9SLc8Feo6lO6feFLGwTUz4QV2roltFM2UCZ5ntMDc+Nts6
 967JuJPuPd5c25Uv6z1SVDXIsxq03MSJW9W4Yl1x1kQ3Tzzvow5idlnHxF9IMpNsePMA
 5DqwsuYh6Zyt5dC9N2C7GaJf844EEhu4b0Ich3DzLMQr0JrFTxfoXH+5UVmc12zwBSc2
 lvDn/y3H/ZUK+S6cVlyUzxPmFZsUlz//PsTzWXKP0BC23QyLWF1iA2aPVMQH6dKLXC5h
 GCZdaHMTp/rrcLP+gooZNK2O6Kb9nMYgOe6+u78resSXRyE6q0hZq1euZlj9txcgYTJh pA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2y4j5jt4x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 13:45:01 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 13:44:59 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Feb 2020 13:44:59 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id EA3643F703F;
        Wed, 12 Feb 2020 13:44:58 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 01CLiwhL025596;
        Wed, 12 Feb 2020 13:44:58 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 01CLiwLQ025595;
        Wed, 12 Feb 2020 13:44:58 -0800
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 07/25] qla2xxx: Add vendor extended RDP additions and amendments
Date:   Wed, 12 Feb 2020 13:44:18 -0800
Message-ID: <20200212214436.25532-8-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200212214436.25532-1-hmadhani@marvell.com>
References: <20200212214436.25532-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_10:2020-02-12,2020-02-12 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Joe Carnuccio <joe.carnuccio@qlogic.com>

This patch adds RDP command support in the driver.
with the help of new ql2xsmartsan parameter, driver will
use PUREX IOCB mode to send RDP command to switch and will
be able to receive various diagnostic data.

Signed-off-by: Joe Carnuccio <joe.carnuccio@qlogic.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  | 135 ++++++++++
 drivers/scsi/qla2xxx/qla_fw.h   |  44 ++++
 drivers/scsi/qla2xxx/qla_gbl.h  |   3 +
 drivers/scsi/qla2xxx/qla_init.c |  15 +-
 drivers/scsi/qla2xxx/qla_isr.c  |  10 +
 drivers/scsi/qla2xxx/qla_mbx.c  |  58 +++++
 drivers/scsi/qla2xxx/qla_os.c   | 546 +++++++++++++++++++++++++++++++++++++++-
 7 files changed, 807 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 917939c5e5be..6ea0ef24a2a8 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -1267,6 +1267,9 @@ static inline bool qla2xxx_is_valid_mbs(unsigned int mbs)
 #define RNID_TYPE_SET_VERSION	0x9
 #define RNID_TYPE_ASIC_TEMP	0xC
 
+#define ELS_CMD_MAP_SIZE	32
+#define ELS_COMMAND_RDP		0x18
+
 /*
  * Firmware state codes from get firmware state mailbox command
  */
@@ -3562,6 +3565,133 @@ struct qlfc_fw {
 	uint32_t len;
 };
 
+struct rdp_req_payload {
+	uint32_t	els_request;
+	uint32_t	desc_list_len;
+
+	/* NPIV descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint8_t  reserved;
+		uint8_t  nport_id[3];
+	} npiv_desc;
+};
+
+struct rdp_rsp_payload {
+	struct {
+		uint32_t cmd;
+		uint32_t len;
+	} hdr;
+
+	/* LS Request Info descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint32_t req_payload_word_0;
+	} ls_req_info_desc;
+
+	/* LS Request Info descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint32_t req_payload_word_0;
+	} ls_req_info_desc2;
+
+	/* SFP diagnostic param descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint16_t temperature;
+		uint16_t vcc;
+		uint16_t tx_bias;
+		uint16_t tx_power;
+		uint16_t rx_power;
+		uint16_t sfp_flags;
+	} sfp_diag_desc;
+
+	/* Port Speed Descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint16_t speed_capab;
+		uint16_t operating_speed;
+	} port_speed_desc;
+
+	/* Link Error Status Descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint32_t link_fail_cnt;
+		uint32_t loss_sync_cnt;
+		uint32_t loss_sig_cnt;
+		uint32_t prim_seq_err_cnt;
+		uint32_t inval_xmit_word_cnt;
+		uint32_t inval_crc_cnt;
+		uint8_t  pn_port_phy_type;
+		uint8_t  reserved[3];
+	} ls_err_desc;
+
+	/* Port name description with diag param */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint8_t WWNN[WWN_SIZE];
+		uint8_t WWPN[WWN_SIZE];
+	} port_name_diag_desc;
+
+	/* Port Name desc for Direct attached Fx_Port or Nx_Port */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint8_t WWNN[WWN_SIZE];
+		uint8_t WWPN[WWN_SIZE];
+	} port_name_direct_desc;
+
+	/* Buffer Credit descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint32_t fcport_b2b;
+		uint32_t attached_fcport_b2b;
+		uint32_t fcport_rtt;
+	} buffer_credit_desc;
+
+	/* Optical Element Data Descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint16_t high_alarm;
+		uint16_t low_alarm;
+		uint16_t high_warn;
+		uint16_t low_warn;
+		uint32_t element_flags;
+	} optical_elmt_desc[5];
+
+	/* Optical Product Data Descriptor */
+	struct {
+		uint32_t desc_tag;
+		uint32_t desc_len;
+		uint8_t  vendor_name[16];
+		uint8_t  part_number[16];
+		uint8_t  serial_number[16];
+		uint8_t  revision[4];
+		uint8_t  date[8];
+	} optical_prod_desc;
+};
+
+#define RDP_DESC_LEN(obj) \
+    (sizeof(obj) - sizeof((obj).desc_tag) - sizeof((obj).desc_len))
+
+#define RDP_PORT_SPEED_1GB		BIT_15
+#define RDP_PORT_SPEED_2GB		BIT_14
+#define RDP_PORT_SPEED_4GB		BIT_13
+#define RDP_PORT_SPEED_10GB		BIT_12
+#define RDP_PORT_SPEED_8GB		BIT_11
+#define RDP_PORT_SPEED_16GB		BIT_10
+#define RDP_PORT_SPEED_32GB		BIT_9
+#define RDP_PORT_SPEED_UNKNOWN		BIT_0
+
 struct scsi_qlt_host {
 	void *target_lport_ptr;
 	struct mutex tgt_mutex;
@@ -3964,6 +4094,8 @@ struct qla_hw_data {
 
 #define SFP_DEV_SIZE    512
 #define SFP_BLOCK_SIZE  64
+#define SFP_RTDI_LEN	SFP_BLOCK_SIZE
+
 	void		*sfp_data;
 	dma_addr_t	sfp_data_dma;
 
@@ -4423,6 +4555,8 @@ typedef struct scsi_qla_host {
 #define ISP_ABORT_TO_ROM	33
 #define VPORT_DELETE		34
 
+#define PROCESS_PUREX_IOCB	63
+
 	unsigned long	pci_flags;
 #define PFLG_DISCONNECTED	0	/* PCI device removed */
 #define PFLG_DRIVER_REMOVING	1	/* PCI driver .remove */
@@ -4531,6 +4665,7 @@ typedef struct scsi_qla_host {
 	uint16_t ql2xexchoffld;
 	uint16_t ql2xiniexchg;
 
+	void	*purex_data;
 	struct name_list_extended gnl;
 	/* Count of active session/fcport */
 	int fcport_count;
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index 02c1dbb4abc8..649bdfd61bc5 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -724,6 +724,50 @@ struct ct_entry_24xx {
 };
 
 /*
+ * ISP queue - PUREX IOCB entry structure definition
+ */
+#define PUREX_IOCB_TYPE		0x51	/* CT Pass Through IOCB entry */
+typedef struct purex_entry_24xx {
+	uint8_t entry_type;		/* Entry type. */
+	uint8_t entry_count;		/* Entry count. */
+	uint8_t sys_define;		/* System defined. */
+	uint8_t entry_status;		/* Entry Status. */
+
+	uint16_t reserved1;
+	uint8_t vp_idx;
+	uint8_t reserved2;
+
+	uint16_t status_flags;
+	uint16_t nport_handle;
+
+	uint16_t frame_size;
+	uint16_t trunc_frame_size;
+
+	uint32_t rx_xchg_addr;
+
+	uint8_t d_id[3];
+	uint8_t r_ctl;
+
+	uint8_t s_id[3];
+	uint8_t cs_ctl;
+
+	uint8_t f_ctl[3];
+	uint8_t type;
+
+	uint16_t seq_cnt;
+	uint8_t df_ctl;
+	uint8_t seq_id;
+
+	uint16_t rx_id;
+	uint16_t ox_id;
+	uint32_t param;
+
+	uint8_t els_frame_payload[20];
+} purex_entry_24xx_t;
+
+#define PUREX_ENTRY_SIZE	(sizeof(purex_entry_24xx_t))
+
+/*
  * ISP queue - ELS Pass-Through entry structure definition.
  */
 #define ELS_IOCB_TYPE		0x53	/* ELS Pass-Through IOCB entry */
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index b40a3fb46c00..7679f8fa1ddc 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -458,6 +458,9 @@ extern int
 qla25xx_set_driver_version(scsi_qla_host_t *, char *);
 
 extern int
+qla25xx_set_els_cmds_supported(scsi_qla_host_t *);
+
+extern int
 qla24xx_get_buffer_credits(scsi_qla_host_t *, struct buffer_credit_24xx *,
     dma_addr_t);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 9887602529a3..2b36a1bdcc5f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3708,6 +3708,10 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 			    "ISP Firmware failed checksum.\n");
 			goto failed;
 		}
+
+		/* Enable PUREX PASSTHRU */
+		if (ql2xsmartsan)
+			qla25xx_set_els_cmds_supported(vha);
 	} else
 		goto failed;
 
@@ -3929,7 +3933,7 @@ qla24xx_update_fw_options(scsi_qla_host_t *vha)
 
 	/* Update Serial Link options. */
 	if ((le16_to_cpu(ha->fw_seriallink_options24[0]) & BIT_0) == 0)
-		return;
+		goto enable_purex;
 
 	rval = qla2x00_set_serdes_params(vha,
 	    le16_to_cpu(ha->fw_seriallink_options24[1]),
@@ -3939,6 +3943,12 @@ qla24xx_update_fw_options(scsi_qla_host_t *vha)
 		ql_log(ql_log_warn, vha, 0x0104,
 		    "Unable to update Serial Link options (%x).\n", rval);
 	}
+
+enable_purex:
+	if (ql2xsmartsan)
+		ha->fw_options[1] |= ADD_FO1_ENABLE_PUREX_IOCB;
+
+	qla2x00_set_fw_options(vha, ha->fw_options);
 }
 
 void
@@ -8672,6 +8682,9 @@ qla83xx_update_fw_options(scsi_qla_host_t *vha)
 {
 	struct qla_hw_data *ha = vha->hw;
 
+	if (ql2xsmartsan)
+		ha->fw_options[1] |= ADD_FO1_ENABLE_PUREX_IOCB;
+
 	qla2x00_set_fw_options(vha, ha->fw_options);
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 73b6cfd14581..f0a4245f892c 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -31,6 +31,13 @@ const char *const port_state_str[] = {
 	"ONLINE"
 };
 
+static void qla24xx_purex_iocb(scsi_qla_host_t *vha, struct req_que *req,
+    struct sts_entry_24xx *pkt)
+{
+	memcpy(vha->purex_data, pkt, PUREX_ENTRY_SIZE);
+	set_bit(PROCESS_PUREX_IOCB, &vha->dpc_flags);
+}
+
 /**
  * qla2100_intr_handler() - Process interrupts for the ISP2100 and ISP2200.
  * @irq: interrupt number
@@ -3128,6 +3135,9 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 			qla_ctrlvp_completed(vha, rsp->req,
 			    (struct vp_ctrl_entry_24xx *)pkt);
 			break;
+		case PUREX_IOCB_TYPE:
+			qla24xx_purex_iocb(vha, rsp->req, pkt);
+			break;
 		default:
 			/* Type Not Supported. */
 			ql_dbg(ql_dbg_async, vha, 0x5042,
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index f295bd73128f..2e531e289eb0 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4878,6 +4878,64 @@ qla24xx_get_port_login_templ(scsi_qla_host_t *vha, dma_addr_t buf_dma,
 }
 
 int
+qla25xx_set_els_cmds_supported(scsi_qla_host_t *vha)
+{
+	int rval;
+	mbx_cmd_t mc;
+	mbx_cmd_t *mcp = &mc;
+	uint8_t *els_cmd_map;
+	dma_addr_t els_cmd_map_dma;
+	uint cmd_opcode = ELS_COMMAND_RDP;
+	uint index = cmd_opcode / 8;
+	uint bit = cmd_opcode % 8;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (!IS_QLA25XX(ha) && !IS_QLA2031(ha) && !IS_QLA27XX(ha))
+		return QLA_SUCCESS;
+
+	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1197,
+	    "Entered %s.\n", __func__);
+
+	els_cmd_map = dma_alloc_coherent(&ha->pdev->dev, ELS_CMD_MAP_SIZE,
+	    &els_cmd_map_dma, GFP_KERNEL);
+	if (!els_cmd_map) {
+		ql_log(ql_log_warn, vha, 0x7101,
+		    "Failed to allocate RDP els command param.\n");
+		return QLA_MEMORY_ALLOC_FAILED;
+	}
+
+	memset(els_cmd_map, 0, ELS_CMD_MAP_SIZE);
+
+	els_cmd_map[index] |= 1 << bit;
+
+	mcp->mb[0] = MBC_SET_RNID_PARAMS;
+	mcp->mb[1] = RNID_TYPE_ELS_CMD << 8;
+	mcp->mb[2] = MSW(LSD(els_cmd_map_dma));
+	mcp->mb[3] = LSW(LSD(els_cmd_map_dma));
+	mcp->mb[6] = MSW(MSD(els_cmd_map_dma));
+	mcp->mb[7] = LSW(MSD(els_cmd_map_dma));
+	mcp->out_mb = MBX_7|MBX_6|MBX_3|MBX_2|MBX_1|MBX_0;
+	mcp->in_mb = MBX_1|MBX_0;
+	mcp->tov = MBX_TOV_SECONDS;
+	mcp->flags = MBX_DMA_OUT;
+	mcp->buf_size = ELS_CMD_MAP_SIZE;
+	rval = qla2x00_mailbox_command(vha, mcp);
+
+	if (rval != QLA_SUCCESS) {
+		ql_dbg(ql_dbg_mbx, vha, 0x118d,
+		    "Failed=%x (%x,%x).\n", rval, mcp->mb[0], mcp->mb[1]);
+	} else {
+		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x118c,
+		    "Done %s.\n", __func__);
+	}
+
+	dma_free_coherent(&ha->pdev->dev, DMA_POOL_SIZE,
+	   els_cmd_map, els_cmd_map_dma);
+
+	return rval;
+}
+
+int
 qla24xx_get_buffer_credits(scsi_qla_host_t *vha, struct buffer_credit_24xx *bbc,
     dma_addr_t bbc_dma)
 {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 39d75de84db6..96f5577d3679 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -305,6 +305,15 @@ MODULE_PARM_DESC(ql2xdifbundlinginternalbuffers,
     "0 (Default). Based on check.\n"
     "1 Force using internal buffers\n");
 
+int ql2xsmartsan;
+module_param(ql2xsmartsan, int, 0444);
+module_param_named(smartsan, ql2xsmartsan, int, 0444);
+MODULE_PARM_DESC(ql2xsmartsan,
+               "Send SmartSAN Management Attributes for FDMI Registration."
+               " Default is 0 - No SmartSAN registration,"
+               " 1 - Register SmartSAN Management Attributes.");
+
+
 static void qla2x00_clear_drv_active(struct qla_hw_data *);
 static void qla2x00_free_device(scsi_qla_host_t *);
 static int qla2xxx_map_queues(struct Scsi_Host *shost);
@@ -3268,6 +3277,11 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto probe_failed;
 	}
 
+	base_vha->purex_data = kzalloc(PUREX_ENTRY_SIZE, GFP_KERNEL);
+	if (!base_vha->purex_data)
+		ql_log(ql_log_warn, base_vha, 0x7118,
+		    "Failed to allocate memory for PUREX data\n");
+
 	if (IS_QLAFX00(ha))
 		host->can_queue = QLAFX00_MAX_CANQUEUE;
 	else
@@ -3449,6 +3463,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 probe_failed:
+	kfree(base_vha->purex_data);
 	if (base_vha->gnl.l) {
 		dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
 				base_vha->gnl.l, base_vha->gnl.ldma);
@@ -3765,6 +3780,8 @@ qla2x00_remove_one(struct pci_dev *pdev)
 
 	qla84xx_put_chip(base_vha);
 
+	kfree(base_vha->purex_data);
+
 	/* Disable timer */
 	if (base_vha->timer_active)
 		qla2x00_stop_timer(base_vha);
@@ -5731,6 +5748,518 @@ qla83xx_idc_lock(scsi_qla_host_t *base_vha, uint16_t requester_id)
 	return;
 }
 
+static uint
+qla25xx_rdp_port_speed_capability(struct qla_hw_data *ha)
+{
+	if (IS_CNA_CAPABLE(ha))
+		return RDP_PORT_SPEED_10GB;
+
+	if (IS_QLA27XX(ha)) {
+		if (FW_ABILITY_MAX_SPEED(ha) == FW_ABILITY_MAX_SPEED_32G)
+			return RDP_PORT_SPEED_32GB|RDP_PORT_SPEED_16GB|
+			       RDP_PORT_SPEED_8GB;
+
+		return RDP_PORT_SPEED_16GB|RDP_PORT_SPEED_8GB|
+		       RDP_PORT_SPEED_4GB;
+	}
+
+	if (IS_QLA2031(ha))
+		return RDP_PORT_SPEED_16GB|RDP_PORT_SPEED_8GB|
+		       RDP_PORT_SPEED_4GB;
+
+	if (IS_QLA25XX(ha))
+		return RDP_PORT_SPEED_8GB|RDP_PORT_SPEED_4GB|
+		       RDP_PORT_SPEED_2GB|RDP_PORT_SPEED_1GB;
+
+	if (IS_QLA24XX_TYPE(ha))
+		return RDP_PORT_SPEED_4GB|RDP_PORT_SPEED_2GB|
+		       RDP_PORT_SPEED_1GB;
+
+	if (IS_QLA23XX(ha))
+		return RDP_PORT_SPEED_2GB|RDP_PORT_SPEED_1GB;
+
+	return RDP_PORT_SPEED_1GB;
+}
+
+static uint
+qla25xx_rdp_port_speed_currently(struct qla_hw_data *ha)
+{
+	switch (ha->link_data_rate) {
+	case PORT_SPEED_1GB:
+		return RDP_PORT_SPEED_1GB;
+
+	case PORT_SPEED_2GB:
+		return RDP_PORT_SPEED_2GB;
+
+	case PORT_SPEED_4GB:
+		return RDP_PORT_SPEED_4GB;
+
+	case PORT_SPEED_8GB:
+		return RDP_PORT_SPEED_8GB;
+
+	case PORT_SPEED_10GB:
+		return RDP_PORT_SPEED_10GB;
+
+	case PORT_SPEED_16GB:
+		return RDP_PORT_SPEED_16GB;
+
+	case PORT_SPEED_32GB:
+		return RDP_PORT_SPEED_32GB;
+
+	default:
+		return RDP_PORT_SPEED_UNKNOWN;
+	}
+}
+
+/*
+ * Function Name: qla24xx_process_purex_iocb
+ *
+ * Description:
+ * Prepare a RDP response and send to Fabric switch
+ *
+ * PARAMETERS:
+ * vha:	SCSI qla host
+ * purex: RDP request received by HBA
+ */
+static int qla24xx_process_purex_iocb(struct scsi_qla_host *vha, void *pkt)
+{
+	struct qla_hw_data *ha = vha->hw;
+	struct purex_entry_24xx *purex = pkt;
+	struct port_database_24xx *pdb = NULL;
+	dma_addr_t rsp_els_dma;
+	dma_addr_t rsp_payload_dma;
+	dma_addr_t stat_dma;
+	dma_addr_t bbc_dma;
+	dma_addr_t sfp_dma;
+	struct els_entry_24xx *rsp_els = NULL;
+	struct rdp_rsp_payload *rsp_payload = NULL;
+	struct link_statistics *stat = NULL;
+	struct buffer_credit_24xx *bbc = NULL;
+	uint8_t *sfp = NULL;
+	uint16_t sfp_flags = 0;
+	int rval = -ENOMEM;
+
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0180,
+	    "%s: Enter\n", __func__);
+
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0181,
+	    "-------- ELS REQ -------\n");
+	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0182,
+	    (void *)purex, sizeof(*purex));
+
+	rsp_els = dma_alloc_coherent(&ha->pdev->dev, sizeof(*rsp_els),
+	    &rsp_els_dma, GFP_KERNEL);
+	if (!rsp_els)
+		goto dealloc;
+
+	rsp_payload = dma_alloc_coherent(&ha->pdev->dev, sizeof(*rsp_payload),
+	    &rsp_payload_dma, GFP_KERNEL);
+	if (!rsp_payload)
+		goto dealloc;
+
+	sfp = dma_alloc_coherent(&ha->pdev->dev, SFP_RTDI_LEN,
+	    &sfp_dma, GFP_KERNEL);
+
+	stat = dma_alloc_coherent(&ha->pdev->dev, sizeof(*stat),
+	    &stat_dma, GFP_KERNEL);
+
+	bbc = dma_alloc_coherent(&ha->pdev->dev, sizeof(*bbc),
+	    &bbc_dma, GFP_KERNEL);
+
+	/* Prepare Response IOCB */
+	memset(rsp_els, 0, sizeof(*rsp_els));
+	rsp_els->entry_type = ELS_IOCB_TYPE;
+	rsp_els->entry_count = 1;
+	rsp_els->sys_define = 0;
+	rsp_els->entry_status = 0;
+	rsp_els->handle = 0;
+	rsp_els->nport_handle = purex->nport_handle;
+	rsp_els->tx_dsd_count = 1;
+	rsp_els->vp_index = purex->vp_idx;
+	rsp_els->sof_type = EST_SOFI3;
+	rsp_els->rx_xchg_address = purex->rx_xchg_addr;
+	rsp_els->rx_dsd_count = 0;
+	rsp_els->opcode = purex->els_frame_payload[0];
+
+	rsp_els->port_id[0] = purex->s_id[0];
+	rsp_els->port_id[1] = purex->s_id[1];
+	rsp_els->port_id[2] = purex->s_id[2];
+
+	rsp_els->control_flags = EPD_ELS_ACC;
+	rsp_els->rx_byte_count = 0;
+	rsp_els->tx_byte_count = cpu_to_le32(sizeof(*rsp_payload));
+
+	put_unaligned_le64(rsp_payload_dma, &rsp_els->tx_address);
+	rsp_els->tx_len = rsp_els->tx_byte_count;
+
+	rsp_els->rx_address = 0;
+	rsp_els->rx_len = 0;
+
+	if (sizeof(*rsp_payload) <= 0x100)
+		goto accept;
+
+	pdb = kzalloc(sizeof(*pdb), GFP_KERNEL);
+	if (!pdb)
+		goto reduce;
+
+	rval = qla24xx_get_port_database(vha, purex->nport_handle, pdb);
+	if (rval)
+		goto reduce;
+
+	if (pdb->port_id[0] != purex->s_id[2] ||
+	    pdb->port_id[1] != purex->s_id[1] ||
+	    pdb->port_id[2] != purex->s_id[0])
+		goto reduce;
+
+	if (pdb->current_login_state == PDS_PLOGI_COMPLETE ||
+	    pdb->current_login_state == PDS_PRLI_COMPLETE)
+		goto accept;
+
+reduce:
+	ql_dbg(ql_dbg_init, vha, 0x016e, "Requesting port is not logged in.\n");
+	rsp_els->tx_byte_count = rsp_els->tx_len =
+	    offsetof(struct rdp_rsp_payload, buffer_credit_desc);
+	ql_dbg(ql_dbg_init, vha, 0x016f, "Reduced response payload size %u.\n",
+	    rsp_els->tx_byte_count);
+
+accept:
+	/* Prepare Response Payload */
+	rsp_payload->hdr.cmd = cpu_to_be32(0x2 << 24); /* LS_ACC */
+	rsp_payload->hdr.len = cpu_to_be32(
+	    rsp_els->tx_byte_count - sizeof(rsp_payload->hdr));
+
+	/* Link service Request Info Descriptor */
+	rsp_payload->ls_req_info_desc.desc_tag = cpu_to_be32(0x1);
+	rsp_payload->ls_req_info_desc.desc_len =
+	    cpu_to_be32(RDP_DESC_LEN(rsp_payload->ls_req_info_desc));
+	rsp_payload->ls_req_info_desc.req_payload_word_0 =
+	    cpu_to_be32p((uint32_t *)purex->els_frame_payload);
+
+	/* Link service Request Info Descriptor 2 */
+	rsp_payload->ls_req_info_desc2.desc_tag = cpu_to_be32(0x1);
+	rsp_payload->ls_req_info_desc2.desc_len =
+	    cpu_to_be32(RDP_DESC_LEN(rsp_payload->ls_req_info_desc2));
+	rsp_payload->ls_req_info_desc2.req_payload_word_0 =
+	    cpu_to_be32p((uint32_t *)purex->els_frame_payload);
+
+	if (sfp) {
+		/* SFP Flags */
+		memset(sfp, 0, SFP_RTDI_LEN);
+		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa0, 0x7, 2, 0);
+		if (!rval) {
+			/* SFP Flags bits 3-0: Port Tx Laser Type */
+			if (sfp[0] & BIT_2 || sfp[1] & (BIT_6|BIT_5))
+				sfp_flags |= BIT_0; /* short wave */
+			else if (sfp[0] & BIT_1)
+				sfp_flags |= BIT_1; /* long wave 1310nm */
+			else if (sfp[1] & BIT_4)
+				sfp_flags |= BIT_1|BIT_0; /* long wave 1550nm */
+		}
+
+		/* SFP Type */
+		memset(sfp, 0, SFP_RTDI_LEN);
+		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa0, 0x0, 1, 0);
+		if (!rval) {
+			sfp_flags |= BIT_4; /* optical */
+			if (sfp[0] == 0x3)
+				sfp_flags |= BIT_6; /* sfp+ */
+		}
+
+		/* SFP Diagnostics */
+		memset(sfp, 0, SFP_RTDI_LEN);
+		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa2, 0x60, 10, 0);
+		if (!rval && sfp_flags) {
+			uint16_t *trx = (void *)sfp; /* already be16 */
+
+			rsp_payload->sfp_diag_desc.desc_tag =
+			    cpu_to_be32(0x10000);
+			rsp_payload->sfp_diag_desc.desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(rsp_payload->sfp_diag_desc));
+			rsp_payload->sfp_diag_desc.temperature = trx[0];
+			rsp_payload->sfp_diag_desc.vcc = trx[1];
+			rsp_payload->sfp_diag_desc.tx_bias = trx[2];
+			rsp_payload->sfp_diag_desc.tx_power = trx[3];
+			rsp_payload->sfp_diag_desc.rx_power = trx[4];
+			rsp_payload->sfp_diag_desc.sfp_flags =
+			    cpu_to_be16(sfp_flags);
+		}
+	}
+
+	/* Port Speed Descriptor */
+	rsp_payload->port_speed_desc.desc_tag = cpu_to_be32(0x10001);
+	rsp_payload->port_speed_desc.desc_len =
+	    cpu_to_be32(RDP_DESC_LEN(rsp_payload->port_speed_desc));
+	rsp_payload->port_speed_desc.speed_capab = cpu_to_be16(
+	    qla25xx_rdp_port_speed_capability(ha));
+	rsp_payload->port_speed_desc.operating_speed = cpu_to_be16(
+	    qla25xx_rdp_port_speed_currently(ha));
+
+	if (stat) {
+		rval = qla24xx_get_isp_stats(vha, stat, stat_dma, 0);
+		if (!rval) {
+			/* Link Error Status Descriptor */
+			rsp_payload->ls_err_desc.desc_tag =
+			    cpu_to_be32(0x10002);
+			rsp_payload->ls_err_desc.desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(rsp_payload->ls_err_desc));
+			rsp_payload->ls_err_desc.link_fail_cnt =
+			    cpu_to_be32(stat->link_fail_cnt);
+			rsp_payload->ls_err_desc.loss_sync_cnt =
+			    cpu_to_be32(stat->loss_sync_cnt);
+			rsp_payload->ls_err_desc.loss_sig_cnt =
+			    cpu_to_be32(stat->loss_sig_cnt);
+			rsp_payload->ls_err_desc.prim_seq_err_cnt =
+			    cpu_to_be32(stat->prim_seq_err_cnt);
+			rsp_payload->ls_err_desc.inval_xmit_word_cnt =
+			    cpu_to_be32(stat->inval_xmit_word_cnt);
+			rsp_payload->ls_err_desc.inval_crc_cnt =
+			    cpu_to_be32(stat->inval_crc_cnt);
+			rsp_payload->ls_err_desc.pn_port_phy_type |= BIT_6;
+		}
+	}
+
+	/* Portname Descriptor */
+	rsp_payload->port_name_diag_desc.desc_tag = cpu_to_be32(0x10003);
+	rsp_payload->port_name_diag_desc.desc_len =
+	    cpu_to_be32(RDP_DESC_LEN(rsp_payload->port_name_diag_desc));
+	memcpy(rsp_payload->port_name_diag_desc.WWNN,
+	    vha->node_name,
+	    sizeof(rsp_payload->port_name_diag_desc.WWNN));
+	memcpy(rsp_payload->port_name_diag_desc.WWPN,
+	    vha->port_name,
+	    sizeof(rsp_payload->port_name_diag_desc.WWPN));
+
+	/* F-Port Portname Descriptor */
+	rsp_payload->port_name_direct_desc.desc_tag = cpu_to_be32(0x10003);
+	rsp_payload->port_name_direct_desc.desc_len =
+	    cpu_to_be32(RDP_DESC_LEN(rsp_payload->port_name_direct_desc));
+	memcpy(rsp_payload->port_name_direct_desc.WWNN,
+	    vha->fabric_node_name,
+	    sizeof(rsp_payload->port_name_direct_desc.WWNN));
+	memcpy(rsp_payload->port_name_direct_desc.WWPN,
+	    vha->fabric_port_name,
+	    sizeof(rsp_payload->port_name_direct_desc.WWPN));
+
+	if (rsp_els->tx_byte_count < sizeof(*rsp_payload))
+		goto send;
+
+	if (bbc) {
+		memset(bbc, 0, sizeof(*bbc));
+		rval = qla24xx_get_buffer_credits(vha, bbc, bbc_dma);
+		if (!rval) {
+			/* Bufer Credit Descriptor */
+			rsp_payload->buffer_credit_desc.desc_tag =
+			    cpu_to_be32(0x10006);
+			rsp_payload->buffer_credit_desc.desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(
+				rsp_payload->buffer_credit_desc));
+			rsp_payload->buffer_credit_desc.fcport_b2b =
+			    cpu_to_be32(LSW(bbc->parameter[0]));
+			rsp_payload->buffer_credit_desc.attached_fcport_b2b =
+			    cpu_to_be32(0);
+			rsp_payload->buffer_credit_desc.fcport_rtt =
+			    cpu_to_be32(0);
+		}
+	}
+
+	if (sfp) {
+		memset(sfp, 0, SFP_RTDI_LEN);
+		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa2, 0, 64, 0);
+		if (!rval) {
+			uint16_t *trx = (void *)sfp; /* already be16 */
+
+			/* Optical Element Descriptor, Temperature */
+			rsp_payload->optical_elmt_desc[0].desc_tag =
+			    cpu_to_be32(0x10007);
+			rsp_payload->optical_elmt_desc[0].desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(
+				*rsp_payload->optical_elmt_desc));
+			rsp_payload->optical_elmt_desc[0].high_alarm = trx[0];
+			rsp_payload->optical_elmt_desc[0].low_alarm = trx[1];
+			rsp_payload->optical_elmt_desc[0].high_warn = trx[2];
+			rsp_payload->optical_elmt_desc[0].low_warn = trx[3];
+			rsp_payload->optical_elmt_desc[0].element_flags =
+			    cpu_to_be32(1 << 28);
+
+			/* Optical Element Descriptor, Voltage */
+			rsp_payload->optical_elmt_desc[1].desc_tag =
+			    cpu_to_be32(0x10007);
+			rsp_payload->optical_elmt_desc[1].desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(
+				*rsp_payload->optical_elmt_desc));
+			rsp_payload->optical_elmt_desc[1].high_alarm = trx[4];
+			rsp_payload->optical_elmt_desc[1].low_alarm = trx[5];
+			rsp_payload->optical_elmt_desc[1].high_warn = trx[6];
+			rsp_payload->optical_elmt_desc[1].low_warn = trx[7];
+			rsp_payload->optical_elmt_desc[1].element_flags =
+			    cpu_to_be32(2 << 28);
+
+			/* Optical Element Descriptor, Tx Bias Current */
+			rsp_payload->optical_elmt_desc[2].desc_tag =
+			    cpu_to_be32(0x10007);
+			rsp_payload->optical_elmt_desc[2].desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(
+				*rsp_payload->optical_elmt_desc));
+			rsp_payload->optical_elmt_desc[2].high_alarm = trx[8];
+			rsp_payload->optical_elmt_desc[2].low_alarm = trx[9];
+			rsp_payload->optical_elmt_desc[2].high_warn = trx[10];
+			rsp_payload->optical_elmt_desc[2].low_warn = trx[11];
+			rsp_payload->optical_elmt_desc[2].element_flags =
+			    cpu_to_be32(3 << 28);
+
+			/* Optical Element Descriptor, Tx Power */
+			rsp_payload->optical_elmt_desc[3].desc_tag =
+			    cpu_to_be32(0x10007);
+			rsp_payload->optical_elmt_desc[3].desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(
+				*rsp_payload->optical_elmt_desc));
+			rsp_payload->optical_elmt_desc[3].high_alarm = trx[12];
+			rsp_payload->optical_elmt_desc[3].low_alarm = trx[13];
+			rsp_payload->optical_elmt_desc[3].high_warn = trx[14];
+			rsp_payload->optical_elmt_desc[3].low_warn = trx[15];
+			rsp_payload->optical_elmt_desc[3].element_flags =
+			    cpu_to_be32(4 << 28);
+
+			/* Optical Element Descriptor, Rx Power */
+			rsp_payload->optical_elmt_desc[4].desc_tag =
+			    cpu_to_be32(0x10007);
+			rsp_payload->optical_elmt_desc[4].desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(
+				*rsp_payload->optical_elmt_desc));
+			rsp_payload->optical_elmt_desc[4].high_alarm = trx[16];
+			rsp_payload->optical_elmt_desc[4].low_alarm = trx[17];
+			rsp_payload->optical_elmt_desc[4].high_warn = trx[18];
+			rsp_payload->optical_elmt_desc[4].low_warn = trx[19];
+			rsp_payload->optical_elmt_desc[4].element_flags =
+			    cpu_to_be32(5 << 28);
+		}
+
+		memset(sfp, 0, SFP_RTDI_LEN);
+		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa2, 112, 64, 0);
+		if (!rval) {
+			/* Temperature high/low alarm/warning */
+			rsp_payload->optical_elmt_desc[0].element_flags |=
+			    cpu_to_be32(
+				(sfp[0] >> 7 & 1) << 3 |
+				(sfp[0] >> 6 & 1) << 2 |
+				(sfp[4] >> 7 & 1) << 1 |
+				(sfp[4] >> 6 & 1) << 0);
+
+			/* Voltage high/low alarm/warning */
+			rsp_payload->optical_elmt_desc[1].element_flags |=
+			    cpu_to_be32(
+				(sfp[0] >> 5 & 1) << 3 |
+				(sfp[0] >> 4 & 1) << 2 |
+				(sfp[4] >> 5 & 1) << 1 |
+				(sfp[4] >> 4 & 1) << 0);
+
+			/* Tx Bias Current high/low alarm/warning */
+			rsp_payload->optical_elmt_desc[2].element_flags |=
+			    cpu_to_be32(
+				(sfp[0] >> 3 & 1) << 3 |
+				(sfp[0] >> 2 & 1) << 2 |
+				(sfp[4] >> 3 & 1) << 1 |
+				(sfp[4] >> 2 & 1) << 0);
+
+			/* Tx Power high/low alarm/warning */
+			rsp_payload->optical_elmt_desc[3].element_flags |=
+			    cpu_to_be32(
+				(sfp[0] >> 1 & 1) << 3 |
+				(sfp[0] >> 0 & 1) << 2 |
+				(sfp[4] >> 1 & 1) << 1 |
+				(sfp[4] >> 0 & 1) << 0);
+
+			/* Rx Power high/low alarm/warning */
+			rsp_payload->optical_elmt_desc[4].element_flags |=
+			    cpu_to_be32(
+				(sfp[1] >> 7 & 1) << 3 |
+				(sfp[1] >> 6 & 1) << 2 |
+				(sfp[5] >> 7 & 1) << 1 |
+				(sfp[5] >> 6 & 1) << 0);
+		}
+	}
+
+	if (sfp) {
+		memset(sfp, 0, SFP_RTDI_LEN);
+		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa0, 20, 64, 0);
+		if (!rval) {
+			/* Optical Product Data Descriptor */
+			rsp_payload->optical_prod_desc.desc_tag =
+			    cpu_to_be32(0x10008);
+			rsp_payload->optical_prod_desc.desc_len =
+			    cpu_to_be32(RDP_DESC_LEN(
+				rsp_payload->optical_prod_desc));
+			memcpy(rsp_payload->optical_prod_desc.vendor_name,
+			    sfp + 0,
+			    sizeof(rsp_payload->optical_prod_desc.vendor_name));
+			memcpy(rsp_payload->optical_prod_desc.part_number,
+			    sfp + 20,
+			    sizeof(rsp_payload->optical_prod_desc.part_number));
+			memcpy(rsp_payload->optical_prod_desc.revision,
+			    sfp + 36,
+			    sizeof(rsp_payload->optical_prod_desc.revision));
+			memcpy(rsp_payload->optical_prod_desc.serial_number,
+			    sfp + 48,
+			    sizeof(rsp_payload->optical_prod_desc.serial_number));
+		}
+
+		memset(sfp, 0, SFP_RTDI_LEN);
+		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa0, 84, 8, 0);
+		if (!rval) {
+			memcpy(rsp_payload->optical_prod_desc.date,
+			    sfp + 0,
+			    sizeof(rsp_payload->optical_prod_desc.date));
+		}
+	}
+
+send:
+	ql_dbg(ql_dbg_init, vha, 0x0183,
+	    "Sending ELS Response to RDP Request...\n");
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0184,
+	    "-------- ELS RSP -------\n");
+	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0185,
+	    (void *)rsp_els, sizeof(*rsp_els));
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0186,
+	    "-------- ELS RSP PAYLOAD -------\n");
+	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0187,
+	    (void *)rsp_payload, rsp_els->tx_byte_count);
+
+	rval = qla2x00_issue_iocb(vha, rsp_els, rsp_els_dma, 0);
+
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_log_warn, vha, 0x0188,
+		    "%s: failed to issue IOCB (%x).\n", __func__, rval);
+	} else if (rsp_els->entry_status != 0) {
+		ql_log(ql_log_warn, vha, 0x0189,
+		    "%s: failed to complete IOCB -- error status (%x).\n",
+		    __func__, rsp_els->entry_status);
+		rval = QLA_FUNCTION_FAILED;
+	} else {
+		ql_dbg(ql_dbg_init, vha, 0x018a, "%s: done.\n", __func__);
+	}
+
+dealloc:
+	kfree(pdb);
+
+	if (bbc)
+		dma_free_coherent(&ha->pdev->dev, sizeof(*bbc),
+		    bbc, bbc_dma);
+	if (stat)
+		dma_free_coherent(&ha->pdev->dev, sizeof(*stat),
+		    stat, stat_dma);
+	if (sfp)
+		dma_free_coherent(&ha->pdev->dev, SFP_RTDI_LEN,
+		    sfp, sfp_dma);
+	if (rsp_payload)
+		dma_free_coherent(&ha->pdev->dev, sizeof(*rsp_payload),
+		    rsp_payload, rsp_payload_dma);
+	if (rsp_els)
+		dma_free_coherent(&ha->pdev->dev, sizeof(*rsp_els),
+		    rsp_els, rsp_els_dma);
+
+	return rval;
+}
+
 void
 qla83xx_idc_unlock(scsi_qla_host_t *base_vha, uint16_t requester_id)
 {
@@ -6078,6 +6607,8 @@ qla2x00_disable_board_on_pci_error(struct work_struct *work)
 
 	base_vha->flags.online = 0;
 
+	kfree(base_vha->purex_data);
+
 	qla2x00_destroy_deferred_work(ha);
 
 	/*
@@ -6301,6 +6832,13 @@ qla2x00_do_dpc(void *data)
 			}
 		}
 
+		if (test_bit(PROCESS_PUREX_IOCB, &base_vha->dpc_flags) &&
+		   (atomic_read(&base_vha->loop_state) == LOOP_READY)) {
+			qla24xx_process_purex_iocb(base_vha,
+			   base_vha->purex_data);
+			clear_bit(PROCESS_PUREX_IOCB, &base_vha->dpc_flags);
+		}
+
 		if (test_and_clear_bit(FCPORT_UPDATE_NEEDED,
 		    &base_vha->dpc_flags)) {
 			qla2x00_update_fcports(base_vha);
@@ -6692,7 +7230,8 @@ qla2x00_timer(struct timer_list *t)
 	    test_bit(ISP_UNRECOVERABLE, &vha->dpc_flags) ||
 	    test_bit(FCOE_CTX_RESET_NEEDED, &vha->dpc_flags) ||
 	    test_bit(VP_DPC_NEEDED, &vha->dpc_flags) ||
-	    test_bit(RELOGIN_NEEDED, &vha->dpc_flags))) {
+	    test_bit(RELOGIN_NEEDED, &vha->dpc_flags) ||
+	    test_bit(PROCESS_PUREX_IOCB, &vha->dpc_flags))) {
 		ql_dbg(ql_dbg_timer, vha, 0x600b,
 		    "isp_abort_needed=%d loop_resync_needed=%d "
 		    "fcport_update_needed=%d start_dpc=%d "
@@ -6705,12 +7244,13 @@ qla2x00_timer(struct timer_list *t)
 		ql_dbg(ql_dbg_timer, vha, 0x600c,
 		    "beacon_blink_needed=%d isp_unrecoverable=%d "
 		    "fcoe_ctx_reset_needed=%d vp_dpc_needed=%d "
-		    "relogin_needed=%d.\n",
+		    "relogin_needed=%d, Process_purex_iocb=%d.\n",
 		    test_bit(BEACON_BLINK_NEEDED, &vha->dpc_flags),
 		    test_bit(ISP_UNRECOVERABLE, &vha->dpc_flags),
 		    test_bit(FCOE_CTX_RESET_NEEDED, &vha->dpc_flags),
 		    test_bit(VP_DPC_NEEDED, &vha->dpc_flags),
-		    test_bit(RELOGIN_NEEDED, &vha->dpc_flags));
+		    test_bit(RELOGIN_NEEDED, &vha->dpc_flags),
+		    test_bit(PROCESS_PUREX_IOCB, &vha->dpc_flags));
 		qla2xxx_wake_dpc(vha);
 	}
 
-- 
2.12.0

