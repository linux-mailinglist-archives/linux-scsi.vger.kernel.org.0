Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15115BFFA
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2020 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgBMOF3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Feb 2020 09:05:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgBMOF3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Feb 2020 09:05:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E1A0AF8A;
        Thu, 13 Feb 2020 14:05:27 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/13] aacraid: move scsi_(block,unblock)_requests out of _aac_reset_adapter()
Date:   Thu, 13 Feb 2020 15:04:16 +0100
Message-Id: <20200213140422.128382-8-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213140422.128382-1-hare@suse.de>
References: <20200213140422.128382-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

_aac_reset_adapter() only has one caller, and that one already calls
scsi_block_requests(). So move the calls out of _aac_reset_adapter()
to avoid calling scsi_block_requests() twice.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Acked-by: Balsundar P < Balsundar.P@microchip.com>
---
 drivers/scsi/aacraid/commsup.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 8736a540a048..0d8c1ee40759 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1476,7 +1476,7 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 {
 	int index, quirks;
 	int retval;
-	struct Scsi_Host *host;
+	struct Scsi_Host *host = aac->scsi_host_ptr;
 	struct scsi_device *dev;
 	int jafo = 0;
 	int bled;
@@ -1493,8 +1493,6 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 	 *	- The card is dead, or will be very shortly ;-/ so no new
 	 *	  commands are completing in the interrupt service.
 	 */
-	host = aac->scsi_host_ptr;
-	scsi_block_requests(host);
 	aac_adapter_disable_int(aac);
 	if (aac->thread && aac->thread->pid != current->pid) {
 		spin_unlock_irq(host->host_lock);
@@ -1619,7 +1617,6 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 
 out:
 	aac->in_reset = 0;
-	scsi_unblock_requests(host);
 
 	/*
 	 * Issue bus rescan to catch any configuration that might have
@@ -1640,7 +1637,7 @@ int aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 {
 	unsigned long flagv = 0;
 	int retval;
-	struct Scsi_Host * host;
+	struct Scsi_Host * host = aac->scsi_host_ptr;
 	int bled;
 
 	if (spin_trylock_irqsave(&aac->fib_lock, flagv) == 0)
@@ -1658,7 +1655,6 @@ int aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 	 * target (block maximum 60 seconds). Although not necessary,
 	 * it does make us a good storage citizen.
 	 */
-	host = aac->scsi_host_ptr;
 	scsi_block_requests(host);
 
 	/* Quiesce build, flush cache, write through mode */
@@ -1670,6 +1666,8 @@ int aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 	retval = _aac_reset_adapter(aac, bled, reset_type);
 	spin_unlock_irqrestore(host->host_lock, flagv);
 
+	scsi_unblock_requests(host);
+
 	if ((forced < 2) && (retval == -ENODEV)) {
 		/* Unwind aac_send_shutdown() IOP_RESET unsupported/disabled */
 		struct fib * fibctx = aac_fib_alloc(aac);
-- 
2.16.4

