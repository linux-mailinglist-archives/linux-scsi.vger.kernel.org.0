Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AE521F69D
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGNQDH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 12:03:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgGNQDH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Jul 2020 12:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66051B1A5;
        Tue, 14 Jul 2020 16:03:08 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     James Bottomley <james.bottomley@hansenpartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] aic79xx: restore modes when exiting ahd_linux_queue_abort_cmd()
Date:   Tue, 14 Jul 2020 18:03:01 +0200
Message-Id: <20200714160301.4482-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

ahd_linux_queue_abort_cmd() calls ahd_save_modes() without calling
ahd_restore_modes() before exiting.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index dc4fe334efd0..abb5447f1de4 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -2147,7 +2147,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 	u_int  last_phase;
 	u_int  saved_scsiid;
 	u_int  cdb_byte;
-	int    retval;
+	int    retval = SUCCESS;
 	int    was_paused;
 	int    paused;
 	int    wait;
@@ -2185,8 +2185,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 		 * so we must not still own the command.
 		 */
 		scmd_printk(KERN_INFO, cmd, "Is not an active device\n");
-		retval = SUCCESS;
-		goto no_cmd;
+		goto done;
 	}
 
 	/*
@@ -2199,7 +2198,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 
 	if (pending_scb == NULL) {
 		scmd_printk(KERN_INFO, cmd, "Command not found\n");
-		goto no_cmd;
+		goto done;
 	}
 
 	if ((pending_scb->flags & SCB_RECOVERY_SCB) != 0) {
@@ -2207,7 +2206,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 		 * We can't queue two recovery actions using the same SCB
 		 */
 		retval = FAILED;
-		goto  done;
+		goto done;
 	}
 
 	/*
@@ -2222,7 +2221,7 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 
 	if ((pending_scb->flags & SCB_ACTIVE) == 0) {
 		scmd_printk(KERN_INFO, cmd, "Command already completed\n");
-		goto no_cmd;
+		goto done;
 	}
 
 	printk("%s: At time of recovery, card was %spaused\n",
@@ -2239,7 +2238,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 		printk("%s:%d:%d:%d: Cmd aborted from QINFIFO\n",
 		       ahd_name(ahd), cmd->device->channel, 
 		       cmd->device->id, (u8)cmd->device->lun);
-		retval = SUCCESS;
 		goto done;
 	}
 
@@ -2336,17 +2334,10 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd *cmd)
 	} else {
 		scmd_printk(KERN_INFO, cmd, "Unable to deliver message\n");
 		retval = FAILED;
-		goto done;
 	}
 
-no_cmd:
-	/*
-	 * Our assumption is that if we don't have the command, no
-	 * recovery action was required, so we return success.  Again,
-	 * the semantics of the mid-layer recovery engine are not
-	 * well defined, so this may change in time.
-	 */
-	retval = SUCCESS;
+
+	ahd_restore_modes(ahd, saved_modes);
 done:
 	if (paused)
 		ahd_unpause(ahd);
-- 
2.16.4

