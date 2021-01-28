Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98B306C1F
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Jan 2021 05:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhA1ERt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Jan 2021 23:17:49 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:40784 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhA1ERp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 Jan 2021 23:17:45 -0500
IronPort-SDR: OprRn3r4q5StQDslDiawAZFtjakEuR6au4kIXGT+/XY5wuVGYe2piSOqMXkqodhwN2pLDiU3Q9
 gj5aLzIQtEm/ZYKU7ivEOKSicNfEfEXd+N1Os86d2flrzYXrym6FmwVTxkIBDH3RckzFUI0FrF
 xdaiWPGEHPLRbH6/UvikBH2YXsfv8to1lf/iLvIAIcqAIXjYFAk34+kxKdpAwaPjFNMgzxhFU8
 FBIEDH28wsaTnukbSCi912UmocACt+olmA0WKqaZ25YgE/l7MW7leuanCCCBRBV5Aq8CC9682y
 aN0=
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="47715647"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 27 Jan 2021 20:17:04 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 27 Jan 2021 20:17:03 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 5EAD7219A2; Wed, 27 Jan 2021 20:17:03 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     jaegeuk@kernel.org, bvanassche@acm.org, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, hongwus@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        cang@codeaurora.org
Subject: [PATCH v3 0/3] Three fixes for task management request implementation
Date:   Wed, 27 Jan 2021 20:16:01 -0800
Message-Id: <1611807365-35513-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

These fixes are based on Jaegeuk's change - https://git.kernel.org/mkp/scsi/c/eeb1b55b6e25

Change since v2:
- Split one change into 3 changes

Change since v1:
- Typo fixed

Can Guo (3):
  scsi: ufs: Fix task management request completion timeout
  scsi: ufs: Fix a race condition btw task management request send and
    compl
  scsi: ufs: Fix wrong Task Tag used in task management request UPIUs

 drivers/scsi/ufs/ufshcd.c | 70 +++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

