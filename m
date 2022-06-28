Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F355F12B
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jun 2022 00:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiF1WZA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Jun 2022 18:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiF1WYq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Jun 2022 18:24:46 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3860A2494A
        for <linux-scsi@vger.kernel.org>; Tue, 28 Jun 2022 15:21:41 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id cv13so13866943pjb.4
        for <linux-scsi@vger.kernel.org>; Tue, 28 Jun 2022 15:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLQc2mCLu8msQ8/udarSByzM+S09Au/Kiel9Yxrmz+w=;
        b=Wc/qiMpP/RK1pQqvXRvfja856SpK76Fh+Js0cSACMi7ce+cDOptbwTOhl5kH8fJyQ0
         sKWOiwfHfYxJt+bvCsfO0cp5QfI4HFqZEeog4V5nE6t5E1brKBBThOupW2DFSSJNVWCL
         uXAnHAvfw/ngAHbqhhnhHSvtTkB7Taa2Z8Q8Rud1YIiquCh/aNx47GSIi9sGEwAttSCZ
         /SoG8uWTRbWFqdCeMUCsuMMNF/V7zebgWj3IM4Wh5lE+0aKWxfdJc5RuPinHecDJlEgT
         WH5bMqSQj3k0w8S8SsQcRXPBBvlQELng4VgqHdG8rcGTsg8B3wd9JPJ5Ec3ObH/+RZPW
         Kshw==
X-Gm-Message-State: AJIora9elEX3WRwbJCICPoy8QW17DONrIKBtl7cm2Won9u9PtHC5agIa
        6EY/dL2Ueq0vS4ZzBI2iZ5g=
X-Google-Smtp-Source: AGRyM1sWT0TP2c/MGvZze57DUSpMOgGKoYWCRu04vsmU1M++4EVticduBqlQQPZSzWsJCaObhT/ioA==
X-Received: by 2002:a17:90b:33d2:b0:1ed:2038:b949 with SMTP id lk18-20020a17090b33d200b001ed2038b949mr122605pjb.61.1656454900616;
        Tue, 28 Jun 2022 15:21:40 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a294900b001eaae89de5fsm413599pjf.1.2022.06.28.15.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:21:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] scsi: core: Retry after a delay if the device is becoming ready
Date:   Tue, 28 Jun 2022 15:21:30 -0700
Message-Id: <20220628222131.14780-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628222131.14780-1-bvanassche@acm.org>
References: <20220628222131.14780-1-bvanassche@acm.org>
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

If a logical unit reports that it is becoming ready, retry the command
after a delay instead of retrying immediately.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 49ef864df581..fb7e363c4c00 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -625,10 +625,10 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 			return NEEDS_RETRY;
 		/*
 		 * if the device is in the process of becoming ready, we
-		 * should retry.
+		 * should retry after a delay.
 		 */
 		if ((sshdr.asc == 0x04) && (sshdr.ascq == 0x01))
-			return NEEDS_RETRY;
+			return ADD_TO_MLQUEUE;
 		/*
 		 * if the device is not started, we need to wake
 		 * the error handler to start the motor
