Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4591BF922
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 15:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgD3NUF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 09:20:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:60568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgD3NUE (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 09:20:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8D7CAEBF;
        Thu, 30 Apr 2020 13:20:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH RFC v3 04/41] csiostor: use reserved command for LUN reset
Date:   Thu, 30 Apr 2020 15:18:27 +0200
Message-Id: <20200430131904.5847-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
References: <20200430131904.5847-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When issuing a LUN reset we should be using a reserved command
to avoid overwriting the original command.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/csiostor/csio_init.c |  1 +
 drivers/scsi/csiostor/csio_scsi.c | 48 +++++++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index 8dea7d53788a..5e1b0a24caf6 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -622,6 +622,7 @@ csio_shost_init(struct csio_hw *hw, struct device *dev,
 	ln->dev_num = (shost->host_no << 16);
 
 	shost->can_queue = CSIO_MAX_QUEUE;
+	shost->nr_reserved_cmds = 1;
 	shost->this_id = -1;
 	shost->unique_id = shost->host_no;
 	shost->max_cmd_len = 16; /* Max CDB length supported */
diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 00cf33573136..273a8b952e69 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -2057,10 +2057,12 @@ csio_tm_cbfn(struct csio_hw *hw, struct csio_ioreq *req)
 static int
 csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 {
-	struct csio_lnode *ln = shost_priv(cmnd->device->host);
+	struct scsi_cmnd *reset_cmnd;
+	struct scsi_device *sdev = cmnd->device;
+	struct csio_lnode *ln = shost_priv(sdev->host);
 	struct csio_hw *hw = csio_lnode_to_hw(ln);
 	struct csio_scsim *scsim = csio_hw_to_scsim(hw);
-	struct csio_rnode *rn = (struct csio_rnode *)(cmnd->device->hostdata);
+	struct csio_rnode *rn = (struct csio_rnode *)(sdev->hostdata);
 	struct csio_ioreq *ioreq = NULL;
 	struct csio_scsi_qset *sqset;
 	unsigned long flags;
@@ -2073,13 +2075,13 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 		goto fail;
 
 	csio_dbg(hw, "Request to reset LUN:%llu (ssni:0x%x tgtid:%d)\n",
-		      cmnd->device->lun, rn->flowid, rn->scsi_id);
+		      sdev->lun, rn->flowid, rn->scsi_id);
 
 	if (!csio_is_lnode_ready(ln)) {
 		csio_err(hw,
 			 "LUN reset cannot be issued on non-ready"
 			 " local node vnpi:0x%x (LUN:%llu)\n",
-			 ln->vnp_flowid, cmnd->device->lun);
+			 ln->vnp_flowid, sdev->lun);
 		goto fail;
 	}
 
@@ -2099,17 +2101,22 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 		csio_err(hw,
 			 "LUN reset cannot be issued on non-ready"
 			 " remote node ssni:0x%x (LUN:%llu)\n",
-			 rn->flowid, cmnd->device->lun);
+			 rn->flowid, sdev->lun);
 		goto fail;
 	}
 
+	reset_cmnd = scsi_get_reserved_cmd(sdev, DMA_NONE);
+	if (!reset_cmnd) {
+		csio_err(hw, "No free TMF request\n");
+		goto fail;
+	}
 	/* Get a free ioreq structure - SM is already set to uninit */
 	ioreq = csio_get_scsi_ioreq_lock(hw, scsim);
 
 	if (!ioreq) {
 		csio_err(hw, "Out of IO request elements. Active # :%d\n",
 			 scsim->stats.n_active);
-		goto fail;
+		goto fail_ret_cmnd;
 	}
 
 	sqset			= &hw->sqset[ln->portid][smp_processor_id()];
@@ -2119,11 +2126,11 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 	ioreq->iq_idx		= sqset->iq_idx;
 	ioreq->eq_idx		= sqset->eq_idx;
 
-	csio_scsi_cmnd(ioreq)	= cmnd;
-	cmnd->host_scribble	= (unsigned char *)ioreq;
-	cmnd->SCp.Status	= 0;
+	csio_scsi_cmnd(ioreq)	= reset_cmnd;
+	reset_cmnd->host_scribble	= (unsigned char *)ioreq;
+	reset_cmnd->SCp.Status	= 0;
 
-	cmnd->SCp.Message	= FCP_TMF_LUN_RESET;
+	reset_cmnd->SCp.Message	= FCP_TMF_LUN_RESET;
 	ioreq->tmo		= CSIO_SCSI_LUNRST_TMO_MS / 1000;
 
 	/*
@@ -2140,7 +2147,7 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 	sld.level = CSIO_LEV_LUN;
 	sld.lnode = ioreq->lnode;
 	sld.rnode = ioreq->rnode;
-	sld.oslun = cmnd->device->lun;
+	sld.oslun = sdev->lun;
 
 	spin_lock_irqsave(&hw->lock, flags);
 	/* Kick off TM SM on the ioreq */
@@ -2156,14 +2163,14 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 	csio_dbg(hw, "Waiting max %d secs for LUN reset completion\n",
 		    count * (CSIO_SCSI_TM_POLL_MS / 1000));
 	/* Wait for completion */
-	while ((((struct scsi_cmnd *)csio_scsi_cmnd(ioreq)) == cmnd)
+	while ((((struct scsi_cmnd *)csio_scsi_cmnd(ioreq)) == reset_cmnd)
 								&& count--)
 		msleep(CSIO_SCSI_TM_POLL_MS);
 
 	/* LUN reset timed-out */
-	if (((struct scsi_cmnd *)csio_scsi_cmnd(ioreq)) == cmnd) {
+	if (((struct scsi_cmnd *)csio_scsi_cmnd(ioreq)) == reset_cmnd) {
 		csio_err(hw, "LUN reset (%d:%llu) timed out\n",
-			 cmnd->device->id, cmnd->device->lun);
+			 sdev->id, sdev->lun);
 
 		spin_lock_irq(&hw->lock);
 		csio_scsi_drvcleanup(ioreq);
@@ -2174,11 +2181,12 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 	}
 
 	/* LUN reset returned, check cached status */
-	if (cmnd->SCp.Status != FW_SUCCESS) {
+	if (reset_cmnd->SCp.Status != FW_SUCCESS) {
 		csio_err(hw, "LUN reset failed (%d:%llu), status: %d\n",
-			 cmnd->device->id, cmnd->device->lun, cmnd->SCp.Status);
-		goto fail;
+			 sdev->id, sdev->lun, reset_cmnd->SCp.Status);
+		goto fail_ret_cmnd;
 	}
+	scsi_put_reserved_cmd(reset_cmnd);
 
 	/* LUN reset succeeded, Start aborting affected I/Os */
 	/*
@@ -2196,7 +2204,7 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 	if (retval != 0) {
 		csio_err(hw,
 			 "Attempt to abort I/Os during LUN reset of %llu"
-			 " returned %d\n", cmnd->device->lun, retval);
+			 " returned %d\n", sdev->lun, retval);
 		/* Return I/Os back to active_q */
 		spin_lock_irq(&hw->lock);
 		list_splice_tail_init(&local_q, &scsim->active_q);
@@ -2207,12 +2215,14 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 	CSIO_INC_STATS(rn, n_lun_rst);
 
 	csio_info(hw, "LUN reset occurred (%d:%llu)\n",
-		  cmnd->device->id, cmnd->device->lun);
+		  sdev->id, sdev->lun);
 
 	return SUCCESS;
 
 fail_ret_ioreq:
 	csio_put_scsi_ioreq_lock(hw, scsim, ioreq);
+fail_ret_cmnd:
+	scsi_put_reserved_cmd(reset_cmnd);
 fail:
 	CSIO_INC_STATS(rn, n_lun_rst_fail);
 	return FAILED;
-- 
2.16.4

