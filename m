Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC734C5EF
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 05:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbfFTDsO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 23:48:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16771 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfFTDsO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 23:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561002493; x=1592538493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6UQwVQihL8vWmJlX78JrOyWNnPOAvSVkPP7PE41GQfg=;
  b=dQ80/adNiuu1stx8JNrq7cyQFz+w0t9zFwvVJkpTkIuYIwa/puNMr3f5
   3829CTVyuVnuToH5wLCgrKObbtU0NJEkcxvlpOWV/P960WxLkhyxYPj/w
   cYDTkzo3JauPLuP0BMlAChEfsdwRRjX3rnWn5NpkN87Oyqis/JYqfc9pd
   wEMa/VVaDEZAuF1drw3m5bXE7n0Py5teLbsFY4kdYGGUGgFSqaCg6DeoQ
   Z1ATJEGuPO4r8HqGxBhYyyzJHgUa0VKZHcGJBLyJQkq51hYa2hgt3zjlu
   tZf4oroMH+tOg3cUlwpO/6B3qpD0vFBbCRn5vn8QIeJHPO+kl08uyQUg4
   A==;
X-IronPort-AV: E=Sophos;i="5.63,395,1557158400"; 
   d="scan'208";a="111010724"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 11:48:13 +0800
IronPort-SDR: dL/6yH4IEORdwD1vrNnoxKV0WG5zWaJzB86Ph8elEgQsQOOFJK3Q6TvNCHM5E88nxR1gA+eAKV
 AkOcsNOnEa8+g0Dc75BennsnPTNyZxHdO0OKbB2gI5/XVTo4vrojzd78PzjX7nNpxxLIiPPPUs
 IUJSJwMADvUQHg+zhl86ie0c0lOIXO+5zjJFkuRTK55KYdwSdaZmehK9n7HRxou85wyj7GiCnk
 ADOaDocWamkbbvWLLrKpmuolmTJT72ce+Hmi3xovqm1+orpYw0Vzs0EGE5stVMjMZhM6VNp3gJ
 B0nyJWs2fYN8IAI/Qun+TXPs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Jun 2019 20:47:39 -0700
IronPort-SDR: 8SiDX3oAzX+kWXtD3kAT+aYBQtpi9dp4dDJ31pSxVo3d9+XFL57LYG/uBRpFsdpr+pnIwevcEb
 0si1CRaOVBR0nHwN40bn1xqPlM3Jo/zzR9LJxZHhwxCuQAjQAjFKZGzx4ZoDxXB17zwqnTw26X
 x1FhBsVYS9UYuM4xTAO03T+9DMUhgKyjvvukWaCao3aGIlI7RdfEgrpmn5hesK4m+MYJ4OZAL2
 McCUXxQBOEJT6DInyMerbfu0Q42CYRpix5KahThvUOFTvwj01ztUlhkemqmwXMhByNLiGBnN+I
 IyI=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 20:48:13 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH] sd_zbc: Fix report zones buffer allocation
Date:   Thu, 20 Jun 2019 12:48:12 +0900
Message-Id: <20190620034812.3254-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During disk revalidation done with sd_revalidate(), the zones of a
zoned disk zones are checked using the helper function
blk_revalidate_disk_zones() if a zone configuration change is detected
(change in the number of zones or zone size). The function
blk_revalidate_disk_zones() issues report_zones calls that are very
large, that is, to obtain zone information for all zones of the disk
with a single command. The size of the report zones command buffer
necessary for such large request generally is lower than the disk
max_hw_sectors and KMALLOC_MAX_SIZE (4MB) but still very large (e.g.
aboiut 3.5MB for a 15TB disk with 256MB zones). This large report zones
reply buffer allocation with kmalloc succeeds on boot, but frequently
fails at run time, especially for a system under memory pressure. This
causes the disk revalidation to fail and the disk capacity to be
changed to 0.

This problem can be avoided with a more intelligent report zones buffer
allocation. This patch introduces the arbitrary SD_ZBC_REPORT_SIZE
allocation limit of 1MB allowing to fit 16383 zone descriptor for every
report zone command execution, thus allowing a full zone report with 4
or 5 commands for most ZBC/ZAC disks today. This limit may be lowered to
satisfy the disk max_hw_sectors limit. Furthermore, further reduce the
likelyhood of a buffer allocation failure while guaranteeing progress
in the zone report by retrying the buffer allocation with a smaller
size in case kmalloc() fails.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/scsi/sd_zbc.c | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 7334024b64f1..37469d77264e 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -103,6 +103,44 @@ static int sd_zbc_do_report_zones(struct scsi_disk *sdkp, unsigned char *buf,
 	return 0;
 }
 
+/**
+ * Arbitrary maximum report zones buffer size of 1MB, fitting 16383 x 64B zone
+ * descriptors plus the 64B report header.
+ */
+#define SD_ZBC_REPORT_SIZE (16384U * 64U)
+
+/**
+ * Allocate a buffer for report zones.
+ */
+static void *sd_zbc_alloc_report_buffer(struct gendisk *disk, size_t *buflen,
+					gfp_t gfp_mask)
+{
+	struct page *page;
+	size_t bufsize;
+	int order;
+
+	/*
+	 * Limit the command buffer size to the arbitrary SD_ZBC_REPORT_SIZE
+	 * size (1MB), allowing up to 16383 zone descriptors being reported with
+	 * a single command. And make sure that this size does not exceed the
+	 * hardware capabilities. To avoid disk revalidation failures due to
+	 * memory allocation errors, retry the allocation with a smaller buffer
+	 * size if the allocation fails.
+	 */
+	bufsize = min_t(size_t, *buflen, SD_ZBC_REPORT_SIZE);
+	bufsize = min_t(size_t, bufsize,
+			queue_max_hw_sectors(disk->queue) << 9);
+	for (order = get_order(bufsize); order >= 0; order--) {
+		page = alloc_pages(gfp_mask, order);
+		if (page) {
+			*buflen = PAGE_SIZE << order;
+			return page_address(page);
+		}
+	}
+
+	return NULL;
+}
+
 /**
  * sd_zbc_report_zones - Disk report zones operation.
  * @disk: The target disk
@@ -118,9 +156,9 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			gfp_t gfp_mask)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	unsigned int i, buflen, nrz = *nr_zones;
+	unsigned int i, nrz = *nr_zones;
 	unsigned char *buf;
-	size_t offset = 0;
+	size_t buflen, offset = 0;
 	int ret = 0;
 
 	if (!sd_is_zoned(sdkp))
@@ -128,13 +166,11 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		return -EOPNOTSUPP;
 
 	/*
-	 * Get a reply buffer for the number of requested zones plus a header,
-	 * without exceeding the device maximum command size. For ATA disks,
-	 * buffers must be aligned to 512B.
+	 * Try to get a buffer that can fits the requested number of zones plus
+	 * the command reply header, all 64B in size.
 	 */
-	buflen = min(queue_max_hw_sectors(disk->queue) << 9,
-		     roundup((nrz + 1) * 64, 512));
-	buf = kmalloc(buflen, gfp_mask);
+	buflen = (nrz + 1) * 64;
+	buf = sd_zbc_alloc_report_buffer(disk, &buflen, gfp_mask);
 	if (!buf)
 		return -ENOMEM;
 
@@ -153,7 +189,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	*nr_zones = nrz;
 
 out_free_buf:
-	kfree(buf);
+	free_pages((unsigned long)buf, get_order(buflen));
 
 	return ret;
 }
-- 
2.21.0

