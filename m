Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522E93E9FCD
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Aug 2021 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhHLHun (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Aug 2021 03:50:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51846 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhHLHun (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Aug 2021 03:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628754619; x=1660290619;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OaHm0g4Pt7Dgnern0abkbViMMO5KfKOhJvpYT/SNmVk=;
  b=T6w6cI7mUrVUAeV3vlxhD7Wi4cm32p2C3b/6mbBecUY2h+6WNNbzLSS5
   H/TPjiFQTwn852XFxAkLeHPZafNvO0oepesEdlT+9ANP9dkBeNlbE4U09
   TRWRIUuAJalmck9oUxdF8zilw0poE1E2kiO+STBHtVG5ADMv1O6ZiZmtg
   KJpt1mu3wtzhJp4F+HXfUGjreZLJC615TGxpIxbBez7k7oqFib1D9CrQf
   zAMu7xApDglGPu0mDCxIqTYzhT0UZ+4kUmy+31XZJfRwdkJjBFocn8J8S
   mznrSdnpCjvrnd/WX+8lLaUokUOD21h+8vCF2e6GSvciD0h+wMy212ajc
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,315,1620662400"; 
   d="scan'208";a="177596933"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 15:50:19 +0800
IronPort-SDR: Ij36qF9yE8jXU460vT+rPgSIVA8s0cV7ZxtioXEBu+Z9fdaX/eYofklvUcgDK25TtJZXZ1Conw
 Im7F+j351ML7bQr0IvdeFLSYIcL15+D+PIjWmORWe5iBMITnA91CKEsgGZraafKO2KGuyycI2l
 c9UrZKo7vPUILzMjs5SJEQKZ5jj3chlIRMxKP/jZz1PJJ4vPF+lDVp4aoWAFRP0dS5EQykpmQj
 ZW0U010kGurSFjwc8gZ1lQLmqToQwrwzHGwRwuHBi7LmRR6VPYUC0IzMppKLs3SDC9gQAA+/mt
 zPIByNh2q6YINTG2IqU3BJI4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 00:25:47 -0700
IronPort-SDR: ZqKUMYfPgArYz2yrHzvCWLs/n/tInJNUysJkLhRAcIZa63y2kGmJNDyqZidldaCYCuN4ESY76J
 YW/Es8Ck5wkOgb7p6uWHHF7IMhhAdXI15035cGEo/6lSALjWN5H2D4EpSqlYjpXCjwUowG0TyX
 q4fdYDhH/B1qd1YoXrYLqO4l/csP/hm7x+xFbddpjYtKFFBqqdI8pYTash2odK90KZORDnH8wV
 F5+iq93cL0yEcpdkoSTNdwZc88XYcu4ylQISTXZtFDzZPXi1F4s+PLOWS8C2Q8BgBT6V8I2Gh+
 pQU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2021 00:50:17 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v5 1/5] block: Add concurrent positioning ranges support
Date:   Thu, 12 Aug 2021 16:50:11 +0900
Message-Id: <20210812075015.1090959-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812075015.1090959-1-damien.lemoal@wdc.com>
References: <20210812075015.1090959-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The Concurrent Positioning Ranges VPD page (for SCSI) and Log (for ATA)
contain parameters describing the number of sets of contiguous LBAs that
can be served independently by a single LUN multi-actuator disk. This
patch provides the blk_queue_set_cranges() function allowing a device
driver to signal to the block layer that a disk has multiple actuators,
each one serving a contiguous range of sectors. To describe the set
of sector ranges representing the different actuators of a device, the
data type struct blk_cranges is introduced.

For a device with multiple actuators, a struct blk_cranges is attached
to the device request queue by the disk_set_cranges() function. The
function disk_alloc_cranges() is provided for drivers to allocate this
structure.

The blk_cranges structure contains kobjects (struct kobject) to register
with sysfs the set of sector ranges defined by a device. On initial
device scan, this registration is done from blk_register_queue() using
the block layer internal function disk_register_cranges(). If a driver
calls disk_set_cranges() for a registered queue, e.g. when a device
is revalidated, disk_set_cranges() will execute disk_register_cranges()
to update the queue sysfs attribute files.

The sysfs file structure created starts from the cranges sub-directory
and contains the start sector and number of sectors served by an
actuator, with the information for each actuator grouped in one
directory per actuator. E.g. for a dual actuator drive, we have:

$ tree /sys/block/sdk/queue/cranges/
/sys/block/sdk/queue/cranges/
|-- 0
|   |-- nr_sectors
|   `-- sector
`-- 1
    |-- nr_sectors
    `-- sector

For a regular single actuator device, the cranges directory does not
exist.

Device revalidation may lead to changes to this structure and to the
attribute values. When manipulated, the queue sysfs_lock and
sysfs_dir_lock are held for atomicity, similarly to how the blk-mq and
elevator sysfs queue sub-directories are protected.

The code related to the management of cranges is added in the new
file block/blk-cranges.c.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/Makefile         |   2 +-
 block/blk-cranges.c    | 310 +++++++++++++++++++++++++++++++++++++++++
 block/blk-sysfs.c      |  26 ++--
 block/blk.h            |   4 +
 include/linux/blkdev.h |  29 ++++
 5 files changed, 362 insertions(+), 9 deletions(-)
 create mode 100644 block/blk-cranges.c

diff --git a/block/Makefile b/block/Makefile
index 0d951adce796..7b8a2b969537 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
-			disk-events.o
+			disk-events.o blk-cranges.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
diff --git a/block/blk-cranges.c b/block/blk-cranges.c
new file mode 100644
index 000000000000..9994301414ee
--- /dev/null
+++ b/block/blk-cranges.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Block device concurrent positioning ranges.
+ *
+ *  Copyright (C) 2021 Western Digital Corporation or its Affiliates.
+ */
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+
+#include "blk.h"
+
+static ssize_t blk_crange_sector_show(struct blk_crange *cr, char *page)
+{
+	return sprintf(page, "%llu\n", cr->sector);
+}
+
+static ssize_t blk_crange_nr_sectors_show(struct blk_crange *cr, char *page)
+{
+	return sprintf(page, "%llu\n", cr->nr_sectors);
+}
+
+struct blk_crange_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct blk_crange *cr, char *page);
+};
+
+static struct blk_crange_sysfs_entry blk_crange_sector_entry = {
+	.attr = { .name = "sector", .mode = 0444 },
+	.show = blk_crange_sector_show,
+};
+
+static struct blk_crange_sysfs_entry blk_crange_nr_sectors_entry = {
+	.attr = { .name = "nr_sectors", .mode = 0444 },
+	.show = blk_crange_nr_sectors_show,
+};
+
+static struct attribute *blk_crange_attrs[] = {
+	&blk_crange_sector_entry.attr,
+	&blk_crange_nr_sectors_entry.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(blk_crange);
+
+static ssize_t blk_crange_sysfs_show(struct kobject *kobj,
+				     struct attribute *attr, char *page)
+{
+	struct blk_crange_sysfs_entry *entry =
+		container_of(attr, struct blk_crange_sysfs_entry, attr);
+	struct blk_crange *cr = container_of(kobj, struct blk_crange, kobj);
+	ssize_t ret;
+
+	mutex_lock(&cr->queue->sysfs_lock);
+	ret = entry->show(cr, page);
+	mutex_unlock(&cr->queue->sysfs_lock);
+
+	return ret;
+}
+
+static const struct sysfs_ops blk_crange_sysfs_ops = {
+	.show	= blk_crange_sysfs_show,
+};
+
+/*
+ * crange entries are not freed individually, but alltogether with the
+ * struct blk_cranges and its array of range entries. since kobject_add()
+ * takes a reference on the parent struct blk_cranges kobj, the array of
+ * crange entries cannot be freed until kobject_del() is called for all entries.
+ * So we do not need to do anything here, but still need this nop release
+ * operation to avoid complaints from the kobject code.
+ */
+static void blk_crange_sysfs_nop_release(struct kobject *kobj)
+{
+}
+
+static struct kobj_type blk_crange_ktype = {
+	.sysfs_ops	= &blk_crange_sysfs_ops,
+	.default_groups	= blk_crange_groups,
+	.release	= blk_crange_sysfs_nop_release,
+};
+
+/*
+ * This will be executed only after all range entries are removed
+ * with kobject_del(), at which point, it is safe to free everything,
+ * including the array of range entries.
+ */
+static void blk_cranges_sysfs_release(struct kobject *kobj)
+{
+	struct blk_cranges *cranges =
+		container_of(kobj, struct blk_cranges, kobj);
+
+	kfree(cranges);
+}
+
+static struct kobj_type blk_cranges_ktype = {
+	.release	= blk_cranges_sysfs_release,
+};
+
+/**
+ * disk_register_cranges - register with sysfs a set of concurrent ranges
+ * @disk:		Target disk
+ * @new_cranges:	New set of concurrent ranges
+ *
+ * Register with sysfs a set of concurrent ranges for @disk. If @new_cranges
+ * is not NULL, this set of concurrent ranges is registered and the
+ * old set specified by q->cranges is unregistered. Otherwise, q->cranges
+ * is registered if it is not already.
+ */
+int disk_register_cranges(struct gendisk *disk, struct blk_cranges *new_cranges)
+{
+	struct request_queue *q = disk->queue;
+	struct blk_cranges *cranges;
+	int i, ret;
+
+	lockdep_assert_held(&q->sysfs_dir_lock);
+	lockdep_assert_held(&q->sysfs_lock);
+
+	/* If a new range set is specified, unregister the old one */
+	if (new_cranges) {
+		if (q->cranges)
+			disk_unregister_cranges(disk);
+		q->cranges = new_cranges;
+	}
+
+	cranges = q->cranges;
+	if (!cranges)
+		return 0;
+
+	/*
+	 * At this point, cranges is the new set of sector ranges that needs
+	 * to be registered with sysfs.
+	 */
+	WARN_ON(cranges->sysfs_registered);
+	ret = kobject_init_and_add(&cranges->kobj, &blk_cranges_ktype,
+				   &q->kobj, "%s", "cranges");
+	if (ret) {
+		q->cranges = NULL;
+		kfree(cranges);
+		return ret;
+	}
+
+	for (i = 0; i < cranges->nr_ranges; i++) {
+		cranges->ranges[i].queue = q;
+		ret = kobject_init_and_add(&cranges->ranges[i].kobj,
+					   &blk_crange_ktype, &cranges->kobj,
+					   "%d", i);
+		if (ret) {
+			while (--i >= 0)
+				kobject_del(&cranges->ranges[i].kobj);
+			kobject_del(&cranges->kobj);
+			kobject_put(&cranges->kobj);
+			return ret;
+		}
+	}
+
+	cranges->sysfs_registered = true;
+
+	return 0;
+}
+
+void disk_unregister_cranges(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+	struct blk_cranges *cranges = q->cranges;
+	int i;
+
+	lockdep_assert_held(&q->sysfs_dir_lock);
+	lockdep_assert_held(&q->sysfs_lock);
+
+	if (!cranges)
+		return;
+
+	if (cranges->sysfs_registered) {
+		for (i = 0; i < cranges->nr_ranges; i++)
+			kobject_del(&cranges->ranges[i].kobj);
+		kobject_del(&cranges->kobj);
+		kobject_put(&cranges->kobj);
+	} else {
+		kfree(cranges);
+	}
+
+	q->cranges = NULL;
+}
+
+static bool disk_check_ranges(struct gendisk *disk, struct blk_cranges *cr)
+{
+	sector_t capacity = get_capacity(disk);
+	sector_t min_sector = (sector_t)-1;
+	sector_t max_sector = 0;
+	int i;
+
+	/*
+	 * Sector ranges may overlap but should overall contain all sectors
+	 * within the disk capacity.
+	 */
+	for (i = 0; i < cr->nr_ranges; i++) {
+		min_sector = min(min_sector, cr->ranges[i].sector);
+		max_sector = max(max_sector, cr->ranges[i].sector +
+					     cr->ranges[i].nr_sectors);
+	}
+
+	if (min_sector != 0 || max_sector < capacity) {
+		pr_warn("Invalid concurrent ranges: missing sectors\n");
+		return false;
+	}
+
+	if (max_sector > capacity) {
+		pr_warn("Invalid concurrent ranges: beyond capacity\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool disk_cranges_changed(struct gendisk *disk, struct blk_cranges *new)
+{
+	struct blk_cranges *old = disk->queue->cranges;
+	int i;
+
+	if (!old)
+		return true;
+
+	if (old->nr_ranges != new->nr_ranges)
+		return true;
+
+	for (i = 0; i < old->nr_ranges; i++) {
+		if (new->ranges[i].sector != old->ranges[i].sector ||
+		    new->ranges[i].nr_sectors != old->ranges[i].nr_sectors)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * disk_alloc_cranges - Allocate a concurrent positioning range structure
+ * @disk:	target disk
+ * @nr_ranges:	Number of concurrent ranges
+ *
+ * Allocate a struct blk_cranges structure with @nr_ranges range descriptors.
+ */
+struct blk_cranges *disk_alloc_cranges(struct gendisk *disk, int nr_ranges)
+{
+	struct blk_cranges *cr;
+
+	cr = kzalloc_node(struct_size(cr, ranges, nr_ranges), GFP_KERNEL,
+			  disk->queue->node);
+	if (cr)
+		cr->nr_ranges = nr_ranges;
+	return cr;
+}
+EXPORT_SYMBOL_GPL(disk_alloc_cranges);
+
+/**
+ * disk_set_cranges - Set a disk concurrent positioning ranges
+ * @disk:	target disk
+ * @cr:		concurrent ranges structure
+ *
+ * Set the concurrant positioning ranges information of the request queue
+ * of @disk to @cr. If @cr is NULL and the concurrent ranges structure
+ * already set, if any, is cleared. If there are no differences between
+ * @cr and the concurrent ranges structure already set, @cr is freed.
+ */
+void disk_set_cranges(struct gendisk *disk, struct blk_cranges *cr)
+{
+	struct request_queue *q = disk->queue;
+
+	if (WARN_ON_ONCE(cr && !cr->nr_ranges)) {
+		kfree(cr);
+		cr = NULL;
+	}
+
+	mutex_lock(&q->sysfs_dir_lock);
+	mutex_lock(&q->sysfs_lock);
+
+	if (cr) {
+		if (!disk_check_ranges(disk, cr)) {
+			kfree(cr);
+			cr = NULL;
+			goto reg;
+		}
+
+		if (!disk_cranges_changed(disk, cr)) {
+			kfree(cr);
+			goto unlock;
+		}
+	}
+
+	/*
+	 * This may be called for a registered queue. E.g. during a device
+	 * revalidation. If that is the case, we need to unregister the old
+	 * set of concurrent ranges and register the new set. If the queue
+	 * is not registered, the device request queue registration will
+	 * register the ranges, so only swap in the new set and free the
+	 * old one.
+	 */
+reg:
+	if (blk_queue_registered(q)) {
+		disk_register_cranges(disk, cr);
+	} else {
+		swap(q->cranges, cr);
+		kfree(cr);
+	}
+
+unlock:
+	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->sysfs_dir_lock);
+}
+EXPORT_SYMBOL_GPL(disk_set_cranges);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1832587dce3a..be8e02356a26 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -897,16 +897,15 @@ int blk_register_queue(struct gendisk *disk)
 	}
 
 	mutex_lock(&q->sysfs_lock);
+
+	ret = disk_register_cranges(disk, NULL);
+	if (ret)
+		goto put_dev;
+
 	if (q->elevator) {
 		ret = elv_register_queue(q, false);
-		if (ret) {
-			mutex_unlock(&q->sysfs_lock);
-			mutex_unlock(&q->sysfs_dir_lock);
-			kobject_del(&q->kobj);
-			blk_trace_remove_sysfs(dev);
-			kobject_put(&dev->kobj);
-			return ret;
-		}
+		if (ret)
+			goto put_dev;
 	}
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
@@ -937,6 +936,16 @@ int blk_register_queue(struct gendisk *disk)
 		percpu_ref_switch_to_percpu(&q->q_usage_counter);
 	}
 
+	return ret;
+
+put_dev:
+	disk_unregister_cranges(disk);
+	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->sysfs_dir_lock);
+	kobject_del(&q->kobj);
+	blk_trace_remove_sysfs(dev);
+	kobject_put(&dev->kobj);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
@@ -983,6 +992,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	mutex_lock(&q->sysfs_lock);
 	if (q->elevator)
 		elv_unregister_queue(q);
+	disk_unregister_cranges(disk);
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
 
diff --git a/block/blk.h b/block/blk.h
index 56f33fbcde59..149cd5ef8eeb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -367,4 +367,8 @@ extern struct device_attribute dev_attr_events;
 extern struct device_attribute dev_attr_events_async;
 extern struct device_attribute dev_attr_events_poll_msecs;
 
+int disk_register_cranges(struct gendisk *disk,
+			  struct blk_cranges *new_cranges);
+void disk_unregister_cranges(struct gendisk *disk);
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 07eef02325b4..476fc5104a95 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -377,6 +377,29 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+/*
+ * Concurrent sector ranges: struct blk_crange describes range of
+ * contiguous sectors that can be served by independent resources on the
+ * device. The set of ranges defined in struct blk_cranges must overall
+ * include all sectors within the device capacity.
+ * For a device with multiple ranges, e.g. a single LUN multi-actuator HDD,
+ * requests targeting sectors in different ranges can be executed in parallel.
+ * A request can straddle a range boundary.
+ */
+struct blk_crange {
+	struct kobject		kobj;
+	struct request_queue	*queue;
+	sector_t		sector;
+	sector_t		nr_sectors;
+};
+
+struct blk_cranges {
+	struct kobject		kobj;
+	bool			sysfs_registered;
+	unsigned int		nr_ranges;
+	struct blk_crange	ranges[];
+};
+
 struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
@@ -567,6 +590,9 @@ struct request_queue {
 
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
+
+	/* Concurrent sector ranges */
+	struct blk_cranges	*cranges;
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
@@ -1161,6 +1187,9 @@ extern void blk_queue_required_elevator_features(struct request_queue *q,
 extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 					      struct device *dev);
 
+struct blk_cranges *disk_alloc_cranges(struct gendisk *disk, int nr_ranges);
+void disk_set_cranges(struct gendisk *disk, struct blk_cranges *cr);
+
 /*
  * Number of physical segments as sent to the device.
  *
-- 
2.31.1

