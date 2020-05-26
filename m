Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD69B1C1FD7
	for <lists+linux-scsi@lfdr.de>; Fri,  1 May 2020 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgEAVnb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 May 2020 17:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgEAVnb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 May 2020 17:43:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F9C061A0C
        for <linux-scsi@vger.kernel.org>; Fri,  1 May 2020 14:43:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so1203069wmk.5
        for <linux-scsi@vger.kernel.org>; Fri, 01 May 2020 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8MSZKPDOb7IGLt+v012ivN8R700HtAuxnpbq7G97wnU=;
        b=fI2LjIhg2Ocid57x8lVsRgVO9BPxEpWWtXjU3c9PM1IftMriGJLiO9wGtrVtifNivB
         FsBaZpa3TaxlUX/8ZPvHJ+pkXoSllCeYLXc71P0yWffrWLvzom+YJ5uzF0yQ3hZuDy+x
         Ewck+NU+uKbSxKtbdqyrVUDbxavUrXv9De85YG7FFBrsMcEWbVtG9sS6UQcAPNs4MAul
         SytX7IqAjvWNIm1kpYSFJcUa3jf5DawRFWSBNzZWaCjW1PVEuIunUQ/8p6BnopUO1Lbe
         85Ni93UDGvF+tX8hwexpTSVbJXEghoeIdKwRRCQRecoTJBQZ7M2jCFSWg8JVVEh5VZOM
         MHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MSZKPDOb7IGLt+v012ivN8R700HtAuxnpbq7G97wnU=;
        b=CZqRB1Kzd3Al9tHdAifZfHzSS5czdmtH9CaAcouGo5A0QrSV648SFCTar0/DaoaG44
         UBY/wAz6srPOGuGQc+HONHxjmeYJoM5yJtX7+r6to2ZNLlruubnKY54E1qDMkNkhqpPY
         KZL+ofeyOf6lLlTicDq3+emz1w0XHL2orfNLJQIe1b//2ze3OX51rdNSGk3+uqQKUT68
         6IlfeLrRtUEEyKMW6eYnEp+WZgwWAWkUARvHzVDlR6ZV0bUriDoj+9UyffMfeSG77uIe
         SIyGhVV4BZN7YkxZ95w60CUxF44OEvSthOj5bXOARs5yqfGn3JW9FlWMG01Vt4r3IYW2
         PmIg==
X-Gm-Message-State: AGi0PuZ/VAsmZG/shBwJTIAsys7D6WLotS29vmWJflwppWJZ0e8gAKFX
        dCiKPp78XXK8SmHqBjb6mR0sDTRS
X-Google-Smtp-Source: APiQypLTwesKZ4YNd4ure7Ec02q9zVlytn+ZWk0+wgr6Qa6Wz3i+Zs3BhQN98MfqG1s7bTdHX+6Shw==
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr1526996wmf.16.1588369408726;
        Fri, 01 May 2020 14:43:28 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t2sm1207734wmt.15.2020.05.01.14.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 14:43:28 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 5/9] lpfc: Change default queue allocation for reduced memory consumption
Date:   Fri,  1 May 2020 14:43:06 -0700
Message-Id: <20200501214310.91713-6-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200501214310.91713-1-jsmart2021@gmail.com>
References: <20200501214310.91713-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

By default, the driver attempts to allocate a hdwq per logical cpu in
order to provide good cpu affinity. Some systems have extremely high cpu
counts and this can significantly raise memory consumption.

In testing on x86 platforms (non-AMD) it is found that sharing of a hdwq
by a physical cpu and it's HT cpu can occur with little performance
degredation. By sharing the hdwq count can be halved, significantly
reducing the memory overhead.

Change the default behavior of the driver on non-AMD x86 platforms to
share a hdwq by the cpu and its HT cpu.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |  23 ++++++--
 drivers/scsi/lpfc/lpfc_attr.c | 106 +++++++++++++++++++++++++++-------
 drivers/scsi/lpfc/lpfc_init.c |  82 +++++++++++---------------
 drivers/scsi/lpfc/lpfc_sli4.h |   2 +-
 4 files changed, 137 insertions(+), 76 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 8e2a356911a9..45657a7502f6 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -627,6 +627,19 @@ struct lpfc_ras_fwlog {
 	enum ras_state state;    /* RAS logging running state */
 };
 
+enum lpfc_irq_chann_mode {
+	/* Assign IRQs to all possible cpus that have hardware queues */
+	NORMAL_MODE,
+
+	/* Assign IRQs only to cpus on the same numa node as HBA */
+	NUMA_MODE,
+
+	/* Assign IRQs only on non-hyperthreaded CPUs. This is the
+	 * same as normal_mode, but assign IRQS only on physical CPUs.
+	 */
+	NHT_MODE,
+};
+
 struct lpfc_hba {
 	/* SCSI interface function jump table entries */
 	struct lpfc_io_buf * (*lpfc_get_scsi_buf)
@@ -835,7 +848,6 @@ struct lpfc_hba {
 	uint32_t cfg_fcp_mq_threshold;
 	uint32_t cfg_hdw_queue;
 	uint32_t cfg_irq_chann;
-	uint32_t cfg_irq_numa;
 	uint32_t cfg_suppress_rsp;
 	uint32_t cfg_nvme_oas;
 	uint32_t cfg_nvme_embed_cmd;
@@ -1003,6 +1015,7 @@ struct lpfc_hba {
 	mempool_t *active_rrq_pool;
 
 	struct fc_host_statistics link_stats;
+	enum lpfc_irq_chann_mode irq_chann_mode;
 	enum intr_type_t intr_type;
 	uint32_t intr_mode;
 #define LPFC_INTR_ERROR	0xFFFFFFFF
@@ -1314,19 +1327,19 @@ lpfc_phba_elsring(struct lpfc_hba *phba)
 }
 
 /**
- * lpfc_next_online_numa_cpu - Finds next online CPU on NUMA node
- * @numa_mask: Pointer to phba's numa_mask member.
+ * lpfc_next_online_cpu - Finds next online CPU on cpumask
+ * @mask: Pointer to phba's cpumask member.
  * @start: starting cpu index
  *
  * Note: If no valid cpu found, then nr_cpu_ids is returned.
  *
  **/
 static inline unsigned int
-lpfc_next_online_numa_cpu(const struct cpumask *numa_mask, unsigned int start)
+lpfc_next_online_cpu(const struct cpumask *mask, unsigned int start)
 {
 	unsigned int cpu_it;
 
-	for_each_cpu_wrap(cpu_it, numa_mask, start) {
+	for_each_cpu_wrap(cpu_it, mask, start) {
 		if (cpu_online(cpu_it))
 			break;
 	}
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 1354c141d614..2791efa770af 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5704,17 +5704,69 @@ LPFC_ATTR_R(hdw_queue,
 	    LPFC_HBA_HDWQ_MIN, LPFC_HBA_HDWQ_MAX,
 	    "Set the number of I/O Hardware Queues");
 
-static inline void
-lpfc_assign_default_irq_numa(struct lpfc_hba *phba)
+#if IS_ENABLED(CONFIG_X86)
+/**
+ * lpfc_cpumask_irq_mode_init - initalizes cpumask of phba based on
+ *				irq_chann_mode
+ * @phba: Pointer to HBA context object.
+ **/
+static void
+lpfc_cpumask_irq_mode_init(struct lpfc_hba *phba)
+{
+	unsigned int cpu, first_cpu, numa_node = NUMA_NO_NODE;
+	const struct cpumask *sibling_mask;
+	struct cpumask *aff_mask = &phba->sli4_hba.irq_aff_mask;
+
+	cpumask_clear(aff_mask);
+
+	if (phba->irq_chann_mode == NUMA_MODE) {
+		/* Check if we're a NUMA architecture */
+		numa_node = dev_to_node(&phba->pcidev->dev);
+		if (numa_node == NUMA_NO_NODE) {
+			phba->irq_chann_mode = NORMAL_MODE;
+			return;
+		}
+	}
+
+	for_each_possible_cpu(cpu) {
+		switch (phba->irq_chann_mode) {
+		case NUMA_MODE:
+			if (cpu_to_node(cpu) == numa_node)
+				cpumask_set_cpu(cpu, aff_mask);
+			break;
+		case NHT_MODE:
+			sibling_mask = topology_sibling_cpumask(cpu);
+			first_cpu = cpumask_first(sibling_mask);
+			if (first_cpu < nr_cpu_ids)
+				cpumask_set_cpu(first_cpu, aff_mask);
+			break;
+		default:
+			break;
+		}
+	}
+}
+#endif
+
+static void
+lpfc_assign_default_irq_chann(struct lpfc_hba *phba)
 {
 #if IS_ENABLED(CONFIG_X86)
-	/* If AMD architecture, then default is LPFC_IRQ_CHANN_NUMA */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		phba->cfg_irq_numa = 1;
-	else
-		phba->cfg_irq_numa = 0;
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		/* If AMD architecture, then default is NUMA_MODE */
+		phba->irq_chann_mode = NUMA_MODE;
+		break;
+	case X86_VENDOR_INTEL:
+		/* If Intel architecture, then default is no hyperthread mode */
+		phba->irq_chann_mode = NHT_MODE;
+		break;
+	default:
+		phba->irq_chann_mode = NORMAL_MODE;
+		break;
+	}
+	lpfc_cpumask_irq_mode_init(phba);
 #else
-	phba->cfg_irq_numa = 0;
+	phba->irq_chann_mode = NORMAL_MODE;
 #endif
 }
 
@@ -5726,6 +5778,7 @@ lpfc_assign_default_irq_numa(struct lpfc_hba *phba)
  *
  *	0		= Configure number of IRQ Channels to:
  *			  if AMD architecture, number of CPUs on HBA's NUMA node
+ *			  if Intel architecture, number of physical CPUs.
  *			  otherwise, number of active CPUs.
  *	[1,256]		= Manually specify how many IRQ Channels to use.
  *
@@ -5751,35 +5804,44 @@ MODULE_PARM_DESC(lpfc_irq_chann, "Set number of interrupt vectors to allocate");
 static int
 lpfc_irq_chann_init(struct lpfc_hba *phba, uint32_t val)
 {
-	const struct cpumask *numa_mask;
+	const struct cpumask *aff_mask;
 
 	if (phba->cfg_use_msi != 2) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"8532 use_msi = %u ignoring cfg_irq_numa\n",
 				phba->cfg_use_msi);
-		phba->cfg_irq_numa = 0;
-		phba->cfg_irq_chann = LPFC_IRQ_CHANN_MIN;
+		phba->irq_chann_mode = NORMAL_MODE;
+		phba->cfg_irq_chann = LPFC_IRQ_CHANN_DEF;
 		return 0;
 	}
 
 	/* Check if default setting was passed */
 	if (val == LPFC_IRQ_CHANN_DEF)
-		lpfc_assign_default_irq_numa(phba);
+		lpfc_assign_default_irq_chann(phba);
 
-	if (phba->cfg_irq_numa) {
-		numa_mask = &phba->sli4_hba.numa_mask;
+	if (phba->irq_chann_mode != NORMAL_MODE) {
+		aff_mask = &phba->sli4_hba.irq_aff_mask;
 
-		if (cpumask_empty(numa_mask)) {
+		if (cpumask_empty(aff_mask)) {
 			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-					"8533 Could not identify NUMA node, "
-					"ignoring cfg_irq_numa\n");
-			phba->cfg_irq_numa = 0;
-			phba->cfg_irq_chann = LPFC_IRQ_CHANN_MIN;
+					"8533 Could not identify CPUS for "
+					"mode %d, ignoring\n",
+					phba->irq_chann_mode);
+			phba->irq_chann_mode = NORMAL_MODE;
+			phba->cfg_irq_chann = LPFC_IRQ_CHANN_DEF;
 		} else {
-			phba->cfg_irq_chann = cpumask_weight(numa_mask);
+			phba->cfg_irq_chann = cpumask_weight(aff_mask);
+
+			/* If no hyperthread mode, then set hdwq count to
+			 * aff_mask weight as well
+			 */
+			if (phba->irq_chann_mode == NHT_MODE)
+				phba->cfg_hdw_queue = phba->cfg_irq_chann;
+
 			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 					"8543 lpfc_irq_chann set to %u "
-					"(numa)\n", phba->cfg_irq_chann);
+					"(mode: %d)\n", phba->cfg_irq_chann,
+					phba->irq_chann_mode);
 		}
 	} else {
 		if (val > LPFC_IRQ_CHANN_MAX) {
@@ -5790,7 +5852,7 @@ lpfc_irq_chann_init(struct lpfc_hba *phba, uint32_t val)
 					val,
 					LPFC_IRQ_CHANN_MIN,
 					LPFC_IRQ_CHANN_MAX);
-			phba->cfg_irq_chann = LPFC_IRQ_CHANN_MIN;
+			phba->cfg_irq_chann = LPFC_IRQ_CHANN_DEF;
 			return -EINVAL;
 		}
 		phba->cfg_irq_chann = val;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 4104bdcdbb6f..8b8530351843 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -6022,29 +6022,6 @@ static void lpfc_log_intr_mode(struct lpfc_hba *phba, uint32_t intr_mode)
 	return;
 }
 
-/**
- * lpfc_cpumask_of_node_init - initalizes cpumask of phba's NUMA node
- * @phba: Pointer to HBA context object.
- *
- **/
-static void
-lpfc_cpumask_of_node_init(struct lpfc_hba *phba)
-{
-	unsigned int cpu, numa_node;
-	struct cpumask *numa_mask = &phba->sli4_hba.numa_mask;
-
-	cpumask_clear(numa_mask);
-
-	/* Check if we're a NUMA architecture */
-	numa_node = dev_to_node(&phba->pcidev->dev);
-	if (numa_node == NUMA_NO_NODE)
-		return;
-
-	for_each_possible_cpu(cpu)
-		if (cpu_to_node(cpu) == numa_node)
-			cpumask_set_cpu(cpu, numa_mask);
-}
-
 /**
  * lpfc_enable_pci_dev - Enable a generic PCI device.
  * @phba: pointer to lpfc hba data structure.
@@ -6483,7 +6460,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	phba->sli4_hba.num_present_cpu = lpfc_present_cpu;
 	phba->sli4_hba.num_possible_cpu = cpumask_last(cpu_possible_mask) + 1;
 	phba->sli4_hba.curr_disp_cpu = 0;
-	lpfc_cpumask_of_node_init(phba);
 
 	/* Get all the module params for configuring this host */
 	lpfc_get_cfgparam(phba);
@@ -6691,6 +6667,13 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 #endif
 				/* Not supported for NVMET */
 				phba->cfg_xri_rebalancing = 0;
+				if (phba->irq_chann_mode == NHT_MODE) {
+					phba->cfg_irq_chann =
+						phba->sli4_hba.num_present_cpu;
+					phba->cfg_hdw_queue =
+						phba->sli4_hba.num_present_cpu;
+					phba->irq_chann_mode = NORMAL_MODE;
+				}
 				break;
 			}
 		}
@@ -7032,7 +7015,7 @@ lpfc_sli4_driver_resource_unset(struct lpfc_hba *phba)
 	phba->sli4_hba.num_possible_cpu = 0;
 	phba->sli4_hba.num_present_cpu = 0;
 	phba->sli4_hba.curr_disp_cpu = 0;
-	cpumask_clear(&phba->sli4_hba.numa_mask);
+	cpumask_clear(&phba->sli4_hba.irq_aff_mask);
 
 	/* Free memory allocated for fast-path work queue handles */
 	kfree(phba->sli4_hba.hba_eq_hdl);
@@ -11287,11 +11270,12 @@ lpfc_irq_clear_aff(struct lpfc_hba_eq_hdl *eqhdl)
  * @offline: true, cpu is going offline. false, cpu is coming online.
  *
  * If cpu is going offline, we'll try our best effort to find the next
- * online cpu on the phba's NUMA node and migrate all offlining IRQ affinities.
+ * online cpu on the phba's original_mask and migrate all offlining IRQ
+ * affinities.
  *
- * If cpu is coming online, reaffinitize the IRQ back to the onlineng cpu.
+ * If cpu is coming online, reaffinitize the IRQ back to the onlining cpu.
  *
- * Note: Call only if cfg_irq_numa is enabled, otherwise rely on
+ * Note: Call only if NUMA or NHT mode is enabled, otherwise rely on
  *	 PCI_IRQ_AFFINITY to auto-manage IRQ affinity.
  *
  **/
@@ -11301,14 +11285,14 @@ lpfc_irq_rebalance(struct lpfc_hba *phba, unsigned int cpu, bool offline)
 	struct lpfc_vector_map_info *cpup;
 	struct cpumask *aff_mask;
 	unsigned int cpu_select, cpu_next, idx;
-	const struct cpumask *numa_mask;
+	const struct cpumask *orig_mask;
 
-	if (!phba->cfg_irq_numa)
+	if (phba->irq_chann_mode == NORMAL_MODE)
 		return;
 
-	numa_mask = &phba->sli4_hba.numa_mask;
+	orig_mask = &phba->sli4_hba.irq_aff_mask;
 
-	if (!cpumask_test_cpu(cpu, numa_mask))
+	if (!cpumask_test_cpu(cpu, orig_mask))
 		return;
 
 	cpup = &phba->sli4_hba.cpu_map[cpu];
@@ -11317,9 +11301,9 @@ lpfc_irq_rebalance(struct lpfc_hba *phba, unsigned int cpu, bool offline)
 		return;
 
 	if (offline) {
-		/* Find next online CPU on NUMA node */
-		cpu_next = cpumask_next_wrap(cpu, numa_mask, cpu, true);
-		cpu_select = lpfc_next_online_numa_cpu(numa_mask, cpu_next);
+		/* Find next online CPU on original mask */
+		cpu_next = cpumask_next_wrap(cpu, orig_mask, cpu, true);
+		cpu_select = lpfc_next_online_cpu(orig_mask, cpu_next);
 
 		/* Found a valid CPU */
 		if ((cpu_select < nr_cpu_ids) && (cpu_select != cpu)) {
@@ -11434,7 +11418,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 {
 	int vectors, rc, index;
 	char *name;
-	const struct cpumask *numa_mask = NULL;
+	const struct cpumask *aff_mask = NULL;
 	unsigned int cpu = 0, cpu_cnt = 0, cpu_select = nr_cpu_ids;
 	struct lpfc_hba_eq_hdl *eqhdl;
 	const struct cpumask *maskp;
@@ -11444,16 +11428,18 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 	/* Set up MSI-X multi-message vectors */
 	vectors = phba->cfg_irq_chann;
 
-	if (phba->cfg_irq_numa) {
-		numa_mask = &phba->sli4_hba.numa_mask;
-		cpu_cnt = cpumask_weight(numa_mask);
+	if (phba->irq_chann_mode != NORMAL_MODE)
+		aff_mask = &phba->sli4_hba.irq_aff_mask;
+
+	if (aff_mask) {
+		cpu_cnt = cpumask_weight(aff_mask);
 		vectors = min(phba->cfg_irq_chann, cpu_cnt);
 
-		/* cpu: iterates over numa_mask including offline or online
-		 * cpu_select: iterates over online numa_mask to set affinity
+		/* cpu: iterates over aff_mask including offline or online
+		 * cpu_select: iterates over online aff_mask to set affinity
 		 */
-		cpu = cpumask_first(numa_mask);
-		cpu_select = lpfc_next_online_numa_cpu(numa_mask, cpu);
+		cpu = cpumask_first(aff_mask);
+		cpu_select = lpfc_next_online_cpu(aff_mask, cpu);
 	} else {
 		flags |= PCI_IRQ_AFFINITY;
 	}
@@ -11487,7 +11473,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 
 		eqhdl->irq = pci_irq_vector(phba->pcidev, index);
 
-		if (phba->cfg_irq_numa) {
+		if (aff_mask) {
 			/* If found a neighboring online cpu, set affinity */
 			if (cpu_select < nr_cpu_ids)
 				lpfc_irq_set_aff(eqhdl, cpu_select);
@@ -11497,11 +11483,11 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 						LPFC_CPU_FIRST_IRQ,
 						cpu);
 
-			/* Iterate to next offline or online cpu in numa_mask */
-			cpu = cpumask_next(cpu, numa_mask);
+			/* Iterate to next offline or online cpu in aff_mask */
+			cpu = cpumask_next(cpu, aff_mask);
 
-			/* Find next online cpu in numa_mask to set affinity */
-			cpu_select = lpfc_next_online_numa_cpu(numa_mask, cpu);
+			/* Find next online cpu in aff_mask to set affinity */
+			cpu_select = lpfc_next_online_cpu(aff_mask, cpu);
 		} else if (vectors == 1) {
 			cpu = cpumask_first(cpu_present_mask);
 			lpfc_assign_eq_map_info(phba, index, LPFC_CPU_FIRST_IRQ,
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 8da7429e385a..4decb53d81c3 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -920,7 +920,7 @@ struct lpfc_sli4_hba {
 	struct lpfc_vector_map_info *cpu_map;
 	uint16_t num_possible_cpu;
 	uint16_t num_present_cpu;
-	struct cpumask numa_mask;
+	struct cpumask irq_aff_mask;
 	uint16_t curr_disp_cpu;
 	struct lpfc_eq_intr_info __percpu *eq_info;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
-- 
2.26.1

