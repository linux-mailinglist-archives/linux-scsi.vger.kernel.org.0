Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E819546B02
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jun 2022 18:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349892AbiFJQxB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 10 Jun 2022 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349856AbiFJQw5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 10 Jun 2022 12:52:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367D712AEB;
        Fri, 10 Jun 2022 09:52:55 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKRkj5J6lz67KdQ;
        Sat, 11 Jun 2022 00:49:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 18:52:53 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:52:50 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/4] scsi: pm8001: Expose HW queues for pm80xx hw
Date:   Sat, 11 Jun 2022 00:46:42 +0800
Message-ID: <1654879602-33497-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In commit 05c6c029a44d ("scsi: pm80xx: Increase number of supported
queues"), support for 80xx chip was improved by enabling multiple HW
queues.

In this, like other SCSI MQ HBA drivers at the time, the HW queues were
not exposed to upper layer, and instead the driver managed the queues
internally.

However, this management duplicates blk-mq code. In addition, the HW queue
management is sub-optimal for a system where the number of CPUs exceeds
the HW queues - this is because queues are selected in a round-robin
fashion, when it would be better to make adjacent CPUs submit on the same
queue. And finally, the affinity of the completion queue interrupts is not
set to mirror the cpu<->HQ queue mapping, which is suboptimal.

As such, for when MSIX is supported, expose HW queues to upper layer. We
always use queue index #0 for "internal" commands, i.e. anything which
does not come from the block layer, so omit this from the affinity
spreading.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 50 ++++++++++++++++++++++++-------
 drivers/scsi/pm8001/pm8001_sas.h  |  2 ++
 drivers/scsi/pm8001/pm80xx_hwi.c  | 35 +++++++++++++++++-----
 3 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 171f0a2cf2d6..a3a972c2e532 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -81,6 +81,18 @@ LIST_HEAD(hba_list);
 
 struct workqueue_struct *pm8001_wq;
 
+static int pm8001_map_queues(struct Scsi_Host *shost)
+{
+	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
+	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	if (pm8001_ha->number_of_intr > 1)
+		blk_mq_pci_map_queues(qmap, pm8001_ha->pdev, 1);
+
+	return blk_mq_map_queues(qmap);
+}
+
 /*
  * The main structure which LLDD must register for scsi core.
  */
@@ -110,6 +122,7 @@ static struct scsi_host_template pm8001_sht = {
 	.shost_groups		= pm8001_host_groups,
 	.track_queue_depth	= 1,
 	.cmd_per_lun		= 32,
+	.map_queues		= pm8001_map_queues,
 };
 
 /*
@@ -928,31 +941,35 @@ static int pm8001_configure_phy_settings(struct pm8001_hba_info *pm8001_ha)
  */
 static u32 pm8001_setup_msix(struct pm8001_hba_info *pm8001_ha)
 {
-	u32 number_of_intr;
-	int rc, cpu_online_count;
 	unsigned int allocated_irq_vectors;
+	int rc;
 
 	/* SPCv controllers supports 64 msi-x */
 	if (pm8001_ha->chip_id == chip_8001) {
-		number_of_intr = 1;
+		rc = pci_alloc_irq_vectors(pm8001_ha->pdev, 1, 1,
+					   PCI_IRQ_MSIX);
 	} else {
-		number_of_intr = PM8001_MAX_MSIX_VEC;
+		/*
+		 * Queue index #0 is used always for housekeeping, so don't
+		 * include in the affinity spreading.
+		 */
+		struct irq_affinity desc = {
+			.pre_vectors = 1,
+		};
+		rc = pci_alloc_irq_vectors_affinity(
+				pm8001_ha->pdev, 2, PM8001_MAX_MSIX_VEC,
+				PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &desc);
 	}
 
-	cpu_online_count = num_online_cpus();
-	number_of_intr = min_t(int, cpu_online_count, number_of_intr);
-	rc = pci_alloc_irq_vectors(pm8001_ha->pdev, number_of_intr,
-			number_of_intr, PCI_IRQ_MSIX);
 	allocated_irq_vectors = rc;
 	if (rc < 0)
 		return rc;
 
 	/* Assigns the number of interrupts */
-	number_of_intr = min_t(int, allocated_irq_vectors, number_of_intr);
-	pm8001_ha->number_of_intr = number_of_intr;
+	pm8001_ha->number_of_intr = allocated_irq_vectors;
 
 	/* Maximum queue number updating in HBA structure */
-	pm8001_ha->max_q_num = number_of_intr;
+	pm8001_ha->max_q_num = allocated_irq_vectors;
 
 	pm8001_dbg(pm8001_ha, INIT,
 		   "pci_alloc_irq_vectors request ret:%d no of intr %d\n",
@@ -1123,8 +1140,19 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 	if (rc)
 		goto err_out_enable;
 
+
 	PM8001_CHIP_DISP->chip_post_init(pm8001_ha);
 
+	if (pm8001_ha->number_of_intr > 1) {
+		shost->nr_hw_queues = pm8001_ha->number_of_intr - 1;
+		/*
+		 * For now, ensure we're not sent too many commands by setting
+		 * host_tagset. This is also required if we start using request
+		 * tag.
+		 */
+		shost->host_tagset = 1;
+	}
+
 	rc = scsi_add_host(shost, &pdev->dev);
 	if (rc)
 		goto err_out_ha_free;
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index c761a2fd25e5..c5e3f380a01c 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -55,6 +55,8 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/sas_ata.h>
 #include <linux/atomic.h>
+#include <linux/blk-mq.h>
+#include <linux/blk-mq-pci.h>
 #include "pm8001_defs.h"
 
 #define DRV_NAME		"pm80xx"
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index d5cc726c034e..3893f704602e 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4351,6 +4351,29 @@ static int check_enc_sat_cmd(struct sas_task *task)
 	return ret;
 }
 
+static u32 pm80xx_chip_get_q_index(struct sas_task *task)
+{
+	struct scsi_cmnd *scmd = NULL;
+	u32 blk_tag;
+
+	if (task->uldd_task) {
+		struct ata_queued_cmd *qc;
+
+		if (dev_is_sata(task->dev)) {
+			qc = task->uldd_task;
+			scmd = qc->scsicmd;
+		} else {
+			scmd = task->uldd_task;
+		}
+	}
+
+	if (!scmd)
+		return 0;
+
+	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+	return blk_mq_unique_tag_to_hwq(blk_tag);
+}
+
 /**
  * pm80xx_chip_ssp_io_req - send an SSP task to FW
  * @pm8001_ha: our hba card information.
@@ -4366,7 +4389,7 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	u32 tag = ccb->ccb_tag;
 	u64 phys_addr, end_addr;
 	u32 end_addr_high, end_addr_low;
-	u32 q_index, cpu_id;
+	u32 q_index;
 	u32 opc = OPC_INB_SSPINIIOSTART;
 
 	memset(&ssp_cmd, 0, sizeof(ssp_cmd));
@@ -4387,8 +4410,7 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
 		       task->ssp_task.cmd->cmd_len);
-	cpu_id = smp_processor_id();
-	q_index = (u32) (cpu_id) % (pm8001_ha->max_q_num);
+	q_index = pm80xx_chip_get_q_index(task);
 
 	/* Check if encryption is set */
 	if (pm8001_ha->chip->encrypt &&
@@ -4517,8 +4539,7 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 	struct domain_device *dev = task->dev;
 	struct pm8001_device *pm8001_ha_dev = dev->lldd_dev;
 	struct ata_queued_cmd *qc = task->uldd_task;
-	u32 tag = ccb->ccb_tag;
-	u32 q_index, cpu_id;
+	u32 tag = ccb->ccb_tag, q_index;
 	struct sata_start_req sata_cmd;
 	u32 hdr_tag, ncg_tag = 0;
 	u64 phys_addr, end_addr;
@@ -4528,8 +4549,8 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 	unsigned long flags;
 	u32 opc = OPC_INB_SATA_HOST_OPSTART;
 	memset(&sata_cmd, 0, sizeof(sata_cmd));
-	cpu_id = smp_processor_id();
-	q_index = (u32) (cpu_id) % (pm8001_ha->max_q_num);
+
+	q_index = pm80xx_chip_get_q_index(task);
 
 	if (task->data_dir == DMA_NONE && !task->ata_task.use_ncq) {
 		ATAP = 0x04; /* no data*/
-- 
2.26.2

