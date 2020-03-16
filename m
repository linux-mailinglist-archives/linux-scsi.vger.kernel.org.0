Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12118186571
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2020 08:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgCPHKR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Mar 2020 03:10:17 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:12763 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPHKR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Mar 2020 03:10:17 -0400
IronPort-SDR: fsv5aapoqoBhKXcbtM2Nc2YkZ+mN4E4fPdQaBiyhl8V5sBFbiinIwN/xXqAQqmd+RzdOo1TDc5
 tIG5avrm5qhX5w2+2b2VnD7Jg4qFY7aPfJcZx1HyqpOcjSQT95kQy1dfMZMnmDlwO6L9eMTkVo
 zgSbcH3MTUCOfa87GEm4ZR7SIxJt48ouFG0gKS55ms8Yx0ZLvhFk6A6fVs+7mmiujniSQJZcGA
 J5yZ7dvEha8XhcMEwuVLn8tKXW3D1hp70fwub+cJ26TU8ygDS/2uBQ83X9BucZadNhHxcrh+R5
 vyA=
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="28595121"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 16 Mar 2020 00:06:21 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 16 Mar 2020 00:06:21 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id 339AE3A63; Mon, 16 Mar 2020 00:06:21 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v4 0/2] UFS driver general fixes bundle 2
Date:   Mon, 16 Mar 2020 00:06:09 -0700
Message-Id: <1584342373-10282-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This bundle includes 2 general fixes for UFS driver.

Changes since v3:
- Removed trivial spaces in comments

Changes since v2:
- Rebased on 5.7/scsi-queue and fixed minor conflicts

Changes since v1:
- Fixed minor typo

Can Guo (1):
  scsi: ufs: Do not rely on prefetched data

Subhash Jadavani (1):
  scsi: ufs: Clean up ufshcd_scale_clks() and clock scaling error out
    path

 drivers/scsi/ufs/ufshcd.c | 100 +++++++++++++++++++++++++++++-----------------
 drivers/scsi/ufs/ufshcd.h |  11 -----
 2 files changed, 64 insertions(+), 47 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

