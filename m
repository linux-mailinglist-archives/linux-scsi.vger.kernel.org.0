Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D732E8784
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Jan 2021 15:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbhABOAV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 2 Jan 2021 09:00:21 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:20241 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbhABOAV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 2 Jan 2021 09:00:21 -0500
IronPort-SDR: 4AYuvZ2XLtu3GoWyVA4I53Sdc7TmBJ2yU6gFzQz7PADJxfC9bnP5Mft6YyTr3LRgtczkKpQVi3
 C4g4Ir04HNVAuoZlE8pAy985CVWCY5PU62Wiq2W3xtCYdN9Tl0XUPJh/CXls29UoynoWHlATtK
 37Ts7MZmW8DQnsLYmR/KfffvIRiaaLoKddeR9e9hPTkTV/ebC0q/pQh0C+jdTcD0KPVFCsmxQW
 s5r3Z4m89N5zHrbbxnxfB3+nif153JT7ju/Wz6ZxDSHzc5za8RjrJlr1b+ggPZPRBuka/UXUya
 A38=
X-IronPort-AV: E=Sophos;i="5.78,469,1599548400"; 
   d="scan'208";a="29476448"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by labrats.qualcomm.com with ESMTP; 02 Jan 2021 05:59:40 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg01-sd.qualcomm.com with ESMTP; 02 Jan 2021 05:59:40 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id F1AA62187E; Sat,  2 Jan 2021 05:59:39 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Subject: [PATCH v3 0/2] Synchronize user layer access with system PM ops and error handling
Date:   Sat,  2 Jan 2021 05:59:32 -0800
Message-Id: <1609595975-12219-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series contains two changes and it is based on 5.11/scsi-queue
The 1st change is just a minor fix.
The 2nd change is to synchronize user layer access through UFS sysfs nodes, so that system PM ops (suspend, resume and shutdown), error handling and async probe won't be disturbed by user layer access. The protection is only added to some sysfs nodes, not all of them.

Change since v2:
- Updated the 1st change, added a global boolean flag to tell if system suspend is invoked when hba is NULL, it is used during resume in case of hba becomes not NULL.

Change since v1:
- Slightly updated the 2nd change, added a dedicated inline func to check hba->shutting_down in ufshcd.h. This inline func can be updated to add more rules for sysfs passage in future.

Can Guo (2):
  scsi: ufs: Fix a possible NULL pointer issue
  scsi: ufs: Protect PM ops and err_handler from user access through
    sysfs

 drivers/scsi/ufs/ufs-sysfs.c | 104 ++++++++++++++++++++++++++++++++++++-------
 drivers/scsi/ufs/ufshcd.c    |  49 ++++++++++++--------
 drivers/scsi/ufs/ufshcd.h    |  10 ++++-
 3 files changed, 128 insertions(+), 35 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

