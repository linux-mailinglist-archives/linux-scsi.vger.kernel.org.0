Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185C630DF1
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfEaMPZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42625 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so4622130eds.9
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GAOgeHANtoVUK7w7PdcN70Wh4fZXrCM8z1cVIwQv8w=;
        b=cREZKXTLnFU5UsNRI+K67KtFYaTI6KwQNtvP2TRqHuZjYpcavvZUVCnB7k6BEilkqH
         yRwRZEkGZ3D6JkHFJPhwsXk9PmE2jKzFmO29hxYgxTqbzfZsHP8P8NAojwV370++F9u3
         7QKb56ynt6BaqimypZZKnwXjY+0p19mSrqo+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GAOgeHANtoVUK7w7PdcN70Wh4fZXrCM8z1cVIwQv8w=;
        b=t2gBvwtbfxxbpNBFRwxFx9cuKTbMfESwGS7EEvUD1z0iEz5C96TXoCKPISU7Ffvb4I
         yPal++Nih2q47DBSPJt1ZsTQ5nYAwabkf2dpC1eZptmjvDfjwEu/u4L76g8nzPtu7E6a
         JSWvU3S9DZtOlCP8vtlwQWFp5xdWWlSzWN8K6ma8DUrGzz5k9NIrUBhXosfy/Z0sT68p
         mZ+/ExyUistVK+3fPdrxcw5btMGSr7UhdYk6HJzJqaAOHOGIoQaVrFBimKP4nO2bpaxy
         e5Kf8QWI75t8cfV2Hb9tO/r1ryCatgLo9OeRJNkaOfa9cFxv2g8EH4UGfyUMg/h+moaz
         QOjQ==
X-Gm-Message-State: APjAAAW4GNVdufc4LNND+yiBWwVCyTcqXXXg4wD14wDQPNWN5tfKCcxA
        miydNAZk1fkQCHjRcYz2bh+yCH8gUJcYoGR3Qg+tTkjQpnSJ+TmNgyA7ANRxwipDh7bTgn9WT+5
        wj7m3CI6LwwH2MkeXeOQPCgZniaWIA8I7QLLXjNR2q4bqX52etBrKYPyUoiFFs2gGM2Oa3Pi8mr
        5P1uN62VZIorChHPlvZA==
X-Google-Smtp-Source: APXvYqx2EUx/UfwU8ezzQd1q4DB8QI+MG4oEmy3ag+6M5Fxc+4zDvnzX9mgl76Wr3nlhNKf+UVzlbQ==
X-Received: by 2002:a50:c88d:: with SMTP id d13mr10659143edh.214.1559304922993;
        Fri, 31 May 2019 05:15:22 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:22 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 05/10] mpt3sas: Use highiops queues if more in-flights
Date:   Fri, 31 May 2019 08:14:38 -0400
Message-Id: <20190531121443.30694-6-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Driver will use round robin method for io submission in batches
within the high iops queues when in-flight ios on the target device
is more than 8.

If in-flight ios per SCSI device more than 8, driver will use
high iops queue else driver will use low latency reply queues.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 36 ++++++++++++++++++++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_base.h | 14 ++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 57d0e7d..74cb060 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3322,6 +3322,35 @@ _base_get_msix_index(struct MPT3SAS_ADAPTER *ioc,
 	return ioc->cpu_msix_table[raw_smp_processor_id()];
 }
 
+/**
+ * _base_get_high_iops_msix_index - get the msix index of
+ *				high iops queues
+ * @ioc: per adapter object
+ * @scmd: scsi_cmnd object
+ *
+ * Returns: msix index of high iops reply queues.
+ * i.e. high iops reply queue on which IO request's
+ * reply should be posted by the HBA firmware.
+ */
+static inline u8
+_base_get_high_iops_msix_index(struct MPT3SAS_ADAPTER *ioc,
+	struct scsi_cmnd *scmd)
+{
+	/**
+	 * Round robin the IO interrupts among the high iops
+	 * reply queues in terms of batch count 16 when outstanding
+	 * IOs on the target device is >=8.
+	 */
+	if (atomic_read(&scmd->device->device_busy) >
+	    MPT3SAS_DEVICE_HIGH_IOPS_DEPTH)
+		return base_mod64((
+		    atomic64_add_return(1, &ioc->high_iops_outstanding) /
+		    MPT3SAS_HIGH_IOPS_BATCH_COUNT),
+		    MPT3SAS_HIGH_IOPS_REPLY_QUEUES);
+
+	return _base_get_msix_index(ioc, scmd);
+}
+
 /**
  * mpt3sas_base_get_smid - obtain a free smid from internal queue
  * @ioc: per adapter object
@@ -6707,6 +6736,7 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 		ioc->build_sg_scmd = &_base_build_sg_scmd;
 		ioc->build_sg = &_base_build_sg;
 		ioc->build_zero_len_sge = &_base_build_zero_len_sge;
+		ioc->get_msix_index_for_smlio = &_base_get_msix_index;
 		break;
 	case MPI25_VERSION:
 	case MPI26_VERSION:
@@ -6721,7 +6751,11 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 		ioc->build_nvme_prp = &_base_build_nvme_prp;
 		ioc->build_zero_len_sge = &_base_build_zero_len_sge_ieee;
 		ioc->sge_size_ieee = sizeof(Mpi2IeeeSgeSimple64_t);
-
+		if (ioc->high_iops_queues)
+			ioc->get_msix_index_for_smlio =
+					&_base_get_high_iops_msix_index;
+		else
+			ioc->get_msix_index_for_smlio = &_base_get_msix_index;
 		break;
 	}
 	if (ioc->atomic_desc_capable) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index bbbeb88..85db1f2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -356,7 +356,9 @@ struct mpt3sas_nvme_cmd {
 #define VIRTUAL_IO_FAILED_RETRY			(0x32010081)
 
 /* High IOPs definitions */
+#define MPT3SAS_DEVICE_HIGH_IOPS_DEPTH		8
 #define MPT3SAS_HIGH_IOPS_REPLY_QUEUES		8
+#define MPT3SAS_HIGH_IOPS_BATCH_COUNT		16
 #define MPT3SAS_GEN35_MAX_MSIX_QUEUES		128
 
 /* OEM Specific Flags will come from OEM specific header files */
@@ -928,6 +930,12 @@ typedef void (*PUT_SMID_IO_FP_HIP) (struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u16 funcdep);
 typedef void (*PUT_SMID_DEFAULT) (struct MPT3SAS_ADAPTER *ioc, u16 smid);
 typedef u32 (*BASE_READ_REG) (const volatile void __iomem *addr);
+/*
+ * To get high iops reply queue's msix index when high iops mode is enabled
+ * else get the msix index of general reply queues.
+ */
+typedef u8 (*GET_MSIX_INDEX) (struct MPT3SAS_ADAPTER *ioc,
+	struct scsi_cmnd *scmd);
 
 /* IOC Facts and Port Facts converted from little endian to cpu */
 union mpi3_version_union {
@@ -1029,6 +1037,8 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  * @cpu_msix_table: table for mapping cpus to msix index
  * @cpu_msix_table_sz: table size
  * @total_io_cnt: Gives total IO count, used to load balance the interrupts
+ * @high_iops_outstanding: used to load balance the interrupts
+ *				within high iops reply queues
  * @msix_load_balance: Enables load balancing of interrupts across
  * the multiple MSIXs
  * @schedule_dead_ioc_flush_running_cmds: callback to flush pending commands
@@ -1152,6 +1162,7 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  *	crash. To avoid the above race condition we use mutex syncrhonization
  *	which ensures the syncrhonization between cli/sysfs_show path.
  * @atomic_desc_capable: Atomic Request Descriptor support.
+ * @GET_MSIX_INDEX: Get the msix index of high iops queues.
  */
 struct MPT3SAS_ADAPTER {
 	struct list_head list;
@@ -1211,6 +1222,7 @@ struct MPT3SAS_ADAPTER {
 	MPT3SAS_FLUSH_RUNNING_CMDS schedule_dead_ioc_flush_running_cmds;
 	u32             non_operational_loop;
 	atomic64_t      total_io_cnt;
+	atomic64_t	high_iops_outstanding;
 	bool            msix_load_balance;
 	u16		thresh_hold;
 	u8		high_iops_queues;
@@ -1432,7 +1444,7 @@ struct MPT3SAS_ADAPTER {
 	PUT_SMID_IO_FP_HIP put_smid_fast_path;
 	PUT_SMID_IO_FP_HIP put_smid_hi_priority;
 	PUT_SMID_DEFAULT put_smid_default;
-
+	GET_MSIX_INDEX get_msix_index_for_smlio;
 };
 
 typedef u8 (*MPT_CALLBACK)(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
-- 
2.18.1

