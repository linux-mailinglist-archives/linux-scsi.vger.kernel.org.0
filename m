Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732CB25FAA
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 10:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfEVIjJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 May 2019 04:39:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44529 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfEVIjJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 May 2019 04:39:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hTMm8-0000oM-41; Wed, 22 May 2019 08:39:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Don Brace <don.brace@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: hpsa: fix an uninitialized read and dereference of pointer dev
Date:   Wed, 22 May 2019 09:39:03 +0100
Message-Id: <20190522083903.18849-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check for a lockup_detected failure exits via the
label return_reset_status that reads and dereferences an uninitialized
pointer dev.  Fix this by ensuring dev is inintialized to null.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: 14991a5bade5 ("scsi: hpsa: correct device resets")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/hpsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c560a4532733..ac8338b0571b 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5947,7 +5947,7 @@ static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd)
 	int rc = SUCCESS;
 	int i;
 	struct ctlr_info *h;
-	struct hpsa_scsi_dev_t *dev;
+	struct hpsa_scsi_dev_t *dev = NULL;
 	u8 reset_type;
 	char msg[48];
 	unsigned long flags;
-- 
2.20.1

