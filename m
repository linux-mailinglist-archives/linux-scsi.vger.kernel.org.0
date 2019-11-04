Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDEEDB0F
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfKDJC2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:57316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbfKDJCR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74073B4C0;
        Mon,  4 Nov 2019 09:02:11 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 48/52] 3w-9xxx: Kill unreachable code in twa_interrupt()
Date:   Mon,  4 Nov 2019 10:01:47 +0100
Message-Id: <20191104090151.129140-49-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

twa_fill_sense() can never return '1', so the check is pointless.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/3w-9xxx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 3337b1e80412..b275ce3b0fbd 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1339,12 +1339,6 @@ static irqreturn_t twa_interrupt(int irq, void *dev_instance)
 					cmd->result = (DID_OK << 16);
 				}
 
-				/* If error, command failed */
-				if (error == 1) {
-					/* Ask for a host reset */
-					cmd->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
-				}
-
 				/* Report residual bytes for single sgl */
 				if ((scsi_sg_count(cmd) <= 1) && (full_command_packet->command.newcommand.status == 0)) {
 					if (full_command_packet->command.newcommand.sg_list[0].length < scsi_bufflen(tw_dev->srb[request_id]))
-- 
2.16.4

