Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5541FC9A1
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2020 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgFQJRV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Wed, 17 Jun 2020 05:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgFQJRU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 05:17:20 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 208215] HPSA P410 resetting logical Direct-Access never
 complete 5.7.1
Date:   Wed, 17 Jun 2020 09:17:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: voronkovaa@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-208215-11613-5H5nnPBGpJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208215-11613@https.bugzilla.kernel.org/>
References: <bug-208215-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208215

Andrey Voronkov (voronkovaa@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |Intel

--- Comment #1 from Andrey Voronkov (voronkovaa@gmail.com) ---
Seems like related: https://bugzilla.kernel.org/show_bug.cgi?id=199435

-- 
You are receiving this mail because:
You are the assignee for the bug.
