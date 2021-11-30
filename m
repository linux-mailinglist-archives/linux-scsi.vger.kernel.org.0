Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851C746381D
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Nov 2021 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbhK3O6Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Nov 2021 09:58:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59378 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbhK3Ozk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Nov 2021 09:55:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2FDBCE1A65;
        Tue, 30 Nov 2021 14:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C9AC8D184;
        Tue, 30 Nov 2021 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283938;
        bh=/RRgJJcRnK5MhUnsOLjgKCGRQxup3pwTkTT4yhfdWnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPF7uRTFiyUpymODf/+3ocW9U1HqfWvecHgGPMkM+/rl+PxSZTCP6J0W4cqP4HLvR
         I9ks36R4TYXiD2aZzc5oBxUF5tRirjQxKYDSiF3Ggx2sPhGpRaXe6tXSkW2cN+WZVD
         TUviOWGQLGujM0y5Wqlw7MXFpQnyQUZ3fxd9dYTXuWydleBU7bk2NTR1JRLbW5+V4Y
         pKAjXDmcoMcUt+SjiM+OSjL5fvGSmuWHao2Ufnu2TmaP93NHPN3+ZrB0gJpwwg/79I
         3XVpNJHNAp2lFw6WxWzxn+khzZdYk31StrI9IeA2E3kXgQJcTRYMj6EpNkGmp9AYLQ
         uTt7x0w2saODA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     George Kennedy <george.kennedy@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/25] scsi: scsi_debug: Sanity check block descriptor length in resp_mode_select()
Date:   Tue, 30 Nov 2021 09:51:40 -0500
Message-Id: <20211130145156.946083-10-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145156.946083-1-sashal@kernel.org>
References: <20211130145156.946083-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

[ Upstream commit e0a2c28da11e2c2b963fc01d50acbf03045ac732 ]

In resp_mode_select() sanity check the block descriptor len to avoid UAF.

BUG: KASAN: use-after-free in resp_mode_select+0xa4c/0xb40 drivers/scsi/scsi_debug.c:2509
Read of size 1 at addr ffff888026670f50 by task scsicmd/15032

CPU: 1 PID: 15032 Comm: scsicmd Not tainted 5.15.0-01d0625 #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Call Trace:
 <TASK>
 dump_stack_lvl+0x89/0xb5 lib/dump_stack.c:107
 print_address_description.constprop.9+0x28/0x160 mm/kasan/report.c:257
 kasan_report.cold.14+0x7d/0x117 mm/kasan/report.c:443
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/report_generic.c:306
 resp_mode_select+0xa4c/0xb40 drivers/scsi/scsi_debug.c:2509
 schedule_resp+0x4af/0x1a10 drivers/scsi/scsi_debug.c:5483
 scsi_debug_queuecommand+0x8c9/0x1e70 drivers/scsi/scsi_debug.c:7537
 scsi_queue_rq+0x16b4/0x2d10 drivers/scsi/scsi_lib.c:1521
 blk_mq_dispatch_rq_list+0xb9b/0x2700 block/blk-mq.c:1640
 __blk_mq_sched_dispatch_requests+0x28f/0x590 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x105/0x190 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0xe5/0x150 block/blk-mq.c:1762
 __blk_mq_delay_run_hw_queue+0x4f8/0x5c0 block/blk-mq.c:1839
 blk_mq_run_hw_queue+0x18d/0x350 block/blk-mq.c:1891
 blk_mq_sched_insert_request+0x3db/0x4e0 block/blk-mq-sched.c:474
 blk_execute_rq_nowait+0x16b/0x1c0 block/blk-exec.c:63
 sg_common_write.isra.18+0xeb3/0x2000 drivers/scsi/sg.c:837
 sg_new_write.isra.19+0x570/0x8c0 drivers/scsi/sg.c:775
 sg_ioctl_common+0x14d6/0x2710 drivers/scsi/sg.c:941
 sg_ioctl+0xa2/0x180 drivers/scsi/sg.c:1166
 __x64_sys_ioctl+0x19d/0x220 fs/ioctl.c:52
 do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:50
 entry_SYSCALL_64_after_hwframe+0x44/0xae arch/x86/entry/entry_64.S:113

Link: https://lore.kernel.org/r/1637262208-28850-1-git-send-email-george.kennedy@oracle.com
Reported-by: syzkaller <syzkaller@googlegroups.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 44181a2cbf18d..408166bd20f33 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2296,11 +2296,11 @@ static int resp_mode_select(struct scsi_cmnd *scp,
 			    __func__, param_len, res);
 	md_len = mselect6 ? (arr[0] + 1) : (get_unaligned_be16(arr + 0) + 2);
 	bd_len = mselect6 ? arr[3] : get_unaligned_be16(arr + 6);
-	if (md_len > 2) {
+	off = bd_len + (mselect6 ? 4 : 8);
+	if (md_len > 2 || off >= res) {
 		mk_sense_invalid_fld(scp, SDEB_IN_DATA, 0, -1);
 		return check_condition_result;
 	}
-	off = bd_len + (mselect6 ? 4 : 8);
 	mpage = arr[off] & 0x3f;
 	ps = !!(arr[off] & 0x80);
 	if (ps) {
-- 
2.33.0

