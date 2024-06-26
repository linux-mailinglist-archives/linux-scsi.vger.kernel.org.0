Return-Path: <linux-scsi+bounces-6237-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A0917E36
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2024 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78C11C23F39
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2024 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577317DE24;
	Wed, 26 Jun 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fVP1ld/9"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793117CA06
	for <linux-scsi@vger.kernel.org>; Wed, 26 Jun 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397805; cv=none; b=WtgGBawZ/VIISNAEAc1NNE7tUIdhnBFjDqQH6J8Oe1HQtIVS1+O9DVY37gxNQ5N1JvUMkfelrWQF7YTcGLMzs3HwI0tSWbnKV6iY4a6JsJ5FGh36fhjrCNSABKwT4RWonQRXJq7aa/GtUDdUnuG41e27iIxZLteU8a1JHk/f7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397805; c=relaxed/simple;
	bh=OT0f3ljhDEY0XOJ8CUS36eeEKTuZ+7KkIkcofez8faY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo+uDOmftNK8zKjhOb381y8g7IFtYLfLougtvUhBWkBvhVAoQeXRcKcx9h9FFPDiDUPN25Q1alVTUhrJZlqKBgS+aTMqvdUZ3jpx0KOJDQj0RYzphS/7ccx6Fq0R/UWMI7dojs+onjkziiBFPpM/EKm+yvKVYzP76G9ADFf/9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fVP1ld/9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7024d571d8eso5088926b3a.0
        for <linux-scsi@vger.kernel.org>; Wed, 26 Jun 2024 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719397801; x=1720002601; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pi7VE/FLaPAAe/LQIrwCkUOSL3qEk4q6TJeQpN/SymA=;
        b=fVP1ld/9iSuPCegoAn2vM3kkmFNsBTlUZCPsi/z2cI6kgZYkheNzur9G0vdqfajfWQ
         a85czdy0hMFbvd+x39hLs4dCmfy3R8yQldLTBCRSv9r/gMkmMXrPzVfrWsGlMvNzAOWh
         DU6s/aanKQ1PHyAFVsbUhy2LEXAiJR0QuB7mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719397801; x=1720002601;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi7VE/FLaPAAe/LQIrwCkUOSL3qEk4q6TJeQpN/SymA=;
        b=FtPTKLqLpq0y3iXmF39oWvci8gAdU6n3vEYDJ/EhCgrSdKA7xd8SxfZKuohYxvhwzt
         Iu1eQdbpDB18InrXnoSDvgKwMfYNIaZRdQ3zDPhPOqY+nR8Ws1O8f6AW9PPpODw+p6Ej
         Uqky70lRyHOvZAxaUVL8BT8rFmZPLnICTgILMgrmDktb69XM1BlGfGzJ78e2sdm60yc9
         eDDNTEo+syK7MbZqlIDVuXpCQTYUipmhEBf/LBc+ylfCdLcm4BiqCkS4X9rSJxb1EMex
         XWvHy/zQ/WZCB698Kr5oUsHLeiUYREZSz6O2/9Hq6n3o+LlhjVWCTfnXRZ7ND1BVLJ9+
         Gfig==
X-Gm-Message-State: AOJu0Yy5tN3W68VYVfDdXo3S8HCW9CVvb51u1s6Vm4gdYuU9Hhv0TNfF
	taSOCw56rMQuYBKffkJOehQGbc/HXGIwxHLkaPXYE/2uMwZ9dFTxGFN1mdU+/K24P0O6yDM3Nci
	IS5GcZOkcYhAqpZ2hfTJRrma91Chh510NVDGkSUCmi7uSupNq0UDyGUySWzYOHYvpf6kPFsRmBB
	axrccwlzXV82LYWPf3Zjj7op7Or97lpH1gR0WaVl3LGAVOKQ==
X-Google-Smtp-Source: AGHT+IHk1sBQqBFsmeWpZEfPSA9ouI1iVJevzT4o5AHx6IRkQ1VohDda+bAzwsadjXMpFdkqVzicvA==
X-Received: by 2002:a05:6a20:3112:b0:1bd:feed:c031 with SMTP id adf61e73a8af0-1bdfeedc083mr1277339637.28.1719397801137;
        Wed, 26 Jun 2024 03:30:01 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7ccasm96051055ad.299.2024.06.26.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:29:59 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: rajsekhar.chundru@broadcom.com,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	prayas.patel@broadcom.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/4] mpi3mr: HDB allocation and posting for hardware and Firmware buffers
Date: Wed, 26 Jun 2024 15:56:43 +0530
Message-Id: <20240626102646.14298-2-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240626102646.14298-1-ranjan.kumar@broadcom.com>
References: <20240626102646.14298-1-ranjan.kumar@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000360db6061bc87f83"

--000000000000360db6061bc87f83
Content-Transfer-Encoding: 8bit

To be able to debug controller problems it is beneficial to
allocate and configure system/host memory buffers which can be used
to capture hardware and firmware diagnostic information.

Add functions required to allocate and post firmware and
hardware diagnostic buffers to the controller and to set up
automatic diagnostic capture triggers.

Captures will be triggered under the following circumstances:
1. Firmware is in FAULT state.
2. Admin commands timeout.
3. Controller reset caused due to IO timeout

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405151758.7xrJz6rp-lkp@intel.com/
Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi/mpi30_tool.h |  44 +++
 drivers/scsi/mpi3mr/mpi3mr.h         |  74 +++++
 drivers/scsi/mpi3mr/mpi3mr_app.c     | 480 +++++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_fw.c      | 193 ++++++++++-
 4 files changed, 790 insertions(+), 1 deletion(-)
 create mode 100644 drivers/scsi/mpi3mr/mpi/mpi30_tool.h

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_tool.h b/drivers/scsi/mpi3mr/mpi/mpi30_tool.h
new file mode 100644
index 000000000000..3b960893870f
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_tool.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright 2016-2024 Broadcom Inc. All rights reserved.
+ */
+#ifndef MPI30_TOOL_H
+#define MPI30_TOOL_H     1
+
+#define MPI3_DIAG_BUFFER_TYPE_TRACE	(0x01)
+#define MPI3_DIAG_BUFFER_TYPE_FW	(0x02)
+#define MPI3_DIAG_BUFFER_ACTION_RELEASE	(0x01)
+
+struct mpi3_diag_buffer_post_request {
+	__le16                     host_tag;
+	u8                         ioc_use_only02;
+	u8                         function;
+	__le16                     ioc_use_only04;
+	u8                         ioc_use_only06;
+	u8                         msg_flags;
+	__le16                     change_count;
+	__le16                     reserved0a;
+	u8                         type;
+	u8                         reserved0d;
+	__le16                     reserved0e;
+	__le64                     address;
+	__le32                     length;
+	__le32                     reserved1c;
+};
+
+struct mpi3_diag_buffer_manage_request {
+	__le16                     host_tag;
+	u8                         ioc_use_only02;
+	u8                         function;
+	__le16                     ioc_use_only04;
+	u8                         ioc_use_only06;
+	u8                         msg_flags;
+	__le16                     change_count;
+	__le16                     reserved0a;
+	u8                         type;
+	u8                         action;
+	__le16                     reserved0e;
+};
+
+
+#endif
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index f5a1529fa537..9aae59646faa 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -47,6 +47,7 @@
 #include "mpi/mpi30_ioc.h"
 #include "mpi/mpi30_sas.h"
 #include "mpi/mpi30_pci.h"
+#include "mpi/mpi30_tool.h"
 #include "mpi3mr_debug.h"
 
 /* Global list and lock for storing multiple adapters managed by the driver */
@@ -187,6 +188,13 @@ extern atomic64_t event_counter;
 #define MPI3MR_HARD_SECURE_DEVICE		0x08
 #define MPI3MR_TAMPERED_DEVICE			0x0C
 
+#define MPI3MR_DEFAULT_HDB_MAX_SZ       (4 * 1024 * 1024)
+#define MPI3MR_DEFAULT_HDB_DEC_SZ       (1 * 1024 * 1024)
+#define MPI3MR_DEFAULT_HDB_MIN_SZ       (2 * 1024 * 1024)
+#define MPI3MR_MAX_NUM_HDB      2
+
+#define MPI3MR_HDB_TRIGGER_TYPE_GLOBAL          3
+
 /* SGE Flag definition */
 #define MPI3MR_SGEFLAGS_SYSTEM_SIMPLE_END_OF_LIST \
 	(MPI3_SGE_FLAGS_ELEMENT_TYPE_SIMPLE | MPI3_SGE_FLAGS_DLAS_SYSTEM | \
@@ -210,6 +218,7 @@ extern atomic64_t event_counter;
 #define MPI3MR_WRITE_SAME_MAX_LEN_256_BLKS 256
 #define MPI3MR_WRITE_SAME_MAX_LEN_2048_BLKS 2048
 
+
 /**
  * struct mpi3mr_nvme_pt_sge -  Structure to store SGEs for NVMe
  * Encapsulated commands.
@@ -289,6 +298,8 @@ enum mpi3mr_reset_reason {
 	MPI3MR_RESET_FROM_PELABORT_TIMEOUT = 22,
 	MPI3MR_RESET_FROM_SYSFS = 23,
 	MPI3MR_RESET_FROM_SYSFS_TIMEOUT = 24,
+	MPI3MR_RESET_FROM_DIAG_BUFFER_POST_TIMEOUT = 25,
+	MPI3MR_RESET_FROM_DIAG_BUFFER_RELEASE_TIMEOUT = 26,
 	MPI3MR_RESET_FROM_FIRMWARE = 27,
 	MPI3MR_RESET_FROM_CFG_REQ_TIMEOUT = 29,
 	MPI3MR_RESET_FROM_SAS_TRANSPORT_TIMEOUT = 30,
@@ -327,6 +338,9 @@ struct mpi3mr_ioc_facts {
 	u32 ioc_capabilities;
 	struct mpi3mr_compimg_ver fw_ver;
 	u32 mpi_version;
+	u32 diag_trace_sz;
+	u32 diag_fw_sz;
+	u32 diag_drvr_sz;
 	u16 max_reqs;
 	u16 product_id;
 	u16 op_req_sz;
@@ -852,6 +866,41 @@ struct mpi3mr_drv_cmd {
 	    struct mpi3mr_drv_cmd *drv_cmd);
 };
 
+/**
+ * union mpi3mr_trigger_data - Trigger data information
+ * @fault: Fault code
+ * @global: Global trigger data
+ * @element: element trigger data
+ */
+union mpi3mr_trigger_data {
+	u16 fault;
+	u64 global;
+	union mpi3_driver2_trigger_element element;
+};
+
+/**
+ * struct diag_buffer_desc - memory descriptor structure to
+ * store virtual, dma addresses, size, buffer status for host
+ * diagnostic buffers.
+ *
+ * @type: Buffer type
+ * @trigger_data: Trigger data
+ * @trigger_type: Trigger type
+ * @status: Buffer status
+ * @size: Buffer size
+ * @addr: Virtual address
+ * @dma_addr: Buffer DMA address
+ */
+struct diag_buffer_desc {
+	u8 type;
+	union mpi3mr_trigger_data trigger_data;
+	u8 trigger_type;
+	u8 status;
+	u32 size;
+	void *addr;
+	dma_addr_t dma_addr;
+};
+
 /**
  * struct dma_memory_desc - memory descriptor structure to store
  * virtual address, dma address and size for any generic dma
@@ -1054,6 +1103,11 @@ struct scmd_priv {
  * @sas_node_lock: Lock to protect SAS node list
  * @hba_port_table_list: List of HBA Ports
  * @enclosure_list: List of Enclosure objects
+ * @diag_buffers: Host diagnostic buffers
+ * @driver_pg2:  Driver page 2 pointer
+ * @reply_trigger_present: Reply trigger present flag
+ * @event_trigger_present: Event trigger present flag
+ * @scsisense_trigger_present: Scsi sense trigger present flag
  * @ioctl_dma_pool: DMA pool for IOCTL data buffers
  * @ioctl_sge: DMA buffer descriptors for IOCTL data
  * @ioctl_chain_sge: DMA buffer descriptor for IOCTL chain
@@ -1250,6 +1304,12 @@ struct mpi3mr_ioc {
 	struct dma_memory_desc ioctl_chain_sge;
 	struct dma_memory_desc ioctl_resp_sge;
 	bool ioctl_sges_allocated;
+	bool reply_trigger_present;
+	bool event_trigger_present;
+	bool scsisense_trigger_present;
+	struct diag_buffer_desc diag_buffers[MPI3MR_MAX_NUM_HDB];
+	struct mpi3_driver_page2 *driver_pg2;
+	spinlock_t trigger_lock;
 };
 
 /**
@@ -1406,6 +1466,8 @@ int mpi3mr_cfg_set_sas_io_unit_pg1(struct mpi3mr_ioc *mrioc,
 	struct mpi3_sas_io_unit_page1 *sas_io_unit_pg1, u16 pg_sz);
 int mpi3mr_cfg_get_driver_pg1(struct mpi3mr_ioc *mrioc,
 	struct mpi3_driver_page1 *driver_pg1, u16 pg_sz);
+int mpi3mr_cfg_get_driver_pg2(struct mpi3mr_ioc *mrioc,
+	struct mpi3_driver_page2 *driver_pg2, u16 pg_sz, u8 page_type);
 
 u8 mpi3mr_is_expander_device(u16 device_info);
 int mpi3mr_expander_add(struct mpi3mr_ioc *mrioc, u16 handle);
@@ -1439,4 +1501,16 @@ void mpi3mr_free_enclosure_list(struct mpi3mr_ioc *mrioc);
 int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc);
 void mpi3mr_expander_node_remove(struct mpi3mr_ioc *mrioc,
 	struct mpi3mr_sas_node *sas_expander);
+void mpi3mr_alloc_diag_bufs(struct mpi3mr_ioc *mrioc);
+int mpi3mr_post_diag_bufs(struct mpi3mr_ioc *mrioc);
+int mpi3mr_issue_diag_buf_release(struct mpi3mr_ioc *mrioc,
+	struct diag_buffer_desc *diag_buffer);
+void mpi3mr_release_diag_bufs(struct mpi3mr_ioc *mrioc, u8 skip_rel_action);
+void mpi3mr_set_trigger_data_in_hdb(struct diag_buffer_desc *hdb,
+	u8 type, union mpi3mr_trigger_data *trigger_data, bool force);
+int mpi3mr_refresh_trigger(struct mpi3mr_ioc *mrioc, u8 page_type);
+struct diag_buffer_desc *mpi3mr_diag_buffer_for_type(struct mpi3mr_ioc *mrioc,
+	u8 buf_type);
+int mpi3mr_issue_diag_buf_post(struct mpi3mr_ioc *mrioc,
+	struct diag_buffer_desc *diag_buffer);
 #endif /*MPI3MR_H_INCLUDED*/
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 1638109a68a0..3da7c46f3b79 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -11,6 +11,486 @@
 #include <linux/bsg-lib.h>
 #include <uapi/scsi/scsi_bsg_mpi3mr.h>
 
+/**
+ * mpi3mr_alloc_trace_buffer:	Allocate trace buffer
+ * @mrioc: Adapter instance reference
+ * @trace_size: Trace buffer size
+ *
+ * Allocate trace buffer
+ * Return: 0 on success, non-zero on failure.
+ */
+static int mpi3mr_alloc_trace_buffer(struct mpi3mr_ioc *mrioc, u32 trace_size)
+{
+	struct diag_buffer_desc *diag_buffer = &mrioc->diag_buffers[0];
+
+	diag_buffer->addr = dma_alloc_coherent(&mrioc->pdev->dev,
+	    trace_size, &diag_buffer->dma_addr, GFP_KERNEL);
+	if (diag_buffer->addr) {
+		dprint_init(mrioc, "trace diag buffer is allocated successfully\n");
+		return 0;
+	}
+	return -1;
+}
+
+/**
+ * mpi3mr_alloc_diag_bufs - Allocate memory for diag buffers
+ * @mrioc: Adapter instance reference
+ *
+ * This functions checks whether the driver defined buffer sizes
+ * are greater than IOCFacts provided controller local buffer
+ * sizes and if the driver defined sizes are more then the
+ * driver allocates the specific buffer by reading driver page1
+ *
+ * Return: Nothing.
+ */
+void mpi3mr_alloc_diag_bufs(struct mpi3mr_ioc *mrioc)
+{
+	struct diag_buffer_desc *diag_buffer;
+	struct mpi3_driver_page1 driver_pg1;
+	u32 trace_dec_size, trace_min_size, fw_dec_size, fw_min_size,
+		trace_size, fw_size;
+	u16 pg_sz = sizeof(driver_pg1);
+	int retval = 0;
+	bool retry = false;
+
+	if (mrioc->diag_buffers[0].addr || mrioc->diag_buffers[1].addr)
+		return;
+
+	retval = mpi3mr_cfg_get_driver_pg1(mrioc, &driver_pg1, pg_sz);
+	if (retval) {
+		ioc_warn(mrioc,
+		    "%s: driver page 1 read failed, allocating trace\n"
+		    "and firmware diag buffers of default size\n", __func__);
+		trace_size = fw_size = MPI3MR_DEFAULT_HDB_MAX_SZ;
+		trace_dec_size = fw_dec_size = MPI3MR_DEFAULT_HDB_DEC_SZ;
+		trace_min_size = fw_min_size = MPI3MR_DEFAULT_HDB_MIN_SZ;
+
+	} else {
+		trace_size = driver_pg1.host_diag_trace_max_size * 1024;
+		trace_dec_size = driver_pg1.host_diag_trace_decrement_size
+			 * 1024;
+		trace_min_size = driver_pg1.host_diag_trace_min_size * 1024;
+		fw_size = driver_pg1.host_diag_fw_max_size * 1024;
+		fw_dec_size = driver_pg1.host_diag_fw_decrement_size * 1024;
+		fw_min_size = driver_pg1.host_diag_fw_min_size * 1024;
+		dprint_init(mrioc,
+		    "%s:trace diag buffer sizes read from driver\n"
+		    "page1: maximum size = %dKB, decrement size = %dKB\n"
+		    ", minimum size = %dKB\n", __func__, driver_pg1.host_diag_trace_max_size,
+		    driver_pg1.host_diag_trace_decrement_size,
+		    driver_pg1.host_diag_trace_min_size);
+		dprint_init(mrioc,
+		    "%s:firmware diag buffer sizes read from driver\n"
+		    "page1: maximum size = %dKB, decrement size = %dKB\n"
+		    ", minimum size = %dKB\n", __func__, driver_pg1.host_diag_fw_max_size,
+		    driver_pg1.host_diag_fw_decrement_size,
+		    driver_pg1.host_diag_fw_min_size);
+		if ((trace_size == 0) && (fw_size == 0))
+			return;
+	}
+
+
+retry_trace:
+	diag_buffer = &mrioc->diag_buffers[0];
+	diag_buffer->type = MPI3_DIAG_BUFFER_TYPE_TRACE;
+	diag_buffer->status = MPI3MR_HDB_BUFSTATUS_NOT_ALLOCATED;
+	if ((mrioc->facts.diag_trace_sz < trace_size) && (trace_size >=
+		trace_min_size)) {
+		if (!retry)
+			dprint_init(mrioc,
+			    "trying to allocate trace diag buffer of size = %dKB\n",
+			    trace_size / 1024);
+		if (mpi3mr_alloc_trace_buffer(mrioc, trace_size)) {
+			retry = true;
+			trace_size -= trace_dec_size;
+			dprint_init(mrioc, "trace diag buffer allocation failed\n"
+			"retrying smaller size %dKB\n", trace_size / 1024);
+			goto retry_trace;
+		} else
+			diag_buffer->size = trace_size;
+	}
+
+	retry = false;
+retry_fw:
+
+	diag_buffer = &mrioc->diag_buffers[1];
+
+	diag_buffer->type = MPI3_DIAG_BUFFER_TYPE_FW;
+	diag_buffer->status = MPI3MR_HDB_BUFSTATUS_NOT_ALLOCATED;
+	if ((mrioc->facts.diag_fw_sz < fw_size) && (fw_size >= fw_min_size)) {
+		diag_buffer->addr = dma_alloc_coherent(&mrioc->pdev->dev,
+		    fw_size, &diag_buffer->dma_addr, GFP_KERNEL);
+		if (!retry)
+			dprint_init(mrioc,
+			    "%s:trying to allocate firmware diag buffer of size = %dKB\n",
+			    __func__, fw_size / 1024);
+		if (diag_buffer->addr) {
+			dprint_init(mrioc, "%s:firmware diag buffer allocated successfully\n",
+			    __func__);
+			diag_buffer->size = fw_size;
+		} else {
+			retry = true;
+			fw_size -= fw_dec_size;
+			dprint_init(mrioc, "%s:trace diag buffer allocation failed,\n"
+					"retrying smaller size %dKB\n",
+					__func__, fw_size / 1024);
+			goto retry_fw;
+		}
+	}
+}
+
+/**
+ * mpi3mr_issue_diag_buf_post - Send diag buffer post req
+ * @mrioc: Adapter instance reference
+ * @diag_buffer: Diagnostic buffer descriptor
+ *
+ * Issue diagnostic buffer post MPI request through admin queue
+ * and wait for the completion of it or time out.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+int mpi3mr_issue_diag_buf_post(struct mpi3mr_ioc *mrioc,
+	struct diag_buffer_desc *diag_buffer)
+{
+	struct mpi3_diag_buffer_post_request diag_buf_post_req;
+	u8 prev_status;
+	int retval = 0;
+
+	memset(&diag_buf_post_req, 0, sizeof(diag_buf_post_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		dprint_bsg_err(mrioc, "%s: command is in use\n", __func__);
+		mutex_unlock(&mrioc->init_cmds.mutex);
+		return -1;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	diag_buf_post_req.host_tag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	diag_buf_post_req.function = MPI3_FUNCTION_DIAG_BUFFER_POST;
+	diag_buf_post_req.type = diag_buffer->type;
+	diag_buf_post_req.address = le64_to_cpu(diag_buffer->dma_addr);
+	diag_buf_post_req.length = le32_to_cpu(diag_buffer->size);
+
+	dprint_bsg_info(mrioc, "%s: posting diag buffer type %d\n", __func__,
+	    diag_buffer->type);
+	prev_status = diag_buffer->status;
+	diag_buffer->status = MPI3MR_HDB_BUFSTATUS_POSTED_UNPAUSED;
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &diag_buf_post_req,
+	    sizeof(diag_buf_post_req), 1);
+	if (retval) {
+		dprint_bsg_err(mrioc, "%s: admin request post failed\n",
+		    __func__);
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		mrioc->init_cmds.is_waiting = 0;
+		dprint_bsg_err(mrioc, "%s: command timedout\n", __func__);
+		mpi3mr_check_rh_fault_ioc(mrioc,
+		    MPI3MR_RESET_FROM_DIAG_BUFFER_POST_TIMEOUT);
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		dprint_bsg_err(mrioc,
+		    "%s: command failed, buffer_type (%d) ioc_status(0x%04x) log_info(0x%08x)\n",
+		    __func__, diag_buffer->type,
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+	dprint_bsg_info(mrioc, "%s: diag buffer type %d posted successfully\n",
+	    __func__, diag_buffer->type);
+
+out_unlock:
+	if (retval)
+		diag_buffer->status = prev_status;
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+	return retval;
+}
+
+/**
+ * mpi3mr_post_diag_bufs - Post diag buffers to the controller
+ * @mrioc: Adapter instance reference
+ *
+ * This function calls helper function to post both trace and
+ * firmware buffers to the controller.
+ *
+ * Return: None
+ */
+int mpi3mr_post_diag_bufs(struct mpi3mr_ioc *mrioc)
+{
+	u8 i;
+	struct diag_buffer_desc *diag_buffer;
+
+	for (i = 0; i < MPI3MR_MAX_NUM_HDB; i++) {
+		diag_buffer = &mrioc->diag_buffers[i];
+		if (!(diag_buffer->addr))
+			continue;
+		if (mpi3mr_issue_diag_buf_post(mrioc, diag_buffer))
+			return -1;
+	}
+	return 0;
+}
+
+/**
+ * mpi3mr_issue_diag_buf_release - Send diag buffer release req
+ * @mrioc: Adapter instance reference
+ * @diag_buffer: Diagnostic buffer descriptor
+ *
+ * Issue diagnostic buffer manage MPI request with release
+ * action request through admin queue and wait for the
+ * completion of it or time out.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+int mpi3mr_issue_diag_buf_release(struct mpi3mr_ioc *mrioc,
+	struct diag_buffer_desc *diag_buffer)
+{
+	struct mpi3_diag_buffer_manage_request diag_buf_manage_req;
+	int retval = 0;
+
+	if ((diag_buffer->status != MPI3MR_HDB_BUFSTATUS_POSTED_UNPAUSED) &&
+	    (diag_buffer->status != MPI3MR_HDB_BUFSTATUS_POSTED_PAUSED))
+		return retval;
+
+	memset(&diag_buf_manage_req, 0, sizeof(diag_buf_manage_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		dprint_reset(mrioc, "%s: command is in use\n", __func__);
+		mutex_unlock(&mrioc->init_cmds.mutex);
+		return -1;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	diag_buf_manage_req.host_tag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	diag_buf_manage_req.function = MPI3_FUNCTION_DIAG_BUFFER_MANAGE;
+	diag_buf_manage_req.type = diag_buffer->type;
+	diag_buf_manage_req.action = MPI3_DIAG_BUFFER_ACTION_RELEASE;
+
+
+	dprint_reset(mrioc, "%s: releasing diag buffer type %d\n", __func__,
+	    diag_buffer->type);
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &diag_buf_manage_req,
+	    sizeof(diag_buf_manage_req), 1);
+	if (retval) {
+		dprint_reset(mrioc, "%s: admin request post failed\n", __func__);
+		mpi3mr_set_trigger_data_in_hdb(diag_buffer,
+		    MPI3MR_HDB_TRIGGER_TYPE_UNKNOWN, NULL, 1);
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		mrioc->init_cmds.is_waiting = 0;
+		dprint_reset(mrioc, "%s: command timedout\n", __func__);
+		mpi3mr_check_rh_fault_ioc(mrioc,
+		    MPI3MR_RESET_FROM_DIAG_BUFFER_RELEASE_TIMEOUT);
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		dprint_reset(mrioc,
+		    "%s: command failed, buffer_type (%d) ioc_status(0x%04x) log_info(0x%08x)\n",
+		    __func__, diag_buffer->type,
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+	dprint_reset(mrioc, "%s: diag buffer type %d released successfully\n",
+	    __func__, diag_buffer->type);
+
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+	return retval;
+}
+
+/**
+ * mpi3mr_get_num_trigger - Gets number of HDB triggers
+ * @mrioc: Adapter instance reference
+ * @num_triggers: Number of triggers
+ * @page_action: Page action
+ *
+ * This function reads number of triggers by reading driver page
+ * 2
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+static int mpi3mr_get_num_trigger(struct mpi3mr_ioc *mrioc, u8 *num_triggers,
+	u8 page_action)
+{
+	struct mpi3_driver_page2 drvr_page2;
+	int retval = 0;
+
+	*num_triggers = 0;
+
+	retval = mpi3mr_cfg_get_driver_pg2(mrioc, &drvr_page2,
+	    sizeof(struct mpi3_driver_page2), page_action);
+
+	if (retval) {
+		dprint_init(mrioc, "%s: driver page 2 read failed\n", __func__);
+		return retval;
+	}
+	*num_triggers = drvr_page2.num_triggers;
+	return retval;
+}
+
+/**
+ * mpi3mr_refresh_trigger - Handler for Refresh trigger BSG
+ * @mrioc: Adapter instance reference
+ * @page_action: Page action
+ *
+ * This function caches the driver page 2 in the driver's memory
+ * by reading driver page 2 from the controller for a given page
+ * type and updates the HDB trigger values
+ *
+ * Return: 0 on success and proper error codes on failure
+ */
+int mpi3mr_refresh_trigger(struct mpi3mr_ioc *mrioc, u8 page_action)
+{
+	u16 pg_sz = sizeof(struct mpi3_driver_page2);
+	struct mpi3_driver_page2 *drvr_page2 = NULL;
+	u8 trigger_type, num_triggers;
+	int retval;
+	int i = 0;
+	unsigned long flags;
+
+	retval = mpi3mr_get_num_trigger(mrioc, &num_triggers, page_action);
+
+	if (retval)
+		goto out;
+
+	pg_sz = offsetof(struct mpi3_driver_page2, trigger) +
+		(num_triggers * sizeof(union mpi3_driver2_trigger_element));
+	drvr_page2 = kzalloc(pg_sz, GFP_KERNEL);
+	if (!drvr_page2) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
+	retval = mpi3mr_cfg_get_driver_pg2(mrioc, drvr_page2, pg_sz, page_action);
+	if (retval) {
+		dprint_init(mrioc, "%s: driver page 2 read failed\n", __func__);
+		kfree(drvr_page2);
+		goto out;
+	}
+	spin_lock_irqsave(&mrioc->trigger_lock, flags);
+	kfree(mrioc->driver_pg2);
+	mrioc->driver_pg2 = drvr_page2;
+	mrioc->reply_trigger_present = false;
+	mrioc->event_trigger_present = false;
+	mrioc->scsisense_trigger_present = false;
+
+	for (i = 0; (i < mrioc->driver_pg2->num_triggers); i++) {
+		trigger_type = mrioc->driver_pg2->trigger[i].event.type;
+		switch (trigger_type) {
+		case MPI3_DRIVER2_TRIGGER_TYPE_REPLY:
+			mrioc->reply_trigger_present = true;
+			break;
+		case MPI3_DRIVER2_TRIGGER_TYPE_EVENT:
+			mrioc->event_trigger_present = true;
+			break;
+		case MPI3_DRIVER2_TRIGGER_TYPE_SCSI_SENSE:
+			mrioc->scsisense_trigger_present = true;
+			break;
+		default:
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&mrioc->trigger_lock, flags);
+out:
+	return retval;
+}
+
+/**
+ * mpi3mr_release_diag_bufs - Release diag buffers
+ * @mrioc: Adapter instance reference
+ * @skip_rel_action: Skip release action and set buffer state
+ *
+ * This function calls helper function to release both trace and
+ * firmware buffers from the controller.
+ *
+ * Return: None
+ */
+void mpi3mr_release_diag_bufs(struct mpi3mr_ioc *mrioc, u8 skip_rel_action)
+{
+	u8 i;
+	struct diag_buffer_desc *diag_buffer;
+
+	for (i = 0; i < MPI3MR_MAX_NUM_HDB; i++) {
+		diag_buffer = &mrioc->diag_buffers[i];
+		if (!(diag_buffer->addr))
+			continue;
+		if (diag_buffer->status == MPI3MR_HDB_BUFSTATUS_RELEASED)
+			continue;
+		if (!skip_rel_action)
+			mpi3mr_issue_diag_buf_release(mrioc, diag_buffer);
+		diag_buffer->status = MPI3MR_HDB_BUFSTATUS_RELEASED;
+		atomic64_inc(&event_counter);
+	}
+}
+
+/**
+ * mpi3mr_set_trigger_data_in_hdb - Updates HDB trigger type and
+ * trigger data
+ *
+ * @hdb: HDB pointer
+ * @type: Trigger type
+ * @data: Trigger data
+ * @force: Trigger overwrite flag
+ * @trigger_data: pointer to trigger data information
+ *
+ * Updates trigger type and trigger data based on parameter
+ * passed to this function
+ *
+ * Return: Nothing
+ */
+void mpi3mr_set_trigger_data_in_hdb(struct diag_buffer_desc *hdb,
+	u8 type, union mpi3mr_trigger_data *trigger_data, bool force)
+{
+	if ((!force) && (hdb->trigger_type != MPI3MR_HDB_TRIGGER_TYPE_UNKNOWN))
+		return;
+	hdb->trigger_type = type;
+	if (!trigger_data)
+		memset(&hdb->trigger_data, 0, sizeof(*trigger_data));
+	else
+		memcpy(&hdb->trigger_data, trigger_data, sizeof(*trigger_data));
+}
+
+/**
+ * mpi3mr_diag_buffer_for_type - returns buffer desc for type
+ * @mrioc: Adapter instance reference
+ * @buf_type: Diagnostic buffer type
+ *
+ * Identifies matching diag descriptor from mrioc for given diag
+ * buffer type.
+ *
+ * Return: diag buffer descriptor on success, NULL on failures.
+ */
+
+struct diag_buffer_desc *
+mpi3mr_diag_buffer_for_type(struct mpi3mr_ioc *mrioc, u8 buf_type)
+{
+	u8 i;
+
+	for (i = 0; i < MPI3MR_MAX_NUM_HDB; i++) {
+		if (mrioc->diag_buffers[i].type == buf_type)
+			return &mrioc->diag_buffers[i];
+	}
+	return NULL;
+}
+
 /**
  * mpi3mr_bsg_pel_abort - sends PEL abort request
  * @mrioc: Adapter instance reference
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index c2a22e96f7b7..fbd6f32f79ce 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3003,7 +3003,11 @@ static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
 	mrioc->facts.sge_mod_shift = facts_data->sge_modifier_shift;
 	mrioc->facts.shutdown_timeout =
 	    le16_to_cpu(facts_data->shutdown_timeout);
-
+	mrioc->facts.diag_trace_sz =
+	    le32_to_cpu(facts_data->diag_trace_size);
+	mrioc->facts.diag_fw_sz =
+	    le32_to_cpu(facts_data->diag_fw_size);
+	mrioc->facts.diag_drvr_sz = le32_to_cpu(facts_data->diag_driver_size);
 	mrioc->facts.max_dev_per_tg =
 	    facts_data->max_devices_per_throttle_group;
 	mrioc->facts.io_throttle_data_length =
@@ -3681,6 +3685,94 @@ static const struct {
 	{ MPI3_IOCFACTS_CAPABILITY_MULTIPATH_SUPPORTED, "MultiPath" },
 };
 
+/**
+ * mpi3mr_repost_diag_bufs - repost host diag buffers
+ * @mrioc: Adapter instance reference
+ *
+ * repost firmware and trace diag buffers based on global
+ * trigger flag from driver page 2
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static int mpi3mr_repost_diag_bufs(struct mpi3mr_ioc *mrioc)
+{
+	u64 global_trigger;
+	union mpi3mr_trigger_data prev_trigger_data;
+	struct diag_buffer_desc *trace_hdb = NULL;
+	struct diag_buffer_desc *fw_hdb = NULL;
+	int retval = 0;
+	bool trace_repost_needed = false;
+	bool fw_repost_needed = false;
+	u8 prev_trigger_type;
+
+	retval = mpi3mr_refresh_trigger(mrioc, MPI3_CONFIG_ACTION_READ_CURRENT);
+	if (retval)
+		return -1;
+
+	trace_hdb = mpi3mr_diag_buffer_for_type(mrioc,
+	    MPI3_DIAG_BUFFER_TYPE_TRACE);
+
+	if (trace_hdb &&
+	    trace_hdb->status != MPI3MR_HDB_BUFSTATUS_NOT_ALLOCATED &&
+	    trace_hdb->trigger_type != MPI3MR_HDB_TRIGGER_TYPE_GLOBAL &&
+	    trace_hdb->trigger_type != MPI3MR_HDB_TRIGGER_TYPE_ELEMENT)
+		trace_repost_needed = true;
+
+	fw_hdb = mpi3mr_diag_buffer_for_type(mrioc, MPI3_DIAG_BUFFER_TYPE_FW);
+
+	if (fw_hdb && fw_hdb->status != MPI3MR_HDB_BUFSTATUS_NOT_ALLOCATED &&
+	    fw_hdb->trigger_type != MPI3MR_HDB_TRIGGER_TYPE_GLOBAL &&
+	    fw_hdb->trigger_type != MPI3MR_HDB_TRIGGER_TYPE_ELEMENT)
+		fw_repost_needed = true;
+
+	if (trace_repost_needed || fw_repost_needed) {
+		global_trigger = le64_to_cpu(mrioc->driver_pg2->global_trigger);
+		if (global_trigger &
+		      MPI3_DRIVER2_GLOBALTRIGGER_POST_DIAG_TRACE_DISABLED)
+			trace_repost_needed = false;
+		if (global_trigger &
+		     MPI3_DRIVER2_GLOBALTRIGGER_POST_DIAG_FW_DISABLED)
+			fw_repost_needed = false;
+	}
+
+	if (trace_repost_needed) {
+		prev_trigger_type = trace_hdb->trigger_type;
+		memcpy(&prev_trigger_data, &trace_hdb->trigger_data,
+		    sizeof(trace_hdb->trigger_data));
+		retval = mpi3mr_issue_diag_buf_post(mrioc, trace_hdb);
+		if (!retval) {
+			dprint_init(mrioc, "trace diag buffer reposted");
+			mpi3mr_set_trigger_data_in_hdb(trace_hdb,
+				    MPI3MR_HDB_TRIGGER_TYPE_UNKNOWN, NULL, 1);
+		} else {
+			trace_hdb->trigger_type = prev_trigger_type;
+			memcpy(&trace_hdb->trigger_data, &prev_trigger_data,
+			    sizeof(prev_trigger_data));
+			ioc_err(mrioc, "trace diag buffer repost failed");
+			return -1;
+		}
+	}
+
+	if (fw_repost_needed) {
+		prev_trigger_type = fw_hdb->trigger_type;
+		memcpy(&prev_trigger_data, &fw_hdb->trigger_data,
+		    sizeof(fw_hdb->trigger_data));
+		retval = mpi3mr_issue_diag_buf_post(mrioc, fw_hdb);
+		if (!retval) {
+			dprint_init(mrioc, "firmware diag buffer reposted");
+			mpi3mr_set_trigger_data_in_hdb(fw_hdb,
+				    MPI3MR_HDB_TRIGGER_TYPE_UNKNOWN, NULL, 1);
+		} else {
+			fw_hdb->trigger_type = prev_trigger_type;
+			memcpy(&fw_hdb->trigger_data, &prev_trigger_data,
+			    sizeof(prev_trigger_data));
+			ioc_err(mrioc, "firmware diag buffer repost failed");
+			return -1;
+		}
+	}
+	return retval;
+}
+
 /**
  * mpi3mr_print_ioc_info - Display controller information
  * @mrioc: Adapter instance reference
@@ -3989,9 +4081,18 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 		}
 	}
 
+	dprint_init(mrioc, "allocating host diag buffers\n");
+	mpi3mr_alloc_diag_bufs(mrioc);
+
 	dprint_init(mrioc, "allocating ioctl dma buffers\n");
 	mpi3mr_alloc_ioctl_dma_memory(mrioc);
 
+	dprint_init(mrioc, "posting host diag buffers\n");
+	retval = mpi3mr_post_diag_bufs(mrioc);
+
+	if (retval)
+		ioc_warn(mrioc, "failed to post host diag buffers\n");
+
 	if (!mrioc->init_cmds.reply) {
 		retval = mpi3mr_alloc_reply_sense_bufs(mrioc);
 		if (retval) {
@@ -4144,6 +4245,17 @@ int mpi3mr_reinit_ioc(struct mpi3mr_ioc *mrioc, u8 is_resume)
 
 	mpi3mr_print_ioc_info(mrioc);
 
+	if (is_resume) {
+		dprint_reset(mrioc, "posting host diag buffers\n");
+		retval = mpi3mr_post_diag_bufs(mrioc);
+		if (retval)
+			ioc_warn(mrioc, "failed to post host diag buffers\n");
+	} else {
+		retval = mpi3mr_repost_diag_bufs(mrioc);
+		if (retval)
+			ioc_warn(mrioc, "failed to re post host diag buffers\n");
+	}
+
 	dprint_reset(mrioc, "sending ioc_init\n");
 	retval = mpi3mr_issue_iocinit(mrioc);
 	if (retval) {
@@ -4409,6 +4521,7 @@ void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
 {
 	u16 i;
 	struct mpi3mr_intr_info *intr_info;
+	struct diag_buffer_desc *diag_buffer;
 
 	mpi3mr_free_enclosure_list(mrioc);
 	mpi3mr_free_ioctl_dma_memory(mrioc);
@@ -4543,6 +4656,19 @@ void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
 		mrioc->pel_seqnum_virt = NULL;
 	}
 
+	for (i = 0; i < MPI3MR_MAX_NUM_HDB; i++) {
+		diag_buffer = &mrioc->diag_buffers[i];
+		if (diag_buffer->addr) {
+			dma_free_coherent(&mrioc->pdev->dev,
+			    diag_buffer->size, diag_buffer->addr,
+			    diag_buffer->dma_addr);
+			diag_buffer->addr = NULL;
+			diag_buffer->size = 0;
+			diag_buffer->type = 0;
+			diag_buffer->status = 0;
+		}
+	}
+
 	kfree(mrioc->throttle_groups);
 	mrioc->throttle_groups = NULL;
 
@@ -5016,6 +5142,9 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 	if ((!snapdump) && (reset_reason != MPI3MR_RESET_FROM_FAULT_WATCH) &&
 	    (reset_reason != MPI3MR_RESET_FROM_FIRMWARE) &&
 	    (reset_reason != MPI3MR_RESET_FROM_CIACTIV_FAULT)) {
+		dprint_reset(mrioc,
+		    "soft_reset_handler: releasing host diagnostic buffers\n");
+		mpi3mr_release_diag_bufs(mrioc, 0);
 		for (i = 0; i < MPI3_EVENT_NOTIFY_EVENTMASK_WORDS; i++)
 			mrioc->event_masks[i] = -1;
 
@@ -5075,6 +5204,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 		mrioc->prepare_for_reset_timeout_counter = 0;
 	}
 	mpi3mr_memset_buffers(mrioc);
+	mpi3mr_release_diag_bufs(mrioc, 1);
 	retval = mpi3mr_reinit_ioc(mrioc, 0);
 	if (retval) {
 		pr_err(IOCNAME "reinit after soft reset failed: reason %d\n",
@@ -5954,3 +6084,64 @@ int mpi3mr_cfg_get_driver_pg1(struct mpi3mr_ioc *mrioc,
 out_failed:
 	return -1;
 }
+
+/**
+ * mpi3mr_cfg_get_driver_pg2 - Read current driver page2
+ * @mrioc: Adapter instance reference
+ * @driver_pg2: Pointer to return driver page 2
+ * @pg_sz: Size of the memory allocated to the page pointer
+ * @page_action: Page action
+ *
+ * This is handler for config page read for the driver page2.
+ * This routine checks ioc_status to decide whether the page
+ * read is success or not.
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+int mpi3mr_cfg_get_driver_pg2(struct mpi3mr_ioc *mrioc,
+	struct mpi3_driver_page2 *driver_pg2, u16 pg_sz, u8 page_action)
+{
+	struct mpi3_config_page_header cfg_hdr;
+	struct mpi3_config_request cfg_req;
+	u16 ioc_status = 0;
+
+	memset(driver_pg2, 0, pg_sz);
+	memset(&cfg_hdr, 0, sizeof(cfg_hdr));
+	memset(&cfg_req, 0, sizeof(cfg_req));
+
+	cfg_req.function = MPI3_FUNCTION_CONFIG;
+	cfg_req.action = MPI3_CONFIG_ACTION_PAGE_HEADER;
+	cfg_req.page_type = MPI3_CONFIG_PAGETYPE_DRIVER;
+	cfg_req.page_number = 2;
+	cfg_req.page_address = 0;
+	cfg_req.page_version = MPI3_DRIVER2_PAGEVERSION;
+
+	if (mpi3mr_process_cfg_req(mrioc, &cfg_req, NULL,
+	    MPI3MR_INTADMCMD_TIMEOUT, &ioc_status, &cfg_hdr, sizeof(cfg_hdr))) {
+		ioc_err(mrioc, "driver page2 header read failed\n");
+		goto out_failed;
+	}
+	if (ioc_status != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc, "driver page2 header read failed with\n"
+			       "ioc_status(0x%04x)\n",
+		    ioc_status);
+		goto out_failed;
+	}
+	cfg_req.action = page_action;
+
+	if (mpi3mr_process_cfg_req(mrioc, &cfg_req, &cfg_hdr,
+	    MPI3MR_INTADMCMD_TIMEOUT, &ioc_status, driver_pg2, pg_sz)) {
+		ioc_err(mrioc, "driver page2 read failed\n");
+		goto out_failed;
+	}
+	if (ioc_status != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc, "driver page2 read failed with\n"
+			       "ioc_status(0x%04x)\n",
+		    ioc_status);
+		goto out_failed;
+	}
+	return 0;
+out_failed:
+	return -1;
+}
+
-- 
2.31.1


--000000000000360db6061bc87f83
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
GK2Ee6ez7fr/FL1RWbOPVHJR+deNIorOjW7U5HVwnRYhM1OR4mAkrkqcN+3kwae0KmVO3SDKFd7h
Ok4L2e1ixyaRTo379Ur3iVTnagglDOliayMGRITBPe0CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8WuEiYXvpeCaubgLCCFoyRBc
8QwwDQYJKoZIhvcNAQELBQADggEBAA5th3yz1fvJCBmK21x68IdDNFC0gmynT76I3fOgslLHc7ey
lC9VXLb+vJ863blS/WxEOwf0fvc0ks7qYWl8xisInHu5AX9glaooGhLImlzE0l9rDf0tcq2kkgc4
CXL9UGDEoqdxfRj3j9xn9fm9gpTBWSck6ufc/8RV1TLVjcZvrYkMqQwoVulGkr+HCnzaEFxBRmO/
nWsVitGa1sKS9usFXoW1bQXgJ9TtRdy8gka8b9SaKnh4TaiEKpdl8ztXhugWp7RpFGVu/ZZ8narx
0H1L9W/UIr3J/uYokdFr+hIrXOfOwJLB18bWOTCVWxTEo4zYC8qZ/h7UcS5aispm/rkxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxMV+PqteWF5WGw7jsw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIM/XYwjQ9QvCurtvPzSv3pztZD7aKrot
2Avza76Vb/v7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NjEwMzAwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQDdTsRJFRWQANybp9OSLcSaqgKxRD0w3HCkkFyqCXwClFbo+ie0
53Rh8v0T/tmKdGUamC4pf40JAJN9tV86457/ibgRSxMBmXWEDLK/VqbuIAtRmfF6NhzSI+9x7CuQ
m2QdYFFQiTgtXxnlWcUxFwxqdZiuXkl69FliifMDd6EkdhSD7rQ+aNFhN2VNHhq6kMnIj8ZYcw0K
BD3+NqqsZjchJlQhtjQq9F5JNayjO5ij/btk5YA7qGheREBnWx6jpyZHphibTNopN/mzAKzvIs7D
y5bjaWjsZlDtE+lUZ3nGyKnB6WhT2DSBvjI5En76mXCsg1bkPGWxlkFi/6Ivvw8X
--000000000000360db6061bc87f83--

