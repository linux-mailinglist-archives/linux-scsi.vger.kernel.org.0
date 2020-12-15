Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051452DAA4A
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Dec 2020 10:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgLOJmZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Dec 2020 04:42:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33765 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728157AbgLOJkX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Dec 2020 04:40:23 -0500
X-UUID: 50708c2b8e104bbe8a64484080f1d3ef-20201215
X-UUID: 50708c2b8e104bbe8a64484080f1d3ef-20201215
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 660722252; Tue, 15 Dec 2020 17:39:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Dec 2020 17:39:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 17:39:35 +0800
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
Subject: [PATCH v1 0/4] Cleanup and refactor clock scaling
Date:   Tue, 15 Dec 2020 17:39:30 +0800
Message-ID: <20201215093934.21223-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,
This series cleans up and refactors clk-scaling feature, and shall not change any functionality.

This series is based on Can's series "Three changes related with UFS clock scaling" in 5.10/scsi-fixes branch in Martin's tree.

However this series may not be required to be merged to 5.10. The choice of base branch is simply making these patches easy to be reviewed because this series is based on clk-scaling fixes by Can. If this series is decided not being merged to 5.10, then I would rebase it to 5.11/scsi-queue.

Stanley Chu (4):
  scsi: ufs: Cleanup ufshcd_suspend_clkscaling function
  scsi: ufs: Cleanup ufshcd_add_lus function
  scsi: ufs: Cleanup and refactor clk-scaling feature
  scsi: ufs: Fix build warning by incorrect function description

 drivers/scsi/ufs/ufshcd.c | 82 +++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

-- 
2.18.0

