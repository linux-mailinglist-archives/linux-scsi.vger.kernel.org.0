Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DD32CBC0A
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbgLBLyq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 06:54:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:38736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387923AbgLBLyo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 06:54:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FBB5AE52;
        Wed,  2 Dec 2020 11:53:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 25/34] mac53c94: Do not set invalid command result
Date:   Wed,  2 Dec 2020 12:52:40 +0100
Message-Id: <20201202115249.37690-26-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201202115249.37690-1-hare@suse.de>
References: <20201202115249.37690-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

CMD_ACCEPT_MSG is an internal definition, and most certainly not
a SCSI status. As the latter gets set during command completion
we can drop the assignment here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/mac53c94.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 43edf83fdb62..9e989776609b 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -326,7 +326,6 @@ static void mac53c94_interrupt(int irq, void *dev_id)
 		}
 		cmd->SCp.Status = readb(&regs->fifo);
 		cmd->SCp.Message = readb(&regs->fifo);
-		cmd->result = CMD_ACCEPT_MSG;
 		writeb(CMD_ACCEPT_MSG, &regs->command);
 		state->phase = busfreeing;
 		break;
-- 
2.16.4

