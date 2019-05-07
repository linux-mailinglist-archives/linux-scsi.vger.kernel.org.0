Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8C168BC
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfEGRGc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41921 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so4909746pgp.8
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jEUYs8mQo5FFKhRrErQjGPLFPPXA93Wv710nOJGG2/E=;
        b=B45ge17rhpxjr/7ywo94s8c7dkOpHcDjrh2P+qlL5oHz/wR2VpmSr5rVRHsp5PWlyU
         Zqmrmu4vxmVP9q8Q9UsFLsS0SQWBrPB0EmevmmESXhqc1jAyQLv0EtIVVa309bjBGFiM
         pK6dSphhlEB/bKis68PrUxaRVWvgLQuxlkPGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jEUYs8mQo5FFKhRrErQjGPLFPPXA93Wv710nOJGG2/E=;
        b=LCeBILhuEPzc9rHi6swZ6i/Ivqp/Ix52bU9wx7NHm3p6GpBDqGUjXSXRSXJMyf6M3K
         J+0MXOAE4KA+kwWMTn+2Co4x+wDgzDBP+OKA9tFWbGAUFO0Jk44Jgm14ykcL1aPKxBFP
         U9fLz58gBeWVW+0OCu3DEqephs5aN7iC29tXxup6+1fm6tHUj5pwoOi+iB63xZyaX4lJ
         tV9fiaLwS2J2REq1ufjoGgvm5jBFkxV4SNP9P27ItqlCiYb7Tgf9iRWw5j/ZVaRvKx/v
         DSecsBuZW8O4U1ATuJuOXJxD3c2tuD3Xdaxtazs7Rn0wxTLoMQsw/32XORR9N6xc66hk
         Bj1Q==
X-Gm-Message-State: APjAAAVfzkMuhcCtV6sWPQgprZCFh9YO787/N7cK5ljk7PY1ANsfd1ln
        cz38lYyEjMy22KJnpmcH3GuB6AgaQ4fHtb9brjHI7JU0yajGY9Q/uVcBgKiiKyj8VGab/mzl86h
        rVGPs2nsIp6x6FIaAwLHQ6XgdINxMY9pk5SbocdkKvTqUsxDhqJVr+f1OEHrBgoMR0Cn2jzgQ6c
        dRVVHrOqZAOMx174HNgewZ
X-Google-Smtp-Source: APXvYqxB+QimV9oYpU69xKoWP5pkqLIc+wUDoG1lkqzYbQfQonG8Hx8xbafyvZHVFFO+CvmnReN51w==
X-Received: by 2002:a63:e417:: with SMTP id a23mr25903100pgi.224.1557248790306;
        Tue, 07 May 2019 10:06:30 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:29 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 06/21] megaraid_sas: IRQ poll to avoid CPU hard lockups
Date:   Tue,  7 May 2019 10:05:35 -0700
Message-Id: <1557248750-4099-7-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Issue Description:
We have seen cpu lock up issues from field if system has greater
(more than 96) logical cpu count.
SAS3.0 controller (Invader series) supports at max 96 msix vector and
SAS3.5 product (Ventura) supports at max 128 msix vectors.

This may be a generic issue (if PCI device support completion on multiple
reply queues).
Let me explain it w.r.t megaraid_sas supported h/w just to simplify the
problem and possible changes to handle such issues.
MegaRAID controller supports multiple reply queues in completion path.
Driver creates MSI-x vectors for controller as
"minimum of (FW supported Reply queues, Logical CPUs)".
If submitter is not interrupted via completion on same CPU, there is a loop
in the IO path. This behavior can cause hard/soft CPU lockups, IO timeout,
system sluggish etc.

Example - one CPU (e.g. CPU A) is busy submitting the IOs and
another CPU (e.g. CPU B) is busy with processing the corresponding
IO's reply descriptors from reply descriptor queue upon receiving the
interrupts from HBA.
If CPU A is continuously pumping the IOs then always CPU B (which is
executing the ISR) will see the valid reply descriptors in the
reply descriptor queue and it will be continuously processing those
reply descriptor in a loop without quitting the ISR handler.

megaraid_sas driver will exit ISR handler if it finds unused
reply descriptor in the reply descriptor queue.
Since CPU A will be continuously sending the IOs, CPU B may always see
a valid reply descriptor (posted by HBA Firmware after processing the IO)
in the reply descriptor queue. In worst case, driver will not quit from
this loop in the ISR handler.
Eventually, CPU lockup will be detected by watchdog.

Above mentioned behavior is not common if "rq_affinity" set to 2 or
affinity_hint is honored by irqbalancer as "exact".
If rq_affinity is set to 2, submitter will be always
interrupted via completion on same CPU.
If irqbalancer is using "exact" policy, interrupt will be delivered to
submitter CPU.

Problem statement -
If CPU count to MSI-X vectors (reply descriptor Queues) count ratio is
not 1:1, we still have exposure of issue explained above and for that
we don't have any solution.

Exposure of soft/hard lockup is seen if CPU count is more than MSI-x
supported by device.

If CPUs count to MSI-x vectors count ratio is not 1:1, (Other way, if
CPU counts to MSI-x vector count ratio is something like X:1, where X > 1)
then 'exact' irqbalance policy OR rq_affinity = 2 won't help to avoid CPU
hard/soft lockups. There won't be any one to one mapping between
CPU to MSI-x vector instead one MSI-x interrupt (or reply descriptor queue)
is shared with group/set of CPUs and there is a possibility of having a
loop in the IO path within that CPU group and may observe lockups.

For example: Consider a system having two NUMA nodes and each node having
four logical CPUs and also consider that number of MSI-x vectors enabled on
the HBA is two, then CPUs count to MSI-x vector count ratio as 4:1.
e.g.
MSIx vector 0 is affinity to CPU 0, CPU 1, CPU 2 & CPU 3 of NUMA node 0 and
MSIx vector 1 is affinity to CPU 4, CPU 5, CPU 6 & CPU 7 of NUMA node 1.

numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3                 --> MSI-x 0
node 0 size: 65536 MB
node 0 free: 63176 MB
node 1 cpus: 4 5 6 7                 --> MSI-x 1
node 1 size: 65536 MB
node 1 free: 63176 MB

Assume that user started an application which uses all the CPUs of NUMA
node 0 for issuing the IOs.
Only one CPU from affinity list (it can be any cpu since this behavior
depends upon irqbalance) CPU0 will receive the interrupts from MSIx 0
for all the IOs. Eventually, CPU 0 IO submission percentage will be
decreasing and ISR processing percentage will be increasing as it is more
busy with processing the interrupts.
Gradually IO submission percentage on CPU 0 will be zero
and it's ISR processing percentage will be 100 percentage as
IO loop has already formed within the NUMA node 0,
i.e. CPU 1, CPU 2 & CPU 3 will be continuously busy with
submitting the heavy IOs and only CPU 0 is busy in the ISR path as it
always find the valid reply descriptor in the reply descriptor queue.
Eventually, we will observe the hard lockup here.

Chances of occurring of hard/soft lockups are directly proportional to
value of X. If value of X is high, then chances of observing CPU lockups
is high.

Solution -
Fix - Use IRQ poll interface defined in "irq_poll.c".
megaraid_sas driver will execute ISR routine in Softirq context and it will
always quit the loop based on budget provided in IRQ poll interface.
Driver will switch to IRQ poll only when more than a threshold number of
reply descriptors are handled in one ISR. Currently threshold is set as
1/4th of HBA queue depth.

In these scenarios (i.e. where CPUs count to MSI-X vectors count ratio is
X:1 (where X >  1)), IRQ poll interface will avoid CPU hard lockups due to
voluntary exit from the reply queue processing based on budget.
Note - Only one MSI-x vector is busy doing processing.

Select CONFIG_IRQ_POLL from driver Kconfig for driver compilation.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
Changes in v2:
Make megasas_enable_irq_poll static as reported by kbuild test robot

 drivers/scsi/megaraid/Kconfig.megaraid      |   1 +
 drivers/scsi/megaraid/megaraid_sas.h        |   5 ++
 drivers/scsi/megaraid/megaraid_sas_base.c   |  36 ++++++++
 drivers/scsi/megaraid/megaraid_sas_fp.c     |   1 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 122 +++++++++++++++++++++-------
 drivers/scsi/megaraid/megaraid_sas_fusion.h |   1 -
 6 files changed, 136 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/megaraid/Kconfig.megaraid b/drivers/scsi/megaraid/Kconfig.megaraid
index 17419e30ffc8..1fa9d095ae36 100644
--- a/drivers/scsi/megaraid/Kconfig.megaraid
+++ b/drivers/scsi/megaraid/Kconfig.megaraid
@@ -78,6 +78,7 @@ config MEGARAID_LEGACY
 config MEGARAID_SAS
 	tristate "LSI Logic MegaRAID SAS RAID Module"
 	depends on PCI && SCSI
+	select IRQ_POLL
 	help
 	Module for LSI Logic's SAS based RAID controllers.
 	To compile this driver as a module, choose 'm' here.
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 990ee23d7bc2..8d6a9c511455 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2173,6 +2173,9 @@ struct megasas_aen_event {
 struct megasas_irq_context {
 	struct megasas_instance *instance;
 	u32 MSIxIndex;
+	u32 os_irq;
+	struct irq_poll irqpoll;
+	bool irq_poll_scheduled;
 };
 
 struct MR_DRV_SYSTEM_INFO {
@@ -2303,6 +2306,7 @@ struct megasas_instance {
 	struct pci_dev *pdev;
 	u32 unique_id;
 	u32 fw_support_ieee;
+	u32 threshold_reply_count;
 
 	atomic_t fw_outstanding;
 	atomic_t ldio_outstanding;
@@ -2639,4 +2643,5 @@ void megasas_set_dma_settings(struct megasas_instance *instance,
 int megasas_adp_reset_wait_for_ready(struct megasas_instance *instance,
 				     bool do_adp_reset,
 				     int ocr_context);
+int megasas_irqpoll(struct irq_poll *irqpoll, int budget);
 #endif				/*LSI_MEGARAID_SAS_H */
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 5e5170b40f6f..f7ffa72e9572 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -48,6 +48,7 @@
 #include <linux/mutex.h>
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
+#include <linux/irq_poll.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -5272,6 +5273,25 @@ megasas_init_adapter_mfi(struct megasas_instance *instance)
 	return 1;
 }
 
+static
+void megasas_setup_irq_poll(struct megasas_instance *instance)
+{
+	struct megasas_irq_context *irq_ctx;
+	u32 count, i;
+
+	count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
+
+	/* Initialize IRQ poll */
+	for (i = 0; i < count; i++) {
+		irq_ctx = &instance->irq_context[i];
+		irq_ctx->os_irq = pci_irq_vector(instance->pdev, i);
+		irq_ctx->irq_poll_scheduled = false;
+		irq_poll_init(&irq_ctx->irqpoll,
+			      instance->threshold_reply_count,
+			      megasas_irqpoll);
+	}
+}
+
 /*
  * megasas_setup_irqs_ioapic -		register legacy interrupts.
  * @instance:				Adapter soft state
@@ -5350,6 +5370,16 @@ static void
 megasas_destroy_irqs(struct megasas_instance *instance) {
 
 	int i;
+	int count;
+	struct megasas_irq_context *irq_ctx;
+
+	count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
+	if (instance->adapter_type != MFI_SERIES) {
+		for (i = 0; i < count; i++) {
+			irq_ctx = &instance->irq_context[i];
+			irq_poll_disable(&irq_ctx->irqpoll);
+		}
+	}
 
 	if (instance->msix_vectors)
 		for (i = 0; i < instance->msix_vectors; i++) {
@@ -5722,6 +5752,9 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		megasas_setup_irqs_ioapic(instance))
 		goto fail_init_adapter;
 
+	if (instance->adapter_type != MFI_SERIES)
+		megasas_setup_irq_poll(instance);
+
 	instance->instancet->enable_intr(instance);
 
 	dev_info(&instance->pdev->dev, "INIT adapter done\n");
@@ -7187,6 +7220,9 @@ megasas_resume(struct pci_dev *pdev)
 			megasas_setup_irqs_ioapic(instance))
 		goto fail_init_mfi;
 
+	if (instance->adapter_type != MFI_SERIES)
+		megasas_setup_irq_poll(instance);
+
 	/* Re-launch SR-IOV heartbeat timer */
 	if (instance->requestorId) {
 		if (!megasas_sriov_start_heartbeat(instance, 0))
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 87c2c0472c8f..9ac357619b28 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -45,6 +45,7 @@
 #include <linux/compat.h>
 #include <linux/blkdev.h>
 #include <linux/poll.h>
+#include <linux/irq_poll.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 59bab98274f6..51ee6439ebbd 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -47,6 +47,7 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
+#include <linux/irq_poll.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -1789,6 +1790,7 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
 
 	instance->flag_ieee = 1;
 	instance->r1_ldio_hint_default =  MR_R1_LDIO_PIGGYBACK_DEFAULT;
+	instance->threshold_reply_count = instance->max_fw_cmds / 4;
 	fusion->fast_path_io = 0;
 
 	if (megasas_allocate_raid_maps(instance))
@@ -3422,7 +3424,8 @@ megasas_complete_r1_command(struct megasas_instance *instance,
  * Completes all commands that is in reply descriptor queue
  */
 int
-complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex)
+complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
+		    struct megasas_irq_context *irq_context)
 {
 	union MPI2_REPLY_DESCRIPTORS_UNION *desc;
 	struct MPI2_SCSI_IO_SUCCESS_REPLY_DESCRIPTOR *reply_desc;
@@ -3555,7 +3558,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex)
 		 * number of reply counts and still there are more replies in reply queue
 		 * pending to be completed
 		 */
-		if (threshold_reply_count >= THRESHOLD_REPLY_COUNT) {
+		if (threshold_reply_count >= instance->threshold_reply_count) {
 			if (instance->msix_combined)
 				writel(((MSIxIndex & 0x7) << 24) |
 					fusion->last_reply_idx[MSIxIndex],
@@ -3565,23 +3568,46 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex)
 					fusion->last_reply_idx[MSIxIndex],
 					instance->reply_post_host_index_addr[0]);
 			threshold_reply_count = 0;
+			if (irq_context) {
+				if (!irq_context->irq_poll_scheduled) {
+					irq_context->irq_poll_scheduled = true;
+					disable_irq_nosync(irq_context->os_irq);
+					irq_poll_sched(&irq_context->irqpoll);
+				}
+				return num_completed;
+			}
 		}
 	}
 
-	if (!num_completed)
-		return IRQ_NONE;
+	if (num_completed) {
+		wmb();
+		if (instance->msix_combined)
+			writel(((MSIxIndex & 0x7) << 24) |
+				fusion->last_reply_idx[MSIxIndex],
+				instance->reply_post_host_index_addr[MSIxIndex/8]);
+		else
+			writel((MSIxIndex << 24) |
+				fusion->last_reply_idx[MSIxIndex],
+				instance->reply_post_host_index_addr[0]);
+		megasas_check_and_restore_queue_depth(instance);
+	}
+	return num_completed;
+}
 
-	wmb();
-	if (instance->msix_combined)
-		writel(((MSIxIndex & 0x7) << 24) |
-			fusion->last_reply_idx[MSIxIndex],
-			instance->reply_post_host_index_addr[MSIxIndex/8]);
-	else
-		writel((MSIxIndex << 24) |
-			fusion->last_reply_idx[MSIxIndex],
-			instance->reply_post_host_index_addr[0]);
-	megasas_check_and_restore_queue_depth(instance);
-	return IRQ_HANDLED;
+/**
+ * megasas_enable_irq_poll() - enable irqpoll
+ */
+static void megasas_enable_irq_poll(struct megasas_instance *instance)
+{
+	u32 count, i;
+	struct megasas_irq_context *irq_ctx;
+
+	count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
+
+	for (i = 0; i < count; i++) {
+		irq_ctx = &instance->irq_context[i];
+		irq_poll_enable(&irq_ctx->irqpoll);
+	}
 }
 
 /**
@@ -3593,11 +3619,46 @@ void megasas_sync_irqs(unsigned long instance_addr)
 	u32 count, i;
 	struct megasas_instance *instance =
 		(struct megasas_instance *)instance_addr;
+	struct megasas_irq_context *irq_ctx;
 
 	count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
 
-	for (i = 0; i < count; i++)
+	for (i = 0; i < count; i++) {
 		synchronize_irq(pci_irq_vector(instance->pdev, i));
+		irq_ctx = &instance->irq_context[i];
+		irq_poll_disable(&irq_ctx->irqpoll);
+		if (irq_ctx->irq_poll_scheduled) {
+			irq_ctx->irq_poll_scheduled = false;
+			enable_irq(irq_ctx->os_irq);
+		}
+	}
+}
+
+/**
+ * megasas_irqpoll() - process a queue for completed reply descriptors
+ * @irqpoll:	IRQ poll structure associated with queue to poll.
+ * @budget:	Threshold of reply descriptors to process per poll.
+ *
+ * Return: The number of entries processed.
+ */
+
+int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
+{
+	struct megasas_irq_context *irq_ctx;
+	struct megasas_instance *instance;
+	int num_entries;
+
+	irq_ctx = container_of(irqpoll, struct megasas_irq_context, irqpoll);
+	instance = irq_ctx->instance;
+
+	num_entries = complete_cmd_fusion(instance, irq_ctx->MSIxIndex, irq_ctx);
+	if (num_entries < budget) {
+		irq_poll_complete(irqpoll);
+		irq_ctx->irq_poll_scheduled = false;
+		enable_irq(irq_ctx->os_irq);
+	}
+
+	return num_entries;
 }
 
 /**
@@ -3620,7 +3681,7 @@ megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
 		return;
 
 	for (MSIxIndex = 0 ; MSIxIndex < count; MSIxIndex++)
-		complete_cmd_fusion(instance, MSIxIndex);
+		complete_cmd_fusion(instance, MSIxIndex, NULL);
 }
 
 /**
@@ -3647,7 +3708,8 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
 		return IRQ_HANDLED;
 	}
 
-	return complete_cmd_fusion(instance, irq_context->MSIxIndex);
+	return complete_cmd_fusion(instance, irq_context->MSIxIndex, irq_context)
+			? IRQ_HANDLED : IRQ_NONE;
 }
 
 /**
@@ -4334,6 +4396,7 @@ megasas_issue_tm(struct megasas_instance *instance, u16 device_handle,
 			instance->instancet->disable_intr(instance);
 			megasas_sync_irqs((unsigned long)instance);
 			instance->instancet->enable_intr(instance);
+			megasas_enable_irq_poll(instance);
 			if (scsi_lookup->scmd == NULL)
 				break;
 		}
@@ -4347,6 +4410,7 @@ megasas_issue_tm(struct megasas_instance *instance, u16 device_handle,
 		megasas_sync_irqs((unsigned long)instance);
 		rc = megasas_track_scsiio(instance, id, channel);
 		instance->instancet->enable_intr(instance);
+		megasas_enable_irq_poll(instance);
 
 		break;
 	case MPI2_SCSITASKMGMT_TASKTYPE_ABRT_TASK_SET:
@@ -4735,10 +4799,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 			dev_warn(&instance->pdev->dev, "Reset not supported"
 			       ", killing adapter scsi%d.\n",
 				instance->host->host_no);
-			megaraid_sas_kill_hba(instance);
-			instance->skip_heartbeat_timer_del = 1;
-			retval = FAILED;
-			goto out;
+			goto kill_hba;
 		}
 
 		/* Let SR-IOV VF & PF sync up if there was a HB failure */
@@ -4776,9 +4837,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 				dev_info(&instance->pdev->dev,
 					"Failed from %s %d\n",
 					__func__, __LINE__);
-				megaraid_sas_kill_hba(instance);
-				retval = FAILED;
-				goto out;
+				goto kill_hba;
 			}
 
 			megasas_refire_mgmt_cmd(instance);
@@ -4807,7 +4866,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 			clear_bit(MEGASAS_FUSION_IN_RESET,
 				  &instance->reset_flags);
 			instance->instancet->enable_intr(instance);
-
+			megasas_enable_irq_poll(instance);
 			shost_for_each_device(sdev, shost) {
 				if ((instance->tgt_prop) &&
 				    (instance->nvme_page_size))
@@ -4858,9 +4917,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 		/* Reset failed, kill the adapter */
 		dev_warn(&instance->pdev->dev, "Reset failed, killing "
 		       "adapter scsi%d.\n", instance->host->host_no);
-		megaraid_sas_kill_hba(instance);
-		instance->skip_heartbeat_timer_del = 1;
-		retval = FAILED;
+		goto kill_hba;
 	} else {
 		/* For VF: Restart HB timer if we didn't OCR */
 		if (instance->requestorId) {
@@ -4868,8 +4925,15 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 		}
 		clear_bit(MEGASAS_FUSION_IN_RESET, &instance->reset_flags);
 		instance->instancet->enable_intr(instance);
+		megasas_enable_irq_poll(instance);
 		atomic_set(&instance->adprecovery, MEGASAS_HBA_OPERATIONAL);
+		goto out;
 	}
+kill_hba:
+	megaraid_sas_kill_hba(instance);
+	megasas_enable_irq_poll(instance);
+	instance->skip_heartbeat_timer_del = 1;
+	retval = FAILED;
 out:
 	clear_bit(MEGASAS_FUSION_IN_RESET, &instance->reset_flags);
 	mutex_unlock(&instance->reset_mutex);
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index 1481bf029490..160ac16941fe 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -100,7 +100,6 @@ enum MR_RAID_FLAGS_IO_SUB_TYPE {
 
 #define MEGASAS_FP_CMD_LEN	16
 #define MEGASAS_FUSION_IN_RESET 0
-#define THRESHOLD_REPLY_COUNT 50
 #define RAID_1_PEER_CMDS 2
 #define JBOD_MAPS_COUNT	2
 #define MEGASAS_REDUCE_QD_COUNT 64
-- 
2.16.1

