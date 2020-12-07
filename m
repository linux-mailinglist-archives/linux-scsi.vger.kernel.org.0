Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667202D10FA
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 13:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLGMuf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 07:50:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:44210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGMuf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 07:50:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E60ABAEAB;
        Mon,  7 Dec 2020 12:48:31 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/35] nsp_cs: drop internal SCSI message definition
Date:   Mon,  7 Dec 2020 13:48:02 +0100
Message-Id: <20201207124819.95822-19-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201207124819.95822-1-hare@suse.de>
References: <20201207124819.95822-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the standard SCSI message definitions instead of the
driver-internal ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/pcmcia/nsp_cs.c | 12 ++++++------
 drivers/scsi/pcmcia/nsp_cs.h | 11 -----------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index bb3b3884f968..5d5f50d6a02d 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1132,7 +1132,7 @@ static irqreturn_t nspintr(int irq, void *dev_id)
 		//*sync_neg       = SYNC_NOT_YET;
 
 		/* all command complete and return status */
-		if (tmpSC->SCp.Message == MSG_COMMAND_COMPLETE) {
+		if (tmpSC->SCp.Message == COMMAND_COMPLETE) {
 			tmpSC->result = (DID_OK		             << 16) |
 					((tmpSC->SCp.Message & 0xff) <<  8) |
 					((tmpSC->SCp.Status  & 0xff) <<  0);
@@ -1226,9 +1226,9 @@ static irqreturn_t nspintr(int irq, void *dev_id)
 			data->Sync[target].SyncOffset = 0;
 
 			/**/
-			data->MsgBuffer[i] = MSG_EXTENDED; i++;
+			data->MsgBuffer[i] = EXTENDED_MESSAGE; i++;
 			data->MsgBuffer[i] = 3;            i++;
-			data->MsgBuffer[i] = MSG_EXT_SDTR; i++;
+			data->MsgBuffer[i] = EXTENDED_SDTR; i++;
 			data->MsgBuffer[i] = 0x0c;         i++;
 			data->MsgBuffer[i] = 15;           i++;
 			/**/
@@ -1255,9 +1255,9 @@ static irqreturn_t nspintr(int irq, void *dev_id)
 			//nsp_dbg(NSP_DEBUG_INTR, "sync target=%d,lun=%d",target,lun);
 
 			if (data->MsgLen       >= 5            &&
-			    data->MsgBuffer[0] == MSG_EXTENDED &&
+			    data->MsgBuffer[0] == EXTENDED_MESSAGE &&
 			    data->MsgBuffer[1] == 3            &&
-			    data->MsgBuffer[2] == MSG_EXT_SDTR ) {
+			    data->MsgBuffer[2] == EXTENDED_SDTR ) {
 				data->Sync[target].SyncPeriod = data->MsgBuffer[3];
 				data->Sync[target].SyncOffset = data->MsgBuffer[4];
 				//nsp_dbg(NSP_DEBUG_INTR, "sync ok, %d %d", data->MsgBuffer[3], data->MsgBuffer[4]);
@@ -1275,7 +1275,7 @@ static irqreturn_t nspintr(int irq, void *dev_id)
 		tmp = -1;
 		for (i = 0; i < data->MsgLen; i++) {
 			tmp = data->MsgBuffer[i];
-			if (data->MsgBuffer[i] == MSG_EXTENDED) {
+			if (data->MsgBuffer[i] == EXTENDED_MESSAGE) {
 				i += (1 + data->MsgBuffer[i+1]);
 			}
 		}
diff --git a/drivers/scsi/pcmcia/nsp_cs.h b/drivers/scsi/pcmcia/nsp_cs.h
index ea5122f3396d..665bf8d0faf7 100644
--- a/drivers/scsi/pcmcia/nsp_cs.h
+++ b/drivers/scsi/pcmcia/nsp_cs.h
@@ -370,17 +370,6 @@ enum _burst_mode {
 	BURST_MEM32 = 2,
 };
 
-/**************************************************************************
- * SCSI messaage
- */
-#define MSG_COMMAND_COMPLETE 0x00
-#define MSG_EXTENDED         0x01
-#define MSG_ABORT            0x06
-#define MSG_NO_OPERATION     0x08
-#define MSG_BUS_DEVICE_RESET 0x0c
-
-#define MSG_EXT_SDTR         0x01
-
 /* scatter-gather table */
 #  define BUFFER_ADDR ((char *)((sg_virt(SCpnt->SCp.buffer))))
 
-- 
2.16.4

