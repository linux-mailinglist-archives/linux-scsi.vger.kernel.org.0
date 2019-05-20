Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30A92314C
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfETK0i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33663 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETK0i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so6606126pgv.0
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ix+paT5CCN4r4hkS6QQBQqaPodiZcvpgrB/dNlbOBAE=;
        b=A8Z3hAhaeVmD9XMzNXCifxygro9lIwTBXZ0AC+s47GG6G36H5CeHYOhgDW4HFs7CYN
         PeEaav0MDDT48ergMDdexVxqltTQvHQpNxR/EBEbdgxsVjHXYEkT9OUX/AbRRhkKcOlw
         mtZvVOhpEJRKnLDw89cLea8elxOgzN7X1CDFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ix+paT5CCN4r4hkS6QQBQqaPodiZcvpgrB/dNlbOBAE=;
        b=UmwtUNNBQfq7QRrYJs/tsE7pe7bWP2sk2+gsJgdEQeBCcMxlTxu18r0/CcCjEIDnHT
         4r2lKs3gkH44dZ94au9lxu9TbpGzYQv9euRAO8IW6XIqEybM/11BwLEMjJGrhkeevv3X
         bLhgqDdKg8EWiQ9kT1kSKNO2B+xcLyr1qR/F3gVbEBS0A4Zp+tVWeVNAOGdhF9FKM0UP
         aog/2D62goPcPFj1d0ZCLkBj57xJgrpPg2RWyDLP7wBo3iOMXgCCpo/aQ/nTTAhq7j46
         EorhFfRb2EHpXZRR9J3jyldspuEypfsJR6AMh+EYD89yb6yTsRdUHmUAXISgGg1fLNOA
         KFMA==
X-Gm-Message-State: APjAAAUxxS9OavWoDbvg915GDhZLHcEazABAAVaM153A6/+5Bvz9Wxct
        KBzhZQT+19GhPkoTDCQrcGaDGSITD6TNvOK90mctYgxmhAeD+FqGoKr8OHq63rSIsH6JcFDJES/
        MdiYutuaIBC4DpeEcLTKwmfKXY5iR1/bTOjdO2iVLd/ABysMRP/AyjDuKyKgyyQBNA2zDVTQVKu
        oD8p6OUNNmR++yqXJo4w==
X-Google-Smtp-Source: APXvYqyEDDqYNljp1cEYh4LPm0lMZL1Zj0KgHm1iRGXaDaE6jxUjq7YQv4wIclvHab3RRvBVECPq4g==
X-Received: by 2002:a65:550b:: with SMTP id f11mr73786632pgr.311.1558347997170;
        Mon, 20 May 2019 03:26:37 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:36 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 07/10] mpt3sas: Affinity high iops queues IRQs to local node
Date:   Mon, 20 May 2019 06:26:01 -0400
Message-Id: <20190520102604.3466-8-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

High iops queues are mapped to non-managed irqs.
Set affinity of non-managed irqs to local numa node.
Low latency queues are mapped to managed irq.

Driver reserves some reply queues (pci_alloc_irq_vectors_affinity and
.pre_vectors interface is used to meet the goal) for max iops and rest
of queues for low latency. Based on io workload in io submission path
driver will decide which group of reply queues (either high iops queues
or low latency queues) to be used. High iops queues will be mapped to
local numa node of controller and low latency queues will be mapped to
cpus across numa nodes. In general, high iops queue and low latency
queue together should fit into 128 reply queue (max reply queue
supported by Aero/Sea).

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 73 +++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a23d257..6620c49 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2793,6 +2793,9 @@ _base_free_irq(struct MPT3SAS_ADAPTER *ioc)
 
 	list_for_each_entry_safe(reply_q, next, &ioc->reply_queue_list, list) {
 		list_del(&reply_q->list);
+		if (smp_affinity_enable)
+			irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
+			    reply_q->msix_index), NULL);
 		free_irq(pci_irq_vector(ioc->pdev, reply_q->msix_index),
 			 reply_q);
 		kfree(reply_q);
@@ -2857,6 +2860,7 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 {
 	unsigned int cpu, nr_cpus, nr_msix, index = 0;
 	struct adapter_reply_queue *reply_q;
+	int local_numa_node;
 
 	if (!_base_is_controller_msix_enabled(ioc))
 		return;
@@ -2875,13 +2879,32 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 		return;
 
 	if (smp_affinity_enable) {
+
+		/*
+		 * set irq affinity to local numa node for those irqs
+		 * corresponding to high iops queues.
+		 */
+		if (ioc->high_iops_queues) {
+			local_numa_node = dev_to_node(&ioc->pdev->dev);
+			for (index = 0; index < ioc->high_iops_queues;
+			    index++) {
+				irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
+				    index), cpumask_of_node(local_numa_node));
+			}
+		}
+
 		list_for_each_entry(reply_q, &ioc->reply_queue_list, list) {
-			const cpumask_t *mask = pci_irq_get_affinity(ioc->pdev,
-							reply_q->msix_index);
+			const cpumask_t *mask;
+
+			if (reply_q->msix_index < ioc->high_iops_queues)
+				continue;
+
+			mask = pci_irq_get_affinity(ioc->pdev,
+			    reply_q->msix_index);
 			if (!mask) {
 				ioc_warn(ioc, "no affinity for msi %x\n",
 					 reply_q->msix_index);
-				continue;
+				goto fall_back;
 			}
 
 			for_each_cpu_and(cpu, mask, cpu_online_mask) {
@@ -2892,12 +2915,18 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 		}
 		return;
 	}
+
+fall_back:
 	cpu = cpumask_first(cpu_online_mask);
+	nr_msix -= ioc->high_iops_queues;
+	index = 0;
 
 	list_for_each_entry(reply_q, &ioc->reply_queue_list, list) {
-
 		unsigned int i, group = nr_cpus / nr_msix;
 
+		if (reply_q->msix_index < ioc->high_iops_queues)
+			continue;
+
 		if (cpu >= nr_cpus)
 			break;
 
@@ -2950,11 +2979,38 @@ _base_disable_msix(struct MPT3SAS_ADAPTER *ioc)
 {
 	if (!ioc->msix_enable)
 		return;
-	pci_disable_msix(ioc->pdev);
+	pci_free_irq_vectors(ioc->pdev);
 	ioc->msix_enable = 0;
 }
 
 /**
+ * _base_alloc_irq_vectors - allocate msix vectors
+ * @ioc: per adapter object
+ *
+ */
+static int
+_base_alloc_irq_vectors(struct MPT3SAS_ADAPTER *ioc)
+{
+	int i, irq_flags = PCI_IRQ_MSIX;
+	struct irq_affinity desc = { .pre_vectors = ioc->high_iops_queues };
+	struct irq_affinity *descp = &desc;
+
+	if (smp_affinity_enable)
+		irq_flags |= PCI_IRQ_AFFINITY;
+	else
+		descp = NULL;
+
+	ioc_info(ioc, " %d %d\n", ioc->high_iops_queues,
+	    ioc->msix_vector_count);
+
+	i = pci_alloc_irq_vectors_affinity(ioc->pdev,
+	    ioc->high_iops_queues,
+	    ioc->msix_vector_count, irq_flags, descp);
+
+	return i;
+}
+
+/**
  * _base_enable_msix - enables msix, failback to io_apic
  * @ioc: per adapter object
  *
@@ -2965,7 +3021,6 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	int r;
 	int i, local_max_msix_vectors;
 	u8 try_msix = 0;
-	unsigned int irq_flags = PCI_IRQ_MSIX;
 
 	if (msix_disable == -1 || msix_disable == 0)
 		try_msix = 1;
@@ -2999,11 +3054,7 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	if (ioc->msix_vector_count < ioc->cpu_count)
 		smp_affinity_enable = 0;
 
-	if (smp_affinity_enable)
-		irq_flags |= PCI_IRQ_AFFINITY;
-
-	r = pci_alloc_irq_vectors(ioc->pdev, 1, ioc->reply_queue_count,
-				  irq_flags);
+	r = _base_alloc_irq_vectors(ioc);
 	if (r < 0) {
 		dfailprintk(ioc,
 			    ioc_info(ioc, "pci_alloc_irq_vectors failed (r=%d) !!!\n",
-- 
1.8.3.1

