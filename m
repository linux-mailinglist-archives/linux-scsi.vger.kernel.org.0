Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2326320A083
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2020 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405328AbgFYOCC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jun 2020 10:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405308AbgFYOBx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Jun 2020 10:01:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 139BFAF82;
        Thu, 25 Jun 2020 14:01:46 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.de>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/22] hpsa: use scsi_host_busy_iter() to traverse outstanding commands
Date:   Thu, 25 Jun 2020 16:01:19 +0200
Message-Id: <20200625140124.17201-18-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200625140124.17201-1-hare@suse.de>
References: <20200625140124.17201-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace all hand-crafted command iterations with
scsi_host_busy_iter() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/hpsa.c | 117 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a3212d0e0dc2..6f0ef39471ce 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -1816,30 +1816,26 @@ static int hpsa_add_device(struct ctlr_info *h, struct hpsa_scsi_dev_t *device)
 	return rc;
 }
 
-static int hpsa_find_outstanding_commands_for_dev(struct ctlr_info *h,
-						struct hpsa_scsi_dev_t *dev)
-{
-	int i;
-	int count = 0;
-
-	for (i = 0; i < h->nr_cmds; i++) {
-		struct CommandList *c = h->cmd_pool + i;
-		int refcount = atomic_inc_return(&c->refcount);
-
-		if (refcount > 1 && hpsa_cmd_dev_match(h, c, dev,
-				dev->scsi3addr)) {
-			unsigned long flags;
+struct hpsa_command_iter_data {
+	struct ctlr_info *h;
+	struct hpsa_scsi_dev_t *dev;
+	unsigned char *scsi3addr;
+	int count;
+};
 
-			spin_lock_irqsave(&h->lock, flags);	/* Implied MB */
-			if (!hpsa_is_cmd_idle(c))
-				++count;
-			spin_unlock_irqrestore(&h->lock, flags);
-		}
+static bool hpsa_find_outstanding_commands_iter(struct scsi_cmnd *sc,
+						void *data, bool reserved)
+{
+	struct hpsa_command_iter_data *iter_data = data;
+	struct ctlr_info *h = iter_data->h;
+	struct hpsa_scsi_dev_t *dev = iter_data->dev;
+	struct CommandList *c = h->cmd_pool + sc->request->tag;
 
-		cmd_free(h, c);
+	if (hpsa_cmd_dev_match(h, c, dev, dev->scsi3addr)) {
+		iter_data->count++;
+		return false;
 	}
-
-	return count;
+	return true;
 }
 
 #define NUM_WAIT 20
@@ -1849,13 +1845,20 @@ static void hpsa_wait_for_outstanding_commands_for_dev(struct ctlr_info *h,
 	int cmds = 0;
 	int waits = 0;
 	int num_wait = NUM_WAIT;
+	struct hpsa_command_iter_data iter_data = {
+		.h = h,
+		.dev = device,
+	};
 
 	if (device->external)
 		num_wait = HPSA_EH_PTRAID_TIMEOUT;
 
 	while (1) {
-		cmds = hpsa_find_outstanding_commands_for_dev(h, device);
-		if (cmds == 0)
+		iter_data.count = 0;
+		scsi_host_busy_iter(h->scsi_host,
+				    hpsa_find_outstanding_commands_iter,
+				    &iter_data);
+		if (iter_data.count == 0)
 			break;
 		if (++waits > num_wait)
 			break;
@@ -8134,27 +8137,34 @@ static void hpsa_undo_allocations_after_kdump_soft_reset(struct ctlr_info *h)
 	kfree(h);				/* init_one 1 */
 }
 
+static bool fail_all_outstanding_cmds_iter(struct scsi_cmnd *sc, void *data,
+					   bool reserved)
+{
+	struct hpsa_command_iter_data *iter_data = data;
+	struct ctlr_info *h = iter_data->h;
+	struct CommandList *c = h->cmd_pool + sc->request->tag;
+
+	c->err_info->CommandStatus = CMD_CTLR_LOCKUP;
+	finish_cmd(c);
+	atomic_dec(&h->commands_outstanding);
+	iter_data->count++;
+
+	return true;
+}
+
 /* Called when controller lockup detected. */
 static void fail_all_outstanding_cmds(struct ctlr_info *h)
 {
-	int i, refcount;
-	struct CommandList *c;
-	int failcount = 0;
+	struct hpsa_command_iter_data iter_data = {
+		.h = h,
+		.count = 0,
+	};
 
 	flush_workqueue(h->resubmit_wq); /* ensure all cmds are fully built */
-	for (i = 0; i < h->nr_cmds; i++) {
-		c = h->cmd_pool + i;
-		refcount = atomic_inc_return(&c->refcount);
-		if (refcount > 1) {
-			c->err_info->CommandStatus = CMD_CTLR_LOCKUP;
-			finish_cmd(c);
-			atomic_dec(&h->commands_outstanding);
-			failcount++;
-		}
-		cmd_free(h, c);
-	}
+	scsi_host_busy_iter(h->scsi_host,
+			    fail_all_outstanding_cmds_iter, &iter_data);
 	dev_warn(&h->pdev->dev,
-		"failed %d commands in fail_all\n", failcount);
+		"failed %d commands in fail_all\n", iter_data.count);
 }
 
 static void set_lockup_detected_for_all_cpus(struct ctlr_info *h, u32 value)
@@ -9454,22 +9464,29 @@ static int is_accelerated_cmd(struct CommandList *c)
 	return c->cmd_type == CMD_IOACCEL1 || c->cmd_type == CMD_IOACCEL2;
 }
 
+static bool hpsa_drain_accel_commands_iter(struct scsi_cmnd *sc, void *data,
+					   bool reserved)
+{
+	struct hpsa_command_iter_data *iter_data = data;
+	struct ctlr_info *h = iter_data->h;
+	struct CommandList *c = h->cmd_pool + sc->request->tag;
+
+	iter_data->count += is_accelerated_cmd(c);
+	return true;
+}
+
 static void hpsa_drain_accel_commands(struct ctlr_info *h)
 {
-	struct CommandList *c = NULL;
-	int i, accel_cmds_out;
-	int refcount;
+	struct hpsa_command_iter_data iter_data = {
+		.h = h,
+	};
 
 	do { /* wait for all outstanding ioaccel commands to drain out */
-		accel_cmds_out = 0;
-		for (i = 0; i < h->nr_cmds; i++) {
-			c = h->cmd_pool + i;
-			refcount = atomic_inc_return(&c->refcount);
-			if (refcount > 1) /* Command is allocated */
-				accel_cmds_out += is_accelerated_cmd(c);
-			cmd_free(h, c);
-		}
-		if (accel_cmds_out <= 0)
+		iter_data.count = 0;
+		scsi_host_busy_iter(h->scsi_host,
+				    hpsa_drain_accel_commands_iter,
+				    &iter_data);
+		if (iter_data.count <= 0)
 			break;
 		msleep(100);
 	} while (1);
-- 
2.16.4

