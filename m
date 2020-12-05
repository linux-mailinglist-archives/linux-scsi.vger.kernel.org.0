Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76F02CFB72
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Dec 2020 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLENC1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Dec 2020 08:02:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41504 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726629AbgLENA6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 5 Dec 2020 08:00:58 -0500
X-UUID: 942fc7abcd90455580c70505bf17a18f-20201205
X-UUID: 942fc7abcd90455580c70505bf17a18f-20201205
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 630460112; Sat, 05 Dec 2020 20:01:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Dec 2020 20:00:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Dec 2020 20:00:41 +0800
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
Subject: [PATCH v1 0/4] scsi: ufs: Cleanup phy_initialization vop
Date:   Sat, 5 Dec 2020 20:00:37 +0800
Message-ID: <20201205120041.26869-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,
This series simply cleans up UFS vops and shall not change any functionality.

Stanley Chu (4):
  scsi: ufs: Remove unused setup_regulators variant function
  scsi: ufs: Introduce phy_initialization helper
  scsi: ufs-cdns: Use phy_initialization helper
  scsi: ufs-dwc: Use phy_initialization helper

 drivers/scsi/ufs/cdns-pltfrm.c |  3 +--
 drivers/scsi/ufs/ufshcd-dwc.c  | 11 ++++-------
 drivers/scsi/ufs/ufshcd.c      | 10 +---------
 drivers/scsi/ufs/ufshcd.h      | 18 ++++++++----------
 4 files changed, 14 insertions(+), 28 deletions(-)

-- 
2.18.0

