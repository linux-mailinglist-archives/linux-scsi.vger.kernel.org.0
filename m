Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429F0EC19F
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Nov 2019 12:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfKALSp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Nov 2019 07:18:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:34756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730253AbfKALSo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 Nov 2019 07:18:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 107AAB2D2;
        Fri,  1 Nov 2019 11:18:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/4] aacraid: use blk_mq_rq_busy_iter() for traversing outstanding commands
Date:   Fri,  1 Nov 2019 12:18:37 +0100
Message-Id: <20191101111838.140027-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191101111838.140027-1-hare@suse.de>
References: <20191101111838.140027-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use blk_mq_rq_busy_iter() for traversing outstanding commands and
drop the cmd_list usage.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aacraid/aachba.c   | 127 ++++++++++++++++++++++------------------
 drivers/scsi/aacraid/comminit.c |  30 ++++------
 drivers/scsi/aacraid/commsup.c  |  38 +++++-------
 drivers/scsi/aacraid/linit.c    |  87 ++++++++++++++-------------
 4 files changed, 147 insertions(+), 135 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index e36608ce937a..df590240e2c9 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -2639,81 +2639,96 @@ static void synchronize_callback(void *context, struct fib *fibptr)
 	cmd->scsi_done(cmd);
 }
 
+struct synchronize_busy_data {
+	struct scsi_device *sdev;
+	u64 lba;
+	u32 count;
+	int active;
+};
+
+static bool synchronize_busy_iter(struct request *req, void *data, bool reserved)
+{
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
+	struct synchronize_busy_data *busy_data = data;
+
+	if (busy_data->sdev == cmd->device &&
+	    cmd->SCp.phase == AAC_OWNER_FIRMWARE) {
+		u64 cmnd_lba;
+		u32 cmnd_count;
+
+		if (cmd->cmnd[0] == WRITE_6) {
+			cmnd_lba = ((cmd->cmnd[1] & 0x1F) << 16) |
+				(cmd->cmnd[2] << 8) |
+				cmd->cmnd[3];
+			cmnd_count = cmd->cmnd[4];
+			if (cmnd_count == 0)
+				cmnd_count = 256;
+		} else if (cmd->cmnd[0] == WRITE_16) {
+			cmnd_lba = ((u64)cmd->cmnd[2] << 56) |
+				((u64)cmd->cmnd[3] << 48) |
+				((u64)cmd->cmnd[4] << 40) |
+				((u64)cmd->cmnd[5] << 32) |
+				((u64)cmd->cmnd[6] << 24) |
+				(cmd->cmnd[7] << 16) |
+				(cmd->cmnd[8] << 8) |
+				cmd->cmnd[9];
+			cmnd_count = (cmd->cmnd[10] << 24) |
+				(cmd->cmnd[11] << 16) |
+				(cmd->cmnd[12] << 8) |
+				cmd->cmnd[13];
+		} else if (cmd->cmnd[0] == WRITE_12) {
+			cmnd_lba = ((u64)cmd->cmnd[2] << 24) |
+				(cmd->cmnd[3] << 16) |
+				(cmd->cmnd[4] << 8) |
+				cmd->cmnd[5];
+			cmnd_count = (cmd->cmnd[6] << 24) |
+				(cmd->cmnd[7] << 16) |
+				(cmd->cmnd[8] << 8) |
+				cmd->cmnd[9];
+		} else if (cmd->cmnd[0] == WRITE_10) {
+			cmnd_lba = ((u64)cmd->cmnd[2] << 24) |
+				(cmd->cmnd[3] << 16) |
+				(cmd->cmnd[4] << 8) |
+				cmd->cmnd[5];
+			cmnd_count = (cmd->cmnd[7] << 8) |
+				cmd->cmnd[8];
+		} else
+			return true;
+		if (((cmnd_lba + cmnd_count) < busy_data->lba) ||
+		    (busy_data->count && ((busy_data->lba + busy_data->count) < cmnd_lba)))
+			return true;;
+		++busy_data->active;
+	}
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
-	int active = 0;
 	struct aac_dev *aac;
 	u64 lba = ((u64)scsicmd->cmnd[2] << 24) | (scsicmd->cmnd[3] << 16) |
 		(scsicmd->cmnd[4] << 8) | scsicmd->cmnd[5];
 	u32 count = (scsicmd->cmnd[7] << 8) | scsicmd->cmnd[8];
-	unsigned long flags;
+	struct synchronize_busy_data busy_data = {
+		.sdev = sdev,
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
+	blk_mq_tagset_busy_iter(&sdev->host->tag_set, synchronize_busy_iter, &busy_data);
 
 	/*
 	 *	Yield the processor (requeue for later)
 	 */
-	if (active)
+	if (busy_data.active)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 
 	aac = (struct aac_dev *)sdev->host->hostdata;
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index f75878d773cf..72cdf47437fe 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -272,29 +272,25 @@ static void aac_queue_init(struct aac_dev * dev, struct aac_queue * q, u32 *mem,
 	q->entries = qsize;
 }
 
+static bool wait_for_io_iter(struct request *rq, void *data, bool reserved)
+{
+	struct scsi_cmnd *command = blk_mq_rq_to_pdu(rq);
+	int *active = data;
+
+	if (command->SCp.phase == AAC_OWNER_FIRMWARE)
+		*active = 1;
+	return true;
+}
+
 static void aac_wait_for_io_completion(struct aac_dev *aac)
 {
-	unsigned long flagv = 0;
-	int i = 0;
+	int i;
 
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
-
-		}
+		blk_mq_tagset_busy_iter(&aac->scsi_host_ptr->tag_set,
+					wait_for_io_iter, &active);
 		/*
 		 * We can exit If all the commands are complete
 		 */
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 5a8a999606ea..218b0954b91c 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1472,14 +1472,26 @@ static void aac_schedule_bus_scan(struct aac_dev *aac)
 		aac_schedule_src_reinit_aif_worker(aac);
 }
 
+static bool reset_adapter_complete_iter(struct request *rq, void *data, bool reserved)
+{
+	struct scsi_cmnd *command = blk_mq_rq_to_pdu(rq);
+
+	if (command->SCp.phase == AAC_OWNER_FIRMWARE) {
+		command->result = DID_OK << 16
+		  | COMMAND_COMPLETE << 8
+		  | SAM_STAT_TASK_SET_FULL;
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
@@ -1607,26 +1619,8 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
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
+	blk_mq_tagset_busy_iter(&host->tag_set, reset_adapter_complete_iter, NULL);
+
 	/*
 	 * Any Device that was already marked offline needs to be marked
 	 * running
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index ee6bc2f9b80a..30af9eef6774 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -622,54 +622,62 @@ static int aac_ioctl(struct scsi_device *sdev, unsigned int cmd,
 	return aac_do_ioctl(dev, cmd, arg);
 }
 
-static int get_num_of_incomplete_fibs(struct aac_dev *aac)
+struct fib_count_data {
+	int mlcnt;
+	int llcnt;
+	int ehcnt;
+	int fwcnt;
+	int krlcnt;
+};
+
+static bool fib_count_iter(struct request *rq, void *data, bool reserved)
 {
+	struct scsi_cmnd *scmnd = blk_mq_rq_to_pdu(rq);
+	struct fib_count_data *fib_count = data;
 
-	unsigned long flags;
-	struct scsi_device *sdev = NULL;
+	switch (scmnd->SCp.phase) {
+	case AAC_OWNER_FIRMWARE:
+		fib_count->fwcnt++;
+		break;
+	case AAC_OWNER_ERROR_HANDLER:
+		fib_count->ehcnt++;
+		break;
+	case AAC_OWNER_LOWLEVEL:
+		fib_count->llcnt++;
+		break;
+	case AAC_OWNER_MIDLEVEL:
+		fib_count->mlcnt++;
+		break;
+	default:
+		fib_count->krlcnt++;
+		break;
+	}
+	return true;
+}
+
+static int get_num_of_incomplete_fibs(struct aac_dev *aac)
+{
 	struct Scsi_Host *shost = aac->scsi_host_ptr;
-	struct scsi_cmnd *scmnd = NULL;
 	struct device *ctrl_dev;
+	struct fib_count_data fib_count = {
+		.mlcnt  = 0,
+		.llcnt  = 0,
+		.ehcnt  = 0,
+		.fwcnt  = 0,
+		.krlcnt = 0,
+	};
 
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
+	blk_mq_tagset_busy_iter(&shost->tag_set, fib_count_iter, &fib_count);
 
 	ctrl_dev = &aac->pdev->dev;
 
-	dev_info(ctrl_dev, "outstanding cmd: midlevel-%d\n", mlcnt);
-	dev_info(ctrl_dev, "outstanding cmd: lowlevel-%d\n", llcnt);
-	dev_info(ctrl_dev, "outstanding cmd: error handler-%d\n", ehcnt);
-	dev_info(ctrl_dev, "outstanding cmd: firmware-%d\n", fwcnt);
-	dev_info(ctrl_dev, "outstanding cmd: kernel-%d\n", krlcnt);
+	dev_info(ctrl_dev, "outstanding cmd: midlevel-%d\n", fib_count.mlcnt);
+	dev_info(ctrl_dev, "outstanding cmd: lowlevel-%d\n", fib_count.llcnt);
+	dev_info(ctrl_dev, "outstanding cmd: error handler-%d\n", fib_count.ehcnt);
+	dev_info(ctrl_dev, "outstanding cmd: firmware-%d\n", fib_count.fwcnt);
+	dev_info(ctrl_dev, "outstanding cmd: kernel-%d\n", fib_count.krlcnt);
 
-	return mlcnt + llcnt + ehcnt + fwcnt;
+	return fib_count.mlcnt + fib_count.llcnt + fib_count.ehcnt + fib_count.fwcnt;
 }
 
 static int aac_eh_abort(struct scsi_cmnd* cmd)
@@ -1675,7 +1683,6 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->irq = pdev->irq;
 	shost->unique_id = unique_id;
 	shost->max_cmd_len = 16;
-	shost->use_cmd_list = 1;
 
 	if (aac_cfg_major == AAC_CHARDEV_NEEDS_REINIT)
 		aac_init_char();
-- 
2.16.4

