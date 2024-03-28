Return-Path: <linux-scsi+bounces-3653-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73788F428
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 01:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD11C3324E
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091EA3D55B;
	Thu, 28 Mar 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiHliGhj"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB13CF73;
	Thu, 28 Mar 2024 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586702; cv=none; b=PVhnuMZ/ePasq6X2761k9NBer/BLKzUI+MLl7OIIiXO9icV1uzh4o6PAZlm7XuKbkclTIH7RtDt0FyxT/DdWZHYrUt4iy06yFC7uMCttdhdSyfgnR7dvowdGgss9YN7RkM6hAy2UgsGvECAytKdeXP4BFqcX0ZXnrjSxhZcw3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586702; c=relaxed/simple;
	bh=e58CEecNGpbFbmbhftT8a75FTxd0JIrk0f7Dep+TNhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taNMZH14cGlWD0yA+BlTqESZGqWXKAxBr6ZIA9+eoMr5pRyXeJAuiTus2p/rwQpgIBf8auUumKqIAq0EGs49KKBwZGUODIv8uGThPdoeuAffaKEH68w0GHGWRSk6rN+vvlRwOcijsZsET+bBkyomugiRFFWXqpN1MM15iiULU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiHliGhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771DEC433F1;
	Thu, 28 Mar 2024 00:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586702;
	bh=e58CEecNGpbFbmbhftT8a75FTxd0JIrk0f7Dep+TNhI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HiHliGhjQBdAqapwFynQ1J5ch32TBEZFKal5FxGTYPiJyh4iUBL0iaI3fOeO3XaRR
	 Sq7xZMN2wxkTwn4NQSRTaRl3FPzQDFk8S98vkuL9yWP9A+onOipt+WElcQk2RttLWG
	 vXmpNT2kDv2KCWh7LRhJDjbAUrGJlisNhf4MbRTkVFSfp5UohhE3avqy/rvS+YgQuD
	 0yTETqChhnbWEoRDKQ/X3Yrmuip9swWu//iIV83eXtvKf1czd6LmEBSslQqiFVI7OI
	 zplBBGmkGSIQo3rlduqUhJ69LEpHIFV5s9MNqzpZUkZZzcGWdnQdZrC4yH22CVEueU
	 buIyAB+26A3DA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 30/30] block: Do not special-case plugging of zone write operations
Date: Thu, 28 Mar 2024 09:44:09 +0900
Message-ID: <20240328004409.594888-31-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the block layer zone write plugging being automatically done for
any write operation to a zone of a zoned block device, a regular request
plugging handled through current->plug can only ever see at most a
single write request per zone. In such case, any potential reordering
of the plugged requests will be harmless. We can thus remove the special
casing for write operations to zones and have these requests plugged as
well. This allows removing the function blk_mq_plug and instead directly
using current->plug where needed.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-core.c       |  6 ------
 block/blk-merge.c      |  3 +--
 block/blk-mq.c         |  7 +------
 block/blk-mq.h         | 31 -------------------------------
 include/linux/blkdev.h | 12 ------------
 5 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e1a5344c2257..47400a4fe851 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -907,12 +907,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
-	/*
-	 * As the requests that require a zone lock are not plugged in the
-	 * first place, directly accessing the plug instead of using
-	 * blk_mq_plug() should not have any consequences during flushing for
-	 * zoned devices.
-	 */
 	blk_flush_plug(current->plug, false);
 
 	/*
diff --git a/block/blk-merge.c b/block/blk-merge.c
index b96466d2ba94..1a9a424212ee 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1112,10 +1112,9 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
-	struct blk_plug *plug;
+	struct blk_plug *plug = current->plug;
 	struct request *rq;
 
-	plug = blk_mq_plug(bio);
 	if (!plug || rq_list_empty(plug->mq_list))
 		return false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 770d636707dc..823ce64610e0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1332,11 +1332,6 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 
 	blk_account_io_start(rq);
 
-	/*
-	 * As plugging can be enabled for passthrough requests on a zoned
-	 * device, directly accessing the plug instead of using blk_mq_plug()
-	 * should not have any consequences.
-	 */
 	if (current->plug && !at_head) {
 		blk_add_rq_to_plug(current->plug, rq);
 		return;
@@ -2924,7 +2919,7 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 void blk_mq_submit_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	struct blk_plug *plug = blk_mq_plug(bio);
+	struct blk_plug *plug = current->plug;
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int nr_segs = 1;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..260beea8e332 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -365,37 +365,6 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
-/*
- * blk_mq_plug() - Get caller context plug
- * @bio : the bio being submitted by the caller context
- *
- * Plugging, by design, may delay the insertion of BIOs into the elevator in
- * order to increase BIO merging opportunities. This however can cause BIO
- * insertion order to change from the order in which submit_bio() is being
- * executed in the case of multiple contexts concurrently issuing BIOs to a
- * device, even if these context are synchronized to tightly control BIO issuing
- * order. While this is not a problem with regular block devices, this ordering
- * change can cause write BIO failures with zoned block devices as these
- * require sequential write patterns to zones. Prevent this from happening by
- * ignoring the plug state of a BIO issuing context if it is for a zoned block
- * device and the BIO to plug is a write operation.
- *
- * Return current->plug if the bio can be plugged and NULL otherwise
- */
-static inline struct blk_plug *blk_mq_plug( struct bio *bio)
-{
-	/* Zoned block device write operation case: do not plug the BIO */
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
-		return NULL;
-
-	/*
-	 * For regular block devices or read operations, use the context plug
-	 * which may be NULL if blk_start_plug() was not executed.
-	 */
-	return current->plug;
-}
-
 /* Free all requests on the list */
 static inline void blk_mq_free_requests(struct list_head *list)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d2b8d7761269..022d78c5136f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1301,18 +1301,6 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 	return disk_zone_no(bdev->bd_disk, sec);
 }
 
-/* Whether write serialization is required for @op on zoned devices. */
-static inline bool op_needs_zoned_write_locking(enum req_op op)
-{
-	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
-}
-
-static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-					  enum req_op op)
-{
-	return bdev_is_zoned(bdev) && op_needs_zoned_write_locking(op);
-}
-
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.44.0


