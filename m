Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACC25A6CF
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Sep 2020 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIBHbI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Sep 2020 03:31:08 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20068 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgIBHbI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Sep 2020 03:31:08 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0827PQdp023726
        for <linux-scsi@vger.kernel.org>; Wed, 2 Sep 2020 00:31:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=VTaNBu7wCI0mIdJFbB993A9O69+FtduhJMpEXucg9pI=;
 b=ZY+nCiDClTDmIPfphHmcqjAp/5FR2rSfhznnnUQ/1WewtAvqzSjPsnp2ykiOyjKsTIOr
 pAKB9TbS/0izVSYAyK8SuRrG5InmSnulIMNb7VQvxQja4lpoSYwsH7jRXmbDiA0PAfYB
 /dhSoYEluDIjWTlAwE97EWUZB1RXYKJV0iQGEVu7vgkrBlPG4aF/Le1+THecoWpr8OF1
 3M+SmlRPq+TiKrLXCY62diy+ibdEh8NdtB8uaYnkfXm4+LPPFxvxsFKZvu3wBTJsPmRv
 /nqUz5Wftiyg9B8vmHGEdB+dZZtFUYJ95BaOTd9Z4d630j4qYRgYiam8kJ0THX9oYPIX Tg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 337phq554s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 02 Sep 2020 00:31:06 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 00:31:03 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 00:31:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Sep 2020 00:31:02 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 7E4083F704A;
        Wed,  2 Sep 2020 00:31:02 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 0827V2rW011672;
        Wed, 2 Sep 2020 00:31:02 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 0827V2Ns011671;
        Wed, 2 Sep 2020 00:31:02 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 12/13] qla2xxx: Add SLER and PI control support
Date:   Wed, 2 Sep 2020 00:25:47 -0700
Message-ID: <20200902072548.11491-13-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200902072548.11491-1-njavali@marvell.com>
References: <20200902072548.11491-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

- BIT_13 of extended FW attribute informs about NVMe-2 support.
- Set BIT_15 of specical feature control block for enabling SLER in FW.
- Set bit 8 (SLER supported) to 1 for the service parameter information
  when sending NVMe PRLI request.
- Set BIT_14 of special feature control block for enabling
  PI Control in FW.
- Driver should set bit 9 (PI Control supported) to 1 for the service
  parameter information when sending NVMe PRLI request.
- Set BIT_13 for NVMe Async events.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c  |  2 +-
 drivers/scsi/qla2xxx/qla_def.h  |  4 ++++
 drivers/scsi/qla2xxx/qla_iocb.c |  8 ++++++++
 drivers/scsi/qla2xxx/qla_mbx.c  | 21 +++++++++++++++++++--
 drivers/scsi/qla2xxx/qla_nvme.c | 16 ++++++++++++++--
 drivers/scsi/qla2xxx/qla_nvme.h |  1 +
 drivers/scsi/qla2xxx/qla_os.c   |  1 +
 7 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 1be811a5d69d..369040250ab9 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -16,7 +16,7 @@
  * | Device Discovery             |       0x2134       | 0x210e-0x2116  |
  * |				  | 		       | 0x211a         |
  * |                              |                    | 0x211c-0x2128  |
- * |                              |                    | 0x212a-0x2134  |
+ * |                              |                    | 0x212c-0x2134  |
  * | Queue Command and IO tracing |       0x3074       | 0x300b         |
  * |                              |                    | 0x3027-0x3028  |
  * |                              |                    | 0x303d-0x3041  |
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 863b9c7766e1..19b5c0e3dc99 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2476,6 +2476,8 @@ typedef struct fc_port {
 
 	struct completion nvme_del_done;
 	uint32_t nvme_prli_service_param;
+#define NVME_PRLI_SP_PI_CTRL	BIT_9
+#define NVME_PRLI_SP_SLER	BIT_8
 #define NVME_PRLI_SP_CONF       BIT_7
 #define NVME_PRLI_SP_INITIATOR  BIT_5
 #define NVME_PRLI_SP_TARGET     BIT_4
@@ -4308,6 +4310,7 @@ struct qla_hw_data {
 #define FW_ATTR_EXT0_SCM_BROCADE	0x00001000
 	/* Cisco fabric attached */
 #define FW_ATTR_EXT0_SCM_CISCO		0x00002000
+#define FW_ATTR_EXT0_NVME2	BIT_13
 	uint16_t	fw_attributes_ext[2];
 	uint32_t	fw_memory_size;
 	uint32_t	fw_transfer_size;
@@ -4657,6 +4660,7 @@ typedef struct scsi_qla_host {
 		uint32_t	qpairs_rsp_created:1;
 		uint32_t	nvme_enabled:1;
 		uint32_t        nvme_first_burst:1;
+		uint32_t        nvme2_enabled:1;
 	} flags;
 
 	atomic_t	loop_state;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index b60a332e5846..a46f01a25582 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2378,6 +2378,14 @@ qla24xx_prli_iocb(srb_t *sp, struct logio_entry_24xx *logio)
 		if (sp->vha->flags.nvme_first_burst)
 			logio->io_parameter[0] =
 				cpu_to_le32(NVME_PRLI_SP_FIRST_BURST);
+		if (sp->vha->flags.nvme2_enabled) {
+		/* Set service parameter BIT_8 for SLER support */
+			logio->io_parameter[0] |=
+				cpu_to_le32(NVME_PRLI_SP_SLER);
+		/* Set service parameter BIT_9 for PI control support */
+			logio->io_parameter[0] |=
+				cpu_to_le32(NVME_PRLI_SP_PI_CTRL);
+		}
 	}
 
 	logio->nport_handle = cpu_to_le16(sp->fcport->loop_id);
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index ab7dbbc99c22..e5a47d5147fc 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -1093,6 +1093,17 @@ qla2x00_get_fw_version(scsi_qla_host_t *vha)
 			    "%s: FC-NVMe is Enabled (0x%x)\n",
 			     __func__, ha->fw_attributes_h);
 		}
+
+		/* BIT_13 of Extended FW Attributes informs about NVMe2 support */
+		if (ha->fw_attributes_ext[0] & FW_ATTR_EXT0_NVME2) {
+			ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1191,
+			       "%s: Firmware supports NVMe2 0x%x\n",
+			      __func__, ha->fw_attributes_ext[0]);
+			ql_log(ql_log_info, vha, 0xd302,
+			       "Firmware supports NVMe2 0x%x\n",
+			       ha->fw_attributes_ext[0]);
+			vha->flags.nvme2_enabled = 1;
+		}
 	}
 
 	if (IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
@@ -1122,12 +1133,18 @@ qla2x00_get_fw_version(scsi_qla_host_t *vha)
 		if (ha->flags.scm_supported_a &&
 		    (ha->fw_attributes_ext[0] & FW_ATTR_EXT0_SCM_SUPPORTED)) {
 			ha->flags.scm_supported_f = 1;
-			memset(ha->sf_init_cb, 0, sizeof(struct init_sf_cb));
 			ha->sf_init_cb->flags |= BIT_13;
 		}
 		ql_log(ql_log_info, vha, 0x11a3, "SCM in FW: %s\n",
 		       (ha->flags.scm_supported_f) ? "Supported" :
 		       "Not Supported");
+
+		if (vha->flags.nvme2_enabled) {
+		/* set BIT_15 of special feature control block for SLER */
+			ha->sf_init_cb->flags |= BIT_15;
+		/* set BIT_14 of special feature control block for PI CTRL*/
+			ha->sf_init_cb->flags |= BIT_14;
+		}
 	}
 
 failed:
@@ -1823,7 +1840,7 @@ qla2x00_init_firmware(scsi_qla_host_t *vha, uint16_t size)
 		mcp->out_mb |= MBX_14|MBX_13|MBX_12|MBX_11|MBX_10;
 	}
 
-	if (ha->flags.scm_supported_f) {
+	if (ha->flags.scm_supported_f || vha->flags.nvme2_enabled) {
 		mcp->mb[1] |= BIT_1;
 		mcp->mb[16] = MSW(ha->sf_init_cb_dma);
 		mcp->mb[17] = LSW(ha->sf_init_cb_dma);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 675f2b1180e8..0d73c285a4d1 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -69,6 +69,14 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 		return ret;
 	}
 
+	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_SLER)
+		ql_log(ql_log_info, vha, 0x212a,
+		       "PortID:%06x Supports SLER\n", req.port_id);
+
+	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_PI_CTRL)
+		ql_log(ql_log_info, vha, 0x212b,
+		       "PortID:%06x Supports PI control\n", req.port_id);
+
 	rport = fcport->nvme_remote_port->private;
 	rport->fcport = fcport;
 
@@ -368,6 +376,7 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 	struct srb_iocb *nvme = &sp->u.iocb_cmd;
 	struct scatterlist *sgl, *sg;
 	struct nvmefc_fcp_req *fd = nvme->u.nvme.desc;
+	struct nvme_fc_cmd_iu *cmd = fd->cmdaddr;
 	uint32_t        rval = QLA_SUCCESS;
 
 	/* Setup qpair pointers */
@@ -399,8 +408,6 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 	}
 
 	if (unlikely(!fd->sqid)) {
-		struct nvme_fc_cmd_iu *cmd = fd->cmdaddr;
-
 		if (cmd->sqe.common.opcode == nvme_admin_async_event) {
 			nvme->u.nvme.aen_op = 1;
 			atomic_inc(&ha->nvme_active_aen_cnt);
@@ -446,6 +453,11 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 	} else if (fd->io_dir == 0) {
 		cmd_pkt->control_flags = 0;
 	}
+	/* Set BIT_13 of control flags for Async event */
+	if (vha->flags.nvme2_enabled &&
+	    cmd->sqe.common.opcode == nvme_admin_async_event) {
+		cmd_pkt->control_flags |= cpu_to_le16(CF_ADMIN_ASYNC_EVENT);
+	}
 
 	/* Set NPORT-ID */
 	cmd_pkt->nport_handle = cpu_to_le16(sp->fcport->loop_id);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index cf45a5b277f1..5d5f115a77c3 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -54,6 +54,7 @@ struct cmd_nvme {
 	uint64_t rsvd;
 
 	__le16	control_flags;		/* Control Flags */
+#define CF_ADMIN_ASYNC_EVENT		BIT_13
 #define CF_NVME_FIRST_BURST_ENABLE	BIT_11
 #define CF_DIF_SEG_DESCR_ENABLE         BIT_3
 #define CF_DATA_SEG_DESCR_ENABLE        BIT_2
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index a4d737b92ec1..a186c3a55088 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4231,6 +4231,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 						&ha->sf_init_cb_dma);
 		if (!ha->sf_init_cb)
 			goto fail_sf_init_cb;
+		memset(ha->sf_init_cb, 0, sizeof(struct init_sf_cb));
 		ql_dbg_pci(ql_dbg_init, ha->pdev, 0x0199,
 			   "sf_init_cb=%p.\n", ha->sf_init_cb);
 	}
-- 
2.19.0.rc0

