Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87A06517F5
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Dec 2022 02:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiLTBXo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Dec 2022 20:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiLTBWP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Dec 2022 20:22:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ACC12AB2;
        Mon, 19 Dec 2022 17:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C4BAB80FA6;
        Tue, 20 Dec 2022 01:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C87C433EF;
        Tue, 20 Dec 2022 01:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671499295;
        bh=BiBcUe1NiGyXfzYVNug/rXwbw35M+7EH7CcJtek1hQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpOs400CiniBI5c6c3pkhQjZpAt8BAjkM54s3DoqVUN2O25jIoXKEEdQlUHGnyUAT
         XFhZ2UCXfq95koCZ8XwFepPj/8jNw43o8Fz6zFfNmQNN9lZbQQbj+ujodJVW1uWz85
         l6Xyy6AMD6e0SbHnPXhGMF2jPrKaetpx2VhItM9mn1v5bNUm37Z7ftfU9X4+ozyz0O
         AF+FRS28zv3ZMStCrV+lm1S+YtIb9jnaPINd4UJlj1/La/0IW2KnDJ5+tS/Lt8ZizE
         Oa3yf/mTLDPKaLSUC+OOSibU4vDBB/Nmsilt37ZX0tpkUEmpfLviXO3N+auhOyqdPf
         WTZTmr8Ogxmtg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        avri.altman@wdc.com, beanhuo@micron.com, stanley.chu@mediatek.com,
        j-young.choi@samsung.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 03/16] scsi: ufs: Reduce the START STOP UNIT timeout
Date:   Mon, 19 Dec 2022 20:21:13 -0500
Message-Id: <20221220012127.1222311-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220012127.1222311-1-sashal@kernel.org>
References: <20221220012127.1222311-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit dcd5b7637c6d442d957f73780a03047413ed3a10 ]

Reduce the START STOP UNIT command timeout to one second since on Android
devices a kernel panic is triggered if an attempt to suspend the system
takes more than 20 seconds. One second should be enough for the START STOP
UNIT command since this command completes in less than a millisecond for
the UFS devices I have access to.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20221018202958.1902564-7-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a202d7d5240d..6a2a187d6f83 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8741,8 +8741,6 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	struct scsi_device *sdp;
 	unsigned long flags;
 	int ret, retries;
-	unsigned long deadline;
-	int32_t remaining;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	sdp = hba->ufs_device_wlun;
@@ -8775,14 +8773,9 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	 * callbacks hence set the RQF_PM flag so that it doesn't resume the
 	 * already suspended childs.
 	 */
-	deadline = jiffies + 10 * HZ;
 	for (retries = 3; retries > 0; --retries) {
-		ret = -ETIMEDOUT;
-		remaining = deadline - jiffies;
-		if (remaining <= 0)
-			break;
 		ret = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, &sshdr,
-				   remaining / HZ, 0, 0, RQF_PM, NULL);
+				   HZ, 0, 0, RQF_PM, NULL);
 		if (!scsi_status_is_check_condition(ret) ||
 				!scsi_sense_valid(&sshdr) ||
 				sshdr.sense_key != UNIT_ATTENTION)
-- 
2.35.1

