Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5A37B82F
	for <lists+linux-scsi@lfdr.de>; Wed, 12 May 2021 10:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhELIkk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 May 2021 04:40:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37505 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229968AbhELIkk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 May 2021 04:40:40 -0400
X-UUID: 5d27913343b34fc9b41baf52b7a5fcdd-20210512
X-UUID: 5d27913343b34fc9b41baf52b7a5fcdd-20210512
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1572727613; Wed, 12 May 2021 16:39:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 May 2021 16:39:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 May 2021 16:39:30 +0800
From:   <peter.wang@mediatek.com>
To:     <stanley.chu@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>
Subject: [PATCH v1 1/1] scsi: ufs-mediatek: fix ufs power down specs violation
Date:   Wed, 12 May 2021 16:39:06 +0800
Message-ID: <1620808746-21082-2-git-send-email-peter.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1620808746-21082-1-git-send-email-peter.wang@mediatek.com>
References: <1620808746-21082-1-git-send-email-peter.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Peter Wang <peter.wang@mediatek.com>

As per specs, e.g, JESD220E chapter 7.2, while powering off
the ufs device, RST_N signal should be between VSS(Ground)
and VCCQ/VCCQ2. The power down sequence after fixing as below:

Power down:
1. Assert RST_N low
2. Turn-off VCC
3. Turn-off VCCQ/VCCQ2

Change-Id: I297e9afe3c22bb1a5fc5e7acce9b5ecfd20181ed
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
---
 drivers/scsi/ufs/ufs-mediatek.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index c55202b..47b4066 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -922,6 +922,7 @@ static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
 static int ufs_mtk_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	int err;
+	struct arm_smccc_res res;
 
 	if (ufshcd_is_link_hibern8(hba)) {
 		err = ufs_mtk_link_set_lpm(hba);
@@ -941,6 +942,9 @@ static int ufs_mtk_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			goto fail;
 	}
 
+	if (ufshcd_is_link_off(hba))
+		ufs_mtk_device_reset_ctrl(0, res);
+
 	return 0;
 fail:
 	/*
-- 
1.7.9.5

