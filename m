Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6D12F74F
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jan 2020 12:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgACLe3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Jan 2020 06:34:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34066 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbgACLe3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Jan 2020 06:34:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so18974714pln.1
        for <linux-scsi@vger.kernel.org>; Fri, 03 Jan 2020 03:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KNiy5mXxq7ufDUw2unNT8psOXd1+XeQ4ElJm3xeUn8k=;
        b=Px7R2DvjaVKz6XfHY+L43OjipVVX/AvtaO24fPblPc0ehIU37B+4iI4EOOPMtVe1Ac
         JqVrsYIwU/bYA4DMvJEEk8nAV0kLwDqpNs4/HBxry5m+H16Ksah872ysARSripwoDHZw
         HcdhQHnKVKvOvEBrE1Zkh/5hDfFn4ZscK0NIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KNiy5mXxq7ufDUw2unNT8psOXd1+XeQ4ElJm3xeUn8k=;
        b=QEGsslxeKGLodHPfNalMgDZW0WCLjVd+0X5yTSQS4YYLlQuPBFLkYFjU55bQ/OcSxG
         lgunRtXcuDW51co/I/CFfqFntywprxBI9GTMV5BPXsRNi0V04xjOn+culiW9Kovu0+rB
         KHz61TODyWgrJi4mIQ9tXwMPQ8Vl9beuxrRxq3ucMjoYDDnu5VKhYQ60/LaJ/kvZPxHn
         xC8NHHxV6e+mMy1tdEJORh/rFnWQcNEKaH2yvznuXEp31gB4jlrCCUF6aAizqrAnu9RS
         3GF5WH6OLVJjfmOAMU0bv2yrzn3dAhd+hKos+Xf9BsfY/h6XrqHcs2R/3MU9K06OjZCh
         p/tw==
X-Gm-Message-State: APjAAAXbLRuxldJxZ8GHvtOcp6AqahJ3dZ6AU8T5itJFRLh3zAMREKpq
        qUg5OSxMV3vJE4AUj/kdTLXVsf2nybKr+shAH2FRcelZotjtK3HC2PSMu6knEnYGenzayre7R6d
        WTqRPjQDB06qtKorQo6pobmpOXCIVXLdGPQoIxlqzzmcwsXbnJr8uKVjd+r4gOCph4wGt7crljJ
        /maRg4Ww==
X-Google-Smtp-Source: APXvYqwuhHc9hLmvoH+fo03yqNQA0qPbdbp0wkeCh2bFuqyYmqhhzyfyvG2Zo2iebjebjh0NWGR/Xw==
X-Received: by 2002:a17:902:7e4d:: with SMTP id a13mr90941630pln.281.1578051268745;
        Fri, 03 Jan 2020 03:34:28 -0800 (PST)
Received: from dhcp-10-123-20-32.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h128sm70302144pfe.172.2020.01.03.03.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 03:34:28 -0800 (PST)
From:   Anand Lodnoor <anand.lodnoor@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com,
        Anand Lodnoor <anand.lodnoor@broadcom.com>
Subject: [PATCH 02/11] megaraid_sas: Set no_write_same only for Virtual Disk
Date:   Fri,  3 Jan 2020 17:02:26 +0530
Message-Id: <1578051155-14716-3-git-send-email-anand.lodnoor@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578051155-14716-1-git-send-email-anand.lodnoor@broadcom.com>
References: <1578051155-14716-1-git-send-email-anand.lodnoor@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set no_write_same only for Virtual Disk, "no_write_same" flag should not
be set for EPDs (Encapsulated PDs).

Signed-off-by: Anand Lodnoor <anand.lodnoor@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c   |  5 ++++-
 drivers/scsi/megaraid/megaraid_sas_fusion.h | 17 ++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b5f0221..3cd269f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -1887,6 +1887,10 @@ void megasas_set_dynamic_target_properties(struct scsi_device *sdev,
 
 		mr_device_priv_data->is_tm_capable =
 			raid->capability.tmCapable;
+
+		if (!raid->flags.isEPD)
+			sdev->no_write_same = 1;
+
 	} else if (instance->use_seqnum_jbod_fp) {
 		pd_index = (sdev->channel * MEGASAS_MAX_DEV_PER_CHANNEL) +
 			sdev->id;
@@ -3416,7 +3420,6 @@ static int megasas_reset_target(struct scsi_cmnd *scmd)
 	.bios_param = megasas_bios_param,
 	.change_queue_depth = scsi_change_queue_depth,
 	.max_segment_size = 0xffffffff,
-	.no_write_same = 1,
 };
 
 /**
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index c013c80..8358b68 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -864,9 +864,20 @@ struct MR_LD_RAID {
 	u8	regTypeReqOnRead;
 	__le16     seqNum;
 
-	struct {
-		u32 ldSyncRequired:1;
-		u32 reserved:31;
+struct {
+#ifndef MFI_BIG_ENDIAN
+	u32 ldSyncRequired:1;
+	u32 regTypeReqOnReadIsValid:1;
+	u32 isEPD:1;
+	u32 enableSLDOnAllRWIOs:1;
+	u32 reserved:28;
+#else
+	u32 reserved:28;
+	u32 enableSLDOnAllRWIOs:1;
+	u32 isEPD:1;
+	u32 regTypeReqOnReadIsValid:1;
+	u32 ldSyncRequired:1;
+#endif
 	} flags;
 
 	u8	LUN[8]; /* 0x24 8 byte LUN field used for SCSI IO's */
-- 
1.8.3.1

