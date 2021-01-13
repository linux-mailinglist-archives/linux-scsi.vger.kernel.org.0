Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2E2F471A
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbhAMJG2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:06:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:53814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbhAMJG1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:06:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2D8BB73F;
        Wed, 13 Jan 2021 09:05:03 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/35] acornscsi: use standard defines
Date:   Wed, 13 Jan 2021 10:04:35 +0100
Message-Id: <20210113090500.129644-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use midlayer-defined values and drop the non-existing QUEUE_FULL
case; we are checking the SCSI messages in the switch statement,
and QUEUE_FULL is a SCSI status hence it can never occur here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/arm/acornscsi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 9a912fd0f70b..248a5bfad153 100644
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
2.29.2

