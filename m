Return-Path: <linux-scsi+bounces-8503-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF784986AB3
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Sep 2024 03:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D941C21791
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Sep 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C190177982;
	Thu, 26 Sep 2024 01:43:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD81741D0
	for <linux-scsi@vger.kernel.org>; Thu, 26 Sep 2024 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727315018; cv=none; b=WApvQkG6k6PVugZj1i3zhESHbydTmBgjsRMYwVAmFOLOhp1XyEw7BWV/9dew3RvnlzbW+kKe+XQ4R4SNBnuT/xvbaPbHtKDJ8mvDafC9UvXpT1flsRfr41LYtSQREOD05pr82tNZpzaEHRcJReg+wMAzHWKRwzpcLCeAwyHP52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727315018; c=relaxed/simple;
	bh=eU2WqnIsb/EEbHicjb2/cREkFZe6p5u80LuoycDCmQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVzAiGleYw3JViYlVABl7/UDCqsOEbcq5RXc6ofB6PyCNHcDB3gTelaiYT+ifZ9m/rKNWCJhBYqkiYBxBLQDZzjvmp0SLO8SfumZzX+PViPgvdR6ZnfX/UiAgFF3kzmZegDJSGtHNGBhx18t83KqFIvLtbeDCBo3vj5NzDToRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XDbvS5qFlz1SBr8;
	Thu, 26 Sep 2024 09:42:44 +0800 (CST)
Received: from dggpemf100013.china.huawei.com (unknown [7.185.36.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AEA5140336;
	Thu, 26 Sep 2024 09:43:33 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 dggpemf100013.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Sep 2024 09:43:33 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
	<liyihang9@huawei.com>
Subject: [PATCH 03/13] scsi: hisi_sas: Add firmware information check
Date: Thu, 26 Sep 2024 09:43:22 +0800
Message-ID: <20240926014332.3905399-4-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240926014332.3905399-1-liyihang9@huawei.com>
References: <20240926014332.3905399-1-liyihang9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100013.china.huawei.com (7.185.36.179)

For security purposes, after information is obtained through the FW,
check information to ensure data correctness.

In v1 and v2 hw, the maximum number of PHYs is 9, while in v3 it is 8.
In v2 and v3 hw, the maximum number of hardware queues is 16, while in v1
it is 32.

Also add some debug logs for failure.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  7 +++++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 ++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 ++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 20 ++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index d223f482488f..a44768bceb9a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -307,6 +307,7 @@ enum {
 
 struct hisi_sas_hw {
 	int (*hw_init)(struct hisi_hba *hisi_hba);
+	int (*fw_info_check)(struct hisi_hba *hisi_hba);
 	int (*interrupt_preinit)(struct hisi_hba *hisi_hba);
 	void (*setup_itct)(struct hisi_hba *hisi_hba,
 			   struct hisi_sas_device *device);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index d3dcc4918444..e15926c40983 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2450,6 +2450,13 @@ static struct Scsi_Host *hisi_sas_shost_alloc(struct platform_device *pdev,
 	if (hisi_sas_get_fw_info(hisi_hba) < 0)
 		goto err_out;
 
+	if (hisi_hba->hw->fw_info_check) {
+		error = hisi_hba->hw->fw_info_check(hisi_hba);
+
+		if (error)
+			return error;
+	}
+
 	error = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (error) {
 		dev_err(dev, "No usable DMA addressing method\n");
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 71b5008c3552..70bba55bc5d0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1734,6 +1734,23 @@ static struct attribute *host_v1_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v1_hw);
 
+static int check_fw_info_v1_hw(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+
+	if (hisi_hba->n_phy < 0 || hisi_hba->n_phy > 9) {
+		dev_err(dev, "invalid phy number from FW\n");
+		return -EINVAL;
+	}
+
+	if (hisi_hba->queue_count < 0 || hisi_hba->queue_count > 32) {
+		dev_err(dev, "invalid queue count from FW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct scsi_host_template sht_v1_hw = {
 	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.device_configure	= hisi_sas_device_configure,
@@ -1747,6 +1764,7 @@ static const struct scsi_host_template sht_v1_hw = {
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
 	.hw_init = hisi_sas_v1_init,
+	.fw_info_check = check_fw_info_v1_hw,
 	.setup_itct = setup_itct_v1_hw,
 	.sl_notify_ssp = sl_notify_ssp_v1_hw,
 	.clear_itct = clear_itct_v1_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 342d75f12051..ab6668dc5b77 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3566,6 +3566,23 @@ static void map_queues_v2_hw(struct Scsi_Host *shost)
 	}
 }
 
+static int check_fw_info_v2_hw(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+
+	if (hisi_hba->n_phy < 0 || hisi_hba->n_phy > 9) {
+		dev_err(dev, "invalid phy number from FW\n");
+		return -EINVAL;
+	}
+
+	if (hisi_hba->queue_count < 0 || hisi_hba->queue_count > 16) {
+		dev_err(dev, "invalid queue count from FW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct scsi_host_template sht_v2_hw = {
 	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.device_configure	= hisi_sas_device_configure,
@@ -3582,6 +3599,7 @@ static const struct scsi_host_template sht_v2_hw = {
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
 	.hw_init = hisi_sas_v2_init,
+	.fw_info_check = check_fw_info_v2_hw,
 	.interrupt_preinit = hisi_sas_v2_interrupt_preinit,
 	.setup_itct = setup_itct_v2_hw,
 	.slot_index_alloc = slot_index_alloc_quirk_v2_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 980f28d7b87f..d48777fc4bd9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3371,6 +3371,23 @@ static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.debugfs_snapshot_regs = debugfs_snapshot_regs_v3_hw,
 };
 
+static int check_fw_info_v3_hw(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+
+	if (hisi_hba->n_phy < 0 || hisi_hba->n_phy > 8) {
+		dev_err(dev, "invalid phy number from FW\n");
+		return -EINVAL;
+	}
+
+	if (hisi_hba->queue_count < 0 || hisi_hba->queue_count > 16) {
+		dev_err(dev, "invalid queue count from FW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct Scsi_Host *
 hisi_sas_shost_alloc_pci(struct pci_dev *pdev)
 {
@@ -3401,6 +3418,9 @@ hisi_sas_shost_alloc_pci(struct pci_dev *pdev)
 	if (hisi_sas_get_fw_info(hisi_hba) < 0)
 		goto err_out;
 
+	if (check_fw_info_v3_hw(hisi_hba) < 0)
+		goto err_out;
+
 	if (experimental_iopoll_q_cnt < 0 ||
 		experimental_iopoll_q_cnt >= hisi_hba->queue_count)
 		dev_err(dev, "iopoll queue count %d cannot exceed or equal 16, using default 0\n",
-- 
2.33.0


