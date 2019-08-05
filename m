Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A5F81E05
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfHENvO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 09:51:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729625AbfHENu1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0636237F57F35AD326B3;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:15 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 15/15] scsi: hisi_sas: Consolidate internal abort calls in LU reset operation
Date:   Mon, 5 Aug 2019 21:48:12 +0800
Message-ID: <1565012892-75940-16-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
References: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

In hisi_sas_lu_reset(), we call internal abort for SAS and SATA device
codepaths -> consolidate into a single call.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index acb87b4f9622..d60eaaa4c5e8 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1829,18 +1829,18 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 	struct device *dev = hisi_hba->dev;
 	int rc = TMF_RESP_FUNC_FAILED;
 
+	/* Clear internal IO and then lu reset */
+	rc = hisi_sas_internal_task_abort(hisi_hba, device,
+					  HISI_SAS_INT_ABT_DEV, 0);
+	if (rc < 0) {
+		dev_err(dev, "lu_reset: internal abort failed\n");
+		goto out;
+	}
+	hisi_sas_dereg_device(hisi_hba, device);
+
 	if (dev_is_sata(device)) {
 		struct sas_phy *phy;
 
-		/* Clear internal IO and then hardreset */
-		rc = hisi_sas_internal_task_abort(hisi_hba, device,
-						  HISI_SAS_INT_ABT_DEV, 0);
-		if (rc < 0) {
-			dev_err(dev, "lu_reset: internal abort failed\n");
-			goto out;
-		}
-		hisi_sas_dereg_device(hisi_hba, device);
-
 		phy = sas_get_local_phy(device);
 
 		rc = sas_phy_reset(phy, 1);
@@ -1851,14 +1851,6 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 	} else {
 		struct hisi_sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
 
-		rc = hisi_sas_internal_task_abort(hisi_hba, device,
-						  HISI_SAS_INT_ABT_DEV, 0);
-		if (rc < 0) {
-			dev_err(dev, "lu_reset: internal abort failed\n");
-			goto out;
-		}
-		hisi_sas_dereg_device(hisi_hba, device);
-
 		rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
 		if (rc == TMF_RESP_FUNC_COMPLETE)
 			hisi_sas_release_task(hisi_hba, device);
-- 
2.17.1

