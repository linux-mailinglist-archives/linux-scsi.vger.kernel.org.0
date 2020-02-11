Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5105B158B19
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Feb 2020 09:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBKINH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 11 Feb 2020 03:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbgBKINH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 11 Feb 2020 03:13:07 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 206491] New: SG_SET_RESERVED_SIZE ioctl failed: Bad address
Date:   Tue, 11 Feb 2020 08:13:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: crvisqr@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206491-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206491

            Bug ID: 206491
           Summary: SG_SET_RESERVED_SIZE ioctl failed: Bad address
           Product: SCSI Drivers
           Version: 2.5
    Kernel Version: 5.6.0-0.rc0.git5.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: scsi_drivers-other@kernel-bugs.osdl.org
          Reporter: crvisqr@gmail.com
        Regression: No

[rok@vm-fedora-rawhide ~]$ cdrdao read-toc --device /dev/sr1 toc.toc
Cdrdao version 1.2.4 - (C) Andreas Mueller <andreas@daneb.de>
ERROR: SG_SET_RESERVED_SIZE ioctl failed: Bad address
ERROR: /dev/sr1: SCSI command Inquiry (0x12) failed: Bad address.
ERROR: Inquiry command failed on "/dev/sr1"
/dev/sr1: �&~4�U        Rev: 
ERROR: Inquiry failed and no driver id is specified.
ERROR: Please use option --driver to specify a driver id.
ERROR: Cannot setup device /dev/sr1.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
