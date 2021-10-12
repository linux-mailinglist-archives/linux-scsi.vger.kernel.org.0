Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8242A503
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Oct 2021 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhJLNCL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Oct 2021 09:02:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:5460 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233883AbhJLNCL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Oct 2021 09:02:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="225904427"
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="225904427"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 05:59:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="625934934"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2021 05:59:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <huobean@gmail.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 1/1] scsi: ufs-pci: Force a full restore after suspend-to-disk
Date:   Tue, 12 Oct 2021 15:59:14 +0300
Message-Id: <20211012125914.21977-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012125914.21977-1-adrian.hunter@intel.com>
References: <20211012125914.21977-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Implement the ->restore() PM operation and set the link to off, which
will force a full reset and restore.  This ensures that Host Performance
Booster is reset after suspend-to-disk.

The Host Performance Booster feature caches logical-to-physical mapping
information in the host memory.  After suspend-to-disk, such information
is not valid, so a full reset and restore is needed.

A full reset and restore is done if the SPM level is 5 or 6, but not for
other SPM levels, so this change fixes those cases.

A full reset and restore also restores base address registers, so that
code is removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd-pci.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index 149c1aa09103..d65e6cd7a28d 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -370,20 +370,6 @@ static void ufs_intel_common_exit(struct ufs_hba *hba)
 
 static int ufs_intel_resume(struct ufs_hba *hba, enum ufs_pm_op op)
 {
-	/*
-	 * To support S4 (suspend-to-disk) with spm_lvl other than 5, the base
-	 * address registers must be restored because the restore kernel can
-	 * have used different addresses.
-	 */
-	ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
-		      REG_UTP_TRANSFER_REQ_LIST_BASE_L);
-	ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
-		      REG_UTP_TRANSFER_REQ_LIST_BASE_H);
-	ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
-		      REG_UTP_TASK_REQ_LIST_BASE_L);
-	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
-		      REG_UTP_TASK_REQ_LIST_BASE_H);
-
 	if (ufshcd_is_link_hibern8(hba)) {
 		int ret = ufshcd_uic_hibern8_exit(hba);
 
@@ -463,6 +449,16 @@ static struct ufs_hba_variant_ops ufs_intel_lkf_hba_vops = {
 	.device_reset		= ufs_intel_device_reset,
 };
 
+static int ufshcd_pci_restore(struct device *dev)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	/* Force a full reset and restore */
+	ufshcd_set_link_off(hba);
+
+	return ufshcd_system_resume(dev);
+}
+
 /**
  * ufshcd_pci_shutdown - main function to put the controller in reset state
  * @pdev: pointer to PCI device handle
@@ -546,9 +542,14 @@ ufshcd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct dev_pm_ops ufshcd_pci_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
 	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 #ifdef CONFIG_PM_SLEEP
+	.suspend	= ufshcd_system_suspend,
+	.resume		= ufshcd_system_resume,
+	.freeze		= ufshcd_system_suspend,
+	.thaw		= ufshcd_system_resume,
+	.poweroff	= ufshcd_system_suspend,
+	.restore	= ufshcd_pci_restore,
 	.prepare	= ufshcd_suspend_prepare,
 	.complete	= ufshcd_resume_complete,
 #endif
-- 
2.25.1

