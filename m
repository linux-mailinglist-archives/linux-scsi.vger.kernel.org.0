Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5629975F
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 20:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgJZTvg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 15:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgJZTve (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Oct 2020 15:51:34 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18EDA207F7;
        Mon, 26 Oct 2020 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741893;
        bh=zQZFSX0npmQuQeQGY4zF4LfIkhpH+ObSpyi5XTvCmXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdZjVXnPOMdVYuZb2rj43MBi6K0NWZQhdKEE5spmU7fCUlduogDgOVFetMNbbGqzV
         m1Wou3+LPP7u6u79znwi3Q0jpTlmS11o1Hv/zeXslFWxj4eA7u9GkTaJyisggz9osN
         lJCXhPw1IWZXKluz9uyrpJrUZgYf8ouogmVk17i0=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, Jaegeuk Kim <jaegeuk@google.com>
Subject: [PATCH v4 4/5] scsi: add more contexts in the ufs tracepoints
Date:   Mon, 26 Oct 2020 12:51:23 -0700
Message-Id: <20201026195124.363096-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026195124.363096-1-jaegeuk@kernel.org>
References: <20201026195124.363096-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@google.com>

This adds user-friendly tracepoints with group id.

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
Reviewed-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c  |  6 ++++--
 include/trace/events/ufs.h | 21 +++++++++++++++++----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c45c0cff174e..b8a54d09e750 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -348,7 +348,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
 		unsigned int tag, const char *str)
 {
 	sector_t lba = -1;
-	u8 opcode = 0;
+	u8 opcode = 0, group_id = 0;
 	u32 intr, doorbell;
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct scsi_cmnd *cmd = lrbp->cmd;
@@ -374,13 +374,15 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
 				lba = cmd->request->bio->bi_iter.bi_sector;
 			transfer_len = be32_to_cpu(
 				lrbp->ucd_req_ptr->sc.exp_data_transfer_len);
+			if (opcode == WRITE_10)
+				group_id = lrbp->cmd->cmnd[6];
 		}
 	}
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	trace_ufshcd_command(dev_name(hba->dev), str, tag,
-				doorbell, transfer_len, intr, lba, opcode);
+			doorbell, transfer_len, intr, lba, opcode, group_id);
 }
 
 static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index 84841b3a7ffd..50654f352639 100644
--- a/include/trace/events/ufs.h
+++ b/include/trace/events/ufs.h
@@ -11,6 +11,15 @@
 
 #include <linux/tracepoint.h>
 
+#define str_opcode(opcode)						\
+	__print_symbolic(opcode,					\
+		{ WRITE_16,		"WRITE_16" },			\
+		{ WRITE_10,		"WRITE_10" },			\
+		{ READ_16,		"READ_16" },			\
+		{ READ_10,		"READ_10" },			\
+		{ SYNCHRONIZE_CACHE,	"SYNC" },			\
+		{ UNMAP,		"UNMAP" })
+
 #define UFS_LINK_STATES			\
 	EM(UIC_LINK_OFF_STATE)		\
 	EM(UIC_LINK_ACTIVE_STATE)	\
@@ -215,9 +224,10 @@ DEFINE_EVENT(ufshcd_template, ufshcd_init,
 TRACE_EVENT(ufshcd_command,
 	TP_PROTO(const char *dev_name, const char *str, unsigned int tag,
 			u32 doorbell, int transfer_len, u32 intr, u64 lba,
-			u8 opcode),
+			u8 opcode, u8 group_id),
 
-	TP_ARGS(dev_name, str, tag, doorbell, transfer_len, intr, lba, opcode),
+	TP_ARGS(dev_name, str, tag, doorbell, transfer_len,
+				intr, lba, opcode, group_id),
 
 	TP_STRUCT__entry(
 		__string(dev_name, dev_name)
@@ -228,6 +238,7 @@ TRACE_EVENT(ufshcd_command,
 		__field(u32, intr)
 		__field(u64, lba)
 		__field(u8, opcode)
+		__field(u8, group_id)
 	),
 
 	TP_fast_assign(
@@ -239,13 +250,15 @@ TRACE_EVENT(ufshcd_command,
 		__entry->intr = intr;
 		__entry->lba = lba;
 		__entry->opcode = opcode;
+		__entry->group_id = group_id;
 	),
 
 	TP_printk(
-		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x",
+		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x",
 		__get_str(str), __get_str(dev_name), __entry->tag,
 		__entry->doorbell, __entry->transfer_len,
-		__entry->intr, __entry->lba, (u32)__entry->opcode
+		__entry->intr, __entry->lba, (u32)__entry->opcode,
+		str_opcode(__entry->opcode), (u32)__entry->group_id
 	)
 );
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

