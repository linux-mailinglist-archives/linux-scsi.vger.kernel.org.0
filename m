Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02C4CC50
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFTKwq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:52:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36781 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKwq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:52:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so1397457pgi.3
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTW9Jfhqa3WzeDUCjzlQ1hjebGSFomDtiNWcykKm+Kw=;
        b=OF1v33r/oR60J8/RY+KxyA/ZYBtD/z27LfWTK5fol50u0a3upPCD9t1m34vvub1i9j
         jOOYN451QfDKowZJ+eRdpEzh+74gTTWrXcEUfvcJpybm+qzvFjnFZJosTZNZVIGIeT/g
         owlpkBfVYhu48uynnIn14sON8YwKYtBQqN5XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTW9Jfhqa3WzeDUCjzlQ1hjebGSFomDtiNWcykKm+Kw=;
        b=lazzQ4Dka0wj1y7GUWLG3oFw5TO+JG79kQpwM0/rrjf2gMuNYH5RTiSF7SjnSJq16f
         y1OmNKndI/jwCzCwgdcyz7mH7IiwdoGcUHjvT1EbufuwR8C2TlwY9nbUxoLlBkZdhjjN
         lgF1pDypk1oOoTDIijb5uoI/UPTaDSCxHdgRsEePbmqV4K5IKzAWXedoAZK+ETOiSqAr
         cHVGxjCK3Xu+8vktPN3vikx0ziibKmVKoYsRxy16NeYHeDlzrobeXN0i4cKIUrTiV+CI
         +i1gP7FHj7oKx/4XBzvkXmJPLYjnc+lYggpJRHGqIwpYi41wsxW5H0bjYRQSvtMdKnPE
         fYDQ==
X-Gm-Message-State: APjAAAWk2XqdB5cAPwWDto5i4QTgeTp5byupgJVF4AN7no94hgPwyFQR
        H8zhLj4xLH2uTZuT29hZR2jbRlLk4Qd3EjT+RGjk466656lOieeq2tSJtR7P/QGW4hy2gGck5F0
        ilJb9Zgo9gT/BoKTmCgWrmMfdbk4wV8g/DwefWfHQgGBbOShGz7XfvTnMY2fkGK9Ooy8Zqp1yjW
        8YxQHHNh44eb3oaHI=
X-Google-Smtp-Source: APXvYqw6lAhR5qFNqgX+VjO9s9XKsrJGKw8JnQXR4e7hiNgCKqKbMWkD6yFH54oTi74PARplvSLokQ==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr71409152pfc.62.1561027965008;
        Thu, 20 Jun 2019 03:52:45 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:52:44 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 02/18] megaraid_sas: Add support for Non-secure Aero PCI IDs
Date:   Thu, 20 Jun 2019 16:21:52 +0530
Message-Id: <20190620105208.15011-3-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

