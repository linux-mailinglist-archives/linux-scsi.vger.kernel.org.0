Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C814ADF8A
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Feb 2022 18:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384317AbiBHR03 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Feb 2022 12:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384376AbiBHR0X (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Feb 2022 12:26:23 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7EDC03F938
        for <linux-scsi@vger.kernel.org>; Tue,  8 Feb 2022 09:26:20 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id k17so14455432plk.0
        for <linux-scsi@vger.kernel.org>; Tue, 08 Feb 2022 09:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ly0ZPJcM1eXSN9YNjGh68pG3uHl2VWJNdeo+tbEtGe8=;
        b=xrihjxWwH2SljAq0d5RJGIzpqHW2iR8tpsuDO7RD9iEgV4bwl7ndDmQ0HvP5wNJHOQ
         M68n8EDuJ8vFikLglXtFWX2oJQxCO/GJL4bcHq8xn2/NcGSvep+auQoH3nR/HyG1SlAN
         nTFr0Hu2T8fVnLvAlMRFJCurH/+/U0GF9Zahr9tGR34W3peeC1DD+ScN6tBuvB29fduN
         12p1F6CaTkqYnoD5K3QYT8KHPV/M/2a2dkGauP5iXSaR86j0oqwOWVZBFboAaBCjvD+R
         r3+qpMhVuMtRjUOothu2BegVv3iFbD6atUsmExqUwRSUic6WkJ1vrR+OufuU9yvRGtQ+
         mF1A==
X-Gm-Message-State: AOAM531EEES5xHHEJxtxIwimdLubpvQjRPGsZeKbuvZ4bvrho+RiOT8c
        HpNbEueN2cl8RNPsFoMIBus=
X-Google-Smtp-Source: ABdhPJyUy3a7LQCLgK0Ak4C8QMLRVuzte/sihsumUZ6SSODos2qW1xlD+cHJJpF2YvvfF7FPXEQWjA==
X-Received: by 2002:a17:903:1212:: with SMTP id l18mr5633725plh.7.1644341179439;
        Tue, 08 Feb 2022 09:26:19 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id q1sm335116pfs.112.2022.02.08.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:26:18 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 21/44] imm: Move the SCSI pointer to private command data
Date:   Tue,  8 Feb 2022 09:24:51 -0800
Message-Id: <20220208172514.3481-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208172514.3481-1-bvanassche@acm.org>
References: <20220208172514.3481-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set .cmd_size in the SCSI host template instead of using the SCSI pointer.
This patch prepares for removal of the SCSI pointer from struct scsi_cmnd.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/imm.c | 88 ++++++++++++++++++++++++----------------------
 drivers/scsi/imm.h | 11 ++++++
 2 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 8afdb4dba2be..3d86e3a52866 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -66,7 +66,7 @@ static void got_it(imm_struct *dev)
 {
 	dev->base = dev->dev->port->base;
 	if (dev->cur_cmd)
-		dev->cur_cmd->SCp.phase = 1;
+		imm_scsi_pointer(dev->cur_cmd)->phase = 1;
 	else
 		wake_up(dev->waiting);
 }
@@ -618,13 +618,14 @@ static inline int imm_send_command(struct scsi_cmnd *cmd)
  * The driver appears to remain stable if we speed up the parallel port
  * i/o in this function, but not elsewhere.
  */
-static int imm_completion(struct scsi_cmnd *cmd)
+static int imm_completion(struct scsi_cmnd *const cmd)
 {
 	/* Return codes:
 	 * -1     Error
 	 *  0     Told to schedule
 	 *  1     Finished data transfer
 	 */
+	struct scsi_pointer *scsi_pointer = imm_scsi_pointer(cmd);
 	imm_struct *dev = imm_dev(cmd->device->host);
 	unsigned short ppb = dev->base;
 	unsigned long start_jiffies = jiffies;
@@ -660,44 +661,43 @@ static int imm_completion(struct scsi_cmnd *cmd)
 		 * a) Drive status is screwy (!ready && !present)
 		 * b) Drive is requesting/sending more data than expected
 		 */
-		if (((r & 0x88) != 0x88) || (cmd->SCp.this_residual <= 0)) {
+		if ((r & 0x88) != 0x88 || scsi_pointer->this_residual <= 0) {
 			imm_fail(dev, DID_ERROR);
 			return -1;	/* ERROR_RETURN */
 		}
 		/* determine if we should use burst I/O */
 		if (dev->rd == 0) {
-			fast = (bulk
-				&& (cmd->SCp.this_residual >=
-				    IMM_BURST_SIZE)) ? IMM_BURST_SIZE : 2;
-			status = imm_out(dev, cmd->SCp.ptr, fast);
+			fast = bulk && scsi_pointer->this_residual >=
+				IMM_BURST_SIZE ? IMM_BURST_SIZE : 2;
+			status = imm_out(dev, scsi_pointer->ptr, fast);
 		} else {
-			fast = (bulk
-				&& (cmd->SCp.this_residual >=
-				    IMM_BURST_SIZE)) ? IMM_BURST_SIZE : 1;
-			status = imm_in(dev, cmd->SCp.ptr, fast);
+			fast = bulk && scsi_pointer->this_residual >=
+				IMM_BURST_SIZE ? IMM_BURST_SIZE : 1;
+			status = imm_in(dev, scsi_pointer->ptr, fast);
 		}
 
-		cmd->SCp.ptr += fast;
-		cmd->SCp.this_residual -= fast;
+		scsi_pointer->ptr += fast;
+		scsi_pointer->this_residual -= fast;
 
 		if (!status) {
 			imm_fail(dev, DID_BUS_BUSY);
 			return -1;	/* ERROR_RETURN */
 		}
-		if (cmd->SCp.buffer && !cmd->SCp.this_residual) {
+		if (scsi_pointer->buffer && !scsi_pointer->this_residual) {
 			/* if scatter/gather, advance to the next segment */
-			if (cmd->SCp.buffers_residual--) {
-				cmd->SCp.buffer = sg_next(cmd->SCp.buffer);
-				cmd->SCp.this_residual =
-				    cmd->SCp.buffer->length;
-				cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
+			if (scsi_pointer->buffers_residual--) {
+				scsi_pointer->buffer =
+					sg_next(scsi_pointer->buffer);
+				scsi_pointer->this_residual =
+				    scsi_pointer->buffer->length;
+				scsi_pointer->ptr = sg_virt(scsi_pointer->buffer);
 
 				/*
 				 * Make sure that we transfer even number of bytes
 				 * otherwise it makes imm_byte_out() messy.
 				 */
-				if (cmd->SCp.this_residual & 0x01)
-					cmd->SCp.this_residual++;
+				if (scsi_pointer->this_residual & 0x01)
+					scsi_pointer->this_residual++;
 			}
 		}
 		/* Now check to see if the drive is ready to comunicate */
@@ -762,7 +762,7 @@ static void imm_interrupt(struct work_struct *work)
 	}
 #endif
 
-	if (cmd->SCp.phase > 1)
+	if (imm_scsi_pointer(cmd)->phase > 1)
 		imm_disconnect(dev);
 
 	imm_pb_dismiss(dev);
@@ -774,8 +774,9 @@ static void imm_interrupt(struct work_struct *work)
 	return;
 }
 
-static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
+static int imm_engine(imm_struct *dev, struct scsi_cmnd *const cmd)
 {
+	struct scsi_pointer *scsi_pointer = imm_scsi_pointer(cmd);
 	unsigned short ppb = dev->base;
 	unsigned char l = 0, h = 0;
 	int retv, x;
@@ -786,7 +787,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 	if (dev->failed)
 		return 0;
 
-	switch (cmd->SCp.phase) {
+	switch (scsi_pointer->phase) {
 	case 0:		/* Phase 0 - Waiting for parport */
 		if (time_after(jiffies, dev->jstart + HZ)) {
 			/*
@@ -800,7 +801,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 
 	case 1:		/* Phase 1 - Connected */
 		imm_connect(dev, CONNECT_EPP_MAYBE);
-		cmd->SCp.phase++;
+		scsi_pointer->phase++;
 		fallthrough;
 
 	case 2:		/* Phase 2 - We are now talking to the scsi bus */
@@ -808,7 +809,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 			imm_fail(dev, DID_NO_CONNECT);
 			return 0;
 		}
-		cmd->SCp.phase++;
+		scsi_pointer->phase++;
 		fallthrough;
 
 	case 3:		/* Phase 3 - Ready to accept a command */
@@ -818,23 +819,23 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 
 		if (!imm_send_command(cmd))
 			return 0;
-		cmd->SCp.phase++;
+		scsi_pointer->phase++;
 		fallthrough;
 
 	case 4:		/* Phase 4 - Setup scatter/gather buffers */
 		if (scsi_bufflen(cmd)) {
-			cmd->SCp.buffer = scsi_sglist(cmd);
-			cmd->SCp.this_residual = cmd->SCp.buffer->length;
-			cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
+			scsi_pointer->buffer = scsi_sglist(cmd);
+			scsi_pointer->this_residual = scsi_pointer->buffer->length;
+			scsi_pointer->ptr = sg_virt(scsi_pointer->buffer);
 		} else {
-			cmd->SCp.buffer = NULL;
-			cmd->SCp.this_residual = 0;
-			cmd->SCp.ptr = NULL;
+			scsi_pointer->buffer = NULL;
+			scsi_pointer->this_residual = 0;
+			scsi_pointer->ptr = NULL;
 		}
-		cmd->SCp.buffers_residual = scsi_sg_count(cmd) - 1;
-		cmd->SCp.phase++;
-		if (cmd->SCp.this_residual & 0x01)
-			cmd->SCp.this_residual++;
+		scsi_pointer->buffers_residual = scsi_sg_count(cmd) - 1;
+		scsi_pointer->phase++;
+		if (scsi_pointer->this_residual & 0x01)
+			scsi_pointer->this_residual++;
 		fallthrough;
 
 	case 5:		/* Phase 5 - Pre-Data transfer stage */
@@ -851,7 +852,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 		if ((dev->dp) && (dev->rd))
 			if (imm_negotiate(dev))
 				return 0;
-		cmd->SCp.phase++;
+		scsi_pointer->phase++;
 		fallthrough;
 
 	case 6:		/* Phase 6 - Data transfer stage */
@@ -867,7 +868,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 			if (retv == 0)
 				return 1;
 		}
-		cmd->SCp.phase++;
+		scsi_pointer->phase++;
 		fallthrough;
 
 	case 7:		/* Phase 7 - Post data transfer stage */
@@ -879,7 +880,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 				w_ctr(ppb, 0x4);
 			}
 		}
-		cmd->SCp.phase++;
+		scsi_pointer->phase++;
 		fallthrough;
 
 	case 8:		/* Phase 8 - Read status/message */
@@ -922,7 +923,7 @@ static int imm_queuecommand_lck(struct scsi_cmnd *cmd)
 	dev->jstart = jiffies;
 	dev->cur_cmd = cmd;
 	cmd->result = DID_ERROR << 16;	/* default return code */
-	cmd->SCp.phase = 0;	/* bus free */
+	imm_scsi_pointer(cmd)->phase = 0;	/* bus free */
 
 	schedule_delayed_work(&dev->imm_tq, 0);
 
@@ -961,7 +962,7 @@ static int imm_abort(struct scsi_cmnd *cmd)
 	 * have tied the SCSI_MESSAGE line high in the interface
 	 */
 
-	switch (cmd->SCp.phase) {
+	switch (imm_scsi_pointer(cmd)->phase) {
 	case 0:		/* Do not have access to parport */
 	case 1:		/* Have not connected to interface */
 		dev->cur_cmd = NULL;	/* Forget the problem */
@@ -987,7 +988,7 @@ static int imm_reset(struct scsi_cmnd *cmd)
 {
 	imm_struct *dev = imm_dev(cmd->device->host);
 
-	if (cmd->SCp.phase)
+	if (imm_scsi_pointer(cmd)->phase)
 		imm_disconnect(dev);
 	dev->cur_cmd = NULL;	/* Forget the problem */
 
@@ -1109,6 +1110,7 @@ static struct scsi_host_template imm_template = {
 	.sg_tablesize		= SG_ALL,
 	.can_queue		= 1,
 	.slave_alloc		= imm_adjust_queue,
+	.cmd_size		= sizeof(struct imm_cmd_priv),
 };
 
 /***************************************************************************
diff --git a/drivers/scsi/imm.h b/drivers/scsi/imm.h
index 7f2bb35b1b87..12cbc7ee8bba 100644
--- a/drivers/scsi/imm.h
+++ b/drivers/scsi/imm.h
@@ -139,6 +139,17 @@ static char *IMM_MODE_STRING[] =
 #define w_ctr(x,y)      outb(y, (x)+2)
 #endif
 
+struct imm_cmd_priv {
+	struct scsi_pointer scsi_pointer;
+};
+
+static inline struct scsi_pointer *imm_scsi_pointer(struct scsi_cmnd *cmd)
+{
+	struct imm_cmd_priv *icmd = scsi_cmd_priv(cmd);
+
+	return &icmd->scsi_pointer;
+}
+
 static int imm_engine(imm_struct *, struct scsi_cmnd *);
 
 #endif				/* _IMM_H */
