Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9732049D59
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfFRJcr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39049 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfFRJcr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so5466354pls.6
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k+VtLc4WyqsDZY5PU4sB86ptthuO0zTsd/EMjJ4soVA=;
        b=hbJTFWg4X9Nob9HV5wsMnivL6QWuWMe27JNCQmoXD2G4GBS/1mTCKexQG1fgsw+/s1
         KKDDvthvIuHRphhdowoLjLNk5kMQuurIOoDFgY+OXZIE6KHikTrXkob+rxo9gu0/ktx7
         5a4fVFr9PsUOpB2ZLEIUv430e47p5DHvZDL8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k+VtLc4WyqsDZY5PU4sB86ptthuO0zTsd/EMjJ4soVA=;
        b=XZgdBHGxYy73dU0u95zfxnvPYYMoQdPvqrGXpE14uS4UV+GDnAz7HYfkLPwO7xTFDT
         yiLDt6vUjPgPOqgF/OSrFfSi3Q95+wHOGd3j6UW+DG6dA9ztCrFjtw8Bo8RIwPoH3Ljy
         heNyTYPTUOzVT61108ssudzRKSxTADVdff7KgxbpkcmwiBuFhy00Xx+2iWfyGkvRB+7G
         zILpMqqnaroyo5I+ck/tViMQj9gvHPolcsSHkKlXQpxXyvJ4hZF+/YF7MlN/c2oWwbdz
         OqmkOScD0VBo9O3GekXK1IFQcOcWeY3dc1U7/Esjfnvl2uTFVld26mqtVGF0CBNSuIG7
         iXMg==
X-Gm-Message-State: APjAAAWPSN7mzw0oH8rs6jT7o0sHTM4MtK8SjqOWFN+jM9Fc19icyKmW
        K2OF8VWYqpayMd4yGlcttZNutZDzXf0nlOIiL9EgPbpiZfgcjDxtksbJ4lRuNXUumemwJshwmRY
        IkVDkLtLL6+mccS0/AIOZB5+su7H62w7rYO+y0RKGxkw06kfZNvjKSJ/O+3AcdwvtDOPi7uRh+6
        GsgVJL9dHADg==
X-Google-Smtp-Source: APXvYqyh/mwXcArml3QtHMzinr7S3sM3vuekPebiobCpNIvrygl3rRh0WPY/tUnUU6MTvyls9wpuvQ==
X-Received: by 2002:a17:902:740c:: with SMTP id g12mr59125451pll.128.1560850366162;
        Tue, 18 Jun 2019 02:32:46 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:45 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 06/18] megaraid_sas: In probe context, retry IOC INIT once if firmware is in fault
Date:   Tue, 18 Jun 2019 15:01:55 +0530
Message-Id: <20190618093207.9939-7-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Issue: Under certain conditions, controller goes in FAULT state after
IOC INIT fired to firmware. Such Fault can be recovered through controller
reset.

Fix: In driver probe context, if firmware fault is observed post IOC INIT,
driver would do controller reset followed by retry logic for IOC INIT
command.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 855199c..1d34609 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1009,6 +1009,7 @@ wait_and_poll(struct megasas_instance *instance, struct megasas_cmd *cmd,
 {
 	int i;
 	struct megasas_header *frame_hdr = &cmd->frame->hdr;
+	u32 status_reg;
 
 	u32 msecs = seconds * 1000;
 
@@ -1018,6 +1019,12 @@ wait_and_poll(struct megasas_instance *instance, struct megasas_cmd *cmd,
 	for (i = 0; (i < msecs) && (frame_hdr->cmd_status == 0xff); i += 20) {
 		rmb();
 		msleep(20);
+		if (!(i % 5000)) {
+			status_reg = instance->instancet->read_fw_status_reg(instance)
+					& MFI_STATE_MASK;
+			if (status_reg == MFI_STATE_FAULT)
+				break;
+		}
 	}
 
 	if (frame_hdr->cmd_status == MFI_STAT_INVALID_STATUS)
@@ -1722,6 +1729,7 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
 	struct fusion_context *fusion;
 	u32 scratch_pad_1;
 	int i = 0, count;
+	u32 status_reg;
 
 	fusion = instance->ctrl_context;
 
@@ -1804,8 +1812,21 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
 	if (megasas_alloc_cmds_fusion(instance))
 		goto fail_alloc_cmds;
 
-	if (megasas_ioc_init_fusion(instance))
-		goto fail_ioc_init;
+	if (megasas_ioc_init_fusion(instance)) {
+		status_reg = instance->instancet->read_fw_status_reg(instance);
+		if (((status_reg & MFI_STATE_MASK) == MFI_STATE_FAULT) &&
+		    (status_reg & MFI_RESET_ADAPTER)) {
+			/* Do a chip reset and then retry IOC INIT once */
+			if (megasas_adp_reset_wait_for_ready
+				(instance, true, 0) == FAILED)
+				goto fail_ioc_init;
+
+			if (megasas_ioc_init_fusion(instance))
+				goto fail_ioc_init;
+		} else {
+			goto fail_ioc_init;
+		}
+	}
 
 	megasas_display_intel_branding(instance);
 	if (megasas_get_ctrl_info(instance)) {
-- 
2.9.5

