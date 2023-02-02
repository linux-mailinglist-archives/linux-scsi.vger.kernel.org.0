Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D503688987
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Feb 2023 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjBBWEd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Feb 2023 17:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjBBWEc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Feb 2023 17:04:32 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038AFB2
        for <linux-scsi@vger.kernel.org>; Thu,  2 Feb 2023 14:04:32 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id q9so2370158pgq.5
        for <linux-scsi@vger.kernel.org>; Thu, 02 Feb 2023 14:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0DMeyMy5HWqMb16NZC6T3JB2JZZxY6/UJbJQf+vKGY=;
        b=EhyuLUI60spw3xeKY44YROwVAAvucVJf6fd1KBavIOx3dQfjZo+UXyJ2ooJ24M7F6R
         c4UJXG/eDUOUpo6f9P3huNLFOZa+GYx6/CurIpZ4aYC1usqQRQomKHwBZ26g981bstZo
         NOTfInMhtSQEqXN+Fsj6hf4fbEwUspZR53pSRGbfGVnfaYI8XeuKGCg48yyzvFRRZVfH
         dUP/r4cudJG6ldNli6NVg8QkTxJ/wr9VJdSWDNQgcA+CWCHy6BCJLm3a9kYa7NeJEyaZ
         1aQsd7Q7rvvxj6qx5CIyF3Zd92lhvsndwMyWyqUj69TEOOI6Zs+jELsYc0RJcRHpDAhS
         8sqQ==
X-Gm-Message-State: AO0yUKWaXsblZDj3Evyls68xE03g82rC0JXeHjoGpJHHWnkqAk6rMcnJ
        U3B1iGikaGzzi/KQDqVtARU=
X-Google-Smtp-Source: AK7set/mpWtTqQZqOd4jAavMMUXlkkaK3t4dPhCIdCRziIl+lpCzwpTnT0BLcC5fVDe6pBXvb0qY0g==
X-Received: by 2002:a05:6a00:1c96:b0:593:893f:81d7 with SMTP id y22-20020a056a001c9600b00593893f81d7mr6253091pfw.16.1675375471632;
        Thu, 02 Feb 2023 14:04:31 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf7f:37aa:6a01:bf09])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0057fec210d33sm160530pfr.152.2023.02.02.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:04:30 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>
Subject: [PATCH 2/2] scsi: ufs: Simplify ufshcd_execute_start_stop()
Date:   Thu,  2 Feb 2023 14:04:12 -0800
Message-Id: <20230202220412.561487-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230202220412.561487-1-bvanassche@acm.org>
References: <20230202220412.561487-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use scsi_execute_cmd() instead of open-coding it.

Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 89a78a0f794c..bf3cb12ef02f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9121,34 +9121,16 @@ static int ufshcd_execute_start_stop(struct scsi_device *sdev,
 				     enum ufs_dev_pwr_mode pwr_mode,
 				     struct scsi_sense_hdr *sshdr)
 {
-	unsigned char cdb[6] = { START_STOP, 0, 0, 0, pwr_mode << 4, 0 };
-	struct request *req;
-	struct scsi_cmnd *scmd;
-	int ret;
-
-	req = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
-				 BLK_MQ_REQ_PM);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	scmd = blk_mq_rq_to_pdu(req);
-	scmd->cmd_len = COMMAND_SIZE(cdb[0]);
-	memcpy(scmd->cmnd, cdb, scmd->cmd_len);
-	scmd->allowed = 0/*retries*/;
-	scmd->flags |= SCMD_FAIL_IF_RECOVERING;
-	req->timeout = 1 * HZ;
-	req->rq_flags |= RQF_PM | RQF_QUIET;
-
-	blk_execute_rq(req, /*at_head=*/true);
-
-	if (sshdr)
-		scsi_normalize_sense(scmd->sense_buffer, scmd->sense_len,
-				     sshdr);
-	ret = scmd->result;
-
-	blk_mq_free_request(req);
+	const unsigned char cdb[6] = { START_STOP, 0, 0, 0, pwr_mode << 4, 0 };
+	const struct scsi_exec_args args = {
+		.sshdr = sshdr,
+		.req_flags = BLK_MQ_REQ_PM,
+		.rq_flags = RQF_PM,
+		.scmd_flags = SCMD_FAIL_IF_RECOVERING,
+	};
 
-	return ret;
+	return scsi_execute_cmd(sdev, cdb, REQ_OP_DRV_IN, /*buffer=*/NULL, 0,
+			 /*timeout=*/HZ, /*retries=*/0, &args);
 }
 
 /**
