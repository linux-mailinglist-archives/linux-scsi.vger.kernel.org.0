Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB52FD1CD
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Jan 2021 14:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389672AbhATN2X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Wed, 20 Jan 2021 08:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733079AbhATNOI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 20 Jan 2021 08:14:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D29823371
        for <linux-scsi@vger.kernel.org>; Wed, 20 Jan 2021 13:13:14 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 25A1386726; Wed, 20 Jan 2021 13:13:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 211285] new kernel 5.10.8 deadlock?
Date:   Wed, 20 Jan 2021 13:13:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mricon@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_group component cf_kernel_version version
 assigned_to product
Message-ID: <bug-211285-11613-nYzoMVn59u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211285-11613@https.bugzilla.kernel.org/>
References: <bug-211285-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=211285

Konstantin Ryabitsev (mricon@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
              Group|korgadmins                  |
          Component|Helpdesk                    |Other
     Kernel Version|                            |5.10.8
            Version|unspecified                 |2.5
           Assignee|kernelorg-helpdesk@kernel-b |scsi_drivers-other@kernel-b
                   |ugs.kernel.org              |ugs.osdl.org
            Product|kernel.org infra            |SCSI Drivers

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.
