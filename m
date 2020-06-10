Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DAD1F5A91
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2020 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFJRdc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jun 2020 13:33:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgFJRdb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 10 Jun 2020 13:33:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D8E569FF5E15F0A2D922;
        Thu, 11 Jun 2020 01:33:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 11 Jun 2020 01:33:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <don.brace@microsemi.com>,
        <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>, <hare@suse.com>,
        <hch@lst.de>, <shivasharan.srikanteshwara@broadcom.com>
CC:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <chenxiang66@hisilicon.com>,
        <megaraidlinux.pdl@broadcom.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v7 01/12] blk-mq: rename BLK_MQ_F_TAG_SHARED as BLK_MQ_F_TAG_QUEUE_SHARED
Date:   Thu, 11 Jun 2020 01:29:08 +0800
Message-ID: <1591810159-240929-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

BLK_MQ_F_TAG_SHARED actually means that tags is shared among request
queues, all of which should belong to LUNs attached to same HBA.

So rename it to make the point explicitly.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-debugfs.c |  2 +-
 block/blk-mq-tag.c     |  2 +-
 block/blk-mq-tag.h     |  4 ++--
 block/blk-mq.c         | 20 ++++++++++----------
 include/linux/blk-mq.h |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 15df3a36e9fa..52d11f8422a7 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -237,7 +237,7 @@ static const char *const alloc_policy_name[] = {
 #define HCTX_FLAG_NAME(name) [ilog2(BLK_MQ_F_##name)] = #name
 static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(SHOULD_MERGE),
-	HCTX_FLAG_NAME(TAG_SHARED),
+	HCTX_FLAG_NAME(TAG_QUEUE_SHARED),
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 96a39d0724a2..85aa1690cbcf 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -65,7 +65,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 {
 	unsigned int depth, users;
 
-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
+	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return true;
 	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		return true;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d38e48f2a0a4..c810a346db8e 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -56,7 +56,7 @@ extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
 static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED))
+	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return false;
 
 	return __blk_mq_tag_busy(hctx);
@@ -64,7 +64,7 @@ static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED))
+	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return;
 
 	__blk_mq_tag_idle(hctx);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9a36ac1c1fa1..d255c485ca5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -281,7 +281,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	} else {
-		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
+		if (data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
 			atomic_inc(&data->hctx->nr_active);
 		}
@@ -1116,7 +1116,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	wait_queue_entry_t *wait;
 	bool ret;
 
-	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED)) {
+	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
 
 		/*
@@ -1282,7 +1282,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 				 * For non-shared tags, the RESTART check
 				 * will suffice.
 				 */
-				if (hctx->flags & BLK_MQ_F_TAG_SHARED)
+				if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 					no_tag = true;
 				break;
 			}
@@ -2579,7 +2579,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
 	hctx->queue = q;
-	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
+	hctx->flags = set->flags & ~BLK_MQ_F_TAG_QUEUE_SHARED;
 
 	INIT_LIST_HEAD(&hctx->hctx_list);
 
@@ -2796,9 +2796,9 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (shared)
-			hctx->flags |= BLK_MQ_F_TAG_SHARED;
+			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 		else
-			hctx->flags &= ~BLK_MQ_F_TAG_SHARED;
+			hctx->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
 	}
 }
 
@@ -2824,7 +2824,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	list_del_rcu(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
-		set->flags &= ~BLK_MQ_F_TAG_SHARED;
+		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
 		/* update existing queue */
 		blk_mq_update_tag_set_depth(set, false);
 	}
@@ -2841,12 +2841,12 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
 	 */
 	if (!list_empty(&set->tag_list) &&
-	    !(set->flags & BLK_MQ_F_TAG_SHARED)) {
-		set->flags |= BLK_MQ_F_TAG_SHARED;
+	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 		/* update existing queue */
 		blk_mq_update_tag_set_depth(set, true);
 	}
-	if (set->flags & BLK_MQ_F_TAG_SHARED)
+	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 		queue_set_hctx_shared(q, true);
 	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d6fcae17da5a..233209e8030d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -392,7 +392,7 @@ struct blk_mq_ops {
 
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
-	BLK_MQ_F_TAG_SHARED	= 1 << 1,
+	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,
 	/*
 	 * Set when this device requires underlying blk-mq device for
 	 * completing IO:
-- 
2.26.2

