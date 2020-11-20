Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6762B9FCC
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Nov 2020 02:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKTBfv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 20:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgKTBfv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 20:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605836149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CXbWMn85vsEetZ5zh1R84Ze1IVkbnw3ZzkmmkOOrow=;
        b=XyQUfAhomMXLA8gUPOuz+SMqJxt4LEFjY+HyYW+EPCD/gS6MchroIOxk8Pq84PVRCHLQj4
        pWpmeulK4ktHyqYUgnoBhzxLgObYE/+Gbsa+tK1xGei2tQgKL8DdArtolykM6eQqfsV3JG
        RSjDEuxaX/jR+KgQuVSKITiKQOlqrVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-thKV15HcN8WCa_4SonMg3Q-1; Thu, 19 Nov 2020 20:35:44 -0500
X-MC-Unique: thKV15HcN8WCa_4SonMg3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 464DE107ACE3;
        Fri, 20 Nov 2020 01:35:43 +0000 (UTC)
Received: from T590 (ovpn-13-9.pek2.redhat.com [10.72.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1A6760853;
        Fri, 20 Nov 2020 01:35:34 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:35:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V6 10/13] megaraid_sas: v2 replace sdev_busy with local
 counter
Message-ID: <20201120013529.GA333150@T590>
References: <20201119094705.280390-1-ming.lei@redhat.com>
 <20201119095147.GB279559@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119095147.GB279559@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From e98ce3cf552ae173f1b8bcb19219f2e88dd3bf86 Mon Sep 17 00:00:00 2001
From: Kashyap Desai <kashyap.desai@broadcom.com>
Date: Thu, 19 Nov 2020 12:39:01 +0530
Subject: [PATCH V6 10/13] megaraid_sas: v2 replace sdev_busy with local counter

use local tracking of per sdev outstanding command since sdev_busy in
SML is improved for performance reason using sbitmap (earlier it was
atomic variable).

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>

Fix checkpatch ERROR and WARNING.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V5->V6:
	- fix one check in megasas_sdev_busy_read

 drivers/scsi/megaraid/megaraid_sas.h        |  2 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 47 +++++++++++++++++----
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 5e4137f10e0e..2299342d5b2d 100644
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
index fd607287608e..e9ec9b7b1c36 100644
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
@@ -357,15 +391,9 @@ megasas_get_msix_index(struct megasas_instance *instance,
 		       struct megasas_cmd_fusion *cmd,
 		       u8 data_arms)
 {
-	int sdev_busy;
-
-	/* TBD - if sml remove device_busy in future, driver
-	 * should track counter in internal structure.
-	 */
-	sdev_busy = atomic_read(&scmd->device->device_busy);
-
 	if (instance->perf_mode == MR_BALANCED_PERF_MODE &&
-	    sdev_busy > (data_arms * MR_DEVICE_HIGH_IOPS_DEPTH)) {
+	    (megasas_sdev_busy_read(instance, scmd) >
+	    (data_arms * MR_DEVICE_HIGH_IOPS_DEPTH))) {
 		cmd->request_desc->SCSIIO.MSIxIndex =
 			mega_mod64((atomic64_add_return(1, &instance->high_iops_outstanding) /
 					MR_HIGH_IOPS_BATCH_COUNT), instance->low_latency_index_start);
@@ -3390,6 +3418,7 @@ megasas_build_and_issue_cmd_fusion(struct megasas_instance *instance,
 	 * Issue the command to the FW
 	 */
 
+	megasas_sdev_busy_inc(instance, scmd);
 	megasas_fire_cmd_fusion(instance, req_desc);
 
 	if (r1_cmd)
@@ -3450,6 +3479,7 @@ megasas_complete_r1_command(struct megasas_instance *instance,
 		scmd_local->SCp.ptr = NULL;
 		megasas_return_cmd_fusion(instance, cmd);
 		scsi_dma_unmap(scmd_local);
+		megasas_sdev_busy_dec(instance, scmd_local);
 		scmd_local->scsi_done(scmd_local);
 	}
 }
@@ -3550,6 +3580,7 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
 				scmd_local->SCp.ptr = NULL;
 				megasas_return_cmd_fusion(instance, cmd_fusion);
 				scsi_dma_unmap(scmd_local);
+				megasas_sdev_busy_dec(instance, scmd_local);
 				scmd_local->scsi_done(scmd_local);
 			} else	/* Optimal VD - R1 FP command completion. */
 				megasas_complete_r1_command(instance, cmd_fusion);
-- 
2.25.4

