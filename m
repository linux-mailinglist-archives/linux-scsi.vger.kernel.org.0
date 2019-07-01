Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED755DEF
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 03:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFZBsG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 21:48:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15693 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfFZBsF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 21:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561513685; x=1593049685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lg8pbEXqIGRxgTLVtp82Eq91m5uzXzwMVXBnCRVLznI=;
  b=aQi5wADhiDEtCJ3BHRVBpBE9Lq+sEDSZTwzUI2xP55f5i68X4T+lZ+cC
   Z9CRBaxeSmS9O/CxnAqggbJ84h3M3EqLH5KRAgiCZB3rR36iHOWMC7Xcy
   B/7EGe2BdsLCr0RkSZJj8tUbwVshYuofdMU2l/2/aBNRcFFIF2uX5go8r
   076ERCt0RqeGaS2bUiEUjHIBQy1lL90x6U7mXlhUvgCfiFRXFtr2d+eC5
   dj21VT3dLH1dYcJvG9oSM/u11h3WmTIIkTW6ypBY5tbe86WUa0nDW4p23
   SdCSQxkoGJmpyubKHFwe3Zne3LjnAkvyrfoAMIJxfrbRsV7YMM0NHDTJN
   g==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="116422529"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 09:48:05 +0800
IronPort-SDR: qOTpe0DgvT2kbr4ZRc65rQ/WV56GJ4qjw4c1z2Np58uNJpNj1GXBuTfbv1pRxg5iXd0BpI5y2J
 9hm28/A7T/n59MGXgbqIHT1L3EIyX7CEtUtZvF6svLUehIS7Edg/Gcj2KimP1LwUDwPQu6isdP
 HX65Kf3bVk6Wvtubd8GHcEeUtK+LvMo6TP5kERry4rCorhL/mgHvRncpw8mApoD1upKUY2igb2
 0nL6QC2zxE4RkteTK+WfDfkCpxr3RotmSqqXViVm+LSPyGKjoKLlm2JIfESn18V6Ho788lhJrU
 8qhomkrIjm5HKNwB7zkWl4WQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 25 Jun 2019 18:47:15 -0700
IronPort-SDR: H4nLPmYfq04J07ckE/4WlprUwtVMa0PVFo+Q4P6rLf3po4rMydwLksfkOQmiKuBQDhugAmisGH
 R9f6seEXxfEh1uJdcfV3dAw7G4ReMms/3XKAuanQs6UiR0wYzNeCB7uAuZT8d7aA8NTbdiFFNr
 63YDb/rKnot4mNriGXn5bQTsACiiXwiIwsR5e0O/dnWmo6znvIexi6PMDAuUN/9SY+sIi4Nsgy
 p/pKagM/CJhpylikmnHf40Qg6fMgUtg34ePHfN8zk4nChpttv/c0MXC+hB6fw2sbttCBi9yCAP
 Iak=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2019 18:48:03 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 3/3] block: Limit zone array allocation size
Date:   Wed, 26 Jun 2019 10:47:59 +0900
Message-Id: <20190626014759.15285-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626014759.15285-1-damien.lemoal@wdc.com>
References: <20190626014759.15285-1-damien.lemoal@wdc.com>
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

