Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8193727FF1C
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Oct 2020 14:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJAMa7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Oct 2020 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732180AbgJAMa7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Oct 2020 08:30:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EF5C0613D0;
        Thu,  1 Oct 2020 05:30:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so4334959pfn.9;
        Thu, 01 Oct 2020 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2Jimmslu4qP6milaPXPNgv6BhHWWJb4M6uEgyL5FY0=;
        b=S4vxVY6vZO+1XCsgvAOsJJpRSO9TihhxfLtpAR1s0R/IBlYYTF7ybcC658ZnEe12F2
         Tk81IBH5+gLSAqhiv0o7rgCS/lklNlonTjzJsdLm6V/4E/t7mUUzyMrGCYzcg/GbYFqJ
         E7lIXhCoCnvwl1oLYJQqgDnDPXewWk8nC6rVAjQlhqLDC4jJiZIAyK5UbiJKqySIC2vn
         ZsK+mLFYwNoeaYcm9zTen7U93+MLn6+WUYoNc0NUZhGdJ/yHyX/uJensNAedmyV/LPDH
         Bkfwt9Vx/f5BIURumhSN6NSGKgmCz2tGvnnOgXhU8UWQKvAypwTQnF64NQEbJSrJubqJ
         et/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2Jimmslu4qP6milaPXPNgv6BhHWWJb4M6uEgyL5FY0=;
        b=WpwG3VRmV6jsZB369eWaTwtZLnSnROfbAvnLNcVMoeBRhFEUV6Juu9cS2BByRA29ot
         lLgg+A6zMcVXiKBsG1VBCsCHDIx8OYAXiRY6rL2Wnvgvd4lMTF8xbPVJrm4ArNX1V7Ci
         XSgQA8vlkmJPatnHkNyYtGONZ0tobOJFYDB/hWUCOAimAm5WsS7wwB+DqPiB5jofhQFj
         xXAaIQ8KDZuA7Y4LlPybCbIl6dTzyZD/fApERr7qvLIA+f+/DhXUQQs5dwt31pVSIDhR
         mXvfZqM3Q2MeCdY1TBQGD9+hnTceb1TiGcyp4SaaKb1SsDJVPxJVL3Ou6i4qt7ZDGlqn
         rfYw==
X-Gm-Message-State: AOAM53109iqzlfl3/J1PXVrb1LkJnXxIcy1goNMbuGNjPIvzmWVsLJSV
        ax/0U5UP9DO2ULo/2BVZmsmX2tnQFgQdCA7f
X-Google-Smtp-Source: ABdhPJzFT+8I0OSlV2t152hgKtHTxC98pvTJk2S0gTh62JrgFAbw9Wf4H3LkAr5KLgeavlTYpnSv7w==
X-Received: by 2002:a17:902:8f8f:b029:d2:4276:1b2d with SMTP id z15-20020a1709028f8fb02900d242761b2dmr7247496plo.17.1601555459098;
        Thu, 01 Oct 2020 05:30:59 -0700 (PDT)
Received: from varodek.localdomain ([171.61.143.130])
        by smtp.gmail.com with ESMTPSA id m13sm5695199pjl.45.2020.10.01.05.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 05:30:58 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Hannes Reinecke <hare@suse.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v3 18/28] scsi: pm_8001: use generic power management
Date:   Thu,  1 Oct 2020 17:55:01 +0530
Message-Id: <20201001122511.1075420-19-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001122511.1075420-1-vaibhavgupta40@gmail.com>
References: <20201001122511.1075420-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Drivers should do only device-specific jobs. But in general, drivers using
legacy PCI PM framework for .suspend()/.resume() have to manage many PCI
PM-related tasks themselves which can be done by PCI Core itself. This
brings extra load on the driver and it directly calls PCI helper functions
to handle them.

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. Also, remove
unnecessary calls to the PCI Helper functions along with the legacy
.suspend & .resume bindings.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 45 +++++++++++--------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ee27ecb17560..62dc30a45ac4 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1178,23 +1178,21 @@ static void pm8001_pci_remove(struct pci_dev *pdev)
 
 /**
  * pm8001_pci_suspend - power management suspend main entry point
- * @pdev: PCI device struct
- * @state: PM state change to (usually PCI_D3)
+ * @dev: Device struct
  *
  * Returns 0 success, anything else error.
  */
-static int pm8001_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused pm8001_pci_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sas_ha_struct *sha = pci_get_drvdata(pdev);
-	struct pm8001_hba_info *pm8001_ha;
+	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 	int  i, j;
-	u32 device_state;
-	pm8001_ha = sha->lldd_ha;
 	sas_suspend_ha(sha);
 	flush_workqueue(pm8001_wq);
 	scsi_block_requests(pm8001_ha->shost);
 	if (!pdev->pm_cap) {
-		dev_err(&pdev->dev, " PCI PM not supported\n");
+		dev_err(dev, " PCI PM not supported\n");
 		return -ENODEV;
 	}
 	PM8001_CHIP_DISP->interrupt_disable(pm8001_ha, 0xFF);
@@ -1217,24 +1215,21 @@ static int pm8001_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 		for (j = 0; j < PM8001_MAX_MSIX_VEC; j++)
 			tasklet_kill(&pm8001_ha->tasklet[j]);
 #endif
-	device_state = pci_choose_state(pdev, state);
 	pm8001_printk("pdev=0x%p, slot=%s, entering "
-		      "operating state [D%d]\n", pdev,
-		      pm8001_ha->name, device_state);
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, device_state);
+		"suspended state\n", pdev,
+		pm8001_ha->name);
 	return 0;
 }
 
 /**
  * pm8001_pci_resume - power management resume main entry point
- * @pdev: PCI device struct
+ * @dev: Device struct
  *
  * Returns 0 success, anything else error.
  */
-static int pm8001_pci_resume(struct pci_dev *pdev)
+static int __maybe_unused pm8001_pci_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sas_ha_struct *sha = pci_get_drvdata(pdev);
 	struct pm8001_hba_info *pm8001_ha;
 	int rc;
@@ -1247,16 +1242,6 @@ static int pm8001_pci_resume(struct pci_dev *pdev)
 	pm8001_printk("pdev=0x%p, slot=%s, resuming from previous "
 		"operating state [D%d]\n", pdev, pm8001_ha->name, device_state);
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	rc = pci_enable_device(pdev);
-	if (rc) {
-		pm8001_printk("slot=%s Enable device failed during resume\n",
-			      pm8001_ha->name);
-		goto err_out_enable;
-	}
-
-	pci_set_master(pdev);
 	rc = pci_go_44(pdev);
 	if (rc)
 		goto err_out_disable;
@@ -1317,8 +1302,7 @@ static int pm8001_pci_resume(struct pci_dev *pdev)
 
 err_out_disable:
 	scsi_remove_host(pm8001_ha->shost);
-	pci_disable_device(pdev);
-err_out_enable:
+
 	return rc;
 }
 
@@ -1401,13 +1385,16 @@ static struct pci_device_id pm8001_pci_table[] = {
 	{} /* terminate list */
 };
 
+static SIMPLE_DEV_PM_OPS(pm8001_pci_pm_ops,
+			 pm8001_pci_suspend,
+			 pm8001_pci_resume);
+
 static struct pci_driver pm8001_pci_driver = {
 	.name		= DRV_NAME,
 	.id_table	= pm8001_pci_table,
 	.probe		= pm8001_pci_probe,
 	.remove		= pm8001_pci_remove,
-	.suspend	= pm8001_pci_suspend,
-	.resume		= pm8001_pci_resume,
+	.driver.pm	= &pm8001_pci_pm_ops,
 };
 
 /**
-- 
2.28.0

