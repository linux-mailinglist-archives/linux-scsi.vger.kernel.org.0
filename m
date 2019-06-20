Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AB74CC54
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfFTKw7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:52:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35493 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKw6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:52:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so1466481pfd.2
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mveVJiAznNjg5E86Wj26dh5RZ/LgPI6cFDk8lk8GhzU=;
        b=N3pk1BWWw5IJvi8/mjwazahI2kpJ1xAiyPtSi7AzppmkFa39q9mltv74u/WXXjqQJc
         /H+IkvWFfTgcm76NLfqGc2e9/mQPEFFd4yrBaneUiJcSbIfVOY++WNSV/TynTTDnJwhe
         7dtDOX1rTfJGiEcCbAOLCkq++sH12o3nYrSwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mveVJiAznNjg5E86Wj26dh5RZ/LgPI6cFDk8lk8GhzU=;
        b=jeyx0kgj8fzSjVxMt7e8Ew9oGZW3nTa/x5Vyio/Q4bq3T5pu6YHRtMdV6RCxmKyOMY
         o+Gt7vqVnes7nqIGhjB4FEsiXZxVKz+5IZXbsoLYsaXhPoO8lPscUhZENfqNNKTBiiqa
         LlSMCk23OTPa5aLaaHCoLL/ENVpRS4MgxXlOd5Xz+BHqPQuhD3UwbRkm/6nlzo2cAUR2
         E1JxRbfAln5dXrXSKBtuH93yWjQGFF3wiz8nLhyujRz3P1QrOcfpSMjXn8ikT8O8nJ2H
         jgT9gGdjqdDELF7jlJlFAILMyHMtl0YfyuO6oqtpPU/uewZIVEm/HpW5Kyo8q3bzu/Qr
         EV1A==
X-Gm-Message-State: APjAAAXDiAmEYtjtU6DJ6tK4QYHu08tja0e1CFrt90bbBRx0GmKYdAK6
        A7dS1HGzF4Y46T2ZNjLZFjci4pt2Ks/t+pBf5Yx8JjhUOk/g3H1Tk9Y1Ef6CvZOBC1uaO4SaTaC
        iQg5+dMxUDwru5znx7tTh+Nb3cPxS7Mmh3eO2h5Pt/D6k8qAkG2+MLR9XNlUE/ljYcT0p5XwqPg
        Eqx7AYDslOiOmxGdM=
X-Google-Smtp-Source: APXvYqwQ6Xqj50qqLLoKl3hcRp/XdxvGJcf++VUOkwisFn+sqDTvSoY82kJbugTHZmJgrOboSv9Ezw==
X-Received: by 2002:a62:e511:: with SMTP id n17mr119775257pff.181.1561027977751;
        Thu, 20 Jun 2019 03:52:57 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:52:57 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 06/18] megaraid_sas: In probe context, retry IOC INIT once if firmware is in fault
Date:   Thu, 20 Jun 2019 16:21:56 +0530
Message-Id: <20190620105208.15011-7-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

