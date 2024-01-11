Return-Path: <linux-scsi+bounces-1537-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FF882AF5E
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jan 2024 14:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82611F23F53
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jan 2024 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667C182DC;
	Thu, 11 Jan 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQMpsbuN"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31B1802D;
	Thu, 11 Jan 2024 13:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C45EC43390;
	Thu, 11 Jan 2024 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704979071;
	bh=4RdvKST51cJemT2mdWu7LVxZC9+IbRrzBCtv9as6/tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQMpsbuNa0HzPgts9Tv3qoCoTicKXpZ+TVP/u4QhwXSTMd6H2jdrLciiUIuhDa1gC
	 4uipPFXY/dwW2y6AYR0FUUybTP2cAhiW6UcBvynjZxkDXmn77+Mtif8jnjxIfOMUNl
	 a6w7yg+tqGHC9pYc1JDGKrPLtPlRpKEg4STponK/dGuIVPpBRj/NSVzX+93B5W9MY/
	 nIx+MW4f4TnKujmpjxAc/CNoV/mxN/ODSE56h/4PPgDZ/t8Z0sYwZJP59rWKSiBBP3
	 q7Avzz4B2mVEY0BMRL7VcZavhTf5neUnbkVQaoIxfTCDk+w9SXxS4yjeKKfpET414V
	 2PAC4iraM5eTg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Richard Hirst <rhirst@linuxcare.com>
Subject: [PATCH 4/5] scsi: 53c700: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date: Thu, 11 Jan 2024 13:17:25 +0000
Message-ID: <20240111131732.1815560-5-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240111131732.1815560-1-lee@kernel.org>
References: <20240111131732.1815560-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Richard Hirst <rhirst@linuxcare.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/scsi/53c700.c | 104 +++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 857be0f3ae5b9..1aa933485719a 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
 **-----------------------------------------------------------------------------
-**  
+**
 **
 **-----------------------------------------------------------------------------
  */
@@ -18,7 +18,7 @@
  *
  * The 700 is the lowliest of the line, it can only do async SCSI.
  * The 700-66 can at least do synchronous SCSI up to 10MHz.
- * 
+ *
  * The 700 chip has no host bus interface logic of its own.  However,
  * it is usually mapped to a location with well defined register
  * offsets.  Therefore, if you can determine the base address and the
@@ -61,7 +61,7 @@
  * consistent memory allocation.
  *
  * Version 2.5
- * 
+ *
  * More Compatibility changes for 710 (now actually works).  Enhanced
  * support for odd clock speeds which constrain SDTR negotiations.
  * correct cacheline separation for scsi messages and status for
@@ -70,7 +70,7 @@
  *
  * Version 2.4
  *
- * Added support for the 53c710 chip (in 53c700 emulation mode only---no 
+ * Added support for the 53c710 chip (in 53c700 emulation mode only---no
  * special 53c710 instructions or registers are used).
  *
  * Version 2.3
@@ -190,7 +190,7 @@ static char *NCR_700_condition[] = {
 	"DISCONNECT_MSG RECEIVED",
 	"MSG_OUT",
 	"DATA_IN",
-	
+
 };
 
 static char *NCR_700_fatal_messages[] = {
@@ -260,7 +260,7 @@ NCR_700_offset_period_to_sxfer(struct NCR_700_Host_Parameters *hostdata,
 static inline __u8
 NCR_700_get_SXFER(struct scsi_device *SDp)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SDp->host->hostdata[0];
 
 	return NCR_700_offset_period_to_sxfer(hostdata,
@@ -416,7 +416,7 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 int
 NCR_700_release(struct Scsi_Host *host)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 
 	if (hostdata->noncoherent)
@@ -449,7 +449,7 @@ NCR_700_identify(int can_disconnect, __u8 lun)
  * Inputs : host - SCSI host */
 static inline int
 NCR_700_data_residual (struct Scsi_Host *host) {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 	int count, synchronous = 0;
 	unsigned int ddir;
@@ -461,16 +461,16 @@ NCR_700_data_residual (struct Scsi_Host *host) {
 		count = ((NCR_700_readb(host, DFIFO_REG) & 0x3f) -
 			 (NCR_700_readl(host, DBC_REG) & 0x3f)) & 0x3f;
 	}
-	
+
 	if(hostdata->fast)
 		synchronous = NCR_700_readb(host, SXFER_REG) & 0x0f;
-	
+
 	/* get the data direction */
 	ddir = NCR_700_readb(host, CTEST0_REG) & 0x01;
 
 	if (ddir) {
 		/* Receive */
-		if (synchronous) 
+		if (synchronous)
 			count += (NCR_700_readb(host, SSTAT2_REG) & 0xf0) >> 4;
 		else
 			if (NCR_700_readb(host, SSTAT1_REG) & SIDL_REG_FULL)
@@ -500,7 +500,7 @@ sbcl_to_string(__u8 sbcl)
 
 	ret[0]='\0';
 	for(i=0; i<8; i++) {
-		if((1<<i) & sbcl) 
+		if((1<<i) & sbcl)
 			strcat(ret, NCR_700_SBCL_bits[i]);
 	}
 	strcat(ret, NCR_700_SBCL_to_phase[sbcl & 0x07]);
@@ -533,7 +533,7 @@ find_empty_slot(struct NCR_700_Host_Parameters *hostdata)
 	if(slot->state != NCR_700_SLOT_FREE)
 		/* should panic! */
 		printk(KERN_ERR "BUSY SLOT ON FREE LIST!!!\n");
-		
+
 
 	hostdata->free_list = slot->ITL_forw;
 	slot->ITL_forw = NULL;
@@ -546,11 +546,11 @@ find_empty_slot(struct NCR_700_Host_Parameters *hostdata)
 	slot->state = NCR_700_SLOT_BUSY;
 	slot->flags = 0;
 	hostdata->command_slot_count++;
-	
+
 	return slot;
 }
 
-STATIC void 
+STATIC void
 free_slot(struct NCR_700_command_slot *slot,
 	  struct NCR_700_Host_Parameters *hostdata)
 {
@@ -560,7 +560,7 @@ free_slot(struct NCR_700_command_slot *slot,
 	if(slot->state == NCR_700_SLOT_FREE) {
 		printk(KERN_ERR "53c700: SLOT %p is FREE!!!\n", slot);
 	}
-	
+
 	slot->resume_offset = 0;
 	slot->cmnd = NULL;
 	slot->state = NCR_700_SLOT_FREE;
@@ -654,7 +654,7 @@ NCR_700_internal_bus_reset(struct Scsi_Host *host)
 STATIC void
 NCR_700_chip_setup(struct Scsi_Host *host)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 	__u8 min_period;
 	__u8 min_xferp = (hostdata->chip710 ? NCR_710_MIN_XFERP : NCR_700_MIN_XFERP);
@@ -694,11 +694,11 @@ NCR_700_chip_setup(struct Scsi_Host *host)
 	} else {
 		NCR_700_writeb(BURST_LENGTH_8 | hostdata->dmode_extra,
 			       host, DMODE_700_REG);
-		NCR_700_writeb(hostdata->differential ? 
+		NCR_700_writeb(hostdata->differential ?
 			       DIFF : 0, host, CTEST7_REG);
 		if(hostdata->fast) {
 			/* this is for 700-66, does nothing on 700 */
-			NCR_700_writeb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION 
+			NCR_700_writeb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION
 				       | GENERATE_RECEIVE_PARITY, host,
 				       CTEST8_REG);
 		} else {
@@ -731,7 +731,7 @@ NCR_700_chip_setup(struct Scsi_Host *host)
 		NCR_700_writeb(ASYNC_DIV_3_0 | hostdata->dcntl_extra, host, DCNTL_REG);
 		hostdata->sync_clock = hostdata->clock*2;
 		hostdata->sync_clock /= 3;
-		
+
 	} else if(hostdata->clock > 37 && hostdata->clock <= 50) {
 		/* sync divider 1, async divider 2 */
 		DEBUG(("53c700: sync 1 async 2\n"));
@@ -764,7 +764,7 @@ NCR_700_chip_setup(struct Scsi_Host *host)
 STATIC void
 NCR_700_chip_reset(struct Scsi_Host *host)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 	if(hostdata->chip710) {
 		NCR_700_writeb(SOFTWARE_RESET_710, host, ISTAT_REG);
@@ -774,7 +774,7 @@ NCR_700_chip_reset(struct Scsi_Host *host)
 	} else {
 		NCR_700_writeb(SOFTWARE_RESET, host, DCNTL_REG);
 		udelay(100);
-		
+
 		NCR_700_writeb(0, host, DCNTL_REG);
 	}
 
@@ -790,7 +790,7 @@ NCR_700_chip_reset(struct Scsi_Host *host)
  * ACK) so that the routine returns correctly to resume its activity
  * */
 STATIC __u32
-process_extended_message(struct Scsi_Host *host, 
+process_extended_message(struct Scsi_Host *host,
 			 struct NCR_700_Host_Parameters *hostdata,
 			 struct scsi_cmnd *SCp, __u32 dsp, __u32 dsps)
 {
@@ -816,15 +816,15 @@ process_extended_message(struct Scsi_Host *host,
 
 			spi_offset(starget) = offset;
 			spi_period(starget) = period;
-			
+
 			if(NCR_700_is_flag_set(SCp->device, NCR_700_DEV_PRINT_SYNC_NEGOTIATION)) {
 				spi_display_xfer_agreement(starget);
 				NCR_700_clear_flag(SCp->device, NCR_700_DEV_PRINT_SYNC_NEGOTIATION);
 			}
-			
+
 			NCR_700_set_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
 			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
-			
+
 			NCR_700_writeb(NCR_700_get_SXFER(SCp->device),
 				       host, SXFER_REG);
 
@@ -841,7 +841,7 @@ process_extended_message(struct Scsi_Host *host,
 			resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
 		}
 		break;
-	
+
 	case A_WDTR_MSG:
 		printk(KERN_INFO "scsi%d: (%d:%d), Unsolicited WDTR after CMD, Rejecting\n",
 		       host->host_no, pun, lun);
@@ -1121,7 +1121,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 
 			SCp = scsi_host_find_tag(SDp->host, hostdata->msgin[2]);
 			if(unlikely(SCp == NULL)) {
-				printk(KERN_ERR "scsi%d: (%d:%d) no saved request for tag %d\n", 
+				printk(KERN_ERR "scsi%d: (%d:%d) no saved request for tag %d\n",
 				       host->host_no, reselection_id, lun, hostdata->msgin[2]);
 				BUG();
 			}
@@ -1180,7 +1180,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 				       slot->cmnd->cmd_len);
 
 
-			
+
 		}
 	} else if(dsps == A_RESELECTED_DURING_SELECTION) {
 
@@ -1193,10 +1193,10 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 
 		__u8 reselection_id = NCR_700_readb(host, SFBR_REG);
 		struct NCR_700_command_slot *slot;
-		
+
 		/* Take out our own ID */
 		reselection_id &= ~(1<<host->this_id);
-		
+
 		/* I've never seen this happen, so keep this as a printk rather
 		 * than a debug */
 		printk(KERN_INFO "scsi%d: (%d:%d) RESELECTION DURING SELECTION, dsp=%08x[%04x] state=%d, count=%d\n",
@@ -1222,7 +1222,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 			slot->state = NCR_700_SLOT_QUEUED;
 		}
 		hostdata->cmd = NULL;
-		
+
 		if(reselection_id == 0) {
 			if(hostdata->reselection_id == 0xff) {
 				printk(KERN_ERR "scsi%d: Invalid reselection during selection!!\n", host->host_no);
@@ -1233,7 +1233,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 				reselection_id = hostdata->reselection_id;
 			}
 		} else {
-			
+
 			/* convert to real ID */
 			reselection_id = bitmap_to_number(reselection_id);
 		}
@@ -1251,7 +1251,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 		 * a return here will re-run the queued command slot
 		 * that may have been interrupted by the initial selection */
 		DEBUG((" SELECTION COMPLETED\n"));
-	} else if((dsps & 0xfffff0f0) == A_MSG_IN) { 
+	} else if((dsps & 0xfffff0f0) == A_MSG_IN) {
 		resume_offset = process_message(host, hostdata, SCp,
 						dsp, dsps);
 	} else if((dsps &  0xfffff000) == 0) {
@@ -1304,7 +1304,7 @@ process_selection(struct Scsi_Host *host, __u32 dsp)
 
 		/* Take out our own ID */
 		id &= ~(1<<host->this_id);
-		if(id != 0) 
+		if(id != 0)
 			break;
 		udelay(5);
 	}
@@ -1322,7 +1322,7 @@ process_selection(struct Scsi_Host *host, __u32 dsp)
 		struct NCR_700_command_slot *slot =
 			(struct NCR_700_command_slot *)SCp->host_scribble;
 		DEBUG(("  ID %d WARNING: RESELECTION OF BUSY HOST, saving cmd %p, slot %p, addr %x [%04x], resume %x!\n", id, hostdata->cmd, slot, dsp, dsp - hostdata->pScript, resume_offset));
-		
+
 		switch(dsp - hostdata->pScript) {
 		case Ent_Disconnect1:
 		case Ent_Disconnect2:
@@ -1344,7 +1344,7 @@ process_selection(struct Scsi_Host *host, __u32 dsp)
 		case Ent_Finish2:
 			process_script_interrupt(A_GOOD_STATUS_AFTER_STATUS, dsp, SCp, host, hostdata);
 			break;
-			
+
 		default:
 			slot->state = NCR_700_SLOT_QUEUED;
 			break;
@@ -1547,7 +1547,7 @@ NCR_700_intr(int irq, void *dev_id)
 			/* clear all the negotiated parameters */
 			__shost_for_each_device(SDp, host)
 				NCR_700_clear_flag(SDp, ~0);
-			
+
 			/* clear all the slots and their pending commands */
 			for(i = 0; i < NCR_700_COMMAND_SLOTS_PER_HOST; i++) {
 				struct scsi_cmnd *SCp;
@@ -1556,7 +1556,7 @@ NCR_700_intr(int irq, void *dev_id)
 
 				if(slot->state == NCR_700_SLOT_FREE)
 					continue;
-				
+
 				SCp = slot->cmnd;
 				printk(KERN_ERR " failing command because of reset, slot %p, cmnd %p\n",
 				       slot, SCp);
@@ -1620,7 +1620,7 @@ NCR_700_intr(int irq, void *dev_id)
 				data_transfer += residual;
 
 				if(data_transfer != 0) {
-					int count; 
+					int count;
 					__u32 pAddr;
 
 					SGcount--;
@@ -1680,7 +1680,7 @@ NCR_700_intr(int irq, void *dev_id)
 			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
 		}
 
-		
+
 		/* NOTE: selection interrupt processing MUST occur
 		 * after script interrupt processing to correctly cope
 		 * with the case where we process a disconnect and
@@ -1718,7 +1718,7 @@ NCR_700_intr(int irq, void *dev_id)
 		DEBUG(("Attempting to resume at %x\n", resume_offset));
 		NCR_700_clear_fifo(host);
 		NCR_700_writel(resume_offset, host, DSP_REG);
-	} 
+	}
 	/* There is probably a technical no-no about this: If we're a
 	 * shared interrupt and we got this interrupt because the
 	 * other device needs servicing not us, we're still going to
@@ -1732,7 +1732,7 @@ NCR_700_intr(int irq, void *dev_id)
 			 * position we left off */
 			int j = (i + hostdata->saved_slot_position)
 				% NCR_700_COMMAND_SLOTS_PER_HOST;
-			
+
 			if(hostdata->slots[j].state != NCR_700_SLOT_QUEUED)
 				continue;
 			if(NCR_700_start_command(hostdata->slots[j].cmnd)) {
@@ -1752,7 +1752,7 @@ NCR_700_intr(int irq, void *dev_id)
 
 static int NCR_700_queuecommand_lck(struct scsi_cmnd *SCp)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SCp->device->host->hostdata[0];
 	__u32 move_ins;
 	struct NCR_700_command_slot *slot;
@@ -1852,7 +1852,7 @@ static int NCR_700_queuecommand_lck(struct scsi_cmnd *SCp)
 		default:
 			printk(KERN_ERR "53c700: Unknown command for data direction ");
 			scsi_print_command(SCp);
-			
+
 			move_ins = 0;
 			break;
 		case DMA_NONE:
@@ -1937,7 +1937,7 @@ STATIC int
 NCR_700_host_reset(struct scsi_cmnd * SCp)
 {
 	DECLARE_COMPLETION_ONSTACK(complete);
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SCp->device->host->hostdata[0];
 
 	scmd_printk(KERN_INFO, SCp,
@@ -1975,9 +1975,9 @@ STATIC void
 NCR_700_set_period(struct scsi_target *STp, int period)
 {
 	struct Scsi_Host *SHp = dev_to_shost(STp->dev.parent);
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SHp->hostdata[0];
-	
+
 	if(!hostdata->fast)
 		return;
 
@@ -1994,11 +1994,11 @@ STATIC void
 NCR_700_set_offset(struct scsi_target *STp, int offset)
 {
 	struct Scsi_Host *SHp = dev_to_shost(STp->dev.parent);
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SHp->hostdata[0];
 	int max_offset = hostdata->chip710
 		? NCR_710_MAX_OFFSET : NCR_700_MAX_OFFSET;
-	
+
 	if(!hostdata->fast)
 		return;
 
@@ -2031,7 +2031,7 @@ NCR_700_slave_alloc(struct scsi_device *SDp)
 STATIC int
 NCR_700_slave_configure(struct scsi_device *SDp)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SDp->host->hostdata[0];
 
 	/* to do here: allocate memory; build a queue_full list */
@@ -2071,7 +2071,7 @@ NCR_700_show_active_tags(struct device *dev, struct device_attribute *attr, char
 {
 	struct scsi_device *SDp = to_scsi_device(dev);
 
-	return snprintf(buf, 20, "%d\n", NCR_700_get_depth(SDp));
+	return sysfs_emit(buf, "%d\n", NCR_700_get_depth(SDp));
 }
 
 static struct device_attribute NCR_700_active_tags_attr = {
-- 
2.43.0.275.g3460e3d667-goog


