Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684FA1BE2F8
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2020 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgD2PlA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Apr 2020 11:41:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35756 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgD2PlA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 Apr 2020 11:41:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jTopT-0004nr-Du; Wed, 29 Apr 2020 15:40:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pm80xx: remove redundant assignments to status
Date:   Wed, 29 Apr 2020 16:40:55 +0100
Message-Id: <20200429154055.286617-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable status is being assigned with a value that is never read
hence the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 4d205ebaee87..f5e36375a68f 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -235,7 +235,6 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 			pm8001_ha->forensic_fatal_step = 1;
 			pm8001_ha->fatal_forensic_shift_offset = 0;
 			pm8001_ha->forensic_last_offset	= 0;
-			status = 0;
 			offset = (int)
 			((char *)pm8001_ha->forensic_info.data_buf.direct_data
 			- (char *)buf);
@@ -258,7 +257,6 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 					forensic_info.data_buf.direct_data,
 					"%08x ", *(temp + index));
 			}
-			status = 0;
 			offset = (int)
 			((char *)pm8001_ha->forensic_info.data_buf.direct_data
 			- (char *)buf);
@@ -285,7 +283,6 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 		pm8001_cw32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER,
 			pm8001_ha->fatal_forensic_shift_offset);
 		pm8001_ha->fatal_bar_loc = 0;
-		status = 0;
 		offset = (int)
 			((char *)pm8001_ha->forensic_info.data_buf.direct_data
 			- (char *)buf);
-- 
2.25.1

