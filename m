Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2F25B4F
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfEVAtf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46508 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfEVAte (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so159610pls.13
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pNz02KWu9MY5I80lfuOTL/E+wprRSQEPXW1e5pknxwY=;
        b=k9LVFo+0bcJEm7a/LYP0IKC8IU8PX/XZ+3cNbRTJ446haQkwUTD++BclBXlVCX/XRz
         yblpoZuXyUM7tJJGK4fzfa3qRhWAc5Rsb81TATVFSoE5BoLxOegM4dgyib60ZcHzxDmH
         r8S8+SqLQewnkYD0SCDJxoCd7jrwTlGNGoLN15XIid7PawhwKaHgwOcylvKIiCRVNOar
         onG3e0wj9St2AuzdXV2nJjicFcLv40Fc4C96Hod0WbyALYmS+BsPVvEMtpSVcK/CcIao
         cprYgm6DrHxD0j+kgG8SUJM1bzV7HjnJ7AaP7PIEysTX7C37IRJBhal/dFgc7WCdADRf
         R4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pNz02KWu9MY5I80lfuOTL/E+wprRSQEPXW1e5pknxwY=;
        b=i49rexujmjp1hqGBGN6rSEotB55QBQ3EtatEnLseBgio6vDTgDMl2lFimThziubmBz
         fFcswfaCtBbDyAkZdfi70vewlfyavSivon/qfGRP/ufRKELIYfMfwAnIhYGzPRX8oxjL
         eOfp0kvg3B4pjsZCAce3O+MGA1UHGvAbHgGmxefNzcfOTb/9g1RQfujAQgwicLf9Ow7o
         jprjrfykhy6nd23BFzR8IyX4xhS3lug8rhxBQ4kvbbCEiQ0PyTZXLA8lQg1N1Es7D3WS
         MAsWBbuMRyRz51ev/B4INyqFxtgG1VEPRc9kVFDj2piF/bsT0ToaeUCG0estY63CPtSF
         Ib1Q==
X-Gm-Message-State: APjAAAX4rY+YIqgaNGViHfR+SyHpvBf+0opuXRoYQydOXOHZwIuBQfHR
        wZorMlS4R1AbAhTlqi3ozLKEiNTq
X-Google-Smtp-Source: APXvYqyHzbOMcevs0c2JmzNB3vHwDpD6DmONVKwFGbg/CdT+koXCHeBuZlXg70BGs1roHc2QkuFnsw==
X-Received: by 2002:a17:902:184:: with SMTP id b4mr60417396plb.2.1558486173853;
        Tue, 21 May 2019 17:49:33 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:33 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 15/21] lpfc: Fix oops when driver is loaded with 1 interrupt vector
Date:   Tue, 21 May 2019 17:49:05 -0700
Message-Id: <20190522004911.573-16-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver was coded expecting enough hardware queues and interrupt
vectors such that at least there was one per socket. In the case where
there were fewer than sockets, cpus were left unassigned thus null
pointers.

Rework the affinity mappings. Map settings for the cpu's that are in
the irq cpu mask. For each cpu not in the mask, map to another cpu
that does have a mask. Choice of the "other" cpu will attempt to
map to the same cpu but differing hyperthread, or cpu within in same
core, or cpu within same socket, or finally cpu in the base socket.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_attr.c |  27 +++++---
 drivers/scsi/lpfc/lpfc_init.c | 143 +++++++++++++++++++++++++++++++++++++++---
 drivers/scsi/lpfc/lpfc_sli4.h |   4 +-
 3 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index aabd42c4c6f8..58f26e5f3a59 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5236,35 +5236,44 @@ lpfc_fcp_cpu_map_show(struct device *dev, struct device_attribute *attr,
 				len += scnprintf(
 					buf + len, PAGE_SIZE - len,
 					"CPU %02d hdwq None "
-					"physid %d coreid %d ht %d\n",
+					"physid %d coreid %d ht %d ua %d\n",
 					phba->sli4_hba.curr_disp_cpu,
-					cpup->phys_id,
-					cpup->core_id, cpup->hyper);
+					cpup->phys_id, cpup->core_id,
+					(cpup->flag & LPFC_CPU_MAP_HYPER),
+					(cpup->flag & LPFC_CPU_MAP_UNASSIGN));
 			else
 				len += scnprintf(
 					buf + len, PAGE_SIZE - len,
 					"CPU %02d EQ %04d hdwq %04d "
-					"physid %d coreid %d ht %d\n",
+					"physid %d coreid %d ht %d ua %d\n",
 					phba->sli4_hba.curr_disp_cpu,
 					cpup->eq, cpup->hdwq, cpup->phys_id,
-					cpup->core_id, cpup->hyper);
+					cpup->core_id,
+					(cpup->flag & LPFC_CPU_MAP_HYPER),
+					(cpup->flag & LPFC_CPU_MAP_UNASSIGN));
 		} else {
 			if (cpup->hdwq == LPFC_VECTOR_MAP_EMPTY)
 				len += scnprintf(
 					buf + len, PAGE_SIZE - len,
 					"CPU %02d hdwq None "
-					"physid %d coreid %d ht %d IRQ %d\n",
+					"physid %d coreid %d ht %d ua %d IRQ %d\n",
 					phba->sli4_hba.curr_disp_cpu,
 					cpup->phys_id,
-					cpup->core_id, cpup->hyper, cpup->irq);
+					cpup->core_id,
+					(cpup->flag & LPFC_CPU_MAP_HYPER),
+					(cpup->flag & LPFC_CPU_MAP_UNASSIGN),
+					cpup->irq);
 			else
 				len += scnprintf(
 					buf + len, PAGE_SIZE - len,
 					"CPU %02d EQ %04d hdwq %04d "
-					"physid %d coreid %d ht %d IRQ %d\n",
+					"physid %d coreid %d ht %d ua %d IRQ %d\n",
 					phba->sli4_hba.curr_disp_cpu,
 					cpup->eq, cpup->hdwq, cpup->phys_id,
-					cpup->core_id, cpup->hyper, cpup->irq);
+					cpup->core_id,
+					(cpup->flag & LPFC_CPU_MAP_HYPER),
+					(cpup->flag & LPFC_CPU_MAP_UNASSIGN),
+					cpup->irq);
 		}
 
 		phba->sli4_hba.curr_disp_cpu++;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 73b77aaf7135..021b01561597 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -10653,24 +10653,31 @@ lpfc_find_hyper(struct lpfc_hba *phba, int cpu,
 static void
 lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 {
-	int i, cpu, idx;
+	int i, cpu, idx, new_cpu, start_cpu, first_cpu;
 	int max_phys_id, min_phys_id;
 	int max_core_id, min_core_id;
 	struct lpfc_vector_map_info *cpup;
+	struct lpfc_vector_map_info *new_cpup;
 	const struct cpumask *maskp;
 #ifdef CONFIG_X86
 	struct cpuinfo_x86 *cpuinfo;
 #endif
 
 	/* Init cpu_map array */
-	memset(phba->sli4_hba.cpu_map, 0xff,
-	       (sizeof(struct lpfc_vector_map_info) *
-	       phba->sli4_hba.num_possible_cpu));
+	for_each_possible_cpu(cpu) {
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+		cpup->phys_id = LPFC_VECTOR_MAP_EMPTY;
+		cpup->core_id = LPFC_VECTOR_MAP_EMPTY;
+		cpup->hdwq = LPFC_VECTOR_MAP_EMPTY;
+		cpup->eq = LPFC_VECTOR_MAP_EMPTY;
+		cpup->irq = LPFC_VECTOR_MAP_EMPTY;
+		cpup->flag = 0;
+	}
 
 	max_phys_id = 0;
-	min_phys_id = 0xffff;
+	min_phys_id = LPFC_VECTOR_MAP_EMPTY;
 	max_core_id = 0;
-	min_core_id = 0xffff;
+	min_core_id = LPFC_VECTOR_MAP_EMPTY;
 
 	/* Update CPU map with physical id and core id of each CPU */
 	for_each_present_cpu(cpu) {
@@ -10679,13 +10686,12 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 		cpuinfo = &cpu_data(cpu);
 		cpup->phys_id = cpuinfo->phys_proc_id;
 		cpup->core_id = cpuinfo->cpu_core_id;
-		cpup->hyper = lpfc_find_hyper(phba, cpu,
-					      cpup->phys_id, cpup->core_id);
+		if (lpfc_find_hyper(phba, cpu, cpup->phys_id, cpup->core_id))
+			cpup->flag |= LPFC_CPU_MAP_HYPER;
 #else
 		/* No distinction between CPUs for other platforms */
 		cpup->phys_id = 0;
 		cpup->core_id = cpu;
-		cpup->hyper = 0;
 #endif
 
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
@@ -10711,6 +10717,12 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 		eqi->icnt = 0;
 	}
 
+	/* This loop sets up all CPUs that are affinitized with a
+	 * irq vector assigned to the driver. All affinitized CPUs
+	 * will get a link to that vectors IRQ and EQ. For now we
+	 * are assuming all CPUs using the same EQ will all share
+	 * the same hardware queue.
+	 */
 	for (idx = 0; idx <  phba->cfg_irq_chann; idx++) {
 		maskp = pci_irq_get_affinity(phba->pcidev, idx);
 		if (!maskp)
@@ -10728,6 +10740,119 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 					cpu, cpup->hdwq, cpup->irq);
 		}
 	}
+
+	/* After looking at each irq vector assigned to this pcidev, its
+	 * possible to see that not ALL CPUs have been accounted for.
+	 * Next we will set any unassigned cpu map entries to a IRQ
+	 * on the same phys_id
+	 */
+	first_cpu = cpumask_first(cpu_present_mask);
+	start_cpu = first_cpu;
+
+	for_each_present_cpu(cpu) {
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+
+		/* Is this CPU entry unassigned */
+		if (cpup->eq == LPFC_VECTOR_MAP_EMPTY) {
+			/* Mark CPU as IRQ not assigned by the kernel */
+			cpup->flag |= LPFC_CPU_MAP_UNASSIGN;
+
+			/* If so, find a new_cpup thats on the the same
+			 * phys_id as cpup. start_cpu will start where we
+			 * left off so all unassigned entries don't get assgined
+			 * the IRQ of the first entry.
+			 */
+			new_cpu = start_cpu;
+			for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
+				new_cpup = &phba->sli4_hba.cpu_map[new_cpu];
+				if (!(new_cpup->flag & LPFC_CPU_MAP_UNASSIGN) &&
+				    (new_cpup->irq != LPFC_VECTOR_MAP_EMPTY) &&
+				    (new_cpup->phys_id == cpup->phys_id))
+					goto found_same;
+				new_cpu = cpumask_next(
+					new_cpu, cpu_present_mask);
+				if (new_cpu == nr_cpumask_bits)
+					new_cpu = first_cpu;
+			}
+			/* At this point, we leave the CPU as unassigned */
+			continue;
+found_same:
+			/* We found a matching phys_id, so copy the IRQ info */
+			cpup->eq = new_cpup->eq;
+			cpup->hdwq = new_cpup->hdwq;
+			cpup->irq = new_cpup->irq;
+
+			/* Bump start_cpu to the next slot to minmize the
+			 * chance of having multiple unassigned CPU entries
+			 * selecting the same IRQ.
+			 */
+			start_cpu = cpumask_next(new_cpu, cpu_present_mask);
+			if (start_cpu == nr_cpumask_bits)
+				start_cpu = first_cpu;
+
+			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+					"3337 Set Affinity: CPU %d "
+					"hdwq %d irq %d from id %d same "
+					"phys_id (%d)\n",
+					cpu, cpup->hdwq, cpup->irq,
+					new_cpu, cpup->phys_id);
+		}
+	}
+
+	/* Set any unassigned cpu map entries to a IRQ on any phys_id */
+	start_cpu = first_cpu;
+
+	for_each_present_cpu(cpu) {
+		cpup = &phba->sli4_hba.cpu_map[cpu];
+
+		/* Is this entry unassigned */
+		if (cpup->eq == LPFC_VECTOR_MAP_EMPTY) {
+			/* Mark it as IRQ not assigned by the kernel */
+			cpup->flag |= LPFC_CPU_MAP_UNASSIGN;
+
+			/* If so, find a new_cpup thats on any phys_id
+			 * as the cpup. start_cpu will start where we
+			 * left off so all unassigned entries don't get
+			 * assigned the IRQ of the first entry.
+			 */
+			new_cpu = start_cpu;
+			for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
+				new_cpup = &phba->sli4_hba.cpu_map[new_cpu];
+				if (!(new_cpup->flag & LPFC_CPU_MAP_UNASSIGN) &&
+				    (new_cpup->irq != LPFC_VECTOR_MAP_EMPTY))
+					goto found_any;
+				new_cpu = cpumask_next(
+					new_cpu, cpu_present_mask);
+				if (new_cpu == nr_cpumask_bits)
+					new_cpu = first_cpu;
+			}
+			/* We should never leave an entry unassigned */
+			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+					"3339 Set Affinity: CPU %d "
+					"hdwq %d irq %d UNASSIGNED\n",
+					cpu, cpup->hdwq, cpup->irq);
+			continue;
+found_any:
+			/* We found an available entry, copy the IRQ info */
+			cpup->eq = new_cpup->eq;
+			cpup->hdwq = new_cpup->hdwq;
+			cpup->irq = new_cpup->irq;
+
+			/* Bump start_cpu to the next slot to minmize the
+			 * chance of having multiple unassigned CPU entries
+			 * selecting the same IRQ.
+			 */
+			start_cpu = cpumask_next(new_cpu, cpu_present_mask);
+			if (start_cpu == nr_cpumask_bits)
+				start_cpu = first_cpu;
+
+			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+					"3338 Set Affinity: CPU %d "
+					"hdwq %d irq %d from id %d (%d/%d)\n",
+					cpu, cpup->hdwq, cpup->irq, new_cpu,
+					new_cpup->phys_id, new_cpup->core_id);
+		}
+	}
 	return;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 8b28a55c73bb..69c6dba77dce 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -549,7 +549,9 @@ struct lpfc_vector_map_info {
 	uint16_t	irq;
 	uint16_t	eq;
 	uint16_t	hdwq;
-	uint16_t	hyper;
+	uint16_t	flag;
+#define LPFC_CPU_MAP_HYPER	0x1
+#define LPFC_CPU_MAP_UNASSIGN	0x2
 };
 #define LPFC_VECTOR_MAP_EMPTY	0xffff
 
-- 
2.13.7

