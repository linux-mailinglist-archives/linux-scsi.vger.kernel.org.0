Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0898066F
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391038AbfHCOAU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:20 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43077 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfHCOAU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:20 -0400
Received: by mail-pf1-f182.google.com with SMTP id i189so37430289pfg.10
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fzp+d3FnBlvBe0Zqb+mhGXKaWVGRNrQqQAg82JCQoTU=;
        b=PXjfrHj6I3IRvAWH9FVNB1eCo7o7jxNXIs8CkLky/xTvmL0nMVWDdfx8eP+1VZ0qf8
         jr6kGFPu2l5wPgx2RT7BYj5n4u9HgYF+qoZbUA7kSJtv16chwGqxY9t0bDifBD9abDko
         jryKSqtdHarmNDDUWSUxVxRc/hosW7nq/TdBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fzp+d3FnBlvBe0Zqb+mhGXKaWVGRNrQqQAg82JCQoTU=;
        b=ccKGyC52a2AofPP1KZTFnQMgppypAfDXG3f34494IxpCL7Iud1Sz623TDVezS4gYck
         5M4C247nT8B2n0hgCm3vF0cyedvQwowI6aXPljsnYMBuD703/6txIkerii5Kh5uk7Ifs
         YpthbqaDlPDJeev+1RTsEn3VXQ8RxpuagcBA2viMjjNhcOv5i6THS3szPV7nSPkkCBCm
         f/yNDoXonhTfmoBoUhs+x7WMOkr5mrd1naoQwpAp9lHHiPjJ3IanzbDDxiXItP6MH9e1
         v07msKn2zI9ur9PFCVMGPIejNALwas+po8dGOH0Z/1/l7Gf5T0nOXrSBcwJ/Wf1evg/y
         umtw==
X-Gm-Message-State: APjAAAUADtCt3IFBsijHbRXnCrm4RZ6ctosqyxEvLzGKCvtDcpxJHfrM
        XtHP9d7Fu0veionWQlsWmxGXrLLO1q3pk2eJ/eC0pqgI4TAWqepHXph4r48tecnoi7OZEuvtlUl
        Erwxo0+YRJk51EknvVqrF8B8VvGRUJnk6EjyxCrcgXDkem5rUZ5gP7IdbZCJCkWUEwRKw2StFfh
        YbuQg0UiZR6GiSakuuBA==
X-Google-Smtp-Source: APXvYqy0DJTVcx3p21HCd024mq2/Ge6waUzq2vtOvtFoKG8TE8UoQjVkgVHt27HXh3m6ASbGCTGSCw==
X-Received: by 2002:a63:6947:: with SMTP id e68mr93254050pgc.60.1564840819144;
        Sat, 03 Aug 2019 07:00:19 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:18 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 04/12] mpt3sas: Update MPI headers to 2.6.8 spec
Date:   Sat,  3 Aug 2019 09:59:49 -0400
Message-Id: <1564840797-5876-5-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Updated MPI to 2.6.8 specification and header files to 2.00.54.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpi/mpi2.h       |  5 +++--
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  | 10 +++++++--
 drivers/scsi/mpt3sas/mpi/mpi2_image.h | 39 +++++++++++++++++++----------------
 drivers/scsi/mpt3sas/mpi/mpi2_pci.h   | 13 ++++++------
 drivers/scsi/mpt3sas/mpi/mpi2_tool.h  | 13 ++++++------
 5 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2.h b/drivers/scsi/mpt3sas/mpi/mpi2.h
index 7efd17a..18b1e31 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2.h
@@ -9,7 +9,7 @@
  *                 scatter/gather formats.
  * Creation Date:  June 21, 2006
  *
- *  mpi2.h Version:  02.00.53
+ *  mpi2.h Version:  02.00.54
  *
  * NOTE: Names (typedefs, defines, etc.) beginning with an MPI25 or Mpi25
  *       prefix are for use only on MPI v2.5 products, and must not be used
@@ -121,6 +121,7 @@
  * 08-15-18  02.00.52  Bumped MPI2_HEADER_VERSION_UNIT.
  * 08-28-18  02.00.53  Bumped MPI2_HEADER_VERSION_UNIT.
  *                     Added MPI2_IOCSTATUS_FAILURE
+ * 12-17-18  02.00.54  Bumped MPI2_HEADER_VERSION_UNIT
  *  --------------------------------------------------------------------------
  */
 
@@ -161,7 +162,7 @@
 
 
 /* Unit and Dev versioning for this MPI header set */
-#define MPI2_HEADER_VERSION_UNIT            (0x35)
+#define MPI2_HEADER_VERSION_UNIT            (0x36)
 #define MPI2_HEADER_VERSION_DEV             (0x00)
 #define MPI2_HEADER_VERSION_UNIT_MASK       (0xFF00)
 #define MPI2_HEADER_VERSION_UNIT_SHIFT      (8)
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index 167d79d..3a6871a 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -7,7 +7,7 @@
  *         Title:  MPI Configuration messages and pages
  * Creation Date:  November 10, 2006
  *
- *    mpi2_cnfg.h Version:  02.00.46
+ *    mpi2_cnfg.h Version:  02.00.47
  *
  * NOTE: Names (typedefs, defines, etc.) beginning with an MPI25 or Mpi25
  *       prefix are for use only on MPI v2.5 products, and must not be used
@@ -244,6 +244,11 @@
  *                     Added DMDReport Delay Time defines to
  *                     PCIeIOUnitPage1
  * --------------------------------------------------------------------------
+ * 08-02-18  02.00.44  Added Slotx2, Slotx4 to ManPage 7.
+ * 08-15-18  02.00.45  Added ProductSpecific field at end of IOC Page 1
+ * 08-28-18  02.00.46  Added NVMs Write Cache flag to IOUnitPage1
+ *                     Added DMDReport Delay Time defines to PCIeIOUnitPage1
+ * 12-17-18  02.00.47  Swap locations of Slotx2 and Slotx4 in ManPage 7.
  */
 
 #ifndef MPI2_CNFG_H
@@ -810,7 +815,8 @@ typedef struct _MPI2_MANPAGE7_CONNECTOR_INFO {
 	U8                          Location;               /*0x14 */
 	U8                          ReceptacleID;           /*0x15 */
 	U16                         Slot;                   /*0x16 */
-	U32                         Reserved2;              /*0x18 */
+	U16                         Slotx2;                 /*0x18 */
+	U16                         Slotx4;                 /*0x1A */
 } MPI2_MANPAGE7_CONNECTOR_INFO,
 	*PTR_MPI2_MANPAGE7_CONNECTOR_INFO,
 	Mpi2ManPage7ConnectorInfo_t,
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_image.h b/drivers/scsi/mpt3sas/mpi/mpi2_image.h
index 4959585..a3f6778 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_image.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_image.h
@@ -5,7 +5,7 @@
  *          Name: mpi2_image.h
  * Description: Contains definitions for firmware and other component images
  * Creation Date: 04/02/2018
- *       Version: 02.06.03
+ *       Version: 02.06.04
  *
  *
  * Version History
@@ -17,6 +17,8 @@
  * 08-14-18  02.06.01  Corrected define for MPI26_IMAGE_HEADER_SIGNATURE0_MPI26
  * 08-28-18  02.06.02  Added MPI2_EXT_IMAGE_TYPE_RDE
  * 09-07-18  02.06.03  Added MPI26_EVENT_PCIE_TOPO_PI_16_LANES
+ * 12-17-18  02.06.04  Addd MPI2_EXT_IMAGE_TYPE_PBLP
+ *			Shorten some defines to be compatible with DOS
  */
 #ifndef MPI2_IMAGE_H
 #define MPI2_IMAGE_H
@@ -200,17 +202,17 @@ typedef struct _MPI26_COMPONENT_IMAGE_HEADER {
 #define MPI26_IMAGE_HEADER_SIGNATURE0_MPI26                     (0xEB000042)
 
 /**** Definitions for Signature1 field ****/
-#define MPI26_IMAGE_HEADER_SIGNATURE1_APPLICATION              (0x20505041)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_CBB                      (0x20424243)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_MFG                      (0x2047464D)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_BIOS                     (0x534F4942)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_HIIM                     (0x4D494948)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_HIIA                     (0x41494948)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_CPLD                     (0x444C5043)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_SPD                      (0x20445053)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_NVDATA                   (0x5444564E)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_GAS_GAUGE                (0x20534147)
-#define MPI26_IMAGE_HEADER_SIGNATURE1_PBLP                     (0x50424C50)
+#define MPI26_IMAGE_HEADER_SIG1_APPLICATION              (0x20505041)
+#define MPI26_IMAGE_HEADER_SIG1_CBB                      (0x20424243)
+#define MPI26_IMAGE_HEADER_SIG1_MFG                      (0x2047464D)
+#define MPI26_IMAGE_HEADER_SIG1_BIOS                     (0x534F4942)
+#define MPI26_IMAGE_HEADER_SIG1_HIIM                     (0x4D494948)
+#define MPI26_IMAGE_HEADER_SIG1_HIIA                     (0x41494948)
+#define MPI26_IMAGE_HEADER_SIG1_CPLD                     (0x444C5043)
+#define MPI26_IMAGE_HEADER_SIG1_SPD                      (0x20445053)
+#define MPI26_IMAGE_HEADER_SIG1_NVDATA                   (0x5444564E)
+#define MPI26_IMAGE_HEADER_SIG1_GAS_GAUGE                (0x20534147)
+#define MPI26_IMAGE_HEADER_SIG1_PBLP                     (0x504C4250)
 
 /**** Definitions for Signature2 field ****/
 #define MPI26_IMAGE_HEADER_SIGNATURE2_VALUE                    (0x50584546)
@@ -278,6 +280,7 @@ typedef struct _MPI2_EXT_IMAGE_HEADER {
 #define MPI2_EXT_IMAGE_TYPE_MEGARAID                (0x08)
 #define MPI2_EXT_IMAGE_TYPE_ENCRYPTED_HASH          (0x09)
 #define MPI2_EXT_IMAGE_TYPE_RDE                     (0x0A)
+#define MPI2_EXT_IMAGE_TYPE_PBLP                    (0x0B)
 #define MPI2_EXT_IMAGE_TYPE_MIN_PRODUCT_SPECIFIC    (0x80)
 #define MPI2_EXT_IMAGE_TYPE_MAX_PRODUCT_SPECIFIC    (0xFF)
 
@@ -472,12 +475,12 @@ Mpi25EncryptedHashEntry_t, *pMpi25EncryptedHashEntry_t;
 #define MPI25_HASH_ALGORITHM_UNUSED             (0x00)
 #define MPI25_HASH_ALGORITHM_SHA256             (0x01)
 
-#define MPI26_HASH_ALGORITHM_VERSION_MASK       (0xE0)
-#define MPI26_HASH_ALGORITHM_VERSION_NONE       (0x00)
-#define MPI26_HASH_ALGORITHM_VERSION_SHA1       (0x20)
-#define MPI26_HASH_ALGORITHM_VERSION_SHA2       (0x40)
-#define MPI26_HASH_ALGORITHM_VERSION_SHA3       (0x60)
-#define MPI26_HASH_ALGORITHM_SIZE_MASK          (0x1F)
+#define MPI26_HASH_ALGORITHM_VER_MASK		(0xE0)
+#define MPI26_HASH_ALGORITHM_VER_NONE		(0x00)
+#define MPI26_HASH_ALGORITHM_VER_SHA1		(0x20)
+#define MPI26_HASH_ALGORITHM_VER_SHA2		(0x40)
+#define MPI26_HASH_ALGORITHM_VER_SHA3		(0x60)
+#define MPI26_HASH_ALGORITHM_SIZE_MASK		(0x1F)
 #define MPI26_HASH_ALGORITHM_SIZE_256           (0x01)
 #define MPI26_HASH_ALGORITHM_SIZE_512           (0x02)
 
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_pci.h b/drivers/scsi/mpt3sas/mpi/mpi2_pci.h
index 63a0950..bb7b79c 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_pci.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_pci.h
@@ -6,7 +6,7 @@
  *         Title:  MPI PCIe Attached Devices structures and definitions.
  * Creation Date:  October 9, 2012
  *
- * mpi2_pci.h Version:  02.00.03
+ * mpi2_pci.h Version:  02.00.04
  *
  * NOTE: Names (typedefs, defines, etc.) beginning with an MPI25 or Mpi25
  *       prefix are for use only on MPI v2.5 products, and must not be used
@@ -24,6 +24,8 @@
  * 07-01-16  02.00.02  Added MPI26_NVME_FLAGS_FORCE_ADMIN_ERR_RESP to
  *                     NVME Encapsulated Request.
  * 07-22-18  02.00.03  Updted flags field for NVME Encapsulated req
+ * 12-17-18  02.00.04  Added MPI26_PCIE_DEVINFO_SCSI
+ *			Shortten some defines to be compatible with DOS
  * --------------------------------------------------------------------------
  */
 
@@ -41,7 +43,7 @@
 #define MPI26_PCIE_DEVINFO_NO_DEVICE            (0x00000000)
 #define MPI26_PCIE_DEVINFO_PCI_SWITCH           (0x00000001)
 #define MPI26_PCIE_DEVINFO_NVME                 (0x00000003)
-
+#define MPI26_PCIE_DEVINFO_SCSI                 (0x00000004)
 
 /****************************************************************************
 *  NVMe Encapsulated message
@@ -75,10 +77,9 @@ typedef struct _MPI26_NVME_ENCAPSULATED_REQUEST {
 #define MPI26_NVME_FLAGS_SUBMISSIONQ_IO             (0x0000)
 #define MPI26_NVME_FLAGS_SUBMISSIONQ_ADMIN          (0x0010)
 /*Error Response Address Space */
-#define MPI26_NVME_FLAGS_MASK_ERROR_RSP_ADDR        (0x000C)
-#define MPI26_NVME_FLAGS_MASK_ERROR_RSP_ADDR_MASK   (0x000C)
-#define MPI26_NVME_FLAGS_SYSTEM_RSP_ADDR            (0x0000)
-#define MPI26_NVME_FLAGS_IOCCTL_RSP_ADDR            (0x0008)
+#define MPI26_NVME_FLAGS_ERR_RSP_ADDR_MASK          (0x000C)
+#define MPI26_NVME_FLAGS_ERR_RSP_ADDR_SYSTEM        (0x0000)
+#define MPI26_NVME_FLAGS_ERR_RSP_ADDR_IOCTL         (0x0008)
 /* Data Direction*/
 #define MPI26_NVME_FLAGS_DATADIRECTION_MASK         (0x0003)
 #define MPI26_NVME_FLAGS_NODATATRANSFER             (0x0000)
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_tool.h b/drivers/scsi/mpt3sas/mpi/mpi2_tool.h
index 3f966b6..17ef7f6 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_tool.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_tool.h
@@ -7,7 +7,7 @@
  *         Title:  MPI diagnostic tool structures and definitions
  * Creation Date:  March 26, 2007
  *
- *   mpi2_tool.h Version:  02.00.15
+ *   mpi2_tool.h Version:  02.00.16
  *
  * Version History
  * ---------------
@@ -40,6 +40,7 @@
  *                     Tool Request Message.
  * 07-22-18  02.00.15  Added defines for new TOOLBOX_PCIE_LANE_MARGINING tool.
  *                     Added option for DeviceInfo field in ISTWI tool.
+ * 12-17-18  02.00.16  Shorten some defines to be compatible with DOS.
  * --------------------------------------------------------------------------
  */
 
@@ -230,11 +231,11 @@ typedef struct _MPI2_TOOLBOX_ISTWI_READ_WRITE_REQUEST {
 #define MPI2_TOOL_ISTWI_FLAG_PAGE_ADDR_MASK         (0x07)
 
 /*MPI26 TOOLBOX Request MsgFlags defines */
-#define MPI26_TOOLBOX_REQ_MSGFLAGS_ADDRESSING_MASK     (0x01)
+#define MPI26_TOOL_ISTWI_MSGFLG_ADDR_MASK           (0x01)
 /*Request uses Man Page 43 device index addressing */
-#define MPI26_TOOLBOX_REQ_MSGFLAGS_ADDRESSING_DEVINDEX (0x00)
+#define MPI26_TOOL_ISTWI_MSGFLG_ADDR_INDEX          (0x00)
 /*Request uses Man Page 43 device info struct addressing */
-#define MPI26_TOOLBOX_REQ_MSGFLAGS_ADDRESSING_DEVINFO  (0x01)
+#define MPI26_TOOL_ISTWI_MSGFLG_ADDR_INFO           (0x01)
 
 /*Toolbox ISTWI Read Write Tool reply message */
 typedef struct _MPI2_TOOLBOX_ISTWI_REPLY {
@@ -403,7 +404,7 @@ Mpi2ToolboxTextDisplayRequest_t,
  */
 
 /*Toolbox Backend Lane Margining Tool request message */
-typedef struct _MPI26_TOOLBOX_LANE_MARGINING_REQUEST {
+typedef struct _MPI26_TOOLBOX_LANE_MARGIN_REQUEST {
 	U8 Tool;			/*0x00 */
 	U8 Reserved1;			/*0x01 */
 	U8 ChainOffset;			/*0x02 */
@@ -434,7 +435,7 @@ typedef struct _MPI26_TOOLBOX_LANE_MARGINING_REQUEST {
 
 
 /*Toolbox Backend Lane Margining Tool reply message */
-typedef struct _MPI26_TOOLBOX_LANE_MARGINING_REPLY {
+typedef struct _MPI26_TOOLBOX_LANE_MARGIN_REPLY {
 	U8 Tool;			/*0x00 */
 	U8 Reserved1;			/*0x01 */
 	U8 MsgLength;			/*0x02 */
-- 
1.8.3.1

