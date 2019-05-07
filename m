Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3D165D8
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 16:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEGOgk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 7 May 2019 10:36:40 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:49630 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbfEGOgj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 10:36:39 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EE832288F6
        for <linux-scsi@vger.kernel.org>; Tue,  7 May 2019 14:36:38 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id E05BB288C7; Tue,  7 May 2019 14:36:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 199435] HPSA + P420i resetting logical Direct-Access never
 complete
Date:   Tue, 07 May 2019 14:36:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: don.brace@microsemi.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-199435-11613-xB8FHmWhjV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199435-11613@https.bugzilla.kernel.org/>
References: <bug-199435-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=199435

--- Comment #34 from Don (don.brace@microsemi.com) ---
(In reply to Anthony Hausman from comment #33)
> Hi Don,
> 
> Did you send it to kernel.org?
> Any idea when the patch will be available in the kernel?
> 
> Is the patch compatible with the last kernel longterm release 4.19?
> 
> Thanks in advance for your response.

I will be sending the patch up today.

It will apply if all of the patches I am sending up are applied. 
Otherwise it will have to have some minor porting done to have it applied.

The patches I am sending up are:

hpsa-correct-simple-mode
hpsa-use-local-workqueues-instead-of-system-workqueues
hpsa-check-for-tag-collision
hpsa-wait-longer-for-ptraid-commands
hpsa-do-not-complete-cmds-for-deleted-devices
hpsa-correct-device-resets
hpsa-update-driver-version

-- 
You are receiving this mail because:
You are the assignee for the bug.
