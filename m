Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96651A431D
	for <lists+linux-scsi@lfdr.de>; Sat, 31 Aug 2019 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfHaHjK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 31 Aug 2019 03:39:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50284 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfHaHjK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 31 Aug 2019 03:39:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i3xyR-0000sR-QR; Sat, 31 Aug 2019 07:39:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Don Brace <don.brace@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][smartpqi-next] scsi: smartpqi: clean up indentation of a statement
Date:   Sat, 31 Aug 2019 08:39:03 +0100
Message-Id: <20190831073903.7834-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that is indented one level too deeply, remove
the tab, re-join broken line and remove some empty lines.

Addresses-Coverity: ("Indentation does not match nesting")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ea5409bebf57..652d48224942 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2175,10 +2175,7 @@ static int pqi_update_scsi_devices(struct pqi_ctrl_info *ctrl_info)
 					device->aio_handle =
 						phys_lun_ext_entry->aio_handle;
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

