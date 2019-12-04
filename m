Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C15112DE1
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Dec 2019 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfLDO70 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Dec 2019 09:59:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbfLDO7Z (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:59:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D43DAECA;
        Wed,  4 Dec 2019 14:59:24 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        Balsundar P <balsundar.p@microchip.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/13] aacraid: use scsi_host_busy_iter() to wait for outstanding commands
Date:   Wed,  4 Dec 2019 15:59:16 +0100
Message-Id: <20191204145918.143134-12-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191204145918.143134-1-hare@suse.de>
References: <20191204145918.143134-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of traversing the list of possible commands by hands we
should be using scsi_host_busy_iter() to figure out if there are
outstanding commands.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aacraid/comminit.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index f75878d773cf..355b16f0b145 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -272,36 +272,35 @@ static void aac_queue_init(struct aac_dev * dev, struct aac_queue * q, u32 *mem,
 	q->entries = qsize;
 }
 
+static bool wait_for_io_iter(struct scsi_cmnd *cmd, void *data, bool rsvd)
+{
+	int *active = data;
+
+	if (cmd->SCp.phase == AAC_OWNER_FIRMWARE)
+		*active = *active + 1;
+	return true;
+}
 static void aac_wait_for_io_completion(struct aac_dev *aac)
 {
-	unsigned long flagv = 0;
-	int i = 0;
+	int i = 0, active;
 
 	for (i = 60; i; --i) {
-		struct scsi_device *dev;
-		struct scsi_cmnd *command;
-		int active = 0;
-
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
 
-		}
+		active = 0;
+		scsi_host_busy_iter(aac->scsi_host_ptr,
+				    wait_for_io_iter, &active);
 		/*
 		 * We can exit If all the commands are complete
 		 */
 		if (active == 0)
 			break;
+		dev_info(&aac->pdev->dev,
+			 "Wait for %d commands to complete\n", active);
 		ssleep(1);
 	}
+	if (active)
+		dev_err(&aac->pdev->dev,
+			"%d outstanding commands during shutdown\n", active);
 }
 
 /**
-- 
2.16.4

