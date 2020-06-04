Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E11EE65B
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jun 2020 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgFDOLm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Thu, 4 Jun 2020 10:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgFDOLl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 4 Jun 2020 10:11:41 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 208045] ARM ubuntu 18.04 as the iscsi server, using initiator
 login, the kernel crashes
Date:   Thu, 04 Jun 2020 14:11:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: lnsyyj@hotmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-208045-11613-UvBzJC4qOR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208045-11613@https.bugzilla.kernel.org/>
References: <bug-208045-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208045

JiangYu (lnsyyj@hotmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|4.19.118                    |4.19.118, 5.4.44, 5.6.16

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
