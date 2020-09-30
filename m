Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB6F27E338
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 10:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgI3IDE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Sep 2020 04:03:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:60946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3IDD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 30 Sep 2020 04:03:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C2BEAF7A;
        Wed, 30 Sep 2020 08:03:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/4] block: return status code in blk_mq_end_request()
Date:   Wed, 30 Sep 2020 10:02:53 +0200
Message-Id: <20200930080256.90964-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200930080256.90964-1-hare@suse.de>
References: <20200930080256.90964-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

blk_mq_end_request() will use the block status returned from
queue_rq() as argument, except in one instance in blk_mq_dispatch_rq_list(),
where the generic BLK_STS_IOERR is used.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0015a1892153..a19dda3a4ad0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1403,7 +1403,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			break;
 		default:
 			errors++;
-			blk_mq_end_request(rq, BLK_STS_IOERR);
+			blk_mq_end_request(rq, ret);
 		}
 	} while (!list_empty(list));
 out:
-- 
2.16.4

