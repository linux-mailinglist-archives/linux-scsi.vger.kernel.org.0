Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B577168C7
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfEGRHE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34355 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck18so8495610plb.1
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zqlad5jQIKPc+MIklfDYLl9c85Crem7srgoO0xdfp54=;
        b=R5nrM4M8jpV8DSiPebkp6UaVKxKeu3HBnebnW5jDHrUJRimZWGIEep4sRoOCOEsn5l
         GbQtzc9KIRNipbkzVUtjRjB7KE8ec1aZe5aO5/8PR0zwpbtwVm6se9EB3fMxpRoTZqKE
         rOeIOc+MEMukJKQ3+1ehAU1NNxmDaUHeHgBic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zqlad5jQIKPc+MIklfDYLl9c85Crem7srgoO0xdfp54=;
        b=PcVyenHiMf80zY9NvAVJwRMLu5gyFB4lD60xnMled4PH2gU0BFdnzLnfdLoqLvY/PF
         w67D76rQGN0n9H7cnVA4n4VW/cJb1nY/m3sRCXPQMgyFRZ5u3Mc4cyMQoG88cjXf+sE6
         QieXqGbubIUujBkTFOayA0vl4KUlpk1JtupbxD6cHpowny3ZJuuWyfDgI/yMXye5RER8
         Ujl1n4PDTN4VP/jjXhPS8u6OkANsHYydDo/9ChaAHfpYJ7LUzZuOakx5pWP3J5s8gTnP
         tqgQuYFVi6FEQ8X/uGOTkX6dRUDTqS+ek5klZ7fRixuzTlfp+lqyUnwn0D/GbUsW5sFk
         fftA==
X-Gm-Message-State: APjAAAXwkflKWhlEIInsC+vMHvyxVv8ADFaoxfrYpxU0tQEHIMeDKfUY
        w/Fwaw4uhe7IKPVRMJrFRgbbF7ch63nDsdg3IpPSLx1c89EE/Kw94IPWgLOL8Lgy+jNlqbfBqnP
        XoYHzxi9FJbBn7J3454V51OMSw3PLOZhLxrWGQ81Gv8GXTHyiQZfZzkh6SEfDszH5A1CffPTrCB
        YKwV+CfG0Zy/690PeI1I3K
X-Google-Smtp-Source: APXvYqyBweSnVT+dUqM0fEvipspc7VvlfH7kD/ppbTU9qNH4uO3GxuVXL4ow3gtheQbzg87j9cqsLg==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr39343704plo.32.1557248822945;
        Tue, 07 May 2019 10:07:02 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:07:02 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 15/21] megaraid_sas: Print FW fault information
Date:   Tue,  7 May 2019 10:05:44 -0700
Message-Id: <1557248750-4099-16-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When driver detects a firmware fault during load, dump additional
information on fault code and subcode that will help in debugging.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  2 ++
 drivers/scsi/megaraid/megaraid_sas_base.c   |  5 ++++-
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 25 ++++++++++++++-----------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 27980d68cf1b..8df6ef01785e 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -135,6 +135,8 @@
 #define MFI_RESET_ADAPTER			0x00000002
 #define MEGAMFI_FRAME_SIZE			64
 
+#define MFI_STATE_FAULT_CODE			0x0FFF0000
+#define MFI_STATE_FAULT_SUBCODE			0x0000FF00
 /*
  * During FW init, clear pending cmds & reset state using inbound_msg_0
  *
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index c560d1e748f4..4689909fa66b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3919,7 +3919,10 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 		switch (fw_state) {
 
 		case MFI_STATE_FAULT:
-			dev_printk(KERN_DEBUG, &instance->pdev->dev, "FW in FAULT state!!\n");
+			dev_printk(KERN_ERR, &instance->pdev->dev,
+				   "FW in FAULT state, Fault code:0x%x subcode:0x%x func:%s\n",
+				   abs_state & MFI_STATE_FAULT_CODE,
+				   abs_state & MFI_STATE_FAULT_SUBCODE, __func__);
 			if (ocr) {
 				max_wait = MEGASAS_RESET_WAIT_TIME;
 				cur_state = MFI_STATE_FAULT;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index b4f798b458f0..4c78e4caf910 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3984,7 +3984,7 @@ megasas_check_reset_fusion(struct megasas_instance *instance,
 static inline void megasas_trigger_snap_dump(struct megasas_instance *instance)
 {
 	int j;
-	u32 fw_state;
+	u32 fw_state, abs_state;
 
 	if (!instance->disableOnlineCtrlReset) {
 		dev_info(&instance->pdev->dev, "Trigger snap dump\n");
@@ -3994,11 +3994,13 @@ static inline void megasas_trigger_snap_dump(struct megasas_instance *instance)
 	}
 
 	for (j = 0; j < instance->snapdump_wait_time; j++) {
-		fw_state = instance->instancet->read_fw_status_reg(instance) &
-				MFI_STATE_MASK;
+		abs_state = instance->instancet->read_fw_status_reg(instance);
+		fw_state = abs_state & MFI_STATE_MASK;
 		if (fw_state == MFI_STATE_FAULT) {
-			dev_err(&instance->pdev->dev,
-				"Found FW in FAULT state, after snap dump trigger\n");
+			dev_printk(KERN_ERR, &instance->pdev->dev,
+				   "FW in FAULT state Fault code:0x%x subcode:0x%x func:%s\n",
+				   abs_state & MFI_STATE_FAULT_CODE,
+				   abs_state & MFI_STATE_FAULT_SUBCODE, __func__);
 			return;
 		}
 		msleep(1000);
@@ -4010,7 +4012,7 @@ int megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
 					int reason, int *convert)
 {
 	int i, outstanding, retval = 0, hb_seconds_missed = 0;
-	u32 fw_state;
+	u32 fw_state, abs_state;
 	u32 waittime_for_io_completion;
 
 	waittime_for_io_completion =
@@ -4029,12 +4031,13 @@ int megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
 
 	for (i = 0; i < waittime_for_io_completion; i++) {
 		/* Check if firmware is in fault state */
-		fw_state = instance->instancet->read_fw_status_reg(instance) &
-				MFI_STATE_MASK;
+		abs_state = instance->instancet->read_fw_status_reg(instance);
+		fw_state = abs_state & MFI_STATE_MASK;
 		if (fw_state == MFI_STATE_FAULT) {
-			dev_warn(&instance->pdev->dev, "Found FW in FAULT state,"
-			       " will reset adapter scsi%d.\n",
-				instance->host->host_no);
+			dev_printk(KERN_ERR, &instance->pdev->dev,
+				   "FW in FAULT state Fault code:0x%x subcode:0x%x func:%s\n",
+				   abs_state & MFI_STATE_FAULT_CODE,
+				   abs_state & MFI_STATE_FAULT_SUBCODE, __func__);
 			megasas_complete_cmd_dpc_fusion((unsigned long)instance);
 			if (instance->requestorId && reason) {
 				dev_warn(&instance->pdev->dev, "SR-IOV Found FW in FAULT"
-- 
2.16.1

