Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2586FFA
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2019 05:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405283AbfHIDDf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Aug 2019 23:03:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405025AbfHIDDf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Aug 2019 23:03:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so45224414pfq.0
        for <linux-scsi@vger.kernel.org>; Thu, 08 Aug 2019 20:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqsHyTgc2DKwacbjA3c1e9um7VxnuQJnDR0FfnMJMqc=;
        b=ebRVkZLXiYHHWt/ipJ+6zCH6lnt7EZ9DjsI6Hnpd70YarvRIgulrEc6dxCu4VYVRNw
         EXpu6E9xT1G0SVA8DET4z3JEJ8q36q83y6/brOCnrz41+50F5hfP8ln9N3oe5mOMjD7B
         ged5/FSV7IG90DnogFZpGFdOEkTE9p/wGd13logHni2pzVuB8QSxAsfbuafUDOOV5ny2
         kXEDsrK+8sZEvFAGkYf+f2Ws9nhTHURwEra2lCNlD5uDdSQ24/k5tju8KLvl01u9QxSt
         YndGEYWQtdVEZEz7yzcUKYwEN2GPfTQh6L4xJI9EKGXhi/8hBXIyQb3VxvxvO3aQ0cUq
         Vjqg==
X-Gm-Message-State: APjAAAU+K2/MS2Grns22+7nOO73qMBuqVlEoSqyNfHJmB5WQvElUUfLN
        eODKlnPZdI2eqEQFUIM9cbI=
X-Google-Smtp-Source: APXvYqw61bswQ7nTnD2HJmDrTN7bQidndcTKRKQ7tx3a/dSHk9wBq1dGkbRQTDY1mTBSBY2n49vORA==
X-Received: by 2002:a65:6096:: with SMTP id t22mr14646456pgu.204.1565319813420;
        Thu, 08 Aug 2019 20:03:33 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4001:6530:8f02:649d:771a:4703])
        by smtp.gmail.com with ESMTPSA id g2sm111787580pfi.26.2019.08.08.20.03.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:03:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: [PATCH v2 43/58] qla2xxx: Enable type checking for the SRB free and done callback functions
Date:   Thu,  8 Aug 2019 20:02:04 -0700
Message-Id: <20190809030219.11296-44-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809030219.11296-1-bvanassche@acm.org>
References: <20190809030219.11296-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since all pointers passed to the srb_t.done() and srb_t.free() functions
have type srb_t, change the type of the first argument of these functions
from void * into struct srb *. This allows the compiler to verify the
argument types for these functions. This patch does not change any
functionality.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c    |  8 ++-----
 drivers/scsi/qla2xxx/qla_def.h    | 14 +++++++++--
 drivers/scsi/qla2xxx/qla_gbl.h    | 14 +++++------
 drivers/scsi/qla2xxx/qla_gs.c     | 21 ++++++----------
 drivers/scsi/qla2xxx/qla_init.c   | 40 ++++++++-----------------------
 drivers/scsi/qla2xxx/qla_iocb.c   | 12 +++-------
 drivers/scsi/qla2xxx/qla_mbx.c    |  4 +---
 drivers/scsi/qla2xxx/qla_mid.c    |  4 +---
 drivers/scsi/qla2xxx/qla_mr.c     |  4 +---
 drivers/scsi/qla2xxx/qla_nvme.c   | 11 ++++-----
 drivers/scsi/qla2xxx/qla_nvme.h   |  2 +-
 drivers/scsi/qla2xxx/qla_os.c     | 16 ++++---------
 drivers/scsi/qla2xxx/qla_target.c |  4 +---
 13 files changed, 54 insertions(+), 100 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 240b07b0098a..28d587a89ba6 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -12,10 +12,8 @@
 #include <linux/bsg-lib.h>
 
 /* BSG support for ELS/CT pass through */
-void
-qla2x00_bsg_job_done(void *ptr, int res)
+void qla2x00_bsg_job_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct bsg_job *bsg_job = sp->u.bsg_job;
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
 
@@ -25,10 +23,8 @@ qla2x00_bsg_job_done(void *ptr, int res)
 	sp->free(sp);
 }
 
-void
-qla2x00_bsg_sp_free(void *ptr)
+void qla2x00_bsg_sp_free(srb_t *sp)
 {
-	srb_t *sp = ptr;
 	struct qla_hw_data *ha = sp->vha->hw;
 	struct bsg_job *bsg_job = sp->u.bsg_job;
 	struct fc_bsg_request *bsg_request = bsg_job->request;
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 779bf3fcab0f..65d79bcb7ccf 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -614,8 +614,18 @@ typedef struct srb {
 		struct bsg_job *bsg_job;
 		struct srb_cmd scmd;
 	} u;
-	void (*done)(void *, int);
-	void (*free)(void *);
+	/*
+	 * Report completion status @res and call sp_put(@sp). @res is
+	 * an NVMe status code, a SCSI result (e.g. DID_OK << 16) or a
+	 * QLA_* status value.
+	 */
+	void (*done)(struct srb *sp, int res);
+	/* Stop the timer and free @sp. Only used by the FCP code. */
+	void (*free)(struct srb *sp);
+	/*
+	 * Call nvme_private->fd->done() and free @sp. Only used by the NVMe
+	 * code.
+	 */
 	void (*put_fn)(struct kref *kref);
 } srb_t;
 
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index aac664da419b..bbfbe3a34a7e 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -213,9 +213,9 @@ extern int qla2x00_post_uevent_work(struct scsi_qla_host *, u32);
 
 extern int qla2x00_post_uevent_work(struct scsi_qla_host *, u32);
 extern void qla2x00_disable_board_on_pci_error(struct work_struct *);
-extern void qla2x00_sp_compl(void *, int);
-extern void qla2xxx_qpair_sp_free_dma(void *);
-extern void qla2xxx_qpair_sp_compl(void *, int);
+extern void qla2x00_sp_compl(srb_t *sp, int);
+extern void qla2xxx_qpair_sp_free_dma(srb_t *sp);
+extern void qla2xxx_qpair_sp_compl(srb_t *sp, int);
 extern void qla24xx_sched_upd_fcport(fc_port_t *);
 void qla2x00_handle_login_done_event(struct scsi_qla_host *, fc_port_t *,
 	uint16_t *);
@@ -244,7 +244,7 @@ extern void qla2x00_do_dpc_all_vps(scsi_qla_host_t *);
 extern int qla24xx_vport_create_req_sanity_check(struct fc_vport *);
 extern scsi_qla_host_t *qla24xx_create_vhost(struct fc_vport *);
 
-extern void qla2x00_sp_free_dma(void *);
+extern void qla2x00_sp_free_dma(srb_t *sp);
 extern char *qla2x00_get_fw_version_str(struct scsi_qla_host *, char *);
 
 extern void qla2x00_mark_device_lost(scsi_qla_host_t *, fc_port_t *, int, int);
@@ -790,10 +790,10 @@ extern int qla82xx_restart_isp(scsi_qla_host_t *);
 
 /* IOCB related functions */
 extern int qla82xx_start_scsi(srb_t *);
-extern void qla2x00_sp_free(void *);
+extern void qla2x00_sp_free(srb_t *sp);
 extern void qla2x00_sp_timeout(struct timer_list *);
-extern void qla2x00_bsg_job_done(void *, int);
-extern void qla2x00_bsg_sp_free(void *);
+extern void qla2x00_bsg_job_done(srb_t *sp, int);
+extern void qla2x00_bsg_sp_free(srb_t *sp);
 extern void qla2x00_start_iocbs(struct scsi_qla_host *, struct req_que *);
 
 /* Interrupt related */
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 18117b5f32bc..35e1f36c9366 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -499,9 +499,8 @@ qla2x00_gnn_id(scsi_qla_host_t *vha, sw_info_t *list)
 	return (rval);
 }
 
-static void qla2x00_async_sns_sp_done(void *s, int rc)
+static void qla2x00_async_sns_sp_done(srb_t *sp, int rc)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct ct_sns_pkt *ct_sns;
 	struct qla_work_evt *e;
@@ -2989,9 +2988,8 @@ void qla24xx_handle_gpsc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	qla_post_iidma_work(vha, fcport);
 }
 
-static void qla24xx_async_gpsc_sp_done(void *s, int res)
+static void qla24xx_async_gpsc_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct qla_hw_data *ha = vha->hw;
 	fc_port_t *fcport = sp->fcport;
@@ -3258,9 +3256,8 @@ void qla24xx_handle_gpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	}
 }
 
-static void qla2x00_async_gpnid_sp_done(void *s, int res)
+static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct ct_sns_req *ct_req =
 	    (struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
@@ -3446,9 +3443,8 @@ void qla24xx_handle_gffid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	qla24xx_post_gnl_work(vha, fcport);
 }
 
-void qla24xx_async_gffid_sp_done(void *s, int res)
+void qla24xx_async_gffid_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	fc_port_t *fcport = sp->fcport;
 	struct ct_sns_rsp *ct_rsp;
@@ -3872,9 +3868,8 @@ static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
 	}
 }
 
-static void qla2x00_async_gpnft_gnnft_sp_done(void *s, int res)
+static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct ct_sns_req *ct_req =
 		(struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
@@ -4251,9 +4246,8 @@ void qla24xx_handle_gnnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	qla24xx_post_gnl_work(vha, ea->fcport);
 }
 
-static void qla2x00_async_gnnid_sp_done(void *s, int res)
+static void qla2x00_async_gnnid_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	fc_port_t *fcport = sp->fcport;
 	u8 *node_name = fcport->ct_desc.ct_sns->p.rsp.rsp.gnn_id.node_name;
@@ -4384,9 +4378,8 @@ void qla24xx_handle_gfpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	qla24xx_post_gpsc_work(vha, fcport);
 }
 
-static void qla2x00_async_gfpnid_sp_done(void *s, int res)
+static void qla2x00_async_gfpnid_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	fc_port_t *fcport = sp->fcport;
 	u8 *fpn = fcport->ct_desc.ct_sns->p.rsp.rsp.gfpn_id.port_name;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a6a66b5d36a3..3fa8ca63429c 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -63,10 +63,8 @@ qla2x00_sp_timeout(struct timer_list *t)
 	iocb->timeout(sp);
 }
 
-void
-qla2x00_sp_free(void *ptr)
+void qla2x00_sp_free(srb_t *sp)
 {
-	srb_t *sp = ptr;
 	struct srb_iocb *iocb = &sp->u.iocb_cmd;
 
 	del_timer(&iocb->timer);
@@ -117,9 +115,8 @@ static void qla24xx_abort_iocb_timeout(void *data)
 	sp->done(sp, QLA_OS_TIMER_EXPIRED);
 }
 
-static void qla24xx_abort_sp_done(void *ptr, int res)
+static void qla24xx_abort_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
 
 	del_timer(&sp->u.iocb_cmd.timer);
@@ -249,10 +246,8 @@ qla2x00_async_iocb_timeout(void *data)
 	}
 }
 
-static void
-qla2x00_async_login_sp_done(void *ptr, int res)
+static void qla2x00_async_login_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct scsi_qla_host *vha = sp->vha;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 	struct event_arg ea;
@@ -358,11 +353,8 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
 	return rval;
 }
 
-static void
-qla2x00_async_logout_sp_done(void *ptr, int res)
+static void qla2x00_async_logout_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
-
 	sp->fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 	sp->fcport->login_gen++;
 	qlt_logo_completion_handler(sp->fcport, res);
@@ -419,10 +411,8 @@ qla2x00_async_prlo_done(struct scsi_qla_host *vha, fc_port_t *fcport,
 	qlt_logo_completion_handler(fcport, data[0]);
 }
 
-static void
-qla2x00_async_prlo_sp_done(void *s, int res)
+static void qla2x00_async_prlo_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = (srb_t *)s;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 	struct scsi_qla_host *vha = sp->vha;
 
@@ -525,10 +515,8 @@ static int qla_post_els_plogi_work(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return qla2x00_post_work(vha, e);
 }
 
-static void
-qla2x00_async_adisc_sp_done(void *ptr, int res)
+static void qla2x00_async_adisc_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct scsi_qla_host *vha = sp->vha;
 	struct event_arg ea;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
@@ -931,10 +919,8 @@ static void qla24xx_handle_gnl_done_event(scsi_qla_host_t *vha,
 	}
 } /* gnl_event */
 
-static void
-qla24xx_async_gnl_sp_done(void *s, int res)
+static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	unsigned long flags;
 	struct fc_port *fcport = NULL, *tf;
@@ -1121,10 +1107,8 @@ int qla24xx_post_gnl_work(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return qla2x00_post_work(vha, e);
 }
 
-static
-void qla24xx_async_gpdb_sp_done(void *s, int res)
+static void qla24xx_async_gpdb_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct qla_hw_data *ha = vha->hw;
 	fc_port_t *fcport = sp->fcport;
@@ -1168,10 +1152,8 @@ static int qla24xx_post_prli_work(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return qla2x00_post_work(vha, e);
 }
 
-static void
-qla2x00_async_prli_sp_done(void *ptr, int res)
+static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct scsi_qla_host *vha = sp->vha;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 	struct event_arg ea;
@@ -1808,10 +1790,8 @@ qla2x00_tmf_iocb_timeout(void *data)
 	complete(&tmf->u.tmf.comp);
 }
 
-static void
-qla2x00_tmf_sp_done(void *ptr, int res)
+static void qla2x00_tmf_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct srb_iocb *tmf = &sp->u.iocb_cmd;
 
 	complete(&tmf->u.tmf.comp);
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 2da7c92e320b..59a0a778d31c 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2544,10 +2544,8 @@ void qla2x00_init_timer(srb_t *sp, unsigned long tmo)
 	sp->start_timer = 1;
 }
 
-static void
-qla2x00_els_dcmd_sp_free(void *data)
+static void qla2x00_els_dcmd_sp_free(srb_t *sp)
 {
-	srb_t *sp = data;
 	struct srb_iocb *elsio = &sp->u.iocb_cmd;
 
 	kfree(sp->fcport);
@@ -2577,10 +2575,8 @@ qla2x00_els_dcmd_iocb_timeout(void *data)
 	complete(&lio->u.els_logo.comp);
 }
 
-static void
-qla2x00_els_dcmd_sp_done(void *ptr, int res)
+static void qla2x00_els_dcmd_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	fc_port_t *fcport = sp->fcport;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 	struct scsi_qla_host *vha = sp->vha;
@@ -2758,10 +2754,8 @@ qla2x00_els_dcmd2_iocb_timeout(void *data)
 	sp->done(sp, QLA_FUNCTION_TIMEOUT);
 }
 
-static void
-qla2x00_els_dcmd2_sp_done(void *ptr, int res)
+static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	fc_port_t *fcport = sp->fcport;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 	struct scsi_qla_host *vha = sp->vha;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 783a84606047..a82b6db2fa9d 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -6217,10 +6217,8 @@ qla26xx_dport_diagnostics(scsi_qla_host_t *vha,
 	return rval;
 }
 
-static void qla2x00_async_mb_sp_done(void *s, int res)
+static void qla2x00_async_mb_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
-
 	sp->u.iocb_cmd.u.mbx.rc = res;
 
 	complete(&sp->u.iocb_cmd.u.mbx.comp);
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index b2977e49356b..1a9a11ae7285 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -901,10 +901,8 @@ qla25xx_create_rsp_que(struct qla_hw_data *ha, uint16_t options,
 	return 0;
 }
 
-static void qla_ctrlvp_sp_done(void *s, int res)
+static void qla_ctrlvp_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
-
 	if (sp->comp)
 		complete(sp->comp);
 	/* don't free sp here. Let the caller do the free */
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 78b3679e1b9c..e8da3ec4db2c 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1797,10 +1797,8 @@ qla2x00_fxdisc_iocb_timeout(void *data)
 	complete(&lio->u.fxiocb.fxiocb_comp);
 }
 
-static void
-qla2x00_fxdisc_sp_done(void *ptr, int res)
+static void qla2x00_fxdisc_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 
 	complete(&lio->u.fxiocb.fxiocb_comp);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index bba25c38a118..af6b46777602 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -180,10 +180,9 @@ static void qla_nvme_ls_complete(struct work_struct *work)
 	kref_put(&priv->sp->cmd_kref, qla_nvme_release_ls_cmd_kref);
 }
 
-static void qla_nvme_sp_ls_done(void *ptr, int res)
+static void qla_nvme_sp_ls_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
-	struct nvme_private *priv;
+	struct nvme_private *priv = sp->priv;
 
 	if (WARN_ON_ONCE(kref_read(&sp->cmd_kref) == 0))
 		return;
@@ -191,17 +190,15 @@ static void qla_nvme_sp_ls_done(void *ptr, int res)
 	if (res)
 		res = -EINVAL;
 
-	priv = (struct nvme_private *)sp->priv;
 	priv->comp_status = res;
 	INIT_WORK(&priv->ls_work, qla_nvme_ls_complete);
 	schedule_work(&priv->ls_work);
 }
 
 /* it assumed that QPair lock is held. */
-static void qla_nvme_sp_done(void *ptr, int res)
+static void qla_nvme_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
-	struct nvme_private *priv = (struct nvme_private *)sp->priv;
+	struct nvme_private *priv = sp->priv;
 
 	priv->comp_status = res;
 	kref_put(&sp->cmd_kref, qla_nvme_release_fcp_cmd_kref);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index 68a8d09a36ef..25a2b82d5095 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -144,5 +144,5 @@ int  qla_nvme_register_remote(struct scsi_qla_host *, struct fc_port *);
 void qla_nvme_delete(struct scsi_qla_host *);
 void qla24xx_nvme_ls4_iocb(struct scsi_qla_host *, struct pt_ls4_request *,
     struct req_que *);
-void qla24xx_async_gffid_sp_done(void *, int);
+void qla24xx_async_gffid_sp_done(struct srb *sp, int);
 #endif
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index a247dce0cb95..9ef59995f5d6 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -652,10 +652,8 @@ qla24xx_fw_version_str(struct scsi_qla_host *vha, char *str, size_t size)
 	return str;
 }
 
-void
-qla2x00_sp_free_dma(void *ptr)
+void qla2x00_sp_free_dma(srb_t *sp)
 {
-	srb_t *sp = ptr;
 	struct qla_hw_data *ha = sp->vha->hw;
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	void *ctx = GET_CMD_CTX_SP(sp);
@@ -699,10 +697,8 @@ qla2x00_sp_free_dma(void *ptr)
 	}
 }
 
-void
-qla2x00_sp_compl(void *ptr, int res)
+void qla2x00_sp_compl(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct completion *comp = sp->comp;
 
@@ -720,10 +716,8 @@ qla2x00_sp_compl(void *ptr, int res)
 	qla2x00_rel_sp(sp);
 }
 
-void
-qla2xxx_qpair_sp_free_dma(void *ptr)
+void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 {
-	srb_t *sp = (srb_t *)ptr;
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct qla_hw_data *ha = sp->fcport->vha->hw;
 	void *ctx = GET_CMD_CTX_SP(sp);
@@ -804,10 +798,8 @@ qla2xxx_qpair_sp_free_dma(void *ptr)
 	}
 }
 
-void
-qla2xxx_qpair_sp_compl(void *ptr, int res)
+void qla2xxx_qpair_sp_compl(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct completion *comp = sp->comp;
 
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index f7b72d1d4862..d25c3fa43601 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -559,10 +559,8 @@ static int qla24xx_post_nack_work(struct scsi_qla_host *vha, fc_port_t *fcport,
 	return qla2x00_post_work(vha, e);
 }
 
-static
-void qla2x00_async_nack_sp_done(void *s, int res)
+static void qla2x00_async_nack_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = (struct srb *)s;
 	struct scsi_qla_host *vha = sp->vha;
 	unsigned long flags;
 
-- 
2.22.0

