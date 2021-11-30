Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A72462D9A
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Nov 2021 08:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhK3HmD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Nov 2021 02:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239079AbhK3Hlt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 30 Nov 2021 02:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638257910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3P5jR+l+L0z0qtIKT2BMJPtc2z0RNo6n9uuv+kb7/A=;
        b=g7g8BlvUaanMJU9yLDsPVl5XBcwssZwm1HFrhpJ6uDSHAtIv9cItMDbZbaJLsJnfbimDD4
        bkswIAGWieJJ6G2j0RpnslzZthRgzO8JLkFuJDepG2Oc2pz/KdQa+NX9fSdHHack7mjW/B
        V/zFhCPlRpBfc3wF/VRPpX4JsXcO4FI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-FGDxn6evPqixBSSbB-HAZQ-1; Tue, 30 Nov 2021 02:38:24 -0500
X-MC-Unique: FGDxn6evPqixBSSbB-HAZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF75194EE4;
        Tue, 30 Nov 2021 07:38:22 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0E4C60BF1;
        Tue, 30 Nov 2021 07:38:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/5] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
Date:   Tue, 30 Nov 2021 15:37:49 +0800
Message-Id: <20211130073752.3005936-3-ming.lei@redhat.com>
In-Reply-To: <20211130073752.3005936-1-ming.lei@redhat.com>
References: <20211130073752.3005936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In case of BLK_MQ_F_BLOCKING, per-hctx srcu is used to protect dispatch
critical area. However, this srcu instance stays at the end of hctx, and
it often takes standalone cacheline, often cold.

Inside srcu_read_lock() and srcu_read_unlock(), WRITE is always done on
the indirect percpu variable which is allocated from heap instead of
being embedded, srcu->srcu_idx is read only in srcu_read_lock(). It
doesn't matter if srcu structure stays in hctx or request queue.

So switch to per-request-queue srcu for protecting dispatch, and this
way simplifies quiesce a lot, not mention quiesce is always done on the
request queue wide.

Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 27 ++++++++++++++++++++++-----
 block/blk-mq-sysfs.c   |  2 --
 block/blk-mq.c         | 41 ++++++++++-------------------------------
 block/blk-sysfs.c      |  3 ++-
 block/blk.h            | 10 +++++++++-
 block/genhd.c          |  2 +-
 include/linux/blk-mq.h |  8 --------
 include/linux/blkdev.h |  9 +++++++++
 8 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b0660c9df852..10619fd83c1b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -66,6 +66,7 @@ DEFINE_IDA(blk_queue_ida);
  * For queue allocation
  */
 struct kmem_cache *blk_requestq_cachep;
+struct kmem_cache *blk_requestq_srcu_cachep;
 
 /*
  * Controlling structure to kblockd
@@ -437,21 +438,27 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-struct request_queue *blk_alloc_queue(int node_id)
+struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 {
 	struct request_queue *q;
 	int ret;
 
-	q = kmem_cache_alloc_node(blk_requestq_cachep,
-				GFP_KERNEL | __GFP_ZERO, node_id);
+	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
+			GFP_KERNEL | __GFP_ZERO, node_id);
 	if (!q)
 		return NULL;
 
+	if (alloc_srcu) {
+		blk_queue_flag_set(QUEUE_FLAG_HAS_SRCU, q);
+		if (init_srcu_struct(q->srcu) != 0)
+			goto fail_q;
+	}
+
 	q->last_merge = NULL;
 
 	q->id = ida_simple_get(&blk_queue_ida, 0, 0, GFP_KERNEL);
 	if (q->id < 0)
-		goto fail_q;
+		goto fail_srcu;
 
 	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (ret)
@@ -508,8 +515,11 @@ struct request_queue *blk_alloc_queue(int node_id)
 	bioset_exit(&q->bio_split);
 fail_id:
 	ida_simple_remove(&blk_queue_ida, q->id);
+fail_srcu:
+	if (alloc_srcu)
+		cleanup_srcu_struct(q->srcu);
 fail_q:
-	kmem_cache_free(blk_requestq_cachep, q);
+	kmem_cache_free(blk_get_queue_kmem_cache(alloc_srcu), q);
 	return NULL;
 }
 
@@ -1301,6 +1311,9 @@ int __init blk_dev_init(void)
 			sizeof_field(struct request, cmd_flags));
 	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
 			sizeof_field(struct bio, bi_opf));
+	BUILD_BUG_ON(ALIGN(offsetof(struct request_queue, srcu),
+			   __alignof__(struct request_queue)) !=
+		     sizeof(struct request_queue));
 
 	/* used for unplugging and affects IO latency/throughput - HIGHPRI */
 	kblockd_workqueue = alloc_workqueue("kblockd",
@@ -1311,6 +1324,10 @@ int __init blk_dev_init(void)
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
+	blk_requestq_srcu_cachep = kmem_cache_create("request_queue_srcu",
+			sizeof(struct request_queue) +
+			sizeof(struct srcu_struct), 0, SLAB_PANIC, NULL);
+
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 
 	return 0;
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 253c857cba47..674786574075 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -36,8 +36,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		cleanup_srcu_struct(hctx->srcu);
 	blk_free_flush_queue(hctx->fq);
 	sbitmap_free(&hctx->ctx_map);
 	free_cpumask_var(hctx->cpumask);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c5dc716b8167..a3ff671ca20e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,17 +260,9 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
  */
 void blk_mq_wait_quiesce_done(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-	bool rcu = false;
-
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->flags & BLK_MQ_F_BLOCKING)
-			synchronize_srcu(hctx->srcu);
-		else
-			rcu = true;
-	}
-	if (rcu)
+	if (blk_queue_has_srcu(q))
+		synchronize_srcu(q->srcu);
+	else
 		synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
@@ -1090,9 +1082,9 @@ do {								\
 		int srcu_idx;					\
 								\
 		might_sleep();					\
-		srcu_idx = srcu_read_lock(hctx->srcu);		\
+		srcu_idx = srcu_read_lock(hctx->queue->srcu);	\
 		(dispatch_ops);					\
-		srcu_read_unlock(hctx->srcu, srcu_idx);		\
+		srcu_read_unlock(hctx->queue->srcu, srcu_idx);	\
 	}							\
 } while (0)
 
@@ -3431,20 +3423,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
-static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
-{
-	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
-
-	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
-			   __alignof__(struct blk_mq_hw_ctx)) !=
-		     sizeof(struct blk_mq_hw_ctx));
-
-	if (tag_set->flags & BLK_MQ_F_BLOCKING)
-		hw_ctx_size += sizeof(struct srcu_struct);
-
-	return hw_ctx_size;
-}
-
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
@@ -3482,7 +3460,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	struct blk_mq_hw_ctx *hctx;
 	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
 
-	hctx = kzalloc_node(blk_mq_hw_ctx_size(set), gfp, node);
+	hctx = kzalloc_node(sizeof(struct blk_mq_hw_ctx), gfp, node);
 	if (!hctx)
 		goto fail_alloc_hctx;
 
@@ -3524,8 +3502,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!hctx->fq)
 		goto free_bitmap;
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		init_srcu_struct(hctx->srcu);
 	blk_mq_hctx_kobj_init(hctx);
 
 	return hctx;
@@ -3861,7 +3837,7 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node);
+	q = blk_alloc_queue(set->numa_node, set->flags & BLK_MQ_F_BLOCKING);
 	if (!q)
 		return ERR_PTR(-ENOMEM);
 	q->queuedata = queuedata;
@@ -4010,6 +3986,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q)
 {
+	WARN_ON_ONCE(blk_queue_has_srcu(q) !=
+			!!(set->flags & BLK_MQ_F_BLOCKING));
+
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4622da4bb992..3e6357321225 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -735,7 +735,8 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
 	struct request_queue *q = container_of(rcu_head, struct request_queue,
 					       rcu_head);
-	kmem_cache_free(blk_requestq_cachep, q);
+
+	kmem_cache_free(blk_get_queue_kmem_cache(blk_queue_has_srcu(q)), q);
 }
 
 /* Unconfigure the I/O scheduler and dissociate from the cgroup controller. */
diff --git a/block/blk.h b/block/blk.h
index a57c84654d0a..911f9f8db646 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -27,6 +27,7 @@ struct blk_flush_queue {
 };
 
 extern struct kmem_cache *blk_requestq_cachep;
+extern struct kmem_cache *blk_requestq_srcu_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
@@ -428,7 +429,14 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
-struct request_queue *blk_alloc_queue(int node_id);
+static inline struct kmem_cache *blk_get_queue_kmem_cache(bool srcu)
+{
+	if (srcu)
+		return blk_requestq_srcu_cachep;
+	return blk_requestq_cachep;
+}
+struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu);
+
 int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
 
 int disk_alloc_events(struct gendisk *disk);
diff --git a/block/genhd.c b/block/genhd.c
index 5179a4f00fba..3c139a1b6f04 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1338,7 +1338,7 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node);
+	q = blk_alloc_queue(node, false);
 	if (!q)
 		return NULL;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d952c3442261..42fe97adb807 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -4,7 +4,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
-#include <linux/srcu.h>
 #include <linux/lockdep.h>
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
@@ -376,13 +375,6 @@ struct blk_mq_hw_ctx {
 	 * q->unused_hctx_list.
 	 */
 	struct list_head	hctx_list;
-
-	/**
-	 * @srcu: Sleepable RCU. Use as lock when type of the hardware queue is
-	 * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
-	 * blk_mq_hw_ctx_size().
-	 */
-	struct srcu_struct	srcu[];
 };
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a4416ef4fbf..c80cfaefc0a8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -16,6 +16,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/blkzoned.h>
 #include <linux/sbitmap.h>
+#include <linux/srcu.h>
 
 struct module;
 struct request_queue;
@@ -373,11 +374,18 @@ struct request_queue {
 	 * devices that do not have multiple independent access ranges.
 	 */
 	struct blk_independent_access_ranges *ia_ranges;
+
+	/**
+	 * @srcu: Sleepable RCU. Use as lock when type of the request queue
+	 * is blocking (BLK_MQ_F_BLOCKING). Must be the last member
+	 */
+	struct srcu_struct	srcu[];
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
+#define QUEUE_FLAG_HAS_SRCU	2	/* SRCU is allocated */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
 #define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
@@ -415,6 +423,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
+#define blk_queue_has_srcu(q)	test_bit(QUEUE_FLAG_HAS_SRCU, &(q)->queue_flags)
 #define blk_queue_dead(q)	test_bit(QUEUE_FLAG_DEAD, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
-- 
2.31.1

