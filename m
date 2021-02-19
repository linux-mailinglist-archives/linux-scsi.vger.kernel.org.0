Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93931FEED
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Feb 2021 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBSSpM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Feb 2021 13:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhBSSpI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 19 Feb 2021 13:45:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2184764E4B
        for <linux-scsi@vger.kernel.org>; Fri, 19 Feb 2021 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613760268;
        bh=Mx3DafmADZv8Esj0lXVq1x9W9UV7DI3fQzYOyc8/xks=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NOkVphgcJsjrysvMsIkg3rKI2gJ059dJ+GbsxpNJLTcyymFZa/0Unf3qwmq1TCpSu
         N5Uy75HyXBI3+m4myRx0PnuAxCtqU83ZhjySxbMwDSkFv4KBrlBBN7fGJGHLMCoOAU
         i2jQfjYt9xk8YF6IKK/6qX1lMDUL/dUqCYNfmPDsbHYSEE46Jrlt6lwO5OkrlKrb6f
         MtRsSREQE481WyQLunzAkwqPXSQMNcMcnEvY1l999raqXeJCTZofj1iI7JmBc6BI8E
         Mtoo6QhPIvqXdV/KijDet8TGdOHbyRrhv21NZgd2rIh1NKpZD4qveHHHW586Rn6Cf+
         8Qul/umW5GMLg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 1B50D6533C; Fri, 19 Feb 2021 18:44:28 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 211227] [BISECTED][REGRESSION] Linux 5.10.7 breaks s3 resume on
 opal encrypted ssd
Date:   Fri, 19 Feb 2021 18:44:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bvanassche@acm.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-211227-11613-R9i6Vpxa61@https.bugzilla.kernel.org/>
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

--- Comment #2 from Bart Van Assche (bvanassche@acm.org) ---
Created attachment 295369
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295369&action=3Dedit
Debug patch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
