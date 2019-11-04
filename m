Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F9EDAF7
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKDJCM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:57062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfKDJCM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 185DFB296;
        Mon,  4 Nov 2019 09:02:10 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/52] acornscsi: use standard defines
Date:   Mon,  4 Nov 2019 10:01:03 +0100
Message-Id: <20191104090151.129140-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use midlayer-defined values and drop the non-existing QUEUE_FULL
case; we are checking the SCSI messages in the switch statement,
and QUEUE_FULL is a SCSI status hence it can never occur here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/arm/acornscsi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index ddb52e7ba622..8ceb1663bdb5 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -144,12 +144,6 @@
 #define VER_MINOR 0
 #define VER_PATCH 6
 
-#ifndef ABORT_TAG
-#define ABORT_TAG 0xd
-#else
-#error "Yippee!  ABORT TAG is now defined!  Remove this error!"
-#endif
-
 #ifdef USE_DMAC
 /*
  * DMAC setup parameters
@@ -1490,8 +1484,8 @@ void acornscsi_message(AS_Host *host)
     }
 
     switch (message[0]) {
-    case ABORT:
-    case ABORT_TAG:
+    case ABORT_TASK_SET:
+    case ABORT_TASK:
     case COMMAND_COMPLETE:
 	if (host->scsi.phase != PHASE_STATUSIN) {
 	    printk(KERN_ERR "scsi%d.%c: command complete following non-status in phase?\n",
@@ -1596,10 +1590,6 @@ void acornscsi_message(AS_Host *host)
 	}
 	break;
 
-    case QUEUE_FULL:
-	/* TODO: target queue is full */
-	break;
-
     case SIMPLE_QUEUE_TAG:
 	/* tag queue reconnect... message[1] = queue tag.  Print something to indicate something happened! */
 	printk("scsi%d.%c: reconnect queue tag %02X\n",
-- 
2.16.4

