Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4F23A181
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Aug 2020 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHCJFY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Aug 2020 05:05:24 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:21494 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgHCJFX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Aug 2020 05:05:23 -0400
IronPort-SDR: tiMR4BmNoE4dGZXEe91/ql5tjyhGGdcKzVBe6GFDh5EPp4+AcxMCmZLDPHJnWA+sOQv/ltA46z
 mU9ijqkmdMJlQJfcxSytc4TKkbX1cpn6x0No59DuvABy0CJ+EIcDljLzOIrkcvMfhgjml9fMSl
 ajgrm5HGIE0QMkK9vXIrj6WOxkgCAfyiY9pBjBzq7RDZj34UlBm2tXzcfjinD4Y5+jB4Vzkf5p
 XO9a9aETGR7DJVr6EFFR7BJ2Lnit4TMbXXnrQhbFIgsLKUTw9FOTtdAq3ZtR4U9mniBa1uo57M
 W9A=
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="47240958"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 03 Aug 2020 02:05:21 -0700
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 03 Aug 2020 02:05:20 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 0AB2A214E4; Mon,  3 Aug 2020 02:05:21 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v9 9/9] scsi: ufs: Properly release resources if a task is aborted successfully
Date:   Mon,  3 Aug 2020 02:04:44 -0700
Message-Id: <1596445485-19834-10-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596445485-19834-1-git-send-email-cang@codeaurora.org>
References: <1596445485-19834-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In current UFS task abort hook, namely ufshcd_abort(), if a task is
aborted successfully, clock scaling busy time statistics is not updated
and, most important, clk_gating.active_reqs is not decreased, which makes
clk_gating.active_reqs stay above zero forever, thus clock gating would
never happen. To fix it, instead of releasing resources "mannually", use
the existing func __ufshcd_transfer_req_compl(). This can also eliminate
racing of scsi_dma_unmap() from the real completion in IRQ handler path.

Signed-off-by: Can Guo <cang@codeaurora.org>
CC: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufshcd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d7d2758..9a48389 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6635,11 +6635,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto out;
 	}
 
-	scsi_dma_unmap(cmd);
-
 	spin_lock_irqsave(host->host_lock, flags);
-	ufshcd_outstanding_req_clear(hba, tag);
-	hba->lrb[tag].cmd = NULL;
+	__ufshcd_transfer_req_compl(hba, (1UL << tag));
 	spin_unlock_irqrestore(host->host_lock, flags);
 
 out:
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

