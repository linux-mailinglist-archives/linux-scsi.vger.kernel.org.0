Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C463C72BB8C
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Jun 2023 11:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjFLJCc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Jun 2023 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjFLJBn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Jun 2023 05:01:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ABB10C9;
        Mon, 12 Jun 2023 01:58:28 -0700 (PDT)
X-UUID: 4884be0e08ff11ee9cb5633481061a41-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zo1qendqIdLBfs8hT+rdfMuM1oQDdS7ykxqzsxeY+aQ=;
        b=N93FSRDNT7/n5fsYtldCVrjMng+CTgz8fC9wYKIZ7VX7FUKFli+e7LW2VLhXAAu5t7B3GDmM+BcwydE0muOB37SDsZrx0RUded9ktK9Wj3K4xAX9U77Q3rfbrJ8Tf6vNCTd3Vm3XB+CduT5l8rCkEqG79s72U13GXDa08k05mGA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:a1048dc1-8a05-4840-a19e-39f751b193ec,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:cb9a4e1,CLOUDID:d0f8253e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4884be0e08ff11ee9cb5633481061a41-20230612
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1784407423; Mon, 12 Jun 2023 16:58:22 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 16:58:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 16:58:21 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>
Subject: [PATCH v1 2/4] scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_RTC
Date:   Mon, 12 Jun 2023 16:58:10 +0800
Message-ID: <20230612085817.12275-3-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230612085817.12275-1-powen.kao@mediatek.com>
References: <20230612085817.12275-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some host does not implement SQ Run Time Command (SQRTC) register
thus need this quirk to skip related flow.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c | 12 ++++++++++++
 include/ufs/ufshcd.h       |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 785fc9762cad..e5be3445c4ab 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -458,6 +458,9 @@ static int ufshcd_mcq_sq_stop(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
 	u32 id = hwq->id, val;
 	int err;
 
+	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
+		return -ETIMEDOUT;
+
 	writel(SQ_STOP, mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTC);
 	reg = mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTS;
 	err = read_poll_timeout(readl, val, val & SQ_STS, 20,
@@ -474,6 +477,9 @@ static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
 	u32 id = hwq->id, val;
 	int err;
 
+	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
+		return -ETIMEDOUT;
+
 	writel(SQ_START, mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTC);
 	reg = mcq_opr_base(hba, OPR_SQD, id) + REG_SQRTS;
 	err = read_poll_timeout(readl, val, !(val & SQ_STS), 20,
@@ -501,6 +507,9 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
 	u32 nexus, id, val;
 	int err;
 
+	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
+		return -ETIMEDOUT;
+
 	if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
 		if (!cmd)
 			return -EINVAL;
@@ -583,6 +592,9 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 	u64 addr, match;
 	u32 sq_head_slot;
 
+	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
+		return true;
+
 	mutex_lock(&hwq->sq_mutex);
 
 	ufshcd_mcq_sq_stop(hba, hwq);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ea43ceaf881c..86b4aae5aa2c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -618,6 +618,12 @@ enum ufshcd_quirks {
 	 * Enable this quirk will disable CQES and use per queue interrupt.
 	 */
 	UFSHCD_QUIRK_MCQ_BROKEN_INTR			= 1 << 20,
+
+	/*
+	 * Some host does not implement SQ Run Time Command (SQRTC) register
+	 * thus need this quirk to skip related flow.
+	 */
+	UFSHCD_QUIRK_MCQ_BROKEN_RTC			= 1 << 21,
 };
 
 enum ufshcd_caps {
-- 
2.18.0

