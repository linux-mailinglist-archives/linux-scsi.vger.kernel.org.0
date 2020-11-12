Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FF2AFC4E
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Nov 2020 02:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgKLBec (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Nov 2020 20:34:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbgKLBEz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Nov 2020 20:04:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC13Mxm109252;
        Wed, 11 Nov 2020 20:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aLJFfNoUry9zcXQtKgiM05OczT4S5aiWbmxnT3Uk0ck=;
 b=QAzb6npDp42CojJ6ZTSdQ1YO/OSVaVI0YAvOcM2aSE7QpRxgCQGPMhorTVuKEkcHlAKf
 gmKkiAiRO5iJjrwxHevpJHPycODN5xJcVIAV4sfXHlL3e7wBhu/cXExEQcTnnFdjB5uR
 rVJKh9isC1wdQ8dUbDIFeF0gtJ2+c45linnwppmAc8JjP31Hq5qi4UJOkk1edRvP/pum
 /qvlCRaStnKrQSrdm86ckWQ92oxlCRRcsxcyRcQMWBIxT0zqc+MqDm7pW35/oNzYmx7S
 k9VRMTtZGGW9OyPeDT1ctX9feBQWuQQztmhQ2KrjpPDxaEQlJ06wuZ1kLxIGOhZHD9pd Ww== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34rcxf96dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 20:04:48 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC0w7gx020204;
        Thu, 12 Nov 2020 01:04:47 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 34nk7af54s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 01:04:47 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AC14kiD17367662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 01:04:46 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8331A28058;
        Thu, 12 Nov 2020 01:04:46 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5A72805E;
        Thu, 12 Nov 2020 01:04:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.188])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 01:04:45 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 4/6] ibmvfc: add FC payload retrieval routines for versioned vfcFrames
Date:   Wed, 11 Nov 2020 19:04:40 -0600
Message-Id: <20201112010442.102589-4-tyreld@linux.ibm.com>
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

The FC iu and response payloads are located at different offsets
depending on the ibmvfc_cmd version. This is a result of the version 2
vfcFrame definition adding an extra 64bytes of reserved space to the
structure prior to the payloads.

Add helper routines to determine the current vfcFrame version and
returning pointers to the proper iu or response structures within that
ibmvfc_cmd.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 76 ++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index aa3445bec42c..5e666f7c9266 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -138,6 +138,22 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *);
 
 static const char *unknown_error = "unknown error";
 
+static struct ibmvfc_fcp_cmd_iu *ibmvfc_get_fcp_iu(struct ibmvfc_host *vhost, struct ibmvfc_cmd *vfc_cmd)
+{
+	if (be64_to_cpu(vhost->login_buf->resp.capabilities) & IBMVFC_HANDLE_VF_WWPN)
+		return &vfc_cmd->v2.iu;
+	else
+		return &vfc_cmd->v1.iu;
+}
+
+static struct ibmvfc_fcp_rsp *ibmvfc_get_fcp_rsp(struct ibmvfc_host *vhost, struct ibmvfc_cmd *vfc_cmd)
+{
+	if (be64_to_cpu(vhost->login_buf->resp.capabilities) & IBMVFC_HANDLE_VF_WWPN)
+		return &vfc_cmd->v2.rsp;
+	else
+		return &vfc_cmd->v1.rsp;
+}
+
 #ifdef CONFIG_SCSI_IBMVFC_TRACE
 /**
  * ibmvfc_trc_start - Log a start trace entry
@@ -149,7 +165,7 @@ static void ibmvfc_trc_start(struct ibmvfc_event *evt)
 	struct ibmvfc_host *vhost = evt->vhost;
 	struct ibmvfc_cmd *vfc_cmd = &evt->iu.cmd;
 	struct ibmvfc_mad_common *mad = &evt->iu.mad_common;
-	struct ibmvfc_fcp_cmd_iu *iu = &vfc_cmd->v1.iu;
+	struct ibmvfc_fcp_cmd_iu *iu = ibmvfc_get_fcp_iu(vhost, vfc_cmd);
 	struct ibmvfc_trace_entry *entry;
 
 	entry = &vhost->trace[vhost->trace_index++];
@@ -184,8 +200,8 @@ static void ibmvfc_trc_end(struct ibmvfc_event *evt)
 	struct ibmvfc_host *vhost = evt->vhost;
 	struct ibmvfc_cmd *vfc_cmd = &evt->xfer_iu->cmd;
 	struct ibmvfc_mad_common *mad = &evt->xfer_iu->mad_common;
-	struct ibmvfc_fcp_cmd_iu *iu = &vfc_cmd->v1.iu;
-	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
+	struct ibmvfc_fcp_cmd_iu *iu = ibmvfc_get_fcp_iu(vhost, vfc_cmd);
+	struct ibmvfc_fcp_rsp *rsp = ibmvfc_get_fcp_rsp(vhost, vfc_cmd);
 	struct ibmvfc_trace_entry *entry = &vhost->trace[vhost->trace_index++];
 
 	entry->evt = evt;
@@ -263,10 +279,10 @@ static const char *ibmvfc_get_cmd_error(u16 status, u16 error)
  * Return value:
  *	SCSI result value to return for completed command
  **/
-static int ibmvfc_get_err_result(struct ibmvfc_cmd *vfc_cmd)
+static int ibmvfc_get_err_result(struct ibmvfc_host *vhost, struct ibmvfc_cmd *vfc_cmd)
 {
 	int err;
-	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
+	struct ibmvfc_fcp_rsp *rsp = ibmvfc_get_fcp_rsp(vhost, vfc_cmd);
 	int fc_rsp_len = be32_to_cpu(rsp->fcp_rsp_len);
 
 	if ((rsp->flags & FCP_RSP_LEN_VALID) &&
@@ -1381,7 +1397,7 @@ static int ibmvfc_map_sg_data(struct scsi_cmnd *scmd,
 	int sg_mapped;
 	struct srp_direct_buf *data = &vfc_cmd->ioba;
 	struct ibmvfc_host *vhost = dev_get_drvdata(dev);
-	struct ibmvfc_fcp_cmd_iu *iu = &vfc_cmd->v1.iu;
+	struct ibmvfc_fcp_cmd_iu *iu = ibmvfc_get_fcp_iu(evt->vhost, vfc_cmd);
 
 	if (cls3_error)
 		vfc_cmd->flags |= cpu_to_be16(IBMVFC_CLASS_3_ERR);
@@ -1520,7 +1536,7 @@ static void ibmvfc_log_error(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_cmd *vfc_cmd = &evt->xfer_iu->cmd;
 	struct ibmvfc_host *vhost = evt->vhost;
-	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
+	struct ibmvfc_fcp_rsp *rsp = ibmvfc_get_fcp_rsp(vhost, vfc_cmd);
 	struct scsi_cmnd *cmnd = evt->cmnd;
 	const char *err = unknown_error;
 	int index = ibmvfc_get_err_index(be16_to_cpu(vfc_cmd->status), be16_to_cpu(vfc_cmd->error));
@@ -1574,7 +1590,7 @@ static void ibmvfc_relogin(struct scsi_device *sdev)
 static void ibmvfc_scsi_done(struct ibmvfc_event *evt)
 {
 	struct ibmvfc_cmd *vfc_cmd = &evt->xfer_iu->cmd;
-	struct ibmvfc_fcp_rsp *rsp = &vfc_cmd->v1.rsp;
+	struct ibmvfc_fcp_rsp *rsp = ibmvfc_get_fcp_rsp(evt->vhost, vfc_cmd);
 	struct scsi_cmnd *cmnd = evt->cmnd;
 	u32 rsp_len = 0;
 	u32 sense_len = be32_to_cpu(rsp->fcp_sense_len);
@@ -1588,7 +1604,7 @@ static void ibmvfc_scsi_done(struct ibmvfc_event *evt)
 			scsi_set_resid(cmnd, 0);
 
 		if (vfc_cmd->status) {
-			cmnd->result = ibmvfc_get_err_result(vfc_cmd);
+			cmnd->result = ibmvfc_get_err_result(evt->vhost, vfc_cmd);
 
 			if (rsp->flags & FCP_RSP_LEN_VALID)
 				rsp_len = be32_to_cpu(rsp->fcp_rsp_len);
@@ -1653,17 +1669,25 @@ static inline int ibmvfc_host_chkready(struct ibmvfc_host *vhost)
 static struct ibmvfc_cmd *ibmvfc_init_vfc_cmd(struct ibmvfc_event *evt, struct scsi_device *sdev)
 {
 	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
+	struct ibmvfc_host *vhost = evt->vhost;
 	struct ibmvfc_cmd *vfc_cmd = &evt->iu.cmd;
+	struct ibmvfc_fcp_cmd_iu *iu = ibmvfc_get_fcp_iu(vhost, vfc_cmd);
+	struct ibmvfc_fcp_rsp *rsp = ibmvfc_get_fcp_rsp(vhost, vfc_cmd);
+	size_t offset;
 
 	memset(vfc_cmd, 0, sizeof(*vfc_cmd));
-	vfc_cmd->resp.va = cpu_to_be64(be64_to_cpu(evt->crq.ioba) + offsetof(struct ibmvfc_cmd, v1.rsp));
-	vfc_cmd->resp.len = cpu_to_be32(sizeof(vfc_cmd->v1.rsp));
+	if (be64_to_cpu(vhost->login_buf->resp.capabilities) & IBMVFC_HANDLE_VF_WWPN)
+		offset = offsetof(struct ibmvfc_cmd, v2.rsp);
+	else
+		offset = offsetof(struct ibmvfc_cmd, v1.rsp);
+	vfc_cmd->resp.va = cpu_to_be64(be64_to_cpu(evt->crq.ioba) + offset);
+	vfc_cmd->resp.len = cpu_to_be32(sizeof(*rsp));
 	vfc_cmd->frame_type = cpu_to_be32(IBMVFC_SCSI_FCP_TYPE);
-	vfc_cmd->payload_len = cpu_to_be32(sizeof(vfc_cmd->v1.iu));
-	vfc_cmd->resp_len = cpu_to_be32(sizeof(vfc_cmd->v1.rsp));
+	vfc_cmd->payload_len = cpu_to_be32(sizeof(*iu));
+	vfc_cmd->resp_len = cpu_to_be32(sizeof(*rsp));
 	vfc_cmd->cancel_key = cpu_to_be32((unsigned long)sdev->hostdata);
 	vfc_cmd->tgt_scsi_id = cpu_to_be64(rport->port_id);
-	int_to_scsilun(sdev->lun, &vfc_cmd->v1.iu.lun);
+	int_to_scsilun(sdev->lun, &iu->lun);
 
 	return vfc_cmd;
 }
@@ -1682,6 +1706,7 @@ static int ibmvfc_queuecommand_lck(struct scsi_cmnd *cmnd,
 	struct ibmvfc_host *vhost = shost_priv(cmnd->device->host);
 	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
 	struct ibmvfc_cmd *vfc_cmd;
+	struct ibmvfc_fcp_cmd_iu *iu;
 	struct ibmvfc_event *evt;
 	int rc;
 
@@ -1699,13 +1724,14 @@ static int ibmvfc_queuecommand_lck(struct scsi_cmnd *cmnd,
 	cmnd->scsi_done = done;
 
 	vfc_cmd = ibmvfc_init_vfc_cmd(evt, cmnd->device);
+	iu = ibmvfc_get_fcp_iu(vhost, vfc_cmd);
 
-	vfc_cmd->v1.iu.xfer_len = cpu_to_be32(scsi_bufflen(cmnd));
-	memcpy(vfc_cmd->v1.iu.cdb, cmnd->cmnd, cmnd->cmd_len);
+	iu->xfer_len = cpu_to_be32(scsi_bufflen(cmnd));
+	memcpy(iu->cdb, cmnd->cmnd, cmnd->cmd_len);
 
 	if (cmnd->flags & SCMD_TAGGED) {
 		vfc_cmd->task_tag = cpu_to_be64(cmnd->tag);
-		vfc_cmd->v1.iu.pri_task_attr = IBMVFC_SIMPLE_TASK;
+		iu->pri_task_attr = IBMVFC_SIMPLE_TASK;
 	}
 
 	if (likely(!(rc = ibmvfc_map_sg_data(cmnd, evt, vfc_cmd, vhost->dev))))
@@ -2030,7 +2056,8 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 	struct ibmvfc_cmd *tmf;
 	struct ibmvfc_event *evt = NULL;
 	union ibmvfc_iu rsp_iu;
-	struct ibmvfc_fcp_rsp *fc_rsp = &rsp_iu.cmd.v1.rsp;
+	struct ibmvfc_fcp_cmd_iu *iu;
+	struct ibmvfc_fcp_rsp *fc_rsp = ibmvfc_get_fcp_rsp(vhost, &rsp_iu.cmd);
 	int rsp_rc = -EBUSY;
 	unsigned long flags;
 	int rsp_code = 0;
@@ -2040,9 +2067,10 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 		evt = ibmvfc_get_event(vhost);
 		ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_CMD_FORMAT);
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
+		iu = ibmvfc_get_fcp_iu(vhost, tmf);
 
 		tmf->flags = cpu_to_be16((IBMVFC_NO_MEM_DESC | IBMVFC_TMF));
-		tmf->v1.iu.tmf_flags = type;
+		iu->tmf_flags = type;
 		evt->sync_iu = &rsp_iu;
 
 		init_completion(&evt->comp);
@@ -2060,7 +2088,7 @@ static int ibmvfc_reset_device(struct scsi_device *sdev, int type, char *desc)
 	wait_for_completion(&evt->comp);
 
 	if (rsp_iu.cmd.status)
-		rsp_code = ibmvfc_get_err_result(&rsp_iu.cmd);
+		rsp_code = ibmvfc_get_err_result(vhost, &rsp_iu.cmd);
 
 	if (rsp_code) {
 		if (fc_rsp->flags & FCP_RSP_LEN_VALID)
@@ -2335,7 +2363,8 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 	struct ibmvfc_cmd *tmf;
 	struct ibmvfc_event *evt, *found_evt;
 	union ibmvfc_iu rsp_iu;
-	struct ibmvfc_fcp_rsp *fc_rsp = &rsp_iu.cmd.v1.rsp;
+	struct ibmvfc_fcp_cmd_iu *iu;
+	struct ibmvfc_fcp_rsp *fc_rsp = ibmvfc_get_fcp_rsp(vhost, &rsp_iu.cmd);
 	int rc, rsp_rc = -EBUSY;
 	unsigned long flags, timeout = IBMVFC_ABORT_TIMEOUT;
 	int rsp_code = 0;
@@ -2360,9 +2389,10 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 		evt = ibmvfc_get_event(vhost);
 		ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_CMD_FORMAT);
 		tmf = ibmvfc_init_vfc_cmd(evt, sdev);
+		iu = ibmvfc_get_fcp_iu(vhost, tmf);
 
+		iu->tmf_flags = IBMVFC_ABORT_TASK_SET;
 		tmf->flags = cpu_to_be16((IBMVFC_NO_MEM_DESC | IBMVFC_TMF));
-		tmf->v1.iu.tmf_flags = IBMVFC_ABORT_TASK_SET;
 		evt->sync_iu = &rsp_iu;
 
 		init_completion(&evt->comp);
@@ -2409,7 +2439,7 @@ static int ibmvfc_abort_task_set(struct scsi_device *sdev)
 	}
 
 	if (rsp_iu.cmd.status)
-		rsp_code = ibmvfc_get_err_result(&rsp_iu.cmd);
+		rsp_code = ibmvfc_get_err_result(vhost, &rsp_iu.cmd);
 
 	if (rsp_code) {
 		if (fc_rsp->flags & FCP_RSP_LEN_VALID)
-- 
2.27.0

