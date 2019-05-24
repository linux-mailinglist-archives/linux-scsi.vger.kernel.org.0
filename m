Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258D929E67
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403773AbfEXSsr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:47 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56446 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391167AbfEXSsr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B535A204170;
        Fri, 24 May 2019 20:48:44 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 33AEue6sCTm8; Fri, 24 May 2019 20:48:43 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id DCD73204197;
        Fri, 24 May 2019 20:48:33 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 19/19] sg: table of error numbers with meanings
Date:   Fri, 24 May 2019 14:48:09 -0400
Message-Id: <20190524184809.25121-20-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
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
 drivers/scsi/sg.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d048c1f371ce..4fee90cca852 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -389,6 +389,48 @@ static void sg_rep_rq_state_fail(struct sg_device *sdp,
 #define SG_LOG(depth, sdp, fmt, a...)
 #endif	/* end of CONFIG_SCSI_LOGGING && SG_DEBUG conditional */
 
+/*
+ * Unless otherwise noted, functions that return int will return 0 for
+ * good/successful or a negated errno value. Here is list of errno_s generated
+ * by this driver:
+ *
+ * E2BIG    sum(dlen) > tot_fd_thresh ; slave dxfer_len > master dxfer_len
+ * EACCES   user (process) does not have sufficient privilege or capabilities
+ * EADDRINUSE	sharing: slave file descriptor already in share
+ * EADDRNOTAVAIL   sharing: master file descriptor already in share
+ *		   slave request but no preceding master request
+ * EAGAIN   [aka EWOULDBLOCK]; occurs when O_NONBLOCK set on open() or
+ *	    SGV4_FLAG_IMMED given, and SG_IORECEIVE (or read(2)) not ready
+ * EBUSY    'Device or resource busy'; this uses open(O_NONBLOCK) but another
+ *	    has open(O_EXCL); reserve request in use (e.g. when mmap() called)
+ * EDOM     numerical error, command queueing false and second command
+ *	    attempted when one already outstanding
+ * EFAULT   problem moving data to or from user space
+ * EIDRM    block request unexpectedly missing
+ * EINTR    interrupted system call (generated by kernel, not this driver)
+ * EINVAL   flags or other input information contradicts or disallowed
+ * EIO      only kept for backward compatibility, too generic to be useful
+ * ELOOP    sharing: file descriptor can't share with itself
+ * EMSGSIZE    cdb too long (> 252 bytes) or too short (less than 6 bytes)
+ * ENODATA  sharing: no data xfer requested; mmap or direct io problem
+ *          SG_IOABORT: no match on pack_id or tag; mrq: no active reqs
+ * ENODEV   target (SCSI) device associated with the fd has "disappeared"
+ * ENOMEM   obvious; could be some pre-allocated cache that is full
+ * ENOMSG   data transfer setup needed or (direction) disallowed (sharing)
+ * ENOSTR   slave request abandoned due to master error or state
+ * ENOTSOCK   sharing: file descriptor for sharing unassociated with sg driver
+ * ENXIO    'no such device or address' SCSI mid-level processing errors
+ *          (e.g. command timeouts); also sg info not in 'file' struct
+ * EPERM    not permitted (even if has ACCES); v1+2,v3,v4 interface usage
+ *	    violation, opened read-only but SCSI command not listed read-only
+ * EPROTO   logic error (in driver); like "shouldn't get here"
+ * EPROTOTYPE    atomic state change failed unexpectedly
+ * ERANGE   multiple requests: usually bad flag values
+ * ERESTARTSYS   should not be seen in user space, associated with an
+ *		 interruptable wait; will restart system call or give EINTR
+ * EWOULDBLOCK   [aka EAGAIN]; additionally if the 'more async' flag is set
+ *		 SG_IOSUBMIT may yield this error
+ */
 
 /*
  * The SCSI interfaces that use read() and write() as an asynchronous variant of
-- 
2.17.1

