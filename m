Return-Path: <linux-scsi+bounces-4024-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8E896944
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA101F2B909
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0F82D68;
	Wed,  3 Apr 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAEZr8Nz"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB66D1AF;
	Wed,  3 Apr 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133802; cv=none; b=OFbIq8AQfMlM0cZfZW+gG0DuOjx93bMFAKLsop5+D9MFUXHqadb6hD/NJAoby5Fx9KM7l87lzXkmWI+2VkxAbvr8/zAffxeg35Pl0q4J+ULxkCSvHc++kx9wQjhQcmeoti171puzZmOfkX11p9d46fAKvl9xfkgqKiHfytTKvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133802; c=relaxed/simple;
	bh=5QWa4X8V1zDvXyIDE4UuQh75a2f+8WdHVAptSx7V4dA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNBSeNRx/Bz6qnQQMHSnLfUTgijGS/gUAkdc9CXV2XNc+hA5U94xNlljMD2C3FNW1rD1okmIIppfm8RS5iTOJgTd6gbydqOlQDD1nglouzTPGYFXLaokBYlnSEjW+059E7Qm9d5XRjbdpW5yd9k37GbZPuaZNyrOWrhZKVoNIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAEZr8Nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B675C43394;
	Wed,  3 Apr 2024 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133801;
	bh=5QWa4X8V1zDvXyIDE4UuQh75a2f+8WdHVAptSx7V4dA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rAEZr8NzMxg0wZ6VDR3qRb6nNb7JAJbq4ubDpuTd3V9YyVd/5ZSfJa5HMhpP8f30G
	 1DbGwo+RaGEoOA10EQQUgO9OmxibDd4TtT1sI/YjW1QF65P1IyMxDJfRvzcchep4Zz
	 LA4wcdkM9f5UGVIFGQsAkDOtZkk6BIHdKMC14VLOI4GWo1QPt9BCkzQTy7ZuzelXJQ
	 4/bQ1ysawxYIPl5Jejski7UfU8+wD6HdDubjeSVD4zTnpPrux8EGQvuC8Y6WlRLf9C
	 Os1qtGZb1D3P4iLusuxOf6u0i9kNEur0Av0GmJ9ghiMv0Lf1e443ZlOdiF+1S8Cegj
	 LEYkpHmcXH+aA==
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
Subject: [PATCH v5 20/28] block: Simplify blk_revalidate_disk_zones() interface
Date: Wed,  3 Apr 2024 17:42:39 +0900
Message-ID: <20240403084247.856481-21-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only user of blk_revalidate_disk_zones() second argument was the
SCSI disk driver (sd). Now that this driver does not require this
update_driver_data argument, remove it to simplify the interface of
blk_revalidate_disk_zones(). Also update the function kdoc comment to
be more accurate (i.e. there is no gendisk ->revalidate method).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c              | 21 +++++++--------------
 drivers/block/null_blk/zoned.c |  2 +-
 drivers/block/ublk_drv.c       |  2 +-
 drivers/block/virtio_blk.c     |  2 +-
 drivers/md/dm-zone.c           |  2 +-
 drivers/nvme/host/core.c       |  2 +-
 drivers/scsi/sd_zbc.c          |  2 +-
 include/linux/blkdev.h         |  3 +--
 8 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1441f7aa3036..8e821974d46b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1711,21 +1711,17 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 /**
  * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
  * @disk:	Target disk
- * @update_driver_data:	Callback to update driver data on the frozen disk
  *
- * Helper function for low-level device drivers to check and (re) allocate and
- * initialize a disk request queue zone bitmaps. This functions should normally
- * be called within the disk ->revalidate method for blk-mq based drivers.
+ * Helper function for low-level device drivers to check, (re) allocate and
+ * initialize resources used for managing zoned disks. This function should
+ * normally be called by blk-mq based drivers when a zoned gendisk is probed
+ * and when the zone configuration of the gendisk changes (e.g. after a format).
  * Before calling this function, the device driver must already have set the
  * device zone size (chunk_sector limit) and the max zone append limit.
  * BIO based drivers can also use this function as long as the device queue
  * can be safely frozen.
- * If the @update_driver_data callback function is not NULL, the callback is
- * executed with the device request queue frozen after all zones have been
- * checked.
  */
-int blk_revalidate_disk_zones(struct gendisk *disk,
-			      void (*update_driver_data)(struct gendisk *disk))
+int blk_revalidate_disk_zones(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	sector_t zone_sectors = q->limits.chunk_sectors;
@@ -1792,13 +1788,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 * referencing the bitmaps).
 	 */
 	blk_mq_freeze_queue(q);
-	if (ret > 0) {
+	if (ret > 0)
 		ret = disk_update_zone_resources(disk, &args);
-		if (update_driver_data)
-			update_driver_data(disk);
-	} else {
+	else
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-	}
 	if (ret)
 		disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 159746b0661c..34f4d273df38 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -179,7 +179,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 		disk->disk_name,
 		queue_emulates_zone_append(q) ? "emulated" : "native");
 
-	return blk_revalidate_disk_zones(disk, NULL);
+	return blk_revalidate_disk_zones(disk);
 }
 
 void null_free_zoned_dev(struct nullb_device *dev)
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ab6af84e327c..851c78913de2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -221,7 +221,7 @@ static int ublk_get_nr_zones(const struct ublk_device *ub)
 
 static int ublk_revalidate_disk_zones(struct ublk_device *ub)
 {
-	return blk_revalidate_disk_zones(ub->ub_disk, NULL);
+	return blk_revalidate_disk_zones(ub->ub_disk);
 }
 
 static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42dea7601d87..c1af0a7d56c8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1543,7 +1543,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	 */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && lim.zoned) {
 		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, vblk->disk->queue);
-		err = blk_revalidate_disk_zones(vblk->disk, NULL);
+		err = blk_revalidate_disk_zones(vblk->disk);
 		if (err)
 			goto out_cleanup_disk;
 	}
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 174fda0a301c..99d27fba01d3 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -169,7 +169,7 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 	 * our table for dm_blk_report_zones() to use directly.
 	 */
 	md->zone_revalidate_map = t;
-	ret = blk_revalidate_disk_zones(disk, NULL);
+	ret = blk_revalidate_disk_zones(disk);
 	md->zone_revalidate_map = NULL;
 
 	if (ret) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 943d72bdd794..c9955ecd1790 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2150,7 +2150,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
-		ret = blk_revalidate_disk_zones(ns->disk, NULL);
+		ret = blk_revalidate_disk_zones(ns->disk);
 		if (ret && !nvme_first_scan(ns->disk))
 			goto out;
 	}
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index d0ead9858954..806036e48abe 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -572,7 +572,7 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	blk_queue_max_zone_append_sectors(q, 0);
 
 	flags = memalloc_noio_save();
-	ret = blk_revalidate_disk_zones(disk, NULL);
+	ret = blk_revalidate_disk_zones(disk);
 	memalloc_noio_restore(flags);
 	if (ret) {
 		sdkp->zone_info = (struct zoned_disk_info){ };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7a621f23393f..19f59e0e5f29 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,8 +336,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
 int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		sector_t sectors, sector_t nr_sectors);
-int blk_revalidate_disk_zones(struct gendisk *disk,
-		void (*update_driver_data)(struct gendisk *disk));
+int blk_revalidate_disk_zones(struct gendisk *disk);
 
 /*
  * Independent access ranges: struct blk_independent_access_range describes
-- 
2.44.0


