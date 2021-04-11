Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38D135B234
	for <lists+linux-scsi@lfdr.de>; Sun, 11 Apr 2021 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhDKHnz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 11 Apr 2021 03:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKHny (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 11 Apr 2021 03:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C2C1B611ED
        for <linux-scsi@vger.kernel.org>; Sun, 11 Apr 2021 07:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618127013;
        bh=gwbO3acNV9nUWeJyvaNibsqm4DLLEuJ4wGaUDrIsZPo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SiF48A+SI+mdu4vTxvEv3agmpvqUpRMYd7OqUbVawH4gEn94Tlrq0H0pVyEnHDLJA
         0PRWWhEDTXvynPJ/eHt0quP+EYampf/1vfpuH7c67gk4exPIE3C89LTZCqYPS+jRZI
         kSKTNJkgRG5NMSfBlzwdC+V/UJF5afTwgaoAOqv4eo0PR4aiptoTtXuy5zDurs5vY1
         RZ3Dh7U+tqZluDuYnwZnuH0QeKdyq2jE8aUIosKnl8oOb7qfty0v5mPo6XkGIz8xOC
         uRy1iV5fEaSt8vEFZ3fuS5VaWNs2liXit+HfCEdIVBd+lhuwKHNOGqk7Trx1jg7Eg2
         FBkyZsCA3zluQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id BAC5661185; Sun, 11 Apr 2021 07:43:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 209177] mpt2sas_cm0: failure at
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:10791/_scsih_probe()!
Date:   Sun, 11 Apr 2021 07:43:33 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: toracat@elrepo.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209177-11613-qYpwF3q7jf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209177-11613@https.bugzilla.kernel.org/>
References: <bug-209177-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209177

Akemi Yagi (toracat@elrepo.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |toracat@elrepo.org

--- Comment #5 from Akemi Yagi (toracat@elrepo.org) ---
This bug has been reported for Fedora (kernel 5.8.6):

https://bugzilla.redhat.com/show_bug.cgi?id=3D1878332

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
