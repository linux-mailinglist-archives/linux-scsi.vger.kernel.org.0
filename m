Return-Path: <linux-scsi+bounces-21539-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBGRO+OBqmkHSwEAu9opvQ
	(envelope-from <linux-scsi+bounces-21539-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 08:27:32 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902021C734
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 08:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E483036D7C
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2026 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE4372EEF;
	Fri,  6 Mar 2026 07:27:02 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C24EEBA
	for <linux-scsi@vger.kernel.org>; Fri,  6 Mar 2026 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782022; cv=none; b=VYh5emwlzjB+mtVeZ8VEmffnyyo9bbRbX57UmsxEOY9Tx2r1iHbgXnVzJhREdmWduqyAOk6CHfHsV/qXKr8kiD3Lf4Dbxj0NoxYUbopDLRlv6rz9a/qBI6dsrTMiS+DGRitPDuk2GU6Tkl4W9lbFGxOcPXLNHpsFtfe5xnltvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782022; c=relaxed/simple;
	bh=MnhUvUy13eqdLJmeYjSBjYBb/PzwL83E++OzGZZ4x50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cD1JM+Zgfa/kczH80KA7GrGbhT5llI386BcjLzJif3jaZjYirmg+oL9LxmjfXes+yH0PTv8nAgLfV0Mfdqt0hUb0P1mM7DqhP9cFqP63NOV+ULaWzuy7Gmcfe6mgsUWX2KfLBhnD8NuYRy2w6vnnt5gPmCIG7GGgCFW5WLbkYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: +nZyBKo8RwOJg0CgfJZJ5g==
X-CSE-MsgGUID: YeUOF3XISGKoVqht6xgX3A==
X-IronPort-AV: E=Sophos;i="6.23,104,1770566400"; 
   d="scan'208";a="142720431"
From: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "James E . J . Bottomley"
	<James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <wanghui33@xiaomi.com>, Wang Shuaiwei
	<wangshuaiwei1@xiaomi.com>
Subject: [PATCH v2] scsi: ufs: core: Fix SError in ufshcd_rtc_work()  during UFS suspend
Date: Fri, 6 Mar 2026 15:26:47 +0800
Message-ID: <20260306072647.2991132-1-wangshuaiwei1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bj-mbx11.mioffice.cn (10.237.8.131) To bj-mbx11.mioffice.cn
 (10.237.8.131)
X-Rspamd-Queue-Id: 7902021C734
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21539-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[wangshuaiwei1@xiaomi.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In continuous suspend/resume cycling, where the interval between 
UFS resume completion and the next suspend is approximately 
UFS_RTC_UPDATE_INTERVAL_MS, a race condition may occur. The kernel
panic trace is as follows:

Kernel panic - not syncing: Asynchronous SError Interrupt
Call trace:
 dump_backtrace+0xec/0x128
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0xa0
 dump_stack+0x18/0x24
 panic+0x148/0x374
 nmi_panic+0x3c/0x8c
 arm64_serror_panic+0x64/0x8c
 do_serror+0xc4/0xc8
 el1h_64_error_handler+0x34/0x4c
 el1h_64_error+0x68/0x6c
 el1_interrupt+0x20/0x58
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x68/0x6c
 ktime_get+0xc4/0x12c
 ufshcd_mcq_sq_stop+0x4c/0xec
 ufshcd_mcq_sq_cleanup+0x64/0x1dc
 ufshcd_clear_cmd+0x38/0x134
 ufshcd_issue_dev_cmd+0x298/0x4d0
 ufshcd_exec_dev_cmd+0x1a4/0x1c4
 ufshcd_query_attr+0xbc/0x19c
 ufshcd_rtc_work+0x10c/0x1c8
 process_scheduled_works+0x1c4/0x45c
 worker_thread+0x32c/0x3e8
 kthread+0x120/0x1d8
 ret_from_fork+0x10/0x20

Root cause: In __ufshcd_wl_suspend(), cancel_delayed_work_sync() is called
to cancel the UFS RTC work, but it is placed after 
ufshcd_vops_suspend(hba, pm_op, POST_CHANGE). This creates a race condition
where ufshcd_rtc_work() can still be running while ufshcd_vops_suspend() 
is executing. When UFSHCD_CAP_CLK_GATING is not supported, the condition 
!hba->clk_gating.active_reqs is always true,causing ufshcd_update_rtc() 
to be executed. Since ufshcd_vops_suspend() typically performs clock 
gating operations, executing ufshcd_update_rtc() at that moment triggers
an SError

Fix this by moving cancel_delayed_work_sync() before the call to
ufshcd_vops_suspend(hba, pm_op, PRE_CHANGE), ensuring the UFS RTC work is
fully completed or cancelled at that point.

Signed-off-by: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>
---

v1->v2:
- Modify commit message and add problem scenario description 

v1: https://lore.kernel.org/linux-scsi/20260226064601.56597-1-wangshuaiwei1@xiaomi.com/

 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 899e663fea6e..9ceb6d6d479d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10066,6 +10066,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	}
 
 	flush_work(&hba->eeh_work);
+	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
 
 	ret = ufshcd_vops_suspend(hba, pm_op, PRE_CHANGE);
 	if (ret)
@@ -10120,7 +10121,6 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (ret)
 		goto set_link_active;
 
-	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
 	goto out;
 
 set_link_active:
-- 
2.43.0


