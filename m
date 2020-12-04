Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22C72CEBC8
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbgLDKDz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:03:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:52116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgLDKDy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:03:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18C8AAE91;
        Fri,  4 Dec 2020 10:01:48 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 19/37] aic7xxx,aic79xx: drop internal SCSI message definition
Date:   Fri,  4 Dec 2020 11:01:22 +0100
Message-Id: <20201204100140.140863-20-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201204100140.140863-1-hare@suse.de>
References: <20201204100140.140863-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the standard SCSI message definitions instead of the
driver-internal ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 138 ++++++++++++++++++------------------
 drivers/scsi/aic7xxx/aic79xx_osm.c  |   4 +-
 drivers/scsi/aic7xxx/aic7xxx_core.c | 126 ++++++++++++++++----------------
 drivers/scsi/aic7xxx/aic7xxx_osm.c  |   5 +-
 drivers/scsi/aic7xxx/scsi_message.h |  41 -----------
 include/scsi/scsi.h                 |   1 +
 6 files changed, 138 insertions(+), 177 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index d81220525fca..e409cdc9c367 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -73,16 +73,16 @@ static const u_int num_errors = ARRAY_SIZE(ahd_hard_errors);
 
 static const struct ahd_phase_table_entry ahd_phase_table[] =
 {
-	{ P_DATAOUT,	MSG_NOOP,		"in Data-out phase"	},
-	{ P_DATAIN,	MSG_INITIATOR_DET_ERR,	"in Data-in phase"	},
-	{ P_DATAOUT_DT,	MSG_NOOP,		"in DT Data-out phase"	},
-	{ P_DATAIN_DT,	MSG_INITIATOR_DET_ERR,	"in DT Data-in phase"	},
-	{ P_COMMAND,	MSG_NOOP,		"in Command phase"	},
-	{ P_MESGOUT,	MSG_NOOP,		"in Message-out phase"	},
-	{ P_STATUS,	MSG_INITIATOR_DET_ERR,	"in Status phase"	},
+	{ P_DATAOUT,	NOP,			"in Data-out phase"	},
+	{ P_DATAIN,	INITIATOR_ERROR,	"in Data-in phase"	},
+	{ P_DATAOUT_DT,	NOP,			"in DT Data-out phase"	},
+	{ P_DATAIN_DT,	INITIATOR_ERROR,	"in DT Data-in phase"	},
+	{ P_COMMAND,	NOP,			"in Command phase"	},
+	{ P_MESGOUT,	NOP,			"in Message-out phase"	},
+	{ P_STATUS,	INITIATOR_ERROR,	"in Status phase"	},
 	{ P_MESGIN,	MSG_PARITY_ERROR,	"in Message-in phase"	},
-	{ P_BUSFREE,	MSG_NOOP,		"while idle"		},
-	{ 0,		MSG_NOOP,		"in unknown phase"	}
+	{ P_BUSFREE,	NOP,			"while idle"		},
+	{ 0,		NOP,			"in unknown phase"	}
 };
 
 /*
@@ -1126,7 +1126,7 @@ ahd_restart(struct ahd_softc *ahd)
 	/* No more pending messages */
 	ahd_clear_msg_state(ahd);
 	ahd_outb(ahd, SCSISIGO, 0);		/* De-assert BSY */
-	ahd_outb(ahd, MSG_OUT, MSG_NOOP);	/* No message to send */
+	ahd_outb(ahd, MSG_OUT, NOP);	/* No message to send */
 	ahd_outb(ahd, SXFRCTL1, ahd_inb(ahd, SXFRCTL1) & ~BITBUCKET);
 	ahd_outb(ahd, SEQINTCTL, 0);
 	ahd_outb(ahd, LASTPHASE, P_BUSFREE);
@@ -2007,7 +2007,7 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 			 */
 			ahd_assert_atn(ahd);
 			ahd_outb(ahd, MSG_OUT, HOST_MSG);
-			ahd->msgout_buf[0] = MSG_ABORT_TASK;
+			ahd->msgout_buf[0] = ABORT_TASK;
 			ahd->msgout_len = 1;
 			ahd->msgout_index = 0;
 			ahd->msg_type = MSG_TYPE_INITIATOR_MSGOUT;
@@ -2135,7 +2135,7 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 		printk("SXFRCTL0 == 0x%x\n", ahd_inb(ahd, SXFRCTL0));
 		printk("SEQCTL0 == 0x%x\n", ahd_inb(ahd, SEQCTL0));
 		ahd_dump_card_state(ahd);
-		ahd->msgout_buf[0] = MSG_BUS_DEV_RESET;
+		ahd->msgout_buf[0] = TARGET_RESET;
 		ahd->msgout_len = 1;
 		ahd->msgout_index = 0;
 		ahd->msg_type = MSG_TYPE_INITIATOR_MSGOUT;
@@ -2691,7 +2691,7 @@ ahd_handle_transmission_error(struct ahd_softc *ahd)
 	lastphase = ahd_inb(ahd, LASTPHASE);
 	curphase = ahd_inb(ahd, SCSISIGI) & PHASE_MASK;
 	perrdiag = ahd_inb(ahd, PERRDIAG);
-	msg_out = MSG_INITIATOR_DET_ERR;
+	msg_out = INITIATOR_ERROR;
 	ahd_outb(ahd, CLRSINT1, CLRSCSIPERR);
 
 	/*
@@ -2823,14 +2823,14 @@ ahd_handle_transmission_error(struct ahd_softc *ahd)
 	}
 
 	/*
-	 * We've set the hardware to assert ATN if we 
+	 * We've set the hardware to assert ATN if we
 	 * get a parity error on "in" phases, so all we
 	 * need to do is stuff the message buffer with
 	 * the appropriate message.  "In" phases have set
-	 * mesg_out to something other than MSG_NOP.
+	 * mesg_out to something other than NOP.
 	 */
 	ahd->send_msg_perror = msg_out;
-	if (scb != NULL && msg_out == MSG_INITIATOR_DET_ERR)
+	if (scb != NULL && msg_out == INITIATOR_ERROR)
 		scb->flags |= SCB_TRANSMISSION_ERROR;
 	ahd_outb(ahd, MSG_OUT, HOST_MSG);
 	ahd_outb(ahd, CLRINT, CLRSCSIINT);
@@ -3050,8 +3050,8 @@ ahd_handle_nonpkt_busfree(struct ahd_softc *ahd)
 		u_int tag;
 
 		tag = SCB_LIST_NULL;
-		if (ahd_sent_msg(ahd, AHDMSG_1B, MSG_ABORT_TAG, TRUE)
-		 || ahd_sent_msg(ahd, AHDMSG_1B, MSG_ABORT, TRUE)) {
+		if (ahd_sent_msg(ahd, AHDMSG_1B, ABORT_TASK, TRUE)
+		 || ahd_sent_msg(ahd, AHDMSG_1B, ABORT_TASK_SET, TRUE)) {
 			int found;
 			int sent_msg;
 
@@ -3066,9 +3066,9 @@ ahd_handle_nonpkt_busfree(struct ahd_softc *ahd)
 			ahd_print_path(ahd, scb);
 			printk("SCB %d - Abort%s Completed.\n",
 			       SCB_GET_TAG(scb),
-			       sent_msg == MSG_ABORT_TAG ? "" : " Tag");
+			       sent_msg == ABORT_TASK ? "" : " Tag");
 
-			if (sent_msg == MSG_ABORT_TAG)
+			if (sent_msg == ABORT_TASK)
 				tag = SCB_GET_TAG(scb);
 
 			if ((scb->flags & SCB_EXTERNAL_RESET) != 0) {
@@ -3093,12 +3093,12 @@ ahd_handle_nonpkt_busfree(struct ahd_softc *ahd)
 			printk("found == 0x%x\n", found);
 			printerror = 0;
 		} else if (ahd_sent_msg(ahd, AHDMSG_1B,
-					MSG_BUS_DEV_RESET, TRUE)) {
+					TARGET_RESET, TRUE)) {
 			ahd_handle_devreset(ahd, &devinfo, CAM_LUN_WILDCARD,
 					    CAM_BDR_SENT, "Bus Device Reset",
 					    /*verbose_level*/0);
 			printerror = 0;
-		} else if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_PPR, FALSE)
+		} else if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_PPR, FALSE)
 			&& ppr_busfree == 0) {
 			struct ahd_initiator_tinfo *tinfo;
 			struct ahd_tmode_tstate *tstate;
@@ -3151,7 +3151,7 @@ ahd_handle_nonpkt_busfree(struct ahd_softc *ahd)
 				}
 				printerror = 0;
 			}
-		} else if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_WDTR, FALSE)
+		} else if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_WDTR, FALSE)
 			&& ppr_busfree == 0) {
 			/*
 			 * Negotiation Rejected.  Go-narrow and
@@ -3176,7 +3176,7 @@ ahd_handle_nonpkt_busfree(struct ahd_softc *ahd)
 				ahd_qinfifo_requeue_tail(ahd, scb);
 			}
 			printerror = 0;
-		} else if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_SDTR, FALSE)
+		} else if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_SDTR, FALSE)
 			&& ppr_busfree == 0) {
 			/*
 			 * Negotiation Rejected.  Go-async and
@@ -3204,7 +3204,7 @@ ahd_handle_nonpkt_busfree(struct ahd_softc *ahd)
 			printerror = 0;
 		} else if ((ahd->msg_flags & MSG_FLAG_EXPECT_IDE_BUSFREE) != 0
 			&& ahd_sent_msg(ahd, AHDMSG_1B,
-					 MSG_INITIATOR_DET_ERR, TRUE)) {
+					 INITIATOR_ERROR, TRUE)) {
 
 #ifdef AHD_DEBUG
 			if ((ahd_debug & AHD_SHOW_MESSAGES) != 0)
@@ -3213,7 +3213,7 @@ ahd_handle_nonpkt_busfree(struct ahd_softc *ahd)
 			printerror = 0;
 		} else if ((ahd->msg_flags & MSG_FLAG_EXPECT_QASREJ_BUSFREE)
 			&& ahd_sent_msg(ahd, AHDMSG_1B,
-					MSG_MESSAGE_REJECT, TRUE)) {
+					MESSAGE_REJECT, TRUE)) {
 
 #ifdef AHD_DEBUG
 			if ((ahd_debug & AHD_SHOW_MESSAGES) != 0)
@@ -3367,7 +3367,7 @@ ahd_handle_proto_violation(struct ahd_softc *ahd)
 		ahd_outb(ahd, MSG_OUT, HOST_MSG);
 		if (scb == NULL) {
 			ahd_print_devinfo(ahd, &devinfo);
-			ahd->msgout_buf[0] = MSG_ABORT_TASK;
+			ahd->msgout_buf[0] = ABORT_TASK;
 			ahd->msgout_len = 1;
 			ahd->msgout_index = 0;
 			ahd->msg_type = MSG_TYPE_INITIATOR_MSGOUT;
@@ -4389,7 +4389,7 @@ ahd_setup_initiator_msgout(struct ahd_softc *ahd, struct ahd_devinfo *devinfo,
 	} else if (scb == NULL) {
 		printk("%s: WARNING. No pending message for "
 		       "I_T msgin.  Issuing NO-OP\n", ahd_name(ahd));
-		ahd->msgout_buf[ahd->msgout_index++] = MSG_NOOP;
+		ahd->msgout_buf[ahd->msgout_index++] = NOP;
 		ahd->msgout_len++;
 		ahd->msg_type = MSG_TYPE_INITIATOR_MSGOUT;
 		return;
@@ -4415,7 +4415,7 @@ ahd_setup_initiator_msgout(struct ahd_softc *ahd, struct ahd_devinfo *devinfo,
 	}
 
 	if (scb->flags & SCB_DEVICE_RESET) {
-		ahd->msgout_buf[ahd->msgout_index++] = MSG_BUS_DEV_RESET;
+		ahd->msgout_buf[ahd->msgout_index++] = TARGET_RESET;
 		ahd->msgout_len++;
 		ahd_print_path(ahd, scb);
 		printk("Bus Device Reset Message Sent\n");
@@ -4430,9 +4430,9 @@ ahd_setup_initiator_msgout(struct ahd_softc *ahd, struct ahd_devinfo *devinfo,
 	} else if ((scb->flags & SCB_ABORT) != 0) {
 
 		if ((scb->hscb->control & TAG_ENB) != 0) {
-			ahd->msgout_buf[ahd->msgout_index++] = MSG_ABORT_TAG;
+			ahd->msgout_buf[ahd->msgout_index++] = ABORT_TASK;
 		} else {
-			ahd->msgout_buf[ahd->msgout_index++] = MSG_ABORT;
+			ahd->msgout_buf[ahd->msgout_index++] = ABORT_TASK_SET;
 		}
 		ahd->msgout_len++;
 		ahd_print_path(ahd, scb);
@@ -4664,7 +4664,7 @@ ahd_clear_msg_state(struct ahd_softc *ahd)
 		 */
 		ahd_outb(ahd, CLRSINT1, CLRATNO);
 	}
-	ahd_outb(ahd, MSG_OUT, MSG_NOOP);
+	ahd_outb(ahd, MSG_OUT, NOP);
 	ahd_outb(ahd, SEQ_FLAGS2,
 		 ahd_inb(ahd, SEQ_FLAGS2) & ~TARGET_MSG_PENDING);
 	ahd_restore_modes(ahd, saved_modes);
@@ -4745,7 +4745,7 @@ ahd_handle_message_phase(struct ahd_softc *ahd)
 			 * with a busfree.
 			 */
 			if ((ahd->msg_flags & MSG_FLAG_PACKETIZED) != 0
-			 && ahd->send_msg_perror == MSG_INITIATOR_DET_ERR)
+			 && ahd->send_msg_perror == INITIATOR_ERROR)
 				ahd->msg_flags |= MSG_FLAG_EXPECT_IDE_BUSFREE;
 
 			ahd_outb(ahd, RETURN_2, ahd->send_msg_perror);
@@ -5023,7 +5023,7 @@ ahd_sent_msg(struct ahd_softc *ahd, ahd_msgtype type, u_int msgval, int full)
 	index = 0;
 
 	while (index < ahd->msgout_len) {
-		if (ahd->msgout_buf[index] == MSG_EXTENDED) {
+		if (ahd->msgout_buf[index] == EXTENDED_MESSAGE) {
 			u_int end_index;
 
 			end_index = index + 1 + ahd->msgout_buf[index + 1];
@@ -5037,8 +5037,8 @@ ahd_sent_msg(struct ahd_softc *ahd, ahd_msgtype type, u_int msgval, int full)
 					found = TRUE;
 			}
 			index = end_index;
-		} else if (ahd->msgout_buf[index] >= MSG_SIMPLE_TASK
-			&& ahd->msgout_buf[index] <= MSG_IGN_WIDE_RESIDUE) {
+		} else if (ahd->msgout_buf[index] >= SIMPLE_QUEUE_TAG
+			&& ahd->msgout_buf[index] <= IGNORE_WIDE_RESIDUE) {
 
 			/* Skip tag type and tag id or residue param*/
 			index += 2;
@@ -5089,30 +5089,30 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 	 * extended message type.
 	 */
 	switch (ahd->msgin_buf[0]) {
-	case MSG_DISCONNECT:
-	case MSG_SAVEDATAPOINTER:
-	case MSG_CMDCOMPLETE:
-	case MSG_RESTOREPOINTERS:
-	case MSG_IGN_WIDE_RESIDUE:
+	case DISCONNECT:
+	case SAVE_POINTERS:
+	case COMMAND_COMPLETE:
+	case RESTORE_POINTERS:
+	case IGNORE_WIDE_RESIDUE:
 		/*
 		 * End our message loop as these are messages
 		 * the sequencer handles on its own.
 		 */
 		done = MSGLOOP_TERMINATED;
 		break;
-	case MSG_MESSAGE_REJECT:
+	case MESSAGE_REJECT:
 		response = ahd_handle_msg_reject(ahd, devinfo);
 		fallthrough;
-	case MSG_NOOP:
+	case NOP:
 		done = MSGLOOP_MSGCOMPLETE;
 		break;
-	case MSG_EXTENDED:
+	case EXTENDED_MESSAGE:
 	{
 		/* Wait for enough of the message to begin validation */
 		if (ahd->msgin_index < 2)
 			break;
 		switch (ahd->msgin_buf[2]) {
-		case MSG_EXT_SDTR:
+		case EXTENDED_SDTR:
 		{
 			u_int	 period;
 			u_int	 ppr_options;
@@ -5160,7 +5160,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			 * and didn't have to fall down to async
 			 * transfers.
 			 */
-			if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_SDTR, TRUE)) {
+			if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_SDTR, TRUE)) {
 				/* We started it */
 				if (saved_offset != offset) {
 					/* Went too low - force async */
@@ -5187,7 +5187,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			done = MSGLOOP_MSGCOMPLETE;
 			break;
 		}
-		case MSG_EXT_WDTR:
+		case EXTENDED_WDTR:
 		{
 			u_int bus_width;
 			u_int saved_width;
@@ -5221,7 +5221,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 				       saved_width, bus_width);
 			}
 
-			if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_WDTR, TRUE)) {
+			if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_WDTR, TRUE)) {
 				/*
 				 * Don't send a WDTR back to the
 				 * target, since we asked first.
@@ -5283,7 +5283,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			done = MSGLOOP_MSGCOMPLETE;
 			break;
 		}
-		case MSG_EXT_PPR:
+		case EXTENDED_PPR:
 		{
 			u_int	period;
 			u_int	offset;
@@ -5338,7 +5338,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			ahd_validate_offset(ahd, tinfo, period, &offset,
 					    bus_width, devinfo->role);
 
-			if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_PPR, TRUE)) {
+			if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_PPR, TRUE)) {
 				/*
 				 * If we are unable to do any of the
 				 * requested options (we went too low),
@@ -5401,7 +5401,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		break;
 	}
 #ifdef AHD_TARGET_MODE
-	case MSG_BUS_DEV_RESET:
+	case TARGET_RESET:
 		ahd_handle_devreset(ahd, devinfo, CAM_LUN_WILDCARD,
 				    CAM_BDR_SENT,
 				    "Bus Device Reset Received",
@@ -5409,9 +5409,9 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		ahd_restart(ahd);
 		done = MSGLOOP_TERMINATED;
 		break;
-	case MSG_ABORT_TAG:
-	case MSG_ABORT:
-	case MSG_CLEAR_QUEUE:
+	case ABORT_TASK:
+	case ABORT_TASK_SET:
+	case CLEAR_TASK_SET:
 	{
 		int tag;
 
@@ -5421,7 +5421,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			break;
 		}
 		tag = SCB_LIST_NULL;
-		if (ahd->msgin_buf[0] == MSG_ABORT_TAG)
+		if (ahd->msgin_buf[0] == ABORT_TASK)
 			tag = ahd_inb(ahd, INITIATOR_TAG);
 		ahd_abort_scbs(ahd, devinfo->target, devinfo->channel,
 			       devinfo->lun, tag, ROLE_TARGET,
@@ -5445,7 +5445,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		break;
 	}
 #endif
-	case MSG_QAS_REQUEST:
+	case QAS_REQUEST:
 #ifdef AHD_DEBUG
 		if ((ahd_debug & AHD_SHOW_MESSAGES) != 0)
 			printk("%s: QAS request.  SCSISIGI == 0x%x\n",
@@ -5453,7 +5453,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 #endif
 		ahd->msg_flags |= MSG_FLAG_EXPECT_QASREJ_BUSFREE;
 		fallthrough;
-	case MSG_TERM_IO_PROC:
+	case TERMINATE_IO_PROC:
 	default:
 		reject = TRUE;
 		break;
@@ -5465,7 +5465,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		 */
 		ahd->msgout_index = 0;
 		ahd->msgout_len = 1;
-		ahd->msgout_buf[0] = MSG_MESSAGE_REJECT;
+		ahd->msgout_buf[0] = MESSAGE_REJECT;
 		done = MSGLOOP_MSGCOMPLETE;
 		response = TRUE;
 	}
@@ -5504,8 +5504,8 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 	/* Might be necessary */
 	last_msg = ahd_inb(ahd, LAST_MSG);
 
-	if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_PPR, /*full*/FALSE)) {
-		if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_PPR, /*full*/TRUE)
+	if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_PPR, /*full*/FALSE)) {
+		if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_PPR, /*full*/TRUE)
 		 && tinfo->goal.period <= AHD_SYNCRATE_PACED) {
 			/*
 			 * Target may not like our SPI-4 PPR Options.
@@ -5542,7 +5542,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		ahd_build_transfer_msg(ahd, devinfo);
 		ahd->msgout_index = 0;
 		response = 1;
-	} else if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_WDTR, /*full*/FALSE)) {
+	} else if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_WDTR, /*full*/FALSE)) {
 
 		/* note 8bit xfers */
 		printk("(%s:%c:%d:%d): refuses WIDE negotiation.  Using "
@@ -5567,7 +5567,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			ahd->msgout_index = 0;
 			response = 1;
 		}
-	} else if (ahd_sent_msg(ahd, AHDMSG_EXT, MSG_EXT_SDTR, /*full*/FALSE)) {
+	} else if (ahd_sent_msg(ahd, AHDMSG_EXT, EXTENDED_SDTR, /*full*/FALSE)) {
 		/* note asynch xfers and clear flag */
 		ahd_set_syncrate(ahd, devinfo, /*period*/0,
 				 /*offset*/0, /*ppr_options*/0,
@@ -5577,13 +5577,13 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		       "Using asynchronous transfers\n",
 		       ahd_name(ahd), devinfo->channel,
 		       devinfo->target, devinfo->lun);
-	} else if ((scb->hscb->control & MSG_SIMPLE_TASK) != 0) {
+	} else if ((scb->hscb->control & SIMPLE_QUEUE_TAG) != 0) {
 		int tag_type;
 		int mask;
 
-		tag_type = (scb->hscb->control & MSG_SIMPLE_TASK);
+		tag_type = (scb->hscb->control & SIMPLE_QUEUE_TAG);
 
-		if (tag_type == MSG_SIMPLE_TASK) {
+		if (tag_type == SIMPLE_QUEUE_TAG) {
 			printk("(%s:%c:%d:%d): refuses tagged commands.  "
 			       "Performing non-tagged I/O\n", ahd_name(ahd),
 			       devinfo->channel, devinfo->target, devinfo->lun);
@@ -5593,7 +5593,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			printk("(%s:%c:%d:%d): refuses %s tagged commands.  "
 			       "Performing simple queue tagged I/O only\n",
 			       ahd_name(ahd), devinfo->channel, devinfo->target,
-			       devinfo->lun, tag_type == MSG_ORDERED_TASK
+			       devinfo->lun, tag_type == ORDERED_QUEUE_TAG
 			       ? "ordered" : "head of queue");
 			ahd_set_tags(ahd, scb->io_ctx, devinfo, AHD_QUEUE_BASIC);
 			mask = ~0x03;
@@ -5607,7 +5607,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			 ahd_inb_scbram(ahd, SCB_CONTROL) & mask);
 		scb->hscb->control &= mask;
 		ahd_set_transaction_tag(scb, /*enabled*/FALSE,
-					/*type*/MSG_SIMPLE_TASK);
+					/*type*/SIMPLE_QUEUE_TAG);
 		ahd_outb(ahd, MSG_OUT, MSG_IDENTIFYFLAG);
 		ahd_assert_atn(ahd);
 		ahd_busy_tcl(ahd, BUILD_TCL(scb->hscb->scsiid, devinfo->lun),
@@ -5922,7 +5922,7 @@ ahd_handle_devreset(struct ahd_softc *ahd, struct ahd_devinfo *devinfo,
 				continue;
 
 			ahd_queue_lstate_event(ahd, lstate, devinfo->our_scsiid,
-					       MSG_BUS_DEV_RESET, /*arg*/0);
+					       TARGET_RESET, /*arg*/0);
 			ahd_send_lstate_events(ahd, lstate);
 		}
 	}
@@ -9160,7 +9160,7 @@ ahd_queue_lstate_event(struct ahd_softc *ahd, struct ahd_tmode_lstate *lstate,
 			- (lstate->event_r_idx - lstate->event_w_idx);
 
 	if (event_type == EVENT_TYPE_BUS_RESET
-	 || event_type == MSG_BUS_DEV_RESET) {
+	 || event_type == TARGET_RESET) {
 		/*
 		 * Any earlier events are irrelevant, so reset our buffer.
 		 * This has the effect of allowing us to deal with reset
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 4a91385fdfea..4f7102f8eeb0 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -1602,10 +1602,10 @@ ahd_linux_run_command(struct ahd_softc *ahd, struct ahd_linux_device *dev,
 	if ((dev->flags & (AHD_DEV_Q_TAGGED|AHD_DEV_Q_BASIC)) != 0) {
 		if (dev->commands_since_idle_or_otag == AHD_OTAG_THRESH
 		 && (dev->flags & AHD_DEV_Q_TAGGED) != 0) {
-			hscb->control |= MSG_ORDERED_TASK;
+			hscb->control |= ORDERED_QUEUE_TAG;
 			dev->commands_since_idle_or_otag = 0;
 		} else {
-			hscb->control |= MSG_SIMPLE_TASK;
+			hscb->control |= SIMPLE_QUEUE_TAG;
 		}
 	}
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index a320be2e76f3..f7e77948d185 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -84,16 +84,16 @@ static const u_int num_errors = ARRAY_SIZE(ahc_hard_errors);
 
 static const struct ahc_phase_table_entry ahc_phase_table[] =
 {
-	{ P_DATAOUT,	MSG_NOOP,		"in Data-out phase"	},
-	{ P_DATAIN,	MSG_INITIATOR_DET_ERR,	"in Data-in phase"	},
-	{ P_DATAOUT_DT,	MSG_NOOP,		"in DT Data-out phase"	},
-	{ P_DATAIN_DT,	MSG_INITIATOR_DET_ERR,	"in DT Data-in phase"	},
-	{ P_COMMAND,	MSG_NOOP,		"in Command phase"	},
-	{ P_MESGOUT,	MSG_NOOP,		"in Message-out phase"	},
-	{ P_STATUS,	MSG_INITIATOR_DET_ERR,	"in Status phase"	},
+	{ P_DATAOUT,	NOP,			"in Data-out phase"	},
+	{ P_DATAIN,	INITIATOR_ERROR,	"in Data-in phase"	},
+	{ P_DATAOUT_DT,	NOP,			"in DT Data-out phase"	},
+	{ P_DATAIN_DT,	INITIATOR_ERROR,	"in DT Data-in phase"	},
+	{ P_COMMAND,	NOP,			"in Command phase"	},
+	{ P_MESGOUT,	NOP,			"in Message-out phase"	},
+	{ P_STATUS,	INITIATOR_ERROR,	"in Status phase"	},
 	{ P_MESGIN,	MSG_PARITY_ERROR,	"in Message-in phase"	},
-	{ P_BUSFREE,	MSG_NOOP,		"while idle"		},
-	{ 0,		MSG_NOOP,		"in unknown phase"	}
+	{ P_BUSFREE,	NOP,			"while idle"		},
+	{ 0,		NOP,			"in unknown phase"	}
 };
 
 /*
@@ -815,7 +815,7 @@ ahc_restart(struct ahc_softc *ahc)
 	ahc_clear_msg_state(ahc);
 
 	ahc_outb(ahc, SCSISIGO, 0);		/* De-assert BSY */
-	ahc_outb(ahc, MSG_OUT, MSG_NOOP);	/* No message to send */
+	ahc_outb(ahc, MSG_OUT, NOP);	/* No message to send */
 	ahc_outb(ahc, SXFRCTL1, ahc_inb(ahc, SXFRCTL1) & ~BITBUCKET);
 	ahc_outb(ahc, LASTPHASE, P_BUSFREE);
 	ahc_outb(ahc, SAVED_SCSIID, 0xFF);
@@ -1179,7 +1179,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 		printk("SXFRCTL0 == 0x%x\n", ahc_inb(ahc, SXFRCTL0));
 		printk("SEQCTL == 0x%x\n", ahc_inb(ahc, SEQCTL));
 		ahc_dump_card_state(ahc);
-		ahc->msgout_buf[0] = MSG_BUS_DEV_RESET;
+		ahc->msgout_buf[0] = TARGET_RESET;
 		ahc->msgout_len = 1;
 		ahc->msgout_index = 0;
 		ahc->msg_type = MSG_TYPE_INITIATOR_MSGOUT;
@@ -1683,7 +1683,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 			 * data direction, so ignore the value
 			 * in the phase table.
 			 */
-			mesg_out = MSG_INITIATOR_DET_ERR;
+			mesg_out = INITIATOR_ERROR;
 		}
 
 		/*
@@ -1693,7 +1693,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 		 * the appropriate message.  "In" phases have set
 		 * mesg_out to something other than MSG_NOP.
 		 */
-		if (mesg_out != MSG_NOOP) {
+		if (mesg_out != NOP) {
 			if (ahc->msg_type != MSG_TYPE_NONE)
 				ahc->send_msg_perror = TRUE;
 			else
@@ -1817,10 +1817,10 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 			u_int tag;
 
 			tag = SCB_LIST_NULL;
-			if (ahc_sent_msg(ahc, AHCMSG_1B, MSG_ABORT_TAG, TRUE)
-			 || ahc_sent_msg(ahc, AHCMSG_1B, MSG_ABORT, TRUE)) {
+			if (ahc_sent_msg(ahc, AHCMSG_1B, ABORT_TASK, TRUE)
+			 || ahc_sent_msg(ahc, AHCMSG_1B, ABORT_TASK_SET, TRUE)) {
 				if (ahc->msgout_buf[ahc->msgout_index - 1]
-				 == MSG_ABORT_TAG)
+				 == ABORT_TASK)
 					tag = scb->hscb->tag;
 				ahc_print_path(ahc, scb);
 				printk("SCB %d - Abort%s Completed.\n",
@@ -1832,7 +1832,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 					       CAM_REQ_ABORTED);
 				printerror = 0;
 			} else if (ahc_sent_msg(ahc, AHCMSG_1B,
-						MSG_BUS_DEV_RESET, TRUE)) {
+						TARGET_RESET, TRUE)) {
 				ahc_compile_devinfo(&devinfo,
 						    initiator_role_id,
 						    target,
@@ -1845,7 +1845,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 						    /*verbose_level*/0);
 				printerror = 0;
 			} else if (ahc_sent_msg(ahc, AHCMSG_EXT,
-						MSG_EXT_PPR, FALSE)) {
+						EXTENDED_PPR, FALSE)) {
 				struct ahc_initiator_tinfo *tinfo;
 				struct ahc_tmode_tstate *tstate;
 
@@ -1864,7 +1864,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 				ahc_qinfifo_requeue_tail(ahc, scb);
 				printerror = 0;
 			} else if (ahc_sent_msg(ahc, AHCMSG_EXT,
-						MSG_EXT_WDTR, FALSE)) {
+						EXTENDED_WDTR, FALSE)) {
 				/*
 				 * Negotiation Rejected.  Go-narrow and
 				 * retry command.
@@ -1876,7 +1876,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 				ahc_qinfifo_requeue_tail(ahc, scb);
 				printerror = 0;
 			} else if (ahc_sent_msg(ahc, AHCMSG_EXT,
-						MSG_EXT_SDTR, FALSE)) {
+						EXTENDED_SDTR, FALSE)) {
 				/*
 				 * Negotiation Rejected.  Go-async and
 				 * retry command.
@@ -2878,7 +2878,7 @@ ahc_setup_initiator_msgout(struct ahc_softc *ahc, struct ahc_devinfo *devinfo,
 	}
 
 	if (scb->flags & SCB_DEVICE_RESET) {
-		ahc->msgout_buf[ahc->msgout_index++] = MSG_BUS_DEV_RESET;
+		ahc->msgout_buf[ahc->msgout_index++] = TARGET_RESET;
 		ahc->msgout_len++;
 		ahc_print_path(ahc, scb);
 		printk("Bus Device Reset Message Sent\n");
@@ -2892,9 +2892,9 @@ ahc_setup_initiator_msgout(struct ahc_softc *ahc, struct ahc_devinfo *devinfo,
 		ahc_outb(ahc, SCSISEQ, (ahc_inb(ahc, SCSISEQ) & ~ENSELO));
 	} else if ((scb->flags & SCB_ABORT) != 0) {
 		if ((scb->hscb->control & TAG_ENB) != 0)
-			ahc->msgout_buf[ahc->msgout_index++] = MSG_ABORT_TAG;
+			ahc->msgout_buf[ahc->msgout_index++] = ABORT_TASK;
 		else
-			ahc->msgout_buf[ahc->msgout_index++] = MSG_ABORT;
+			ahc->msgout_buf[ahc->msgout_index++] = ABORT_TASK_SET;
 		ahc->msgout_len++;
 		ahc_print_path(ahc, scb);
 		printk("Abort%s Message Sent\n",
@@ -3104,7 +3104,7 @@ ahc_clear_msg_state(struct ahc_softc *ahc)
 		 */
 		ahc_outb(ahc, CLRSINT1, CLRATNO);
 	}
-	ahc_outb(ahc, MSG_OUT, MSG_NOOP);
+	ahc_outb(ahc, MSG_OUT, NOP);
 	ahc_outb(ahc, SEQ_FLAGS2,
 		 ahc_inb(ahc, SEQ_FLAGS2) & ~TARGET_MSG_PENDING);
 }
@@ -3190,7 +3190,7 @@ ahc_handle_proto_violation(struct ahc_softc *ahc)
 		ahc_outb(ahc, MSG_OUT, HOST_MSG);
 		if (scb == NULL) {
 			ahc_print_devinfo(ahc, &devinfo);
-			ahc->msgout_buf[0] = MSG_ABORT_TASK;
+			ahc->msgout_buf[0] = ABORT_TASK;
 			ahc->msgout_len = 1;
 			ahc->msgout_index = 0;
 			ahc->msg_type = MSG_TYPE_INITIATOR_MSGOUT;
@@ -3518,7 +3518,7 @@ ahc_sent_msg(struct ahc_softc *ahc, ahc_msgtype type, u_int msgval, int full)
 	index = 0;
 
 	while (index < ahc->msgout_len) {
-		if (ahc->msgout_buf[index] == MSG_EXTENDED) {
+		if (ahc->msgout_buf[index] == EXTENDED_MESSAGE) {
 			u_int end_index;
 
 			end_index = index + 1 + ahc->msgout_buf[index + 1];
@@ -3532,8 +3532,8 @@ ahc_sent_msg(struct ahc_softc *ahc, ahc_msgtype type, u_int msgval, int full)
 					found = TRUE;
 			}
 			index = end_index;
-		} else if (ahc->msgout_buf[index] >= MSG_SIMPLE_TASK
-			&& ahc->msgout_buf[index] <= MSG_IGN_WIDE_RESIDUE) {
+		} else if (ahc->msgout_buf[index] >= SIMPLE_QUEUE_TAG
+			&& ahc->msgout_buf[index] <= IGNORE_WIDE_RESIDUE) {
 
 			/* Skip tag type and tag id or residue param*/
 			index += 2;
@@ -3584,37 +3584,37 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 	 * extended message type.
 	 */
 	switch (ahc->msgin_buf[0]) {
-	case MSG_DISCONNECT:
-	case MSG_SAVEDATAPOINTER:
-	case MSG_CMDCOMPLETE:
-	case MSG_RESTOREPOINTERS:
-	case MSG_IGN_WIDE_RESIDUE:
+	case DISCONNECT:
+	case SAVE_POINTERS:
+	case COMMAND_COMPLETE:
+	case RESTORE_POINTERS:
+	case IGNORE_WIDE_RESIDUE:
 		/*
 		 * End our message loop as these are messages
 		 * the sequencer handles on its own.
 		 */
 		done = MSGLOOP_TERMINATED;
 		break;
-	case MSG_MESSAGE_REJECT:
+	case MESSAGE_REJECT:
 		response = ahc_handle_msg_reject(ahc, devinfo);
 		fallthrough;
-	case MSG_NOOP:
+	case NOP:
 		done = MSGLOOP_MSGCOMPLETE;
 		break;
-	case MSG_EXTENDED:
+	case EXTENDED_MESSAGE:
 	{
 		/* Wait for enough of the message to begin validation */
 		if (ahc->msgin_index < 2)
 			break;
 		switch (ahc->msgin_buf[2]) {
-		case MSG_EXT_SDTR:
+		case EXTENDED_SDTR:
 		{
 			const struct ahc_syncrate *syncrate;
 			u_int	 period;
 			u_int	 ppr_options;
 			u_int	 offset;
 			u_int	 saved_offset;
-			
+
 			if (ahc->msgin_buf[1] != MSG_EXT_SDTR_LEN) {
 				reject = TRUE;
 				break;
@@ -3648,7 +3648,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 				       ahc->msgin_buf[3], saved_offset,
 				       period, offset);
 			}
-			ahc_set_syncrate(ahc, devinfo, 
+			ahc_set_syncrate(ahc, devinfo,
 					 syncrate, period,
 					 offset, ppr_options,
 					 AHC_TRANS_ACTIVE|AHC_TRANS_GOAL,
@@ -3659,7 +3659,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 			 * and didn't have to fall down to async
 			 * transfers.
 			 */
-			if (ahc_sent_msg(ahc, AHCMSG_EXT, MSG_EXT_SDTR, TRUE)) {
+			if (ahc_sent_msg(ahc, AHCMSG_EXT, EXTENDED_SDTR, TRUE)) {
 				/* We started it */
 				if (saved_offset != offset) {
 					/* Went too low - force async */
@@ -3686,7 +3686,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 			done = MSGLOOP_MSGCOMPLETE;
 			break;
 		}
-		case MSG_EXT_WDTR:
+		case EXTENDED_WDTR:
 		{
 			u_int bus_width;
 			u_int saved_width;
@@ -3720,7 +3720,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 				       saved_width, bus_width);
 			}
 
-			if (ahc_sent_msg(ahc, AHCMSG_EXT, MSG_EXT_WDTR, TRUE)) {
+			if (ahc_sent_msg(ahc, AHCMSG_EXT, EXTENDED_WDTR, TRUE)) {
 				/*
 				 * Don't send a WDTR back to the
 				 * target, since we asked first.
@@ -3782,7 +3782,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 			done = MSGLOOP_MSGCOMPLETE;
 			break;
 		}
-		case MSG_EXT_PPR:
+		case EXTENDED_PPR:
 		{
 			const struct ahc_syncrate *syncrate;
 			u_int	period;
@@ -3842,7 +3842,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 					    &offset, bus_width,
 					    devinfo->role);
 
-			if (ahc_sent_msg(ahc, AHCMSG_EXT, MSG_EXT_PPR, TRUE)) {
+			if (ahc_sent_msg(ahc, AHCMSG_EXT, EXTENDED_PPR, TRUE)) {
 				/*
 				 * If we are unable to do any of the
 				 * requested options (we went too low),
@@ -3906,7 +3906,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		break;
 	}
 #ifdef AHC_TARGET_MODE
-	case MSG_BUS_DEV_RESET:
+	case TARGET_RESET:
 		ahc_handle_devreset(ahc, devinfo,
 				    CAM_BDR_SENT,
 				    "Bus Device Reset Received",
@@ -3914,9 +3914,9 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		ahc_restart(ahc);
 		done = MSGLOOP_TERMINATED;
 		break;
-	case MSG_ABORT_TAG:
-	case MSG_ABORT:
-	case MSG_CLEAR_QUEUE:
+	case ABORT_TASK:
+	case ABORT_TASK_SET:
+	case CLEAR_QUEUE_TASK_SET:
 	{
 		int tag;
 
@@ -3926,7 +3926,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 			break;
 		}
 		tag = SCB_LIST_NULL;
-		if (ahc->msgin_buf[0] == MSG_ABORT_TAG)
+		if (ahc->msgin_buf[0] == ABORT_TASK)
 			tag = ahc_inb(ahc, INITIATOR_TAG);
 		ahc_abort_scbs(ahc, devinfo->target, devinfo->channel,
 			       devinfo->lun, tag, ROLE_TARGET,
@@ -3950,7 +3950,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		break;
 	}
 #endif
-	case MSG_TERM_IO_PROC:
+	case TERMINATE_IO_PROC:
 	default:
 		reject = TRUE;
 		break;
@@ -3962,7 +3962,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		 */
 		ahc->msgout_index = 0;
 		ahc->msgout_len = 1;
-		ahc->msgout_buf[0] = MSG_MESSAGE_REJECT;
+		ahc->msgout_buf[0] = MESSAGE_REJECT;
 		done = MSGLOOP_MSGCOMPLETE;
 		response = TRUE;
 	}
@@ -4001,7 +4001,7 @@ ahc_handle_msg_reject(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 	/* Might be necessary */
 	last_msg = ahc_inb(ahc, LAST_MSG);
 
-	if (ahc_sent_msg(ahc, AHCMSG_EXT, MSG_EXT_PPR, /*full*/FALSE)) {
+	if (ahc_sent_msg(ahc, AHCMSG_EXT, EXTENDED_PPR, /*full*/FALSE)) {
 		/*
 		 * Target does not support the PPR message.
 		 * Attempt to negotiate SPI-2 style.
@@ -4020,7 +4020,7 @@ ahc_handle_msg_reject(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		ahc_build_transfer_msg(ahc, devinfo);
 		ahc->msgout_index = 0;
 		response = 1;
-	} else if (ahc_sent_msg(ahc, AHCMSG_EXT, MSG_EXT_WDTR, /*full*/FALSE)) {
+	} else if (ahc_sent_msg(ahc, AHCMSG_EXT, EXTENDED_WDTR, /*full*/FALSE)) {
 
 		/* note 8bit xfers */
 		printk("(%s:%c:%d:%d): refuses WIDE negotiation.  Using "
@@ -4045,7 +4045,7 @@ ahc_handle_msg_reject(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 			ahc->msgout_index = 0;
 			response = 1;
 		}
-	} else if (ahc_sent_msg(ahc, AHCMSG_EXT, MSG_EXT_SDTR, /*full*/FALSE)) {
+	} else if (ahc_sent_msg(ahc, AHCMSG_EXT, EXTENDED_SDTR, /*full*/FALSE)) {
 		/* note asynch xfers and clear flag */
 		ahc_set_syncrate(ahc, devinfo, /*syncrate*/NULL, /*period*/0,
 				 /*offset*/0, /*ppr_options*/0,
@@ -4055,13 +4055,13 @@ ahc_handle_msg_reject(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		       "Using asynchronous transfers\n",
 		       ahc_name(ahc), devinfo->channel,
 		       devinfo->target, devinfo->lun);
-	} else if ((scb->hscb->control & MSG_SIMPLE_TASK) != 0) {
+	} else if ((scb->hscb->control & SIMPLE_QUEUE_TAG) != 0) {
 		int tag_type;
 		int mask;
 
-		tag_type = (scb->hscb->control & MSG_SIMPLE_TASK);
+		tag_type = (scb->hscb->control & SIMPLE_QUEUE_TAG);
 
-		if (tag_type == MSG_SIMPLE_TASK) {
+		if (tag_type == SIMPLE_QUEUE_TAG) {
 			printk("(%s:%c:%d:%d): refuses tagged commands.  "
 			       "Performing non-tagged I/O\n", ahc_name(ahc),
 			       devinfo->channel, devinfo->target, devinfo->lun);
@@ -4071,7 +4071,7 @@ ahc_handle_msg_reject(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 			printk("(%s:%c:%d:%d): refuses %s tagged commands.  "
 			       "Performing simple queue tagged I/O only\n",
 			       ahc_name(ahc), devinfo->channel, devinfo->target,
-			       devinfo->lun, tag_type == MSG_ORDERED_TASK
+			       devinfo->lun, tag_type == ORDERED_QUEUE_TAG
 			       ? "ordered" : "head of queue");
 			ahc_set_tags(ahc, scb->io_ctx, devinfo, AHC_QUEUE_BASIC);
 			mask = ~0x03;
@@ -4083,9 +4083,9 @@ ahc_handle_msg_reject(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		 */
 		ahc_outb(ahc, SCB_CONTROL,
 			 ahc_inb(ahc, SCB_CONTROL) & mask);
-	 	scb->hscb->control &= mask;
+		scb->hscb->control &= mask;
 		ahc_set_transaction_tag(scb, /*enabled*/FALSE,
-					/*type*/MSG_SIMPLE_TASK);
+					/*type*/SIMPLE_QUEUE_TAG);
 		ahc_outb(ahc, MSG_OUT, MSG_IDENTIFYFLAG);
 		ahc_assert_atn(ahc);
 
@@ -4322,7 +4322,7 @@ ahc_handle_devreset(struct ahc_softc *ahc, struct ahc_devinfo *devinfo,
 				continue;
 
 			ahc_queue_lstate_event(ahc, lstate, devinfo->our_scsiid,
-					       MSG_BUS_DEV_RESET, /*arg*/0);
+					       TARGET_RESET, /*arg*/0);
 			ahc_send_lstate_events(ahc, lstate);
 		}
 	}
@@ -5167,7 +5167,7 @@ ahc_chip_init(struct ahc_softc *ahc)
 	ahc_outb(ahc, DISCONNECTED_SCBH, SCB_LIST_NULL);
 
 	/* Message out buffer starts empty */
-	ahc_outb(ahc, MSG_OUT, MSG_NOOP);
+	ahc_outb(ahc, MSG_OUT, NOP);
 
 	/*
 	 * Setup the allowed SCSI Sequences based on operational mode.
@@ -6689,7 +6689,7 @@ ahc_queue_lstate_event(struct ahc_softc *ahc, struct ahc_tmode_lstate *lstate,
 			- (lstate->event_r_idx - lstate->event_w_idx);
 
 	if (event_type == EVENT_TYPE_BUS_RESET
-	 || event_type == MSG_BUS_DEV_RESET) {
+	 || event_type == TARGET_RESET) {
 		/*
 		 * Any earlier events are irrelevant, so reset our buffer.
 		 * This has the effect of allowing us to deal with reset
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 2c7d9d38a577..d33f5a00bf0b 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -1,3 +1,4 @@
+
 /*
  * Adaptec AIC7xxx device driver for Linux.
  *
@@ -1480,10 +1481,10 @@ ahc_linux_run_command(struct ahc_softc *ahc, struct ahc_linux_device *dev,
 	if ((dev->flags & (AHC_DEV_Q_TAGGED|AHC_DEV_Q_BASIC)) != 0) {
 		if (dev->commands_since_idle_or_otag == AHC_OTAG_THRESH
 				&& (dev->flags & AHC_DEV_Q_TAGGED) != 0) {
-			hscb->control |= MSG_ORDERED_TASK;
+			hscb->control |= ORDERED_QUEUE_TAG;
 			dev->commands_since_idle_or_otag = 0;
 		} else {
-			hscb->control |= MSG_SIMPLE_TASK;
+			hscb->control |= SIMPLE_QUEUE_TAG;
 		}
 	}
 
diff --git a/drivers/scsi/aic7xxx/scsi_message.h b/drivers/scsi/aic7xxx/scsi_message.h
index 75811e245ec7..a7515c3039ed 100644
--- a/drivers/scsi/aic7xxx/scsi_message.h
+++ b/drivers/scsi/aic7xxx/scsi_message.h
@@ -3,44 +3,6 @@
  * $FreeBSD: src/sys/cam/scsi/scsi_message.h,v 1.2 2000/05/01 20:21:29 peter Exp $
  */
 
-/* Messages (1 byte) */		     /* I/T (M)andatory or (O)ptional */
-#define MSG_CMDCOMPLETE		0x00 /* M/M */
-#define MSG_TASK_COMPLETE	0x00 /* M/M */ /* SPI3 Terminology */
-#define MSG_EXTENDED		0x01 /* O/O */
-#define MSG_SAVEDATAPOINTER	0x02 /* O/O */
-#define MSG_RESTOREPOINTERS	0x03 /* O/O */
-#define MSG_DISCONNECT		0x04 /* O/O */
-#define MSG_INITIATOR_DET_ERR	0x05 /* M/M */
-#define MSG_ABORT		0x06 /* O/M */
-#define MSG_ABORT_TASK_SET	0x06 /* O/M */ /* SPI3 Terminology */
-#define MSG_MESSAGE_REJECT	0x07 /* M/M */
-#define MSG_NOOP		0x08 /* M/M */
-#define MSG_PARITY_ERROR	0x09 /* M/M */
-#define MSG_LINK_CMD_COMPLETE	0x0a /* O/O */
-#define MSG_LINK_CMD_COMPLETEF	0x0b /* O/O */
-#define MSG_BUS_DEV_RESET	0x0c /* O/M */
-#define MSG_TARGET_RESET	0x0c /* O/M */ /* SPI3 Terminology */
-#define MSG_ABORT_TAG		0x0d /* O/O */
-#define MSG_ABORT_TASK		0x0d /* O/O */ /* SPI3 Terminology */
-#define MSG_CLEAR_QUEUE		0x0e /* O/O */
-#define MSG_CLEAR_TASK_SET	0x0e /* O/O */ /* SPI3 Terminology */
-#define MSG_INIT_RECOVERY	0x0f /* O/O */ /* Deprecated in SPI3 */
-#define MSG_REL_RECOVERY	0x10 /* O/O */ /* Deprecated in SPI3 */
-#define MSG_TERM_IO_PROC	0x11 /* O/O */ /* Deprecated in SPI3 */
-#define MSG_CLEAR_ACA		0x16 /* O/O */ /* SPI3 */
-#define MSG_LOGICAL_UNIT_RESET	0x17 /* O/O */ /* SPI3 */
-#define MSG_QAS_REQUEST		0x55 /* O/O */ /* SPI3 */
-
-/* Messages (2 byte) */
-#define MSG_SIMPLE_Q_TAG	0x20 /* O/O */
-#define MSG_SIMPLE_TASK		0x20 /* O/O */ /* SPI3 Terminology */
-#define MSG_HEAD_OF_Q_TAG	0x21 /* O/O */
-#define MSG_HEAD_OF_QUEUE_TASK	0x21 /* O/O */ /* SPI3 Terminology */
-#define MSG_ORDERED_Q_TAG	0x22 /* O/O */
-#define MSG_ORDERED_TASK	0x22 /* O/O */ /* SPI3 Terminology */
-#define MSG_IGN_WIDE_RESIDUE	0x23 /* O/O */
-#define MSG_ACA_TASK		0x24 /* 0/0 */ /* SPI3 */
-
 /* Identify message */		     /* M/M */	
 #define MSG_IDENTIFYFLAG	0x80 
 #define MSG_IDENTIFY_DISCFLAG	0x40 
@@ -49,16 +11,13 @@
 #define MSG_IDENTIFY_LUNMASK	0x3F 
 
 /* Extended messages (opcode and length) */
-#define MSG_EXT_SDTR		0x01
 #define MSG_EXT_SDTR_LEN	0x03
 
-#define MSG_EXT_WDTR		0x03
 #define MSG_EXT_WDTR_LEN	0x02
 #define MSG_EXT_WDTR_BUS_8_BIT	0x00
 #define MSG_EXT_WDTR_BUS_16_BIT	0x01
 #define MSG_EXT_WDTR_BUS_32_BIT	0x02 /* Deprecated in SPI3 */
 
-#define MSG_EXT_PPR		0x04 /* SPI3 */
 #define MSG_EXT_PPR_LEN		0x06
 #define	MSG_EXT_PPR_PCOMP_EN	0x80
 #define	MSG_EXT_PPR_RTI		0x40
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 5339baadc082..75af52584307 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -116,6 +116,7 @@ static inline int scsi_is_wlun(u64 lun)
 #define CLEAR_TASK_SET      0x0e
 #define INITIATE_RECOVERY   0x0f            /* SCSI-II only */
 #define RELEASE_RECOVERY    0x10            /* SCSI-II only */
+#define TERMINATE_IO_PROC   0x11            /* SCSI-II only */
 #define CLEAR_ACA           0x16
 #define LOGICAL_UNIT_RESET  0x17
 #define SIMPLE_QUEUE_TAG    0x20
-- 
2.16.4

