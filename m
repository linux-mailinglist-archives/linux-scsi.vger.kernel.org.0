Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD63B1816
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Jun 2021 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFWKbq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Jun 2021 06:31:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3318 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230030AbhFWKbp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 23 Jun 2021 06:31:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NAMY97027657
        for <linux-scsi@vger.kernel.org>; Wed, 23 Jun 2021 03:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=7F3CINWZJIPO2bOOAztqNImFCaLlQusf2ph8WtjdM1A=;
 b=Kwu9UCylvk6tSpmeMvwA43IdARwBOTI10r/fFFMfGyDLWyI27k1GLFQCIvfXGPEXxc6K
 00LX9GBuywPpV1vkDAM0nIIqGKNeQ+UYsuk4CGcl+tyy1kPIAISQTAO+z56VkJ+ijuBU
 FaNcoIsJZUXtW8wS/6ZaJs1heoQRGlt0lZcH9Nw+OPfieyI6hmcRiGupz/z8fUNk7vES
 C+q+RQ1Hlv+ukKPJaKIbL9IEr1QCwrCn7ClAH4lSfxbf/qwm/642THWmFppGXJcnP8Nh
 MsldgwT2rAdIGIDutR9u4MnffMiyIUuHvgN3Vk6shMhhpCpDvvEIS+EVf0t/FttLJgZf jA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 39bptj2j8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 23 Jun 2021 03:29:27 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Jun
 2021 03:29:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 23 Jun 2021 03:29:24 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 2196F5B6938;
        Wed, 23 Jun 2021 03:29:25 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 15NATO1U003724;
        Wed, 23 Jun 2021 03:29:24 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 15NATOvb003723;
        Wed, 23 Jun 2021 03:29:24 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v3 07/11] qla2xxx: Add detection of secure device
Date:   Wed, 23 Jun 2021 03:26:07 -0700
Message-ID: <20210623102611.3637-8-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210623102611.3637-1-njavali@marvell.com>
References: <20210623102611.3637-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DMm_DQ3i8zS1LI5knasWZOeyQ1cgsqvi
X-Proofpoint-GUID: DMm_DQ3i8zS1LI5knasWZOeyQ1cgsqvi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-23_03:2021-06-23,2021-06-23 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Latest FC adapter from Marvell has the ability to encrypt
data in flight (EDIF) feature. This feature require an
application (ex: ipsec, etc) to act as an authenticator.

At this time, there is no FC switch scan service that
indicate a device is secure or non-secure.

In order to detect whether the remote port support secured
or not, driver must first do a PLOGI with the remote device.
On completion of the PLOGI, driver will query FW to see if
the device supports secure login. To do that, driver + FW
must advertise the security bit via PLOGI's service
parameter. The remote device shall respond with the same
service parameter bit on whether it supports it or not.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Larry Wisneski <Larry.Wisneski@marvell.com>
Signed-off-by: Duane Grigsby <duane.grigsby@marvell.com>
Signed-off-by: Rick Hicksted Jr <rhicksted@marvell.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h    |   5 +-
 drivers/scsi/qla2xxx/qla_edif.c   |  31 +++++++
 drivers/scsi/qla2xxx/qla_fw.h     |   8 +-
 drivers/scsi/qla2xxx/qla_gbl.h    |   3 +
 drivers/scsi/qla2xxx/qla_gs.c     |   4 +
 drivers/scsi/qla2xxx/qla_init.c   | 141 +++++++++++++++++++++++++-----
 drivers/scsi/qla2xxx/qla_iocb.c   |  17 +++-
 drivers/scsi/qla2xxx/qla_isr.c    |   4 +
 drivers/scsi/qla2xxx/qla_mbx.c    |   6 ++
 drivers/scsi/qla2xxx/qla_mid.c    |   7 +-
 drivers/scsi/qla2xxx/qla_os.c     |  19 ++++
 drivers/scsi/qla2xxx/qla_target.c |  61 ++++++++++++-
 drivers/scsi/qla2xxx/qla_target.h |   1 +
 13 files changed, 279 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 3e4c4cfbf7d4..af0e8be0eb9b 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -492,6 +492,7 @@ struct srb_iocb {
 #define SRB_LOGIN_SKIP_PRLI	BIT_2
 #define SRB_LOGIN_NVME_PRLI	BIT_3
 #define SRB_LOGIN_PRLI_ONLY	BIT_4
+#define SRB_LOGIN_FCSP		BIT_5
 			uint16_t data[2];
 			u32 iop[2];
 		} logio;
@@ -2343,6 +2344,7 @@ struct imm_ntfy_from_isp {
 			__le16	nport_handle;
 			uint16_t reserved_2;
 			__le16	flags;
+#define NOTIFY24XX_FLAGS_FCSP		BIT_5
 #define NOTIFY24XX_FLAGS_GLOBAL_TPRLO   BIT_1
 #define NOTIFY24XX_FLAGS_PUREX_IOCB     BIT_0
 			__le16	srr_rx_id;
@@ -2682,7 +2684,8 @@ static const char * const port_dstate_str[] = {
 	"UPD_FCPORT",
 	"LOGIN_COMPLETE",
 	"ADISC",
-	"DELETE_PEND"
+	"DELETE_PEND",
+	"LOGIN_AUTH_PEND",
 };
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 8f486bd1201f..51f96f5882af 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -2366,6 +2366,26 @@ qla28xx_sa_update_iocb_entry(scsi_qla_host_t *v, struct req_que *req,
 	sp->done(sp, 0);
 }
 
+/**********************************************
+ * edif update/delete sa_index list functions *
+ **********************************************/
+
+/* clear the edif_indx_list for this port */
+void qla_edif_list_del(fc_port_t *fcport)
+{
+	struct edif_list_entry *indx_lst;
+	struct edif_list_entry *tindx_lst;
+	struct list_head *indx_list = &fcport->edif.edif_indx_list;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&fcport->edif.indx_list_lock, flags);
+	list_for_each_entry_safe(indx_lst, tindx_lst, indx_list, next) {
+		list_del(&indx_lst->next);
+		kfree(indx_lst);
+	}
+	spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+}
+
 /******************
  * SADB functions *
  ******************/
@@ -2791,3 +2811,14 @@ int qla_edif_process_els(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 done:
 	return rval;
 }
+
+void qla_edif_sess_down(struct scsi_qla_host *vha, struct fc_port *sess)
+{
+	if (sess->edif.app_sess_online && vha->e_dbell.db_flags & EDB_ACTIVE) {
+		ql_dbg(ql_dbg_disc, vha, 0xf09c,
+			"%s: sess %8phN send port_offline event\n",
+			__func__, sess->port_name);
+		sess->edif.app_sess_online = 0;
+		qla2x00_post_aen_work(vha, FCH_EVT_PORT_OFFLINE, sess->d_id.b24);
+	}
+}
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index c067cd202dc4..4934b08a8990 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -82,10 +82,11 @@ struct port_database_24xx {
 	uint8_t port_name[WWN_SIZE];
 	uint8_t node_name[WWN_SIZE];
 
-	uint8_t reserved_3[4];
+	uint8_t reserved_3[2];
+	uint16_t nvme_first_burst_size;
 	uint16_t prli_nvme_svc_param_word_0;	/* Bits 15-0 of word 0 */
 	uint16_t prli_nvme_svc_param_word_3;	/* Bits 15-0 of word 3 */
-	uint16_t nvme_first_burst_size;
+	uint8_t secure_login;
 	uint8_t reserved_4[14];
 };
 
@@ -897,6 +898,7 @@ struct logio_entry_24xx {
 #define LCF_FCP2_OVERRIDE	BIT_9	/* Set/Reset word 3 of PRLI. */
 #define LCF_CLASS_2		BIT_8	/* Enable class 2 during PLOGI. */
 #define LCF_FREE_NPORT		BIT_7	/* Release NPORT handle after LOGO. */
+#define LCF_COMMON_FEAT		BIT_7	/* PLOGI - Set Common Features Field */
 #define LCF_EXPL_LOGO		BIT_6	/* Perform an explicit LOGO. */
 #define LCF_NVME_PRLI		BIT_6   /* Perform NVME FC4 PRLI */
 #define LCF_SKIP_PRLI		BIT_5	/* Skip PRLI after PLOGI. */
@@ -921,6 +923,8 @@ struct logio_entry_24xx {
 	uint8_t rsp_size;		/* Response size in 32bit words. */
 
 	__le32	io_parameter[11];	/* General I/O parameters. */
+#define LIO_COMM_FEAT_FCSP	BIT_21
+#define LIO_COMM_FEAT_CIO	BIT_31
 #define LSC_SCODE_NOLINK	0x01
 #define LSC_SCODE_NOIOCB	0x02
 #define LSC_SCODE_NOXCB		0x03
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index d9d554101788..61b0164ac283 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -131,6 +131,7 @@ void qla24xx_free_purex_item(struct purex_item *item);
 extern bool qla24xx_risc_firmware_invalid(uint32_t *);
 void qla_init_iocb_limit(scsi_qla_host_t *);
 
+void qla_edif_list_del(fc_port_t *fcport);
 void qla_edif_sadb_release(struct qla_hw_data *ha);
 int qla_edif_sadb_build_free_pool(struct qla_hw_data *ha);
 void qla_edif_sadb_release_free_pool(struct qla_hw_data *ha);
@@ -138,7 +139,9 @@ void qla_chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha,
 		srb_t *sp, struct sts_entry_24xx *sts24);
 void qlt_chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha, fc_port_t *fcport,
 		struct ctio7_from_24xx *ctio);
+void qla2x00_release_all_sadb(struct scsi_qla_host *vha, struct fc_port *fcport);
 int qla_edif_process_els(scsi_qla_host_t *vha, struct bsg_job *bsgjob);
+void qla_edif_sess_down(struct scsi_qla_host *vha, struct fc_port *sess);
 const char *sc_to_str(uint16_t cmd);
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 5b6e04a91a18..99fb330053ae 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -2826,6 +2826,10 @@ void qla24xx_handle_gpsc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	if (fcport->disc_state == DSC_DELETE_PEND)
 		return;
 
+	/* We will figure-out what happen after AUTH completes */
+	if (fcport->disc_state == DSC_LOGIN_AUTH_PEND)
+		return;
+
 	if (ea->sp->gen2 != fcport->login_gen) {
 		/* target side must have changed it. */
 		ql_dbg(ql_dbg_disc, vha, 0x20d3,
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 71f6c76be401..22474baf57aa 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -342,10 +342,22 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
 
 	sp->done = qla2x00_async_login_sp_done;
-	if (N2N_TOPO(fcport->vha->hw) && fcport_is_bigger(fcport))
+	if (N2N_TOPO(fcport->vha->hw) && fcport_is_bigger(fcport)) {
 		lio->u.logio.flags |= SRB_LOGIN_PRLI_ONLY;
-	else
-		lio->u.logio.flags |= SRB_LOGIN_COND_PLOGI;
+	} else {
+		if (vha->hw->flags.edif_enabled) {
+			if (fcport->edif.non_secured_login == 0) {
+				lio->u.logio.flags |=
+					(SRB_LOGIN_FCSP | SRB_LOGIN_SKIP_PRLI);
+				ql_dbg(ql_dbg_disc, vha, 0x2072,
+				    "Async-login: w/ FCSP %8phC hdl=%x, loopid=%x portid=%06x\n",
+				    fcport->port_name, sp->handle, fcport->loop_id,
+				    fcport->d_id.b24);
+			}
+		} else {
+			lio->u.logio.flags |= SRB_LOGIN_COND_PLOGI;
+		}
+	}
 
 	if (NVME_TARGET(vha->hw, fcport))
 		lio->u.logio.flags |= SRB_LOGIN_SKIP_PRLI;
@@ -377,7 +389,7 @@ static void qla2x00_async_logout_sp_done(srb_t *sp, int res)
 {
 	sp->fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 	sp->fcport->login_gen++;
-	qlt_logo_completion_handler(sp->fcport, res);
+	qlt_logo_completion_handler(sp->fcport, sp->u.iocb_cmd.u.logio.data[0]);
 	sp->free(sp);
 }
 
@@ -403,10 +415,10 @@ qla2x00_async_logout(struct scsi_qla_host *vha, fc_port_t *fcport)
 	sp->done = qla2x00_async_logout_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0x2070,
-	    "Async-logout - hdl=%x loop-id=%x portid=%02x%02x%02x %8phC.\n",
+	    "Async-logout - hdl=%x loop-id=%x portid=%02x%02x%02x %8phC explicit %d.\n",
 	    sp->handle, fcport->loop_id, fcport->d_id.b.domain,
 		fcport->d_id.b.area, fcport->d_id.b.al_pa,
-		fcport->port_name);
+		fcport->port_name, fcport->explicit_logout);
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS)
@@ -691,11 +703,11 @@ static void qla24xx_handle_gnl_done_event(scsi_qla_host_t *vha,
 
 	fcport = ea->fcport;
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
-	    "%s %8phC DS %d LS rc %d %d login %d|%d rscn %d|%d lid %d\n",
+	    "%s %8phC DS %d LS rc %d %d login %d|%d rscn %d|%d lid %d edif %d\n",
 	    __func__, fcport->port_name, fcport->disc_state,
 	    fcport->fw_login_state, ea->rc,
 	    fcport->login_gen, fcport->last_login_gen,
-	    fcport->rscn_gen, fcport->last_rscn_gen, vha->loop_id);
+	    fcport->rscn_gen, fcport->last_rscn_gen, vha->loop_id, fcport->edif.enable);
 
 	if (fcport->disc_state == DSC_DELETE_PEND)
 		return;
@@ -821,6 +833,13 @@ static void qla24xx_handle_gnl_done_event(scsi_qla_host_t *vha,
 				qla2x00_post_async_adisc_work(vha, fcport,
 				    data);
 				break;
+			case DSC_LS_PLOGI_COMP:
+				if (vha->hw->flags.edif_enabled) {
+					/* check to see if App support Secure */
+					qla24xx_post_gpdb_work(vha, fcport, 0);
+					break;
+				}
+				fallthrough;
 			case DSC_LS_PORT_UNAVAIL:
 			default:
 				if (fcport->loop_id == FC_NO_LOOP_ID) {
@@ -1417,6 +1436,57 @@ void __qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 }
 
+static int	qla_chk_secure_login(scsi_qla_host_t	*vha, fc_port_t *fcport,
+	struct port_database_24xx *pd)
+{
+	int rc = 0;
+
+	if (pd->secure_login) {
+		ql_dbg(ql_dbg_disc, vha, 0x104d,
+		    "Secure Login established on %8phC\n",
+		    fcport->port_name);
+		fcport->edif.secured_login = 1;
+		fcport->edif.non_secured_login = 0;
+		fcport->flags |= FCF_FCSP_DEVICE;
+	} else {
+		ql_dbg(ql_dbg_disc, vha, 0x104d,
+		    "non-Secure Login %8phC",
+		    fcport->port_name);
+		fcport->edif.secured_login = 0;
+		fcport->edif.non_secured_login = 1;
+	}
+	if (vha->hw->flags.edif_enabled) {
+		if (fcport->flags & FCF_FCSP_DEVICE) {
+			qla2x00_set_fcport_disc_state(fcport, DSC_LOGIN_AUTH_PEND);
+			/* Start edif prli timer & ring doorbell for app */
+			fcport->edif.rx_sa_set = 0;
+			fcport->edif.tx_sa_set = 0;
+			fcport->edif.rx_sa_pending = 0;
+			fcport->edif.tx_sa_pending = 0;
+
+			qla2x00_post_aen_work(vha, FCH_EVT_PORT_ONLINE,
+			    fcport->d_id.b24);
+
+			if (vha->e_dbell.db_flags ==  EDB_ACTIVE) {
+				ql_dbg(ql_dbg_disc, vha, 0x20ef,
+				    "%s %d %8phC EDIF: post DB_AUTH: AUTH needed\n",
+				    __func__, __LINE__, fcport->port_name);
+				fcport->edif.app_started = 1;
+				fcport->edif.app_sess_online = 1;
+			}
+
+			rc = 1;
+		} else {
+			ql_dbg(ql_dbg_disc, vha, 0x2117,
+			    "%s %d %8phC post prli\n",
+			    __func__, __LINE__, fcport->port_name);
+			qla24xx_post_prli_work(vha, fcport);
+			rc = 1;
+		}
+	}
+	return rc;
+}
+
 static
 void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
@@ -1459,8 +1529,11 @@ void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	case PDS_PRLI_COMPLETE:
 		__qla24xx_parse_gpdb(vha, fcport, pd);
 		break;
-	case PDS_PLOGI_PENDING:
 	case PDS_PLOGI_COMPLETE:
+		if (qla_chk_secure_login(vha, fcport, pd))
+			return;
+		fallthrough;
+	case PDS_PLOGI_PENDING:
 	case PDS_PRLI_PENDING:
 	case PDS_PRLI2_PENDING:
 		/* Set discovery state back to GNL to Relogin attempt */
@@ -2052,26 +2125,38 @@ qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 		 * force a relogin attempt via implicit LOGO, PLOGI, and PRLI
 		 * requests.
 		 */
-		if (NVME_TARGET(vha->hw, ea->fcport)) {
-			ql_dbg(ql_dbg_disc, vha, 0x2117,
-				"%s %d %8phC post prli\n",
-				__func__, __LINE__, ea->fcport->port_name);
-			qla24xx_post_prli_work(vha, ea->fcport);
-		} else {
-			ql_dbg(ql_dbg_disc, vha, 0x20ea,
-			    "%s %d %8phC LoopID 0x%x in use with %06x. post gpdb\n",
-			    __func__, __LINE__, ea->fcport->port_name,
-			    ea->fcport->loop_id, ea->fcport->d_id.b24);
-
+		if (vha->hw->flags.edif_enabled) {
 			set_bit(ea->fcport->loop_id, vha->hw->loop_id_map);
 			spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 			ea->fcport->chip_reset = vha->hw->base_qpair->chip_reset;
 			ea->fcport->logout_on_delete = 1;
 			ea->fcport->send_els_logo = 0;
-			ea->fcport->fw_login_state = DSC_LS_PRLI_COMP;
+			ea->fcport->fw_login_state = DSC_LS_PLOGI_COMP;
 			spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
 			qla24xx_post_gpdb_work(vha, ea->fcport, 0);
+		} else {
+			if (NVME_TARGET(vha->hw, fcport)) {
+				ql_dbg(ql_dbg_disc, vha, 0x2117,
+				    "%s %d %8phC post prli\n",
+				    __func__, __LINE__, fcport->port_name);
+				qla24xx_post_prli_work(vha, fcport);
+			} else {
+				ql_dbg(ql_dbg_disc, vha, 0x20ea,
+				    "%s %d %8phC LoopID 0x%x in use with %06x. post gpdb\n",
+				    __func__, __LINE__, fcport->port_name,
+				    fcport->loop_id, fcport->d_id.b24);
+
+				set_bit(fcport->loop_id, vha->hw->loop_id_map);
+				spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
+				fcport->chip_reset = vha->hw->base_qpair->chip_reset;
+				fcport->logout_on_delete = 1;
+				fcport->send_els_logo = 0;
+				fcport->fw_login_state = DSC_LS_PRLI_COMP;
+				spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+
+				qla24xx_post_gpdb_work(vha, fcport, 0);
+			}
 		}
 		break;
 	case MBS_COMMAND_ERROR:
@@ -5093,8 +5178,13 @@ qla2x00_free_fcport(fc_port_t *fcport)
 
 		fcport->ct_desc.ct_sns = NULL;
 	}
+
+	qla_edif_flush_sa_ctl_lists(fcport);
 	list_del(&fcport->list);
 	qla2x00_clear_loop_id(fcport);
+
+	qla_edif_list_del(fcport);
+
 	kfree(fcport);
 }
 
@@ -5213,6 +5303,12 @@ qla2x00_configure_loop(scsi_qla_host_t *vha)
 			    "LOOP READY.\n");
 			ha->flags.fw_init_done = 1;
 
+			if (vha->hw->flags.edif_enabled &&
+			    vha->e_dbell.db_flags != EDB_ACTIVE) {
+				/* wake up authentication app to get ready */
+				qla2x00_post_aen_work(vha, FCH_EVT_PORT_ONLINE, 0);
+			}
+
 			/*
 			 * Process any ATIO queue entries that came in
 			 * while we weren't online.
@@ -5232,7 +5328,8 @@ qla2x00_configure_loop(scsi_qla_host_t *vha)
 		    "%s *** FAILED ***.\n", __func__);
 	} else {
 		ql_dbg(ql_dbg_disc, vha, 0x206b,
-		    "%s: exiting normally.\n", __func__);
+		    "%s: exiting normally. local port wwpn %8phN id %06x)\n",
+		    __func__, vha->port_name, vha->d_id.b24);
 	}
 
 	/* Restore state if a resync event occurred during processing */
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 64ec66307bda..25e772435ada 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2466,6 +2466,12 @@ qla24xx_login_iocb(srb_t *sp, struct logio_entry_24xx *logio)
 			logio->control_flags |= cpu_to_le16(LCF_COND_PLOGI);
 		if (lio->u.logio.flags & SRB_LOGIN_SKIP_PRLI)
 			logio->control_flags |= cpu_to_le16(LCF_SKIP_PRLI);
+		if (lio->u.logio.flags & SRB_LOGIN_FCSP) {
+			logio->control_flags |=
+			    cpu_to_le16(LCF_COMMON_FEAT | LCF_SKIP_PRLI);
+			logio->io_parameter[0] =
+			    cpu_to_le32(LIO_COMM_FEAT_FCSP | LIO_COMM_FEAT_CIO);
+		}
 	}
 	logio->nport_handle = cpu_to_le16(sp->fcport->loop_id);
 	logio->port_id[0] = sp->fcport->d_id.b.al_pa;
@@ -2806,7 +2812,6 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
 		    (uint8_t *)els_iocb,
 		    sizeof(*els_iocb));
 	} else {
-		els_iocb->control_flags = cpu_to_le16(1 << 13);
 		els_iocb->tx_byte_count =
 			cpu_to_le32(sizeof(struct els_logo_payload));
 		put_unaligned_le64(elsio->u.els_logo.els_logo_pyld_dma,
@@ -3737,6 +3742,16 @@ static void qla2x00_send_notify_ack_iocb(srb_t *sp,
 	nack->u.isp24.srr_reject_code = 0;
 	nack->u.isp24.srr_reject_code_expl = 0;
 	nack->u.isp24.vp_index = ntfy->u.isp24.vp_index;
+
+	if (ntfy->u.isp24.status_subcode == ELS_PLOGI &&
+	    (le16_to_cpu(ntfy->u.isp24.flags) & NOTIFY24XX_FLAGS_FCSP) &&
+	    sp->vha->hw->flags.edif_enabled) {
+		ql_dbg(ql_dbg_disc, sp->vha, 0x3074,
+		    "%s PLOGI NACK sent with FC SECURITY bit, hdl=%x, loopid=%x, to pid %06x\n",
+		    sp->name, sp->handle, sp->fcport->loop_id,
+		    sp->fcport->d_id.b24);
+		nack->u.isp24.flags |= cpu_to_le16(NOTIFY_ACK_FLAGS_FCSP);
+	}
 }
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 657fe0d9ee21..ce4f93fb4d25 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2372,6 +2372,10 @@ qla24xx_logio_entry(scsi_qla_host_t *vha, struct req_que *req,
 		if (sp->type != SRB_LOGIN_CMD)
 			goto logio_done;
 
+		lio->u.logio.iop[1] = le32_to_cpu(logio->io_parameter[5]);
+		if (le32_to_cpu(logio->io_parameter[5]) & LIO_COMM_FEAT_FCSP)
+			fcport->flags |= FCF_FCSP_DEVICE;
+
 		iop[0] = le32_to_cpu(logio->io_parameter[0]);
 		if (iop[0] & BIT_4) {
 			fcport->port_type = FCT_TARGET;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 9f3ad8aa649c..19fa50884293 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -6588,6 +6588,12 @@ int __qla24xx_parse_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport,
 	fcport->d_id.b.al_pa = pd->port_id[2];
 	fcport->d_id.b.rsvd_1 = 0;
 
+	ql_dbg(ql_dbg_disc, vha, 0x2062,
+	     "%8phC SVC Param w3 %02x%02x",
+	     fcport->port_name,
+	     pd->prli_svc_param_word_3[1],
+	     pd->prli_svc_param_word_3[0]);
+
 	if (NVME_TARGET(vha->hw, fcport)) {
 		fcport->port_type = FCT_NVME;
 		if ((pd->prli_svc_param_word_3[0] & BIT_5) == 0)
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index c7caf322f445..078d596dbd49 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -158,6 +158,10 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 	int ret = QLA_SUCCESS;
 	fc_port_t *fcport;
 
+	if (vha->hw->flags.edif_enabled)
+		/* delete sessions and flush sa_indexes */
+		qla2x00_wait_for_sess_deletion(vha);
+
 	if (vha->hw->flags.fw_started)
 		ret = qla24xx_control_vp(vha, VCE_COMMAND_DISABLE_VPS_LOGO_ALL);
 
@@ -166,7 +170,8 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 	list_for_each_entry(fcport, &vha->vp_fcports, list)
 		fcport->logout_on_delete = 0;
 
-	qla2x00_mark_all_devices_lost(vha);
+	if (!vha->hw->flags.edif_enabled)
+		qla2x00_wait_for_sess_deletion(vha);
 
 	/* Remove port id from vp target map */
 	spin_lock_irqsave(&vha->hw->hardware_lock, flags);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 0ae4d0fd622f..216f132dc5b2 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1120,12 +1120,28 @@ static inline int test_fcport_count(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
 	int res;
+	/* Return 0 = sleep, x=wake */
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	ql_dbg(ql_dbg_init, vha, 0x00ec,
 	    "tgt %p, fcport_count=%d\n",
 	    vha, vha->fcport_count);
 	res = (vha->fcport_count == 0);
+	if  (res) {
+		struct fc_port *fcport;
+
+		list_for_each_entry(fcport, &vha->vp_fcports, list) {
+			if (fcport->deleted != QLA_SESS_DELETED) {
+				/* session(s) may not be fully logged in
+				 * (ie fcport_count=0), but session
+				 * deletion thread(s) may be inflight.
+				 */
+
+				res = 0;
+				break;
+			}
+		}
+	}
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
 	return res;
@@ -3934,6 +3950,8 @@ void qla2x00_mark_device_lost(scsi_qla_host_t *vha, fc_port_t *fcport,
 		qla2x00_set_fcport_state(fcport, FCS_DEVICE_LOST);
 		qla2x00_schedule_rport_del(vha, fcport);
 	}
+
+	qla_edif_sess_down(vha, fcport);
 	/*
 	 * We may need to retry the login, so don't change the state of the
 	 * port but do the retries.
@@ -5441,6 +5459,7 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
 		if (atomic_read(&fcport->state) != FCS_ONLINE &&
 		    fcport->login_retry) {
 			if (fcport->scan_state != QLA_FCPORT_FOUND ||
+			    fcport->disc_state == DSC_LOGIN_AUTH_PEND ||
 			    fcport->disc_state == DSC_LOGIN_COMPLETE)
 				continue;
 
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index eb5a9a385569..c1ff9f484f92 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -576,6 +576,16 @@ static void qla2x00_async_nack_sp_done(srb_t *sp, int res)
 		sp->fcport->logout_on_delete = 1;
 		sp->fcport->plogi_nack_done_deadline = jiffies + HZ;
 		sp->fcport->send_els_logo = 0;
+
+		if (sp->fcport->flags & FCF_FCSP_DEVICE) {
+			ql_dbg(ql_dbg_edif, vha, 0x20ef,
+			    "%s %8phC edif: PLOGI- AUTH WAIT\n", __func__,
+			    sp->fcport->port_name);
+			qla2x00_set_fcport_disc_state(sp->fcport,
+			    DSC_LOGIN_AUTH_PEND);
+			qla2x00_post_aen_work(vha, FCH_EVT_PORT_ONLINE,
+			    sp->fcport->d_id.b24);
+		}
 		break;
 
 	case SRB_NACK_PRLI:
@@ -623,6 +633,10 @@ int qla24xx_async_notify_ack(scsi_qla_host_t *vha, fc_port_t *fcport,
 	case SRB_NACK_PLOGI:
 		fcport->fw_login_state = DSC_LS_PLOGI_PEND;
 		c = "PLOGI";
+		if (vha->hw->flags.edif_enabled &&
+		    (le16_to_cpu(ntfy->u.isp24.flags) & NOTIFY24XX_FLAGS_FCSP)) {
+			fcport->flags |= FCF_FCSP_DEVICE;
+		}
 		break;
 	case SRB_NACK_PRLI:
 		fcport->fw_login_state = DSC_LS_PRLI_PEND;
@@ -692,7 +706,12 @@ void qla24xx_do_nack_work(struct scsi_qla_host *vha, struct qla_work_evt *e)
 void qla24xx_delete_sess_fn(struct work_struct *work)
 {
 	fc_port_t *fcport = container_of(work, struct fc_port, del_work);
-	struct qla_hw_data *ha = fcport->vha->hw;
+	struct qla_hw_data *ha = NULL;
+
+	if (!fcport || !fcport->vha || !fcport->vha->hw)
+		return;
+
+	ha = fcport->vha->hw;
 
 	if (fcport->se_sess) {
 		ha->tgt.tgt_ops->shutdown_sess(fcport);
@@ -964,6 +983,19 @@ void qlt_free_session_done(struct work_struct *work)
 		sess->send_els_logo);
 
 	if (!IS_SW_RESV_ADDR(sess->d_id)) {
+		if (ha->flags.edif_enabled &&
+		    (!own || own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
+			if (!ha->flags.host_shutting_down) {
+				ql_dbg(ql_dbg_edif, vha, 0x911e,
+					"%s wwpn %8phC calling qla2x00_release_all_sadb\n",
+					__func__, sess->port_name);
+				qla2x00_release_all_sadb(vha, sess);
+			} else {
+				ql_dbg(ql_dbg_edif, vha, 0x911e,
+					"%s bypassing release_all_sadb\n",
+					__func__);
+			}
+		}
 		qla2x00_mark_device_lost(vha, sess, 0);
 
 		if (sess->send_els_logo) {
@@ -971,6 +1003,7 @@ void qlt_free_session_done(struct work_struct *work)
 
 			logo.id = sess->d_id;
 			logo.cmd_count = 0;
+			INIT_LIST_HEAD(&logo.list);
 			if (!own)
 				qlt_send_first_logo(vha, &logo);
 			sess->send_els_logo = 0;
@@ -981,6 +1014,7 @@ void qlt_free_session_done(struct work_struct *work)
 
 			if (!own ||
 			     (own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
+				sess->logout_completed = 0;
 				rc = qla2x00_post_async_logout_work(vha, sess,
 				    NULL);
 				if (rc != QLA_SUCCESS)
@@ -1717,6 +1751,12 @@ static void qlt_send_notify_ack(struct qla_qpair *qpair,
 	nack->u.isp24.srr_reject_code_expl = srr_explan;
 	nack->u.isp24.vp_index = ntfy->u.isp24.vp_index;
 
+	/* TODO qualify this with EDIF enable */
+	if (ntfy->u.isp24.status_subcode == ELS_PLOGI &&
+	    (le16_to_cpu(ntfy->u.isp24.flags) & NOTIFY24XX_FLAGS_FCSP)) {
+		nack->u.isp24.flags |= cpu_to_le16(NOTIFY_ACK_FLAGS_FCSP);
+	}
+
 	ql_dbg(ql_dbg_tgt, vha, 0xe005,
 	    "qla_target(%d): Sending 24xx Notify Ack %d\n",
 	    vha->vp_idx, nack->u.isp24.status);
@@ -4724,6 +4764,15 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 		goto out;
 	}
 
+	if (vha->hw->flags.edif_enabled &&
+	    vha->e_dbell.db_flags != EDB_ACTIVE) {
+		ql_dbg(ql_dbg_disc, vha, 0xffff,
+			"%s %d Term INOT due to app not available lid=%d, NportID %06X ",
+			__func__, __LINE__, loop_id, port_id.b24);
+		qlt_send_term_imm_notif(vha, iocb, 1);
+		goto out;
+	}
+
 	pla = qlt_plogi_ack_find_add(vha, &port_id, iocb);
 	if (!pla) {
 		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
@@ -4789,6 +4838,16 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 	qlt_plogi_ack_link(vha, pla, sess, QLT_PLOGI_LINK_SAME_WWN);
 	sess->d_id = port_id;
 	sess->login_gen++;
+	sess->loop_id = loop_id;
+
+	if (iocb->u.isp24.status_subcode == ELS_PLOGI) {
+		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		    "%s %8phC - send port online\n",
+		    __func__, sess->port_name);
+
+		qla2x00_post_aen_work(vha, FCH_EVT_PORT_ONLINE,
+		    sess->d_id.b24);
+	}
 
 	if (iocb->u.isp24.status_subcode == ELS_PRLI) {
 		sess->fw_login_state = DSC_LS_PRLI_PEND;
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 8a319b78cdf6..b910f8f09353 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -176,6 +176,7 @@ struct nack_to_isp {
 	uint8_t  reserved[2];
 	__le16	ox_id;
 } __packed;
+#define NOTIFY_ACK_FLAGS_FCSP		BIT_5
 #define NOTIFY_ACK_FLAGS_TERMINATE	BIT_3
 #define NOTIFY_ACK_SRR_FLAGS_ACCEPT	0
 #define NOTIFY_ACK_SRR_FLAGS_REJECT	1
-- 
2.19.0.rc0

