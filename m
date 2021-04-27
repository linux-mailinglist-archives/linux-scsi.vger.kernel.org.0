Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155BA36C0EA
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 10:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhD0IcO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 04:32:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235176AbhD0IcA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:32:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71B16B0EA;
        Tue, 27 Apr 2021 08:31:06 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/40] NCR5380: Fold SCSI message ABORT onto DID_ABORT
Date:   Tue, 27 Apr 2021 10:30:21 +0200
Message-Id: <20210427083046.31620-16-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210427083046.31620-1-hare@suse.de>
References: <20210427083046.31620-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The message byte can take only two values, COMMAND_COMPLETE and ABORT.
So we can easily map ABORT to DID_ABORT and do not set the message byte.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/NCR5380.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index d7594b794d3c..a74674941e7d 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1815,6 +1815,8 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 
 				switch (tmp) {
 				case ABORT:
+					set_host_byte(cmd, DID_ABORT);
+					/* fallthrough */
 				case COMMAND_COMPLETE:
 					/* Accept message by clearing ACK */
 					sink = 1;
@@ -1826,9 +1828,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					hostdata->connected = NULL;
 					hostdata->busy[scmd_id(cmd)] &= ~(1 << cmd->device->lun);
 
-					cmd->result &= ~0xffff;
-					cmd->result |= cmd->SCp.Status;
-					cmd->result |= cmd->SCp.Message << 8;
+					set_status_byte(cmd, cmd->SCp.Status);
 
 					set_resid_from_SCp(cmd);
 
-- 
2.29.2

