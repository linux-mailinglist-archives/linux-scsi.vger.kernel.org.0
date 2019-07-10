Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C6A63F88
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 05:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGJDJg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 9 Jul 2019 23:09:36 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:60328 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbfGJDJf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 23:09:35 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4BD0A28913
        for <linux-scsi@vger.kernel.org>; Wed, 10 Jul 2019 03:09:34 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 3F8A128917; Wed, 10 Jul 2019 03:09:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-scsi@vger.kernel.org
Subject: [Bug 204119] scsi_mod: Could not allocate 4104 bytes percpu data
Date:   Wed, 10 Jul 2019 03:09:32 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204119-11613-Vk6aHkxTQA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204119-11613@https.bugzilla.kernel.org/>
References: <bug-204119-11613@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=204119

--- Comment #6 from Bart Van Assche (bvanassche@acm.org) ---
The "size=4104" in the error message probably refers to the SCSI log buffer.
From drivers/scsi/scsi_logging.c:

#define SCSI_LOG_SPOOLSIZE 4096
struct scsi_log_buf {
        char buffer[SCSI_LOG_SPOOLSIZE];
        unsigned long map;
};
static DEFINE_PER_CPU(struct scsi_log_buf, scsi_format_log);

I am not aware of any changes between kernel versions v5.1 and v5.2 in the SCSI
logging mechanism so I don't think that this indicates a regression in the SCSI
subsystem. Anyway, does this patch help?

diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index 39b8cc4574b4..148d8635d5f6 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -15,7 +15,7 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_dbg.h>

-#define SCSI_LOG_SPOOLSIZE 4096
+#define SCSI_LOG_SPOOLSIZE SCSI_LOG_BUFSIZE

 #if (SCSI_LOG_SPOOLSIZE / SCSI_LOG_BUFSIZE) > BITS_PER_LONG
 #warning SCSI logging bitmask too large

-- 
You are receiving this mail because:
You are the assignee for the bug.
