Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FFF232A70
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Jul 2020 05:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgG3Dar (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Jul 2020 23:30:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728518AbgG3Daq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Jul 2020 23:30:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BAE0D8972AE3E401777C;
        Thu, 30 Jul 2020 11:30:41 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 11:30:37 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 3/3] scsi: Remove superfluous memset()
Date:   Thu, 30 Jul 2020 11:31:58 +0800
Message-ID: <1596079918-41115-4-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596079918-41115-1-git-send-email-liheng40@huawei.com>
References: <1596079918-41115-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes coccicheck warning:

./drivers/scsi/mpt3sas/mpt3sas_base.c:5247:16-34: WARNING: dma_alloc_coherent use in ioc -> request already zeroes out memory,  so memset is not needed

dma_alloc_coherent use in status already zeroes out memory, so memset is not needed

Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 1d64524..61219ad 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5257,7 +5257,6 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		_base_release_memory_pools(ioc);
 		goto retry_allocation;
 	}
-	memset(ioc->request, 0, sz);
 
 	if (retry_sz)
 		ioc_err(ioc, "request pool: dma_alloc_coherent succeed: hba_depth(%d), chains_per_io(%d), frame_sz(%d), total(%d kb)\n",
-- 
2.7.4

