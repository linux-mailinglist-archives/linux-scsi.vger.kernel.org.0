Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31881BF248
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Sep 2019 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfIZL5V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Sep 2019 07:57:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54615 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfIZL5V (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Sep 2019 07:57:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iDSOa-00070U-GG; Thu, 26 Sep 2019 11:57:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: csiostor: clean up indentation issue
Date:   Thu, 26 Sep 2019 12:57:16 +0100
Message-Id: <20190926115716.3698-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The goto statement is indented incorrectly, remove the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/csiostor/csio_mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_mb.c
index 6f13673d6aa0..94810b19e747 100644
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -1210,7 +1210,7 @@ csio_mb_issue(struct csio_hw *hw, struct csio_mb *mbp)
 		   !csio_is_hw_intr_enabled(hw)) {
 		csio_err(hw, "Cannot issue mailbox in interrupt mode 0x%x\n",
 			 *((uint8_t *)mbp->mb));
-			goto error_out;
+		goto error_out;
 	}
 
 	if (mbm->mcurrent != NULL) {
-- 
2.20.1

