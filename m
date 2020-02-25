Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502FC16B9B0
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Feb 2020 07:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgBYGYS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Feb 2020 01:24:18 -0500
Received: from smtp.infotech.no ([82.134.31.41]:36169 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbgBYGYS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 Feb 2020 01:24:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id C27EC2041F1;
        Tue, 25 Feb 2020 07:24:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HC4he9-KD8nr; Tue, 25 Feb 2020 07:24:15 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 0C168204269;
        Tue, 25 Feb 2020 07:24:13 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v4 14/14] scsi_debug: bump to version 1.89
Date:   Tue, 25 Feb 2020 01:23:51 -0500
Message-Id: <20200225062351.21267-15-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225062351.21267-1-dgilbert@interlog.com>
References: <20200225062351.21267-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The scsi_debug driver version is visible in:
   /sys/modules/scsi_debug/version
and can thus be used by user space programs to alter the
features they try to use. Since the doublestore option is
a significant addition, bump the version number which
will appear as 0189 when the above file is read.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 8530bc54b575..2e7837a86682 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7,7 +7,7 @@
  *  anything out of the ordinary is seen.
  * ^^^^^^^^^^^^^^^^^^^^^^^ Original ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  *
- * Copyright (C) 2001 - 2018 Douglas Gilbert
+ * Copyright (C) 2001 - 2020 Douglas Gilbert
  *
  *  For documentation see http://sg.danny.cz/sg/sdebug26.html
  */
@@ -58,8 +58,8 @@
 #include "scsi_logging.h"
 
 /* make sure inq_product_rev string corresponds to this version */
-#define SDEBUG_VERSION "0188"	/* format to fit INQUIRY revision field */
-static const char *sdebug_version_date = "20190125";
+#define SDEBUG_VERSION "0189"	/* format to fit INQUIRY revision field */
+static const char *sdebug_version_date = "20200225";
 
 #define MY_NAME "scsi_debug"
 
-- 
2.25.1

