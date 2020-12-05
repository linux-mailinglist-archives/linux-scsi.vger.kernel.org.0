Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE012CFE52
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Dec 2020 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgLETXj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Dec 2020 14:23:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9118 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgLETXi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 5 Dec 2020 14:23:38 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cp7Gc1R2vz15Wnh;
        Sat,  5 Dec 2020 19:52:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Dec 2020
 19:52:36 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>
Subject: [PATCH] scsi: pm80xx: Fix error return in pm8001_pci_probe
Date:   Sat, 5 Dec 2020 19:55:51 +0800
Message-ID: <20201205115551.2079471-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Forget to set error code when pm8001_configure_phy_settings
failed. We fixed it by using rc to store return value of
pm8001_configure_phy_settings.

Fixes: 279094079a442 ("[SCSI] pm80xx: Phy settings support for motherboard controller.")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 9a5d284f076a..ee2de177d0d0 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1127,7 +1127,8 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 
 	pm8001_init_sas_add(pm8001_ha);
 	/* phy setting support for motherboard controller */
-	if (pm8001_configure_phy_settings(pm8001_ha))
+	rc = pm8001_configure_phy_settings(pm8001_ha);
+	if (rc)
 		goto err_out_shost;
 
 	pm8001_post_sas_ha_init(shost, chip);
-- 
2.25.4

