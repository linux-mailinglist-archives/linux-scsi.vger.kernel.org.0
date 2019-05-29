Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5932DE32
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfE2N3U (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:45562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbfE2N3M (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A977AFFB;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 10/24] scsi: allocate separate queue for reserved commands
Date:   Wed, 29 May 2019 15:28:47 +0200
Message-Id: <20190529132901.27645-11-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Allocate a separate 'reserved_cmd_q' for sending reserved commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c  | 15 ++++++++++++++-
 include/scsi/scsi_host.h |  4 ++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e17153a9ce7c..076459853622 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1831,6 +1831,7 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
 int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
+	int ret;
 
 	sgl_size = scsi_mq_inline_sgl_size(shost);
 	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
@@ -1850,11 +1851,23 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;
 
-	return blk_mq_alloc_tag_set(&shost->tag_set);
+	ret = blk_mq_alloc_tag_set(&shost->tag_set);
+	if (ret)
+		return ret;
+
+	if (shost->nr_reserved_cmds && shost->use_reserved_cmd_q) {
+		shost->reserved_cmd_q = blk_mq_init_queue(&shost->tag_set);
+		if (IS_ERR(shost->reserved_cmd_q)) {
+			blk_mq_free_tag_set(&shost->tag_set);
+			ret = PTR_ERR(shost->reserved_cmd_q);
+		}
+	}
+	return ret;
 }
 
 void scsi_mq_destroy_tags(struct Scsi_Host *shost)
 {
+	blk_cleanup_queue(shost->reserved_cmd_q);
 	blk_mq_free_tag_set(&shost->tag_set);
 }
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 89998b6bee04..a2bab5f07eff 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -600,6 +600,7 @@ struct Scsi_Host {
 	 * Number of reserved commands, if any.
 	 */
 	unsigned nr_reserved_cmds;
+	struct request_queue *reserved_cmd_q;
 
 	unsigned active_mode:2;
 	unsigned unchecked_isa_dma:1;
@@ -637,6 +638,9 @@ struct Scsi_Host {
 	/* The transport requires the LUN bits NOT to be stored in CDB[1] */
 	unsigned no_scsi2_lun_in_cdb:1;
 
+	/* Host requires a separate reserved_cmd_q */
+	unsigned use_reserved_cmd_q:1;
+
 	/*
 	 * Optional work queue to be utilized by the transport
 	 */
-- 
2.16.4

