Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAFEF25D
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 01:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfKEA5m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 19:57:42 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36023 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbfKEA5m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Nov 2019 19:57:42 -0500
Received: by mail-wr1-f49.google.com with SMTP id w18so19306220wrt.3
        for <linux-scsi@vger.kernel.org>; Mon, 04 Nov 2019 16:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8WT+WTyUO2P38t4DAIos5iweAty8TUhYQDfUhpOgIvE=;
        b=h86ylRhYJDyB/xpb786c7PEgDS0c/JWsjC1qpU1FytkRgygTJbR1Mhar3H+XszzosB
         77fIApAvuulXBO6L8KI63b2gBHExgAezIo7+20IBupy6AqJ7YvhZqz8VwVi/7jxvElxN
         28rTYzXUAJVRhLfH6VwOALyihT/Rh0MnhjKVI0H/MPqV7QHz5tfw/LH9e9+Eag8lHY+4
         ut7Vkn+aaS/5cfVY/kUJSlStPiW6Xw15juD+lmVhnV69Ip3cM3iAv05o71kReaJ8Db7i
         rkE3Modi8yXxhxFJ2Bdb1LkkJhs0lteA5gRQpKjPgA1ScWvVFpAPuvBbl+VKdP1bq7ah
         6YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8WT+WTyUO2P38t4DAIos5iweAty8TUhYQDfUhpOgIvE=;
        b=SrSXdsz+if3et1XN+9uy7cPbGK1r+jPSHKESjDMorLWRbs12nkp5WXlZ+FljhvLeIS
         +mcgwo8eAHXkMNmzJzgzv15PRh9YGOTuw1gTlVuXIbL1axevKOyaSO071vJKCy1dRtOY
         iDBvtK60xacglrJ6yOMHt0guvjMPN0PUOGibw0zh7HVeFupOrRSKM9JsroXfbe23lMsa
         4KLSKe9u25OEr73KtDApen+92nZ0Noy31RFnV7l52YvNvwxGJBaTh35BxDbHS4fx8zEd
         Hl92qNAWXK9UCObMK3FNscdn/HQXbxcalQSemNiyLsqAQeNOZsSgXYlPhwkzs+nUCmsb
         /eFA==
X-Gm-Message-State: APjAAAW9OLYD8P5G0KbZUghmQ3PujOq5P0u/q3xKq13phe3VB5+Kcc3z
        NrmwWXjuPD4vMpE7ZWnE3gLgN20oGJA=
X-Google-Smtp-Source: APXvYqx47MJGQ+DWEH00YGhKeCtm//lhOLlzrGj/Ed0euUE2nJgxJleLqZL5PfreEQS9SrHvfEg8YA==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr20591806wrm.299.1572915455899;
        Mon, 04 Nov 2019 16:57:35 -0800 (PST)
Received: from pallmd1.broadcom.com ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id g5sm16920991wma.43.2019.11.04.16.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 16:57:35 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 09/11] lpfc: Change default IRQ model on AMD architectures
Date:   Mon,  4 Nov 2019 16:57:06 -0800
Message-Id: <20191105005708.7399-10-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191105005708.7399-1-jsmart2021@gmail.com>
References: <20191105005708.7399-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current driver attempts to allocate an interrupt vector
per cpu using the systems managed IRQ allocator (flag
PCI_IRQ_AFFINITY). The system IRQ allocator will either provide
the per-cpu vector, or return fewer vectors. When fewer vectors,
they are evenly spread between the numa nodes on the system.
When run on an AMD architecture, if interrupts occur to a cpu that
is not in the same numa node as the adapter generating the
interrupt, there are extreme costs and overheads in performance.
Thus, if 1:1 vector allocation is used, or the "balanced" vectors
in the other numa nodes, performance can be hit significantly.

A much more performance model is to allocate interrupts only on
the cpus that are in the numa node where the adapter resides.
I/O completion is still performed by the cpu that where the I/O
was generated. Unfortunately, there is no flag to request the
managed IRQ subsystem allocate vectors only for the cpu's in the
numa node as the adapter.

On AMD architecture, revert the irq allocation to the normal style
(non-managed) and then use irq_set_affinity_hint() to set the cpu
affinity and disable user-space rebalancing.

Tie the support into CPU offline/online. If the cpu being offlined
owns a vector, the vector is re-affinitized to one of the other
cpu's on the same numa node. If there are no more cpus on the
numa node, the vector has all affinity removed and lets the system
determine where it's serviced. Similarly, when the cpu that owned
a vector comes online, the vector is reaffinitized to the cpu.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |  21 ++
 drivers/scsi/lpfc/lpfc_attr.c | 132 +++++++++++--
 drivers/scsi/lpfc/lpfc_init.c | 450 +++++++++++++++++++++++++++++++-----------
 drivers/scsi/lpfc/lpfc_sli4.h |  19 +-
 4 files changed, 484 insertions(+), 138 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 88d5fd99f5ec..935f98804198 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -837,6 +837,7 @@ struct lpfc_hba {
 	uint32_t cfg_fcp_mq_threshold;
 	uint32_t cfg_hdw_queue;
 	uint32_t cfg_irq_chann;
+	uint32_t cfg_irq_numa;
 	uint32_t cfg_suppress_rsp;
 	uint32_t cfg_nvme_oas;
 	uint32_t cfg_nvme_embed_cmd;
@@ -1312,6 +1313,26 @@ lpfc_phba_elsring(struct lpfc_hba *phba)
 }
 
 /**
+ * lpfc_next_online_numa_cpu - Finds next online CPU on NUMA node
+ * @numa_mask: Pointer to phba's numa_mask member.
+ * @start: starting cpu index
+ *
+ * Note: If no valid cpu found, then nr_cpu_ids is returned.
+ *
+ **/
+static inline unsigned int
+lpfc_next_online_numa_cpu(const struct cpumask *numa_mask, unsigned int start)
+{
+	unsigned int cpu_it;
+
+	for_each_cpu_wrap(cpu_it, numa_mask, start) {
+		if (cpu_online(cpu_it))
+			break;
+	}
+
+	return cpu_it;
+}
+/**
  * lpfc_sli4_mod_hba_eq_delay - update EQ delay
  * @phba: Pointer to HBA context object.
  * @q: The Event Queue to update.
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index e7f6581935bf..4ff82b36a37a 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5331,7 +5331,7 @@ lpfc_fcp_cpu_map_show(struct device *dev, struct device_attribute *attr,
 			len += scnprintf(buf + len, PAGE_SIZE - len,
 					"CPU %02d not present\n",
 					phba->sli4_hba.curr_disp_cpu);
-		else if (cpup->irq == LPFC_VECTOR_MAP_EMPTY) {
+		else if (cpup->eq == LPFC_VECTOR_MAP_EMPTY) {
 			if (cpup->hdwq == LPFC_VECTOR_MAP_EMPTY)
 				len += scnprintf(
 					buf + len, PAGE_SIZE - len,
@@ -5344,10 +5344,10 @@ lpfc_fcp_cpu_map_show(struct device *dev, struct device_attribute *attr,
 			else
 				len += scnprintf(
 					buf + len, PAGE_SIZE - len,
-					"CPU %02d EQ %04d hdwq %04d "
+					"CPU %02d EQ None hdwq %04d "
 					"physid %d coreid %d ht %d ua %d\n",
 					phba->sli4_hba.curr_disp_cpu,
-					cpup->eq, cpup->hdwq, cpup->phys_id,
+					cpup->hdwq, cpup->phys_id,
 					cpup->core_id,
 					(cpup->flag & LPFC_CPU_MAP_HYPER),
 					(cpup->flag & LPFC_CPU_MAP_UNASSIGN));
@@ -5362,7 +5362,7 @@ lpfc_fcp_cpu_map_show(struct device *dev, struct device_attribute *attr,
 					cpup->core_id,
 					(cpup->flag & LPFC_CPU_MAP_HYPER),
 					(cpup->flag & LPFC_CPU_MAP_UNASSIGN),
-					cpup->irq);
+					lpfc_get_irq(cpup->eq));
 			else
 				len += scnprintf(
 					buf + len, PAGE_SIZE - len,
@@ -5373,7 +5373,7 @@ lpfc_fcp_cpu_map_show(struct device *dev, struct device_attribute *attr,
 					cpup->core_id,
 					(cpup->flag & LPFC_CPU_MAP_HYPER),
 					(cpup->flag & LPFC_CPU_MAP_UNASSIGN),
-					cpup->irq);
+					lpfc_get_irq(cpup->eq));
 		}
 
 		phba->sli4_hba.curr_disp_cpu++;
@@ -5744,7 +5744,7 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
  * the driver will advertise it supports to the SCSI layer.
  *
  *      0    = Set nr_hw_queues by the number of CPUs or HW queues.
- *      1,128 = Manually specify the maximum nr_hw_queue value to be set,
+ *      1,256 = Manually specify nr_hw_queue value to be advertised,
  *
  * Value range is [0,256]. Default value is 8.
  */
@@ -5762,30 +5762,130 @@ LPFC_ATTR_R(fcp_mq_threshold, LPFC_FCP_MQ_THRESHOLD_DEF,
  * A hardware IO queue maps (qidx) to a specific driver CQ/WQ.
  *
  *      0    = Configure the number of hdw queues to the number of active CPUs.
- *      1,128 = Manually specify how many hdw queues to use.
+ *      1,256 = Manually specify how many hdw queues to use.
  *
- * Value range is [0,128]. Default value is 0.
+ * Value range is [0,256]. Default value is 0.
  */
 LPFC_ATTR_R(hdw_queue,
 	    LPFC_HBA_HDWQ_DEF,
 	    LPFC_HBA_HDWQ_MIN, LPFC_HBA_HDWQ_MAX,
 	    "Set the number of I/O Hardware Queues");
 
+static inline void
+lpfc_assign_default_irq_numa(struct lpfc_hba *phba)
+{
+#if IS_ENABLED(CONFIG_X86)
+	/* If AMD architecture, then default is LPFC_IRQ_CHANN_NUMA */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		phba->cfg_irq_numa = 1;
+	else
+		phba->cfg_irq_numa = 0;
+#else
+	phba->cfg_irq_numa = 0;
+#endif
+}
+
 /*
  * lpfc_irq_chann: Set the number of IRQ vectors that are available
  * for Hardware Queues to utilize.  This also will map to the number
  * of EQ / MSI-X vectors the driver will create. This should never be
  * more than the number of Hardware Queues
  *
- *      0     = Configure number of IRQ Channels to the number of active CPUs.
- *      1,128 = Manually specify how many IRQ Channels to use.
+ *	0		= Configure number of IRQ Channels to:
+ *			  if AMD architecture, number of CPUs on HBA's NUMA node
+ *			  otherwise, number of active CPUs.
+ *	[1,256]		= Manually specify how many IRQ Channels to use.
  *
- * Value range is [0,128]. Default value is 0.
+ * Value range is [0,256]. Default value is [0].
  */
-LPFC_ATTR_R(irq_chann,
-	    LPFC_HBA_HDWQ_DEF,
-	    LPFC_HBA_HDWQ_MIN, LPFC_HBA_HDWQ_MAX,
-	    "Set the number of I/O IRQ Channels");
+static uint lpfc_irq_chann = LPFC_IRQ_CHANN_DEF;
+module_param(lpfc_irq_chann, uint, 0444);
+MODULE_PARM_DESC(lpfc_irq_chann, "Set number of interrupt vectors to allocate");
+
+/* lpfc_irq_chann_init - Set the hba irq_chann initial value
+ * @phba: lpfc_hba pointer.
+ * @val: contains the initial value
+ *
+ * Description:
+ * Validates the initial value is within range and assigns it to the
+ * adapter. If not in range, an error message is posted and the
+ * default value is assigned.
+ *
+ * Returns:
+ * zero if value is in range and is set
+ * -EINVAL if value was out of range
+ **/
+static int
+lpfc_irq_chann_init(struct lpfc_hba *phba, uint32_t val)
+{
+	const struct cpumask *numa_mask;
+
+	if (phba->cfg_use_msi != 2) {
+		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
+				"8532 use_msi = %u ignoring cfg_irq_numa\n",
+				phba->cfg_use_msi);
+		phba->cfg_irq_numa = 0;
+		phba->cfg_irq_chann = LPFC_IRQ_CHANN_MIN;
+		return 0;
+	}
+
+	/* Check if default setting was passed */
+	if (val == LPFC_IRQ_CHANN_DEF)
+		lpfc_assign_default_irq_numa(phba);
+
+	if (phba->cfg_irq_numa) {
+		numa_mask = &phba->sli4_hba.numa_mask;
+
+		if (cpumask_empty(numa_mask)) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
+					"8533 Could not identify NUMA node, "
+					"ignoring cfg_irq_numa\n");
+			phba->cfg_irq_numa = 0;
+			phba->cfg_irq_chann = LPFC_IRQ_CHANN_MIN;
+		} else {
+			phba->cfg_irq_chann = cpumask_weight(numa_mask);
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
+					"8543 lpfc_irq_chann set to %u "
+					"(numa)\n", phba->cfg_irq_chann);
+		}
+	} else {
+		if (val > LPFC_IRQ_CHANN_MAX) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
+					"8545 lpfc_irq_chann attribute cannot "
+					"be set to %u, allowed range is "
+					"[%u,%u]\n",
+					val,
+					LPFC_IRQ_CHANN_MIN,
+					LPFC_IRQ_CHANN_MAX);
+			phba->cfg_irq_chann = LPFC_IRQ_CHANN_MIN;
+			return -EINVAL;
+		}
+		phba->cfg_irq_chann = val;
+	}
+
+	return 0;
+}
+
+/**
+ * lpfc_irq_chann_show - Display value of irq_chann
+ * @dev: class converted to a Scsi_host structure.
+ * @attr: device attribute, not used.
+ * @buf: on return contains a string with the list sizes
+ *
+ * Returns: size of formatted string.
+ **/
+static ssize_t
+lpfc_irq_chann_show(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
+	struct lpfc_hba *phba = vport->phba;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", phba->cfg_irq_chann);
+}
+
+static DEVICE_ATTR_RO(lpfc_irq_chann);
 
 /*
 # lpfc_enable_hba_reset: Allow or prevent HBA resets to the hardware.
@@ -7190,6 +7290,7 @@ lpfc_get_hba_function_mode(struct lpfc_hba *phba)
 void
 lpfc_get_cfgparam(struct lpfc_hba *phba)
 {
+	lpfc_hba_log_verbose_init(phba, lpfc_log_verbose);
 	lpfc_fcp_io_sched_init(phba, lpfc_fcp_io_sched);
 	lpfc_ns_query_init(phba, lpfc_ns_query);
 	lpfc_fcp2_no_tgt_reset_init(phba, lpfc_fcp2_no_tgt_reset);
@@ -7296,7 +7397,6 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	phba->cfg_soft_wwpn = 0L;
 	lpfc_sg_seg_cnt_init(phba, lpfc_sg_seg_cnt);
 	lpfc_hba_queue_depth_init(phba, lpfc_hba_queue_depth);
-	lpfc_hba_log_verbose_init(phba, lpfc_log_verbose);
 	lpfc_aer_support_init(phba, lpfc_aer_support);
 	lpfc_sriov_nr_virtfn_init(phba, lpfc_sriov_nr_virtfn);
 	lpfc_request_firmware_upgrade_init(phba, lpfc_req_fw_upgrade);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 888ad32d5267..28e6a763f106 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -40,6 +40,7 @@
 #include <linux/irq.h>
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
+#include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 
 #include <scsi/scsi.h>
@@ -5996,6 +5997,35 @@ static void lpfc_log_intr_mode(struct lpfc_hba *phba, uint32_t intr_mode)
 }
 
 /**
+ * lpfc_cpumask_of_node_init - initalizes cpumask of phba's NUMA node
+ * @phba: Pointer to HBA context object.
+ *
+ **/
+static void
+lpfc_cpumask_of_node_init(struct lpfc_hba *phba)
+{
+	unsigned int cpu, numa_node;
+	struct cpumask *numa_mask = NULL;
+
+#ifdef CONFIG_NUMA
+	numa_node = phba->pcidev->dev.numa_node;
+#else
+	numa_node = NUMA_NO_NODE;
+#endif
+	numa_mask = &phba->sli4_hba.numa_mask;
+
+	cpumask_clear(numa_mask);
+
+	/* Check if we're a NUMA architecture */
+	if (!cpumask_of_node(numa_node))
+		return;
+
+	for_each_possible_cpu(cpu)
+		if (cpu_to_node(cpu) == numa_node)
+			cpumask_set_cpu(cpu, numa_mask);
+}
+
+/**
  * lpfc_enable_pci_dev - Enable a generic PCI device.
  * @phba: pointer to lpfc hba data structure.
  *
@@ -6438,6 +6468,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	phba->sli4_hba.num_present_cpu = lpfc_present_cpu;
 	phba->sli4_hba.num_possible_cpu = num_possible_cpus();
 	phba->sli4_hba.curr_disp_cpu = 0;
+	lpfc_cpumask_of_node_init(phba);
 
 	/* Get all the module params for configuring this host */
 	lpfc_get_cfgparam(phba);
@@ -6973,6 +7004,7 @@ lpfc_sli4_driver_resource_unset(struct lpfc_hba *phba)
 	phba->sli4_hba.num_possible_cpu = 0;
 	phba->sli4_hba.num_present_cpu = 0;
 	phba->sli4_hba.curr_disp_cpu = 0;
+	cpumask_clear(&phba->sli4_hba.numa_mask);
 
 	/* Free memory allocated for fast-path work queue handles */
 	kfree(phba->sli4_hba.hba_eq_hdl);
@@ -10686,7 +10718,6 @@ lpfc_find_cpu_handle(struct lpfc_hba *phba, uint16_t id, int match)
 		 */
 		if ((match == LPFC_FIND_BY_EQ) &&
 		    (cpup->flag & LPFC_CPU_FIRST_IRQ) &&
-		    (cpup->irq != LPFC_VECTOR_MAP_EMPTY) &&
 		    (cpup->eq == id))
 			return cpu;
 
@@ -10724,6 +10755,75 @@ lpfc_find_hyper(struct lpfc_hba *phba, int cpu,
 }
 #endif
 
+/*
+ * lpfc_assign_eq_map_info - Assigns eq for vector_map structure
+ * @phba: pointer to lpfc hba data structure.
+ * @eqidx: index for eq and irq vector
+ * @flag: flags to set for vector_map structure
+ * @cpu: cpu used to index vector_map structure
+ *
+ * The routine assigns eq info into vector_map structure
+ */
+static inline void
+lpfc_assign_eq_map_info(struct lpfc_hba *phba, uint16_t eqidx, uint16_t flag,
+			unsigned int cpu)
+{
+	struct lpfc_vector_map_info *cpup = &phba->sli4_hba.cpu_map[cpu];
+	struct lpfc_hba_eq_hdl *eqhdl = lpfc_get_eq_hdl(eqidx);
+
+	cpup->eq = eqidx;
+	cpup->flag |= flag;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
+			"3336 Set Affinity: CPU %d irq %d eq %d flag x%x\n",
+			cpu, eqhdl->irq, cpup->eq, cpup->flag);
+}
+
+/**
+ * lpfc_cpu_map_array_init - Initialize cpu_map structure
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * The routine initializes the cpu_map array structure
+ */
+static void
+lpfc_cpu_map_array_init(struct lpfc_hba *phba)
+{
+	struct lpfc_vector_map_info *cpup;
+	struct lpfc_eq_intr_info *eqi;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+		cpup->phys_id = LPFC_VECTOR_MAP_EMPTY;
+		cpup->core_id = LPFC_VECTOR_MAP_EMPTY;
+		cpup->hdwq = LPFC_VECTOR_MAP_EMPTY;
+		cpup->eq = LPFC_VECTOR_MAP_EMPTY;
+		cpup->flag = 0;
+		eqi = per_cpu_ptr(phba->sli4_hba.eq_info, cpu);
+		INIT_LIST_HEAD(&eqi->list);
+		eqi->icnt = 0;
+	}
+}
+
+/**
+ * lpfc_hba_eq_hdl_array_init - Initialize hba_eq_hdl structure
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * The routine initializes the hba_eq_hdl array structure
+ */
+static void
+lpfc_hba_eq_hdl_array_init(struct lpfc_hba *phba)
+{
+	struct lpfc_hba_eq_hdl *eqhdl;
+	int i;
+
+	for (i = 0; i < phba->cfg_irq_chann; i++) {
+		eqhdl = lpfc_get_eq_hdl(i);
+		eqhdl->irq = LPFC_VECTOR_MAP_EMPTY;
+		eqhdl->phba = phba;
+	}
+}
+
 /**
  * lpfc_cpu_affinity_check - Check vector CPU affinity mappings
  * @phba: pointer to lpfc hba data structure.
@@ -10742,22 +10842,10 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 	int max_core_id, min_core_id;
 	struct lpfc_vector_map_info *cpup;
 	struct lpfc_vector_map_info *new_cpup;
-	const struct cpumask *maskp;
 #ifdef CONFIG_X86
 	struct cpuinfo_x86 *cpuinfo;
 #endif
 
-	/* Init cpu_map array */
-	for_each_possible_cpu(cpu) {
-		cpup = &phba->sli4_hba.cpu_map[cpu];
-		cpup->phys_id = LPFC_VECTOR_MAP_EMPTY;
-		cpup->core_id = LPFC_VECTOR_MAP_EMPTY;
-		cpup->hdwq = LPFC_VECTOR_MAP_EMPTY;
-		cpup->eq = LPFC_VECTOR_MAP_EMPTY;
-		cpup->irq = LPFC_VECTOR_MAP_EMPTY;
-		cpup->flag = 0;
-	}
-
 	max_phys_id = 0;
 	min_phys_id = LPFC_VECTOR_MAP_EMPTY;
 	max_core_id = 0;
@@ -10793,65 +10881,6 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			min_core_id = cpup->core_id;
 	}
 
-	for_each_possible_cpu(i) {
-		struct lpfc_eq_intr_info *eqi =
-			per_cpu_ptr(phba->sli4_hba.eq_info, i);
-
-		INIT_LIST_HEAD(&eqi->list);
-		eqi->icnt = 0;
-	}
-
-	/* This loop sets up all CPUs that are affinitized with a
-	 * irq vector assigned to the driver. All affinitized CPUs
-	 * will get a link to that vectors IRQ and EQ.
-	 *
-	 * NULL affinity mask handling:
-	 * If irq count is greater than one, log an error message.
-	 * If the null mask is received for the first irq, find the
-	 * first present cpu, and assign the eq index to ensure at
-	 * least one EQ is assigned.
-	 */
-	for (idx = 0; idx <  phba->cfg_irq_chann; idx++) {
-		/* Get a CPU mask for all CPUs affinitized to this vector */
-		maskp = pci_irq_get_affinity(phba->pcidev, idx);
-		if (!maskp) {
-			if (phba->cfg_irq_chann > 1)
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-						"3329 No affinity mask found "
-						"for vector %d (%d)\n",
-						idx, phba->cfg_irq_chann);
-			if (!idx) {
-				cpu = cpumask_first(cpu_present_mask);
-				cpup = &phba->sli4_hba.cpu_map[cpu];
-				cpup->eq = idx;
-				cpup->irq = pci_irq_vector(phba->pcidev, idx);
-				cpup->flag |= LPFC_CPU_FIRST_IRQ;
-			}
-			break;
-		}
-
-		i = 0;
-		/* Loop through all CPUs associated with vector idx */
-		for_each_cpu_and(cpu, maskp, cpu_present_mask) {
-			/* Set the EQ index and IRQ for that vector */
-			cpup = &phba->sli4_hba.cpu_map[cpu];
-			cpup->eq = idx;
-			cpup->irq = pci_irq_vector(phba->pcidev, idx);
-
-			/* If this is the first CPU thats assigned to this
-			 * vector, set LPFC_CPU_FIRST_IRQ.
-			 */
-			if (!i)
-				cpup->flag |= LPFC_CPU_FIRST_IRQ;
-			i++;
-
-			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-					"3336 Set Affinity: CPU %d "
-					"irq %d eq %d flag x%x\n",
-					cpu, cpup->irq, cpup->eq, cpup->flag);
-		}
-	}
-
 	/* After looking at each irq vector assigned to this pcidev, its
 	 * possible to see that not ALL CPUs have been accounted for.
 	 * Next we will set any unassigned (unaffinitized) cpu map
@@ -10877,7 +10906,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
 				new_cpup = &phba->sli4_hba.cpu_map[new_cpu];
 				if (!(new_cpup->flag & LPFC_CPU_MAP_UNASSIGN) &&
-				    (new_cpup->irq != LPFC_VECTOR_MAP_EMPTY) &&
+				    (new_cpup->eq != LPFC_VECTOR_MAP_EMPTY) &&
 				    (new_cpup->phys_id == cpup->phys_id))
 					goto found_same;
 				new_cpu = cpumask_next(
@@ -10890,7 +10919,6 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 found_same:
 			/* We found a matching phys_id, so copy the IRQ info */
 			cpup->eq = new_cpup->eq;
-			cpup->irq = new_cpup->irq;
 
 			/* Bump start_cpu to the next slot to minmize the
 			 * chance of having multiple unassigned CPU entries
@@ -10902,9 +10930,10 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 
 			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 					"3337 Set Affinity: CPU %d "
-					"irq %d from id %d same "
+					"eq %d from peer cpu %d same "
 					"phys_id (%d)\n",
-					cpu, cpup->irq, new_cpu, cpup->phys_id);
+					cpu, cpup->eq, new_cpu,
+					cpup->phys_id);
 		}
 	}
 
@@ -10928,7 +10957,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
 				new_cpup = &phba->sli4_hba.cpu_map[new_cpu];
 				if (!(new_cpup->flag & LPFC_CPU_MAP_UNASSIGN) &&
-				    (new_cpup->irq != LPFC_VECTOR_MAP_EMPTY))
+				    (new_cpup->eq != LPFC_VECTOR_MAP_EMPTY))
 					goto found_any;
 				new_cpu = cpumask_next(
 					new_cpu, cpu_present_mask);
@@ -10938,13 +10967,12 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			/* We should never leave an entry unassigned */
 			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 					"3339 Set Affinity: CPU %d "
-					"irq %d UNASSIGNED\n",
-					cpup->hdwq, cpup->irq);
+					"eq %d UNASSIGNED\n",
+					cpup->hdwq, cpup->eq);
 			continue;
 found_any:
 			/* We found an available entry, copy the IRQ info */
 			cpup->eq = new_cpup->eq;
-			cpup->irq = new_cpup->irq;
 
 			/* Bump start_cpu to the next slot to minmize the
 			 * chance of having multiple unassigned CPU entries
@@ -10956,8 +10984,8 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 
 			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 					"3338 Set Affinity: CPU %d "
-					"irq %d from id %d (%d/%d)\n",
-					cpu, cpup->irq, new_cpu,
+					"eq %d from peer cpu %d (%d/%d)\n",
+					cpu, cpup->eq, new_cpu,
 					new_cpup->phys_id, new_cpup->core_id);
 		}
 	}
@@ -10978,9 +11006,9 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 		idx++;
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 				"3333 Set Affinity: CPU %d (phys %d core %d): "
-				"hdwq %d eq %d irq %d flg x%x\n",
+				"hdwq %d eq %d flg x%x\n",
 				cpu, cpup->phys_id, cpup->core_id,
-				cpup->hdwq, cpup->eq, cpup->irq, cpup->flag);
+				cpup->hdwq, cpup->eq, cpup->flag);
 	}
 	/* Finally we need to associate a hdwq with each cpu_map entry
 	 * This will be 1 to 1 - hdwq to cpu, unless there are less
@@ -11056,9 +11084,9 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
  logit:
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 				"3335 Set Affinity: CPU %d (phys %d core %d): "
-				"hdwq %d eq %d irq %d flg x%x\n",
+				"hdwq %d eq %d flg x%x\n",
 				cpu, cpup->phys_id, cpup->core_id,
-				cpup->hdwq, cpup->eq, cpup->irq, cpup->flag);
+				cpup->hdwq, cpup->eq, cpup->flag);
 	}
 
 	/* The cpu_map array will be used later during initialization
@@ -11078,10 +11106,8 @@ static void
 lpfc_cpuhp_get_eq(struct lpfc_hba *phba, unsigned int cpu,
 		  struct list_head *eqlist)
 {
-	struct lpfc_vector_map_info *map;
 	const struct cpumask *maskp;
 	struct lpfc_queue *eq;
-	unsigned int i;
 	cpumask_t tmp;
 	u16 idx;
 
@@ -11111,15 +11137,8 @@ lpfc_cpuhp_get_eq(struct lpfc_hba *phba, unsigned int cpu,
 		 * the software can share an eq, but eventually
 		 * only eq will be mapped to this vector
 		 */
-		for_each_possible_cpu(i) {
-			map = &phba->sli4_hba.cpu_map[i];
-			if (!(map->irq == pci_irq_vector(phba->pcidev, idx)))
-				continue;
-			eq = phba->sli4_hba.hdwq[map->hdwq].hba_eq;
-			list_add(&eq->_poll_list, eqlist);
-			/* 1 is good enough. others will be a copy of this */
-			break;
-		}
+		eq = phba->sli4_hba.hba_eq_hdl[idx].eq;
+		list_add(&eq->_poll_list, eqlist);
 	}
 }
 
@@ -11181,6 +11200,99 @@ static int __lpfc_cpuhp_checks(struct lpfc_hba *phba, int *retval)
 	return false;
 }
 
+/**
+ * lpfc_irq_set_aff - set IRQ affinity
+ * @eqhdl: EQ handle
+ * @cpu: cpu to set affinity
+ *
+ **/
+static inline void
+lpfc_irq_set_aff(struct lpfc_hba_eq_hdl *eqhdl, unsigned int cpu)
+{
+	cpumask_clear(&eqhdl->aff_mask);
+	cpumask_set_cpu(cpu, &eqhdl->aff_mask);
+	irq_set_status_flags(eqhdl->irq, IRQ_NO_BALANCING);
+	irq_set_affinity_hint(eqhdl->irq, &eqhdl->aff_mask);
+}
+
+/**
+ * lpfc_irq_clear_aff - clear IRQ affinity
+ * @eqhdl: EQ handle
+ *
+ **/
+static inline void
+lpfc_irq_clear_aff(struct lpfc_hba_eq_hdl *eqhdl)
+{
+	cpumask_clear(&eqhdl->aff_mask);
+	irq_clear_status_flags(eqhdl->irq, IRQ_NO_BALANCING);
+	irq_set_affinity_hint(eqhdl->irq, &eqhdl->aff_mask);
+}
+
+/**
+ * lpfc_irq_rebalance - rebalances IRQ affinity according to cpuhp event
+ * @phba: pointer to HBA context object.
+ * @cpu: cpu going offline/online
+ * @offline: true, cpu is going offline. false, cpu is coming online.
+ *
+ * If cpu is going offline, we'll try our best effort to find the next
+ * online cpu on the phba's NUMA node and migrate all offlining IRQ affinities.
+ *
+ * If cpu is coming online, reaffinitize the IRQ back to the onlineng cpu.
+ *
+ * Note: Call only if cfg_irq_numa is enabled, otherwise rely on
+ *	 PCI_IRQ_AFFINITY to auto-manage IRQ affinity.
+ *
+ **/
+static void
+lpfc_irq_rebalance(struct lpfc_hba *phba, unsigned int cpu, bool offline)
+{
+	struct lpfc_vector_map_info *cpup;
+	struct cpumask *aff_mask;
+	unsigned int cpu_select, cpu_next, idx;
+	const struct cpumask *numa_mask;
+
+	if (!phba->cfg_irq_numa)
+		return;
+
+	numa_mask = &phba->sli4_hba.numa_mask;
+
+	if (!cpumask_test_cpu(cpu, numa_mask))
+		return;
+
+	cpup = &phba->sli4_hba.cpu_map[cpu];
+
+	if (!(cpup->flag & LPFC_CPU_FIRST_IRQ))
+		return;
+
+	if (offline) {
+		/* Find next online CPU on NUMA node */
+		cpu_next = cpumask_next_wrap(cpu, numa_mask, cpu, true);
+		cpu_select = lpfc_next_online_numa_cpu(numa_mask, cpu_next);
+
+		/* Found a valid CPU */
+		if ((cpu_select < nr_cpu_ids) && (cpu_select != cpu)) {
+			/* Go through each eqhdl and ensure offlining
+			 * cpu aff_mask is migrated
+			 */
+			for (idx = 0; idx < phba->cfg_irq_chann; idx++) {
+				aff_mask = lpfc_get_aff_mask(idx);
+
+				/* Migrate affinity */
+				if (cpumask_test_cpu(cpu, aff_mask))
+					lpfc_irq_set_aff(lpfc_get_eq_hdl(idx),
+							 cpu_select);
+			}
+		} else {
+			/* Rely on irqbalance if no online CPUs left on NUMA */
+			for (idx = 0; idx < phba->cfg_irq_chann; idx++)
+				lpfc_irq_clear_aff(lpfc_get_eq_hdl(idx));
+		}
+	} else {
+		/* Migrate affinity back to this CPU */
+		lpfc_irq_set_aff(lpfc_get_eq_hdl(cpup->eq), cpu);
+	}
+}
+
 static int lpfc_cpu_offline(unsigned int cpu, struct hlist_node *node)
 {
 	struct lpfc_hba *phba = hlist_entry_safe(node, struct lpfc_hba, cpuhp);
@@ -11196,6 +11308,8 @@ static int lpfc_cpu_offline(unsigned int cpu, struct hlist_node *node)
 	if (__lpfc_cpuhp_checks(phba, &retval))
 		return retval;
 
+	lpfc_irq_rebalance(phba, cpu, true);
+
 	lpfc_cpuhp_get_eq(phba, cpu, &eqlist);
 
 	/* start polling on these eq's */
@@ -11222,6 +11336,8 @@ static int lpfc_cpu_online(unsigned int cpu, struct hlist_node *node)
 	if (__lpfc_cpuhp_checks(phba, &retval))
 		return retval;
 
+	lpfc_irq_rebalance(phba, cpu, false);
+
 	list_for_each_entry_safe(eq, next, &phba->poll_list, _poll_list) {
 		n = lpfc_find_cpu_handle(phba, eq->hdwq, LPFC_FIND_BY_HDWQ);
 		if (n == cpu)
@@ -11236,7 +11352,24 @@ static int lpfc_cpu_online(unsigned int cpu, struct hlist_node *node)
  * @phba: pointer to lpfc hba data structure.
  *
  * This routine is invoked to enable the MSI-X interrupt vectors to device
- * with SLI-4 interface spec.
+ * with SLI-4 interface spec.  It also allocates MSI-X vectors and maps them
+ * to cpus on the system.
+ *
+ * When cfg_irq_numa is enabled, the adapter will only allocate vectors for
+ * the number of cpus on the same numa node as this adapter.  The vectors are
+ * allocated without requesting OS affinity mapping.  A vector will be
+ * allocated and assigned to each online and offline cpu.  If the cpu is
+ * online, then affinity will be set to that cpu.  If the cpu is offline, then
+ * affinity will be set to the nearest peer cpu within the numa node that is
+ * online.  If there are no online cpus within the numa node, affinity is not
+ * assigned and the OS may do as it pleases. Note: cpu vector affinity mapping
+ * is consistent with the way cpu online/offline is handled when cfg_irq_numa is
+ * configured.
+ *
+ * If numa mode is not enabled and there is more than 1 vector allocated, then
+ * the driver relies on the managed irq interface where the OS assigns vector to
+ * cpu affinity.  The driver will then use that affinity mapping to setup its
+ * cpu mapping table.
  *
  * Return codes
  * 0 - successful
@@ -11247,13 +11380,31 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 {
 	int vectors, rc, index;
 	char *name;
+	const struct cpumask *numa_mask = NULL;
+	unsigned int cpu = 0, cpu_cnt = 0, cpu_select = nr_cpu_ids;
+	struct lpfc_hba_eq_hdl *eqhdl;
+	const struct cpumask *maskp;
+	bool first;
+	unsigned int flags = PCI_IRQ_MSIX;
 
 	/* Set up MSI-X multi-message vectors */
 	vectors = phba->cfg_irq_chann;
 
-	rc = pci_alloc_irq_vectors(phba->pcidev,
-				1,
-				vectors, PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+	if (phba->cfg_irq_numa) {
+		numa_mask = &phba->sli4_hba.numa_mask;
+		cpu_cnt = cpumask_weight(numa_mask);
+		vectors = min(phba->cfg_irq_chann, cpu_cnt);
+
+		/* cpu: iterates over numa_mask including offline or online
+		 * cpu_select: iterates over online numa_mask to set affinity
+		 */
+		cpu = cpumask_first(numa_mask);
+		cpu_select = lpfc_next_online_numa_cpu(numa_mask, cpu);
+	} else {
+		flags |= PCI_IRQ_AFFINITY;
+	}
+
+	rc = pci_alloc_irq_vectors(phba->pcidev, 1, vectors, flags);
 	if (rc < 0) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0484 PCI enable MSI-X failed (%d)\n", rc);
@@ -11263,23 +11414,61 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 
 	/* Assign MSI-X vectors to interrupt handlers */
 	for (index = 0; index < vectors; index++) {
-		name = phba->sli4_hba.hba_eq_hdl[index].handler_name;
+		eqhdl = lpfc_get_eq_hdl(index);
+		name = eqhdl->handler_name;
 		memset(name, 0, LPFC_SLI4_HANDLER_NAME_SZ);
 		snprintf(name, LPFC_SLI4_HANDLER_NAME_SZ,
 			 LPFC_DRIVER_HANDLER_NAME"%d", index);
 
-		phba->sli4_hba.hba_eq_hdl[index].idx = index;
-		phba->sli4_hba.hba_eq_hdl[index].phba = phba;
+		eqhdl->idx = index;
 		rc = request_irq(pci_irq_vector(phba->pcidev, index),
 			 &lpfc_sli4_hba_intr_handler, 0,
-			 name,
-			 &phba->sli4_hba.hba_eq_hdl[index]);
+			 name, eqhdl);
 		if (rc) {
 			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
 					"0486 MSI-X fast-path (%d) "
 					"request_irq failed (%d)\n", index, rc);
 			goto cfg_fail_out;
 		}
+
+		eqhdl->irq = pci_irq_vector(phba->pcidev, index);
+
+		if (phba->cfg_irq_numa) {
+			/* If found a neighboring online cpu, set affinity */
+			if (cpu_select < nr_cpu_ids)
+				lpfc_irq_set_aff(eqhdl, cpu_select);
+
+			/* Assign EQ to cpu_map */
+			lpfc_assign_eq_map_info(phba, index,
+						LPFC_CPU_FIRST_IRQ,
+						cpu);
+
+			/* Iterate to next offline or online cpu in numa_mask */
+			cpu = cpumask_next(cpu, numa_mask);
+
+			/* Find next online cpu in numa_mask to set affinity */
+			cpu_select = lpfc_next_online_numa_cpu(numa_mask, cpu);
+		} else if (vectors == 1) {
+			cpu = cpumask_first(cpu_present_mask);
+			lpfc_assign_eq_map_info(phba, index, LPFC_CPU_FIRST_IRQ,
+						cpu);
+		} else {
+			maskp = pci_irq_get_affinity(phba->pcidev, index);
+
+			first = true;
+			/* Loop through all CPUs associated with vector index */
+			for_each_cpu_and(cpu, maskp, cpu_present_mask) {
+				/* If this is the first CPU thats assigned to
+				 * this vector, set LPFC_CPU_FIRST_IRQ.
+				 */
+				lpfc_assign_eq_map_info(phba, index,
+							first ?
+							LPFC_CPU_FIRST_IRQ : 0,
+							cpu);
+				if (first)
+					first = false;
+			}
+		}
 	}
 
 	if (vectors != phba->cfg_irq_chann) {
@@ -11295,9 +11484,12 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 
 cfg_fail_out:
 	/* free the irq already requested */
-	for (--index; index >= 0; index--)
-		free_irq(pci_irq_vector(phba->pcidev, index),
-				&phba->sli4_hba.hba_eq_hdl[index]);
+	for (--index; index >= 0; index--) {
+		eqhdl = lpfc_get_eq_hdl(index);
+		lpfc_irq_clear_aff(eqhdl);
+		irq_set_affinity_hint(eqhdl->irq, NULL);
+		free_irq(eqhdl->irq, eqhdl);
+	}
 
 	/* Unconfigure MSI-X capability structure */
 	pci_free_irq_vectors(phba->pcidev);
@@ -11324,6 +11516,8 @@ static int
 lpfc_sli4_enable_msi(struct lpfc_hba *phba)
 {
 	int rc, index;
+	unsigned int cpu;
+	struct lpfc_hba_eq_hdl *eqhdl;
 
 	rc = pci_alloc_irq_vectors(phba->pcidev, 1, 1,
 				   PCI_IRQ_MSI | PCI_IRQ_AFFINITY);
@@ -11345,9 +11539,15 @@ lpfc_sli4_enable_msi(struct lpfc_hba *phba)
 		return rc;
 	}
 
+	eqhdl = lpfc_get_eq_hdl(0);
+	eqhdl->irq = pci_irq_vector(phba->pcidev, 0);
+
+	cpu = cpumask_first(cpu_present_mask);
+	lpfc_assign_eq_map_info(phba, 0, LPFC_CPU_FIRST_IRQ, cpu);
+
 	for (index = 0; index < phba->cfg_irq_chann; index++) {
-		phba->sli4_hba.hba_eq_hdl[index].idx = index;
-		phba->sli4_hba.hba_eq_hdl[index].phba = phba;
+		eqhdl = lpfc_get_eq_hdl(index);
+		eqhdl->idx = index;
 	}
 
 	return 0;
@@ -11380,7 +11580,9 @@ lpfc_sli4_enable_intr(struct lpfc_hba *phba, uint32_t cfg_mode)
 		retval = 0;
 		if (!retval) {
 			/* Now, try to enable MSI-X interrupt mode */
+			get_online_cpus();
 			retval = lpfc_sli4_enable_msix(phba);
+			put_online_cpus();
 			if (!retval) {
 				/* Indicate initialization to MSI-X mode */
 				phba->intr_type = MSIX;
@@ -11405,15 +11607,21 @@ lpfc_sli4_enable_intr(struct lpfc_hba *phba, uint32_t cfg_mode)
 				     IRQF_SHARED, LPFC_DRIVER_NAME, phba);
 		if (!retval) {
 			struct lpfc_hba_eq_hdl *eqhdl;
+			unsigned int cpu;
 
 			/* Indicate initialization to INTx mode */
 			phba->intr_type = INTx;
 			intr_mode = 0;
 
+			eqhdl = lpfc_get_eq_hdl(0);
+			eqhdl->irq = pci_irq_vector(phba->pcidev, 0);
+
+			cpu = cpumask_first(cpu_present_mask);
+			lpfc_assign_eq_map_info(phba, 0, LPFC_CPU_FIRST_IRQ,
+						cpu);
 			for (idx = 0; idx < phba->cfg_irq_chann; idx++) {
-				eqhdl = &phba->sli4_hba.hba_eq_hdl[idx];
+				eqhdl = lpfc_get_eq_hdl(idx);
 				eqhdl->idx = idx;
-				eqhdl->phba = phba;
 			}
 		}
 	}
@@ -11435,14 +11643,14 @@ lpfc_sli4_disable_intr(struct lpfc_hba *phba)
 	/* Disable the currently initialized interrupt mode */
 	if (phba->intr_type == MSIX) {
 		int index;
+		struct lpfc_hba_eq_hdl *eqhdl;
 
 		/* Free up MSI-X multi-message vectors */
 		for (index = 0; index < phba->cfg_irq_chann; index++) {
-			irq_set_affinity_hint(
-				pci_irq_vector(phba->pcidev, index),
-				NULL);
-			free_irq(pci_irq_vector(phba->pcidev, index),
-					&phba->sli4_hba.hba_eq_hdl[index]);
+			eqhdl = lpfc_get_eq_hdl(index);
+			lpfc_irq_clear_aff(eqhdl);
+			irq_set_affinity_hint(eqhdl->irq, NULL);
+			free_irq(eqhdl->irq, eqhdl);
 		}
 	} else {
 		free_irq(phba->pcidev->irq, phba);
@@ -12848,6 +13056,12 @@ lpfc_pci_probe_one_s4(struct pci_dev *pdev, const struct pci_device_id *pid)
 	phba->pport = NULL;
 	lpfc_stop_port(phba);
 
+	/* Init cpu_map array */
+	lpfc_cpu_map_array_init(phba);
+
+	/* Init hba_eq_hdl array */
+	lpfc_hba_eq_hdl_array_init(phba);
+
 	/* Configure and enable interrupt */
 	intr_mode = lpfc_sli4_enable_intr(phba, cfg_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index ef32159248d7..d963ca871383 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -41,8 +41,13 @@
 
 /* Multi-queue arrangement for FCP EQ/CQ/WQ tuples */
 #define LPFC_HBA_HDWQ_MIN	0
-#define LPFC_HBA_HDWQ_MAX	128
-#define LPFC_HBA_HDWQ_DEF	0
+#define LPFC_HBA_HDWQ_MAX	256
+#define LPFC_HBA_HDWQ_DEF	LPFC_HBA_HDWQ_MIN
+
+/* irq_chann range, values */
+#define LPFC_IRQ_CHANN_MIN	0
+#define LPFC_IRQ_CHANN_MAX	256
+#define LPFC_IRQ_CHANN_DEF	LPFC_IRQ_CHANN_MIN
 
 /* FCP MQ queue count limiting */
 #define LPFC_FCP_MQ_THRESHOLD_MIN	0
@@ -467,11 +472,17 @@ struct lpfc_hba;
 #define LPFC_SLI4_HANDLER_NAME_SZ	16
 struct lpfc_hba_eq_hdl {
 	uint32_t idx;
+	uint16_t irq;
 	char handler_name[LPFC_SLI4_HANDLER_NAME_SZ];
 	struct lpfc_hba *phba;
 	struct lpfc_queue *eq;
+	struct cpumask aff_mask;
 };
 
+#define lpfc_get_eq_hdl(eqidx) (&phba->sli4_hba.hba_eq_hdl[eqidx])
+#define lpfc_get_aff_mask(eqidx) (&phba->sli4_hba.hba_eq_hdl[eqidx].aff_mask)
+#define lpfc_get_irq(eqidx) (phba->sli4_hba.hba_eq_hdl[eqidx].irq)
+
 /*BB Credit recovery value*/
 struct lpfc_bbscn_params {
 	uint32_t word0;
@@ -561,11 +572,10 @@ struct lpfc_sli4_lnk_info {
 #define LPFC_SLI4_HANDLER_CNT		(LPFC_HBA_IO_CHAN_MAX+ \
 					 LPFC_FOF_IO_CHAN_NUM)
 
-/* Used for IRQ vector to CPU mapping */
+/* Used for tracking CPU mapping attributes */
 struct lpfc_vector_map_info {
 	uint16_t	phys_id;
 	uint16_t	core_id;
-	uint16_t	irq;
 	uint16_t	eq;
 	uint16_t	hdwq;
 	uint16_t	flag;
@@ -908,6 +918,7 @@ struct lpfc_sli4_hba {
 	struct lpfc_vector_map_info *cpu_map;
 	uint16_t num_possible_cpu;
 	uint16_t num_present_cpu;
+	struct cpumask numa_mask;
 	uint16_t curr_disp_cpu;
 	struct lpfc_eq_intr_info __percpu *eq_info;
 	uint32_t conf_trunk;
-- 
2.13.7

