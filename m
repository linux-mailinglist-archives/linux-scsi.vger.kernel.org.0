Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663AF1755BF
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Mar 2020 09:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCBISf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Mar 2020 03:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgCBIQV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:21 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B3E246E4;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=38vWwY8WDeo4wWGBmnlve3hnkekL6KaGDbK0Cb1AvEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhVdc3SnAxRviRnL4o/a7J5QsaARF1FI+uv+cGiwwWrBPYEn9RndBbhiglEB2hq4G
         e1nSLvk/ewT9/C37jl6YKjgad+nNc9hGCnr+c8Oe5WtIZ6rLuaLdS8l6WjA1k60t91
         +ubEDEPEwvNVqMMNaWFkIFXySLhLgevjmrblLC64=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003xp-Di; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 16/42] docs: scsi: convert g_NCR5380.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:49 +0100
Message-Id: <a66e9ea704be6a7aa81b9864ad66a32b75ab808d.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../scsi/{g_NCR5380.txt => g_NCR5380.rst}     | 89 ++++++++++++-------
 Documentation/scsi/index.rst                  |  1 +
 Documentation/scsi/scsi-parameters.txt        |  6 +-
 MAINTAINERS                                   |  2 +-
 drivers/scsi/g_NCR5380.c                      |  2 +-
 5 files changed, 63 insertions(+), 37 deletions(-)
 rename Documentation/scsi/{g_NCR5380.txt => g_NCR5380.rst} (41%)

diff --git a/Documentation/scsi/g_NCR5380.txt b/Documentation/scsi/g_NCR5380.rst
similarity index 41%
rename from Documentation/scsi/g_NCR5380.txt
rename to Documentation/scsi/g_NCR5380.rst
index 37b1967a00a9..a282059fec43 100644
--- a/Documentation/scsi/g_NCR5380.txt
+++ b/Documentation/scsi/g_NCR5380.rst
@@ -1,7 +1,13 @@
-README file for the Linux g_NCR5380 driver.
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-(c) 1993 Drew Eckhard
-NCR53c400 extensions (c) 1994,1995,1996 Kevin Lentin
+==========================================
+README file for the Linux g_NCR5380 driver
+==========================================
+
+Copyright |copy| 1993 Drew Eckhard
+
+NCR53c400 extensions Copyright |copy| 1994,1995,1996 Kevin Lentin
 
 This file documents the NCR53c400 extensions by Kevin Lentin and some
 enhancements to the NCR5380 core.
@@ -26,43 +32,62 @@ time. More info to come in the future.
 This driver works as a module.
 When included as a module, parameters can be passed on the insmod/modprobe
 command line:
+
+  ============= ===============================================================
   irq=xx[,...]	the interrupt(s)
   base=xx[,...]	the port or base address(es) (for port or memory mapped, resp.)
   card=xx[,...]	card type(s):
-		0 = NCR5380,
-		1 = NCR53C400,
-		2 = NCR53C400A,
-		3 = Domex Technology Corp 3181E (DTC3181E)
-		4 = Hewlett Packard C2502
+
+		==  ======================================
+		0   NCR5380,
+		1   NCR53C400,
+		2   NCR53C400A,
+		3   Domex Technology Corp 3181E (DTC3181E)
+		4   Hewlett Packard C2502
+		==  ======================================
+  ============= ===============================================================
 
 These old-style parameters can support only one card:
-  ncr_irq=xx   the interrupt
-  ncr_addr=xx  the port or base address (for port or memory
-               mapped, resp.)
-  ncr_5380=1   to set up for a NCR5380 board
-  ncr_53c400=1 to set up for a NCR53C400 board
+
+  ============= =================================================
+  ncr_irq=xx    the interrupt
+  ncr_addr=xx   the port or base address (for port or memory
+                mapped, resp.)
+  ncr_5380=1    to set up for a NCR5380 board
+  ncr_53c400=1  to set up for a NCR53C400 board
   ncr_53c400a=1 to set up for a NCR53C400A board
-  dtc_3181e=1  to set up for a Domex Technology Corp 3181E board
-  hp_c2502=1   to set up for a Hewlett Packard C2502 board
-
-E.g. Trantor T130B in its default configuration:
-modprobe g_NCR5380 irq=5 base=0x350 card=1
-or alternatively, using the old syntax,
-modprobe g_NCR5380 ncr_irq=5 ncr_addr=0x350 ncr_53c400=1
-
-E.g. a port mapped NCR5380 board, driver to probe for IRQ:
-modprobe g_NCR5380 base=0x350 card=0
-or alternatively,
-modprobe g_NCR5380 ncr_addr=0x350 ncr_5380=1
-
-E.g. a memory mapped NCR53C400 board with no IRQ:
-modprobe g_NCR5380 irq=255 base=0xc8000 card=1
-or alternatively,
-modprobe g_NCR5380 ncr_irq=255 ncr_addr=0xc8000 ncr_53c400=1
+  dtc_3181e=1   to set up for a Domex Technology Corp 3181E board
+  hp_c2502=1    to set up for a Hewlett Packard C2502 board
+  ============= =================================================
+
+E.g. Trantor T130B in its default configuration::
+
+	modprobe g_NCR5380 irq=5 base=0x350 card=1
+
+or alternatively, using the old syntax::
+
+	modprobe g_NCR5380 ncr_irq=5 ncr_addr=0x350 ncr_53c400=1
+
+E.g. a port mapped NCR5380 board, driver to probe for IRQ::
+
+	modprobe g_NCR5380 base=0x350 card=0
+
+or alternatively::
+
+	modprobe g_NCR5380 ncr_addr=0x350 ncr_5380=1
+
+E.g. a memory mapped NCR53C400 board with no IRQ::
+
+	modprobe g_NCR5380 irq=255 base=0xc8000 card=1
+
+or alternatively::
+
+	modprobe g_NCR5380 ncr_irq=255 ncr_addr=0xc8000 ncr_53c400=1
 
 E.g. two cards, DTC3181 (in non-PnP mode) at 0x240 with no IRQ
-and HP C2502 at 0x300 with IRQ 7:
-modprobe g_NCR5380 irq=0,7 base=0x240,0x300 card=3,4
+and HP C2502 at 0x300 with IRQ 7::
+
+	modprobe g_NCR5380 irq=0,7 base=0x240,0x300 card=3,4
 
 Kevin Lentin
 K.Lentin@cs.monash.edu.au
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index aad8359357e6..4b577c9e804e 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -20,5 +20,6 @@ Linux SCSI Subsystem
    dc395x
    dpti
    FlashPoint
+   g_NCR5380
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/scsi-parameters.txt b/Documentation/scsi/scsi-parameters.txt
index 266fd3b2398a..864bbf7f737b 100644
--- a/Documentation/scsi/scsi-parameters.txt
+++ b/Documentation/scsi/scsi-parameters.txt
@@ -57,13 +57,13 @@ parameters may be changed at runtime by the command
 			See header of drivers/scsi/NCR_D700.c.
 
 	ncr5380=	[HW,SCSI]
-			See Documentation/scsi/g_NCR5380.txt.
+			See Documentation/scsi/g_NCR5380.rst.
 
 	ncr53c400=	[HW,SCSI]
-			See Documentation/scsi/g_NCR5380.txt.
+			See Documentation/scsi/g_NCR5380.rst.
 
 	ncr53c400a=	[HW,SCSI]
-			See Documentation/scsi/g_NCR5380.txt.
+			See Documentation/scsi/g_NCR5380.rst.
 
 	ncr53c8xx=	[HW,SCSI]
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e2ab816fe66..451a3f67d23a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11533,7 +11533,7 @@ M:	Finn Thain <fthain@telegraphics.com.au>
 M:	Michael Schmitz <schmitzmic@gmail.com>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
-F:	Documentation/scsi/g_NCR5380.txt
+F:	Documentation/scsi/g_NCR5380.rst
 F:	drivers/scsi/NCR5380.*
 F:	drivers/scsi/arm/cumana_1.c
 F:	drivers/scsi/arm/oak.c
diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
index 2ab774e62e40..2cc676e3df6a 100644
--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -20,7 +20,7 @@
  * Added ISAPNP support for DTC436 adapters,
  * Thomas Sailer, sailer@ife.ee.ethz.ch
  *
- * See Documentation/scsi/g_NCR5380.txt for more info.
+ * See Documentation/scsi/g_NCR5380.rst for more info.
  */
 
 #include <asm/io.h>
-- 
2.21.1

