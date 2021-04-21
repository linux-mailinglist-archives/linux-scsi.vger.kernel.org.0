Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF313671E7
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbhDURu6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245058AbhDURtM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD2BAB1CA;
        Wed, 21 Apr 2021 17:48:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/42] NCR5380: Fold SCSI message ABORT onto DID_ABORT
Date:   Wed, 21 Apr 2021 19:47:23 +0200
Message-Id: <20210421174749.11221-17-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The message byte can take only two values, COMMAND_COMPLETE and ABORT.
So we can easily map ABORT to DID_ABORT and do not set the message byte.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/NCR5380.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 855edda9db41..76b4dce22e03 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1827,7 +1827,8 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					hostdata->connected = NULL;
 					hostdata->busy[scmd_id(cmd)] &= ~(1 << cmd->device->lun);
 
-					set_msg_byte(cmd, cmd->SCp.Message);
+					if (cmd->SCp.Message == ABORT)
+						set_host_byte(cmd, DID_ABORT);
 					set_status_byte(cmd, cmd->SCp.Status);
 
 					set_resid_from_SCp(cmd);
-- 
2.29.2

