Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7086C103793
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Nov 2019 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfKTKbb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Nov 2019 05:31:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:49306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728705AbfKTKba (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 20 Nov 2019 05:31:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C98DCB3E6;
        Wed, 20 Nov 2019 10:31:27 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Balsundar P <balsundar.p@microsemi.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH 04/11] aacraid: Do not wait for outstanding write commands on synchronize_cache
Date:   Wed, 20 Nov 2019 11:31:07 +0100
Message-Id: <20191120103114.24723-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191120103114.24723-1-hare@suse.de>
References: <20191120103114.24723-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is no need to wait for outstanding write commands on synchronize
cache; the block layer is responsible for I/O scheduling, no need
to out-guess it on the driver layer.

Cc: Balsundar P <balsundar.p@microsemi.com>
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aacraid/aachba.c | 76 ++-----------------------------------------
 1 file changed, 2 insertions(+), 74 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index e36608ce937a..cfa14e15d5f0 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -2601,9 +2601,7 @@ static int aac_write(struct scsi_cmnd * scsicmd)
 static void synchronize_callback(void *context, struct fib *fibptr)
 {
 	struct aac_synchronize_reply *synchronizereply;
-	struct scsi_cmnd *cmd;
-
-	cmd = context;
+	struct scsi_cmnd *cmd = context;
 
 	if (!aac_valid_context(cmd, fibptr))
 		return;
@@ -2644,77 +2642,8 @@ static int aac_synchronize(struct scsi_cmnd *scsicmd)
 	int status;
 	struct fib *cmd_fibcontext;
 	struct aac_synchronize *synchronizecmd;
-	struct scsi_cmnd *cmd;
 	struct scsi_device *sdev = scsicmd->device;
-	int active = 0;
 	struct aac_dev *aac;
-	u64 lba = ((u64)scsicmd->cmnd[2] << 24) | (scsicmd->cmnd[3] << 16) |
-		(scsicmd->cmnd[4] << 8) | scsicmd->cmnd[5];
-	u32 count = (scsicmd->cmnd[7] << 8) | scsicmd->cmnd[8];
-	unsigned long flags;
-
-	/*
-	 * Wait for all outstanding queued commands to complete to this
-	 * specific target (block).
-	 */
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
-
-	/*
-	 *	Yield the processor (requeue for later)
-	 */
-	if (active)
-		return SCSI_MLQUEUE_DEVICE_BUSY;
 
 	aac = (struct aac_dev *)sdev->host->hostdata;
 	if (aac->in_reset)
@@ -2723,8 +2652,7 @@ static int aac_synchronize(struct scsi_cmnd *scsicmd)
 	/*
 	 *	Allocate and initialize a Fib
 	 */
-	if (!(cmd_fibcontext = aac_fib_alloc(aac)))
-		return SCSI_MLQUEUE_HOST_BUSY;
+	cmd_fibcontext = aac_fib_alloc_tag(aac, scsicmd);
 
 	aac_fib_init(cmd_fibcontext);
 
-- 
2.16.4

