Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1E359E61
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Apr 2021 14:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhDIMKD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Apr 2021 08:10:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16557 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIMKC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Apr 2021 08:10:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGxhl6fqHz1BGWc;
        Fri,  9 Apr 2021 20:07:35 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 20:09:41 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH -next] scsi: qla2xxx: remove unneeded if-null-free check
Date:   Fri, 9 Apr 2021 20:09:25 +0800
Message-ID: <20210409120925.7122-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Eliminate the following coccicheck warning:

drivers/scsi/qla2xxx/qla_os.c:4622:2-7:
 WARNING: NULL check before some freeing functions is not needed.
drivers/scsi/qla2xxx/qla_os.c:4637:3-8:
 WARNING: NULL check before some freeing functions is not needed.

Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 12959e3874cb..d74c32f84ef5 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4618,8 +4618,7 @@ qla2x00_free_fw_dump(struct qla_hw_data *ha)
 		dma_free_coherent(&ha->pdev->dev,
 		    EFT_SIZE, ha->eft, ha->eft_dma);
 
-	if (ha->fw_dump)
-		vfree(ha->fw_dump);
+	vfree(ha->fw_dump);
 
 	ha->fce = NULL;
 	ha->fce_dma = 0;
@@ -4633,8 +4632,7 @@ qla2x00_free_fw_dump(struct qla_hw_data *ha)
 	ha->fw_dump_len = 0;
 
 	for (j = 0; j < 2; j++, fwdt++) {
-		if (fwdt->template)
-			vfree(fwdt->template);
+		vfree(fwdt->template);
 		fwdt->template = NULL;
 		fwdt->length = 0;
 	}
-- 
2.31.1

