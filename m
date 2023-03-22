Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86FE6C55E5
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 21:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCVUB4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 16:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCVUA6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 16:00:58 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F51B6B949
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:46 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id c18so20279463ple.11
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5gBIhC8WBeIKUevKHd/72SKoMXkdl9EMvIEJ27ZMNk=;
        b=hC96xqolTcxo9u0Uw1vnUZbfDh6tnqTQ2hDWRCBs0j9QOI2ykoh0XyFTqKJ8jhUwVd
         hqBFYKLRzTMM86PZljL4znsbv16fRDopg5lscK7eT+gVtWRBgjvGqGbO/9OuWAYWC3uK
         7jLgiPdYxLJPv6q+Xrjp5lJ3aoScOi6fMK47CQpwq+9DQJirTHTXYjR4oFNP1n2Kee6b
         GKh93oBR+wjdf+4CStMbNq1AN0MKvi2M49zLHlNm+XIlGrBZpA0FJf22sU7xUqQ8c+nj
         Btt+OD+TfpV9SFtnbEk864DoZ9ZEbMrNKGbdF5D+0O9yA08cIUEQjBAhRmHQWt2gWTJk
         5jtA==
X-Gm-Message-State: AO0yUKUWp+OeUIjDZN5WKuKZb7dBSxKTCH7T3ntEA6UXMMPsj7k4adhf
        EMuxMm0d20vjx2PCb/X2Pas=
X-Google-Smtp-Source: AK7set+7i3usKiARpHZam8dYR6slLtZ4RWIqdJ6uYHdNXHurapyPMPlbkxX0vcGk4fbHaaBUrIHVSw==
X-Received: by 2002:a17:90a:51c5:b0:23a:87cf:de93 with SMTP id u63-20020a17090a51c500b0023a87cfde93mr5165477pjh.15.1679515115747;
        Wed, 22 Mar 2023 12:58:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:58:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 63/80] scsi: pmcraid: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:58 -0700
Message-Id: <20230322195515.1267197-64-bvanassche@acm.org>
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
 drivers/scsi/pmcraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 836ddc476764..23c5230dbed4 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3611,7 +3611,7 @@ static struct attribute *pmcraid_host_attrs[] = {
 ATTRIBUTE_GROUPS(pmcraid_host);
 
 /* host template structure for pmcraid driver */
-static struct scsi_host_template pmcraid_host_template = {
+static const struct scsi_host_template pmcraid_host_template = {
 	.module = THIS_MODULE,
 	.name = PMCRAID_DRIVER_NAME,
 	.queuecommand = pmcraid_queuecommand,
