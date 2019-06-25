Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5398654D22
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfFYLFA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37617 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLE7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:04:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so8649453plb.4
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTW9Jfhqa3WzeDUCjzlQ1hjebGSFomDtiNWcykKm+Kw=;
        b=OWmBReklaDXx4th2BrPSCrFgIjxxVD+Or6UNYj/toE397SB08Iang4UA4Z+2fT/YRa
         cw0rbXLx6XQ6PmiB2lQH6sMCLHVeThNaAymaZCXd7wFMmhFOV1TqGgDaFwr770imqnXZ
         e0cbQ94vBCGmvW5ob9IgbMcOYFf1VxqVxgCCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTW9Jfhqa3WzeDUCjzlQ1hjebGSFomDtiNWcykKm+Kw=;
        b=WJ5L/vtjoHj7fFH2/6vp061djiB6NfUWxx51Orm6y0dS2SkoR8UdRJHchwT6IP0p2y
         bdtA1Hg//uOxdejg8d7QIF/jcAflV760FHWLlJVFO38gUsxAnZxAXFL0dJMLYCVzdiby
         HZ4y1BSSAxqRHGKQ3qsFEo0jpcW2uiOJxkEkiuCj429B9jGMovYpylNfr6jBWlC+eksp
         +oxYjPyinF7TAHU6FBLA+NMdJJ2T4+mnuY9PFcU+rwc3XJGjhuaDKlyzPSTTPaiBfSQW
         xvCXKHFOvLp0+sO+OWdCoMUyk4EYiDv0Obv1LYupzMKF26o5WsKimAfFYgxUycdRCIKL
         hpvg==
X-Gm-Message-State: APjAAAU/GH1ktR+0ZyEieqZ0yDPfvwko/UgQxbhJ8KBzMhmvpidHPQOS
        ZnYMde5JpjC6/RrWCt6rZsO0+yv4qSTtMdYcTL2S9+yKeXF/QyVihrIY6hZZ+2qJj5iCbUjgC/a
        2VGTcyV1IzZdkeS6ezs7zjROCVYTz/ILyEsL8ylbDvVTdQNnaLUsSR7AR5OK6NYl7M1wF2vj1wo
        ij1wo4AHm0frpa
X-Google-Smtp-Source: APXvYqx0ctpgdj5vA1ZJF4Q7xytpafO3AlzZlVhUqKQD/DvIRNwkNjWNEQSAMbtgk6GIsFH0S94BIg==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr77310483plk.247.1561460698600;
        Tue, 25 Jun 2019 04:04:58 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.04.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:04:58 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 02/18] megaraid_sas: Add support for Non-secure Aero PCI IDs
Date:   Tue, 25 Jun 2019 16:34:20 +0530
Message-Id: <20190625110436.4703-3-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch will add support for Non-secure Aero adapters' PCI IDs.
Driver will throw an error message when a non-secure type controller
is detected. Purpose of this interface is to avoid interacting with
any firmware which is not secured/signed by Broadcom. Any tampering on
Firmware component will be detected by hardware and it will be
communicated to the driver to avoid any further interaction with
that component.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h      |  4 ++++
 drivers/scsi/megaraid/megaraid_sas_base.c | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index a08dd9c..61bcf7a 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -64,6 +64,10 @@
 #define PCI_DEVICE_ID_LSI_AERO_10E2		0x10e2
 #define PCI_DEVICE_ID_LSI_AERO_10E5		0x10e5
 #define PCI_DEVICE_ID_LSI_AERO_10E6		0x10e6
+#define PCI_DEVICE_ID_LSI_AERO_10E0		0x10e0
+#define PCI_DEVICE_ID_LSI_AERO_10E3		0x10e3
+#define PCI_DEVICE_ID_LSI_AERO_10E4		0x10e4
+#define PCI_DEVICE_ID_LSI_AERO_10E7		0x10e7
 
 /*
  * Intel HBA SSDIDs
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 5490898..7d1cf4e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -168,6 +168,10 @@ static struct pci_device_id megasas_pci_table[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_AERO_10E2)},
 	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_AERO_10E5)},
 	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_AERO_10E6)},
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_AERO_10E0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_AERO_10E3)},
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_AERO_10E4)},
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_AERO_10E7)},
 	{}
 };
 
@@ -6991,6 +6995,12 @@ static int megasas_probe_one(struct pci_dev *pdev,
 	u16 control = 0;
 
 	switch (pdev->device) {
+	case PCI_DEVICE_ID_LSI_AERO_10E0:
+	case PCI_DEVICE_ID_LSI_AERO_10E3:
+	case PCI_DEVICE_ID_LSI_AERO_10E4:
+	case PCI_DEVICE_ID_LSI_AERO_10E7:
+		dev_err(&pdev->dev, "Adapter is in non secure mode\n");
+		return 1;
 	case PCI_DEVICE_ID_LSI_AERO_10E1:
 	case PCI_DEVICE_ID_LSI_AERO_10E5:
 		dev_info(&pdev->dev, "Adapter is in configurable secure mode\n");
@@ -7246,6 +7256,10 @@ megasas_suspend(struct pci_dev *pdev, pm_message_t state)
 	struct megasas_instance *instance;
 
 	instance = pci_get_drvdata(pdev);
+
+	if (!instance)
+		return 0;
+
 	instance->unload = 1;
 
 	dev_info(&pdev->dev, "%s is called\n", __func__);
@@ -7299,6 +7313,10 @@ megasas_resume(struct pci_dev *pdev)
 	int irq_flags = PCI_IRQ_LEGACY;
 
 	instance = pci_get_drvdata(pdev);
+
+	if (!instance)
+		return 0;
+
 	host = instance->host;
 	pci_set_power_state(pdev, PCI_D0);
 	pci_enable_wake(pdev, PCI_D0, 0);
@@ -7467,6 +7485,10 @@ static void megasas_detach_one(struct pci_dev *pdev)
 	u32 pd_seq_map_sz;
 
 	instance = pci_get_drvdata(pdev);
+
+	if (!instance)
+		return;
+
 	host = instance->host;
 	fusion = instance->ctrl_context;
 
@@ -7595,6 +7617,9 @@ static void megasas_shutdown(struct pci_dev *pdev)
 {
 	struct megasas_instance *instance = pci_get_drvdata(pdev);
 
+	if (!instance)
+		return;
+
 	instance->unload = 1;
 
 	if (megasas_wait_for_adapter_operational(instance))
-- 
2.9.5

