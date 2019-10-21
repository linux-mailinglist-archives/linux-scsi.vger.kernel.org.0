Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E7DF2F4
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 18:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfJUQZd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 12:25:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbfJUQZd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 12:25:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E4D28CD12A34CCC4AF9;
        Tue, 22 Oct 2019 00:25:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 22 Oct 2019 00:25:21 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 16/18] scsi: hisi_sas: Add ability to have multiple debugfs dumps
Date:   Tue, 22 Oct 2019 00:22:13 +0800
Message-ID: <1571674935-108326-17-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1571674935-108326-1-git-send-email-john.garry@huawei.com>
References: <1571674935-108326-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

We use the module parameter debugfs_dump_count to manage the upper limit
of the memory block for multiple dumps.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      |  5 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c | 73 ++++++++++++++++-----------
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index bdd4aa7ed730..72823222e08f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -451,12 +451,11 @@ struct hisi_hba {
 	struct hisi_sas_debugfs_iost_cache debugfs_iost_cache[HISI_SAS_MAX_DEBUGFS_DUMP];
 	struct hisi_sas_debugfs_itct_cache debugfs_itct_cache[HISI_SAS_MAX_DEBUGFS_DUMP];
 
-	u64 debugfs_timestamp;
-
+	u64 debugfs_timestamp[HISI_SAS_MAX_DEBUGFS_DUMP];
+	int debugfs_dump_index;
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_dump_dentry;
 	struct dentry *debugfs_bist_dentry;
-	bool debugfs_snapshot;
 };
 
 /* Generic HW DMA host memory structures */
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 57723b0fc025..f6ee8db6298f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2697,10 +2697,11 @@ struct dentry *hisi_sas_debugfs_dir;
 static void hisi_sas_debugfs_snapshot_cq_reg(struct hisi_hba *hisi_hba)
 {
 	int queue_entry_size = hisi_hba->hw->complete_hdr_size;
+	int dump_index = hisi_hba->debugfs_dump_index;
 	int i;
 
 	for (i = 0; i < hisi_hba->queue_count; i++)
-		memcpy(hisi_hba->debugfs_cq[0][i].complete_hdr,
+		memcpy(hisi_hba->debugfs_cq[dump_index][i].complete_hdr,
 		       hisi_hba->complete_hdr[i],
 		       HISI_SAS_QUEUE_SLOTS * queue_entry_size);
 }
@@ -2708,13 +2709,14 @@ static void hisi_sas_debugfs_snapshot_cq_reg(struct hisi_hba *hisi_hba)
 static void hisi_sas_debugfs_snapshot_dq_reg(struct hisi_hba *hisi_hba)
 {
 	int queue_entry_size = sizeof(struct hisi_sas_cmd_hdr);
+	int dump_index = hisi_hba->debugfs_dump_index;
 	int i;
 
 	for (i = 0; i < hisi_hba->queue_count; i++) {
 		struct hisi_sas_cmd_hdr *debugfs_cmd_hdr, *cmd_hdr;
 		int j;
 
-		debugfs_cmd_hdr = hisi_hba->debugfs_dq[0][i].hdr;
+		debugfs_cmd_hdr = hisi_hba->debugfs_dq[dump_index][i].hdr;
 		cmd_hdr = hisi_hba->cmd_hdr[i];
 
 		for (j = 0; j < HISI_SAS_QUEUE_SLOTS; j++)
@@ -2725,6 +2727,7 @@ static void hisi_sas_debugfs_snapshot_dq_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_port_reg(struct hisi_hba *hisi_hba)
 {
+	int dump_index = hisi_hba->debugfs_dump_index;
 	const struct hisi_sas_debugfs_reg *port =
 		hisi_hba->hw->debugfs_reg_port;
 	int i, phy_cnt;
@@ -2732,7 +2735,7 @@ static void hisi_sas_debugfs_snapshot_port_reg(struct hisi_hba *hisi_hba)
 	u32 *databuf;
 
 	for (phy_cnt = 0; phy_cnt < hisi_hba->n_phy; phy_cnt++) {
-		databuf = hisi_hba->debugfs_port_reg[0][phy_cnt].data;
+		databuf = hisi_hba->debugfs_port_reg[dump_index][phy_cnt].data;
 		for (i = 0; i < port->count; i++, databuf++) {
 			offset = port->base_off + 4 * i;
 			*databuf = port->read_port_reg(hisi_hba, phy_cnt,
@@ -2743,7 +2746,8 @@ static void hisi_sas_debugfs_snapshot_port_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_global_reg(struct hisi_hba *hisi_hba)
 {
-	u32 *databuf = hisi_hba->debugfs_regs[0][DEBUGFS_GLOBAL].data;
+	int dump_index = hisi_hba->debugfs_dump_index;
+	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_GLOBAL].data;
 	const struct hisi_sas_hw *hw = hisi_hba->hw;
 	const struct hisi_sas_debugfs_reg *global =
 			hw->debugfs_reg_array[DEBUGFS_GLOBAL];
@@ -2755,7 +2759,8 @@ static void hisi_sas_debugfs_snapshot_global_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_axi_reg(struct hisi_hba *hisi_hba)
 {
-	u32 *databuf = hisi_hba->debugfs_regs[0][DEBUGFS_AXI].data;
+	int dump_index = hisi_hba->debugfs_dump_index;
+	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_AXI].data;
 	const struct hisi_sas_hw *hw = hisi_hba->hw;
 	const struct hisi_sas_debugfs_reg *axi =
 			hw->debugfs_reg_array[DEBUGFS_AXI];
@@ -2768,7 +2773,8 @@ static void hisi_sas_debugfs_snapshot_axi_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_ras_reg(struct hisi_hba *hisi_hba)
 {
-	u32 *databuf = hisi_hba->debugfs_regs[0][DEBUGFS_RAS].data;
+	int dump_index = hisi_hba->debugfs_dump_index;
+	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_RAS].data;
 	const struct hisi_sas_hw *hw = hisi_hba->hw;
 	const struct hisi_sas_debugfs_reg *ras =
 			hw->debugfs_reg_array[DEBUGFS_RAS];
@@ -2781,8 +2787,9 @@ static void hisi_sas_debugfs_snapshot_ras_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
 {
-	void *cachebuf = hisi_hba->debugfs_itct_cache[0].cache;
-	void *databuf = hisi_hba->debugfs_itct[0].itct;
+	int dump_index = hisi_hba->debugfs_dump_index;
+	void *cachebuf = hisi_hba->debugfs_itct_cache[dump_index].cache;
+	void *databuf = hisi_hba->debugfs_itct[dump_index].itct;
 	struct hisi_sas_itct *itct;
 	int i;
 
@@ -2799,9 +2806,10 @@ static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_iost_reg(struct hisi_hba *hisi_hba)
 {
+	int dump_index = hisi_hba->debugfs_dump_index;
 	int max_command_entries = HISI_SAS_MAX_COMMANDS;
-	void *cachebuf = hisi_hba->debugfs_iost_cache[0].cache;
-	void *databuf = hisi_hba->debugfs_iost[0].iost;
+	void *cachebuf = hisi_hba->debugfs_iost_cache[dump_index].cache;
+	void *databuf = hisi_hba->debugfs_iost[dump_index].iost;
 	struct hisi_sas_iost *iost;
 	int i;
 
@@ -3195,6 +3203,7 @@ static const struct file_operations hisi_sas_debugfs_itct_cache_fops = {
 static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 {
 	u64 *debugfs_timestamp;
+	int dump_index = hisi_hba->debugfs_dump_index;
 	struct dentry *dump_dentry;
 	struct dentry *dentry;
 	char name[256];
@@ -3202,17 +3211,18 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 	int c;
 	int d;
 
-	debugfs_timestamp = &hisi_hba->debugfs_timestamp;
-	/* Create dump dir inside device dir */
-	dump_dentry = debugfs_create_dir("dump", hisi_hba->debugfs_dir);
-	hisi_hba->debugfs_dump_dentry = dump_dentry;
+	snprintf(name, 256, "%d", dump_index);
+
+	dump_dentry = debugfs_create_dir(name, hisi_hba->debugfs_dump_dentry);
+
+	debugfs_timestamp = &hisi_hba->debugfs_timestamp[dump_index];
 
 	debugfs_create_u64("timestamp", 0400, dump_dentry,
 			   debugfs_timestamp);
 
 	debugfs_create_file("global", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[0][DEBUGFS_GLOBAL],
-			    &hisi_sas_debugfs_global_fops);
+			   &hisi_hba->debugfs_regs[dump_index][DEBUGFS_GLOBAL],
+			   &hisi_sas_debugfs_global_fops);
 
 	/* Create port dir and files */
 	dentry = debugfs_create_dir("port", dump_dentry);
@@ -3220,7 +3230,7 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", p);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_port_reg[0][p],
+				    &hisi_hba->debugfs_port_reg[dump_index][p],
 				    &hisi_sas_debugfs_port_fops);
 	}
 
@@ -3230,7 +3240,7 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", c);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_cq[0][c],
+				    &hisi_hba->debugfs_cq[dump_index][c],
 				    &hisi_sas_debugfs_cq_fops);
 	}
 
@@ -3240,32 +3250,32 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", d);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_dq[0][d],
+				    &hisi_hba->debugfs_dq[dump_index][d],
 				    &hisi_sas_debugfs_dq_fops);
 	}
 
 	debugfs_create_file("iost", 0400, dump_dentry,
-			    &hisi_hba->debugfs_iost[0],
+			    &hisi_hba->debugfs_iost[dump_index],
 			    &hisi_sas_debugfs_iost_fops);
 
 	debugfs_create_file("iost_cache", 0400, dump_dentry,
-			    &hisi_hba->debugfs_iost_cache[0],
+			    &hisi_hba->debugfs_iost_cache[dump_index],
 			    &hisi_sas_debugfs_iost_cache_fops);
 
 	debugfs_create_file("itct", 0400, dump_dentry,
-			    &hisi_hba->debugfs_itct[0],
+			    &hisi_hba->debugfs_itct[dump_index],
 			    &hisi_sas_debugfs_itct_fops);
 
 	debugfs_create_file("itct_cache", 0400, dump_dentry,
-			    &hisi_hba->debugfs_itct_cache[0],
+			    &hisi_hba->debugfs_itct_cache[dump_index],
 			    &hisi_sas_debugfs_itct_cache_fops);
 
 	debugfs_create_file("axi", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[0][DEBUGFS_AXI],
+			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_AXI],
 			    &hisi_sas_debugfs_axi_fops);
 
 	debugfs_create_file("ras", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[0][DEBUGFS_RAS],
+			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_RAS],
 			    &hisi_sas_debugfs_ras_fops);
 
 	return;
@@ -3296,8 +3306,7 @@ static ssize_t hisi_sas_debugfs_trigger_dump_write(struct file *file,
 	struct hisi_hba *hisi_hba = file->f_inode->i_private;
 	char buf[8];
 
-	/* A bit racy, but don't care too much since it's only debugfs */
-	if (hisi_hba->debugfs_snapshot)
+	if (hisi_hba->debugfs_dump_index >= hisi_sas_debugfs_dump_count)
 		return -EFAULT;
 
 	if (count > 8)
@@ -3700,13 +3709,17 @@ void hisi_sas_debugfs_work_handler(struct work_struct *work)
 	struct hisi_hba *hisi_hba =
 		container_of(work, struct hisi_hba, debugfs_work);
 	u64 timestamp = local_clock() / NSEC_PER_MSEC;
+	struct device *dev = hisi_hba->dev;
+	int debugfs_dump_index = hisi_hba->debugfs_dump_index;
 
-	hisi_hba->debugfs_timestamp = timestamp;
-	if (hisi_hba->debugfs_snapshot)
+	hisi_hba->debugfs_timestamp[debugfs_dump_index] = timestamp;
+	if (debugfs_dump_index >= hisi_sas_debugfs_dump_count) {
+		dev_warn(dev, "dump count exceeded!\n");
 		return;
-	hisi_hba->debugfs_snapshot = true;
+	}
 
 	hisi_sas_debugfs_snapshot_regs(hisi_hba);
+	hisi_hba->debugfs_dump_index++;
 }
 EXPORT_SYMBOL_GPL(hisi_sas_debugfs_work_handler);
 
-- 
2.17.1

