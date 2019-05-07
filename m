Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A358E168BB
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfEGRG2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45397 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRG2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so8603518pgi.12
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xidrd8LC2JRaLE5PKfyFNBrAHwqEptbcNXmQylZbJnY=;
        b=Lp1PzTqL6TDxT0mvI0O0+71C9hEdO5j+CHjT46wHtm9g9RMvwP6+LHIh9SuhT72jBn
         jQABp3ffRLxqxEaCX5MK6bjBBdJSXxdQeNQ3XkI3G0PjstBWYz7J7/iqORMJ/+zN0SvD
         jn9z8O5MumjXrMVulpLl32aYyd4wzVoLpU3Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xidrd8LC2JRaLE5PKfyFNBrAHwqEptbcNXmQylZbJnY=;
        b=qqR7t6xnEpzGmBkReqZIkYavEQK2+/2xa6Dv6OG/t6fRc5EpU3qLobFqTG+QXUrsUW
         zrNDjpiAGd/6LsfzKix1/XVCrcLaJgsdLzNLugxM6yDdzQ7vM2itFuISVEUA4En9CKY2
         e0Xkm+1h+CR6nsL7EVR8KncW777KVxrBC1qcrA/jUdB6nITCwcvkb/sBflD7aHy9KOvl
         Q8nSMYv16elD7zAkDfJAVDJf6FFC1qtheiyL0gzY/MHvyx/ca5OIvYG+fiOuiE3YNUUi
         hN8SLUniLiG51d4lTvZY6OD1x4iFOalTM+wZiGo4N21Z0kBVaon4Sa50eowq2ANgDlmV
         DplQ==
X-Gm-Message-State: APjAAAW8/d6tsgs2DGcvazhsgcZBlwLnDnrjx8m7NfexgEnvMLO7oEy5
        ZkTPEBDtFZ1X73Dj8azYlDIaTZbjSh+KPPLSOKCQIL9GRv6k8gnLGN9XXUTzNL5wzm0phWJvkap
        n+WxYJnPJxrKNSfPyxVkApXNxqgEItDL1y6YZmrzWR+6bRno+LokvdDhC67zhWkGH5UFYKyrycR
        vYsfBKfvV2NOVJsOBS5X6O
X-Google-Smtp-Source: APXvYqzaEVufZ5heq9OOfxa3s87CwNs1JX+M9uZfMzLf3p+K0NF2VDL1qoQDz41GBoVw9C6WxJZD8A==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr41287826pgv.57.1557248786816;
        Tue, 07 May 2019 10:06:26 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:25 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 05/21] megaraid_sas: Block PCI config space access from userspace during OCR
Date:   Tue,  7 May 2019 10:05:34 -0700
Message-Id: <1557248750-4099-6-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

While an online controller reset(OCR) is in progress, there is short
duration where all access to controller's PCI config space from
the host needs to be blocked.
This is due to a hardware limitation of MegaRAID controllers.

With this patch, driver will block all access to controller's config
space from userland applications by calling pci_cfg_access_lock()
while OCR is in progress and unlocking after controller comes back to
ready state.

Added helper function which locks the config space before initiating OCR
and wait for controller to become READY.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  3 ++
 drivers/scsi/megaraid/megaraid_sas_base.c   | 15 ++++---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 66 +++++++++++++++++++++++++++--
 3 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 902b11b97999..990ee23d7bc2 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2636,4 +2636,7 @@ void megasas_fusion_stop_watchdog(struct megasas_instance *instance);
 void megasas_set_dma_settings(struct megasas_instance *instance,
 			      struct megasas_dcmd_frame *dcmd,
 			      dma_addr_t dma_addr, u32 dma_len);
+int megasas_adp_reset_wait_for_ready(struct megasas_instance *instance,
+				     bool do_adp_reset,
+				     int ocr_context);
 #endif				/*LSI_MEGARAID_SAS_H */
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 77db6e773a01..5e5170b40f6f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5535,13 +5535,15 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	}
 
 	if (megasas_transition_to_ready(instance, 0)) {
+		dev_info(&instance->pdev->dev,
+			 "Failed to transition controller to ready from %s!\n",
+			 __func__);
 		if (instance->adapter_type != MFI_SERIES) {
 			status_reg = instance->instancet->read_fw_status_reg(
 					instance);
 			if (status_reg & MFI_RESET_ADAPTER) {
-				instance->instancet->adp_reset
-					(instance, instance->reg_set);
-				if (megasas_transition_to_ready(instance, 0))
+				if (megasas_adp_reset_wait_for_ready
+					(instance, true, 0) == FAILED)
 					goto fail_ready_state;
 			} else {
 				goto fail_ready_state;
@@ -5551,9 +5553,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			instance->instancet->adp_reset
 				(instance, instance->reg_set);
 			atomic_set(&instance->fw_reset_no_pci_access, 0);
-			dev_info(&instance->pdev->dev,
-				 "FW restarted successfully from %s!\n",
-				 __func__);
 
 			/*waiting for about 30 second before retry*/
 			ssleep(30);
@@ -5561,6 +5560,10 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			if (megasas_transition_to_ready(instance, 0))
 				goto fail_ready_state;
 		}
+
+		dev_info(&instance->pdev->dev,
+			 "FW restarted successfully from %s!\n",
+			 __func__);
 	}
 
 	megasas_init_ctrl_params(instance);
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 76bd29c92752..59bab98274f6 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -98,6 +98,62 @@ static void megasas_fusion_crash_dump(struct megasas_instance *instance);
 extern u32 megasas_readl(struct megasas_instance *instance,
 			 const volatile void __iomem *addr);
 
+/**
+ * megasas_adp_reset_wait_for_ready -	initiate chip reset and wait for
+ *					controller to come to ready state
+ * @instance -				adapter's soft state
+ * @do_adp_reset -			If true, do a chip reset
+ * @ocr_context -			If called from OCR context this will
+ *					be set to 1, else 0
+ *
+ * This functon initates a chip reset followed by a wait for controller to
+ * transition to ready state.
+ * During this, driver will block all access to PCI config space from userspace
+ */
+int
+megasas_adp_reset_wait_for_ready(struct megasas_instance *instance,
+				 bool do_adp_reset,
+				 int ocr_context)
+{
+	int ret = FAILED;
+
+	/*
+	 * Block access to PCI config space from userspace
+	 * when diag reset is initiated from driver
+	 */
+	if (megasas_dbg_lvl & OCR_LOGS)
+		dev_info(&instance->pdev->dev,
+			 "Block access to PCI config space %s %d\n",
+			 __func__, __LINE__);
+
+	pci_cfg_access_lock(instance->pdev);
+
+	if (do_adp_reset) {
+		if (instance->instancet->adp_reset
+			(instance, instance->reg_set))
+			goto out;
+	}
+
+	/* Wait for FW to become ready */
+	if (megasas_transition_to_ready(instance, ocr_context)) {
+		dev_warn(&instance->pdev->dev,
+			 "Failed to transition controller to ready for scsi%d.\n",
+			 instance->host->host_no);
+		goto out;
+	}
+
+	ret = SUCCESS;
+out:
+	if (megasas_dbg_lvl & OCR_LOGS)
+		dev_info(&instance->pdev->dev,
+			 "Unlock access to PCI config space %s %d\n",
+			 __func__, __LINE__);
+
+	pci_cfg_access_unlock(instance->pdev);
+
+	return ret;
+}
+
 /**
  * megasas_check_same_4gb_region -	check if allocation
  *					crosses same 4GB boundary or not
@@ -4694,10 +4750,12 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 
 		/* Now try to reset the chip */
 		for (i = 0; i < max_reset_tries; i++) {
-
-			if (do_adp_reset &&
-			    instance->instancet->adp_reset
-				(instance, instance->reg_set))
+			/*
+			 * Do adp reset and wait for
+			 * controller to transition to ready
+			 */
+			if (megasas_adp_reset_wait_for_ready(instance,
+				do_adp_reset, 1) == FAILED)
 				continue;
 
 			/* Wait for FW to become ready */
-- 
2.16.1

