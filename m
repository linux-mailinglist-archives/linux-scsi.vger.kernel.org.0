Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB404BAEA8
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Feb 2022 01:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiBRApv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Feb 2022 19:45:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiBRApu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Feb 2022 19:45:50 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B7FFCB54
        for <linux-scsi@vger.kernel.org>; Thu, 17 Feb 2022 16:45:32 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A49765C01B6;
        Thu, 17 Feb 2022 19:45:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 17 Feb 2022 19:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AJzo+Soxnomq1YyFl
        wFJxQMNa0N+wuxo4DDqgeZPjXc=; b=MJNgs1kndIa0f1uYZqaSh+GaSk+VVXE6D
        JuQPAz/WJ3oGX33YVAdqN503JgQ69lBnuDAf6UvSPK8EAUFtov4l+6mX1eLR4xUX
        yx6aJ3uQs+VHcAsZEeKuqbdPwq5ixQm6xX8D3084eSMdms5GgkBfomqhHjLTuapf
        AZILIe+TwnFuqm3F3iHrfk8Og59AfAKGOud3dtgECgHwHMhw/m0BirH/hGEz2MoA
        OFpOT/t+JuUXe4sayjY3j/Qnve9T6Zm6MOFSfBZNRP/H0ukIhyngOm2zmxxLdgBm
        0VntBTrgqSvSiRFhGiGjjuQGZAHhoV7jguikZtFnyuOZecO2V6gXQ==
X-ME-Sender: <xms:J-wOYg7CmE91accFAHQwb43mfBL-JL-_xXarD1hkwBl8nmX9MSRvgw>
    <xme:J-wOYh5QQXMF1ObPA87gqc9jozMtoATsuG2a04MPJrEOY5QFpkG8ilOouE7wXoKp7
    Fg9b9ACaGiNUMdZCvk>
X-ME-Received: <xmr:J-wOYvdo0pcVbAUgV-S12sQO7xNc9aZJKAxxVCpZtTx3owAjiZfnBEXa87xi63IzaPOFqPhsS1Xho1GfvyLRnLYGXW0haAt50DU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeelgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveffteeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:KOwOYlIHfOmPvZpRn5E6Fyk8fBrhrZheOTNg1MSUjL9B1Uf7lNdVLQ>
    <xmx:KOwOYkKOPvC4prJIjx3USujwW6evNXsK-TaL_vWUCS9enSYdciCC1Q>
    <xmx:KOwOYmx6MGC03D-degKCHG1qmz-Eoqy1stGEStH_dGdT-dbRBqiGOg>
    <xmx:KewOYrVhwBz1u8jWQnTLnCvce3s6wtlHm91KP1faeFbInX7ULae3QA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 19:45:24 -0500 (EST)
Date:   Fri, 18 Feb 2022 11:45:34 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Bart Van Assche <bvanassche@acm.org>
cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Ondrej Zary <linux@zary.sk>
Subject: Re: [PATCH v4 00/50] Remove the SCSI pointer from struct scsi_cmnd
In-Reply-To: <20220216210233.28774-1-bvanassche@acm.org>
Message-ID: <cacca1db-be52-d816-b0b9-e625438ebce@linux-m68k.org>
References: <20220216210233.28774-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

On Wed, 16 Feb 2022, Bart Van Assche wrote:

> ...
>   scsi: NCR5380: Introduce the NCR5380_cmd_priv() function
>   scsi: NCR5380: Move the SCSI pointer to private command data

Please replace those two patches with the one below. This one is better 
because it adds less source code, adds less scsi_cmnd private data, 
updates an overlooked comment, avoids anything like "struct scsi_pointer" 
and doesn't shadow any local variables.

From: Finn Thain <fthain@linux-m68k.org>
Subject: scsi: NCR5380: Add SCp members to struct NCR5380_cmd

This is necessary for the eventual removal of SCp from struct scsi_cmnd.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Ondrej Zary <linux@zary.sk>
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/scsi/NCR5380.c    | 94 +++++++++++++++++++--------------------
 drivers/scsi/NCR5380.h    | 11 +++++
 drivers/scsi/atari_scsi.c |  4 +-
 drivers/scsi/g_NCR5380.c  |  4 +-
 drivers/scsi/mac_scsi.c   |  7 +--
 drivers/scsi/sun3_scsi.c  |  2 +-
 6 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 55af3e245a92..dece7d9eb4d3 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -84,8 +84,7 @@
  * On command termination, the done function will be called as
  * appropriate.
  *
- * SCSI pointers are maintained in the SCp field of SCSI command
- * structures, being initialized after the command is connected
+ * The command data pointer is initialized after the command is connected
  * in NCR5380_select, and set as appropriate in NCR5380_information_transfer.
  * Note that in violation of the standard, an implicit SAVE POINTERS operation
  * is done, since some BROKEN disks fail to issue an explicit SAVE POINTERS.
@@ -145,40 +144,38 @@ static void bus_reset_cleanup(struct Scsi_Host *);
 
 static inline void initialize_SCp(struct scsi_cmnd *cmd)
 {
-	/*
-	 * Initialize the Scsi Pointer field so that all of the commands in the
-	 * various queues are valid.
-	 */
+	struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(cmd);
 
 	if (scsi_bufflen(cmd)) {
-		cmd->SCp.buffer = scsi_sglist(cmd);
-		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
-		cmd->SCp.this_residual = cmd->SCp.buffer->length;
+		ncmd->buffer = scsi_sglist(cmd);
+		ncmd->ptr = sg_virt(ncmd->buffer);
+		ncmd->this_residual = ncmd->buffer->length;
 	} else {
-		cmd->SCp.buffer = NULL;
-		cmd->SCp.ptr = NULL;
-		cmd->SCp.this_residual = 0;
+		ncmd->buffer = NULL;
+		ncmd->ptr = NULL;
+		ncmd->this_residual = 0;
 	}
 
-	cmd->SCp.Status = 0;
-	cmd->SCp.Message = 0;
+	ncmd->status = 0;
+	ncmd->message = 0;
 }
 
-static inline void advance_sg_buffer(struct scsi_cmnd *cmd)
+static inline void advance_sg_buffer(struct NCR5380_cmd *ncmd)
 {
-	struct scatterlist *s = cmd->SCp.buffer;
+	struct scatterlist *s = ncmd->buffer;
 
-	if (!cmd->SCp.this_residual && s && !sg_is_last(s)) {
-		cmd->SCp.buffer = sg_next(s);
-		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
-		cmd->SCp.this_residual = cmd->SCp.buffer->length;
+	if (!ncmd->this_residual && s && !sg_is_last(s)) {
+		ncmd->buffer = sg_next(s);
+		ncmd->ptr = sg_virt(ncmd->buffer);
+		ncmd->this_residual = ncmd->buffer->length;
 	}
 }
 
 static inline void set_resid_from_SCp(struct scsi_cmnd *cmd)
 {
-	int resid = cmd->SCp.this_residual;
-	struct scatterlist *s = cmd->SCp.buffer;
+	struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(cmd);
+	int resid = ncmd->this_residual;
+	struct scatterlist *s = ncmd->buffer;
 
 	if (s)
 		while (!sg_is_last(s)) {
@@ -564,7 +561,7 @@ static int NCR5380_queue_command(struct Scsi_Host *instance,
                                  struct scsi_cmnd *cmd)
 {
 	struct NCR5380_hostdata *hostdata = shost_priv(instance);
-	struct NCR5380_cmd *ncmd = scsi_cmd_priv(cmd);
+	struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(cmd);
 	unsigned long flags;
 
 #if (NDEBUG & NDEBUG_NO_WRITE)
@@ -672,7 +669,7 @@ static struct scsi_cmnd *dequeue_next_cmd(struct Scsi_Host *instance)
 static void requeue_cmd(struct Scsi_Host *instance, struct scsi_cmnd *cmd)
 {
 	struct NCR5380_hostdata *hostdata = shost_priv(instance);
-	struct NCR5380_cmd *ncmd = scsi_cmd_priv(cmd);
+	struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(cmd);
 
 	if (hostdata->sensing == cmd) {
 		scsi_eh_restore_cmnd(cmd, &hostdata->ses);
@@ -757,6 +754,7 @@ static void NCR5380_main(struct work_struct *work)
 static void NCR5380_dma_complete(struct Scsi_Host *instance)
 {
 	struct NCR5380_hostdata *hostdata = shost_priv(instance);
+	struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(hostdata->connected);
 	int transferred;
 	unsigned char **data;
 	int *count;
@@ -764,7 +762,7 @@ static void NCR5380_dma_complete(struct Scsi_Host *instance)
 	unsigned char p;
 
 	if (hostdata->read_overruns) {
-		p = hostdata->connected->SCp.phase;
+		p = ncmd->phase;
 		if (p & SR_IO) {
 			udelay(10);
 			if ((NCR5380_read(BUS_AND_STATUS_REG) &
@@ -801,8 +799,8 @@ static void NCR5380_dma_complete(struct Scsi_Host *instance)
 	transferred = hostdata->dma_len - NCR5380_dma_residual(hostdata);
 	hostdata->dma_len = 0;
 
-	data = (unsigned char **)&hostdata->connected->SCp.ptr;
-	count = &hostdata->connected->SCp.this_residual;
+	data = (unsigned char **)&ncmd->ptr;
+	count = &ncmd->this_residual;
 	*data += transferred;
 	*count -= transferred;
 
@@ -1498,7 +1496,7 @@ static int NCR5380_transfer_dma(struct Scsi_Host *instance,
 		return -1;
 	}
 
-	hostdata->connected->SCp.phase = p;
+	NCR5380_to_ncmd(hostdata->connected)->phase = p;
 
 	if (p & SR_IO) {
 		if (hostdata->read_overruns)
@@ -1690,7 +1688,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 #endif
 
 	while ((cmd = hostdata->connected)) {
-		struct NCR5380_cmd *ncmd = scsi_cmd_priv(cmd);
+		struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(cmd);
 
 		tmp = NCR5380_read(STATUS_REG);
 		/* We only have a valid SCSI phase when REQ is asserted */
@@ -1705,17 +1703,17 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 			    sun3_dma_setup_done != cmd) {
 				int count;
 
-				advance_sg_buffer(cmd);
+				advance_sg_buffer(ncmd);
 
 				count = sun3scsi_dma_xfer_len(hostdata, cmd);
 
 				if (count > 0) {
 					if (cmd->sc_data_direction == DMA_TO_DEVICE)
 						sun3scsi_dma_send_setup(hostdata,
-						                        cmd->SCp.ptr, count);
+									ncmd->ptr, count);
 					else
 						sun3scsi_dma_recv_setup(hostdata,
-						                        cmd->SCp.ptr, count);
+									ncmd->ptr, count);
 					sun3_dma_setup_done = cmd;
 				}
 #ifdef SUN3_SCSI_VME
@@ -1755,11 +1753,11 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				 * scatter-gather list, move onto the next one.
 				 */
 
-				advance_sg_buffer(cmd);
+				advance_sg_buffer(ncmd);
 				dsprintk(NDEBUG_INFORMATION, instance,
 					"this residual %d, sg ents %d\n",
-					cmd->SCp.this_residual,
-					sg_nents(cmd->SCp.buffer));
+					ncmd->this_residual,
+					sg_nents(ncmd->buffer));
 
 				/*
 				 * The preferred transfer method is going to be
@@ -1778,7 +1776,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				if (transfersize > 0) {
 					len = transfersize;
 					if (NCR5380_transfer_dma(instance, &phase,
-					    &len, (unsigned char **)&cmd->SCp.ptr)) {
+					    &len, (unsigned char **)&ncmd->ptr)) {
 						/*
 						 * If the watchdog timer fires, all future
 						 * accesses to this device will use the
@@ -1794,13 +1792,13 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					/* Transfer a small chunk so that the
 					 * irq mode lock is not held too long.
 					 */
-					transfersize = min(cmd->SCp.this_residual,
+					transfersize = min(ncmd->this_residual,
 							   NCR5380_PIO_CHUNK_SIZE);
 					len = transfersize;
 					NCR5380_transfer_pio(instance, &phase, &len,
-					                     (unsigned char **)&cmd->SCp.ptr,
+							     (unsigned char **)&ncmd->ptr,
 							     0);
-					cmd->SCp.this_residual -= transfersize - len;
+					ncmd->this_residual -= transfersize - len;
 				}
 #ifdef CONFIG_SUN3
 				if (sun3_dma_setup_done == cmd)
@@ -1811,7 +1809,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				len = 1;
 				data = &tmp;
 				NCR5380_transfer_pio(instance, &phase, &len, &data, 0);
-				cmd->SCp.Message = tmp;
+				ncmd->message = tmp;
 
 				switch (tmp) {
 				case ABORT:
@@ -1828,15 +1826,15 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 					hostdata->connected = NULL;
 					hostdata->busy[scmd_id(cmd)] &= ~(1 << cmd->device->lun);
 
-					set_status_byte(cmd, cmd->SCp.Status);
+					set_status_byte(cmd, ncmd->status);
 
 					set_resid_from_SCp(cmd);
 
 					if (cmd->cmnd[0] == REQUEST_SENSE)
 						complete_cmd(instance, cmd);
 					else {
-						if (cmd->SCp.Status == SAM_STAT_CHECK_CONDITION ||
-						    cmd->SCp.Status == SAM_STAT_COMMAND_TERMINATED) {
+						if (ncmd->status == SAM_STAT_CHECK_CONDITION ||
+						    ncmd->status == SAM_STAT_COMMAND_TERMINATED) {
 							dsprintk(NDEBUG_QUEUES, instance, "autosense: adding cmd %p to tail of autosense queue\n",
 							         cmd);
 							list_add_tail(&ncmd->list,
@@ -2000,7 +1998,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				len = 1;
 				data = &tmp;
 				NCR5380_transfer_pio(instance, &phase, &len, &data, 0);
-				cmd->SCp.Status = tmp;
+				ncmd->status = tmp;
 				break;
 			default:
 				shost_printk(KERN_ERR, instance, "unknown phase\n");
@@ -2153,17 +2151,17 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 	if (sun3_dma_setup_done != tmp) {
 		int count;
 
-		advance_sg_buffer(tmp);
+		advance_sg_buffer(ncmd);
 
 		count = sun3scsi_dma_xfer_len(hostdata, tmp);
 
 		if (count > 0) {
 			if (tmp->sc_data_direction == DMA_TO_DEVICE)
 				sun3scsi_dma_send_setup(hostdata,
-				                        tmp->SCp.ptr, count);
+							ncmd->ptr, count);
 			else
 				sun3scsi_dma_recv_setup(hostdata,
-				                        tmp->SCp.ptr, count);
+							ncmd->ptr, count);
 			sun3_dma_setup_done = tmp;
 		}
 	}
@@ -2206,7 +2204,7 @@ static bool list_del_cmd(struct list_head *haystack,
                          struct scsi_cmnd *needle)
 {
 	if (list_find_cmd(haystack, needle)) {
-		struct NCR5380_cmd *ncmd = scsi_cmd_priv(needle);
+		struct NCR5380_cmd *ncmd = NCR5380_to_ncmd(needle);
 
 		list_del(&ncmd->list);
 		return true;
diff --git a/drivers/scsi/NCR5380.h b/drivers/scsi/NCR5380.h
index 845bd2423e66..8dc2be4212dc 100644
--- a/drivers/scsi/NCR5380.h
+++ b/drivers/scsi/NCR5380.h
@@ -227,6 +227,12 @@ struct NCR5380_hostdata {
 };
 
 struct NCR5380_cmd {
+	char *ptr;
+	int this_residual;
+	struct scatterlist *buffer;
+	int status;
+	int message;
+	int phase;
 	struct list_head list;
 };
 
@@ -240,6 +246,11 @@ static inline struct scsi_cmnd *NCR5380_to_scmd(struct NCR5380_cmd *ncmd_ptr)
 	return ((struct scsi_cmnd *)ncmd_ptr) - 1;
 }
 
+static inline struct NCR5380_cmd *NCR5380_to_ncmd(struct scsi_cmnd *cmd)
+{
+	return scsi_cmd_priv(cmd);
+}
+
 #ifndef NDEBUG
 #define NDEBUG (0)
 #endif
diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
index e9d0d99abc86..d401cf27113a 100644
--- a/drivers/scsi/atari_scsi.c
+++ b/drivers/scsi/atari_scsi.c
@@ -538,7 +538,7 @@ static int falcon_classify_cmd(struct scsi_cmnd *cmd)
 static int atari_scsi_dma_xfer_len(struct NCR5380_hostdata *hostdata,
                                    struct scsi_cmnd *cmd)
 {
-	int wanted_len = cmd->SCp.this_residual;
+	int wanted_len = NCR5380_to_ncmd(cmd)->this_residual;
 	int possible_len, limit;
 
 	if (wanted_len < DMA_MIN_SIZE)
@@ -610,7 +610,7 @@ static int atari_scsi_dma_xfer_len(struct NCR5380_hostdata *hostdata,
 	}
 
 	/* Last step: apply the hard limit on DMA transfers */
-	limit = (atari_dma_buffer && !STRAM_ADDR(virt_to_phys(cmd->SCp.ptr))) ?
+	limit = (atari_dma_buffer && !STRAM_ADDR(virt_to_phys(NCR5380_to_ncmd(cmd)->ptr))) ?
 		    STRAM_BUFFER_SIZE : 255*512;
 	if (possible_len > limit)
 		possible_len = limit;
diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
index 5923f86a384e..0c768e7d06b9 100644
--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -663,7 +663,7 @@ static inline int generic_NCR5380_psend(struct NCR5380_hostdata *hostdata,
 static int generic_NCR5380_dma_xfer_len(struct NCR5380_hostdata *hostdata,
                                         struct scsi_cmnd *cmd)
 {
-	int transfersize = cmd->SCp.this_residual;
+	int transfersize = NCR5380_to_ncmd(cmd)->this_residual;
 
 	if (hostdata->flags & FLAG_NO_PSEUDO_DMA)
 		return 0;
@@ -675,7 +675,7 @@ static int generic_NCR5380_dma_xfer_len(struct NCR5380_hostdata *hostdata,
 	/* Limit PDMA send to 512 B to avoid random corruption on DTC3181E */
 	if (hostdata->board == BOARD_DTC3181E &&
 	    cmd->sc_data_direction == DMA_TO_DEVICE)
-		transfersize = min(cmd->SCp.this_residual, 512);
+		transfersize = min(transfersize, 512);
 
 	return min(transfersize, DMA_MAX_SIZE);
 }
diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 71d493a0bb43..2e511697fce3 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -404,11 +404,12 @@ static inline int macscsi_pwrite(struct NCR5380_hostdata *hostdata,
 static int macscsi_dma_xfer_len(struct NCR5380_hostdata *hostdata,
                                 struct scsi_cmnd *cmd)
 {
-	if (hostdata->flags & FLAG_NO_PSEUDO_DMA ||
-	    cmd->SCp.this_residual < setup_use_pdma)
+	int resid = NCR5380_to_ncmd(cmd)->this_residual;
+
+	if (hostdata->flags & FLAG_NO_PSEUDO_DMA || resid < setup_use_pdma)
 		return 0;
 
-	return cmd->SCp.this_residual;
+	return resid;
 }
 
 static int macscsi_dma_residual(struct NCR5380_hostdata *hostdata)
diff --git a/drivers/scsi/sun3_scsi.c b/drivers/scsi/sun3_scsi.c
index 82a253270c3b..abf229b847a1 100644
--- a/drivers/scsi/sun3_scsi.c
+++ b/drivers/scsi/sun3_scsi.c
@@ -334,7 +334,7 @@ static int sun3scsi_dma_residual(struct NCR5380_hostdata *hostdata)
 static int sun3scsi_dma_xfer_len(struct NCR5380_hostdata *hostdata,
                                  struct scsi_cmnd *cmd)
 {
-	int wanted_len = cmd->SCp.this_residual;
+	int wanted_len = NCR5380_to_ncmd(cmd)->this_residual;
 
 	if (wanted_len < DMA_MIN_SIZE || blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
 		return 0;
-- 
2.32.0
