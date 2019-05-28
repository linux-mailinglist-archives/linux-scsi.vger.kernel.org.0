Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60E82C0F6
	for <lists+linux-scsi@lfdr.de>; Tue, 28 May 2019 10:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfE1IM1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 May 2019 04:12:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17881 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726236AbfE1IM1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 May 2019 04:12:27 -0400
X-UUID: 166f0407fbc0412c9523ce831da75c28-20190528
X-UUID: 166f0407fbc0412c9523ce831da75c28-20190528
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 160705361; Tue, 28 May 2019 16:12:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 28 May 2019 16:12:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 28 May 2019 16:12:10 +0800
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
Subject: [PATCH] scsi: ufs: Use pm_runtime_get_sync in shutdown flow
Date:   Tue, 28 May 2019 16:12:06 +0800
Message-ID: <1559031126-6587-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There might be a racing issue between UFS shutdown and runtime resume
flow described as below,

Thread #1: In UFS shutdown flow with ufshcd_shutdown() is running.
Thread #2: In UFS runtime-resume flow which invokes
           ufshcd_runtime_resume() because UFS was in runtime-suspended
           state while an I/O request was issued.

In this scenario, racing may happen and possibly lead to system hang
if Thread #2 accesses UFS host's register map after host's resource,
like power or clocks, are disabled by Thread #1.

To avoid this racing, use PM public function pm_runtime_get_sync() in
shutdown flow instead of internal function ufshcd_runtime_resume() for
consolidated control of RPM status.

One concern is that pm_runtime_get_sync() may be better paired with
pm_runtime_put_sync(), however shutdown could be one-way path thus the
pairing is not required.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a208589426b1..cce7303f8653 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8095,11 +8095,8 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 	if (ufshcd_is_ufs_dev_poweroff(hba) && ufshcd_is_link_off(hba))
 		goto out;
 
-	if (pm_runtime_suspended(hba->dev)) {
-		ret = ufshcd_runtime_resume(hba);
-		if (ret)
-			goto out;
-	}
+	if (pm_runtime_get_sync(hba->dev) < 0)
+		goto out;
 
 	ret = ufshcd_suspend(hba, UFS_SHUTDOWN_PM);
 out:
-- 
2.18.0

