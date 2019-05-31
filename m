Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8563830DEE
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfEaMPN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33036 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so14287862edb.0
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pnHCjmIyku9L5dlnd3uLGQ8BT6J8nU+YpPAtu209nTQ=;
        b=HVeWAh7cPbssCKMxffYGCGjKxS8q2eNc6bQH1iF7xrpfHtYnAOKHRYsATumkcIDtwD
         AdCfKjQzGdWrdH8qJx0WSe7OoIDT2Pg52GcBFXDpSmmR3+jfsqbA2cGqBFv4HoHrI6Fz
         qibfKF+DUF7cprNGWGb/6s2/92s2I3POPweHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pnHCjmIyku9L5dlnd3uLGQ8BT6J8nU+YpPAtu209nTQ=;
        b=GiZ/plKkNzLinV00ZWJqXr1x/GlCtWcqwOGujUlYhAbga3DzxuiOSl6VJoM53roLre
         QKkBtUVFW5uH0VCctXd7vYL/F/f5Kma47DQIMRYUV9AzIApwU5W/HYwaPdvSinPNJ3Ni
         KNnzhgGFG8lDxUvV3XW9IijMVYT5l3NXF+wyzEQBTQHdjpk3KorCWCsluvW+Jfa0l14Q
         0EgYrR6Hlu/gr9+kVSaSCk0zCbwPgfLn0cI5twU3REoZAuZReNq5OiGn5Bb/kYHcTsOi
         Oqhj+7lW01AvR7F1XvTUUccetYe4cesxZfxHnNqqTTa9q/Vg9fbOrZJdnA5PXVzhyouQ
         XzOg==
X-Gm-Message-State: APjAAAUgqkY7FBnIUE4Qpmp7mFXOGasizWYjTqhp2U0b76pu+lEJZRZX
        E7mD2cK8gznanKfSx8EsC8lE61kQTCUST0zzTIutFRoQjFFWXUjCI+YhsJj3mJR1yt/nkv0YlUP
        MCMF26zt8drbPVqJWsShSEq8oKk0da71sH6KKg5zmoy72/tlX048HAxBQ4X1ZhDhFegrmzitQzv
        LfPIB6PKdqSsu9kqeGoA==
X-Google-Smtp-Source: APXvYqyqSXF6wcyU8VRyNUi36SDgVasnlqUGxQaIy36rLeYTtFMPCLmo0uWbGnffyDtqMeuAtw4c3A==
X-Received: by 2002:aa7:c545:: with SMTP id s5mr10967728edr.217.1559304910462;
        Fri, 31 May 2019 05:15:10 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:09 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 02/10] mpt3sas: Add Atomic RequestDescriptor support on Aero
Date:   Fri, 31 May 2019 08:14:35 -0400
Message-Id: <20190531121443.30694-3-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
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
 drivers/scsi/mpt3sas/mpt3sas_base.c | 118 +++++++++++++++++++++++++---
 drivers/scsi/mpt3sas/mpt3sas_base.h |   2 +
 2 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index ab0392a..9cdbd61 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3653,6 +3653,95 @@ _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 				&ioc->scsi_lookup_lock);
 }
 
+/**
+ * _base_put_smid_scsi_io_atomic - send SCSI_IO request to firmware using
+ *   Atomic Request Descriptor
+ * @ioc: per adapter object
+ * @smid: system request message index
+ * @handle: device handle, unused in this function, for function type match
+ *
+ * Return nothing.
+ */
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
 /**
  * _base_display_OEMs_branding - Display branding string
  * @ioc: per adapter object
@@ -5694,6 +5783,9 @@ _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc)
 	if ((facts->IOCCapabilities &
 	      MPI2_IOCFACTS_CAPABILITY_RDPQ_ARRAY_CAPABLE) && (!reset_devices))
 		ioc->rdpq_array_capable = 1;
+	if ((facts->IOCCapabilities & MPI26_IOCFACTS_CAPABILITY_ATOMIC_REQ)
+	    && ioc->is_aero_ioc)
+		ioc->atomic_desc_capable = 1;
 	facts->FWVersion.Word = le32_to_cpu(mpi_reply.FWVersion.Word);
 	facts->IOCRequestFrameSize =
 	    le16_to_cpu(mpi_reply.IOCRequestFrameSize);
@@ -6587,15 +6679,23 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 
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
2.18.1

