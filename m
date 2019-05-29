Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F982DE2E
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfE2N3S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbfE2N3N (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0CB7B010;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 20/24] aacraid: use private commands
Date:   Wed, 29 May 2019 15:28:57 +0200
Message-Id: <20190529132901.27645-21-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Use private commands to allocate internal commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aacraid/aacraid.h |  6 ++++--
 drivers/scsi/aacraid/commsup.c | 47 +++++++++++++++---------------------------
 drivers/scsi/aacraid/linit.c   |  3 +++
 3 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 11fb68d7e60d..4b187b4099ed 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1303,13 +1303,16 @@ struct fsa_dev_info {
 };
 
 struct fib {
-	void			*next;	/* this is used by the allocator */
 	s16			type;
 	s16			size;
 	/*
 	 *	The Adapter that this I/O is destined for.
 	 */
 	struct aac_dev		*dev;
+	/*
+	 * The associated scsi command
+	 */
+	struct scsi_cmnd 	*scmd;
 	/*
 	 *	This is the event the sendfib routine will wait on if the
 	 *	caller did not pass one and this is synch io.
@@ -1564,7 +1567,6 @@ struct aac_dev
 	 */
 	struct fib              *fibs;
 
-	struct fib		*free_fib;
 	spinlock_t		fib_lock;
 
 	struct mutex		ioctl_mutex;
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 78430a7b294c..271934adf6d1 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -49,6 +49,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_tcq.h>
 
 #include "aacraid.h"
 
@@ -187,7 +188,6 @@ int aac_fib_setup(struct aac_dev * dev)
 		fibptr->dev = dev;
 		fibptr->hw_fib_va = hw_fib;
 		fibptr->data = (void *) fibptr->hw_fib_va->data;
-		fibptr->next = fibptr+1;	/* Forward chain the fibs */
 		init_completion(&fibptr->event_wait);
 		spin_lock_init(&fibptr->event_lock);
 		hw_fib->header.XferState = cpu_to_le32(0xffffffff);
@@ -214,14 +214,6 @@ int aac_fib_setup(struct aac_dev * dev)
 	 */
 	aac_fib_vector_assign(dev);
 
-	/*
-	 *	Add the fib chain to the free list
-	 */
-	dev->fibs[dev->scsi_host_ptr->can_queue + AAC_NUM_MGT_FIB - 1].next = NULL;
-	/*
-	*	Set 8 fibs aside for management tools
-	*/
-	dev->free_fib = &dev->fibs[dev->scsi_host_ptr->can_queue];
 	return 0;
 }
 
@@ -246,6 +238,7 @@ struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 	fibptr->type = FSAFS_NTC_FIB_CONTEXT;
 	fibptr->callback_data = NULL;
 	fibptr->callback = NULL;
+	fibptr->scmd = scmd;
 
 	return fibptr;
 }
@@ -260,29 +253,19 @@ struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 
 struct fib *aac_fib_alloc(struct aac_dev *dev)
 {
-	struct fib * fibptr;
+	struct scsi_cmnd *scmd;
+	struct fib * fibptr = NULL;
 	unsigned long flags;
+
 	spin_lock_irqsave(&dev->fib_lock, flags);
-	fibptr = dev->free_fib;
-	if(!fibptr){
-		spin_unlock_irqrestore(&dev->fib_lock, flags);
-		return fibptr;
-	}
-	dev->free_fib = fibptr->next;
+	scmd = scsi_host_get_reserved_cmd(dev->scsi_host_ptr);
+	if (scmd)
+		fibptr = aac_fib_alloc_tag(dev, scmd);
 	spin_unlock_irqrestore(&dev->fib_lock, flags);
-	/*
-	 *	Set the proper node type code and node byte size
-	 */
-	fibptr->type = FSAFS_NTC_FIB_CONTEXT;
+	if (!fibptr)
+		return NULL;
+
 	fibptr->size = sizeof(struct fib);
-	/*
-	 *	Null out fields that depend on being zero at the start of
-	 *	each I/O
-	 */
-	fibptr->hw_fib_va->header.XferState = 0;
-	fibptr->flags = 0;
-	fibptr->callback = NULL;
-	fibptr->callback_data = NULL;
 
 	return fibptr;
 }
@@ -310,8 +293,12 @@ void aac_fib_free(struct fib *fibptr)
 			 (void*)fibptr,
 			 le32_to_cpu(fibptr->hw_fib_va->header.XferState));
 	}
-	fibptr->next = fibptr->dev->free_fib;
-	fibptr->dev->free_fib = fibptr;
+	if (fibptr->scmd) {
+		struct scsi_cmnd *scmd = fibptr->scmd;
+
+		fibptr->scmd = NULL;
+		scsi_put_reserved_cmd(scmd);
+	}
 	spin_unlock_irqrestore(&fibptr->dev->fib_lock, flags);
 }
 
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 71d97881fc26..30357bf0f3e8 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1671,8 +1671,11 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->use_cmd_list = 1;
 	shost->max_id = MAXIMUM_NUM_CONTAINERS;
 	shost->max_lun = AAC_MAX_LUN;
+	shost->nr_reserved_cmds = AAC_NUM_MGT_FIB;
+	shost->use_reserved_cmd_q = true;
 	shost->sg_tablesize = HBA_MAX_SG_SEPARATE;
 
+
 	if (aac_cfg_major == AAC_CHARDEV_NEEDS_REINIT)
 		aac_init_char();
 
-- 
2.16.4

