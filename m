Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739976FD630
	for <lists+linux-scsi@lfdr.de>; Wed, 10 May 2023 07:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjEJF1Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 May 2023 01:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjEJF1V (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 May 2023 01:27:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E81FEF;
        Tue,  9 May 2023 22:27:10 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A2HR7d020674;
        Wed, 10 May 2023 05:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2eGlXlvn5UzqxcldaXw0YYLt5bMTRsK+KHOAM3hK55Y=;
 b=M31Dte0CUiCc1VEdtRH/YgXksCmY5GDg/JkWgtd2eC/ZzHKVekpJXp0KhhBJccXMKl6P
 YU1t1KMxWLAI1iHdGvG3Zma6NPvpgchKajzOHHV+l8T7VvpHRrKUxY1gtfBWsdxV/De7
 XqrwhwGQSkBUE/pY8A3YcHUq4cKlGjGzXzXgjcm+Oe2PX/hKRoHJj59Cc6yXuEZH1kjK
 lrxSLekI4he6CrCjicOtZXTIa7ouER5OAwYZNu+myoYASkw7L/t5ZTk3s/Xu8WU7VJk1
 Y8PXbLqu7tJsnvHvD96keEsYdEWm7afJ/kPPOFA05TbtKyPCksNIGhL4Y2iPbDZ4xtqD 7w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfr509h1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 05:26:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A5Qudq023106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 05:26:56 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 22:26:56 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] ufs: core: Add error handling for MCQ mode
Date:   Tue, 9 May 2023 22:24:28 -0700
Message-ID: <09428bd2ee5f9c832046142c9c6d13efebab8887.1683688693.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683688692.git.quic_nguyenb@quicinc.com>
References: <cover.1683688692.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yWJmVWtvnAU3Ev08Ury2ajigfNMxVeFT
X-Proofpoint-ORIG-GUID: yWJmVWtvnAU3Ev08Ury2ajigfNMxVeFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add support for error handling for MCQ mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 85 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5e3029ed..0c6dec67 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3148,6 +3148,16 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		err = -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
+
+		/* MCQ mode */
+		if (is_mcq_enabled(hba)) {
+			err = ufshcd_clear_cmds(hba, lrbp->task_tag);
+			if (!err)
+				hba->dev_cmd.complete = NULL;
+			return err;
+		}
+
+		/* SDB mode */
 		if (ufshcd_clear_cmds(hba, lrbp->task_tag) == 0) {
 			/* successfully cleared the command, retry if needed */
 			err = -EAGAIN;
@@ -5581,6 +5591,10 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
  */
 static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
 {
+	struct ufshcd_lrb *lrbp;
+	u32 hwq_num, utag;
+	int tag;
+
 	/* Resetting interrupt aggregation counters first and reading the
 	 * DOOR_BELL afterward allows us to handle all the completed requests.
 	 * In order to prevent other interrupts starvation the DB is read once
@@ -5599,7 +5613,22 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
 	 * Ignore the ufshcd_poll() return value and return IRQ_HANDLED since we
 	 * do not want polling to trigger spurious interrupt complaints.
 	 */
-	ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
+	if (!is_mcq_enabled(hba)) {
+		ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
+		goto out;
+	}
+
+	/* MCQ mode */
+	for (tag = 0; tag < hba->nutrs; tag++) {
+		lrbp = &hba->lrb[tag];
+		if (ufshcd_cmd_inflight(lrbp->cmd)) {
+			utag = blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->cmd));
+			hwq_num = blk_mq_unique_tag_to_hwq(utag);
+			ufshcd_poll(hba->host, hwq_num);
+		}
+	}
+
+out:
 
 	return IRQ_HANDLED;
 }
@@ -6378,18 +6407,36 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
 	bool needs_reset = false;
 	int tag, ret;
 
-	/* Clear pending transfer requests */
-	for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
-		ret = ufshcd_try_to_abort_task(hba, tag);
-		dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
-			hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
-			ret ? "failed" : "succeeded");
-		if (ret) {
-			needs_reset = true;
-			goto out;
+	if (is_mcq_enabled(hba)) {
+		struct ufshcd_lrb *lrbp;
+		int tag;
+
+		for (tag = 0; tag < hba->nutrs; tag++) {
+			lrbp = &hba->lrb[tag];
+			if (!ufshcd_cmd_inflight(lrbp->cmd))
+				continue;
+			ret = ufshcd_try_to_abort_task(hba, tag);
+			dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
+				hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
+				ret ? "failed" : "succeeded");
+			if (ret) {
+				needs_reset = true;
+				goto out;
+			}
+		}
+	} else {
+		/* Clear pending transfer requests */
+		for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
+			ret = ufshcd_try_to_abort_task(hba, tag);
+			dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
+				hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
+				ret ? "failed" : "succeeded");
+			if (ret) {
+				needs_reset = true;
+				goto out;
+			}
 		}
 	}
-
 	/* Clear pending task management requests */
 	for_each_set_bit(tag, &hba->outstanding_tasks, hba->nutmrs) {
 		if (ufshcd_clear_tm_cmd(hba, tag)) {
@@ -7321,6 +7368,8 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	unsigned long flags, pending_reqs = 0, not_cleared = 0;
 	struct Scsi_Host *host;
 	struct ufs_hba *hba;
+	struct ufs_hw_queue *hwq;
+	struct ufshcd_lrb *lrbp;
 	u32 pos, not_cleared_mask = 0;
 	int err;
 	u8 resp = 0xF, lun;
@@ -7336,6 +7385,20 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 		goto out;
 	}
 
+	if (is_mcq_enabled(hba)) {
+		for (pos = 0; pos < hba->nutrs; pos++) {
+			lrbp = &hba->lrb[pos];
+			if (ufshcd_cmd_inflight(lrbp->cmd) &&
+			    lrbp->lun == lun) {
+				ufshcd_clear_cmds(hba, pos);
+				hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
+				ufshcd_mcq_poll_cqe_lock(hba, hwq);
+			}
+		}
+		err = 0;
+		goto out;
+	}
+
 	/* clear the commands that were pending for corresponding LUN */
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	for_each_set_bit(pos, &hba->outstanding_reqs, hba->nutrs)
-- 
2.7.4

