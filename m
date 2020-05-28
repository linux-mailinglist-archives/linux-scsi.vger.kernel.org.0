Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41C1E6769
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2020 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404861AbgE1Q2e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Thu, 28 May 2020 12:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404986AbgE1Q2d (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 28 May 2020 12:28:33 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 207877] ASMedia drive (174c:55aa) hangs in ioctl
 CDROM_DRIVE_STATUS when mounting a DVD
Date:   Thu, 28 May 2020 16:28:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zfigura@codeweavers.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-207877-11613-Lkrkmu0OER@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207877-11613@https.bugzilla.kernel.org/>
References: <bug-207877-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207877

--- Comment #4 from Zebediah Figura (zfigura@codeweavers.com) ---
Created attachment 289385
  --> https://bugzilla.kernel.org/attachment.cgi?id=289385&action=edit
usbmon trace

Attaching a usbmon trace including the hang. The drive is bus 1, device 3. The
last bulk input submission apparently never receives a response (I watched it
for a while, and after several minutes it was still stuck on the last line.)

Is this a sign of a broken device?

Even if it is, is the kernel mishandling this by hanging forever? (I'd be
inclined to say yes, but maybe there's only so much the kernel can do with
broken devices...)

-- 
You are receiving this mail because:
You are the assignee for the bug.
