Return-Path: <linux-scsi+bounces-8509-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D326A986AB9
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Sep 2024 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9464F280BEE
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Sep 2024 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64D17C223;
	Thu, 26 Sep 2024 01:43:40 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04A176AC2
	for <linux-scsi@vger.kernel.org>; Thu, 26 Sep 2024 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727315020; cv=none; b=kDqN30afDfOlBCBCadNyyBvNagerQDrCkpNTSEuOX7C1KGixNWY4b6to3umeNX1kan1w1jJ5ZKK4DLvgJMYuano0hFnun+k4bbHOuXwXJ8vfmVRZMZcTI6HAC6MnQYj6iSR0oT4c15dZOTwh0Xuh8PS+2BIT0anL6OrE+dIQyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727315020; c=relaxed/simple;
	bh=y+6pWse0eB7wzAGMa0sXTsfvbPNNcdIcTdJzQyG6Z+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlAW7+uTD8jUH7WFu/RyTJ0t+b8lF4i+2TkBMLnhw8bjir0xvyMVdJ7dSQ2VNdcE/75OfR9oRUFgW3sMveC1112Bbd7RVPnMLHdKeCH5dhwm8rSK84yt8NUayqO8wL6s/MmD8yUy0a5cKjZXEyKRXBwAJKXui/otrdVUlSV5S7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XDbvV1NVtz1SBq5;
	Thu, 26 Sep 2024 09:42:46 +0800 (CST)
Received: from dggpemf100013.china.huawei.com (unknown [7.185.36.179])
	by mail.maildlp.com (Postfix) with ESMTPS id E7DF41A016C;
	Thu, 26 Sep 2024 09:43:34 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 dggpemf100013.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Sep 2024 09:43:34 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
	<liyihang9@huawei.com>
Subject: [PATCH 12/13] scsi: hisi_sas: Create all dump files during debugfs initialization
Date: Thu, 26 Sep 2024 09:43:31 +0800
Message-ID: <20240926014332.3905399-13-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240926014332.3905399-1-liyihang9@huawei.com>
References: <20240926014332.3905399-1-liyihang9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100013.china.huawei.com (7.185.36.179)

For the current debugfs of hisi_sas, after user triggers dump, the driver
allocate memory space to save the register information and create debugfs
files to display the saved information. In this process, the debugfs files
created after each dump.

Therefore, when the dump is triggered while the driver is unbind, the
following hang occurs:

[67840.853907] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a0
[67840.862947] Mem abort info:
[67840.865855]   ESR = 0x0000000096000004
[67840.869713]   EC = 0x25: DABT (current EL), IL = 32 bits
[67840.875125]   SET = 0, FnV = 0
[67840.878291]   EA = 0, S1PTW = 0
[67840.881545]   FSC = 0x04: level 0 translation fault
[67840.886528] Data abort info:
[67840.889524]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[67840.895117]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[67840.900284]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[67840.905709] user pgtable: 4k pages, 48-bit VAs, pgdp=0000002803a1f000
[67840.912263] [00000000000000a0] pgd=0000000000000000, p4d=0000000000000000
[67840.919177] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[67840.996435] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[67841.003628] pc : down_write+0x30/0x98
[67841.007546] lr : start_creating.part.0+0x60/0x198
[67841.012495] sp : ffff8000b979ba20
[67841.016046] x29: ffff8000b979ba20 x28: 0000000000000010 x27: 0000000000024b40
[67841.023412] x26: 0000000000000012 x25: ffff20202b355ae8 x24: ffff20202b35a8c8
[67841.030779] x23: ffffa36877928208 x22: ffffa368b4972240 x21: ffff8000b979bb18
[67841.038147] x20: ffff00281dc1e3c0 x19: fffffffffffffffe x18: 0000000000000020
[67841.045515] x17: 0000000000000000 x16: ffffa368b128a530 x15: ffffffffffffffff
[67841.052888] x14: ffff8000b979bc18 x13: ffffffffffffffff x12: ffff8000b979bb18
[67841.060263] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa368b1289b18
[67841.067640] x8 : 0000000000000012 x7 : 0000000000000000 x6 : 00000000000003a9
[67841.075014] x5 : 0000000000000000 x4 : ffff002818c5cb00 x3 : 0000000000000001
[67841.082388] x2 : 0000000000000000 x1 : ffff002818c5cb00 x0 : 00000000000000a0
[67841.089759] Call trace:
[67841.092456]  down_write+0x30/0x98
[67841.096017]  start_creating.part.0+0x60/0x198
[67841.100613]  debugfs_create_dir+0x48/0x1f8
[67841.104950]  debugfs_create_files_v3_hw+0x88/0x348 [hisi_sas_v3_hw]
[67841.111447]  debugfs_snapshot_regs_v3_hw+0x708/0x798 [hisi_sas_v3_hw]
[67841.118111]  debugfs_trigger_dump_v3_hw_write+0x9c/0x120 [hisi_sas_v3_hw]
[67841.125115]  full_proxy_write+0x68/0xc8
[67841.129175]  vfs_write+0xd8/0x3f0
[67841.132708]  ksys_write+0x70/0x108
[67841.136317]  __arm64_sys_write+0x24/0x38
[67841.140440]  invoke_syscall+0x50/0x128
[67841.144385]  el0_svc_common.constprop.0+0xc8/0xf0
[67841.149273]  do_el0_svc+0x24/0x38
[67841.152773]  el0_svc+0x38/0xd8
[67841.156009]  el0t_64_sync_handler+0xc0/0xc8
[67841.160361]  el0t_64_sync+0x1a4/0x1a8
[67841.164189] Code: b9000882 d2800002 d2800023 f9800011 (c85ffc05)
[67841.170443] ---[ end trace 0000000000000000 ]---

To fix this issue, create all directories and files during debugfs
initialization. In this way, the driver only needs to allocate memory
space to save information each time the user triggers dumping.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Reviewed-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 99 ++++++++++++++++++++------
 1 file changed, 77 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index bc5c96320f5a..8250d44f0b3e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3576,6 +3576,11 @@ debugfs_to_reg_name_v3_hw(int off, int base_off,
 	return NULL;
 }
 
+static bool debugfs_dump_is_generated_v3_hw(void *p)
+{
+	return p ? true : false;
+}
+
 static void debugfs_print_reg_v3_hw(u32 *regs_val, struct seq_file *s,
 				    const struct hisi_sas_debugfs_reg *reg)
 {
@@ -3601,6 +3606,9 @@ static int debugfs_global_v3_hw_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_debugfs_regs *global = s->private;
 
+	if (!debugfs_dump_is_generated_v3_hw(global->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(global->data, s,
 				&debugfs_global_reg);
 
@@ -3612,6 +3620,9 @@ static int debugfs_axi_v3_hw_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_debugfs_regs *axi = s->private;
 
+	if (!debugfs_dump_is_generated_v3_hw(axi->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(axi->data, s,
 				&debugfs_axi_reg);
 
@@ -3623,6 +3634,9 @@ static int debugfs_ras_v3_hw_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_debugfs_regs *ras = s->private;
 
+	if (!debugfs_dump_is_generated_v3_hw(ras->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(ras->data, s,
 				&debugfs_ras_reg);
 
@@ -3635,6 +3649,9 @@ static int debugfs_port_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_port *port = s->private;
 	const struct hisi_sas_debugfs_reg *reg_port = &debugfs_port_reg;
 
+	if (!debugfs_dump_is_generated_v3_hw(port->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(port->data, s, reg_port);
 
 	return 0;
@@ -3690,6 +3707,9 @@ static int debugfs_cq_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_cq *debugfs_cq = s->private;
 	int slot;
 
+	if (!debugfs_dump_is_generated_v3_hw(debugfs_cq->complete_hdr))
+		return -EPERM;
+
 	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++)
 		debugfs_cq_show_slot_v3_hw(s, slot, debugfs_cq);
 
@@ -3711,8 +3731,12 @@ static void debugfs_dq_show_slot_v3_hw(struct seq_file *s, int slot,
 
 static int debugfs_dq_v3_hw_show(struct seq_file *s, void *p)
 {
+	struct hisi_sas_debugfs_dq *debugfs_dq = s->private;
 	int slot;
 
+	if (!debugfs_dump_is_generated_v3_hw(debugfs_dq->hdr))
+		return -EPERM;
+
 	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++)
 		debugfs_dq_show_slot_v3_hw(s, slot, s->private);
 
@@ -3726,6 +3750,9 @@ static int debugfs_iost_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_iost *iost = debugfs_iost->iost;
 	int i, max_command_entries = HISI_SAS_MAX_COMMANDS;
 
+	if (!debugfs_dump_is_generated_v3_hw(iost))
+		return -EPERM;
+
 	for (i = 0; i < max_command_entries; i++, iost++) {
 		__le64 *data = &iost->qw0;
 
@@ -3745,6 +3772,9 @@ static int debugfs_iost_cache_v3_hw_show(struct seq_file *s, void *p)
 	int i, tab_idx;
 	__le64 *iost;
 
+	if (!debugfs_dump_is_generated_v3_hw(iost_cache))
+		return -EPERM;
+
 	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, iost_cache++) {
 		/*
 		 * Data struct of IOST cache:
@@ -3768,6 +3798,9 @@ static int debugfs_itct_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_itct *debugfs_itct = s->private;
 	struct hisi_sas_itct *itct = debugfs_itct->itct;
 
+	if (!debugfs_dump_is_generated_v3_hw(itct))
+		return -EPERM;
+
 	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
 		__le64 *data = &itct->qw0;
 
@@ -3787,6 +3820,9 @@ static int debugfs_itct_cache_v3_hw_show(struct seq_file *s, void *p)
 	int i, tab_idx;
 	__le64 *itct;
 
+	if (!debugfs_dump_is_generated_v3_hw(itct_cache))
+		return -EPERM;
+
 	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, itct_cache++) {
 		/*
 		 * Data struct of ITCT cache:
@@ -3804,10 +3840,9 @@ static int debugfs_itct_cache_v3_hw_show(struct seq_file *s, void *p)
 }
 DEFINE_SHOW_ATTRIBUTE(debugfs_itct_cache_v3_hw);
 
-static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
+static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba, int index)
 {
 	u64 *debugfs_timestamp;
-	int dump_index = hisi_hba->debugfs_dump_index;
 	struct dentry *dump_dentry;
 	struct dentry *dentry;
 	char name[256];
@@ -3815,17 +3850,17 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 	int c;
 	int d;
 
-	snprintf(name, 256, "%d", dump_index);
+	snprintf(name, 256, "%d", index);
 
 	dump_dentry = debugfs_create_dir(name, hisi_hba->debugfs_dump_dentry);
 
-	debugfs_timestamp = &hisi_hba->debugfs_timestamp[dump_index];
+	debugfs_timestamp = &hisi_hba->debugfs_timestamp[index];
 
 	debugfs_create_u64("timestamp", 0400, dump_dentry,
 			   debugfs_timestamp);
 
 	debugfs_create_file("global", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_GLOBAL],
+			    &hisi_hba->debugfs_regs[index][DEBUGFS_GLOBAL],
 			    &debugfs_global_v3_hw_fops);
 
 	/* Create port dir and files */
@@ -3834,7 +3869,7 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", p);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_port_reg[dump_index][p],
+				    &hisi_hba->debugfs_port_reg[index][p],
 				    &debugfs_port_v3_hw_fops);
 	}
 
@@ -3844,7 +3879,7 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", c);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_cq[dump_index][c],
+				    &hisi_hba->debugfs_cq[index][c],
 				    &debugfs_cq_v3_hw_fops);
 	}
 
@@ -3854,32 +3889,32 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", d);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_dq[dump_index][d],
+				    &hisi_hba->debugfs_dq[index][d],
 				    &debugfs_dq_v3_hw_fops);
 	}
 
 	debugfs_create_file("iost", 0400, dump_dentry,
-			    &hisi_hba->debugfs_iost[dump_index],
+			    &hisi_hba->debugfs_iost[index],
 			    &debugfs_iost_v3_hw_fops);
 
 	debugfs_create_file("iost_cache", 0400, dump_dentry,
-			    &hisi_hba->debugfs_iost_cache[dump_index],
+			    &hisi_hba->debugfs_iost_cache[index],
 			    &debugfs_iost_cache_v3_hw_fops);
 
 	debugfs_create_file("itct", 0400, dump_dentry,
-			    &hisi_hba->debugfs_itct[dump_index],
+			    &hisi_hba->debugfs_itct[index],
 			    &debugfs_itct_v3_hw_fops);
 
 	debugfs_create_file("itct_cache", 0400, dump_dentry,
-			    &hisi_hba->debugfs_itct_cache[dump_index],
+			    &hisi_hba->debugfs_itct_cache[index],
 			    &debugfs_itct_cache_v3_hw_fops);
 
 	debugfs_create_file("axi", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_AXI],
+			    &hisi_hba->debugfs_regs[index][DEBUGFS_AXI],
 			    &debugfs_axi_v3_hw_fops);
 
 	debugfs_create_file("ras", 0400, dump_dentry,
-			    &hisi_hba->debugfs_regs[dump_index][DEBUGFS_RAS],
+			    &hisi_hba->debugfs_regs[index][DEBUGFS_RAS],
 			    &debugfs_ras_v3_hw_fops);
 }
 
@@ -4542,22 +4577,34 @@ static void debugfs_release_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
 	int i;
 
 	devm_kfree(dev, hisi_hba->debugfs_iost_cache[dump_index].cache);
+	hisi_hba->debugfs_iost_cache[dump_index].cache = NULL;
 	devm_kfree(dev, hisi_hba->debugfs_itct_cache[dump_index].cache);
+	hisi_hba->debugfs_itct_cache[dump_index].cache = NULL;
 	devm_kfree(dev, hisi_hba->debugfs_iost[dump_index].iost);
+	hisi_hba->debugfs_iost[dump_index].iost = NULL;
 	devm_kfree(dev, hisi_hba->debugfs_itct[dump_index].itct);
+	hisi_hba->debugfs_itct[dump_index].itct = NULL;
 
-	for (i = 0; i < hisi_hba->queue_count; i++)
+	for (i = 0; i < hisi_hba->queue_count; i++) {
 		devm_kfree(dev, hisi_hba->debugfs_dq[dump_index][i].hdr);
+		hisi_hba->debugfs_dq[dump_index][i].hdr = NULL;
+	}
 
-	for (i = 0; i < hisi_hba->queue_count; i++)
+	for (i = 0; i < hisi_hba->queue_count; i++) {
 		devm_kfree(dev,
 			   hisi_hba->debugfs_cq[dump_index][i].complete_hdr);
+		hisi_hba->debugfs_cq[dump_index][i].complete_hdr = NULL;
+	}
 
-	for (i = 0; i < DEBUGFS_REGS_NUM; i++)
+	for (i = 0; i < DEBUGFS_REGS_NUM; i++) {
 		devm_kfree(dev, hisi_hba->debugfs_regs[dump_index][i].data);
+		hisi_hba->debugfs_regs[dump_index][i].data = NULL;
+	}
 
-	for (i = 0; i < hisi_hba->n_phy; i++)
+	for (i = 0; i < hisi_hba->n_phy; i++) {
 		devm_kfree(dev, hisi_hba->debugfs_port_reg[dump_index][i].data);
+		hisi_hba->debugfs_port_reg[dump_index][i].data = NULL;
+	}
 }
 
 static const struct hisi_sas_debugfs_reg *debugfs_reg_array_v3_hw[DEBUGFS_REGS_NUM] = {
@@ -4684,8 +4731,6 @@ static int debugfs_snapshot_regs_v3_hw(struct hisi_hba *hisi_hba)
 	debugfs_snapshot_itct_reg_v3_hw(hisi_hba);
 	debugfs_snapshot_iost_reg_v3_hw(hisi_hba);
 
-	debugfs_create_files_v3_hw(hisi_hba);
-
 	debugfs_snapshot_restore_v3_hw(hisi_hba);
 	hisi_hba->debugfs_dump_index++;
 
@@ -4769,6 +4814,17 @@ static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_hba->debugfs_bist_linkrate = SAS_LINK_RATE_1_5_GBPS;
 }
 
+static void debugfs_dump_init_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int i;
+
+	hisi_hba->debugfs_dump_dentry =
+			debugfs_create_dir("dump", hisi_hba->debugfs_dir);
+
+	for (i = 0; i < hisi_sas_debugfs_dump_count; i++)
+		debugfs_create_files_v3_hw(hisi_hba, i);
+}
+
 static void debugfs_exit_v3_hw(struct hisi_hba *hisi_hba)
 {
 	debugfs_remove_recursive(hisi_hba->debugfs_dir);
@@ -4784,8 +4840,7 @@ static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
 	/* create bist structures */
 	debugfs_bist_init_v3_hw(hisi_hba);
 
-	hisi_hba->debugfs_dump_dentry =
-			debugfs_create_dir("dump", hisi_hba->debugfs_dir);
+	debugfs_dump_init_v3_hw(hisi_hba);
 
 	debugfs_phy_down_cnt_init_v3_hw(hisi_hba);
 	debugfs_fifo_init_v3_hw(hisi_hba);
-- 
2.33.0


