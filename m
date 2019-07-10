Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969E164089
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 07:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGJFUj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 01:20:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31171 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbfGJFUj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 01:20:39 -0400
X-UUID: 2e2f264d1a2c494c9074349a711db9e2-20190710
X-UUID: 2e2f264d1a2c494c9074349a711db9e2-20190710
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 578802991; Wed, 10 Jul 2019 13:20:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Jul 2019 13:20:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Jul 2019 13:20:18 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <evgreen@chromium.org>, <beanhuo@micron.com>,
        <marc.w.gonzalez@free.fr>, <ygardi@codeaurora.org>,
        <subhashj@codeaurora.org>, <sthumma@codeaurora.org>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 0/4] scsi: ufs: Provide fatal and auto-hibern8 error history
Date:   Wed, 10 Jul 2019 13:20:13 +0800
Message-ID: <1562736017-29461-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset provides more information of fatal errros and auto-hibern8 errors
to improve debugging by keeping their error history as completed as possible.

Thanks Avri so much for prompt reviewing patchset v1.

I would like to post v2 to add one more patch "scsi: ufs: Add history of fatal events"
to add history for "non-interrupt-based" errors as well, for example,

- Link startup fail
- Suspend fail
- Resume fail
- Task or request abort event

Changes in v2:
- Add new patch "scsi: ufs: Add history of fatal events".

Stanley Chu (4):
  scsi: ufs: Change names related to error history
  scsi: ufs: Add fatal and auto-hibern8 error history
  scsi: ufs: Do not reset error history during host reset
  scsi: ufs: Add history of fatal events

 drivers/scsi/ufs/ufshcd.c | 87 +++++++++++++++++++++++----------------
 drivers/scsi/ufs/ufshcd.h | 38 ++++++++++++-----
 2 files changed, 80 insertions(+), 45 deletions(-)

-- 
2.18.0

