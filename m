Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9E25B50
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfEVAtg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46506 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfEVAtd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so159594pls.13
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5vkbR7OsLuKbrSI2TPtp/d7+DOzMcDSb1ztVyrbXNRg=;
        b=SWGccQJ/3+Qa6JgUeFiM+8ff8z289nyK5sSl4jpQmX8UykuUEzGjt8sgA2Q1PBr4K7
         35jatL4FzL9r+0prSQQz2ueEyBWFFvd63MUJh7Btpxn4Hm7eN7iQHs7GZFqyInrJFR6y
         Sk5XsC6m3nvWJKotZDGTzjrKws5SiAzEP+RHEeq5EhfdsZm0FP/lRe4boyxjuiHas59d
         Yi3XERsrPEMJyoKwR5VLmbjsOxVNI3ldj2xsC3NifOmanBJ8WmiOyXvjt1GBadiZdtUC
         wpDrT8DjFqhVnb9vmAlMeLfbKV9evMmcHmEl9pHlH3E7J6zrCgfErZzsS7pIrYU6NDMk
         KhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5vkbR7OsLuKbrSI2TPtp/d7+DOzMcDSb1ztVyrbXNRg=;
        b=AQMkqiIrCbApNtJIXbwBz3szcgqWgX63u+FB/9ifoaiC0YfVSk+WIQOigss/HOs0FL
         vRmxArdIWbWP3QwYKF0Q1xMx8Cs4BKhWj0p4+dH4Ryz15J+GnP94BGOf8VgY97Vl7H4T
         XyfEOcI3QvONUOA8IddPwaE8Z3d12Cq415XfHZPIXGyoYIeykNmGLnyv5xKK60TSktSZ
         0WbjXHu9AoFkfnspg5KhF0Qba9MFsies0FjboB/INDfHyuOt2JpHtfUHiS9AcQ1XIBCj
         zDvzWV3taSoNrQixTasUf1nYI32rxabdysJmLzXPfrFNBtUPXoDE1q2ux53OJb8lBnFE
         LfiA==
X-Gm-Message-State: APjAAAXq3DrNjSr/uzan2xPsRnZy9UrxagO4xp2/VN5eh9U1B1BG4b6E
        zLc5v/DebuNRdzO6c7WkKxQ+p1B+
X-Google-Smtp-Source: APXvYqzfINsFBTDBLaECzkpSffLf5fRbM7qCvqCtWsJ1vny6zpIqeDRqwwKzxVpuj55JLCVokfLnhg==
X-Received: by 2002:a17:902:12d:: with SMTP id 42mr79584201plb.4.1558486173056;
        Tue, 21 May 2019 17:49:33 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:32 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 14/21] lpfc: Fix incorrect logical link speed on trunks when links down
Date:   Tue, 21 May 2019 17:49:04 -0700
Message-Id: <20190522004911.573-15-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Invalid logical speed is displayed for trunk enabled ports when all
ports are down. Also noted that link speed is incorrectly reported
for the units when links are up.

Current code is returning the logical link speed from the last event
from the adapter. In cases where the last link went down, the link
speed in the event was not valid - meaning that although the links
where down the field had a bogus value.

Rework the event handling to qualify the trunk link state before
using the event speed data.

Also correct units on other areas where the logical link speed
was taken from a link event.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c  |  2 +-
 drivers/scsi/lpfc/lpfc_init.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index b0202bc0aa62..b7216d694bff 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -5741,7 +5741,7 @@ lpfc_get_trunk_info(struct bsg_job *job)
 
 	event_reply->port_speed = phba->sli4_hba.link_state.speed / 1000;
 	event_reply->logical_speed =
-				phba->sli4_hba.link_state.logical_speed / 100;
+				phba->sli4_hba.link_state.logical_speed / 1000;
 job_error:
 	bsg_reply->result = rc;
 	bsg_job_done(job, bsg_reply->result,
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 1468a4d7c501..73b77aaf7135 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -5055,7 +5055,7 @@ lpfc_update_trunk_link_status(struct lpfc_hba *phba,
 				bf_get(lpfc_acqe_fc_la_speed, acqe_fc));
 
 	phba->sli4_hba.link_state.logical_speed =
-				bf_get(lpfc_acqe_fc_la_llink_spd, acqe_fc);
+				bf_get(lpfc_acqe_fc_la_llink_spd, acqe_fc) * 10;
 	/* We got FC link speed, convert to fc_linkspeed (READ_TOPOLOGY) */
 	phba->fc_linkspeed =
 		 lpfc_async_link_speed_to_read_top(
@@ -5158,8 +5158,14 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 				bf_get(lpfc_acqe_fc_la_port_number, acqe_fc);
 	phba->sli4_hba.link_state.fault =
 				bf_get(lpfc_acqe_link_fault, acqe_fc);
-	phba->sli4_hba.link_state.logical_speed =
+
+	if (bf_get(lpfc_acqe_fc_la_att_type, acqe_fc) ==
+	    LPFC_FC_LA_TYPE_LINK_DOWN)
+		phba->sli4_hba.link_state.logical_speed = 0;
+	else if	(!phba->sli4_hba.conf_trunk)
+		phba->sli4_hba.link_state.logical_speed =
 				bf_get(lpfc_acqe_fc_la_llink_spd, acqe_fc) * 10;
+
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 			"2896 Async FC event - Speed:%dGBaud Topology:x%x "
 			"LA Type:x%x Port Type:%d Port Number:%d Logical speed:"
-- 
2.13.7

