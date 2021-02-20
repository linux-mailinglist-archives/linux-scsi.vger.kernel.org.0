Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69F53205E6
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Feb 2021 16:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTP1p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Feb 2021 10:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhBTP1o (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 20 Feb 2021 10:27:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6990064E3E
        for <linux-scsi@vger.kernel.org>; Sat, 20 Feb 2021 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613834822;
        bh=MB7Q+Fi4yDyYTbSFbozVvNRg1RdXggR+OdqzQF8xqPE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eLw8KP51cHqDjGvcZorPwfrQ4sjFTWfpGjIccPsAJ8TYkhT10cp//5VJqdNXTd1Rf
         7025lifYB6wNHTxFY493Zf6SQfsxJRyLCl20GwlYcnHxx7J1fkk3bQNtIct1a2aBfa
         6muypLVvInHdzM/odG3/VEKTber4B9SEXliQxsYZWtQKYaKAvQL6nnjXIff/UJED1A
         2ZSHxwEMtxjZz1dE847xIYqudgmE+CBiSY1Cl0792yEfcE4OuvhCd0oaSgkzNBkNAl
         GaEUkCaEKUxcxZ7Y2L89q5JsBA3atCU0faLmlpSTN2C631s8fbJU6a5BUrEj8JDj/c
         4wTce2uikzs5Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 5632565346; Sat, 20 Feb 2021 15:27:02 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 211227] [BISECTED][REGRESSION] Linux 5.10.7 breaks s3 resume on
 opal encrypted ssd
Date:   Sat, 20 Feb 2021 15:27:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chriscjsus@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211227-11613-eytGd1ST5x@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211227-11613@https.bugzilla.kernel.org/>
References: <bug-211227-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211227

--- Comment #4 from chriscjsus@yahoo.com ---
Forgot to mention that CONFIG_PM=3Dy in the kernel configs that I use.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
