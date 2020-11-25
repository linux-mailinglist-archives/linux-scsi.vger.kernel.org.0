Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE902C3942
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Nov 2020 07:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgKYGqX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Nov 2020 01:46:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7984 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgKYGqW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 25 Nov 2020 01:46:22 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cgry52hvCzhh9C;
        Wed, 25 Nov 2020 14:46:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 14:46:09 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] scsi: aic94xx: Fix error return code in asd_process_ms
Date:   Wed, 25 Nov 2020 14:50:33 +0800
Message-ID: <20201125065033.154172-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix to return the error code -EINVAL when size == 0 after
asd_find_flash_de instead of zero.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_sds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_sds.c b/drivers/scsi/aic94xx/aic94xx_sds.c
index 105adba55..3aad00458 100644
--- a/drivers/scsi/aic94xx/aic94xx_sds.c
+++ b/drivers/scsi/aic94xx/aic94xx_sds.c
@@ -860,8 +860,10 @@ static int asd_process_ms(struct asd_ha_struct *asd_ha,
 		goto out;
 	}
 
-	if (size == 0)
+	if (size == 0) {
+		err = -EINVAL;
 		goto out;
+	}
 
 	err = -ENOMEM;
 	manuf_sec = kmalloc(size, GFP_KERNEL);
@@ -989,8 +991,10 @@ static int asd_process_ctrl_a_user(struct asd_ha_struct *asd_ha,
 		goto out_process;
 	}
 
-	if (size == 0)
+	if (size == 0) {
+		err = -EINVAL;
 		goto out;
+	}
 
 	err = -ENOMEM;
 	el = kmalloc(size, GFP_KERNEL);
-- 
2.23.0

