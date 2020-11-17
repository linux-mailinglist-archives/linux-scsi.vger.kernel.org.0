Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0E2B6AE4
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 18:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgKQQ6r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Nov 2020 11:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgKQQ6r (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Nov 2020 11:58:47 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849F124654;
        Tue, 17 Nov 2020 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605632326;
        bh=/Y3fTCys3yzpm1PjIxGpKZqD03qS2AZ/fgmi/1y720w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xL4AkxbT0Fr8LU6PueJPit6Zh255FDOV8oaZo+q9fL9yjNemadmgJk6mDDK0Mw3Fl
         T1rFpMm1Wq6aYzbitnUw6MC3fsDy1skpJIque8Ok+hCaR+IsRsxTyKKCwPdq6tufRs
         LIpEw/uIqPQE6EhKKmgL7jVzT119C5XLbo6NriFA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, Jaegeuk Kim <jaegeuk@google.com>
Subject: [PATCH v5 2/7] scsi: ufs: atomic update for clkgating_enable
Date:   Tue, 17 Nov 2020 08:58:34 -0800
Message-Id: <20201117165839.1643377-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117165839.1643377-1-jaegeuk@kernel.org>
References: <20201117165839.1643377-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@google.com>

When giving a stress test which enables/disables clkgating, we hit device
timeout sometimes. This patch avoids subtle racy condition to address it.

Note that, this requires a patch to address the device stuck by REQ_CLKS_OFF in
__ufshcd_release().

The fix is "scsi: ufs: avoid to call REQ_CLKS_OFF to CLKS_OFF".

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 drivers/scsi/ufs/ufshcd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index cc8d5f0c3fdc..6c9269bffcbd 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1808,19 +1808,19 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 		return -EINVAL;
 
 	value = !!value;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (value == hba->clk_gating.is_enabled)
 		goto out;
 
-	if (value) {
-		ufshcd_release(hba);
-	} else {
-		spin_lock_irqsave(hba->host->host_lock, flags);
+	if (value)
+		__ufshcd_release(hba);
+	else
 		hba->clk_gating.active_reqs++;
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-	}
 
 	hba->clk_gating.is_enabled = value;
 out:
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	return count;
 }
 
-- 
2.29.2.299.gdc1121823c-goog

