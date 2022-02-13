Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978014B39CB
	for <lists+linux-scsi@lfdr.de>; Sun, 13 Feb 2022 07:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiBMGBg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Feb 2022 01:01:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiBMGBf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 13 Feb 2022 01:01:35 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA8F5E778
        for <linux-scsi@vger.kernel.org>; Sat, 12 Feb 2022 22:01:30 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id p15-20020a056e02104f00b002be1c3c16f2so8922653ilj.23
        for <linux-scsi@vger.kernel.org>; Sat, 12 Feb 2022 22:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gdJ+UkM0mS6Igr5cs53GndzuH98uTBFN5/z+YadgrUM=;
        b=BZ4ItSh5v0wo3F9F0YP1OSrt02a8wPN726WX+ZUDGL96x9bwwbQU31MUxMtah9RxyS
         /fFZfz4c/SeLfNlGN3Da6UqbF72gUR8/0ty4dw8IZ1tN8LVuVFcYfGmNtLn0nFAIURdO
         fWX5xcPLWRGY1Vj8Pgv+J6ZZajbjvOzBPNuHac48TPCgkTYRSCKMJ9+MYvjQRyNnr117
         yi5JFFAMFlLiJVg2SeylXg/e1Hm3yxP6G8r6VJIeqpQDBTvFHSgpqq4g4NSHPsw1bjWQ
         BaZ39XDsxwIoqCiaVDWrOmP3lAwC5YscXSc2wa0ILFzc1rIZrlsI8mP/O4TsKbzIWSFq
         O1TA==
X-Gm-Message-State: AOAM530x1ZKmgbkzv12pgRSRDNiwYH7ocXmbX7agf4s9up8K4tqLHkVN
        JvtkBaR1NLAQ39OsI333ZthCVbMnIYFD0NPCn9gIi7hBP54D
X-Google-Smtp-Source: ABdhPJwxx6Lh05kLoeWh/aE/tMJgFoEYgOAwi283VF7pCizVdNvlAZCtUZ4bEOv2aBgWSDg7R7v5+OmooQdvVx0sVwjcAGomCJAx
MIME-Version: 1.0
X-Received: by 2002:a92:c8c7:: with SMTP id c7mr4604282ilq.17.1644732089952;
 Sat, 12 Feb 2022 22:01:29 -0800 (PST)
Date:   Sat, 12 Feb 2022 22:01:29 -0800
In-Reply-To: <0000000000008e52e005c765798b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8eec505d7e007c4@google.com>
Subject: Re: [syzbot] WARNING in scsi_alloc_sgtables
From:   syzbot <syzbot+d44b35ecfb807e5af0b5@syzkaller.appspotmail.com>
To:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b81b1829e7e3 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131edbb4700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5707221760c00a20
dashboard link: https://syzkaller.appspot.com/bug?extid=d44b35ecfb807e5af0b5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171d9ef8700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c18344700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d44b35ecfb807e5af0b5@syzkaller.appspotmail.com

WARNING: CPU: 2 PID: 3643 at drivers/scsi/scsi_lib.c:1032 scsi_alloc_sgtables+0xc7d/0xf70 drivers/scsi/scsi_lib.c:1032
Modules linked in:

CPU: 2 PID: 3643 Comm: syz-executor397 Not tainted 5.17.0-rc3-syzkaller-00316-gb81b1829e7e3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:scsi_alloc_sgtables+0xc7d/0xf70 drivers/scsi/scsi_lib.c:1032
Code: e7 fc 31 ff 44 89 f6 e8 c1 4e e7 fc 45 85 f6 0f 84 1a f5 ff ff e8 93 4c e7 fc 83 c5 01 0f b7 ed e9 0f f5 ff ff e8 83 4c e7 fc <0f> 0b 41 bc 0a 00 00 00 e9 2b fb ff ff 41 bc 09 00 00 00 e9 20 fb
RSP: 0018:ffffc90000d07558 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801bfc96a0 RCX: 0000000000000000
RDX: ffff88801c876000 RSI: ffffffff849060bd RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff849055b9 R11: 0000000000000000 R12: ffff888012b8c000
R13: ffff88801bfc9580 R14: 0000000000000000 R15: ffff88801432c000
FS:  00007effdec8e700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007effdec6d718 CR3: 00000000206d6000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 scsi_setup_scsi_cmnd drivers/scsi/scsi_lib.c:1219 [inline]
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1614 [inline]
 scsi_queue_rq+0x283e/0x3630 drivers/scsi/scsi_lib.c:1730
 blk_mq_dispatch_rq_list+0x6ea/0x22e0 block/blk-mq.c:1851
 __blk_mq_sched_dispatch_requests+0x20b/0x410 block/blk-mq-sched.c:299
 blk_mq_sched_dispatch_requests+0xfb/0x180 block/blk-mq-sched.c:332
 __blk_mq_run_hw_queue+0xf9/0x350 block/blk-mq.c:1968
 __blk_mq_delay_run_hw_queue+0x5b6/0x6c0 block/blk-mq.c:2045
 blk_mq_run_hw_queue+0x30f/0x480 block/blk-mq.c:2096
 blk_mq_sched_insert_request+0x340/0x440 block/blk-mq-sched.c:451
 blk_execute_rq+0xcc/0x340 block/blk-mq.c:1231
 sg_io+0x67c/0x1210 drivers/scsi/scsi_ioctl.c:485
 scsi_ioctl_sg_io drivers/scsi/scsi_ioctl.c:866 [inline]
 scsi_ioctl+0xa66/0x1560 drivers/scsi/scsi_ioctl.c:921
 sd_ioctl+0x199/0x2a0 drivers/scsi/sd.c:1576
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7effdecdc5d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007effdec8e2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007effded664c0 RCX: 00007effdecdc5d9
RDX: 0000000020002300 RSI: 0000000000002285 RDI: 0000000000000004
RBP: 00007effded34034 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007effded34054 R14: 2f30656c69662f2e R15: 00007effded664c8
 </TASK>

