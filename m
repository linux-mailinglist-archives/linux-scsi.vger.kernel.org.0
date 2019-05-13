Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41351B862
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfEMOgk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 10:36:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9610 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729843AbfEMOgk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 May 2019 10:36:40 -0400
X-UUID: ebb2a6f367e642119064ca99eb57b7e8-20190513
X-UUID: ebb2a6f367e642119064ca99eb57b7e8-20190513
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 816032453; Mon, 13 May 2019 22:36:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 13 May 2019 22:36:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 13 May 2019 22:36:31 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>
CC:     <marc.w.gonzalez@free.fr>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        <sayalil@codeaurora.org>, <subhashj@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <evgreen@chromium.org>,
        <beanhuo@micron.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 1/3] scsi: ufs: do not overwrite auto-hibern8 timer
Date:   Mon, 13 May 2019 22:36:24 +0800
Message-ID: <1557758186-18706-2-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
References: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some vendor-specific initialization flow may set its own
auto-hibern8 timer. In this case, do not overwrite timer value
as "default value" in ufshcd_init().

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e040f9dd9ff3..1665820c22fd 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8309,7 +8309,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 						UIC_LINK_HIBERN8_STATE);
 
 	/* Set the default auto-hiberate idle timer value to 150 ms */
-	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) {
+	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT & !hba->ahit) {
 		hba->ahit = FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK, 150) |
 			    FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, 3);
 	}
-- 
2.18.0

