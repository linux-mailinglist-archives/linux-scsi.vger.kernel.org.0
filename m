Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA364CC52
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfFTKww (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:52:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46193 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKwv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:52:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so1436238pfy.13
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YBgpyZC5t+wsWk7wChS8HOs3vSiojNUjxFitgNjZEY=;
        b=ZeWGoddCgf5Zu/D8mcM7cd0skwanPa65lMVgnNLSp+8i6R4+mYVIXy9BCNEsDkLgdk
         c2zABFLrFqD7xN2aPhR2CGokcvFwLaeYYh9y1m8KeIlDVQB3TRkhleeoWoqdZaYJf76e
         84JplUWe5tfISzrl1DQLBbU25yMS1hy/ZdOC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YBgpyZC5t+wsWk7wChS8HOs3vSiojNUjxFitgNjZEY=;
        b=SVXJnuxcON0gLn09spxRj/yFH0hVQXM0TjGnbIhwLbusd8FN5We4QY0CHcpLf8F6bD
         204reBgoV5PKsqVZDs+RMso9NbV4UHLIZk+PtuoNLkfxscilzSmSrRCpNdwwJGt30bnD
         ZLwWA+TnnGdegxquqJ+OqPjM0miuLXLCIBbzf4oVl0SDOK0vdTiAxM4MHzvFxrmzS/44
         Rz7/3Lxe9JP2HzDvab2Ot4d2k1Ud4n4e2dk0hBBqAeEymiJikh6aRK2rnwGqQV9gv9kE
         Up2om//vjkOgqagATHAJS5Hbbi+2D8M3nUBL1o7n90+KRQpMMJaKdp65+GxhQcpwheYp
         ADPg==
X-Gm-Message-State: APjAAAVaFdcBqFy+w7Gf/793r472sofbAQVi92rVfI6E5fyiLMn4avfw
        fAZeugO3m0p23FiOmIsq2G9K4As3rfwYz7SAqhkVhj2yhupP3FEqdqi7Ze9/ZhFiXVvwgoS49ON
        2hTGP9ix6ua1ZdkaX45RcB3LLfEGnndo1ES8QybHYLav56GLqOME8C69mLDeyUqvpHUHShrn4gf
        0EKL/0hu9dCNYLO6o=
X-Google-Smtp-Source: APXvYqyjOD35Y12gwlG04i0/E1+ObcIJ2h4o5dro3MD/r1XojXbH9DcbqX69DwqF97K7Fufz3CVEjA==
X-Received: by 2002:aa7:9212:: with SMTP id 18mr91367938pfo.120.1561027970993;
        Thu, 20 Jun 2019 03:52:50 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:52:50 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 04/18] megaraid_sas: Call disable_irq from process IRQ poll
Date:   Thu, 20 Jun 2019 16:21:54 +0530
Message-Id: <20190620105208.15011-5-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

