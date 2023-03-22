Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF86C5584
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 20:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCVT7H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjCVT6A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:58:00 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E265068
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:41 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id le6so20266871plb.12
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksKFgRH4rYvlBG1yS/w98H9HGUxvKE6kRBa+hfKL1B0=;
        b=M3kg2O7KUbMsVtcewkqmtAUPn33uTF1Q986xpdaoO+LXRc/By4huqRoILIZuq9jIuq
         3WydL1lB12c2fK9Cf8BY+wUfuP029oy4Cfwt1fU9j80o2uZfWLE37SZP+7IiGt0pkTOh
         YQoiFu82RzTfuHHQeTeIt7BU+q0U0stD0KAxMYv5LNVKKNnti5O7D0JaiGXKyPI14KQJ
         8qWbFcYmK6YQkT5WGEM9bg901w0Ma53p4mCR9KvqhjdAssGtpfzrb/qL3lmwET6AvhwG
         yXwdlWcC5n8OpUkCXlMcvotH6HG6aatRxZHSPO4uVhpEU3FKKeDuoafjJnHZDyUowwa1
         yeCg==
X-Gm-Message-State: AO0yUKVK1jjeib63Ae45fRp9b0iPYWV7NI6edM1npHH/y6fijrP74VU6
        LZFOBYM6FOkquveoJ9Op+Ao=
X-Google-Smtp-Source: AK7set/bQIwwtBb/ZxisBp2+UVRVUuU8JLlzEzZCE4SLgr93zFDaXwnpbLcdfC85fFBwAJ0ckxRwPg==
X-Received: by 2002:a17:90b:4c4d:b0:23e:2b3c:d4a7 with SMTP id np13-20020a17090b4c4d00b0023e2b3cd4a7mr4338703pjb.35.1679515061454;
        Wed, 22 Mar 2023 12:57:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:57:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 45/80] scsi: imm: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:40 -0700
Message-Id: <20230322195515.1267197-46-bvanassche@acm.org>
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
 drivers/scsi/imm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 7a499d621c25..07db98161a03 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -1096,7 +1096,7 @@ static int imm_adjust_queue(struct scsi_device *device)
 	return 0;
 }
 
-static struct scsi_host_template imm_template = {
+static const struct scsi_host_template imm_template = {
 	.module			= THIS_MODULE,
 	.proc_name		= "imm",
 	.show_info		= imm_show_info,
