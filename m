Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2A256C12
	for <lists+linux-scsi@lfdr.de>; Sun, 30 Aug 2020 08:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgH3GZn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Aug 2020 02:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgH3GZM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 30 Aug 2020 02:25:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C80C061573;
        Sat, 29 Aug 2020 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BGQcXkyLbzqk3zkeB3Nq7mBvKscH/vQYZj67kAW9oTY=; b=n4leLOCj/+vIc4Zpqa8/G0I5E3
        EdZXxyGnYRyIs1TpjB6BlN6C8rNL3o2ZLot9pvLp071EhmLbzJ13zNqXHFxt+C6CYFaDHsbBXL4t8
        +l3Ym9gtFAAl2oCcSsY4GAUvl19trJEJ+cNR3Vvq83To3l4wIRsxjAwnrWiR7Is3rdVbAJfCGPdxO
        HQyfYMRVyzOrSC2EG6nIfgJUMQml/Rs+4EMVHvsScWPC5b5X1qdAxIkUjjBO73eE2K6QxSfXajoPX
        tKXoLkdX0n8mCQVIshoJBMKn9/++gpCZfHhKTUidZ3i61nyvnGVsAc4ca+u4Z7Xne4W8n25q/ve/W
        54bIUjrQ==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCGm2-0002Ti-5r; Sun, 30 Aug 2020 06:25:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH 19/19] block: switch gendisk lookup to a simple xarray
Date:   Sun, 30 Aug 2020 08:24:45 +0200
Message-Id: <20200830062445.1199128-20-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830062445.1199128-1-hch@lst.de>
References: <20200830062445.1199128-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Now that bdev_map is only used for finding gendisks, we can use
a simple xarray instead of the regions tracking structure for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 208 ++++++++----------------------------------
 include/linux/genhd.h |   7 --
 2 files changed, 37 insertions(+), 178 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 4cbeff3ec1ef5a..51766a201999ce 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,15 +27,7 @@
 
 static struct kobject *block_depr;
 
-struct bdev_map {
-	struct bdev_map *next;
-	dev_t dev;
-	unsigned long range;
-	struct module *owner;
-	struct kobject *(*probe)(dev_t, int *, void *);
-	int (*lock)(dev_t, void *);
-	void *data;
-} *bdev_map[255];
+static DEFINE_XARRAY(bdev_map);
 static DEFINE_MUTEX(bdev_map_lock);
 
 /* for extended dynamic devt allocation, currently only one major is used */
@@ -649,85 +641,26 @@ static char *bdevt_str(dev_t devt, char *buf)
 	return buf;
 }
 
-/*
- * Register device numbers dev..(dev+range-1)
- * range must be nonzero
- * The hash chain is sorted on range, so that subranges can override.
- */
-void blk_register_region(dev_t devt, unsigned long range, struct module *module,
-			 struct kobject *(*probe)(dev_t, int *, void *),
-			 int (*lock)(dev_t, void *), void *data)
-{
-	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
-	unsigned index = MAJOR(devt);
-	unsigned i;
-	struct bdev_map *p;
-
-	n = min(n, 255u);
-	p = kmalloc_array(n, sizeof(struct bdev_map), GFP_KERNEL);
-	if (p == NULL)
-		return;
-
-	for (i = 0; i < n; i++, p++) {
-		p->owner = module;
-		p->probe = probe;
-		p->lock = lock;
-		p->dev = devt;
-		p->range = range;
-		p->data = data;
-	}
+static void blk_register_region(struct gendisk *disk)
+{
+	int i;
 
 	mutex_lock(&bdev_map_lock);
-	for (i = 0, p -= n; i < n; i++, p++, index++) {
-		struct bdev_map **s = &bdev_map[index % 255];
-		while (*s && (*s)->range < range)
-			s = &(*s)->next;
-		p->next = *s;
-		*s = p;
+	for (i = 0; i < disk->minors; i++) {
+		if (xa_insert(&bdev_map, disk_devt(disk) + i, disk, GFP_KERNEL))
+			WARN_ON_ONCE(1);
 	}
 	mutex_unlock(&bdev_map_lock);
 }
-EXPORT_SYMBOL(blk_register_region);
 
-void blk_unregister_region(dev_t devt, unsigned long range)
+static void blk_unregister_region(struct gendisk *disk)
 {
-	unsigned n = MAJOR(devt + range - 1) - MAJOR(devt) + 1;
-	unsigned index = MAJOR(devt);
-	unsigned i;
-	struct bdev_map *found = NULL;
+	int i;
 
 	mutex_lock(&bdev_map_lock);
-	for (i = 0; i < min(n, 255u); i++, index++) {
-		struct bdev_map **s;
-		for (s = &bdev_map[index % 255]; *s; s = &(*s)->next) {
-			struct bdev_map *p = *s;
-			if (p->dev == devt && p->range == range) {
-				*s = p->next;
-				if (!found)
-					found = p;
-				break;
-			}
-		}
-	}
+	for (i = 0; i < disk->minors; i++)
+		xa_erase(&bdev_map, disk_devt(disk) + i);
 	mutex_unlock(&bdev_map_lock);
-	kfree(found);
-}
-EXPORT_SYMBOL(blk_unregister_region);
-
-static struct kobject *exact_match(dev_t devt, int *partno, void *data)
-{
-	struct gendisk *p = data;
-
-	return &disk_to_dev(p)->kobj;
-}
-
-static int exact_lock(dev_t devt, void *data)
-{
-	struct gendisk *p = data;
-
-	if (!get_disk_and_module(p))
-		return -1;
-	return 0;
 }
 
 static void register_disk(struct device *parent, struct gendisk *disk,
@@ -878,8 +811,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
 		bdi_set_owner(bdi, dev);
-		blk_register_region(disk_devt(disk), disk->minors, NULL,
-				    exact_match, exact_lock, disk);
+		blk_register_region(disk);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
@@ -987,7 +919,7 @@ void del_gendisk(struct gendisk *disk)
 		 */
 		bdi_unregister(disk->queue->backing_dev_info);
 		blk_unregister_queue(disk);
-		blk_unregister_region(disk_devt(disk), disk->minors);
+		blk_unregister_region(disk);
 	} else {
 		blk_unregister_queue(disk);
 	}
@@ -1057,54 +989,22 @@ static void request_gendisk_module(dev_t devt)
 		request_module("block-major-%d", MAJOR(devt));
 }
 
-static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
+static bool get_disk_and_module(struct gendisk *disk)
 {
-	struct kobject *kobj;
-	struct bdev_map *p;
-	unsigned long best = ~0UL;
-
-retry:
-	mutex_lock(&bdev_map_lock);
-	for (p = bdev_map[MAJOR(dev) % 255]; p; p = p->next) {
-		struct kobject *(*probe)(dev_t, int *, void *);
-		struct module *owner;
-		void *data;
-
-		if (p->dev > dev || p->dev + p->range - 1 < dev)
-			continue;
-		if (p->range - 1 >= best)
-			break;
-		if (!try_module_get(p->owner))
-			continue;
-		owner = p->owner;
-		data = p->data;
-		probe = p->probe;
-		best = p->range - 1;
-		*partno = dev - p->dev;
-
-		if (!probe) {
-			mutex_unlock(&bdev_map_lock);
-			module_put(owner);
-			request_gendisk_module(dev);
-			goto retry;
-		}
+	struct module *owner;
 
-		if (p->lock && p->lock(dev, data) < 0) {
-			module_put(owner);
-			continue;
-		}
-		mutex_unlock(&bdev_map_lock);
-		kobj = probe(dev, partno, data);
-		/* Currently ->owner protects _only_ ->probe() itself. */
+	if (!disk->fops)
+		return false;
+	owner = disk->fops->owner;
+	if (owner && !try_module_get(owner))
+		return false;
+	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj)) {
 		module_put(owner);
-		if (kobj)
-			return dev_to_disk(kobj_to_dev(kobj));
-		goto retry;
+		return false;
 	}
-	mutex_unlock(&bdev_map_lock);
-	return NULL;
-}
+	return true;
 
+}
 
 /**
  * get_gendisk - get partitioning information for a given device
@@ -1123,7 +1023,19 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	might_sleep();
 
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
-		disk = lookup_gendisk(devt, partno);
+		mutex_lock(&bdev_map_lock);
+		disk = xa_load(&bdev_map, devt);
+		if (!disk) {
+			mutex_unlock(&bdev_map_lock);
+			request_gendisk_module(devt);
+			mutex_lock(&bdev_map_lock);
+			disk = xa_load(&bdev_map, devt);
+		}
+		if (disk && !get_disk_and_module(disk))
+			disk = NULL;
+		if (disk)
+			*partno = devt - disk_devt(disk);
+		mutex_unlock(&bdev_map_lock);
 	} else {
 		struct hd_struct *part;
 
@@ -1327,21 +1239,6 @@ static const struct seq_operations partitions_op = {
 };
 #endif
 
-static void bdev_map_init(void)
-{
-	struct bdev_map *base;
-	int i;
-
-	base = kzalloc(sizeof(*base), GFP_KERNEL);
-	if (!base)
-		panic("cannot allocate bdev_map");
-
-	base->dev = 1;
-	base->range = ~0 ;
-	for (i = 0; i < 255; i++)
-		bdev_map[i] = base;
-}
-
 static int __init genhd_device_init(void)
 {
 	int error;
@@ -1350,7 +1247,6 @@ static int __init genhd_device_init(void)
 	error = class_register(&block_class);
 	if (unlikely(error))
 		return error;
-	bdev_map_init();
 	blk_dev_init();
 
 	register_blkdev(BLOCK_EXT_MAJOR, "blkext");
@@ -1896,35 +1792,6 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
-/**
- * get_disk_and_module - increments the gendisk and gendisk fops module refcount
- * @disk: the struct gendisk to increment the refcount for
- *
- * This increments the refcount for the struct gendisk, and the gendisk's
- * fops module owner.
- *
- * Context: Any context.
- */
-struct kobject *get_disk_and_module(struct gendisk *disk)
-{
-	struct module *owner;
-	struct kobject *kobj;
-
-	if (!disk->fops)
-		return NULL;
-	owner = disk->fops->owner;
-	if (owner && !try_module_get(owner))
-		return NULL;
-	kobj = kobject_get_unless_zero(&disk_to_dev(disk)->kobj);
-	if (kobj == NULL) {
-		module_put(owner);
-		return NULL;
-	}
-	return kobj;
-
-}
-EXPORT_SYMBOL(get_disk_and_module);
-
 /**
  * put_disk - decrements the gendisk refcount
  * @disk: the struct gendisk to decrement the refcount for
@@ -1961,7 +1828,6 @@ void put_disk_and_module(struct gendisk *disk)
 		module_put(owner);
 	}
 }
-EXPORT_SYMBOL(put_disk_and_module);
 
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c0bde190a3dd0c..c6bdc8ce69bd87 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -341,15 +341,8 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct block_device *bdev);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
 extern void put_disk_and_module(struct gendisk *disk);
-extern void blk_register_region(dev_t devt, unsigned long range,
-			struct module *module,
-			struct kobject *(*probe)(dev_t, int *, void *),
-			int (*lock)(dev_t, void *),
-			void *data);
-extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 #define alloc_disk_node(minors, node_id)				\
 ({									\
-- 
2.28.0

