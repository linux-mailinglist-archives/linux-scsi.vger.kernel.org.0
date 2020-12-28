Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE32E36E7
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Dec 2020 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgL1MF0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 28 Dec 2020 07:05:26 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:12867 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgL1MFY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 28 Dec 2020 07:05:24 -0500
IronPort-SDR: 0k5lsHhbcHw79ZwaIYH96GoUtAwxRqbuVSlzHzYawAZE+1cuIk0sYM0FblPPBctdFdv9SwJX0a
 I1kYsgWEzZ0y340UEemolZ+FgGbT8Dt7JSZPfWFHSha1gNlONeIepUf6YGdDWzT9aSPWed+qfC
 LPuqTlddjYiWf05w0QK6xTOd64dpXKas+WOD4SsGTqPHKRWY8WGlZGAldqdNjIOYJ5cbp1oggV
 hCzcPUBkb5EtcQ2aLRfs602fCMTd/NKAexzbKDpfrm5qeiPA797PPnSxB+sVb68/vz9btuSkC5
 /ps=
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="29452600"
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by labrats.qualcomm.com with ESMTP; 28 Dec 2020 04:04:44 -0800
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg05-sd.qualcomm.com with ESMTP; 28 Dec 2020 04:04:43 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id EC2AC2188E; Mon, 28 Dec 2020 04:04:43 -0800 (PST)
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
Subject: [PATCH] scsi: ufs: Correct the lun used in eh_device_reset_handler() callback
Date:   Mon, 28 Dec 2020 04:04:36 -0800
Message-Id: <1609157080-26283-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Users can initiate resets to specific SCSI device/target/host through
IOCTL. When this happens, the SCSI cmd passed to eh_device/target/host
_reset_handler() callbacks is initialized with a request whose tag is -1.
So, in this case, it is not right for eh_device_reset_handler() callback
to count on the lun get from hba->lrb[-1]. Fix it by getting lun from the
SCSI device associated with the SCSI cmd.

Signed-off-by: Can Guo <cang@codeaurora.org>

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 98093a5..d577cda 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6604,19 +6604,16 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 {
 	struct Scsi_Host *host;
 	struct ufs_hba *hba;
-	unsigned int tag;
 	u32 pos;
 	int err;
-	u8 resp = 0xF;
-	struct ufshcd_lrb *lrbp;
+	u8 resp = 0xF, lun;
 	unsigned long flags;
 
 	host = cmd->device->host;
 	hba = shost_priv(host);
-	tag = cmd->request->tag;
 
-	lrbp = &hba->lrb[tag];
-	err = ufshcd_issue_tm_cmd(hba, lrbp->lun, 0, UFS_LOGICAL_RESET, &resp);
+	lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
+	err = ufshcd_issue_tm_cmd(hba, lun, 0, UFS_LOGICAL_RESET, &resp);
 	if (err || resp != UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
 		if (!err)
 			err = resp;
@@ -6625,7 +6622,7 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 
 	/* clear the commands that were pending for corresponding LUN */
 	for_each_set_bit(pos, &hba->outstanding_reqs, hba->nutrs) {
-		if (hba->lrb[pos].lun == lrbp->lun) {
+		if (hba->lrb[pos].lun == lun) {
 			err = ufshcd_clear_cmd(hba, pos);
 			if (err)
 				break;
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

