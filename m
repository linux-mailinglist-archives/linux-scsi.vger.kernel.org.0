Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A254D24
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfFYLFF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46467 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so8648745pls.13
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YBgpyZC5t+wsWk7wChS8HOs3vSiojNUjxFitgNjZEY=;
        b=UZr+JLWSv4RDIoZuGb0u5D4Nt5dXUTK4Jz9QdMizZy3dFhRs6WBlz2QpkOY6x3vXAu
         7aW/c5Evrttw66M7v7+/SOO64IIAMGX75mwrZNx8GIVH6nLcScUGxsfOLulJ+6H2Tkp3
         1k2PDx75fVPkcpYF2P6wMi4sJOuPHZ9g6NTvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YBgpyZC5t+wsWk7wChS8HOs3vSiojNUjxFitgNjZEY=;
        b=T2cB7cJ1h9NJjPOZVvxgINzYBbWWs9v+PYNIhSs8Ul+pS6pDgaW0EYD3wjd32U79oW
         0TF0/Dl36UZz+ZYWjHVI6724lApURyySnkRgrB7tRx4WTIeZmsRRN42DslXOp8ynRNXh
         iLnLuW+rZ1bgRtLCDZ2TKwh9EqNqQxm6B4dobkL81YZ4KZ83/PV+lJTtMGobl948RPvE
         0EcuaHVFJ+2/3cyKbEVTfwhPlzZoB3QQVd5qZKKXOKPGit3mtJ3i4eOnDhOWu4ml4cOF
         zs/sqmBs4rk+Ckn8LIef+zojeIdwbALZFabKuywt5uvwgjLl3CIEU+SlIR4Y8uWxNVEn
         qOJg==
X-Gm-Message-State: APjAAAUpdb6+io7yTq4etH8XuaNk/QuJTZ5D7ryg0eTYK5TxE9jvOKQa
        z8A2uAffGKgBDGl7IEJcvxomV+RHqfkDRrVYxCLcoDAW8bfV08yYwa9pKGaxh9vf5D7okkhKRWW
        kqSF4mT6KbW0DrybNFLT719rpOv7dPggTXjrdFnqEQ7SnJVk63qIj81dg7MBvvvfAvqwTiWIr9l
        XzYx5xlNvECvIA
X-Google-Smtp-Source: APXvYqwaNQq1hMGXn9AVC/r9rMuy7sU7wYphzZ5Dx5rXsqeguXYb/7gnNnIeEAp7nB4bFGFzUH3BGg==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr66325482plo.97.1561460704709;
        Tue, 25 Jun 2019 04:05:04 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:04 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 04/18] megaraid_sas: Call disable_irq from process IRQ poll
Date:   Tue, 25 Jun 2019 16:34:22 +0530
Message-Id: <20190625110436.4703-5-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On PowerPC architecture, calling disable_irq_nosync from IRQ context is
not providing the required effect.

In current megaraid_sas driver, disable_irq_nosync is being called from
IRQ context before enabling IRQ poll. But due to the issue seen on PPC,
after IRQ poll disable and legacy ISR is enabled, we are not seeing our
ISR getting called.

Fix: Call disable_irq from IRQ poll thread context instead of IRQ context.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  1 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index a972021..d333b8e 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2186,6 +2186,7 @@ struct megasas_irq_context {
 	u32 os_irq;
 	struct irq_poll irqpoll;
 	bool irq_poll_scheduled;
+	bool irq_line_enable;
 };
 
 struct MR_DRV_SYSTEM_INFO {
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index dac8552..b8a5bbf 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3601,7 +3601,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
 			if (irq_context) {
 				if (!irq_context->irq_poll_scheduled) {
 					irq_context->irq_poll_scheduled = true;
-					disable_irq_nosync(irq_context->os_irq);
+					irq_context->irq_line_enable = true;
 					irq_poll_sched(&irq_context->irqpoll);
 				}
 				return num_completed;
@@ -3681,6 +3681,11 @@ int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
 	irq_ctx = container_of(irqpoll, struct megasas_irq_context, irqpoll);
 	instance = irq_ctx->instance;
 
+	if (irq_ctx->irq_line_enable) {
+		disable_irq(irq_ctx->os_irq);
+		irq_ctx->irq_line_enable = false;
+	}
+
 	num_entries = complete_cmd_fusion(instance, irq_ctx->MSIxIndex, irq_ctx);
 	if (num_entries < budget) {
 		irq_poll_complete(irqpoll);
@@ -3726,6 +3731,11 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
 	if (instance->mask_interrupts)
 		return IRQ_NONE;
 
+#if defined(ENABLE_IRQ_POLL)
+	if (irq_context->irq_poll_scheduled)
+		return IRQ_HANDLED;
+#endif
+
 	if (!instance->msix_vectors) {
 		mfiStatus = instance->instancet->clear_intr(instance);
 		if (!mfiStatus)
-- 
2.9.5

