Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6352168BA
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEGRGY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44270 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so4465217plj.11
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZmw5ywIbzOc8VruWmb764fG6flSNtrbuGspqfBaQaI=;
        b=J1qcqjZPbPBnHndft+52+YMdtr+C+61qR+qA4HjPd6tQ36giiQjV9q/kd8ni58Ggt1
         Zsmv/ty4GsQJZ8f85C01qVbWKHL7KBGJ28CoNEIv/8s4f7ebrEwHMWKpIiZVnSkldlyw
         Yr3ROqSGYPR0PwqiJnznoTb2WLd1mFMyn6lq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZmw5ywIbzOc8VruWmb764fG6flSNtrbuGspqfBaQaI=;
        b=XA4HWW60jMSdZGUF2tJDbk00ObRKS997dEfDTzZNSDnGePl0CSFpLzhKcS9Mv+M/2n
         WyZFcNxJ9VMqlurpZGRfY1KGpauSvlCvCaKAf2yjnsSJxArW8N9+CXbHTXmsKcmnAxIJ
         CxoOLk5EjqOnulryb4qcb2Xe+cMZ/cikNLcotku6+cfuy0nlA+jT91CXubQXGmJyx+Lk
         Cjk7rJJ3HLdFCg8TgkF9VwhDVelIqWo/gVx9N+jPjGXG6osnQwOASGut7x8lPqDvuoyp
         lBxMtGvQ/Af8KHq4sZDilgGVZIH1URTMIy7+NfGemSnTHXE2TPyVqNtzpXA5s54Hft3R
         be0w==
X-Gm-Message-State: APjAAAWlWkGUOvfbeOkcSCTJez4BV3gIbmiGzlC97iuM+mYJXZVmuLIB
        5C+mu60LDLWVG6gHe4lEfS22XOg+tItKG+E9b6ChP8SWpMQqDL/asjXo0r6sYh3ZTgj6fmOvgmk
        z1i31q3aGIs3p7c2/juZiSNbW6TL/XIx0Fa9xdlLiFuNjvsyL94olyPRjAdZBAxa38dSmq5poo0
        2D/zvOSVklZqf8cUYj+TDu
X-Google-Smtp-Source: APXvYqyq5qJyyyGpxuBM1JAn8aPwKVW+OOBVdINn4gK6cAj7upAcLV5ncaH/vcflgr8iZysOzF5OZQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr42282448plb.202.1557248782969;
        Tue, 07 May 2019 10:06:22 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:22 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 04/21] megaraid_sas: rework code around controller reset
Date:   Tue,  7 May 2019 10:05:33 -0700
Message-Id: <1557248750-4099-5-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

No functional change.
This patch reworks code around controller reset path which gets rid
of a couple of goto labels.
This is in preparation for the next patch which adds PCI config
space access locking while controller reset is in progress.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  1 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 23 ++++++++++-------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 6fd57f7f0b1e..902b11b97999 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -1571,6 +1571,7 @@ enum FW_BOOT_CONTEXT {
 #define MFI_IO_TIMEOUT_SECS			180
 #define MEGASAS_SRIOV_HEARTBEAT_INTERVAL_VF	(5 * HZ)
 #define MEGASAS_OCR_SETTLE_TIME_VF		(1000 * 30)
+#define MEGASAS_SRIOV_MAX_RESET_TRIES_VF	1
 #define MEGASAS_ROUTINE_WAIT_TIME_VF		300
 #define MFI_REPLY_1078_MESSAGE_INTERRUPT	0x80000000
 #define MFI_REPLY_GEN2_MESSAGE_INTERRUPT	0x00000001
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index bf1fa963af0b..76bd29c92752 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -4568,6 +4568,8 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 	struct scsi_device *sdev;
 	int ret_target_prop = DCMD_FAILED;
 	bool is_target_prop = false;
+	bool do_adp_reset = true;
+	int max_reset_tries = MEGASAS_FUSION_MAX_RESET_TRIES;
 
 	instance = (struct megasas_instance *)shost->hostdata;
 	fusion = instance->ctrl_context;
@@ -4686,34 +4688,30 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 		/* Let SR-IOV VF & PF sync up if there was a HB failure */
 		if (instance->requestorId && !reason) {
 			msleep(MEGASAS_OCR_SETTLE_TIME_VF);
-			goto transition_to_ready;
+			do_adp_reset = false;
+			max_reset_tries = MEGASAS_SRIOV_MAX_RESET_TRIES_VF;
 		}
 
 		/* Now try to reset the chip */
-		for (i = 0; i < MEGASAS_FUSION_MAX_RESET_TRIES; i++) {
+		for (i = 0; i < max_reset_tries; i++) {
 
-			if (instance->instancet->adp_reset
+			if (do_adp_reset &&
+			    instance->instancet->adp_reset
 				(instance, instance->reg_set))
 				continue;
-transition_to_ready:
+
 			/* Wait for FW to become ready */
 			if (megasas_transition_to_ready(instance, 1)) {
 				dev_warn(&instance->pdev->dev,
 					"Failed to transition controller to ready for "
 					"scsi%d.\n", instance->host->host_no);
-				if (instance->requestorId && !reason)
-					goto fail_kill_adapter;
-				else
-					continue;
+				continue;
 			}
 			megasas_reset_reply_desc(instance);
 			megasas_fusion_update_can_queue(instance, OCR_CONTEXT);
 
 			if (megasas_ioc_init_fusion(instance)) {
-				if (instance->requestorId && !reason)
-					goto fail_kill_adapter;
-				else
-					continue;
+				continue;
 			}
 
 			if (megasas_get_ctrl_info(instance)) {
@@ -4799,7 +4797,6 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 
 			goto out;
 		}
-fail_kill_adapter:
 		/* Reset failed, kill the adapter */
 		dev_warn(&instance->pdev->dev, "Reset failed, killing "
 		       "adapter scsi%d.\n", instance->host->host_no);
-- 
2.16.1

