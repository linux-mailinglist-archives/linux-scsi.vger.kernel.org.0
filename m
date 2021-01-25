Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590CA301FF4
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 02:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAYBeX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Jan 2021 20:34:23 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45801 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbhAYBcl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 24 Jan 2021 20:32:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 9E08E20426F;
        Mon, 25 Jan 2021 02:27:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T1KFQ2gxGO3z; Mon, 25 Jan 2021 02:27:56 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id DAB3C2042B4;
        Mon, 25 Jan 2021 02:27:45 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com
Subject: [PATCH v14 45/45] sg: bump version to 4.0.12
Date:   Sun, 24 Jan 2021 20:26:50 -0500
Message-Id: <20210125012650.269411-46-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125012650.269411-1-dgilbert@interlog.com>
References: <20210125012650.269411-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Now that the sg version 4 interface is supported:
  - with ioctl(SG_IO) for synchronous/blocking use
  - with ioctl(SG_IOSUBMIT) and ioctl(SG_IORECEIVE) for
    async/non-blocking use
Plus new ioctl(SG_IOSUBMIT_V3) and ioctl(SG_IORECEIVE_V3)
potentially replace write() and read() for the sg
version 3 interface. Bump major driver version number
from 3 to 4.

The main new feature is the removal of the fixed 16 element
array of requests per file descriptor. It is replaced by
a xarray (eXtensible array) in their parent which is a
sg_fd object (i.e. a file descriptor). The sg_request
objects are not freed until the owning file descriptor is
closed; instead these objects are re-used when multiple
commands are sent to the same file descriptor.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 11 ++++++-----
 include/uapi/scsi/sg.h |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 1f00f13ba8fe..49746024ac21 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -7,13 +7,14 @@
  *
  * Original driver (sg.c):
  *        Copyright (C) 1992 Lawrence Foard
- * Version 2 and 3 extensions to driver:
- *        Copyright (C) 1998 - 2019 Douglas Gilbert
+ * Version 2, 3 and 4 extensions to driver:
+ *        Copyright (C) 1998 - 2021 Douglas Gilbert
+ *
  */
 
-static int sg_version_num = 30901;  /* [x]xyyzz where [x] empty when x=0 */
-#define SG_VERSION_STR "3.9.01"		/* [x]x.[y]y.zz */
-static char *sg_version_date = "20190606";
+static int sg_version_num = 40012;  /* [x]xyyzz where [x] empty when x=0 */
+#define SG_VERSION_STR "4.0.12"		/* [x]x.[y]y.zz */
+static char *sg_version_date = "20210124";
 
 #include <linux/module.h>
 
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 11b58b279241..33109f3d5ed3 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -12,9 +12,9 @@
  *   Copyright (C) 1992 Lawrence Foard
  *
  * Later extensions (versions 2, 3 and 4) to driver:
- *   Copyright (C) 1998 - 2018 Douglas Gilbert
+ *   Copyright (C) 1998 - 2021 Douglas Gilbert
  *
- * Version 4.0.11 (20190502)
+ * Version 4.0.12 (20210111)
  *  This version is for Linux 4 and 5 series kernels.
  *
  * Documentation
-- 
2.25.1

