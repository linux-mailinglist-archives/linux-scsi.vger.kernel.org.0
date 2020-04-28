Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731411BBB74
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Apr 2020 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgD1KqT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Apr 2020 06:46:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15223 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgD1KqQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Apr 2020 06:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070777; x=1619606777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fm7YqfEPJ4zYW7ttyFXRZc2PMKMWSEwogvDYqfLIVNc=;
  b=MVy5tfSGUBcV3nGB3D65+wEyDs8BapfyMzYIv38G/6pfYR31Wgxg+Am6
   ZPVg7X2+m+3rTLKqx27BZyBaeM7rnGAmIuY1aFii8I1u2mdm3pnDKltCB
   rYyVI9ibVznRcVRoXP0ucSuFerLJJxRvWEtPrn4uC2uNAzDHPpMrRLHWT
   7fuO5ECKlgUZ/PQRopAgaea4WD1DAiTVKuVSwyXoCppoamnwYOFngW5cd
   vgx4Ybp/mqsrPrwxaPf6XR/FL0K2htyyu8KmmTiTNP3m7fnSK+HLBphF6
   SwVm4siCCryRJmJJmhqFYc8mpdP+esf7CuVaaElnIe3KccG8IKSjU8Pq/
   w==;
IronPort-SDR: LQmSoVsV5M8WBEihOaNTQ8dqRphQXuxJgerzd2mHUg90hXGDVoe7D+839Rx8lhJqv/eFzRt/7b
 mg66CZ9cF+T6hX46vA8dILzfK5JqG3OEYjEHSfOVYmYM/T9CptqbxynSvTm1bzDpVsSnSOOVwT
 4/QcYF0oklHZamKKT2an/Gh7Xyp56J3EMIkJF4C0+TDPhcSkG/xVX9NyTjCjkZ6o8TiosxEOdg
 cE4B8ReCDbeoi2BigFtnHK4GvH/Czzv3WX5D51SHQ/d6xQ1M48V7CHyMoObxU6QtyfCFhEADzm
 p2E=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886568"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:16 +0800
IronPort-SDR: 0ILhakblu4Nk3+lRyPvCFZUHpiMcSqWfPEkpC+Fjz2zheLD22vQQMY7yr0Iaw+8AdPmoQ3Hnc9
 xgIuZiHc0oMvyMDnkv2uH1hRUQrtsm/aU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:23 -0700
IronPort-SDR: mx8qN2pqtpKWXNSGc/0cha2BtmfMoZQF7sjnLQluH9Vo2ZIwmuWmx8/2cvBuZQTGr7GWtgVdiC
 Zt1HeGiFIXTQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v9 03/11] block: rename __bio_add_pc_page to bio_add_hw_page
Date:   Tue, 28 Apr 2020 19:45:57 +0900
Message-Id: <20200428104605.8143-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Rename __bio_add_pc_page() to bio_add_hw_page() and explicitly pass in a
max_sectors argument.

This max_sectors argument can be used to specify constraints from the
hardware.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[ jth: rebased and made public for blk-map.c ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/bio.c     | 65 ++++++++++++++++++++++++++++++-------------------
 block/blk-map.c |  5 ++--
 block/blk.h     |  4 +--
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20..aad0a6dad4f9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -748,9 +748,14 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return true;
 }
 
-static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned len, unsigned offset,
-		bool *same_page)
+/*
+ * Try to merge a page into a segment, while obeying the hardware segment
+ * size limit.  This is not for normal read/write bios, but for passthrough
+ * or Zone Append operations that we can't split.
+ */
+static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
+				 struct page *page, unsigned len,
+				 unsigned offset, bool *same_page)
 {
 	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
@@ -765,38 +770,32 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
 }
 
 /**
- *	__bio_add_pc_page	- attempt to add page to passthrough bio
- *	@q: the target queue
- *	@bio: destination bio
- *	@page: page to add
- *	@len: vec entry length
- *	@offset: vec entry offset
- *	@same_page: return if the merge happen inside the same page
- *
- *	Attempt to add a page to the bio_vec maplist. This can fail for a
- *	number of reasons, such as the bio being full or target block device
- *	limitations. The target block device must allow bio's up to PAGE_SIZE,
- *	so it is always possible to add a single page to an empty bio.
+ * bio_add_hw_page - attempt to add a page to a bio with hw constraints
+ * @q: the target queue
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ * @max_sectors: maximum number of sectors that can be added
+ * @same_page: return if the segment has been merged inside the same page
  *
- *	This should only be used by passthrough bios.
+ * Add a page to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
  */
-int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool *same_page)
+		unsigned int max_sectors, bool *same_page)
 {
 	struct bio_vec *bvec;
 
-	/*
-	 * cloned bio must not modify vec list
-	 */
-	if (unlikely(bio_flagged(bio, BIO_CLONED)))
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_pc_page(q, bio, page, len, offset, same_page))
+		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
 			return len;
 
 		/*
@@ -823,11 +822,27 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	return len;
 }
 
+/**
+ * bio_add_pc_page	- attempt to add page to passthrough bio
+ * @q: the target queue
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ *
+ * Attempt to add a page to the bio_vec maplist. This can fail for a
+ * number of reasons, such as the bio being full or target block device
+ * limitations. The target block device must allow bio's up to PAGE_SIZE,
+ * so it is always possible to add a single page to an empty bio.
+ *
+ * This should only be used by passthrough bios.
+ */
 int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
-	return __bio_add_pc_page(q, bio, page, len, offset, &same_page);
+	return bio_add_hw_page(q, bio, page, len, offset,
+			queue_max_hw_sectors(q), &same_page);
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
diff --git a/block/blk-map.c b/block/blk-map.c
index b6fa343fea9f..e3e4ac48db45 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -257,6 +257,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 static struct bio *bio_map_user_iov(struct request_queue *q,
 		struct iov_iter *iter, gfp_t gfp_mask)
 {
+	unsigned int max_sectors = queue_max_hw_sectors(q);
 	int j;
 	struct bio *bio;
 	int ret;
@@ -294,8 +295,8 @@ static struct bio *bio_map_user_iov(struct request_queue *q,
 				if (n > bytes)
 					n = bytes;
 
-				if (!__bio_add_pc_page(q, bio, page, n, offs,
-						&same_page)) {
+				if (!bio_add_hw_page(q, bio, page, n, offs,
+						     max_sectors, &same_page)) {
 					if (same_page)
 						put_page(page);
 					break;
diff --git a/block/blk.h b/block/blk.h
index 73bd3b1c6938..1ae3279df712 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -453,8 +453,8 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 
 struct request_queue *__blk_alloc_queue(int node_id);
 
-int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool *same_page);
+		unsigned int max_sectors, bool *same_page);
 
 #endif /* BLK_INTERNAL_H */
-- 
2.24.1

