Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E758D4BC086
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Feb 2022 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiBRTvw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Feb 2022 14:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbiBRTvq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Feb 2022 14:51:46 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C8291FAB
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:51:29 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id j4so7960229plj.8
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6hcTPTAbcTrOtT8jY+FWg4iCNywlNyNbCJma56j84E=;
        b=vrZ0I/szmaZ2osIygRuEosYZ0aC++jk/5xPtH1QtAU4Po13IdwXm8XzDTrd/0W0Y2O
         1NDlBBnkL91iLtit1GzKGBICgJ7n9kFKc+wClTY3GkvQ0rSdZZboW5QyNXlKds5TF5fj
         o41V2SqBZa0PcIqLH86v85p6ruMtMnGMaiiZvOY8WWT4RGTtVOSC/0xZJG2olJYpfT8y
         QtveU7qqcgueV/wI7jqrtQqhbon8EJcuH5s1m8nfB08XnGyWi8jg3Fduv5wMLREwb2dU
         ENpHMS2g6E/y8rJFy0xKYYJfcA8/FcTCd3k6Lod1NvIl89RaJCuLfMMIL+BRLpcCZ9ne
         +Zcw==
X-Gm-Message-State: AOAM5321nzLdGDMxbDAC99qQuu49qiXn77hG5omgKSKCyZ06CDCTZEPd
        69e8tJDTQ0Qqrav8m7PApEk=
X-Google-Smtp-Source: ABdhPJz6Lq3caM8+SitYP6lN0MLrAW9stdx424r4kshwqYPy5L8KKQar0kJHrPntE64BlatcrE0qQA==
X-Received: by 2002:a17:90b:352:b0:1b9:66bb:8034 with SMTP id fh18-20020a17090b035200b001b966bb8034mr14060801pjb.89.1645213888555;
        Fri, 18 Feb 2022 11:51:28 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id e15sm3930523pfv.104.2022.02.18.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:51:27 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 03/49] scsi: ips: Use true and false instead of TRUE and FALSE
Date:   Fri, 18 Feb 2022 11:50:31 -0800
Message-Id: <20220218195117.25689-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218195117.25689-1-bvanassche@acm.org>
References: <20220218195117.25689-1-bvanassche@acm.org>
MIME-Version: 1.0
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

This patch prepares for removal of the drivers/scsi/scsi.h header file.
That header file defines the 'TRUE' and 'FALSE' constants.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ips.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 59664e92ec8a..d22ba53d6028 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -945,7 +945,7 @@ static int __ips_eh_reset(struct scsi_cmnd *SC)
 			scsi_done(scsi_cmd);
 		}
 
-		ha->active = FALSE;
+		ha->active = false;
 		return (FAILED);
 	}
 
@@ -974,7 +974,7 @@ static int __ips_eh_reset(struct scsi_cmnd *SC)
 			scsi_done(scsi_cmd);
 		}
 
-		ha->active = FALSE;
+		ha->active = false;
 		return (FAILED);
 	}
 
@@ -1287,7 +1287,7 @@ ips_intr_copperhead(ips_ha_t * ha)
 		return 0;
 	}
 
-	while (TRUE) {
+	while (true) {
 		sp = &ha->sp;
 
 		intrstatus = (*ha->func.isintr) (ha);
@@ -1351,7 +1351,7 @@ ips_intr_morpheus(ips_ha_t * ha)
 		return 0;
 	}
 
-	while (TRUE) {
+	while (true) {
 		sp = &ha->sp;
 
 		intrstatus = (*ha->func.isintr) (ha);
@@ -3086,8 +3086,8 @@ ipsintr_blocking(ips_ha_t * ha, ips_scb_t * scb)
 	METHOD_TRACE("ipsintr_blocking", 2);
 
 	ips_freescb(ha, scb);
-	if ((ha->waitflag == TRUE) && (ha->cmd_in_progress == scb->cdb[0])) {
-		ha->waitflag = FALSE;
+	if (ha->waitflag && ha->cmd_in_progress == scb->cdb[0]) {
+		ha->waitflag = false;
 
 		return;
 	}
@@ -3387,7 +3387,7 @@ ips_send_wait(ips_ha_t * ha, ips_scb_t * scb, int timeout, int intr)
 	METHOD_TRACE("ips_send_wait", 1);
 
 	if (intr != IPS_FFDC) {	/* Won't be Waiting if this is a Time Stamp */
-		ha->waitflag = TRUE;
+		ha->waitflag = true;
 		ha->cmd_in_progress = scb->cdb[0];
 	}
 	scb->callback = ipsintr_blocking;
@@ -3464,10 +3464,8 @@ ips_send_cmd(ips_ha_t * ha, ips_scb_t * scb)
 		if (scb->bus > 0) {
 			/* Controller commands can't be issued */
 			/* to real devices -- fail them        */
-			if ((ha->waitflag == TRUE) &&
-			    (ha->cmd_in_progress == scb->cdb[0])) {
-				ha->waitflag = FALSE;
-			}
+			if (ha->waitflag && ha->cmd_in_progress == scb->cdb[0])
+				ha->waitflag = false;
 
 			return (1);
 		}
@@ -4615,7 +4613,7 @@ ips_poll_for_flush_complete(ips_ha_t * ha)
 {
 	IPS_STATUS cstatus;
 
-	while (TRUE) {
+	while (true) {
 	    cstatus.value = (*ha->func.statupd) (ha);
 
 	    if (cstatus.value == 0xffffffff)      /* If No Interrupt to process */
@@ -5538,26 +5536,26 @@ ips_wait(ips_ha_t * ha, int time, int intr)
 	METHOD_TRACE("ips_wait", 1);
 
 	ret = IPS_FAILURE;
-	done = FALSE;
+	done = false;
 
 	time *= IPS_ONE_SEC;	/* convert seconds */
 
 	while ((time > 0) && (!done)) {
 		if (intr == IPS_INTR_ON) {
-			if (ha->waitflag == FALSE) {
+			if (!ha->waitflag) {
 				ret = IPS_SUCCESS;
-				done = TRUE;
+				done = true;
 				break;
 			}
 		} else if (intr == IPS_INTR_IORL) {
-			if (ha->waitflag == FALSE) {
+			if (!ha->waitflag) {
 				/*
 				 * controller generated an interrupt to
 				 * acknowledge completion of the command
 				 * and ips_intr() has serviced the interrupt.
 				 */
 				ret = IPS_SUCCESS;
-				done = TRUE;
+				done = true;
 				break;
 			}
 
@@ -5592,7 +5590,7 @@ ips_write_driver_status(ips_ha_t * ha, int intr)
 {
 	METHOD_TRACE("ips_write_driver_status", 1);
 
-	if (!ips_readwrite_page5(ha, FALSE, intr)) {
+	if (!ips_readwrite_page5(ha, false, intr)) {
 		IPS_PRINTK(KERN_WARNING, ha->pcidev,
 			   "unable to read NVRAM page 5.\n");
 
@@ -5630,7 +5628,7 @@ ips_write_driver_status(ips_ha_t * ha, int intr)
 	ha->nvram->versioning = 0;	/* Indicate the Driver Does Not Support Versioning */
 
 	/* now update the page */
-	if (!ips_readwrite_page5(ha, TRUE, intr)) {
+	if (!ips_readwrite_page5(ha, true, intr)) {
 		IPS_PRINTK(KERN_WARNING, ha->pcidev,
 			   "unable to write NVRAM page 5.\n");
 
