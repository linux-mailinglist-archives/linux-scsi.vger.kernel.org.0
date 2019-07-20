Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688C76EF1B
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jul 2019 12:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfGTKnj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sat, 20 Jul 2019 06:43:39 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52228 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727369AbfGTKnj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 20 Jul 2019 06:43:39 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EC33028960
        for <linux-scsi@vger.kernel.org>; Sat, 20 Jul 2019 10:43:37 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id E08ED28989; Sat, 20 Jul 2019 10:43:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 204243] New: WARNING: possible circular locking dependency
 detected [sr_mod]
Date:   Sat, 20 Jul 2019 10:43:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-204243-11613@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=204243

            Bug ID: 204243
           Summary: WARNING: possible circular locking dependency detected
                    [sr_mod]
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 5.2.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: SCSI
          Assignee: linux-scsi@vger.kernel.org
          Reporter: erhard_f@mailbox.org
        Regression: No

Created attachment 283867
  --> https://bugzilla.kernel.org/attachment.cgi?id=283867&action=edit
dmesg output

Encountered this during writing an .iso to a DVD-RW media:

[...]
[ 6908.678745] ======================================================
[ 6908.678746] WARNING: possible circular locking dependency detected
[ 6908.678749] 5.2.1-gentoo #1 Not tainted
[ 6908.678750] ------------------------------------------------------
[ 6908.678752] brasero/1066 is trying to acquire lock:
[ 6908.678754] 0000000087aec994 (&mm->mmap_sem#2){++++}, at:
__do_page_fault+0x387/0x420
[ 6908.678761] 
               but task is already holding lock:
[ 6908.678762] 0000000056293ac4 (sr_mutex){+.+.}, at: sr_block_ioctl+0x3a/0xc0
[sr_mod]
[ 6908.678768] 
               which lock already depends on the new lock.

[ 6908.678769] 
               the existing dependency chain (in reverse order) is:
[ 6908.678770] 
               -> #6 (sr_mutex){+.+.}:
[ 6908.678773] 
               -> #5 (&bdev->bd_mutex){+.+.}:
[ 6908.678775] 
               -> #4 (&fs_devs->device_list_mutex){+.+.}:
[ 6908.678777] 
               -> #3 (&fs_info->tree_log_mutex){+.+.}:
[ 6908.678780] 
               -> #2 (&fs_info->reloc_mutex){+.+.}:
[ 6908.678782] 
               -> #1 (sb_pagefaults){.+.+}:
[ 6908.678784] 
               -> #0 (&mm->mmap_sem#2){++++}:
[ 6908.678786] 
               other info that might help us debug this:

[ 6908.678787] Chain exists of:
                 &mm->mmap_sem#2 --> &bdev->bd_mutex --> sr_mutex

[ 6908.678790]  Possible unsafe locking scenario:

[ 6908.678791]        CPU0                    CPU1
[ 6908.678793]        ----                    ----
[ 6908.678794]   lock(sr_mutex);
[ 6908.678795]                                lock(&bdev->bd_mutex);
[ 6908.678797]                                lock(sr_mutex);
[ 6908.678798]   lock(&mm->mmap_sem#2);
[ 6908.678800] 
                *** DEADLOCK ***

[ 6908.678801] 1 lock held by brasero/1066:
[ 6908.678802]  #0: 0000000056293ac4 (sr_mutex){+.+.}, at:
sr_block_ioctl+0x3a/0xc0 [sr_mod]
[ 6908.678806] 
               stack backtrace:
[ 6908.678809] CPU: 1 PID: 1066 Comm: brasero Not tainted 5.2.1-gentoo #1
[ 6908.678810] Hardware name: System manufacturer System Product Name/M5A78L-M
LX3, BIOS 1401    05/05/2016
[ 6908.678812] Call Trace:
[ 6908.678816]  dump_stack+0x67/0x98
[ 6908.678820]  print_circular_bug.cold.60+0x15c/0x195
[ 6908.678823]  __lock_acquire+0x17c0/0x1d18
[ 6908.678826]  lock_acquire+0xaa/0x168
[ 6908.678828]  ? __do_page_fault+0x387/0x420
[ 6908.678831]  ? copy_user_generic_string+0x29/0x40
[ 6908.678833]  down_read+0x28/0xc0
[ 6908.678836]  ? __do_page_fault+0x387/0x420
[ 6908.678838]  __do_page_fault+0x387/0x420
[ 6908.678841]  ? page_fault+0x1b/0x20
[ 6908.678843]  ? copy_user_generic_string+0x29/0x40
[ 6908.678846]  ? copyout+0x25/0x30
[ 6908.678847]  ? copy_page_to_iter+0xd0/0x330
[ 6908.678850]  ? bio_uncopy_user+0x124/0x168
[ 6908.678852]  ? blk_rq_unmap_user+0x22/0x60
[ 6908.678855]  ? sg_io+0x268/0x440
[ 6908.678857]  ? scsi_cmd_ioctl+0x2b2/0x498
[ 6908.678861]  ? cdrom_ioctl+0x36/0xde4 [cdrom]
[ 6908.678864]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[ 6908.678866]  ? __pm_runtime_resume+0x4f/0x70
[ 6908.678869]  ? sr_block_ioctl+0x9d/0xc0 [sr_mod]
[ 6908.678872]  ? blkdev_ioctl+0x52e/0xa80
[ 6908.678874]  ? find_held_lock+0x2d/0x90
[ 6908.678876]  ? block_ioctl+0x2d/0x38
[ 6908.678879]  ? do_vfs_ioctl+0xa8/0x718
[ 6908.678881]  ? __fget+0x101/0x1e0
[ 6908.678883]  ? ksys_ioctl+0x35/0x70
[ 6908.678884]  ? __x64_sys_ioctl+0x11/0x18
[ 6908.678887]  ? do_syscall_64+0x4b/0x198
[ 6908.678889]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 6984.804171] capability: warning: `growisofs' uses 32-bit capabilities
(legacy support in use)

-- 
You are receiving this mail because:
You are the assignee for the bug.
