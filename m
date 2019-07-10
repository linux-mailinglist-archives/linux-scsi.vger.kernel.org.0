Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5E64718
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGJNi3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 09:38:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38351 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbfGJNi2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 09:38:28 -0400
X-UUID: 173f399bdbab419d963a12cad0af55c6-20190710
X-UUID: 173f399bdbab419d963a12cad0af55c6-20190710
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1483190641; Wed, 10 Jul 2019 21:38:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v3 2/4] scsi: ufs: Add fatal and auto-hibern8 error history
Date:   Wed, 10 Jul 2019 21:38:19 +0800
Message-ID: <1562765901-18328-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562765901-18328-1-git-send-email-stanley.chu@mediatek.com>
References: <1562765901-18328-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Provide more information of fatal errros and auto-hibern8 errors
to improve debugging by extending extend existed UFS error history
framework.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/scsi/ufs/ufshcd.c | 11 ++++++++++-
 drivers/scsi/ufs/ufshcd.h | 10 +++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index eb062aba0d21..b8b874311509 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -429,6 +429,9 @@ static void ufshcd_print_host_regs(struct ufs_hba *hba)
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.nl_err, "nl_err");
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.tl_err, "tl_err");
 	ufshcd_print_err_hist(hba, &hba->ufs_stats.dme_err, "dme_err");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.fatal_err, "fatal_err");
+	ufshcd_print_err_hist(hba, &hba->ufs_stats.auto_hibern8_err,
+			      "auto_hibern8_err");
 
 	ufshcd_print_clk_freqs(hba);
 
@@ -5440,8 +5443,10 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
 {
 	bool queue_eh_work = false;
 
-	if (hba->errors & INT_FATAL_ERRORS)
+	if (hba->errors & INT_FATAL_ERRORS) {
+		ufshcd_update_reg_hist(&hba->ufs_stats.fatal_err, hba->errors);
 		queue_eh_work = true;
+	}
 
 	if (hba->errors & UIC_ERROR) {
 		hba->uic_error = 0;
@@ -5456,6 +5461,8 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
 			__func__, (hba->errors & UIC_HIBERNATE_ENTER) ?
 			"Enter" : "Exit",
 			hba->errors, ufshcd_get_upmcrs(hba));
+		ufshcd_update_reg_hist(&hba->ufs_stats.auto_hibern8_err,
+				       hba->errors);
 		queue_eh_work = true;
 	}
 
@@ -6693,6 +6700,8 @@ static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
 	memset(&hba->ufs_stats.nl_err, 0, err_reg_hist_size);
 	memset(&hba->ufs_stats.tl_err, 0, err_reg_hist_size);
 	memset(&hba->ufs_stats.dme_err, 0, err_reg_hist_size);
+	memset(&hba->ufs_stats.fatal_err, 0, err_reg_hist_size);
+	memset(&hba->ufs_stats.auto_hibern8_err, 0, err_reg_hist_size);
 
 	hba->req_abort_count = 0;
 }
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index dcc61f857c38..c6ec5c749ceb 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -414,7 +414,7 @@ struct ufs_init_prefetch {
 
 #define UFS_ERR_REG_HIST_LENGTH 8
 /**
- * struct ufs_err_reg_hist - keeps history of uic errors
+ * struct ufs_err_reg_hist - keeps history of errors
  * @pos: index to indicate cyclic buffer position
  * @reg: cyclic buffer for registers value
  * @tstamp: cyclic buffer for time stamp
@@ -436,15 +436,23 @@ struct ufs_err_reg_hist {
  * @nl_err: tracks nl-uic errors
  * @tl_err: tracks tl-uic errors
  * @dme_err: tracks dme errors
+ * @fatal_err: tracks fatal errors
+ * @auto_hibern8_err: tracks auto-hibernate errors
  */
 struct ufs_stats {
 	u32 hibern8_exit_cnt;
 	ktime_t last_hibern8_exit_tstamp;
+
+	/* uic specific errors */
 	struct ufs_err_reg_hist pa_err;
 	struct ufs_err_reg_hist dl_err;
 	struct ufs_err_reg_hist nl_err;
 	struct ufs_err_reg_hist tl_err;
 	struct ufs_err_reg_hist dme_err;
+
+	/* fatal errors */
+	struct ufs_err_reg_hist fatal_err;
+	struct ufs_err_reg_hist auto_hibern8_err;
 };
 
 /**
-- 
2.18.0

