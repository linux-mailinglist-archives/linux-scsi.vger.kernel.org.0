Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5573A92C9
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Jun 2021 08:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhFPGkQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Jun 2021 02:40:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7452 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhFPGkM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 16 Jun 2021 02:40:12 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4b5p4QqlzZhmC;
        Wed, 16 Jun 2021 14:35:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 14:38:06 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 14:38:05 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Vishal Bhakta <vbhakta@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "Sesidhar Baddela" <sebaddel@cisco.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "Adaptec OEM Raid Solutions" <aacraid@microsemi.com>,
        Brian King <brking@us.ibm.com>,
        Satish Kharat <satishkh@cisco.com>,
        Hannes Reinecke <hare@suse.de>,
        "Manish Rangankar" <mrangankar@marvell.com>,
        Adam Radford <aradford@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 19/20] scsi: a100u2w: remove unnecessary oom message
Date:   Wed, 16 Jun 2021 14:37:13 +0800
Message-ID: <20210616063714.778-20-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210616063714.778-1-thunder.leizhen@huawei.com>
References: <20210616063714.778-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


