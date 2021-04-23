Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A681B369144
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbhDWLkn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:40:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:46956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242142AbhDWLkd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59083B1B5;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/39] NCR5380: Fold SCSI message ABORT onto DID_ABORT
Date:   Fri, 23 Apr 2021 13:39:19 +0200
Message-Id: <20210423113944.42672-15-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
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
index d7594b794d3c..1aea164c535c 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1826,9 +1826,9 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					hostdata->connected = NULL;
 					hostdata->busy[scmd_id(cmd)] &= ~(1 << cmd->device->lun);
 
-					cmd->result &= ~0xffff;
-					cmd->result |= cmd->SCp.Status;
-					cmd->result |= cmd->SCp.Message << 8;
+					if (cmd->SCp.Message == ABORT)
+						set_host_byte(cmd, DID_ABORT);
+					set_status_byte(cmd, cmd->SCp.Status);
 
 					set_resid_from_SCp(cmd);
 
-- 
2.29.2

