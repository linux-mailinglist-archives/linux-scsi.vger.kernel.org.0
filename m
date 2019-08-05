Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5302981DFC
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfHENu6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 09:50:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729755AbfHENu2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1C38CF8B2C0E5EB75829;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 11/15] scsi: hisi_sas: Drop free_irq() when devm_request_irq() failed
Date:   Mon, 5 Aug 2019 21:48:08 +0800
Message-ID: <1565012892-75940-12-git-send-email-john.garry@huawei.com>
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

From: Xiang Chen <chenxiang66@hisilicon.com>

It will free irq automatically if devm_request_irq() failed, so drop
free_irq() if devm_request_irq() failed.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 34 ++++++--------------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 21 +++-------------
 2 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 9955b4fbdd0d..a3f8c51b3500 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3304,8 +3304,8 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 {
 	struct platform_device *pdev = hisi_hba->platform_dev;
 	struct device *dev = &pdev->dev;
-	int irq, rc, irq_map[128];
-	int i, phy_no, fatal_no, queue_no, k;
+	int irq, rc = 0, irq_map[128];
+	int i, phy_no, fatal_no, queue_no;
 
 	for (i = 0; i < 128; i++)
 		irq_map[i] = platform_get_irq(pdev, i);
@@ -3318,7 +3318,7 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 			dev_err(dev, "irq init: could not request phy interrupt %d, rc=%d\n",
 				irq, rc);
 			rc = -ENOENT;
-			goto free_phy_int_irqs;
+			goto err_out;
 		}
 	}
 
@@ -3332,7 +3332,7 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 			dev_err(dev, "irq init: could not request sata interrupt %d, rc=%d\n",
 				irq, rc);
 			rc = -ENOENT;
-			goto free_sata_int_irqs;
+			goto err_out;
 		}
 	}
 
@@ -3344,7 +3344,7 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 			dev_err(dev, "irq init: could not request fatal interrupt %d, rc=%d\n",
 				irq, rc);
 			rc = -ENOENT;
-			goto free_fatal_int_irqs;
+			goto err_out;
 		}
 	}
 
@@ -3359,34 +3359,14 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 			dev_err(dev, "irq init: could not request cq interrupt %d, rc=%d\n",
 				irq, rc);
 			rc = -ENOENT;
-			goto free_cq_int_irqs;
+			goto err_out;
 		}
 		tasklet_init(t, cq_tasklet_v2_hw, (unsigned long)cq);
 	}
 
 	hisi_hba->cq_nvecs = hisi_hba->queue_count;
 
-	return 0;
-
-free_cq_int_irqs:
-	for (k = 0; k < queue_no; k++) {
-		struct hisi_sas_cq *cq = &hisi_hba->cq[k];
-
-		free_irq(irq_map[k + 96], cq);
-		tasklet_kill(&cq->tasklet);
-	}
-free_fatal_int_irqs:
-	for (k = 0; k < fatal_no; k++)
-		free_irq(irq_map[k + 81], hisi_hba);
-free_sata_int_irqs:
-	for (k = 0; k < phy_no; k++) {
-		struct hisi_sas_phy *phy = &hisi_hba->phy[k];
-
-		free_irq(irq_map[k + 72], phy);
-	}
-free_phy_int_irqs:
-	for (k = 0; k < i; k++)
-		free_irq(irq_map[k + 1], hisi_hba);
+err_out:
 	return rc;
 }
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 95a298d4e211..3cc53e5b92f2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2351,8 +2351,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
 	struct pci_dev *pdev = hisi_hba->pci_dev;
-	int vectors, rc;
-	int i, k;
+	int vectors, rc, i;
 	int max_msi = HISI_SAS_MSI_COUNT_V3_HW, min_msi;
 
 	if (auto_affine_msi_experimental) {
@@ -2400,7 +2399,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 	if (rc) {
 		dev_err(dev, "could not request chnl interrupt, rc=%d\n", rc);
 		rc = -ENOENT;
-		goto free_phy_irq;
+		goto free_irq_vectors;
 	}
 
 	rc = devm_request_irq(dev, pci_irq_vector(pdev, 11),
@@ -2409,7 +2408,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 	if (rc) {
 		dev_err(dev, "could not request fatal interrupt, rc=%d\n", rc);
 		rc = -ENOENT;
-		goto free_chnl_interrupt;
+		goto free_irq_vectors;
 	}
 
 	/* Init tasklets for cq only */
@@ -2426,7 +2425,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 			dev_err(dev, "could not request cq%d interrupt, rc=%d\n",
 				i, rc);
 			rc = -ENOENT;
-			goto free_cq_irqs;
+			goto free_irq_vectors;
 		}
 
 		tasklet_init(t, cq_tasklet_v3_hw, (unsigned long)cq);
@@ -2434,18 +2433,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 
 	return 0;
 
-free_cq_irqs:
-	for (k = 0; k < i; k++) {
-		struct hisi_sas_cq *cq = &hisi_hba->cq[k];
-		int nr = hisi_sas_intr_conv ? 16 : 16 + k;
-
-		free_irq(pci_irq_vector(pdev, nr), cq);
-	}
-	free_irq(pci_irq_vector(pdev, 11), hisi_hba);
-free_chnl_interrupt:
-	free_irq(pci_irq_vector(pdev, 2), hisi_hba);
-free_phy_irq:
-	free_irq(pci_irq_vector(pdev, 1), hisi_hba);
 free_irq_vectors:
 	pci_free_irq_vectors(pdev);
 	return rc;
-- 
2.17.1

