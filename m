Return-Path: <linux-scsi+bounces-11198-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F87A037E8
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jan 2025 07:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04953A2A96
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jan 2025 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81101E0B91;
	Tue,  7 Jan 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fr+rWfYm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEC1DE8AA;
	Tue,  7 Jan 2025 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736231495; cv=none; b=ed1pOwSoTUKAeYXWmcNKGg6og1BbiggDJQ2uuh2RCCldv5DAoctK3xd8Fx+A4hvEbxmgm623Jdc62Exd1Y1XEW0LouLRSCbIoYnUlM0U+CRG9OIdGTQKegVmnKwtdxK/27V2CijtE9/h3uuqhI2ZIKEAaRQ8gMCwWF52V+bP1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736231495; c=relaxed/simple;
	bh=MCQSR0weS3mvFYyac14o1qa2VzluI8UiQyUzor9bU1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg5IacA3drVnvfx2mZg2Nb3aKntniMn47p3UEUod2J5oo9zN9GDBlwk4cc7uPpCcIHHbl10drKVJLEvyD8dN8JzI5upnC92zk2HH1YZvb5EzAfZHbELrpYZObhVHgsL8p194HS8RQ82A2mWaPT+Qy8y0gDzaS0a8uLTMM4I/Fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fr+rWfYm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AXp5b/SaMnyr0NyPtwbboGVI2AIHtcycWI2fx/lObGg=; b=fr+rWfYmj7G6ACym0YWWlsQ0Ph
	IkNVsqpobp/n0St6Mh9CbtLpeqPVoNc6p8TlqxR0gLfIkoJlxKVLAqYH9oW5kxUNeZ9MvFRQAaaSK
	+IykUYe4VC8t3oI567zL34ndDbLs3e92I8rgXuH1ZeQT1pBvKOQZYn+ewbZz1DkjDjFuCLUwL7jo1
	8fBTZ1Vlqpzjf3iv6JxSL4R0zy79QdbrnrLCqdEES6wFugCXo3ecLqfWWj275WxJXsgeRzyTBuHh4
	evpJ5cdIW6dhm/kcPCRSXKIExg6hnXno6FpiLiLF0n24JhagD2J4ygP9nz86ottKC1Pfqhd4cLnPH
	2DpVB2gQ==;
Received: from 2a02-8389-2341-5b80-d467-d75d-35bf-0eb6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d467:d75d:35bf:eb6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tV37g-00000003dqF-3fMc;
	Tue, 07 Jan 2025 06:31:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH 2/8] block: add a queue_limits_commit_update_frozen helper
Date: Tue,  7 Jan 2025 07:30:34 +0100
Message-ID: <20250107063120.1011593-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250107063120.1011593-1-hch@lst.de>
References: <20250107063120.1011593-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper that freezes the queue, updates the queue limits and
unfreezes the queue and convert all open coded versions of that to the
new helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c      |  4 +---
 block/blk-settings.c       | 24 ++++++++++++++++++++++++
 block/blk-zoned.c          |  7 +------
 drivers/block/virtio_blk.c |  4 +---
 drivers/scsi/sd.c          | 17 +++++------------
 drivers/scsi/sr.c          |  5 +----
 include/linux/blkdev.h     |  2 ++
 7 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index b180cac61a9d..013469faa5e7 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -218,9 +218,7 @@ static ssize_t flag_store(struct device *dev, const char *page, size_t count,
 	else
 		lim.integrity.flags |= flag;
 
-	blk_mq_freeze_queue(q);
-	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
+	err = queue_limits_commit_update_frozen(q, &lim);
 	if (err)
 		return err;
 	return count;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index b6b8c580d018..2afc67182efd 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -444,6 +444,30 @@ int queue_limits_commit_update(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(queue_limits_commit_update);
 
+/**
+ * queue_limits_commit_update_frozen - commit an atomic update of queue limits
+ * @q:		queue to update
+ * @lim:	limits to apply
+ *
+ * Apply the limits in @lim that were obtained from queue_limits_start_update()
+ * and updated by the caller to @q.  Freezes the queue before the updated and
+ * unfreezes it after.
+ *
+ * Returns 0 if successful, else a negative error code.
+ */
+int queue_limits_commit_update_frozen(struct request_queue *q,
+		struct queue_limits *lim)
+{
+	int ret;
+
+	blk_mq_freeze_queue(q);
+	ret = queue_limits_commit_update(q, lim);
+	blk_mq_unfreeze_queue(q);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(queue_limits_commit_update_frozen);
+
 /**
  * queue_limits_set - apply queue limits to queue
  * @q:		queue to update
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4b0be40a8ea7..9d08a54c201e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1444,7 +1444,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	unsigned int nr_seq_zones, nr_conv_zones;
 	unsigned int pool_size;
 	struct queue_limits lim;
-	int ret;
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1495,11 +1494,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	blk_mq_freeze_queue(q);
-	ret = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
-
-	return ret;
+	return queue_limits_commit_update_frozen(q, &lim);
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 71a7ffeafb32..bbaa26b523b8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1105,9 +1105,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 	else
 		lim.features &= ~BLK_FEAT_WRITE_CACHE;
-	blk_mq_freeze_queue(disk->queue);
-	i = queue_limits_commit_update(disk->queue, &lim);
-	blk_mq_unfreeze_queue(disk->queue);
+	i = queue_limits_commit_update_frozen(disk->queue, &lim);
 	if (i)
 		return i;
 	return count;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8947dab132d7..af62a8ed8620 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -177,9 +177,8 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 
 		lim = queue_limits_start_update(sdkp->disk->queue);
 		sd_set_flush_flag(sdkp, &lim);
-		blk_mq_freeze_queue(sdkp->disk->queue);
-		ret = queue_limits_commit_update(sdkp->disk->queue, &lim);
-		blk_mq_unfreeze_queue(sdkp->disk->queue);
+		ret = queue_limits_commit_update_frozen(sdkp->disk->queue,
+				&lim);
 		if (ret)
 			return ret;
 		return count;
@@ -483,9 +482,7 @@ provisioning_mode_store(struct device *dev, struct device_attribute *attr,
 
 	lim = queue_limits_start_update(sdkp->disk->queue);
 	sd_config_discard(sdkp, &lim, mode);
-	blk_mq_freeze_queue(sdkp->disk->queue);
-	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
-	blk_mq_unfreeze_queue(sdkp->disk->queue);
+	err = queue_limits_commit_update_frozen(sdkp->disk->queue, &lim);
 	if (err)
 		return err;
 	return count;
@@ -594,9 +591,7 @@ max_write_same_blocks_store(struct device *dev, struct device_attribute *attr,
 
 	lim = queue_limits_start_update(sdkp->disk->queue);
 	sd_config_write_same(sdkp, &lim);
-	blk_mq_freeze_queue(sdkp->disk->queue);
-	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
-	blk_mq_unfreeze_queue(sdkp->disk->queue);
+	err = queue_limits_commit_update_frozen(sdkp->disk->queue, &lim);
 	if (err)
 		return err;
 	return count;
@@ -3803,9 +3798,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	sd_config_write_same(sdkp, &lim);
 	kfree(buffer);
 
-	blk_mq_freeze_queue(sdkp->disk->queue);
-	err = queue_limits_commit_update(sdkp->disk->queue, &lim);
-	blk_mq_unfreeze_queue(sdkp->disk->queue);
+	err = queue_limits_commit_update_frozen(sdkp->disk->queue, &lim);
 	if (err)
 		return err;
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 198bec87bb8e..b17796d5ee66 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -797,10 +797,7 @@ static int get_sectorsize(struct scsi_cd *cd)
 
 	lim = queue_limits_start_update(q);
 	lim.logical_block_size = sector_size;
-	blk_mq_freeze_queue(q);
-	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
-	return err;
+	return queue_limits_commit_update_frozen(q, &lim);
 }
 
 static int get_capabilities(struct scsi_cd *cd)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e781d4e6f92d..13d353351c37 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -952,6 +952,8 @@ queue_limits_start_update(struct request_queue *q)
 	mutex_lock(&q->limits_lock);
 	return q->limits;
 }
+int queue_limits_commit_update_frozen(struct request_queue *q,
+		struct queue_limits *lim);
 int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim);
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
-- 
2.45.2


