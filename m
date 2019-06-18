Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EB49D57
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfFRJcm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33954 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfFRJcl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so7385607pgn.1
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wo7RQezSw797loYVS0n34QvnDialeFwRJ/cXlc9gP5w=;
        b=NR3eWK9ShwHNXcJQG1V1KFGbgu3eggndZiWrm8wrMOi4N/g04Qj4zufirAWxd/L2Zc
         njI6NBf7gT8bTtP0td0fnv6msKA/RUjT5kInB5mOpi4ycUOpsjZlTtGt/nUI1v7z2raO
         tlZ/qg9X1aiW5q6owyPoT8qzWYAzDDzgbtYpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wo7RQezSw797loYVS0n34QvnDialeFwRJ/cXlc9gP5w=;
        b=VmxK8vDkRtDfY0rU8VdOA7YjrKHpYT/1nsJLbYb7Ad7F1krH/5fW3Lfv6EH/eOP7ML
         +LH00SS0VK+PZQveZy9p1cPUu+A2SoQsUDhdvjZHu1lHWCA1JHXk2U/rYR0uIfj5P7ZG
         XgyUXtOXYAMPJzJxJeF5ZjrxRD6qcQo+tr+QiYddpWUwtt8Ja4o5xM3r9bsZlvZ0Z28b
         Olp6HkGE75elqQpBtLd9MSe/ItSx47rSKHuIENwj36IKqpfieeBANTD8sK7ZjdJneG2i
         duATiCP5GNKayzi9fQDUHX9ntBaxtPMzN0C1uEgr0PRgBRFhmrhqx22wIZqUWDXd+/kV
         IQbA==
X-Gm-Message-State: APjAAAVbpta22ypQskgdNXVZVFoIXudgQZGTVUDjQvhNYJ5GBslDLtcI
        7NQ7QU+ABFFTFV8/NaZE80qANC7QwIXLu6v3v7z6fjGt+9x2OCDBN7pNJSiRFb1Vzhx78SAC50m
        WXcl0HLUPpjniBHjn7jaWaIT6BdjhLmTBiYiqzyGmfQ9hBWkAI96OOwj1XBT5/3n1Behg/Zi03k
        7/YdsSnTulcQ==
X-Google-Smtp-Source: APXvYqw/KxOPQr9lLqwJ5lF8YB6EcVEWaMFeX2KFXZm9eP0p0bNpfKVw+AzRPj3VVtwX9u2hPwfxZQ==
X-Received: by 2002:a17:90a:2768:: with SMTP id o95mr4069939pje.37.1560850360134;
        Tue, 18 Jun 2019 02:32:40 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:39 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 04/18] megaraid_sas: Call disable_irq from process IRQ poll
Date:   Tue, 18 Jun 2019 15:01:53 +0530
Message-Id: <20190618093207.9939-5-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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
index dc27da1..855199c 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3603,7 +3603,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
 			if (irq_context) {
 				if (!irq_context->irq_poll_scheduled) {
 					irq_context->irq_poll_scheduled = true;
-					disable_irq_nosync(irq_context->os_irq);
+					irq_context->irq_line_enable = true;
 					irq_poll_sched(&irq_context->irqpoll);
 				}
 				return num_completed;
@@ -3683,6 +3683,11 @@ int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
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
@@ -3728,6 +3733,11 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
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

