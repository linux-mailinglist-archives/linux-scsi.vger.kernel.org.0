Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617AC2D10F1
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 13:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLGMuN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 07:50:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:43272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgLGMuN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 07:50:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42472B1A1;
        Mon,  7 Dec 2020 12:48:32 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 24/35] atp870u: use standard definitions
Date:   Mon,  7 Dec 2020 13:48:08 +0100
Message-Id: <20201207124819.95822-25-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201207124819.95822-1-hare@suse.de>
References: <20201207124819.95822-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use standard definitions for SCSI commands and return status
instead of the hardcoded values.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/atp870u.c | 54 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index e559baeb0329..da6ca2b153d8 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -379,28 +379,28 @@ static irqreturn_t atp870u_intr_handle(int irq, void *dev_id)
 			if (is885(dev)) {
 				i = atp_readb_pci(dev, c, 1) & 0xf3;
 				//j=workreq->cmnd[0];
-				if ((workreq->cmnd[0] == 0x08) ||
-				    (workreq->cmnd[0] == 0x28) ||
-				    (workreq->cmnd[0] == 0x0a) ||
-				    (workreq->cmnd[0] == 0x2a)) {
+				if ((workreq->cmnd[0] == READ_6) ||
+				    (workreq->cmnd[0] == READ_10) ||
+				    (workreq->cmnd[0] == WRITE_6) ||
+				    (workreq->cmnd[0] == WRITE_10)) {
 				   i |= 0x0c;
 				}
 				atp_writeb_pci(dev, c, 1, i);
 			} else if (is880(dev)) {
-				if ((workreq->cmnd[0] == 0x08) ||
-				    (workreq->cmnd[0] == 0x28) ||
-				    (workreq->cmnd[0] == 0x0a) ||
-				    (workreq->cmnd[0] == 0x2a))
+				if ((workreq->cmnd[0] == READ_6) ||
+				    (workreq->cmnd[0] == READ_10) ||
+				    (workreq->cmnd[0] == WRITE_6) ||
+				    (workreq->cmnd[0] == WRITE_10))
 					atp_writeb_base(dev, 0x3b,
 							(atp_readb_base(dev, 0x3b) & 0x3f) | 0xc0);
 				else
 					atp_writeb_base(dev, 0x3b,
 							atp_readb_base(dev, 0x3b) & 0x3f);
 			} else {
-				if ((workreq->cmnd[0] == 0x08) ||
-				    (workreq->cmnd[0] == 0x28) ||
-				    (workreq->cmnd[0] == 0x0a) ||
-				    (workreq->cmnd[0] == 0x2a))
+				if ((workreq->cmnd[0] == READ_6) ||
+				    (workreq->cmnd[0] == READ_10) ||
+				    (workreq->cmnd[0] == WRITE_6) ||
+				    (workreq->cmnd[0] == WRITE_10))
 					atp_writeb_base(dev, 0x3a,
 							(atp_readb_base(dev, 0x3a) & 0xf3) | 0x08);
 				else
@@ -497,10 +497,10 @@ static irqreturn_t atp870u_intr_handle(int irq, void *dev_id)
 				workreq->result = atp_readb_io(dev, c, 0x0f);
 				if (((dev->r1f[c][target_id] & 0x10) != 0) && is885(dev)) {
 					printk(KERN_WARNING "AEC67162 CRC ERROR !\n");
-					workreq->result = 0x02;
+					workreq->result = SAM_STAT_CHECK_CONDITION;
 				}
 			} else
-				workreq->result = 0x02;
+				workreq->result = SAM_STAT_CHECK_CONDITION;
 
 			if (is885(dev)) {
 				j = atp_readb_base(dev, 0x29) | 0x01;
@@ -630,7 +630,7 @@ static int atp870u_queuecommand_lck(struct scsi_cmnd *req_p,
 	req_p->sense_buffer[0]=0;
 	scsi_set_resid(req_p, 0);
 	if (scmd_channel(req_p) > 1) {
-		req_p->result = 0x00040000;
+		req_p->result = DID_BAD_TARGET << 16;
 		done(req_p);
 #ifdef ED_DBGP
 		printk("atp870u_queuecommand : req_p->device->channel > 1\n");
@@ -649,7 +649,7 @@ static int atp870u_queuecommand_lck(struct scsi_cmnd *req_p,
 	 */
 
 	if ((m & dev->active_id[c]) == 0) {
-		req_p->result = 0x00040000;
+		req_p->result = DID_BAD_TARGET << 16;
 		done(req_p);
 		return 0;
 	}
@@ -684,7 +684,7 @@ static int atp870u_queuecommand_lck(struct scsi_cmnd *req_p,
 		printk("atp870u_queuecommand : dev->quhd[c] == dev->quend[c]\n");
 #endif
 		dev->quend[c]--;
-		req_p->result = 0x00020000;
+		req_p->result = DID_BUS_BUSY << 16;
 		done(req_p);
 		return 0;
 	}
@@ -800,7 +800,7 @@ static void send_s870(struct atp_unit *dev,unsigned char c)
 		if (l > 8)
 			l = 8;
 	}
-	if (workreq->cmnd[0] == 0x00) {
+	if (workreq->cmnd[0] == TEST_UNIT_READY) {
 		l = 0;
 	}
 
@@ -934,22 +934,28 @@ static void send_s870(struct atp_unit *dev,unsigned char c)
 	atp_writeb_pci(dev, c, 2, 0x00);
 	if (is885(dev)) {
 		j = atp_readb_pci(dev, c, 1) & 0xf3;
-		if ((workreq->cmnd[0] == 0x08) || (workreq->cmnd[0] == 0x28) ||
-		    (workreq->cmnd[0] == 0x0a) || (workreq->cmnd[0] == 0x2a)) {
+		if ((workreq->cmnd[0] == READ_6) ||
+		    (workreq->cmnd[0] == READ_10) ||
+		    (workreq->cmnd[0] == WRITE_6) ||
+		    (workreq->cmnd[0] == WRITE_10)) {
 			j |= 0x0c;
 		}
 		atp_writeb_pci(dev, c, 1, j);
 	} else if (is880(dev)) {
-		if ((workreq->cmnd[0] == 0x08) || (workreq->cmnd[0] == 0x28) ||
-		    (workreq->cmnd[0] == 0x0a) || (workreq->cmnd[0] == 0x2a))
+		if ((workreq->cmnd[0] == READ_6) ||
+		    (workreq->cmnd[0] == READ_10) ||
+		    (workreq->cmnd[0] == WRITE_6) ||
+		    (workreq->cmnd[0] == WRITE_10))
 			atp_writeb_base(dev, 0x3b,
 					(atp_readb_base(dev, 0x3b) & 0x3f) | 0xc0);
 		else
 			atp_writeb_base(dev, 0x3b,
 					atp_readb_base(dev, 0x3b) & 0x3f);
 	} else {
-		if ((workreq->cmnd[0] == 0x08) || (workreq->cmnd[0] == 0x28) ||
-		    (workreq->cmnd[0] == 0x0a) || (workreq->cmnd[0] == 0x2a))
+		if ((workreq->cmnd[0] == READ_6) ||
+		    (workreq->cmnd[0] == READ_10) ||
+		    (workreq->cmnd[0] == WRITE_6) ||
+		    (workreq->cmnd[0] == WRITE_10))
 			atp_writeb_base(dev, 0x3a,
 					(atp_readb_base(dev, 0x3a) & 0xf3) | 0x08);
 		else
-- 
2.16.4

