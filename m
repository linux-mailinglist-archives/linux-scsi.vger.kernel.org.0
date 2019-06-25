Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730BA54D21
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfFYLE5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:04:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42021 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLE5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:04:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id k13so2620462pgq.9
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TgCgky6YIODK9Qkx2FukavRnGMLU1Hv4ZF/hfiUliTU=;
        b=LL6ct4K8F57DIeoySOPDbPGSPUIxRuAw5aaw+UQ6owDHsZ0fxcLnLnSsStYRuIbyXN
         xcZAcinrt8xCkv/MiQ7+CS9rgBT4BdlXAgvZKN2HSLo/4y+w96T9wnA0YtMkflP+ZiIn
         pngXbJpDEu14LyywlKkteZqAk6+D/hSs4LZig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TgCgky6YIODK9Qkx2FukavRnGMLU1Hv4ZF/hfiUliTU=;
        b=Xf9vN9iiN7nOy27E0+lWV8kweXg+sXY/bdLC9bndu8aJZrhY15OG2Sxl30ja3EfY9H
         d30DaAS00FxOMAtz7K50+GWCKUE965WX0YshsKOhIhq1u8Z16jkdykay+CUGWDTP6BwB
         C5YETGEikmlql9sTyGjnPnvcU894TXKJiGQrwF55SR0AbVrY0qO5h5cxOoJJZBJEmMlE
         6Lk9P6juTe/M5kExBNODElusCrsaCXW+3HtEeTsJKSFNoHW9t7qCuDhhIVVjSc8pwjqZ
         6m2/RRgU23cXtsXPXGRGQSTQi/Gn1vKGCpiE5v1rLAuLMx76HUYlLg4eBnFdbYUTiwQ0
         eIaQ==
X-Gm-Message-State: APjAAAWLoR1zP0rpZQykfkpc1niGh3E4udWQNmUUSfOzdGstTuteqW0u
        pYkyu02Uc28t4Y3tXoym6LJQRsKmSBVKEo7KG+h2A/5hHrYN6ie5n8MxxVZFDRfqLhUrwX8mOOw
        T4WDDIYwwHSzhGrKJUHUhEVJmVw7homZ6viBmKM+cP3KZuGb9xC5aiWYK1JPG1uthCC7TbUkfWU
        OE/h5WQ199fv4j
X-Google-Smtp-Source: APXvYqyRjbqdgAwqOc0Bfz+UBC/23sSRcw8B3lHs1+BKDA5oiT5oKQIZUrPsP4C1QNhghIjm9214BA==
X-Received: by 2002:a65:448a:: with SMTP id l10mr37968483pgq.53.1561460695464;
        Tue, 25 Jun 2019 04:04:55 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.04.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:04:54 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 01/18] megaraid_sas: Add 32 bit atomic descriptor support to AERO adapters
Date:   Tue, 25 Jun 2019 16:34:19 +0530
Message-Id: <20190625110436.4703-2-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Aero adapters provides Atomic Request Descriptor as an alternative
method for posting an entry onto a request queue. The posting of an
Atomic Request Descriptor is an atomic operation, providing a safe
mechanism for multiple processors on the host to post requests without
synchronization. This Atomic Request Descriptor format is identical to
first 32 bits of Default Request Descriptor and uses only 32 bits.

If Aero adapters support Atomic descriptor, driver should use it for
posting IOs and DCMDs to firmware.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  3 ++
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 45 +++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index e138d14..a08dd9c 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -1600,6 +1600,8 @@ enum FW_BOOT_CONTEXT {
 
 #define MR_CAN_HANDLE_SYNC_CACHE_OFFSET		0X01000000
 
+#define MR_ATOMIC_DESCRIPTOR_SUPPORT_OFFSET	(1 << 24)
+
 #define MR_CAN_HANDLE_64_BIT_DMA_OFFSET		(1 << 25)
 
 #define MEGASAS_WATCHDOG_THREAD_INTERVAL	1000
@@ -2395,6 +2397,7 @@ struct megasas_instance {
 	struct dentry *raidmap_dump;
 #endif
 	u8 enable_fw_dev_list;
+	bool atomic_desc_support;
 };
 struct MR_LD_VF_MAP {
 	u32 size;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 8a7ac5c..4411408 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -277,21 +277,17 @@ inline void megasas_return_cmd_fusion(struct megasas_instance *instance,
 }
 
 /**
- * megasas_fire_cmd_fusion -	Sends command to the FW
- * @instance:			Adapter soft state
- * @req_desc:			64bit Request descriptor
- *
- * Perform PCI Write.
+ * megasas_write_64bit_req_desc -	PCI writes 64bit request descriptor
+ * @instance:				Adapter soft state
+ * @req_desc:				64bit Request descriptor
  */
-
 static void
-megasas_fire_cmd_fusion(struct megasas_instance *instance,
+megasas_write_64bit_req_desc(struct megasas_instance *instance,
 		union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc)
 {
 #if defined(writeq) && defined(CONFIG_64BIT)
 	u64 req_data = (((u64)le32_to_cpu(req_desc->u.high) << 32) |
 		le32_to_cpu(req_desc->u.low));
-
 	writeq(req_data, &instance->reg_set->inbound_low_queue_port);
 #else
 	unsigned long flags;
@@ -305,6 +301,25 @@ megasas_fire_cmd_fusion(struct megasas_instance *instance,
 }
 
 /**
+ * megasas_fire_cmd_fusion -	Sends command to the FW
+ * @instance:			Adapter soft state
+ * @req_desc:			32bit or 64bit Request descriptor
+ *
+ * Perform PCI Write. AERO SERIES supports 32 bit Descriptor.
+ * Prior to AERO_SERIES support 64 bit Descriptor.
+ */
+static void
+megasas_fire_cmd_fusion(struct megasas_instance *instance,
+		union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc)
+{
+	if (instance->atomic_desc_support)
+		writel(le32_to_cpu(req_desc->u.low),
+			&instance->reg_set->inbound_single_queue_port);
+	else
+		megasas_write_64bit_req_desc(instance, req_desc);
+}
+
+/**
  * megasas_fusion_update_can_queue -	Do all Adapter Queue depth related calculations here
  * @instance:							Adapter soft state
  * fw_boot_context:						Whether this function called during probe or after OCR
@@ -1171,7 +1186,8 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 			break;
 	}
 
-	megasas_fire_cmd_fusion(instance, &req_desc);
+	/* For AERO also, IOC_INIT requires 64 bit descriptor write */
+	megasas_write_64bit_req_desc(instance, &req_desc);
 
 	wait_and_poll(instance, cmd, MFI_IO_TIMEOUT_SECS);
 
@@ -1181,6 +1197,17 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 		goto fail_fw_init;
 	}
 
+	if (instance->adapter_type >= AERO_SERIES) {
+		scratch_pad_1 = megasas_readl
+			(instance, &instance->reg_set->outbound_scratch_pad_1);
+
+		instance->atomic_desc_support =
+			(scratch_pad_1 & MR_ATOMIC_DESCRIPTOR_SUPPORT_OFFSET) ? 1 : 0;
+
+		dev_info(&instance->pdev->dev, "FW supports atomic descriptor\t: %s\n",
+			instance->atomic_desc_support ? "Yes" : "No");
+	}
+
 	return 0;
 
 fail_fw_init:
-- 
2.9.5

