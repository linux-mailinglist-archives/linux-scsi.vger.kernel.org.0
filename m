Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053E93069F
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 04:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEaC2j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 22:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC2i (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 22:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E93AA836;
        Fri, 31 May 2019 02:28:38 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5F087E322;
        Fri, 31 May 2019 02:28:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/9] scsi: Add template flag 'host_tagset'
Date:   Fri, 31 May 2019 10:27:55 +0800
Message-Id: <20190531022801.10003-4-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 31 May 2019 02:28:38 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Add a host template flag 'host_tagset' so hostwide tagset can be
shared on multiple reply queues after the SCSI device's reply queue
is converted to blk-mq hw queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c  | 2 ++
 include/scsi/scsi_host.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 65d0a10c76ad..2397947ed9fc 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1834,6 +1834,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	shost->tag_set.flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
+	if (shost->hostt->host_tagset)
+		shost->tag_set.flags |= BLK_MQ_F_HOST_TAGS;
 	shost->tag_set.driver_data = shost;
 
 	return blk_mq_alloc_tag_set(&shost->tag_set);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a5fcdad4a03e..48bb7a666be6 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -428,6 +428,9 @@ struct scsi_host_template {
 	/* True if the low-level driver supports blk-mq only */
 	unsigned force_blk_mq:1;
 
+	/* True if the host uses host-wide tagspace */
+	unsigned host_tagset:1;
+
 	/*
 	 * Countdown for host blocking with no commands outstanding.
 	 */
-- 
2.20.1

