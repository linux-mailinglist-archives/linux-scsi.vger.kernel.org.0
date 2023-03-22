Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01C66C5562
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 20:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCVT6C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCVT5b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:57:31 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC5F6A059
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:12 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id le6so20265782plb.12
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts+vWJKv0MXDJEA4JIO9+AM9uvvvxXowXRyy3KeGtYI=;
        b=VstA4XncyU1wn7gvYUBDdixz0s4WMGd30FoP8NqNY4WefqHzTqOTrMM514i1RCg8DN
         HcYeuuaZ9/Hi1VmQStd/IQJppI5jecwWrOPWZSkX2Qe0IK9vil+9TkYQbHqKBOxd5gIO
         4FJjxmAuZ6zfUymWlXtsrQ84D0n+uhmjof7/lfZaPiZ8w/BvxN8Q3dSyzxPS1g0cALFX
         TEVy4r2QTariJBklphpxU2byCcCdmU5JfBI8/DAFrtoXc4R7FaiOOZlxvJVzLy8X9InM
         iW25MGK2FXLS7cD2cg3bnt2zkC7kE3SKDLRnbJa1YE9cFNt7z0qHDiU3i3pjtv6vDYST
         nOJw==
X-Gm-Message-State: AAQBX9f3su7+3sCOo4aTBzQ75+5R4WNU/eCu6PhKMLuIuC32uOiloebM
        4vpcP+pPmdDNIK07nLKSF6o=
X-Google-Smtp-Source: AKy350aOJDTmJgS6CW7MXLOgeWdZ3e5rbKZkDCvslNo9HmLxSpna7PQYcDL6MjYy1H+feNpbw0kKqQ==
X-Received: by 2002:a17:90b:298:b0:240:c4c:59ea with SMTP id az24-20020a17090b029800b002400c4c59eamr2329274pjb.11.1679515032439;
        Wed, 22 Mar 2023 12:57:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:57:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 29/80] scsi: atp870u: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:24 -0700
Message-Id: <20230322195515.1267197-30-bvanassche@acm.org>
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
 drivers/scsi/atp870u.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index 7143418d690f..2a748af269c2 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -40,7 +40,7 @@
 
 #include "atp870u.h"
 
-static struct scsi_host_template atp870u_template;
+static const struct scsi_host_template atp870u_template;
 static void send_s870(struct atp_unit *dev,unsigned char c);
 static void atp_is(struct atp_unit *dev, unsigned char c, bool wide_chip,
 		   unsigned char lvdmode);
@@ -1726,7 +1726,7 @@ static void atp870u_remove (struct pci_dev *pdev)
 }
 MODULE_LICENSE("GPL");
 
-static struct scsi_host_template atp870u_template = {
+static const struct scsi_host_template atp870u_template = {
      .module			= THIS_MODULE,
      .name			= "atp870u"		/* name */,
      .proc_name			= "atp870u",
