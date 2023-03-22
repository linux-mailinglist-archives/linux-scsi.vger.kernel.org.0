Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C753E6C5543
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCVT4t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCVT4k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:56:40 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811F659E7B
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:56:29 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so20224035pjt.5
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oXRTU4ppzyaVUobHzxub2u25mIEKjp/3zCfs4JzFS8=;
        b=2nT9d1kQtyyWzIZF6mYmpBKWFJSGdvtyCcpDYeORaDG1mMSLCeash1xo1JAwMjg3wK
         kThrjO3fm9Cfjb1N5C+ScdAX/utF0skdpa/xGs4woEJomaSy7afgtOnBoAKqwp7NR+A3
         iD6pUl+ffc7jfi+J10tx3DyqEtw9hQDXEhQFlrY5hss+d1WcZ4hbEa6WdMBDiQliDxZZ
         lM7Llndgn1vs/APTdnBWTfWLJnshq8nXUhxV9jMBgOr+68mmOhMSAX6iGP4+Jx8bDTQh
         CMxvjisqfh5uM0IAu318KjrsJbiUAdNpS9IjAkXt/Fa12hB6nidYJ4iLQWf4QubAjW2Z
         t9Fg==
X-Gm-Message-State: AO0yUKWq2fap4KipegqAbJx1S6pNr47RnQ1dgao0RFE8CqUTyC3HrGLS
        5oCU5O6MhMLCUPiph8I6JceBl7SeBTA=
X-Google-Smtp-Source: AK7set9qTZv5aVbCEFLqzmSMBRJ2JCY6/h7/hnrs9s4PMQRmcMqtCfL7i/cwza7Z6xkovYkMdyco/g==
X-Received: by 2002:a17:90b:350e:b0:23f:2c65:fab7 with SMTP id ls14-20020a17090b350e00b0023f2c65fab7mr4714919pjb.42.1679514988965;
        Wed, 22 Mar 2023 12:56:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:56:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 08/80] scsi: zfcp: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:03 -0700
Message-Id: <20230322195515.1267197-9-bvanassche@acm.org>
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

Acked-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/s390/scsi/zfcp_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 3dbf4b21d127..b2a8cd792266 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -418,7 +418,7 @@ static int zfcp_scsi_sysfs_host_reset(struct Scsi_Host *shost, int reset_type)
 
 struct scsi_transport_template *zfcp_scsi_transport_template;
 
-static struct scsi_host_template zfcp_scsi_host_template = {
+static const struct scsi_host_template zfcp_scsi_host_template = {
 	.module			 = THIS_MODULE,
 	.name			 = "zfcp",
 	.queuecommand		 = zfcp_scsi_queuecommand,
