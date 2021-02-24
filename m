Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED83236EB
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Feb 2021 06:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhBXFhd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Feb 2021 00:37:33 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:60044 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhBXFhd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Feb 2021 00:37:33 -0500
IronPort-SDR: Hs03IBt2XEUP2JDBHS/Q77Mxmp0BrG+VNSPmTZqX6UYxuEk1bonioP7qOgpuhIi2vAUkA9kNns
 5xo3ZANUptCkyJa4NgCtJ4ZEXOc/YKBTt/PZbmCIWuGC22V/o85cr/OfTp9z8fIVtkZpo30F9Y
 v/RrviaKWtK9uA4YCdcMGAzHgDIzHIbn2Aep2QV42NC1lY/9f/JzzJDkZTBolnnj54H+FTyVaD
 rj+uON/Nd9VpmsavdgFwbf8nJZHJdxzF0bpI56EzOHzx+o8OJ3zaMhXLulfTQcggvB2VuZbBuv
 HmI=
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="29674164"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 23 Feb 2021 21:36:53 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 23 Feb 2021 21:36:52 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 3352A21A10; Tue, 23 Feb 2021 21:36:52 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, cang@codeaurora.org
Subject: [PATCH v2 0/3] Three minor changes related with error handling
Date:   Tue, 23 Feb 2021 21:36:46 -0800
Message-Id: <1614145010-36079-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The 1st change is a complementary change for error handling.
The 2nd change disables IRQ in host reset path to avoid possible NoC issues.
The 3rd change is a minor cleanup to !hba checks in suspend/resume paths

Can Guo (2):
  scsi: ufs: Minor adjustments to error handling
  scsi: ufs: Remove redundant checks of !hba in suspend/resume callbacks

Nitin Rawat (1):
  scsi: ufs-qcom: Disable interrupt in reset path

 drivers/scsi/ufs/ufs-qcom.c | 10 ++++++++++
 drivers/scsi/ufs/ufshcd.c   | 39 ++++++++++++---------------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

