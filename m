Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049091588EF
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Feb 2020 04:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgBKDl0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Feb 2020 22:41:26 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:25144 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgBKDlZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Feb 2020 22:41:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581392484; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9SGjnvm6LlZlgsWKDoqurru12ybAut9xXpgs6hQ/Ncc=; b=K4rVr9BqKpg4HiIDuMW1ezPAlEYouCx92ROTBcZ8CM2MvnDfD76yCCZzR9Mfqp485pOx231o
 owmIH8xh6ZBTepHon0RxkvXI2sOTVsDoXqKngn13zViqQ3dZnRElzjhNINZ2iRC8hBywc6rp
 /vwkjRkQ8n4Cw1GngBeqWv8AugQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42225d.7f2e5fdb2260-smtp-out-n03;
 Tue, 11 Feb 2020 03:41:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 574F2C447AB; Tue, 11 Feb 2020 03:41:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78042C43383;
        Tue, 11 Feb 2020 03:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78042C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v10 4/7] scsi: ufs: Remove the check before call setup clock notify vops
Date:   Mon, 10 Feb 2020 19:40:47 -0800
Message-Id: <1581392451-28743-5-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581392451-28743-1-git-send-email-cang@codeaurora.org>
References: <1581392451-28743-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The functionality of vendor specific ops should be handled properly in
platform specific driver, but should not count on the UFS driver.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 83ae093..bbc2607 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7402,16 +7402,9 @@ static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
 	if (list_empty(head))
 		goto out;
 
-	/*
-	 * vendor specific setup_clocks ops may depend on clocks managed by
-	 * this standard driver hence call the vendor specific setup_clocks
-	 * before disabling the clocks managed here.
-	 */
-	if (!on) {
-		ret = ufshcd_vops_setup_clocks(hba, on, PRE_CHANGE);
-		if (ret)
-			return ret;
-	}
+	ret = ufshcd_vops_setup_clocks(hba, on, PRE_CHANGE);
+	if (ret)
+		return ret;
 
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
@@ -7435,16 +7428,9 @@ static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
 		}
 	}
 
-	/*
-	 * vendor specific setup_clocks ops may depend on clocks managed by
-	 * this standard driver hence call the vendor specific setup_clocks
-	 * after enabling the clocks managed here.
-	 */
-	if (on) {
-		ret = ufshcd_vops_setup_clocks(hba, on, POST_CHANGE);
-		if (ret)
-			return ret;
-	}
+	ret = ufshcd_vops_setup_clocks(hba, on, POST_CHANGE);
+	if (ret)
+		return ret;
 
 out:
 	if (ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
