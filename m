Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49081DE2
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfHENuW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 09:50:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728904AbfHENuW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 194B87F39B89CBF6CE54;
        Mon,  5 Aug 2019 21:50:19 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:12 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 01/15] scsi: hisi_sas: Make max IPTT count equal for all hw revisions
Date:   Mon, 5 Aug 2019 21:47:58 +0800
Message-ID: <1565012892-75940-2-git-send-email-john.garry@huawei.com>
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

There is a small optimisation to be had by making the max IPTT the
same for all hw revisions, that being we can drop the check for read
and write pointer being the same in the get free slot function.

Change v1 hw to have max IPTT of 4096 - same as v2 and v3 hw - and
drop hisi_sas_hw.max_command_entries.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  6 ++++--
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 30 +++++++++++---------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  3 ---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  7 ++----
 5 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 42a02cc47a60..1fa3e53e857d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -31,7 +31,10 @@
 #define HISI_SAS_MAX_DEVICES HISI_SAS_MAX_ITCT_ENTRIES
 #define HISI_SAS_RESET_BIT	0
 #define HISI_SAS_REJECT_CMD_BIT	1
-#define HISI_SAS_RESERVED_IPTT_CNT  96
+#define HISI_SAS_MAX_COMMANDS (HISI_SAS_QUEUE_SLOTS)
+#define HISI_SAS_RESERVED_IPTT  96
+#define HISI_SAS_UNRESERVED_IPTT \
+	(HISI_SAS_MAX_COMMANDS - HISI_SAS_RESERVED_IPTT)
 
 #define HISI_SAS_STATUS_BUF_SZ (sizeof(struct hisi_sas_status_buffer))
 #define HISI_SAS_COMMAND_TABLE_SZ (sizeof(union hisi_sas_command_table))
@@ -292,7 +295,6 @@ struct hisi_sas_hw {
 					  int delay_ms, int timeout_ms);
 	void (*snapshot_prepare)(struct hisi_hba *hisi_hba);
 	void (*snapshot_restore)(struct hisi_hba *hisi_hba);
-	int max_command_entries;
 	int complete_hdr_size;
 	struct scsi_host_template *sht;
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index cb746cfc2fa8..94c7c2b48b17 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -180,8 +180,8 @@ static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
 {
 	unsigned long flags;
 
-	if (hisi_hba->hw->slot_index_alloc || (slot_idx >=
-	    hisi_hba->hw->max_command_entries - HISI_SAS_RESERVED_IPTT_CNT)) {
+	if (hisi_hba->hw->slot_index_alloc ||
+	    slot_idx >= HISI_SAS_UNRESERVED_IPTT) {
 		spin_lock_irqsave(&hisi_hba->lock, flags);
 		hisi_sas_slot_index_clear(hisi_hba, slot_idx);
 		spin_unlock_irqrestore(&hisi_hba->lock, flags);
@@ -211,8 +211,7 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
 	if (index >= hisi_hba->slot_index_count) {
 		index = find_next_zero_bit(bitmap,
 				hisi_hba->slot_index_count,
-				hisi_hba->hw->max_command_entries -
-				HISI_SAS_RESERVED_IPTT_CNT);
+				HISI_SAS_UNRESERVED_IPTT);
 		if (index >= hisi_hba->slot_index_count) {
 			spin_unlock_irqrestore(&hisi_hba->lock, flags);
 			return -SAS_QUEUE_FULL;
@@ -2291,7 +2290,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 
 void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
 {
-	int i, s, j, max_command_entries = hisi_hba->hw->max_command_entries;
+	int i, s, j, max_command_entries = HISI_SAS_MAX_COMMANDS;
 	struct hisi_sas_breakpoint *sata_breakpoint = hisi_hba->sata_breakpoint;
 
 	for (i = 0; i < hisi_hba->queue_count; i++) {
@@ -2328,7 +2327,7 @@ EXPORT_SYMBOL_GPL(hisi_sas_init_mem);
 int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
-	int i, j, s, max_command_entries = hisi_hba->hw->max_command_entries;
+	int i, j, s, max_command_entries = HISI_SAS_MAX_COMMANDS;
 	int max_command_entries_ru, sz_slot_buf_ru;
 	int blk_cnt, slots_per_blk;
 
@@ -2458,8 +2457,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 	hisi_sas_init_mem(hisi_hba);
 
 	hisi_sas_slot_index_init(hisi_hba);
-	hisi_hba->last_slot_index = hisi_hba->hw->max_command_entries -
-		HISI_SAS_RESERVED_IPTT_CNT;
+	hisi_hba->last_slot_index = HISI_SAS_UNRESERVED_IPTT;
 
 	hisi_hba->wq = create_singlethread_workqueue(dev_name(dev));
 	if (!hisi_hba->wq) {
@@ -2672,13 +2670,11 @@ int hisi_sas_probe(struct platform_device *pdev,
 	shost->max_channel = 1;
 	shost->max_cmd_len = 16;
 	if (hisi_hba->hw->slot_index_alloc) {
-		shost->can_queue = hisi_hba->hw->max_command_entries;
-		shost->cmd_per_lun = hisi_hba->hw->max_command_entries;
+		shost->can_queue = HISI_SAS_MAX_COMMANDS;
+		shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
 	} else {
-		shost->can_queue = hisi_hba->hw->max_command_entries -
-			HISI_SAS_RESERVED_IPTT_CNT;
-		shost->cmd_per_lun = hisi_hba->hw->max_command_entries -
-			HISI_SAS_RESERVED_IPTT_CNT;
+		shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
+		shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
 	}
 
 	sha->sas_ha_name = DRV_NAME;
@@ -2794,7 +2790,7 @@ static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_iost_reg(struct hisi_hba *hisi_hba)
 {
-	int max_command_entries = hisi_hba->hw->max_command_entries;
+	int max_command_entries = HISI_SAS_MAX_COMMANDS;
 	void *databuf = hisi_hba->debugfs_iost;
 	struct hisi_sas_iost *iost;
 	int i;
@@ -3008,7 +3004,7 @@ static int hisi_sas_debugfs_iost_show(struct seq_file *s, void *p)
 {
 	struct hisi_hba *hisi_hba = s->private;
 	struct hisi_sas_iost *debugfs_iost = hisi_hba->debugfs_iost;
-	int i, ret, max_command_entries = hisi_hba->hw->max_command_entries;
+	int i, ret, max_command_entries = HISI_SAS_MAX_COMMANDS;
 	__le64 *iost = &debugfs_iost->qw0;
 
 	for (i = 0; i < max_command_entries; i++, debugfs_iost++) {
@@ -3177,7 +3173,7 @@ EXPORT_SYMBOL_GPL(hisi_sas_debugfs_work_handler);
 
 void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 {
-	int max_command_entries = hisi_hba->hw->max_command_entries;
+	int max_command_entries = HISI_SAS_MAX_COMMANDS;
 	struct device *dev = hisi_hba->dev;
 	int p, i, c, d;
 	size_t sz;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3912216e8a4f..afdbaccbbc5e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -401,8 +401,6 @@ enum {
 	TRANS_RX_SMP_RESP_TIMEOUT_ERR, /* 0x31a */
 };
 
-#define HISI_SAS_COMMAND_ENTRIES_V1_HW 8192
-
 #define HISI_SAS_PHY_MAX_INT_NR (HISI_SAS_PHY_INT_NR * HISI_SAS_MAX_PHYS)
 #define HISI_SAS_CQ_MAX_INT_NR (HISI_SAS_MAX_QUEUES)
 #define HISI_SAS_FATAL_INT_NR (2)
@@ -1830,7 +1828,6 @@ static const struct hisi_sas_hw hisi_sas_v1_hw = {
 	.phy_set_linkrate = phy_set_linkrate_v1_hw,
 	.phy_get_max_linkrate = phy_get_max_linkrate_v1_hw,
 	.get_wideport_bitmap = get_wideport_bitmap_v1_hw,
-	.max_command_entries = HISI_SAS_COMMAND_ENTRIES_V1_HW,
 	.complete_hdr_size = sizeof(struct hisi_sas_complete_v1_hdr),
 	.sht = &sht_v1_hw,
 };
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index e9b15d45f98f..fc98bd9e5588 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3616,7 +3616,6 @@ static const struct hisi_sas_hw hisi_sas_v2_hw = {
 	.get_events = phy_get_events_v2_hw,
 	.phy_set_linkrate = phy_set_linkrate_v2_hw,
 	.phy_get_max_linkrate = phy_get_max_linkrate_v2_hw,
-	.max_command_entries = HISI_SAS_COMMAND_ENTRIES_V2_HW,
 	.complete_hdr_size = sizeof(struct hisi_sas_complete_v2_hdr),
 	.soft_reset = soft_reset_v2_hw,
 	.get_phys_state = get_phys_state_v2_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 5f0f6df11adf..0171cdb4da81 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2935,7 +2935,6 @@ static struct scsi_host_template sht_v3_hw = {
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.hw_init = hisi_sas_v3_init,
 	.setup_itct = setup_itct_v3_hw,
-	.max_command_entries = HISI_SAS_COMMAND_ENTRIES_V3_HW,
 	.get_wideport_bitmap = get_wideport_bitmap_v3_hw,
 	.complete_hdr_size = sizeof(struct hisi_sas_complete_v3_hdr),
 	.clear_itct = clear_itct_v3_hw,
@@ -3076,10 +3075,8 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_lun = ~0;
 	shost->max_channel = 1;
 	shost->max_cmd_len = 16;
-	shost->can_queue = hisi_hba->hw->max_command_entries -
-		HISI_SAS_RESERVED_IPTT_CNT;
-	shost->cmd_per_lun = hisi_hba->hw->max_command_entries -
-		HISI_SAS_RESERVED_IPTT_CNT;
+	shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
+	shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = dev;
-- 
2.17.1

