Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889441F05E1
	for <lists+linux-scsi@lfdr.de>; Sat,  6 Jun 2020 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgFFJB5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sat, 6 Jun 2020 05:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFFJB4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 6 Jun 2020 05:01:56 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 207855] arcconf host reset causes kernel panic -> driver crash?
Date:   Sat, 06 Jun 2020 09:01:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: janpieter.sollie@edpnet.be
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-207855-11613-65jbrZzXKy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207855-11613@https.bugzilla.kernel.org/>
References: <bug-207855-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207855

Janpieter Sollie (janpieter.sollie@edpnet.be) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #7 from Janpieter Sollie (janpieter.sollie@edpnet.be) ---
I figured out it was due to an insufficient +5V line which made devices
function the wrong way,I added some extra +5V juice and it worked without any
problem.
Neverthless, is it an option to "isolate" the storage driver somewhat so the
other PCI devices are kept up-and-running?
There are still some points of investigation:
-If it's PCI related, why does the dedicated VGA + onboard USB still work?
-If it's storage subsystem related, why does network IO fail?
-If it's driver related, why is AHCI going down as well?
I guess this is not supposed to happen, so I'll see whether I can make it crash
again, and eventually try to reset the whole PCI bus (and see whether that
would help)

-- 
You are receiving this mail because:
You are the assignee for the bug.
