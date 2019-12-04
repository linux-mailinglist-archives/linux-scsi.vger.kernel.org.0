Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157EE112DE2
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Dec 2019 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfLDO70 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Dec 2019 09:59:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728068AbfLDO7Z (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:59:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08368AE89;
        Wed,  4 Dec 2019 14:59:24 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        Balsundar P <balsundar.p@microchip.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 10/13] scsi: add scsi_host_busy_iter()
Date:   Wed,  4 Dec 2019 15:59:15 +0100
Message-Id: <20191204145918.143134-11-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191204145918.143134-1-hare@suse.de>
References: <20191204145918.143134-1-hare@suse.de>
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
index 00ae9d43ce9f..91987b9fb45f 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -678,3 +678,36 @@ void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status)
 				&status);
 }
 EXPORT_SYMBOL_GPL(scsi_host_complete_all_commands);
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
index 71472eace583..02ac2c61b5af 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -763,6 +763,11 @@ extern void scsi_block_requests(struct Scsi_Host *);
 extern int scsi_host_block(struct Scsi_Host *shost);
 extern int scsi_host_unblock(struct Scsi_Host *shost, int new_state);
 
+typedef bool (scsi_host_busy_iter_fn)(struct scsi_cmnd *, void *, bool);
+
+void scsi_host_busy_iter(struct Scsi_Host *,
+			 scsi_host_busy_iter_fn *fn, void *priv);
+
 struct class_container;
 
 /*
-- 
2.16.4

