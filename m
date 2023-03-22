Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26146C55C4
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCVUAz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCVT74 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:59:56 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66525CED1
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:23 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id o2so12888279plg.4
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGld+nXB8xoLCjPdJf78FkMSomKl6XlXAp76vIAuqrw=;
        b=k5Ldz/3bIKStxR50ImRpFDiFdGuTtDaoaD0GwWpfBtChF4Ysc4iYD/GPvtK2h/lQbC
         210CdGe31alvjp7qaRFsYWdof+RwXgdOYRi8xWnL/ncrK/ab09rtNI5oAJpurW0utMf/
         ncQSW6uUJhCe0sVSoK4kUJLdIKKbmtltBgiMcRcPT/8JSES6nNwvwe81u+IT5+yqj3+v
         bJfF3L4JAPZ+h6f0UpHRuY3IGG4AQmysgcbabq7TvrMgCb6Xak2Zj9CuC9Po15IFctof
         QqhNEqYtAZaFV9b+avwxit8FxQvC5RdfhX9TVWAOcerwfrV0CCAFsBV8hOlDD0YnJhJ0
         Lbqg==
X-Gm-Message-State: AO0yUKUdzZxjQjGeABdR3fc0v1yIRJjHU03pzn1viKAg45XzK4rJitG9
        zy0PX74N5Okw1zPmF1CJYkk=
X-Google-Smtp-Source: AK7set9VkSHezmWhOmxNdN7BtRvVLB48Ll+MtGW3SXDZj784GbOkhLBmG6KeFm6MqfgyB9yDtnqa9Q==
X-Received: by 2002:a17:90b:350f:b0:23b:bf03:397e with SMTP id ls15-20020a17090b350f00b0023bbf03397emr5199384pjb.24.1679515103070;
        Wed, 22 Mar 2023 12:58:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:58:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 59/80] scsi: myrs: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:54 -0700
Message-Id: <20230322195515.1267197-60-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322195515.1267197-1-bvanassche@acm.org>
References: <20230322195515.1267197-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make it explicit that the SCSI host template is not modified.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/myrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 7eb8c39da366..a1eec65a9713 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1915,7 +1915,7 @@ static void myrs_slave_destroy(struct scsi_device *sdev)
 	kfree(sdev->hostdata);
 }
 
-static struct scsi_host_template myrs_template = {
+static const struct scsi_host_template myrs_template = {
 	.module			= THIS_MODULE,
 	.name			= "DAC960",
 	.proc_name		= "myrs",
