Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0205C2D435C
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Dec 2020 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgLINgZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Dec 2020 08:36:25 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:39396 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732206AbgLINgZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Dec 2020 08:36:25 -0500
IronPort-SDR: I126Nt3ViAB86vyipeafsp5jpovx2n3VEz/+wTBMZ68bDgePC/UagqTuh80TZ2mU55GQBZjUEx
 WgxMccWextHVpyAvbDb7VdqQfLBEzt8VHi0GtbiUN1ZeXEWohMj3gOq9bsihUlQrlGwAI+Y0md
 gQho2Yb2KdMhm0CARGG/XDZ3lq/yZGw2PC+0iGzELFUwAcD6SseyvVqLcyYNjPh7DYhHRU3gjD
 NOTSwu6RvRFRww02XAERw7gqqS55+BCYEApT8PLf9NZOK9AOGLbErbtKJvQ7mc+nRmJO91laWz
 F5g=
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="29333083"
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by labrats.qualcomm.com with ESMTP; 09 Dec 2020 05:35:45 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg03-sd.qualcomm.com with ESMTP; 09 Dec 2020 05:35:44 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 2218421340; Wed,  9 Dec 2020 05:35:44 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v2 0/2] Two changes related with UFS clock scaling
Date:   Wed,  9 Dec 2020 05:35:39 -0800
Message-Id: <1607520942-22254-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series is made based on 5.11/scsi-fixes branch.
The 1st change allows contexts to prevent clock scaling from being invoked through sysfs nodes like clkscale_enable.
The 2nd change is just a minor code cleanup.

Change since v1:
- Updated the 2nd change

Can Guo (2):
  scsi: ufs: Protect some contexts from unexpected clock scaling
  scsi: ufs: Clean up ufshcd_exit_clk_scaling/gating()

 drivers/scsi/ufs/ufshcd.c | 116 ++++++++++++++++++++++++++--------------------
 drivers/scsi/ufs/ufshcd.h |   6 +++
 2 files changed, 71 insertions(+), 51 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

