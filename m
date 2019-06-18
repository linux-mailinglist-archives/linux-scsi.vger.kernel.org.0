Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F031649D66
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfFRJdQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:33:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36024 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRJdP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:33:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so7329548pfl.3
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FIPydZ3jEWaeWPodWxnrqDckJVIVod1VLHb1/9k7Fxg=;
        b=NFPFv6MkpR99j6sWOCv9b/Ye+EtOlG/SQagnMC1jk3snvTwLZ6eODaIoWy9CkFjbSu
         YpoEnyG2Pkti9cw4gLqfm4pqmPaGtf57nINK8u78YyJ1S6CuinBUzH6iOf063+vCZmho
         KmmIM/gXUFQnlgQwPXcD2k5zdZ2BAUDsrKPZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIPydZ3jEWaeWPodWxnrqDckJVIVod1VLHb1/9k7Fxg=;
        b=Rm3X4yXcLT5FQaJVt52LkdZQgNFw2IYGawaIPu8mUWkbGdVXOfFl3Nc59EsQY1du/B
         JSNQdZwISYDXrwJ6T9T/Gcuv8KORIByuN6rSkwcC/Y5T/+TxZI0DByncnSfa/6pKWm+X
         FxJLxgYMPjBkfHzSdsgWKdVll3cLD+bUJrf3ORSXIstfIZNuf6iQyN+hGLvE3j+1AnG1
         hluZhglr4SyNU/uW0JOmWdRfO3t4UHtnZfBriAmFSqJ45y8zVQ5dY3WkohutFHA696zt
         3uQI1EV04QBbnLW+9Mv2aYO8NZB1pGcO3TrmaFUkwHmaDdm4lwDDELGYPUuCeuqrrpYB
         TBvQ==
X-Gm-Message-State: APjAAAW06xFeC7hczytf78kM2M36r+fG9k6n3ZYTSj/vWTep1xNaNLuk
        WO19NszGRgKfmJy5WWiECcw9OrVIqCCpPlELeU+fR4gjIMrJJGuQQVKyFQS3z5vkVBxOEf+k1Wh
        KnZh9kAGo6r/hx4xTUpG71CgEYaPDdc5hZsy0x2sPz2BdBsmF248G2LEAf8JlHmtGljMG7vDAe/
        aYmsoXVb/jzQ==
X-Google-Smtp-Source: APXvYqw4JPzE1rnqU5DKKeLMi1jdOuZ1jW930eeN35wmNq2iJvpKeWEVYsewUZIME81ZN+R/bFNz1A==
X-Received: by 2002:a62:6341:: with SMTP id x62mr120838017pfb.63.1560850394718;
        Tue, 18 Jun 2019 02:33:14 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.33.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:33:13 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 15/18] megaraid_sas: Set affinity for high IOPs reply queues
Date:   Tue, 18 Jun 2019 15:02:04 +0530
Message-Id: <20190618093207.9939-16-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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

