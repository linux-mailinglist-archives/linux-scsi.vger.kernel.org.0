Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AEB87005
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2019 05:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405365AbfHIDDu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Aug 2019 23:03:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37646 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405025AbfHIDDu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Aug 2019 23:03:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so12283186pgp.4
        for <linux-scsi@vger.kernel.org>; Thu, 08 Aug 2019 20:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCNKHRD6kAntLvr+qxYLi1C+pdx67KAH+5vEEJHEzj4=;
        b=l6JK/BjNlL7KjJsgCLX4ipvwUKAp9f6ml7iqwj/ablqIFjhCS1m3TndaspOA+3FPqC
         Yh52/SztazvNf9Sl/uEVXQXmkuFaS5wu9SUmDGUGuc642fBfIoBc2v/xQg+lRQ4jMIvb
         2uOv7onJS++COTMNlxaXd1hIdZ25UTy35bZyp0RRCG80eWGNmJKHy158b4w2ESNATwal
         74nB86pBtV3n96rM8c2G3yESWtBy9nMACOPbWL2QaKY+aRUiWI2akuXOYAyWxHE7o9kk
         JSn+9KIL/HHKwcPfAoJQSEmMzAeyQL2LAl5dgnRiETXTafXxAqiPADPpaX1YKvUIPixx
         X6Mw==
X-Gm-Message-State: APjAAAXDqyC6GpdspbAaqm5VEig3vFd6BtWkbg02dSJE3tZ4UBLb6APD
        ut5G6vh7P+TXEg3iP1PDwiI=
X-Google-Smtp-Source: APXvYqwDMa73Ayeyb6adfwy8k3q6DOdotUomRakRBPPKXR/2egwhB9UCw8JNrmjQ0YuSHl6tjsVQog==
X-Received: by 2002:a65:6081:: with SMTP id t1mr15753273pgu.9.1565319828938;
        Thu, 08 Aug 2019 20:03:48 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4001:6530:8f02:649d:771a:4703])
        by smtp.gmail.com with ESMTPSA id g2sm111787580pfi.26.2019.08.08.20.03.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:03:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: [PATCH v2 54/58] qla2xxx: Inline the qla2x00_fcport_event_handler() function
Date:   Thu,  8 Aug 2019 20:02:15 -0700
Message-Id: <20190809030219.11296-55-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809030219.11296-1-bvanassche@acm.org>
References: <20190809030219.11296-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of calling qla2x00_fcport_event_handler() and letting the
switch statement inside that function decide which other function
to call, call the latter function directly. Remove the event member
from the event_arg structure because it is no longer needed. Remove
the qla_handle_els_plogi_done() function because it is never called.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |  17 -----
 drivers/scsi/qla2xxx/qla_gbl.h  |   6 +-
 drivers/scsi/qla2xxx/qla_gs.c   |  15 ++--
 drivers/scsi/qla2xxx/qla_init.c | 131 ++++++++------------------------
 drivers/scsi/qla2xxx/qla_iocb.c |   3 +-
 drivers/scsi/qla2xxx/qla_isr.c  |   3 +-
 drivers/scsi/qla2xxx/qla_os.c   |   3 +-
 7 files changed, 45 insertions(+), 133 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 556376ce0259..a971d4245d89 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2363,22 +2363,6 @@ enum login_state {	/* FW control Target side */
 	DSC_LS_LOGO_PEND,
 };
 
-enum fcport_mgt_event {
-	FCME_RELOGIN = 1,
-	FCME_RSCN,
-	FCME_PLOGI_DONE,	/* Initiator side sent LLIOCB */
-	FCME_PRLI_DONE,
-	FCME_GNL_DONE,
-	FCME_GPSC_DONE,
-	FCME_GPDB_DONE,
-	FCME_GPNID_DONE,
-	FCME_GFFID_DONE,
-	FCME_ADISC_DONE,
-	FCME_GNNID_DONE,
-	FCME_GFPNID_DONE,
-	FCME_ELS_PLOGI_DONE,
-};
-
 enum rscn_addr_format {
 	RSCN_PORT_ADDR,
 	RSCN_AREA_ADDR,
@@ -2496,7 +2480,6 @@ typedef struct fc_port {
 #define QLA_FCPORT_FOUND	2
 
 struct event_arg {
-	enum fcport_mgt_event	event;
 	fc_port_t		*fcport;
 	srb_t			*sp;
 	port_id_t		id;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 6b914942fad3..3f313eaf854b 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -96,7 +96,11 @@ extern int qla2x00_init_rings(scsi_qla_host_t *);
 extern struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *,
 	int, int, bool);
 extern int qla2xxx_delete_qpair(struct scsi_qla_host *, struct qla_qpair *);
-void qla2x00_fcport_event_handler(scsi_qla_host_t *, struct event_arg *);
+void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea);
+void qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha,
+				     struct event_arg *ea);
+void qla24xx_handle_relogin_event(scsi_qla_host_t *vha,
+				  struct event_arg *ea);
 int qla24xx_async_gpdb(struct scsi_qla_host *, fc_port_t *, u8);
 int qla24xx_async_prli(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_async_notify_ack(scsi_qla_host_t *, fc_port_t *,
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 35e1f36c9366..0e1df8232c75 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3031,11 +3031,10 @@ static void qla24xx_async_gpsc_sp_done(srb_t *sp, int res)
 		    be16_to_cpu(ct_rsp->rsp.gpsc.speed));
 	}
 	memset(&ea, 0, sizeof(ea));
-	ea.event = FCME_GPSC_DONE;
 	ea.rc = res;
 	ea.fcport = fcport;
 	ea.sp = sp;
-	qla2x00_fcport_event_handler(vha, &ea);
+	qla24xx_handle_gpsc_event(vha, &ea);
 
 done:
 	sp->free(sp);
@@ -3283,7 +3282,6 @@ static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 	ea.sp = sp;
 	ea.id = be_to_port_id(ct_req->req.port_id.port_id);
 	ea.rc = res;
-	ea.event = FCME_GPNID_DONE;
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	list_del(&sp->elem);
@@ -3302,7 +3300,7 @@ static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 		return;
 	}
 
-	qla2x00_fcport_event_handler(vha, &ea);
+	qla24xx_handle_gpnid_event(vha, &ea);
 
 	e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
 	if (!e) {
@@ -3481,9 +3479,8 @@ void qla24xx_async_gffid_sp_done(srb_t *sp, int res)
 	ea.sp = sp;
 	ea.fcport = sp->fcport;
 	ea.rc = res;
-	ea.event = FCME_GFFID_DONE;
 
-	qla2x00_fcport_event_handler(vha, &ea);
+	qla24xx_handle_gffid_event(vha, &ea);
 	sp->free(sp);
 }
 
@@ -4263,13 +4260,12 @@ static void qla2x00_async_gnnid_sp_done(srb_t *sp, int res)
 	ea.fcport = fcport;
 	ea.sp = sp;
 	ea.rc = res;
-	ea.event = FCME_GNNID_DONE;
 
 	ql_dbg(ql_dbg_disc, vha, 0x204f,
 	    "Async done-%s res %x, WWPN %8phC %8phC\n",
 	    sp->name, res, fcport->port_name, fcport->node_name);
 
-	qla2x00_fcport_event_handler(vha, &ea);
+	qla24xx_handle_gnnid_event(vha, &ea);
 
 	sp->free(sp);
 }
@@ -4394,13 +4390,12 @@ static void qla2x00_async_gfpnid_sp_done(srb_t *sp, int res)
 	ea.fcport = fcport;
 	ea.sp = sp;
 	ea.rc = res;
-	ea.event = FCME_GFPNID_DONE;
 
 	ql_dbg(ql_dbg_disc, vha, 0x204f,
 	    "Async done-%s res %x, WWPN %8phC %8phC\n",
 	    sp->name, res, fcport->port_name, fcport->fabric_port_name);
 
-	qla2x00_fcport_event_handler(vha, &ea);
+	qla24xx_handle_gfpnid_event(vha, &ea);
 
 	sp->free(sp);
 }
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index b3f1203bfe87..c9cb6856f82e 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -37,8 +37,8 @@ static struct qla_chip_state_84xx *qla84xx_get_chip(struct scsi_qla_host *);
 static int qla84xx_init_chip(scsi_qla_host_t *);
 static int qla25xx_init_queues(struct qla_hw_data *);
 static int qla24xx_post_prli_work(struct scsi_qla_host*, fc_port_t *);
-static void qla24xx_handle_plogi_done_event(struct scsi_qla_host *,
-    struct event_arg *);
+static void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha,
+				      struct event_arg *ea);
 static void qla24xx_handle_prli_done_event(struct scsi_qla_host *,
     struct event_arg *);
 static void __qla24xx_handle_gpdb_event(scsi_qla_host_t *, struct event_arg *);
@@ -263,14 +263,13 @@ static void qla2x00_async_login_sp_done(srb_t *sp, int res)
 
 	if (!test_bit(UNLOADING, &vha->dpc_flags)) {
 		memset(&ea, 0, sizeof(ea));
-		ea.event = FCME_PLOGI_DONE;
 		ea.fcport = sp->fcport;
 		ea.data[0] = lio->u.logio.data[0];
 		ea.data[1] = lio->u.logio.data[1];
 		ea.iop[0] = lio->u.logio.iop[0];
 		ea.iop[1] = lio->u.logio.iop[1];
 		ea.sp = sp;
-		qla2x00_fcport_event_handler(vha, &ea);
+		qla24xx_handle_plogi_done_event(vha, &ea);
 	}
 
 	sp->free(sp);
@@ -535,7 +534,6 @@ static void qla2x00_async_adisc_sp_done(srb_t *sp, int res)
 	sp->fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 
 	memset(&ea, 0, sizeof(ea));
-	ea.event = FCME_ADISC_DONE;
 	ea.rc = res;
 	ea.data[0] = lio->u.logio.data[0];
 	ea.data[1] = lio->u.logio.data[1];
@@ -544,7 +542,7 @@ static void qla2x00_async_adisc_sp_done(srb_t *sp, int res)
 	ea.fcport = sp->fcport;
 	ea.sp = sp;
 
-	qla2x00_fcport_event_handler(vha, &ea);
+	qla24xx_handle_adisc_event(vha, &ea);
 
 	sp->free(sp);
 }
@@ -950,7 +948,6 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 	memset(&ea, 0, sizeof(ea));
 	ea.sp = sp;
 	ea.rc = res;
-	ea.event = FCME_GNL_DONE;
 
 	if (sp->u.iocb_cmd.u.mbx.in_mb[1] >=
 	    sizeof(struct get_name_list_extended)) {
@@ -989,7 +986,7 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 		spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 		ea.fcport = fcport;
 
-		qla2x00_fcport_event_handler(vha, &ea);
+		qla24xx_handle_gnl_done_event(vha, &ea);
 	}
 
 	/* create new fcport if fw has knowledge of new sessions */
@@ -1134,11 +1131,10 @@ static void qla24xx_async_gpdb_sp_done(srb_t *sp, int res)
 
 	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 	memset(&ea, 0, sizeof(ea));
-	ea.event = FCME_GPDB_DONE;
 	ea.fcport = fcport;
 	ea.sp = sp;
 
-	qla2x00_fcport_event_handler(vha, &ea);
+	qla24xx_handle_gpdb_event(vha, &ea);
 
 	dma_pool_free(ha->s_dma_pool, sp->u.iocb_cmd.u.mbx.in,
 		sp->u.iocb_cmd.u.mbx.in_dma);
@@ -1173,7 +1169,6 @@ static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 
 	if (!test_bit(UNLOADING, &vha->dpc_flags)) {
 		memset(&ea, 0, sizeof(ea));
-		ea.event = FCME_PRLI_DONE;
 		ea.fcport = sp->fcport;
 		ea.data[0] = lio->u.logio.data[0];
 		ea.data[1] = lio->u.logio.data[1];
@@ -1181,7 +1176,7 @@ static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 		ea.iop[1] = lio->u.logio.iop[1];
 		ea.sp = sp;
 
-		qla2x00_fcport_event_handler(vha, &ea);
+		qla24xx_handle_prli_done_event(vha, &ea);
 	}
 
 	sp->free(sp);
@@ -1644,12 +1639,34 @@ int qla24xx_post_newsess_work(struct scsi_qla_host *vha, port_id_t *id,
 	return qla2x00_post_work(vha, e);
 }
 
-static
+void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
+{
+	fc_port_t *fcport;
+	unsigned long flags;
+
+	fcport = qla2x00_find_fcport_by_nportid(vha, &ea->id, 1);
+	if (fcport) {
+		fcport->scan_needed = 1;
+		fcport->rscn_gen++;
+	}
+
+	spin_lock_irqsave(&vha->work_lock, flags);
+	if (vha->scan.scan_flags == 0) {
+		ql_dbg(ql_dbg_disc, vha, 0xffff, "%s: schedule\n", __func__);
+		vha->scan.scan_flags |= SF_QUEUED;
+		schedule_delayed_work(&vha->scan.scan_work, 5);
+	}
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+}
+
 void qla24xx_handle_relogin_event(scsi_qla_host_t *vha,
 	struct event_arg *ea)
 {
 	fc_port_t *fcport = ea->fcport;
 
+	if (test_bit(UNLOADING, &vha->dpc_flags))
+		return;
+
 	ql_dbg(ql_dbg_disc, vha, 0x2102,
 	    "%s %8phC DS %d LS %d P %d del %d cnfl %p rscn %d|%d login %d|%d fl %x\n",
 	    __func__, fcport->port_name, fcport->disc_state,
@@ -1680,89 +1697,6 @@ void qla24xx_handle_relogin_event(scsi_qla_host_t *vha,
 	qla24xx_fcport_handle_login(vha, fcport);
 }
 
-
-static void qla_handle_els_plogi_done(scsi_qla_host_t *vha,
-				      struct event_arg *ea)
-{
-	ql_dbg(ql_dbg_disc, vha, 0x2118,
-	    "%s %d %8phC post PRLI\n",
-	    __func__, __LINE__, ea->fcport->port_name);
-	qla24xx_post_prli_work(vha, ea->fcport);
-}
-
-void qla2x00_fcport_event_handler(scsi_qla_host_t *vha, struct event_arg *ea)
-{
-	fc_port_t *fcport;
-
-	switch (ea->event) {
-	case FCME_RELOGIN:
-		if (test_bit(UNLOADING, &vha->dpc_flags))
-			return;
-
-		qla24xx_handle_relogin_event(vha, ea);
-		break;
-	case FCME_RSCN:
-		if (test_bit(UNLOADING, &vha->dpc_flags))
-			return;
-		{
-			unsigned long flags;
-
-			fcport = qla2x00_find_fcport_by_nportid
-				(vha, &ea->id, 1);
-			if (fcport) {
-				fcport->scan_needed = 1;
-				fcport->rscn_gen++;
-			}
-
-			spin_lock_irqsave(&vha->work_lock, flags);
-			if (vha->scan.scan_flags == 0) {
-				ql_dbg(ql_dbg_disc, vha, 0xffff,
-				    "%s: schedule\n", __func__);
-				vha->scan.scan_flags |= SF_QUEUED;
-				schedule_delayed_work(&vha->scan.scan_work, 5);
-			}
-			spin_unlock_irqrestore(&vha->work_lock, flags);
-		}
-		break;
-	case FCME_GNL_DONE:
-		qla24xx_handle_gnl_done_event(vha, ea);
-		break;
-	case FCME_GPSC_DONE:
-		qla24xx_handle_gpsc_event(vha, ea);
-		break;
-	case FCME_PLOGI_DONE:	/* Initiator side sent LLIOCB */
-		qla24xx_handle_plogi_done_event(vha, ea);
-		break;
-	case FCME_PRLI_DONE:
-		qla24xx_handle_prli_done_event(vha, ea);
-		break;
-	case FCME_GPDB_DONE:
-		qla24xx_handle_gpdb_event(vha, ea);
-		break;
-	case FCME_GPNID_DONE:
-		qla24xx_handle_gpnid_event(vha, ea);
-		break;
-	case FCME_GFFID_DONE:
-		qla24xx_handle_gffid_event(vha, ea);
-		break;
-	case FCME_ADISC_DONE:
-		qla24xx_handle_adisc_event(vha, ea);
-		break;
-	case FCME_GNNID_DONE:
-		qla24xx_handle_gnnid_event(vha, ea);
-		break;
-	case FCME_GFPNID_DONE:
-		qla24xx_handle_gfpnid_event(vha, ea);
-		break;
-	case FCME_ELS_PLOGI_DONE:
-		qla_handle_els_plogi_done(vha, ea);
-		break;
-	default:
-		BUG_ON(1);
-		break;
-	}
-}
-
 /*
  * RSCN(s) came in for this fcport, but the RSCN(s) was not able
  * to be consumed by the fcport
@@ -1780,10 +1714,9 @@ void qla_rscn_replay(fc_port_t *fcport)
 
 	if (fcport->scan_needed) {
 		memset(&ea, 0, sizeof(ea));
-		ea.event = FCME_RSCN;
 		ea.id = fcport->d_id;
 		ea.id.b.rsvd_1 = RSCN_PORT_ADDR;
-		qla2x00_fcport_event_handler(fcport->vha, &ea);
+		qla2x00_handle_rscn(fcport->vha, &ea);
 	}
 }
 
@@ -1938,7 +1871,7 @@ qla24xx_handle_prli_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 	}
 }
 
-static void
+void
 qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 {
 	port_id_t cid;	/* conflict Nport id */
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 6acf92d19951..39c7738c0a55 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2741,8 +2741,7 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 			memset(&ea, 0, sizeof(ea));
 			ea.fcport = fcport;
 			ea.rc = res;
-			ea.event = FCME_ELS_PLOGI_DONE;
-			qla2x00_fcport_event_handler(vha, &ea);
+			qla24xx_handle_plogi_done_event(vha, &ea);
 		}
 
 		e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 5c65f2e67448..cd39ac18c5fd 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1118,10 +1118,9 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 			struct event_arg ea;
 
 			memset(&ea, 0, sizeof(ea));
-			ea.event = FCME_RSCN;
 			ea.id.b24 = rscn_entry;
 			ea.id.b.rsvd_1 = rscn_entry >> 24;
-			qla2x00_fcport_event_handler(vha, &ea);
+			qla2x00_handle_rscn(vha, &ea);
 			qla2x00_post_aen_work(vha, FCH_EVT_RSCN, rscn_entry);
 		}
 		break;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 5cb0bb65ace3..7d73b6a7cf41 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5328,9 +5328,8 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
 			} else {
 				if (vha->hw->current_topology != ISP_CFG_NL) {
 					memset(&ea, 0, sizeof(ea));
-					ea.event = FCME_RELOGIN;
 					ea.fcport = fcport;
-					qla2x00_fcport_event_handler(vha, &ea);
+					qla24xx_handle_relogin_event(vha, &ea);
 				} else if (vha->hw->current_topology ==
 				    ISP_CFG_NL) {
 					fcport->login_retry--;
-- 
2.22.0

