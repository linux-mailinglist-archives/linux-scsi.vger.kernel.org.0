Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F52EF22A
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 01:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfKEAmi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 19:42:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41095 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfKEAmh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Nov 2019 19:42:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so13811282pfq.8
        for <linux-scsi@vger.kernel.org>; Mon, 04 Nov 2019 16:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEnkeVoKnv2xbcigffre63HlK0AiI3h+8776ByTgGcE=;
        b=Yv9dQgDOkrCItVFMpE+/Q7jZCkrWY4TrjEoVH0K/PM3juHzlBxc4l1NZeh6Xye2F4V
         CvoPNas152lC2aeYoeILC/LZWBN1/6FS02X19hpUTTh6NPrfZeQ/+5QRZMGE8bSTADXM
         WS/Fn88iKb6QWgw5qMfOvbfPD8S0cI79mY6IDWCvRtgTpu0DJ5RCfrfY5bHrFFUf7Htl
         fxiORlSR30ygCjt4Q2BhNN3K+iZFmbg4lUIuFnDnUldqOvkjMGZRAlesY3LoNBt0+VR6
         qmHceDgveR0S84KFXGnTzv7yvi4XBdBf3mWnEIz5zIY1tix+4kevneP5PJeQozl9REWd
         OiUw==
X-Gm-Message-State: APjAAAWLTdHOwBik12DYlCR3H66CVVKclkDy+IjZ+t8x9Ui+Q0Py34fY
        eXWg+fxZClRA+6CwktkQWIo=
X-Google-Smtp-Source: APXvYqyGN2KzKdisc58nAmq26TAQYCXw+9M5ZQW7cXO9sHF6mcJ3SGeRs4N0xxR0ReLcTWexJitopg==
X-Received: by 2002:a62:6385:: with SMTP id x127mr35317365pfb.244.1572914556819;
        Mon, 04 Nov 2019 16:42:36 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a21sm4235449pjv.20.2019.11.04.16.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 16:42:36 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH RFC v2 3/5] ufs: Avoid busy-waiting by eliminating tag conflicts
Date:   Mon,  4 Nov 2019 16:42:24 -0800
Message-Id: <20191105004226.232635-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105004226.232635-1-bvanassche@acm.org>
References: <20191105004226.232635-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of tracking which tags are in use in the ufs_hba.lrb_in_use
bitmask, rely on the block layer tag allocation mechanism. This patch
removes the following busy-waiting loop if ufshcd_issue_devman_upiu_cmd()
and the block layer accidentally allocate the same tag for a SCSI request:
* ufshcd_queuecommand() returns SCSI_MLQUEUE_HOST_BUSY.
* The SCSI core requeues the SCSI command.

Cc: Yaniv Gardi <ygardi@codeaurora.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ufs/ufshcd.c | 124 ++++++++++++++++----------------------
 drivers/scsi/ufs/ufshcd.h |   9 +--
 2 files changed, 57 insertions(+), 76 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3e3c6257a343..c8124db6665e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -497,8 +497,8 @@ static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
 static void ufshcd_print_host_state(struct ufs_hba *hba)
 {
 	dev_err(hba->dev, "UFS Host state=%d\n", hba->ufshcd_state);
-	dev_err(hba->dev, "lrb in use=0x%lx, outstanding reqs=0x%lx tasks=0x%lx\n",
-		hba->lrb_in_use, hba->outstanding_reqs, hba->outstanding_tasks);
+	dev_err(hba->dev, "outstanding reqs=0x%lx tasks=0x%lx\n",
+		hba->outstanding_reqs, hba->outstanding_tasks);
 	dev_err(hba->dev, "saved_err=0x%x, saved_uic_err=0x%x\n",
 		hba->saved_err, hba->saved_uic_err);
 	dev_err(hba->dev, "Device power mode=%d, UIC link state=%d\n",
@@ -1596,6 +1596,29 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 }
 EXPORT_SYMBOL_GPL(ufshcd_hold);
 
+static bool ufshcd_is_busy(struct request *req, void *priv, bool reserved)
+{
+	int *busy = priv;
+
+	if (reserved)
+		return true;
+	(*busy)++;
+	return false;
+}
+
+/*
+ * Whether or not any non-reserved tag is in use by a request that is in
+ * progress.
+ */
+static bool ufshcd_any_tag_in_use(struct ufs_hba *hba)
+{
+	struct request_queue *q = hba->tag_alloc_queue;
+	int busy = 0;
+
+	blk_mq_tagset_busy_iter(q->tag_set, ufshcd_is_busy, &busy);
+	return busy;
+}
+
 static void ufshcd_gate_work(struct work_struct *work)
 {
 	struct ufs_hba *hba = container_of(work, struct ufs_hba,
@@ -1619,7 +1642,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 
 	if (hba->clk_gating.active_reqs
 		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| hba->lrb_in_use || hba->outstanding_tasks
+		|| ufshcd_any_tag_in_use(hba) || hba->outstanding_tasks
 		|| hba->active_uic_cmd || hba->uic_async_done)
 		goto rel_lock;
 
@@ -1673,7 +1696,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended
 		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| hba->lrb_in_use || hba->outstanding_tasks
+		|| ufshcd_any_tag_in_use(hba) || hba->outstanding_tasks
 		|| hba->active_uic_cmd || hba->uic_async_done
 		|| ufshcd_eh_in_progress(hba))
 		return;
@@ -2443,22 +2466,9 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 	hba->req_abort_count = 0;
 
-	/* acquire the tag to make sure device cmds don't use it */
-	if (test_and_set_bit_lock(tag, &hba->lrb_in_use)) {
-		/*
-		 * Dev manage command in progress, requeue the command.
-		 * Requeuing the command helps in cases where the request *may*
-		 * find different tag instead of waiting for dev manage command
-		 * completion.
-		 */
-		err = SCSI_MLQUEUE_HOST_BUSY;
-		goto out;
-	}
-
 	err = ufshcd_hold(hba, true);
 	if (err) {
 		err = SCSI_MLQUEUE_HOST_BUSY;
-		clear_bit_unlock(tag, &hba->lrb_in_use);
 		goto out;
 	}
 	WARN_ON(hba->clk_gating.state != CLKS_ON);
@@ -2479,7 +2489,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	err = ufshcd_map_sg(hba, lrbp);
 	if (err) {
 		lrbp->cmd = NULL;
-		clear_bit_unlock(tag, &hba->lrb_in_use);
 		goto out;
 	}
 	/* Make sure descriptors are ready before ringing the doorbell */
@@ -2625,44 +2634,6 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 	return err;
 }
 
-/**
- * ufshcd_get_dev_cmd_tag - Get device management command tag
- * @hba: per-adapter instance
- * @tag_out: pointer to variable with available slot value
- *
- * Get a free slot and lock it until device management command
- * completes.
- *
- * Returns false if free slot is unavailable for locking, else
- * return true with tag value in @tag.
- */
-static bool ufshcd_get_dev_cmd_tag(struct ufs_hba *hba, int *tag_out)
-{
-	int tag;
-	bool ret = false;
-	unsigned long tmp;
-
-	if (!tag_out)
-		goto out;
-
-	do {
-		tmp = ~hba->lrb_in_use;
-		tag = find_last_bit(&tmp, hba->nutrs);
-		if (tag >= hba->nutrs)
-			goto out;
-	} while (test_and_set_bit_lock(tag, &hba->lrb_in_use));
-
-	*tag_out = tag;
-	ret = true;
-out:
-	return ret;
-}
-
-static inline void ufshcd_put_dev_cmd_tag(struct ufs_hba *hba, int tag)
-{
-	clear_bit_unlock(tag, &hba->lrb_in_use);
-}
-
 /**
  * ufshcd_exec_dev_cmd - API for sending device management requests
  * @hba: UFS hba
@@ -2675,6 +2646,8 @@ static inline void ufshcd_put_dev_cmd_tag(struct ufs_hba *hba, int tag)
 static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		enum dev_cmd_type cmd_type, int timeout)
 {
+	struct request_queue *q = hba->tag_alloc_queue;
+	struct request *req;
 	struct ufshcd_lrb *lrbp;
 	int err;
 	int tag;
@@ -2688,7 +2661,11 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	 * Even though we use wait_event() which sleeps indefinitely,
 	 * the maximum wait time is bounded by SCSI request timeout.
 	 */
-	wait_event(hba->dev_cmd.tag_wq, ufshcd_get_dev_cmd_tag(hba, &tag));
+	req = blk_get_request(q, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	tag = req->tag - hba->nutmrs;
+	WARN_ON_ONCE(!ufshcd_valid_tag(hba, tag));
 
 	init_completion(&wait);
 	lrbp = &hba->lrb[tag];
@@ -2712,8 +2689,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 			err ? "query_complete_err" : "query_complete");
 
 out_put_tag:
-	ufshcd_put_dev_cmd_tag(hba, tag);
-	wake_up(&hba->dev_cmd.tag_wq);
+	blk_put_request(req);
 	up_read(&hba->clk_scaling_lock);
 	return err;
 }
@@ -4832,7 +4808,6 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 			cmd->result = result;
 			/* Mark completed command as NULL in LRB */
 			lrbp->cmd = NULL;
-			clear_bit_unlock(index, &hba->lrb_in_use);
 			/* Do not touch lrbp after scsi done */
 			cmd->scsi_done(cmd);
 			__ufshcd_release(hba);
@@ -4854,9 +4829,6 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 	hba->outstanding_reqs ^= completed_reqs;
 
 	ufshcd_clk_scaling_update_busy(hba);
-
-	/* we might have free'd some tags above */
-	wake_up(&hba->dev_cmd.tag_wq);
 }
 
 /**
@@ -5785,6 +5757,8 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					enum dev_cmd_type cmd_type,
 					enum query_opcode desc_op)
 {
+	struct request_queue *q = hba->tag_alloc_queue;
+	struct request *req;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
 	int tag;
@@ -5794,7 +5768,11 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	down_read(&hba->clk_scaling_lock);
 
-	wait_event(hba->dev_cmd.tag_wq, ufshcd_get_dev_cmd_tag(hba, &tag));
+	req = blk_get_request(q, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	tag = req->tag - hba->nutmrs;
+	WARN_ON_ONCE(!ufshcd_valid_tag(hba, tag));
 
 	init_completion(&wait);
 	lrbp = &hba->lrb[tag];
@@ -5868,8 +5846,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 		}
 	}
 
-	ufshcd_put_dev_cmd_tag(hba, tag);
-	wake_up(&hba->dev_cmd.tag_wq);
+	blk_put_request(req);
 	up_read(&hba->clk_scaling_lock);
 	return err;
 }
@@ -6165,9 +6142,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	hba->lrb[tag].cmd = NULL;
 	spin_unlock_irqrestore(host->host_lock, flags);
 
-	clear_bit_unlock(tag, &hba->lrb_in_use);
-	wake_up(&hba->dev_cmd.tag_wq);
-
 out:
 	if (!err) {
 		err = SUCCESS;
@@ -6874,6 +6848,11 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	int ret;
 	ktime_t start = ktime_get();
 
+	ret = -ENOMEM;
+	hba->tag_alloc_queue = blk_mq_init_queue(&hba->host->tag_set);
+	if (!hba->tag_alloc_queue)
+		goto out;
+
 	ret = ufshcd_link_startup(hba);
 	if (ret)
 		goto out;
@@ -7506,6 +7485,10 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 		ufshcd_setup_hba_vreg(hba, false);
 		hba->is_powered = false;
 	}
+
+	if (hba->tag_alloc_queue)
+		blk_cleanup_queue(hba->tag_alloc_queue);
+	hba->tag_alloc_queue = NULL;
 }
 
 static int
@@ -8348,9 +8331,6 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	init_rwsem(&hba->clk_scaling_lock);
 
-	/* Initialize device management tag acquire wait queue */
-	init_waitqueue_head(&hba->dev_cmd.tag_wq);
-
 	ufshcd_init_clk_gating(hba);
 
 	ufshcd_init_clk_scaling(hba);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index e3593cce23c1..8fa33fb71237 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -212,13 +212,11 @@ struct ufs_query {
  * @type: device management command type - Query, NOP OUT
  * @lock: lock to allow one command at a time
  * @complete: internal commands completion
- * @tag_wq: wait queue until free command slot is available
  */
 struct ufs_dev_cmd {
 	enum dev_cmd_type type;
 	struct mutex lock;
 	struct completion *complete;
-	wait_queue_head_t tag_wq;
 	struct ufs_query query;
 };
 
@@ -480,7 +478,10 @@ struct ufs_stats {
  * @host: Scsi_Host instance of the driver
  * @dev: device handle
  * @lrb: local reference block
- * @lrb_in_use: lrb in use
+ * @tag_alloc_queue: None of the exported block layer functions allows to
+ * allocate a tag directly from a tag set. The purpose of this request queue
+ * is to support allocating tags from hba->host->tag_set before any LUNs have
+ * been associated with this HBA.
  * @outstanding_tasks: Bits representing outstanding task requests
  * @outstanding_reqs: Bits representing outstanding transfer requests
  * @capabilities: UFS Controller Capabilities
@@ -538,6 +539,7 @@ struct ufs_hba {
 
 	struct Scsi_Host *host;
 	struct device *dev;
+	struct request_queue *tag_alloc_queue;
 	/*
 	 * This field is to keep a reference to "scsi_device" corresponding to
 	 * "UFS device" W-LU.
@@ -558,7 +560,6 @@ struct ufs_hba {
 	u32 ahit;
 
 	struct ufshcd_lrb *lrb;
-	unsigned long lrb_in_use;
 
 	unsigned long outstanding_tasks;
 	unsigned long outstanding_reqs;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

