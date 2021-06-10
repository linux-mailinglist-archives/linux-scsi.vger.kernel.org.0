Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6123A259D
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Jun 2021 09:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJHmQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Jun 2021 03:42:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3934 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHmP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Jun 2021 03:42:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0wm92Rncz6x9v;
        Thu, 10 Jun 2021 15:37:13 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:40:11 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:40:11 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] scsi: 3w-xxx: remove unnecessary oom message
Date:   Thu, 10 Jun 2021 15:40:07 +0800
Message-ID: <20210610074007.15453-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 drivers/scsi/3w-xxxx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 4ee485ab2714845..a7eb50d2592ea1a 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -836,10 +836,8 @@ static int tw_allocate_memory(TW_Device_Extension *tw_dev, int size, int which)
 
 	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev,
 			size * TW_Q_LENGTH, &dma_handle, GFP_KERNEL);
-	if (cpu_addr == NULL) {
-		printk(KERN_WARNING "3w-xxxx: dma_alloc_coherent() failed.\n");
+	if (!cpu_addr)
 		return 1;
-	}
 
 	if ((unsigned long)cpu_addr % (tw_dev->tw_pci_dev->device == TW_DEVICE_ID ? TW_ALIGNMENT_6000 : TW_ALIGNMENT_7000)) {
 		printk(KERN_WARNING "3w-xxxx: Couldn't allocate correctly aligned memory.\n");
-- 
2.26.0.106.g9fadedd


