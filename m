Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2170136CE54
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 23:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhD0WAl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 18:00:41 -0400
Received: from smtp.infotech.no ([82.134.31.41]:39003 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239438AbhD0WAQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 18:00:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 700CD204295;
        Tue, 27 Apr 2021 23:59:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Y0ZIaFEsKb9; Tue, 27 Apr 2021 23:59:28 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id 98F3D20429C;
        Tue, 27 Apr 2021 23:59:27 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v18 73/83] sg: table of error number explanations
Date:   Tue, 27 Apr 2021 17:57:23 -0400
Message-Id: <20210427215733.417746-75-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427215733.417746-1-dgilbert@interlog.com>
References: <20210427215733.417746-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Rather than having a piece of paper recording which errno
values have been used for what, the author thought why not
place then in one table in the driver code.

As a guesstimate, over half the code in this driver is dedicated
to sanity checking and reporting errors. Those errors may come
from the host machine, the SCSI HBA or its associated hardware,
or the transport or the storage device. For near end errors
some creative license is taken with errno values (e.g.
ENOTSOCK) to convey a better sense of what this driver is
objecting to.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d030f7c43bf0..c4421a426045 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -453,6 +453,50 @@ static void sg_take_snap(struct sg_fd *sfp, bool clear_first);
 #define SG_LOG(depth, sfp, fmt, a...) do { } while (0)
 #endif	/* end of CONFIG_SCSI_LOGGING && SG_DEBUG conditional */
 
+/*
+ * Unless otherwise noted, functions that return int will return 0 for successful or a
+ * negated errno value. Here is list of errno_s generated by this driver:
+ *
+ * E2BIG	sum(dlen) > tot_fd_thresh ; write-side dxfer_len > read-side dxfer_len
+ * EACCES	user (process) does not have sufficient privilege or capabilities
+ * EADDRINUSE	sharing: write-side file descriptor already in share
+ * EADDRNOTAVAIL   sharing: read-side file descriptor already in share
+ *		   write-side request but no preceding read-side request
+ * EAGAIN	[aka EWOULDBLOCK]; occurs when O_NONBLOCK set on open() or
+ *		SGV4_FLAG_IMMED given, and SG_IORECEIVE (or read(2)) not ready
+ * EBADF	user provided fd to sg_fd_share() or sg_fd_reshare() is bad
+ * EBADFD	SG_FLAG_MMAP_IO given but no mmap() active
+ * EBUSY	'Device or resource busy'; this uses open(O_NONBLOCK) but another
+ *		has open(O_EXCL); reserve request in use (e.g. when mmap() called)
+ * EDOM		numerical error, command queueing false and second command
+ *		attempted when one already outstanding, mrq pack_id
+ * EFAULT	problem moving data to or from user space
+ * EFBIG	too many reserve requests on this file descriptor
+ * EINTR	interrupted system call (generated by kernel, not this driver)
+ * EINVAL	flags or other input information contradicts or disallowed
+ * EIO		only kept for backward compatibility, too generic to be useful
+ * ELOOP	sharing: file descriptor can't share with itself
+ * EMSGSIZE	cdb too long (> 252 bytes) or too short (less than 6 bytes)
+ * ENODATA	sharing: no data xfer requested; mmap or direct io problem
+ *		SG_IOABORT: no match on pack_id or tag; mrq: no active reqs
+ * ENODEV	target (SCSI) device associated with the fd has "disappeared"
+ * ENOMEM	obvious; could be some pre-allocated cache that is exhausted
+ * ENOMSG	data transfer setup needed or (direction) disallowed (sharing)
+ * ENOSTR	write-side request abandoned due to read-side error or state
+ * ENOTSOCK	sharing: file descriptor for sharing unassociated with sg driver
+ * ENXIO	'no such device or address' SCSI mid-level processing errors
+ *		(e.g. command timeouts); also sg info not in 'file' struct
+ * EPERM	not permitted (even if has ACCES); v1+2,v3,v4 interface usage
+ *		violation, opened read-only but SCSI command not listed read-only
+ * EPROTO	logic error (in driver); like "shouldn't get here"
+ * EPROTOTYPE	atomic state change failed unexpectedly
+ * ERANGE	multiple requests: usually bad flag values
+ * ERESTARTSYS	should not be seen in user space, associated with an
+ *		interruptable wait; will restart system call or give EINTR
+ * EWOULDBLOCK	[aka EAGAIN]; additionally if the 'more async' flag is set
+ *		SG_IOSUBMIT may yield this error
+ */
+
 /*
  * The SCSI interfaces that use read() and write() as an asynchronous variant of
  * ioctl(..., SG_IO, ...) are fundamentally unsafe, since there are lots of ways
-- 
2.25.1

