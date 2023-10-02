Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560107B575D
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Oct 2023 18:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbjJBPtn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Oct 2023 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbjJBPtg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Oct 2023 11:49:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30AAD8
        for <linux-scsi@vger.kernel.org>; Mon,  2 Oct 2023 08:49:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B74A121864;
        Mon,  2 Oct 2023 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696261770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ3En+potPu8/1dcXfvyyPfMeyY/AafyozqLOLc+CHQ=;
        b=iWnFdYX+Agh16ObA3DCjPqvYiFI3qLV4P+crEbSFagznvcLy17y4Buw3Lj7YutLpTs6+RR
        6bx9wniYOinuSVwzlsrgBk9j/hy6StuXP+qyLjq5UcrrPtKi1FxfPSdA1jQT2QFwbjFYJK
        vdrKUlNtJ/5Nvv3c5br9VPySwqSRV8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696261770;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ3En+potPu8/1dcXfvyyPfMeyY/AafyozqLOLc+CHQ=;
        b=Qdg3/dqyBWuhXGHLuzbBGm8D8GSzWNcOrYkw8bX1nFFnPbBdkTIKkAGQF/t+riFIH8iyvT
        m71rrC/5oBJ3m/AA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9819A2C145;
        Mon,  2 Oct 2023 15:49:30 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id AAF9551E7561; Mon,  2 Oct 2023 17:49:30 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/15] bfa: Do not use scsi command to signal TMF status
Date:   Mon,  2 Oct 2023 17:49:14 +0200
Message-Id: <20231002154927.68643-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231002154927.68643-1-hare@suse.de>
References: <20231002154927.68643-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The bfa driver hijacks the scsi command to signal the TMF status,
which will no longer work if the TMF handler will be converted.
So rework TMF handling to not use a scsi command but rather add
new TMF fields to the per-device structure.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/bfa/bfad_im.c | 112 ++++++++++++++++++++-----------------
 drivers/scsi/bfa/bfad_im.h |   2 +
 2 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index a9d3d8562d3c..ef352fc59458 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -147,13 +147,13 @@ void
 bfa_cb_tskim_done(void *bfad, struct bfad_tskim_s *dtsk,
 		   enum bfi_tskim_status tsk_status)
 {
-	struct scsi_cmnd *cmnd = (struct scsi_cmnd *)dtsk;
+	struct bfad_itnim_data_s *itnim_data =
+		(struct bfad_itnim_data_s *)dtsk;
 	wait_queue_head_t *wq;
 
-	bfad_priv(cmnd)->status |= tsk_status << 1;
-	set_bit(IO_DONE_BIT, &bfad_priv(cmnd)->status);
-	wq = bfad_priv(cmnd)->wq;
-	bfad_priv(cmnd)->wq = NULL;
+	itnim_data->tmf_status |= tsk_status << 1;
+	set_bit(IO_DONE_BIT, &itnim_data->tmf_status);
+	wq = itnim_data->tmf_wq;
 
 	if (wq)
 		wake_up(wq);
@@ -238,15 +238,16 @@ bfad_im_abort_handler(struct scsi_cmnd *cmnd)
 }
 
 static bfa_status_t
-bfad_im_target_reset_send(struct bfad_s *bfad, struct scsi_cmnd *cmnd,
-		     struct bfad_itnim_s *itnim)
+bfad_im_target_reset_send(struct bfad_s *bfad,
+			  struct bfad_itnim_data_s *itnim_data)
 {
+	struct bfad_itnim_s *itnim = itnim_data->itnim;
 	struct bfa_tskim_s *tskim;
 	struct bfa_itnim_s *bfa_itnim;
 	bfa_status_t    rc = BFA_STATUS_OK;
 	struct scsi_lun scsilun;
 
-	tskim = bfa_tskim_alloc(&bfad->bfa, (struct bfad_tskim_s *) cmnd);
+	tskim = bfa_tskim_alloc(&bfad->bfa, (struct bfad_tskim_s *) itnim_data);
 	if (!tskim) {
 		BFA_LOG(KERN_ERR, bfad, bfa_log_level,
 			"target reset, fail to allocate tskim\n");
@@ -254,12 +255,6 @@ bfad_im_target_reset_send(struct bfad_s *bfad, struct scsi_cmnd *cmnd,
 		goto out;
 	}
 
-	/*
-	 * Set host_scribble to NULL to avoid aborting a task command if
-	 * happens.
-	 */
-	cmnd->host_scribble = NULL;
-	bfad_priv(cmnd)->status = 0;
 	bfa_itnim = bfa_fcs_itnim_get_halitn(&itnim->fcs_itnim);
 	/*
 	 * bfa_itnim can be NULL if the port gets disconnected and the bfa
@@ -290,10 +285,11 @@ bfad_im_target_reset_send(struct bfad_s *bfad, struct scsi_cmnd *cmnd,
 static int
 bfad_im_reset_lun_handler(struct scsi_cmnd *cmnd)
 {
-	struct Scsi_Host *shost = cmnd->device->host;
+	struct scsi_device *sdev = cmnd->device;
+	struct Scsi_Host *shost = sdev->host;
 	struct bfad_im_port_s *im_port =
 			(struct bfad_im_port_s *) shost->hostdata[0];
-	struct bfad_itnim_data_s *itnim_data = cmnd->device->hostdata;
+	struct bfad_itnim_data_s *itnim_data = sdev->hostdata;
 	struct bfad_s         *bfad = im_port->bfad;
 	struct bfa_tskim_s *tskim;
 	struct bfad_itnim_s   *itnim;
@@ -305,14 +301,20 @@ bfad_im_reset_lun_handler(struct scsi_cmnd *cmnd)
 	struct scsi_lun scsilun;
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
+	if (itnim_data->tmf_wq) {
+		BFA_LOG(KERN_ERR, bfad, bfa_log_level,
+			"LUN reset, TMF already active");
+		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+		rc = FAILED;
+		goto out;
+	}
 	itnim = itnim_data->itnim;
 	if (!itnim) {
 		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
 		rc = FAILED;
 		goto out;
 	}
-
-	tskim = bfa_tskim_alloc(&bfad->bfa, (struct bfad_tskim_s *) cmnd);
+	tskim = bfa_tskim_alloc(&bfad->bfa, (struct bfad_tskim_s *) itnim_data);
 	if (!tskim) {
 		BFA_LOG(KERN_ERR, bfad, bfa_log_level,
 				"LUN reset, fail to allocate tskim");
@@ -321,13 +323,8 @@ bfad_im_reset_lun_handler(struct scsi_cmnd *cmnd)
 		goto out;
 	}
 
-	/*
-	 * Set host_scribble to NULL to avoid aborting a task command
-	 * if happens.
-	 */
-	cmnd->host_scribble = NULL;
-	bfad_priv(cmnd)->wq = &wq;
-	bfad_priv(cmnd)->status = 0;
+	itnim_data->tmf_wq = &wq;
+	itnim_data->tmf_status = 0;
 	bfa_itnim = bfa_fcs_itnim_get_halitn(&itnim->fcs_itnim);
 	/*
 	 * bfa_itnim can be NULL if the port gets disconnected and the bfa
@@ -342,14 +339,15 @@ bfad_im_reset_lun_handler(struct scsi_cmnd *cmnd)
 		rc = FAILED;
 		goto out;
 	}
-	int_to_scsilun(cmnd->device->lun, &scsilun);
+	int_to_scsilun(sdev->lun, &scsilun);
 	bfa_tskim_start(tskim, bfa_itnim, scsilun,
 			    FCP_TM_LUN_RESET, BFAD_LUN_RESET_TMO);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
 
-	wait_event(wq, test_bit(IO_DONE_BIT, &bfad_priv(cmnd)->status));
+	wait_event(wq, test_bit(IO_DONE_BIT, &itnim_data->tmf_status));
 
-	task_status = bfad_priv(cmnd)->status >> 1;
+	itnim_data->tmf_wq = NULL;
+	task_status = itnim_data->tmf_status >> 1;
 	if (task_status != BFI_TSKIM_STS_OK) {
 		BFA_LOG(KERN_ERR, bfad, bfa_log_level,
 			"LUN reset failure, status: %d\n", task_status);
@@ -368,35 +366,47 @@ bfad_im_reset_target_handler(struct scsi_cmnd *cmnd)
 {
 	struct Scsi_Host *shost = cmnd->device->host;
 	struct scsi_target *starget = scsi_target(cmnd->device);
+	struct fc_rport *rport = starget_to_rport(starget);
 	struct bfad_im_port_s *im_port =
 				(struct bfad_im_port_s *) shost->hostdata[0];
-	struct bfad_s         *bfad = im_port->bfad;
-	struct bfad_itnim_s   *itnim;
-	unsigned long   flags;
-	u32        rc, rtn = FAILED;
+	struct bfad_s *bfad = im_port->bfad;
+	struct bfad_itnim_data_s *itnim_data;
+	struct bfad_itnim_s *itnim;
+	unsigned long flags;
+	u32 rc, rtn = FAILED;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	enum bfi_tskim_status task_status;
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
-	itnim = bfad_get_itnim(im_port, starget->id);
-	if (itnim) {
-		bfad_priv(cmnd)->wq = &wq;
-		rc = bfad_im_target_reset_send(bfad, cmnd, itnim);
-		if (rc == BFA_STATUS_OK) {
-			/* wait target reset to complete */
-			spin_unlock_irqrestore(&bfad->bfad_lock, flags);
-			wait_event(wq, test_bit(IO_DONE_BIT,
-						&bfad_priv(cmnd)->status));
-			spin_lock_irqsave(&bfad->bfad_lock, flags);
-
-			task_status = bfad_priv(cmnd)->status >> 1;
-			if (task_status != BFI_TSKIM_STS_OK)
-				BFA_LOG(KERN_ERR, bfad, bfa_log_level,
-					"target reset failure,"
-					" status: %d\n", task_status);
-			else
-				rtn = SUCCESS;
-		}
+	if (!rport->dd_data) {
+		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+		return rtn;
+	}
+	itnim_data = rport->dd_data;
+	if (itnim_data->tmf_wq) {
+		BFA_LOG(KERN_ERR, bfad, bfa_log_level,
+			"target reset failed, TMF already active");
+		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+		return rtn;
+	}
+	itnim = itnim_data->itnim;
+	itnim_data->tmf_wq = &wq;
+	itnim_data->tmf_status = 0;
+	rc = bfad_im_target_reset_send(bfad, itnim_data);
+	if (rc == BFA_STATUS_OK) {
+		/* wait target reset to complete */
+		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+		wait_event(wq, test_bit(IO_DONE_BIT,
+					&itnim_data->tmf_status));
+		spin_lock_irqsave(&bfad->bfad_lock, flags);
+
+		task_status = itnim_data->tmf_status >> 1;
+		if (task_status != BFI_TSKIM_STS_OK)
+			BFA_LOG(KERN_ERR, bfad, bfa_log_level,
+				"target reset failure,"
+				" status: %d\n", task_status);
+		else
+			rtn = SUCCESS;
 	}
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
 
diff --git a/drivers/scsi/bfa/bfad_im.h b/drivers/scsi/bfa/bfad_im.h
index 4353feedf76a..48e8c12969c9 100644
--- a/drivers/scsi/bfa/bfad_im.h
+++ b/drivers/scsi/bfa/bfad_im.h
@@ -61,6 +61,8 @@ static inline struct bfad_cmd_priv *bfad_priv(struct scsi_cmnd *cmd)
 
 struct bfad_itnim_data_s {
 	struct bfad_itnim_s *itnim;
+	wait_queue_head_t *tmf_wq;
+	unsigned long tmf_status;
 };
 
 struct bfad_im_port_s {
-- 
2.35.3

