Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79D15476A7
	for <lists+linux-scsi@lfdr.de>; Sat, 11 Jun 2022 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiFKQzn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 11 Jun 2022 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbiFKQzl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 11 Jun 2022 12:55:41 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2B6FA27;
        Sat, 11 Jun 2022 09:55:40 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LL3qb13Xnz9tSK;
        Sat, 11 Jun 2022 18:55:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nFh1cxtmkzBP; Sat, 11 Jun 2022 18:55:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LL3qZ70grz9tSH;
        Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB59A8B77D;
        Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cxP0qEisn2cd; Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.192])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96AB68B768;
        Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25BGtQIQ742061
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Jun 2022 18:55:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25BGtPqZ742060;
        Sat, 11 Jun 2022 18:55:25 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 1/2] powerpc: Don't include asm/setup.h in asm/machdep.h
Date:   Sat, 11 Jun 2022 18:55:15 +0200
Message-Id: <3b1dfb19a2c3265fb4abc2bfc7b6eae9261a998b.1654966508.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1654966513; l=5413; s=20211009; h=from:subject:message-id; bh=vKt/zj5ubWanfk2yp2gMHh5WNCdyLmbGfiDJfEjxtqw=; b=HyRWk2N/BXduTigNxI0hSIFHBaxZrQtiXsfP/OnB4bSHTDAPXCIo5SDH1iHkWGpt/8HxFyRRfkr4 QJRdxnspCwX53tQMUhinIM1aY/ZbOwkv1Zui8d7rvM2OIeopjcsm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

asm/machdep.h doesn't need asm/setup.h

Remove it.

Add it directly in files that needs it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/machdep.h     | 2 --
 arch/powerpc/kernel/pci-common.c       | 1 +
 arch/powerpc/kernel/prom.c             | 2 +-
 arch/powerpc/kernel/prom_init.c        | 2 +-
 arch/powerpc/kexec/core.c              | 1 +
 arch/powerpc/kvm/powerpc.c             | 1 +
 arch/powerpc/mm/mem.c                  | 1 +
 arch/powerpc/platforms/pseries/kexec.c | 2 +-
 arch/powerpc/platforms/pseries/lpar.c  | 2 +-
 arch/powerpc/platforms/pseries/setup.c | 1 +
 arch/powerpc/sysdev/fsl_pci.c          | 1 +
 drivers/scsi/mesh.c                    | 2 +-
 12 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 358d171ae8e0..613755afa8a9 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -8,8 +8,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 
-#include <asm/setup.h>
-
 struct pt_regs;
 struct pci_bus;	
 struct device_node;
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 068410cd54a3..c87999289752 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -39,6 +39,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/eeh.h>
+#include <asm/setup.h>
 
 #include "../../../drivers/pci/pci.h"
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index feae8509b59c..1066b072db35 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -44,7 +44,7 @@
 #include <asm/iommu.h>
 #include <asm/btext.h>
 #include <asm/sections.h>
-#include <asm/machdep.h>
+#include <asm/setup.h>
 #include <asm/pci-bridge.h>
 #include <asm/kexec.h>
 #include <asm/opal.h>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 04694ec423f6..1939683e35ed 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -42,7 +42,7 @@
 #include <asm/iommu.h>
 #include <asm/btext.h>
 #include <asm/sections.h>
-#include <asm/machdep.h>
+#include <asm/setup.h>
 #include <asm/asm-prototypes.h>
 #include <asm/ultravisor-api.h>
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 7ab4980fe13a..9773dd0640f3 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -19,6 +19,7 @@
 #include <asm/machdep.h>
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
+#include <asm/setup.h>
 
 void machine_kexec_mask_interrupts(void) {
 	unsigned int i;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 191992fcb2c2..fb1490761c87 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -33,6 +33,7 @@
 #include <asm/plpar_wrappers.h>
 #endif
 #include <asm/ultravisor.h>
+#include <asm/setup.h>
 
 #include "timing.h"
 #include "irq.h"
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 52b77684acda..2cf6748755e1 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -25,6 +25,7 @@
 #include <asm/mmzone.h>
 #include <asm/ftrace.h>
 #include <asm/code-patching.h>
+#include <asm/setup.h>
 
 #include <mm/mmu_decl.h>
 
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index ab6cdbebb35e..096d09ed89f6 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -6,7 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 
-#include <asm/machdep.h>
+#include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/firmware.h>
 #include <asm/kexec.h>
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 937f9c010b22..e6c117fb6491 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -27,7 +27,7 @@
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
-#include <asm/machdep.h>
+#include <asm/setup.h>
 #include <asm/mmu_context.h>
 #include <asm/iommu.h>
 #include <asm/tlb.h>
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index afb074269b42..e86a749173e6 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -72,6 +72,7 @@
 #include <asm/svm.h>
 #include <asm/dtl.h>
 #include <asm/hvconsole.h>
+#include <asm/setup.h>
 
 #include "pseries.h"
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 1011cfea2e32..e8d072e98b66 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -38,6 +38,7 @@
 #include <asm/disassemble.h>
 #include <asm/ppc-opcode.h>
 #include <asm/swiotlb.h>
+#include <asm/setup.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 322d3ad38159..a74f0c2c8ba7 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -38,7 +38,7 @@
 #include <asm/irq.h>
 #include <asm/hydra.h>
 #include <asm/processor.h>
-#include <asm/machdep.h>
+#include <asm/setup.h>
 #include <asm/pmac_feature.h>
 #include <asm/macio.h>
 
-- 
2.35.3

