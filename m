Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73106910CB
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Feb 2023 19:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBISxy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Feb 2023 13:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBISxv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Feb 2023 13:53:51 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE05FE68
        for <linux-scsi@vger.kernel.org>; Thu,  9 Feb 2023 10:53:47 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id u9so3915231plf.3
        for <linux-scsi@vger.kernel.org>; Thu, 09 Feb 2023 10:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DLyy3X9GHPQsj6fQXw22QEKR6ye8QKoRgQwiKwUuT8=;
        b=TYTxcgQcnu0On5cGyD1cBlnwfT9r7fJhpK0W0xkmZoqvdXjy/y/ceD+bFiZOBbfq/C
         56mt+2K9JBwCVeAECV/4MeqC0hORZR4272wxdqSWqZHrd0+Qw4+4vh3S/tRZN0j0moQW
         +nFAN3toMbV/j31k9oGdXWyTwS1rcDLrrRYo21nGAXh6jmuXWcnNpPj4dRTafttmFf3n
         wvNujsA4ntx8SVVtqeKA/SmLhzV9I4r9SoRpylUP4hxVwOOmgmYe2u0tdAwfJqeuFTfB
         jdPqXFaNirz8j7C3PxwSvcMQcKH4WygejEyF9qmLh0ZaHa9CDchGszVhNFMS46WPz6o2
         tQAw==
X-Gm-Message-State: AO0yUKVQmTRP7Wd6FStMmBTwXeyz8HFdWQQ1KyaQCqPTTKLAcVbgnj4r
        cK7Skdb+TqNp2U/nIlekLew=
X-Google-Smtp-Source: AK7set+LT+w0JaJnbc85N9yD0u2UNwsSs2IWxpiYceHsleY+igmU2adamL2WNcqJVUtFArWTvKLvaw==
X-Received: by 2002:a05:6a21:6d91:b0:c3:3143:26a2 with SMTP id wl17-20020a056a216d9100b000c3314326a2mr7202359pzb.23.1675968826799;
        Thu, 09 Feb 2023 10:53:46 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:15f5:48f5:6861:f3f6])
        by smtp.gmail.com with ESMTPSA id x18-20020a63b212000000b00478162d9923sm1603988pge.13.2023.02.09.10.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:53:46 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>
Subject: [PATCH v2 2/3] scsi: ufs: Rely on the block layer for setting RQF_PM
Date:   Thu,  9 Feb 2023 10:53:27 -0800
Message-Id: <20230209185328.2762796-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230209185328.2762796-1-bvanassche@acm.org>
References: <20230209185328.2762796-1-bvanassche@acm.org>
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

Do not set RQF_PM explicitly since scsi_alloc_request() sets it indirectly
if BLK_MQ_REQ_PM is set. The call chain for the code that sets RQF_PM is
as follows:

    scsi_alloc_request()
      blk_mq_alloc_request()
        __blk_mq_alloc_requests()
          blk_mq_rq_ctx_init()
            if (data->flags & BLK_MQ_REQ_PM)
              data->rq_flags |= RQF_PM;

Cc: Mike Christie <michael.christie@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0cfe112ff8c3..3512dcc152c8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9141,7 +9141,8 @@ static int ufshcd_execute_start_stop(struct scsi_device *sdev,
 	scmd->allowed = 0/*retries*/;
 	scmd->flags |= SCMD_FAIL_IF_RECOVERING;
 	req->timeout = 1 * HZ;
-	req->rq_flags |= RQF_PM | RQF_QUIET;
+	req->rq_flags |= RQF_QUIET;
+	WARN_ON_ONCE(!(req->rq_flags & RQF_PM));
 
 	blk_execute_rq(req, /*at_head=*/true);
 
