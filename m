Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEFB34905
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfFDNiw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 09:38:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39775 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfFDNiw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 09:38:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so10392250pgc.6
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXTTcTVaSKQEzyig1UPU+xb7uEfx/jVSA7Lye04WJEY=;
        b=BOJy3dORCx8UIc1xNhl3atOMoS1GSfmcFWyRnG9sAPak8EmnSai8W6ryXKIse+a9kG
         OIk0nN9tZHxg0voO+Jq0LGxuCL8bXqMzKp8BTIk2ll00W7wLt3NkuTNO+pQH+rZX01xf
         hihHyVLLqX3gjmh4PEIGH2Qmrj7nHGBxphuhxlPOyVgUk9p/gNZbcixsLU4qIwjcKvSh
         FgGdeVJwU405cd21mHfnFGpU9nhj1fyHbULvFg0gPyT4ndOGiIMsYk6PvicO+K8cjvWK
         y2/3/k/FC+xJw8ICeDh1G1QRoPRvZBJotBsH8SxC5jGd5dTbOeZwHelV37z7SWGMJ/XT
         OtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXTTcTVaSKQEzyig1UPU+xb7uEfx/jVSA7Lye04WJEY=;
        b=ooRp8yc/mUPW3hIr6Ji2JMtpksSzpi+0ooJIKYK1u7mW5Z3pMUX5aIpHes6tvm3dT0
         gcnXlDJ8+cwzre1NDW79n+7vAC/9x+TrYN6m0rYDWVuSa5snDiS7j75KWg3auXDG929u
         TlbPAnU4SmpnT0jyE9P1lqqHXvy1gjn5VBQdF1tLwpY22Fe0BZQf1HvR78LUj6QnaHDM
         G8W7riWb0A1jGoN/CHrBDisDmQdNffqktnT9yYL0OqTCJyx07hPi61cWp6iS7WfJM3TX
         +q/w4VXSS8nOlpT3WKO/xvk9GrDzSkajLKdAEtJJ++bMu55Rre3acNiePCo+j5JCePW9
         Xaug==
X-Gm-Message-State: APjAAAWzbUCfej0fCJl99kw5Z43XTPHOXcDlpI1Pb8v/hZiVHX0cdHtV
        276xHbgAoFvy6GYNIkm5Wxk=
X-Google-Smtp-Source: APXvYqyIZ11xPAsjKVezfFRIQp64QBw1cnZcxJ+0hT/Ss0re5/UdJjHjvqDvEjCzP4DHqCErjNrx9Q==
X-Received: by 2002:a17:90a:d3d2:: with SMTP id d18mr1873349pjw.5.1559655531695;
        Tue, 04 Jun 2019 06:38:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7sm18621727pfm.82.2019.06.04.06.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:38:50 -0700 (PDT)
Date:   Tue, 4 Jun 2019 06:38:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 0/2] scsi: two SG_CHAIN related fixes
Message-ID: <20190604133849.GA1880@roeck-us.net>
References: <20190604082308.5575-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604082308.5575-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 04, 2019 at 04:23:06PM +0800, Ming Lei wrote:
> Hi,
> 
> Guenter reported scsi boot issue caused by commit c3288dd8c232
> ("scsi: core: avoid pre-allocating big SGL for data").
> 
> Turns out there are at least two issues.
> 
> The 1st patch fixes issue in case that NO_SG_CHAIN on some ARCHs,
> such as alpha, arm and parisc.
> 
> The 2nd patch makes esp scsi working with SG_CHAIN.
> 

Both patches applied on top of next-20190604.

Results on alpha:

Waiting for root device /dev/sda...
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7 at mm/slab.h:359 kmem_cache_free+0x120/0x2a0
virt_to_cache: Object is not a Slab page!
Modules linked in:
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 5.2.0-rc3-next-20190604-00002-gab1fef861ee2 #1
       fffffc000787fb38 fffffc0007d12658 fffffc0000333d50 fffffc00004205b0
       fffffc0000333dd8 fffffc0007eb82a8 fffffc00003c3234 fffffc0000eedb20
       0000000000000080 0000000000000001 0000000000000167 fffffc00004205b0
       fffffc00004205b0 fffffc0007d908f8 fffffc0000cbe231 fffffc000787fbf8
       0000000000000018 0000000000000000 fffffc00006d8e38 fffffc0007d908f8
       0000000000000000 fffffc0000b8d610 0000000000000001 000000000000005a
Trace:
[<fffffc0000333d50>] __warn+0x160/0x190
[<fffffc00004205b0>] kmem_cache_free+0x120/0x2a0
[<fffffc0000333dd8>] warn_slowpath_fmt+0x58/0x70
[<fffffc00003c3234>] mempool_free_slab+0x24/0x40
[<fffffc00004205b0>] kmem_cache_free+0x120/0x2a0
[<fffffc00004205b0>] kmem_cache_free+0x120/0x2a0
[<fffffc00006d8e38>] bio_free+0x98/0xc0
[<fffffc00003c3234>] mempool_free_slab+0x24/0x40
[<fffffc00003c3158>] mempool_free+0x48/0x100
[<fffffc00007a459c>] sg_pool_free+0x9c/0xd0
[<fffffc00007a4500>] sg_pool_free+0x0/0xd0
[<fffffc000070d350>] __sg_free_table+0xb0/0xf0
[<fffffc00007a44e8>] sg_free_table_chained+0x48/0x60
[<fffffc0000889130>] scsi_mq_uninit_cmd+0xc0/0xd0
[<fffffc00008891d4>] scsi_end_request+0x94/0x270
[<fffffc0000889550>] scsi_io_completion+0xd0/0x740
[<fffffc000087f274>] scsi_finish_command+0x104/0x160
[<fffffc000087f1b0>] scsi_finish_command+0x40/0x160
[<fffffc0000888d4c>] scsi_softirq_done+0x18c/0x1c0
[<fffffc00006e9a2c>] blk_done_softirq+0xbc/0xf0
[<fffffc0000338008>] run_ksoftirqd+0x48/0x80
[<fffffc000035f654>] smpboot_thread_fn+0x184/0x230
[<fffffc000035afb8>] kthread+0x168/0x1d0
[<fffffc000035f4d0>] smpboot_thread_fn+0x0/0x230
[<fffffc00003119e8>] ret_from_kernel_thread+0x18/0x20
[<fffffc000035ae50>] kthread+0x0/0x1d0

---[ end trace 1fadf5f1c983cdae ]---
scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
sd 0:0:0:0: Power-on or device reset occurred
sd 0:0:0:0: [sda] 20480 512-byte logical blocks: (10.5 MB/10.0 MiB)
random: crng init done
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] Attached SCSI disk
EXT4-fs (sda): mounted filesystem without journal. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
Unable to handle kernel paging request at virtual address 0000000000000000
kworker/0:1H(45): Oops 1
pc = [<fffffc0000b7f760>]  ra = [<fffffc000088a41c>]  ps = 0000    Tainted: G        W        
pc is at loop+0x0/0x10
ra is at scsi_queue_rq+0x6fc/0xaa0
v0 = 0000000000000000  t0 = 0000000000000060  t1 = 0000000000000004
t2 = 000000000000000c  t3 = 0000980100000028  t4 = 0000000000000000
t5 = 0000000000000060  t6 = fffffc0007eb83d4  t7 = fffffc0007ed0000
s0 = 0000000000000000  s1 = fffffc0007eb82c0  s2 = fffffc0007d72998
s3 = fffffc0007dd2b28  s4 = fffffc0007eb83d0  s5 = fffffc000782a328
s6 = fffffc000782a328
a0 = 0000000000000000  a1 = 0000000000000000  a2 = 0000000000000000
a3 = 0000000000000000  a4 = 0000000000000000  a5 = fffffc0007edbeb0
t8 = fffffc0007eb83d3  t9 = 0000000000000002  t10= fffffc0007d12068
t11= 0000000000000000  pv = fffffc0000b7f6e0  at = 0000000000000000
gp = fffffc0000ee88d8  sp = 00000000f0901f3d
Disabling lock debugging due to kernel taint
Trace:
[<fffffc00006eef94>] blk_mq_dispatch_rq_list+0x454/0x810
[<fffffc00006eef1c>] blk_mq_dispatch_rq_list+0x3dc/0x810
[<fffffc00006f5f94>] blk_mq_do_dispatch_sched+0xc4/0x170
[<fffffc00006f5f30>] blk_mq_do_dispatch_sched+0x60/0x170
[<fffffc00006f5f60>] blk_mq_do_dispatch_sched+0x90/0x170
[<fffffc00006f6a20>] blk_mq_sched_dispatch_requests+0x140/0x220
[<fffffc00006ed2bc>] __blk_mq_run_hw_queue+0x6c/0x250
[<fffffc0000350a90>] process_one_work+0x1f0/0x520
[<fffffc0000351310>] worker_thread+0x60/0x750
[<fffffc000035afb8>] kthread+0x168/0x1d0
[<fffffc00003512b0>] worker_thread+0x0/0x750
[<fffffc00003119e8>] ret_from_kernel_thread+0x18/0x20
[<fffffc000035ae50>] kthread+0x0/0x1d0

On the plus side, boot tests test are passing with m68k and sparc,
so "scsi: esp: make it working on SG_CHAIN" seems to work.

Guenter
