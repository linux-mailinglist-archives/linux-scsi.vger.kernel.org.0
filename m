Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4482FFEFC
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Jan 2021 10:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhAVIjP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Jan 2021 03:39:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52457 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727105AbhAVIhq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Jan 2021 03:37:46 -0500
X-UUID: d7790b7198b84e9997d0567646afedae-20210122
X-UUID: d7790b7198b84e9997d0567646afedae-20210122
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 679792100; Fri, 22 Jan 2021 16:36:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 16:36:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 16:36:38 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <robh@kernel.org>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>
CC:     <linux-mediatek@lists.infradead.org>, <yingjoe.chen@mediatek.com>,
        <matthias.bgg@gmail.com>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, <alice.chao@mediatek.com>,
        <chaotian.jing@mediatek.com>, <cc.chou@mediatek.com>,
        <jiajie.hao@mediatek.com>, <hanks.chen@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v3 2/2] arm64: dts: mt6779: Support ufshci and ufsphy
Date:   Fri, 22 Jan 2021 16:36:27 +0800
Message-ID: <20210122083627.2893-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122083627.2893-1-stanley.chu@mediatek.com>
References: <20210122083627.2893-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Support UFS on MT6779 platforms by adding ufshci and ufsphy
nodes in dts file.

Reviewed-by: Hanks Chen <hanks.chen@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 36 +++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 370f309d32de..6eaf230bb0d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -225,6 +225,41 @@
 			#clock-cells = <1>;
 		};
 
+		ufshci: ufshci@11270000 {
+			compatible = "mediatek,mt8183-ufshci";
+			reg = <0 0x11270000 0 0x2300>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>;
+			phys = <&ufsphy>;
+
+			clocks = <&infracfg_ao CLK_INFRA_UFS>,
+				 <&infracfg_ao CLK_INFRA_UFS_TICK>,
+				 <&infracfg_ao CLK_INFRA_UFS_AXI>,
+				 <&infracfg_ao CLK_INFRA_UNIPRO_TICK>,
+				 <&infracfg_ao CLK_INFRA_UNIPRO_MBIST>,
+				 <&topckgen CLK_TOP_FAES_UFSFDE>,
+				 <&infracfg_ao CLK_INFRA_AES_UFSFDE>,
+				 <&infracfg_ao CLK_INFRA_AES_BCLK>;
+			clock-names = "ufs", "ufs_tick", "ufs_axi",
+				      "unipro_tick", "unipro_mbist",
+				      "aes_top", "aes_infra", "aes_bclk";
+			freq-table-hz = <0 0>, <0 0>, <0 0>,
+					<0 0>, <0 0>, <0 0>,
+					<0 0>, <0 0>;
+
+			mediatek,ufs-disable-ah8;
+			mediatek,ufs-support-va09;
+		};
+
+		ufsphy: phy@11fa0000 {
+			compatible = "mediatek,mt8183-ufsphy";
+			reg = <0 0x11fa0000 0 0xc000>;
+			#phy-cells = <0>;
+
+			clocks = <&infracfg_ao CLK_INFRA_UNIPRO_SCK>,
+				 <&infracfg_ao CLK_INFRA_UFS_MP_SAP_BCLK>;
+			clock-names = "unipro", "mp";
+		};
+
 		mfgcfg: clock-controller@13fbf000 {
 			compatible = "mediatek,mt6779-mfgcfg", "syscon";
 			reg = <0 0x13fbf000 0 0x1000>;
@@ -266,6 +301,5 @@
 			reg = <0 0x1b000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-
 	};
 };
-- 
2.18.0

