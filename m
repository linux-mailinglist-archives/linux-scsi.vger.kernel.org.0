Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD41B002D
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2020 05:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDTDSD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sun, 19 Apr 2020 23:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgDTDSD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 19 Apr 2020 23:18:03 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 206123] aacraid ( PM8068) and iommu=nobypass Frozen PHB error 
 on ppc64
Date:   Mon, 20 Apr 2020 03:18:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-aacraid@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: AACRAID
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oohall@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-aacraid@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-206123-11613-2jOGp0jym3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206123-11613@https.bugzilla.kernel.org/>
References: <bug-206123-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206123

Oliver O'Halloran (oohall@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |oohall@gmail.com

--- Comment #4 from Oliver O'Halloran (oohall@gmail.com) ---
(In reply to Timothy Pearson from comment #3)
> If I'm decoding this right, the EEH is caused by a PCIe configuration space
> write, triggering a correctable error in the PCIe core.  I have no way of
> knowing if the address reported is valid (I suspect it is not) but would be
> 0x0.

$ pest 8300b03800000000 8000000000000000
Transaction type: DMA Read Response
Invalid MMIO Address
TCE Page Fault
TCE Access Fault
LEM Bit Number 56
Requestor 00:0.0
MSI Data 0x0000
Fault Address = 0x0000000000000000

A TCE fault makes more sense given that it doesn't happen when bypass is
enabled. I'm leaning towards this being a driver bug, but it could be a powerpc
IOMMU specific issue. I'll investigate.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
