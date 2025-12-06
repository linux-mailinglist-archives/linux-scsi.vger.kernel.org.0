Return-Path: <linux-scsi+bounces-19570-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA95CAAED4
	for <lists+linux-scsi@lfdr.de>; Sat, 06 Dec 2025 23:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AB1D3008D73
	for <lists+linux-scsi@lfdr.de>; Sat,  6 Dec 2025 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384FA296BBD;
	Sat,  6 Dec 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXGyyjEq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E783B8D47
	for <linux-scsi@vger.kernel.org>; Sat,  6 Dec 2025 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765061782; cv=none; b=BKHP0y3IgUFXDGsslXofv1pzKYUtLKX/fqZ9iMii0Y7CEJZy6ApoofHZYp15XzqztnmimHzMsSx+ktwFfqaEUmyaQSh9LpaARD/gKKrLfOc6TGSqIQL9LzQf0mDUO8IDIypUpwux4TnBnOnQGvr/oAmLF5qrCPIhJB4aeic8na8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765061782; c=relaxed/simple;
	bh=k6u+81kX9Gcd8cWbyzNcmLW8K875RwLHuzkxerJv7ec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0v9wz0FTQqlktnSbxwJr5G1uMA0A2I0I0ZPA+RRixAjffic5hlRGrJZQngPxGv31lHe+xa15B5iIYcdUA4wBs81XNKAdmQVfPc2VQjl9ac0UHJP7AMsFEDUkF0LYPmeT1z2bM0qW+f7AVAqYrabhXOQKEVmInrb3zBIGU/3LjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXGyyjEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78488C116D0
	for <linux-scsi@vger.kernel.org>; Sat,  6 Dec 2025 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765061781;
	bh=k6u+81kX9Gcd8cWbyzNcmLW8K875RwLHuzkxerJv7ec=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dXGyyjEqoVZQc6mb5+v+X8wwh5yd0GhYtCeZHruWFbLxTaz+Y1ZiwbYJFskqmmPSd
	 9cDjkxd1fxXUHAovBQDLYh4nExlb+/g6bU6ZHPQy0SAIQt6cESo1NhRE9mvDrnf92k
	 mDbzc75/LeWEudfMn/njIctfX4yjRJVF3vhgKk25T/mEbzjayTVuQ/JhEFYuQC/2Ah
	 FcNWLP3G0ZMlfVwve67kMe3NcKgmJ3lE0lvmDtuPInHfKRtVhzeFuEjfx7kBsM6K4C
	 KIA9eujHQVUY6Sq6xmhNSWhJ47QF2DUMiIV+SuJkywL1qTHKA6+JYA9zeloA1X9nNY
	 6tnxPORwowcnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6E4BAC53BC7; Sat,  6 Dec 2025 22:56:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-scsi@vger.kernel.org
Subject: [Bug 219575] UBSAN: array-index-out-of-bounds in
 drivers/message/fusion/mptsas.c:2446:22 ; index 1 is out of range for type
 'MPI_SAS_IO_UNIT0_PHY_DATA [1]'
Date: Sat, 06 Dec 2025 22:56:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rdunlap@infradead.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-219575-11613-oojfZ2JAfi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219575-11613@https.bugzilla.kernel.org/>
References: <bug-219575-11613@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219575

Randy Dunlap (rdunlap@infradead.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |rdunlap@infradead.org
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

