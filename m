Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D214CC4F
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfFTKwn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:52:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42956 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKwn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:52:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so1445774pff.9
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TgCgky6YIODK9Qkx2FukavRnGMLU1Hv4ZF/hfiUliTU=;
        b=JXM2NGrDmYl+yadi0p7R3ziMAAFRIPbLQ/j+eiHRvY46UAFbXzKzoqEYFg89TlYtNk
         0QhGtGlpC8wTnQ7xKh/qjaek6RFWtXKRKJ1yYq1jdZwd4ANwyJtnGxjPYQ1NMGbZ+4OM
         Pv8SyzELuaCBJg4/SQvCJ3VgXRdPVka5XUtws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TgCgky6YIODK9Qkx2FukavRnGMLU1Hv4ZF/hfiUliTU=;
        b=KJHxtwyVQ0s6k391ErBuuoCGugu9f/OoBVkQY5aWkbXd+EDJ4YaQ+CWO4QoWCFSpj8
         Sta18Zm5uYHF0deHQ8us6V0TFZ0fPxttPHh/xzecmtgTxmVF9S0EhrgLHAPRQHie3pwa
         Ero/yNVlu1NKAhMal5viR3q9JMDGyZjStJoR1c8mZJ7wqJhyB3bWPsgAW41ziyoxek9p
         JAqNFKOa4dZbxif4lXAr8T6stBnncO/p/KPlNMqUsAvIeDRqaoNtp+6HLAzguTgbDGS7
         hapylq/rBSvGICiC0ldHdbKcbXsaKa4I4Z9nsaeLsguwXDdeM8TgVtVZW7f0thcrTbiM
         QmBQ==
X-Gm-Message-State: APjAAAWjyCsEZP5ZPDJVFd89q7ZAMHTJQsr8O94F4HVnqzYT9MBOd4VI
        9tAQVqqEKNtDfPleor4aRbhSVOZSjY3fL9Vi036hplZhXnu5pK1tC9iV7zQEjTuZyRlP9E4DJeQ
        U7WKhakBwT51entaiOXEhpMmNBumTzROIblead9C3W2xuX9ctdacH5QJNXtnLbuXm1QmWCK+Z7P
        4DnxHrwyrz3fJaPEY=
X-Google-Smtp-Source: APXvYqwMQfVyfwH1lI372Q3gotx1MIL1CTTWXOjsWzgEo2uedYRuLIBdSH5Rgd/bbXPC6BZ4yCffCw==
X-Received: by 2002:a17:90a:db44:: with SMTP id u4mr2465934pjx.52.1561027961871;
        Thu, 20 Jun 2019 03:52:41 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:52:41 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 01/18] megaraid_sas: Add 32 bit atomic descriptor support to AERO adapters
Date:   Thu, 20 Jun 2019 16:21:51 +0530
Message-Id: <20190620105208.15011-2-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

