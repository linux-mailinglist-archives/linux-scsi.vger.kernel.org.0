Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20000168C4
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfEGRGx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43003 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so8604255pgh.9
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcu3BjDbzb6AS6deRu3+AnPwMTij9dA2O6fW6kspqME=;
        b=QMMbX7iWktzNrSydS8UIILTaTwk7e2Rq3mcyfRFr0BBNM4nMMDY8kicbR6U806nOgi
         Y5KyAei3iPX4IrqYhDDRh1/jdsy06iSwuPMXFUEki7mscE11GJKGRX1SkxtEf3J+rvtB
         Q2YpEQhB308niDZsbpP9nWxmx8VkCWBssLfss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcu3BjDbzb6AS6deRu3+AnPwMTij9dA2O6fW6kspqME=;
        b=gTnKSFi19vccIF9YyS2NekrAKJ2hr1MDr0F3DYzOMOHhSPRi5OwIQdvGHXZTqd0t3s
         61qtX1PEOQnA16xvNeMIRNg8M2mkKceBiewOOpO9niUmZHnsdqDHCXaFjVa6lMTKuJnL
         ddgaa+Zj99z7tc0AhLLjWtoztkdRT8nGvdcPj8tOSn8ChcXWYzoqTE6M1YxcNYLs/qML
         SwtqBV3nGMWXgr2bqI0yAaHDK5x2O24NvnqxhMgeIKJmtmSY9b1N9A2cwZkCpXaVD273
         qFENS6669P77MvVftups/JxHEk67BqUnzbonmNDvaraghAo6cjEmZkf+mV7jL0MS2S4G
         FliQ==
X-Gm-Message-State: APjAAAVk3zylTVsERA+TtkZbb6Wq+6LcpakLExPxkZkJdsf/2MfdhXly
        9LUz+diKFaZpEsVpr255Lc+x0egHYGsrgPy4n75j8g/sa0tkiG87LY+VzCDv/udSgJSpHdNF/qk
        8LC61rSxFiwbQDJHrOJaAuKG1aiB13LOD1qtsbtyS3L/7EMZ5iYqcw0wP1WS0IfmA+qfy0uXTRj
        cagAD4A0pxe8krwaLfBiTs
X-Google-Smtp-Source: APXvYqxXQv6yAaYw6AkkPog0t/PvBPaUp0pfm9GkuSlEGUcQCm6eRk4peCLzwAn/JKJRbaWnIS3iUg==
X-Received: by 2002:a62:5653:: with SMTP id k80mr29007217pfb.144.1557248812357;
        Tue, 07 May 2019 10:06:52 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:51 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 12/21] megaraid_sas: Dump system registers for debugging
Date:   Tue,  7 May 2019 10:05:41 -0700
Message-Id: <1557248750-4099-13-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When controller fails to transition to READY state during driver probe,
dump the system interface register set.
This will give snapshot of the firmware status for debugging
driver load issues.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
Changes in v2:
Fixed the sparse warning and removed the endianness conversion after
readl.

 drivers/scsi/megaraid/megaraid_sas_base.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index e2a89821bdd2..905b45590c7e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2862,6 +2862,24 @@ megasas_dump(void *buf, int sz, int format)
 	printk(KERN_CONT "\n");
 }
 
+/**
+ * megasas_dump_reg_set -	This function will print hexdump of register set
+ * @buf:			Buffer to be dumped
+ * @sz:				Size in bytes
+ * @format:			Different formats of dumping e.g. format=n will
+ *				cause only 'n' 32 bit words to be dumped in a
+ *				single line.
+ */
+inline void
+megasas_dump_reg_set(void __iomem *reg_set)
+{
+	unsigned int i, sz = 256;
+	u32 __iomem *reg = (u32 __iomem *)reg_set;
+
+	for (i = 0; i < (sz / sizeof(u32)); i++)
+		printk("%08x: %08x\n", (i * 4), readl(&reg[i]));
+}
+
 /**
  * megasas_dump_fusion_io -	This function will print key details
  *				of SCSI IO
@@ -3891,8 +3909,11 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 				max_wait = MEGASAS_RESET_WAIT_TIME;
 				cur_state = MFI_STATE_FAULT;
 				break;
-			} else
+			} else {
+				dev_printk(KERN_DEBUG, &instance->pdev->dev, "System Register set:\n");
+				megasas_dump_reg_set(instance->reg_set);
 				return -ENODEV;
+			}
 
 		case MFI_STATE_WAIT_HANDSHAKE:
 			/*
@@ -4000,6 +4021,8 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 		default:
 			dev_printk(KERN_DEBUG, &instance->pdev->dev, "Unknown state 0x%x\n",
 			       fw_state);
+			dev_printk(KERN_DEBUG, &instance->pdev->dev, "System Register set:\n");
+			megasas_dump_reg_set(instance->reg_set);
 			return -ENODEV;
 		}
 
@@ -4022,6 +4045,8 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 		if (curr_abs_state == abs_state) {
 			dev_printk(KERN_DEBUG, &instance->pdev->dev, "FW state [%d] hasn't changed "
 			       "in %d secs\n", fw_state, max_wait);
+			dev_printk(KERN_DEBUG, &instance->pdev->dev, "System Register set:\n");
+			megasas_dump_reg_set(instance->reg_set);
 			return -ENODEV;
 		}
 
-- 
2.16.1

