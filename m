Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8D2DE35
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfE2N3V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbfE2N3L (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FFD0AFE2;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 11/24] scsi: add scsi_host_get_reserved_cmd()
Date:   Wed, 29 May 2019 15:28:48 +0200
Message-Id: <20190529132901.27645-12-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Implement a function to allocate a SCSI command from the reserved
tag pool using the host-wide reserved command queue.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c  | 21 +++++++++++++++++++++
 include/scsi/scsi_cmnd.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 076459853622..da850bf28065 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1871,6 +1871,27 @@ void scsi_mq_destroy_tags(struct Scsi_Host *shost)
 	blk_mq_free_tag_set(&shost->tag_set);
 }
 
+struct scsi_cmnd *scsi_host_get_reserved_cmd(struct Scsi_Host *shost)
+{
+	struct request *rq;
+	struct scsi_cmnd *scmd;
+
+	if (WARN_ON(!shost->reserved_cmd_q))
+		return NULL;
+
+	rq = blk_mq_alloc_request(shost->reserved_cmd_q,
+				  REQ_OP_DRV_OUT | REQ_NOWAIT,
+				  BLK_MQ_REQ_RESERVED);
+	if (IS_ERR(rq))
+		return NULL;
+	WARN_ON(rq->tag == -1);
+	scmd = blk_mq_rq_to_pdu(rq);
+	scmd->request = rq;
+
+	return scmd;
+}
+EXPORT_SYMBOL_GPL(scsi_host_get_reserved_cmd);
+
 /**
  * scsi_device_from_queue - return sdev associated with a request_queue
  * @q: The request queue to return the sdev from
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 318f1e729318..4a45704b28fe 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -167,6 +167,7 @@ static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
 }
 
+struct scsi_cmnd *scsi_host_get_reserved_cmd(struct Scsi_Host *shost);
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
 
-- 
2.16.4

