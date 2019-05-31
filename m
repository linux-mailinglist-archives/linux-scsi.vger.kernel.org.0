Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDBA3098F
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 09:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaHmC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 03:42:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaHmB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 03:42:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7AC6ACC4;
        Fri, 31 May 2019 07:41:59 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH RFC] hisi_sas_v3: multiqueue support
Date:   Fri, 31 May 2019 09:41:58 +0200
Message-Id: <20190531074158.76923-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

(Resending due to missing mailing list submission)

Update v3 to support SCSI multiqueue.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 45 +++++++++++++++++-----------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 44 +++++++++++----------------------
 3 files changed, 36 insertions(+), 54 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index fc87994b5d73..4b6f32f60689 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -378,7 +378,6 @@ struct hisi_hba {
 	u32 intr_coal_count;	/* Interrupt count to coalesce */
 
 	int cq_nvecs;
-	unsigned int *reply_map;
 
 	/* debugfs memories */
 	u32 *debugfs_global_reg;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 8a7feb8ed8d6..f4237c4754a4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -200,16 +200,12 @@ static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
 	set_bit(slot_idx, bitmap);
 }
 
-static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
-				     struct scsi_cmnd *scsi_cmnd)
+static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba)
 {
 	int index;
 	void *bitmap = hisi_hba->slot_index_tags;
 	unsigned long flags;
 
-	if (scsi_cmnd)
-		return scsi_cmnd->request->tag;
-
 	spin_lock_irqsave(&hisi_hba->lock, flags);
 	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
 				   hisi_hba->last_slot_index + 1);
@@ -459,6 +455,8 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	struct hisi_sas_dq *dq;
 	unsigned long flags;
 	int wr_q_index;
+	struct scsi_cmnd *scsi_cmnd = NULL;
+	u32 blk_tag = (u32)-1;
 
 	if (DEV_IS_GONE(sas_dev)) {
 		if (sas_dev)
@@ -471,10 +469,22 @@ static int hisi_sas_task_prep(struct sas_task *task,
 		return -ECOMM;
 	}
 
-	if (hisi_hba->reply_map) {
-		int cpu = raw_smp_processor_id();
-		unsigned int dq_index = hisi_hba->reply_map[cpu];
+	if (task->uldd_task) {
+		struct ata_queued_cmd *qc;
+
+		if (dev_is_sata(device)) {
+			qc = task->uldd_task;
+			scsi_cmnd = qc->scsicmd;
+		} else {
+			scsi_cmnd = task->uldd_task;
+		}
+		blk_tag = blk_mq_unique_tag(scsi_cmnd->request);
+	}
+
+	if (hisi_hba->core.shost->nr_hw_queues > 1 && blk_tag != (u32)-1) {
+		unsigned int dq_index;
 
+		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
 		*dq_pointer = dq = &hisi_hba->dq[dq_index];
 	} else {
 		*dq_pointer = dq = sas_dev->dq;
@@ -503,21 +513,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
 
 	if (hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
-	else {
-		struct scsi_cmnd *scsi_cmnd = NULL;
-
-		if (task->uldd_task) {
-			struct ata_queued_cmd *qc;
-
-			if (dev_is_sata(device)) {
-				qc = task->uldd_task;
-				scsi_cmnd = qc->scsicmd;
-			} else {
-				scsi_cmnd = task->uldd_task;
-			}
-		}
-		rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
-	}
+	else if (blk_tag != (u32)-1)
+		rc = blk_mq_unique_tag_to_tag(blk_tag);
+	else
+		rc  = hisi_sas_slot_index_alloc(hisi_hba);
 	if (rc < 0)
 		goto err_out_dif_dma_unmap;
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 49620c2411df..31ddfd32ebc0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2344,30 +2344,6 @@ static irqreturn_t cq_interrupt_v3_hw(int irq_no, void *p)
 	return IRQ_HANDLED;
 }
 
-static void setup_reply_map_v3_hw(struct hisi_hba *hisi_hba, int nvecs)
-{
-	const struct cpumask *mask;
-	int queue, cpu;
-
-	for (queue = 0; queue < nvecs; queue++) {
-		struct hisi_sas_cq *cq = &hisi_hba->cq[queue];
-
-		mask = pci_irq_get_affinity(hisi_hba->pci_dev, queue +
-					    BASE_VECTORS_V3_HW);
-		if (!mask)
-			goto fallback;
-		cq->pci_irq_mask = mask;
-		for_each_cpu(cpu, mask)
-			hisi_hba->reply_map[cpu] = queue;
-	}
-	return;
-
-fallback:
-	for_each_possible_cpu(cpu)
-		hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
-	/* Don't clean all CQ masks */
-}
-
 static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
@@ -2383,11 +2359,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 
 		min_msi = MIN_AFFINE_VECTORS_V3_HW;
 
-		hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
-						   sizeof(unsigned int),
-						   GFP_KERNEL);
-		if (!hisi_hba->reply_map)
-			return -ENOMEM;
 		vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
 							 min_msi, max_msi,
 							 PCI_IRQ_MSI |
@@ -2395,7 +2366,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 							 &desc);
 		if (vectors < 0)
 			return -ENOENT;
-		setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
 	} else {
 		min_msi = max_msi;
 		vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
@@ -2896,6 +2866,18 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
 	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 }
 
+static int hisi_sas_map_queues(struct Scsi_Host *shost)
+{
+	struct hisi_hba *hisi_hba = shost_priv(shost);
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	if (auto_affine_msi_experimental)
+		return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
+				BASE_VECTORS_V3_HW);
+	else
+		return blk_mq_map_queues(qmap);
+}
+
 static struct scsi_host_template sht_v3_hw = {
 	.name			= DRV_NAME,
 	.module			= THIS_MODULE,
@@ -2904,6 +2886,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
+	.map_queues		= hisi_sas_map_queues,
 	.change_queue_depth	= sas_change_queue_depth,
 	.bios_param		= sas_bios_param,
 	.this_id		= -1,
@@ -3067,6 +3050,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		HISI_SAS_RESERVED_IPTT_CNT;
 	shost->cmd_per_lun = hisi_hba->hw->max_command_entries -
 		HISI_SAS_RESERVED_IPTT_CNT;
+	shost->nr_hw_queues = hisi_hba->cq_nvecs;
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = dev;
-- 
2.16.4

