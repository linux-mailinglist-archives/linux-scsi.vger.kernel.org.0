Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DC49D54
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfFRJcf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45973 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfFRJce (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so5450350plb.12
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTW9Jfhqa3WzeDUCjzlQ1hjebGSFomDtiNWcykKm+Kw=;
        b=UeRrQ5e6yu8TOFX1JVWe3339CLMzP3+qy5lGKm3lNstWHOe1tdNlMokevkENwU1bHy
         IV4YsbYdN+GhotxH1f5QJ7MvRHhURg9ri9z9o6uYvUgm1OA5k3brHmhDS98kIVkvOn15
         Lgeu2inGUdnB2r4GSEbBG7dTmoNZwe34HH4A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTW9Jfhqa3WzeDUCjzlQ1hjebGSFomDtiNWcykKm+Kw=;
        b=qnLZUL7YwhWe567O5xDn0Hc7z6NNH9CrEghtvhnnK9NnUu4x87gYPtS/FZUZyMJgnC
         feBKUgeLpLhZHCsj/4czSTlTsXIvxUA/hUBwGuFzwhGKmzEes4hFo2jXPUrQNA3oDmbc
         dqzilqxXZZOxHTuoIF3jbEY4jA/UOPw99p8OjuQ2Sg+FKuLRBCrtEm/vAsnbifUIZ9MA
         p44EnbSDX/X1VBeWbwLyq4fEX2Wkp1HRF5IcAkoKDm+D7p+6+y7RuTgzPFOQMlCX5wMX
         EueTuR7bebPrt69V9w10W4icmhQ3M9BpJTNHLyt42ivuzd/ijNjWGqmdak5HnNqjzbks
         xNCQ==
X-Gm-Message-State: APjAAAUXhNNT6iFZYMNBY6ehQRLU5Df2H7O/cjvOzPFMxmRHg0pLCXkr
        mTzt9G7m9rBTqfS7MkA7xxj9YDhmic6ct1HjCd5PAEMClSNIlc9qrLMCkWA6h728zj2LoMJOoRj
        GEbYgYjExxNaHHyPDrcskQlJRxuOtA1SuNr0Eyj1IHP0f4YFZgVZEmFfCQU1GEVCNxDjgHONEg4
        gT+x4dsXvRLg==
X-Google-Smtp-Source: APXvYqyEawnPgkO2TAHNZhSA/iE3dRhW2RbVSMFGssZei6wzdoT25LL/8Te4IGvmA2lhJPaDHopkwg==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr35104400plr.12.1560850354059;
        Tue, 18 Jun 2019 02:32:34 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:33 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 02/18] megaraid_sas: Add support for Non-secure Aero PCI IDs
Date:   Tue, 18 Jun 2019 15:01:51 +0530
Message-Id: <20190618093207.9939-3-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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

