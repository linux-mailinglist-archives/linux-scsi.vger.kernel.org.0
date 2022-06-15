Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DEC54C054
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jun 2022 05:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbiFODwB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jun 2022 23:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbiFODvy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Jun 2022 23:51:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07B50052;
        Tue, 14 Jun 2022 20:51:53 -0700 (PDT)
X-UUID: ba15bb8b701041b5a2d5e253e71e6738-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:8fe5c023-5296-4bef-b65a-3b9abb7a4a72,OB:20,L
        OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:8fe5c023-5296-4bef-b65a-3b9abb7a4a72,OB:20,LOB
        :20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:99988548-4c92-421c-ad91-b806c0f58b2a,C
        OID:91aab2dd5763,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ba15bb8b701041b5a2d5e253e71e6738-20220615
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1940988244; Wed, 15 Jun 2022 11:51:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 15 Jun 2022 11:51:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:51:47 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH v4 01/10] scsi: ufs: Export ufshcd_uic_change_pwr_mode()
Date:   Wed, 15 Jun 2022 11:51:37 +0800
Message-ID: <20220615035146.20964-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220615035146.20964-1-stanley.chu@mediatek.com>
References: <20220615035146.20964-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Export ufshcd_uic_change_pwr_mode() to allow vendors to
use it for SoC-specific power mode change design limitation.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 include/ufs/ufshcd.h      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 936a6d5467c9..19e17c898319 100755
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4091,7 +4091,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
  *
  * Returns 0 on success, non-zero value on failure
  */
-static int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
+int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 {
 	struct uic_command uic_cmd = {0};
 	int ret;
@@ -4116,6 +4116,7 @@ static int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_uic_change_pwr_mode);
 
 int ufshcd_link_recovery(struct ufs_hba *hba)
 {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a92271421718..aa778418703f 100755
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1087,6 +1087,7 @@ extern int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			       u32 *mib_val, u8 peer);
 extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 			struct ufs_pa_layer_attr *desired_pwr_mode);
+extern int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode);
 
 /* UIC command interfaces for DME primitives */
 #define DME_LOCAL	0
-- 
2.18.0

