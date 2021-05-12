Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529DB37B5F5
	for <lists+linux-scsi@lfdr.de>; Wed, 12 May 2021 08:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhELGUm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 May 2021 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhELGUb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 May 2021 02:20:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6407C06175F;
        Tue, 11 May 2021 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mausZijoKljrr3VV+8fZtfAAbWU2lD4443TTtkB+6I4=; b=cklApESAT+Bl6eiwX2eWH3rWtY
        RNVT54bHzk+5kINJbAm8H0ZaxH9lUELMeRzSWdmfB00r9GMjhF4YZhUg72SGQTEsLbPJROYW5nBDx
        o3cSDxl2eHwFSVmBxaEspo8uTp11FdTWght8Sq0y4E2YPUkh9SEg0SQJRJg3dNmeiKZlH6gNuXlCq
        jCi+6rRQ2H8gwJn+TEorJQDYyQ8guDIq4ercX1Mda5iBp65pjFmp3TuR6jTZNTsa1+M22Q0xafvVA
        W8WE36mKmfpVsxKLuAtT+xht1x1L/7cAI6vI9rk17OvoGyfmRJMvP6C/vmejYcwPjj38ZcekJKTp0
        8tJ2JSqA==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgiDH-00A8tD-UO; Wed, 12 May 2021 06:19:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 8/8] block: remove bdget_disk
Date:   Wed, 12 May 2021 08:18:56 +0200
Message-Id: <20210512061856.47075-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512061856.47075-1-hch@lst.de>
References: <20210512061856.47075-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Just opencode the xa_load in the callers, as none of them actually
needs a reference to the bdev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 35 +++++------------------------------
 block/partitions/core.c | 25 ++++++++++++-------------
 include/linux/genhd.h   |  1 -
 3 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 14fd777811fe..a5847560719c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -701,32 +701,6 @@ void blk_request_module(dev_t devt)
 		request_module("block-major-%d", MAJOR(devt));
 }
 
-/**
- * bdget_disk - do bdget() by gendisk and partition number
- * @disk: gendisk of interest
- * @partno: partition number
- *
- * Find partition @partno from @disk, do bdget() on it.
- *
- * CONTEXT:
- * Don't care.
- *
- * RETURNS:
- * Resulting block_device on success, NULL on failure.
- */
-struct block_device *bdget_disk(struct gendisk *disk, int partno)
-{
-	struct block_device *bdev = NULL;
-
-	rcu_read_lock();
-	bdev = xa_load(&disk->part_tbl, partno);
-	if (bdev && !bdgrab(bdev))
-		bdev = NULL;
-	rcu_read_unlock();
-
-	return bdev;
-}
-
 /*
  * print a full list of all partitions - intended for places where the root
  * filesystem can't be mounted and thus to give the victim some idea of what
@@ -1253,13 +1227,14 @@ module_init(proc_genhd_init);
 
 dev_t part_devt(struct gendisk *disk, u8 partno)
 {
-	struct block_device *part = bdget_disk(disk, partno);
+	struct block_device *part;
 	dev_t devt = 0;
 
-	if (part) {
+	rcu_read_lock();
+	part = xa_load(&disk->part_tbl, partno);
+	if (part)
 		devt = part->bd_dev;
-		bdput(part);
-	}
+	rcu_read_unlock();
 
 	return devt;
 }
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 0d33f55a7d78..325368b9de29 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -325,6 +325,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	const char *dname;
 	int err;
 
+	lockdep_assert_held(&disk->open_mutex);
+
 	/*
 	 * disk_max_parts() won't be zero, either GENHD_FL_EXT_DEVT is set
 	 * or 'minors' is passed to alloc_disk().
@@ -464,14 +466,13 @@ int bdev_add_partition(struct block_device *bdev, int partno,
 
 int bdev_del_partition(struct block_device *bdev, int partno)
 {
-	struct block_device *part;
-	int ret;
-
-	part = bdget_disk(bdev->bd_disk, partno);
-	if (!part)
-		return -ENXIO;
+	struct block_device *part = NULL;
+	int ret = -ENXIO;
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
+	part = xa_load(&bdev->bd_disk->part_tbl, partno);
+	if (!part)
+		goto out_unlock;
 
 	ret = -EBUSY;
 	if (part->bd_openers)
@@ -481,21 +482,20 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	ret = 0;
 out_unlock:
 	mutex_unlock(&bdev->bd_disk->open_mutex);
-	bdput(part);
 	return ret;
 }
 
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length)
 {
-	struct block_device *part;
-	int ret = 0;
+	struct block_device *part = NULL;
+	int ret = -ENXIO;
 
-	part = bdget_disk(bdev->bd_disk, partno);
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	part = xa_load(&bdev->bd_disk->part_tbl, partno);
 	if (!part)
-		return -ENXIO;
+		goto out_unlock;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
 	ret = -EINVAL;
 	if (start != part->bd_start_sect)
 		goto out_unlock;
@@ -509,7 +509,6 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 	ret = 0;
 out_unlock:
 	mutex_unlock(&bdev->bd_disk->open_mutex);
-	bdput(part);
 	return ret;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4c4d903caa09..5043e5d9436a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -222,7 +222,6 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 }
 
 extern void del_gendisk(struct gendisk *gp);
-extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
 void set_disk_ro(struct gendisk *disk, bool read_only);
 
-- 
2.30.2

