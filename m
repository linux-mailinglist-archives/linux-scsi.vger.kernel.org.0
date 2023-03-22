Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C396C55A2
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Mar 2023 20:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCVT7w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Mar 2023 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCVT71 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Mar 2023 15:59:27 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538EE580CD
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:03 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id u5so20280698plq.7
        for <linux-scsi@vger.kernel.org>; Wed, 22 Mar 2023 12:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+4v/C2RuRmCm2hrk+4AAfVZyUrantTB0vKA7PER/Cs=;
        b=zcIQxvBNH0nAe84JgRkpC3003KwM2dTU3uJL/86ljB19aBx56xzpAYIzhfvJsUe9Um
         f2Mcy+mr0o13Lauv9WC8LX2bowdI6dRAQo7LVczhDWRLWoBfd9f74WkbmDZSo/IsvKOp
         gA2B23FVEFSQxU8ESEyU7yGBhLzbSyq7HXYcacCbTsO68l0V3MGsTZq3Eowmhm+Ui5CX
         qshPMk8xXTD4f0dQpaYZV8tM7l3mmrt7rMTSgQeO7DxpAUk7N4wyA3jheN72ii+GVjrK
         hpJePyst+tOCRCIZ/3vrgymf2Lf9EB2vnr1YY2LVBBPdQc1jBMBMktaNR6edYiBkE0Ih
         AF8w==
X-Gm-Message-State: AO0yUKX7GD4WCDjx4TEXsh2oE38Rkaez9U5oOU23Z8iY14uoDzSaFS6o
        Gp5qgewYtArgj/Ecqvo4Its=
X-Google-Smtp-Source: AK7set8xv/Npc9qFgn/37j+gnApzLbOkrOS4mJuMLMp2RBp3+PXekH4E3mgBHFIrLjKbm7toNKCqBA==
X-Received: by 2002:a17:90b:1a8a:b0:23e:aba9:d51d with SMTP id ng10-20020a17090b1a8a00b0023eaba9d51dmr4518698pjb.7.1679515083626;
        Wed, 22 Mar 2023 12:58:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adac200b00233cde36909sm13574815pjx.21.2023.03.22.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:58:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 50/80] scsi: mac53c94: Declare SCSI host template const
Date:   Wed, 22 Mar 2023 12:54:45 -0700
Message-Id: <20230322195515.1267197-51-bvanassche@acm.org>
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
 drivers/scsi/mac53c94.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index f75928f7773e..6a019132109c 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -392,7 +392,7 @@ static void set_dma_cmds(struct fsc_state *state, struct scsi_cmnd *cmd)
 	mac53c94_priv(cmd)->this_residual = total;
 }
 
-static struct scsi_host_template mac53c94_template = {
+static const struct scsi_host_template mac53c94_template = {
 	.proc_name	= "53c94",
 	.name		= "53C94",
 	.queuecommand	= mac53c94_queue,
