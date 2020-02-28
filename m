Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC3173217
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Feb 2020 08:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgB1HxX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 02:53:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:59748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgB1HxX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 02:53:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1C508B03C;
        Fri, 28 Feb 2020 07:53:20 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/13] scsi: add scsi_host_complete_all_commands() helper
Date:   Fri, 28 Feb 2020 08:53:07 +0100
Message-Id: <20200228075318.91255-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200228075318.91255-1-hare@suse.de>
References: <20200228075318.91255-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a helper scsi_host_complete_all_commands() to terminate all outstanding
commands on a scsi host.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/hosts.c     | 28 ++++++++++++++++++++++++++++
 include/scsi/scsi_host.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 1d669e47b692..00ae9d43ce9f 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -650,3 +650,31 @@ void scsi_flush_work(struct Scsi_Host *shost)
 	flush_workqueue(shost->work_q);
 }
 EXPORT_SYMBOL_GPL(scsi_flush_work);
+
+static bool complete_all_cmds_iter(struct request *rq, void *data, bool rsvd)
+{
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+	int status = *(int *)data;
+
+	scsi_dma_unmap(scmd);
+	scmd->result = status << 16;
+	scmd->scsi_done(scmd);
+	return true;
+}
+
+/**
+ * scsi_host_complete_all_commands - Terminate all running commands
+ * @shost:	Scsi Host on which commands should be terminated
+ * @status:	Status to be set for the terminated commands
+ *
+ * There is no protection against modification of the number
+ * of outstanding commands. It is the responsibility of the
+ * caller to ensure that concurrent I/O submission and/or
+ * completion is stopped when calling this function.
+ */
+void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status)
+{
+	blk_mq_tagset_busy_iter(&shost->tag_set, complete_all_cmds_iter,
+				&status);
+}
+EXPORT_SYMBOL_GPL(scsi_host_complete_all_commands);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 7a97fb8104cf..25bef781cbe1 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -732,6 +732,8 @@ extern int scsi_host_busy(struct Scsi_Host *shost);
 extern void scsi_host_put(struct Scsi_Host *t);
 extern struct Scsi_Host *scsi_host_lookup(unsigned short);
 extern const char *scsi_host_state_name(enum scsi_host_state);
+extern void scsi_host_complete_all_commands(struct Scsi_Host *shost,
+					    int status);
 
 static inline int __must_check scsi_add_host(struct Scsi_Host *host,
 					     struct device *dev)
-- 
2.16.4

