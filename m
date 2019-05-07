Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C15168CA
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEGRHP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42387 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id 13so8664194pfw.9
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6T7C4DHZfs5d/tAliVqBd8MYVdXzJSegSHZ8GtbFr3M=;
        b=QpIOQksvuJYEmYH30FYUszi1mg+s4iBb2r2sSkTuWjVcHb5EmJD0ru1KwCfwh3i7RK
         ZYrQcuo2wphFa/Bpc6dUsV2hb7a52hq5OkcWwcgN81HdgVAY1Z+draJhSPwmfZoJjEdI
         LsN2Fh09PLRTz8SB321bL/06B8+sou4OHLPNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6T7C4DHZfs5d/tAliVqBd8MYVdXzJSegSHZ8GtbFr3M=;
        b=Ig+digsuwSe/3LxsIgJ/AhNoHsn4OkZoZGhQnYl5cUqnUvvBIGL8X8Fg7JMP0NIBhb
         sq4qTBzCmbb1pyac1yFLO1v2HxCngCOTsjslGtOUMkLAE+C143VX/Pu+bzUr/t3aZbgD
         57xAtUQjP0TkV1fbeZHTmmlxWgY9vpHE4sBqLzulmsZojl+DpjLzrbUuW5HF5DLO0wxU
         0l7yTKlnAajs50JAAaIIwQXGEzaDlpwRMlg/sx/CrlgUyJSqB0jtx0ZoG+GRBOF5PeJX
         8ddSahicGNJXAnx0CY5gTuupMmPoLLXAzIDDA6FZuoGR2E1g5lAPZygdbAp6RbMIUEi2
         s91Q==
X-Gm-Message-State: APjAAAX8v2sn2eLJeQd6xh/rSO3z4h9s7M3CyQAV9U0hOUlhp66kd9GI
        oYylt9d1qG8R5lcYJlak3yVFH7yFUo1nMWDK4JSuruXOe7KrC/AB9Tr6+ReeC+d7isMwcWYzHEX
        Z695QduqfAzfujutWhDSVW9yK4Sw+b07E4moAsHs5hcFbjhZbpU3xgFWANUbETMGHxInnKFbGQP
        Wm++BtnodBb67XeqgZwiIZ
X-Google-Smtp-Source: APXvYqxfrgNfnZWM+SxHIrbaTkUy0QITafpCvyzXCpz59hnXndcBDybpJ91H8AJBjVXYZxaQ4MhZ6g==
X-Received: by 2002:a65:4144:: with SMTP id x4mr41585145pgp.282.1557248833484;
        Tue, 07 May 2019 10:07:13 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:07:12 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 18/21] megaraid_sas: Add debug prints for device list
Date:   Tue,  7 May 2019 10:05:47 -0700
Message-Id: <1557248750-4099-19-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add debug prints related to device list being returned by firmware.
The a debug flag to activate these prints.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h      |  1 +
 drivers/scsi/megaraid/megaraid_sas_base.c | 35 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 8df6ef01785e..840506f2f33c 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -1499,6 +1499,7 @@ struct megasas_ctrl_info {
 /* Driver's internal Logging levels*/
 #define OCR_DEBUG    (1 << 0)
 #define TM_DEBUG     (1 << 1)
+#define LD_PD_DEBUG    (1 << 2)
 
 #define SCAN_PD_CHANNEL	0x1
 #define SCAN_VD_CHANNEL	0x2
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b40702e30e49..b9893f8ccf4d 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4512,6 +4512,9 @@ megasas_get_pd_list(struct megasas_instance *instance)
 
 	case DCMD_SUCCESS:
 		pd_addr = ci->addr;
+		if (megasas_dbg_lvl & LD_PD_DEBUG)
+			dev_info(&instance->pdev->dev, "%s, sysPD count: 0x%x\n",
+				 __func__, le32_to_cpu(ci->count));
 
 		if ((le32_to_cpu(ci->count) >
 			(MEGASAS_MAX_PD_CHANNELS * MEGASAS_MAX_DEV_PER_CHANNEL)))
@@ -4527,6 +4530,11 @@ megasas_get_pd_list(struct megasas_instance *instance)
 					pd_addr->scsiDevType;
 			instance->local_pd_list[le16_to_cpu(pd_addr->deviceId)].driveState	=
 					MR_PD_STATE_SYSTEM;
+			if (megasas_dbg_lvl & LD_PD_DEBUG)
+				dev_info(&instance->pdev->dev,
+					 "PD%d: targetID: 0x%03x deviceType:0x%x\n",
+					 pd_index, le16_to_cpu(pd_addr->deviceId),
+					 pd_addr->scsiDevType);
 			pd_addr++;
 		}
 
@@ -4630,6 +4638,10 @@ megasas_get_ld_list(struct megasas_instance *instance)
 		break;
 
 	case DCMD_SUCCESS:
+		if (megasas_dbg_lvl & LD_PD_DEBUG)
+			dev_info(&instance->pdev->dev, "%s, LD count: 0x%x\n",
+				 __func__, ld_count);
+
 		if (ld_count > instance->fw_supported_vd_count)
 			break;
 
@@ -4639,6 +4651,10 @@ megasas_get_ld_list(struct megasas_instance *instance)
 			if (ci->ldList[ld_index].state != 0) {
 				ids = ci->ldList[ld_index].ref.targetId;
 				instance->ld_ids[ids] = ci->ldList[ld_index].ref.targetId;
+				if (megasas_dbg_lvl & LD_PD_DEBUG)
+					dev_info(&instance->pdev->dev,
+						 "LD%d: targetID: 0x%03x\n",
+						 ld_index, ids);
 			}
 		}
 
@@ -4742,6 +4758,10 @@ megasas_ld_list_query(struct megasas_instance *instance, u8 query_type)
 	case DCMD_SUCCESS:
 		tgtid_count = le32_to_cpu(ci->count);
 
+		if (megasas_dbg_lvl & LD_PD_DEBUG)
+			dev_info(&instance->pdev->dev, "%s, LD count: 0x%x\n",
+				 __func__, tgtid_count);
+
 		if ((tgtid_count > (instance->fw_supported_vd_count)))
 			break;
 
@@ -4749,6 +4769,9 @@ megasas_ld_list_query(struct megasas_instance *instance, u8 query_type)
 		for (ld_index = 0; ld_index < tgtid_count; ld_index++) {
 			ids = ci->targetId[ld_index];
 			instance->ld_ids[ids] = ci->targetId[ld_index];
+			if (megasas_dbg_lvl & LD_PD_DEBUG)
+				dev_info(&instance->pdev->dev, "LD%d: targetID: 0x%03x\n",
+					 ld_index, ci->targetId[ld_index]);
 		}
 
 		break;
@@ -4828,6 +4851,10 @@ megasas_host_device_list_query(struct megasas_instance *instance,
 		 */
 		count = le32_to_cpu(ci->count);
 
+		if (megasas_dbg_lvl & LD_PD_DEBUG)
+			dev_info(&instance->pdev->dev, "%s, Device count: 0x%x\n",
+				 __func__, count);
+
 		memset(instance->local_pd_list, 0,
 		       MEGASAS_MAX_PD * sizeof(struct megasas_pd_list));
 		memset(instance->ld_ids, 0xff, MAX_LOGICAL_DRIVES_EXT);
@@ -4839,8 +4866,16 @@ megasas_host_device_list_query(struct megasas_instance *instance,
 						ci->host_device_list[i].scsi_type;
 				instance->local_pd_list[target_id].driveState =
 						MR_PD_STATE_SYSTEM;
+				if (megasas_dbg_lvl & LD_PD_DEBUG)
+					dev_info(&instance->pdev->dev,
+						 "Device %d: PD targetID: 0x%03x deviceType:0x%x\n",
+						 i, target_id, ci->host_device_list[i].scsi_type);
 			} else {
 				instance->ld_ids[target_id] = target_id;
+				if (megasas_dbg_lvl & LD_PD_DEBUG)
+					dev_info(&instance->pdev->dev,
+						 "Device %d: LD targetID: 0x%03x\n",
+						 i, target_id);
 			}
 		}
 
-- 
2.16.1

