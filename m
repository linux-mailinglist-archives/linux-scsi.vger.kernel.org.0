Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04F4F6CD8
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Nov 2019 03:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKCjf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 Nov 2019 21:39:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52028 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKCje (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 10 Nov 2019 21:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573439975; x=1604975975;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=FdDMBM8oW2SBfdkbPDmth/Mj8PXjLYk7YajwPtVTjXo=;
  b=P3GpTILIpPb7JVtwqYsfca/xvLIbTMJB/J6oIiBHvoxqE43kPzTferKY
   G+RMtJCpa4L4Am83cO5j1+6wTcny71D8nnmTdg1+jcBlAUOH+rwES9O9Y
   OpB/9B+09NvRGFzImLaREpQ9nw/6Xz9cjpMw7OJHOB6NdeLF77P91G7f9
   JO6ciaaiWfZcvHLoijjhFc5L2ZXAQcTR1kbReOY+fpSfc9QlTOgasVPfG
   TlAzSSQkyK2TdrCwTS/um7UO+xaBp4B9bIdnghFNAKjq71DVY8B7f5JPy
   HeNip4w3/ie2BnNmwYHHdeJULbdUCxLwybSorSB5hx9SOBZXrDWbd3O41
   w==;
IronPort-SDR: mqtF/u73RMx8s/kGkQPbfu5+fMLpFBY6jxw7/WJ/yZtVCZfKyNxaCjOVWlisTh3EbWVnLvZdP9
 Hic/ddv/WCjbANJD1bb4VpJ11ficGyvfEJAwlscvQZ/a2uqHYIkoq9y/oLQg3HonJni6H5HkNf
 GG49h/+8e98oqzEi6RwfNIxtDlp/E8+1MqGscs/IpUUR+SQJr4SsQ89Mu3FMzWYZEQRkypH3bO
 yY3+zoJz7xUDntfxOlET0bsRHOr9hKGj9d+E1LPKSaTW/pUg5f8Qv7YOiR7ice+16NBDo5957g
 894=
X-IronPort-AV: E=Sophos;i="5.68,291,1569254400"; 
   d="scan'208";a="127062960"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2019 10:39:34 +0800
IronPort-SDR: cFvGGPMmo/wcei5u8RsGjy1RlCCexK02zSkGldsdAxvG3bzk/PGNcTz9hrVx6r3L4vbYJH4gcZ
 BnWhA6qvpCvEJjNoWx36BVar472SPCiVOG/yWMREwlZi5j/CpDjGtjTAdJLx4feF0ZVwyeSPiW
 uVlrvLvqSnZTDHVXlUrWESL/rVIT3JCydpdpSfa4rwp/Fd4WwrHG43vzaGje4LSwDnmz0UvVrE
 lzNbzkH73eTeWoE3fz+dDeBS9MDa8CdLBAnVLJt+hrla7ZbIDyT6OHrUrUWljkV5NRlqn0XgRC
 tsxIe6GfBfs25xrnepxNA/7Q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 18:34:39 -0800
IronPort-SDR: 4oxQANO3Le6zwGzSh84WyY/rR6HLvilbmxQhOVSuP4qz734lp+9TQlCDsh2oXnApWZuFEYGinl
 xIbAznCo/WIgVk0WVuLYnczVGMa0iIt+2ucgguDebEO5GaRSSVw+7yUHCC0MR/N7Pv5LBknbKY
 8hDnJaTQgc0y0tK0Dk8bg8RNdNmhFjp2mARQ0sXmp32jMzh3qiY3zMxOqmU+d8P7fnY45nDRVG
 k5oX+zOEY/IrPFo93bYDDT3zTJ3Q0f2d41WyR/BA2m17hxK8GTVWx68OLqKIWNQGOZ+0+6wePk
 56s=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2019 18:39:34 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/9] block: Enhance blk_revalidate_disk_zones()
Date:   Mon, 11 Nov 2019 11:39:22 +0900
Message-Id: <20191111023930.638129-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111023930.638129-1-damien.lemoal@wdc.com>
References: <20191111023930.638129-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For ZBC and ZAC zoned devices, the scsi driver revalidation processing
implemented by sd_revalidate_disk() includes a call to
sd_zbc_read_zones() which executes a full disk zone report used to
check that all zones of the disk are the same size. This processing is
followed by a call to blk_revalidate_disk_zones(), used to initialize
the device request queue zone bitmaps (zone type and zone write lock
bitmaps). To do so, blk_revalidate_disk_zones() also executes a full
device zone report to obtain zone types. As a result, the entire
zoned block device revalidation process includes two full device zone
report.

By moving the zone size checks into blk_revalidate_disk_zones(), this
process can be optimized to a single full device zone report, leading to
shorter device scan and revalidation times. This patch implements this
optimization, reducing the original full device zone report implemented
in sd_zbc_check_zones() to a single, small, report zones command
execution to obtain the size of the first zone of the device. Checks
whether all zones of the device are the same size as the first zone
size are moved to the generic blk_check_zone() function called from
blk_revalidate_disk_zones().

This optimization also has the following benefits:
1) fewer memory allocations in the scsi layer during disk revalidation
   as the potentailly large buffer for zone report execution is not
   needed.
2) Implement zone checks in a generic manner, reducing the burden on
   device driver which only need to obtain the zone size and check that
   this size is a power of 2 number of LBAs. Any new type of zoned
   block device will benefit from this.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-zoned.c     |  62 +++++++++++++++++++++++-
 drivers/scsi/sd_zbc.c | 107 ++++++++----------------------------------
 2 files changed, 80 insertions(+), 89 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 481eaf7d04d4..dae787f67019 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -448,6 +448,58 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q)
 	q->seq_zones_wlock = NULL;
 }
 
+/*
+ * Helper function to check the validity of zones of a zoned block device.
+ */
+static bool blk_zone_valid(struct gendisk *disk, struct blk_zone *zone,
+			   sector_t *sector)
+{
+	struct request_queue *q = disk->queue;
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+	sector_t capacity = get_capacity(disk);
+
+	/*
+	 * All zones must have the same size, with the exception on an eventual
+	 * smaller last zone.
+	 */
+	if (zone->start + zone_sectors < capacity &&
+	    zone->len != zone_sectors) {
+		pr_warn("%s: Invalid zoned device with non constant zone size\n",
+			disk->disk_name);
+		return false;
+	}
+
+	if (zone->start + zone->len >= capacity &&
+	    zone->len > zone_sectors) {
+		pr_warn("%s: Invalid zoned device with larger last zone size\n",
+			disk->disk_name);
+		return false;
+	}
+
+	/* Check for holes in the zone report */
+	if (zone->start != *sector) {
+		pr_warn("%s: Zone gap at sectors %llu..%llu\n",
+			disk->disk_name, *sector, zone->start);
+		return false;
+	}
+
+	/* Check zone type */
+	switch (zone->type) {
+	case BLK_ZONE_TYPE_CONVENTIONAL:
+	case BLK_ZONE_TYPE_SEQWRITE_REQ:
+	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+		break;
+	default:
+		pr_warn("%s: Invalid zone type 0x%x at sectors %llu\n",
+			disk->disk_name, (int)zone->type, zone->start);
+		return false;
+	}
+
+	*sector += zone->len;
+
+	return true;
+}
+
 /**
  * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
  * @disk:	Target disk
@@ -497,7 +549,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (!seq_zones_bitmap)
 		goto out;
 
-	/* Get zone information and initialize seq_zones_bitmap */
+	/*
+	 * Get zone information to check the zones and initialize
+	 * seq_zones_bitmap.
+	 */
 	rep_nr_zones = nr_zones;
 	zones = blk_alloc_zones(&rep_nr_zones);
 	if (!zones)
@@ -511,11 +566,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		if (!nrz)
 			break;
 		for (i = 0; i < nrz; i++) {
+			if (!blk_zone_valid(disk, &zones[i], &sector)) {
+				ret = -ENODEV;
+				goto out;
+			}
 			if (zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL)
 				set_bit(z, seq_zones_bitmap);
 			z++;
 		}
-		sector += nrz * blk_queue_zone_sectors(q);
 	}
 
 	if (WARN_ON(z != nr_zones)) {
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 39f10ec0dfcf..7c4690f26698 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -339,32 +339,19 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
  * Returns the zone size in number of blocks upon success or an error code
  * upon failure.
  */
-static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
+static int sd_zbc_check_zones(struct scsi_disk *sdkp, unsigned char *buf,
+			      u32 *zblocks)
 {
-	size_t bufsize, buflen;
-	unsigned int noio_flag;
+	size_t buflen;
 	u64 zone_blocks = 0;
-	sector_t max_lba, block = 0;
-	unsigned char *buf;
+	sector_t max_lba;
 	unsigned char *rec;
 	int ret;
-	u8 same;
-
-	/* Do all memory allocations as if GFP_NOIO was specified */
-	noio_flag = memalloc_noio_save();
 
-	/* Get a buffer */
-	buf = sd_zbc_alloc_report_buffer(sdkp, SD_ZBC_REPORT_MAX_ZONES,
-					 &bufsize);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	/* Do a report zone to get max_lba and the same field */
-	ret = sd_zbc_do_report_zones(sdkp, buf, bufsize, 0, false);
+	/* Do a report zone to get max_lba and the size of the first zone */
+	ret = sd_zbc_do_report_zones(sdkp, buf, SD_BUF_SIZE, 0, false);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	if (sdkp->rc_basis == 0) {
 		/* The max_lba field is the capacity of this device */
@@ -379,82 +366,28 @@ static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 		}
 	}
 
-	/*
-	 * Check same field: for any value other than 0, we know that all zones
-	 * have the same size.
-	 */
-	same = buf[4] & 0x0f;
-	if (same > 0) {
-		rec = &buf[64];
-		zone_blocks = get_unaligned_be64(&rec[8]);
-		goto out;
-	}
-
-	/*
-	 * Check the size of all zones: all zones must be of
-	 * equal size, except the last zone which can be smaller
-	 * than other zones.
-	 */
-	do {
-
-		/* Parse REPORT ZONES header */
-		buflen = min_t(size_t, get_unaligned_be32(&buf[0]) + 64,
-			       bufsize);
-		rec = buf + 64;
-
-		/* Parse zone descriptors */
-		while (rec < buf + buflen) {
-			u64 this_zone_blocks = get_unaligned_be64(&rec[8]);
-
-			if (zone_blocks == 0) {
-				zone_blocks = this_zone_blocks;
-			} else if (this_zone_blocks != zone_blocks &&
-				   (block + this_zone_blocks < sdkp->capacity
-				    || this_zone_blocks > zone_blocks)) {
-				zone_blocks = 0;
-				goto out;
-			}
-			block += this_zone_blocks;
-			rec += 64;
-		}
-
-		if (block < sdkp->capacity) {
-			ret = sd_zbc_do_report_zones(sdkp, buf, bufsize, block,
-						     true);
-			if (ret)
-				goto out_free;
-		}
-
-	} while (block < sdkp->capacity);
-
-out:
-	if (!zone_blocks) {
-		if (sdkp->first_scan)
-			sd_printk(KERN_NOTICE, sdkp,
-				  "Devices with non constant zone "
-				  "size are not supported\n");
-		ret = -ENODEV;
-	} else if (!is_power_of_2(zone_blocks)) {
+	/* Parse REPORT ZONES header */
+	buflen = min_t(size_t, get_unaligned_be32(&buf[0]) + 64, SD_BUF_SIZE);
+	rec = buf + 64;
+	zone_blocks = get_unaligned_be64(&rec[8]);
+	if (!zone_blocks || !is_power_of_2(zone_blocks)) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Devices with non power of 2 zone "
 				  "size are not supported\n");
-		ret = -ENODEV;
-	} else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
+		return -ENODEV;
+	}
+
+	if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Zone size too large\n");
-		ret = -EFBIG;
-	} else {
-		*zblocks = zone_blocks;
-		ret = 0;
+		return -EFBIG;
 	}
 
-out_free:
-	memalloc_noio_restore(noio_flag);
-	kvfree(buf);
+	*zblocks = zone_blocks;
 
-	return ret;
+	return 0;
 }
 
 int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
@@ -480,7 +413,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	 * Check zone size: only devices with a constant zone size (except
 	 * an eventual last runt zone) that is a power of 2 are supported.
 	 */
-	ret = sd_zbc_check_zones(sdkp, &zone_blocks);
+	ret = sd_zbc_check_zones(sdkp, buf, &zone_blocks);
 	if (ret != 0)
 		goto err;
 
-- 
2.23.0

