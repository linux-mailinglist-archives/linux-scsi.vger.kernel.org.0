Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B794150EDF
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfFXOnR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 10:43:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37302 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfFXOnQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 10:43:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so7636037pfa.4
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TboHE8Qaeh99MtheYp4ZuAw9gzWEwuaNtLXGMcwzoCg=;
        b=BbLBWD+2HQql03rH91swhNfVPoDC+4iZhkRFPtR4oPE0dtYZWo4UIOoif7m6Jd6AKh
         6xSvSXb/pY/KH0+NsAy0PnR/c+Uf2Ko3582v/3NheDBMX4Hay4qr/Ats8ME9GxDkkOAR
         op6LyiBy4KC7S8RVs61u4CPaxhbbYOTatNOS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TboHE8Qaeh99MtheYp4ZuAw9gzWEwuaNtLXGMcwzoCg=;
        b=jZmJZXyYlkFcEUyKKnBtOJd+Ew0WMW4m5p9en6jVYCN4RtRXlAnc2NqusJDLdvY1QN
         242j9HIwJVGxITJvCXpHcH7OqiFVckixKfPHsPAeAwF6dnNQKlLkODs6TG6C3mCcjbn/
         EMZM71xtShaxySKXW8r7va/51zpGeH/NHNjtsGAf9wDPLUDl7jMfJWVvVdyOORQjLdF3
         VhadWr+IRts+OCTHVBM+U/ZGO5XeOoTC/s2PBdekpzNpYGm8Dj+L8GfwtmhRrumk69Zx
         DvhbHvxDZdHIYxY0WdH9YLGVlrIlwFaAc3rbnFiS6ACqHdKKWii00ckVJBA6NpUhC76h
         KpCg==
X-Gm-Message-State: APjAAAWbxeU+e9JfLTtO4KESZRm1Ipu6CnF0o+LOyv4CERYTT8f+/U+L
        P1mNRTn0vlXo4cNHl3QMwmz8Gg==
X-Google-Smtp-Source: APXvYqxxKUoPyj1GbnNLoPMdjzaj9KMrwab0s4xIla+bVf8OdhG2STzvzimbm6JnUgpVugfRe/oqaQ==
X-Received: by 2002:a63:fc15:: with SMTP id j21mr33106958pgi.217.1561387395583;
        Mon, 24 Jun 2019 07:43:15 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k197sm12991799pgc.22.2019.06.24.07.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:43:15 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 3/4] mpt3sas: Fix determine smp affinity on per HBA basis
Date:   Mon, 24 Jun 2019 10:42:55 -0400
Message-Id: <1561387376-28323-4-git-send-email-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
References: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Even though 'smp_affinity_enable' module parameter is enabled,
if the number of online CPUs are more than then the number of
msix vectors enabled on that HBA then smp affinity settings
should be disabled only for this HBA.
But currently this smp affinity setting is disabled
globally and hence smp affinity will be disabled for the
subsequent HBAs even though number of msix vectors enabled
for this HBA matches with number of online CPU.

To fix this, defined a per HBA variable smp_affinity_enable.
Initially this variable is initialized with smp_affinity_enable
module parameter value. If this HBA has less number of msix
vectors configured when compare to number of online cpus then
only this HBA's variable smp_affinity_enable is set to zero.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 10 ++++++----
 drivers/scsi/mpt3sas/mpt3sas_base.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8a47e02..722599a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2813,7 +2813,7 @@ _base_free_irq(struct MPT3SAS_ADAPTER *ioc)
 
 	list_for_each_entry_safe(reply_q, next, &ioc->reply_queue_list, list) {
 		list_del(&reply_q->list);
-		if (smp_affinity_enable)
+		if (ioc->smp_affinity_enable)
 			irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
 			    reply_q->msix_index), NULL);
 		free_irq(pci_irq_vector(ioc->pdev, reply_q->msix_index),
@@ -2898,7 +2898,7 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 	if (!nr_msix)
 		return;
 
-	if (smp_affinity_enable) {
+	if (ioc->smp_affinity_enable) {
 
 		/*
 		 * set irq affinity to local numa node for those irqs
@@ -3033,7 +3033,7 @@ _base_alloc_irq_vectors(struct MPT3SAS_ADAPTER *ioc)
 	struct irq_affinity desc = { .pre_vectors = ioc->high_iops_queues };
 	struct irq_affinity *descp = &desc;
 
-	if (smp_affinity_enable)
+	if (ioc->smp_affinity_enable)
 		irq_flags |= PCI_IRQ_AFFINITY;
 	else
 		descp = NULL;
@@ -3091,7 +3091,7 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 		goto try_ioapic;
 
 	if (ioc->msix_vector_count < ioc->cpu_count)
-		smp_affinity_enable = 0;
+		ioc->smp_affinity_enable = 0;
 
 	r = _base_alloc_irq_vectors(ioc);
 	if (r < 0) {
@@ -6897,6 +6897,8 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 		}
 	}
 
+	ioc->smp_affinity_enable = smp_affinity_enable;
+
 	ioc->rdpq_array_enable_assigned = 0;
 	ioc->dma_mask = 0;
 	if (ioc->is_aero_ioc)
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 44b8a23..6afbdb0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1405,6 +1405,7 @@ struct MPT3SAS_ADAPTER {
 
 	u8		combined_reply_queue;
 	u8		combined_reply_index_count;
+	u8		smp_affinity_enable;
 	/* reply post register index */
 	resource_size_t	**replyPostRegisterIndex;
 
-- 
1.8.3.1

