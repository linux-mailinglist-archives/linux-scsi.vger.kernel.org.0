Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA766C55B8
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 21:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjCVUAl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCVT7v (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:59:51 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F15A193
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:22 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so9686725pjb.4
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mt+SALTZpgtMKMj3j2WTDo1ienCuaV/TBXYIRZ/PdNk=;
        b=OlRlUdbvvkMyGgrkccJRMVUcxgZ1E70qEgFCl5eTmmzffQIuJDk2ONf/yL5OL4pJgk
         zVpJ9sN6qlEqw6gJ97vjuqk5s1pjbqoSAiZH4Te6tYyZOYXbQelf4ftv7Csr1Uchdtjw
         Xw/rpZ/oGJ95bNdiqxDb1Sg/YR8RKS4FyeLDB/jrDnPG/UHfqg4Yb2yEfjBnMZSCibiG
         6IJmCQ7hibhz9h+VuLmNUHSFDpLJLm/XWurMmJAj2I6wLRDLa8T/zRUpnsf9F3qn6p0v
         n+VZjnA+KEEc9Z+H9KpoDfLh75EI6D7jj4RjRLO/8F0AxG2QaUp+kUuQus8h5yFP39ja
         AoOw==
X-Gm-Message-State: AO0yUKVqBbiJnPqYDBxlsJRVKZwG259X+/p+0pW2iC+jdeA7zocCrDvC
        yXNZnyk7r5L8j89b94aBw1Y=
X-Google-Smtp-Source: AK7set+5By458uBhDaGMdQXC2nABprwsbCjigDKOBI/A+nyD6pqWG1yIZpZkihuN2qNzYsub87OX5Q==
X-Received: by 2002:a17:90a:1d1:b0:23b:2963:ec94 with SMTP id 17-20020a17090a01d100b0023b2963ec94mr5036975pjd.29.1679515100474;
        Wed, 22 Mar 2023 12:58:20 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:58:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 57/80] scsi: mvumi: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:52 -0700
Message-Id: <20230322195515.1267197-58-bvanassche@acm.org>
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/mvumi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 60c65586f30e..73aa7059b556 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2168,7 +2168,7 @@ mvumi_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 	return 0;
 }
 
-static struct scsi_host_template mvumi_template = {
+static const struct scsi_host_template mvumi_template = {
 
 	.module = THIS_MODULE,
 	.name = "Marvell Storage Controller",
