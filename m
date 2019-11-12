Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B1FF8BE8
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Nov 2019 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKLJe2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Nov 2019 04:34:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbfKLJe1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Nov 2019 04:34:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF1CF6C0DA9CB716FA85;
        Tue, 12 Nov 2019 17:34:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 17:34:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/4] scsi: hisi_sas: Relocate call to hisi_sas_debugfs_exit()
Date:   Tue, 12 Nov 2019 17:30:58 +0800
Message-ID: <1573551059-107873-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573551059-107873-1-git-send-email-john.garry@huawei.com>
References: <1573551059-107873-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Currently we call function hisi_sas_debugfs_exit() to remove debugfs_dir
before freeing interrupt irqs and destroying workqueue in the driver
remove path.

If a dump is triggered before function hisi_sas_debugfs_exit() but
debugfs_work may be called after it, so it may refer to already removed
debugfs_dir which will cause NULL pointer dereference.

To avoid it, put function hisi_sas_debugfs_exit() after free_irqs and
destroy workqueue when removing hisi_sas driver.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b7836406debe..bf5d5f138437 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3302,8 +3302,6 @@ static void hisi_sas_v3_remove(struct pci_dev *pdev)
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
 	struct Scsi_Host *shost = sha->core.shost;
 
-	hisi_sas_debugfs_exit(hisi_hba);
-
 	if (timer_pending(&hisi_hba->timer))
 		del_timer(&hisi_hba->timer);
 
@@ -3315,6 +3313,7 @@ static void hisi_sas_v3_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	hisi_sas_free(hisi_hba);
+	hisi_sas_debugfs_exit(hisi_hba);
 	scsi_host_put(shost);
 }
 
-- 
2.17.1

