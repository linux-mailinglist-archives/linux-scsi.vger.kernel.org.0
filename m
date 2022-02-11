Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54864B3089
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Feb 2022 23:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354122AbiBKWdo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Feb 2022 17:33:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354115AbiBKWdm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 11 Feb 2022 17:33:42 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B9D53
        for <linux-scsi@vger.kernel.org>; Fri, 11 Feb 2022 14:33:39 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id a39so17827952pfx.7
        for <linux-scsi@vger.kernel.org>; Fri, 11 Feb 2022 14:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M606XAph7ghdXmUFxKYRv7kzlFluM4QcK7HymImpOY4=;
        b=ENm2ZC6j4EBKoWlKX0+zJJeCnMdNFIoirxLa+Yke0lmwmgxLRpmyI+NWSrluCRM5fg
         ANL+PDgLl1kwqSEed+vSWpXRwvxniT03ylo98YKuYCtMDlRJ0SlgDzGtoLzW5DTFJodm
         kzf/7YFWRWX/MyoblP3Gdot2eSGHezQLGQL1gBy7DW30SmZIBQ1Y0W2kbi6Qf4YIi1pB
         h/szfR17+8PA3k44OgxMlGE9joWA2/gcRmOYEwUmTZnmP3Yh2UUAsRBRmKo++pUb1m6x
         SlBDV6XPKr977j5Qk/GP9oY4QH3H9pgN3AIHE+1/Btzgwc+mHDz9lD/0NHrOCHdVIoF2
         x0fw==
X-Gm-Message-State: AOAM530JAQbzlIg5tFVyaPQspMx5AtzuYSDbltYEXrGc0rHxwIcMGwOC
        6LlLtzwR3iJWTmue+dyqvF0=
X-Google-Smtp-Source: ABdhPJzyj0eh0kfh+bKWvFRy7/xBg1iYrq5bekdWWUkAI1nZpDbt+62FHoqYIlaRCtgQeiUwO70oGA==
X-Received: by 2002:aa7:9888:: with SMTP id r8mr3790103pfl.24.1644618818720;
        Fri, 11 Feb 2022 14:33:38 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id n13sm6296733pjq.13.2022.02.11.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 14:33:38 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 16/48] scsi: aha152x: Move the SCSI pointer to private command data
Date:   Fri, 11 Feb 2022 14:32:15 -0800
Message-Id: <20220211223247.14369-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211223247.14369-1-bvanassche@acm.org>
References: <20220211223247.14369-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set .cmd_size in the SCSI host template instead of using the SCSI pointer
from struct scsi_cmnd. This patch prepares for removal of the SCSI pointer
from struct scsi_cmnd.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aha152x.c | 259 ++++++++++++++++++++++++-----------------
 1 file changed, 155 insertions(+), 104 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 901b78e8ffe6..34b2378075fd 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -316,6 +316,17 @@ enum {
 	check_condition = 0x0800,	/* requesting sense after CHECK CONDITION */
 };
 
+struct aha152x_cmd_priv {
+	struct scsi_pointer scsi_pointer;
+};
+
+static struct scsi_pointer *aha152x_scsi_pointer(struct scsi_cmnd *cmd)
+{
+	struct aha152x_cmd_priv *acmd = scsi_cmd_priv(cmd);
+
+	return &acmd->scsi_pointer;
+}
+
 MODULE_AUTHOR("Jürgen Fischer");
 MODULE_DESCRIPTION(AHA152X_REVID);
 MODULE_LICENSE("GPL");
@@ -879,14 +890,17 @@ void aha152x_release(struct Scsi_Host *shpnt)
 static int setup_expected_interrupts(struct Scsi_Host *shpnt)
 {
 	if(CURRENT_SC) {
-		CURRENT_SC->SCp.phase |= 1 << 16;
+		struct scsi_pointer *scsi_pointer =
+			aha152x_scsi_pointer(CURRENT_SC);
 
-		if(CURRENT_SC->SCp.phase & selecting) {
+		scsi_pointer->phase |= 1 << 16;
+
+		if (scsi_pointer->phase & selecting) {
 			SETPORT(SSTAT1, SELTO);
 			SETPORT(SIMODE0, ENSELDO | (DISCONNECTED_SC ? ENSELDI : 0));
 			SETPORT(SIMODE1, ENSELTIMO);
 		} else {
-			SETPORT(SIMODE0, (CURRENT_SC->SCp.phase & spiordy) ? ENSPIORDY : 0);
+			SETPORT(SIMODE0, (scsi_pointer->phase & spiordy) ? ENSPIORDY : 0);
 			SETPORT(SIMODE1, ENPHASEMIS | ENSCSIRST | ENSCSIPERR | ENBUSFREE);
 		}
 	} else if(STATE==seldi) {
@@ -910,16 +924,17 @@ static int setup_expected_interrupts(struct Scsi_Host *shpnt)
 static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 				  struct completion *complete, int phase)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(SCpnt);
 	struct Scsi_Host *shpnt = SCpnt->device->host;
 	unsigned long flags;
 
-	SCpnt->SCp.phase	= not_issued | phase;
-	SCpnt->SCp.Status	= 0x1; /* Ilegal status by SCSI standard */
-	SCpnt->SCp.Message	= 0;
-	SCpnt->SCp.have_data_in	= 0;
-	SCpnt->SCp.sent_command	= 0;
+	scsi_pointer->phase	   = not_issued | phase;
+	scsi_pointer->Status	   = 0x1; /* Ilegal status by SCSI standard */
+	scsi_pointer->Message	   = 0;
+	scsi_pointer->have_data_in = 0;
+	scsi_pointer->sent_command = 0;
 
-	if(SCpnt->SCp.phase & (resetting|check_condition)) {
+	if (scsi_pointer->phase & (resetting | check_condition)) {
 		if (!SCpnt->host_scribble || SCSEM(SCpnt) || SCNEXT(SCpnt)) {
 			scmd_printk(KERN_ERR, SCpnt, "cannot reuse command\n");
 			return FAILED;
@@ -942,15 +957,15 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 	   SCp.phase            : current state of the command */
 
 	if ((phase & resetting) || !scsi_sglist(SCpnt)) {
-		SCpnt->SCp.ptr           = NULL;
-		SCpnt->SCp.this_residual = 0;
+		scsi_pointer->ptr           = NULL;
+		scsi_pointer->this_residual = 0;
 		scsi_set_resid(SCpnt, 0);
-		SCpnt->SCp.buffer           = NULL;
+		scsi_pointer->buffer        = NULL;
 	} else {
 		scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
-		SCpnt->SCp.buffer           = scsi_sglist(SCpnt);
-		SCpnt->SCp.ptr              = SG_ADDRESS(SCpnt->SCp.buffer);
-		SCpnt->SCp.this_residual    = SCpnt->SCp.buffer->length;
+		scsi_pointer->buffer        = scsi_sglist(SCpnt);
+		scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
+		scsi_pointer->this_residual = scsi_pointer->buffer->length;
 	}
 
 	DO_LOCK(flags);
@@ -1000,7 +1015,7 @@ static void reset_done(struct scsi_cmnd *SCpnt)
 
 static void aha152x_scsi_done(struct scsi_cmnd *SCpnt)
 {
-	if (SCpnt->SCp.phase & resetting)
+	if (aha152x_scsi_pointer(SCpnt)->phase & resetting)
 		reset_done(SCpnt);
 	else
 		scsi_done(SCpnt);
@@ -1086,7 +1101,7 @@ static int aha152x_device_reset(struct scsi_cmnd * SCpnt)
 
 	DO_LOCK(flags);
 
-	if(SCpnt->SCp.phase & resetted) {
+	if (aha152x_scsi_pointer(SCpnt)->phase & resetted) {
 		HOSTDATA(shpnt)->commands--;
 		if (!HOSTDATA(shpnt)->commands)
 			SETPORT(PORTA, 0);
@@ -1380,28 +1395,31 @@ static void busfree_run(struct Scsi_Host *shpnt)
 	SETPORT(SSTAT1, CLRBUSFREE);
 
 	if(CURRENT_SC) {
+		struct scsi_pointer *scsi_pointer =
+			aha152x_scsi_pointer(CURRENT_SC);
+
 #if defined(AHA152X_STAT)
 		action++;
 #endif
-		CURRENT_SC->SCp.phase &= ~syncneg;
+		scsi_pointer->phase &= ~syncneg;
 
-		if(CURRENT_SC->SCp.phase & completed) {
+		if (scsi_pointer->phase & completed) {
 			/* target sent COMMAND COMPLETE */
-			done(shpnt, CURRENT_SC->SCp.Status, DID_OK);
+			done(shpnt, scsi_pointer->Status, DID_OK);
 
-		} else if(CURRENT_SC->SCp.phase & aborted) {
-			done(shpnt, CURRENT_SC->SCp.Status, DID_ABORT);
+		} else if (scsi_pointer->phase & aborted) {
+			done(shpnt, scsi_pointer->Status, DID_ABORT);
 
-		} else if(CURRENT_SC->SCp.phase & resetted) {
-			done(shpnt, CURRENT_SC->SCp.Status, DID_RESET);
+		} else if (scsi_pointer->phase & resetted) {
+			done(shpnt, scsi_pointer->Status, DID_RESET);
 
-		} else if(CURRENT_SC->SCp.phase & disconnected) {
+		} else if (scsi_pointer->phase & disconnected) {
 			/* target sent DISCONNECT */
 #if defined(AHA152X_STAT)
 			HOSTDATA(shpnt)->disconnections++;
 #endif
 			append_SC(&DISCONNECTED_SC, CURRENT_SC);
-			CURRENT_SC->SCp.phase |= 1 << 16;
+			scsi_pointer->phase |= 1 << 16;
 			CURRENT_SC = NULL;
 
 		} else {
@@ -1420,23 +1438,24 @@ static void busfree_run(struct Scsi_Host *shpnt)
 		action++;
 #endif
 
-		if(DONE_SC->SCp.phase & check_condition) {
+		if (aha152x_scsi_pointer(DONE_SC)->phase & check_condition) {
 			struct scsi_cmnd *cmd = HOSTDATA(shpnt)->done_SC;
 			struct aha152x_scdata *sc = SCDATA(cmd);
 
 			scsi_eh_restore_cmnd(cmd, &sc->ses);
 
-			cmd->SCp.Status = SAM_STAT_CHECK_CONDITION;
+			aha152x_scsi_pointer(cmd)->Status = SAM_STAT_CHECK_CONDITION;
 
 			HOSTDATA(shpnt)->commands--;
 			if (!HOSTDATA(shpnt)->commands)
 				SETPORT(PORTA, 0);	/* turn led off */
-		} else if(DONE_SC->SCp.Status==SAM_STAT_CHECK_CONDITION) {
+		} else if (aha152x_scsi_pointer(DONE_SC)->Status ==
+			   SAM_STAT_CHECK_CONDITION) {
 #if defined(AHA152X_STAT)
 			HOSTDATA(shpnt)->busfree_with_check_condition++;
 #endif
 
-			if(!(DONE_SC->SCp.phase & not_issued)) {
+			if(!(aha152x_scsi_pointer(DONE_SC)->phase & not_issued)) {
 				struct aha152x_scdata *sc;
 				struct scsi_cmnd *ptr = DONE_SC;
 				DONE_SC=NULL;
@@ -1461,7 +1480,7 @@ static void busfree_run(struct Scsi_Host *shpnt)
 			if (!HOSTDATA(shpnt)->commands)
 				SETPORT(PORTA, 0);	/* turn led off */
 
-			if (!(ptr->SCp.phase & resetting)) {
+			if (!(aha152x_scsi_pointer(ptr)->phase & resetting)) {
 				kfree(ptr->host_scribble);
 				ptr->host_scribble=NULL;
 			}
@@ -1484,10 +1503,13 @@ static void busfree_run(struct Scsi_Host *shpnt)
 	DO_UNLOCK(flags);
 
 	if(CURRENT_SC) {
+		struct scsi_pointer *scsi_pointer =
+			aha152x_scsi_pointer(CURRENT_SC);
+
 #if defined(AHA152X_STAT)
 		action++;
 #endif
-		CURRENT_SC->SCp.phase |= selecting;
+		scsi_pointer->phase |= selecting;
 
 		/* clear selection timeout */
 		SETPORT(SSTAT1, SELTO);
@@ -1515,11 +1537,13 @@ static void busfree_run(struct Scsi_Host *shpnt)
  */
 static void seldo_run(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+
 	SETPORT(SCSISIG, 0);
 	SETPORT(SSTAT1, CLRBUSFREE);
 	SETPORT(SSTAT1, CLRPHASECHG);
 
-	CURRENT_SC->SCp.phase &= ~(selecting|not_issued);
+	scsi_pointer->phase &= ~(selecting | not_issued);
 
 	SETPORT(SCSISEQ, 0);
 
@@ -1534,12 +1558,12 @@ static void seldo_run(struct Scsi_Host *shpnt)
 
 	ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 
-	if (CURRENT_SC->SCp.phase & aborting) {
+	if (scsi_pointer->phase & aborting) {
 		ADDMSGO(ABORT);
-	} else if (CURRENT_SC->SCp.phase & resetting) {
+	} else if (scsi_pointer->phase & resetting) {
 		ADDMSGO(BUS_DEVICE_RESET);
 	} else if (SYNCNEG==0 && SYNCHRONOUS) {
-		CURRENT_SC->SCp.phase |= syncneg;
+		scsi_pointer->phase |= syncneg;
 		MSGOLEN += spi_populate_sync_msg(&MSGO(MSGOLEN), 50, 8);
 		SYNCNEG=1;		/* negotiation in progress */
 	}
@@ -1554,15 +1578,17 @@ static void seldo_run(struct Scsi_Host *shpnt)
  */
 static void selto_run(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+
 	SETPORT(SCSISEQ, 0);
 	SETPORT(SSTAT1, CLRSELTIMO);
 
 	if (!CURRENT_SC)
 		return;
 
-	CURRENT_SC->SCp.phase &= ~selecting;
+	scsi_pointer->phase &= ~selecting;
 
-	if (CURRENT_SC->SCp.phase & aborted)
+	if (scsi_pointer->phase & aborted)
 		done(shpnt, SAM_STAT_GOOD, DID_ABORT);
 	else if (TESTLO(SSTAT0, SELINGO))
 		done(shpnt, SAM_STAT_GOOD, DID_BUS_BUSY);
@@ -1590,7 +1616,10 @@ static void seldi_run(struct Scsi_Host *shpnt)
 	SETPORT(SSTAT1, CLRPHASECHG);
 
 	if(CURRENT_SC) {
-		if(!(CURRENT_SC->SCp.phase & not_issued))
+		struct scsi_pointer *scsi_pointer =
+			aha152x_scsi_pointer(CURRENT_SC);
+
+		if (!(scsi_pointer->phase & not_issued))
 			scmd_printk(KERN_ERR, CURRENT_SC,
 				    "command should not have been issued yet\n");
 
@@ -1647,6 +1676,7 @@ static void seldi_run(struct Scsi_Host *shpnt)
 static void msgi_run(struct Scsi_Host *shpnt)
 {
 	for(;;) {
+		struct scsi_pointer *scsi_pointer;
 		int sstat1 = GETPORT(SSTAT1);
 
 		if(sstat1 & (PHASECHG|PHASEMIS|BUSFREE) || !(sstat1 & REQINIT))
@@ -1684,8 +1714,9 @@ static void msgi_run(struct Scsi_Host *shpnt)
 				continue;
 			}
 
-			CURRENT_SC->SCp.Message = MSGI(0);
-			CURRENT_SC->SCp.phase &= ~disconnected;
+			scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+			scsi_pointer->Message = MSGI(0);
+			scsi_pointer->phase &= ~disconnected;
 
 			MSGILEN=0;
 
@@ -1693,7 +1724,8 @@ static void msgi_run(struct Scsi_Host *shpnt)
 			continue;
 		}
 
-		CURRENT_SC->SCp.Message = MSGI(0);
+		scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+		scsi_pointer->Message = MSGI(0);
 
 		switch (MSGI(0)) {
 		case DISCONNECT:
@@ -1701,11 +1733,11 @@ static void msgi_run(struct Scsi_Host *shpnt)
 				scmd_printk(KERN_WARNING, CURRENT_SC,
 					    "target was not allowed to disconnect\n");
 
-			CURRENT_SC->SCp.phase |= disconnected;
+			scsi_pointer->phase |= disconnected;
 			break;
 
 		case COMMAND_COMPLETE:
-			CURRENT_SC->SCp.phase |= completed;
+			scsi_pointer->phase |= completed;
 			break;
 
 		case MESSAGE_REJECT:
@@ -1835,8 +1867,11 @@ static void msgi_end(struct Scsi_Host *shpnt)
  */
 static void msgo_init(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+
 	if(MSGOLEN==0) {
-		if((CURRENT_SC->SCp.phase & syncneg) && SYNCNEG==2 && SYNCRATE==0) {
+		if ((scsi_pointer->phase & syncneg) && SYNCNEG==2 &&
+		    SYNCRATE==0) {
 			ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 		} else {
 			scmd_printk(KERN_INFO, CURRENT_SC,
@@ -1853,6 +1888,8 @@ static void msgo_init(struct Scsi_Host *shpnt)
  */
 static void msgo_run(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+
 	while(MSGO_I<MSGOLEN) {
 		if (TESTLO(SSTAT0, SPIORDY))
 			return;
@@ -1864,13 +1901,13 @@ static void msgo_run(struct Scsi_Host *shpnt)
 
 
 		if (MSGO(MSGO_I) & IDENTIFY_BASE)
-			CURRENT_SC->SCp.phase |= identified;
+			scsi_pointer->phase |= identified;
 
 		if (MSGO(MSGO_I)==ABORT)
-			CURRENT_SC->SCp.phase |= aborted;
+			scsi_pointer->phase |= aborted;
 
 		if (MSGO(MSGO_I)==BUS_DEVICE_RESET)
-			CURRENT_SC->SCp.phase |= resetted;
+			scsi_pointer->phase |= resetted;
 
 		SETPORT(SCSIDAT, MSGO(MSGO_I++));
 	}
@@ -1899,7 +1936,7 @@ static void msgo_end(struct Scsi_Host *shpnt)
  */
 static void cmd_init(struct Scsi_Host *shpnt)
 {
-	if (CURRENT_SC->SCp.sent_command) {
+	if (aha152x_scsi_pointer(CURRENT_SC)->sent_command) {
 		scmd_printk(KERN_ERR, CURRENT_SC,
 			    "command already sent\n");
 		done(shpnt, SAM_STAT_GOOD, DID_ERROR);
@@ -1930,7 +1967,7 @@ static void cmd_end(struct Scsi_Host *shpnt)
 			    "command sent incompletely (%d/%d)\n",
 			    CMD_I, CURRENT_SC->cmd_len);
 	else
-		CURRENT_SC->SCp.sent_command++;
+		aha152x_scsi_pointer(CURRENT_SC)->sent_command++;
 }
 
 /*
@@ -1942,7 +1979,7 @@ static void status_run(struct Scsi_Host *shpnt)
 	if (TESTLO(SSTAT0, SPIORDY))
 		return;
 
-	CURRENT_SC->SCp.Status = GETPORT(SCSIDAT);
+	aha152x_scsi_pointer(CURRENT_SC)->Status = GETPORT(SCSIDAT);
 
 }
 
@@ -1966,6 +2003,7 @@ static void datai_init(struct Scsi_Host *shpnt)
 
 static void datai_run(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer;
 	unsigned long the_time;
 	int fifodata, data_count;
 
@@ -2003,35 +2041,36 @@ static void datai_run(struct Scsi_Host *shpnt)
 			fifodata = GETPORT(FIFOSTAT);
 		}
 
-		if(CURRENT_SC->SCp.this_residual>0) {
-			while(fifodata>0 && CURRENT_SC->SCp.this_residual>0) {
-				data_count = fifodata > CURRENT_SC->SCp.this_residual ?
-						CURRENT_SC->SCp.this_residual :
+		scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+		if (scsi_pointer->this_residual > 0) {
+			while (fifodata > 0 && scsi_pointer->this_residual > 0) {
+				data_count = fifodata > scsi_pointer->this_residual ?
+						scsi_pointer->this_residual :
 						fifodata;
 				fifodata -= data_count;
 
 				if (data_count & 1) {
 					SETPORT(DMACNTRL0, ENDMA|_8BIT);
-					*CURRENT_SC->SCp.ptr++ = GETPORT(DATAPORT);
-					CURRENT_SC->SCp.this_residual--;
+					*scsi_pointer->ptr++ = GETPORT(DATAPORT);
+					scsi_pointer->this_residual--;
 					DATA_LEN++;
 					SETPORT(DMACNTRL0, ENDMA);
 				}
 
 				if (data_count > 1) {
 					data_count >>= 1;
-					insw(DATAPORT, CURRENT_SC->SCp.ptr, data_count);
-					CURRENT_SC->SCp.ptr += 2 * data_count;
-					CURRENT_SC->SCp.this_residual -= 2 * data_count;
+					insw(DATAPORT, scsi_pointer->ptr, data_count);
+					scsi_pointer->ptr += 2 * data_count;
+					scsi_pointer->this_residual -= 2 * data_count;
 					DATA_LEN += 2 * data_count;
 				}
 
-				if (CURRENT_SC->SCp.this_residual == 0 &&
-				    !sg_is_last(CURRENT_SC->SCp.buffer)) {
+				if (scsi_pointer->this_residual == 0 &&
+				    !sg_is_last(scsi_pointer->buffer)) {
 					/* advance to next buffer */
-					CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
-					CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
-					CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
+					scsi_pointer->buffer = sg_next(scsi_pointer->buffer);
+					scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
+					scsi_pointer->this_residual = scsi_pointer->buffer->length;
 				}
 			}
 		} else if (fifodata > 0) {
@@ -2099,14 +2138,15 @@ static void datao_init(struct Scsi_Host *shpnt)
 
 static void datao_run(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
 	unsigned long the_time;
 	int data_count;
 
 	/* until phase changes or all data sent */
-	while(TESTLO(DMASTAT, INTSTAT) && CURRENT_SC->SCp.this_residual>0) {
+	while (TESTLO(DMASTAT, INTSTAT) && scsi_pointer->this_residual > 0) {
 		data_count = 128;
-		if(data_count > CURRENT_SC->SCp.this_residual)
-			data_count=CURRENT_SC->SCp.this_residual;
+		if (data_count > scsi_pointer->this_residual)
+			data_count = scsi_pointer->this_residual;
 
 		if(TESTLO(DMASTAT, DFIFOEMP)) {
 			scmd_printk(KERN_ERR, CURRENT_SC,
@@ -2117,26 +2157,26 @@ static void datao_run(struct Scsi_Host *shpnt)
 
 		if(data_count & 1) {
 			SETPORT(DMACNTRL0,WRITE_READ|ENDMA|_8BIT);
-			SETPORT(DATAPORT, *CURRENT_SC->SCp.ptr++);
-			CURRENT_SC->SCp.this_residual--;
+			SETPORT(DATAPORT, *scsi_pointer->ptr++);
+			scsi_pointer->this_residual--;
 			CMD_INC_RESID(CURRENT_SC, -1);
 			SETPORT(DMACNTRL0,WRITE_READ|ENDMA);
 		}
 
 		if(data_count > 1) {
 			data_count >>= 1;
-			outsw(DATAPORT, CURRENT_SC->SCp.ptr, data_count);
-			CURRENT_SC->SCp.ptr           += 2 * data_count;
-			CURRENT_SC->SCp.this_residual -= 2 * data_count;
+			outsw(DATAPORT, scsi_pointer->ptr, data_count);
+			scsi_pointer->ptr           += 2 * data_count;
+			scsi_pointer->this_residual -= 2 * data_count;
 			CMD_INC_RESID(CURRENT_SC, -2 * data_count);
 		}
 
-		if (CURRENT_SC->SCp.this_residual == 0 &&
-		    !sg_is_last(CURRENT_SC->SCp.buffer)) {
+		if (scsi_pointer->this_residual == 0 &&
+		    !sg_is_last(scsi_pointer->buffer)) {
 			/* advance to next buffer */
-			CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
-			CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
-			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
+			scsi_pointer->buffer = sg_next(scsi_pointer->buffer);
+			scsi_pointer->ptr           = SG_ADDRESS(scsi_pointer->buffer);
+			scsi_pointer->this_residual = scsi_pointer->buffer->length;
 		}
 
 		the_time=jiffies + 100*HZ;
@@ -2152,6 +2192,8 @@ static void datao_run(struct Scsi_Host *shpnt)
 
 static void datao_end(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
+
 	if(TESTLO(DMASTAT, DFIFOEMP)) {
 		u32 datao_cnt = GETSTCNT();
 		int datao_out = DATA_LEN - scsi_get_resid(CURRENT_SC);
@@ -2169,9 +2211,9 @@ static void datao_end(struct Scsi_Host *shpnt)
 			sg = sg_next(sg);
 		}
 
-		CURRENT_SC->SCp.buffer = sg;
-		CURRENT_SC->SCp.ptr = SG_ADDRESS(CURRENT_SC->SCp.buffer) + done;
-		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length -
+		scsi_pointer->buffer = sg;
+		scsi_pointer->ptr = SG_ADDRESS(scsi_pointer->buffer) + done;
+		scsi_pointer->this_residual = scsi_pointer->buffer->length -
 			done;
 	}
 
@@ -2187,6 +2229,7 @@ static void datao_end(struct Scsi_Host *shpnt)
  */
 static int update_state(struct Scsi_Host *shpnt)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(CURRENT_SC);
 	int dataphase=0;
 	unsigned int stat0 = GETPORT(SSTAT0);
 	unsigned int stat1 = GETPORT(SSTAT1);
@@ -2200,7 +2243,8 @@ static int update_state(struct Scsi_Host *shpnt)
 		SETPORT(SSTAT1,SCSIRSTI);
 	} else if (stat0 & SELDI && PREVSTATE == busfree) {
 		STATE=seldi;
-	} else if(stat0 & SELDO && CURRENT_SC && (CURRENT_SC->SCp.phase & selecting)) {
+	} else if (stat0 & SELDO && CURRENT_SC &&
+		   (scsi_pointer->phase & selecting)) {
 		STATE=seldo;
 	} else if(stat1 & SELTO) {
 		STATE=selto;
@@ -2332,7 +2376,8 @@ static void is_complete(struct Scsi_Host *shpnt)
 			SETPORT(SXFRCTL0, CH1);
 			SETPORT(DMACNTRL0, 0);
 			if(CURRENT_SC)
-				CURRENT_SC->SCp.phase &= ~spiordy;
+				aha152x_scsi_pointer(CURRENT_SC)->phase &=
+					~spiordy;
 		}
 
 		/*
@@ -2354,7 +2399,8 @@ static void is_complete(struct Scsi_Host *shpnt)
 			SETPORT(DMACNTRL0, 0);
 			SETPORT(SXFRCTL0, CH1|SPIOEN);
 			if(CURRENT_SC)
-				CURRENT_SC->SCp.phase |= spiordy;
+				aha152x_scsi_pointer(CURRENT_SC)->phase |=
+					spiordy;
 		}
 
 		/*
@@ -2444,21 +2490,23 @@ static void disp_enintr(struct Scsi_Host *shpnt)
  */
 static void show_command(struct scsi_cmnd *ptr)
 {
+	const int phase = aha152x_scsi_pointer(ptr)->phase;
+
 	scsi_print_command(ptr);
 	scmd_printk(KERN_DEBUG, ptr,
 		    "request_bufflen=%d; resid=%d; "
 		    "phase |%s%s%s%s%s%s%s%s%s; next=0x%p",
 		    scsi_bufflen(ptr), scsi_get_resid(ptr),
-		    (ptr->SCp.phase & not_issued) ? "not issued|" : "",
-		    (ptr->SCp.phase & selecting) ? "selecting|" : "",
-		    (ptr->SCp.phase & identified) ? "identified|" : "",
-		    (ptr->SCp.phase & disconnected) ? "disconnected|" : "",
-		    (ptr->SCp.phase & completed) ? "completed|" : "",
-		    (ptr->SCp.phase & spiordy) ? "spiordy|" : "",
-		    (ptr->SCp.phase & syncneg) ? "syncneg|" : "",
-		    (ptr->SCp.phase & aborted) ? "aborted|" : "",
-		    (ptr->SCp.phase & resetted) ? "resetted|" : "",
-		    (SCDATA(ptr)) ? SCNEXT(ptr) : NULL);
+		    phase & not_issued ? "not issued|" : "",
+		    phase & selecting ? "selecting|" : "",
+		    phase & identified ? "identified|" : "",
+		    phase & disconnected ? "disconnected|" : "",
+		    phase & completed ? "completed|" : "",
+		    phase & spiordy ? "spiordy|" : "",
+		    phase & syncneg ? "syncneg|" : "",
+		    phase & aborted ? "aborted|" : "",
+		    phase & resetted ? "resetted|" : "",
+		    SCDATA(ptr) ? SCNEXT(ptr) : NULL);
 }
 
 /*
@@ -2490,6 +2538,8 @@ static void show_queues(struct Scsi_Host *shpnt)
 
 static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
 {
+	struct scsi_pointer *scsi_pointer = aha152x_scsi_pointer(ptr);
+	const int phase = scsi_pointer->phase;
 	int i;
 
 	seq_printf(m, "%p: target=%d; lun=%d; cmnd=( ",
@@ -2499,24 +2549,24 @@ static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
 		seq_printf(m, "0x%02x ", ptr->cmnd[i]);
 
 	seq_printf(m, "); resid=%d; residual=%d; buffers=%d; phase |",
-		scsi_get_resid(ptr), ptr->SCp.this_residual,
-		sg_nents(ptr->SCp.buffer) - 1);
+		scsi_get_resid(ptr), scsi_pointer->this_residual,
+		sg_nents(scsi_pointer->buffer) - 1);
 
-	if (ptr->SCp.phase & not_issued)
+	if (phase & not_issued)
 		seq_puts(m, "not issued|");
-	if (ptr->SCp.phase & selecting)
+	if (phase & selecting)
 		seq_puts(m, "selecting|");
-	if (ptr->SCp.phase & disconnected)
+	if (phase & disconnected)
 		seq_puts(m, "disconnected|");
-	if (ptr->SCp.phase & aborted)
+	if (phase & aborted)
 		seq_puts(m, "aborted|");
-	if (ptr->SCp.phase & identified)
+	if (phase & identified)
 		seq_puts(m, "identified|");
-	if (ptr->SCp.phase & completed)
+	if (phase & completed)
 		seq_puts(m, "completed|");
-	if (ptr->SCp.phase & spiordy)
+	if (phase & spiordy)
 		seq_puts(m, "spiordy|");
-	if (ptr->SCp.phase & syncneg)
+	if (phase & syncneg)
 		seq_puts(m, "syncneg|");
 	seq_printf(m, "; next=0x%p\n", SCNEXT(ptr));
 }
@@ -2921,6 +2971,7 @@ static struct scsi_host_template aha152x_driver_template = {
 	.sg_tablesize			= SG_ALL,
 	.dma_boundary			= PAGE_SIZE - 1,
 	.slave_alloc			= aha152x_adjust_queue,
+	.cmd_size			= sizeof(struct aha152x_cmd_priv),
 };
 
 #if !defined(AHA152X_PCMCIA)
