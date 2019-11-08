Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF693F3DB4
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2019 02:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfKHB5Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Nov 2019 20:57:16 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12762 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHB5P (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Nov 2019 20:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573178235; x=1604714235;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bKM/4aInW/OgAqMFQv0OZJNRf46tFrvXlpwNgWcw2sw=;
  b=J3OVqTrSiHtDkLyqDFqPLEdZuivJPeSN05sU36JKARcxh7xcdYc1Ssc5
   CsN0Nz1WVMElMxos5tqIizrdAGM8oag1cSfayq12h0IEf6RRQ+zmY5v0B
   yHkKjFfWRpRETZ9Vrs7UBN+T4pz6aDpMiOsDp2cHfqTM8OI8xKVD5jOUj
   2ozf+2Z7NxLMAx6MvzXABulHh26yYpEUru4fysTxREMnfxYqvRhmhrhkn
   XZ1DRDvDuJpCsaYBcdZUYLWrVqm+DyXBptdRXdBPI8TxukBTJFUFUussa
   YMI5/XVMxnUvqoDvH/iCUdtVj9uis0qyjK0fLuaMqs2qi3Q0oklKFXd3n
   Q==;
IronPort-SDR: vpw0jBQjSm2ycOzEhWsBGVUyqjZj9ICQfmqa5usz3rJ+uv93fOuLVH9BPo+lulofUFUVSTlt83
 FkloJnYCzfpmox7t5xUIDhMfpdVTZ7ZUCoEaHQbKjfe0eoS8jZcO/YZBkYyF41fOFyMpqapqUL
 IiuqnUxiBnGQIgQPR79O5Q5oGF7lxuZkSGtBapWstF6Z8OqFCUNOwern6VtHEVqQAgBlb6R2H7
 xlO9UwXoAz4sKQwzVoU2vi0zljTlCaU68EI2E6YnnNG2TazMsZomIX2JXLYBGMhK1hi6gzAEIH
 xXA=
X-IronPort-AV: E=Sophos;i="5.68,279,1569254400"; 
   d="scan'208";a="122437213"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2019 09:57:15 +0800
IronPort-SDR: GxpbKG4wIQU0FKhBaF+Q/zueW/c90BSPYbfbDifDclmtm3Vn4pRYYCyI362sYWj8pJlU+LhnU+
 YB+S5kp8oQyHylBL6X9gNU/+/NnXcBOvWOqM3MSreJKevx0b+vXzY4BoSmrW7xD3XyOtgeF//6
 LQB3U27u/NzCftwF/k/7vS61JtA57BUl2LfAPWvlueYpJ3OSjJQuoPu3ycM70wn/fDKzkGRoW5
 R0Ejirdvc4Gty3GKVxZOZTZggVGG+yg1RHk/q/xWVRwlGTJgxyghbhKTBPBQdv8I72DtNBPoi1
 wEHWE9aYc9nGnKmLBHk6d/kD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 17:52:24 -0800
IronPort-SDR: 4CDSQV2+GUtY/DSWWA7Yt1gBV3s2ut6Ip0kWS6IlKPmfz9aw8vAh4foMojfjAlyTPim0pyGsMD
 mGEEU6eq6rRd8UgsEGjut9tEMR4CHv2QWG/j3M0IqThDPNwox1bJjWLJqSgcfa0awC6USbi0Nf
 U9bZJAbu2+rAeYmDFVrAXIp7ruBASpzX6QP6gPPjUByI2iZBnk1Fog/wFVZHvfqYU38/wrLoIg
 o9yNzMe2paRPu3RPanNpjJzi6mGL7Lb94r/a3kJQZCrHpf7XlDJWpWG5Q8/eJD9wrM6unlf8Su
 QDk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2019 17:57:13 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 6/9] null_blk: clean up report zones
Date:   Fri,  8 Nov 2019 10:56:59 +0900
Message-Id: <20191108015702.233102-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108015702.233102-1-damien.lemoal@wdc.com>
References: <20191108015702.233102-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Make the instance name match the method name and define the name to NULL
instead of providing an inline stub, which is rather pointless for a
method call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       | 11 +++--------
 drivers/block/null_blk_main.c  |  2 +-
 drivers/block/null_blk_zoned.c |  4 ++--
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 93c2a3d403da..9bf56fbab091 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -91,8 +91,8 @@ struct nullb {
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_zone_init(struct nullb_device *dev);
 void null_zone_exit(struct nullb_device *dev);
-int null_zone_report(struct gendisk *disk, sector_t sector,
-		     struct blk_zone *zones, unsigned int *nr_zones);
+int null_report_zones(struct gendisk *disk, sector_t sector,
+		      struct blk_zone *zones, unsigned int *nr_zones);
 blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 				enum req_opf op, sector_t sector,
 				sector_t nr_sectors);
@@ -105,12 +105,6 @@ static inline int null_zone_init(struct nullb_device *dev)
 	return -EINVAL;
 }
 static inline void null_zone_exit(struct nullb_device *dev) {}
-static inline int null_zone_report(struct gendisk *disk, sector_t sector,
-				   struct blk_zone *zones,
-				   unsigned int *nr_zones)
-{
-	return -EOPNOTSUPP;
-}
 static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 					     enum req_opf op, sector_t sector,
 					     sector_t nr_sectors)
@@ -123,5 +117,6 @@ static inline size_t null_zone_valid_read_len(struct nullb *nullb,
 {
 	return len;
 }
+#define null_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 89d385bab45b..2687eb36441c 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1444,7 +1444,7 @@ static void null_config_discard(struct nullb *nullb)
 
 static const struct block_device_operations null_ops = {
 	.owner		= THIS_MODULE,
-	.report_zones	= null_zone_report,
+	.report_zones	= null_report_zones,
 };
 
 static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 02f41a3bc4cb..00696f16664b 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -66,8 +66,8 @@ void null_zone_exit(struct nullb_device *dev)
 	kvfree(dev->zones);
 }
 
-int null_zone_report(struct gendisk *disk, sector_t sector,
-		     struct blk_zone *zones, unsigned int *nr_zones)
+int null_report_zones(struct gendisk *disk, sector_t sector,
+		      struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct nullb *nullb = disk->private_data;
 	struct nullb_device *dev = nullb->dev;
-- 
2.23.0

