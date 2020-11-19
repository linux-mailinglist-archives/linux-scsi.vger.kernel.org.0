Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEE2B8F47
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 10:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgKSJrm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 04:47:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgKSJrm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 04:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605779261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ULqOpUnAfzrT3NeJZImuxqgaxUGerXUAiZ4hYCjwqo=;
        b=QiebpOEJWwo9vWUP9yl0fSLQR8joA3RgJ8bGaJzUu9xFOXZmFaQLF2LJYz9pYcPTRMdqgJ
        NE5qI8mDbh9Ngh0JwzxlB5VkWmqY8bmXxu+oOkBzU/feghaKzpYjWw0pX8iJTIzMWULb0c
        Q/nG66he49uEVdblteiUNNh7g9k7Avo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-NTgLV9SSMaOoJgX_Q1u-zg-1; Thu, 19 Nov 2020 04:47:39 -0500
X-MC-Unique: NTgLV9SSMaOoJgX_Q1u-zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11808E746;
        Thu, 19 Nov 2020 09:47:38 +0000 (UTC)
Received: from localhost (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E1495D6A8;
        Thu, 19 Nov 2020 09:47:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 04/13] sbitmap: move allocation hint into sbitmap
Date:   Thu, 19 Nov 2020 17:46:56 +0800
Message-Id: <20201119094705.280390-5-ming.lei@redhat.com>
In-Reply-To: <20201119094705.280390-1-ming.lei@redhat.com>
References: <20201119094705.280390-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Allocation hint should have belonged to sbitmap, also when sbitmap's
depth is high and no need to use mulitple wakeup queues, user can
benefit from percpu allocation hint too.

So move allocation hint into sbitmap, then scsi device queue can benefit
from allocation hint when converting to plain sbitmap in the following
patches.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c          |   2 +-
 block/kyber-iosched.c   |   2 +-
 include/linux/sbitmap.h |  41 +++++++++------
 lib/sbitmap.c           | 112 +++++++++++++++++++++++-----------------
 4 files changed, 94 insertions(+), 63 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33b94ca9d0e9..ae023cf90c30 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2688,7 +2688,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 		goto free_cpumask;
 
 	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
-				gfp, node, false))
+				gfp, node, false, false))
 		goto free_ctxs;
 	hctx->nr_ctx = 0;
 
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index cc8bcfe1d587..3949d68ac4c1 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -480,7 +480,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
 		if (sbitmap_init_node(&khd->kcq_map[i], hctx->nr_ctx,
 				      ilog2(8), GFP_KERNEL, hctx->numa_node,
-				      false)) {
+				      false, false)) {
 			while (--i >= 0)
 				sbitmap_free(&khd->kcq_map[i]);
 			goto err_kcqs;
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 68097b052ec3..103b41c03311 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -70,6 +70,14 @@ struct sbitmap {
 	 * @map: Allocated bitmap.
 	 */
 	struct sbitmap_word *map;
+
+	/*
+	 * @alloc_hint: Cache of last successfully allocated or freed bit.
+	 *
+	 * This is per-cpu, which allows multiple users to stick to different
+	 * cachelines until the map is exhausted.
+	 */
+	unsigned int __percpu *alloc_hint;
 };
 
 #define SBQ_WAIT_QUEUES 8
@@ -105,14 +113,6 @@ struct sbitmap_queue {
 	 */
 	struct sbitmap sb;
 
-	/*
-	 * @alloc_hint: Cache of last successfully allocated or freed bit.
-	 *
-	 * This is per-cpu, which allows multiple users to stick to different
-	 * cachelines until the map is exhausted.
-	 */
-	unsigned int __percpu *alloc_hint;
-
 	/**
 	 * @wake_batch: Number of bits which must be freed before we wake up any
 	 * waiters.
@@ -152,11 +152,13 @@ struct sbitmap_queue {
  * @round_robin: If true, be stricter about allocation order; always allocate
  *               starting from the last allocated bit. This is less efficient
  *               than the default behavior (false).
+ * @alloc_hint: If true, apply percpu hint for where to start searching for
+ * 		a free bit.
  *
  * Return: Zero on success or negative errno on failure.
  */
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
-		      gfp_t flags, int node, bool round_robin);
+		      gfp_t flags, int node, bool round_robin, bool alloc_hint);
 
 /**
  * sbitmap_free() - Free memory used by a &struct sbitmap.
@@ -164,6 +166,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
  */
 static inline void sbitmap_free(struct sbitmap *sb)
 {
+	free_percpu(sb->alloc_hint);
 	kfree(sb->map);
 	sb->map = NULL;
 }
@@ -181,19 +184,17 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
 /**
  * sbitmap_get() - Try to allocate a free bit from a &struct sbitmap.
  * @sb: Bitmap to allocate from.
- * @alloc_hint: Hint for where to start searching for a free bit.
  *
  * This operation provides acquire barrier semantics if it succeeds.
  *
  * Return: Non-negative allocated bit number if successful, -1 otherwise.
  */
-int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint);
+int sbitmap_get(struct sbitmap *sb);
 
 /**
  * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
  * limiting the depth used from each word.
  * @sb: Bitmap to allocate from.
- * @alloc_hint: Hint for where to start searching for a free bit.
  * @shallow_depth: The maximum number of bits to allocate from a single word.
  *
  * This rather specific operation allows for having multiple users with
@@ -205,8 +206,7 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint);
  *
  * Return: Non-negative allocated bit number if successful, -1 otherwise.
  */
-int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
-			unsigned long shallow_depth);
+int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth);
 
 /**
  * sbitmap_any_bit_set() - Check for a set bit in a &struct sbitmap.
@@ -320,6 +320,18 @@ static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int b
 	set_bit(SB_NR_TO_BIT(sb, bitnr), addr);
 }
 
+/*
+ * Pair of sbitmap_get, and this one applies both cleared bit and
+ * allocation hint.
+ */
+static inline void sbitmap_put(struct sbitmap *sb, unsigned int bitnr)
+{
+	sbitmap_deferred_clear_bit(sb, bitnr);
+
+	if (likely(sb->alloc_hint && !sb->round_robin && bitnr < sb->depth))
+                *this_cpu_ptr(sb->alloc_hint) = bitnr;
+}
+
 static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
 {
 	return test_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
@@ -368,7 +380,6 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
 {
 	kfree(sbq->ws);
-	free_percpu(sbq->alloc_hint);
 	sbitmap_free(&sbq->sb);
 }
 
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 4e4423414f4d..dcd6a89b4d2f 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -9,52 +9,51 @@
 #include <linux/sbitmap.h>
 #include <linux/seq_file.h>
 
-static int init_alloc_hint(struct sbitmap_queue *sbq, gfp_t flags)
+static int init_alloc_hint(struct sbitmap *sb, gfp_t flags)
 {
-	unsigned depth = sbq->sb.depth;
+	unsigned depth = sb->depth;
 
-	sbq->alloc_hint = alloc_percpu_gfp(unsigned int, flags);
-	if (!sbq->alloc_hint)
+	sb->alloc_hint = alloc_percpu_gfp(unsigned int, flags);
+	if (!sb->alloc_hint)
 		return -ENOMEM;
 
-	if (depth && !sbq->sb.round_robin) {
+	if (depth && !sb->round_robin) {
 		int i;
 
 		for_each_possible_cpu(i)
-			*per_cpu_ptr(sbq->alloc_hint, i) = prandom_u32() % depth;
+			*per_cpu_ptr(sb->alloc_hint, i) = prandom_u32() % depth;
 	}
-
 	return 0;
 }
 
-static inline unsigned update_alloc_hint_before_get(struct sbitmap_queue *sbq,
+static inline unsigned update_alloc_hint_before_get(struct sbitmap *sb,
 						    unsigned int depth)
 {
 	unsigned hint;
 
-	hint = this_cpu_read(*sbq->alloc_hint);
+	hint = this_cpu_read(*sb->alloc_hint);
 	if (unlikely(hint >= depth)) {
 		hint = depth ? prandom_u32() % depth : 0;
-		this_cpu_write(*sbq->alloc_hint, hint);
+		this_cpu_write(*sb->alloc_hint, hint);
 	}
 
 	return hint;
 }
 
-static inline void update_alloc_hint_after_get(struct sbitmap_queue *sbq,
+static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 					       unsigned int depth,
 					       unsigned int hint,
 					       unsigned int nr)
 {
 	if (nr == -1) {
 		/* If the map is full, a hint won't do us much good. */
-		this_cpu_write(*sbq->alloc_hint, 0);
-	} else if (nr == hint || unlikely(sbq->sb.round_robin)) {
+		this_cpu_write(*sb->alloc_hint, 0);
+	} else if (nr == hint || unlikely(sb->round_robin)) {
 		/* Only update the hint if we used it. */
 		hint = nr + 1;
 		if (hint >= depth - 1)
 			hint = 0;
-		this_cpu_write(*sbq->alloc_hint, hint);
+		this_cpu_write(*sb->alloc_hint, hint);
 	}
 }
 
@@ -91,7 +90,8 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 }
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
-		      gfp_t flags, int node, bool round_robin)
+		      gfp_t flags, int node, bool round_robin,
+		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
 	unsigned int i;
@@ -123,9 +123,18 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return 0;
 	}
 
+	if (alloc_hint) {
+		if (init_alloc_hint(sb, flags))
+			return -ENOMEM;
+	} else {
+		sb->alloc_hint = NULL;
+	}
+
 	sb->map = kcalloc_node(sb->map_nr, sizeof(*sb->map), flags, node);
-	if (!sb->map)
+	if (!sb->map) {
+		free_percpu(sb->alloc_hint);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < sb->map_nr; i++) {
 		sb->map[i].depth = min(depth, bits_per_word);
@@ -204,7 +213,7 @@ static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
 	return nr;
 }
 
-int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
+static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
 {
 	unsigned int i, index;
 	int nr = -1;
@@ -236,10 +245,27 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
 
 	return nr;
 }
+
+int sbitmap_get(struct sbitmap *sb)
+{
+	int nr;
+	unsigned int hint, depth;
+
+	if (WARN_ON_ONCE(unlikely(!sb->alloc_hint)))
+		return -1;
+
+	depth = READ_ONCE(sb->depth);
+	hint = update_alloc_hint_before_get(sb, depth);
+	nr = __sbitmap_get(sb, hint);
+	update_alloc_hint_after_get(sb, depth, hint, nr);
+
+	return nr;
+}
 EXPORT_SYMBOL_GPL(sbitmap_get);
 
-int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
-			unsigned long shallow_depth)
+static int __sbitmap_get_shallow(struct sbitmap *sb,
+				 unsigned int alloc_hint,
+				 unsigned long shallow_depth)
 {
 	unsigned int i, index;
 	int nr = -1;
@@ -271,6 +297,22 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 
 	return nr;
 }
+
+int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
+{
+	int nr;
+	unsigned int hint, depth;
+
+	if (WARN_ON_ONCE(unlikely(!sb->alloc_hint)))
+		return -1;
+
+	depth = READ_ONCE(sb->depth);
+	hint = update_alloc_hint_before_get(sb, depth);
+	nr = __sbitmap_get_shallow(sb, hint, shallow_depth);
+	update_alloc_hint_after_get(sb, depth, hint, nr);
+
+	return nr;
+}
 EXPORT_SYMBOL_GPL(sbitmap_get_shallow);
 
 bool sbitmap_any_bit_set(const struct sbitmap *sb)
@@ -408,15 +450,10 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	int i;
 
 	ret = sbitmap_init_node(&sbq->sb, depth, shift, flags, node,
-				round_robin);
+				round_robin, true);
 	if (ret)
 		return ret;
 
-	if (init_alloc_hint(sbq, flags) != 0) {
-		sbitmap_free(&sbq->sb);
-		return -ENOMEM;
-	}
-
 	sbq->min_shallow_depth = UINT_MAX;
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
@@ -424,7 +461,6 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
-		free_percpu(sbq->alloc_hint);
 		sbitmap_free(&sbq->sb);
 		return -ENOMEM;
 	}
@@ -466,32 +502,16 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_resize);
 
 int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 {
-	unsigned int hint, depth;
-	int nr;
-
-	depth = READ_ONCE(sbq->sb.depth);
-	hint = update_alloc_hint_before_get(sbq, depth);
-	nr = sbitmap_get(&sbq->sb, hint);
-	update_alloc_hint_after_get(sbq, depth, hint, nr);
-
-	return nr;
+	return sbitmap_get(&sbq->sb);
 }
 EXPORT_SYMBOL_GPL(__sbitmap_queue_get);
 
 int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 				unsigned int shallow_depth)
 {
-	unsigned int hint, depth;
-	int nr;
-
 	WARN_ON_ONCE(shallow_depth < sbq->min_shallow_depth);
 
-	depth = READ_ONCE(sbq->sb.depth);
-	hint = update_alloc_hint_before_get(sbq, depth);
-	nr = sbitmap_get_shallow(&sbq->sb, hint, shallow_depth);
-	update_alloc_hint_after_get(sbq, depth, hint, nr);
-
-	return nr;
+	return sbitmap_get_shallow(&sbq->sb, shallow_depth);
 }
 EXPORT_SYMBOL_GPL(__sbitmap_queue_get_shallow);
 
@@ -600,7 +620,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 	sbitmap_queue_wake_up(sbq);
 
 	if (likely(!sbq->sb.round_robin && nr < sbq->sb.depth))
-		*per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
+		*per_cpu_ptr(sbq->sb.alloc_hint, cpu) = nr;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
 
@@ -638,7 +658,7 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 		if (!first)
 			seq_puts(m, ", ");
 		first = false;
-		seq_printf(m, "%u", *per_cpu_ptr(sbq->alloc_hint, i));
+		seq_printf(m, "%u", *per_cpu_ptr(sbq->sb.alloc_hint, i));
 	}
 	seq_puts(m, "}\n");
 
-- 
2.25.4

