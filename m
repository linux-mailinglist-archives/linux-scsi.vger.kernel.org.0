Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72F51797D
	for <lists+linux-scsi@lfdr.de>; Mon,  2 May 2022 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbiEBV6D (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 May 2022 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387806AbiEBV5y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 May 2022 17:57:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC8FD23
        for <linux-scsi@vger.kernel.org>; Mon,  2 May 2022 14:54:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A2BB91F896;
        Mon,  2 May 2022 21:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651528460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ry5H6cMidPWYUAqkFmsNUYphLy8pO7JStnwRsjeJSZ0=;
        b=1wAa3xXqqEe7K4AFNY4p/wLtIOuGIiQPpp/OMRbafIYqgnFfrGokpRmq78rvVnsSGnRMS7
        sIxLLEdX4WlCulTaShe+kFvHkccWh1Tws80zp/bJJqU8U2QO3IEaMD3tT4f979AHLIBe2W
        0hlxOVpiKrap++GSnsoNV6usi1G9BMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651528460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ry5H6cMidPWYUAqkFmsNUYphLy8pO7JStnwRsjeJSZ0=;
        b=ByAKZiXXjtp3LC4RPRNzarv+44AwoVXEO0EY1+gPYQ2w0Zlmip/zaMxx/NOdiQdKfwPXzw
        SYOvSvmsAb7H7IDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9D6B92C14E;
        Mon,  2 May 2022 21:54:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9B67D5194138; Mon,  2 May 2022 23:54:20 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 09/11] xen-scsifront: add scsi device as argument to scsifront_do_request()
Date:   Mon,  2 May 2022 23:54:14 +0200
Message-Id: <20220502215416.5351-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220502215416.5351-1-hare@suse.de>
References: <20220502215416.5351-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add scsi device as argument to scsifront_do_request() so that it
will be possible to call it with a NULL command pointer.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/xen-scsifront.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 12109e4c73d4..9de099532f8b 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -175,7 +175,8 @@ static void scsifront_put_rqid(struct vscsifrnt_info *info, uint32_t id)
 		scsifront_wake_up(info);
 }
 
-static int scsifront_do_request(struct vscsifrnt_info *info,
+static int scsifront_do_request(struct scsi_device *sdev,
+				struct vscsifrnt_info *info,
 				struct vscsifrnt_shadow *shadow)
 {
 	struct vscsiif_front_ring *ring = &(info->ring);
@@ -202,17 +203,25 @@ static int scsifront_do_request(struct vscsifrnt_info *info,
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
@@ -561,7 +570,7 @@ static int scsifront_queuecommand(struct Scsi_Host *shost,
 		return 0;
 	}
 
-	if (scsifront_do_request(info, shadow)) {
+	if (scsifront_do_request(sc->device, info, shadow)) {
 		scsifront_gnttab_done(info, shadow);
 		goto busy;
 	}
@@ -606,7 +615,7 @@ static int scsifront_action_handler(struct scsi_cmnd *sc, uint8_t act)
 		if (scsifront_enter(info))
 			goto fail;
 
-		if (!scsifront_do_request(info, shadow))
+		if (!scsifront_do_request(sc->device, info, shadow))
 			break;
 
 		scsifront_return(info);
-- 
2.29.2

