Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E763D2F
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfGIVSc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 9 Jul 2019 17:18:32 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:49830 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbfGIVSc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 17:18:32 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 87DCA28897
        for <linux-scsi@vger.kernel.org>; Tue,  9 Jul 2019 21:18:31 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7C515288C7; Tue,  9 Jul 2019 21:18:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 204119] scsi_mod: Could not allocate 4104 bytes percpu data
Date:   Tue, 09 Jul 2019 21:18:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bvanassche@acm.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204119-11613-X5INlHoVUk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204119-11613@https.bugzilla.kernel.org/>
References: <bug-204119-11613@https.bugzilla.kernel.org/>
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

Bart Van Assche (bvanassche@acm.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bvanassche@acm.org

--- Comment #1 from Bart Van Assche (bvanassche@acm.org) ---
From which kernel version did you upgrade to 5.2?

-- 
You are receiving this mail because:
You are the assignee for the bug.
