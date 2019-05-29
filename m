Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8422DE1F
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfE2N3K (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfE2N3K (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1808FAE84;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 01/24] block: disable elevator for reserved tags
Date:   Wed, 29 May 2019 15:28:38 +0200
Message-Id: <20190529132901.27645-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reserved requests are internal to the driver and we wouldn't know
if and how they should be merged.
So disable the elevator for reserved tags.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 08a6248d8536..f6711a61ba3b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -368,17 +368,18 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		e = NULL;
+
 	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
 
 		/*
 		 * Flush requests are special and go directly to the
-		 * dispatch list. Don't include reserved tags in the
-		 * limiting, as it isn't useful.
+		 * dispatch list.
 		 */
 		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.limit_depth &&
-		    !(data->flags & BLK_MQ_REQ_RESERVED))
+		    e->type->ops.limit_depth)
 			e->type->ops.limit_depth(data->cmd_flags, data);
 	} else {
 		blk_mq_tag_busy(data->hctx);
-- 
2.16.4

