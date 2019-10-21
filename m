Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB53DE887
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 11:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfJUJxa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 05:53:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJUJxa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:53:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3A6ABAB6;
        Mon, 21 Oct 2019 09:53:28 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/24] acornscsi: use standard defines
Date:   Mon, 21 Oct 2019 11:53:02 +0200
Message-Id: <20191021095322.137969-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021095322.137969-1-hare@suse.de>
References: <20191021095322.137969-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use midlayer-defined values and drop the non-existing QUEUE_FULL
case.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/arm/acornscsi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index d12dd89538df..7e69e481ccac 100644
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

