Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310792DE27
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfE2N3Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:45598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfE2N3O (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9037B01C;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 24/24] scsi: drop scsi command list
Date:   Wed, 29 May 2019 15:29:01 +0200
Message-Id: <20190529132901.27645-25-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

No users left, kill it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi.c        |  1 -
 drivers/scsi/scsi_lib.c    | 32 --------------------------------
 drivers/scsi/scsi_scan.c   |  1 -
 include/scsi/scsi_cmnd.h   |  1 -
 include/scsi/scsi_device.h |  1 -
 include/scsi/scsi_host.h   |  2 --
 6 files changed, 38 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 8128165a46fa..8db1cba81363 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -104,7 +104,6 @@ EXPORT_SYMBOL(scsi_sd_pm_domain);
  */
 void scsi_put_command(struct scsi_cmnd *cmd)
 {
-	scsi_del_cmd_from_list(cmd);
 	BUG_ON(delayed_work_pending(&cmd->abort_work));
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index da850bf28065..761fbfcfae1f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -561,7 +561,6 @@ static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 {
 	scsi_mq_free_sgtables(cmd);
 	scsi_uninit_cmd(cmd);
-	scsi_del_cmd_from_list(cmd);
 }
 
 /* Returns false when no more bytes to process, true if there are more */
@@ -1085,35 +1084,6 @@ static void scsi_initialize_rq(struct request *rq)
 	cmd->retries = 0;
 }
 
-/* Add a command to the list used by the aacraid and dpt_i2o drivers */
-void scsi_add_cmd_to_list(struct scsi_cmnd *cmd)
-{
-	struct scsi_device *sdev = cmd->device;
-	struct Scsi_Host *shost = sdev->host;
-	unsigned long flags;
-
-	if (shost->use_cmd_list) {
-		spin_lock_irqsave(&sdev->list_lock, flags);
-		list_add_tail(&cmd->list, &sdev->cmd_list);
-		spin_unlock_irqrestore(&sdev->list_lock, flags);
-	}
-}
-
-/* Remove a command from the list used by the aacraid and dpt_i2o drivers */
-void scsi_del_cmd_from_list(struct scsi_cmnd *cmd)
-{
-	struct scsi_device *sdev = cmd->device;
-	struct Scsi_Host *shost = sdev->host;
-	unsigned long flags;
-
-	if (shost->use_cmd_list) {
-		spin_lock_irqsave(&sdev->list_lock, flags);
-		BUG_ON(list_empty(&cmd->list));
-		list_del_init(&cmd->list);
-		spin_unlock_irqrestore(&sdev->list_lock, flags);
-	}
-}
-
 /* Called after a request has been started. */
 void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 {
@@ -1142,8 +1112,6 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	INIT_DELAYED_WORK(&cmd->abort_work, scmd_eh_abort_handler);
 	cmd->jiffies_at_alloc = jiffies_at_alloc;
 	cmd->retries = retries;
-
-	scsi_add_cmd_to_list(cmd);
 }
 
 static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 058079f915f1..f2437a7570ce 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -236,7 +236,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	sdev->sdev_state = SDEV_CREATED;
 	INIT_LIST_HEAD(&sdev->siblings);
 	INIT_LIST_HEAD(&sdev->same_target_siblings);
-	INIT_LIST_HEAD(&sdev->cmd_list);
 	INIT_LIST_HEAD(&sdev->starved_entry);
 	INIT_LIST_HEAD(&sdev->event_list);
 	spin_lock_init(&sdev->list_lock);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 4a45704b28fe..dab164c908d6 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -66,7 +66,6 @@ struct scsi_pointer {
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
-	struct list_head list;  /* scsi_cmnd participates in queue lists */
 	struct list_head eh_entry; /* entry for the host eh_cmd_q */
 	struct delayed_work abort_work;
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 202f4d6a4342..9ef440c34c40 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -110,7 +110,6 @@ struct scsi_device {
 	atomic_t device_blocked;	/* Device returned QUEUE_FULL. */
 
 	spinlock_t list_lock;
-	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
 	struct list_head starved_entry;
 	unsigned short queue_depth;	/* How deep of a queue we want */
 	unsigned short max_queue_depth;	/* max queue depth */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a2bab5f07eff..9e8f9ccaf493 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -630,8 +630,6 @@ struct Scsi_Host {
 	/* The controller does not support WRITE SAME */
 	unsigned no_write_same:1;
 
-	unsigned use_cmd_list:1;
-
 	/* Host responded with short (<36 bytes) INQUIRY result */
 	unsigned short_inquiry:1;
 
-- 
2.16.4

