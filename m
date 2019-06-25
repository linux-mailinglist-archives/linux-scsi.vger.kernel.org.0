Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720BC54D28
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfFYLFT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46493 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so8649041pls.13
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcglgUXaK1MvJIHZ8sWYFR18WSuVnGfZV5jcIw8NZcc=;
        b=TUIkdqNzP4kO+VSwvP02UtTvqso3PdI/SC1hb1Dh9yXw/Yk3EIqdZxgwL1ZaCSHzU3
         BCZj4rblR2AKdk1cB0W9JdrOjXXZ9UvWWFNjg9lQexTCVZwlMRkPVADeMP5go2D/yx6t
         RSqtCmOWG3E0OyGJSnE5lyQTRnlqIy2zSeU44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcglgUXaK1MvJIHZ8sWYFR18WSuVnGfZV5jcIw8NZcc=;
        b=Xz7Vp+fxHKZJ0rDmSAwR+41CU9eIGadaInKmPmhWxNgF5YDr+py3iSur01SudlkPw5
         ComICBJVuIB7ugJBeRYOuTmzXrY5PoyUR1oJ31jVwLOejYIx963Etzg4hxZXWZ1TNKhG
         IHr6QT5nWya/KoAsWKzrADoGudM69M/JDubStjHwcrdPw5kEgHpxcI6a1WJIEKSQ72Eo
         K1j/qoGpi1vDpDAXo2VReeOiUj0YNIrKSvP1HYoJUAH/lgS5NKYkR8bT/bxVP0zkfVhl
         aBA00rVHzFNQR+xQRqAqUavkKx62rW9uXLkxevT8+4O9VKKK+gnBH+zUUNIDNxKt5IJU
         i6oA==
X-Gm-Message-State: APjAAAXQLdh3KAneYawGOibcpxLsBkSDREeMU2lum8fg9aqpB45xVTZx
        Y947ntRCfpVNCFlhU2eHEHA/wHci4lOMgLHgozZvqf28yrAXxzVc056pXCdmkWfDVOhbsGOR7Gl
        +QPwK0XQiS8RdTOqgygfHinGUyQjk7F09fLKgrNCVg57jQ+uXEKa8moxztqpmbzemft4I8TMgij
        fbMT2d0aKmQfw6
X-Google-Smtp-Source: APXvYqxr9OsgCODYJJZ8FQaIg9OROJTlIoNlWSLVdcSMshkZV4TWdJwIC2ZnVM/lXHU2i+g3N+WWLw==
X-Received: by 2002:a17:902:bc83:: with SMTP id bb3mr133834042plb.56.1561460717179;
        Tue, 25 Jun 2019 04:05:17 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:16 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 08/18] megaraid_sas: Handle sequence JBOD map failure at driver level
Date:   Tue, 25 Jun 2019 16:34:26 +0530
Message-Id: <20190625110436.4703-9-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Issue: This issue is applicable to scenario when JBOD sequence map is
unavailable (memory allocation for JBOD sequence map failed) to driver
but feature is supported by firmware.
If the driver sends a JBOD IO by not adding 255(MAX_PHYSICAL_DEVICES - 1)
to device ID when underlying firmware supports JBOD sequence map, it will
lead to the IO failure.

Fix: For JBOD IOs, driver will not use the RAID map to fetch the
devhandle, if JBOD sequence map is unavailable. Driver will set Devhandle
to 0xffff and Target ID to  'device ID + 255(MAX_PHYSICAL_DEVICES - 1)'.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  2 +
 drivers/scsi/megaraid/megaraid_sas_base.c   | 14 ++++--
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 77 ++++++++++++++++-------------
 3 files changed, 55 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index d333b8e..cd63281 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2398,7 +2398,9 @@ struct megasas_instance {
 #endif
 	u8 enable_fw_dev_list;
 	bool atomic_desc_support;
+	bool support_seqnum_jbod_fp;
 };
+
 struct MR_LD_VF_MAP {
 	u32 size;
 	union MR_LD_REF ref;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 54bb48e..554ec72 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5103,7 +5103,7 @@ megasas_get_ctrl_info(struct megasas_instance *instance)
 		 * in case of Firmware upgrade without system reboot.
 		 */
 		megasas_update_ext_vd_details(instance);
-		instance->use_seqnum_jbod_fp =
+		instance->support_seqnum_jbod_fp =
 			ci->adapterOperations3.useSeqNumJbodFP;
 		instance->support_morethan256jbod =
 			ci->adapter_operations4.support_pd_map_target_id;
@@ -5140,6 +5140,8 @@ megasas_get_ctrl_info(struct megasas_instance *instance)
 		dev_info(&instance->pdev->dev,
 			 "FW provided TM TaskAbort/Reset timeout\t: %d secs/%d secs\n",
 			 instance->task_abort_tmo, instance->max_reset_tmo);
+		dev_info(&instance->pdev->dev, "JBOD sequence map support\t: %s\n",
+			 instance->support_seqnum_jbod_fp ? "Yes" : "No");
 
 		break;
 
@@ -5554,10 +5556,12 @@ megasas_setup_jbod_map(struct megasas_instance *instance)
 	pd_seq_map_sz = sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) +
 		(sizeof(struct MR_PD_CFG_SEQ) * (MAX_PHYSICAL_DEVICES - 1));
 
+	instance->use_seqnum_jbod_fp =
+		instance->support_seqnum_jbod_fp;
 	if (reset_devices || !fusion ||
-		!instance->ctrl_info_buf->adapterOperations3.useSeqNumJbodFP) {
+		!instance->support_seqnum_jbod_fp) {
 		dev_info(&instance->pdev->dev,
-			"Jbod map is not supported %s %d\n",
+			"JBOD sequence map is disabled %s %d\n",
 			__func__, __LINE__);
 		instance->use_seqnum_jbod_fp = false;
 		return;
@@ -6042,8 +6046,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		instance->UnevenSpanSupport ? "yes" : "no");
 	dev_info(&instance->pdev->dev, "firmware crash dump	: %s\n",
 		instance->crash_dump_drv_support ? "yes" : "no");
-	dev_info(&instance->pdev->dev, "jbod sync map		: %s\n",
-		instance->use_seqnum_jbod_fp ? "yes" : "no");
+	dev_info(&instance->pdev->dev, "JBOD sequence map	: %s\n",
+		instance->use_seqnum_jbod_fp ? "enabled" : "disabled");
 
 	instance->max_sectors_per_req = instance->max_num_sge *
 						SGE_BUFFER_SIZE / 512;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index a765662..5121d4c 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3083,44 +3083,55 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 		<< MR_RAID_CTX_RAID_FLAGS_IO_SUB_TYPE_SHIFT;
 
 	/* If FW supports PD sequence number */
-	if (instance->use_seqnum_jbod_fp &&
-		instance->pd_list[pd_index].driveType == TYPE_DISK) {
-		/* TgtId must be incremented by 255 as jbod seq number is index
-		 * below raid map
-		 */
-		 /* More than 256 PD/JBOD support for Ventura */
-		if (instance->support_morethan256jbod)
-			pRAID_Context->virtual_disk_tgt_id =
-				pd_sync->seq[pd_index].pd_target_id;
-		else
-			pRAID_Context->virtual_disk_tgt_id =
-				cpu_to_le16(device_id + (MAX_PHYSICAL_DEVICES - 1));
-		pRAID_Context->config_seq_num = pd_sync->seq[pd_index].seqNum;
-		io_request->DevHandle = pd_sync->seq[pd_index].devHandle;
-		if (instance->adapter_type >= VENTURA_SERIES) {
-			io_request->RaidContext.raid_context_g35.routing_flags |=
-				(1 << MR_RAID_CTX_ROUTINGFLAGS_SQN_SHIFT);
-			io_request->RaidContext.raid_context_g35.nseg_type |=
-							(1 << RAID_CONTEXT_NSEG_SHIFT);
-			io_request->RaidContext.raid_context_g35.nseg_type |=
-							(MPI2_TYPE_CUDA << RAID_CONTEXT_TYPE_SHIFT);
+	if (instance->support_seqnum_jbod_fp) {
+		if (instance->use_seqnum_jbod_fp &&
+			instance->pd_list[pd_index].driveType == TYPE_DISK) {
+
+			/* More than 256 PD/JBOD support for Ventura */
+			if (instance->support_morethan256jbod)
+				pRAID_Context->virtual_disk_tgt_id =
+					pd_sync->seq[pd_index].pd_target_id;
+			else
+				pRAID_Context->virtual_disk_tgt_id =
+					cpu_to_le16(device_id +
+					(MAX_PHYSICAL_DEVICES - 1));
+			pRAID_Context->config_seq_num =
+				pd_sync->seq[pd_index].seqNum;
+			io_request->DevHandle =
+				pd_sync->seq[pd_index].devHandle;
+			if (instance->adapter_type >= VENTURA_SERIES) {
+				io_request->RaidContext.raid_context_g35.routing_flags |=
+					(1 << MR_RAID_CTX_ROUTINGFLAGS_SQN_SHIFT);
+				io_request->RaidContext.raid_context_g35.nseg_type |=
+					(1 << RAID_CONTEXT_NSEG_SHIFT);
+				io_request->RaidContext.raid_context_g35.nseg_type |=
+					(MPI2_TYPE_CUDA << RAID_CONTEXT_TYPE_SHIFT);
+			} else {
+				pRAID_Context->type = MPI2_TYPE_CUDA;
+				pRAID_Context->nseg = 0x1;
+				pRAID_Context->reg_lock_flags |=
+					(MR_RL_FLAGS_SEQ_NUM_ENABLE |
+					 MR_RL_FLAGS_GRANT_DESTINATION_CUDA);
+			}
 		} else {
-			pRAID_Context->type = MPI2_TYPE_CUDA;
-			pRAID_Context->nseg = 0x1;
-			pRAID_Context->reg_lock_flags |=
-				(MR_RL_FLAGS_SEQ_NUM_ENABLE|MR_RL_FLAGS_GRANT_DESTINATION_CUDA);
+			pRAID_Context->virtual_disk_tgt_id =
+				cpu_to_le16(device_id +
+				(MAX_PHYSICAL_DEVICES - 1));
+			pRAID_Context->config_seq_num = 0;
+			io_request->DevHandle = cpu_to_le16(0xFFFF);
 		}
-	} else if (fusion->fast_path_io) {
-		pRAID_Context->virtual_disk_tgt_id = cpu_to_le16(device_id);
-		pRAID_Context->config_seq_num = 0;
-		local_map_ptr = fusion->ld_drv_map[(instance->map_id & 1)];
-		io_request->DevHandle =
-			local_map_ptr->raidMap.devHndlInfo[device_id].curDevHdl;
 	} else {
-		/* Want to send all IO via FW path */
 		pRAID_Context->virtual_disk_tgt_id = cpu_to_le16(device_id);
 		pRAID_Context->config_seq_num = 0;
-		io_request->DevHandle = cpu_to_le16(0xFFFF);
+
+		if (fusion->fast_path_io) {
+			local_map_ptr =
+				fusion->ld_drv_map[(instance->map_id & 1)];
+			io_request->DevHandle =
+				local_map_ptr->raidMap.devHndlInfo[device_id].curDevHdl;
+		} else {
+			io_request->DevHandle = cpu_to_le16(0xFFFF);
+		}
 	}
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
-- 
2.9.5

