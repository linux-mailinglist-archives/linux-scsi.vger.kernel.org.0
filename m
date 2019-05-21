Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDF2484D
	for <lists+linux-scsi@lfdr.de>; Tue, 21 May 2019 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEUGp0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 02:45:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16941 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbfEUGp0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 02:45:26 -0400
X-UUID: d75d3c3b356948f292527319b66923c1-20190521
X-UUID: d75d3c3b356948f292527319b66923c1-20190521
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 925548303; Tue, 21 May 2019 14:45:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 May 2019 14:45:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 14:45:05 +0800
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
Subject: [PATCH v5 1/3] scsi: ufs: Introduce ufshcd_is_auto_hibern8_supported()
Date:   Tue, 21 May 2019 14:44:52 +0800
Message-ID: <1558421094-3182-2-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1558421094-3182-1-git-send-email-stanley.chu@mediatek.com>
References: <1558421094-3182-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The checking of Auto-Hibernation support is used in
many places in the driver, thus re-factor it as
ufshcd_is_auto_hibern8_supported() to make code more
clean.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/scsi/ufs/ufs-sysfs.c | 6 +++---
 drivers/scsi/ufs/ufshcd.c    | 4 ++--
 drivers/scsi/ufs/ufshcd.h    | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 8d9332bb7d0c..f478685122ff 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -122,7 +122,7 @@ static void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 {
 	unsigned long flags;
 
-	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT))
+	if (!ufshcd_is_auto_hibern8_supported(hba))
 		return;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -164,7 +164,7 @@ static ssize_t auto_hibern8_show(struct device *dev,
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT))
+	if (!ufshcd_is_auto_hibern8_supported(hba))
 		return -EOPNOTSUPP;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", ufshcd_ahit_to_us(hba->ahit));
@@ -177,7 +177,7 @@ static ssize_t auto_hibern8_store(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	unsigned int timer;
 
-	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT))
+	if (!ufshcd_is_auto_hibern8_supported(hba))
 		return -EOPNOTSUPP;
 
 	if (kstrtouint(buf, 0, &timer))
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8c1c551f2b42..0cf698d05426 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3907,7 +3907,7 @@ static void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)
 {
 	unsigned long flags;
 
-	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) || !hba->ahit)
+	if (!ufshcd_is_auto_hibern8_supported(hba) || !hba->ahit)
 		return;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -8312,7 +8312,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 						UIC_LINK_HIBERN8_STATE);
 
 	/* Set the default auto-hiberate idle timer value to 150 ms */
-	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) {
+	if (ufshcd_is_auto_hibern8_supported(hba)) {
 		hba->ahit = FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK, 150) |
 			    FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, 3);
 	}
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ecfa898b9ccc..994d73d03207 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -740,6 +740,11 @@ return true;
 #endif
 }
 
+static inline bool ufshcd_is_auto_hibern8_supported(struct ufs_hba *hba)
+{
+	return (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT);
+}
+
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
-- 
2.18.0

