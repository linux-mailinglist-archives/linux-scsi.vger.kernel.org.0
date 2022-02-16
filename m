Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A65D4B92DF
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Feb 2022 22:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiBPVEh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Feb 2022 16:04:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiBPVEQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 16 Feb 2022 16:04:16 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3162B04A9
        for <linux-scsi@vger.kernel.org>; Wed, 16 Feb 2022 13:04:02 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id c3so2965653pls.5
        for <linux-scsi@vger.kernel.org>; Wed, 16 Feb 2022 13:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tnHuLBSxaziml5aSmalKdD+1YoupdlPfcjSx6lYIiq0=;
        b=tdFFj8cWkpfHFL88SvGpkhsdolGwUptUlku5R/q74vXG0qNNtbPTno2gWKqrs1Rjc8
         XH4kZd+kaWCPthTkY/AeslcZ79mR82uBuSHd4dCKIbx5s81LO+Klei6VjGHkmrhWcHhg
         DwOrBHfor8H+xMQRSYbRVyyWYTfkiOlfHVYPXXdkjYKMLAE+1xnXf9P1q+StmnZkP4k5
         HDkplaCdmDlpwxt4PGrnpZTJsmb5D5uhC5bIGRB1FMu/Vz+XsJk3ABOKPo0GSUxXFGZn
         Cj0pMGyiktu0A3+KYUyLYxZ9mtX434nUh6zeNyF3fmCqS7As5CNYAr0o8Sc/JYZjhDMG
         wuSw==
X-Gm-Message-State: AOAM5322n4qz8f/Yt6I1EzZAxNvS2smuF70ew9Prz5R5N3I/piFb7txD
        3eN9Rq0317bVkeEsE56Wzxs=
X-Google-Smtp-Source: ABdhPJyIcU4VTbuaxMTEMZ1ghKzIsAl99/H/nJaZwfWIt4g4enRmTgkmvek8uMYyWwXMZxAPqWxaCw==
X-Received: by 2002:a17:90b:3698:b0:1b9:e011:b942 with SMTP id mj24-20020a17090b369800b001b9e011b942mr3814835pjb.189.1645045442056;
        Wed, 16 Feb 2022 13:04:02 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c8sm46591222pfv.57.2022.02.16.13.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 13:04:01 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Masanori Goto <gotom@debian.or.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v4 38/50] scsi: nsp32: Stop using the SCSI pointer
Date:   Wed, 16 Feb 2022 13:02:21 -0800
Message-Id: <20220216210233.28774-39-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216210233.28774-1-bvanassche@acm.org>
References: <20220216210233.28774-1-bvanassche@acm.org>
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

Move the SCSI status field to private data. Stop setting the .ptr,
.this_residual, .buffer and .buffer_residual SCSI pointer members
since no code in this driver reads these members.

This patch prepares for removal of the SCSI pointer from struct scsi_cmnd.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Masanori Goto <gotom@debian.or.jp>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/nsp32.c | 20 +++++++-------------
 drivers/scsi/nsp32.h |  9 +++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index bd3ee3bf08ee..75bb0028ed74 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -273,6 +273,7 @@ static struct scsi_host_template nsp32_template = {
 	.eh_abort_handler		= nsp32_eh_abort,
 	.eh_host_reset_handler		= nsp32_eh_host_reset,
 /*	.highmem_io			= 1, */
+	.cmd_size			= sizeof(struct nsp32_cmd_priv),
 };
 
 #include "nsp32_io.h"
@@ -946,14 +947,9 @@ static int nsp32_queuecommand_lck(struct scsi_cmnd *SCpnt)
 	show_command(SCpnt);
 
 	data->CurrentSC      = SCpnt;
-	SCpnt->SCp.Status    = SAM_STAT_CHECK_CONDITION;
+	nsp32_priv(SCpnt)->status = SAM_STAT_CHECK_CONDITION;
 	scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
 
-	SCpnt->SCp.ptr		    = (char *)scsi_sglist(SCpnt);
-	SCpnt->SCp.this_residual    = scsi_bufflen(SCpnt);
-	SCpnt->SCp.buffer	    = NULL;
-	SCpnt->SCp.buffers_residual = 0;
-
 	/* initialize data */
 	data->msgout_len	= 0;
 	data->msgin_len		= 0;
@@ -1376,7 +1372,7 @@ static irqreturn_t do_nsp32_isr(int irq, void *dev_id)
 		case BUSPHASE_STATUS:
 			nsp32_dbg(NSP32_DEBUG_INTR, "fifo/status");
 
-			SCpnt->SCp.Status = nsp32_read1(base, SCSI_CSB_IN);
+			nsp32_priv(SCpnt)->status = nsp32_read1(base, SCSI_CSB_IN);
 
 			break;
 		default:
@@ -1687,18 +1683,18 @@ static int nsp32_busfree_occur(struct scsi_cmnd *SCpnt, unsigned short execph)
 		/* MsgIn 00: Command Complete */
 		nsp32_dbg(NSP32_DEBUG_BUSFREE, "command complete");
 
-		SCpnt->SCp.Status  = nsp32_read1(base, SCSI_CSB_IN);
+		nsp32_priv(SCpnt)->status  = nsp32_read1(base, SCSI_CSB_IN);
 		nsp32_dbg(NSP32_DEBUG_BUSFREE,
 			  "normal end stat=0x%x resid=0x%x\n",
-			  SCpnt->SCp.Status, scsi_get_resid(SCpnt));
+			  nsp32_priv(SCpnt)->status, scsi_get_resid(SCpnt));
 		SCpnt->result = (DID_OK << 16) |
-			(SCpnt->SCp.Status << 0);
+			(nsp32_priv(SCpnt)->status << 0);
 		nsp32_scsi_done(SCpnt);
 		/* All operation is done */
 		return TRUE;
 	} else if (execph & MSGIN_04_VALID) {
 		/* MsgIn 04: Disconnect */
-		SCpnt->SCp.Status  = nsp32_read1(base, SCSI_CSB_IN);
+		nsp32_priv(SCpnt)->status = nsp32_read1(base, SCSI_CSB_IN);
 
 		nsp32_dbg(NSP32_DEBUG_BUSFREE, "disconnect");
 		return TRUE;
@@ -1706,8 +1702,6 @@ static int nsp32_busfree_occur(struct scsi_cmnd *SCpnt, unsigned short execph)
 		/* Unexpected bus free */
 		nsp32_msg(KERN_WARNING, "unexpected bus free occurred");
 
-		/* DID_ERROR? */
-		//SCpnt->result   = (DID_OK << 16) | (SCpnt->SCp.Status << 0);
 		SCpnt->result = DID_ERROR << 16;
 		nsp32_scsi_done(SCpnt);
 		return TRUE;
diff --git a/drivers/scsi/nsp32.h b/drivers/scsi/nsp32.h
index ab0726c070f7..924889f8bd37 100644
--- a/drivers/scsi/nsp32.h
+++ b/drivers/scsi/nsp32.h
@@ -534,6 +534,15 @@ typedef struct _nsp32_sync_table {
       ---PERIOD-- ---OFFSET--   */
 #define TO_SYNCREG(period, offset) (((period) & 0x0f) << 4 | ((offset) & 0x0f))
 
+struct nsp32_cmd_priv {
+	enum sam_status status;
+};
+
+static inline struct nsp32_cmd_priv *nsp32_priv(struct scsi_cmnd *cmd)
+{
+	return scsi_cmd_priv(cmd);
+}
+
 typedef struct _nsp32_target {
 	unsigned char	syncreg;	/* value for SYNCREG   */
 	unsigned char	ackwidth;	/* value for ACKWIDTH  */
