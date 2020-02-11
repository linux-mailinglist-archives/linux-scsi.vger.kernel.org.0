Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67393158842
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Feb 2020 03:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBKCiN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Feb 2020 21:38:13 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:19969 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727747AbgBKCiM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Feb 2020 21:38:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581388692; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=f1HTEkpxUdDYbFLcYWFshQ3BL0C5vGP4FbG4ywXAapM=; b=ww/tO4wgb2ahOR2fnxvTnGKiwTBnOViCabY5g6QQI4gPZUYW2sjTOQQKSBp60kaiwh6Jieyg
 N7+uky+RV/f+tE1i41gmIkYdKfhYwJfyyJBoSfDf+KU78pZ6UXDxxQ/6OIztmpQ0tXga2/SI
 hMV7hqRIeSuQocg1G7zXHLvoAS8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42138f.7fcc910c16c0-smtp-out-n01;
 Tue, 11 Feb 2020 02:38:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5969EC447A5; Tue, 11 Feb 2020 02:38:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D1DFC433A2;
        Tue, 11 Feb 2020 02:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D1DFC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Sayali Lokhande <sayalil@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 1/7] scsi: ufs: Flush exception event before suspend
Date:   Mon, 10 Feb 2020 18:37:43 -0800
Message-Id: <1581388671-18078-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581388671-18078-1-git-send-email-cang@codeaurora.org>
References: <1581388671-18078-1-git-send-email-cang@codeaurora.org>
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
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index abd0e6b..10dbc0c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4730,8 +4730,15 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 			 * UFS device needs urgent BKOPs.
 			 */
 			if (!hba->pm_op_in_progress &&
-			    ufshcd_is_exception_event(lrbp->ucd_rsp_ptr))
-				schedule_work(&hba->eeh_work);
+			    ufshcd_is_exception_event(lrbp->ucd_rsp_ptr) &&
+			    schedule_work(&hba->eeh_work)) {
+				/*
+				 * Prevent suspend once eeh_work is scheduled
+				 * to avoid deadlock between ufshcd_suspend
+				 * and exception event handler.
+				 */
+				pm_runtime_get_noresume(hba->dev);
+			}
 			break;
 		case UPIU_TRANSACTION_REJECT_UPIU:
 			/* TODO: handle Reject UPIU Response */
@@ -5184,7 +5191,14 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 
 out:
 	ufshcd_scsi_unblock_requests(hba);
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
 
@@ -7924,6 +7938,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			goto enable_gating;
 	}
 
+	flush_work(&hba->eeh_work);
 	ret = ufshcd_link_state_transition(hba, req_link_state, 1);
 	if (ret)
 		goto set_dev_active;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
