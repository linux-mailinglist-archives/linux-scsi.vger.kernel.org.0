Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDAE224873
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Jul 2020 06:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGRENm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Jul 2020 00:13:42 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:2007 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgGRENk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 18 Jul 2020 00:13:40 -0400
IronPort-SDR: +X23YoJFj1Fp3a+/GTEZZt/mgJgTpKpYd/OGYBnlpsP8Cy4ncmrI8gY/dPXLHKfw8cuHbCMNiR
 T6+KEH7hkqCQw/wgRFVivX0UTUrJDjGoGj/YN9DoSUlFjhxYqKAddKlLE5bK0JAeEO3JVzwwRF
 EWItaMSu4BLLrFdKvcSjgYJqLkV2KgYuuHQ6FgeYx6zHhoKhRbu7Is9S3SCi6hybyQnJ1PYivx
 UdMXXzX6wMiNTINIvw6QC6JPQQFvhBCnMJ4lXLH+4u7nqM2Wut0pFjb0GPBwEU/CYFyTYhn2FG
 47w=
X-IronPort-AV: E=Sophos;i="5.75,365,1589266800"; 
   d="scan'208";a="47222741"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 17 Jul 2020 21:13:07 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg04-sd.qualcomm.com with ESMTP; 17 Jul 2020 21:13:06 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id 4E57B22D61; Fri, 17 Jul 2020 21:13:06 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        sh425.lee@samsung.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Subject: [PATCH v3 0/4] Fix up and simplify error recovery mechanism
Date:   Fri, 17 Jul 2020 21:13:00 -0700
Message-Id: <1595045585-16402-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series contains 4 changes, the first 3 of them are minor changes to make
sure the main change "scsi: ufs: Fix up and simplify error recovery mechanism"
work properly.

The changes have been tested with error injections of multiple error types (and
all kinds of mixture of them) during runtime, e.g. hibern8 enter/ exit error,
power mode change error and fatal/non-fatal error from IRQ context. During the
test, error injections happen randomly across all contexts, e.g. clk scaling,
clk gate/ungate, runtime suspend/resume and IRQ.

There are a few more fixes to resolve other minor problems based on the main
change, but they will be pushed after this series is taken, due to there are
already too many lines in this change.

Change since v2:
- Incorporate Bart's comment to change "scsi: ufs: Add checks before setting clk-gating states"
- Revised the commit msg of change "scsi: ufs: Fix up and simplify error recovery mechanism"

Change since v1:
- Fixed a compilation error in case that CONFIG_PM is N

Can Guo (4):
  scsi: ufs: Add checks before setting clk-gating states
  scsi: ufs: Fix imbalanced scsi_block_reqs_cnt caused by ufshcd_hold()
  ufs: ufs-qcom: Fix a few BUGs in func ufs_qcom_dump_dbg_regs()
  scsi: ufs: Fix up and simplify error recovery mechanism

 drivers/scsi/ufs/ufs-qcom.c  |  17 +-
 drivers/scsi/ufs/ufs-sysfs.c |   1 +
 drivers/scsi/ufs/ufshcd.c    | 477 ++++++++++++++++++++++++++-----------------
 drivers/scsi/ufs/ufshcd.h    |  15 ++
 4 files changed, 314 insertions(+), 196 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

