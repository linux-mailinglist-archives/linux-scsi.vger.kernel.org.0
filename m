Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917792B5A0A
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 08:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgKQHEk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Nov 2020 02:04:40 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:26986 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKQHEk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Nov 2020 02:04:40 -0500
IronPort-SDR: DH8PTV49Co+O8YM5bEM+C47FWbs58QyJqIqeqXBIpcrJXBARY7GoNHkSrBNwquk+8/BdFqxf13
 EJUQEEBLXTGkA2r2IH/JUEZ0lUYYtzzQu4KjnEuhohwijysQk6hitOdkVlFyggF37zboZFTxCx
 MLLWtfvVHiTclSpDduNdKzebn3zNgoKg2+yRGDT50dQLyou0ONjkjLPs4f7IU8AB7cgiwXp3iu
 bg25XlblB3iAJyhSJW0MjolHFvU1CNUXQYkklhBrqigTwSCKepwKLkco1Ujkoribh1cFmN+hDl
 3Zs=
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="47474919"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 16 Nov 2020 23:04:39 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg04-sd.qualcomm.com with ESMTP; 16 Nov 2020 23:04:39 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 411E52181A; Mon, 16 Nov 2020 23:04:39 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/3] scsi: ufs: Print host regs in IRQ handler when AH8 error happens
Date:   Mon, 16 Nov 2020 23:04:19 -0800
Message-Id: <1605596660-2987-4-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605596660-2987-1-git-send-email-cang@codeaurora.org>
References: <1605596660-2987-1-git-send-email-cang@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When AH8 error happens, all the regs and states are dumped in err handler.
Sometime we need to look into host regs right after AH8 error happens,
which is before leaving the IRQ handler.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index cd7394e..a7857f6 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6057,7 +6057,8 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
 		hba->saved_uic_err |= hba->uic_error;
 
 		/* dump controller state before resetting */
-		if ((hba->saved_err & (INT_FATAL_ERRORS)) ||
+		if ((hba->saved_err &
+		     (INT_FATAL_ERRORS | UFSHCD_UIC_HIBERN8_MASK)) ||
 		    (hba->saved_uic_err &&
 		     (hba->saved_uic_err != UFSHCD_UIC_PA_GENERIC_ERROR))) {
 			dev_err(hba->dev, "%s: saved_err 0x%x saved_uic_err 0x%x\n",
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

