Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0142072FB29
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Jun 2023 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjFNKgq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Jun 2023 06:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjFNKgi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Jun 2023 06:36:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038CC3;
        Wed, 14 Jun 2023 03:36:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6FE42253D;
        Wed, 14 Jun 2023 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686738995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBZbEawiIpZprdZTA1GMxE9hL27s7KVDXGtVeStDZCs=;
        b=tXq+9gYYkLoGjIexgfFsXiUWMfhw7+U4d1t8OqrrolAw2wK5/5+M8kYhcFLrW++V3ht/Yl
        R9t9KII8lLXAEsZEiBc/6ry/7AGjajRSp6Ou/cc70IXRVieyH70IfDvnddNRkFvBUBLlrF
        3AxBxsPlvZZo+Tx+j07DgmkTFnd1Ge8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 568661357F;
        Wed, 14 Jun 2023 10:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id COpFEzOYiWSTfQAAMHmgww
        (envelope-from <mwilck@suse.com>); Wed, 14 Jun 2023 10:36:35 +0000
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v7 7/7] scsi: improve warning message in scsi_device_block()
Date:   Wed, 14 Jun 2023 12:36:16 +0200
Message-Id: <20230614103616.31857-8-mwilck@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614103616.31857-1-mwilck@suse.com>
References: <20230614103616.31857-1-mwilck@suse.com>
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

If __scsi_internal_device_block() returns an error, it is always -EINVAL
because of an invalid state transition. For debugging purposes, it makes
more sense to print the device state.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 599c9ec550e0..b7f78e53184a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2790,9 +2790,11 @@ EXPORT_SYMBOL_GPL(scsi_internal_device_block_nowait);
 static void scsi_device_block(struct scsi_device *sdev, void *data)
 {
 	int err;
+	enum scsi_device_state state;
 
 	mutex_lock(&sdev->state_mutex);
 	err = __scsi_internal_device_block_nowait(sdev);
+	state = sdev->sdev_state;
 	if (err == 0)
 		/*
 		 * scsi_stop_queue() must be called with the state_mutex
@@ -2803,8 +2805,8 @@ static void scsi_device_block(struct scsi_device *sdev, void *data)
 
 	mutex_unlock(&sdev->state_mutex);
 
-	WARN_ONCE(err, "__scsi_internal_device_block_nowait(%s) failed: err = %d\n",
-		  dev_name(&sdev->sdev_gendev), err);
+	WARN_ONCE(err, "%s: failed to block %s in state %d\n",
+		  __func__, dev_name(&sdev->sdev_gendev), state);
 }
 
 /**
-- 
2.40.1

