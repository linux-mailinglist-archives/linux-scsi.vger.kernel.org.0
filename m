Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C53A25AA
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Jun 2021 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhFJHoT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Jun 2021 03:44:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3935 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHoS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Jun 2021 03:44:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0wpY13BGz6w5S;
        Thu, 10 Jun 2021 15:39:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:42:21 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:42:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] scsi: a100u2w: remove unnecessary oom message
Date:   Thu, 10 Jun 2021 15:42:14 +0800
Message-ID: <20210610074214.15506-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/scsi/a100u2w.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 028af6b1057c606..7bcb8889c085e0a 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1123,19 +1123,15 @@ static int inia100_probe_one(struct pci_dev *pdev,
 	sz = ORC_MAXQUEUE * sizeof(struct orc_scb);
 	host->scb_virt = dma_alloc_coherent(&pdev->dev, sz, &host->scb_phys,
 					    GFP_KERNEL);
-	if (!host->scb_virt) {
-		printk("inia100: SCB memory allocation error\n");
+	if (!host->scb_virt)
 		goto out_host_put;
-	}
 
 	/* Get total memory needed for ESCB */
 	sz = ORC_MAXQUEUE * sizeof(struct orc_extended_scb);
 	host->escb_virt = dma_alloc_coherent(&pdev->dev, sz, &host->escb_phys,
 					     GFP_KERNEL);
-	if (!host->escb_virt) {
-		printk("inia100: ESCB memory allocation error\n");
+	if (!host->escb_virt)
 		goto out_free_scb_array;
-	}
 
 	if (init_orchid(host)) {	/* Initialize orchid chip */
 		printk("inia100: initial orchid fail!!\n");
-- 
2.26.0.106.g9fadedd


