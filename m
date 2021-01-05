Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133A32EAA02
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Jan 2021 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbhAELgC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Jan 2021 06:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbhAELfm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Jan 2021 06:35:42 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01985C061794;
        Tue,  5 Jan 2021 03:35:02 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lt17so40781086ejb.3;
        Tue, 05 Jan 2021 03:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zAve0h42Kexq4ViJloINYZNQ2O2w9ogGHjXf0XBmUrk=;
        b=moav0DzwPJ92ba15OEG/wmrU0zIYVzys6mFAhU966VEloAbJrz/OBo/2sHcgtd1DUS
         SDFSAYltsl8U8fkdoJK2xWnH+Ij1UUQ9nEciznvpW+0JyrBoQ+kU6+Fyp5S0zpVsjzUL
         TJtGIVnkc4Yl4cgkAgeFWsIrYywbDgB6GSwnX/tyMKbaT3h78dALJgnhjxbe0f/u8Dk2
         PHejwo08dP+SUXJX6sSMEAaH5OCoitYiywuGo8WOFYofAbQ77OEtMne+7ms5JFPSAgvF
         xjFiPadpNBl4ZivnFxLSL27hjdioL805obG/U+b9CmB5XqLsWU9IlJC0shUhUm1owqzy
         MQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zAve0h42Kexq4ViJloINYZNQ2O2w9ogGHjXf0XBmUrk=;
        b=qkutlrSvtsbKmzt+P3EGp98JzjxGQzfCGHTsioksFfu4Lorfra0n4UBtRV5wUfICcf
         REFXBm7fqlOk2qboOx56DCLEWVDmkcQgSWO2K3a4mUSs4M145+ePR5SdExovUyYZpzQ/
         cLXFXRxZ1RiaWFDKGwkhYEBGiqME2Su1RPEVfoLH1IEodZtyPp/RogDQYcXjltEoZ0o3
         RuCl+VPe8DlTQwkA9jd9vaBI+ss5940r4b47yL/I4Y0m/YT1U5x4WR3MYpOlxLkMNDL+
         GQ4y0pN3tJISUij/kaPgAmAon9O7owFI9SUrxYfYGLJ+oDMLXy2Oy3SboEvgFBRTtBWj
         I3QA==
X-Gm-Message-State: AOAM530xQ+pE8lvdZlh8pi0LMpSi+q0D1PbLCQQapFXEsxph5oDx0/f/
        OEsxMwCsPUc06sXCO77LukE=
X-Google-Smtp-Source: ABdhPJyXgRxEdcvcgtD3eBHeLqz5/OCVsjfwZKiAGKfm2RPwWQ6phYCkjIplgbKYtosNrroLhFPqYg==
X-Received: by 2002:a17:906:4705:: with SMTP id y5mr69462022ejq.112.1609846500727;
        Tue, 05 Jan 2021 03:35:00 -0800 (PST)
Received: from localhost.localdomain (ip5f5bfcff.dynamic.kabel-deutschland.de. [95.91.252.255])
        by smtp.gmail.com with ESMTPSA id n17sm24640772ejh.49.2021.01.05.03.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 03:35:00 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, rostedt@goodmis.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] scsi: ufs: Use __print_symbolic() for UFS trace string print
Date:   Tue,  5 Jan 2021 12:34:42 +0100
Message-Id: <20210105113446.16027-3-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105113446.16027-1-huobean@gmail.com>
References: <20210105113446.16027-1-huobean@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

__print_symbolic() is designed for exporting the print formatting table
to userspace and allows parsing tool, such as trace-cmd and perf, to analyze
trace log according to this print formatting table, meanwhile, by using
__print_symbolic()s, save space in the trace ring buffer.

original print format:

print fmt: "%s: %s: HDR:%s, CDB:%s", __get_str(str), __get_str(dev_name),
            __print_hex(REC->hdr, sizeof(REC->hdr)),
            __print_hex(REC->tsf, sizeof(REC->tsf))

after this change:

print fmt: "%s: %s: HDR:%s, CDB:%s",
      print_symbolic(REC->str_t, {0, "send"},
                                 {1, "complete"},
                                 {2, "dev_complete"},
                                 {3, "query_send"},
                                 {4, "query_complete"},
                                 {5, "query_complete_err"},
                                 {6, "tm_send"},
                                 {7, "tm_complete"},
                                 {8, "tm_complete_err"}),
      __get_str(dev_name), __print_hex(REC->hdr, sizeof(REC->hdr)),
      __print_hex(REC->tsf, sizeof(REC->tsf))

Note: This patch just converts current __get_str(str) to __print_symbolic(),
      the original tracing log will not be affected by this change, so it
      doesn't break what current parsers expect.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufs.h     | 10 +++++++
 drivers/scsi/ufs/ufshcd.c  | 48 ++++++++++++++++-----------------
 include/trace/events/ufs.h | 54 ++++++++++++++++++++++++--------------
 3 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 14dfda735adf..ba24b504f85a 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -545,6 +545,16 @@ struct ufs_dev_info {
 	u8 b_presrv_uspc_en;
 };
 
+/*
+ * This enum is used in string mapping in include/trace/events/ufs.h.
+ */
+enum ufs_trace_str_t {
+	UFS_CMD_SEND, UFS_CMD_COMP, UFS_DEV_COMP,
+	UFS_QUERY_SEND, UFS_QUERY_COMP, UFS_QUERY_ERR,
+	UFS_TM_SEND, UFS_TM_COMP, UFS_TM_ERR
+};
+
+
 /**
  * ufs_is_valid_unit_desc_lun - checks if the given LUN has a unit descriptor
  * @dev_info: pointer of instance of struct ufs_dev_info
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 82ad31781bc9..c68afd356abb 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -305,53 +305,53 @@ static void ufshcd_scsi_block_requests(struct ufs_hba *hba)
 }
 
 static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
-		const char *str)
+				      enum ufs_trace_str_t str_t)
 {
 	struct utp_upiu_req *rq = hba->lrb[tag].ucd_req_ptr;
 
-	trace_ufshcd_upiu(dev_name(hba->dev), str, &rq->header, &rq->sc.cdb);
+	trace_ufshcd_upiu(dev_name(hba->dev), str_t, &rq->header, &rq->sc.cdb);
 }
 
 static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba, unsigned int tag,
-		const char *str)
+					enum ufs_trace_str_t str_t)
 {
 	struct utp_upiu_req *rq = hba->lrb[tag].ucd_req_ptr;
 
-	trace_ufshcd_upiu(dev_name(hba->dev), str, &rq->header, &rq->qr);
+	trace_ufshcd_upiu(dev_name(hba->dev), str_t, &rq->header, &rq->qr);
 }
 
 static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
-		const char *str)
+				     enum ufs_trace_str_t str_t)
 {
 	int off = (int)tag - hba->nutrs;
 	struct utp_task_req_desc *descp = &hba->utmrdl_base_addr[off];
 
-	trace_ufshcd_upiu(dev_name(hba->dev), str, &descp->req_header,
+	trace_ufshcd_upiu(dev_name(hba->dev), str_t, &descp->req_header,
 			&descp->input_param1);
 }
 
 static void ufshcd_add_uic_command_trace(struct ufs_hba *hba,
 					 struct uic_command *ucmd,
-					 const char *str)
+					 enum ufs_trace_str_t str_t)
 {
 	u32 cmd;
 
 	if (!trace_ufshcd_uic_command_enabled())
 		return;
 
-	if (!strcmp(str, "send"))
+	if (str_t == UFS_CMD_SEND)
 		cmd = ucmd->command;
 	else
 		cmd = ufshcd_readl(hba, REG_UIC_COMMAND);
 
-	trace_ufshcd_uic_command(dev_name(hba->dev), str, cmd,
+	trace_ufshcd_uic_command(dev_name(hba->dev), str_t, cmd,
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_1),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_2),
 				 ufshcd_readl(hba, REG_UIC_COMMAND_ARG_3));
 }
 
-static void ufshcd_add_command_trace(struct ufs_hba *hba,
-		unsigned int tag, const char *str)
+static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
+				     enum ufs_trace_str_t str_t)
 {
 	sector_t lba = -1;
 	u8 opcode = 0, group_id = 0;
@@ -363,13 +363,13 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
 	if (!trace_ufshcd_command_enabled()) {
 		/* trace UPIU W/O tracing command */
 		if (cmd)
-			ufshcd_add_cmd_upiu_trace(hba, tag, str);
+			ufshcd_add_cmd_upiu_trace(hba, tag, str_t);
 		return;
 	}
 
 	if (cmd) { /* data phase exists */
 		/* trace UPIU also */
-		ufshcd_add_cmd_upiu_trace(hba, tag, str);
+		ufshcd_add_cmd_upiu_trace(hba, tag, str_t);
 		opcode = cmd->cmnd[0];
 		if ((opcode == READ_10) || (opcode == WRITE_10)) {
 			/*
@@ -392,7 +392,7 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
 
 	intr = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	trace_ufshcd_command(dev_name(hba->dev), str, tag,
+	trace_ufshcd_command(dev_name(hba->dev), str_t, tag,
 			doorbell, transfer_len, intr, lba, opcode, group_id);
 }
 
@@ -2001,7 +2001,7 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	lrbp->issue_time_stamp = ktime_get();
 	lrbp->compl_time_stamp = ktime_set(0, 0);
 	ufshcd_vops_setup_xfer_req(hba, task_tag, (lrbp->cmd ? true : false));
-	ufshcd_add_command_trace(hba, task_tag, "send");
+	ufshcd_add_command_trace(hba, task_tag, UFS_CMD_SEND);
 	ufshcd_clk_scaling_start_busy(hba);
 	__set_bit(task_tag, &hba->outstanding_reqs);
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
@@ -2137,7 +2137,7 @@ ufshcd_dispatch_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	ufshcd_writel(hba, uic_cmd->argument2, REG_UIC_COMMAND_ARG_2);
 	ufshcd_writel(hba, uic_cmd->argument3, REG_UIC_COMMAND_ARG_3);
 
-	ufshcd_add_uic_command_trace(hba, uic_cmd, "send");
+	ufshcd_add_uic_command_trace(hba, uic_cmd, UFS_CMD_SEND);
 
 	/* Write UIC Cmd */
 	ufshcd_writel(hba, uic_cmd->command & COMMAND_OPCODE_MASK,
@@ -2856,7 +2856,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	hba->dev_cmd.complete = &wait;
 
-	ufshcd_add_query_upiu_trace(hba, tag, "query_send");
+	ufshcd_add_query_upiu_trace(hba, tag, UFS_QUERY_SEND);
 	/* Make sure descriptors are ready before ringing the doorbell */
 	wmb();
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -2867,7 +2867,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 out:
 	ufshcd_add_query_upiu_trace(hba, tag,
-			err ? "query_complete_err" : "query_complete");
+			err ? UFS_QUERY_ERR : UFS_QUERY_COMP);
 
 out_put_tag:
 	blk_put_request(req);
@@ -5028,7 +5028,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 
 	if (retval == IRQ_HANDLED)
 		ufshcd_add_uic_command_trace(hba, hba->active_uic_cmd,
-					     "complete");
+					     UFS_CMD_COMP);
 	return retval;
 }
 
@@ -5052,7 +5052,7 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 		lrbp->compl_time_stamp = ktime_get();
 		cmd = lrbp->cmd;
 		if (cmd) {
-			ufshcd_add_command_trace(hba, index, "complete");
+			ufshcd_add_command_trace(hba, index, UFS_CMD_COMP);
 			result = ufshcd_transfer_rsp_status(hba, lrbp);
 			scsi_dma_unmap(cmd);
 			cmd->result = result;
@@ -5066,7 +5066,7 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 			lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
 			if (hba->dev_cmd.complete) {
 				ufshcd_add_command_trace(hba, index,
-						"dev_complete");
+							 UFS_DEV_COMP);
 				complete(hba->dev_cmd.complete);
 				update_scaling = true;
 			}
@@ -6369,7 +6369,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 
 	spin_unlock_irqrestore(host->host_lock, flags);
 
-	ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_send");
+	ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_SEND);
 
 	/* wait until the task management command is completed */
 	err = wait_for_completion_io_timeout(&wait,
@@ -6380,7 +6380,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		 * use-after-free.
 		 */
 		req->end_io_data = NULL;
-		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete_err");
+		ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_ERR);
 		dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
 				__func__, tm_function);
 		if (ufshcd_clear_tm_cmd(hba, free_slot))
@@ -6391,7 +6391,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		err = 0;
 		memcpy(treq, hba->utmrdl_base_addr + free_slot, sizeof(*treq));
 
-		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete");
+		ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_COMP);
 	}
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index fa755394bc0f..7613a5cd14de 100644
--- a/include/trace/events/ufs.h
+++ b/include/trace/events/ufs.h
@@ -37,6 +37,17 @@
 	EM(REQ_CLKS_OFF,		"REQ_CLKS_OFF")		\
 	EMe(REQ_CLKS_ON,		"REQ_CLKS_ON")
 
+#define UFS_CMD_TRACE_STRINGS					\
+	EM(UFS_CMD_SEND,	"send_req")			\
+	EM(UFS_CMD_COMP,	"complete_rsp")			\
+	EM(UFS_DEV_COMP,	"dev_complete")			\
+	EM(UFS_QUERY_SEND,	"query_send")			\
+	EM(UFS_QUERY_COMP,	"query_complete")		\
+	EM(UFS_QUERY_ERR,	"query_complete_err")		\
+	EM(UFS_TM_SEND,		"tm_send")			\
+	EM(UFS_TM_COMP,		"tm_complete")			\
+	EMe(UFS_TM_ERR,		"tm_complete_err")
+
 /* Enums require being exported to userspace, for user tool parsing */
 #undef EM
 #undef EMe
@@ -46,6 +57,7 @@
 UFS_LINK_STATES;
 UFS_PWR_MODES;
 UFSCHD_CLK_GATING_STATES;
+UFS_CMD_TRACE_STRINGS
 
 /*
  * Now redefine the EM() and EMe() macros to map the enums to the strings
@@ -56,6 +68,9 @@ UFSCHD_CLK_GATING_STATES;
 #define EM(a, b)	{a, b},
 #define EMe(a, b)	{a, b}
 
+#define show_ufs_cmd_trace_str(str_t)	\
+				__print_symbolic(str_t, UFS_CMD_TRACE_STRINGS)
+
 TRACE_EVENT(ufshcd_clk_gating,
 
 	TP_PROTO(const char *dev_name, int state),
@@ -223,16 +238,16 @@ DEFINE_EVENT(ufshcd_template, ufshcd_init,
 	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
 
 TRACE_EVENT(ufshcd_command,
-	TP_PROTO(const char *dev_name, const char *str, unsigned int tag,
-			u32 doorbell, int transfer_len, u32 intr, u64 lba,
-			u8 opcode, u8 group_id),
+	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t,
+		 unsigned int tag, u32 doorbell, int transfer_len, u32 intr,
+		 u64 lba, u8 opcode, u8 group_id),
 
-	TP_ARGS(dev_name, str, tag, doorbell, transfer_len,
+	TP_ARGS(dev_name, str_t, tag, doorbell, transfer_len,
 				intr, lba, opcode, group_id),
 
 	TP_STRUCT__entry(
 		__string(dev_name, dev_name)
-		__string(str, str)
+		__field(enum ufs_trace_str_t, str_t)
 		__field(unsigned int, tag)
 		__field(u32, doorbell)
 		__field(int, transfer_len)
@@ -244,7 +259,7 @@ TRACE_EVENT(ufshcd_command,
 
 	TP_fast_assign(
 		__assign_str(dev_name, dev_name);
-		__assign_str(str, str);
+		__entry->str_t = str_t;
 		__entry->tag = tag;
 		__entry->doorbell = doorbell;
 		__entry->transfer_len = transfer_len;
@@ -256,22 +271,22 @@ TRACE_EVENT(ufshcd_command,
 
 	TP_printk(
 		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x",
-		__get_str(str), __get_str(dev_name), __entry->tag,
-		__entry->doorbell, __entry->transfer_len,
+		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
+		__entry->tag, __entry->doorbell, __entry->transfer_len,
 		__entry->intr, __entry->lba, (u32)__entry->opcode,
 		str_opcode(__entry->opcode), (u32)__entry->group_id
 	)
 );
 
 TRACE_EVENT(ufshcd_uic_command,
-	TP_PROTO(const char *dev_name, const char *str, u32 cmd,
+	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, u32 cmd,
 		 u32 arg1, u32 arg2, u32 arg3),
 
-	TP_ARGS(dev_name, str, cmd, arg1, arg2, arg3),
+	TP_ARGS(dev_name, str_t, cmd, arg1, arg2, arg3),
 
 	TP_STRUCT__entry(
 		__string(dev_name, dev_name)
-		__string(str, str)
+		__field(enum ufs_trace_str_t, str_t)
 		__field(u32, cmd)
 		__field(u32, arg1)
 		__field(u32, arg2)
@@ -280,7 +295,7 @@ TRACE_EVENT(ufshcd_uic_command,
 
 	TP_fast_assign(
 		__assign_str(dev_name, dev_name);
-		__assign_str(str, str);
+		__entry->str_t = str_t;
 		__entry->cmd = cmd;
 		__entry->arg1 = arg1;
 		__entry->arg2 = arg2;
@@ -289,33 +304,34 @@ TRACE_EVENT(ufshcd_uic_command,
 
 	TP_printk(
 		"%s: %s: cmd: 0x%x, arg1: 0x%x, arg2: 0x%x, arg3: 0x%x",
-		__get_str(str), __get_str(dev_name), __entry->cmd,
-		__entry->arg1, __entry->arg2, __entry->arg3
+		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
+		__entry->cmd, __entry->arg1, __entry->arg2, __entry->arg3
 	)
 );
 
 TRACE_EVENT(ufshcd_upiu,
-	TP_PROTO(const char *dev_name, const char *str, void *hdr, void *tsf),
+	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t, void *hdr,
+		 void *tsf),
 
-	TP_ARGS(dev_name, str, hdr, tsf),
+	TP_ARGS(dev_name, str_t, hdr, tsf),
 
 	TP_STRUCT__entry(
 		__string(dev_name, dev_name)
-		__string(str, str)
+		__field(enum ufs_trace_str_t, str_t)
 		__array(unsigned char, hdr, 12)
 		__array(unsigned char, tsf, 16)
 	),
 
 	TP_fast_assign(
 		__assign_str(dev_name, dev_name);
-		__assign_str(str, str);
+		__entry->str_t = str_t;
 		memcpy(__entry->hdr, hdr, sizeof(__entry->hdr));
 		memcpy(__entry->tsf, tsf, sizeof(__entry->tsf));
 	),
 
 	TP_printk(
 		"%s: %s: HDR:%s, CDB:%s",
-		__get_str(str), __get_str(dev_name),
+		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
 		__print_hex(__entry->hdr, sizeof(__entry->hdr)),
 		__print_hex(__entry->tsf, sizeof(__entry->tsf))
 	)
-- 
2.17.1

