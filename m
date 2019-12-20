Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2F127968
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 11:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfLTKc1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 05:32:27 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39073 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfLTKc0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Dec 2019 05:32:26 -0500
Received: by mail-pl1-f182.google.com with SMTP id g6so966416plp.6
        for <linux-scsi@vger.kernel.org>; Fri, 20 Dec 2019 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FGhoDrm5LlSTCqbDElMc3SFvAISmG3NJrSEhNWEkzko=;
        b=A9GAVaz8PxIGqav+C2+pFnRqli6JrZNhqiJ7Z9NvOZQCy6UV3uXz6XK0TSfd41t6eV
         ZKDIm/S4EsP7hTc667eajkh8+P2lVF7ajq4lBdHDKaxLN1xvOjkYxOgKal2Lk3F6vP3j
         CwygcRrqnbQo0VsEnnj36UDlxTehHrhltthZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FGhoDrm5LlSTCqbDElMc3SFvAISmG3NJrSEhNWEkzko=;
        b=EtzE57AFLSEOmTpxzXhZcOsZZ4hopiEDJ6BpJ5CIC6O0hDicz4syWWaKsc2GZLNXse
         2U6TZfadMhZ4soJFWZOGNUq7FpnhcgLNmE+/RCOb0CUQRpFf77wtWh6+MtfmltZjx6v4
         UfPZdSgL/AUREoB+1QuaiX9vCIwxDL/OkJ30Z23WY0WrBQHDyuyCIc+Ag9xMvDm8NWjE
         srtWBDjHToKd//CO5fpxvxNpxwpXwi3D5tFI89VMR6WDAv53ksne2+iiZ87E6OtacTgk
         Od5ZkEFS9+DIYCDz5qEQcPz7Z4oXuDaxoHJ3IxHm/UiGShH9eIpYYxoJpbg38wLgXKoU
         jrJQ==
X-Gm-Message-State: APjAAAXhcYKPRa8UsSPNWHjaam8CZf2XAgbUZOPN4xai7/xc6ZlX1i9n
        TrlJ2olmeOuFDJFstvB4LxnXBlEwVjeOsKLF8lmzWimjCAT6lpuuxGtyzvfKdF+oG98JuO+DAYo
        vS0qaDkZI1DygYG0wxKTveIf9NrmPaY7NFsRTnlUPW6JhI5ixm64cFvYYUMTYsbabgyUnohQZEG
        71XQ5rbISES+hH2Nk8DA==
X-Google-Smtp-Source: APXvYqxP2ndPxUb6CSQ6wDi4NcHoaPzKh1hOUgd4yi4f/5Aldd2yg1s0LvkjP7AyV+vvwqmCYKnT4Q==
X-Received: by 2002:a17:90a:7f89:: with SMTP id m9mr15269735pjl.143.1576837945275;
        Fri, 20 Dec 2019 02:32:25 -0800 (PST)
Received: from dhcp-10-123-20-125.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 200sm12185364pfz.121.2019.12.20.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 02:32:24 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     sreekanth.reddy@broadcom.com, sathya.prakash@broadcom.com,
        kashyap.desai@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 01/10] mpt3sas: Update MPI Headers to v02.00.57
Date:   Fri, 20 Dec 2019 05:32:01 -0500
Message-Id: <20191220103210.43631-2-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20191220103210.43631-1-suganath-prabu.subramani@broadcom.com>
References: <20191220103210.43631-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update MPI Headers to version 02.00.57.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpi/mpi2.h       |  6 +++++-
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  | 19 +++++++++++++++----
 drivers/scsi/mpt3sas/mpi/mpi2_image.h |  7 +++++++
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h   |  8 +++++++-
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2.h b/drivers/scsi/mpt3sas/mpi/mpi2.h
index 18b1e31..ed3923f 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2.h
@@ -122,6 +122,9 @@
  * 08-28-18  02.00.53  Bumped MPI2_HEADER_VERSION_UNIT.
  *                     Added MPI2_IOCSTATUS_FAILURE
  * 12-17-18  02.00.54  Bumped MPI2_HEADER_VERSION_UNIT
+ * 06-24-19  02.00.55  Bumped MPI2_HEADER_VERSION_UNIT
+ * 08-01-19  02.00.56  Bumped MPI2_HEADER_VERSION_UNIT
+ * 10-02-19  02.00.57  Bumped MPI2_HEADER_VERSION_UNIT
  *  --------------------------------------------------------------------------
  */
 
@@ -162,7 +165,7 @@
 
 
 /* Unit and Dev versioning for this MPI header set */
-#define MPI2_HEADER_VERSION_UNIT            (0x36)
+#define MPI2_HEADER_VERSION_UNIT            (0x39)
 #define MPI2_HEADER_VERSION_DEV             (0x00)
 #define MPI2_HEADER_VERSION_UNIT_MASK       (0xFF00)
 #define MPI2_HEADER_VERSION_UNIT_SHIFT      (8)
@@ -181,6 +184,7 @@
 #define MPI2_IOC_STATE_READY               (0x10000000)
 #define MPI2_IOC_STATE_OPERATIONAL         (0x20000000)
 #define MPI2_IOC_STATE_FAULT               (0x40000000)
+#define MPI2_IOC_STATE_COREDUMP            (0x50000000)
 
 #define MPI2_IOC_STATE_MASK                (0xF0000000)
 #define MPI2_IOC_STATE_SHIFT               (28)
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index 3a6871a..43a3bf8 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -249,6 +249,8 @@
  * 08-28-18  02.00.46  Added NVMs Write Cache flag to IOUnitPage1
  *                     Added DMDReport Delay Time defines to PCIeIOUnitPage1
  * 12-17-18  02.00.47  Swap locations of Slotx2 and Slotx4 in ManPage 7.
+ * 08-01-19  02.00.49  Add MPI26_MANPAGE7_FLAG_X2_X4_SLOT_INFO_VALID
+ *                     Add MPI26_IOUNITPAGE1_NVME_WRCACHE_SHIFT
  */
 
 #ifndef MPI2_CNFG_H
@@ -891,6 +893,8 @@ typedef struct _MPI2_CONFIG_PAGE_MAN_7 {
 #define MPI2_MANPAGE7_FLAG_EVENTREPLAY_SLOT_ORDER       (0x00000002)
 #define MPI2_MANPAGE7_FLAG_USE_SLOT_INFO                (0x00000001)
 
+#define MPI26_MANPAGE7_FLAG_CONN_LANE_USE_PINOUT        (0x00000020)
+#define MPI26_MANPAGE7_FLAG_X2_X4_SLOT_INFO_VALID       (0x00000010)
 
 /*
  *Generic structure to use for product-specific manufacturing pages
@@ -962,9 +966,10 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_1 {
 
 /* IO Unit Page 1 Flags defines */
 #define MPI26_IOUNITPAGE1_NVME_WRCACHE_MASK             (0x00030000)
-#define MPI26_IOUNITPAGE1_NVME_WRCACHE_ENABLE           (0x00000000)
-#define MPI26_IOUNITPAGE1_NVME_WRCACHE_DISABLE          (0x00010000)
-#define MPI26_IOUNITPAGE1_NVME_WRCACHE_NO_CHANGE        (0x00020000)
+#define MPI26_IOUNITPAGE1_NVME_WRCACHE_SHIFT            (16)
+#define MPI26_IOUNITPAGE1_NVME_WRCACHE_NO_CHANGE        (0x00000000)
+#define MPI26_IOUNITPAGE1_NVME_WRCACHE_ENABLE           (0x00010000)
+#define MPI26_IOUNITPAGE1_NVME_WRCACHE_DISABLE          (0x00020000)
 #define MPI2_IOUNITPAGE1_ATA_SECURITY_FREEZE_LOCK       (0x00004000)
 #define MPI25_IOUNITPAGE1_NEW_DEVICE_FAST_PATH_DISABLE  (0x00002000)
 #define MPI25_IOUNITPAGE1_DISABLE_FAST_PATH             (0x00001000)
@@ -3931,7 +3936,13 @@ typedef struct _MPI26_CONFIG_PAGE_PCIEDEV_2 {
 	U32	MaximumDataTransferSize;	/*0x0C */
 	U32	Capabilities;		/*0x10 */
 	U16	NOIOB;		/* 0x14 */
-	U16	Reserved2;		/* 0x16 */
+	U16     ShutdownLatency;        /* 0x16 */
+	U16     VendorID;               /* 0x18 */
+	U16     DeviceID;               /* 0x1A */
+	U16     SubsystemVendorID;      /* 0x1C */
+	U16     SubsystemID;            /* 0x1E */
+	U8      RevisionID;             /* 0x20 */
+	U8      Reserved21[3];          /* 0x21 */
 } MPI26_CONFIG_PAGE_PCIEDEV_2, *PTR_MPI26_CONFIG_PAGE_PCIEDEV_2,
 	Mpi26PCIeDevicePage2_t, *pMpi26PCIeDevicePage2_t;
 
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_image.h b/drivers/scsi/mpt3sas/mpi/mpi2_image.h
index a3f6778..33b9c3a 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_image.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_image.h
@@ -19,6 +19,10 @@
  * 09-07-18  02.06.03  Added MPI26_EVENT_PCIE_TOPO_PI_16_LANES
  * 12-17-18  02.06.04  Addd MPI2_EXT_IMAGE_TYPE_PBLP
  *			Shorten some defines to be compatible with DOS
+ * 06-24-19  02.06.05  Whitespace adjustments to help with identifier
+ *			checking tool.
+ * 10-02-19  02.06.06  Added MPI26_IMAGE_HEADER_SIG1_COREDUMP
+ *                     Added MPI2_FLASH_REGION_COREDUMP
  */
 #ifndef MPI2_IMAGE_H
 #define MPI2_IMAGE_H
@@ -213,6 +217,8 @@ typedef struct _MPI26_COMPONENT_IMAGE_HEADER {
 #define MPI26_IMAGE_HEADER_SIG1_NVDATA                   (0x5444564E)
 #define MPI26_IMAGE_HEADER_SIG1_GAS_GAUGE                (0x20534147)
 #define MPI26_IMAGE_HEADER_SIG1_PBLP                     (0x504C4250)
+/* little-endian "DUMP" */
+#define MPI26_IMAGE_HEADER_SIG1_COREDUMP                 (0x504D5544)
 
 /**** Definitions for Signature2 field ****/
 #define MPI26_IMAGE_HEADER_SIGNATURE2_VALUE                    (0x50584546)
@@ -359,6 +365,7 @@ typedef struct _MPI2_FLASH_LAYOUT_DATA {
 #define MPI2_FLASH_REGION_MR_NVDATA             (0x14)
 #define MPI2_FLASH_REGION_CPLD                  (0x15)
 #define MPI2_FLASH_REGION_PSOC                  (0x16)
+#define MPI2_FLASH_REGION_COREDUMP              (0x17)
 
 /*ImageRevision */
 #define MPI2_FLASH_LAYOUT_IMAGE_REVISION        (0x00)
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h b/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h
index 68ea408..e83c7c5 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h
@@ -175,6 +175,10 @@
  *                     Moved FW image definitions ionto new mpi2_image,h
  * 08-14-18   02.00.36 Fixed definition of MPI2_FW_DOWNLOAD_ITYPE_PSOC (0x16)
  * 09-07-18   02.00.37 Added MPI26_EVENT_PCIE_TOPO_PI_16_LANES
+ * 10-02-19   02.00.38 Added MPI26_IOCINIT_CFGFLAGS_COREDUMP_ENABLE
+ *                     Added MPI26_IOCFACTS_CAPABILITY_COREDUMP_ENABLED
+ *                     Added MPI2_FW_DOWNLOAD_ITYPE_COREDUMP
+ *                     Added MPI2_FW_UPLOAD_ITYPE_COREDUMP
  * --------------------------------------------------------------------------
  */
 
@@ -248,6 +252,7 @@ typedef struct _MPI2_IOC_INIT_REQUEST {
 
 /*ConfigurationFlags */
 #define MPI26_IOCINIT_CFGFLAGS_NVME_SGL_FORMAT  (0x0001)
+#define MPI26_IOCINIT_CFGFLAGS_COREDUMP_ENABLE  (0x0002)
 
 /*minimum depth for a Reply Descriptor Post Queue */
 #define MPI2_RDPQ_DEPTH_MIN                     (16)
@@ -377,6 +382,7 @@ typedef struct _MPI2_IOC_FACTS_REPLY {
 /*ProductID field uses MPI2_FW_HEADER_PID_ */
 
 /*IOCCapabilities */
+#define MPI26_IOCFACTS_CAPABILITY_COREDUMP_ENABLED      (0x00200000)
 #define MPI26_IOCFACTS_CAPABILITY_PCIE_SRIOV            (0x00100000)
 #define MPI26_IOCFACTS_CAPABILITY_ATOMIC_REQ            (0x00080000)
 #define MPI2_IOCFACTS_CAPABILITY_RDPQ_ARRAY_CAPABLE     (0x00040000)
@@ -1458,8 +1464,8 @@ typedef struct _MPI2_FW_DOWNLOAD_REQUEST {
 /*MPI v2.6 and newer */
 #define MPI2_FW_DOWNLOAD_ITYPE_CPLD                 (0x15)
 #define MPI2_FW_DOWNLOAD_ITYPE_PSOC                 (0x16)
+#define MPI2_FW_DOWNLOAD_ITYPE_COREDUMP             (0x17)
 #define MPI2_FW_DOWNLOAD_ITYPE_MIN_PRODUCT_SPECIFIC (0xF0)
-#define MPI2_FW_DOWNLOAD_ITYPE_TERMINATE            (0xFF)
 
 /*MPI v2.0 FWDownload TransactionContext Element */
 typedef struct _MPI2_FW_DOWNLOAD_TCSGE {
-- 
2.18.1

