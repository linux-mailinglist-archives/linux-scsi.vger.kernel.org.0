Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28524A2F5
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Aug 2020 17:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgHSP03 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Aug 2020 11:26:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbgHSPZZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 19 Aug 2020 11:25:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CFA469B6EBA2B998A65;
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
Subject: [PATCH v8 06/18] blk-mq: Facilitate a shared sbitmap per tagset
Date:   Wed, 19 Aug 2020 23:20:24 +0800
Message-ID: <1597850436-116171-7-git-send-email-john.garry@huawei.com>
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

Some SCSI HBAs (such as HPSA, megaraid, mpt3sas, hisi_sas_v3 ..) support
multiple reply queues with single hostwide tags.

In addition, these drivers want to use interrupt assignment in
pci_alloc_irq_vectors(PCI_IRQ_AFFINITY). However, as discussed in [0],
CPU hotplug may cause in-flight IO completion to not be serviced when an
interrupt is shutdown. That problem is solved in commit bf0beec0607d
("blk-mq: drain I/O when all CPUs in a hctx are offline").

However, to take advantage of that blk-mq feature, the HBA HW queuess are
required to be mapped to that of the blk-mq hctx's; to do that, the HBA HW
queues need to be exposed to the upper layer.

In making that transition, the per-SCSI command request tags are no
longer unique per Scsi host - they are just unique per hctx. As such, the
HBA LLDD would have to generate this tag internally, which has a certain
performance overhead.

However another problem is that blk-mq assumes the host may accept
(Scsi_host.can_queue * #hw queue) commands. In commit 6eb045e092ef ("scsi:
 core: avoid host-wide host_busy counter for scsi_mq"), the Scsi host busy
counter was removed, which would stop the LLDD being sent more than
.can_queue commands; however, it should still be ensured that the block
layer does not issue more than .can_queue commands to the Scsi host.

To solve this problem, introduce a shared sbitmap per blk_mq_tag_set,
which may be requested at init time.

New flag BLK_MQ_F_TAG_HCTX_SHARED should be set when requesting the
tagset to indicate whether the shared sbitmap should be used.

Even when BLK_MQ_F_TAG_HCTX_SHARED is set, a full set of tags and requests
are still allocated per hctx; the reason for this is that if tags and
requests were only allocated for a single hctx - like hctx0 - it may break
block drivers which expect a request be associated with a specific hctx,
i.e. not always hctx0. This will introduce extra memory usage.

This change is based on work originally from Ming Lei in [1] and from
Bart's suggestion in [2].

[0] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
[1] https://lore.kernel.org/linux-block/20190531022801.10003-1-ming.lei@redhat.com/
[2] https://lore.kernel.org/linux-block/ff77beff-5fd9-9f05-12b6-826922bace1f@huawei.com/T/#m3db0a602f095cbcbff27e9c884d6b4ae826144be

Tested-by: Don Brace<don.brace@microsemi.com> #SCSI resv cmds patches used
Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-sched.c   |  8 ++++---
 block/blk-mq-tag.c     | 51 ++++++++++++++++++++++++++++++++++++++----
 block/blk-mq-tag.h     |  7 ++++++
 block/blk-mq.c         | 15 +++++++++++++
 block/blk-mq.h         |  5 +++++
 include/linux/blk-mq.h |  6 +++++
 6 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ee970d848e62..777be967c4f2 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -607,7 +607,7 @@ static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 				   struct blk_mq_hw_ctx *hctx,
 				   unsigned int hctx_idx)
 {
-	unsigned int flags = set->flags;
+	unsigned int flags = set->flags & ~BLK_MQ_F_TAG_HCTX_SHARED;
 
 	if (hctx->sched_tags) {
 		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
@@ -621,7 +621,8 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 				   unsigned int hctx_idx)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
-	unsigned int flags = set->flags;
+	/* Clear HCTX_SHARED so tags are init'ed */
+	unsigned int flags = set->flags & ~BLK_MQ_F_TAG_HCTX_SHARED;
 	int ret;
 
 	hctx->sched_tags = blk_mq_alloc_rq_map(set, hctx_idx, q->nr_requests,
@@ -643,7 +644,8 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q)
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		unsigned int flags = hctx->flags;
+		/* Clear HCTX_SHARED so tags are freed */
+		unsigned int flags = hctx->flags & ~BLK_MQ_F_TAG_HCTX_SHARED;
 
 		if (hctx->sched_tags) {
 			blk_mq_free_rq_map(hctx->sched_tags, flags);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 77fbeae05745..c6d7ebc62bdb 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -197,7 +197,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue)
+	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
@@ -450,6 +450,38 @@ static int blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+int blk_mq_init_shared_sbitmap(struct blk_mq_tag_set *set, unsigned int flags)
+{
+	unsigned int depth = set->queue_depth - set->reserved_tags;
+	int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags);
+	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;
+	int i, node = set->numa_node;
+
+	if (bt_alloc(&set->__bitmap_tags, depth, round_robin, node))
+		return -ENOMEM;
+	if (bt_alloc(&set->__breserved_tags, set->reserved_tags,
+		     round_robin, node))
+		goto free_bitmap_tags;
+
+	for (i = 0; i < set->nr_hw_queues; i++) {
+		struct blk_mq_tags *tags = set->tags[i];
+
+		tags->bitmap_tags = &set->__bitmap_tags;
+		tags->breserved_tags = &set->__breserved_tags;
+	}
+
+	return 0;
+free_bitmap_tags:
+	sbitmap_queue_free(&set->__bitmap_tags);
+	return -ENOMEM;
+}
+
+void blk_mq_exit_shared_sbitmap(struct blk_mq_tag_set *set)
+{
+	sbitmap_queue_free(&set->__bitmap_tags);
+	sbitmap_queue_free(&set->__breserved_tags);
+}
+
 struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 				     unsigned int reserved_tags,
 				     int node, unsigned int flags)
@@ -469,6 +501,9 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
+	if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
+		return tags;
+
 	if (blk_mq_init_bitmap_tags(tags, node, alloc_policy) < 0) {
 		kfree(tags);
 		return NULL;
@@ -478,8 +513,10 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
 {
-	sbitmap_queue_free(&tags->__bitmap_tags);
-	sbitmap_queue_free(&tags->__breserved_tags);
+	if (!(flags & BLK_MQ_F_TAG_HCTX_SHARED)) {
+		sbitmap_queue_free(tags->bitmap_tags);
+		sbitmap_queue_free(tags->breserved_tags);
+	}
 	kfree(tags);
 }
 
@@ -498,7 +535,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (tdepth > tags->nr_tags) {
 		struct blk_mq_tag_set *set = hctx->queue->tag_set;
-		unsigned int flags = set->flags;
+		/* Only sched tags can grow, so clear HCTX_SHARED flag  */
+		unsigned int flags = set->flags & ~BLK_MQ_F_TAG_HCTX_SHARED;
 		struct blk_mq_tags *new;
 		bool ret;
 
@@ -537,6 +575,11 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 	return 0;
 }
 
+void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set, unsigned int size)
+{
+	sbitmap_queue_resize(&set->__bitmap_tags, size - set->reserved_tags);
+}
+
 /**
  * blk_mq_unique_tag() - return a tag that is unique queue-wide
  * @rq: request for which to compute a unique tag
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 5b6f25bd1966..8f4cce52ba2d 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -29,12 +29,19 @@ extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
 					int node, unsigned int flags);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags);
 
+extern int blk_mq_init_shared_sbitmap(struct blk_mq_tag_set *set,
+				      unsigned int flags);
+extern void blk_mq_exit_shared_sbitmap(struct blk_mq_tag_set *set);
+
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
 extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 			   unsigned int tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
+extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
+					     unsigned int size);
+
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce712ec818e4..a500d1dfa1bd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3430,11 +3430,21 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
+	if (blk_mq_is_sbitmap_shared(set->flags)) {
+		if (blk_mq_init_shared_sbitmap(set, set->flags)) {
+			ret = -ENOMEM;
+			goto out_free_mq_rq_maps;
+		}
+	}
+
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
 
 	return 0;
 
+out_free_mq_rq_maps:
+	for (i = 0; i < set->nr_hw_queues; i++)
+		blk_mq_free_map_and_requests(set, i);
 out_free_mq_map:
 	for (i = 0; i < set->nr_maps; i++) {
 		kfree(set->map[i].mq_map);
@@ -3453,6 +3463,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 	for (i = 0; i < set->nr_hw_queues; i++)
 		blk_mq_free_map_and_requests(set, i);
 
+	if (blk_mq_is_sbitmap_shared(set->flags))
+		blk_mq_exit_shared_sbitmap(set);
+
 	for (j = 0; j < set->nr_maps; j++) {
 		kfree(set->map[j].mq_map);
 		set->map[j].mq_map = NULL;
@@ -3489,6 +3502,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		if (!hctx->sched_tags) {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
 							false);
+			if (!ret && blk_mq_is_sbitmap_shared(set->flags))
+				blk_mq_tag_resize_shared_sbitmap(set, nr);
 		} else {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
 							nr, true);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index b86e7fe47789..3acdb56065e1 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -159,6 +159,11 @@ struct blk_mq_alloc_data {
 	struct blk_mq_hw_ctx *hctx;
 };
 
+static inline bool blk_mq_is_sbitmap_shared(unsigned int flags)
+{
+	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
+}
+
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
 	if (data->q->elevator)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 95aca7aa8957..03b1f39d5a72 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -231,6 +231,9 @@ enum hctx_type {
  * @flags:	   Zero or more BLK_MQ_F_* flags.
  * @driver_data:   Pointer to data owned by the block driver that created this
  *		   tag set.
+ * @__bitmap_tags: A shared tags sbitmap, used over all hctx's
+ * @__breserved_tags:
+ *		   A shared reserved tags sbitmap, used over all hctx's
  * @tags:	   Tag sets. One tag set per hardware queue. Has @nr_hw_queues
  *		   elements.
  * @tag_list_lock: Serializes tag_list accesses.
@@ -250,6 +253,8 @@ struct blk_mq_tag_set {
 	unsigned int		flags;
 	void			*driver_data;
 
+	struct sbitmap_queue	__bitmap_tags;
+	struct sbitmap_queue	__breserved_tags;
 	struct blk_mq_tags	**tags;
 
 	struct mutex		tag_list_lock;
@@ -384,6 +389,7 @@ enum {
 	 * completing IO:
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
+	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.26.2

