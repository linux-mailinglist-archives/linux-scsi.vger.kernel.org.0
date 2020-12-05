Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6812CFB97
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Dec 2020 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgLEOwA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Dec 2020 09:52:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726043AbgLEOuy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 5 Dec 2020 09:50:54 -0500
X-UUID: ce64551989a84f0f91ef6dfe1777c8b2-20201205
X-UUID: ce64551989a84f0f91ef6dfe1777c8b2-20201205
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 183301001; Sat, 05 Dec 2020 20:01:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Dec 2020 20:00:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Dec 2020 20:00:42 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, <chaotian.jing@mediatek.com>,
        <cc.chou@mediatek.com>, <jiajie.hao@mediatek.com>,
        <alice.chao@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 2/4] scsi: ufs: Introduce phy_initialization helper
Date:   Sat, 5 Dec 2020 20:00:39 +0800
Message-ID: <20201205120041.26869-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201205120041.26869-1-stanley.chu@mediatek.com>
References: <20201205120041.26869-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce phy_initialization helper since this is the only
one variant function without helper.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 21de7607611f..384a042ccb46 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1134,6 +1134,14 @@ static inline int ufshcd_vops_link_startup_notify(struct ufs_hba *hba,
 	return 0;
 }
 
+static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->phy_initialization)
+		return hba->vops->phy_initialization(hba);
+
+	return 0;
+}
+
 static inline int ufshcd_vops_pwr_change_notify(struct ufs_hba *hba,
 				  bool status,
 				  struct ufs_pa_layer_attr *dev_max_params,
-- 
2.18.0

