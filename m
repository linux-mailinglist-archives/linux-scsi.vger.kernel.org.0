Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008784CC53
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFTKwz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:52:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35489 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKwz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:52:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1466390pfd.2
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x21bqmk9dLzO1D0BNR75+yjl+IKbX45VB/zMtMVbSDI=;
        b=CLTjePUgj8+tEk+9K+jginmNbqRPbTXnzn39VoYMNE9YVYpUJSpOf8EbZm+jgy7We6
         6UHCIx33EoxqgeWlQrexBX274cHiSTUEKC8AnJiRHExbLKvTQkjdB17oTk5she2jUL8f
         FweqR8diZ9PrdnRtfMAf7muqlAOY1QmLQqxtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x21bqmk9dLzO1D0BNR75+yjl+IKbX45VB/zMtMVbSDI=;
        b=OefpqwhqRVsLMphstUryTWqlictdkGVo0e9YWwTjNSYVRt0cBEP3t9YySt05/vXVTZ
         zSNc4A4VFnp1HHCjjsJ3cDmsb9P7r3PlgZnc/NthV+aCtHAHHoAv8Um8A4kcFlnCUAOI
         /NHrjOqeGgBCHqHbUrHAtzcEWplmnOLUQeuIa1zp3AciP7B1HpoKTKQtRiDPNtxaLWyy
         GYZVPR4rOkH9wOouKq99kX0JMuxqqOCGljp5eXGGR+GJfWuc80h7gpKQPQiQ7TBhRnep
         M56otBlbMT1/pkY7tsoepFO1K54IK7M2OmHkGOweTZGXoyK53+POTPJHnxP6/klIo3rK
         HWvg==
X-Gm-Message-State: APjAAAUMMoNYxfMQ/95aOjqiF8pd8hGB1Q61GLHZk1YD8tf+kIrmA7va
        IMPYYSPK5YEsCSqv51xdfWBTtkJfg2Q2AFae0579stha6fnZCHfUjgxkrk7CWIW8XmURcUqUe7j
        BPzquWHztyZKsp7l9rKu57bNeHLHx3sw+sMGgDxOS+Oo/RpYB8xH8kEafzPi3wvrxQhoBchdG2K
        jSukJWnDgMRO2QHfM=
X-Google-Smtp-Source: APXvYqzGlDfvNQafyGcbDZmxb6VB0X6CJ6qbxRE3jYkYvxiQLhQz8U6VJtlRyrNw+MhWU1xuSEebAQ==
X-Received: by 2002:a63:231a:: with SMTP id j26mr12100527pgj.389.1561027974305;
        Thu, 20 Jun 2019 03:52:54 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:52:53 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 05/18] megaraid_sas: Release Mutex lock before OCR in case of DCMD timeout
Date:   Thu, 20 Jun 2019 16:21:55 +0530
Message-Id: <20190620105208.15011-6-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

