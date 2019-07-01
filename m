Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A372B820
	for <lists+linux-scsi@lfdr.de>; Mon, 27 May 2019 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfE0PDN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 May 2019 11:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfE0PDN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 27 May 2019 11:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2BD53091D67;
        Mon, 27 May 2019 15:03:12 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 173511017E39;
        Mon, 27 May 2019 15:03:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on CPU unplug
Date:   Mon, 27 May 2019 23:02:07 +0800
Message-Id: <20190527150207.11372-6-ming.lei@redhat.com>
In-Reply-To: <20190527150207.11372-1-ming.lei@redhat.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 27 May 2019 15:03:13 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Managed interrupts can not migrate affinity when their CPUs are offline.
If the CPU is allowed to shutdown before they're returned, commands
dispatched to managed queues won't be able to complete through their
irq handlers.

Wait in cpu hotplug handler until all inflight requests on the tags
are completed or timeout. Wait once for each tags, so we can save time
in case of shared tags.

Based on the following patch from Keith, and use simple delay-spin
instead.

https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/

Some SCSI devices may have single blk_mq hw queue and multiple private
completion queues, and wait until all requests on the private completion
queue are completed.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  2 +-
 block/blk-mq-tag.h |  5 +++
 block/blk-mq.c     | 94 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7513c8eaabee..b24334f99c5d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -332,7 +332,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..9ce7606a87f0 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -19,6 +19,9 @@ struct blk_mq_tags {
 	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+#define BLK_MQ_TAGS_DRAINED           0
+	unsigned long flags;
 };
 
 
@@ -35,6 +38,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32b8ad3d341b..ab1fbfd48374 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2215,6 +2215,65 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
+{
+	struct blk_mq_hw_ctx	*hctx =
+		hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+
+	if (hctx->tags)
+		clear_bit(BLK_MQ_TAGS_DRAINED, &hctx->tags->flags);
+
+	return 0;
+}
+
+struct blk_mq_inflight_rq_data {
+	unsigned cnt;
+	const struct cpumask *cpumask;
+};
+
+static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
+				     bool reserved)
+{
+	struct blk_mq_inflight_rq_data *count = data;
+
+	if ((blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) &&
+			cpumask_test_cpu(blk_mq_rq_cpu(rq), count->cpumask))
+		count->cnt++;
+
+	return true;
+}
+
+unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags,
+		const struct cpumask *completion_cpus)
+{
+	struct blk_mq_inflight_rq_data data = {
+		.cnt = 0,
+		.cpumask = completion_cpus,
+	};
+
+	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &data);
+
+	return data.cnt;
+}
+
+static void blk_mq_drain_inflight_rqs(struct blk_mq_tags *tags,
+		const struct cpumask *completion_cpus)
+{
+	if (!tags)
+		return;
+
+	/* Can't apply the optimization in case of private completion queues */
+	if (completion_cpus == cpu_all_mask &&
+			test_and_set_bit(BLK_MQ_TAGS_DRAINED, &tags->flags))
+		return;
+
+	while (1) {
+		if (!blk_mq_tags_inflight_rqs(tags, completion_cpus))
+			break;
+		msleep(5);
+	}
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2226,6 +2285,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
+	struct request_queue *q;
+	const struct cpumask *cpumask = NULL, *completion_cpus;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
@@ -2238,14 +2299,32 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
 
-	if (list_empty(&tmp))
-		return 0;
+	if (!list_empty(&tmp)) {
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&tmp, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
 
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+		blk_mq_run_hw_queue(hctx, true);
+	}
+
+	/*
+	 * Interrupt for the current completion queue will be shutdown, so
+	 * wait until all requests on this queue are completed.
+	 */
+	q = hctx->queue;
+	if (q->mq_ops->complete_queue_affinity)
+		cpumask = q->mq_ops->complete_queue_affinity(hctx, cpu);
+
+	if (!cpumask) {
+		cpumask = hctx->cpumask;
+		completion_cpus = cpu_all_mask;
+	} else {
+		completion_cpus = cpumask;
+	}
+
+	if (cpumask_first_and(cpumask, cpu_online_mask) >= nr_cpu_ids)
+		blk_mq_drain_inflight_rqs(hctx->tags, completion_cpus);
 
-	blk_mq_run_hw_queue(hctx, true);
 	return 0;
 }
 
@@ -3541,7 +3620,8 @@ EXPORT_SYMBOL(blk_mq_rq_cpu);
 
 static int __init blk_mq_init(void)
 {
-	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
+	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead",
+				blk_mq_hctx_notify_prepare,
 				blk_mq_hctx_notify_dead);
 	return 0;
 }
-- 
2.20.1

