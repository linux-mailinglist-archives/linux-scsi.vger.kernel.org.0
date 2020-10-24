Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD6297D0C
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Oct 2020 17:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760519AbgJXPHA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 24 Oct 2020 11:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760493AbgJXPGx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 24 Oct 2020 11:06:53 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF362463C;
        Sat, 24 Oct 2020 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603552013;
        bh=jKe58VCHcddM1dYk7D3BlWfw1IskslkyIMAiX99iZDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVqFVvHDaGRXrmbzkdqwSE47wQ2yT2qWQ8WbaBW6Pk5lRJ+YWBiv50cq4UdsV/Ysz
         H6Z/UiJLJ2Wkj8f4azyT0pcoCZJJhmN+84e/u/1FZZf6mbA/4otHNfI+sklc5iOjM7
         iPenAGfNW741XNkNb8mXNeqFhMaa4KTPWyM1Bq9U=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 5/5] scsi: ufs: fix clkgating on/off correctly
Date:   Sat, 24 Oct 2020 08:06:46 -0700
Message-Id: <20201024150646.1790529-6-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201024150646.1790529-1-jaegeuk@kernel.org>
References: <20201024150646.1790529-1-jaegeuk@kernel.org>
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c94610cbecae..38043c6b8d5f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1746,7 +1746,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended ||
 	    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
-	    ufshcd_any_tag_in_use(hba) || hba->outstanding_tasks ||
+	    hba->outstanding_tasks ||
 	    hba->active_uic_cmd || hba->uic_async_done)
 		return;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

