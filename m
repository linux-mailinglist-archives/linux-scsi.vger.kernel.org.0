Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3819E28FDFC
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Oct 2020 08:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbgJPGDE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Oct 2020 02:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730699AbgJPGDE (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 16 Oct 2020 02:03:04 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF307207C4;
        Fri, 16 Oct 2020 06:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602828184;
        bh=OU66uSLTVdDEsvXAQTU5DJ60ObUUefp/DVMyIGfoE3E=;
        h=From:To:Cc:Subject:Date:From;
        b=SlUKJwUGhRSfwWh17+WD9YoLpK37ohRCW0JUogPSvIuI3tc545c1BQEo0Im3a+qcH
         NHWLkYx8WXXFmXrS/0yhfD01BSGeynwtKPz/V1kX+t12LAHyGIZIb+v6c+s/xNkJUC
         1RunAAzoAmJCFot+WW9XGKnY7MUWd83y2tRJbXCo=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH] scsi: ufs: fix no clkgating due to tag being alive
Date:   Thu, 15 Oct 2020 23:02:59 -0700
Message-Id: <20201016060259.390029-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The below call stack prevents clk_gating at every IO completion.
We can remove the condition, ufshcd_any_tag_in_use(), since clkgating_work
will check it again.

ufshcd_complete_requests(struct ufs_hba *hba)
  ufshcd_transfer_req_compl()
    __ufshcd_transfer_req_compl()
      __ufshcd_release(hba)
        if (ufshcd_any_tag_in_use() == 1)
           return;
  ufshcd_tmc_handler(hba);
    blk_mq_tagset_busy_iter();

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Can Guo <cang@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1d157ff58d81..22fecb9a4ec2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1727,7 +1727,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended
 		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| ufshcd_any_tag_in_use(hba) || hba->outstanding_tasks
+		|| hba->outstanding_tasks
 		|| hba->active_uic_cmd || hba->uic_async_done
 		|| ufshcd_eh_in_progress(hba))
 		return;
-- 
2.29.0.rc1.297.gfa9743e501-goog

