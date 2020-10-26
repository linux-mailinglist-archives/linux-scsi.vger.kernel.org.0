Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15040299761
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 20:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgJZTvg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 15:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgJZTve (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Oct 2020 15:51:34 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18F521655;
        Mon, 26 Oct 2020 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741894;
        bh=xTNw6+WS4QruCfRu7I59YvY2zjaDS2nJzRs7S5LxRMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QalBONmOfrWvb1o7TEOiZjNdcDoj92PpWFnGLczmkdjyLvTc9jj7DcfPzUhph67Pe
         bStdx8VAiYQSLiwcZUktbSb4DIaLGQlnFS8MPJuqITsVqPut7vLfiru+VLk652KZAp
         8wHq8K11i1xgRMxT8IwhTGaAHvhIFDI3tNlWNYkY=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH v4 5/5] scsi: ufs: fix clkgating on/off correctly
Date:   Mon, 26 Oct 2020 12:51:24 -0700
Message-Id: <20201026195124.363096-6-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026195124.363096-1-jaegeuk@kernel.org>
References: <20201026195124.363096-1-jaegeuk@kernel.org>
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

Note that, this still requires a work to deal with a potential racy condition
when user sets clkgating.delay_ms to very small value. That can cause preventing
clkgating by the check of ufshcd_any_tag_in_use() in gate_work.

Fixes: 7252a3603015 ("scsi: ufs: Avoid busy-waiting by eliminating tag conflicts")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b8a54d09e750..86c8dee01ca9 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1746,7 +1746,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended ||
 	    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
-	    ufshcd_any_tag_in_use(hba) || hba->outstanding_tasks ||
+	    hba->outstanding_tasks ||
 	    hba->active_uic_cmd || hba->uic_async_done ||
 	    hba->clk_gating.state == CLKS_OFF)
 		return;
-- 
2.29.0.rc1.297.gfa9743e501-goog

