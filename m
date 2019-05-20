Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C872314A
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfETK0e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41285 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETK0e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so6997942pfq.8
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHqS3sDZjF74RYNMS2p9YuOhaeNpteYO6EvVRxR2+bc=;
        b=Z6Qaj1STppmHWDecun40Temn4PGGp/SVPNqYxq9V3V9g7uv2pg8S4VZUqedmmmWgk+
         Q1H1psHoLFqNx3QG3n/Gy5uPq6GtSkGa7Fxkpk7MF3YlBMTI8EdBJ7hjpXZasuk2mt8p
         intOIPddq9Uj1ueo92CSsYwndKyl/3TX5+oAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHqS3sDZjF74RYNMS2p9YuOhaeNpteYO6EvVRxR2+bc=;
        b=gg/yCndMZJeJk6oXdnbJOS93k5QmcHodiYhjFwgprYp3s62erTR2X37EXnj68Xmfek
         yDD48tnn25pV0c0mUY7QHTEJmpna7I/4cOVoGmSGmtsJUbYt5v/VhoF7usc5g+JEkemb
         vWO7cvilfefhGEvaVDbD7XomtDep4UibD9NcQ15rQYYSy/3F2eJbrz6ptzfve86yn6Rv
         EfM9RMVwhHpdLaMKZjGm9pGM7RpUk5TEBXy0KSDJZf+K94wsbU0q38iNuvcnAT9XiWDm
         nSPwUDQRMi2BYUZAs4fri93n2N4uOsVOpmf7qAn3Z887ReCWLdxmOvzgONGvRkWLV0nt
         2W+w==
X-Gm-Message-State: APjAAAWhSao+OwCzr7qTNx+d/rcYp20oYrw1cV1uN7YEFRhYFDb3jVMZ
        3o20PturR3aBQtY06eo0oMpTRjLp94qEn/IZR21CHLFEaSrAxks/hTx8Sv3XTCvbmzVhbBQxF3S
        Jb+itiZTBgZvdll1D1VbwgdIOOOejUAKXkQSMwtn9mSkqggMgrr+QUsz3iQdyDrUfqMZ1Va7gMH
        nlRolaKdmQI2X4f50TZw==
X-Google-Smtp-Source: APXvYqwu9C9DGzl3u0cHYgXYu+RDDyl9GHGv15oNZwUeN5MKoGEJeEHa6Q8P4/4d1/pQ/VcGC1Bc7g==
X-Received: by 2002:a63:9242:: with SMTP id s2mr57702108pgn.220.1558347993048;
        Mon, 20 May 2019 03:26:33 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:32 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 05/10] mpt3sas: Use highiops queues if more in-flights
Date:   Mon, 20 May 2019 06:25:59 -0400
Message-Id: <20190520102604.3466-6-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Driver will use round robin method for io submission in batches
within the high iops queues when in-flight ios on the target device
is more than 8.

If in-flight ios per SCSI device more than 8, driver will use
high iops queue else driver will use low latency reply queues.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_base.h | 14 +++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a0d5161..a06b010 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3323,6 +3323,35 @@ _base_get_msix_index(struct MPT3SAS_ADAPTER *ioc,
 }
 
 /**
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
+/**
  * mpt3sas_base_get_smid - obtain a free smid from internal queue
  * @ioc: per adapter object
  * @cb_idx: callback index
@@ -6708,6 +6737,7 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 		ioc->build_sg_scmd = &_base_build_sg_scmd;
 		ioc->build_sg = &_base_build_sg;
 		ioc->build_zero_len_sge = &_base_build_zero_len_sge;
+		ioc->get_msix_index_for_smlio = &_base_get_msix_index;
 		break;
 	case MPI25_VERSION:
 	case MPI26_VERSION:
@@ -6722,7 +6752,11 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
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
1.8.3.1

