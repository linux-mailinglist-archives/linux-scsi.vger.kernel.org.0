Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB229200AD9
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2020 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgFSOCF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Jun 2020 10:02:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgFSOCE (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 19 Jun 2020 10:02:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C36AADCC;
        Fri, 19 Jun 2020 14:02:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] block: only return started requests from blk_mq_tag_to_rq()
Date:   Fri, 19 Jun 2020 16:01:59 +0200
Message-Id: <20200619140159.141905-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

blk_mq_tag_to_rq() is used from within the driver to map a tag
to a request. As such it should only return requests which are
already started (ie passed to the driver); otherwise the driver
might trip over requests which it has never seen and random
crashes will occur.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f57d27bfa73..f02d18113f9e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -815,9 +815,13 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
+	struct request *rq;
+
 	if (tag < tags->nr_tags) {
 		prefetch(tags->rqs[tag]);
-		return tags->rqs[tag];
+		rq = tags->rqs[tag];
+		if (blk_mq_request_started(rq))
+			return rq;
 	}
 
 	return NULL;
-- 
2.16.4

