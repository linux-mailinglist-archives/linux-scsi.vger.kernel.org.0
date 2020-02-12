Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7782115A0B7
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Feb 2020 06:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgBLFik (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Feb 2020 00:38:40 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:36289 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgBLFik (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Feb 2020 00:38:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581485920; h=Message-Id: Date: Subject: To: From: Sender;
 bh=yNGVgmjwiwryzyjpdUe+/QLRZ9ovEttO4I5NQbLUKaI=; b=pjoa44frE+XG7lti0SE/b1apd2gI51DQ/53vF/ogX9qV0wb5gpsNB9bxCEuDYDq2EVwKiyi4
 hRHV6/ovIYrK/BWV74kUfPUpUJNA8f30pNaO5yd12EGZ8FGgPGvlBqU1QwPN8+oEnt2ATh1y
 euhRnCTobff1JXB9cMMAIv1sua8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e438f5f.7f17994a9f80-smtp-out-n02;
 Wed, 12 Feb 2020 05:38:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C512C4479D; Wed, 12 Feb 2020 05:38:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3EC4C43383;
        Wed, 12 Feb 2020 05:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3EC4C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v1 0/2] Select ADAPT type when do gear scaling
Date:   Tue, 11 Feb 2020 21:38:27 -0800
Message-Id: <1581485910-8307-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Call ufshcd_config_pwr_mode() in ufshcd_scale_gear() to utilize
vops_pwr_change_notify() to allow selecting ADAPT type before
change the power mode.

Can Guo (2):
  scsi: ufs: Use ufshcd_config_pwr_mode() when scale gear
  scsi: ufs: Select INITIAL ADAPT type for HS Gear4

 drivers/scsi/ufs/ufs-qcom.c | 14 ++++++++++++++
 drivers/scsi/ufs/ufshcd.c   |  6 ++----
 drivers/scsi/ufs/unipro.h   |  7 +++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
