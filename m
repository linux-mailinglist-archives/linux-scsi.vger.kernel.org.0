Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF67CA40C
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Oct 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjJPJZF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Oct 2023 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjJPJYv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Oct 2023 05:24:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE8EA
        for <linux-scsi@vger.kernel.org>; Mon, 16 Oct 2023 02:24:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABE6621C45;
        Mon, 16 Oct 2023 09:24:44 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1D2542D10D;
        Mon, 16 Oct 2023 09:24:44 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D5A0B51EBDCB; Mon, 16 Oct 2023 11:24:43 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/17] xen-scsifront: add scsi device as argument to scsifront_do_request()
Date:   Mon, 16 Oct 2023 11:24:20 +0200
Message-Id: <20231016092430.55557-8-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231016092430.55557-1-hare@suse.de>
References: <20231016092430.55557-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [11.49 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[5];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(3.00)[1.000];
         MID_CONTAINS_FROM(1.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         BAYES_HAM(-0.00)[12.26%]
X-Spam-Score: 11.49
X-Rspamd-Queue-Id: ABE6621C45
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add scsi device as argument to scsifront_do_request() so that it
will be possible to call it with a NULL command pointer.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/xen-scsifront.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 9ec55ddc1204..a0c13200d53a 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -178,7 +178,8 @@ static void scsifront_put_rqid(struct vscsifrnt_info *info, uint32_t id)
 		scsifront_wake_up(info);
 }
 
-static int scsifront_do_request(struct vscsifrnt_info *info,
+static int scsifront_do_request(struct scsi_device *sdev,
+				struct vscsifrnt_info *info,
 				struct vscsifrnt_shadow *shadow)
 {
 	struct vscsiif_front_ring *ring = &(info->ring);
@@ -205,17 +206,25 @@ static int scsifront_do_request(struct vscsifrnt_info *info,
 	ring_req->ref_rqid    = shadow->ref_rqid;
 	ring_req->nr_segments = shadow->nr_segments;
 
-	ring_req->id      = sc->device->id;
-	ring_req->lun     = sc->device->lun;
-	ring_req->channel = sc->device->channel;
-	ring_req->cmd_len = sc->cmd_len;
+	ring_req->id      = sdev->id;
+	ring_req->lun     = sdev->lun;
+	ring_req->channel = sdev->channel;
 
-	BUG_ON(sc->cmd_len > VSCSIIF_MAX_COMMAND_SIZE);
+	if (sc) {
+		ring_req->cmd_len = sc->cmd_len;
 
-	memcpy(ring_req->cmnd, sc->cmnd, sc->cmd_len);
+		BUG_ON(sc->cmd_len > VSCSIIF_MAX_COMMAND_SIZE);
 
-	ring_req->sc_data_direction   = (uint8_t)sc->sc_data_direction;
-	ring_req->timeout_per_command = scsi_cmd_to_rq(sc)->timeout / HZ;
+		memcpy(ring_req->cmnd, sc->cmnd, sc->cmd_len);
+
+		ring_req->sc_data_direction   = (uint8_t)sc->sc_data_direction;
+		ring_req->timeout_per_command =
+			scsi_cmd_to_rq(sc)->timeout / HZ;
+	} else {
+		ring_req->cmd_len = VSCSIIF_MAX_COMMAND_SIZE;
+		memset(ring_req->cmnd, 0, VSCSIIF_MAX_COMMAND_SIZE);
+		ring_req->sc_data_direction = DMA_NONE;
+	}
 
 	for (i = 0; i < (shadow->nr_segments & ~VSCSIIF_SG_GRANT); i++)
 		ring_req->seg[i] = shadow->seg[i];
@@ -637,7 +646,7 @@ static int scsifront_queuecommand(struct Scsi_Host *shost,
 		return 0;
 	}
 
-	if (scsifront_do_request(info, shadow)) {
+	if (scsifront_do_request(sc->device, info, shadow)) {
 		scsifront_gnttab_done(info, shadow);
 		goto busy;
 	}
@@ -685,7 +694,7 @@ static int scsifront_action_handler(struct scsi_cmnd *sc, uint8_t act)
 		if (scsifront_enter(info))
 			goto fail;
 
-		if (!scsifront_do_request(info, shadow))
+		if (!scsifront_do_request(sc->device, info, shadow))
 			break;
 
 		scsifront_return(info);
-- 
2.35.3

