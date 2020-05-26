Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9319BBB2
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Apr 2020 08:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgDBGbA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Apr 2020 02:31:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbgDBGa7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 Apr 2020 02:30:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 16BD892522924C6D5985;
        Thu,  2 Apr 2020 14:30:34 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 14:30:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <chenxiang66@hisilicon.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] scsi: hisi_sas: Fix build error without SATA_HOST
Date:   Thu, 2 Apr 2020 14:30:21 +0800
Message-ID: <20200402063021.34672-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If SATA_HOST is n, build fails:

drivers/scsi/hisi_sas/hisi_sas_main.o: In function `hisi_sas_fill_ata_reset_cmd':
hisi_sas_main.c:(.text+0x2500): undefined reference to `ata_tf_to_fis'

Select SATA_HOST to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 7c594f0407de ("scsi: hisi_sas: add softreset function for SATA disk")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/hisi_sas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/hisi_sas/Kconfig b/drivers/scsi/hisi_sas/Kconfig
index 90a17452a50d..13ed9073fc72 100644
--- a/drivers/scsi/hisi_sas/Kconfig
+++ b/drivers/scsi/hisi_sas/Kconfig
@@ -6,6 +6,7 @@ config SCSI_HISI_SAS
 	select SCSI_SAS_LIBSAS
 	select BLK_DEV_INTEGRITY
 	depends on ATA
+	select SATA_HOST
 	help
 		This driver supports HiSilicon's SAS HBA, including support based
 		on platform device
-- 
2.17.1


