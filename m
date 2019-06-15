Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E098471FF
	for <lists+linux-scsi@lfdr.de>; Sat, 15 Jun 2019 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFOUFv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sat, 15 Jun 2019 16:05:51 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:35908 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725270AbfFOUFv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 15 Jun 2019 16:05:51 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id BB60626E78
        for <linux-scsi@vger.kernel.org>; Sat, 15 Jun 2019 20:05:49 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id AF9E127F85; Sat, 15 Jun 2019 20:05:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 71981] Writing session to CD does not update some important
 cached information
Date:   Sat, 15 Jun 2019 20:05:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: rogerx.oss@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-71981-11613-xWXGPrWX8Q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-71981-11613@https.bugzilla.kernel.org/>
References: <bug-71981-11613@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=71981

Roger (rogerx.oss@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rogerx.oss@gmail.com

--- Comment #1 from Roger (rogerx.oss@gmail.com) ---
I'm also seeing the following error within my logs, subsequently causing BD-R
(and likely CD/DVD) media to not be able to be mounted, either manually or by
using autofs.

kernel: isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16

In my case, seems to be due to previous failed growisofs sessions when writing
at a higher riskier speeds to (Verbatim 50GB) dual layer BD-R media, but within
drive & media manufacturer's recommendations.  The BD-R drive I'm using, LG
WH16NS60 displays both this dual layer write problem and subsequent reading
problems.  The previous LG WH14NS40 BD-R drive, displayed the similar scenario
but I did not catch the scsi/kernel error within logs.

Either rebooting and/or using the media within a Windows or secondary computer,
the media can be read.

The above error seems to be caused by:
# mount -t iso9660 /dev/sr0 /mnt/tmp
mount: /mnt/tmp1: wrong fs type, bad option, bad superblock on /dev/sr0,
missing codepage or helper program, or other error.
32 :-(

WORKAROUND
SOFT RESET SCSI BUS
https://zedt.eu/tech/linux/soft-resetting-sata-devices-linux/

Get host number:
# readlink /sys/block/sdX
../devices/pci0000:00/0000:00:1f.2/host1/target1:0:0/1:0:0:0/block/sr0

Trigger device delete:
# echo 1 > /sys/block/sdX/device/delete

Trigger device scan on host controller number as specified above:
# echo "- - -" > /sys/class/scsi_host/host1/scan

Long story short, this looks like a kernel/growisofs problem.  Growisofs is
having difficulties writing dual layer (Verbatim) bluray (BD-R) media at speeds
above speed=1 here.  An error condition is likely incurred, either or both the
kernel or growisofs is having problems properly handling.  The writing problem
is also experienced under MS Windows 10, due to likely MS Windows 10 using max
speed. Not known if MS Windows 10 is also have problems with reading after scsi
bus errors as described above, etc.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
