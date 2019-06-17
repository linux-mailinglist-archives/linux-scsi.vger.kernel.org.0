Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8B49184
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfFQUjF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:39:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41980 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUjF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:39:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so6286159pff.8
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOtkAEiEC73GZ9qXNucQOymOq7BS8tTvix/1DIOezUg=;
        b=tRt3LENwEMD6//aJiT/jCsjnfqvbXHclOLgJ8DG/YPp888F+gPvuVxAtpcz52OAT5l
         RHtc861xLJgSwwui76Um2p65GIpvqO2q0plcpVgOc70fUOUDqm1GHB+TggKgNcdDhbaJ
         OrkuaekakqOUehQyz65iXvSIsiM83VdjnsbQMcidtdKOYWxEnWU+RrO5xKRHaSUwZqbS
         7ioqFwd8eTfTxgkfj3qimJei4B3w8bmtqKRZEV9IIr7ZIkOyyS8JhXGxjHaj3Gc32HGY
         uCoXNBeNYOcpr8wsg8AUmUYW0LAE8w8M2t9/V/JgXQRbAQSkp8e4df+Mq0p8pP2UdINd
         hERg==
X-Gm-Message-State: APjAAAW0aDURKvO2S1fQuYfRe7339XT1/o2esDhpvzm6SXgTLvacU1xe
        1mYBAZfMg0IA4JvmGxfis1I=
X-Google-Smtp-Source: APXvYqywLxeJLN7UguNNIwrNnAVx4Uhn5NliDfSuGzlvBZaWGHidVwUxA9pAxLzf+jvHo08L4mnQEw==
X-Received: by 2002:a17:90a:2343:: with SMTP id f61mr929580pje.130.1560803943866;
        Mon, 17 Jun 2019 13:39:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm16835620pfk.72.2019.06.17.13.39.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:39:02 -0700 (PDT)
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
Subject: [PATCH 5/6] qla2xxx: Make the code for freeing SRBs more systematic
Date:   Mon, 17 Jun 2019 13:38:46 -0700
Message-Id: <20190617203847.184407-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617203847.184407-1-bvanassche@acm.org>
References: <20190617203847.184407-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For each SRB type, make the free function free all memory associated
with the SRB. Initialize the .free() function pointer after the
qla2x00_init_timer() call and before the first sp->free(sp) call to
make sure that all sp->free(sp) calls call the right .free() function.
Remove the qla24xx_sp_unmap() function because it is no longer
necessary.

This patch fixes a memory leak in the timeout handling code in
qla24xx_async_gpdb_sp_done().

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |   2 +-
 drivers/scsi/qla2xxx/qla_gbl.h  |   1 -
 drivers/scsi/qla2xxx/qla_gs.c   | 209 ++++++++++++++------------------
 drivers/scsi/qla2xxx/qla_init.c |  24 ++--
 drivers/scsi/qla2xxx/qla_iocb.c |  48 ++++----
 drivers/scsi/qla2xxx/qla_nvme.c |  18 ++-
 drivers/scsi/qla2xxx/qla_os.c   |   4 +-
 7 files changed, 142 insertions(+), 164 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 78c5405482f6..3f398475d658 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -395,7 +395,7 @@ struct srb_iocb {
 			struct els_logo_payload *els_logo_pyld;
 			dma_addr_t els_logo_pyld_dma;
 		} els_logo;
-		struct {
+		struct els_plogi {
 #define ELS_DCMD_PLOGI 0x3
 			uint32_t flags;
 			uint32_t els_cmd;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index aaa78f1020a7..b3affe8ddf29 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -676,7 +676,6 @@ int qla24xx_post_gnnid_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_post_gfpnid_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_async_gfpnid(scsi_qla_host_t *, fc_port_t *);
 void qla24xx_handle_gfpnid_event(scsi_qla_host_t *, struct event_arg *);
-void qla24xx_sp_unmap(scsi_qla_host_t *, srb_t *);
 void qla_scan_work_fn(struct work_struct *);
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 013d64d2be10..863f98ac6a30 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -509,6 +509,28 @@ qla2x00_gnn_id(scsi_qla_host_t *vha, sw_info_t *list)
 	return (rval);
 }
 
+static void qla2x00_async_sns_sp_free(srb_t *sp)
+{
+	struct scsi_qla_host *vha = sp->vha;
+	struct ct_arg *ctarg = &sp->u.iocb_cmd.u.ctarg;
+
+	if (&ctarg->rsp) {
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  ctarg->rsp_allocated_size, ctarg->rsp,
+				  ctarg->rsp_dma);
+		ctarg->rsp = NULL;
+	}
+
+	if (&ctarg->req) {
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  ctarg->req_allocated_size, ctarg->req,
+				  ctarg->req_dma);
+		ctarg->req = NULL;
+	}
+
+	qla2x00_sp_free(sp);
+}
+
 static void qla2x00_async_sns_sp_done(srb_t *sp, int rc)
 {
 	struct scsi_qla_host *vha = sp->vha;
@@ -549,24 +571,7 @@ static void qla2x00_async_sns_sp_done(srb_t *sp, int rc)
 err2:
 	if (!e) {
 		/* please ignore kernel warning. otherwise, we have mem leak. */
-		if (sp->u.iocb_cmd.u.ctarg.req) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-			    sp->u.iocb_cmd.u.ctarg.req,
-			    sp->u.iocb_cmd.u.ctarg.req_dma);
-			sp->u.iocb_cmd.u.ctarg.req = NULL;
-		}
-
-		if (sp->u.iocb_cmd.u.ctarg.rsp) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-			    sp->u.iocb_cmd.u.ctarg.rsp,
-			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
-			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-		}
-
 		sp->free(sp);
-
 		return;
 	}
 
@@ -608,6 +613,8 @@ static int qla_async_rftid(scsi_qla_host_t *vha, port_id_t *d_id)
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rft_id";
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->free = qla2x00_async_sns_sp_free;
+	sp->done = qla2x00_async_sns_sp_done;
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -650,7 +657,6 @@ static int qla_async_rftid(scsi_qla_host_t *vha, port_id_t *d_id)
 	sp->u.iocb_cmd.u.ctarg.rsp_size = RFT_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x portid %06x.\n",
@@ -706,6 +712,8 @@ static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rff_id";
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->free = qla2x00_async_sns_sp_free;
+	sp->done = qla2x00_async_sns_sp_done;
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -746,7 +754,6 @@ static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
 	sp->u.iocb_cmd.u.ctarg.rsp_size = RFF_ID_RSP_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x portid %06x feature %x type %x.\n",
@@ -799,6 +806,8 @@ static int qla_async_rnnid(scsi_qla_host_t *vha, port_id_t *d_id,
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rnid";
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->free = qla2x00_async_sns_sp_free;
+	sp->done = qla2x00_async_sns_sp_done;
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -839,7 +848,6 @@ static int qla_async_rnnid(scsi_qla_host_t *vha, port_id_t *d_id,
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x portid %06x\n",
@@ -909,6 +917,8 @@ static int qla_async_rsnn_nn(scsi_qla_host_t *vha)
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "rsnn_nn";
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->free = qla2x00_async_sns_sp_free;
+	sp->done = qla2x00_async_sns_sp_done;
 
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
@@ -953,7 +963,6 @@ static int qla_async_rsnn_nn(scsi_qla_host_t *vha)
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_sns_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s - hdl=%x.\n",
@@ -3136,47 +3145,6 @@ int qla24xx_post_gpnid_work(struct scsi_qla_host *vha, port_id_t *id)
 	return qla2x00_post_work(vha, e);
 }
 
-void qla24xx_sp_unmap(scsi_qla_host_t *vha, srb_t *sp)
-{
-	struct srb_iocb *c = &sp->u.iocb_cmd;
-
-	switch (sp->type) {
-	case SRB_ELS_DCMD:
-		if (c->u.els_plogi.els_plogi_pyld)
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    c->u.els_plogi.tx_size,
-			    c->u.els_plogi.els_plogi_pyld,
-			    c->u.els_plogi.els_plogi_pyld_dma);
-
-		if (c->u.els_plogi.els_resp_pyld)
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    c->u.els_plogi.rx_size,
-			    c->u.els_plogi.els_resp_pyld,
-			    c->u.els_plogi.els_resp_pyld_dma);
-		break;
-	case SRB_CT_PTHRU_CMD:
-	default:
-		if (sp->u.iocb_cmd.u.ctarg.req) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-			    sp->u.iocb_cmd.u.ctarg.req,
-			    sp->u.iocb_cmd.u.ctarg.req_dma);
-			sp->u.iocb_cmd.u.ctarg.req = NULL;
-		}
-
-		if (sp->u.iocb_cmd.u.ctarg.rsp) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-			    sp->u.iocb_cmd.u.ctarg.rsp,
-			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
-			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-		}
-		break;
-	}
-
-	sp->free(sp);
-}
-
 void qla24xx_handle_gpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
 	fc_port_t *fcport, *conflict, *t;
@@ -3278,6 +3246,33 @@ void qla24xx_handle_gpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 	}
 }
 
+static void qla2x00_async_gpnid_sp_free(srb_t *sp)
+{
+	struct scsi_qla_host *vha = sp->vha;
+	struct ct_arg *ctarg = &sp->u.iocb_cmd.u.ctarg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vha->hw->vport_slock, flags);
+	list_del_init(&sp->elem);
+	spin_unlock_irqrestore(&vha->hw->vport_slock, flags);
+
+	if (ctarg->rsp) {
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  ctarg->rsp_allocated_size, ctarg->rsp,
+				  ctarg->rsp_dma);
+		ctarg->rsp = NULL;
+	}
+
+	if (ctarg->req) {
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  ctarg->req_allocated_size, ctarg->req,
+				  ctarg->req_dma);
+		ctarg->req = NULL;
+	}
+
+	qla2x00_sp_free(sp);
+}
+
 static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 {
 	struct scsi_qla_host *vha = sp->vha;
@@ -3310,7 +3305,7 @@ static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 	ea.event = FCME_GPNID_DONE;
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
-	list_del(&sp->elem);
+	list_del_init(&sp->elem);
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
 	if (res) {
@@ -3331,21 +3326,6 @@ static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 	e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
 	if (!e) {
 		/* please ignore kernel warning. otherwise, we have mem leak. */
-		if (sp->u.iocb_cmd.u.ctarg.req) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-				sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-				sp->u.iocb_cmd.u.ctarg.req,
-				sp->u.iocb_cmd.u.ctarg.req_dma);
-			sp->u.iocb_cmd.u.ctarg.req = NULL;
-		}
-		if (sp->u.iocb_cmd.u.ctarg.rsp) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-				sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-				sp->u.iocb_cmd.u.ctarg.rsp,
-				sp->u.iocb_cmd.u.ctarg.rsp_dma);
-			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-		}
-
 		sp->free(sp);
 		return;
 	}
@@ -3375,6 +3355,8 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 	sp->u.iocb_cmd.u.ctarg.id = *id;
 	sp->gen1 = 0;
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->free = qla2x00_async_gpnid_sp_free;
+	sp->done = qla2x00_async_gpnid_sp_done;
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	list_for_each_entry(tsp, &vha->gpnid_list, elem) {
@@ -3425,7 +3407,6 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
-	sp->done = qla2x00_async_gpnid_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0x2067,
 	    "Async-%s hdl=%x ID %3phC.\n", sp->name,
@@ -3438,25 +3419,6 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 	return rval;
 
 done_free_sp:
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
-
 	sp->free(sp);
 done:
 	return rval;
@@ -3747,7 +3709,7 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 
 	recheck = 1;
 out:
-	qla24xx_sp_unmap(vha, sp);
+	sp->free(sp);
 	spin_lock_irqsave(&vha->work_lock, flags);
 	vha->scan.scan_flags &= ~SF_SCANNING;
 	spin_unlock_irqrestore(&vha->work_lock, flags);
@@ -3894,6 +3856,26 @@ static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
 	}
 }
 
+static void qla2x00_async_gpnft_gnnft_sp_free(srb_t *sp)
+{
+	struct scsi_qla_host *vha = sp->vha;
+	struct ct_arg *ctarg = &sp->u.iocb_cmd.u.ctarg;
+
+	if (ctarg->rsp) {
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  ctarg->rsp_allocated_size, ctarg->rsp,
+				  ctarg->rsp_dma);
+		ctarg->rsp = NULL;
+	}
+	if (ctarg->req) {
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  ctarg->req_allocated_size, ctarg->req,
+				  ctarg->req_dma);
+		ctarg->req = NULL;
+	}
+	qla2x00_sp_free(sp);
+}
+
 static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 {
 	struct scsi_qla_host *vha = sp->vha;
@@ -3924,7 +3906,7 @@ static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 		    QLA_EVT_GNNFT_DONE);
 		if (rc) {
 			/* Cleanup here to prevent memory leak */
-			qla24xx_sp_unmap(vha, sp);
+			sp->free(sp);
 
 			spin_lock_irqsave(&vha->work_lock, flags);
 			vha->scan.scan_flags &= ~SF_SCANNING;
@@ -3955,7 +3937,7 @@ static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 		sp->rc = res;
 		rc = qla2x00_post_nvme_gpnft_work(vha, sp, QLA_EVT_GPNFT);
 		if (rc) {
-			qla24xx_sp_unmap(vha, sp);
+			sp->free(sp);
 			set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
 			set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
 		}
@@ -3971,7 +3953,7 @@ static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 	}
 
 	if (rc) {
-		qla24xx_sp_unmap(vha, sp);
+		sp->free(sp);
 		set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
 		set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
 		return;
@@ -4025,6 +4007,8 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->free = qla2x00_async_gpnft_gnnft_sp_free;
+	sp->done = qla2x00_async_gpnft_gnnft_sp_done;
 
 	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
 	memset(sp->u.iocb_cmd.u.ctarg.req, 0, sp->u.iocb_cmd.u.ctarg.req_size);
@@ -4040,8 +4024,6 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 	sp->u.iocb_cmd.u.ctarg.req_size = GNN_FT_REQ_SIZE;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->done = qla2x00_async_gpnft_gnnft_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s hdl=%x FC4Type %x.\n", sp->name,
 	    sp->handle, ct_req->req.gpn_ft.port_type);
@@ -4057,21 +4039,6 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 	return rval;
 
 done_free_sp:
-	if (sp->u.iocb_cmd.u.ctarg.req) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-		    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-		    sp->u.iocb_cmd.u.ctarg.req,
-		    sp->u.iocb_cmd.u.ctarg.req_dma);
-		sp->u.iocb_cmd.u.ctarg.req = NULL;
-	}
-	if (sp->u.iocb_cmd.u.ctarg.rsp) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-		    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-		    sp->u.iocb_cmd.u.ctarg.rsp,
-		    sp->u.iocb_cmd.u.ctarg.rsp_dma);
-		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-	}
-
 	sp->free(sp);
 
 	return rval;
@@ -4181,6 +4148,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
+	sp->free = qla2x00_async_gpnft_gnnft_sp_free;
+	sp->done = qla2x00_async_gpnft_gnnft_sp_done;
 
 	rspsz = sp->u.iocb_cmd.u.ctarg.rsp_size;
 	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
@@ -4195,8 +4164,6 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	sp->done = qla2x00_async_gpnft_gnnft_sp_done;
-
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
 	    "Async-%s hdl=%x FC4Type %x.\n", sp->name,
 	    sp->handle, ct_req->req.gpn_ft.port_type);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index fc46343f3363..3439cbb3c952 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1093,10 +1093,20 @@ int qla24xx_post_gnl_work(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return qla2x00_post_work(vha, e);
 }
 
-static void qla24xx_async_gpdb_sp_done(srb_t *sp, int res)
+static void qla24xx_async_gpdb_sp_free(srb_t *sp)
 {
 	struct scsi_qla_host *vha = sp->vha;
 	struct qla_hw_data *ha = vha->hw;
+
+	if (sp->u.iocb_cmd.u.mbx.in)
+		dma_pool_free(ha->s_dma_pool, sp->u.iocb_cmd.u.mbx.in,
+			      sp->u.iocb_cmd.u.mbx.in_dma);
+	qla2x00_sp_free(sp);
+}
+
+static void qla24xx_async_gpdb_sp_done(srb_t *sp, int res)
+{
+	struct scsi_qla_host *vha = sp->vha;
 	fc_port_t *fcport = sp->fcport;
 	u16 *mb = sp->u.iocb_cmd.u.mbx.in_mb;
 	struct event_arg ea;
@@ -1105,11 +1115,8 @@ static void qla24xx_async_gpdb_sp_done(srb_t *sp, int res)
 	    "Async done-%s res %x, WWPN %8phC mb[1]=%x mb[2]=%x \n",
 	    sp->name, res, fcport->port_name, mb[1], mb[2]);
 
-	if (res == QLA_FUNCTION_TIMEOUT) {
-		dma_pool_free(sp->vha->hw->s_dma_pool, sp->u.iocb_cmd.u.mbx.in,
-			sp->u.iocb_cmd.u.mbx.in_dma);
-		return;
-	}
+	if (res == QLA_FUNCTION_TIMEOUT)
+		goto free_sp;
 
 	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 	memset(&ea, 0, sizeof(ea));
@@ -1119,9 +1126,7 @@ static void qla24xx_async_gpdb_sp_done(srb_t *sp, int res)
 
 	qla2x00_fcport_event_handler(vha, &ea);
 
-	dma_pool_free(ha->s_dma_pool, sp->u.iocb_cmd.u.mbx.in,
-		sp->u.iocb_cmd.u.mbx.in_dma);
-
+free_sp:
 	sp->free(sp);
 }
 
@@ -1283,6 +1288,7 @@ int qla24xx_async_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport, u8 opt)
 	mbx->u.mbx.in = (void *)pd;
 	mbx->u.mbx.in_dma = pd_dma;
 
+	sp->free = qla24xx_async_gpdb_sp_free;
 	sp->done = qla24xx_async_gpdb_sp_done;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20dc,
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 77f3ea4c8a80..42dbe11fbb14 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2751,6 +2751,27 @@ qla2x00_els_dcmd2_iocb_timeout(void *data)
 	sp->done(sp, QLA_FUNCTION_TIMEOUT);
 }
 
+static void qla2x00_els_dcmd2_sp_free(srb_t *sp)
+{
+	struct scsi_qla_host *vha = sp->vha;
+	struct srb_iocb *elsio = &sp->u.iocb_cmd;
+	struct els_plogi *els_plogi = &elsio->u.els_plogi;
+
+	if (els_plogi->els_plogi_pyld)
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  els_plogi->tx_size,
+				  els_plogi->els_plogi_pyld,
+				  els_plogi->els_plogi_pyld_dma);
+
+	if (els_plogi->els_resp_pyld)
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  els_plogi->rx_size,
+				  els_plogi->els_resp_pyld,
+				  els_plogi->els_resp_pyld_dma);
+
+	qla2x00_sp_free(sp);
+}
+
 static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 {
 	fc_port_t *fcport = sp->fcport;
@@ -2781,19 +2802,6 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 
 		e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
 		if (!e) {
-			struct srb_iocb *elsio = &sp->u.iocb_cmd;
-
-			if (elsio->u.els_plogi.els_plogi_pyld)
-				dma_free_coherent(&sp->vha->hw->pdev->dev,
-				    elsio->u.els_plogi.tx_size,
-				    elsio->u.els_plogi.els_plogi_pyld,
-				    elsio->u.els_plogi.els_plogi_pyld_dma);
-
-			if (elsio->u.els_plogi.els_resp_pyld)
-				dma_free_coherent(&sp->vha->hw->pdev->dev,
-				    elsio->u.els_plogi.rx_size,
-				    elsio->u.els_plogi.els_resp_pyld,
-				    elsio->u.els_plogi.els_resp_pyld_dma);
 			sp->free(sp);
 			return;
 		}
@@ -2835,7 +2843,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 		sp->flags = SRB_WAKEUP_ON_COMP;
 
 	qla2x00_init_timer(sp, ELS_DCMD_TIMEOUT + 2);
-
+	sp->free = qla2x00_els_dcmd2_sp_free;
 	sp->done = qla2x00_els_dcmd2_sp_done;
 	elsio->u.els_plogi.tx_size = elsio->u.els_plogi.rx_size = DMA_POOL_SIZE;
 
@@ -2893,18 +2901,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 out:
 	fcport->flags &= ~(FCF_ASYNC_SENT);
-	if (elsio->u.els_plogi.els_plogi_pyld)
-		dma_free_coherent(&sp->vha->hw->pdev->dev,
-		    elsio->u.els_plogi.tx_size,
-		    elsio->u.els_plogi.els_plogi_pyld,
-		    elsio->u.els_plogi.els_plogi_pyld_dma);
-
-	if (elsio->u.els_plogi.els_resp_pyld)
-		dma_free_coherent(&sp->vha->hw->pdev->dev,
-		    elsio->u.els_plogi.rx_size,
-		    elsio->u.els_plogi.els_resp_pyld,
-		    elsio->u.els_plogi.els_resp_pyld_dma);
-
 	sp->free(sp);
 done:
 	return rval;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index fc0c57ecab25..07f83d161304 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -124,6 +124,11 @@ static int qla_nvme_alloc_queue(struct nvme_fc_local_port *lport,
 	return 0;
 }
 
+static void qla_nvme_sp_ls_free(srb_t *sp)
+{
+	qla2x00_rel_sp(sp);
+}
+
 static void qla_nvme_sp_ls_done(srb_t *sp, int res)
 {
 	struct srb_iocb *nvme;
@@ -144,7 +149,12 @@ static void qla_nvme_sp_ls_done(srb_t *sp, int res)
 	priv->comp_status = res;
 	schedule_work(&priv->ls_work);
 	/* work schedule doesn't need the sp */
-	qla2x00_rel_sp(sp);
+	sp->free(sp);
+}
+
+static void qla_nvme_sp_free(srb_t *sp)
+{
+	qla2xxx_rel_qpair_sp(sp->qpair, sp);
 }
 
 static void qla_nvme_sp_done(srb_t *sp, int res)
@@ -168,9 +178,7 @@ static void qla_nvme_sp_done(srb_t *sp, int res)
 	}
 	fd->status = 0;
 	fd->done(fd);
-	qla2xxx_rel_qpair_sp(sp->qpair, sp);
-
-	return;
+	sp->free(sp);
 }
 
 static void qla_nvme_abort_work(struct work_struct *work)
@@ -247,6 +255,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 
 	sp->type = SRB_NVME_LS;
 	sp->name = "nvme_ls";
+	sp->free = qla_nvme_sp_ls_free;
 	sp->done = qla_nvme_sp_ls_done;
 	nvme = &sp->u.iocb_cmd;
 	priv->sp = sp;
@@ -508,6 +517,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
 	sp->name = "nvme_cmd";
+	sp->free = qla_nvme_sp_free;
 	sp->done = qla_nvme_sp_done;
 	sp->qpair = qpair;
 	sp->vha = vha;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7b9f138ad9e4..619ab9b84b08 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5177,7 +5177,7 @@ static void qla_sp_retry(struct scsi_qla_host *vha, struct qla_work_evt *e)
 		ql_dbg(ql_dbg_disc, vha, 0x2043,
 		    "%s: %s: Re-issue IOCB failed (%d).\n",
 		    __func__, sp->name, rval);
-		qla24xx_sp_unmap(vha, sp);
+		sp->free(sp);
 	}
 }
 
@@ -5228,7 +5228,7 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 			qla24xx_async_gpnid(vha, &e->u.gpnid.id);
 			break;
 		case QLA_EVT_UNMAP:
-			qla24xx_sp_unmap(vha, e->u.iosb.sp);
+			e->u.iosb.sp->free(e->u.iosb.sp);
 			break;
 		case QLA_EVT_RELOGIN:
 			qla2x00_relogin(vha);
-- 
2.22.0.rc3

