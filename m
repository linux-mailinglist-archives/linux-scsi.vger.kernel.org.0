Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7A1B863
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 16:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfEMOgl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 10:36:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54304 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729849AbfEMOgk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 May 2019 10:36:40 -0400
X-UUID: 9da6988e753f459dba25179ad17b769e-20190513
X-UUID: 9da6988e753f459dba25179ad17b769e-20190513
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1455054110; Mon, 13 May 2019 22:36:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 13 May 2019 22:36:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 13 May 2019 22:36:32 +0800
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
Subject: [PATCH v1 2/3] scsi: ufs: add error handling of auto-hibern8
Date:   Mon, 13 May 2019 22:36:25 +0800
Message-ID: <1557758186-18706-3-git-send-email-stanley.chu@mediatek.com>
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

Currently auto-hibern8 is activated if host supports
auto-hibern8 capability. However no error handlings are existed thus
this feature is kind of risky.

If "Hibernate Enter" or "Hibernate Exit" fail happens
during auto-hibern8 flow, the corresponding interrupt
"UIC_HIBERNATE_ENTER" or "UIC_HIBERNATE_EXIT" shall be raised
according to UFS specification.

This patch adds auto-hibern8 error handlings:

- Monitor "Hibernate Enter" and "Hibernate Exit" interrupts after
  auto-hibern8 feature is activated.
- If fail happens, trigger error handlings just like "manual-hibernate"
  fail and use the same flow: Identify errors and schedule UFS error
  handler in ufshcd_check_errors(), and then do host reset and restore
  in UFS error handler.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 14 ++++++++++++++
 drivers/scsi/ufs/ufshcd.h | 13 +++++++++++++
 drivers/scsi/ufs/ufshci.h |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1665820c22fd..e0e3930abc19 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5254,6 +5254,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 			goto skip_err_handling;
 	}
 	if ((hba->saved_err & INT_FATAL_ERRORS) ||
+	    ufshcd_is_auto_hibern8_error(hba, hba->saved_err) ||
 	    ((hba->saved_err & UIC_ERROR) &&
 	    (hba->saved_uic_err & (UFSHCD_UIC_DL_PA_INIT_ERROR |
 				   UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
@@ -5431,6 +5432,15 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
 			queue_eh_work = true;
 	}
 
+	if (ufshcd_is_auto_hibern8_error(hba, hba->errors)) {
+		dev_err(hba->dev,
+			"%s: Auto Hibern8 %s failed - status: 0x%08x, upmcrs: 0x%08x\n",
+			__func__, (hba->errors & UIC_HIBERNATE_ENTER) ?
+			"Enter" : "Exit",
+			hba->errors, ufshcd_get_upmcrs(hba));
+		queue_eh_work = true;
+	}
+
 	if (queue_eh_work) {
 		/*
 		 * update the transfer error masks to sticky bits, let's do this
@@ -5493,6 +5503,10 @@ static void ufshcd_tmc_handler(struct ufs_hba *hba)
 static void ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
 {
 	hba->errors = UFSHCD_ERROR_MASK & intr_status;
+
+	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
+		hba->errors |= (UFSHCD_UIC_AH8_ERROR_MASK & intr_status);
+
 	if (hba->errors)
 		ufshcd_check_errors(hba);
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ecfa898b9ccc..1bd9c8b61ed2 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -740,6 +740,19 @@ return true;
 #endif
 }
 
+static inline bool ufshcd_is_auto_hibern8_supported(struct ufs_hba *hba)
+{
+	return (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT);
+}
+
+static inline bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
+						u32 intr_mask)
+{
+	return (ufshcd_is_auto_hibern8_supported(hba) &&
+		!hba->uic_async_done &&
+		(intr_mask & UFSHCD_UIC_AH8_ERROR_MASK));
+}
+
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6fa889de5ee5..4bcb205f2077 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -148,6 +148,9 @@ enum {
 				UIC_HIBERNATE_EXIT |\
 				UIC_POWER_MODE)
 
+#define UFSHCD_UIC_AH8_ERROR_MASK	(UIC_HIBERNATE_ENTER |\
+					UIC_HIBERNATE_EXIT)
+
 #define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UFSHCD_UIC_PWR_MASK)
 
 #define UFSHCD_ERROR_MASK	(UIC_ERROR |\
-- 
2.18.0

