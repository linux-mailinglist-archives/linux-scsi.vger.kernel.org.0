Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A78A2484C
	for <lists+linux-scsi@lfdr.de>; Tue, 21 May 2019 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfEUGp0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 02:45:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44163 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbfEUGp0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 02:45:26 -0400
X-UUID: 05eb53142ae64b8b972cabe8a9cef26e-20190521
X-UUID: 05eb53142ae64b8b972cabe8a9cef26e-20190521
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1488774592; Tue, 21 May 2019 14:45:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 May 2019 14:45:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 14:45:04 +0800
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
Subject: [PATCH v5 0/3] scsi: ufs: Add error handling of Auto-Hibernate
Date:   Tue, 21 May 2019 14:44:51 +0800
Message-ID: <1558421094-3182-1-git-send-email-stanley.chu@mediatek.com>
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

v5:
 - Also re-factor checking of Auto-Hibernation support in other places, e.g., in ufshcd_auto_hibern8_enable() and in ufs-sysfs (Avri Altman)
 - Change order of patch "scsi: ufs: Introduce ufshcd_is_auto_hibern8_supported()" to #1 as a preparation patch of whole series

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
  scsi: ufs: Introduce ufshcd_is_auto_hibern8_supported()
  scsi: ufs: Do not overwrite Auto-Hibernate timer
  scsi: ufs: Add error-handling of Auto-Hibernate

 drivers/scsi/ufs/ufs-sysfs.c |  6 +++---
 drivers/scsi/ufs/ufshcd.c    | 35 +++++++++++++++++++++++++++++++++--
 drivers/scsi/ufs/ufshcd.h    |  5 +++++
 drivers/scsi/ufs/ufshci.h    |  6 ++++--
 4 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.18.0

