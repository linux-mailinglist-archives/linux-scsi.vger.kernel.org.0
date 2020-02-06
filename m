Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D0153EEB
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Feb 2020 07:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBFG5G (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Feb 2020 01:57:06 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:63714 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727843AbgBFG5G (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Feb 2020 01:57:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580972225; h=Message-Id: Date: Subject: To: From: Sender;
 bh=FKKk7ttTBERPnDFgKMOiDn6qO9W0nqA+dc9TvyF5wj4=; b=mBNUS7Qx0mcT5uMXS2otbrwoucTdprsYBPsbkxzom+frcXoc+FQqy3xBNXDe3Mzq2xE3y+9L
 M9d9pnhZp3+C1a0EfeZ1SsV2Fg4CqoZOE2algyFIEVKcMvYCGXsxk++Crt8bLEY8+6cssFP+
 PIBE5Wi8vYalRgP9fqxZff9y/ho=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3bb8bb.7fa68a4bd500-smtp-out-n03;
 Thu, 06 Feb 2020 06:56:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1BC8C4479C; Thu,  6 Feb 2020 06:56:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20D3CC433CB;
        Thu,  6 Feb 2020 06:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20D3CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v6 0/8] UFS driver general fixes bundle 4
Date:   Wed,  5 Feb 2020 22:56:43 -0800
Message-Id: <1580972212-29881-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This bundle includes 8 general fixes for UFS driver.

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

Can Guo (6):
  scsi: ufs: Remove the check before call setup clock notify vops
  scsi: ufs-qcom: Adjust bus bandwidth voting and unvoting
  scsi: ufs: Fix ufshcd_hold() caused scheduling while atomic
  scsi: ufs: Add dev ref clock gating wait time support
  scsi: ufs-qcom: Delay specific time before gate ref clk
  scsi: ufs: Select INITIAL adapt for HS Gear4

Sayali Lokhande (1):
  scsi: ufs: Flush exception event before suspend

 drivers/scsi/ufs/ufs-qcom.c |  79 +++++++++++++++++++++++---------
 drivers/scsi/ufs/ufs.h      |   3 ++
 drivers/scsi/ufs/ufshcd.c   | 108 ++++++++++++++++++++++++++++++++------------
 drivers/scsi/ufs/ufshci.h   |   1 +
 drivers/scsi/ufs/unipro.h   |   7 +++
 5 files changed, 148 insertions(+), 50 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
