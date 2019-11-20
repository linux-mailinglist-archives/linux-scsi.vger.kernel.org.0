Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F686103C97
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Nov 2019 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfKTNum (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Nov 2019 08:50:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42757 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfKTNum (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 Nov 2019 08:50:42 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iXQNL-0008NI-Na; Wed, 20 Nov 2019 13:50:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Deepak Ukey <Deepak.Ukey@microchip.com>,
        Viswas G <Viswas.G@microchip.com>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: pm80xx: fix logic to break out of loop when register value is 2 or 3
Date:   Wed, 20 Nov 2019 13:50:31 +0000
Message-Id: <20191120135031.270708-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The condition (reg_val != 2) || (reg_val != 3) will always be true because
reg_val cannot be equal to two different values at the same time. Fix this
by replacing the || operator with && so that the loop will loop if reg_val
is not a 2 and not a 3 as was originally intended.

Addresses-Coverity: ("Constant expression result")
Fixes: 50dc2f221455 ("scsi: pm80xx: Modified the logic to collect fatal dump")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 19601138e889..d41908b23760 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -348,7 +348,7 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 			do {
 				reg_val = pm8001_mr32(fatal_table_address,
 					MPI_FATAL_EDUMP_TABLE_STATUS);
-			} while (((reg_val != 2) || (reg_val != 3)) &&
+			} while (((reg_val != 2) && (reg_val != 3)) &&
 					time_before(jiffies, start));
 
 			if (reg_val < 2) {
-- 
2.24.0

