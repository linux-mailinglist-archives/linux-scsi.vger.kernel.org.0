Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A091BF920
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgD3NUL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 09:20:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgD3NUG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 09:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1CEC6AF10;
        Thu, 30 Apr 2020 13:20:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH RFC v3 12/41] hpsa: use reserved commands
Date:   Thu, 30 Apr 2020 15:18:35 +0200
Message-Id: <20200430131904.5847-13-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
References: <20200430131904.5847-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Enable the use of reserved commands, and drop the hand-crafted
command allocation.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hpsa.c | 203 +++++++++++++++++++---------------------------------
 drivers/scsi/hpsa.h |   3 +-
 2 files changed, 77 insertions(+), 129 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index fe2fd1c8f4e0..8f23011aade9 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -244,10 +244,6 @@ static struct hpsa_scsi_dev_t
 	*hpsa_find_device_by_sas_rphy(struct ctlr_info *h,
 		struct sas_rphy *rphy);
 
-#define SCSI_CMD_BUSY ((struct scsi_cmnd *)&hpsa_cmd_busy)
-static const struct scsi_cmnd hpsa_cmd_busy;
-#define SCSI_CMD_IDLE ((struct scsi_cmnd *)&hpsa_cmd_idle)
-static const struct scsi_cmnd hpsa_cmd_idle;
 static int number_of_controllers;
 
 static irqreturn_t do_hpsa_intr_intx(int irq, void *dev_id);
@@ -261,7 +257,7 @@ static int hpsa_compat_ioctl(struct scsi_device *dev, unsigned int cmd,
 #endif
 
 static void cmd_free(struct ctlr_info *h, struct CommandList *c);
-static struct CommandList *cmd_alloc(struct ctlr_info *h);
+static struct CommandList *cmd_alloc(struct ctlr_info *h, u8 direction);
 static void cmd_tagged_free(struct ctlr_info *h, struct CommandList *c);
 static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 					    struct scsi_cmnd *scmd);
@@ -342,7 +338,7 @@ static inline struct ctlr_info *shost_to_hba(struct Scsi_Host *sh)
 
 static inline bool hpsa_is_cmd_idle(struct CommandList *c)
 {
-	return c->scsi_cmd == SCSI_CMD_IDLE;
+	return c->scsi_cmd == NULL;
 }
 
 /* extract sense key, asc, and ascq from sense data.  -1 means invalid. */
@@ -2450,7 +2446,12 @@ static void hpsa_cmd_resolve_events(struct ctlr_info *h,
 	 * this command has completed.  Then, check to see if the handler is
 	 * waiting for this command, and, if so, wake it.
 	 */
-	c->scsi_cmd = SCSI_CMD_IDLE;
+	if (c->scsi_cmd && c->cmd_type == CMD_IOCTL_PEND) {
+		struct scsi_cmnd *scmd = c->scsi_cmd;
+
+		scsi_put_reserved_cmd(scmd);
+	}
+	c->scsi_cmd = NULL;
 	mb();	/* Declare command idle before checking for pending events. */
 	if (dev) {
 		atomic_dec(&dev->commands_outstanding);
@@ -2993,7 +2994,7 @@ static int hpsa_do_receive_diagnostic(struct ctlr_info *h, u8 *scsi3addr,
 	struct CommandList *c;
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 	if (fill_cmd(c, RECEIVE_DIAGNOSTIC, h, buf, bufsize,
 			page, scsi3addr, TYPE_CMD)) {
 		rc = -1;
@@ -3045,7 +3046,7 @@ static int hpsa_scsi_do_inquiry(struct ctlr_info *h, unsigned char *scsi3addr,
 	struct CommandList *c;
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 
 	if (fill_cmd(c, HPSA_INQUIRY, h, buf, bufsize,
 			page, scsi3addr, TYPE_CMD)) {
@@ -3073,7 +3074,7 @@ static int hpsa_send_reset(struct ctlr_info *h, struct hpsa_scsi_dev_t *dev,
 	struct CommandList *c;
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_NONE);
 	c->device = dev;
 
 	/* fill_cmd can't fail here, no data buffer to map. */
@@ -3299,7 +3300,7 @@ static int hpsa_get_raid_map(struct ctlr_info *h,
 	struct CommandList *c;
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 
 	if (fill_cmd(c, HPSA_GET_RAID_MAP, h, &this_device->raid_map,
 			sizeof(this_device->raid_map), 0,
@@ -3341,7 +3342,7 @@ static int hpsa_bmic_sense_subsystem_information(struct ctlr_info *h,
 	struct CommandList *c;
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 
 	rc = fill_cmd(c, BMIC_SENSE_SUBSYSTEM_INFORMATION, h, buf, bufsize,
 		0, RAID_CTLR_LUNID, TYPE_CMD);
@@ -3372,7 +3373,7 @@ static int hpsa_bmic_id_controller(struct ctlr_info *h,
 	struct CommandList *c;
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 
 	rc = fill_cmd(c, BMIC_IDENTIFY_CONTROLLER, h, buf, bufsize,
 		0, RAID_CTLR_LUNID, TYPE_CMD);
@@ -3401,7 +3402,7 @@ static int hpsa_bmic_id_physical_device(struct ctlr_info *h,
 	struct CommandList *c;
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 	rc = fill_cmd(c, BMIC_IDENTIFY_PHYSICAL_DEVICE, h, buf, bufsize,
 		0, RAID_CTLR_LUNID, TYPE_CMD);
 	if (rc)
@@ -3473,7 +3474,7 @@ static void hpsa_get_enclosure_info(struct ctlr_info *h,
 		goto out;
 	}
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 
 	rc = fill_cmd(c, BMIC_SENSE_STORAGE_BOX_PARAMS, h, bssbp,
 			sizeof(*bssbp), 0, RAID_CTLR_LUNID, TYPE_CMD);
@@ -3729,7 +3730,7 @@ static int hpsa_scsi_do_report_luns(struct ctlr_info *h, int logical,
 	unsigned char scsi3addr[8];
 	struct ErrorInfo *ei;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 
 	/* address the controller */
 	memset(scsi3addr, 0, sizeof(scsi3addr));
@@ -3872,7 +3873,7 @@ static unsigned char hpsa_volume_offline(struct ctlr_info *h,
 #define ASCQ_LUN_NOT_READY_FORMAT_IN_PROGRESS 0x04
 #define ASCQ_LUN_NOT_READY_INITIALIZING_CMD_REQ 0x02
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_NONE);
 
 	(void) fill_cmd(c, TEST_UNIT_READY, h, NULL, 0, 0, scsi3addr, TYPE_CMD);
 	rc = hpsa_scsi_do_simple_cmd(h, c, DEFAULT_REPLY_QUEUE,
@@ -5523,7 +5524,6 @@ static void hpsa_cmd_init(struct ctlr_info *h, int index,
 	c->ErrDesc.Addr = cpu_to_le64((u64) err_dma_handle);
 	c->ErrDesc.Len = cpu_to_le32((u32) sizeof(*c->err_info));
 	c->h = h;
-	c->scsi_cmd = SCSI_CMD_IDLE;
 }
 
 static void hpsa_preinitialize_commands(struct ctlr_info *h)
@@ -5818,12 +5818,12 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 
 	sh->io_port = 0;
 	sh->n_io_port = 0;
-	sh->this_id = -1;
 	sh->max_channel = 3;
 	sh->max_cmd_len = MAX_COMMAND_SIZE;
 	sh->max_lun = HPSA_MAX_LUN;
 	sh->max_id = HPSA_MAX_LUN;
-	sh->can_queue = h->nr_cmds - HPSA_NRESERVED_CMDS;
+	sh->can_queue = h->nr_cmds;
+	sh->nr_reserved_cmds = HPSA_NRESERVED_CMDS;
 	sh->cmd_per_lun = sh->can_queue;
 	sh->sg_tablesize = h->maxsgentries;
 	sh->transportt = hpsa_sas_transport_template;
@@ -5860,30 +5860,19 @@ static int hpsa_scsi_add_host(struct ctlr_info *h)
 		dev_err(&h->pdev->dev, "scsi_add_host failed\n");
 		return rv;
 	}
-
+	h->raid_ctrl_sdev = scsi_get_virtual_dev(h->scsi_host,
+						 HPSA_LEGACY_HBA_BUS + 1, 0);
+	if (!h->raid_ctrl_sdev) {
+		dev_err(&h->pdev->dev,
+			"allocate raid controller device failed\n");
+		return -ENOMEM;
+	}
 	hpsa_hba_inquiry(h);
 
 	scsi_scan_host(h->scsi_host);
 	return 0;
 }
 
-/*
- * The block layer has already gone to the trouble of picking out a unique,
- * small-integer tag for this request.  We use an offset from that value as
- * an index to select our command block.  (The offset allows us to reserve the
- * low-numbered entries for our own uses.)
- */
-static int hpsa_get_cmd_index(struct scsi_cmnd *scmd)
-{
-	int idx = scmd->request->tag;
-
-	if (idx < 0)
-		return idx;
-
-	/* Offset to leave space for internal cmds. */
-	return idx += HPSA_NRESERVED_CMDS;
-}
-
 /*
  * Send a TEST_UNIT_READY command to the specified LUN using the specified
  * reply queue; returns zero if the unit is ready, and non-zero otherwise.
@@ -5967,7 +5956,7 @@ static int wait_for_device_to_become_ready(struct ctlr_info *h,
 	int rc = 0;
 	struct CommandList *c;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_NONE);
 
 	/*
 	 * If no specific reply queue was requested, then send the TUR
@@ -6040,7 +6029,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	if (lockup_detected(h)) {
 		snprintf(msg, sizeof(msg),
 			 "cmd %d RESET FAILED, lockup detected",
-			 hpsa_get_cmd_index(scsicmd));
+			 scsicmd->request->tag);
 		hpsa_show_dev_msg(KERN_WARNING, h, dev, msg);
 		rc = FAILED;
 		goto return_reset_status;
@@ -6050,7 +6039,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	if (detect_controller_lockup(h)) {
 		snprintf(msg, sizeof(msg),
 			 "cmd %d RESET FAILED, new lockup detected",
-			 hpsa_get_cmd_index(scsicmd));
+			  scsicmd->request->tag);
 		hpsa_show_dev_msg(KERN_WARNING, h, dev, msg);
 		rc = FAILED;
 		goto return_reset_status;
@@ -6112,12 +6101,12 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 					    struct scsi_cmnd *scmd)
 {
-	int idx = hpsa_get_cmd_index(scmd);
+	int idx = scmd->request->tag;
 	struct CommandList *c = h->cmd_pool + idx;
 
-	if (idx < HPSA_NRESERVED_CMDS || idx >= h->nr_cmds) {
+	if (idx < 0 || idx >= h->nr_cmds) {
 		dev_err(&h->pdev->dev, "Bad block tag: %d not in [%d..%d]\n",
-			idx, HPSA_NRESERVED_CMDS, h->nr_cmds - 1);
+			idx, 0, h->nr_cmds - 1);
 		/* The index value comes from the block layer, so if it's out of
 		 * bounds, it's probably not our bug.
 		 */
@@ -6154,80 +6143,50 @@ static void cmd_tagged_free(struct ctlr_info *h, struct CommandList *c)
 	 * else to free it, because it is accessed by index.
 	 */
 	(void)atomic_dec(&c->refcount);
+	c->scsi_cmd = NULL;
 }
 
-/*
- * For operations that cannot sleep, a command block is allocated at init,
- * and managed by cmd_alloc() and cmd_free() using a simple bitmap to track
- * which ones are free or in use.  Lock must be held when calling this.
- * cmd_free() is the complement.
- * This function never gives up and returns NULL.  If it hangs,
- * another thread must call cmd_free() to free some tags.
- */
-
-static struct CommandList *cmd_alloc(struct ctlr_info *h)
+static struct CommandList *cmd_alloc(struct ctlr_info *h, u8 direction)
 {
+	struct scsi_cmnd *scmd;
 	struct CommandList *c;
-	int refcount, i;
-	int offset = 0;
+	int idx;
 
-	/*
-	 * There is some *extremely* small but non-zero chance that that
-	 * multiple threads could get in here, and one thread could
-	 * be scanning through the list of bits looking for a free
-	 * one, but the free ones are always behind him, and other
-	 * threads sneak in behind him and eat them before he can
-	 * get to them, so that while there is always a free one, a
-	 * very unlucky thread might be starved anyway, never able to
-	 * beat the other threads.  In reality, this happens so
-	 * infrequently as to be indistinguishable from never.
-	 *
-	 * Note that we start allocating commands before the SCSI host structure
-	 * is initialized.  Since the search starts at bit zero, this
-	 * all works, since we have at least one command structure available;
-	 * however, it means that the structures with the low indexes have to be
-	 * reserved for driver-initiated requests, while requests from the block
-	 * layer will use the higher indexes.
-	 */
-
-	for (;;) {
-		i = find_next_zero_bit(h->cmd_pool_bits,
-					HPSA_NRESERVED_CMDS,
-					offset);
-		if (unlikely(i >= HPSA_NRESERVED_CMDS)) {
-			offset = 0;
-			continue;
-		}
-		c = h->cmd_pool + i;
-		refcount = atomic_inc_return(&c->refcount);
-		if (unlikely(refcount > 1)) {
-			cmd_free(h, c); /* already in use */
-			offset = (i + 1) % HPSA_NRESERVED_CMDS;
-			continue;
-		}
-		set_bit(i & (BITS_PER_LONG - 1),
-			h->cmd_pool_bits + (i / BITS_PER_LONG));
-		break; /* it's ours now. */
+	scmd = scsi_get_reserved_cmd(h->raid_ctrl_sdev, direction & XFER_WRITE ?
+				     DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (!scmd) {
+		dev_warn(&h->pdev->dev, "failed to allocate reserved cmd\n");
+		return NULL;
 	}
-	hpsa_cmd_partial_init(h, i, c);
+	idx = scmd->request->tag;
+	c = cmd_tagged_alloc(h, scmd);
+	if (!c) {
+		dev_warn(&h->pdev->dev, "failed to allocate reserved cmd %u\n",
+			 idx);
+		scsi_put_reserved_cmd(scmd);
+		return NULL;
+	}
+	hpsa_cmd_partial_init(h, idx, c);
+	c->scsi_cmd = scmd;
 	c->device = NULL;
+	c->cmd_type = CMD_IOCTL_PEND;
+	dev_dbg(&h->pdev->dev, "using reserved cmd %u\n", idx);
 	return c;
 }
 
-/*
- * This is the complementary operation to cmd_alloc().  Note, however, in some
- * corner cases it may also be used to free blocks allocated by
- * cmd_tagged_alloc() in which case the ref-count decrement does the trick and
- * the clear-bit is harmless.
- */
 static void cmd_free(struct ctlr_info *h, struct CommandList *c)
 {
-	if (atomic_dec_and_test(&c->refcount)) {
-		int i;
+	struct scsi_cmnd *scmd = c->scsi_cmd;
 
-		i = c - h->cmd_pool;
-		clear_bit(i & (BITS_PER_LONG - 1),
-			  h->cmd_pool_bits + (i / BITS_PER_LONG));
+	if (!scmd) {
+		dev_warn(&h->pdev->dev, "freeing idle cmd\n");
+		return;
+	}
+	cmd_tagged_free(h, c);
+	if (c->cmd_type == CMD_IOCTL_PEND) {
+		dev_dbg(&h->pdev->dev, "returning reserved cmd %u\n",
+			scmd->request->tag);
+		scsi_put_reserved_cmd(scmd);
 	}
 }
 
@@ -6410,11 +6369,8 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 			memset(buff, 0, iocommand.buf_size);
 		}
 	}
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, iocommand.Request.Type.Direction);
 
-	/* Fill in the command type */
-	c->cmd_type = CMD_IOCTL_PEND;
-	c->scsi_cmd = SCSI_CMD_BUSY;
 	/* Fill in Command Header */
 	c->Header.ReplyQueue = 0; /* unused in simple mode */
 	if (iocommand.buf_size > 0) {	/* buffer to fill */
@@ -6543,10 +6499,8 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 		data_ptr += sz;
 		sg_used++;
 	}
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, ioc->Request.Type.Direction);
 
-	c->cmd_type = CMD_IOCTL_PEND;
-	c->scsi_cmd = SCSI_CMD_BUSY;
 	c->Header.ReplyQueue = 0;
 	c->Header.SGList = (u8) sg_used;
 	c->Header.SGTotal = cpu_to_le16(sg_used);
@@ -6668,7 +6622,7 @@ static void hpsa_send_host_reset(struct ctlr_info *h, u8 reset_type)
 {
 	struct CommandList *c;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_NONE);
 
 	/* fill_cmd can't fail here, no data buffer to map */
 	(void) fill_cmd(c, HPSA_DEVICE_RESET_MSG, h, NULL, 0, 0,
@@ -6689,8 +6643,6 @@ static int fill_cmd(struct CommandList *c, u8 cmd, struct ctlr_info *h,
 {
 	enum dma_data_direction dir = DMA_NONE;
 
-	c->cmd_type = CMD_IOCTL_PEND;
-	c->scsi_cmd = SCSI_CMD_BUSY;
 	c->Header.ReplyQueue = 0;
 	if (buff != NULL && size > 0) {
 		c->Header.SGList = 1;
@@ -8003,8 +7955,6 @@ static int hpsa_init_reset_devices(struct pci_dev *pdev, u32 board_id)
 
 static void hpsa_free_cmd_pool(struct ctlr_info *h)
 {
-	kfree(h->cmd_pool_bits);
-	h->cmd_pool_bits = NULL;
 	if (h->cmd_pool) {
 		dma_free_coherent(&h->pdev->dev,
 				h->nr_cmds * sizeof(struct CommandList),
@@ -8025,17 +7975,13 @@ static void hpsa_free_cmd_pool(struct ctlr_info *h)
 
 static int hpsa_alloc_cmd_pool(struct ctlr_info *h)
 {
-	h->cmd_pool_bits = kcalloc(DIV_ROUND_UP(h->nr_cmds, BITS_PER_LONG),
-				   sizeof(unsigned long),
-				   GFP_KERNEL);
 	h->cmd_pool = dma_alloc_coherent(&h->pdev->dev,
 		    h->nr_cmds * sizeof(*h->cmd_pool),
 		    &h->cmd_pool_dhandle, GFP_KERNEL);
 	h->errinfo_pool = dma_alloc_coherent(&h->pdev->dev,
 		    h->nr_cmds * sizeof(*h->errinfo_pool),
 		    &h->errinfo_pool_dhandle, GFP_KERNEL);
-	if ((h->cmd_pool_bits == NULL)
-	    || (h->cmd_pool == NULL)
+	if ((h->cmd_pool == NULL)
 	    || (h->errinfo_pool == NULL)) {
 		dev_err(&h->pdev->dev, "out of memory in %s", __func__);
 		goto clean_up;
@@ -8918,7 +8864,7 @@ static void hpsa_flush_cache(struct ctlr_info *h)
 	if (!flush_buf)
 		return;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_NONE);
 
 	if (fill_cmd(c, HPSA_CACHE_FLUSH, h, flush_buf, 4, 0,
 		RAID_CTLR_LUNID, TYPE_CMD)) {
@@ -8953,7 +8899,7 @@ static void hpsa_disable_rld_caching(struct ctlr_info *h)
 	if (!options)
 		return;
 
-	c = cmd_alloc(h);
+	c = cmd_alloc(h, XFER_READ);
 
 	/* first, get the current diag options settings */
 	if (fill_cmd(c, BMIC_SENSE_DIAG_OPTIONS, h, options, 4, 0,
@@ -9003,11 +8949,10 @@ static void __hpsa_shutdown(struct pci_dev *pdev)
 	struct ctlr_info *h;
 
 	h = pci_get_drvdata(pdev);
-	/* Turn board interrupts off  and send the flush cache command
-	 * sendcmd will turn off interrupt, and send the flush...
-	 * To write all data in the battery backed cache to disks
+	/*
+	 * Turn board interrupts off;
+	 * flush cache command has already been sent.
 	 */
-	hpsa_flush_cache(h);
 	h->access.set_intr_mask(h, HPSA_INTR_OFF);
 	hpsa_free_irqs(h);			/* init_one 4 */
 	hpsa_disable_interrupt_mode(h);		/* pci_init 2 */
@@ -9015,6 +8960,7 @@ static void __hpsa_shutdown(struct pci_dev *pdev)
 
 static void hpsa_shutdown(struct pci_dev *pdev)
 {
+	hpsa_flush_cache(pci_get_drvdata(pdev));
 	__hpsa_shutdown(pdev);
 	pci_disable_device(pdev);
 }
@@ -9059,6 +9005,7 @@ static void hpsa_remove_one(struct pci_dev *pdev)
 	 * when multipath is enabled. There can be SYNCHRONIZE CACHE
 	 * operations which cannot complete and will hang the system.
 	 */
+	hpsa_flush_cache(h);
 	if (h->scsi_host)
 		scsi_remove_host(h->scsi_host);		/* init_one 8 */
 	/* includes hpsa_free_irqs - init_one 4 */
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index f8c88fc7b80a..d5fcecbc4401 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -205,7 +205,6 @@ struct ctlr_info {
 	dma_addr_t		ioaccel2_cmd_pool_dhandle;
 	struct ErrorInfo 	*errinfo_pool;
 	dma_addr_t		errinfo_pool_dhandle;
-	unsigned long  		*cmd_pool_bits;
 	int			scan_finished;
 	u8			scan_waiting : 1;
 	spinlock_t		scan_lock;
@@ -215,6 +214,8 @@ struct ctlr_info {
 	spinlock_t devlock; /* to protect hba[ctlr]->dev[];  */
 	int ndevices; /* number of used elements in .dev[] array. */
 	struct hpsa_scsi_dev_t *dev[HPSA_MAX_DEVICES];
+	struct scsi_device *raid_ctrl_sdev;
+
 	/*
 	 * Performant mode tables.
 	 */
-- 
2.16.4

