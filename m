Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3C2CEBA6
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgLDKDO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:03:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:51206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgLDKDN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:03:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5C87AD2B;
        Fri,  4 Dec 2020 10:01:47 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/37] aic7xxx,aic79xx: Whitespace cleanup
Date:   Fri,  4 Dec 2020 11:01:09 +0100
Message-Id: <20201204100140.140863-7-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201204100140.140863-1-hare@suse.de>
References: <20201204100140.140863-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aic7xxx/aic79xx.h         |  36 ++++-----
 drivers/scsi/aic7xxx/aic79xx_core.c    | 111 ++++++++++++++--------------
 drivers/scsi/aic7xxx/aic79xx_osm.h     |  14 ++--
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |   6 +-
 drivers/scsi/aic7xxx/aic79xx_proc.c    |  13 ++--
 drivers/scsi/aic7xxx/aic7xxx_93cx6.c   |   4 +-
 drivers/scsi/aic7xxx/aic7xxx_core.c    | 131 ++++++++++++++++-----------------
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |  71 +++++++++---------
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |  16 ++--
 drivers/scsi/aic7xxx/aic7xxx_proc.c    |  15 ++--
 10 files changed, 208 insertions(+), 209 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx.h b/drivers/scsi/aic7xxx/aic79xx.h
index 9a515551641c..419e3e3f9679 100644
--- a/drivers/scsi/aic7xxx/aic79xx.h
+++ b/drivers/scsi/aic7xxx/aic79xx.h
@@ -211,7 +211,7 @@ typedef enum {
  */
 typedef enum {
 	AHD_FENONE		= 0x00000,
-	AHD_WIDE  		= 0x00001,/* Wide Channel */
+	AHD_WIDE		= 0x00001,/* Wide Channel */
 	AHD_AIC79XXB_SLOWCRC    = 0x00002,/* SLOWCRC bit should be set */
 	AHD_MULTI_FUNC		= 0x00100,/* Multi-Function/Channel Device */
 	AHD_TARGETMODE		= 0x01000,/* Has tested target mode support */
@@ -433,7 +433,7 @@ union initiator_data {
  * Target mode version of the shared data SCB segment.
  */
 struct target_data {
-	uint32_t spare[2];	
+	uint32_t spare[2];
 	uint8_t  scsi_status;		/* SCSI status to give to initiator */
 	uint8_t  target_phases;		/* Bitmap of phases to execute */
 	uint8_t  data_phase;		/* Data-In or Data-Out */
@@ -608,9 +608,9 @@ struct scb {
 	struct ahd_softc	 *ahd_softc;
 	scb_flag		  flags;
 	struct scb_platform_data *platform_data;
-	struct map_node	 	 *hscb_map;
-	struct map_node	 	 *sg_map;
-	struct map_node	 	 *sense_map;
+	struct map_node		 *hscb_map;
+	struct map_node		 *sg_map;
+	struct map_node		 *sense_map;
 	void			 *sg_list;
 	uint8_t			 *sense_data;
 	dma_addr_t		  sg_list_busaddr;
@@ -674,7 +674,7 @@ struct scb_data {
 struct target_cmd {
 	uint8_t scsiid;		/* Our ID and the initiator's ID */
 	uint8_t identify;	/* Identify message */
-	uint8_t bytes[22];	/* 
+	uint8_t bytes[22];	/*
 				 * Bytes contains any additional message
 				 * bytes terminated by 0xFF.  The remainder
 				 * is the cdb to execute.
@@ -712,7 +712,7 @@ struct ahd_tmode_event {
  * structure here so we can store arrays of them, etc. in OS neutral
  * data structures.
  */
-#ifdef AHD_TARGET_MODE 
+#ifdef AHD_TARGET_MODE
 struct ahd_tmode_lstate {
 	struct cam_path *path;
 	struct ccb_hdr_slist accept_tios;
@@ -807,11 +807,11 @@ struct ahd_tmode_tstate {
 /***************************** Lookup Tables **********************************/
 /*
  * Phase -> name and message out response
- * to parity errors in each phase table. 
+ * to parity errors in each phase table.
  */
 struct ahd_phase_table_entry {
-        uint8_t phase;
-        uint8_t mesg_out; /* Message response to parity errors */
+	uint8_t phase;
+	uint8_t mesg_out; /* Message response to parity errors */
 	const char *phasemsg;
 };
 
@@ -844,7 +844,7 @@ struct seeprom_config {
 #define		    CFBS_ENABLED	0x04
 #define		    CFBS_DISABLED_SCAN	0x08
 #define		CFENABLEDV	0x0010	/* Perform Domain Validation */
-#define		CFCTRL_A	0x0020	/* BIOS displays Ctrl-A message */	
+#define		CFCTRL_A	0x0020	/* BIOS displays Ctrl-A message */
 #define		CFSPARITY	0x0040	/* SCSI parity */
 #define		CFEXTEND	0x0080	/* extended translation enabled */
 #define		CFBOOTCD	0x0100  /* Support Bootable CD-ROM */
@@ -858,7 +858,7 @@ struct seeprom_config {
 /*
  * Host Adapter Control Bits
  */
-	uint16_t adapter_control;	/* word 17 */	
+	uint16_t adapter_control;	/* word 17 */
 #define		CFAUTOTERM	0x0001	/* Perform Auto termination */
 #define		CFSTERM		0x0002	/* SCSI low byte termination */
 #define		CFWSTERM	0x0004	/* SCSI high byte termination */
@@ -867,7 +867,7 @@ struct seeprom_config {
 #define		CFSEHIGHTERM	0x0020	/* Ultra2 secondary high term */
 #define		CFSTPWLEVEL	0x0040	/* Termination level control */
 #define		CFBIOSAUTOTERM	0x0080	/* Perform Auto termination */
-#define		CFTERM_MENU	0x0100	/* BIOS displays termination menu */	
+#define		CFTERM_MENU	0x0100	/* BIOS displays termination menu */
 #define		CFCLUSTERENB	0x8000	/* Cluster Enable */
 
 /*
@@ -881,7 +881,7 @@ struct seeprom_config {
 /*
  * Maximum targets
  */
-	uint16_t max_targets;		/* word 19 */	
+	uint16_t max_targets;		/* word 19 */
 #define		CFMAXTARG	0x00ff	/* maximum targets */
 #define		CFBOOTLUN	0x0f00	/* Lun to boot from */
 #define		CFBOOTID	0xf000	/* Target to boot from */
@@ -941,7 +941,7 @@ struct vpd_config {
 #define		FLX_ROMSTAT_EE_2MBx8	0x2
 #define		FLX_ROMSTAT_EE_4MBx8	0x3
 #define		FLX_ROMSTAT_EE_16MBx8	0x4
-#define 		CURSENSE_ENB	0x1
+#define			CURSENSE_ENB	0x1
 #define	FLXADDR_FLEXSTAT		0x2
 #define		FLX_FSTAT_BUSY		0x1
 #define FLXADDR_CURRENT_STAT		0x4
@@ -1051,8 +1051,8 @@ struct ahd_completion
 };
 
 struct ahd_softc {
-	bus_space_tag_t           tags[2];
-	bus_space_handle_t        bshs[2];
+	bus_space_tag_t		  tags[2];
+	bus_space_handle_t	  bshs[2];
 	struct scb_data		  scb_data;
 
 	struct hardware_scb	 *next_queued_hscb;
@@ -1243,7 +1243,7 @@ struct ahd_softc {
 	u_int			  int_coalescing_threshold;
 	u_int			  int_coalescing_stop_threshold;
 
-	uint16_t	 	  user_discenable;/* Disconnection allowed  */
+	uint16_t		  user_discenable;/* Disconnection allowed  */
 	uint16_t		  user_tagenable;/* Tagged Queuing allowed */
 };
 
diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 98b02e7d38bb..082047454902 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -57,7 +57,7 @@ static const char *const ahd_chip_names[] =
  * Hardware error codes.
  */
 struct ahd_hard_error_entry {
-        uint8_t errno;
+	uint8_t errno;
 	const char *errmesg;
 };
 
@@ -113,7 +113,7 @@ static void		ahd_free_tstate(struct ahd_softc *ahd,
 					u_int scsi_id, char channel, int force);
 #endif
 static void		ahd_devlimited_syncrate(struct ahd_softc *ahd,
-					        struct ahd_initiator_tinfo *,
+						struct ahd_initiator_tinfo *,
 						u_int *period,
 						u_int *ppr_options,
 						role_t role);
@@ -170,7 +170,7 @@ static void		ahd_setup_target_msgin(struct ahd_softc *ahd,
 static u_int		ahd_sglist_size(struct ahd_softc *ahd);
 static u_int		ahd_sglist_allocsize(struct ahd_softc *ahd);
 static bus_dmamap_callback_t
-			ahd_dmamap_cb; 
+			ahd_dmamap_cb;
 static void		ahd_initialize_hscbs(struct ahd_softc *ahd);
 static int		ahd_init_scbdata(struct ahd_softc *ahd);
 static void		ahd_fini_scbdata(struct ahd_softc *ahd);
@@ -268,7 +268,7 @@ static void		ahd_run_tqinfifo(struct ahd_softc *ahd, int paused);
 static void		ahd_handle_hwerrint(struct ahd_softc *ahd);
 static void		ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat);
 static void		ahd_handle_scsiint(struct ahd_softc *ahd,
-				           u_int intstat);
+					   u_int intstat);
 
 /************************ Sequencer Execution Control *************************/
 void
@@ -1203,7 +1203,7 @@ ahd_flush_qoutfifo(struct ahd_softc *ahd)
 	while ((ahd_inb(ahd, LQISTAT2) & LQIGSAVAIL) != 0) {
 		u_int fifo_mode;
 		u_int i;
-		
+
 		scbid = ahd_inw(ahd, GSFIFO);
 		scb = ahd_lookup_scb(ahd, scbid);
 		if (scb == NULL) {
@@ -1326,7 +1326,7 @@ ahd_flush_qoutfifo(struct ahd_softc *ahd)
 	while (!SCBID_IS_NULL(scbid)) {
 		uint8_t *hscb_ptr;
 		u_int	 i;
-		
+
 		ahd_set_scbptr(ahd, scbid);
 		next_scbid = ahd_inw_scbram(ahd, SCB_NEXT_COMPLETE);
 		scb = ahd_lookup_scb(ahd, scbid);
@@ -1991,7 +1991,7 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 	{
 		struct	scb *scb;
 		u_int	scb_index;
-		
+
 #ifdef AHD_DEBUG
 		if ((ahd_debug & AHD_SHOW_RECOVERY) != 0) {
 			printk("%s: CFG4OVERRUN mode = %x\n", ahd_name(ahd),
@@ -2094,8 +2094,7 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 					ahd->msg_type =
 					    MSG_TYPE_TARGET_MSGOUT;
 					ahd->msgin_index = 0;
-				}
-				else 
+				} else
 					ahd_setup_target_msgin(ahd,
 							       &devinfo,
 							       scb);
@@ -2338,9 +2337,9 @@ ahd_handle_seqint(struct ahd_softc *ahd, u_int intstat)
 				;
 			ahd_outb(ahd, SCB_TASK_MANAGEMENT, 0);
 			ahd_search_qinfifo(ahd, SCB_GET_TARGET(ahd, scb),
-					   SCB_GET_CHANNEL(ahd, scb),  
-					   SCB_GET_LUN(scb), SCB_GET_TAG(scb), 
-					   ROLE_INITIATOR, /*status*/0,   
+					   SCB_GET_CHANNEL(ahd, scb),
+					   SCB_GET_LUN(scb), SCB_GET_TAG(scb),
+					   ROLE_INITIATOR, /*status*/0,
 					   SEARCH_REMOVE);
 		}
 		break;
@@ -2694,14 +2693,14 @@ ahd_handle_transmission_error(struct ahd_softc *ahd)
 	perrdiag = ahd_inb(ahd, PERRDIAG);
 	msg_out = MSG_INITIATOR_DET_ERR;
 	ahd_outb(ahd, CLRSINT1, CLRSCSIPERR);
-	
+
 	/*
 	 * Try to find the SCB associated with this error.
 	 */
 	silent = FALSE;
 	if (lqistat1 == 0
 	 || (lqistat1 & LQICRCI_NLQ) != 0) {
-	 	if ((lqistat1 & (LQICRCI_NLQ|LQIOVERI_NLQ)) != 0)
+		if ((lqistat1 & (LQICRCI_NLQ|LQIOVERI_NLQ)) != 0)
 			ahd_set_active_fifo(ahd);
 		scbid = ahd_get_scbptr(ahd);
 		scb = ahd_lookup_scb(ahd, scbid);
@@ -2818,7 +2817,7 @@ ahd_handle_transmission_error(struct ahd_softc *ahd)
 				    ahd_lookup_phase_entry(curphase)->phasemsg);
 			ahd_inb(ahd, SCSIDAT);
 		}
-	
+
 		if (curphase == P_MESGIN)
 			msg_out = MSG_PARITY_ERROR;
 	}
@@ -3446,7 +3445,6 @@ ahd_clear_critical_section(struct ahd_softc *ahd)
 
 		cs = ahd->critical_sections;
 		for (i = 0; i < ahd->num_critical_sections; i++, cs++) {
-			
 			if (cs->begin < seqaddr && cs->end >= seqaddr)
 				break;
 		}
@@ -3472,8 +3470,8 @@ ahd_clear_critical_section(struct ahd_softc *ahd)
 		if (stepping == FALSE) {
 
 			first_instr = seqaddr;
-  			ahd_set_modes(ahd, AHD_MODE_CFG, AHD_MODE_CFG);
-  			simode0 = ahd_inb(ahd, SIMODE0);
+			ahd_set_modes(ahd, AHD_MODE_CFG, AHD_MODE_CFG);
+			simode0 = ahd_inb(ahd, SIMODE0);
 			simode3 = ahd_inb(ahd, SIMODE3);
 			lqimode0 = ahd_inb(ahd, LQIMODE0);
 			lqimode1 = ahd_inb(ahd, LQIMODE1);
@@ -3515,7 +3513,7 @@ ahd_clear_critical_section(struct ahd_softc *ahd)
 		ahd_outb(ahd, LQOMODE1, lqomode1);
 		ahd_set_modes(ahd, AHD_MODE_SCSI, AHD_MODE_SCSI);
 		ahd_outb(ahd, SEQCTL0, ahd_inb(ahd, SEQCTL0) & ~STEP);
-  		ahd_outb(ahd, SIMODE1, simode1);
+		ahd_outb(ahd, SIMODE1, simode1);
 		/*
 		 * SCSIINT seems to glitch occasionally when
 		 * the interrupt masks are restored.  Clear SCSIINT
@@ -3553,7 +3551,7 @@ ahd_clear_intstat(struct ahd_softc *ahd)
 	ahd_outb(ahd, CLRSINT1, CLRSELTIMEO|CLRATNO|CLRSCSIRSTI
 				|CLRBUSFREE|CLRSCSIPERR|CLRREQINIT);
 	ahd_outb(ahd, CLRSINT0, CLRSELDO|CLRSELDI|CLRSELINGO
-			        |CLRIOERR|CLROVERRUN);
+				|CLRIOERR|CLROVERRUN);
 	ahd_outb(ahd, CLRINT, CLRSCSIINT);
 }
 
@@ -3689,7 +3687,7 @@ ahd_devlimited_syncrate(struct ahd_softc *ahd,
 	 */
 	if (role == ROLE_TARGET)
 		transinfo = &tinfo->user;
-	else 
+	else
 		transinfo = &tinfo->goal;
 	*ppr_options &= (transinfo->ppr_options|MSG_EXT_PPR_PCOMP_EN);
 	if (transinfo->width == MSG_EXT_WDTR_BUS_8_BIT) {
@@ -3720,7 +3718,7 @@ ahd_find_syncrate(struct ahd_softc *ahd, u_int *period,
 	if ((*ppr_options & MSG_EXT_PPR_DT_REQ) != 0
 	 && *period > AHD_SYNCRATE_MIN_DT)
 		*ppr_options &= ~MSG_EXT_PPR_DT_REQ;
-		
+
 	if (*period > AHD_SYNCRATE_MIN)
 		*period = 0;
 
@@ -4083,7 +4081,7 @@ ahd_update_neg_table(struct ahd_softc *ahd, struct ahd_devinfo *devinfo,
 	ahd_outb(ahd, NEGOADDR, devinfo->target);
 	period = tinfo->period;
 	offset = tinfo->offset;
-	memcpy(iocell_opts, ahd->iocell_opts, sizeof(ahd->iocell_opts)); 
+	memcpy(iocell_opts, ahd->iocell_opts, sizeof(ahd->iocell_opts));
 	ppr_opts = tinfo->ppr_options & (MSG_EXT_PPR_QAS_REQ|MSG_EXT_PPR_DT_REQ
 					|MSG_EXT_PPR_IU_REQ|MSG_EXT_PPR_RTI);
 	con_opts = 0;
@@ -4849,7 +4847,7 @@ ahd_handle_message_phase(struct ahd_softc *ahd)
 #endif
 				ahd_assert_atn(ahd);
 			}
-		} else 
+		} else
 			ahd->msgin_index++;
 
 		if (message_done == MSGLOOP_TERMINATED) {
@@ -4952,7 +4950,7 @@ ahd_handle_message_phase(struct ahd_softc *ahd)
 			 */
 			return;
 		}
-		
+
 		ahd->msgin_index++;
 
 		/*
@@ -5120,7 +5118,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			u_int	 ppr_options;
 			u_int	 offset;
 			u_int	 saved_offset;
-			
+
 			if (ahd->msgin_buf[1] != MSG_EXT_SDTR_LEN) {
 				reject = TRUE;
 				break;
@@ -5607,7 +5605,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		 */
 		ahd_outb(ahd, SCB_CONTROL,
 			 ahd_inb_scbram(ahd, SCB_CONTROL) & mask);
-	 	scb->hscb->control &= mask;
+		scb->hscb->control &= mask;
 		ahd_set_transaction_tag(scb, /*enabled*/FALSE,
 					/*type*/MSG_SIMPLE_TASK);
 		ahd_outb(ahd, MSG_OUT, MSG_IDENTIFYFLAG);
@@ -5816,7 +5814,7 @@ ahd_reinitialize_dataptrs(struct ahd_softc *ahd)
 
 	AHD_ASSERT_MODES(ahd, AHD_MODE_DFF0_MSK|AHD_MODE_DFF1_MSK,
 			 AHD_MODE_DFF0_MSK|AHD_MODE_DFF1_MSK);
-			 
+
 	scb_index = ahd_get_scbptr(ahd);
 	scb = ahd_lookup_scb(ahd, scb_index);
 
@@ -5938,7 +5936,7 @@ ahd_handle_devreset(struct ahd_softc *ahd, struct ahd_devinfo *devinfo,
 	ahd_set_syncrate(ahd, devinfo, /*period*/0, /*offset*/0,
 			 /*ppr_options*/0, AHD_TRANS_CUR,
 			 /*paused*/TRUE);
-	
+
 	if (status != CAM_SEL_TIMEOUT)
 		ahd_send_async(ahd, devinfo->channel, devinfo->target,
 			       CAM_LUN_WILDCARD, AC_SENT_BDR);
@@ -5954,11 +5952,11 @@ ahd_setup_target_msgin(struct ahd_softc *ahd, struct ahd_devinfo *devinfo,
 		       struct scb *scb)
 {
 
-	/*              
+	/*
 	 * To facilitate adding multiple messages together,
 	 * each routine should increment the index and len
 	 * variables instead of setting them explicitly.
-	 */             
+	 */
 	ahd->msgout_index = 0;
 	ahd->msgout_len = 0;
 
@@ -6091,7 +6089,7 @@ ahd_softc_init(struct ahd_softc *ahd)
 {
 
 	ahd->unpause = 0;
-	ahd->pause = PAUSE; 
+	ahd->pause = PAUSE;
 	return (0);
 }
 
@@ -6203,7 +6201,7 @@ ahd_reset(struct ahd_softc *ahd, int reinit)
 	u_int	 sxfrctl1;
 	int	 wait;
 	uint32_t cmd;
-	
+
 	/*
 	 * Preserve the value of the SXFRCTL1 register for all channels.
 	 * It contains settings that affect termination and we don't want
@@ -6443,7 +6441,7 @@ ahd_init_scbdata(struct ahd_softc *ahd)
 	/*
 	 * Note that we were successful
 	 */
-	return (0); 
+	return (0);
 
 error_exit:
 
@@ -6961,7 +6959,7 @@ ahd_controller_info(struct ahd_softc *ahd, char *buf)
 static const char *channel_strings[] = {
 	"Primary Low",
 	"Primary High",
-	"Secondary Low", 
+	"Secondary Low",
 	"Secondary High"
 };
 
@@ -7233,7 +7231,7 @@ ahd_chip_init(struct ahd_softc *ahd)
 	} else {
 		sxfrctl1 |= ahd->seltime;
 	}
-		
+
 	ahd_outb(ahd, SXFRCTL0, DFON);
 	ahd_outb(ahd, SXFRCTL1, sxfrctl1|ahd->seltime|ENSTIMER|ACTNEGEN);
 	ahd_outb(ahd, SIMODE1, ENSELTIMO|ENSCSIRST|ENSCSIPERR);
@@ -7489,7 +7487,7 @@ ahd_chip_init(struct ahd_softc *ahd)
 	ahd_outb(ahd, CMDSIZE_TABLE + 5, 11);
 	ahd_outb(ahd, CMDSIZE_TABLE + 6, 0);
 	ahd_outb(ahd, CMDSIZE_TABLE + 7, 0);
-		
+
 	/* Tell the sequencer of our initial queue positions */
 	ahd_set_modes(ahd, AHD_MODE_CCHAN, AHD_MODE_CCHAN);
 	ahd_outb(ahd, QOFF_CTLSTA, SCB_QSIZE_512);
@@ -7886,7 +7884,7 @@ ahd_resume(struct ahd_softc *ahd)
 {
 
 	ahd_reset(ahd, /*reinit*/TRUE);
-	ahd_intr_enable(ahd, TRUE); 
+	ahd_intr_enable(ahd, TRUE);
 	ahd_restart(ahd);
 }
 #endif
@@ -7928,7 +7926,7 @@ ahd_find_busy_tcl(struct ahd_softc *ahd, u_int tcl)
 	u_int scbid;
 	u_int scb_offset;
 	u_int saved_scbptr;
-		
+
 	scb_offset = ahd_index_busy_tcl(ahd, &saved_scbptr, tcl);
 	scbid = ahd_inw_scbram(ahd, scb_offset);
 	ahd_set_scbptr(ahd, saved_scbptr);
@@ -7940,7 +7938,7 @@ ahd_busy_tcl(struct ahd_softc *ahd, u_int tcl, u_int scbid)
 {
 	u_int scb_offset;
 	u_int saved_scbptr;
-		
+
 	scb_offset = ahd_index_busy_tcl(ahd, &saved_scbptr, tcl);
 	ahd_outw(ahd, scb_offset, scbid);
 	ahd_set_scbptr(ahd, saved_scbptr);
@@ -7993,7 +7991,7 @@ ahd_freeze_devq(struct ahd_softc *ahd, struct scb *scb)
 	target = SCB_GET_TARGET(ahd, scb);
 	lun = SCB_GET_LUN(scb);
 	channel = SCB_GET_CHANNEL(ahd, scb);
-	
+
 	ahd_search_qinfifo(ahd, target, channel, lun,
 			   /*tag*/SCB_LIST_NULL, ROLE_UNKNOWN,
 			   CAM_REQUEUE_REQ, SEARCH_COMPLETE);
@@ -8034,7 +8032,7 @@ ahd_qinfifo_requeue(struct ahd_softc *ahd, struct scb *prev_scb,
 		ahd_outl(ahd, NEXT_QUEUED_SCB_ADDR, busaddr);
 	} else {
 		prev_scb->hscb->next_hscb_busaddr = scb->hscb->hscb_busaddr;
-		ahd_sync_scb(ahd, prev_scb, 
+		ahd_sync_scb(ahd, prev_scb,
 			     BUS_DMASYNC_PREREAD|BUS_DMASYNC_PREWRITE);
 	}
 	ahd->qinfifo[AHD_QIN_WRAP(ahd->qinfifonext)] = SCB_GET_TAG(scb);
@@ -8334,7 +8332,7 @@ ahd_search_qinfifo(struct ahd_softc *ahd, int target, char channel,
 static int
 ahd_search_scb_list(struct ahd_softc *ahd, int target, char channel,
 		    int lun, u_int tag, role_t role, uint32_t status,
-		    ahd_search_action action, u_int *list_head, 
+		    ahd_search_action action, u_int *list_head,
 		    u_int *list_tail, u_int tid)
 {
 	struct	scb *scb;
@@ -8792,7 +8790,7 @@ ahd_stat_timer(struct timer_list *t)
 	struct	ahd_softc *ahd = from_timer(ahd, t, stat_timer);
 	u_long	s;
 	int	enint_coal;
-	
+
 	ahd_lock(ahd, &s);
 
 	enint_coal = ahd->hs_mailbox & ENINT_COALESCE;
@@ -8837,7 +8835,7 @@ ahd_handle_scsi_status(struct ahd_softc *ahd, struct scb *scb)
 	 * operations are on data structures that the sequencer
 	 * is not touching once the queue is frozen.
 	 */
-	hscb = scb->hscb; 
+	hscb = scb->hscb;
 
 	if (ahd_is_paused(ahd)) {
 		paused = 1;
@@ -9110,7 +9108,7 @@ ahd_calc_residual(struct ahd_softc *ahd, struct scb *scb)
 
 		/*
 		 * Remainder of the SG where the transfer
-		 * stopped.  
+		 * stopped.
 		 */
 		resid = ahd_le32toh(spkt->residual_datacnt) & AHD_SG_LEN_MASK;
 		sg = ahd_sg_bus_to_virt(ahd, scb, resid_sgptr & SG_PTR_MASK);
@@ -9293,7 +9291,7 @@ ahd_loadseq(struct ahd_softc *ahd)
 
 	/*
 	 * Setup downloadable constant table.
-	 * 
+	 *
 	 * The computation for the S/G prefetch variables is
 	 * a bit complicated.  We would like to always fetch
 	 * in terms of cachelined sized increments.  However,
@@ -9382,7 +9380,7 @@ ahd_loadseq(struct ahd_softc *ahd)
 				if (begin_set[cs_count] == TRUE
 				 && end_set[cs_count] == FALSE) {
 					cs_table[cs_count].end = downloaded;
-				 	end_set[cs_count] = TRUE;
+					end_set[cs_count] = TRUE;
 					cs_count++;
 				}
 				continue;
@@ -9617,7 +9615,7 @@ ahd_print_register(const ahd_reg_parse_entry_t *table, u_int num_entries,
 					  printed_mask == 0 ? ":(" : "|",
 					  table[entry].name);
 			printed_mask |= table[entry].mask;
-			
+
 			break;
 		}
 		if (entry >= num_entries)
@@ -9654,7 +9652,7 @@ ahd_dump_card_state(struct ahd_softc *ahd)
 	ahd_set_modes(ahd, AHD_MODE_SCSI, AHD_MODE_SCSI);
 	printk(">>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<\n"
 	       "%s: Dumping Card State at program address 0x%x Mode 0x%x\n",
-	       ahd_name(ahd), 
+	       ahd_name(ahd),
 	       ahd_inw(ahd, CURADDR),
 	       ahd_build_mode_state(ahd, ahd->saved_src_mode,
 				    ahd->saved_dst_mode));
@@ -9770,7 +9768,6 @@ ahd_dump_card_state(struct ahd_softc *ahd)
 	}
 	printk("\n");
 
-	
 	printk("Sequencer DMA-Up and Complete list: ");
 	scb_index = ahd_inw(ahd, COMPLETE_DMA_SCB_HEAD);
 	i = 0;
@@ -9948,7 +9945,7 @@ ahd_read_seeprom(struct ahd_softc *ahd, uint16_t *buf,
 
 		ahd_outb(ahd, SEEADR, cur_addr);
 		ahd_outb(ahd, SEECTL, SEEOP_READ | SEESTART);
-		
+
 		error = ahd_wait_seeprom(ahd);
 		if (error)
 			break;
@@ -10003,7 +10000,7 @@ ahd_write_seeprom(struct ahd_softc *ahd, uint16_t *buf,
 		ahd_outw(ahd, SEEDAT, *buf++);
 		ahd_outb(ahd, SEEADR, cur_addr);
 		ahd_outb(ahd, SEECTL, SEEOP_WRITE | SEESTART);
-		
+
 		retval = ahd_wait_seeprom(ahd);
 		if (retval)
 			break;
@@ -10108,7 +10105,7 @@ ahd_acquire_seeprom(struct ahd_softc *ahd)
 
 	error = ahd_read_flexport(ahd, FLXADDR_ROMSTAT_CURSENSECTL, &seetype);
 	if (error != 0
-         || ((seetype & FLX_ROMSTAT_SEECFG) == FLX_ROMSTAT_SEE_NONE))
+	    || ((seetype & FLX_ROMSTAT_SEECFG) == FLX_ROMSTAT_SEE_NONE))
 		return (0);
 	return (1);
 #endif
@@ -10250,7 +10247,7 @@ ahd_handle_en_lun(struct ahd_softc *ahd, struct cam_sim *sim, union ccb *ccb)
 		our_id = ahd->our_id;
 		if (ccb->ccb_h.target_id != our_id) {
 			if ((ahd->features & AHD_MULTI_TID) != 0
-		   	 && (ahd->flags & AHD_INITIATORROLE) != 0) {
+			 && (ahd->flags & AHD_INITIATORROLE) != 0) {
 				/*
 				 * Only allow additional targets if
 				 * the initiator role is disabled.
@@ -10437,7 +10434,7 @@ ahd_handle_en_lun(struct ahd_softc *ahd, struct cam_sim *sim, union ccb *ccb)
 		}
 
 		ahd_lock(ahd, &s);
-		
+
 		ccb->ccb_h.status = CAM_REQ_CMP;
 		LIST_FOREACH(scb, &ahd->pending_scbs, pending_links) {
 			struct ccb_hdr *ccbh;
@@ -10701,7 +10698,7 @@ ahd_handle_target_cmd(struct ahd_softc *ahd, struct target_cmd *cmd)
 		printk("Reserved or VU command code type encountered\n");
 		break;
 	}
-	
+
 	memcpy(atio->cdb_io.cdb_bytes, byte, atio->cdb_len);
 
 	atio->ccb_h.status |= CAM_CDB_RECVD;
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/aic79xx_osm.h
index 8a8b7ae7aed3..d6e38298f15b 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -242,7 +242,7 @@ struct ahd_linux_device {
 	int			active;
 
 	/*
-	 * The currently allowed number of 
+	 * The currently allowed number of
 	 * transactions that can be queued to
 	 * the device.  Must be signed for
 	 * conversion from tagged to untagged
@@ -256,7 +256,7 @@ struct ahd_linux_device {
 	 * device's queue is halted.
 	 */
 	u_int			qfrozen;
-	
+
 	/*
 	 * Cumulative command counter.
 	 */
@@ -340,11 +340,11 @@ struct ahd_platform_data {
 	/*
 	 * Fields accessed from interrupt context.
 	 */
-	struct scsi_target *starget[AHD_NUM_TARGETS]; 
+	struct scsi_target *starget[AHD_NUM_TARGETS];
 
 	spinlock_t		 spin_lock;
 	struct completion	*eh_done;
-	struct Scsi_Host        *host;		/* pointer to scsi host */
+	struct Scsi_Host	*host;		/* pointer to scsi host */
 #define AHD_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
 	uint32_t		 bios_address;
@@ -655,9 +655,9 @@ static inline void
 ahd_freeze_scb(struct scb *scb)
 {
 	if ((scb->io_ctx->result & (CAM_DEV_QFRZN << 16)) == 0) {
-                scb->io_ctx->result |= CAM_DEV_QFRZN << 16;
-                scb->platform_data->dev->qfrozen++;
-        }
+		scb->io_ctx->result |= CAM_DEV_QFRZN << 16;
+		scb->platform_data->dev->qfrozen++;
+	}
 }
 
 void	ahd_platform_set_tags(struct ahd_softc *ahd, struct scsi_device *sdev,
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
index 8b891a05d9e7..6a42d527e87d 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -45,8 +45,8 @@
 
 /* Define the macro locally since it's different for different class of chips.
  */
-#define ID(x)            \
-	ID2C(x),         \
+#define ID(x)		 \
+	ID2C(x),	 \
 	ID2C(IDIROC(x))
 
 static const struct pci_device_id ahd_linux_pci_id_table[] = {
@@ -386,7 +386,7 @@ ahd_pci_map_int(struct ahd_softc *ahd)
 			    IRQF_SHARED, "aic79xx", ahd);
 	if (!error)
 		ahd->platform_data->irq = ahd->dev_softc->irq;
-	
+
 	return (-error);
 }
 
diff --git a/drivers/scsi/aic7xxx/aic79xx_proc.c b/drivers/scsi/aic7xxx/aic79xx_proc.c
index add2da581d66..746d0ca2a657 100644
--- a/drivers/scsi/aic7xxx/aic79xx_proc.c
+++ b/drivers/scsi/aic7xxx/aic79xx_proc.c
@@ -100,17 +100,17 @@ ahd_format_transinfo(struct seq_file *m, struct ahd_transinfo *tinfo)
 		seq_puts(m, "Renegotiation Pending\n");
 		return;
 	}
-        speed = 3300;
-        freq = 0;
+	speed = 3300;
+	freq = 0;
 	if (tinfo->offset != 0) {
 		freq = ahd_calc_syncsrate(tinfo->period);
 		speed = freq;
 	}
 	speed *= (0x01 << tinfo->width);
-        mb = speed / 1000;
-        if (mb > 0)
+	mb = speed / 1000;
+	if (mb > 0)
 		seq_printf(m, "%d.%03dMB/s transfers", mb, speed % 1000);
-        else
+	else
 		seq_printf(m, "%dKB/s transfers", speed);
 
 	if (freq != 0) {
@@ -242,7 +242,8 @@ ahd_proc_write_seeprom(struct Scsi_Host *shost, char *buffer, int length)
 		u_int start_addr;
 
 		if (ahd->seep_config == NULL) {
-			ahd->seep_config = kmalloc(sizeof(*ahd->seep_config), GFP_ATOMIC);
+			ahd->seep_config = kmalloc(sizeof(*ahd->seep_config),
+						   GFP_ATOMIC);
 			if (ahd->seep_config == NULL) {
 				printk("aic79xx: Unable to allocate serial "
 				       "eeprom buffer.  Write failing\n");
diff --git a/drivers/scsi/aic7xxx/aic7xxx_93cx6.c b/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
index cc9e41967ce4..11ddffbcc2f3 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
@@ -73,8 +73,8 @@
  * add other 93Cx6 functions.
  */
 struct seeprom_cmd {
-  	uint8_t len;
- 	uint8_t bits[11];
+	uint8_t len;
+	uint8_t bits[11];
 };
 
 /* Short opcodes for the c46 */
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index 725bb7f58054..72006483b016 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -66,7 +66,7 @@ static const char *const ahc_chip_names[] = {
  * Hardware error codes.
  */
 struct ahc_hard_error_entry {
-        uint8_t errno;
+	uint8_t errno;
 	const char *errmesg;
 };
 
@@ -142,7 +142,7 @@ static void		ahc_free_tstate(struct ahc_softc *ahc,
 #endif
 static const struct ahc_syncrate*
 			ahc_devlimited_syncrate(struct ahc_softc *ahc,
-					        struct ahc_initiator_tinfo *,
+						struct ahc_initiator_tinfo *,
 						u_int *period,
 						u_int *ppr_options,
 						role_t role);
@@ -195,7 +195,7 @@ static void		ahc_setup_target_msgin(struct ahc_softc *ahc,
 					       struct scb *scb);
 #endif
 
-static bus_dmamap_callback_t	ahc_dmamap_cb; 
+static bus_dmamap_callback_t	ahc_dmamap_cb;
 static void		ahc_build_free_scb_list(struct ahc_softc *ahc);
 static int		ahc_init_scbdata(struct ahc_softc *ahc);
 static void		ahc_fini_scbdata(struct ahc_softc *ahc);
@@ -978,7 +978,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 {
 	struct scb *scb;
 	struct ahc_devinfo devinfo;
-	
+
 	ahc_fetch_devinfo(ahc, &devinfo);
 
 	/*
@@ -1022,7 +1022,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 			goto unpause;
 		}
 
-		hscb = scb->hscb; 
+		hscb = scb->hscb;
 
 		/* Don't want to clobber the original sense code */
 		if ((scb->flags & SCB_SENSE) != 0) {
@@ -1071,7 +1071,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 							&tstate);
 			tinfo = &targ_info->curr;
 			sg = scb->sg_list;
-			sc = (struct scsi_sense *)(&hscb->shared_data.cdb); 
+			sc = (struct scsi_sense *)(&hscb->shared_data.cdb);
 			/*
 			 * Save off the residual if there is one.
 			 */
@@ -1117,8 +1117,8 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 			 * errors will be reported before any data
 			 * phases occur.
 			 */
-			if (ahc_get_residual(scb) 
-			 == ahc_get_transfer_length(scb)) {
+			if (ahc_get_residual(scb)
+			    == ahc_get_transfer_length(scb)) {
 				ahc_update_neg_request(ahc, &devinfo,
 						       tstate, targ_info,
 						       AHC_NEG_IF_NON_ASYNC);
@@ -1129,7 +1129,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 				scb->flags |= SCB_AUTO_NEGOTIATE;
 			}
 			hscb->cdb_len = sizeof(*sc);
-			hscb->dataptr = sg->addr; 
+			hscb->dataptr = sg->addr;
 			hscb->datacnt = sg->len;
 			hscb->sgptr = scb->sg_list_phys | SG_FULL_RESID;
 			hscb->sgptr = ahc_htole32(hscb->sgptr);
@@ -1187,13 +1187,13 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 		ahc_assert_atn(ahc);
 		break;
 	}
-	case SEND_REJECT: 
+	case SEND_REJECT:
 	{
 		u_int rejbyte = ahc_inb(ahc, ACCUM);
 		printk("%s:%c:%d: Warning - unknown message received from "
-		       "target (0x%x).  Rejecting\n", 
+		       "target (0x%x).  Rejecting\n",
 		       ahc_name(ahc), devinfo.channel, devinfo.target, rejbyte);
-		break; 
+		break;
 	}
 	case PROTO_VIOLATION:
 	{
@@ -1286,8 +1286,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 					ahc->msg_type =
 					    MSG_TYPE_TARGET_MSGOUT;
 					ahc->msgin_index = 0;
-				}
-				else 
+				} else
 					ahc_setup_target_msgin(ahc,
 							       &devinfo,
 							       scb);
@@ -1359,7 +1358,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 					if (scb != NULL)
 						ahc_set_transaction_status(scb,
 						    CAM_UNCOR_PARITY);
-					ahc_reset_channel(ahc, devinfo.channel, 
+					ahc_reset_channel(ahc, devinfo.channel,
 							  /*init reset*/TRUE);
 				}
 			} else {
@@ -1391,7 +1390,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 		printk("data overrun detected %s."
 		       "  Tag == 0x%x.\n",
 		       ahc_phase_table[i].phasemsg,
-  		       scb->hscb->tag);
+		       scb->hscb->tag);
 		ahc_print_path(ahc, scb);
 		printk("%s seen Data Phase.  Length = %ld.  NumSGs = %d.\n",
 		       ahc_inb(ahc, SEQ_FLAGS) & DPHASE ? "Have" : "Haven't",
@@ -1402,7 +1401,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 				printk("sg[%d] - Addr 0x%x%x : Length %d\n",
 				       i,
 				       (ahc_le32toh(scb->sg_list[i].len) >> 24
-				        & SG_HIGH_ADDR_BITS),
+					& SG_HIGH_ADDR_BITS),
 				       ahc_le32toh(scb->sg_list[i].addr),
 				       ahc_le32toh(scb->sg_list[i].len)
 				       & AHC_SG_LEN_MASK);
@@ -1549,7 +1548,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 	if (status == 0 && status0 == 0) {
 		if ((ahc->features & AHC_TWIN) != 0) {
 			/* Try the other channel */
-		 	ahc_outb(ahc, SBLKCTL, ahc_inb(ahc, SBLKCTL) ^ SELBUSB);
+			ahc_outb(ahc, SBLKCTL, ahc_inb(ahc, SBLKCTL) ^ SELBUSB);
 			status = ahc_inb(ahc, SSTAT1)
 			       & (SELTO|SCSIRSTI|BUSFREE|SCSIPERR);
 			intr_channel = (cur_channel == 'A') ? 'B' : 'A';
@@ -1595,7 +1594,7 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 		printk("%s: Someone reset channel %c\n",
 			ahc_name(ahc), intr_channel);
 		if (intr_channel != cur_channel)
-		 	ahc_outb(ahc, SBLKCTL, ahc_inb(ahc, SBLKCTL) ^ SELBUSB);
+			ahc_outb(ahc, SBLKCTL, ahc_inb(ahc, SBLKCTL) ^ SELBUSB);
 		ahc_reset_channel(ahc, intr_channel, /*Initiate Reset*/FALSE);
 	} else if ((status & SCSIPERR) != 0) {
 		/*
@@ -1688,8 +1687,8 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 		}
 
 		/*
-		 * We've set the hardware to assert ATN if we   
-		 * get a parity error on "in" phases, so all we  
+		 * We've set the hardware to assert ATN if we
+		 * get a parity error on "in" phases, so all we
 		 * need to do is stuff the message buffer with
 		 * the appropriate message.  "In" phases have set
 		 * mesg_out to something other than MSG_NOP.
@@ -1986,7 +1985,7 @@ ahc_clear_critical_section(struct ahc_softc *ahc)
 			| (ahc_inb(ahc, SEQADDR1) << 8);
 
 		/*
-		 * Seqaddr represents the next instruction to execute, 
+		 * Seqaddr represents the next instruction to execute,
 		 * so we are really executing the instruction just
 		 * before it.
 		 */
@@ -1994,7 +1993,6 @@ ahc_clear_critical_section(struct ahc_softc *ahc)
 			seqaddr -= 1;
 		cs = ahc->critical_sections;
 		for (i = 0; i < ahc->num_critical_sections; i++, cs++) {
-			
 			if (cs->begin < seqaddr && cs->end >= seqaddr)
 				break;
 		}
@@ -2064,7 +2062,7 @@ ahc_clear_intstat(struct ahc_softc *ahc)
 				CLRREQINIT);
 	ahc_flush_device_writes(ahc);
 	ahc_outb(ahc, CLRSINT0, CLRSELDO|CLRSELDI|CLRSELINGO);
- 	ahc_flush_device_writes(ahc);
+	ahc_flush_device_writes(ahc);
 	ahc_outb(ahc, CLRINT, CLRSCSIINT);
 	ahc_flush_device_writes(ahc);
 }
@@ -2101,7 +2099,7 @@ ahc_print_scb(struct scb *scb)
 			printk("sg[%d] - Addr 0x%x%x : Length %d\n",
 			       i,
 			       (ahc_le32toh(scb->sg_list[i].len) >> 24
-			        & SG_HIGH_ADDR_BITS),
+				& SG_HIGH_ADDR_BITS),
 			       ahc_le32toh(scb->sg_list[i].addr),
 			       ahc_le32toh(scb->sg_list[i].len));
 		}
@@ -2223,7 +2221,7 @@ ahc_devlimited_syncrate(struct ahc_softc *ahc,
 	 */
 	if (role == ROLE_TARGET)
 		transinfo = &tinfo->user;
-	else 
+	else
 		transinfo = &tinfo->goal;
 	*ppr_options &= transinfo->ppr_options;
 	if (transinfo->width == MSG_EXT_WDTR_BUS_8_BIT) {
@@ -2655,9 +2653,9 @@ ahc_set_tags(struct ahc_softc *ahc, struct scsi_cmnd *cmd,
 {
 	struct scsi_device *sdev = cmd->device;
 
- 	ahc_platform_set_tags(ahc, sdev, devinfo, alg);
- 	ahc_send_async(ahc, devinfo->channel, devinfo->target,
- 		       devinfo->lun, AC_TRANSFER_NEG);
+	ahc_platform_set_tags(ahc, sdev, devinfo, alg);
+	ahc_send_async(ahc, devinfo->channel, devinfo->target,
+		       devinfo->lun, AC_TRANSFER_NEG);
 }
 
 /*
@@ -2756,9 +2754,9 @@ ahc_fetch_devinfo(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		role = ROLE_INITIATOR;
 
 	if (role == ROLE_TARGET
-	 && (ahc->features & AHC_MULTI_TID) != 0
-	 && (ahc_inb(ahc, SEQ_FLAGS)
- 	   & (CMDPHASE_PENDING|TARG_CMD_PENDING|NO_DISCONNECT)) != 0) {
+	    && (ahc->features & AHC_MULTI_TID) != 0
+	    && (ahc_inb(ahc, SEQ_FLAGS)
+	     & (CMDPHASE_PENDING|TARG_CMD_PENDING|NO_DISCONNECT)) != 0) {
 		/* We were selected, so pull our id from TARGIDIN */
 		our_id = ahc_inb(ahc, TARGIDIN) & OID;
 	} else if ((ahc->features & AHC_ULTRA2) != 0)
@@ -3366,7 +3364,7 @@ ahc_handle_message_phase(struct ahc_softc *ahc)
 #endif
 				ahc_assert_atn(ahc);
 			}
-		} else 
+		} else
 			ahc->msgin_index++;
 
 		if (message_done == MSGLOOP_TERMINATED) {
@@ -3459,7 +3457,7 @@ ahc_handle_message_phase(struct ahc_softc *ahc)
 			 */
 			return;
 		}
-		
+
 		ahc->msgin_index++;
 
 		/*
@@ -4338,7 +4336,7 @@ ahc_handle_devreset(struct ahc_softc *ahc, struct ahc_devinfo *devinfo,
 	ahc_set_syncrate(ahc, devinfo, /*syncrate*/NULL,
 			 /*period*/0, /*offset*/0, /*ppr_options*/0,
 			 AHC_TRANS_CUR, /*paused*/TRUE);
-	
+
 	if (status != CAM_SEL_TIMEOUT)
 		ahc_send_async(ahc, devinfo->channel, devinfo->target,
 			       CAM_LUN_WILDCARD, AC_SENT_BDR);
@@ -4355,11 +4353,11 @@ ahc_setup_target_msgin(struct ahc_softc *ahc, struct ahc_devinfo *devinfo,
 		       struct scb *scb)
 {
 
-	/*              
+	/*
 	 * To facilitate adding multiple messages together,
 	 * each routine should increment the index and len
 	 * variables instead of setting them explicitly.
-	 */             
+	 */
 	ahc->msgout_index = 0;
 	ahc->msgout_len = 0;
 
@@ -4432,7 +4430,7 @@ ahc_softc_init(struct ahc_softc *ahc)
 		ahc->unpause = ahc_inb(ahc, HCNTRL) & IRQMS;
 	else
 		ahc->unpause = 0;
-	ahc->pause = ahc->unpause | PAUSE; 
+	ahc->pause = ahc->unpause | PAUSE;
 	/* XXX The shared scb data stuff should be deprecated */
 	if (ahc->scb_data == NULL) {
 		ahc->scb_data = kzalloc(sizeof(*ahc->scb_data), GFP_ATOMIC);
@@ -4553,7 +4551,7 @@ ahc_reset(struct ahc_softc *ahc, int reinit)
 	u_int	sxfrctl1_a, sxfrctl1_b;
 	int	error;
 	int	wait;
-	
+
 	/*
 	 * Preserve the value of the SXFRCTL1 register for all channels.
 	 * It contains settings that affect termination and we don't want
@@ -4642,7 +4640,7 @@ ahc_reset(struct ahc_softc *ahc, int reinit)
 		 */
 		error = ahc->bus_chip_init(ahc);
 #ifdef AHC_DUMP_SEQ
-	else 
+	else
 		ahc_dumpseq(ahc);
 #endif
 
@@ -4707,7 +4705,7 @@ ahc_build_free_scb_list(struct ahc_softc *ahc)
 		/* Set the next pointer */
 		if ((ahc->flags & AHC_PAGESCBS) != 0)
 			ahc_outb(ahc, SCB_NEXT, i+1);
-		else 
+		else
 			ahc_outb(ahc, SCB_NEXT, SCB_LIST_NULL);
 
 		/* Make the tag number, SCSIID, and lun invalid */
@@ -4860,7 +4858,7 @@ ahc_init_scbdata(struct ahc_softc *ahc)
 	/*
 	 * Note that we were successful
 	 */
-	return (0); 
+	return (0);
 
 error_exit:
 
@@ -5003,7 +5001,7 @@ ahc_controller_info(struct ahc_softc *ahc, char *buf)
 	len = sprintf(buf, "%s: ", ahc_chip_names[ahc->chip & AHC_CHIPID_MASK]);
 	buf += len;
 	if ((ahc->features & AHC_TWIN) != 0)
- 		len = sprintf(buf, "Twin Channel, A SCSI Id=%d, "
+		len = sprintf(buf, "Twin Channel, A SCSI Id=%d, "
 			      "B SCSI Id=%d, primary %c, ",
 			      ahc->our_id, ahc->our_id_b,
 			      (ahc->flags & AHC_PRIMARY_CHANNEL) + 'A');
@@ -5139,7 +5137,7 @@ ahc_chip_init(struct ahc_softc *ahc)
 	ahc_outb(ahc, CMDSIZE_TABLE + 5, 11);
 	ahc_outb(ahc, CMDSIZE_TABLE + 6, 0);
 	ahc_outb(ahc, CMDSIZE_TABLE + 7, 0);
-		
+
 	if ((ahc->features & AHC_HS_MAILBOX) != 0)
 		ahc_outb(ahc, HS_MAILBOX, 0);
 
@@ -5270,7 +5268,7 @@ ahc_init(struct ahc_softc *ahc)
 	 */
 	if ((ahc->flags & AHC_USEDEFAULTS) != 0)
 		ahc->our_id = ahc->our_id_b = 7;
-	
+
 	/*
 	 * Default to allowing initiator operations.
 	 */
@@ -5288,7 +5286,7 @@ ahc_init(struct ahc_softc *ahc)
 	 * DMA tag for our command fifos and other data in system memory
 	 * the card's sequencer must be able to access.  For initiator
 	 * roles, we need to allocate space for the qinfifo and qoutfifo.
-	 * The qinfifo and qoutfifo are composed of 256 1 byte elements. 
+	 * The qinfifo and qoutfifo are composed of 256 1 byte elements.
 	 * When providing for the target mode role, we must additionally
 	 * provide space for the incoming target command fifo and an extra
 	 * byte to deal with a dma bug in some chip versions.
@@ -5397,7 +5395,7 @@ ahc_init(struct ahc_softc *ahc)
 	 && (ahc->flags & AHC_INITIATORROLE) != 0)
 		ahc->flags |= AHC_RESET_BUS_A;
 
-	ultraenb = 0;	
+	ultraenb = 0;
 	tagenable = ALL_TARGETS_MASK;
 
 	/* Grab the disconnection disable table and invert it for our needs */
@@ -5493,9 +5491,9 @@ ahc_init(struct ahc_softc *ahc)
 				 && (ultraenb & mask) != 0) {
 					/* Treat 10MHz as a non-ultra speed */
 					scsirate &= ~SXFR;
-				 	ultraenb &= ~mask;
+					ultraenb &= ~mask;
 				}
-				tinfo->user.period = 
+				tinfo->user.period =
 				    ahc_find_period(ahc, scsirate,
 						    (ultraenb & mask)
 						   ? AHC_SYNCRATE_ULTRA
@@ -5622,7 +5620,7 @@ ahc_resume(struct ahc_softc *ahc)
 {
 
 	ahc_reset(ahc, /*reinit*/TRUE);
-	ahc_intr_enable(ahc, TRUE); 
+	ahc_intr_enable(ahc, TRUE);
 	ahc_restart(ahc);
 	return (0);
 }
@@ -5640,7 +5638,7 @@ ahc_index_busy_tcl(struct ahc_softc *ahc, u_int tcl)
 
 	if ((ahc->flags & AHC_SCB_BTT) != 0) {
 		u_int saved_scbptr;
-		
+
 		saved_scbptr = ahc_inb(ahc, SCBPTR);
 		ahc_outb(ahc, SCBPTR, TCL_LUN(tcl));
 		scbid = ahc_inb(ahc, SCB_64_BTT + TCL_TARGET_OFFSET(tcl));
@@ -5660,7 +5658,7 @@ ahc_unbusy_tcl(struct ahc_softc *ahc, u_int tcl)
 
 	if ((ahc->flags & AHC_SCB_BTT) != 0) {
 		u_int saved_scbptr;
-		
+
 		saved_scbptr = ahc_inb(ahc, SCBPTR);
 		ahc_outb(ahc, SCBPTR, TCL_LUN(tcl));
 		ahc_outb(ahc, SCB_64_BTT+TCL_TARGET_OFFSET(tcl), SCB_LIST_NULL);
@@ -5678,7 +5676,7 @@ ahc_busy_tcl(struct ahc_softc *ahc, u_int tcl, u_int scbid)
 
 	if ((ahc->flags & AHC_SCB_BTT) != 0) {
 		u_int saved_scbptr;
-		
+
 		saved_scbptr = ahc_inb(ahc, SCBPTR);
 		ahc_outb(ahc, SCBPTR, TCL_LUN(tcl));
 		ahc_outb(ahc, SCB_64_BTT + TCL_TARGET_OFFSET(tcl), scbid);
@@ -5736,7 +5734,7 @@ ahc_freeze_devq(struct ahc_softc *ahc, struct scb *scb)
 	target = SCB_GET_TARGET(ahc, scb);
 	lun = SCB_GET_LUN(scb);
 	channel = SCB_GET_CHANNEL(ahc, scb);
-	
+
 	ahc_search_qinfifo(ahc, target, channel, lun,
 			   /*tag*/SCB_LIST_NULL, ROLE_UNKNOWN,
 			   CAM_REQUEUE_REQ, SEARCH_COMPLETE);
@@ -5774,7 +5772,7 @@ ahc_qinfifo_requeue(struct ahc_softc *ahc, struct scb *prev_scb,
 		ahc_outb(ahc, NEXT_QUEUED_SCB, scb->hscb->tag);
 	} else {
 		prev_scb->hscb->next = scb->hscb->tag;
-		ahc_sync_scb(ahc, prev_scb, 
+		ahc_sync_scb(ahc, prev_scb,
 			     BUS_DMASYNC_PREREAD|BUS_DMASYNC_PREWRITE);
 	}
 	ahc->qinfifo[ahc->qinfifonext++] = scb->hscb->tag;
@@ -5991,7 +5989,6 @@ ahc_search_qinfifo(struct ahc_softc *ahc, int target, char channel,
 				break;
 			}
 		} else {
-			
 			prev = next;
 			next = ahc_inb(ahc, SCB_NEXT);
 		}
@@ -6237,7 +6234,7 @@ ahc_rem_wscb(struct ahc_softc *ahc, u_int scbpos, u_int prev)
 	/* update the waiting list */
 	if (prev == SCB_LIST_NULL) {
 		/* First in the list */
-		ahc_outb(ahc, WAITING_SCBH, next); 
+		ahc_outb(ahc, WAITING_SCBH, next);
 
 		/*
 		 * Ensure we aren't attempting to perform
@@ -6246,7 +6243,7 @@ ahc_rem_wscb(struct ahc_softc *ahc, u_int scbpos, u_int prev)
 		ahc_outb(ahc, SCSISEQ, (ahc_inb(ahc, SCSISEQ) & ~ENSELO));
 	} else {
 		/*
-		 * Select the scb that pointed to us 
+		 * Select the scb that pointed to us
 		 * and update its next pointer.
 		 */
 		ahc_outb(ahc, SCBPTR, prev);
@@ -6640,7 +6637,7 @@ ahc_calc_residual(struct ahc_softc *ahc, struct scb *scb)
 
 		/*
 		 * Remainder of the SG where the transfer
-		 * stopped.  
+		 * stopped.
 		 */
 		resid = ahc_le32toh(spkt->residual_datacnt) & AHC_SG_LEN_MASK;
 		sg = ahc_sg_bus_to_virt(scb, resid_sgptr & SG_PTR_MASK);
@@ -6859,7 +6856,7 @@ ahc_loadseq(struct ahc_softc *ahc)
 				if (begin_set[cs_count] == TRUE
 				 && end_set[cs_count] == FALSE) {
 					cs_table[cs_count].end = downloaded;
-				 	end_set[cs_count] = TRUE;
+					end_set[cs_count] = TRUE;
 					cs_count++;
 				}
 				continue;
@@ -7087,7 +7084,6 @@ ahc_print_register(const ahc_reg_parse_entry_t *table, u_int num_entries,
 					  printed_mask == 0 ? ":(" : "|",
 					  table[entry].name);
 			printed_mask |= table[entry].mask;
-			
 			break;
 		}
 		if (entry >= num_entries)
@@ -7201,7 +7197,7 @@ ahc_dump_card_state(struct ahc_softc *ahc)
 		scb_index = ahc_inb(ahc, SCB_NEXT);
 	}
 	printk("\n");
-		
+
 	ahc_sync_qoutfifo(ahc, BUS_DMASYNC_POSTREAD);
 	printk("QOUTFIFO entries: ");
 	qoutpos = ahc->qoutfifonext;
@@ -7378,7 +7374,7 @@ ahc_handle_en_lun(struct ahc_softc *ahc, struct cam_sim *sim, union ccb *ccb)
 		if ((ahc->features & AHC_MULTIROLE) != 0) {
 
 			if ((ahc->features & AHC_MULTI_TID) != 0
-		   	 && (ahc->flags & AHC_INITIATORROLE) != 0) {
+			 && (ahc->flags & AHC_INITIATORROLE) != 0) {
 				/*
 				 * Only allow additional targets if
 				 * the initiator role is disabled.
@@ -7529,7 +7525,6 @@ ahc_handle_en_lun(struct ahc_softc *ahc, struct cam_sim *sim, union ccb *ccb)
 				targid_mask |= target_mask;
 				ahc_outb(ahc, TARGID, targid_mask);
 				ahc_outb(ahc, TARGID+1, (targid_mask >> 8));
-				
 				ahc_update_scsiid(ahc, targid_mask);
 			} else {
 				u_int our_id;
@@ -7594,7 +7589,7 @@ ahc_handle_en_lun(struct ahc_softc *ahc, struct cam_sim *sim, union ccb *ccb)
 		}
 
 		ahc_lock(ahc, &s);
-		
+
 		ccb->ccb_h.status = CAM_REQ_CMP;
 		LIST_FOREACH(scb, &ahc->pending_scbs, pending_links) {
 			struct ccb_hdr *ccbh;
@@ -7653,7 +7648,7 @@ ahc_handle_en_lun(struct ahc_softc *ahc, struct cam_sim *sim, union ccb *ccb)
 					targid_mask &= ~target_mask;
 					ahc_outb(ahc, TARGID, targid_mask);
 					ahc_outb(ahc, TARGID+1,
-					 	 (targid_mask >> 8));
+						 (targid_mask >> 8));
 					ahc_update_scsiid(ahc, targid_mask);
 				}
 			}
@@ -7782,7 +7777,7 @@ ahc_run_tqinfifo(struct ahc_softc *ahc, int paused)
 				ahc_outb(ahc, HS_MAILBOX, hs_mailbox);
 			} else {
 				if (!paused)
-					ahc_pause(ahc);	
+					ahc_pause(ahc);
 				ahc_outb(ahc, KERNEL_TQINPOS,
 					 ahc->tqinfifonext & HOST_TQINPOS);
 				if (!paused)
@@ -7881,7 +7876,7 @@ ahc_handle_target_cmd(struct ahc_softc *ahc, struct target_cmd *cmd)
 		printk("Reserved or VU command code type encountered\n");
 		break;
 	}
-	
+
 	memcpy(atio->cdb_io.cdb_bytes, byte, atio->cdb_len);
 
 	atio->ccb_h.status |= CAM_CDB_RECVD;
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 7bba961d1ae0..0aaca2eab6b6 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -452,7 +452,7 @@ ahc_insb(struct ahc_softc * ahc, long port, uint8_t *array, int count)
 static void ahc_linux_unmap_scb(struct ahc_softc*, struct scb*);
 
 static int ahc_linux_map_seg(struct ahc_softc *ahc, struct scb *scb,
-		 		      struct ahc_dma_seg *sg,
+				      struct ahc_dma_seg *sg,
 				      dma_addr_t addr, bus_size_t len);
 
 static void
@@ -571,7 +571,7 @@ ahc_linux_target_alloc(struct scsi_target *starget)
 	target_offset = starget->id;
 	if (starget->channel != 0)
 		target_offset += 8;
-	  
+
 	if (starget->channel)
 		our_id = ahc->our_id_b;
 
@@ -597,18 +597,18 @@ ahc_linux_target_alloc(struct scsi_target *starget)
 			ultra = 0;
 			flags &= ~CFXFER;
 		}
-	    
+
 		if ((ahc->features & AHC_ULTRA2) != 0) {
 			scsirate = (flags & CFXFER) | (ultra ? 0x8 : 0);
 		} else {
 			scsirate = (flags & CFXFER) << 4;
-			maxsync = ultra ? AHC_SYNCRATE_ULTRA : 
+			maxsync = ultra ? AHC_SYNCRATE_ULTRA :
 				AHC_SYNCRATE_FAST;
 		}
 		spi_max_width(starget) = (flags & CFWIDEB) ? 1 : 0;
 		if (!(flags & CFSYNCH))
 			spi_max_offset(starget) = 0;
-		spi_min_period(starget) = 
+		spi_min_period(starget) =
 			ahc_find_period(ahc, scsirate, maxsync);
 	}
 	ahc_compile_devinfo(&devinfo, our_id, starget->id,
@@ -657,7 +657,7 @@ ahc_linux_slave_alloc(struct scsi_device *sdev)
 	 * a tagged queuing capable device.
 	 */
 	dev->maxtags = 0;
-	
+
 	spi_period(starget) = 0;
 
 	return 0;
@@ -1219,8 +1219,8 @@ ahc_platform_free(struct ahc_softc *ahc)
 			starget = ahc->platform_data->starget[i];
 			if (starget != NULL) {
 				ahc->platform_data->starget[i] = NULL;
- 			}
- 		}
+			}
+		}
 
 		if (ahc->platform_data->irq != AHC_LINUX_NOIRQ)
 			free_irq(ahc->platform_data->irq, ahc);
@@ -1267,7 +1267,7 @@ ahc_platform_set_tags(struct ahc_softc *ahc, struct scsi_device *sdev,
 	default:
 	case AHC_QUEUE_NONE:
 		now_queuing = 0;
-		break; 
+		break;
 	case AHC_QUEUE_BASIC:
 		now_queuing = AHC_DEV_Q_BASIC;
 		break;
@@ -1468,10 +1468,10 @@ ahc_linux_run_command(struct ahc_softc *ahc, struct ahc_linux_device *dev,
 	hscb->scsioffset = tinfo->curr.offset;
 	if ((tstate->ultraenb & mask) != 0)
 		hscb->control |= ULTRAENB;
-	
+
 	if ((ahc->user_discenable & mask) != 0)
 		hscb->control |= DISCENB;
-	
+
 	if ((tstate->auto_negotiate & mask) != 0) {
 		scb->flags |= SCB_AUTO_NEGOTIATE;
 		scb->hscb->control |= MK_MESSAGE;
@@ -1531,7 +1531,7 @@ ahc_linux_run_command(struct ahc_softc *ahc, struct ahc_linux_device *dev,
 		 */
 		scb->hscb->sgptr =
 			ahc_htole32(scb->sg_list_phys | SG_FULL_RESID);
-		
+
 		/*
 		 * Copy the first SG into the "current"
 		 * data pointer area.
@@ -1551,7 +1551,7 @@ ahc_linux_run_command(struct ahc_softc *ahc, struct ahc_linux_device *dev,
 	dev->commands_issued++;
 	if ((dev->flags & AHC_DEV_PERIODIC_OTAG) != 0)
 		dev->commands_since_idle_or_otag++;
-	
+
 	scb->flags |= SCB_ACTIVE;
 	if (untagged_q) {
 		TAILQ_INSERT_TAIL(untagged_q, scb, links.tqe);
@@ -1572,7 +1572,7 @@ ahc_linux_isr(int irq, void *dev_id)
 	int	ours;
 
 	ahc = (struct ahc_softc *) dev_id;
-	ahc_lock(ahc, &flags); 
+	ahc_lock(ahc, &flags);
 	ours = ahc_intr(ahc);
 	ahc_unlock(ahc, &flags);
 	return IRQ_RETVAL(ours);
@@ -1647,22 +1647,22 @@ ahc_send_async(struct ahc_softc *ahc, char channel,
 		spi_display_xfer_agreement(starget);
 		break;
 	}
-        case AC_SENT_BDR:
+	case AC_SENT_BDR:
 	{
 		WARN_ON(lun != CAM_LUN_WILDCARD);
 		scsi_report_device_reset(ahc->platform_data->host,
 					 channel - 'A', target);
 		break;
 	}
-        case AC_BUS_RESET:
+	case AC_BUS_RESET:
 		if (ahc->platform_data->host != NULL) {
 			scsi_report_bus_reset(ahc->platform_data->host,
 					      channel - 'A');
 		}
-                break;
-        default:
-                panic("ahc_send_async: Unexpected async event");
-        }
+		break;
+	default:
+		panic("ahc_send_async: Unexpected async event");
+	}
 }
 
 /*
@@ -1802,7 +1802,7 @@ ahc_linux_handle_scsi_status(struct ahc_softc *ahc,
 			    sdev->sdev_target->id, sdev->lun,
 			    sdev->sdev_target->channel == 0 ? 'A' : 'B',
 			    ROLE_INITIATOR);
-	
+
 	/*
 	 * We don't currently trust the mid-layer to
 	 * properly deal with queue full or busy.  So,
@@ -2108,7 +2108,7 @@ ahc_linux_queue_recovery_cmd(struct scsi_cmnd *cmd, scb_flag flag)
 
 		/* Any SCB for this device will do for a target reset */
 		LIST_FOREACH(pending_scb, &ahc->pending_scbs, pending_links) {
-		  	if (ahc_match_scb(ahc, pending_scb, scmd_id(cmd),
+			if (ahc_match_scb(ahc, pending_scb, scmd_id(cmd),
 					  scmd_channel(cmd) + 'A',
 					  CAM_LUN_WILDCARD,
 					  SCB_LIST_NULL, ROLE_INITIATOR))
@@ -2329,7 +2329,7 @@ static void ahc_linux_set_period(struct scsi_target *starget, int period)
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
 	struct ahc_tmode_tstate *tstate;
-	struct ahc_initiator_tinfo *tinfo 
+	struct ahc_initiator_tinfo *tinfo
 		= ahc_fetch_transinfo(ahc,
 				      starget->channel + 'A',
 				      shost->this_id, starget->id, &tstate);
@@ -2361,7 +2361,8 @@ static void ahc_linux_set_period(struct scsi_target *starget, int period)
 			ppr_options &= MSG_EXT_PPR_QAS_REQ;
 	}
 
-	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options, AHC_SYNCRATE_DT);
+	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
+				     AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, offset,
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
@@ -2373,7 +2374,7 @@ static void ahc_linux_set_offset(struct scsi_target *starget, int offset)
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
 	struct ahc_tmode_tstate *tstate;
-	struct ahc_initiator_tinfo *tinfo 
+	struct ahc_initiator_tinfo *tinfo
 		= ahc_fetch_transinfo(ahc,
 				      starget->channel + 'A',
 				      shost->this_id, starget->id, &tstate);
@@ -2386,7 +2387,8 @@ static void ahc_linux_set_offset(struct scsi_target *starget, int offset)
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
 	if (offset != 0) {
-		syncrate = ahc_find_syncrate(ahc, &period, &ppr_options, AHC_SYNCRATE_DT);
+		syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
+					     AHC_SYNCRATE_DT);
 		period = tinfo->goal.period;
 		ppr_options = tinfo->goal.ppr_options;
 	}
@@ -2401,7 +2403,7 @@ static void ahc_linux_set_dt(struct scsi_target *starget, int dt)
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
 	struct ahc_tmode_tstate *tstate;
-	struct ahc_initiator_tinfo *tinfo 
+	struct ahc_initiator_tinfo *tinfo
 		= ahc_fetch_transinfo(ahc,
 				      starget->channel + 'A',
 				      shost->this_id, starget->id, &tstate);
@@ -2422,7 +2424,8 @@ static void ahc_linux_set_dt(struct scsi_target *starget, int dt)
 
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
-	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,AHC_SYNCRATE_DT);
+	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
+				     AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, tinfo->goal.offset,
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
@@ -2439,7 +2442,7 @@ static void ahc_linux_set_qas(struct scsi_target *starget, int qas)
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
 	struct ahc_tmode_tstate *tstate;
-	struct ahc_initiator_tinfo *tinfo 
+	struct ahc_initiator_tinfo *tinfo
 		= ahc_fetch_transinfo(ahc,
 				      starget->channel + 'A',
 				      shost->this_id, starget->id, &tstate);
@@ -2455,7 +2458,8 @@ static void ahc_linux_set_qas(struct scsi_target *starget, int qas)
 
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
-	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options, AHC_SYNCRATE_DT);
+	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
+				     AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, tinfo->goal.offset,
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
@@ -2467,7 +2471,7 @@ static void ahc_linux_set_iu(struct scsi_target *starget, int iu)
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct ahc_softc *ahc = *((struct ahc_softc **)shost->hostdata);
 	struct ahc_tmode_tstate *tstate;
-	struct ahc_initiator_tinfo *tinfo 
+	struct ahc_initiator_tinfo *tinfo
 		= ahc_fetch_transinfo(ahc,
 				      starget->channel + 'A',
 				      shost->this_id, starget->id, &tstate);
@@ -2483,7 +2487,8 @@ static void ahc_linux_set_iu(struct scsi_target *starget, int iu)
 
 	ahc_compile_devinfo(&devinfo, shost->this_id, starget->id, 0,
 			    starget->channel + 'A', ROLE_INITIATOR);
-	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options, AHC_SYNCRATE_DT);
+	syncrate = ahc_find_syncrate(ahc, &period, &ppr_options,
+				     AHC_SYNCRATE_DT);
 	ahc_lock(ahc, &flags);
 	ahc_set_syncrate(ahc, &devinfo, syncrate, period, tinfo->goal.offset,
 			 ppr_options, AHC_TRANS_GOAL, FALSE);
@@ -2499,7 +2504,7 @@ static void ahc_linux_get_signalling(struct Scsi_Host *shost)
 
 	if (!(ahc->features & AHC_ULTRA2)) {
 		/* non-LVD chipset, may not have SBLKCTL reg */
-		spi_signalling(shost) = 
+		spi_signalling(shost) =
 			ahc->features & AHC_HVD ?
 			SPI_SIGNAL_HVD :
 			SPI_SIGNAL_SE;
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/aic7xxx_osm.h
index f8489078f003..125ba5eb175d 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -258,7 +258,7 @@ struct ahc_linux_device {
 	int			active;
 
 	/*
-	 * The currently allowed number of 
+	 * The currently allowed number of
 	 * transactions that can be queued to
 	 * the device.  Must be signed for
 	 * conversion from tagged to untagged
@@ -272,7 +272,7 @@ struct ahc_linux_device {
 	 * device's queue is halted.
 	 */
 	u_int			qfrozen;
-	
+
 	/*
 	 * Cumulative command counter.
 	 */
@@ -351,16 +351,16 @@ struct ahc_platform_data {
 	/*
 	 * Fields accessed from interrupt context.
 	 */
-	struct scsi_target *starget[AHC_NUM_TARGETS]; 
+	struct scsi_target *starget[AHC_NUM_TARGETS];
 
 	spinlock_t		 spin_lock;
 	u_int			 qfrozen;
 	struct completion	*eh_done;
-	struct Scsi_Host        *host;		/* pointer to scsi host */
+	struct Scsi_Host	*host;		/* pointer to scsi host */
 #define AHC_LINUX_NOIRQ	((uint32_t)~0)
 	uint32_t		 irq;		/* IRQ for this adapter */
 	uint32_t		 bios_address;
-	resource_size_t 	 mem_busaddr;	/* Mem Base Addr */
+	resource_size_t		 mem_busaddr;	/* Mem Base Addr */
 };
 
 void ahc_delay(long);
@@ -671,9 +671,9 @@ static inline void
 ahc_freeze_scb(struct scb *scb)
 {
 	if ((scb->io_ctx->result & (CAM_DEV_QFRZN << 16)) == 0) {
-                scb->io_ctx->result |= CAM_DEV_QFRZN << 16;
-                scb->platform_data->dev->qfrozen++;
-        }
+		scb->io_ctx->result |= CAM_DEV_QFRZN << 16;
+		scb->platform_data->dev->qfrozen++;
+	}
 }
 
 void	ahc_platform_set_tags(struct ahc_softc *ahc, struct scsi_device *sdev,
diff --git a/drivers/scsi/aic7xxx/aic7xxx_proc.c b/drivers/scsi/aic7xxx/aic7xxx_proc.c
index 18459605d991..4bc9e2dfccf6 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_proc.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_proc.c
@@ -97,17 +97,17 @@ ahc_format_transinfo(struct seq_file *m, struct ahc_transinfo *tinfo)
 	u_int freq;
 	u_int mb;
 
-        speed = 3300;
-        freq = 0;
+	speed = 3300;
+	freq = 0;
 	if (tinfo->offset != 0) {
 		freq = ahc_calc_syncsrate(tinfo->period);
 		speed = freq;
 	}
 	speed *= (0x01 << tinfo->width);
-        mb = speed / 1000;
-        if (mb > 0)
+	mb = speed / 1000;
+	if (mb > 0)
 		seq_printf(m, "%d.%03dMB/s transfers", mb, speed % 1000);
-        else
+	else
 		seq_printf(m, "%dKB/s transfers", speed);
 
 	if (freq != 0) {
@@ -234,7 +234,7 @@ ahc_proc_write_seeprom(struct Scsi_Host *shost, char *buffer, int length)
 	if ((ahc->chip & AHC_VL) != 0) {
 		sd.sd_control_offset = SEECTL_2840;
 		sd.sd_status_offset = STATUS_2840;
-		sd.sd_dataout_offset = STATUS_2840;		
+		sd.sd_dataout_offset = STATUS_2840;
 		sd.sd_chip = C46;
 		sd.sd_MS = 0;
 		sd.sd_RDY = EEPROM_TF;
@@ -255,7 +255,8 @@ ahc_proc_write_seeprom(struct Scsi_Host *shost, char *buffer, int length)
 		u_int start_addr;
 
 		if (ahc->seep_config == NULL) {
-			ahc->seep_config = kmalloc(sizeof(*ahc->seep_config), GFP_ATOMIC);
+			ahc->seep_config = kmalloc(sizeof(*ahc->seep_config),
+						   GFP_ATOMIC);
 			if (ahc->seep_config == NULL) {
 				printk("aic7xxx: Unable to allocate serial "
 				       "eeprom buffer.  Write failing\n");
-- 
2.16.4

