Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CB52FFA83
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Jan 2021 03:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAVChR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Jan 2021 21:37:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbhAVCgS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 21 Jan 2021 21:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611282891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XyyT1wuAxUZptvMl6cmb2mGbfAAxpwE68CCUZEWoPM=;
        b=O6YXIpmWUSWsCWZG92JJxWiv/z7nBRiWXFOUoC4FmQ4e/ZLbfHkf0IjnoG93ZANbwPN4FY
        3HYtIHFvMLE3CW+8jLMBtJtHqkEgiSuDCozG0K5Fb4c6eSTbpHryU66mPjm0yZd38/1TOw
        27gsMdjRVS2PkajCo+h1QhcX+jLylv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-hBzFD-uOOO2kRMhJPIz8eA-1; Thu, 21 Jan 2021 21:34:47 -0500
X-MC-Unique: hBzFD-uOOO2kRMhJPIz8eA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C51806665;
        Fri, 22 Jan 2021 02:34:45 +0000 (UTC)
Received: from localhost (ovpn-13-11.pek2.redhat.com [10.72.13.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 056AC1992D;
        Fri, 22 Jan 2021 02:34:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Omar Sandoval <osandov@fb.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 10/13] megaraid_sas: v2 replace sdev_busy with local counter
Date:   Fri, 22 Jan 2021 10:33:14 +0800
Message-Id: <20210122023317.687987-11-ming.lei@redhat.com>
In-Reply-To: <20210122023317.687987-1-ming.lei@redhat.com>
References: <20210122023317.687987-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Kashyap Desai <kashyap.desai@broadcom.com>

use local tracking of per sdev outstanding command since sdev_busy in
SML is improved for performance reason using sbitmap (earlier it was
atomic variable).

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>

Fix checkpatch ERROR and WARNING.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  2 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 48 +++++++++++++++++----
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 0f808d63580e..0c6a56b24c6e 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2019,10 +2019,12 @@ union megasas_frame {
  * struct MR_PRIV_DEVICE - sdev private hostdata
  * @is_tm_capable: firmware managed tm_capable flag
  * @tm_busy: TM request is in progress
+ * @sdev_priv_busy: pending command per sdev
  */
 struct MR_PRIV_DEVICE {
 	bool is_tm_capable;
 	bool tm_busy;
+	atomic_t sdev_priv_busy;
 	atomic_t r1_ldio_hint;
 	u8 interface_type;
 	u8 task_abort_tmo;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index b0c01cf0428f..ecfe19ea0364 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -220,6 +220,40 @@ megasas_clear_intr_fusion(struct megasas_instance *instance)
 	return 1;
 }
 
+static inline void
+megasas_sdev_busy_inc(struct megasas_instance *instance,
+		      struct scsi_cmnd *scmd)
+{
+	if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
+		struct MR_PRIV_DEVICE *mr_device_priv_data =
+			scmd->device->hostdata;
+		atomic_inc(&mr_device_priv_data->sdev_priv_busy);
+	}
+}
+
+static inline void
+megasas_sdev_busy_dec(struct megasas_instance *instance,
+		      struct scsi_cmnd *scmd)
+{
+	if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
+		struct MR_PRIV_DEVICE *mr_device_priv_data =
+			scmd->device->hostdata;
+		atomic_dec(&mr_device_priv_data->sdev_priv_busy);
+	}
+}
+
+static inline int
+megasas_sdev_busy_read(struct megasas_instance *instance,
+		       struct scsi_cmnd *scmd)
+{
+	if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
+		struct MR_PRIV_DEVICE *mr_device_priv_data =
+			scmd->device->hostdata;
+		return atomic_read(&mr_device_priv_data->sdev_priv_busy);
+	}
+	return 0;
+}
+
 /**
  * megasas_get_cmd_fusion -	Get a command from the free pool
  * @instance:		Adapter soft state
@@ -357,16 +391,9 @@ megasas_get_msix_index(struct megasas_instance *instance,
 		       struct megasas_cmd_fusion *cmd,
 		       u8 data_arms)
 {
-	int sdev_busy;
-
-	/* nr_hw_queue = 1 for MegaRAID */
-	struct blk_mq_hw_ctx *hctx =
-		scmd->device->request_queue->queue_hw_ctx[0];
-
-	sdev_busy = atomic_read(&hctx->nr_active);
-
 	if (instance->perf_mode == MR_BALANCED_PERF_MODE &&
-	    sdev_busy > (data_arms * MR_DEVICE_HIGH_IOPS_DEPTH))
+	    (megasas_sdev_busy_read(instance, scmd) >
+	    (data_arms * MR_DEVICE_HIGH_IOPS_DEPTH)))
 		cmd->request_desc->SCSIIO.MSIxIndex =
 			mega_mod64((atomic64_add_return(1, &instance->high_iops_outstanding) /
 					MR_HIGH_IOPS_BATCH_COUNT), instance->low_latency_index_start);
@@ -3387,6 +3414,7 @@ megasas_build_and_issue_cmd_fusion(struct megasas_instance *instance,
 	 * Issue the command to the FW
 	 */
 
+	megasas_sdev_busy_inc(instance, scmd);
 	megasas_fire_cmd_fusion(instance, req_desc);
 
 	if (r1_cmd)
@@ -3447,6 +3475,7 @@ megasas_complete_r1_command(struct megasas_instance *instance,
 		scmd_local->SCp.ptr = NULL;
 		megasas_return_cmd_fusion(instance, cmd);
 		scsi_dma_unmap(scmd_local);
+		megasas_sdev_busy_dec(instance, scmd_local);
 		scmd_local->scsi_done(scmd_local);
 	}
 }
@@ -3547,6 +3576,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
 				scmd_local->SCp.ptr = NULL;
 				megasas_return_cmd_fusion(instance, cmd_fusion);
 				scsi_dma_unmap(scmd_local);
+				megasas_sdev_busy_dec(instance, scmd_local);
 				scmd_local->scsi_done(scmd_local);
 			} else	/* Optimal VD - R1 FP command completion. */
 				megasas_complete_r1_command(instance, cmd_fusion);
-- 
2.28.0

