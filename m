Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BECB63C9B
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfGIUQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 9 Jul 2019 16:16:04 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:41408 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729526AbfGIUQE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 16:16:04 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A240928877
        for <linux-scsi@vger.kernel.org>; Tue,  9 Jul 2019 20:16:03 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 96D77288AC; Tue,  9 Jul 2019 20:16:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 204119] New: scsi_mod: Could not allocate 4104 bytes percpu
 data
Date:   Tue, 09 Jul 2019 20:16:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpalus@fastmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204119-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204119

            Bug ID: 204119
           Summary: scsi_mod: Could not allocate 4104 bytes percpu data
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 5.2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: SCSI
          Assignee: linux-scsi@vger.kernel.org
          Reporter: jpalus@fastmail.com
        Regression: No

After upgrading to 5.2 scsi_mod fails to insert (CONFIG_X86_VSMP is not set):

Jul 09 09:50:25 localhost kernel: percpu: allocation failed, size=4104 align=32
atomic=0, alloc from reserved chunk failed
Jul 09 09:50:25 localhost kernel: CPU: 0 PID: 372 Comm: systemd-udevd Tainted:
G                T 5.2.0-0.1 #1
Jul 09 09:50:25 localhost kernel: Hardware name: System manufacturer System
Product Name/Z170-PRO, BIOS 3801 03/14/2018
Jul 09 09:50:25 localhost kernel: Call Trace:
Jul 09 09:50:25 localhost kernel:  dump_stack+0x5c/0x78
Jul 09 09:50:25 localhost kernel:  pcpu_alloc.cold.12+0x22/0x45
Jul 09 09:50:25 localhost kernel:  ? __vmalloc_node_range+0x1cf/0x240
Jul 09 09:50:25 localhost kernel:  load_module+0xd8f/0x2500
Jul 09 09:50:25 localhost kernel:  ? map_vm_area+0x38/0x50
Jul 09 09:50:25 localhost kernel:  ? __vmalloc_node_range+0x1cf/0x240
Jul 09 09:50:25 localhost kernel:  ? __se_sys_init_module+0x136/0x160
Jul 09 09:50:25 localhost kernel:  __se_sys_init_module+0x136/0x160
Jul 09 09:50:25 localhost kernel:  do_syscall_64+0x5b/0x130
Jul 09 09:50:25 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul 09 09:50:25 localhost kernel: RIP: 0033:0x7f3a5c452afe
Jul 09 09:50:25 localhost kernel: Code: 48 8b 0d 85 43 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 43 0c 00 f7 d8 64 89 01 48
Jul 09 09:50:25 localhost kernel: RSP: 002b:00007ffc9d2f6768 EFLAGS: 00000202
ORIG_RAX: 00000000000000af
Jul 09 09:50:25 localhost kernel: RAX: ffffffffffffffda RBX: 00000000008b5cf0
RCX: 00007f3a5c452afe
Jul 09 09:50:25 localhost kernel: RDX: 00007f3a5c7ae865 RSI: 000000000007f110
RDI: 00007f3a5a3c7010
Jul 09 09:50:25 localhost kernel: RBP: 00007f3a5c7ae865 R08: 000000000000005f
R09: 00000000008b5ab0
Jul 09 09:50:25 localhost kernel: R10: 00000000008a0010 R11: 0000000000000202
R12: 00007f3a5a3c7010
Jul 09 09:50:25 localhost kernel: R13: 00000000008a4000 R14: 0000000000020000
R15: 00000000008b5cf0
Jul 09 09:50:25 localhost kernel: scsi_mod: Could not allocate 4104 bytes
percpu data

-- 
You are receiving this mail because:
You are the assignee for the bug.
