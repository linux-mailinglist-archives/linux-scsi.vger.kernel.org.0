Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274571E6AFB
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2020 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406560AbgE1T3t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Thu, 28 May 2020 15:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406224AbgE1T3s (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 28 May 2020 15:29:48 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 207877] ASMedia drive (174c:55aa) hangs in ioctl
 CDROM_DRIVE_STATUS when mounting a DVD
Date:   Thu, 28 May 2020 19:29:47 +0000
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
Message-ID: <bug-207877-11613-XtPwadjrcG@https.bugzilla.kernel.org/>
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

--- Comment #5 from Zebediah Figura (zfigura@codeweavers.com) ---
Created attachment 289389
  --> https://bugzilla.kernel.org/attachment.cgi?id=289389&action=edit
dmesg (from journalctl -k) including backtrace of hang and usb-storage
debugging

More testing, in response to questions/instructions from the mailing list.

Sometimes mount hangs forever in openat instead. I guess probably some kernel
thread is getting stuck for reasons not directly related to mount, and mount is
hanging as a result.

I built with 5.7-rc7 and CONFIG_USB_STORAGE_DEBUG enabled. I got a hang in
openat; I've attached kernel logs. usbmon shows a similar bulk input transfer
which never completes (even after waiting several minutes); I can attach that
output if it's helpful.

-- 
You are receiving this mail because:
You are the assignee for the bug.
