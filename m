Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85616ED6F3
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 02:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfKDBgJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 3 Nov 2019 20:36:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfKDBgJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 3 Nov 2019 20:36:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C94AE6081E; Mon,  4 Nov 2019 01:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831368;
        bh=xEgyr62S/j7z6MhHFVqjHvo0b6hTHk22v+vwtcK6UBw=;
        h=From:To:Subject:Date:From;
        b=QfhKhm5gntz6QVkrhQQVouH6VRA6zCjK0dl8TEm6Ikj8J0g+qIurHD/VWYMTwL7eC
         xwfKoTUslP73ORmFZmeXpSA1H7FnR3TkFwOnqQFCeM9UvrNEi7zcfB9TVghP7XeZeB
         QIdgbhdc0RutzZecBi60iv0UkjV6pp/i2yU2ZuXI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6CD260A96;
        Mon,  4 Nov 2019 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831368;
        bh=xEgyr62S/j7z6MhHFVqjHvo0b6hTHk22v+vwtcK6UBw=;
        h=From:To:Subject:Date:From;
        b=QfhKhm5gntz6QVkrhQQVouH6VRA6zCjK0dl8TEm6Ikj8J0g+qIurHD/VWYMTwL7eC
         xwfKoTUslP73ORmFZmeXpSA1H7FnR3TkFwOnqQFCeM9UvrNEi7zcfB9TVghP7XeZeB
         QIdgbhdc0RutzZecBi60iv0UkjV6pp/i2yU2ZuXI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6CD260A96
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Subject: [PATCH v2 0/7] UFS driver general fixes bundle 3
Date:   Sun,  3 Nov 2019 17:35:55 -0800
Message-Id: <1572831362-22779-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This bundle includes 7 general fixes for UFS driver.

Changes since v1:
- Added one more change to fix register dump caused sleep in atomic context

Asutosh Das (1):
  scsi: ufs: Abort gating if clock on request is pending

Can Guo (4):
  scsi: ufs: Add device reset in link recovery path
  scsi: ufs-qcom: Add reset control support for host controller
  scsi: ufs: Fix up auto hibern8 enablement
  scsi: ufs: Fix register dump caused sleep in atomic context

Subhash Jadavani (1):
  scsi: ufs: Fix error handing during hibern8 enter

Venkat Gopalakrishnan (1):
  scsi: ufs: Fix irq return code

 drivers/scsi/ufs/ufs-qcom.c  |  53 +++++++++++++
 drivers/scsi/ufs/ufs-qcom.h  |   3 +
 drivers/scsi/ufs/ufs-sysfs.c |   5 +-
 drivers/scsi/ufs/ufshcd.c    | 172 +++++++++++++++++++++++++++++++------------
 4 files changed, 184 insertions(+), 49 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

