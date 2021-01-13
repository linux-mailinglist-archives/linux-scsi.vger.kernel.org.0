Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3472F4724
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhAMJHD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:53830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbhAMJGr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:06:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B4A9AFF9;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 20/35] dc395x: drop internal SCSI message definitions
Date:   Wed, 13 Jan 2021 10:04:45 +0100
Message-Id: <20210113090500.129644-21-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Drop the internel SCSI message definitions and use the functions
provided by the SPI transport class.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/Kconfig  |  1 +
 drivers/scsi/dc395x.c | 28 +++++++++++-----------------
 drivers/scsi/dc395x.h | 22 ----------------------
 3 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 322d582a22d2..44c1d5e0e8c9 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1168,6 +1168,7 @@ config SCSI_SIM710
 config SCSI_DC395x
 	tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
 	depends on PCI && SCSI
+	select SCSI_SPI_ATTRS
 	help
 	  This driver supports PCI SCSI host adapters based on the ASIC
 	  TRM-S1040 chip, e.g Tekram DC395(U/UW/F) and DC315(U) variants.
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 7b522ff345d5..3ea345c12467 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -64,6 +64,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_transport_spi.h>
 
 #include "dc395x.h"
 
@@ -1281,12 +1282,8 @@ static void build_sdtr(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 	} else if (dcb->sync_offset == 0)
 		dcb->sync_offset = SYNC_NEGO_OFFSET;
 
-	*ptr++ = MSG_EXTENDED;	/* (01h) */
-	*ptr++ = 3;		/* length */
-	*ptr++ = EXTENDED_SDTR;	/* (01h) */
-	*ptr++ = dcb->min_nego_period;	/* Transfer period (in 4ns) */
-	*ptr++ = dcb->sync_offset;	/* Transfer period (max. REQ/ACK dist) */
-	srb->msg_count += 5;
+	srb->msg_count += spi_populate_sync_msg(ptr, dcb->min_nego_period,
+						dcb->sync_offset);
 	srb->state |= SRB_DO_SYNC_NEGO;
 }
 
@@ -1305,11 +1302,7 @@ static void build_wdtr(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 			srb->msgout_buf[1]);
 		return;
 	}
-	*ptr++ = MSG_EXTENDED;	/* (01h) */
-	*ptr++ = 2;		/* length */
-	*ptr++ = EXTENDED_WDTR;	/* (03h) */
-	*ptr++ = wide;
-	srb->msg_count += 4;
+	srb->msg_count += spi_populate_width_msg(ptr, wide);
 	srb->state |= SRB_DO_WIDE_NEGO;
 }
 
@@ -1476,7 +1469,7 @@ static u8 start_scsi(struct AdapterCtlBlk* acb, struct DeviceCtlBlk* dcb,
 			return 1;
 		}
 		/* Send Tag id */
-		DC395x_write8(acb, TRM_S1040_SCSI_FIFO, MSG_SIMPLE_QTAG);
+		DC395x_write8(acb, TRM_S1040_SCSI_FIFO, SIMPLE_QUEUE_TAG);
 		DC395x_write8(acb, TRM_S1040_SCSI_FIFO, tag_number);
 		dcb->tag_mask |= tag_mask;
 		srb->tag_number = tag_number;
@@ -1732,8 +1725,9 @@ static void msgout_phase1(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb,
 	if (!srb->msg_count) {
 		dprintkdbg(DBG_0, "msgout_phase1: (0x%p) NOP msg\n",
 			srb->cmd);
-		DC395x_write8(acb, TRM_S1040_SCSI_FIFO, MSG_NOP);
-		DC395x_write16(acb, TRM_S1040_SCSI_CONTROL, DO_DATALATCH);	/* it's important for atn stop */
+		DC395x_write8(acb, TRM_S1040_SCSI_FIFO, NOP);
+		DC395x_write16(acb, TRM_S1040_SCSI_CONTROL, DO_DATALATCH);
+		/* it's important for atn stop */
 		DC395x_write8(acb, TRM_S1040_SCSI_COMMAND, SCMD_FIFO_OUT);
 		return;
 	}
@@ -1741,7 +1735,7 @@ static void msgout_phase1(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb,
 	for (i = 0; i < srb->msg_count; i++)
 		DC395x_write8(acb, TRM_S1040_SCSI_FIFO, *ptr++);
 	srb->msg_count = 0;
-	if (srb->msgout_buf[0] == MSG_ABORT)
+	if (srb->msgout_buf[0] == ABORT_TASK_SET)
 		srb->state = SRB_ABORT_SENT;
 
 	DC395x_write8(acb, TRM_S1040_SCSI_COMMAND, SCMD_FIFO_OUT);
@@ -2538,7 +2532,7 @@ static struct ScsiReqBlk *msgin_qtag(struct AdapterCtlBlk *acb,
 	srb = acb->tmp_srb;
 	srb->state = SRB_UNEXPECT_RESEL;
 	dcb->active_srb = srb;
-	srb->msgout_buf[0] = MSG_ABORT_TAG;
+	srb->msgout_buf[0] = ABORT_TASK;
 	srb->msg_count = 1;
 	DC395x_ENABLE_MSGOUT;
 	dprintkl(KERN_DEBUG, "msgin_qtag: Unknown tag %i - abort\n", tag);
@@ -2780,7 +2774,7 @@ static void msgin_phase0(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb,
 			msgin_reject(acb, srb);
 			break;
 
-		case MSG_IGNOREWIDE:
+		case IGNORE_WIDE_RESIDUE:
 			/* Discard  wide residual */
 			dprintkdbg(DBG_0, "msgin_phase0: Ignore Wide Residual!\n");
 			break;
diff --git a/drivers/scsi/dc395x.h b/drivers/scsi/dc395x.h
index a7786a6d462e..24a36c046d07 100644
--- a/drivers/scsi/dc395x.h
+++ b/drivers/scsi/dc395x.h
@@ -172,28 +172,6 @@
 
 #define SYNC_NEGO_OFFSET		15
 
-/* SCSI MSG BYTE */
-#define MSG_COMPLETE			0x00
-#define MSG_EXTENDED			0x01
-#define MSG_SAVE_PTR			0x02
-#define MSG_RESTORE_PTR			0x03
-#define MSG_DISCONNECT			0x04
-#define MSG_INITIATOR_ERROR		0x05
-#define MSG_ABORT			0x06
-#define MSG_REJECT_			0x07
-#define MSG_NOP				0x08
-#define MSG_PARITY_ERROR		0x09
-#define MSG_LINK_CMD_COMPL		0x0A
-#define MSG_LINK_CMD_COMPL_FLG		0x0B
-#define MSG_BUS_RESET			0x0C
-#define MSG_ABORT_TAG			0x0D
-#define MSG_SIMPLE_QTAG			0x20
-#define MSG_HEAD_QTAG			0x21
-#define MSG_ORDER_QTAG			0x22
-#define MSG_IGNOREWIDE			0x23
-#define MSG_IDENTIFY			0x80
-#define MSG_HOST_ID			0xC0
-
 /* cmd->result */
 #define STATUS_MASK_			0xFF
 #define MSG_MASK			0xFF00
-- 
2.29.2

