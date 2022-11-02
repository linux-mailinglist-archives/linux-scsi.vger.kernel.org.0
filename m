Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A9615BD2
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Nov 2022 06:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKBFbj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Nov 2022 01:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKBFbc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Nov 2022 01:31:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B2B23396
        for <linux-scsi@vger.kernel.org>; Tue,  1 Nov 2022 22:31:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso933910pjc.5
        for <linux-scsi@vger.kernel.org>; Tue, 01 Nov 2022 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX3TbmGjInf7cKqyQc4waVJupgYK+B/rVkHEoTnFRb4=;
        b=WmFdW8gZmTpS4JhdK4R6MvnFBKs6rBEo8fVdPzp1KND8PXgiJMdHlvE5eYNyXJB/+f
         gSYJ8Q87Brp3EQOwkAcvUDQBBYXkl3R/DuDsHRehLXjewwPROyOCUTqA2vOMBe0g7WTR
         l64X3Q3hImetK3Idhf1+jmJX//aC7A4yVa4BJjILGtyE1XHWgQ76bunNqGP2EQCaAA9c
         X6LYNFZ8kIK47xOriZHVN7rVFOji96Mc4Sw//d3nCp9OheED28+10HCLI5W0q8eTl0Ts
         L6Zg9veJMlQ3Nd6DuewE1X9wmJ56PMf4Oz8asebmHFT02XIVkg+1s/gwXoK4+PPwS0d9
         hT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX3TbmGjInf7cKqyQc4waVJupgYK+B/rVkHEoTnFRb4=;
        b=KlZiVKCTqN7zln5nPbrl5dmbQaebSM2jn57FvSEs0uJlmaX4pwfeBWedURR0X+0DCU
         EdU6UfASGfIZnf6kVmIunnEWfMv8DEV/StZYVJlb4lNzzsYOJBtnz2RBKXDcuFS4pqK3
         XmJwjwN34dzG7mnpVlalUOOzSLnFfb97meo6yMe2ieyvMnJ9cuxM53ilLC3c/DDMmuic
         xm616z8vpQhSP9nIz/qrU4zqCLmWR4dS5I7yJo25WhgIoy7u0/K5k8GjZuaNQJEpbVRM
         tQYsgfZf9wJ4q1fujdxqiaZQrw1r/ZqyUDvhe7fZvOMFVEmUh0pKIBz+c+alSvyM+3YB
         CqOQ==
X-Gm-Message-State: ACrzQf0+gLWSEXojvKh60ev7lkVZPWxDuc/6wztrFJyfhOeO/J+0sVii
        /hKa5fXr7l4WVrWF7ZSB1EJjuA==
X-Google-Smtp-Source: AMsMyM7tTDK6u9L0KtTscd2g1O2p7Ao40FmYOBSprZ+ACxENSFHl+EVRXBkaZNaW8BptsL7qk/6gAA==
X-Received: by 2002:a17:90b:3883:b0:213:a9e8:492c with SMTP id mu3-20020a17090b388300b00213a9e8492cmr22507685pjb.77.1667367091142;
        Tue, 01 Nov 2022 22:31:31 -0700 (PDT)
Received: from ubuntu18.mioffice.cn ([2408:8607:1b00:7:9e7b:efff:fe41:a22a])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b00186b69157ecsm7276367plg.202.2022.11.01.22.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 22:31:30 -0700 (PDT)
From:   Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: [RESEND PATCH 1/4] scsi:ufs:remove sanity check
Date:   Wed,  2 Nov 2022 13:30:55 +0800
Message-Id: <20221102053058.21021-2-lijiaming3@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: lijiaming3 <lijiaming3@xiaomi.com>

UFS descriptors assumed to have a 2 bytes header:
 - Offset 0 - descriptor size
 - Offset 1 - descriptor id
However, the ufs spec does not mandates this, and as a matter of
fact, QUERY_DESC_DESC_TYPE_OFFSET is not being used anymore now.
And future descriptors no longer follow this assumption. So
remove this as preparation of introducing the FBO descriptor.

Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
---
 drivers/ufs/core/ufshcd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b1f59a5fe632..4bc5b8563a62 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3458,14 +3458,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 		goto out;
 	}
 
-	/* Sanity check */
-	if (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] != desc_id) {
-		dev_err(hba->dev, "%s: invalid desc_id %d in descriptor header\n",
-			__func__, desc_buf[QUERY_DESC_DESC_TYPE_OFFSET]);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	/* Update descriptor length */
 	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];
 	ufshcd_update_desc_length(hba, desc_id, desc_index, buff_len);
-- 
2.38.1

