Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024806AA674
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Mar 2023 01:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCDAe5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Mar 2023 19:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCDAeX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Mar 2023 19:34:23 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A365451
        for <linux-scsi@vger.kernel.org>; Fri,  3 Mar 2023 16:33:59 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id v11so4525051plz.8
        for <linux-scsi@vger.kernel.org>; Fri, 03 Mar 2023 16:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677890029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnK8Yqpa8id/oOS0MLZlCpDLRfS4lc4w7yWCDfvnNtc=;
        b=7gIA6vpQ9A+0ODcTjOcBau0lvbre7Eaurf6Wd9wh8VjLVB+HYygT4dpY6wSmGy31CZ
         oQndMfJYxRZ+FImRf7qIe+i4m3/bcWyzSD1lYeREfCjQil9rRXUFV6rnGoY1Hs44bv/b
         4tXo2SQgFpVOJtsDa/VqI9Ao1QCAhoI8011o1C2AFfEH7hZ2Y9plHnLl+ifNxWSl80q3
         q+vPETeaxRP3qaRR1lN58RkNIPSyI5eYYpUNiQPb/nwLmYY4goWzuQkza/e7N/nbA6rn
         h9SNOfzyKJ+0bDf2Z1H0lT8zpeb4VkgI+DpzAKZmoGjuIxV7f5gfNqXFTDpApqtAcJcx
         dhJQ==
X-Gm-Message-State: AO0yUKXVuUFld00uGJzAUKBpKodEDbqeDns47VwmOp8drigfZiqFqDDr
        lLxYvVC0x3McJr2nkT6xwLCCb4az1jE52Q==
X-Google-Smtp-Source: AK7set+X63YmO3ZZ9EpgaI4V2dlY2BEFPsTn/6AaC3l1XK6jRM2+T8RhgJR8CYiMMcQgQtaNzNBg+A==
X-Received: by 2002:a17:903:187:b0:19d:16fa:ba48 with SMTP id z7-20020a170903018700b0019d16faba48mr4341887plg.28.1677890029173;
        Fri, 03 Mar 2023 16:33:49 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:efb8:1cdc:a06f:1b53])
        by smtp.gmail.com with ESMTPSA id kk15-20020a170903070f00b00189743ed3b6sm2071078plb.64.2023.03.03.16.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 16:33:48 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 55/81] scsi: mvme147: Declare SCSI host template const
Date:   Fri,  3 Mar 2023 16:30:37 -0800
Message-Id: <20230304003103.2572793-56-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230304003103.2572793-1-bvanassche@acm.org>
References: <20230304003103.2572793-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make it explicit that the SCSI host template is not modified.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/mvme147.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mvme147.c b/drivers/scsi/mvme147.c
index 472fa043094f..98b99c0f5bc7 100644
--- a/drivers/scsi/mvme147.c
+++ b/drivers/scsi/mvme147.c
@@ -69,7 +69,7 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 	m147_pcc->dma_cntrl = 0;
 }
 
-static struct scsi_host_template mvme147_host_template = {
+static const struct scsi_host_template mvme147_host_template = {
 	.module			= THIS_MODULE,
 	.proc_name		= "MVME147",
 	.name			= "MVME147 built-in SCSI",
