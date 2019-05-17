Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA4421A2D
	for <lists+linux-scsi@lfdr.de>; Fri, 17 May 2019 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfEQO7i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 May 2019 10:59:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43364 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfEQO7h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 May 2019 10:59:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so3800735pfa.10
        for <linux-scsi@vger.kernel.org>; Fri, 17 May 2019 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fB3twfcFBG/KfIdlZg/4UAFvjWSsayAd/TaxU/bJfLU=;
        b=X7M6PkcI4TCIpEMM+HVbpEBYYtYqEKyGG7PD6R92B7Yxxvlf0PrhcEdrWBVmcHibpM
         AWB0cdh53lFU4Ek6adtXPq3Y3QWsHyHb35X6cLeJVy1aO6ClSJ1OqjENgwdvWYURjMy8
         FlExmH7u/JV1SBYkiKoOgivwFjXTSUmwoLs2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fB3twfcFBG/KfIdlZg/4UAFvjWSsayAd/TaxU/bJfLU=;
        b=ABryQ32gqtVSrpgDi8HLjAWtRG2ortO/izspBGhm8CU2lzeQ8iZiJXotQ3N2FBedhJ
         mSAr/chJ/Tle6sX9V5Sh5SNTNnDy+qKdGmc4Y83rfdGuSacX/fbiZyvRKZjjLgbO5cQL
         3FvBl9UHmB9Vzz4F/KU6i9/8mamh8EWhFmr8VYBa2IeeH26iL/dvuCgU/+ShZeHgFDsi
         ccVL1k2pgdLrxHSOLTS3AoQ9uh611YEIYzQ1Iuq1SZiNJcloVO3QsdFYK4ivAL/b58gz
         PquCwO1cEq9QWQuIgcA0OTekFAtaXeWY5LvDim35xLiNs16gTCHThjIZV0MNMcAXIFHW
         T0+w==
X-Gm-Message-State: APjAAAXkEy+lW5sHFnPaYI16Q3gi1/28OCjwFyr34yFh875eP0YP1Kq+
        B2TMv+yV85C+or0kGLFr6g3xIYf8YPbfjv3bBW2V754t3EoWvw2uhW5WJXZXp6eZl+wJWEGk6BD
        56RDbOZ79KwdpFq440dy1tpNnGW158s5TxsC36eV8a5mXTYsU8tzHjzOhFf3zUH27U4NISwF3G8
        TttjZuLUBxHKOpDIjOKQ==
X-Google-Smtp-Source: APXvYqz+6f7c+vJghMqyWL/SBBgBWZLcfeSeBJiG3xe5RKgrOGZBAlheCtSBH5Lyew25UzIiwD7/7w==
X-Received: by 2002:aa7:881a:: with SMTP id c26mr54210977pfo.254.1558105176596;
        Fri, 17 May 2019 07:59:36 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c189sm20739195pfg.46.2019.05.17.07.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 07:59:36 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 07/10] mpt3sas: Affinity high iops queues IRQs to local node
Date:   Fri, 17 May 2019 10:59:02 -0400
Message-Id: <20190517145905.4765-8-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
References: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

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
supported by Aero/Sea)

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 73 +++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 17bb995..779f945 100644
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

