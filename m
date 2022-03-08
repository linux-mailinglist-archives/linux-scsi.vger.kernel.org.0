Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF54D0F7C
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Mar 2022 06:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiCHFxH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 00:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiCHFxF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 00:53:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FEEC1C;
        Mon,  7 Mar 2022 21:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O6z0IYbmbkmAh88yybQCF6FYRkBw9zbZ117XaxaFvAs=; b=kJdWMTuHboJZEyGA/dnmkvdAPC
        iUHIdtnbKlJq7aDIfMiLorcCCXslcFPLvAzDTO7V9FQX578AuK+PnX9EfQEV7C68FcQ4Y3sf+G7jC
        7NbS5VSSpfbGUCJcbJWbDk5bp1H1OuIteyTvmI0LdW+r4A7nxcnvX4UaztgUBqjJky6oNF5E11U0F
        J657rDQrzJnouuS/NxY7OmMIvJV6CnoW7V+ITbd5f/v3lAUrIiRzROH+z6g8Mnwx5xrIUXAOvqAfW
        TwugHpj+qdhF3RSsmAvydVnEUoDqhUNz60keSHMDYAUkj4hheSDTUE5HxB23mbMhC1pFlbO6JtUnI
        F7+A7o/A==;
Received: from [2001:4bb8:184:7746:6f50:7a98:3141:c37b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRSlQ-002ikq-SI; Tue, 08 Mar 2022 05:52:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 01/14] blk-mq: do not include passthrough requests in I/O accounting
Date:   Tue,  8 Mar 2022 06:51:47 +0100
Message-Id: <20220308055200.735835-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308055200.735835-1-hch@lst.de>
References: <20220308055200.735835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

I/O accounting buckets I/O into the read/write/discard categories into
which passthrough I/O does not fit at all.  It also accounts to the
block_device, which may not even exist for passthrough I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-mq.c | 11 ++++++++---
 block/blk.h    |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a05ce77250316..ab4b646551334 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -883,10 +883,15 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 
 static void __blk_account_io_start(struct request *rq)
 {
-	/* passthrough requests can hold bios that do not have ->bi_bdev set */
-	if (rq->bio && rq->bio->bi_bdev)
+	/*
+	 * All non-passthrough requests are created from a bio with one
+	 * exception: when a flush command that is part of a flush sequence
+	 * generated by the state machine in blk-flush.c is cloned onto the
+	 * lower device by dm-multipath we can get here without a bio.
+	 */
+	if (rq->bio)
 		rq->part = rq->bio->bi_bdev;
-	else if (rq->q->disk)
+	else
 		rq->part = rq->q->disk->part0;
 
 	part_stat_lock();
diff --git a/block/blk.h b/block/blk.h
index ebaa59ca46ca6..6f21859c7f0ff 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -325,7 +325,7 @@ int blk_dev_init(void);
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return (rq->rq_flags & RQF_IO_STAT) && rq->q->disk;
+	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
-- 
2.30.2

