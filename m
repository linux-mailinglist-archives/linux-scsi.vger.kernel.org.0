Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC335EB70C
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Sep 2022 03:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiI0Bo3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Sep 2022 21:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiI0Bo0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Sep 2022 21:44:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EABA7205
        for <linux-scsi@vger.kernel.org>; Mon, 26 Sep 2022 18:44:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e68so8407965pfe.1
        for <linux-scsi@vger.kernel.org>; Mon, 26 Sep 2022 18:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ez71/bwQQ37IExTa9EvzsotH0lbr+r0Fmd6a9LpY5qI=;
        b=x4ZUeV586yDllu7b96e/U0RsymAOQMLxPsCvPh11Ba6OnNT81XcXv1uOfz8Byq5cEH
         TdLZy6eIu4tqpQ+rkc+PHvg8Na2X1w6P7DMDQYUxWS8j43MBlJiBBVTn8Lpv5CZdbCD1
         k6Xe7jLCzgKAFfkGJKd0wK1tRLUdh8/yg7J9jUa2IcKkLgrlgTvcpW/77890AK3sI1MV
         NWmyHwAsu5m650XsOledCFbBHtPRrTVV2hqvvN+mM3AMYbpYTBdiDM9yu3SgY0sbHMb5
         zDAUGdi7X8s0oeTfhoN/DgzmHixuLEXWkyJU51BiAKcaJvakGRtZWWdXcRV8e3gP4vDm
         2Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ez71/bwQQ37IExTa9EvzsotH0lbr+r0Fmd6a9LpY5qI=;
        b=YkEQc9Kwnd+NlfkzxziTWJjIzG7UcGpbwY+43tpHUjEIpE905EVjVmLyBma3fodEJO
         yyOJfMZ+dzIg4C8Y6ku6DDNjNGol3YCZKwWDmtNGooEZDaS6F1f5ZtdOtp1YZs7VEqQm
         hYqUO7excJWz6Uv9oCwkAbRofg+ouJnpElydAKqjklZS20oPbs7FEmoq/3ShxI2g5X/A
         HIF7CO8M0ohmojp8m4BybrUHPfvE66QCM3RhovsZnIanUIvM95L2DM3d4bjMFO+MAG3l
         9Sj68WcHNM1RZl0qrVNB2MfBzAJ+43aMOLjgcfMjZKh1iHnHTsat52UN2GG2cJib33iF
         BTtA==
X-Gm-Message-State: ACrzQf0yXpQ2W11uZamYkCLyWlh18pxqiFZWlFDZLidsvivencTfRRiH
        SPrZSaNCJYr6AejY0v0dvhqA1QjbvwWeLg==
X-Google-Smtp-Source: AMsMyM7FHHvkBN1GOgSMAFfgxaVnFcrc/lulR2MfTO3TZoy7tNUBfbXx4qIz3/KCcKPVI4ngOxrAUg==
X-Received: by 2002:a63:85c3:0:b0:43a:e034:9e39 with SMTP id u186-20020a6385c3000000b0043ae0349e39mr22553631pgd.219.1664243064542;
        Mon, 26 Sep 2022 18:44:24 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm183062pfp.113.2022.09.26.18.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:44:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] block: change request end_io handler to pass back a return value
Date:   Mon, 26 Sep 2022 19:44:17 -0600
Message-Id: <20220927014420.71141-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
References: <20220927014420.71141-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Everything is just converted to returning RQ_END_IO_NONE, and there
should be no functional changes with this patch.

In preparation for allowing the end_io handler to pass ownership back
to the block layer, rather than retain ownership of the request.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-flush.c                  | 10 +++++++---
 block/blk-mq.c                     | 14 +++++++++-----
 drivers/md/dm-rq.c                 |  4 +++-
 drivers/nvme/host/core.c           |  6 ++++--
 drivers/nvme/host/ioctl.c          |  5 ++++-
 drivers/nvme/host/pci.c            | 12 ++++++++----
 drivers/nvme/target/passthru.c     |  5 +++--
 drivers/scsi/scsi_error.c          |  4 +++-
 drivers/scsi/sg.c                  |  9 +++++----
 drivers/scsi/st.c                  |  4 +++-
 drivers/target/target_core_pscsi.c |  6 ++++--
 drivers/ufs/core/ufshpb.c          |  8 ++++++--
 include/linux/blk-mq.h             |  7 ++++++-
 13 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index d20a0c6b2c66..ac850f4d9c4c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -218,7 +218,8 @@ static void blk_flush_complete_seq(struct request *rq,
 	blk_kick_flush(q, fq, cmd_flags);
 }
 
-static void flush_end_io(struct request *flush_rq, blk_status_t error)
+static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
+				       blk_status_t error)
 {
 	struct request_queue *q = flush_rq->q;
 	struct list_head *running;
@@ -232,7 +233,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	if (!req_ref_put_and_test(flush_rq)) {
 		fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
-		return;
+		return RQ_END_IO_NONE;
 	}
 
 	blk_account_io_flush(flush_rq);
@@ -269,6 +270,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	}
 
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+	return RQ_END_IO_NONE;
 }
 
 bool is_flush_rq(struct request *rq)
@@ -354,7 +356,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	blk_flush_queue_rq(flush_rq, false);
 }
 
-static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
+static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
+					       blk_status_t error)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
@@ -376,6 +379,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
 	blk_mq_sched_restart(hctx);
+	return RQ_END_IO_NONE;
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d3a9f8b9c7ee..a4e018c82b7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1001,7 +1001,8 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
-		rq->end_io(rq, error);
+		if (rq->end_io(rq, error) == RQ_END_IO_FREE)
+			blk_mq_free_request(rq);
 	} else {
 		blk_mq_free_request(rq);
 	}
@@ -1287,12 +1288,13 @@ struct blk_rq_wait {
 	blk_status_t ret;
 };
 
-static void blk_end_sync_rq(struct request *rq, blk_status_t ret)
+static enum rq_end_io_ret blk_end_sync_rq(struct request *rq, blk_status_t ret)
 {
 	struct blk_rq_wait *wait = rq->end_io_data;
 
 	wait->ret = ret;
 	complete(&wait->done);
+	return RQ_END_IO_NONE;
 }
 
 bool blk_rq_is_poll(struct request *rq)
@@ -1526,10 +1528,12 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 
 void blk_mq_put_rq_ref(struct request *rq)
 {
-	if (is_flush_rq(rq))
-		rq->end_io(rq, 0);
-	else if (req_ref_put_and_test(rq))
+	if (is_flush_rq(rq)) {
+		if (rq->end_io(rq, 0) == RQ_END_IO_FREE)
+			blk_mq_free_request(rq);
+	} else if (req_ref_put_and_test(rq)) {
 		__blk_mq_free_request(rq);
+	}
 }
 
 static bool blk_mq_check_expired(struct request *rq, void *priv)
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 4f49bbcce4f1..3001b10a3fbf 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -292,11 +292,13 @@ static void dm_kill_unmapped_request(struct request *rq, blk_status_t error)
 	dm_complete_request(rq, error);
 }
 
-static void end_clone_request(struct request *clone, blk_status_t error)
+static enum rq_end_io_ret end_clone_request(struct request *clone,
+					    blk_status_t error)
 {
 	struct dm_rq_target_io *tio = clone->end_io_data;
 
 	dm_complete_request(tio->orig, error);
+	return RQ_END_IO_NONE;
 }
 
 static int dm_rq_bio_constructor(struct bio *bio, struct bio *bio_orig,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 13080a017ecf..f946f85e7a66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1177,7 +1177,8 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
 }
 
-static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
+static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
+						 blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
@@ -1189,7 +1190,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
-		return;
+		return RQ_END_IO_NONE;
 	}
 
 	ctrl->comp_seen = false;
@@ -1200,6 +1201,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
 		nvme_queue_keep_alive_work(ctrl);
+	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 548aca8b5b9f..c80b3ecca5c8 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -385,7 +385,8 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
 	io_uring_cmd_done(ioucmd, status, result);
 }
 
-static void nvme_uring_cmd_end_io(struct request *req, blk_status_t err)
+static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
+						blk_status_t err)
 {
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
@@ -404,6 +405,8 @@ static void nvme_uring_cmd_end_io(struct request *req, blk_status_t err)
 		nvme_uring_task_cb(ioucmd);
 	else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
+
+	return RQ_END_IO_NONE;
 }
 
 static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 09b5d62f342b..361f09f23648 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1268,7 +1268,7 @@ static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
 }
 
-static void abort_endio(struct request *req, blk_status_t error)
+static enum rq_end_io_ret abort_endio(struct request *req, blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
@@ -1276,6 +1276,7 @@ static void abort_endio(struct request *req, blk_status_t error)
 		 "Abort status: 0x%x", nvme_req(req)->status);
 	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
 	blk_mq_free_request(req);
+	return RQ_END_IO_NONE;
 }
 
 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
@@ -2447,22 +2448,25 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
-static void nvme_del_queue_end(struct request *req, blk_status_t error)
+static enum rq_end_io_ret nvme_del_queue_end(struct request *req,
+					     blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
 
 	blk_mq_free_request(req);
 	complete(&nvmeq->delete_done);
+	return RQ_END_IO_NONE;
 }
 
-static void nvme_del_cq_end(struct request *req, blk_status_t error)
+static enum rq_end_io_ret nvme_del_cq_end(struct request *req,
+					  blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
 
 	if (error)
 		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
-	nvme_del_queue_end(req, error);
+	return nvme_del_queue_end(req, error);
 }
 
 static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 6f39a29828b1..4876ccaac55b 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -240,14 +240,15 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 }
 
-static void nvmet_passthru_req_done(struct request *rq,
-				    blk_status_t blk_status)
+static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
+						  blk_status_t blk_status)
 {
 	struct nvmet_req *req = rq->end_io_data;
 
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, nvme_req(rq)->status);
 	blk_mq_free_request(rq);
+	return RQ_END_IO_NONE;
 }
 
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..786fb963cf3f 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2004,9 +2004,11 @@ enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 	}
 }
 
-static void eh_lock_door_done(struct request *req, blk_status_t status)
+static enum rq_end_io_ret eh_lock_door_done(struct request *req,
+					    blk_status_t status)
 {
 	blk_mq_free_request(req);
+	return RQ_END_IO_NONE;
 }
 
 /**
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 340b050ad28d..94c5e9a9309c 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -177,7 +177,7 @@ typedef struct sg_device { /* holds the state of each scsi generic device */
 } Sg_device;
 
 /* tasklet or soft irq callback */
-static void sg_rq_end_io(struct request *rq, blk_status_t status);
+static enum rq_end_io_ret sg_rq_end_io(struct request *rq, blk_status_t status);
 static int sg_start_req(Sg_request *srp, unsigned char *cmd);
 static int sg_finish_rem_req(Sg_request * srp);
 static int sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * sfp, int buff_size);
@@ -1311,7 +1311,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
  * This function is a "bottom half" handler that is called by the mid
  * level when a command is completed (or has failed).
  */
-static void
+static enum rq_end_io_ret
 sg_rq_end_io(struct request *rq, blk_status_t status)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
@@ -1324,11 +1324,11 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	int result, resid, done = 1;
 
 	if (WARN_ON(srp->done != 0))
-		return;
+		return RQ_END_IO_NONE;
 
 	sfp = srp->parentfp;
 	if (WARN_ON(sfp == NULL))
-		return;
+		return RQ_END_IO_NONE;
 
 	sdp = sfp->parentdp;
 	if (unlikely(atomic_read(&sdp->detaching)))
@@ -1406,6 +1406,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 		INIT_WORK(&srp->ew.work, sg_rq_end_io_usercontext);
 		schedule_work(&srp->ew.work);
 	}
+	return RQ_END_IO_NONE;
 }
 
 static const struct file_operations sg_fops = {
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 850172a2b8f1..55e7c07ebe4c 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -512,7 +512,8 @@ static void st_do_stats(struct scsi_tape *STp, struct request *req)
 	atomic64_dec(&STp->stats->in_flight);
 }
 
-static void st_scsi_execute_end(struct request *req, blk_status_t status)
+static enum rq_end_io_ret st_scsi_execute_end(struct request *req,
+					      blk_status_t status)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	struct st_request *SRpnt = req->end_io_data;
@@ -532,6 +533,7 @@ static void st_scsi_execute_end(struct request *req, blk_status_t status)
 
 	blk_rq_unmap_user(tmp);
 	blk_mq_free_request(req);
+	return RQ_END_IO_NONE;
 }
 
 static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index e6a967ddc08c..8a7306e5e133 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -39,7 +39,7 @@ static inline struct pscsi_dev_virt *PSCSI_DEV(struct se_device *dev)
 }
 
 static sense_reason_t pscsi_execute_cmd(struct se_cmd *cmd);
-static void pscsi_req_done(struct request *, blk_status_t);
+static enum rq_end_io_ret pscsi_req_done(struct request *, blk_status_t);
 
 /*	pscsi_attach_hba():
  *
@@ -1002,7 +1002,8 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
 	return 0;
 }
 
-static void pscsi_req_done(struct request *req, blk_status_t status)
+static enum rq_end_io_ret pscsi_req_done(struct request *req,
+					 blk_status_t status)
 {
 	struct se_cmd *cmd = req->end_io_data;
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
@@ -1029,6 +1030,7 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 	}
 
 	blk_mq_free_request(req);
+	return RQ_END_IO_NONE;
 }
 
 static const struct target_backend_ops pscsi_ops = {
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index a1a7a1175a5a..3d69a81c5b17 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -613,14 +613,17 @@ static void ufshpb_activate_subregion(struct ufshpb_lu *hpb,
 	srgn->srgn_state = HPB_SRGN_VALID;
 }
 
-static void ufshpb_umap_req_compl_fn(struct request *req, blk_status_t error)
+static enum rq_end_io_ret ufshpb_umap_req_compl_fn(struct request *req,
+						   blk_status_t error)
 {
 	struct ufshpb_req *umap_req = (struct ufshpb_req *)req->end_io_data;
 
 	ufshpb_put_req(umap_req->hpb, umap_req);
+	return RQ_END_IO_NONE;
 }
 
-static void ufshpb_map_req_compl_fn(struct request *req, blk_status_t error)
+static enum rq_end_io_ret ufshpb_map_req_compl_fn(struct request *req,
+						  blk_status_t error)
 {
 	struct ufshpb_req *map_req = (struct ufshpb_req *) req->end_io_data;
 	struct ufshpb_lu *hpb = map_req->hpb;
@@ -636,6 +639,7 @@ static void ufshpb_map_req_compl_fn(struct request *req, blk_status_t error)
 	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
 
 	ufshpb_put_map_req(map_req->hpb, map_req);
+	return RQ_END_IO_NONE;
 }
 
 static void ufshpb_set_unmap_cmd(unsigned char *cdb, struct ufshpb_region *rgn)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 00a15808c137..e6fa49dd6196 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -14,7 +14,12 @@ struct blk_flush_queue;
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_DEFAULT_RQ	128
 
-typedef void (rq_end_io_fn)(struct request *, blk_status_t);
+enum rq_end_io_ret {
+	RQ_END_IO_NONE,
+	RQ_END_IO_FREE,
+};
+
+typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
 
 /*
  * request flags */
-- 
2.35.1

