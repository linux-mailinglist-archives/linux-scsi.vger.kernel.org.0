Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F634ED700
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 02:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfKDBgi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 3 Nov 2019 20:36:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfKDBgi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 3 Nov 2019 20:36:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 806F460FF7; Mon,  4 Nov 2019 01:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831397;
        bh=A09Hg8Gubfo22q2oteGE+XWVmGvlbeGYL8Kj6AbIyz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUGX4eBgih7IYdFJRZGAxdOwevNfqcALMufFEvPGpT6O9rBnxK8kADhEno0oIoh3A
         ykfkL5zQH1olk4dAYzq2o22dcKkK21h4z2u4H/vhVxxgbEUa6fbsfnuruZXzED7CmJ
         AQ8UlArKIIYZt1LzZ3N/eThrCm2rR5GLoFfCTwYg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D2B360FBA;
        Mon,  4 Nov 2019 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572831396;
        bh=A09Hg8Gubfo22q2oteGE+XWVmGvlbeGYL8Kj6AbIyz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEqxaCv0pvIUJeSnqfbD4ngOQBe/1NXxsLJJi8NNxUDHElaD3Y7h8aBXZ2UM9EkOh
         aLqYZqrdvnGesQg5ErHtqaF9ShR81nAhBECq2kgFk/fbRkkDnzYp9Fs2KpSh+HHvsg
         D2UgKehI056ktIiEFhc4XAdwrrugOrEwhPpXCAKU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D2B360FBA
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
Subject: [PATCH v2 6/7] scsi: ufs: Abort gating if clock on request is pending
Date:   Sun,  3 Nov 2019 17:36:01 -0800
Message-Id: <1572831362-22779-7-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572831362-22779-1-git-send-email-cang@codeaurora.org>
References: <1572831362-22779-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Asutosh Das <asutoshd@codeaurora.org>

This change attempts to abort gating of clocks if a
request to turn-on clocks is pending.
This would in turn avoid turning OFF and back ON the
clocks.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8d1b04f..7a5a904 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1610,7 +1610,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 	 * state to CLKS_ON.
 	 */
 	if (hba->clk_gating.is_suspended ||
-		(hba->clk_gating.state == REQ_CLKS_ON)) {
+		(hba->clk_gating.state != REQ_CLKS_OFF)) {
 		hba->clk_gating.state = CLKS_ON;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

