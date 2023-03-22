Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B956C5620
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCVUDS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCVUCb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 16:02:31 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ABF6C1AB
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:59:22 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id j13so19509221pjd.1
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVABtwuKLCZjlgGg9Kihk5ZhKjkBAw+8Lgw+lSIbQNc=;
        b=nLbADDuEHzM5/6KwYaH8sQCf5jHh9ppCFO6I+SIEBXIMCRcjjDs803kACuJsk26sel
         l+/+MdfvcfIXSsvQ6+aArEO5eoOF65H1di9bq0kLIJ+LpOPXjTz2eXlbQ9DtYDm3sJK6
         eicc0fRmOzcgjlQiEZRYOyLgvSJ73kqOvBaxQityM56+AcwyLRUEqTIquznaVLuZN2WQ
         In8PDc4iD9GXst2/3k4eKoid1KmgXb6a7K9XWcV2FXi3Nefc5WXAKNnJAcA0c+tWjLZ0
         ST4RNmO/YTFeDyl5uH823mbSeQkmT/HJudW458THTLmBixCXdZAybW8KrK5mnUNlM6PQ
         wG7Q==
X-Gm-Message-State: AO0yUKWKVH/5O05pU0HR3cWVNbVnfWPh8u4FKQNoqHJG2/9txXE1EHfF
        8TtuBKak6R2ykA+N/RG3ceQ=
X-Google-Smtp-Source: AK7set+zPx2rTkTUFAf1QwxIUCaByFbia4l+qNcWmc8pNZkDgBbOqLv6KTYCcYh2te9vn7A2vSGlJA==
X-Received: by 2002:a17:90b:33c5:b0:237:40a5:7cb9 with SMTP id lk5-20020a17090b33c500b0023740a57cb9mr4985462pjb.5.1679515139677;
        Wed, 22 Mar 2023 12:58:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:58:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 77/80] scsi: rts5208: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:55:12 -0700
Message-Id: <20230322195515.1267197-78-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322195515.1267197-1-bvanassche@acm.org>
References: <20230322195515.1267197-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make it explicit that the SCSI host template is not modified.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/staging/rts5208/rtsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..db2dd0baa8be 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -191,7 +191,7 @@ static int device_reset(struct scsi_cmnd *srb)
  * this defines our host template, with which we'll allocate hosts
  */
 
-static struct scsi_host_template rtsx_host_template = {
+static const struct scsi_host_template rtsx_host_template = {
 	/* basic userland interface stuff */
 	.name =				CR_DRIVER_NAME,
 	.proc_name =			CR_DRIVER_NAME,
