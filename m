Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE59B6408C
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 07:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfGJFUm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 01:20:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63898 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbfGJFUl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 01:20:41 -0400
X-UUID: 42ab371bfdd949a3bee8a4fdfe0c1ce9-20190710
X-UUID: 42ab371bfdd949a3bee8a4fdfe0c1ce9-20190710
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1741744008; Wed, 10 Jul 2019 13:20:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Jul 2019 13:20:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Jul 2019 13:20:19 +0800
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
Subject: [PATCH v2 3/4] scsi: ufs: Do not reset error history during host reset
Date:   Wed, 10 Jul 2019 13:20:16 +0800
Message-ID: <1562736017-29461-4-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562736017-29461-1-git-send-email-stanley.chu@mediatek.com>
References: <1562736017-29461-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently UFS error history will be reset and lost during host reset
flow by ufschd_probe_hba().

We shall not reset it and then error history can be kept as completed
as possible to improve debugging.

In addition, fix a minor display error in ufshcd_print_err_hist().

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/scsi/ufs/ufshcd.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b8b874311509..a46c3d2b2ea3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -402,7 +402,7 @@ static void ufshcd_print_err_hist(struct ufs_hba *hba,
 
 		if (err_hist->reg[p] == 0)
 			continue;
-		dev_err(hba->dev, "%s[%d] = 0x%x at %lld us\n", err_name, i,
+		dev_err(hba->dev, "%s[%d] = 0x%x at %lld us\n", err_name, p,
 			err_hist->reg[p], ktime_to_us(err_hist->tstamp[p]));
 		found = true;
 	}
@@ -6690,19 +6690,8 @@ static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 
 static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
 {
-	int err_reg_hist_size = sizeof(struct ufs_err_reg_hist);
-
 	hba->ufs_stats.hibern8_exit_cnt = 0;
 	hba->ufs_stats.last_hibern8_exit_tstamp = ktime_set(0, 0);
-
-	memset(&hba->ufs_stats.pa_err, 0, err_reg_hist_size);
-	memset(&hba->ufs_stats.dl_err, 0, err_reg_hist_size);
-	memset(&hba->ufs_stats.nl_err, 0, err_reg_hist_size);
-	memset(&hba->ufs_stats.tl_err, 0, err_reg_hist_size);
-	memset(&hba->ufs_stats.dme_err, 0, err_reg_hist_size);
-	memset(&hba->ufs_stats.fatal_err, 0, err_reg_hist_size);
-	memset(&hba->ufs_stats.auto_hibern8_err, 0, err_reg_hist_size);
-
 	hba->req_abort_count = 0;
 }
 
-- 
2.18.0

