Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8031254D26
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfFYLFM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43385 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so8789726pgv.10
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mveVJiAznNjg5E86Wj26dh5RZ/LgPI6cFDk8lk8GhzU=;
        b=GmnyJJQDe1wrNdcJBBW9N7XyS3ZqEzwmfsflhECYGcTzykT4gV3Q0/KQyDdEvzI6kH
         DyWXBhKi0KmbVvQQdthkHn4pJui0QZH6F+bLuBt7LYGtNcqqheCfs4r6agQoA/+R4q2/
         LOW9b7CB7IFBRpWlxsM90VhopUyDlyNmNJsNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mveVJiAznNjg5E86Wj26dh5RZ/LgPI6cFDk8lk8GhzU=;
        b=MyfrzE5eSfFmpaW1DvFOecf9rXigPy+Y7Axk1/MU6oR4hx1p1XsjMHmyfd4p/C8odQ
         NZ6f0g6D7Bnoq1/f9XIPfobrjaxRhEzoImiZqkGl3y3dsO9Pej/QNAj2nPZDUneg5eJB
         9mpEoknRoodPxlrwg6CcTMV7lm30aNYXPg2hSDbTN7w2upDLfk/qbqmLg/fqP1KCAW34
         b9lu9L55TdhSbLn7jdEkHJD17fScFs+yF/8RyJCCrGduZXCubcyQlMiouhp7cMNeFbYD
         Kk565GmIv/Cw1BJ+wL/bgXT1c1FfFre8sU/ZPJJdbYQggrqh/lbpXw3YHZs26nlZ7BuU
         aXZw==
X-Gm-Message-State: APjAAAUigHivCfTuRP5FlduzSESKhpudz68GV5/U86MAwhw4spjTM8Jf
        V+u5HndOV95CTqvLe8C4LQR9fvqaZElqtSDJv6O+psSWUVcPje+LJUZ2J3F71IAN8i9na219F5t
        Q0RjR/1Hr/HSO9w7BScE9MPrNnR0HSnyHcTgRqCH+oCa1funMckezScrOWWPyfTa00QZLlwp+83
        BmkJY01bnucY82
X-Google-Smtp-Source: APXvYqw3GwOT285Ivaze4vy9EbGLcSZ6uWvZRtVTaltML0xoVwBr8Pb6rLkXT1N7Z53hdGwAqQtSdQ==
X-Received: by 2002:a63:c03:: with SMTP id b3mr27660113pgl.68.1561460710894;
        Tue, 25 Jun 2019 04:05:10 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:10 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 06/18] megaraid_sas: In probe context, retry IOC INIT once if firmware is in fault
Date:   Tue, 25 Jun 2019 16:34:24 +0530
Message-Id: <20190625110436.4703-7-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
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
index b8a5bbf..2e711b1 100644
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
@@ -1720,6 +1727,7 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
 	struct fusion_context *fusion;
 	u32 scratch_pad_1;
 	int i = 0, count;
+	u32 status_reg;
 
 	fusion = instance->ctrl_context;
 
@@ -1802,8 +1810,21 @@ megasas_init_adapter_fusion(struct megasas_instance *instance)
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

