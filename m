Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB43F393BFD
	for <lists+linux-scsi@lfdr.de>; Fri, 28 May 2021 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhE1Dju (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 May 2021 23:39:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60743 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229883AbhE1Djs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 May 2021 23:39:48 -0400
X-UUID: 6dfea177829e4ed29ab4d5c3462afd56-20210528
X-UUID: 6dfea177829e4ed29ab4d5c3462afd56-20210528
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 216175521; Fri, 28 May 2021 11:38:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 11:38:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 11:38:07 +0800
From:   Alice <alice.chao@mediatek.com>
To:     <stanley.chu@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <jonathan.hsu@mediatek.com>, <powen.kao@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>
Subject: [PATCH v2 2/2] scsi: ufs-mediatek: Disable HCI before HW reset
Date:   Fri, 28 May 2021 11:36:22 +0800
Message-ID: <20210528033624.12170-3-alice.chao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210528033624.12170-1-alice.chao@mediatek.com>
References: <20210528033624.12170-1-alice.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: "Alice.Chao" <alice.chao@mediatek.com>

MediaTek ufshci needs to be disabled before HW reset to avoid potential issues.

Signed-off-by: Alice.Chao <alice.chao@mediatek.com>
---
 drivers/scsi/ufs/ufs-mediatek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index a981f261b304..c62603ed3d33 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -846,6 +846,9 @@ static int ufs_mtk_device_reset(struct ufs_hba *hba)
 {
 	struct arm_smccc_res res;
 
+	/* disable hba before device reset */
+	ufshcd_hba_stop(hba);
+
 	ufs_mtk_device_reset_ctrl(0, res);
 
 	/*
-- 
2.18.0

