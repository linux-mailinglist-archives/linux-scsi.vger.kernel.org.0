Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E205F297E
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Nov 2019 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfKGInL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Nov 2019 03:43:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfKGInJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Nov 2019 03:43:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9916A60B12; Thu,  7 Nov 2019 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573116188;
        bh=rNVWgNXpCmjzKl7+DgyZaXwpqUvs9j2dpx4wlh2Z2MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFshVw575HfgLXUismyqqMfQjI9opEjoXB4FABby6JnujSFmJoXIsZdauSRArdyiB
         l8y3pVABGYqQcwJ7gdfGFa4N4FGKz0x6B61YNcQ/69yePiQPdU/XOmXzG6/wjnRTRN
         fS6LLaiKMfZ0pzGurQK/56cC1XJ0/+zb7IDGUg68=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0940E60AD7;
        Thu,  7 Nov 2019 08:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573116186;
        bh=rNVWgNXpCmjzKl7+DgyZaXwpqUvs9j2dpx4wlh2Z2MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFubnSHn/1hgvH8iYtRTUnr3NHcXy0uPFQwHOf6Z3SVXlbmsrOU1nY4ay+aGoy2FU
         gM0CG7rSXtizbecUB4M4BhBbATn70Z5WCcS06ZjwCKwCb62oFfqNhaUwv8PImZyig2
         FIcmAsC3k85smovWKFGFe3fUHMcEyWnnr1zkKup0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0940E60AD7
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
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 6/6] scsi: ufs: Fix ufshcd_hold() caused scheduling while atomic
Date:   Thu,  7 Nov 2019 00:42:13 -0800
Message-Id: <1573116140-22408-7-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573116140-22408-1-git-send-email-cang@codeaurora.org>
References: <1573116140-22408-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The aysnc version of ufshcd_hold(async == true), which is only called
in queuecommand path as for now, is expected to work in atomic context,
thus it should not sleep or schedule out. When it runs into the condition
that clocks are ON but link is still in hibern8 state, it should bail out
without flushing the clock ungate work.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9cf5da3..5e112ae8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1545,6 +1545,11 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 */
 		if (ufshcd_can_hibern8_during_gating(hba) &&
 		    ufshcd_is_link_hibern8(hba)) {
+			if (async) {
+				rc = -EAGAIN;
+				hba->clk_gating.active_reqs--;
+				break;
+			}
 			spin_unlock_irqrestore(hba->host->host_lock, flags);
 			flush_work(&hba->clk_gating.ungate_work);
 			spin_lock_irqsave(hba->host->host_lock, flags);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

