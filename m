Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32FC20A075
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2020 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405297AbgFYOBt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jun 2020 10:01:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405283AbgFYOBr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Jun 2020 10:01:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97A34AC7F;
        Thu, 25 Jun 2020 14:01:45 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.de>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/22] block: add flag for internal commands
Date:   Thu, 25 Jun 2020 16:01:04 +0200
Message-Id: <20200625140124.17201-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200625140124.17201-1-hare@suse.de>
References: <20200625140124.17201-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some drivers require to allocate requests for internal command
submission. These request will never be passed through the block
layer, but nevertheless require a valid tag to avoid them clashing
with normal I/O commands.
This patch adds a new request flag REQ_INTERNAL to mark such
requests and a terminates any such commands in blk_execute_rq_nowait()
with a WARN_ON to signal such an invalid usage.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-exec.c          | 5 +++++
 include/linux/blk_types.h | 2 ++
 include/linux/blkdev.h    | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 85324d53d072..86e8968cfa90 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -55,6 +55,11 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	rq->rq_disk = bd_disk;
 	rq->end_io = done;
 
+	if (WARN_ON(blk_rq_is_internal(rq))) {
+		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
+		return;
+	}
+
 	blk_account_io_start(rq);
 
 	/*
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..e386c43e4d77 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -360,6 +360,7 @@ enum req_flag_bits {
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
+	__REQ_INTERNAL,		/* driver-internal command */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -384,6 +385,7 @@ enum req_flag_bits {
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_INTERNAL		(1ULL << __REQ_INTERNAL)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..d09210d4591e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -273,6 +273,11 @@ static inline bool blk_rq_is_passthrough(struct request *rq)
 	return blk_rq_is_scsi(rq) || blk_rq_is_private(rq);
 }
 
+static inline bool blk_rq_is_internal(struct request *rq)
+{
+	return rq->cmd_flags & REQ_INTERNAL;
+}
+
 static inline bool bio_is_passthrough(struct bio *bio)
 {
 	unsigned op = bio_op(bio);
-- 
2.16.4

