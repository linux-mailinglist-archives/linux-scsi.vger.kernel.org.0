Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8479D6B2DA8
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Mar 2023 20:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCITbD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Mar 2023 14:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCITaV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Mar 2023 14:30:21 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10DF7EE6
        for <linux-scsi@vger.kernel.org>; Thu,  9 Mar 2023 11:29:35 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so6486245pjb.5
        for <linux-scsi@vger.kernel.org>; Thu, 09 Mar 2023 11:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678390175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGld+nXB8xoLCjPdJf78FkMSomKl6XlXAp76vIAuqrw=;
        b=qBE31fKCVnblEmhtxOriuT+2jr3X4CNFqzHfzVFM2XRZdUg/tR/SCPC9khcFHjnROO
         WpjWSLdCYNSLlR3UtibKS+mKLFbhq+koQVKtNfDmcF4UkEILMKnnV4IrjYx4fBc+yFGl
         np2rJDFg2CWW2ACI0XyTjQ7rbzHTUnhR1OO556PvsielgCH4y8k5nTtNHep+FOQMCLeV
         Z5GoPigX05dPuTJAXDd3uhLCWzMaWEWRwaO1ZOhZhW5MnDOqt3zE1IteBhfs97+Pe9M5
         UlHG4C1avXU8nMHMJk8ksUBLv8+cH1xhnxz0ZtaYnnzz7MxBEWQf2fOh1DMj2/dUP7Fi
         uhow==
X-Gm-Message-State: AO0yUKWRP5dWq7rDd4QgBYp9CPazHaM1MKeO/igg8J4nwsqlgz9LEJ7p
        h9CGAz9j8XV/2hEyQ8bb5ZA=
X-Google-Smtp-Source: AK7set+hvgSbVnmXv3AB1BkxRmRlxSazA4nolNsoO2NsHoKvHBnqoZWLxxfgVwYFN+W9KslvBpF+Bw==
X-Received: by 2002:a05:6a20:d003:b0:cd:6c14:9854 with SMTP id hu3-20020a056a20d00300b000cd6c149854mr17980484pzb.26.1678390175286;
        Thu, 09 Mar 2023 11:29:35 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf9f:35c8:4915:cb24])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b0058d8f23af26sm11570955pff.157.2023.03.09.11.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 11:29:34 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 60/82] scsi: myrs: Declare SCSI host template const
Date:   Thu,  9 Mar 2023 11:25:52 -0800
Message-Id: <20230309192614.2240602-61-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230309192614.2240602-1-bvanassche@acm.org>
References: <20230309192614.2240602-1-bvanassche@acm.org>
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
