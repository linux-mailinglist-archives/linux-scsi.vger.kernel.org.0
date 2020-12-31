Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6052E7DF3
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Dec 2020 05:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLaE0f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Dec 2020 23:26:35 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:1270 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaE0e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 30 Dec 2020 23:26:34 -0500
IronPort-SDR: L08cG500EoWFs1nYxKlWJt0MfNn3X/4wmzMyAq6CP8IDGWhEZRBCDyh55EWw+wwTtqCAlHOQi8
 iKXSwtXuYMYDD7vndLg3Ab2fSiFPW79JdTFpB6RMYdC8ExYKxDAoAASxedwV1WnUpfKZRRmDAv
 2yxm0ZwZhqOX6zAfPtCi8NUnUVzAGN53o8zPxsPyrfmWFj5jSx30OfHYLW33FUFkQNu/Y3GTU/
 +qOnyb4tldVmHPX5Peaj+UzFuF5fZnnbdkM5GWNZAcXfQNbe2rF/IPU08Vu3phRS3/ANP72YHJ
 Bl4=
X-IronPort-AV: E=Sophos;i="5.78,463,1599548400"; 
   d="scan'208";a="29466384"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 30 Dec 2020 20:25:46 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 30 Dec 2020 20:25:42 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 46D87212C1; Wed, 30 Dec 2020 20:25:42 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] scsi: ufs: Fix a possible NULL pointer issue
Date:   Wed, 30 Dec 2020 20:25:34 -0800
Message-Id: <1609388736-22525-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609388736-22525-1-git-send-email-cang@codeaurora.org>
References: <1609388736-22525-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During system resume/suspend, hba could be NULL. In this case, do not touch
eh_sem.

Fixes: 88a92d6ae4fe ("scsi: ufs: Serialize eh_work with system PM events and async scan")

Signed-off-by: Can Guo <cang@codeaurora.org>

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e221add..34e2541 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8896,8 +8896,11 @@ int ufshcd_system_suspend(struct ufs_hba *hba)
 	int ret = 0;
 	ktime_t start = ktime_get();
 
+	if (!hba)
+		return 0;
+
 	down(&hba->eh_sem);
-	if (!hba || !hba->is_powered)
+	if (!hba->is_powered)
 		return 0;
 
 	if ((ufs_get_pm_lvl_to_dev_pwr_mode(hba->spm_lvl) ==
@@ -8945,10 +8948,8 @@ int ufshcd_system_resume(struct ufs_hba *hba)
 	int ret = 0;
 	ktime_t start = ktime_get();
 
-	if (!hba) {
-		up(&hba->eh_sem);
+	if (!hba)
 		return -EINVAL;
-	}
 
 	if (!hba->is_powered || pm_runtime_suspended(hba->dev))
 		/*
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

