Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84645213A78
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2020 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGCNBa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Jul 2020 09:01:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgGCNB3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 3 Jul 2020 09:01:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E087AF32;
        Fri,  3 Jul 2020 13:01:27 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/21] scsi: add scsi_{get,put}_internal_cmd() helper
Date:   Fri,  3 Jul 2020 15:01:04 +0200
Message-Id: <20200703130122.111448-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200703130122.111448-1-hare@suse.de>
References: <20200703130122.111448-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add helper functions to allow LLDDs to allocate and free
internal commands.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_device.h |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0ba7a65e7c8d..1d5c1b9a1203 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1903,6 +1903,51 @@ void scsi_mq_destroy_tags(struct Scsi_Host *shost)
 	blk_mq_free_tag_set(&shost->tag_set);
 }
 
+/**
+ * scsi_get_internal_cmd - allocate an internal SCSI command
+ * @sdev: SCSI device from which to allocate the command
+ * @data_direction: Data direction for the allocated command
+ * @op_flags: request allocation flags
+ *
+ * Allocates a SCSI command for internal LLDD use.
+ */
+struct scsi_cmnd *scsi_get_internal_cmd(struct scsi_device *sdev,
+	enum dma_data_direction data_direction, int op_flags)
+{
+	struct request *rq;
+	struct scsi_cmnd *scmd;
+	blk_mq_req_flags_t flags = 0;
+	unsigned int op = REQ_INTERNAL | op_flags;
+
+	op |= (data_direction == DMA_TO_DEVICE) ?
+		REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN;
+	rq = blk_mq_alloc_request(sdev->request_queue, op, flags);
+	if (IS_ERR(rq))
+		return NULL;
+	scmd = blk_mq_rq_to_pdu(rq);
+	scmd->request = rq;
+	scmd->device = sdev;
+	return scmd;
+}
+EXPORT_SYMBOL_GPL(scsi_get_internal_cmd);
+
+/**
+ * scsi_put_internal_cmd - free an internal SCSI command
+ * @scmd: SCSI command to be freed
+ *
+ * Check if @scmd is an internal command, and call
+ * blk_mq_free_request() if true.
+ */
+void scsi_put_internal_cmd(struct scsi_cmnd *scmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(scmd);
+
+	if (WARN_ON(!blk_rq_is_internal(rq)))
+		return;
+	blk_mq_free_request(rq);
+}
+EXPORT_SYMBOL_GPL(scsi_put_internal_cmd);
+
 /**
  * scsi_device_from_queue - return sdev associated with a request_queue
  * @q: The request queue to return the sdev from
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index bc5909033d13..2759a538adae 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <scsi/scsi.h>
 #include <linux/atomic.h>
+#include <linux/dma-direction.h>
 
 struct device;
 struct request_queue;
@@ -460,6 +461,9 @@ static inline int scsi_execute_req(struct scsi_device *sdev,
 	return scsi_execute(sdev, cmd, data_direction, buffer,
 		bufflen, NULL, sshdr, timeout, retries,  0, 0, resid);
 }
+struct scsi_cmnd *scsi_get_internal_cmd(struct scsi_device *sdev,
+	enum dma_data_direction data_direction, int op_flags);
+void scsi_put_internal_cmd(struct scsi_cmnd *scmd);
 extern void sdev_disable_disk_events(struct scsi_device *sdev);
 extern void sdev_enable_disk_events(struct scsi_device *sdev);
 extern int scsi_vpd_lun_id(struct scsi_device *, char *, size_t);
-- 
2.16.4

