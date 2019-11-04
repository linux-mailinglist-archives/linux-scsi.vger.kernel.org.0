Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D02EDAF5
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKDJCL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:56966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727332AbfKDJCL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18237B27D;
        Mon,  4 Nov 2019 09:02:10 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/52] wd33c93: use SCSI status
Date:   Mon,  4 Nov 2019 10:01:02 +0100
Message-Id: <20191104090151.129140-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use standard SCSI status and drop usage of the linux-specific ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/wd33c93.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index f81046f0e68a..76143a68f55c 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -1176,7 +1176,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 			if (cmd->SCp.Status == ILLEGAL_STATUS_BYTE)
 				cmd->SCp.Status = lun;
 			if (cmd->cmnd[0] == REQUEST_SENSE
-			    && cmd->SCp.Status != GOOD)
+			    && cmd->SCp.Status != SAM_STAT_GOOD)
 				cmd->result =
 				    (cmd->
 				     result & 0x00ffff) | (DID_ERROR << 16);
@@ -1262,7 +1262,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 		    hostdata->connected = NULL;
 		hostdata->busy[cmd->device->id] &= ~(1 << (cmd->device->lun & 0xff));
 		hostdata->state = S_UNCONNECTED;
-		if (cmd->cmnd[0] == REQUEST_SENSE && cmd->SCp.Status != GOOD)
+		if (cmd->cmnd[0] == REQUEST_SENSE && cmd->SCp.Status != SAM_STAT_GOOD)
 			cmd->result =
 			    (cmd->result & 0x00ffff) | (DID_ERROR << 16);
 		else
@@ -1296,7 +1296,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 			hostdata->state = S_UNCONNECTED;
 			DB(DB_INTR, printk(":%d", cmd->SCp.Status))
 			    if (cmd->cmnd[0] == REQUEST_SENSE
-				&& cmd->SCp.Status != GOOD)
+				&& cmd->SCp.Status != SAM_STAT_GOOD)
 				cmd->result =
 				    (cmd->
 				     result & 0x00ffff) | (DID_ERROR << 16);
-- 
2.16.4

