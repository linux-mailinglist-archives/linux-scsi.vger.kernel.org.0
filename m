Return-Path: <linux-scsi+bounces-13110-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC8A754A8
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Mar 2025 08:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484BB170E4C
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Mar 2025 07:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB841AC43A;
	Sat, 29 Mar 2025 07:32:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147B18DB0D;
	Sat, 29 Mar 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743233565; cv=none; b=j2M/ZRsmeaYvvcd+pstzfIU1OdLFO7Wu/t5HHpkcXTfOyBisrvLAwu+IbO/WEjWAs5l3hI/WedasnkVNe3ON/4zW8NQNz/p1REXsZ1QRmcivimanySyqiSOGznwRH+OJdLsm5VYiWE+hB0CXGt/nQG5Q0NyERlK4jFTGvzq/psQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743233565; c=relaxed/simple;
	bh=Hgvh745+vSQv3akkleclFrfAd/tP7yhkpjTYCRGPa80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns9WLhEVecMPr8BJ4kCAfatPT+7JDKXwlmqMf3jyv/jAjupFHWNkq1u15GUPO04tZZCz6oiyd4BoFCyXwgnBlI3tmU6epU7c8rdc8bNyyAcpKFyPRqv9Xqtj6AAFOxJy+pz+g4MWBUGU6XrVq+RvKHxas7YrHy/BdVWizrS3wB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZPpz23H13z27hGM;
	Sat, 29 Mar 2025 15:33:18 +0800 (CST)
Received: from dggpemf100013.china.huawei.com (unknown [7.185.36.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EE4014010D;
	Sat, 29 Mar 2025 15:32:40 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 dggpemf100013.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Mar 2025 15:32:39 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@huawei.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH 4/5] scsi: hisi_sas: Call I_T_nexus after soft reset for SATA disk
Date: Sat, 29 Mar 2025 15:32:35 +0800
Message-ID: <20250329073236.2300582-5-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250329073236.2300582-1-liyihang9@huawei.com>
References: <20250329073236.2300582-1-liyihang9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100013.china.huawei.com (7.185.36.179)

In commit 21c7e972475e ("scsi: hisi_sas: Disable SATA disk phy for severe
I_T nexus reset failure"), if the softreset fails upon certain conditions,
the PHY connected to the disk is disabled directly. Manual recovery is
required, which is inconvenient for users in actual use.

In addition, SATA disks do not support simultaneous connection of multiple
hosts. Therefore, when multiple controllers are connected to a SATA disk
at the same time, the controller which is connected later failed to issue
an ATA softreset to the SATA disk. As a result, the PHY associated with
the disk is disabled and cannot be automatically recovered.

Now that, we will not focus on the execution result of softreset. No
matter whether the execution is successful or not, we will directly carry
out I_T_nexus_reset.

Fixes: 21c7e972475e ("scsi: hisi_sas: Disable SATA disk phy for severe I_T
nexus reset failure")
Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 29 +++++----------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9e6ee32aa56e..f4b6d678ba72 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1897,33 +1897,14 @@ static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
 	}
 	hisi_sas_dereg_device(hisi_hba, device);
 
-	rc = hisi_sas_debug_I_T_nexus_reset(device);
-	if (rc == TMF_RESP_FUNC_COMPLETE && dev_is_sata(device)) {
-		struct sas_phy *local_phy;
-
+	if (dev_is_sata(device)) {
 		rc = hisi_sas_softreset_ata_disk(device);
-		switch (rc) {
-		case -ECOMM:
-			rc = -ENODEV;
-			break;
-		case TMF_RESP_FUNC_FAILED:
-		case -EMSGSIZE:
-		case -EIO:
-			local_phy = sas_get_local_phy(device);
-			rc = sas_phy_enable(local_phy, 0);
-			if (!rc) {
-				local_phy->enabled = 0;
-				dev_err(dev, "Disabled local phy of ATA disk %016llx due to softreset fail (%d)\n",
-					SAS_ADDR(device->sas_addr), rc);
-				rc = -ENODEV;
-			}
-			sas_put_local_phy(local_phy);
-			break;
-		default:
-			break;
-		}
+		if (rc == TMF_RESP_FUNC_FAILED)
+			dev_err(dev, "ata disk %016llx reset (%d)\n",
+				SAS_ADDR(device->sas_addr), rc);
 	}
 
+	rc = hisi_sas_debug_I_T_nexus_reset(device);
 	if ((rc == TMF_RESP_FUNC_COMPLETE) || (rc == -ENODEV))
 		hisi_sas_release_task(hisi_hba, device);
 
-- 
2.33.0


