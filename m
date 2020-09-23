Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D71274E7C
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Sep 2020 03:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgIWBek (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Sep 2020 21:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbgIWBek (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 22 Sep 2020 21:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600824879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRAH2PQ0f3UQMWllLckup/c3u2jNS0XII72hxpROI/w=;
        b=EVXRNhgAwqciwHuA55mkcUtNf9SxvzVErh2xB9Bj5RyUTimjO+ip/BN2tKjUi+3o6nxIBp
        1J9wqANI1cU1OxFzQJ9PXIUsjurvmGtEiBmO7i63CEso5/v9mMcCLLzIzQN+4lFjKkVfMc
        UG758dp+Cmodw3ExSppQoncYpk8mk6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-obV6k7bdNeKWZXm7_OIrUA-1; Tue, 22 Sep 2020 21:34:35 -0400
X-MC-Unique: obV6k7bdNeKWZXm7_OIrUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0D681CBEB;
        Wed, 23 Sep 2020 01:34:33 +0000 (UTC)
Received: from localhost (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FAE178822;
        Wed, 23 Sep 2020 01:34:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 for 5.11 07/12] blk-mq: add callbacks for storing & retrieving budget token
Date:   Wed, 23 Sep 2020 09:33:34 +0800
Message-Id: <20200923013339.1621784-8-ming.lei@redhat.com>
In-Reply-To: <20200923013339.1621784-1-ming.lei@redhat.com>
References: <20200923013339.1621784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SCSI is the only driver which requires dispatch budget, and it isn't
fair to add one field into 'struct request' for storing budget token
which will be used in the following patches for improving scsi's device
busy scalability.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c  | 18 ++++++++++++++++++
 include/linux/blk-mq.h   |  9 +++++++++
 include/scsi/scsi_cmnd.h |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0c0548b95e4b..bfcccc73fd01 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1655,6 +1655,20 @@ static bool scsi_mq_get_budget(struct request_queue *q)
 	return false;
 }
 
+static void scsi_mq_set_rq_budget_token(struct request *req, int token)
+{
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
+
+	cmd->budget_token = token;
+}
+
+static int scsi_mq_get_rq_budget_token(struct request *req)
+{
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
+
+	return cmd->budget_token;
+}
+
 static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -1864,6 +1878,8 @@ static const struct blk_mq_ops scsi_mq_ops_no_commit = {
 	.cleanup_rq	= scsi_cleanup_rq,
 	.busy		= scsi_mq_lld_busy,
 	.map_queues	= scsi_map_queues,
+	.set_rq_budget_token = scsi_mq_set_rq_budget_token,
+	.get_rq_budget_token = scsi_mq_get_rq_budget_token,
 };
 
 
@@ -1892,6 +1908,8 @@ static const struct blk_mq_ops scsi_mq_ops = {
 	.cleanup_rq	= scsi_cleanup_rq,
 	.busy		= scsi_mq_lld_busy,
 	.map_queues	= scsi_map_queues,
+	.set_rq_budget_token = scsi_mq_set_rq_budget_token,
+	.get_rq_budget_token = scsi_mq_get_rq_budget_token,
 };
 
 struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..71060c6a84b1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -314,6 +314,15 @@ struct blk_mq_ops {
 	 */
 	void (*put_budget)(struct request_queue *);
 
+	/*
+	 * @set_rq_budget_toekn: store rq's budget token
+	 */
+	void (*set_rq_budget_token)(struct request *, int);
+	/*
+	 * @get_rq_budget_toekn: retrieve rq's budget token
+	 */
+	int (*get_rq_budget_token)(struct request *);
+
 	/**
 	 * @timeout: Called on request timeout.
 	 */
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index e76bac4d14c5..b0a2f2ca60ef 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -75,6 +75,8 @@ struct scsi_cmnd {
 
 	int eh_eflags;		/* Used by error handlr */
 
+	int budget_token;
+
 	/*
 	 * This is set to jiffies as it was when the command was first
 	 * allocated.  It is used to time how long the command has
-- 
2.25.2

