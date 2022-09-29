Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75875F00EC
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Sep 2022 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiI2WqN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Sep 2022 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiI2Wpo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 29 Sep 2022 18:45:44 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF70126109
        for <linux-scsi@vger.kernel.org>; Thu, 29 Sep 2022 15:44:53 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id b23so2672301pfp.9
        for <linux-scsi@vger.kernel.org>; Thu, 29 Sep 2022 15:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oHIU87340HTf+1cVSJxwNoDJwwchCbWiuG0K/QTNUSs=;
        b=Y8/cKYuDH0bUvCI8EGwzTdpB4JcWsTAiG+nIkNM9C6mspOX1C1RWSu4B5iaFel8B81
         +HmnATt9jbc6QK2HSHses6go2Q471YuPoRGAAw2cHN49cptxaeiiCaEIhgTbAb5n5/hV
         LrcqDvF19HzZW4JF2zFKo3LAL5O0NPT1+PAew9YV9867YnphZ2jv0Kglqlp+Y3uIACDM
         vDfxYqMRwTWx6Dfw6Hz3i07jjDL2jPgbjad3K6+qpJfZEnC7RXo72FYoQbwHYb9Yyej0
         8SJeMBoXNuiPiG5PTE0iGsVpt7oFS/AcYsOg/L7ubmMy9WguOM+zSoxoQZlbdUhlvD4z
         192g==
X-Gm-Message-State: ACrzQf2OjrlqrgKKUupAtk7HsX+9FpfFrkeYEMTVptpR0uzrMtabEyrW
        SZyt3huD+JzbnYG2MdrykWA=
X-Google-Smtp-Source: AMsMyM5H7cVk2uB5hRYdx+9ALRAlNk23zETlgpM4/xjmT9cjzowv06c74wrdJgdQs0385IZJJKeMwQ==
X-Received: by 2002:a63:1455:0:b0:438:e26b:ab1f with SMTP id 21-20020a631455000000b00438e26bab1fmr4745981pgu.183.1664491493410;
        Thu, 29 Sep 2022 15:44:53 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016d1b70872asm404508plk.134.2022.09.29.15.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:44:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v6 7/8] scsi: core: Remove the put_device() call from scsi_device_get()
Date:   Thu, 29 Sep 2022 15:44:20 -0700
Message-Id: <20220929224421.587465-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220929224421.587465-1-bvanassche@acm.org>
References: <20220929224421.587465-1-bvanassche@acm.org>
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

scsi_device_get() may be called from atomic context, e.g. by
shost_for_each_device(). A later patch will allow put_device() to sleep
for SCSI devices. Hence this patch that removes the put_device() call
from scsi_device_get().

According to Rusty Russell's "Module Refcount and Stuff mini-FAQ",
calling module_put() from atomic context is allowed since considerable
time. See also https://lkml.org/lkml/2002/11/18/330.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 086ec5b5862d..87bddd697fc6 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -563,14 +563,14 @@ int scsi_device_get(struct scsi_device *sdev)
 {
 	if (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL)
 		goto fail;
-	if (!get_device(&sdev->sdev_gendev))
-		goto fail;
 	if (!try_module_get(sdev->host->hostt->module))
-		goto fail_put_device;
+		goto fail;
+	if (!get_device(&sdev->sdev_gendev))
+		goto fail_put_module;
 	return 0;
 
-fail_put_device:
-	put_device(&sdev->sdev_gendev);
+fail_put_module:
+	module_put(sdev->host->hostt->module);
 fail:
 	return -ENXIO;
 }
