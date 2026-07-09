Return-Path: <linux-scsi+bounces-25921-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nBamGPdLT2oAdwIAu9opvQ
	(envelope-from <linux-scsi+bounces-25921-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 09:21:27 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D172D8D5
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 09:21:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=ZWe9lplt;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25921-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25921-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C62E33027959
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2026 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3C13A3ED;
	Thu,  9 Jul 2026 07:18:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DA3C10AF;
	Thu,  9 Jul 2026 07:18:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581508; cv=none; b=hBfBRQmfFJHBa+OZBIjI5L3MuRDGPnYkPKD5U8iTCxxRC2DFddnkONYIcqFRXypsFZ4Q2OpdHHBhPs1KBxwmFce/yTyIgNBIItSlL2CnuhgRGi10XaZyySue8CFxeIrb7NM9AsFd+MMRWijmF9wyEWyGmtemIH4x/wvr+SPKSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581508; c=relaxed/simple;
	bh=3Kn6Asu/GK2QewGnNyPr3r0WsFsrDP9EWXeRsKbom8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mtC+N8bS4XL6f61lMslq9U1GpvdPyHcN1sJw6BEYRdUrwwonnjKLh7mDZ1xJ8gOG3jPfp3dKIcbgue9AvLLRVewcB4fMMyjC/SElOoAMZGF9X9fg1iVQjjoAx7ELRItYoWWO54L3+pICXDRmRS/ihhflM5mak/x0J4JHQAcal5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZWe9lplt; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+n
	h4PWUVd0enXrBygUSLENuQ5UoTQklbIU3BqiNPs/E=; b=ZWe9lpltEGmMZXxh0C
	7w1zqMYxcw8y2p1eXZ7V623BG419v2kkL9h+CMQn+B2A0bWlrGiW5sf8qt7+dnp3
	93Pl39DxU06j7vkGhoQF/u12x7eO4DykhECvICcLDgSIqUfKzWGSvRSeGY6TbzlM
	ACs3355v6iHnX02aloBqH8MOU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3iwMzS09q0GNBGw--.12571S2;
	Thu, 09 Jul 2026 15:18:13 +0800 (CST)
From: kensanya@163.com
To: martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: [PATCH v2] target/stat: implement scsiPortBusyStatuses counter
Date: Thu,  9 Jul 2026 15:18:05 +0800
Message-Id: <20260709071805.769860-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3iwMzS09q0GNBGw--.12571S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JryDKF45CFWrXr1UuFWrGrg_yoWxJF1rpF
	WUJFW5ArWDKFW8Ka18JF4jkrW5tw12gay2ka4xXas5Aws8trW3Cw1DJFW2vFs5JFWkG347
	Wa1qyFs8Ka12qrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG1v-UUUUU=
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbCwRVOKmpPSzVW3wAA3i
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tanzheng@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kensanya@163.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-25921-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kensanya@163.com,linux-scsi@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C5D172D8D5

From: TanZheng <tanzheng@kylinos.cn>

Implement RFC 4455 scsiPortBusyStatuses (ConfigFS busy_count) by adding a
per-CPU busy_statuses counter to scsi_port_stats, incrementing it when
the target sends SAM_STAT_BUSY, and summing all CPUs in the show handler.

Signed-off-by: TanZheng <tanzheng@kylinos.cn>
---
v2: 
1.By taking snapshots of lun, scsi_status and flags before queue_status(),
  the dereferencing of cmd after the callback is avoided.

---
 drivers/target/target_core_internal.h  |  2 ++
 drivers/target/target_core_stat.c      | 31 ++++++++++++++++++++++++--
 drivers/target/target_core_transport.c | 26 ++++++++++++++++-----
 include/target/target_core_base.h      |  1 +
 4 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index 763e6d26e187..c3aa8c514db7 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -161,6 +161,8 @@ void	target_queued_submit_work(struct work_struct *work);
 void	target_stat_setup_dev_default_groups(struct se_device *);
 void	target_stat_setup_port_default_groups(struct se_lun *);
 void	target_stat_setup_mappedlun_default_groups(struct se_lun_acl *);
+void	target_stat_count_sent_status(struct se_lun *lun, u8 scsi_status,
+				      u32 flags);
 
 /* target_core_xcopy.c */
 extern struct se_portal_group xcopy_pt_tpg;
diff --git a/drivers/target/target_core_stat.c b/drivers/target/target_core_stat.c
index 083205052be2..8ae238287065 100644
--- a/drivers/target/target_core_stat.c
+++ b/drivers/target/target_core_stat.c
@@ -21,12 +21,30 @@
 #include <linux/seq_file.h>
 #include <linux/configfs.h>
 
+#include <scsi/scsi_proto.h>
+
 #include <target/target_core_base.h>
 #include <target/target_core_backend.h>
 #include <target/target_core_fabric.h>
 
 #include "target_core_internal.h"
 
+void target_stat_count_sent_status(struct se_lun *lun, u8 scsi_status,
+				 u32 flags)
+{
+	if (flags & SCF_SCSI_TMR_CDB)
+		return;
+
+	switch (scsi_status) {
+	case SAM_STAT_BUSY:
+		if (lun && lun->lun_stats)
+			this_cpu_inc(lun->lun_stats->busy_statuses);
+		break;
+	default:
+		break;
+	}
+}
+
 #ifndef INITIAL_JIFFIES
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
 #endif
@@ -483,13 +501,22 @@ static ssize_t target_stat_port_busy_count_show(struct config_item *item,
 {
 	struct se_lun *lun = to_stat_port(item);
 	struct se_device *dev;
+	struct scsi_port_stats *stats;
+	unsigned int cpu;
+	u64 sum = 0;
 	ssize_t ret = -ENODEV;
 
 	rcu_read_lock();
 	dev = rcu_dereference(lun->lun_se_dev);
 	if (dev) {
-		/* FIXME: scsiPortBusyStatuses  */
-		ret = snprintf(page, PAGE_SIZE, "%u\n", 0);
+		/* scsiPortBusyStatuses */
+		if (lun->lun_stats) {
+			for_each_possible_cpu(cpu) {
+				stats = per_cpu_ptr(lun->lun_stats, cpu);
+				sum += stats->busy_statuses;
+			}
+		}
+		ret = snprintf(page, PAGE_SIZE, "%llu\n", sum);
 	}
 	rcu_read_unlock();
 	return ret;
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index fad03a15c969..bab5ee81817b 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -829,6 +829,20 @@ void transport_copy_sense_to_cmd(struct se_cmd *cmd, unsigned char *sense)
 }
 EXPORT_SYMBOL(transport_copy_sense_to_cmd);
 
+static int target_queue_status(struct se_cmd *cmd)
+{
+	int ret;
+	struct se_lun *lun = cmd->se_lun;
+	u8 scsi_status = cmd->scsi_status;
+	u32 flags = cmd->se_cmd_flags;
+
+	ret = cmd->se_tfo->queue_status(cmd);
+	if (!ret)
+		target_stat_count_sent_status(lun, scsi_status, flags);
+
+	return ret;
+}
+
 static void target_handle_abort(struct se_cmd *cmd)
 {
 	bool tas = cmd->transport_state & CMD_T_TAS;
@@ -843,7 +857,7 @@ static void target_handle_abort(struct se_cmd *cmd)
 			pr_debug("Setting SAM_STAT_TASK_ABORTED status for CDB: 0x%02x, ITT: 0x%08llx\n",
 				 cmd->t_task_cdb[0], cmd->tag);
 			trace_target_cmd_complete(cmd);
-			ret = cmd->se_tfo->queue_status(cmd);
+			ret = target_queue_status(cmd);
 			if (ret) {
 				transport_handle_queue_full(cmd, cmd->se_dev,
 							    ret, false);
@@ -2170,7 +2184,7 @@ void transport_generic_request_failure(struct se_cmd *cmd,
 
 queue_status:
 	trace_target_cmd_complete(cmd);
-	ret = cmd->se_tfo->queue_status(cmd);
+	ret = target_queue_status(cmd);
 	if (!ret)
 		goto check_stop;
 queue_full:
@@ -2487,7 +2501,7 @@ static void transport_complete_qf(struct se_cmd *cmd)
 	case DMA_NONE:
 queue_status:
 		trace_target_cmd_complete(cmd);
-		ret = cmd->se_tfo->queue_status(cmd);
+		ret = target_queue_status(cmd);
 		break;
 	default:
 		break;
@@ -2685,7 +2699,7 @@ static void target_complete_ok_work(struct work_struct *work)
 	case DMA_NONE:
 queue_status:
 		trace_target_cmd_complete(cmd);
-		ret = cmd->se_tfo->queue_status(cmd);
+		ret = target_queue_status(cmd);
 		if (ret)
 			goto queue_full;
 		break;
@@ -3599,7 +3613,7 @@ transport_send_check_condition_and_sense(struct se_cmd *cmd,
 		translate_sense_reason(cmd, reason);
 
 	trace_target_cmd_complete(cmd);
-	return cmd->se_tfo->queue_status(cmd);
+	return target_queue_status(cmd);
 }
 EXPORT_SYMBOL(transport_send_check_condition_and_sense);
 
@@ -3615,7 +3629,7 @@ int target_send_busy(struct se_cmd *cmd)
 
 	cmd->scsi_status = SAM_STAT_BUSY;
 	trace_target_cmd_complete(cmd);
-	return cmd->se_tfo->queue_status(cmd);
+	return target_queue_status(cmd);
 }
 EXPORT_SYMBOL(target_send_busy);
 
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 002b0fc57587..61a230331124 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -764,6 +764,7 @@ struct scsi_port_stats {
 	u64			cmd_pdus;
 	u64			tx_data_octets;
 	u64			rx_data_octets;
+	u64			busy_statuses;
 };
 
 struct se_lun {
-- 
2.25.1


