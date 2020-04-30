Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2611BF93F
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgD3NUh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 09:20:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgD3NUH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 09:20:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38E86AF2A;
        Thu, 30 Apr 2020 13:20:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH RFC v3 20/41] megaraid_sas: separate out megasas_set_max_sectors()
Date:   Thu, 30 Apr 2020 15:18:43 +0200
Message-Id: <20200430131904.5847-21-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
References: <20200430131904.5847-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Separate out the calculations for setting max_sectors into a
separate function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 55 +++++++++++++++++--------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 43a179fc91f2..00a1d5caf7d5 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5829,6 +5829,36 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 		megasas_set_high_iops_queue_affinity_hint(instance);
 }
 
+static void megasas_set_max_sectors(struct megasas_instance *instance)
+{
+	if (instance->fw_support_ieee)
+		instance->max_sectors_per_req = MEGASAS_MAX_SECTORS_IEEE;
+
+	/*
+	 * Check if the module parameter value for max_sectors can be used
+	 */
+	if (max_sectors && max_sectors < instance->max_sectors_per_req)
+		instance->max_sectors_per_req = max_sectors;
+	else {
+		if (max_sectors) {
+			if (((instance->pdev->device ==
+				PCI_DEVICE_ID_LSI_SAS1078GEN2) ||
+				(instance->pdev->device ==
+				PCI_DEVICE_ID_LSI_SAS0079GEN2)) &&
+				(max_sectors <= MEGASAS_MAX_SECTORS)) {
+				instance->max_sectors_per_req = max_sectors;
+			} else {
+				dev_info(&instance->pdev->dev,
+					 "max_sectors should be > 0 and <= %d"
+					 "(or < 1MB for GEN2 controller)\n",
+					 instance->max_sectors_per_req);
+			}
+		}
+	}
+
+	instance->host->max_sectors = instance->max_sectors_per_req;
+}
+
 /**
  * megasas_init_fw -	Initializes the FW
  * @instance:		Adapter soft state
@@ -6737,31 +6767,8 @@ static int megasas_io_attach(struct megasas_instance *instance)
 	host->can_queue = instance->max_scsi_cmds;
 	host->sg_tablesize = instance->max_num_sge;
 
-	if (instance->fw_support_ieee)
-		instance->max_sectors_per_req = MEGASAS_MAX_SECTORS_IEEE;
-
-	/*
-	 * Check if the module parameter value for max_sectors can be used
-	 */
-	if (max_sectors && max_sectors < instance->max_sectors_per_req)
-		instance->max_sectors_per_req = max_sectors;
-	else {
-		if (max_sectors) {
-			if (((instance->pdev->device ==
-				PCI_DEVICE_ID_LSI_SAS1078GEN2) ||
-				(instance->pdev->device ==
-				PCI_DEVICE_ID_LSI_SAS0079GEN2)) &&
-				(max_sectors <= MEGASAS_MAX_SECTORS)) {
-				instance->max_sectors_per_req = max_sectors;
-			} else {
-			dev_info(&instance->pdev->dev, "max_sectors should be > 0"
-				"and <= %d (or < 1MB for GEN2 controller)\n",
-				instance->max_sectors_per_req);
-			}
-		}
-	}
+	megasas_set_max_sectors(instance);
 
-	host->max_sectors = instance->max_sectors_per_req;
 	host->cmd_per_lun = MEGASAS_DEFAULT_CMD_PER_LUN;
 	host->max_channel = MEGASAS_MAX_CHANNELS - 1;
 	host->max_id = MEGASAS_MAX_DEV_PER_CHANNEL;
-- 
2.16.4

