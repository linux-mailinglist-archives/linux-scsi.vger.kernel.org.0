Return-Path: <linux-scsi+bounces-11361-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF14A086D7
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jan 2025 06:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32602188B61C
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jan 2025 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AF2063F1;
	Fri, 10 Jan 2025 05:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ht5SV70e"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87E188A3A;
	Fri, 10 Jan 2025 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488065; cv=none; b=EpGjrpEfmtJuC/51KoKfmxlMtyeXhaMdGzEEQzTacDFN3Txy8P3OKZyNlqQuWizCzLziF1GQ/upeiqv0YfpzVIXvyX4OOVeWP3Rdh4qnaEDu90UxmyrYOrBTHosBH/b6y9i+igvXJl+z7DFLCanLcBEVLw4IbpEVyNbBYs4qnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488065; c=relaxed/simple;
	bh=YD8PwwqM/ykv18tHrK4G2H1YtINF0BljolULZRdvWZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lulTp+E3guadNiznQfTjoVh+t0vUK7txuDDHqocLQMSIpyOTUNrW9D3kNPHebdpb0ttty+LitJR023aCcjanTEqHk9HcPuChwMel9paFag6PB5E3wIDAn9V+r7Goz1mPw4Sn1VPhVSz6qj2D26O1qr3zaBCjXnL+ScJeFJqHU40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ht5SV70e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FzOI+jy13btiFS8fSFYwfB6ydfiYqToeAvETLECru2s=; b=ht5SV70eGv2ELktke3Dp48q1QU
	dy0PKXQ42YnVk9cJ3sHyyfWvYNvr01tttRKiV61U5zbblaK0lxX9B+OuWINN9tcWOQxxhqv/Hcicc
	3/Yohg3srC3Bkov8eIk0MiNp4BRlZG/g7Ll28450AIpXu4ptWLEt1/rerBQQJMS1g+kS+zFDA7rdt
	9Gd0CoBlhfXTo/3IxMe4SEYmt/1i02CC1dMOhlF0qZY3lw1YMgZ8NeWR3/TLUgZ2ATnf6Tyc+IgXr
	YMy6wJY9d/+1hqbBui6thfN8YPgARL/0RI7Iv4HXbN+O/EBgU85nMDDEaivmusvfH7d+DlAlZiktq
	73/lmbqQ==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW7rx-0000000E4wS-2C7x;
	Fri, 10 Jan 2025 05:47:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/11] block: add a store_limit operations for sysfs entries
Date: Fri, 10 Jan 2025 06:47:13 +0100
Message-ID: <20250110054726.1499538-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110054726.1499538-1-hch@lst.de>
References: <20250110054726.1499538-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

De-duplicate the code for updating queue limits by adding a store_limit
method that allows having common code handle the actual queue limits
update.

Note that this is a pure refactoring patch and does not address the
existing freeze vs limits lock order problem in the refactored code,
which will be addressed next.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-sysfs.c | 128 ++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 67 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e9f1c82b2f3e..d2aa2177e4ba 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -24,6 +24,8 @@ struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
+	int (*store_limit)(struct gendisk *disk, const char *page,
+			size_t count, struct queue_limits *lim);
 	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
@@ -153,13 +155,11 @@ QUEUE_SYSFS_SHOW_CONST(discard_zeroes_data, 0)
 QUEUE_SYSFS_SHOW_CONST(write_same_max, 0)
 QUEUE_SYSFS_SHOW_CONST(poll_delay, -1)
 
-static ssize_t queue_max_discard_sectors_store(struct gendisk *disk,
-		const char *page, size_t count)
+static int queue_max_discard_sectors_store(struct gendisk *disk,
+		const char *page, size_t count, struct queue_limits *lim)
 {
 	unsigned long max_discard_bytes;
-	struct queue_limits lim;
 	ssize_t ret;
-	int err;
 
 	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
@@ -171,38 +171,28 @@ static ssize_t queue_max_discard_sectors_store(struct gendisk *disk,
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	lim = queue_limits_start_update(disk->queue);
-	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
-	return ret;
+	lim->max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+	return 0;
 }
 
-static ssize_t
-queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count)
+static int
+queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count,
+		struct queue_limits *lim)
 {
 	unsigned long max_sectors_kb;
-	struct queue_limits lim;
 	ssize_t ret;
-	int err;
 
 	ret = queue_var_store(&max_sectors_kb, page, count);
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
-	lim.max_user_sectors = max_sectors_kb << 1;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
-	return ret;
+	lim->max_user_sectors = max_sectors_kb << 1;
+	return 0;
 }
 
 static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
-		size_t count, blk_features_t feature)
+		size_t count, struct queue_limits *lim, blk_features_t feature)
 {
-	struct queue_limits lim;
 	unsigned long val;
 	ssize_t ret;
 
@@ -210,15 +200,11 @@ static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
 	if (val)
-		lim.features |= feature;
+		lim->features |= feature;
 	else
-		lim.features &= ~feature;
-	ret = queue_limits_commit_update(disk->queue, &lim);
-	if (ret)
-		return ret;
-	return count;
+		lim->features &= ~feature;
+	return 0;
 }
 
 #define QUEUE_SYSFS_FEATURE(_name, _feature)				\
@@ -227,10 +213,10 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 	return sysfs_emit(page, "%u\n",					\
 		!!(disk->queue->limits.features & _feature));		\
 }									\
-static ssize_t queue_##_name##_store(struct gendisk *disk,		\
-		const char *page, size_t count)				\
+static int queue_##_name##_store(struct gendisk *disk,			\
+		const char *page, size_t count, struct queue_limits *lim) \
 {									\
-	return queue_feature_store(disk, page, count, _feature);	\
+	return queue_feature_store(disk, page, count, lim, _feature);	\
 }
 
 QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
@@ -273,10 +259,9 @@ static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char *page)
 	return queue_var_show(!!blk_queue_passthrough_stat(disk->queue), page);
 }
 
-static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
-					       const char *page, size_t count)
+static int queue_iostats_passthrough_store(struct gendisk *disk,
+		const char *page, size_t count, struct queue_limits *lim)
 {
-	struct queue_limits lim;
 	unsigned long ios;
 	ssize_t ret;
 
@@ -284,18 +269,13 @@ static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
 	if (ios)
-		lim.flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
+		lim->flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
 	else
-		lim.flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
-
-	ret = queue_limits_commit_update(disk->queue, &lim);
-	if (ret)
-		return ret;
-
-	return count;
+		lim->flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
+	return 0;
 }
+
 static ssize_t queue_nomerges_show(struct gendisk *disk, char *page)
 {
 	return queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
@@ -398,12 +378,10 @@ static ssize_t queue_wc_show(struct gendisk *disk, char *page)
 	return sysfs_emit(page, "write through\n");
 }
 
-static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
-			      size_t count)
+static int queue_wc_store(struct gendisk *disk, const char *page,
+		size_t count, struct queue_limits *lim)
 {
-	struct queue_limits lim;
 	bool disable;
-	int err;
 
 	if (!strncmp(page, "write back", 10)) {
 		disable = false;
@@ -414,15 +392,11 @@ static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
 		return -EINVAL;
 	}
 
-	lim = queue_limits_start_update(disk->queue);
 	if (disable)
-		lim.flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
+		lim->flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
 	else
-		lim.flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
-	return count;
+		lim->flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
+	return 0;
 }
 
 #define QUEUE_RO_ENTRY(_prefix, _name)			\
@@ -438,6 +412,13 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 	.store	= _prefix##_store,			\
 };
 
+#define QUEUE_LIM_RW_ENTRY(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {	\
+	.attr		= { .name = _name, .mode = 0644 },	\
+	.show		= _prefix##_show,			\
+	.store_limit	= _prefix##_store,			\
+}
+
 #define QUEUE_RW_LOAD_MODULE_ENTRY(_prefix, _name)		\
 static struct queue_sysfs_entry _prefix##_entry = {		\
 	.attr		= { .name = _name, .mode = 0644 },	\
@@ -448,7 +429,7 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
 
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
-QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
+QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
@@ -464,7 +445,7 @@ QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
 QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
 QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
 QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
-QUEUE_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
+QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
 QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
@@ -484,11 +465,11 @@ QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
-QUEUE_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
+QUEUE_LIM_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
 QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
-QUEUE_RW_ENTRY(queue_wc, "write_cache");
+QUEUE_LIM_RW_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
@@ -501,10 +482,10 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 	.show = queue_logical_block_size_show,
 };
 
-QUEUE_RW_ENTRY(queue_rotational, "rotational");
-QUEUE_RW_ENTRY(queue_iostats, "iostats");
-QUEUE_RW_ENTRY(queue_add_random, "add_random");
-QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_LIM_RW_ENTRY(queue_rotational, "rotational");
+QUEUE_LIM_RW_ENTRY(queue_iostats, "iostats");
+QUEUE_LIM_RW_ENTRY(queue_add_random, "add_random");
+QUEUE_LIM_RW_ENTRY(queue_stable_writes, "stable_writes");
 
 #ifdef CONFIG_BLK_WBT
 static ssize_t queue_var_store64(s64 *var, const char *page)
@@ -702,7 +683,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct request_queue *q = disk->queue;
 	ssize_t res;
 
-	if (!entry->store)
+	if (!entry->store_limit && !entry->store)
 		return -EIO;
 
 	/*
@@ -713,11 +694,24 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->load_module)
 		entry->load_module(disk, page, length);
 
-	blk_mq_freeze_queue(q);
 	mutex_lock(&q->sysfs_lock);
-	res = entry->store(disk, page, length);
-	mutex_unlock(&q->sysfs_lock);
+	blk_mq_freeze_queue(q);
+	if (entry->store_limit) {
+		struct queue_limits lim = queue_limits_start_update(q);
+
+		res = entry->store_limit(disk, page, length, &lim);
+		if (res < 0) {
+			queue_limits_cancel_update(q);
+		} else {
+			res = queue_limits_commit_update(q, &lim);
+			if (!res)
+				res = length;
+		}
+	} else {
+		res = entry->store(disk, page, length);
+	}
 	blk_mq_unfreeze_queue(q);
+	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
 
-- 
2.45.2


