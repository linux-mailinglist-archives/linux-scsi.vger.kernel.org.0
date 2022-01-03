Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FE48368C
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jan 2022 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiACSE0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jan 2022 13:04:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46548 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiACSE0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Jan 2022 13:04:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09AAE61194
        for <linux-scsi@vger.kernel.org>; Mon,  3 Jan 2022 18:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 713D6C36AEF
        for <linux-scsi@vger.kernel.org>; Mon,  3 Jan 2022 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641233065;
        bh=bLmfMjS7LGLer5TdJo6UjopBkRbLOW5gWtOrRmSJ3kE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XzABaUR+zXZmqvxQhzfFWUj7ieZR+FZlnMnHOp3g6EWH7oc8JAJERkX8/i5AT5QxW
         d2wnhQTy5pBE6wu+mmtsYOeJVdpvjpXB/8RjBUjkkGkxTmUgA5KJVzUoX11zC97/EH
         pHZC6+idkSGL6+rpSyaxpt9Zt6MicX+9C0jvvDlSd86FxAivPTbG3Ne/cMM411Mypz
         AYw/f0dzt1wbvE6B8IN6OZwuanoa2v81oV4bUvELAKJaJFooHbi/ilEBuvHHyU6vFA
         HplIhzbMVm/OvwQKftgWpaq4dyPzVPqXfj1qmmDnvz9ljwKOy7ybTnuhcfPB4GftI1
         bzAjtIC/FhEag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 62334C004D8; Mon,  3 Jan 2022 18:04:25 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 215447] sr_mod scsi_mode_sense() failure -> "scsi-1 drive"
Date:   Mon, 03 Jan 2022 18:04:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Product: SCSI Drivers
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cshorler@googlemail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: scsi_drivers-other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215447-11613-aLs273i1Zr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215447-11613@https.bugzilla.kernel.org/>
References: <bug-215447-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215447

--- Comment #2 from Chris Horler (cshorler@googlemail.com) ---
Created attachment 300218
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300218&action=3Dedit
my understanding of a typical scsi messages / error codes from the logs

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
