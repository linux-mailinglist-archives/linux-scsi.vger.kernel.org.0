Return-Path: <linux-scsi+bounces-7974-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DEC96D61F
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Sep 2024 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ADF28783C
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Sep 2024 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0D19882C;
	Thu,  5 Sep 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OzyDqM33"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB2194A64
	for <linux-scsi@vger.kernel.org>; Thu,  5 Sep 2024 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532302; cv=none; b=K6bGOlSJbs9tpbCDqy0tgFd0CtpmJMFKpotTL4O7+ltAMSbyrbA1glK5qypmLFLWTCezg1F0OGGpYSa2H7tbKSZoJpCGnzLm6jgmZHP7knmsgy6nzalovSnmSYy36z1j4dmSnjvWtSaGkMeNhS9NHbICIxpW7a0Zi7dLxODdxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532302; c=relaxed/simple;
	bh=pQL2n6T4m2nvPtQZd6+6qbNSTgyhwGqQfuFwDSCml+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uc8tZf8IO0UJj0/2GjFXmnH3JcJn92z2YqjweWB97cvQop1+ZskdHvgEvS+3RrGatBcXQfY07lhmE+xnyVO9+c03ReTCyx2e7q7VcoBBdE/vWfskFw9akf+Fi4ysMuPy4u0wmTJGrnpkGeNE2xpI1GQ1924Jl5RyPzY1FS7J38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OzyDqM33; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7141d7b270dso531814b3a.2
        for <linux-scsi@vger.kernel.org>; Thu, 05 Sep 2024 03:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725532299; x=1726137099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJXaR9VxtTmDYnacUWCCn2NFx7ZwbE/6QsrIqQl6FUE=;
        b=OzyDqM336rfl9D/QmPtSOk0ZkuolxXmWtg9mjLYYuW9/7FWL2MPyRc3OVMR84kyrOY
         F8so/Q+4L0Nco8RVNnzj2b5fqMFa+d1WZzrk+8xihTfMaJHZZXCBSGGhbR8Pu++BEAWf
         dIfCSUOpV2pR5f5PDi1oxVB3EXytaocP7tDCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532299; x=1726137099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJXaR9VxtTmDYnacUWCCn2NFx7ZwbE/6QsrIqQl6FUE=;
        b=bGgO9PFqrKEnFGTHZ0bLDaDTN6uKS224RWEwGlRw4qV84Sk37tkkpRlrpjPYrdec+Y
         n7W72aYRZRQXRltdYbjJdWQ/igVTkOfkjBWlPYjb1Vh7FjSbHkudmKrgMqO7q8JS3jDQ
         kL56fAIyuwt8Qmqq0dH51KH6b4Ub0sNEe1hvSI0/yGcja0GaMBhltrTcp1YzjUw7XmRE
         HpycFENap0thIltrX7TW+a2wS7MDhmZy1xmGOlee/8ZjU2tWHshDQWELdn93tvKLXUx+
         jWSgncFlC7ogiiO7EAAh0Bz2z6siXW1JWj57OAhK6wu7xxwo6EH8sCRLYMupjpafzaW4
         djSA==
X-Gm-Message-State: AOJu0YxAEWLN58tETBN1XGXSkI5wRDWkmu0zNcZl0hiGtNqHSSiTnYKd
	92os+MwRR7FqPeB6p6dz9oiK97kAprP80T1gn7+hElagP8qxkc6ivfBbuAaDiiRhAvOlwwIb8dX
	RvcdRSHQKPm/YEYpafl/Xs1TQZDieFBrRNrdNrLGa/DumQbwGaeTxvuYn8chZYGOII9uh92b26R
	W84u4i0QI4fm12NGDWl38B22SgI55ESj+fKQYIyHgzmrZQNw==
X-Google-Smtp-Source: AGHT+IEspeP0HVOCD09Y7FvKc/ojyxRApAhvsq083oaHL5tw3rAlauVcTDHWKsarfsBih9PTudO+0w==
X-Received: by 2002:a05:6a00:21d5:b0:714:19f8:f135 with SMTP id d2e1a72fcca58-717449b1a76mr15811107b3a.21.1725532299184;
        Thu, 05 Sep 2024 03:31:39 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785364f9sm2960177b3a.87.2024.09.05.03.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:31:38 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: rajsekhar.chundru@broadcom.com,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	prayas.patel@broadcom.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>
Subject: [PATCH v1 3/5] mpi3mr: Update MPI Headers to revision 34
Date: Thu,  5 Sep 2024 15:57:51 +0530
Message-Id: <20240905102753.105310-4-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240905102753.105310-1-ranjan.kumar@broadcom.com>
References: <20240905102753.105310-1-ranjan.kumar@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update MPI Headers to revision 34.

Signed-off-by: Prayas Patel <prayas.patel@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h      | 34 +++++++++++++++++++++--
 drivers/scsi/mpi3mr/mpi/mpi30_image.h     | 13 +++++++--
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h       |  8 ++++++
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h |  4 ++-
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
index b46bd08eac99..00cd18edfad6 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
@@ -67,6 +67,7 @@
 #define MPI3_SECURITY_PGAD_SLOT_GROUP_MASK              (0x0000ff00)
 #define MPI3_SECURITY_PGAD_SLOT_GROUP_SHIFT		(8)
 #define MPI3_SECURITY_PGAD_SLOT_MASK                    (0x000000ff)
+#define MPI3_INSTANCE_PGAD_INSTANCE_MASK                (0x0000ffff)
 struct mpi3_config_request {
 	__le16             host_tag;
 	u8                 ioc_use_only02;
@@ -75,7 +76,8 @@ struct mpi3_config_request {
 	u8                 ioc_use_only06;
 	u8                 msg_flags;
 	__le16             change_count;
-	__le16             reserved0a;
+	u8                 proxy_ioc_number;
+	u8                 reserved0b;
 	u8                 page_version;
 	u8                 page_number;
 	u8                 page_type;
@@ -206,6 +208,9 @@ struct mpi3_config_page_header {
 #define MPI3_MFGPAGE_DEVID_SAS5116_MPI_MGMT		(0x00b5)
 #define MPI3_MFGPAGE_DEVID_SAS5116_NVME_MGMT		(0x00b6)
 #define MPI3_MFGPAGE_DEVID_SAS5116_PCIE_SWITCH		(0x00b8)
+#define MPI3_MFGPAGE_DEVID_SAS5248_MPI			(0x00f0)
+#define MPI3_MFGPAGE_DEVID_SAS5248_MPI_NS		(0x00f1)
+#define MPI3_MFGPAGE_DEVID_SAS5248_PCIE_SWITCH		(0x00f2)
 struct mpi3_man_page0 {
 	struct mpi3_config_page_header         header;
 	u8                                 chip_revision[8];
@@ -1074,6 +1079,8 @@ struct mpi3_io_unit_page8 {
 #define MPI3_IOUNIT8_SBSTATE_SVN_UPDATE_PENDING   (0x04)
 #define MPI3_IOUNIT8_SBSTATE_KEY_UPDATE_PENDING   (0x02)
 #define MPI3_IOUNIT8_SBSTATE_SECURE_BOOT_ENABLED  (0x01)
+#define MPI3_IOUNIT8_SBMODE_CURRENT_KEY_IOUNIT17	(0x10)
+#define MPI3_IOUNIT8_SBMODE_HARD_SECURE_RECERTIFIED	(0x08)
 struct mpi3_io_unit_page9 {
 	struct mpi3_config_page_header         header;
 	__le32                             flags;
@@ -1089,6 +1096,8 @@ struct mpi3_io_unit_page9 {
 #define MPI3_IOUNIT9_FLAGS_UBM_ENCLOSURE_ORDER_BACKPLANE_TYPE     (0x00000004)
 #define MPI3_IOUNIT9_FLAGS_VDFIRST_ENABLED                        (0x00000001)
 #define MPI3_IOUNIT9_FIRSTDEVICE_UNKNOWN                          (0xffff)
+#define MPI3_IOUNIT9_FIRSTDEVICE_IN_DRIVER_PAGE_0                 (0xfffe)
+
 struct mpi3_io_unit_page10 {
 	struct mpi3_config_page_header         header;
 	u8                                 flags;
@@ -1224,6 +1233,19 @@ struct mpi3_io_unit_page15 {
 #define MPI3_IOUNIT15_FLAGS_EPRSUPPORT_WITHOUT_POWER_BRAKE_GPIO     (0x01)
 #define MPI3_IOUNIT15_FLAGS_EPRSUPPORT_WITH_POWER_BRAKE_GPIO        (0x02)
 #define MPI3_IOUNIT15_NUMPOWERBUDGETDATA_POWER_BUDGETING_DISABLED   (0x00)
+
+struct mpi3_io_unit_page17 {
+	struct mpi3_config_page_header         header;
+	u8                                 num_instances;
+	u8                                 instance;
+	__le16                             reserved0a;
+	__le32                             reserved0c[4];
+	__le16                             key_length;
+	u8                                 encryption_algorithm;
+	u8                                 reserved1f;
+	__le32                             current_key[];
+};
+#define MPI3_IOUNIT17_PAGEVERSION		(0x00)
 struct mpi3_ioc_page0 {
 	struct mpi3_config_page_header         header;
 	__le32                             reserved08;
@@ -1311,7 +1333,7 @@ struct mpi3_driver_page0 {
 	u8                                 tur_interval;
 	u8                                 reserved10;
 	u8                                 security_key_timeout;
-	__le16                             reserved12;
+	__le16                             first_device;
 	__le32                             reserved14;
 	__le32                             reserved18;
 };
@@ -1324,11 +1346,13 @@ struct mpi3_driver_page0 {
 #define MPI3_DRIVER0_BSDOPTS_REGISTRATION_IOC_AND_DEVS      (0x00000000)
 #define MPI3_DRIVER0_BSDOPTS_REGISTRATION_IOC_ONLY          (0x00000001)
 #define MPI3_DRIVER0_BSDOPTS_REGISTRATION_IOC_AND_INTERNAL_DEVS		(0x00000002)
+#define MPI3_DRIVER0_FIRSTDEVICE_IGNORE1                            (0x0000)
+#define MPI3_DRIVER0_FIRSTDEVICE_IGNORE2                            (0xffff)
 struct mpi3_driver_page1 {
 	struct mpi3_config_page_header         header;
 	__le32                             flags;
 	u8                                 time_stamp_update;
-	__le32                             reserved0c;
+	u8                                 reserved0d[3];
 	__le16                             host_diag_trace_max_size;
 	__le16                             host_diag_trace_min_size;
 	__le16                             host_diag_trace_decrement_size;
@@ -2348,6 +2372,10 @@ struct mpi3_device0_vd_format {
 #define MPI3_DEVICE0_VD_DEVICE_INFO_SAS                     (0x0001)
 #define MPI3_DEVICE0_VD_FLAGS_IO_THROTTLE_GROUP_QD_MASK     (0xf000)
 #define MPI3_DEVICE0_VD_FLAGS_IO_THROTTLE_GROUP_QD_SHIFT    (12)
+#define MPI3_DEVICE0_VD_FLAGS_OSEXPOSURE_MASK               (0x0003)
+#define MPI3_DEVICE0_VD_FLAGS_OSEXPOSURE_HDD                (0x0000)
+#define MPI3_DEVICE0_VD_FLAGS_OSEXPOSURE_SSD                (0x0001)
+#define MPI3_DEVICE0_VD_FLAGS_OSEXPOSURE_NO_GUIDANCE        (0x0002)
 union mpi3_device0_dev_spec_format {
 	struct mpi3_device0_sas_sata_format        sas_sata_format;
 	struct mpi3_device0_pcie_format            pcie_format;
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_image.h b/drivers/scsi/mpi3mr/mpi/mpi30_image.h
index 7df242190135..2c6e548cbd0f 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_image.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_image.h
@@ -205,13 +205,14 @@ struct mpi3_encrypted_hash_entry {
 	u8                         hash_image_type;
 	u8                         hash_algorithm;
 	u8                         encryption_algorithm;
-	u8                         reserved03;
+	u8                         flags;
 	__le16                     public_key_size;
 	__le16                     signature_size;
 	__le32                     public_key[MPI3_PUBLIC_KEY_MAX];
 };
-
-#define MPI3_HASH_IMAGE_TYPE_KEY_WITH_SIGNATURE      (0x03)
+#define MPI3_HASH_IMAGE_TYPE_KEY_WITH_HASH           (0x03)
+#define MPI3_HASH_IMAGE_TYPE_KEY_WITH_HASH_1_OF_2    (0x04)
+#define MPI3_HASH_IMAGE_TYPE_KEY_WITH_HASH_2_OF_2    (0x05)
 #define MPI3_HASH_ALGORITHM_VERSION_MASK             (0xe0)
 #define MPI3_HASH_ALGORITHM_VERSION_NONE             (0x00)
 #define MPI3_HASH_ALGORITHM_VERSION_SHA1             (0x20)
@@ -230,6 +231,12 @@ struct mpi3_encrypted_hash_entry {
 #define MPI3_ENCRYPTION_ALGORITHM_RSA4096            (0x05)
 #define MPI3_ENCRYPTION_ALGORITHM_RSA3072            (0x06)
 
+/* hierarchical signature system (hss) */
+#define MPI3_ENCRYPTION_ALGORITHM_ML_DSA_87	    (0x0b)
+#define MPI3_ENCRYPTION_ALGORITHM_ML_DSA_65	    (0x0c)
+#define MPI3_ENCRYPTION_ALGORITHM_ML_DSA_44	    (0x0d)
+#define MPI3_ENCRYPTED_HASH_ENTRY_FLAGS_PAIRED_KEY_MASK		(0x0f)
+
 #ifndef MPI3_ENCRYPTED_HASH_ENTRY_MAX
 #define MPI3_ENCRYPTED_HASH_ENTRY_MAX               (1)
 #endif
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
index c9fa0d69b75f..c374867f9ba0 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
@@ -39,6 +39,12 @@ struct mpi3_ioc_init_request {
 #define MPI3_WHOINIT_HOST_DRIVER                         (0x03)
 #define MPI3_WHOINIT_MANUFACTURER                        (0x04)
 
+#define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_MASK              (0x00000003)
+#define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_NO_GUIDANCE       (0x00000000)
+#define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_NO_SPECIAL        (0x00000001)
+#define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_REPORT_AS_HDD     (0x00000002)
+#define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_REPORT_AS_SSD     (0x00000003)
+
 struct mpi3_ioc_facts_request {
 	__le16                 host_tag;
 	u8                     ioc_use_only02;
@@ -140,6 +146,8 @@ struct mpi3_ioc_facts_data {
 #define MPI3_IOCFACTS_EXCEPT_MANUFACT_CHECKSUM_FAIL           (0x0020)
 #define MPI3_IOCFACTS_EXCEPT_FW_CHECKSUM_FAIL                 (0x0010)
 #define MPI3_IOCFACTS_EXCEPT_CONFIG_CHECKSUM_FAIL             (0x0008)
+#define MPI3_IOCFACTS_EXCEPT_BLOCKING_BOOT_EVENT              (0x0004)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_SELFTEST_FAILURE        (0x0002)
 #define MPI3_IOCFACTS_EXCEPT_BOOTSTAT_MASK                    (0x0001)
 #define MPI3_IOCFACTS_EXCEPT_BOOTSTAT_PRIMARY                 (0x0000)
 #define MPI3_IOCFACTS_EXCEPT_BOOTSTAT_SECONDARY               (0x0001)
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
index fdc3d1968e43..b2ab25a1cfeb 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
@@ -18,7 +18,7 @@ union mpi3_version_union {
 
 #define MPI3_VERSION_MAJOR                                              (3)
 #define MPI3_VERSION_MINOR                                              (0)
-#define MPI3_VERSION_UNIT                                               (31)
+#define MPI3_VERSION_UNIT                                               (34)
 #define MPI3_VERSION_DEV                                                (0)
 #define MPI3_DEVHANDLE_INVALID                                          (0xffff)
 struct mpi3_sysif_oper_queue_indexes {
@@ -158,6 +158,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_FAULT_CODE_SOFT_RESET_NEEDED                         (0x0000f004)
 #define MPI3_SYSIF_FAULT_CODE_POWER_CYCLE_REQUIRED                      (0x0000f005)
 #define MPI3_SYSIF_FAULT_CODE_TEMP_THRESHOLD_EXCEEDED                   (0x0000f006)
+#define MPI3_SYSIF_FAULT_CODE_INSUFFICIENT_PCI_SLOT_POWER               (0x0000f007)
 #define MPI3_SYSIF_FAULT_INFO0_OFFSET                                   (0x00001c14)
 #define MPI3_SYSIF_FAULT_INFO1_OFFSET                                   (0x00001c18)
 #define MPI3_SYSIF_FAULT_INFO2_OFFSET                                   (0x00001c1c)
@@ -410,6 +411,7 @@ struct mpi3_default_reply {
 #define MPI3_IOCSTATUS_INSUFFICIENT_RESOURCES       (0x0006)
 #define MPI3_IOCSTATUS_INVALID_FIELD                (0x0007)
 #define MPI3_IOCSTATUS_INVALID_STATE                (0x0008)
+#define MPI3_IOCSTATUS_SHUTDOWN_ACTIVE              (0x0009)
 #define MPI3_IOCSTATUS_INSUFFICIENT_POWER           (0x000a)
 #define MPI3_IOCSTATUS_INVALID_CHANGE_COUNT         (0x000b)
 #define MPI3_IOCSTATUS_ALLOWED_CMD_BLOCK            (0x000c)
-- 
2.31.1


