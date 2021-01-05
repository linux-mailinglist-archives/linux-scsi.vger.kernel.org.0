Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672B72EA244
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Jan 2021 02:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbhAEBBL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 20:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbhAEBBK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Jan 2021 20:01:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87F022B3A;
        Tue,  5 Jan 2021 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808415;
        bh=GHA5ydDxCqqXxs1Ki4IfRQ923AnzZZfVPzjZTVac5YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzO3cRh6zjhnGMnczCQFok/gH3p+/Xon+pTbKgi39U0nrV1qGexeWCz/xqovfyNVo
         ihr0lXL4KFaKMM6Ree9yjmIN2og36efv/RvRWMqZTeK4O+BPM9NsxfWAXEZgNTZWQN
         GKILo876lzAcW2c7e6aeT2pycVQyWaowbTOSj7EWrbLOlMYJr0lF9oOayf5qJ480/n
         jIME4Xp4cqHdOHeSOk72NU4szF4iugu+L1DZnb1lmgXOxCVu8OQ10P1KVL73/676AD
         8W6NYMaMHhdiwLAnCsyr04tn7OV+pbtWP1CdVkd+DBhCkDlYa1iH71FHkjEfYV/SAo
         RNYGnAgJJQGTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/6] scsi: ufs-pci: Ensure UFS device is in PowerDown mode for suspend-to-disk ->poweroff()
Date:   Mon,  4 Jan 2021 20:00:08 -0500
Message-Id: <20210105010012.3954626-2-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105010012.3954626-1-sashal@kernel.org>
References: <20210105010012.3954626-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit af423534d2de86cd0db729a5ac41f056ca8717de ]

The expectation for suspend-to-disk is that devices will be powered-off, so
the UFS device should be put in PowerDown mode. If spm_lvl is not 5, then
that will not happen. Change the pm callbacks to force spm_lvl 5 for
suspend-to-disk poweroff.

Link: https://lore.kernel.org/r/20201207083120.26732-3-adrian.hunter@intel.com
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd-pci.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index 925b0ec7ec54d..5253f089de4ee 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -97,6 +97,30 @@ static int ufshcd_pci_resume(struct device *dev)
 {
 	return ufshcd_system_resume(dev_get_drvdata(dev));
 }
+
+/**
+ * ufshcd_pci_poweroff - suspend-to-disk poweroff function
+ * @dev: pointer to PCI device handle
+ *
+ * Returns 0 if successful
+ * Returns non-zero otherwise
+ */
+static int ufshcd_pci_poweroff(struct device *dev)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	int spm_lvl = hba->spm_lvl;
+	int ret;
+
+	/*
+	 * For poweroff we need to set the UFS device to PowerDown mode.
+	 * Force spm_lvl to ensure that.
+	 */
+	hba->spm_lvl = 5;
+	ret = ufshcd_system_suspend(hba);
+	hba->spm_lvl = spm_lvl;
+	return ret;
+}
+
 #endif /* !CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM
@@ -191,8 +215,14 @@ ufshcd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct dev_pm_ops ufshcd_pci_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_pci_suspend,
-				ufshcd_pci_resume)
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= ufshcd_pci_suspend,
+	.resume		= ufshcd_pci_resume,
+	.freeze		= ufshcd_pci_suspend,
+	.thaw		= ufshcd_pci_resume,
+	.poweroff	= ufshcd_pci_poweroff,
+	.restore	= ufshcd_pci_resume,
+#endif
 	SET_RUNTIME_PM_OPS(ufshcd_pci_runtime_suspend,
 			   ufshcd_pci_runtime_resume,
 			   ufshcd_pci_runtime_idle)
-- 
2.27.0

