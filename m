Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F62A304A
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 17:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKBQvj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 11:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgKBQvj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 11:51:39 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F932C0617A6;
        Mon,  2 Nov 2020 08:51:39 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t6so7086185plq.11;
        Mon, 02 Nov 2020 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rkeme0HWV2vGIGAMlkCl1UyOrxrPPWM02ZKhUnuADDY=;
        b=MVIGolkAxm9wL3HFLSzBrHr4RCbLS5hSYygOp5T65SYrlSe9dW1NgOWGohX//YkaGX
         pW+RhEBrR0hSAtGL7Ua+0fJ3X5OKNXfYzpqvEYCfxV/ugd3d7dzcgGALRgjb39aHN0t2
         kW2ytvt05l1mFlE8DSJa/UCZetJRRY9EYJrwkXI2fpx+Nb2kGazlJ5yDLTSB9MjIlQnt
         FPto44U4wMEFqrmQQRtQgJ4ucMaXxvqnGSY1V89ji6PN0f3MNxXyAXPwJipJdn/v2rkH
         ApS/zKPsGPYZ8tga7K9gwTxocryAqiulZWQm0AAO4LcMD+RaG56+LBUvn3b9nTm9RCei
         eQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rkeme0HWV2vGIGAMlkCl1UyOrxrPPWM02ZKhUnuADDY=;
        b=dXNHOO2iMN1x7mCoFaA09w+t92fsxoUMD0Hm+9DWt94Yy72MxxyU3tHWwO2VvtaSGx
         7KcfLDgQvSuO1PdMXBLlVgEfN8+CUKqvvWC6ngETM8fAOxI0ETsHiHNxaA5DZ2hz4KvP
         DMGil1N46UG7meAebFGC9sz6qJQO+Dv5VWjBsnAyAPD8+ZEC1avO8lg3USB7XKuQi9HX
         8J5AT2Gxsx90UB+ABcSilHn9iwLmh/e5JXvFJHD7y5y092MXMEKe/vZFZQEQPUQ2DnHg
         XNd0OMsMalGq3ee9lpNCRmpuEs4TK29LxYu/pGpGxNdQ9yjL+bZyH9Fk0XYXkDZ7YUCs
         I7Eg==
X-Gm-Message-State: AOAM533v4rEYe+lvYZtNIch2Ib/LTXPPwwCaaMN5Iv5pMHRBTrEhfB+v
        DO47UCp9ljqGL5g+ProwU8ij7XMXcb+5Xg==
X-Google-Smtp-Source: ABdhPJwPTJkQo+eyulLgDesYWM3zj+Bn4umMf0gblMnQTVE2tWeRwAcD0M5KtQ7iNDdU2kCnXjCNMQ==
X-Received: by 2002:a17:902:6909:b029:d6:6ec4:e1f7 with SMTP id j9-20020a1709026909b02900d66ec4e1f7mr14719882plk.40.1604335899053;
        Mon, 02 Nov 2020 08:51:39 -0800 (PST)
Received: from varodek.localdomain ([223.179.149.110])
        by smtp.gmail.com with ESMTPSA id t74sm4953233pfc.47.2020.11.02.08.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:51:38 -0800 (PST)
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
        Xiang Chen <chenxiang66@hisilicon.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Balsundar P <balsundar.p@microchip.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v4 06/29] scsi: aic7xxx: use generic power management
Date:   Mon,  2 Nov 2020 22:17:07 +0530
Message-Id: <20201102164730.324035-7-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102164730.324035-1-vaibhavgupta40@gmail.com>
References: <20201102164730.324035-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

use generic power management

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
 drivers/scsi/aic7xxx/aic7xxx.h         | 10 ++----
 drivers/scsi/aic7xxx/aic7xxx_core.c    |  6 ++--
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c | 46 ++++++--------------------
 drivers/scsi/aic7xxx/aic7xxx_pci.c     |  4 +--
 4 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx.h b/drivers/scsi/aic7xxx/aic7xxx.h
index 88b90f9806c9..11a09798e6b5 100644
--- a/drivers/scsi/aic7xxx/aic7xxx.h
+++ b/drivers/scsi/aic7xxx/aic7xxx.h
@@ -1134,9 +1134,7 @@ const struct ahc_pci_identity	*ahc_find_pci_device(ahc_dev_softc_t);
 int			 ahc_pci_config(struct ahc_softc *,
 					const struct ahc_pci_identity *);
 int			 ahc_pci_test_register_access(struct ahc_softc *);
-#ifdef CONFIG_PM
-void			 ahc_pci_resume(struct ahc_softc *ahc);
-#endif
+void __maybe_unused	 ahc_pci_resume(struct ahc_softc *ahc);
 
 /*************************** EISA/VL Front End ********************************/
 struct aic7770_identity *aic7770_find_device(uint32_t);
@@ -1160,10 +1158,8 @@ int			 ahc_chip_init(struct ahc_softc *ahc);
 int			 ahc_init(struct ahc_softc *ahc);
 void			 ahc_intr_enable(struct ahc_softc *ahc, int enable);
 void			 ahc_pause_and_flushwork(struct ahc_softc *ahc);
-#ifdef CONFIG_PM
-int			 ahc_suspend(struct ahc_softc *ahc); 
-int			 ahc_resume(struct ahc_softc *ahc);
-#endif
+int __maybe_unused	 ahc_suspend(struct ahc_softc *ahc);
+int __maybe_unused	 ahc_resume(struct ahc_softc *ahc);
 void			 ahc_set_unit(struct ahc_softc *, int);
 void			 ahc_set_name(struct ahc_softc *, char *);
 void			 ahc_free(struct ahc_softc *ahc);
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index 725bb7f58054..4ef7af8c0f55 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -5590,8 +5590,7 @@ ahc_pause_and_flushwork(struct ahc_softc *ahc)
 	ahc->flags &= ~AHC_ALL_INTERRUPTS;
 }
 
-#ifdef CONFIG_PM
-int
+int __maybe_unused
 ahc_suspend(struct ahc_softc *ahc)
 {
 
@@ -5617,7 +5616,7 @@ ahc_suspend(struct ahc_softc *ahc)
 	return (0);
 }
 
-int
+int __maybe_unused
 ahc_resume(struct ahc_softc *ahc)
 {
 
@@ -5626,7 +5625,6 @@ ahc_resume(struct ahc_softc *ahc)
 	ahc_restart(ahc);
 	return (0);
 }
-#endif
 /************************** Busy Target Table *********************************/
 /*
  * Return the untagged transaction id for a given target/channel lun.
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
index 9b293b1f0b71..a07e94fac673 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -121,47 +121,23 @@ static const struct pci_device_id ahc_linux_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, ahc_linux_pci_id_table);
 
-#ifdef CONFIG_PM
-static int
-ahc_linux_pci_dev_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int __maybe_unused
+ahc_linux_pci_dev_suspend(struct device *dev)
 {
-	struct ahc_softc *ahc = pci_get_drvdata(pdev);
-	int rc;
-
-	if ((rc = ahc_suspend(ahc)))
-		return rc;
+	struct ahc_softc *ahc = dev_get_drvdata(dev);
 
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-
-	if (mesg.event & PM_EVENT_SLEEP)
-		pci_set_power_state(pdev, PCI_D3hot);
-
-	return rc;
+	return ahc_suspend(ahc);
 }
 
-static int
-ahc_linux_pci_dev_resume(struct pci_dev *pdev)
+static int __maybe_unused
+ahc_linux_pci_dev_resume(struct device *dev)
 {
-	struct ahc_softc *ahc = pci_get_drvdata(pdev);
-	int rc;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
-	if ((rc = pci_enable_device(pdev))) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			   "failed to enable device after resume (%d)\n", rc);
-		return rc;
-	}
-
-	pci_set_master(pdev);
+	struct ahc_softc *ahc = dev_get_drvdata(dev);
 
 	ahc_pci_resume(ahc);
 
 	return (ahc_resume(ahc));
 }
-#endif
 
 static void
 ahc_linux_pci_dev_remove(struct pci_dev *pdev)
@@ -319,14 +295,14 @@ ahc_pci_write_config(ahc_dev_softc_t pci, int reg, uint32_t value, int width)
 	}
 }
 
+static SIMPLE_DEV_PM_OPS(ahc_linux_pci_dev_pm_ops,
+			 ahc_linux_pci_dev_suspend,
+			 ahc_linux_pci_dev_resume);
 
 static struct pci_driver aic7xxx_pci_driver = {
 	.name		= "aic7xxx",
 	.probe		= ahc_linux_pci_dev_probe,
-#ifdef CONFIG_PM
-	.suspend	= ahc_linux_pci_dev_suspend,
-	.resume		= ahc_linux_pci_dev_resume,
-#endif
+	.driver.pm	= &ahc_linux_pci_dev_pm_ops,
 	.remove		= ahc_linux_pci_dev_remove,
 	.id_table	= ahc_linux_pci_id_table
 };
diff --git a/drivers/scsi/aic7xxx/aic7xxx_pci.c b/drivers/scsi/aic7xxx/aic7xxx_pci.c
index 656f680c7802..dab3a6d12c4d 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_pci.c
@@ -2008,8 +2008,7 @@ ahc_pci_chip_init(struct ahc_softc *ahc)
 	return (ahc_chip_init(ahc));
 }
 
-#ifdef CONFIG_PM
-void
+void __maybe_unused
 ahc_pci_resume(struct ahc_softc *ahc)
 {
 	/*
@@ -2040,7 +2039,6 @@ ahc_pci_resume(struct ahc_softc *ahc)
 		ahc_release_seeprom(&sd);
 	}
 }
-#endif
 
 static int
 ahc_aic785X_setup(struct ahc_softc *ahc)
-- 
2.28.0

