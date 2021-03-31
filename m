Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B4734BA1B
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Mar 2021 00:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhC0XHE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 27 Mar 2021 19:07:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47947 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhC0XGz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 27 Mar 2021 19:06:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lQI14-0005Si-Vr; Sat, 27 Mar 2021 23:06:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedi: emove redundant assignment to variable err
Date:   Sat, 27 Mar 2021 23:06:50 +0000
Message-Id: <20210327230650.25803-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

variable err is assigned -ENOMEM followed by an error return path
via label err_udev that does not access the variable and returns
with the -ENOMEM error return code. The assignment to err is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qedi/qedi_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 69c5b5ee2169..2455d1448a7e 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -276,10 +276,8 @@ static int qedi_alloc_uio_rings(struct qedi_ctx *qedi)
 	}
 
 	udev = kzalloc(sizeof(*udev), GFP_KERNEL);
-	if (!udev) {
-		rc = -ENOMEM;
+	if (!udev)
 		goto err_udev;
-	}
 
 	udev->uio_dev = -1;
 
-- 
2.30.2

