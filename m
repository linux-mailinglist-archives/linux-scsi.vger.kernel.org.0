Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129DA27809A
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Sep 2020 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgIYGYd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Sep 2020 02:24:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727176AbgIYGYd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 25 Sep 2020 02:24:33 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1FE87947832B141A87E8;
        Fri, 25 Sep 2020 14:24:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 14:24:24 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <emilne@redhat.com>, <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: bfa: fix error return in bfad_pci_init()
Date:   Fri, 25 Sep 2020 14:24:23 +0800
Message-ID: <20200925062423.161504-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix to return error code -ENODEV from the error handling case instead
of 0.

Fixes: 11ea3824140c ("scsi: bfa: fix calls to dma_set_mask_and_coherent()")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/bfa/bfad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index bc5d84f87d8f..440ef32be048 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -749,6 +749,7 @@ bfad_pci_init(struct pci_dev *pdev, struct bfad_s *bfad)
 
 	if (bfad->pci_bar0_kva == NULL) {
 		printk(KERN_ERR "Fail to map bar0\n");
+		rc = -ENODEV;
 		goto out_release_region;
 	}
 
-- 
2.17.1

