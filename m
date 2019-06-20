Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46D4CC60
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfFTKx1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45034 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbfFTKx1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so1229167plr.11
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FIPydZ3jEWaeWPodWxnrqDckJVIVod1VLHb1/9k7Fxg=;
        b=C37TnUNgK2YbPci9uOJobq5KNzA+A+oiysW38CzBbc4iSFwdANu3U6HNn+PHdf7bAF
         ECLqgDryleWUMga+GBg2mHDpKoTnHDeZoQ3e9OGY74t9ZZRoP35uwHmwr4Hcn0UyUctz
         ENrXcGVBhVahwBq5rdels2Pn+XPF4XQWzwZsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIPydZ3jEWaeWPodWxnrqDckJVIVod1VLHb1/9k7Fxg=;
        b=FF3wojJFo75owBxCJfpRdwNhjCObPLwae1A6Q/8SkYb4Aze5CxriKWUnEg4CYL67xU
         an/lCfO1YBiXqTNOXxpmF23Q4mYMQOUGfsNoT7RPHcqkL4aoFD6xqnePPmdfzNdO4i/J
         7NWyj/G+ECmrgkhFOtlPIDnbsF5FrZexL/g/lwMzTQAfmYoegOKK67/FtftHl49rmjUh
         ykIYSnEalhv+EvFkzwmH7xN6XcCEeW3QXQduul6ufCX1oSJjsBfN7eqCqcACsvBScjnA
         N8tfKKbOcISBgTzvJHY5JZxq+aqTq5cwJaNKeRTe8h5ccp+7kCb+82lqKw911gkUeGkb
         dKNA==
X-Gm-Message-State: APjAAAVruB+ZHtV7VW1D3PD7idmzWBFPz5Y8LhA8HaUbfBzKAG74TKBn
        Vdo0qYkftrhfeYI9twBQPQEE6Kt1ljqtvpnEwQdCQNyX/iyYmQqDfZ4udrs+dlXkpK1qkelpm0s
        DG/haAtEIAvrI97g38bwlAb4EyB5qpE2JxbJdSBFGZ+Mk4QQ78hG2/1BYh5F79V90MBnoE9fjo6
        J47Mx4btxpk93o
X-Google-Smtp-Source: APXvYqwdRMkMNfo/Lu1IQ4cd52dE8TnHe3stgtT7C3v6Fc/LDbRjDzBCw6k7DLkehpf8cS9rskLzsA==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr122170257pla.48.1561028005949;
        Thu, 20 Jun 2019 03:53:25 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:25 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 15/18] megaraid_sas: Set affinity for high IOPs reply queues
Date:   Thu, 20 Jun 2019 16:22:05 +0530
Message-Id: <20190620105208.15011-16-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

