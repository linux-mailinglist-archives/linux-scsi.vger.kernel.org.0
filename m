Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA661EB0E
	for <lists+linux-scsi@lfdr.de>; Wed, 15 May 2019 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfEOJg4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 May 2019 05:36:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8661 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbfEOJg4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 May 2019 05:36:56 -0400
X-UUID: 3515c09b6b76468d8d397726b41c7242-20190515
X-UUID: 3515c09b6b76468d8d397726b41c7242-20190515
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1146994044; Wed, 15 May 2019 17:36:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 15 May 2019 17:36:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 May 2019 17:36:34 +0800
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
Subject: [PATCH v2 2/3] scsi: ufs: Add error-handling of Auto-Hibernate
Date:   Wed, 15 May 2019 17:36:27 +0800
Message-ID: <1557912988-26758-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
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

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 31 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h |  5 +++++
 drivers/scsi/ufs/ufshci.h |  3 +++
 3 files changed, 39 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1665820c22fd..e6a86223a0d4 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5254,6 +5254,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 			goto skip_err_handling;
 	}
 	if ((hba->saved_err & INT_FATAL_ERRORS) ||
+	    (hba->saved_err & UFSHCD_UIC_AH8_ERROR_MASK) ||
 	    ((hba->saved_err & UIC_ERROR) &&
 	    (hba->saved_uic_err & (UFSHCD_UIC_DL_PA_INIT_ERROR |
 				   UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
@@ -5413,6 +5414,23 @@ static void ufshcd_update_uic_error(struct ufs_hba *hba)
 			__func__, hba->uic_error);
 }
 
+static bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
+					 u32 intr_mask)
+{
+	if (!ufshcd_is_auto_hibern8_supported(hba))
+		return false;
+
+	if (!(intr_mask & UFSHCD_UIC_AH8_ERROR_MASK))
+		return false;
+
+	if (hba->active_uic_cmd &&
+	    (hba->active_uic_cmd->command == UIC_CMD_DME_HIBER_ENTER ||
+	    hba->active_uic_cmd->command == UIC_CMD_DME_HIBER_EXIT))
+		return false;
+
+	return true;
+}
+
 /**
  * ufshcd_check_errors - Check for errors that need s/w attention
  * @hba: per-adapter instance
@@ -5431,6 +5449,15 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
 			queue_eh_work = true;
 	}
 
+	if (hba->errors & UFSHCD_UIC_AH8_ERROR_MASK) {
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
@@ -5493,6 +5520,10 @@ static void ufshcd_tmc_handler(struct ufs_hba *hba)
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

