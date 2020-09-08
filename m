Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD6261DF7
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgIHToW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbgIHPvt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 11:51:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57790C0A3BEB;
        Tue,  8 Sep 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0u/YkNfz2765ChTMinGG6JPDmCovYyDZgG3vdcYFHY8=; b=TDmZ2xXcoGXTNzeEqQje2OrEN0
        tJUThZVnfY/+jhjr38EK96Z6+YKRTzvma5UyzgPRh7rBnLiAu6smazcTVNJL2GUjYgU7SSuo5FIw6
        ERtmOFoZpr7EQQI3bN2vMCSGQGLPSa+ULL/d8fd1NvqvHE3KiRksaH+l+G4xV02UIbqrEUT0c6KfV
        /DcNDGhvUUpyOAbq99PireHT06M1bGrqd1ltn3XFKabhDWF5aF5O+rBgoyOMniVhgb5m91e+98+5x
        R2Uz/l6Kpebqi65qaI5JfVFusWp6YoZ0lNkou9FjXFNtR3vHrdDKCJXc/offPT0YF6vZp3YRLxPD9
        8qka3LmA==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf0L-0002um-9p; Tue, 08 Sep 2020 14:53:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/19] block: add a bdev_check_media_change helper
Date:   Tue,  8 Sep 2020 16:53:29 +0200
Message-Id: <20200908145347.2992670-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908145347.2992670-1-hch@lst.de>
References: <20200908145347.2992670-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Like check_disk_changed, except that it does not call ->revalidate_disk
but leaves that to the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/genhd.c         | 29 ++++++++++++++++++++++++++++-
 fs/block_dev.c        | 17 +++--------------
 include/linux/genhd.h |  2 +-
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 081f1039d9367f..9d060e79eb31d8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -2052,7 +2052,7 @@ void disk_flush_events(struct gendisk *disk, unsigned int mask)
  * CONTEXT:
  * Might sleep.
  */
-unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
+static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
 {
 	struct disk_events *ev = disk->ev;
 	unsigned int pending;
@@ -2090,6 +2090,33 @@ unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
 	return pending;
 }
 
+/**
+ * bdev_check_media_change - check if a removable media has been changed
+ * @bdev: block device to check
+ *
+ * Check whether a removable media has been changed, and attempt to free all
+ * dentries and inodes and invalidates all block device page cache entries in
+ * that case.
+ *
+ * Returns %true if the block device changed, or %false if not.
+ */
+bool bdev_check_media_change(struct block_device *bdev)
+{
+	unsigned int events;
+
+	events = disk_clear_events(bdev->bd_disk, DISK_EVENT_MEDIA_CHANGE |
+				   DISK_EVENT_EJECT_REQUEST);
+	if (!(events & DISK_EVENT_MEDIA_CHANGE))
+		return false;
+
+	if (__invalidate_device(bdev, true))
+		pr_warn("VFS: busy inodes on changed media %s\n",
+			bdev->bd_disk->disk_name);
+	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+	return true;
+}
+EXPORT_SYMBOL(bdev_check_media_change);
+
 /*
  * Separate this part out so that a different pointer for clearing_ptr can be
  * passed in for disk_clear_events.
diff --git a/fs/block_dev.c b/fs/block_dev.c
index c70c41ecba4872..c6ac0bd22eca70 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1379,21 +1379,10 @@ EXPORT_SYMBOL(revalidate_disk_size);
  */
 int check_disk_change(struct block_device *bdev)
 {
-	struct gendisk *disk = bdev->bd_disk;
-	const struct block_device_operations *bdops = disk->fops;
-	unsigned int events;
-
-	events = disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
-				   DISK_EVENT_EJECT_REQUEST);
-	if (!(events & DISK_EVENT_MEDIA_CHANGE))
+	if (!bdev_check_media_change(bdev))
 		return 0;
-
-	if (__invalidate_device(bdev, true))
-		pr_warn("VFS: busy inodes on changed media %s\n",
-			disk->disk_name);
-	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
-	if (bdops->revalidate_disk)
-		bdops->revalidate_disk(bdev->bd_disk);
+	if (bdev->bd_disk->fops->revalidate_disk)
+		bdev->bd_disk->fops->revalidate_disk(bdev->bd_disk);
 	return 1;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c618b27292fcc8..322d48a207728a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,7 +315,6 @@ extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
 void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 		bool update_bdev);
-extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
@@ -372,6 +371,7 @@ void unregister_blkdev(unsigned int major, const char *name);
 
 void revalidate_disk_size(struct gendisk *disk, bool verbose);
 int check_disk_change(struct block_device *bdev);
+bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
-- 
2.28.0

