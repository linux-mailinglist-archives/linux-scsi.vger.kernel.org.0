Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F208821A28
	for <lists+linux-scsi@lfdr.de>; Fri, 17 May 2019 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfEQO7Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 May 2019 10:59:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33321 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfEQO7Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 May 2019 10:59:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so3443314pgv.0
        for <linux-scsi@vger.kernel.org>; Fri, 17 May 2019 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enZfe8wiMlG1ctFVlf7wPJUMZ5TucXTJrjZ1mdARE7k=;
        b=Wd11mONtJahwoFLDw2EGMnUzR7rmJ+4QgWyi/sw1H5+qrdnuN/h8NSragIbXUiFB17
         iCtxbPLnG//XW8M5jhXbWQ5SGQ2y+aybwF8vcP/H3TPlX4Ix6YV0XRTJ4TdltEozYMee
         OD04a2HxBfEfwaRjlagrFWyYhmdNU0PJsMeOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enZfe8wiMlG1ctFVlf7wPJUMZ5TucXTJrjZ1mdARE7k=;
        b=Bq9OCRsBBsnrvnlIfWjQQEhDcq10t8t02mkxpfJP+CxgQkUY3EuiTUWtTT2ObQxDKZ
         JAXRV0R8NCMyB+jIj7wMOW0MMVg7MPRm3+SurKCsp2LSkthT1RJUOw8wuVXWnXe8lycv
         MvxLwkN+pw2CwSTTDeBUcuGieDeW1+eH4zIr1+p2f8zkZD8qOHR+/6fGkRIlTA8r/b8X
         BTLcYFGNsLsHmNPisLU/cQl1cl1VUWWQOHU2U9SR4FqticlUDZQJG3Xbr0JxO70GogLq
         nlqcjQHSHK5UZWp4PJj60uxHneaLCtXxV76o9lJYZO7KpdwBUpKau5o0dgAgmdrfVYv1
         GeoA==
X-Gm-Message-State: APjAAAUrzZ2kMyLDxoa7LL6DAA89blkUvRLisRp2RWeKytc/V/D0m1lQ
        UgpAX0rWTtSrG4RVyaBYo+uAwWOBvlfoMBrEokmt7qtUVT5vZhoDrckmvyR1fVGpfLC4E+H7tVm
        QqgRbVUyjmVyxfWxzcML2QvS0xiGUiFV3FdK/O1pPIoVrVG4NnZEP9vNKH9N6FZJ6zohO5uDGFp
        kJvj3fH3TLIDLfRveOsQ==
X-Google-Smtp-Source: APXvYqwNoc3lxbNFY2gC76PAevOrfqO5yK55r0YotALBO0Mr4R5ADbS6AahBiDGQQbS24u3MXeAslQ==
X-Received: by 2002:a65:644e:: with SMTP id s14mr58144181pgv.290.1558105163952;
        Fri, 17 May 2019 07:59:23 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c189sm20739195pfg.46.2019.05.17.07.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 07:59:23 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 02/10] mpt3sas: Add Atomic Request Descriptor support on Aero
Date:   Fri, 17 May 2019 10:58:57 -0400
Message-Id: <20190517145905.4765-3-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
References: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If the Aero HBA supports Atomic Request Descriptors, it sets the Atomic
Request Descriptor Capable bit in the IOCCapabilities field of the
IOCFacts Reply message. Driver uses an Atomic Request Descriptor
as an alternative method for posting an entry onto a request queue.
The posting of an Atomic Request Descriptor is an atomic operation,
providing a safe mechanism for multiple processors on the host to
post requests without synchronization. This Atomic Request Descriptor
format is identical to first 32 bits of Default Request Descriptor
and uses only 32 bits

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 118 +++++++++++++++++++++++++++++++++---
 drivers/scsi/mpt3sas/mpt3sas_base.h |   2 +
 2 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a8fa565..2b6b487 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3655,6 +3655,95 @@ _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 }
 
 /**
+* _base_put_smid_scsi_io_atomic - send SCSI_IO request to firmware using
+*   Atomic Request Descriptor
+* @ioc: per adapter object
+* @smid: system request message index
+* @handle: device handle, unused in this function, for function type match
+*
+* Return nothing.
+*/
+static void
+_base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+	u16 handle)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
+	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
+ * _base_put_smid_fast_path_atomic - send fast path request to firmware
+ * using Atomic Request Descriptor
+ * @ioc: per adapter object
+ * @smid: system request message index
+ * @handle: device handle, unused in this function, for function type match
+ * Return nothing
+ */
+static void
+_base_put_smid_fast_path_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+	u16 handle)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
+	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
+ * _base_put_smid_hi_priority_atomic - send Task Management request to
+ * firmware using Atomic Request Descriptor
+ * @ioc: per adapter object
+ * @smid: system request message index
+ * @msix_task: msix_task will be same as msix of IO incase of task abort else 0
+ *
+ * Return nothing.
+ */
+static void
+_base_put_smid_hi_priority_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+	u16 msix_task)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_HIGH_PRIORITY;
+	descriptor.MSIxIndex = msix_task;
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
+ * _base_put_smid_default - Default, primarily used for config pages
+ * use Atomic Request Descriptor
+ * @ioc: per adapter object
+ * @smid: system request message index
+ *
+ * Return nothing.
+ */
+static void
+_base_put_smid_default_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid)
+{
+	Mpi26AtomicRequestDescriptor_t descriptor;
+	u32 *request = (u32 *)&descriptor;
+
+	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
+	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SMID = cpu_to_le16(smid);
+
+	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
+}
+
+/**
  * _base_display_OEMs_branding - Display branding string
  * @ioc: per adapter object
  */
@@ -5695,6 +5784,9 @@ _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc)
 	if ((facts->IOCCapabilities &
 	      MPI2_IOCFACTS_CAPABILITY_RDPQ_ARRAY_CAPABLE) && (!reset_devices))
 		ioc->rdpq_array_capable = 1;
+	if ((facts->IOCCapabilities & MPI26_IOCFACTS_CAPABILITY_ATOMIC_REQ)
+	    && ioc->is_aero_ioc)
+		ioc->atomic_desc_capable = 1;
 	facts->FWVersion.Word = le32_to_cpu(mpi_reply.FWVersion.Word);
 	facts->IOCRequestFrameSize =
 	    le16_to_cpu(mpi_reply.IOCRequestFrameSize);
@@ -6588,15 +6680,23 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 
 		break;
 	}
-
-	ioc->put_smid_default = &_base_put_smid_default;
-	ioc->put_smid_fast_path = &_base_put_smid_fast_path;
-	ioc->put_smid_hi_priority = &_base_put_smid_hi_priority;
-	if (ioc->is_mcpu_endpoint)
-		ioc->put_smid_scsi_io = &_base_put_smid_mpi_ep_scsi_io;
-	else
-		ioc->put_smid_scsi_io = &_base_put_smid_scsi_io;
-
+	if (ioc->atomic_desc_capable) {
+		ioc->put_smid_default = &_base_put_smid_default_atomic;
+		ioc->put_smid_scsi_io = &_base_put_smid_scsi_io_atomic;
+		ioc->put_smid_fast_path =
+				&_base_put_smid_fast_path_atomic;
+		ioc->put_smid_hi_priority =
+				&_base_put_smid_hi_priority_atomic;
+	} else {
+		ioc->put_smid_default = &_base_put_smid_default;
+		ioc->put_smid_fast_path = &_base_put_smid_fast_path;
+		ioc->put_smid_hi_priority = &_base_put_smid_hi_priority;
+		if (ioc->is_mcpu_endpoint)
+			ioc->put_smid_scsi_io =
+				&_base_put_smid_mpi_ep_scsi_io;
+		else
+			ioc->put_smid_scsi_io = &_base_put_smid_scsi_io;
+	}
 	/*
 	 * These function pointers for other requests that don't
 	 * the require IEEE scatter gather elements.
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index d3f3c37..3309864 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1147,6 +1147,7 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  *	path functions resulting in Null pointer reference followed by kernel
  *	crash. To avoid the above race condition we use mutex syncrhonization
  *	which ensures the syncrhonization between cli/sysfs_show path.
+ * @atomic_desc_capable: Atomic Request Descriptor support.
  */
 struct MPT3SAS_ADAPTER {
 	struct list_head list;
@@ -1412,6 +1413,7 @@ struct MPT3SAS_ADAPTER {
 	u8		hide_drives;
 	spinlock_t	diag_trigger_lock;
 	u8		diag_trigger_active;
+	u8		atomic_desc_capable;
 	BASE_READ_REG	base_readl;
 	struct SL_WH_MASTER_TRIGGER_T diag_trigger_master;
 	struct SL_WH_EVENT_TRIGGERS_T diag_trigger_event;
-- 
1.8.3.1

