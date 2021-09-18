Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64D41023F
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Sep 2021 02:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbhIRAJY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Sep 2021 20:09:24 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:54887 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbhIRAJR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Sep 2021 20:09:17 -0400
Received: by mail-pj1-f47.google.com with SMTP id i19so7998232pjv.4
        for <linux-scsi@vger.kernel.org>; Fri, 17 Sep 2021 17:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSrM2Z9Mg4h89R9uYoLr4hjxm8pWMZLJ41n8sRkf/Tc=;
        b=wU+E39o8yap/dxu7HM/AwlMSA68Lv0/SkfrroymtQ98uCqO5dsXLLMYg8tUE8sbdGq
         odDe8GJu5O3ADTGLD8wBMtBUfDyCQRbkgKpS8F2URJkveJY7KhgEfkOktorkbhcMS5Fz
         7ptQpIXdJJujaQD1kZtm0Ei2Nj/f4DUusnkljGL/eze/sgfAcJcCbR10Zy4T4tnXN4oP
         MN6KD+IEJjffgd6uyIWAWM8Mki2O5JjfLpkfEzHkMUkfabQcnsaEZhJRG6n9tHfS/5qA
         Vvvqmfql3NaiHMO564tSYXDKngZQJoyJdbkRnOOElHSlRHHchavrNpIMqAVze8cPkyK4
         DQ1w==
X-Gm-Message-State: AOAM533+GsjN0JA1KUU74GYIzvGjK4v/D4ATfgnNEyt+bwCS1IZKCcln
        vxop3HKN4exKuK36tU99kYxPHPzuOm2cSg==
X-Google-Smtp-Source: ABdhPJwakXnrsSdRlOeO/pYbEdCr/QCJjUg2np/oGWMZ1NRMQXpG52jmHHEAortfpbynsUvR7XNMzA==
X-Received: by 2002:a17:90a:a513:: with SMTP id a19mr24586854pjq.26.1631923674967;
        Fri, 17 Sep 2021 17:07:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:4c45:d635:d2d2:93])
        by smtp.gmail.com with ESMTPSA id bv16sm6403129pjb.12.2021.09.17.17.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:07:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 59/84] pmcraid: Call scsi_done() directly
Date:   Fri, 17 Sep 2021 17:05:42 -0700
Message-Id: <20210918000607.450448-60-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
In-Reply-To: <20210918000607.450448-1-bvanassche@acm.org>
References: <20210918000607.450448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Conditional statements are faster than indirect calls. Hence call
scsi_done() directly.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/pmcraid.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index bffd9a9349e7..11f36fd4e62f 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -837,7 +837,7 @@ static void pmcraid_erp_done(struct pmcraid_cmd *cmd)
 
 	scsi_dma_unmap(scsi_cmd);
 	pmcraid_return_cmd(cmd);
-	scsi_cmd->scsi_done(scsi_cmd);
+	scsi_done(scsi_cmd);
 }
 
 /**
@@ -2017,7 +2017,7 @@ static void pmcraid_fail_outstanding_cmds(struct pmcraid_instance *pinstance)
 				     le32_to_cpu(resp) >> 2,
 				     cmd->ioa_cb->ioarcb.cdb[0],
 				     scsi_cmd->result);
-			scsi_cmd->scsi_done(scsi_cmd);
+			scsi_done(scsi_cmd);
 		} else if (cmd->cmd_done == pmcraid_internal_done ||
 			   cmd->cmd_done == pmcraid_erp_done) {
 			cmd->cmd_done(cmd);
@@ -2814,7 +2814,7 @@ static int _pmcraid_io_done(struct pmcraid_cmd *cmd, int reslen, int ioasc)
 
 	if (rc == 0) {
 		scsi_dma_unmap(scsi_cmd);
-		scsi_cmd->scsi_done(scsi_cmd);
+		scsi_done(scsi_cmd);
 	}
 
 	return rc;
@@ -3328,7 +3328,6 @@ static int pmcraid_queuecommand_lck(
 	pinstance =
 		(struct pmcraid_instance *)scsi_cmd->device->host->hostdata;
 	fw_version = be16_to_cpu(pinstance->inq_data->fw_version);
-	scsi_cmd->scsi_done = done;
 	res = scsi_cmd->device->hostdata;
 	scsi_cmd->result = (DID_OK << 16);
 
@@ -3338,7 +3337,7 @@ static int pmcraid_queuecommand_lck(
 	if (pinstance->ioa_state == IOA_STATE_DEAD) {
 		pmcraid_info("IOA is dead, but queuecommand is scheduled\n");
 		scsi_cmd->result = (DID_NO_CONNECT << 16);
-		scsi_cmd->scsi_done(scsi_cmd);
+		scsi_done(scsi_cmd);
 		return 0;
 	}
 
@@ -3351,7 +3350,7 @@ static int pmcraid_queuecommand_lck(
 	 */
 	if (scsi_cmd->cmnd[0] == SYNCHRONIZE_CACHE) {
 		pmcraid_info("SYNC_CACHE(0x35), completing in driver itself\n");
-		scsi_cmd->scsi_done(scsi_cmd);
+		scsi_done(scsi_cmd);
 		return 0;
 	}
 
