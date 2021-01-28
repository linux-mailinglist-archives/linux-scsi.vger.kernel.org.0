Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E792306B2B
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Jan 2021 03:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhA1Coq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Jan 2021 21:44:46 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:15550 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhA1Cop (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 Jan 2021 21:44:45 -0500
IronPort-SDR: 1qfe8KWQ0zsYJ5yIEG2EWBqzePd7ksZfUONk2nY6ktZh+Z8fNvPtQ9JZvzqVZr7CZi6l71BabH
 38SBqK54tlA5OQ3HCtwI34WYYu4aBNOQogjfPaWYjaVh3FabEJDYgKwVmEQ0ofQUqVo/ljNDQ+
 Vj1pLBT2zFoKcIic2jTr1bHuknTt0UKLN1cly4a+TI0rkOxQJKAWVIexTWlVRCWmZylfHwwnwG
 Avhemo4rL3IPrNhoTx5KPq/DcsEzitJbj7d1XuNiLB3EADpx3dU1IiNNVWveGKMAAkVwHfaFYL
 EbY=
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="47715382"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 27 Jan 2021 18:44:06 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg03-sd.qualcomm.com with ESMTP; 27 Jan 2021 18:44:04 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id CD0CB219CD; Wed, 27 Jan 2021 18:44:04 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     jaegeuk@kernel.org, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, hongwus@codeaurora.org,
        bjorn.andersson@linaro.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: ufs: Give clk scaling min gear a value
Date:   Wed, 27 Jan 2021 18:42:42 -0800
Message-Id: <1611801769-20561-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The initialization of clk_scaling.min_gear by mistake. This change adds it
back, otherwise clock scaling down would fail.

Fixes: 4543d9d78227 ("scsi: ufs: Refactor ufshcd_init/exit_clk_scaling/gating()")

Signed-off-by: Can Guo <cang@codeaurora.org>

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 36bcbb3..8ef6796 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1602,6 +1602,9 @@ static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return;
 
+	if (!hba->clk_scaling.min_gear)
+		hba->clk_scaling.min_gear = UFS_HS_G1;
+
 	INIT_WORK(&hba->clk_scaling.suspend_work,
 		  ufshcd_clk_scaling_suspend_work);
 	INIT_WORK(&hba->clk_scaling.resume_work,
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

