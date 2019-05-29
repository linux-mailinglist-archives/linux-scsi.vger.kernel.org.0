Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46362DE28
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfE2N3P (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727179AbfE2N3O (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAEDFB014;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 21/24] aacraid: replace cmd_list with scsi_host_tagset_busy_iter()
Date:   Wed, 29 May 2019 15:28:58 +0200
Message-Id: <20190529132901.27645-22-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

As we're now using a common pool for handlng requests we can use
scsi_host_tagset_iter() to traverse commands and can drop the
legacy cmd_list usage.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aacraid/aachba.c   | 125 ++++++++++++++++++++++------------------
 drivers/scsi/aacraid/comminit.c |  28 +++++----
 drivers/scsi/aacraid/commsup.c  |  38 +++++-------
 drivers/scsi/aacraid/linit.c    |  98 ++++++++++++++++---------------
 4 files changed, 152 insertions(+), 137 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 6085aa087a2f..fd83247db441 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -823,7 +823,6 @@ int aac_probe_container(struct aac_dev *dev, int cid)
 		kfree(scsidev);
 		return -ENOMEM;
 	}
-	scsicmd->list.next = NULL;
 	scsicmd->scsi_done = (void (*)(struct scsi_cmnd*))aac_probe_container_callback1;
 
 	scsicmd->device = scsidev;
@@ -2652,76 +2651,92 @@ static void synchronize_callback(void *context, struct fib *fibptr)
 	cmd->scsi_done(cmd);
 }
 
+struct aac_synchronize_iter_data {
+	u64 lba;
+	u32 count;
+	int active;
+};
+
+static bool aac_synchronize_iter(struct scsi_cmnd *cmd, void *data,
+				 bool reserved)
+{
+	struct aac_synchronize_iter_data *iter_data = data;
+	u64 cmnd_lba;
+	u32 cmnd_count;
+
+	if (cmd->SCp.phase != AAC_OWNER_FIRMWARE || reserved)
+		return true;
+
+	if (cmd->cmnd[0] == WRITE_6) {
+		cmnd_lba = ((cmd->cmnd[1] & 0x1F) << 16) |
+			(cmd->cmnd[2] << 8) |
+			cmd->cmnd[3];
+		cmnd_count = cmd->cmnd[4];
+		if (cmnd_count == 0)
+			cmnd_count = 256;
+	} else if (cmd->cmnd[0] == WRITE_16) {
+		cmnd_lba = ((u64)cmd->cmnd[2] << 56) |
+			((u64)cmd->cmnd[3] << 48) |
+			((u64)cmd->cmnd[4] << 40) |
+			((u64)cmd->cmnd[5] << 32) |
+			((u64)cmd->cmnd[6] << 24) |
+			(cmd->cmnd[7] << 16) |
+			(cmd->cmnd[8] << 8) |
+			cmd->cmnd[9];
+		cmnd_count = (cmd->cmnd[10] << 24) |
+			(cmd->cmnd[11] << 16) |
+			(cmd->cmnd[12] << 8) |
+			cmd->cmnd[13];
+	} else if (cmd->cmnd[0] == WRITE_12) {
+		cmnd_lba = ((u64)cmd->cmnd[2] << 24) |
+			(cmd->cmnd[3] << 16) |
+			(cmd->cmnd[4] << 8) |
+			cmd->cmnd[5];
+		cmnd_count = (cmd->cmnd[6] << 24) |
+			(cmd->cmnd[7] << 16) |
+			(cmd->cmnd[8] << 8) |
+			cmd->cmnd[9];
+	} else if (cmd->cmnd[0] == WRITE_10) {
+		cmnd_lba = ((u64)cmd->cmnd[2] << 24) |
+			(cmd->cmnd[3] << 16) |
+			(cmd->cmnd[4] << 8) |
+			cmd->cmnd[5];
+		cmnd_count = (cmd->cmnd[7] << 8) |
+			cmd->cmnd[8];
+	} else
+		return true;
+
+	if (((cmnd_lba + cmnd_count) < iter_data->lba) ||
+	    (iter_data->count && ((iter_data->lba + iter_data->count) < cmnd_lba)))
+		return true;
+
+	++iter_data->active;
+	return true;
+}
+
 static int aac_synchronize(struct scsi_cmnd *scsicmd)
 {
 	int status;
 	struct fib *cmd_fibcontext;
 	struct aac_synchronize *synchronizecmd;
-	struct scsi_cmnd *cmd;
 	struct scsi_device *sdev = scsicmd->device;
 	int active = 0;
 	struct aac_dev *aac;
 	u64 lba = ((u64)scsicmd->cmnd[2] << 24) | (scsicmd->cmnd[3] << 16) |
 		(scsicmd->cmnd[4] << 8) | scsicmd->cmnd[5];
 	u32 count = (scsicmd->cmnd[7] << 8) | scsicmd->cmnd[8];
-	unsigned long flags;
+	struct aac_synchronize_iter_data iter_data = {
+		.lba = lba,
+		.count = count,
+		.active = 0,
+	};
 
 	/*
 	 * Wait for all outstanding queued commands to complete to this
 	 * specific target (block).
 	 */
-	spin_lock_irqsave(&sdev->list_lock, flags);
-	list_for_each_entry(cmd, &sdev->cmd_list, list)
-		if (cmd->SCp.phase == AAC_OWNER_FIRMWARE) {
-			u64 cmnd_lba;
-			u32 cmnd_count;
-
-			if (cmd->cmnd[0] == WRITE_6) {
-				cmnd_lba = ((cmd->cmnd[1] & 0x1F) << 16) |
-					(cmd->cmnd[2] << 8) |
-					cmd->cmnd[3];
-				cmnd_count = cmd->cmnd[4];
-				if (cmnd_count == 0)
-					cmnd_count = 256;
-			} else if (cmd->cmnd[0] == WRITE_16) {
-				cmnd_lba = ((u64)cmd->cmnd[2] << 56) |
-					((u64)cmd->cmnd[3] << 48) |
-					((u64)cmd->cmnd[4] << 40) |
-					((u64)cmd->cmnd[5] << 32) |
-					((u64)cmd->cmnd[6] << 24) |
-					(cmd->cmnd[7] << 16) |
-					(cmd->cmnd[8] << 8) |
-					cmd->cmnd[9];
-				cmnd_count = (cmd->cmnd[10] << 24) |
-					(cmd->cmnd[11] << 16) |
-					(cmd->cmnd[12] << 8) |
-					cmd->cmnd[13];
-			} else if (cmd->cmnd[0] == WRITE_12) {
-				cmnd_lba = ((u64)cmd->cmnd[2] << 24) |
-					(cmd->cmnd[3] << 16) |
-					(cmd->cmnd[4] << 8) |
-					cmd->cmnd[5];
-				cmnd_count = (cmd->cmnd[6] << 24) |
-					(cmd->cmnd[7] << 16) |
-					(cmd->cmnd[8] << 8) |
-					cmd->cmnd[9];
-			} else if (cmd->cmnd[0] == WRITE_10) {
-				cmnd_lba = ((u64)cmd->cmnd[2] << 24) |
-					(cmd->cmnd[3] << 16) |
-					(cmd->cmnd[4] << 8) |
-					cmd->cmnd[5];
-				cmnd_count = (cmd->cmnd[7] << 8) |
-					cmd->cmnd[8];
-			} else
-				continue;
-			if (((cmnd_lba + cmnd_count) < lba) ||
-			  (count && ((lba + count) < cmnd_lba)))
-				continue;
-			++active;
-			break;
-		}
-
-	spin_unlock_irqrestore(&sdev->list_lock, flags);
+	scsi_host_tagset_busy_iter(sdev->host, aac_synchronize_iter,
+				   &iter_data);
 
 	/*
 	 *	Yield the processor (requeue for later)
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 0dc7b5a4fea2..2413161d844f 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -286,29 +286,27 @@ static void aac_queue_init(struct aac_dev * dev, struct aac_queue * q, u32 *mem,
 	q->entries = qsize;
 }
 
+static bool aac_io_completion_iter(struct scsi_cmnd *command, void *data,
+				   bool reserved)
+{
+	int *active = data;
+
+	if (!reserved && command->SCp.phase == AAC_OWNER_FIRMWARE)
+		(*active)++;
+	return true;
+}
+
 static void aac_wait_for_io_completion(struct aac_dev *aac)
 {
-	unsigned long flagv = 0;
 	int i = 0;
+	struct Scsi_Host *shost = aac->scsi_host_ptr;
 
 	for (i = 60; i; --i) {
-		struct scsi_device *dev;
-		struct scsi_cmnd *command;
 		int active = 0;
 
-		__shost_for_each_device(dev, aac->scsi_host_ptr) {
-			spin_lock_irqsave(&dev->list_lock, flagv);
-			list_for_each_entry(command, &dev->cmd_list, list) {
-				if (command->SCp.phase == AAC_OWNER_FIRMWARE) {
-					active++;
-					break;
-				}
-			}
-			spin_unlock_irqrestore(&dev->list_lock, flagv);
-			if (active)
-				break;
+		scsi_host_tagset_busy_iter(shost, aac_io_completion_iter,
+					   &active);
 
-		}
 		/*
 		 * We can exit If all the commands are complete
 		 */
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 271934adf6d1..1ae003e5c2d6 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1464,14 +1464,26 @@ static void aac_handle_aif(struct aac_dev * dev, struct fib * fibptr)
 	}
 }
 
+static bool aac_reset_adapter_iter(struct scsi_cmnd *command, void *data,
+				   bool reserved)
+{
+	if (!reserved && command->SCp.phase == AAC_OWNER_FIRMWARE) {
+		command->SCp.buffer = NULL;
+		command->result = DID_OK << 16
+			| COMMAND_COMPLETE << 8
+			| SAM_STAT_TASK_SET_FULL;
+		command->SCp.phase = AAC_OWNER_ERROR_HANDLER;
+		command->scsi_done(command);
+	}
+	return true;
+}
+
 static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 {
 	int index, quirks;
 	int retval;
 	struct Scsi_Host *host;
 	struct scsi_device *dev;
-	struct scsi_cmnd *command;
-	struct scsi_cmnd *command_list;
 	int jafo = 0;
 	int bled;
 	u64 dmamask;
@@ -1599,26 +1611,8 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 	 * This is where the assumption that the Adapter is quiesced
 	 * is important.
 	 */
-	command_list = NULL;
-	__shost_for_each_device(dev, host) {
-		unsigned long flags;
-		spin_lock_irqsave(&dev->list_lock, flags);
-		list_for_each_entry(command, &dev->cmd_list, list)
-			if (command->SCp.phase == AAC_OWNER_FIRMWARE) {
-				command->SCp.buffer = (struct scatterlist *)command_list;
-				command_list = command;
-			}
-		spin_unlock_irqrestore(&dev->list_lock, flags);
-	}
-	while ((command = command_list)) {
-		command_list = (struct scsi_cmnd *)command->SCp.buffer;
-		command->SCp.buffer = NULL;
-		command->result = DID_OK << 16
-		  | COMMAND_COMPLETE << 8
-		  | SAM_STAT_TASK_SET_FULL;
-		command->SCp.phase = AAC_OWNER_ERROR_HANDLER;
-		command->scsi_done(command);
-	}
+	scsi_host_tagset_busy_iter(host, aac_reset_adapter_iter, NULL);
+
 	/*
 	 * Any Device that was already marked offline needs to be marked
 	 * running
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 30357bf0f3e8..81b9a3f39d79 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -628,54 +628,63 @@ static int aac_ioctl(struct scsi_device *sdev, unsigned int cmd,
 	return aac_do_ioctl(dev, cmd, arg);
 }
 
-static int get_num_of_incomplete_fibs(struct aac_dev *aac)
-{
+struct incomplete_fib_iter_data {
+	int fwcnt;
+	int ehcnt;
+	int llcnt;
+	int mlcnt;
+	int krlcnt;
+};
 
-	unsigned long flags;
-	struct scsi_device *sdev = NULL;
-	struct Scsi_Host *shost = aac->scsi_host_ptr;
-	struct scsi_cmnd *scmnd = NULL;
-	struct device *ctrl_dev;
-
-	int mlcnt  = 0;
-	int llcnt  = 0;
-	int ehcnt  = 0;
-	int fwcnt  = 0;
-	int krlcnt = 0;
-
-	__shost_for_each_device(sdev, shost) {
-		spin_lock_irqsave(&sdev->list_lock, flags);
-		list_for_each_entry(scmnd, &sdev->cmd_list, list) {
-			switch (scmnd->SCp.phase) {
-			case AAC_OWNER_FIRMWARE:
-				fwcnt++;
-				break;
-			case AAC_OWNER_ERROR_HANDLER:
-				ehcnt++;
-				break;
-			case AAC_OWNER_LOWLEVEL:
-				llcnt++;
-				break;
-			case AAC_OWNER_MIDLEVEL:
-				mlcnt++;
-				break;
-			default:
-				krlcnt++;
-				break;
-			}
-		}
-		spin_unlock_irqrestore(&sdev->list_lock, flags);
-	}
+static bool aac_incomplete_fib_iter(struct scsi_cmnd *scmd, void *data,
+				    bool reserved)
+{
+	struct incomplete_fib_iter_data *iter_data = data;
 
-	ctrl_dev = &aac->pdev->dev;
+	if (reserved)
+		return true;
 
-	dev_info(ctrl_dev, "outstanding cmd: midlevel-%d\n", mlcnt);
-	dev_info(ctrl_dev, "outstanding cmd: lowlevel-%d\n", llcnt);
-	dev_info(ctrl_dev, "outstanding cmd: error handler-%d\n", ehcnt);
-	dev_info(ctrl_dev, "outstanding cmd: firmware-%d\n", fwcnt);
-	dev_info(ctrl_dev, "outstanding cmd: kernel-%d\n", krlcnt);
+	switch (scmd->SCp.phase) {
+	case AAC_OWNER_FIRMWARE:
+		iter_data->fwcnt++;
+		break;
+	case AAC_OWNER_ERROR_HANDLER:
+		iter_data->ehcnt++;
+		break;
+	case AAC_OWNER_LOWLEVEL:
+		iter_data->llcnt++;
+		break;
+	case AAC_OWNER_MIDLEVEL:
+		iter_data->mlcnt++;
+		break;
+	default:
+		iter_data->krlcnt++;
+		break;
+	}
+	return true;
+}
 
-	return mlcnt + llcnt + ehcnt + fwcnt;
+static int get_num_of_incomplete_fibs(struct aac_dev *aac)
+{
+	struct Scsi_Host *shost = aac->scsi_host_ptr;
+	struct device *ctrl_dev = &aac->pdev->dev;
+	struct incomplete_fib_iter_data iter_data = {
+		.mlcnt  = 0,
+		.llcnt  = 0,
+		.ehcnt  = 0,
+		.fwcnt  = 0,
+		.krlcnt = 0,
+	};
+
+	scsi_host_tagset_busy_iter(shost, aac_incomplete_fib_iter, &iter_data);
+
+	dev_info(ctrl_dev, "outstanding cmd: midlevel-%d\n", iter_data.mlcnt);
+	dev_info(ctrl_dev, "outstanding cmd: lowlevel-%d\n", iter_data.llcnt);
+	dev_info(ctrl_dev, "outstanding cmd: error handler-%d\n", iter_data.ehcnt);
+	dev_info(ctrl_dev, "outstanding cmd: firmware-%d\n", iter_data.fwcnt);
+	dev_info(ctrl_dev, "outstanding cmd: kernel-%d\n", iter_data.krlcnt);
+
+	return iter_data.mlcnt + iter_data.llcnt + iter_data.ehcnt + iter_data.fwcnt;
 }
 
 static int aac_eh_abort(struct scsi_cmnd* cmd)
@@ -1668,7 +1677,6 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->irq = pdev->irq;
 	shost->unique_id = unique_id;
 	shost->max_cmd_len = 16;
-	shost->use_cmd_list = 1;
 	shost->max_id = MAXIMUM_NUM_CONTAINERS;
 	shost->max_lun = AAC_MAX_LUN;
 	shost->nr_reserved_cmds = AAC_NUM_MGT_FIB;
-- 
2.16.4

