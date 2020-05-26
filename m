Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB91A750D
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2020 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406829AbgDNHmp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Apr 2020 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406822AbgDNHmn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Apr 2020 03:42:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C5C008749;
        Tue, 14 Apr 2020 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SqPcLMimSJ0sqLaKstNKrRjJ4WttSTRibfiSByDqRdE=; b=ape5s4sdPYnpjSEOQ+EECj6zT+
        u+/+u/gG34o+mPn4ue/zLwtAn3XA8wRnivCE1iNqtE3RmTx5NExUkrLNTbdc6JqKwvtdvkKTfINT6
        moHG9L1sJyvxLh6LLBCfIxFVuKrA8aDuRb0sUiwSX7sIlVbmzihDLOVQ7xiojegSzMRZOO8SZWIK/
        b5kQN6d31Yfi9OWyM0x0WygwDI+kcEv0kPRTpClTvRoITU4cRah2QVK+f8Dkre9iUdOt42TuCJuRQ
        tywfc/71ba7CF8We5Eqd95ajzuxt2SXUWwGymXtz/ieEQj9oBOUL905j6aBBQce3K4sJmZKbBLIqo
        WN7H/X1g==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOGDP-0007Ap-3S; Tue, 14 Apr 2020 07:42:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 4/5] block: move dma drain handling to scsi
Date:   Tue, 14 Apr 2020 09:42:24 +0200
Message-Id: <20200414074225.332324-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414074225.332324-1-hch@lst.de>
References: <20200414074225.332324-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Don't burden the common block code with with specifics of the libata DMA
draining mechanism.  Instead move most of the code to the scsi midlayer.

That also means the nr_phys_segments adjustments in the blk-mq fast path
can go away entirely, given that SCSI never looks at nr_phys_segments
after mapping the request to a scatterlist.

Signed-off-by: Christoph Hellwig <hch@lst.de>

wip
---
 block/blk-merge.c          | 14 --------------
 block/blk-mq.c             | 11 -----------
 block/blk-settings.c       | 37 ------------------------------------
 drivers/ata/libata-scsi.c  | 28 ++++++++++-----------------
 drivers/scsi/scsi_lib.c    | 39 +++++++++++++++++++++++++++++++++-----
 include/linux/blkdev.h     |  7 -------
 include/linux/libata.h     |  2 ++
 include/scsi/scsi_device.h |  3 +++
 include/scsi/scsi_host.h   |  7 +++++++
 9 files changed, 56 insertions(+), 92 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ee618cdb141e..25f5a5e00ee6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -539,20 +539,6 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 		rq->extra_len += pad_len;
 	}
 
-	if (q->dma_drain_size && q->dma_drain_needed(rq)) {
-		if (op_is_write(req_op(rq)))
-			memset(q->dma_drain_buffer, 0, q->dma_drain_size);
-
-		sg_unmark_end(*last_sg);
-		*last_sg = sg_next(*last_sg);
-		sg_set_page(*last_sg, virt_to_page(q->dma_drain_buffer),
-			    q->dma_drain_size,
-			    ((unsigned long)q->dma_drain_buffer) &
-			    (PAGE_SIZE - 1));
-		nsegs++;
-		rq->extra_len += q->dma_drain_size;
-	}
-
 	if (*last_sg)
 		sg_mark_end(*last_sg);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e56884fd2e9..28ad7e1e850b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -667,15 +667,6 @@ void blk_mq_start_request(struct request *rq)
 	blk_add_timer(rq);
 	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
 
-	if (q->dma_drain_size && blk_rq_bytes(rq)) {
-		/*
-		 * Make sure space for the drain appears.  We know we can do
-		 * this because max_hw_segments has been adjusted to be one
-		 * fewer than the device can handle.
-		 */
-		rq->nr_phys_segments++;
-	}
-
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
 		q->integrity.profile->prepare_fn(rq);
@@ -695,8 +686,6 @@ static void __blk_mq_requeue_request(struct request *rq)
 	if (blk_mq_request_started(rq)) {
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 		rq->rq_flags &= ~RQF_TIMED_OUT;
-		if (q->dma_drain_size && blk_rq_bytes(rq))
-			rq->nr_phys_segments--;
 	}
 }
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..2ab1967b9716 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -651,43 +651,6 @@ void blk_queue_update_dma_pad(struct request_queue *q, unsigned int mask)
 }
 EXPORT_SYMBOL(blk_queue_update_dma_pad);
 
-/**
- * blk_queue_dma_drain - Set up a drain buffer for excess dma.
- * @q:  the request queue for the device
- * @dma_drain_needed: fn which returns non-zero if drain is necessary
- * @buf:	physically contiguous buffer
- * @size:	size of the buffer in bytes
- *
- * Some devices have excess DMA problems and can't simply discard (or
- * zero fill) the unwanted piece of the transfer.  They have to have a
- * real area of memory to transfer it into.  The use case for this is
- * ATAPI devices in DMA mode.  If the packet command causes a transfer
- * bigger than the transfer size some HBAs will lock up if there
- * aren't DMA elements to contain the excess transfer.  What this API
- * does is adjust the queue so that the buf is always appended
- * silently to the scatterlist.
- *
- * Note: This routine adjusts max_hw_segments to make room for appending
- * the drain buffer.  If you call blk_queue_max_segments() after calling
- * this routine, you must set the limit to one fewer than your device
- * can support otherwise there won't be room for the drain buffer.
- */
-int blk_queue_dma_drain(struct request_queue *q,
-			       dma_drain_needed_fn *dma_drain_needed,
-			       void *buf, unsigned int size)
-{
-	if (queue_max_segments(q) < 2)
-		return -EINVAL;
-	/* make room for appending the drain */
-	blk_queue_max_segments(q, queue_max_segments(q) - 1);
-	q->dma_drain_needed = dma_drain_needed;
-	q->dma_drain_buffer = buf;
-	q->dma_drain_size = size;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(blk_queue_dma_drain);
-
 /**
  * blk_queue_segment_boundary - set boundary rules for segment merging
  * @q:  the request queue for the device
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 36e588d88b95..feb13b8f93d7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1017,16 +1017,11 @@ void ata_scsi_sdev_config(struct scsi_device *sdev)
  *	RETURNS:
  *	1 if ; otherwise, 0.
  */
-static int atapi_drain_needed(struct request *rq)
+bool ata_scsi_dma_need_drain(struct request *rq)
 {
-	if (likely(!blk_rq_is_passthrough(rq)))
-		return 0;
-
-	if (!blk_rq_bytes(rq) || op_is_write(req_op(rq)))
-		return 0;
-
 	return atapi_cmd_type(scsi_req(rq)->cmd[0]) == ATAPI_MISC;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_dma_need_drain);
 
 int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 {
@@ -1039,21 +1034,21 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	blk_queue_max_hw_sectors(q, dev->max_sectors);
 
 	if (dev->class == ATA_DEV_ATAPI) {
-		void *buf;
-
 		sdev->sector_size = ATA_SECT_SIZE;
 
 		/* set DMA padding */
 		blk_queue_update_dma_pad(q, ATA_DMA_PAD_SZ - 1);
 
-		/* configure draining */
-		buf = kmalloc(ATAPI_MAX_DRAIN, q->bounce_gfp | GFP_KERNEL);
-		if (!buf) {
+		/* make room for appending the drain */
+		blk_queue_max_segments(q, queue_max_segments(q) - 1);
+
+		sdev->dma_drain_len = ATAPI_MAX_DRAIN;
+		sdev->dma_drain_buf = kmalloc(sdev->dma_drain_len,
+				q->bounce_gfp | GFP_KERNEL);
+		if (!sdev->dma_drain_buf) {
 			ata_dev_err(dev, "drain buffer allocation failed\n");
 			return -ENOMEM;
 		}
-
-		blk_queue_dma_drain(q, atapi_drain_needed, buf, ATAPI_MAX_DRAIN);
 	} else {
 		sdev->sector_size = ata_id_logical_sector_size(dev->id);
 		sdev->manage_start_stop = 1;
@@ -1135,7 +1130,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 void ata_scsi_slave_destroy(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct request_queue *q = sdev->request_queue;
 	unsigned long flags;
 	struct ata_device *dev;
 
@@ -1152,9 +1146,7 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	kfree(q->dma_drain_buffer);
-	q->dma_drain_buffer = NULL;
-	q->dma_drain_size = 0;
+	kfree(sdev->dma_drain_buf);
 }
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 274dd3ffa66b..b561c6dbda6b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -978,6 +978,14 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 		scsi_io_completion_action(cmd, result);
 }
 
+static inline bool scsi_cmd_needs_dma_drain(struct scsi_device *sdev,
+		struct request *rq)
+{
+	return sdev->dma_drain_len && blk_rq_is_passthrough(rq) &&
+	       !op_is_write(req_op(rq)) &&
+	       sdev->host->hostt->dma_need_drain(rq);
+}
+
 /*
  * Function:    scsi_init_io()
  *
@@ -991,26 +999,47 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
  */
 blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 {
+	struct scsi_device *sdev = cmd->device;
 	struct request *rq = cmd->request;
+	unsigned short nr_segs = blk_rq_nr_phys_segments(rq);
+	struct scatterlist *last_sg = NULL;
 	blk_status_t ret;
+	bool need_drain = scsi_cmd_needs_dma_drain(sdev, rq);
 	int count;
 
-	if (WARN_ON_ONCE(!blk_rq_nr_phys_segments(rq)))
+	if (WARN_ON_ONCE(!nr_segs))
 		return BLK_STS_IOERR;
 
+	/*
+	 * Make sure there is space for the drain.  The driver must adjust
+	 * max_hw_segments to be prepared for this.
+	 */
+	if (need_drain)
+		nr_segs++;
+
 	/*
 	 * If sg table allocation fails, requeue request later.
 	 */
-	if (unlikely(sg_alloc_table_chained(&cmd->sdb.table,
-			blk_rq_nr_phys_segments(rq), cmd->sdb.table.sgl,
-			SCSI_INLINE_SG_CNT)))
+	if (unlikely(sg_alloc_table_chained(&cmd->sdb.table, nr_segs,
+			cmd->sdb.table.sgl, SCSI_INLINE_SG_CNT)))
 		return BLK_STS_RESOURCE;
 
 	/*
 	 * Next, walk the list, and fill in the addresses and sizes of
 	 * each segment.
 	 */
-	count = blk_rq_map_sg(rq->q, rq, cmd->sdb.table.sgl);
+	count = __blk_rq_map_sg(rq->q, rq, cmd->sdb.table.sgl, &last_sg);
+
+	if (need_drain) {
+		sg_unmark_end(last_sg);
+		last_sg = sg_next(last_sg);
+		sg_set_buf(last_sg, sdev->dma_drain_buf, sdev->dma_drain_len);
+		sg_mark_end(last_sg);
+
+		rq->extra_len += sdev->dma_drain_len;
+		count++;
+	}
+
 	BUG_ON(count > cmd->sdb.table.nents);
 	cmd->sdb.table.nents = count;
 	cmd->sdb.length = blk_rq_payload_bytes(rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 496dc9491026..8e4726bce498 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -288,7 +288,6 @@ struct blk_queue_ctx;
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
 
 struct bio_vec;
-typedef int (dma_drain_needed_fn)(struct request *);
 
 enum blk_eh_timer_return {
 	BLK_EH_DONE,		/* drivers has completed the command */
@@ -397,7 +396,6 @@ struct request_queue {
 	struct rq_qos		*rq_qos;
 
 	make_request_fn		*make_request_fn;
-	dma_drain_needed_fn	*dma_drain_needed;
 
 	const struct blk_mq_ops	*mq_ops;
 
@@ -467,8 +465,6 @@ struct request_queue {
 	 */
 	unsigned long		nr_requests;	/* Max # of requests */
 
-	unsigned int		dma_drain_size;
-	void			*dma_drain_buffer;
 	unsigned int		dma_pad_mask;
 	unsigned int		dma_alignment;
 
@@ -1097,9 +1093,6 @@ extern void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 			      sector_t offset);
 extern void blk_queue_stack_limits(struct request_queue *t, struct request_queue *b);
 extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
-extern int blk_queue_dma_drain(struct request_queue *q,
-			       dma_drain_needed_fn *dma_drain_needed,
-			       void *buf, unsigned int size);
 extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_dma_alignment(struct request_queue *, int);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index cffa4714bfa8..af832852e620 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1092,6 +1092,7 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 #define ATA_SCSI_COMPAT_IOCTL /* empty */
 #endif
 extern int ata_scsi_queuecmd(struct Scsi_Host *h, struct scsi_cmnd *cmd);
+bool ata_scsi_dma_need_drain(struct request *rq);
 extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
 			    unsigned int cmd, void __user *arg);
 extern bool ata_link_online(struct ata_link *link);
@@ -1387,6 +1388,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.ioctl			= ata_scsi_ioctl,		\
 	ATA_SCSI_COMPAT_IOCTL					\
 	.queuecommand		= ata_scsi_queuecmd,		\
+	.dma_need_drain		= ata_scsi_dma_need_drain,	\
 	.can_queue		= ATA_DEF_QUEUE,		\
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index c3cba2aaf934..bc5909033d13 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -229,6 +229,9 @@ struct scsi_device {
 	struct scsi_device_handler *handler;
 	void			*handler_data;
 
+	size_t			dma_drain_len;
+	void			*dma_drain_buf;
+
 	unsigned char		access_state;
 	struct mutex		state_mutex;
 	enum scsi_device_state sdev_state;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 822e8cda8d9b..46ef8cccc982 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -270,6 +270,13 @@ struct scsi_host_template {
 	 */
 	int (* map_queues)(struct Scsi_Host *shost);
 
+	/*
+	 * Check if scatterlists need to be padded for DMA draining.
+	 *
+	 * Status: OPTIONAL
+	 */
+	bool (* dma_need_drain)(struct request *rq);
+
 	/*
 	 * This function determines the BIOS parameters for a given
 	 * harddisk.  These tend to be numbers that are made up by
-- 
2.25.1

