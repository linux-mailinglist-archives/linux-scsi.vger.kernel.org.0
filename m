Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B21588E2
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Feb 2020 04:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgBKDlB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Feb 2020 22:41:01 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61227 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727752AbgBKDlB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Feb 2020 22:41:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581392460; h=Message-Id: Date: Subject: To: From: Sender;
 bh=82n36pymZ4C187KFW3fH7LKGuk36Mr7zkUB9mA91hcw=; b=RnheOHtEyo8hEzLKsqtYz7VnbP8KB3lJTH5Nj5T9kvdPBa/oPpZfhF456mXc+aqVl4MBct3k
 U3qJUF+vo1pnLqjSo+ENZSVlJNprlNXzm9NNcP306b12KxFWhdn/Lup4AkDeFncYmpaPsYh+
 Wgo6cLM2wq48Js8JtjloUcWj3xM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42224b.7fc838341928-smtp-out-n03;
 Tue, 11 Feb 2020 03:40:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67BDCC447A0; Tue, 11 Feb 2020 03:40:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DFCAC43383;
        Tue, 11 Feb 2020 03:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DFCAC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v10 0/7] UFS driver general fixes bundle 4
Date:   Mon, 10 Feb 2020 19:40:43 -0800
Message-Id: <1581392451-28743-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This bundle includes 7 general fixes for UFS driver.

Changes since v9:
- Incoperated comments from Hongwu to add a space btw switch and parenthesis in patch #3

Changes since v8:
- Incoperated comments from Arvi to add "Fixes" to commit message of patch #5
- Switched the order of patch #3 and #4 to reflect the dependency.

Changes since v7:
- Incoperated comments from Bjorn and Arvi.
- Removed patch #8.

Changes since v6:
- Incoperated Avri's comment.

Changes since v5:
- Incoperated Stanley's suggestions to make the extra delay added up to bRefClkGatingWaitTime as vendor specific

Changes since v4:
- Rebased this series

Changes since v3:
- Fixed patch #8

Changes since v2:
- Move the ref clk gating wait delay to ufs-qcom.c
- Added one more change to select INITIAL adapt for HS G4

Changes since v1:
- Fixed minor typo

Asutosh Das (1):
  scsi: ufs: set load before setting voltage in regulators

Can Guo (5):
  scsi: ufs-qcom: Adjust bus bandwidth voting and unvoting
  scsi: ufs: Remove the check before call setup clock notify vops
  scsi: ufs: Fix ufshcd_hold() caused scheduling while atomic
  scsi: ufs: Add dev ref clock gating wait time support
  scsi: ufs-qcom: Delay specific time before gate ref clk

Sayali Lokhande (1):
  scsi: ufs: Flush exception event before suspend

 drivers/scsi/ufs/ufs-qcom.c | 100 +++++++++++++++++++++++++++++++-------------
 drivers/scsi/ufs/ufs.h      |   3 ++
 drivers/scsi/ufs/ufshcd.c   |  96 +++++++++++++++++++++++++++++-------------
 3 files changed, 143 insertions(+), 56 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
