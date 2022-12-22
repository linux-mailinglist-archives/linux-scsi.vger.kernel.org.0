Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D22653B5D
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Dec 2022 05:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiLVEkD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Dec 2022 23:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiLVEjp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Dec 2022 23:39:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6686B1A235
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:44 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM4OKMl020309
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=C8SQt44vyoeVB8rAajyHSy8XSyuNPN39TmAN30dj3Ro=;
 b=fozkPeLpp0jz+1NE5oMaPy0DsBALTbUA79K0+GzkVk/Q2+5UapANkoVpFjx0qpTE+WyU
 0Sz4kXnEEPhQfF1aLi7KsqkjAc7Uod8gWI+w0TXcxZAPPtvHG/MgYc4foFC0jeyVjZlq
 i9M8IG4qYAxKcYzZwnERw1tlv8Et0HxM2vyyv7vgWpa/zEPsoJYn+zeUj2Dd11poWLIC
 FwZdwfNnJUUPbaG2qtX4UY1+xfl6M886M45LJn4yGicczFoZ/w9yQt8GQKoMq0ltGEQ8
 xDjSsB/iMHe5m8+hBK4btZA47SuJVzCcSJREwhwsMbTBdxYj/ipqsXxXOq3cJnzKa2Af Tg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3mhe5rsdhc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Dec
 2022 20:39:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 21 Dec 2022 20:39:40 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 82CDE3F7069;
        Wed, 21 Dec 2022 20:39:40 -0800 (PST)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <bhazarika@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH 02/10] qla2xxx: Remove dead code (GPNID)
Date:   Wed, 21 Dec 2022 20:39:25 -0800
Message-ID: <20221222043933.2825-3-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20221222043933.2825-1-njavali@marvell.com>
References: <20221222043933.2825-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: v56kk5SiuUtf7eqAF0faBdG49n1clD9P
X-Proofpoint-ORIG-GUID: v56kk5SiuUtf7eqAF0faBdG49n1clD9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_01,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Remove stale unused code for GPNID.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |   7 +-
 drivers/scsi/qla2xxx/qla_gbl.h  |   4 -
 drivers/scsi/qla2xxx/qla_gs.c   | 297 --------------------------------
 drivers/scsi/qla2xxx/qla_init.c |   2 +-
 drivers/scsi/qla2xxx/qla_iocb.c |   2 +-
 drivers/scsi/qla2xxx/qla_os.c   |   4 -
 6 files changed, 3 insertions(+), 313 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 0dde3fa9e258..9ee9ce613c75 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3479,7 +3479,6 @@ enum qla_work_type {
 	QLA_EVT_ASYNC_ADISC,
 	QLA_EVT_UEVENT,
 	QLA_EVT_AENFX,
-	QLA_EVT_GPNID,
 	QLA_EVT_UNMAP,
 	QLA_EVT_NEW_SESS,
 	QLA_EVT_GPDB,
@@ -3534,9 +3533,6 @@ struct qla_work_evt {
 		struct {
 			srb_t *sp;
 		} iosb;
-		struct {
-			port_id_t id;
-		} gpnid;
 		struct {
 			port_id_t id;
 			u8 port_name[8];
@@ -3544,7 +3540,7 @@ struct qla_work_evt {
 			void *pla;
 			u8 fc4_type;
 		} new_sess;
-		struct { /*Get PDB, Get Speed, update fcport, gnl, gidpn */
+		struct { /*Get PDB, Get Speed, update fcport, gnl */
 			fc_port_t *fcport;
 			u8 opt;
 		} fcport;
@@ -5025,7 +5021,6 @@ typedef struct scsi_qla_host {
 	uint8_t n2n_port_name[WWN_SIZE];
 	uint16_t	n2n_id;
 	__le16 dport_data[4];
-	struct list_head gpnid_list;
 	struct fab_scan scan;
 	uint8_t	scm_fabric_connection_flags;
 
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index e3256e721be1..2acddc8dc943 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -721,10 +721,6 @@ extern int qla2x00_chk_ms_status(scsi_qla_host_t *, ms_iocb_entry_t *,
 	struct ct_sns_rsp *, const char *);
 extern void qla2x00_async_iocb_timeout(void *data);
 
-extern int qla24xx_post_gpnid_work(struct scsi_qla_host *, port_id_t *);
-extern int qla24xx_async_gpnid(scsi_qla_host_t *, port_id_t *);
-void qla24xx_handle_gpnid_event(scsi_qla_host_t *, struct event_arg *);
-
 int qla24xx_post_gpsc_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_async_gpsc(scsi_qla_host_t *, fc_port_t *);
 void qla24xx_handle_gpsc_event(scsi_qla_host_t *, struct event_arg *);
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 64ab070b8716..fe1eb06db654 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -2949,22 +2949,6 @@ int qla24xx_async_gpsc(scsi_qla_host_t *vha, fc_port_t *fcport)
 	return rval;
 }
 
-int qla24xx_post_gpnid_work(struct scsi_qla_host *vha, port_id_t *id)
-{
-	struct qla_work_evt *e;
-
-	if (test_bit(UNLOADING, &vha->dpc_flags) ||
-	    (vha->vp_idx && test_bit(VPORT_DELETE, &vha->dpc_flags)))
-		return 0;
-
-	e = qla2x00_alloc_work(vha, QLA_EVT_GPNID);
-	if (!e)
-		return QLA_FUNCTION_FAILED;
-
-	e->u.gpnid.id = *id;
-	return qla2x00_post_work(vha, e);
-}
-
 void qla24xx_sp_unmap(scsi_qla_host_t *vha, srb_t *sp)
 {
 	struct srb_iocb *c = &sp->u.iocb_cmd;
@@ -2997,287 +2981,6 @@ void qla24xx_sp_unmap(scsi_qla_host_t *vha, srb_t *sp)
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 }
 
-void qla24xx_handle_gpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
-{
-	fc_port_t *fcport, *conflict, *t;
-	u16 data[2];
-
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
-	    "%s %d port_id: %06x\n",
-	    __func__, __LINE__, ea->id.b24);
-
-	if (ea->rc) {
-		/* cable is disconnected */
-		list_for_each_entry_safe(fcport, t, &vha->vp_fcports, list) {
-			if (fcport->d_id.b24 == ea->id.b24)
-				fcport->scan_state = QLA_FCPORT_SCAN;
-
-			qlt_schedule_sess_for_deletion(fcport);
-		}
-	} else {
-		/* cable is connected */
-		fcport = qla2x00_find_fcport_by_wwpn(vha, ea->port_name, 1);
-		if (fcport) {
-			list_for_each_entry_safe(conflict, t, &vha->vp_fcports,
-			    list) {
-				if ((conflict->d_id.b24 == ea->id.b24) &&
-				    (fcport != conflict))
-					/*
-					 * 2 fcports with conflict Nport ID or
-					 * an existing fcport is having nport ID
-					 * conflict with new fcport.
-					 */
-
-					conflict->scan_state = QLA_FCPORT_SCAN;
-
-				qlt_schedule_sess_for_deletion(conflict);
-			}
-
-			fcport->scan_needed = 0;
-			fcport->rscn_gen++;
-			fcport->scan_state = QLA_FCPORT_FOUND;
-			fcport->flags |= FCF_FABRIC_DEVICE;
-			if (fcport->login_retry == 0) {
-				fcport->login_retry =
-					vha->hw->login_retry_count;
-				ql_dbg(ql_dbg_disc, vha, 0xffff,
-				    "Port login retry %8phN, lid 0x%04x cnt=%d.\n",
-				    fcport->port_name, fcport->loop_id,
-				    fcport->login_retry);
-			}
-			switch (fcport->disc_state) {
-			case DSC_LOGIN_COMPLETE:
-				/* recheck session is still intact. */
-				ql_dbg(ql_dbg_disc, vha, 0x210d,
-				    "%s %d %8phC revalidate session with ADISC\n",
-				    __func__, __LINE__, fcport->port_name);
-				data[0] = data[1] = 0;
-				qla2x00_post_async_adisc_work(vha, fcport,
-				    data);
-				break;
-			case DSC_DELETED:
-				ql_dbg(ql_dbg_disc, vha, 0x210d,
-				    "%s %d %8phC login\n", __func__, __LINE__,
-				    fcport->port_name);
-				fcport->d_id = ea->id;
-				qla24xx_fcport_handle_login(vha, fcport);
-				break;
-			case DSC_DELETE_PEND:
-				fcport->d_id = ea->id;
-				break;
-			default:
-				fcport->d_id = ea->id;
-				break;
-			}
-		} else {
-			list_for_each_entry_safe(conflict, t, &vha->vp_fcports,
-			    list) {
-				if (conflict->d_id.b24 == ea->id.b24) {
-					/* 2 fcports with conflict Nport ID or
-					 * an existing fcport is having nport ID
-					 * conflict with new fcport.
-					 */
-					ql_dbg(ql_dbg_disc, vha, 0xffff,
-					    "%s %d %8phC DS %d\n",
-					    __func__, __LINE__,
-					    conflict->port_name,
-					    conflict->disc_state);
-
-					conflict->scan_state = QLA_FCPORT_SCAN;
-					qlt_schedule_sess_for_deletion(conflict);
-				}
-			}
-
-			/* create new fcport */
-			ql_dbg(ql_dbg_disc, vha, 0x2065,
-			    "%s %d %8phC post new sess\n",
-			    __func__, __LINE__, ea->port_name);
-			qla24xx_post_newsess_work(vha, &ea->id,
-			    ea->port_name, NULL, NULL, 0);
-		}
-	}
-}
-
-static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
-{
-	struct scsi_qla_host *vha = sp->vha;
-	struct ct_sns_req *ct_req =
-	    (struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
-	struct ct_sns_rsp *ct_rsp =
-	    (struct ct_sns_rsp *)sp->u.iocb_cmd.u.ctarg.rsp;
-	struct event_arg ea;
-	struct qla_work_evt *e;
-	unsigned long flags;
-
-	if (res)
-		ql_dbg(ql_dbg_disc, vha, 0x2066,
-		    "Async done-%s fail res %x rscn gen %d ID %3phC. %8phC\n",
-		    sp->name, res, sp->gen1, &ct_req->req.port_id.port_id,
-		    ct_rsp->rsp.gpn_id.port_name);
-	else
-		ql_dbg(ql_dbg_disc, vha, 0x2066,
-		    "Async done-%s good rscn gen %d ID %3phC. %8phC\n",
-		    sp->name, sp->gen1, &ct_req->req.port_id.port_id,
-		    ct_rsp->rsp.gpn_id.port_name);
-
-	memset(&ea, 0, sizeof(ea));
-	memcpy(ea.port_name, ct_rsp->rsp.gpn_id.port_name, WWN_SIZE);
-	ea.sp = sp;
-	ea.id = be_to_port_id(ct_req->req.port_id.port_id);
-	ea.rc = res;
-
-	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
-	list_del(&sp->elem);
-	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
-
-	if (res) {
-		if (res == QLA_FUNCTION_TIMEOUT) {
-			qla24xx_post_gpnid_work(sp->vha, &ea.id);
-			/* ref: INIT */
-			kref_put(&sp->cmd_kref, qla2x00_sp_release);
-			return;
-		}
-	} else if (sp->gen1) {
-		/* There was another RSCN for this Nport ID */
-		qla24xx_post_gpnid_work(sp->vha, &ea.id);
-		/* ref: INIT */
-		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		return;
-	}
-
-	qla24xx_handle_gpnid_event(vha, &ea);
-
-	e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
-	if (!e) {
-		/* please ignore kernel warning. otherwise, we have mem leak. */
-		dma_free_coherent(&vha->hw->pdev->dev,
-				  sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-				  sp->u.iocb_cmd.u.ctarg.req,
-				  sp->u.iocb_cmd.u.ctarg.req_dma);
-		sp->u.iocb_cmd.u.ctarg.req = NULL;
-
-		dma_free_coherent(&vha->hw->pdev->dev,
-				  sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-				  sp->u.iocb_cmd.u.ctarg.rsp,
-				  sp->u.iocb_cmd.u.ctarg.rsp_dma);
-		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-
-		/* ref: INIT */
-		kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		return;
-	}
-
-	e->u.iosb.sp = sp;
-	qla2x00_post_work(vha, e);
-}
-
-/* Get WWPN with Nport ID. */
-int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
-{
-	int rval = QLA_FUNCTION_FAILED;
-	struct ct_sns_req       *ct_req;
-	srb_t *sp, *tsp;
-	struct ct_sns_pkt *ct_sns;
-	unsigned long flags;
-
-	if (!vha->flags.online)
-		goto done;
-
-	/* ref: INIT */
-	sp = qla2x00_get_sp(vha, NULL, GFP_KERNEL);
-	if (!sp)
-		goto done;
-
-	sp->type = SRB_CT_PTHRU_CMD;
-	sp->name = "gpnid";
-	sp->u.iocb_cmd.u.ctarg.id = *id;
-	sp->gen1 = 0;
-	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
-			      qla2x00_async_gpnid_sp_done);
-
-	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
-	list_for_each_entry(tsp, &vha->gpnid_list, elem) {
-		if (tsp->u.iocb_cmd.u.ctarg.id.b24 == id->b24) {
-			tsp->gen1++;
-			spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
-			/* ref: INIT */
-			kref_put(&sp->cmd_kref, qla2x00_sp_release);
-			goto done;
-		}
-	}
-	list_add_tail(&sp->elem, &vha->gpnid_list);
-	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
-
-	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
-		sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
-		GFP_KERNEL);
-	sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
-	if (!sp->u.iocb_cmd.u.ctarg.req) {
-		ql_log(ql_log_warn, vha, 0xd041,
-		    "Failed to allocate ct_sns request.\n");
-		goto done_free_sp;
-	}
-
-	sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
-		sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.rsp_dma,
-		GFP_KERNEL);
-	sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
-	if (!sp->u.iocb_cmd.u.ctarg.rsp) {
-		ql_log(ql_log_warn, vha, 0xd042,
-		    "Failed to allocate ct_sns request.\n");
-		goto done_free_sp;
-	}
-
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.rsp;
-	memset(ct_sns, 0, sizeof(*ct_sns));
-
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
-	/* CT_IU preamble  */
-	ct_req = qla2x00_prep_ct_req(ct_sns, GPN_ID_CMD, GPN_ID_RSP_SIZE);
-
-	/* GPN_ID req */
-	ct_req->req.port_id.port_id = port_id_to_be_id(*id);
-
-	sp->u.iocb_cmd.u.ctarg.req_size = GPN_ID_REQ_SIZE;
-	sp->u.iocb_cmd.u.ctarg.rsp_size = GPN_ID_RSP_SIZE;
-	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
-
-	ql_dbg(ql_dbg_disc, vha, 0x2067,
-	    "Async-%s hdl=%x ID %3phC.\n", sp->name,
-	    sp->handle, &ct_req->req.port_id.port_id);
-
-	rval = qla2x00_start_sp(sp);
-	if (rval != QLA_SUCCESS)
-		goto done_free_sp;
-
-	return rval;
-
-done_free_sp:
-	spin_lock_irqsave(&vha->hw->vport_slock, flags);
-	list_del(&sp->elem);
-	spin_unlock_irqrestore(&vha->hw->vport_slock, flags);
-
-	if (sp->u.iocb_cmd.u.ctarg.req) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-			sizeof(struct ct_sns_pkt),
-			sp->u.iocb_cmd.u.ctarg.req,
-			sp->u.iocb_cmd.u.ctarg.req_dma);
-		sp->u.iocb_cmd.u.ctarg.req = NULL;
-	}
-	if (sp->u.iocb_cmd.u.ctarg.rsp) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-			sizeof(struct ct_sns_pkt),
-			sp->u.iocb_cmd.u.ctarg.rsp,
-			sp->u.iocb_cmd.u.ctarg.rsp_dma);
-		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-	}
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
-done:
-	return rval;
-}
-
-
 void qla24xx_async_gffid_sp_done(srb_t *sp, int res)
 {
 	struct scsi_qla_host *vha = sp->vha;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index ca216b820b1c..c66a0106a7fc 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2323,7 +2323,7 @@ qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 			ea->fcport->login_pause = 1;
 
 			ql_dbg(ql_dbg_disc, vha, 0x20ed,
-			    "%s %d %8phC NPortId %06x inuse with loopid 0x%x. post gidpn\n",
+			    "%s %d %8phC NPortId %06x inuse with loopid 0x%x.\n",
 			    __func__, __LINE__, ea->fcport->port_name,
 			    ea->fcport->d_id.b24, lid);
 		} else {
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 6b91dcfd994d..9a7cc0ba5f58 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2920,7 +2920,7 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 					conflict_fcport->conflict = fcport;
 					fcport->login_pause = 1;
 					ql_dbg(ql_dbg_disc, vha, 0x20ed,
-					    "%s %d %8phC pid %06x inuse with lid %#x post gidpn\n",
+					    "%s %d %8phC pid %06x inuse with lid %#x.\n",
 					    __func__, __LINE__,
 					    fcport->port_name,
 					    fcport->d_id.b24, lid);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 078b63b89189..bbbdf2ffb682 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5016,7 +5016,6 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	INIT_LIST_HEAD(&vha->plogi_ack_list);
 	INIT_LIST_HEAD(&vha->qp_list);
 	INIT_LIST_HEAD(&vha->gnl.fcports);
-	INIT_LIST_HEAD(&vha->gpnid_list);
 	INIT_WORK(&vha->iocb_work, qla2x00_iocb_work_fn);
 
 	INIT_LIST_HEAD(&vha->purex_list.head);
@@ -5461,9 +5460,6 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 		case QLA_EVT_AENFX:
 			qlafx00_process_aen(vha, e);
 			break;
-		case QLA_EVT_GPNID:
-			qla24xx_async_gpnid(vha, &e->u.gpnid.id);
-			break;
 		case QLA_EVT_UNMAP:
 			qla24xx_sp_unmap(vha, e->u.iosb.sp);
 			break;
-- 
2.19.0.rc0

