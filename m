Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC72D3E72
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Dec 2020 10:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgLIJUm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Dec 2020 04:20:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9406 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgLIJUj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Dec 2020 04:20:39 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CrWhX0b80z7BM4;
        Wed,  9 Dec 2020 17:19:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Dec 2020
 17:19:48 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <linux-scsi@vger.kernel.org>, <open-iscsi@googlegroups.com>
CC:     <lduncan@suse.com>, <cleech@redhat.com>, <lutianxiong@huawei.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        <wubo40@huawei.com>, <haowenchao@huawei.com>
Subject: [bug report] scsi:iscsi:NULL pointer dereference in iscsi_eh_cmd_timed_out function
Date:   Wed, 9 Dec 2020 17:40:47 +0800
Message-ID: <1607506847-291724-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

When testing kernel 4.18 version, NULL pointer dereference problem occurs
in iscsi_eh_cmd_timed_out function.

I think this bug in the upstream is still exists.

In iscsi_eh_cmd_timed_out(), iscsi_task is protected by session->frwd_lock.
But in following four functions which calling iscsi_free_task(),
sc->SCP.ptr(equal to iscsi_task) is not protected by session->frwd_lock.
So contention window exists between iscsi_eh_cmd_timed_out() 
and iscsi_free_task(), which causes the NULL pointer dereference problem.

  iscsi_complete_task(struct iscsi_task *task, int state)
    -> __iscsi_put_task(task);
	-> iscsi_free_task(task);
	{
		if (sc) {
			/* SCSI eh reuses commands to verify us */
			sc->SCp.ptr = NULL;
			...
		 }
	}

No frwd_lock lock protection before calling iscsi_complete_task:

  1). iscsi_scsi_cmd_rsp
     	-> iscsi_complete_task(task, ISCSI_TASK_COMPLETED);

  2). iscsi_data_in_rsp
        -> iscsi_complete_task(task, ISCSI_TASK_COMPLETED);

  3). iscsi_nop_out_rsp
        -> iscsi_complete_task(task, ISCSI_TASK_COMPLETED);

  4). __iscsi_complete_pdu
	-> iscsi_complete_task(task, ISCSI_TASK_COMPLETED);

Calltrace:
[380751.840862] BUG: unable to handle kernel NULL pointer dereference at 0000000000000138
[380751.843709] PGD 0 P4D 0
[380751.844770] Oops: 0000 [#1] SMP PTI
[380751.846283] CPU: 0 PID: 403 Comm: kworker/0:1H Kdump: loaded Tainted: G
[380751.851467] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
[380751.856521] Workqueue: kblockd blk_mq_timeout_work
[380751.858527] RIP: 0010:iscsi_eh_cmd_timed_out+0x15e/0x2e0 [libiscsi]
[380751.861129] Code: 83 ea 01 48 8d 74 d0 08 48 8b 10 48 8b 4a 50 48 85 c9 74 2c 48 39 d5 74
[380751.868811] RSP: 0018:ffffc1e280a5fd58 EFLAGS: 00010246
[380751.870978] RAX: ffff9fd1e84e15e0 RBX: ffff9fd1e84e6dd0 RCX: 0000000116acc580
[380751.873791] RDX: ffff9fd1f97a9400 RSI: ffff9fd1e84e1800 RDI: ffff9fd1e4d6d420
[380751.876059] RBP: ffff9fd1e4d49000 R08: 0000000116acc580 R09: 0000000116acc580
[380751.878284] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9fd1e6e931e8
[380751.880500] R13: ffff9fd1e84e6ee0 R14: 0000000000000010 R15: 0000000000000003
[380751.882687] FS:  0000000000000000(0000) GS:ffff9fd1fac00000(0000) knlGS:0000000000000000
[380751.885236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[380751.887059] CR2: 0000000000000138 CR3: 000000011860a001 CR4: 00000000003606f0
[380751.889308] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[380751.891523] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[380751.893738] Call Trace:
[380751.894639]  scsi_times_out+0x60/0x1c0
[380751.895861]  blk_mq_check_expired+0x144/0x200
[380751.897302]  ? __switch_to_asm+0x35/0x70
[380751.898551]  blk_mq_queue_tag_busy_iter+0x195/0x2e0
[380751.900091]  ? __blk_mq_requeue_request+0x100/0x100
[380751.901611]  ? __switch_to_asm+0x41/0x70
[380751.902853]  ? __blk_mq_requeue_request+0x100/0x100
[380751.904398]  blk_mq_timeout_work+0x54/0x130
[380751.905740]  process_one_work+0x195/0x390
[380751.907228]  worker_thread+0x30/0x390
[380751.908713]  ? process_one_work+0x390/0x390
[380751.910350]  kthread+0x10d/0x130
[380751.911470]  ? kthread_flush_work_fn+0x10/0x10
[380751.913007]  ret_from_fork+0x35/0x40

crash> dis -l iscsi_eh_cmd_timed_out+0x15e
xxxxx/drivers/scsi/libiscsi.c: 2062

1970 enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
{
...
1984         spin_lock_bh(&session->frwd_lock);
1985         task = (struct iscsi_task *)sc->SCp.ptr;
1986         if (!task) {    
1987                 /*
1988                  * Raced with completion. Blk layer has taken ownership
1989                  * so let timeout code complete it now.
1990                  */     
1991                 rc = BLK_EH_DONE;
1992                 goto done;
1993         }

...

2052         for (i = 0; i < conn->session->cmds_max; i++) {
2053                 running_task = conn->session->cmds[i];
2054                 if (!running_task->sc || running_task == task ||
2055                      running_task->state != ISCSI_TASK_RUNNING)
2056                         continue;
2057
2058                 /*
2059                  * Only check if cmds started before this one have made
2060                  * progress, or this could never fail
2061                  */
2062                 if (time_after(running_task->sc->jiffies_at_alloc,  <---
2063                                task->sc->jiffies_at_alloc))
2064                         continue;
2065
...
}

carsh> struct scsi_cmnd ffff9fd1e6e931e8
struct scsi_cmnd {
  ...
  SCp = {
    ptr = 0x0,   <--- iscsi_task
    this_residual = 0,
    ...
  },
}

