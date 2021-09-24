Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0A416DD8
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Sep 2021 10:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244819AbhIXIfU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Sep 2021 04:35:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3859 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbhIXIfQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Sep 2021 04:35:16 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG4xP255Fz67Xk3;
        Fri, 24 Sep 2021 16:31:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:33:41 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 09:33:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <ming.lei@redhat.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v4 05/13] blk-mq-sched: Rename blk_mq_sched_alloc_{tags -> map_and_rqs}()
Date:   Fri, 24 Sep 2021 16:28:22 +0800
Message-ID: <1632472110-244938-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1632472110-244938-1-git-send-email-john.garry@huawei.com>
References: <1632472110-244938-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Function blk_mq_sched_alloc_tags() does same as
__blk_mq_alloc_map_and_request(), so give a similar name to be consistent.

Similarly rename label err_free_tags -> err_free_map_and_rqs.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2231fb0d4c35..644b6d554d72 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -515,9 +515,9 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 	percpu_ref_put(&q->q_usage_counter);
 }
 
-static int blk_mq_sched_alloc_tags(struct request_queue *q,
-				   struct blk_mq_hw_ctx *hctx,
-				   unsigned int hctx_idx)
+static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
+					  struct blk_mq_hw_ctx *hctx,
+					  unsigned int hctx_idx)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	int ret;
@@ -609,15 +609,15 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 				   BLKDEV_DEFAULT_RQ);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		ret = blk_mq_sched_alloc_tags(q, hctx, i);
+		ret = blk_mq_sched_alloc_map_and_rqs(q, hctx, i);
 		if (ret)
-			goto err_free_tags;
+			goto err_free_map_and_rqs;
 	}
 
 	if (blk_mq_is_sbitmap_shared(q->tag_set->flags)) {
 		ret = blk_mq_init_sched_shared_sbitmap(q);
 		if (ret)
-			goto err_free_tags;
+			goto err_free_map_and_rqs;
 	}
 
 	ret = e->ops.init_sched(q, e);
@@ -645,7 +645,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 err_free_sbitmap:
 	if (blk_mq_is_sbitmap_shared(q->tag_set->flags))
 		blk_mq_exit_sched_shared_sbitmap(q);
-err_free_tags:
+err_free_map_and_rqs:
 	blk_mq_sched_free_requests(q);
 	blk_mq_sched_tags_teardown(q);
 	q->elevator = NULL;
-- 
2.26.2

