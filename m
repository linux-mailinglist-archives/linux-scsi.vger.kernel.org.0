Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31883C78A3
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Jul 2021 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhGMVS5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Jul 2021 17:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236182AbhGMVSw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 13 Jul 2021 17:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626210961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcUE+Ykyp7TUpfxrTLCdo1t8nVQ8beSKO1+WFe5MKv4=;
        b=jI7Meiw4ScxiO1/BbdOA2Fd9SSuF2sjL/cd1cq967aRj25HD8xo8Hy2fygQ05kOR17jatX
        LLuqY6Bzn98ZL7CJSTJSunUCOb2ElyMEh1YiQMk1/3q/Dk7FEWigmfK1bSHC5js/jiTRfY
        NvHnby/CRHJxFnnrKtOKEAiC0fBSHmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-5RW3Jc6gMMayPDz5a56D4A-1; Tue, 13 Jul 2021 17:15:59 -0400
X-MC-Unique: 5RW3Jc6gMMayPDz5a56D4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44CDC5074B;
        Tue, 13 Jul 2021 21:15:54 +0000 (UTC)
Received: from virtlab719.virt.lab.eng.bos.redhat.com (virtlab719.virt.lab.eng.bos.redhat.com [10.19.153.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96F125D9DD;
        Tue, 13 Jul 2021 21:15:50 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-pci@vger.kernel.org,
        tglx@linutronix.de, jesse.brandeburg@intel.com,
        robin.murphy@arm.com, mtosatti@redhat.com, mingo@kernel.org,
        jbrandeb@kernel.org, frederic@kernel.org, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com, rostedt@goodmis.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, maz@kernel.org, nhorman@tuxdriver.com,
        pjwaskiewicz@gmail.com, sassmann@redhat.com, thenzl@redhat.com,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jkc@redhat.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com, ahleihel@redhat.com,
        kheib@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        benve@cisco.com, govind@gmx.com, jassisinghbrar@gmail.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, nilal@redhat.com,
        tatyana.e.nikolova@intel.com, mustafa.ismail@intel.com,
        ahs3@redhat.com, leonro@nvidia.com, chandrakanth.patil@broadcom.com
Subject: [PATCH v3 04/14] scsi: megaraid_sas: Use irq_set_affinity_and_hint
Date:   Tue, 13 Jul 2021 17:14:52 -0400
Message-Id: <20210713211502.464259-5-nitesh@redhat.com>
In-Reply-To: <20210713211502.464259-1-nitesh@redhat.com>
References: <20210713211502.464259-1-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver uses irq_set_affinity_hint() specifically for the high IOPS
queue interrupts for two purposes:

- To set the affinity_hint which is consumed by the userspace for
  distributing the interrupts

- To apply an affinity that it provides

The driver enforces its own affinity to bind the high IOPS queue interrupts
to the local NUMA node. However, irq_set_affinity_hint() applying the
provided cpumask as an affinity for the interrupt is an undocumented side
effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
where the provided mask needs to be applied as the affinity and
affinity_hint pointer needs to be set and replace with
irq_update_affinity_hint() where only affinity_hint needs to be updated.

Change the megasas_set_high_iops_queue_affinity_hint function name to
megasas_set_high_iops_queue_affinity_and_hint to clearly indicate that the
function is setting both affinity and affinity_hint.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 27 +++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index ec10b2497310..836a1b13f71b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5718,7 +5718,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 				"Failed to register IRQ for vector %d.\n", i);
 			for (j = 0; j < i; j++) {
 				if (j < instance->low_latency_index_start)
-					irq_set_affinity_hint(
+					irq_update_affinity_hint(
 						pci_irq_vector(pdev, j), NULL);
 				free_irq(pci_irq_vector(pdev, j),
 					 &instance->irq_context[j]);
@@ -5761,7 +5761,7 @@ megasas_destroy_irqs(struct megasas_instance *instance) {
 	if (instance->msix_vectors)
 		for (i = 0; i < instance->msix_vectors; i++) {
 			if (i < instance->low_latency_index_start)
-				irq_set_affinity_hint(
+				irq_update_affinity_hint(
 				    pci_irq_vector(instance->pdev, i), NULL);
 			free_irq(pci_irq_vector(instance->pdev, i),
 				 &instance->irq_context[i]);
@@ -5892,22 +5892,25 @@ int megasas_get_device_list(struct megasas_instance *instance)
 }
 
 /**
- * megasas_set_high_iops_queue_affinity_hint -	Set affinity hint for high IOPS queues
- * @instance:					Adapter soft state
- * return:					void
+ * megasas_set_high_iops_queue_affinity_and_hint -	Set affinity and hint
+ *							for high IOPS queues
+ * @instance:						Adapter soft state
+ * return:						void
  */
 static inline void
-megasas_set_high_iops_queue_affinity_hint(struct megasas_instance *instance)
+megasas_set_high_iops_queue_affinity_and_hint(struct megasas_instance *instance)
 {
 	int i;
-	int local_numa_node;
+	unsigned int irq;
+	const struct cpumask *mask;
 
 	if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
-		local_numa_node = dev_to_node(&instance->pdev->dev);
+		mask = cpumask_of_node(dev_to_node(&instance->pdev->dev));
 
-		for (i = 0; i < instance->low_latency_index_start; i++)
-			irq_set_affinity_hint(pci_irq_vector(instance->pdev, i),
-				cpumask_of_node(local_numa_node));
+		for (i = 0; i < instance->low_latency_index_start; i++) {
+			irq = pci_irq_vector(instance->pdev, i);
+			irq_set_affinity_and_hint(irq, mask);
+		}
 	}
 }
 
@@ -5996,7 +5999,7 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 		instance->msix_vectors = 0;
 
 	if (instance->smp_affinity_enable)
-		megasas_set_high_iops_queue_affinity_hint(instance);
+		megasas_set_high_iops_queue_affinity_and_hint(instance);
 }
 
 /**
-- 
2.27.0

