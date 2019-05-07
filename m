Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27F168BD
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEGRGf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38706 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so8619985pgl.5
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u8gMjqTWnxht23RzyA+GGSQVrBkeigXH6VIN8FRlibA=;
        b=DO6M0YZbWcpF+ZE4cCjQa71hdZLkVOkzQhXBR7JcKVHbcNjb8v5zhj2+mInHKFmAdP
         Be9yBcBF7ku7ckQHbvwTrerqFyuglhrNuYqpbbjcDUzP66Zij54H8uXjMf2voBjRIFlA
         2OpfxZ87OQZz5bikk9casEDZjqyclPOrVwYM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u8gMjqTWnxht23RzyA+GGSQVrBkeigXH6VIN8FRlibA=;
        b=XyLi0K37ifO+HqwkxIzUSlFywIZWaEcC+lwDN+IYu34eufgsj84GhvYRMUYfGISU+y
         0tThJTxGmIGZi9ZuP8o9xEmoF8Th7SBLJ7RGIqLnXqhz9H7X4m/hAxbcQi1BQ6kV0R/3
         hBtHOUfNOQ1KqJ3peyyNCIt+yznpdDdVX5utNwzPH+ZSA4W/oxWGQIYNqcnYbIoIsuuy
         Sk90gzZ4pyt7bgVAwW7AMkP9sx4D7cXER9+c5bHxb0RC7Nxk8WokE9lSjnyP2FT+AIHH
         Sl7erhqYSGffAZWD42PeFvpnR2gfh8V9Z38NLEx09G+0d/7RKlHq2XDpzV1ZneiOdlce
         N/rA==
X-Gm-Message-State: APjAAAUbY3+rfgkI2iK9POnIqaqDTethAhrmb1upm6FUX4IFkxhPTQZ/
        od9uAxpjWZaRymiklABpds/1pwST/vcvQPSZAf8HZ3udPVZAv6y8o1B9P0K0Gv8X65CZgMPpARy
        WIOqG8kBaiAZ+rM++JpFFyBbitsUwrFzpGLVP2B4qLkXFwD0yv3t5vWlg5jNk5vihBHulDyMllg
        SuVjTcIsHKEqqj/gJm4SnG
X-Google-Smtp-Source: APXvYqzQRDOtH8oGzFuNvsvQbwaYXf6wjqFxW8SmErYD/+7rMHRIsroEbkbGP4CKPG/evw9kPHZkwQ==
X-Received: by 2002:a63:f707:: with SMTP id x7mr40264640pgh.343.1557248793837;
        Tue, 07 May 2019 10:06:33 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:32 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 07/21] megaraid_sas: Load balance completions across all MSIx
Date:   Tue,  7 May 2019 10:05:36 -0700
Message-Id: <1557248750-4099-8-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Driver will use "reply descriptor post queues" in round robin fashion
when the combined MSI-x mode is not enabled. With this IO completions
are distributed and loadbalanced across all the available reply
descriptor post queues equally.

This is enabled only if combined MSI-x mode is not enabled in firmware.
This improves performance and also fixes soft lockups.

When load balancing is enabled, IRQ affinity from driver needs to be
disabled.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  3 +++
 drivers/scsi/megaraid/megaraid_sas_base.c   | 22 ++++++++++++++++++----
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 18 ++++++++++++++----
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 8d6a9c511455..6be748f302cf 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2262,6 +2262,7 @@ struct megasas_instance {
 	u32 secure_jbod_support;
 	u32 support_morethan256jbod; /* FW support for more than 256 PD/JBOD */
 	bool use_seqnum_jbod_fp;   /* Added for PD sequence */
+	bool smp_affinity_enable;
 	spinlock_t crashdump_lock;
 
 	struct megasas_register_set __iomem *reg_set;
@@ -2279,6 +2280,7 @@ struct megasas_instance {
 	u16 ldio_threshold;
 	u16 cur_can_queue;
 	u32 max_sectors_per_req;
+	bool msix_load_balance;
 	struct megasas_aen_event *ev;
 
 	struct megasas_cmd **cmd_list;
@@ -2316,6 +2318,7 @@ struct megasas_instance {
 	atomic_t sge_holes_type1;
 	atomic_t sge_holes_type2;
 	atomic_t sge_holes_type3;
+	atomic64_t total_io_count;
 
 	struct megasas_instance_template *instancet;
 	struct tasklet_struct isr_tasklet;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index f7ffa72e9572..102a7e40996e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5350,6 +5350,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 					 &instance->irq_context[j]);
 			/* Retry irq register for IO_APIC*/
 			instance->msix_vectors = 0;
+			instance->msix_load_balance = false;
 			if (is_probe) {
 				pci_free_irq_vectors(instance->pdev);
 				return megasas_setup_irqs_ioapic(instance);
@@ -5358,6 +5359,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 			}
 		}
 	}
+
 	return 0;
 }
 
@@ -5661,6 +5663,12 @@ static int megasas_init_fw(struct megasas_instance *instance)
 				if (rdpq_enable)
 					instance->is_rdpq = (scratch_pad_1 & MR_RDPQ_MODE_OFFSET) ?
 								1 : 0;
+
+				if (!instance->msix_combined) {
+					instance->msix_load_balance = true;
+					instance->smp_affinity_enable = false;
+				}
+
 				fw_msix_count = instance->msix_vectors;
 				/* Save 1-15 reply post index address to local memory
 				 * Index 0 is already saved from reg offset
@@ -5679,17 +5687,20 @@ static int megasas_init_fw(struct megasas_instance *instance)
 					instance->msix_vectors);
 		} else /* MFI adapters */
 			instance->msix_vectors = 1;
+
 		/* Don't bother allocating more MSI-X vectors than cpus */
 		instance->msix_vectors = min(instance->msix_vectors,
 					     (unsigned int)num_online_cpus());
-		if (smp_affinity_enable)
+		if (instance->smp_affinity_enable)
 			irq_flags |= PCI_IRQ_AFFINITY;
 		i = pci_alloc_irq_vectors(instance->pdev, 1,
 					  instance->msix_vectors, irq_flags);
-		if (i > 0)
+		if (i > 0) {
 			instance->msix_vectors = i;
-		else
+		} else {
 			instance->msix_vectors = 0;
+			instance->msix_load_balance = false;
+		}
 	}
 	/*
 	 * MSI-X host index 0 is common for all adapter.
@@ -6797,6 +6808,7 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	INIT_LIST_HEAD(&instance->internal_reset_pending_q);
 
 	atomic_set(&instance->fw_outstanding, 0);
+	atomic64_set(&instance->total_io_count, 0);
 
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
@@ -6819,6 +6831,8 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	instance->last_time = 0;
 	instance->disableOnlineCtrlReset = 1;
 	instance->UnevenSpanSupport = 0;
+	instance->smp_affinity_enable = smp_affinity_enable ? true : false;
+	instance->msix_load_balance = false;
 
 	if (instance->adapter_type != MFI_SERIES)
 		INIT_WORK(&instance->work_init, megasas_fusion_ocr_wq);
@@ -7182,7 +7196,7 @@ megasas_resume(struct pci_dev *pdev)
 	/* Now re-enable MSI-X */
 	if (instance->msix_vectors) {
 		irq_flags = PCI_IRQ_MSIX;
-		if (smp_affinity_enable)
+		if (instance->smp_affinity_enable)
 			irq_flags |= PCI_IRQ_AFFINITY;
 	}
 	rval = pci_alloc_irq_vectors(instance->pdev, 1,
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 51ee6439ebbd..ef0b15e4de2d 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2769,8 +2769,13 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			fp_possible = (io_info.fpOkForIo > 0) ? true : false;
 	}
 
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+	if (instance->msix_load_balance)
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
+				    instance->msix_vectors));
+	else
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			instance->reply_map[raw_smp_processor_id()];
 
 	if (instance->adapter_type >= VENTURA_SERIES) {
 		/* FP for Optimal raid level 1.
@@ -3083,8 +3088,13 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
 
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+	if (instance->msix_load_balance)
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
+				    instance->msix_vectors));
+	else
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			instance->reply_map[raw_smp_processor_id()];
 
 	if (!fp_possible) {
 		/* system pd firmware path */
-- 
2.16.1

