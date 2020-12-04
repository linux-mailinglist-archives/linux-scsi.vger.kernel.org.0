Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89DF2CEBB4
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbgLDKDa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:03:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:51214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbgLDKD1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:03:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1584BAE86;
        Fri,  4 Dec 2020 10:01:48 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/37] stex: do not set COMMAND_COMPLETE
Date:   Fri,  4 Dec 2020 11:01:20 +0100
Message-Id: <20201204100140.140863-18-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201204100140.140863-1-hare@suse.de>
References: <20201204100140.140863-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

COMMAND_COMPLETE is defined as '0', so setting it is quite pointless.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/stex.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index d4f10c0d813c..de8d52d1463f 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -625,7 +625,7 @@ stex_queuecommand_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 		if (page == 0x8 || page == 0x3f) {
 			scsi_sg_copy_from_buffer(cmd, ms10_caching_page,
 						 sizeof(ms10_caching_page));
-			cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
+			cmd->result = DID_OK << 16;
 			done(cmd);
 		} else
 			stex_invalid_field(cmd, done);
@@ -644,7 +644,7 @@ stex_queuecommand_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 		break;
 	case TEST_UNIT_READY:
 		if (id == host->max_id - 1) {
-			cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
+			cmd->result = DID_OK << 16;
 			done(cmd);
 			return 0;
 		}
@@ -661,7 +661,7 @@ stex_queuecommand_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 			(cmd->cmnd[1] & INQUIRY_EVPD) == 0) {
 			scsi_sg_copy_from_buffer(cmd, (void *)console_inq_page,
 						 sizeof(console_inq_page));
-			cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
+			cmd->result = DID_OK << 16;
 			done(cmd);
 		} else
 			stex_invalid_field(cmd, done);
@@ -679,9 +679,10 @@ stex_queuecommand_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 			ver.console_id = host->max_id - 1;
 			ver.host_no = hba->host->host_no;
 			cp_len = scsi_sg_copy_from_buffer(cmd, &ver, cp_len);
-			cmd->result = sizeof(ver) == cp_len ?
-				DID_OK << 16 | COMMAND_COMPLETE << 8 :
-				DID_ERROR << 16 | COMMAND_COMPLETE << 8;
+			if (sizeof(ver) == cp_len)
+				cmd->result = DID_OK << 16;
+			else
+				cmd->result = DID_ERROR << 16;
 			done(cmd);
 			return 0;
 		}
@@ -735,16 +736,16 @@ static void stex_scsi_done(struct st_ccb *ccb)
 		result = ccb->scsi_status;
 		switch (ccb->scsi_status) {
 		case SAM_STAT_GOOD:
-			result |= DID_OK << 16 | COMMAND_COMPLETE << 8;
+			result |= DID_OK << 16;
 			break;
 		case SAM_STAT_CHECK_CONDITION:
 			result |= DRIVER_SENSE << 24;
 			break;
 		case SAM_STAT_BUSY:
-			result |= DID_BUS_BUSY << 16 | COMMAND_COMPLETE << 8;
+			result |= DID_BUS_BUSY << 16;
 			break;
 		default:
-			result |= DID_ERROR << 16 | COMMAND_COMPLETE << 8;
+			result |= DID_ERROR << 16;
 			break;
 		}
 	}
@@ -752,15 +753,15 @@ static void stex_scsi_done(struct st_ccb *ccb)
 		result = DRIVER_SENSE << 24 | SAM_STAT_CHECK_CONDITION;
 	else switch (ccb->srb_status) {
 		case SRB_STATUS_SELECTION_TIMEOUT:
-			result = DID_NO_CONNECT << 16 | COMMAND_COMPLETE << 8;
+			result = DID_NO_CONNECT << 16;
 			break;
 		case SRB_STATUS_BUSY:
-			result = DID_BUS_BUSY << 16 | COMMAND_COMPLETE << 8;
+			result = DID_BUS_BUSY << 16;
 			break;
 		case SRB_STATUS_INVALID_REQUEST:
 		case SRB_STATUS_ERROR:
 		default:
-			result = DID_ERROR << 16 | COMMAND_COMPLETE << 8;
+			result = DID_ERROR << 16;
 			break;
 	}
 
-- 
2.16.4

