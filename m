Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB981EAC
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfHEOGQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 10:06:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728975AbfHEOGQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 10:06:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E946B22149A80DF7A813;
        Mon,  5 Aug 2019 21:50:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:12 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 04/15] scsi: hisi_sas: Snapshot HW cache of IOST and ITCT at debugfs
Date:   Mon, 5 Aug 2019 21:48:01 +0800
Message-ID: <1565012892-75940-5-git-send-email-john.garry@huawei.com>
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

The value of IOST/ITCT is update to cache first, and then synchronize
to DDR periodically. So the value in IOST/ITCT cache is the latest data
and it's important for debug.

So, the HW cache of IOST and ITCT should be snapshot at debugfs.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  17 ++++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 114 ++++++++++++++++++++++++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  32 +++++++
 3 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index c1b56b482a23..5a2fbbbed53e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -36,6 +36,9 @@
 #define HISI_SAS_UNRESERVED_IPTT \
 	(HISI_SAS_MAX_COMMANDS - HISI_SAS_RESERVED_IPTT)
 
+#define HISI_SAS_IOST_ITCT_CACHE_NUM 64
+#define HISI_SAS_IOST_ITCT_CACHE_DW_SZ 10
+
 #define HISI_SAS_STATUS_BUF_SZ (sizeof(struct hisi_sas_status_buffer))
 #define HISI_SAS_COMMAND_TABLE_SZ (sizeof(union hisi_sas_command_table))
 
@@ -252,6 +255,15 @@ struct hisi_sas_debugfs_reg {
 	};
 };
 
+struct hisi_sas_iost_itct_cache {
+	u32 data[HISI_SAS_IOST_ITCT_CACHE_DW_SZ];
+};
+
+enum hisi_sas_debugfs_cache_type {
+	HISI_SAS_ITCT_CACHE,
+	HISI_SAS_IOST_CACHE,
+};
+
 struct hisi_sas_hw {
 	int (*hw_init)(struct hisi_hba *hisi_hba);
 	void (*setup_itct)(struct hisi_hba *hisi_hba,
@@ -294,6 +306,9 @@ struct hisi_sas_hw {
 					  int delay_ms, int timeout_ms);
 	void (*snapshot_prepare)(struct hisi_hba *hisi_hba);
 	void (*snapshot_restore)(struct hisi_hba *hisi_hba);
+	void (*read_iost_itct_cache)(struct hisi_hba *hisi_hba,
+				     enum hisi_sas_debugfs_cache_type type,
+				     u32 *cache);
 	int complete_hdr_size;
 	struct scsi_host_template *sht;
 
@@ -379,6 +394,8 @@ struct hisi_hba {
 	struct hisi_sas_cmd_hdr	*debugfs_cmd_hdr[HISI_SAS_MAX_QUEUES];
 	struct hisi_sas_iost *debugfs_iost;
 	struct hisi_sas_itct *debugfs_itct;
+	u64 *debugfs_iost_cache;
+	u64 *debugfs_itct_cache;
 
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_dump_dentry;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 325ec4306794..240b6faaf25f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2763,10 +2763,14 @@ static void hisi_sas_debugfs_snapshot_global_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
 {
+	void *cachebuf = hisi_hba->debugfs_itct_cache;
 	void *databuf = hisi_hba->debugfs_itct;
 	struct hisi_sas_itct *itct;
 	int i;
 
+	hisi_hba->hw->read_iost_itct_cache(hisi_hba, HISI_SAS_ITCT_CACHE,
+					   cachebuf);
+
 	itct = hisi_hba->itct;
 
 	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
@@ -2778,10 +2782,14 @@ static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
 static void hisi_sas_debugfs_snapshot_iost_reg(struct hisi_hba *hisi_hba)
 {
 	int max_command_entries = HISI_SAS_MAX_COMMANDS;
+	void *cachebuf = hisi_hba->debugfs_iost_cache;
 	void *databuf = hisi_hba->debugfs_iost;
 	struct hisi_sas_iost *iost;
 	int i;
 
+	hisi_hba->hw->read_iost_itct_cache(hisi_hba, HISI_SAS_IOST_CACHE,
+					   cachebuf);
+
 	iost = hisi_hba->iost;
 
 	for (i = 0; i < max_command_entries; i++, iost++) {
@@ -3018,6 +3026,46 @@ static const struct file_operations hisi_sas_debugfs_iost_fops = {
 	.owner = THIS_MODULE,
 };
 
+static int hisi_sas_debugfs_iost_cache_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+	struct hisi_sas_iost_itct_cache *iost_cache =
+		(struct hisi_sas_iost_itct_cache *)hisi_hba->debugfs_iost_cache;
+	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * 4;
+	int i, tab_idx;
+	__le64 *iost;
+
+	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, iost_cache++) {
+		/*
+		 * Data struct of IOST cache:
+		 * Data[1]: BIT0~15: Table index
+		 *	    Bit16:   Valid mask
+		 * Data[2]~[9]: IOST table
+		 */
+		tab_idx = (iost_cache->data[1] & 0xffff);
+		iost = (__le64 *)iost_cache;
+
+		hisi_sas_show_row_64(s, tab_idx, cache_size, iost);
+	}
+
+	return 0;
+}
+
+static int hisi_sas_debugfs_iost_cache_open(struct inode *inode,
+					    struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_iost_cache_show,
+			   inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_iost_cache_fops = {
+	.open = hisi_sas_debugfs_iost_cache_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static int hisi_sas_debugfs_itct_show(struct seq_file *s, void *p)
 {
 	int i, ret;
@@ -3049,6 +3097,46 @@ static const struct file_operations hisi_sas_debugfs_itct_fops = {
 	.owner = THIS_MODULE,
 };
 
+static int hisi_sas_debugfs_itct_cache_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+	struct hisi_sas_iost_itct_cache *itct_cache =
+		(struct hisi_sas_iost_itct_cache *)hisi_hba->debugfs_itct_cache;
+	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * 4;
+	int i, tab_idx;
+	__le64 *itct;
+
+	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, itct_cache++) {
+		/*
+		 * Data struct of ITCT cache:
+		 * Data[1]: BIT0~15: Table index
+		 *	    Bit16:   Valid mask
+		 * Data[2]~[9]: ITCT table
+		 */
+		tab_idx = itct_cache->data[1] & 0xffff;
+		itct = (__le64 *)itct_cache;
+
+		hisi_sas_show_row_64(s, tab_idx, cache_size, itct);
+	}
+
+	return 0;
+}
+
+static int hisi_sas_debugfs_itct_cache_open(struct inode *inode,
+					    struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_itct_cache_show,
+			   inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_itct_cache_fops = {
+	.open = hisi_sas_debugfs_itct_cache_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 {
 	struct dentry *dump_dentry;
@@ -3095,9 +3183,15 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 	debugfs_create_file("iost", 0400, dump_dentry, hisi_hba,
 			    &hisi_sas_debugfs_iost_fops);
 
+	debugfs_create_file("iost_cache", 0400, dump_dentry, hisi_hba,
+			    &hisi_sas_debugfs_iost_cache_fops);
+
 	debugfs_create_file("itct", 0400, dump_dentry, hisi_hba,
 			    &hisi_sas_debugfs_itct_fops);
 
+	debugfs_create_file("itct_cache", 0400, dump_dentry, hisi_hba,
+			    &hisi_sas_debugfs_itct_cache_fops);
+
 	return;
 }
 
@@ -3212,14 +3306,26 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 			goto fail_iost_dq;
 	}
 
-	/* Alloc buffer for iost */
 	sz = max_command_entries * sizeof(struct hisi_sas_iost);
 
 	hisi_hba->debugfs_iost = devm_kmalloc(dev, sz, GFP_KERNEL);
 	if (!hisi_hba->debugfs_iost)
 		goto fail_iost_dq;
 
-	/* Alloc buffer for itct */
+	sz = HISI_SAS_IOST_ITCT_CACHE_NUM *
+	     sizeof(struct hisi_sas_iost_itct_cache);
+
+	hisi_hba->debugfs_iost_cache = devm_kmalloc(dev, sz, GFP_KERNEL);
+	if (!hisi_hba->debugfs_iost_cache)
+		goto fail_iost_cache;
+
+	sz = HISI_SAS_IOST_ITCT_CACHE_NUM *
+	     sizeof(struct hisi_sas_iost_itct_cache);
+
+	hisi_hba->debugfs_itct_cache = devm_kmalloc(dev, sz, GFP_KERNEL);
+	if (!hisi_hba->debugfs_itct_cache)
+		goto fail_itct_cache;
+
 	/* New memory allocation must be locate before itct */
 	sz = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_itct);
 
@@ -3229,6 +3335,10 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 
 	return;
 fail_itct:
+	devm_kfree(dev, hisi_hba->debugfs_iost_cache);
+fail_itct_cache:
+	devm_kfree(dev, hisi_hba->debugfs_iost_cache);
+fail_iost_cache:
 	devm_kfree(dev, hisi_hba->debugfs_iost);
 fail_iost_dq:
 	for (i = 0; i < d; i++)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b99abc788487..c8ca6ead639b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -71,6 +71,7 @@
 #define HGC_DQE_ECC_MB_ADDR_OFF	16
 #define HGC_DQE_ECC_MB_ADDR_MSK (0xfff << HGC_DQE_ECC_MB_ADDR_OFF)
 #define CHNL_INT_STATUS			0x148
+#define TAB_DFX				0x14c
 #define HGC_ITCT_ECC_ADDR		0x150
 #define HGC_ITCT_ECC_1B_ADDR_OFF		0
 #define HGC_ITCT_ECC_1B_ADDR_MSK		(0x3ff << \
@@ -83,6 +84,7 @@
 #define AXI_ERR_INFO_MSK               (0xff << AXI_ERR_INFO_OFF)
 #define FIFO_ERR_INFO_OFF              8
 #define FIFO_ERR_INFO_MSK              (0xff << FIFO_ERR_INFO_OFF)
+#define TAB_RD_TYPE			0x15c
 #define INT_COAL_EN			0x19c
 #define OQ_INT_COAL_TIME		0x1a0
 #define OQ_INT_COAL_CNT			0x1a4
@@ -2877,6 +2879,35 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
 	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 }
 
+static void read_iost_itct_cache_v3_hw(struct hisi_hba *hisi_hba,
+				       enum hisi_sas_debugfs_cache_type type,
+				       u32 *cache)
+{
+	u32 cache_dw_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ *
+			    HISI_SAS_IOST_ITCT_CACHE_NUM;
+	u32 *buf = cache;
+	u32 i, val;
+
+	hisi_sas_write32(hisi_hba, TAB_RD_TYPE, type);
+
+	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_DW_SZ; i++) {
+		val = hisi_sas_read32(hisi_hba, TAB_DFX);
+		if (val == 0xffffffff)
+			break;
+	}
+
+	if (val != 0xffffffff) {
+		pr_err("Issue occur when reading IOST/ITCT cache!\n");
+		return;
+	}
+
+	memset(buf, 0, cache_dw_size * 4);
+	buf[0] = val;
+
+	for (i = 1; i < cache_dw_size; i++)
+		buf[i] = hisi_sas_read32(hisi_hba, TAB_DFX);
+}
+
 static struct scsi_host_template sht_v3_hw = {
 	.name			= DRV_NAME,
 	.module			= THIS_MODULE,
@@ -2929,6 +2960,7 @@ static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.debugfs_reg_port = &debugfs_port_reg,
 	.snapshot_prepare = debugfs_snapshot_prepare_v3_hw,
 	.snapshot_restore = debugfs_snapshot_restore_v3_hw,
+	.read_iost_itct_cache = read_iost_itct_cache_v3_hw,
 };
 
 static struct Scsi_Host *
-- 
2.17.1

