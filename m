Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD31755A3
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Mar 2020 09:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgCBISF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Mar 2020 03:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbgCBIQV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:21 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F68246BF;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=vEDPp85owWebGGqnzGJmrLSQpWL2YJUvewWbPy2d2tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BG9jgGvG7OeYIM0JBHvlBKxa3qaJlTNxUAj1DPj+mLnUYR9w9cRARTGoimjzh6TGk
         bcrFOgbr2d9rOb8vv6iMXbrJMoYcnZPSl142QK3lHxmJpY8y/e0UekQ4bV2t/op30l
         tlZSAOYs5iZaKuTBz24nCK7r9N33mLK4Sf4XWaMA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003x8-5z; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 07/42] docs: scsi: convert aic79xx.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:40 +0100
Message-Id: <e8a40337a2173f028c9ac569d3d71fd880f4fab5.1583136624.git.mchehab+huawei@kernel.org>
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
 .../scsi/{aic79xx.txt => aic79xx.rst}         | 586 ++++++++++--------
 Documentation/scsi/index.rst                  |   1 +
 Documentation/scsi/scsi-parameters.txt        |   2 +-
 drivers/scsi/aic7xxx/Kconfig.aic79xx          |   2 +-
 4 files changed, 344 insertions(+), 247 deletions(-)
 rename Documentation/scsi/{aic79xx.txt => aic79xx.rst} (48%)

diff --git a/Documentation/scsi/aic79xx.txt b/Documentation/scsi/aic79xx.rst
similarity index 48%
rename from Documentation/scsi/aic79xx.txt
rename to Documentation/scsi/aic79xx.rst
index e2d3273000d4..071ff5111a4f 100644
--- a/Documentation/scsi/aic79xx.txt
+++ b/Documentation/scsi/aic79xx.rst
@@ -1,11 +1,13 @@
-====================================================================
-=             Adaptec Ultra320 Family Manager Set                  =
-=                                                                  =
-=                            README for                            =
-=                    The Linux Operating System                    =
-====================================================================
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-The following information is available in this file:
+===================================
+Adaptec Ultra320 Family Manager Set
+===================================
+
+README for The Linux Operating System
+
+.. The following information is available in this file:
 
   1. Supported Hardware
   2. Version History
@@ -15,28 +17,32 @@ The following information is available in this file:
 
 
 1. Supported Hardware
+=====================
 
-   The following Adaptec SCSI Host Adapters are supported by this 
-   driver set. 
+   The following Adaptec SCSI Host Adapters are supported by this
+   driver set.
 
+   =============              =========================================
    Ultra320 ASIC              Description
-   ----------------------------------------------------------------
-   AIC-7901A                  Single Channel 64-bit PCI-X 133MHz to 
+   =============              =========================================
+   AIC-7901A                  Single Channel 64-bit PCI-X 133MHz to
                               Ultra320 SCSI ASIC
-   AIC-7901B                  Single Channel 64-bit PCI-X 133MHz to 
+   AIC-7901B                  Single Channel 64-bit PCI-X 133MHz to
                               Ultra320 SCSI ASIC with Retained Training
-   AIC-7902A4                 Dual Channel 64-bit PCI-X 133MHz to 
+   AIC-7902A4                 Dual Channel 64-bit PCI-X 133MHz to
                               Ultra320 SCSI ASIC
    AIC-7902B                  Dual Channel 64-bit PCI-X 133MHz to
                               Ultra320 SCSI ASIC with Retained Training
+   =============              =========================================
 
+   ========================== ===================================== ============
    Ultra320 Adapters          Description                              ASIC
-   --------------------------------------------------------------------------
+   ========================== ===================================== ============
    Adaptec SCSI Card 39320    Dual Channel 64-bit PCI-X 133MHz to   7902A4/7902B
-                              Ultra320 SCSI Card (one external 
+                              Ultra320 SCSI Card (one external
                               68-pin, two internal 68-pin)
    Adaptec SCSI Card 39320A   Dual Channel 64-bit PCI-X 133MHz to      7902B
-                              Ultra320 SCSI Card (one external 
+                              Ultra320 SCSI Card (one external
                               68-pin, two internal 68-pin)
    Adaptec SCSI Card 39320D   Dual Channel 64-bit PCI-X 133MHz to      7902A4
                               Ultra320 SCSI Card (two external VHDC
@@ -46,11 +52,11 @@ The following information is available in this file:
                               and one internal 68-pin) based on the
                               AIC-7902B ASIC
    Adaptec SCSI Card 29320    Single Channel 64-bit PCI-X 133MHz to    7901A
-                              Ultra320 SCSI Card (one external 
+                              Ultra320 SCSI Card (one external
                               68-pin, two internal 68-pin, one
                               internal 50-pin)
    Adaptec SCSI Card 29320A   Single Channel 64-bit PCI-X 133MHz to    7901B
-                              Ultra320 SCSI Card (one external 
+                              Ultra320 SCSI Card (one external
                               68-pin, two internal 68-pin, one
                               internal 50-pin)
    Adaptec SCSI Card 29320LP  Single Channel 64-bit Low Profile        7901A
@@ -61,18 +67,22 @@ The following information is available in this file:
                               PCI-X 133MHz to Ultra320 SCSI Card
                               (One external VHDC, one internal
                               68-pin)
+   ========================== ===================================== ============
+
 2. Version History
+==================
 
-   3.0	  (December 1st, 2005)
+
+ * 3.0	  (December 1st, 2005)
 	- Updated driver to use SCSI transport class infrastructure
 	- Upported sequencer and core fixes from adaptec released
 	  version 2.0.15 of the driver.
 
-   1.3.11 (July 11, 2003)
+ * 1.3.11 (July 11, 2003)
         - Fix several deadlock issues.
         - Add 29320ALP and 39320B Id's.
 
-   1.3.10 (June 3rd, 2003)
+ * 1.3.10 (June 3rd, 2003)
         - Align the SCB_TAG field on a 16byte boundary.  This avoids
           SCB corruption on some PCI-33 busses.
         - Correct non-zero luns on Rev B. hardware.
@@ -87,7 +97,7 @@ The following information is available in this file:
           by some other driver probe that occurred before we
           claimed the controller.
 
-   1.3.9 (May 22nd, 2003)
+ * 1.3.9 (May 22nd, 2003)
         - Fix compiler errors.
         - Remove S/G splitting for segments that cross a 4GB boundary.
           This is guaranteed not to happen in Linux.
@@ -100,7 +110,7 @@ The following information is available in this file:
           if the transaction data length was even and we received
           an IWR message.
 
-   1.3.8 (April 29th, 2003)
+ * 1.3.8 (April 29th, 2003)
         - Fix types accessed via the command line interface code.
         - Perform a few firmware optimizations.
         - Fix "Unexpected PKT busfree" errors.
@@ -113,7 +123,7 @@ The following information is available in this file:
         - Add support for new 2.5.X interrupt API.
         - Correct big-endian architecture support.
 
-   1.3.7 (April 16th, 2003)
+ * 1.3.7 (April 16th, 2003)
         - Use del_timer_sync() to ensure that no timeouts
           are pending during controller shutdown.
         - For pre-2.5.X kernels, carefully adjust our segment
@@ -122,14 +132,14 @@ The following information is available in this file:
         - Workaround duplicate device entries in the mid-layer
           device list during add-single-device.
 
-   1.3.6 (March 28th, 2003)
+ * 1.3.6 (March 28th, 2003)
         - Correct a double free in the Domain Validation code.
         - Correct a reference to free'ed memory during controller
           shutdown.
         - Reset the bus on an SE->LVD change.  This is required
           to reset our transceivers.
 
-   1.3.5 (March 24th, 2003)
+ * 1.3.5 (March 24th, 2003)
         - Fix a few register window mode bugs.
         - Include read streaming in the PPR flags we display in
           diagnostics as well as /proc.
@@ -144,16 +154,16 @@ The following information is available in this file:
         - Cleanup command line parsing and move much of this code
           to aiclib.
 
-   1.3.4 (February 28th, 2003)
+ * 1.3.4 (February 28th, 2003)
         - Correct a race condition in our error recovery handler.
         - Allow Test Unit Ready commands to take a full 5 seconds
           during Domain Validation.
 
-   1.3.2 (February 19th, 2003)
+ * 1.3.2 (February 19th, 2003)
         - Correct a Rev B. regression due to the GEM318
           compatibility fix included in 1.3.1.
-          
-   1.3.1 (February 11th, 2003)
+
+ * 1.3.1 (February 11th, 2003)
         - Add support for the 39320A.
         - Improve recovery for certain PCI-X errors.
         - Fix handling of LQ/DATA/LQ/DATA for the
@@ -166,42 +176,43 @@ The following information is available in this file:
         - Adapt to a change in the 2.5.X daemonize() API.
         - Correct a "Missing case in ahd_handle_scsiint" panic.
 
-   1.3.0 (January 21st, 2003)
+ * 1.3.0 (January 21st, 2003)
         - Full regression testing for all U320 products completed.
         - Added abort and target/lun reset error recovery handler and
           interrupt coalescing.
 
-   1.2.0 (November 14th, 2002)
+ * 1.2.0 (November 14th, 2002)
         - Added support for Domain Validation
         - Add support for the Hewlett-Packard version of the 39320D
           and AIC-7902 adapters.
+
         Support for previous adapters has not been fully tested and should
         only be used at the customer's own risk.
 
-   1.1.1 (September 24th, 2002)
+ * 1.1.1 (September 24th, 2002)
         - Added support for the Linux 2.5.X kernel series
 
-   1.1.0 (September 17th, 2002)
+ * 1.1.0 (September 17th, 2002)
         - Added support for four additional SCSI products:
           ASC-39320, ASC-29320, ASC-29320LP, AIC-7901.
 
-   1.0.0 (May 30th, 2002)
+ * 1.0.0 (May 30th, 2002)
         - Initial driver release.
 
-   2.1. Software/Hardware Features
+ * 2.1. Software/Hardware Features
         - Support for the SPI-4 "Ultra320" standard:
           - 320MB/s transfer rates
           - Packetized SCSI Protocol at 160MB/s and 320MB/s
           - Quick Arbitration Selection (QAS)
           - Retained Training Information (Rev B. ASIC only)
         - Interrupt Coalescing
-        - Initiator Mode (target mode not currently 
+        - Initiator Mode (target mode not currently
           supported)
         - Support for the PCI-X standard up to 133MHz
         - Support for the PCI v2.2 standard
         - Domain Validation
 
-   2.2. Operating System Support:
+ * 2.2. Operating System Support:
         - Redhat Linux 7.2, 7.3, 8.0, Advanced Server 2.1
         - SuSE Linux 7.3, 8.0, 8.1, Enterprise Server 7
         - only Intel and AMD x86 supported at this time
@@ -210,197 +221,278 @@ The following information is available in this file:
      Refer to the User's Guide for more details on this.
 
 3. Command Line Options
+=======================
 
-        WARNING: ALTERING OR ADDING THESE DRIVER PARAMETERS
+    .. Warning::
+
+	         ALTERING OR ADDING THESE DRIVER PARAMETERS
                  INCORRECTLY CAN RENDER YOUR SYSTEM INOPERABLE.
-                 USE THEM WITH CAUTION. 
+                 USE THEM WITH CAUTION.
 
    Put a .conf file in the /etc/modprobe.d/ directory and add/edit a
-   line containing 'options aic79xx aic79xx=[command[,command...]]' where
-   'command' is one or more of the following:
-   -----------------------------------------------------------------
-              Option: verbose
-          Definition: enable additional informative messages during
-                      driver operation.
-     Possible Values: This option is a flag
-       Default Value: disabled
-   -----------------------------------------------------------------
-              Option: debug:[value]
-          Definition: Enables various levels of debugging information
-                      The bit definitions for the debugging mask can
-                      be found in drivers/scsi/aic7xxx/aic79xx.h under
-                      the "Debug" heading.
-     Possible Values: 0x0000 = no debugging, 0xffff = full debugging
-       Default Value: 0x0000
-   -----------------------------------------------------------------
-              Option: no_reset
-          Definition: Do not reset the bus during the initial probe
-                      phase
-     Possible Values: This option is a flag
-       Default Value: disabled
-   -----------------------------------------------------------------
-              Option: extended
-          Definition: Force extended translation on the controller
-     Possible Values: This option is a flag
-       Default Value: disabled
-   -----------------------------------------------------------------
-              Option: periodic_otag
-          Definition: Send an ordered tag periodically to prevent
-                      tag starvation.  Needed for some older devices
-     Possible Values: This option is a flag
-       Default Value: disabled
-   -----------------------------------------------------------------
-              Option: reverse_scan
-          Definition: Probe the scsi bus in reverse order, starting
-                      with target 15
-     Possible Values: This option is a flag
-       Default Value: disabled
-   -----------------------------------------------------------------
-              Option: global_tag_depth
-          Definition: Global tag depth for all targets on all busses.
-                      This option sets the default tag depth which
-                      may be selectively overridden vi the tag_info
-                      option.
-     Possible Values: 1 - 253
-       Default Value: 32
-   -----------------------------------------------------------------
-              Option: tag_info:{{value[,value...]}[,{value[,value...]}...]}
-          Definition: Set the per-target tagged queue depth on a
-                      per controller basis.  Both controllers and targets
-                      may be omitted indicating that they should retain
-                      the default tag depth.
-            Examples: tag_info:{{16,32,32,64,8,8,,32,32,32,32,32,32,32,32,32}
-                        On Controller 0
-                          specifies a tag depth of 16 for target 0
-                          specifies a tag depth of 64 for target 3
-                          specifies a tag depth of 8 for targets 4 and 5
-                          leaves target 6 at the default
-                          specifies a tag depth of 32 for targets 1,2,7-15
-                        All other targets retain the default depth.
-
-                      tag_info:{{},{32,,32}}
-                        On Controller 1
-                          specifies a tag depth of 32 for targets 0 and 2
-                        All other targets retain the default depth.
-                        
-     Possible Values: 1 - 253
-       Default Value: 32
-   -----------------------------------------------------------------
-              Option: rd_strm: {rd_strm_bitmask[,rd_strm_bitmask...]}
-          Definition: Enable read streaming on a per target basis.
-                      The rd_strm_bitmask is a 16 bit hex value in which
-                      each bit represents a target.  Setting the target's
-                      bit to '1' enables read streaming for that
-                      target.  Controllers may be omitted indicating that
-                      they should retain the default read streaming setting.
-             Example: rd_strm:{0x0041}
-                        On Controller 0
-                          enables read streaming for targets 0 and 6.
-                          disables read streaming for targets 1-5,7-15.
-                        All other targets retain the default read
-                        streaming setting.
-             Example: rd_strm:{0x0023,,0xFFFF}
-                        On Controller 0
-                          enables read streaming for targets 1,2, and 5.
-                          disables read streaming for targets 3,4,6-15.
-                        On Controller 2
-                          enables read streaming for all targets.
-                        All other targets retain the default read
-                        streaming setting.
-                      
-     Possible Values: 0x0000 - 0xffff
-       Default Value: 0x0000
-   -----------------------------------------------------------------
-              Option: dv: {value[,value...]}
-          Definition: Set Domain Validation Policy on a per-controller basis.
-                      Controllers may be omitted indicating that
-                      they should retain the default read streaming setting.
-             Example: dv:{-1,0,,1,1,0}
-                        On Controller 0 leave DV at its default setting.
-                        On Controller 1 disable DV.
-                        Skip configuration on Controller 2.
-                        On Controllers 3 and 4 enable DV.
-                        On Controller 5 disable DV.
-
-     Possible Values: < 0 Use setting from serial EEPROM.
-                      0 Disable DV
-                      > 0 Enable DV
-       Default Value: DV Serial EEPROM configuration setting.
-   -----------------------------------------------------------------
-              Option: seltime:[value]
-          Definition: Specifies the selection timeout value
-     Possible Values: 0 = 256ms, 1 = 128ms, 2 = 64ms, 3 = 32ms
-       Default Value: 0
-   -----------------------------------------------------------------
-
-   *** The following three options should only be changed at ***
-   *** the direction of a technical support representative.  ***
-
-   -----------------------------------------------------------------
-              Option: precomp: {value[,value...]}
-          Definition: Set IO Cell precompensation value on a per-controller
-                      basis.
-                      Controllers may be omitted indicating that
-                      they should retain the default precompensation setting.
-             Example: precomp:{0x1}
-                        On Controller 0 set precompensation to 1.
-             Example: precomp:{1,,7}
-                        On Controller 0 set precompensation to 1.
-                        On Controller 2 set precompensation to 8.
-                      
-     Possible Values: 0 - 7
-       Default Value: Varies based on chip revision
-   -----------------------------------------------------------------
-              Option: slewrate: {value[,value...]}
-          Definition: Set IO Cell slew rate on a per-controller basis.
+   line containing ``options aic79xx aic79xx=[command[,command...]]`` where
+   ``command`` is one or more of the following:
+
+
+verbose
+    :Definition: enable additional informative messages during driver operation.
+    :Possible Values: This option is a flag
+    :Default Value: disabled
+
+debug:[value]
+    :Definition: Enables various levels of debugging information
+                 The bit definitions for the debugging mask can
+                 be found in drivers/scsi/aic7xxx/aic79xx.h under
+                 the "Debug" heading.
+    :Possible Values: 0x0000 = no debugging, 0xffff = full debugging
+    :Default Value: 0x0000
+
+no_reset
+    :Definition: Do not reset the bus during the initial probe
+                 phase
+    :Possible Values: This option is a flag
+    :Default Value: disabled
+
+extended
+    :Definition: Force extended translation on the controller
+    :Possible Values: This option is a flag
+    :Default Value: disabled
+
+periodic_otag
+    :Definition: Send an ordered tag periodically to prevent
+                 tag starvation.  Needed for some older devices
+    :Possible Values: This option is a flag
+    :Default Value: disabled
+
+reverse_scan
+    :Definition: Probe the scsi bus in reverse order, starting with target 15
+    :Possible Values: This option is a flag
+    :Default Value: disabled
+
+global_tag_depth
+    :Definition: Global tag depth for all targets on all busses.
+		 This option sets the default tag depth which
+		 may be selectively overridden vi the tag_info
+		 option.
+
+    :Possible Values: 1 - 253
+    :Default Value: 32
+
+tag_info:{{value[,value...]}[,{value[,value...]}...]}
+    :Definition: Set the per-target tagged queue depth on a
+                 per controller basis.  Both controllers and targets
+                 may be omitted indicating that they should retain
+                 the default tag depth.
+
+    :Possible Values: 1 - 253
+    :Default Value: 32
+
+    Examples:
+
+
+	::
+
+	    tag_info:{{16,32,32,64,8,8,,32,32,32,32,32,32,32,32,32}
+
+	On Controller 0
+
+	    - specifies a tag depth of 16 for target 0
+	    - specifies a tag depth of 64 for target 3
+	    - specifies a tag depth of 8 for targets 4 and 5
+	    - leaves target 6 at the default
+	    - specifies a tag depth of 32 for targets 1,2,7-15
+
+	All other targets retain the default depth.
+
+	::
+
+	    tag_info:{{},{32,,32}}
+
+	On Controller 1
+
+	    - specifies a tag depth of 32 for targets 0 and 2
+
+	All other targets retain the default depth.
+
+
+rd_strm: {rd_strm_bitmask[,rd_strm_bitmask...]}
+    :Definition: Enable read streaming on a per target basis.
+		 The rd_strm_bitmask is a 16 bit hex value in which
+		 each bit represents a target.  Setting the target's
+		 bit to '1' enables read streaming for that
+		 target.  Controllers may be omitted indicating that
+		 they should retain the default read streaming setting.
+
+    Examples:
+
+	    ::
+
+		rd_strm:{0x0041}
+
+	    On Controller 0
+
+		- enables read streaming for targets 0 and 6.
+		- disables read streaming for targets 1-5,7-15.
+
+	    All other targets retain the default read
+	    streaming setting.
+
+	    ::
+
+		rd_strm:{0x0023,,0xFFFF}
+
+	    On Controller 0
+
+		- enables read streaming for targets 1,2, and 5.
+		- disables read streaming for targets 3,4,6-15.
+
+	    On Controller 2
+
+		- enables read streaming for all targets.
+
+	    All other targets retain the default read
+	    streaming setting.
+
+    :Possible Values: 0x0000 - 0xffff
+    :Default Value: 0x0000
+
+dv: {value[,value...]}
+    :Definition: Set Domain Validation Policy on a per-controller basis.
+                 Controllers may be omitted indicating that
+                 they should retain the default read streaming setting.
+
+     :Possible Values:
+
+		      ==== ===============================
+		       < 0 Use setting from serial EEPROM.
+                         0 Disable DV
+		       > 0 Enable DV
+		      ==== ===============================
+
+    :Default Value: DV Serial EEPROM configuration setting.
+
+    Example:
+
+	::
+
+	    dv:{-1,0,,1,1,0}
+
+	- On Controller 0 leave DV at its default setting.
+	- On Controller 1 disable DV.
+	- Skip configuration on Controller 2.
+	- On Controllers 3 and 4 enable DV.
+	- On Controller 5 disable DV.
+
+seltime:[value]
+    :Definition: Specifies the selection timeout value
+    :Possible Values: 0 = 256ms, 1 = 128ms, 2 = 64ms, 3 = 32ms
+    :Default Value: 0
+
+.. Warning:
+
+    The following three options should only be changed at
+    the direction of a technical support representative.
+
+
+precomp: {value[,value...]}
+    :Definition: Set IO Cell precompensation value on a per-controller basis.
+                 Controllers may be omitted indicating that
+                 they should retain the default precompensation setting.
+
+    :Possible Values: 0 - 7
+    :Default Value: Varies based on chip revision
+
+    Examples:
+
+	::
+
+	    precomp:{0x1}
+
+	On Controller 0 set precompensation to 1.
+
+	::
+
+	    precomp:{1,,7}
+
+	- On Controller 0 set precompensation to 1.
+	- On Controller 2 set precompensation to 8.
+
+slewrate: {value[,value...]}
+    :Definition: Set IO Cell slew rate on a per-controller basis.
                       Controllers may be omitted indicating that
                       they should retain the default slew rate setting.
-             Example: slewrate:{0x1}
-                        On Controller 0 set slew rate to 1.
-             Example: slewrate :{1,,8}
-                        On Controller 0 set slew rate to 1.
-                        On Controller 2 set slew rate to 8.
-                      
-     Possible Values: 0 - 15
-       Default Value: Varies based on chip revision
-   -----------------------------------------------------------------
-              Option: amplitude: {value[,value...]}
-          Definition: Set IO Cell signal amplitude on a per-controller basis.
-                      Controllers may be omitted indicating that
-                      they should retain the default read streaming setting.
-             Example: amplitude:{0x1}
-                        On Controller 0 set amplitude to 1.
-             Example: amplitude :{1,,7}
-                        On Controller 0 set amplitude to 1.
-                        On Controller 2 set amplitude to 7.
-                      
-     Possible Values: 1 - 7
-       Default Value: Varies based on chip revision
-   -----------------------------------------------------------------
-
-   Example: 'options aic79xx aic79xx=verbose,rd_strm:{{0x0041}}'
-        enables verbose output in the driver and turns read streaming on
-        for targets 0 and 6 of Controller 0.
+
+    :Possible Values: 0 - 15
+    :Default Value: Varies based on chip revision
+
+    Examples:
+
+	::
+
+	    slewrate:{0x1}
+
+	- On Controller 0 set slew rate to 1.
+
+	::
+
+	    slewrate :{1,,8}
+
+	- On Controller 0 set slew rate to 1.
+	- On Controller 2 set slew rate to 8.
+
+amplitude: {value[,value...]}
+    :Definition: Set IO Cell signal amplitude on a per-controller basis.
+                 Controllers may be omitted indicating that
+                 they should retain the default read streaming setting.
+
+    :Possible Values: 1 - 7
+    :Default Value: Varies based on chip revision
+
+    Examples:
+
+    ::
+
+	amplitude:{0x1}
+
+    On Controller 0 set amplitude to 1.
+
+    ::
+
+	amplitude :{1,,7}
+
+    - On Controller 0 set amplitude to 1.
+    - On Controller 2 set amplitude to 7.
+
+Example::
+
+    options aic79xx aic79xx=verbose,rd_strm:{{0x0041}}
+
+enables verbose output in the driver and turns read streaming on
+for targets 0 and 6 of Controller 0.
 
 4. Additional Notes
+===================
 
-   4.1. Known/Unresolved or FYI Issues
+4.1. Known/Unresolved or FYI Issues
+-----------------------------------
 
         * Under SuSE Linux Enterprise 7, the driver may fail to operate
           correctly due to a problem with PCI interrupt routing in the
           Linux kernel.  Please contact SuSE for an updated Linux
           kernel.
 
-   4.2. Third-Party Compatibility Issues
+4.2. Third-Party Compatibility Issues
+-------------------------------------
 
         * Adaptec only supports Ultra320 hard drives running
           the latest firmware available. Please check with
           your hard drive manufacturer to ensure you have the
           latest version.
 
-   4.3. Operating System or Technology Limitations
-        
-        * PCI Hot Plug is untested and may cause the operating system 
+4.3. Operating System or Technology Limitations
+-----------------------------------------------
+
+        * PCI Hot Plug is untested and may cause the operating system
           to stop responding.
         * Luns that are not numbered contiguously starting with 0 might not
           be automatically probed during system startup.  This is a limitation
@@ -417,30 +509,34 @@ The following information is available in this file:
 
 
 5. Adaptec Customer Support
+===========================
 
-   A Technical Support Identification (TSID) Number is required for 
+   A Technical Support Identification (TSID) Number is required for
    Adaptec technical support.
+
     - The 12-digit TSID can be found on the white barcode-type label
-      included inside the box with your product.  The TSID helps us 
-      provide more efficient service by accurately identifying your 
+      included inside the box with your product.  The TSID helps us
+      provide more efficient service by accurately identifying your
       product and support status.
 
    Support Options
     - Search the Adaptec Support Knowledgebase (ASK) at
       http://ask.adaptec.com for articles, troubleshooting tips, and
       frequently asked questions about your product.
-    - For support via Email, submit your question to Adaptec's 
+    - For support via Email, submit your question to Adaptec's
       Technical Support Specialists at http://ask.adaptec.com/.
-     
+
    North America
     - Visit our Web site at http://www.adaptec.com/.
     - For information about Adaptec's support options, call
       408-957-2550, 24 hours a day, 7 days a week.
     - To speak with a Technical Support Specialist,
+
       * For hardware products, call 408-934-7274,
         Monday to Friday, 3:00 am to 5:00 pm, PDT.
       * For RAID and Fibre Channel products, call 321-207-2000,
         Monday to Friday, 3:00 am to 5:00 pm, PDT.
+
       To expedite your service, have your computer with you.
     - To order Adaptec products, including accessories and cables,
       call 408-957-7274.  To order cables online go to
@@ -449,49 +545,49 @@ The following information is available in this file:
    Europe
     - Visit our Web site at http://www.adaptec.com/en-US/_common/world_index.
     - To speak with a Technical Support Specialist, call, or email,
+
       * German:  +49 89 4366 5522, Monday-Friday, 9:00-17:00 CET,
         http://ask-de.adaptec.com/.
       * French:  +49 89 4366 5533, Monday-Friday, 9:00-17:00 CET,
 	http://ask-fr.adaptec.com/.
       * English: +49 89 4366 5544, Monday-Friday, 9:00-17:00 GMT,
 	http://ask.adaptec.com/.
+
     - You can order Adaptec cables online at
       http://www.adaptec.com/buy-cables/.
 
    Japan
     - Visit our web site at http://www.adaptec.co.jp/.
-    - To speak with a Technical Support Specialist, call 
+    - To speak with a Technical Support Specialist, call
       +81 3 5308 6120, Monday-Friday, 9:00 a.m. to 12:00 p.m.,
       1:00 p.m. to 6:00 p.m.
 
--------------------------------------------------------------------
-/*
- * Copyright (c) 2003 Adaptec Inc. 691 S. Milpitas Blvd., Milpitas CA 95035 USA.
- * All rights reserved.
- *
- * You are permitted to redistribute, use and modify this README file in whole
- * or in part in conjunction with redistribution of software governed by the
- * General Public License, provided that the following conditions are met:
- * 1. Redistributions of README file must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. The name of the author may not be used to endorse or promote products
- *    derived from this software without specific prior written permission.
- * 3. Modifications or new contributions must be attributed in a copyright
- *    notice identifying the author ("Contributor") and added below the
- *    original copyright notice. The copyright notice is for purposes of
- *    identifying contributors and should not be deemed as permission to alter
- *    the permissions given by Adaptec.
- *
- * THIS README FILE IS PROVIDED BY ADAPTEC AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, ANY
- * WARRANTIES OF NON-INFRINGEMENT OR THE IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
- * ADAPTEC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
- * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS README
- * FILE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
+Copyright |copy| 2003 Adaptec Inc. 691 S. Milpitas Blvd., Milpitas CA 95035 USA.
+All rights reserved.
+
+You are permitted to redistribute, use and modify this README file in whole
+or in part in conjunction with redistribution of software governed by the
+General Public License, provided that the following conditions are met:
+
+1. Redistributions of README file must retain the above copyright
+   notice, this list of conditions, and the following disclaimer,
+   without modification.
+2. The name of the author may not be used to endorse or promote products
+   derived from this software without specific prior written permission.
+3. Modifications or new contributions must be attributed in a copyright
+   notice identifying the author ("Contributor") and added below the
+   original copyright notice. The copyright notice is for purposes of
+   identifying contributors and should not be deemed as permission to alter
+   the permissions given by Adaptec.
+
+THIS README FILE IS PROVIDED BY ADAPTEC AND CONTRIBUTORS ``AS IS`` AND
+ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, ANY
+WARRANTIES OF NON-INFRINGEMENT OR THE IMPLIED WARRANTIES OF MERCHANTABILITY
+AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ADAPTEC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
+TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS README
+FILE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 8404e991b588..b7fdfc0cb956 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -11,5 +11,6 @@ Linux SCSI Subsystem
    aacraid
    advansys
    aha152x
+   aic79xx
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/scsi-parameters.txt b/Documentation/scsi/scsi-parameters.txt
index 064d6dfcac26..8ed9c662a1d4 100644
--- a/Documentation/scsi/scsi-parameters.txt
+++ b/Documentation/scsi/scsi-parameters.txt
@@ -25,7 +25,7 @@ parameters may be changed at runtime by the command
 			See Documentation/scsi/aic7xxx.txt.
 
 	aic79xx=	[HW,SCSI]
-			See Documentation/scsi/aic79xx.txt.
+			See Documentation/scsi/aic79xx.rst.
 
 	atascsi=	[HW,SCSI]
 			See drivers/scsi/atari_scsi.c.
diff --git a/drivers/scsi/aic7xxx/Kconfig.aic79xx b/drivers/scsi/aic7xxx/Kconfig.aic79xx
index 16743fb9eead..d4c50b8fce29 100644
--- a/drivers/scsi/aic7xxx/Kconfig.aic79xx
+++ b/drivers/scsi/aic7xxx/Kconfig.aic79xx
@@ -32,7 +32,7 @@ config AIC79XX_CMDS_PER_DEVICE
 	on some devices.  The upper bound is 253.  0 disables tagged queueing.
 
 	Per device tag depth can be controlled via the kernel command line
-	"tag_info" option.  See Documentation/scsi/aic79xx.txt for details.
+	"tag_info" option.  See Documentation/scsi/aic79xx.rst for details.
 
 config AIC79XX_RESET_DELAY_MS
 	int "Initial bus reset delay in milli-seconds"
-- 
2.21.1

