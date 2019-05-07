Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B2168C1
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfEGRGm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36359 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so8619451pgc.3
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kOA1Bx5cGF6fzOBzG0i3z220U4AD6UldXBrPPdCIklo=;
        b=JJreXd/g4EhLniFJS+ZGNaaV1N2JYVU7K2B6kBeMXGECM3BOQmpxUkQDPbidSJ2xW7
         jibOh5k8E9eywOZy/pW9cJ/6nDlpJRMp5zZ/h0R5vLFrR9FZdVA53haol38Z01ybHNAI
         vTrVtKE1yIClOpdqheozVwuC1bytX1hK0ogl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kOA1Bx5cGF6fzOBzG0i3z220U4AD6UldXBrPPdCIklo=;
        b=jvw2IRnq09IHlNf2ePjRzFWCnzmgqd1tLMw8rCL2iddUWI+gaCBYDCDKlnfzA99jFR
         Fzh09fBB1Ew0iaNHC0V6BVTi8uhA4nlKmln+oAQXuWqxzMri220Gq+Jl0Ag1XIoH76XY
         45cveOZQVyBUHy6yDiLXoRV8CX47ios5QErFpTnlKQAPq9ApMWvkw5HvFAxWXE9OpRtj
         ALhmTfD1p1UY2XsvzRkoeLM9NVkUgHY7hCLYokgD/Xg3XIgvwUYQ0GsTFDezgADXSopd
         5GcwcR9mT9raj3TRZzHjvG/ulAebCSHz815rhL1ui0wLCGjTLOeKCnTD5TWlwJg8A39C
         QnEA==
X-Gm-Message-State: APjAAAWYHJ9f7fVEZhxi7ryU/uFyk5cXWWEOrK5MivWp8QID77r/H9S6
        2wmn/IaRGhedgXyL+GDd0568lhOBwfPUszYGGSpCGk+t9RlNoNNPT5KiCCffs1jNrdME0wgBrrn
        i4jduQ/2wR8CcNdmqpWmxjKFqdLdfOvxB2eJSnL7KXWPfOHlJxWRsJZWPPuPFfUY30YqwSWAA4q
        FArO8Bu85Qxwgsio+mnkzP
X-Google-Smtp-Source: APXvYqw7rU6iOTwusHG68r9SHi91qbsO4oNQ6661SegnideCkJ81FmejXxOFksKV7ZBLo0jD9tClKg==
X-Received: by 2002:a63:b48:: with SMTP id a8mr38536305pgl.368.1557248801548;
        Tue, 07 May 2019 10:06:41 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:40 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 09/21] megaraid_sas: Enhance internal DCMD timeout prints
Date:   Tue,  7 May 2019 10:05:38 -0700
Message-Id: <1557248750-4099-10-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add prints to identify the internal DCMD opcode that has timed out,
for debugging.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 032d91b1f3ba..7449df36a092 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -1113,8 +1113,9 @@ megasas_issue_blocked_cmd(struct megasas_instance *instance,
 		ret = wait_event_timeout(instance->int_cmd_wait_q,
 				cmd->cmd_status_drv != MFI_STAT_INVALID_STATUS, timeout * HZ);
 		if (!ret) {
-			dev_err(&instance->pdev->dev, "Failed from %s %d DCMD Timed out\n",
-				__func__, __LINE__);
+			dev_err(&instance->pdev->dev,
+				"DCMD(opcode: 0x%x) is timed out, func:%s\n",
+				cmd->frame->dcmd.opcode, __func__);
 			return DCMD_TIMEOUT;
 		}
 	} else
@@ -1143,6 +1144,7 @@ megasas_issue_blocked_abort_cmd(struct megasas_instance *instance,
 	struct megasas_cmd *cmd;
 	struct megasas_abort_frame *abort_fr;
 	int ret = 0;
+	u32 opcode;
 
 	cmd = megasas_get_cmd(instance);
 
@@ -1178,8 +1180,10 @@ megasas_issue_blocked_abort_cmd(struct megasas_instance *instance,
 		ret = wait_event_timeout(instance->abort_cmd_wait_q,
 				cmd->cmd_status_drv != MFI_STAT_INVALID_STATUS, timeout * HZ);
 		if (!ret) {
-			dev_err(&instance->pdev->dev, "Failed from %s %d Abort Timed out\n",
-				__func__, __LINE__);
+			opcode = cmd_to_abort->frame->dcmd.opcode;
+			dev_err(&instance->pdev->dev,
+				"Abort(to be aborted DCMD opcode: 0x%x) is timed out func:%s\n",
+				opcode,  __func__);
 			return DCMD_TIMEOUT;
 		}
 	} else
-- 
2.16.1

