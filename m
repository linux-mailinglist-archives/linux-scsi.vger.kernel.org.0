Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8C54D25
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfFYLFJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44774 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so8653569plr.11
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x21bqmk9dLzO1D0BNR75+yjl+IKbX45VB/zMtMVbSDI=;
        b=avzhxG8wbhsi8UUhUecO+m84ZzYIuNfH39ntme7l4OzF1ouuoROq/Z3vKz0OcfCiFB
         ijZoSFaWf1pN03I/3iSi348B16ZP05+GGFReOL7zOdKEgKS5A4ruzEMjj4YlgpShHr8f
         BDDkoBsIMuxIoqVOHKG9S4yjgdYXI+Huoj+ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x21bqmk9dLzO1D0BNR75+yjl+IKbX45VB/zMtMVbSDI=;
        b=jiFsSgeTapgtElRHJsQfpT5HbE2LuxsqWDOynTz6e49yhk8LpjaHZ2Wu/+zowOCrgj
         N8n9Ea5GIT/UNSpRhRkrTRhGbL2GM/kkHrsrQ8j1npuDBAvgjB0+LIS5p8nF+iG4tEsL
         kslJikxV1f+8cfPLMisOo1LJWaeC4s0hbixOV5CeHjdhWShldZStoXM6QHTuz8RTixsS
         yVbKLyGd7cxDu3hMJG+yaeJCuB+N25W50j1jrMpbh3jIyM7UeXELsB3I36mjeObaUrMm
         Qhr34RSAYz7QF1FDXmAiCGyOpH5W1ZRD2FlA16r4ZC9VGiU7ITszH27pIrbDRxfTrP+6
         FQeg==
X-Gm-Message-State: APjAAAWD0GYdEVSGWmssbdIqlvT2r+fZ1RcFtXBv7QVMxgNVFO4sBh+k
        55hEHM6uxw3L8QoQqmBFjH6eIA/2WzIn0YNEj0veJt6RBCoBV73JPXkiFXF3x/Un9yc5R+rRwMP
        VsDpHZG6ZQ1xRV6xrE7p6pS1ECKi9ss1M/Z/NzB4SFFDx2M60oYUn68pJRrnCC8oCVg5C4ERqco
        sAydUZv8Qln4J/
X-Google-Smtp-Source: APXvYqzV/I0TEMCsJHuIPbszHT3B76H/12S4sPMdRf2pj/JbJxeEgH7Xh+CIAiJrrqv47O1gLjmLLA==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr92090963plb.64.1561460707796;
        Tue, 25 Jun 2019 04:05:07 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:07 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 05/18] megaraid_sas: Release Mutex lock before OCR in case of DCMD timeout
Date:   Tue, 25 Jun 2019 16:34:23 +0530
Message-Id: <20190625110436.4703-6-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Issue: There is possibility of few DCMDs timing out with 'reset_mutex'
lock held. As part of DCMD timeout handling, driver calls function
megasas_reset_fusion which also tries to acquire same lock 'reset_mutex'
and end up with deadlock.

Fix: Upon timeout of DCMDs(which are fired with 'reset_mutex' lock held),
driver will release 'reset_mutex' before calling OCR function and will
acquire lock again after OCR function returns.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 7d1cf4e..54bb48e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4369,8 +4369,10 @@ megasas_get_pd_info(struct megasas_instance *instance, struct scsi_device *sdev)
 		switch (dcmd_timeout_ocr_possible(instance)) {
 		case INITIATE_OCR:
 			cmd->flags |= DRV_DCMD_SKIP_REFIRE;
+			mutex_unlock(&instance->reset_mutex);
 			megasas_reset_fusion(instance->host,
 				MFI_IO_TIMEOUT_OCR);
+			mutex_lock(&instance->reset_mutex);
 			break;
 		case KILL_ADAPTER:
 			megaraid_sas_kill_hba(instance);
@@ -4861,8 +4863,10 @@ megasas_host_device_list_query(struct megasas_instance *instance,
 		switch (dcmd_timeout_ocr_possible(instance)) {
 		case INITIATE_OCR:
 			cmd->flags |= DRV_DCMD_SKIP_REFIRE;
+			mutex_unlock(&instance->reset_mutex);
 			megasas_reset_fusion(instance->host,
 				MFI_IO_TIMEOUT_OCR);
+			mutex_lock(&instance->reset_mutex);
 			break;
 		case KILL_ADAPTER:
 			megaraid_sas_kill_hba(instance);
@@ -5010,8 +5014,10 @@ void megasas_get_snapdump_properties(struct megasas_instance *instance)
 		switch (dcmd_timeout_ocr_possible(instance)) {
 		case INITIATE_OCR:
 			cmd->flags |= DRV_DCMD_SKIP_REFIRE;
+			mutex_unlock(&instance->reset_mutex);
 			megasas_reset_fusion(instance->host,
 				MFI_IO_TIMEOUT_OCR);
+			mutex_lock(&instance->reset_mutex);
 			break;
 		case KILL_ADAPTER:
 			megaraid_sas_kill_hba(instance);
@@ -5141,8 +5147,10 @@ megasas_get_ctrl_info(struct megasas_instance *instance)
 		switch (dcmd_timeout_ocr_possible(instance)) {
 		case INITIATE_OCR:
 			cmd->flags |= DRV_DCMD_SKIP_REFIRE;
+			mutex_unlock(&instance->reset_mutex);
 			megasas_reset_fusion(instance->host,
 				MFI_IO_TIMEOUT_OCR);
+			mutex_lock(&instance->reset_mutex);
 			break;
 		case KILL_ADAPTER:
 			megaraid_sas_kill_hba(instance);
@@ -6398,8 +6406,10 @@ megasas_get_target_prop(struct megasas_instance *instance,
 		switch (dcmd_timeout_ocr_possible(instance)) {
 		case INITIATE_OCR:
 			cmd->flags |= DRV_DCMD_SKIP_REFIRE;
+			mutex_unlock(&instance->reset_mutex);
 			megasas_reset_fusion(instance->host,
 					     MFI_IO_TIMEOUT_OCR);
+			mutex_lock(&instance->reset_mutex);
 			break;
 		case KILL_ADAPTER:
 			megaraid_sas_kill_hba(instance);
@@ -7801,10 +7811,13 @@ megasas_mgmt_fw_ioctl(struct megasas_instance *instance,
 		opcode = le32_to_cpu(cmd->frame->dcmd.opcode);
 
 	if (opcode == MR_DCMD_CTRL_SHUTDOWN) {
+		mutex_lock(&instance->reset_mutex);
 		if (megasas_get_ctrl_info(instance) != DCMD_SUCCESS) {
 			megasas_return_cmd(instance, cmd);
+			mutex_unlock(&instance->reset_mutex);
 			return -1;
 		}
+		mutex_unlock(&instance->reset_mutex);
 	}
 
 	if (opcode == MR_DRIVER_SET_APP_CRASHDUMP_MODE) {
-- 
2.9.5

