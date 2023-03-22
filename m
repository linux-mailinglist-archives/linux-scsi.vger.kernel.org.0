Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39CA6C5564
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCVT6E (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 15:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCVT5h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:57:37 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B146A05E
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:15 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso24687825pjb.0
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFvxo/sJNe3B0K/5I7wr+cSfqXHj+OqtPwyJqG3lYLo=;
        b=MVKss67bFKguOMtIEjlwHHPsatFTzmFEcVF3CZUIQtFZRj8vha6n1xLy+dJLyo/rY8
         5Z0rJD/DZ33peGomRUElxnj6OHDNQw2A3L+sumPZZnZFasByRNl7M5eWdqH4Wh6kCI31
         xJjeF0+9fW+7hYUuX6Iy2OipgmspQtPsQIx+kUiskl+NpGTUnSnuJLaxNnz5H/l7ECOT
         knnov24lG6UbU68lo6WOSG4Kj7EYbGWanHZFYnaPfwImPOdpCtNm3yrU1hlHEQgJ99gZ
         6Vo5OcDG2DfJn+7O3Y7pS/YlHXJKIgjvMnr2/LitzLY870FL9zyChbqSno48y1lD9lmc
         /98Q==
X-Gm-Message-State: AO0yUKUHvBC+tI43laHFu6uoW4GW9ToRkSjNpoDCvw21agvbii0rMjZx
        6UQLyBTob/ghgbPwdryOLI0=
X-Google-Smtp-Source: AK7set8HAuVlzUpKmSMGywWdqc2wG+udlceedkWJxajdCtLq5jaXIPwaUGdWx1VMmg+/MX7UoEDaiw==
X-Received: by 2002:a17:90b:4b43:b0:23f:680e:78be with SMTP id mi3-20020a17090b4b4300b0023f680e78bemr4262310pjb.48.1679515034955;
        Wed, 22 Mar 2023 12:57:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:57:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 31/80] scsi: dmx3191d: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:26 -0700
Message-Id: <20230322195515.1267197-32-bvanassche@acm.org>
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
 drivers/scsi/dmx3191d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dmx3191d.c b/drivers/scsi/dmx3191d.c
index a171ce6b70b2..dfb091d34363 100644
--- a/drivers/scsi/dmx3191d.c
+++ b/drivers/scsi/dmx3191d.c
@@ -39,7 +39,7 @@
 #define DMX3191D_REGION_LEN	8
 
 
-static struct scsi_host_template dmx3191d_driver_template = {
+static const struct scsi_host_template dmx3191d_driver_template = {
 	.module			= THIS_MODULE,
 	.proc_name		= DMX3191D_DRIVER_NAME,
 	.name			= "Domex DMX3191D",
