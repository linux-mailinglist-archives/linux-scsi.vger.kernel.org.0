Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51130306B3D
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Jan 2021 03:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhA1Cul (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Jan 2021 21:50:41 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:9011 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhA1Cuk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 Jan 2021 21:50:40 -0500
IronPort-SDR: 2sNbPidodBN2gNdDYfObTCZnXuaOBe6XCpOihijVU/rwrUmQI6sheUlzAiiTANg/bA4HhnaU+m
 UaZkW7b+fQfPgsOXF3kol5bJoAqLtfjee2bi/27DYCWuVqIElC49mzTmaMaYOFCER+baecIQ6L
 9yJRBImIuoi2HCjS+LMZn6ZcVYSxpQ+0HcivhiMB/iTQY0zw5cwqLxd6Se1pbxxV1AzSQEzIyI
 KIO8Iocx35OlY9wnWbR/05mhwpwB6GRHM30PW90nS0TCceg911kom+sbccOM2dpfN7Pfwhndc/
 XL8=
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="47715404"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 27 Jan 2021 18:50:00 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 27 Jan 2021 18:49:59 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 9BA38219A2; Wed, 27 Jan 2021 18:49:59 -0800 (PST)
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
Subject: [PATCH v2] scsi: ufs: Give clk scaling min gear a value
Date:   Wed, 27 Jan 2021 18:49:27 -0800
Message-Id: <1611802172-37802-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The initialization of clk_scaling.min_gear was removed by mistake. This
change adds it back, otherwise clock scaling down would fail.

Fixes: 4543d9d78227 ("scsi: ufs: Refactor ufshcd_init/exit_clk_scaling/gating()")

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

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

