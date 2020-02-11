Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E646B158B1E
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Feb 2020 09:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgBKIOs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 11 Feb 2020 03:14:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgBKIOs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 11 Feb 2020 03:14:48 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 206491] SG_SET_RESERVED_SIZE ioctl failed: Bad address
Date:   Tue, 11 Feb 2020 08:14:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206491-11613-CymgblXvzZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206491-11613@https.bugzilla.kernel.org/>
References: <bug-206491-11613@https.bugzilla.kernel.org/>
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

--- Comment #1 from crvi (crvisqr@gmail.com) ---
Please refer: https://github.com/cdemu/cdemu/issues/3#issuecomment-583894259

This issue was not there in kernel 5.5.0-0.rc4.git2.1

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
