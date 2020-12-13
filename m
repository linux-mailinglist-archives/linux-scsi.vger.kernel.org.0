Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665702D8EC6
	for <lists+linux-scsi@lfdr.de>; Sun, 13 Dec 2020 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436657AbgLMQdE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Dec 2020 11:33:04 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:14649 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405775AbgLMQcz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 13 Dec 2020 11:32:55 -0500
IronPort-SDR: wGkbvEQBJudY7y6PcFudy51EpAJD8cwG4lFHTP7YbSxadDgh+AoZlNBtVdRZg9/mAtcd783KUh
 qMJW97vCsILB6mqQYIeeCEv+gWSxA7deinYeGenkgyYQ9ycwhwzkLAQ9vPNJxsF3ic48oUPjfj
 IKxo3EmOh6TtnQavLZ0WKYIXF2Y7gbrC6r8vlH3tqS7BrkzuFtdQg3OtzOi+mQQkstFF+AIdpO
 PTQXbHRS9OUEENwctg0HIJ5p0R13I+hZhvWXeE9YDvb5NQkqTxsfMG+YQcinUNyHS2qK4jYgf3
 dTY=
X-IronPort-AV: E=Sophos;i="5.78,416,1599548400"; 
   d="scan'208";a="29356199"
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by labrats.qualcomm.com with ESMTP; 13 Dec 2020 08:32:00 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg05-sd.qualcomm.com with ESMTP; 13 Dec 2020 08:31:59 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 775B82171F; Sun, 13 Dec 2020 08:31:59 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/3] scsi: ufs: Revert "Make sure clk scaling happens only when HBA is runtime ACTIVE"
Date:   Sun, 13 Dec 2020 08:31:44 -0800
Message-Id: <1607877104-8916-4-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607877104-8916-1-git-send-email-cang@codeaurora.org>
References: <1607877104-8916-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Commit 73cc291c27024 ("Make sure clk scaling happens only when HBA is
runtime ACTIVE") is no longer needed since commit f7a42540928a8 ("scsi:
ufs: Protect some contexts from unexpected clock scaling") is a more
mature fix to protect UFS LLD stability from clock scaling invoked through
sysfs nodes by users.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 80f82cb..052479a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1300,15 +1300,8 @@ static int ufshcd_devfreq_target(struct device *dev,
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
-	pm_runtime_get_noresume(hba->dev);
-	if (!pm_runtime_active(hba->dev)) {
-		pm_runtime_put_noidle(hba->dev);
-		ret = -EAGAIN;
-		goto out;
-	}
 	start = ktime_get();
 	ret = ufshcd_devfreq_scale(hba, scale_up);
-	pm_runtime_put(hba->dev);
 
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 		(scale_up ? "up" : "down"),
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

