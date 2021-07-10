Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB13C3C3015
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Jul 2021 04:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhGJCdW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jul 2021 22:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234434AbhGJCb3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 9 Jul 2021 22:31:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B233861422;
        Sat, 10 Jul 2021 02:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625884057;
        bh=wIFOHxxG1WGVVfYfKR8/d5d2XYXxPUVK5xaAmAYljR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWAOZmA6LF6lW+LSxFjSsYR3Fp2xxGoUwntohE85qQLJY9QSOMw9qFX9R3Ib4W1PF
         KXFu6Q62TUgh1mrZ0lhN1aHf9rcgap/grBqAAuizaaD3jvto7Cz/iJR588XbYtFGSy
         KuQj1ZMlUEkxEQ0vO8geBNyYry8yE2PXsDabk0YVZyaxnsqAXn3gKCRkpDes4bd4Wp
         6HaGO7VyS5O7OTNU47SykG7BoeEsc8nbpeOxVsnONWNdaojGoPRpYtNJAzas1GJxOG
         LJVMvm6fNvTIpwmo70jNxCEy4JHr3bs4ZXWTNOhDKEEXxQTjvE/djuGiCXalxELgCI
         oA6Tmp+UPyp0Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/63] scsi: megaraid_sas: Handle missing interrupts while re-enabling IRQs
Date:   Fri,  9 Jul 2021 22:26:28 -0400
Message-Id: <20210710022709.3170675-22-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022709.3170675-1-sashal@kernel.org>
References: <20210710022709.3170675-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Chandrakanth Patil <chandrakanth.patil@broadcom.com>

[ Upstream commit 9bedd36e9146b34dda4d6994e3aa1d72bc6442c1 ]

While reenabling the IRQ after IRQ poll there may be a small window for the
firmware to post the replies with interrupts raised. In that case the
driver will not see the interrupts which leads to I/O timeout.

This issue only happens when there are many I/O completions on a single
reply queue. This forces the driver to switch between the interrupt and IRQ
context.

Make the driver process the reply queue one more time after enabling the
IRQ.

Link: https://lore.kernel.org/linux-scsi/20201102072746.27410-1-sreekanth.reddy@broadcom.com/
Link: https://lore.kernel.org/r/20210528131307.25683-5-chandrakanth.patil@broadcom.com
Cc: Tomas Henzl <thenzl@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index ae7a3e154bb2..a78a702511fa 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3716,6 +3716,7 @@ static void megasas_sync_irqs(unsigned long instance_addr)
 		if (irq_ctx->irq_poll_scheduled) {
 			irq_ctx->irq_poll_scheduled = false;
 			enable_irq(irq_ctx->os_irq);
+			complete_cmd_fusion(instance, irq_ctx->MSIxIndex, irq_ctx);
 		}
 	}
 }
@@ -3747,6 +3748,7 @@ int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
 		irq_poll_complete(irqpoll);
 		irq_ctx->irq_poll_scheduled = false;
 		enable_irq(irq_ctx->os_irq);
+		complete_cmd_fusion(instance, irq_ctx->MSIxIndex, irq_ctx);
 	}
 
 	return num_entries;
@@ -3763,6 +3765,7 @@ megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
 {
 	struct megasas_instance *instance =
 		(struct megasas_instance *)instance_addr;
+	struct megasas_irq_context *irq_ctx = NULL;
 	u32 count, MSIxIndex;
 
 	count = instance->msix_vectors > 0 ? instance->msix_vectors : 1;
@@ -3771,8 +3774,10 @@ megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
 	if (atomic_read(&instance->adprecovery) == MEGASAS_HW_CRITICAL_ERROR)
 		return;
 
-	for (MSIxIndex = 0 ; MSIxIndex < count; MSIxIndex++)
-		complete_cmd_fusion(instance, MSIxIndex, NULL);
+	for (MSIxIndex = 0 ; MSIxIndex < count; MSIxIndex++) {
+		irq_ctx = &instance->irq_context[MSIxIndex];
+		complete_cmd_fusion(instance, MSIxIndex, irq_ctx);
+	}
 }
 
 /**
-- 
2.30.2

