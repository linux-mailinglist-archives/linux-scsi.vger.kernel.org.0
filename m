Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3A2DE22
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfE2N3L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfE2N3K (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1848DAEB7;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
Date:   Wed, 29 May 2019 15:28:39 +0200
Message-Id: <20190529132901.27645-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add helper functions to retrieve SCSI commands from the reserved
tag pool.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 include/scsi/scsi_tcq.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index 6053d46e794e..227f3bd4e974 100644
--- a/include/scsi/scsi_tcq.h
+++ b/include/scsi/scsi_tcq.h
@@ -39,5 +39,27 @@ static inline struct scsi_cmnd *scsi_host_find_tag(struct Scsi_Host *shost,
 	return blk_mq_rq_to_pdu(req);
 }
 
+static inline struct scsi_cmnd *scsi_get_reserved_cmd(struct scsi_device *sdev)
+{
+	struct request *rq;
+	struct scsi_cmnd *scmd;
+
+	rq = blk_mq_alloc_request(sdev->request_queue,
+				  REQ_OP_SCSI_OUT | REQ_NOWAIT,
+				  BLK_MQ_REQ_RESERVED);
+	if (IS_ERR(rq))
+		return NULL;
+	scmd = blk_mq_rq_to_pdu(rq);
+	scmd->request = rq;
+	return scmd;
+}
+
+static inline void scsi_put_reserved_cmd(struct scsi_cmnd *scmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(scmd);
+
+	blk_mq_free_request(rq);
+}
+
 #endif /* CONFIG_BLOCK */
 #endif /* _SCSI_SCSI_TCQ_H */
-- 
2.16.4

