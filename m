Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5B2257CE
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 08:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGTGf7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Jul 2020 02:35:59 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:11233 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGf7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 Jul 2020 02:35:59 -0400
IronPort-SDR: UyeMC1NXP3NId5cm3UeQ/8VtiIslobAvHaFFiz80mOAYr1TSBDPRjLONfzIKe48TWW9LdqA6b4
 GJ/APUVGY+rsveBXWJxq7Q64QnJePmcBKrVFzHPffn+lMoO+WmyHivOMPxM2EKDE20cs24lnev
 Z4NEFHsOe7xJVNebsMKSFHxgEnvGExcWY+LLTL5YAWmJGrqfceRzB4d+KVH2ktEyBCRPk9svhi
 YYJAw3uBhY8sfHbsQwxoAu+IIr8CNpBPzmRYtBRSSnrZEfGRA9Jbgpw1jhQXHPCnk1icFsutMl
 pLg=
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="47226980"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 19 Jul 2020 23:35:59 -0700
Received: from pacamara-linux.qualcomm.com ([192.168.140.135])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 19 Jul 2020 23:35:58 -0700
Received: by pacamara-linux.qualcomm.com (Postfix, from userid 359480)
        id 6F0FF22DA5; Sun, 19 Jul 2020 23:35:58 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        sh425.lee@samsung.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Subject: [PATCH v4 0/8] Fix up and simplify error recovery mechanism
Date:   Sun, 19 Jul 2020 23:35:47 -0700
Message-Id: <1595226956-7779-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The changes have been tested with error injections of multiple error types (and
all kinds of mixture of them) during runtime, e.g. hibern8 enter/ exit error,
power mode change error and fatal/non-fatal error from IRQ context. During the
test, error injections happen randomly across all contexts, e.g. clk scaling,
clk gate/ungate, runtime suspend/resume and IRQ.

There are a few more fixes to resolve other minor problems based on the main
change, such as LINERESET handling and racing btw error handler and system
suspend/resume/shutdown, but they will be pushed after this series is taken,
due to there are already too many lines in these changes.

Change since v3:
- Split the original change "scsi: ufs: Fix up and simplify error recovery mechanism" into 5 changes

Change since v2:
- Incorporate Bart's comment to change "scsi: ufs: Add checks before setting clk-gating states"
- Revised the commit msg of change "scsi: ufs: Fix up and simplify error recovery mechanism"

Change since v1:
- Fixed a compilation error in case that CONFIG_PM is N


Can Guo (8):
  scsi: ufs: Add checks before setting clk-gating states
  scsi: ufs: Fix imbalanced scsi_block_reqs_cnt caused by ufshcd_hold()
  ufs: ufs-qcom: Fix a few BUGs in func ufs_qcom_dump_dbg_regs()
  scsi: ufs: Add some debug infos to ufshcd_print_host_state
  scsi: ufs: Fix concurrency of error handler and other error recovery
    paths
  scsi: ufs: Recover hba runtime PM error in error handler
  scsi: ufs: Move dumps in IRQ handler to error handler
  scsi: ufs: Fix a racing problem btw error handler and runtime PM ops

 drivers/scsi/ufs/ufs-qcom.c  |  17 +-
 drivers/scsi/ufs/ufs-sysfs.c |   1 +
 drivers/scsi/ufs/ufshcd.c    | 499 +++++++++++++++++++++++++++----------------
 drivers/scsi/ufs/ufshcd.h    |  15 ++
 4 files changed, 333 insertions(+), 199 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

