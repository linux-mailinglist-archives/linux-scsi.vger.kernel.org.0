Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8968A1E03FA
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2020 01:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgEXXsI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sun, 24 May 2020 19:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388198AbgEXXsI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 24 May 2020 19:48:08 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-scsi@vger.kernel.org
Subject: [Bug 207877] ASMedia drive (174c:55aa) hangs in ioctl
 CDROM_DRIVE_STATUS when mounting a DVD
Date:   Sun, 24 May 2020 23:48:07 +0000
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
Message-ID: <bug-207877-11613-eCEUzvbiLc@https.bugzilla.kernel.org/>
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

--- Comment #3 from Bart Van Assche (bvanassche@acm.org) ---
I think there are fewer processes involved in the v5.7-rc6 hang. Anyway, please
report this on the appropriate USB mailing list. It seems to me that the
following USB code is involved in the hang:

static int device_reset(struct scsi_cmnd *srb)
{
        struct us_data *us = host_to_us(srb->device->host);
        int result;

        usb_stor_dbg(us, "%s called\n", __func__);

        /* lock the device pointers and do the reset */
        mutex_lock(&(us->dev_mutex));
        result = us->transport_reset(us);
        mutex_unlock(&us->dev_mutex);

        return result < 0 ? FAILED : SUCCESS;
}

and also

static int usb_stor_control_thread(void * __us)
{
                [ ... ]
                mutex_lock(&(us->dev_mutex));
                [ ... ]
                        fill_inquiry_response(us, data_ptr, 36);
                [ ... ]
                mutex_unlock(&us->dev_mutex);
                [ ... ]
}

The following mailing list may be appropriate:

usb-storage@lists.one-eyed-alien.net

-- 
You are receiving this mail because:
You are the assignee for the bug.
