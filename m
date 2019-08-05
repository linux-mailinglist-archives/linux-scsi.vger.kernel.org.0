Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A381EAB
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfHEOGR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 10:06:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728894AbfHEOGQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 10:06:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF29D6B9D0210462AC61;
        Mon,  5 Aug 2019 21:50:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:12 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 02/15] scsi: hisi_sas: Drop hisi_sas_hw.get_free_slot
Date:   Mon, 5 Aug 2019 21:47:59 +0800
Message-ID: <1565012892-75940-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
References: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In commit 1273d65f29045 ("scsi: hisi_sas: change queue depth from 512 to
4096"), the depth of each queue is the same as the max IPTT in the
system.

As such, as long as we have an IPTT allocated, we will have enough space
on any delivery queue.

All .get_free_slot functions were checking for space on the queue by
reading the DQ read pointer. Drop this, and also raise the code into
common code, as there is nothing hw specific remaining.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 27 ++++++---------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 32 -------------------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 26 --------------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 33 --------------------------
 5 files changed, 7 insertions(+), 112 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 1fa3e53e857d..c1b56b482a23 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -260,7 +260,6 @@ struct hisi_sas_hw {
 				struct domain_device *device);
 	struct hisi_sas_device *(*alloc_dev)(struct domain_device *device);
 	void (*sl_notify_ssp)(struct hisi_hba *hisi_hba, int phy_no);
-	int (*get_free_slot)(struct hisi_hba *hisi_hba, struct hisi_sas_dq *dq);
 	void (*start_delivery)(struct hisi_sas_dq *dq);
 	void (*prep_ssp)(struct hisi_hba *hisi_hba,
 			struct hisi_sas_slot *slot);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 94c7c2b48b17..54bbab7151c7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -519,13 +519,8 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	slot = &hisi_hba->slot_info[slot_idx];
 
 	spin_lock_irqsave(&dq->lock, flags);
-	wr_q_index = hisi_hba->hw->get_free_slot(hisi_hba, dq);
-	if (wr_q_index < 0) {
-		spin_unlock_irqrestore(&dq->lock, flags);
-		rc = -EAGAIN;
-		goto err_out_tag;
-	}
-
+	wr_q_index = dq->wr_point;
+	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
 	list_add_tail(&slot->delivery, &dq->list);
 	spin_unlock_irqrestore(&dq->lock, flags);
 	spin_lock_irqsave(&sas_dev->lock, flags);
@@ -579,8 +574,6 @@ static int hisi_sas_task_prep(struct sas_task *task,
 
 	return 0;
 
-err_out_tag:
-	hisi_sas_slot_index_free(hisi_hba, slot_idx);
 err_out_dif_dma_unmap:
 	if (!sas_protocol_ata(task->task_proto))
 		hisi_sas_dif_dma_unmap(hisi_hba, task, n_elem_dif);
@@ -1963,7 +1956,7 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_cmd_hdr *cmd_hdr_base;
 	int dlvry_queue_slot, dlvry_queue, n_elem = 0, rc, slot_idx;
-	unsigned long flags, flags_dq = 0;
+	unsigned long flags;
 	int wr_q_index;
 
 	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
@@ -1982,15 +1975,11 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	slot_idx = rc;
 	slot = &hisi_hba->slot_info[slot_idx];
 
-	spin_lock_irqsave(&dq->lock, flags_dq);
-	wr_q_index = hisi_hba->hw->get_free_slot(hisi_hba, dq);
-	if (wr_q_index < 0) {
-		spin_unlock_irqrestore(&dq->lock, flags_dq);
-		rc = -EAGAIN;
-		goto err_out_tag;
-	}
+	spin_lock_irqsave(&dq->lock, flags);
+	wr_q_index = dq->wr_point;
+	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
 	list_add_tail(&slot->delivery, &dq->list);
-	spin_unlock_irqrestore(&dq->lock, flags_dq);
+	spin_unlock_irqrestore(&dq->lock, flags);
 	spin_lock_irqsave(&sas_dev->lock, flags);
 	list_add_tail(&slot->entry, &sas_dev->list);
 	spin_unlock_irqrestore(&sas_dev->lock, flags);
@@ -2027,8 +2016,6 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 
 	return 0;
 
-err_out_tag:
-	hisi_sas_slot_index_free(hisi_hba, slot_idx);
 err_out:
 	dev_err(dev, "internal abort task prep: failed[%d]!\n", rc);
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index afdbaccbbc5e..b13cbc64d2a9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -416,13 +416,6 @@ static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 	return readl(regs);
 }
 
-static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl_relaxed(regs);
-}
-
 static void hisi_sas_write32(struct hisi_hba *hisi_hba,
 				    u32 off, u32 val)
 {
@@ -864,30 +857,6 @@ static int get_wideport_bitmap_v1_hw(struct hisi_hba *hisi_hba, int port_id)
 	return bitmap;
 }
 
-/*
- * The callpath to this function and upto writing the write
- * queue pointer should be safe from interruption.
- */
-static int
-get_free_slot_v1_hw(struct hisi_hba *hisi_hba, struct hisi_sas_dq *dq)
-{
-	struct device *dev = hisi_hba->dev;
-	int queue = dq->id;
-	u32 r, w;
-
-	w = dq->wr_point;
-	r = hisi_sas_read32_relaxed(hisi_hba,
-				DLVRY_Q_0_RD_PTR + (queue * 0x14));
-	if (r == (w+1) % HISI_SAS_QUEUE_SLOTS) {
-		dev_warn(dev, "could not find free slot\n");
-		return -EAGAIN;
-	}
-
-	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
-
-	return w;
-}
-
 /* DQ lock must be taken here */
 static void start_delivery_v1_hw(struct hisi_sas_dq *dq)
 {
@@ -1818,7 +1787,6 @@ static const struct hisi_sas_hw hisi_sas_v1_hw = {
 	.clear_itct = clear_itct_v1_hw,
 	.prep_smp = prep_smp_v1_hw,
 	.prep_ssp = prep_ssp_v1_hw,
-	.get_free_slot = get_free_slot_v1_hw,
 	.start_delivery = start_delivery_v1_hw,
 	.slot_complete = slot_complete_v1_hw,
 	.phys_init = phys_init_v1_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index fc98bd9e5588..de33e31cd88a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1637,31 +1637,6 @@ static int get_wideport_bitmap_v2_hw(struct hisi_hba *hisi_hba, int port_id)
 	return bitmap;
 }
 
-/*
- * The callpath to this function and upto writing the write
- * queue pointer should be safe from interruption.
- */
-static int
-get_free_slot_v2_hw(struct hisi_hba *hisi_hba, struct hisi_sas_dq *dq)
-{
-	struct device *dev = hisi_hba->dev;
-	int queue = dq->id;
-	u32 r, w;
-
-	w = dq->wr_point;
-	r = hisi_sas_read32_relaxed(hisi_hba,
-				DLVRY_Q_0_RD_PTR + (queue * 0x14));
-	if (r == (w+1) % HISI_SAS_QUEUE_SLOTS) {
-		dev_warn(dev, "full queue=%d r=%d w=%d\n",
-				queue, r, w);
-		return -EAGAIN;
-	}
-
-	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
-
-	return w;
-}
-
 /* DQ lock must be taken here */
 static void start_delivery_v2_hw(struct hisi_sas_dq *dq)
 {
@@ -3606,7 +3581,6 @@ static const struct hisi_sas_hw hisi_sas_v2_hw = {
 	.prep_ssp = prep_ssp_v2_hw,
 	.prep_stp = prep_ata_v2_hw,
 	.prep_abort = prep_abort_v2_hw,
-	.get_free_slot = get_free_slot_v2_hw,
 	.start_delivery = start_delivery_v2_hw,
 	.slot_complete = slot_complete_v2_hw,
 	.phys_init = phys_init_v2_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0171cdb4da81..b99abc788487 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -499,13 +499,6 @@ static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 	return readl(regs);
 }
 
-static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl_relaxed(regs);
-}
-
 static void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val)
 {
 	void __iomem *regs = hisi_hba->regs + off;
@@ -1006,31 +999,6 @@ static int get_wideport_bitmap_v3_hw(struct hisi_hba *hisi_hba, int port_id)
 	return bitmap;
 }
 
-/**
- * The callpath to this function and upto writing the write
- * queue pointer should be safe from interruption.
- */
-static int
-get_free_slot_v3_hw(struct hisi_hba *hisi_hba, struct hisi_sas_dq *dq)
-{
-	struct device *dev = hisi_hba->dev;
-	int queue = dq->id;
-	u32 r, w;
-
-	w = dq->wr_point;
-	r = hisi_sas_read32_relaxed(hisi_hba,
-				DLVRY_Q_0_RD_PTR + (queue * 0x14));
-	if (r == (w+1) % HISI_SAS_QUEUE_SLOTS) {
-		dev_warn(dev, "full queue=%d r=%d w=%d\n",
-			 queue, r, w);
-		return -EAGAIN;
-	}
-
-	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
-
-	return w;
-}
-
 static void start_delivery_v3_hw(struct hisi_sas_dq *dq)
 {
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
@@ -2943,7 +2911,6 @@ static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.prep_smp = prep_smp_v3_hw,
 	.prep_stp = prep_ata_v3_hw,
 	.prep_abort = prep_abort_v3_hw,
-	.get_free_slot = get_free_slot_v3_hw,
 	.start_delivery = start_delivery_v3_hw,
 	.slot_complete = slot_complete_v3_hw,
 	.phys_init = phys_init_v3_hw,
-- 
2.17.1

