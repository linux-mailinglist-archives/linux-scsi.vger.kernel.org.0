Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B152D2F472B
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbhAMJHH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbhAMJGt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:06:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A705B8F6;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 29/35] esp_scsi: do not set SCSI message byte
Date:   Wed, 13 Jan 2021 10:04:54 +0100
Message-Id: <20210113090500.129644-30-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The message byte setting always devolves to COMMAND_COMPLETE, so
we can drop setting the message byte in the SCSI result.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/esp_scsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 2bc7e990c119..007ccef5d1e2 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -907,10 +907,8 @@ static void esp_cmd_is_done(struct esp *esp, struct esp_cmd_entry *ent,
 	esp_free_lun_tag(ent, dev->hostdata);
 	cmd->result = 0;
 	set_host_byte(cmd, host_byte);
-	if (host_byte == DID_OK) {
-		set_msg_byte(cmd, ent->message);
+	if (host_byte == DID_OK)
 		set_status_byte(cmd, ent->status);
-	}
 
 	if (ent->eh_done) {
 		complete(ent->eh_done);
@@ -926,7 +924,6 @@ static void esp_cmd_is_done(struct esp *esp, struct esp_cmd_entry *ent,
 		 */
 		cmd->result = ((DRIVER_SENSE << 24) |
 			       (DID_OK << 16) |
-			       (COMMAND_COMPLETE << 8) |
 			       (SAM_STAT_CHECK_CONDITION << 0));
 
 		ent->flags &= ~ESP_CMD_FLAG_AUTOSENSE;
-- 
2.29.2

