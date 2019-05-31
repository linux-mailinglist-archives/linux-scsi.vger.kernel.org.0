Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A230DEF
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaMPR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43250 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so14209815edb.10
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3h8HRACqB399gnigC3yw2AtFQ2c1v8qDHXguU0KTi5E=;
        b=WTD27fdWZ8NIjZHlzdLVIpqxvcg/YIisYnKgfM6OPlXxfqW25nh0zLjeA2FNml35pI
         rdjNCpjPmBib+LugcsUuucH/PbnJ5zTsYxF+JZqCjlZwMVCPTA0cFOAGvbBrho/IGkln
         2UCo5Fbz48FDqGxH02mG8v/IzMOJC497qRFQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3h8HRACqB399gnigC3yw2AtFQ2c1v8qDHXguU0KTi5E=;
        b=RE5S+TQ9VPW5zk3eP/gn3j4nwnMhDWf9k2CuT/BA7TM4mfjDubxIiBL5MRtA/SVYPX
         ctbQZqjgu2sJYHFav25Usl5foNzzUH/EtClsM9iudE9Rzw8UeCsQ5y2b817hBtPmsCen
         vTSre2JUNNvicffSPPG37N5tVf+anfgRAQnxc/DMFLGENRJrTLnEzsRLt4LWsatwiI0j
         lJL3RRKXgLJPOahy9JVDEWn+9vyBQ064pP5Rgwwt5Y4HTScOj2cwHT6sIzu3Os0CTUZH
         ODKOPWnux8k+lfJoBY/IvcjjOJGbqS/r0FFwVES49SIuQa/8eDSGsoIDkujn9grx7/pO
         quKA==
X-Gm-Message-State: APjAAAUd/KI6CUSE8Smq/k0fOCuM0ANN/AyGR9SE9/wOFVgnN2X1A9bq
        7QWU+U9gjfqNZSUqeyFltjnM8mjjILgl49ZAYp84ZJK5Dt0bSC8vcdkqENmAG4IKhcGM5GDBYMI
        bqhO4KDHqZIKsCbMjtzX8M6gz7RF/sahAXToYQf9mXZdrGJmysFiJfXrXuTLsJJofXZN14A4Tk/
        EQgkTmxPM+m3YfIay/kA==
X-Google-Smtp-Source: APXvYqypqFHYzSqzVPsSgXSEF3Wv6V7ew5tuz2mI0g2aSsCLB114GKkXLUnU5CawR/UE1H0R9fRv8Q==
X-Received: by 2002:a17:906:610:: with SMTP id s16mr8828755ejb.108.1559304914650;
        Fri, 31 May 2019 05:15:14 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:14 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 03/10] mpt3sas: Add flag high_iops_queues
Date:   Fri, 31 May 2019 08:14:36 -0400
Message-Id: <20190531121443.30694-4-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

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

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 45 +++++++++++++++++++++++++----
 drivers/scsi/mpt3sas/mpt3sas_base.h |  5 ++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 9cdbd61..6d1a648 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2912,6 +2912,34 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 	}
 }
 
+/**
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
 /**
  * _base_disable_msix - disables msix
  * @ioc: per adapter object
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
2.18.1

