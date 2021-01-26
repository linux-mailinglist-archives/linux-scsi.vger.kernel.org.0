Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E5303CAD
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Jan 2021 13:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404786AbhAZMNM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Jan 2021 07:13:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11596 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404907AbhAZLJT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 26 Jan 2021 06:09:19 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQ3pw1b7Jz15y3D;
        Tue, 26 Jan 2021 19:07:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 19:08:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/5] scsi: hisi_sas: Add trace FIFO debugfs support
Date:   Tue, 26 Jan 2021 19:04:28 +0800
Message-ID: <1611659068-131975-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611659068-131975-1-git-send-email-john.garry@huawei.com>
References: <1611659068-131975-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

The controller provides trace FIFO DFX tool to assist link fault debug and
link optimization. This tool can be helpful when debug link faults without
SAS analyzers. Each PHY has an independent trace FIFO interface.

The user can configure trace FIFO tool of one PHY by using the following
six interfaces:

signal_sel: select signal group applies to different scenarios.
  0x0: linkrate negotiation
  0x1: Host 12G TX train
  0x2: Disk 12G TX train
  0x3: SAS PHY CTRL DFX 0
  0x4: SAS PHY CTRL DFX 1
  0x5: SAS PCS DFX
  other: linkrate negotiation
dump_mask: The masked hardware status bit will not be updated.
dump_mode: determines how to dump data after trigger signal is generated.
  0x0: dump forever
  0x1: dump 32 data after trigger signal is generated
  0x2: no more dump after trigger signal is generated
trigger_mode: determines the trigger mode, level or edge.
  0x0: dump when trigger signal changed
  0x1: dump when trigger signal's level equal to trigger_level
  0x2: dump when trigger signal's level different from trigger_level
trigger_level: determines the trigger level.
trigger_msk: mask trigger signal

The user can get 32 signal datas from hardware by reading the rd_data.
These 32 signal datas is the status record of hardware at different time
points.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  15 ++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 251 +++++++++++++++++++++++++
 2 files changed, 266 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 873bfffa626d..2401a9575215 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -44,6 +44,7 @@
 
 #define HISI_SAS_IOST_ITCT_CACHE_NUM 64
 #define HISI_SAS_IOST_ITCT_CACHE_DW_SZ 10
+#define HISI_SAS_FIFO_DATA_DW_SIZE 32
 
 #define HISI_SAS_STATUS_BUF_SZ (sizeof(struct hisi_sas_status_buffer))
 #define HISI_SAS_COMMAND_TABLE_SZ (sizeof(union hisi_sas_command_table))
@@ -154,6 +155,16 @@ enum hisi_sas_phy_event {
 	HISI_PHYES_NUM,
 };
 
+struct hisi_sas_debugfs_fifo {
+	u32 signal_sel;
+	u32 dump_msk;
+	u32 dump_mode;
+	u32 trigger;
+	u32 trigger_msk;
+	u32 trigger_mode;
+	u32 rd_data[HISI_SAS_FIFO_DATA_DW_SIZE];
+};
+
 struct hisi_sas_phy {
 	struct work_struct	works[HISI_PHYES_NUM];
 	struct hisi_hba	*hisi_hba;
@@ -175,6 +186,9 @@ struct hisi_sas_phy {
 	enum sas_linkrate	maximum_linkrate;
 	int enable;
 	atomic_t down_cnt;
+
+	/* Trace FIFO */
+	struct hisi_sas_debugfs_fifo fifo;
 };
 
 struct hisi_sas_port {
@@ -474,6 +488,7 @@ struct hisi_hba {
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_dump_dentry;
 	struct dentry *debugfs_bist_dentry;
+	struct dentry *debugfs_fifo_dentry;
 };
 
 /* Generic HW DMA host memory structures */
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 4cc344ca121c..4580e081e489 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -303,6 +303,19 @@
 #define ERR_CNT_INVLD_DW		(PORT_BASE + 0x390)
 #define ERR_CNT_CODE_ERR		(PORT_BASE + 0x394)
 #define ERR_CNT_DISP_ERR		(PORT_BASE + 0x398)
+#define DFX_FIFO_CTRL			(PORT_BASE + 0x3a0)
+#define DFX_FIFO_CTRL_TRIGGER_MODE_OFF	0
+#define DFX_FIFO_CTRL_TRIGGER_MODE_MSK	(0x7 << DFX_FIFO_CTRL_TRIGGER_MODE_OFF)
+#define DFX_FIFO_CTRL_DUMP_MODE_OFF	3
+#define DFX_FIFO_CTRL_DUMP_MODE_MSK	(0x7 << DFX_FIFO_CTRL_DUMP_MODE_OFF)
+#define DFX_FIFO_CTRL_SIGNAL_SEL_OFF	6
+#define DFX_FIFO_CTRL_SIGNAL_SEL_MSK	(0xF << DFX_FIFO_CTRL_SIGNAL_SEL_OFF)
+#define DFX_FIFO_CTRL_DUMP_DISABLE_OFF	10
+#define DFX_FIFO_CTRL_DUMP_DISABLE_MSK	(0x1 << DFX_FIFO_CTRL_DUMP_DISABLE_OFF)
+#define DFX_FIFO_TRIGGER		(PORT_BASE + 0x3a4)
+#define DFX_FIFO_TRIGGER_MSK		(PORT_BASE + 0x3a8)
+#define DFX_FIFO_DUMP_MSK		(PORT_BASE + 0x3aC)
+#define DFX_FIFO_RD_DATA		(PORT_BASE + 0x3b0)
 
 #define DEFAULT_ITCT_HW		2048 /* reset value, not reprogrammed */
 #if (HISI_SAS_MAX_DEVICES > DEFAULT_ITCT_HW)
@@ -4153,6 +4166,243 @@ static const struct file_operations debugfs_phy_down_cnt_v3_hw_fops = {
 	.owner = THIS_MODULE,
 };
 
+enum fifo_dump_mode_v3_hw {
+	FIFO_DUMP_FORVER =		(1U << 0),
+	FIFO_DUMP_AFTER_TRIGGER =	(1U << 1),
+	FIFO_DUMP_UNTILL_TRIGGER =	(1U << 2),
+};
+
+enum fifo_trigger_mode_v3_hw {
+	FIFO_TRIGGER_EDGE =		(1U << 0),
+	FIFO_TRIGGER_SAME_LEVEL =	(1U << 1),
+	FIFO_TRIGGER_DIFF_LEVEL =	(1U << 2),
+};
+
+static int debugfs_is_fifo_config_valid_v3_hw(struct hisi_sas_phy *phy)
+{
+	struct hisi_hba *hisi_hba = phy->hisi_hba;
+
+	if (phy->fifo.signal_sel > 0xf) {
+		dev_info(hisi_hba->dev, "Invalid signal select: %u\n",
+			 phy->fifo.signal_sel);
+		return -EINVAL;
+	}
+
+	switch (phy->fifo.dump_mode) {
+	case FIFO_DUMP_FORVER:
+	case FIFO_DUMP_AFTER_TRIGGER:
+	case FIFO_DUMP_UNTILL_TRIGGER:
+		break;
+	default:
+		dev_info(hisi_hba->dev, "Invalid dump mode: %u\n",
+			 phy->fifo.dump_mode);
+		return -EINVAL;
+	}
+
+	/* when FIFO_DUMP_FORVER, no need to check trigger_mode */
+	if (phy->fifo.dump_mode == FIFO_DUMP_FORVER)
+		return 0;
+
+	switch (phy->fifo.trigger_mode) {
+	case FIFO_TRIGGER_EDGE:
+	case FIFO_TRIGGER_SAME_LEVEL:
+	case FIFO_TRIGGER_DIFF_LEVEL:
+		break;
+	default:
+		dev_info(hisi_hba->dev, "Invalid trigger mode: %u\n",
+			 phy->fifo.trigger_mode);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int debugfs_update_fifo_config_v3_hw(struct hisi_sas_phy *phy)
+{
+	u32 trigger_mode = phy->fifo.trigger_mode;
+	u32 signal_sel = phy->fifo.signal_sel;
+	u32 dump_mode = phy->fifo.dump_mode;
+	struct hisi_hba *hisi_hba = phy->hisi_hba;
+	int phy_no = phy->sas_phy.id;
+	u32 reg_val;
+	int res;
+
+	/* Check the validity of trace FIFO configuration */
+	res = debugfs_is_fifo_config_valid_v3_hw(phy);
+	if (res)
+		return res;
+
+	reg_val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_CTRL);
+	/* Disable trace FIFO before update configuration */
+	reg_val |= DFX_FIFO_CTRL_DUMP_DISABLE_MSK;
+
+	/* Update trace FIFO configuration */
+	reg_val &= ~(DFX_FIFO_CTRL_DUMP_MODE_MSK |
+		     DFX_FIFO_CTRL_SIGNAL_SEL_MSK |
+		     DFX_FIFO_CTRL_TRIGGER_MODE_MSK);
+
+	reg_val |= ((trigger_mode << DFX_FIFO_CTRL_TRIGGER_MODE_OFF) |
+		    (dump_mode << DFX_FIFO_CTRL_DUMP_MODE_OFF) |
+		    (signal_sel << DFX_FIFO_CTRL_SIGNAL_SEL_OFF));
+	hisi_sas_phy_write32(hisi_hba, phy_no, DFX_FIFO_CTRL, reg_val);
+
+	hisi_sas_phy_write32(hisi_hba, phy_no, DFX_FIFO_DUMP_MSK,
+			     phy->fifo.dump_msk);
+
+	hisi_sas_phy_write32(hisi_hba, phy_no, DFX_FIFO_TRIGGER,
+			     phy->fifo.trigger);
+
+	hisi_sas_phy_write32(hisi_hba, phy_no, DFX_FIFO_TRIGGER_MSK,
+			     phy->fifo.trigger_msk);
+
+	/* Enable trace FIFO after updated configuration */
+	reg_val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_CTRL);
+	reg_val &= ~DFX_FIFO_CTRL_DUMP_DISABLE_MSK;
+	hisi_sas_phy_write32(hisi_hba, phy_no, DFX_FIFO_CTRL, reg_val);
+
+	return 0;
+}
+
+static ssize_t debugfs_fifo_update_cfg_v3_hw_write(struct file *filp,
+						   const char __user *buf,
+						   size_t count, loff_t *ppos)
+{
+	struct hisi_sas_phy *phy = filp->private_data;
+	bool update;
+	int val;
+
+	val = kstrtobool_from_user(buf, count, &update);
+	if (val)
+		return val;
+
+	if (update != 1)
+		return -EINVAL;
+
+	val = debugfs_update_fifo_config_v3_hw(phy);
+	if (val)
+		return val;
+
+	return count;
+}
+
+static const struct file_operations debugfs_fifo_update_cfg_v3_hw_fops = {
+	.open = simple_open,
+	.write = debugfs_fifo_update_cfg_v3_hw_write,
+	.owner = THIS_MODULE,
+};
+
+static void debugfs_read_fifo_data_v3_hw(struct hisi_sas_phy *phy)
+{
+	struct hisi_hba *hisi_hba = phy->hisi_hba;
+	u32 *buf = phy->fifo.rd_data;
+	int phy_no = phy->sas_phy.id;
+	u32 val;
+	int i;
+
+	memset(buf, 0, sizeof(phy->fifo.rd_data));
+
+	/* Disable trace FIFO before read data */
+	val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_CTRL);
+	val |= DFX_FIFO_CTRL_DUMP_DISABLE_MSK;
+	hisi_sas_phy_write32(hisi_hba, phy_no, DFX_FIFO_CTRL, val);
+
+	for (i = 0; i < HISI_SAS_FIFO_DATA_DW_SIZE; i++) {
+		val = hisi_sas_phy_read32(hisi_hba, phy_no,
+					  DFX_FIFO_RD_DATA);
+		buf[i] = val;
+	}
+
+	/* Enable trace FIFO after read data */
+	val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_CTRL);
+	val &= ~DFX_FIFO_CTRL_DUMP_DISABLE_MSK;
+	hisi_sas_phy_write32(hisi_hba, phy_no, DFX_FIFO_CTRL, val);
+}
+
+static int debugfs_fifo_data_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_phy *phy = s->private;
+
+	debugfs_read_fifo_data_v3_hw(phy);
+
+	debugfs_show_row_32_v3_hw(s, 0, HISI_SAS_FIFO_DATA_DW_SIZE * 4,
+				  phy->fifo.rd_data);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_fifo_data_v3_hw);
+
+static void debugfs_fifo_init_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int phy_no;
+
+	hisi_hba->debugfs_fifo_dentry =
+			debugfs_create_dir("fifo", hisi_hba->debugfs_dir);
+
+	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
+		struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
+		struct dentry *port_dentry;
+		char name[256];
+		u32 val;
+
+		/* get default configuration for trace FIFO */
+		val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_CTRL);
+		val &= DFX_FIFO_CTRL_DUMP_MODE_MSK;
+		val >>= DFX_FIFO_CTRL_DUMP_MODE_OFF;
+		phy->fifo.dump_mode = val;
+
+		val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_CTRL);
+		val &= DFX_FIFO_CTRL_TRIGGER_MODE_MSK;
+		val >>= DFX_FIFO_CTRL_TRIGGER_MODE_OFF;
+		phy->fifo.trigger_mode = val;
+
+		val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_CTRL);
+		val &= DFX_FIFO_CTRL_SIGNAL_SEL_MSK;
+		val >>= DFX_FIFO_CTRL_SIGNAL_SEL_OFF;
+		phy->fifo.signal_sel = val;
+
+		val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_DUMP_MSK);
+		phy->fifo.dump_msk = val;
+
+		val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_TRIGGER);
+		phy->fifo.trigger = val;
+		val = hisi_sas_phy_read32(hisi_hba, phy_no, DFX_FIFO_TRIGGER_MSK);
+		phy->fifo.trigger_msk = val;
+
+		snprintf(name, 256, "%d", phy_no);
+		port_dentry = debugfs_create_dir(name,
+						 hisi_hba->debugfs_fifo_dentry);
+
+		debugfs_create_file("update_config", 0200, port_dentry, phy,
+				    &debugfs_fifo_update_cfg_v3_hw_fops);
+
+		debugfs_create_file("signal_sel", 0600, port_dentry,
+				    &phy->fifo.signal_sel,
+				    &debugfs_v3_hw_fops);
+
+		debugfs_create_file("dump_msk", 0600, port_dentry,
+				    &phy->fifo.dump_msk,
+				    &debugfs_v3_hw_fops);
+
+		debugfs_create_file("dump_mode", 0600, port_dentry,
+				    &phy->fifo.dump_mode,
+				    &debugfs_v3_hw_fops);
+
+		debugfs_create_file("trigger_mode", 0600, port_dentry,
+				    &phy->fifo.trigger_mode,
+				    &debugfs_v3_hw_fops);
+
+		debugfs_create_file("trigger", 0600, port_dentry,
+				    &phy->fifo.trigger,
+				    &debugfs_v3_hw_fops);
+
+		debugfs_create_file("trigger_msk", 0600, port_dentry,
+				    &phy->fifo.trigger_msk,
+				    &debugfs_v3_hw_fops);
+
+		debugfs_create_file("fifo_data", 0400, port_dentry, phy,
+				    &debugfs_fifo_data_v3_hw_fops);
+	}
+}
+
 static void debugfs_work_handler_v3_hw(struct work_struct *work)
 {
 	struct hisi_hba *hisi_hba =
@@ -4388,6 +4638,7 @@ static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
 			debugfs_create_dir("dump", hisi_hba->debugfs_dir);
 
 	debugfs_phy_down_cnt_init_v3_hw(hisi_hba);
+	debugfs_fifo_init_v3_hw(hisi_hba);
 
 	for (i = 0; i < hisi_sas_debugfs_dump_count; i++) {
 		if (debugfs_alloc_v3_hw(hisi_hba, i)) {
-- 
2.26.2

