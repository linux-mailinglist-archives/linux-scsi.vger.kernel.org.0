Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83AC49D62
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfFRJdH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:33:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41157 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfFRJdG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:33:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so7355607pgg.8
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stibehcr0+0AJFjqXm/b2GXe/lR/DqR9cTHJVhep/Ic=;
        b=TBf7gXcQlsH/cKNSq1/gUAmUaEVyBQKn0rFhQ+7jAsBHOd2JDzeiBUnmEUd5vEZArB
         MR9V9f6/iKIjW3b2+ouxS+Tml2AH+M2pDGMDlr276WJo8WV7sbwYnI8JXQF9XUreWdUk
         XesUUa8gjnKXHpKHwnW1ZfFDMbhrs6lDaVZ6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stibehcr0+0AJFjqXm/b2GXe/lR/DqR9cTHJVhep/Ic=;
        b=s5cAHpBqQ5Nn/48RxVZXtFALbnjoVOaujHMUcU6TbH7gR7SAa4T/7h2RYfZo45ny8X
         mq+8tgQojnhT7BcjzZhE2Q+EfDVx9PV+SrHyI7XXPmtKQEdAAD7DLAups2iizdOY2PzX
         n8xDw7jpx1Vh4xvQ4+7P7QtrUchLGy3j3ydHYTUeerQc28RlLZwGujIaDaoIphWsx1BO
         6k1ebrhDhbb/Xt1Xn1SV9/wbQz7/6+uncYDL6s9Z/Bb95MCD04qgjrQtwCe4NEs12XDp
         vLcdh1GjDhVB6rXu/8Smza3Tg+5NX2OJSQ37NzewTjMUZd8VfjkA5oTYZ0Au4MDd6A/Z
         +xWg==
X-Gm-Message-State: APjAAAU2xTOuVtDo2jSBxiGutEWQ6aC4jgKMqiUbdiXDYZYrZscG5Mi5
        2aa38tT5L1/wVTBdcITaO0LV6dFOd7bLxTnqNUlugdLUzJh1vlaJmUQRYwvg74buZE9ADP7X0BY
        LGedIj0KOJY1Jv7KcoXmC9fWJuBhFiheYRT0Q6qgcWorHS3EsFqocIrHnloPDtcaeZkq9HIeAwL
        q3NLBoXb5z2Q==
X-Google-Smtp-Source: APXvYqyCuzZEoiADqw3uXB9hsehdUs9/Pv6q6BgBJ+zf2nSQ37NLrZU/LmUw9nQd8aeJVZDOBCPflw==
X-Received: by 2002:a63:fa0d:: with SMTP id y13mr1801625pgh.258.1560850384926;
        Tue, 18 Jun 2019 02:33:04 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.33.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:33:04 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 12/18] megaraid_sas: Add support for MPI toolbox commands
Date:   Tue, 18 Jun 2019 15:02:01 +0530
Message-Id: <20190618093207.9939-13-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Added driver support to allow passthrough MPI toolbox type MFI commands
to firmware based on firmware capability.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        | 36 ++++++++++++++++++++++++++++-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 31 ++++++++++++++++++++++++-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  7 ++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index cd63281..83baac3 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -208,6 +208,7 @@ enum MFI_CMD_OP {
 	MFI_CMD_SMP		= 0x7,
 	MFI_CMD_STP		= 0x8,
 	MFI_CMD_NVME		= 0x9,
+	MFI_CMD_TOOLBOX		= 0xa,
 	MFI_CMD_OP_COUNT,
 	MFI_CMD_INVALID		= 0xff
 };
@@ -1467,7 +1468,39 @@ struct megasas_ctrl_info {
 
 	u8 reserved6[64];
 
-	u32 rsvdForAdptOp[64];
+	struct {
+	#if defined(__BIG_ENDIAN_BITFIELD)
+		u32 reserved:19;
+		u32 support_pci_lane_margining: 1;
+		u32 support_psoc_update:1;
+		u32 support_force_personality_change:1;
+		u32 support_fde_type_mix:1;
+		u32 support_snap_dump:1;
+		u32 support_nvme_tm:1;
+		u32 support_oce_only:1;
+		u32 support_ext_mfg_vpd:1;
+		u32 support_pcie:1;
+		u32 support_cvhealth_info:1;
+		u32 support_profile_change:2;
+		u32 mr_config_ext2_supported:1;
+	#else
+		u32 mr_config_ext2_supported:1;
+		u32 support_profile_change:2;
+		u32 support_cvhealth_info:1;
+		u32 support_pcie:1;
+		u32 support_ext_mfg_vpd:1;
+		u32 support_oce_only:1;
+		u32 support_nvme_tm:1;
+		u32 support_snap_dump:1;
+		u32 support_fde_type_mix:1;
+		u32 support_force_personality_change:1;
+		u32 support_psoc_update:1;
+		u32 support_pci_lane_margining: 1;
+		u32 reserved:19;
+	#endif
+	} adapter_operations5;
+
+	u32 rsvdForAdptOp[63];
 
 	u8 reserved7[3];
 
@@ -2399,6 +2432,7 @@ struct megasas_instance {
 	u8 enable_fw_dev_list;
 	bool atomic_desc_support;
 	bool support_seqnum_jbod_fp;
+	bool support_pci_lane_margining;
 };
 
 struct MR_LD_VF_MAP {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 81e708b..4c7a093 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -188,6 +188,7 @@ static u32 support_poll_for_event;
 u32 megasas_dbg_lvl;
 static u32 support_device_change;
 static bool support_nvme_encapsulation;
+static bool support_pci_lane_margining;
 
 /* define lock for aen poll */
 spinlock_t poll_aen_lock;
@@ -3494,6 +3495,7 @@ megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
 	case MFI_CMD_SMP:
 	case MFI_CMD_STP:
 	case MFI_CMD_NVME:
+	case MFI_CMD_TOOLBOX:
 		megasas_complete_int_cmd(instance, cmd);
 		break;
 
@@ -5099,6 +5101,7 @@ megasas_get_ctrl_info(struct megasas_instance *instance)
 		le32_to_cpus((u32 *)&ci->adapterOperations2);
 		le32_to_cpus((u32 *)&ci->adapterOperations3);
 		le16_to_cpus((u16 *)&ci->adapter_operations4);
+		le32_to_cpus((u32 *)&ci->adapter_operations5);
 
 		/* Update the latest Ext VD info.
 		 * From Init path, store current firmware details.
@@ -5112,6 +5115,8 @@ megasas_get_ctrl_info(struct megasas_instance *instance)
 			ci->adapter_operations4.support_pd_map_target_id;
 		instance->support_nvme_passthru =
 			ci->adapter_operations4.support_nvme_passthru;
+		instance->support_pci_lane_margining =
+			ci->adapter_operations5.support_pci_lane_margining;
 		instance->task_abort_tmo = ci->TaskAbortTO;
 		instance->max_reset_tmo = ci->MaxResetTO;
 
@@ -5145,6 +5150,8 @@ megasas_get_ctrl_info(struct megasas_instance *instance)
 			 instance->task_abort_tmo, instance->max_reset_tmo);
 		dev_info(&instance->pdev->dev, "JBOD sequence map support\t: %s\n",
 			 instance->support_seqnum_jbod_fp ? "Yes" : "No");
+		dev_info(&instance->pdev->dev, "PCI Lane Margining support\t: %s\n",
+			 instance->support_pci_lane_margining ? "Yes" : "No");
 
 		break;
 
@@ -7793,7 +7800,9 @@ megasas_mgmt_fw_ioctl(struct megasas_instance *instance,
 
 	if ((ioc->frame.hdr.cmd >= MFI_CMD_OP_COUNT) ||
 	    ((ioc->frame.hdr.cmd == MFI_CMD_NVME) &&
-	    !instance->support_nvme_passthru)) {
+	    !instance->support_nvme_passthru) ||
+	    ((ioc->frame.hdr.cmd == MFI_CMD_TOOLBOX) &&
+	    !instance->support_pci_lane_margining)) {
 		dev_err(&instance->pdev->dev,
 			"Received invalid ioctl command 0x%x\n",
 			ioc->frame.hdr.cmd);
@@ -8277,6 +8286,14 @@ support_nvme_encapsulation_show(struct device_driver *dd, char *buf)
 
 static DRIVER_ATTR_RO(support_nvme_encapsulation);
 
+static ssize_t
+support_pci_lane_margining_show(struct device_driver *dd, char *buf)
+{
+	return sprintf(buf, "%u\n", support_pci_lane_margining);
+}
+
+static DRIVER_ATTR_RO(support_pci_lane_margining);
+
 static inline void megasas_remove_scsi_device(struct scsi_device *sdev)
 {
 	sdev_printk(KERN_INFO, sdev, "SCSI device is removed\n");
@@ -8546,6 +8563,7 @@ static int __init megasas_init(void)
 	support_poll_for_event = 2;
 	support_device_change = 1;
 	support_nvme_encapsulation = true;
+	support_pci_lane_margining = true;
 
 	memset(&megasas_mgmt_info, 0, sizeof(megasas_mgmt_info));
 
@@ -8602,8 +8620,17 @@ static int __init megasas_init(void)
 	if (rval)
 		goto err_dcf_support_nvme_encapsulation;
 
+	rval = driver_create_file(&megasas_pci_driver.driver,
+				  &driver_attr_support_pci_lane_margining);
+	if (rval)
+		goto err_dcf_support_pci_lane_margining;
+
 	return rval;
 
+err_dcf_support_pci_lane_margining:
+	driver_remove_file(&megasas_pci_driver.driver,
+			   &driver_attr_support_nvme_encapsulation);
+
 err_dcf_support_nvme_encapsulation:
 	driver_remove_file(&megasas_pci_driver.driver,
 			   &driver_attr_support_device_change);
@@ -8643,6 +8670,8 @@ static void __exit megasas_exit(void)
 	driver_remove_file(&megasas_pci_driver.driver, &driver_attr_version);
 	driver_remove_file(&megasas_pci_driver.driver,
 			   &driver_attr_support_nvme_encapsulation);
+	driver_remove_file(&megasas_pci_driver.driver,
+			   &driver_attr_support_pci_lane_margining);
 
 	pci_unregister_driver(&megasas_pci_driver);
 	megasas_exit_debugfs();
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 9cf10b2..5958dec 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -4248,6 +4248,13 @@ void megasas_refire_mgmt_cmd(struct megasas_instance *instance)
 			}
 
 			break;
+		case MFI_CMD_TOOLBOX:
+			if (!instance->support_pci_lane_margining) {
+				cmd_mfi->frame->hdr.cmd_status = MFI_STAT_INVALID_CMD;
+				result = COMPLETE_CMD;
+			}
+
+			break;
 		default:
 			break;
 		}
-- 
2.9.5

