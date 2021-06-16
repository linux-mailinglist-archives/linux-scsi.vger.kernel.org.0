Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED7D3A92BD
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Jun 2021 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhFPGkC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Jun 2021 02:40:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4928 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhFPGkA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 16 Jun 2021 02:40:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4b5J08jfz70KQ;
        Wed, 16 Jun 2021 14:34:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 14:37:53 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 14:37:52 +0800
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
Subject: [PATCH v2 04/20] scsi: vmw_pvscsi: remove unnecessary oom message
Date:   Wed, 16 Jun 2021 14:36:58 +0800
Message-ID: <20210616063714.778-5-thunder.leizhen@huawei.com>
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
 drivers/scsi/vmw_pvscsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index ce1ba1b936298c7..78102969e9fe692 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1304,10 +1304,8 @@ static u32 pvscsi_get_max_targets(struct pvscsi_adapter *adapter)
 	dev = pvscsi_dev(adapter);
 	config_page = dma_alloc_coherent(&adapter->dev->dev, PAGE_SIZE,
 			&configPagePA, GFP_KERNEL);
-	if (!config_page) {
-		dev_warn(dev, "vmw_pvscsi: failed to allocate memory for config page\n");
+	if (!config_page)
 		goto exit;
-	}
 	BUG_ON(configPagePA & ~PAGE_MASK);
 
 	/* Fetch config info from the device. */
@@ -1479,7 +1477,6 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	adapter->cmd_map = kcalloc(adapter->req_depth,
 				   sizeof(struct pvscsi_ctx), GFP_KERNEL);
 	if (!adapter->cmd_map) {
-		printk(KERN_ERR "vmw_pvscsi: failed to allocate memory.\n");
 		error = -ENOMEM;
 		goto out_reset_adapter;
 	}
-- 
2.26.0.106.g9fadedd


