Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F054E36C0E5
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhD0IcG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 04:32:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:49452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235153AbhD0Ibw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:31:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74907B10B;
        Tue, 27 Apr 2021 08:31:06 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/40] dc395: use standard macros to set SCSI result
Date:   Tue, 27 Apr 2021 10:30:24 +0200
Message-Id: <20210427083046.31620-19-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210427083046.31620-1-hare@suse.de>
References: <20210427083046.31620-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use standard macros to set the SCSI result and drop the internal ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/dc395x.c | 76 ++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index a713fe605dda..598448ece8d0 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -160,22 +160,6 @@
 #define DC395x_write16(acb,address,value)	outw((value), acb->io_port_base + (address))
 #define DC395x_write32(acb,address,value)	outl((value), acb->io_port_base + (address))
 
-/* cmd->result */
-#define RES_TARGET		0x000000FF	/* Target State */
-#define RES_TARGET_LNX  STATUS_MASK	/* Only official ... */
-#define RES_ENDMSG		0x0000FF00	/* End Message */
-#define RES_DID			0x00FF0000	/* DID_ codes */
-#define RES_DRV			0xFF000000	/* DRIVER_ codes */
-
-#define MK_RES(drv,did,msg,tgt) ((int)(drv)<<24 | (int)(did)<<16 | (int)(msg)<<8 | (int)(tgt))
-#define MK_RES_LNX(drv,did,msg,tgt) ((int)(drv)<<24 | (int)(did)<<16 | (int)(msg)<<8 | (int)(tgt)<<1)
-
-#define SET_RES_TARGET(who,tgt) { who &= ~RES_TARGET; who |= (int)(tgt); }
-#define SET_RES_TARGET_LNX(who,tgt) { who &= ~RES_TARGET_LNX; who |= (int)(tgt) << 1; }
-#define SET_RES_MSG(who,msg) { who &= ~RES_ENDMSG; who |= (int)(msg) << 8; }
-#define SET_RES_DID(who,did) { who &= ~RES_DID; who |= (int)(did) << 16; }
-#define SET_RES_DRV(who,drv) { who &= ~RES_DRV; who |= (int)(drv) << 24; }
-
 #define TAG_NONE 255
 
 /*
@@ -986,7 +970,7 @@ static int dc395x_queue_command_lck(struct scsi_cmnd *cmd, void (*done)(struct s
 		cmd, cmd->device->id, (u8)cmd->device->lun, cmd->cmnd[0]);
 
 	/* Assume BAD_TARGET; will be cleared later */
-	cmd->result = DID_BAD_TARGET << 16;
+	set_host_byte(cmd, DID_BAD_TARGET);
 
 	/* ignore invalid targets */
 	if (cmd->device->id >= acb->scsi_host->max_id ||
@@ -1013,7 +997,8 @@ static int dc395x_queue_command_lck(struct scsi_cmnd *cmd, void (*done)(struct s
 
 	/* set callback and clear result in the command */
 	cmd->scsi_done = done;
-	cmd->result = 0;
+	set_host_byte(cmd, DID_OK);
+	set_status_byte(cmd, SAM_STAT_GOOD);
 
 	srb = list_first_entry_or_null(&acb->srb_free_list,
 			struct ScsiReqBlk, list);
@@ -1250,7 +1235,7 @@ static int dc395x_eh_abort(struct scsi_cmnd *cmd)
 		free_tag(dcb, srb);
 		list_add_tail(&srb->list, &acb->srb_free_list);
 		dprintkl(KERN_DEBUG, "eh_abort: Command was waiting\n");
-		cmd->result = DID_ABORT << 16;
+		set_host_byte(cmd, DID_ABORT);
 		return SUCCESS;
 	}
 	srb = find_cmd(cmd, &dcb->srb_going_list);
@@ -3178,6 +3163,8 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		   srb, scsi_sg_count(cmd), srb->sg_index, srb->sg_count,
 		   scsi_sgtalbe(cmd));
 	status = srb->target_status;
+	set_host_byte(cmd, DID_OK);
+	set_status_byte(cmd, SAM_STAT_GOOD);
 	if (srb->flag & AUTO_REQSENSE) {
 		dprintkdbg(DBG_0, "srb_done: AUTO_REQSENSE1\n");
 		pci_unmap_srb_sense(acb, srb);
@@ -3186,7 +3173,7 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		 */
 		srb->flag &= ~AUTO_REQSENSE;
 		srb->adapter_status = 0;
-		srb->target_status = CHECK_CONDITION << 1;
+		srb->target_status = SAM_STAT_CHECK_CONDITION;
 		if (debug_enabled(DBG_1)) {
 			switch (cmd->sense_buffer[2] & 0x0f) {
 			case NOT_READY:
@@ -3233,15 +3220,14 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 					*((unsigned int *)(cmd->sense_buffer + 3)));
 		}
 
-		if (status == (CHECK_CONDITION << 1)) {
-			cmd->result = DID_BAD_TARGET << 16;
+		if (status == SAM_STAT_CHECK_CONDITION) {
+			set_host_byte(cmd, DID_BAD_TARGET);
 			goto ckc_e;
 		}
 		dprintkdbg(DBG_0, "srb_done: AUTO_REQSENSE2\n");
 
-		cmd->result =
-		    MK_RES(0, DID_OK,
-			   srb->end_message, SAM_STAT_CHECK_CONDITION);
+		set_msg_byte(cmd, srb->end_message);
+		set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);
 
 		goto ckc_e;
 	}
@@ -3251,10 +3237,10 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		/*
 		 * target status..........................
 		 */
-		if (status >> 1 == CHECK_CONDITION) {
+		if (status == SAM_STAT_CHECK_CONDITION) {
 			request_sense(acb, dcb, srb);
 			return;
-		} else if (status >> 1 == QUEUE_FULL) {
+		} else if (status == SAM_STAT_TASK_SET_FULL) {
 			tempcnt = (u8)list_size(&dcb->srb_going_list);
 			dprintkl(KERN_INFO, "QUEUE_FULL for dev <%02i-%i> with %i cmnds\n",
 			     dcb->target_id, dcb->target_lun, tempcnt);
@@ -3270,13 +3256,12 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		} else if (status == SCSI_STAT_SEL_TIMEOUT) {
 			srb->adapter_status = H_SEL_TIMEOUT;
 			srb->target_status = 0;
-			cmd->result = DID_NO_CONNECT << 16;
+			set_host_byte(cmd, DID_NO_CONNECT);
 		} else {
 			srb->adapter_status = 0;
-			SET_RES_DID(cmd->result, DID_ERROR);
-			SET_RES_MSG(cmd->result, srb->end_message);
-			SET_RES_TARGET(cmd->result, status);
-
+			set_host_byte(cmd, DID_ERROR);
+			set_msg_byte(cmd, srb->end_message);
+			set_status_byte(cmd, status);
 		}
 	} else {
 		/*
@@ -3285,16 +3270,14 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		status = srb->adapter_status;
 		if (status & H_OVER_UNDER_RUN) {
 			srb->target_status = 0;
-			SET_RES_DID(cmd->result, DID_OK);
-			SET_RES_MSG(cmd->result, srb->end_message);
+			set_msg_byte(cmd, srb->end_message);
 		} else if (srb->status & PARITY_ERROR) {
-			SET_RES_DID(cmd->result, DID_PARITY);
-			SET_RES_MSG(cmd->result, srb->end_message);
+			set_host_byte(cmd, DID_PARITY);
+			set_msg_byte(cmd, srb->end_message);
 		} else {	/* No error */
 
 			srb->adapter_status = 0;
 			srb->target_status = 0;
-			SET_RES_DID(cmd->result, DID_OK);
 		}
 	}
 
@@ -3315,15 +3298,15 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		base = scsi_kmap_atomic_sg(sg, scsi_sg_count(cmd), &offset, &len);
 		ptr = (struct ScsiInqData *)(base + offset);
 
-		if (!ckc_only && (cmd->result & RES_DID) == 0
+		if (!ckc_only && get_host_byte(cmd) == DID_OK
 		    && cmd->cmnd[2] == 0 && scsi_bufflen(cmd) >= 8
 		    && dir != DMA_NONE && ptr && (ptr->Vers & 0x07) >= 2)
 			dcb->inquiry7 = ptr->Flags;
 
 	/*if( srb->cmd->cmnd[0] == INQUIRY && */
 	/*  (host_byte(cmd->result) == DID_OK || status_byte(cmd->result) & CHECK_CONDITION) ) */
-		if ((cmd->result == (DID_OK << 16) ||
-		     status_byte(cmd->result) == CHECK_CONDITION)) {
+		if ((get_host_byte(cmd) == DID_OK) ||
+		    (get_status_byte(cmd) == SAM_STAT_CHECK_CONDITION)) {
 			if (!dcb->init_tcq_flag) {
 				add_dev(acb, dcb, ptr);
 				dcb->init_tcq_flag = 1;
@@ -3350,7 +3333,7 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 	if (srb != acb->tmp_srb) {
 		/* Add to free list */
 		dprintkdbg(DBG_0, "srb_done: (0x%p) done result=0x%08x\n",
-			cmd, cmd->result);
+			   cmd, cmd->result);
 		list_move_tail(&srb->list, &acb->srb_free_list);
 	} else {
 		dprintkl(KERN_ERR, "srb_done: ERROR! Completed cmd with tmp_srb\n");
@@ -3374,16 +3357,14 @@ static void doing_srb_done(struct AdapterCtlBlk *acb, u8 did_flag,
 		struct scsi_cmnd *p;
 
 		list_for_each_entry_safe(srb, tmp, &dcb->srb_going_list, list) {
-			int result;
-
 			p = srb->cmd;
-			result = MK_RES(0, did_flag, 0, 0);
 			printk("G:%p(%02i-%i) ", p,
 			       p->device->id, (u8)p->device->lun);
 			list_del(&srb->list);
 			free_tag(dcb, srb);
 			list_add_tail(&srb->list, &acb->srb_free_list);
-			p->result = result;
+			set_host_byte(p, did_flag);
+			set_status_byte(p, SAM_STAT_GOOD);
 			pci_unmap_srb_sense(acb, srb);
 			pci_unmap_srb(acb, srb);
 			if (force) {
@@ -3404,14 +3385,13 @@ static void doing_srb_done(struct AdapterCtlBlk *acb, u8 did_flag,
 
 		/* Waiting queue */
 		list_for_each_entry_safe(srb, tmp, &dcb->srb_waiting_list, list) {
-			int result;
 			p = srb->cmd;
 
-			result = MK_RES(0, did_flag, 0, 0);
 			printk("W:%p<%02i-%i>", p, p->device->id,
 			       (u8)p->device->lun);
 			list_move_tail(&srb->list, &acb->srb_free_list);
-			p->result = result;
+			set_host_byte(p, did_flag);
+			set_status_byte(p, SAM_STAT_GOOD);
 			pci_unmap_srb_sense(acb, srb);
 			pci_unmap_srb(acb, srb);
 			if (force) {
-- 
2.29.2

