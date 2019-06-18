Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7949D67
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfFRJdU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:33:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36027 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRJdT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:33:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so7329627pfl.3
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xxEO98HnegU4jvyn9wXjZlffVuav23a6nrS8BFkkXdQ=;
        b=hL7sktIrUnoo4Cn9MzQM+l/33nv6cPyOg6LryKKI7U/v1AcF8LroMvgbz9TbUKOkLh
         Mgjyil92drbSjYZ8nT1JwcfxbifFziAIONXW9ZuDD9hfiyMtBKDBUShb4UzpAL/3WFK7
         nrLD5pFDAvBdJwyZHE9U87CCXsozvsOcr7mKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xxEO98HnegU4jvyn9wXjZlffVuav23a6nrS8BFkkXdQ=;
        b=OWNHER0AGzmIqVnJTBNEJJty2e6bY5Fh72jI5m6HaqLhK+6vYvamZCF1TD1a1KGZoa
         vljNNamx/E8tgYvCO6RvCFgHrIJb1ArN44o0Knjlm7n6dH/2f2iA2cfwr/z+yDCT0c51
         f6ju2Bb63Au8KrvuDU1iF2SUFqvkbSsoHhPDjkma2Gy0dsx3l8t1j5HJ+nEvoAF+idNP
         T88xZWYsXNStsMHAY2cG9GAcv7vsqL4QfF+CrOBNHx8wE/7l9aA+4yVI+KiJFTa90rJD
         +nO523sV1Q5rA8t1jr0J5Tf7TE/lEZ6hXZMXbH37XhaFwcC1VgDuRm7yc6OMqERqZ9IG
         4LRA==
X-Gm-Message-State: APjAAAVJhTW6nqjFaFe+k5a5Lx/qNKnI5HF5XM/Nd22A7MMv+y8TvAPq
        iTZET2g9sDo909o5kZi0NrEcYKHhYfqQWmC933N77NG6Pr9Y8g4lneeXYS7eCPo9i1xbU2TNzZs
        f816yzuc23NmjFsQogm8Qds8SnCFYxr1IjQQdtXebNG9hO9b6XuBNWawwKG3Tsos0JbGWJa488c
        3Ba32EbDU4Fg==
X-Google-Smtp-Source: APXvYqyyTjMXMC6/jK8AEoyKfrKV2bA+tFnJO5qavXyUyUiuNOQHjrFO54YFqcz17DDoLijWlNbsqA==
X-Received: by 2002:aa7:8dd1:: with SMTP id j17mr3427120pfr.52.1560850397870;
        Tue, 18 Jun 2019 02:33:17 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.33.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:33:17 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 16/18] megaraid_sas: Use high IOPs queues based on IO workload
Date:   Tue, 18 Jun 2019 15:02:05 +0530
Message-Id: <20190618093207.9939-17-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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
index e08b3ff..8a692b4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2813,6 +2813,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 	io_info.r1_alt_dev_handle = MR_DEVHANDLE_INVALID;
 	scsi_buff_len = scsi_bufflen(scp);
 	io_request->DataLength = cpu_to_le32(scsi_buff_len);
+	io_info.data_arms = 1;
 
 	if (scp->sc_data_direction == DMA_FROM_DEVICE)
 		io_info.isRead = 1;
@@ -2832,7 +2833,13 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
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
@@ -3159,7 +3166,12 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 
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
index aab705f..974bb54 100644
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

