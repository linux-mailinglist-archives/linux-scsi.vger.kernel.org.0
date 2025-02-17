Return-Path: <linux-scsi+bounces-12263-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8785A33E34
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F50168D70
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D37227E9F;
	Thu, 13 Feb 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FBXd1QZA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B04227E8D
	for <linux-scsi@vger.kernel.org>; Thu, 13 Feb 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446647; cv=none; b=aS32QRd9rB3Tc1dw+XzUeCFiAY2i4oKCgirFVdPzKIdlrbgeK7A635KvZ3om/819fDpC83+OFxmQirR8pN4q4M5tEl0q+nns5JmmdHJvzSdAI9lnkPhEIzyt/mYS7ABDMR1PUPAyyon55FDQDmMmC2wIC85djV+miA6xWbh5CuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446647; c=relaxed/simple;
	bh=CpEiQsaHvgPl55RTIQVaeGg9gu2N0rtfAX7UQ3xIxZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azkgoo/XIt9Dc7gqx2kMxjZJiIZ2F7gauj4tqi7nz1hNO+7CFPhbqhxSxnS/d6vk9hm86WmTN2luYy2wgJCl4icruFVV0wiYufrjLQJhnN5ib8oqgJmrzo3aT2iCbZeQ7zvefV1TT/i+3oHp2QpuQ1qrhQ0giDhjubL8XkjUb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FBXd1QZA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dd149378e9fe11efb8f9918b5fc74e19-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CkzXE8aXGcgPTkLcPnjEwJNr6bFUk3BnAKyvsts2yrM=;
	b=FBXd1QZA3jpOvKfyTfwsudlXNx2gNZ7++lwMkqyZz8yehqn4l3f6iSZuOi9l57kuLfPYkEES4Oj7SA83/qcu+kh+7n71lz6hnnzFtqF75solEwxpsHEta896STDU/xUtfHi6dTmh92x4swSJdOO0Eakjh7Tjk6JCNzZjdf3+eS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:a86b9629-7d60-46a4-81ca-8a1b46157e36,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:60aa074,CLOUDID:90d06aa1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil
	,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: dd149378e9fe11efb8f9918b5fc74e19-20250213
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 387896126; Thu, 13 Feb 2025 19:37:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 19:37:09 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 19:37:09 +0800
From: <peter.wang@mediatek.com>
To: <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
	<avri.altman@wdc.com>, <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
	<sutoshd@codeaurora.org>
CC: <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
	<alice.chao@mediatek.com>, <cc.chou@mediatek.com>,
	<chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
	<yi-fan.peng@mediatek.com>, <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>,
	<tun-yu.yu@mediatek.com>, <eddie.huang@mediatek.com>,
	<naomi.chu@mediatek.com>, <ed.tsai@mediatek.com>, <bvanassche@acm.org>
Subject: [PATCH v2] ufs: core: add hba parameter to trace events
Date: Thu, 13 Feb 2025 19:35:17 +0800
Message-ID: <20250213113707.955255-1-peter.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Peter Wang <peter.wang@mediatek.com>

Included the ufs_hba structure as a parameter in various trace events
to provide more context and improve debugging capabilities.
Also remove dev_name and replace it with dev_name(hba->dev).

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
---
 drivers/ufs/core/ufs_trace.h | 119 ++++++++++++++++++++---------------
 drivers/ufs/core/ufshcd.c    |  68 ++++++++++----------
 2 files changed, 103 insertions(+), 84 deletions(-)

diff --git a/drivers/ufs/core/ufs_trace.h b/drivers/ufs/core/ufs_trace.h
index 84deca2b841d..2f79982846b6 100644
--- a/drivers/ufs/core/ufs_trace.h
+++ b/drivers/ufs/core/ufs_trace.h
@@ -83,16 +83,18 @@ UFS_CMD_TRACE_TSF_TYPES
 
 TRACE_EVENT(ufshcd_clk_gating,
 
-	TP_PROTO(const char *dev_name, int state),
+	TP_PROTO(struct ufs_hba *hba, int state),
 
-	TP_ARGS(dev_name, state),
+	TP_ARGS(hba, state),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(int, state)
 	),
 
 	TP_fast_assign(
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__entry->state = state;
 	),
@@ -104,13 +106,14 @@ TRACE_EVENT(ufshcd_clk_gating,
 
 TRACE_EVENT(ufshcd_clk_scaling,
 
-	TP_PROTO(const char *dev_name, const char *state, const char *clk,
+	TP_PROTO(struct ufs_hba *hba, const char *state, const char *clk,
 		u32 prev_state, u32 curr_state),
 
-	TP_ARGS(dev_name, state, clk, prev_state, curr_state),
+	TP_ARGS(hba, state, clk, prev_state, curr_state),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__string(state, state)
 		__string(clk, clk)
 		__field(u32, prev_state)
@@ -118,6 +121,7 @@ TRACE_EVENT(ufshcd_clk_scaling,
 	),
 
 	TP_fast_assign(
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__assign_str(state);
 		__assign_str(clk);
@@ -132,16 +136,18 @@ TRACE_EVENT(ufshcd_clk_scaling,
 
 TRACE_EVENT(ufshcd_auto_bkops_state,
 
-	TP_PROTO(const char *dev_name, const char *state),
+	TP_PROTO(struct ufs_hba *hba, const char *state),
 
-	TP_ARGS(dev_name, state),
+	TP_ARGS(hba, state),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__string(state, state)
 	),
 
 	TP_fast_assign(
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__assign_str(state);
 	),
@@ -151,19 +157,21 @@ TRACE_EVENT(ufshcd_auto_bkops_state,
 );
 
 DECLARE_EVENT_CLASS(ufshcd_profiling_template,
-	TP_PROTO(const char *dev_name, const char *profile_info, s64 time_us,
+	TP_PROTO(struct ufs_hba *hba, const char *profile_info, s64 time_us,
 		 int err),
 
-	TP_ARGS(dev_name, profile_info, time_us, err),
+	TP_ARGS(hba, profile_info, time_us, err),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__string(profile_info, profile_info)
 		__field(s64, time_us)
 		__field(int, err)
 	),
 
 	TP_fast_assign(
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__assign_str(profile_info);
 		__entry->time_us = time_us;
@@ -176,30 +184,31 @@ DECLARE_EVENT_CLASS(ufshcd_profiling_template,
 );
 
 DEFINE_EVENT(ufshcd_profiling_template, ufshcd_profile_hibern8,
-	TP_PROTO(const char *dev_name, const char *profile_info, s64 time_us,
+	TP_PROTO(struct ufs_hba *hba, const char *profile_info, s64 time_us,
 		 int err),
-	TP_ARGS(dev_name, profile_info, time_us, err));
+	TP_ARGS(hba, profile_info, time_us, err));
 
 DEFINE_EVENT(ufshcd_profiling_template, ufshcd_profile_clk_gating,
-	TP_PROTO(const char *dev_name, const char *profile_info, s64 time_us,
+	TP_PROTO(struct ufs_hba *hba, const char *profile_info, s64 time_us,
 		 int err),
-	TP_ARGS(dev_name, profile_info, time_us, err));
+	TP_ARGS(hba, profile_info, time_us, err));
 
 DEFINE_EVENT(ufshcd_profiling_template, ufshcd_profile_clk_scaling,
-	TP_PROTO(const char *dev_name, const char *profile_info, s64 time_us,
+	TP_PROTO(struct ufs_hba *hba, const char *profile_info, s64 time_us,
 		 int err),
-	TP_ARGS(dev_name, profile_info, time_us, err));
+	TP_ARGS(hba, profile_info, time_us, err));
 
 DECLARE_EVENT_CLASS(ufshcd_template,
-	TP_PROTO(const char *dev_name, int err, s64 usecs,
+	TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		 int dev_state, int link_state),
 
-	TP_ARGS(dev_name, err, usecs, dev_state, link_state),
+	TP_ARGS(hba, err, usecs, dev_state, link_state),
 
 	TP_STRUCT__entry(
 		__field(s64, usecs)
 		__field(int, err)
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(int, dev_state)
 		__field(int, link_state)
 	),
@@ -207,6 +216,7 @@ DECLARE_EVENT_CLASS(ufshcd_template,
 	TP_fast_assign(
 		__entry->usecs = usecs;
 		__entry->err = err;
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__entry->dev_state = dev_state;
 		__entry->link_state = link_state;
@@ -223,60 +233,62 @@ DECLARE_EVENT_CLASS(ufshcd_template,
 );
 
 DEFINE_EVENT(ufshcd_template, ufshcd_system_suspend,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_system_resume,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_runtime_suspend,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_runtime_resume,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_init,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_wl_suspend,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_wl_resume,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_wl_runtime_suspend,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 DEFINE_EVENT(ufshcd_template, ufshcd_wl_runtime_resume,
-	     TP_PROTO(const char *dev_name, int err, s64 usecs,
+	     TP_PROTO(struct ufs_hba *hba, int err, s64 usecs,
 		      int dev_state, int link_state),
-	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
+	     TP_ARGS(hba, err, usecs, dev_state, link_state));
 
 TRACE_EVENT(ufshcd_command,
-	TP_PROTO(struct scsi_device *sdev, enum ufs_trace_str_t str_t,
+	TP_PROTO(struct scsi_device *sdev, struct ufs_hba *hba,
+		 enum ufs_trace_str_t str_t,
 		 unsigned int tag, u32 doorbell, u32 hwq_id, int transfer_len,
 		 u32 intr, u64 lba, u8 opcode, u8 group_id),
 
-	TP_ARGS(sdev, str_t, tag, doorbell, hwq_id, transfer_len, intr, lba,
+	TP_ARGS(sdev, hba, str_t, tag, doorbell, hwq_id, transfer_len, intr, lba,
 		opcode, group_id),
 
 	TP_STRUCT__entry(
 		__field(struct scsi_device *, sdev)
+		__field(struct ufs_hba *, hba)
 		__field(enum ufs_trace_str_t, str_t)
 		__field(unsigned int, tag)
 		__field(u32, doorbell)
@@ -290,6 +302,7 @@ TRACE_EVENT(ufshcd_command,
 
 	TP_fast_assign(
 		__entry->sdev = sdev;
+		__entry->hba = hba;
 		__entry->str_t = str_t;
 		__entry->tag = tag;
 		__entry->doorbell = doorbell;
@@ -312,13 +325,14 @@ TRACE_EVENT(ufshcd_command,
 );
 
 TRACE_EVENT(ufshcd_uic_command,
-	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, u32 cmd,
+	TP_PROTO(struct ufs_hba *hba, enum ufs_trace_str_t str_t, u32 cmd,
 		 u32 arg1, u32 arg2, u32 arg3),
 
-	TP_ARGS(dev_name, str_t, cmd, arg1, arg2, arg3),
+	TP_ARGS(hba, str_t, cmd, arg1, arg2, arg3),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(enum ufs_trace_str_t, str_t)
 		__field(u32, cmd)
 		__field(u32, arg1)
@@ -327,6 +341,7 @@ TRACE_EVENT(ufshcd_uic_command,
 	),
 
 	TP_fast_assign(
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__entry->str_t = str_t;
 		__entry->cmd = cmd;
@@ -343,13 +358,14 @@ TRACE_EVENT(ufshcd_uic_command,
 );
 
 TRACE_EVENT(ufshcd_upiu,
-	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, void *hdr,
+	TP_PROTO(struct ufs_hba *hba, enum ufs_trace_str_t str_t, void *hdr,
 		 void *tsf, enum ufs_trace_tsf_t tsf_t),
 
-	TP_ARGS(dev_name, str_t, hdr, tsf, tsf_t),
+	TP_ARGS(hba, str_t, hdr, tsf, tsf_t),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(enum ufs_trace_str_t, str_t)
 		__array(unsigned char, hdr, 12)
 		__array(unsigned char, tsf, 16)
@@ -357,6 +373,7 @@ TRACE_EVENT(ufshcd_upiu,
 	),
 
 	TP_fast_assign(
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__entry->str_t = str_t;
 		memcpy(__entry->hdr, hdr, sizeof(__entry->hdr));
@@ -375,16 +392,18 @@ TRACE_EVENT(ufshcd_upiu,
 
 TRACE_EVENT(ufshcd_exception_event,
 
-	TP_PROTO(const char *dev_name, u16 status),
+	TP_PROTO(struct ufs_hba *hba, u16 status),
 
-	TP_ARGS(dev_name, status),
+	TP_ARGS(hba, status),
 
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(u16, status)
 	),
 
 	TP_fast_assign(
+		__entry->hba = hba;
 		__assign_str(dev_name);
 		__entry->status = status;
 	),
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1893a7ad9531..97c89ac73a54 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -369,7 +369,7 @@ static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 	else
 		header = &hba->lrb[tag].ucd_rsp_ptr->header;
 
-	trace_ufshcd_upiu(dev_name(hba->dev), str_t, header, &rq->sc.cdb,
+	trace_ufshcd_upiu(hba, str_t, header, &rq->sc.cdb,
 			  UFS_TSF_CDB);
 }
 
@@ -380,7 +380,7 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
 	if (!trace_ufshcd_upiu_enabled())
 		return;
 
-	trace_ufshcd_upiu(dev_name(hba->dev), str_t, &rq_rsp->header,
+	trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
 			  &rq_rsp->qr, UFS_TSF_OSF);
 }
 
@@ -393,12 +393,12 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 		return;
 
 	if (str_t == UFS_TM_SEND)
-		trace_ufshcd_upiu(dev_name(hba->dev), str_t,
+		trace_ufshcd_upiu(hba, str_t,
 				  &descp->upiu_req.req_header,
 				  &descp->upiu_req.input_param1,
 				  UFS_TSF_TM_INPUT);
 	else
-		trace_ufshcd_upiu(dev_name(hba->dev), str_t,
+		trace_ufshcd_upiu(hba, str_t,
 				  &descp->upiu_rsp.rsp_header,
 				  &descp->upiu_rsp.output_param1,
 				  UFS_TSF_TM_OUTPUT);
@@ -418,7 +418,7 @@ static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 	else
 		cmd = ufshcd_readl(hba, REG_UIC_COMMAND);
 
-	trace_ufshcd_uic_command(dev_name(hba->dev), str_t, cmd,
+	trace_ufshcd_uic_command(hba, str_t, cmd,
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
@@ -473,7 +473,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 	} else {
 		doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	}
-	trace_ufshcd_command(cmd->device, str_t, tag, doorbell, hwq_id,
+	trace_ufshcd_command(cmd->device, hba, str_t, tag, doorbell, hwq_id,
 			     transfer_len, intr, lba, opcode, group_id);
 }
 
@@ -1063,7 +1063,7 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 						clki->max_freq, ret);
 					break;
 				}
-				trace_ufshcd_clk_scaling(dev_name(hba->dev),
+				trace_ufshcd_clk_scaling(hba,
 						"scaled up", clki->name,
 						clki->curr_freq,
 						clki->max_freq);
@@ -1081,7 +1081,7 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 						clki->min_freq, ret);
 					break;
 				}
-				trace_ufshcd_clk_scaling(dev_name(hba->dev),
+				trace_ufshcd_clk_scaling(hba,
 						"scaled down", clki->name,
 						clki->curr_freq,
 						clki->min_freq);
@@ -1122,7 +1122,7 @@ int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
 				return ret;
 			}
 
-			trace_ufshcd_clk_scaling(dev_name(dev),
+			trace_ufshcd_clk_scaling(hba,
 				(scaling_down ? "scaled down" : "scaled up"),
 				clki->name, hba->clk_scaling.target_freq, freq);
 		}
@@ -1186,7 +1186,7 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
 	ufshcd_pm_qos_update(hba, scale_up);
 
 out:
-	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
+	trace_ufshcd_profile_clk_scaling(hba,
 			(scale_up ? "up" : "down"),
 			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
 	return ret;
@@ -1548,7 +1548,7 @@ static int ufshcd_devfreq_target(struct device *dev,
 	if (!ret)
 		hba->clk_scaling.target_freq = *freq;
 
-	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
+	trace_ufshcd_profile_clk_scaling(hba,
 		(scale_up ? "up" : "down"),
 		ktime_to_us(ktime_sub(ktime_get(), start)), ret);
 
@@ -1881,7 +1881,7 @@ void ufshcd_hold(struct ufs_hba *hba)
 	case REQ_CLKS_OFF:
 		if (cancel_delayed_work(&hba->clk_gating.gate_work)) {
 			hba->clk_gating.state = CLKS_ON;
-			trace_ufshcd_clk_gating(dev_name(hba->dev),
+			trace_ufshcd_clk_gating(hba,
 						hba->clk_gating.state);
 			break;
 		}
@@ -1893,7 +1893,7 @@ void ufshcd_hold(struct ufs_hba *hba)
 		fallthrough;
 	case CLKS_OFF:
 		hba->clk_gating.state = REQ_CLKS_ON;
-		trace_ufshcd_clk_gating(dev_name(hba->dev),
+		trace_ufshcd_clk_gating(hba,
 					hba->clk_gating.state);
 		queue_work(hba->clk_gating.clk_gating_workq,
 			   &hba->clk_gating.ungate_work);
@@ -1933,7 +1933,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 		if (hba->clk_gating.is_suspended ||
 		    hba->clk_gating.state != REQ_CLKS_OFF) {
 			hba->clk_gating.state = CLKS_ON;
-			trace_ufshcd_clk_gating(dev_name(hba->dev),
+			trace_ufshcd_clk_gating(hba,
 						hba->clk_gating.state);
 			return;
 		}
@@ -1955,7 +1955,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 			hba->clk_gating.state = CLKS_ON;
 			dev_err(hba->dev, "%s: hibern8 enter failed %d\n",
 					__func__, ret);
-			trace_ufshcd_clk_gating(dev_name(hba->dev),
+			trace_ufshcd_clk_gating(hba,
 						hba->clk_gating.state);
 			return;
 		}
@@ -1980,7 +1980,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 	guard(spinlock_irqsave)(&hba->clk_gating.lock);
 	if (hba->clk_gating.state == REQ_CLKS_OFF) {
 		hba->clk_gating.state = CLKS_OFF;
-		trace_ufshcd_clk_gating(dev_name(hba->dev),
+		trace_ufshcd_clk_gating(hba,
 					hba->clk_gating.state);
 	}
 }
@@ -2006,7 +2006,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
 	}
 
 	hba->clk_gating.state = REQ_CLKS_OFF;
-	trace_ufshcd_clk_gating(dev_name(hba->dev), hba->clk_gating.state);
+	trace_ufshcd_clk_gating(hba, hba->clk_gating.state);
 	queue_delayed_work(hba->clk_gating.clk_gating_workq,
 			   &hba->clk_gating.gate_work,
 			   msecs_to_jiffies(hba->clk_gating.delay_ms));
@@ -4422,7 +4422,7 @@ int ufshcd_uic_hibern8_enter(struct ufs_hba *hba)
 	ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_ENTER, PRE_CHANGE);
 
 	ret = ufshcd_uic_pwr_ctrl(hba, &uic_cmd);
-	trace_ufshcd_profile_hibern8(dev_name(hba->dev), "enter",
+	trace_ufshcd_profile_hibern8(hba, "enter",
 			     ktime_to_us(ktime_sub(ktime_get(), start)), ret);
 
 	if (ret)
@@ -4447,7 +4447,7 @@ int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 	ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_EXIT, PRE_CHANGE);
 
 	ret = ufshcd_uic_pwr_ctrl(hba, &uic_cmd);
-	trace_ufshcd_profile_hibern8(dev_name(hba->dev), "exit",
+	trace_ufshcd_profile_hibern8(hba, "exit",
 			     ktime_to_us(ktime_sub(ktime_get(), start)), ret);
 
 	if (ret) {
@@ -5808,7 +5808,7 @@ static int ufshcd_enable_auto_bkops(struct ufs_hba *hba)
 	}
 
 	hba->auto_bkops_enabled = true;
-	trace_ufshcd_auto_bkops_state(dev_name(hba->dev), "Enabled");
+	trace_ufshcd_auto_bkops_state(hba, "Enabled");
 
 	/* No need of URGENT_BKOPS exception from the device */
 	err = ufshcd_disable_ee(hba, MASK_EE_URGENT_BKOPS);
@@ -5859,7 +5859,7 @@ static int ufshcd_disable_auto_bkops(struct ufs_hba *hba)
 	}
 
 	hba->auto_bkops_enabled = false;
-	trace_ufshcd_auto_bkops_state(dev_name(hba->dev), "Disabled");
+	trace_ufshcd_auto_bkops_state(hba, "Disabled");
 	hba->is_urgent_bkops_lvl_checked = false;
 out:
 	return err;
@@ -6193,7 +6193,7 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 		return;
 	}
 
-	trace_ufshcd_exception_event(dev_name(hba->dev), status);
+	trace_ufshcd_exception_event(hba, status);
 
 	if (status & hba->ee_drv_mask & MASK_EE_URGENT_BKOPS)
 		ufshcd_bkops_exception_event_handler(hba);
@@ -7652,7 +7652,7 @@ static void ufshcd_process_probe_result(struct ufs_hba *hba,
 		hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
-	trace_ufshcd_init(dev_name(hba->dev), ret,
+	trace_ufshcd_init(hba, ret,
 			  ktime_to_us(ktime_sub(ktime_get(), probe_start)),
 			  hba->curr_dev_pwr_mode, hba->uic_link_state);
 }
@@ -9148,12 +9148,12 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 	} else if (!ret && on && hba->clk_gating.is_initialized) {
 		scoped_guard(spinlock_irqsave, &hba->clk_gating.lock)
 			hba->clk_gating.state = CLKS_ON;
-		trace_ufshcd_clk_gating(dev_name(hba->dev),
+		trace_ufshcd_clk_gating(hba,
 					hba->clk_gating.state);
 	}
 
 	if (clk_state_changed)
-		trace_ufshcd_profile_clk_gating(dev_name(hba->dev),
+		trace_ufshcd_profile_clk_gating(hba,
 			(on ? "on" : "off"),
 			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
 	return ret;
@@ -9853,7 +9853,7 @@ static int ufshcd_wl_runtime_suspend(struct device *dev)
 	if (ret)
 		dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__, ret);
 
-	trace_ufshcd_wl_runtime_suspend(dev_name(dev), ret,
+	trace_ufshcd_wl_runtime_suspend(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 
@@ -9873,7 +9873,7 @@ static int ufshcd_wl_runtime_resume(struct device *dev)
 	if (ret)
 		dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__, ret);
 
-	trace_ufshcd_wl_runtime_resume(dev_name(dev), ret,
+	trace_ufshcd_wl_runtime_resume(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 
@@ -9905,7 +9905,7 @@ static int ufshcd_wl_suspend(struct device *dev)
 out:
 	if (!ret)
 		hba->is_sys_suspended = true;
-	trace_ufshcd_wl_suspend(dev_name(dev), ret,
+	trace_ufshcd_wl_suspend(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 
@@ -9928,7 +9928,7 @@ static int ufshcd_wl_resume(struct device *dev)
 	if (ret)
 		dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__, ret);
 out:
-	trace_ufshcd_wl_resume(dev_name(dev), ret,
+	trace_ufshcd_wl_resume(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 	if (!ret)
@@ -9966,7 +9966,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	}
 	if (ufshcd_is_clkgating_allowed(hba)) {
 		hba->clk_gating.state = CLKS_OFF;
-		trace_ufshcd_clk_gating(dev_name(hba->dev),
+		trace_ufshcd_clk_gating(hba,
 					hba->clk_gating.state);
 	}
 
@@ -10039,7 +10039,7 @@ int ufshcd_system_suspend(struct device *dev)
 
 	ret = ufshcd_suspend(hba);
 out:
-	trace_ufshcd_system_suspend(dev_name(hba->dev), ret,
+	trace_ufshcd_system_suspend(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 	return ret;
@@ -10067,7 +10067,7 @@ int ufshcd_system_resume(struct device *dev)
 	ret = ufshcd_resume(hba);
 
 out:
-	trace_ufshcd_system_resume(dev_name(hba->dev), ret,
+	trace_ufshcd_system_resume(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 
@@ -10093,7 +10093,7 @@ int ufshcd_runtime_suspend(struct device *dev)
 
 	ret = ufshcd_suspend(hba);
 
-	trace_ufshcd_runtime_suspend(dev_name(hba->dev), ret,
+	trace_ufshcd_runtime_suspend(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 	return ret;
@@ -10120,7 +10120,7 @@ int ufshcd_runtime_resume(struct device *dev)
 
 	ret = ufshcd_resume(hba);
 
-	trace_ufshcd_runtime_resume(dev_name(hba->dev), ret,
+	trace_ufshcd_runtime_resume(hba, ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
 	return ret;
-- 
2.45.2


