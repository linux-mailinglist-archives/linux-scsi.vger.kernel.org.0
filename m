Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B03387EF9
	for <lists+linux-scsi@lfdr.de>; Tue, 18 May 2021 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351308AbhERRvm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 May 2021 13:51:42 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:56107 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbhERRvl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 May 2021 13:51:41 -0400
Received: by mail-pj1-f45.google.com with SMTP id gm21so5907948pjb.5
        for <linux-scsi@vger.kernel.org>; Tue, 18 May 2021 10:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoCWvILBU/xuVDUdiiKI1s/Sb+wDWFgTxOYnXyVK8Ts=;
        b=W4rApSrF2p9wAkX9JXKdyX5r5sIOOc431mazopwXjpDntc9NFU2QPSBBYAv2lpUSxt
         s11QfjqqIQjSfI3rV4US8QgEjICt5Htu0yXG8n1mdsuj1lTELk7A9m74CS5OQKWRUE00
         DelacYTX2W5koXMIsw3JBJUPsgUMEfmUQgJ6Au9WA3RbrmcYOHT72cYXBtQy/h4tfmC7
         UC2uKSLtDWhj5cmbDFHou8NshJfL95t6BNcPcaY5rsKKLX5Juh8c02OC4QBf3YGYXG/h
         7EIOfdNfuQIJ7FPu/kaCotTsXYanofZtgR2KzA+LP1+F1duReGgkl3sKk5kwOW9+kk8j
         RdyQ==
X-Gm-Message-State: AOAM532bHmnlBKLTE6giV2rnfsgsZt8ZtPMhc4mcgqzBup8Kt64meTwD
        kdpKuBI6nY3BNw0CxtKT774=
X-Google-Smtp-Source: ABdhPJxjNOlnqfQMr5trnHHs9c5VutrcFVlmSSDMRZD1BNzvJqd/8UvKogQpUc1sf0aDHmvggB4J/w==
X-Received: by 2002:a17:90a:e7c6:: with SMTP id kb6mr6561011pjb.81.1621360222841;
        Tue, 18 May 2021 10:50:22 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:4ae4:fc49:eafe:4150])
        by smtp.gmail.com with ESMTPSA id a2sm613762pfv.156.2021.05.18.10.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:50:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        Jolly Shah <jollys@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 1/3] libsas: Introduce more SAM status code aliases in enum exec_status
Date:   Tue, 18 May 2021 10:50:04 -0700
Message-Id: <20210518175006.21308-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518175006.21308-1-bvanassche@acm.org>
References: <20210518175006.21308-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch prepares for converting SAM status codes into an enum. Without
this patch converting SAM status codes into an enumeration type would
trigger complaints about enum type mismatches for the SAS code.

Cc: Hannes Reinecke <hare@suse.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aic94xx/aic94xx_task.c    |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  8 ++++----
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  8 ++++----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  8 ++++----
 drivers/scsi/isci/request.c            | 10 +++++-----
 drivers/scsi/isci/task.c               |  2 +-
 drivers/scsi/libsas/sas_ata.c          |  7 ++++---
 drivers/scsi/libsas/sas_expander.c     |  2 +-
 drivers/scsi/libsas/sas_task.c         |  4 ++--
 drivers/scsi/mvsas/mv_sas.c            | 10 +++++-----
 drivers/scsi/pm8001/pm8001_hwi.c       | 16 ++++++++--------
 drivers/scsi/pm8001/pm8001_sas.c       |  4 ++--
 drivers/scsi/pm8001/pm80xx_hwi.c       | 14 +++++++-------
 include/scsi/libsas.h                  | 12 +++++++++---
 14 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 71d18f607dae..518ad4758a45 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -205,7 +205,7 @@ static void asd_task_tasklet_complete(struct asd_ascb *ascb,
 	switch (opcode) {
 	case TC_NO_ERROR:
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 		break;
 	case TC_UNDERRUN:
 		ts->resp = SAS_TASK_COMPLETE;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3e359ac752fd..9bb3ebd2a4e1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1152,14 +1152,14 @@ static void slot_err_v1_hw(struct hisi_hba *hisi_hba,
 		}
 		default:
 		{
-			ts->stat = SAM_STAT_CHECK_CONDITION;
+			ts->stat = SAS_STAT_CHECK_CONDITION;
 			break;
 		}
 		}
 	}
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SATA:
@@ -1281,7 +1281,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -1298,7 +1298,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 		break;
 
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 46f60fc2a069..67d1a821edb6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2168,7 +2168,7 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	}
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SATA:
@@ -2427,7 +2427,7 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -2441,12 +2441,12 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 	{
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 		hisi_sas_sata_done(task, slot);
 		break;
 	}
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 499c770d405c..35d58daa2729 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2178,7 +2178,7 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 		hisi_sas_sata_done(task, slot);
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 	default:
 		break;
@@ -2285,7 +2285,7 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -2298,11 +2298,11 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_SATA:
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 		hisi_sas_sata_done(task, slot);
 		break;
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index e7c6cb4c1556..83069d0f69b3 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -2566,7 +2566,7 @@ static void isci_request_handle_controller_specific_errors(
 			if (!idev)
 				*status_ptr = SAS_DEVICE_UNKNOWN;
 			else
-				*status_ptr = SAM_STAT_TASK_ABORTED;
+				*status_ptr = SAS_STAT_TASK_ABORTED;
 
 			clear_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 		}
@@ -2696,7 +2696,7 @@ static void isci_request_handle_controller_specific_errors(
 	default:
 		/* Task in the target is not done. */
 		*response_ptr = SAS_TASK_UNDELIVERED;
-		*status_ptr = SAM_STAT_TASK_ABORTED;
+		*status_ptr = SAS_STAT_TASK_ABORTED;
 
 		if (task->task_proto == SAS_PROTOCOL_SMP)
 			set_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
@@ -2719,7 +2719,7 @@ static void isci_process_stp_response(struct sas_task *task, struct dev_to_host_
 	if (ac_err_mask(fis->status))
 		ts->stat = SAS_PROTO_RESPONSE;
 	else
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 
 	ts->resp = SAS_TASK_COMPLETE;
 }
@@ -2782,7 +2782,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 	case SCI_IO_SUCCESS_IO_DONE_EARLY:
 
 		response = SAS_TASK_COMPLETE;
-		status   = SAM_STAT_GOOD;
+		status   = SAS_STAT_GOOD;
 		set_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 
 		if (completion_status == SCI_IO_SUCCESS_IO_DONE_EARLY) {
@@ -2852,7 +2852,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 
 		/* Fail the I/O. */
 		response = SAS_TASK_UNDELIVERED;
-		status = SAM_STAT_TASK_ABORTED;
+		status = SAS_STAT_TASK_ABORTED;
 
 		clear_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 		break;
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 62062ed6cd9a..4ab33393d4ed 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -160,7 +160,7 @@ int isci_task_execute_task(struct sas_task *task, gfp_t gfp_flags)
 
 			isci_task_refuse(ihost, task,
 					 SAS_TASK_UNDELIVERED,
-					 SAM_STAT_TASK_ABORTED);
+					 SAS_STAT_TASK_ABORTED);
 		} else {
 			task->task_state_flags |= SAS_TASK_AT_INITIATOR;
 			spin_unlock_irqrestore(&task->task_state_lock, flags);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index e9a86128f1f1..fbdcf6fd7d85 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -116,9 +116,10 @@ static void sas_ata_task_done(struct sas_task *task)
 		}
 	}
 
-	if (stat->stat == SAS_PROTO_RESPONSE || stat->stat == SAM_STAT_GOOD ||
-	    ((stat->stat == SAM_STAT_CHECK_CONDITION &&
-	      dev->sata_dev.class == ATA_DEV_ATAPI))) {
+	if (stat->stat == SAS_PROTO_RESPONSE ||
+	    stat->stat == SAS_STAT_GOOD ||
+	    (stat->stat == SAS_STAT_CHECK_CONDITION &&
+	      dev->sata_dev.class == ATA_DEV_ATAPI)) {
 		memcpy(dev->sata_dev.fis, resp->ending_fis, ATA_RESP_FIS_SIZE);
 
 		if (!link->sactive) {
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 6d583e8c403a..bc8cbccb87cd 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -101,7 +101,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
 			}
 		}
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAM_STAT_GOOD) {
+		    task->task_status.stat == SAS_STAT_GOOD) {
 			res = 0;
 			break;
 		}
diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
index e2d42593ce52..4e0c3ffd9aac 100644
--- a/drivers/scsi/libsas/sas_task.c
+++ b/drivers/scsi/libsas/sas_task.c
@@ -20,7 +20,7 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 	else if (iu->datapres == 1)
 		tstat->stat = iu->resp_data[3];
 	else if (iu->datapres == 2) {
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_STAT_CHECK_CONDITION;
 		tstat->buf_valid_size =
 			min_t(int, SAS_STATUS_BUF_SIZE,
 			      be32_to_cpu(iu->sense_data_len));
@@ -32,7 +32,7 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 	}
 	else
 		/* when datapres contains corrupt/unknown value... */
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_STAT_CHECK_CONDITION;
 }
 EXPORT_SYMBOL_GPL(sas_ssp_task_response);
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 1acea528f27f..087c4f3acc81 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1314,7 +1314,7 @@ static int mvs_exec_internal_tmf_task(struct domain_device *dev,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAM_STAT_GOOD) {
+		    task->task_status.stat == SAS_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 		}
@@ -1764,7 +1764,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 	case SAS_PROTOCOL_SSP:
 		/* hw says status == 0, datapres == 0 */
 		if (rx_desc & RXQ_GOOD) {
-			tstat->stat = SAM_STAT_GOOD;
+			tstat->stat = SAS_STAT_GOOD;
 			tstat->resp = SAS_TASK_COMPLETE;
 		}
 		/* response frame present */
@@ -1773,12 +1773,12 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 						sizeof(struct mvs_err_info);
 			sas_ssp_task_response(mvi->dev, task, iu);
 		} else
-			tstat->stat = SAM_STAT_CHECK_CONDITION;
+			tstat->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SMP: {
 			struct scatterlist *sg_resp = &task->smp_task.smp_resp;
-			tstat->stat = SAM_STAT_GOOD;
+			tstat->stat = SAS_STAT_GOOD;
 			to = kmap_atomic(sg_page(sg_resp));
 			memcpy(to + sg_resp->offset,
 				slot->response + sizeof(struct mvs_err_info),
@@ -1795,7 +1795,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 		}
 
 	default:
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_STAT_CHECK_CONDITION;
 		break;
 	}
 	if (!slot->port->port_attached) {
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index ecd06d2d7e81..4740d7eee196 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1930,7 +1930,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			   param);
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_STAT_GOOD;
 		} else {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_PROTO_RESPONSE;
@@ -2390,7 +2390,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_STAT_GOOD;
 			/* check if response is for SEND READ LOG */
 			if (pm8001_dev &&
 				(pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
@@ -2912,7 +2912,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		break;
@@ -2939,17 +2939,17 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_ERROR_HW_TIMEOUT:
 		pm8001_dbg(pm8001_ha, IO, "IO_ERROR_HW_TIMEOUT\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_BREAK:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_BREAK\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_PHY_NOT_READY:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_PHY_NOT_READY\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_STAT_BUSY;
 		break;
 	case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
 		pm8001_dbg(pm8001_ha, IO,
@@ -3710,7 +3710,7 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, EH, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 		break;
 	case IO_NOT_VALID:
 		pm8001_dbg(pm8001_ha, EH, "IO_NOT_VALID\n");
@@ -4355,7 +4355,7 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 
 			spin_lock_irqsave(&task->task_state_lock, flags);
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_STAT_GOOD;
 			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 			task->task_state_flags |= SAS_TASK_STATE_DONE;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index d28af413b93a..4367f4166704 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -753,7 +753,7 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAM_STAT_GOOD) {
+			task->task_status.stat == SAS_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 		}
@@ -838,7 +838,7 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAM_STAT_GOOD) {
+			task->task_status.stat == SAS_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 4e980830f9f5..4aec0405288f 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1952,7 +1952,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 			   param);
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_STAT_GOOD;
 		} else {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_PROTO_RESPONSE;
@@ -2487,7 +2487,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_STAT_GOOD;
 			/* check if response is for SEND READ LOG */
 			if (pm8001_dev &&
 				(pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
@@ -3042,7 +3042,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_STAT_GOOD;
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
@@ -3084,17 +3084,17 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_ERROR_HW_TIMEOUT:
 		pm8001_dbg(pm8001_ha, IO, "IO_ERROR_HW_TIMEOUT\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_BREAK:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_BREAK\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_PHY_NOT_READY:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_PHY_NOT_READY\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_STAT_BUSY;
 		break;
 	case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
 		pm8001_dbg(pm8001_ha, IO,
@@ -4699,7 +4699,7 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 
 			spin_lock_irqsave(&task->task_state_lock, flags);
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_STAT_GOOD;
 			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 			task->task_state_flags |= SAS_TASK_STATE_DONE;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 9271d7a49b90..e68327fa4835 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -474,10 +474,16 @@ enum service_response {
 };
 
 enum exec_status {
-	/* The SAM_STAT_.. codes fit in the lower 6 bits, alias some of
-	 * them here to silence 'case value not in enumerated type' warnings
+	/*
+	 * Values 0..0x7f are used to return the SAM_STAT_* codes.  To avoid
+	 * 'case value not in enumerated type' compiler warnings every value
+	 * returned through the exec_status enum needs an alias with the SAS_
+	 * prefix here.
 	 */
-	__SAM_STAT_CHECK_CONDITION = SAM_STAT_CHECK_CONDITION,
+	SAS_STAT_GOOD = SAM_STAT_GOOD,
+	SAS_STAT_BUSY = SAM_STAT_BUSY,
+	SAS_STAT_TASK_ABORTED = SAM_STAT_TASK_ABORTED,
+	SAS_STAT_CHECK_CONDITION = SAM_STAT_CHECK_CONDITION,
 
 	SAS_DEV_NO_RESPONSE = 0x80,
 	SAS_DATA_UNDERRUN,
