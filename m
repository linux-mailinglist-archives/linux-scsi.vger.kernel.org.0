Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA712AFC4F
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Nov 2020 02:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgKLBed (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Nov 2020 20:34:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbgKLBEz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Nov 2020 20:04:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC13ML3109236;
        Wed, 11 Nov 2020 20:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jCfgi/mAEnfnmJKbx/no41CiUC7PjNzKLwM93Vd1kPc=;
 b=g92Hni8wHmKeXcr8DPbR83f9MgwNeBifn7TZgqTAtd6gm6tie/Dl0d3U2uveY86N2TG1
 MpFmiMmZ6wFt1CUQCh8VpXJ6GJOUyRazTCKdHcNYIPKkLHDdw1+UNmvCYh393go2hnjD
 +slnN1tEO/9hyXrtB+KxF6h+5lnOiL6UPQot1QlkmHZe8vFJwfBIXpsy+TezbmC7a3EV
 fwRKszn7mKl26pYe8Q/EEp5JisqJyVUzFOy3z/eQdWp/NRP54v+3wXl4rbUsRfg6ulOQ
 NLcsK8SeTHY6nutNEbv0HauPDUgtxWIPZh3XcXYwq4Sc1WVAZkftSXBRWmawzPFvr8Jg 9A== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34rcxf96db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 20:04:47 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC0vTHH020721;
        Thu, 12 Nov 2020 01:04:46 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 34nk79y5sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 01:04:46 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AC14khM17367654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 01:04:46 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DB12805C;
        Thu, 12 Nov 2020 01:04:45 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B47F2805A;
        Thu, 12 Nov 2020 01:04:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.188])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 01:04:45 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 3/6] ibmvfc: add new fields for version 2 of several MADs
Date:   Wed, 11 Nov 2020 19:04:39 -0600
Message-Id: <20201112010442.102589-3-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201112010442.102589-1-tyreld@linux.ibm.com>
References: <20201112010442.102589-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_12:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 clxscore=1015
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120002
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce a targetWWPN field to several MADs. Its possible that a scsi
ID of a target can change due to some fabric changes. The WWPN of the
scsi target provides a better way to identify the target. Also, add
flags for receiving MAD versioning information and advertising client
support for targetWWPN with the VIOS. This latter capability flag will
be required for future clients capable of requesting multiple hardware
queues from the host adapter.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 58 ++++++++++++++++++----------------
 drivers/scsi/ibmvscsi/ibmvfc.h | 28 +++++++++++++---
 2 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 7b25789dba9a..aa3445bec42c 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -149,6 +149,7 @@ static void ibmvfc_trc_start(struct ibmvfc_event *evt)
 	struct ibmvfc_host *vhost = evt->vhost;
 	struct ibmvfc_cmd *vfc_cmd = &evt->iu.cmd;
 	struct ibmvfc_mad_common *mad = &evt->iu.mad_common;
+	struct ibmvfc_fcp_cmd_iu *iu = &vfc_cmd->v1.iu;
 	struct ibmvfc_trace_entry *entry;
 
 	entry = &vhost->trace[vhost->trace_index++];
@@ -159,11 +160,11 @@ static void ibmvfc_trc_start(struct ibmvfc_event *evt)
 
 	switch (entry->fmt) {
 	case IBMVFC_CMD_FORMAT:
-		entry->op_code = vfc_cmd->iu.cdb[0];
+		entry->op_code = iu->cdb[0];
 		entry->scsi_id = be64_to_cpu(vfc_cmd->tgt_scsi_id);
-		entry->lun = scsilun_to_int(&vfc_cmd->iu.lun);
-		entry->tmf_flags = vfc_cmd->iu.tmf_flags;
-		entry->u.start.xfer_len = be32_to_cpu(vfc_cmd->iu.xfer_len);
+		entry->lun = scsilun_to_int(&iu->lun);
+		entry->tmf_flags = iu->tmf_flags;
+		entry->u.start.xfer_len = be32_to_cpu(iu->xfer_len);
 		break;
 	case IBMVFC_MAD_FORMAT:
 		entry->op_code = be32_to_cpu(mad->opcode);
@@ -183,6 +184,8 @@ static void ibmvfc_trc_end(struct ibmvfc_event *evt)
 	struct ibmvfc_host *vhost = evt->vhost;
 	struct ibmvfc_cmd *vfc_cmd = &evt->xfer_iu->cmd;
 	struct ibmvfc_mad_common *mad = &evt->xfer_iu->mad_common;
+	struct ibmvfc_fcp_cmd_iu *iu = &vfc_cmd->v1.iu;
+	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
 	struct ibmvfc_trace_entry *entry = &vhost->trace[vhost->trace_index++];
 
 	entry->evt = evt;
@@ -192,15 +195,15 @@ static void ibmvfc_trc_end(struct ibmvfc_event *evt)
 
 	switch (entry->fmt) {
 	case IBMVFC_CMD_FORMAT:
-		entry->op_code = vfc_cmd->iu.cdb[0];
+		entry->op_code = iu->cdb[0];
 		entry->scsi_id = be64_to_cpu(vfc_cmd->tgt_scsi_id);
-		entry->lun = scsilun_to_int(&vfc_cmd->iu.lun);
-		entry->tmf_flags = vfc_cmd->iu.tmf_flags;
+		entry->lun = scsilun_to_int(&iu->lun);
+		entry->tmf_flags = iu->tmf_flags;
 		entry->u.end.status = be16_to_cpu(vfc_cmd->status);
 		entry->u.end.error = be16_to_cpu(vfc_cmd->error);
-		entry->u.end.fcp_rsp_flags = vfc_cmd->rsp.flags;
-		entry->u.end.rsp_code = vfc_cmd->rsp.data.info.rsp_code;
-		entry->u.end.scsi_status = vfc_cmd->rsp.scsi_status;
+		entry->u.end.fcp_rsp_flags = rsp->flags;
+		entry->u.end.rsp_code = rsp->data.info.rsp_code;
+		entry->u.end.scsi_status = rsp->scsi_status;
 		break;
 	case IBMVFC_MAD_FORMAT:
 		entry->op_code = be32_to_cpu(mad->opcode);
@@ -263,7 +266,7 @@ static const char *ibmvfc_get_cmd_error(u16 status, u16 error)
 static int ibmvfc_get_err_result(struct ibmvfc_cmd *vfc_cmd)
 {
 	int err;
-	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->rsp;
+	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
 	int fc_rsp_len = be32_to_cpu(rsp->fcp_rsp_len);
 
 	if ((rsp->flags & FCP_RSP_LEN_VALID) &&
@@ -1378,6 +1381,7 @@ static int ibmvfc_map_sg_data(struct scsi_cmnd *scmd,
 	int sg_mapped;
 	struct srp_direct_buf *data = &vfc_cmd->ioba;
 	struct ibmvfc_host *vhost = dev_get_drvdata(dev);
+	struct ibmvfc_fcp_cmd_iu *iu = &vfc_cmd->v1.iu;
 
 	if (cls3_error)
 		vfc_cmd->flags |= cpu_to_be16(IBMVFC_CLASS_3_ERR);
@@ -1394,10 +1398,10 @@ static int ibmvfc_map_sg_data(struct scsi_cmnd *scmd,
 
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		vfc_cmd->flags |= cpu_to_be16(IBMVFC_WRITE);
-		vfc_cmd->iu.add_cdb_len |= IBMVFC_WRDATA;
+		iu->add_cdb_len |= IBMVFC_WRDATA;
 	} else {
 		vfc_cmd->flags |= cpu_to_be16(IBMVFC_READ);
-		vfc_cmd->iu.add_cdb_len |= IBMVFC_RDDATA;
+		iu->add_cdb_len |= IBMVFC_RDDATA;
 	}
 
 	if (sg_mapped == 1) {
@@ -1516,7 +1520,7 @@ static void ibmvfc_log_error(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_cmd *vfc_cmd = &evt->xfer_iu->cmd;
 	struct ibmvfc_host *vhost = evt->vhost;
-	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->rsp;
+	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
 	struct scsi_cmnd *cmnd = evt->cmnd;
 	const char *err = unknown_error;
 	int index = ibmvfc_get_err_index(be16_to_cpu(vfc_cmd->status), be16_to_cpu(vfc_cmd->error));
@@ -1570,7 +1574,7 @@ static void ibmvfc_relogin(struct scsi_device *sdev)
 static void ibmvfc_scsi_done(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_cmd *vfc_cmd = &evt->xfer_iu->cmd;
-	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->rsp;
+	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
 	struct scsi_cmnd *cmnd = evt->cmnd;
 	u32 rsp_len = 0;
 	u32 sense_len = be32_to_cpu(rsp->fcp_sense_len);
@@ -1652,14 +1656,14 @@ static struct ibmvfc_cmd *ibmvfc_init_vfc_cmd(struct ibmvfc_event *evt, struct s
 	struct ibmvfc_cmd *vfc_cmd = &evt->iu.cmd;
 
 	memset(vfc_cmd, 0, sizeof(*vfc_cmd));
-	vfc_cmd->resp.va = cpu_to_be64(be64_to_cpu(evt->crq.ioba) + offsetof(struct ibmvfc_cmd, rsp));
-	vfc_cmd->resp.len = cpu_to_be32(sizeof(vfc_cmd->rsp));
+	vfc_cmd->resp.va = cpu_to_be64(be64_to_cpu(evt->crq.ioba) + offsetof(struct ibmvfc_cmd, v1.rsp));
+	vfc_cmd->resp.len = cpu_to_be32(sizeof(vfc_cmd->v1.rsp));
 	vfc_cmd->frame_type = cpu_to_be32(IBMVFC_SCSI_FCP_TYPE);
-	vfc_cmd->payload_len = cpu_to_be32(sizeof(vfc_cmd->iu));
-	vfc_cmd->resp_len = cpu_to_be32(sizeof(vfc_cmd->rsp));
+	vfc_cmd->payload_len = cpu_to_be32(sizeof(vfc_cmd->v1.iu));
+	vfc_cmd->resp_len = cpu_to_be32(sizeof(vfc_cmd->v1.rsp));
 	vfc_cmd->cancel_key = cpu_to_be32((unsigned long)sdev->hostdata);
 	vfc_cmd->tgt_scsi_id = cpu_to_be64(rport->port_id);
-	int_to_scsilun(sdev->lun, &vfc_cmd->iu.lun);
+	int_to_scsilun(sdev->lun, &vfc_cmd->v1.iu.lun);
 
 	return vfc_cmd;
 }
@@ -1696,12 +1700,12 @@ static int ibmvfc_queuecommand_lck(struct scsi_cmnd *cmnd,
 
 	vfc_cmd = ibmvfc_init_vfc_cmd(evt, cmnd->device);
 
-	vfc_cmd->iu.xfer_len = cpu_to_be32(scsi_bufflen(cmnd));
-	memcpy(vfc_cmd->iu.cdb, cmnd->cmnd, cmnd->cmd_len);
+	vfc_cmd->v1.iu.xfer_len = cpu_to_be32(scsi_bufflen(cmnd));
+	memcpy(vfc_cmd->v1.iu.cdb, cmnd->cmnd, cmnd->cmd_len);
 
 	if (cmnd->flags & SCMD_TAGGED) {
 		vfc_cmd->task_tag = cpu_to_be64(cmnd->tag);
-		vfc_cmd->iu.pri_task_attr = IBMVFC_SIMPLE_TASK;
+		vfc_cmd->v1.iu.pri_task_attr = IBMVFC_SIMPLE_TASK;
 	}
 
 	if (likely(!(rc = ibmvfc_map_sg_data(cmnd, evt, vfc_cmd, vhost->dev))))
@@ -2026,7 +2030,7 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 	struct ibmvfc_cmd *tmf;
 	struct ibmvfc_event *evt = NULL;
 	union ibmvfc_iu rsp_iu;
-	struct ibmvfc_fcp_rsp *fc_rsp = &rsp_iu.cmd.rsp;
+	struct ibmvfc_fcp_rsp *fc_rsp = &rsp_iu.cmd.v1.rsp;
 	int rsp_rc = -EBUSY;
 	unsigned long flags;
 	int rsp_code = 0;
@@ -2038,7 +2042,7 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
 
 		tmf->flags = cpu_to_be16((IBMVFC_NO_MEM_DESC | IBMVFC_TMF));
-		tmf->iu.tmf_flags = type;
+		tmf->v1.iu.tmf_flags = type;
 		evt->sync_iu = &rsp_iu;
 
 		init_completion(&evt->comp);
@@ -2331,7 +2335,7 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 	struct ibmvfc_cmd *tmf;
 	struct ibmvfc_event *evt, *found_evt;
 	union ibmvfc_iu rsp_iu;
-	struct ibmvfc_fcp_rsp *fc_rsp = &rsp_iu.cmd.rsp;
+	struct ibmvfc_fcp_rsp *fc_rsp = &rsp_iu.cmd.v1.rsp;
 	int rc, rsp_rc = -EBUSY;
 	unsigned long flags, timeout = IBMVFC_ABORT_TIMEOUT;
 	int rsp_code = 0;
@@ -2358,7 +2362,7 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
 
 		tmf->flags = cpu_to_be16((IBMVFC_NO_MEM_DESC | IBMVFC_TMF));
-		tmf->iu.tmf_flags = IBMVFC_ABORT_TASK_SET;
+		tmf->v1.iu.tmf_flags = IBMVFC_ABORT_TASK_SET;
 		evt->sync_iu = &rsp_iu;
 
 		init_completion(&evt->comp);
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 34debccfb142..65092812bd4a 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -54,6 +54,7 @@
 
 #define IBMVFC_MAD_SUCCESS		0x00
 #define IBMVFC_MAD_NOT_SUPPORTED	0xF1
+#define IBMVFC_MAD_VERSION_NOT_SUPP	0xF2
 #define IBMVFC_MAD_FAILED		0xF7
 #define IBMVFC_MAD_DRIVER_FAILED	0xEE
 #define IBMVFC_MAD_CRQ_ERROR		0xEF
@@ -168,6 +169,8 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_CAN_MIGRATE		0x01
 #define IBMVFC_CAN_USE_CHANNELS		0x02
 #define IBMVFC_CAN_HANDLE_FPIN		0x04
+#define IBMVFC_CAN_USE_MAD_VERSION	0x08
+#define IBMVFC_CAN_SEND_VF_WWPN		0x10
 	__be64 node_name;
 	struct srp_direct_buf async;
 	u8 partition_name[IBMVFC_MAX_NAME];
@@ -211,7 +214,9 @@ struct ibmvfc_npiv_login_resp {
 	__be64 capabilities;
 #define IBMVFC_CAN_FLUSH_ON_HALT	0x08
 #define IBMVFC_CAN_SUPPRESS_ABTS	0x10
-#define IBMVFC_CAN_SUPPORT_CHANNELS	0x20
+#define IBMVFC_MAD_VERSION_CAP		0x20
+#define IBMVFC_HANDLE_VF_WWPN		0x40
+#define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
 	__be64 max_dma_len;
@@ -293,6 +298,7 @@ struct ibmvfc_port_login {
 	__be32 reserved2;
 	struct ibmvfc_service_parms service_parms;
 	struct ibmvfc_service_parms service_parms_change;
+	__be64 targetWWPN;
 	__be64 reserved3[2];
 } __packed __aligned(8);
 
@@ -344,6 +350,7 @@ struct ibmvfc_process_login {
 	__be16 status;
 	__be16 error;			/* also fc_reason */
 	__be32 reserved2;
+	__be64 targetWWPN;
 	__be64 reserved3[2];
 } __packed __aligned(8);
 
@@ -378,6 +385,8 @@ struct ibmvfc_tmf {
 	__be32 cancel_key;
 	__be32 my_cancel_key;
 	__be32 pad;
+	__be64 targetWWPN;
+	__be64 taskTag;
 	__be64 reserved[2];
 } __packed __aligned(8);
 
@@ -474,9 +483,19 @@ struct ibmvfc_cmd {
 	__be64 correlation;
 	__be64 tgt_scsi_id;
 	__be64 tag;
-	__be64 reserved3[2];
-	struct ibmvfc_fcp_cmd_iu iu;
-	struct ibmvfc_fcp_rsp rsp;
+	__be64 targetWWPN;
+	__be64 reserved3;
+	union {
+		struct {
+			struct ibmvfc_fcp_cmd_iu iu;
+			struct ibmvfc_fcp_rsp rsp;
+		} v1;
+		struct {
+			__be64 reserved4;
+			struct ibmvfc_fcp_cmd_iu iu;
+			struct ibmvfc_fcp_rsp rsp;
+		} v2;
+	};
 } __packed __aligned(8);
 
 struct ibmvfc_passthru_fc_iu {
@@ -503,6 +522,7 @@ struct ibmvfc_passthru_iu {
 	__be64 correlation;
 	__be64 scsi_id;
 	__be64 tag;
+	__be64 targetWWPN;
 	__be64 reserved2[2];
 } __packed __aligned(8);
 
-- 
2.27.0

