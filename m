Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9DA8423
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Sep 2019 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfIDNFp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Sep 2019 09:05:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729888AbfIDNFp (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 4 Sep 2019 09:05:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC78CDC15B65CCCF9CCB;
        Wed,  4 Sep 2019 21:05:41 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 21:05:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <liwei213@huawei.com>,
        <dimitrysh@google.com>, <kjlu@umn.edu>, <tglx@linutronix.de>,
        <manivannan.sadhasivam@linaro.org>, <yuehaibing@huawei.com>,
        <stanley.chu@mediatek.com>, <arnd@arndb.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scsi: ufs-hisi: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 21:04:57 +0800
Message-ID: <20190904130457.24744-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/ufs/ufs-hisi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index f4d1dca..6bbb167 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -447,13 +447,11 @@ static int ufs_hisi_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
 {
-	struct resource *mem_res;
 	struct device *dev = host->hba->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 
 	/* get resource of ufs sys ctrl */
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
+	host->ufs_sys_ctrl = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(host->ufs_sys_ctrl))
 		return PTR_ERR(host->ufs_sys_ctrl);
 
-- 
2.7.4


