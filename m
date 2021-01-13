Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB39A2F4738
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbhAMJH2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:53814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbhAMJHG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:07:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E09C1B8FD;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Don Brace <don.brace@microchip.com>
Subject: [PATCH 16/35] hpsa: do not set COMMAND_COMPLETE
Date:   Wed, 13 Jan 2021 10:04:41 +0100
Message-Id: <20210113090500.129644-17-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

COMMAND_COMPLETE is defined as '0', and it is a SCSI parallel message
to boot. So drop the call to set_msg_byte().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Don Brace <don.brace@microchip.com>
---
 drivers/scsi/hpsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index f4d3747cfa0b..337d3aa91945 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -2396,7 +2396,6 @@ static int handle_ioaccel_mode2_error(struct ctlr_info *h,
 			break;
 		case IOACCEL2_STATUS_SR_UNDERRUN:
 			cmd->result = (DID_OK << 16);		/* host byte */
-			cmd->result |= (COMMAND_COMPLETE << 8);	/* msg byte */
 			ioaccel2_resid = get_unaligned_le32(
 						&c2->error_data.resid_cnt[0]);
 			scsi_set_resid(cmd, ioaccel2_resid);
@@ -2597,8 +2596,7 @@ static void complete_scsi_command(struct CommandList *cp)
 		(c2->sg[0].chain_indicator == IOACCEL2_CHAIN))
 		hpsa_unmap_ioaccel2_sg_chain_block(h, c2);
 
-	cmd->result = (DID_OK << 16); 		/* host byte */
-	cmd->result |= (COMMAND_COMPLETE << 8);	/* msg byte */
+	cmd->result = (DID_OK << 16);		/* host byte */
 
 	/* SCSI command has already been cleaned up in SML */
 	if (dev->was_removed) {
-- 
2.29.2

