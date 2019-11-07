Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF933F2B37
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Nov 2019 10:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfKGJsa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Nov 2019 04:48:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGJs3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Nov 2019 04:48:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97CDA60A0A; Thu,  7 Nov 2019 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573120107;
        bh=FtDInhzlNbMYnaah34JKXnQVyTO/o1xFZ/slgp6EYrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtTBOOGC3OZ7E99/+3B2moDdUEDx2rKHd3Givhb/dGsdZW9IGWkgzVMUMGKd92K3h
         Bryny6LkTr30RE7OGY4FmxoL5fDwoh6OKgRrMl1IWSx7mZX/ixFibXTksU1VcQw6Ch
         llVAbldr+tohfNZ/j7dZ0nY9+FoFI1VStMF/IYDQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04697602E0;
        Thu,  7 Nov 2019 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573120103;
        bh=FtDInhzlNbMYnaah34JKXnQVyTO/o1xFZ/slgp6EYrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CoHkD6WFOFIoWG8COx/lnsD0p8o68PmgRbi32LIt6q2A7Vz+XLs/+IYaxLnpCXYRo
         oVAEdIXfF6FI2nWq6rYxJM7O6pZEHb/fJG0Pm/haKR0ToCCuE6ooZtY7jLkxQS9WyT
         mHD1ggpmvI4gbh8Hbd4BbIro5ZTQlKjy1zB5y0xY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04697602E0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Sayali Lokhande <sayalil@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] scsi: ufs: Flush exception event before suspend
Date:   Thu,  7 Nov 2019 01:47:52 -0800
Message-Id: <1573120078-15547-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573120078-15547-1-git-send-email-cang@codeaurora.org>
References: <1573120078-15547-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Sayali Lokhande <sayalil@codeaurora.org>

Exception event can be raised by the device when system
suspend is in progress. This will result in unclocked
register access in exception event handler as clocks will
be turned off during suspend. This change makes sure to flush
exception event handler work in suspend before disabling
clocks to avoid unclocked register access issue.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1201578..c2de29f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4760,8 +4760,15 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 			 * UFS device needs urgent BKOPs.
 			 */
 			if (!hba->pm_op_in_progress &&
-			    ufshcd_is_exception_event(lrbp->ucd_rsp_ptr))
-				schedule_work(&hba->eeh_work);
+			    ufshcd_is_exception_event(lrbp->ucd_rsp_ptr)) {
+				/*
+				 * Prevent suspend once eeh_work is scheduled
+				 * to avoid deadlock between ufshcd_suspend
+				 * and exception event handler.
+				 */
+				if (schedule_work(&hba->eeh_work))
+					pm_runtime_get_noresume(hba->dev);
+			}
 			break;
 		case UPIU_TRANSACTION_REJECT_UPIU:
 			/* TODO: handle Reject UPIU Response */
@@ -5215,7 +5222,14 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 
 out:
 	scsi_unblock_requests(hba->host);
-	pm_runtime_put_sync(hba->dev);
+	/*
+	 * pm_runtime_get_noresume is called while scheduling
+	 * eeh_work to avoid suspend racing with exception work.
+	 * Hence decrement usage counter using pm_runtime_put_noidle
+	 * to allow suspend on completion of exception event handler.
+	 */
+	pm_runtime_put_noidle(hba->dev);
+	pm_runtime_put(hba->dev);
 	return;
 }
 
@@ -7901,6 +7915,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			goto enable_gating;
 	}
 
+	flush_work(&hba->eeh_work);
 	ret = ufshcd_link_state_transition(hba, req_link_state, 1);
 	if (ret)
 		goto set_dev_active;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

