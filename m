Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6C20D4C0
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2020 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgF2TL2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jun 2020 15:11:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731053AbgF2TL0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jun 2020 15:11:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20F7DB087;
        Mon, 29 Jun 2020 07:20:56 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Don Brace <don.brace@microchip.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/22] scsi: implement reserved command handling
Date:   Mon, 29 Jun 2020 09:20:07 +0200
Message-Id: <20200629072021.9864-9-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200629072021.9864-1-hare@suse.de>
References: <20200629072021.9864-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Quite some drivers are using management commands internally, which
typically use the same hardware tag pool (ie they are being allocated
from the same hardware resources) as the 'normal' I/O commands.
These commands are set aside before allocating the block-mq tag bitmap,
so they'll never show up as busy in the tag map.
The block-layer, OTOH, already has 'reserved_tags' to handle precisely
this situation.
So this patch adds a new field 'nr_reserved_cmds' to the SCSI host
template to instruct the block layer to set aside a tag space for these
management commands by using reserved tags.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c  | 10 +++++++++-
 include/scsi/scsi_host.h | 11 +++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c2277eff4e06..57ce390dd458 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1887,7 +1887,9 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	else
 		tag_set->ops = &scsi_mq_ops_no_commit;
 	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
-	tag_set->queue_depth = shost->can_queue;
+	tag_set->queue_depth =
+		shost->can_queue + shost->nr_reserved_cmds;
+	tag_set->reserved_tags = shost->nr_reserved_cmds;
 	tag_set->cmd_size = cmd_size;
 	tag_set->numa_node = NUMA_NO_NODE;
 	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
@@ -1910,6 +1912,9 @@ void scsi_mq_destroy_tags(struct Scsi_Host *shost)
  * @op_flags: request allocation flags
  *
  * Allocates a SCSI command for internal LLDD use.
+ * If 'nr_reserved_commands' is spectified by the host the
+ * command will be allocated from the reserved tag pool;
+ * otherwise the normal tag pool will be used.
  */
 struct scsi_cmnd *scsi_get_internal_cmd(struct scsi_device *sdev,
 	enum dma_data_direction data_direction, int op_flags)
@@ -1919,6 +1924,9 @@ struct scsi_cmnd *scsi_get_internal_cmd(struct scsi_device *sdev,
 	blk_mq_req_flags_t flags = 0;
 	unsigned int op = REQ_INTERNAL | op_flags;
 
+	if (sdev->host->nr_reserved_cmds)
+		flags = BLK_MQ_REQ_RESERVED;
+
 	op |= (data_direction == DMA_TO_DEVICE) ?
 		REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN;
 	rq = blk_mq_alloc_request(sdev->request_queue, op, flags);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 46ef8cccc982..b94938e87e3a 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -590,6 +590,11 @@ struct Scsi_Host {
 	unsigned short max_cmd_len;
 
 	int this_id;
+
+	/*
+	 * Number of commands this host can handle at the same time.
+	 * This excludes reserved commands as specified by nr_reserved_cmds.
+	 */
 	int can_queue;
 	short cmd_per_lun;
 	short unsigned int sg_tablesize;
@@ -606,6 +611,12 @@ struct Scsi_Host {
 	 * is nr_hw_queues * can_queue.
 	 */
 	unsigned nr_hw_queues;
+
+	/*
+	 * Number of reserved commands to allocate, if any.
+	 */
+	unsigned nr_reserved_cmds;
+
 	unsigned active_mode:2;
 	unsigned unchecked_isa_dma:1;
 
-- 
2.16.4

