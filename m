Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406F4EC87
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Apr 2019 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfD2WJU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Mon, 29 Apr 2019 18:09:20 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:57392 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729437AbfD2WJU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Apr 2019 18:09:20 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 00948289F3
        for <linux-scsi@vger.kernel.org>; Mon, 29 Apr 2019 22:09:19 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id E67AB289F0; Mon, 29 Apr 2019 22:09:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 199887] Fibre login failure on older adapters
Date:   Mon, 29 Apr 2019 22:09:19 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-qla2xxx@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: QLOGIC QLA2XXX
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: whiteheadm@acm.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-qla2xxx@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-199887-11613-mhJZX0kYkY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199887-11613@https.bugzilla.kernel.org/>
References: <bug-199887-11613@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=199887

Matthew Whitehead (whiteheadm@acm.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |whiteheadm@acm.org

--- Comment #2 from Matthew Whitehead (whiteheadm@acm.org) ---
I have reproduced this problem with similar hardware, an ISP2300. The problem
is not present using the 4.9.171 kernel, and it is present on the 4.14.114
kernel, so the suspicion that it was introduced in 4.11 is likely.

I will attempt to test it on a similar ISP6312 next.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
