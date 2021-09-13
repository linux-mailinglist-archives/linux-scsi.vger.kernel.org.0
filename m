Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD74096F3
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Sep 2021 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbhIMPS7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Sep 2021 11:18:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3775 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345654AbhIMPSp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Sep 2021 11:18:45 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H7VQq1spNz67M3Q;
        Mon, 13 Sep 2021 23:15:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 17:17:27 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 16:17:25 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <ming.lei@redhat.com>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RESEND v3 03/13] blk-mq: Relocate shared sbitmap resize in blk_mq_update_nr_requests()
Date:   Mon, 13 Sep 2021 23:12:20 +0800
Message-ID: <1631545950-56586-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For shared sbitmap, if the call to blk_mq_tag_update_depth() was
successful for any hctx when hctx->sched_tags is not set, then it would be
successful for all (due to nature in which blk_mq_tag_update_depth()
fails).

As such, there is no need to call blk_mq_tag_resize_shared_sbitmap() for
each hctx. So relocate the call until after the hctx iteration under the
!q->elevator check, which is equivalent (to !hctx->sched_tags).

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2316ff27c1f5..1a4bb2db30e5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3616,8 +3616,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		if (!hctx->sched_tags) {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
 							false);
-			if (!ret && blk_mq_is_sbitmap_shared(set->flags))
-				blk_mq_tag_resize_shared_sbitmap(set, nr);
 		} else {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
 							nr, true);
@@ -3635,9 +3633,13 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	}
 	if (!ret) {
 		q->nr_requests = nr;
-		if (q->elevator && blk_mq_is_sbitmap_shared(set->flags))
-			sbitmap_queue_resize(&q->sched_bitmap_tags,
-					     nr - set->reserved_tags);
+		if (blk_mq_is_sbitmap_shared(set->flags)) {
+			if (q->elevator)
+				sbitmap_queue_resize(&q->sched_bitmap_tags,
+						     nr - set->reserved_tags);
+			else
+				blk_mq_tag_resize_shared_sbitmap(set, nr);
+		}
 	}
 
 	blk_mq_unquiesce_queue(q);
-- 
2.26.2

