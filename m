Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF740EF0E
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Sep 2021 04:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbhIQCB4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Sep 2021 22:01:56 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:1081 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbhIQCB4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 Sep 2021 22:01:56 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 22:01:56 EDT
IronPort-SDR: Vjal9AbcCSMvnjzsBdf+ZIVr8LrGiCpsM5T3sZhnEHZ8L8tyeeJ1llAcVV/DSelfKL9EXzMw86
 1OU/0e/H0ApkJCnpE0spk9sNsK5lAndL4x3ViUVscmfe58m3jqZbJLugZknbbX9KyCHurJLvHi
 abMEevUu/GEQzUM6h1AEhoSkEMKqWxypeMAVCwXLnO5gSce2sY8m2sEDXWMD80/ofWQWY65ZP+
 LeE37u+02JJ1IS3DlgOD5lyhgR6R2dywFkq7A14aqwzTOqnm/g0QGTg4LV/udKdvKymIMjtQdU
 4Kk=
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="47922504"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 16 Sep 2021 18:54:30 -0700
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg04-sd.qualcomm.com with ESMTP; 16 Sep 2021 18:54:29 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id E1EB921E7F; Thu, 16 Sep 2021 18:54:29 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: ufs: Fix a possible dead lock in clock scaling
Date:   Thu, 16 Sep 2021 18:51:53 -0700
Message-Id: <1631843521-2863-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Assume a scenario where task A and B call ufshcd_devfreq_scale()
simultaneously. After task B calls downgrade_write() [1], but before it
calls down_read() [3], if task A calls down_write() [2], when task B calls
down_read() [3], it will lead to dead lock. Fix this by utilizing the
existing flag scaling.is_allowed to make sure only one task can do clock
scaling at a time.

Task A -
down_write [2]
ufshcd_clock_scaling_prepare
ufshcd_devfreq_scale
ufshcd_clkscale_enable_store

Task B -
down_read [3]
ufshcd_exec_dev_cmd
ufshcd_query_flag
ufshcd_wb_ctrl
downgrade_write [1]
ufshcd_devfreq_scale
ufshcd_devfreq_target
devfreq_set_target
update_devfreq
devfreq_performance_handler
governor_store

Fixes: 0e9d4ca43ba81 ("scsi: ufs: Protect some contexts from unexpected clock scaling")
Signed-off-by: Can Guo <cang@codeaurora.org>

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3841ab49..782a9c8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1186,6 +1186,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
 		goto out;
 	}
 
+	hba->clk_scaling.is_allowed = false;
 	/* let's not get into low power until clock scaling is completed */
 	ufshcd_hold(hba, false);
 
@@ -1193,12 +1194,10 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
 	return ret;
 }
 
-static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
+static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba)
 {
-	if (writelock)
-		up_write(&hba->clk_scaling_lock);
-	else
-		up_read(&hba->clk_scaling_lock);
+	hba->clk_scaling.is_allowed = true;
+	up_write(&hba->clk_scaling_lock);
 	ufshcd_scsi_unblock_requests(hba);
 	ufshcd_release(hba);
 }
@@ -1215,7 +1214,6 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
 static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 {
 	int ret = 0;
-	bool is_writelock = true;
 
 	ret = ufshcd_clock_scaling_prepare(hba);
 	if (ret)
@@ -1245,12 +1243,12 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 	}
 
 	/* Enable Write Booster if we have scaled up else disable it */
-	downgrade_write(&hba->clk_scaling_lock);
-	is_writelock = false;
+	up_write(&hba->clk_scaling_lock);
 	ufshcd_wb_toggle(hba, scale_up);
+	down_write(&hba->clk_scaling_lock);
 
 out_unprepare:
-	ufshcd_clock_scaling_unprepare(hba, is_writelock);
+	ufshcd_clock_scaling_unprepare(hba);
 	return ret;
 }
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

