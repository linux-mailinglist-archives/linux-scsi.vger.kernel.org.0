Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7B36C0E8
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhD0IcL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 04:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235169AbhD0Ib5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:31:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D3D2B121;
        Tue, 27 Apr 2021 08:31:06 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 24/40] nsp32: do not set message byte
Date:   Tue, 27 Apr 2021 10:30:30 +0200
Message-Id: <20210427083046.31620-25-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210427083046.31620-1-hare@suse.de>
References: <20210427083046.31620-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The message byte always devolves to COMMAND_COMPLETE, so there
is no point in setting it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/nsp32.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index 6d29908017f0..56009eb248a7 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -948,7 +948,6 @@ static int nsp32_queuecommand_lck(struct scsi_cmnd *SCpnt,
 	SCpnt->scsi_done     = done;
 	data->CurrentSC      = SCpnt;
 	SCpnt->SCp.Status    = SAM_STAT_CHECK_CONDITION;
-	SCpnt->SCp.Message   = 0;
 	scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
 
 	SCpnt->SCp.ptr		    = (char *)scsi_sglist(SCpnt);
@@ -1690,12 +1689,10 @@ static int nsp32_busfree_occur(struct scsi_cmnd *SCpnt, unsigned short execph)
 		nsp32_dbg(NSP32_DEBUG_BUSFREE, "command complete");
 
 		SCpnt->SCp.Status  = nsp32_read1(base, SCSI_CSB_IN);
-		SCpnt->SCp.Message = 0;
 		nsp32_dbg(NSP32_DEBUG_BUSFREE,
 			  "normal end stat=0x%x resid=0x%x\n",
 			  SCpnt->SCp.Status, scsi_get_resid(SCpnt));
 		SCpnt->result = (DID_OK << 16) |
-			(SCpnt->SCp.Message << 8) |
 			(SCpnt->SCp.Status << 0);
 		nsp32_scsi_done(SCpnt);
 		/* All operation is done */
@@ -1703,7 +1700,6 @@ static int nsp32_busfree_occur(struct scsi_cmnd *SCpnt, unsigned short execph)
 	} else if (execph & MSGIN_04_VALID) {
 		/* MsgIn 04: Disconnect */
 		SCpnt->SCp.Status  = nsp32_read1(base, SCSI_CSB_IN);
-		SCpnt->SCp.Message = 4;
 
 		nsp32_dbg(NSP32_DEBUG_BUSFREE, "disconnect");
 		return TRUE;
@@ -1712,7 +1708,7 @@ static int nsp32_busfree_occur(struct scsi_cmnd *SCpnt, unsigned short execph)
 		nsp32_msg(KERN_WARNING, "unexpected bus free occurred");
 
 		/* DID_ERROR? */
-		//SCpnt->result   = (DID_OK << 16) | (SCpnt->SCp.Message << 8) | (SCpnt->SCp.Status << 0);
+		//SCpnt->result   = (DID_OK << 16) | (SCpnt->SCp.Status << 0);
 		SCpnt->result = DID_ERROR << 16;
 		nsp32_scsi_done(SCpnt);
 		return TRUE;
-- 
2.29.2

