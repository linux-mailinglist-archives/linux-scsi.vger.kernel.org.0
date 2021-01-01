Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537B22E832D
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Jan 2021 06:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbhAAFpg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Jan 2021 00:45:36 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:28895 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbhAAFpg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Jan 2021 00:45:36 -0500
IronPort-SDR: kcOeIESvyJEUClK0iXioosR67nmkw/VXX+b3M+6FRpZvf/Pa1xdL9yBfkwqNqPL306dIaRlrcB
 gbqtCJQ8Vbmb72QNgtA4nOmMSkh+DD1gWC92uAQAWDaOAxkLdXG0C3IfEGFQgOjTfgCbd6w6xx
 +gC53FrGO4jUmcuLgWLYFNDXRhPLk2qixAZNhwESUWz6fox0NeeybKEFb321s6dJEWuwfovkFL
 UqDT8lii8Gsxl4o3KR73D2fkC0fFBv1Du61Bc9dCUGcTE8iM1nGcqETSOVgPs+j4gLKgF3Dtao
 0bc=
X-IronPort-AV: E=Sophos;i="5.78,466,1599548400"; 
   d="scan'208";a="29470878"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 31 Dec 2020 21:44:56 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 31 Dec 2020 21:44:55 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 6B602212C1; Thu, 31 Dec 2020 21:44:55 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Subject: [PATCH v2 0/2] Synchronize user layer access with system PM ops and error handling
Date:   Thu, 31 Dec 2020 21:44:51 -0800
Message-Id: <1609479893-8889-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series contains two changes and it is based on 5.11/scsi-queue
The 1st change is just a minor fix.
The 2nd change is to synchronize user layer access through UFS sysfs nodes, so that system PM ops (suspend, resume and shutdown), error handling and async probe won't be disturbed by user layer access. The protection is only added to some sysfs nodes, not all of them.

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

