Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89F58BA08
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Aug 2019 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfHMNXy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Aug 2019 09:23:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54352 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfHMNXy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Aug 2019 09:23:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hxWmD-00057b-DS; Tue, 13 Aug 2019 13:23:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fnic: remove redundant assignment of variable rc
Date:   Tue, 13 Aug 2019 14:23:49 +0100
Message-Id: <20190813132349.8720-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is initialized to a value that is never read and it is
re-assigned later and immediatetly returns. Clean up the code by
removing rc and just returning 0.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/fnic/fnic_debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 21991c99db7c..13f7d88d6e57 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -52,7 +52,6 @@ static struct fc_trace_flag_type *fc_trc_flag;
  */
 int fnic_debugfs_init(void)
 {
-	int rc = -1;
 	fnic_trace_debugfs_root = debugfs_create_dir("fnic", NULL);
 
 	fnic_stats_debugfs_root = debugfs_create_dir("statistics",
@@ -70,8 +69,7 @@ int fnic_debugfs_init(void)
 		fc_trc_flag->fc_clear = 4;
 	}
 
-	rc = 0;
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.20.1

