Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7CC45EE70
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Nov 2021 14:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhKZNGv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Nov 2021 08:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhKZNEs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Nov 2021 08:04:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B814EC06137F;
        Fri, 26 Nov 2021 04:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p4BWTk0rGQd/2C4NW9pMLPrVIv2RnZenKUEJ7oeIu80=; b=jrXrUPtXhz3k7vzOYBQibs84rY
        N8vkxTUXgVkSWdeuhRQlJFWtsx7wiQFuJrzUKUVUmrocGAsIcrY5FmDTAUkMuBBinMeeYjncp4dC/
        OjjZHjOZh22EkhDAlbqFccib2ey8CBDLhxDov243huSvTtFj46DLxDyZNnNiZTT3To3I/X1Yh4kjj
        eGIUTqXSuW6ThigPA7RKlKlyX6lT6grpFMcP6Hi4mwL3EaFp3E1F7uCFmeBMHD7Sm21KDI+ZzwOBf
        qqzwVoF/4iAyc/pe2kGIoEPLS9sYfHCEcqDBJzoRBk0q2Iocp8lfgP6yrLYFUgpgKAl3fNKPgV7/J
        iDAFw4Ug==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqaB4-00AWGb-OG; Fri, 26 Nov 2021 12:18:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-scsi@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/5] block: remove the ->rq_disk field in struct request
Date:   Fri, 26 Nov 2021 13:18:00 +0100
Message-Id: <20211126121802.2090656-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126121802.2090656-1-hch@lst.de>
References: <20211126121802.2090656-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Just use the disk attached to the request_queue instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-flush.c                |  3 +--
 block/blk-mq.c                   | 14 ++++++--------
 block/blk.h                      |  2 +-
 drivers/block/amiflop.c          |  2 +-
 drivers/block/ataflop.c          |  6 +++---
 drivers/block/floppy.c           |  6 +++---
 drivers/block/null_blk/trace.h   |  2 +-
 drivers/block/paride/pcd.c       |  2 +-
 drivers/block/paride/pd.c        |  4 ++--
 drivers/block/paride/pf.c        |  4 ++--
 drivers/block/rnbd/rnbd-clt.c    |  4 ++--
 drivers/block/sunvdc.c           |  2 +-
 drivers/md/dm-mpath.c            |  1 -
 drivers/mmc/core/block.c         |  2 +-
 drivers/nvme/host/fault_inject.c |  2 +-
 drivers/nvme/host/trace.h        |  6 +++---
 drivers/scsi/scsi_lib.c          |  3 ++-
 drivers/scsi/scsi_logging.c      |  4 +++-
 drivers/scsi/sd.c                | 24 ++++++++++++------------
 drivers/scsi/sd_zbc.c            |  8 ++++----
 drivers/scsi/sr.c                |  4 ++--
 drivers/scsi/virtio_scsi.c       |  2 +-
 drivers/usb/storage/transport.c  |  2 +-
 include/linux/blk-mq.h           |  4 ----
 include/scsi/scsi_cmnd.h         |  2 +-
 include/scsi/scsi_device.h       |  4 ++--
 include/trace/events/block.h     |  8 ++++----
 kernel/trace/blktrace.c          |  2 +-
 28 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 902e80e48e4ae..fd5187a0898df 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -145,7 +145,7 @@ static void blk_flush_queue_rq(struct request *rq, bool add_front)
 
 static void blk_account_io_flush(struct request *rq)
 {
-	struct block_device *part = rq->rq_disk->part0;
+	struct block_device *part = rq->q->disk->part0;
 
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
@@ -339,7 +339,6 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
 	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
-	flush_rq->rq_disk = first_rq->rq_disk;
 	flush_rq->end_io = flush_end_io;
 	/*
 	 * Order WRITE ->end_io and WRITE rq->ref, and its pair is the one
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 82491ab676fb1..0ebda52853b38 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -377,7 +377,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->start_time_ns = ktime_get_ns();
 	else
 		rq->start_time_ns = 0;
-	rq->rq_disk = NULL;
 	rq->part = NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	rq->alloc_time_ns = alloc_time_ns;
@@ -667,7 +666,7 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 void blk_dump_rq_flags(struct request *rq, char *msg)
 {
 	printk(KERN_INFO "%s: dev %s: flags=%llx\n", msg,
-		rq->rq_disk ? rq->rq_disk->disk_name : "?",
+		rq->q->disk ? rq->q->disk->disk_name : "?",
 		(unsigned long long) rq->cmd_flags);
 
 	printk(KERN_INFO "  sector %llu, nr/cnr %u/%u\n",
@@ -720,7 +719,7 @@ static void blk_print_req_error(struct request *req, blk_status_t status)
 		"%s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
 		"phys_seg %u prio class %u\n",
 		blk_status_to_str(status),
-		req->rq_disk ? req->rq_disk->disk_name : "?",
+		req->q->disk ? req->q->disk->disk_name : "?",
 		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
 		req->cmd_flags & ~REQ_OP_MASK,
 		req->nr_phys_segments,
@@ -861,8 +860,8 @@ static void __blk_account_io_start(struct request *rq)
 	/* passthrough requests can hold bios that do not have ->bi_bdev set */
 	if (rq->bio && rq->bio->bi_bdev)
 		rq->part = rq->bio->bi_bdev;
-	else
-		rq->part = rq->rq_disk->part0;
+	else if (rq->q->disk)
+		rq->part = rq->q->disk->part0;
 
 	part_stat_lock();
 	update_io_ticks(rq->part, jiffies, false);
@@ -1179,7 +1178,6 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
 
-	rq->rq_disk = bd_disk;
 	rq->end_io = done;
 
 	blk_account_io_start(rq);
@@ -2908,8 +2906,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	if (ret != BLK_STS_OK)
 		return ret;
 
-	if (rq->rq_disk &&
-	    should_fail_request(rq->rq_disk->part0, blk_rq_bytes(rq)))
+	if (rq->q->disk &&
+	    should_fail_request(rq->q->disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
 	if (blk_crypto_insert_cloned_request(rq))
diff --git a/block/blk.h b/block/blk.h
index a57c84654d0a1..48d62ece03808 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -324,7 +324,7 @@ int blk_dev_init(void);
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return (rq->rq_flags & RQF_IO_STAT) && rq->rq_disk;
+	return (rq->rq_flags & RQF_IO_STAT) && rq->q->disk;
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 1eec5113d0b5b..5a566f2fd533a 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1505,7 +1505,7 @@ static blk_status_t amiflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				     const struct blk_mq_queue_data *bd)
 {
 	struct request *rq = bd->rq;
-	struct amiga_floppy_struct *floppy = rq->rq_disk->private_data;
+	struct amiga_floppy_struct *floppy = rq->q->disk->private_data;
 	blk_status_t err;
 
 	if (!spin_trylock_irq(&amiflop_lock))
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index f3ff9babdb5cd..5d819a466e2f3 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1502,7 +1502,7 @@ static void setup_req_params( int drive )
 static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				     const struct blk_mq_queue_data *bd)
 {
-	struct atari_floppy_struct *floppy = bd->rq->rq_disk->private_data;
+	struct atari_floppy_struct *floppy = bd->rq->q->disk->private_data;
 	int drive = floppy - unit;
 	int type = floppy->type;
 
@@ -1538,7 +1538,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (!UDT) {
 			Probing = 1;
 			UDT = atari_disk_type + StartDiskType[DriveType];
-			set_capacity(bd->rq->rq_disk, UDT->blocks);
+			set_capacity(bd->rq->q->disk, UDT->blocks);
 			UD.autoprobe = 1;
 		}
 	} 
@@ -1558,7 +1558,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 		type = minor2disktype[type].index;
 		UDT = &atari_disk_type[type];
-		set_capacity(bd->rq->rq_disk, UDT->blocks);
+		set_capacity(bd->rq->q->disk, UDT->blocks);
 		UD.autoprobe = 0;
 	}
 
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 7f0a60c4079fd..0c638de25023f 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2259,7 +2259,7 @@ static int do_format(int drive, struct format_descr *tmp_format_req)
 static void floppy_end_request(struct request *req, blk_status_t error)
 {
 	unsigned int nr_sectors = current_count_sectors;
-	unsigned int drive = (unsigned long)req->rq_disk->private_data;
+	unsigned int drive = (unsigned long)req->q->disk->private_data;
 
 	/* current_count_sectors can be zero if transfer failed */
 	if (error)
@@ -2550,7 +2550,7 @@ static int make_raw_rw_request(void)
 	if (WARN(max_buffer_sectors == 0, "VFS: Block I/O scheduled on unopened device\n"))
 		return 0;
 
-	set_fdc((long)current_req->rq_disk->private_data);
+	set_fdc((long)current_req->q->disk->private_data);
 
 	raw_cmd = &default_raw_cmd;
 	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_DISK | FD_RAW_NEED_SEEK;
@@ -2792,7 +2792,7 @@ static void redo_fd_request(void)
 			return;
 		}
 	}
-	drive = (long)current_req->rq_disk->private_data;
+	drive = (long)current_req->q->disk->private_data;
 	set_fdc(drive);
 	reschedule_timeout(current_drive, "redo fd request");
 
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index ce3b430e88c57..86d6c12c603cc 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -44,7 +44,7 @@ TRACE_EVENT(nullb_zone_op,
 		__entry->op = req_op(cmd->rq);
 		__entry->zone_no = zone_no;
 		__entry->zone_cond = zone_cond;
-		__assign_disk_name(__entry->disk, cmd->rq->rq_disk);
+		__assign_disk_name(__entry->disk, cmd->rq->q->disk);
 	    ),
 	    TP_printk("%s req=%-15s zone_no=%u zone_cond=%-10s",
 		      __print_disk_name(__entry->disk),
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 255fd3d4b8a84..f462ad67931aa 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -690,7 +690,7 @@ static void pcd_request(void)
 	if (!pcd_req && !set_next_request())
 		return;
 
-	cd = pcd_req->rq_disk->private_data;
+	cd = pcd_req->q->disk->private_data;
 	if (cd != pcd_current)
 		pcd_bufblk = -1;
 	pcd_current = cd;
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index fba865058a17b..4f8cce5105621 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -430,7 +430,7 @@ static void run_fsm(void)
 		int stop = 0;
 
 		if (!phase) {
-			pd_current = pd_req->rq_disk->private_data;
+			pd_current = pd_req->q->disk->private_data;
 			pi_current = pd_current->pi;
 			phase = do_pd_io_start;
 		}
@@ -492,7 +492,7 @@ static enum action do_pd_io_start(void)
 	case REQ_OP_WRITE:
 		pd_block = blk_rq_pos(pd_req);
 		pd_count = blk_rq_cur_sectors(pd_req);
-		if (pd_block + pd_count > get_capacity(pd_req->rq_disk))
+		if (pd_block + pd_count > get_capacity(pd_req->q->disk))
 			return Fail;
 		pd_run = blk_rq_sectors(pd_req);
 		pd_buf = bio_data(pd_req->bio);
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index b84a6448a4f75..292e9a4ce1b9e 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -746,12 +746,12 @@ static void pf_request(void)
 	if (!pf_req && !set_next_request())
 		return;
 
-	pf_current = pf_req->rq_disk->private_data;
+	pf_current = pf_req->q->disk->private_data;
 	pf_block = blk_rq_pos(pf_req);
 	pf_run = blk_rq_sectors(pf_req);
 	pf_count = blk_rq_cur_sectors(pf_req);
 
-	if (pf_block + pf_count > get_capacity(pf_req->rq_disk)) {
+	if (pf_block + pf_count > get_capacity(pf_req->q->disk)) {
 		pf_end_request(BLK_STS_IOERR);
 		goto repeat;
 	}
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 2df0657cdf003..67a8edbaa1fdb 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -393,7 +393,7 @@ static void rnbd_put_iu(struct rnbd_clt_session *sess, struct rnbd_iu *iu)
 
 static void rnbd_softirq_done_fn(struct request *rq)
 {
-	struct rnbd_clt_dev *dev	= rq->rq_disk->private_data;
+	struct rnbd_clt_dev *dev	= rq->q->disk->private_data;
 	struct rnbd_clt_session *sess	= dev->sess;
 	struct rnbd_iu *iu;
 
@@ -1133,7 +1133,7 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 				   const struct blk_mq_queue_data *bd)
 {
 	struct request *rq = bd->rq;
-	struct rnbd_clt_dev *dev = rq->rq_disk->private_data;
+	struct rnbd_clt_dev *dev = rq->q->disk->private_data;
 	struct rnbd_iu *iu = blk_mq_rq_to_pdu(rq);
 	int err;
 	blk_status_t ret = BLK_STS_IOERR;
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 2157936de623c..146d85d80e0e7 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -462,7 +462,7 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 
 static int __send_request(struct request *req)
 {
-	struct vdc_port *port = req->rq_disk->private_data;
+	struct vdc_port *port = req->q->disk->private_data;
 	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
 	struct scatterlist sg[MAX_RING_COOKIES];
 	struct vdc_req_entry *rqe;
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 90dc9cc488814..f4719b65e5e33 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -550,7 +550,6 @@ static int multipath_clone_and_map(struct dm_target *ti, struct request *rq,
 		return DM_MAPIO_REQUEUE;
 	}
 	clone->bio = clone->biotail = NULL;
-	clone->rq_disk = bdev->bd_disk;
 	clone->cmd_flags |= REQ_FAILFAST_TRANSPORT;
 	*__clone = clone;
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 635b79899b9fe..dc094f73d3359 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1837,7 +1837,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 	/* Reset if the card is in a bad state */
 	if (!mmc_host_is_spi(mq->card->host) &&
 	    err && mmc_blk_reset(md, card->host, type)) {
-		pr_err("%s: recovery failed!\n", req->rq_disk->disk_name);
+		pr_err("%s: recovery failed!\n", req->q->disk->disk_name);
 		mqrq->retries = MMC_NO_RETRIES;
 		return;
 	}
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 1352159733b08..83d2e6860d388 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -56,7 +56,7 @@ void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject)
 
 void nvme_should_fail(struct request *req)
 {
-	struct gendisk *disk = req->rq_disk;
+	struct gendisk *disk = req->q->disk;
 	struct nvme_fault_inject *fault_inject = NULL;
 	u16 status;
 
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 35bac7a254227..b5f85259461a6 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -68,7 +68,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = !!blk_integrity_rq(req);
 		__entry->fctype = cmd->fabrics.fctype;
-		__assign_disk_name(__entry->disk, req->rq_disk);
+		__assign_disk_name(__entry->disk, req->q->disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
 			sizeof(__entry->cdw10));
 	    ),
@@ -103,7 +103,7 @@ TRACE_EVENT(nvme_complete_rq,
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
 		__entry->status = nvme_req(req)->status;
-		__assign_disk_name(__entry->disk, req->rq_disk);
+		__assign_disk_name(__entry->disk, req->q->disk);
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%#llx, retries=%u, flags=0x%x, status=%#x",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
@@ -153,7 +153,7 @@ TRACE_EVENT(nvme_sq,
 	),
 	TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
-		__assign_disk_name(__entry->disk, req->rq_disk);
+		__assign_disk_name(__entry->disk, req->q->disk);
 		__entry->qid = nvme_req_qid(req);
 		__entry->sq_head = le16_to_cpu(sq_head);
 		__entry->sq_tail = sq_tail;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5e8b5ecb3245a..c23cf8e7b3c3c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -543,8 +543,9 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	if (blk_update_request(req, error, bytes))
 		return true;
 
+	// XXX:
 	if (blk_queue_add_random(q))
-		add_disk_randomness(req->rq_disk);
+		add_disk_randomness(req->q->disk);
 
 	if (!blk_rq_is_passthrough(req)) {
 		WARN_ON_ONCE(!(cmd->flags & SCMD_INITIALIZED));
diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index ed9572252a426..1f8f80b2dbfcb 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -30,7 +30,9 @@ static inline const char *scmd_name(const struct scsi_cmnd *scmd)
 {
 	struct request *rq = scsi_cmd_to_rq((struct scsi_cmnd *)scmd);
 
-	return rq->rq_disk ? rq->rq_disk->disk_name : NULL;
+	if (!rq->q->disk)
+		return NULL;
+	return rq->q->disk->disk_name;
 }
 
 static size_t sdev_format_header(char *logbuf, size_t logbuf_len,
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index bba1f5dafd387..8181857ddf53f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -872,7 +872,7 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	unsigned int data_len = 24;
@@ -908,7 +908,7 @@ static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
@@ -940,7 +940,7 @@ static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
@@ -971,7 +971,7 @@ static blk_status_t sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_device *sdp = cmd->device;
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 
@@ -1068,7 +1068,7 @@ static blk_status_t sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_device *sdp = cmd->device;
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	struct bio *bio = rq->bio;
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
@@ -1116,7 +1116,7 @@ static blk_status_t sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 
 	/* flush requests don't perform I/O, zero the S/G table */
 	memset(&cmd->sdb, 0, sizeof(cmd->sdb));
@@ -1215,7 +1215,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_device *sdp = cmd->device;
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	sector_t lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	sector_t threshold;
 	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
@@ -1236,7 +1236,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		goto fail;
 	}
 
-	if (blk_rq_pos(rq) + blk_rq_sectors(rq) > get_capacity(rq->rq_disk)) {
+	if (blk_rq_pos(rq) + blk_rq_sectors(rq) > get_capacity(rq->q->disk)) {
 		scmd_printk(KERN_ERR, cmd, "access beyond end of device\n");
 		goto fail;
 	}
@@ -1331,7 +1331,7 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 
 	switch (req_op(rq)) {
 	case REQ_OP_DISCARD:
-		switch (scsi_disk(rq->rq_disk)->provisioning_mode) {
+		switch (scsi_disk(rq->q->disk)->provisioning_mode) {
 		case SD_LBP_UNMAP:
 			return sd_setup_unmap_cmnd(cmd);
 		case SD_LBP_WS16:
@@ -1917,7 +1917,7 @@ static const struct block_device_operations sd_fops = {
  **/
 static void sd_eh_reset(struct scsi_cmnd *scmd)
 {
-	struct scsi_disk *sdkp = scsi_disk(scsi_cmd_to_rq(scmd)->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(scsi_cmd_to_rq(scmd)->q->disk);
 
 	/* New SCSI EH run, reset gate variable */
 	sdkp->ignore_medium_access_errors = false;
@@ -1937,7 +1937,7 @@ static void sd_eh_reset(struct scsi_cmnd *scmd)
  **/
 static int sd_eh_action(struct scsi_cmnd *scmd, int eh_disp)
 {
-	struct scsi_disk *sdkp = scsi_disk(scsi_cmd_to_rq(scmd)->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(scsi_cmd_to_rq(scmd)->q->disk);
 	struct scsi_device *sdev = scmd->device;
 
 	if (!scsi_device_online(sdev) ||
@@ -2034,7 +2034,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	unsigned int resid;
 	struct scsi_sense_hdr sshdr;
 	struct request *req = scsi_cmd_to_rq(SCpnt);
-	struct scsi_disk *sdkp = scsi_disk(req->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(req->q->disk);
 	int sense_valid = 0;
 	int sense_deferred = 0;
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index ed06798983f87..65bfd1e170da9 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -244,7 +244,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	sector_t sector = blk_rq_pos(rq);
 
 	if (!sd_is_zoned(sdkp))
@@ -322,7 +322,7 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 					unsigned int nr_blocks)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	unsigned int wp_offset, zno = blk_rq_zone_no(rq);
 	unsigned long flags;
 	blk_status_t ret;
@@ -388,7 +388,7 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	sector_t sector = blk_rq_pos(rq);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	sector_t block = sectors_to_logical(sdkp->device, sector);
 	blk_status_t ret;
 
@@ -443,7 +443,7 @@ static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
 {
 	int result = cmd->result;
 	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
 	unsigned int zno = blk_rq_zone_no(rq);
 	enum req_opf op = req_op(rq);
 	unsigned long flags;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 411e2b01966e8..7db595c08b20a 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -335,7 +335,7 @@ static int sr_done(struct scsi_cmnd *SCpnt)
 	int block_sectors = 0;
 	long error_sector;
 	struct request *rq = scsi_cmd_to_rq(SCpnt);
-	struct scsi_cd *cd = scsi_cd(rq->rq_disk);
+	struct scsi_cd *cd = scsi_cd(rq->q->disk);
 
 #ifdef DEBUG
 	scmd_printk(KERN_INFO, SCpnt, "done: %x\n", result);
@@ -402,7 +402,7 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 	ret = scsi_alloc_sgtables(SCpnt);
 	if (ret != BLK_STS_OK)
 		return ret;
-	cd = scsi_cd(rq->rq_disk);
+	cd = scsi_cd(rq->q->disk);
 
 	SCSI_LOG_HLQUEUE(1, scmd_printk(KERN_INFO, SCpnt,
 		"Doing sr request, block = %d\n", block));
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 19f7d7b906251..e6018d9a2b20c 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -528,7 +528,7 @@ static void virtio_scsi_init_hdr_pi(struct virtio_device *vdev,
 	if (!rq || !scsi_prot_sg_count(sc))
 		return;
 
-	bi = blk_get_integrity(rq->rq_disk);
+	bi = blk_get_integrity(rq->q->disk);
 
 	if (sc->sc_data_direction == DMA_TO_DEVICE)
 		cmd_pi->pi_bytesout = cpu_to_virtio32(vdev,
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 4c5a0a49035fc..1928b39182425 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -551,7 +551,7 @@ static void last_sector_hacks(struct us_data *us, struct scsi_cmnd *srb)
 	/* Did this command access the last sector? */
 	sector = (srb->cmnd[2] << 24) | (srb->cmnd[3] << 16) |
 			(srb->cmnd[4] << 8) | (srb->cmnd[5]);
-	disk = scsi_cmd_to_rq(srb)->rq_disk;
+	disk = scsi_cmd_to_rq(srb)->q->disk;
 	if (!disk)
 		goto done;
 	sdkp = scsi_disk(disk);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d952c34422619..ede7bef8880a9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -100,7 +100,6 @@ struct request {
 		struct request *rq_next;
 	};
 
-	struct gendisk *rq_disk;
 	struct block_device *part;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	/* Time that the first bio started allocating this request. */
@@ -890,9 +889,6 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 	rq->ioprio = bio_prio(bio);
-
-	if (bio->bi_bdev)
-		rq->rq_disk = bio->bi_bdev->bd_disk;
 }
 
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 477a800a95433..6794d7322cbde 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -164,7 +164,7 @@ static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
 
-	return *(struct scsi_driver **)rq->rq_disk->private_data;
+	return *(struct scsi_driver **)rq->q->disk->private_data;
 }
 
 void scsi_done(struct scsi_cmnd *cmd);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index d1c6fc83b1e38..ab7557d84f751 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -275,9 +275,9 @@ scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 	do {								\
 		struct request *__rq = scsi_cmd_to_rq((scmd));		\
 									\
-		if (__rq->rq_disk)					\
+		if (__rq->q->disk)					\
 			sdev_dbg((scmd)->device, "[%s] " fmt,		\
-				 __rq->rq_disk->disk_name, ##a);	\
+				 __rq->q->disk->disk_name, ##a);	\
 		else							\
 			sdev_dbg((scmd)->device, fmt, ##a);		\
 	} while (0)
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index a95daa4d4caa2..27170e40e8c95 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -85,7 +85,7 @@ TRACE_EVENT(block_rq_requeue,
 	),
 
 	TP_fast_assign(
-		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 
@@ -128,7 +128,7 @@ TRACE_EVENT(block_rq_complete,
 	),
 
 	TP_fast_assign(
-		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->error     = blk_status_to_errno(error);
@@ -161,7 +161,7 @@ DECLARE_EVENT_CLASS(block_rq,
 	),
 
 	TP_fast_assign(
-		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
@@ -512,7 +512,7 @@ TRACE_EVENT(block_rq_remap,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= disk_devt(rq->rq_disk);
+		__entry->dev		= disk_devt(rq->q->disk);
 		__entry->sector		= blk_rq_pos(rq);
 		__entry->nr_sector	= blk_rq_sectors(rq);
 		__entry->old_dev	= dev;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1183c88634aa6..431e41bc4c232 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1045,7 +1045,7 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 	}
 
 	r.device_from = cpu_to_be32(dev);
-	r.device_to   = cpu_to_be32(disk_devt(rq->rq_disk));
+	r.device_to   = cpu_to_be32(disk_devt(rq->q->disk));
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-- 
2.30.2

