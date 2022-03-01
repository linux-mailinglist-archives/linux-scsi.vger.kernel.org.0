Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6774D4C8E06
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Mar 2022 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiCAOkv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Mar 2022 09:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiCAOkr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Mar 2022 09:40:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F56314
        for <linux-scsi@vger.kernel.org>; Tue,  1 Mar 2022 06:40:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F301F1F8A8;
        Tue,  1 Mar 2022 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646145603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRUCCEaZajSSHM7TsU/BEYubkYyuod8oHd4WQ/SzzcA=;
        b=fTN7hBZ6NGlbRCm/LeY+mRc55HyihvBKm645nvJcMRogrUdkx4GClmW5Dr5gYbXyePPbto
        fAOT/KEN6g0CjLFOGDrd8Qbo+WHT9+DoKABMlUTBPwoWiIde1KedgtX1mQ9iVvxTmb7QCR
        FacK3M5PUX8wxAk8djCnGDL3qO7/izo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646145603;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRUCCEaZajSSHM7TsU/BEYubkYyuod8oHd4WQ/SzzcA=;
        b=iUJqdib8id9AQDIwyjyCxDpHbrZdOJdhCIz40+UicKF4LNosc8rksN3AaTjV86C8H7cHGt
        z8iZ3aGsR41YTRCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EA755A3B8E;
        Tue,  1 Mar 2022 14:40:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D720F51933D8; Tue,  1 Mar 2022 15:40:02 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 3/4] aic7xxx: do not reference scsi command when resetting device
Date:   Tue,  1 Mar 2022 15:39:56 +0100
Message-Id: <20220301143957.40998-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220301143957.40998-1-hare@suse.de>
References: <20220301143957.40998-1-hare@suse.de>
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

When sending a device reset we should not take a reference to the
scsi command.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 102 +++++++++++++++--------------
 1 file changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 16d7a7310e90..484641a76d4f 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -366,7 +366,8 @@ static void ahc_linux_queue_cmd_complete(struct ahc_softc *ahc,
 					 struct scsi_cmnd *cmd);
 static void ahc_linux_freeze_simq(struct ahc_softc *ahc);
 static void ahc_linux_release_simq(struct ahc_softc *ahc);
-static int  ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag);
+static int  ahc_linux_queue_recovery_cmd(struct scsi_device *sdev,
+					 struct scsi_cmnd *cmd);
 static void ahc_linux_initialize_scsi_bus(struct ahc_softc *ahc);
 static u_int ahc_linux_user_tagdepth(struct ahc_softc *ahc,
 				     struct ahc_devinfo *devinfo);
@@ -728,7 +729,7 @@ ahc_linux_abort(struct scsi_cmnd *cmd)
 {
 	int error;
 
-	error = ahc_linux_queue_recovery_cmd(cmd, SCB_ABORT);
+	error = ahc_linux_queue_recovery_cmd(cmd->device, cmd);
 	if (error != SUCCESS)
 		printk("aic7xxx_abort returns 0x%x\n", error);
 	return (error);
@@ -742,7 +743,7 @@ ahc_linux_dev_reset(struct scsi_cmnd *cmd)
 {
 	int error;
 
-	error = ahc_linux_queue_recovery_cmd(cmd, SCB_DEVICE_RESET);
+	error = ahc_linux_queue_recovery_cmd(cmd->device, NULL);
 	if (error != SUCCESS)
 		printk("aic7xxx_dev_reset returns 0x%x\n", error);
 	return (error);
@@ -2029,11 +2030,12 @@ ahc_linux_release_simq(struct ahc_softc *ahc)
 }
 
 static int
-ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
+ahc_linux_queue_recovery_cmd(struct scsi_device *sdev,
+			     struct scsi_cmnd *cmd)
 {
 	struct ahc_softc *ahc;
 	struct ahc_linux_device *dev;
-	struct scb *pending_scb;
+	struct scb *pending_scb = NULL, *scb;
 	u_int  saved_scbptr;
 	u_int  active_scb_index;
 	u_int  last_phase;
@@ -2046,18 +2048,19 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 	int    disconnected;
 	unsigned long flags;
 
-	pending_scb = NULL;
 	paused = FALSE;
 	wait = FALSE;
-	ahc = *(struct ahc_softc **)cmd->device->host->hostdata;
+	ahc = *(struct ahc_softc **)sdev->host->hostdata;
 
-	scmd_printk(KERN_INFO, cmd, "Attempting to queue a%s message\n",
-	       flag == SCB_ABORT ? "n ABORT" : " TARGET RESET");
+	sdev_printk(KERN_INFO, sdev, "Attempting to queue a%s message\n",
+	       cmd ? "n ABORT" : " TARGET RESET");
 
-	printk("CDB:");
-	for (cdb_byte = 0; cdb_byte < cmd->cmd_len; cdb_byte++)
-		printk(" 0x%x", cmd->cmnd[cdb_byte]);
-	printk("\n");
+	if (cmd) {
+		printk("CDB:");
+		for (cdb_byte = 0; cdb_byte < cmd->cmd_len; cdb_byte++)
+			printk(" 0x%x", cmd->cmnd[cdb_byte]);
+		printk("\n");
+	}
 
 	ahc_lock(ahc, &flags);
 
@@ -2068,7 +2071,7 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 	 * at all, and the system wanted us to just abort the
 	 * command, return success.
 	 */
-	dev = scsi_transport_device_data(cmd->device);
+	dev = scsi_transport_device_data(sdev);
 
 	if (dev == NULL) {
 		/*
@@ -2076,13 +2079,12 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 		 * so we must not still own the command.
 		 */
 		printk("%s:%d:%d:%d: Is not an active device\n",
-		       ahc_name(ahc), cmd->device->channel, cmd->device->id,
-		       (u8)cmd->device->lun);
+		       ahc_name(ahc), sdev->channel, sdev->id, (u8)sdev->lun);
 		retval = SUCCESS;
 		goto no_cmd;
 	}
 
-	if ((dev->flags & (AHC_DEV_Q_BASIC|AHC_DEV_Q_TAGGED)) == 0
+	if (cmd && (dev->flags & (AHC_DEV_Q_BASIC|AHC_DEV_Q_TAGGED)) == 0
 	 && ahc_search_untagged_queues(ahc, cmd, cmd->device->id,
 				       cmd->device->channel + 'A',
 				       (u8)cmd->device->lun,
@@ -2097,25 +2099,28 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 	/*
 	 * See if we can find a matching cmd in the pending list.
 	 */
-	LIST_FOREACH(pending_scb, &ahc->pending_scbs, pending_links) {
-		if (pending_scb->io_ctx == cmd)
+	LIST_FOREACH(scb, &ahc->pending_scbs, pending_links) {
+		if (cmd && scb->io_ctx == cmd) {
+			pending_scb = scb;
 			break;
+		}
 	}
 
-	if (pending_scb == NULL && flag == SCB_DEVICE_RESET) {
-
+	if (!cmd) {
 		/* Any SCB for this device will do for a target reset */
-		LIST_FOREACH(pending_scb, &ahc->pending_scbs, pending_links) {
-			if (ahc_match_scb(ahc, pending_scb, scmd_id(cmd),
-					  scmd_channel(cmd) + 'A',
+		LIST_FOREACH(scb, &ahc->pending_scbs, pending_links) {
+			if (ahc_match_scb(ahc, scb, sdev->id,
+					  sdev->channel + 'A',
 					  CAM_LUN_WILDCARD,
-					  SCB_LIST_NULL, ROLE_INITIATOR))
+					  SCB_LIST_NULL, ROLE_INITIATOR)) {
+				pending_scb = scb;
 				break;
+			}
 		}
 	}
 
 	if (pending_scb == NULL) {
-		scmd_printk(KERN_INFO, cmd, "Command not found\n");
+		sdev_printk(KERN_INFO, sdev, "Command not found\n");
 		goto no_cmd;
 	}
 
@@ -2146,22 +2151,22 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 	ahc_dump_card_state(ahc);
 
 	disconnected = TRUE;
-	if (flag == SCB_ABORT) {
-		if (ahc_search_qinfifo(ahc, cmd->device->id,
-				       cmd->device->channel + 'A',
-				       cmd->device->lun,
+	if (cmd) {
+		if (ahc_search_qinfifo(ahc, sdev->id,
+				       sdev->channel + 'A',
+				       sdev->lun,
 				       pending_scb->hscb->tag,
 				       ROLE_INITIATOR, CAM_REQ_ABORTED,
 				       SEARCH_COMPLETE) > 0) {
 			printk("%s:%d:%d:%d: Cmd aborted from QINFIFO\n",
-			       ahc_name(ahc), cmd->device->channel,
-			       cmd->device->id, (u8)cmd->device->lun);
+			       ahc_name(ahc), sdev->channel,
+			       sdev->id, (u8)sdev->lun);
 			retval = SUCCESS;
 			goto done;
 		}
-	} else if (ahc_search_qinfifo(ahc, cmd->device->id,
-				      cmd->device->channel + 'A',
-				      cmd->device->lun,
+	} else if (ahc_search_qinfifo(ahc, sdev->id,
+				      sdev->channel + 'A',
+				      sdev->lun,
 				      pending_scb->hscb->tag,
 				      ROLE_INITIATOR, /*status*/0,
 				      SEARCH_COUNT) > 0) {
@@ -2174,7 +2179,7 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 		bus_scb = ahc_lookup_scb(ahc, ahc_inb(ahc, SCB_TAG));
 		if (bus_scb == pending_scb)
 			disconnected = FALSE;
-		else if (flag != SCB_ABORT
+		else if (!cmd
 		      && ahc_inb(ahc, SAVED_SCSIID) == pending_scb->hscb->scsiid
 		      && ahc_inb(ahc, SAVED_LUN) == SCB_GET_LUN(pending_scb))
 			disconnected = FALSE;
@@ -2194,18 +2199,18 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 	saved_scsiid = ahc_inb(ahc, SAVED_SCSIID);
 	if (last_phase != P_BUSFREE
 	 && (pending_scb->hscb->tag == active_scb_index
-	  || (flag == SCB_DEVICE_RESET
-	   && SCSIID_TARGET(ahc, saved_scsiid) == scmd_id(cmd)))) {
+	  || (!cmd && SCSIID_TARGET(ahc, saved_scsiid) == sdev->id))) {
 
 		/*
 		 * We're active on the bus, so assert ATN
 		 * and hope that the target responds.
 		 */
 		pending_scb = ahc_lookup_scb(ahc, active_scb_index);
-		pending_scb->flags |= SCB_RECOVERY_SCB|flag;
+		pending_scb->flags |= SCB_RECOVERY_SCB;
+		pending_scb->flags |= cmd ? SCB_ABORT : SCB_DEVICE_RESET;
 		ahc_outb(ahc, MSG_OUT, HOST_MSG);
 		ahc_outb(ahc, SCSISIGO, last_phase|ATNO);
-		scmd_printk(KERN_INFO, cmd, "Device is active, asserting ATN\n");
+		sdev_printk(KERN_INFO, sdev, "Device is active, asserting ATN\n");
 		wait = TRUE;
 	} else if (disconnected) {
 
@@ -2226,7 +2231,8 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 		 * an unsolicited reselection occurred.
 		 */
 		pending_scb->hscb->control |= MK_MESSAGE|DISCONNECTED;
-		pending_scb->flags |= SCB_RECOVERY_SCB|flag;
+		pending_scb->flags |= SCB_RECOVERY_SCB;
+		pending_scb->flags |= cmd ? SCB_ABORT : SCB_DEVICE_RESET;
 
 		/*
 		 * Remove any cached copy of this SCB in the
@@ -2235,9 +2241,9 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 		 * same element in the SCB, SCB_NEXT, for
 		 * both the qinfifo and the disconnected list.
 		 */
-		ahc_search_disc_list(ahc, cmd->device->id,
-				     cmd->device->channel + 'A',
-				     cmd->device->lun, pending_scb->hscb->tag,
+		ahc_search_disc_list(ahc, sdev->id,
+				     sdev->channel + 'A',
+				     sdev->lun, pending_scb->hscb->tag,
 				     /*stop_on_first*/TRUE,
 				     /*remove*/TRUE,
 				     /*save_state*/FALSE);
@@ -2260,9 +2266,9 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 		 * so we are the next SCB for this target
 		 * to run.
 		 */
-		ahc_search_qinfifo(ahc, cmd->device->id,
-				   cmd->device->channel + 'A',
-				   cmd->device->lun, SCB_LIST_NULL,
+		ahc_search_qinfifo(ahc, sdev->id,
+				   sdev->channel + 'A',
+				   (u8)sdev->lun, SCB_LIST_NULL,
 				   ROLE_INITIATOR, CAM_REQUEUE_REQ,
 				   SEARCH_COMPLETE);
 		ahc_qinfifo_requeue_tail(ahc, pending_scb);
@@ -2271,7 +2277,7 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 		printk("Device is disconnected, re-queuing SCB\n");
 		wait = TRUE;
 	} else {
-		scmd_printk(KERN_INFO, cmd, "Unable to deliver message\n");
+		sdev_printk(KERN_INFO, sdev, "Unable to deliver message\n");
 		retval = FAILED;
 		goto done;
 	}
-- 
2.29.2

