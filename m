Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28A24A2DC
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Aug 2020 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgHSPZk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Aug 2020 11:25:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728259AbgHSPZd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 19 Aug 2020 11:25:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6135B0D07DE32A285FB;
        Wed, 19 Aug 2020 23:24:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 23:24:49 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <don.brace@microsemi.com>,
        <kashyap.desai@broadcom.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>, <dgilbert@interlog.com>,
        <paolo.valente@linaro.org>, <hare@suse.de>, <hch@lst.de>
CC:     <sumit.saxena@broadcom.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <megaraidlinux.pdl@broadcom.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v8 05/18] blk-mq: Use pointers for blk_mq_tags bitmap tags
Date:   Wed, 19 Aug 2020 23:20:23 +0800
Message-ID: <1597850436-116171-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce pointers for the blk_mq_tags regular and reserved bitmap tags,
with the goal of later being able to use a common shared tag bitmap across
all HW contexts in a set.

Tested-by: Don Brace<don.brace@microsemi.com> #SCSI resv cmds patches used
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/bfq-iosched.c    |  4 ++--
 block/blk-mq-debugfs.c |  8 ++++----
 block/blk-mq-tag.c     | 41 ++++++++++++++++++++++-------------------
 block/blk-mq-tag.h     |  7 +++++--
 block/blk-mq.c         |  8 ++++----
 block/kyber-iosched.c  |  4 ++--
 6 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a4c0bec920cb..88f0dfa545d7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6372,8 +6372,8 @@ static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct blk_mq_tags *tags = hctx->sched_tags;
 	unsigned int min_shallow;
 
-	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
+	min_shallow = bfq_update_depths(bfqd, tags->bitmap_tags);
+	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, min_shallow);
 }
 
 static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a4597febff69..645b7f800cb8 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -452,11 +452,11 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 		   atomic_read(&tags->active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
-	sbitmap_queue_show(&tags->bitmap_tags, m);
+	sbitmap_queue_show(tags->bitmap_tags, m);
 
 	if (tags->nr_reserved_tags) {
 		seq_puts(m, "\nbreserved_tags:\n");
-		sbitmap_queue_show(&tags->breserved_tags, m);
+		sbitmap_queue_show(tags->breserved_tags, m);
 	}
 }
 
@@ -487,7 +487,7 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
 	if (res)
 		goto out;
 	if (hctx->tags)
-		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
+		sbitmap_bitmap_show(&hctx->tags->bitmap_tags->sb, m);
 	mutex_unlock(&q->sysfs_lock);
 
 out:
@@ -521,7 +521,7 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	if (res)
 		goto out;
 	if (hctx->sched_tags)
-		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
+		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags->sb, m);
 	mutex_unlock(&q->sysfs_lock);
 
 out:
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0426f01e06a6..77fbeae05745 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -35,9 +35,9 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
  */
 void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
 {
-	sbitmap_queue_wake_all(&tags->bitmap_tags);
+	sbitmap_queue_wake_all(tags->bitmap_tags);
 	if (include_reserve)
-		sbitmap_queue_wake_all(&tags->breserved_tags);
+		sbitmap_queue_wake_all(tags->breserved_tags);
 }
 
 /*
@@ -82,10 +82,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 			WARN_ON_ONCE(1);
 			return BLK_MQ_NO_TAG;
 		}
-		bt = &tags->breserved_tags;
+		bt = tags->breserved_tags;
 		tag_offset = 0;
 	} else {
-		bt = &tags->bitmap_tags;
+		bt = tags->bitmap_tags;
 		tag_offset = tags->nr_reserved_tags;
 	}
 
@@ -131,9 +131,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 						data->ctx);
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
-			bt = &tags->breserved_tags;
+			bt = tags->breserved_tags;
 		else
-			bt = &tags->bitmap_tags;
+			bt = tags->bitmap_tags;
 
 		/*
 		 * If destination hw queue is changed, fake wake up on
@@ -167,10 +167,10 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		const int real_tag = tag - tags->nr_reserved_tags;
 
 		BUG_ON(real_tag >= tags->nr_tags);
-		sbitmap_queue_clear(&tags->bitmap_tags, real_tag, ctx->cpu);
+		sbitmap_queue_clear(tags->bitmap_tags, real_tag, ctx->cpu);
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
-		sbitmap_queue_clear(&tags->breserved_tags, tag, ctx->cpu);
+		sbitmap_queue_clear(tags->breserved_tags, tag, ctx->cpu);
 	}
 }
 
@@ -298,9 +298,9 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 	WARN_ON_ONCE(flags & BT_TAG_ITER_RESERVED);
 
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv,
+		bt_tags_for_each(tags, tags->breserved_tags, fn, priv,
 				 flags | BT_TAG_ITER_RESERVED);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags);
+	bt_tags_for_each(tags, tags->bitmap_tags, fn, priv, flags);
 }
 
 /**
@@ -416,8 +416,8 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 			continue;
 
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+			bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
+		bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
 	}
 	blk_queue_exit(q);
 }
@@ -435,15 +435,18 @@ static int blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 	unsigned int depth = tags->nr_tags - tags->nr_reserved_tags;
 	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;
 
-	if (bt_alloc(&tags->bitmap_tags, depth, round_robin, node))
+	if (bt_alloc(&tags->__bitmap_tags, depth, round_robin, node))
 		return -ENOMEM;
-	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, round_robin,
-		     node))
+	if (bt_alloc(&tags->__breserved_tags, tags->nr_reserved_tags,
+		     round_robin, node))
 		goto free_bitmap_tags;
 
+	tags->bitmap_tags = &tags->__bitmap_tags;
+	tags->breserved_tags = &tags->__breserved_tags;
+
 	return 0;
 free_bitmap_tags:
-	sbitmap_queue_free(&tags->bitmap_tags);
+	sbitmap_queue_free(&tags->__bitmap_tags);
 	return -ENOMEM;
 }
 
@@ -475,8 +478,8 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
 {
-	sbitmap_queue_free(&tags->bitmap_tags);
-	sbitmap_queue_free(&tags->breserved_tags);
+	sbitmap_queue_free(&tags->__bitmap_tags);
+	sbitmap_queue_free(&tags->__breserved_tags);
 	kfree(tags);
 }
 
@@ -527,7 +530,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		 * Don't need (or can't) update reserved tags here, they
 		 * remain static and should never need resizing.
 		 */
-		sbitmap_queue_resize(&tags->bitmap_tags,
+		sbitmap_queue_resize(tags->bitmap_tags,
 				tdepth - tags->nr_reserved_tags);
 	}
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 391f68d32fa1..5b6f25bd1966 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -13,8 +13,11 @@ struct blk_mq_tags {
 
 	atomic_t active_queues;
 
-	struct sbitmap_queue bitmap_tags;
-	struct sbitmap_queue breserved_tags;
+	struct sbitmap_queue *bitmap_tags;
+	struct sbitmap_queue *breserved_tags;
+
+	struct sbitmap_queue __bitmap_tags;
+	struct sbitmap_queue __breserved_tags;
 
 	struct request **rqs;
 	struct request **static_rqs;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 376930061452..ce712ec818e4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1096,14 +1096,14 @@ static inline unsigned int queued_to_index(unsigned int queued)
 
 static bool __blk_mq_get_driver_tag(struct request *rq)
 {
-	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
+	struct sbitmap_queue *bt = rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
 	int tag;
 
 	blk_mq_tag_busy(rq->mq_hctx);
 
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
-		bt = &rq->mq_hctx->tags->breserved_tags;
+		bt = rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
 	}
 
@@ -1145,7 +1145,7 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 		struct sbitmap_queue *sbq;
 
 		list_del_init(&wait->entry);
-		sbq = &hctx->tags->bitmap_tags;
+		sbq = hctx->tags->bitmap_tags;
 		atomic_dec(&sbq->ws_active);
 	}
 	spin_unlock(&hctx->dispatch_wait_lock);
@@ -1163,7 +1163,7 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 				 struct request *rq)
 {
-	struct sbitmap_queue *sbq = &hctx->tags->bitmap_tags;
+	struct sbitmap_queue *sbq = hctx->tags->bitmap_tags;
 	struct wait_queue_head *wq;
 	wait_queue_entry_t *wait;
 	bool ret;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index a38c5ab103d1..075e99c207ef 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -359,7 +359,7 @@ static unsigned int kyber_sched_tags_shift(struct request_queue *q)
 	 * All of the hardware queues have the same depth, so we can just grab
 	 * the shift of the first one.
 	 */
-	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
+	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags->sb.shift;
 }
 
 static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
@@ -502,7 +502,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	khd->batching = 0;
 
 	hctx->sched_data = khd;
-	sbitmap_queue_min_shallow_depth(&hctx->sched_tags->bitmap_tags,
+	sbitmap_queue_min_shallow_depth(hctx->sched_tags->bitmap_tags,
 					kqd->async_depth);
 
 	return 0;
-- 
2.26.2

