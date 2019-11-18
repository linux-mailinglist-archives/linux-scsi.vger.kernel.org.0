Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707C9FFD6C
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 04:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKRDvJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 17 Nov 2019 22:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfKRDvJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 17 Nov 2019 22:51:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DAA5BC4479D; Mon, 18 Nov 2019 03:51:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF1D9C43383;
        Mon, 18 Nov 2019 03:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF1D9C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=pass smtp.mailfrom=cang@qti.qualcomm.com
From:   Can Guo <cang@qti.qualcomm.com>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Can Guo <cang@qti.qualcomm.com>
Subject: [PATCH v2 0/4] UFS driver general fixes bundle 5
Date:   Sun, 17 Nov 2019 19:50:56 -0800
Message-Id: <1574049061-11417-1-git-send-email-cang@qti.qualcomm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This bundle includes 4 general fixes for UFS driver.

Changes since v1:
- Incorporated review comments from Avri Altman.
- Removed change "scsi: ufs: Add new bit field PA_INIT to UECDL register".
- Updated change "scsi: ufs: Complete pending requests in host reset and restore path".

Asutosh Das (1):
  scsi: ufs: Recheck bkops level if bkops is disabled

Can Guo (3):
  scsi: ufs: Update VCCQ2 and VCCQ min/max voltage hard codes
  scsi: ufs: Avoid messing up the compl_time_stamp of lrbs
  scsi: ufs: Complete pending requests in host reset and restore path

 drivers/scsi/ufs/ufs.h    |  4 ++--
 drivers/scsi/ufs/ufshcd.c | 31 +++++++++++++++----------------
 drivers/scsi/ufs/ufshcd.h |  2 ++
 3 files changed, 19 insertions(+), 18 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

