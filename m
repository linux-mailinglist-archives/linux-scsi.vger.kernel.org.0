Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58F1755B7
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Mar 2020 09:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgCBISg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Mar 2020 03:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbgCBIQV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:21 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312FE246CD;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=whC7giiFv+Yk442YMgup2KDESn5/o/XkEA6JPZfKSOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGk3J5HlEheZ32y/4VOv0ANHBoVnpC05frr3DIwvRXZyMmDIdC7yWr9SHgNk+J0ss
         Ziq3Li+N9118FzjH3EvwYeM8aNw2l4EGJMhV8Q3E0xgJ8DY/1VOJYa63K+ZxehW3J2
         BwCPBBxU4+Y8Pk9YLVyLA2FucY+fYzPPggD1BARY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003xQ-9b; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 11/42] docs: scsi: convert BusLogic.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:44 +0100
Message-Id: <750629b6a5233c85c5391c44d126606b8aabefc8.1583136624.git.mchehab+huawei@kernel.org>
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
 .../scsi/{BusLogic.txt => BusLogic.rst}       | 89 +++++++++++++------
 Documentation/scsi/index.rst                  |  1 +
 drivers/scsi/BusLogic.c                       |  2 +-
 drivers/scsi/Kconfig                          |  2 +-
 4 files changed, 67 insertions(+), 27 deletions(-)
 rename Documentation/scsi/{BusLogic.txt => BusLogic.rst} (93%)

diff --git a/Documentation/scsi/BusLogic.txt b/Documentation/scsi/BusLogic.rst
similarity index 93%
rename from Documentation/scsi/BusLogic.txt
rename to Documentation/scsi/BusLogic.rst
index 48e982cd6fe7..b60169812358 100644
--- a/Documentation/scsi/BusLogic.txt
+++ b/Documentation/scsi/BusLogic.rst
@@ -1,6 +1,11 @@
-	   BusLogic MultiMaster and FlashPoint SCSI Driver for Linux
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================================
+BusLogic MultiMaster and FlashPoint SCSI Driver for Linux
+=========================================================
 
 			 Version 2.0.15 for Linux 2.0
+
 			 Version 2.1.15 for Linux 2.1
 
 			      PRODUCTION RELEASE
@@ -8,13 +13,16 @@
 				17 August 1998
 
 			       Leonard N. Zubkoff
+
 			       Dandelion Digital
+
 			       lnz@dandelion.com
 
 	 Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
 
 
-				 INTRODUCTION
+Introduction
+============
 
 BusLogic, Inc. designed and manufactured a variety of high performance SCSI
 host adapters which share a common programming interface across a diverse
@@ -86,9 +94,11 @@ Contact information for offices in Europe and Japan is available on the Web
 site.
 
 
-				DRIVER FEATURES
+Driver Features
+===============
 
-o Configuration Reporting and Testing
+Configuration Reporting and Testing
+-----------------------------------
 
   During system initialization, the driver reports extensively on the host
   adapter hardware configuration, including the synchronous transfer parameters
@@ -130,7 +140,8 @@ o Configuration Reporting and Testing
     The status of Wide Negotiation, Disconnect/Reconnect, and Tagged Queuing
     are reported as "Enabled", Disabled", or a sequence of "Y" and "N" letters.
 
-o Performance Features
+Performance Features
+--------------------
 
   BusLogic SCSI Host Adapters directly implement SCSI-2 Tagged Queuing, and so
   support has been included in the driver to utilize tagged queuing with any
@@ -150,7 +161,8 @@ o Performance Features
   queue depth of 1 is selected.  Tagged queuing is also disabled for individual
   target devices if disconnect/reconnect is disabled for that device.
 
-o Robustness Features
+Robustness Features
+-------------------
 
   The driver implements extensive error recovery procedures.  When the higher
   level parts of the SCSI subsystem request that a timed out command be reset,
@@ -174,7 +186,8 @@ o Robustness Features
   lock up or crash, and thereby allowing a clean shutdown and restart after the
   offending component is removed.
 
-o PCI Configuration Support
+PCI Configuration Support
+-------------------------
 
   On PCI systems running kernels compiled with PCI BIOS support enabled, this
   driver will interrogate the PCI configuration space and use the I/O port
@@ -184,19 +197,22 @@ o PCI Configuration Support
   used to disable the ISA compatible I/O port entirely as it is not necessary.
   The ISA compatible I/O port is disabled by default on the BT-948/958/958D.
 
-o /proc File System Support
+/proc File System Support
+-------------------------
 
   Copies of the host adapter configuration information together with updated
   data transfer and error recovery statistics are available through the
   /proc/scsi/BusLogic/<N> interface.
 
-o Shared Interrupts Support
+Shared Interrupts Support
+-------------------------
 
   On systems that support shared interrupts, any number of BusLogic Host
   Adapters may share the same interrupt request channel.
 
 
-			    SUPPORTED HOST ADAPTERS
+Supported Host Adapters
+=======================
 
 The following list comprises the supported BusLogic SCSI Host Adapters as of
 the date of this document.  It is recommended that anyone purchasing a BusLogic
@@ -205,6 +221,7 @@ that it is or will be supported.
 
 FlashPoint Series PCI Host Adapters:
 
+=======================	=============================================
 FlashPoint LT (BT-930)	Ultra SCSI-3
 FlashPoint LT (BT-930R)	Ultra SCSI-3 with RAIDPlus
 FlashPoint LT (BT-920)	Ultra SCSI-3 (BT-930 without BIOS)
@@ -214,15 +231,19 @@ FlashPoint LW (BT-950)	Wide Ultra SCSI-3
 FlashPoint LW (BT-950R)	Wide Ultra SCSI-3 with RAIDPlus
 FlashPoint DW (BT-952)	Dual Channel Wide Ultra SCSI-3
 FlashPoint DW (BT-952R)	Dual Channel Wide Ultra SCSI-3 with RAIDPlus
+=======================	=============================================
 
 MultiMaster "W" Series Host Adapters:
 
+=======     ===		==============================
 BT-948	    PCI		Ultra SCSI-3
 BT-958	    PCI		Wide Ultra SCSI-3
 BT-958D	    PCI		Wide Differential Ultra SCSI-3
+=======     ===		==============================
 
 MultiMaster "C" Series Host Adapters:
 
+========    ====	==============================
 BT-946C	    PCI		Fast SCSI-2
 BT-956C	    PCI		Wide Fast SCSI-2
 BT-956CD    PCI		Wide Differential Fast SCSI-2
@@ -232,9 +253,11 @@ BT-757C	    EISA	Wide Fast SCSI-2
 BT-757CD    EISA	Wide Differential Fast SCSI-2
 BT-545C	    ISA		Fast SCSI-2
 BT-540CF    ISA		Fast SCSI-2
+========    ====	==============================
 
 MultiMaster "S" Series Host Adapters:
 
+=======     ====	==============================
 BT-445S	    VLB		Fast SCSI-2
 BT-747S	    EISA	Fast SCSI-2
 BT-747D	    EISA	Differential Fast SCSI-2
@@ -244,11 +267,14 @@ BT-545S	    ISA		Fast SCSI-2
 BT-542D	    ISA		Differential Fast SCSI-2
 BT-742A	    EISA	SCSI-2 (742A revision H)
 BT-542B	    ISA		SCSI-2 (542B revision H)
+=======     ====	==============================
 
 MultiMaster "A" Series Host Adapters:
 
+=======     ====	==============================
 BT-742A	    EISA	SCSI-2 (742A revisions A - G)
 BT-542B	    ISA		SCSI-2 (542B revisions A - G)
+=======     ====	==============================
 
 AMI FastDisk Host Adapters that are true BusLogic MultiMaster clones are also
 supported by this driver.
@@ -260,9 +286,11 @@ list.  The retail kit includes the bare board and manual as well as cabling and
 driver media and documentation that are not provided with bare boards.
 
 
-			 FLASHPOINT INSTALLATION NOTES
+FlashPoint Installation Notes
+=============================
 
-o RAIDPlus Support
+RAIDPlus Support
+----------------
 
   FlashPoint Host Adapters now include RAIDPlus, Mylex's bootable software
   RAID.  RAIDPlus is not supported on Linux, and there are no plans to support
@@ -273,7 +301,8 @@ o RAIDPlus Support
   than RAIDPlus, so there is little impetus to include RAIDPlus support in the
   BusLogic driver.
 
-o Enabling UltraSCSI Transfers
+Enabling UltraSCSI Transfers
+----------------------------
 
   FlashPoint Host Adapters ship with their configuration set to "Factory
   Default" settings that are conservative and do not allow for UltraSCSI speed
@@ -287,12 +316,14 @@ o Enabling UltraSCSI Transfers
   the "Optimum Performance" settings are loaded.
 
 
-		      BT-948/958/958D INSTALLATION NOTES
+BT-948/958/958D Installation Notes
+==================================
 
 The BT-948/958/958D PCI Ultra SCSI Host Adapters have some features which may
 require attention in some circumstances when installing Linux.
 
-o PCI I/O Port Assignments
+PCI I/O Port Assignments
+------------------------
 
   When configured to factory default settings, the BT-948/958/958D will only
   recognize the PCI I/O port assignments made by the motherboard's PCI BIOS.
@@ -312,7 +343,8 @@ o PCI I/O Port Assignments
   possible future I/O port conflicts.  The older BT-946C/956C/956CD also have
   this configuration option, but the factory default setting is "Primary".
 
-o PCI Slot Scanning Order
+PCI Slot Scanning Order
+-----------------------
 
   In systems with multiple BusLogic PCI Host Adapters, the order in which the
   PCI slots are scanned may appear reversed with the BT-948/958/958D as
@@ -339,7 +371,8 @@ o PCI Slot Scanning Order
   so as to recognize the host adapters in the same order as they are enumerated
   by the host adapter's BIOS.
 
-o Enabling UltraSCSI Transfers
+Enabling UltraSCSI Transfers
+----------------------------
 
   The BT-948/958/958D ship with their configuration set to "Factory Default"
   settings that are conservative and do not allow for UltraSCSI speed to be
@@ -353,7 +386,8 @@ o Enabling UltraSCSI Transfers
   "Optimum Performance" settings are loaded.
 
 
-				DRIVER OPTIONS
+Driver Options
+==============
 
 BusLogic Driver Options may be specified either via the Linux Kernel Command
 Line or via the Loadable Kernel Module Installation Facility.  Driver Options
@@ -520,30 +554,34 @@ The following examples demonstrate setting the Queue Depth for Target Devices
 Devices on the second host adapter to 31, and the Bus Settle Time on the
 second host adapter to 30 seconds.
 
-Linux Kernel Command Line:
+Linux Kernel Command Line::
 
   linux BusLogic=QueueDepth:[,7,15];QueueDepth:31,BusSettleTime:30
 
-LILO Linux Boot Loader (in /etc/lilo.conf):
+LILO Linux Boot Loader (in /etc/lilo.conf)::
 
   append = "BusLogic=QueueDepth:[,7,15];QueueDepth:31,BusSettleTime:30"
 
-INSMOD Loadable Kernel Module Installation Facility:
+INSMOD Loadable Kernel Module Installation Facility::
 
   insmod BusLogic.o \
       'BusLogic="QueueDepth:[,7,15];QueueDepth:31,BusSettleTime:30"'
 
-NOTE: Module Utilities 2.1.71 or later is required for correct parsing
+
+.. Note::
+
+      Module Utilities 2.1.71 or later is required for correct parsing
       of driver options containing commas.
 
 
-			      DRIVER INSTALLATION
+Driver Installation
+===================
 
 This distribution was prepared for Linux kernel version 2.0.35, but should be
 compatible with 2.0.4 or any later 2.0 series kernel.
 
 To install the new BusLogic SCSI driver, you may use the following commands,
-replacing "/usr/src" with wherever you keep your Linux kernel source tree:
+replacing "/usr/src" with wherever you keep your Linux kernel source tree::
 
   cd /usr/src
   tar -xvzf BusLogic-2.0.15.tar.gz
@@ -557,7 +595,8 @@ Then install "arch/x86/boot/zImage" as your standard kernel, run lilo if
 appropriate, and reboot.
 
 
-		      BUSLOGIC ANNOUNCEMENTS MAILING LIST
+BusLogic Announcements Mailing List
+===================================
 
 The BusLogic Announcements Mailing List provides a forum for informing Linux
 users of new driver releases and other announcements regarding Linux support
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index d453fb3f1f7d..6bb2428c1d56 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -15,5 +15,6 @@ Linux SCSI Subsystem
    aic7xxx
    bfa
    bnx2fc
+   BusLogic
 
    scsi_transport_srp/figures
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 3170b295a5da..9b8be4f0da19 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3652,7 +3652,7 @@ static bool __init blogic_parse(char **str, char *keyword)
   selected host adapter.
 
   The BusLogic Driver Probing Options are described in
-  <file:Documentation/scsi/BusLogic.txt>.
+  <file:Documentation/scsi/BusLogic.rst>.
 */
 
 static int __init blogic_parseopts(char *options)
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 18af62594bc0..5ec7330f82b6 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -502,7 +502,7 @@ config SCSI_BUSLOGIC
 	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
 	  Adapters. Consult the SCSI-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>, and the files
-	  <file:Documentation/scsi/BusLogic.txt> and
+	  <file:Documentation/scsi/BusLogic.rst> and
 	  <file:Documentation/scsi/FlashPoint.txt> for more information.
 	  Note that support for FlashPoint is only available for 32-bit
 	  x86 configurations.
-- 
2.21.1

