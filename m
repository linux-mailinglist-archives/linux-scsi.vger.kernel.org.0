Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778712639A5
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Sep 2020 03:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgIJB7R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Wed, 9 Sep 2020 21:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgIJBrr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Sep 2020 21:47:47 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 206123] aacraid ( PM8068) and iommu=nobypass Frozen PHB error 
 on ppc64
Date:   Thu, 10 Sep 2020 01:46:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-aacraid@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: AACRAID
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sagar.biradar@microchip.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-aacraid@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206123-11613-N1YEqvxzui@https.bugzilla.kernel.org/>
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

--- Comment #11 from Sagar (sagar.biradar@microchip.com) ---
(In reply to gyakovlev from comment #10)
> (In reply to Oliver O'Halloran from comment #8)
> > Can you see if this patch fixes it?
> > 
> >
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200908015106.79661-
> > 1-aik@ozlabs.ru/
> 
> ok I applied this patch to linux-5.4.63
> 
> looks very good so far, kernel booted with 'iommu=nobypass' and I don't see
> any problems with aacraid yet, it works. I can write to all 8 SAS disks in
> parallel, and can't trigger the error.
> 
> 
> I'll try to generate torture/heavy random IO on the disks a bit later.
> 
> also I may give linux-5.8.8 a try.

Hi,
could you please post you findings with heavy IO load?

Also Thanks Oliver for adding the reference to the potential patch.
Appreciate it.

Thanks
Sagar

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
