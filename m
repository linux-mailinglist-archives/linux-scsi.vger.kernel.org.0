Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879E61026C5
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Nov 2019 15:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfKSOb2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Nov 2019 09:31:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7147 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726409AbfKSOb1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 19 Nov 2019 09:31:27 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8359CC7F207CA2B6F94;
        Tue, 19 Nov 2019 22:31:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 19 Nov 2019 22:30:59 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <ming.lei@redhat.com>,
        <hare@suse.com>, <bvanassche@acm.org>, <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC V2 3/5] blk-mq: Facilitate a shared sbitmap per tagset
Date:   Tue, 19 Nov 2019 22:27:36 +0800
Message-ID: <1574173658-76818-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574173658-76818-1-git-send-email-john.garry@huawei.com>
References: <1574173658-76818-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some SCSI HBAs (such as HPSA, megaraid, mpt3sas, hisi_sas_v3 ..) support
multiple reply queues with single hostwide tags.

In addition, these drivers want to use interrupt assignment in
pci_alloc_irq_vectors(PCI_IRQ_AFFINITY). However, as discussed in [0],
CPU hotplug may cause in-flight IO completion to not be serviced when an
interrupt is shutdown.

To solve that problem, Ming's patchset to drain hctx's should ensure no
IOs are missed in-flight [1].

However, to take advantage of that patchset, we need to map the HBA HW
queues to blk mq hctx's; to do that, we need to expose the HBA HW queues.

In making that transition, the per-SCSI command request tags are no
longer unique per Scsi host - they are just unique per hctx. As such, the
HBA LLDD would have to generate this tag internally, which has a certain
performance overhead.

However another problem is that blk mq assumes the host may accept
(Scsi_host.can_queue * #hw queue) commands. In [2], we removed the Scsi
host busy counter, which would stop the LLDD being sent more than
.can_queue commands; however, we should still ensure that the block layer
does not issue more than .can_queue commands to the Scsi host.

To solve this problem, introduce a shared sbitmap per blk_mq_tag_set,
which may be requested at init time.

New flag BLK_MQ_F_TAG_HCTX_SHARED should be set when requesting the
tagset to indicate whether the shared sbitmap should be used.

Even when BLK_MQ_F_TAG_HCTX_SHARED is set, we still allocate a full set of
tags and requests per hctx; the reason for this is that if we only allocate
tags and requests for a single hctx - like hctx0 - we may break block
drivers which expect a request be associated with a specific hctx, i.e.
not hctx0.

This is based on work originally from Ming Lei in [3] and from Bart's
suggestion in [4].

[0] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
[1] https://lore.kernel.org/linux-block/20191014015043.25029-1-ming.lei@redhat.com/
[2] https://lore.kernel.org/linux-scsi/20191025065855.6309-1-ming.lei@redhat.com/
[3] https://lore.kernel.org/linux-block/20190531022801.10003-1-ming.lei@redhat.com/
[4] https://lore.kernel.org/linux-block/ff77beff-5fd9-9f05-12b6-826922bace1f@huawei.com/T/#m3db0a602f095cbcbff27e9c884d6b4ae826144be

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/bfq-iosched.c    |  4 +--
 block/blk-mq-debugfs.c |  4 +--
 block/blk-mq-sched.c   | 14 ++++++++
 block/blk-mq-tag.c     | 74 +++++++++++++++++++++++++++++++++---------
 block/blk-mq-tag.h     | 15 +++++++--
 block/blk-mq.c         | 57 +++++++++++++++++++++++++++++---
 block/blk-mq.h         |  5 +++
 block/kyber-iosched.c  |  4 +--
 include/linux/blk-mq.h |  7 ++++
 9 files changed, 157 insertions(+), 27 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0319d6339822..9633c864af07 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6327,8 +6327,8 @@ static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct blk_mq_tags *tags = hctx->sched_tags;
 	unsigned int min_shallow;
 
-	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
+	min_shallow = bfq_update_depths(bfqd, tags->pbitmap_tags);
+	sbitmap_queue_min_shallow_depth(tags->pbitmap_tags, min_shallow);
 }
 
 static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 33a40ae1d60f..9cf2f09c08e4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -483,7 +483,7 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
 	res = mutex_lock_interruptible(&q->sysfs_lock);
 	if (res)
 		goto out;
-	if (hctx->tags)
+	if (hctx->tags) /* We should just iterate the relevant bits for this hctx FIXME */
 		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->sysfs_lock);
 
@@ -517,7 +517,7 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	res = mutex_lock_interruptible(&q->sysfs_lock);
 	if (res)
 		goto out;
-	if (hctx->sched_tags)
+	if (hctx->sched_tags) /* We should just iterate the relevant bits for this hctx FIXME */
 		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->sysfs_lock);
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..b23547f10949 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -492,6 +492,7 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q)
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
+	struct blk_mq_tag_set *tag_set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	struct elevator_queue *eq;
 	unsigned int i;
@@ -537,6 +538,19 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 		blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
+	if (blk_mq_is_sbitmap_shared(tag_set)) {
+		if (!blk_mq_init_sched_shared_sbitmap(tag_set, q->nr_requests)) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		queue_for_each_hw_ctx(q, hctx, i) {
+			struct blk_mq_tags *tags = hctx->sched_tags;
+
+			tags->pbitmap_tags = &tag_set->sched_shared_bitmap_tags;
+			tags->pbreserved_tags = &tag_set->sched_shared_breserved_tags;
+		}
+	}
+
 	return 0;
 
 err:
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 42792942b428..6625bebb46c3 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -35,9 +35,9 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
  */
 void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
 {
-	sbitmap_queue_wake_all(&tags->bitmap_tags);
+	sbitmap_queue_wake_all(tags->pbitmap_tags);
 	if (include_reserve)
-		sbitmap_queue_wake_all(&tags->breserved_tags);
+		sbitmap_queue_wake_all(tags->pbreserved_tags);
 }
 
 /*
@@ -113,10 +113,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 			WARN_ON_ONCE(1);
 			return BLK_MQ_TAG_FAIL;
 		}
-		bt = &tags->breserved_tags;
+		bt = tags->pbreserved_tags;
 		tag_offset = 0;
 	} else {
-		bt = &tags->bitmap_tags;
+		bt = tags->pbitmap_tags;
 		tag_offset = tags->nr_reserved_tags;
 	}
 
@@ -162,9 +162,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 						data->ctx);
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
-			bt = &tags->breserved_tags;
+			bt = tags->pbreserved_tags;
 		else
-			bt = &tags->bitmap_tags;
+			bt = tags->pbitmap_tags;
 
 		/*
 		 * If destination hw queue is changed, fake wake up on
@@ -190,10 +190,10 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		const int real_tag = tag - tags->nr_reserved_tags;
 
 		BUG_ON(real_tag >= tags->nr_tags);
-		sbitmap_queue_clear(&tags->bitmap_tags, real_tag, ctx->cpu);
+		sbitmap_queue_clear(tags->pbitmap_tags, real_tag, ctx->cpu);
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
-		sbitmap_queue_clear(&tags->breserved_tags, tag, ctx->cpu);
+		sbitmap_queue_clear(tags->pbreserved_tags, tag, ctx->cpu);
 	}
 }
 
@@ -220,7 +220,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue)
+	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
@@ -321,8 +321,8 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
+		bt_tags_for_each(tags, tags->pbreserved_tags, fn, priv, true);
+	bt_tags_for_each(tags, tags->pbitmap_tags, fn, priv, false);
 }
 
 /**
@@ -419,8 +419,8 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 			continue;
 
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+			bt_for_each(hctx, tags->pbreserved_tags, fn, priv, true);
+		bt_for_each(hctx, tags->pbitmap_tags, fn, priv, false);
 	}
 	blk_queue_exit(q);
 }
@@ -444,6 +444,9 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 		     node))
 		goto free_bitmap_tags;
 
+	tags->pbitmap_tags = &tags->bitmap_tags;
+	tags->pbreserved_tags = &tags->breserved_tags;
+
 	return tags;
 free_bitmap_tags:
 	sbitmap_queue_free(&tags->bitmap_tags);
@@ -452,7 +455,46 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 	return NULL;
 }
 
-struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
+bool blk_mq_init_shared_sbitmap(struct blk_mq_tag_set *tag_set)
+{
+	unsigned int depth = tag_set->queue_depth -tag_set->reserved_tags;
+	int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(tag_set->flags);
+	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;
+	int node = tag_set->numa_node;
+
+	if (bt_alloc(&tag_set->shared_bitmap_tags, depth, round_robin, node))
+		return false;
+	if (bt_alloc(&tag_set->shared_breserved_tags, tag_set->reserved_tags, round_robin,
+			 node))
+		goto free_bitmap_tags;
+
+	return true;
+free_bitmap_tags:
+	sbitmap_queue_free(&tag_set->shared_bitmap_tags);
+	return false;
+}
+
+bool blk_mq_init_sched_shared_sbitmap(struct blk_mq_tag_set *tag_set, unsigned long nr_requests)
+{
+	unsigned int depth = nr_requests -tag_set->reserved_tags;
+	int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(tag_set->flags);
+	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;
+	int node = tag_set->numa_node;
+
+	if (bt_alloc(&tag_set->sched_shared_bitmap_tags, depth, round_robin, node))
+		return false;
+	if (bt_alloc(&tag_set->sched_shared_breserved_tags, tag_set->reserved_tags, round_robin,
+			 node))
+		goto free_bitmap_tags;
+
+	return true;
+free_bitmap_tags:
+	sbitmap_queue_free(&tag_set->sched_shared_bitmap_tags);
+	return false;
+}
+
+struct blk_mq_tags *blk_mq_init_tags(struct blk_mq_tag_set *set,
+				     unsigned int total_tags,
 				     unsigned int reserved_tags,
 				     int node, int alloc_policy)
 {
@@ -470,6 +512,8 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
+	if (blk_mq_is_sbitmap_shared(set))
+		return tags;
 	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
 
@@ -526,7 +570,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		 * Don't need (or can't) update reserved tags here, they
 		 * remain static and should never need resizing.
 		 */
-		sbitmap_queue_resize(&tags->bitmap_tags,
+		sbitmap_queue_resize(tags->pbitmap_tags,
 				tdepth - tags->nr_reserved_tags);
 	}
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index e36bec8e0970..198b6fbe2c22 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -13,20 +13,31 @@ struct blk_mq_tags {
 
 	atomic_t active_queues;
 
+	/* We should consider deleting these so they are not referenced by mistake */
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
 
+	struct sbitmap_queue *pbitmap_tags;
+	struct sbitmap_queue *pbreserved_tags;
+
 	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
 };
 
 
-extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
+extern bool blk_mq_init_shared_sbitmap(struct blk_mq_tag_set *tag_set);
+extern bool blk_mq_init_sched_shared_sbitmap(struct blk_mq_tag_set *tag_set,
+					     unsigned long nr_requests);
+extern struct blk_mq_tags *blk_mq_init_tags(struct blk_mq_tag_set *tag_set,
+					    unsigned int nr_tags,
+					    unsigned int reserved_tags,
+					    int node, int alloc_policy);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
-extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx, unsigned int tag);
+extern void blk_mq_put_tag(struct blk_mq_tags *tags,
+			   struct blk_mq_ctx *ctx, unsigned int tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2d2956249ae9..8d5b21919c9a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1089,7 +1089,7 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 		struct sbitmap_queue *sbq;
 
 		list_del_init(&wait->entry);
-		sbq = &hctx->tags->bitmap_tags;
+		sbq = hctx->tags->pbitmap_tags;
 		atomic_dec(&sbq->ws_active);
 	}
 	spin_unlock(&hctx->dispatch_wait_lock);
@@ -1107,7 +1107,7 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 				 struct request *rq)
 {
-	struct sbitmap_queue *sbq = &hctx->tags->bitmap_tags;
+	struct sbitmap_queue *sbq = hctx->tags->pbitmap_tags;
 	struct wait_queue_head *wq;
 	wait_queue_entry_t *wait;
 	bool ret;
@@ -2097,7 +2097,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
-	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
+	tags = blk_mq_init_tags(set, nr_tags, reserved_tags, node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
 		return NULL;
@@ -3100,6 +3100,20 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
+	if (blk_mq_is_sbitmap_shared(set)) {
+		if (!blk_mq_init_shared_sbitmap(set)) {
+			ret = -ENOMEM;
+			goto out_free_mq_map;
+		}
+
+		for (i = 0; i < set->nr_hw_queues; i++) {
+			struct blk_mq_tags *tags = set->tags[i];
+
+			tags->pbitmap_tags = &set->shared_bitmap_tags;
+			tags->pbreserved_tags = &set->shared_breserved_tags;
+		}
+	}
+
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
 
@@ -3137,6 +3151,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
+	bool sched_tags = false;
 	int i, ret;
 
 	if (!set)
@@ -3160,6 +3175,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
 							false);
 		} else {
+			sched_tags = true;
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
 							nr, true);
 		}
@@ -3169,8 +3185,41 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			q->elevator->type->ops.depth_updated(hctx);
 	}
 
-	if (!ret)
+	/*
+	 * if ret is 0, all queues should have been updated to the same depth
+	 * if not, then maybe some have been updated - yuk, need to handle this for shared sbitmap...
+	 * if some are updated, we should probably roll back the change altogether. FIXME
+	 */
+	if (!ret) {
+		if (blk_mq_is_sbitmap_shared(set)) {
+			if (sched_tags) {
+				sbitmap_queue_free(&set->sched_shared_bitmap_tags);
+				sbitmap_queue_free(&set->sched_shared_breserved_tags);
+				if (!blk_mq_init_sched_shared_sbitmap(set, nr))
+					return -ENOMEM; /* fixup error handling */
+
+				queue_for_each_hw_ctx(q, hctx, i) {
+					hctx->sched_tags->pbitmap_tags = &set->sched_shared_bitmap_tags;
+					hctx->sched_tags->pbreserved_tags = &set->sched_shared_breserved_tags;
+				}
+			} else {
+				sbitmap_queue_free(&set->shared_bitmap_tags);
+				sbitmap_queue_free(&set->shared_breserved_tags);
+				if (!blk_mq_init_shared_sbitmap(set))
+					return -ENOMEM; /* fixup error handling */
+
+				queue_for_each_hw_ctx(q, hctx, i) {
+					hctx->tags->pbitmap_tags = &set->shared_bitmap_tags;
+					hctx->tags->pbreserved_tags = &set->shared_breserved_tags;
+				}
+			}
+		}
 		q->nr_requests = nr;
+	}
+	/*
+	 * if ret != 0, q->nr_requests would not be updated, yet the depth
+	 * for some hctx may have changed - is that right?
+	 */
 
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 78d38b5f2793..4c1ea206d3f4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -166,6 +166,11 @@ struct blk_mq_alloc_data {
 	struct blk_mq_hw_ctx *hctx;
 };
 
+static inline bool blk_mq_is_sbitmap_shared(struct blk_mq_tag_set *tag_set)
+{
+	return !!(tag_set->flags & BLK_MQ_F_TAG_HCTX_SHARED);
+}
+
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
 	if (data->flags & BLK_MQ_REQ_INTERNAL)
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 34dcea0ef637..59fb6afd8e68 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -359,7 +359,7 @@ static unsigned int kyber_sched_tags_shift(struct request_queue *q)
 	 * All of the hardware queues have the same depth, so we can just grab
 	 * the shift of the first one.
 	 */
-	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
+	return q->queue_hw_ctx[0]->sched_tags->pbitmap_tags->sb.shift;
 }
 
 static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
@@ -502,7 +502,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	khd->batching = 0;
 
 	hctx->sched_data = khd;
-	sbitmap_queue_min_shallow_depth(&hctx->sched_tags->bitmap_tags,
+	sbitmap_queue_min_shallow_depth(hctx->sched_tags->pbitmap_tags,
 					kqd->async_depth);
 
 	return 0;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8952c9dfef79..9b923b42c07b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -109,6 +109,12 @@ struct blk_mq_tag_set {
 	unsigned int		flags;		/* BLK_MQ_F_* */
 	void			*driver_data;
 
+	struct sbitmap_queue shared_bitmap_tags;
+	struct sbitmap_queue shared_breserved_tags;
+
+	struct sbitmap_queue sched_shared_bitmap_tags;
+	struct sbitmap_queue sched_shared_breserved_tags;
+
 	struct blk_mq_tags	**tags;
 
 	struct mutex		tag_list_lock;
@@ -226,6 +232,7 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_QUEUE_SHARED	= 1 << 1,
+	BLK_MQ_F_TAG_HCTX_SHARED	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.17.1

