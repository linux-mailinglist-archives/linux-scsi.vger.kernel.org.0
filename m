Return-Path: <linux-scsi+bounces-3917-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419E28953A0
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Apr 2024 14:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8593EB23156
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Apr 2024 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3D80C0C;
	Tue,  2 Apr 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZGe/OPA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A67A151;
	Tue,  2 Apr 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061586; cv=none; b=AWpm6erXkQEnQDSXarxda427tVE4+eDBkJ4bBGMbQRVb6wCr2nBtY7MpfD0TsUgVFK9MDUjCkFN90W2/NUAs33AiICeJIkNw5sO8tJ3OaST9ryeqOTM83O5BU/ZJAeozEFIRsiUoNgFyoxtDEp1GnZkRSPpKFr43vZmCrMx1nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061586; c=relaxed/simple;
	bh=EwyuPvtRfX99fu5ZXcXAblOW9X0264dxzy5A718CnzI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSDA7x2A+Sklr2e/EfhjblTNZLIJaj398YNQC98+sRNnH4NwAGEw7UcvOTHQbiyBdlzmy7M8qLbRNQB7SbGMNFyfsjHdvdUvV9JGOiCV5B9gYenDTaNyuOki1HRK20GLph2DWnynmdpVuJ6hwO+kTAlmD8ryC1oOx0wlBeSmHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZGe/OPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F71EC43399;
	Tue,  2 Apr 2024 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061586;
	bh=EwyuPvtRfX99fu5ZXcXAblOW9X0264dxzy5A718CnzI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NZGe/OPARcjNTdSJUcRklejxeHAsBPHoXbJnAdPaVlTJv/shvsrv3c3UhbHrDU10P
	 WDOjaZPrTEfD9H+Jtz8td9AQium9ZYCs84A8V5kD7Y7Mnuld8wx8sMe9rbcalL2ald
	 l4AAswUekDaVOVVnIlX0e/cQfsgtJDcSrea0Q0PZDlhSAkS4khJR0ReSGlbvZBzpWh
	 1uIPAWHcrBLk9smStUvMtBb+LuDeEU24yn/nKGb8007sHA5xbKhV0Ql2Paw0YpPcYq
	 TbiIxLXl05PoPVAY0by1oBSjQQUqhsHiaS9VZb4SWBRL/veMhSKhIFjFTeyb3mM1AB
	 EaRu1oR3zjHDA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 26/28] block: Remove zone write locking
Date: Tue,  2 Apr 2024 21:39:05 +0900
Message-ID: <20240402123907.512027-27-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zone write locking is now unused and replaced with zone write plugging.
Remove all code that was implementing zone write locking, that is, the
various helper functions controlling request zone write locking and
the gendisk attached zone bitmaps.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c    |  1 -
 block/blk-zoned.c         | 66 ++-----------------------------
 include/linux/blk-mq.h    | 83 ---------------------------------------
 include/linux/blk_types.h |  1 -
 include/linux/blkdev.h    | 35 ++---------------
 5 files changed, 7 insertions(+), 179 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ca1f2b9422d5..770c0c2b72fa 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -256,7 +256,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
-	RQF_NAME(ZONE_WRITE_LOCKED),
 	RQF_NAME(TIMED_OUT),
 	RQF_NAME(RESV),
 };
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 988b40667321..035de116839f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -114,52 +114,6 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
-/*
- * Return true if a request is a write requests that needs zone write locking.
- */
-bool blk_req_needs_zone_write_lock(struct request *rq)
-{
-	if (!rq->q->disk->seq_zones_wlock)
-		return false;
-
-	return blk_rq_is_seq_zoned_write(rq);
-}
-EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
-
-bool blk_req_zone_write_trylock(struct request *rq)
-{
-	unsigned int zno = blk_rq_zone_no(rq);
-
-	if (test_and_set_bit(zno, rq->q->disk->seq_zones_wlock))
-		return false;
-
-	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
-	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(blk_req_zone_write_trylock);
-
-void __blk_req_zone_write_lock(struct request *rq)
-{
-	if (WARN_ON_ONCE(test_and_set_bit(blk_rq_zone_no(rq),
-					  rq->q->disk->seq_zones_wlock)))
-		return;
-
-	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
-	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
-}
-EXPORT_SYMBOL_GPL(__blk_req_zone_write_lock);
-
-void __blk_req_zone_write_unlock(struct request *rq)
-{
-	rq->rq_flags &= ~RQF_ZONE_WRITE_LOCKED;
-	if (rq->q->disk->seq_zones_wlock)
-		WARN_ON_ONCE(!test_and_clear_bit(blk_rq_zone_no(rq),
-						 rq->q->disk->seq_zones_wlock));
-}
-EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
-
 /**
  * bdev_nr_zones - Get number of zones
  * @bdev:	Target device
@@ -1521,9 +1475,6 @@ void disk_free_zone_resources(struct gendisk *disk)
 
 	kfree(disk->conv_zones_bitmap);
 	disk->conv_zones_bitmap = NULL;
-	kfree(disk->seq_zones_wlock);
-	disk->seq_zones_wlock = NULL;
-
 	disk->zone_capacity = 0;
 	disk->nr_zones = 0;
 }
@@ -1571,7 +1522,6 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	unsigned long	*conv_zones_bitmap;
-	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
 	unsigned int	zone_capacity;
 	sector_t	sector;
@@ -1589,7 +1539,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
-	swap(disk->seq_zones_wlock, args->seq_zones_wlock);
 	swap(disk->conv_zones_bitmap, args->conv_zones_bitmap);
 
 	/*
@@ -1679,13 +1628,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		set_bit(idx, args->conv_zones_bitmap);
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
-		if (!args->seq_zones_wlock) {
-			args->seq_zones_wlock =
-				blk_alloc_zone_bitmap(q->node, args->nr_zones);
-			if (!args->seq_zones_wlock)
-				return -ENOMEM;
-		}
-
 		/*
 		 * Remember the capacity of the first sequential zone and check
 		 * if it is constant for all zones.
@@ -1727,7 +1669,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 }
 
 /**
- * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
+ * blk_revalidate_disk_zones - (re)allocate and initialize zone write plugs
  * @disk:	Target disk
  *
  * Helper function for low-level device drivers to check, (re) allocate and
@@ -1801,9 +1743,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	}
 
 	/*
-	 * Install the new bitmaps and update nr_zones only once the queue is
-	 * stopped and all I/Os are completed (i.e. a scheduler is not
-	 * referencing the bitmaps).
+	 * Set the new disk zone parameters only once the queue is frozen and
+	 * all I/Os are completed.
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret > 0)
@@ -1814,7 +1755,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q);
 
-	kfree(args.seq_zones_wlock);
 	kfree(args.conv_zones_bitmap);
 
 	return ret;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 60090c8366fb..89ba6b16fe8b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -54,8 +54,6 @@ typedef __u32 __bitwise req_flags_t;
 /* Look at ->special_vec for the actual data payload instead of the
    bio chain. */
 #define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
-/* The per-zone write lock is held for this request */
-#define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
 /* The request completion needs to be signaled to zone write pluging. */
 #define RQF_ZONE_WRITE_PLUGGING	((__force req_flags_t)(1 << 20))
 /* ->timeout has been called, don't expire again */
@@ -1152,85 +1150,4 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 void blk_dump_rq_flags(struct request *, char *);
 
-#ifdef CONFIG_BLK_DEV_ZONED
-static inline unsigned int blk_rq_zone_no(struct request *rq)
-{
-	return disk_zone_no(rq->q->disk, blk_rq_pos(rq));
-}
-
-static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
-{
-	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
-}
-
-/**
- * blk_rq_is_seq_zoned_write() - Check if @rq requires write serialization.
- * @rq: Request to examine.
- *
- * Note: REQ_OP_ZONE_APPEND requests do not require serialization.
- */
-static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
-{
-	return op_needs_zoned_write_locking(req_op(rq)) &&
-		blk_rq_zone_is_seq(rq);
-}
-
-bool blk_req_needs_zone_write_lock(struct request *rq);
-bool blk_req_zone_write_trylock(struct request *rq);
-void __blk_req_zone_write_lock(struct request *rq);
-void __blk_req_zone_write_unlock(struct request *rq);
-
-static inline void blk_req_zone_write_lock(struct request *rq)
-{
-	if (blk_req_needs_zone_write_lock(rq))
-		__blk_req_zone_write_lock(rq);
-}
-
-static inline void blk_req_zone_write_unlock(struct request *rq)
-{
-	if (rq->rq_flags & RQF_ZONE_WRITE_LOCKED)
-		__blk_req_zone_write_unlock(rq);
-}
-
-static inline bool blk_req_zone_is_write_locked(struct request *rq)
-{
-	return rq->q->disk->seq_zones_wlock &&
-		test_bit(blk_rq_zone_no(rq), rq->q->disk->seq_zones_wlock);
-}
-
-static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
-{
-	if (!blk_req_needs_zone_write_lock(rq))
-		return true;
-	return !blk_req_zone_is_write_locked(rq);
-}
-#else /* CONFIG_BLK_DEV_ZONED */
-static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
-{
-	return false;
-}
-
-static inline bool blk_req_needs_zone_write_lock(struct request *rq)
-{
-	return false;
-}
-
-static inline void blk_req_zone_write_lock(struct request *rq)
-{
-}
-
-static inline void blk_req_zone_write_unlock(struct request *rq)
-{
-}
-static inline bool blk_req_zone_is_write_locked(struct request *rq)
-{
-	return false;
-}
-
-static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
-{
-	return true;
-}
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 #endif /* BLK_MQ_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ffe0c112b128..5751292fee6a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -297,7 +297,6 @@ enum {
 	BIO_QOS_THROTTLED,	/* bio went through rq_qos throttle path */
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
-	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
 	BIO_FLAG_LAST
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 045579474ed4..faacc9853e0b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -178,23 +178,14 @@ struct gendisk {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	/*
-	 * Zoned block device information for request dispatch control.
-	 * nr_zones is the total number of zones of the device. This is always
-	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
-	 * bits which indicates if a zone is conventional (bit set) or
-	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
-	 * bits which indicates if a zone is write locked, that is, if a write
-	 * request targeting the zone was dispatched.
-	 *
-	 * Reads of this information must be protected with blk_queue_enter() /
-	 * blk_queue_exit(). Modifying this information is only allowed while
-	 * no requests are being processed. See also blk_mq_freeze_queue() and
-	 * blk_mq_unfreeze_queue().
+	 * Zoned block device information. Reads of this information must be
+	 * protected with blk_queue_enter() / blk_queue_exit(). Modifying this
+	 * information is only allowed while no requests are being processed.
+	 * See also blk_mq_freeze_queue() and blk_mq_unfreeze_queue().
 	 */
 	unsigned int		nr_zones;
 	unsigned int		zone_capacity;
 	unsigned long		*conv_zones_bitmap;
-	unsigned long		*seq_zones_wlock;
 	unsigned int            zone_wplugs_hash_bits;
 	spinlock_t              zone_wplugs_lock;
 	mempool_t		*zone_wplugs_pool;
@@ -636,15 +627,6 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return sector >> ilog2(disk->queue->limits.chunk_sectors);
 }
 
-static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
-{
-	if (!blk_queue_is_zoned(disk->queue))
-		return false;
-	if (!disk->conv_zones_bitmap)
-		return true;
-	return !test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
-}
-
 static inline void disk_set_max_open_zones(struct gendisk *disk,
 		unsigned int max_open_zones)
 {
@@ -678,10 +660,6 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
 	return 0;
 }
-static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
-{
-	return false;
-}
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
@@ -871,11 +849,6 @@ static inline bool bio_straddles_zones(struct bio *bio)
 		disk_zone_no(bio->bi_bdev->bd_disk, bio_end_sector(bio) - 1);
 }
 
-static inline unsigned int bio_zone_is_seq(struct bio *bio)
-{
-	return disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector);
-}
-
 /*
  * Return how much of the chunk is left to be used for I/O at a given offset.
  */
-- 
2.44.0


