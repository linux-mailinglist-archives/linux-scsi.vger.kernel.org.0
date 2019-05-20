Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0470A23147
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbfETK02 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33393 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETK02 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so7032302pfk.0
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8uYJmGAlhDt5KIwCxpJdkxu0YXu6rIOqWDiQJ0nzqW0=;
        b=GITd2/+2MRstTX5T+l5OWAb4A3BaRQA9C4WSFsJEb6+Sqj2L0t0aeFFxOE3qcjr7+y
         +UfvR0Hu3A2BROnTISkFFQhLxVXewkUZEuwXLsiIoY0sic9FNGdaiovbPv0lJ1KFxWpu
         KhWDWeScU7jWQEGy3C9FnMNq0gzDNrfvE9WWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8uYJmGAlhDt5KIwCxpJdkxu0YXu6rIOqWDiQJ0nzqW0=;
        b=fwk37nny9zejpm5URJqA+SgWkF5E/8ss1C1m7XueJ5DoXmRkQ5WRlhPpMMF3UZsZPa
         H+kcWcf0TpTX0lJyNTSaKnaI4FHv+Vtj0s16xBW26IHWrimvEOTQa1Gr0sMKyUEQBwe6
         T8sKttE1Uo6Dh48X9Xur+2knMSIFfLGAJTCpEXaPXjIp2Bw3KsBGzx6FvMdZioMDUqRT
         IqLu2ekO77rb5l0TP4qkHoeR4sdiMiCThjn7WnOxMHxh8neTqvl/bA7VoFONQKtJHfIr
         BRGJFuF/yqip0YDZdMPgp0xIb4qiMBih7OM+FFZVt2HqjJXQOHlGnGoQn4Zg3X7rUeWK
         zb1A==
X-Gm-Message-State: APjAAAVcNITfnxjT0z5EoLSiA+6iNU6n6li+FCljNGnI28rURyKblIGg
        xvi3vOVlDH5RWqoC5I/Gz8pn5c4YYa7rNqgbCnbRim5JoDh0aP+JVHoSqjRZdcR5HvYdvevAM8V
        BGC/ffv2D9VnR1HtwVRPZUq4xPt9oSITfl9Ppd9eB5X09h20QIZ6P27S7MTQ2fxaFfJeKLCp3mj
        EmQ31RCBCzZGz8qe70jA==
X-Google-Smtp-Source: APXvYqxPGZ1dzIPA531FpcOM97UkMiIECXbuXXtqfJmP9jKBwKH5LASOFKvDbRRX9tNZv0CVCYx36g==
X-Received: by 2002:a63:9214:: with SMTP id o20mr75102320pgd.203.1558347986976;
        Mon, 20 May 2019 03:26:26 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:26 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 02/10] mpt3sas: Add Atomic RequestDescriptor support on Aero
Date:   Mon, 20 May 2019 06:25:56 -0400
Message-Id: <20190520102604.3466-3-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

If the Aero HBA supports Atomic Request Descriptors, it sets the Atomic
Request Descriptor Capable bit in the IOCCapabilities field of the
IOCFacts Reply message. Driver uses an Atomic Request Descriptor
as an alternative method for posting an entry onto a request queue.
The posting of an Atomic Request Descriptor is an atomic operation,
providing a safe mechanism for multiple processors on the host to
post requests without synchronization. This Atomic Request Descriptor
format is identical to first 32 bits of Default Request Descriptor
and uses only 32 bits

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 118 +++++++++++++++++++++++++++++++++---
 drivers/scsi/mpt3sas/mpt3sas_base.h |   2 +
 2 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 95f831e..da475f2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3655,6 +3655,95 @@ _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 }
 
 /**
+* _base_put_smid_scsi_io_atomic - send SCSI_IO request to firmware using
+*   Atomic Request Descriptor
+* @ioc: per adapter object
+* @smid: system request message index
+* @handle: device handle, unused in this function, for function type match
+*
+* Return nothing.
+*/
+static void
+_base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+	u16 handle)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
+	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
+ * _base_put_smid_fast_path_atomic - send fast path request to firmware
+ * using Atomic Request Descriptor
+ * @ioc: per adapter object
+ * @smid: system request message index
+ * @handle: device handle, unused in this function, for function type match
+ * Return nothing
+ */
+static void
+_base_put_smid_fast_path_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+	u16 handle)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
+	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
+ * _base_put_smid_hi_priority_atomic - send Task Management request to
+ * firmware using Atomic Request Descriptor
+ * @ioc: per adapter object
+ * @smid: system request message index
+ * @msix_task: msix_task will be same as msix of IO incase of task abort else 0
+ *
+ * Return nothing.
+ */
+static void
+_base_put_smid_hi_priority_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+	u16 msix_task)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_HIGH_PRIORITY;
+	descriptor.MSIxIndex = msix_task;
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
+ * _base_put_smid_default - Default, primarily used for config pages
+ * use Atomic Request Descriptor
+ * @ioc: per adapter object
+ * @smid: system request message index
+ *
+ * Return nothing.
+ */
+static void
+_base_put_smid_default_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
+	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
  * _base_display_OEMs_branding - Display branding string
  * @ioc: per adapter object
  */
@@ -5695,6 +5784,9 @@ _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc)
 	if ((facts->IOCCapabilities &
 	      MPI2_IOCFACTS_CAPABILITY_RDPQ_ARRAY_CAPABLE) && (!reset_devices))
 		ioc->rdpq_array_capable = 1;
+	if ((facts->IOCCapabilities & MPI26_IOCFACTS_CAPABILITY_ATOMIC_REQ)
+	    && ioc->is_aero_ioc)
+		ioc->atomic_desc_capable = 1;
 	facts->FWVersion.Word = le32_to_cpu(mpi_reply.FWVersion.Word);
 	facts->IOCRequestFrameSize =
 	    le16_to_cpu(mpi_reply.IOCRequestFrameSize);
@@ -6588,15 +6680,23 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 
 		break;
 	}
-
-	ioc->put_smid_default = &_base_put_smid_default;
-	ioc->put_smid_fast_path = &_base_put_smid_fast_path;
-	ioc->put_smid_hi_priority = &_base_put_smid_hi_priority;
-	if (ioc->is_mcpu_endpoint)
-		ioc->put_smid_scsi_io = &_base_put_smid_mpi_ep_scsi_io;
-	else
-		ioc->put_smid_scsi_io = &_base_put_smid_scsi_io;
-
+	if (ioc->atomic_desc_capable) {
+		ioc->put_smid_default = &_base_put_smid_default_atomic;
+		ioc->put_smid_scsi_io = &_base_put_smid_scsi_io_atomic;
+		ioc->put_smid_fast_path =
+				&_base_put_smid_fast_path_atomic;
+		ioc->put_smid_hi_priority =
+				&_base_put_smid_hi_priority_atomic;
+	} else {
+		ioc->put_smid_default = &_base_put_smid_default;
+		ioc->put_smid_fast_path = &_base_put_smid_fast_path;
+		ioc->put_smid_hi_priority = &_base_put_smid_hi_priority;
+		if (ioc->is_mcpu_endpoint)
+			ioc->put_smid_scsi_io =
+				&_base_put_smid_mpi_ep_scsi_io;
+		else
+			ioc->put_smid_scsi_io = &_base_put_smid_scsi_io;
+	}
 	/*
 	 * These function pointers for other requests that don't
 	 * the require IEEE scatter gather elements.
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index d3f3c37..3309864 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1147,6 +1147,7 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  *	path functions resulting in Null pointer reference followed by kernel
  *	crash. To avoid the above race condition we use mutex syncrhonization
  *	which ensures the syncrhonization between cli/sysfs_show path.
+ * @atomic_desc_capable: Atomic Request Descriptor support.
  */
 struct MPT3SAS_ADAPTER {
 	struct list_head list;
@@ -1412,6 +1413,7 @@ struct MPT3SAS_ADAPTER {
 	u8		hide_drives;
 	spinlock_t	diag_trigger_lock;
 	u8		diag_trigger_active;
+	u8		atomic_desc_capable;
 	BASE_READ_REG	base_readl;
 	struct SL_WH_MASTER_TRIGGER_T diag_trigger_master;
 	struct SL_WH_EVENT_TRIGGERS_T diag_trigger_event;
-- 
1.8.3.1

