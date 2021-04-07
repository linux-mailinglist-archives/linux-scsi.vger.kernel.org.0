Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A50D356135
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Apr 2021 04:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbhDGCEe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Apr 2021 22:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDGCEc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Apr 2021 22:04:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CEC06174A
        for <linux-scsi@vger.kernel.org>; Tue,  6 Apr 2021 19:04:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c204so8039767pfc.4
        for <linux-scsi@vger.kernel.org>; Tue, 06 Apr 2021 19:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aNw6nVQAIRO6LMIh4xHkcr58taDQalc0wN6l1B/VK3Q=;
        b=B8vf29CQA94H3cgkBkH0xxg1ZO5iIDZLRVFv7nZwG0ZiNzO56Ti+3HKgLx2I8Serpd
         ohwb/XwC5YbjmykpwPnQfVWxzttXOhcdLwgW0EOGjvigovdKLmElL9mI2i8Z33uLYpO2
         SI2G8aoP5VWwV0d6DM1+tdYnSmglpTl5oa6Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aNw6nVQAIRO6LMIh4xHkcr58taDQalc0wN6l1B/VK3Q=;
        b=QrWlHGDa7hoiRtXalG7cwhHTJ19FMWlSLdUVvP8u/fWI3caAg0Hv0TDrlOmC2NK8jU
         oc9G1SYRbRj0Psj4Q1eoQkBE8Hgly82LpQu2Qls2MqrYlVmnUFssMejtFPrHlrx1Jv2x
         EkGrFIbacX9Cd/YNG0ovneX91YZjzPkW0tHLU22QJyu1soJ2o4vKVWAObSO75Fo+fJgf
         CnmwYfUppetO9ht8fidmMPLLXTcCactwzT/t8fsP+iJ6CiXWUBqQXFeMJNDtGvqBdSww
         MMS77TPSXQndvjqKxz+VI2SnnkBZLE4ae2N+BI7FRgu4/MW5wGeTRxg6AFgSj3Arb7A3
         JZqA==
X-Gm-Message-State: AOAM532stP+vTay+i5TT7QaNdz4rLcDED34Fwl06MJH/FwSD2cVQ6bVn
        WtopRGdgoxjUoHyGPKCG7qrv6sX7cqRdU9NUPBwshl0rh0UVtzg6JZVlHM868uFYgB3qHCBp7qQ
        p5YMEg05f9YeGoqcP0vg/Kb5Rive6nKFUQc3edcsmQm1MK6bj4JrCbk7Y7DAdgQZ162xNrBQnEs
        p2trPATw==
X-Google-Smtp-Source: ABdhPJxxSpf+Gqu0BIhgxX9h8vPFlDRv9crycLbMDgAA/G9vxCyGipdBOujh09jkLGSPGxDyAzKYsA==
X-Received: by 2002:a62:868a:0:b029:23e:5c30:edef with SMTP id x132-20020a62868a0000b029023e5c30edefmr971985pfd.56.1617761060798;
        Tue, 06 Apr 2021 19:04:20 -0700 (PDT)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y9sm3435858pja.50.2021.04.06.19.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 19:04:19 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com
Subject: [PATCH v2 02/24] mpi3mr: base driver code
Date:   Wed,  7 Apr 2021 07:34:29 +0530
Message-Id: <20210407020451.924822-3-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210407020451.924822-1-kashyap.desai@broadcom.com>
References: <20210407020451.924822-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006d971505bf585919"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000006d971505bf585919

This patch covers basic pci device driver requirements -
device probe, memory allocation, mapping system registers,
allocate irq lines etc.

Source is managed in mainly three different files.

mpi3mr_fw.c -	Keep common code which interact with underlying fw/hw.
mpi3mr_os.c -	Keep common code which interact with scsi midlayer.
mpi3mr_app.c -	Keep common code which interact with application/ioctl.
		This is currently work in progress.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: sathya.prakash@broadcom.com
---
 drivers/scsi/mpi3mr/Makefile       |    4 +
 drivers/scsi/mpi3mr/mpi3mr.h       |  525 ++++++++
 drivers/scsi/mpi3mr/mpi3mr_debug.h |   60 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c    | 1819 ++++++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_os.c    |  368 ++++++
 5 files changed, 2776 insertions(+)
 create mode 100644 drivers/scsi/mpi3mr/Makefile
 create mode 100644 drivers/scsi/mpi3mr/mpi3mr.h
 create mode 100644 drivers/scsi/mpi3mr/mpi3mr_debug.h
 create mode 100644 drivers/scsi/mpi3mr/mpi3mr_fw.c
 create mode 100644 drivers/scsi/mpi3mr/mpi3mr_os.c

diff --git a/drivers/scsi/mpi3mr/Makefile b/drivers/scsi/mpi3mr/Makefile
new file mode 100644
index 000000000000..7c2063e04c81
--- /dev/null
+++ b/drivers/scsi/mpi3mr/Makefile
@@ -0,0 +1,4 @@
+# mpi3mr makefile
+obj-m += mpi3mr.o
+mpi3mr-y +=  mpi3mr_os.o     \
+		mpi3mr_fw.o \
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
new file mode 100644
index 000000000000..cf1cfea19826
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -0,0 +1,525 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Broadcom MPI3 Storage Controllers
+ *
+ * Copyright (C) 2017-2020 Broadcom Inc.
+ *  (mailto: mpi3mr-linuxdrv.pdl@broadcom.com)
+ *
+ */
+
+#ifndef MPI3MR_H_INCLUDED
+#define MPI3MR_H_INCLUDED
+
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/blk-mq-pci.h>
+#include <linux/delay.h>
+#include <linux/dmapool.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+#include <linux/workqueue.h>
+#include <asm/unaligned.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_dbg.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_tcq.h>
+
+#include "mpi/mpi30_api.h"
+#include "mpi3mr_debug.h"
+
+/* Global list and lock for storing multiple adapters managed by the driver */
+extern spinlock_t mrioc_list_lock;
+extern struct list_head mrioc_list;
+
+#define MPI3MR_DRIVER_VERSION	"00.255.45.01"
+#define MPI3MR_DRIVER_RELDATE	"12-December-2020"
+
+#define MPI3MR_DRIVER_NAME	"mpi3mr"
+#define MPI3MR_DRIVER_LICENSE	"GPL"
+#define MPI3MR_DRIVER_AUTHOR	"Broadcom Inc. <mpi3mr-linuxdrv.pdl@broadcom.com>"
+#define MPI3MR_DRIVER_DESC	"MPI3 Storage Controller Device Driver"
+
+#define MPI3MR_NAME_LENGTH	32
+#define IOCNAME			"%s: "
+
+/* Definitions for internal SGL and Chain SGL buffers */
+#define MPI3MR_PAGE_SIZE_4K		4096
+#define MPI3MR_SG_DEPTH		(PAGE_SIZE/sizeof(Mpi3SGESimple_t))
+
+/* Definitions for MAX values for shost */
+#define MPI3MR_MAX_CMDS_LUN	7
+#define MPI3MR_MAX_CDB_LENGTH	32
+
+/* Admin queue management definitions */
+#define MPI3MR_ADMIN_REQ_Q_SIZE		(2 * MPI3MR_PAGE_SIZE_4K)
+#define MPI3MR_ADMIN_REPLY_Q_SIZE	(4 * MPI3MR_PAGE_SIZE_4K)
+#define MPI3MR_ADMIN_REQ_FRAME_SZ	128
+#define MPI3MR_ADMIN_REPLY_FRAME_SZ	16
+
+
+/* Reserved Host Tag definitions */
+#define MPI3MR_HOSTTAG_INVALID		0xFFFF
+#define MPI3MR_HOSTTAG_INITCMDS		1
+#define MPI3MR_HOSTTAG_IOCTLCMDS	2
+#define MPI3MR_HOSTTAG_BLK_TMS		5
+
+#define MPI3MR_NUM_DEVRMCMD		1
+#define MPI3MR_HOSTTAG_DEVRMCMD_MIN	(MPI3MR_HOSTTAG_BLK_TMS + 1)
+#define MPI3MR_HOSTTAG_DEVRMCMD_MAX	(MPI3MR_HOSTTAG_DEVRMCMD_MIN + \
+						MPI3MR_NUM_DEVRMCMD - 1)
+
+#define MPI3MR_INTERNAL_CMDS_RESVD     MPI3MR_HOSTTAG_DEVRMCMD_MAX
+
+/* Reduced resource count definition for crash kernel */
+#define MPI3MR_HOST_IOS_KDUMP		128
+
+/* command/controller interaction timeout definitions in seconds */
+#define MPI3MR_INTADMCMD_TIMEOUT		10
+#define MPI3MR_RESETTM_TIMEOUT			30
+#define MPI3MR_DEFAULT_SHUTDOWN_TIME		120
+
+#define MPI3MR_WATCHDOG_INTERVAL		1000 /* in milli seconds */
+
+/* Internal admin command state definitions*/
+#define MPI3MR_CMD_NOTUSED	0x8000
+#define MPI3MR_CMD_COMPLETE	0x0001
+#define MPI3MR_CMD_PENDING	0x0002
+#define MPI3MR_CMD_REPLY_VALID	0x0004
+#define MPI3MR_CMD_RESET	0x0008
+
+/* Definitions for Event replies and sense buffer allocated per controller */
+#define MPI3MR_NUM_EVT_REPLIES	64
+#define MPI3MR_SENSEBUF_SZ	256
+#define MPI3MR_SENSEBUF_FACTOR	3
+#define MPI3MR_CHAINBUF_FACTOR	3
+
+/* Invalid target device handle */
+#define MPI3MR_INVALID_DEV_HANDLE	0xFFFF
+
+/* Controller Reset related definitions */
+#define MPI3MR_HOSTDIAG_UNLOCK_RETRY_COUNT	5
+#define MPI3MR_MAX_RESET_RETRY_COUNT		3
+
+/* ResponseCode definitions */
+#define MPI3MR_RI_MASK_RESPCODE		(0x000000FF)
+#define MPI3MR_RSP_TM_COMPLETE		0x00
+#define MPI3MR_RSP_INVALID_FRAME	0x02
+#define MPI3MR_RSP_TM_NOT_SUPPORTED	0x04
+#define MPI3MR_RSP_TM_FAILED		0x05
+#define MPI3MR_RSP_TM_SUCCEEDED		0x08
+#define MPI3MR_RSP_TM_INVALID_LUN	0x09
+#define MPI3MR_RSP_TM_OVERLAPPED_TAG	0x0A
+#define MPI3MR_RSP_IO_QUEUED_ON_IOC \
+			MPI3_SCSITASKMGMT_RSPCODE_IO_QUEUED_ON_IOC
+
+/* SGE Flag definition */
+#define MPI3MR_SGEFLAGS_SYSTEM_SIMPLE_END_OF_LIST \
+	(MPI3_SGE_FLAGS_ELEMENT_TYPE_SIMPLE | MPI3_SGE_FLAGS_DLAS_SYSTEM | \
+	MPI3_SGE_FLAGS_END_OF_LIST)
+
+/* IOC State definitions */
+enum mpi3mr_iocstate {
+	MRIOC_STATE_READY = 1,
+	MRIOC_STATE_RESET,
+	MRIOC_STATE_FAULT,
+	MRIOC_STATE_BECOMING_READY,
+	MRIOC_STATE_RESET_REQUESTED,
+	MRIOC_STATE_UNRECOVERABLE,
+};
+
+/* Reset reason code definitions*/
+enum mpi3mr_reset_reason {
+	MPI3MR_RESET_FROM_BRINGUP = 1,
+	MPI3MR_RESET_FROM_FAULT_WATCH = 2,
+	MPI3MR_RESET_FROM_IOCTL = 3,
+	MPI3MR_RESET_FROM_EH_HOS = 4,
+	MPI3MR_RESET_FROM_TM_TIMEOUT = 5,
+	MPI3MR_RESET_FROM_IOCTL_TIMEOUT = 6,
+	MPI3MR_RESET_FROM_MUR_FAILURE = 7,
+	MPI3MR_RESET_FROM_CTLR_CLEANUP = 8,
+	MPI3MR_RESET_FROM_CIACTIV_FAULT = 9,
+	MPI3MR_RESET_FROM_PE_TIMEOUT = 10,
+	MPI3MR_RESET_FROM_TSU_TIMEOUT = 11,
+	MPI3MR_RESET_FROM_DELREQQ_TIMEOUT = 12,
+	MPI3MR_RESET_FROM_DELREPQ_TIMEOUT = 13,
+	MPI3MR_RESET_FROM_CREATEREPQ_TIMEOUT = 14,
+	MPI3MR_RESET_FROM_CREATEREQQ_TIMEOUT = 15,
+	MPI3MR_RESET_FROM_IOCFACTS_TIMEOUT = 16,
+	MPI3MR_RESET_FROM_IOCINIT_TIMEOUT = 17,
+	MPI3MR_RESET_FROM_EVTNOTIFY_TIMEOUT = 18,
+	MPI3MR_RESET_FROM_EVTACK_TIMEOUT = 19,
+	MPI3MR_RESET_FROM_CIACTVRST_TIMER = 20,
+	MPI3MR_RESET_FROM_GETPKGVER_TIMEOUT = 21,
+};
+
+/**
+ * struct mpi3mr_compimg_ver - replica of component image
+ * version defined in mpi30_image.h in host endianness
+ *
+ */
+struct mpi3mr_compimg_ver {
+	u16 build_num;
+	u16 cust_id;
+	u8 ph_minor;
+	u8 ph_major;
+	u8 gen_minor;
+	u8 gen_major;
+};
+
+/**
+ * struct mpi3mr_ioc_facs - replica of component image version
+ * defined in mpi30_ioc.h in host endianness
+ *
+ */
+struct mpi3mr_ioc_facts {
+	u32 ioc_capabilities;
+	struct mpi3mr_compimg_ver fw_ver;
+	u32 mpi_version;
+	u16 max_reqs;
+	u16 product_id;
+	u16 op_req_sz;
+	u16 reply_sz;
+	u16 exceptions;
+	u16 max_perids;
+	u16 max_pds;
+	u16 max_sasexpanders;
+	u16 max_sasinitiators;
+	u16 max_enclosures;
+	u16 max_pcieswitches;
+	u16 max_nvme;
+	u16 max_vds;
+	u16 max_hpds;
+	u16 max_advhpds;
+	u16 max_raidpds;
+	u16 min_devhandle;
+	u16 max_devhandle;
+	u16 max_op_req_q;
+	u16 max_op_reply_q;
+	u16 shutdown_timeout;
+	u8 ioc_num;
+	u8 who_init;
+	u16 max_msix_vectors;
+	u8 personality;
+	u8 dma_mask;
+	u8 protocol_flags;
+	u8 sge_mod_mask;
+	u8 sge_mod_value;
+	u8 sge_mod_shift;
+};
+
+/**
+ * struct op_req_qinfo -  Operational Request Queue Information
+ *
+ * @ci: consumer index
+ * @pi: producer index
+ */
+struct op_req_qinfo {
+	u16 ci;
+	u16 pi;
+};
+
+/**
+ * struct op_reply_qinfo -  Operational Reply Queue Information
+ *
+ * @ci: consumer index
+ * @qid: Queue Id starting from 1
+ */
+struct op_reply_qinfo {
+	u16 ci;
+	u16 qid;
+};
+
+/**
+ * struct mpi3mr_intr_info -  Interrupt cookie information
+ *
+ * @mrioc: Adapter instance reference
+ * @msix_index: MSIx index
+ * @op_reply_q: Associated operational reply queue
+ * @name: Dev name for the irq claiming device
+ */
+struct mpi3mr_intr_info {
+	struct mpi3mr_ioc *mrioc;
+	u16 msix_index;
+	struct op_reply_qinfo *op_reply_q;
+	char name[MPI3MR_NAME_LENGTH];
+};
+
+
+
+/**
+ * struct mpi3mr_drv_cmd - Internal command tracker
+ *
+ * @mutex: Command mutex
+ * @done: Completeor for wakeup
+ * @reply: Firmware reply for internal commands
+ * @sensebuf: Sensebuf for SCSI IO commands
+ * @state: Command State
+ * @dev_handle: Firmware handle for device specific commands
+ * @ioc_status: IOC status from the firmware
+ * @ioc_loginfo:IOC log info from the firmware
+ * @is_waiting: Is the command issued in block mode
+ * @retry_count: Retry count for retriable commands
+ * @host_tag: Host tag used by the command
+ * @callback: Callback for non blocking commands
+ */
+struct mpi3mr_drv_cmd {
+	struct mutex mutex;
+	struct completion done;
+	void *reply;
+	u8 *sensebuf;
+	u16 state;
+	u16 dev_handle;
+	u16 ioc_status;
+	u32 ioc_loginfo;
+	u8 is_waiting;
+	u8 retry_count;
+	u16 host_tag;
+
+	void (*callback)(struct mpi3mr_ioc *mrioc,
+		struct mpi3mr_drv_cmd *drv_cmd);
+};
+
+
+/**
+ * struct chain_element - memory descriptor structure to store
+ * virtual and dma addresses for chain elements.
+ *
+ * @addr: virtual address
+ * @dma_addr: dma address
+ */
+struct chain_element {
+	void *addr;
+	dma_addr_t dma_addr;
+};
+
+/**
+ * struct scmd_priv - SCSI command private data
+ *
+ * @host_tag: Host tag specific to operational queue
+ * @in_lld_scope: Command in LLD scope or not
+ * @scmd: SCSI Command pointer
+ * @req_q_idx: Operational request queue index
+ * @chain_idx: Chain frame index
+ * @mpi3mr_scsiio_req: MPI SCSI IO request
+ */
+struct scmd_priv {
+	u16 host_tag;
+	u8 in_lld_scope;
+	struct scsi_cmnd *scmd;
+	u16 req_q_idx;
+	int chain_idx;
+	u8 mpi3mr_scsiio_req[MPI3MR_ADMIN_REQ_FRAME_SZ];
+};
+
+/**
+ * struct mpi3mr_ioc - Adapter anchor structure stored in shost
+ * private data
+ *
+ * @list: List pointer
+ * @pdev: PCI device pointer
+ * @shost: Scsi_Host pointer
+ * @id: Controller ID
+ * @cpu_count: Number of online CPUs
+ * @name: Controller ASCII name
+ * @driver_name: Driver ASCII name
+ * @sysif_regs: System interface registers virtual address
+ * @sysif_regs_phys: System interface registers physical address
+ * @bars: PCI BARS
+ * @dma_mask: DMA mask
+ * @msix_count: Number of MSIX vectors used
+ * @intr_enabled: Is interrupts enabled
+ * @num_admin_req: Number of admin requests
+ * @admin_req_q_sz: Admin request queue size
+ * @admin_req_pi: Admin request queue producer index
+ * @admin_req_ci: Admin request queue consumer index
+ * @admin_req_base: Admin request queue base virtual address
+ * @admin_req_dma: Admin request queue base dma address
+ * @admin_req_lock: Admin queue access lock
+ * @num_admin_replies: Number of admin replies
+ * @admin_reply_q_sz: Admin reply queue size
+ * @admin_reply_ci: Admin reply queue consumer index
+ * @admin_reply_ephase:Admin reply queue expected phase
+ * @admin_reply_base: Admin reply queue base virtual address
+ * @admin_reply_dma: Admin reply queue base dma address
+ * @ready_timeout: Controller ready timeout
+ * @intr_info: Interrupt cookie pointer
+ * @intr_info_count: Number of interrupt cookies
+ * @num_queues: Number of operational queues
+ * @num_op_req_q: Number of operational request queues
+ * @req_qinfo: Operational request queue info pointer
+ * @num_op_reply_q: Number of operational reply queues
+ * @op_reply_qinfo: Operational reply queue info pointer
+ * @init_cmds: Command tracker for initialization commands
+ * @facts: Cached IOC facts data
+ * @op_reply_desc_sz: Operational reply descriptor size
+ * @num_reply_bufs: Number of reply buffers allocated
+ * @reply_buf_pool: Reply buffer pool
+ * @reply_buf: Reply buffer base virtual address
+ * @reply_buf_dma: Reply buffer DMA address
+ * @reply_buf_dma_max_address: Reply DMA address max limit
+ * @reply_free_qsz: Reply free queue size
+ * @reply_free_q_pool: Reply free queue pool
+ * @reply_free_q: Reply free queue base virtual address
+ * @reply_free_q_dma: Reply free queue base DMA address
+ * @reply_free_queue_lock: Reply free queue lock
+ * @reply_free_queue_host_index: Reply free queue host index
+ * @num_sense_bufs: Number of sense buffers
+ * @sense_buf_pool: Sense buffer pool
+ * @sense_buf: Sense buffer base virtual address
+ * @sense_buf_dma: Sense buffer base DMA address
+ * @sense_buf_q_sz: Sense buffer queue size
+ * @sense_buf_q_pool: Sense buffer queue pool
+ * @sense_buf_q: Sense buffer queue virtual address
+ * @sense_buf_q_dma: Sense buffer queue DMA address
+ * @sbq_lock: Sense buffer queue lock
+ * @sbq_host_index: Sense buffer queuehost index
+ * @is_driver_loading: Is driver still loading
+ * @max_host_ios: Maximum host I/O count
+ * @chain_buf_count: Chain buffer count
+ * @chain_buf_pool: Chain buffer pool
+ * @chain_sgl_list: Chain SGL list
+ * @chain_bitmap_sz: Chain buffer allocator bitmap size
+ * @chain_bitmap: Chain buffer allocator bitmap
+ * @reset_in_progress: Reset in progress flag
+ * @unrecoverable: Controller unrecoverable flag
+ * @logging_level: Controller debug logging level
+ * @current_event: Firmware event currently in process
+ * @driver_info: Driver, Kernel, OS information to firmware
+ * @change_count: Topology change count
+ */
+struct mpi3mr_ioc {
+	struct list_head list;
+	struct pci_dev *pdev;
+	struct Scsi_Host *shost;
+	u8 id;
+	int cpu_count;
+
+	char name[MPI3MR_NAME_LENGTH];
+	char driver_name[MPI3MR_NAME_LENGTH];
+
+	Mpi3SysIfRegs_t __iomem *sysif_regs;
+	resource_size_t sysif_regs_phys;
+	int bars;
+	u64 dma_mask;
+
+	u16 msix_count;
+	u8 intr_enabled;
+
+	u16 num_admin_req;
+	u32 admin_req_q_sz;
+	u16 admin_req_pi;
+	u16 admin_req_ci;
+	void *admin_req_base;
+	dma_addr_t admin_req_dma;
+	spinlock_t admin_req_lock;
+
+	u16 num_admin_replies;
+	u32 admin_reply_q_sz;
+	u16 admin_reply_ci;
+	u8 admin_reply_ephase;
+	void *admin_reply_base;
+	dma_addr_t admin_reply_dma;
+
+	u32 ready_timeout;
+
+	struct mpi3mr_intr_info *intr_info;
+	u16 intr_info_count;
+
+	u16 num_queues;
+	u16 num_op_req_q;
+	struct op_req_qinfo *req_qinfo;
+
+	u16 num_op_reply_q;
+	struct op_reply_qinfo *op_reply_qinfo;
+
+	struct mpi3mr_drv_cmd init_cmds;
+	struct mpi3mr_ioc_facts facts;
+	u16 op_reply_desc_sz;
+
+	u32 num_reply_bufs;
+	struct dma_pool *reply_buf_pool;
+	u8 *reply_buf;
+	dma_addr_t reply_buf_dma;
+	dma_addr_t reply_buf_dma_max_address;
+
+	u16 reply_free_qsz;
+	struct dma_pool *reply_free_q_pool;
+	U64 *reply_free_q;
+	dma_addr_t reply_free_q_dma;
+	spinlock_t reply_free_queue_lock;
+	u32 reply_free_queue_host_index;
+
+	u32 num_sense_bufs;
+	struct dma_pool *sense_buf_pool;
+	u8 *sense_buf;
+	dma_addr_t sense_buf_dma;
+
+	u16 sense_buf_q_sz;
+	struct dma_pool *sense_buf_q_pool;
+	U64 *sense_buf_q;
+	dma_addr_t sense_buf_q_dma;
+	spinlock_t sbq_lock;
+	u32 sbq_host_index;
+
+	u8 is_driver_loading;
+
+	u16 max_host_ios;
+
+	u32 chain_buf_count;
+	struct dma_pool *chain_buf_pool;
+	struct chain_element *chain_sgl_list;
+	u16  chain_bitmap_sz;
+	void *chain_bitmap;
+
+	u8 reset_in_progress;
+	u8 unrecoverable;
+
+	int logging_level;
+
+	struct mpi3mr_fwevt *current_event;
+	Mpi3DriverInfoLayout_t driver_info;
+	u16 change_count;
+};
+
+int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc);
+void mpi3mr_cleanup_resources(struct mpi3mr_ioc *mrioc);
+int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc);
+void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc);
+int mpi3mr_admin_request_post(struct mpi3mr_ioc *mrioc, void *admin_req,
+u16 admin_req_sz, u8 ignore_reset);
+void mpi3mr_add_sg_single(void *paddr, u8 flags, u32 length,
+			  dma_addr_t dma_addr);
+void mpi3mr_build_zero_len_sge(void *paddr);
+void *mpi3mr_get_sensebuf_virt_addr(struct mpi3mr_ioc *mrioc,
+				     dma_addr_t phys_addr);
+void *mpi3mr_get_reply_virt_addr(struct mpi3mr_ioc *mrioc,
+				     dma_addr_t phys_addr);
+void mpi3mr_repost_sense_buf(struct mpi3mr_ioc *mrioc,
+				     u64 sense_buf_dma);
+
+void mpi3mr_start_watchdog(struct mpi3mr_ioc *mrioc);
+void mpi3mr_stop_watchdog(struct mpi3mr_ioc *mrioc);
+
+int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
+			      u32 reset_reason, u8 snapdump);
+void mpi3mr_ioc_disable_intr(struct mpi3mr_ioc *mrioc);
+void mpi3mr_ioc_enable_intr(struct mpi3mr_ioc *mrioc);
+
+enum mpi3mr_iocstate mpi3mr_get_iocstate(struct mpi3mr_ioc *mrioc);
+
+#endif /*MPI3MR_H_INCLUDED*/
diff --git a/drivers/scsi/mpi3mr/mpi3mr_debug.h b/drivers/scsi/mpi3mr/mpi3mr_debug.h
new file mode 100644
index 000000000000..d35f296d9325
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi3mr_debug.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Broadcom MPI3 Storage Controllers
+ *
+ * Copyright (C) 2017-2020 Broadcom Inc.
+ *  (mailto: mpi3mr-linuxdrv.pdl@broadcom.com)
+ *
+ */
+
+#ifndef MPI3SAS_DEBUG_H_INCLUDED
+
+#define MPI3SAS_DEBUG_H_INCLUDED
+
+/*
+ * debug levels
+ */
+#define MPI3_DEBUG			0x00000001
+#define MPI3_DEBUG_MSG_FRAME		0x00000002
+#define MPI3_DEBUG_SG			0x00000004
+#define MPI3_DEBUG_EVENTS		0x00000008
+#define MPI3_DEBUG_EVENT_WORK_TASK	0x00000010
+#define MPI3_DEBUG_INIT			0x00000020
+#define MPI3_DEBUG_EXIT			0x00000040
+#define MPI3_DEBUG_FAIL			0x00000080
+#define MPI3_DEBUG_TM			0x00000100
+#define MPI3_DEBUG_REPLY		0x00000200
+#define MPI3_DEBUG_HANDSHAKE		0x00000400
+#define MPI3_DEBUG_CONFIG		0x00000800
+#define MPI3_DEBUG_DL			0x00001000
+#define MPI3_DEBUG_RESET		0x00002000
+#define MPI3_DEBUG_SCSI			0x00004000
+#define MPI3_DEBUG_IOCTL		0x00008000
+#define MPI3_DEBUG_CSMISAS		0x00010000
+#define MPI3_DEBUG_SAS			0x00020000
+#define MPI3_DEBUG_TRANSPORT		0x00040000
+#define MPI3_DEBUG_TASK_SET_FULL	0x00080000
+#define MPI3_DEBUG_TRIGGER_DIAG		0x00200000
+
+
+/*
+ * debug macros
+ */
+
+#define ioc_err(ioc, fmt, ...) \
+	pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+#define ioc_notice(ioc, fmt, ...) \
+	pr_notice("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+#define ioc_warn(ioc, fmt, ...) \
+	pr_warn("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+#define ioc_info(ioc, fmt, ...) \
+	pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+
+
+#define dbgprint(IOC, FMT, ...) \
+	do { \
+		if (IOC->logging_level & MPI3_DEBUG) \
+			pr_info("%s: " FMT, (IOC)->name, ##__VA_ARGS__); \
+	} while (0)
+
+#endif /* MPT3SAS_DEBUG_H_INCLUDED */
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
new file mode 100644
index 000000000000..d1f3606c457f
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -0,0 +1,1819 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Broadcom MPI3 Storage Controllers
+ *
+ * Copyright (C) 2017-2020 Broadcom Inc.
+ *  (mailto: mpi3mr-linuxdrv.pdl@broadcom.com)
+ *
+ */
+
+#include "mpi3mr.h"
+
+#if defined(writeq) && defined(CONFIG_64BIT)
+static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+{
+	writeq(b, addr);
+}
+#else
+static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+{
+	__u64 data_out = b;
+
+	writel((u32)(data_out), addr);
+	writel((u32)(data_out >> 32), (addr + 4));
+}
+#endif
+
+static void mpi3mr_sync_irqs(struct mpi3mr_ioc *mrioc)
+{
+	u16 i, max_vectors;
+
+	max_vectors = mrioc->intr_info_count;
+
+	for (i = 0; i < max_vectors; i++)
+		synchronize_irq(pci_irq_vector(mrioc->pdev, i));
+}
+
+void mpi3mr_ioc_disable_intr(struct mpi3mr_ioc *mrioc)
+{
+	mrioc->intr_enabled = 0;
+	mpi3mr_sync_irqs(mrioc);
+}
+
+void mpi3mr_ioc_enable_intr(struct mpi3mr_ioc *mrioc)
+{
+	mrioc->intr_enabled = 1;
+}
+
+static void mpi3mr_cleanup_isr(struct mpi3mr_ioc *mrioc)
+{
+	u16 i;
+
+	mpi3mr_ioc_disable_intr(mrioc);
+
+	if (!mrioc->intr_info)
+		return;
+
+	for (i = 0; i < mrioc->intr_info_count; i++)
+		free_irq(pci_irq_vector(mrioc->pdev, i),
+		    (mrioc->intr_info + i));
+
+	kfree(mrioc->intr_info);
+	mrioc->intr_info = NULL;
+	mrioc->intr_info_count = 0;
+	pci_free_irq_vectors(mrioc->pdev);
+}
+
+void mpi3mr_add_sg_single(void *paddr, u8 flags, u32 length,
+	dma_addr_t dma_addr)
+{
+	Mpi3SGESimple_t *sgel = paddr;
+
+	sgel->Flags = flags;
+	sgel->Length = cpu_to_le32(length);
+	sgel->Address = cpu_to_le64(dma_addr);
+}
+
+void mpi3mr_build_zero_len_sge(void *paddr)
+{
+	u8 sgl_flags = MPI3MR_SGEFLAGS_SYSTEM_SIMPLE_END_OF_LIST;
+
+	mpi3mr_add_sg_single(paddr, sgl_flags, 0, -1);
+
+}
+void *mpi3mr_get_reply_virt_addr(struct mpi3mr_ioc *mrioc,
+	dma_addr_t phys_addr)
+{
+	if (!phys_addr)
+		return NULL;
+
+	if ((phys_addr < mrioc->reply_buf_dma) ||
+	    (phys_addr > mrioc->reply_buf_dma_max_address))
+		return NULL;
+
+	return mrioc->reply_buf + (phys_addr - mrioc->reply_buf_dma);
+}
+
+void *mpi3mr_get_sensebuf_virt_addr(struct mpi3mr_ioc *mrioc,
+	dma_addr_t phys_addr)
+{
+	if (!phys_addr)
+		return NULL;
+
+	return mrioc->sense_buf + (phys_addr - mrioc->sense_buf_dma);
+}
+
+static void mpi3mr_repost_reply_buf(struct mpi3mr_ioc *mrioc,
+	u64 reply_dma)
+{
+	u32 old_idx = 0;
+
+	spin_lock(&mrioc->reply_free_queue_lock);
+	old_idx  =  mrioc->reply_free_queue_host_index;
+	mrioc->reply_free_queue_host_index = (
+	    (mrioc->reply_free_queue_host_index ==
+	    (mrioc->reply_free_qsz - 1)) ? 0 :
+	    (mrioc->reply_free_queue_host_index + 1));
+	mrioc->reply_free_q[old_idx] = cpu_to_le64(reply_dma);
+	writel(mrioc->reply_free_queue_host_index,
+	    &mrioc->sysif_regs->ReplyFreeHostIndex);
+	spin_unlock(&mrioc->reply_free_queue_lock);
+}
+
+void mpi3mr_repost_sense_buf(struct mpi3mr_ioc *mrioc,
+	u64 sense_buf_dma)
+{
+	u32 old_idx = 0;
+
+	spin_lock(&mrioc->sbq_lock);
+	old_idx  =  mrioc->sbq_host_index;
+	mrioc->sbq_host_index = ((mrioc->sbq_host_index ==
+	    (mrioc->sense_buf_q_sz - 1)) ? 0 :
+	    (mrioc->sbq_host_index + 1));
+	mrioc->sense_buf_q[old_idx] = cpu_to_le64(sense_buf_dma);
+	writel(mrioc->sbq_host_index,
+	    &mrioc->sysif_regs->SenseBufferFreeHostIndex);
+	spin_unlock(&mrioc->sbq_lock);
+}
+
+static void mpi3mr_handle_events(struct mpi3mr_ioc *mrioc,
+	Mpi3DefaultReply_t *def_reply)
+{
+	Mpi3EventNotificationReply_t *event_reply =
+	    (Mpi3EventNotificationReply_t *)def_reply;
+
+	mrioc->change_count = le16_to_cpu(event_reply->IOCChangeCount);
+}
+
+static struct mpi3mr_drv_cmd *
+mpi3mr_get_drv_cmd(struct mpi3mr_ioc *mrioc, u16 host_tag,
+	Mpi3DefaultReply_t *def_reply)
+{
+	switch (host_tag) {
+	case MPI3MR_HOSTTAG_INITCMDS:
+		return &mrioc->init_cmds;
+	case MPI3MR_HOSTTAG_INVALID:
+		if (def_reply && def_reply->Function ==
+		    MPI3_FUNCTION_EVENT_NOTIFICATION)
+			mpi3mr_handle_events(mrioc, def_reply);
+		return NULL;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+static void mpi3mr_process_admin_reply_desc(struct mpi3mr_ioc *mrioc,
+	Mpi3DefaultReplyDescriptor_t *reply_desc, u64 *reply_dma)
+{
+	u16 reply_desc_type, host_tag = 0;
+	u16 ioc_status = MPI3_IOCSTATUS_SUCCESS;
+	u32 ioc_loginfo = 0;
+	Mpi3StatusReplyDescriptor_t *status_desc;
+	Mpi3AddressReplyDescriptor_t *addr_desc;
+	Mpi3SuccessReplyDescriptor_t *success_desc;
+	Mpi3DefaultReply_t *def_reply = NULL;
+	struct mpi3mr_drv_cmd *cmdptr = NULL;
+	Mpi3SCSIIOReply_t *scsi_reply;
+	u8 *sense_buf = NULL;
+
+	*reply_dma = 0;
+	reply_desc_type = le16_to_cpu(reply_desc->ReplyFlags) &
+	    MPI3_REPLY_DESCRIPT_FLAGS_TYPE_MASK;
+	switch (reply_desc_type) {
+	case MPI3_REPLY_DESCRIPT_FLAGS_TYPE_STATUS:
+		status_desc = (Mpi3StatusReplyDescriptor_t *)reply_desc;
+		host_tag = le16_to_cpu(status_desc->HostTag);
+		ioc_status = le16_to_cpu(status_desc->IOCStatus);
+		if (ioc_status &
+		    MPI3_REPLY_DESCRIPT_STATUS_IOCSTATUS_LOGINFOAVAIL)
+			ioc_loginfo = le32_to_cpu(status_desc->IOCLogInfo);
+		ioc_status &= MPI3_REPLY_DESCRIPT_STATUS_IOCSTATUS_STATUS_MASK;
+		break;
+	case MPI3_REPLY_DESCRIPT_FLAGS_TYPE_ADDRESS_REPLY:
+		addr_desc = (Mpi3AddressReplyDescriptor_t *)reply_desc;
+		*reply_dma = le64_to_cpu(addr_desc->ReplyFrameAddress);
+		def_reply = mpi3mr_get_reply_virt_addr(mrioc, *reply_dma);
+		if (!def_reply)
+			goto out;
+		host_tag = le16_to_cpu(def_reply->HostTag);
+		ioc_status = le16_to_cpu(def_reply->IOCStatus);
+		if (ioc_status &
+		    MPI3_REPLY_DESCRIPT_STATUS_IOCSTATUS_LOGINFOAVAIL)
+			ioc_loginfo = le32_to_cpu(def_reply->IOCLogInfo);
+		ioc_status &= MPI3_REPLY_DESCRIPT_STATUS_IOCSTATUS_STATUS_MASK;
+		if (def_reply->Function == MPI3_FUNCTION_SCSI_IO) {
+			scsi_reply = (Mpi3SCSIIOReply_t *)def_reply;
+			sense_buf = mpi3mr_get_sensebuf_virt_addr(mrioc,
+			    le64_to_cpu(scsi_reply->SenseDataBufferAddress));
+		}
+		break;
+	case MPI3_REPLY_DESCRIPT_FLAGS_TYPE_SUCCESS:
+		success_desc = (Mpi3SuccessReplyDescriptor_t *)reply_desc;
+		host_tag = le16_to_cpu(success_desc->HostTag);
+		break;
+	default:
+		break;
+	}
+
+	cmdptr = mpi3mr_get_drv_cmd(mrioc, host_tag, def_reply);
+	if (cmdptr) {
+		if (cmdptr->state & MPI3MR_CMD_PENDING) {
+			cmdptr->state |= MPI3MR_CMD_COMPLETE;
+			cmdptr->ioc_loginfo = ioc_loginfo;
+			cmdptr->ioc_status = ioc_status;
+			cmdptr->state &= ~MPI3MR_CMD_PENDING;
+			if (def_reply) {
+				cmdptr->state |= MPI3MR_CMD_REPLY_VALID;
+				memcpy((u8 *)cmdptr->reply, (u8 *)def_reply,
+				    mrioc->facts.reply_sz);
+			}
+			if (cmdptr->is_waiting) {
+				complete(&cmdptr->done);
+				cmdptr->is_waiting = 0;
+			} else if (cmdptr->callback)
+				cmdptr->callback(mrioc, cmdptr);
+		}
+	}
+out:
+	if (sense_buf)
+		mpi3mr_repost_sense_buf(mrioc,
+		    le64_to_cpu(scsi_reply->SenseDataBufferAddress));
+}
+
+static int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
+{
+	u32 exp_phase = mrioc->admin_reply_ephase;
+	u32 admin_reply_ci = mrioc->admin_reply_ci;
+	u32 num_admin_replies = 0;
+	u64 reply_dma = 0;
+	Mpi3DefaultReplyDescriptor_t *reply_desc;
+
+	reply_desc = (Mpi3DefaultReplyDescriptor_t *)mrioc->admin_reply_base +
+	    admin_reply_ci;
+
+	if ((le16_to_cpu(reply_desc->ReplyFlags) &
+	    MPI3_REPLY_DESCRIPT_FLAGS_PHASE_MASK) != exp_phase)
+		return 0;
+
+	do {
+		mrioc->admin_req_ci = le16_to_cpu(reply_desc->RequestQueueCI);
+		mpi3mr_process_admin_reply_desc(mrioc, reply_desc, &reply_dma);
+		if (reply_dma)
+			mpi3mr_repost_reply_buf(mrioc, reply_dma);
+		num_admin_replies++;
+		if (++admin_reply_ci == mrioc->num_admin_replies) {
+			admin_reply_ci = 0;
+			exp_phase ^= 1;
+		}
+		reply_desc =
+		    (Mpi3DefaultReplyDescriptor_t *)mrioc->admin_reply_base +
+		    admin_reply_ci;
+		if ((le16_to_cpu(reply_desc->ReplyFlags) &
+		    MPI3_REPLY_DESCRIPT_FLAGS_PHASE_MASK) != exp_phase)
+			break;
+	} while (1);
+
+	writel(admin_reply_ci, &mrioc->sysif_regs->AdminReplyQueueCI);
+	mrioc->admin_reply_ci = admin_reply_ci;
+	mrioc->admin_reply_ephase = exp_phase;
+
+	return num_admin_replies;
+}
+
+static irqreturn_t mpi3mr_isr_primary(int irq, void *privdata)
+{
+	struct mpi3mr_intr_info *intr_info = privdata;
+	struct mpi3mr_ioc *mrioc;
+	u16 midx;
+	u32 num_admin_replies = 0;
+
+	if (!intr_info)
+		return IRQ_NONE;
+
+	mrioc = intr_info->mrioc;
+
+	if (!mrioc->intr_enabled)
+		return IRQ_NONE;
+
+	midx = intr_info->msix_index;
+
+	if (!midx)
+		num_admin_replies = mpi3mr_process_admin_reply_q(mrioc);
+
+	if (num_admin_replies)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
+static irqreturn_t mpi3mr_isr(int irq, void *privdata)
+{
+	struct mpi3mr_intr_info *intr_info = privdata;
+	struct mpi3mr_ioc *mrioc;
+	u16 midx;
+	int ret;
+
+	if (!intr_info)
+		return IRQ_NONE;
+
+	mrioc = intr_info->mrioc;
+	midx = intr_info->msix_index;
+	/* Call primary ISR routine */
+	ret = mpi3mr_isr_primary(irq, privdata);
+
+	return ret;
+}
+
+/**
+ * mpi3mr_isr_poll - Reply queue polling routine
+ * @irq: IRQ
+ * @privdata: Interrupt info
+ *
+ * poll for pending I/O completions in a loop until pending I/Os
+ * present or controller queue depth I/Os are processed.
+ *
+ * Return: IRQ_NONE or IRQ_HANDLED
+ */
+static irqreturn_t mpi3mr_isr_poll(int irq, void *privdata)
+{
+	return IRQ_HANDLED;
+}
+
+/**
+ * mpi3mr_request_irq - Request IRQ and register ISR
+ * @mrioc: Adapter instance reference
+ * @index: IRQ vector index
+ *
+ * Request threaded ISR with primary ISR and secondary
+ *
+ * Return: 0 on success and non zero on failures.
+ */
+static inline int mpi3mr_request_irq(struct mpi3mr_ioc *mrioc, u16 index)
+{
+	struct pci_dev *pdev = mrioc->pdev;
+	struct mpi3mr_intr_info *intr_info = mrioc->intr_info + index;
+	int retval = 0;
+
+	intr_info->mrioc = mrioc;
+	intr_info->msix_index = index;
+	intr_info->op_reply_q = NULL;
+
+	snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
+	    mrioc->driver_name, mrioc->id, index);
+
+	retval = request_threaded_irq(pci_irq_vector(pdev, index), mpi3mr_isr,
+	    mpi3mr_isr_poll, IRQF_SHARED, intr_info->name, intr_info);
+	if (retval) {
+		ioc_err(mrioc, "%s: Unable to allocate interrupt %d!\n",
+		    intr_info->name, pci_irq_vector(pdev, index));
+		return retval;
+	}
+
+	return retval;
+}
+
+/**
+ * mpi3mr_setup_isr - Setup ISR for the controller
+ * @mrioc: Adapter instance reference
+ * @setup_one: Request one IRQ or more
+ *
+ * Allocate IRQ vectors and call mpi3mr_request_irq to setup ISR
+ *
+ * Return: 0 on success and non zero on failures.
+ */
+static int mpi3mr_setup_isr(struct mpi3mr_ioc *mrioc, u8 setup_one)
+{
+	unsigned int irq_flags = PCI_IRQ_MSIX;
+	u16 max_vectors = 0, i;
+	int retval = 0;
+	struct irq_affinity desc = { .pre_vectors =  1};
+
+
+	mpi3mr_cleanup_isr(mrioc);
+
+	if (setup_one || reset_devices)
+		max_vectors = 1;
+	else {
+		max_vectors =
+		    min_t(int, mrioc->cpu_count + 1, mrioc->msix_count);
+
+		ioc_info(mrioc,
+		    "MSI-X vectors supported: %d, no of cores: %d,",
+		    mrioc->msix_count, mrioc->cpu_count);
+		ioc_info(mrioc,
+		    "MSI-x vectors requested: %d\n", max_vectors);
+	}
+
+	irq_flags |= PCI_IRQ_AFFINITY | PCI_IRQ_ALL_TYPES;
+
+	i = pci_alloc_irq_vectors_affinity(mrioc->pdev,
+	    1, max_vectors, irq_flags, &desc);
+	if (i <= 0) {
+		ioc_err(mrioc, "Cannot alloc irq vectors\n");
+		goto out_failed;
+	}
+	if (i != max_vectors) {
+		ioc_info(mrioc,
+		    "allocated vectors (%d) are less than configured (%d)\n",
+		    i, max_vectors);
+
+		max_vectors = i;
+	}
+	mrioc->intr_info = kzalloc(sizeof(struct mpi3mr_intr_info)*max_vectors,
+	    GFP_KERNEL);
+	if (!mrioc->intr_info) {
+		retval = -1;
+		pci_free_irq_vectors(mrioc->pdev);
+		goto out_failed;
+	}
+	for (i = 0; i < max_vectors; i++) {
+		retval = mpi3mr_request_irq(mrioc, i);
+		if (retval) {
+			mrioc->intr_info_count = i;
+			goto out_failed;
+		}
+	}
+	mrioc->intr_info_count = max_vectors;
+	mpi3mr_ioc_enable_intr(mrioc);
+	return retval;
+out_failed:
+	mpi3mr_cleanup_isr(mrioc);
+
+	return retval;
+}
+
+static const struct {
+	enum mpi3mr_iocstate value;
+	char *name;
+} mrioc_states[] = {
+	{ MRIOC_STATE_READY, "ready" },
+	{ MRIOC_STATE_FAULT, "fault" },
+	{ MRIOC_STATE_RESET, "reset" },
+	{ MRIOC_STATE_BECOMING_READY, "becoming ready" },
+	{ MRIOC_STATE_RESET_REQUESTED, "reset requested" },
+	{ MRIOC_STATE_UNRECOVERABLE, "unrecoverable error" },
+};
+
+static const char *mpi3mr_iocstate_name(enum mpi3mr_iocstate mrioc_state)
+{
+	int i;
+	char *name = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(mrioc_states); i++) {
+		if (mrioc_states[i].value == mrioc_state) {
+			name = mrioc_states[i].name;
+			break;
+		}
+	}
+	return name;
+}
+
+
+/**
+ * mpi3mr_print_fault_info - Display fault information
+ * @mrioc: Adapter instance reference
+ *
+ * Display the controller fault information if there is a
+ * controller fault.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_print_fault_info(struct mpi3mr_ioc *mrioc)
+{
+	u32 ioc_status, code, code1, code2, code3;
+
+	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+
+	if (ioc_status & MPI3_SYSIF_IOC_STATUS_FAULT) {
+		code = readl(&mrioc->sysif_regs->Fault);
+		code1 = readl(&mrioc->sysif_regs->FaultInfo[0]);
+		code2 = readl(&mrioc->sysif_regs->FaultInfo[1]);
+		code3 = readl(&mrioc->sysif_regs->FaultInfo[2]);
+
+		ioc_info(mrioc,
+		    "fault code(0x%08X): Additional code: (0x%08X:0x%08X:0x%08X)\n",
+		    code, code1, code2, code3);
+	}
+}
+
+/**
+ * mpi3mr_get_iocstate - Get IOC State
+ * @mrioc: Adapter instance reference
+ *
+ * Return a proper IOC state enum based on the IOC status and
+ * IOC configuration and unrcoverable state of the controller.
+ *
+ * Return: Current IOC state.
+ */
+enum mpi3mr_iocstate mpi3mr_get_iocstate(struct mpi3mr_ioc *mrioc)
+{
+	u32 ioc_status, ioc_config;
+	u8 ready, enabled;
+
+	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+
+	if (mrioc->unrecoverable)
+		return MRIOC_STATE_UNRECOVERABLE;
+	if (ioc_status & MPI3_SYSIF_IOC_STATUS_FAULT)
+		return MRIOC_STATE_FAULT;
+
+	ready = (ioc_status & MPI3_SYSIF_IOC_STATUS_READY);
+	enabled = (ioc_config & MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC);
+
+	if (ready && enabled)
+		return MRIOC_STATE_READY;
+	if ((!ready) && (!enabled))
+		return MRIOC_STATE_RESET;
+	if ((!ready) && (enabled))
+		return MRIOC_STATE_BECOMING_READY;
+
+	return MRIOC_STATE_RESET_REQUESTED;
+}
+
+/**
+ * mpi3mr_clear_reset_history - Clear reset history
+ * @mrioc: Adapter instance reference
+ *
+ * Write the reset history bit in IOC Status to clear the bit,
+ * if it is already set.
+ *
+ * Return: Nothing.
+ */
+static inline void mpi3mr_clear_reset_history(struct mpi3mr_ioc *mrioc)
+{
+	u32 ioc_status;
+
+	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+	if (ioc_status & MPI3_SYSIF_IOC_STATUS_RESET_HISTORY)
+		writel(ioc_status, &mrioc->sysif_regs->IOCStatus);
+
+}
+
+/**
+ * mpi3mr_issue_and_process_mur - Message Unit Reset handler
+ * @mrioc: Adapter instance reference
+ * @reset_reason: Reset reason code
+ *
+ * Issue Message Unit Reset to the controller and wait for it to
+ * be complete.
+ *
+ * Return: 0 on success, -1 on failure.
+ */
+static int mpi3mr_issue_and_process_mur(struct mpi3mr_ioc *mrioc,
+					u32 reset_reason)
+{
+	u32 ioc_config, timeout, ioc_status;
+	int retval = -1;
+
+	ioc_info(mrioc, "Issuing Message Unit Reset(MUR)\n");
+	if (mrioc->unrecoverable) {
+		ioc_info(mrioc, "IOC is unrecoverable MUR not issued\n");
+		return retval;
+	}
+	mpi3mr_clear_reset_history(mrioc);
+	writel(reset_reason, &mrioc->sysif_regs->Scratchpad[0]);
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+	ioc_config &= ~MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC;
+	writel(ioc_config, &mrioc->sysif_regs->IOCConfiguration);
+
+	timeout = mrioc->ready_timeout * 10;
+	do {
+		ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+		if ((ioc_status & MPI3_SYSIF_IOC_STATUS_RESET_HISTORY)) {
+			mpi3mr_clear_reset_history(mrioc);
+			ioc_config =
+			    readl(&mrioc->sysif_regs->IOCConfiguration);
+			if (!((ioc_status & MPI3_SYSIF_IOC_STATUS_READY) ||
+			    (ioc_status & MPI3_SYSIF_IOC_STATUS_FAULT) ||
+			    (ioc_config & MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC))) {
+				retval = 0;
+				break;
+			}
+		}
+		msleep(100);
+	} while (--timeout);
+
+	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+
+	ioc_info(mrioc, "Base IOC Sts/Config after %s MUR is (0x%x)/(0x%x)\n",
+	    (!retval) ? "successful" : "failed", ioc_status, ioc_config);
+	return retval;
+}
+
+/**
+ * mpi3mr_bring_ioc_ready - Bring controller to ready state
+ * @mrioc: Adapter instance reference
+ *
+ * Set Enable IOC bit in IOC configuration register and wait for
+ * the controller to become ready.
+ *
+ * Return: 0 on success, -1 on failure.
+ */
+static int mpi3mr_bring_ioc_ready(struct mpi3mr_ioc *mrioc)
+{
+	u32 ioc_config, timeout;
+	enum mpi3mr_iocstate current_state;
+
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+	ioc_config |= MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC;
+	writel(ioc_config, &mrioc->sysif_regs->IOCConfiguration);
+
+	timeout = mrioc->ready_timeout * 10;
+	do {
+		current_state = mpi3mr_get_iocstate(mrioc);
+		if (current_state == MRIOC_STATE_READY)
+			return 0;
+		msleep(100);
+	} while (--timeout);
+
+	return -1;
+}
+
+/**
+ * mpi3mr_set_diagsave - Set diag save bit for snapdump
+ * @mrioc: Adapter reference
+ *
+ * Set diag save bit in IOC configuration register to enable
+ * snapdump.
+ *
+ * Return: Nothing.
+ */
+static inline void mpi3mr_set_diagsave(struct mpi3mr_ioc *mrioc)
+{
+	u32 ioc_config;
+
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+	ioc_config |= MPI3_SYSIF_IOC_CONFIG_DIAG_SAVE;
+	writel(ioc_config, &mrioc->sysif_regs->IOCConfiguration);
+}
+
+/**
+ * mpi3mr_issue_reset - Issue reset to the controller
+ * @mrioc: Adapter reference
+ * @reset_type: Reset type
+ * @reset_reason: Reset reason code
+ *
+ * TBD
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+static int mpi3mr_issue_reset(struct mpi3mr_ioc *mrioc, u16 reset_type,
+	u32 reset_reason)
+{
+	return 0;
+}
+
+/**
+ * mpi3mr_admin_request_post - Post request to admin queue
+ * @mrioc: Adapter reference
+ * @admin_req: MPI3 request
+ * @admin_req_sz: Request size
+ * @ignore_reset: Ignore reset in process
+ *
+ * Post the MPI3 request into admin request queue and
+ * inform the controller, if the queue is full return
+ * appropriate error.
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+int mpi3mr_admin_request_post(struct mpi3mr_ioc *mrioc, void *admin_req,
+	u16 admin_req_sz, u8 ignore_reset)
+{
+	u16 areq_pi = 0, areq_ci = 0, max_entries = 0;
+	int retval = 0;
+	unsigned long flags;
+	u8 *areq_entry;
+
+
+	if (mrioc->unrecoverable) {
+		ioc_err(mrioc, "%s : Unrecoverable controller\n", __func__);
+		return -EFAULT;
+	}
+
+	spin_lock_irqsave(&mrioc->admin_req_lock, flags);
+	areq_pi = mrioc->admin_req_pi;
+	areq_ci = mrioc->admin_req_ci;
+	max_entries = mrioc->num_admin_req;
+	if ((areq_ci == (areq_pi + 1)) || ((!areq_ci) &&
+	    (areq_pi == (max_entries - 1)))) {
+		ioc_err(mrioc, "AdminReqQ full condition detected\n");
+		retval = -EAGAIN;
+		goto out;
+	}
+	if (!ignore_reset && mrioc->reset_in_progress) {
+		ioc_err(mrioc, "AdminReqQ submit reset in progress\n");
+		retval = -EAGAIN;
+		goto out;
+	}
+	areq_entry = (u8 *)mrioc->admin_req_base +
+	    (areq_pi * MPI3MR_ADMIN_REQ_FRAME_SZ);
+	memset(areq_entry, 0, MPI3MR_ADMIN_REQ_FRAME_SZ);
+	memcpy(areq_entry, (u8 *)admin_req, admin_req_sz);
+
+	if (++areq_pi == max_entries)
+		areq_pi = 0;
+	mrioc->admin_req_pi = areq_pi;
+
+	writel(mrioc->admin_req_pi, &mrioc->sysif_regs->AdminRequestQueuePI);
+
+out:
+	spin_unlock_irqrestore(&mrioc->admin_req_lock, flags);
+
+	return retval;
+}
+
+
+/**
+ * mpi3mr_setup_admin_qpair - Setup admin queue pair
+ * @mrioc: Adapter instance reference
+ *
+ * Allocate memory for admin queue pair if required and register
+ * the admin queue with the controller.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static int mpi3mr_setup_admin_qpair(struct mpi3mr_ioc *mrioc)
+{
+	int retval = 0;
+	u32 num_admin_entries = 0;
+
+	mrioc->admin_req_q_sz = MPI3MR_ADMIN_REQ_Q_SIZE;
+	mrioc->num_admin_req = mrioc->admin_req_q_sz /
+	    MPI3MR_ADMIN_REQ_FRAME_SZ;
+	mrioc->admin_req_ci = mrioc->admin_req_pi = 0;
+	mrioc->admin_req_base = NULL;
+
+	mrioc->admin_reply_q_sz = MPI3MR_ADMIN_REPLY_Q_SIZE;
+	mrioc->num_admin_replies = mrioc->admin_reply_q_sz /
+	    MPI3MR_ADMIN_REPLY_FRAME_SZ;
+	mrioc->admin_reply_ci = 0;
+	mrioc->admin_reply_ephase = 1;
+	mrioc->admin_reply_base = NULL;
+
+	if (!mrioc->admin_req_base) {
+		mrioc->admin_req_base = dma_alloc_coherent(&mrioc->pdev->dev,
+		    mrioc->admin_req_q_sz, &mrioc->admin_req_dma, GFP_KERNEL);
+
+		if (!mrioc->admin_req_base) {
+			retval = -1;
+			goto out_failed;
+		}
+
+		mrioc->admin_reply_base = dma_alloc_coherent(&mrioc->pdev->dev,
+		    mrioc->admin_reply_q_sz, &mrioc->admin_reply_dma,
+		    GFP_KERNEL);
+
+		if (!mrioc->admin_reply_base) {
+			retval = -1;
+			goto out_failed;
+		}
+
+	}
+
+	num_admin_entries = (mrioc->num_admin_replies << 16) |
+	    (mrioc->num_admin_req);
+	writel(num_admin_entries, &mrioc->sysif_regs->AdminQueueNumEntries);
+	mpi3mr_writeq(mrioc->admin_req_dma,
+	    &mrioc->sysif_regs->AdminRequestQueueAddress);
+	mpi3mr_writeq(mrioc->admin_reply_dma,
+	    &mrioc->sysif_regs->AdminReplyQueueAddress);
+	writel(mrioc->admin_req_pi, &mrioc->sysif_regs->AdminRequestQueuePI);
+	writel(mrioc->admin_reply_ci, &mrioc->sysif_regs->AdminReplyQueueCI);
+	return retval;
+
+out_failed:
+
+	if (mrioc->admin_reply_base) {
+		dma_free_coherent(&mrioc->pdev->dev, mrioc->admin_reply_q_sz,
+		    mrioc->admin_reply_base, mrioc->admin_reply_dma);
+		mrioc->admin_reply_base = NULL;
+	}
+	if (mrioc->admin_req_base) {
+		dma_free_coherent(&mrioc->pdev->dev, mrioc->admin_req_q_sz,
+		    mrioc->admin_req_base, mrioc->admin_req_dma);
+		mrioc->admin_req_base = NULL;
+	}
+	return retval;
+}
+
+/**
+ * mpi3mr_issue_iocfacts - Send IOC Facts
+ * @mrioc: Adapter instance reference
+ *
+ * Issue IOC Facts MPI request through admin queue and wait for
+ * the completion of it or time out.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static int mpi3mr_issue_iocfacts(struct mpi3mr_ioc *mrioc,
+	Mpi3IOCFactsData_t *facts_data)
+{
+	Mpi3IOCFactsRequest_t iocfacts_req;
+	void *data = NULL;
+	dma_addr_t data_dma;
+	u32 data_len = sizeof(*facts_data);
+	int retval = 0;
+	u8 sgl_flags = MPI3MR_SGEFLAGS_SYSTEM_SIMPLE_END_OF_LIST;
+
+	data = dma_alloc_coherent(&mrioc->pdev->dev, data_len, &data_dma,
+	    GFP_KERNEL);
+
+	if (!data) {
+		retval = -1;
+		goto out;
+	}
+
+	memset(&iocfacts_req, 0, sizeof(iocfacts_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "Issue IOCFacts: Init command is in use\n");
+		mutex_unlock(&mrioc->init_cmds.mutex);
+		goto out;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	iocfacts_req.HostTag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	iocfacts_req.Function = MPI3_FUNCTION_IOC_FACTS;
+
+	mpi3mr_add_sg_single(&iocfacts_req.SGL, sgl_flags, data_len,
+	    data_dma);
+
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &iocfacts_req,
+	    sizeof(iocfacts_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "Issue IOCFacts: Admin Post failed\n");
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		ioc_err(mrioc, "Issue IOCFacts: command timed out\n");
+		mpi3mr_set_diagsave(mrioc);
+		mpi3mr_issue_reset(mrioc,
+		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT,
+		    MPI3MR_RESET_FROM_IOCFACTS_TIMEOUT);
+		mrioc->unrecoverable = 1;
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "Issue IOCFacts: Failed IOCStatus(0x%04x) Loginfo(0x%08x)\n",
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+	memcpy(facts_data, (u8 *)data, data_len);
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+
+out:
+	if (data)
+		dma_free_coherent(&mrioc->pdev->dev, data_len, data, data_dma);
+
+	return retval;
+}
+
+/**
+ * mpi3mr_check_reset_dma_mask - Process IOC facts data
+ * @mrioc: Adapter instance reference
+ *
+ * Check whether the new DMA mask requested through IOCFacts by
+ * firmware needs to be set, if so set it .
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+static inline int mpi3mr_check_reset_dma_mask(struct mpi3mr_ioc *mrioc)
+{
+	struct pci_dev *pdev = mrioc->pdev;
+	int r;
+	u64 facts_dma_mask = DMA_BIT_MASK(mrioc->facts.dma_mask);
+
+	if (!mrioc->facts.dma_mask || (mrioc->dma_mask <= facts_dma_mask))
+		return 0;
+
+	ioc_info(mrioc, "Changing DMA mask from 0x%016llx to 0x%016llx\n",
+	    mrioc->dma_mask, facts_dma_mask);
+
+	r = dma_set_mask_and_coherent(&pdev->dev, facts_dma_mask);
+	if (r) {
+		ioc_err(mrioc, "Setting DMA mask to 0x%016llx failed: %d\n",
+		    facts_dma_mask, r);
+		return r;
+	}
+	mrioc->dma_mask = facts_dma_mask;
+	return r;
+}
+/**
+ * mpi3mr_process_factsdata - Process IOC facts data
+ * @mrioc: Adapter instance reference
+ *
+ * Convert IOC facts data into cpu endianness and cache it in
+ * the driver .
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
+	Mpi3IOCFactsData_t *facts_data)
+{
+	u32 ioc_config, req_sz, facts_flags;
+
+	if ((le16_to_cpu(facts_data->IOCFactsDataLength)) !=
+	    (sizeof(*facts_data)/4)) {
+		ioc_warn(mrioc,
+		    "IOCFactsdata length mismatch driver_sz(%ld) firmware_sz(%d)\n",
+		    sizeof(*facts_data),
+		    le16_to_cpu(facts_data->IOCFactsDataLength) * 4);
+	}
+
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+	req_sz = 1 << ((ioc_config & MPI3_SYSIF_IOC_CONFIG_OPER_REQ_ENT_SZ) >>
+	    MPI3_SYSIF_IOC_CONFIG_OPER_REQ_ENT_SZ_SHIFT);
+	if (le16_to_cpu(facts_data->IOCRequestFrameSize) != (req_sz/4)) {
+		ioc_err(mrioc,
+		    "IOCFacts data reqFrameSize mismatch hw_size(%d) firmware_sz(%d)\n",
+		    req_sz/4, le16_to_cpu(facts_data->IOCRequestFrameSize));
+	}
+
+	memset(&mrioc->facts, 0, sizeof(mrioc->facts));
+
+	facts_flags = le32_to_cpu(facts_data->Flags);
+	mrioc->facts.op_req_sz = req_sz;
+	mrioc->op_reply_desc_sz = 1 << ((ioc_config &
+	    MPI3_SYSIF_IOC_CONFIG_OPER_RPY_ENT_SZ) >>
+	    MPI3_SYSIF_IOC_CONFIG_OPER_RPY_ENT_SZ_SHIFT);
+
+	mrioc->facts.ioc_num = facts_data->IOCNumber;
+	mrioc->facts.who_init = facts_data->WhoInit;
+	mrioc->facts.max_msix_vectors = le16_to_cpu(facts_data->MaxMSIxVectors);
+	mrioc->facts.personality = (facts_flags &
+	    MPI3_IOCFACTS_FLAGS_PERSONALITY_MASK);
+	mrioc->facts.dma_mask = (facts_flags &
+	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK) >>
+	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT;
+	mrioc->facts.protocol_flags = facts_data->ProtocolFlags;
+	mrioc->facts.mpi_version = le32_to_cpu(facts_data->MPIVersion.Word);
+	mrioc->facts.max_reqs = le16_to_cpu(facts_data->MaxOutstandingRequest);
+	mrioc->facts.product_id = le16_to_cpu(facts_data->ProductID);
+	mrioc->facts.reply_sz = le16_to_cpu(facts_data->ReplyFrameSize) * 4;
+	mrioc->facts.exceptions = le16_to_cpu(facts_data->IOCExceptions);
+	mrioc->facts.max_perids = le16_to_cpu(facts_data->MaxPersistentID);
+	mrioc->facts.max_pds = le16_to_cpu(facts_data->MaxPDs);
+	mrioc->facts.max_vds = le16_to_cpu(facts_data->MaxVDs);
+	mrioc->facts.max_hpds = le16_to_cpu(facts_data->MaxHostPDs);
+	mrioc->facts.max_advhpds = le16_to_cpu(facts_data->MaxAdvancedHostPDs);
+	mrioc->facts.max_raidpds = le16_to_cpu(facts_data->MaxRAIDPDs);
+	mrioc->facts.max_nvme = le16_to_cpu(facts_data->MaxNVMe);
+	mrioc->facts.max_pcieswitches =
+	    le16_to_cpu(facts_data->MaxPCIeSwitches);
+	mrioc->facts.max_sasexpanders =
+	    le16_to_cpu(facts_data->MaxSASExpanders);
+	mrioc->facts.max_sasinitiators =
+	    le16_to_cpu(facts_data->MaxSASInitiators);
+	mrioc->facts.max_enclosures = le16_to_cpu(facts_data->MaxEnclosures);
+	mrioc->facts.min_devhandle = le16_to_cpu(facts_data->MinDevHandle);
+	mrioc->facts.max_devhandle = le16_to_cpu(facts_data->MaxDevHandle);
+	mrioc->facts.max_op_req_q =
+	    le16_to_cpu(facts_data->MaxOperationalRequestQueues);
+	mrioc->facts.max_op_reply_q =
+	    le16_to_cpu(facts_data->MaxOperationalReplyQueues);
+	mrioc->facts.ioc_capabilities =
+	    le32_to_cpu(facts_data->IOCCapabilities);
+	mrioc->facts.fw_ver.build_num =
+	    le16_to_cpu(facts_data->FWVersion.BuildNum);
+	mrioc->facts.fw_ver.cust_id =
+	    le16_to_cpu(facts_data->FWVersion.CustomerID);
+	mrioc->facts.fw_ver.ph_minor = facts_data->FWVersion.PhaseMinor;
+	mrioc->facts.fw_ver.ph_major = facts_data->FWVersion.PhaseMajor;
+	mrioc->facts.fw_ver.gen_minor = facts_data->FWVersion.GenMinor;
+	mrioc->facts.fw_ver.gen_major = facts_data->FWVersion.GenMajor;
+	mrioc->msix_count = min_t(int, mrioc->msix_count,
+	    mrioc->facts.max_msix_vectors);
+	mrioc->facts.sge_mod_mask = facts_data->SGEModifierMask;
+	mrioc->facts.sge_mod_value = facts_data->SGEModifierValue;
+	mrioc->facts.sge_mod_shift = facts_data->SGEModifierShift;
+	mrioc->facts.shutdown_timeout =
+	    le16_to_cpu(facts_data->ShutdownTimeout);
+
+	ioc_info(mrioc, "ioc_num(%d), maxopQ(%d), maxopRepQ(%d), maxdh(%d),",
+	    mrioc->facts.ioc_num, mrioc->facts.max_op_req_q,
+	    mrioc->facts.max_op_reply_q, mrioc->facts.max_devhandle);
+	ioc_info(mrioc,
+	    "maxreqs(%d), mindh(%d) maxPDs(%d) maxvectors(%d) maxperids(%d)\n",
+	    mrioc->facts.max_reqs, mrioc->facts.min_devhandle,
+	    mrioc->facts.max_pds, mrioc->facts.max_msix_vectors,
+	    mrioc->facts.max_perids);
+	ioc_info(mrioc, "SGEModMask 0x%x SGEModVal 0x%x SGEModShift 0x%x ",
+	    mrioc->facts.sge_mod_mask, mrioc->facts.sge_mod_value,
+	    mrioc->facts.sge_mod_shift);
+	ioc_info(mrioc, "DMA Mask %d InitialPE Status 0x%x\n",
+	    mrioc->facts.dma_mask, (facts_flags &
+	    MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_MASK));
+
+	mrioc->max_host_ios = mrioc->facts.max_reqs - MPI3MR_INTERNAL_CMDS_RESVD;
+
+	if (reset_devices)
+		mrioc->max_host_ios = min_t(int, mrioc->max_host_ios,
+		    MPI3MR_HOST_IOS_KDUMP);
+
+}
+
+/**
+ * mpi3mr_alloc_reply_sense_bufs - Send IOC Init
+ * @mrioc: Adapter instance reference
+ *
+ * Allocate and initialize the reply free buffers, sense
+ * buffers, reply free queue and sense buffer queue.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static int mpi3mr_alloc_reply_sense_bufs(struct mpi3mr_ioc *mrioc)
+{
+	int retval = 0;
+	u32 sz, i;
+	dma_addr_t phy_addr;
+
+	if (mrioc->init_cmds.reply)
+		goto post_reply_sbuf;
+
+	mrioc->init_cmds.reply = kzalloc(mrioc->facts.reply_sz, GFP_KERNEL);
+	if (!mrioc->init_cmds.reply)
+		goto out_failed;
+
+
+	mrioc->num_reply_bufs = mrioc->facts.max_reqs + MPI3MR_NUM_EVT_REPLIES;
+	mrioc->reply_free_qsz = mrioc->num_reply_bufs + 1;
+	mrioc->num_sense_bufs = mrioc->facts.max_reqs / MPI3MR_SENSEBUF_FACTOR;
+	mrioc->sense_buf_q_sz = mrioc->num_sense_bufs + 1;
+
+	/* reply buffer pool, 16 byte align */
+	sz = mrioc->num_reply_bufs * mrioc->facts.reply_sz;
+	mrioc->reply_buf_pool = dma_pool_create("reply_buf pool",
+	    &mrioc->pdev->dev, sz, 16, 0);
+	if (!mrioc->reply_buf_pool) {
+		ioc_err(mrioc, "reply buf pool: dma_pool_create failed\n");
+		goto out_failed;
+	}
+
+	mrioc->reply_buf = dma_pool_zalloc(mrioc->reply_buf_pool, GFP_KERNEL,
+	    &mrioc->reply_buf_dma);
+	if (!mrioc->reply_buf)
+		goto out_failed;
+
+	mrioc->reply_buf_dma_max_address = mrioc->reply_buf_dma + sz;
+
+	/* reply free queue, 8 byte align */
+	sz = mrioc->reply_free_qsz * 8;
+	mrioc->reply_free_q_pool = dma_pool_create("reply_free_q pool",
+	    &mrioc->pdev->dev, sz, 8, 0);
+	if (!mrioc->reply_free_q_pool) {
+		ioc_err(mrioc, "reply_free_q pool: dma_pool_create failed\n");
+		goto out_failed;
+	}
+	mrioc->reply_free_q = dma_pool_zalloc(mrioc->reply_free_q_pool,
+	    GFP_KERNEL, &mrioc->reply_free_q_dma);
+	if (!mrioc->reply_free_q)
+		goto out_failed;
+
+	/* sense buffer pool,  4 byte align */
+	sz = mrioc->num_sense_bufs * MPI3MR_SENSEBUF_SZ;
+	mrioc->sense_buf_pool = dma_pool_create("sense_buf pool",
+	    &mrioc->pdev->dev, sz, 4, 0);
+	if (!mrioc->sense_buf_pool) {
+		ioc_err(mrioc, "sense_buf pool: dma_pool_create failed\n");
+		goto out_failed;
+	}
+	mrioc->sense_buf = dma_pool_zalloc(mrioc->sense_buf_pool, GFP_KERNEL,
+	    &mrioc->sense_buf_dma);
+	if (!mrioc->sense_buf)
+		goto out_failed;
+
+	/* sense buffer queue, 8 byte align */
+	sz = mrioc->sense_buf_q_sz * 8;
+	mrioc->sense_buf_q_pool = dma_pool_create("sense_buf_q pool",
+	    &mrioc->pdev->dev, sz, 8, 0);
+	if (!mrioc->sense_buf_q_pool) {
+		ioc_err(mrioc, "sense_buf_q pool: dma_pool_create failed\n");
+		goto out_failed;
+	}
+	mrioc->sense_buf_q = dma_pool_zalloc(mrioc->sense_buf_q_pool,
+	    GFP_KERNEL, &mrioc->sense_buf_q_dma);
+	if (!mrioc->sense_buf_q)
+		goto out_failed;
+
+post_reply_sbuf:
+	sz = mrioc->num_reply_bufs * mrioc->facts.reply_sz;
+	ioc_info(mrioc,
+	    "reply buf pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB), reply_dma(0x%llx)\n",
+	    mrioc->reply_buf, mrioc->num_reply_bufs, mrioc->facts.reply_sz,
+	    (sz / 1024), (unsigned long long)mrioc->reply_buf_dma);
+	sz = mrioc->reply_free_qsz * 8;
+	ioc_info(mrioc,
+	    "reply_free_q pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB), reply_dma(0x%llx)\n",
+	    mrioc->reply_free_q, mrioc->reply_free_qsz, 8, (sz / 1024),
+	    (unsigned long long)mrioc->reply_free_q_dma);
+	sz = mrioc->num_sense_bufs * MPI3MR_SENSEBUF_SZ;
+	ioc_info(mrioc,
+	    "sense_buf pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB), sense_dma(0x%llx)\n",
+	    mrioc->sense_buf, mrioc->num_sense_bufs, MPI3MR_SENSEBUF_SZ,
+	    (sz / 1024), (unsigned long long)mrioc->sense_buf_dma);
+	sz = mrioc->sense_buf_q_sz * 8;
+	ioc_info(mrioc,
+	    "sense_buf_q pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB), sense_dma(0x%llx)\n",
+	    mrioc->sense_buf_q, mrioc->sense_buf_q_sz, 8, (sz / 1024),
+	    (unsigned long long)mrioc->sense_buf_q_dma);
+
+	/* initialize Reply buffer Queue */
+	for (i = 0, phy_addr = mrioc->reply_buf_dma;
+	    i < mrioc->num_reply_bufs; i++, phy_addr += mrioc->facts.reply_sz)
+		mrioc->reply_free_q[i] = cpu_to_le64(phy_addr);
+	mrioc->reply_free_q[i] = cpu_to_le64(0);
+
+	/* initialize Sense Buffer Queue */
+	for (i = 0, phy_addr = mrioc->sense_buf_dma;
+	    i < mrioc->num_sense_bufs; i++, phy_addr += MPI3MR_SENSEBUF_SZ)
+		mrioc->sense_buf_q[i] = cpu_to_le64(phy_addr);
+	mrioc->sense_buf_q[i] = cpu_to_le64(0);
+	return retval;
+
+out_failed:
+	retval = -1;
+	return retval;
+}
+
+/**
+ * mpi3mr_issue_iocinit - Send IOC Init
+ * @mrioc: Adapter instance reference
+ *
+ * Issue IOC Init MPI request through admin queue and wait for
+ * the completion of it or time out.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static int mpi3mr_issue_iocinit(struct mpi3mr_ioc *mrioc)
+{
+	Mpi3IOCInitRequest_t iocinit_req;
+	Mpi3DriverInfoLayout_t *drv_info;
+	dma_addr_t data_dma;
+	u32 data_len = sizeof(*drv_info);
+	int retval = 0;
+	ktime_t current_time;
+
+	drv_info = dma_alloc_coherent(&mrioc->pdev->dev, data_len, &data_dma,
+	    GFP_KERNEL);
+	if (!drv_info) {
+		retval = -1;
+		goto out;
+	}
+	drv_info->InformationLength = cpu_to_le32(data_len);
+	strcpy(drv_info->DriverSignature, "Broadcom");
+	strcpy(drv_info->OsName, utsname()->sysname);
+	drv_info->OsName[sizeof(drv_info->OsName)-1] = 0;
+	strcpy(drv_info->OsVersion, utsname()->release);
+	drv_info->OsVersion[sizeof(drv_info->OsVersion)-1] = 0;
+	strcpy(drv_info->DriverName, MPI3MR_DRIVER_NAME);
+	strcpy(drv_info->DriverVersion, MPI3MR_DRIVER_VERSION);
+	strcpy(drv_info->DriverReleaseDate, MPI3MR_DRIVER_RELDATE);
+	drv_info->DriverCapabilities = 0;
+	memcpy((u8 *)&mrioc->driver_info, (u8 *)drv_info,
+	    sizeof(mrioc->driver_info));
+
+	memset(&iocinit_req, 0, sizeof(iocinit_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "Issue IOCInit: Init command is in use\n");
+		mutex_unlock(&mrioc->init_cmds.mutex);
+		goto out;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	iocinit_req.HostTag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	iocinit_req.Function = MPI3_FUNCTION_IOC_INIT;
+	iocinit_req.MPIVersion.Struct.Dev = MPI3_VERSION_DEV;
+	iocinit_req.MPIVersion.Struct.Unit = MPI3_VERSION_UNIT;
+	iocinit_req.MPIVersion.Struct.Major = MPI3_VERSION_MAJOR;
+	iocinit_req.MPIVersion.Struct.Minor = MPI3_VERSION_MINOR;
+	iocinit_req.WhoInit = MPI3_WHOINIT_HOST_DRIVER;
+	iocinit_req.ReplyFreeQueueDepth = cpu_to_le16(mrioc->reply_free_qsz);
+	iocinit_req.ReplyFreeQueueAddress =
+	    cpu_to_le64(mrioc->reply_free_q_dma);
+	iocinit_req.SenseBufferLength = cpu_to_le16(MPI3MR_SENSEBUF_SZ);
+	iocinit_req.SenseBufferFreeQueueDepth =
+	    cpu_to_le16(mrioc->sense_buf_q_sz);
+	iocinit_req.SenseBufferFreeQueueAddress =
+	    cpu_to_le64(mrioc->sense_buf_q_dma);
+	iocinit_req.DriverInformationAddress = cpu_to_le64(data_dma);
+
+	current_time = ktime_get_real();
+	iocinit_req.TimeStamp = cpu_to_le64(ktime_to_ms(current_time));
+
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &iocinit_req,
+	    sizeof(iocinit_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "Issue IOCInit: Admin Post failed\n");
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		mpi3mr_set_diagsave(mrioc);
+		mpi3mr_issue_reset(mrioc,
+		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT,
+		    MPI3MR_RESET_FROM_IOCINIT_TIMEOUT);
+		mrioc->unrecoverable = 1;
+		ioc_err(mrioc, "Issue IOCInit: command timed out\n");
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "Issue IOCInit: Failed IOCStatus(0x%04x) Loginfo(0x%08x)\n",
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+
+out:
+	if (drv_info)
+		dma_free_coherent(&mrioc->pdev->dev, data_len, drv_info,
+		    data_dma);
+
+	return retval;
+}
+
+
+/**
+ * mpi3mr_alloc_chain_bufs - Allocate chain buffers
+ * @mrioc: Adapter instance reference
+ *
+ * Allocate chain buffers and set a bitmap to indicate free
+ * chain buffers. Chain buffers are used to pass the SGE
+ * information along with MPI3 SCSI IO requests for host I/O.
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+static int mpi3mr_alloc_chain_bufs(struct mpi3mr_ioc *mrioc)
+{
+	int retval = 0;
+	u32 sz, i;
+	u16 num_chains;
+
+	num_chains = mrioc->max_host_ios/MPI3MR_CHAINBUF_FACTOR;
+
+	mrioc->chain_buf_count = num_chains;
+	sz = sizeof(struct chain_element) * num_chains;
+	mrioc->chain_sgl_list = kzalloc(sz, GFP_KERNEL);
+	if (!mrioc->chain_sgl_list)
+		goto out_failed;
+
+	sz = MPI3MR_PAGE_SIZE_4K;
+	mrioc->chain_buf_pool = dma_pool_create("chain_buf pool",
+	    &mrioc->pdev->dev, sz, 16, 0);
+	if (!mrioc->chain_buf_pool) {
+		ioc_err(mrioc, "chain buf pool: dma_pool_create failed\n");
+		goto out_failed;
+	}
+
+	for (i = 0; i < num_chains; i++) {
+		mrioc->chain_sgl_list[i].addr =
+		    dma_pool_zalloc(mrioc->chain_buf_pool, GFP_KERNEL,
+		    &mrioc->chain_sgl_list[i].dma_addr);
+
+		if (!mrioc->chain_sgl_list[i].addr)
+			goto out_failed;
+	}
+	mrioc->chain_bitmap_sz = num_chains / 8;
+	if (num_chains % 8)
+		mrioc->chain_bitmap_sz++;
+	mrioc->chain_bitmap = kzalloc(mrioc->chain_bitmap_sz, GFP_KERNEL);
+	if (!mrioc->chain_bitmap)
+		goto out_failed;
+	return retval;
+out_failed:
+	retval = -1;
+	return retval;
+}
+
+
+/**
+ * mpi3mr_cleanup_resources - Free PCI resources
+ * @mrioc: Adapter instance reference
+ *
+ * Unmap PCI device memory and disable PCI device.
+ *
+ * Return: 0 on success and non-zero on failure.
+ */
+void mpi3mr_cleanup_resources(struct mpi3mr_ioc *mrioc)
+{
+	struct pci_dev *pdev = mrioc->pdev;
+
+	mpi3mr_cleanup_isr(mrioc);
+
+	if (mrioc->sysif_regs) {
+		iounmap(mrioc->sysif_regs);
+		mrioc->sysif_regs = NULL;
+	}
+
+	if (pci_is_enabled(pdev)) {
+		if (mrioc->bars)
+			pci_release_selected_regions(pdev, mrioc->bars);
+		pci_disable_device(pdev);
+	}
+}
+
+/**
+ * mpi3mr_setup_resources - Enable PCI resources
+ * @mrioc: Adapter instance reference
+ *
+ * Enable PCI device memory, MSI-x registers and set DMA mask.
+ *
+ * Return: 0 on success and non-zero on failure.
+ */
+int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc)
+{
+	struct pci_dev *pdev = mrioc->pdev;
+	u32 memap_sz = 0;
+	int i, retval = 0, capb = 0;
+	u16 message_control;
+	u64 dma_mask = mrioc->dma_mask ? mrioc->dma_mask :
+	    (((dma_get_required_mask(&pdev->dev) > DMA_BIT_MASK(32)) &&
+	    (sizeof(dma_addr_t) > 4)) ? DMA_BIT_MASK(64):DMA_BIT_MASK(32));
+
+	if (pci_enable_device_mem(pdev)) {
+		ioc_err(mrioc, "pci_enable_device_mem: failed\n");
+		retval = -ENODEV;
+		goto out_failed;
+	}
+
+	capb = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
+	if (!capb) {
+		ioc_err(mrioc, "Unable to find MSI-X Capabilities\n");
+		retval = -ENODEV;
+		goto out_failed;
+	}
+	mrioc->bars = pci_select_bars(pdev, IORESOURCE_MEM);
+
+	if (pci_request_selected_regions(pdev, mrioc->bars,
+	    mrioc->driver_name)) {
+		ioc_err(mrioc, "pci_request_selected_regions: failed\n");
+		retval = -ENODEV;
+		goto out_failed;
+	}
+
+	for (i = 0; (i < DEVICE_COUNT_RESOURCE); i++) {
+		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM) {
+			mrioc->sysif_regs_phys = pci_resource_start(pdev, i);
+			memap_sz = pci_resource_len(pdev, i);
+			mrioc->sysif_regs =
+			    ioremap(mrioc->sysif_regs_phys, memap_sz);
+			break;
+		}
+	}
+
+	pci_set_master(pdev);
+
+	retval = dma_set_mask_and_coherent(&pdev->dev, dma_mask);
+	if (retval) {
+		if (dma_mask != DMA_BIT_MASK(32)) {
+			ioc_warn(mrioc, "Setting 64 bit DMA mask failed\n");
+			dma_mask = DMA_BIT_MASK(32);
+			retval = dma_set_mask_and_coherent(&pdev->dev,
+			    dma_mask);
+		}
+		if (retval) {
+			mrioc->dma_mask = 0;
+			ioc_err(mrioc, "Setting 32 bit DMA mask also failed\n");
+			goto out_failed;
+		}
+	}
+	mrioc->dma_mask = dma_mask;
+
+	if (mrioc->sysif_regs == NULL) {
+		ioc_err(mrioc,
+		    "Unable to map adapter memory or resource not found\n");
+		retval = -EINVAL;
+		goto out_failed;
+	}
+
+	pci_read_config_word(pdev, capb + 2, &message_control);
+	mrioc->msix_count = (message_control & 0x3FF) + 1;
+
+	pci_save_state(pdev);
+
+	pci_set_drvdata(pdev, mrioc->shost);
+
+	mpi3mr_ioc_disable_intr(mrioc);
+
+	ioc_info(mrioc, "iomem(0x%016llx), mapped(0x%p), size(%d)\n",
+	    (unsigned long long)mrioc->sysif_regs_phys,
+	    mrioc->sysif_regs, memap_sz);
+	ioc_info(mrioc, "Number of MSI-X vectors found in capabilities: (%d)\n",
+	    mrioc->msix_count);
+	return retval;
+
+out_failed:
+	mpi3mr_cleanup_resources(mrioc);
+	return retval;
+}
+
+/**
+ * mpi3mr_init_ioc - Initialize the controller
+ * @mrioc: Adapter instance reference
+ *
+ * This the controller initialization routine, executed either
+ * after soft reset or from pci probe callback.
+ * Setup the required resources, memory map the controller
+ * registers, create admin and operational reply queue pairs,
+ * allocate required memory for reply pool, sense buffer pool,
+ * issue IOC init request to the firmware, unmask the events and
+ * issue port enable to discover SAS/SATA/NVMe devies and RAID
+ * volumes.
+ *
+ * Return: 0 on success and non-zero on failure.
+ */
+int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
+{
+	int retval = 0;
+	enum mpi3mr_iocstate ioc_state;
+	u64 base_info;
+	u32 timeout;
+	u32 ioc_status, ioc_config;
+	Mpi3IOCFactsData_t facts_data;
+
+	mrioc->change_count = 0;
+	mrioc->cpu_count = num_online_cpus();
+	retval = mpi3mr_setup_resources(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Failed to setup resources:error %d\n",
+		    retval);
+		goto out_nocleanup;
+	}
+	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+
+	ioc_info(mrioc, "SOD status %x configuration %x\n",
+	    ioc_status, ioc_config);
+
+	base_info = readq(&mrioc->sysif_regs->IOCInformation);
+	ioc_info(mrioc, "SOD base_info %llx\n",	base_info);
+
+	/*The timeout value is in 2sec unit, changing it to seconds*/
+	mrioc->ready_timeout =
+	    ((base_info & MPI3_SYSIF_IOC_INFO_LOW_TIMEOUT_MASK) >>
+	    MPI3_SYSIF_IOC_INFO_LOW_TIMEOUT_SHIFT) * 2;
+
+	ioc_info(mrioc, "IOC ready timeout %d\n", mrioc->ready_timeout);
+
+	ioc_state = mpi3mr_get_iocstate(mrioc);
+	ioc_info(mrioc, "IOC in %s state during detection\n",
+	    mpi3mr_iocstate_name(ioc_state));
+
+	if (ioc_state == MRIOC_STATE_BECOMING_READY ||
+			ioc_state == MRIOC_STATE_RESET_REQUESTED) {
+		timeout = mrioc->ready_timeout * 10;
+		do {
+			msleep(100);
+		} while (--timeout);
+
+		ioc_state = mpi3mr_get_iocstate(mrioc);
+		ioc_info(mrioc,
+			"IOC in %s state after waiting for reset time\n",
+			mpi3mr_iocstate_name(ioc_state));
+	}
+
+	if (ioc_state == MRIOC_STATE_READY) {
+		retval = mpi3mr_issue_and_process_mur(mrioc,
+		    MPI3MR_RESET_FROM_BRINGUP);
+		if (retval) {
+			ioc_err(mrioc, "Failed to MU reset IOC error %d\n",
+			    retval);
+		}
+		ioc_state = mpi3mr_get_iocstate(mrioc);
+	}
+	if (ioc_state != MRIOC_STATE_RESET) {
+		mpi3mr_print_fault_info(mrioc);
+		retval = mpi3mr_issue_reset(mrioc,
+		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET,
+		    MPI3MR_RESET_FROM_BRINGUP);
+		if (retval) {
+			ioc_err(mrioc,
+			    "%s :Failed to soft reset IOC error %d\n",
+			    __func__, retval);
+			goto out_failed;
+		}
+	}
+	ioc_state = mpi3mr_get_iocstate(mrioc);
+	if (ioc_state != MRIOC_STATE_RESET) {
+		ioc_err(mrioc, "Cannot bring IOC to reset state\n");
+		goto out_failed;
+	}
+
+	retval = mpi3mr_setup_admin_qpair(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Failed to setup admin Qs: error %d\n",
+		    retval);
+		goto out_failed;
+	}
+
+	retval = mpi3mr_bring_ioc_ready(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Failed to bring ioc ready: error %d\n",
+		    retval);
+		goto out_failed;
+	}
+
+	retval = mpi3mr_setup_isr(mrioc, 1);
+	if (retval) {
+		ioc_err(mrioc, "Failed to setup ISR error %d\n",
+		    retval);
+		goto out_failed;
+	}
+
+	retval = mpi3mr_issue_iocfacts(mrioc, &facts_data);
+	if (retval) {
+		ioc_err(mrioc, "Failed to Issue IOC Facts %d\n",
+		    retval);
+		goto out_failed;
+	}
+
+	mpi3mr_process_factsdata(mrioc, &facts_data);
+	retval = mpi3mr_check_reset_dma_mask(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Resetting dma mask failed %d\n",
+		    retval);
+		goto out_failed;
+	}
+
+	retval = mpi3mr_alloc_reply_sense_bufs(mrioc);
+	if (retval) {
+		ioc_err(mrioc,
+		    "%s :Failed to allocated reply sense buffers %d\n",
+		    __func__, retval);
+		goto out_failed;
+	}
+
+	retval = mpi3mr_alloc_chain_bufs(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Failed to allocated chain buffers %d\n",
+		    retval);
+		goto out_failed;
+	}
+
+	retval = mpi3mr_issue_iocinit(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Failed to Issue IOC Init %d\n",
+		    retval);
+		goto out_failed;
+	}
+	mrioc->reply_free_queue_host_index = mrioc->num_reply_bufs;
+	writel(mrioc->reply_free_queue_host_index,
+	    &mrioc->sysif_regs->ReplyFreeHostIndex);
+
+	mrioc->sbq_host_index = mrioc->num_sense_bufs;
+	writel(mrioc->sbq_host_index,
+	    &mrioc->sysif_regs->SenseBufferFreeHostIndex);
+
+	retval = mpi3mr_setup_isr(mrioc, 0);
+	if (retval) {
+		ioc_err(mrioc, "Failed to re-setup ISR, error %d\n",
+		    retval);
+		goto out_failed;
+	}
+
+	return retval;
+
+out_failed:
+	mpi3mr_cleanup_ioc(mrioc);
+out_nocleanup:
+	return retval;
+}
+
+
+/**
+ * mpi3mr_free_mem - Free memory allocated for a controller
+ * @mrioc: Adapter instance reference
+ *
+ * Free all the memory allocated for a controller.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
+{
+	u16 i;
+	struct mpi3mr_intr_info *intr_info;
+
+	if (mrioc->sense_buf_pool) {
+		if (mrioc->sense_buf)
+			dma_pool_free(mrioc->sense_buf_pool, mrioc->sense_buf,
+			    mrioc->sense_buf_dma);
+		dma_pool_destroy(mrioc->sense_buf_pool);
+		mrioc->sense_buf = NULL;
+		mrioc->sense_buf_pool = NULL;
+	}
+	if (mrioc->sense_buf_q_pool) {
+		if (mrioc->sense_buf_q)
+			dma_pool_free(mrioc->sense_buf_q_pool,
+			    mrioc->sense_buf_q, mrioc->sense_buf_q_dma);
+		dma_pool_destroy(mrioc->sense_buf_q_pool);
+		mrioc->sense_buf_q = NULL;
+		mrioc->sense_buf_q_pool = NULL;
+	}
+
+	if (mrioc->reply_buf_pool) {
+		if (mrioc->reply_buf)
+			dma_pool_free(mrioc->reply_buf_pool, mrioc->reply_buf,
+			    mrioc->reply_buf_dma);
+		dma_pool_destroy(mrioc->reply_buf_pool);
+		mrioc->reply_buf = NULL;
+		mrioc->reply_buf_pool = NULL;
+	}
+	if (mrioc->reply_free_q_pool) {
+		if (mrioc->reply_free_q)
+			dma_pool_free(mrioc->reply_free_q_pool,
+			    mrioc->reply_free_q, mrioc->reply_free_q_dma);
+		dma_pool_destroy(mrioc->reply_free_q_pool);
+		mrioc->reply_free_q = NULL;
+		mrioc->reply_free_q_pool = NULL;
+	}
+
+	for (i = 0; i < mrioc->intr_info_count; i++) {
+		intr_info = mrioc->intr_info + i;
+		if (intr_info)
+			intr_info->op_reply_q = NULL;
+	}
+
+	kfree(mrioc->req_qinfo);
+	mrioc->req_qinfo = NULL;
+	mrioc->num_op_req_q = 0;
+
+	kfree(mrioc->op_reply_qinfo);
+	mrioc->op_reply_qinfo = NULL;
+	mrioc->num_op_reply_q = 0;
+
+	kfree(mrioc->init_cmds.reply);
+	mrioc->init_cmds.reply = NULL;
+
+	kfree(mrioc->chain_bitmap);
+	mrioc->chain_bitmap = NULL;
+
+	if (mrioc->chain_buf_pool) {
+		for (i = 0; i < mrioc->chain_buf_count; i++) {
+			if (mrioc->chain_sgl_list[i].addr) {
+				dma_pool_free(mrioc->chain_buf_pool,
+				    mrioc->chain_sgl_list[i].addr,
+				    mrioc->chain_sgl_list[i].dma_addr);
+				mrioc->chain_sgl_list[i].addr = NULL;
+			}
+		}
+		dma_pool_destroy(mrioc->chain_buf_pool);
+		mrioc->chain_buf_pool = NULL;
+	}
+
+	kfree(mrioc->chain_sgl_list);
+	mrioc->chain_sgl_list = NULL;
+
+	if (mrioc->admin_reply_base) {
+		dma_free_coherent(&mrioc->pdev->dev, mrioc->admin_reply_q_sz,
+		    mrioc->admin_reply_base, mrioc->admin_reply_dma);
+		mrioc->admin_reply_base = NULL;
+	}
+	if (mrioc->admin_req_base) {
+		dma_free_coherent(&mrioc->pdev->dev, mrioc->admin_req_q_sz,
+		    mrioc->admin_req_base, mrioc->admin_req_dma);
+		mrioc->admin_req_base = NULL;
+	}
+
+}
+
+/**
+ * mpi3mr_issue_ioc_shutdown - Shutdown controller
+ * @mrioc: Adapter instance reference
+ *
+ * Send shutodwn notification to the controller and wait for the
+ * shutdown_timeout for it to be completed.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_issue_ioc_shutdown(struct mpi3mr_ioc *mrioc)
+{
+	u32 ioc_config, ioc_status;
+	u8 retval = 1;
+	u32 timeout = MPI3MR_DEFAULT_SHUTDOWN_TIME * 10;
+
+	ioc_info(mrioc, "Issuing Shutdown Notification\n");
+	if (mrioc->unrecoverable) {
+		ioc_warn(mrioc,
+		    "IOC is unrecoverable Shutdown is not issued\n");
+		return;
+	}
+	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+	if ((ioc_status & MPI3_SYSIF_IOC_STATUS_SHUTDOWN_MASK)
+	    == MPI3_SYSIF_IOC_STATUS_SHUTDOWN_IN_PROGRESS) {
+		ioc_info(mrioc, "Shutdown already in progress\n");
+		return;
+	}
+
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+	ioc_config |= MPI3_SYSIF_IOC_CONFIG_SHUTDOWN_NORMAL;
+	ioc_config |= MPI3_SYSIF_IOC_CONFIG_DEVICE_SHUTDOWN;
+
+	writel(ioc_config, &mrioc->sysif_regs->IOCConfiguration);
+
+	if (mrioc->facts.shutdown_timeout)
+		timeout = mrioc->facts.shutdown_timeout * 10;
+
+	do {
+		ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+		if ((ioc_status & MPI3_SYSIF_IOC_STATUS_SHUTDOWN_MASK)
+		    == MPI3_SYSIF_IOC_STATUS_SHUTDOWN_COMPLETE) {
+			retval = 0;
+			break;
+		}
+		msleep(100);
+	} while (--timeout);
+
+
+	ioc_status = readl(&mrioc->sysif_regs->IOCStatus);
+	ioc_config = readl(&mrioc->sysif_regs->IOCConfiguration);
+
+	if (retval) {
+		if ((ioc_status & MPI3_SYSIF_IOC_STATUS_SHUTDOWN_MASK)
+		    == MPI3_SYSIF_IOC_STATUS_SHUTDOWN_IN_PROGRESS)
+			ioc_warn(mrioc,
+			    "Shutdown still in progress after timeout\n");
+	}
+
+	ioc_info(mrioc,
+	    "Base IOC Sts/Config after %s shutdown is (0x%x)/(0x%x)\n",
+	    (!retval)?"successful":"failed", ioc_status,
+	    ioc_config);
+}
+
+/**
+ * mpi3mr_cleanup_ioc - Cleanup controller
+ * @mrioc: Adapter instance reference
+ *
+ * Controller cleanup handler, Message unit reset or soft reset
+ * and shutdown notification is issued to the controller and the
+ * associated memory resources are freed.
+ *
+ * Return: Nothing.
+ */
+void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc)
+{
+	enum mpi3mr_iocstate ioc_state;
+
+	mpi3mr_ioc_disable_intr(mrioc);
+
+	ioc_state = mpi3mr_get_iocstate(mrioc);
+
+	if ((!mrioc->unrecoverable) && (!mrioc->reset_in_progress) &&
+	     (ioc_state == MRIOC_STATE_READY)) {
+		if (mpi3mr_issue_and_process_mur(mrioc,
+		    MPI3MR_RESET_FROM_CTLR_CLEANUP))
+			mpi3mr_issue_reset(mrioc,
+			    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET,
+			    MPI3MR_RESET_FROM_MUR_FAILURE);
+
+		 mpi3mr_issue_ioc_shutdown(mrioc);
+	}
+
+	mpi3mr_free_mem(mrioc);
+	mpi3mr_cleanup_resources(mrioc);
+}
+
+
+/**
+ * mpi3mr_soft_reset_handler - Reset the controller
+ * @mrioc: Adapter instance reference
+ * @reset_reason: Reset reason code
+ * @snapdump: Flag to generate snapdump in firmware or not
+ *
+ * TBD
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
+	u32 reset_reason, u8 snapdump)
+{
+	return 0;
+}
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
new file mode 100644
index 000000000000..c31ec9883152
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Broadcom MPI3 Storage Controllers
+ *
+ * Copyright (C) 2017-2020 Broadcom Inc.
+ *  (mailto: mpi3mr-linuxdrv.pdl@broadcom.com)
+ *
+ */
+
+#include "mpi3mr.h"
+
+/* global driver scop variables */
+LIST_HEAD(mrioc_list);
+DEFINE_SPINLOCK(mrioc_list_lock);
+static int mrioc_ids;
+static int warn_non_secure_ctlr;
+
+MODULE_AUTHOR(MPI3MR_DRIVER_AUTHOR);
+MODULE_DESCRIPTION(MPI3MR_DRIVER_DESC);
+MODULE_LICENSE(MPI3MR_DRIVER_LICENSE);
+MODULE_VERSION(MPI3MR_DRIVER_VERSION);
+
+/* Module parameters*/
+int logging_level;
+module_param(logging_level, int, 0);
+MODULE_PARM_DESC(logging_level,
+	" bits for enabling additional logging info (default=0)");
+
+
+/**
+ * mpi3mr_map_queues - Map queues callback handler
+ * @shost: SCSI host reference
+ *
+ * Call the blk_mq_pci_map_queues with from which operational
+ * queue the mapping has to be done
+ *
+ * Return: return of blk_mq_pci_map_queues
+ */
+static int mpi3mr_map_queues(struct Scsi_Host *shost)
+{
+	struct mpi3mr_ioc *mrioc = shost_priv(shost);
+
+	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+	    mrioc->pdev, 0);
+}
+
+/**
+ * mpi3mr_slave_destroy - Slave destroy callback handler
+ * @sdev: SCSI device reference
+ *
+ * Cleanup and free per device(LUN) private data.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_slave_destroy(struct scsi_device *sdev)
+{
+}
+
+/**
+ * mpi3mr_target_destroy - Target destroy callback handler
+ * @starget: SCSI target reference
+ *
+ * Cleanup and free per target private data.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_target_destroy(struct scsi_target *starget)
+{
+}
+
+/**
+ * mpi3mr_slave_configure - Slave configure callback handler
+ * @sdev: SCSI device reference
+ *
+ * Configure queue depth, max hardware sectors and virt boundary
+ * as required
+ *
+ * Return: 0 always.
+ */
+static int mpi3mr_slave_configure(struct scsi_device *sdev)
+{
+	int retval = 0;
+	return retval;
+}
+
+/**
+ * mpi3mr_slave_alloc -Slave alloc callback handler
+ * @sdev: SCSI device reference
+ *
+ * Allocate per device(LUN) private data and initialize it.
+ *
+ * Return: 0 on success -ENOMEM on memory allocation failure.
+ */
+static int mpi3mr_slave_alloc(struct scsi_device *sdev)
+{
+	int retval = 0;
+	return retval;
+}
+
+/**
+ * mpi3mr_target_alloc - Target alloc callback handler
+ * @starget: SCSI target reference
+ *
+ * Allocate per target private data and initialize it.
+ *
+ * Return: 0 on success -ENOMEM on memory allocation failure.
+ */
+static int mpi3mr_target_alloc(struct scsi_target *starget)
+{
+	int retval = -ENODEV;
+	return retval;
+}
+
+/**
+ * mpi3mr_qcmd - I/O request despatcher
+ * @shost: SCSI Host reference
+ * @scmd: SCSI Command reference
+ *
+ * Issues the SCSI Command as an MPI3 request.
+ *
+ * Return: 0 on successful queueing of the request or if the
+ *         request is completed with failure.
+ *         SCSI_MLQUEUE_DEVICE_BUSY when the device is busy.
+ *         SCSI_MLQUEUE_HOST_BUSY when the host queue is full.
+ */
+static int mpi3mr_qcmd(struct Scsi_Host *shost,
+	struct scsi_cmnd *scmd)
+{
+	int retval = 0;
+
+	scmd->result = DID_NO_CONNECT << 16;
+	scmd->scsi_done(scmd);
+	return retval;
+}
+
+static struct scsi_host_template mpi3mr_driver_template = {
+	.module				= THIS_MODULE,
+	.name				= "MPI3 Storage Controller",
+	.proc_name			= MPI3MR_DRIVER_NAME,
+	.queuecommand			= mpi3mr_qcmd,
+	.target_alloc			= mpi3mr_target_alloc,
+	.slave_alloc			= mpi3mr_slave_alloc,
+	.slave_configure		= mpi3mr_slave_configure,
+	.target_destroy			= mpi3mr_target_destroy,
+	.slave_destroy			= mpi3mr_slave_destroy,
+	.map_queues			= mpi3mr_map_queues,
+	.no_write_same			= 1,
+	.can_queue			= 1,
+	.this_id			= -1,
+	.sg_tablesize			= MPI3MR_SG_DEPTH,
+	/* max xfer supported is 1M (2K in 512 byte sized sectors)
+	 */
+	.max_sectors			= 2048,
+	.cmd_per_lun			= MPI3MR_MAX_CMDS_LUN,
+	.track_queue_depth		= 1,
+	.cmd_size			= sizeof(struct scmd_priv),
+};
+
+
+/**
+ * mpi3mr_init_drv_cmd - Initialize internal command tracker
+ * @cmdptr: Internal command tracker
+ * @host_tag: Host tag used for the specific command
+ *
+ * Initialize the internal command tracker structure with
+ * specified host tag.
+ *
+ * Return: Nothing.
+ */
+static inline void mpi3mr_init_drv_cmd(struct mpi3mr_drv_cmd *cmdptr,
+	u16 host_tag)
+{
+	mutex_init(&cmdptr->mutex);
+	cmdptr->reply = NULL;
+	cmdptr->state = MPI3MR_CMD_NOTUSED;
+	cmdptr->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
+	cmdptr->host_tag = host_tag;
+}
+
+/**
+ * mpi3mr_probe - PCI probe callback
+ * @pdev: PCI device instance
+ * @id: PCI device ID details
+ *
+ * Controller initialization routine. Checks the security status
+ * of the controller and if it is invalid or tampered return the
+ * probe without initializing the controller. Otherwise,
+ * allocate per adapter instance through shost_priv and
+ * initialize controller specific data structures, initializae
+ * the controller hardware, add shost to the SCSI subsystem.
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+
+static int
+mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct mpi3mr_ioc *mrioc = NULL;
+	struct Scsi_Host *shost = NULL;
+	int retval = 0;
+
+	shost = scsi_host_alloc(&mpi3mr_driver_template,
+	    sizeof(struct mpi3mr_ioc));
+	if (!shost) {
+		retval = -ENODEV;
+		goto shost_failed;
+	}
+
+	mrioc = shost_priv(shost);
+	mrioc->id = mrioc_ids++;
+	sprintf(mrioc->driver_name, "%s", MPI3MR_DRIVER_NAME);
+	sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id);
+	INIT_LIST_HEAD(&mrioc->list);
+	spin_lock(&mrioc_list_lock);
+	list_add_tail(&mrioc->list, &mrioc_list);
+	spin_unlock(&mrioc_list_lock);
+
+	spin_lock_init(&mrioc->admin_req_lock);
+	spin_lock_init(&mrioc->reply_free_queue_lock);
+	spin_lock_init(&mrioc->sbq_lock);
+
+	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
+
+	mrioc->logging_level = logging_level;
+	mrioc->shost = shost;
+	mrioc->pdev = pdev;
+
+	/* init shost parameters */
+	shost->max_cmd_len = MPI3MR_MAX_CDB_LENGTH;
+	shost->max_lun = -1;
+	shost->unique_id = mrioc->id;
+
+	shost->max_channel = 1;
+	shost->max_id = 0xFFFFFFFF;
+
+	mrioc->is_driver_loading = 1;
+	if (mpi3mr_init_ioc(mrioc)) {
+		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
+		    __FILE__, __LINE__, __func__);
+		retval = -ENODEV;
+		goto out_iocinit_failed;
+	}
+
+	shost->nr_hw_queues = mrioc->num_op_reply_q;
+	shost->can_queue = mrioc->max_host_ios;
+	shost->sg_tablesize = MPI3MR_SG_DEPTH;
+	shost->max_id = mrioc->facts.max_perids;
+
+	retval = scsi_add_host(shost, &pdev->dev);
+	if (retval) {
+		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
+		    __FILE__, __LINE__, __func__);
+		goto addhost_failed;
+	}
+
+	scsi_scan_host(shost);
+	return retval;
+
+addhost_failed:
+	mpi3mr_cleanup_ioc(mrioc);
+out_iocinit_failed:
+	spin_lock(&mrioc_list_lock);
+	list_del(&mrioc->list);
+	spin_unlock(&mrioc_list_lock);
+	scsi_host_put(shost);
+shost_failed:
+	return retval;
+}
+
+/**
+ * mpi3mr_remove - PCI remove callback
+ * @pdev: PCI device instance
+ *
+ * Free up all memory and resources associated with the
+ * controllerand target devices, unregister the shost.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_remove(struct pci_dev *pdev)
+{
+	struct Scsi_Host *shost = pci_get_drvdata(pdev);
+	struct mpi3mr_ioc *mrioc;
+
+	mrioc = shost_priv(shost);
+	while (mrioc->reset_in_progress || mrioc->is_driver_loading)
+		ssleep(1);
+
+
+	scsi_remove_host(shost);
+
+	mpi3mr_cleanup_ioc(mrioc);
+
+	spin_lock(&mrioc_list_lock);
+	list_del(&mrioc->list);
+	spin_unlock(&mrioc_list_lock);
+
+	scsi_host_put(shost);
+}
+
+/**
+ * mpi3mr_shutdown - PCI shutdown callback
+ * @pdev: PCI device instance
+ *
+ * Free up all memory and resources associated with the
+ * controller
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_shutdown(struct pci_dev *pdev)
+{
+	struct Scsi_Host *shost = pci_get_drvdata(pdev);
+	struct mpi3mr_ioc *mrioc;
+
+	if (!shost)
+		return;
+
+	mrioc = shost_priv(shost);
+	while (mrioc->reset_in_progress || mrioc->is_driver_loading)
+		ssleep(1);
+
+	mpi3mr_cleanup_ioc(mrioc);
+
+}
+
+static const struct pci_device_id mpi3mr_pci_id_table[] = {
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_LSI_LOGIC, 0x00A5,
+		    PCI_ANY_ID, PCI_ANY_ID)
+	},
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, mpi3mr_pci_id_table);
+
+static struct pci_driver mpi3mr_pci_driver = {
+	.name = MPI3MR_DRIVER_NAME,
+	.id_table = mpi3mr_pci_id_table,
+	.probe = mpi3mr_probe,
+	.remove = mpi3mr_remove,
+	.shutdown = mpi3mr_shutdown,
+};
+
+static int __init mpi3mr_init(void)
+{
+	int ret_val;
+
+	pr_info("Loading %s version %s\n", MPI3MR_DRIVER_NAME,
+	    MPI3MR_DRIVER_VERSION);
+
+	ret_val = pci_register_driver(&mpi3mr_pci_driver);
+
+	return ret_val;
+}
+
+static void __exit mpi3mr_exit(void)
+{
+	if (warn_non_secure_ctlr)
+		pr_warn(
+		    "Unloading %s version %s while managing a non secure controller\n",
+		    MPI3MR_DRIVER_NAME, MPI3MR_DRIVER_VERSION);
+	else
+		pr_info("Unloading %s version %s\n", MPI3MR_DRIVER_NAME,
+		    MPI3MR_DRIVER_VERSION);
+
+	pci_unregister_driver(&mpi3mr_pci_driver);
+}
+
+module_init(mpi3mr_init);
+module_exit(mpi3mr_exit);
-- 
2.18.1


--0000000000006d971505bf585919
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDHA7TgNc55htm2viYDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxMjU2MDJaFw0yMjA5MTUxMTQ1MTZaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDUthc2h5YXAgRGVzYWkxKTAnBgkqhkiG9w0B
CQEWGmthc2h5YXAuZGVzYWlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAzPAzyHBqFL/1u7ttl86wZrWK3vYcqFH+GBe0laKvAGOuEkaHijHa8iH+9GA8FUv1cdWF
WY3c3BGA+omJGYc4eHLEyKowuLRWvjV3MEjGBG7NIVoIaTkH4R+6Xs1P4/9EmUA0WI881B3pTv5W
nHG54/aqGUDSRDyWVhK7TLqJQkkiYKB0kH0GkB/UfmU/pmCaV68w5J6l4vz/TG23hWJmTg1lW5mu
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILZ3w0sUec5vLcHiY3MhBw/fmbI1
jb38iyKOPuhwPVTRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQwNzAyMDQyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAPi4H3vlEj8ufO78e2Pa+4Eyq3HyIm/fmhYjdE2Rnv/zqV
3O6UzjeFm4Qr+Ollz2rcUITYvtuWoHOS/oNg5X6gqA2jm4Lr4FVM/IPbJrIoAjSBopiuYZ7hEFpK
VSviIIXr6mXlR8ZeoH3eqCSbXOWaw6fv0ysqp1/Nvs5sNKh6Yo36v1uLCDnCylOUZ4SG180DDQ5c
grCaX1N/2LycUwN+wSxatzd5erZiBKYAu04FumGqVi6Qq20y2I3gB9TBfwGBsIKGY5O2XwGFxURm
qENA30Fc0Psx1/4JmkWlCAHtEqc1pvq+fInFVj8+X0bsJa5TSO3MpKOgMjwWwra7g9TK
--0000000000006d971505bf585919--
