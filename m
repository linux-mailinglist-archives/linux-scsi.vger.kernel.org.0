Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DC3393E2
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Mar 2021 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhCLQuk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Mar 2021 11:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhCLQuf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 12 Mar 2021 11:50:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 349946500F
        for <linux-scsi@vger.kernel.org>; Fri, 12 Mar 2021 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615567835;
        bh=3lfLWq1ux1ulxP0hdoaAKRfx+RzFzIsLpb12XaIFPAo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qBaSQk+V4DgGzJzGwtZ4hDsE9lOngvDtfUXmcCiJS2fryssttOmSPTlnzxy4pJn8m
         4X8mEeiOmcNcGzDVWkMReFfzdiKdwIo/sDxfzH92i709ml/F9ClfS+5/SFutQIIu3s
         ZS3I8arjy5Uciz0dVI/BARLXh1DspC64teCsITs1Aovf4LUl5gXLKRhfc3lFLzlNL5
         ZRjnlw0lccp3sCoVa7j+0kcZMmPNlWW2uY3qc4QfdgosXp/xQ3+RPIJh8ZasNF5QU3
         MfJX1YyhLvUSdb2xNeZbcoJ5PLX4gjvAtiHZF1S19ENqAXMwpUfxssgA3CbSi3s8h8
         d9wQWIGW+BR2A==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 22A8665369; Fri, 12 Mar 2021 16:50:35 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 212183] st read statistics inaccurate when requested and
 physical block mismatch
Date:   Fri, 12 Mar 2021 16:50:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: etienne.mollier@cgg.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-212183-11613-vAeiNK2KlZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-212183-11613@https.bugzilla.kernel.org/>
References: <bug-212183-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212183

=C3=89tienne Mollier (etienne.mollier@cgg.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #295769|0                           |1
        is obsolete|                            |

--- Comment #2 from =C3=89tienne Mollier (etienne.mollier@cgg.com) ---
Created attachment 295817
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295817&action=3Dedit
st.c patch stats when blocks size mismatch while SILI set

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
