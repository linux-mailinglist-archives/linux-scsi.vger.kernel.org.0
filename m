Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7DF10011D
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 10:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKRJWc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 04:22:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:54574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbfKRJWc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 04:22:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F8D6B13A;
        Mon, 18 Nov 2019 09:22:30 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 6/9] scsi: add scsi_host_busy_iter()
Date:   Mon, 18 Nov 2019 10:22:05 +0100
Message-Id: <20191118092208.54521-7-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191118092208.54521-1-hare@suse.de>
References: <20191118092208.54521-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add an iterator scsi_host_busy_iter() to traverse all busy commands.
If locking against concurrent command completions is required it
has to be provided by the caller.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hosts.c     | 33 +++++++++++++++++++++++++++++++++
 include/scsi/scsi_host.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index da1df48ef27c..a0a660b50929 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -674,3 +674,36 @@ void scsi_host_flush_commands(struct Scsi_Host *shost, int status)
 	blk_mq_tagset_busy_iter(&shost->tag_set, flush_cmds_iter, &status);
 }
 EXPORT_SYMBOL_GPL(scsi_host_flush_commands);
+
+struct scsi_host_busy_iter_data {
+	scsi_host_busy_iter_fn *fn;
+	void *priv;
+};
+
+static bool __scsi_host_busy_iter_fn(struct request *req, void *priv,
+				   bool reserved)
+{
+	struct scsi_host_busy_iter_data *iter_data = priv;
+	struct scsi_cmnd *sc = blk_mq_rq_to_pdu(req);
+
+	return iter_data->fn(sc, iter_data->priv, reserved);
+}
+
+/**
+ * scsi_host_busy_iter - Iterate over all busy commands
+ * @shost:	Pointer to Scsi_Host.
+ * @fn:		Function to call on each busy command
+ * @priv:	Data pointer passed to @fn
+ **/
+void scsi_host_busy_iter(struct Scsi_Host *shost,
+			 scsi_host_busy_iter_fn *fn, void *priv)
+{
+	struct scsi_host_busy_iter_data iter_data = {
+		.fn = fn,
+		.priv = priv,
+	};
+
+	blk_mq_tagset_busy_iter(&shost->tag_set, __scsi_host_busy_iter_fn,
+				&iter_data);
+}
+EXPORT_SYMBOL_GPL(scsi_host_busy_iter);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index cb9a6fe9ad5b..1293d9686115 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -761,6 +761,11 @@ static inline int scsi_host_scan_allowed(struct Scsi_Host *shost)
 extern void scsi_unblock_requests(struct Scsi_Host *);
 extern void scsi_block_requests(struct Scsi_Host *);
 
+typedef bool (scsi_host_busy_iter_fn)(struct scsi_cmnd *, void *, bool);
+
+void scsi_host_busy_iter(struct Scsi_Host *,
+			 scsi_host_busy_iter_fn *fn, void *priv);
+
 struct class_container;
 
 /*
-- 
2.16.4

