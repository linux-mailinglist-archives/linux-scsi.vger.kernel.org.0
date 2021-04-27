Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04DE36C0F3
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhD0IcT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 04:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235188AbhD0IcC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:32:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A46E8B143;
        Tue, 27 Apr 2021 08:31:06 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 29/40] aha152x: modify done() to use separate status bytes
Date:   Tue, 27 Apr 2021 10:30:35 +0200
Message-Id: <20210427083046.31620-30-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210427083046.31620-1-hare@suse.de>
References: <20210427083046.31620-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of passing in the combined SCSI result value split them
off into separate status, message, and host byte values.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aha152x.c | 43 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index d8e19afa7a14..f59d11f8080a 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -619,7 +619,8 @@ static struct {
 static irqreturn_t intr(int irq, void *dev_id);
 static void reset_ports(struct Scsi_Host *shpnt);
 static void aha152x_error(struct Scsi_Host *shpnt, char *msg);
-static void done(struct Scsi_Host *shpnt, int error);
+static void done(struct Scsi_Host *shpnt, unsigned char status_byte,
+		 unsigned char msg_byte, unsigned char host_byte);
 
 /* diagnostics */
 static void show_command(struct scsi_cmnd * ptr);
@@ -1271,7 +1272,8 @@ static int aha152x_biosparam(struct scsi_device *sdev, struct block_device *bdev
  *  Internal done function
  *
  */
-static void done(struct Scsi_Host *shpnt, int error)
+static void done(struct Scsi_Host *shpnt, unsigned char status_byte,
+		 unsigned char msg_byte, unsigned char host_byte)
 {
 	if (CURRENT_SC) {
 		if(DONE_SC)
@@ -1281,7 +1283,9 @@ static void done(struct Scsi_Host *shpnt, int error)
 
 		DONE_SC = CURRENT_SC;
 		CURRENT_SC = NULL;
-		DONE_SC->result = error;
+		DONE_SC->result = status_byte;
+		set_msg_byte(DONE_SC, msg_byte);
+		set_host_byte(DONE_SC, host_byte);
 	} else
 		printk(KERN_ERR "aha152x: done() called outside of command\n");
 }
@@ -1376,13 +1380,16 @@ static void busfree_run(struct Scsi_Host *shpnt)
 
 		if(CURRENT_SC->SCp.phase & completed) {
 			/* target sent COMMAND COMPLETE */
-			done(shpnt, (CURRENT_SC->SCp.Status & 0xff) | ((CURRENT_SC->SCp.Message & 0xff) << 8) | (DID_OK << 16));
+			done(shpnt, CURRENT_SC->SCp.Status,
+			     CURRENT_SC->SCp.Message, DID_OK);
 
 		} else if(CURRENT_SC->SCp.phase & aborted) {
-			done(shpnt, (CURRENT_SC->SCp.Status & 0xff) | ((CURRENT_SC->SCp.Message & 0xff) << 8) | (DID_ABORT << 16));
+			done(shpnt, CURRENT_SC->SCp.Status,
+			     CURRENT_SC->SCp.Message, DID_ABORT);
 
 		} else if(CURRENT_SC->SCp.phase & resetted) {
-			done(shpnt, (CURRENT_SC->SCp.Status & 0xff) | ((CURRENT_SC->SCp.Message & 0xff) << 8) | (DID_RESET << 16));
+			done(shpnt, CURRENT_SC->SCp.Status,
+			     CURRENT_SC->SCp.Message, DID_RESET);
 
 		} else if(CURRENT_SC->SCp.phase & disconnected) {
 			/* target sent DISCONNECT */
@@ -1394,7 +1401,8 @@ static void busfree_run(struct Scsi_Host *shpnt)
 			CURRENT_SC = NULL;
 
 		} else {
-			done(shpnt, DID_ERROR << 16);
+			done(shpnt, SAM_STAT_GOOD,
+			     COMMAND_COMPLETE, DID_ERROR);
 		}
 #if defined(AHA152X_STAT)
 	} else {
@@ -1515,7 +1523,8 @@ static void seldo_run(struct Scsi_Host *shpnt)
 	if (TESTLO(SSTAT0, SELDO)) {
 		scmd_printk(KERN_ERR, CURRENT_SC,
 			    "aha152x: passing bus free condition\n");
-		done(shpnt, DID_NO_CONNECT << 16);
+		done(shpnt, SAM_STAT_GOOD,
+		     COMMAND_COMPLETE, DID_NO_CONNECT);
 		return;
 	}
 
@@ -1552,12 +1561,15 @@ static void selto_run(struct Scsi_Host *shpnt)
 	CURRENT_SC->SCp.phase &= ~selecting;
 
 	if (CURRENT_SC->SCp.phase & aborted)
-		done(shpnt, DID_ABORT << 16);
+		done(shpnt, SAM_STAT_GOOD,
+		     COMMAND_COMPLETE, DID_ABORT);
 	else if (TESTLO(SSTAT0, SELINGO))
-		done(shpnt, DID_BUS_BUSY << 16);
+		done(shpnt, SAM_STAT_GOOD,
+		     COMMAND_COMPLETE, DID_BUS_BUSY);
 	else
 		/* ARBITRATION won, but SELECTION failed */
-		done(shpnt, DID_NO_CONNECT << 16);
+		done(shpnt, SAM_STAT_GOOD,
+		     COMMAND_COMPLETE, DID_NO_CONNECT);
 }
 
 /*
@@ -1891,7 +1903,8 @@ static void cmd_init(struct Scsi_Host *shpnt)
 	if (CURRENT_SC->SCp.sent_command) {
 		scmd_printk(KERN_ERR, CURRENT_SC,
 			    "command already sent\n");
-		done(shpnt, DID_ERROR << 16);
+		done(shpnt, SAM_STAT_GOOD,
+		     COMMAND_COMPLETE, DID_ERROR);
 		return;
 	}
 
@@ -2231,7 +2244,8 @@ static int update_state(struct Scsi_Host *shpnt)
 static void parerr_run(struct Scsi_Host *shpnt)
 {
 	scmd_printk(KERN_ERR, CURRENT_SC, "parity error\n");
-	done(shpnt, DID_PARITY << 16);
+	done(shpnt, SAM_STAT_GOOD,
+	     COMMAND_COMPLETE, DID_PARITY);
 }
 
 /*
@@ -2262,7 +2276,8 @@ static void rsti_run(struct Scsi_Host *shpnt)
 	}
 
 	if(CURRENT_SC && !CURRENT_SC->device->soft_reset)
-		done(shpnt, DID_RESET << 16 );
+		done(shpnt, SAM_STAT_GOOD,
+		     COMMAND_COMPLETE, DID_RESET);
 }
 
 
-- 
2.29.2

