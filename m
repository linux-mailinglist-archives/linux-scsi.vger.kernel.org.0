Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86FD75FE07
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jul 2023 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGXRoF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jul 2023 13:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjGXRn5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jul 2023 13:43:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18213170F;
        Mon, 24 Jul 2023 10:43:54 -0700 (PDT)
Message-ID: <20230724172843.757723854@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QyA0S2TVws1qsDR2birwFTxwxOkhSIlP4hK4LYRB228=;
        b=KZ398iJF69fxiAwKvO5SnenKyHckxQgvzU2gXrVxpYTG5e6SBVPRyIMX0hyc/DpPUTmZ+8
        KhIFe4OraYoPhWKP4VLHv+teT6O3VS4HGma4PTMPv4tEhnnUahAMSm/0KIIe0uR34978S/
        KRLlOOmWo+ZRpQEWa0aS3+VVRjh0dTF3teCNQqrLKgY8Ur+is3SqPQMYIebCQcqkgBMbnA
        xo9KqLolzGwT9yJAy0oKYLidzg6HSGWS2fWyFOQap7uQgo69JD3Ij6uesTxLLRVxgf7RZ2
        MsK9DSHdS9+J1jFIiPOzZVwGnX1TRG+g04pOR3O0vZKuVQY6TqCmbgOkUK8UpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QyA0S2TVws1qsDR2birwFTxwxOkhSIlP4hK4LYRB228=;
        b=hepgplPRVV2oMUm94AmgUW+1CAOD3LOnzGW7cisYj3JQsXDtv+1ffPzJ+owUc8TtDwRhA0
        IyyWmlr1InG2cHBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 01/29] x86/cpu: Encapsulate topology information in
 cpuinfo_x86
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:43:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The topology related information is randomly scattered across cpuinfo_x86.

Create a new structure cpuinfo_topo and move in a first step initial_apicid
and apicid into it.

Aside of being better readable this is in preparation for replacing the
horribly fragile CPU topology evaluation code further down the road.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h          |   12 +++++++-----
 arch/x86/kernel/cpu/amd.c                 |   10 +++++-----
 arch/x86/kernel/cpu/cacheinfo.c           |   20 ++++++++++----------
 arch/x86/kernel/cpu/common.c              |   18 +++++++++---------
 arch/x86/kernel/cpu/hygon.c               |   12 ++++++------
 arch/x86/kernel/cpu/mce/apei.c            |    2 +-
 arch/x86/kernel/cpu/mce/core.c            |    2 +-
 arch/x86/kernel/cpu/proc.c                |    4 ++--
 arch/x86/kernel/cpu/topology.c            |   12 ++++++------
 arch/x86/xen/apic.c                       |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |    2 +-
 drivers/virt/acrn/hsm.c                   |    2 +-
 12 files changed, 50 insertions(+), 48 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -74,11 +74,14 @@ extern u16 __read_mostly tlb_lld_4m[NR_I
 extern u16 __read_mostly tlb_lld_1g[NR_INFO];
 
 /*
- *  CPU type and hardware bug flags. Kept separately for each CPU.
- *  Members of this structure are referenced in head_32.S, so think twice
- *  before touching them. [mj]
+ * CPU type and hardware bug flags. Kept separately for each CPU.
  */
 
+struct cpuinfo_topology {
+	u16			apicid;
+	u16			initial_apicid;
+};
+
 struct cpuinfo_x86 {
 	__u8			x86;		/* CPU family */
 	__u8			x86_vendor;	/* CPU vendor */
@@ -111,6 +114,7 @@ struct cpuinfo_x86 {
 	};
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
+	struct cpuinfo_topology	topo;
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
@@ -124,8 +128,6 @@ struct cpuinfo_x86 {
 	u64			ppin;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
-	u16			apicid;
-	u16			initial_apicid;
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -387,9 +387,9 @@ static void amd_detect_cmp(struct cpuinf
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->initial_apicid & ((1 << bits)-1);
+	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id = c->initial_apicid >> bits;
+	c->phys_proc_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
@@ -405,7 +405,7 @@ static void srat_detect_node(struct cpui
 #ifdef CONFIG_NUMA
 	int cpu = smp_processor_id();
 	int node;
-	unsigned apicid = c->apicid;
+	unsigned apicid = c->topo.apicid;
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
@@ -439,7 +439,7 @@ static void srat_detect_node(struct cpui
 		 * through CPU mapping may alter the outcome, directly
 		 * access __apicid_to_node[].
 		 */
-		int ht_nodeid = c->initial_apicid;
+		int ht_nodeid = c->topo.initial_apicid;
 
 		if (__apicid_to_node[ht_nodeid] != NUMA_NO_NODE)
 			node = __apicid_to_node[ht_nodeid];
@@ -934,7 +934,7 @@ static void init_amd(struct cpuinfo_x86
 		set_cpu_cap(c, X86_FEATURE_FSRS);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = read_apic_id();
+	c->topo.apicid = read_apic_id();
 
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -678,7 +678,7 @@ void cacheinfo_amd_init_llc_id(struct cp
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
 		 */
-		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+		per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> 3;
 	} else {
 		/*
 		 * LLC ID is calculated from the number of threads sharing the
@@ -694,7 +694,7 @@ void cacheinfo_amd_init_llc_id(struct cp
 		if (num_sharing_cache) {
 			int bits = get_count_order(num_sharing_cache);
 
-			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
+			per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> bits;
 		}
 	}
 }
@@ -712,7 +712,7 @@ void cacheinfo_hygon_init_llc_id(struct
 	 * LLC is at the core complex level.
 	 * Core complex ID is ApicId[3] for these processors.
 	 */
-	per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+	per_cpu(cpu_llc_id, cpu) = c->topo.apicid >> 3;
 }
 
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
@@ -776,13 +776,13 @@ void init_intel_cacheinfo(struct cpuinfo
 				new_l2 = this_leaf.size/1024;
 				num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
-				l2_id = c->apicid & ~((1 << index_msb) - 1);
+				l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			case 3:
 				new_l3 = this_leaf.size/1024;
 				num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
-				l3_id = c->apicid & ~((1 << index_msb) - 1);
+				l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			default:
 				break;
@@ -915,7 +915,7 @@ static int __cache_amd_cpumap_setup(unsi
 		unsigned int apicid, nshared, first, last;
 
 		nshared = base->eax.split.num_threads_sharing + 1;
-		apicid = cpu_data(cpu).apicid;
+		apicid = cpu_data(cpu).topo.apicid;
 		first = apicid - (apicid % nshared);
 		last = first + nshared - 1;
 
@@ -924,14 +924,14 @@ static int __cache_amd_cpumap_setup(unsi
 			if (!this_cpu_ci->info_list)
 				continue;
 
-			apicid = cpu_data(i).apicid;
+			apicid = cpu_data(i).topo.apicid;
 			if ((apicid < first) || (apicid > last))
 				continue;
 
 			this_leaf = this_cpu_ci->info_list + index;
 
 			for_each_online_cpu(sibling) {
-				apicid = cpu_data(sibling).apicid;
+				apicid = cpu_data(sibling).topo.apicid;
 				if ((apicid < first) || (apicid > last))
 					continue;
 				cpumask_set_cpu(sibling,
@@ -969,7 +969,7 @@ static void __cache_cpumap_setup(unsigne
 	index_msb = get_count_order(num_threads_sharing);
 
 	for_each_online_cpu(i)
-		if (cpu_data(i).apicid >> index_msb == c->apicid >> index_msb) {
+		if (cpu_data(i).topo.apicid >> index_msb == c->topo.apicid >> index_msb) {
 			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
 
 			if (i == cpu || !sib_cpu_ci->info_list)
@@ -1024,7 +1024,7 @@ static void get_cache_id(int cpu, struct
 
 	num_threads_sharing = 1 + id4_regs->eax.split.num_threads_sharing;
 	index_msb = get_count_order(num_threads_sharing);
-	id4_regs->id = c->apicid >> index_msb;
+	id4_regs->id = c->topo.apicid >> index_msb;
 }
 
 int populate_cache_leaves(unsigned int cpu)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -899,7 +899,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 		return;
 
 	index_msb = get_count_order(smp_num_siblings);
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, index_msb);
+	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
 
 	smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
@@ -907,7 +907,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 	core_bits = get_count_order(c->x86_max_cores);
 
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid, index_msb) &
+	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
 				       ((1 << core_bits) - 1);
 #endif
 }
@@ -1721,15 +1721,15 @@ static void generic_identify(struct cpui
 	get_cpu_address_sizes(c);
 
 	if (c->cpuid_level >= 0x00000001) {
-		c->initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
+		c->topo.initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_SMP
-		c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+		c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 # else
-		c->apicid = c->initial_apicid;
+		c->topo.apicid = c->topo.initial_apicid;
 # endif
 #endif
-		c->phys_proc_id = c->initial_apicid;
+		c->phys_proc_id = c->topo.initial_apicid;
 	}
 
 	get_model_name(c); /* Default name */
@@ -1763,9 +1763,9 @@ static void validate_apic_and_package_id
 
 	apicid = apic->cpu_present_to_apicid(cpu);
 
-	if (apicid != c->apicid) {
+	if (apicid != c->topo.apicid) {
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
-		       cpu, apicid, c->initial_apicid);
+		       cpu, apicid, c->topo.initial_apicid);
 	}
 	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
 	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
@@ -1815,7 +1815,7 @@ static void identify_cpu(struct cpuinfo_
 	apply_forced_caps(c);
 
 #ifdef CONFIG_X86_64
-	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 #endif
 
 	/*
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -88,7 +88,7 @@ static void hygon_get_topology(struct cp
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
 		/* Socket ID is ApicId[6] for these processors. */
-		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+		c->phys_proc_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
@@ -116,9 +116,9 @@ static void hygon_detect_cmp(struct cpui
 
 	bits = c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id = c->initial_apicid & ((1 << bits)-1);
+	c->cpu_core_id = c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id = c->initial_apicid >> bits;
+	c->phys_proc_id = c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
@@ -128,7 +128,7 @@ static void srat_detect_node(struct cpui
 #ifdef CONFIG_NUMA
 	int cpu = smp_processor_id();
 	int node;
-	unsigned int apicid = c->apicid;
+	unsigned int apicid = c->topo.apicid;
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
@@ -161,7 +161,7 @@ static void srat_detect_node(struct cpui
 		 * through CPU mapping may alter the outcome, directly
 		 * access __apicid_to_node[].
 		 */
-		int ht_nodeid = c->initial_apicid;
+		int ht_nodeid = c->topo.initial_apicid;
 
 		if (__apicid_to_node[ht_nodeid] != NUMA_NO_NODE)
 			node = __apicid_to_node[ht_nodeid];
@@ -301,7 +301,7 @@ static void init_hygon(struct cpuinfo_x8
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = read_apic_id();
+	c->topo.apicid = read_apic_id();
 
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -103,7 +103,7 @@ int apei_smca_report_x86_error(struct cp
 	m.socketid = -1;
 
 	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).initial_apicid == lapic_id) {
+		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
 			m.extcpu = cpu;
 			m.socketid = cpu_data(m.extcpu).phys_proc_id;
 			break;
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -124,7 +124,7 @@ void mce_setup(struct mce *m)
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->cpuid = cpuid_eax(1);
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
-	m->apicid = cpu_data(m->extcpu).initial_apicid;
+	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
 	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
 	m->ppin = cpu_data(m->extcpu).ppin;
 	m->microcode = boot_cpu_data.microcode;
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -23,8 +23,8 @@ static void show_cpuinfo_core(struct seq
 		   cpumask_weight(topology_core_cpumask(cpu)));
 	seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
 	seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
-	seq_printf(m, "apicid\t\t: %d\n", c->apicid);
-	seq_printf(m, "initial apicid\t: %d\n", c->initial_apicid);
+	seq_printf(m, "apicid\t\t: %d\n", c->topo.apicid);
+	seq_printf(m, "initial apicid\t: %d\n", c->topo.initial_apicid);
 #endif
 }
 
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -78,7 +78,7 @@ int detect_extended_topology_early(struc
 	/*
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
-	c->initial_apicid = edx;
+	c->topo.initial_apicid = edx;
 	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
@@ -108,7 +108,7 @@ int detect_extended_topology(struct cpui
 	 * Populate HT related information from sub-leaf level 0.
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	c->initial_apicid = edx;
+	c->topo.initial_apicid = edx;
 	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
@@ -146,20 +146,20 @@ int detect_extended_topology(struct cpui
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
 
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
+	c->cpu_core_id = apic->phys_pkg_id(c->topo.initial_apicid,
 				ht_mask_width) & core_select_mask;
 
 	if (die_level_present) {
-		c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
+		c->cpu_die_id = apic->phys_pkg_id(c->topo.initial_apicid,
 					core_plus_mask_width) & die_select_mask;
 	}
 
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
+	c->phys_proc_id = apic->phys_pkg_id(c->topo.initial_apicid,
 				pkg_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
-	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
 	__max_die_per_package = (die_level_siblings / core_level_siblings);
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -118,7 +118,7 @@ static int xen_phys_pkg_id(int initial_a
 static int xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
-		return cpu_data(cpu).apicid;
+		return cpu_data(cpu).topo.apicid;
 	else
 		return BAD_APICID;
 }
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2255,7 +2255,7 @@ static int kfd_cpumask_to_apic_id(const
 	if (first_cpu_of_numa_node >= nr_cpu_ids)
 		return -1;
 #ifdef CONFIG_X86_64
-	return cpu_data(first_cpu_of_numa_node).apicid;
+	return cpu_data(first_cpu_of_numa_node).topo.apicid;
 #else
 	return first_cpu_of_numa_node;
 #endif
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -447,7 +447,7 @@ static ssize_t remove_cpu_store(struct d
 	if (cpu_online(cpu))
 		remove_cpu(cpu);
 
-	lapicid = cpu_data(cpu).apicid;
+	lapicid = cpu_data(cpu).topo.apicid;
 	dev_dbg(dev, "Try to remove cpu %lld with lapicid %lld\n", cpu, lapicid);
 	ret = hcall_sos_remove_cpu(lapicid);
 	if (ret < 0) {

