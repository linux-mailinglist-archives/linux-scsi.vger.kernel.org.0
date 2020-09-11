Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616D4265932
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Sep 2020 08:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgIKGQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Fri, 11 Sep 2020 02:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKGQU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 11 Sep 2020 02:16:20 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 206123] aacraid ( PM8068) and iommu=nobypass Frozen PHB error 
 on ppc64
Date:   Fri, 11 Sep 2020 06:16:19 +0000
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
Message-ID: <bug-206123-11613-Vf8oS3cbuN@https.bugzilla.kernel.org/>
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

--- Comment #13 from Sagar (sagar.biradar@microchip.com) ---
(In reply to gyakovlev from comment #12)
> applied patch to linux-5.4.64, booted with iommu=nobypass and ran some
> stress-ng tests across all drives.
> looks good so far.
> wrote close to 1TB of test data, not a sign of a problem.
> performance is excellent.
> 
> 
> also booted linux-5.8.8 (without patch), just a tiny bit of IO triggers the
> error, controller does not recover after reset, everything hangs.
> I have not tested patched 5.8.8.
> 
> 
> Conclusion is - patch Oliver linked definitely helps and system is stable
> and performant.
> 
> Hopefully it'll make into 5.4 and 5.8, I'll be patching manually meanwhile.
> 
> 
> Tested-by: Georgy Yakovlev <gyakovlev@gentoo.org>

Thanks for the prompt response Georgy. Appreciate it
Does that mean you will patch it one more time on 5.8.8 and based on the result
- we can consider closing this BZ?

Sagar

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
