Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4483E2BA189
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Nov 2020 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgKTEvi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 23:51:38 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52672 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKTEvg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Nov 2020 23:51:36 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id BE34E2A452; Thu, 19 Nov 2020 23:51:35 -0500 (EST)
To:     Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <c1317ae8fdcb498460de5d7ea0bd62a42f5eeca8.1605847196.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] scsi/NCR5380: Reduce NCR5380_maybe_release_dma_irq() call
 sites
Date:   Fri, 20 Nov 2020 15:39:56 +1100
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Refactor to avoid needless calls to NCR5380_maybe_release_dma_irq().
This makes the machine code smaller and the source more readable.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index ea4b5749e7da..d597d7493a62 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -725,7 +725,6 @@ static void NCR5380_main(struct work_struct *work)
 
 			if (!NCR5380_select(instance, cmd)) {
 				dsprintk(NDEBUG_MAIN, instance, "main: select complete\n");
-				maybe_release_dma_irq(instance);
 			} else {
 				dsprintk(NDEBUG_MAIN | NDEBUG_QUEUES, instance,
 				         "main: select failed, returning %p to queue\n", cmd);
@@ -737,8 +736,10 @@ static void NCR5380_main(struct work_struct *work)
 			NCR5380_information_transfer(instance);
 			done = 0;
 		}
-		if (!hostdata->connected)
+		if (!hostdata->connected) {
 			NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
+			maybe_release_dma_irq(instance);
+		}
 		spin_unlock_irq(&hostdata->lock);
 		if (!done)
 			cond_resched();
@@ -1844,7 +1845,6 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					 */
 					NCR5380_write(TARGET_COMMAND_REG, 0);
 
-					maybe_release_dma_irq(instance);
 					return;
 				case MESSAGE_REJECT:
 					/* Accept message by clearing ACK */
@@ -1976,7 +1976,6 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					hostdata->busy[scmd_id(cmd)] &= ~(1 << cmd->device->lun);
 					cmd->result = DID_ERROR << 16;
 					complete_cmd(instance, cmd);
-					maybe_release_dma_irq(instance);
 					return;
 				}
 				msgout = NOP;
@@ -2312,7 +2311,6 @@ static int NCR5380_abort(struct scsi_cmnd *cmd)
 	}
 
 	queue_work(hostdata->work_q, &hostdata->main_task);
-	maybe_release_dma_irq(instance);
 	spin_unlock_irqrestore(&hostdata->lock, flags);
 
 	return result;
@@ -2368,7 +2366,6 @@ static void bus_reset_cleanup(struct Scsi_Host *instance)
 	hostdata->dma_len = 0;
 
 	queue_work(hostdata->work_q, &hostdata->main_task);
-	maybe_release_dma_irq(instance);
 }
 
 /**
-- 
2.26.2

