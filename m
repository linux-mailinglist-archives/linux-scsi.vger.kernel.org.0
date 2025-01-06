Return-Path: <linux-scsi+bounces-11145-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0CA020E1
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jan 2025 09:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4EF1885E7D
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jan 2025 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF11D9592;
	Mon,  6 Jan 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1SKCJnsq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421A1D90CB;
	Mon,  6 Jan 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152541; cv=none; b=j56GAQ33NTUJjjncC3/56Z1wjYQ3wrNJU/Qv4/vtFRFxU7h4UvJ5/m6TBJUKrQ9CNJhXRugbS9G9yE8aalIDdqAVEVe6jcKcN6O0prvNVmza7JwWd2DwWCDwnjthvp+zkeum3mrnOdeQecVzkCjCY9txDkiL6fk38gzCSZ21m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152541; c=relaxed/simple;
	bh=U+6jtobhZof1xtiIv2bxIA35GMFfyK3McdZN5lTsWa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5GT+g6oHv2ZEjtq1XGLF30UsiFeOU38LzrR505PQ5fwzcw6C1nt9Bhofh4VgxM/eF25BDqAUj3n/CQaqN470z7fW4/Bw5CcRhcL758HVgrL2Aa41UebC4FkC7sRRWqDk2YxhUgOy0x0bsA0f+rdLpR9OTJdEm7GJ/gsAa4xuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1SKCJnsq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ExBiyZmpA17+YsQ0k/FSXAG5UssGE1UXgSLv2tj7XAc=; b=1SKCJnsqsXetm5ciadhYN6uri5
	PdYB32EWj7InDm4sRDtDHneEE7YbCRqyaesAS4bJkBJu7Nki4U3q9JXXOfA/CLJsNLwLuU5uK9/uK
	l8h0ZPFZeI27YKTNe9A0TpQFj0cmQaBZE1Lkc3vA7EHL1dOHiqnHLKeiUQ3Gv3Fz8eY5DqSdB89VG
	gty6rcyO1sM7zGXTBDZDkqvn3T/UMpH5g+M9sF+lu5Xq/JJ7v25EJqW/4mTUZ3PdnYIB/OfG9E7LX
	DMOm3KyK1VQ1ZuwR6JmE2agPl/VHaO2Qu/XqZRd3vA/R/O3hVZ0ysphyN8wtQPNy5uLN1HCSVA+yV
	3AU0jvtQ==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiaJ-00000000XFL-0SlR;
	Mon, 06 Jan 2025 08:35:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 2/4] block: remove blk_mq_init_bitmaps
Date: Mon,  6 Jan 2025 09:35:09 +0100
Message-ID: <20250106083531.799976-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106083531.799976-1-hch@lst.de>
References: <20250106083531.799976-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The little work done in blk_mq_init_bitmaps is easier done in the only
caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-tag.c | 38 ++++++++++++--------------------------
 block/blk-mq.h     |  3 ---
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2cafcf11ee8b..ab4a66791a20 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -544,30 +544,12 @@ static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 				       node);
 }
 
-int blk_mq_init_bitmaps(struct sbitmap_queue *bitmap_tags,
-			struct sbitmap_queue *breserved_tags,
-			unsigned int queue_depth, unsigned int reserved,
-			int node, int alloc_policy)
-{
-	unsigned int depth = queue_depth - reserved;
-	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;
-
-	if (bt_alloc(bitmap_tags, depth, round_robin, node))
-		return -ENOMEM;
-	if (bt_alloc(breserved_tags, reserved, round_robin, node))
-		goto free_bitmap_tags;
-
-	return 0;
-
-free_bitmap_tags:
-	sbitmap_queue_free(bitmap_tags);
-	return -ENOMEM;
-}
-
 struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 				     unsigned int reserved_tags,
 				     int node, int alloc_policy)
 {
+	unsigned int depth = total_tags - reserved_tags;
+	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;
 	struct blk_mq_tags *tags;
 
 	if (total_tags > BLK_MQ_TAG_MAX) {
@@ -582,14 +564,18 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
+	if (bt_alloc(&tags->bitmap_tags, depth, round_robin, node))
+		goto out_free_tags;
+	if (bt_alloc(&tags->breserved_tags, reserved_tags, round_robin, node))
+		goto out_free_bitmap_tags;
 
-	if (blk_mq_init_bitmaps(&tags->bitmap_tags, &tags->breserved_tags,
-				total_tags, reserved_tags, node,
-				alloc_policy) < 0) {
-		kfree(tags);
-		return NULL;
-	}
 	return tags;
+
+out_free_bitmap_tags:
+	sbitmap_queue_free(&tags->bitmap_tags);
+out_free_tags:
+	kfree(tags);
+	return NULL;
 }
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 89a20fffa4b1..3bb9ea80f9b6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -165,9 +165,6 @@ struct blk_mq_alloc_data {
 struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
 		unsigned int reserved_tags, int node, int alloc_policy);
 void blk_mq_free_tags(struct blk_mq_tags *tags);
-int blk_mq_init_bitmaps(struct sbitmap_queue *bitmap_tags,
-		struct sbitmap_queue *breserved_tags, unsigned int queue_depth,
-		unsigned int reserved, int node, int alloc_policy);
 
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
 unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
-- 
2.45.2


