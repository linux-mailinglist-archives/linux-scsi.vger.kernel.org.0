Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8756819F
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jul 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiGFIeA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiGFId5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 04:33:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE51240BA
        for <linux-scsi@vger.kernel.org>; Wed,  6 Jul 2022 01:33:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86187336F8;
        Wed,  6 Jul 2022 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657096433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZOlmrdEiTlDeLehiLbYCNqQa1+nH4MMrgOog0CDHNL0=;
        b=oZvxhmRw1fbSy/RU5UO6u+9GOrjwbD/j3yvV6b9P1PDfRoXYFAajMT3Pf81jR2tsR3Si0E
        ww5X837ktRk2qTGFFUrIgJw3XueNnPODKjsTq3ocusV2PHUMbuoaiR+X1EJlFdE9vVGI31
        Sqb+V5vdP0+7lv6GRb+00gib+d7bwsg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E29E13A7D;
        Wed,  6 Jul 2022 08:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jSdgEfFIxWLRJgAAMHmgww
        (envelope-from <oneukum@suse.com>); Wed, 06 Jul 2022 08:33:53 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] sd: make open_cnt unsigned
Date:   Wed,  6 Jul 2022 10:33:50 +0200
Message-Id: <20220706083350.14154-1-oneukum@suse.com>
X-Mailer: git-send-email 2.35.3
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

You really cannot have a negative number of openers.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 118c7b4a8af2..d38fa3fe031b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -169,7 +169,7 @@ typedef struct sg_device { /* holds the state of each scsi generic device */
 	rwlock_t sfd_lock;      /* protect access to sfd list */
 	atomic_t detaching;     /* 0->device usable, 1->device detaching */
 	bool exclude;		/* 1->open(O_EXCL) succeeded and is active */
-	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
+	unsigned int open_cnt;	/* count of opens (perhaps < num(sfds) ) */
 	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
 	char name[DISK_NAME_LEN];
 	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
-- 
2.35.3

