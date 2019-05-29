Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B482DE26
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfE2N3O (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727164AbfE2N3N (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E105B00B;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 18/24] scsi: Implement scsi_is_reserved_cmd()
Date:   Wed, 29 May 2019 15:28:55 +0200
Message-Id: <20190529132901.27645-19-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add function to check if a SCSI command originates from the reserved
command pool.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c          | 13 +++++++++++++
 include/linux/blk-mq.h  |  2 ++
 include/scsi/scsi_tcq.h | 10 +++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6711a61ba3b..a2212c117782 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -289,6 +289,19 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 	return (rq->rq_flags & RQF_IO_STAT) || rq->q->elevator;
 }
 
+/**
+ * blk_mq_rq_is_reserved - Check if a request has a reserved tag
+ *
+ * @rq: Request to check
+ */
+bool blk_mq_rq_is_reserved(struct request *rq)
+{
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	return blk_mq_tag_is_reserved(hctx->tags, rq->tag);
+}
+EXPORT_SYMBOL_GPL(blk_mq_rq_is_reserved);
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, unsigned int op)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15d1aa53d96c..e0e49f1c6f3c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -348,6 +348,8 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	return rq + 1;
 }
 
+bool blk_mq_rq_is_reserved(struct request *rq);
+
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
 	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index 227f3bd4e974..0c11e8fbe6d2 100644
--- a/include/scsi/scsi_tcq.h
+++ b/include/scsi/scsi_tcq.h
@@ -58,7 +58,15 @@ static inline void scsi_put_reserved_cmd(struct scsi_cmnd *scmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(scmd);
 
-	blk_mq_free_request(rq);
+	if (blk_mq_rq_is_reserved(rq))
+		blk_mq_free_request(rq);
+}
+
+static inline bool scsi_is_reserved_cmd(struct scsi_cmnd *scmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(scmd);
+
+	return blk_mq_rq_is_reserved(rq);
 }
 
 #endif /* CONFIG_BLOCK */
-- 
2.16.4

