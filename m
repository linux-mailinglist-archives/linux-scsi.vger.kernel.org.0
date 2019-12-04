Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1816A112DE6
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Dec 2019 15:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfLDO73 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Dec 2019 09:59:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:36332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbfLDO71 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:59:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96A95AF63;
        Wed,  4 Dec 2019 14:59:25 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        Balsundar P <balsundar.p@microchip.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH 03/13] dpt_i2o: use scsi_host_complete_all_commands() to abort outstanding commands
Date:   Wed,  4 Dec 2019 15:59:08 +0100
Message-Id: <20191204145918.143134-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191204145918.143134-1-hare@suse.de>
References: <20191204145918.143134-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Rather than traversing all outstanding commands manually use the
scsi_host_complete_all_commands() helper to terminate all commands during
reset.
With that we can drop the cmd_list usage from the midlayer.

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/dpt_i2o.c | 20 +-------------------
 drivers/scsi/dpti.h    |  1 -
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index c30ace9f251e..ac27323ea135 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -817,7 +817,7 @@ static int adpt_hba_reset(adpt_hba* pHba)
 	}
 	pHba->state &= ~DPTI_STATE_RESET;
 
-	adpt_fail_posted_scbs(pHba);
+	scsi_host_complete_all_commands(pHba->host, DID_RESET);
 	return 0;	/* return success */
 }
 
@@ -2335,7 +2335,6 @@ static s32 adpt_scsi_host_alloc(adpt_hba* pHba, struct scsi_host_template *sht)
 	host->unique_id = (u32)sys_tbl_pa + pHba->unit;
 	host->sg_tablesize = pHba->sg_tablesize;
 	host->can_queue = pHba->post_fifo_size;
-	host->use_cmd_list = 1;
 
 	return 0;
 }
@@ -2646,23 +2645,6 @@ static s32 adpt_i2o_reparse_lct(adpt_hba* pHba)
 	return 0;
 }
 
-static void adpt_fail_posted_scbs(adpt_hba* pHba)
-{
-	struct scsi_cmnd* 	cmd = NULL;
-	struct scsi_device* 	d = NULL;
-
-	shost_for_each_device(d, pHba->host) {
-		unsigned long flags;
-		spin_lock_irqsave(&d->list_lock, flags);
-		list_for_each_entry(cmd, &d->cmd_list, list) {
-			cmd->result = (DID_OK << 16) | (QUEUE_FULL <<1);
-			cmd->scsi_done(cmd);
-		}
-		spin_unlock_irqrestore(&d->list_lock, flags);
-	}
-}
-
-
 /*============================================================================
  *  Routines from i2o subsystem
  *============================================================================
diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
index 3ec391134bb0..72293b8450b6 100644
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -295,7 +295,6 @@ static s32 adpt_i2o_reparse_lct(adpt_hba* pHba);
 static s32 adpt_send_nop(adpt_hba*pHba,u32 m);
 static void adpt_i2o_delete_hba(adpt_hba* pHba);
 static void adpt_inquiry(adpt_hba* pHba);
-static void adpt_fail_posted_scbs(adpt_hba* pHba);
 static struct adpt_device* adpt_find_device(adpt_hba* pHba, u32 chan, u32 id, u64 lun);
 static int adpt_install_hba(struct scsi_host_template* sht, struct pci_dev* pDev) ;
 static int adpt_i2o_online_hba(adpt_hba* pHba);
-- 
2.16.4

