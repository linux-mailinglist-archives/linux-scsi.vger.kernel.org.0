Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13E475FE58
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jul 2023 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGXRrV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jul 2023 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGXRqD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jul 2023 13:46:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0C1FDA;
        Mon, 24 Jul 2023 10:44:35 -0700 (PDT)
Message-ID: <20230724172845.206339747@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nCoiYGGGz2nXOq7tjWjNlQvkWfPVDpABc4VMP3k40m8=;
        b=MiQ7bR3ZjHmiReh4o694yPpOZbTkyzoXvQ1NVS7NMa3vr3okhcwORhjXWYjv18gXwyDSXs
        hg7C918dlOghClg06/8QS0wsy6kJWGXctkY0mQb8xWsSG8CknmS3BHDRr/Yf1o8UDaPsY6
        9ebjpHHuzIBFxCkXsqKhVEuYZtQWzA9CTC8eUHQ260gjYZB8jTvPWNqV54w127tiWYODL2
        4zs7BFFYTUpW4w6YbmppRm/rnMCrn9C9Fx/27a6nK5ZwYvAe6bnLJ3TDBy/3th4ysH+s5k
        3E9Ytf79viMg6ETXcDH7bCfm++VLLXYs+muJ5GmnmBDEFsDZ3urdNqQhxm/pjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nCoiYGGGz2nXOq7tjWjNlQvkWfPVDpABc4VMP3k40m8=;
        b=vDenuF6yZObdpPNtFXP9d0JygpI2Bkhw42FLA1KzJ/ffYVTQf9Rr7lev/pHxy5N68gcVOs
        h5CcFPLuZq60auAw==
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
Subject: [patch 26/29] x86/cpu: Remove topology.c
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:31 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

No more users. Stick it into the ugly code museum.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/Makefile   |    2 
 arch/x86/kernel/cpu/topology.c |  164 -----------------------------------------
 2 files changed, 1 insertion(+), 165 deletions(-)

--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -18,7 +18,7 @@ KMSAN_SANITIZE_common.o := n
 KCSAN_SANITIZE_common.o := n
 
 obj-y			:= cacheinfo.o scattered.o
-obj-y			+= topology_common.o topology_ext.o topology_amd.o topology.o
+obj-y			+= topology_common.o topology_ext.o topology_amd.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
--- a/arch/x86/kernel/cpu/topology.c
+++ /dev/null
@@ -1,164 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Check for extended topology enumeration cpuid leaf 0xb and if it
- * exists, use it for populating initial_apicid and cpu topology
- * detection.
- */
-
-#include <linux/cpu.h>
-#include <asm/apic.h>
-#include <asm/memtype.h>
-#include <asm/processor.h>
-
-#include "cpu.h"
-
-/* leaf 0xb SMT level */
-#define SMT_LEVEL	0
-
-/* extended topology sub-leaf types */
-#define INVALID_TYPE	0
-#define SMT_TYPE	1
-#define CORE_TYPE	2
-#define DIE_TYPE	5
-
-#define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
-#define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
-#define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
-
-#ifdef CONFIG_SMP
-/*
- * Check if given CPUID extended topology "leaf" is implemented
- */
-static int check_extended_topology_leaf(int leaf)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-
-	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
-		return -1;
-
-	return 0;
-}
-/*
- * Return best CPUID Extended Topology Leaf supported
- */
-static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
-{
-	if (c->cpuid_level >= 0x1f) {
-		if (check_extended_topology_leaf(0x1f) == 0)
-			return 0x1f;
-	}
-
-	if (c->cpuid_level >= 0xb) {
-		if (check_extended_topology_leaf(0xb) == 0)
-			return 0xb;
-	}
-
-	return -1;
-}
-#endif
-
-int detect_extended_topology_early(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx;
-	int leaf;
-
-	leaf = detect_extended_topology_leaf(c);
-	if (leaf < 0)
-		return -1;
-
-	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
-
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	/*
-	 * initial apic id, which also represents 32-bit extended x2apic id.
-	 */
-	c->topo.initial_apicid = edx;
-	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
-#endif
-	return 0;
-}
-
-/*
- * Check for extended topology enumeration cpuid leaf, and if it
- * exists, use it for populating initial_apicid and cpu topology
- * detection.
- */
-int detect_extended_topology(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
-	unsigned int core_select_mask, core_level_siblings;
-	unsigned int die_select_mask, die_level_siblings;
-	unsigned int pkg_mask_width;
-	bool die_level_present = false;
-	int leaf;
-
-	leaf = detect_extended_topology_leaf(c);
-	if (leaf < 0)
-		return -1;
-
-	/*
-	 * Populate HT related information from sub-leaf level 0.
-	 */
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	c->topo.initial_apicid = edx;
-	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
-	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-
-	sub_index = 1;
-	while (true) {
-		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
-
-		/*
-		 * Check for the Core type in the implemented sub leaves.
-		 */
-		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
-			core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-			core_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-			die_level_siblings = core_level_siblings;
-			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-		}
-		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
-			die_level_present = true;
-			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-		}
-
-		if (LEAFB_SUBTYPE(ecx) != INVALID_TYPE)
-			pkg_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-		else
-			break;
-
-		sub_index++;
-	}
-
-	core_select_mask = (~(-1 << pkg_mask_width)) >> ht_mask_width;
-	die_select_mask = (~(-1 << die_plus_mask_width)) >>
-				core_plus_mask_width;
-
-	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid,
-				ht_mask_width) & core_select_mask;
-
-	if (die_level_present) {
-		c->topo.die_id = apic->phys_pkg_id(c->topo.initial_apicid,
-					core_plus_mask_width) & die_select_mask;
-	}
-
-	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, pkg_mask_width);
-	/*
-	 * Reinit the apicid, now that we have extended initial_apicid.
-	 */
-	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
-
-	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
-	__max_die_per_package = (die_level_siblings / core_level_siblings);
-#endif
-	return 0;
-}

