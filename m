Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AD64213C
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Dec 2022 02:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLEBxB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 4 Dec 2022 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLEBxA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 4 Dec 2022 20:53:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581DC767C;
        Sun,  4 Dec 2022 17:52:49 -0800 (PST)
X-UUID: aa2886e5d5254e58b70ea0296d1fbece-20221205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=g9BsRHMoVPm+BDBuWg0FYyhlA3PQRobIouKG13VEGoA=;
        b=DMZ3WnpTUv1rQqtHCswAtQPL8L+UvNwrjYzAEWtkV2KqgDbHQb0CxvoJBgzbAIz5D803xklFTAD1oFvRPWJe4jC5RncV2ip7QzCneZ5Pgux09odcQN++mo7mczCZOLkH7CFUKzwYx/Uy48yniWuwCDaJXmHxT3yJXJF1c68aqJc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a6fb3763-ad12-4f96-97d2-c155db137212,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:a6fb3763-ad12-4f96-97d2-c155db137212,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:7e381f1f-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:221205095245Y940Y0T2,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: aa2886e5d5254e58b70ea0296d1fbece-20221205
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 191979232; Mon, 05 Dec 2022 09:52:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 5 Dec 2022 09:52:41 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 5 Dec 2022 09:52:40 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Wang <peter.wang@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH v2 1/1] scsi: ufs: core: fix device management cmd timeout flow
Date:   Mon, 5 Dec 2022 09:42:03 +0800
Message-ID: <20221205014202.2672-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

In ufs error handler flow, host will send device management cmd(NOP OUT)
to device for recovery link. If cmd response timeout, and clear doorbell
fail, ufshcd_wait_for_dev_cmd will do nothing and return,
hba->dev_cmd.complete struct not set to null.

In this time, if cmd has been responsed by device, then it will
call complete() in __ufshcd_transfer_req_compl, because of complete
struct is alloced in stack, then the KE will occur.

Fix the following crash:
  ipanic_die+0x24/0x38 [mrdump]
  die+0x344/0x748
  arm64_notify_die+0x44/0x104
  do_debug_exception+0x104/0x1e0
  el1_dbg+0x38/0x54
  el1_sync_handler+0x40/0x88
  el1_sync+0x8c/0x140
  queued_spin_lock_slowpath+0x2e4/0x3c0
  __ufshcd_transfer_req_compl+0x3b0/0x1164
  ufshcd_trc_handler+0x15c/0x308
  ufshcd_host_reset_and_restore+0x54/0x260
  ufshcd_reset_and_restore+0x28c/0x57c
  ufshcd_err_handler+0xeb8/0x1b6c
  process_one_work+0x288/0x964
  worker_thread+0x4bc/0xc7c
  kthread+0x15c/0x264
  ret_from_fork+0x10/0x30

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 46 ++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b1f59a5fe632..2b4934a562a6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2979,35 +2979,31 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		err = -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
-		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
+		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0)
 			/* successfully cleared the command, retry if needed */
 			err = -EAGAIN;
+		/*
+		 * Since clearing the command succeeded we also need to
+		 * clear the task tag bit from the outstanding_reqs
+		 * variable.
+		 */
+		spin_lock_irqsave(&hba->outstanding_lock, flags);
+		pending = test_bit(lrbp->task_tag,
+				   &hba->outstanding_reqs);
+		if (pending) {
+			hba->dev_cmd.complete = NULL;
+			__clear_bit(lrbp->task_tag,
+				    &hba->outstanding_reqs);
+		}
+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+
+		if (!pending) {
 			/*
-			 * Since clearing the command succeeded we also need to
-			 * clear the task tag bit from the outstanding_reqs
-			 * variable.
+			 * The completion handler ran while we tried to
+			 * clear the command.
 			 */
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending = test_bit(lrbp->task_tag,
-					   &hba->outstanding_reqs);
-			if (pending) {
-				hba->dev_cmd.complete = NULL;
-				__clear_bit(lrbp->task_tag,
-					    &hba->outstanding_reqs);
-			}
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-			if (!pending) {
-				/*
-				 * The completion handler ran while we tried to
-				 * clear the command.
-				 */
-				time_left = 1;
-				goto retry;
-			}
-		} else {
-			dev_err(hba->dev, "%s: failed to clear tag %d\n",
-				__func__, lrbp->task_tag);
+			time_left = 1;
+			goto retry;
 		}
 	}
 
-- 
2.18.0

