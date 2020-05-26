Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2691AEB59
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Apr 2020 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDRJcf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Apr 2020 05:32:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgDRJcf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Apr 2020 05:32:35 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7BC1CF453326FE1A78F1;
        Sat, 18 Apr 2020 17:32:33 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 17:32:25 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <sathya.prakash@broadcom.com>, <chaitra.basappa@broadcom.com>,
        <suganath-prabu.subramani@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <sreekanth.reddy@broadcom.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: mpt3sas: remove NULL check before freeing function
Date:   Sat, 18 Apr 2020 17:58:50 +0800
Message-ID: <20200418095850.34883-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/mpt3sas/mpt3sas_base.c:4906:3-19: WARNING: NULL check
before some freeing functions is not needed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 663782bb790d..06285b03fa00 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4902,8 +4902,7 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 					ioc->pcie_sg_lookup[i].pcie_sgl,
 					ioc->pcie_sg_lookup[i].pcie_sgl_dma);
 		}
-		if (ioc->pcie_sgl_dma_pool)
-			dma_pool_destroy(ioc->pcie_sgl_dma_pool);
+		dma_pool_destroy(ioc->pcie_sgl_dma_pool);
 	}
 
 	if (ioc->config_page) {
-- 
2.21.1

