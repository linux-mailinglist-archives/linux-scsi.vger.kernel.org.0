Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26598400B58
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Sep 2021 14:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhIDMeU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 4 Sep 2021 08:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236349AbhIDMeT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 4 Sep 2021 08:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F35FB60F38
        for <linux-scsi@vger.kernel.org>; Sat,  4 Sep 2021 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630758795;
        bh=MD4EOTMWyDffBAz37M1PVhe6+v6+/e1OgQsmrrmTYJ8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k7bUqRY59VsTJ7JJR9K0z5ZuEw/WgYW9I+6wOpDMkBPEPJsydQ0CzpQJUY5jnXYme
         liRVvuAiKsXr0sGl4ELmkLmW+o8kZtvdEFFHfaEuiYQPgLCSYJ3qg3AfjD6bXY0KxY
         IVOaungWHJRz/eCZQQWtHmz5kuvRoXP05lb/qF+sJybLljk9aHQh7Ix2QfDiZYlqSl
         PmYbc5GaFzKN1NHZv5JJe++S2dK2Xegkq0FGD2S8uNU9lQzDz2/a8uKxmvh1i8x73n
         zZju3gdopZNc66DnV49lwhnzqG6L9PMoz/8jFh3XTRAyxYC765XCc5/5HfHSvM6Iuj
         gwLwHhBfOrL0Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E5C9C60EE3; Sat,  4 Sep 2021 12:33:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 214311] megaraid_sas - no disks detected
Date:   Sat, 04 Sep 2021 12:33:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jarek@poczta.srv.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214311-11613-6GgKVHj1gG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214311-11613@https.bugzilla.kernel.org/>
References: <bug-214311-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214311

--- Comment #1 from Jarek (jarek@poczta.srv.pl) ---
The problem happens only when Boot option is set to BIOS. With UEFI boot,
kernel 5.10.0 detects disks properly. Kernel 4.19 detects disks in both cas=
es.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
