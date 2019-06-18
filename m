Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABD549D68
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfFRJdW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:33:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34013 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRJdW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:33:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so7386642pgn.1
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CoA6rL8thdtbvxFhjnwGfWN4ShPAR8WIkjSXsy8S6ak=;
        b=B6J1HycXLAgGGy40fkzTsQUPfqxli6YCv+6JZcNSv3P/jkWsMMPEFHjiQpdCAtVmyV
         LL21fFlWRmD4I07Ym7/4l6a778EGdQUhJ215JiY2ClxRNzvIjXg7lAgAnrzvrKdF2QKY
         uJ8eB60iCb0ov5gNpq7OAy5ba06ve3wXe/h0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CoA6rL8thdtbvxFhjnwGfWN4ShPAR8WIkjSXsy8S6ak=;
        b=e79QUHP17LqI2E5mZ2iAnQvfSDOyRwG4o3CdOiGb+1aMj2+SzO7YOAzPHckCIAXeb6
         HlHpfXHAyIGZIkfwukrFeO2SHkefU1/Jx8RmJn8x5yZV22uQPlRMUyFONWrG3606fhFV
         I2kJHXkPa8w4T2Y/UhDDnxcdkoqkmvSeahQbOwSKYRqpCYOfCai0HqklBAsZj/tdXFfi
         u3Ai8RnHHZvky+UwJ+k+SqRVmbc0cypousxows2OK3a9cCCL4pcqz1XQbrW7NYoyFnOK
         PHz5lFCBCRlgXVjFBHQVXvGy1Vy6dVwckWJjphWaVvlsFalqpZAweoG8nJJ2fHF3vwfD
         dFsA==
X-Gm-Message-State: APjAAAUC8NGgiW4QXOyNQdIDevoWPpouiSzhjHXQAZbtVfcDAk4tyEN9
        czdRQP32SCL47i8pXfT7hWSQ+gIPw75rZt3pPwu2zdJ2L6PQDtW3z4FWnZG7WdWpvVUhyAIJg4L
        wOGaO2TBpBPugfbh46v+ZFZpP/3k+ILiDwgOS9LpMVLHAhMGyAclldXTKc5A/2NNtxgzgBVQfgG
        1ykPKj0QbQrQ==
X-Google-Smtp-Source: APXvYqyf9iGp7Z54U6BEQsEG4SuHYKbfF/kwETVy01UTXacEfnoyX3X9JdOKBZxULNkomg0OhJ9bbA==
X-Received: by 2002:a62:640e:: with SMTP id y14mr114947610pfb.109.1560850400948;
        Tue, 18 Jun 2019 02:33:20 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.33.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:33:20 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 17/18] megaraid_sas: Introduce various Aero performance modes
Date:   Tue, 18 Jun 2019 15:02:06 +0530
Message-Id: <20190618093207.9939-18-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For Aero adapters, driver provides three different  performance modes controlled 
through module parameter named- 'perf_mode'. Below are those performance modes:

 0: Balanced - Additional high IOPs reply queues will be enabled along with
    low latency queues. Interrupt coalescing will be enabled only for these
    high IOPs reply queues.

 1: IOPs - No additional high IOPs queues are enabled. Interrupt coalescing will be
    enabled on all reply queues.

 2: Latency - No additional high IOPs queues are enabled. Interrupt coalescing will be
    disabled on all reply queues. This is a legacy behavior similar to Ventura & Invader
    Series.

Default performance mode settings:
-Performance mode set to 'Balanced', if Aero controller is working in 16GT/s PCIe speed.
-Performance mode will be set to 'Latency' mode for all other cases.

Through module parameter- 'perf_mode', user can override default performance mode to 
desired one.

Captured below some performance numbers with these performance modes.
4k Random Read IO performance numbers on 24 SAS SSD drives for above three
permormance modes. Performance data is from Intel Skylake and HGST SS300
(drive model SDLL1DLR400GCCA1).

IOPs:
 -----------------------------------------------------------------------
  |perf_mode    | qd = 1 | qd = 64 |   note                             |
  |-------------|--------|---------|-------------------------------------
  |balanced     |  259K  |  3061k  | Provides max performance numbers   |
  |             |        |         | both on lower QD workload &        |
  |             |        |         | also on higher QD workload         |
  |-------------|--------|---------|-------------------------------------
  |iops         |  220K  |  3100k  | Provides max performance numbers   |
  |             |        |         | only on higher QD workload.        |
  |-------------|--------|---------|-------------------------------------
  |latency      |  246k  |  2226k  | Provides good performance numbers  |
  |             |        |         | only on lower QD worklaod.         |
  -----------------------------------------------------------------------

Average Latency:
  -----------------------------------------------------
  |perf_mode    |  qd = 1      |    qd = 64           |
  |-------------|--------------|----------------------|
  |balanced     |  92.05 usec  |    501.12 usec       |
  |-------------|--------------|----------------------|
  |iops         |  108.40 usec |    498.10 usec       |
  |-------------|--------------|----------------------|
  |latency      |  97.10 usec  |    689.26 usec       |
  -----------------------------------------------------

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        | 14 ++++++-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 61 +++++++++++++++++++++++++----
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 22 +++++++----
 3 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 3f4cb52..0b38691 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2256,6 +2256,18 @@ enum MR_PD_TYPE {
 #define MR_DEVICE_HIGH_IOPS_DEPTH	8
 #define MR_HIGH_IOPS_BATCH_COUNT	16
 
+enum MR_PERF_MODE {
+	MR_BALANCED_PERF_MODE		= 0,
+	MR_IOPS_PERF_MODE		= 1,
+	MR_LATENCY_PERF_MODE		= 2,
+};
+
+#define MEGASAS_PERF_MODE_2STR(mode) \
+		((mode) == MR_BALANCED_PERF_MODE ? "Balanced" : \
+		 (mode) == MR_IOPS_PERF_MODE ? "IOPs" : \
+		 (mode) == MR_LATENCY_PERF_MODE ? "Latency" : \
+		 "Unknown")
+
 struct megasas_instance {
 
 	unsigned int *reply_map;
@@ -2441,7 +2453,7 @@ struct megasas_instance {
 	bool support_seqnum_jbod_fp;
 	bool support_pci_lane_margining;
 	u8  low_latency_index_start;
-	bool balanced_mode;
+	int perf_mode;
 };
 
 struct MR_LD_VF_MAP {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index fec3e57..c698cb7 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -105,6 +105,19 @@ unsigned int scmd_timeout = MEGASAS_DEFAULT_CMD_TIMEOUT;
 module_param(scmd_timeout, int, 0444);
 MODULE_PARM_DESC(scmd_timeout, "scsi command timeout (10-90s), default 90s. See megasas_reset_timer.");
 
+int perf_mode = -1;
+module_param(perf_mode, int, 0444);
+MODULE_PARM_DESC(perf_mode, "Performance mode (only for Aero adapters), options:\n\t\t"
+		"0 - balanced: High iops and low latency queues are allocated &\n\t\t"
+		"interrupt coalescing is enabled only on high iops queues\n\t\t"
+		"1 - iops: High iops queues are not allocated &\n\t\t"
+		"interrupt coalescing is enabled on all queues\n\t\t"
+		"2 - latency: High iops queues are not allocated &\n\t\t"
+		"interrupt coalescing is disabled on all queues\n\t\t"
+		"On Intel architecture, default mode is 'balanced'\n\t\t"
+		"On other architectures, default mode is 'latency'"
+		);
+
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGASAS_VERSION);
 MODULE_AUTHOR("megaraidlinux.pdl@broadcom.com");
@@ -5472,7 +5485,7 @@ megasas_setup_irqs_ioapic(struct megasas_instance *instance)
 				__func__, __LINE__);
 		return -1;
 	}
-	instance->balanced_mode = false;
+	instance->perf_mode = MR_LATENCY_PERF_MODE;
 	instance->low_latency_index_start = 0;
 	return 0;
 }
@@ -5683,7 +5696,7 @@ megasas_set_high_iops_queue_affinity_hint(struct megasas_instance *instance)
 	int i;
 	int local_numa_node;
 
-	if (instance->balanced_mode) {
+	if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
 		local_numa_node = dev_to_node(&instance->pdev->dev);
 
 		for (i = 0; i < instance->low_latency_index_start; i++)
@@ -5726,11 +5739,12 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 
 	i = __megasas_alloc_irq_vectors(instance);
 
-	if (instance->balanced_mode && (i != instance->msix_vectors)) {
+	if ((instance->perf_mode == MR_BALANCED_PERF_MODE) &&
+		(i != instance->msix_vectors)) {
 		if (instance->msix_vectors)
 			pci_free_irq_vectors(instance->pdev);
 		/*Disable Balanced IOPs mode and try realloc vectors*/
-		instance->balanced_mode = false;
+		instance->perf_mode = MR_LATENCY_PERF_MODE;
 		instance->low_latency_index_start = 1;
 		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
 
@@ -5774,6 +5788,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	struct fusion_context *fusion;
 	bool intr_coalescing;
 	unsigned int num_msix_req;
+	u16 lnksta, speed;
 
 	fusion = instance->ctrl_context;
 
@@ -5983,11 +5998,43 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		if (intr_coalescing &&
 			(num_online_cpus() >= MR_HIGH_IOPS_QUEUE_COUNT) &&
 			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
-			instance->balanced_mode = true;
+			instance->perf_mode = MR_BALANCED_PERF_MODE;
 		else
-			instance->balanced_mode = false;
+			instance->perf_mode = MR_LATENCY_PERF_MODE;
+
+
+		if (instance->adapter_type == AERO_SERIES) {
+			pcie_capability_read_word(instance->pdev, PCI_EXP_LNKSTA, &lnksta);
+			speed = lnksta & PCI_EXP_LNKSTA_CLS;
+
+			/*
+			 * For Aero, if PCIe link speed is <16 GT/s, then driver should operate
+			 * in latency perf mode and enable R1 PCI bandwidth algorithm
+			 */
+			if (speed < 0x4) {
+				instance->perf_mode = MR_LATENCY_PERF_MODE;
+				fusion->pcie_bw_limitation = true;
+			}
+
+			/*
+			 * Performance mode settings provided through module parameter-perf_mode will
+			 * take affect only for:
+			 * 1. Aero family of adapters.
+			 * 2. When user sets module parameter- perf_mode in range of 0-2.
+			 */
+			if ((perf_mode >= MR_BALANCED_PERF_MODE) &&
+				(perf_mode <= MR_LATENCY_PERF_MODE))
+				instance->perf_mode = perf_mode;
+			/*
+			 * If intr coalescing is not supported by controller FW, then IOPs
+			 * and Balanced modes are not feasible.
+			 */
+				if (!intr_coalescing)
+					instance->perf_mode = MR_LATENCY_PERF_MODE;
+
+		}
 
-		if (instance->balanced_mode)
+		if (instance->perf_mode == MR_BALANCED_PERF_MODE)
 			instance->low_latency_index_start =
 				MR_HIGH_IOPS_QUEUE_COUNT;
 		else
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 8a692b4..44f8556 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1097,10 +1097,10 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 
 	if ((instance->low_latency_index_start ==
 		MR_HIGH_IOPS_QUEUE_COUNT) && cur_intr_coalescing)
-		instance->balanced_mode = true;
+		instance->perf_mode = MR_BALANCED_PERF_MODE;
 
-	dev_info(&instance->pdev->dev, "Balanced mode :%s\n",
-		instance->balanced_mode ? "Yes" : "No");
+	dev_info(&instance->pdev->dev, "Performance mode :%s\n",
+		MEGASAS_PERF_MODE_2STR(instance->perf_mode));
 
 	instance->fw_sync_cache_support = (scratch_pad_1 &
 		MR_CAN_HANDLE_SYNC_CACHE_OFFSET) ? 1 : 0;
@@ -1190,9 +1190,17 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 	 * Each bit in replyqueue_mask represents one group of MSI-x vectors
 	 * (each group has 8 vectors)
 	 */
-	if (instance->balanced_mode)
+	switch (instance->perf_mode) {
+	case MR_BALANCED_PERF_MODE:
 		init_frame->replyqueue_mask =
-		       cpu_to_le16(~(~0 << instance->low_latency_index_start / 8));
+		       cpu_to_le16(~(~0 << instance->low_latency_index_start/8));
+		break;
+	case MR_IOPS_PERF_MODE:
+		init_frame->replyqueue_mask =
+		       cpu_to_le16(~(~0 << instance->msix_vectors/8));
+		break;
+	}
+
 
 	req_desc.u.low = cpu_to_le32(lower_32_bits(cmd->frame_phys_addr));
 	req_desc.u.high = cpu_to_le32(upper_32_bits(cmd->frame_phys_addr));
@@ -2833,7 +2841,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			fp_possible = (io_info.fpOkForIo > 0) ? true : false;
 	}
 
-	if (instance->balanced_mode &&
+	if ((instance->perf_mode == MR_BALANCED_PERF_MODE) &&
 		atomic_read(&scp->device->device_busy) >
 		(io_info.data_arms * MR_DEVICE_HIGH_IOPS_DEPTH))
 		cmd->request_desc->SCSIIO.MSIxIndex =
@@ -3166,7 +3174,7 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
 
-	if (instance->balanced_mode &&
+	if ((instance->perf_mode == MR_BALANCED_PERF_MODE) &&
 		atomic_read(&scmd->device->device_busy) > MR_DEVICE_HIGH_IOPS_DEPTH)
 		cmd->request_desc->SCSIIO.MSIxIndex =
 			mega_mod64((atomic64_add_return(1, &instance->high_iops_outstanding) /
-- 
2.9.5

