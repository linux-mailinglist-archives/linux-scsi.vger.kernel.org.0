Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7301C10004C
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 09:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfKRI0j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 03:26:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbfKRI0j (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 03:26:39 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0C5B9B3A51CBA320222A;
        Mon, 18 Nov 2019 16:26:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 16:26:28 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <sathya.prakash@broadcom.com>, <chaitra.basappa@broadcom.com>,
        <suganath-prabu.subramani@broadcom.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] scsi: mpt3sas: remove not needed memset
Date:   Mon, 18 Nov 2019 16:33:52 +0800
Message-ID: <1574066032-40510-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes coccicheck warning:

drivers/scsi/mpt3sas/mpt3sas_base.c:5080:16-34: WARNING: dma_alloc_coherent use in ioc -> request already zeroes out memory,  so memset is not needed

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index fea3cb6..d26fbc2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5076,7 +5076,6 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		_base_release_memory_pools(ioc);
 		goto retry_allocation;
 	}
-	memset(ioc->request, 0, sz);

 	if (retry_sz)
 		ioc_err(ioc, "request pool: dma_alloc_coherent succeed: hba_depth(%d), chains_per_io(%d), frame_sz(%d), total(%d kb)\n",
--
2.7.4

