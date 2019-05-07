Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D5168C8
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfEGRHH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43356 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so8486401plp.10
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GH2McAjbHTTT+r3RUBdzwUwYCFkr8azQo8a6uOlOZ2o=;
        b=HeNcYkid6c3ntapQswQU1nXepNrX2NUr20+0iMwkIpB73qGQ+z64MR/kCMcu6k6j5w
         9uX6fInLlthtVyUXtnhmwgaricxW6QzeuAWIj7C+7ayUTYOxiw2UnACsxKZWltQ35blG
         G3nytv0Ac6FKKOoRmbLjH2gD7Q0+URV3n7mns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GH2McAjbHTTT+r3RUBdzwUwYCFkr8azQo8a6uOlOZ2o=;
        b=BAPaMcGX+TURxY6K6T4SvQFMj1kzvqI+IOnRcw+YZ91BrIIrqFjW8vp54HQqRuKQ22
         GmQc/WUmSGa4e11elfSJce/2VOro+iLmpNA6s+r/GzlERrULiifzPVjpkWWnME00l8G9
         eqf3z6BtuJxXjKSTRzl8lvB+o8/G59KLyFcK5CeVbGTi3JpYWzvvrVpXZ0Q2zJHmtnp+
         T7jeHplG0L8GSff93LRb3xO+g9SxBewSRwGNG7evL11/aqtIdwTSJKeRgJtvwifbB3bW
         YP8LojV36RZt2WEIfzlriXxkRXhL/249p2LPkarH4IR/Ka8zPn3xaL325kJQzQi4fPuI
         5VaQ==
X-Gm-Message-State: APjAAAURxtZx9u3SFyR5gTRIqeOK2CaiZqV23+Y2zUc9ahSpu9CTWUwg
        i/qZ4NFMbwY8UJSkKEEtZgnreKr5NCyrxUxrywB/du+RKenCt36MRbdpOe3OqBFYGUj8kIP9xtN
        lWTVj8JFzP7D25p1Wapxpr8uVZzDvUjlM3MGrNNsEwbNw5GVpU86T3Mrsxe2LPtPqIv4ICwrbdH
        rj+yQmCKN0nCdvsfPGRhW+
X-Google-Smtp-Source: APXvYqw7V8G1EcgmvaoCuwjZtg9YvHU+guVs/shw0fBQDGY7MZCNGCf/2GT/tmydThUxU+ZGmy9T6A==
X-Received: by 2002:a17:902:2a07:: with SMTP id i7mr36483523plb.125.1557248826487;
        Tue, 07 May 2019 10:07:06 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:07:05 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 16/21] megaraid_sas: Print firmware interrupt status
Date:   Tue,  7 May 2019 10:05:45 -0700
Message-Id: <1557248750-4099-17-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a print to dump the interrupt status in system log
for debugging.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 4c78e4caf910..ca489fed51a1 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -202,7 +202,8 @@ megasas_enable_intr_fusion(struct megasas_instance *instance)
 	writel(~MFI_FUSION_ENABLE_INTERRUPT_MASK, &(regs)->outbound_intr_mask);
 
 	/* Dummy readl to force pci flush */
-	readl(&regs->outbound_intr_mask);
+	dev_info(&instance->pdev->dev, "%s is called outbound_intr_mask:0x%08x\n",
+		 __func__, readl(&regs->outbound_intr_mask));
 }
 
 /**
@@ -213,14 +214,14 @@ void
 megasas_disable_intr_fusion(struct megasas_instance *instance)
 {
 	u32 mask = 0xFFFFFFFF;
-	u32 status;
 	struct megasas_register_set __iomem *regs;
 	regs = instance->reg_set;
 	instance->mask_interrupts = 1;
 
 	writel(mask, &regs->outbound_intr_mask);
 	/* Dummy readl to force pci flush */
-	status = readl(&regs->outbound_intr_mask);
+	dev_info(&instance->pdev->dev, "%s is called outbound_intr_mask:0x%08x\n",
+		 __func__, readl(&regs->outbound_intr_mask));
 }
 
 int
@@ -4895,9 +4896,9 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 
 			atomic_set(&instance->adprecovery, MEGASAS_HBA_OPERATIONAL);
 
-			dev_info(&instance->pdev->dev, "Interrupts are enabled and"
-				" controller is OPERATIONAL for scsi:%d\n",
-				instance->host->host_no);
+			dev_info(&instance->pdev->dev,
+				 "Adapter is OPERATIONAL for scsi:%d\n",
+				 instance->host->host_no);
 
 			/* Restart SR-IOV heartbeat */
 			if (instance->requestorId) {
-- 
2.16.1

