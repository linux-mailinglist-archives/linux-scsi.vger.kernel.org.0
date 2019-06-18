Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1902349D53
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfFRJcc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44424 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfFRJcc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so7355534pgp.11
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uxd6SqY+GvbMMeonQN53Ug1mAP924ESetdmikHsQgdY=;
        b=VkF0OLdJb7chwYTh+ss6Dvl5pr+BnyzuJvGzviWQU7TqSoOvMksDF6Z8mWQnq7vcxL
         UisM3Qg6RpAKl+39dwh6K64iQpYiL2Q9N2e91GuytLYV6QGm/1eyw4voXsVWx4srMN7A
         Fug1g+OSvWN8WE1V4rOEqfPczQKSKXgvXUjCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uxd6SqY+GvbMMeonQN53Ug1mAP924ESetdmikHsQgdY=;
        b=pENJg8qfBjb6Qk/qoO9L/Pc99/55YFhL8Nph0S606AymyKqKIpLH3/UkAIBsc3FD5W
         h57GEMn+QnhGdk2VpGFaQj78EK5yrfpybxGWD7HBaWLbfHgoSyCWx/wUtFhxNdEJ2F4F
         ia2brGtbVY0G6KylYGyWszxpxTZSe4uhOuZvwuXX7rbrJpLjYL2YN8SRgixMh6qxoAZP
         5Inbo0NKLXWN8eoOc5URb3zi1PXhgmeJc49KtaOclWMlvIfaeaxnTxx1w14Kx2KqF7Ij
         wiSy39fRUkBZEClKpXgoZrOBA2reD5IhjnZArIrE9DCgnPmtpmubTFEhl86FdOH6fgsN
         9H8w==
X-Gm-Message-State: APjAAAU4Y8cCIYME1z2wfhsaTX4452J/EW6nkmVjpmOqi2QhxeQ4dHx1
        +KxY6sYDYIxdIy6sXZAmaWx3457a1eE9CvHygtX83DNmjik2oiyLPXwatMmi5Shv/dHIpD//ieB
        coFsu8zMHHCEzY9XG9YbzlEeiGcrSnYpSaiRrw4QWq3fXRhieXndLK5Y7qrOIOGzN/ABuLhD8jx
        WyVQzeH/0VaQ==
X-Google-Smtp-Source: APXvYqxonxkMlsR69n6TsxWbz6BlNqiFfWeutzxWlhsyoZVukSRTgzUv8TNXEeVzrlXVS45ss3FfWQ==
X-Received: by 2002:a62:1883:: with SMTP id 125mr13893275pfy.178.1560850351089;
        Tue, 18 Jun 2019 02:32:31 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:30 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 01/18] megaraid_sas: Add 32 bit atomic descriptor support to AERO adapters
Date:   Tue, 18 Jun 2019 15:01:50 +0530
Message-Id: <20190618093207.9939-2-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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
index 2edb082..d4c1ee57 100644
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

