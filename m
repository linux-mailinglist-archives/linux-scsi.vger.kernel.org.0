Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F316BC02CA
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Sep 2019 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfI0J6r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Sep 2019 05:58:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34826 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfI0J6r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 27 Sep 2019 05:58:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iDn1M-0001I0-9J; Fri, 27 Sep 2019 09:58:40 +0000
From:   Colin King <colin.king@canonical.com>
To:     Don Brace <don.brace@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: smartpqi: clean up an indentation issue
Date:   Fri, 27 Sep 2019 10:58:40 +0100
Message-Id: <20190927095840.26377-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are some statements that are indented too deeply, remove
the extraneous tabs and rejoin split lines.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ea5409bebf57..be496d63aea3 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2172,13 +2172,10 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 				REPORT_PHYS_LUN_DEV_FLAG_AIO_ENABLED) &&
 				phys_lun_ext_entry->aio_handle) {
 				device->aio_enabled = true;
-					device->aio_handle =
-						phys_lun_ext_entry->aio_handle;
+				device->aio_handle =
+					phys_lun_ext_entry->aio_handle;
 			}
-
-				pqi_get_physical_disk_info(ctrl_info,
-					device, id_phys);
-
+			pqi_get_physical_disk_info(ctrl_info, device, id_phys);
 		} else {
 			memcpy(device->volume_id, log_lun_ext_entry->volume_id,
 				sizeof(device->volume_id));
-- 
2.20.1

