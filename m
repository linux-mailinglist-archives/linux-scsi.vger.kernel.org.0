Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C84BC08F
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Feb 2022 20:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiBRTw2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Feb 2022 14:52:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiBRTwG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Feb 2022 14:52:06 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E9293B6F
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:51:48 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id w1so7968300plb.6
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ba4bEJmtkM/3WJAT4TgzDstqDhaDKX2I2VSFRMVcdg=;
        b=vjobPCw58igYBof9X6bMi1Tq6Rmt1eozAgaJn0YSBX2vEknppBy5+qgjuBl7O5YmSf
         6AgW+r97eaFWtnGqCbir1zyEBDbkzn2gL0HB7Kll7Sd2qbfmIPmzYtDMsJJY/bIOe4bs
         OLWOPV9TJXzv8a+0Y0fU388SmhKivmcdmffBfRitsMWsvMPpe4tEyFI53mpOCp9TvU0z
         509exjnfdRxrF/7U94jfg0fX0gSzoys/J4i1U7/K8hyTBSW97iunzLkBqJAA8K0nwVdz
         k/jZlkC2r9+bT+a5y0Hvm88KJbalXrm75dBLjQ5mEmyTprAQD1j2uUuSPE1MUGB8i3Z7
         a5wg==
X-Gm-Message-State: AOAM5334w4jacXXnYslll2wRShBA9OgC/cj2gNGvfKrhyEQD83mMxTa7
        NnC+vZm2nYdcpre5XQ1vDIc=
X-Google-Smtp-Source: ABdhPJwMa+OebcEPgOJ/NFZV7hBhwH4DTyK6JsWoezcth6bz4W/sb0CD2DoV9hLdpFmgolvuy0uQHg==
X-Received: by 2002:a17:902:d683:b0:14c:c0a9:34f3 with SMTP id v3-20020a170902d68300b0014cc0a934f3mr8708834ply.109.1645213907986;
        Fri, 18 Feb 2022 11:51:47 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id e15sm3930523pfv.104.2022.02.18.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:51:47 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Russell King <linux@armlinux.org.uk>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 10/49] scsi: arm: Move the SCSI pointer to private command data
Date:   Fri, 18 Feb 2022 11:50:38 -0800
Message-Id: <20220218195117.25689-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218195117.25689-1-bvanassche@acm.org>
References: <20220218195117.25689-1-bvanassche@acm.org>
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

Set .cmd_size in the SCSI host template instead of using the SCSI pointer
from struct scsi_cmnd. This patch prepares for removal of the SCSI pointer
from struct scsi_cmnd. The ARM SCSI drivers have been identified as follows:
$ git grep -l '#include.*arm_scsi.h'
drivers/scsi/arm/acornscsi.c
drivers/scsi/arm/cumana_2.c
drivers/scsi/arm/eesox.c
drivers/scsi/arm/fas216.c
drivers/scsi/arm/powertec.c

Cc: Russell King <linux@armlinux.org.uk>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/arm/acornscsi.c | 20 ++++++++++++--------
 drivers/scsi/arm/arm_scsi.h  | 33 +++++++++++++++++++++++----------
 drivers/scsi/arm/fas216.c    | 28 +++++++++++++++++-----------
 drivers/scsi/arm/fas216.h    |  4 ++++
 4 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 38aa9333631b..7602639da9b3 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -729,7 +729,7 @@ intr_ret_t acornscsi_kick(AS_Host *host)
      */
     host->scsi.phase = PHASE_CONNECTING;
     host->SCpnt = SCpnt;
-    host->scsi.SCp = SCpnt->SCp;
+    host->scsi.SCp = *arm_scsi_pointer(SCpnt);
     host->dma.xfer_setup = 0;
     host->dma.xfer_required = 0;
     host->dma.xfer_done = 0;
@@ -1424,6 +1424,7 @@ unsigned char acornscsi_readmessagebyte(AS_Host *host)
 static
 void acornscsi_message(AS_Host *host)
 {
+    struct scsi_pointer *scsi_pointer;
     unsigned char message[16];
     unsigned int msgidx = 0, msglen = 1;
 
@@ -1493,8 +1494,9 @@ void acornscsi_message(AS_Host *host)
 	 *  the saved data pointer for the current I/O process.
 	 */
 	acornscsi_dma_cleanup(host);
-	host->SCpnt->SCp = host->scsi.SCp;
-	host->SCpnt->SCp.sent_command = 0;
+	scsi_pointer = arm_scsi_pointer(host->SCpnt);
+	*scsi_pointer = host->scsi.SCp;
+	scsi_pointer->sent_command = 0;
 	host->scsi.phase = PHASE_MSGIN;
 	break;
 
@@ -1509,7 +1511,7 @@ void acornscsi_message(AS_Host *host)
 	 *  the present command and status areas.'
 	 */
 	acornscsi_dma_cleanup(host);
-	host->scsi.SCp = host->SCpnt->SCp;
+	host->scsi.SCp = *arm_scsi_pointer(host->SCpnt);
 	host->scsi.phase = PHASE_MSGIN;
 	break;
 
@@ -1809,7 +1811,7 @@ int acornscsi_reconnect_finish(AS_Host *host)
 	/*
 	 * Restore data pointer from SAVED pointers.
 	 */
-	host->scsi.SCp = host->SCpnt->SCp;
+	host->scsi.SCp = *arm_scsi_pointer(host->SCpnt);
 #if (DEBUG & (DEBUG_QUEUES|DEBUG_DISCON))
 	printk(", data pointers: [%p, %X]",
 		host->scsi.SCp.ptr, host->scsi.SCp.this_residual);
@@ -2408,6 +2410,7 @@ acornscsi_intr(int irq, void *dev_id)
  */
 static int acornscsi_queuecmd_lck(struct scsi_cmnd *SCpnt)
 {
+    struct scsi_pointer *scsi_pointer = arm_scsi_pointer(SCpnt);
     void (*done)(struct scsi_cmnd *) = scsi_done;
     AS_Host *host = (AS_Host *)SCpnt->device->host->hostdata;
 
@@ -2423,9 +2426,9 @@ static int acornscsi_queuecmd_lck(struct scsi_cmnd *SCpnt)
 
     SCpnt->host_scribble = NULL;
     SCpnt->result = 0;
-    SCpnt->SCp.phase = (int)acornscsi_datadirection(SCpnt->cmnd[0]);
-    SCpnt->SCp.sent_command = 0;
-    SCpnt->SCp.scsi_xferred = 0;
+    scsi_pointer->phase = (int)acornscsi_datadirection(SCpnt->cmnd[0]);
+    scsi_pointer->sent_command = 0;
+    scsi_pointer->scsi_xferred = 0;
 
     init_SCp(SCpnt);
 
@@ -2791,6 +2794,7 @@ static struct scsi_host_template acornscsi_template = {
 	.cmd_per_lun		= 2,
 	.dma_boundary		= PAGE_SIZE - 1,
 	.proc_name		= "acornscsi",
+	.cmd_size		= sizeof(struct arm_cmd_priv),
 };
 
 static int acornscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
diff --git a/drivers/scsi/arm/arm_scsi.h b/drivers/scsi/arm/arm_scsi.h
index 3eb5c6aa93c9..ea9fcd92c6de 100644
--- a/drivers/scsi/arm/arm_scsi.h
+++ b/drivers/scsi/arm/arm_scsi.h
@@ -9,6 +9,17 @@
 
 #define BELT_AND_BRACES
 
+struct arm_cmd_priv {
+	struct scsi_pointer scsi_pointer;
+};
+
+static inline struct scsi_pointer *arm_scsi_pointer(struct scsi_cmnd *cmd)
+{
+	struct arm_cmd_priv *acmd = scsi_cmd_priv(cmd);
+
+	return &acmd->scsi_pointer;
+}
+
 /*
  * The scatter-gather list handling.  This contains all
  * the yucky stuff that needs to be fixed properly.
@@ -76,16 +87,18 @@ static inline void put_next_SCp_byte(struct scsi_pointer *SCp, unsigned char c)
 
 static inline void init_SCp(struct scsi_cmnd *SCpnt)
 {
-	memset(&SCpnt->SCp, 0, sizeof(struct scsi_pointer));
+	struct scsi_pointer *scsi_pointer = arm_scsi_pointer(SCpnt);
+
+	memset(scsi_pointer, 0, sizeof(struct scsi_pointer));
 
 	if (scsi_bufflen(SCpnt)) {
 		unsigned long len = 0;
 
-		SCpnt->SCp.buffer = scsi_sglist(SCpnt);
-		SCpnt->SCp.buffers_residual = scsi_sg_count(SCpnt) - 1;
-		SCpnt->SCp.ptr = sg_virt(SCpnt->SCp.buffer);
-		SCpnt->SCp.this_residual = SCpnt->SCp.buffer->length;
-		SCpnt->SCp.phase = scsi_bufflen(SCpnt);
+		scsi_pointer->buffer = scsi_sglist(SCpnt);
+		scsi_pointer->buffers_residual = scsi_sg_count(SCpnt) - 1;
+		scsi_pointer->ptr = sg_virt(scsi_pointer->buffer);
+		scsi_pointer->this_residual = scsi_pointer->buffer->length;
+		scsi_pointer->phase = scsi_bufflen(SCpnt);
 
 #ifdef BELT_AND_BRACES
 		{	/*
@@ -109,15 +122,15 @@ static inline void init_SCp(struct scsi_cmnd *SCpnt)
 				 * FIXME: Totaly naive fixup. We should abort
 				 * with error
 				 */
-				SCpnt->SCp.phase =
+				scsi_pointer->phase =
 					min_t(unsigned long, len,
 					      scsi_bufflen(SCpnt));
 			}
 		}
 #endif
 	} else {
-		SCpnt->SCp.ptr = NULL;
-		SCpnt->SCp.this_residual = 0;
-		SCpnt->SCp.phase = 0;
+		scsi_pointer->ptr = NULL;
+		scsi_pointer->this_residual = 0;
+		scsi_pointer->phase = 0;
 	}
 }
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index a23e34c9f7de..4ce0b2d73614 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -761,7 +761,7 @@ static void fas216_transfer(FAS216_Info *info)
 		fas216_log(info, LOG_ERROR, "null buffer passed to "
 			   "fas216_starttransfer");
 		print_SCp(&info->scsi.SCp, "SCp: ", "\n");
-		print_SCp(&info->SCpnt->SCp, "Cmnd SCp: ", "\n");
+		print_SCp(arm_scsi_pointer(info->SCpnt), "Cmnd SCp: ", "\n");
 		return;
 	}
 
@@ -1011,7 +1011,7 @@ fas216_reselected_intr(FAS216_Info *info)
 		/*
 		 * Restore data pointer from SAVED data pointer
 		 */
-		info->scsi.SCp = info->SCpnt->SCp;
+		info->scsi.SCp = *arm_scsi_pointer(info->SCpnt);
 
 		fas216_log(info, LOG_CONNECT, "data pointers: [%p, %X]",
 			info->scsi.SCp.ptr, info->scsi.SCp.this_residual);
@@ -1054,6 +1054,7 @@ fas216_reselected_intr(FAS216_Info *info)
 
 static void fas216_parse_message(FAS216_Info *info, unsigned char *message, int msglen)
 {
+	struct scsi_pointer *scsi_pointer;
 	int i;
 
 	switch (message[0]) {
@@ -1078,8 +1079,9 @@ static void fas216_parse_message(FAS216_Info *info, unsigned char *message, int
 		 * as required by the SCSI II standard.  These always
 		 * point to the start of their respective areas.
 		 */
-		info->SCpnt->SCp = info->scsi.SCp;
-		info->SCpnt->SCp.sent_command = 0;
+		scsi_pointer = arm_scsi_pointer(info->SCpnt);
+		*scsi_pointer = info->scsi.SCp;
+		scsi_pointer->sent_command = 0;
 		fas216_log(info, LOG_CONNECT | LOG_MESSAGES | LOG_BUFFER,
 			"save data pointers: [%p, %X]",
 			info->scsi.SCp.ptr, info->scsi.SCp.this_residual);
@@ -1092,7 +1094,7 @@ static void fas216_parse_message(FAS216_Info *info, unsigned char *message, int
 		/*
 		 * Restore current data pointer from SAVED data pointer
 		 */
-		info->scsi.SCp = info->SCpnt->SCp;
+		info->scsi.SCp = *arm_scsi_pointer(info->SCpnt);
 		fas216_log(info, LOG_CONNECT | LOG_MESSAGES | LOG_BUFFER,
 			"restore data pointers: [%p, 0x%x]",
 			info->scsi.SCp.ptr, info->scsi.SCp.this_residual);
@@ -1770,7 +1772,7 @@ static void fas216_start_command(FAS216_Info *info, struct scsi_cmnd *SCpnt)
 	 * claim host busy
 	 */
 	info->scsi.phase = PHASE_SELECTION;
-	info->scsi.SCp = SCpnt->SCp;
+	info->scsi.SCp = *arm_scsi_pointer(SCpnt);
 	info->SCpnt = SCpnt;
 	info->dma.transfer_type = fasdma_none;
 
@@ -1849,7 +1851,7 @@ static void fas216_do_bus_device_reset(FAS216_Info *info,
 	 * claim host busy
 	 */
 	info->scsi.phase = PHASE_SELECTION;
-	info->scsi.SCp = SCpnt->SCp;
+	info->scsi.SCp = *arm_scsi_pointer(SCpnt);
 	info->SCpnt = SCpnt;
 	info->dma.transfer_type = fasdma_none;
 
@@ -1999,11 +2001,13 @@ static void fas216_devicereset_done(FAS216_Info *info, struct scsi_cmnd *SCpnt,
 static void fas216_rq_sns_done(FAS216_Info *info, struct scsi_cmnd *SCpnt,
 			       unsigned int result)
 {
+	struct scsi_pointer *scsi_pointer = arm_scsi_pointer(SCpnt);
+
 	fas216_log_target(info, LOG_CONNECT, SCpnt->device->id,
 		   "request sense complete, result=0x%04x%02x%02x",
-		   result, SCpnt->SCp.Message, SCpnt->SCp.Status);
+		   result, scsi_pointer->Message, scsi_pointer->Status);
 
-	if (result != DID_OK || SCpnt->SCp.Status != SAM_STAT_GOOD)
+	if (result != DID_OK || scsi_pointer->Status != SAM_STAT_GOOD)
 		/*
 		 * Something went wrong.  Make sure that we don't
 		 * have valid data in the sense buffer that could
@@ -2033,6 +2037,8 @@ static void fas216_rq_sns_done(FAS216_Info *info, struct scsi_cmnd *SCpnt,
 static void
 fas216_std_done(FAS216_Info *info, struct scsi_cmnd *SCpnt, unsigned int result)
 {
+	struct scsi_pointer *scsi_pointer = arm_scsi_pointer(SCpnt);
+
 	info->stats.fins += 1;
 
 	set_host_byte(SCpnt, result);
@@ -2107,8 +2113,8 @@ fas216_std_done(FAS216_Info *info, struct scsi_cmnd *SCpnt, unsigned int result)
 	fas216_log_target(info, LOG_CONNECT, SCpnt->device->id,
 			  "requesting sense");
 	init_SCp(SCpnt);
-	SCpnt->SCp.Message = 0;
-	SCpnt->SCp.Status = 0;
+	scsi_pointer->Message = 0;
+	scsi_pointer->Status = 0;
 	SCpnt->host_scribble = (void *)fas216_rq_sns_done;
 
 	/*
diff --git a/drivers/scsi/arm/fas216.h b/drivers/scsi/arm/fas216.h
index abf960487314..08113277a2a9 100644
--- a/drivers/scsi/arm/fas216.h
+++ b/drivers/scsi/arm/fas216.h
@@ -312,6 +312,10 @@ typedef struct {
 
 /* driver-private data per SCSI command. */
 struct fas216_cmd_priv {
+	/*
+	 * @scsi_pointer must be the first member. See also arm_scsi_pointer().
+	 */
+	struct scsi_pointer scsi_pointer;
 	void (*scsi_done)(struct scsi_cmnd *cmd);
 };
 
