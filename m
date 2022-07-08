Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21E56B332
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Jul 2022 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiGHHLz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Jul 2022 03:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiGHHLv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Jul 2022 03:11:51 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4776975;
        Fri,  8 Jul 2022 00:11:50 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LfPbN0nG9z9tKr;
        Fri,  8 Jul 2022 09:11:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GUC-TTr3AKPS; Fri,  8 Jul 2022 09:11:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LfPbK6l2yz9tFj;
        Fri,  8 Jul 2022 09:11:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE6C88B76C;
        Fri,  8 Jul 2022 09:11:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NctDR-Rk0r9G; Fri,  8 Jul 2022 09:11:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.202])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FB338B763;
        Fri,  8 Jul 2022 09:11:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2687BYYl603410
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Jul 2022 09:11:34 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2687BXTU603406;
        Fri, 8 Jul 2022 09:11:33 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, deller@gmx.de,
        manoj@linux.ibm.com, mrochs@linux.ibm.com, ukrishn@linux.ibm.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, tzimmermann@suse.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/4] powerpc: Finally remove unnecessary headers from asm/prom.h
Date:   Fri,  8 Jul 2022 09:11:08 +0200
Message-Id: <4be954abef978b34cff9193fc566ffefdd3517bb.1657264228.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <f75b383673663e27f6b57e50b4abfb9fe3780b00.1657264228.git.christophe.leroy@csgroup.eu>
References: <f75b383673663e27f6b57e50b4abfb9fe3780b00.1657264228.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657264266; l=1143; s=20211009; h=from:subject:message-id; bh=rhMeWgMRVJCcnZ4LkUB/MevA+zWJ66UrLEuQIoq1Yg0=; b=aSzeb+chFstwLU0nCOuwBtbA5U5xgYndUebgzgAFOP3kvtFTlKpIphdt6XSL2LaRlBzvqMzXeceC 3WcuvQhNCXW3RZk7r1HJGuNvWAJdmtN/35jcrr7gzAg+rGVfsK9j
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

Remove all headers included from asm/prom.h which are not used
by asm/prom.h itself.

Declare struct device_node and struct property locally to
avoid including of.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/prom.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 6f109b5cb84e..2e82820fbd64 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -12,16 +12,10 @@
  * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
  */
 #include <linux/types.h>
-#include <asm/irq.h>
-#include <linux/atomic.h>
 #include <asm/firmware.h>
 
-/* These includes should be removed once implicit includes are cleaned up. */
-#include <linux/of.h>
-#include <linux/of_fdt.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/platform_device.h>
+struct device_node;
+struct property;
 
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
 #define OF_DT_END_NODE		0x2		/* End node */
-- 
2.36.1

