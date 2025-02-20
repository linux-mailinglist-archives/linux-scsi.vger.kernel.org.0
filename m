Return-Path: <linux-scsi+bounces-12383-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17ADA3DCD1
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2025 15:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6287A4F12
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B31FCFC1;
	Thu, 20 Feb 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GpcrQvqB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86EA29
	for <linux-scsi@vger.kernel.org>; Thu, 20 Feb 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061798; cv=none; b=Gh4DUG34HnKwbdEXATM42Mbz6UET6CuuzLF9eMwxuCk21ROq/O2KrpiKHx3H1cfzRx/3qqPiktRiD2mrKsGtyC9s00Ptff5dM0nBxC09f5GJh4MRnt4rWVgh/IJoffP1EQGrT4sgTceYoSeFpCXJFoWdK4Xz9IYO209oExcl/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061798; c=relaxed/simple;
	bh=pyyQhUU+gfUYJNEp4ZYfaKLvYjHcYtPj/Bgr9XLa0+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBF+srTia3ZxQhWAvG64+AmAShlcyKuegPJcNFwN3E8kiFeKUrAAVVZsDATRCJRh9WtNcK3OWxClRbGC10fyHUwJ7kE3mR46+NgraIaD/K3+Yii4g91675BuEvpNMISSdiNRgbzk8RUa1PnDjByMNhYMH0VSF1Sbxlyg/yymwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GpcrQvqB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d132f16dso16023655ad.0
        for <linux-scsi@vger.kernel.org>; Thu, 20 Feb 2025 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740061795; x=1740666595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoXxEDWth3FmY1cDf+ULUdMdKlX0/F1wDxn2uWklfJQ=;
        b=GpcrQvqBlIxv357pY+Rr+UktZFJIKRX8BMYr3ETH+kCJ2kdoHEgd9Q67NfesWcqKTI
         JuDC4q/83C0fHs2BRi3JNz7yjtR32pJAvbr2c9+v54jRBw2a9igVUYoqrUrFFdUbeiyD
         iTBMG1Hx99E92RLXz8liRX+bFa3Bor7Baa8To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061795; x=1740666595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoXxEDWth3FmY1cDf+ULUdMdKlX0/F1wDxn2uWklfJQ=;
        b=OHQs9bZUjJM9lpBrNoTOsNl/7As0lDM2kaK4xHOYxLiqiFouDEXUgMyT/mxmlJKKxX
         Y4/m9AOJmwYYzxBqgVZdmOMYMw3deRIdOxWm2gX3PhcOag37FKXJ4n8et3bv2j2LXuRs
         zG16y2idQzEPSKKo/x8g/+mA6phrJiwc8SIfJ19q9glaZ61JFQ7CCvGXkc5NFHhAZWBi
         /5q0ZLg5v3W/LTuTfnCD+59/9MNO3ZYTPqU5gVyPB5/aIEgrteKO3xaCtBrP+r/jl+Jx
         cF1ioeejP82WJBs7C9UJFOaa5IFOnp4lGrIG8to66DJW2MvmJ4Ys9KIHyZDtmNwH1t1j
         sKzQ==
X-Gm-Message-State: AOJu0YwGcjZA1u1cTgRsmJLgq4CMWlQ281X2GvxX0igxTyGStBYCy7yt
	Y5b/xi7cOsQSRtuVmDMs/VUgKLpBVtVXc0N2PkuXh5fUcneGuF7pf5+FedJiKlYnOzs3gnLBy50
	hLMuGh2idtDEcprnrKEat/60kD/8Pu8/ktV/3gwPL9xDCbQbdJ0aoBDIxkUHQhvBp3dxkTqt+I1
	FgIhV2CqP1yE8zj39Jmbn7GuVlOKr4cdiN32bzpbqfwJCmbg==
X-Gm-Gg: ASbGncuUYAPlBXI2gZKXQZhW/XqmhvC1ljQLJl5H5eJBN021EsTx1N9OSBuKV1YwskD
	X8pMRsdNni3QxRjmGXWnf/SsRRQWl48dPsMCbiXzIr6DgYY5J7ycqsg7NQ48AZqi5ewyJFfXHPM
	KDd+2fb0xXt5SH45Beb05upBUhNiYc8EKFagSnrHoQCc1D9mafshWe6m/eJDmWByRf9hyQ814/R
	DWnHhwNtqB4NEvyjo3psATPFb0Zq3keor8fW3waNyR2DI5Z9QzbZp/MMjvzwziW20fdRrCx0GFb
	o7BlMNPW0ZkP3o2FlzVjRXYqIuThfW63tyeYUO3dA4jaCDVFR75RJ8VKXYU=
X-Google-Smtp-Source: AGHT+IFrY/DW7jdYFRDjQX327TUTYDYG5uiYpVkPaS3ZJUmHl0KmkvuDMCQK/ns0UP9JJyaQC3b+yQ==
X-Received: by 2002:a17:902:e80b:b0:220:d272:5343 with SMTP id d9443c01a7336-22170987f95mr113995945ad.27.1740061795158;
        Thu, 20 Feb 2025 06:29:55 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d47ba84fsm122551805ad.0.2025.02.20.06.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:29:54 -0800 (PST)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: rajsekhar.chundru@broadcom.com,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	prayas.patel@broadcom.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>
Subject: [PATCH v1 1/4] mpi3mr: Update MPI Headers to revision 35
Date: Thu, 20 Feb 2025 19:55:25 +0530
Message-Id: <20250220142528.20837-2-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250220142528.20837-1-ranjan.kumar@broadcom.com>
References: <20250220142528.20837-1-ranjan.kumar@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update MPI Headers to revision 35

Signed-off-by: Prayas Patel <prayas.patel@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h      |  4 ++++
 drivers/scsi/mpi3mr/mpi/mpi30_image.h     |  8 ++++++++
 drivers/scsi/mpi3mr/mpi/mpi30_init.h      | 11 ++++++++++-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h       | 21 +++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h | 20 +++++++++++++++++++-
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
index 00cd18edfad6..96401eb7e231 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
@@ -19,6 +19,7 @@
 #define MPI3_CONFIG_PAGETYPE_PCIE_SWITCH                (0x31)
 #define MPI3_CONFIG_PAGETYPE_PCIE_LINK                  (0x33)
 #define MPI3_CONFIG_PAGEATTR_MASK                       (0xf0)
+#define MPI3_CONFIG_PAGEATTR_SHIFT			(4)
 #define MPI3_CONFIG_PAGEATTR_READ_ONLY                  (0x00)
 #define MPI3_CONFIG_PAGEATTR_CHANGEABLE                 (0x10)
 #define MPI3_CONFIG_PAGEATTR_PERSISTENT                 (0x20)
@@ -29,10 +30,13 @@
 #define MPI3_CONFIG_ACTION_READ_PERSISTENT              (0x04)
 #define MPI3_CONFIG_ACTION_WRITE_PERSISTENT             (0x05)
 #define MPI3_DEVICE_PGAD_FORM_MASK                      (0xf0000000)
+#define MPI3_DEVICE_PGAD_FORM_SHIFT			(28)
 #define MPI3_DEVICE_PGAD_FORM_GET_NEXT_HANDLE           (0x00000000)
 #define MPI3_DEVICE_PGAD_FORM_HANDLE                    (0x20000000)
 #define MPI3_DEVICE_PGAD_HANDLE_MASK                    (0x0000ffff)
+#define MPI3_DEVICE_PGAD_HANDLE_SHIFT			(0)
 #define MPI3_SAS_EXPAND_PGAD_FORM_MASK                  (0xf0000000)
+#define MPI3_SAS_EXPAND_PGAD_FORM_SHIFT			(28)
 #define MPI3_SAS_EXPAND_PGAD_FORM_GET_NEXT_HANDLE       (0x00000000)
 #define MPI3_SAS_EXPAND_PGAD_FORM_HANDLE_PHY_NUM        (0x10000000)
 #define MPI3_SAS_EXPAND_PGAD_FORM_HANDLE                (0x20000000)
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_image.h b/drivers/scsi/mpi3mr/mpi/mpi30_image.h
index 2c6e548cbd0f..8d824107a678 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_image.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_image.h
@@ -66,7 +66,12 @@ struct mpi3_component_image_header {
 #define MPI3_IMAGE_HEADER_SIGNATURE1_SMM                      (0x204d4d53)
 #define MPI3_IMAGE_HEADER_SIGNATURE1_PSW                      (0x20575350)
 #define MPI3_IMAGE_HEADER_SIGNATURE2_VALUE                    (0x50584546)
+#define MPI3_IMAGE_HEADER_FLAGS_SIGNED_UEFI_MASK	        (0x00000300)
+#define MPI3_IMAGE_HEADER_FLAGS_SIGNED_UEFI_SHIFT		(8)
+#define MPI3_IMAGE_HEADER_FLAGS_CERT_CHAIN_FORMAT_MASK		(0x000000c0)
+#define MPI3_IMAGE_HEADER_FLAGS_CERT_CHAIN_FORMAT_SHIFT		(6)
 #define MPI3_IMAGE_HEADER_FLAGS_DEVICE_KEY_BASIS_MASK         (0x00000030)
+#define MPI3_IMAGE_HEADER_FLAGS_DEVICE_KEY_BASIS_SHIFT		(4)
 #define MPI3_IMAGE_HEADER_FLAGS_DEVICE_KEY_BASIS_CDI          (0x00000000)
 #define MPI3_IMAGE_HEADER_FLAGS_DEVICE_KEY_BASIS_DI           (0x00000010)
 #define MPI3_IMAGE_HEADER_FLAGS_SIGNED_NVDATA                 (0x00000008)
@@ -214,11 +219,13 @@ struct mpi3_encrypted_hash_entry {
 #define MPI3_HASH_IMAGE_TYPE_KEY_WITH_HASH_1_OF_2    (0x04)
 #define MPI3_HASH_IMAGE_TYPE_KEY_WITH_HASH_2_OF_2    (0x05)
 #define MPI3_HASH_ALGORITHM_VERSION_MASK             (0xe0)
+#define MPI3_HASH_ALGORITHM_VERSION_SHIFT		(5)
 #define MPI3_HASH_ALGORITHM_VERSION_NONE             (0x00)
 #define MPI3_HASH_ALGORITHM_VERSION_SHA1             (0x20)
 #define MPI3_HASH_ALGORITHM_VERSION_SHA2             (0x40)
 #define MPI3_HASH_ALGORITHM_VERSION_SHA3             (0x60)
 #define MPI3_HASH_ALGORITHM_SIZE_MASK                (0x1f)
+#define MPI3_HASH_ALGORITHM_SIZE_SHIFT			(0)
 #define MPI3_HASH_ALGORITHM_SIZE_UNUSED              (0x00)
 #define MPI3_HASH_ALGORITHM_SIZE_SHA256              (0x01)
 #define MPI3_HASH_ALGORITHM_SIZE_SHA512              (0x02)
@@ -236,6 +243,7 @@ struct mpi3_encrypted_hash_entry {
 #define MPI3_ENCRYPTION_ALGORITHM_ML_DSA_65	    (0x0c)
 #define MPI3_ENCRYPTION_ALGORITHM_ML_DSA_44	    (0x0d)
 #define MPI3_ENCRYPTED_HASH_ENTRY_FLAGS_PAIRED_KEY_MASK		(0x0f)
+#define MPI3_ENCRYPTED_HASH_ENTRY_FLAGS_PAIRED_KEY_SHIFT	(0)
 
 #ifndef MPI3_ENCRYPTED_HASH_ENTRY_MAX
 #define MPI3_ENCRYPTED_HASH_ENTRY_MAX               (1)
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_init.h b/drivers/scsi/mpi3mr/mpi/mpi30_init.h
index af86d12c8e49..bbef5bac92ed 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_init.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_init.h
@@ -38,23 +38,31 @@ struct mpi3_scsi_io_request {
 #define MPI3_SCSIIO_MSGFLAGS_METASGL_VALID                  (0x80)
 #define MPI3_SCSIIO_MSGFLAGS_DIVERT_TO_FIRMWARE             (0x40)
 #define MPI3_SCSIIO_FLAGS_LARGE_CDB                         (0x60000000)
+#define MPI3_SCSIIO_FLAGS_LARGE_CDB_MASK		    (0x60000000)
+#define MPI3_SCSIIO_FLAGS_LARGE_CDB_SHIFT		    (29)
+#define MPI3_SCSIIO_FLAGS_IOC_USE_ONLY_27_MASK		    (0x18000000)
+#define MPI3_SCSIIO_FLAGS_IOC_USE_ONLY_27_SHIFT		    (27)
 #define MPI3_SCSIIO_FLAGS_CDB_16_OR_LESS                    (0x00000000)
 #define MPI3_SCSIIO_FLAGS_CDB_GREATER_THAN_16               (0x20000000)
 #define MPI3_SCSIIO_FLAGS_CDB_IN_SEPARATE_BUFFER            (0x40000000)
 #define MPI3_SCSIIO_FLAGS_TASKATTRIBUTE_MASK                (0x07000000)
+#define MPI3_SCSIIO_FLAGS_TASKATTRIBUTE_SHIFT		    (24)
+#define MPI3_SCSIIO_FLAGS_DATADIRECTION_MASK		    (0x000c0000)
+#define MPI3_SCSIIO_FLAGS_DATADIRECTION_SHIFT               (18)
 #define MPI3_SCSIIO_FLAGS_TASKATTRIBUTE_SIMPLEQ             (0x00000000)
 #define MPI3_SCSIIO_FLAGS_TASKATTRIBUTE_HEADOFQ             (0x01000000)
 #define MPI3_SCSIIO_FLAGS_TASKATTRIBUTE_ORDEREDQ            (0x02000000)
 #define MPI3_SCSIIO_FLAGS_TASKATTRIBUTE_ACAQ                (0x04000000)
 #define MPI3_SCSIIO_FLAGS_CMDPRI_MASK                       (0x00f00000)
 #define MPI3_SCSIIO_FLAGS_CMDPRI_SHIFT                      (20)
-#define MPI3_SCSIIO_FLAGS_DATADIRECTION_MASK                (0x000c0000)
 #define MPI3_SCSIIO_FLAGS_DATADIRECTION_NO_DATA_TRANSFER    (0x00000000)
 #define MPI3_SCSIIO_FLAGS_DATADIRECTION_WRITE               (0x00040000)
 #define MPI3_SCSIIO_FLAGS_DATADIRECTION_READ                (0x00080000)
 #define MPI3_SCSIIO_FLAGS_DMAOPERATION_MASK                 (0x00030000)
+#define MPI3_SCSIIO_FLAGS_DMAOPERATION_SHIFT			(16)
 #define MPI3_SCSIIO_FLAGS_DMAOPERATION_HOST_PI              (0x00010000)
 #define MPI3_SCSIIO_FLAGS_DIVERT_REASON_MASK                (0x000000f0)
+#define MPI3_SCSIIO_FLAGS_DIVERT_REASON_SHIFT			(4)
 #define MPI3_SCSIIO_FLAGS_DIVERT_REASON_IO_THROTTLING       (0x00000010)
 #define MPI3_SCSIIO_FLAGS_DIVERT_REASON_WRITE_SAME_TOO_LARGE (0x00000020)
 #define MPI3_SCSIIO_FLAGS_DIVERT_REASON_PROD_SPECIFIC       (0x00000080)
@@ -99,6 +107,7 @@ struct mpi3_scsi_io_reply {
 #define MPI3_SCSI_STATUS_ACA_ACTIVE             (0x30)
 #define MPI3_SCSI_STATUS_TASK_ABORTED           (0x40)
 #define MPI3_SCSI_STATE_SENSE_MASK              (0x03)
+#define MPI3_SCSI_STATE_SENSE_SHIFT		(0)
 #define MPI3_SCSI_STATE_SENSE_VALID             (0x00)
 #define MPI3_SCSI_STATE_SENSE_FAILED            (0x01)
 #define MPI3_SCSI_STATE_SENSE_BUFF_Q_EMPTY      (0x02)
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
index c374867f9ba0..b42933fcd423 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
@@ -30,6 +30,7 @@ struct mpi3_ioc_init_request {
 #define MPI3_IOCINIT_MSGFLAGS_WRITESAMEDIVERT_SUPPORTED		(0x08)
 #define MPI3_IOCINIT_MSGFLAGS_SCSIIOSTATUSREPLY_SUPPORTED	(0x04)
 #define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_MASK          (0x03)
+#define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_SHIFT	(0)
 #define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_NOT_USED      (0x00)
 #define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_SEPARATED     (0x01)
 #define MPI3_IOCINIT_MSGFLAGS_HOSTMETADATA_INLINE        (0x02)
@@ -40,6 +41,7 @@ struct mpi3_ioc_init_request {
 #define MPI3_WHOINIT_MANUFACTURER                        (0x04)
 
 #define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_MASK              (0x00000003)
+#define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_SHIFT		    (0)
 #define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_NO_GUIDANCE       (0x00000000)
 #define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_NO_SPECIAL        (0x00000001)
 #define MPI3_IOCINIT_DRIVERCAP_OSEXPOSURE_REPORT_AS_HDD     (0x00000002)
@@ -111,9 +113,11 @@ struct mpi3_ioc_facts_data {
 	__le32			   diag_tty_size;
 };
 #define MPI3_IOCFACTS_CAPABILITY_NON_SUPERVISOR_MASK          (0x80000000)
+#define MPI3_IOCFACTS_CAPABILITY_NON_SUPERVISOR_SHIFT		(31)
 #define MPI3_IOCFACTS_CAPABILITY_SUPERVISOR_IOC               (0x00000000)
 #define MPI3_IOCFACTS_CAPABILITY_NON_SUPERVISOR_IOC           (0x80000000)
 #define MPI3_IOCFACTS_CAPABILITY_INT_COALESCE_MASK            (0x00000600)
+#define MPI3_IOCFACTS_CAPABILITY_INT_COALESCE_SHIFT		(9)
 #define MPI3_IOCFACTS_CAPABILITY_INT_COALESCE_FIXED_THRESHOLD (0x00000000)
 #define MPI3_IOCFACTS_CAPABILITY_INT_COALESCE_OUTSTANDING_IO  (0x00000200)
 #define MPI3_IOCFACTS_CAPABILITY_COMPLETE_RESET_SUPPORTED     (0x00000100)
@@ -134,6 +138,7 @@ struct mpi3_ioc_facts_data {
 #define MPI3_IOCFACTS_EXCEPT_SAS_DISABLED                     (0x1000)
 #define MPI3_IOCFACTS_EXCEPT_SAFE_MODE                        (0x0800)
 #define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_MASK                (0x0700)
+#define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_SHIFT			(8)
 #define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_NONE                (0x0000)
 #define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_LOCAL_VIA_MGMT      (0x0100)
 #define MPI3_IOCFACTS_EXCEPT_SECURITY_KEY_EXT_VIA_MGMT        (0x0200)
@@ -149,6 +154,7 @@ struct mpi3_ioc_facts_data {
 #define MPI3_IOCFACTS_EXCEPT_BLOCKING_BOOT_EVENT              (0x0004)
 #define MPI3_IOCFACTS_EXCEPT_SECURITY_SELFTEST_FAILURE        (0x0002)
 #define MPI3_IOCFACTS_EXCEPT_BOOTSTAT_MASK                    (0x0001)
+#define MPI3_IOCFACTS_EXCEPT_BOOTSTAT_SHIFT			(0)
 #define MPI3_IOCFACTS_EXCEPT_BOOTSTAT_PRIMARY                 (0x0000)
 #define MPI3_IOCFACTS_EXCEPT_BOOTSTAT_SECONDARY               (0x0001)
 #define MPI3_IOCFACTS_PROTOCOL_SAS                            (0x0010)
@@ -161,10 +167,12 @@ struct mpi3_ioc_facts_data {
 #define MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK            (0x0000ff00)
 #define MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT           (8)
 #define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_MASK          (0x00000030)
+#define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_SHIFT		(4)
 #define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_NOT_STARTED   (0x00000000)
 #define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_IN_PROGRESS   (0x00000010)
 #define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_COMPLETE      (0x00000020)
 #define MPI3_IOCFACTS_FLAGS_PERSONALITY_MASK                  (0x0000000f)
+#define MPI3_IOCFACTS_FLAGS_PERSONALITY_SHIFT			(0)
 #define MPI3_IOCFACTS_FLAGS_PERSONALITY_EHBA                  (0x00000000)
 #define MPI3_IOCFACTS_FLAGS_PERSONALITY_RAID_DDR              (0x00000002)
 #define MPI3_IOCFACTS_IO_THROTTLE_DATA_LENGTH_NOT_REQUIRED    (0x0000)
@@ -204,6 +212,7 @@ struct mpi3_create_request_queue_request {
 };
 
 #define MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_MASK          (0x80)
+#define MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_SHIFT		(7)
 #define MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_SEGMENTED     (0x80)
 #define MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_CONTIGUOUS    (0x00)
 #define MPI3_CREATE_REQUEST_QUEUE_SIZE_MINIMUM                  (2)
@@ -237,10 +246,12 @@ struct mpi3_create_reply_queue_request {
 };
 
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_SEGMENTED_MASK            (0x80)
+#define MPI3_CREATE_REPLY_QUEUE_FLAGS_SEGMENTED_SHIFT		(7)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_SEGMENTED_SEGMENTED       (0x80)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_SEGMENTED_CONTIGUOUS      (0x00)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_COALESCE_DISABLE          (0x02)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_MASK           (0x01)
+#define MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_SHIFT		(0)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_DISABLE        (0x00)
 #define MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_ENABLE         (0x01)
 #define MPI3_CREATE_REPLY_QUEUE_SIZE_MINIMUM                    (2)
@@ -326,9 +337,11 @@ struct mpi3_event_notification_reply {
 };
 
 #define MPI3_EVENT_NOTIFY_MSGFLAGS_ACK_MASK                        (0x01)
+#define MPI3_EVENT_NOTIFY_MSGFLAGS_ACK_SHIFT			    (0)
 #define MPI3_EVENT_NOTIFY_MSGFLAGS_ACK_REQUIRED                    (0x01)
 #define MPI3_EVENT_NOTIFY_MSGFLAGS_ACK_NOT_REQUIRED                (0x00)
 #define MPI3_EVENT_NOTIFY_MSGFLAGS_EVENT_ORIGINALITY_MASK          (0x02)
+#define MPI3_EVENT_NOTIFY_MSGFLAGS_EVENT_ORIGINALITY_SHIFT	    (1)
 #define MPI3_EVENT_NOTIFY_MSGFLAGS_EVENT_ORIGINALITY_ORIGINAL      (0x00)
 #define MPI3_EVENT_NOTIFY_MSGFLAGS_EVENT_ORIGINALITY_REPLAY        (0x02)
 struct mpi3_event_data_gpio_interrupt {
@@ -487,6 +500,7 @@ struct mpi3_event_sas_topo_phy_entry {
 #define MPI3_EVENT_SAS_TOPO_PHY_STATUS_NO_EXIST             (0x40)
 #define MPI3_EVENT_SAS_TOPO_PHY_STATUS_VACANT               (0x80)
 #define MPI3_EVENT_SAS_TOPO_PHY_RC_MASK                     (0x0f)
+#define MPI3_EVENT_SAS_TOPO_PHY_RC_SHIFT		    (0)
 #define MPI3_EVENT_SAS_TOPO_PHY_RC_TARG_NOT_RESPONDING      (0x02)
 #define MPI3_EVENT_SAS_TOPO_PHY_RC_PHY_CHANGED              (0x03)
 #define MPI3_EVENT_SAS_TOPO_PHY_RC_NO_CHANGE                (0x04)
@@ -566,6 +580,7 @@ struct mpi3_event_pcie_topo_port_entry {
 #define MPI3_EVENT_PCIE_TOPO_PS_DELAY_NOT_RESPONDING    (0x05)
 #define MPI3_EVENT_PCIE_TOPO_PS_RESPONDING              (0x06)
 #define MPI3_EVENT_PCIE_TOPO_PI_LANES_MASK              (0xf0)
+#define MPI3_EVENT_PCIE_TOPO_PI_LANES_SHIFT		(4)
 #define MPI3_EVENT_PCIE_TOPO_PI_LANES_UNKNOWN           (0x00)
 #define MPI3_EVENT_PCIE_TOPO_PI_LANES_1                 (0x10)
 #define MPI3_EVENT_PCIE_TOPO_PI_LANES_2                 (0x20)
@@ -573,6 +588,7 @@ struct mpi3_event_pcie_topo_port_entry {
 #define MPI3_EVENT_PCIE_TOPO_PI_LANES_8                 (0x40)
 #define MPI3_EVENT_PCIE_TOPO_PI_LANES_16                (0x50)
 #define MPI3_EVENT_PCIE_TOPO_PI_RATE_MASK               (0x0f)
+#define MPI3_EVENT_PCIE_TOPO_PI_RATE_SHIFT		(0)
 #define MPI3_EVENT_PCIE_TOPO_PI_RATE_UNKNOWN            (0x00)
 #define MPI3_EVENT_PCIE_TOPO_PI_RATE_DISABLED           (0x01)
 #define MPI3_EVENT_PCIE_TOPO_PI_RATE_2_5                (0x02)
@@ -881,6 +897,7 @@ struct mpi3_pel_req_action_acknowledge {
 };
 
 #define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_MASK                     (0x03)
+#define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_SHIFT			(0)
 #define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_NO_GUIDANCE              (0x00)
 #define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_CONTINUE_OP              (0x01)
 #define MPI3_PELACKNOWLEDGE_MSGFLAGS_SAFE_MODE_EXIT_TRANSITION_TO_FAULT      (0x02)
@@ -924,6 +941,7 @@ struct mpi3_ci_download_request {
 #define MPI3_CI_DOWNLOAD_MSGFLAGS_FORCE_FMC_ENABLE             (0x40)
 #define MPI3_CI_DOWNLOAD_MSGFLAGS_SIGNED_NVDATA                (0x20)
 #define MPI3_CI_DOWNLOAD_MSGFLAGS_WRITE_CACHE_FLUSH_MASK       (0x03)
+#define MPI3_CI_DOWNLOAD_MSGFLAGS_WRITE_CACHE_FLUSH_SHIFT	(0)
 #define MPI3_CI_DOWNLOAD_MSGFLAGS_WRITE_CACHE_FLUSH_FAST       (0x00)
 #define MPI3_CI_DOWNLOAD_MSGFLAGS_WRITE_CACHE_FLUSH_MEDIUM     (0x01)
 #define MPI3_CI_DOWNLOAD_MSGFLAGS_WRITE_CACHE_FLUSH_SLOW       (0x02)
@@ -953,6 +971,7 @@ struct mpi3_ci_download_reply {
 #define MPI3_CI_DOWNLOAD_FLAGS_OFFLINE_ACTIVATION_REQUIRED           (0x20)
 #define MPI3_CI_DOWNLOAD_FLAGS_KEY_UPDATE_PENDING                    (0x10)
 #define MPI3_CI_DOWNLOAD_FLAGS_ACTIVATION_STATUS_MASK                (0x0e)
+#define MPI3_CI_DOWNLOAD_FLAGS_ACTIVATION_STATUS_SHIFT			(1)
 #define MPI3_CI_DOWNLOAD_FLAGS_ACTIVATION_STATUS_NOT_NEEDED          (0x00)
 #define MPI3_CI_DOWNLOAD_FLAGS_ACTIVATION_STATUS_AWAITING            (0x02)
 #define MPI3_CI_DOWNLOAD_FLAGS_ACTIVATION_STATUS_ONLINE_PENDING      (0x04)
@@ -976,9 +995,11 @@ struct mpi3_ci_upload_request {
 };
 
 #define MPI3_CI_UPLOAD_MSGFLAGS_LOCATION_MASK                        (0x01)
+#define MPI3_CI_UPLOAD_MSGFLAGS_LOCATION_SHIFT				(0)
 #define MPI3_CI_UPLOAD_MSGFLAGS_LOCATION_PRIMARY                     (0x00)
 #define MPI3_CI_UPLOAD_MSGFLAGS_LOCATION_SECONDARY                   (0x01)
 #define MPI3_CI_UPLOAD_MSGFLAGS_FORMAT_MASK                          (0x02)
+#define MPI3_CI_UPLOAD_MSGFLAGS_FORMAT_SHIFT				(1)
 #define MPI3_CI_UPLOAD_MSGFLAGS_FORMAT_FLASH                         (0x00)
 #define MPI3_CI_UPLOAD_MSGFLAGS_FORMAT_EXECUTABLE                    (0x02)
 #define MPI3_CTRL_OP_FORCE_FULL_DISCOVERY                            (0x01)
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
index b2ab25a1cfeb..5c522e2531c3 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
@@ -18,7 +18,7 @@ union mpi3_version_union {
 
 #define MPI3_VERSION_MAJOR                                              (3)
 #define MPI3_VERSION_MINOR                                              (0)
-#define MPI3_VERSION_UNIT                                               (34)
+#define MPI3_VERSION_UNIT                                               (35)
 #define MPI3_VERSION_DEV                                                (0)
 #define MPI3_DEVHANDLE_INVALID                                          (0xffff)
 struct mpi3_sysif_oper_queue_indexes {
@@ -80,6 +80,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_IOC_CONFIG_OPER_RPY_ENT_SZ_SHIFT                     (20)
 #define MPI3_SYSIF_IOC_CONFIG_OPER_REQ_ENT_SZ                           (0x000f0000)
 #define MPI3_SYSIF_IOC_CONFIG_OPER_REQ_ENT_SZ_SHIFT                     (16)
+#define MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_SHIFT				(14)
 #define MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_MASK                             (0x0000c000)
 #define MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_NO                               (0x00000000)
 #define MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_NORMAL                           (0x00004000)
@@ -97,6 +98,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_IOC_STATUS_READY                                     (0x00000001)
 #define MPI3_SYSIF_ADMIN_Q_NUM_ENTRIES_OFFSET                           (0x00000024)
 #define MPI3_SYSIF_ADMIN_Q_NUM_ENTRIES_REQ_MASK                         (0x0fff)
+#define MPI3_SYSIF_ADMIN_Q_NUM_ENTRIES_REQ_SHIFT			(0)
 #define MPI3_SYSIF_ADMIN_Q_NUM_ENTRIES_REPLY_OFFSET                     (0x00000026)
 #define MPI3_SYSIF_ADMIN_Q_NUM_ENTRIES_REPLY_MASK                       (0x0fff0000)
 #define MPI3_SYSIF_ADMIN_Q_NUM_ENTRIES_REPLY_SHIFT                      (16)
@@ -106,6 +108,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_ADMIN_REPLY_Q_ADDR_HIGH_OFFSET                       (0x00000034)
 #define MPI3_SYSIF_COALESCE_CONTROL_OFFSET                              (0x00000040)
 #define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_MASK                         (0xc0000000)
+#define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_SHIFT			(30)
 #define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_NO_CHANGE                    (0x00000000)
 #define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_DISABLE                      (0x40000000)
 #define MPI3_SYSIF_COALESCE_CONTROL_ENABLE_ENABLE                       (0xc0000000)
@@ -124,6 +127,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_OPER_REPLY_Q_N_CI_OFFSET(N)                          (MPI3_SYSIF_OPER_REPLY_Q_CI_OFFSET + (((N) - 1) * 8))
 #define MPI3_SYSIF_WRITE_SEQUENCE_OFFSET                                (0x00001c04)
 #define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_MASK                        (0x0000000f)
+#define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_SHIFT			(0)
 #define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_FLUSH                       (0x0)
 #define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_1ST                         (0xf)
 #define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND                         (0x4)
@@ -133,6 +137,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_6TH                         (0xd)
 #define MPI3_SYSIF_HOST_DIAG_OFFSET                                     (0x00001c08)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_MASK                          (0x00000700)
+#define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SHIFT				(8)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_NO_RESET                      (0x00000000)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET                    (0x00000100)
 #define MPI3_SYSIF_HOST_DIAG_RESET_ACTION_HOST_CONTROL_BOOT_RESET       (0x00000200)
@@ -151,6 +156,7 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_FAULT_FUNC_AREA_SHIFT                                (24)
 #define MPI3_SYSIF_FAULT_FUNC_AREA_MPI_DEFINED                          (0x00000000)
 #define MPI3_SYSIF_FAULT_CODE_MASK                                      (0x0000ffff)
+#define MPI3_SYSIF_FAULT_CODE_SHIFT					(0)
 #define MPI3_SYSIF_FAULT_CODE_DIAG_FAULT_RESET                          (0x0000f000)
 #define MPI3_SYSIF_FAULT_CODE_CI_ACTIVATION_RESET                       (0x0000f001)
 #define MPI3_SYSIF_FAULT_CODE_SOFT_RESET_IN_PROGRESS                    (0x0000f002)
@@ -176,17 +182,20 @@ struct mpi3_sysif_registers {
 #define MPI3_SYSIF_DIAG_RW_ADDRESS_HIGH_OFFSET                          (0x00001c5c)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_OFFSET                               (0x00001c60)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_LEN_MASK                             (0x00000030)
+#define MPI3_SYSIF_DIAG_RW_CONTROL_LEN_SHIFT				(4)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_LEN_1BYTE                            (0x00000000)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_LEN_2BYTES                           (0x00000010)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_LEN_4BYTES                           (0x00000020)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_LEN_8BYTES                           (0x00000030)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_RESET                                (0x00000004)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_DIR_MASK                             (0x00000002)
+#define MPI3_SYSIF_DIAG_RW_CONTROL_DIR_SHIFT				(1)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_DIR_READ                             (0x00000000)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_DIR_WRITE                            (0x00000002)
 #define MPI3_SYSIF_DIAG_RW_CONTROL_START                                (0x00000001)
 #define MPI3_SYSIF_DIAG_RW_STATUS_OFFSET                                (0x00001c62)
 #define MPI3_SYSIF_DIAG_RW_STATUS_STATUS_MASK                           (0x0000000e)
+#define MPI3_SYSIF_DIAG_RW_STATUS_STATUS_SHIFT				(1)
 #define MPI3_SYSIF_DIAG_RW_STATUS_STATUS_SUCCESS                        (0x00000000)
 #define MPI3_SYSIF_DIAG_RW_STATUS_STATUS_INV_ADDR                       (0x00000002)
 #define MPI3_SYSIF_DIAG_RW_STATUS_STATUS_ACC_ERR                        (0x00000004)
@@ -207,7 +216,9 @@ struct mpi3_default_reply_descriptor {
 };
 
 #define MPI3_REPLY_DESCRIPT_FLAGS_PHASE_MASK                       (0x0001)
+#define MPI3_REPLY_DESCRIPT_FLAGS_PHASE_SHIFT				(0)
 #define MPI3_REPLY_DESCRIPT_FLAGS_TYPE_MASK                        (0xf000)
+#define MPI3_REPLY_DESCRIPT_FLAGS_TYPE_SHIFT				(12)
 #define MPI3_REPLY_DESCRIPT_FLAGS_TYPE_ADDRESS_REPLY               (0x0000)
 #define MPI3_REPLY_DESCRIPT_FLAGS_TYPE_SUCCESS                     (0x1000)
 #define MPI3_REPLY_DESCRIPT_FLAGS_TYPE_TARGET_COMMAND_BUFFER       (0x2000)
@@ -301,6 +312,7 @@ union mpi3_sge_union {
 };
 
 #define MPI3_SGE_FLAGS_ELEMENT_TYPE_MASK        (0xf0)
+#define MPI3_SGE_FLAGS_ELEMENT_TYPE_SHIFT	(4)
 #define MPI3_SGE_FLAGS_ELEMENT_TYPE_SIMPLE      (0x00)
 #define MPI3_SGE_FLAGS_ELEMENT_TYPE_BIT_BUCKET  (0x10)
 #define MPI3_SGE_FLAGS_ELEMENT_TYPE_CHAIN       (0x20)
@@ -309,6 +321,7 @@ union mpi3_sge_union {
 #define MPI3_SGE_FLAGS_END_OF_LIST              (0x08)
 #define MPI3_SGE_FLAGS_END_OF_BUFFER            (0x04)
 #define MPI3_SGE_FLAGS_DLAS_MASK                (0x03)
+#define MPI3_SGE_FLAGS_DLAS_SHIFT		(0)
 #define MPI3_SGE_FLAGS_DLAS_SYSTEM              (0x00)
 #define MPI3_SGE_FLAGS_DLAS_IOC_UDP             (0x01)
 #define MPI3_SGE_FLAGS_DLAS_IOC_CTL             (0x02)
@@ -322,15 +335,18 @@ union mpi3_sge_union {
 #define MPI3_EEDPFLAGS_CHK_APP_TAG                  (0x0200)
 #define MPI3_EEDPFLAGS_CHK_GUARD                    (0x0100)
 #define MPI3_EEDPFLAGS_ESC_MODE_MASK                (0x00c0)
+#define MPI3_EEDPFLAGS_ESC_MODE_SHIFT			(6)
 #define MPI3_EEDPFLAGS_ESC_MODE_DO_NOT_DISABLE      (0x0040)
 #define MPI3_EEDPFLAGS_ESC_MODE_APPTAG_DISABLE      (0x0080)
 #define MPI3_EEDPFLAGS_ESC_MODE_APPTAG_REFTAG_DISABLE   (0x00c0)
 #define MPI3_EEDPFLAGS_HOST_GUARD_MASK              (0x0030)
+#define MPI3_EEDPFLAGS_HOST_GUARD_SHIFT			(4)
 #define MPI3_EEDPFLAGS_HOST_GUARD_T10_CRC           (0x0000)
 #define MPI3_EEDPFLAGS_HOST_GUARD_IP_CHKSUM         (0x0010)
 #define MPI3_EEDPFLAGS_HOST_GUARD_OEM_SPECIFIC      (0x0020)
 #define MPI3_EEDPFLAGS_PT_REF_TAG                   (0x0008)
 #define MPI3_EEDPFLAGS_EEDP_OP_MASK                 (0x0007)
+#define MPI3_EEDPFLAGS_EEDP_OP_SHIFT			(0)
 #define MPI3_EEDPFLAGS_EEDP_OP_CHECK                (0x0001)
 #define MPI3_EEDPFLAGS_EEDP_OP_STRIP                (0x0002)
 #define MPI3_EEDPFLAGS_EEDP_OP_CHECK_REMOVE         (0x0003)
@@ -403,6 +419,7 @@ struct mpi3_default_reply {
 #define MPI3_IOCSTATUS_LOG_INFO_AVAIL_MASK          (0x8000)
 #define MPI3_IOCSTATUS_LOG_INFO_AVAILABLE           (0x8000)
 #define MPI3_IOCSTATUS_STATUS_MASK                  (0x7fff)
+#define MPI3_IOCSTATUS_STATUS_SHIFT			(0)
 #define MPI3_IOCSTATUS_SUCCESS                      (0x0000)
 #define MPI3_IOCSTATUS_INVALID_FUNCTION             (0x0001)
 #define MPI3_IOCSTATUS_BUSY                         (0x0002)
@@ -469,4 +486,5 @@ struct mpi3_default_reply {
 #define MPI3_IOCLOGINFO_TYPE_NONE               (0x0)
 #define MPI3_IOCLOGINFO_TYPE_SAS                (0x3)
 #define MPI3_IOCLOGINFO_LOG_DATA_MASK           (0x0fffffff)
+#define MPI3_IOCLOGINFO_LOG_DATA_SHIFT          (0)
 #endif
-- 
2.31.1


