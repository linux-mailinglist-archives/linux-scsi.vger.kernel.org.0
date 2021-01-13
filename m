Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A522F4732
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbhAMJHS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:54986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbhAMJHO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:07:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D7ACB8F2;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 30/35] wd33c93: use SCSI status
Date:   Wed, 13 Jan 2021 10:04:55 +0100
Message-Id: <20210113090500.129644-31-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use standard SCSI status and drop usage of the linux-specific ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/wd33c93.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index 87dafbc942d3..a23277bb870e 100644
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
2.29.2

