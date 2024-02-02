Return-Path: <linux-scsi+bounces-2127-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8B3846960
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Feb 2024 08:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6C5B27F54
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Feb 2024 07:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A318EB8;
	Fri,  2 Feb 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwL33KNh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C818E2F;
	Fri,  2 Feb 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859082; cv=none; b=b16LvTsfKeq5VdH7iW0K+tSbSxRCvJoje8G/XMy2Ug0THyiJvNx1fSur8fczq91Qf9pzkhrqYsppGtYIYQwKtsFuq5iFaqUZdGN/WS62AB6PWKXPHhocQGrczVuPSIwkJqBjp3hO7s74PnGGatojmLdmDScKFtdtiBd/qB2+JNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859082; c=relaxed/simple;
	bh=+lcTqxkV7kUnTLtvJSw1J7QCLOzWYKJHAZLa0uoCg4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUQY0OYYuIiLKaWJz3bjSvZoHHoB8q+hJP71jo5hh2Cnz4ABJcEurzr+xk28YsuiTm7nBjLnEXC8JK7xGmKF8QrAefqqf5YtrPBp/G2CHI1T8RmysAdUj+DUgPCdemCGgDU9LEklnNSAyEDLagBUySZ2c3D5zVH3uRPs5bCyWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwL33KNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80171C43390;
	Fri,  2 Feb 2024 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706859081;
	bh=+lcTqxkV7kUnTLtvJSw1J7QCLOzWYKJHAZLa0uoCg4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwL33KNhVUa/XHKbGpGMKtC6ChFHz4xm4HI2V/MvYcrKvHONL1tJ7JZCkCg2ikBE6
	 tIQph1UWDKNeJhNJKA7RY6JpnAHQjyyWayyqBPHL/2bgOJATCDodMf4Rq02WbpvS3e
	 x4knX/iKjwfNZ5F9Dz7wbOmU2pSUXVCLeJSXSaAhwHqDemuk60QcBtFO9TwTJjQC9T
	 CmFNFvBo090rbttNPhDw32p5OosuO/zJy2dsMfvwre62OnhyT/NhW/woB5sM+xFhHM
	 d7KPBEK5n/yQDGqhbgKSi5tdF5/QoiPEHqAloZpY3yMMdQVF1HFU6YG85M/sNRxfiJ
	 x6fCjlSigyvOg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/26] dm: Use the block layer zone append emulation
Date: Fri,  2 Feb 2024 16:30:48 +0900
Message-ID: <20240202073104.2418230-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202073104.2418230-1-dlemoal@kernel.org>
References: <20240202073104.2418230-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For targets requiring zone append operation emulation with regular
writes (e.g. dm-crypt), we can use the block layer emulation provided by
zone write plugging. Remove DM implemented zone append emulation and
enable the block layer one.

This is done by setting the max_zone_append_sectors limit of the
mapped device queue to 0 for mapped devices that have a target table
that cannot support native zone append operations. These includes
mixed zoned and non-zoned targets, or targets that explicitly requested
emulation of zone append (e.g. dm-crypt). For these mapped devices, the
new field emulate_zone_append is set to true. dm_split_and_process_bio()
is modified to call blk_zone_write_plug_bio() for such device to let the
block layer transform zone append operations into regular writes. This
is done after ensuring that the submitted BIO is split if it straddles
zone boundaries.

dm_revalidate_zones() is also modified to use the block layer provided
function blk_revalidate_disk_zones() so that all zone resources needed
for zone append emulation are allocated and initialized by the block
layer without DM core needing to do anything. Since the device table is
not yet live when dm_revalidate_zones() is executed, enabling the use of
blk_revalidate_disk_zones() requires adding a pointer to the device
table in struct mapped_device. This avoids errors in
dm_blk_report_zones() trying to get the table with dm_get_live_table().
The mapped device table pointer is set to the table passed as argument
to dm_revalidate_zones() before calling blk_revalidate_disk_zones() and
reset to NULL after this function returns to restore the live table
handling for user call of report zones.

All the code related to zone append emulation is removed from
dm-zone.c. This leads to simplifications of the functions __map_bio()
and dm_zone_endio(). This later function now only needs to deal with
completions of real zone append operations for targets that support it.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/md/dm-core.h |  11 +-
 drivers/md/dm-zone.c | 470 ++++---------------------------------------
 drivers/md/dm.c      |  44 ++--
 drivers/md/dm.h      |   7 -
 4 files changed, 68 insertions(+), 464 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 095b9b49aa82..42d6b21e2395 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -138,7 +138,8 @@ struct mapped_device {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_zones;
-	unsigned int *zwp_offset;
+	bool emulate_zone_append;
+	void *zone_revalidate_map;
 #endif
 
 #ifdef CONFIG_IMA
@@ -158,7 +159,6 @@ struct mapped_device {
 #define DMF_DEFERRED_REMOVE 6
 #define DMF_SUSPENDED_INTERNALLY 7
 #define DMF_POST_SUSPENDING 8
-#define DMF_EMULATE_ZONE_APPEND 9
 
 void disable_discard(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
@@ -177,13 +177,6 @@ DECLARE_STATIC_KEY_FALSE(stats_enabled);
 DECLARE_STATIC_KEY_FALSE(swap_bios_enabled);
 DECLARE_STATIC_KEY_FALSE(zoned_enabled);
 
-static inline bool dm_emulate_zone_append(struct mapped_device *md)
-{
-	if (blk_queue_is_zoned(md->queue))
-		return test_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
-	return false;
-}
-
 #define DM_TABLE_MAX_DEPTH 16
 
 struct dm_table {
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index eb9832b22b14..570b44b924b8 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -60,16 +60,23 @@ int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 	struct dm_table *map;
 	int srcu_idx, ret;
 
-	if (dm_suspended_md(md))
-		return -EAGAIN;
+	if (!md->zone_revalidate_map) {
+		/* Regular user context */
+		if (dm_suspended_md(md))
+			return -EAGAIN;
 
-	map = dm_get_live_table(md, &srcu_idx);
-	if (!map)
-		return -EIO;
+		map = dm_get_live_table(md, &srcu_idx);
+		if (!map)
+			return -EIO;
+	} else {
+		/* Zone revalidation during __bind() */
+		map = md->zone_revalidate_map;
+	}
 
 	ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb, data);
 
-	dm_put_live_table(md, srcu_idx);
+	if (!md->zone_revalidate_map)
+		dm_put_live_table(md, srcu_idx);
 
 	return ret;
 }
@@ -138,85 +145,6 @@ bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
 	}
 }
 
-void dm_cleanup_zoned_dev(struct mapped_device *md)
-{
-	if (md->disk) {
-		bitmap_free(md->disk->conv_zones_bitmap);
-		md->disk->conv_zones_bitmap = NULL;
-		bitmap_free(md->disk->seq_zones_wlock);
-		md->disk->seq_zones_wlock = NULL;
-	}
-
-	kvfree(md->zwp_offset);
-	md->zwp_offset = NULL;
-	md->nr_zones = 0;
-}
-
-static unsigned int dm_get_zone_wp_offset(struct blk_zone *zone)
-{
-	switch (zone->cond) {
-	case BLK_ZONE_COND_IMP_OPEN:
-	case BLK_ZONE_COND_EXP_OPEN:
-	case BLK_ZONE_COND_CLOSED:
-		return zone->wp - zone->start;
-	case BLK_ZONE_COND_FULL:
-		return zone->len;
-	case BLK_ZONE_COND_EMPTY:
-	case BLK_ZONE_COND_NOT_WP:
-	case BLK_ZONE_COND_OFFLINE:
-	case BLK_ZONE_COND_READONLY:
-	default:
-		/*
-		 * Conventional, offline and read-only zones do not have a valid
-		 * write pointer. Use 0 as for an empty zone.
-		 */
-		return 0;
-	}
-}
-
-static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
-				 void *data)
-{
-	struct mapped_device *md = data;
-	struct gendisk *disk = md->disk;
-
-	switch (zone->type) {
-	case BLK_ZONE_TYPE_CONVENTIONAL:
-		if (!disk->conv_zones_bitmap) {
-			disk->conv_zones_bitmap = bitmap_zalloc(disk->nr_zones,
-								GFP_NOIO);
-			if (!disk->conv_zones_bitmap)
-				return -ENOMEM;
-		}
-		set_bit(idx, disk->conv_zones_bitmap);
-		break;
-	case BLK_ZONE_TYPE_SEQWRITE_REQ:
-	case BLK_ZONE_TYPE_SEQWRITE_PREF:
-		if (!disk->seq_zones_wlock) {
-			disk->seq_zones_wlock = bitmap_zalloc(disk->nr_zones,
-							      GFP_NOIO);
-			if (!disk->seq_zones_wlock)
-				return -ENOMEM;
-		}
-		if (!md->zwp_offset) {
-			md->zwp_offset =
-				kvcalloc(disk->nr_zones, sizeof(unsigned int),
-					 GFP_KERNEL);
-			if (!md->zwp_offset)
-				return -ENOMEM;
-		}
-		md->zwp_offset[idx] = dm_get_zone_wp_offset(zone);
-
-		break;
-	default:
-		DMERR("Invalid zone type 0x%x at sectors %llu",
-		      (int)zone->type, zone->start);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 /*
  * Revalidate the zones of a mapped device to initialize resource necessary
  * for zone append emulation. Note that we cannot simply use the block layer
@@ -226,41 +154,32 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
 static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 {
 	struct gendisk *disk = md->disk;
-	unsigned int noio_flag;
 	int ret;
 
-	/*
-	 * Check if something changed. If yes, cleanup the current resources
-	 * and reallocate everything.
-	 */
+	/* Revalidate ionly if something changed. */
 	if (!disk->nr_zones || disk->nr_zones != md->nr_zones)
-		dm_cleanup_zoned_dev(md);
+		md->nr_zones = 0;
+
 	if (md->nr_zones)
 		return 0;
 
 	/*
-	 * Scan all zones to initialize everything. Ensure that all vmalloc
-	 * operations in this context are done as if GFP_NOIO was specified.
+	 * Our table is not live yet. So the call to dm_get_live_table()
+	 * in dm_blk_report_zones() will fail. So set a temporary pointer to
+	 * our table for dm_blk_report_zones() to use directly.
 	 */
-	noio_flag = memalloc_noio_save();
-	ret = dm_blk_do_report_zones(md, t, 0, disk->nr_zones,
-				     dm_zone_revalidate_cb, md);
-	memalloc_noio_restore(noio_flag);
-	if (ret < 0)
-		goto err;
-	if (ret != disk->nr_zones) {
-		ret = -EIO;
-		goto err;
+	md->zone_revalidate_map = t;
+	ret = blk_revalidate_disk_zones(disk, NULL);
+	md->zone_revalidate_map = NULL;
+
+	if (ret) {
+		DMERR("Revalidate zones failed %d", ret);
+		return ret;
 	}
 
 	md->nr_zones = disk->nr_zones;
 
 	return 0;
-
-err:
-	DMERR("Revalidate zones failed %d", ret);
-	dm_cleanup_zoned_dev(md);
-	return ret;
 }
 
 static int device_not_zone_append_capable(struct dm_target *ti,
@@ -289,6 +208,7 @@ static bool dm_table_supports_zone_append(struct dm_table *t)
 int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 {
 	struct mapped_device *md = t->md;
+	int ret;
 
 	/*
 	 * For a zoned target, the number of zones should be updated for the
@@ -298,287 +218,29 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 	md->disk->nr_zones = bdev_nr_zones(md->disk->part0);
 
 	/* Check if zone append is natively supported */
-	if (dm_table_supports_zone_append(t)) {
-		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
-		dm_cleanup_zoned_dev(md);
+	if (dm_table_supports_zone_append(t))
 		return 0;
-	}
 
 	/*
-	 * Mark the mapped device as needing zone append emulation and
+	 * Set the mapped device queue as needing zone append emulation and
 	 * initialize the emulation resources once the capacity is set.
 	 */
-	set_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
+	md->emulate_zone_append = true;
+	blk_queue_max_zone_append_sectors(q, 0);
 	if (!get_capacity(md->disk))
 		return 0;
 
-	return dm_revalidate_zones(md, t);
-}
+	ret = dm_revalidate_zones(md, t);
+	if (ret)
+		return ret;
 
-static int dm_update_zone_wp_offset_cb(struct blk_zone *zone, unsigned int idx,
-				       void *data)
-{
-	unsigned int *wp_offset = data;
-
-	*wp_offset = dm_get_zone_wp_offset(zone);
+	DMINFO("%s using %s zone append",
+	       md->disk->disk_name,
+	       queue_emulates_zone_append(q) ? "emulated" : "native");
 
 	return 0;
 }
 
-static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
-				    unsigned int *wp_ofst)
-{
-	sector_t sector = zno * bdev_zone_sectors(md->disk->part0);
-	unsigned int noio_flag;
-	struct dm_table *t;
-	int srcu_idx, ret;
-
-	t = dm_get_live_table(md, &srcu_idx);
-	if (!t)
-		return -EIO;
-
-	/*
-	 * Ensure that all memory allocations in this context are done as if
-	 * GFP_NOIO was specified.
-	 */
-	noio_flag = memalloc_noio_save();
-	ret = dm_blk_do_report_zones(md, t, sector, 1,
-				     dm_update_zone_wp_offset_cb, wp_ofst);
-	memalloc_noio_restore(noio_flag);
-
-	dm_put_live_table(md, srcu_idx);
-
-	if (ret != 1)
-		return -EIO;
-
-	return 0;
-}
-
-struct orig_bio_details {
-	enum req_op op;
-	unsigned int nr_sectors;
-};
-
-/*
- * First phase of BIO mapping for targets with zone append emulation:
- * check all BIO that change a zone writer pointer and change zone
- * append operations into regular write operations.
- */
-static bool dm_zone_map_bio_begin(struct mapped_device *md,
-				  unsigned int zno, struct bio *clone)
-{
-	sector_t zsectors = bdev_zone_sectors(md->disk->part0);
-	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
-
-	/*
-	 * If the target zone is in an error state, recover by inspecting the
-	 * zone to get its current write pointer position. Note that since the
-	 * target zone is already locked, a BIO issuing context should never
-	 * see the zone write in the DM_ZONE_UPDATING_WP_OFST state.
-	 */
-	if (zwp_offset == DM_ZONE_INVALID_WP_OFST) {
-		if (dm_update_zone_wp_offset(md, zno, &zwp_offset))
-			return false;
-		WRITE_ONCE(md->zwp_offset[zno], zwp_offset);
-	}
-
-	switch (bio_op(clone)) {
-	case REQ_OP_ZONE_RESET:
-	case REQ_OP_ZONE_FINISH:
-		return true;
-	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE:
-		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
-			return false;
-		break;
-	case REQ_OP_ZONE_APPEND:
-		/*
-		 * Change zone append operations into a non-mergeable regular
-		 * writes directed at the current write pointer position of the
-		 * target zone.
-		 */
-		clone->bi_opf = REQ_OP_WRITE | REQ_NOMERGE |
-			(clone->bi_opf & (~REQ_OP_MASK));
-		clone->bi_iter.bi_sector += zwp_offset;
-		break;
-	default:
-		DMWARN_LIMIT("Invalid BIO operation");
-		return false;
-	}
-
-	/* Cannot write to a full zone */
-	if (zwp_offset >= zsectors)
-		return false;
-
-	return true;
-}
-
-/*
- * Second phase of BIO mapping for targets with zone append emulation:
- * update the zone write pointer offset array to account for the additional
- * data written to a zone. Note that at this point, the remapped clone BIO
- * may already have completed, so we do not touch it.
- */
-static blk_status_t dm_zone_map_bio_end(struct mapped_device *md, unsigned int zno,
-					struct orig_bio_details *orig_bio_details,
-					unsigned int nr_sectors)
-{
-	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
-
-	/* The clone BIO may already have been completed and failed */
-	if (zwp_offset == DM_ZONE_INVALID_WP_OFST)
-		return BLK_STS_IOERR;
-
-	/* Update the zone wp offset */
-	switch (orig_bio_details->op) {
-	case REQ_OP_ZONE_RESET:
-		WRITE_ONCE(md->zwp_offset[zno], 0);
-		return BLK_STS_OK;
-	case REQ_OP_ZONE_FINISH:
-		WRITE_ONCE(md->zwp_offset[zno],
-			   bdev_zone_sectors(md->disk->part0));
-		return BLK_STS_OK;
-	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE:
-		WRITE_ONCE(md->zwp_offset[zno], zwp_offset + nr_sectors);
-		return BLK_STS_OK;
-	case REQ_OP_ZONE_APPEND:
-		/*
-		 * Check that the target did not truncate the write operation
-		 * emulating a zone append.
-		 */
-		if (nr_sectors != orig_bio_details->nr_sectors) {
-			DMWARN_LIMIT("Truncated write for zone append");
-			return BLK_STS_IOERR;
-		}
-		WRITE_ONCE(md->zwp_offset[zno], zwp_offset + nr_sectors);
-		return BLK_STS_OK;
-	default:
-		DMWARN_LIMIT("Invalid BIO operation");
-		return BLK_STS_IOERR;
-	}
-}
-
-static inline void dm_zone_lock(struct gendisk *disk, unsigned int zno,
-				struct bio *clone)
-{
-	if (WARN_ON_ONCE(bio_flagged(clone, BIO_ZONE_WRITE_LOCKED)))
-		return;
-
-	wait_on_bit_lock_io(disk->seq_zones_wlock, zno, TASK_UNINTERRUPTIBLE);
-	bio_set_flag(clone, BIO_ZONE_WRITE_LOCKED);
-}
-
-static inline void dm_zone_unlock(struct gendisk *disk, unsigned int zno,
-				  struct bio *clone)
-{
-	if (!bio_flagged(clone, BIO_ZONE_WRITE_LOCKED))
-		return;
-
-	WARN_ON_ONCE(!test_bit(zno, disk->seq_zones_wlock));
-	clear_bit_unlock(zno, disk->seq_zones_wlock);
-	smp_mb__after_atomic();
-	wake_up_bit(disk->seq_zones_wlock, zno);
-
-	bio_clear_flag(clone, BIO_ZONE_WRITE_LOCKED);
-}
-
-static bool dm_need_zone_wp_tracking(struct bio *bio)
-{
-	/*
-	 * Special processing is not needed for operations that do not need the
-	 * zone write lock, that is, all operations that target conventional
-	 * zones and all operations that do not modify directly a sequential
-	 * zone write pointer.
-	 */
-	if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
-		return false;
-	switch (bio_op(bio)) {
-	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE:
-	case REQ_OP_ZONE_RESET:
-	case REQ_OP_ZONE_FINISH:
-	case REQ_OP_ZONE_APPEND:
-		return bio_zone_is_seq(bio);
-	default:
-		return false;
-	}
-}
-
-/*
- * Special IO mapping for targets needing zone append emulation.
- */
-int dm_zone_map_bio(struct dm_target_io *tio)
-{
-	struct dm_io *io = tio->io;
-	struct dm_target *ti = tio->ti;
-	struct mapped_device *md = io->md;
-	struct bio *clone = &tio->clone;
-	struct orig_bio_details orig_bio_details;
-	unsigned int zno;
-	blk_status_t sts;
-	int r;
-
-	/*
-	 * IOs that do not change a zone write pointer do not need
-	 * any additional special processing.
-	 */
-	if (!dm_need_zone_wp_tracking(clone))
-		return ti->type->map(ti, clone);
-
-	/* Lock the target zone */
-	zno = bio_zone_no(clone);
-	dm_zone_lock(md->disk, zno, clone);
-
-	orig_bio_details.nr_sectors = bio_sectors(clone);
-	orig_bio_details.op = bio_op(clone);
-
-	/*
-	 * Check that the bio and the target zone write pointer offset are
-	 * both valid, and if the bio is a zone append, remap it to a write.
-	 */
-	if (!dm_zone_map_bio_begin(md, zno, clone)) {
-		dm_zone_unlock(md->disk, zno, clone);
-		return DM_MAPIO_KILL;
-	}
-
-	/* Let the target do its work */
-	r = ti->type->map(ti, clone);
-	switch (r) {
-	case DM_MAPIO_SUBMITTED:
-		/*
-		 * The target submitted the clone BIO. The target zone will
-		 * be unlocked on completion of the clone.
-		 */
-		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
-					  *tio->len_ptr);
-		break;
-	case DM_MAPIO_REMAPPED:
-		/*
-		 * The target only remapped the clone BIO. In case of error,
-		 * unlock the target zone here as the clone will not be
-		 * submitted.
-		 */
-		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
-					  *tio->len_ptr);
-		if (sts != BLK_STS_OK)
-			dm_zone_unlock(md->disk, zno, clone);
-		break;
-	case DM_MAPIO_REQUEUE:
-	case DM_MAPIO_KILL:
-	default:
-		dm_zone_unlock(md->disk, zno, clone);
-		sts = BLK_STS_IOERR;
-		break;
-	}
-
-	if (sts != BLK_STS_OK)
-		return DM_MAPIO_KILL;
-
-	return r;
-}
-
 /*
  * IO completion callback called from clone_endio().
  */
@@ -587,61 +249,17 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 	struct mapped_device *md = io->md;
 	struct gendisk *disk = md->disk;
 	struct bio *orig_bio = io->orig_bio;
-	unsigned int zwp_offset;
-	unsigned int zno;
 
 	/*
-	 * For targets that do not emulate zone append, we only need to
-	 * handle native zone-append bios.
+	 * Get the offset within the zone of the written sector
+	 * and add that to the original bio sector position.
 	 */
-	if (!dm_emulate_zone_append(md)) {
-		/*
-		 * Get the offset within the zone of the written sector
-		 * and add that to the original bio sector position.
-		 */
-		if (clone->bi_status == BLK_STS_OK &&
-		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask =
-				(sector_t)bdev_zone_sectors(disk->part0) - 1;
-
-			orig_bio->bi_iter.bi_sector +=
-				clone->bi_iter.bi_sector & mask;
-		}
-
-		return;
-	}
+	if (clone->bi_status == BLK_STS_OK &&
+	    bio_op(clone) == REQ_OP_ZONE_APPEND) {
+		sector_t mask = bdev_zone_sectors(disk->part0) - 1;
 
-	/*
-	 * For targets that do emulate zone append, if the clone BIO does not
-	 * own the target zone write lock, we have nothing to do.
-	 */
-	if (!bio_flagged(clone, BIO_ZONE_WRITE_LOCKED))
-		return;
-
-	zno = bio_zone_no(orig_bio);
-
-	if (clone->bi_status != BLK_STS_OK) {
-		/*
-		 * BIOs that modify a zone write pointer may leave the zone
-		 * in an unknown state in case of failure (e.g. the write
-		 * pointer was only partially advanced). In this case, set
-		 * the target zone write pointer as invalid unless it is
-		 * already being updated.
-		 */
-		WRITE_ONCE(md->zwp_offset[zno], DM_ZONE_INVALID_WP_OFST);
-	} else if (bio_op(orig_bio) == REQ_OP_ZONE_APPEND) {
-		/*
-		 * Get the written sector for zone append operation that were
-		 * emulated using regular write operations.
-		 */
-		zwp_offset = READ_ONCE(md->zwp_offset[zno]);
-		if (WARN_ON_ONCE(zwp_offset < bio_sectors(orig_bio)))
-			WRITE_ONCE(md->zwp_offset[zno],
-				   DM_ZONE_INVALID_WP_OFST);
-		else
-			orig_bio->bi_iter.bi_sector +=
-				zwp_offset - bio_sectors(orig_bio);
+		orig_bio->bi_iter.bi_sector += clone->bi_iter.bi_sector & mask;
 	}
 
-	dm_zone_unlock(disk, zno, clone);
+	return;
 }
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8dcabf84d866..92ce3b2eb4ae 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1419,25 +1419,12 @@ static void __map_bio(struct bio *clone)
 		down(&md->swap_bios_semaphore);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled)) {
-		/*
-		 * Check if the IO needs a special mapping due to zone append
-		 * emulation on zoned target. In this case, dm_zone_map_bio()
-		 * calls the target map operation.
-		 */
-		if (unlikely(dm_emulate_zone_append(md)))
-			r = dm_zone_map_bio(tio);
-		else
-			goto do_map;
-	} else {
-do_map:
-		if (likely(ti->type->map == linear_map))
-			r = linear_map(ti, clone);
-		else if (ti->type->map == stripe_map)
-			r = stripe_map(ti, clone);
-		else
-			r = ti->type->map(ti, clone);
-	}
+	if (likely(ti->type->map == linear_map))
+		r = linear_map(ti, clone);
+	else if (ti->type->map == stripe_map)
+		r = stripe_map(ti, clone);
+	else
+		r = ti->type->map(ti, clone);
 
 	switch (r) {
 	case DM_MAPIO_SUBMITTED:
@@ -1774,19 +1761,33 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	struct clone_info ci;
 	struct dm_io *io;
 	blk_status_t error = BLK_STS_OK;
-	bool is_abnormal;
+	bool is_abnormal, need_split;
 
 	is_abnormal = is_abnormal_io(bio);
-	if (unlikely(is_abnormal)) {
+	if (likely(!md->emulate_zone_append))
+		need_split = is_abnormal;
+	else
+		need_split = is_abnormal || bio_straddle_zones(bio);
+	if (unlikely(need_split)) {
 		/*
 		 * Use bio_split_to_limits() for abnormal IO (e.g. discard, etc)
 		 * otherwise associated queue_limits won't be imposed.
+		 * Also split the BIO for mapped devices needing zone append
+		 * emulation to ensure that the BIO does not cross zone
+		 * boundaries.
 		 */
 		bio = bio_split_to_limits(bio);
 		if (!bio)
 			return;
 	}
 
+	/*
+	 * Use the block layer zone write plugging for mapped devices that
+	 * need zone append emulation (e.g. dm-crypt).
+	 */
+	if (md->emulate_zone_append && blk_zone_write_plug_bio(bio, 0))
+		return;
+
 	/* Only support nowait for normal IO */
 	if (unlikely(bio->bi_opf & REQ_NOWAIT) && !is_abnormal) {
 		io = alloc_io(md, bio, GFP_NOWAIT);
@@ -2007,7 +2008,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		md->dax_dev = NULL;
 	}
 
-	dm_cleanup_zoned_dev(md);
 	if (md->disk) {
 		spin_lock(&_minor_lock);
 		md->disk->private_data = NULL;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 7f1acbf6bd9e..08a7c34eeca0 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -104,22 +104,15 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
 int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q);
 void dm_zone_endio(struct dm_io *io, struct bio *clone);
 #ifdef CONFIG_BLK_DEV_ZONED
-void dm_cleanup_zoned_dev(struct mapped_device *md);
 int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 bool dm_is_zone_write(struct mapped_device *md, struct bio *bio);
-int dm_zone_map_bio(struct dm_target_io *io);
 #else
-static inline void dm_cleanup_zoned_dev(struct mapped_device *md) {}
 #define dm_blk_report_zones	NULL
 static inline bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
 {
 	return false;
 }
-static inline int dm_zone_map_bio(struct dm_target_io *tio)
-{
-	return DM_MAPIO_KILL;
-}
 #endif
 
 /*
-- 
2.43.0


