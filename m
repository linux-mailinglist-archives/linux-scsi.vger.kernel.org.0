Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F738EE97
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Apr 2019 03:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfD3BxM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 21:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfD3BxM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Apr 2019 21:53:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3392B87624;
        Tue, 30 Apr 2019 01:53:12 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C0485D796;
        Tue, 30 Apr 2019 01:53:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V9 7/7] block: don't drain in-progress dispatch in blk_cleanup_queue()
Date:   Tue, 30 Apr 2019 09:52:29 +0800
Message-Id: <20190430015229.23141-8-ming.lei@redhat.com>
In-Reply-To: <20190430015229.23141-1-ming.lei@redhat.com>
References: <20190430015229.23141-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 30 Apr 2019 01:53:12 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Now freeing hw queue resource is moved to hctx's release handler,
we don't need to worry about the race between blk_cleanup_queue and
run queue any more.

So don't drain in-progress dispatch in blk_cleanup_queue().

This is basically revert of c2856ae2f315 ("blk-mq: quiesce queue before
freeing queue").

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f5b5f21ae4fd..e24cfcefdc19 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -338,18 +338,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
-	/*
-	 * make sure all in-progress dispatch are completed because
-	 * blk_freeze_queue() can only complete all requests, and
-	 * dispatch may still be in-progress since we dispatch requests
-	 * from more than one contexts.
-	 *
-	 * We rely on driver to deal with the race in case that queue
-	 * initialization isn't done.
-	 */
-	if (queue_is_mq(q) && blk_queue_init_done(q))
-		blk_mq_quiesce_queue(q);
-
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
-- 
2.9.5

