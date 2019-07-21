Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B956F22A
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 09:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGUH0V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sun, 21 Jul 2019 03:26:21 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:48966 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbfGUH0U (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 21 Jul 2019 03:26:20 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 564E22871E
        for <linux-scsi@vger.kernel.org>; Sun, 21 Jul 2019 07:26:20 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 4AA2428757; Sun, 21 Jul 2019 07:26:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 204243] WARNING: possible circular locking dependency detected
 [sr_mod]
Date:   Sun, 21 Jul 2019 07:26:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: scdbackup@gmx.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204243-11613-ypoB1vu8kc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204243-11613@https.bugzilla.kernel.org/>
References: <bug-204243-11613@https.bugzilla.kernel.org/>
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

Thomas Schmitt (scdbackup@gmx.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |scdbackup@gmx.net

--- Comment #2 from Thomas Schmitt (scdbackup@gmx.net) ---
Hi,

the lock in sr_block_open() is a nuisance since it was introduced by
a daring mass change nine years ago:
  https://lkml.org/lkml/2010/9/14/338
It has a history of complaints about slowing down concurrent use of
ioctl(SG_IO) on different sr drives:
  https://marc.info/?l=linux-scsi&m=135705061804384&w=2
As developer of libburn i had to develop workarounds in userspace:
  http://libburnia-project.org/wiki/ConcurrentLinuxSr
None of them is really satisfying.

Since 3 years i use /dev/sg* instead of /dev/sr* for burning. The older
readers will remember the relief when we could use hd and sr and thus
had proper coordination with mount(8). This is gone, at least for systems
where more than one optical drive shall be used concurrently.

So, as did others before, i propose to remove the mutex_lock()/mutex_unlock()
pair in sr_block_ioctl().

(Actually the other mutex_lock()/mutex_unlock() pairs introduced by
   https://lkml.org/lkml/2010/9/14/338
 should be examined whether they are appropriate replacements of the
 previously existing BKLs. They don't have this long lasting impact on
 multi-drive operation, though.)

Have a nice day :)

Thomas

-- 
You are receiving this mail because:
You are the assignee for the bug.
