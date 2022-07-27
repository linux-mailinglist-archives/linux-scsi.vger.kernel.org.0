Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF1F581F53
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Jul 2022 06:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiG0EyV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Jul 2022 00:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiG0EyT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 Jul 2022 00:54:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7AA27B2E;
        Tue, 26 Jul 2022 21:54:18 -0700 (PDT)
X-UUID: 03f540c5bb364f79b2dc89199e9201d2-20220727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0001caaf-b9e6-4e87-9654-c8c732a5cda9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:eb42eacb-7c9b-4dbc-a9d4-00659d6b7a90,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 03f540c5bb364f79b2dc89199e9201d2-20220727
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 285652300; Wed, 27 Jul 2022 12:54:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Wed, 27 Jul 2022 04:53:55 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 27 Jul 2022 11:27:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 27 Jul 2022 11:27:47 +0800
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
Subject: [PATCH v1 2/5] scsi: ufs: ufs-mediatek: Provide detailed description for UIC errors
Date:   Wed, 27 Jul 2022 11:27:42 +0800
Message-ID: <20220727032745.31728-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220727032745.31728-1-stanley.chu@mediatek.com>
References: <20220727032745.31728-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Provide detailed description in logs for UIC errors for
eaiser issue breakdown.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 20 +++++++++++++++++
 drivers/ufs/host/ufs-mediatek.h | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index ff6fd8f52ebc..b590fb267c20 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1309,8 +1309,28 @@ static void ufs_mtk_event_notify(struct ufs_hba *hba,
 				 enum ufs_event_type evt, void *data)
 {
 	unsigned int val = *(u32 *)data;
+	unsigned long reg;
+	int bit;
 
 	trace_ufs_mtk_event(evt, val);
+
+	/* Print details of UIC Errors */
+	if (evt <= UFS_EVT_DME_ERR) {
+		dev_info(hba->dev,
+			 "Host UIC Error Code (%s): %08x\n",
+			 ufs_uic_err_str[evt], val);
+		reg = val;
+	}
+
+	if (evt == UFS_EVT_PA_ERR) {
+		for_each_set_bit(bit, &reg, ARRAY_SIZE(ufs_uic_pa_err_str))
+			dev_info(hba->dev, "%s\n", ufs_uic_pa_err_str[bit]);
+	}
+
+	if (evt == UFS_EVT_DL_ERR) {
+		for_each_set_bit(bit, &reg, ARRAY_SIZE(ufs_uic_dl_err_str))
+			dev_info(hba->dev, "%s\n", ufs_uic_dl_err_str[bit]);
+	}
 }
 
 /*
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index aa26d415527b..9017ab8f9867 100644
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -26,6 +26,44 @@
 #define REG_UFS_DEBUG_SEL_B2        0x22D8
 #define REG_UFS_DEBUG_SEL_B3        0x22DC
 
+/*
+ * Details of UIC Errors
+ */
+static const u8 *ufs_uic_err_str[] = {
+	"PHY Adapter Layer",
+	"Data Link Layer",
+	"Network Link Layer",
+	"Transport Link Layer",
+	"DME"
+};
+
+static const u8 *ufs_uic_pa_err_str[] = {
+	"PHY error on Lane 0",
+	"PHY error on Lane 1",
+	"PHY error on Lane 2",
+	"PHY error on Lane 3",
+	"Generic PHY Adapter Error. This should be the LINERESET indication"
+};
+
+static const u8 *ufs_uic_dl_err_str[] = {
+	"NAC_RECEIVED",
+	"TCx_REPLAY_TIMER_EXPIRED",
+	"AFCx_REQUEST_TIMER_EXPIRED",
+	"FCx_PROTECTION_TIMER_EXPIRED",
+	"CRC_ERROR",
+	"RX_BUFFER_OVERFLOW",
+	"MAX_FRAME_LENGTH_EXCEEDED",
+	"WRONG_SEQUENCE_NUMBER",
+	"AFC_FRAME_SYNTAX_ERROR",
+	"NAC_FRAME_SYNTAX_ERROR",
+	"EOF_SYNTAX_ERROR",
+	"FRAME_SYNTAX_ERROR",
+	"BAD_CTRL_SYMBOL_TYPE",
+	"PA_INIT_ERROR",
+	"PA_ERROR_IND_RECEIVED",
+	"PA_INIT"
+};
+
 /*
  * Ref-clk control
  *
-- 
2.18.0

