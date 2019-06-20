Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3EE4CC5C
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFTKxP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46233 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbfFTKxP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so1436815pfy.13
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UwfdqmjTCz96BciZ834nttPOE+gzE0u5ZgR+uMxNsaI=;
        b=YIrpfR3S3muPwXlibXHzsuvAE2yTBIifJMAJythwJrUe5Nuej3UvgWGgco32SbGkY7
         La9WnWcTQTiXr9SzSqq0MjxocIHlN7t9Yn1VVlZq0GSuY3zxoXWXDGwiv2PENy3+A9sr
         rK++pz2w80soDheZJZk725V/hURwDXNB+UpVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UwfdqmjTCz96BciZ834nttPOE+gzE0u5ZgR+uMxNsaI=;
        b=RZDTewxeXmoyTbw1pOKcK5hw0sAZNFeE4VHXCuVO79o5egu7wGbVZzVpXpkuwsTmRh
         6+uQ1vBwBrYAPjGJRhOAs36pEbKVpcOeT1fLGqScopGsPHmfiTPBurRgIi743UOD6Ui2
         Y+q/k0m76wBa36o2kdGUHN29c458ppeIpRwyYsSSjR0FtEp2dtFPT2ijQIMwZO/0L3mb
         baYfRuQxdKBa4oZ4/QBY5cQf4TL9yyo8zFgUO/CrNqbLknXDBiLtsubPkkmsiar4eCD6
         xlm6TIhPV8sMp8i1UqOUfc77iRyrtvct9P6Weta19OQo0ZHYwBio92ZoWx5OLJrz1y5t
         LkVg==
X-Gm-Message-State: APjAAAWOzEE3C9y8+bR5ipJFLPcwZliyMIX4gkbwXbEw4uS8rz5AT9pi
        /ZBFTOYBfsheWkLMfw2gxkSh5q538WVarXpz2hS0hIrMDi8qyGpKv14uqO1AuVQR86ZMMe3eYp9
        u3vXdyFcN/LRUZy2fJHypcaojp3boNOJWSUhrA7qnpaxFwLQHq99gv/0jZjHyHbVQ9PEdyyOkbc
        vTcHtBRebiErLP
X-Google-Smtp-Source: APXvYqxxkBlB2uoZI9thoXUtH8PI8hLVRtwr/Pcfh7+uC0iU0Oy/6ClTZTRT7lbVSCfi5+GLIWSnWg==
X-Received: by 2002:a17:90a:be0a:: with SMTP id a10mr2337464pjs.112.1561027993823;
        Thu, 20 Jun 2019 03:53:13 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:13 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 11/18] megaraid_sas: Offload Aero RAID5/6 division calculations to driver
Date:   Thu, 20 Jun 2019 16:22:01 +0530
Message-Id: <20190620105208.15011-12-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For RAID5/RAID6 volumes configured behind Aero, driver will be doing 64bit
division operations on behalf of firmware as controller's ARM CPU is very
slow in this division. Later, driver calculate Q-ARM, P-ARM and Log-ARM
and pass those values to firmware by writing these values to RAID_CONTEXT.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c   | 10 +++-
 drivers/scsi/megaraid/megaraid_sas_fp.c     | 78 +++++++++++++++++++++++++++++
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  6 +--
 drivers/scsi/megaraid/megaraid_sas_fusion.h | 24 ++++++---
 4 files changed, 108 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 5244b6e..81e708b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5777,8 +5777,16 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			MR_MAX_RAID_MAP_SIZE_MASK);
 	}
 
-	if (instance->adapter_type == VENTURA_SERIES)
+	switch (instance->adapter_type) {
+	case VENTURA_SERIES:
 		fusion->pcie_bw_limitation = true;
+		break;
+	case AERO_SERIES:
+		fusion->r56_div_offload = true;
+		break;
+	default:
+		break;
+	}
 
 	/* Check if MSI-X is supported while in ready state */
 	msix_enable = (instance->instancet->read_fw_status_reg(instance) &
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index d296255..43a2e49 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -902,6 +902,77 @@ u8 MR_GetPhyParams(struct megasas_instance *instance, u32 ld, u64 stripRow,
 }
 
 /*
+ * mr_get_phy_params_r56_rmw -  Calculate parameters for R56 CTIO write operation
+ * @instance:			Adapter soft state
+ * @ld:				LD index
+ * @stripNo:			Strip Number
+ * @io_info:			IO info structure pointer
+ * pRAID_Context:		RAID context pointer
+ * map:				RAID map pointer
+ *
+ * This routine calculates the logical arm, data Arm, row number and parity arm
+ * for R56 CTIO write operation.
+ */
+static void mr_get_phy_params_r56_rmw(struct megasas_instance *instance,
+			    u32 ld, u64 stripNo,
+			    struct IO_REQUEST_INFO *io_info,
+			    struct RAID_CONTEXT_G35 *pRAID_Context,
+			    struct MR_DRV_RAID_MAP_ALL *map)
+{
+	struct MR_LD_RAID  *raid = MR_LdRaidGet(ld, map);
+	u8          span, dataArms, arms, dataArm, logArm;
+	s8          rightmostParityArm, PParityArm;
+	u64         rowNum;
+	u64 *pdBlock = &io_info->pdBlock;
+
+	dataArms = raid->rowDataSize;
+	arms = raid->rowSize;
+
+	rowNum =  mega_div64_32(stripNo, dataArms);
+	/* parity disk arm, first arm is 0 */
+	rightmostParityArm = (arms - 1) - mega_mod64(rowNum, arms);
+
+	/* logical arm within row */
+	logArm =  mega_mod64(stripNo, dataArms);
+	/* physical arm for data */
+	dataArm = mega_mod64((rightmostParityArm + 1 + logArm), arms);
+
+	if (raid->spanDepth == 1) {
+		span = 0;
+	} else {
+		span = (u8)MR_GetSpanBlock(ld, rowNum, pdBlock, map);
+		if (span == SPAN_INVALID)
+			return;
+	}
+
+	if (raid->level == 6) {
+		/* P Parity arm, note this can go negative adjust if negative */
+		PParityArm = (arms - 2) - mega_mod64(rowNum, arms);
+
+		if (PParityArm < 0)
+			PParityArm += arms;
+
+		/* rightmostParityArm is P-Parity for RAID 5 and Q-Parity for RAID */
+		pRAID_Context->flow_specific.r56_arm_map = rightmostParityArm;
+		pRAID_Context->flow_specific.r56_arm_map |=
+				    (u16)(PParityArm << RAID_CTX_R56_P_ARM_SHIFT);
+	} else {
+		pRAID_Context->flow_specific.r56_arm_map |=
+				    (u16)(rightmostParityArm << RAID_CTX_R56_P_ARM_SHIFT);
+	}
+
+	pRAID_Context->reg_lock_row_lba = cpu_to_le64(rowNum);
+	pRAID_Context->flow_specific.r56_arm_map |=
+				   (u16)(logArm << RAID_CTX_R56_LOG_ARM_SHIFT);
+	cpu_to_le16s(&pRAID_Context->flow_specific.r56_arm_map);
+	pRAID_Context->span_arm = (span << RAID_CTX_SPANARM_SPAN_SHIFT) | dataArm;
+	pRAID_Context->raid_flags = (MR_RAID_FLAGS_IO_SUB_TYPE_R56_DIV_OFFLOAD <<
+				    MR_RAID_CTX_RAID_FLAGS_IO_SUB_TYPE_SHIFT);
+
+	return;
+}
+
+/*
 ******************************************************************************
 *
 * MR_BuildRaidContext function
@@ -1108,6 +1179,13 @@ MR_BuildRaidContext(struct megasas_instance *instance,
 	/* save pointer to raid->LUN array */
 	*raidLUN = raid->LUN;
 
+	/* Aero R5/6 Division Offload for WRITE */
+	if (fusion->r56_div_offload && (raid->level >= 5) && !isRead) {
+		mr_get_phy_params_r56_rmw(instance, ld, start_strip, io_info,
+				       (struct RAID_CONTEXT_G35 *)pRAID_Context,
+				       map);
+		return true;
+	}
 
 	/*Get Phy Params only if FP capable, or else leave it to MR firmware
 	  to do the calculation.*/
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index ad18474..058d22b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3324,9 +3324,9 @@ void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
 	r1_cmd->request_desc->SCSIIO.DevHandle = cmd->r1_alt_dev_handle;
 	r1_cmd->io_request->DevHandle = cmd->r1_alt_dev_handle;
 	r1_cmd->r1_alt_dev_handle = cmd->io_request->DevHandle;
-	cmd->io_request->RaidContext.raid_context_g35.smid.peer_smid =
+	cmd->io_request->RaidContext.raid_context_g35.flow_specific.peer_smid =
 			cpu_to_le16(r1_cmd->index);
-	r1_cmd->io_request->RaidContext.raid_context_g35.smid.peer_smid =
+	r1_cmd->io_request->RaidContext.raid_context_g35.flow_specific.peer_smid =
 			cpu_to_le16(cmd->index);
 	/*MSIxIndex of both commands request descriptors should be same*/
 	r1_cmd->request_desc->SCSIIO.MSIxIndex =
@@ -3444,7 +3444,7 @@ megasas_complete_r1_command(struct megasas_instance *instance,
 
 	rctx_g35 = &cmd->io_request->RaidContext.raid_context_g35;
 	fusion = instance->ctrl_context;
-	peer_smid = le16_to_cpu(rctx_g35->smid.peer_smid);
+	peer_smid = le16_to_cpu(rctx_g35->flow_specific.peer_smid);
 
 	r1_cmd = fusion->cmd_list[peer_smid - 1];
 	scmd_local = cmd->scmd;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index b50da38..ca32b2b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -87,7 +87,8 @@ enum MR_RAID_FLAGS_IO_SUB_TYPE {
 	MR_RAID_FLAGS_IO_SUB_TYPE_RMW_P        = 3,
 	MR_RAID_FLAGS_IO_SUB_TYPE_RMW_Q        = 4,
 	MR_RAID_FLAGS_IO_SUB_TYPE_CACHE_BYPASS = 6,
-	MR_RAID_FLAGS_IO_SUB_TYPE_LDIO_BW_LIMIT = 7
+	MR_RAID_FLAGS_IO_SUB_TYPE_LDIO_BW_LIMIT = 7,
+	MR_RAID_FLAGS_IO_SUB_TYPE_R56_DIV_OFFLOAD = 8
 };
 
 /*
@@ -151,12 +152,15 @@ struct RAID_CONTEXT_G35 {
 	u16 timeout_value; /* 0x02 -0x03 */
 	u16		routing_flags;	// 0x04 -0x05 routing flags
 	u16 virtual_disk_tgt_id;   /* 0x06 -0x07 */
-	u64 reg_lock_row_lba;      /* 0x08 - 0x0F */
+	__le64 reg_lock_row_lba;      /* 0x08 - 0x0F */
 	u32 reg_lock_length;      /* 0x10 - 0x13 */
-	union {
-		u16 next_lmid; /* 0x14 - 0x15 */
-		u16	peer_smid;	/* used for the raid 1/10 fp writes */
-	} smid;
+	union {                     // flow specific
+		u16 rmw_op_index;   /* 0x14 - 0x15, R5/6 RMW: rmw operation index*/
+		u16 peer_smid;      /* 0x14 - 0x15, R1 Write: peer smid*/
+		u16 r56_arm_map;    /* 0x14 - 0x15, Unused [15], LogArm[14:10], P-Arm[9:5], Q-Arm[4:0] */
+
+	} flow_specific;
+
 	u8 ex_status;       /* 0x16 : OUT */
 	u8 status;          /* 0x17 status */
 	u8 raid_flags;		/* 0x18 resvd[7:6], ioSubType[5:4],
@@ -247,6 +251,13 @@ union RAID_CONTEXT_UNION {
 #define RAID_CTX_SPANARM_SPAN_SHIFT	(5)
 #define RAID_CTX_SPANARM_SPAN_MASK	(0xE0)
 
+/* LogArm[14:10], P-Arm[9:5], Q-Arm[4:0] */
+#define RAID_CTX_R56_Q_ARM_MASK		(0x1F)
+#define RAID_CTX_R56_P_ARM_SHIFT	(5)
+#define RAID_CTX_R56_P_ARM_MASK		(0x3E0)
+#define RAID_CTX_R56_LOG_ARM_SHIFT	(10)
+#define RAID_CTX_R56_LOG_ARM_MASK	(0x7C00)
+
 /* number of bits per index in U32 TrackStream */
 #define BITS_PER_INDEX_STREAM		4
 #define INVALID_STREAM_NUM              16
@@ -1336,6 +1347,7 @@ struct fusion_context {
 	struct MPI2_IOC_INIT_REQUEST *ioc_init_request;
 	struct megasas_cmd *ioc_init_cmd;
 	bool pcie_bw_limitation;
+	bool r56_div_offload;
 };
 
 union desc_value {
-- 
2.9.5

