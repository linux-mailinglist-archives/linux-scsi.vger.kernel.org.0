Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2132C807
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 02:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355762AbhCDAda (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Mar 2021 19:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388045AbhCCUfL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 3 Mar 2021 15:35:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 495CB64F09
        for <linux-scsi@vger.kernel.org>; Wed,  3 Mar 2021 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614803671;
        bh=ESTdII5QMK9KiJE227qzet6edyrckTWoy8AHFhW+isw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mJyxb3uLhMXcApCPRIl1L0I+pWs6iAIv7TUEWl5Yzj5G4wpIzgmxKaUZMVElsux9T
         8DHhG4bNzzEI0GY2kk2F8YmQ1fQQsSh1abJhCDQvSD3bLuBEk2RBzpmS5Lqyvg9hOh
         szWkX1toKmRHtDMeNKWdPCBL5oRRUJm59sH5Vitz7g8ygiXtKyRWkvZTwjBM8eHldP
         rkfZcgeuTc9YN2W690pmmEr1EpJt3Ak2E2KVESWYD3XL3sjn1f+qQ5gmGlulab4Twp
         SoKZuAgMO9384xRpsaPSgHHypgSnrgM2i3PIAm5/gISS3mgeGSn5soOz1XyjknnpPV
         uF7x56RrUUNvw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4126C6537D; Wed,  3 Mar 2021 20:34:31 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 212007] wrong timeout calculation in scsi device_handler
 (scsi_dh_emc.c and scsi_dh_rdac.c)
Date:   Wed, 03 Mar 2021 20:34:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bvanassche@acm.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-212007-11613-upgWiFn8gP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-212007-11613@https.bugzilla.kernel.org/>
References: <bug-212007-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212007

Bart Van Assche (bvanassche@acm.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bvanassche@acm.org

--- Comment #1 from Bart Van Assche (bvanassche@acm.org) ---
Please prepare a patch and post it on the linux-scsi mailing list.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
