Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2703624A2F1
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Aug 2020 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgHSPZS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Aug 2020 11:25:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727932AbgHSPZI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 19 Aug 2020 11:25:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 636322665BD9170CBC7F;
        Wed, 19 Aug 2020 23:25:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 23:24:52 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <don.brace@microsemi.com>,
        <kashyap.desai@broadcom.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>, <dgilbert@interlog.com>,
        <paolo.valente@linaro.org>, <hare@suse.de>, <hch@lst.de>
CC:     <sumit.saxena@broadcom.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <megaraidlinux.pdl@broadcom.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v8 14/18] scsi: hisi_sas: Switch v3 hw to MQ
Date:   Wed, 19 Aug 2020 23:20:32 +0800
Message-ID: <1597850436-116171-15-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Now that the block layer provides a shared tag, we can switch the driver
to expose all HW queues.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  3 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 36 ++++++-----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 87 +++++++++++---------------
 3 files changed, 56 insertions(+), 70 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 2bdd64648ef0..e6acbf940712 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -8,6 +8,8 @@
 #define _HISI_SAS_H_
 
 #include <linux/acpi.h>
+#include <linux/blk-mq.h>
+#include <linux/blk-mq-pci.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/dmapool.h>
@@ -431,7 +433,6 @@ struct hisi_hba {
 	u32 intr_coal_count;	/* Interrupt count to coalesce */
 
 	int cq_nvecs;
-	unsigned int *reply_map;
 
 	/* bist */
 	enum sas_linkrate debugfs_bist_linkrate;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 11caa4b0d797..7ed4eaedb7ca 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -417,6 +417,7 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	struct device *dev = hisi_hba->dev;
 	int dlvry_queue_slot, dlvry_queue, rc, slot_idx;
 	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
+	struct scsi_cmnd *scmd = NULL;
 	struct hisi_sas_dq *dq;
 	unsigned long flags;
 	int wr_q_index;
@@ -432,10 +433,23 @@ static int hisi_sas_task_prep(struct sas_task *task,
 		return -ECOMM;
 	}
 
-	if (hisi_hba->reply_map) {
-		int cpu = raw_smp_processor_id();
-		unsigned int dq_index = hisi_hba->reply_map[cpu];
+	if (task->uldd_task) {
+		struct ata_queued_cmd *qc;
 
+		if (dev_is_sata(device)) {
+			qc = task->uldd_task;
+			scmd = qc->scsicmd;
+		} else {
+			scmd = task->uldd_task;
+		}
+	}
+
+	if (scmd) {
+		unsigned int dq_index;
+		u32 blk_tag;
+
+		blk_tag = blk_mq_unique_tag(scmd->request);
+		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
 		*dq_pointer = dq = &hisi_hba->dq[dq_index];
 	} else {
 		*dq_pointer = dq = sas_dev->dq;
@@ -464,21 +478,9 @@ static int hisi_sas_task_prep(struct sas_task *task,
 
 	if (hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
-	else {
-		struct scsi_cmnd *scsi_cmnd = NULL;
-
-		if (task->uldd_task) {
-			struct ata_queued_cmd *qc;
+	else
+		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
 
-			if (dev_is_sata(device)) {
-				qc = task->uldd_task;
-				scsi_cmnd = qc->scsicmd;
-			} else {
-				scsi_cmnd = task->uldd_task;
-			}
-		}
-		rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
-	}
 	if (rc < 0)
 		goto err_out_dif_dma_unmap;
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 60adf5c32143..b6f75a1764df 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2362,68 +2362,36 @@ static irqreturn_t cq_interrupt_v3_hw(int irq_no, void *p)
 	return IRQ_WAKE_THREAD;
 }
 
-static void setup_reply_map_v3_hw(struct hisi_hba *hisi_hba, int nvecs)
+static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
 {
-	const struct cpumask *mask;
-	int queue, cpu;
+	int vectors;
+	int max_msi = HISI_SAS_MSI_COUNT_V3_HW, min_msi;
+	struct Scsi_Host *shost = hisi_hba->shost;
+	struct irq_affinity desc = {
+		.pre_vectors = BASE_VECTORS_V3_HW,
+	};
 
-	for (queue = 0; queue < nvecs; queue++) {
-		struct hisi_sas_cq *cq = &hisi_hba->cq[queue];
+	min_msi = MIN_AFFINE_VECTORS_V3_HW;
+	vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
+						 min_msi, max_msi,
+						 PCI_IRQ_MSI |
+						 PCI_IRQ_AFFINITY,
+						 &desc);
+	if (vectors < 0)
+		return -ENOENT;
 
-		mask = pci_irq_get_affinity(hisi_hba->pci_dev, queue +
-					    BASE_VECTORS_V3_HW);
-		if (!mask)
-			goto fallback;
-		cq->irq_mask = mask;
-		for_each_cpu(cpu, mask)
-			hisi_hba->reply_map[cpu] = queue;
-	}
-	return;
 
-fallback:
-	for_each_possible_cpu(cpu)
-		hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
-	/* Don't clean all CQ masks */
+	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
+	shost->nr_hw_queues = hisi_hba->cq_nvecs;
+
+	return 0;
 }
 
 static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
 	struct pci_dev *pdev = hisi_hba->pci_dev;
-	int vectors, rc, i;
-	int max_msi = HISI_SAS_MSI_COUNT_V3_HW, min_msi;
-
-	if (auto_affine_msi_experimental) {
-		struct irq_affinity desc = {
-			.pre_vectors = BASE_VECTORS_V3_HW,
-		};
-
-		dev_info(dev, "Enable MSI auto-affinity\n");
-
-		min_msi = MIN_AFFINE_VECTORS_V3_HW;
-
-		hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
-						   sizeof(unsigned int),
-						   GFP_KERNEL);
-		if (!hisi_hba->reply_map)
-			return -ENOMEM;
-		vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
-							 min_msi, max_msi,
-							 PCI_IRQ_MSI |
-							 PCI_IRQ_AFFINITY,
-							 &desc);
-		if (vectors < 0)
-			return -ENOENT;
-		setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
-	} else {
-		min_msi = max_msi;
-		vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
-						max_msi, PCI_IRQ_MSI);
-		if (vectors < 0)
-			return vectors;
-	}
-
-	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
+	int rc, i;
 
 	rc = devm_request_irq(dev, pci_irq_vector(pdev, 1),
 			      int_phy_up_down_bcast_v3_hw, 0,
@@ -3072,6 +3040,15 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 	return 0;
 }
 
+static int hisi_sas_map_queues(struct Scsi_Host *shost)
+{
+	struct hisi_hba *hisi_hba = shost_priv(shost);
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
+				     BASE_VECTORS_V3_HW);
+}
+
 static struct scsi_host_template sht_v3_hw = {
 	.name			= DRV_NAME,
 	.proc_name		= DRV_NAME,
@@ -3082,6 +3059,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
+	.map_queues		= hisi_sas_map_queues,
 	.change_queue_depth	= sas_change_queue_depth,
 	.bios_param		= sas_bios_param,
 	.this_id		= -1,
@@ -3098,6 +3076,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.shost_attrs		= host_attrs_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
+	.host_tagset		= 1,
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
@@ -3269,6 +3248,10 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (hisi_sas_debugfs_enable)
 		hisi_sas_debugfs_init(hisi_hba);
 
+	rc = interrupt_preinit_v3_hw(hisi_hba);
+	if (rc)
+		goto err_out_ha;
+	dev_err(dev, "%d hw queues\n", shost->nr_hw_queues);
 	rc = scsi_add_host(shost, dev);
 	if (rc)
 		goto err_out_ha;
-- 
2.26.2

