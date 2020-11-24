Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E1F2C2069
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Nov 2020 09:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgKXIvB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Nov 2020 03:51:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7726 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbgKXIvB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 Nov 2020 03:51:01 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CgHlc59lDzkdQH;
        Tue, 24 Nov 2020 16:50:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 16:50:22 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/3] scsi: hisi_sas: Move debugfs code to v3 hw driver
Date:   Tue, 24 Nov 2020 16:46:34 +0800
Message-ID: <1606207594-196362-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606207594-196362-1-git-send-email-john.garry@huawei.com>
References: <1606207594-196362-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

Relocate all the debugfs code for DFX to v3 hw as there are only longer
plans to support earlier HW versions.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |   28 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 1346 +-----------------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1225 ++++++++++++++++++++-
 3 files changed, 1212 insertions(+), 1387 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index a25cfc11c96d..2b28dd405600 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -243,24 +243,6 @@ struct hisi_sas_slot {
 	u16	idx;
 };
 
-#define HISI_SAS_DEBUGFS_REG(x) {#x, x}
-
-struct hisi_sas_debugfs_reg_lu {
-	char *name;
-	int off;
-};
-
-struct hisi_sas_debugfs_reg {
-	const struct hisi_sas_debugfs_reg_lu *lu;
-	int count;
-	int base_off;
-	union {
-		u32 (*read_global_reg)(struct hisi_hba *hisi_hba, u32 off);
-		u32 (*read_port_reg)(struct hisi_hba *hisi_hba, int port,
-				     u32 off);
-	};
-};
-
 struct hisi_sas_iost_itct_cache {
 	u32 data[HISI_SAS_IOST_ITCT_CACHE_DW_SZ];
 };
@@ -350,15 +332,8 @@ struct hisi_sas_hw {
 					   int delay_ms, int timeout_ms);
 	void (*snapshot_prepare)(struct hisi_hba *hisi_hba);
 	void (*snapshot_restore)(struct hisi_hba *hisi_hba);
-	int (*set_bist)(struct hisi_hba *hisi_hba, bool enable);
-	void (*read_iost_itct_cache)(struct hisi_hba *hisi_hba,
-				     enum hisi_sas_debugfs_cache_type type,
-				     u32 *cache);
 	int complete_hdr_size;
 	struct scsi_host_template *sht;
-
-	const struct hisi_sas_debugfs_reg *debugfs_reg_array[DEBUGFS_REGS_NUM];
-	const struct hisi_sas_debugfs_reg *debugfs_reg_port;
 };
 
 #define HISI_SAS_MAX_DEBUGFS_DUMP (50)
@@ -673,7 +648,4 @@ extern void hisi_sas_release_tasks(struct hisi_hba *hisi_hba);
 extern u8 hisi_sas_get_prog_phy_linkrate_mask(enum sas_linkrate max);
 extern void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba);
 extern void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba);
-extern void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba);
-extern void hisi_sas_debugfs_exit(struct hisi_hba *hisi_hba);
-extern void hisi_sas_debugfs_work_handler(struct work_struct *work);
 #endif
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 128583dfccf2..e77c3e64a326 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2690,1355 +2690,12 @@ int hisi_sas_probe(struct platform_device *pdev,
 err_out_register_ha:
 	scsi_remove_host(shost);
 err_out_ha:
-	hisi_sas_debugfs_exit(hisi_hba);
 	hisi_sas_free(hisi_hba);
 	scsi_host_put(shost);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(hisi_sas_probe);
 
-struct dentry *hisi_sas_debugfs_dir;
-
-static void hisi_sas_debugfs_snapshot_cq_reg(struct hisi_hba *hisi_hba)
-{
-	int queue_entry_size = hisi_hba->hw->complete_hdr_size;
-	int dump_index = hisi_hba->debugfs_dump_index;
-	int i;
-
-	for (i = 0; i < hisi_hba->queue_count; i++)
-		memcpy(hisi_hba->debugfs_cq[dump_index][i].complete_hdr,
-		       hisi_hba->complete_hdr[i],
-		       HISI_SAS_QUEUE_SLOTS * queue_entry_size);
-}
-
-static void hisi_sas_debugfs_snapshot_dq_reg(struct hisi_hba *hisi_hba)
-{
-	int queue_entry_size = sizeof(struct hisi_sas_cmd_hdr);
-	int dump_index = hisi_hba->debugfs_dump_index;
-	int i;
-
-	for (i = 0; i < hisi_hba->queue_count; i++) {
-		struct hisi_sas_cmd_hdr *debugfs_cmd_hdr, *cmd_hdr;
-		int j;
-
-		debugfs_cmd_hdr = hisi_hba->debugfs_dq[dump_index][i].hdr;
-		cmd_hdr = hisi_hba->cmd_hdr[i];
-
-		for (j = 0; j < HISI_SAS_QUEUE_SLOTS; j++)
-			memcpy(&debugfs_cmd_hdr[j], &cmd_hdr[j],
-			       queue_entry_size);
-	}
-}
-
-static void hisi_sas_debugfs_snapshot_port_reg(struct hisi_hba *hisi_hba)
-{
-	int dump_index = hisi_hba->debugfs_dump_index;
-	const struct hisi_sas_debugfs_reg *port =
-		hisi_hba->hw->debugfs_reg_port;
-	int i, phy_cnt;
-	u32 offset;
-	u32 *databuf;
-
-	for (phy_cnt = 0; phy_cnt < hisi_hba->n_phy; phy_cnt++) {
-		databuf = hisi_hba->debugfs_port_reg[dump_index][phy_cnt].data;
-		for (i = 0; i < port->count; i++, databuf++) {
-			offset = port->base_off + 4 * i;
-			*databuf = port->read_port_reg(hisi_hba, phy_cnt,
-						       offset);
-		}
-	}
-}
-
-static void hisi_sas_debugfs_snapshot_global_reg(struct hisi_hba *hisi_hba)
-{
-	int dump_index = hisi_hba->debugfs_dump_index;
-	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_GLOBAL].data;
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const struct hisi_sas_debugfs_reg *global =
-			hw->debugfs_reg_array[DEBUGFS_GLOBAL];
-	int i;
-
-	for (i = 0; i < global->count; i++, databuf++)
-		*databuf = global->read_global_reg(hisi_hba, 4 * i);
-}
-
-static void hisi_sas_debugfs_snapshot_axi_reg(struct hisi_hba *hisi_hba)
-{
-	int dump_index = hisi_hba->debugfs_dump_index;
-	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_AXI].data;
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const struct hisi_sas_debugfs_reg *axi =
-			hw->debugfs_reg_array[DEBUGFS_AXI];
-	int i;
-
-	for (i = 0; i < axi->count; i++, databuf++)
-		*databuf = axi->read_global_reg(hisi_hba,
-						4 * i + axi->base_off);
-}
-
-static void hisi_sas_debugfs_snapshot_ras_reg(struct hisi_hba *hisi_hba)
-{
-	int dump_index = hisi_hba->debugfs_dump_index;
-	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_RAS].data;
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const struct hisi_sas_debugfs_reg *ras =
-			hw->debugfs_reg_array[DEBUGFS_RAS];
-	int i;
-
-	for (i = 0; i < ras->count; i++, databuf++)
-		*databuf = ras->read_global_reg(hisi_hba,
-						4 * i + ras->base_off);
-}
-
-static void hisi_sas_debugfs_snapshot_itct_reg(struct hisi_hba *hisi_hba)
-{
-	int dump_index = hisi_hba->debugfs_dump_index;
-	void *cachebuf = hisi_hba->debugfs_itct_cache[dump_index].cache;
-	void *databuf = hisi_hba->debugfs_itct[dump_index].itct;
-	struct hisi_sas_itct *itct;
-	int i;
-
-	hisi_hba->hw->read_iost_itct_cache(hisi_hba, HISI_SAS_ITCT_CACHE,
-					   cachebuf);
-
-	itct = hisi_hba->itct;
-
-	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
-		memcpy(databuf, itct, sizeof(struct hisi_sas_itct));
-		databuf += sizeof(struct hisi_sas_itct);
-	}
-}
-
-static void hisi_sas_debugfs_snapshot_iost_reg(struct hisi_hba *hisi_hba)
-{
-	int dump_index = hisi_hba->debugfs_dump_index;
-	int max_command_entries = HISI_SAS_MAX_COMMANDS;
-	void *cachebuf = hisi_hba->debugfs_iost_cache[dump_index].cache;
-	void *databuf = hisi_hba->debugfs_iost[dump_index].iost;
-	struct hisi_sas_iost *iost;
-	int i;
-
-	hisi_hba->hw->read_iost_itct_cache(hisi_hba, HISI_SAS_IOST_CACHE,
-					   cachebuf);
-
-	iost = hisi_hba->iost;
-
-	for (i = 0; i < max_command_entries; i++, iost++) {
-		memcpy(databuf, iost, sizeof(struct hisi_sas_iost));
-		databuf += sizeof(struct hisi_sas_iost);
-	}
-}
-
-static const char *
-hisi_sas_debugfs_to_reg_name(int off, int base_off,
-			     const struct hisi_sas_debugfs_reg_lu *lu)
-{
-	for (; lu->name; lu++) {
-		if (off == lu->off - base_off)
-			return lu->name;
-	}
-
-	return NULL;
-}
-
-static void hisi_sas_debugfs_print_reg(u32 *regs_val, const void *ptr,
-				       struct seq_file *s)
-{
-	const struct hisi_sas_debugfs_reg *reg = ptr;
-	int i;
-
-	for (i = 0; i < reg->count; i++) {
-		int off = i * 4;
-		const char *name;
-
-		name = hisi_sas_debugfs_to_reg_name(off, reg->base_off,
-						    reg->lu);
-
-		if (name)
-			seq_printf(s, "0x%08x 0x%08x %s\n", off,
-				   regs_val[i], name);
-		else
-			seq_printf(s, "0x%08x 0x%08x\n", off,
-				   regs_val[i]);
-	}
-}
-
-static int hisi_sas_debugfs_global_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_regs *global = s->private;
-	struct hisi_hba *hisi_hba = global->hisi_hba;
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const void *reg_global = hw->debugfs_reg_array[DEBUGFS_GLOBAL];
-
-	hisi_sas_debugfs_print_reg(global->data,
-				   reg_global, s);
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_global_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_global_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_global_fops = {
-	.open = hisi_sas_debugfs_global_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int hisi_sas_debugfs_axi_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_regs *axi = s->private;
-	struct hisi_hba *hisi_hba = axi->hisi_hba;
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const void *reg_axi = hw->debugfs_reg_array[DEBUGFS_AXI];
-
-	hisi_sas_debugfs_print_reg(axi->data,
-				   reg_axi, s);
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_axi_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_axi_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_axi_fops = {
-	.open = hisi_sas_debugfs_axi_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int hisi_sas_debugfs_ras_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_regs *ras = s->private;
-	struct hisi_hba *hisi_hba = ras->hisi_hba;
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const void *reg_ras = hw->debugfs_reg_array[DEBUGFS_RAS];
-
-	hisi_sas_debugfs_print_reg(ras->data,
-				   reg_ras, s);
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_ras_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_ras_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_ras_fops = {
-	.open = hisi_sas_debugfs_ras_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int hisi_sas_debugfs_port_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_port *port = s->private;
-	struct hisi_sas_phy *phy = port->phy;
-	struct hisi_hba *hisi_hba = phy->hisi_hba;
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	const struct hisi_sas_debugfs_reg *reg_port = hw->debugfs_reg_port;
-
-	hisi_sas_debugfs_print_reg(port->data, reg_port, s);
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_port_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_port_show, inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_port_fops = {
-	.open = hisi_sas_debugfs_port_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static void hisi_sas_show_row_64(struct seq_file *s, int index,
-				 int sz, __le64 *ptr)
-{
-	int i;
-
-	/* completion header size not fixed per HW version */
-	seq_printf(s, "index %04d:\n\t", index);
-	for (i = 1; i <= sz / 8; i++, ptr++) {
-		seq_printf(s, " 0x%016llx", le64_to_cpu(*ptr));
-		if (!(i % 2))
-			seq_puts(s, "\n\t");
-	}
-
-	seq_puts(s, "\n");
-}
-
-static void hisi_sas_show_row_32(struct seq_file *s, int index,
-				 int sz, __le32 *ptr)
-{
-	int i;
-
-	/* completion header size not fixed per HW version */
-	seq_printf(s, "index %04d:\n\t", index);
-	for (i = 1; i <= sz / 4; i++, ptr++) {
-		seq_printf(s, " 0x%08x", le32_to_cpu(*ptr));
-		if (!(i % 4))
-			seq_puts(s, "\n\t");
-	}
-	seq_puts(s, "\n");
-}
-
-static void hisi_sas_cq_show_slot(struct seq_file *s, int slot,
-				  struct hisi_sas_debugfs_cq *debugfs_cq)
-{
-	struct hisi_sas_cq *cq = debugfs_cq->cq;
-	struct hisi_hba *hisi_hba = cq->hisi_hba;
-	__le32 *complete_hdr = debugfs_cq->complete_hdr +
-			       (hisi_hba->hw->complete_hdr_size * slot);
-
-	hisi_sas_show_row_32(s, slot,
-			     hisi_hba->hw->complete_hdr_size,
-			     complete_hdr);
-}
-
-static int hisi_sas_debugfs_cq_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_cq *debugfs_cq = s->private;
-	int slot;
-
-	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++) {
-		hisi_sas_cq_show_slot(s, slot, debugfs_cq);
-	}
-	return 0;
-}
-
-static int hisi_sas_debugfs_cq_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_cq_show, inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_cq_fops = {
-	.open = hisi_sas_debugfs_cq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static void hisi_sas_dq_show_slot(struct seq_file *s, int slot, void *dq_ptr)
-{
-	struct hisi_sas_debugfs_dq *debugfs_dq = dq_ptr;
-	void *cmd_queue = debugfs_dq->hdr;
-	__le32 *cmd_hdr = cmd_queue +
-		sizeof(struct hisi_sas_cmd_hdr) * slot;
-
-	hisi_sas_show_row_32(s, slot, sizeof(struct hisi_sas_cmd_hdr), cmd_hdr);
-}
-
-static int hisi_sas_debugfs_dq_show(struct seq_file *s, void *p)
-{
-	int slot;
-
-	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++) {
-		hisi_sas_dq_show_slot(s, slot, s->private);
-	}
-	return 0;
-}
-
-static int hisi_sas_debugfs_dq_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_dq_show, inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_dq_fops = {
-	.open = hisi_sas_debugfs_dq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int hisi_sas_debugfs_iost_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_iost *debugfs_iost = s->private;
-	struct hisi_sas_iost *iost = debugfs_iost->iost;
-	int i, max_command_entries = HISI_SAS_MAX_COMMANDS;
-
-	for (i = 0; i < max_command_entries; i++, iost++) {
-		__le64 *data = &iost->qw0;
-
-		hisi_sas_show_row_64(s, i, sizeof(*iost), data);
-	}
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_iost_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_iost_show, inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_iost_fops = {
-	.open = hisi_sas_debugfs_iost_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int hisi_sas_debugfs_iost_cache_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_iost_cache *debugfs_iost_cache = s->private;
-	struct hisi_sas_iost_itct_cache *iost_cache = debugfs_iost_cache->cache;
-	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * 4;
-	int i, tab_idx;
-	__le64 *iost;
-
-	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, iost_cache++) {
-		/*
-		 * Data struct of IOST cache:
-		 * Data[1]: BIT0~15: Table index
-		 *	    Bit16:   Valid mask
-		 * Data[2]~[9]: IOST table
-		 */
-		tab_idx = (iost_cache->data[1] & 0xffff);
-		iost = (__le64 *)iost_cache;
-
-		hisi_sas_show_row_64(s, tab_idx, cache_size, iost);
-	}
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_iost_cache_open(struct inode *inode,
-					    struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_iost_cache_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_iost_cache_fops = {
-	.open = hisi_sas_debugfs_iost_cache_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int hisi_sas_debugfs_itct_show(struct seq_file *s, void *p)
-{
-	int i;
-	struct hisi_sas_debugfs_itct *debugfs_itct = s->private;
-	struct hisi_sas_itct *itct = debugfs_itct->itct;
-
-	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
-		__le64 *data = &itct->qw0;
-
-		hisi_sas_show_row_64(s, i, sizeof(*itct), data);
-	}
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_itct_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_itct_show, inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_itct_fops = {
-	.open = hisi_sas_debugfs_itct_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int hisi_sas_debugfs_itct_cache_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_debugfs_itct_cache *debugfs_itct_cache = s->private;
-	struct hisi_sas_iost_itct_cache *itct_cache = debugfs_itct_cache->cache;
-	u32 cache_size = HISI_SAS_IOST_ITCT_CACHE_DW_SZ * 4;
-	int i, tab_idx;
-	__le64 *itct;
-
-	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, itct_cache++) {
-		/*
-		 * Data struct of ITCT cache:
-		 * Data[1]: BIT0~15: Table index
-		 *	    Bit16:   Valid mask
-		 * Data[2]~[9]: ITCT table
-		 */
-		tab_idx = itct_cache->data[1] & 0xffff;
-		itct = (__le64 *)itct_cache;
-
-		hisi_sas_show_row_64(s, tab_idx, cache_size, itct);
-	}
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_itct_cache_open(struct inode *inode,
-					    struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_itct_cache_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_itct_cache_fops = {
-	.open = hisi_sas_debugfs_itct_cache_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
-{
-	u64 *debugfs_timestamp;
-	int dump_index = hisi_hba->debugfs_dump_index;
-	struct dentry *dump_dentry;
-	struct dentry *dentry;
-	char name[256];
-	int p;
-	int c;
-	int d;
-
-	snprintf(name, 256, "%d", dump_index);
-
-	dump_dentry = debugfs_create_dir(name, hisi_hba->debugfs_dump_dentry);
-
-	debugfs_timestamp = &hisi_hba->debugfs_timestamp[dump_index];
-
-	debugfs_create_u64("timestamp", 0400, dump_dentry,
-			   debugfs_timestamp);
-
-	debugfs_create_file("global", 0400, dump_dentry,
-			   &hisi_hba->debugfs_regs[dump_index][DEBUGFS_GLOBAL],
-			   &hisi_sas_debugfs_global_fops);
-
-	/* Create port dir and files */
-	dentry = debugfs_create_dir("port", dump_dentry);
-	for (p = 0; p < hisi_hba->n_phy; p++) {
-		snprintf(name, 256, "%d", p);
-
-		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_port_reg[dump_index][p],
-				    &hisi_sas_debugfs_port_fops);
-	}
-
-	/* Create CQ dir and files */
-	dentry = debugfs_create_dir("cq", dump_dentry);
-	for (c = 0; c < hisi_hba->queue_count; c++) {
-		snprintf(name, 256, "%d", c);
-
-		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_cq[dump_index][c],
-				    &hisi_sas_debugfs_cq_fops);
-	}
-
-	/* Create DQ dir and files */
-	dentry = debugfs_create_dir("dq", dump_dentry);
-	for (d = 0; d < hisi_hba->queue_count; d++) {
-		snprintf(name, 256, "%d", d);
-
-		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_dq[dump_index][d],
-				    &hisi_sas_debugfs_dq_fops);
-	}
-
-	debugfs_create_file("iost", 0400, dump_dentry,
-			    &hisi_hba->debugfs_iost[dump_index],
-			    &hisi_sas_debugfs_iost_fops);
-
-	debugfs_create_file("iost_cache", 0400, dump_dentry,
-			    &hisi_hba->debugfs_iost_cache[dump_index],
-			    &hisi_sas_debugfs_iost_cache_fops);
-
-	debugfs_create_file("itct", 0400, dump_dentry,
-			    &hisi_hba->debugfs_itct[dump_index],
-			    &hisi_sas_debugfs_itct_fops);
-
-	debugfs_create_file("itct_cache", 0400, dump_dentry,
-			    &hisi_hba->debugfs_itct_cache[dump_index],
-			    &hisi_sas_debugfs_itct_cache_fops);
-
-	debugfs_create_file("axi", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_AXI],
-			    &hisi_sas_debugfs_axi_fops);
-
-	debugfs_create_file("ras", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_RAS],
-			    &hisi_sas_debugfs_ras_fops);
-
-	return;
-}
-
-static void hisi_sas_debugfs_snapshot_regs(struct hisi_hba *hisi_hba)
-{
-	hisi_hba->hw->snapshot_prepare(hisi_hba);
-
-	hisi_sas_debugfs_snapshot_global_reg(hisi_hba);
-	hisi_sas_debugfs_snapshot_port_reg(hisi_hba);
-	hisi_sas_debugfs_snapshot_axi_reg(hisi_hba);
-	hisi_sas_debugfs_snapshot_ras_reg(hisi_hba);
-	hisi_sas_debugfs_snapshot_cq_reg(hisi_hba);
-	hisi_sas_debugfs_snapshot_dq_reg(hisi_hba);
-	hisi_sas_debugfs_snapshot_itct_reg(hisi_hba);
-	hisi_sas_debugfs_snapshot_iost_reg(hisi_hba);
-
-	hisi_sas_debugfs_create_files(hisi_hba);
-
-	hisi_hba->hw->snapshot_restore(hisi_hba);
-}
-
-static ssize_t hisi_sas_debugfs_trigger_dump_write(struct file *file,
-						   const char __user *user_buf,
-						   size_t count, loff_t *ppos)
-{
-	struct hisi_hba *hisi_hba = file->f_inode->i_private;
-	char buf[8];
-
-	if (hisi_hba->debugfs_dump_index >= hisi_sas_debugfs_dump_count)
-		return -EFAULT;
-
-	if (count > 8)
-		return -EFAULT;
-
-	if (copy_from_user(buf, user_buf, count))
-		return -EFAULT;
-
-	if (buf[0] != '1')
-		return -EFAULT;
-
-	queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
-
-	return count;
-}
-
-static const struct file_operations hisi_sas_debugfs_trigger_dump_fops = {
-	.write = &hisi_sas_debugfs_trigger_dump_write,
-	.owner = THIS_MODULE,
-};
-
-enum {
-	HISI_SAS_BIST_LOOPBACK_MODE_DIGITAL = 0,
-	HISI_SAS_BIST_LOOPBACK_MODE_SERDES,
-	HISI_SAS_BIST_LOOPBACK_MODE_REMOTE,
-};
-
-static const struct {
-	int		value;
-	char		*name;
-} hisi_sas_debugfs_loop_linkrate[] = {
-	{ SAS_LINK_RATE_1_5_GBPS, "1.5 Gbit" },
-	{ SAS_LINK_RATE_3_0_GBPS, "3.0 Gbit" },
-	{ SAS_LINK_RATE_6_0_GBPS, "6.0 Gbit" },
-	{ SAS_LINK_RATE_12_0_GBPS, "12.0 Gbit" },
-};
-
-static int hisi_sas_debugfs_bist_linkrate_show(struct seq_file *s, void *p)
-{
-	struct hisi_hba *hisi_hba = s->private;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(hisi_sas_debugfs_loop_linkrate); i++) {
-		int match = (hisi_hba->debugfs_bist_linkrate ==
-			     hisi_sas_debugfs_loop_linkrate[i].value);
-
-		seq_printf(s, "%s%s%s ", match ? "[" : "",
-			   hisi_sas_debugfs_loop_linkrate[i].name,
-			   match ? "]" : "");
-	}
-	seq_puts(s, "\n");
-
-	return 0;
-}
-
-static ssize_t hisi_sas_debugfs_bist_linkrate_write(struct file *filp,
-						    const char __user *buf,
-						    size_t count, loff_t *ppos)
-{
-	struct seq_file *m = filp->private_data;
-	struct hisi_hba *hisi_hba = m->private;
-	char kbuf[16] = {}, *pkbuf;
-	bool found = false;
-	int i;
-
-	if (hisi_hba->debugfs_bist_enable)
-		return -EPERM;
-
-	if (count >= sizeof(kbuf))
-		return -EOVERFLOW;
-
-	if (copy_from_user(kbuf, buf, count))
-		return -EINVAL;
-
-	pkbuf = strstrip(kbuf);
-
-	for (i = 0; i < ARRAY_SIZE(hisi_sas_debugfs_loop_linkrate); i++) {
-		if (!strncmp(hisi_sas_debugfs_loop_linkrate[i].name,
-			     pkbuf, 16)) {
-			hisi_hba->debugfs_bist_linkrate =
-				hisi_sas_debugfs_loop_linkrate[i].value;
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return -EINVAL;
-
-	return count;
-}
-
-static int hisi_sas_debugfs_bist_linkrate_open(struct inode *inode,
-					       struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_bist_linkrate_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_bist_linkrate_ops = {
-	.open = hisi_sas_debugfs_bist_linkrate_open,
-	.read = seq_read,
-	.write = hisi_sas_debugfs_bist_linkrate_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static const struct {
-	int		value;
-	char		*name;
-} hisi_sas_debugfs_loop_code_mode[] = {
-	{ HISI_SAS_BIST_CODE_MODE_PRBS7, "PRBS7" },
-	{ HISI_SAS_BIST_CODE_MODE_PRBS23, "PRBS23" },
-	{ HISI_SAS_BIST_CODE_MODE_PRBS31, "PRBS31" },
-	{ HISI_SAS_BIST_CODE_MODE_JTPAT, "JTPAT" },
-	{ HISI_SAS_BIST_CODE_MODE_CJTPAT, "CJTPAT" },
-	{ HISI_SAS_BIST_CODE_MODE_SCRAMBED_0, "SCRAMBED_0" },
-	{ HISI_SAS_BIST_CODE_MODE_TRAIN, "TRAIN" },
-	{ HISI_SAS_BIST_CODE_MODE_TRAIN_DONE, "TRAIN_DONE" },
-	{ HISI_SAS_BIST_CODE_MODE_HFTP, "HFTP" },
-	{ HISI_SAS_BIST_CODE_MODE_MFTP, "MFTP" },
-	{ HISI_SAS_BIST_CODE_MODE_LFTP, "LFTP" },
-	{ HISI_SAS_BIST_CODE_MODE_FIXED_DATA, "FIXED_DATA" },
-};
-
-static int hisi_sas_debugfs_bist_code_mode_show(struct seq_file *s, void *p)
-{
-	struct hisi_hba *hisi_hba = s->private;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(hisi_sas_debugfs_loop_code_mode); i++) {
-		int match = (hisi_hba->debugfs_bist_code_mode ==
-			     hisi_sas_debugfs_loop_code_mode[i].value);
-
-		seq_printf(s, "%s%s%s ", match ? "[" : "",
-			   hisi_sas_debugfs_loop_code_mode[i].name,
-			   match ? "]" : "");
-	}
-	seq_puts(s, "\n");
-
-	return 0;
-}
-
-static ssize_t hisi_sas_debugfs_bist_code_mode_write(struct file *filp,
-						     const char __user *buf,
-						     size_t count,
-						     loff_t *ppos)
-{
-	struct seq_file *m = filp->private_data;
-	struct hisi_hba *hisi_hba = m->private;
-	char kbuf[16] = {}, *pkbuf;
-	bool found = false;
-	int i;
-
-	if (hisi_hba->debugfs_bist_enable)
-		return -EPERM;
-
-	if (count >= sizeof(kbuf))
-		return -EINVAL;
-
-	if (copy_from_user(kbuf, buf, count))
-		return -EOVERFLOW;
-
-	pkbuf = strstrip(kbuf);
-
-	for (i = 0; i < ARRAY_SIZE(hisi_sas_debugfs_loop_code_mode); i++) {
-		if (!strncmp(hisi_sas_debugfs_loop_code_mode[i].name,
-			     pkbuf, 16)) {
-			hisi_hba->debugfs_bist_code_mode =
-				hisi_sas_debugfs_loop_code_mode[i].value;
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return -EINVAL;
-
-	return count;
-}
-
-static int hisi_sas_debugfs_bist_code_mode_open(struct inode *inode,
-						struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_bist_code_mode_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_bist_code_mode_ops = {
-	.open = hisi_sas_debugfs_bist_code_mode_open,
-	.read = seq_read,
-	.write = hisi_sas_debugfs_bist_code_mode_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static ssize_t hisi_sas_debugfs_bist_phy_write(struct file *filp,
-					       const char __user *buf,
-					       size_t count, loff_t *ppos)
-{
-	struct seq_file *m = filp->private_data;
-	struct hisi_hba *hisi_hba = m->private;
-	unsigned int phy_no;
-	int val;
-
-	if (hisi_hba->debugfs_bist_enable)
-		return -EPERM;
-
-	val = kstrtouint_from_user(buf, count, 0, &phy_no);
-	if (val)
-		return val;
-
-	if (phy_no >= hisi_hba->n_phy)
-		return -EINVAL;
-
-	hisi_hba->debugfs_bist_phy_no = phy_no;
-
-	return count;
-}
-
-static int hisi_sas_debugfs_bist_phy_show(struct seq_file *s, void *p)
-{
-	struct hisi_hba *hisi_hba = s->private;
-
-	seq_printf(s, "%d\n", hisi_hba->debugfs_bist_phy_no);
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_bist_phy_open(struct inode *inode,
-					  struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_bist_phy_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_bist_phy_ops = {
-	.open = hisi_sas_debugfs_bist_phy_open,
-	.read = seq_read,
-	.write = hisi_sas_debugfs_bist_phy_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static const struct {
-	int		value;
-	char		*name;
-} hisi_sas_debugfs_loop_modes[] = {
-	{ HISI_SAS_BIST_LOOPBACK_MODE_DIGITAL, "digital" },
-	{ HISI_SAS_BIST_LOOPBACK_MODE_SERDES, "serdes" },
-	{ HISI_SAS_BIST_LOOPBACK_MODE_REMOTE, "remote" },
-};
-
-static int hisi_sas_debugfs_bist_mode_show(struct seq_file *s, void *p)
-{
-	struct hisi_hba *hisi_hba = s->private;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(hisi_sas_debugfs_loop_modes); i++) {
-		int match = (hisi_hba->debugfs_bist_mode ==
-			     hisi_sas_debugfs_loop_modes[i].value);
-
-		seq_printf(s, "%s%s%s ", match ? "[" : "",
-			   hisi_sas_debugfs_loop_modes[i].name,
-			   match ? "]" : "");
-	}
-	seq_puts(s, "\n");
-
-	return 0;
-}
-
-static ssize_t hisi_sas_debugfs_bist_mode_write(struct file *filp,
-						const char __user *buf,
-						size_t count, loff_t *ppos)
-{
-	struct seq_file *m = filp->private_data;
-	struct hisi_hba *hisi_hba = m->private;
-	char kbuf[16] = {}, *pkbuf;
-	bool found = false;
-	int i;
-
-	if (hisi_hba->debugfs_bist_enable)
-		return -EPERM;
-
-	if (count >= sizeof(kbuf))
-		return -EINVAL;
-
-	if (copy_from_user(kbuf, buf, count))
-		return -EOVERFLOW;
-
-	pkbuf = strstrip(kbuf);
-
-	for (i = 0; i < ARRAY_SIZE(hisi_sas_debugfs_loop_modes); i++) {
-		if (!strncmp(hisi_sas_debugfs_loop_modes[i].name, pkbuf, 16)) {
-			hisi_hba->debugfs_bist_mode =
-				hisi_sas_debugfs_loop_modes[i].value;
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return -EINVAL;
-
-	return count;
-}
-
-static int hisi_sas_debugfs_bist_mode_open(struct inode *inode,
-					   struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_bist_mode_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_bist_mode_ops = {
-	.open = hisi_sas_debugfs_bist_mode_open,
-	.read = seq_read,
-	.write = hisi_sas_debugfs_bist_mode_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static ssize_t hisi_sas_debugfs_bist_enable_write(struct file *filp,
-						  const char __user *buf,
-						  size_t count, loff_t *ppos)
-{
-	struct seq_file *m = filp->private_data;
-	struct hisi_hba *hisi_hba = m->private;
-	unsigned int enable;
-	int val;
-
-	val = kstrtouint_from_user(buf, count, 0, &enable);
-	if (val)
-		return val;
-
-	if (enable > 1)
-		return -EINVAL;
-
-	if (enable == hisi_hba->debugfs_bist_enable)
-		return count;
-
-	if (!hisi_hba->hw->set_bist)
-		return -EPERM;
-
-	val = hisi_hba->hw->set_bist(hisi_hba, enable);
-	if (val < 0)
-		return val;
-
-	hisi_hba->debugfs_bist_enable = enable;
-
-	return count;
-}
-
-static int hisi_sas_debugfs_bist_enable_show(struct seq_file *s, void *p)
-{
-	struct hisi_hba *hisi_hba = s->private;
-
-	seq_printf(s, "%d\n", hisi_hba->debugfs_bist_enable);
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_bist_enable_open(struct inode *inode,
-					     struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_bist_enable_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_bist_enable_ops = {
-	.open = hisi_sas_debugfs_bist_enable_open,
-	.read = seq_read,
-	.write = hisi_sas_debugfs_bist_enable_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static const struct {
-	char *name;
-} hisi_sas_debugfs_ffe_name[FFE_CFG_MAX] = {
-	{ "SAS_1_5_GBPS" },
-	{ "SAS_3_0_GBPS" },
-	{ "SAS_6_0_GBPS" },
-	{ "SAS_12_0_GBPS" },
-	{ "FFE_RESV" },
-	{ "SATA_1_5_GBPS" },
-	{ "SATA_3_0_GBPS" },
-	{ "SATA_6_0_GBPS" },
-};
-
-static ssize_t hisi_sas_debugfs_write(struct file *filp,
-				      const char __user *buf,
-				      size_t count, loff_t *ppos)
-{
-	struct seq_file *m = filp->private_data;
-	u32 *val = m->private;
-	int res;
-
-	res = kstrtouint_from_user(buf, count, 0, val);
-	if (res)
-		return res;
-
-	return count;
-}
-
-static int hisi_sas_debugfs_show(struct seq_file *s, void *p)
-{
-	u32 *val = s->private;
-
-	seq_printf(s, "0x%x\n", *val);
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_ops = {
-	.open = hisi_sas_debugfs_open,
-	.read = seq_read,
-	.write = hisi_sas_debugfs_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static ssize_t hisi_sas_debugfs_phy_down_cnt_write(struct file *filp,
-						   const char __user *buf,
-						   size_t count, loff_t *ppos)
-{
-	struct seq_file *s = filp->private_data;
-	struct hisi_sas_phy *phy = s->private;
-	unsigned int set_val;
-	int res;
-
-	res = kstrtouint_from_user(buf, count, 0, &set_val);
-	if (res)
-		return res;
-
-	if (set_val > 0)
-		return -EINVAL;
-
-	atomic_set(&phy->down_cnt, 0);
-
-	return count;
-}
-
-static int hisi_sas_debugfs_phy_down_cnt_show(struct seq_file *s, void *p)
-{
-	struct hisi_sas_phy *phy = s->private;
-
-	seq_printf(s, "%d\n", atomic_read(&phy->down_cnt));
-
-	return 0;
-}
-
-static int hisi_sas_debugfs_phy_down_cnt_open(struct inode *inode,
-					      struct file *filp)
-{
-	return single_open(filp, hisi_sas_debugfs_phy_down_cnt_show,
-			   inode->i_private);
-}
-
-static const struct file_operations hisi_sas_debugfs_phy_down_cnt_ops = {
-	.open = hisi_sas_debugfs_phy_down_cnt_open,
-	.read = seq_read,
-	.write = hisi_sas_debugfs_phy_down_cnt_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-void hisi_sas_debugfs_work_handler(struct work_struct *work)
-{
-	struct hisi_hba *hisi_hba =
-		container_of(work, struct hisi_hba, debugfs_work);
-	int debugfs_dump_index = hisi_hba->debugfs_dump_index;
-	struct device *dev = hisi_hba->dev;
-	u64 timestamp = local_clock();
-
-	if (debugfs_dump_index >= hisi_sas_debugfs_dump_count) {
-		dev_warn(dev, "dump count exceeded!\n");
-		return;
-	}
-
-	do_div(timestamp, NSEC_PER_MSEC);
-	hisi_hba->debugfs_timestamp[debugfs_dump_index] = timestamp;
-
-	hisi_sas_debugfs_snapshot_regs(hisi_hba);
-	hisi_hba->debugfs_dump_index++;
-}
-EXPORT_SYMBOL_GPL(hisi_sas_debugfs_work_handler);
-
-static void hisi_sas_debugfs_release(struct hisi_hba *hisi_hba, int dump_index)
-{
-	struct device *dev = hisi_hba->dev;
-	int i;
-
-	devm_kfree(dev, hisi_hba->debugfs_iost_cache[dump_index].cache);
-	devm_kfree(dev, hisi_hba->debugfs_itct_cache[dump_index].cache);
-	devm_kfree(dev, hisi_hba->debugfs_iost[dump_index].iost);
-	devm_kfree(dev, hisi_hba->debugfs_itct[dump_index].itct);
-
-	for (i = 0; i < hisi_hba->queue_count; i++)
-		devm_kfree(dev, hisi_hba->debugfs_dq[dump_index][i].hdr);
-
-	for (i = 0; i < hisi_hba->queue_count; i++)
-		devm_kfree(dev,
-			   hisi_hba->debugfs_cq[dump_index][i].complete_hdr);
-
-	for (i = 0; i < DEBUGFS_REGS_NUM; i++)
-		devm_kfree(dev, hisi_hba->debugfs_regs[dump_index][i].data);
-
-	for (i = 0; i < hisi_hba->n_phy; i++)
-		devm_kfree(dev, hisi_hba->debugfs_port_reg[dump_index][i].data);
-}
-
-static int hisi_sas_debugfs_alloc(struct hisi_hba *hisi_hba, int dump_index)
-{
-	const struct hisi_sas_hw *hw = hisi_hba->hw;
-	struct device *dev = hisi_hba->dev;
-	int p, c, d, r, i;
-	size_t sz;
-
-	for (r = 0; r < DEBUGFS_REGS_NUM; r++) {
-		struct hisi_sas_debugfs_regs *regs =
-				&hisi_hba->debugfs_regs[dump_index][r];
-
-		sz = hw->debugfs_reg_array[r]->count * 4;
-		regs->data = devm_kmalloc(dev, sz, GFP_KERNEL);
-		if (!regs->data)
-			goto fail;
-		regs->hisi_hba = hisi_hba;
-	}
-
-	sz = hw->debugfs_reg_port->count * 4;
-	for (p = 0; p < hisi_hba->n_phy; p++) {
-		struct hisi_sas_debugfs_port *port =
-				&hisi_hba->debugfs_port_reg[dump_index][p];
-
-		port->data = devm_kmalloc(dev, sz, GFP_KERNEL);
-		if (!port->data)
-			goto fail;
-		port->phy = &hisi_hba->phy[p];
-	}
-
-	sz = hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
-	for (c = 0; c < hisi_hba->queue_count; c++) {
-		struct hisi_sas_debugfs_cq *cq =
-				&hisi_hba->debugfs_cq[dump_index][c];
-
-		cq->complete_hdr = devm_kmalloc(dev, sz, GFP_KERNEL);
-		if (!cq->complete_hdr)
-			goto fail;
-		cq->cq = &hisi_hba->cq[c];
-	}
-
-	sz = sizeof(struct hisi_sas_cmd_hdr) * HISI_SAS_QUEUE_SLOTS;
-	for (d = 0; d < hisi_hba->queue_count; d++) {
-		struct hisi_sas_debugfs_dq *dq =
-				&hisi_hba->debugfs_dq[dump_index][d];
-
-		dq->hdr = devm_kmalloc(dev, sz, GFP_KERNEL);
-		if (!dq->hdr)
-			goto fail;
-		dq->dq = &hisi_hba->dq[d];
-	}
-
-	sz = HISI_SAS_MAX_COMMANDS * sizeof(struct hisi_sas_iost);
-
-	hisi_hba->debugfs_iost[dump_index].iost =
-				devm_kmalloc(dev, sz, GFP_KERNEL);
-	if (!hisi_hba->debugfs_iost[dump_index].iost)
-		goto fail;
-
-	sz = HISI_SAS_IOST_ITCT_CACHE_NUM *
-	     sizeof(struct hisi_sas_iost_itct_cache);
-
-	hisi_hba->debugfs_iost_cache[dump_index].cache =
-				devm_kmalloc(dev, sz, GFP_KERNEL);
-	if (!hisi_hba->debugfs_iost_cache[dump_index].cache)
-		goto fail;
-
-	sz = HISI_SAS_IOST_ITCT_CACHE_NUM *
-	     sizeof(struct hisi_sas_iost_itct_cache);
-
-	hisi_hba->debugfs_itct_cache[dump_index].cache =
-				devm_kmalloc(dev, sz, GFP_KERNEL);
-	if (!hisi_hba->debugfs_itct_cache[dump_index].cache)
-		goto fail;
-
-	/* New memory allocation must be locate before itct */
-	sz = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_itct);
-
-	hisi_hba->debugfs_itct[dump_index].itct =
-				devm_kmalloc(dev, sz, GFP_KERNEL);
-	if (!hisi_hba->debugfs_itct[dump_index].itct)
-		goto fail;
-
-	return 0;
-fail:
-	for (i = 0; i < hisi_sas_debugfs_dump_count; i++)
-		hisi_sas_debugfs_release(hisi_hba, i);
-	return -ENOMEM;
-}
-
-static void hisi_sas_debugfs_phy_down_cnt_init(struct hisi_hba *hisi_hba)
-{
-	struct dentry *dir = debugfs_create_dir("phy_down_cnt",
-						hisi_hba->debugfs_dir);
-	char name[16];
-	int phy_no;
-
-	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
-		snprintf(name, 16, "%d", phy_no);
-		debugfs_create_file(name, 0600, dir,
-				    &hisi_hba->phy[phy_no],
-				    &hisi_sas_debugfs_phy_down_cnt_ops);
-	}
-}
-
-static void hisi_sas_debugfs_bist_init(struct hisi_hba *hisi_hba)
-{
-	struct dentry *ports_dentry;
-	int phy_no;
-
-	hisi_hba->debugfs_bist_dentry =
-			debugfs_create_dir("bist", hisi_hba->debugfs_dir);
-	debugfs_create_file("link_rate", 0600,
-			    hisi_hba->debugfs_bist_dentry, hisi_hba,
-			    &hisi_sas_debugfs_bist_linkrate_ops);
-
-	debugfs_create_file("code_mode", 0600,
-			    hisi_hba->debugfs_bist_dentry, hisi_hba,
-			    &hisi_sas_debugfs_bist_code_mode_ops);
-
-	debugfs_create_file("fixed_code", 0600,
-			    hisi_hba->debugfs_bist_dentry,
-			    &hisi_hba->debugfs_bist_fixed_code[0],
-			    &hisi_sas_debugfs_ops);
-
-	debugfs_create_file("fixed_code_1", 0600,
-			    hisi_hba->debugfs_bist_dentry,
-			    &hisi_hba->debugfs_bist_fixed_code[1],
-			    &hisi_sas_debugfs_ops);
-
-	debugfs_create_file("phy_id", 0600, hisi_hba->debugfs_bist_dentry,
-			    hisi_hba, &hisi_sas_debugfs_bist_phy_ops);
-
-	debugfs_create_u32("cnt", 0600, hisi_hba->debugfs_bist_dentry,
-			   &hisi_hba->debugfs_bist_cnt);
-
-	debugfs_create_file("loopback_mode", 0600,
-			    hisi_hba->debugfs_bist_dentry,
-			    hisi_hba, &hisi_sas_debugfs_bist_mode_ops);
-
-	debugfs_create_file("enable", 0600, hisi_hba->debugfs_bist_dentry,
-			    hisi_hba, &hisi_sas_debugfs_bist_enable_ops);
-
-	ports_dentry = debugfs_create_dir("port", hisi_hba->debugfs_bist_dentry);
-
-	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
-		struct dentry *port_dentry;
-		struct dentry *ffe_dentry;
-		char name[256];
-		int i;
-
-		snprintf(name, 256, "%d", phy_no);
-		port_dentry = debugfs_create_dir(name, ports_dentry);
-		ffe_dentry = debugfs_create_dir("ffe", port_dentry);
-		for (i = 0; i < FFE_CFG_MAX; i++) {
-			if (i == FFE_RESV)
-				continue;
-			debugfs_create_file(hisi_sas_debugfs_ffe_name[i].name,
-					    0600, ffe_dentry,
-					    &hisi_hba->debugfs_bist_ffe[phy_no][i],
-					    &hisi_sas_debugfs_ops);
-		}
-	}
-
-	hisi_hba->debugfs_bist_linkrate = SAS_LINK_RATE_1_5_GBPS;
-}
-
-void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
-{
-	struct device *dev = hisi_hba->dev;
-	int i;
-
-	hisi_hba->debugfs_dir = debugfs_create_dir(dev_name(dev),
-						   hisi_sas_debugfs_dir);
-	debugfs_create_file("trigger_dump", 0200,
-			    hisi_hba->debugfs_dir,
-			    hisi_hba,
-			    &hisi_sas_debugfs_trigger_dump_fops);
-
-	/* create bist structures */
-	hisi_sas_debugfs_bist_init(hisi_hba);
-
-	hisi_hba->debugfs_dump_dentry =
-			debugfs_create_dir("dump", hisi_hba->debugfs_dir);
-
-	hisi_sas_debugfs_phy_down_cnt_init(hisi_hba);
-
-	for (i = 0; i < hisi_sas_debugfs_dump_count; i++) {
-		if (hisi_sas_debugfs_alloc(hisi_hba, i)) {
-			debugfs_remove_recursive(hisi_hba->debugfs_dir);
-			dev_dbg(dev, "failed to init debugfs!\n");
-			break;
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(hisi_sas_debugfs_init);
-
-void hisi_sas_debugfs_exit(struct hisi_hba *hisi_hba)
-{
-	debugfs_remove_recursive(hisi_hba->debugfs_dir);
-}
-EXPORT_SYMBOL_GPL(hisi_sas_debugfs_exit);
-
 int hisi_sas_remove(struct platform_device *pdev)
 {
 	struct sas_ha_struct *sha = platform_get_drvdata(pdev);
@@ -4067,6 +2724,9 @@ EXPORT_SYMBOL_GPL(hisi_sas_debugfs_dump_count);
 module_param_named(debugfs_dump_count, hisi_sas_debugfs_dump_count, uint, 0444);
 MODULE_PARM_DESC(hisi_sas_debugfs_dump_count, "Number of debugfs dumps to allow");
 
+struct dentry *hisi_sas_debugfs_dir;
+EXPORT_SYMBOL_GPL(hisi_sas_debugfs_dir);
+
 static __init int hisi_sas_init(void)
 {
 	hisi_sas_stt = sas_domain_attach_transport(&hisi_sas_transport_ops);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index f6d0aa3a8c11..9f294f94d825 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -522,6 +522,8 @@ module_param(auto_affine_msi_experimental, bool, 0444);
 MODULE_PARM_DESC(auto_affine_msi_experimental, "Enable auto-affinity of MSI IRQs as experimental:\n"
 		 "default is off");
 
+static void debugfs_work_handler_v3_hw(struct work_struct *work);
+
 static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 {
 	void __iomem *regs = hisi_hba->regs + off;
@@ -2753,6 +2755,19 @@ static struct device_attribute *host_attrs_v3_hw[] = {
 	NULL
 };
 
+#define HISI_SAS_DEBUGFS_REG(x) {#x, x}
+
+struct hisi_sas_debugfs_reg_lu {
+	char *name;
+	int off;
+};
+
+struct hisi_sas_debugfs_reg {
+	const struct hisi_sas_debugfs_reg_lu *lu;
+	int count;
+	int base_off;
+};
+
 static const struct hisi_sas_debugfs_reg_lu debugfs_port_reg_lu[] = {
 	HISI_SAS_DEBUGFS_REG(PHY_CFG),
 	HISI_SAS_DEBUGFS_REG(HARD_PHY_LINKRATE),
@@ -2808,7 +2823,6 @@ static const struct hisi_sas_debugfs_reg debugfs_port_reg = {
 	.lu = debugfs_port_reg_lu,
 	.count = 0x100,
 	.base_off = PORT_BASE,
-	.read_port_reg = hisi_sas_phy_read32,
 };
 
 static const struct hisi_sas_debugfs_reg_lu debugfs_global_reg_lu[] = {
@@ -2881,7 +2895,6 @@ static const struct hisi_sas_debugfs_reg_lu debugfs_global_reg_lu[] = {
 static const struct hisi_sas_debugfs_reg debugfs_global_reg = {
 	.lu = debugfs_global_reg_lu,
 	.count = 0x800,
-	.read_global_reg = hisi_sas_read32,
 };
 
 static const struct hisi_sas_debugfs_reg_lu debugfs_axi_reg_lu[] = {
@@ -2896,7 +2909,6 @@ static const struct hisi_sas_debugfs_reg debugfs_axi_reg = {
 	.lu = debugfs_axi_reg_lu,
 	.count = 0x61,
 	.base_off = AXI_MASTER_CFG_BASE,
-	.read_global_reg = hisi_sas_read32,
 };
 
 static const struct hisi_sas_debugfs_reg_lu debugfs_ras_reg_lu[] = {
@@ -2914,7 +2926,6 @@ static const struct hisi_sas_debugfs_reg debugfs_ras_reg = {
 	.lu = debugfs_ras_reg_lu,
 	.count = 0x10,
 	.base_off = RAS_BASE,
-	.read_global_reg = hisi_sas_read32,
 };
 
 static void debugfs_snapshot_prepare_v3_hw(struct hisi_hba *hisi_hba)
@@ -3156,14 +3167,6 @@ static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.get_events = phy_get_events_v3_hw,
 	.write_gpio = write_gpio_v3_hw,
 	.wait_cmds_complete_timeout = wait_cmds_complete_timeout_v3_hw,
-	.debugfs_reg_array[DEBUGFS_GLOBAL] = &debugfs_global_reg,
-	.debugfs_reg_array[DEBUGFS_AXI] = &debugfs_axi_reg,
-	.debugfs_reg_array[DEBUGFS_RAS] = &debugfs_ras_reg,
-	.debugfs_reg_port = &debugfs_port_reg,
-	.snapshot_prepare = debugfs_snapshot_prepare_v3_hw,
-	.snapshot_restore = debugfs_snapshot_restore_v3_hw,
-	.read_iost_itct_cache = read_iost_itct_cache_v3_hw,
-	.set_bist = debugfs_set_bist_v3_hw,
 };
 
 static struct Scsi_Host *
@@ -3181,7 +3184,7 @@ hisi_sas_shost_alloc_pci(struct pci_dev *pdev)
 	hisi_hba = shost_priv(shost);
 
 	INIT_WORK(&hisi_hba->rst_work, hisi_sas_rst_work_handler);
-	INIT_WORK(&hisi_hba->debugfs_work, hisi_sas_debugfs_work_handler);
+	INIT_WORK(&hisi_hba->debugfs_work, debugfs_work_handler_v3_hw);
 	hisi_hba->hw = &hisi_sas_v3_hw;
 	hisi_hba->pci_dev = pdev;
 	hisi_hba->dev = dev;
@@ -3209,6 +3212,1196 @@ hisi_sas_shost_alloc_pci(struct pci_dev *pdev)
 	return NULL;
 }
 
+static void debugfs_snapshot_cq_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int queue_entry_size = hisi_hba->hw->complete_hdr_size;
+	int dump_index = hisi_hba->debugfs_dump_index;
+	int i;
+
+	for (i = 0; i < hisi_hba->queue_count; i++)
+		memcpy(hisi_hba->debugfs_cq[dump_index][i].complete_hdr,
+		       hisi_hba->complete_hdr[i],
+		       HISI_SAS_QUEUE_SLOTS * queue_entry_size);
+}
+
+static void debugfs_snapshot_dq_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int queue_entry_size = sizeof(struct hisi_sas_cmd_hdr);
+	int dump_index = hisi_hba->debugfs_dump_index;
+	int i;
+
+	for (i = 0; i < hisi_hba->queue_count; i++) {
+		struct hisi_sas_cmd_hdr *debugfs_cmd_hdr, *cmd_hdr;
+		int j;
+
+		debugfs_cmd_hdr = hisi_hba->debugfs_dq[dump_index][i].hdr;
+		cmd_hdr = hisi_hba->cmd_hdr[i];
+
+		for (j = 0; j < HISI_SAS_QUEUE_SLOTS; j++)
+			memcpy(&debugfs_cmd_hdr[j], &cmd_hdr[j],
+			       queue_entry_size);
+	}
+}
+
+static void debugfs_snapshot_port_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int dump_index = hisi_hba->debugfs_dump_index;
+	const struct hisi_sas_debugfs_reg *port = &debugfs_port_reg;
+	int i, phy_cnt;
+	u32 offset;
+	u32 *databuf;
+
+	for (phy_cnt = 0; phy_cnt < hisi_hba->n_phy; phy_cnt++) {
+		databuf = hisi_hba->debugfs_port_reg[dump_index][phy_cnt].data;
+		for (i = 0; i < port->count; i++, databuf++) {
+			offset = port->base_off + 4 * i;
+			*databuf = hisi_sas_phy_read32(hisi_hba, phy_cnt,
+						       offset);
+		}
+	}
+}
+
+static void debugfs_snapshot_global_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int dump_index = hisi_hba->debugfs_dump_index;
+	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_GLOBAL].data;
+	int i;
+
+	for (i = 0; i < debugfs_axi_reg.count; i++, databuf++)
+		*databuf = hisi_sas_read32(hisi_hba, 4 * i);
+}
+
+static void debugfs_snapshot_axi_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int dump_index = hisi_hba->debugfs_dump_index;
+	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_AXI].data;
+	const struct hisi_sas_debugfs_reg *axi = &debugfs_axi_reg;
+	int i;
+
+	for (i = 0; i < axi->count; i++, databuf++)
+		*databuf = hisi_sas_read32(hisi_hba, 4 * i + axi->base_off);
+}
+
+static void debugfs_snapshot_ras_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int dump_index = hisi_hba->debugfs_dump_index;
+	u32 *databuf = hisi_hba->debugfs_regs[dump_index][DEBUGFS_RAS].data;
+	const struct hisi_sas_debugfs_reg *ras = &debugfs_ras_reg;
+	int i;
+
+	for (i = 0; i < ras->count; i++, databuf++)
+		*databuf = hisi_sas_read32(hisi_hba, 4 * i + ras->base_off);
+}
+
+static void debugfs_snapshot_itct_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int dump_index = hisi_hba->debugfs_dump_index;
+	void *cachebuf = hisi_hba->debugfs_itct_cache[dump_index].cache;
+	void *databuf = hisi_hba->debugfs_itct[dump_index].itct;
+	struct hisi_sas_itct *itct;
+	int i;
+
+	read_iost_itct_cache_v3_hw(hisi_hba, HISI_SAS_ITCT_CACHE, cachebuf);
+
+	itct = hisi_hba->itct;
+
+	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
+		memcpy(databuf, itct, sizeof(struct hisi_sas_itct));
+		databuf += sizeof(struct hisi_sas_itct);
+	}
+}
+
+static void debugfs_snapshot_iost_reg_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int dump_index = hisi_hba->debugfs_dump_index;
+	int max_command_entries = HISI_SAS_MAX_COMMANDS;
+	void *cachebuf = hisi_hba->debugfs_iost_cache[dump_index].cache;
+	void *databuf = hisi_hba->debugfs_iost[dump_index].iost;
+	struct hisi_sas_iost *iost;
+	int i;
+
+	read_iost_itct_cache_v3_hw(hisi_hba, HISI_SAS_IOST_CACHE, cachebuf);
+
+	iost = hisi_hba->iost;
+
+	for (i = 0; i < max_command_entries; i++, iost++) {
+		memcpy(databuf, iost, sizeof(struct hisi_sas_iost));
+		databuf += sizeof(struct hisi_sas_iost);
+	}
+}
+
+static const char *
+debugfs_to_reg_name_v3_hw(int off, int base_off,
+			  const struct hisi_sas_debugfs_reg_lu *lu)
+{
+	for (; lu->name; lu++) {
+		if (off == lu->off - base_off)
+			return lu->name;
+	}
+
+	return NULL;
+}
+
+static void debugfs_print_reg_v3_hw(u32 *regs_val, struct seq_file *s,
+				    const struct hisi_sas_debugfs_reg *reg)
+{
+	int i;
+
+	for (i = 0; i < reg->count; i++) {
+		int off = i * 4;
+		const char *name;
+
+		name = debugfs_to_reg_name_v3_hw(off, reg->base_off,
+						 reg->lu);
+
+		if (name)
+			seq_printf(s, "0x%08x 0x%08x %s\n", off,
+				   regs_val[i], name);
+		else
+			seq_printf(s, "0x%08x 0x%08x\n", off,
+				   regs_val[i]);
+	}
+}
+
+static int debugfs_global_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_regs *global = s->private;
+
+	debugfs_print_reg_v3_hw(global->data, s,
+				&debugfs_global_reg);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_global_v3_hw);
+
+static int debugfs_axi_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_regs *axi = s->private;
+
+	debugfs_print_reg_v3_hw(axi->data, s,
+				&debugfs_axi_reg);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_axi_v3_hw);
+
+static int debugfs_ras_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_regs *ras = s->private;
+
+	debugfs_print_reg_v3_hw(ras->data, s,
+				&debugfs_ras_reg);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_ras_v3_hw);
+
+static int debugfs_port_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_port *port = s->private;
+	const struct hisi_sas_debugfs_reg *reg_port = &debugfs_port_reg;
+
+	debugfs_print_reg_v3_hw(port->data, s, reg_port);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_port_v3_hw);
+
+static void debugfs_show_row_64_v3_hw(struct seq_file *s, int index,
+				      int sz, __le64 *ptr)
+{
+	int i;
+
+	/* completion header size not fixed per HW version */
+	seq_printf(s, "index %04d:\n\t", index);
+	for (i = 1; i <= sz / 8; i++, ptr++) {
+		seq_printf(s, " 0x%016llx", le64_to_cpu(*ptr));
+		if (!(i % 2))
+			seq_puts(s, "\n\t");
+	}
+
+	seq_puts(s, "\n");
+}
+
+static void debugfs_show_row_32_v3_hw(struct seq_file *s, int index,
+				      int sz, __le32 *ptr)
+{
+	int i;
+
+	/* completion header size not fixed per HW version */
+	seq_printf(s, "index %04d:\n\t", index);
+	for (i = 1; i <= sz / 4; i++, ptr++) {
+		seq_printf(s, " 0x%08x", le32_to_cpu(*ptr));
+		if (!(i % 4))
+			seq_puts(s, "\n\t");
+	}
+	seq_puts(s, "\n");
+}
+
+static void debugfs_cq_show_slot_v3_hw(struct seq_file *s, int slot,
+				       struct hisi_sas_debugfs_cq *debugfs_cq)
+{
+	struct hisi_sas_cq *cq = debugfs_cq->cq;
+	struct hisi_hba *hisi_hba = cq->hisi_hba;
+	__le32 *complete_hdr = debugfs_cq->complete_hdr +
+			       (hisi_hba->hw->complete_hdr_size * slot);
+
+	debugfs_show_row_32_v3_hw(s, slot,
+				  hisi_hba->hw->complete_hdr_size,
+				  complete_hdr);
+}
+
+static int debugfs_cq_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_cq *debugfs_cq = s->private;
+	int slot;
+
+	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++)
+		debugfs_cq_show_slot_v3_hw(s, slot, debugfs_cq);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_cq_v3_hw);
+
+static void debugfs_dq_show_slot_v3_hw(struct seq_file *s, int slot,
+				       void *dq_ptr)
+{
+	struct hisi_sas_debugfs_dq *debugfs_dq = dq_ptr;
+	void *cmd_queue = debugfs_dq->hdr;
+	__le32 *cmd_hdr = cmd_queue +
+		sizeof(struct hisi_sas_cmd_hdr) * slot;
+
+	debugfs_show_row_32_v3_hw(s, slot, sizeof(struct hisi_sas_cmd_hdr),
+				  cmd_hdr);
+}
+
+static int debugfs_dq_v3_hw_show(struct seq_file *s, void *p)
+{
+	int slot;
+
+	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++)
+		debugfs_dq_show_slot_v3_hw(s, slot, s->private);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_dq_v3_hw);
+
+static int debugfs_iost_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_iost *debugfs_iost = s->private;
+	struct hisi_sas_iost *iost = debugfs_iost->iost;
+	int i, max_command_entries = HISI_SAS_MAX_COMMANDS;
+
+	for (i = 0; i < max_command_entries; i++, iost++) {
+		__le64 *data = &iost->qw0;
+
+		debugfs_show_row_64_v3_hw(s, i, sizeof(*iost), data);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_iost_v3_hw);
+
+static int debugfs_iost_cache_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_iost_cache *debugfs_iost_cache = s->private;
+	struct hisi_sas_iost_itct_cache *iost_cache =
+						debugfs_iost_cache->cache;
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
+		debugfs_show_row_64_v3_hw(s, tab_idx, cache_size, iost);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_iost_cache_v3_hw);
+
+static int debugfs_itct_v3_hw_show(struct seq_file *s, void *p)
+{
+	int i;
+	struct hisi_sas_debugfs_itct *debugfs_itct = s->private;
+	struct hisi_sas_itct *itct = debugfs_itct->itct;
+
+	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
+		__le64 *data = &itct->qw0;
+
+		debugfs_show_row_64_v3_hw(s, i, sizeof(*itct), data);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_itct_v3_hw);
+
+static int debugfs_itct_cache_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_debugfs_itct_cache *debugfs_itct_cache = s->private;
+	struct hisi_sas_iost_itct_cache *itct_cache =
+						debugfs_itct_cache->cache;
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
+		debugfs_show_row_64_v3_hw(s, tab_idx, cache_size, itct);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_itct_cache_v3_hw);
+
+static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
+{
+	u64 *debugfs_timestamp;
+	int dump_index = hisi_hba->debugfs_dump_index;
+	struct dentry *dump_dentry;
+	struct dentry *dentry;
+	char name[256];
+	int p;
+	int c;
+	int d;
+
+	snprintf(name, 256, "%d", dump_index);
+
+	dump_dentry = debugfs_create_dir(name, hisi_hba->debugfs_dump_dentry);
+
+	debugfs_timestamp = &hisi_hba->debugfs_timestamp[dump_index];
+
+	debugfs_create_u64("timestamp", 0400, dump_dentry,
+			   debugfs_timestamp);
+
+	debugfs_create_file("global", 0400, dump_dentry,
+			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_GLOBAL],
+			    &debugfs_global_v3_hw_fops);
+
+	/* Create port dir and files */
+	dentry = debugfs_create_dir("port", dump_dentry);
+	for (p = 0; p < hisi_hba->n_phy; p++) {
+		snprintf(name, 256, "%d", p);
+
+		debugfs_create_file(name, 0400, dentry,
+				    &hisi_hba->debugfs_port_reg[dump_index][p],
+				    &debugfs_port_v3_hw_fops);
+	}
+
+	/* Create CQ dir and files */
+	dentry = debugfs_create_dir("cq", dump_dentry);
+	for (c = 0; c < hisi_hba->queue_count; c++) {
+		snprintf(name, 256, "%d", c);
+
+		debugfs_create_file(name, 0400, dentry,
+				    &hisi_hba->debugfs_cq[dump_index][c],
+				    &debugfs_cq_v3_hw_fops);
+	}
+
+	/* Create DQ dir and files */
+	dentry = debugfs_create_dir("dq", dump_dentry);
+	for (d = 0; d < hisi_hba->queue_count; d++) {
+		snprintf(name, 256, "%d", d);
+
+		debugfs_create_file(name, 0400, dentry,
+				    &hisi_hba->debugfs_dq[dump_index][d],
+				    &debugfs_dq_v3_hw_fops);
+	}
+
+	debugfs_create_file("iost", 0400, dump_dentry,
+			    &hisi_hba->debugfs_iost[dump_index],
+			    &debugfs_iost_v3_hw_fops);
+
+	debugfs_create_file("iost_cache", 0400, dump_dentry,
+			    &hisi_hba->debugfs_iost_cache[dump_index],
+			    &debugfs_iost_cache_v3_hw_fops);
+
+	debugfs_create_file("itct", 0400, dump_dentry,
+			    &hisi_hba->debugfs_itct[dump_index],
+			    &debugfs_itct_v3_hw_fops);
+
+	debugfs_create_file("itct_cache", 0400, dump_dentry,
+			    &hisi_hba->debugfs_itct_cache[dump_index],
+			    &debugfs_itct_cache_v3_hw_fops);
+
+	debugfs_create_file("axi", 0400, dump_dentry,
+			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_AXI],
+			    &debugfs_axi_v3_hw_fops);
+
+	debugfs_create_file("ras", 0400, dump_dentry,
+			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_RAS],
+			    &debugfs_ras_v3_hw_fops);
+}
+
+static void debugfs_snapshot_regs_v3_hw(struct hisi_hba *hisi_hba)
+{
+	debugfs_snapshot_prepare_v3_hw(hisi_hba);
+
+	debugfs_snapshot_global_reg_v3_hw(hisi_hba);
+	debugfs_snapshot_port_reg_v3_hw(hisi_hba);
+	debugfs_snapshot_axi_reg_v3_hw(hisi_hba);
+	debugfs_snapshot_ras_reg_v3_hw(hisi_hba);
+	debugfs_snapshot_cq_reg_v3_hw(hisi_hba);
+	debugfs_snapshot_dq_reg_v3_hw(hisi_hba);
+	debugfs_snapshot_itct_reg_v3_hw(hisi_hba);
+	debugfs_snapshot_iost_reg_v3_hw(hisi_hba);
+
+	debugfs_create_files_v3_hw(hisi_hba);
+
+	debugfs_snapshot_restore_v3_hw(hisi_hba);
+}
+
+static ssize_t debugfs_trigger_dump_v3_hw_write(struct file *file,
+						const char __user *user_buf,
+						size_t count, loff_t *ppos)
+{
+	struct hisi_hba *hisi_hba = file->f_inode->i_private;
+	char buf[8];
+
+	if (hisi_hba->debugfs_dump_index >= hisi_sas_debugfs_dump_count)
+		return -EFAULT;
+
+	if (count > 8)
+		return -EFAULT;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (buf[0] != '1')
+		return -EFAULT;
+
+	queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
+
+	return count;
+}
+
+static const struct file_operations debugfs_trigger_dump_v3_hw_fops = {
+	.write = &debugfs_trigger_dump_v3_hw_write,
+	.owner = THIS_MODULE,
+};
+
+enum {
+	HISI_SAS_BIST_LOOPBACK_MODE_DIGITAL = 0,
+	HISI_SAS_BIST_LOOPBACK_MODE_SERDES,
+	HISI_SAS_BIST_LOOPBACK_MODE_REMOTE,
+};
+
+static const struct {
+	int		value;
+	char		*name;
+} debugfs_loop_linkrate_v3_hw[] = {
+	{ SAS_LINK_RATE_1_5_GBPS, "1.5 Gbit" },
+	{ SAS_LINK_RATE_3_0_GBPS, "3.0 Gbit" },
+	{ SAS_LINK_RATE_6_0_GBPS, "6.0 Gbit" },
+	{ SAS_LINK_RATE_12_0_GBPS, "12.0 Gbit" },
+};
+
+static int debugfs_bist_linkrate_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(debugfs_loop_linkrate_v3_hw); i++) {
+		int match = (hisi_hba->debugfs_bist_linkrate ==
+			     debugfs_loop_linkrate_v3_hw[i].value);
+
+		seq_printf(s, "%s%s%s ", match ? "[" : "",
+			   debugfs_loop_linkrate_v3_hw[i].name,
+			   match ? "]" : "");
+	}
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static ssize_t debugfs_bist_linkrate_v3_hw_write(struct file *filp,
+						 const char __user *buf,
+						 size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct hisi_hba *hisi_hba = m->private;
+	char kbuf[16] = {}, *pkbuf;
+	bool found = false;
+	int i;
+
+	if (hisi_hba->debugfs_bist_enable)
+		return -EPERM;
+
+	if (count >= sizeof(kbuf))
+		return -EOVERFLOW;
+
+	if (copy_from_user(kbuf, buf, count))
+		return -EINVAL;
+
+	pkbuf = strstrip(kbuf);
+
+	for (i = 0; i < ARRAY_SIZE(debugfs_loop_linkrate_v3_hw); i++) {
+		if (!strncmp(debugfs_loop_linkrate_v3_hw[i].name,
+			     pkbuf, 16)) {
+			hisi_hba->debugfs_bist_linkrate =
+				debugfs_loop_linkrate_v3_hw[i].value;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	return count;
+}
+
+static int debugfs_bist_linkrate_v3_hw_open(struct inode *inode,
+					    struct file *filp)
+{
+	return single_open(filp, debugfs_bist_linkrate_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_bist_linkrate_v3_hw_fops = {
+	.open = debugfs_bist_linkrate_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_bist_linkrate_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static const struct {
+	int		value;
+	char		*name;
+} debugfs_loop_code_mode_v3_hw[] = {
+	{ HISI_SAS_BIST_CODE_MODE_PRBS7, "PRBS7" },
+	{ HISI_SAS_BIST_CODE_MODE_PRBS23, "PRBS23" },
+	{ HISI_SAS_BIST_CODE_MODE_PRBS31, "PRBS31" },
+	{ HISI_SAS_BIST_CODE_MODE_JTPAT, "JTPAT" },
+	{ HISI_SAS_BIST_CODE_MODE_CJTPAT, "CJTPAT" },
+	{ HISI_SAS_BIST_CODE_MODE_SCRAMBED_0, "SCRAMBED_0" },
+	{ HISI_SAS_BIST_CODE_MODE_TRAIN, "TRAIN" },
+	{ HISI_SAS_BIST_CODE_MODE_TRAIN_DONE, "TRAIN_DONE" },
+	{ HISI_SAS_BIST_CODE_MODE_HFTP, "HFTP" },
+	{ HISI_SAS_BIST_CODE_MODE_MFTP, "MFTP" },
+	{ HISI_SAS_BIST_CODE_MODE_LFTP, "LFTP" },
+	{ HISI_SAS_BIST_CODE_MODE_FIXED_DATA, "FIXED_DATA" },
+};
+
+static int debugfs_bist_code_mode_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(debugfs_loop_code_mode_v3_hw); i++) {
+		int match = (hisi_hba->debugfs_bist_code_mode ==
+			     debugfs_loop_code_mode_v3_hw[i].value);
+
+		seq_printf(s, "%s%s%s ", match ? "[" : "",
+			   debugfs_loop_code_mode_v3_hw[i].name,
+			   match ? "]" : "");
+	}
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static ssize_t debugfs_bist_code_mode_v3_hw_write(struct file *filp,
+						  const char __user *buf,
+						  size_t count,
+						  loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct hisi_hba *hisi_hba = m->private;
+	char kbuf[16] = {}, *pkbuf;
+	bool found = false;
+	int i;
+
+	if (hisi_hba->debugfs_bist_enable)
+		return -EPERM;
+
+	if (count >= sizeof(kbuf))
+		return -EINVAL;
+
+	if (copy_from_user(kbuf, buf, count))
+		return -EOVERFLOW;
+
+	pkbuf = strstrip(kbuf);
+
+	for (i = 0; i < ARRAY_SIZE(debugfs_loop_code_mode_v3_hw); i++) {
+		if (!strncmp(debugfs_loop_code_mode_v3_hw[i].name,
+			     pkbuf, 16)) {
+			hisi_hba->debugfs_bist_code_mode =
+				debugfs_loop_code_mode_v3_hw[i].value;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	return count;
+}
+
+static int debugfs_bist_code_mode_v3_hw_open(struct inode *inode,
+					     struct file *filp)
+{
+	return single_open(filp, debugfs_bist_code_mode_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_bist_code_mode_v3_hw_fops = {
+	.open = debugfs_bist_code_mode_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_bist_code_mode_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t debugfs_bist_phy_v3_hw_write(struct file *filp,
+					    const char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct hisi_hba *hisi_hba = m->private;
+	unsigned int phy_no;
+	int val;
+
+	if (hisi_hba->debugfs_bist_enable)
+		return -EPERM;
+
+	val = kstrtouint_from_user(buf, count, 0, &phy_no);
+	if (val)
+		return val;
+
+	if (phy_no >= hisi_hba->n_phy)
+		return -EINVAL;
+
+	hisi_hba->debugfs_bist_phy_no = phy_no;
+
+	return count;
+}
+
+static int debugfs_bist_phy_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+
+	seq_printf(s, "%d\n", hisi_hba->debugfs_bist_phy_no);
+
+	return 0;
+}
+
+static int debugfs_bist_phy_v3_hw_open(struct inode *inode,
+				       struct file *filp)
+{
+	return single_open(filp, debugfs_bist_phy_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_bist_phy_v3_hw_fops = {
+	.open = debugfs_bist_phy_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_bist_phy_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static const struct {
+	int		value;
+	char		*name;
+} debugfs_loop_modes_v3_hw[] = {
+	{ HISI_SAS_BIST_LOOPBACK_MODE_DIGITAL, "digital" },
+	{ HISI_SAS_BIST_LOOPBACK_MODE_SERDES, "serdes" },
+	{ HISI_SAS_BIST_LOOPBACK_MODE_REMOTE, "remote" },
+};
+
+static int debugfs_bist_mode_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(debugfs_loop_modes_v3_hw); i++) {
+		int match = (hisi_hba->debugfs_bist_mode ==
+			     debugfs_loop_modes_v3_hw[i].value);
+
+		seq_printf(s, "%s%s%s ", match ? "[" : "",
+			   debugfs_loop_modes_v3_hw[i].name,
+			   match ? "]" : "");
+	}
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static ssize_t debugfs_bist_mode_v3_hw_write(struct file *filp,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct hisi_hba *hisi_hba = m->private;
+	char kbuf[16] = {}, *pkbuf;
+	bool found = false;
+	int i;
+
+	if (hisi_hba->debugfs_bist_enable)
+		return -EPERM;
+
+	if (count >= sizeof(kbuf))
+		return -EINVAL;
+
+	if (copy_from_user(kbuf, buf, count))
+		return -EOVERFLOW;
+
+	pkbuf = strstrip(kbuf);
+
+	for (i = 0; i < ARRAY_SIZE(debugfs_loop_modes_v3_hw); i++) {
+		if (!strncmp(debugfs_loop_modes_v3_hw[i].name, pkbuf, 16)) {
+			hisi_hba->debugfs_bist_mode =
+				debugfs_loop_modes_v3_hw[i].value;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	return count;
+}
+
+static int debugfs_bist_mode_v3_hw_open(struct inode *inode,
+					struct file *filp)
+{
+	return single_open(filp, debugfs_bist_mode_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_bist_mode_v3_hw_fops = {
+	.open = debugfs_bist_mode_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_bist_mode_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t debugfs_bist_enable_v3_hw_write(struct file *filp,
+					       const char __user *buf,
+					       size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct hisi_hba *hisi_hba = m->private;
+	unsigned int enable;
+	int val;
+
+	val = kstrtouint_from_user(buf, count, 0, &enable);
+	if (val)
+		return val;
+
+	if (enable > 1)
+		return -EINVAL;
+
+	if (enable == hisi_hba->debugfs_bist_enable)
+		return count;
+
+	val = debugfs_set_bist_v3_hw(hisi_hba, enable);
+	if (val < 0)
+		return val;
+
+	hisi_hba->debugfs_bist_enable = enable;
+
+	return count;
+}
+
+static int debugfs_bist_enable_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_hba *hisi_hba = s->private;
+
+	seq_printf(s, "%d\n", hisi_hba->debugfs_bist_enable);
+
+	return 0;
+}
+
+static int debugfs_bist_enable_v3_hw_open(struct inode *inode,
+					  struct file *filp)
+{
+	return single_open(filp, debugfs_bist_enable_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_bist_enable_v3_hw_fops = {
+	.open = debugfs_bist_enable_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_bist_enable_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static const struct {
+	char *name;
+} debugfs_ffe_name_v3_hw[FFE_CFG_MAX] = {
+	{ "SAS_1_5_GBPS" },
+	{ "SAS_3_0_GBPS" },
+	{ "SAS_6_0_GBPS" },
+	{ "SAS_12_0_GBPS" },
+	{ "FFE_RESV" },
+	{ "SATA_1_5_GBPS" },
+	{ "SATA_3_0_GBPS" },
+	{ "SATA_6_0_GBPS" },
+};
+
+static ssize_t debugfs_v3_hw_write(struct file *filp,
+				   const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	u32 *val = m->private;
+	int res;
+
+	res = kstrtouint_from_user(buf, count, 0, val);
+	if (res)
+		return res;
+
+	return count;
+}
+
+static int debugfs_v3_hw_show(struct seq_file *s, void *p)
+{
+	u32 *val = s->private;
+
+	seq_printf(s, "0x%x\n", *val);
+
+	return 0;
+}
+
+static int debugfs_v3_hw_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, debugfs_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_v3_hw_fops = {
+	.open = debugfs_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t debugfs_phy_down_cnt_v3_hw_write(struct file *filp,
+						const char __user *buf,
+						size_t count, loff_t *ppos)
+{
+	struct seq_file *s = filp->private_data;
+	struct hisi_sas_phy *phy = s->private;
+	unsigned int set_val;
+	int res;
+
+	res = kstrtouint_from_user(buf, count, 0, &set_val);
+	if (res)
+		return res;
+
+	if (set_val > 0)
+		return -EINVAL;
+
+	atomic_set(&phy->down_cnt, 0);
+
+	return count;
+}
+
+static int debugfs_phy_down_cnt_v3_hw_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_phy *phy = s->private;
+
+	seq_printf(s, "%d\n", atomic_read(&phy->down_cnt));
+
+	return 0;
+}
+
+static int debugfs_phy_down_cnt_v3_hw_open(struct inode *inode,
+					   struct file *filp)
+{
+	return single_open(filp, debugfs_phy_down_cnt_v3_hw_show,
+			   inode->i_private);
+}
+
+static const struct file_operations debugfs_phy_down_cnt_v3_hw_fops = {
+	.open = debugfs_phy_down_cnt_v3_hw_open,
+	.read = seq_read,
+	.write = debugfs_phy_down_cnt_v3_hw_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
+static void debugfs_work_handler_v3_hw(struct work_struct *work)
+{
+	struct hisi_hba *hisi_hba =
+		container_of(work, struct hisi_hba, debugfs_work);
+	int debugfs_dump_index = hisi_hba->debugfs_dump_index;
+	struct device *dev = hisi_hba->dev;
+	u64 timestamp = local_clock();
+
+	if (debugfs_dump_index >= hisi_sas_debugfs_dump_count) {
+		dev_warn(dev, "dump count exceeded!\n");
+		return;
+	}
+
+	do_div(timestamp, NSEC_PER_MSEC);
+	hisi_hba->debugfs_timestamp[debugfs_dump_index] = timestamp;
+
+	debugfs_snapshot_regs_v3_hw(hisi_hba);
+	hisi_hba->debugfs_dump_index++;
+}
+
+static void debugfs_release_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
+{
+	struct device *dev = hisi_hba->dev;
+	int i;
+
+	devm_kfree(dev, hisi_hba->debugfs_iost_cache[dump_index].cache);
+	devm_kfree(dev, hisi_hba->debugfs_itct_cache[dump_index].cache);
+	devm_kfree(dev, hisi_hba->debugfs_iost[dump_index].iost);
+	devm_kfree(dev, hisi_hba->debugfs_itct[dump_index].itct);
+
+	for (i = 0; i < hisi_hba->queue_count; i++)
+		devm_kfree(dev, hisi_hba->debugfs_dq[dump_index][i].hdr);
+
+	for (i = 0; i < hisi_hba->queue_count; i++)
+		devm_kfree(dev,
+			   hisi_hba->debugfs_cq[dump_index][i].complete_hdr);
+
+	for (i = 0; i < DEBUGFS_REGS_NUM; i++)
+		devm_kfree(dev, hisi_hba->debugfs_regs[dump_index][i].data);
+
+	for (i = 0; i < hisi_hba->n_phy; i++)
+		devm_kfree(dev, hisi_hba->debugfs_port_reg[dump_index][i].data);
+}
+
+static const struct hisi_sas_debugfs_reg *debugfs_reg_array_v3_hw[DEBUGFS_REGS_NUM] = {
+	[DEBUGFS_GLOBAL] = &debugfs_global_reg,
+	[DEBUGFS_AXI] = &debugfs_axi_reg,
+	[DEBUGFS_RAS] = &debugfs_ras_reg,
+};
+
+static int debugfs_alloc_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
+{
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
+	struct device *dev = hisi_hba->dev;
+	int p, c, d, r, i;
+	size_t sz;
+
+	for (r = 0; r < DEBUGFS_REGS_NUM; r++) {
+		struct hisi_sas_debugfs_regs *regs =
+				&hisi_hba->debugfs_regs[dump_index][r];
+
+		sz = debugfs_reg_array_v3_hw[r]->count * 4;
+		regs->data = devm_kmalloc(dev, sz, GFP_KERNEL);
+		if (!regs->data)
+			goto fail;
+		regs->hisi_hba = hisi_hba;
+	}
+
+	sz = debugfs_port_reg.count * 4;
+	for (p = 0; p < hisi_hba->n_phy; p++) {
+		struct hisi_sas_debugfs_port *port =
+				&hisi_hba->debugfs_port_reg[dump_index][p];
+
+		port->data = devm_kmalloc(dev, sz, GFP_KERNEL);
+		if (!port->data)
+			goto fail;
+		port->phy = &hisi_hba->phy[p];
+	}
+
+	sz = hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
+	for (c = 0; c < hisi_hba->queue_count; c++) {
+		struct hisi_sas_debugfs_cq *cq =
+				&hisi_hba->debugfs_cq[dump_index][c];
+
+		cq->complete_hdr = devm_kmalloc(dev, sz, GFP_KERNEL);
+		if (!cq->complete_hdr)
+			goto fail;
+		cq->cq = &hisi_hba->cq[c];
+	}
+
+	sz = sizeof(struct hisi_sas_cmd_hdr) * HISI_SAS_QUEUE_SLOTS;
+	for (d = 0; d < hisi_hba->queue_count; d++) {
+		struct hisi_sas_debugfs_dq *dq =
+				&hisi_hba->debugfs_dq[dump_index][d];
+
+		dq->hdr = devm_kmalloc(dev, sz, GFP_KERNEL);
+		if (!dq->hdr)
+			goto fail;
+		dq->dq = &hisi_hba->dq[d];
+	}
+
+	sz = HISI_SAS_MAX_COMMANDS * sizeof(struct hisi_sas_iost);
+
+	hisi_hba->debugfs_iost[dump_index].iost =
+				devm_kmalloc(dev, sz, GFP_KERNEL);
+	if (!hisi_hba->debugfs_iost[dump_index].iost)
+		goto fail;
+
+	sz = HISI_SAS_IOST_ITCT_CACHE_NUM *
+	     sizeof(struct hisi_sas_iost_itct_cache);
+
+	hisi_hba->debugfs_iost_cache[dump_index].cache =
+				devm_kmalloc(dev, sz, GFP_KERNEL);
+	if (!hisi_hba->debugfs_iost_cache[dump_index].cache)
+		goto fail;
+
+	sz = HISI_SAS_IOST_ITCT_CACHE_NUM *
+	     sizeof(struct hisi_sas_iost_itct_cache);
+
+	hisi_hba->debugfs_itct_cache[dump_index].cache =
+				devm_kmalloc(dev, sz, GFP_KERNEL);
+	if (!hisi_hba->debugfs_itct_cache[dump_index].cache)
+		goto fail;
+
+	/* New memory allocation must be locate before itct */
+	sz = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_itct);
+
+	hisi_hba->debugfs_itct[dump_index].itct =
+				devm_kmalloc(dev, sz, GFP_KERNEL);
+	if (!hisi_hba->debugfs_itct[dump_index].itct)
+		goto fail;
+
+	return 0;
+fail:
+	for (i = 0; i < hisi_sas_debugfs_dump_count; i++)
+		debugfs_release_v3_hw(hisi_hba, i);
+	return -ENOMEM;
+}
+
+static void debugfs_phy_down_cnt_init_v3_hw(struct hisi_hba *hisi_hba)
+{
+	struct dentry *dir = debugfs_create_dir("phy_down_cnt",
+						hisi_hba->debugfs_dir);
+	char name[16];
+	int phy_no;
+
+	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
+		snprintf(name, 16, "%d", phy_no);
+		debugfs_create_file(name, 0600, dir,
+				    &hisi_hba->phy[phy_no],
+				    &debugfs_phy_down_cnt_v3_hw_fops);
+	}
+}
+
+static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
+{
+	struct dentry *ports_dentry;
+	int phy_no;
+
+	hisi_hba->debugfs_bist_dentry =
+			debugfs_create_dir("bist", hisi_hba->debugfs_dir);
+	debugfs_create_file("link_rate", 0600,
+			    hisi_hba->debugfs_bist_dentry, hisi_hba,
+			    &debugfs_bist_linkrate_v3_hw_fops);
+
+	debugfs_create_file("code_mode", 0600,
+			    hisi_hba->debugfs_bist_dentry, hisi_hba,
+			    &debugfs_bist_code_mode_v3_hw_fops);
+
+	debugfs_create_file("fixed_code", 0600,
+			    hisi_hba->debugfs_bist_dentry,
+			    &hisi_hba->debugfs_bist_fixed_code[0],
+			    &debugfs_v3_hw_fops);
+
+	debugfs_create_file("fixed_code_1", 0600,
+			    hisi_hba->debugfs_bist_dentry,
+			    &hisi_hba->debugfs_bist_fixed_code[1],
+			    &debugfs_v3_hw_fops);
+
+	debugfs_create_file("phy_id", 0600, hisi_hba->debugfs_bist_dentry,
+			    hisi_hba, &debugfs_bist_phy_v3_hw_fops);
+
+	debugfs_create_u32("cnt", 0600, hisi_hba->debugfs_bist_dentry,
+			   &hisi_hba->debugfs_bist_cnt);
+
+	debugfs_create_file("loopback_mode", 0600,
+			    hisi_hba->debugfs_bist_dentry,
+			    hisi_hba, &debugfs_bist_mode_v3_hw_fops);
+
+	debugfs_create_file("enable", 0600, hisi_hba->debugfs_bist_dentry,
+			    hisi_hba, &debugfs_bist_enable_v3_hw_fops);
+
+	ports_dentry = debugfs_create_dir("port", hisi_hba->debugfs_bist_dentry);
+
+	for (phy_no = 0; phy_no < hisi_hba->n_phy; phy_no++) {
+		struct dentry *port_dentry;
+		struct dentry *ffe_dentry;
+		char name[256];
+		int i;
+
+		snprintf(name, 256, "%d", phy_no);
+		port_dentry = debugfs_create_dir(name, ports_dentry);
+		ffe_dentry = debugfs_create_dir("ffe", port_dentry);
+		for (i = 0; i < FFE_CFG_MAX; i++) {
+			if (i == FFE_RESV)
+				continue;
+			debugfs_create_file(debugfs_ffe_name_v3_hw[i].name,
+					    0600, ffe_dentry,
+					    &hisi_hba->debugfs_bist_ffe[phy_no][i],
+					    &debugfs_v3_hw_fops);
+		}
+	}
+
+	hisi_hba->debugfs_bist_linkrate = SAS_LINK_RATE_1_5_GBPS;
+}
+
+static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+	int i;
+
+	hisi_hba->debugfs_dir = debugfs_create_dir(dev_name(dev),
+						   hisi_sas_debugfs_dir);
+	debugfs_create_file("trigger_dump", 0200,
+			    hisi_hba->debugfs_dir,
+			    hisi_hba,
+			    &debugfs_trigger_dump_v3_hw_fops);
+
+	/* create bist structures */
+	debugfs_bist_init_v3_hw(hisi_hba);
+
+	hisi_hba->debugfs_dump_dentry =
+			debugfs_create_dir("dump", hisi_hba->debugfs_dir);
+
+	debugfs_phy_down_cnt_init_v3_hw(hisi_hba);
+
+	for (i = 0; i < hisi_sas_debugfs_dump_count; i++) {
+		if (debugfs_alloc_v3_hw(hisi_hba, i)) {
+			debugfs_remove_recursive(hisi_hba->debugfs_dir);
+			dev_dbg(dev, "failed to init debugfs!\n");
+			break;
+		}
+	}
+}
+
+static void debugfs_exit_v3_hw(struct hisi_hba *hisi_hba)
+{
+	debugfs_remove_recursive(hisi_hba->debugfs_dir);
+}
+
 static int
 hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -3299,7 +4492,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	if (hisi_sas_debugfs_enable)
-		hisi_sas_debugfs_init(hisi_hba);
+		debugfs_init_v3_hw(hisi_hba);
 
 	rc = interrupt_preinit_v3_hw(hisi_hba);
 	if (rc)
@@ -3337,7 +4530,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_out_free_irq_vectors:
 	pci_free_irq_vectors(pdev);
 err_out_debugfs:
-	hisi_sas_debugfs_exit(hisi_hba);
+	debugfs_exit_v3_hw(hisi_hba);
 err_out_ha:
 	hisi_sas_free(hisi_hba);
 	scsi_host_put(shost);
@@ -3384,7 +4577,7 @@ static void hisi_sas_v3_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	hisi_sas_free(hisi_hba);
-	hisi_sas_debugfs_exit(hisi_hba);
+	debugfs_exit_v3_hw(hisi_hba);
 	scsi_host_put(shost);
 }
 
-- 
2.26.2

