Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E1EFA9F0
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Nov 2019 07:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKMGAm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Nov 2019 01:00:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfKMGAl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 13 Nov 2019 01:00:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27760609CA; Wed, 13 Nov 2019 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573624841;
        bh=Lpc1vPlBXIBVaSueTeC6tHlXeDwYV/+8vGhGZ8ayr4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMka4P0er2vaK8jmpvxZPIApaclYofjWrg8DBh3mg3UUgNgfzFyI8bR0rteAcN34h
         Zh8aT3zn17A7LkqHuJJtHpGb3DYE2S+I0iCglc/XEfjEQAUf8D8hkT1j2lQxbU5t2g
         ZDcZASaurVqqy5FmyhQnz5wuNCreK+Y6pvQ0/zKw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C2DD609CA;
        Wed, 13 Nov 2019 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573624839;
        bh=Lpc1vPlBXIBVaSueTeC6tHlXeDwYV/+8vGhGZ8ayr4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhgUWHIavGRVrM8bRR2hXLYKwr9VXJfdYN6QQPlTqznGzmoWnjLzpyZIBJAG6zHSZ
         lSfu1WuEoDoDru/bJ/+fB5jcqiU0yo7HIr5a/3PdjInYq6IkXkbJBtEliBHnJm86Ur
         dDq7L6z8Hjmr/K9YWfObZ6goNBtZ7q0VhJ41I+xw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C2DD609CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/5] scsi: ufs: Use DBD setting in mode sense
Date:   Tue, 12 Nov 2019 22:00:20 -0800
Message-Id: <1573624824-671-3-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573624824-671-1-git-send-email-cang@codeaurora.org>
References: <1573624824-671-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

UFS standards requires DBD field to be set to 1 in mode sense(10).

Some card vendors are more strict and check the DBD field, hence
respond with CHECK_CONDITION (Sense key set to ILLEGAL_REQUEST and
ASC set to INVALID FIELD IN CDB).
When host send mode sense for page caching, as a result of the
CHECK_CONDITION response, host assumes that the device doesn't support
the cache feature and doesn't send SYNCHRONIZE_CACHE commands to flush
the device cache. This can result in data corruption in case of sudden
power down, when there is data stored in the device cache.

This patch fixes the DBD field setting as required in UFS standards.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c28c144..5484177 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4596,6 +4596,9 @@ static int ufshcd_slave_alloc(struct scsi_device *sdev)
 	/* Mode sense(6) is not supported by UFS, so use Mode sense(10) */
 	sdev->use_10_for_ms = 1;
 
+	/* DBD field should be set to 1 in mode sense(10) */
+	sdev->set_dbd_for_ms = 1;
+
 	/* allow SCSI layer to restart the device in case of errors */
 	sdev->allow_restart = 1;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

