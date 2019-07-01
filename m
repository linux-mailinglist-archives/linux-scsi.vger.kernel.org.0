Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977892DE2B
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfE2N3N (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:45554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbfE2N3M (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64F2DAFE7;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 13/24] hpsa: use reserved commands
Date:   Wed, 29 May 2019 15:28:50 +0200
Message-Id: <20190529132901.27645-14-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Enable the use of reserved commands, and drop the hand-crafted
command allocation.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hpsa.c | 144 ++++++++++++++++------------------------------------
 drivers/scsi/hpsa.h |   1 -
 2 files changed, 44 insertions(+), 101 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c7d3463da4be..aa1a8c70292c 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -245,10 +245,6 @@ static struct hpsa_scsi_dev_t
 	*hpsa_find_device_by_sas_rphy(struct ctlr_info *h,
 		struct sas_rphy *rphy);
 
-#define SCSI_CMD_BUSY ((struct scsi_cmnd *)&hpsa_cmd_busy)
-static const struct scsi_cmnd hpsa_cmd_busy;
-#define SCSI_CMD_IDLE ((struct scsi_cmnd *)&hpsa_cmd_idle)
-static const struct scsi_cmnd hpsa_cmd_idle;
 static int number_of_controllers;
 
 static irqreturn_t do_hpsa_intr_intx(int irq, void *dev_id);
@@ -343,7 +339,7 @@ static inline struct ctlr_info *shost_to_hba(struct Scsi_Host *sh)
 
 static inline bool hpsa_is_cmd_idle(struct CommandList *c)
 {
-	return c->scsi_cmd == SCSI_CMD_IDLE;
+	return c->scsi_cmd == NULL;
 }
 
 /* extract sense key, asc, and ascq from sense data.  -1 means invalid. */
@@ -2444,7 +2440,12 @@ static void hpsa_cmd_resolve_events(struct ctlr_info *h,
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
@@ -5492,7 +5493,6 @@ static void hpsa_cmd_init(struct ctlr_info *h, int index,
 	c->ErrDesc.Addr = cpu_to_le64((u64) err_dma_handle);
 	c->ErrDesc.Len = cpu_to_le32((u32) sizeof(*c->err_info));
 	c->h = h;
-	c->scsi_cmd = SCSI_CMD_IDLE;
 }
 
 static void hpsa_preinitialize_commands(struct ctlr_info *h)
@@ -5785,6 +5785,8 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 	sh->max_lun = HPSA_MAX_LUN;
 	sh->max_id = HPSA_MAX_LUN;
 	sh->can_queue = h->nr_cmds - HPSA_NRESERVED_CMDS;
+	sh->nr_reserved_cmds = HPSA_NRESERVED_CMDS;
+	sh->use_reserved_cmd_q = true;
 	sh->cmd_per_lun = sh->can_queue;
 	sh->sg_tablesize = h->maxsgentries;
 	sh->transportt = hpsa_sas_transport_template;
@@ -5828,23 +5830,6 @@ static int hpsa_scsi_add_host(struct ctlr_info *h)
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
@@ -5966,7 +5951,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	int rc = SUCCESS;
 	int i;
 	struct ctlr_info *h;
-	struct hpsa_scsi_dev_t *dev;
+	struct hpsa_scsi_dev_t *dev = NULL;
 	u8 reset_type;
 	char msg[48];
 	unsigned long flags;
@@ -6001,7 +5986,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	if (lockup_detected(h)) {
 		snprintf(msg, sizeof(msg),
 			 "cmd %d RESET FAILED, lockup detected",
-			 hpsa_get_cmd_index(scsicmd));
+			 scsicmd->request->tag);
 		hpsa_show_dev_msg(KERN_WARNING, h, dev, msg);
 		rc = FAILED;
 		goto return_reset_status;
@@ -6011,7 +5996,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	if (detect_controller_lockup(h)) {
 		snprintf(msg, sizeof(msg),
 			 "cmd %d RESET FAILED, new lockup detected",
-			 hpsa_get_cmd_index(scsicmd));
+			 scsicmd->request->tag);
 		hpsa_show_dev_msg(KERN_WARNING, h, dev, msg);
 		rc = FAILED;
 		goto return_reset_status;
@@ -6073,12 +6058,12 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
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
@@ -6117,80 +6102,48 @@ static void cmd_tagged_free(struct ctlr_info *h, struct CommandList *c)
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
 static struct CommandList *cmd_alloc(struct ctlr_info *h)
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
+	scmd = scsi_host_get_reserved_cmd(h->scsi_host);
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
+	if (c->cmd_type == CMD_IOCTL_PEND && scmd) {
+		dev_dbg(&h->pdev->dev, "returning reserved cmd %u\n",
+			scmd->request->tag);
+		scsi_put_reserved_cmd(scmd);
 	}
 }
 
@@ -6377,7 +6330,6 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 
 	/* Fill in the command type */
 	c->cmd_type = CMD_IOCTL_PEND;
-	c->scsi_cmd = SCSI_CMD_BUSY;
 	/* Fill in Command Header */
 	c->Header.ReplyQueue = 0; /* unused in simple mode */
 	if (iocommand.buf_size > 0) {	/* buffer to fill */
@@ -6509,7 +6461,6 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	c = cmd_alloc(h);
 
 	c->cmd_type = CMD_IOCTL_PEND;
-	c->scsi_cmd = SCSI_CMD_BUSY;
 	c->Header.ReplyQueue = 0;
 	c->Header.SGList = (u8) sg_used;
 	c->Header.SGTotal = cpu_to_le16(sg_used);
@@ -6653,7 +6604,6 @@ static int fill_cmd(struct CommandList *c, u8 cmd, struct ctlr_info *h,
 	enum dma_data_direction dir = DMA_NONE;
 
 	c->cmd_type = CMD_IOCTL_PEND;
-	c->scsi_cmd = SCSI_CMD_BUSY;
 	c->Header.ReplyQueue = 0;
 	if (buff != NULL && size > 0) {
 		c->Header.SGList = 1;
@@ -7966,8 +7916,6 @@ static int hpsa_init_reset_devices(struct pci_dev *pdev, u32 board_id)
 
 static void hpsa_free_cmd_pool(struct ctlr_info *h)
 {
-	kfree(h->cmd_pool_bits);
-	h->cmd_pool_bits = NULL;
 	if (h->cmd_pool) {
 		dma_free_coherent(&h->pdev->dev,
 				h->nr_cmds * sizeof(struct CommandList),
@@ -7988,17 +7936,13 @@ static void hpsa_free_cmd_pool(struct ctlr_info *h)
 
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
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index f8c88fc7b80a..70addb024ebb 100644
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
-- 
2.16.4

