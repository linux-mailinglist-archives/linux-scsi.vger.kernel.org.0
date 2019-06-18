Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4952049D58
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfFRJco (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33050 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfFRJco (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so7337903pfq.0
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x21bqmk9dLzO1D0BNR75+yjl+IKbX45VB/zMtMVbSDI=;
        b=Z/Yt7f2nQP+L+BudJvXi3sPni8YKDePlkFd9Rdp6o2Izoyfu4ZsplH2k1Mm825cknT
         KSNyCuAk3dBhfYvMhX6fxJIqNOAwqDqT2txfTxz9KQHokswNSImAiZc696nZ9nelL5/o
         y+wJ0zq+d1rhMa8GsMUjAx7SvHSxO48JmV3f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x21bqmk9dLzO1D0BNR75+yjl+IKbX45VB/zMtMVbSDI=;
        b=dWolplJ2KzFgyVvYcBEnCaCFTJSeDEPExfahS9pkcfQ9N4k6SMYCrcgCvrjxvwr0Xg
         LkIVxL2IdJR5gCkBhDCLbpP0TDw81SXNKI1eBrb50N9hhNs+LuV271KgqGGE3IK11zCs
         /OaBX6XouAmu8zWqF5mQQnxhRt9oh6yZq/N2L82akKD3NZLWgjDk79evgJY192rhdYs1
         dM+Nsq9WE8INJqdm9q8vYraFqlg+NI4ldKfH2Ft0R+1+rSZ0PvPSHHPA8c9HTfYW6aOe
         ST2FX9t4EX/kASeP4QDomsHbYubi/WAPPWkB1xl7i74Yn76vWP3g8RJmbdadI5kE5nfn
         a53g==
X-Gm-Message-State: APjAAAUVD4NTpcNxBA3xpp154y8ixJsaBpop0ZYbDeQ4Soeap/aoa1b4
        u1ldXJ3oY0iKA6ygm1GEFXMzUeHyAXVJS1DZQTggD659enq7h5nsfLoW+jiN9GEiNPjUhe1rLAe
        sWRA1VIBYEKuauZ2GTYCWmUaU6Ep4SdakY5nylCjH9Y37qcT5baVjaW4JF3k7X9wutgPbp5GWQd
        JtDWVJYa5lNA==
X-Google-Smtp-Source: APXvYqygAsrt8KDFbah6rkxM0B8TJyiRHwHXNRNaeKIao1oYY7KgHIyi+cohFGAZpjqo8NryLvnlmA==
X-Received: by 2002:aa7:90c9:: with SMTP id k9mr44486546pfk.171.1560850363173;
        Tue, 18 Jun 2019 02:32:43 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:42 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 05/18] megaraid_sas: Release Mutex lock before OCR in case of DCMD timeout
Date:   Tue, 18 Jun 2019 15:01:54 +0530
Message-Id: <20190618093207.9939-6-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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

