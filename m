Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD63823971
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfETOKz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 10:10:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45876 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731841AbfETOKy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 10:10:54 -0400
X-UUID: d517044066c94e18a1611a60d47c99fd-20190520
X-UUID: d517044066c94e18a1611a60d47c99fd-20190520
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 623934374; Mon, 20 May 2019 22:10:48 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 22:10:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 22:10:46 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <evgreen@chromium.org>, <beanhuo@micron.com>,
        <marc.w.gonzalez@free.fr>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v4 0/3] scsi: ufs: Add error handling of Auto-Hibernate
Date:   Mon, 20 May 2019 22:10:42 +0800
Message-ID: <1558361445-30994-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently auto-hibernate is activated if host supports
auto-hibern8 capability. However error-handling is not implemented,
which makes the feature somewhat risky.

If either "Hibernate Enter" or "Hibernate Exit" fail during
auto-hibernate flow, the corresponding interrupt
"UIC_HIBERNATE_ENTER" or "UIC_HIBERNATE_EXIT" shall be raised
according to UFS specification.

This patch adds auto-hibernate error-handling:

- Monitor "Hibernate Enter" and "Hibernate Exit" interrupts after
  auto-hibernate feature is activated.

- If fail happens, trigger error-handling just like "manual-hibernate"
  fail and apply the same recovery flow: schedule UFS error handler in
  ufshcd_check_errors(), and then do host reset and restore
  in UFS error handler.

v4:
 - Replace original patch "[3/3] scsi: ufs: Use re-factored Auto-Hibernate function" by a new preparation patch "[2/3] scsi: ufs: Introduce ufshcd_is_auto_hibern8_supported()" for re-factoring ufshcd_is_auto_hibern8_supported (Avri Altman)
 - Refine UIC mask definitions (Avri Altman)

v3:
 - Fix typo in patch "scsi: ufs: Do not overwrite Auto-Hibernate timer" (Avri Altman)
 - Rebase to Linux 5.2-rc1

v2:
 - Fix sentences in commit message (Marc Gonzalez)
 - Make "Auto-Hibernate" error detection more precise (Bean Huo)

Stanley Chu (3):
  scsi: ufs: Do not overwrite Auto-Hibernate timer
  scsi: ufs: Introduce ufshcd_is_auto_hibern8_supported()
  scsi: ufs: Add error-handling of Auto-Hibernate

 drivers/scsi/ufs/ufshcd.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/scsi/ufs/ufshcd.h |  5 +++++
 drivers/scsi/ufs/ufshci.h |  6 ++++--
 3 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.18.0

