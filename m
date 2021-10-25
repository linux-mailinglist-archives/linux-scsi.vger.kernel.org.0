Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABB8438FFD
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Oct 2021 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhJYHJH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Oct 2021 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhJYHII (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 25 Oct 2021 03:08:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D999DC061243;
        Mon, 25 Oct 2021 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=P84v3qAZh9eJN5PqAF0/WHBx7XZAKTrdDTBePU9Rs9M=; b=ojOQdMyzh/mXfjQNbLztBRNvWi
        CsQBulWmc8VK7QkjRcOUtdfL8DDoDxT0WT5nnepdwD2eHZ7rTbhBTZai7eZW/BeUgFvoyE6Auy71K
        TpzSiM95JMX3DHy7b5McQ4PtyGMahVG9WWJRGOyKZxN1b4lDA4Za2xptSjJ5wbdNhapLF42rLqSSw
        WlPkUrmSvtZUX0mB4DoMZw1F3f5TjWvYBVHtf7GS9gTfbLT3Uv6gCgsujoQZfl0aIyyj0wYGJ+bFO
        /cFEcqCz4MHL0eGeJXx2nORAA8qO22PtESa8rzgQdwLcazmmtEaPXrfuKCPgosZgbxlw0RCvwjqZY
        NLv2rD6g==;
Received: from [2001:4bb8:184:6dcb:6093:467a:cccc:351c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meu3A-00FUVj-2G; Mon, 25 Oct 2021 07:05:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH 08/12] block: move blk_steal_bios to blk-mq.c
Date:   Mon, 25 Oct 2021 09:05:13 +0200
Message-Id: <20211025070517.1548584-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025070517.1548584-1-hch@lst.de>
References: <20211025070517.1548584-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Keep all the request based code together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 21 ---------------------
 block/blk-mq.c   | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1ee942266df8d..98cb9d69a4068 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1191,27 +1191,6 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 }
 EXPORT_SYMBOL(disk_end_io_acct);
 
-/*
- * Steal bios from a request and add them to a bio list.
- * The request must not have been partially completed before.
- */
-void blk_steal_bios(struct bio_list *list, struct request *rq)
-{
-	if (rq->bio) {
-		if (list->tail)
-			list->tail->bi_next = rq->bio;
-		else
-			list->head = rq->bio;
-		list->tail = rq->biotail;
-
-		rq->bio = NULL;
-		rq->biotail = NULL;
-	}
-
-	rq->__data_len = 0;
-}
-EXPORT_SYMBOL_GPL(blk_steal_bios);
-
 /**
  * blk_lld_busy - Check if underlying low-level drivers of a device are busy
  * @q : the queue of the device being checked
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a0505099b2ce2..06fb74166aded 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2910,6 +2910,27 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 }
 EXPORT_SYMBOL_GPL(blk_rq_prep_clone);
 
+/*
+ * Steal bios from a request and add them to a bio list.
+ * The request must not have been partially completed before.
+ */
+void blk_steal_bios(struct bio_list *list, struct request *rq)
+{
+	if (rq->bio) {
+		if (list->tail)
+			list->tail->bi_next = rq->bio;
+		else
+			list->head = rq->bio;
+		list->tail = rq->biotail;
+
+		rq->bio = NULL;
+		rq->biotail = NULL;
+	}
+
+	rq->__data_len = 0;
+}
+EXPORT_SYMBOL_GPL(blk_steal_bios);
+
 static size_t order_to_size(unsigned int order)
 {
 	return (size_t)PAGE_SIZE << order;
-- 
2.30.2

