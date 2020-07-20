Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC1226120
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgGTNiw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Jul 2020 09:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgGTNiv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Jul 2020 09:38:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB6C061794;
        Mon, 20 Jul 2020 06:38:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so10123364pjb.1;
        Mon, 20 Jul 2020 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwDPleRnNmF5nIya5pCRA/s+OZ7smPPXMDZ4egsrQq8=;
        b=srTKLcUk8HebhhSPqZECa68ZYvqmIBEEJHZLxD64ASuiBlRaZ582SQBExeJt0rnGXv
         zdBGY80UkV8b8lQt0Ec9pJmVerBbQmDrkWjqXWfaYVoY7egex0QQBk6W5/ynmwao5UkD
         fHtDFJENW6zYilGkiVZi1h7Xf/UmHG/vT239U1/C+PbNf6XErDln+vgxyCe3Fdd0LSCs
         Ho9FKOQyLYkWuVNTqXnXCcXV6W/swtNYbJr3McVzVO9pWctAP8a38Gln396NYDGGP6IJ
         hNqRGMxxQFMHyyB2Djuk1nls4MUtc32XYQRH/HGan+9TBp9bxUYydOYxm3jbf1VpCf4c
         6FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwDPleRnNmF5nIya5pCRA/s+OZ7smPPXMDZ4egsrQq8=;
        b=miengSoPEGk2AwOjFCrO94GSUQaSNGIn8PzEn3z8KeY8YM0yBJYgVMSxeoJJzYW+DU
         XfV/vEBUnDDfGwUkLq95bz5b8DhJ2L+mOGK1Sr7MXwUfzbD0XeqklTKqV2rjuL0f5tV/
         QOTXWaMg5ykIgrec9dyJR6RqVEzkanPrh/eJzmGvJO1ercR3lZ6Q5Ewl1NyJ1g3hjuBL
         7YyrWOMlYgBrYRnC0pTQRmLu+wG0dfqoX85vd0XXPxXgeXvg7cLwN87FnSis+bQ++d84
         6evrdSCaXLvXJ6To2h7pRqcISmd2mLJ2N/w6yKv4PzmPVpTF7+GOYgiK9caVB2k46tP0
         xieg==
X-Gm-Message-State: AOAM530yzsUsxD4lpvqAFubRtaTk33HUYWDt8DoCKFtA5mN7ajzcKuXq
        6PmxMKKYWeQ8ohW41sQFHN8=
X-Google-Smtp-Source: ABdhPJzhxWkMegVPPIMDV/AO8rBKSdJjRz/A+cntjd7+YbWn+VkyqFp6HBuEO10AOZp2eEYX+9tyGw==
X-Received: by 2002:a17:902:9a0a:: with SMTP id v10mr17929936plp.134.1595252330830;
        Mon, 20 Jul 2020 06:38:50 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id s6sm17042183pfd.20.2020.07.20.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:38:50 -0700 (PDT)
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
Subject: [PATCH v2 14/15] scsi: mvumi: use generic power management
Date:   Mon, 20 Jul 2020 19:04:27 +0530
Message-Id: <20200720133427.454400-15-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720133427.454400-1-vaibhavgupta40@gmail.com>
References: <20200720133427.454400-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state(), pci_enable/disable_device(),
pci_set_power_state() and pci_set_master() to do required operations. In
generic mode, they are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use dev_get_drvdata() to get drv data.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/scsi/mvumi.c | 49 ++++++++++----------------------------------
 1 file changed, 11 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 8906aceda4c4..7a6ef8264e47 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2558,7 +2558,7 @@ static void mvumi_detach_one(struct pci_dev *pdev)
 
 /**
  * mvumi_shutdown -	Shutdown entry point
- * @device:		Generic device structure
+ * @pdev:		PCI device structure
  */
 static void mvumi_shutdown(struct pci_dev *pdev)
 {
@@ -2567,47 +2567,28 @@ static void mvumi_shutdown(struct pci_dev *pdev)
 	mvumi_flush_cache(mhba);
 }
 
-static int __maybe_unused mvumi_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused mvumi_suspend(struct device *dev)
 {
-	struct mvumi_hba *mhba = NULL;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	mhba = pci_get_drvdata(pdev);
+	struct mvumi_hba *mhba = pci_get_drvdata(pdev);
 	mvumi_flush_cache(mhba);
 
-	pci_set_drvdata(pdev, mhba);
 	mhba->instancet->disable_intr(mhba);
-	free_irq(mhba->pdev->irq, mhba);
 	mvumi_unmap_pci_addr(pdev, mhba->base_addr);
-	pci_release_regions(pdev);
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
 
-static int __maybe_unused mvumi_resume(struct pci_dev *pdev)
+static int __maybe_unused mvumi_resume(struct device *dev)
 {
 	int ret;
-	struct mvumi_hba *mhba = NULL;
-
-	mhba = pci_get_drvdata(pdev);
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_enable_wake(pdev, PCI_D0, 0);
-	pci_restore_state(pdev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct mvumi_hba *mhba = pci_get_drvdata(pdev);
 
-	ret = pci_enable_device(pdev);
-	if (ret) {
-		dev_err(&pdev->dev, "enable device failed\n");
-		return ret;
-	}
+	device_wakeup_disable(dev);
 
-	ret = mvumi_pci_set_master(pdev);
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto fail;
-	ret = pci_request_regions(mhba->pdev, MV_DRIVER_NAME);
 	if (ret)
 		goto fail;
 	ret = mvumi_map_pci_addr(mhba->pdev, mhba->base_addr);
@@ -2627,12 +2608,6 @@ static int __maybe_unused mvumi_resume(struct pci_dev *pdev)
 		goto unmap_pci_addr;
 	}
 
-	ret = request_irq(mhba->pdev->irq, mvumi_isr_handler, IRQF_SHARED,
-				"mvumi", mhba);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register IRQ\n");
-		goto unmap_pci_addr;
-	}
 	mhba->instancet->enable_intr(mhba);
 
 	return 0;
@@ -2642,11 +2617,12 @@ static int __maybe_unused mvumi_resume(struct pci_dev *pdev)
 release_regions:
 	pci_release_regions(pdev);
 fail:
-	pci_disable_device(pdev);
 
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(mvumi_pm_ops, mvumi_suspend, mvumi_resume);
+
 static struct pci_driver mvumi_pci_driver = {
 
 	.name = MV_DRIVER_NAME,
@@ -2654,10 +2630,7 @@ static struct pci_driver mvumi_pci_driver = {
 	.probe = mvumi_probe_one,
 	.remove = mvumi_detach_one,
 	.shutdown = mvumi_shutdown,
-#ifdef CONFIG_PM
-	.suspend = mvumi_suspend,
-	.resume = mvumi_resume,
-#endif
+	.driver.pm = &mvumi_pm_ops,
 };
 
 module_pci_driver(mvumi_pci_driver);
-- 
2.27.0

