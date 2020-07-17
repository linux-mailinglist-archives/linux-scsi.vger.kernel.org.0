Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB802234AE
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Jul 2020 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGQGgu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Jul 2020 02:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQGgu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Jul 2020 02:36:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77BC061755;
        Thu, 16 Jul 2020 23:36:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f16so5912846pjt.0;
        Thu, 16 Jul 2020 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aKAKc3QV9tSVn9rtnXDsVWLu3x/6YoSShniIPxhNVg=;
        b=n9pgpB8bQLOGLfjLxLeMbtPFcKmi6Xl/eDdz2z3YJMaCgmrX8JpdyOElxOpIjLExcV
         iQyXZdXbLXVqIxkueyNAsROiWsPe5eTOxR9iX5XA7wmmsOXME9+7Ezoy4lu82xiIU0kD
         cZBp8gYy2chvC4Cjp66PQrdEFzWGgAqQXIkL3+XiAA9SBz2DEAU5s2QHI0dvdRRVTcKP
         kXRoqOHadD8NhWd9Krm7i41kHZHL+b0CFN6msqLkv8tpwT+lrn+aQbNF6i/epvr+10jh
         +C7rkrpoqkmN2oFT0yjxLBSxVIpY8QJHB5Puw3s6lpt9k+r0O/p1ieNc9hTQM+yYjf7P
         d8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aKAKc3QV9tSVn9rtnXDsVWLu3x/6YoSShniIPxhNVg=;
        b=K3FfaV3GTZkBAjxL0Z10NseKTW/fu7NgsyHxhjIsa5YT6w1vafIE16uk6Ey8FlDAFr
         JrFGFf+XkgI2oU6+mgL9NdKd9gJgP82ueWP2evzXMTsR4Onp8eHj09XBm8J6gLVhIxj4
         9w4nzFO1xsD7m7fK2kg1XIR/EhgPsjitIxnfvNvIbTOO7kDn3RSHvg9LVGpTcv/3Vyyv
         RtkPuhlhlgq/DEoLhOd3Wxncsb6X18d+WJQmCNI7GRFPZFVMWzyd7gX8uWcpJyVYm6CB
         aQrsZZzFsrKpYYkZGd0Rebqc3SiP7eYXUXp0uAdPFUUjz660UlE6dVspMOtRTx+XBhvI
         rqeg==
X-Gm-Message-State: AOAM532M8+kjgY+h+mSixHZ+HLx9pv+1CWDpSrwaqQMLcT3ZH5Xw8aAZ
        ZHwxgvjv6oshVRp7MIh/N7Y=
X-Google-Smtp-Source: ABdhPJxZmWU9b6pfr/qFTvlbVtaE+f6A7i14Jq/8iwcASIM7NsFEQXR7BELCsdTLfEAPbAYspXVKQA==
X-Received: by 2002:a17:90a:8904:: with SMTP id u4mr8897461pjn.87.1594967809674;
        Thu, 16 Jul 2020 23:36:49 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id y22sm1683392pjp.41.2020.07.16.23.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 23:36:49 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
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
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v1 03/15] scsi: aic7xxx: use generic power management
Date:   Fri, 17 Jul 2020 12:04:26 +0530
Message-Id: <20200717063438.175022-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717063438.175022-1-vaibhavgupta40@gmail.com>
References: <20200717063438.175022-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

With legacy PM hooks, it was the responsibility of a driver to manage PCI
states and also the device's power state. The generic approach is to let
the PCI core handle the work.

PCI core passes "struct device*" as an argument to the .suspend() and
.resume() callbacks.

Driver was using PCI helper functions like pci_save/restore_state(),
pci_disable/enable_device(), pci_set_power_state() and pci_enable_wake().
They should not be invoked by the driver.

Also, .suspend() and .resume() are invoking other functions for PM, which
were againg bounded by "#ifdef CONFIG_PM" directive. Remove the directive
and mark those functions as "__maybe_unused".

Compile-tested only.

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
index 3d4df906fa4f..c7eb238a9599 100644
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
2.27.0

