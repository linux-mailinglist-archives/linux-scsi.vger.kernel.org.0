Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633DBF8BED
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Nov 2019 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKLJeq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Nov 2019 04:34:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbfKLJe1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Nov 2019 04:34:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7E0CD00DD1FD5603B76;
        Tue, 12 Nov 2019 17:34:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 17:34:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 2/4] scsi: hisi_sas: Return directly if init hardware failed
Date:   Tue, 12 Nov 2019 17:30:57 +0800
Message-ID: <1573551059-107873-3-git-send-email-john.garry@huawei.com>
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

Need to return directly if init hardware failed.

Fixes: 73a4925d154c ("scsi: hisi_sas: Update all the registers after suspend and resume")
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 2ae7070db41a..b7836406debe 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3432,6 +3432,7 @@ static int hisi_sas_v3_resume(struct pci_dev *pdev)
 	if (rc) {
 		scsi_remove_host(shost);
 		pci_disable_device(pdev);
+		return rc;
 	}
 	hisi_hba->hw->phys_init(hisi_hba);
 	sas_resume_ha(sha);
-- 
2.17.1

