Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0323EE61A
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Aug 2021 07:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbhHQFOa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 01:14:30 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54614 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237600AbhHQFOZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Aug 2021 01:14:25 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17H2m1BM006952
        for <linux-scsi@vger.kernel.org>; Mon, 16 Aug 2021 22:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=EmOwEWWiMDS0DXt1dppVheomoX82mzJMux5VxlN9Q90=;
 b=KvfhAjYhm2rGF02iV8MjZ5T6kgNEOiMPQ6fHLENcb4Psqy07FTuo/p64z1IgRzW9alx8
 BflY/nAhUVjcYOkJUNYBUdlrtWD+dWSzOUhi+uFoXg47DjoTQyuX35dXtBZxTTdAt9m9
 klPGatxhY28u4kBWAZXM5KRQ/IKrSUnkRVTF6RzNYKK04IchntNEdGvWeDtXLFOBc2LI
 xvHYXqDMzAqGSI+SZzQIhVV1/cFetoSyF4VC6fxlE0YO27DVmraEMuw7S15TVtLlJFA6
 6/4rStH2E+VejurSmsx8XzHq+Q8bSQF5VELhTnqI+4cyVxKdc2jokNyBJpcVFS56cL3r 0w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3ag4n0rdcu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 16 Aug 2021 22:13:52 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 16 Aug
 2021 22:13:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 16 Aug 2021 22:13:51 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 3B0443F70AC;
        Mon, 16 Aug 2021 22:13:51 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 17H5DpKG002532;
        Mon, 16 Aug 2021 22:13:51 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 17H5Dpfa002531;
        Mon, 16 Aug 2021 22:13:51 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 05/12] qla2xxx: edif: add N2N support for EDIF
Date:   Mon, 16 Aug 2021 22:13:08 -0700
Message-ID: <20210817051315.2477-6-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210817051315.2477-1-njavali@marvell.com>
References: <20210817051315.2477-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 9ncSEVi1reIDFq9NaZ8Ovf_a5f-0mQJE
X-Proofpoint-ORIG-GUID: 9ncSEVi1reIDFq9NaZ8Ovf_a5f-0mQJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-17_01,2021-08-16_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Please bring up your FW to latest (9.8.+) for EDIF + N2N to work.
Driver will pause after PLOGI to allow app to authenticate.
Once authentication completes, app will tell driver to do PRLI.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h    |   3 +
 drivers/scsi/qla2xxx/qla_edif.c   |  95 ++++++++++++++++++++-------
 drivers/scsi/qla2xxx/qla_edif.h   |   4 +-
 drivers/scsi/qla2xxx/qla_fw.h     |   1 +
 drivers/scsi/qla2xxx/qla_gbl.h    |   1 +
 drivers/scsi/qla2xxx/qla_init.c   | 105 ++++++++++++++++++++----------
 drivers/scsi/qla2xxx/qla_inline.h |  16 +++++
 drivers/scsi/qla2xxx/qla_iocb.c   |  14 +++-
 drivers/scsi/qla2xxx/qla_mbx.c    |   3 +-
 drivers/scsi/qla2xxx/qla_os.c     |   5 +-
 drivers/scsi/qla2xxx/qla_target.c |  53 ++++++++++++++-
 11 files changed, 234 insertions(+), 66 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 47e8762545e5..031107b6024f 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2633,6 +2633,7 @@ typedef struct fc_port {
 		uint64_t	rx_bytes;
 		uint8_t		non_secured_login;
 		uint8_t		auth_state;
+		uint16_t	authok:1;
 		uint16_t	rekey_cnt;
 		struct list_head edif_indx_list;
 		spinlock_t  indx_list_lock;
@@ -4023,6 +4024,7 @@ struct qla_hw_data {
 		uint32_t	scm_enabled:1;
 		uint32_t	edif_hw:1;
 		uint32_t	edif_enabled:1;
+		uint32_t	n2n_fw_acc_sec:1;
 		uint32_t	plogi_template_valid:1;
 		uint32_t	port_isolated:1;
 	} flags;
@@ -4720,6 +4722,7 @@ struct qla_hw_data {
 	struct list_head sadb_rx_index_list;
 	spinlock_t sadb_lock;	/* protects list */
 	struct els_reject elsrej;
+	u8 edif_post_stop_cnt_down;
 };
 
 #define RX_ELS_SIZE (roundup(sizeof(struct enode) + ELS_MAX_PAYLOAD, SMP_CACHE_BYTES))
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 555c38bea08a..bb5cda85b60f 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -546,31 +546,47 @@ qla_edif_app_start(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 		     __func__);
 	}
 
-	list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
-		ql_dbg(ql_dbg_edif, vha, 0xf084,
-		    "%s: sess %p %8phC lid %#04x s_id %06x logout %d\n",
-		    __func__, fcport, fcport->port_name,
-		    fcport->loop_id, fcport->d_id.b24,
-		    fcport->logout_on_delete);
-
-		ql_dbg(ql_dbg_edif, vha, 0xf084,
-		    "keep %d els_logo %d disc state %d auth state %d stop state %d\n",
-		    fcport->keep_nport_handle,
-		    fcport->send_els_logo, fcport->disc_state,
-		    fcport->edif.auth_state, fcport->edif.app_stop);
-
-		if (atomic_read(&vha->loop_state) == LOOP_DOWN)
-			break;
+	if (N2N_TOPO(vha->hw)) {
+		if (vha->hw->flags.n2n_fw_acc_sec)
+			set_bit(N2N_LINK_RESET, &vha->dpc_flags);
+		else
+			set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+	} else {
+		list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
+			ql_dbg(ql_dbg_edif, vha, 0xf084,
+			       "%s: sess %p %8phC lid %#04x s_id %06x logout %d\n",
+			       __func__, fcport, fcport->port_name,
+			       fcport->loop_id, fcport->d_id.b24,
+			       fcport->logout_on_delete);
+
+			ql_dbg(ql_dbg_edif, vha, 0xf084,
+			       "keep %d els_logo %d disc state %d auth state %d stop state %d\n",
+			       fcport->keep_nport_handle,
+			       fcport->send_els_logo, fcport->disc_state,
+			       fcport->edif.auth_state, fcport->edif.app_stop);
 
-		fcport->edif.app_started = 1;
-		fcport->edif.app_stop = 0;
+			if (atomic_read(&vha->loop_state) == LOOP_DOWN)
+				break;
+			if (!fcport->edif.secured_login)
+				continue;
 
-		ql_dbg(ql_dbg_edif, vha, 0x911e,
-		    "%s wwpn %8phC calling qla_edif_reset_auth_wait\n",
-		    __func__, fcport->port_name);
-		fcport->edif.app_sess_online = 1;
-		qla_edif_reset_auth_wait(fcport, DSC_LOGIN_PEND, 0);
-		qla_edif_sa_ctl_init(vha, fcport);
+			fcport->edif.app_started = 1;
+			if (fcport->edif.app_stop ||
+			    (fcport->disc_state != DSC_LOGIN_COMPLETE &&
+			     fcport->disc_state != DSC_LOGIN_PEND &&
+			     fcport->disc_state != DSC_DELETED)) {
+				/* no activity */
+				fcport->edif.app_stop = 0;
+
+				ql_dbg(ql_dbg_edif, vha, 0x911e,
+				       "%s wwpn %8phC calling qla_edif_reset_auth_wait\n",
+				       __func__, fcport->port_name);
+				fcport->edif.app_sess_online = 1;
+				qla_edif_reset_auth_wait(fcport, DSC_LOGIN_PEND, 0);
+			}
+			qla_edif_sa_ctl_init(vha, fcport);
+		}
 	}
 
 	if (vha->pur_cinfo.enode_flags != ENODE_ACTIVE) {
@@ -763,6 +779,7 @@ qla_edif_app_authok(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 
 	SET_DID_STATUS(bsg_reply->result, DID_OK);
 	appplogireply.prli_status = 1;
+	fcport->edif.authok = 1;
 	if (!(fcport->edif.rx_sa_set && fcport->edif.tx_sa_set)) {
 		ql_dbg(ql_dbg_edif, vha, 0x911e,
 		    "%s: wwpn %8phC Both SA indexes has not been SET TX %d, RX %d.\n",
@@ -929,8 +946,9 @@ qla_edif_app_getfcinfo(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 			app_reply->ports[pcnt].remote_pid = fcport->d_id;
 
 			ql_dbg(ql_dbg_edif, vha, 0x2058,
-			    "Found FC_SP fcport - nn %8phN pn %8phN pcnt %d portid=%06x\n",
-			    fcport->node_name, fcport->port_name, pcnt, fcport->d_id.b24);
+			    "Found FC_SP fcport - nn %8phN pn %8phN pcnt %d portid=%06x secure %d.\n",
+			    fcport->node_name, fcport->port_name, pcnt,
+			    fcport->d_id.b24, fcport->edif.secured_login);
 
 			switch (fcport->edif.auth_state) {
 			case VND_CMD_AUTH_STATE_ELS_RCVD:
@@ -2012,6 +2030,33 @@ qla_edb_getnext(scsi_qla_host_t *vha)
 	return edbnode;
 }
 
+void
+qla_edif_timer(scsi_qla_host_t *vha)
+{
+	struct qla_hw_data *ha = vha->hw;
+
+	if (!vha->vp_idx && N2N_TOPO(ha) && ha->flags.n2n_fw_acc_sec) {
+		if (vha->e_dbell.db_flags != EDB_ACTIVE &&
+		    ha->edif_post_stop_cnt_down) {
+			ha->edif_post_stop_cnt_down--;
+
+			/*
+			 * turn off auto 'Plogi Acc + secure=1' feature
+			 * Set Add FW option[3]
+			 * BIT_15, if.
+			 */
+			if (ha->edif_post_stop_cnt_down == 0) {
+				ql_dbg(ql_dbg_async, vha, 0x911d,
+				       "%s chip reset to turn off PLOGI ACC + secure\n",
+				       __func__);
+				set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+			}
+		} else {
+			ha->edif_post_stop_cnt_down = 60;
+		}
+	}
+}
+
 /*
  * app uses separate thread to read this. It'll wait until the doorbell
  * is rung by the driver or the max wait time has expired
diff --git a/drivers/scsi/qla2xxx/qla_edif.h b/drivers/scsi/qla2xxx/qla_edif.h
index 9384765460cf..9e8f28d0caa1 100644
--- a/drivers/scsi/qla2xxx/qla_edif.h
+++ b/drivers/scsi/qla2xxx/qla_edif.h
@@ -129,8 +129,8 @@ struct enode {
 };
 
 #define EDIF_SESSION_DOWN(_s) \
-	(_s->disc_state == DSC_DELETE_PEND || \
+	(qla_ini_mode_enabled(_s->vha) && (_s->disc_state == DSC_DELETE_PEND || \
 	 _s->disc_state == DSC_DELETED || \
-	 !_s->edif.app_sess_online)
+	 !_s->edif.app_sess_online))
 
 #endif	/* __QLA_EDIF_H */
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index c257af8d87fd..073d06e88c58 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -810,6 +810,7 @@ struct els_entry_24xx {
 #define EPD_RX_XCHG		(3 << 13)
 #define ECF_CLR_PASSTHRU_PEND	BIT_12
 #define ECF_INCL_FRAME_HDR	BIT_11
+#define ECF_SEC_LOGIN		BIT_3
 
 	union {
 		struct {
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 2b8bdb146a8f..1c3f055d41b8 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -990,6 +990,7 @@ void qla_enode_init(scsi_qla_host_t *vha);
 void qla_enode_stop(scsi_qla_host_t *vha);
 void qla_edif_flush_sa_ctl_lists(fc_port_t *fcport);
 void qla_edb_init(scsi_qla_host_t *vha);
+void qla_edif_timer(scsi_qla_host_t *vha);
 int qla28xx_start_scsi_edif(srb_t *sp);
 void qla24xx_sa_update_iocb(srb_t *sp, struct sa_update_28xx *sa_update_iocb);
 void qla24xx_sa_replace_iocb(srb_t *sp, struct sa_update_28xx *sa_update_iocb);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 4b9350f79eb8..4c5acfde0788 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -292,22 +292,6 @@ static void qla2x00_async_login_sp_done(srb_t *sp, int res)
 	sp->free(sp);
 }
 
-static inline bool
-fcport_is_smaller(fc_port_t *fcport)
-{
-	if (wwn_to_u64(fcport->port_name) <
-	    wwn_to_u64(fcport->vha->port_name))
-		return true;
-	else
-		return false;
-}
-
-static inline bool
-fcport_is_bigger(fc_port_t *fcport)
-{
-	return !fcport_is_smaller(fcport);
-}
-
 int
 qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
     uint16_t *data)
@@ -818,7 +802,7 @@ static void qla24xx_handle_gnl_done_event(scsi_qla_host_t *vha,
 		default:
 			switch (current_login_state) {
 			case DSC_LS_PRLI_COMP:
-				ql_dbg(ql_dbg_disc + ql_dbg_verbose,
+				ql_dbg(ql_dbg_disc,
 				    vha, 0x20e4, "%s %d %8phC post gpdb\n",
 				    __func__, __LINE__, fcport->port_name);
 
@@ -864,6 +848,7 @@ static void qla24xx_handle_gnl_done_event(scsi_qla_host_t *vha,
 				 */
 				qla2x00_set_fcport_disc_state(fcport,
 				    DSC_DELETED);
+				set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
 				break;
 			case DSC_LS_PRLI_COMP:
 				if ((e->prli_svc_param_word_3[0] & BIT_4) == 0)
@@ -876,6 +861,12 @@ static void qla24xx_handle_gnl_done_event(scsi_qla_host_t *vha,
 				    data);
 				break;
 			case DSC_LS_PLOGI_COMP:
+				if (vha->hw->flags.edif_enabled &&
+				    vha->e_dbell.db_flags & EDB_ACTIVE) {
+					/* check to see if App support secure or not */
+					qla24xx_post_gpdb_work(vha, fcport, 0);
+					break;
+				}
 				if (fcport_is_bigger(fcport)) {
 					/* local adapter is smaller */
 					if (fcport->loop_id != FC_NO_LOOP_ID)
@@ -1229,7 +1220,7 @@ static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 	struct event_arg ea;
 
 	ql_dbg(ql_dbg_disc, vha, 0x2129,
-	    "%s %8phC res %d \n", __func__,
+	    "%s %8phC res %x\n", __func__,
 	    sp->fcport->port_name, res);
 
 	sp->fcport->flags &= ~FCF_ASYNC_SENT;
@@ -1242,6 +1233,8 @@ static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 		ea.iop[0] = lio->u.logio.iop[0];
 		ea.iop[1] = lio->u.logio.iop[1];
 		ea.sp = sp;
+		if (res == QLA_OS_TIMER_EXPIRED)
+			ea.data[0] = QLA_OS_TIMER_EXPIRED;
 
 		qla24xx_handle_prli_done_event(vha, &ea);
 	}
@@ -1453,7 +1446,7 @@ static int	qla_chk_secure_login(scsi_qla_host_t	*vha, fc_port_t *fcport,
 		fcport->edif.non_secured_login = 1;
 	}
 	if (vha->hw->flags.edif_enabled) {
-		if (fcport->flags & FCF_FCSP_DEVICE) {
+		if (fcport->edif.secured_login) {
 			qla2x00_set_fcport_disc_state(fcport, DSC_LOGIN_AUTH_PEND);
 			/* Start edif prli timer & ring doorbell for app */
 			fcport->edif.rx_sa_set = 0;
@@ -1476,7 +1469,7 @@ static int	qla_chk_secure_login(scsi_qla_host_t	*vha, fc_port_t *fcport,
 			}
 
 			rc = 1;
-		} else {
+		} else if (qla_ini_mode_enabled(vha) || qla_dual_mode_enabled(vha)) {
 			ql_dbg(ql_dbg_disc, vha, 0x2117,
 			    "%s %d %8phC post prli\n",
 			    __func__, __LINE__, fcport->port_name);
@@ -1500,12 +1493,15 @@ void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	fcport->flags &= ~FCF_ASYNC_SENT;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d2,
-	    "%s %8phC DS %d LS %d fc4_type %x rc %d\n", __func__,
+	    "%s %8phC DS %d LS %x fc4_type %x rc %x\n", __func__,
 	    fcport->port_name, fcport->disc_state, pd->current_login_state,
 	    fcport->fc4_type, ea->rc);
 
-	if (fcport->disc_state == DSC_DELETE_PEND)
+	if (fcport->disc_state == DSC_DELETE_PEND) {
+		ql_dbg(ql_dbg_disc, vha, 0x20d5, "%s %d %8phC\n",
+		       __func__, __LINE__, fcport->port_name);
 		return;
+	}
 
 	if (NVME_TARGET(vha->hw, fcport))
 		ls = pd->current_login_state >> 4;
@@ -1522,6 +1518,8 @@ void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	} else if (ea->sp->gen1 != fcport->rscn_gen) {
 		qla_rscn_replay(fcport);
 		qlt_schedule_sess_for_deletion(fcport);
+		ql_dbg(ql_dbg_disc, vha, 0x20d5, "%s %d %8phC, ls %x\n",
+		       __func__, __LINE__, fcport->port_name, ls);
 		return;
 	}
 
@@ -1530,8 +1528,11 @@ void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 		__qla24xx_parse_gpdb(vha, fcport, pd);
 		break;
 	case PDS_PLOGI_COMPLETE:
-		if (qla_chk_secure_login(vha, fcport, pd))
+		if (qla_chk_secure_login(vha, fcport, pd)) {
+			ql_dbg(ql_dbg_disc, vha, 0x20d5, "%s %d %8phC, ls %x\n",
+			       __func__, __LINE__, fcport->port_name, ls);
 			return;
+		}
 		fallthrough;
 	case PDS_PLOGI_PENDING:
 	case PDS_PRLI_PENDING:
@@ -1542,6 +1543,8 @@ void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 			qla2x00_set_fcport_disc_state(fcport, DSC_GNL);
 			set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
 		}
+		ql_dbg(ql_dbg_disc, vha, 0x20d5, "%s %d %8phC, ls %x\n",
+		       __func__, __LINE__, fcport->port_name, ls);
 		return;
 	case PDS_LOGO_PENDING:
 	case PDS_PORT_UNAVAILABLE:
@@ -1836,6 +1839,13 @@ void qla24xx_handle_relogin_event(scsi_qla_host_t *vha,
 void qla_handle_els_plogi_done(scsi_qla_host_t *vha,
 				      struct event_arg *ea)
 {
+	if (N2N_TOPO(vha->hw) && fcport_is_smaller(ea->fcport) &&
+	    vha->hw->flags.edif_enabled) {
+		/* check to see if App support Secure */
+		qla24xx_post_gpdb_work(vha, ea->fcport, 0);
+		return;
+	}
+
 	/* for pure Target Mode, PRLI will not be initiated */
 	if (vha->host->active_mode == MODE_TARGET)
 		return;
@@ -2026,12 +2036,12 @@ qla24xx_handle_prli_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 		       "FCP" : "NVMe", ea->fcport->fc4_type);
 
 		if (N2N_TOPO(vha->hw)) {
-			if (vha->hw->fc4_type_priority == FC4_PRIORITY_NVME) {
-				ea->fcport->fc4_type &= ~FS_FC4TYPE_NVME;
-				ea->fcport->fc4_type |= FS_FC4TYPE_FCP;
-			} else {
+			if (vha->hw->fc4_type_priority == FC4_PRIORITY_FCP) {
 				ea->fcport->fc4_type &= ~FS_FC4TYPE_FCP;
 				ea->fcport->fc4_type |= FS_FC4TYPE_NVME;
+			} else {
+				ea->fcport->fc4_type &= ~FS_FC4TYPE_NVME;
+				ea->fcport->fc4_type |= FS_FC4TYPE_FCP;
 			}
 
 			if (ea->fcport->n2n_link_reset_cnt < 3) {
@@ -2042,6 +2052,7 @@ qla24xx_handle_prli_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 				 * state machine
 				 */
 				set_bit(N2N_LINK_RESET, &vha->dpc_flags);
+				qla2xxx_wake_dpc(vha);
 			} else {
 				ql_log(ql_log_warn, vha, 0x2119,
 				       "%s %d %8phC Unable to reconnect\n",
@@ -4172,13 +4183,26 @@ qla24xx_update_fw_options(scsi_qla_host_t *vha)
 		    qla_dual_mode_enabled(vha))
 			ha->fw_options[2] |= BIT_4;
 		else
-			ha->fw_options[2] &= ~BIT_4;
+			ha->fw_options[2] &= ~(BIT_4);
 
 		/* Reserve 1/2 of emergency exchanges for ELS.*/
 		if (qla2xuseresexchforels)
 			ha->fw_options[2] |= BIT_8;
 		else
 			ha->fw_options[2] &= ~BIT_8;
+
+		/*
+		 * N2N: set Secure=1 for PLOGI ACC and
+		 * fw shal not send PRLI after PLOGI Acc
+		 */
+		if (ha->flags.edif_enabled &&
+		    vha->e_dbell.db_flags & EDB_ACTIVE) {
+			ha->fw_options[3] |= BIT_15;
+			ha->flags.n2n_fw_acc_sec = 1;
+		} else {
+			ha->fw_options[3] &= ~BIT_15;
+			ha->flags.n2n_fw_acc_sec = 0;
+		}
 	}
 
 	if (ql2xrdpenable || ha->flags.scm_supported_f ||
@@ -4381,8 +4405,6 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
 
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
-	ql_dbg(ql_dbg_init, vha, 0x00d1, "Issue init firmware.\n");
-
 	if (IS_QLAFX00(ha)) {
 		rval = qlafx00_init_firmware(vha, ha->init_cb_size);
 		goto next_check;
@@ -4391,6 +4413,12 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
 	/* Update any ISP specific firmware options before initialization. */
 	ha->isp_ops->update_fw_options(vha);
 
+	ql_dbg(ql_dbg_init, vha, 0x00d1,
+	       "Issue init firmware FW opt 1-3= %08x %08x %08x.\n",
+	       le32_to_cpu(mid_init_cb->init_cb.firmware_options_1),
+	       le32_to_cpu(mid_init_cb->init_cb.firmware_options_2),
+	       le32_to_cpu(mid_init_cb->init_cb.firmware_options_3));
+
 	if (ha->flags.npiv_supported) {
 		if (ha->operating_mode == LOOP && !IS_CNA_CAPABLE(ha))
 			ha->max_npiv_vports = MIN_MULTI_ID_FABRIC - 1;
@@ -4671,7 +4699,10 @@ qla2x00_configure_hba(scsi_qla_host_t *vha)
 	id.b.al_pa = al_pa;
 	id.b.rsvd_1 = 0;
 	spin_lock_irqsave(&ha->hardware_lock, flags);
-	if (!(topo == 2 && ha->flags.n2n_bigger))
+	if (vha->hw->flags.edif_enabled) {
+		if (topo != 2)
+			qlt_update_host_map(vha, id);
+	} else if (!(topo == 2 && ha->flags.n2n_bigger))
 		qlt_update_host_map(vha, id);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
@@ -5313,9 +5344,13 @@ qla2x00_configure_loop(scsi_qla_host_t *vha)
 			    "LOOP READY.\n");
 			ha->flags.fw_init_done = 1;
 
-			if (vha->hw->flags.edif_enabled &&
-			    vha->e_dbell.db_flags != EDB_ACTIVE) {
-				/* wake up authentication app to get ready */
+			if (ha->flags.edif_enabled &&
+			    !(vha->e_dbell.db_flags & EDB_ACTIVE) &&
+			    N2N_TOPO(vha->hw)) {
+				/*
+				 * use port online to wake up app to get ready
+				 * for authentication
+				 */
 				qla2x00_post_aen_work(vha, FCH_EVT_PORT_ONLINE, 0);
 			}
 
@@ -5359,6 +5394,8 @@ static int qla2x00_configure_n2n_loop(scsi_qla_host_t *vha)
 	unsigned long flags;
 	fc_port_t *fcport;
 
+	ql_dbg(ql_dbg_disc, vha, 0x206a, "%s %d.\n", __func__, __LINE__);
+
 	if (test_and_clear_bit(N2N_LOGIN_NEEDED, &vha->dpc_flags))
 		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
 
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 82937c6bd9c4..5f3b7995cc8f 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -478,3 +478,19 @@ bool qla_pci_disconnected(struct scsi_qla_host *vha,
 	}
 	return ret;
 }
+
+static inline bool
+fcport_is_smaller(fc_port_t *fcport)
+{
+	if (wwn_to_u64(fcport->port_name) <
+		wwn_to_u64(fcport->vha->port_name))
+		return true;
+	else
+		return false;
+}
+
+static inline bool
+fcport_is_bigger(fc_port_t *fcport)
+{
+	return !fcport_is_smaller(fcport);
+}
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 625d6b237fb2..eef1fa2b45c2 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2745,7 +2745,10 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
 	els_iocb->s_id[0] = vha->d_id.b.domain;
 
 	if (elsio->u.els_logo.els_cmd == ELS_DCMD_PLOGI) {
-		els_iocb->control_flags = 0;
+		if (vha->hw->flags.edif_enabled)
+			els_iocb->control_flags = cpu_to_le16(ECF_SEC_LOGIN);
+		else
+			els_iocb->control_flags = 0;
 		els_iocb->tx_byte_count = els_iocb->tx_len =
 			cpu_to_le32(sizeof(struct els_plogi_payload));
 		put_unaligned_le64(elsio->u.els_plogi.els_plogi_pyld_dma,
@@ -2985,7 +2988,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	qla2x00_set_fcport_disc_state(fcport, DSC_LOGIN_PEND);
 	elsio = &sp->u.iocb_cmd;
 	ql_dbg(ql_dbg_io, vha, 0x3073,
-	    "Enter: PLOGI portid=%06x\n", fcport->d_id.b24);
+	       "%s Enter: PLOGI portid=%06x\n", __func__, fcport->d_id.b24);
 
 	sp->type = SRB_ELS_DCMD;
 	sp->name = "ELS_DCMD";
@@ -3028,6 +3031,13 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	elsio->u.els_plogi.els_cmd = els_opcode;
 	elsio->u.els_plogi.els_plogi_pyld->opcode = els_opcode;
 
+	if (els_opcode == ELS_DCMD_PLOGI && vha->hw->flags.edif_enabled &&
+	    vha->e_dbell.db_flags & EDB_ACTIVE) {
+		struct fc_els_flogi *p = ptr;
+
+		p->fl_csp.sp_features |= cpu_to_be16(FC_SP_FT_SEC);
+	}
+
 	ql_dbg(ql_dbg_disc + ql_dbg_buffer, vha, 0x3073, "PLOGI buffer:\n");
 	ql_dump_buffer(ql_dbg_disc + ql_dbg_buffer, vha, 0x0109,
 	    (uint8_t *)elsio->u.els_plogi.els_plogi_pyld,
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 154e211bd4bf..2964f5280bed 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -1141,7 +1141,7 @@ qla2x00_get_fw_version(scsi_qla_host_t *vha)
 		if (IS_QLA28XX(ha) && ha->flags.edif_hw && ql2xsecenable &&
 		    (ha->fw_attributes_ext[0] & FW_ATTR_EXT0_EDIF)) {
 			ha->flags.edif_enabled = 1;
-			ql_log(ql_log_info + ql_dbg_edif, vha, 0xffff,
+			ql_log(ql_log_info, vha, 0xffff,
 			       "%s: edif is enabled\n", __func__);
 		}
 	}
@@ -4049,6 +4049,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 				fcport->scan_state = QLA_FCPORT_FOUND;
 				fcport->n2n_flag = 1;
 				fcport->keep_nport_handle = 1;
+				fcport->login_retry = vha->hw->login_retry_count;
 
 				if (wwn_to_u64(vha->port_name) >
 				    wwn_to_u64(fcport->port_name)) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 94e12a398d7f..bc8abe226fa6 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3964,7 +3964,6 @@ void qla2x00_mark_device_lost(scsi_qla_host_t *vha, fc_port_t *fcport,
 		qla2x00_schedule_rport_del(vha, fcport);
 	}
 
-	qla_edif_sess_down(vha, fcport);
 	/*
 	 * We may need to retry the login, so don't change the state of the
 	 * port but do the retries.
@@ -7343,6 +7342,10 @@ qla2x00_timer(struct timer_list *t)
 		}
 	}
 
+	/* check if edif running */
+	if (vha->hw->flags.edif_enabled)
+		qla_edif_timer(vha);
+
 	/* Process any deferred work. */
 	if (!list_empty(&vha->work_list)) {
 		unsigned long flags;
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index c3a589659658..2f4da88995ea 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -638,6 +638,7 @@ int qla24xx_async_notify_ack(scsi_qla_host_t *vha, fc_port_t *fcport,
 		if (vha->hw->flags.edif_enabled &&
 		    (le16_to_cpu(ntfy->u.isp24.flags) & NOTIFY24XX_FLAGS_FCSP)) {
 			fcport->flags |= FCF_FCSP_DEVICE;
+			fcport->edif.secured_login = 1;
 		}
 		break;
 	case SRB_NACK_PRLI:
@@ -937,6 +938,11 @@ qlt_send_first_logo(struct scsi_qla_host *vha, qlt_port_logo_t *logo)
 	qlt_port_logo_t *tmp;
 	int res;
 
+	if (test_bit(PFLG_DRIVER_REMOVING, &vha->pci_flags)) {
+		res = 0;
+		goto out;
+	}
+
 	mutex_lock(&vha->vha_tgt.tgt_mutex);
 
 	list_for_each_entry(tmp, &vha->logo_list, list) {
@@ -957,6 +963,7 @@ qlt_send_first_logo(struct scsi_qla_host *vha, qlt_port_logo_t *logo)
 	list_del(&logo->list);
 	mutex_unlock(&vha->vha_tgt.tgt_mutex);
 
+out:
 	ql_dbg(ql_dbg_tgt_mgt, vha, 0xf098,
 	    "Finished LOGO to %02x:%02x:%02x, dropped %d cmds, res = %#x\n",
 	    logo->id.b.domain, logo->id.b.area, logo->id.b.al_pa,
@@ -987,6 +994,7 @@ void qlt_free_session_done(struct work_struct *work)
 	if (!IS_SW_RESV_ADDR(sess->d_id)) {
 		if (ha->flags.edif_enabled &&
 		    (!own || own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
+			sess->edif.authok = 0;
 			if (!ha->flags.host_shutting_down) {
 				ql_dbg(ql_dbg_edif, vha, 0x911e,
 					"%s wwpn %8phC calling qla2x00_release_all_sadb\n",
@@ -997,6 +1005,7 @@ void qlt_free_session_done(struct work_struct *work)
 					"%s bypassing release_all_sadb\n",
 					__func__);
 			}
+			qla_edif_sess_down(vha, sess);
 		}
 		qla2x00_mark_device_lost(vha, sess, 0);
 
@@ -4808,6 +4817,23 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 		goto out;
 	}
 
+	if (vha->hw->flags.edif_enabled) {
+		if (!(vha->e_dbell.db_flags & EDB_ACTIVE)) {
+			ql_dbg(ql_dbg_disc, vha, 0xffff,
+			       "%s %d Term INOT due to app not started lid=%d, NportID %06X ",
+			       __func__, __LINE__, loop_id, port_id.b24);
+			qlt_send_term_imm_notif(vha, iocb, 1);
+			goto out;
+		} else if (iocb->u.isp24.status_subcode == ELS_PLOGI &&
+			   !(le16_to_cpu(iocb->u.isp24.flags) & NOTIFY24XX_FLAGS_FCSP)) {
+			ql_dbg(ql_dbg_disc, vha, 0xffff,
+			       "%s %d Term INOT due to unsecure lid=%d, NportID %06X ",
+			       __func__, __LINE__, loop_id, port_id.b24);
+			qlt_send_term_imm_notif(vha, iocb, 1);
+			goto out;
+		}
+	}
+
 	pla = qlt_plogi_ack_find_add(vha, &port_id, iocb);
 	if (!pla) {
 		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
@@ -4876,6 +4902,10 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 	sess->loop_id = loop_id;
 
 	if (iocb->u.isp24.status_subcode == ELS_PLOGI) {
+		/* remote port has assigned Port ID */
+		if (N2N_TOPO(vha->hw) && fcport_is_bigger(sess))
+			vha->d_id = sess->d_id;
+
 		ql_dbg(ql_dbg_disc, vha, 0xffff,
 		    "%s %8phC - send port online\n",
 		    __func__, sess->port_name);
@@ -4995,6 +5025,16 @@ static int qlt_24xx_handle_els(struct scsi_qla_host *vha,
 			sess = qla2x00_find_fcport_by_wwpn(vha,
 			    iocb->u.isp24.port_name, 1);
 
+			if (vha->hw->flags.edif_enabled && sess &&
+			    (!(sess->flags & FCF_FCSP_DEVICE) ||
+			     !sess->edif.authok)) {
+				ql_dbg(ql_dbg_disc, vha, 0xffff,
+				       "%s %d %8phC Term PRLI due to unauthorize PRLI\n",
+				       __func__, __LINE__, iocb->u.isp24.port_name);
+				qlt_send_term_imm_notif(vha, iocb, 1);
+				break;
+			}
+
 			if (sess && sess->plogi_link[QLT_PLOGI_LINK_SAME_WWN]) {
 				ql_dbg(ql_dbg_disc, vha, 0xffff,
 				    "%s %d %8phC Term PRLI due to PLOGI ACK not completed\n",
@@ -5043,6 +5083,16 @@ static int qlt_24xx_handle_els(struct scsi_qla_host *vha,
 			bool delete = false;
 			int sec;
 
+			if (vha->hw->flags.edif_enabled && sess &&
+			    (!(sess->flags & FCF_FCSP_DEVICE) ||
+			     !sess->edif.authok)) {
+				ql_dbg(ql_dbg_disc, vha, 0xffff,
+				       "%s %d %8phC Term PRLI due to unauthorize prli\n",
+				       __func__, __LINE__, iocb->u.isp24.port_name);
+				qlt_send_term_imm_notif(vha, iocb, 1);
+				break;
+			}
+
 			spin_lock_irqsave(&tgt->ha->tgt.sess_lock, flags);
 			switch (sess->fw_login_state) {
 			case DSC_LS_PLOGI_PEND:
@@ -5232,7 +5282,8 @@ static int qlt_24xx_handle_els(struct scsi_qla_host *vha,
 }
 
 /*
- * ha->hardware_lock supposed to be held on entry. Might drop it, then reaquire
+ * ha->hardware_lock supposed to be held on entry.
+ * Might drop it, then reacquire.
  */
 static void qlt_handle_imm_notify(struct scsi_qla_host *vha,
 	struct imm_ntfy_from_isp *iocb)
-- 
2.23.1

