Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2B36C173
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 11:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhD0JGM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 05:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhD0JGM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 05:06:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4A1DC610FA
        for <linux-scsi@vger.kernel.org>; Tue, 27 Apr 2021 09:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619514329;
        bh=1cvrlA6NIYue5ShxjuR+2CuQKHTp7j1VQrhmqMSMEj0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qcjq0UU6uAYw7Nj4sxC+m5gH8GVNmXvutSObYq1XXYVzbf2Tk0HmRgLZDCmpnXWWY
         64cTbvk+y09gywqFBon3PFuBKoBIiBlT4HG0Cs0JIP1V35YuU4ZKSMdjsjhlP80f3g
         ALv4z3DKUTOVlk9DJeB9K+OwW5Mxt8JE9gZjqLRoCr295ziRHHUIDP6XTJvJkBnUWD
         WheEAs0V03g1sZb3ptpQL6ZLtCsLB/PIcToLVHgpD2uVo1RhanNtryIKkrapuU04Tc
         6es7WVtx4qM0czSNDKdqdLMMIMQF2hScyfmLplwmzpaFkXpWw+7QlX7aZKQenzh+Ix
         O8QSFfQNL9Oiw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4059661278; Tue, 27 Apr 2021 09:05:29 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 212759] NvmeOf (nvmet-rdma) cause crash with first step connect
Date:   Tue, 27 Apr 2021 09:05:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: NVMe
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: slavon.net@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-212759-11613-2rxXRrCMmh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-212759-11613@https.bugzilla.kernel.org/>
References: <bug-212759-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212759

--- Comment #3 from Badalian Slava (slavon.net@gmail.com) ---
Sorry for wrong category

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
