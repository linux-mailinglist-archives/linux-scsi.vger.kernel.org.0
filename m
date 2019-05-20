Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B358823148
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfETK0a (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36165 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETK0a (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so6603269pgb.3
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2lLeIjqov5PWm/VZygr/OA5sTf+qokuZT0kle07ijPk=;
        b=BiXiHe24vwgP7jJCQY+B//RnMQEVaDVh1mb1nY4OpE7VENeZbkbdUaATi1orz7qQ4m
         9SSoDwLBukpHFy6uNF8ixOgZCOQxS17plFzbSCCI0OYKWVSwmV3us4VpjRQWKEWYenPN
         PoFJZE4NVm6gLHLtY8nYt88GjltV3l29/pySM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2lLeIjqov5PWm/VZygr/OA5sTf+qokuZT0kle07ijPk=;
        b=JU0p8YkzbPCF+3SSyMXLxyJnwSqMmT9K+8xHzh9kL0xCc9gHOBe+O1HGDI+KLaBr42
         kywrsrnuvcVWKkAHu8q3vpc4xI7tbd4GCALZbN6mpHMUvSdsoQDDE9WcevPovM0lhkJB
         e/pAV4hvhH8yWQJrjlHezLTfML7RgiRkKBNimIyO8eYjjAjWjJFQNc98D4O4B+QHXMPl
         9lMSuVMwoOPp+J5REdevxv4qaI8INd+1i5v/jpJR+fLFYwcP9eVV+2LIxBBHJTTQ9dpM
         zwKQ4j7XUWGxBd4IW7q2ZJCmA44IV/4+wgJ4AU6lDM+q1uFo2PSzfLQCy9bdblq6ZkqA
         e3bg==
X-Gm-Message-State: APjAAAWmmGGTECqGcRHzXFiV50MQjYU8+fVf5Z+z8JHRjB3L4S7kdZSL
        YgHk4fJVdHv7U1XYyjgJ/JtN27nNYF8YN6GodVVkZLaJoUZ2WqRMj65zzIhI28mARm6FINdrjlJ
        /MDxr94y1tb0ERaToxd/7v/0dxF9G0q0M/bIoy0rOEqzeKueF/fEdaMVZGQ495Xw5ziaXsPJIGV
        B30VmLFLustNOoII3bYw==
X-Google-Smtp-Source: APXvYqxepfhAu2WowTglmn8i0beZwGRsxJMJDm1Ui6tSD0m0rEXjHrnlJJGBwSdRE0vE9AnImn70xQ==
X-Received: by 2002:a63:730f:: with SMTP id o15mr74566155pgc.315.1558347989010;
        Mon, 20 May 2019 03:26:29 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:28 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 03/10] mpt3sas: Add flag high_iops_queues
Date:   Mon, 20 May 2019 06:25:57 -0400
Message-Id: <20190520102604.3466-4-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Aero controllers supports balanced performance mode and driver enables
set of high iops and low latency reply queue only if,

-  HBA is an AERO controller,
-  MSIXs vector supported by the HBA is 128,
-  Total CPU count in the system more than high iops queue count,
-  Loaded driver with default max_msix_vectors module parameter and
-  System booted in non kdump mode.

Reply queues with interrupt coalescing enabled are called "high iops
reply queues" and reply queues with interrupt coalescing disabled are
called "low latency reply queues".

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 45 ++++++++++++++++++++++++++++++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.h |  5 +++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index da475f2..6e7c5e4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2913,6 +2913,34 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 }
 
 /**
+ * _base_check_and_enable_high_iops_queues - enable high iops mode
+ * @ ioc - per adapter object
+ * @ hba_msix_vector_count - msix vectors supported by HBA
+ *
+ * Enable high iops queues only if
+ *  - HBA is a SEA/AERO controller and
+ *  - MSI-Xs vector supported by the HBA is 128 and
+ *  - total CPU count in the system >=16 and
+ *  - loaded driver with default max_msix_vectors module parameter and
+ *  - system booted in non kdump mode
+ *
+ * returns nothing.
+ */
+static void
+_base_check_and_enable_high_iops_queues(struct MPT3SAS_ADAPTER *ioc,
+		int hba_msix_vector_count)
+{
+
+	if (!reset_devices && ioc->is_aero_ioc &&
+	    hba_msix_vector_count == MPT3SAS_GEN35_MAX_MSIX_QUEUES &&
+	    num_online_cpus() >= MPT3SAS_HIGH_IOPS_REPLY_QUEUES &&
+	    max_msix_vectors == -1)
+		ioc->high_iops_queues = MPT3SAS_HIGH_IOPS_REPLY_QUEUES;
+	else
+		ioc->high_iops_queues = 0;
+}
+
+/**
  * _base_disable_msix - disables msix
  * @ioc: per adapter object
  *
@@ -2948,11 +2976,14 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	if (_base_check_enable_msix(ioc) != 0)
 		goto try_ioapic;
 
-	ioc->reply_queue_count = min_t(int, ioc->cpu_count,
-		ioc->msix_vector_count);
+	ioc_info(ioc, "MSI-X vectors supported: %d\n", ioc->msix_vector_count);
+	pr_info("\t no of cores: %d, max_msix_vectors: %d\n",
+		ioc->cpu_count, max_msix_vectors);
 
-	ioc_info(ioc, "MSI-X vectors supported: %d, no of cores: %d, max_msix_vectors: %d\n",
-		 ioc->msix_vector_count, ioc->cpu_count, max_msix_vectors);
+	_base_check_and_enable_high_iops_queues(ioc, ioc->msix_vector_count);
+	ioc->reply_queue_count =
+		min_t(int, ioc->cpu_count + ioc->high_iops_queues,
+		ioc->msix_vector_count);
 
 	if (!ioc->rdpq_array_enable && max_msix_vectors == -1)
 		local_max_msix_vectors = (reset_devices) ? 1 : 8;
@@ -2991,11 +3022,15 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 		}
 	}
 
+	ioc_info(ioc, "High IOPs queues : %s\n",
+			ioc->high_iops_queues ? "enabled" : "disabled");
+
 	return 0;
 
 /* failback to io_apic interrupt routing */
  try_ioapic:
-
+	ioc->high_iops_queues = 0;
+	ioc_info(ioc, "High IOPs queues : disabled\n");
 	ioc->reply_queue_count = 1;
 	r = pci_alloc_irq_vectors(ioc->pdev, 1, 1, PCI_IRQ_LEGACY);
 	if (r < 0) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 3309864..bbbeb88 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -355,6 +355,10 @@ struct mpt3sas_nvme_cmd {
 
 #define VIRTUAL_IO_FAILED_RETRY			(0x32010081)
 
+/* High IOPs definitions */
+#define MPT3SAS_HIGH_IOPS_REPLY_QUEUES		8
+#define MPT3SAS_GEN35_MAX_MSIX_QUEUES		128
+
 /* OEM Specific Flags will come from OEM specific header files */
 struct Mpi2ManufacturingPage10_t {
 	MPI2_CONFIG_PAGE_HEADER	Header;		/* 00h */
@@ -1209,6 +1213,7 @@ struct MPT3SAS_ADAPTER {
 	atomic64_t      total_io_cnt;
 	bool            msix_load_balance;
 	u16		thresh_hold;
+	u8		high_iops_queues;
 
 	/* internal commands, callback index */
 	u8		scsi_io_cb_idx;
-- 
1.8.3.1

