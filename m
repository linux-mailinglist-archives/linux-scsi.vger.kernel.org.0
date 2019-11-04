Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA4EDB1F
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfKDJCf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbfKDJCO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2BB0B49D;
        Mon,  4 Nov 2019 09:02:10 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 26/52] libata-scsi: use scsi_build_sense()
Date:   Mon,  4 Nov 2019 10:01:25 +0100
Message-Id: <20191104090151.129140-27-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use scsi_build_sense() to format the sense code.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b197d2fbe3f8..0fd3cb8e4e49 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -342,9 +342,7 @@ void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (!cmd)
 		return;
 
-	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
-
-	scsi_build_sense_buffer(d_sense, cmd->sense_buffer, sk, asc, ascq);
+	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
 }
 
 void ata_scsi_set_sense_information(struct ata_device *dev,
@@ -1092,8 +1090,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 		 * ATA PASS-THROUGH INFORMATION AVAILABLE
 		 * Always in descriptor format sense.
 		 */
-		scsi_build_sense_buffer(1, cmd->sense_buffer,
-					RECOVERED_ERROR, 0, 0x1D);
+		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
 
 	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
-- 
2.16.4

