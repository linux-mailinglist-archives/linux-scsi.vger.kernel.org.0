Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D851817B5E4
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2020 05:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFE71 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 5 Mar 2020 23:59:27 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:43136 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgCFE71 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 5 Mar 2020 23:59:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583470766; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=5MWQLtho3ToFXSVprC0VQBc7lkh4LWocTd4tRw1QnuM=; b=kGRywfMKsioOp7JQeaWDmvb57aujsONSqlWF6W08AHocmsvAGrfIV6CM3oRFrv1kRF/vCtwk
 2gj6XV2Uybt6SI5H71nZy1t6JQn3jxzgHwfaQh7jFif/nECjMEqKIMO3wkswH3Uo1lR3N8Ew
 98TDpb0iTEd/HGMgjJoqcoZj6/4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e61d8a9.7f45f5bef068-smtp-out-n02;
 Fri, 06 Mar 2020 04:59:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B30ADC433A2; Fri,  6 Mar 2020 04:59:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA478C43383;
        Fri,  6 Mar 2020 04:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA478C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, asutoshd@codeaurora.org,
        cang@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [PATCH v2 3/4] mmc: core: Make host->card as NULL when card is removed
Date:   Thu,  5 Mar 2020 20:58:17 -0800
Message-Id: <17f39df2f08f6d40b829d115255ddb2d2ef4bc2a.1583470026.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583470026.git.nguyenb@codeaurora.org>
References: <cover.1583470026.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1583470026.git.nguyenb@codeaurora.org>
References: <cover.1583470026.git.nguyenb@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Ritesh Harjani <riteshh@codeaurora.org>

Make host->card as NULL when card is removed otherwise
we do see some kernel crashes in async contexts,
where host->card is referred (as dangling pointer).

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/mmc/core/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 74de3f2..e83821c 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -247,12 +247,15 @@ void mmc_unregister_driver(struct mmc_driver *drv)
 static void mmc_release_card(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
 
 	sdio_free_common_cis(card);
 
 	kfree(card->info);
 
 	kfree(card);
+	if (host)
+		host->card = NULL;
 }
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
