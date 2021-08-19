Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C853F154A
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Aug 2021 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhHSIkv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Aug 2021 04:40:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54240 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhHSIkt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Aug 2021 04:40:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D3B0F220B4;
        Thu, 19 Aug 2021 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629362412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a46D2C6DrBQIcn8GCbVooAoBCLhHl5psufRdjV/kNWg=;
        b=R5xvCGHcz07T08hqW6QT77eJe89Oh0SXkNiQgK3HRVs7dp2CF+o4LJponOgxJLUjWWN389
        Sz5D2aWLB3vE7c3DgRICBGL7+jDUmOzvtaClYLLZM/hwFleG9yNcDPDoe6b0vOAVCKBrqT
        VelBkALUeXfFIH4TqD9uSsotzijjm6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629362412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a46D2C6DrBQIcn8GCbVooAoBCLhHl5psufRdjV/kNWg=;
        b=1NPIbMwYbEzF6m6jYchigzKp+At2BjVnWLzGNEByK3VPMDQ9ZWLKLHS3f+ITlKt4clNyxt
        Rpj4Ut+Vx27zi5Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 31330A3BA0;
        Thu, 19 Aug 2021 08:40:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 73977518D263; Thu, 19 Aug 2021 10:40:12 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/4] acornscsi: remove tagged queuing vestiges
Date:   Thu, 19 Aug 2021 10:40:06 +0200
Message-Id: <20210819084007.79233-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210819084007.79233-1-hare@suse.de>
References: <20210819084007.79233-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The acornscsi driver has a config option to enable tagged queuing,
but this option gets disabled in the driver itself with the comment
'needs to be debugged'.
As this is a _really_ old driver I doubt anyone will be wanting to
invest time here, so remove the tagged queue vestiges and make
our live easier.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/arm/Kconfig     |  11 ----
 drivers/scsi/arm/acornscsi.c | 103 ++++++++---------------------------
 drivers/scsi/arm/queue.c     |   2 +-
 3 files changed, 23 insertions(+), 93 deletions(-)

diff --git a/drivers/scsi/arm/Kconfig b/drivers/scsi/arm/Kconfig
index f34badc75196..9f64133f976a 100644
--- a/drivers/scsi/arm/Kconfig
+++ b/drivers/scsi/arm/Kconfig
@@ -10,17 +10,6 @@ config SCSI_ACORNSCSI_3
 	  This enables support for the Acorn SCSI card (aka30). If you have an
 	  Acorn system with one of these, say Y. If unsure, say N.
 
-config SCSI_ACORNSCSI_TAGGED_QUEUE
-	bool "Support SCSI 2 Tagged queueing"
-	depends on SCSI_ACORNSCSI_3
-	help
-	  Say Y here to enable tagged queuing support on the Acorn SCSI card.
-
-	  This is a feature of SCSI-2 which improves performance: the host
-	  adapter can send several SCSI commands to a device's queue even if
-	  previous commands haven't finished yet. Some SCSI devices don't
-	  implement this properly, so the safe answer is N.
-
 config SCSI_ACORNSCSI_SYNC
 	bool "Support SCSI 2 Synchronous Transfers"
 	depends on SCSI_ACORNSCSI_3
diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 84fc7a0c6ff4..4521d4f2773f 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -52,12 +52,8 @@
  * You can tell if you have a device that supports tagged queueing my
  * cating (eg) /proc/scsi/acornscsi/0 and see if the SCSI revision is reported
  * as '2 TAG'.
- *
- * Also note that CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE is normally set in the config
- * scripts, but disabled here.  Once debugged, remove the #undef, otherwise to debug,
- * comment out the undef.
  */
-#undef CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
+
 /*
  * SCSI-II Synchronous transfer support.
  *
@@ -171,7 +167,7 @@ static void acornscsi_done(AS_Host *host, struct scsi_cmnd **SCpntp,
 			   unsigned int result);
 static int acornscsi_reconnect_finish(AS_Host *host);
 static void acornscsi_dma_cleanup(AS_Host *host);
-static void acornscsi_abortcmd(AS_Host *host, unsigned char tag);
+static void acornscsi_abortcmd(AS_Host *host);
 
 /* ====================================================================================
  * Miscellaneous
@@ -741,17 +737,6 @@ intr_ret_t acornscsi_kick(AS_Host *host)
 #endif
 
     if (from_queue) {
-#ifdef CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
-	/*
-	 * tagged queueing - allocate a new tag to this command
-	 */
-	if (SCpnt->device->simple_tags) {
-	    SCpnt->device->current_tag += 1;
-	    if (SCpnt->device->current_tag == 0)
-		SCpnt->device->current_tag = 1;
-	    SCpnt->tag = SCpnt->device->current_tag;
-	} else
-#endif
 	    set_bit(SCpnt->device->id * 8 +
 		    (u8)(SCpnt->device->lun & 0x07), host->busyluns);
 
@@ -1192,7 +1177,7 @@ void acornscsi_dma_intr(AS_Host *host)
 	 * the device recognises the attention.
 	 */
 	if (dmac_read(host, DMAC_STATUS) & STATUS_RQ0) {
-	    acornscsi_abortcmd(host, host->SCpnt->tag);
+	    acornscsi_abortcmd(host);
 
 	    dmac_write(host, DMAC_TXCNTLO, 0);
 	    dmac_write(host, DMAC_TXCNTHI, 0);
@@ -1560,23 +1545,6 @@ void acornscsi_message(AS_Host *host)
 	    acornscsi_sbic_issuecmd(host, CMND_ASSERTATN);
 
 	switch (host->scsi.last_message) {
-#ifdef CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
-	case HEAD_OF_QUEUE_TAG:
-	case ORDERED_QUEUE_TAG:
-	case SIMPLE_QUEUE_TAG:
-	    /*
-	     * ANSI standard says: (Section SCSI-2 Rev. 10c Sect 5.6.17)
-	     *  If a target does not implement tagged queuing and a queue tag
-	     *  message is received, it shall respond with a MESSAGE REJECT
-	     *  message and accept the I/O process as if it were untagged.
-	     */
-	    printk(KERN_NOTICE "scsi%d.%c: disabling tagged queueing\n",
-		    host->host->host_no, acornscsi_target(host));
-	    host->SCpnt->device->simple_tags = 0;
-	    set_bit(host->SCpnt->device->id * 8 +
-		    (u8)(host->SCpnt->device->lun & 0x7), host->busyluns);
-	    break;
-#endif
 	case EXTENDED_MESSAGE | (EXTENDED_SDTR << 8):
 	    /*
 	     * Target can't handle synchronous transfers
@@ -1687,24 +1655,11 @@ void acornscsi_buildmessages(AS_Host *host)
 #if 0
     /* does the device need the current command aborted */
     if (cmd_aborted) {
-	acornscsi_abortcmd(host->SCpnt->tag);
+	acornscsi_abortcmd(host);
 	return;
     }
 #endif
 
-#ifdef CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
-    if (host->SCpnt->tag) {
-	unsigned int tag_type;
-
-	if (host->SCpnt->cmnd[0] == REQUEST_SENSE ||
-	    host->SCpnt->cmnd[0] == TEST_UNIT_READY ||
-	    host->SCpnt->cmnd[0] == INQUIRY)
-	    tag_type = HEAD_OF_QUEUE_TAG;
-	else
-	    tag_type = SIMPLE_QUEUE_TAG;
-	msgqueue_addmsg(&host->scsi.msgs, 2, tag_type, host->SCpnt->tag);
-    }
-#endif
 
 #ifdef CONFIG_SCSI_ACORNSCSI_SYNC
     if (host->device[host->SCpnt->device->id].sync_state == SYNC_NEGOCIATE) {
@@ -1798,7 +1753,7 @@ int acornscsi_reconnect(AS_Host *host)
 		"to reconnect with\n",
 		host->host->host_no, '0' + target);
 	acornscsi_dumplog(host, target);
-	acornscsi_abortcmd(host, 0);
+	acornscsi_abortcmd(host);
 	if (host->SCpnt) {
 	    queue_add_cmd_tail(&host->queues.disconnected, host->SCpnt);
 	    host->SCpnt = NULL;
@@ -1821,7 +1776,7 @@ int acornscsi_reconnect_finish(AS_Host *host)
 	host->scsi.disconnectable = 0;
 	if (host->SCpnt->device->id  == host->scsi.reconnected.target &&
 	    host->SCpnt->device->lun == host->scsi.reconnected.lun &&
-	    host->SCpnt->tag         == host->scsi.reconnected.tag) {
+	    scsi_cmd_to_tag(host->SCpnt) == host->scsi.reconnected.tag) {
 #if (DEBUG & (DEBUG_QUEUES|DEBUG_DISCON))
 	    DBG(host->SCpnt, printk("scsi%d.%c: reconnected",
 		    host->host->host_no, acornscsi_target(host)));
@@ -1848,7 +1803,7 @@ int acornscsi_reconnect_finish(AS_Host *host)
     }
 
     if (!host->SCpnt)
-	acornscsi_abortcmd(host, host->scsi.reconnected.tag);
+	acornscsi_abortcmd(host);
     else {
 	/*
 	 * Restore data pointer from SAVED pointers.
@@ -1889,21 +1844,15 @@ void acornscsi_disconnect_unexpected(AS_Host *host)
  * Function: void acornscsi_abortcmd(AS_host *host, unsigned char tag)
  * Purpose : abort a currently executing command
  * Params  : host - host with connected command to abort
- *	     tag  - tag to abort
  */
 static
-void acornscsi_abortcmd(AS_Host *host, unsigned char tag)
+void acornscsi_abortcmd(AS_Host *host)
 {
     host->scsi.phase = PHASE_ABORTED;
     sbic_arm_write(host, SBIC_CMND, CMND_ASSERTATN);
 
     msgqueue_flush(&host->scsi.msgs);
-#ifdef CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
-    if (tag)
-	msgqueue_addmsg(&host->scsi.msgs, 2, ABORT_TAG, tag);
-    else
-#endif
-	msgqueue_addmsg(&host->scsi.msgs, 1, ABORT);
+    msgqueue_addmsg(&host->scsi.msgs, 1, ABORT);
 }
 
 /* ==========================================================================================
@@ -1993,7 +1942,7 @@ intr_ret_t acornscsi_sbicintr(AS_Host *host, int in_irq)
 	    printk(KERN_ERR "scsi%d.%c: PHASE_CONNECTING, SSR %02X?\n",
 		    host->host->host_no, acornscsi_target(host), ssr);
 	    acornscsi_dumplog(host, host->SCpnt ? host->SCpnt->device->id : 8);
-	    acornscsi_abortcmd(host, host->SCpnt->tag);
+	    acornscsi_abortcmd(host);
 	}
 	return INTR_PROCESSING;
 
@@ -2029,7 +1978,7 @@ intr_ret_t acornscsi_sbicintr(AS_Host *host, int in_irq)
 	    printk(KERN_ERR "scsi%d.%c: PHASE_CONNECTED, SSR %02X?\n",
 		    host->host->host_no, acornscsi_target(host), ssr);
 	    acornscsi_dumplog(host, host->SCpnt ? host->SCpnt->device->id : 8);
-	    acornscsi_abortcmd(host, host->SCpnt->tag);
+	    acornscsi_abortcmd(host);
 	}
 	return INTR_PROCESSING;
 
@@ -2075,20 +2024,20 @@ intr_ret_t acornscsi_sbicintr(AS_Host *host, int in_irq)
 	case 0x18:			/* -> PHASE_DATAOUT				*/
 	    /* COMMAND -> DATA OUT */
 	    if (host->scsi.SCp.sent_command != host->SCpnt->cmd_len)
-		acornscsi_abortcmd(host, host->SCpnt->tag);
+		acornscsi_abortcmd(host);
 	    acornscsi_dma_setup(host, DMA_OUT);
 	    if (!acornscsi_starttransfer(host))
-		acornscsi_abortcmd(host, host->SCpnt->tag);
+		acornscsi_abortcmd(host);
 	    host->scsi.phase = PHASE_DATAOUT;
 	    return INTR_IDLE;
 
 	case 0x19:			/* -> PHASE_DATAIN				*/
 	    /* COMMAND -> DATA IN */
 	    if (host->scsi.SCp.sent_command != host->SCpnt->cmd_len)
-		acornscsi_abortcmd(host, host->SCpnt->tag);
+		acornscsi_abortcmd(host);
 	    acornscsi_dma_setup(host, DMA_IN);
 	    if (!acornscsi_starttransfer(host))
-		acornscsi_abortcmd(host, host->SCpnt->tag);
+		acornscsi_abortcmd(host);
 	    host->scsi.phase = PHASE_DATAIN;
 	    return INTR_IDLE;
 
@@ -2156,7 +2105,7 @@ intr_ret_t acornscsi_sbicintr(AS_Host *host, int in_irq)
 	    /* MESSAGE IN -> DATA OUT */
 	    acornscsi_dma_setup(host, DMA_OUT);
 	    if (!acornscsi_starttransfer(host))
-		acornscsi_abortcmd(host, host->SCpnt->tag);
+		acornscsi_abortcmd(host);
 	    host->scsi.phase = PHASE_DATAOUT;
 	    return INTR_IDLE;
 
@@ -2165,7 +2114,7 @@ intr_ret_t acornscsi_sbicintr(AS_Host *host, int in_irq)
 	    /* MESSAGE IN -> DATA IN */
 	    acornscsi_dma_setup(host, DMA_IN);
 	    if (!acornscsi_starttransfer(host))
-		acornscsi_abortcmd(host, host->SCpnt->tag);
+		acornscsi_abortcmd(host);
 	    host->scsi.phase = PHASE_DATAIN;
 	    return INTR_IDLE;
 
@@ -2206,7 +2155,7 @@ intr_ret_t acornscsi_sbicintr(AS_Host *host, int in_irq)
 	switch (ssr) {
 	case 0x19:			/* -> PHASE_DATAIN				*/
 	case 0x89:			/* -> PHASE_DATAIN				*/
-	    acornscsi_abortcmd(host, host->SCpnt->tag);
+	    acornscsi_abortcmd(host);
 	    return INTR_IDLE;
 
 	case 0x1b:			/* -> PHASE_STATUSIN				*/
@@ -2255,7 +2204,7 @@ intr_ret_t acornscsi_sbicintr(AS_Host *host, int in_irq)
 	switch (ssr) {
 	case 0x18:			/* -> PHASE_DATAOUT				*/
 	case 0x88:			/* -> PHASE_DATAOUT				*/
-	    acornscsi_abortcmd(host, host->SCpnt->tag);
+	    acornscsi_abortcmd(host);
 	    return INTR_IDLE;
 
 	case 0x1b:			/* -> PHASE_STATUSIN				*/
@@ -2482,7 +2431,6 @@ static int acornscsi_queuecmd_lck(struct scsi_cmnd *SCpnt,
     SCpnt->scsi_done = done;
     SCpnt->host_scribble = NULL;
     SCpnt->result = 0;
-    SCpnt->tag = 0;
     SCpnt->SCp.phase = (int)acornscsi_datadirection(SCpnt->cmnd[0]);
     SCpnt->SCp.sent_command = 0;
     SCpnt->SCp.scsi_xferred = 0;
@@ -2581,7 +2529,7 @@ static enum res_abort acornscsi_do_abort(AS_Host *host, struct scsi_cmnd *SCpnt)
 			break;
 
 		default:
-			acornscsi_abortcmd(host, host->SCpnt->tag);
+			acornscsi_abortcmd(host);
 			res = res_snooze;
 		}
 		local_irq_restore(flags);
@@ -2746,9 +2694,6 @@ char *acornscsi_info(struct Scsi_Host *host)
 #ifdef CONFIG_SCSI_ACORNSCSI_SYNC
     " SYNC"
 #endif
-#ifdef CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
-    " TAG"
-#endif
 #if (DEBUG & DEBUG_NO_WRITE)
     " NOWRITE (" __stringify(NO_WRITE) ")"
 #endif
@@ -2769,9 +2714,6 @@ static int acornscsi_show_info(struct seq_file *m, struct Scsi_Host *instance)
 #ifdef CONFIG_SCSI_ACORNSCSI_SYNC
     " SYNC"
 #endif
-#ifdef CONFIG_SCSI_ACORNSCSI_TAGGED_QUEUE
-    " TAG"
-#endif
 #if (DEBUG & DEBUG_NO_WRITE)
     " NOWRITE (" __stringify(NO_WRITE) ")"
 #endif
@@ -2826,9 +2768,8 @@ static int acornscsi_show_info(struct seq_file *m, struct Scsi_Host *instance)
 	seq_printf(m, "Device/Lun TaggedQ      Sync\n");
 	seq_printf(m, "     %d/%llu   ", scd->id, scd->lun);
 	if (scd->tagged_supported)
-		seq_printf(m, "%3sabled(%3d) ",
-			     scd->simple_tags ? "en" : "dis",
-			     scd->current_tag);
+		seq_printf(m, "%3sabled ",
+			     scd->simple_tags ? "en" : "dis");
 	else
 		seq_printf(m, "unsupported  ");
 
diff --git a/drivers/scsi/arm/queue.c b/drivers/scsi/arm/queue.c
index e5559f27669d..0d99db7df5d6 100644
--- a/drivers/scsi/arm/queue.c
+++ b/drivers/scsi/arm/queue.c
@@ -214,7 +214,7 @@ struct scsi_cmnd *queue_remove_tgtluntag(Queue_t *queue, int target, int lun,
 	list_for_each(l, &queue->head) {
 		QE_t *q = list_entry(l, QE_t, list);
 		if (q->SCpnt->device->id == target && q->SCpnt->device->lun == lun &&
-		    q->SCpnt->tag == tag) {
+		    scsi_cmd_to_tag(q->SCpnt) == tag) {
 			SCpnt = __queue_remove(queue, l);
 			break;
 		}
-- 
2.29.2

