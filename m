Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05734478C5
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 05:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfFQDkF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 23:40:05 -0400
Received: from smtp.infotech.no ([82.134.31.41]:37819 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfFQDkF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 16 Jun 2019 23:40:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 5BF092041D4
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 05:40:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iCuvWWv9YiJ3 for <linux-scsi@vger.kernel.org>;
        Mon, 17 Jun 2019 05:40:03 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 00B34204247
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 05:39:49 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Subject: [PATCH 18/18] sg: bump version to 4.0.03
Date:   Sun, 16 Jun 2019 23:39:34 -0400
Message-Id: <20190617033934.5051-19-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617033934.5051-1-dgilbert@interlog.com>
References: <20190617033934.5051-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
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
two lists: one for active (inflight) requests and a free
list. Also sg_requests objects are not freed until the
owning file descriptor is closed; rather these objects
are re-used when multiple commands are sent to the same
file descriptor.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0d93c6a92978..06e29e5f9f48 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -12,9 +12,9 @@
  *
  */
 
-static int sg_version_num = 30901;  /* [x]xyyzz where [x] empty when x=0 */
-#define SG_VERSION_STR "3.9.01"		/* [x]x.[y]y.zz */
-static char *sg_version_date = "20190606";
+static int sg_version_num = 40003;  /* [x]xyyzz where [x] empty when x=0 */
+#define SG_VERSION_STR "4.0.03"		/* [x]x.[y]y.zz */
+static char *sg_version_date = "20190612";
 
 #include <linux/module.h>
 
-- 
2.17.1

