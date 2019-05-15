Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817B71EB07
	for <lists+linux-scsi@lfdr.de>; Wed, 15 May 2019 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEOJgp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 May 2019 05:36:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7585 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbfEOJgo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 May 2019 05:36:44 -0400
X-UUID: 8451fe8aa64f45f2b1e3c08b6cd4b511-20190515
X-UUID: 8451fe8aa64f45f2b1e3c08b6cd4b511-20190515
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1377088839; Wed, 15 May 2019 17:36:36 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 15 May 2019 17:36:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 May 2019 17:36:33 +0800
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
Subject: [PATCH v2 0/3] scsi: ufs: Add error handling of Auto-Hibernate
Date:   Wed, 15 May 2019 17:36:25 +0800
Message-ID: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6FFEA0CCF754E31D9D5A4690B8170BC47254F360FB07BE0B3B5CFDB1B23F76FA2000:8
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

v2:
 - Fix sentences in commit message (Marc Gonzalez)
 - Make "Auto-Hibernate" error detection more precise (Bean Huo)

Stanley Chu (3):
  scsi: ufs: Do not overwrite Auto-Hibernate timer
  scsi: ufs: Add error-handling of Auto-Hibernate
  scsi: ufs: Use re-factored Auto-Hibernate function

 drivers/scsi/ufs/ufshcd.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/scsi/ufs/ufshcd.h |  5 +++++
 drivers/scsi/ufs/ufshci.h |  3 +++
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.18.0

