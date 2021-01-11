Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222852F0F2D
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Jan 2021 10:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbhAKJdI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jan 2021 04:33:08 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39272 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728381AbhAKJdH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 Jan 2021 04:33:07 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10B9VGsF011584
        for <linux-scsi@vger.kernel.org>; Mon, 11 Jan 2021 01:32:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=SN478qXhjG8O0B14S0ypWWVOAwMa77kFs3HpdggNQWc=;
 b=FOCn47dvlcm1z5IMdRpo/um7glUVxPBwMI8fpBNMQLTgV35rHWYxQh7dNNdjJWauhXRO
 G9FTMA9/qA2M/DQN0gtu5tvZbxY6J2RNdDuXDbRVMSYRrBuIBOcnUQ8n1IVJFI3P2gPi
 W+SL+ioB24VcXt2oHNuqfHirVtzDfvFkiZSklusuL9b4aRvLWuV520knKPj+zzLFDRcm
 5oDzdXWd7f6gDZie0ATlWzIDHLW7X0tdDUGHAPFZJxInT1ezwfa6McjsCrkN8BmjlCbK
 sE8EDQ9dTSrfk31i45Sa4+KW5Co/DRFiFt4bhGPizaZGQ5LJAL4ypaqdhhJ9ct0eMRd8 pg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35yaqskrwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 11 Jan 2021 01:32:24 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 11 Jan
 2021 01:32:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 01:32:22 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 77A453F703F;
        Mon, 11 Jan 2021 01:32:22 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 10B9WMpL001255;
        Mon, 11 Jan 2021 01:32:22 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 10B9WMmN001254;
        Mon, 11 Jan 2021 01:32:22 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v4 1/7] qla2xxx: Implementation to get and manage host, target stats and initiator port
Date:   Mon, 11 Jan 2021 01:31:28 -0800
Message-ID: <20210111093134.1206-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210111093134.1206-1-njavali@marvell.com>
References: <20210111093134.1206-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-09_13:2021-01-07,2021-01-09 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

This statistics will help in debugging process and checking specific
error counts. It also provides a capability to isolate the port or bring it
out of isolation.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/scsi/qla2xxx/qla_attr.c |   9 +
 drivers/scsi/qla2xxx/qla_bsg.c  | 342 ++++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_bsg.h  |   5 +
 drivers/scsi/qla2xxx/qla_def.h  |  71 +++++++
 drivers/scsi/qla2xxx/qla_gbl.h  |  23 +++
 drivers/scsi/qla2xxx/qla_gs.c   |   1 +
 drivers/scsi/qla2xxx/qla_init.c | 216 ++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_isr.c  |  22 ++
 drivers/scsi/qla2xxx/qla_mbx.c  |   9 +
 drivers/scsi/qla2xxx/qla_os.c   |  20 ++
 10 files changed, 718 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index ab45ac1e5a72..63391c9be05d 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -710,6 +710,12 @@ qla2x00_sysfs_write_reset(struct file *filp, struct kobject *kobj,
 		ql_log(ql_log_info, vha, 0x706e,
 		    "Issuing ISP reset.\n");
 
+		if (vha->hw->flags.port_isolated) {
+			ql_log(ql_log_info, vha, 0x706e,
+			       "Port is isolated, returning.\n");
+			return -EINVAL;
+		}
+
 		scsi_block_requests(vha->host);
 		if (IS_QLA82XX(ha)) {
 			ha->flags.isp82xx_no_md_cap = 1;
@@ -2717,6 +2723,9 @@ qla2x00_issue_lip(struct Scsi_Host *shost)
 	if (IS_QLAFX00(vha->hw))
 		return 0;
 
+	if (vha->hw->flags.port_isolated)
+		return 0;
+
 	qla2x00_loop_reset(vha);
 	return 0;
 }
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 23b604832a54..e45da05383cd 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -4,6 +4,7 @@
  * Copyright (c)  2003-2014 QLogic Corporation
  */
 #include "qla_def.h"
+#include "qla_gbl.h"
 
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
@@ -2444,6 +2445,323 @@ qla2x00_get_flash_image_status(struct bsg_job *bsg_job)
 	return 0;
 }
 
+static int
+qla2x00_manage_host_stats(struct bsg_job *bsg_job)
+{
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct ql_vnd_mng_host_stats_param *req_data;
+	struct ql_vnd_mng_host_stats_resp rsp_data;
+	u32 req_data_len;
+	int ret = 0;
+
+	if (!vha->flags.online) {
+		ql_log(ql_log_warn, vha, 0x0000, "Host is not online.\n");
+		return -EIO;
+	}
+
+	req_data_len = bsg_job->request_payload.payload_len;
+
+	if (req_data_len != sizeof(struct ql_vnd_mng_host_stats_param)) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data_len invalid.\n");
+		return -EIO;
+	}
+
+	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
+	if (!req_data) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data memory allocation failure.\n");
+		return -ENOMEM;
+	}
+
+	/* Copy the request buffer in req_data */
+	sg_copy_to_buffer(bsg_job->request_payload.sg_list,
+			  bsg_job->request_payload.sg_cnt, req_data,
+			  req_data_len);
+
+	switch (req_data->action) {
+	case QLA_STOP:
+		ret = qla2xxx_stop_stats(vha->host, req_data->stat_type);
+		break;
+	case QLA_START:
+		ret = qla2xxx_start_stats(vha->host, req_data->stat_type);
+		break;
+	case QLA_CLEAR:
+		ret = qla2xxx_reset_stats(vha->host, req_data->stat_type);
+		break;
+	default:
+		ql_log(ql_log_warn, vha, 0x0000, "Invalid action.\n");
+		ret = -EIO;
+		break;
+	}
+
+	kfree(req_data);
+
+	/* Prepare response */
+	rsp_data.status = ret;
+	bsg_job->reply_payload.payload_len = sizeof(struct ql_vnd_mng_host_stats_resp);
+
+	bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_OK;
+	bsg_reply->reply_payload_rcv_len =
+		sg_copy_from_buffer(bsg_job->reply_payload.sg_list,
+				    bsg_job->reply_payload.sg_cnt,
+				    &rsp_data,
+				    sizeof(struct ql_vnd_mng_host_stats_resp));
+
+	bsg_reply->result = DID_OK;
+	bsg_job_done(bsg_job, bsg_reply->result,
+		     bsg_reply->reply_payload_rcv_len);
+
+	return ret;
+}
+
+static int
+qla2x00_get_host_stats(struct bsg_job *bsg_job)
+{
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct ql_vnd_stats_param *req_data;
+	struct ql_vnd_host_stats_resp rsp_data;
+	u32 req_data_len;
+	int ret = 0;
+	u64 ini_entry_count = 0;
+	u64 entry_count = 0;
+	u64 tgt_num = 0;
+	u64 tmp_stat_type = 0;
+	u64 response_len = 0;
+	void *data;
+
+	req_data_len = bsg_job->request_payload.payload_len;
+
+	if (req_data_len != sizeof(struct ql_vnd_stats_param)) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data_len invalid.\n");
+		return -EIO;
+	}
+
+	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
+	if (!req_data) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data memory allocation failure.\n");
+		return -ENOMEM;
+	}
+
+	/* Copy the request buffer in req_data */
+	sg_copy_to_buffer(bsg_job->request_payload.sg_list,
+			  bsg_job->request_payload.sg_cnt, req_data, req_data_len);
+
+	/* Copy stat type to work on it */
+	tmp_stat_type = req_data->stat_type;
+
+	if (tmp_stat_type & QLA2XX_TGT_SHT_LNK_DOWN) {
+		/* Num of tgts connected to this host */
+		tgt_num = qla2x00_get_num_tgts(vha);
+		/* unset BIT_17 */
+		tmp_stat_type &= ~(1 << 17);
+	}
+
+	/* Total ini stats */
+	ini_entry_count = qla2x00_count_set_bits(tmp_stat_type);
+
+	/* Total number of entries */
+	entry_count = ini_entry_count + tgt_num;
+
+	response_len = sizeof(struct ql_vnd_host_stats_resp) +
+		(sizeof(struct ql_vnd_stat_entry) * entry_count);
+
+	if (response_len > bsg_job->reply_payload.payload_len) {
+		rsp_data.status = EXT_STATUS_BUFFER_TOO_SMALL;
+		bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_BUFFER_TOO_SMALL;
+		bsg_job->reply_payload.payload_len = sizeof(struct ql_vnd_mng_host_stats_resp);
+
+		bsg_reply->reply_payload_rcv_len =
+			sg_copy_from_buffer(bsg_job->reply_payload.sg_list,
+					    bsg_job->reply_payload.sg_cnt, &rsp_data,
+					    sizeof(struct ql_vnd_mng_host_stats_resp));
+
+		bsg_reply->result = DID_OK;
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
+		goto host_stat_out;
+	}
+
+	data = kzalloc(response_len, GFP_KERNEL);
+
+	ret = qla2xxx_get_ini_stats(fc_bsg_to_shost(bsg_job), req_data->stat_type,
+				    data, response_len);
+
+	rsp_data.status = EXT_STATUS_OK;
+	bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_OK;
+
+	bsg_reply->reply_payload_rcv_len = sg_copy_from_buffer(bsg_job->reply_payload.sg_list,
+							       bsg_job->reply_payload.sg_cnt,
+							       data, response_len);
+	bsg_reply->result = DID_OK;
+	bsg_job_done(bsg_job, bsg_reply->result,
+		     bsg_reply->reply_payload_rcv_len);
+
+	kfree(data);
+host_stat_out:
+	kfree(req_data);
+	return ret;
+}
+
+static struct fc_rport *
+qla2xxx_find_rport(scsi_qla_host_t *vha, uint32_t tgt_num)
+{
+	fc_port_t *fcport = NULL;
+
+	list_for_each_entry(fcport, &vha->vp_fcports, list) {
+		if (fcport->rport->number == tgt_num)
+			return fcport->rport;
+	}
+	return NULL;
+}
+
+static int
+qla2x00_get_tgt_stats(struct bsg_job *bsg_job)
+{
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct ql_vnd_tgt_stats_param *req_data;
+	u32 req_data_len;
+	int ret = 0;
+	u64 response_len = 0;
+	struct ql_vnd_tgt_stats_resp *data = NULL;
+	struct fc_rport *rport = NULL;
+
+	if (!vha->flags.online) {
+		ql_log(ql_log_warn, vha, 0x0000, "Host is not online.\n");
+		return -EIO;
+	}
+
+	req_data_len = bsg_job->request_payload.payload_len;
+
+	if (req_data_len != sizeof(struct ql_vnd_stat_entry)) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data_len invalid.\n");
+		return -EIO;
+	}
+
+	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
+	if (!req_data) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data memory allocation failure.\n");
+		return -ENOMEM;
+	}
+
+	/* Copy the request buffer in req_data */
+	sg_copy_to_buffer(bsg_job->request_payload.sg_list,
+			  bsg_job->request_payload.sg_cnt,
+			  req_data, req_data_len);
+
+	response_len = sizeof(struct ql_vnd_tgt_stats_resp) +
+		sizeof(struct ql_vnd_stat_entry);
+
+	/* structure + size for one entry */
+	data = kzalloc(response_len, GFP_KERNEL);
+	if (!data) {
+		kfree(req_data);
+		return -ENOMEM;
+	}
+
+	if (response_len > bsg_job->reply_payload.payload_len) {
+		data->status = EXT_STATUS_BUFFER_TOO_SMALL;
+		bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_BUFFER_TOO_SMALL;
+		bsg_job->reply_payload.payload_len = sizeof(struct ql_vnd_mng_host_stats_resp);
+
+		bsg_reply->reply_payload_rcv_len =
+			sg_copy_from_buffer(bsg_job->reply_payload.sg_list,
+					    bsg_job->reply_payload.sg_cnt, &data,
+					    sizeof(struct ql_vnd_tgt_stats_resp));
+
+		bsg_reply->result = DID_OK;
+		bsg_job_done(bsg_job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
+		goto tgt_stat_out;
+	}
+
+	rport = qla2xxx_find_rport(vha, req_data->tgt_id);
+	if (!rport) {
+		ql_log(ql_log_warn, vha, 0x0000, "target %d not found.\n", req_data->tgt_id);
+		ret = EXT_STATUS_INVALID_PARAM;
+		data->status = EXT_STATUS_INVALID_PARAM;
+		goto reply;
+	}
+
+	ret = qla2xxx_get_tgt_stats(fc_bsg_to_shost(bsg_job), req_data->stat_type,
+				    rport, (void *)data, response_len);
+
+	bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_OK;
+reply:
+	bsg_reply->reply_payload_rcv_len =
+		sg_copy_from_buffer(bsg_job->reply_payload.sg_list,
+				    bsg_job->reply_payload.sg_cnt, data,
+				    response_len);
+	bsg_reply->result = DID_OK;
+	bsg_job_done(bsg_job, bsg_reply->result,
+		     bsg_reply->reply_payload_rcv_len);
+
+tgt_stat_out:
+	kfree(data);
+	kfree(req_data);
+
+	return ret;
+}
+
+static int
+qla2x00_manage_host_port(struct bsg_job *bsg_job)
+{
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct ql_vnd_mng_host_port_param *req_data;
+	struct ql_vnd_mng_host_port_resp rsp_data;
+	u32 req_data_len;
+	int ret = 0;
+
+	req_data_len = bsg_job->request_payload.payload_len;
+
+	if (req_data_len != sizeof(struct ql_vnd_mng_host_port_param)) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data_len invalid.\n");
+		return -EIO;
+	}
+
+	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
+	if (!req_data) {
+		ql_log(ql_log_warn, vha, 0x0000, "req_data memory allocation failure.\n");
+		return -ENOMEM;
+	}
+
+	/* Copy the request buffer in req_data */
+	sg_copy_to_buffer(bsg_job->request_payload.sg_list,
+			  bsg_job->request_payload.sg_cnt, req_data, req_data_len);
+
+	switch (req_data->action) {
+	case QLA_ENABLE:
+		ret = qla2xxx_enable_port(vha->host);
+		break;
+	case QLA_DISABLE:
+		ret = qla2xxx_disable_port(vha->host);
+		break;
+	default:
+		ql_log(ql_log_warn, vha, 0x0000, "Invalid action.\n");
+		ret = -EIO;
+		break;
+	}
+
+	kfree(req_data);
+
+	/* Prepare response */
+	rsp_data.status = ret;
+	bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_OK;
+	bsg_job->reply_payload.payload_len = sizeof(struct ql_vnd_mng_host_port_resp);
+
+	bsg_reply->reply_payload_rcv_len =
+		sg_copy_from_buffer(bsg_job->reply_payload.sg_list,
+				    bsg_job->reply_payload.sg_cnt, &rsp_data,
+				    sizeof(struct ql_vnd_mng_host_port_resp));
+	bsg_reply->result = DID_OK;
+	bsg_job_done(bsg_job, bsg_reply->result,
+		     bsg_reply->reply_payload_rcv_len);
+
+	return ret;
+}
+
 static int
 qla2x00_process_vendor_specific(struct bsg_job *bsg_job)
 {
@@ -2520,6 +2838,18 @@ qla2x00_process_vendor_specific(struct bsg_job *bsg_job)
 	case QL_VND_SS_GET_FLASH_IMAGE_STATUS:
 		return qla2x00_get_flash_image_status(bsg_job);
 
+	case QL_VND_MANAGE_HOST_STATS:
+		return qla2x00_manage_host_stats(bsg_job);
+
+	case QL_VND_GET_HOST_STATS:
+		return qla2x00_get_host_stats(bsg_job);
+
+	case QL_VND_GET_TGT_STATS:
+		return qla2x00_get_tgt_stats(bsg_job);
+
+	case QL_VND_MANAGE_HOST_PORT:
+		return qla2x00_manage_host_port(bsg_job);
+
 	default:
 		return -ENOSYS;
 	}
@@ -2547,6 +2877,17 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 		vha = shost_priv(host);
 	}
 
+	/* Disable port will bring down the chip, allow enable command */
+	if (bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_MANAGE_HOST_PORT ||
+	    bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_GET_HOST_STATS)
+		goto skip_chip_chk;
+
+	if (vha->hw->flags.port_isolated) {
+		bsg_reply->result = DID_ERROR;
+		/* operation not permitted */
+		return -EPERM;
+	}
+
 	if (qla2x00_chip_is_down(vha)) {
 		ql_dbg(ql_dbg_user, vha, 0x709f,
 		    "BSG: ISP abort active/needed -- cmd=%d.\n",
@@ -2554,6 +2895,7 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 		return -EBUSY;
 	}
 
+skip_chip_chk:
 	ql_dbg(ql_dbg_user, vha, 0x7000,
 	    "Entered %s msgcode=0x%x.\n", __func__, bsg_request->msgcode);
 
diff --git a/drivers/scsi/qla2xxx/qla_bsg.h b/drivers/scsi/qla2xxx/qla_bsg.h
index 1a09b5512267..0274e99e4a12 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.h
+++ b/drivers/scsi/qla2xxx/qla_bsg.h
@@ -31,6 +31,10 @@
 #define QL_VND_DPORT_DIAGNOSTICS	0x19
 #define QL_VND_GET_PRIV_STATS_EX	0x1A
 #define QL_VND_SS_GET_FLASH_IMAGE_STATUS	0x1E
+#define QL_VND_MANAGE_HOST_STATS	0x23
+#define QL_VND_GET_HOST_STATS		0x24
+#define QL_VND_GET_TGT_STATS		0x25
+#define QL_VND_MANAGE_HOST_PORT		0x26
 
 /* BSG Vendor specific subcode returns */
 #define EXT_STATUS_OK			0
@@ -40,6 +44,7 @@
 #define EXT_STATUS_DATA_OVERRUN		7
 #define EXT_STATUS_DATA_UNDERRUN	8
 #define EXT_STATUS_MAILBOX		11
+#define EXT_STATUS_BUFFER_TOO_SMALL	16
 #define EXT_STATUS_NO_MEMORY		17
 #define EXT_STATUS_DEVICE_OFFLINE	22
 
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 30c7e5e63851..ca67be8b62ec 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2557,6 +2557,10 @@ typedef struct fc_port {
 	u16 n2n_chip_reset;
 
 	struct dentry *dfs_rport_dir;
+
+	u64 tgt_short_link_down_cnt;
+	u64 tgt_link_down_time;
+	u64 dev_loss_tmo;
 } fc_port_t;
 
 enum {
@@ -3922,6 +3926,7 @@ struct qla_hw_data {
 		uint32_t	scm_enabled:1;
 		uint32_t	max_req_queue_warned:1;
 		uint32_t	plogi_template_valid:1;
+		uint32_t	port_isolated:1;
 	} flags;
 
 	uint16_t max_exchg;
@@ -4851,6 +4856,13 @@ typedef struct scsi_qla_host {
 	uint8_t	scm_fabric_connection_flags;
 
 	unsigned int irq_offset;
+
+	u64 hw_err_cnt;
+	u64 interface_err_cnt;
+	u64 cmd_timeout_cnt;
+	u64 reset_cmd_err_cnt;
+	u64 link_down_time;
+	u64 short_link_down_cnt;
 } scsi_qla_host_t;
 
 struct qla27xx_image_status {
@@ -5174,6 +5186,65 @@ struct sff_8247_a0 {
 #define PRLI_PHASE(_cls) \
 	((_cls == DSC_LS_PRLI_PEND) || (_cls == DSC_LS_PRLI_COMP))
 
+enum ql_vnd_host_stat_action {
+	QLA_STOP = 0,
+	QLA_START,
+	QLA_CLEAR,
+};
+
+struct ql_vnd_mng_host_stats_param {
+	u32 stat_type;
+	enum ql_vnd_host_stat_action action;
+} __packed;
+
+struct ql_vnd_mng_host_stats_resp {
+	u32 status;
+} __packed;
+
+struct ql_vnd_stats_param {
+	u32 stat_type;
+} __packed;
+
+struct ql_vnd_tgt_stats_param {
+	s32 tgt_id;
+	u32 stat_type;
+} __packed;
+
+enum ql_vnd_host_port_action {
+	QLA_ENABLE = 0,
+	QLA_DISABLE,
+};
+
+struct ql_vnd_mng_host_port_param {
+	enum ql_vnd_host_port_action action;
+} __packed;
+
+struct ql_vnd_mng_host_port_resp {
+	u32 status;
+} __packed;
+
+struct ql_vnd_stat_entry {
+	u32 stat_type;	/* Failure type */
+	u32 tgt_num;	/* Target Num */
+	u64 cnt;	/* Counter value */
+} __packed;
+
+struct ql_vnd_stats {
+	u64 entry_count; /* Num of entries */
+	u64 rservd;
+	struct ql_vnd_stat_entry entry[0]; /* Place holder of entries */
+} __packed;
+
+struct ql_vnd_host_stats_resp {
+	u32 status;
+	struct ql_vnd_stats stats;
+} __packed;
+
+struct ql_vnd_tgt_stats_resp {
+	u32 status;
+	struct ql_vnd_stats stats;
+} __packed;
+
 #include "qla_target.h"
 #include "qla_gbl.h"
 #include "qla_dbg.h"
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index e39b4f2da73a..708f82311b83 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -945,4 +945,27 @@ extern void qla2x00_dfs_remove_rport(scsi_qla_host_t *vha, struct fc_port *fp);
 /* nvme.c */
 void qla_nvme_unregister_remote_port(struct fc_port *fcport);
 void qla_handle_els_plogi_done(scsi_qla_host_t *vha, struct event_arg *ea);
+
+#define QLA2XX_HW_ERROR			BIT_0
+#define QLA2XX_SHT_LNK_DWN		BIT_1
+#define QLA2XX_INT_ERR			BIT_2
+#define QLA2XX_CMD_TIMEOUT		BIT_3
+#define QLA2XX_RESET_CMD_ERR		BIT_4
+#define QLA2XX_TGT_SHT_LNK_DOWN		BIT_17
+
+#define QLA2XX_MAX_LINK_DOWN_TIME	100
+
+int qla2xxx_start_stats(struct Scsi_Host *shost, u32 flags);
+int qla2xxx_stop_stats(struct Scsi_Host *shost, u32 flags);
+int qla2xxx_reset_stats(struct Scsi_Host *shost, u32 flags);
+
+int qla2xxx_get_ini_stats(struct Scsi_Host *shost, u32 flags, void *data, u64 size);
+int qla2xxx_get_tgt_stats(struct Scsi_Host *shost, u32 flags,
+			  struct fc_rport *rport, void *data, u64 size);
+int qla2xxx_disable_port(struct Scsi_Host *shost);
+int qla2xxx_enable_port(struct Scsi_Host *shost);
+
+uint64_t qla2x00_get_num_tgts(scsi_qla_host_t *vha);
+uint64_t qla2x00_count_set_bits(u32 num);
+
 #endif /* _QLA_GBL_H */
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 391ac75e3de3..517d358b0031 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3563,6 +3563,7 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 					       __func__, __LINE__,
 					       fcport->port_name);
 
+					fcport->tgt_link_down_time = 0;
 					qlt_schedule_sess_for_deletion(fcport);
 					continue;
 				}
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index dcc0f0d823db..410ff5534a59 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4993,6 +4993,9 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	fcport->login_retry = vha->hw->login_retry_count;
 	fcport->chip_reset = vha->hw->base_qpair->chip_reset;
 	fcport->logout_on_delete = 1;
+	fcport->tgt_link_down_time = QLA2XX_MAX_LINK_DOWN_TIME;
+	fcport->tgt_short_link_down_cnt = 0;
+	fcport->dev_loss_tmo = 0;
 
 	if (!fcport->ct_desc.ct_sns) {
 		ql_log(ql_log_warn, vha, 0xd049,
@@ -5490,6 +5493,7 @@ qla2x00_reg_remote_port(scsi_qla_host_t *vha, fc_port_t *fcport)
 	spin_lock_irqsave(fcport->vha->host->host_lock, flags);
 	*((fc_port_t **)rport->dd_data) = fcport;
 	spin_unlock_irqrestore(fcport->vha->host->host_lock, flags);
+	fcport->dev_loss_tmo = rport->dev_loss_tmo;
 
 	rport->supported_classes = fcport->supported_classes;
 
@@ -5548,6 +5552,11 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 		fcport->logout_on_delete = 1;
 	fcport->n2n_chip_reset = fcport->n2n_link_reset_cnt = 0;
 
+	if (fcport->tgt_link_down_time < fcport->dev_loss_tmo) {
+		fcport->tgt_short_link_down_cnt++;
+		fcport->tgt_link_down_time = QLA2XX_MAX_LINK_DOWN_TIME;
+	}
+
 	switch (vha->hw->current_topology) {
 	case ISP_CFG_N:
 	case ISP_CFG_NL:
@@ -6908,6 +6917,9 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 	if (vha->flags.online) {
 		qla2x00_abort_isp_cleanup(vha);
 
+		if (vha->hw->flags.port_isolated)
+			return status;
+
 		if (test_and_clear_bit(ISP_ABORT_TO_ROM, &vha->dpc_flags)) {
 			ha->flags.chip_reset_done = 1;
 			vha->flags.online = 1;
@@ -7029,6 +7041,11 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 
 	}
 
+	if (vha->hw->flags.port_isolated) {
+		qla2x00_abort_isp_cleanup(vha);
+		return status;
+	}
+
 	if (!status) {
 		ql_dbg(ql_dbg_taskm, vha, 0x8022, "%s succeeded.\n", __func__);
 		qla2x00_configure_hba(vha);
@@ -9171,3 +9188,202 @@ int qla2xxx_delete_qpair(struct scsi_qla_host *vha, struct qla_qpair *qpair)
 fail:
 	return ret;
 }
+
+uint64_t
+qla2x00_count_set_bits(uint32_t num)
+{
+	/* Brian Kernighan's Alogorithm */
+	u64 count = 0;
+
+	while (num) {
+		num &= (num - 1);
+		count++;
+	}
+	return count;
+}
+
+uint64_t
+qla2x00_get_num_tgts(scsi_qla_host_t *vha)
+{
+	fc_port_t *f, *tf;
+	u64 count = 0;
+
+	f = NULL;
+	tf = NULL;
+
+	list_for_each_entry_safe(f, tf, &vha->vp_fcports, list) {
+		if (f->port_type != FCT_TARGET)
+			continue;
+		count++;
+	}
+	return count;
+}
+
+int qla2xxx_reset_stats(struct Scsi_Host *host, u32 flags)
+{
+	scsi_qla_host_t *vha = shost_priv(host);
+	fc_port_t *fcport = NULL;
+	unsigned long int_flags;
+
+	if (flags & QLA2XX_HW_ERROR)
+		vha->hw_err_cnt = 0;
+	if (flags & QLA2XX_SHT_LNK_DWN)
+		vha->short_link_down_cnt = 0;
+	if (flags & QLA2XX_INT_ERR)
+		vha->interface_err_cnt = 0;
+	if (flags & QLA2XX_CMD_TIMEOUT)
+		vha->cmd_timeout_cnt = 0;
+	if (flags & QLA2XX_RESET_CMD_ERR)
+		vha->reset_cmd_err_cnt = 0;
+	if (flags & QLA2XX_TGT_SHT_LNK_DOWN) {
+		spin_lock_irqsave(&vha->hw->tgt.sess_lock, int_flags);
+		list_for_each_entry(fcport, &vha->vp_fcports, list) {
+			fcport->tgt_short_link_down_cnt = 0;
+			fcport->tgt_link_down_time = QLA2XX_MAX_LINK_DOWN_TIME;
+		}
+		spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, int_flags);
+	}
+	vha->link_down_time = QLA2XX_MAX_LINK_DOWN_TIME;
+	return 0;
+}
+
+int qla2xxx_start_stats(struct Scsi_Host *host, u32 flags)
+{
+	return qla2xxx_reset_stats(host, flags);
+}
+
+int qla2xxx_stop_stats(struct Scsi_Host *host, u32 flags)
+{
+	return qla2xxx_reset_stats(host, flags);
+}
+
+int qla2xxx_get_ini_stats(struct Scsi_Host *host, u32 flags,
+			  void *data, u64 size)
+{
+	scsi_qla_host_t *vha = shost_priv(host);
+	struct ql_vnd_host_stats_resp *resp = (struct ql_vnd_host_stats_resp *)data;
+	struct ql_vnd_stats *rsp_data = &resp->stats;
+	u64 ini_entry_count = 0;
+	u64 i = 0;
+	u64 entry_count = 0;
+	u64 num_tgt = 0;
+	u32 tmp_stat_type = 0;
+	fc_port_t *fcport = NULL;
+	unsigned long int_flags;
+
+	/* Copy stat type to work on it */
+	tmp_stat_type = flags;
+
+	if (tmp_stat_type & BIT_17) {
+		num_tgt = qla2x00_get_num_tgts(vha);
+		/* unset BIT_17 */
+		tmp_stat_type &= ~(1 << 17);
+	}
+	ini_entry_count = qla2x00_count_set_bits(tmp_stat_type);
+
+	entry_count = ini_entry_count + num_tgt;
+
+	rsp_data->entry_count = entry_count;
+
+	i = 0;
+	if (flags & QLA2XX_HW_ERROR) {
+		rsp_data->entry[i].stat_type = QLA2XX_HW_ERROR;
+		rsp_data->entry[i].tgt_num = 0x0;
+		rsp_data->entry[i].cnt = vha->hw_err_cnt;
+		i++;
+	}
+
+	if (flags & QLA2XX_SHT_LNK_DWN) {
+		rsp_data->entry[i].stat_type = QLA2XX_SHT_LNK_DWN;
+		rsp_data->entry[i].tgt_num = 0x0;
+		rsp_data->entry[i].cnt = vha->short_link_down_cnt;
+		i++;
+	}
+
+	if (flags & QLA2XX_INT_ERR) {
+		rsp_data->entry[i].stat_type = QLA2XX_INT_ERR;
+		rsp_data->entry[i].tgt_num = 0x0;
+		rsp_data->entry[i].cnt = vha->interface_err_cnt;
+		i++;
+	}
+
+	if (flags & QLA2XX_CMD_TIMEOUT) {
+		rsp_data->entry[i].stat_type = QLA2XX_CMD_TIMEOUT;
+		rsp_data->entry[i].tgt_num = 0x0;
+		rsp_data->entry[i].cnt = vha->cmd_timeout_cnt;
+		i++;
+	}
+
+	if (flags & QLA2XX_RESET_CMD_ERR) {
+		rsp_data->entry[i].stat_type = QLA2XX_RESET_CMD_ERR;
+		rsp_data->entry[i].tgt_num = 0x0;
+		rsp_data->entry[i].cnt = vha->reset_cmd_err_cnt;
+		i++;
+	}
+
+	/* i will continue from previous loop, as target
+	 * entries are after initiator
+	 */
+	if (flags & QLA2XX_TGT_SHT_LNK_DOWN) {
+		spin_lock_irqsave(&vha->hw->tgt.sess_lock, int_flags);
+		list_for_each_entry(fcport, &vha->vp_fcports, list) {
+			if (fcport->port_type != FCT_TARGET)
+				continue;
+			if (!fcport->rport)
+				continue;
+			rsp_data->entry[i].stat_type = QLA2XX_TGT_SHT_LNK_DOWN;
+			rsp_data->entry[i].tgt_num = fcport->rport->number;
+			rsp_data->entry[i].cnt = fcport->tgt_short_link_down_cnt;
+			i++;
+		}
+		spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, int_flags);
+	}
+	resp->status = EXT_STATUS_OK;
+
+	return 0;
+}
+
+int qla2xxx_get_tgt_stats(struct Scsi_Host *host, u32 flags,
+			  struct fc_rport *rport, void *data, u64 size)
+{
+	struct ql_vnd_tgt_stats_resp *tgt_data = data;
+	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+
+	tgt_data->status = 0;
+	tgt_data->stats.entry_count = 1;
+	tgt_data->stats.entry[0].stat_type = flags;
+	tgt_data->stats.entry[0].tgt_num = rport->number;
+	tgt_data->stats.entry[0].cnt = fcport->tgt_short_link_down_cnt;
+
+	return 0;
+}
+
+int qla2xxx_disable_port(struct Scsi_Host *host)
+{
+	scsi_qla_host_t *vha = shost_priv(host);
+
+	vha->hw->flags.port_isolated = 1;
+
+	if (qla2x00_chip_is_down(vha))
+		return 0;
+
+	if (vha->flags.online) {
+		qla2x00_abort_isp_cleanup(vha);
+		qla2x00_wait_for_sess_deletion(vha);
+	}
+
+	return 0;
+}
+
+int qla2xxx_enable_port(struct Scsi_Host *host)
+{
+	scsi_qla_host_t *vha = shost_priv(host);
+
+	vha->hw->flags.port_isolated = 0;
+	/* Set the flag to 1, so that isp_abort can proceed */
+	vha->flags.online = 1;
+	set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+	qla2xxx_wake_dpc(vha);
+
+	return 0;
+}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index f9142dbec112..9cf8326ab9fc 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1059,6 +1059,9 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 
 	case MBA_SYSTEM_ERR:		/* System Error */
 		mbx = 0;
+
+		vha->hw_err_cnt++;
+
 		if (IS_QLA81XX(ha) || IS_QLA83XX(ha) ||
 		    IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
 			u16 m[4];
@@ -1112,6 +1115,8 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		ql_log(ql_log_warn, vha, 0x5006,
 		    "ISP Request Transfer Error (%x).\n",  mb[1]);
 
+		vha->hw_err_cnt++;
+
 		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 		break;
 
@@ -1119,6 +1124,8 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		ql_log(ql_log_warn, vha, 0x5007,
 		    "ISP Response Transfer Error (%x).\n", mb[1]);
 
+		vha->hw_err_cnt++;
+
 		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 		break;
 
@@ -1176,12 +1183,18 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		vha->flags.management_server_logged_in = 0;
 		qla2x00_post_aen_work(vha, FCH_EVT_LINKUP, ha->link_data_rate);
 
+		if (vha->link_down_time < vha->hw->port_down_retry_count) {
+			vha->short_link_down_cnt++;
+			vha->link_down_time = QLA2XX_MAX_LINK_DOWN_TIME;
+		}
+
 		break;
 
 	case MBA_LOOP_DOWN:		/* Loop Down Event */
 		SAVE_TOPO(ha);
 		ha->flags.lip_ae = 0;
 		ha->current_topology = 0;
+		vha->link_down_time = 0;
 
 		mbx = (IS_QLA81XX(ha) || IS_QLA8031(ha))
 			? rd_reg_word(&reg24->mailbox4) : 0;
@@ -1503,6 +1516,7 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		ql_dbg(ql_dbg_async, vha, 0x5016,
 		    "Discard RND Frame -- %04x %04x %04x.\n",
 		    mb[1], mb[2], mb[3]);
+		vha->interface_err_cnt++;
 		break;
 
 	case MBA_TRACE_NOTIFICATION:
@@ -1592,6 +1606,7 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 
 	case MBA_IDC_AEN:
 		if (IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
+			vha->hw_err_cnt++;
 			qla27xx_handle_8200_aen(vha, mb);
 		} else if (IS_QLA83XX(ha)) {
 			mb[4] = rd_reg_word(&reg24->mailbox4);
@@ -3101,6 +3116,8 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 				    "Dropped frame(s) detected (0x%x of 0x%x bytes).\n",
 				    resid, scsi_bufflen(cp));
 
+				vha->interface_err_cnt++;
+
 				res = DID_ERROR << 16 | lscsi_status;
 				goto check_scsi_status;
 			}
@@ -3126,6 +3143,8 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 			    "Dropped frame(s) detected (0x%x of 0x%x bytes).\n",
 			    resid, scsi_bufflen(cp));
 
+			vha->interface_err_cnt++;
+
 			res = DID_ERROR << 16 | lscsi_status;
 			goto check_scsi_status;
 		} else {
@@ -3208,6 +3227,7 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 
 	case CS_TRANSPORT:
 		res = DID_ERROR << 16;
+		vha->hw_err_cnt++;
 
 		if (!IS_PI_SPLIT_DET_CAPABLE(ha))
 			break;
@@ -3228,6 +3248,7 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 		ql_dump_buffer(ql_dbg_tgt + ql_dbg_verbose, vha, 0xe0ee,
 		    pkt, sizeof(*sts24));
 		res = DID_ERROR << 16;
+		vha->hw_err_cnt++;
 		break;
 	default:
 		res = DID_ERROR << 16;
@@ -3839,6 +3860,7 @@ qla24xx_msix_default(int irq, void *dev_id)
 			    hccr);
 
 			qla2xxx_check_risc_status(vha);
+			vha->hw_err_cnt++;
 
 			ha->isp_ops->fw_dump(vha);
 			set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index d7d4ab65009c..f438cdedca23 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -180,6 +180,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 		ql_log(ql_log_warn, vha, 0xd035,
 		    "Cmd access timeout, cmd=0x%x, Exiting.\n",
 		    mcp->mb[0]);
+		vha->hw_err_cnt++;
 		atomic_dec(&ha->num_pend_mbx_stage1);
 		return QLA_FUNCTION_TIMEOUT;
 	}
@@ -307,6 +308,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				atomic_dec(&ha->num_pend_mbx_stage2);
 				ql_dbg(ql_dbg_mbx, vha, 0x1012,
 				    "Pending mailbox timeout, exiting.\n");
+				vha->hw_err_cnt++;
 				rval = QLA_FUNCTION_TIMEOUT;
 				goto premature_exit;
 			}
@@ -418,6 +420,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			    "mb[0-3]=[0x%x 0x%x 0x%x 0x%x] mb7 0x%x host_status 0x%x hccr 0x%x\n",
 			    command, ictrl, jiffies, mb[0], mb[1], mb[2], mb[3],
 			    mb[7], host_status, hccr);
+			vha->hw_err_cnt++;
 
 		} else {
 			mb[0] = RD_MAILBOX_REG(ha, &reg->isp, 0);
@@ -425,6 +428,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			ql_dbg(ql_dbg_mbx + ql_dbg_buffer, vha, 0x1119,
 			    "MBX Command timeout for cmd %x, iocontrol=%x jiffies=%lx "
 			    "mb[0]=0x%x\n", command, ictrl, jiffies, mb[0]);
+			vha->hw_err_cnt++;
 		}
 		ql_dump_regs(ql_dbg_mbx + ql_dbg_buffer, vha, 0x1019);
 
@@ -497,6 +501,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				    "mb[0]=0x%x, eeh_busy=0x%x. Scheduling ISP "
 				    "abort.\n", command, mcp->mb[0],
 				    ha->flags.eeh_busy);
+				vha->hw_err_cnt++;
 				set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 				qla2xxx_wake_dpc(vha);
 			}
@@ -521,6 +526,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				    "Mailbox cmd timeout occurred, cmd=0x%x, "
 				    "mb[0]=0x%x. Scheduling ISP abort ",
 				    command, mcp->mb[0]);
+				vha->hw_err_cnt++;
 				set_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags);
 				clear_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 				/* Allow next mbx cmd to come in. */
@@ -625,6 +631,7 @@ qla2x00_load_ram(scsi_qla_host_t *vha, dma_addr_t req_dma, uint32_t risc_addr,
 		ql_dbg(ql_dbg_mbx, vha, 0x1023,
 		    "Failed=%x mb[0]=%x mb[1]=%x.\n",
 		    rval, mcp->mb[0], mcp->mb[1]);
+		vha->hw_err_cnt++;
 	} else {
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1024,
 		    "Done %s.\n", __func__);
@@ -736,6 +743,7 @@ qla2x00_execute_fw(scsi_qla_host_t *vha, uint32_t risc_addr)
 
 		ql_dbg(ql_dbg_mbx, vha, 0x1026,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
+		vha->hw_err_cnt++;
 		return rval;
 	}
 
@@ -1313,6 +1321,7 @@ qla2x00_mbx_reg_test(scsi_qla_host_t *vha)
 	if (rval != QLA_SUCCESS) {
 		/*EMPTY*/
 		ql_dbg(ql_dbg_mbx, vha, 0x1033, "Failed=%x.\n", rval);
+		vha->hw_err_cnt++;
 	} else {
 		/*EMPTY*/
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1034,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index f80abe28f35a..a760cb38e487 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1274,6 +1274,8 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	sp = scsi_cmd_priv(cmd);
 	qpair = sp->qpair;
 
+	vha->cmd_timeout_cnt++;
+
 	if ((sp->fcport && sp->fcport->deleted) || !qpair)
 		return SUCCESS;
 
@@ -1442,6 +1444,7 @@ __qla2xxx_eh_generic_reset(char *name, enum nexus_wait_type type,
 	    "%s RESET FAILED: %s nexus=%ld:%d:%llu cmd=%p.\n", name,
 	    reset_errors[err], vha->host_no, cmd->device->id, cmd->device->lun,
 	    cmd);
+	vha->reset_cmd_err_cnt++;
 	return FAILED;
 }
 
@@ -3141,6 +3144,10 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	ha->mr.fcport.supported_classes = FC_COS_UNSPECIFIED;
 	ha->mr.fcport.scan_state = 1;
 
+	qla2xxx_reset_stats(host, QLA2XX_HW_ERROR | QLA2XX_SHT_LNK_DWN |
+			    QLA2XX_INT_ERR | QLA2XX_CMD_TIMEOUT |
+			    QLA2XX_RESET_CMD_ERR | QLA2XX_TGT_SHT_LNK_DOWN);
+
 	/* Set the SG table size based on ISP type */
 	if (!IS_FWI2_CAPABLE(ha)) {
 		if (IS_QLA2100(ha))
@@ -5090,6 +5097,7 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 			fcport->d_id = e->u.new_sess.id;
 			fcport->flags |= FCF_FABRIC_DEVICE;
 			fcport->fw_login_state = DSC_LS_PLOGI_PEND;
+			fcport->tgt_short_link_down_cnt = 0;
 
 			memcpy(fcport->port_name, e->u.new_sess.port_name,
 			    WWN_SIZE);
@@ -7061,6 +7069,8 @@ qla2x00_timer(struct timer_list *t)
 	uint16_t        w;
 	struct qla_hw_data *ha = vha->hw;
 	struct req_que *req;
+	unsigned long flags;
+	fc_port_t *fcport = NULL;
 
 	if (ha->flags.eeh_busy) {
 		ql_dbg(ql_dbg_timer, vha, 0x6000,
@@ -7092,6 +7102,16 @@ qla2x00_timer(struct timer_list *t)
 	if (!vha->vp_idx && IS_QLAFX00(ha))
 		qlafx00_timer_routine(vha);
 
+	if (vha->link_down_time < QLA2XX_MAX_LINK_DOWN_TIME)
+		vha->link_down_time++;
+
+	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
+	list_for_each_entry(fcport, &vha->vp_fcports, list) {
+		if (fcport->tgt_link_down_time < QLA2XX_MAX_LINK_DOWN_TIME)
+			fcport->tgt_link_down_time++;
+	}
+	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+
 	/* Loop down handler. */
 	if (atomic_read(&vha->loop_down_timer) > 0 &&
 	    !(test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags)) &&
-- 
2.19.0.rc0

