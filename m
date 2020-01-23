Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB701461D5
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Jan 2020 07:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAWGMr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 Jan 2020 01:12:47 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:38589 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgAWGMq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 23 Jan 2020 01:12:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579759965; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9S0QIlbYmQAb+fbkT7yD3PV4Zf5YseEdwAjssYu+PQ8=; b=GbMHJcE49scyCXbcZ0BeBuAP84hCrVMn9TP5kuP9f0L2AtkQqxWhTQOyGl+Y6V3c59tOEf0V
 NCSN+8FgUY/n/VbD8J+VieRvVNlP/08dHKVhpb7nwJlXZhCRCp+AiK1HoXKkF/uIP8BUeJYK
 mS7cEs1Gcr9nfDaWdDPTzBX4MIA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e29395b.7fb056a165a8-smtp-out-n02;
 Thu, 23 Jan 2020 06:12:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6427EC447B1; Thu, 23 Jan 2020 06:12:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E777C447A5;
        Thu, 23 Jan 2020 06:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E777C447A5
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
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/8] scsi: ufs: Flush exception event before suspend
Date:   Wed, 22 Jan 2020 22:12:18 -0800
Message-Id: <1579759946-5448-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579759946-5448-1-git-send-email-cang@codeaurora.org>
References: <1579759946-5448-1-git-send-email-cang@codeaurora.org>
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
