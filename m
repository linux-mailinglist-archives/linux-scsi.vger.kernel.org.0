Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77E34F81B
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Mar 2021 06:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhCaEur (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 31 Mar 2021 00:50:47 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:51991 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhCaEul (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 31 Mar 2021 00:50:41 -0400
IronPort-SDR: PfZ6ebAWMII3s2EChd/xHkbGjR9QNpOlR0o+gHyV0kyK9mUsAeRc5a+VBngGi6B+Eq+mIhwFNy
 eYbZII1VCL8Lquc4whrHWAIXWM+QQqiSee+yrH/cA4Cl9OGddDP6P8UbjH3hIRY8+XON931xum
 l6QgJ/Z6rpwlta9cx03I1+2gIVr34zgBdJpKIqxpWDDwf1fP8R+/A65kOUvSz3JxBfwE4s/Z9Z
 JOpt/yK69U7sLI/X4t0TF4FVUTy+Wsf2lISk9cAd1vsQuPSOij1WEJJ1NqJ8Fk3lUqCzO2Cmf9
 n/E=
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="29735581"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 30 Mar 2021 21:50:40 -0700
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 30 Mar 2021 21:50:40 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 2F22F21093; Tue, 30 Mar 2021 21:50:40 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] scsi: ufs: Fix task management request completion timeout
Date:   Tue, 30 Mar 2021 21:50:34 -0700
Message-Id: <1617166236-39908-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617166236-39908-1-git-send-email-cang@codeaurora.org>
References: <1617166236-39908-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

ufshcd_tmc_handler() calls blk_mq_tagset_busy_iter(fn = ufshcd_compl_tm()),
but since blk_mq_tagset_busy_iter() only iterates over all reserved tags
and requests which are not in IDLE state, ufshcd_compl_tm() never gets a
chance to run. Thus, TMR always ends up with completion timeout. Fix it by
calling blk_mq_start_request() in  __ufshcd_issue_tm_cmd().

Fixes: 69a6c269c097 ("scsi: ufs: Use blk_{get,put}_request() to allocate and free TMFs")

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b49555fa..d4f8cb2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6464,6 +6464,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 
 	spin_lock_irqsave(host->host_lock, flags);
 	task_tag = hba->nutrs + free_slot;
+	blk_mq_start_request(req);
 
 	treq->req_header.dword_0 |= cpu_to_be32(task_tag);
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

