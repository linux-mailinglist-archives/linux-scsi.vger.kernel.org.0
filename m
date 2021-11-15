Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63D84524EF
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Nov 2021 02:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357651AbhKPBqM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 15 Nov 2021 20:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241376AbhKOSTj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 15 Nov 2021 13:19:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D6336325E;
        Mon, 15 Nov 2021 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636998720;
        bh=qBcTJ8oKwE8dUFEIHV/xvco0dzhXm5haIzim0tJRVHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHAZMeEbT7YR7T+B8+36w9bk9MjB4yfuMwquRFnq0xt8O84l1R0GI7ycOhmJHKh8a
         2E7OzQcV9SM5lCODAcdyg1BJWcUJoKotuhhquxnpO/Zb8dLEhqmzV6beSV1yAFdI9s
         kiyCzF4l4wPpso1RCslCzxNYUft0fMj/dCsya6/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+5516b30f5401d4dcbcae@syzkaller.appspotmail.com,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH 5.14 009/849] scsi: core: Remove command size deduction from scsi_setup_scsi_cmnd()
Date:   Mon, 15 Nov 2021 17:51:32 +0100
Message-Id: <20211115165420.306521416@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165419.961798833@linuxfoundation.org>
References: <20211115165419.961798833@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tadeusz Struk <tadeusz.struk@linaro.org>

commit 703535e6ae1e94c89a9c1396b4c7b6b41160ef0c upstream.

No need to deduce command size in scsi_setup_scsi_cmnd() anymore as
appropriate checks have been added to scsi_fill_sghdr_rq() function and the
cmd_len should never be zero here.  The code to do that wasn't correct
anyway, as it used uninitialized cmd->cmnd, which caused a null-ptr-deref
if the command size was zero as in the trace below. Fix this by removing
the unneeded code.

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 1822 Comm: repro Not tainted 5.15.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
Call Trace:
 blk_mq_dispatch_rq_list+0x7c7/0x12d0
 __blk_mq_sched_dispatch_requests+0x244/0x380
 blk_mq_sched_dispatch_requests+0xf0/0x160
 __blk_mq_run_hw_queue+0xe8/0x160
 __blk_mq_delay_run_hw_queue+0x252/0x5d0
 blk_mq_run_hw_queue+0x1dd/0x3b0
 blk_mq_sched_insert_request+0x1ff/0x3e0
 blk_execute_rq_nowait+0x173/0x1e0
 blk_execute_rq+0x15c/0x540
 sg_io+0x97c/0x1370
 scsi_ioctl+0xe16/0x28e0
 sd_ioctl+0x134/0x170
 blkdev_ioctl+0x362/0x6e0
 block_ioctl+0xb0/0xf0
 vfs_ioctl+0xa7/0xf0
 do_syscall_64+0x3d/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
---[ end trace 8b086e334adef6d2 ]---
Kernel panic - not syncing: Fatal exception

Link: https://lore.kernel.org/r/20211103170659.22151-2-tadeusz.struk@linaro.org
Fixes: 2ceda20f0a99 ("scsi: core: Move command size detection out of the fast path")
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: <linux-scsi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <stable@vger.kernel.org> # 5.15, 5.14, 5.10
Reported-by: syzbot+5516b30f5401d4dcbcae@syzkaller.appspotmail.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_lib.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1168,8 +1168,6 @@ static blk_status_t scsi_setup_scsi_cmnd
 	}
 
 	cmd->cmd_len = scsi_req(req)->cmd_len;
-	if (cmd->cmd_len == 0)
-		cmd->cmd_len = scsi_command_size(cmd->cmnd);
 	cmd->cmnd = scsi_req(req)->cmd;
 	cmd->transfersize = blk_rq_bytes(req);
 	cmd->allowed = scsi_req(req)->retries;


