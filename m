Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901A047AAE9
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Dec 2021 15:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhLTOES (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Dec 2021 09:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLTOEN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Dec 2021 09:04:13 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8AAC06173E
        for <linux-scsi@vger.kernel.org>; Mon, 20 Dec 2021 06:04:13 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c2so8797718pfc.1
        for <linux-scsi@vger.kernel.org>; Mon, 20 Dec 2021 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ZWgxW/emkIBK8q3pZv/KCobmJ6SK2btMhzZ3+ACPaec=;
        b=FOMz9KK7cgyAWQOvqonag7MtMPeuRNz5vsBA0EIOWF8I/6CdHCgyFajx9SG4bf9ny3
         oGWxneB2cLam0/SPG2UfkrJY6rlJj4ybfwxQUdamcCSV7pSeT9tlPH6DKa0Qkq2OGhC8
         aGmtkUD7tznthVuW72PsYTyPTaG7KfVj5vakI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ZWgxW/emkIBK8q3pZv/KCobmJ6SK2btMhzZ3+ACPaec=;
        b=23uBtfD05WvxI51tL0AYg6rZTmooHt/A/lioGmiZse+fpVNq9ZVAKXuBtFBsFIz2Ex
         AbSKj1vP1jJkr2OddkJfKz8YpFhe1uOmBr8co3HtUM93FJoaBa83jA13LO2nE97zXs+v
         G8hvd4FCaYAY0hwoEZ6F3pvZM08CaOYk4jFgW/HltijeybUmM7GJBFXiwZpTjUaDnAWM
         BmYpBlaXYZ77D6LSnKtdpg3VgS5nU2CHnpgoTScDOrWKGyd2nJL22UvCyVGl5yxnX5sE
         b5lxKRcN4bbygr1fW2XOsABvvJxqIKmZAMQLmsUnbX9488KX6K2fFKcBPsxRWPQgE/GF
         Vyyw==
X-Gm-Message-State: AOAM533pg2dWpltkA/GVdIE6SHkOSDaQr7RTGcc/s1FaVS7XUd85F/kF
        1Hawd7/CTqLNOMwMM0bAcnOUSscLQUSxw6DwVcKTGzORKyL8zxKia2LpQgyeSMmPli+lUHjxwcP
        B3HcJlakOLa+DfC0sMjfMIYL+JtiJ7UBbC+LEtDd4mmi6N+HH+YFpCFuWq/MjOAQBzbZqS+dHY6
        r4CUbh4oaZ
X-Google-Smtp-Source: ABdhPJwsZ+uLgY5REwsw8w1J6P4qkottZxyIq886LBaFT4Oq+FRJghPR3gnYK9EZ8bJlaJmEJ/UcAw==
X-Received: by 2002:a63:6b87:: with SMTP id g129mr15158453pgc.284.1640009052443;
        Mon, 20 Dec 2021 06:04:12 -0800 (PST)
Received: from dhcp-10-123-20-36.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b4sm5434180pjm.17.2021.12.20.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:04:11 -0800 (PST)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 05/25] mpi3mr: Update MPI3 headers - part2
Date:   Mon, 20 Dec 2021 19:41:39 +0530
Message-Id: <20211220141159.16117-6-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211220141159.16117-1-sreekanth.reddy@broadcom.com>
References: <20211220141159.16117-1-sreekanth.reddy@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000b973605d3945d0e"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000000b973605d3945d0e
Content-Transfer-Encoding: 8bit

Continued updating MPI3 headers.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi/mpi30_image.h     |  59 +++++++++-
 drivers/scsi/mpi3mr/mpi/mpi30_init.h      |  15 ++-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h       | 128 +++++++++++++++++-----
 drivers/scsi/mpi3mr/mpi/mpi30_pci.h       |  44 ++++++++
 drivers/scsi/mpi3mr/mpi/mpi30_sas.h       |  14 +++
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h |  31 ++++--
 drivers/scsi/mpi3mr/mpi3mr.h              |   5 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c           |  26 ++---
 8 files changed, 261 insertions(+), 61 deletions(-)
 create mode 100644 drivers/scsi/mpi3mr/mpi/mpi30_pci.h

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_image.h b/drivers/scsi/mpi3mr/mpi/mpi30_image.h
index 169e4f9..c29b87d 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_image.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_image.h
@@ -61,6 +61,8 @@ struct mpi3_component_image_header {
 #define MPI3_IMAGE_HEADER_SIGNATURE1_SPD                      (0x20445053)
 #define MPI3_IMAGE_HEADER_SIGNATURE1_GAS_GAUGE                (0x20534147)
 #define MPI3_IMAGE_HEADER_SIGNATURE1_PBLP                     (0x504c4250)
+#define MPI3_IMAGE_HEADER_SIGNATURE1_MANIFEST                 (0x464e414d)
+#define MPI3_IMAGE_HEADER_SIGNATURE1_OEM                      (0x204d454f)
 #define MPI3_IMAGE_HEADER_SIGNATURE2_VALUE                    (0x50584546)
 #define MPI3_IMAGE_HEADER_FLAGS_DEVICE_KEY_BASIS_MASK         (0x00000030)
 #define MPI3_IMAGE_HEADER_FLAGS_DEVICE_KEY_BASIS_CDI          (0x00000000)
@@ -94,6 +96,61 @@ struct mpi3_component_image_header {
 #define MPI3_IMAGE_HEADER_HASH_EXCLUSION_OFFSET               (0x5c)
 #define MPI3_IMAGE_HEADER_NEXT_IMAGE_HEADER_OFFSET_OFFSET     (0x7c)
 #define MPI3_IMAGE_HEADER_SIZE                                (0x100)
+#ifndef MPI3_CI_MANIFEST_MPI_MAX
+#define MPI3_CI_MANIFEST_MPI_MAX                               (1)
+#endif
+struct mpi3_ci_manifest_mpi_comp_image_ref {
+	__le32                                signature1;
+	__le32                                reserved04[3];
+	struct mpi3_comp_image_version            component_image_version;
+	__le32                                component_image_version_string_offset;
+	__le32                                crc;
+};
+
+struct mpi3_ci_manifest_mpi {
+	u8                                       manifest_type;
+	u8                                       reserved01[3];
+	__le32                                   reserved04[3];
+	u8                                       num_image_references;
+	u8                                       release_level;
+	__le16                                   reserved12;
+	__le16                                   reserved14;
+	__le16                                   flags;
+	__le32                                   reserved18[2];
+	__le16                                   vendor_id;
+	__le16                                   device_id;
+	__le16                                   subsystem_vendor_id;
+	__le16                                   subsystem_id;
+	__le32                                   reserved28[2];
+	union mpi3_version_union                    package_security_version;
+	__le32                                   reserved34;
+	struct mpi3_comp_image_version               package_version;
+	__le32                                   package_version_string_offset;
+	__le32                                   package_build_date_string_offset;
+	__le32                                   package_build_time_string_offset;
+	__le32                                   reserved4c;
+	__le32                                   diag_authorization_identifier[16];
+	struct mpi3_ci_manifest_mpi_comp_image_ref   component_image_ref[MPI3_CI_MANIFEST_MPI_MAX];
+};
+
+#define MPI3_CI_MANIFEST_MPI_RELEASE_LEVEL_DEV                        (0x00)
+#define MPI3_CI_MANIFEST_MPI_RELEASE_LEVEL_PREALPHA                   (0x10)
+#define MPI3_CI_MANIFEST_MPI_RELEASE_LEVEL_ALPHA                      (0x20)
+#define MPI3_CI_MANIFEST_MPI_RELEASE_LEVEL_BETA                       (0x30)
+#define MPI3_CI_MANIFEST_MPI_RELEASE_LEVEL_RC                         (0x40)
+#define MPI3_CI_MANIFEST_MPI_RELEASE_LEVEL_GCA                        (0x50)
+#define MPI3_CI_MANIFEST_MPI_RELEASE_LEVEL_POINT                      (0x60)
+#define MPI3_CI_MANIFEST_MPI_FLAGS_DIAG_AUTHORIZATION                 (0x01)
+#define MPI3_CI_MANIFEST_MPI_SUBSYSTEMID_IGNORED                   (0xffff)
+#define MPI3_CI_MANIFEST_MPI_PKG_VER_STR_OFF_UNSPECIFIED           (0x00000000)
+#define MPI3_CI_MANIFEST_MPI_PKG_BUILD_DATE_STR_OFF_UNSPECIFIED    (0x00000000)
+#define MPI3_CI_MANIFEST_MPI_PKG_BUILD_TIME_STR_OFF_UNSPECIFIED    (0x00000000)
+union mpi3_ci_manifest {
+	struct mpi3_ci_manifest_mpi               mpi;
+	__le32                                dword[1];
+};
+
+#define MPI3_CI_MANIFEST_TYPE_MPI                                  (0x00)
 struct mpi3_extended_image_header {
 	u8                                image_type;
 	u8                                reserved01[3];
@@ -161,6 +218,7 @@ struct mpi3_encrypted_hash_entry {
 #define MPI3_HASH_ALGORITHM_SIZE_UNUSED              (0x00)
 #define MPI3_HASH_ALGORITHM_SIZE_SHA256              (0x01)
 #define MPI3_HASH_ALGORITHM_SIZE_SHA512              (0x02)
+#define MPI3_HASH_ALGORITHM_SIZE_SHA384              (0x03)
 #define MPI3_ENCRYPTION_ALGORITHM_UNUSED             (0x00)
 #define MPI3_ENCRYPTION_ALGORITHM_RSA256             (0x01)
 #define MPI3_ENCRYPTION_ALGORITHM_RSA512             (0x02)
@@ -178,7 +236,6 @@ struct mpi3_encrypted_key_with_hash_entry {
 	u8                         reserved03;
 	__le32                     reserved04;
 	__le32                     public_key[MPI3_PUBLIC_KEY_MAX];
-	__le32                     encrypted_hash[MPI3_ENCRYPTED_HASH_MAX];
 };
 
 #ifndef MPI3_ENCRYPTED_HASH_ENTRY_MAX
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_init.h b/drivers/scsi/mpi3mr/mpi/mpi30_init.h
index e02b6d3..7a208dc 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_init.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_init.h
@@ -13,7 +13,7 @@ struct mpi3_scsi_io_cdb_eedp32 {
 	__le32             transfer_length;
 };
 
-union mpi3_scso_io_cdb_union {
+union mpi3_scsi_io_cdb_union {
 	u8                         cdb32[32];
 	struct mpi3_scsi_io_cdb_eedp32 eedp32;
 	struct mpi3_sge_common         sge;
@@ -32,11 +32,12 @@ struct mpi3_scsi_io_request {
 	__le32                     skip_count;
 	__le32                     data_length;
 	u8                         lun[8];
-	union mpi3_scso_io_cdb_union  cdb;
+	union mpi3_scsi_io_cdb_union  cdb;
 	union mpi3_sge_union          sgl[4];
 };
 
 #define MPI3_SCSIIO_MSGFLAGS_METASGL_VALID                  (0x80)
+#define MPI3_SCSIIO_MSGFLAGS_DIVERT_TO_FIRMWARE             (0x40)
 #define MPI3_SCSIIO_FLAGS_LARGE_CDB                         (0x60000000)
 #define MPI3_SCSIIO_FLAGS_CDB_16_OR_LESS                    (0x00000000)
 #define MPI3_SCSIIO_FLAGS_CDB_GREATER_THAN_16               (0x20000000)
@@ -155,5 +156,13 @@ struct mpi3_scsi_task_mgmt_reply {
 	__le32                     reserved18;
 };
 
-#define MPI3_SCSITASKMGMT_RSPCODE_IO_QUEUED_ON_IOC      (0x80)
+#define MPI3_SCSITASKMGMT_RSPCODE_TM_COMPLETE                (0x00)
+#define MPI3_SCSITASKMGMT_RSPCODE_INVALID_FRAME              (0x02)
+#define MPI3_SCSITASKMGMT_RSPCODE_TM_FUNCTION_NOT_SUPPORTED  (0x04)
+#define MPI3_SCSITASKMGMT_RSPCODE_TM_FAILED                  (0x05)
+#define MPI3_SCSITASKMGMT_RSPCODE_TM_SUCCEEDED               (0x08)
+#define MPI3_SCSITASKMGMT_RSPCODE_TM_INVALID_LUN             (0x09)
+#define MPI3_SCSITASKMGMT_RSPCODE_TM_OVERLAPPED_TAG          (0x0a)
+#define MPI3_SCSITASKMGMT_RSPCODE_IO_QUEUED_ON_IOC           (0x80)
+#define MPI3_SCSITASKMGMT_RSPCODE_TM_NVME_DENIED             (0x81)
 #endif
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
index 1af99a5..bc56273 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
@@ -29,10 +29,15 @@ struct mpi3_ioc_init_request {
 	__le64                   driver_information_address;
 };
 
-#define MPI3_WHOINIT_NOT_INITIALIZED            (0x00)
-#define MPI3_WHOINIT_ROM_BIOS                   (0x02)
-#define MPI3_WHOINIT_HOST_DRIVER                (0x03)
-#define MPI3_WHOINIT_MANUFACTURER               (0x04)
+#define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_MASK          (0x03)
+#define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_NOT_USED      (0x00)
+#define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_SEPARATED     (0x01)
+#define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_INLINE        (0x02)
+#define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_BOTH          (0x03)
+#define MPI3_WHOINIT_NOT_INITIALIZED                     (0x00)
+#define MPI3_WHOINIT_ROM_BIOS                            (0x02)
+#define MPI3_WHOINIT_HOST_DRIVER                         (0x03)
+#define MPI3_WHOINIT_MANUFACTURER                        (0x04)
 struct mpi3_driver_info_layout {
 	__le32             information_length;
 	u8                 driver_signature[12];
@@ -77,17 +82,17 @@ struct mpi3_ioc_facts_data {
 	u8                         sge_modifier_shift;
 	u8                         protocol_flags;
 	__le16                     max_sas_initiators;
-	__le16                     max_sas_targets;
+	__le16                     reserved2a;
 	__le16                     max_sas_expanders;
 	__le16                     max_enclosures;
 	__le16                     min_dev_handle;
 	__le16                     max_dev_handle;
-	__le16                     max_pc_ie_switches;
+	__le16                     max_pcie_switches;
 	__le16                     max_nvme;
-	__le16                     max_pds;
+	__le16                     reserved38;
 	__le16                     max_vds;
 	__le16                     max_host_pds;
-	__le16                     max_advanced_host_pds;
+	__le16                     max_adv_host_pds;
 	__le16                     max_raid_pds;
 	__le16                     max_posted_cmd_buffers;
 	__le32                     flags;
@@ -97,26 +102,41 @@ struct mpi3_ioc_facts_data {
 	__le16                     reserved4e;
 	__le32                     diag_trace_size;
 	__le32                     diag_fw_size;
+	__le32                     diag_driver_size;
+	u8                         max_host_pd_ns_count;
+	u8                         max_adv_host_pd_ns_count;
+	u8                         max_raidpd_ns_count;
+	u8                         reserved5f;
 };
 
-#define MPI3_IOCFACTS_CAPABILITY_ADVANCED_HOST_PD             (0x00000010)
+#define MPI3_IOCFACTS_CAPABILITY_NON_SUPERVISOR_MASK          (0x80000000)
+#define MPI3_IOCFACTS_CAPABILITY_SUPERVISOR_IOC               (0x00000000)
+#define MPI3_IOCFACTS_CAPABILITY_NON_SUPERVISOR_IOC           (0x10000000)
+#define MPI3_IOCFACTS_CAPABILITY_COMPLETE_RESET_CAPABLE       (0x00000100)
+#define MPI3_IOCFACTS_CAPABILITY_SEG_DIAG_TRACE_ENABLED       (0x00000080)
+#define MPI3_IOCFACTS_CAPABILITY_SEG_DIAG_FW_ENABLED          (0x00000040)
+#define MPI3_IOCFACTS_CAPABILITY_SEG_DIAG_DRIVER_ENABLED      (0x00000020)
+#define MPI3_IOCFACTS_CAPABILITY_ADVANCED_HOST_PD_ENABLED     (0x00000010)
 #define MPI3_IOCFACTS_CAPABILITY_RAID_CAPABLE                 (0x00000008)
-#define MPI3_IOCFACTS_CAPABILITY_COALESCE_CTRL_GRAN_MASK      (0x00000001)
-#define MPI3_IOCFACTS_CAPABILITY_COALESCE_CTRL_IOC_GRAN       (0x00000000)
-#define MPI3_IOCFACTS_CAPABILITY_COALESCE_CTRL_REPLY_Q_GRAN   (0x00000001)
+#define MPI3_IOCFACTS_CAPABILITY_MULTIPATH_ENABLED            (0x00000002)
+#define MPI3_IOCFACTS_CAPABILITY_COALESCE_CTRL_SUPPORTED      (0x00000001)
 #define MPI3_IOCFACTS_PID_TYPE_MASK                           (0xf000)
 #define MPI3_IOCFACTS_PID_TYPE_SHIFT                          (12)
 #define MPI3_IOCFACTS_PID_PRODUCT_MASK                        (0x0f00)
 #define MPI3_IOCFACTS_PID_PRODUCT_SHIFT                       (8)
 #define MPI3_IOCFACTS_PID_FAMILY_MASK                         (0x00ff)
 #define MPI3_IOCFACTS_PID_FAMILY_SHIFT                        (0)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_REKEY                   (0x2000)
+#define MPI3_IOCFACTS_EXCEPT_SAS_DISABLED                     (0x1000)
 #define MPI3_IOCFACTS_EXCEPT_SAFE_MODE                        (0x0800)
 #define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_MASK                (0x0700)
 #define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_NONE                (0x0000)
-#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_LOCAL_VIA_RAID      (0x0100)
-#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_LOCAL_VIA_OOB       (0x0200)
-#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_EXT_VIA_RAID        (0x0300)
-#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_EXT_VIA_OOB         (0x0400)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_LOCAL_VIA_MGMT      (0x0100)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_EXT_VIA_MGMT        (0x0200)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_DRIVE_EXT_VIA_MGMT  (0x0300)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_LOCAL_VIA_OOB       (0x0400)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_EXT_VIA_OOB         (0x0500)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_DRIVE_EXT_VIA_OOB   (0x0600)
 #define MPI3_IOCFACTS_EXCEPT_PCIE_DISABLED                    (0x0080)
 #define MPI3_IOCFACTS_EXCEPT_PARTIAL_MEMORY_FAILURE           (0x0040)
 #define MPI3_IOCFACTS_EXCEPT_MANUFACT_CHECKSUM_FAIL           (0x0020)
@@ -175,6 +195,7 @@ struct mpi3_create_request_queue_request {
 #define MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_MASK          (0x80)
 #define MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_SEGMENTED     (0x80)
 #define MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_CONTIGUOUS    (0x00)
+#define MPI3_CREATE_REQUEST_QUEUE_SIZE_MINIMUM                  (2)
 struct mpi3_delete_request_queue_request {
 	__le16             host_tag;
 	u8                 ioc_use_only02;
@@ -210,6 +231,7 @@ struct mpi3_create_reply_queue_request {
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_MASK           (0x01)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_DISABLE        (0x00)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_ENABLE         (0x01)
+#define MPI3_CREATE_REPLY_QUEUE_SIZE_MINIMUM                    (2)
 struct mpi3_delete_reply_queue_request {
 	__le16             host_tag;
 	u8                 ioc_use_only02;
@@ -255,7 +277,9 @@ struct mpi3_port_enable_request {
 #define MPI3_EVENT_SAS_DEVICE_DISCOVERY_ERROR       (0x19)
 #define MPI3_EVENT_PCIE_TOPOLOGY_CHANGE_LIST        (0x20)
 #define MPI3_EVENT_PCIE_ENUMERATION                 (0x22)
+#define MPI3_EVENT_PCIE_ERROR_THRESHOLD             (0x23)
 #define MPI3_EVENT_HARD_RESET_RECEIVED              (0x40)
+#define MPI3_EVENT_DIAGNOSTIC_BUFFER_STATUS_CHANGE  (0x50)
 #define MPI3_EVENT_MIN_PRODUCT_SPECIFIC             (0x60)
 #define MPI3_EVENT_MAX_PRODUCT_SPECIFIC             (0x7f)
 #define MPI3_EVENT_NOTIFY_EVENTMASK_WORDS           (4)
@@ -311,10 +335,9 @@ struct mpi3_event_data_temp_threshold {
 	__le32             reserved0c;
 };
 
-#define MPI3_EVENT_TEMP_THRESHOLD_STATUS_THRESHOLD3_EXCEEDED         (0x0008)
-#define MPI3_EVENT_TEMP_THRESHOLD_STATUS_THRESHOLD2_EXCEEDED         (0x0004)
-#define MPI3_EVENT_TEMP_THRESHOLD_STATUS_THRESHOLD1_EXCEEDED         (0x0002)
-#define MPI3_EVENT_TEMP_THRESHOLD_STATUS_THRESHOLD0_EXCEEDED         (0x0001)
+#define MPI3_EVENT_TEMP_THRESHOLD_STATUS_FATAL_THRESHOLD_EXCEEDED     (0x0004)
+#define MPI3_EVENT_TEMP_THRESHOLD_STATUS_CRITICAL_THRESHOLD_EXCEEDED  (0x0002)
+#define MPI3_EVENT_TEMP_THRESHOLD_STATUS_WARNING_THRESHOLD_EXCEEDED   (0x0001)
 struct mpi3_event_data_cable_management {
 	__le32             active_cable_power_requirement;
 	u8                 status;
@@ -398,8 +421,10 @@ struct mpi3_event_data_sas_discovery {
 #define MPI3_SAS_DISC_STATUS_MAX_EXPANDERS_EXCEED             (0x40000000)
 #define MPI3_SAS_DISC_STATUS_MAX_DEVICES_EXCEED               (0x20000000)
 #define MPI3_SAS_DISC_STATUS_MAX_TOPO_PHYS_EXCEED             (0x10000000)
+#define MPI3_SAS_DISC_STATUS_INVALID_CEI                      (0x00010000)
+#define MPI3_SAS_DISC_STATUS_FECEI_MISMATCH                   (0x00008000)
 #define MPI3_SAS_DISC_STATUS_MULTIPLE_DEVICES_IN_SLOT         (0x00004000)
-#define MPI3_SAS_DISC_STATUS_SLOT_COUNT_MISMATCH              (0x00002000)
+#define MPI3_SAS_DISC_STATUS_NECEI_MISMATCH                   (0x00002000)
 #define MPI3_SAS_DISC_STATUS_TOO_MANY_SLOTS                   (0x00001000)
 #define MPI3_SAS_DISC_STATUS_EXP_MULTI_SUBTRACTIVE            (0x00000800)
 #define MPI3_SAS_DISC_STATUS_MULTI_PORT_DOMAIN                (0x00000400)
@@ -581,6 +606,20 @@ struct mpi3_event_data_pcie_topology_change_list {
 #define MPI3_EVENT_PCIE_TOPO_SS_NOT_RESPONDING          (0x02)
 #define MPI3_EVENT_PCIE_TOPO_SS_RESPONDING              (0x03)
 #define MPI3_EVENT_PCIE_TOPO_SS_DELAY_NOT_RESPONDING    (0x04)
+struct mpi3_event_data_pcie_error_threshold {
+	__le64                                 timestamp;
+	u8                                     reason_code;
+	u8                                     port;
+	__le16                                 switch_dev_handle;
+	u8                                     error;
+	u8                                     action;
+	__le16                                 threshold_count;
+	__le16                                 attached_dev_handle;
+	__le16                                 reserved12;
+};
+
+#define MPI3_EVENT_PCI_ERROR_RC_THRESHOLD_EXCEEDED          (0x00)
+#define MPI3_EVENT_PCI_ERROR_RC_ESCALATION                  (0x01)
 struct mpi3_event_data_sas_init_dev_status_change {
 	u8                 reason_code;
 	u8                 io_unit_port;
@@ -604,6 +643,16 @@ struct mpi3_event_data_hard_reset_received {
 	__le16             reserved02;
 };
 
+struct mpi3_event_data_diag_buffer_status_change {
+	u8                 type;
+	u8                 reason_code;
+	__le16             reserved02;
+	__le32             reserved04;
+};
+
+#define MPI3_EVENT_DIAG_BUFFER_STATUS_CHANGE_RC_RELEASED             (0x01)
+#define MPI3_EVENT_DIAG_BUFFER_STATUS_CHANGE_RC_PAUSED               (0x02)
+#define MPI3_EVENT_DIAG_BUFFER_STATUS_CHANGE_RC_RESUMED              (0x03)
 #define MPI3_PEL_LOCALE_FLAGS_NON_BLOCKING_BOOT_EVENT   (0x0200)
 #define MPI3_PEL_LOCALE_FLAGS_BLOCKING_BOOT_EVENT       (0x0100)
 #define MPI3_PEL_LOCALE_FLAGS_PCIE                      (0x0080)
@@ -645,21 +694,23 @@ struct mpi3_pel_seq {
 };
 
 struct mpi3_pel_entry {
+	__le64                             time_stamp;
 	__le32                             sequence_number;
-	__le32                             time_stamp[2];
 	__le16                             log_code;
 	__le16                             arg_type;
 	__le16                             locale;
 	u8                                 class;
-	u8                                 reserved13;
+	u8                                 flags;
 	u8                                 ext_num;
 	u8                                 num_exts;
 	u8                                 arg_data_size;
-	u8                                 fixed_format_size;
+	u8                                 fixed_format_strings_size;
 	__le32                             reserved18[2];
 	__le32                             pel_info[24];
 };
 
+#define MPI3_PEL_FLAGS_COMPLETE_RESET_NEEDED                  (0x02)
+#define MPI3_PEL_FLAGS_ACK_NEEDED                             (0x01)
 struct mpi3_pel_list {
 	__le32                             log_count;
 	__le32                             reserved04;
@@ -837,7 +888,10 @@ struct mpi3_pel_req_action_acknowledge {
 	__le32                             reserved10;
 };
 
-#define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT            (0x01)
+#define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_MASK                     (0x03)
+#define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_NO_GUIDANCE              (0x00)
+#define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_CONTINUE_OP              (0x01)
+#define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_TRANSITION_TO_FAULT      (0x02)
 struct mpi3_pel_reply {
 	__le16                             host_tag;
 	u8                                 ioc_use_only02;
@@ -885,6 +939,7 @@ struct mpi3_ci_download_request {
 #define MPI3_CI_DOWNLOAD_ACTION_ONLINE_ACTIVATION              (0x02)
 #define MPI3_CI_DOWNLOAD_ACTION_OFFLINE_ACTIVATION             (0x03)
 #define MPI3_CI_DOWNLOAD_ACTION_GET_STATUS                     (0x04)
+#define MPI3_CI_DOWNLOAD_ACTION_CANCEL_OFFLINE_ACTIVATION      (0x05)
 struct mpi3_ci_download_reply {
 	__le16                             host_tag;
 	u8                                 ioc_use_only02;
@@ -902,6 +957,7 @@ struct mpi3_ci_download_reply {
 };
 
 #define MPI3_CI_DOWNLOAD_FLAGS_DOWNLOAD_IN_PROGRESS                  (0x80)
+#define MPI3_CI_DOWNLOAD_FLAGS_OFFLINE_ACTIVATION_REQUIRED           (0x20)
 #define MPI3_CI_DOWNLOAD_FLAGS_KEY_UPDATE_PENDING                    (0x10)
 #define MPI3_CI_DOWNLOAD_FLAGS_ACTIVATION_STATUS_MASK                (0x0e)
 #define MPI3_CI_DOWNLOAD_FLAGS_ACTIVATION_STATUS_NOT_NEEDED          (0x00)
@@ -939,19 +995,28 @@ struct mpi3_ci_upload_request {
 #define MPI3_CTRL_OP_REMOVE_DEVICE                                   (0x10)
 #define MPI3_CTRL_OP_CLOSE_PERSISTENT_CONNECTION                     (0x11)
 #define MPI3_CTRL_OP_HIDDEN_ACK                                      (0x12)
+#define MPI3_CTRL_OP_CLEAR_DEVICE_COUNTERS                           (0x13)
 #define MPI3_CTRL_OP_SAS_SEND_PRIMITIVE                              (0x20)
-#define MPI3_CTRL_OP_SAS_CLEAR_ERROR_LOG                             (0x21)
-#define MPI3_CTRL_OP_PCIE_CLEAR_ERROR_LOG                            (0x22)
+#define MPI3_CTRL_OP_SAS_PHY_CONTROL                                 (0x21)
+#define MPI3_CTRL_OP_READ_INTERNAL_BUS                               (0x23)
+#define MPI3_CTRL_OP_WRITE_INTERNAL_BUS                              (0x24)
+#define MPI3_CTRL_OP_PCIE_LINK_CONTROL                               (0x30)
 #define MPI3_CTRL_OP_LOOKUP_MAPPING_PARAM8_LOOKUP_METHOD_INDEX       (0x00)
 #define MPI3_CTRL_OP_UPDATE_TIMESTAMP_PARAM64_TIMESTAMP_INDEX        (0x00)
 #define MPI3_CTRL_OP_REMOVE_DEVICE_PARAM16_DEVHANDLE_INDEX           (0x00)
 #define MPI3_CTRL_OP_CLOSE_PERSIST_CONN_PARAM16_DEVHANDLE_INDEX      (0x00)
 #define MPI3_CTRL_OP_HIDDEN_ACK_PARAM16_DEVHANDLE_INDEX              (0x00)
+#define MPI3_CTRL_OP_CLEAR_DEVICE_COUNTERS_PARAM16_DEVHANDLE_INDEX   (0x00)
 #define MPI3_CTRL_OP_SAS_SEND_PRIM_PARAM8_PHY_INDEX                  (0x00)
 #define MPI3_CTRL_OP_SAS_SEND_PRIM_PARAM8_PRIMSEQ_INDEX              (0x01)
 #define MPI3_CTRL_OP_SAS_SEND_PRIM_PARAM32_PRIMITIVE_INDEX           (0x00)
-#define MPI3_CTRL_OP_SAS_CLEAR_ERR_LOG_PARAM8_PHY_INDEX              (0x00)
-#define MPI3_CTRL_OP_PCIE_CLEAR_ERR_LOG_PARAM8_PHY_INDEX             (0x00)
+#define MPI3_CTRL_OP_SAS_PHY_CONTROL_PARAM8_ACTION_INDEX             (0x00)
+#define MPI3_CTRL_OP_SAS_PHY_CONTROL_PARAM8_PHY_INDEX                (0x01)
+#define MPI3_CTRL_OP_READ_INTERNAL_BUS_PARAM64_ADDRESS_INDEX         (0x00)
+#define MPI3_CTRL_OP_WRITE_INTERNAL_BUS_PARAM64_ADDRESS_INDEX        (0x00)
+#define MPI3_CTRL_OP_WRITE_INTERNAL_BUS_PARAM32_VALUE_INDEX          (0x00)
+#define MPI3_CTRL_OP_PCIE_LINK_CONTROL_PARAM8_ACTION_INDEX           (0x00)
+#define MPI3_CTRL_OP_PCIE_LINK_CONTROL_PARAM8_LINK_INDEX             (0x01)
 #define MPI3_CTRL_LOOKUP_METHOD_WWID_ADDRESS                         (0x01)
 #define MPI3_CTRL_LOOKUP_METHOD_ENCLOSURE_SLOT                       (0x02)
 #define MPI3_CTRL_LOOKUP_METHOD_SAS_DEVICE_NAME                      (0x03)
@@ -966,9 +1031,14 @@ struct mpi3_ci_upload_request {
 #define MPI3_CTRL_LOOKUP_METHOD_PERSISTID_PARAM16_PERSISTENT_ID_INDEX   (1)
 #define MPI3_CTRL_LOOKUP_METHOD_VALUE16_DEVH_INDEX                      (0)
 #define MPI3_CTRL_GET_TIMESTAMP_VALUE64_TIMESTAMP_INDEX                 (0)
+#define MPI3_CTRL_READ_INTERNAL_BUS_VALUE32_VALUE_INDEX                 (0)
 #define MPI3_CTRL_PRIMFLAGS_SINGLE                                   (0x01)
 #define MPI3_CTRL_PRIMFLAGS_TRIPLE                                   (0x03)
 #define MPI3_CTRL_PRIMFLAGS_REDUNDANT                                (0x06)
+#define MPI3_CTRL_ACTION_NOP                                         (0x00)
+#define MPI3_CTRL_ACTION_LINK_RESET                                  (0x01)
+#define MPI3_CTRL_ACTION_HARD_RESET                                  (0x02)
+#define MPI3_CTRL_ACTION_CLEAR_ERROR_LOG                             (0x05)
 struct mpi3_iounit_control_request {
 	__le16                             host_tag;
 	u8                                 ioc_use_only02;
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_pci.h b/drivers/scsi/mpi3mr/mpi/mpi30_pci.h
new file mode 100644
index 0000000..dbfaf41
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_pci.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright 2016-2021 Broadcom Inc. All rights reserved.
+ *
+ */
+#ifndef MPI30_PCI_H
+#define MPI30_PCI_H     1
+#ifndef MPI3_NVME_ENCAP_CMD_MAX
+#define MPI3_NVME_ENCAP_CMD_MAX               (1)
+#endif
+struct mpi3_nvme_encapsulated_request {
+	__le16                     host_tag;
+	u8                         ioc_use_only02;
+	u8                         function;
+	__le16                     ioc_use_only04;
+	u8                         ioc_use_only06;
+	u8                         msg_flags;
+	__le16                     change_count;
+	__le16                     dev_handle;
+	__le16                     encapsulated_command_length;
+	__le16                     flags;
+	__le32                     reserved10[4];
+	__le32                     command[MPI3_NVME_ENCAP_CMD_MAX];
+};
+
+#define MPI3_NVME_FLAGS_FORCE_ADMIN_ERR_REPLY_MASK      (0x0002)
+#define MPI3_NVME_FLAGS_FORCE_ADMIN_ERR_REPLY_FAIL_ONLY (0x0000)
+#define MPI3_NVME_FLAGS_FORCE_ADMIN_ERR_REPLY_ALL       (0x0002)
+#define MPI3_NVME_FLAGS_SUBMISSIONQ_MASK                (0x0001)
+#define MPI3_NVME_FLAGS_SUBMISSIONQ_IO                  (0x0000)
+#define MPI3_NVME_FLAGS_SUBMISSIONQ_ADMIN               (0x0001)
+struct mpi3_nvme_encapsulated_error_reply {
+	__le16                     host_tag;
+	u8                         ioc_use_only02;
+	u8                         function;
+	__le16                     ioc_use_only04;
+	u8                         ioc_use_only06;
+	u8                         msg_flags;
+	__le16                     ioc_use_only08;
+	__le16                     ioc_status;
+	__le32                     ioc_log_info;
+	__le32                     nvme_completion_entry[4];
+};
+#endif
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_sas.h b/drivers/scsi/mpi3mr/mpi/mpi30_sas.h
index ba50187..298d895 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_sas.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_sas.h
@@ -30,4 +30,18 @@ struct mpi3_smp_passthrough_request {
 	struct mpi3_sge_common         request_sge;
 	struct mpi3_sge_common         response_sge;
 };
+
+struct mpi3_smp_passthrough_reply {
+	__le16                     host_tag;
+	u8                         ioc_use_only02;
+	u8                         function;
+	__le16                     ioc_use_only04;
+	u8                         ioc_use_only06;
+	u8                         msg_flags;
+	__le16                     ioc_use_only08;
+	__le16                     ioc_status;
+	__le32                     ioc_log_info;
+	__le16                     response_data_length;
+	__le16                     reserved12;
+};
 #endif
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
index 63e4e81..6d55011 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
@@ -19,8 +19,8 @@ union mpi3_version_union {
 
 #define MPI3_VERSION_MAJOR                                              (3)
 #define MPI3_VERSION_MINOR                                              (0)
-#define MPI3_VERSION_UNIT                                               (0)
-#define MPI3_VERSION_DEV                                                (18)
+#define MPI3_VERSION_UNIT                                               (22)
+#define MPI3_VERSION_DEV                                                (0)
 struct mpi3_sysif_oper_queue_indexes {
 	__le16         producer_index;
 	__le16         reserved02;
@@ -74,6 +74,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_IOC_INFO_HIGH_OFFSET                                 (0x00000004)
 #define MPI3_SYSIF_IOC_INFO_LOW_TIMEOUT_MASK                            (0xff000000)
 #define MPI3_SYSIF_IOC_INFO_LOW_TIMEOUT_SHIFT                           (24)
+#define MPI3_SYSIF_IOC_INFO_LOW_HCB_DISABLED                            (0x00000001)
 #define MPI3_SYSIF_IOC_CONFIG_OFFSET                                    (0x00000014)
 #define MPI3_SYSIF_IOC_CONFIG_OPER_RPY_ENT_SZ                           (0x00f00000)
 #define MPI3_SYSIF_IOC_CONFIG_OPER_RPY_ENT_SZ_SHIFT                     (20)
@@ -82,12 +83,13 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_MASK                             (0x0000c000)
 #define MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_NO                               (0x00000000)
 #define MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_NORMAL                           (0x00004000)
-#define MPI3_SYSIF_IOC_CONFIG_DEVICE_SHUTDOWN                           (0x00002000)
+#define MPI3_SYSIF_IOC_CONFIG_DEVICE_SHUTDOWN_SEND_REQ                  (0x00002000)
 #define MPI3_SYSIF_IOC_CONFIG_DIAG_SAVE                                 (0x00000010)
 #define MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC                                (0x00000001)
 #define MPI3_SYSIF_IOC_STATUS_OFFSET                                    (0x0000001c)
 #define MPI3_SYSIF_IOC_STATUS_RESET_HISTORY                             (0x00000010)
 #define MPI3_SYSIF_IOC_STATUS_SHUTDOWN_MASK                             (0x0000000c)
+#define MPI3_SYSIF_IOC_STATUS_SHUTDOWN_SHIFT                            (0x00000002)
 #define MPI3_SYSIF_IOC_STATUS_SHUTDOWN_NONE                             (0x00000000)
 #define MPI3_SYSIF_IOC_STATUS_SHUTDOWN_IN_PROGRESS                      (0x00000004)
 #define MPI3_SYSIF_IOC_STATUS_SHUTDOWN_COMPLETE                         (0x00000008)
@@ -107,9 +109,9 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_NO_CHANGE                    (0x00000000)
 #define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_DISABLE                      (0x40000000)
 #define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_ENABLE                       (0xc0000000)
-#define MPI3_SYSIF_COALESCE_CONTROL_VALID                               (0x30000000)
-#define MPI3_SYSIF_COALESCE_CONTROL_QUEUE_ID_MASK                       (0x00ff0000)
-#define MPI3_SYSIF_COALESCE_CONTROL_QUEUE_ID_SHIFT                      (16)
+#define MPI3_SYSIF_COALESCE_CONTROL_VALID                               (0x20000000)
+#define MPI3_SYSIF_COALESCE_CONTROL_MSIX_IDX_MASK                       (0x01ff0000)
+#define MPI3_SYSIF_COALESCE_CONTROL_MSIX_IDX_SHIFT                      (16)
 #define MPI3_SYSIF_COALESCE_CONTROL_TIMEOUT_MASK                        (0x0000ff00)
 #define MPI3_SYSIF_COALESCE_CONTROL_TIMEOUT_SHIFT                       (8)
 #define MPI3_SYSIF_COALESCE_CONTROL_DEPTH_MASK                          (0x000000ff)
@@ -117,9 +119,9 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_ADMIN_REQ_Q_PI_OFFSET                                (0x00001000)
 #define MPI3_SYSIF_ADMIN_REPLY_Q_CI_OFFSET                              (0x00001004)
 #define MPI3_SYSIF_OPER_REQ_Q_PI_OFFSET                                 (0x00001008)
-#define MPI3_SYSIF_OPER_REQ_Q_N_PI_OFFSET(n)                            (MPI3_SYSIF_OPER_REQ_Q_PI_OFFSET + (((n) - 1) * 8))
+#define MPI3_SYSIF_OPER_REQ_Q_N_PI_OFFSET(N)                            (MPI3_SYSIF_OPER_REQ_Q_PI_OFFSET + (((N) - 1) * 8))
 #define MPI3_SYSIF_OPER_REPLY_Q_CI_OFFSET                               (0x0000100c)
-#define MPI3_SYSIF_OPER_REPLY_Q_N_CI_OFFSET(n)                          (MPI3_SYSIF_OPER_REPLY_Q_CI_OFFSET + (((n) - 1) * 8))
+#define MPI3_SYSIF_OPER_REPLY_Q_N_CI_OFFSET(N)                          (MPI3_SYSIF_OPER_REPLY_Q_CI_OFFSET + (((N) - 1) * 8))
 #define MPI3_SYSIF_WRITE_SEQUENCE_OFFSET                                (0x00001c04)
 #define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_MASK                        (0x0000000f)
 #define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_FLUSH                       (0x0)
@@ -133,7 +135,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_MASK                          (0x00000700)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_NO_RESET                      (0x00000000)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET                    (0x00000100)
-#define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_FLASH_RCVRY_RESET             (0x00000200)
+#define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_HOST_CONTROL_BOOT_RESET       (0x00000200)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_COMPLETE_RESET                (0x00000300)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT                    (0x00000700)
 #define MPI3_SYSIF_HOST_DIAG_SAVE_IN_PROGRESS                           (0x00000080)
@@ -153,8 +155,9 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_FAULT_CODE_CI_ACTIVATION_RESET                       (0x0000f001)
 #define MPI3_SYSIF_FAULT_CODE_SOFT_RESET_IN_PROGRESS                    (0x0000f002)
 #define MPI3_SYSIF_FAULT_CODE_COMPLETE_RESET_NEEDED                     (0x0000f003)
-#define MPI3_SYSIF_FAULT_CODE_SAFE_MODE_EXIT                            (0x0000f004)
-#define MPI3_SYSIF_FAULT_CODE_FACTORY_RESET                             (0x0000f005)
+#define MPI3_SYSIF_FAULT_CODE_SOFT_RESET_NEEDED                         (0x0000f004)
+#define MPI3_SYSIF_FAULT_CODE_POWER_CYCLE_REQUIRED                      (0x0000f005)
+#define MPI3_SYSIF_FAULT_CODE_TEMP_THRESHOLD_EXCEEDED                   (0x0000f006)
 #define MPI3_SYSIF_FAULT_INFO0_OFFSET                                   (0x00001c14)
 #define MPI3_SYSIF_FAULT_INFO1_OFFSET                                   (0x00001c18)
 #define MPI3_SYSIF_FAULT_INFO2_OFFSET                                   (0x00001c1c)
@@ -409,6 +412,8 @@ struct mpi3_default_reply {
 #define MPI3_IOCSTATUS_INVALID_STATE                (0x0008)
 #define MPI3_IOCSTATUS_INSUFFICIENT_POWER           (0x000a)
 #define MPI3_IOCSTATUS_INVALID_CHANGE_COUNT         (0x000b)
+#define MPI3_IOCSTATUS_ALLOWED_CMD_BLOCK            (0x000c)
+#define MPI3_IOCSTATUS_SUPERVISOR_ONLY              (0x000d)
 #define MPI3_IOCSTATUS_FAILURE                      (0x001f)
 #define MPI3_IOCSTATUS_CONFIG_INVALID_ACTION        (0x0020)
 #define MPI3_IOCSTATUS_CONFIG_INVALID_TYPE          (0x0021)
@@ -448,8 +453,10 @@ struct mpi3_default_reply {
 #define MPI3_IOCSTATUS_CI_UNSUPPORTED               (0x00b0)
 #define MPI3_IOCSTATUS_CI_UPDATE_SEQUENCE           (0x00b1)
 #define MPI3_IOCSTATUS_CI_VALIDATION_FAILED         (0x00b2)
-#define MPI3_IOCSTATUS_CI_UPDATE_PENDING            (0x00b3)
+#define MPI3_IOCSTATUS_CI_KEY_UPDATE_PENDING        (0x00b3)
+#define MPI3_IOCSTATUS_CI_KEY_UPDATE_NOT_POSSIBLE   (0x00b4)
 #define MPI3_IOCSTATUS_SECURITY_KEY_REQUIRED        (0x00c0)
+#define MPI3_IOCSTATUS_SECURITY_VIOLATION           (0x00c1)
 #define MPI3_IOCSTATUS_INVALID_QUEUE_ID             (0x0f00)
 #define MPI3_IOCSTATUS_INVALID_QUEUE_SIZE           (0x0f01)
 #define MPI3_IOCSTATUS_INVALID_MSIX_VECTOR          (0x0f02)
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 9787b53..cdbd1cb 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -45,6 +45,7 @@
 #include "mpi/mpi30_init.h"
 #include "mpi/mpi30_ioc.h"
 #include "mpi/mpi30_sas.h"
+#include "mpi/mpi30_pci.h"
 #include "mpi3mr_debug.h"
 
 /* Global list and lock for storing multiple adapters managed by the driver */
@@ -121,7 +122,7 @@ extern int prot_mask;
 
 /* Definitions for Event replies and sense buffer allocated per controller */
 #define MPI3MR_NUM_EVT_REPLIES	64
-#define MPI3MR_SENSEBUF_SZ	256
+#define MPI3MR_SENSE_BUF_SZ	256
 #define MPI3MR_SENSEBUF_FACTOR	3
 #define MPI3MR_CHAINBUF_FACTOR	3
 #define MPI3MR_CHAINBUFDIX_FACTOR	2
@@ -263,7 +264,7 @@ struct mpi3mr_ioc_facts {
 	u16 max_vds;
 	u16 max_hpds;
 	u16 max_advhpds;
-	u16 max_raidpds;
+	u16 max_raid_pds;
 	u16 min_devhandle;
 	u16 max_devhandle;
 	u16 max_op_req_q;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 4ce79d7..12d5106 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -2012,7 +2012,7 @@ static void mpi3mr_watchdog_work(struct work_struct *work)
 			mpi3mr_print_fault_info(mrioc);
 		mrioc->diagsave_timeout = 0;
 
-		if (fault == MPI3_SYSIF_FAULT_CODE_FACTORY_RESET) {
+		if (fault == MPI3_SYSIF_FAULT_CODE_POWER_CYCLE_REQUIRED) {
 			ioc_info(mrioc,
 			    "Factory Reset fault occurred marking controller as unrecoverable"
 			    );
@@ -2377,14 +2377,13 @@ static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
 	mrioc->facts.reply_sz = le16_to_cpu(facts_data->reply_frame_size) * 4;
 	mrioc->facts.exceptions = le16_to_cpu(facts_data->ioc_exceptions);
 	mrioc->facts.max_perids = le16_to_cpu(facts_data->max_persistent_id);
-	mrioc->facts.max_pds = le16_to_cpu(facts_data->max_pds);
 	mrioc->facts.max_vds = le16_to_cpu(facts_data->max_vds);
 	mrioc->facts.max_hpds = le16_to_cpu(facts_data->max_host_pds);
-	mrioc->facts.max_advhpds = le16_to_cpu(facts_data->max_advanced_host_pds);
-	mrioc->facts.max_raidpds = le16_to_cpu(facts_data->max_raid_pds);
+	mrioc->facts.max_advhpds = le16_to_cpu(facts_data->max_adv_host_pds);
+	mrioc->facts.max_raid_pds = le16_to_cpu(facts_data->max_raid_pds);
 	mrioc->facts.max_nvme = le16_to_cpu(facts_data->max_nvme);
 	mrioc->facts.max_pcie_switches =
-	    le16_to_cpu(facts_data->max_pc_ie_switches);
+	    le16_to_cpu(facts_data->max_pcie_switches);
 	mrioc->facts.max_sasexpanders =
 	    le16_to_cpu(facts_data->max_sas_expanders);
 	mrioc->facts.max_sasinitiators =
@@ -2418,10 +2417,9 @@ static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
 	    mrioc->facts.ioc_num, mrioc->facts.max_op_req_q,
 	    mrioc->facts.max_op_reply_q, mrioc->facts.max_devhandle);
 	ioc_info(mrioc,
-	    "maxreqs(%d), mindh(%d) maxPDs(%d) maxvectors(%d) maxperids(%d)\n",
+	    "maxreqs(%d), mindh(%d) maxvectors(%d) maxperids(%d)\n",
 	    mrioc->facts.max_reqs, mrioc->facts.min_devhandle,
-	    mrioc->facts.max_pds, mrioc->facts.max_msix_vectors,
-	    mrioc->facts.max_perids);
+	    mrioc->facts.max_msix_vectors, mrioc->facts.max_perids);
 	ioc_info(mrioc, "SGEModMask 0x%x SGEModVal 0x%x SGEModShift 0x%x ",
 	    mrioc->facts.sge_mod_mask, mrioc->facts.sge_mod_value,
 	    mrioc->facts.sge_mod_shift);
@@ -2520,7 +2518,7 @@ static int mpi3mr_alloc_reply_sense_bufs(struct mpi3mr_ioc *mrioc)
 		goto out_failed;
 
 	/* sense buffer pool,  4 byte align */
-	sz = mrioc->num_sense_bufs * MPI3MR_SENSEBUF_SZ;
+	sz = mrioc->num_sense_bufs * MPI3MR_SENSE_BUF_SZ;
 	mrioc->sense_buf_pool = dma_pool_create("sense_buf pool",
 	    &mrioc->pdev->dev, sz, 4, 0);
 	if (!mrioc->sense_buf_pool) {
@@ -2556,10 +2554,10 @@ post_reply_sbuf:
 	    "reply_free_q pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB), reply_dma(0x%llx)\n",
 	    mrioc->reply_free_q, mrioc->reply_free_qsz, 8, (sz / 1024),
 	    (unsigned long long)mrioc->reply_free_q_dma);
-	sz = mrioc->num_sense_bufs * MPI3MR_SENSEBUF_SZ;
+	sz = mrioc->num_sense_bufs * MPI3MR_SENSE_BUF_SZ;
 	ioc_info(mrioc,
 	    "sense_buf pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB), sense_dma(0x%llx)\n",
-	    mrioc->sense_buf, mrioc->num_sense_bufs, MPI3MR_SENSEBUF_SZ,
+	    mrioc->sense_buf, mrioc->num_sense_bufs, MPI3MR_SENSE_BUF_SZ,
 	    (sz / 1024), (unsigned long long)mrioc->sense_buf_dma);
 	sz = mrioc->sense_buf_q_sz * 8;
 	ioc_info(mrioc,
@@ -2575,7 +2573,7 @@ post_reply_sbuf:
 
 	/* initialize Sense Buffer Queue */
 	for (i = 0, phy_addr = mrioc->sense_buf_dma;
-	    i < mrioc->num_sense_bufs; i++, phy_addr += MPI3MR_SENSEBUF_SZ)
+	    i < mrioc->num_sense_bufs; i++, phy_addr += MPI3MR_SENSE_BUF_SZ)
 		mrioc->sense_buf_q[i] = cpu_to_le64(phy_addr);
 	mrioc->sense_buf_q[i] = cpu_to_le64(0);
 	return retval;
@@ -2642,7 +2640,7 @@ static int mpi3mr_issue_iocinit(struct mpi3mr_ioc *mrioc)
 	iocinit_req.reply_free_queue_depth = cpu_to_le16(mrioc->reply_free_qsz);
 	iocinit_req.reply_free_queue_address =
 	    cpu_to_le64(mrioc->reply_free_q_dma);
-	iocinit_req.sense_buffer_length = cpu_to_le16(MPI3MR_SENSEBUF_SZ);
+	iocinit_req.sense_buffer_length = cpu_to_le16(MPI3MR_SENSE_BUF_SZ);
 	iocinit_req.sense_buffer_free_queue_depth =
 	    cpu_to_le16(mrioc->sense_buf_q_sz);
 	iocinit_req.sense_buffer_free_queue_address =
@@ -3667,7 +3665,7 @@ static void mpi3mr_issue_ioc_shutdown(struct mpi3mr_ioc *mrioc)
 
 	ioc_config = readl(&mrioc->sysif_regs->ioc_configuration);
 	ioc_config |= MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_NORMAL;
-	ioc_config |= MPI3_SYSIF_IOC_CONFIG_DEVICE_SHUTDOWN;
+	ioc_config |= MPI3_SYSIF_IOC_CONFIG_DEVICE_SHUTDOWN_SEND_REQ;
 
 	writel(ioc_config, &mrioc->sysif_regs->ioc_configuration);
 
-- 
2.27.0


--0000000000000b973605d3945d0e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
5AGo2E3pe+2yEgkxKvM2fnniZHUiSjbrfKk6nl9RIXPOKUP5HntZFdA5XuNYXWM+HPs3O0AJwBm/
VCZsZtkjVjxeBmTXiXDnxytdsHdGrHGymPfjJYatDu6d1KRVDlMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUClVHbAvhzGT8
s2/6xOf58NkGMQ8wDQYJKoZIhvcNAQELBQADggEBAENRsP1H3calKC2Sstg/8li8byKiqljCFkfi
IhcJsjPOOR9UZnMFxAoH/s2AlM7mQDR7rZ2MxRuUnIa6Cp5W5w1lUJHktjCUHnQq5nIAZ9GH5SDY
pgzbFsoYX8U2QCmkAC023FF++ZDJuc9aj0R/nhABxmUYErIze2jV/VO8Pj7TnCrBONZ/Qvf8G5CQ
X1hfOcCDBgT7eSvf9YRLaV935mB9/V+KYX8lT4E0lB4wQ0OLV8qUS9UuNoG2lCJ5UQTMrBgeUFFY
eKKhn+R91COmRlKGlaCdTtzKG5atS6dPnGEYUHjcpUvzejmJ5ghBk6P01HqSACsszDOzmBvdiOs+
Ux0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxyeqr1
0keLkvPdYw4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPCDQFrLV3JZ74NMVHUi
hPfiXrn0bJ1wyzsMIqHdMeZDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIxMTIyMDE0MDQxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCSkcMW0IhNqx5edDKqdBh6vvxxENYvp9jGhGUh
1N49kVptN+Hk5plEsMAnaSp1xuYtyohbSPoPMWSuPtk2h9A8I+7cIjSFMIfGw12UEwWcKNKpfxNX
EimVDb0Pg7foZBV2QljwEZ9O10IsHLrBu/NqnTDn/+aqeAgo6jjQBk0XMuaweuXs8HSB1SYK/+ui
28iaIBg8LuCzwaBOF2McXGHoNElZ9N8lMZI3r9E5hpSEwoLcNDE+kW5owschIYpEWxFzxkSUxc7z
wH53ouGBcsxnzJqyq0y0UUqtJp6dGvWPTQEDGRBMmtfp6Aq2FwjKUxgojDKnWpa8sLReg1Karxb/
--0000000000000b973605d3945d0e--
