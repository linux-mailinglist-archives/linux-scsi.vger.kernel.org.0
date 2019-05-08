Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA02B17D62
	for <lists+linux-scsi@lfdr.de>; Wed,  8 May 2019 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEHPgt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 May 2019 11:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfEHPgt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 8 May 2019 11:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D2E13DBF7;
        Wed,  8 May 2019 15:36:48 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFE5662671;
        Wed,  8 May 2019 15:36:47 +0000 (UTC)
Message-ID: <9eccdec2bf0f3662685bd551fa619e0c35f4ee39.camel@redhat.com>
Subject: Re: [PATCH 1/2] qla2xxx: Fix Crash due to NULL pointer access in
 qla2x00_sysfs_read_optrom()
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Date:   Wed, 08 May 2019 11:36:47 -0400
In-Reply-To: <20190506205219.7842-2-hmadhani@marvell.com>
References: <20190506205219.7842-1-hmadhani@marvell.com>
         <20190506205219.7842-2-hmadhani@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 08 May 2019 15:36:48 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

See below.

On Mon, 2019-05-06 at 13:52 -0700, Himanshu Madhani wrote:
> From: Quinn Tran <qutran@marvell.com>
> 
> commit c7702b8c2271 ("scsi: qla2xxx: Get mutex lock before checking
> optrom_state") fixed crash while reading optrom data by adding mutex
> locking. However, there can be still case where previous WRITE for
> optrom buffer failed and then read_optrom() is called with NULL
> optrom_buffer. This patch fixes access to read optrom data if the
> buffers are NULL.
> 
> following stack trace is seen in the log file
> 
> [3130734.630350] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [3130734.630366] IP: [<ffffffff81287526>] memcpy+0x6/0x110
> [3130734.630373] PGD 0
> [3130734.630374] Oops: 0000 [#1] SMP
> [3130734.630375] Modules linked in: iscsi_target_mod target_core_mod configfs ip_vs tcp_diag dccp_diag dccp inet_diag fuse nfsv3 nfs_acl nfsv4 auth_rpcgs>
> [3130734.630401]  hwmon dm_mirror dm_region_hash dm_log dm_mod ipv6 autofs4 [last unloaded: emcpioc]
> [3130734.630404] CPU 9
> [3130734.630407] Pid: 14513, comm: udevadm Tainted: PF          O 3.8.13-118.10.2.el7uek.x86_64 #2 Oracle Corporation SUN SERVER X4-2       /ASSY,MB,X4-2>
> [3130734.630409] RIP: 0010:[<ffffffff81287526>]  [<ffffffff81287526>] memcpy+0x6/0x110
> [3130734.630411] RSP: 0018:ffff88036c7a3e48  EFLAGS: 00010206
> [3130734.630411] RAX: ffff880106b0f000 RBX: 0000000000001000 RCX: 0000000000001000
> [3130734.630412] RDX: 0000000000001000 RSI: 0000000000000000 RDI: ffff880106b0f000
> [3130734.630413] RBP: ffff88036c7a3e68 R08: 0000000000001000 R09: 0000000000000007
> [3130734.630414] R10: 0000000000000004 R11: 0000000000000005 R12: ffff88036c7a3e78
> [3130734.630414] R13: 0000000000001000 R14: ffff881fc96945e0 R15: ffff881fc7e99ba8
> [3130734.630415] FS:  00007f5e245948c0(0000) GS:ffff881fff320000(0000) knlGS:0000000000000000
> [3130734.630416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [3130734.630417] CR2: 0000000000000000 CR3: 0000000106a88000 CR4: 00000000001407e0
> [3130734.630418] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [3130734.630418] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [3130734.630419] Process udevadm (pid: 14513, threadinfo ffff88036c7a2000, task ffff880ee5820500)
> [3130734.630420] Stack:
> [3130734.630421]  ffffffff811ad38c ffff881fc9694000 ffff880106b0f000 0000000000001000
> [3130734.630424]  ffff88036c7a3ea0 ffffffffa02dea5c 0000000000000000 ffff881014fd9540
> [3130734.630427]  ffff881010863dc0 ffff88036c7a3f50 0000000000001000 ffff88036c7a3f08
> [3130734.630429] Call Trace:
> [3130734.630435]  [<ffffffff811ad38c>] ? memory_read_from_buffer+0x3c/0x60
> [3130734.630445]  [<ffffffffa02dea5c>] qla2x00_sysfs_read_optrom+0x9c/0xc0 [qla2xxx]
> [3130734.630449]  [<ffffffff811fe96f>] read+0xdf/0x1f0
> [3130734.630454]  [<ffffffff81187ff3>] vfs_read+0xa3/0x180
> [3130734.630455]  [<ffffffff81188299>] sys_read+0x49/0xa0
> [3130734.630461]  [<ffffffff810df3b6>] ? __audit_syscall_exit+0x1f6/0x2a0
> [3130734.630467]  [<ffffffff815874f9>] system_call_fastpath+0x16/0x1b
> [3130734.630467] Code: 43 58 48 2b 43 50 88 43 4e 5b 5d c3 66 0f 1f 84 00 00 00 00 00 e8 fb fb ff ff eb e2 90 90 90 90 90 90 90 90 90 48 89 f8 48 89 d1 <>
> [3130734.630485] RIP  [<ffffffff81287526>] memcpy+0x6/0x110
> [3130734.630486]  RSP <ffff88036c7a3e48>
> [3130734.630487] CR2: 0000000000000000
> 
> Fixes: c7702b8c2271 ("scsi: qla2xxx: Get mutex lock before checking optrom_state")
> Cc: stable@vger.kernel.org # 4.10
> Signed-off-by: Quinn Tran <qutran@marvell.com>
> Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> ---
>  drivers/scsi/qla2xxx/qla_attr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
> index 8d560c562e9c..0341f3340edb 100644
> --- a/drivers/scsi/qla2xxx/qla_attr.c
> +++ b/drivers/scsi/qla2xxx/qla_attr.c
> @@ -275,7 +275,8 @@ qla2x00_sysfs_read_optrom(struct file *filp, struct kobject *kobj,
>  
>  	mutex_lock(&ha->optrom_mutex);
>  
> -	if (ha->optrom_state != QLA_SREADING)
> +	if ((ha->optrom_state != QLA_SREADING) ||
> +	    !buf || !ha->optrom_buffer)
>  		goto out;
>  

In this case it appears as if no error is returned, since rval is always 0?
Presumably this is the intentional behavior if it's not in the SREADING state?

Why is the test for !buf necessary, since such a check is mostly not done here
except for qlini_mode_store().  Is that the actual null pointer encountered?
I don't see how ha->optrom_buffer would ever be NULL in the QLA_SREADING state.
How does an optrom write failure result in this?  

-Ewan

>  	rval = memory_read_from_buffer(buf, count, &off, ha->optrom_buffer,
