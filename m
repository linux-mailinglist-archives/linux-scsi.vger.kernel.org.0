Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DE2FFF01
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Jan 2021 10:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAVIjX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Jan 2021 03:39:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52444 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727100AbhAVIhq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Jan 2021 03:37:46 -0500
X-UUID: 5258720654404e1ca9824f5c0e002279-20210122
X-UUID: 5258720654404e1ca9824f5c0e002279-20210122
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 957812370; Fri, 22 Jan 2021 16:36:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v3 0/2] arm64: Support Universal Flash Storage on MediaTek MT6779 platform
Date:   Fri, 22 Jan 2021 16:36:25 +0800
Message-ID: <20210122083627.2893-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,
This series adds UFS (Universal Flash Storage) support on MediaTek MT6779 SoC platform.

Changes since v2:
  - Rebase to Martin's 5.12/scsi-queue branch

Changes since v1:
  - Fix irq attribute in dts in patch [2/2]

Stanley Chu (2):
  arm64: configs: Support Universal Flash Storage on MediaTek platforms
  arm64: dts: mt6779: Support ufshci and ufsphy

 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 36 +++++++++++++++++++++++-
 arch/arm64/configs/defconfig             |  1 +
 2 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.18.0

