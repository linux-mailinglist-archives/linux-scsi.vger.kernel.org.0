Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F0A369D60
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Apr 2021 01:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbhDWXgV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbhDWXfx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 23 Apr 2021 19:35:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B476C06138C
        for <linux-scsi@vger.kernel.org>; Fri, 23 Apr 2021 16:35:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso2096382pjs.2
        for <linux-scsi@vger.kernel.org>; Fri, 23 Apr 2021 16:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TCOrtjzwNgjqEN4zWZ07LOKWq2vOVRkrTavJ/B6Zis=;
        b=Nr1uOmxXuQC+vM5RtminwlhfZ43Wsajl2jRc74EYF3s4gr/k5Hky+bgoX9pbxQcGYw
         tbZevl16cJJULOegIf3fLf4soPg9aHcg5OOz6MuQI+KhBtY1DGEQRFTzxXDcavFlzmYC
         cJXPJjxmNsiQV7yzn4SGLOJP9ArKfmBrZYyStQlZBb6bhTPjjgGcf+wkMolsuMATg/XL
         JSaoU9eCcVd03VIwRVtz9HWA4v8U04Bd84p5zpgzyjgaRAOaIKULCyRANOj4P2A6MT5H
         SacxPI9CDacxXJ6BSKll71Siu8qny4WwknCu2srApWprB+ehetl7GmXqBJ1HQBndXNhE
         iNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TCOrtjzwNgjqEN4zWZ07LOKWq2vOVRkrTavJ/B6Zis=;
        b=RH2+89xAjgVaaMs00A12oxDllLdhN1ThubV7OtzJXPdc85I6lsPVy9t+YGtFRQWnnF
         sXPSqr9siABi2DQrPVl5DRGJqCpheBpm2I5xeM6JLw8AgwNd+G4Bag/T3qi/KWAqAbIu
         1hfC3odK3TW4Fc2jeS7MzhzwzM8x9LtoYoVPrmMxzhjWYKYZObyod8P9YDqD9K0kksY1
         oixKKthgPKsoKU+Ts3nWi4mqG8LjCV9CQet8j18trHIseXR7c6HN3KpM3kNfP9zEzGPr
         kEpQLfOIeCHmuW0BKX9hYfQBegwOoT2s0+tByh3AL8YbfsOfk9gH8s0P5x8yFCYQRP4t
         b2BA==
X-Gm-Message-State: AOAM532BlNZ68pkEL2Au1JGbIgWc+65p726kbkK0hVooRHmtdgsRCEcn
        RKi5Cu+lgXfW23vs674gPWPqzXyMdBk=
X-Google-Smtp-Source: ABdhPJyeBSJxrXR5eOTKxDK1/ETIHsv6a3pc8C4rfm6X844NcFgQLrS3WsE5eZC7tQVFNObFBCoYtw==
X-Received: by 2002:a17:90a:17a3:: with SMTP id q32mr7194678pja.224.1619220913752;
        Fri, 23 Apr 2021 16:35:13 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v123sm5346892pfb.80.2021.04.23.16.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 16:35:13 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v8 17/31] elx: efct: Data structures and defines for hw operations
Date:   Fri, 23 Apr 2021 16:34:41 -0700
Message-Id: <20210423233455.27243-18-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210423233455.27243-1-jsmart2021@gmail.com>
References: <20210423233455.27243-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch starts the population of the efct target mode
driver.  The driver is contained in the drivers/scsi/elx/efct
subdirectory.

This patch creates the efct directory and starts population of
the driver by adding SLI-4 configuration parameters, data structures
for configuring SLI-4 queues, converting from os to SLI-4 IO requests,
and handling async events.

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/elx/efct/efct_hw.h | 600 ++++++++++++++++++++++++++++++++
 1 file changed, 600 insertions(+)
 create mode 100644 drivers/scsi/elx/efct/efct_hw.h

diff --git a/drivers/scsi/elx/efct/efct_hw.h b/drivers/scsi/elx/efct/efct_hw.h
new file mode 100644
index 000000000000..913b22d4a8ae
--- /dev/null
+++ b/drivers/scsi/elx/efct/efct_hw.h
@@ -0,0 +1,600 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#ifndef _EFCT_HW_H
+#define _EFCT_HW_H
+
+#include "../libefc_sli/sli4.h"
+
+/*
+ * EFCT PCI IDs
+ */
+#define EFCT_VENDOR_ID			0x10df
+/* LightPulse 16Gb x 4 FC (lancer-g6) */
+#define EFCT_DEVICE_LANCER_G6		0xe307
+/* LightPulse 32Gb x 4 FC (lancer-g7) */
+#define EFCT_DEVICE_LANCER_G7		0xf407
+
+/*Default RQ entries len used by driver*/
+#define EFCT_HW_RQ_ENTRIES_MIN		512
+#define EFCT_HW_RQ_ENTRIES_DEF		1024
+#define EFCT_HW_RQ_ENTRIES_MAX		4096
+
+/*Defines the size of the RQ buffers used for each RQ*/
+#define EFCT_HW_RQ_SIZE_HDR             128
+#define EFCT_HW_RQ_SIZE_PAYLOAD         1024
+
+/*Define the maximum number of multi-receive queues*/
+#define EFCT_HW_MAX_MRQS		8
+
+/*
+ * Define count of when to set the WQEC bit in a submitted
+ * WQE, causing a consummed/released completion to be posted.
+ */
+#define EFCT_HW_WQEC_SET_COUNT		32
+
+/*Send frame timeout in seconds*/
+#define EFCT_HW_SEND_FRAME_TIMEOUT	10
+
+/*
+ * FDT Transfer Hint value, reads greater than this value
+ * will be segmented to implement fairness. A value of zero disables
+ * the feature.
+ */
+#define EFCT_HW_FDT_XFER_HINT		8192
+
+#define EFCT_HW_TIMECHECK_ITERATIONS	100
+#define EFCT_HW_MAX_NUM_MQ		1
+#define EFCT_HW_MAX_NUM_RQ		32
+#define EFCT_HW_MAX_NUM_EQ		16
+#define EFCT_HW_MAX_NUM_WQ		32
+#define EFCT_HW_DEF_NUM_EQ		1
+
+#define OCE_HW_MAX_NUM_MRQ_PAIRS	16
+
+#define EFCT_HW_MQ_DEPTH		128
+#define EFCT_HW_EQ_DEPTH		1024
+
+/*
+ * A CQ will be assinged to each WQ
+ * (CQ must have 2X entries of the WQ for abort
+ * processing), plus a separate one for each RQ PAIR and one for MQ
+ */
+#define EFCT_HW_MAX_NUM_CQ \
+	((EFCT_HW_MAX_NUM_WQ * 2) + 1 + (OCE_HW_MAX_NUM_MRQ_PAIRS * 2))
+
+#define EFCT_HW_Q_HASH_SIZE		128
+#define EFCT_HW_RQ_HEADER_SIZE		128
+#define EFCT_HW_RQ_HEADER_INDEX		0
+
+#define EFCT_HW_REQUE_XRI_REGTAG	65534
+
+/* Options for efct_hw_command() */
+enum efct_cmd_opts {
+	/* command executes synchronously and busy-waits for completion */
+	EFCT_CMD_POLL,
+	/* command executes asynchronously. Uses callback */
+	EFCT_CMD_NOWAIT,
+};
+
+enum efct_hw_rtn {
+	EFCT_HW_RTN_SUCCESS = 0,
+	EFCT_HW_RTN_ERROR = -1,
+	EFCT_HW_RTN_NO_RESOURCES = -2,
+	EFCT_HW_RTN_NO_MEMORY = -3,
+	EFCT_HW_RTN_IO_NOT_ACTIVE = -4,
+	EFCT_HW_RTN_IO_ABORT_IN_PROGRESS = -5,
+	EFCT_HW_RTN_IO_PORT_OWNED_ALREADY_ABORTED = -6,
+	EFCT_HW_RTN_INVALID_ARG = -7,
+};
+
+#define EFCT_HW_RTN_IS_ERROR(e)	((e) < 0)
+
+enum efct_hw_reset {
+	EFCT_HW_RESET_FUNCTION,
+	EFCT_HW_RESET_FIRMWARE,
+	EFCT_HW_RESET_MAX
+};
+
+enum efct_hw_topo {
+	EFCT_HW_TOPOLOGY_AUTO,
+	EFCT_HW_TOPOLOGY_NPORT,
+	EFCT_HW_TOPOLOGY_LOOP,
+	EFCT_HW_TOPOLOGY_NONE,
+	EFCT_HW_TOPOLOGY_MAX
+};
+
+/* pack fw revision values into a single uint64_t */
+#define HW_FWREV(a, b, c, d) (((uint64_t)(a) << 48) | ((uint64_t)(b) << 32) \
+			| ((uint64_t)(c) << 16) | ((uint64_t)(d)))
+
+#define EFCT_FW_VER_STR(a, b, c, d) (#a "." #b "." #c "." #d)
+
+enum efct_hw_io_type {
+	EFCT_HW_ELS_REQ,
+	EFCT_HW_ELS_RSP,
+	EFCT_HW_FC_CT,
+	EFCT_HW_FC_CT_RSP,
+	EFCT_HW_BLS_ACC,
+	EFCT_HW_BLS_RJT,
+	EFCT_HW_IO_TARGET_READ,
+	EFCT_HW_IO_TARGET_WRITE,
+	EFCT_HW_IO_TARGET_RSP,
+	EFCT_HW_IO_DNRX_REQUEUE,
+	EFCT_HW_IO_MAX,
+};
+
+enum efct_hw_io_state {
+	EFCT_HW_IO_STATE_FREE,
+	EFCT_HW_IO_STATE_INUSE,
+	EFCT_HW_IO_STATE_WAIT_FREE,
+	EFCT_HW_IO_STATE_WAIT_SEC_HIO,
+};
+
+#define EFCT_TARGET_WRITE_SKIPS	1
+#define EFCT_TARGET_READ_SKIPS	2
+
+struct efct_hw;
+struct efct_io;
+
+#define EFCT_CMD_CTX_POOL_SZ	32
+/**
+ * HW command context.
+ * Stores the state for the asynchronous commands sent to the hardware.
+ */
+struct efct_command_ctx {
+	struct list_head	list_entry;
+	int (*cb)(struct efct_hw *hw, int status, u8 *mqe, void *arg);
+	void			*arg;	/* Argument for callback */
+	/* buffer holding command / results */
+	u8			buf[SLI4_BMBX_SIZE];
+	void			*ctx;	/* upper layer context */
+};
+
+struct efct_hw_sgl {
+	uintptr_t		addr;
+	size_t			len;
+};
+
+union efct_hw_io_param_u {
+	struct sli_bls_params bls;
+	struct sli_els_params els;
+	struct sli_ct_params fc_ct;
+	struct sli_fcp_tgt_params fcp_tgt;
+};
+
+/* WQ steering mode */
+enum efct_hw_wq_steering {
+	EFCT_HW_WQ_STEERING_CLASS,
+	EFCT_HW_WQ_STEERING_REQUEST,
+	EFCT_HW_WQ_STEERING_CPU,
+};
+
+/* HW wqe object */
+struct efct_hw_wqe {
+	struct list_head	list_entry;
+	bool			abort_wqe_submit_needed;
+	bool			send_abts;
+	u32			id;
+	u32			abort_reqtag;
+	u8			*wqebuf;
+};
+
+struct efct_hw_io;
+/* Typedef for HW "done" callback */
+typedef int (*efct_hw_done_t)(struct efct_hw_io *, u32 len, int status,
+			      u32 ext, void *ul_arg);
+
+/**
+ * HW IO object.
+ *
+ * Stores the per-IO information necessary
+ * for both SLI and efct.
+ * @ref:		reference counter for hw io object
+ * @state:		state of IO: free, busy, wait_free
+ * @list_entry		used for busy, wait_free, free lists
+ * @wqe			Work queue object, with link for pending
+ * @hw			pointer back to hardware context
+ * @xfer_rdy		transfer ready data
+ * @type		IO type
+ * @xbusy		Exchange is active in FW
+ * @abort_in_progress	if TRUE, abort is in progress
+ * @status_saved	if TRUE, latched status should be returned
+ * @wq_class		WQ class if steering mode is Class
+ * @reqtag		request tag for this HW IO
+ * @wq			WQ assigned to the exchange
+ * @done		Function called on IO completion
+ * @arg			argument passed to IO done callback
+ * @abort_done		Function called on abort completion
+ * @abort_arg		argument passed to abort done callback
+ * @wq_steering		WQ steering mode request
+ * @saved_status	Saved status
+ * @saved_len		Status length
+ * @saved_ext		Saved extended status
+ * @eq			EQ on which this HIO came up
+ * @sge_offset		SGE data offset
+ * @def_sgl_count	Count of SGEs in default SGL
+ * @abort_reqtag	request tag for an abort of this HW IO
+ * @indicator		Exchange indicator
+ * @def_sgl		default SGL
+ * @sgl			pointer to current active SGL
+ * @sgl_count		count of SGEs in io->sgl
+ * @first_data_sge	index of first data SGE
+ * @n_sge		number of active SGEs
+ */
+struct efct_hw_io {
+	struct kref		ref;
+	enum efct_hw_io_state	state;
+	void			(*release)(struct kref *arg);
+	struct list_head	list_entry;
+	struct efct_hw_wqe	wqe;
+
+	struct efct_hw		*hw;
+	struct efc_dma		xfer_rdy;
+	u16			type;
+	bool			xbusy;
+	bool			abort_in_progress;
+	bool			status_saved;
+	u8			wq_class;
+	u16			reqtag;
+
+	struct hw_wq		*wq;
+	efct_hw_done_t		done;
+	void			*arg;
+	efct_hw_done_t		abort_done;
+	void			*abort_arg;
+
+	enum efct_hw_wq_steering wq_steering;
+
+	u32			saved_status;
+	u32			saved_len;
+	u32			saved_ext;
+
+	struct hw_eq		*eq;
+	u32			sge_offset;
+	u32			def_sgl_count;
+	u32			abort_reqtag;
+	u32			indicator;
+	struct efc_dma		def_sgl;
+	struct efc_dma		*sgl;
+	u32			sgl_count;
+	u32			first_data_sge;
+	u32			n_sge;
+};
+
+
+enum efct_hw_port {
+	EFCT_HW_PORT_INIT,
+	EFCT_HW_PORT_SHUTDOWN,
+};
+
+/* Node group rpi reference */
+struct efct_hw_rpi_ref {
+	atomic_t rpi_count;
+	atomic_t rpi_attached;
+};
+
+enum efct_hw_link_stat {
+	EFCT_HW_LINK_STAT_LINK_FAILURE_COUNT,
+	EFCT_HW_LINK_STAT_LOSS_OF_SYNC_COUNT,
+	EFCT_HW_LINK_STAT_LOSS_OF_SIGNAL_COUNT,
+	EFCT_HW_LINK_STAT_PRIMITIVE_SEQ_COUNT,
+	EFCT_HW_LINK_STAT_INVALID_XMIT_WORD_COUNT,
+	EFCT_HW_LINK_STAT_CRC_COUNT,
+	EFCT_HW_LINK_STAT_PRIMITIVE_SEQ_TIMEOUT_COUNT,
+	EFCT_HW_LINK_STAT_ELASTIC_BUFFER_OVERRUN_COUNT,
+	EFCT_HW_LINK_STAT_ARB_TIMEOUT_COUNT,
+	EFCT_HW_LINK_STAT_ADVERTISED_RCV_B2B_CREDIT,
+	EFCT_HW_LINK_STAT_CURR_RCV_B2B_CREDIT,
+	EFCT_HW_LINK_STAT_ADVERTISED_XMIT_B2B_CREDIT,
+	EFCT_HW_LINK_STAT_CURR_XMIT_B2B_CREDIT,
+	EFCT_HW_LINK_STAT_RCV_EOFA_COUNT,
+	EFCT_HW_LINK_STAT_RCV_EOFDTI_COUNT,
+	EFCT_HW_LINK_STAT_RCV_EOFNI_COUNT,
+	EFCT_HW_LINK_STAT_RCV_SOFF_COUNT,
+	EFCT_HW_LINK_STAT_RCV_DROPPED_NO_AER_COUNT,
+	EFCT_HW_LINK_STAT_RCV_DROPPED_NO_RPI_COUNT,
+	EFCT_HW_LINK_STAT_RCV_DROPPED_NO_XRI_COUNT,
+	EFCT_HW_LINK_STAT_MAX,
+};
+
+enum efct_hw_host_stat {
+	EFCT_HW_HOST_STAT_TX_KBYTE_COUNT,
+	EFCT_HW_HOST_STAT_RX_KBYTE_COUNT,
+	EFCT_HW_HOST_STAT_TX_FRAME_COUNT,
+	EFCT_HW_HOST_STAT_RX_FRAME_COUNT,
+	EFCT_HW_HOST_STAT_TX_SEQ_COUNT,
+	EFCT_HW_HOST_STAT_RX_SEQ_COUNT,
+	EFCT_HW_HOST_STAT_TOTAL_EXCH_ORIG,
+	EFCT_HW_HOST_STAT_TOTAL_EXCH_RESP,
+	EFCT_HW_HOSY_STAT_RX_P_BSY_COUNT,
+	EFCT_HW_HOST_STAT_RX_F_BSY_COUNT,
+	EFCT_HW_HOST_STAT_DROP_FRM_DUE_TO_NO_RQ_BUF_COUNT,
+	EFCT_HW_HOST_STAT_EMPTY_RQ_TIMEOUT_COUNT,
+	EFCT_HW_HOST_STAT_DROP_FRM_DUE_TO_NO_XRI_COUNT,
+	EFCT_HW_HOST_STAT_EMPTY_XRI_POOL_COUNT,
+	EFCT_HW_HOST_STAT_MAX,
+};
+
+enum efct_hw_state {
+	EFCT_HW_STATE_UNINITIALIZED,
+	EFCT_HW_STATE_QUEUES_ALLOCATED,
+	EFCT_HW_STATE_ACTIVE,
+	EFCT_HW_STATE_RESET_IN_PROGRESS,
+	EFCT_HW_STATE_TEARDOWN_IN_PROGRESS,
+};
+
+struct efct_hw_link_stat_counts {
+	u8		overflow;
+	u32		counter;
+};
+
+struct efct_hw_host_stat_counts {
+	u32		counter;
+};
+
+/* Structure used for the hash lookup of queue IDs */
+struct efct_queue_hash {
+	bool		in_use;
+	u16		id;
+	u16		index;
+};
+
+/* WQ callback object */
+struct hw_wq_callback {
+	u16		instance_index;	/* use for request tag */
+	void (*callback)(void *arg, u8 *cqe, int status);
+	void		*arg;
+	struct list_head list_entry;
+};
+
+struct reqtag_pool {
+	spinlock_t lock;	/* pool lock */
+	struct hw_wq_callback *tags[U16_MAX];
+	struct list_head freelist;
+};
+
+struct efct_hw_config {
+	u32		n_eq;
+	u32		n_cq;
+	u32		n_mq;
+	u32		n_rq;
+	u32		n_wq;
+	u32		n_io;
+	u32		n_sgl;
+	u32		speed;
+	u32		topology;
+	/* size of the buffers for first burst */
+	u32		rq_default_buffer_size;
+	u8		esoc;
+	/* MRQ RQ selection policy */
+	u8		rq_selection_policy;
+	/* RQ quanta if rq_selection_policy == 2 */
+	u8		rr_quanta;
+	u32		filter_def[SLI4_CMD_REG_FCFI_NUM_RQ_CFG];
+};
+
+struct efct_hw {
+	struct efct		*os;
+	struct sli4		sli;
+	u16			ulp_start;
+	u16			ulp_max;
+	u32			dump_size;
+	enum efct_hw_state	state;
+	bool			hw_setup_called;
+	u8			sliport_healthcheck;
+	u16			fcf_indicator;
+
+	/* HW configuration */
+	struct efct_hw_config	config;
+
+	/* calculated queue sizes for each type */
+	u32			num_qentries[SLI4_QTYPE_MAX];
+
+	/* Storage for SLI queue objects */
+	struct sli4_queue	wq[EFCT_HW_MAX_NUM_WQ];
+	struct sli4_queue	rq[EFCT_HW_MAX_NUM_RQ];
+	u16			hw_rq_lookup[EFCT_HW_MAX_NUM_RQ];
+	struct sli4_queue	mq[EFCT_HW_MAX_NUM_MQ];
+	struct sli4_queue	cq[EFCT_HW_MAX_NUM_CQ];
+	struct sli4_queue	eq[EFCT_HW_MAX_NUM_EQ];
+
+	/* HW queue */
+	u32			eq_count;
+	u32			cq_count;
+	u32			mq_count;
+	u32			wq_count;
+	u32			rq_count;
+	u32			cmd_head_count;
+	struct list_head	eq_list;
+
+	struct efct_queue_hash	cq_hash[EFCT_HW_Q_HASH_SIZE];
+	struct efct_queue_hash	rq_hash[EFCT_HW_Q_HASH_SIZE];
+	struct efct_queue_hash	wq_hash[EFCT_HW_Q_HASH_SIZE];
+
+	/* Storage for HW queue objects */
+	struct hw_wq		*hw_wq[EFCT_HW_MAX_NUM_WQ];
+	struct hw_rq		*hw_rq[EFCT_HW_MAX_NUM_RQ];
+	struct hw_mq		*hw_mq[EFCT_HW_MAX_NUM_MQ];
+	struct hw_cq		*hw_cq[EFCT_HW_MAX_NUM_CQ];
+	struct hw_eq		*hw_eq[EFCT_HW_MAX_NUM_EQ];
+	/* count of hw_rq[] entries */
+	u32			hw_rq_count;
+	/* count of multirq RQs */
+	u32			hw_mrq_count;
+
+	struct hw_wq		**wq_cpu_array;
+
+	/* Sequence objects used in incoming frame processing */
+	struct efc_hw_sequence	*seq_pool;
+
+	/* Maintain an ordered, linked list of outstanding HW commands. */
+	struct mutex            bmbx_lock;
+	spinlock_t		cmd_lock;
+	struct list_head	cmd_head;
+	struct list_head	cmd_pending;
+	mempool_t		*cmd_ctx_pool;
+	mempool_t		*mbox_rqst_pool;
+
+	struct sli4_link_event	link;
+
+	/* pointer array of IO objects */
+	struct efct_hw_io	**io;
+	/* array of WQE buffs mapped to IO objects */
+	u8			*wqe_buffs;
+
+	/* IO lock to synchronize list access */
+	spinlock_t		io_lock;
+	/* List of IO objects in use */
+	struct list_head	io_inuse;
+	/* List of IO objects waiting to be freed */
+	struct list_head	io_wait_free;
+	/* List of IO objects available for allocation */
+	struct list_head	io_free;
+
+	struct efc_dma		loop_map;
+
+	struct efc_dma		xfer_rdy;
+
+	struct efc_dma		rnode_mem;
+
+	atomic_t		io_alloc_failed_count;
+
+	/* stat: wq sumbit count */
+	u32			tcmd_wq_submit[EFCT_HW_MAX_NUM_WQ];
+	/* stat: wq complete count */
+	u32			tcmd_wq_complete[EFCT_HW_MAX_NUM_WQ];
+
+	atomic_t		send_frame_seq_id;
+	struct reqtag_pool	*wq_reqtag_pool;
+};
+
+enum efct_hw_io_count_type {
+	EFCT_HW_IO_INUSE_COUNT,
+	EFCT_HW_IO_FREE_COUNT,
+	EFCT_HW_IO_WAIT_FREE_COUNT,
+	EFCT_HW_IO_N_TOTAL_IO_COUNT,
+};
+
+/* HW queue data structures */
+struct hw_eq {
+	struct list_head	list_entry;
+	enum sli4_qtype		type;
+	u32			instance;
+	u32			entry_count;
+	u32			entry_size;
+	struct efct_hw		*hw;
+	struct sli4_queue	*queue;
+	struct list_head	cq_list;
+	u32			use_count;
+};
+
+struct hw_cq {
+	struct list_head	list_entry;
+	enum sli4_qtype		type;
+	u32			instance;
+	u32			entry_count;
+	u32			entry_size;
+	struct hw_eq		*eq;
+	struct sli4_queue	*queue;
+	struct list_head	q_list;
+	u32			use_count;
+};
+
+struct hw_q {
+	struct list_head	list_entry;
+	enum sli4_qtype		type;
+};
+
+struct hw_mq {
+	struct list_head	list_entry;
+	enum sli4_qtype		type;
+	u32			instance;
+
+	u32			entry_count;
+	u32			entry_size;
+	struct hw_cq		*cq;
+	struct sli4_queue	*queue;
+
+	u32			use_count;
+};
+
+struct hw_wq {
+	struct list_head	list_entry;
+	enum sli4_qtype		type;
+	u32			instance;
+	struct efct_hw		*hw;
+
+	u32			entry_count;
+	u32			entry_size;
+	struct hw_cq		*cq;
+	struct sli4_queue	*queue;
+	u32			class;
+
+	/* WQ consumed */
+	u32			wqec_set_count;
+	u32			wqec_count;
+	u32			free_count;
+	u32			total_submit_count;
+	struct list_head	pending_list;
+
+	/* HW IO allocated for use with Send Frame */
+	struct efct_hw_io	*send_frame_io;
+
+	/* Stats */
+	u32			use_count;
+	u32			wq_pending_count;
+};
+
+struct hw_rq {
+	struct list_head	list_entry;
+	enum sli4_qtype		type;
+	u32			instance;
+
+	u32			entry_count;
+	u32			use_count;
+	u32			hdr_entry_size;
+	u32			first_burst_entry_size;
+	u32			data_entry_size;
+	bool			is_mrq;
+	u32			base_mrq_id;
+
+	struct hw_cq		*cq;
+
+	u8			filter_mask;
+	struct sli4_queue	*hdr;
+	struct sli4_queue	*first_burst;
+	struct sli4_queue	*data;
+
+	struct efc_hw_rq_buffer	*hdr_buf;
+	struct efc_hw_rq_buffer	*fb_buf;
+	struct efc_hw_rq_buffer	*payload_buf;
+	/* RQ tracker for this RQ */
+	struct efc_hw_sequence	**rq_tracker;
+};
+
+struct efct_hw_send_frame_context {
+	struct efct_hw		*hw;
+	struct hw_wq_callback	*wqcb;
+	struct efct_hw_wqe	wqe;
+	void (*callback)(int status, void *arg);
+	void			*arg;
+
+	/* General purpose elements */
+	struct efc_hw_sequence	*seq;
+	struct efc_dma		payload;
+};
+
+struct efct_hw_grp_hdr {
+	u32			size;
+	__be32			magic_number;
+	u32			word2;
+	u8			rev_name[128];
+	u8			date[12];
+	u8			revision[32];
+};
+
+#endif /* __EFCT_H__ */
-- 
2.26.2

