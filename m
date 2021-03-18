Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3015340EA5
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Mar 2021 20:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhCRT5g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Mar 2021 15:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbhCRT5Y (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Mar 2021 15:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 675F564E83
        for <linux-scsi@vger.kernel.org>; Thu, 18 Mar 2021 19:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616097442;
        bh=PUIRNqaC3mnc7JUUk2Q74hZGoqhk5uIrVsHNKrNQXMs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aNLUTUVrV1t6icUrmwcsQ2oDAAyC+Oe34jTMoaN09SihrwpVepd6/AsdrFi7W03Rx
         q+kRZsridnKKsk+DNsVllIp0BBOylhQGYDi26tmdBltzpFQ0RzP5Jh0FLkgSPGVvtE
         g91tWIgvRBnZK+NRfpo+nfVakAI6b+WjMO2n/A1lVEghrACSBUlhOgsPzmUv+Tb7pB
         oSTh7yGNaYqORvbhgTet9zrrnTHswBwYrPjKBn7FBx40frOhy9FvHJodrVhpJwcaZd
         k/EZSoigvikELTPAFwX+CP+J7gJhPzq8UC8G9NkQ9SogoqnOQ1SRpFY7WxStGHaeZq
         wOAjvpY8m0zAA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 5CA6C653CB; Thu, 18 Mar 2021 19:57:22 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 212337] scsi_debug: race at module load and module unload
Date:   Thu, 18 Mar 2021 19:57:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mcgrof@kernel.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-212337-11613-DAZeRZszl3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-212337-11613@https.bugzilla.kernel.org/>
References: <bug-212337-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212337

--- Comment #7 from Luis Chamberlain (mcgrof@kernel.org) ---
(In reply to d gilbert from comment #3)
> To stop any higher levels setting up SCSI devices before the async scans
> are complete, the scsi_debug can set TEST UNIT READY to return an error
> along the lines of: not ready, device in process of becoming ready
> BTW that is what real devices do, but scsi_debug does not do that by defa=
ult.

I looked but it was not clear how to do this exactly.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
