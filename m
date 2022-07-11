Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3C567F61
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jul 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGFHEQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jul 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiGFHEN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jul 2022 03:04:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948816312;
        Wed,  6 Jul 2022 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vNH0Q4N3xXjSeujMuTq4H5y0o6pA+J4+EeXQ5TSHAYU=; b=c8dIEG6UGnp7N/x/aGvv0mGRKU
        uvOR6JIZ4J0scU9GFiZ3SlOxGJ96nuC0k0Mmoz7ITqoAYtjLquccQ8gWWEDSpETTaQoK853+Qk8Ml
        /EZ9694AKEi4W/YX5lqNbhtQknXVyYTNarhpCXS853hkSQtToT4TlVXL5176SbI4yU/6kvOnCZrky
        XWBju0UPxMDdsaF8vOqxFtqav/0qDzGf9nnZ2YPeInnNwpapnozWD3Gqp0xIDhkRT4f/ynfSdaSmc
        5yX6nn9HjP0DV7W5WxSF57T0Y7sFrSZQOnPGp2hCfHRQK+hn2TH5/x/qnGW0sWfqgOLzfcEDlhoB6
        vuXGhlKA==;
Received: from [2001:4bb8:189:3c4a:f22c:c36a:4e84:c723] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8z4y-006uxQ-O9; Wed, 06 Jul 2022 07:04:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/16] block: pass a gendisk to blk_queue_set_zoned
Date:   Wed,  6 Jul 2022 09:03:40 +0200
Message-Id: <20220706070350.1703384-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706070350.1703384-1-hch@lst.de>
References: <20220706070350.1703384-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Prepare for storing the zone related field in struct gendisk instead
of struct request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-settings.c           | 9 +++++----
 block/partitions/core.c        | 2 +-
 drivers/block/null_blk/zoned.c | 2 +-
 drivers/nvme/host/zns.c        | 2 +-
 drivers/scsi/sd.c              | 6 +++---
 drivers/scsi/sd_zbc.c          | 2 +-
 include/linux/blkdev.h         | 2 +-
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6ccceb421ed2f..35b7bba306a83 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -893,18 +893,19 @@ static bool disk_has_partitions(struct gendisk *disk)
 }
 
 /**
- * blk_queue_set_zoned - configure a disk queue zoned model.
+ * disk_set_zoned - configure the zoned model for a disk
  * @disk:	the gendisk of the queue to configure
  * @model:	the zoned model to set
  *
- * Set the zoned model of the request queue of @disk according to @model.
+ * Set the zoned model of @disk to @model.
+ *
  * When @model is BLK_ZONED_HM (host managed), this should be called only
  * if zoned block device support is enabled (CONFIG_BLK_DEV_ZONED option).
  * If @model specifies BLK_ZONED_HA (host aware), the effective model used
  * depends on CONFIG_BLK_DEV_ZONED settings and on the existence of partitions
  * on the disk.
  */
-void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
+void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
 	struct request_queue *q = disk->queue;
 
@@ -948,7 +949,7 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		blk_queue_clear_zone_settings(q);
 	}
 }
-EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
+EXPORT_SYMBOL_GPL(disk_set_zoned);
 
 int bdev_alignment_offset(struct block_device *bdev)
 {
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 7dc487f5b03cd..1a45b1dd64918 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -330,7 +330,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	case BLK_ZONED_HA:
 		pr_info("%s: disabling host aware zoned block device support due to partitions\n",
 			disk->disk_name);
-		blk_queue_set_zoned(disk, BLK_ZONED_NONE);
+		disk_set_zoned(disk, BLK_ZONED_NONE);
 		break;
 	case BLK_ZONED_NONE:
 		break;
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 2fdd7b20c224e..b47bbd114058d 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -159,7 +159,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct nullb_device *dev = nullb->dev;
 	struct request_queue *q = nullb->q;
 
-	blk_queue_set_zoned(nullb->disk, BLK_ZONED_HM);
+	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4ef..0ed15c2fd56de 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -109,7 +109,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		goto free_data;
 	}
 
-	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
+	disk_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cb587e488601c..eb02d939dd448 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2934,15 +2934,15 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 
 	if (sdkp->device->type == TYPE_ZBC) {
 		/* Host-managed */
-		blk_queue_set_zoned(sdkp->disk, BLK_ZONED_HM);
+		disk_set_zoned(sdkp->disk, BLK_ZONED_HM);
 	} else {
 		sdkp->zoned = zoned;
 		if (sdkp->zoned == 1) {
 			/* Host-aware */
-			blk_queue_set_zoned(sdkp->disk, BLK_ZONED_HA);
+			disk_set_zoned(sdkp->disk, BLK_ZONED_HA);
 		} else {
 			/* Regular disk or drive managed disk */
-			blk_queue_set_zoned(sdkp->disk, BLK_ZONED_NONE);
+			disk_set_zoned(sdkp->disk, BLK_ZONED_NONE);
 		}
 	}
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 6acc4f406eb8c..0f5823b674685 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -929,7 +929,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 		/*
 		 * This can happen for a host aware disk with partitions.
 		 * The block device zone model was already cleared by
-		 * blk_queue_set_zoned(). Only free the scsi disk zone
+		 * disk_set_zoned(). Only free the scsi disk zone
 		 * information and exit early.
 		 */
 		sd_zbc_free_zone_info(sdkp);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 270cd0c552924..416faa0137820 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -291,7 +291,7 @@ struct queue_limits {
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 			       void *data);
 
-void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
+void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
-- 
2.30.2

