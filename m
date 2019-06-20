Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864834CC56
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfFTKxF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46018 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKxF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id s21so1369564pga.12
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcglgUXaK1MvJIHZ8sWYFR18WSuVnGfZV5jcIw8NZcc=;
        b=HjGhu162cCjh1VLY89vI7z7hffueB5yWve9WFm0wx+MWKxcdC8USrgluGfftgDlEDD
         pRJEOZBe8AXhap652o1f7je6nK9iAbhzW6dQGYmxhzA+j9Z2+cPpEVEUKzjDEOBFjPeo
         nZwvBX8o2gueuFgvK87NJ6S9lADR8gIHKbQXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcglgUXaK1MvJIHZ8sWYFR18WSuVnGfZV5jcIw8NZcc=;
        b=LawDEC6AnuxsxXzx86VPNbfPB8wBwUQZ26Rio1DxpWjQ4dauv+JdrhsMtG4E6Tgu65
         ldj1ZI/ltZSptOyeErI9XlKNmBuDs0MTN6rdTRNkL8pwJsbZkXwz9ptG17LAkI1CxALf
         6yanY0J3KuAsmNAdkXGJ38MMtSvSTfia2s9v3XcCKSXsx1bE39U0hzbzfInRy1/U9gze
         TVLT8g4V51H45Ad2JqQx3xlAMArBmqk3KvHzVUwC0VELdhuAgfErmdAkyfaMdtwxQjSn
         ByzM713YfvloEdgi0MqTlQ5hiAP8guBrKycnRfY0zitQ6fWyjMLLWsdNAiT8UZt6Dcio
         x98g==
X-Gm-Message-State: APjAAAWEGCp6vnO227UcItmpxpMNjoKBlJdEJlP6dZXTYz5wvwEHlJXC
        QjePQHHd7n6Na8wwvGly3at4HH/Bsos/QlDA1ip+h/xeurFZjJz8RJFewk84yxxKr/eLtElBFa3
        nzU2s/IZqytsbMbFcM5KnU4ZCcHyhbtN4j2BHmt6ggtS4sTqNXzFdavSOK52Nr1K4C/jb3FUjCu
        272IusZnDTMGK22CE=
X-Google-Smtp-Source: APXvYqysEm4IxWlNLQiLtVRqCOA6TxfJgWu8u8oNjlYkfc/XOQI+mRTqig/TY9s8NWsGFHEZm/5MVQ==
X-Received: by 2002:a63:c0e:: with SMTP id b14mr12318139pgl.4.1561027984063;
        Thu, 20 Jun 2019 03:53:04 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:03 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 08/18] megaraid_sas: Handle sequence JBOD map failure at driver level
Date:   Thu, 20 Jun 2019 16:21:58 +0530
Message-Id: <20190620105208.15011-9-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

