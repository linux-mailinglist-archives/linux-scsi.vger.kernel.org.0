Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C931BF929
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgD3NUU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 09:20:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgD3NUL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 09:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9BC1AF6D;
        Thu, 30 Apr 2020 13:20:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH RFC v3 34/41] pm8001: use libsas-provided domain devices for SATA
Date:   Thu, 30 Apr 2020 15:18:57 +0200
Message-Id: <20200430131904.5847-35-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
References: <20200430131904.5847-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pm8001 driver assumes that libsas does not provide any domain
devices for SATA, which is actually not true.
So use the libsas-provided domain devices for SATA and don't
allocate private ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 14 +-------------
 drivers/scsi/pm8001/pm80xx_hwi.c | 15 +--------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index fb9848e1d481..1c1b87905bea 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1785,7 +1785,7 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
 	struct pm8001_ccb_info *ccb;
 	struct sas_task *task = NULL;
 	struct host_to_dev_fis fis;
-	struct domain_device *dev;
+	struct domain_device *dev = pm8001_ha_dev->sas_device;
 	struct inbound_queue_table *circularQ;
 	u32 opc = OPC_INB_SATA_HOST_OPSTART;
 
@@ -1806,17 +1806,6 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
 		return;
 	}
 
-	/* allocate domain device by ourselves as libsas
-	 * is not going to provide any
-	*/
-	dev = kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
-	if (!dev) {
-		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
-		PM8001_FAIL_DBG(pm8001_ha,
-			pm8001_printk("Domain device cannot be allocated\n"));
-		return;
-	}
 	task->dev = dev;
 	task->dev->lldd_dev = pm8001_ha_dev;
 
@@ -1848,7 +1837,6 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
 	if (res) {
 		sas_free_task(task);
 		pm8001_tag_free(pm8001_ha, ccb_tag);
-		kfree(dev);
 	}
 }
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 4d205ebaee87..e59e72b20b0c 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1809,7 +1809,7 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
 	struct pm8001_ccb_info *ccb;
 	struct sas_task *task = NULL;
 	struct host_to_dev_fis fis;
-	struct domain_device *dev;
+	struct domain_device *dev = pm8001_ha_dev->sas_device;
 	struct inbound_queue_table *circularQ;
 	u32 opc = OPC_INB_SATA_HOST_OPSTART;
 
@@ -1830,18 +1830,6 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
 		return;
 	}
 
-	/* allocate domain device by ourselves as libsas
-	 * is not going to provide any
-	*/
-	dev = kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
-	if (!dev) {
-		sas_free_task(task);
-		pm8001_tag_free(pm8001_ha, ccb_tag);
-		PM8001_FAIL_DBG(pm8001_ha,
-			pm8001_printk("Domain device cannot be allocated\n"));
-		return;
-	}
-
 	task->dev = dev;
 	task->dev->lldd_dev = pm8001_ha_dev;
 
@@ -1875,7 +1863,6 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
 	if (res) {
 		sas_free_task(task);
 		pm8001_tag_free(pm8001_ha, ccb_tag);
-		kfree(dev);
 	}
 }
 
-- 
2.16.4

