Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD51BC100
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Apr 2020 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgD1ORx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Apr 2020 10:17:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbgD1ORx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 28 Apr 2020 10:17:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 53F634A93A80664C1FA2;
        Tue, 28 Apr 2020 22:17:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 22:17:39 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     "Manoj N . Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-scsi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] scsi: cxlflash: Fix error return code in cxlflash_probe()
Date:   Tue, 28 Apr 2020 14:18:55 +0000
Message-ID: <20200428141855.88704-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix to return negative error code -ENOMEM from create_afu error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/scsi/cxlflash/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index fbd2ae40dab4..fcc5aa9f6014 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3744,6 +3744,7 @@ static int cxlflash_probe(struct pci_dev *pdev,
 	cfg->afu_cookie = cfg->ops->create_afu(pdev);
 	if (unlikely(!cfg->afu_cookie)) {
 		dev_err(dev, "%s: create_afu failed\n", __func__);
+		rc = -ENOMEM;
 		goto out_remove;
 	}



