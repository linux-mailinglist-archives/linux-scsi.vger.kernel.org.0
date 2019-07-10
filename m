Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA99B6471C
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 15:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfGJNid (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 09:38:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6790 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbfGJNib (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 09:38:31 -0400
X-UUID: 4766aa64a9854b878be08da1a446ac06-20190710
X-UUID: 4766aa64a9854b878be08da1a446ac06-20190710
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 172332617; Wed, 10 Jul 2019 21:38:24 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Jul 2019 21:38:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Jul 2019 21:38:23 +0800
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
Subject: [PATCH v3 0/4] scsi: ufs: Provide fatal and auto-hibern8 error history
Date:   Wed, 10 Jul 2019 21:38:17 +0800
Message-ID: <1562765901-18328-1-git-send-email-stanley.chu@mediatek.com>
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

I would like to post new version to add one more patch "scsi: ufs: Add history of fatal events"
to provide history for "non-interrupt-based" errors and abnormal events as well.

Example of fatal errors,
- Link startup error
- Suspend error
- Resume error

Example of abnormal events,
- Task or request abort
- Device reset (now equals to Logical Unit Reset)
- Host reset

Changes in v3:
- Fix one missing place to track link startup error (Avri Altman)
- Add history of device reset events (Avri Altman)
- Add history of host reset events

Changes in v2:
- Add new patch "scsi: ufs: Add history of fatal events"

Stanley Chu (4):
  scsi: ufs: Change names related to error history
  scsi: ufs: Add fatal and auto-hibern8 error history
  scsi: ufs: Do not reset error history during host reset
  scsi: ufs: Add history of fatal events

 drivers/scsi/ufs/ufshcd.c | 94 ++++++++++++++++++++++++---------------
 drivers/scsi/ufs/ufshcd.h | 42 ++++++++++++-----
 2 files changed, 90 insertions(+), 46 deletions(-)

-- 
2.18.0

