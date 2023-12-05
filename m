Return-Path: <linux-scsi+bounces-568-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0F80620D
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 23:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162B01F212E6
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 22:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F43FE4C
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUmM28wq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDD6E589
	for <linux-scsi@vger.kernel.org>; Tue,  5 Dec 2023 21:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BEE4C433C8
	for <linux-scsi@vger.kernel.org>; Tue,  5 Dec 2023 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701812242;
	bh=LuWh6aqwWmGWTQFv4b3rnUP7zqoDkwpdbD4ho7Z2820=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HUmM28wqSVgf7uYir4tBp62JOqliLf3FIRpsQqoN4edgVPFvhel69KVTtZqZ8nDjx
	 i4dr/uatSD/lY4bpG/07yIMJWs4/VnWY6ic7S7BXz4bpTKjFgfjsFTSprSrdx/nCFR
	 R0//TXRXqvESPFPVHPirMxjNxQOO+9MJt4wmzb/CWvy11bKIJHZxUtyhrpMSOIk6Tv
	 JM6Up0DNeZa7ttldoBjNcacHpMWasKv/+hx1zHfSb8f1dACE2kejDPCrflhIgfvL6D
	 Uin1IDsMsUpdm1J+jSB2X6o22oPaxWHPIMY7gAh3Pf/Bbv9RvdjfdfoYbczLmDSKFt
	 OZIQUbhioZ/vg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F3E01C53BD2; Tue,  5 Dec 2023 21:37:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-scsi@vger.kernel.org
Subject: [Bug 218198] Suspend/Resume Regression with attached ATA devices
Date: Tue, 05 Dec 2023 21:37:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: phill@thesusis.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218198-11613-1wOsltpGIk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218198-11613@https.bugzilla.kernel.org/>
References: <bug-218198-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218198

--- Comment #14 from Phillip Susi (phill@thesusis.net) ---
bugzilla-daemon@kernel.org writes:

> a couple of seconds after successful resume my system transitions down to
> pc8.
> hdparm manual doesn't explicitly tell what command is issued with the -Y
> switch.

SLEEP.  One problem with using it though is that several things
tend to wake the drive up from it soon.  I've had patches to address
this for years.  Maybe I'll finally get them merged soon.  Those things
are:

1)  smartd or udisks2 polling the SMART status of the drive.  They
already issue CHECK POWER CONDITION first to see if the drive is in
STANDBY and if so, don't bother with the SMART read.  That avoids waking
up a disk in STANDBY mode, but in SLEEP, you can't even ask the drive
whether it's in standby without waking it up.

2)  A mounted filesystem periodically issues a FLUSH CACHE command, even
if nothing has been written.  A drive in STANDBY just ignores it but in
SLEEP, it wakes up.

I would imagine at once you access the disk in some way and so it wakes
up, you won't get back to pc8 again without another hdparm -Y?  Is that
correct?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

