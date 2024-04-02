Return-Path: <linux-scsi+bounces-3894-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B329895359
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Apr 2024 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52C1B26BC7
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Apr 2024 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48B7FBB1;
	Tue,  2 Apr 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sucqGG3Y"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307017EEE4;
	Tue,  2 Apr 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061555; cv=none; b=P0tWWISuJZ2ptErFSxjcK/iCf9ECe8XZRRlB4hHDBUoM7I5CECPSFxHEiGxiiTmUh7qsReeoT5zHKyiwiTBqPCXvkJoDm3WZ8sSYYzpea0Y2xNgv4UCUVgF5Ad9AP9EJuhRlkOtmwzyDrU/gOErHomCMUu8waEonT1DPqLM8yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061555; c=relaxed/simple;
	bh=SWcDmYUAOAy6ZmoLjJbiaC3tg+KjYcY2XdCTfbTFYxE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHcRTyCsPtt6de3H0xU4zpiXyc6ORNAZbX3PlidDWMQh3Tw6DeVQWuHjdPvaje5o4WzICmTwIeKLiKUnFGYTBRjVk9t/eVwXbt8oxXAhV4nJrAVhCCVk/pJXlPQWaq4y1YdkfbmLMx+XFx4uPoFHjLppGW8EDdAlYLR/AFcEdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sucqGG3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFD5C433F1;
	Tue,  2 Apr 2024 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061554;
	bh=SWcDmYUAOAy6ZmoLjJbiaC3tg+KjYcY2XdCTfbTFYxE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sucqGG3YvkRvEL7m9V4RFyLBZsW+skb8DCVL5QdG22VEfo/YVgDyBZzQQmPsyjSqV
	 Ha9j23ENEAl9V+q7fW+mfJwrYhrgFki2qeONpxs7aMMNaNM6crDN+GKwcwdzYdICGd
	 3ZzimkTFs/Z96w+A8db1IaTFKLHBhFIVkavH++GJ434m2tOdzmR+tmXuxwQlcrTnUc
	 Xb1/AsvuqL4nWNpCiLWAmsitJy0lhznEa3rPDxGS0o0zePwGbLY1KOAZxubR/0YsR1
	 H+6FkqIY0qMXzkTrDzPuNkCQvHVqP3hIXlCoZRmr4iHZJ7o3qvVGYcs1kH7QG0CDj3
	 a5+SsJblLxxLg==
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
Subject: [PATCH v4 03/28] block: Introduce blk_zone_update_request_bio()
Date: Tue,  2 Apr 2024 21:38:42 +0900
Message-ID: <20240402123907.512027-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On completion of a zone append request, the request sector indicates the
location of the written data. This value must be returned to the user
through the BIO iter sector. This is done in 2 places: in
blk_complete_request() and in blk_update_request(). Introduce the inline
helper function blk_zone_update_request_bio() to avoid duplicating
this BIO update for zone append requests, and to compile out this
helper call when CONFIG_BLK_DEV_ZONED is not enabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 11 +++++------
 block/blk.h    | 19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fcbf0953a179..88b541e8873f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -821,8 +821,7 @@ static void blk_complete_request(struct request *req)
 		/* Completion has already been traced */
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 
-		if (req_op(req) == REQ_OP_ZONE_APPEND)
-			bio->bi_iter.bi_sector = req->__sector;
+		blk_zone_update_request_bio(req, bio);
 
 		if (!is_flush)
 			bio_endio(bio);
@@ -923,10 +922,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		bio_advance(bio, bio_bytes);
 
 		/* Don't actually finish bio if it's part of flush sequence */
-		if (!bio->bi_iter.bi_size && !is_flush) {
-			if (req_op(req) == REQ_OP_ZONE_APPEND)
-				bio->bi_iter.bi_sector = req->__sector;
-			bio_endio(bio);
+		if (!bio->bi_iter.bi_size) {
+			blk_zone_update_request_bio(req, bio);
+			if (!is_flush)
+				bio_endio(bio);
 		}
 
 		total_bytes += bio_bytes;
diff --git a/block/blk.h b/block/blk.h
index d9f584984bc4..17786052f32d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -408,12 +408,29 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_free_zone_bitmaps(struct gendisk *disk);
+static inline void blk_zone_update_request_bio(struct request *rq,
+					       struct bio *bio)
+{
+	/*
+	 * For zone append requests, the request sector indicates the location
+	 * at which the BIO data was written. Return this value to the BIO
+	 * issuer through the BIO iter sector.
+	 */
+	if (req_op(rq) == REQ_OP_ZONE_APPEND)
+		bio->bi_iter.bi_sector = rq->__sector;
+}
 int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 		unsigned long arg);
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
 #else /* CONFIG_BLK_DEV_ZONED */
-static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
+static inline void disk_free_zone_bitmaps(struct gendisk *disk)
+{
+}
+static inline void blk_zone_update_request_bio(struct request *rq,
+					       struct bio *bio)
+{
+}
 static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
 		unsigned int cmd, unsigned long arg)
 {
-- 
2.44.0


