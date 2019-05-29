Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88C42DE2C
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfE2N3R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727160AbfE2N3N (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD1D1B018;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 22/24] aacraid: use scsi_host_tagset_busy_iter() to traverse outstanding commands
Date:   Wed, 29 May 2019 15:28:59 +0200
Message-Id: <20190529132901.27645-23-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of walking the array of potential commands and trying to figure out
which one might be pending the driver should be using
scsi_host_tagset_busy_iter() to traverse all outstanding commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aacraid/commsup.c |  49 ++++++-----
 drivers/scsi/aacraid/linit.c   | 188 +++++++++++++++++++++++++----------------
 2 files changed, 142 insertions(+), 95 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 1ae003e5c2d6..c6f303d198cd 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1464,6 +1464,32 @@ static void aac_handle_aif(struct aac_dev * dev, struct fib * fibptr)
 	}
 }
 
+static bool aac_close_sync_fib_iter(struct scsi_cmnd *command, void *data,
+				    bool reserved)
+{
+	struct Scsi_Host *host = command->device->host;
+	struct aac_dev *aac = (struct aac_dev *)host->hostdata;
+	struct fib *fib = &aac->fibs[command->request->tag];
+	int *retval = data;
+	__le32 XferState = fib->hw_fib_va->header.XferState;
+	bool is_response_expected = false;
+
+	if (!(XferState & cpu_to_le32(NoResponseExpected | Async)) &&
+	    (XferState & cpu_to_le32(ResponseExpected)))
+		is_response_expected = true;
+
+	if (is_response_expected
+	    || fib->flags & FIB_CONTEXT_FLAG_WAIT) {
+		unsigned long flagv;
+		spin_lock_irqsave(&fib->event_lock, flagv);
+		complete(&fib->event_wait);
+		spin_unlock_irqrestore(&fib->event_lock, flagv);
+		schedule();
+		*retval = 0;
+	}
+	return true;
+}
+
 static bool aac_reset_adapter_iter(struct scsi_cmnd *command, void *data,
 				   bool reserved)
 {
@@ -1487,7 +1513,6 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 	int jafo = 0;
 	int bled;
 	u64 dmamask;
-	int num_of_fibs = 0;
 
 	/*
 	 * Assumptions:
@@ -1523,27 +1548,7 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 	 *	Loop through the fibs, close the synchronous FIBS
 	 */
 	retval = 1;
-	num_of_fibs = aac->scsi_host_ptr->can_queue + AAC_NUM_MGT_FIB;
-	for (index = 0; index <  num_of_fibs; index++) {
-
-		struct fib *fib = &aac->fibs[index];
-		__le32 XferState = fib->hw_fib_va->header.XferState;
-		bool is_response_expected = false;
-
-		if (!(XferState & cpu_to_le32(NoResponseExpected | Async)) &&
-		   (XferState & cpu_to_le32(ResponseExpected)))
-			is_response_expected = true;
-
-		if (is_response_expected
-		  || fib->flags & FIB_CONTEXT_FLAG_WAIT) {
-			unsigned long flagv;
-			spin_lock_irqsave(&fib->event_lock, flagv);
-			complete(&fib->event_wait);
-			spin_unlock_irqrestore(&fib->event_lock, flagv);
-			schedule();
-			retval = 0;
-		}
-	}
+	scsi_host_tagset_busy_iter(host, aac_close_sync_fib_iter, &retval);
 	/* Give some extra time for ioctls to complete. */
 	if (retval == 0)
 		ssleep(2);
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 81b9a3f39d79..5e860d731bca 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -687,14 +687,87 @@ static int get_num_of_incomplete_fibs(struct aac_dev *aac)
 	return iter_data.mlcnt + iter_data.llcnt + iter_data.ehcnt + iter_data.fwcnt;
 }
 
+struct aac_eh_abort_iter_data {
+	struct aac_dev *aac;
+	struct scsi_cmnd *cmd;
+	int ret;
+};
+
+static bool aac_eh_abort_busy_iter(struct scsi_cmnd *cmd, void *data,
+				   bool reserved)
+{
+	struct aac_eh_abort_iter_data *iter_data = data;
+	struct aac_dev *aac = iter_data->aac;
+	struct fib *fib = &aac->fibs[cmd->request->tag];
+
+	if (cmd != iter_data->cmd)
+		return true;
+
+	if (*(u8 *)fib->hw_fib_va != 0 &&
+	    (fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA) &&
+	    (fib->callback_data == cmd)) {
+		iter_data->ret = SUCCESS;
+		return false;
+	}
+	return true;
+}
+
+static bool aac_eh_abort_cmd_iter(struct scsi_cmnd *cmd, void *data,
+				  bool reserved)
+{
+	struct aac_eh_abort_iter_data *iter_data = data;
+	struct fib *fib = &iter_data->aac->fibs[cmd->request->tag];
+
+	if (cmd != iter_data->cmd)
+		return true;
+
+	if (fib->hw_fib_va->header.XferState &&
+	    (fib->flags & FIB_CONTEXT_FLAG) &&
+	    (fib->callback_data == iter_data->cmd)) {
+		fib->flags |= FIB_CONTEXT_FLAG_TIMED_OUT;
+		cmd->SCp.phase = AAC_OWNER_ERROR_HANDLER;
+		iter_data->ret = SUCCESS;
+	}
+	return true;
+}
+
+static bool aac_eh_abort_tur_iter(struct scsi_cmnd *cmd, void *data,
+				  bool reserved)
+{
+	struct aac_eh_abort_iter_data *iter_data = data;
+	struct fib *fib = &iter_data->aac->fibs[cmd->request->tag];
+	struct scsi_cmnd *command;
+
+	if (cmd != iter_data->cmd)
+		return true;
+
+	command = fib->callback_data;
+	if ((fib->hw_fib_va->header.XferState &
+	     cpu_to_le32(Async | NoResponseExpected)) &&
+	    (fib->flags & FIB_CONTEXT_FLAG) &&
+	    ((command)) && (command->device == cmd->device)) {
+		fib->flags |= FIB_CONTEXT_FLAG_TIMED_OUT;
+		command->SCp.phase = AAC_OWNER_ERROR_HANDLER;
+		if (command == cmd)
+			iter_data->ret = SUCCESS;
+	}
+	return true;
+}
+
 static int aac_eh_abort(struct scsi_cmnd* cmd)
 {
 	struct scsi_device * dev = cmd->device;
 	struct Scsi_Host * host = dev->host;
 	struct aac_dev * aac = (struct aac_dev *)host->hostdata;
-	int count, found;
+	int count;
 	u32 bus, cid;
 	int ret = FAILED;
+	struct aac_eh_abort_iter_data iter_data = {
+		.aac = aac,
+		.cmd = cmd,
+		.ret = FAILED,
+	};
+
 
 	if (aac_adapter_check_health(aac))
 		return ret;
@@ -711,17 +784,9 @@ static int aac_eh_abort(struct scsi_cmnd* cmd)
 		 AAC_DRIVERNAME,
 		 host->host_no, sdev_channel(dev), sdev_id(dev), (int)dev->lun);
 
-		found = 0;
-		for (count = 0; count < (host->can_queue + AAC_NUM_MGT_FIB); ++count) {
-			fib = &aac->fibs[count];
-			if (*(u8 *)fib->hw_fib_va != 0 &&
-				(fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA) &&
-				(fib->callback_data == cmd)) {
-				found = 1;
-				break;
-			}
-		}
-		if (!found)
+		scsi_host_tagset_busy_iter(host, aac_eh_abort_busy_iter,
+					   &iter_data);
+		if (iter_data.ret == FAILED)
 			return ret;
 
 		/* start a HBA_TMF_ABORT_TASK TMF request */
@@ -779,49 +844,18 @@ static int aac_eh_abort(struct scsi_cmnd* cmd)
 			 * Mark associated FIB to not complete,
 			 * eh handler does this
 			 */
-			for (count = 0;
-				count < (host->can_queue + AAC_NUM_MGT_FIB);
-				++count) {
-				struct fib *fib = &aac->fibs[count];
-
-				if (fib->hw_fib_va->header.XferState &&
-				(fib->flags & FIB_CONTEXT_FLAG) &&
-				(fib->callback_data == cmd)) {
-					fib->flags |=
-						FIB_CONTEXT_FLAG_TIMED_OUT;
-					cmd->SCp.phase =
-						AAC_OWNER_ERROR_HANDLER;
-					ret = SUCCESS;
-				}
-			}
+			scsi_host_tagset_busy_iter(host, aac_eh_abort_cmd_iter,
+						   &iter_data);
+			ret = iter_data.ret;
 			break;
 		case TEST_UNIT_READY:
 			/*
 			 * Mark associated FIB to not complete,
 			 * eh handler does this
 			 */
-			for (count = 0;
-				count < (host->can_queue + AAC_NUM_MGT_FIB);
-				++count) {
-				struct scsi_cmnd *command;
-				struct fib *fib = &aac->fibs[count];
-
-				command = fib->callback_data;
-
-				if ((fib->hw_fib_va->header.XferState &
-					cpu_to_le32
-					(Async | NoResponseExpected)) &&
-					(fib->flags & FIB_CONTEXT_FLAG) &&
-					((command)) &&
-					(command->device == cmd->device)) {
-					fib->flags |=
-						FIB_CONTEXT_FLAG_TIMED_OUT;
-					command->SCp.phase =
-						AAC_OWNER_ERROR_HANDLER;
-					if (command == cmd)
-						ret = SUCCESS;
-				}
-			}
+			scsi_host_tagset_busy_iter(host, aac_eh_abort_tur_iter,
+						   &iter_data);
+			ret = iter_data.ret;
 			break;
 		}
 	}
@@ -1016,6 +1050,36 @@ static int aac_eh_target_reset(struct scsi_cmnd *cmd)
 	return ret;
 }
 
+static bool aac_eh_bus_reset_iter(struct scsi_cmnd *cmd, void *data,
+				  bool reserved)
+{
+	struct Scsi_Host *host = cmd->device->host;
+	struct aac_dev *aac = (struct aac_dev *)host->hostdata;
+	struct fib *fib = &aac->fibs[cmd->request->tag];
+	int *cmd_bus = data;
+
+	if (fib->hw_fib_va->header.XferState &&
+	    (fib->flags & FIB_CONTEXT_FLAG) &&
+	    (fib->flags & FIB_CONTEXT_FLAG_SCSI_CMD)) {
+		struct aac_hba_map_info *info;
+		u32 bus, cid;
+
+		if (cmd != (struct scsi_cmnd *)fib->callback_data)
+			return true;
+		bus = aac_logical_to_phys(scmd_channel(cmd));
+		if (bus != *cmd_bus)
+			return true;
+		cid = scmd_id(cmd);
+		info = &aac->hba_map[bus][cid];
+		if (bus >= AAC_MAX_BUSES || cid >= AAC_MAX_TARGETS ||
+		    info->devtype != AAC_DEVTYPE_NATIVE_RAW) {
+			fib->flags |= FIB_CONTEXT_FLAG_EH_RESET;
+			cmd->SCp.phase = AAC_OWNER_ERROR_HANDLER;
+		}
+	}
+	return true;
+}
+
 /*
  *	aac_eh_bus_reset	- Bus reset command handling
  *	@scsi_cmd:	SCSI command block causing the reset
@@ -1030,32 +1094,10 @@ static int aac_eh_bus_reset(struct scsi_cmnd* cmd)
 	u32 cmd_bus;
 	int status = 0;
 
-
 	cmd_bus = aac_logical_to_phys(scmd_channel(cmd));
-	/* Mark the assoc. FIB to not complete, eh handler does this */
-	for (count = 0; count < (host->can_queue + AAC_NUM_MGT_FIB); ++count) {
-		struct fib *fib = &aac->fibs[count];
-
-		if (fib->hw_fib_va->header.XferState &&
-		    (fib->flags & FIB_CONTEXT_FLAG) &&
-		    (fib->flags & FIB_CONTEXT_FLAG_SCSI_CMD)) {
-			struct aac_hba_map_info *info;
-			u32 bus, cid;
-
-			cmd = (struct scsi_cmnd *)fib->callback_data;
-			bus = aac_logical_to_phys(scmd_channel(cmd));
-			if (bus != cmd_bus)
-				continue;
-			cid = scmd_id(cmd);
-			info = &aac->hba_map[bus][cid];
-			if (bus >= AAC_MAX_BUSES || cid >= AAC_MAX_TARGETS ||
-			    info->devtype != AAC_DEVTYPE_NATIVE_RAW) {
-				fib->flags |= FIB_CONTEXT_FLAG_EH_RESET;
-				cmd->SCp.phase = AAC_OWNER_ERROR_HANDLER;
-			}
-		}
-	}
 
+	/* Mark the assoc. FIB to not complete, eh handler does this */
+	scsi_host_tagset_busy_iter(host, aac_eh_bus_reset_iter, &cmd_bus);
 	pr_err("%s: Host adapter reset request. SCSI hang ?\n", AAC_DRIVERNAME);
 
 	/*
-- 
2.16.4

