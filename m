Return-Path: <linux-scsi+bounces-10495-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F09E40AF
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Dec 2024 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420391685C5
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Dec 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2811F03E9;
	Wed,  4 Dec 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X65UG1V+"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36921F03DF;
	Wed,  4 Dec 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331599; cv=none; b=BZtB09RgGmQNzLAoKIwjAKgQAqOpHqvpzSA6/Av7VWbxRAnpUIM17utw5nPgLERPRclNDmF0b8qcZQP2rx0Fz/+bVIrMiTmEyRML4jwbGrVHmAo8FnRVgBrs/Zh/vJzDUdl7XNZCJG4LEIvhsf/fI9v3TFP7zVsrbQRoWgbLreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331599; c=relaxed/simple;
	bh=7veacg163DEHxux0q4IJwclqH/o6OEQ/H/h2FWmRTpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIUoptVaAxNPF32IVXn8KJqUPTVNAY3oufumyYj6XhXVZBuLZ5QNW0r2sMuUaTbzoKmniUYzjmV/iuALYI8drnN6qN1bUitJq/fzkQQk56FE5UcnMN4g7s+uVdebtP1llOCdpJP8PRDcY3XTn6JQ37nauvxow6UTM7nTAZfTfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X65UG1V+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0EBC4CECD;
	Wed,  4 Dec 2024 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331599;
	bh=7veacg163DEHxux0q4IJwclqH/o6OEQ/H/h2FWmRTpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X65UG1V+bsZTozbAlbjstUOnaLwzXuTmt03Qb83lGhgNxAPSrenR0UjdGYPb+1b9D
	 +eBqaiR7CIk6uQUhYSeWTJAClkO8s8iZLlKEKriJlgx7N7lcAGerC5SRuf8CLAusvg
	 q9H8C8d+95EGUufkC6hW5z/PGaoNBL1o7KfwlCnWcOZ50Hs3ns9nOCRRpTrRoH9DC+
	 E5dDHCQ/nq9vT7KNowHs1GKdPFZ3efJ5U2MC/dXXtssVJqQUVkSA+qpJuRU1HDm9D7
	 /YwF3qo5lYtuyFNc3CcX75WelTj0B17mwxvfjluez8M+8Mrvhj/mEV4m3SuyJ/4y9H
	 6hokxuNEbwkFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yihang Li <liyihang9@huawei.com>,
	Xingui Yang <yangxingui@huawei.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 09/33] scsi: hisi_sas: Create all dump files during debugfs initialization
Date: Wed,  4 Dec 2024 10:47:22 -0500
Message-ID: <20241204154817.2212455-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Yihang Li <liyihang9@huawei.com>

[ Upstream commit 9f564f15f88490b484e02442dc4c4b11640ea172 ]

For the current debugfs of hisi_sas, after user triggers dump, the
driver allocate memory space to save the register information and create
debugfs files to display the saved information. In this process, the
debugfs files created after each dump.

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
Link: https://lore.kernel.org/r/20241008021822.2617339-13-liyihang9@huawei.com
Reviewed-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 99 ++++++++++++++++++++------
 1 file changed, 77 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 5bf4b61eed51d..bdcabad21f697 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3551,6 +3551,11 @@ debugfs_to_reg_name_v3_hw(int off, int base_off,
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
@@ -3576,6 +3581,9 @@ static int debugfs_global_v3_hw_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_debugfs_regs *global = s->private;
 
+	if (!debugfs_dump_is_generated_v3_hw(global->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(global->data, s,
 				&debugfs_global_reg);
 
@@ -3587,6 +3595,9 @@ static int debugfs_axi_v3_hw_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_debugfs_regs *axi = s->private;
 
+	if (!debugfs_dump_is_generated_v3_hw(axi->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(axi->data, s,
 				&debugfs_axi_reg);
 
@@ -3598,6 +3609,9 @@ static int debugfs_ras_v3_hw_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_debugfs_regs *ras = s->private;
 
+	if (!debugfs_dump_is_generated_v3_hw(ras->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(ras->data, s,
 				&debugfs_ras_reg);
 
@@ -3610,6 +3624,9 @@ static int debugfs_port_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_port *port = s->private;
 	const struct hisi_sas_debugfs_reg *reg_port = &debugfs_port_reg;
 
+	if (!debugfs_dump_is_generated_v3_hw(port->data))
+		return -EPERM;
+
 	debugfs_print_reg_v3_hw(port->data, s, reg_port);
 
 	return 0;
@@ -3665,6 +3682,9 @@ static int debugfs_cq_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_cq *debugfs_cq = s->private;
 	int slot;
 
+	if (!debugfs_dump_is_generated_v3_hw(debugfs_cq->complete_hdr))
+		return -EPERM;
+
 	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++)
 		debugfs_cq_show_slot_v3_hw(s, slot, debugfs_cq);
 
@@ -3686,8 +3706,12 @@ static void debugfs_dq_show_slot_v3_hw(struct seq_file *s, int slot,
 
 static int debugfs_dq_v3_hw_show(struct seq_file *s, void *p)
 {
+	struct hisi_sas_debugfs_dq *debugfs_dq = s->private;
 	int slot;
 
+	if (!debugfs_dump_is_generated_v3_hw(debugfs_dq->hdr))
+		return -EPERM;
+
 	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++)
 		debugfs_dq_show_slot_v3_hw(s, slot, s->private);
 
@@ -3701,6 +3725,9 @@ static int debugfs_iost_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_iost *iost = debugfs_iost->iost;
 	int i, max_command_entries = HISI_SAS_MAX_COMMANDS;
 
+	if (!debugfs_dump_is_generated_v3_hw(iost))
+		return -EPERM;
+
 	for (i = 0; i < max_command_entries; i++, iost++) {
 		__le64 *data = &iost->qw0;
 
@@ -3720,6 +3747,9 @@ static int debugfs_iost_cache_v3_hw_show(struct seq_file *s, void *p)
 	int i, tab_idx;
 	__le64 *iost;
 
+	if (!debugfs_dump_is_generated_v3_hw(iost_cache))
+		return -EPERM;
+
 	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, iost_cache++) {
 		/*
 		 * Data struct of IOST cache:
@@ -3743,6 +3773,9 @@ static int debugfs_itct_v3_hw_show(struct seq_file *s, void *p)
 	struct hisi_sas_debugfs_itct *debugfs_itct = s->private;
 	struct hisi_sas_itct *itct = debugfs_itct->itct;
 
+	if (!debugfs_dump_is_generated_v3_hw(itct))
+		return -EPERM;
+
 	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, itct++) {
 		__le64 *data = &itct->qw0;
 
@@ -3762,6 +3795,9 @@ static int debugfs_itct_cache_v3_hw_show(struct seq_file *s, void *p)
 	int i, tab_idx;
 	__le64 *itct;
 
+	if (!debugfs_dump_is_generated_v3_hw(itct_cache))
+		return -EPERM;
+
 	for (i = 0; i < HISI_SAS_IOST_ITCT_CACHE_NUM; i++, itct_cache++) {
 		/*
 		 * Data struct of ITCT cache:
@@ -3779,10 +3815,9 @@ static int debugfs_itct_cache_v3_hw_show(struct seq_file *s, void *p)
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
@@ -3790,17 +3825,17 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
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
@@ -3809,7 +3844,7 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", p);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_port_reg[dump_index][p],
+				    &hisi_hba->debugfs_port_reg[index][p],
 				    &debugfs_port_v3_hw_fops);
 	}
 
@@ -3819,7 +3854,7 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
 		snprintf(name, 256, "%d", c);
 
 		debugfs_create_file(name, 0400, dentry,
-				    &hisi_hba->debugfs_cq[dump_index][c],
+				    &hisi_hba->debugfs_cq[index][c],
 				    &debugfs_cq_v3_hw_fops);
 	}
 
@@ -3829,32 +3864,32 @@ static void debugfs_create_files_v3_hw(struct hisi_hba *hisi_hba)
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
 
@@ -4517,22 +4552,34 @@ static void debugfs_release_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
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
@@ -4659,8 +4706,6 @@ static int debugfs_snapshot_regs_v3_hw(struct hisi_hba *hisi_hba)
 	debugfs_snapshot_itct_reg_v3_hw(hisi_hba);
 	debugfs_snapshot_iost_reg_v3_hw(hisi_hba);
 
-	debugfs_create_files_v3_hw(hisi_hba);
-
 	debugfs_snapshot_restore_v3_hw(hisi_hba);
 	hisi_hba->debugfs_dump_index++;
 
@@ -4744,6 +4789,17 @@ static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
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
@@ -4764,8 +4820,7 @@ static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
 	/* create bist structures */
 	debugfs_bist_init_v3_hw(hisi_hba);
 
-	hisi_hba->debugfs_dump_dentry =
-			debugfs_create_dir("dump", hisi_hba->debugfs_dir);
+	debugfs_dump_init_v3_hw(hisi_hba);
 
 	debugfs_phy_down_cnt_init_v3_hw(hisi_hba);
 	debugfs_fifo_init_v3_hw(hisi_hba);
-- 
2.43.0


