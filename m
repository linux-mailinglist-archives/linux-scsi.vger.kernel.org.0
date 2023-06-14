Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB4726897
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Jun 2023 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjFGSYy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Jun 2023 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjFGSYm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Jun 2023 14:24:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA3826BB;
        Wed,  7 Jun 2023 11:24:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A10E21FDB6;
        Wed,  7 Jun 2023 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686162195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcQe94NHWKwEfD3MI7AnQAtuXjeqyhqnM1uaeyFHWSs=;
        b=GAALNW3/t1DsjWjR2gP0xLezPK6/VzFBX7uwANlzX4F+J/q/AfeRr9VrOurbnrR5+4dRv8
        FmFRAFebCO28bQb9SdwuLMQfz7QKfwQHHGqv4xOMx37QBBzTjJhNPM38kmQG2rktzC4SC3
        dzEAK9Y+04EOjWrk6ZnzGOHZnYypTFM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 061D71346D;
        Wed,  7 Jun 2023 18:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id INRYOhLLgGRzBQAAMHmgww
        (envelope-from <mwilck@suse.com>); Wed, 07 Jun 2023 18:23:14 +0000
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 1/8] bsg: increase number of devices
Date:   Wed,  7 Jun 2023 20:22:42 +0200
Message-Id: <20230607182249.22623-2-mwilck@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607182249.22623-1-mwilck@suse.com>
References: <20230607182249.22623-1-mwilck@suse.com>
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

From: Hannes Reinecke <hare@suse.de>

Larger setups may need to allocate more than 32k bsg devices, so
increase the number of devices to the full range of minor device
numbers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bsg.c b/block/bsg.c
index 7eca43f33d7f..c53f24243bf2 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -36,7 +36,7 @@ static inline struct bsg_device *to_bsg_device(struct inode *inode)
 }
 
 #define BSG_DEFAULT_CMDS	64
-#define BSG_MAX_DEVS		32768
+#define BSG_MAX_DEVS		(1 << MINORBITS)
 
 static DEFINE_IDA(bsg_minor_ida);
 static struct class *bsg_class;
-- 
2.40.1

