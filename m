Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72D428EAE6
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Oct 2020 04:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgJOCH4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Oct 2020 22:07:56 -0400
Received: from smtp.infotech.no ([82.134.31.41]:40282 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732569AbgJOCHq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 14 Oct 2020 22:07:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 9FE39204248;
        Thu, 15 Oct 2020 04:07:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IYHdj-QnS1DY; Thu, 15 Oct 2020 04:07:40 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 5BA97204255;
        Thu, 15 Oct 2020 04:07:34 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v11 44/44] sg: bump version to 4.0.11
Date:   Wed, 14 Oct 2020 22:06:43 -0400
Message-Id: <20201015020643.432908-45-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015020643.432908-1-dgilbert@interlog.com>
References: <20201015020643.432908-1-dgilbert@interlog.com>
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
index 770e8c1ef53e..3a434b067b5c 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -7,13 +7,14 @@
  *
  * Original driver (sg.c):
  *        Copyright (C) 1992 Lawrence Foard
- * Version 2 and 3 extensions to driver:
- *        Copyright (C) 1998 - 2019 Douglas Gilbert
+ * Version 2, 3 and 4 extensions to driver:
+ *        Copyright (C) 1998 - 2020 Douglas Gilbert
+ *
  */
 
-static int sg_version_num = 30901;  /* [x]xyyzz where [x] empty when x=0 */
-#define SG_VERSION_STR "3.9.01"		/* [x]x.[y]y.zz */
-static char *sg_version_date = "20190606";
+static int sg_version_num = 40011;  /* [x]xyyzz where [x] empty when x=0 */
+#define SG_VERSION_STR "4.0.11"		/* [x]x.[y]y.zz */
+static char *sg_version_date = "20201014";
 
 #include <linux/module.h>
 
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index cbade2870355..72574ab0a7b3 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -12,9 +12,9 @@
  *   Copyright (C) 1992 Lawrence Foard
  *
  * Later extensions (versions 2, 3 and 4) to driver:
- *   Copyright (C) 1998 - 2018 Douglas Gilbert
+ *   Copyright (C) 1998 - 2020 Douglas Gilbert
  *
- * Version 4.0.11 (20190502)
+ * Version 4.0.09 (20200618)
  *  This version is for Linux 4 and 5 series kernels.
  *
  * Documentation
-- 
2.25.1

