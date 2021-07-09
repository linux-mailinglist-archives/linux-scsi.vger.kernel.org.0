Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93F83C2A48
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Jul 2021 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGIU3p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jul 2021 16:29:45 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:50721 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGIU3p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Jul 2021 16:29:45 -0400
Received: by mail-pj1-f49.google.com with SMTP id cu14so1060754pjb.0
        for <linux-scsi@vger.kernel.org>; Fri, 09 Jul 2021 13:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYJazgWDiFtmi66NZ4JN7FdOqfX/8D3WUA6oYR+HV74=;
        b=Pben4NFp6Gi8MRgTZ3FEjCE5LJu9nc1q4UK6pj3X9FLrlB4419SzNmlCxr64lvOUw3
         1pVY88kI11aAZYZAGB3CoUyLsS+zAvIvUYGkw6TEkyqONEmQTofxisGAUoYiQ0yqbrfB
         GfEyXo1AwIXMsEpKgEtbOe0LriaRuXjRLlxXUTRLz2Sa/k8gQGqfoCMotUJEgtEex/qq
         0z+vqbQi0/QcN2b5hdMapwW6MY8i+sMkZtBmL3/k8GLxIEqGsTHGrMDrSf2JzMQleYDH
         +uwhHAEkWQJifJPQhi5R6B0HPgfmZDMWv4H/JTfcWa8jZWYZfyfPCxYxpIsN6NPI/uB0
         15qQ==
X-Gm-Message-State: AOAM531fXr+mAePgOqNhoNmBjCp5UCsQR2Yeu4KXBXh+3ZqP4ecZZM8b
        9osery3rYfZ1kFbdRwV7XI0=
X-Google-Smtp-Source: ABdhPJwxHgTY4iZchUdjRGiG7QU9YDAvRxI/u/mKbcF5kbKYj7ZmFv3M4f+mcLZx8xQWZjlCstJqBg==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr640066pjh.135.1625862421337;
        Fri, 09 Jul 2021 13:27:01 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:eeaf:c266:e6cc:b591])
        by smtp.gmail.com with ESMTPSA id e16sm8812927pgl.54.2021.07.09.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 13:27:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bean Huo <beanhuo@micron.com>, Yue Hu <huyue2@yulong.com>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH v2 02/19] scsi: ufs: Reduce power management code duplication
Date:   Fri,  9 Jul 2021 13:26:21 -0700
Message-Id: <20210709202638.9480-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709202638.9480-1-bvanassche@acm.org>
References: <20210709202638.9480-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Move the dev_get_drvdata() calls into the ufshcd_{system,runtime}_*()
functions. Remove ufshcd_runtime_idle() since it is empty. This patch
does not change any functionality.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ufs/cdns-pltfrm.c        |  7 ++--
 drivers/scsi/ufs/tc-dwc-g210-pci.c    | 32 ++----------------
 drivers/scsi/ufs/tc-dwc-g210-pltfrm.c |  7 ++--
 drivers/scsi/ufs/ufs-exynos.c         |  7 ++--
 drivers/scsi/ufs/ufs-hisi.c           |  7 ++--
 drivers/scsi/ufs/ufs-mediatek.c       |  7 ++--
 drivers/scsi/ufs/ufs-qcom.c           |  7 ++--
 drivers/scsi/ufs/ufshcd-pci.c         | 48 ++-------------------------
 drivers/scsi/ufs/ufshcd-pltfrm.c      | 47 --------------------------
 drivers/scsi/ufs/ufshcd-pltfrm.h      | 18 ----------
 drivers/scsi/ufs/ufshcd.c             | 41 ++++++++++++-----------
 drivers/scsi/ufs/ufshcd.h             |  9 +++--
 12 files changed, 41 insertions(+), 196 deletions(-)

diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
index 908ff39c4856..7da8be2f35c4 100644
--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -318,11 +318,8 @@ static int cdns_ufs_pltfrm_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops cdns_ufs_dev_pm_ops = {
-	.suspend         = ufshcd_pltfrm_suspend,
-	.resume          = ufshcd_pltfrm_resume,
-	.runtime_suspend = ufshcd_pltfrm_runtime_suspend,
-	.runtime_resume  = ufshcd_pltfrm_runtime_resume,
-	.runtime_idle    = ufshcd_pltfrm_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
diff --git a/drivers/scsi/ufs/tc-dwc-g210-pci.c b/drivers/scsi/ufs/tc-dwc-g210-pci.c
index ec4589afbc13..679289e1a78e 100644
--- a/drivers/scsi/ufs/tc-dwc-g210-pci.c
+++ b/drivers/scsi/ufs/tc-dwc-g210-pci.c
@@ -23,31 +23,6 @@ static int tc_type = TC_G210_INV;
 module_param(tc_type, int, 0);
 MODULE_PARM_DESC(tc_type, "Test Chip Type (20 = 20-bit, 40 = 40-bit)");
 
-static int tc_dwc_g210_pci_suspend(struct device *dev)
-{
-	return ufshcd_system_suspend(dev_get_drvdata(dev));
-}
-
-static int tc_dwc_g210_pci_resume(struct device *dev)
-{
-	return ufshcd_system_resume(dev_get_drvdata(dev));
-}
-
-static int tc_dwc_g210_pci_runtime_suspend(struct device *dev)
-{
-	return ufshcd_runtime_suspend(dev_get_drvdata(dev));
-}
-
-static int tc_dwc_g210_pci_runtime_resume(struct device *dev)
-{
-	return ufshcd_runtime_resume(dev_get_drvdata(dev));
-}
-
-static int tc_dwc_g210_pci_runtime_idle(struct device *dev)
-{
-	return ufshcd_runtime_idle(dev_get_drvdata(dev));
-}
-
 /*
  * struct ufs_hba_dwc_vops - UFS DWC specific variant operations
  */
@@ -143,11 +118,8 @@ tc_dwc_g210_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct dev_pm_ops tc_dwc_g210_pci_pm_ops = {
-	.suspend	= tc_dwc_g210_pci_suspend,
-	.resume		= tc_dwc_g210_pci_resume,
-	.runtime_suspend = tc_dwc_g210_pci_runtime_suspend,
-	.runtime_resume  = tc_dwc_g210_pci_runtime_resume,
-	.runtime_idle    = tc_dwc_g210_pci_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
diff --git a/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c b/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
index a1268e4f44d6..783ec43efa78 100644
--- a/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
+++ b/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
@@ -84,11 +84,8 @@ static int tc_dwc_g210_pltfm_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops tc_dwc_g210_pltfm_pm_ops = {
-	.suspend	= ufshcd_pltfrm_suspend,
-	.resume		= ufshcd_pltfrm_resume,
-	.runtime_suspend = ufshcd_pltfrm_runtime_suspend,
-	.runtime_resume  = ufshcd_pltfrm_runtime_resume,
-	.runtime_idle    = ufshcd_pltfrm_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 };
 
 static struct platform_driver tc_dwc_g210_pltfm_driver = {
diff --git a/drivers/scsi/ufs/ufs-exynos.c b/drivers/scsi/ufs/ufs-exynos.c
index cf46d6f86e0e..5aa096e5b6cc 100644
--- a/drivers/scsi/ufs/ufs-exynos.c
+++ b/drivers/scsi/ufs/ufs-exynos.c
@@ -1287,11 +1287,8 @@ static const struct of_device_id exynos_ufs_of_match[] = {
 };
 
 static const struct dev_pm_ops exynos_ufs_pm_ops = {
-	.suspend	= ufshcd_pltfrm_suspend,
-	.resume		= ufshcd_pltfrm_resume,
-	.runtime_suspend = ufshcd_pltfrm_runtime_suspend,
-	.runtime_resume  = ufshcd_pltfrm_runtime_resume,
-	.runtime_idle    = ufshcd_pltfrm_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 526b911655fe..3b4117ddb3c8 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -569,11 +569,8 @@ static int ufs_hisi_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops ufs_hisi_pm_ops = {
-	.suspend	= ufshcd_pltfrm_suspend,
-	.resume		= ufshcd_pltfrm_resume,
-	.runtime_suspend = ufshcd_pltfrm_runtime_suspend,
-	.runtime_resume  = ufshcd_pltfrm_runtime_resume,
-	.runtime_idle    = ufshcd_pltfrm_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index 32ae67e40086..fe6e678faa2c 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -1123,11 +1123,8 @@ static int ufs_mtk_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops ufs_mtk_pm_ops = {
-	.suspend         = ufshcd_pltfrm_suspend,
-	.resume          = ufshcd_pltfrm_resume,
-	.runtime_suspend = ufshcd_pltfrm_runtime_suspend,
-	.runtime_resume  = ufshcd_pltfrm_runtime_resume,
-	.runtime_idle    = ufshcd_pltfrm_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 9b1d18d7c9bb..9d9770f1db4f 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1546,11 +1546,8 @@ MODULE_DEVICE_TABLE(acpi, ufs_qcom_acpi_match);
 #endif
 
 static const struct dev_pm_ops ufs_qcom_pm_ops = {
-	.suspend	= ufshcd_pltfrm_suspend,
-	.resume		= ufshcd_pltfrm_resume,
-	.runtime_suspend = ufshcd_pltfrm_runtime_suspend,
-	.runtime_resume  = ufshcd_pltfrm_runtime_resume,
-	.runtime_idle    = ufshcd_pltfrm_runtime_idle,
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
 };
diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index e6c334bfb4c2..b3bcc5c882da 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -385,48 +385,6 @@ static struct ufs_hba_variant_ops ufs_intel_lkf_hba_vops = {
 	.device_reset		= ufs_intel_device_reset,
 };
 
-#ifdef CONFIG_PM_SLEEP
-/**
- * ufshcd_pci_suspend - suspend power management function
- * @dev: pointer to PCI device handle
- *
- * Returns 0 if successful
- * Returns non-zero otherwise
- */
-static int ufshcd_pci_suspend(struct device *dev)
-{
-	return ufshcd_system_suspend(dev_get_drvdata(dev));
-}
-
-/**
- * ufshcd_pci_resume - resume power management function
- * @dev: pointer to PCI device handle
- *
- * Returns 0 if successful
- * Returns non-zero otherwise
- */
-static int ufshcd_pci_resume(struct device *dev)
-{
-	return ufshcd_system_resume(dev_get_drvdata(dev));
-}
-
-#endif /* !CONFIG_PM_SLEEP */
-
-#ifdef CONFIG_PM
-static int ufshcd_pci_runtime_suspend(struct device *dev)
-{
-	return ufshcd_runtime_suspend(dev_get_drvdata(dev));
-}
-static int ufshcd_pci_runtime_resume(struct device *dev)
-{
-	return ufshcd_runtime_resume(dev_get_drvdata(dev));
-}
-static int ufshcd_pci_runtime_idle(struct device *dev)
-{
-	return ufshcd_runtime_idle(dev_get_drvdata(dev));
-}
-#endif /* !CONFIG_PM */
-
 /**
  * ufshcd_pci_shutdown - main function to put the controller in reset state
  * @pdev: pointer to PCI device handle
@@ -510,10 +468,8 @@ ufshcd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct dev_pm_ops ufshcd_pci_pm_ops = {
-	SET_RUNTIME_PM_OPS(ufshcd_pci_runtime_suspend,
-			   ufshcd_pci_runtime_resume,
-			   ufshcd_pci_runtime_idle)
-	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_pci_suspend, ufshcd_pci_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
+	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 #ifdef CONFIG_PM_SLEEP
 	.prepare	= ufshcd_suspend_prepare,
 	.complete	= ufshcd_resume_complete,
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 298e22ef907e..8859c13f4e09 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -170,53 +170,6 @@ static int ufshcd_parse_regulator_info(struct ufs_hba *hba)
 	return err;
 }
 
-#ifdef CONFIG_PM
-/**
- * ufshcd_pltfrm_suspend - suspend power management function
- * @dev: pointer to device handle
- *
- * Returns 0 if successful
- * Returns non-zero otherwise
- */
-int ufshcd_pltfrm_suspend(struct device *dev)
-{
-	return ufshcd_system_suspend(dev_get_drvdata(dev));
-}
-EXPORT_SYMBOL_GPL(ufshcd_pltfrm_suspend);
-
-/**
- * ufshcd_pltfrm_resume - resume power management function
- * @dev: pointer to device handle
- *
- * Returns 0 if successful
- * Returns non-zero otherwise
- */
-int ufshcd_pltfrm_resume(struct device *dev)
-{
-	return ufshcd_system_resume(dev_get_drvdata(dev));
-}
-EXPORT_SYMBOL_GPL(ufshcd_pltfrm_resume);
-
-int ufshcd_pltfrm_runtime_suspend(struct device *dev)
-{
-	return ufshcd_runtime_suspend(dev_get_drvdata(dev));
-}
-EXPORT_SYMBOL_GPL(ufshcd_pltfrm_runtime_suspend);
-
-int ufshcd_pltfrm_runtime_resume(struct device *dev)
-{
-	return ufshcd_runtime_resume(dev_get_drvdata(dev));
-}
-EXPORT_SYMBOL_GPL(ufshcd_pltfrm_runtime_resume);
-
-int ufshcd_pltfrm_runtime_idle(struct device *dev)
-{
-	return ufshcd_runtime_idle(dev_get_drvdata(dev));
-}
-EXPORT_SYMBOL_GPL(ufshcd_pltfrm_runtime_idle);
-
-#endif /* CONFIG_PM */
-
 void ufshcd_pltfrm_shutdown(struct platform_device *pdev)
 {
 	ufshcd_shutdown((struct ufs_hba *)platform_get_drvdata(pdev));
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.h b/drivers/scsi/ufs/ufshcd-pltfrm.h
index 772a8e848098..c33e28ac6ef6 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.h
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.h
@@ -33,22 +33,4 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		       const struct ufs_hba_variant_ops *vops);
 void ufshcd_pltfrm_shutdown(struct platform_device *pdev);
 
-#ifdef CONFIG_PM
-
-int ufshcd_pltfrm_suspend(struct device *dev);
-int ufshcd_pltfrm_resume(struct device *dev);
-int ufshcd_pltfrm_runtime_suspend(struct device *dev);
-int ufshcd_pltfrm_runtime_resume(struct device *dev);
-int ufshcd_pltfrm_runtime_idle(struct device *dev);
-
-#else /* !CONFIG_PM */
-
-#define ufshcd_pltfrm_suspend	NULL
-#define ufshcd_pltfrm_resume	NULL
-#define ufshcd_pltfrm_runtime_suspend	NULL
-#define ufshcd_pltfrm_runtime_resume	NULL
-#define ufshcd_pltfrm_runtime_idle	NULL
-
-#endif /* CONFIG_PM */
-
 #endif /* UFSHCD_PLTFRM_H_ */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5b31de83a63a..a34aa6d486c7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9204,15 +9204,17 @@ static int ufshcd_resume(struct ufs_hba *hba)
 }
 
 /**
- * ufshcd_system_suspend - system suspend routine
- * @hba: per adapter instance
+ * ufshcd_system_suspend - system suspend callback
+ * @dev: Device associated with the UFS controller.
  *
- * Check the description of ufshcd_suspend() function for more details.
+ * Executed before putting the system into a sleep state in which the contents
+ * of main memory are preserved.
  *
  * Returns 0 for success and non-zero for failure
  */
-int ufshcd_system_suspend(struct ufs_hba *hba)
+int ufshcd_system_suspend(struct device *dev)
 {
+	struct ufs_hba *hba = dev_get_drvdata(dev);
 	int ret = 0;
 	ktime_t start = ktime_get();
 
@@ -9229,16 +9231,19 @@ int ufshcd_system_suspend(struct ufs_hba *hba)
 EXPORT_SYMBOL(ufshcd_system_suspend);
 
 /**
- * ufshcd_system_resume - system resume routine
- * @hba: per adapter instance
+ * ufshcd_system_resume - system resume callback
+ * @dev: Device associated with the UFS controller.
+ *
+ * Executed after waking the system up from a sleep state in which the contents
+ * of main memory were preserved.
  *
  * Returns 0 for success and non-zero for failure
  */
-
-int ufshcd_system_resume(struct ufs_hba *hba)
+int ufshcd_system_resume(struct device *dev)
 {
-	int ret = 0;
+	struct ufs_hba *hba = dev_get_drvdata(dev);
 	ktime_t start = ktime_get();
+	int ret = 0;
 
 	if (pm_runtime_suspended(hba->dev))
 		goto out;
@@ -9255,15 +9260,16 @@ int ufshcd_system_resume(struct ufs_hba *hba)
 EXPORT_SYMBOL(ufshcd_system_resume);
 
 /**
- * ufshcd_runtime_suspend - runtime suspend routine
- * @hba: per adapter instance
+ * ufshcd_runtime_suspend - runtime suspend callback
+ * @dev: Device associated with the UFS controller.
  *
  * Check the description of ufshcd_suspend() function for more details.
  *
  * Returns 0 for success and non-zero for failure
  */
-int ufshcd_runtime_suspend(struct ufs_hba *hba)
+int ufshcd_runtime_suspend(struct device *dev)
 {
+	struct ufs_hba *hba = dev_get_drvdata(dev);
 	int ret;
 	ktime_t start = ktime_get();
 
@@ -9278,7 +9284,7 @@ EXPORT_SYMBOL(ufshcd_runtime_suspend);
 
 /**
  * ufshcd_runtime_resume - runtime resume routine
- * @hba: per adapter instance
+ * @dev: Device associated with the UFS controller.
  *
  * This function basically brings controller
  * to active state. Following operations are done in this function:
@@ -9286,8 +9292,9 @@ EXPORT_SYMBOL(ufshcd_runtime_suspend);
  * 1. Turn on all the controller related clocks
  * 2. Turn ON VCC rail
  */
-int ufshcd_runtime_resume(struct ufs_hba *hba)
+int ufshcd_runtime_resume(struct device *dev)
 {
+	struct ufs_hba *hba = dev_get_drvdata(dev);
 	int ret;
 	ktime_t start = ktime_get();
 
@@ -9300,12 +9307,6 @@ int ufshcd_runtime_resume(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL(ufshcd_runtime_resume);
 
-int ufshcd_runtime_idle(struct ufs_hba *hba)
-{
-	return 0;
-}
-EXPORT_SYMBOL(ufshcd_runtime_idle);
-
 /**
  * ufshcd_shutdown - shutdown routine
  * @hba: per adapter instance
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index c98d540ac044..dc75426c609f 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1009,11 +1009,10 @@ static inline u8 ufshcd_wb_get_query_index(struct ufs_hba *hba)
 	return 0;
 }
 
-extern int ufshcd_runtime_suspend(struct ufs_hba *hba);
-extern int ufshcd_runtime_resume(struct ufs_hba *hba);
-extern int ufshcd_runtime_idle(struct ufs_hba *hba);
-extern int ufshcd_system_suspend(struct ufs_hba *hba);
-extern int ufshcd_system_resume(struct ufs_hba *hba);
+extern int ufshcd_runtime_suspend(struct device *dev);
+extern int ufshcd_runtime_resume(struct device *dev);
+extern int ufshcd_system_suspend(struct device *dev);
+extern int ufshcd_system_resume(struct device *dev);
 extern int ufshcd_shutdown(struct ufs_hba *hba);
 extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 				      int agreed_gear,
