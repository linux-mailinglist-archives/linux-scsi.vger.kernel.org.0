Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88372EA27
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Jun 2023 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjFMRmm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Jun 2023 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbjFMRmi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Jun 2023 13:42:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC01E6;
        Tue, 13 Jun 2023 10:42:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78C9A1FDCA;
        Tue, 13 Jun 2023 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686678155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aO6+WMWh4e/7jdiQYineafSxAgpAwg54hYWv22eDsNY=;
        b=GJnsMAMtyHRyZXfEw+yS1Wh9eHYgDAswV4welVdAIYhbONUIr6hmDAgb+FhSjjAs8SXeI0
        uljUcPpOOPDK4AAaINLSvzO/TW9fqOm3rFxRFWUt7Je77hiAFZay//dZgBa4Ww4YvkskQ2
        F3M/44MPBGjjd/1PhbDw8o2in67NCbI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12CE913483;
        Tue, 13 Jun 2023 17:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WHmLAouqiGSWXwAAMHmgww
        (envelope-from <mwilck@suse.com>); Tue, 13 Jun 2023 17:42:35 +0000
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 5/7] scsi: don't wait for quiesce in scsi_device_block()
Date:   Tue, 13 Jun 2023 19:42:25 +0200
Message-Id: <20230613174227.11235-6-mwilck@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613174227.11235-1-mwilck@suse.com>
References: <20230613174227.11235-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

scsi_device_block() is only called from scsi_target_block(), which
calls it repeatedly for every child device. For targets with many devices,
waiting for every queue to quiesce may cause a substantial delay
(we measured more than 100s delay for blocking a FC rport with 2048 LUNs).

Just call blk_mq_wait_quiesce_done() once from scsi_target_block() after
stopping all queues.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3e12cc61569d..f20e65dd996e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2777,8 +2777,9 @@ EXPORT_SYMBOL_GPL(scsi_internal_device_block_nowait);
  * @sdev: device to block
  * @data: dummy argument, ignored
  *
- * Pause SCSI command processing on the specified device and wait until all
- * ongoing scsi_queue_rq() calls have finished. May sleep.
+ * Pause SCSI command processing on the specified device. Callers must wait
+ * until all ongoing scsi_queue_rq() calls have finished after this function
+ * returns.
  *
  * Note:
  * This routine transitions the device to the SDEV_BLOCK state (which must be
@@ -2792,17 +2793,15 @@ static void scsi_device_block(struct scsi_device *sdev, void *data)
 
 	mutex_lock(&sdev->state_mutex);
 	err = __scsi_internal_device_block_nowait(sdev);
-	if (err == 0) {
+	if (err == 0)
 		/*
 		 * scsi_stop_queue() must be called with the state_mutex
 		 * held. Otherwise a simultaneous scsi_start_queue() call
 		 * might unquiesce the queue before we quiesce it.
 		 */
 		scsi_stop_queue(sdev);
-		mutex_unlock(&sdev->state_mutex);
-		blk_mq_wait_quiesce_done(sdev->request_queue->tag_set);
-	} else
-		mutex_unlock(&sdev->state_mutex);
+
+	mutex_unlock(&sdev->state_mutex);
 
 	WARN_ONCE(err, "__scsi_internal_device_block_nowait(%s) failed: err = %d\n",
 		  dev_name(&sdev->sdev_gendev), err);
@@ -2900,11 +2899,15 @@ target_block(struct device *dev, void *data)
 void
 scsi_target_block(struct device *dev)
 {
+	struct Scsi_Host *shost = dev_to_shost(dev);
+
 	if (scsi_is_target_device(dev))
 		starget_for_each_device(to_scsi_target(dev), NULL,
 					scsi_device_block);
 	else
 		device_for_each_child(dev, NULL, target_block);
+
+	blk_mq_wait_quiesce_done(&shost->tag_set);
 }
 EXPORT_SYMBOL_GPL(scsi_target_block);
 
-- 
2.40.1

