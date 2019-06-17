Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46F949182
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfFQUjC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:39:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37504 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUjC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:39:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id n65so1963418pga.4
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyY2w6M/fY2z6+VQPMLwCZXpwwizMdW8D5MQRQc2zS4=;
        b=XGh48ii/lhsBY7RFo2WSU0itf/Wo2icH5Nf/+53y8w93811ac7xaHtsFiw2PnRP4af
         /NWTnSRWIfhfYUpfXDpxIgwaqPf/NT6T0RJqURoKnvlJMRlma8QFcJAPRF5Q1q28h+47
         kBtl6Fw+/TckPjZIhXLB4bCuvV2pO3S1T4deFO15f4N38kcFWVduAgl8Kgmu7RDDM1Va
         /blzlXmb1da1KZlf/st8OpaFvE/WOw5VnwRzGIMu5MQtf9OwCxQZkrBqhyYSVXJXNkGS
         HqR3p2ngXeYSLca3gee+r95M4cdktA0cFcbbaRHpy/B5UebdtbysUk3/L+CtigkCExcp
         5XWQ==
X-Gm-Message-State: APjAAAVCTfxc1RH0gHAQH59O7+h4vyi/XFKG+eLSweoF2MUu3IWC8s6d
        9GWKqquKzjngccFYdGsM4cs=
X-Google-Smtp-Source: APXvYqyYJBeybupLJS/Gg6Ad2UDVK3UqaLMUteSPPobRvyrT4P5gZnyRMschQT/WHaUPXreixZsvdA==
X-Received: by 2002:a17:90a:8c0c:: with SMTP id a12mr890392pjo.67.1560803940724;
        Mon, 17 Jun 2019 13:39:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm16835620pfk.72.2019.06.17.13.38.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:38:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 3/6] qla2xxx: Enable type checking for the SRB free and done callback functions
Date:   Mon, 17 Jun 2019 13:38:44 -0700
Message-Id: <20190617203847.184407-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617203847.184407-1-bvanassche@acm.org>
References: <20190617203847.184407-1-bvanassche@acm.org>
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
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c    |  8 ++-----
 drivers/scsi/qla2xxx/qla_def.h    |  6 +++--
 drivers/scsi/qla2xxx/qla_gbl.h    | 14 +++++------
 drivers/scsi/qla2xxx/qla_gs.c     | 21 ++++++----------
 drivers/scsi/qla2xxx/qla_init.c   | 40 ++++++++-----------------------
 drivers/scsi/qla2xxx/qla_iocb.c   | 12 +++-------
 drivers/scsi/qla2xxx/qla_mbx.c    |  4 +---
 drivers/scsi/qla2xxx/qla_mid.c    |  4 +---
 drivers/scsi/qla2xxx/qla_mr.c     |  4 +---
 drivers/scsi/qla2xxx/qla_nvme.c   |  6 ++---
 drivers/scsi/qla2xxx/qla_nvme.h   |  2 +-
 drivers/scsi/qla2xxx/qla_os.c     | 16 ++++---------
 drivers/scsi/qla2xxx/qla_target.c |  4 +---
 13 files changed, 44 insertions(+), 97 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 5441557b424b..d545263d73a1 100644
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
index 1a4095c56eee..78c5405482f6 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -552,8 +552,10 @@ typedef struct srb {
 		struct bsg_job *bsg_job;
 		struct srb_cmd scmd;
 	} u;
-	void (*done)(void *, int);
-	void (*free)(void *);
+	/* Report completion status @res and call sp_put(@sp). */
+	void (*done)(struct srb *sp, int res);
+	/* Stop the timer and free @sp. */
+	void (*free)(struct srb *sp);
 } srb_t;
 
 #define GET_CMD_SP(sp) (sp->u.scmd.cmd)
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index bbe69ab5cf3f..aaa78f1020a7 100644
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
index 9f58e591666d..013d64d2be10 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -509,9 +509,8 @@ qla2x00_gnn_id(scsi_qla_host_t *vha, sw_info_t *list)
 	return (rval);
 }
 
-static void qla2x00_async_sns_sp_done(void *s, int rc)
+static void qla2x00_async_sns_sp_done(srb_t *sp, int rc)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct ct_sns_pkt *ct_sns;
 	struct qla_work_evt *e;
@@ -3011,9 +3010,8 @@ void qla24xx_handle_gpsc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	qla_post_iidma_work(vha, fcport);
 }
 
-static void qla24xx_async_gpsc_sp_done(void *s, int res)
+static void qla24xx_async_gpsc_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct qla_hw_data *ha = vha->hw;
 	fc_port_t *fcport = sp->fcport;
@@ -3280,9 +3278,8 @@ void qla24xx_handle_gpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	}
 }
 
-static void qla2x00_async_gpnid_sp_done(void *s, int res)
+static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct ct_sns_req *ct_req =
 	    (struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
@@ -3472,9 +3469,8 @@ void qla24xx_handle_gffid_event(scsi_qla_host_t *vha, struct event_arg *ea)
        qla24xx_post_gnl_work(vha, fcport);
 }
 
-void qla24xx_async_gffid_sp_done(void *s, int res)
+void qla24xx_async_gffid_sp_done(srb_t *sp, int res)
 {
-       struct srb *sp = s;
        struct scsi_qla_host *vha = sp->vha;
        fc_port_t *fcport = sp->fcport;
        struct ct_sns_rsp *ct_rsp;
@@ -3898,9 +3894,8 @@ static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
 	}
 }
 
-static void qla2x00_async_gpnft_gnnft_sp_done(void *s, int res)
+static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	struct ct_sns_req *ct_req =
 		(struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
@@ -4261,9 +4256,8 @@ void qla24xx_handle_gnnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	qla24xx_post_gnl_work(vha, ea->fcport);
 }
 
-static void qla2x00_async_gnnid_sp_done(void *s, int res)
+static void qla2x00_async_gnnid_sp_done(srb_t *sp, int res)
 {
-	struct srb *sp = s;
 	struct scsi_qla_host *vha = sp->vha;
 	fc_port_t *fcport = sp->fcport;
 	u8 *node_name = fcport->ct_desc.ct_sns->p.rsp.rsp.gnn_id.node_name;
@@ -4396,9 +4390,8 @@ void qla24xx_handle_gfpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
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
index 4059655639d9..fc46343f3363 100644
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
@@ -104,9 +102,8 @@ static void qla24xx_abort_iocb_timeout(void *data)
 	sp->done(sp, QLA_FUNCTION_TIMEOUT);
 }
 
-static void qla24xx_abort_sp_done(void *ptr, int res)
+static void qla24xx_abort_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
 
 	if (del_timer(&sp->u.iocb_cmd.timer)) {
@@ -237,10 +234,8 @@ qla2x00_async_iocb_timeout(void *data)
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
@@ -341,11 +336,8 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
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
@@ -405,10 +397,8 @@ qla2x00_async_prlo_done(struct scsi_qla_host *vha, fc_port_t *fcport,
 	qlt_logo_completion_handler(fcport, data[0]);
 }
 
-static void
-qla2x00_async_prlo_sp_done(void *s, int res)
+static void qla2x00_async_prlo_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = (srb_t *)s;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 	struct scsi_qla_host *vha = sp->vha;
 
@@ -511,10 +501,8 @@ static int qla_post_els_plogi_work(struct scsi_qla_host *vha, fc_port_t *fcport)
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
@@ -917,10 +905,8 @@ static void qla24xx_handle_gnl_done_event(scsi_qla_host_t *vha,
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
@@ -1107,10 +1093,8 @@ int qla24xx_post_gnl_work(struct scsi_qla_host *vha, fc_port_t *fcport)
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
@@ -1154,10 +1138,8 @@ static int qla24xx_post_prli_work(struct scsi_qla_host *vha, fc_port_t *fcport)
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
@@ -1789,10 +1771,8 @@ qla2x00_tmf_iocb_timeout(void *data)
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
index 9312b19ed708..77f3ea4c8a80 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2543,10 +2543,8 @@ void qla2x00_init_timer(srb_t *sp, unsigned long tmo)
 	add_timer(&sp->u.iocb_cmd.timer);
 }
 
-static void
-qla2x00_els_dcmd_sp_free(void *data)
+static void qla2x00_els_dcmd_sp_free(srb_t *sp)
 {
-	srb_t *sp = data;
 	struct srb_iocb *elsio = &sp->u.iocb_cmd;
 
 	kfree(sp->fcport);
@@ -2576,10 +2574,8 @@ qla2x00_els_dcmd_iocb_timeout(void *data)
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
@@ -2755,10 +2751,8 @@ qla2x00_els_dcmd2_iocb_timeout(void *data)
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
index 133f5f6270ff..8b62f1d6ab9f 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -6213,10 +6213,8 @@ qla26xx_dport_diagnostics(scsi_qla_host_t *vha,
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
index 942ee13b96a4..8606aee03ccf 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1799,10 +1799,8 @@ qla2x00_fxdisc_iocb_timeout(void *data)
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
index 22e3fba28e51..01f1c2e6180f 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -124,9 +124,8 @@ static int qla_nvme_alloc_queue(struct nvme_fc_local_port *lport,
 	return 0;
 }
 
-static void qla_nvme_sp_ls_done(void *ptr, int res)
+static void qla_nvme_sp_ls_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct srb_iocb *nvme;
 	struct nvmefc_ls_req   *fd;
 	struct nvme_private *priv;
@@ -148,9 +147,8 @@ static void qla_nvme_sp_ls_done(void *ptr, int res)
 	qla2x00_rel_sp(sp);
 }
 
-static void qla_nvme_sp_done(void *ptr, int res)
+static void qla_nvme_sp_done(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct srb_iocb *nvme;
 	struct nvmefc_fcp_req *fd;
 
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index d3b8a6440113..febb076285e7 100644
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
index 1ab472799938..7768b8462942 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -662,10 +662,8 @@ qla24xx_fw_version_str(struct scsi_qla_host *vha, char *str, size_t size)
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
@@ -709,10 +707,8 @@ qla2x00_sp_free_dma(void *ptr)
 	}
 }
 
-void
-qla2x00_sp_compl(void *ptr, int res)
+void qla2x00_sp_compl(srb_t *sp, int res)
 {
-	srb_t *sp = ptr;
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct completion *comp = sp->comp;
 
@@ -730,10 +726,8 @@ qla2x00_sp_compl(void *ptr, int res)
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
@@ -814,10 +808,8 @@ qla2xxx_qpair_sp_free_dma(void *ptr)
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
index 3eeae72793bc..ac5b1aea6742 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -569,10 +569,8 @@ static int qla24xx_post_nack_work(struct scsi_qla_host *vha, fc_port_t *fcport,
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
2.22.0.rc3

