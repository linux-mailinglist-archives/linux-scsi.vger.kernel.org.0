Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB51D30DF5
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfEaMPm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39037 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so14242179edq.6
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDHrr9f4+vNEjKbQQ3imd0Fn8rlfLg55VRw/UxLow0U=;
        b=QCxsp2Ies7iReLbfDV2P/aHbsXrmYycG2JXtP3IjHJ4L+3Nnzp2XD1wElkW4jgLBb3
         1zjqGe5mTbwpw9sS1h5C47GDPrb9p6HhgpFUUkSJoVlPdyDmIk5WSu5o3Lrzw9+cm3Af
         8lyCHqrlaEgeWQTTGpNIZlV3qyoIYyG2ASbiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MDHrr9f4+vNEjKbQQ3imd0Fn8rlfLg55VRw/UxLow0U=;
        b=X1EDi6Y7emz59NddgDbF7/Ox3aFs6OYv1NvGTAY7j2PrKQMJB+7zKVRFIAXoq5AHYS
         ZUL8np5eI1NhBLPXrgTkmG3M6tU17xxKYQUFuhwkzXY8gLd9EpI3fvyT9vHNMEPBkHBo
         6myAcc7FAXSMd15pGc24S1VZ0F/6RjhA/CwafCGA3GwrxlBJVAzUdIvGyA2lnbKeEo4M
         ALLjX+aLQIC5BUH7/QmKD7+r9IJK6EL2BHnnJKK4oDT6ZG2qTtUpbY7s+SFMdoyo/cMR
         QBCc/vkpc27h6WYlG7NNYrPp8ZevB87MY3r3HuYa71yvKTu8vcqPmQQsfMAmwatLtmu9
         b7jw==
X-Gm-Message-State: APjAAAUX/x8L7MWo9lihtiq1dNSALParptqJOTxHPMrAGpzQu70VYDdu
        uQgmYWc6qfJkCzKIz+3ROtmr7w6G2V6qfVWctzt3POGjZy7/8oZ4rL/waCvP+DWsx1SUTmyLy9H
        BvabpZUJDWZoVc77Ezq+hyA9z3X0k5MoZQ85Heo9phc2UHWQzNWArC/D2D/aGSEG6Z/7j14VTKi
        BxK4HH+Jjv46tAZeBgGg==
X-Google-Smtp-Source: APXvYqw16BvgYUP+10OS2Kj0ua+V0Rfzsw7odVcN77Tl+IsCwFnQAyM5twaopMXXtscbGdf1bvIihA==
X-Received: by 2002:a50:ade3:: with SMTP id b32mr11065159edd.297.1559304939308;
        Fri, 31 May 2019 05:15:39 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:38 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 09/10] mpt3sas: Introduce perf_mode module parameter
Date:   Fri, 31 May 2019 08:14:42 -0400
Message-Id: <20190531121443.30694-10-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

1. Introduce module parameter perf_mode for only Aero/Sea
   generation HBAs.
2. Update IOC page1 fields according to performance mode.

Below are the performance modes that can be
enabled with module parameter perf_mode.

0: Balanced - Few high iops reply queues will be enabled.
   Interrupt coalescing will be enabled only for these high iops
   reply descriptor queues.

1: Iops - Interrupt coalescing will be enabled on all reply queues.
   Coalescing timeout is set to 0x20.This is default value for Aero.

2: Latency - Interrupt coalescing will be enabled on all reply queues.
   Coalescing timeout is set to 0xA.
   This is a legacy behavior similar to Ventura & Invader HBA series.

Default perf mode set by driver is balanced mode if below condition met-
- CPU vendor = Intel
- Aero controller working in 16GT/s pcie speed,
Note - perf mode will be set to latency mode for all other cases.

4k Random Read IO performance numbers on 24 SAS SSD drives for
above three permormance modes.
Below performance data is from Intel Skylake and HGST SS300 (drive model
SDLL1DLR400GCCA1).

IOPs:
 -----------------------------------------------------------------------
  |perf_mode    | qd = 1 | qd = 64 |   note                             |
  |-------------|--------|---------|-------------------------------------
  |balanced     |  259K  |  3061k  | Provides max performance numbers   |
  |             |        |         | both on lower QD workload &        |
  |             |        |         | also on higher QD workload         |
  |-------------|--------|---------|-------------------------------------
  |iops         |  220K  |  3100k  | Provides max performance numbers   |
  |             |        |         | only on higher QD workload.        |
  |-------------|--------|---------|-------------------------------------
  |latency      |  246k  |  2226k  | Provides good performance numbers  |
  |             |        |         | only on lower QD worklaod.         |
  -----------------------------------------------------------------------

Avarage Latency:
  -----------------------------------------------------
  |perf_mode    |  qd = 1      |    qd = 64           |
  |-------------|--------------|----------------------|
  |balanced     |  92.05 usec  |    501.12 usec       |
  |-------------|--------------|----------------------|
  |iops         |  108.40 usec |    498.10 usec       |
  |-------------|--------------|----------------------|
  |latency      |  97.10 usec  |    689.26 usec       |
  -----------------------------------------------------

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 144 ++++++++++++++++++++++++----
 1 file changed, 126 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index c9418d9..e6377ec 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -103,6 +103,27 @@ static int mpt3sas_fwfault_debug;
 MODULE_PARM_DESC(mpt3sas_fwfault_debug,
 	" enable detection of firmware fault and halt firmware - (default=0)");
 
+static int perf_mode = -1;
+module_param(perf_mode, int, 0);
+MODULE_PARM_DESC(perf_mode,
+	"Performance mode (only for Aero/Sea Generation), options:\n\t\t"
+	"0 - balanced: high iops mode is enabled &\n\t\t"
+	"interrupt coalescing is enabled only on high iops queues,\n\t\t"
+	"1 - iops: high iops mode is disabled &\n\t\t"
+	"interrupt coalescing is enabled on all queues,\n\t\t"
+	"2 - latency: high iops mode is disabled &\n\t\t"
+	"interrupt coalescing is enabled on all queues with timeout value 0xA,\n"
+	"\t\tdefault - on Intel architecture, default perf_mode is\n\t\t"
+	" 'balanced' and in others architectures the default mode is 'latency'"
+	);
+
+enum mpt3sas_perf_mode {
+	MPT_PERF_MODE_DEFAULT	= -1,
+	MPT_PERF_MODE_BALANCED	= 0,
+	MPT_PERF_MODE_IOPS	= 1,
+	MPT_PERF_MODE_LATENCY	= 2,
+};
+
 static int
 _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc);
 
@@ -2959,6 +2980,42 @@ static void
 _base_check_and_enable_high_iops_queues(struct MPT3SAS_ADAPTER *ioc,
 		int hba_msix_vector_count)
 {
+	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
+
+	if (perf_mode == MPT_PERF_MODE_IOPS ||
+	    perf_mode == MPT_PERF_MODE_LATENCY) {
+		ioc->high_iops_queues = 0;
+		return;
+	}
+
+	if (perf_mode == MPT_PERF_MODE_DEFAULT) {
+
+#if defined(CONFIG_X86)
+		/*
+		 * Use global variable boot_cpu_data.x86_vendor to
+		 * determine whether the architecture is Intel or not.
+		 */
+		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+			ioc->high_iops_queues = 0;
+			return;
+		}
+#else
+		ioc->high_iops_queues = 0;
+		return;
+#endif
+		speed = pcie_get_speed_cap(ioc->pdev);
+		dev_info(&ioc->pdev->dev, "PCIe device speed is %s\n",
+		     speed == PCIE_SPEED_2_5GT ? "2.5GHz" :
+		     speed == PCIE_SPEED_5_0GT ? "5.0GHz" :
+		     speed == PCIE_SPEED_8_0GT ? "8.0GHz" :
+		     speed == PCIE_SPEED_16_0GT ? "16.0GHz" :
+		     "Unknown");
+
+		if (speed < PCIE_SPEED_16_0GT) {
+			ioc->high_iops_queues = 0;
+			return;
+		}
+	}
 
 	if (!reset_devices && ioc->is_aero_ioc &&
 	    hba_msix_vector_count == MPT3SAS_GEN35_MAX_MSIX_QUEUES &&
@@ -3034,8 +3091,9 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	ioc_info(ioc, "MSI-X vectors supported: %d\n", ioc->msix_vector_count);
 	pr_info("\t no of cores: %d, max_msix_vectors: %d\n",
 		ioc->cpu_count, max_msix_vectors);
-
-	_base_check_and_enable_high_iops_queues(ioc, ioc->msix_vector_count);
+	if (ioc->is_aero_ioc)
+		_base_check_and_enable_high_iops_queues(ioc,
+			ioc->msix_vector_count);
 	ioc->reply_queue_count =
 		min_t(int, ioc->cpu_count + ioc->high_iops_queues,
 		ioc->msix_vector_count);
@@ -4430,6 +4488,70 @@ out:
 	kfree(sas_iounit_pg1);
 }
 
+/**
+ * _base_update_ioc_page1_inlinewith_perf_mode - Update IOC Page1 fields
+ *    according to performance mode.
+ * @ioc : per adapter object
+ *
+ * Return nothing.
+ */
+static void
+_base_update_ioc_page1_inlinewith_perf_mode(struct MPT3SAS_ADAPTER *ioc)
+{
+	Mpi2IOCPage1_t ioc_pg1;
+	Mpi2ConfigReply_t mpi_reply;
+
+	mpt3sas_config_get_ioc_pg1(ioc, &mpi_reply, &ioc->ioc_pg1_copy);
+	memcpy(&ioc_pg1, &ioc->ioc_pg1_copy, sizeof(Mpi2IOCPage1_t));
+
+	switch (perf_mode) {
+	case MPT_PERF_MODE_DEFAULT:
+	case MPT_PERF_MODE_BALANCED:
+		if (ioc->high_iops_queues) {
+			ioc_info(ioc,
+				"Enable interrupt coalescing only for first\t"
+				"%d reply queues\n",
+				MPT3SAS_HIGH_IOPS_REPLY_QUEUES);
+			/*
+			 * If 31st bit is zero then interrupt coalescing is
+			 * enabled for all reply descriptor post queues.
+			 * If 31st bit is set to one then user can
+			 * enable/disable interrupt coalescing on per reply
+			 * descriptor post queue group(8) basis. So to enable
+			 * interrupt coalescing only on first reply descriptor
+			 * post queue group 31st bit and zero th bit is enabled.
+			 */
+			ioc_pg1.ProductSpecific = cpu_to_le32(0x80000000 |
+			    ((1 << MPT3SAS_HIGH_IOPS_REPLY_QUEUES/8) - 1));
+			mpt3sas_config_set_ioc_pg1(ioc, &mpi_reply, &ioc_pg1);
+			ioc_info(ioc, "performance mode: balanced\n");
+			return;
+		}
+	case MPT_PERF_MODE_LATENCY:
+		/*
+		 * Enable interrupt coalescing on all reply queues
+		 * with timeout value 0xA
+		 */
+		ioc_pg1.CoalescingTimeout = cpu_to_le32(0xa);
+		ioc_pg1.Flags |= cpu_to_le32(MPI2_IOCPAGE1_REPLY_COALESCING);
+		ioc_pg1.ProductSpecific = 0;
+		mpt3sas_config_set_ioc_pg1(ioc, &mpi_reply, &ioc_pg1);
+		ioc_info(ioc, "performance mode: latency\n");
+		break;
+	case MPT_PERF_MODE_IOPS:
+		/*
+		 * Enable interrupt coalescing on all reply queues.
+		 */
+		ioc_info(ioc,
+		    "performance mode: iops with coalescing timeout: 0x%x\n",
+		    le32_to_cpu(ioc_pg1.CoalescingTimeout));
+		ioc_pg1.Flags |= cpu_to_le32(MPI2_IOCPAGE1_REPLY_COALESCING);
+		ioc_pg1.ProductSpecific = 0;
+		mpt3sas_config_set_ioc_pg1(ioc, &mpi_reply, &ioc_pg1);
+		break;
+	}
+}
+
 /**
  * _base_static_config_pages - static start of day config pages
  * @ioc: per adapter object
@@ -4439,7 +4561,6 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 {
 	Mpi2ConfigReply_t mpi_reply;
 	u32 iounit_pg1_flags;
-	Mpi2IOCPage1_t ioc_pg1;
 
 	ioc->nvme_abort_timeout = 30;
 	mpt3sas_config_get_manufacturing_pg0(ioc, &mpi_reply, &ioc->manu_pg0);
@@ -4472,21 +4593,6 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 		else
 			ioc->nvme_abort_timeout = ioc->manu_pg11.NVMeAbortTO;
 	}
-	if (ioc->high_iops_queues) {
-		mpt3sas_config_get_ioc_pg1(ioc, &mpi_reply, &ioc_pg1);
-		pr_info(
-		"%s Enable interrupt coalescing only for first reply queue group(8)\n",
-		ioc->name);
-		/* If 31st bit is zero then interrupt coalescing is enabled
-		 * for all reply descriptor post queues. If 31st bit is set
-		 * to one then user can enable/disable interrupt coalescing
-		 * on per reply descriptor post queue group(8) basis. So to
-		 * enable interrupt coalescing only on first reply descriptor
-		 * post queue group 31st bit and zero th bit is enabled.
-		 */
-		ioc_pg1.ProductSpecific = cpu_to_le32(0x80000001);
-		mpt3sas_config_set_ioc_pg1(ioc, &mpi_reply, &ioc_pg1);
-	}
 
 	mpt3sas_config_get_bios_pg2(ioc, &mpi_reply, &ioc->bios_pg2);
 	mpt3sas_config_get_bios_pg3(ioc, &mpi_reply, &ioc->bios_pg3);
@@ -4513,6 +4619,8 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 
 	if (ioc->iounit_pg8.NumSensors)
 		ioc->temp_sensors_count = ioc->iounit_pg8.NumSensors;
+	if (ioc->is_aero_ioc)
+		_base_update_ioc_page1_inlinewith_perf_mode(ioc);
 }
 
 /**
-- 
2.18.1

