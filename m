Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E55579AA
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 04:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfF0CtQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 22:49:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35004 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfF0CtQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 22:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561603755; x=1593139755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lg8pbEXqIGRxgTLVtp82Eq91m5uzXzwMVXBnCRVLznI=;
  b=NiW545gH2omc/buw7VwX6ruBCVzZg8OCBGfOUy1NQZbPxby9QVNgsFyq
   G60KbtjXtWZ9lLxsHUdpf5Jm30XCKdTyzcdqATi0MhvWAK0ru5XsnSv3K
   kLJJgQHFnlWRFnH5uJToOYR+Yz/ItV7gzp9SrYWdkAevi0Bcxwr4RToJH
   XqtPfj2p4KLOQSyB5uVs2Ic8zlv0ZgGQVCacW63YZPeNl66WCOYv/8kwp
   Y9rINzzUBmOaC2BKndHBfRb22xGH5pI75ZF8IbxSP6S3FvKWWYJWA22EC
   nnoqG5kQTAAbLunPba+wQS5PgplHXRVcm2L1EoEwIFy34FEXZ4QNufhK7
   A==;
X-IronPort-AV: E=Sophos;i="5.63,422,1557158400"; 
   d="scan'208";a="218022033"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 10:49:15 +0800
IronPort-SDR: DYd6rgX/eTMCl5tvCyLWEO2p+wohGgxS9B8pusCbhLGN+414JTn4IX5NTl6vsLezm/EPelx5s7
 P1lkTkAfEj3yUJx+Cs24ijrmRscEciUamIiym4GY6dGofUAaRKmZlPlDce4Gn4ek3Ng4GXV/bc
 cxGvJMz9oGCZoEYPA7NNU8ikeqltFTjiEvPD/riw4XNLLQso8efPOSfyM2wjdtFdcmMyF7b6w1
 31fMOv33xV3vYcHMC4WgpWupuvH7YehlvZTISJClxHGYJRcGDVoaiAzNxIpFsIqGxQ3U8uchrJ
 QVsnq4LbJMDR35qyNAZk/ZV2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2019 19:48:24 -0700
IronPort-SDR: l7Q8eErx4O47E08s4VUeN4+1j05XjzrDcO/8OSqhR3Wq6y/kPfq4USFc3NfsLABvaLhOW9/UXM
 S97qAus7EP/h+saCFDvENc85isKBO7n5VkEa4Dczf9yDUKD2MpkbVDxeA8N8tEAN566jafBwDM
 eZGoM03qBqXwF8ziTlFCpichdx+Lo/CcMjL15aQhbyYgUMzb6CT7Lrmy99IP+p4Lc8f8/cQGRF
 Crpj0+/wnVes0JmD2l7u0jj5pXGM7/TOgjvynSuoz0sliE34C7I4/gpjuzKVKCH1tjlZxaRkaR
 WzI=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2019 19:49:15 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V4 3/3] block: Limit zone array allocation size
Date:   Thu, 27 Jun 2019 11:49:10 +0900
Message-Id: <20190627024910.23987-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627024910.23987-1-damien.lemoal@wdc.com>
References: <20190627024910.23987-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Limit the size of the struct blk_zone array used in
blk_revalidate_disk_zones() to avoid memory allocation failures leading
to disk revalidation failure. Further reduce the likelyhood of these
failures by using kvmalloc() instead of directly allocating contiguous
pages.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 29 +++++++++++++----------------
 include/linux/blkdev.h |  5 +++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ae7e91bd0618..26f878b9b5f5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -373,22 +373,20 @@ static inline unsigned long *blk_alloc_zone_bitmap(int node,
  * Allocate an array of struct blk_zone to get nr_zones zone information.
  * The allocated array may be smaller than nr_zones.
  */
-static struct blk_zone *blk_alloc_zones(int node, unsigned int *nr_zones)
+static struct blk_zone *blk_alloc_zones(unsigned int *nr_zones)
 {
-	size_t size = *nr_zones * sizeof(struct blk_zone);
-	struct page *page;
-	int order;
-
-	for (order = get_order(size); order >= 0; order--) {
-		page = alloc_pages_node(node, GFP_NOIO | __GFP_ZERO, order);
-		if (page) {
-			*nr_zones = min_t(unsigned int, *nr_zones,
-				(PAGE_SIZE << order) / sizeof(struct blk_zone));
-			return page_address(page);
-		}
+	struct blk_zone *zones;
+	size_t nrz = min(*nr_zones, BLK_ZONED_REPORT_MAX_ZONES);
+
+	zones = kvcalloc(nrz, sizeof(struct blk_zone), GFP_NOIO);
+	if (!zones) {
+		*nr_zones = 0;
+		return NULL;
 	}
 
-	return NULL;
+	*nr_zones = nrz;
+
+	return zones;
 }
 
 void blk_queue_free_zone_bitmaps(struct request_queue *q)
@@ -443,7 +441,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 
 	/* Get zone information and initialize seq_zones_bitmap */
 	rep_nr_zones = nr_zones;
-	zones = blk_alloc_zones(q->node, &rep_nr_zones);
+	zones = blk_alloc_zones(&rep_nr_zones);
 	if (!zones)
 		goto out;
 
@@ -480,8 +478,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	blk_mq_unfreeze_queue(q);
 
 out:
-	free_pages((unsigned long)zones,
-		   get_order(rep_nr_zones * sizeof(struct blk_zone)));
+	kvfree(zones);
 	kfree(seq_zones_wlock);
 	kfree(seq_zones_bitmap);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..f7faac856017 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -344,6 +344,11 @@ struct queue_limits {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
+/*
+ * Maximum number of zones to report with a single report zones command.
+ */
+#define BLK_ZONED_REPORT_MAX_ZONES	8192U
+
 extern unsigned int blkdev_nr_zones(struct block_device *bdev);
 extern int blkdev_report_zones(struct block_device *bdev,
 			       sector_t sector, struct blk_zone *zones,
-- 
2.21.0

