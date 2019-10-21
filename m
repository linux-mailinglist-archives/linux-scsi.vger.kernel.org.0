Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B965DE892
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 11:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfJUJxg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 05:53:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:48814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727898AbfJUJxe (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:53:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9FB8BABD;
        Mon, 21 Oct 2019 09:53:28 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/24] advansys: kill driver_defined status byte accessors
Date:   Mon, 21 Oct 2019 11:53:09 +0200
Message-Id: <20191021095322.137969-12-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021095322.137969-1-hare@suse.de>
References: <20191021095322.137969-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace the driver-defined status byte accessors by the
mid-layer defined ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/advansys.c | 78 +++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 58 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index a242a62caaa1..5268b4b92e43 100644
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
@@ -6021,43 +6015,28 @@ static void adv_isr_callback(ADV_DVC_VAR *adv_dvc_varp, ADV_SCSI_REQ_Q *scsiqp)
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
 			}
+			scp->result = status_byte(scsiqp->scsi_status);
 			break;
 
 		default:
 			/* Some other QHSTA error occurred. */
 			ASC_DBG(1, "host_status 0x%x\n", scsiqp->host_status);
-			scp->result = HOST_BYTE(DID_BAD_TARGET);
+			scp->result = host_byte(DID_BAD_TARGET);
 			break;
 		}
 		break;
 
 	case QD_ABORTED_BY_HOST:
 		ASC_DBG(1, "QD_ABORTED_BY_HOST\n");
-		scp->result =
-		    HOST_BYTE(DID_ABORT) | STATUS_BYTE(scsiqp->scsi_status);
+		scp->result = host_byte(DID_ABORT);
+		set_status_byte(scp, scsiqp->scsi_status);
 		break;
 
 	default:
 		ASC_DBG(1, "done_status 0x%x\n", scsiqp->done_status);
-		scp->result =
-		    HOST_BYTE(DID_ERROR) | STATUS_BYTE(scsiqp->scsi_status);
+		scp->result = host_byte(DID_ERROR);
+		set_status_byte(scp, scsiqp->scsi_status);
 		break;
 	}
 
@@ -6789,47 +6768,30 @@ static void asc_isr_callback(ASC_DVC_VAR *asc_dvc_varp, ASC_QDONE_INFO *qdonep)
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
 			}
+			scp->result = status_byte(qdonep->d3.scsi_stat);
 			break;
 
 		default:
 			/* QHSTA error occurred */
 			ASC_DBG(1, "host_stat 0x%x\n", qdonep->d3.host_stat);
-			scp->result = HOST_BYTE(DID_BAD_TARGET);
+			scp->result = host_byte(DID_BAD_TARGET);
 			break;
 		}
 		break;
 
 	case QD_ABORTED_BY_HOST:
 		ASC_DBG(1, "QD_ABORTED_BY_HOST\n");
-		scp->result =
-		    HOST_BYTE(DID_ABORT) | MSG_BYTE(qdonep->d3.
-						    scsi_msg) |
-		    STATUS_BYTE(qdonep->d3.scsi_stat);
+		scp->result = host_byte(DID_ABORT);
+		set_msg_byte(scp, qdonep->d3.scsi_msg);
+		set_status_byte(scp, qdonep->d3.scsi_stat);
 		break;
 
 	default:
 		ASC_DBG(1, "done_stat 0x%x\n", qdonep->d3.done_stat);
-		scp->result =
-		    HOST_BYTE(DID_ERROR) | MSG_BYTE(qdonep->d3.
-						    scsi_msg) |
-		    STATUS_BYTE(qdonep->d3.scsi_stat);
+		scp->result = host_byte(DID_ERROR);
+		set_msg_byte(scp, qdonep->d3.scsi_msg);
+		set_status_byte(scp, qdonep->d3.scsi_stat);
 		break;
 	}
 
@@ -7568,7 +7530,7 @@ static int asc_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 				"sg_tablesize %d\n", use_sg,
 				scp->device->host->sg_tablesize);
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_ERROR);
+			scp->result = host_byte(DID_ERROR);
 			return ASC_ERROR;
 		}
 
@@ -7576,7 +7538,7 @@ static int asc_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 			use_sg * sizeof(struct asc_sg_list), GFP_ATOMIC);
 		if (!asc_sg_head) {
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_SOFT_ERROR);
+			scp->result = host_byte(DID_SOFT_ERROR);
 			return ASC_ERROR;
 		}
 
@@ -7819,7 +7781,7 @@ adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 				   "ADV_MAX_SG_LIST %d\n", use_sg,
 				   scp->device->host->sg_tablesize);
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_ERROR);
+			scp->result = host_byte(DID_ERROR);
 			reqp->cmndp = NULL;
 			scp->host_scribble = NULL;
 
@@ -7831,7 +7793,7 @@ adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
 		ret = adv_get_sglist(boardp, reqp, scsiqp, scp, use_sg);
 		if (ret != ADV_SUCCESS) {
 			scsi_dma_unmap(scp);
-			scp->result = HOST_BYTE(DID_ERROR);
+			scp->result = host_byte(DID_ERROR);
 			reqp->cmndp = NULL;
 			scp->host_scribble = NULL;
 
@@ -8528,13 +8490,13 @@ static int asc_execute_scsi_cmnd(struct scsi_cmnd *scp)
 		scmd_printk(KERN_ERR, scp, "ExeScsiQueue() ASC_ERROR, "
 			"err_code 0x%x\n", err_code);
 		ASC_STATS(scp->device->host, exe_error);
-		scp->result = HOST_BYTE(DID_ERROR);
+		scp->result = host_byte(DID_ERROR);
 		break;
 	default:
 		scmd_printk(KERN_ERR, scp, "ExeScsiQueue() unknown, "
 			"err_code 0x%x\n", err_code);
 		ASC_STATS(scp->device->host, exe_unknown);
-		scp->result = HOST_BYTE(DID_ERROR);
+		scp->result = host_byte(DID_ERROR);
 		break;
 	}
 
-- 
2.16.4

