Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AFF54D30
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfFYLFo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39316 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so8793653pgc.6
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T4xFAUQiRTbKSvU/plzn2gO53ObR6gnzkNhb7ykrKfo=;
        b=Mb1OkNV0i/hvmtqYzu7PTd6cw+vEGWB2im/+3ujUVNMx5DFOQHx33+Gdu6xXnSHyi8
         QzzvakfcOGFcuMD2oqLQD3iCi4457wrhYup4qZNM9MDC4qBf02KzS64iGovkUWQ6SUrA
         FM4JEbRZAai+onB783m5qqNOmQmi6A8alBeeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T4xFAUQiRTbKSvU/plzn2gO53ObR6gnzkNhb7ykrKfo=;
        b=nYL/0Piz2J5TPwYlbbGXwio/lrdwRCFQqmLdSvMupJ86I/6c9aa/ZaSEhJ0CdhjbIG
         iemj6/KaH/JNTKRWuIQebwMuePCMeY5NgWpRkU6xaHU7WIftlOiAqBbOoILTPZyuBatU
         cTpzSoxtv2d/F7g6GY9Y/ERXbE4H8LHsfp2wuT/H9w4hymKlT7n+MV4U4lBfvPA3H+BP
         0WkZtQCTE6ky+77JB2hBcGGdMh5gYujSP8kx68Xay45yDagGFr/yoekwiETtz+JLMN5E
         HfVlELyltuBLBBLlp/XZGKHkJAaCCPNUxQf8Kr4NdVv9pF1lOzAjO1fm7YI2G3IEBqdv
         h7MA==
X-Gm-Message-State: APjAAAVgPPSbYhwiyitgbNFww3COAdnYIwuxGW1br4taaTRUqQ0q3sQ/
        zid71gXU8DyfEwDXT5D+Z8bX1hNwk/+1oobcn7qTEHfhK2njRvJS5FDt31nYKPhMLVyjqnQ2Msp
        NYBByJnn3NELNQXfrgndUlT1FBRh0bfNUiGdXdYbuj4HI6azhKJNtwgeiLrjREnhXJLdH8Ko7sj
        MJ3d+Z5UlN/w==
X-Google-Smtp-Source: APXvYqyjCA9E933W4rYJlp5aotifrGZDPbzocoC/GOg7ndnehM3HLqwPt7/ZD8OVV2/ZYNMroA/J7w==
X-Received: by 2002:a17:90a:3544:: with SMTP id q62mr31508839pjb.53.1561460742847;
        Tue, 25 Jun 2019 04:05:42 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:42 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 16/18] megaraid_sas: Use high IOPs queues based on IO workload
Date:   Tue, 25 Jun 2019 16:34:34 +0530
Message-Id: <20190625110436.4703-17-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver will use round-robin method for IO submission in batches within
the high iops queues when the number of in-flight ios on the target device
is larger than 8. Otherwise the driver will use low latency reply queues.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  3 +++
 drivers/scsi/megaraid/megaraid_sas_fp.c     |  1 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 16 ++++++++++++++--
 drivers/scsi/megaraid/megaraid_sas_fusion.h |  1 +
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 02e6e15..3f4cb52 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2253,6 +2253,8 @@ enum MR_PD_TYPE {
 
 /*Aero performance parameters*/
 #define MR_HIGH_IOPS_QUEUE_COUNT	8
+#define MR_DEVICE_HIGH_IOPS_DEPTH	8
+#define MR_HIGH_IOPS_BATCH_COUNT	16
 
 struct megasas_instance {
 
@@ -2362,6 +2364,7 @@ struct megasas_instance {
 	atomic_t ldio_outstanding;
 	atomic_t fw_reset_no_pci_access;
 	atomic64_t total_io_count;
+	atomic64_t high_iops_outstanding;
 
 	struct megasas_instance_template *instancet;
 	struct tasklet_struct isr_tasklet;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 43a2e49..f9f7c34 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -1038,6 +1038,7 @@ MR_BuildRaidContext(struct megasas_instance *instance,
 	stripSize = 1 << raid->stripeShift;
 	stripe_mask = stripSize-1;
 
+	io_info->data_arms = raid->rowDataSize;
 
 	/*
 	 * calculate starting row and stripe, and number of strips and rows
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 845ca2f..90dced4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2811,6 +2811,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 	io_info.r1_alt_dev_handle = MR_DEVHANDLE_INVALID;
 	scsi_buff_len = scsi_bufflen(scp);
 	io_request->DataLength = cpu_to_le32(scsi_buff_len);
+	io_info.data_arms = 1;
 
 	if (scp->sc_data_direction == DMA_FROM_DEVICE)
 		io_info.isRead = 1;
@@ -2830,7 +2831,13 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			fp_possible = (io_info.fpOkForIo > 0) ? true : false;
 	}
 
-	if (instance->msix_load_balance)
+	if (instance->balanced_mode &&
+		atomic_read(&scp->device->device_busy) >
+		(io_info.data_arms * MR_DEVICE_HIGH_IOPS_DEPTH))
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			mega_mod64((atomic64_add_return(1, &instance->high_iops_outstanding) /
+				MR_HIGH_IOPS_BATCH_COUNT), instance->low_latency_index_start);
+	else if (instance->msix_load_balance)
 		cmd->request_desc->SCSIIO.MSIxIndex =
 			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
 				    instance->msix_vectors));
@@ -3157,7 +3164,12 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
 
-	if (instance->msix_load_balance)
+	if (instance->balanced_mode &&
+		atomic_read(&scmd->device->device_busy) > MR_DEVICE_HIGH_IOPS_DEPTH)
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			mega_mod64((atomic64_add_return(1, &instance->high_iops_outstanding) /
+				MR_HIGH_IOPS_BATCH_COUNT), instance->low_latency_index_start);
+	else if (instance->msix_load_balance)
 		cmd->request_desc->SCSIIO.MSIxIndex =
 			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
 				    instance->msix_vectors));
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index ca32b2b..6fe3343 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -962,6 +962,7 @@ struct IO_REQUEST_INFO {
 	u8  pd_after_lb;
 	u16 r1_alt_dev_handle; /* raid 1/10 only */
 	bool ra_capable;
+	u8 data_arms;
 };
 
 struct MR_LD_TARGET_SYNC {
-- 
2.9.5

