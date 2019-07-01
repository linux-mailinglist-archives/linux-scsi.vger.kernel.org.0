Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A538658905
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfF0RoT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Jun 2019 13:44:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33532 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfF0RoT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Jun 2019 13:44:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so1693723plo.0;
        Thu, 27 Jun 2019 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fMSiZev5TC+RJzc16L/mj1DXSyzROvrHBBpdoAkI4pA=;
        b=j1qZqxDCY1SE+3POtAF4fIPpydkT991PUh1oofQZPKaJWSjB2/xoYZzpkrowByRCze
         bdbOdV661xZNJCqkUSmqEBvRG99kwldxO16Vu17L69JFTnln0hOPns87XE3PmRH1lUva
         PCAzjXFm28A+9bZ6VQrDsbIL5B0Rww50JQesQh2osh4oDE6/JWHriV1v0dC96U68cn+/
         ILiYp93BJOPXr5LQ0U/YUII3kSgiYrADhhUrBmehJ3a/+4snMWRacFWUGJvwFgwOxmjB
         POdvKmQUsXwCyOhtlU4Q1osXDT6dfbNJJjsRFmNIwudAqH1yEyDf+QptNmHDsOtGHFrC
         ZxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fMSiZev5TC+RJzc16L/mj1DXSyzROvrHBBpdoAkI4pA=;
        b=c50tc2YLiS+zp6uZWJF6TTuP7vJWtAj0ppRgRqBPA2IoBsQiX4ef2gbkkJO/hmsu/U
         KtWoHZVgwzjEN1a4GAEk4YpmtirWfizPtJCv0sBEKvJWw2obBjU6e/OLaKDFlrLjcJxk
         fsK1HaXclaW65zkQoozVaBU2Sdx0udnUyMvHp0Bh/ax3bRpfIOZD+XxAltMAe/6xe0hj
         N75IEzQE4CBJ6whM0Ugdk6jBmlwRFYRMK4iB1AT8Ol1Cqhqq4eFSeRTllm0T+/iqhzn5
         rka82LVSvs1iJ+76FHgfmPd7RJN/G6VfaWzGdZ9ASJxf8bxM2uGNglQkYr4xrFTBUsCS
         Tvwg==
X-Gm-Message-State: APjAAAWTUpJvey1Q90z+D0r7ljkbB5ElFni7Kve7rry/dU3f7IaP9hP8
        tP2kg7lD2+euFCczpr5v5ps=
X-Google-Smtp-Source: APXvYqz6DciFrJAZR8kflqpCUghCNuNS4CyzELd9ZB59oZi5uUdIFGgT4WxsfhD/mnIoQXiwQqYt5Q==
X-Received: by 2002:a17:902:f087:: with SMTP id go7mr6033850plb.330.1561657458740;
        Thu, 27 Jun 2019 10:44:18 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id w7sm3978503pfb.117.2019.06.27.10.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:44:18 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 59/87] scsi: mpt3sas: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:44:05 +0800
Message-Id: <20190627174406.5360-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 60ae2d0feb2b..b09af57840d8 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -1111,7 +1111,6 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	rc = -EINVAL;
-	memset(data_out, 0, sz);
 	phy_error_log_request = data_out;
 	phy_error_log_request->smp_frame_type = 0x40;
 	phy_error_log_request->function = 0x11;
@@ -1401,7 +1400,6 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	rc = -EINVAL;
-	memset(data_out, 0, sz);
 	phy_control_request = data_out;
 	phy_control_request->smp_frame_type = 0x40;
 	phy_control_request->function = 0x91;
-- 
2.11.0

