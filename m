Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8F109961
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Nov 2019 07:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKZGxp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Nov 2019 01:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfKZGxp (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Nov 2019 01:53:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4093C4479F; Tue, 26 Nov 2019 06:53:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13CA9C43383;
        Tue, 26 Nov 2019 06:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13CA9C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=pass smtp.mailfrom=cang@qti.qualcomm.com
From:   Can Guo <cang@qti.qualcomm.com>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Can Guo <cang@qti.qualcomm.com>
Subject: [PATCH v3 0/4]  UFS driver general fixes bundle 5
Date:   Mon, 25 Nov 2019 22:53:29 -0800
Message-Id: <1574751214-8321-1-git-send-email-cang@qti.qualcomm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This bundle includes 4 general fixes for UFS driver.

Changes since v2:
- Incorporated review comments from Avri Altman, Alim Akhtar and Bean Huo.
- Updated change "scsi: ufs: Update VCCQ2 and VCCQ min/max voltage hard codes"

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

 drivers/scsi/ufs/ufs.h    |  6 +++---
 drivers/scsi/ufs/ufshcd.c | 31 +++++++++++++++----------------
 drivers/scsi/ufs/ufshcd.h |  2 ++
 3 files changed, 20 insertions(+), 19 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

