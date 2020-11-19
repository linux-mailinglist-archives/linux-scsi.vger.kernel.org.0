Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7970E2B8F44
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKSJrb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 04:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgKSJr3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 04:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605779247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WqUQXD0yDgunr1vSaHKO5cUB8OIZ/9r3wJKM95xE+M=;
        b=LbSoirJeBukPWx3aVDk5zcfsq1N8xjtozBogCTcWpaQwjx86hER7LQNZFQs1jmLKcVvxO7
        +SFqRj8VxBIENxwqKHjw5FM+WfnW6FaD7PdlSkk3lc4LG3E5VTUnEdt5cghantpOT1RqpE
        YusNeEOEnF88Pm0MvavWuNJrFQGPiX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-BMSXl6tLNUuvhQ6u1kwKTQ-1; Thu, 19 Nov 2020 04:47:25 -0500
X-MC-Unique: BMSXl6tLNUuvhQ6u1kwKTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A03E68144E1;
        Thu, 19 Nov 2020 09:47:23 +0000 (UTC)
Received: from localhost (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D206210013BD;
        Thu, 19 Nov 2020 09:47:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 02/13] sbitmap: maintain allocation round_robin in sbitmap
Date:   Thu, 19 Nov 2020 17:46:54 +0800
Message-Id: <20201119094705.280390-3-ming.lei@redhat.com>
In-Reply-To: <20201119094705.280390-1-ming.lei@redhat.com>
References: <20201119094705.280390-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Now allocation round_robin info is maintained by sbitmap_queue.

Actually, bit allocation belongs to sbitmap. Also the following
patch will move alloc_hint to sbitmap for users with high depth.

So move round_robin to sbitmap.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c          |  2 +-
 block/kyber-iosched.c   |  3 ++-
 include/linux/sbitmap.h | 20 ++++++++++----------
 lib/sbitmap.c           | 28 ++++++++++++++--------------
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..33b94ca9d0e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2688,7 +2688,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 		goto free_cpumask;
 
 	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
-				gfp, node))
+				gfp, node, false))
 		goto free_ctxs;
 	hctx->nr_ctx = 0;
 
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index dc89199bc8c6..cc8bcfe1d587 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -479,7 +479,8 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
 		if (sbitmap_init_node(&khd->kcq_map[i], hctx->nr_ctx,
-				      ilog2(8), GFP_KERNEL, hctx->numa_node)) {
+				      ilog2(8), GFP_KERNEL, hctx->numa_node,
+				      false)) {
 			while (--i >= 0)
 				sbitmap_free(&khd->kcq_map[i]);
 			goto err_kcqs;
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 51edc05489cb..68097b052ec3 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -61,6 +61,11 @@ struct sbitmap {
 	 */
 	unsigned int map_nr;
 
+	/**
+	 * @round_robin: Allocate bits in strict round-robin order.
+	 */
+	bool round_robin;
+
 	/**
 	 * @map: Allocated bitmap.
 	 */
@@ -129,11 +134,6 @@ struct sbitmap_queue {
 	 */
 	atomic_t ws_active;
 
-	/**
-	 * @round_robin: Allocate bits in strict round-robin order.
-	 */
-	bool round_robin;
-
 	/**
 	 * @min_shallow_depth: The minimum shallow depth which may be passed to
 	 * sbitmap_queue_get_shallow() or __sbitmap_queue_get_shallow().
@@ -149,11 +149,14 @@ struct sbitmap_queue {
  *         given, a good default is chosen.
  * @flags: Allocation flags.
  * @node: Memory node to allocate on.
+ * @round_robin: If true, be stricter about allocation order; always allocate
+ *               starting from the last allocated bit. This is less efficient
+ *               than the default behavior (false).
  *
  * Return: Zero on success or negative errno on failure.
  */
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
-		      gfp_t flags, int node);
+		      gfp_t flags, int node, bool round_robin);
 
 /**
  * sbitmap_free() - Free memory used by a &struct sbitmap.
@@ -179,15 +182,12 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
  * sbitmap_get() - Try to allocate a free bit from a &struct sbitmap.
  * @sb: Bitmap to allocate from.
  * @alloc_hint: Hint for where to start searching for a free bit.
- * @round_robin: If true, be stricter about allocation order; always allocate
- *               starting from the last allocated bit. This is less efficient
- *               than the default behavior (false).
  *
  * This operation provides acquire barrier semantics if it succeeds.
  *
  * Return: Non-negative allocated bit number if successful, -1 otherwise.
  */
-int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin);
+int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint);
 
 /**
  * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 267aa7709416..8d920d66d42a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -42,7 +42,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 }
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
-		      gfp_t flags, int node)
+		      gfp_t flags, int node, bool round_robin)
 {
 	unsigned int bits_per_word;
 	unsigned int i;
@@ -67,6 +67,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	sb->shift = shift;
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
+	sb->round_robin = round_robin;
 
 	if (depth == 0) {
 		sb->map = NULL;
@@ -137,14 +138,14 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 }
 
 static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
-				     unsigned int alloc_hint, bool round_robin)
+				     unsigned int alloc_hint)
 {
 	int nr;
 
 	do {
 		nr = __sbitmap_get_word(&sb->map[index].word,
 					sb->map[index].depth, alloc_hint,
-					!round_robin);
+					!sb->round_robin);
 		if (nr != -1)
 			break;
 		if (!sbitmap_deferred_clear(sb, index))
@@ -154,7 +155,7 @@ static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
 	return nr;
 }
 
-int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
+int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
 {
 	unsigned int i, index;
 	int nr = -1;
@@ -166,14 +167,13 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 	 * alloc_hint to find the right word index. No point in looping
 	 * twice in find_next_zero_bit() for that case.
 	 */
-	if (round_robin)
+	if (sb->round_robin)
 		alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
 	else
 		alloc_hint = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		nr = sbitmap_find_bit_in_index(sb, index, alloc_hint,
-						round_robin);
+		nr = sbitmap_find_bit_in_index(sb, index, alloc_hint);
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -358,7 +358,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	int ret;
 	int i;
 
-	ret = sbitmap_init_node(&sbq->sb, depth, shift, flags, node);
+	ret = sbitmap_init_node(&sbq->sb, depth, shift, flags, node,
+				round_robin);
 	if (ret)
 		return ret;
 
@@ -390,7 +391,6 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 		atomic_set(&sbq->ws[i].wait_cnt, sbq->wake_batch);
 	}
 
-	sbq->round_robin = round_robin;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
@@ -432,12 +432,12 @@ int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 		hint = depth ? prandom_u32() % depth : 0;
 		this_cpu_write(*sbq->alloc_hint, hint);
 	}
-	nr = sbitmap_get(&sbq->sb, hint, sbq->round_robin);
+	nr = sbitmap_get(&sbq->sb, hint);
 
 	if (nr == -1) {
 		/* If the map is full, a hint won't do us much good. */
 		this_cpu_write(*sbq->alloc_hint, 0);
-	} else if (nr == hint || unlikely(sbq->round_robin)) {
+	} else if (nr == hint || unlikely(sbq->sb.round_robin)) {
 		/* Only update the hint if we used it. */
 		hint = nr + 1;
 		if (hint >= depth - 1)
@@ -468,7 +468,7 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 	if (nr == -1) {
 		/* If the map is full, a hint won't do us much good. */
 		this_cpu_write(*sbq->alloc_hint, 0);
-	} else if (nr == hint || unlikely(sbq->round_robin)) {
+	} else if (nr == hint || unlikely(sbq->sb.round_robin)) {
 		/* Only update the hint if we used it. */
 		hint = nr + 1;
 		if (hint >= depth - 1)
@@ -584,7 +584,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 	smp_mb__after_atomic();
 	sbitmap_queue_wake_up(sbq);
 
-	if (likely(!sbq->round_robin && nr < sbq->sb.depth))
+	if (likely(!sbq->sb.round_robin && nr < sbq->sb.depth))
 		*per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
@@ -641,7 +641,7 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 	}
 	seq_puts(m, "}\n");
 
-	seq_printf(m, "round_robin=%d\n", sbq->round_robin);
+	seq_printf(m, "round_robin=%d\n", sbq->sb.round_robin);
 	seq_printf(m, "min_shallow_depth=%u\n", sbq->min_shallow_depth);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_show);
-- 
2.25.4

