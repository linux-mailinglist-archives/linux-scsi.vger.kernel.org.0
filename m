Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD3110011F
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 10:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKRJWd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 04:22:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:54570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbfKRJWc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 04:22:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5674CB14A;
        Mon, 18 Nov 2019 09:22:30 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 9/9] scsi: Remove cmd_list functionality
Date:   Mon, 18 Nov 2019 10:22:08 +0100
Message-Id: <20191118092208.54521-10-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191118092208.54521-1-hare@suse.de>
References: <20191118092208.54521-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove cmd_list functionality; no users left.
With that the scsi_put_command() becomes empty,
so remove that one, too.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c        | 14 --------------
 drivers/scsi/scsi_error.c  |  1 -
 drivers/scsi/scsi_lib.c    | 31 -------------------------------
 drivers/scsi/scsi_priv.h   |  2 --
 drivers/scsi/scsi_scan.c   |  1 -
 include/scsi/scsi_cmnd.h   |  1 -
 include/scsi/scsi_device.h |  1 -
 include/scsi/scsi_host.h   |  2 --
 8 files changed, 53 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index adfe8b3693d5..ed533b6e1fd0 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -94,20 +94,6 @@ EXPORT_SYMBOL(scsi_logging_level);
 ASYNC_DOMAIN_EXCLUSIVE(scsi_sd_pm_domain);
 EXPORT_SYMBOL(scsi_sd_pm_domain);
 
-/**
- * scsi_put_command - Free a scsi command block
- * @cmd: command block to free
- *
- * Returns:	Nothing.
- *
- * Notes:	The command must not belong to any lists.
- */
-void scsi_put_command(struct scsi_cmnd *cmd)
-{
-	scsi_del_cmd_from_list(cmd);
-	BUG_ON(delayed_work_pending(&cmd->abort_work));
-}
-
 #ifdef CONFIG_SCSI_LOGGING
 void scsi_log_send(struct scsi_cmnd *cmd)
 {
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index ae2fa170f6ad..978be1602f71 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2412,7 +2412,6 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	wake_up(&shost->host_wait);
 	scsi_run_host_queues(shost);
 
-	scsi_put_command(scmd);
 	kfree(rq);
 
 out_put_autopm_host:
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2563b061f56b..893804e87e25 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -562,7 +562,6 @@ static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 {
 	scsi_mq_free_sgtables(cmd);
 	scsi_uninit_cmd(cmd);
-	scsi_del_cmd_from_list(cmd);
 }
 
 /* Returns false when no more bytes to process, true if there are more */
@@ -1098,35 +1097,6 @@ static void scsi_cleanup_rq(struct request *rq)
 	}
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
@@ -1160,7 +1130,6 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	if (in_flight)
 		__set_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 
-	scsi_add_cmd_to_list(cmd);
 }
 
 static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 3bff9f7aa684..5eab5da4efe7 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -84,8 +84,6 @@ int scsi_eh_get_sense(struct list_head *work_q,
 int scsi_noretry_cmd(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
-extern void scsi_add_cmd_to_list(struct scsi_cmnd *cmd);
-extern void scsi_del_cmd_from_list(struct scsi_cmnd *cmd);
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
 extern void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd);
 extern void scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
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
index a2849bb9cd19..80ac89e47b47 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -159,7 +159,6 @@ static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
 }
 
-extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
 
 extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 3ed836db5306..fd2aee1f59fc 100644
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
index 1293d9686115..ee43db94a479 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -627,8 +627,6 @@ struct Scsi_Host {
 	/* The controller does not support WRITE SAME */
 	unsigned no_write_same:1;
 
-	unsigned use_cmd_list:1;
-
 	/* Host responded with short (<36 bytes) INQUIRY result */
 	unsigned short_inquiry:1;
 
-- 
2.16.4

