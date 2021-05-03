Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228B0371772
	for <lists+linux-scsi@lfdr.de>; Mon,  3 May 2021 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhECPEw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 May 2021 11:04:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhECPEk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 May 2021 11:04:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AED30B1EC;
        Mon,  3 May 2021 15:03:44 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Don Brace <don.brace@microchip.com>
Subject: [PATCH 14/18] hpsa: drop refcount field from CommandList
Date:   Mon,  3 May 2021 17:03:29 +0200
Message-Id: <20210503150333.130310-15-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210503150333.130310-1-hare@suse.de>
References: <20210503150333.130310-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Field is now unused, so drop it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Acked-by: Don Brace <don.brace@microchip.com>
Tested-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/hpsa.c     | 11 ++---------
 drivers/scsi/hpsa_cmd.h | 10 ----------
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 282338944a85..61f993704e23 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5533,8 +5533,8 @@ static void hpsa_cmd_init(struct ctlr_info *h, int index,
 {
 	dma_addr_t cmd_dma_handle, err_dma_handle;
 
-	/* Zero out all of commandlist except the last field, refcount */
-	memset(c, 0, offsetof(struct CommandList, refcount));
+	/* Zero out all of commandlist */
+	memset(c, 0, sizeof(struct CommandList));
 	c->Header.tag = cpu_to_le64((u64) (index << DIRECT_LOOKUP_SHIFT));
 	cmd_dma_handle = h->cmd_pool_dhandle + index * sizeof(*c);
 	c->err_info = h->errinfo_pool + index;
@@ -5556,7 +5556,6 @@ static void hpsa_preinitialize_commands(struct ctlr_info *h)
 		struct CommandList *c = h->cmd_pool + i;
 
 		hpsa_cmd_init(h, i, c);
-		atomic_set(&c->refcount, 0);
 	}
 }
 
@@ -6172,7 +6171,6 @@ static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 		return NULL;
 	}
 
-	atomic_inc(&c->refcount);
 	hpsa_cmd_partial_init(h, idx, c);
 
 	/*
@@ -6186,11 +6184,6 @@ static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 
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
index ba6a3aa8d954..04c92c94cc6c 100644
--- a/drivers/scsi/hpsa_cmd.h
+++ b/drivers/scsi/hpsa_cmd.h
@@ -454,18 +454,8 @@ struct CommandList {
 
 	bool retry_pending;
 	struct hpsa_scsi_dev_t *device;
-	atomic_t refcount; /* Must be last to avoid memset in hpsa_cmd_init() */
 } __aligned(COMMANDLIST_ALIGNMENT);
 
-/*
- * Make sure our embedded atomic variable is aligned. Otherwise we break atomic
- * operations on architectures that don't support unaligned atomics like IA64.
- *
- * The assert guards against reintroductin against unwanted __packed to
- * the struct CommandList.
- */
-static_assert(offsetof(struct CommandList, refcount) % __alignof__(atomic_t) == 0);
-
 /* Max S/G elements in I/O accelerator command */
 #define IOACCEL1_MAXSGENTRIES           24
 #define IOACCEL2_MAXSGENTRIES		28
-- 
2.29.2

