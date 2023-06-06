Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B10B723A55
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Jun 2023 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjFFHqc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Jun 2023 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbjFFHo1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Jun 2023 03:44:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BEB10F6;
        Tue,  6 Jun 2023 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ToYe8ZYSwKXL6KxAabxVX7gj2QangdD/3MTwXV+JCCo=; b=VbRcYrPCeI6JQFBN2MYAGq3Yzp
        PjCRbgrqNJTOsbUk53iAarlPlzljgrVqJvuCddxWzgsDrdB3Ol0MDqv5pAIWqYcm92VNDZA6Y/tJd
        tjGfl1zEOmv5rlHURxcBiYebr9XzJgzY27zwYkEMaFnO7Bqmw6i3/cpvqBjW2s+wVwbLIY6p8MN4r
        6cv7y3FYispHYUpENx5YV5gnQbIZ8p8UOAKpmf8ycoY4oxurTwEmuEuoZm3FWpRwi1LfvUxp9IQ4U
        zdp281W59BLNMeiV4nPJ6AeZl2ySwc2g/JC9vgAepK4YYGGmLa4LSbo+sGJAuAI5ylt1co1huXL7j
        AfH4h/+w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RJj-000a2o-17;
        Tue, 06 Jun 2023 07:41:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 28/31] block: replace fmode_t with a block-specific type for block open flags
Date:   Tue,  6 Jun 2023 09:39:47 +0200
Message-Id: <20230606073950.225178-29-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The only overlap between the block open flags mapped into the fmode_t and
other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new
blk_mode_t instead for use in blkdev_get_by_*, ->open and ->ioctl and
stop abusing fmode_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c          |  8 +++---
 arch/xtensa/platforms/iss/simdisk.c |  2 +-
 block/bdev.c                        | 32 +++++++++++-----------
 block/blk-zoned.c                   |  8 +++---
 block/blk.h                         | 11 ++++----
 block/fops.c                        | 26 +++++++++++++-----
 block/genhd.c                       |  8 +++---
 block/ioctl.c                       | 42 +++++++++--------------------
 drivers/block/amiflop.c             | 12 ++++-----
 drivers/block/aoe/aoeblk.c          |  4 +--
 drivers/block/ataflop.c             | 25 +++++++++--------
 drivers/block/drbd/drbd_main.c      |  7 ++---
 drivers/block/drbd/drbd_nl.c        |  2 +-
 drivers/block/floppy.c              | 28 +++++++++----------
 drivers/block/loop.c                | 22 +++++++--------
 drivers/block/mtip32xx/mtip32xx.c   |  4 +--
 drivers/block/nbd.c                 |  4 +--
 drivers/block/pktcdvd.c             | 17 ++++++------
 drivers/block/rbd.c                 |  2 +-
 drivers/block/rnbd/rnbd-clt.c       |  4 +--
 drivers/block/rnbd/rnbd-srv.c       |  4 +--
 drivers/block/sunvdc.c              |  2 +-
 drivers/block/swim.c                | 16 +++++------
 drivers/block/swim3.c               | 24 ++++++++---------
 drivers/block/ublk_drv.c            |  2 +-
 drivers/block/xen-blkback/xenbus.c  |  2 +-
 drivers/block/xen-blkfront.c        |  2 +-
 drivers/block/z2ram.c               |  2 +-
 drivers/block/zram/zram_drv.c       |  6 ++---
 drivers/cdrom/cdrom.c               |  4 +--
 drivers/cdrom/gdrom.c               |  4 +--
 drivers/md/bcache/bcache.h          |  2 +-
 drivers/md/bcache/request.c         |  4 +--
 drivers/md/bcache/super.c           |  6 ++---
 drivers/md/dm-cache-target.c        | 12 ++++-----
 drivers/md/dm-clone-target.c        | 10 +++----
 drivers/md/dm-core.h                |  7 +++--
 drivers/md/dm-era-target.c          |  6 +++--
 drivers/md/dm-ioctl.c               | 10 +++----
 drivers/md/dm-snap.c                |  4 +--
 drivers/md/dm-table.c               | 11 ++++----
 drivers/md/dm-thin.c                |  9 ++++---
 drivers/md/dm-verity-fec.c          |  2 +-
 drivers/md/dm-verity-target.c       |  6 ++---
 drivers/md/dm.c                     | 10 +++----
 drivers/md/dm.h                     |  2 +-
 drivers/md/md.c                     |  8 +++---
 drivers/mmc/core/block.c            |  8 +++---
 drivers/mtd/devices/block2mtd.c     |  4 +--
 drivers/mtd/mtd_blkdevs.c           |  4 +--
 drivers/mtd/ubi/block.c             |  5 ++--
 drivers/nvme/host/core.c            |  2 +-
 drivers/nvme/host/ioctl.c           |  8 +++---
 drivers/nvme/host/multipath.c       |  2 +-
 drivers/nvme/host/nvme.h            |  4 +--
 drivers/nvme/target/io-cmd-bdev.c   |  2 +-
 drivers/s390/block/dasd.c           |  6 ++---
 drivers/s390/block/dasd_genhd.c     |  3 ++-
 drivers/s390/block/dasd_int.h       |  3 ++-
 drivers/s390/block/dasd_ioctl.c     |  2 +-
 drivers/s390/block/dcssblk.c        |  4 +--
 drivers/scsi/sd.c                   | 19 ++++++-------
 drivers/scsi/sr.c                   | 10 +++----
 drivers/target/target_core_iblock.c |  5 ++--
 drivers/target/target_core_pscsi.c  |  4 +--
 fs/btrfs/dev-replace.c              |  2 +-
 fs/btrfs/super.c                    |  4 +--
 fs/btrfs/volumes.c                  | 16 +++++------
 fs/btrfs/volumes.h                  |  4 +--
 fs/erofs/super.c                    |  2 +-
 fs/ext4/super.c                     |  2 +-
 fs/jfs/jfs_logmgr.c                 |  2 +-
 fs/nfs/blocklayout/dev.c            |  5 ++--
 fs/ocfs2/cluster/heartbeat.c        |  3 ++-
 fs/reiserfs/journal.c               |  4 +--
 fs/xfs/xfs_super.c                  |  2 +-
 include/linux/blkdev.h              | 30 ++++++++++++++++-----
 include/linux/cdrom.h               |  3 ++-
 include/linux/device-mapper.h       |  8 +++---
 kernel/power/swap.c                 |  6 ++---
 mm/swapfile.c                       |  2 +-
 81 files changed, 324 insertions(+), 311 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 20c1a16199c503..50206feac577d5 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -108,9 +108,9 @@ static inline void ubd_set_bit(__u64 bit, unsigned char *data)
 static DEFINE_MUTEX(ubd_lock);
 static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
 
-static int ubd_open(struct gendisk *disk, fmode_t mode);
+static int ubd_open(struct gendisk *disk, blk_mode_t mode);
 static void ubd_release(struct gendisk *disk);
-static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
+static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg);
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
@@ -1154,7 +1154,7 @@ static int __init ubd_driver_init(void){
 
 device_initcall(ubd_driver_init);
 
-static int ubd_open(struct gendisk *disk, fmode_t mode)
+static int ubd_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct ubd *ubd_dev = disk->private_data;
 	int err = 0;
@@ -1389,7 +1389,7 @@ static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
+static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg)
 {
 	struct ubd *ubd_dev = bdev->bd_disk->private_data;
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 2ad9da3de0d90f..178cf96ca10acb 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -120,7 +120,7 @@ static void simdisk_submit_bio(struct bio *bio)
 	bio_endio(bio);
 }
 
-static int simdisk_open(struct gendisk *disk, fmode_t mode)
+static int simdisk_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct simdisk *dev = disk->private_data;
 
diff --git a/block/bdev.c b/block/bdev.c
index db63e5bcc46ffa..bd558a9ba3cd97 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -93,7 +93,7 @@ EXPORT_SYMBOL(invalidate_bdev);
  * Drop all buffers & page cache for given bdev range. This function bails
  * with error if bdev has other exclusive owner (such as filesystem).
  */
-int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
+int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 			loff_t lstart, loff_t lend)
 {
 	/*
@@ -101,14 +101,14 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
 	 * while we discard the buffer cache to avoid discarding buffers
 	 * under live filesystem.
 	 */
-	if (!(mode & FMODE_EXCL)) {
+	if (!(mode & BLK_OPEN_EXCL)) {
 		int err = bd_prepare_to_claim(bdev, truncate_bdev_range, NULL);
 		if (err)
 			goto invalidate;
 	}
 
 	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
-	if (!(mode & FMODE_EXCL))
+	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
 
@@ -647,7 +647,7 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 	bdev_write_inode(bdev);
 }
 
-static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
+static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
@@ -679,7 +679,7 @@ static void blkdev_put_whole(struct block_device *bdev)
 		bdev->bd_disk->fops->release(bdev->bd_disk);
 }
 
-static int blkdev_get_part(struct block_device *part, fmode_t mode)
+static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
 {
 	struct gendisk *disk = part->bd_disk;
 	int ret;
@@ -743,11 +743,11 @@ void blkdev_put_no_open(struct block_device *bdev)
 {
 	put_device(&bdev->bd_device);
 }
-
+	
 /**
  * blkdev_get_by_dev - open a block device by device number
  * @dev: device number of block device to open
- * @mode: FMODE_* mask
+ * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
  * @hops: holder operations
  *
@@ -765,7 +765,7 @@ void blkdev_put_no_open(struct block_device *bdev)
  * RETURNS:
  * Reference to the block_device on success, ERR_PTR(-errno) on failure.
  */
-struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
+struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops)
 {
 	bool unblock_events = true;
@@ -775,8 +775,8 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 
 	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
 			MAJOR(dev), MINOR(dev),
-			((mode & FMODE_READ) ? DEVCG_ACC_READ : 0) |
-			((mode & FMODE_WRITE) ? DEVCG_ACC_WRITE : 0));
+			((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
+			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -786,12 +786,12 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 	disk = bdev->bd_disk;
 
 	if (holder) {
-		mode |= FMODE_EXCL;
+		mode |= BLK_OPEN_EXCL;
 		ret = bd_prepare_to_claim(bdev, holder, hops);
 		if (ret)
 			goto put_blkdev;
 	} else {
-		if (WARN_ON_ONCE(mode & FMODE_EXCL)) {
+		if (WARN_ON_ONCE(mode & BLK_OPEN_EXCL)) {
 			ret = -EIO;
 			goto put_blkdev;
 		}
@@ -821,7 +821,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 		 * writeable reference is too fragile given the way @mode is
 		 * used in blkdev_get/put().
 		 */
-		if ((mode & FMODE_WRITE) && !bdev->bd_write_holder &&
+		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
 		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
 			bdev->bd_write_holder = true;
 			unblock_events = false;
@@ -848,7 +848,7 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
 /**
  * blkdev_get_by_path - open a block device by name
  * @path: path to the block device to open
- * @mode: FMODE_* mask
+ * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
  *
  * Open the block device described by the device file at @path.  If @holder is
@@ -861,7 +861,7 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
  * RETURNS:
  * Reference to the block_device on success, ERR_PTR(-errno) on failure.
  */
-struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
+struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops)
 {
 	struct block_device *bdev;
@@ -873,7 +873,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 		return ERR_PTR(error);
 
 	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
-	if (!IS_ERR(bdev) && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
+	if (!IS_ERR(bdev) && (mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
 		blkdev_put(bdev, holder);
 		return ERR_PTR(-EACCES);
 	}
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 02cc2c629ac9be..0f9f97cdddd99c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -356,8 +356,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 	return 0;
 }
 
-static int blkdev_truncate_zone_range(struct block_device *bdev, fmode_t mode,
-				      const struct blk_zone_range *zrange)
+static int blkdev_truncate_zone_range(struct block_device *bdev,
+		blk_mode_t mode, const struct blk_zone_range *zrange)
 {
 	loff_t start, end;
 
@@ -376,7 +376,7 @@ static int blkdev_truncate_zone_range(struct block_device *bdev, fmode_t mode,
  * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
  * Called from blkdev_ioctl.
  */
-int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
+int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -390,7 +390,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!bdev_is_zoned(bdev))
 		return -ENOTTY;
 
-	if (!(mode & FMODE_WRITE))
+	if (!(mode & BLK_OPEN_WRITE))
 		return -EBADF;
 
 	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
diff --git a/block/blk.h b/block/blk.h
index e28d5d67d31a28..768852a84fefb3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -396,7 +396,7 @@ void disk_free_zone_bitmaps(struct gendisk *disk);
 void disk_clear_zone_settings(struct gendisk *disk);
 int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 		unsigned long arg);
-int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
+int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
@@ -407,7 +407,7 @@ static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
 	return -ENOTTY;
 }
 static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
-		fmode_t mode, unsigned int cmd, unsigned long arg)
+		blk_mode_t mode, unsigned int cmd, unsigned long arg)
 {
 	return -ENOTTY;
 }
@@ -451,7 +451,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 
 struct request_queue *blk_alloc_queue(int node_id);
 
-int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
+int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
 
 int disk_alloc_events(struct gendisk *disk);
 void disk_add_events(struct gendisk *disk);
@@ -466,8 +466,9 @@ extern struct device_attribute dev_attr_events_poll_msecs;
 
 extern struct attribute_group blk_trace_attr_group;
 
-int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-		loff_t lend);
+blk_mode_t file_to_blk_mode(struct file *file);
+int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
+		loff_t lstart, loff_t lend);
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/block/fops.c b/block/fops.c
index 9f26e25bafa172..928c37a214f785 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -470,6 +470,24 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 	return error;
 }
 
+blk_mode_t file_to_blk_mode(struct file *file)
+{
+	blk_mode_t mode = 0;
+
+	if (file->f_mode & FMODE_READ)
+		mode |= BLK_OPEN_READ;
+	if (file->f_mode & FMODE_WRITE)
+		mode |= BLK_OPEN_WRITE;
+	if (file->f_mode & FMODE_EXCL)
+		mode |= BLK_OPEN_EXCL;
+	if ((file->f_flags & O_ACCMODE) == 3)
+		mode |= BLK_OPEN_WRITE_IOCTL;
+	if (file->f_flags & O_NDELAY)
+		mode |= BLK_OPEN_NDELAY;
+
+	return mode;
+}
+
 static int blkdev_open(struct inode *inode, struct file *filp)
 {
 	struct block_device *bdev;
@@ -483,14 +501,10 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	filp->f_flags |= O_LARGEFILE;
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
-	if (filp->f_flags & O_NDELAY)
-		filp->f_mode |= FMODE_NDELAY;
 	if (filp->f_flags & O_EXCL)
 		filp->f_mode |= FMODE_EXCL;
-	if ((filp->f_flags & O_ACCMODE) == 3)
-		filp->f_mode |= FMODE_WRITE_IOCTL;
 
-	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode,
+	bdev = blkdev_get_by_dev(inode->i_rdev, file_to_blk_mode(filp),
 				 (filp->f_mode & FMODE_EXCL) ? filp : NULL,
 				 NULL);
 	if (IS_ERR(bdev))
@@ -648,7 +662,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
+	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
 	if (error)
 		goto fail;
 
diff --git a/block/genhd.c b/block/genhd.c
index b56f8b5c88b3e3..2c2f9a7168223f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -339,7 +339,7 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
 }
 EXPORT_SYMBOL_GPL(disk_uevent);
 
-int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
+int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 {
 	struct block_device *bdev;
 	int ret = 0;
@@ -357,7 +357,7 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	 * synchronize with other exclusive openers and other partition
 	 * scanners.
 	 */
-	if (!(mode & FMODE_EXCL)) {
+	if (!(mode & BLK_OPEN_EXCL)) {
 		ret = bd_prepare_to_claim(disk->part0, disk_scan_partitions,
 					  NULL);
 		if (ret)
@@ -377,7 +377,7 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	 * creat partition for underlying disk.
 	 */
 	clear_bit(GD_NEED_PART_SCAN, &disk->state);
-	if (!(mode & FMODE_EXCL))
+	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(disk->part0, disk_scan_partitions);
 	return ret;
 }
@@ -505,7 +505,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 
 		bdev_add(disk->part0, ddev->devt);
 		if (get_capacity(disk))
-			disk_scan_partitions(disk, FMODE_READ);
+			disk_scan_partitions(disk, BLK_OPEN_READ);
 
 		/*
 		 * Announce the disk and partitions after all partitions are
diff --git a/block/ioctl.c b/block/ioctl.c
index 3a10c34b8ef6d3..61bb94fd428187 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -82,7 +82,7 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
 }
 #endif
 
-static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
+static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
@@ -90,7 +90,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	struct inode *inode = bdev->bd_inode;
 	int err;
 
-	if (!(mode & FMODE_WRITE))
+	if (!(mode & BLK_OPEN_WRITE))
 		return -EBADF;
 
 	if (!bdev_max_discard_sectors(bdev))
@@ -120,14 +120,14 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
-static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t mode,
+static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
 	uint64_t start, len;
 	uint64_t range[2];
 	int err;
 
-	if (!(mode & FMODE_WRITE))
+	if (!(mode & BLK_OPEN_WRITE))
 		return -EBADF;
 	if (!bdev_max_secure_erase_sectors(bdev))
 		return -EOPNOTSUPP;
@@ -151,7 +151,7 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t mode,
 }
 
 
-static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
+static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
@@ -159,7 +159,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 	struct inode *inode = bdev->bd_inode;
 	int err;
 
-	if (!(mode & FMODE_WRITE))
+	if (!(mode & BLK_OPEN_WRITE))
 		return -EBADF;
 
 	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
@@ -240,7 +240,7 @@ static int compat_put_ulong(compat_ulong_t __user *argp, compat_ulong_t val)
  * drivers that implement only commands that are completely compatible
  * between 32-bit and 64-bit user space
  */
-int blkdev_compat_ptr_ioctl(struct block_device *bdev, fmode_t mode,
+int blkdev_compat_ptr_ioctl(struct block_device *bdev, blk_mode_t mode,
 			unsigned cmd, unsigned long arg)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -439,7 +439,7 @@ static int compat_hdio_getgeo(struct block_device *bdev,
 #endif
 
 /* set the logical block size */
-static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
+static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		int __user *argp)
 {
 	int ret, n;
@@ -451,7 +451,7 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 	if (get_user(n, argp))
 		return -EFAULT;
 
-	if (mode & FMODE_EXCL)
+	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
 	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode, &bdev, NULL)))
@@ -467,7 +467,7 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
  * user space. Note the separate arg/argp parameters that are needed
  * to deal with the compat_ptr() conversion.
  */
-static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
+static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 			       unsigned int cmd, unsigned long arg,
 			       void __user *argp)
 {
@@ -560,18 +560,9 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	void __user *argp = (void __user *)arg;
-	fmode_t mode = file->f_mode;
+	blk_mode_t mode = file_to_blk_mode(file);
 	int ret;
 
-	/*
-	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
-	 * to updated it before every ioctl.
-	 */
-	if (file->f_flags & O_NDELAY)
-		mode |= FMODE_NDELAY;
-	else
-		mode &= ~FMODE_NDELAY;
-
 	switch (cmd) {
 	/* These need separate implementations for the data structure */
 	case HDIO_GETGEO:
@@ -630,16 +621,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	void __user *argp = compat_ptr(arg);
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	struct gendisk *disk = bdev->bd_disk;
-	fmode_t mode = file->f_mode;
-
-	/*
-	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
-	 * to updated it before every ioctl.
-	 */
-	if (file->f_flags & O_NDELAY)
-		mode |= FMODE_NDELAY;
-	else
-		mode &= ~FMODE_NDELAY;
+	blk_mode_t mode = file_to_blk_mode(file);
 
 	switch (cmd) {
 	/* These need separate implementations for the data structure */
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 9a0e9dc74a8c57..e460c9799d9f35 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1532,7 +1532,7 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
+static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		    unsigned int cmd, unsigned long param)
 {
 	struct amiga_floppy_struct *p = bdev->bd_disk->private_data;
@@ -1607,7 +1607,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 	return 0;
 }
 
-static int fd_ioctl(struct block_device *bdev, fmode_t mode,
+static int fd_ioctl(struct block_device *bdev, blk_mode_t mode,
 			     unsigned int cmd, unsigned long param)
 {
 	int ret;
@@ -1654,7 +1654,7 @@ static void fd_probe(int dev)
  * /dev/PS0 etc), and disallows simultaneous access to the same
  * drive with different device numbers.
  */
-static int floppy_open(struct gendisk *disk, fmode_t mode)
+static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int drive = disk->first_minor & 3;
 	int system = (disk->first_minor & 4) >> 2;
@@ -1673,10 +1673,9 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 		mutex_unlock(&amiflop_mutex);
 		return -ENXIO;
 	}
-
-	if (mode & (FMODE_READ|FMODE_WRITE)) {
+	if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
 		disk_check_media_change(disk);
-		if (mode & FMODE_WRITE) {
+		if (mode & BLK_OPEN_WRITE) {
 			int wrprot;
 
 			get_fdc(drive);
@@ -1691,7 +1690,6 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 			}
 		}
 	}
-
 	local_irq_save(flags);
 	fd_ref[drive]++;
 	fd_device[drive] = system;
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index c3a39e02ab9571..cf6883756155a3 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -204,7 +204,7 @@ aoedisk_rm_debugfs(struct aoedev *d)
 }
 
 static int
-aoeblk_open(struct gendisk *disk, fmode_t mode)
+aoeblk_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct aoedev *d = disk->private_data;
 	ulong flags;
@@ -285,7 +285,7 @@ aoeblk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 static int
-aoeblk_ioctl(struct block_device *bdev, fmode_t mode, uint cmd, ulong arg)
+aoeblk_ioctl(struct block_device *bdev, blk_mode_t mode, uint cmd, ulong arg)
 {
 	struct aoedev *d;
 
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 66a3242bb062c3..cd738cab725f39 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -442,12 +442,12 @@ static void fd_times_out(struct timer_list *unused);
 static void finish_fdc( void );
 static void finish_fdc_done( int dummy );
 static void setup_req_params( int drive );
-static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
-                     cmd, unsigned long param);
+static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
+		unsigned int cmd, unsigned long param);
 static void fd_probe( int drive );
 static int fd_test_drive_present( int drive );
 static void config_types( void );
-static int floppy_open(struct gendisk *disk, fmode_t mode);
+static int floppy_open(struct gendisk *disk, blk_mode_t mode);
 static void floppy_release(struct gendisk *disk);
 
 /************************* End of Prototypes **************************/
@@ -1581,7 +1581,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
+static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		    unsigned int cmd, unsigned long param)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -1768,7 +1768,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 	}
 }
 
-static int fd_ioctl(struct block_device *bdev, fmode_t mode,
+static int fd_ioctl(struct block_device *bdev, blk_mode_t mode,
 			     unsigned int cmd, unsigned long arg)
 {
 	int ret;
@@ -1915,7 +1915,7 @@ static void __init config_types( void )
  * drive with different device numbers.
  */
 
-static int floppy_open(struct gendisk *disk, fmode_t mode)
+static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct atari_floppy_struct *p = disk->private_data;
 	int type = disk->first_minor >> 2;
@@ -1924,23 +1924,22 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 	if (p->ref && p->type != type)
 		return -EBUSY;
 
-	if (p->ref == -1 || (p->ref && mode & FMODE_EXCL))
+	if (p->ref == -1 || (p->ref && mode & BLK_OPEN_EXCL))
 		return -EBUSY;
-
-	if (mode & FMODE_EXCL)
+	if (mode & BLK_OPEN_EXCL)
 		p->ref = -1;
 	else
 		p->ref++;
 
 	p->type = type;
 
-	if (mode & FMODE_NDELAY)
+	if (mode & BLK_OPEN_NDELAY)
 		return 0;
 
-	if (mode & (FMODE_READ|FMODE_WRITE)) {
+	if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
 		if (disk_check_media_change(disk))
 			floppy_revalidate(disk);
-		if (mode & FMODE_WRITE) {
+		if (mode & BLK_OPEN_WRITE) {
 			if (p->wpstat) {
 				if (p->ref < 0)
 					p->ref = 0;
@@ -1953,7 +1952,7 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static int floppy_unlocked_open(struct gendisk *disk, fmode_t mode)
+static int floppy_unlocked_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int ret;
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7f3d7ca6ce6bcf..965f672557f22c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -49,7 +49,7 @@
 #include "drbd_debugfs.h"
 
 static DEFINE_MUTEX(drbd_main_mutex);
-static int drbd_open(struct gendisk *disk, fmode_t mode);
+static int drbd_open(struct gendisk *disk, blk_mode_t mode);
 static void drbd_release(struct gendisk *gd);
 static void md_sync_timer_fn(struct timer_list *t);
 static int w_bitmap_io(struct drbd_work *w, int unused);
@@ -1882,7 +1882,7 @@ int drbd_send_all(struct drbd_connection *connection, struct socket *sock, void
 	return 0;
 }
 
-static int drbd_open(struct gendisk *disk, fmode_t mode)
+static int drbd_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct drbd_device *device = disk->private_data;
 	unsigned long flags;
@@ -1894,7 +1894,7 @@ static int drbd_open(struct gendisk *disk, fmode_t mode)
 	 * and no race with updating open_cnt */
 
 	if (device->state.role != R_PRIMARY) {
-		if (mode & FMODE_WRITE)
+		if (mode & BLK_OPEN_WRITE)
 			rv = -EROFS;
 		else if (!drbd_allow_oos)
 			rv = -EMEDIUMTYPE;
@@ -1911,6 +1911,7 @@ static int drbd_open(struct gendisk *disk, fmode_t mode)
 static void drbd_release(struct gendisk *gd)
 {
 	struct drbd_device *device = gd->private_data;
+
 	mutex_lock(&drbd_main_mutex);
 	device->open_cnt--;
 	mutex_unlock(&drbd_main_mutex);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 10b1e5171332f7..cddae6f4b00fea 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1640,7 +1640,7 @@ static struct block_device *open_backing_dev(struct drbd_device *device,
 	struct block_device *bdev;
 	int err = 0;
 
-	bdev = blkdev_get_by_path(bdev_path, FMODE_READ | FMODE_WRITE,
+	bdev = blkdev_get_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
 				  claim_ptr, NULL);
 	if (IS_ERR(bdev)) {
 		drbd_err(device, "open(\"%s\") failed with %ld\n",
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index d79fac288a73dc..2db9b186b977ac 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3394,8 +3394,8 @@ static bool valid_floppy_drive_params(const short autodetect[FD_AUTODETECT_SIZE]
 	return true;
 }
 
-static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
-		    unsigned long param)
+static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
+		unsigned int cmd, unsigned long param)
 {
 	int drive = (long)bdev->bd_disk->private_data;
 	int type = ITYPE(drive_state[drive].fd_device);
@@ -3428,7 +3428,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		return ret;
 
 	/* permission checks */
-	if (((cmd & 0x40) && !(mode & (FMODE_WRITE | FMODE_WRITE_IOCTL))) ||
+	if (((cmd & 0x40) &&
+	     !(mode & (BLK_OPEN_WRITE | BLK_OPEN_WRITE_IOCTL))) ||
 	    ((cmd & 0x80) && !capable(CAP_SYS_ADMIN)))
 		return -EPERM;
 
@@ -3566,7 +3567,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 	return 0;
 }
 
-static int fd_ioctl(struct block_device *bdev, fmode_t mode,
+static int fd_ioctl(struct block_device *bdev, blk_mode_t mode,
 			     unsigned int cmd, unsigned long param)
 {
 	int ret;
@@ -3654,8 +3655,8 @@ struct compat_floppy_write_errors {
 #define FDGETFDCSTAT32 _IOR(2, 0x15, struct compat_floppy_fdc_state)
 #define FDWERRORGET32  _IOR(2, 0x17, struct compat_floppy_write_errors)
 
-static int compat_set_geometry(struct block_device *bdev, fmode_t mode, unsigned int cmd,
-		    struct compat_floppy_struct __user *arg)
+static int compat_set_geometry(struct block_device *bdev, blk_mode_t mode,
+		unsigned int cmd, struct compat_floppy_struct __user *arg)
 {
 	struct floppy_struct v;
 	int drive, type;
@@ -3664,7 +3665,7 @@ static int compat_set_geometry(struct block_device *bdev, fmode_t mode, unsigned
 	BUILD_BUG_ON(offsetof(struct floppy_struct, name) !=
 		     offsetof(struct compat_floppy_struct, name));
 
-	if (!(mode & (FMODE_WRITE | FMODE_WRITE_IOCTL)))
+	if (!(mode & (BLK_OPEN_WRITE | BLK_OPEN_WRITE_IOCTL)))
 		return -EPERM;
 
 	memset(&v, 0, sizeof(struct floppy_struct));
@@ -3861,8 +3862,8 @@ static int compat_werrorget(int drive,
 	return 0;
 }
 
-static int fd_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
-		    unsigned long param)
+static int fd_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
+		unsigned int cmd, unsigned long param)
 {
 	int drive = (long)bdev->bd_disk->private_data;
 	switch (cmd) {
@@ -3984,7 +3985,7 @@ static void floppy_release(struct gendisk *disk)
  * /dev/PS0 etc), and disallows simultaneous access to the same
  * drive with different device numbers.
  */
-static int floppy_open(struct gendisk *disk, fmode_t mode)
+static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int drive = (long)disk->private_data;
 	int old_dev, new_dev;
@@ -4049,9 +4050,8 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 
 	if (fdc_state[FDC(drive)].rawcmd == 1)
 		fdc_state[FDC(drive)].rawcmd = 2;
-
-	if (!(mode & FMODE_NDELAY)) {
-		if (mode & (FMODE_READ|FMODE_WRITE)) {
+	if (!(mode & BLK_OPEN_NDELAY)) {
+		if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
 			drive_state[drive].last_checked = 0;
 			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
 				  &drive_state[drive].flags);
@@ -4063,7 +4063,7 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 				goto out;
 		}
 		res = -EROFS;
-		if ((mode & FMODE_WRITE) &&
+		if ((mode & BLK_OPEN_WRITE) &&
 		    !test_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags))
 			goto out;
 	}
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ca40d24572aea6..37511d2b2caf7d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -990,7 +990,7 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static int loop_configure(struct loop_device *lo, fmode_t mode,
+static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 			  struct block_device *bdev,
 			  const struct loop_config *config)
 {
@@ -1014,7 +1014,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * here to avoid changing device under exclusive owner.
 	 */
-	if (!(mode & FMODE_EXCL)) {
+	if (!(mode & BLK_OPEN_EXCL)) {
 		error = bd_prepare_to_claim(bdev, loop_configure, NULL);
 		if (error)
 			goto out_putf;
@@ -1050,7 +1050,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (error)
 		goto out_unlock;
 
-	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
+	if (!(file->f_mode & FMODE_WRITE) || !(mode & BLK_OPEN_WRITE) ||
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
@@ -1116,7 +1116,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		loop_reread_partitions(lo);
 
-	if (!(mode & FMODE_EXCL))
+	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
 
 	return 0;
@@ -1124,7 +1124,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 out_unlock:
 	loop_global_unlock(lo, is_loop);
 out_bdev:
-	if (!(mode & FMODE_EXCL))
+	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
 out_putf:
 	fput(file);
@@ -1528,7 +1528,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 	return err;
 }
 
-static int lo_ioctl(struct block_device *bdev, fmode_t mode,
+static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
@@ -1563,24 +1563,22 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		return loop_clr_fd(lo);
 	case LOOP_SET_STATUS:
 		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
+		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
 			err = loop_set_status_old(lo, argp);
-		}
 		break;
 	case LOOP_GET_STATUS:
 		return loop_get_status_old(lo, argp);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
+		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
 			err = loop_set_status64(lo, argp);
-		}
 		break;
 	case LOOP_GET_STATUS64:
 		return loop_get_status64(lo, argp);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
-		if (!(mode & FMODE_WRITE) && !capable(CAP_SYS_ADMIN))
+		if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		fallthrough;
 	default:
@@ -1691,7 +1689,7 @@ loop_get_status_compat(struct loop_device *lo,
 	return err;
 }
 
-static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
+static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 815d77ba63819e..b200950e8fb5f9 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3041,7 +3041,7 @@ static int rssd_disk_name_format(char *prefix,
  *                 structure pointer.
  */
 static int mtip_block_ioctl(struct block_device *dev,
-			    fmode_t mode,
+			    blk_mode_t mode,
 			    unsigned cmd,
 			    unsigned long arg)
 {
@@ -3079,7 +3079,7 @@ static int mtip_block_ioctl(struct block_device *dev,
  *                 structure pointer.
  */
 static int mtip_block_compat_ioctl(struct block_device *dev,
-			    fmode_t mode,
+			    blk_mode_t mode,
 			    unsigned cmd,
 			    unsigned long arg)
 {
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5a02fd6b3e7e95..33b6c8e6ca6b12 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1502,7 +1502,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	return -ENOTTY;
 }
 
-static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
+static int nbd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg)
 {
 	struct nbd_device *nbd = bdev->bd_disk->private_data;
@@ -1553,7 +1553,7 @@ static struct nbd_config *nbd_alloc_config(void)
 	return config;
 }
 
-static int nbd_open(struct gendisk *disk, fmode_t mode)
+static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct nbd_device *nbd;
 	int ret = 0;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 0842a45cba167e..ba5b2257f809df 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2113,7 +2113,7 @@ static int pkt_open_write(struct pktcdvd_device *pd)
 /*
  * called at open time.
  */
-static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
+static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 {
 	int ret;
 	long lba;
@@ -2125,7 +2125,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
 	 * so open should not fail.
 	 */
-	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, FMODE_READ, pd, NULL);
+	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, BLK_OPEN_READ, pd, NULL);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
 		goto out;
@@ -2203,7 +2203,7 @@ static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
 	return pkt_devs[dev_minor];
 }
 
-static int pkt_open(struct gendisk *disk, fmode_t mode)
+static int pkt_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct pktcdvd_device *pd = NULL;
 	int ret;
@@ -2219,13 +2219,13 @@ static int pkt_open(struct gendisk *disk, fmode_t mode)
 
 	pd->refcnt++;
 	if (pd->refcnt > 1) {
-		if ((mode & FMODE_WRITE) &&
+		if ((mode & BLK_OPEN_WRITE) &&
 		    !test_bit(PACKET_WRITABLE, &pd->flags)) {
 			ret = -EBUSY;
 			goto out_dec;
 		}
 	} else {
-		ret = pkt_open_dev(pd, mode & FMODE_WRITE);
+		ret = pkt_open_dev(pd, mode & BLK_OPEN_WRITE);
 		if (ret)
 			goto out_dec;
 		/*
@@ -2234,7 +2234,6 @@ static int pkt_open(struct gendisk *disk, fmode_t mode)
 		 */
 		set_blocksize(disk->part0, CD_FRAMESIZE);
 	}
-
 	mutex_unlock(&ctl_mutex);
 	mutex_unlock(&pktcdvd_mutex);
 	return 0;
@@ -2530,7 +2529,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		}
 	}
 
-	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_NDELAY, NULL, NULL);
+	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY, NULL,
+				 NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 	sdev = scsi_device_from_queue(bdev->bd_disk->queue);
@@ -2566,7 +2566,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	return -ENOMEM;
 }
 
-static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
+static int pkt_ioctl(struct block_device *bdev, blk_mode_t mode,
+		unsigned int cmd, unsigned long arg)
 {
 	struct pktcdvd_device *pd = bdev->bd_disk->private_data;
 	int ret;
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5215eff94fe94f..39f2903fe25fed 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -660,7 +660,7 @@ static bool pending_result_dec(struct pending_result *pending, int *result)
 	return true;
 }
 
-static int rbd_open(struct gendisk *disk, fmode_t mode)
+static int rbd_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct rbd_device *rbd_dev = disk->private_data;
 	bool removing = false;
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index d5261d36d78630..b0550b68645d38 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -921,11 +921,11 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 	return sess;
 }
 
-static int rnbd_client_open(struct gendisk *disk, fmode_t mode)
+static int rnbd_client_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct rnbd_clt_dev *dev = disk->private_data;
 
-	if (get_disk_ro(dev->gd) && (mode & FMODE_WRITE))
+	if (get_disk_ro(dev->gd) && (mode & BLK_OPEN_WRITE))
 		return -EPERM;
 
 	if (dev->dev_state == DEV_STATE_UNMAPPED ||
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index b680071342b898..7327dc8e8d2be2 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -681,14 +681,14 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_srv_sess_dev *srv_sess_dev;
 	const struct rnbd_msg_open *open_msg = msg;
 	struct block_device *bdev;
-	fmode_t open_flags = FMODE_READ;
+	blk_mode_t open_flags = BLK_OPEN_READ;
 	char *full_path;
 	struct rnbd_msg_open_rsp *rsp = data;
 
 	trace_process_msg_open(srv_sess, open_msg);
 
 	if (open_msg->access_mode != RNBD_ACCESS_RO)
-		open_flags |= FMODE_WRITE;
+		open_flags |= BLK_OPEN_WRITE;
 
 	mutex_lock(&srv_sess->lock);
 
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 9fa821fa76b07b..7bf4b48e2282e7 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -139,7 +139,7 @@ static int vdc_getgeo(struct block_device *bdev, struct hd_geometry *geo)
  * when vdisk_mtype is VD_MEDIA_TYPE_CD or VD_MEDIA_TYPE_DVD.
  * Needed to be able to install inside an ldom from an iso image.
  */
-static int vdc_ioctl(struct block_device *bdev, fmode_t mode,
+static int vdc_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned command, unsigned long argument)
 {
 	struct vdc_port *port = bdev->bd_disk->private_data;
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index a629b38dec660a..651009b3a601eb 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -608,20 +608,18 @@ static void setup_medium(struct floppy_state *fs)
 	}
 }
 
-static int floppy_open(struct gendisk *disk, fmode_t mode)
+static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct floppy_state *fs = disk->private_data;
 	struct swim __iomem *base = fs->swd->base;
 	int err;
 
-	if (fs->ref_count == -1 || (fs->ref_count && mode & FMODE_EXCL))
+	if (fs->ref_count == -1 || (fs->ref_count && mode & BLK_OPEN_EXCL))
 		return -EBUSY;
-
-	if (mode & FMODE_EXCL)
+	if (mode & BLK_OPEN_EXCL)
 		fs->ref_count = -1;
 	else
 		fs->ref_count++;
-
 	swim_write(base, setup, S_IBM_DRIVE  | S_FCLK_DIV2);
 	udelay(10);
 	swim_drive(base, fs->location);
@@ -636,10 +634,10 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 
 	set_capacity(fs->disk, fs->total_secs);
 
-	if (mode & FMODE_NDELAY)
+	if (mode & BLK_OPEN_NDELAY)
 		return 0;
 
-	if (mode & (FMODE_READ|FMODE_WRITE)) {
+	if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
 		if (disk_check_media_change(disk) && fs->disk_in)
 			fs->ejected = 0;
 		if ((mode & FMODE_WRITE) && fs->write_protected) {
@@ -659,7 +657,7 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 	return err;
 }
 
-static int floppy_unlocked_open(struct gendisk *disk, fmode_t mode)
+static int floppy_unlocked_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int ret;
 
@@ -686,7 +684,7 @@ static void floppy_release(struct gendisk *disk)
 	mutex_unlock(&swim_mutex);
 }
 
-static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
+static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 			unsigned int cmd, unsigned long param)
 {
 	struct floppy_state *fs = bdev->bd_disk->private_data;
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index b696deff3d8ba1..945a0315425070 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -246,9 +246,9 @@ static int grab_drive(struct floppy_state *fs, enum swim_state state,
 		      int interruptible);
 static void release_drive(struct floppy_state *fs);
 static int fd_eject(struct floppy_state *fs);
-static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
+static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 			unsigned int cmd, unsigned long param);
-static int floppy_open(struct gendisk *disk, fmode_t mode);
+static int floppy_open(struct gendisk *disk, blk_mode_t mode);
 static unsigned int floppy_check_events(struct gendisk *disk,
 					unsigned int clearing);
 static int floppy_revalidate(struct gendisk *disk);
@@ -882,7 +882,7 @@ static int fd_eject(struct floppy_state *fs)
 static struct floppy_struct floppy_type =
 	{ 2880,18,2,80,0,0x1B,0x00,0xCF,0x6C,NULL };	/*  7 1.44MB 3.5"   */
 
-static int floppy_locked_ioctl(struct block_device *bdev, fmode_t mode,
+static int floppy_locked_ioctl(struct block_device *bdev,
 			unsigned int cmd, unsigned long param)
 {
 	struct floppy_state *fs = bdev->bd_disk->private_data;
@@ -910,7 +910,7 @@ static int floppy_locked_ioctl(struct block_device *bdev, fmode_t mode,
 	return -ENOTTY;
 }
 
-static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
+static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 				 unsigned int cmd, unsigned long param)
 {
 	int ret;
@@ -922,7 +922,7 @@ static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-static int floppy_open(struct gendisk *disk, fmode_t mode)
+static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct floppy_state *fs = disk->private_data;
 	struct swim3 __iomem *sw = fs->swim3;
@@ -957,18 +957,18 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 		swim3_action(fs, SETMFM);
 		swim3_select(fs, RELAX);
 
-	} else if (fs->ref_count == -1 || mode & FMODE_EXCL)
+	} else if (fs->ref_count == -1 || mode & BLK_OPEN_EXCL)
 		return -EBUSY;
 
-	if (err == 0 && (mode & FMODE_NDELAY) == 0
-	    && (mode & (FMODE_READ|FMODE_WRITE))) {
+	if (err == 0 && !(mode & BLK_OPEN_NDELAY) &&
+	    (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE))) {
 		if (disk_check_media_change(disk))
 			floppy_revalidate(disk);
 		if (fs->ejected)
 			err = -ENXIO;
 	}
 
-	if (err == 0 && (mode & FMODE_WRITE)) {
+	if (err == 0 && (mode & BLK_OPEN_WRITE)) {
 		if (fs->write_prot < 0)
 			fs->write_prot = swim3_readbit(fs, WRITE_PROT);
 		if (fs->write_prot)
@@ -984,7 +984,7 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 		return err;
 	}
 
-	if (mode & FMODE_EXCL)
+	if (mode & BLK_OPEN_EXCL)
 		fs->ref_count = -1;
 	else
 		++fs->ref_count;
@@ -992,12 +992,12 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static int floppy_unlocked_open(struct block_device *bdev, fmode_t mode)
+static int floppy_unlocked_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int ret;
 
 	mutex_lock(&swim3_mutex);
-	ret = floppy_open(bdev, mode);
+	ret = floppy_open(disk, mode);
 	mutex_unlock(&swim3_mutex);
 
 	return ret;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 92c900ac2ebcb6..9fdc4c7f908dd0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -447,7 +447,7 @@ static void ublk_store_owner_uid_gid(unsigned int *owner_uid,
 	*owner_gid = from_kgid(&init_user_ns, gid);
 }
 
-static int ublk_open(struct gendisk *disk, fmode_t mode)
+static int ublk_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct ublk_device *ub = disk->private_data;
 
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 141b60aad57038..bb66178c432b0d 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -492,7 +492,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	vbd->pdevice  = MKDEV(major, minor);
 
 	bdev = blkdev_get_by_dev(vbd->pdevice, vbd->readonly ?
-				 FMODE_READ : FMODE_WRITE, NULL, NULL);
+				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL, NULL);
 
 	if (IS_ERR(bdev)) {
 		pr_warn("xen_vbd_create: device %08x could not be opened\n",
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 23ed258b57f0e5..52e74adbaad675 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -509,7 +509,7 @@ static int blkif_getgeo(struct block_device *bd, struct hd_geometry *hg)
 	return 0;
 }
 
-static int blkif_ioctl(struct block_device *bdev, fmode_t mode,
+static int blkif_ioctl(struct block_device *bdev, blk_mode_t mode,
 		       unsigned command, unsigned long argument)
 {
 	struct blkfront_info *info = bdev->bd_disk->private_data;
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index a2e41cc084ca3a..11493167b0a848 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -140,7 +140,7 @@ static void get_chipram(void)
 	return;
 }
 
-static int z2_open(struct gendisk *disk, fmode_t mode)
+static int z2_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int device = disk->first_minor;
 	int max_z2_map = (Z2RAM_SIZE / Z2RAM_CHUNKSIZE) * sizeof(z2ram_map[0]);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 21615d67a9bd66..1867f378b319f4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -507,8 +507,8 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev = blkdev_get_by_dev(inode->i_rdev, FMODE_READ | FMODE_WRITE, zram,
-				 NULL);
+	bdev = blkdev_get_by_dev(inode->i_rdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				 zram, NULL);
 	if (IS_ERR(bdev)) {
 		err = PTR_ERR(bdev);
 		bdev = NULL;
@@ -2097,7 +2097,7 @@ static ssize_t reset_store(struct device *dev,
 	return len;
 }
 
-static int zram_open(struct gendisk *disk, fmode_t mode)
+static int zram_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct zram *zram = disk->private_data;
 
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 998b03fe976e22..44a5b6b20962f9 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1146,7 +1146,7 @@ int open_for_data(struct cdrom_device_info *cdi)
  * is in their own interest: device control becomes a lot easier
  * this way.
  */
-int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
+int cdrom_open(struct cdrom_device_info *cdi, blk_mode_t mode)
 {
 	int ret;
 
@@ -1155,7 +1155,7 @@ int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
 	cdi->use_count++;
-	if ((mode & FMODE_NDELAY) && (cdi->options & CDO_USE_FFLAGS)) {
+	if ((mode & BLK_OPEN_NDELAY) && (cdi->options & CDO_USE_FFLAGS)) {
 		ret = cdi->ops->open(cdi, 1);
 	} else {
 		ret = open_for_data(cdi);
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index dac148d4d1feda..3a46e27479ff64 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -474,7 +474,7 @@ static const struct cdrom_device_ops gdrom_ops = {
 				  CDC_RESET | CDC_DRIVE_STATUS | CDC_CD_R,
 };
 
-static int gdrom_bdops_open(struct gendisk *disk, fmode_t mode)
+static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int ret;
 
@@ -499,7 +499,7 @@ static unsigned int gdrom_bdops_check_events(struct gendisk *disk,
 	return cdrom_check_events(gd.cd_info, clearing);
 }
 
-static int gdrom_bdops_ioctl(struct block_device *bdev, fmode_t mode,
+static int gdrom_bdops_ioctl(struct block_device *bdev, blk_mode_t mode,
 	unsigned cmd, unsigned long arg)
 {
 	int ret;
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index aebb7ef10e631a..700dc5588d5fc6 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -275,7 +275,7 @@ struct bcache_device {
 
 	int (*cache_miss)(struct btree *b, struct search *s,
 			  struct bio *bio, unsigned int sectors);
-	int (*ioctl)(struct bcache_device *d, fmode_t mode,
+	int (*ioctl)(struct bcache_device *d, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg);
 };
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 67a2e29e0b40e0..a9b1f3896249b3 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1228,7 +1228,7 @@ void cached_dev_submit_bio(struct bio *bio)
 		detached_dev_do_request(d, bio, orig_bdev, start_time);
 }
 
-static int cached_dev_ioctl(struct bcache_device *d, fmode_t mode,
+static int cached_dev_ioctl(struct bcache_device *d, blk_mode_t mode,
 			    unsigned int cmd, unsigned long arg)
 {
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
@@ -1318,7 +1318,7 @@ void flash_dev_submit_bio(struct bio *bio)
 	continue_at(cl, search_free, NULL);
 }
 
-static int flash_dev_ioctl(struct bcache_device *d, fmode_t mode,
+static int flash_dev_ioctl(struct bcache_device *d, blk_mode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	return -ENOTTY;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 7022fea396f25e..1f829e74db0a31 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -732,7 +732,7 @@ static int prio_read(struct cache *ca, uint64_t bucket)
 
 /* Bcache device */
 
-static int open_dev(struct gendisk *disk, fmode_t mode)
+static int open_dev(struct gendisk *disk, blk_mode_t mode)
 {
 	struct bcache_device *d = disk->private_data;
 
@@ -750,7 +750,7 @@ static void release_dev(struct gendisk *b)
 	closure_put(&d->cl);
 }
 
-static int ioctl_dev(struct block_device *b, fmode_t mode,
+static int ioctl_dev(struct block_device *b, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg)
 {
 	struct bcache_device *d = b->bd_disk->private_data;
@@ -2558,7 +2558,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	ret = -EINVAL;
 	err = "failed to open device";
-	bdev = blkdev_get_by_path(strim(path), FMODE_READ | FMODE_WRITE,
+	bdev = blkdev_get_by_path(strim(path), BLK_OPEN_READ | BLK_OPEN_WRITE,
 				  bcache_kobj, NULL);
 	if (IS_ERR(bdev)) {
 		if (bdev == ERR_PTR(-EBUSY)) {
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 872896218550c9..911f73f7ebbaa0 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2051,8 +2051,8 @@ static int parse_metadata_dev(struct cache_args *ca, struct dm_arg_set *as,
 	if (!at_least_one_arg(as, error))
 		return -EINVAL;
 
-	r = dm_get_device(ca->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
-			  &ca->metadata_dev);
+	r = dm_get_device(ca->ti, dm_shift_arg(as),
+			  BLK_OPEN_READ | BLK_OPEN_WRITE, &ca->metadata_dev);
 	if (r) {
 		*error = "Error opening metadata device";
 		return r;
@@ -2074,8 +2074,8 @@ static int parse_cache_dev(struct cache_args *ca, struct dm_arg_set *as,
 	if (!at_least_one_arg(as, error))
 		return -EINVAL;
 
-	r = dm_get_device(ca->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
-			  &ca->cache_dev);
+	r = dm_get_device(ca->ti, dm_shift_arg(as),
+			  BLK_OPEN_READ | BLK_OPEN_WRITE, &ca->cache_dev);
 	if (r) {
 		*error = "Error opening cache device";
 		return r;
@@ -2093,8 +2093,8 @@ static int parse_origin_dev(struct cache_args *ca, struct dm_arg_set *as,
 	if (!at_least_one_arg(as, error))
 		return -EINVAL;
 
-	r = dm_get_device(ca->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
-			  &ca->origin_dev);
+	r = dm_get_device(ca->ti, dm_shift_arg(as),
+			  BLK_OPEN_READ | BLK_OPEN_WRITE, &ca->origin_dev);
 	if (r) {
 		*error = "Error opening origin device";
 		return r;
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index f467cdb5a02237..94b2fc33f64be3 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -1683,8 +1683,8 @@ static int parse_metadata_dev(struct clone *clone, struct dm_arg_set *as, char *
 	int r;
 	sector_t metadata_dev_size;
 
-	r = dm_get_device(clone->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
-			  &clone->metadata_dev);
+	r = dm_get_device(clone->ti, dm_shift_arg(as),
+			  BLK_OPEN_READ | BLK_OPEN_WRITE, &clone->metadata_dev);
 	if (r) {
 		*error = "Error opening metadata device";
 		return r;
@@ -1703,8 +1703,8 @@ static int parse_dest_dev(struct clone *clone, struct dm_arg_set *as, char **err
 	int r;
 	sector_t dest_dev_size;
 
-	r = dm_get_device(clone->ti, dm_shift_arg(as), FMODE_READ | FMODE_WRITE,
-			  &clone->dest_dev);
+	r = dm_get_device(clone->ti, dm_shift_arg(as),
+			  BLK_OPEN_READ | BLK_OPEN_WRITE, &clone->dest_dev);
 	if (r) {
 		*error = "Error opening destination device";
 		return r;
@@ -1725,7 +1725,7 @@ static int parse_source_dev(struct clone *clone, struct dm_arg_set *as, char **e
 	int r;
 	sector_t source_dev_size;
 
-	r = dm_get_device(clone->ti, dm_shift_arg(as), FMODE_READ,
+	r = dm_get_device(clone->ti, dm_shift_arg(as), BLK_OPEN_READ,
 			  &clone->source_dev);
 	if (r) {
 		*error = "Error opening source device";
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index aecab0c0720f77..ce913ad91a52b9 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -207,11 +207,10 @@ struct dm_table {
 	unsigned integrity_added:1;
 
 	/*
-	 * Indicates the rw permissions for the new logical
-	 * device.  This should be a combination of FMODE_READ
-	 * and FMODE_WRITE.
+	 * Indicates the rw permissions for the new logical device.  This
+	 * should be a combination of BLK_OPEN_READ and BLK_OPEN_WRITE.
 	 */
-	fmode_t mode;
+	blk_mode_t mode;
 
 	/* a list of devices used by this table */
 	struct list_head devices;
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index 0d70914217eedc..6acfa5bf97a400 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1482,14 +1482,16 @@ static int era_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	era->ti = ti;
 
-	r = dm_get_device(ti, argv[0], FMODE_READ | FMODE_WRITE, &era->metadata_dev);
+	r = dm_get_device(ti, argv[0], BLK_OPEN_READ | BLK_OPEN_WRITE,
+			  &era->metadata_dev);
 	if (r) {
 		ti->error = "Error opening metadata device";
 		era_destroy(era);
 		return -EINVAL;
 	}
 
-	r = dm_get_device(ti, argv[1], FMODE_READ | FMODE_WRITE, &era->origin_dev);
+	r = dm_get_device(ti, argv[1], BLK_OPEN_READ | BLK_OPEN_WRITE,
+			  &era->origin_dev);
 	if (r) {
 		ti->error = "Error opening data device";
 		era_destroy(era);
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cc77cf3d410921..8ba4cbb92351f5 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -861,7 +861,7 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 
 		table = dm_get_inactive_table(md, &srcu_idx);
 		if (table) {
-			if (!(dm_table_get_mode(table) & FMODE_WRITE))
+			if (!(dm_table_get_mode(table) & BLK_OPEN_WRITE))
 				param->flags |= DM_READONLY_FLAG;
 			param->target_count = table->num_targets;
 		}
@@ -1192,7 +1192,7 @@ static int do_resume(struct dm_ioctl *param)
 		if (old_size && new_size && old_size != new_size)
 			need_resize_uevent = true;
 
-		if (dm_table_get_mode(new_map) & FMODE_WRITE)
+		if (dm_table_get_mode(new_map) & BLK_OPEN_WRITE)
 			set_disk_ro(dm_disk(md), 0);
 		else
 			set_disk_ro(dm_disk(md), 1);
@@ -1381,12 +1381,12 @@ static int dev_arm_poll(struct file *filp, struct dm_ioctl *param, size_t param_
 	return 0;
 }
 
-static inline fmode_t get_mode(struct dm_ioctl *param)
+static inline blk_mode_t get_mode(struct dm_ioctl *param)
 {
-	fmode_t mode = FMODE_READ | FMODE_WRITE;
+	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
 
 	if (param->flags & DM_READONLY_FLAG)
-		mode = FMODE_READ;
+		mode = BLK_OPEN_READ;
 
 	return mode;
 }
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 7832974b73eb03..bf7a574499a34d 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1242,7 +1242,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	int r = -EINVAL;
 	char *origin_path, *cow_path;
 	unsigned int args_used, num_flush_bios = 1;
-	fmode_t origin_mode = FMODE_READ;
+	blk_mode_t origin_mode = BLK_OPEN_READ;
 
 	if (argc < 4) {
 		ti->error = "requires 4 or more arguments";
@@ -1252,7 +1252,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	if (dm_target_is_snapshot_merge(ti)) {
 		num_flush_bios = 2;
-		origin_mode = FMODE_WRITE;
+		origin_mode = BLK_OPEN_WRITE;
 	}
 
 	s = kzalloc(sizeof(*s), GFP_KERNEL);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2fd5826bfce175..7d208b2b1a192d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -126,7 +126,7 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 	return 0;
 }
 
-int dm_table_create(struct dm_table **result, fmode_t mode,
+int dm_table_create(struct dm_table **result, blk_mode_t mode,
 		    unsigned int num_targets, struct mapped_device *md)
 {
 	struct dm_table *t = kzalloc(sizeof(*t), GFP_KERNEL);
@@ -304,7 +304,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
  * device and not to touch the existing bdev field in case
  * it is accessed concurrently.
  */
-static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
+static int upgrade_mode(struct dm_dev_internal *dd, blk_mode_t new_mode,
 			struct mapped_device *md)
 {
 	int r;
@@ -330,7 +330,7 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
  * Note: the __ref annotation is because this function can call the __init
  * marked early_lookup_bdev when called during early boot code from dm-init.c.
  */
-int __ref dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
+int __ref dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 		  struct dm_dev **result)
 {
 	int r;
@@ -662,7 +662,8 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 		t->singleton = true;
 	}
 
-	if (dm_target_always_writeable(ti->type) && !(t->mode & FMODE_WRITE)) {
+	if (dm_target_always_writeable(ti->type) &&
+	    !(t->mode & BLK_OPEN_WRITE)) {
 		ti->error = "target type may not be included in a read-only table";
 		goto bad;
 	}
@@ -2033,7 +2034,7 @@ struct list_head *dm_table_get_devices(struct dm_table *t)
 	return &t->devices;
 }
 
-fmode_t dm_table_get_mode(struct dm_table *t)
+blk_mode_t dm_table_get_mode(struct dm_table *t)
 {
 	return t->mode;
 }
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 2b13c949bd726b..464c6b67841719 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -3301,7 +3301,7 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	unsigned long block_size;
 	dm_block_t low_water_blocks;
 	struct dm_dev *metadata_dev;
-	fmode_t metadata_mode;
+	blk_mode_t metadata_mode;
 
 	/*
 	 * FIXME Remove validation from scope of lock.
@@ -3334,7 +3334,8 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (r)
 		goto out_unlock;
 
-	metadata_mode = FMODE_READ | ((pf.mode == PM_READ_ONLY) ? 0 : FMODE_WRITE);
+	metadata_mode = BLK_OPEN_READ |
+		((pf.mode == PM_READ_ONLY) ? 0 : BLK_OPEN_WRITE);
 	r = dm_get_device(ti, argv[0], metadata_mode, &metadata_dev);
 	if (r) {
 		ti->error = "Error opening metadata block device";
@@ -3342,7 +3343,7 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	warn_if_metadata_device_too_big(metadata_dev->bdev);
 
-	r = dm_get_device(ti, argv[1], FMODE_READ | FMODE_WRITE, &data_dev);
+	r = dm_get_device(ti, argv[1], BLK_OPEN_READ | BLK_OPEN_WRITE, &data_dev);
 	if (r) {
 		ti->error = "Error getting data device";
 		goto out_metadata;
@@ -4223,7 +4224,7 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			goto bad_origin_dev;
 		}
 
-		r = dm_get_device(ti, argv[2], FMODE_READ, &origin_dev);
+		r = dm_get_device(ti, argv[2], BLK_OPEN_READ, &origin_dev);
 		if (r) {
 			ti->error = "Error opening origin device";
 			goto bad_origin_dev;
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index a9ee2faa75a296..3ef9f018da60ce 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -607,7 +607,7 @@ int verity_fec_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 	(*argc)--;
 
 	if (!strcasecmp(arg_name, DM_VERITY_OPT_FEC_DEV)) {
-		r = dm_get_device(ti, arg_value, FMODE_READ, &v->fec->dev);
+		r = dm_get_device(ti, arg_value, BLK_OPEN_READ, &v->fec->dev);
 		if (r) {
 			ti->error = "FEC device lookup failed";
 			return r;
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index e35c16e06d0658..26adcfea030229 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1196,7 +1196,7 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (r)
 		goto bad;
 
-	if ((dm_table_get_mode(ti->table) & ~FMODE_READ)) {
+	if ((dm_table_get_mode(ti->table) & ~BLK_OPEN_READ)) {
 		ti->error = "Device must be readonly";
 		r = -EINVAL;
 		goto bad;
@@ -1225,13 +1225,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	v->version = num;
 
-	r = dm_get_device(ti, argv[1], FMODE_READ, &v->data_dev);
+	r = dm_get_device(ti, argv[1], BLK_OPEN_READ, &v->data_dev);
 	if (r) {
 		ti->error = "Data device lookup failed";
 		goto bad;
 	}
 
-	r = dm_get_device(ti, argv[2], FMODE_READ, &v->hash_dev);
+	r = dm_get_device(ti, argv[2], BLK_OPEN_READ, &v->hash_dev);
 	if (r) {
 		ti->error = "Hash device lookup failed";
 		goto bad;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b16e37362c5a01..ca2dc079c3f46b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -310,7 +310,7 @@ int dm_deleting_md(struct mapped_device *md)
 	return test_bit(DMF_DELETING, &md->flags);
 }
 
-static int dm_blk_open(struct gendisk *disk, fmode_t mode)
+static int dm_blk_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct mapped_device *md;
 
@@ -448,7 +448,7 @@ static void dm_unprepare_ioctl(struct mapped_device *md, int srcu_idx)
 	dm_put_live_table(md, srcu_idx);
 }
 
-static int dm_blk_ioctl(struct block_device *bdev, fmode_t mode,
+static int dm_blk_ioctl(struct block_device *bdev, blk_mode_t mode,
 			unsigned int cmd, unsigned long arg)
 {
 	struct mapped_device *md = bdev->bd_disk->private_data;
@@ -734,7 +734,7 @@ static char *_dm_claim_ptr = "I belong to device-mapper";
  * Open a table device so we can use it as a map destination.
  */
 static struct table_device *open_table_device(struct mapped_device *md,
-		dev_t dev, fmode_t mode)
+		dev_t dev, blk_mode_t mode)
 {
 	struct table_device *td;
 	struct block_device *bdev;
@@ -791,7 +791,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 }
 
 static struct table_device *find_table_device(struct list_head *l, dev_t dev,
-					      fmode_t mode)
+					      blk_mode_t mode)
 {
 	struct table_device *td;
 
@@ -802,7 +802,7 @@ static struct table_device *find_table_device(struct list_head *l, dev_t dev,
 	return NULL;
 }
 
-int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
+int dm_get_table_device(struct mapped_device *md, dev_t dev, blk_mode_t mode,
 			struct dm_dev **result)
 {
 	struct table_device *td;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index a856e0aee73bc9..63d9010d8e6179 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -203,7 +203,7 @@ int dm_open_count(struct mapped_device *md);
 int dm_lock_for_deletion(struct mapped_device *md, bool mark_deferred, bool only_deferred);
 int dm_cancel_deferred_remove(struct mapped_device *md);
 int dm_request_based(struct mapped_device *md);
-int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
+int dm_get_table_device(struct mapped_device *md, dev_t dev, blk_mode_t mode,
 			struct dm_dev **result);
 void dm_put_table_device(struct mapped_device *md, struct dm_dev *d);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index dad4a5539f9f68..ca0de7ddd9434d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3643,7 +3643,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	rdev->bdev = blkdev_get_by_dev(newdev, FMODE_READ | FMODE_WRITE,
+	rdev->bdev = blkdev_get_by_dev(newdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
 			super_format == -2 ? &claim_rdev : rdev, NULL);
 	if (IS_ERR(rdev->bdev)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
@@ -7488,7 +7488,7 @@ static int __md_set_array_info(struct mddev *mddev, void __user *argp)
 	return err;
 }
 
-static int md_ioctl(struct block_device *bdev, fmode_t mode,
+static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 			unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
@@ -7720,7 +7720,7 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 #ifdef CONFIG_COMPAT
-static int md_compat_ioctl(struct block_device *bdev, fmode_t mode,
+static int md_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 		    unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -7769,7 +7769,7 @@ static int md_set_read_only(struct block_device *bdev, bool ro)
 	return err;
 }
 
-static int md_open(struct gendisk *disk, fmode_t mode)
+static int md_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct mddev *mddev;
 	int err;
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b16eedf22d4e26..2a33b5073cc454 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -357,7 +357,7 @@ static const struct attribute_group *mmc_disk_attr_groups[] = {
 	NULL,
 };
 
-static int mmc_blk_open(struct gendisk *disk, fmode_t mode)
+static int mmc_blk_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(disk);
 	int ret = -ENXIO;
@@ -365,7 +365,7 @@ static int mmc_blk_open(struct gendisk *disk, fmode_t mode)
 	mutex_lock(&block_mutex);
 	if (md) {
 		ret = 0;
-		if ((mode & FMODE_WRITE) && md->read_only) {
+		if ((mode & BLK_OPEN_WRITE) && md->read_only) {
 			mmc_blk_put(md);
 			ret = -EROFS;
 		}
@@ -754,7 +754,7 @@ static int mmc_blk_check_blkdev(struct block_device *bdev)
 	return 0;
 }
 
-static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
+static int mmc_blk_ioctl(struct block_device *bdev, blk_mode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct mmc_blk_data *md;
@@ -791,7 +791,7 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 }
 
 #ifdef CONFIG_COMPAT
-static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
+static int mmc_blk_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	return mmc_blk_ioctl(bdev, mode, cmd, (unsigned long) compat_ptr(arg));
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 44fc23af4c3f84..be106dc20ff3cf 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -220,7 +220,7 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
  * early_lookup_bdev when called from the early boot code.
  */
 static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
-		fmode_t mode, int timeout, struct block2mtd_dev *dev)
+		blk_mode_t mode, int timeout, struct block2mtd_dev *dev)
 {
 	struct block_device *bdev = ERR_PTR(-ENODEV);
 #ifndef MODULE
@@ -261,7 +261,7 @@ static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
 static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		char *label, int timeout)
 {
-	const fmode_t mode = FMODE_READ | FMODE_WRITE;
+	const blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
 	char *name;
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index bd0b7545364349..ff18636e088973 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -182,7 +182,7 @@ static blk_status_t mtd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static int blktrans_open(struct gendisk *disk, fmode_t mode)
+static int blktrans_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct mtd_blktrans_dev *dev = disk->private_data;
 	int ret = 0;
@@ -208,7 +208,7 @@ static int blktrans_open(struct gendisk *disk, fmode_t mode)
 	ret = __get_mtd_device(dev->mtd);
 	if (ret)
 		goto error_release;
-	dev->writable = mode & FMODE_WRITE;
+	dev->writable = mode & BLK_OPEN_WRITE;
 
 unlock:
 	dev->open++;
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index e85fb9de0b7004..437c5b83ffe513 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -227,7 +227,7 @@ static blk_status_t ubiblock_read(struct request *req)
 	return BLK_STS_OK;
 }
 
-static int ubiblock_open(struct gendisk *disk, fmode_t mode)
+static int ubiblock_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct ubiblock *dev = disk->private_data;
 	int ret;
@@ -246,11 +246,10 @@ static int ubiblock_open(struct gendisk *disk, fmode_t mode)
 	 * It's just a paranoid check, as write requests will get rejected
 	 * in any case.
 	 */
-	if (mode & FMODE_WRITE) {
+	if (mode & BLK_OPEN_WRITE) {
 		ret = -EROFS;
 		goto out_unlock;
 	}
-
 	dev->desc = ubi_open_volume(dev->ubi_num, dev->vol_id, UBI_READONLY);
 	if (IS_ERR(dev->desc)) {
 		dev_err(disk_to_dev(dev->gd), "failed to open ubi volume %d_%d",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd7f8e6d66fda6..c3d72fc677f7ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1591,7 +1591,7 @@ static void nvme_ns_release(struct nvme_ns *ns)
 	nvme_put_ns(ns);
 }
 
-static int nvme_open(struct gendisk *disk, fmode_t mode)
+static int nvme_open(struct gendisk *disk, blk_mode_t mode)
 {
 	return nvme_ns_open(disk->private_data);
 }
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8bf09047348ee9..0fd0aa571cc939 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -709,11 +709,11 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	}
 }
 
-int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
-	bool open_for_write = mode & FMODE_WRITE;
+	bool open_for_write = mode & BLK_OPEN_WRITE;
 	void __user *argp = (void __user *)arg;
 	unsigned int flags = 0;
 
@@ -817,11 +817,11 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	return ret;
 }
 
-int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
+int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
-	bool open_for_write = mode & FMODE_WRITE;
+	bool open_for_write = mode & BLK_OPEN_WRITE;
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 698c0e70bcfa5b..91a9a55227fa3e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -402,7 +402,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	srcu_read_unlock(&head->srcu, srcu_idx);
 }
 
-static int nvme_ns_head_open(struct gendisk *disk, fmode_t mode)
+static int nvme_ns_head_open(struct gendisk *disk, blk_mode_t mode)
 {
 	if (!nvme_tryget_ns_head(disk->private_data))
 		return -ENXIO;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1e4..953e59f5613920 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -836,10 +836,10 @@ void nvme_put_ns_head(struct nvme_ns_head *head);
 int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 		const struct file_operations *fops, struct module *owner);
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
-int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
+int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 65ed2d478fac89..2733e01585854c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -85,7 +85,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		return -ENOTBLK;
 
 	ns->bdev = blkdev_get_by_path(ns->device_path,
-			FMODE_READ | FMODE_WRITE, NULL, NULL);
+			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
 	if (IS_ERR(ns->bdev)) {
 		ret = PTR_ERR(ns->bdev);
 		if (ret != -ENOTBLK) {
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 19295b2df470c8..45788955c4e63f 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3234,7 +3234,7 @@ struct blk_mq_ops dasd_mq_ops = {
 	.exit_hctx = dasd_exit_hctx,
 };
 
-static int dasd_open(struct gendisk *disk, fmode_t mode)
+static int dasd_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct dasd_device *base;
 	int rc;
@@ -3268,14 +3268,12 @@ static int dasd_open(struct gendisk *disk, fmode_t mode)
 		rc = -ENODEV;
 		goto out;
 	}
-
-	if ((mode & FMODE_WRITE) &&
+	if ((mode & BLK_OPEN_WRITE) &&
 	    (test_bit(DASD_FLAG_DEVICE_RO, &base->flags) ||
 	     (base->features & DASD_FEATURE_READONLY))) {
 		rc = -EROFS;
 		goto out;
 	}
-
 	dasd_put_device(base);
 	return 0;
 
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index d2b27b84f854cc..fe5108a1b332ea 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -130,7 +130,8 @@ int dasd_scan_partitions(struct dasd_block *block)
 	struct block_device *bdev;
 	int rc;
 
-	bdev = blkdev_get_by_dev(disk_devt(block->gdp), FMODE_READ, NULL, NULL);
+	bdev = blkdev_get_by_dev(disk_devt(block->gdp), BLK_OPEN_READ, NULL,
+				 NULL);
 	if (IS_ERR(bdev)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, blkdev_get returned %ld",
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 33f812f0e51504..0aa56351da720e 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -965,7 +965,8 @@ int dasd_scan_partitions(struct dasd_block *);
 void dasd_destroy_partitions(struct dasd_block *);
 
 /* externals in dasd_ioctl.c */
-int dasd_ioctl(struct block_device *, fmode_t, unsigned int, unsigned long);
+int dasd_ioctl(struct block_device *bdev, blk_mode_t mode, unsigned int cmd,
+		unsigned long arg);
 int dasd_set_read_only(struct block_device *bdev, bool ro);
 
 /* externals in dasd_proc.c */
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9327dcdd6e5e43..838c9f5313e60d 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -612,7 +612,7 @@ static int dasd_ioctl_readall_cmb(struct dasd_block *block, unsigned int cmd,
 	return ret;
 }
 
-int dasd_ioctl(struct block_device *bdev, fmode_t mode,
+int dasd_ioctl(struct block_device *bdev, blk_mode_t mode,
 	       unsigned int cmd, unsigned long arg)
 {
 	struct dasd_block *block;
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 5aee3106bfda84..200f88f0e45194 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -28,7 +28,7 @@
 #define DCSSBLK_PARM_LEN 400
 #define DCSS_BUS_ID_SIZE 20
 
-static int dcssblk_open(struct gendisk *disk, fmode_t mode);
+static int dcssblk_open(struct gendisk *disk, blk_mode_t mode);
 static void dcssblk_release(struct gendisk *disk);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
@@ -809,7 +809,7 @@ dcssblk_remove_store(struct device *dev, struct device_attribute *attr, const ch
 }
 
 static int
-dcssblk_open(struct gendisk *disk, fmode_t mode)
+dcssblk_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct dcssblk_dev_info *dev_info = disk->private_data;
 	int rc;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 02b6704ec2b401..ab216976dbdc80 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1298,7 +1298,7 @@ static bool sd_need_revalidate(struct gendisk *disk, struct scsi_disk *sdkp)
 /**
  *	sd_open - open a scsi disk device
  *	@disk: disk to open
- *	@mode: FMODE_* mask
+ *	@mode: open mode
  *
  *	Returns 0 if successful. Returns a negated errno value in case 
  *	of error.
@@ -1310,7 +1310,7 @@ static bool sd_need_revalidate(struct gendisk *disk, struct scsi_disk *sdkp)
  *
  *	Locking: called with disk->open_mutex held.
  **/
-static int sd_open(struct gendisk *disk, fmode_t mode)
+static int sd_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdev = sdkp->device;
@@ -1336,7 +1336,8 @@ static int sd_open(struct gendisk *disk, fmode_t mode)
 	 * If the drive is empty, just let the open fail.
 	 */
 	retval = -ENOMEDIUM;
-	if (sdev->removable && !sdkp->media_present && !(mode & FMODE_NDELAY))
+	if (sdev->removable && !sdkp->media_present &&
+	    !(mode & BLK_OPEN_NDELAY))
 		goto error_out;
 
 	/*
@@ -1344,7 +1345,7 @@ static int sd_open(struct gendisk *disk, fmode_t mode)
 	 * if the user expects to be able to write to the thing.
 	 */
 	retval = -EROFS;
-	if (sdkp->write_prot && (mode & FMODE_WRITE))
+	if (sdkp->write_prot && (mode & BLK_OPEN_WRITE))
 		goto error_out;
 
 	/*
@@ -1379,7 +1380,7 @@ static int sd_open(struct gendisk *disk, fmode_t mode)
  *	Note: may block (uninterruptible) if error recovery is underway
  *	on this disk.
  *
- *	Locking: called with bdev->bd_disk->open_mutex held.
+ *	Locking: called with disk->open_mutex held.
  **/
 static void sd_release(struct gendisk *disk)
 {
@@ -1424,7 +1425,7 @@ static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 /**
  *	sd_ioctl - process an ioctl
  *	@bdev: target block device
- *	@mode: FMODE_* mask
+ *	@mode: open mode
  *	@cmd: ioctl command number
  *	@arg: this is third argument given to ioctl(2) system call.
  *	Often contains a pointer.
@@ -1435,7 +1436,7 @@ static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
  *	Note: most ioctls are forward onto the block subsystem or further
  *	down in the scsi subsystem.
  **/
-static int sd_ioctl(struct block_device *bdev, fmode_t mode,
+static int sd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		    unsigned int cmd, unsigned long arg)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -1457,13 +1458,13 @@ static int sd_ioctl(struct block_device *bdev, fmode_t mode,
 	 * access to the device is prohibited.
 	 */
 	error = scsi_ioctl_block_when_processing_errors(sdp, cmd,
-			(mode & FMODE_NDELAY) != 0);
+			(mode & BLK_OPEN_NDELAY));
 	if (error)
 		return error;
 
 	if (is_sed_ioctl(cmd))
 		return sed_ioctl(sdkp->opal_dev, cmd, p);
-	return scsi_ioctl(sdp, mode & FMODE_WRITE, cmd, p);
+	return scsi_ioctl(sdp, mode & BLK_OPEN_WRITE, cmd, p);
 }
 
 static void set_media_not_present(struct scsi_disk *sdkp)
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 00aaafc8dd78f8..ce886c8c9dbe4c 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -484,7 +484,7 @@ static void sr_revalidate_disk(struct scsi_cd *cd)
 	get_sectorsize(cd);
 }
 
-static int sr_block_open(struct gendisk *disk, fmode_t mode)
+static int sr_block_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct scsi_cd *cd = scsi_cd(disk);
 	struct scsi_device *sdev = cd->device;
@@ -518,8 +518,8 @@ static void sr_block_release(struct gendisk *disk)
 	scsi_device_put(cd->device);
 }
 
-static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
-			  unsigned long arg)
+static int sr_block_ioctl(struct block_device *bdev, blk_mode_t mode,
+		unsigned cmd, unsigned long arg)
 {
 	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
 	struct scsi_device *sdev = cd->device;
@@ -532,7 +532,7 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	mutex_lock(&cd->lock);
 
 	ret = scsi_ioctl_block_when_processing_errors(sdev, cmd,
-			(mode & FMODE_NDELAY) != 0);
+			(mode & BLK_OPEN_NDELAY));
 	if (ret)
 		goto out;
 
@@ -543,7 +543,7 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		if (ret != -ENOSYS)
 			goto put;
 	}
-	ret = scsi_ioctl(sdev, mode & FMODE_WRITE, cmd, argp);
+	ret = scsi_ioctl(sdev, mode & BLK_OPEN_WRITE, cmd, argp);
 
 put:
 	scsi_autopm_put_device(sdev);
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index c62f961f46e378..3c462d69daca30 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -90,7 +90,7 @@ static int iblock_configure_device(struct se_device *dev)
 	struct request_queue *q;
 	struct block_device *bd = NULL;
 	struct blk_integrity *bi;
-	fmode_t mode;
+	blk_mode_t mode = BLK_OPEN_READ;
 	unsigned int max_write_zeroes_sectors;
 	int ret;
 
@@ -108,9 +108,8 @@ static int iblock_configure_device(struct se_device *dev)
 	pr_debug( "IBLOCK: Claiming struct block_device: %s\n",
 			ib_dev->ibd_udev_path);
 
-	mode = FMODE_READ;
 	if (!ib_dev->ibd_readonly)
-		mode |= FMODE_WRITE;
+		mode |= BLK_OPEN_WRITE;
 	else
 		dev->dev_flags |= DF_READ_ONLY;
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index da3b5512d7ae32..0d4f09693ef46e 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -366,8 +366,8 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	 * Claim exclusive struct block_device access to struct scsi_device
 	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
 	 */
-	bd = blkdev_get_by_path(dev->udev_path, FMODE_WRITE | FMODE_READ, pdv,
-				NULL);
+	bd = blkdev_get_by_path(dev->udev_path, BLK_OPEN_WRITE | BLK_OPEN_READ,
+				pdv, NULL);
 	if (IS_ERR(bd)) {
 		pr_err("pSCSI: blkdev_get_by_path() failed\n");
 		scsi_device_put(sd);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 677e9d9e1527aa..2d00600ff41327 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -257,7 +257,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	bdev = blkdev_get_by_path(device_path, FMODE_WRITE,
+	bdev = blkdev_get_by_path(device_path, BLK_OPEN_WRITE,
 				  fs_info->bdev_holder, NULL);
 	if (IS_ERR(bdev)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fd02b92e39106a..3c8c5e5a0bfc53 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -849,7 +849,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(const char *options, fmode_t flags)
+static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *device_name, *opts, *orig, *p;
@@ -1440,7 +1440,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	struct btrfs_fs_devices *fs_devices = NULL;
 	struct btrfs_fs_info *fs_info = NULL;
 	void *new_sec_opts = NULL;
-	fmode_t mode = sb_open_mode(flags);
+	blk_mode_t mode = sb_open_mode(flags);
 	int error = 0;
 
 	if (data) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7b12e05cdbf00b..c85e54f8603564 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -490,7 +490,7 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 
 
 static int
-btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
+btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		      int flush, struct block_device **bdev,
 		      struct btrfs_super_block **disk_super)
 {
@@ -590,7 +590,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
  * fs_devices->device_list_mutex here.
  */
 static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
-			struct btrfs_device *device, fmode_t flags,
+			struct btrfs_device *device, blk_mode_t flags,
 			void *holder)
 {
 	struct block_device *bdev;
@@ -1207,7 +1207,7 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 }
 
 static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
-				fmode_t flags, void *holder)
+				blk_mode_t flags, void *holder)
 {
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
@@ -1255,7 +1255,7 @@ static int devid_cmp(void *priv, const struct list_head *a,
 }
 
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
-		       fmode_t flags, void *holder)
+		       blk_mode_t flags, void *holder)
 {
 	int ret;
 
@@ -1346,7 +1346,7 @@ int btrfs_forget_devices(dev_t devt)
  * and we are not allowed to call set_blocksize during the scan. The superblock
  * is read via pagecache
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags)
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
 {
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
@@ -2378,7 +2378,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 	}
 
-	ret = btrfs_get_bdev_and_sb(path, FMODE_READ, NULL, 0,
+	ret = btrfs_get_bdev_and_sb(path, BLK_OPEN_READ, NULL, 0,
 				    &bdev, &disk_super);
 	if (ret) {
 		btrfs_put_dev_args_from_path(args);
@@ -2625,7 +2625,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
-	bdev = blkdev_get_by_path(device_path, FMODE_WRITE,
+	bdev = blkdev_get_by_path(device_path, BLK_OPEN_WRITE,
 				  fs_info->bdev_holder, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
@@ -6907,7 +6907,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	ret = open_fs_devices(fs_devices, FMODE_READ, fs_info->bdev_holder);
+	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->bdev_holder);
 	if (ret) {
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 840a8df399072c..8227ba4d64b8b1 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -599,8 +599,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
-		       fmode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags);
+		       blk_mode_t flags, void *holder);
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 54dba967a2d445..3f080f0afc0251 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -254,7 +254,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev = blkdev_get_by_path(dif->path, FMODE_READ, sb->s_type,
+		bdev = blkdev_get_by_path(dif->path, BLK_OPEN_READ, sb->s_type,
 					  NULL);
 		if (IS_ERR(bdev))
 			return PTR_ERR(bdev);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 92dd699139a3f7..94a7b56ed876c0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1112,7 +1112,7 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 {
 	struct block_device *bdev;
 
-	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_WRITE, sb,
+	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
 				 &ext4_holder_ops);
 	if (IS_ERR(bdev))
 		goto fail;
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 82f70d46f4e544..e855b8fde76ce1 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1100,7 +1100,7 @@ int lmLogOpen(struct super_block *sb)
 	 * file systems to log may have n-to-1 relationship;
 	 */
 
-	bdev = blkdev_get_by_dev(sbi->logdev, FMODE_READ | FMODE_WRITE,
+	bdev = blkdev_get_by_dev(sbi->logdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
 				 log, NULL);
 	if (IS_ERR(bdev)) {
 		rc = PTR_ERR(bdev);
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 9be7f958f60e45..70f5563a8e81c7 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -243,7 +243,8 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 	if (!dev)
 		return -EIO;
 
-	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_WRITE, NULL, NULL);
+	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, NULL,
+				 NULL);
 	if (IS_ERR(bdev)) {
 		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
 			MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
@@ -312,7 +313,7 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev = blkdev_get_by_path(devname, FMODE_READ | FMODE_WRITE, NULL,
+	bdev = blkdev_get_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE, NULL,
 				  NULL);
 	if (IS_ERR(bdev)) {
 		pr_warn("pNFS: failed to open device %s (%ld)\n",
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index c6ae9aee01edb9..21472e3ed182aa 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1786,7 +1786,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		goto out2;
 
 	reg->hr_bdev = blkdev_get_by_dev(f.file->f_mapping->host->i_rdev,
-					 FMODE_WRITE | FMODE_READ, NULL, NULL);
+					 BLK_OPEN_WRITE | BLK_OPEN_READ, NULL,
+					 NULL);
 	if (IS_ERR(reg->hr_bdev)) {
 		ret = PTR_ERR(reg->hr_bdev);
 		reg->hr_bdev = NULL;
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 905297ea55458d..62beee3c62b610 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2598,7 +2598,7 @@ static int journal_init_dev(struct super_block *super,
 			    struct reiserfs_journal *journal,
 			    const char *jdev_name)
 {
-	fmode_t blkdev_mode = FMODE_READ;
+	blk_mode_t blkdev_mode = BLK_OPEN_READ;
 	void *holder = journal;
 	int result;
 	dev_t jdev;
@@ -2610,7 +2610,7 @@ static int journal_init_dev(struct super_block *super,
 	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
 
 	if (!bdev_read_only(super->s_bdev))
-		blkdev_mode |= FMODE_WRITE;
+		blkdev_mode |= BLK_OPEN_WRITE;
 
 	/* there is no "jdev" option and journal is on separate device */
 	if ((!jdev_name || !jdev_name[0])) {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 3b7cf8268057fe..67ad1c93763769 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -396,7 +396,7 @@ xfs_blkdev_get(
 {
 	int			error = 0;
 
-	*bdevp = blkdev_get_by_path(name, FMODE_READ | FMODE_WRITE, mp,
+	*bdevp = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE, mp,
 				    &xfs_holder_ops);
 	if (IS_ERR(*bdevp)) {
 		error = PTR_ERR(*bdevp);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6b65623e447c02..824e31dd752acb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -112,6 +112,19 @@ struct blk_integrity {
 	unsigned char				tag_size;
 };
 
+typedef unsigned int __bitwise blk_mode_t;
+
+/* open for reading */
+#define BLK_OPEN_READ		((__force blk_mode_t)(1 << 0))
+/* open for writing */
+#define BLK_OPEN_WRITE		((__force blk_mode_t)(1 << 1))
+/* open exclusively (vs other exclusive openers */
+#define BLK_OPEN_EXCL		((__force blk_mode_t)(1 << 2))
+/* opened with O_NDELAY */
+#define BLK_OPEN_NDELAY		((__force blk_mode_t)(1 << 3))
+/* open for "writes" only for ioctls (specialy hack for floppy.c) */
+#define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
+
 struct gendisk {
 	/*
 	 * major/first_minor/minors should not be set by any new driver, the
@@ -187,6 +200,7 @@ struct gendisk {
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
 	u64 diskseq;
+	blk_mode_t open_mode;
 
 	/*
 	 * Independent sector access ranges. This is always NULL for
@@ -1363,10 +1377,12 @@ struct block_device_operations {
 	void (*submit_bio)(struct bio *bio);
 	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
 			unsigned int flags);
-	int (*open)(struct gendisk *disk, fmode_t mode);
+	int (*open)(struct gendisk *disk, blk_mode_t mode);
 	void (*release)(struct gendisk *disk);
-	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
-	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
+	int (*ioctl)(struct block_device *bdev, blk_mode_t mode,
+			unsigned cmd, unsigned long arg);
+	int (*compat_ioctl)(struct block_device *bdev, blk_mode_t mode,
+			unsigned cmd, unsigned long arg);
 	unsigned int (*check_events) (struct gendisk *disk,
 				      unsigned int clearing);
 	void (*unlock_native_capacity) (struct gendisk *);
@@ -1393,7 +1409,7 @@ struct block_device_operations {
 };
 
 #ifdef CONFIG_COMPAT
-extern int blkdev_compat_ptr_ioctl(struct block_device *, fmode_t,
+extern int blkdev_compat_ptr_ioctl(struct block_device *, blk_mode_t,
 				      unsigned int, unsigned long);
 #else
 #define blkdev_compat_ptr_ioctl NULL
@@ -1455,11 +1471,11 @@ struct blk_holder_ops {
  * as stored in sb->s_flags.
  */
 #define sb_open_mode(flags) \
-	(FMODE_READ | (((flags) & SB_RDONLY) ? 0 : FMODE_WRITE))
+	(BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
-struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
+struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
-struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
+struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 3f23d5239de254..1df724a90f60da 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -13,6 +13,7 @@
 
 #include <linux/fs.h>		/* not really needed, later.. */
 #include <linux/list.h>
+#include <linux/blkdev.h>
 #include <scsi/scsi_common.h>
 #include <uapi/linux/cdrom.h>
 
@@ -101,7 +102,7 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
 		struct cdrom_tocentry *entry);
 
 /* the general block_device operations structure: */
-int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
+int cdrom_open(struct cdrom_device_info *cdi, blk_mode_t mode);
 void cdrom_release(struct cdrom_device_info *cdi);
 int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		unsigned int cmd, unsigned long arg);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index c27b84002d8382..69d0435c7ebb0d 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -166,7 +166,7 @@ void dm_error(const char *message);
 struct dm_dev {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
-	fmode_t mode;
+	blk_mode_t mode;
 	char name[16];
 };
 
@@ -174,7 +174,7 @@ struct dm_dev {
  * Constructors should call these functions to ensure destination devices
  * are opened/closed correctly.
  */
-int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
+int dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 		  struct dm_dev **result);
 void dm_put_device(struct dm_target *ti, struct dm_dev *d);
 
@@ -543,7 +543,7 @@ int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
 /*
  * First create an empty table.
  */
-int dm_table_create(struct dm_table **result, fmode_t mode,
+int dm_table_create(struct dm_table **result, blk_mode_t mode,
 		    unsigned int num_targets, struct mapped_device *md);
 
 /*
@@ -586,7 +586,7 @@ void dm_sync_table(struct mapped_device *md);
  * Queries
  */
 sector_t dm_table_get_size(struct dm_table *t);
-fmode_t dm_table_get_mode(struct dm_table *t);
+blk_mode_t dm_table_get_mode(struct dm_table *t);
 struct mapped_device *dm_table_get_md(struct dm_table *t);
 const char *dm_table_device_name(struct dm_table *t);
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index cc9259307c942a..f6ebcd00c4100b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -356,8 +356,8 @@ static int swsusp_swap_check(void)
 		return res;
 	root_swap = res;
 
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, FMODE_WRITE,
-			NULL, NULL);
+	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
+			BLK_OPEN_WRITE, NULL, NULL);
 	if (IS_ERR(hib_resume_bdev))
 		return PTR_ERR(hib_resume_bdev);
 
@@ -1521,7 +1521,7 @@ int swsusp_check(bool snapshot_test)
 	void *holder = snapshot_test ? &swsusp_holder : NULL;
 	int error;
 
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, FMODE_READ,
+	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
 					    holder, NULL);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 16554256be6554..6bc83060df9a12 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2770,7 +2770,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 
 	if (S_ISBLK(inode->i_mode)) {
 		p->bdev = blkdev_get_by_dev(inode->i_rdev,
-				   FMODE_READ | FMODE_WRITE, p, NULL);
+				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
 		if (IS_ERR(p->bdev)) {
 			error = PTR_ERR(p->bdev);
 			p->bdev = NULL;
-- 
2.39.2

