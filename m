Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC62F473A
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhAMJHk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:55204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbhAMJHU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:07:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70DAEB8F4;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 34/35] advansys: kill driver_defined status byte accessors
Date:   Wed, 13 Jan 2021 10:04:59 +0100
Message-Id: <20210113090500.129644-35-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace the driver-defined status byte accessors by the
mid-layer defined ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/advansys.c | 84 ++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 60 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 79830e77afa9..9529074c8886 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -2085,12 +2085,6 @@ do { \
 #define ASC_BUSY        0
 #define ASC_ERROR       (-1)
 
-/* struct scsi_cmnd function return codes */
-#define STATUS_BYTE(byte)   (byte)
-#define MSG_BYTE(byte)      ((byte) << 8)
-#define HOST_BYTE(byte)     ((byte) << 16)
-#define DRIVER_BYTE(byte)   ((byte) << 24)
-
 #define ASC_STATS(shost, counter) ASC_STATS_ADD(shost, counter, 1)
 #ifndef ADVANSYS_STATS
 #define ASC_STATS_ADD(shost, counter, count)
@@ -5986,10 +5980,10 @@ static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
 	/*
 	 * 'done_status' contains the command's ending status.
 	 */
+	scp->result = 0;
 	switch (scsiqp->done_status) {
 	case QD_NO_ERROR:
 		ASC_DBG(2, "QD_NO_ERROR\n");
-		scp->result = 0;
 
 		/*
 		 * Check for an underrun condition.
@@ -6010,47 +6004,33 @@ static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
 		ASC_DBG(2, "QD_WITH_ERROR\n");
 		switch (scsiqp->host_status) {
 		case QHSTA_NO_ERROR:
+			set_status_byte(scp, scsiqp->scsi_status);
 			if (scsiqp->scsi_status == SAM_STAT_CHECK_CONDITION) {
 				ASC_DBG(2, "SAM_STAT_CHECK_CONDITION\n");
 				ASC_DBG_PRT_SENSE(2, scp->sense_buffer,
 						  SCSI_SENSE_BUFFERSIZE);
-				/*
-				 * Note: The 'status_byte()' macro used by
-				 * target drivers defined in scsi.h shifts the
-				 * status byte returned by host drivers right
-				 * by 1 bit.  This is why target drivers also
-				 * use right shifted status byte definitions.
-				 * For instance target drivers use
-				 * CHECK_CONDITION, defined to 0x1, instead of
-				 * the SCSI defined check condition value of
-				 * 0x2. Host drivers are supposed to return
-				 * the status byte as it is defined by SCSI.
-				 */
-				scp->result = DRIVER_BYTE(DRIVER_SENSE) |
-				    STATUS_BYTE(scsiqp->scsi_status);
-			} else {
-				scp->result = STATUS_BYTE(scsiqp->scsi_status);
+				set_driver_byte(scp, DRIVER_SENSE);
 			}
 			break;
 
 		default:
 			/* Some other QHSTA error occurred. */
 			ASC_DBG(1, "host_status 0x%x\n", scsiqp->host_status);
-			scp->result = HOST_BYTE(DID_BAD_TARGET);
+			set_host_byte(scp, DID_BAD_TARGET);
 			break;
 		}
 		break;
 
 	case QD_ABORTED_BY_HOST:
 		ASC_DBG(1, "QD_ABORTED_BY_HOST\n");
-		scp->result =
-		    HOST_BYTE(DID_ABORT) | STATUS_BYTE(scsiqp->scsi_status);
+		set_status_byte(scp, scsiqp->scsi_status);
+		set_host_byte(scp, DID_ABORT);
 		break;
 
 	default:
 		ASC_DBG(1, "done_status 0x%x\n", scsiqp->done_status);
-		scp->result =
-		    HOST_BYTE(DID_ERROR) | STATUS_BYTE(scsiqp->scsi_status);
+		set_status_byte(scp, scsiqp->scsi_status);
+		set_host_byte(scp, DID_ERROR);
 		break;
 	}
 
@@ -6752,10 +6732,10 @@ static void asc_isr_callback(ASC_DVC_VAR *asc_dvc_varp, ASC_QDONE_INFO *qdonep)
 	/*
 	 * 'qdonep' contains the command's ending status.
 	 */
+	scp->result = 0;
 	switch (qdonep->d3.done_stat) {
 	case QD_NO_ERROR:
 		ASC_DBG(2, "QD_NO_ERROR\n");
-		scp->result = 0;
 
 		/*
 		 * Check for an underrun condition.
@@ -6775,51 +6755,35 @@ static void asc_isr_callback(ASC_DVC_VAR *asc_dvc_varp, ASC_QDONE_INFO *qdonep)
 		ASC_DBG(2, "QD_WITH_ERROR\n");
 		switch (qdonep->d3.host_stat) {
 		case QHSTA_NO_ERROR:
+			set_status_byte(scp, qdonep->d3.scsi_stat);
 			if (qdonep->d3.scsi_stat == SAM_STAT_CHECK_CONDITION) {
 				ASC_DBG(2, "SAM_STAT_CHECK_CONDITION\n");
 				ASC_DBG_PRT_SENSE(2, scp->sense_buffer,
 						  SCSI_SENSE_BUFFERSIZE);
-				/*
-				 * Note: The 'status_byte()' macro used by
-				 * target drivers defined in scsi.h shifts the
-				 * status byte returned by host drivers right
-				 * by 1 bit.  This is why target drivers also
-				 * use right shifted status byte definitions.
-				 * For instance target drivers use
-				 * CHECK_CONDITION, defined to 0x1, instead of
-				 * the SCSI defined check condition value of
-				 * 0x2. Host drivers are supposed to return
-				 * the status byte as it is defined by SCSI.
-				 */
-				scp->result = DRIVER_BYTE(DRIVER_SENSE) |
-				    STATUS_BYTE(qdonep->d3.scsi_stat);
-			} else {
-				scp->result = STATUS_BYTE(qdonep->d3.scsi_stat);
+				set_driver_byte(scp, DRIVER_SENSE);
 			}
 			break;
 
 		default:
 			/* QHSTA error occurred */
 			ASC_DBG(1, "host_stat 0x%x\n", qdonep->d3.host_stat);
-			scp->result = HOST_BYTE(DID_BAD_TARGET);
+			set_host_byte(scp, DID_BAD_TARGET);
 			break;
 		}
 		break;
 
 	case QD_ABORTED_BY_HOST:
 		ASC_DBG(1, "QD_ABORTED_BY_HOST\n");
-		scp->result =
-		    HOST_BYTE(DID_ABORT) | MSG_BYTE(qdonep->d3.
-						    scsi_msg) |
-		    STATUS_BYTE(qdonep->d3.scsi_stat);
+		set_status_byte(scp, qdonep->d3.scsi_stat);
+		set_msg_byte(scp, qdonep->d3.scsi_msg);
+		set_host_byte(scp, DID_ABORT);
 		break;
 
 	default:
 		ASC_DBG(1, "done_stat 0x%x\n", qdonep->d3.done_stat);
-		scp->result =
-		    HOST_BYTE(DID_ERROR) | MSG_BYTE(qdonep->d3.
-						    scsi_msg) |
-		    STATUS_BYTE(qdonep->d3.scsi_stat);
+		set_status_byte(scp, qdonep->d3.scsi_stat);
+		set_msg_byte(scp, qdonep->d3.scsi_msg);
+		set_host_byte(scp, DID_ERROR);
 		break;
 	}
 
@@ -7558,7 +7522,7 @@ static int asc_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 				"sg_tablesize %d\n", use_sg,
 				scp->device->host->sg_tablesize);
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_ERROR);
+			set_host_byte(scp, DID_ERROR);
 			return ASC_ERROR;
 		}
 
@@ -7566,7 +7530,7 @@ static int asc_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 			use_sg * sizeof(struct asc_sg_list), GFP_ATOMIC);
 		if (!asc_sg_head) {
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_SOFT_ERROR);
+			set_host_byte(scp, DID_SOFT_ERROR);
 			return ASC_ERROR;
 		}
 
@@ -7809,7 +7773,7 @@ adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 				   "ADV_MAX_SG_LIST %d\n", use_sg,
 				   scp->device->host->sg_tablesize);
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_ERROR);
+			set_host_byte(scp, DID_ERROR);
 			reqp->cmndp = NULL;
 			scp->host_scribble = NULL;
 
@@ -7821,7 +7785,7 @@ adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 		ret = adv_get_sglist(boardp, reqp, scsiqp, scp, use_sg);
 		if (ret != ADV_SUCCESS) {
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_ERROR);
+			set_host_byte(scp, DID_ERROR);
 			reqp->cmndp = NULL;
 			scp->host_scribble = NULL;
 
@@ -8518,13 +8482,13 @@ static int asc_execute_scsi_cmnd(struct scsi_cmnd *scp)
 		scmd_printk(KERN_ERR, scp, "ExeScsiQueue() ASC_ERROR, "
 			"err_code 0x%x\n", err_code);
 		ASC_STATS(scp->device->host, exe_error);
-		scp->result = HOST_BYTE(DID_ERROR);
+		set_host_byte(scp, DID_ERROR);
 		break;
 	default:
 		scmd_printk(KERN_ERR, scp, "ExeScsiQueue() unknown, "
 			"err_code 0x%x\n", err_code);
 		ASC_STATS(scp->device->host, exe_unknown);
-		scp->result = HOST_BYTE(DID_ERROR);
+		set_host_byte(scp, DID_ERROR);
 		break;
 	}
 
-- 
2.29.2

