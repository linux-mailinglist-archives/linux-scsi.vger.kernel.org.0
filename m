Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1732F471B
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbhAMJGb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:06:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:53816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbhAMJG2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:06:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD6BEB740;
        Wed, 13 Jan 2021 09:05:03 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bart van Assche <bvanassche@acm.org>
Subject: [PATCH 08/35] aic7xxx,aic79xxx: remove driver-defined SAM status definitions
Date:   Wed, 13 Jan 2021 10:04:33 +0100
Message-Id: <20210113090500.129644-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace the driver-defined SAM status definitions with the
standard mid-layer defined ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/aic7xxx/aic79xx_core.c |  8 ++++----
 drivers/scsi/aic7xxx/aic79xx_osm.c  | 16 ++++++++--------
 drivers/scsi/aic7xxx/aic7xxx_core.c |  6 +++---
 drivers/scsi/aic7xxx/aic7xxx_osm.c  | 12 ++++++------
 drivers/scsi/aic7xxx/aiclib.h       | 15 ---------------
 5 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index c2b0b3847beb..f179e05fb8c3 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -8911,7 +8911,7 @@ ahd_handle_scsi_status(struct ahd_softc *ahd, struct scb *scb)
 					break;
 				}
 			}
-			if (siu->status == SCSI_STATUS_OK)
+			if (siu->status == SAM_STAT_GOOD)
 				ahd_set_transaction_status(scb,
 							   CAM_REQ_CMP_ERR);
 		}
@@ -8925,8 +8925,8 @@ ahd_handle_scsi_status(struct ahd_softc *ahd, struct scb *scb)
 		ahd_done(ahd, scb);
 		break;
 	}
-	case SCSI_STATUS_CMD_TERMINATED:
-	case SCSI_STATUS_CHECK_COND:
+	case SAM_STAT_COMMAND_TERMINATED:
+	case SAM_STAT_CHECK_CONDITION:
 	{
 		struct ahd_devinfo devinfo;
 		struct ahd_dma_seg *sg;
@@ -9016,7 +9016,7 @@ ahd_handle_scsi_status(struct ahd_softc *ahd, struct scb *scb)
 		ahd_queue_scb(ahd, scb);
 		break;
 	}
-	case SCSI_STATUS_OK:
+	case SAM_STAT_GOOD:
 		printk("%s: Interrupted for status of 0???\n",
 		       ahd_name(ahd));
 		fallthrough;
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index d413b1c5fdc5..4a91385fdfea 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -1834,7 +1834,7 @@ ahd_done(struct ahd_softc *ahd, struct scb *scb)
 
 	if (dev->openings == 1
 	 && ahd_get_transaction_status(scb) == CAM_REQ_CMP
-	 && ahd_get_scsi_status(scb) != SCSI_STATUS_QUEUE_FULL)
+	 && ahd_get_scsi_status(scb) != SAM_STAT_TASK_SET_FULL)
 		dev->tag_success_count++;
 	/*
 	 * Some devices deal with temporary internal resource
@@ -1891,8 +1891,8 @@ ahd_linux_handle_scsi_status(struct ahd_softc *ahd,
 	switch (ahd_get_scsi_status(scb)) {
 	default:
 		break;
-	case SCSI_STATUS_CHECK_COND:
-	case SCSI_STATUS_CMD_TERMINATED:
+	case SAM_STAT_CHECK_CONDITION:
+	case SAM_STAT_COMMAND_TERMINATED:
 	{
 		struct scsi_cmnd *cmd;
 
@@ -1947,7 +1947,7 @@ ahd_linux_handle_scsi_status(struct ahd_softc *ahd,
 		}
 		break;
 	}
-	case SCSI_STATUS_QUEUE_FULL:
+	case SAM_STAT_TASK_SET_FULL:
 		/*
 		 * By the time the core driver has returned this
 		 * command, all other commands that were queued
@@ -1993,7 +1993,7 @@ ahd_linux_handle_scsi_status(struct ahd_softc *ahd,
 				dev->last_queuefull_same_count = 0;
 			}
 			ahd_set_transaction_status(scb, CAM_REQUEUE_REQ);
-			ahd_set_scsi_status(scb, SCSI_STATUS_OK);
+			ahd_set_scsi_status(scb, SAM_STAT_GOOD);
 			ahd_platform_set_tags(ahd, sdev, &devinfo,
 				     (dev->flags & AHD_DEV_Q_BASIC)
 				   ? AHD_QUEUE_BASIC : AHD_QUEUE_TAGGED);
@@ -2007,7 +2007,7 @@ ahd_linux_handle_scsi_status(struct ahd_softc *ahd,
 		ahd_platform_set_tags(ahd, sdev, &devinfo,
 			     (dev->flags & AHD_DEV_Q_BASIC)
 			   ? AHD_QUEUE_BASIC : AHD_QUEUE_TAGGED);
-		ahd_set_scsi_status(scb, SCSI_STATUS_BUSY);
+		ahd_set_scsi_status(scb, SAM_STAT_BUSY);
 	}
 }
 
@@ -2039,8 +2039,8 @@ ahd_linux_queue_cmd_complete(struct ahd_softc *ahd, struct scsi_cmnd *cmd)
 		scsi_status = ahd_cmd_get_scsi_status(cmd);
 
 		switch(scsi_status) {
-		case SCSI_STATUS_CMD_TERMINATED:
-		case SCSI_STATUS_CHECK_COND:
+		case SAM_STAT_COMMAND_TERMINATED:
+		case SAM_STAT_CHECK_CONDITION:
 			if ((cmd->result >> 24) != DRIVER_SENSE) {
 				do_fallback = 1;
 			} else {
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index b61a32c53645..43da21a26e1a 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -1041,12 +1041,12 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 		ahc_freeze_scb(scb);
 		ahc_set_scsi_status(scb, hscb->shared_data.status.scsi_status);
 		switch (hscb->shared_data.status.scsi_status) {
-		case SCSI_STATUS_OK:
+		case SAM_STAT_GOOD:
 			printk("%s: Interrupted for status of 0???\n",
 			       ahc_name(ahc));
 			break;
-		case SCSI_STATUS_CMD_TERMINATED:
-		case SCSI_STATUS_CHECK_COND:
+		case SAM_STAT_COMMAND_TERMINATED:
+		case SAM_STAT_CHECK_CONDITION:
 		{
 			struct ahc_dma_seg *sg;
 			struct scsi_sense *sc;
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 0aaca2eab6b6..2c7d9d38a577 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -1759,7 +1759,7 @@ ahc_done(struct ahc_softc *ahc, struct scb *scb)
 
 	if (dev->openings == 1
 	 && ahc_get_transaction_status(scb) == CAM_REQ_CMP
-	 && ahc_get_scsi_status(scb) != SCSI_STATUS_QUEUE_FULL)
+	 && ahc_get_scsi_status(scb) != SAM_STAT_TASK_SET_FULL)
 		dev->tag_success_count++;
 	/*
 	 * Some devices deal with temporary internal resource
@@ -1816,8 +1816,8 @@ ahc_linux_handle_scsi_status(struct ahc_softc *ahc,
 	switch (ahc_get_scsi_status(scb)) {
 	default:
 		break;
-	case SCSI_STATUS_CHECK_COND:
-	case SCSI_STATUS_CMD_TERMINATED:
+	case SAM_STAT_CHECK_CONDITION:
+	case SAM_STAT_COMMAND_TERMINATED:
 	{
 		struct scsi_cmnd *cmd;
 
@@ -1855,7 +1855,7 @@ ahc_linux_handle_scsi_status(struct ahc_softc *ahc,
 		}
 		break;
 	}
-	case SCSI_STATUS_QUEUE_FULL:
+	case SAM_STAT_TASK_SET_FULL:
 	{
 		/*
 		 * By the time the core driver has returned this
@@ -1899,7 +1899,7 @@ ahc_linux_handle_scsi_status(struct ahc_softc *ahc,
 				dev->last_queuefull_same_count = 0;
 			}
 			ahc_set_transaction_status(scb, CAM_REQUEUE_REQ);
-			ahc_set_scsi_status(scb, SCSI_STATUS_OK);
+			ahc_set_scsi_status(scb, SAM_STAT_GOOD);
 			ahc_platform_set_tags(ahc, sdev, &devinfo,
 				     (dev->flags & AHC_DEV_Q_BASIC)
 				   ? AHC_QUEUE_BASIC : AHC_QUEUE_TAGGED);
@@ -1910,7 +1910,7 @@ ahc_linux_handle_scsi_status(struct ahc_softc *ahc,
 		 * as if the target returned BUSY SCSI status.
 		 */
 		dev->openings = 1;
-		ahc_set_scsi_status(scb, SCSI_STATUS_BUSY);
+		ahc_set_scsi_status(scb, SAM_STAT_BUSY);
 		ahc_platform_set_tags(ahc, sdev, &devinfo,
 			     (dev->flags & AHC_DEV_Q_BASIC)
 			   ? AHC_QUEUE_BASIC : AHC_QUEUE_TAGGED);
diff --git a/drivers/scsi/aic7xxx/aiclib.h b/drivers/scsi/aic7xxx/aiclib.h
index f8fd198aafbc..ba08eb3c4e3b 100644
--- a/drivers/scsi/aic7xxx/aiclib.h
+++ b/drivers/scsi/aic7xxx/aiclib.h
@@ -117,21 +117,6 @@ struct scsi_sense_data
 #define SSD_FULL_SIZE sizeof(struct scsi_sense_data)
 };
 
-/*
- * Status Byte
- */
-#define	SCSI_STATUS_OK			0x00
-#define	SCSI_STATUS_CHECK_COND		0x02
-#define	SCSI_STATUS_COND_MET		0x04
-#define	SCSI_STATUS_BUSY		0x08
-#define SCSI_STATUS_INTERMED		0x10
-#define SCSI_STATUS_INTERMED_COND_MET	0x14
-#define SCSI_STATUS_RESERV_CONFLICT	0x18
-#define SCSI_STATUS_CMD_TERMINATED	0x22	/* Obsolete in SAM-2 */
-#define SCSI_STATUS_QUEUE_FULL		0x28
-#define SCSI_STATUS_ACA_ACTIVE		0x30
-#define SCSI_STATUS_TASK_ABORTED	0x40
-
 /************************* Large Disk Handling ********************************/
 static inline int
 aic_sector_div(sector_t capacity, int heads, int sectors)
-- 
2.29.2

