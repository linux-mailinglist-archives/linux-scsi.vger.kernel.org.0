Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56E954D2F
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfFYLFk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38531 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfFYLFk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so8640670plb.5
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FIPydZ3jEWaeWPodWxnrqDckJVIVod1VLHb1/9k7Fxg=;
        b=CIFCY1w626bTzOUOiY626W/PsZU0essBlv6U95YmCyphuHHLlcJberXjvNmrSgMHOt
         V/gRdEm6aY6VwMkOy7XgsuFqEHbaLd9A5Pm0X+Z40uAxDsAT1yTK2GczNf/J43NT/z2p
         Wgp3e1fwfiuwbmYSZPH1kZ9gqoX/Ygy02Ja5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIPydZ3jEWaeWPodWxnrqDckJVIVod1VLHb1/9k7Fxg=;
        b=mZMWEvt17OwWs7YnzM68jtXkrhBXMeC6AyJ0ZS8SOI2w+bq0nKfFWTrJwAGGpHXrVA
         b7c6QY1Y+ODWCbArZH7OVlDiIndOkWP2tiU9zJe/9HCtcw+FfhjvcNUjxslkvN2OgZBP
         h0hH2Yya/p04lx0UChOB0JB5rLEHehqo9WZHi4iVGH7gCyQPgHRlXpQItS+66Js/48dk
         e/wd2J+P6As5d5fD28zHIpeXJIF8tcwJJF0OPaU0bHpSuaznm38J/MrTMxrNxlDKIXtI
         31utSmLknOZ/DMI5QZK6hMJQ+PIS5qQBuBC8uDedGRbHNYV+gk8qR2oUorDATUlTXCXu
         6h6w==
X-Gm-Message-State: APjAAAXb1Va4SC2LylpUSBUvTeBPQcWEQdc2gctfw5bW3PcfAl34ou+X
        y7IkM/yI2Mad/EZQ7R6y7VQ+1HNU5irLYam/xkatXHVgAXj52vGQFfBw2x5v88Zmn8sh7i4fJwR
        X3Npx90j57MhJWq5FtZiQ06S9hNWs80ijwipXnTNKHH/Km9rQ4cuDE28Jr4QkH+P8nepJkWd+Fx
        BVLUWZ9RXyCw==
X-Google-Smtp-Source: APXvYqyB5uHM30ddXQsXnrtiwnO6Pb4Owi262lNKjyL0SLv3Gjsrm+MtwjHhsyitzjfr+AAej2Qqng==
X-Received: by 2002:a17:902:306:: with SMTP id 6mr156117704pld.148.1561460739169;
        Tue, 25 Jun 2019 04:05:39 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:38 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 15/18] megaraid_sas: Set affinity for high IOPs reply queues
Date:   Tue, 25 Jun 2019 16:34:33 +0530
Message-Id: <20190625110436.4703-16-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

High iops queues are mapped to non-managed IRQs. Set affinity of
non-managed irqs to local numa node.  Low latency queues are mapped to
managed IRQs.

Driver reserves some reply queues for high iops queues (through
pci_alloc_irq_vectors_affinity and .pre_vectors interface). The rest of
queues are for low latency.

Based on IO workload, driver will decide which group of reply queues
(either high iops queues or low latency queues) to be used.
High iops queues will be mapped to local numa node of controller and
low latency queues will be mapped to CPUs across numa nodes. In general,
high iops and low latency queues should fit into 128 reply queues
which is the max number of reply queues supported by Aero adapters.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 2e3c7fd..fec3e57 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5672,6 +5672,26 @@ int megasas_get_device_list(struct megasas_instance *instance)
 	return SUCCESS;
 }
 
+/**
+ * megasas_set_high_iops_queue_affinity_hint -	Set affinity hint for high IOPs queues
+ * @instance:					Adapter soft state
+ * return:					void
+ */
+static inline void
+megasas_set_high_iops_queue_affinity_hint(struct megasas_instance *instance)
+{
+	int i;
+	int local_numa_node;
+
+	if (instance->balanced_mode) {
+		local_numa_node = dev_to_node(&instance->pdev->dev);
+
+		for (i = 0; i < instance->low_latency_index_start; i++)
+			irq_set_affinity_hint(pci_irq_vector(instance->pdev, i),
+				cpumask_of_node(local_numa_node));
+	}
+}
+
 static int
 __megasas_alloc_irq_vectors(struct megasas_instance *instance)
 {
@@ -5729,6 +5749,8 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 	else
 		instance->msix_vectors = 0;
 
+	if (instance->smp_affinity_enable)
+		megasas_set_high_iops_queue_affinity_hint(instance);
 }
 
 /**
-- 
2.9.5

