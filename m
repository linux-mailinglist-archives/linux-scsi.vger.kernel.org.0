Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB42E2DF3E7
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Dec 2020 06:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgLTFnc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Dec 2020 00:43:32 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:29195 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgLTFnb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 20 Dec 2020 00:43:31 -0500
IronPort-SDR: jA3w2H0Li4OEfU3/8PM9bQJYmth7OxhnyVH9u8QmSnuHNI38qmemm0PHpuiVpfvvDtRxU80u8X
 jaSL9lM4QhvRuyuyXogMOi4dQmm5mGueHEd2MpVxGDJfEa9RmoRPmhGfzd4WwiwWTzIoBbOINt
 6tZGs7mUEwQ71CVIHvYuEC+1ICMJeoMPsaLMw5YW2slTh+WubYFG2K4vkqIzaeHizKMff6PmQq
 xCg5EDHN3AqAuuaPSdMKKm9d7bAS9Hmm/8SUuYQqDW4gdh+6eTnMoyFFKW3lx2ZhP/SbT9fcLj
 CD4=
X-IronPort-AV: E=Sophos;i="5.78,434,1599548400"; 
   d="scan'208";a="29398168"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 19 Dec 2020 21:42:50 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 19 Dec 2020 21:42:50 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 3D92D212A8; Sat, 19 Dec 2020 21:42:50 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v6 0/3] Three changes related with UFS clock scaling
Date:   Sat, 19 Dec 2020 21:42:44 -0800
Message-Id: <1608442968-38560-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series is made based on 5.10/scsi-fixes branch.

Current devfreq framework allows sysfs nodes like governor, min_freq and max_freq to be changed even after devfreq device is suspended.
Meanwhile, devfreq_suspend_device() cannot/wouldn't synchronize ongoing execution invoked through sysfs nodes menitioned above either.
It means that UFS clock scaling can be invoked at any time (clkscale_enable is same) regardless of the state of UFS host and/or device.

The 1st change allows contexts to prevent clock scaling from being invoked through sysfs nodes like clkscale_enable.
The 2nd change is just a minor code cleanup.
The 3rd change reverts one old change which can be covered by the 1st change. For branches which do not have this change yet, it can be ignored.

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
  scsi: ufs: Clean up ufshcd_exit_clk_scaling/gating()
  scsi: ufs: Revert "Make sure clk scaling happens only when HBA is
    runtime ACTIVE"

 drivers/scsi/ufs/ufshcd.c | 118 ++++++++++++++++++++++++++--------------------
 drivers/scsi/ufs/ufshcd.h |  10 +++-
 2 files changed, 76 insertions(+), 52 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

