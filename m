Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25399962C
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfHVORo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 10:17:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732331AbfHVORo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 10:17:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8596F5C4896BD44C105B;
        Thu, 22 Aug 2019 22:13:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:13:04 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <mcgrof@kernel.org>, <colin.king@canonical.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] scsi: arcmsr: remove set but not used variable 'flags'
Date:   Thu, 22 Aug 2019 22:19:35 +0800
Message-ID: <1566483575-120713-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/arcmsr/arcmsr_hba.c: In function arcmsr_remap_pciregion:
drivers/scsi/arcmsr/arcmsr_hba.c:286:30: warning: variable flags set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 88053b1..bdf352e 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -283,11 +283,10 @@ static bool arcmsr_remap_pciregion(struct AdapterControlBlock *acb)
 	}
 	case ACB_ADAPTER_TYPE_D: {
 		void __iomem *mem_base0;
-		unsigned long addr, range, flags;
+		unsigned long addr, range;

 		addr = (unsigned long)pci_resource_start(pdev, 0);
 		range = pci_resource_len(pdev, 0);
-		flags = pci_resource_flags(pdev, 0);
 		mem_base0 = ioremap(addr, range);
 		if (!mem_base0) {
 			pr_notice("arcmsr%d: memory mapping region fail\n",
--
2.7.4

