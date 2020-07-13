Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3F21E07E
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2020 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGMTKy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Mon, 13 Jul 2020 15:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMTKx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 Jul 2020 15:10:53 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 207855] arcconf host reset causes kernel panic -> driver crash?
Date:   Mon, 13 Jul 2020 19:10:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: janpieter.sollie@edpnet.be
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207855-11613-5KMVQPmEla@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207855-11613@https.bugzilla.kernel.org/>
References: <bug-207855-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207855

--- Comment #10 from Janpieter Sollie (janpieter.sollie@edpnet.be) ---
I just verified: the device was mostly dead:no F12 to enter kernel log, no num
lock answer by kb led, but still replying to ping...
I currently locked the screen on tty12, so next time I *should* be able to see
something

-- 
You are receiving this mail because:
You are the assignee for the bug.
