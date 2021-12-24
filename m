Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC247EC80
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Dec 2021 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351766AbhLXHHy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Dec 2021 02:07:54 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56278 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351745AbhLXHHw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Dec 2021 02:07:52 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BO2WGJu008452
        for <linux-scsi@vger.kernel.org>; Thu, 23 Dec 2021 23:07:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=eeFr/o5aVuEtmUrpCiyUsSZE6u/dbMJT2LfyLZHW9/A=;
 b=LvZEFQ+zA8XBxFhqOsVpxdmSOpsIugz6QOXGEmbyVLxV7XYI1J+QfbTJ8rFraStiHoax
 vNSQqrzpxxN+4HgQjdywLP8TUbg9O7peA378UrjTDaGyx15iNfrnRAAbzDuQQNig1vt8
 XDMU1YNc8/ZJtK+Tv2Uhk1UDD4F+9BhY27D0eT1EDiUiV0R1f6mJ3APr3BzdygabXU7k
 ffqgJnVkTiKjO/Z6oFPFtu9S446OL8yBUCtPJLdatB8ClU1XMRTHmCBO6i9HIzQoF0hc
 RK+9oSrfeyCenkN+UIXB92axpzkM5+gmoNdXzk6EXGm8cgof51fNNS4Lvu6Mi9pghdDj MQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3d4t6kjua2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 23 Dec 2021 23:07:50 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Dec
 2021 23:07:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Dec 2021 23:07:48 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id BD80D3F7063;
        Thu, 23 Dec 2021 23:07:48 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1BO77jsY017944;
        Thu, 23 Dec 2021 23:07:45 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1BO77bJX017943;
        Thu, 23 Dec 2021 23:07:37 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 01/16] qla2xxx: Refactor asynchronous command initialization
Date:   Thu, 23 Dec 2021 23:06:57 -0800
Message-ID: <20211224070712.17905-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20211224070712.17905-1-njavali@marvell.com>
References: <20211224070712.17905-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: rcbH7cenOVMQyfqLom8NmKCuC5dBMAjy
X-Proofpoint-ORIG-GUID: rcbH7cenOVMQyfqLom8NmKCuC5dBMAjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-24_02,2021-12-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

Move common open coded asynchronous command initializing code such as
setting up the timer and the done callback into one function. This is
a preparation step and allows us later on to change the low level
error flow handling at a central place.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gbl.h    |  3 +-
 drivers/scsi/qla2xxx/qla_gs.c     | 70 +++++++++-------------------
 drivers/scsi/qla2xxx/qla_init.c   | 77 ++++++++++---------------------
 drivers/scsi/qla2xxx/qla_iocb.c   | 29 ++++++------
 drivers/scsi/qla2xxx/qla_mbx.c    | 11 ++---
 drivers/scsi/qla2xxx/qla_mid.c    |  5 +-
 drivers/scsi/qla2xxx/qla_mr.c     |  7 ++-
 drivers/scsi/qla2xxx/qla_target.c |  6 +--
 8 files changed, 76 insertions(+), 132 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 8d8503a28479..5056564f0d0c 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -316,7 +316,8 @@ extern int qla2x00_start_sp(srb_t *);
 extern int qla24xx_dif_start_scsi(srb_t *);
 extern int qla2x00_start_bidir(srb_t *, struct scsi_qla_host *, uint32_t);
 extern int qla2xxx_dif_start_scsi_mq(srb_t *);
-extern void qla2x00_init_timer(srb_t *sp, unsigned long tmo);
+extern void qla2x00_init_async_sp(srb_t *sp, unsigned long tmo,
+				  void (*done)(struct srb *, int));
 extern unsigned long qla2x00_get_async_timeout(struct scsi_qla_host *);
 
 extern void *qla2x00_alloc_iocbs(struct scsi_qla_host *, srb_t *);
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 28b574e20ef3..744eb3192056 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -598,7 +598,8 @@ static int qla_async_rftid(scsi_qla_host_t *vha, port_id_t *d_id)
 
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rft_id";
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_sns_sp_done);
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -638,8 +639,6 @@ static int qla_async_rftid(scsi_qla_host_t *vha, port_id_t *d_id)
 	sp->u.iocb_cmd.u.ctarg.req_size = RFT_ID_REQ_SIZE;
 	sp->u.iocb_cmd.u.ctarg.rsp_size = RFT_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x portid %06x.\n",
@@ -694,7 +693,8 @@ static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
 
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rff_id";
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_sns_sp_done);
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -732,8 +732,6 @@ static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
 	sp->u.iocb_cmd.u.ctarg.req_size = RFF_ID_REQ_SIZE;
 	sp->u.iocb_cmd.u.ctarg.rsp_size = RFF_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x portid %06x feature %x type %x.\n",
@@ -785,7 +783,8 @@ static int qla_async_rnnid(scsi_qla_host_t *vha, port_id_t *d_id,
 
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rnid";
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_sns_sp_done);
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -823,9 +822,6 @@ static int qla_async_rnnid(scsi_qla_host_t *vha, port_id_t *d_id,
 	sp->u.iocb_cmd.u.ctarg.rsp_size = RNN_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x portid %06x\n",
 	    sp->name, sp->handle, d_id->b24);
@@ -892,7 +888,8 @@ static int qla_async_rsnn_nn(scsi_qla_host_t *vha)
 
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rsnn_nn";
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_sns_sp_done);
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -936,9 +933,6 @@ static int qla_async_rsnn_nn(scsi_qla_host_t *vha)
 	sp->u.iocb_cmd.u.ctarg.rsp_size = RSNN_NN_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x.\n",
 	    sp->name, sp->handle);
@@ -2913,8 +2907,8 @@ int qla24xx_async_gpsc(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->name = "gpsc";
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
-
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla24xx_async_gpsc_sp_done);
 
 	/* CT_IU preamble  */
 	ct_req = qla24xx_prep_ct_fm_req(fcport->ct_desc.ct_sns, GPSC_CMD,
@@ -2932,9 +2926,6 @@ int qla24xx_async_gpsc(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->u.iocb_cmd.u.ctarg.rsp_size = GPSC_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = vha->mgmt_svr_loop_id;
 
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla24xx_async_gpsc_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0x205e,
 	    "Async-%s %8phC hdl=%x loopid=%x portid=%02x%02x%02x.\n",
 	    sp->name, fcport->port_name, sp->handle,
@@ -3190,7 +3181,8 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 	sp->name = "gpnid";
 	sp->u.iocb_cmd.u.ctarg.id = *id;
 	sp->gen1 = 0;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_gpnid_sp_done);
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	list_for_each_entry(tsp, &vha->gpnid_list, elem) {
@@ -3238,9 +3230,6 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 	sp->u.iocb_cmd.u.ctarg.rsp_size = GPN_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_gpnid_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0x2067,
 	    "Async-%s hdl=%x ID %3phC.\n", sp->name,
 	    sp->handle, &ct_req->req.port_id.port_id);
@@ -3348,9 +3337,8 @@ int qla24xx_async_gffid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->name = "gffid";
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
-
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla24xx_async_gffid_sp_done);
 
 	/* CT_IU preamble  */
 	ct_req = qla2x00_prep_ct_req(fcport->ct_desc.ct_sns, GFF_ID_CMD,
@@ -3368,8 +3356,6 @@ int qla24xx_async_gffid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->u.iocb_cmd.u.ctarg.rsp_size = GFF_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->done = qla24xx_async_gffid_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0x2132,
 	    "Async-%s hdl=%x  %8phC.\n", sp->name,
 	    sp->handle, fcport->port_name);
@@ -3892,9 +3878,8 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 	sp->name = "gnnft";
 	sp->gen1 = vha->hw->base_qpair->chip_reset;
 	sp->gen2 = fc4_type;
-
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_gpnft_gnnft_sp_done);
 
 	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
 	memset(sp->u.iocb_cmd.u.ctarg.req, 0, sp->u.iocb_cmd.u.ctarg.req_size);
@@ -3910,8 +3895,6 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 	sp->u.iocb_cmd.u.ctarg.req_size = GNN_FT_REQ_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->done = qla2x00_async_gpnft_gnnft_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s hdl=%x FC4Type %x.\n", sp->name,
 	    sp->handle, ct_req->req.gpn_ft.port_type);
@@ -4057,9 +4040,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 	sp->name = "gpnft";
 	sp->gen1 = vha->hw->base_qpair->chip_reset;
 	sp->gen2 = fc4_type;
-
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_gpnft_gnnft_sp_done);
 
 	rspsz = sp->u.iocb_cmd.u.ctarg.rsp_size;
 	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
@@ -4074,8 +4056,6 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->done = qla2x00_async_gpnft_gnnft_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s hdl=%x FC4Type %x.\n", sp->name,
 	    sp->handle, ct_req->req.gpn_ft.port_type);
@@ -4189,9 +4169,8 @@ int qla24xx_async_gnnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->name = "gnnid";
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
-
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_gnnid_sp_done);
 
 	/* CT_IU preamble  */
 	ct_req = qla2x00_prep_ct_req(fcport->ct_desc.ct_sns, GNN_ID_CMD,
@@ -4210,8 +4189,6 @@ int qla24xx_async_gnnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->u.iocb_cmd.u.ctarg.rsp_size = GNN_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->done = qla2x00_async_gnnid_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - %8phC hdl=%x loopid=%x portid %06x.\n",
 	    sp->name, fcport->port_name,
@@ -4317,9 +4294,8 @@ int qla24xx_async_gfpnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->name = "gfpnid";
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
-
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_gfpnid_sp_done);
 
 	/* CT_IU preamble  */
 	ct_req = qla2x00_prep_ct_req(fcport->ct_desc.ct_sns, GFPN_ID_CMD,
@@ -4338,8 +4314,6 @@ int qla24xx_async_gfpnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	sp->u.iocb_cmd.u.ctarg.rsp_size = GFPN_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->done = qla2x00_async_gfpnid_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - %8phC hdl=%x loopid=%x portid %06x.\n",
 	    sp->name, fcport->port_name,
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1fe4966fc2f6..e6f13cb6fa28 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -167,16 +167,14 @@ int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	if (wait)
 		sp->flags = SRB_WAKEUP_ON_COMP;
 
-	abt_iocb->timeout = qla24xx_abort_iocb_timeout;
 	init_completion(&abt_iocb->u.abt.comp);
 	/* FW can send 2 x ABTS's timeout/20s */
-	qla2x00_init_timer(sp, 42);
+	qla2x00_init_async_sp(sp, 42, qla24xx_abort_sp_done);
+	sp->u.iocb_cmd.timeout = qla24xx_abort_iocb_timeout;
 
 	abt_iocb->u.abt.cmd_hndl = cmd_sp->handle;
 	abt_iocb->u.abt.req_que_no = cpu_to_le16(cmd_sp->qpair->req->id);
 
-	sp->done = qla24xx_abort_sp_done;
-
 	ql_dbg(ql_dbg_async, vha, 0x507c,
 	       "Abort command issued - hdl=%x, type=%x\n", cmd_sp->handle,
 	       cmd_sp->type);
@@ -320,12 +318,10 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
 	sp->name = "login";
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_login_sp_done);
 
 	lio = &sp->u.iocb_cmd;
-	lio->timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
-
-	sp->done = qla2x00_async_login_sp_done;
 	if (N2N_TOPO(fcport->vha->hw) && fcport_is_bigger(fcport)) {
 		lio->u.logio.flags |= SRB_LOGIN_PRLI_ONLY;
 	} else {
@@ -377,7 +373,6 @@ int
 qla2x00_async_logout(struct scsi_qla_host *vha, fc_port_t *fcport)
 {
 	srb_t *sp;
-	struct srb_iocb *lio;
 	int rval = QLA_FUNCTION_FAILED;
 
 	fcport->flags |= FCF_ASYNC_SENT;
@@ -387,12 +382,8 @@ qla2x00_async_logout(struct scsi_qla_host *vha, fc_port_t *fcport)
 
 	sp->type = SRB_LOGOUT_CMD;
 	sp->name = "logout";
-
-	lio = &sp->u.iocb_cmd;
-	lio->timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
-
-	sp->done = qla2x00_async_logout_sp_done;
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_logout_sp_done),
 
 	ql_dbg(ql_dbg_disc, vha, 0x2070,
 	    "Async-logout - hdl=%x loop-id=%x portid=%02x%02x%02x %8phC explicit %d.\n",
@@ -439,7 +430,6 @@ int
 qla2x00_async_prlo(struct scsi_qla_host *vha, fc_port_t *fcport)
 {
 	srb_t *sp;
-	struct srb_iocb *lio;
 	int rval;
 
 	rval = QLA_FUNCTION_FAILED;
@@ -449,12 +439,8 @@ qla2x00_async_prlo(struct scsi_qla_host *vha, fc_port_t *fcport)
 
 	sp->type = SRB_PRLO_CMD;
 	sp->name = "prlo";
-
-	lio = &sp->u.iocb_cmd;
-	lio->timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
-
-	sp->done = qla2x00_async_prlo_sp_done;
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_prlo_sp_done);
 
 	ql_dbg(ql_dbg_disc, vha, 0x2070,
 	    "Async-prlo - hdl=%x loop-id=%x portid=%02x%02x%02x.\n",
@@ -575,16 +561,15 @@ qla2x00_async_adisc(struct scsi_qla_host *vha, fc_port_t *fcport,
 
 	sp->type = SRB_ADISC_CMD;
 	sp->name = "adisc";
-
-	lio = &sp->u.iocb_cmd;
-	lio->timeout = qla2x00_async_iocb_timeout;
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_adisc_sp_done);
 
-	sp->done = qla2x00_async_adisc_sp_done;
-	if (data[1] & QLA_LOGIO_LOGIN_RETRIED)
+	if (data[1] & QLA_LOGIO_LOGIN_RETRIED) {
+		lio = &sp->u.iocb_cmd;
 		lio->u.logio.flags |= SRB_LOGIN_RETRIED;
+	}
 
 	ql_dbg(ql_dbg_disc, vha, 0x206f,
 	    "Async-adisc - hdl=%x loopid=%x portid=%06x %8phC.\n",
@@ -1084,7 +1069,6 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 {
 	srb_t *sp;
-	struct srb_iocb *mbx;
 	int rval = QLA_FUNCTION_FAILED;
 	unsigned long flags;
 	u16 *mb;
@@ -1117,10 +1101,8 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 	sp->name = "gnlist";
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
-
-	mbx = &sp->u.iocb_cmd;
-	mbx->timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha)+2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla24xx_async_gnl_sp_done);
 
 	mb = sp->u.iocb_cmd.u.mbx.out_mb;
 	mb[0] = MBC_PORT_NODE_NAME_LIST;
@@ -1132,8 +1114,6 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 	mb[8] = vha->gnl.size;
 	mb[9] = vha->vp_idx;
 
-	sp->done = qla24xx_async_gnl_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0x20da,
 	    "Async-%s - OUT WWPN %8phC hndl %x\n",
 	    sp->name, fcport->port_name, sp->handle);
@@ -1269,12 +1249,10 @@ qla24xx_async_prli(struct scsi_qla_host *vha, fc_port_t *fcport)
 
 	sp->type = SRB_PRLI_CMD;
 	sp->name = "prli";
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_prli_sp_done);
 
 	lio = &sp->u.iocb_cmd;
-	lio->timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
-
-	sp->done = qla2x00_async_prli_sp_done;
 	lio->u.logio.flags = 0;
 
 	if (NVME_TARGET(vha->hw, fcport))
@@ -1344,10 +1322,8 @@ int qla24xx_async_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport, u8 opt)
 	sp->name = "gpdb";
 	sp->gen1 = fcport->rscn_gen;
 	sp->gen2 = fcport->login_gen;
-
-	mbx = &sp->u.iocb_cmd;
-	mbx->timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla24xx_async_gpdb_sp_done);
 
 	pd = dma_pool_zalloc(ha->s_dma_pool, GFP_KERNEL, &pd_dma);
 	if (pd == NULL) {
@@ -1366,11 +1342,10 @@ int qla24xx_async_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport, u8 opt)
 	mb[9] = vha->vp_idx;
 	mb[10] = opt;
 
-	mbx->u.mbx.in = pd;
+	mbx = &sp->u.iocb_cmd;
+	mbx->u.mbx.in = (void *)pd;
 	mbx->u.mbx.in_dma = pd_dma;
 
-	sp->done = qla24xx_async_gpdb_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0x20dc,
 	    "Async-%s %8phC hndl %x opt %x\n",
 	    sp->name, fcport->port_name, sp->handle, opt);
@@ -1974,18 +1949,16 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 	if (!sp)
 		goto done;
 
-	tm_iocb = &sp->u.iocb_cmd;
 	sp->type = SRB_TM_CMD;
 	sp->name = "tmf";
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha),
+			      qla2x00_tmf_sp_done);
+	sp->u.iocb_cmd.timeout = qla2x00_tmf_iocb_timeout;
 
-	tm_iocb->timeout = qla2x00_tmf_iocb_timeout;
+	tm_iocb = &sp->u.iocb_cmd;
 	init_completion(&tm_iocb->u.tmf.comp);
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha));
-
 	tm_iocb->u.tmf.flags = flags;
 	tm_iocb->u.tmf.lun = lun;
-	tm_iocb->u.tmf.data = tag;
-	sp->done = qla2x00_tmf_sp_done;
 
 	ql_dbg(ql_dbg_taskm, vha, 0x802f,
 	    "Async-tmf hdl=%x loop-id=%x portid=%02x%02x%02x.\n",
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index ed604f2185bf..95aae9a9631e 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2560,11 +2560,15 @@ qla24xx_tm_iocb(srb_t *sp, struct tsk_mgmt_entry *tsk)
 	}
 }
 
-void qla2x00_init_timer(srb_t *sp, unsigned long tmo)
+void
+qla2x00_init_async_sp(srb_t *sp, unsigned long tmo,
+		     void (*done)(struct srb *sp, int res))
 {
 	timer_setup(&sp->u.iocb_cmd.timer, qla2x00_sp_timeout, 0);
-	sp->u.iocb_cmd.timer.expires = jiffies + tmo * HZ;
+	sp->done = done;
 	sp->free = qla2x00_sp_free;
+	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
+	sp->u.iocb_cmd.timer.expires = jiffies + tmo * HZ;
 	if (IS_QLAFX00(sp->vha->hw) && sp->type == SRB_FXIOCB_DCMD)
 		init_completion(&sp->u.iocb_cmd.u.fxiocb.fxiocb_comp);
 	sp->start_timer = 1;
@@ -2672,11 +2676,11 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	sp->type = SRB_ELS_DCMD;
 	sp->name = "ELS_DCMD";
 	sp->fcport = fcport;
-	elsio->timeout = qla2x00_els_dcmd_iocb_timeout;
-	qla2x00_init_timer(sp, ELS_DCMD_TIMEOUT);
-	init_completion(&sp->u.iocb_cmd.u.els_logo.comp);
-	sp->done = qla2x00_els_dcmd_sp_done;
+	qla2x00_init_async_sp(sp, ELS_DCMD_TIMEOUT,
+			      qla2x00_els_dcmd_sp_done);
 	sp->free = qla2x00_els_dcmd_sp_free;
+	sp->u.iocb_cmd.timeout = qla2x00_els_dcmd_iocb_timeout;
+	init_completion(&sp->u.iocb_cmd.u.els_logo.comp);
 
 	elsio->u.els_logo.els_logo_pyld = dma_alloc_coherent(&ha->pdev->dev,
 			    DMA_POOL_SIZE, &elsio->u.els_logo.els_logo_pyld_dma,
@@ -2993,17 +2997,16 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	ql_dbg(ql_dbg_io, vha, 0x3073,
 	       "%s Enter: PLOGI portid=%06x\n", __func__, fcport->d_id.b24);
 
-	sp->type = SRB_ELS_DCMD;
-	sp->name = "ELS_DCMD";
-	sp->fcport = fcport;
-
-	elsio->timeout = qla2x00_els_dcmd2_iocb_timeout;
 	if (wait)
 		sp->flags = SRB_WAKEUP_ON_COMP;
 
-	qla2x00_init_timer(sp, ELS_DCMD_TIMEOUT + 2);
+	sp->type = SRB_ELS_DCMD;
+	sp->name = "ELS_DCMD";
+	sp->fcport = fcport;
+	qla2x00_init_async_sp(sp, ELS_DCMD_TIMEOUT + 2,
+			     qla2x00_els_dcmd2_sp_done);
+	sp->u.iocb_cmd.timeout = qla2x00_els_dcmd2_iocb_timeout;
 
-	sp->done = qla2x00_els_dcmd2_sp_done;
 	elsio->u.els_plogi.tx_size = elsio->u.els_plogi.rx_size = DMA_POOL_SIZE;
 
 	ptr = elsio->u.els_plogi.els_plogi_pyld =
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 10d2655ef676..2aacd3653245 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -6483,19 +6483,16 @@ int qla24xx_send_mb_cmd(struct scsi_qla_host *vha, mbx_cmd_t *mcp)
 	if (!sp)
 		goto done;
 
-	sp->type = SRB_MB_IOCB;
-	sp->name = mb_to_str(mcp->mb[0]);
-
 	c = &sp->u.iocb_cmd;
-	c->timeout = qla2x00_async_iocb_timeout;
 	init_completion(&c->u.mbx.comp);
 
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->type = SRB_MB_IOCB;
+	sp->name = mb_to_str(mcp->mb[0]);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_mb_sp_done);
 
 	memcpy(sp->u.iocb_cmd.u.mbx.out_mb, mcp->mb, SIZEOF_IOCB_MB_REG);
 
-	sp->done = qla2x00_async_mb_sp_done;
-
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
 		ql_dbg(ql_dbg_mbx, vha, 0x1018,
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 1c024055f8c5..c4a967c96fd6 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -972,9 +972,8 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
 	sp->type = SRB_CTRL_VP;
 	sp->name = "ctrl_vp";
 	sp->comp = &comp;
-	sp->done = qla_ctrlvp_sp_done;
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla_ctrlvp_sp_done);
 	sp->u.iocb_cmd.u.ctrlvp.cmd = cmd;
 	sp->u.iocb_cmd.u.ctrlvp.vp_index = vp_index;
 
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 350b0c4346fb..e3ae0894c7a8 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1793,11 +1793,11 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 
 	sp->type = SRB_FXIOCB_DCMD;
 	sp->name = "fxdisc";
+	qla2x00_init_async_sp(sp, FXDISC_TIMEOUT,
+			      qla2x00_fxdisc_sp_done);
+	sp->u.iocb_cmd.timeout = qla2x00_fxdisc_iocb_timeout;
 
 	fdisc = &sp->u.iocb_cmd;
-	fdisc->timeout = qla2x00_fxdisc_iocb_timeout;
-	qla2x00_init_timer(sp, FXDISC_TIMEOUT);
-
 	switch (fx_type) {
 	case FXDISC_GET_CONFIG_INFO:
 	fdisc->u.fxiocb.flags =
@@ -1898,7 +1898,6 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 	}
 
 	fdisc->u.fxiocb.req_func_type = cpu_to_le16(fx_type);
-	sp->done = qla2x00_fxdisc_sp_done;
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS)
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 8993d438e0b7..83c8c55017d1 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -656,12 +656,10 @@ int qla24xx_async_notify_ack(scsi_qla_host_t *vha, fc_port_t *fcport,
 
 	sp->type = type;
 	sp->name = "nack";
-
-	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha)+2);
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
+			      qla2x00_async_nack_sp_done);
 
 	sp->u.iocb_cmd.u.nack.ntfy = ntfy;
-	sp->done = qla2x00_async_nack_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20f4,
 	    "Async-%s %8phC hndl %x %s\n",
-- 
2.23.1

