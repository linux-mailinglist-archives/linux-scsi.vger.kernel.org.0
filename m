Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6472557F5C
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF0J3v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Jun 2019 05:29:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13123 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfF0J3u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Jun 2019 05:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561627789; x=1593163789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kbEPhpOWuZEiLmXFafrzlRcGM3900czchapAYxS100=;
  b=KwVLtB5pczxcHdQd+CAL/7WgEfU40sxE9eFHuQC2/Bwbmb4fZZq0QV56
   nSjTmoQVYbvLFAv2oUH7j/9PYuJ9zYbUB4jYOkXLBMIob6/g3uvhwJDmb
   5fJDfkSVcPG5uSz5GL1lBvmHlEeUSrcZaELB+YGklxkpDSKHru5ZbDzUy
   OaF1mGc/qiUWmCjlohwvl4CK20tJlB3MLaa89TkGy1XspkrNGBsaqeNDQ
   D6OKlYWtitIf3Xy9YxMdxxbF5YLOQyDeLZNz3f+Hikn5msE539+sJ9bL/
   3gtHKLDAjroG8UOG/EgSrq6IF/XeHfAcl8jCtTJzEgBAKv49qb/LHAr3l
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="116545300"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 17:29:49 +0800
IronPort-SDR: 4Yg1pD1hz6eXEwZkc7zbyqrQegDbc7UZ4DYSC3X/ue9dsFVMgbDN3WK2EhTvq7iVE5xj6zJ8rr
 8w4tnfpUtbYg7S80rbaOZ/C0BFVDW3T5rTSAzLD0Nm+eQjsAkArsppJlSnFN0oHtu8x+AMVyba
 ZK29gv9cR2lT0Ado2M5TTBRP9XukQTPqZnhT3N8EvNfyF/W1NEv5NJE6EIjQLtAWQfWyVXEGAd
 ub7tae8inh/PUYeDcAXsoZTyZUQT4IYzfAODheCEXYCadk4pNl5YBBVeEy27yp27VeE6SqYDor
 0iDwxxW8GhbGhtmSTxnwDVA3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Jun 2019 02:28:56 -0700
IronPort-SDR: gQ03/g8/YOcQDuRgQDklGO04gWxw0S5jnK2JczT5a04utq+FCKTI+Bnt2/ylw62fAhTXLtT0De
 SRq77OUV61ZYuA8q+bCg5UP05E94v3hQYFP6LL7GZ8eHODzmXsatUwQB6aYh5MsRd/JGIG/Bj6
 JlV7pcQlCT1m0hC4R2Yo0zaqLhtfW0ogbPsxx5YNMoa/rH7z98Iueo6Uk41qrVJ3zzrl4Vl7kX
 xyPKBOo+q9EX+PM96e/nohhNGJr9vivf5TM2R3NliwYsJZrU9yngZNrTegHjxNAtd48QDHaKxh
 TcQ=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 02:29:48 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Date:   Thu, 27 Jun 2019 18:29:43 +0900
Message-Id: <20190627092944.20957-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627092944.20957-1-damien.lemoal@wdc.com>
References: <20190627092944.20957-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During disk scan and revalidation done with sd_revalidate(), the zones
of a zoned disk are checked using the helper function
blk_revalidate_disk_zones() if a configuration change is detected
(change in the number of zones or zone size). The function
blk_revalidate_disk_zones() issues report_zones calls that are very
large, that is, to obtain zone information for all zones of the disk
with a single command. The size of the report zones command buffer
necessary for such large request generally is lower than the disk
max_hw_sectors and KMALLOC_MAX_SIZE (4MB) and succeeds on boot (no
memory fragmentation), but often fail at run time (e.g. hot-plug
event). This causes the disk revalidation to fail and the disk
capacity to be changed to 0.

This problem can be avoided by using vmalloc() instead of kmalloc() for
the buffer allocation. To limit the amount of memory to be allocated,
this patch also introduces the arbitrary SD_ZBC_REPORT_MAX_ZONES
maximum number of zones to report with a single report zones command.
This limit may be lowered further to satisfy the disk max_hw_sectors
limit. Finally, to ensure that the vmalloc-ed buffer can always be
mapped in a request, the buffer size is further limited to at most
queue_max_segments() pages, allowing successful mapping of the buffer
even in the worst case scenario where none of the buffer pages are
contiguous.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/scsi/sd_zbc.c | 83 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 7334024b64f1..ecd967fb39c1 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/vmalloc.h>
 
 #include <asm/unaligned.h>
 
@@ -50,7 +51,7 @@ static void sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
 /**
  * sd_zbc_do_report_zones - Issue a REPORT ZONES scsi command.
  * @sdkp: The target disk
- * @buf: Buffer to use for the reply
+ * @buf: vmalloc-ed buffer to use for the reply
  * @buflen: the buffer size
  * @lba: Start LBA of the report
  * @partial: Do partial report
@@ -79,6 +80,7 @@ static int sd_zbc_do_report_zones(struct scsi_disk *sdkp, unsigned char *buf,
 	put_unaligned_be32(buflen, &cmd[10]);
 	if (partial)
 		cmd[14] = ZBC_REPORT_ZONE_PARTIAL;
+
 	memset(buf, 0, buflen);
 
 	result = scsi_execute_req(sdp, cmd, DMA_FROM_DEVICE,
@@ -103,6 +105,48 @@ static int sd_zbc_do_report_zones(struct scsi_disk *sdkp, unsigned char *buf,
 	return 0;
 }
 
+/*
+ * Maximum number of zones to get with one report zones command.
+ */
+#define SD_ZBC_REPORT_MAX_ZONES		8192U
+
+/**
+ * Allocate a buffer for report zones reply.
+ * @disk: The target disk
+ * @nr_zones: Maximum number of zones to report
+ * @buflen: Size of the buffer allocated
+ * @gfp_mask: Memory allocation mask
+ *
+ */
+static void *sd_zbc_alloc_report_buffer(struct request_queue *q,
+					unsigned int nr_zones, size_t *buflen,
+					gfp_t gfp_mask)
+{
+	size_t bufsize;
+	void *buf;
+
+	/*
+	 * Report zone buffer size should be at most 64B times the number of
+	 * zones requested plus the 64B reply header, but should be at least
+	 * SECTOR_SIZE for ATA devices.
+	 * Make sure that this size does not exceed the hardware capabilities.
+	 * Furthermore, since the report zone command cannot be split, make
+	 * sure that the allocated buffer can always be mapped by limiting the
+	 * number of pages allocated to the HBA max segments limit.
+	 */
+	nr_zones = min(nr_zones, SD_ZBC_REPORT_MAX_ZONES);
+	bufsize = roundup((nr_zones + 1) * 64, 512);
+	bufsize = min_t(size_t, bufsize,
+			queue_max_hw_sectors(q) << SECTOR_SHIFT);
+	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+
+	buf = __vmalloc(bufsize, gfp_mask, PAGE_KERNEL);
+	if (buf)
+		*buflen = bufsize;
+
+	return buf;
+}
+
 /**
  * sd_zbc_report_zones - Disk report zones operation.
  * @disk: The target disk
@@ -118,9 +162,9 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			gfp_t gfp_mask)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	unsigned int i, buflen, nrz = *nr_zones;
+	unsigned int i, nrz = *nr_zones;
 	unsigned char *buf;
-	size_t offset = 0;
+	size_t buflen = 0, offset = 0;
 	int ret = 0;
 
 	if (!sd_is_zoned(sdkp))
@@ -132,16 +176,14 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	 * without exceeding the device maximum command size. For ATA disks,
 	 * buffers must be aligned to 512B.
 	 */
-	buflen = min(queue_max_hw_sectors(disk->queue) << 9,
-		     roundup((nrz + 1) * 64, 512));
-	buf = kmalloc(buflen, gfp_mask);
+	buf = sd_zbc_alloc_report_buffer(disk->queue, nrz, &buflen, gfp_mask);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
 			sectors_to_logical(sdkp->device, sector), true);
 	if (ret)
-		goto out_free_buf;
+		goto out;
 
 	nrz = min(nrz, get_unaligned_be32(&buf[0]) / 64);
 	for (i = 0; i < nrz; i++) {
@@ -152,8 +194,8 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 
 	*nr_zones = nrz;
 
-out_free_buf:
-	kfree(buf);
+out:
+	kvfree(buf);
 
 	return ret;
 }
@@ -287,8 +329,6 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
 	return 0;
 }
 
-#define SD_ZBC_BUF_SIZE 131072U
-
 /**
  * sd_zbc_check_zones - Check the device capacity and zone sizes
  * @sdkp: Target disk
@@ -304,22 +344,23 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
  */
 static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 {
+	size_t bufsize, buflen;
 	u64 zone_blocks = 0;
 	sector_t max_lba, block = 0;
 	unsigned char *buf;
 	unsigned char *rec;
-	unsigned int buf_len;
-	unsigned int list_length;
 	int ret;
 	u8 same;
 
 	/* Get a buffer */
-	buf = kmalloc(SD_ZBC_BUF_SIZE, GFP_KERNEL);
+	buf = sd_zbc_alloc_report_buffer(sdkp->disk->queue,
+					 SD_ZBC_REPORT_MAX_ZONES,
+					 &bufsize, GFP_NOIO);
 	if (!buf)
 		return -ENOMEM;
 
 	/* Do a report zone to get max_lba and the same field */
-	ret = sd_zbc_do_report_zones(sdkp, buf, SD_ZBC_BUF_SIZE, 0, false);
+	ret = sd_zbc_do_report_zones(sdkp, buf, bufsize, 0, false);
 	if (ret)
 		goto out_free;
 
@@ -355,12 +396,12 @@ static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 	do {
 
 		/* Parse REPORT ZONES header */
-		list_length = get_unaligned_be32(&buf[0]) + 64;
+		buflen = min_t(size_t, get_unaligned_be32(&buf[0]) + 64,
+			       bufsize);
 		rec = buf + 64;
-		buf_len = min(list_length, SD_ZBC_BUF_SIZE);
 
 		/* Parse zone descriptors */
-		while (rec < buf + buf_len) {
+		while (rec < buf + buflen) {
 			u64 this_zone_blocks = get_unaligned_be64(&rec[8]);
 
 			if (zone_blocks == 0) {
@@ -376,8 +417,8 @@ static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 		}
 
 		if (block < sdkp->capacity) {
-			ret = sd_zbc_do_report_zones(sdkp, buf, SD_ZBC_BUF_SIZE,
-						     block, true);
+			ret = sd_zbc_do_report_zones(sdkp, buf, bufsize, block,
+						     true);
 			if (ret)
 				goto out_free;
 		}
@@ -408,7 +449,7 @@ static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 	}
 
 out_free:
-	kfree(buf);
+	kvfree(buf);
 
 	return ret;
 }
-- 
2.21.0

