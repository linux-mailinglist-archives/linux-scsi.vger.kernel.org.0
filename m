Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FE3671D6
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244980AbhDURtZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:49:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245079AbhDURtN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BF6CB2FB;
        Wed, 21 Apr 2021 17:48:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 34/42] aha152x: do not set message byte when calling scsi_done()
Date:   Wed, 21 Apr 2021 19:47:41 +0200
Message-Id: <20210421174749.11221-35-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The done() function is called with a host_byte indicating the
actual error when the message byte is set. As the host byte takes
precedence during error recovery we can drop setting the message
byte if the host byte is set, too.
The only other case is when the host byte is DID_OK, but in that case
the message byte is always COMMAND_COMPLETE (ie 0), so we can drop
it there, too.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aha152x.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index f59d11f8080a..b13b5c85f3de 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -620,7 +620,7 @@ static irqreturn_t intr(int irq, void *dev_id);
 static void reset_ports(struct Scsi_Host *shpnt);
 static void aha152x_error(struct Scsi_Host *shpnt, char *msg);
 static void done(struct Scsi_Host *shpnt, unsigned char status_byte,
-		 unsigned char msg_byte, unsigned char host_byte);
+		 unsigned char host_byte);
 
 /* diagnostics */
 static void show_command(struct scsi_cmnd * ptr);
@@ -1273,7 +1273,7 @@ static int aha152x_biosparam(struct scsi_device *sdev, struct block_device *bdev
  *
  */
 static void done(struct Scsi_Host *shpnt, unsigned char status_byte,
-		 unsigned char msg_byte, unsigned char host_byte)
+		 unsigned char host_byte)
 {
 	if (CURRENT_SC) {
 		if(DONE_SC)
@@ -1283,8 +1283,7 @@ static void done(struct Scsi_Host *shpnt, unsigned char status_byte,
 
 		DONE_SC = CURRENT_SC;
 		CURRENT_SC = NULL;
-		DONE_SC->result = status_byte;
-		set_msg_byte(DONE_SC, msg_byte);
+		set_status_byte(DONE_SC, status_byte);
 		set_host_byte(DONE_SC, host_byte);
 	} else
 		printk(KERN_ERR "aha152x: done() called outside of command\n");
@@ -1380,16 +1379,13 @@ static void busfree_run(struct Scsi_Host *shpnt)
 
 		if(CURRENT_SC->SCp.phase & completed) {
 			/* target sent COMMAND COMPLETE */
-			done(shpnt, CURRENT_SC->SCp.Status,
-			     CURRENT_SC->SCp.Message, DID_OK);
+			done(shpnt, CURRENT_SC->SCp.Status, DID_OK);
 
 		} else if(CURRENT_SC->SCp.phase & aborted) {
-			done(shpnt, CURRENT_SC->SCp.Status,
-			     CURRENT_SC->SCp.Message, DID_ABORT);
+			done(shpnt, CURRENT_SC->SCp.Status, DID_ABORT);
 
 		} else if(CURRENT_SC->SCp.phase & resetted) {
-			done(shpnt, CURRENT_SC->SCp.Status,
-			     CURRENT_SC->SCp.Message, DID_RESET);
+			done(shpnt, CURRENT_SC->SCp.Status, DID_RESET);
 
 		} else if(CURRENT_SC->SCp.phase & disconnected) {
 			/* target sent DISCONNECT */
@@ -1401,8 +1397,7 @@ static void busfree_run(struct Scsi_Host *shpnt)
 			CURRENT_SC = NULL;
 
 		} else {
-			done(shpnt, SAM_STAT_GOOD,
-			     COMMAND_COMPLETE, DID_ERROR);
+			done(shpnt, SAM_STAT_GOOD, DID_ERROR);
 		}
 #if defined(AHA152X_STAT)
 	} else {
@@ -1523,8 +1518,7 @@ static void seldo_run(struct Scsi_Host *shpnt)
 	if (TESTLO(SSTAT0, SELDO)) {
 		scmd_printk(KERN_ERR, CURRENT_SC,
 			    "aha152x: passing bus free condition\n");
-		done(shpnt, SAM_STAT_GOOD,
-		     COMMAND_COMPLETE, DID_NO_CONNECT);
+		done(shpnt, SAM_STAT_GOOD, DID_NO_CONNECT);
 		return;
 	}
 
@@ -1561,15 +1555,12 @@ static void selto_run(struct Scsi_Host *shpnt)
 	CURRENT_SC->SCp.phase &= ~selecting;
 
 	if (CURRENT_SC->SCp.phase & aborted)
-		done(shpnt, SAM_STAT_GOOD,
-		     COMMAND_COMPLETE, DID_ABORT);
+		done(shpnt, SAM_STAT_GOOD, DID_ABORT);
 	else if (TESTLO(SSTAT0, SELINGO))
-		done(shpnt, SAM_STAT_GOOD,
-		     COMMAND_COMPLETE, DID_BUS_BUSY);
+		done(shpnt, SAM_STAT_GOOD, DID_BUS_BUSY);
 	else
 		/* ARBITRATION won, but SELECTION failed */
-		done(shpnt, SAM_STAT_GOOD,
-		     COMMAND_COMPLETE, DID_NO_CONNECT);
+		done(shpnt, SAM_STAT_GOOD, DID_NO_CONNECT);
 }
 
 /*
@@ -1903,8 +1894,7 @@ static void cmd_init(struct Scsi_Host *shpnt)
 	if (CURRENT_SC->SCp.sent_command) {
 		scmd_printk(KERN_ERR, CURRENT_SC,
 			    "command already sent\n");
-		done(shpnt, SAM_STAT_GOOD,
-		     COMMAND_COMPLETE, DID_ERROR);
+		done(shpnt, SAM_STAT_GOOD, DID_ERROR);
 		return;
 	}
 
@@ -2244,8 +2234,7 @@ static int update_state(struct Scsi_Host *shpnt)
 static void parerr_run(struct Scsi_Host *shpnt)
 {
 	scmd_printk(KERN_ERR, CURRENT_SC, "parity error\n");
-	done(shpnt, SAM_STAT_GOOD,
-	     COMMAND_COMPLETE, DID_PARITY);
+	done(shpnt, SAM_STAT_GOOD, DID_PARITY);
 }
 
 /*
@@ -2268,7 +2257,7 @@ static void rsti_run(struct Scsi_Host *shpnt)
 			kfree(ptr->host_scribble);
 			ptr->host_scribble=NULL;
 
-			ptr->result =  DID_RESET << 16;
+			set_host_byte(ptr, DID_RESET);
 			ptr->scsi_done(ptr);
 		}
 
@@ -2276,8 +2265,7 @@ static void rsti_run(struct Scsi_Host *shpnt)
 	}
 
 	if(CURRENT_SC && !CURRENT_SC->device->soft_reset)
-		done(shpnt, SAM_STAT_GOOD,
-		     COMMAND_COMPLETE, DID_RESET);
+		done(shpnt, SAM_STAT_GOOD, DID_RESET);
 }
 
 
-- 
2.29.2

