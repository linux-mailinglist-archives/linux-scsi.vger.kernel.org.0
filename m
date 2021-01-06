Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F782EB92B
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jan 2021 06:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbhAFFF3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jan 2021 00:05:29 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:6985 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFFF3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jan 2021 00:05:29 -0500
IronPort-SDR: o04Zs1rGoXkJ+2VR0aVGML/aTrbFF+1yZmupufYCOxf4UVRsewrwK8eWW6RkKKz00FFBm5z6Al
 jQQgE7vVFOuKWiMDOnXiEsJBAZ5/KNaPge6t3ifJ1M1Jg8fNQ/gXe9Kdt6C9dUnwS3yylM1vYE
 GRZED1OZBMCFQYl/MwRoC8qNBmL1kExyEiPgG5NSxTi3U0gs37PQJApK8YC87SwG9e4e/dfERv
 SynhgqFYkNHHLqd6jAREHbuXPmS2Skx0iIl0bSQTJZu6mxF9gaeGm6AT7x90vP21oXFilb6sCG
 mMM=
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="47640803"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 05 Jan 2021 21:04:48 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg04-sd.qualcomm.com with ESMTP; 05 Jan 2021 21:04:48 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 39967218E2; Tue,  5 Jan 2021 21:04:48 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v9 0/3] Three changes related with UFS clock scaling
Date:   Tue,  5 Jan 2021 21:04:42 -0800
Message-Id: <1609909486-21053-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series is made based on 5.12/scsi-queue branch.

Current devfreq framework allows sysfs nodes like governor, min_freq and max_freq to be changed even after devfreq device is suspended.
Meanwhile, devfreq_suspend_device() cannot/wouldn't synchronize clock scaling which has already been invoked through devfreq sysfs nodes menitioned above.
It means that clock scaling invoked through these devfreq sysfs nodes can happen at any time regardless of the state of UFS host and/or device.
We need to control and synchronize clock scaling in this scenario.

The 1st change allows contexts to prevent clock scaling from being invoked through devfreq sysfs nodes.
The 2nd change is just a code cleanup for clk_scaling/gating initialization routine.
The 3rd change reverts one old change which can be covered by the 1st change. For branches which do not have this change yet, it can be ignored.

Change since v8:
- Rebased on 5.12/scsi-queue

Change since v7:
- Slightly updated the 1st change: changed the up_write() before ufshcd_wb_ctrl() to downgrade_write() in ufshcd_devfreq_scale(),
  so that ufshcd_wb_ctrl() is called with clk_scale_lock held, this is to make sure race condition won't happen to ufshcd_wb_ctrl().

Change since v6:
- Updated the 2nd change

Change since v5:
- Reomved the code change in ufshcd_shutdown() since it is not quite relevant with this fix

Change since v4:
- Updated some comment lines as requested by Stanley

Change since v3:
- Slightly updated the 1st change

Change since v2:
- Split the 1st change to two changes, which become the 1st change and the 3rd change

Change since v1:
- Updated the 2nd change


Can Guo (3):
  scsi: ufs: Protect some contexts from unexpected clock scaling
  scsi: ufs: Refactor ufshcd_init/exit_clk_scaling/gating()
  scsi: ufs: Revert "Make sure clk scaling happens only when HBA is
    runtime ACTIVE"

 drivers/scsi/ufs/ufshcd.c | 217 ++++++++++++++++++++++++++--------------------
 drivers/scsi/ufs/ufshcd.h |  10 ++-
 2 files changed, 130 insertions(+), 97 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

