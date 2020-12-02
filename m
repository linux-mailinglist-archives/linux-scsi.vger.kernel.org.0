Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACE02CBC1B
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 12:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgLBLzO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 06:55:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:41222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgLBLzO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 06:55:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04D87AE86;
        Wed,  2 Dec 2020 11:53:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 28/34] esp_scsi: do not set SCSI message byte
Date:   Wed,  2 Dec 2020 12:52:43 +0100
Message-Id: <20201202115249.37690-29-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201202115249.37690-1-hare@suse.de>
References: <20201202115249.37690-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The message byte setting always devolves to COMMAND_COMPLETE, so
we can drop setting the message byte in the SCSI result.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/esp_scsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index f6f663f554a7..c8ae81d64b06 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -921,7 +921,6 @@ static void esp_cmd_is_done(struct esp *esp, struct esp_cmd_entry *ent,
 		 */
 		cmd->result = ((DRIVER_SENSE << 24) |
 			       (DID_OK << 16) |
-			       (COMMAND_COMPLETE << 8) |
 			       (SAM_STAT_CHECK_CONDITION << 0));
 
 		ent->flags &= ~ESP_CMD_FLAG_AUTOSENSE;
@@ -1869,7 +1868,6 @@ static int esp_process_event(struct esp *esp)
 				esp_autosense(esp, ent);
 			} else {
 				cmd->result = ent->status;
-				set_msg_byte(cmd, ent->message);
 				esp_cmd_is_done(esp, ent, cmd, DID_OK);
 			}
 		} else if (ent->message == DISCONNECT) {
-- 
2.16.4

