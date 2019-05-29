Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0DE2DE25
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfE2N3O (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfE2N3N (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0ACDB019;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 23/24] dpt_i2o: drop cmd_list usage
Date:   Wed, 29 May 2019 15:29:00 +0200
Message-Id: <20190529132901.27645-24-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Now each command has a unique tag, so we can drop the legacy 'cmd_list'
usage and rely on the tag to identify the command.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/dpt_i2o.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index a3afd1478ab6..f66d1641685c 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -2338,7 +2338,6 @@ static s32 adpt_scsi_host_alloc(adpt_hba* pHba, struct scsi_host_template *sht)
 	host->unique_id = (u32)sys_tbl_pa + pHba->unit;
 	host->sg_tablesize = pHba->sg_tablesize;
 	host->can_queue = pHba->post_fifo_size;
-	host->use_cmd_list = 1;
 
 	return 0;
 }
@@ -2650,20 +2649,18 @@ static s32 adpt_i2o_reparse_lct(adpt_hba* pHba)
 	return 0;
 }
 
-static void adpt_fail_posted_scbs(adpt_hba* pHba)
+static bool adpt_fail_posted_scbs_iter(struct request *req, void *data, bool reserved)
 {
-	struct scsi_cmnd* 	cmd = NULL;
-	struct scsi_device* 	d = NULL;
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 
-	shost_for_each_device(d, pHba->host) {
-		unsigned long flags;
-		spin_lock_irqsave(&d->list_lock, flags);
-		list_for_each_entry(cmd, &d->cmd_list, list) {
-			cmd->result = (DID_OK << 16) | (QUEUE_FULL <<1);
-			cmd->scsi_done(cmd);
-		}
-		spin_unlock_irqrestore(&d->list_lock, flags);
-	}
+	cmd->result = (DID_OK << 16) | (QUEUE_FULL <<1);
+	cmd->scsi_done(cmd);
+	return true;
+}
+
+static void adpt_fail_posted_scbs(adpt_hba* pHba)
+{
+	blk_mq_tagset_busy_iter(&pHba->host->tag_set, adpt_fail_posted_scbs_iter, NULL);
 }
 
 
-- 
2.16.4

