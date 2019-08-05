Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D181DFB
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfHENu1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 09:50:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729623AbfHENu1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 11B0426FC82EBB493845;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:13 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 05/15] scsi: hisi_sas: Snapshot AXI and RAS register at debugfs
Date:   Mon, 5 Aug 2019 21:48:02 +0800
Message-ID: <1565012892-75940-6-git-send-email-john.garry@huawei.com>
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

From: Luo Jiaxing <luojiaxing@huawei.com>

The AXI and RAS register values should also should be snapshot at debugfs.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  12 ++-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 132 ++++++++++++++++++++++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  36 ++++++-
 3 files changed, 162 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 5a2fbbbed53e..fd998d07ffcd 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -259,6 +259,13 @@ struct hisi_sas_iost_itct_cache {
 	u32 data[HISI_SAS_IOST_ITCT_CACHE_DW_SZ];
 };
 
+enum hisi_sas_debugfs_reg_array_member {
+	DEBUGFS_GLOBAL = 0,
+	DEBUGFS_AXI,
+	DEBUGFS_RAS,
+	DEBUGFS_REGS_NUM
+};
+
 enum hisi_sas_debugfs_cache_type {
 	HISI_SAS_ITCT_CACHE,
 	HISI_SAS_IOST_CACHE,
@@ -312,7 +319,7 @@ struct hisi_sas_hw {
 	int complete_hdr_size;
 	struct scsi_host_template *sht;
 
-	const struct hisi_sas_debugfs_reg *debugfs_reg_global;
+	const struct hisi_sas_debugfs_reg *debugfs_reg_array[DEBUGFS_REGS_NUM];
 	const struct hisi_sas_debugfs_reg *debugfs_reg_port;
 };
 
@@ -388,7 +395,8 @@ struct hisi_hba {
 	unsigned int *reply_map;
 
 	/* debugfs memories */
-	u32 *debugfs_global_reg;
+	/* Put Global AXI and RAS Register into register array */
+	u32 *debugfs_regs[DEBUGFS_REGS_NUM];
 	u32 *debugfs_port_reg[HISI_SAS_MAX_PHYS];
 	void *debugfs_complete_hdr[HISI_SAS_MAX_QUEUES];
 	struct hisi_sas_cmd_hdr	*debugfs_cmd_hdr[HISI_SAS_MAX_QUEUES];
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 240b6faaf25f..04b3b0040059 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2752,15 +2752,42 @@ static void hisi_sas_debugfs_snapshot_port_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_global_reg(struct hisi_hba *hisi_hba)
 {
-	u32 *databuf = (u32 *)hisi_hba->debugfs_global_reg;
+	u32 *databuf = hisi_hba->debugfs_regs[DEBUGFS_GLOBAL];
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
 	const struct hisi_sas_debugfs_reg *global =
-		hisi_hba->hw->debugfs_reg_global;
+			hw->debugfs_reg_array[DEBUGFS_GLOBAL];
 	int i;
 
 	for (i = 0; i < global->count; i++, databuf++)
 		*databuf = global->read_global_reg(hisi_hba, 4 * i);
 }
 
+static void hisi_sas_debugfs_snapshot_axi_reg(struct hisi_hba *hisi_hba)
+{
+	u32 *databuf = hisi_hba->debugfs_regs[DEBUGFS_AXI];
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
+	const struct hisi_sas_debugfs_reg *axi =
+			hw->debugfs_reg_array[DEBUGFS_AXI];
+	int i;
+
+	for (i = 0; i < axi->count; i++, databuf++)
+		*databuf = axi->read_global_reg(hisi_hba,
+						4 * i + axi->base_off);
+}
+
+static void hisi_sas_debugfs_snapshot_ras_reg(struct hisi_hba *hisi_hba)
+{
+	u32 *databuf = hisi_hba->debugfs_regs[DEBUGFS_RAS];
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
+	const struct hisi_sas_debugfs_reg *ras =
+			hw->debugfs_reg_array[DEBUGFS_RAS];
+	int i;
+
+	for (i = 0; i < ras->count; i++, databuf++)
+		*databuf = ras->read_global_reg(hisi_hba,
+						4 * i + ras->base_off);
+}
+
 static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
 {
 	void *cachebuf = hisi_hba->debugfs_itct_cache;
@@ -2836,9 +2863,9 @@ static int hisi_sas_debugfs_global_show(struct seq_file *s, void *p)
 {
 	struct hisi_hba *hisi_hba = s->private;
 	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const struct hisi_sas_debugfs_reg *reg_global = hw->debugfs_reg_global;
+	const void *reg_global = hw->debugfs_reg_array[DEBUGFS_GLOBAL];
 
-	hisi_sas_debugfs_print_reg(hisi_hba->debugfs_global_reg,
+	hisi_sas_debugfs_print_reg(hisi_hba->debugfs_regs[DEBUGFS_GLOBAL],
 				   reg_global, s);
 
 	return 0;
@@ -2858,6 +2885,58 @@ static const struct file_operations hisi_sas_debugfs_global_fops = {
 	.owner = THIS_MODULE,
 };
 
+static int hisi_sas_debugfs_axi_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
+	const void *reg_axi = hw->debugfs_reg_array[DEBUGFS_AXI];
+
+	hisi_sas_debugfs_print_reg(hisi_hba->debugfs_regs[DEBUGFS_AXI],
+				   reg_axi, s);
+
+	return 0;
+}
+
+static int hisi_sas_debugfs_axi_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_axi_show,
+			   inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_axi_fops = {
+	.open = hisi_sas_debugfs_axi_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static int hisi_sas_debugfs_ras_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
+	const void *reg_ras = hw->debugfs_reg_array[DEBUGFS_RAS];
+
+	hisi_sas_debugfs_print_reg(hisi_hba->debugfs_regs[DEBUGFS_RAS],
+				   reg_ras, s);
+
+	return 0;
+}
+
+static int hisi_sas_debugfs_ras_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_ras_show,
+			   inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_ras_fops = {
+	.open = hisi_sas_debugfs_ras_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static int hisi_sas_debugfs_port_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_phy *phy = s->private;
@@ -3192,6 +3271,12 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 	debugfs_create_file("itct_cache", 0400, dump_dentry, hisi_hba,
 			    &hisi_sas_debugfs_itct_cache_fops);
 
+	debugfs_create_file("axi", 0400, dump_dentry, hisi_hba,
+			    &hisi_sas_debugfs_axi_fops);
+
+	debugfs_create_file("ras", 0400, dump_dentry, hisi_hba,
+			    &hisi_sas_debugfs_ras_fops);
+
 	return;
 }
 
@@ -3201,6 +3286,8 @@ static void hisi_sas_debugfs_snapshot_regs(struct hisi_hba *hisi_hba)
 
 	hisi_sas_debugfs_snapshot_global_reg(hisi_hba);
 	hisi_sas_debugfs_snapshot_port_reg(hisi_hba);
+	hisi_sas_debugfs_snapshot_axi_reg(hisi_hba);
+	hisi_sas_debugfs_snapshot_ras_reg(hisi_hba);
 	hisi_sas_debugfs_snapshot_cq_reg(hisi_hba);
 	hisi_sas_debugfs_snapshot_dq_reg(hisi_hba);
 	hisi_sas_debugfs_snapshot_itct_reg(hisi_hba);
@@ -3257,6 +3344,7 @@ EXPORT_SYMBOL_GPL(hisi_sas_debugfs_work_handler);
 void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 {
 	int max_command_entries = HISI_SAS_MAX_COMMANDS;
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
 	struct device *dev = hisi_hba->dev;
 	int p, i, c, d;
 	size_t sz;
@@ -3268,16 +3356,14 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 			    hisi_hba,
 			    &hisi_sas_debugfs_trigger_dump_fops);
 
-	/* Alloc buffer for global */
-	sz = hisi_hba->hw->debugfs_reg_global->count * 4;
-	hisi_hba->debugfs_global_reg =
-		devm_kmalloc(dev, sz, GFP_KERNEL);
+	sz = hw->debugfs_reg_array[DEBUGFS_GLOBAL]->count * 4;
+	hisi_hba->debugfs_regs[DEBUGFS_GLOBAL] =
+				devm_kmalloc(dev, sz, GFP_KERNEL);
 
-	if (!hisi_hba->debugfs_global_reg)
+	if (!hisi_hba->debugfs_regs[DEBUGFS_GLOBAL])
 		goto fail_global;
 
-	/* Alloc buffer for port */
-	sz = hisi_hba->hw->debugfs_reg_port->count * 4;
+	sz = hw->debugfs_reg_port->count * 4;
 	for (p = 0; p < hisi_hba->n_phy; p++) {
 		hisi_hba->debugfs_port_reg[p] =
 			devm_kmalloc(dev, sz, GFP_KERNEL);
@@ -3286,8 +3372,21 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 			goto fail_port;
 	}
 
-	/* Alloc buffer for cq */
-	sz = hisi_hba->hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
+	sz = hw->debugfs_reg_array[DEBUGFS_AXI]->count * 4;
+	hisi_hba->debugfs_regs[DEBUGFS_AXI] =
+		devm_kmalloc(dev, sz, GFP_KERNEL);
+
+	if (!hisi_hba->debugfs_regs[DEBUGFS_AXI])
+		goto fail_axi;
+
+	sz = hw->debugfs_reg_array[DEBUGFS_RAS]->count * 4;
+	hisi_hba->debugfs_regs[DEBUGFS_RAS] =
+		devm_kmalloc(dev, sz, GFP_KERNEL);
+
+	if (!hisi_hba->debugfs_regs[DEBUGFS_RAS])
+		goto fail_ras;
+
+	sz = hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
 	for (c = 0; c < hisi_hba->queue_count; c++) {
 		hisi_hba->debugfs_complete_hdr[c] =
 			devm_kmalloc(dev, sz, GFP_KERNEL);
@@ -3296,7 +3395,6 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 			goto fail_cq;
 	}
 
-	/* Alloc buffer for dq */
 	sz = sizeof(struct hisi_sas_cmd_hdr) * HISI_SAS_QUEUE_SLOTS;
 	for (d = 0; d < hisi_hba->queue_count; d++) {
 		hisi_hba->debugfs_cmd_hdr[d] =
@@ -3346,10 +3444,14 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 fail_cq:
 	for (i = 0; i < c; i++)
 		devm_kfree(dev, hisi_hba->debugfs_complete_hdr[i]);
+	devm_kfree(dev, hisi_hba->debugfs_regs[DEBUGFS_RAS]);
+fail_ras:
+	devm_kfree(dev, hisi_hba->debugfs_regs[DEBUGFS_AXI]);
+fail_axi:
 fail_port:
 	for (i = 0; i < p; i++)
 		devm_kfree(dev, hisi_hba->debugfs_port_reg[i]);
-	devm_kfree(dev, hisi_hba->debugfs_global_reg);
+	devm_kfree(dev, hisi_hba->debugfs_regs[DEBUGFS_GLOBAL]);
 fail_global:
 	debugfs_remove_recursive(hisi_hba->debugfs_dir);
 	dev_dbg(dev, "failed to init debugfs!\n");
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index c8ca6ead639b..072a39d5c4ad 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2857,6 +2857,38 @@ static const struct hisi_sas_debugfs_reg debugfs_global_reg = {
 	.read_global_reg = hisi_sas_read32,
 };
 
+static const struct hisi_sas_debugfs_reg_lu debugfs_axi_reg_lu[] = {
+	HISI_SAS_DEBUGFS_REG(AM_CFG_MAX_TRANS),
+	HISI_SAS_DEBUGFS_REG(AM_CFG_SINGLE_PORT_MAX_TRANS),
+	HISI_SAS_DEBUGFS_REG(AXI_CFG),
+	HISI_SAS_DEBUGFS_REG(AM_ROB_ECC_ERR_ADDR),
+	{}
+};
+
+static const struct hisi_sas_debugfs_reg debugfs_axi_reg = {
+	.lu = debugfs_axi_reg_lu,
+	.count = 0x61,
+	.base_off = AXI_MASTER_CFG_BASE,
+	.read_global_reg = hisi_sas_read32,
+};
+
+static const struct hisi_sas_debugfs_reg_lu debugfs_ras_reg_lu[] = {
+	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR1),
+	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR0_MASK),
+	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR1_MASK),
+	HISI_SAS_DEBUGFS_REG(CFG_SAS_RAS_INTR_MASK),
+	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR2),
+	HISI_SAS_DEBUGFS_REG(SAS_RAS_INTR2_MASK),
+	{}
+};
+
+static const struct hisi_sas_debugfs_reg debugfs_ras_reg = {
+	.lu = debugfs_ras_reg_lu,
+	.count = 0x10,
+	.base_off = RAS_BASE,
+	.read_global_reg = hisi_sas_read32,
+};
+
 static void debugfs_snapshot_prepare_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
@@ -2956,7 +2988,9 @@ static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.get_events = phy_get_events_v3_hw,
 	.write_gpio = write_gpio_v3_hw,
 	.wait_cmds_complete_timeout = wait_cmds_complete_timeout_v3_hw,
-	.debugfs_reg_global = &debugfs_global_reg,
+	.debugfs_reg_array[DEBUGFS_GLOBAL] = &debugfs_global_reg,
+	.debugfs_reg_array[DEBUGFS_AXI] = &debugfs_axi_reg,
+	.debugfs_reg_array[DEBUGFS_RAS] = &debugfs_ras_reg,
 	.debugfs_reg_port = &debugfs_port_reg,
 	.snapshot_prepare = debugfs_snapshot_prepare_v3_hw,
 	.snapshot_restore = debugfs_snapshot_restore_v3_hw,
-- 
2.17.1

