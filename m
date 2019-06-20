Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6425F4CC5E
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfFTKxV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41996 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTKxU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so1446768pff.9
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sEFNuVq5acDFnuFNK80WEE4N3ubRxRDH6lU83qeQjQo=;
        b=JI+HIjBzHnBOeXxvp4NA4UMB/QYmeYkzqGOBA7CW3MZeXoueYK54I52wcGMRnU+hft
         eAUGgNK8RduzUlm0Op8LmSKNi4tIl3RpSfPv82/Vcg8lrX7FR8CmHMVidxDkORuGlKr8
         oBDg3svnaKkpv8sp3UQ2PquKVunGaKr8a/Sj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sEFNuVq5acDFnuFNK80WEE4N3ubRxRDH6lU83qeQjQo=;
        b=s0qTqjJFiG8NL/YOYan6sw1I1ay1sv7vAjMyE+h7b0q3dIpU+CgTFI39raQOMIXt4y
         zgoaENF7kMyJlhHsb+2IkGZ8YU6t6ntrwz9BWo2RciqcBiPMT3x4P69Fobwcek05SVlt
         dUe/wBaRxzsYLNgOB/I4Qx2PbTrRwBN264CoMbI0/4fpkK8ROlihQzeeoiNMmYRfOeYw
         /vriaFhlfuZrXy2cv5uGObIMYDKu3yfGAHteifHHrbwtRIaErg9vLd/cgqGLlvCIU1Ib
         CmPEo41q3yIvjvcA0JhVj+apgEAfve6JdGfXpsjdn8/5ptdwfwg2mSrB12NwD5CKIZBU
         hBew==
X-Gm-Message-State: APjAAAXYKq/ukywoTcYqw0kFJsBJWb8nguc7YO7beA4SO+OoBzfp019m
        2qjnHuP17U6Pd2Ff6p+UQO6iLIdyfdKMJV3HX+H2fxDPYud5fFkz9tCw9epnGneci+eFFz1nocY
        GtcydOPk/sPF3rNaxtmGWgjvM13+H0GrqWnAbvcBG0qF5qy3LuJ9k/cdjbSl5Vf2PyUezedufgH
        O5o3dzB/G+hFZt
X-Google-Smtp-Source: APXvYqwO0t/x1iHMAOdnKkuRWF0WbHB+jjlfXdmv3Bdk6gWv18thXuI3L5f0wTCJ9FPUbQ+GDB3gZQ==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr131911742pfc.189.1561027999740;
        Thu, 20 Jun 2019 03:53:19 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:19 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 13/18] megaraid_sas: Add support for High IOPs queues
Date:   Thu, 20 Jun 2019 16:22:03 +0530
Message-Id: <20190620105208.15011-14-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Aero controllers support balanced performance mode through the ability to
configure queues with different properties.

Reply queues with interrupt coalescing enabled are called "high iops reply
queues" and reply queues with interrupt coalescing disabled are called "low
latency reply queues".

The driver configures a combination of high iops and low latency reply
queues if:

 - HBA is an AERO controller;

 - MSI-X vectors supported by the HBA is 128;

 - Total CPU count in the system more than high iops queue count;

 - Driver is loaded with default max_msix_vectors module parameter; and

 - System booted in non-kdump mode.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |   6 ++
 drivers/scsi/megaraid/megaraid_sas_base.c   | 135 ++++++++++++++++++++++++----
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  11 +++
 3 files changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 83baac3..5b17d0f 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -1640,6 +1640,7 @@ enum FW_BOOT_CONTEXT {
 #define MR_ATOMIC_DESCRIPTOR_SUPPORT_OFFSET	(1 << 24)
 
 #define MR_CAN_HANDLE_64_BIT_DMA_OFFSET		(1 << 25)
+#define MR_INTR_COALESCING_SUPPORT_OFFSET	(1 << 26)
 
 #define MEGASAS_WATCHDOG_THREAD_INTERVAL	1000
 #define MEGASAS_WAIT_FOR_NEXT_DMA_MSECS		20
@@ -2250,6 +2251,9 @@ enum MR_PD_TYPE {
 #define MR_DEFAULT_NVME_MDTS_KB		128
 #define MR_NVME_PAGE_SIZE_MASK		0x000000FF
 
+/*Aero performance parameters*/
+#define MR_HIGH_IOPS_QUEUE_COUNT	8
+
 struct megasas_instance {
 
 	unsigned int *reply_map;
@@ -2433,6 +2437,8 @@ struct megasas_instance {
 	bool atomic_desc_support;
 	bool support_seqnum_jbod_fp;
 	bool support_pci_lane_margining;
+	u8  low_latency_index_start;
+	bool balanced_mode;
 };
 
 struct MR_LD_VF_MAP {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 4c7a093..2e3c7fd 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5472,6 +5472,8 @@ megasas_setup_irqs_ioapic(struct megasas_instance *instance)
 				__func__, __LINE__);
 		return -1;
 	}
+	instance->balanced_mode = false;
+	instance->low_latency_index_start = 0;
 	return 0;
 }
 
@@ -5610,9 +5612,11 @@ megasas_setup_jbod_map(struct megasas_instance *instance)
 static void megasas_setup_reply_map(struct megasas_instance *instance)
 {
 	const struct cpumask *mask;
-	unsigned int queue, cpu;
+	unsigned int queue, cpu, low_latency_index_start;
 
-	for (queue = 0; queue < instance->msix_vectors; queue++) {
+	low_latency_index_start = instance->low_latency_index_start;
+
+	for (queue = low_latency_index_start; queue < instance->msix_vectors; queue++) {
 		mask = pci_irq_get_affinity(instance->pdev, queue);
 		if (!mask)
 			goto fallback;
@@ -5623,8 +5627,14 @@ static void megasas_setup_reply_map(struct megasas_instance *instance)
 	return;
 
 fallback:
-	for_each_possible_cpu(cpu)
-		instance->reply_map[cpu] = cpu % instance->msix_vectors;
+	queue = low_latency_index_start;
+	for_each_possible_cpu(cpu) {
+		instance->reply_map[cpu] = queue;
+		if (queue == (instance->msix_vectors - 1))
+			queue = low_latency_index_start;
+		else
+			queue++;
+	}
 }
 
 /**
@@ -5661,6 +5671,66 @@ int megasas_get_device_list(struct megasas_instance *instance)
 
 	return SUCCESS;
 }
+
+static int
+__megasas_alloc_irq_vectors(struct megasas_instance *instance)
+{
+	int i, irq_flags;
+	struct irq_affinity desc = { .pre_vectors = instance->low_latency_index_start };
+	struct irq_affinity *descp = &desc;
+
+	irq_flags = PCI_IRQ_MSIX;
+
+	if (instance->smp_affinity_enable)
+		irq_flags |= PCI_IRQ_AFFINITY;
+	else
+		descp = NULL;
+
+	i = pci_alloc_irq_vectors_affinity(instance->pdev,
+		instance->low_latency_index_start,
+		instance->msix_vectors, irq_flags, descp);
+
+	return i;
+}
+
+/**
+ * megasas_alloc_irq_vectors -	Allocate IRQ vectors/enable MSI-x vectors
+ * @instance:			Adapter soft state
+ * return:			void
+ */
+static void
+megasas_alloc_irq_vectors(struct megasas_instance *instance)
+{
+	int i;
+	unsigned int num_msix_req;
+
+	i = __megasas_alloc_irq_vectors(instance);
+
+	if (instance->balanced_mode && (i != instance->msix_vectors)) {
+		if (instance->msix_vectors)
+			pci_free_irq_vectors(instance->pdev);
+		/*Disable Balanced IOPs mode and try realloc vectors*/
+		instance->balanced_mode = false;
+		instance->low_latency_index_start = 1;
+		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+
+		instance->msix_vectors = min(num_msix_req,
+				instance->msix_vectors);
+
+		i = __megasas_alloc_irq_vectors(instance);
+
+	}
+
+	dev_info(&instance->pdev->dev,
+		"requested/available msix %d/%d\n", instance->msix_vectors, i);
+
+	if (i > 0)
+		instance->msix_vectors = i;
+	else
+		instance->msix_vectors = 0;
+
+}
+
 /**
  * megasas_init_fw -	Initializes the FW
  * @instance:		Adapter soft state
@@ -5680,6 +5750,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	int i, j, loop;
 	struct IOV_111 *iovPtr;
 	struct fusion_context *fusion;
+	bool intr_coalescing;
+	unsigned int num_msix_req;
 
 	fusion = instance->ctrl_context;
 
@@ -5799,7 +5871,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	msix_enable = (instance->instancet->read_fw_status_reg(instance) &
 		       0x4000000) >> 0x1a;
 	if (msix_enable && !msix_disable) {
-		int irq_flags = PCI_IRQ_MSIX;
 
 		scratch_pad_1 = megasas_readl
 			(instance, &instance->reg_set->outbound_scratch_pad_1);
@@ -5865,19 +5936,49 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		} else /* MFI adapters */
 			instance->msix_vectors = 1;
 
-		/* Don't bother allocating more MSI-X vectors than cpus */
-		instance->msix_vectors = min(instance->msix_vectors,
-					     (unsigned int)num_online_cpus());
-		if (instance->smp_affinity_enable)
-			irq_flags |= PCI_IRQ_AFFINITY;
-		i = pci_alloc_irq_vectors(instance->pdev, 1,
-					  instance->msix_vectors, irq_flags);
-		if (i > 0) {
-			instance->msix_vectors = i;
-		} else {
-			instance->msix_vectors = 0;
+
+		/*
+		 * For Aero(if few conditions are met), driver will configure
+		 * few additional reply queues with interrupt coalescing enabled.
+		 * These queues with interrupt coalescing enabled are called
+		 * High IOPs queues and rest of reply queues(based on number of
+		 * logical CPUs) are termed as Low latency queues.
+		 *
+		 * Total Number of reply queues = High IOPs queues + low latency queues
+		 *
+		 * For rest of fusion adapters, 1 additional reply queue will be
+		 * reserved for management commands, rest of reply queues
+		 * (based on number of logical CPUs) will be used for IOs and
+		 * referenced as IO queues.
+		 * Total Number of reply queues = 1 + IO queues
+		 *
+		 * MFI adapters supports single MSI-x so single reply queue
+		 * will be used for IO and management commands.
+		 */
+
+		intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
+								true : false;
+		if (intr_coalescing &&
+			(num_online_cpus() >= MR_HIGH_IOPS_QUEUE_COUNT) &&
+			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
+			instance->balanced_mode = true;
+		else
+			instance->balanced_mode = false;
+
+		if (instance->balanced_mode)
+			instance->low_latency_index_start =
+				MR_HIGH_IOPS_QUEUE_COUNT;
+		else
+			instance->low_latency_index_start = 1;
+
+		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+
+		instance->msix_vectors = min(num_msix_req,
+				instance->msix_vectors);
+
+		megasas_alloc_irq_vectors(instance);
+		if (!instance->msix_vectors)
 			instance->msix_load_balance = false;
-		}
 	}
 	/*
 	 * MSI-X host index 0 is common for all adapter.
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index e124341..44bfbe8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1058,6 +1058,7 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 	u32 scratch_pad_1;
 	ktime_t time;
 	bool cur_fw_64bit_dma_capable;
+	bool cur_intr_coalescing;
 
 	fusion = instance->ctrl_context;
 
@@ -1091,6 +1092,16 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 		goto fail_fw_init;
 	}
 
+	cur_intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
+							true : false;
+
+	if ((instance->low_latency_index_start ==
+		MR_HIGH_IOPS_QUEUE_COUNT) && cur_intr_coalescing)
+		instance->balanced_mode = true;
+
+	dev_info(&instance->pdev->dev, "Balanced mode :%s\n",
+		instance->balanced_mode ? "Yes" : "No");
+
 	instance->fw_sync_cache_support = (scratch_pad_1 &
 		MR_CAN_HANDLE_SYNC_CACHE_OFFSET) ? 1 : 0;
 	dev_info(&instance->pdev->dev, "FW supports sync cache\t: %s\n",
-- 
2.9.5

