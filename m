Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9327A718
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Sep 2020 07:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1Fvi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 28 Sep 2020 01:51:38 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14668 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725308AbgI1Fvi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 28 Sep 2020 01:51:38 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S5oNhA007630
        for <linux-scsi@vger.kernel.org>; Sun, 27 Sep 2020 22:51:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=mUTNefO6/5PAK2O15B9S8IX30qKCFZOKiU0yQTzyDls=;
 b=JxDQefdEmGA2H2xJ3HfklU0TeA+eKiJY/nWS9uMRVTMUKvXjEWO1NOrq1RhcopkbFzwe
 c02c0rRUx9UYgFRZ45WTQmYZaiw666/0ztef9/VTymBzAj7JWiF3RfGQ8CS+nY/tX+2F
 XgFKKykbVVa9IvwgP/UiGEAFAfCGSjaUJanObBXU75g+C5U/mzgwwFONtN/8Xgb7YqEA
 sBBmpZ450UFfViIV2QXWsworjVAC1JNOL1wpolwhyc3CYT7Y2q7GO/oS8PfKxhJxSHbE
 MJiqe8JDys8c/H44SR4mLRKbIPmr6jZB96zg1B7JID9jaZtPUehJuSS8iOxlhV1vj+Er eA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 33teem5sek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Sun, 27 Sep 2020 22:51:37 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 27 Sep
 2020 22:51:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Sep 2020 22:51:36 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 2E52C3F703F;
        Sun, 27 Sep 2020 22:51:36 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 08S5paVJ004001;
        Sun, 27 Sep 2020 22:51:36 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 08S5pZ4h004000;
        Sun, 27 Sep 2020 22:51:35 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 2/7] qla2xxx: Fix buffer-buffer credit extraction error
Date:   Sun, 27 Sep 2020 22:50:18 -0700
Message-ID: <20200928055023.3950-3-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200928055023.3950-1-njavali@marvell.com>
References: <20200928055023.3950-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_05:2020-09-24,2020-09-28 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Current code uses wrong mailbox option to extract bbc
from fw. This field is nested inside of Plogi payload.
Extract bbc from PLOGI template payload.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |  4 ++-
 drivers/scsi/qla2xxx/qla_init.c | 49 +++++++++++++++++----------------
 drivers/scsi/qla2xxx/qla_iocb.c |  3 +-
 drivers/scsi/qla2xxx/qla_mbx.c  | 39 --------------------------
 drivers/scsi/qla2xxx/qla_os.c   | 19 +++----------
 5 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index fa31301528bd..98814a9a8ea6 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3915,6 +3915,7 @@ struct qla_hw_data {
 				/* Enabled in Driver */
 		uint32_t	scm_enabled:1;
 		uint32_t	max_req_queue_warned:1;
+		uint32_t	plogi_template_valid:1;
 	} flags;
 
 	uint16_t max_exchg;
@@ -4263,7 +4264,8 @@ struct qla_hw_data {
 	int 		exchoffld_count;
 
 	/* n2n */
-	struct els_plogi_payload plogi_els_payld;
+	struct fc_els_flogi plogi_els_payld;
+#define LOGIN_TEMPLATE_SIZE (sizeof(struct fc_els_flogi) - 4)
 
 	void            *swl;
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 980e39b8b3de..6b88b0e6d91a 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4981,6 +4981,28 @@ qla2x00_free_fcport(fc_port_t *fcport)
 	kfree(fcport);
 }
 
+static void qla_get_login_template(scsi_qla_host_t *vha)
+{
+	struct qla_hw_data *ha = vha->hw;
+	int rval;
+	u32 *bp, sz;
+
+	memset(ha->init_cb, 0, ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
+	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
+					    ha->init_cb, sz);
+	if (rval == QLA_SUCCESS) {
+		__be32 *q = (__be32 *)&ha->plogi_els_payld.fl_csp;
+
+		bp = (uint32_t *)ha->init_cb;
+		cpu_to_be32_array(q, bp, sz / 4);
+		ha->flags.plogi_template_valid = 1;
+	} else {
+		ql_dbg(ql_dbg_init, vha, 0x00d1,
+		       "PLOGI ELS param read fail.\n");
+	}
+}
+
 /*
  * qla2x00_configure_loop
  *      Updates Fibre Channel Device Database with what is actually on loop.
@@ -5024,6 +5046,7 @@ qla2x00_configure_loop(scsi_qla_host_t *vha)
 	clear_bit(RSCN_UPDATE, &vha->dpc_flags);
 
 	qla2x00_get_data_rate(vha);
+	qla_get_login_template(vha);
 
 	/* Determine what we need to do */
 	if ((ha->current_topology == ISP_CFG_FL ||
@@ -5108,32 +5131,11 @@ qla2x00_configure_loop(scsi_qla_host_t *vha)
 
 static int qla2x00_configure_n2n_loop(scsi_qla_host_t *vha)
 {
-	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
 	fc_port_t *fcport;
-	int rval;
-
-	if (test_and_clear_bit(N2N_LOGIN_NEEDED, &vha->dpc_flags)) {
-		/* borrowing */
-		u32 *bp, sz;
-
-		memset(ha->init_cb, 0, ha->init_cb_size);
-		sz = min_t(int, sizeof(struct els_plogi_payload),
-			   ha->init_cb_size);
-		rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
-						    ha->init_cb, sz);
-		if (rval == QLA_SUCCESS) {
-			__be32 *q = &ha->plogi_els_payld.data[0];
 
-			bp = (uint32_t *)ha->init_cb;
-			cpu_to_be32_array(q, bp, sz / 4);
-			memcpy(bp, q, sizeof(ha->plogi_els_payld.data));
-		} else {
-			ql_dbg(ql_dbg_init, vha, 0x00d1,
-			       "PLOGI ELS param read fail.\n");
-			goto skip_login;
-		}
-	}
+	if (test_and_clear_bit(N2N_LOGIN_NEEDED, &vha->dpc_flags))
+		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
 
 	list_for_each_entry(fcport, &vha->vp_fcports, list) {
 		if (fcport->n2n_flag) {
@@ -5142,7 +5144,6 @@ static int qla2x00_configure_n2n_loop(scsi_qla_host_t *vha)
 		}
 	}
 
-skip_login:
 	spin_lock_irqsave(&vha->work_lock, flags);
 	vha->scan.scan_retry++;
 	spin_unlock_irqrestore(&vha->work_lock, flags);
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 310db7e4e233..3202c9ca42f6 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3013,8 +3013,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	memset(ptr, 0, sizeof(struct els_plogi_payload));
 	memset(resp_ptr, 0, sizeof(struct els_plogi_payload));
 	memcpy(elsio->u.els_plogi.els_plogi_pyld->data,
-	    &ha->plogi_els_payld.data,
-	    sizeof(elsio->u.els_plogi.els_plogi_pyld->data));
+	    &ha->plogi_els_payld.fl_csp, LOGIN_TEMPLATE_SIZE);
 
 	elsio->u.els_plogi.els_cmd = els_opcode;
 	elsio->u.els_plogi.els_plogi_pyld->opcode = els_opcode;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 92166b86369a..d861d025bce1 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4979,45 +4979,6 @@ qla25xx_set_els_cmds_supported(scsi_qla_host_t *vha)
 	return rval;
 }
 
-int
-qla24xx_get_buffer_credits(scsi_qla_host_t *vha, struct buffer_credit_24xx *bbc,
-	dma_addr_t bbc_dma)
-{
-	mbx_cmd_t mc;
-	mbx_cmd_t *mcp = &mc;
-	int rval;
-
-	if (!IS_FWI2_CAPABLE(vha->hw))
-		return QLA_FUNCTION_FAILED;
-
-	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x118e,
-	    "Entered %s.\n", __func__);
-
-	mcp->mb[0] = MBC_GET_RNID_PARAMS;
-	mcp->mb[1] = RNID_BUFFER_CREDITS << 8;
-	mcp->mb[2] = MSW(LSD(bbc_dma));
-	mcp->mb[3] = LSW(LSD(bbc_dma));
-	mcp->mb[6] = MSW(MSD(bbc_dma));
-	mcp->mb[7] = LSW(MSD(bbc_dma));
-	mcp->mb[8] = sizeof(*bbc) / sizeof(*bbc->parameter);
-	mcp->out_mb = MBX_8|MBX_7|MBX_6|MBX_3|MBX_2|MBX_1|MBX_0;
-	mcp->in_mb = MBX_1|MBX_0;
-	mcp->buf_size = sizeof(*bbc);
-	mcp->flags = MBX_DMA_IN;
-	mcp->tov = MBX_TOV_SECONDS;
-	rval = qla2x00_mailbox_command(vha, mcp);
-
-	if (rval != QLA_SUCCESS) {
-		ql_dbg(ql_dbg_mbx, vha, 0x118f,
-		    "Failed=%x mb[0]=%x,%x.\n", rval, mcp->mb[0], mcp->mb[1]);
-	} else {
-		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1190,
-		    "Done %s.\n", __func__);
-	}
-
-	return rval;
-}
-
 static int
 qla2x00_read_asic_temperature(scsi_qla_host_t *vha, uint16_t *temp)
 {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b943b2f1df6b..6c4dc8eff8b8 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5837,12 +5837,10 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 	dma_addr_t rsp_els_dma;
 	dma_addr_t rsp_payload_dma;
 	dma_addr_t stat_dma;
-	dma_addr_t bbc_dma;
 	dma_addr_t sfp_dma;
 	struct els_entry_24xx *rsp_els = NULL;
 	struct rdp_rsp_payload *rsp_payload = NULL;
 	struct link_statistics *stat = NULL;
-	struct buffer_credit_24xx *bbc = NULL;
 	uint8_t *sfp = NULL;
 	uint16_t sfp_flags = 0;
 	uint rsp_payload_length = sizeof(*rsp_payload);
@@ -5886,9 +5884,6 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 	stat = dma_alloc_coherent(&ha->pdev->dev, sizeof(*stat),
 	    &stat_dma, GFP_KERNEL);
 
-	bbc = dma_alloc_coherent(&ha->pdev->dev, sizeof(*bbc),
-	    &bbc_dma, GFP_KERNEL);
-
 	/* Prepare Response IOCB */
 	rsp_els->entry_type = ELS_IOCB_TYPE;
 	rsp_els->entry_count = 1;
@@ -6042,13 +6037,10 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 	rsp_payload->buffer_credit_desc.attached_fcport_b2b = cpu_to_be32(0);
 	rsp_payload->buffer_credit_desc.fcport_rtt = cpu_to_be32(0);
 
-	if (bbc) {
-		memset(bbc, 0, sizeof(*bbc));
-		rval = qla24xx_get_buffer_credits(vha, bbc, bbc_dma);
-		if (!rval) {
-			rsp_payload->buffer_credit_desc.fcport_b2b =
-			    cpu_to_be32(LSW(bbc->parameter[0]));
-		}
+	if (ha->flags.plogi_template_valid) {
+		uint32_t tmp =
+		be16_to_cpu(ha->plogi_els_payld.fl_csp.sp_bb_cred);
+		rsp_payload->buffer_credit_desc.fcport_b2b = cpu_to_be32(tmp);
 	}
 
 	if (rsp_payload_length < sizeof(*rsp_payload))
@@ -6226,9 +6218,6 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 	}
 
 dealloc:
-	if (bbc)
-		dma_free_coherent(&ha->pdev->dev, sizeof(*bbc),
-		    bbc, bbc_dma);
 	if (stat)
 		dma_free_coherent(&ha->pdev->dev, sizeof(*stat),
 		    stat, stat_dma);
-- 
2.19.0.rc0

