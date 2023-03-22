Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016786C5568
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCVT6X (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCVT5o (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:57:44 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F296A1E9
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:24 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id w4so12216080plg.9
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9EbEznef8iJjMvb3ab9roSVdm2qWqXIE3r6q0CuMcY=;
        b=A1AaJnlcdyTvl7QbZm6iWZY/SHYi8xBU/4Bw+jESlC6oIJ/OTdht8BVAffRz5rwvYk
         36tg0AXKpFXovElmfRgPoufYxPhwcR1rX4Qr86uoGpKKn6ZjGYnyaGrn+4tRoP++gTkB
         GdfEGD1g+vnhSuQRL9j9WnMt3ESlzKPFyr6hkz95A84zI70NJwOyyT40c/OK1FgCGGuV
         XhFrWZ4ucj6VD6ApVUDJzaa5orjzpRtRGdh+E/yTtAvt6ZtNkq6wkjQxZSb20Rj3XMV9
         0WzNDZIF5Hw4AgpAQI/UwjpJBuOh6053PntO286zT0k+Q5T7rj/Zsx4rOp8J+/tf4a4y
         fcng==
X-Gm-Message-State: AAQBX9eLSjlfwyCBAptqR9GGJDqV3CwqKaL3LNMNCq27neMVUs6m1PBQ
        6dRR0Pf5oTlvfXF+DTALiJ/jiZNKvWw=
X-Google-Smtp-Source: AKy350Z/CfpObEW9i6dwb7qwxcQ3CIe339bpyEr2AzrR19dNPs65xLdUZ2s7HR7zDEVeFpBvnekaGQ==
X-Received: by 2002:a17:90a:c241:b0:23d:35ae:5ab9 with SMTP id d1-20020a17090ac24100b0023d35ae5ab9mr3282669pjx.9.1679515044221;
        Wed, 22 Mar 2023 12:57:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:57:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 32/80] scsi: elx: efct: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:27 -0700
Message-Id: <20230322195515.1267197-33-bvanassche@acm.org>
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
 drivers/scsi/elx/efct/efct_xport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_xport.c b/drivers/scsi/elx/efct/efct_xport.c
index 9495cedcc0b9..cf4dced20b8b 100644
--- a/drivers/scsi/elx/efct/efct_xport.c
+++ b/drivers/scsi/elx/efct/efct_xport.c
@@ -10,7 +10,7 @@
 static struct dentry *efct_debugfs_root;
 static atomic_t efct_debugfs_count;
 
-static struct scsi_host_template efct_template = {
+static const struct scsi_host_template efct_template = {
 	.module			= THIS_MODULE,
 	.name			= EFCT_DRIVER_NAME,
 	.supported_mode		= MODE_TARGET,
