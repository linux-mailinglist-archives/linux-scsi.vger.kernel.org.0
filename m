Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B3E16A39
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfEGScp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 14:32:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43461 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfEGScp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 14:32:45 -0400
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa3.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa3.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.60,443,1549954800"; 
   d="scan'208";a="32364595"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2019 11:32:36 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:35 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:34 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 May 2019 11:32:33 -0700
Subject: [PATCH 6/7] hpsa: correct device resets
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 7 May 2019 13:32:33 -0500
Message-ID: <155725395361.27200.12954572103764004153.stgit@brunhilda>
In-Reply-To: <155725372104.27200.12250663760304977059.stgit@brunhilda>
References: <155725372104.27200.12250663760304977059.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- Correct a race condition that occurs between the
  reset handler and the completion handler. There
  are times when the wait_event condition is never
  met due to this race condition and the reset never
  completes.

  The reset_pending field is NULL initially.

  t  Reset Handler Thread     Completion Thread
  -- --------------------     -----------------
  t1                          if (c->reset_pending)
  t2 c->reset_pending = dev;     if (atomic_dev_and_test(counter))
  t3 atomic_inc(counter)             wait_up_all(event_sync_wait_queue)
  t4
  t5 wait_event(...counter == 0)

Kernel.org Bugzilla:
           https://bugzilla.kernel.org/show_bug.cgi?id=1994350
           Bug 199435 - HPSA + P420i resetting logical Direct-Access
                        never complete

Reviewed-by: Justin Lindley <justin.lindley@microsemi.com>
Reviewed-by: David Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c     |  173 +++++++++++++++++++++++------------------------
 drivers/scsi/hpsa.h     |    3 +
 drivers/scsi/hpsa_cmd.h |    2 -
 3 files changed, 88 insertions(+), 90 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 0480e3c34217..85982b78ab58 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -346,11 +346,6 @@ static inline bool hpsa_is_cmd_idle(struct CommandList *c)
 	return c->scsi_cmd == SCSI_CMD_IDLE;
 }
 
-static inline bool hpsa_is_pending_event(struct CommandList *c)
-{
-	return c->reset_pending;
-}
-
 /* extract sense key, asc, and ascq from sense data.  -1 means invalid. */
 static void decode_sense_data(const u8 *sense_data, int sense_data_len,
 			u8 *sense_key, u8 *asc, u8 *ascq)
@@ -1146,6 +1141,8 @@ static void __enqueue_cmd_and_start_io(struct ctlr_info *h,
 {
 	dial_down_lockup_detection_during_fw_flash(h, c);
 	atomic_inc(&h->commands_outstanding);
+	if (c->device)
+		atomic_inc(&c->device->commands_outstanding);
 
 	reply_queue = h->reply_map[raw_smp_processor_id()];
 	switch (c->cmd_type) {
@@ -1169,9 +1166,6 @@ static void __enqueue_cmd_and_start_io(struct ctlr_info *h,
 
 static void enqueue_cmd_and_start_io(struct ctlr_info *h, struct CommandList *c)
 {
-	if (unlikely(hpsa_is_pending_event(c)))
-		return finish_cmd(c);
-
 	__enqueue_cmd_and_start_io(h, c, DEFAULT_REPLY_QUEUE);
 }
 
@@ -2434,13 +2428,16 @@ static int handle_ioaccel_mode2_error(struct ctlr_info *h,
 		break;
 	}
 
+	if (dev->in_reset)
+		retry = 0;
+
 	return retry;	/* retry on raid path? */
 }
 
 static void hpsa_cmd_resolve_events(struct ctlr_info *h,
 		struct CommandList *c)
 {
-	bool do_wake = false;
+	struct hpsa_scsi_dev_t *dev = c->device;
 
 	/*
 	 * Reset c->scsi_cmd here so that the reset handler will know
@@ -2449,25 +2446,12 @@ static void hpsa_cmd_resolve_events(struct ctlr_info *h,
 	 */
 	c->scsi_cmd = SCSI_CMD_IDLE;
 	mb();	/* Declare command idle before checking for pending events. */
-	if (c->reset_pending) {
-		unsigned long flags;
-		struct hpsa_scsi_dev_t *dev;
-
-		/*
-		 * There appears to be a reset pending; lock the lock and
-		 * reconfirm.  If so, then decrement the count of outstanding
-		 * commands and wake the reset command if this is the last one.
-		 */
-		spin_lock_irqsave(&h->lock, flags);
-		dev = c->reset_pending;		/* Re-fetch under the lock. */
-		if (dev && atomic_dec_and_test(&dev->reset_cmds_out))
-			do_wake = true;
-		c->reset_pending = NULL;
-		spin_unlock_irqrestore(&h->lock, flags);
+	if (dev) {
+		atomic_dec(&dev->commands_outstanding);
+		if (dev->in_reset &&
+			atomic_read(&dev->commands_outstanding) <= 0)
+			wake_up_all(&h->event_sync_wait_queue);
 	}
-
-	if (do_wake)
-		wake_up_all(&h->event_sync_wait_queue);
 }
 
 static void hpsa_cmd_resolve_and_free(struct ctlr_info *h,
@@ -2516,6 +2500,11 @@ static void process_ioaccel2_completion(struct ctlr_info *h,
 			dev->offload_to_be_enabled = 0;
 		}
 
+		if (dev->in_reset) {
+			cmd->result = DID_RESET << 16;
+			return hpsa_cmd_free_and_done(h, c, cmd);
+		}
+
 		return hpsa_retry_cmd(h, c);
 	}
 
@@ -2621,10 +2610,6 @@ static void complete_scsi_command(struct CommandList *cp)
 		return hpsa_cmd_free_and_done(h, cp, cmd);
 	}
 
-	if ((unlikely(hpsa_is_pending_event(cp))))
-		if (cp->reset_pending)
-			return hpsa_cmd_free_and_done(h, cp, cmd);
-
 	if (cp->cmd_type == CMD_IOACCEL2)
 		return process_ioaccel2_completion(h, cp, cmd, dev);
 
@@ -3063,7 +3048,7 @@ static int hpsa_scsi_do_inquiry(struct ctlr_info *h, unsigned char *scsi3addr,
 	return rc;
 }
 
-static int hpsa_send_reset(struct ctlr_info *h, unsigned char *scsi3addr,
+static int hpsa_send_reset(struct ctlr_info *h, struct hpsa_scsi_dev_t *dev,
 	u8 reset_type, int reply_queue)
 {
 	int rc = IO_OK;
@@ -3071,11 +3056,10 @@ static int hpsa_send_reset(struct ctlr_info *h, unsigned char *scsi3addr,
 	struct ErrorInfo *ei;
 
 	c = cmd_alloc(h);
-
+	c->device = dev;
 
 	/* fill_cmd can't fail here, no data buffer to map. */
-	(void) fill_cmd(c, reset_type, h, NULL, 0, 0,
-			scsi3addr, TYPE_MSG);
+	(void) fill_cmd(c, reset_type, h, NULL, 0, 0, dev->scsi3addr, TYPE_MSG);
 	rc = hpsa_scsi_do_simple_cmd(h, c, reply_queue, NO_TIMEOUT);
 	if (rc) {
 		dev_warn(&h->pdev->dev, "Failed to send reset command\n");
@@ -3153,9 +3137,8 @@ static bool hpsa_cmd_dev_match(struct ctlr_info *h, struct CommandList *c,
 }
 
 static int hpsa_do_reset(struct ctlr_info *h, struct hpsa_scsi_dev_t *dev,
-	unsigned char *scsi3addr, u8 reset_type, int reply_queue)
+	u8 reset_type, int reply_queue)
 {
-	int i;
 	int rc = 0;
 
 	/* We can really only handle one reset at a time */
@@ -3164,38 +3147,14 @@ static int hpsa_do_reset(struct ctlr_info *h, struct hpsa_scsi_dev_t *dev,
 		return -EINTR;
 	}
 
-	BUG_ON(atomic_read(&dev->reset_cmds_out) != 0);
-
-	for (i = 0; i < h->nr_cmds; i++) {
-		struct CommandList *c = h->cmd_pool + i;
-		int refcount = atomic_inc_return(&c->refcount);
-
-		if (refcount > 1 && hpsa_cmd_dev_match(h, c, dev, scsi3addr)) {
-			unsigned long flags;
-
-			/*
-			 * Mark the target command as having a reset pending,
-			 * then lock a lock so that the command cannot complete
-			 * while we're considering it.  If the command is not
-			 * idle then count it; otherwise revoke the event.
-			 */
-			c->reset_pending = dev;
-			spin_lock_irqsave(&h->lock, flags);	/* Implied MB */
-			if (!hpsa_is_cmd_idle(c))
-				atomic_inc(&dev->reset_cmds_out);
-			else
-				c->reset_pending = NULL;
-			spin_unlock_irqrestore(&h->lock, flags);
-		}
-
-		cmd_free(h, c);
-	}
-
-	rc = hpsa_send_reset(h, scsi3addr, reset_type, reply_queue);
-	if (!rc)
+	rc = hpsa_send_reset(h, dev, reset_type, reply_queue);
+	if (!rc) {
+		/* incremented by sending the reset request */
+		atomic_dec(&dev->commands_outstanding);
 		wait_event(h->event_sync_wait_queue,
-			atomic_read(&dev->reset_cmds_out) == 0 ||
+			atomic_read(&dev->commands_outstanding) <= 0 ||
 			lockup_detected(h));
+	}
 
 	if (unlikely(lockup_detected(h))) {
 		dev_warn(&h->pdev->dev,
@@ -3203,10 +3162,8 @@ static int hpsa_do_reset(struct ctlr_info *h, struct hpsa_scsi_dev_t *dev,
 		rc = -ENODEV;
 	}
 
-	if (unlikely(rc))
-		atomic_set(&dev->reset_cmds_out, 0);
-	else
-		rc = wait_for_device_to_become_ready(h, scsi3addr, 0);
+	if (!rc)
+		rc = wait_for_device_to_become_ready(h, dev->scsi3addr, 0);
 
 	mutex_unlock(&h->reset_mutex);
 	return rc;
@@ -4831,6 +4788,9 @@ static int hpsa_scsi_ioaccel_direct_map(struct ctlr_info *h,
 
 	c->phys_disk = dev;
 
+	if (dev->in_reset)
+		return -1;
+
 	return hpsa_scsi_ioaccel_queue_command(h, c, dev->ioaccel_handle,
 		cmd->cmnd, cmd->cmd_len, dev->scsi3addr, dev);
 }
@@ -5016,6 +4976,11 @@ static int hpsa_scsi_ioaccel2_queue_command(struct ctlr_info *h,
 	} else
 		cp->sg_count = (u8) use_sg;
 
+	if (phys_disk->in_reset) {
+		cmd->result = DID_RESET << 16;
+		return -1;
+	}
+
 	enqueue_cmd_and_start_io(h, c);
 	return 0;
 }
@@ -5033,6 +4998,9 @@ static int hpsa_scsi_ioaccel_queue_command(struct ctlr_info *h,
 	if (!c->scsi_cmd->device->hostdata)
 		return -1;
 
+	if (phys_disk->in_reset)
+		return -1;
+
 	/* Try to honor the device's queue depth */
 	if (atomic_inc_return(&phys_disk->ioaccel_cmds_out) >
 					phys_disk->queue_depth) {
@@ -5116,6 +5084,9 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
 	if (!dev)
 		return -1;
 
+	if (dev->in_reset)
+		return -1;
+
 	/* check for valid opcode, get LBA and block count */
 	switch (cmd->cmnd[0]) {
 	case WRITE_6:
@@ -5420,13 +5391,13 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
  */
 static int hpsa_ciss_submit(struct ctlr_info *h,
 	struct CommandList *c, struct scsi_cmnd *cmd,
-	unsigned char scsi3addr[])
+	struct hpsa_scsi_dev_t *dev)
 {
 	cmd->host_scribble = (unsigned char *) c;
 	c->cmd_type = CMD_SCSI;
 	c->scsi_cmd = cmd;
 	c->Header.ReplyQueue = 0;  /* unused in simple mode */
-	memcpy(&c->Header.LUN.LunAddrBytes[0], &scsi3addr[0], 8);
+	memcpy(&c->Header.LUN.LunAddrBytes[0], &dev->scsi3addr[0], 8);
 	c->Header.tag = cpu_to_le64((c->cmdindex << DIRECT_LOOKUP_SHIFT));
 
 	/* Fill in the request block... */
@@ -5477,6 +5448,12 @@ static int hpsa_ciss_submit(struct ctlr_info *h,
 		hpsa_cmd_resolve_and_free(h, c);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
+
+	if (dev->in_reset) {
+		hpsa_cmd_resolve_and_free(h, c);
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+
 	enqueue_cmd_and_start_io(h, c);
 	/* the cmd'll come back via intr handler in complete_scsi_command()  */
 	return 0;
@@ -5528,8 +5505,7 @@ static inline void hpsa_cmd_partial_init(struct ctlr_info *h, int index,
 }
 
 static int hpsa_ioaccel_submit(struct ctlr_info *h,
-		struct CommandList *c, struct scsi_cmnd *cmd,
-		unsigned char *scsi3addr)
+		struct CommandList *c, struct scsi_cmnd *cmd)
 {
 	struct hpsa_scsi_dev_t *dev = cmd->device->hostdata;
 	int rc = IO_ACCEL_INELIGIBLE;
@@ -5537,6 +5513,9 @@ static int hpsa_ioaccel_submit(struct ctlr_info *h,
 	if (!dev)
 		return SCSI_MLQUEUE_HOST_BUSY;
 
+	if (dev->in_reset)
+		return SCSI_MLQUEUE_HOST_BUSY;
+
 	if (hpsa_simple_mode)
 		return IO_ACCEL_INELIGIBLE;
 
@@ -5572,8 +5551,12 @@ static void hpsa_command_resubmit_worker(struct work_struct *work)
 		cmd->result = DID_NO_CONNECT << 16;
 		return hpsa_cmd_free_and_done(c->h, c, cmd);
 	}
-	if (c->reset_pending)
+
+	if (dev->in_reset) {
+		cmd->result = DID_RESET << 16;
 		return hpsa_cmd_free_and_done(c->h, c, cmd);
+	}
+
 	if (c->cmd_type == CMD_IOACCEL2) {
 		struct ctlr_info *h = c->h;
 		struct io_accel2_cmd *c2 = &h->ioaccel2_cmd_pool[c->cmdindex];
@@ -5581,7 +5564,7 @@ static void hpsa_command_resubmit_worker(struct work_struct *work)
 
 		if (c2->error_data.serv_response ==
 				IOACCEL2_STATUS_SR_TASK_COMP_SET_FULL) {
-			rc = hpsa_ioaccel_submit(h, c, cmd, dev->scsi3addr);
+			rc = hpsa_ioaccel_submit(h, c, cmd);
 			if (rc == 0)
 				return;
 			if (rc == SCSI_MLQUEUE_HOST_BUSY) {
@@ -5597,7 +5580,7 @@ static void hpsa_command_resubmit_worker(struct work_struct *work)
 		}
 	}
 	hpsa_cmd_partial_init(c->h, c->cmdindex, c);
-	if (hpsa_ciss_submit(c->h, c, cmd, dev->scsi3addr)) {
+	if (hpsa_ciss_submit(c->h, c, cmd, dev)) {
 		/*
 		 * If we get here, it means dma mapping failed. Try
 		 * again via scsi mid layer, which will then get
@@ -5616,7 +5599,6 @@ static int hpsa_scsi_queue_command(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 {
 	struct ctlr_info *h;
 	struct hpsa_scsi_dev_t *dev;
-	unsigned char scsi3addr[8];
 	struct CommandList *c;
 	int rc = 0;
 
@@ -5638,13 +5620,15 @@ static int hpsa_scsi_queue_command(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 		return 0;
 	}
 
-	memcpy(scsi3addr, dev->scsi3addr, sizeof(scsi3addr));
-
 	if (unlikely(lockup_detected(h))) {
 		cmd->result = DID_NO_CONNECT << 16;
 		cmd->scsi_done(cmd);
 		return 0;
 	}
+
+	if (dev->in_reset)
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+
 	c = cmd_tagged_alloc(h, cmd);
 	if (c == NULL)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
@@ -5656,7 +5640,7 @@ static int hpsa_scsi_queue_command(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 	if (likely(cmd->retries == 0 &&
 			!blk_rq_is_passthrough(cmd->request) &&
 			h->acciopath_status)) {
-		rc = hpsa_ioaccel_submit(h, c, cmd, scsi3addr);
+		rc = hpsa_ioaccel_submit(h, c, cmd);
 		if (rc == 0)
 			return 0;
 		if (rc == SCSI_MLQUEUE_HOST_BUSY) {
@@ -5664,7 +5648,7 @@ static int hpsa_scsi_queue_command(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 			return SCSI_MLQUEUE_HOST_BUSY;
 		}
 	}
-	return hpsa_ciss_submit(h, c, cmd, scsi3addr);
+	return hpsa_ciss_submit(h, c, cmd, dev);
 }
 
 static void hpsa_scan_complete(struct ctlr_info *h)
@@ -5946,6 +5930,7 @@ static int wait_for_device_to_become_ready(struct ctlr_info *h,
 static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 {
 	int rc = SUCCESS;
+	int i;
 	struct ctlr_info *h;
 	struct hpsa_scsi_dev_t *dev;
 	u8 reset_type;
@@ -6013,9 +5998,19 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 		reset_type == HPSA_DEVICE_RESET_MSG ? "logical " : "physical ");
 	hpsa_show_dev_msg(KERN_WARNING, h, dev, msg);
 
+	/*
+	 * wait to see if any commands will complete before sending reset
+	 */
+	dev->in_reset = true; /* block any new cmds from OS for this device */
+	for (i = 0; i < 10; i++) {
+		if (atomic_read(&dev->commands_outstanding) > 0)
+			msleep(1000);
+		else
+			break;
+	}
+
 	/* send a reset to the SCSI LUN which the command was sent to */
-	rc = hpsa_do_reset(h, dev, dev->scsi3addr, reset_type,
-			   DEFAULT_REPLY_QUEUE);
+	rc = hpsa_do_reset(h, dev, reset_type, DEFAULT_REPLY_QUEUE);
 	if (rc == 0)
 		rc = SUCCESS;
 	else
@@ -6029,6 +6024,8 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 return_reset_status:
 	spin_lock_irqsave(&h->reset_lock, flags);
 	h->reset_in_progress = 0;
+	if (dev)
+		dev->in_reset = false;
 	spin_unlock_irqrestore(&h->reset_lock, flags);
 	return rc;
 }
@@ -6142,6 +6139,7 @@ static struct CommandList *cmd_alloc(struct ctlr_info *h)
 		break; /* it's ours now. */
 	}
 	hpsa_cmd_partial_init(h, i, c);
+	c->device = NULL;
 	return c;
 }
 
@@ -6595,8 +6593,7 @@ static int hpsa_ioctl(struct scsi_device *dev, unsigned int cmd,
 	}
 }
 
-static void hpsa_send_host_reset(struct ctlr_info *h, unsigned char *scsi3addr,
-				u8 reset_type)
+static void hpsa_send_host_reset(struct ctlr_info *h, u8 reset_type)
 {
 	struct CommandList *c;
 
@@ -8090,7 +8087,7 @@ static int hpsa_request_irqs(struct ctlr_info *h,
 static int hpsa_kdump_soft_reset(struct ctlr_info *h)
 {
 	int rc;
-	hpsa_send_host_reset(h, RAID_CTLR_LUNID, HPSA_RESET_TYPE_CONTROLLER);
+	hpsa_send_host_reset(h, HPSA_RESET_TYPE_CONTROLLER);
 
 	dev_info(&h->pdev->dev, "Waiting for board to soft reset.\n");
 	rc = hpsa_wait_for_board_state(h->pdev, h->vaddr, BOARD_NOT_READY);
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index a013c16af5f1..f8c88fc7b80a 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -76,11 +76,12 @@ struct hpsa_scsi_dev_t {
 	unsigned char raid_level;	/* from inquiry page 0xC1 */
 	unsigned char volume_offline;	/* discovered via TUR or VPD */
 	u16 queue_depth;		/* max queue_depth for this device */
-	atomic_t reset_cmds_out;	/* Count of commands to-be affected */
+	atomic_t commands_outstanding;	/* track commands sent to device */
 	atomic_t ioaccel_cmds_out;	/* Only used for physical devices
 					 * counts commands sent to physical
 					 * device via "ioaccel" path.
 					 */
+	bool in_reset;
 	u32 ioaccel_handle;
 	u8 active_path_index;
 	u8 path_map;
diff --git a/drivers/scsi/hpsa_cmd.h b/drivers/scsi/hpsa_cmd.h
index 21a726e2eec6..2daf08f81d80 100644
--- a/drivers/scsi/hpsa_cmd.h
+++ b/drivers/scsi/hpsa_cmd.h
@@ -448,7 +448,7 @@ struct CommandList {
 	struct hpsa_scsi_dev_t *phys_disk;
 
 	int abort_pending;
-	struct hpsa_scsi_dev_t *reset_pending;
+	struct hpsa_scsi_dev_t *device;
 	atomic_t refcount; /* Must be last to avoid memset in hpsa_cmd_init() */
 } __aligned(COMMANDLIST_ALIGNMENT);
 

