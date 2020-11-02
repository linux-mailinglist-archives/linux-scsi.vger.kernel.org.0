Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343AE2A2DF8
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgKBPTI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 10:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgKBPTG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 10:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604330344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvbrY2I55xkY2YSa9P0xoipZGviKjz7sESXGUBs+2p8=;
        b=XJ9CstI75BfV9NpOwxC8iOhG/cVy2jgUmZ95ie4jilFzLLbKfB8ZWGd30/2enlS7paSbB6
        2ZJi989KWtfumPXuDsTb6qnWHP4F3kQoZijHnkuA805k+2tdvdW+EwVyfrKe/XFy07FE7j
        nbNC5FQy2wxFaNQ1pFV+pSWy/mncQIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-t3mUCsi4Pvy3oaSaZG1aqg-1; Mon, 02 Nov 2020 10:18:59 -0500
X-MC-Unique: t3mUCsi4Pvy3oaSaZG1aqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B0E59;
        Mon,  2 Nov 2020 15:18:56 +0000 (UTC)
Received: from ovpn-112-12.rdu2.redhat.com (ovpn-112-12.rdu2.redhat.com [10.10.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4D495D98A;
        Mon,  2 Nov 2020 15:18:53 +0000 (UTC)
Message-ID: <193a0440eed447209c48bda042f0e4db102355e7.camel@redhat.com>
Subject: Re: [PATCH v8 17/18] scsi: megaraid_sas: Added support for shared
 host tagset for cpuhotplug
From:   Qian Cai <cai@redhat.com>
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, kashyap.desai@broadcom.com,
        ming.lei@redhat.com, bvanassche@acm.org, dgilbert@interlog.com,
        paolo.valente@linaro.org, hare@suse.de, hch@lst.de
Cc:     sumit.saxena@broadcom.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, megaraidlinux.pdl@broadcom.com,
        chenxiang66@hisilicon.com, luojiaxing@huawei.com,
        Hannes Reinecke <hare@suse.com>
Date:   Mon, 02 Nov 2020 10:18:51 -0500
In-Reply-To: <385d5408-6ba2-6bb6-52d3-b59c9aa9c5e5@huawei.com>
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
         <1597850436-116171-18-git-send-email-john.garry@huawei.com>
         <fe3dff7dae4494e5a88caffbb4d877bbf472dceb.camel@redhat.com>
         <385d5408-6ba2-6bb6-52d3-b59c9aa9c5e5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2020-11-02 at 14:51 +0000, John Garry wrote:
> On 02/11/2020 14:17, Qian Cai wrote:
> > [  251.961152][  T330] INFO: task systemd-udevd:567 blocked for more than
> > 122 seconds.
> > [  251.968876][  T330]       Not tainted 5.10.0-rc1-next-20201102 #1
> > [  251.975003][  T330] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  251.983546][  T330] task:systemd-udevd   state:D stack:27224 pid:  567
> > ppid:   506 flags:0x00004324
> > [  251.992620][  T330] Call Trace:
> > [  251.995784][  T330]  __schedule+0x71d/0x1b60
> > [  252.000067][  T330]  ? __sched_text_start+0x8/0x8
> > [  252.004798][  T330]  schedule+0xbf/0x270
> > [  252.008735][  T330]  schedule_timeout+0x3fc/0x590
> > [  252.013464][  T330]  ? usleep_range+0x120/0x120
> > [  252.018008][  T330]  ? wait_for_completion+0x156/0x250
> > [  252.023176][  T330]  ? lock_downgrade+0x700/0x700
> > [  252.027886][  T330]  ? rcu_read_unlock+0x40/0x40
> > [  252.032530][  T330]  ? do_raw_spin_lock+0x121/0x290
> > [  252.037412][  T330]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
> > [  252.043268][  T330]  ? _raw_spin_unlock_irq+0x1f/0x30
> > [  252.048331][  T330]  wait_for_completion+0x15e/0x250
> > [  252.053323][  T330]  ? wait_for_completion_interruptible+0x320/0x320
> > [  252.059687][  T330]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
> > [  252.065543][  T330]  ? _raw_spin_unlock_irq+0x1f/0x30
> > [  252.070606][  T330]  __flush_work+0x42a/0x900
> > [  252.074989][  T330]  ? queue_delayed_work_on+0x90/0x90
> > [  252.080139][  T330]  ? __queue_work+0x463/0xf40
> > [  252.084700][  T330]  ? init_pwq+0x320/0x320
> > [  252.088891][  T330]  ? queue_work_on+0x5e/0x80
> > [  252.093364][  T330]  ? trace_hardirqs_on+0x1c/0x150
> > [  252.098255][  T330]  work_on_cpu+0xe7/0x130
> > [  252.102461][  T330]  ? flush_delayed_work+0xc0/0xc0
> > [  252.107342][  T330]  ? __mutex_unlock_slowpath+0xd4/0x670
> > [  252.112764][  T330]  ? work_debug_hint+0x30/0x30
> > [  252.117391][  T330]  ? pci_device_shutdown+0x80/0x80
> > [  252.122378][  T330]  ? cpumask_next_and+0x57/0x80
> > [  252.127094][  T330]  pci_device_probe+0x500/0x5c0
> > [  252.131824][  T330]  ? pci_device_remove+0x1f0/0x1f0
> 
> Is CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled? I figure it is, with this call.
> 
> Or please share the .config

No. https://cailca.coding.net/public/linux/mm/git/files/master/x86.config

> 
> Cheers,
> John
> 
> > [  252.136805][  T330]  really_probe+0x207/0xad0
> > [  252.141191][  T330]  ? device_driver_attach+0x120/0x120
> > [  252.146428][  T330]  driver_probe_device+0x1f1/0x370
> > [  252.151424][  T330]  device_driver_attach+0xe5/0x120
> > [  252.156399][  T330]  __driver_attach+0xf0/0x260
> > [  252.160953][  T330]  bus_for_each_dev+0x117/0x1a0
> > [  252.165669][  T330]  ? subsys_dev_iter_exit+0x10/0x10
> > [  252.170731][  T330]  bus_add_driver+0x399/0x560
> > [  252.175289][  T330]  driver_register+0x189/0x310
> > [  252.179919][  T330]  ? 0xffffffffc05c1000
> > [  252.183960][  T330]  megasas_init+0x117/0x1000 [megaraid_sas]
> > [  252.189713][  T330]  do_one_initcall+0xf6/0x510
> > [  252.194267][  T330]  ? perf_trace_initcall_level+0x490/0x490
> > [  252.199940][  T330]  ? kasan_unpoison_shadow+0x30/0x40
> > [  252.205104][  T330]  ? __kasan_kmalloc.constprop.11+0xc1/0xd0
> > [  252.210859][  T330]  ? do_init_module+0x49/0x6c0
> > [  252.215500][  T330]  ? kmem_cache_alloc_trace+0x11f/0x1e0
> > [  252.220925][  T330]  ? kasan_unpoison_shadow+0x30/0x40
> > [  252.226068][  T330]  do_init_module+0x1ed/0x6c0
> > [  252.230608][  T330]  load_module+0x4a59/0x5d20
> > [  252.235081][  T330]  ? layout_and_allocate+0x2770/0x2770
> > [  252.240404][  T330]  ? __vmalloc_node+0x8d/0x100
> > [  252.245046][  T330]  ? kernel_read_file+0x485/0x5a0
> > [  252.249934][  T330]  ? kernel_read_file+0x305/0x5a0
> > [  252.254839][  T330]  ? __x64_sys_fsconfig+0x970/0x970
> > [  252.259903][  T330]  ? __do_sys_finit_module+0xff/0x180
> > [  252.265153][  T330]  __do_sys_finit_module+0xff/0x180
> > [  252.270216][  T330]  ? __do_sys_init_module+0x1d0/0x1d0
> > [  252.275465][  T330]  ? __fget_files+0x1c3/0x2e0
> > [  252.280010][  T330]  do_syscall_64+0x33/0x40
> > [  252.284304][  T330]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  252.290054][  T330] RIP: 0033:0x7fbb3e2fa78d
> > [  252.294348][  T330] Code: Unable to access opcode bytes at RIP
> > 0x7fbb3e2fa763.
> > [  252.301584][  T330] RSP: 002b:00007ffe572e8d18 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000139
> > [  252.309855][  T330] RAX: ffffffffffffffda RBX: 000055c7795d90f0 RCX:
> > 00007fbb3e2fa78d
> > [  252.317703][  T330] RDX: 0000000000000000 RSI: 00007fbb3ee6c82d RDI:
> > 0000000000000006
> > [  252.325553][  T330] RBP: 00007fbb3ee6c82d R08: 0000000000000000 R09:
> > 00007ffe572e8e40
> > [  252.333402][  T330] R10: 0000000000000006 R11: 0000000000000246 R12:
> > 0000000000000000
> > [  252.341257][  T330] R13: 000055c7795930e0 R14: 0000000000020000 R15:
> > 0000000000000000
> > [  252.349117][  T330]

