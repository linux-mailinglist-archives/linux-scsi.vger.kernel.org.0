Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6C2DE2F
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfE2N3T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbfE2N3N (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E9B4AFFC;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 15/24] hpsa: drop refcount field from CommandList
Date:   Wed, 29 May 2019 15:28:52 +0200
Message-Id: <20190529132901.27645-16-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Field is not unused, so drop it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hpsa.c     | 12 ++----------
 drivers/scsi/hpsa_cmd.h |  1 -
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 2c34cfe3fdea..38380bf72669 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5483,8 +5483,8 @@ static void hpsa_cmd_init(struct ctlr_info *h, int index,
 {
 	dma_addr_t cmd_dma_handle, err_dma_handle;
 
-	/* Zero out all of commandlist except the last field, refcount */
-	memset(c, 0, offsetof(struct CommandList, refcount));
+	/* Zero out all of commandlist */
+	memset(c, 0, sizeof(struct CommandList));
 	c->Header.tag = cpu_to_le64((u64) (index << DIRECT_LOOKUP_SHIFT));
 	cmd_dma_handle = h->cmd_pool_dhandle + index * sizeof(*c);
 	c->err_info = h->errinfo_pool + index;
@@ -5506,7 +5506,6 @@ static void hpsa_preinitialize_commands(struct ctlr_info *h)
 		struct CommandList *c = h->cmd_pool + i;
 
 		hpsa_cmd_init(h, i, c);
-		atomic_set(&c->refcount, 0);
 	}
 }
 
@@ -6092,19 +6091,12 @@ static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 		return NULL;
 	}
 
-	atomic_inc(&c->refcount);
-
 	hpsa_cmd_partial_init(h, idx, c);
 	return c;
 }
 
 static void cmd_tagged_free(struct ctlr_info *h, struct CommandList *c)
 {
-	/*
-	 * Release our reference to the block.  We don't need to do anything
-	 * else to free it, because it is accessed by index.
-	 */
-	(void)atomic_dec(&c->refcount);
 	c->scsi_cmd = NULL;
 }
 
diff --git a/drivers/scsi/hpsa_cmd.h b/drivers/scsi/hpsa_cmd.h
index 2daf08f81d80..eccb10bc18f8 100644
--- a/drivers/scsi/hpsa_cmd.h
+++ b/drivers/scsi/hpsa_cmd.h
@@ -449,7 +449,6 @@ struct CommandList {
 
 	int abort_pending;
 	struct hpsa_scsi_dev_t *device;
-	atomic_t refcount; /* Must be last to avoid memset in hpsa_cmd_init() */
 } __aligned(COMMANDLIST_ALIGNMENT);
 
 /* Max S/G elements in I/O accelerator command */
-- 
2.16.4

