Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2349185
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfFQUjG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:39:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34479 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUjG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:39:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so6438898pgn.1
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yf+ZoN47IROO2u9hxZk7hjPb57pp4fG1dOu/8anw6S4=;
        b=HpmoSpJRxD6lZxaUGPkClC2BC+i+6vZbphVUV+Psup47T7ToE1M7C1hS8SCstFC4z/
         pb/avmlw+8q5uwSkFW/AvKkeKIkqpMaOabuqDsMRYo1S79LZ1eTVifMMgwzFWlrOcGJj
         7RUSzfqm9MDTrS06Sbk+HyVdSRJjvjs3eJ8OnauQWJSdgLTe0D9f5mtwAjk8444i6byq
         dxIY+GlpQAMZZJNi00bTtNq7kKW7aJW9OlLNcKQegYRT5cipfxaCaLArnQPKtsoCx23B
         zok9A1rV/C7OSyXZO1PissY0Mn6sFovKZEMRZqubf/Wyxr+WzquEdv5klROzm5hfenja
         wTQg==
X-Gm-Message-State: APjAAAW8OE7w47XPF+CwBd9tICwrq5zXvWNrElMBC6ZMdP3MxfvJ65pq
        U6WKWrPdfAm0sWPpBqQmxSc=
X-Google-Smtp-Source: APXvYqzzYMkfFAYGYwABQ7aJe+SKuiktPIHuWB0iSnfP92rJd2340Fd0pRE2KU9lzXIfbp4Hs20hiQ==
X-Received: by 2002:a17:90a:30aa:: with SMTP id h39mr943400pjb.32.1560803945126;
        Mon, 17 Jun 2019 13:39:05 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm16835620pfk.72.2019.06.17.13.39.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:39:04 -0700 (PDT)
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
Subject: [PATCH 6/6] qla2xxx: Only free an SRB once the reference count drops to zero
Date:   Mon, 17 Jun 2019 13:38:47 -0700
Message-Id: <20190617203847.184407-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617203847.184407-1-bvanassche@acm.org>
References: <20190617203847.184407-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes a race condition: it avoids that the
atomic_dec(&sp->ref_count) statement in qla2xxx_eh_abort() sporadically
triggers a use-after-free.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c    |  4 +--
 drivers/scsi/qla2xxx/qla_def.h    |  9 +++++-
 drivers/scsi/qla2xxx/qla_gs.c     | 42 ++++++++++++-------------
 drivers/scsi/qla2xxx/qla_init.c   | 34 ++++++++++-----------
 drivers/scsi/qla2xxx/qla_inline.h |  2 +-
 drivers/scsi/qla2xxx/qla_iocb.c   | 10 +++---
 drivers/scsi/qla2xxx/qla_mbx.c    |  6 ++--
 drivers/scsi/qla2xxx/qla_mid.c    |  2 +-
 drivers/scsi/qla2xxx/qla_mr.c     |  2 +-
 drivers/scsi/qla2xxx/qla_nvme.c   | 23 +++++---------
 drivers/scsi/qla2xxx/qla_os.c     | 51 +++++++++++++++----------------
 drivers/scsi/qla2xxx/qla_target.c |  4 +--
 12 files changed, 92 insertions(+), 97 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index d545263d73a1..370823dffc45 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -20,7 +20,7 @@ void qla2x00_bsg_job_done(srb_t *sp, int res)
 	bsg_reply->result = res;
 	bsg_job_done(bsg_job, bsg_reply->result,
 		       bsg_reply->reply_payload_rcv_len);
-	sp->free(sp);
+	sp_put(sp);
 }
 
 void qla2x00_bsg_sp_free(srb_t *sp)
@@ -2611,6 +2611,6 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 
 done:
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
-	sp->free(sp);
+	sp_put(sp);
 	return 0;
 }
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 3f398475d658..b1badc0c0b6e 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -531,7 +531,7 @@ typedef struct srb {
 	 */
 	uint8_t cmd_type;
 	uint8_t pad[3];
-	atomic_t ref_count;
+	struct kref kref;
 	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
@@ -575,6 +575,13 @@ typedef struct srb {
 #define SET_FW_SENSE_LEN(sp, len) \
 	(sp->u.scmd.fw_sense_length = len)
 
+void sp_free(struct kref *kref);
+
+static inline void sp_put(struct srb *sp)
+{
+	kref_put(&sp->kref, sp_free);
+}
+
 struct msg_echo_lb {
 	dma_addr_t send_dma;
 	dma_addr_t rcv_dma;
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 863f98ac6a30..c5c7ff7190ae 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -571,7 +571,7 @@ static void qla2x00_async_sns_sp_done(srb_t *sp, int rc)
 err2:
 	if (!e) {
 		/* please ignore kernel warning. otherwise, we have mem leak. */
-		sp->free(sp);
+		sp_put(sp);
 		return;
 	}
 
@@ -670,7 +670,7 @@ static int qla_async_rftid(scsi_qla_host_t *vha, port_id_t *d_id)
 	}
 	return rval;
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
@@ -769,7 +769,7 @@ static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
@@ -863,7 +863,7 @@ static int qla_async_rnnid(scsi_qla_host_t *vha, port_id_t *d_id,
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
@@ -978,7 +978,7 @@ static int qla_async_rsnn_nn(scsi_qla_host_t *vha)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
@@ -3069,7 +3069,7 @@ static void qla24xx_async_gpsc_sp_done(srb_t *sp, int res)
 	qla2x00_fcport_event_handler(vha, &ea);
 
 done:
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int qla24xx_async_gpsc(scsi_qla_host_t *vha, fc_port_t *fcport)
@@ -3123,7 +3123,7 @@ int qla24xx_async_gpsc(scsi_qla_host_t *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	fcport->flags &= ~FCF_ASYNC_ACTIVE;
@@ -3311,13 +3311,13 @@ static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 	if (res) {
 		if (res == QLA_FUNCTION_TIMEOUT) {
 			qla24xx_post_gpnid_work(sp->vha, &ea.id);
-			sp->free(sp);
+			sp_put(sp);
 			return;
 		}
 	} else if (sp->gen1) {
 		/* There was another RSCN for this Nport ID */
 		qla24xx_post_gpnid_work(sp->vha, &ea.id);
-		sp->free(sp);
+		sp_put(sp);
 		return;
 	}
 
@@ -3326,7 +3326,7 @@ static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 	e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
 	if (!e) {
 		/* please ignore kernel warning. otherwise, we have mem leak. */
-		sp->free(sp);
+		sp_put(sp);
 		return;
 	}
 
@@ -3363,7 +3363,7 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 		if (tsp->u.iocb_cmd.u.ctarg.id.b24 == id->b24) {
 			tsp->gen1++;
 			spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
-			sp->free(sp);
+			sp_put(sp);
 			goto done;
 		}
 	}
@@ -3419,7 +3419,7 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
@@ -3472,7 +3472,7 @@ void qla24xx_async_gffid_sp_done(srb_t *sp, int res)
        ea.event = FCME_GFFID_DONE;
 
        qla2x00_fcport_event_handler(vha, &ea);
-       sp->free(sp);
+       sp_put(sp);
 }
 
 /* Get FC4 Feature with Nport ID. */
@@ -3526,7 +3526,7 @@ int qla24xx_async_gffid(scsi_qla_host_t *vha, fc_port_t *fcport)
 
 	return rval;
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 	return rval;
 }
@@ -4039,7 +4039,7 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 
 	return rval;
 } /* GNNFT */
@@ -4080,7 +4080,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 		    "%s: Performing FCP Scan\n", __func__);
 
 		if (sp)
-			sp->free(sp); /* should not happen */
+			sp_put(sp); /* should not happen */
 
 		sp = qla2x00_get_sp(vha, NULL, GFP_KERNEL);
 		if (!sp) {
@@ -4194,7 +4194,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
 	}
 
-	sp->free(sp);
+	sp_put(sp);
 
 	return rval;
 }
@@ -4248,7 +4248,7 @@ static void qla2x00_async_gnnid_sp_done(srb_t *sp, int res)
 
 	qla2x00_fcport_event_handler(vha, &ea);
 
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int qla24xx_async_gnnid(scsi_qla_host_t *vha, fc_port_t *fcport)
@@ -4306,7 +4306,7 @@ int qla24xx_async_gnnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	return rval;
@@ -4381,7 +4381,7 @@ static void qla2x00_async_gfpnid_sp_done(srb_t *sp, int res)
 
 	qla2x00_fcport_event_handler(vha, &ea);
 
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int qla24xx_async_gfpnid(scsi_qla_host_t *vha, fc_port_t *fcport)
@@ -4438,7 +4438,7 @@ int qla24xx_async_gfpnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	return rval;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3439cbb3c952..e66dab3f1ad3 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -110,7 +110,7 @@ static void qla24xx_abort_sp_done(srb_t *sp, int res)
 		if (sp->flags & SRB_WAKEUP_ON_COMP)
 			complete(&abt->u.abt.comp);
 		else
-			sp->free(sp);
+			sp_put(sp);
 	}
 }
 
@@ -160,7 +160,7 @@ static int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
 	}
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
@@ -257,7 +257,7 @@ static void qla2x00_async_login_sp_done(srb_t *sp, int res)
 		qla2x00_fcport_event_handler(vha, &ea);
 	}
 
-	sp->free(sp);
+	sp_put(sp);
 }
 
 static inline bool
@@ -329,7 +329,7 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	fcport->flags &= ~FCF_ASYNC_ACTIVE;
@@ -341,7 +341,7 @@ static void qla2x00_async_logout_sp_done(srb_t *sp, int res)
 	sp->fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 	sp->fcport->login_gen++;
 	qlt_logo_completion_handler(sp->fcport, res);
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int
@@ -380,7 +380,7 @@ qla2x00_async_logout(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 	return rval;
@@ -406,7 +406,7 @@ static void qla2x00_async_prlo_sp_done(srb_t *sp, int res)
 	if (!test_bit(UNLOADING, &vha->dpc_flags))
 		qla2x00_post_async_prlo_done_work(sp->fcport->vha, sp->fcport,
 		    lio->u.logio.data);
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int
@@ -442,7 +442,7 @@ qla2x00_async_prlo(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	fcport->flags &= ~FCF_ASYNC_ACTIVE;
 	return rval;
@@ -525,7 +525,7 @@ static void qla2x00_async_adisc_sp_done(srb_t *sp, int res)
 
 	qla2x00_fcport_event_handler(vha, &ea);
 
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int
@@ -568,7 +568,7 @@ qla2x00_async_adisc(struct scsi_qla_host *vha, fc_port_t *fcport,
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 	qla2x00_post_async_adisc_work(vha, fcport, data);
@@ -1007,7 +1007,7 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 	vha->gnl.sent = 0;
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
@@ -1074,7 +1074,7 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	return rval;
@@ -1127,7 +1127,7 @@ static void qla24xx_async_gpdb_sp_done(srb_t *sp, int res)
 	qla2x00_fcport_event_handler(vha, &ea);
 
 free_sp:
-	sp->free(sp);
+	sp_put(sp);
 }
 
 static int qla24xx_post_prli_work(struct scsi_qla_host *vha, fc_port_t *fcport)
@@ -1168,7 +1168,7 @@ static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 		qla2x00_fcport_event_handler(vha, &ea);
 	}
 
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int
@@ -1220,7 +1220,7 @@ qla24xx_async_prli(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 	return rval;
 }
@@ -1304,7 +1304,7 @@ int qla24xx_async_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport, u8 opt)
 	if (pd)
 		dma_pool_free(ha->s_dma_pool, pd, pd_dma);
 
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	qla24xx_post_gpdb_work(vha, fcport, opt);
@@ -1838,7 +1838,7 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 	}
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	return rval;
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 2523fbc6c666..dfd6d950fa11 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -168,7 +168,7 @@ qla2xxx_get_qpair_sp(scsi_qla_host_t *vha, struct qla_qpair *qpair,
 		goto done;
 
 	memset(sp, 0, sizeof(*sp));
-	atomic_set(&sp->ref_count, 1);
+	kref_init(&sp->kref);
 	sp->fcport = fcport;
 	sp->iocbs = 1;
 	sp->vha = vha;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 42dbe11fbb14..034d3b824517 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2637,7 +2637,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 			    GFP_KERNEL);
 
 	if (!elsio->u.els_logo.els_logo_pyld) {
-		sp->free(sp);
+		sp_put(sp);
 		return QLA_FUNCTION_FAILED;
 	}
 
@@ -2656,7 +2656,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		sp->free(sp);
+		sp_put(sp);
 		return QLA_FUNCTION_FAILED;
 	}
 
@@ -2667,7 +2667,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	wait_for_completion(&elsio->u.els_logo.comp);
 
-	sp->free(sp);
+	sp_put(sp);
 	return rval;
 }
 
@@ -2802,7 +2802,7 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 
 		e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
 		if (!e) {
-			sp->free(sp);
+			sp_put(sp);
 			return;
 		}
 		e->u.iosb.sp = sp;
@@ -2901,7 +2901,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 out:
 	fcport->flags &= ~(FCF_ASYNC_SENT);
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 8b62f1d6ab9f..f5ea692a00fa 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -6275,19 +6275,19 @@ int qla24xx_send_mb_cmd(struct scsi_qla_host *vha, mbx_cmd_t *mcp)
 	case  QLA_SUCCESS:
 		ql_dbg(ql_dbg_mbx, vha, 0x119d, "%s: %s done.\n",
 		    __func__, sp->name);
-		sp->free(sp);
+		sp_put(sp);
 		break;
 	default:
 		ql_dbg(ql_dbg_mbx, vha, 0x119e, "%s: %s Failed. %x.\n",
 		    __func__, sp->name, rval);
-		sp->free(sp);
+		sp_put(sp);
 		break;
 	}
 
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 1a9a11ae7285..b27128bb3659 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -976,6 +976,6 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 	return rval;
 }
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 8606aee03ccf..dc2cfc0cb06f 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -2002,7 +2002,7 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 		dma_free_coherent(&ha->pdev->dev, fdisc->u.fxiocb.req_len,
 		    fdisc->u.fxiocb.req_addr, fdisc->u.fxiocb.req_dma_handle);
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	return rval;
 }
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 07f83d161304..2df5c668275d 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -135,11 +135,6 @@ static void qla_nvme_sp_ls_done(srb_t *sp, int res)
 	struct nvmefc_ls_req   *fd;
 	struct nvme_private *priv;
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
-	atomic_dec(&sp->ref_count);
-
 	if (res)
 		res = -EINVAL;
 
@@ -149,7 +144,7 @@ static void qla_nvme_sp_ls_done(srb_t *sp, int res)
 	priv->comp_status = res;
 	schedule_work(&priv->ls_work);
 	/* work schedule doesn't need the sp */
-	sp->free(sp);
+	sp_put(sp);
 }
 
 static void qla_nvme_sp_free(srb_t *sp)
@@ -165,11 +160,6 @@ static void qla_nvme_sp_done(srb_t *sp, int res)
 	nvme = &sp->u.iocb_cmd;
 	fd = nvme->u.nvme.desc;
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
-	atomic_dec(&sp->ref_count);
-
 	if (res == QLA_SUCCESS) {
 		fd->rcv_rsplen = nvme->u.nvme.rsp_pyld_len;
 	} else {
@@ -178,7 +168,7 @@ static void qla_nvme_sp_done(srb_t *sp, int res)
 	}
 	fd->status = 0;
 	fd->done(fd);
-	sp->free(sp);
+	sp_put(sp);
 }
 
 static void qla_nvme_abort_work(struct work_struct *work)
@@ -200,12 +190,12 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	if (ha->flags.host_shutting_down) {
 		ql_log(ql_log_info, sp->fcport->vha, 0xffff,
 		    "%s Calling done on sp: %p, type: 0x%x, sp->ref_count: 0x%x\n",
-		    __func__, sp, sp->type, atomic_read(&sp->ref_count));
+		    __func__, sp, sp->type, kref_read(&sp->kref));
 		sp->done(sp, 0);
 		return;
 	}
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
+	if (WARN_ON_ONCE(kref_read(&sp->kref) == 0))
 		return;
 
 	rval = ha->isp_ops->abort_command(sp);
@@ -257,6 +247,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	sp->name = "nvme_ls";
 	sp->free = qla_nvme_sp_ls_free;
 	sp->done = qla_nvme_sp_ls_done;
+	sp->free = qla_nvme_sp_ls_free;
 	nvme = &sp->u.iocb_cmd;
 	priv->sp = sp;
 	priv->fd = fd;
@@ -277,7 +268,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x700e,
 		    "qla2x00_start_sp failed = %d\n", rval);
-		atomic_dec(&sp->ref_count);
+		sp_put(sp);
 		wake_up(&sp->nvme_ls_waitq);
 		return rval;
 	}
@@ -528,7 +519,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
-		atomic_dec(&sp->ref_count);
+		sp_put(sp);
 		wake_up(&sp->nvme_ls_waitq);
 	}
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 619ab9b84b08..40058e842182 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -680,7 +680,7 @@ void qla2x00_sp_free_dma(srb_t *sp)
 	}
 
 	if (!ctx)
-		return;
+		goto free_sp;
 
 	if (sp->flags & SRB_CRC_CTX_DSD_VALID) {
 		/* List assured to be having elements */
@@ -705,6 +705,9 @@ void qla2x00_sp_free_dma(srb_t *sp)
 		ha->gbl_dsd_avail += ctx1->dsd_use_cnt;
 		mempool_free(ctx1, ha->ctx_mempool);
 	}
+
+free_sp:
+	qla2x00_rel_sp(sp);
 }
 
 void qla2x00_sp_compl(srb_t *sp, int res)
@@ -712,18 +715,12 @@ void qla2x00_sp_compl(srb_t *sp, int res)
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct completion *comp = sp->comp;
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
-	atomic_dec(&sp->ref_count);
-
-	sp->free(sp);
 	cmd->result = res;
 	CMD_SP(cmd) = NULL;
 	cmd->scsi_done(cmd);
 	if (comp)
 		complete(comp);
-	qla2x00_rel_sp(sp);
+	sp_put(sp);
 }
 
 void qla2xxx_qpair_sp_free_dma(srb_t *sp)
@@ -744,7 +741,7 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 	}
 
 	if (!ctx)
-		return;
+		goto free_sp;
 
 	if (sp->flags & SRB_CRC_CTX_DSD_VALID) {
 		/* List assured to be having elements */
@@ -806,6 +803,9 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 		dma_pool_free(ha->dl_dma_pool, ctx, ctx0->crc_ctx_dma);
 		sp->flags &= ~SRB_CRC_CTX_DMA_VALID;
 	}
+
+free_sp:
+	qla2xxx_rel_qpair_sp(sp->qpair, sp);
 }
 
 void qla2xxx_qpair_sp_compl(srb_t *sp, int res)
@@ -813,18 +813,12 @@ void qla2xxx_qpair_sp_compl(srb_t *sp, int res)
 	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
 	struct completion *comp = sp->comp;
 
-	if (WARN_ON_ONCE(atomic_read(&sp->ref_count) == 0))
-		return;
-
-	atomic_dec(&sp->ref_count);
-
-	sp->free(sp);
 	cmd->result = res;
 	CMD_SP(cmd) = NULL;
 	cmd->scsi_done(cmd);
+	sp_put(sp);
 	if (comp)
 		complete(comp);
-	qla2xxx_rel_qpair_sp(sp->qpair, sp);
 }
 
 static int
@@ -937,7 +931,7 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	return 0;
 
 qc24_host_busy_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 
 qc24_host_busy:
 	return SCSI_MLQUEUE_HOST_BUSY;
@@ -1025,7 +1019,7 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 	return 0;
 
 qc24_host_busy_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 
 qc24_host_busy:
 	return SCSI_MLQUEUE_HOST_BUSY;
@@ -1201,14 +1195,17 @@ qla2x00_wait_for_chip_reset(scsi_qla_host_t *vha)
 	return return_status;
 }
 
-static int
-sp_get(struct srb *sp)
+void sp_free(struct kref *kref)
 {
-	if (!refcount_inc_not_zero((refcount_t *)&sp->ref_count))
-		/* kref get fail */
-		return ENXIO;
-	else
-		return 0;
+	srb_t *sp = container_of(kref, typeof(*sp), kref);
+
+	sp->free(sp);
+}
+
+/* Return zero if the increment succeeded. Otherwise return ENXIO. */
+static int sp_get(struct srb *sp)
+{
+	return kref_get_unless_zero(&sp->kref) ? 0 : ENXIO;
 }
 
 #define ISP_REG_DISCONNECT 0xffffffffU
@@ -1342,7 +1339,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	}
 
 	sp->comp = NULL;
-	atomic_dec(&sp->ref_count);
+	sp_put(sp);
 	ql_log(ql_log_info, vha, 0x801c,
 	    "Abort command issued nexus=%ld:%d:%llu -- %x.\n",
 	    vha->host_no, id, lun, ret);
@@ -1750,7 +1747,7 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		sp->comp = NULL;
 	}
 
-	atomic_dec(&sp->ref_count);
+	sp_put(sp);
 }
 
 static void
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index ac5b1aea6742..1261713fa63a 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -620,7 +620,7 @@ static void qla2x00_async_nack_sp_done(srb_t *sp, int res)
 	}
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
-	sp->free(sp);
+	sp_put(sp);
 }
 
 int qla24xx_async_notify_ack(scsi_qla_host_t *vha, fc_port_t *fcport,
@@ -671,7 +671,7 @@ int qla24xx_async_notify_ack(scsi_qla_host_t *vha, fc_port_t *fcport,
 	return rval;
 
 done_free_sp:
-	sp->free(sp);
+	sp_put(sp);
 done:
 	fcport->flags &= ~FCF_ASYNC_SENT;
 	return rval;
-- 
2.22.0.rc3

