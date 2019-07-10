Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBAD64659
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGJMi5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 08:38:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:6467 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJMi5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 10 Jul 2019 08:38:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="173853055"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2019 05:38:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1ED4D12C; Wed, 10 Jul 2019 15:38:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] scsi: scsi_debug: Use for_each_set_bit to simplify code
Date:   Wed, 10 Jul 2019 15:38:54 +0300
Message-Id: <20190710123854.31012-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We can use for_each_set_bit() to slightly simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/scsi/scsi_debugfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_debugfs.c b/drivers/scsi/scsi_debugfs.c
index c5a8756384bc..c19ea7ab54cb 100644
--- a/drivers/scsi/scsi_debugfs.c
+++ b/drivers/scsi/scsi_debugfs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
 #include <linux/seq_file.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
@@ -18,9 +19,7 @@ static int scsi_flags_show(struct seq_file *m, const unsigned long flags,
 	bool sep = false;
 	int i;
 
-	for (i = 0; i < sizeof(flags) * BITS_PER_BYTE; i++) {
-		if (!(flags & BIT(i)))
-			continue;
+	for_each_set_bit(i, &flags, BITS_PER_LONG) {
 		if (sep)
 			seq_puts(m, "|");
 		sep = true;
-- 
2.20.1

