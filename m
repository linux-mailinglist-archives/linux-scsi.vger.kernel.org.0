Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8567974C
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Jan 2023 13:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjAXMIA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Jan 2023 07:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjAXMH7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 Jan 2023 07:07:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724722ED5C
        for <linux-scsi@vger.kernel.org>; Tue, 24 Jan 2023 04:07:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30D7B211C2;
        Tue, 24 Jan 2023 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674562077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EmGibTBZ9EowfNbqQnHD6gi5zJ9/GfRTWTh5aRLHjRw=;
        b=fA24g04eJUwsYY8J+k5O7DyfRnrx5q2po5rjVDS+OnnWFkfqumchpHRpKz4vKqsmJE871B
        8tLRKWoY+gstlhlarfAkfhptCV480SJsSuZFJzElOP8EGmyGzAa2bbbMv8vtKmpZS5hdYq
        HbsuoQmSbG2/n9EKUTr26D3WoRanEFI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0730139FB;
        Tue, 24 Jan 2023 12:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cBNVMRzKz2PWMQAAMHmgww
        (envelope-from <mwilck@suse.com>); Tue, 24 Jan 2023 12:07:56 +0000
From:   mwilck@suse.com
To:     Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH] scsi: add non-sleeping variant of scsi_device_put() and use it in alua
Date:   Tue, 24 Jan 2023 13:07:34 +0100
Message-Id: <20230124120734.15806-1-mwilck@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

Since the might_sleep() annotation was added in scsi_device_put() and
alua_rtpg_queue(), we have seen repeated reports of "BUG: sleeping function
called from invalid context" [1], [2]. alua_rtpg_queue() is always called
from contexts where the caller must hold at least one reference to the
scsi device in question. This means that the reference taken by
alua_rtpg_queue() itself can't be the last one, and thus can be dropped
without entering the code path in which scsi_device_put() might actually
sleep.

Add a new helper function, scsi_device_put_nosleep() for cases like this,
where a device reference is put from atomic context, and at the same time
it is certain that this reference is not the last one, and use it from
alua_rtpg_queue().

[1] https://lore.kernel.org/linux-scsi/b49e37d5-edfb-4c56-3eeb-62c7d5855c00@linux.ibm.com/
[2] https://lore.kernel.org/linux-scsi/55c35e64-a7d4-9072-46fd-e8eae6a90e96@linux.ibm.com/

Fixes: f93ed747e2c7 ("scsi: core: Release SCSI devices synchronously")
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Sachin Sant <sachinp@linux.ibm.com>
Cc: Benjamin Block <bblock@linux.ibm.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/scsi/device_handler/scsi_dh_alua.c |  4 +---
 drivers/scsi/scsi.c                        | 23 ++++++++++++++++++----
 include/scsi/scsi_device.h                 |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 49cc18a87473..bdfcea1c16cb 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -989,8 +989,6 @@ static bool alua_rtpg_queue(struct alua_port_group *pg,
 	int start_queue = 0;
 	unsigned long flags;
 
-	might_sleep();
-
 	if (WARN_ON_ONCE(!pg) || scsi_device_get(sdev))
 		return false;
 
@@ -1031,7 +1029,7 @@ static bool alua_rtpg_queue(struct alua_port_group *pg,
 			kref_put(&pg->kref, release_port_group);
 	}
 	if (sdev)
-		scsi_device_put(sdev);
+		scsi_device_put_nosleep(sdev);
 
 	return true;
 }
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1426b9b03612..eec52bb298a7 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -576,6 +576,24 @@ int scsi_device_get(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL(scsi_device_get);
 
+/**
+ * scsi_device_put_nosleep  -  release a reference to a scsi_device
+ * @sdev:	device to release a reference on.
+ *
+ * Description: Release a reference to the scsi_device and decrements the use
+ * count of the underlying LLDD module. This function may only be called from
+ * a call context where it is certain that the reference dropped is not the
+ * last one.
+ */
+void scsi_device_put_nosleep(struct scsi_device *sdev)
+{
+	struct module *mod = sdev->host->hostt->module;
+
+	put_device(&sdev->sdev_gendev);
+	module_put(mod);
+}
+EXPORT_SYMBOL(scsi_device_put);
+
 /**
  * scsi_device_put  -  release a reference to a scsi_device
  * @sdev:	device to release a reference on.
@@ -586,12 +604,9 @@ EXPORT_SYMBOL(scsi_device_get);
  */
 void scsi_device_put(struct scsi_device *sdev)
 {
-	struct module *mod = sdev->host->hostt->module;
-
 	might_sleep();
 
-	put_device(&sdev->sdev_gendev);
-	module_put(mod);
+	scsi_device_put_nosleep(sdev);
 }
 EXPORT_SYMBOL(scsi_device_put);
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 3642b8e3928b..85cffa07f2c0 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -365,6 +365,7 @@ void scsi_attach_vpd(struct scsi_device *sdev);
 
 extern struct scsi_device *scsi_device_from_queue(struct request_queue *q);
 extern int __must_check scsi_device_get(struct scsi_device *);
+extern void scsi_device_put_nosleep(struct scsi_device *);
 extern void scsi_device_put(struct scsi_device *);
 extern struct scsi_device *scsi_device_lookup(struct Scsi_Host *,
 					      uint, uint, u64);
-- 
2.39.0

