Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E66FD629
	for <lists+linux-scsi@lfdr.de>; Wed, 10 May 2023 07:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjEJF0z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 May 2023 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjEJF0v (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 May 2023 01:26:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAE61FEA;
        Tue,  9 May 2023 22:26:47 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A4krAd006126;
        Wed, 10 May 2023 05:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=K4bYyppKwoa4ZdL27Uewmba3TVmcf4ezt2saUpRoh4w=;
 b=h86iSffUlnFP7ULEJwuAVAe+V3LTLuYXn73uoXSM+8tGrEy6bqpRTnoLWTD3s+tp+6hS
 ug7bHB3umY3URBNoBFwXp+tx7g7ASPg5ASlY5iN8hIPMfUU7iUisUAjFDtwZiojlSLAx
 v+uWB82AVZ3D/c6NLHhuQqNCznzvCoPA3PFVSW6EcMR8DctGZl0AyV16gNt8fvtC2ep0
 boJpbUetzYp3tIft94NoR1L+b1cd0vImdLOcXb1pO6n7i1Tq96FEi83G7YuJ8XvVwSs4
 hyZEYXxNDlZZ4sd9ciPFFtesmZbjBD2zUvblPJ2DyUB0cReFbcN5XGyDrn1VxK2V8upV og== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrvm1bv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 05:26:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A5QDes025207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 05:26:13 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 22:26:12 -0700
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] ufs: mcq: Add support for clean up mcq resources
Date:   Tue, 9 May 2023 22:24:25 -0700
Message-ID: <d8de00bab403dc725cf638750083d5e5f1449eec.1683688693.git.quic_nguyenb@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mpzDUf4beP644zaPx7tUw5LSptPKob0d
X-Proofpoint-GUID: mpzDUf4beP644zaPx7tUw5LSptPKob0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update ufshcd_clear_cmds() to clean up the mcq resources similar
to the function ufshcd_utrl_clear() does for sdb mode.

Update ufshcd_try_to_abort_task() to support mcq mode so that
this function can be invoked in either mcq or sdb mode.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufshcd-priv.h |  2 +-
 drivers/ufs/core/ufshcd.c      | 56 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index f8beabb..7d2104d 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -77,7 +77,7 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					   struct request *req);
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
-
+bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd);
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result);
 
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 07a6974..834b13ae 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3005,6 +3005,26 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 }
 
 /*
+ * Check with the block layer if the command is inflight
+ * @cmd: command to check.
+ *
+ * Returns true if command is inflight; false if not.
+ */
+bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
+{
+	struct request *rq;
+
+	if (!cmd)
+		return false;
+
+	rq = scsi_cmd_to_rq(cmd);
+	if (!rq || !blk_mq_request_started(rq))
+		return false;
+
+	return true;
+}
+
+/*
  * Clear the pending command in the controller and wait until
  * the controller confirms that the command has been cleared.
  * @hba: per adapter instance
@@ -3013,8 +3033,23 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 task_tag)
 {
 	unsigned long flags;
+	int err, result = FAILED;
 	u32 mask = 1U << task_tag;
 
+	if (is_mcq_enabled(hba)) {
+		/*
+		 * MCQ mode. Clean up the MCQ resources similar to
+		 * what the ufshcd_utrl_clear() does for SDB mode.
+		 */
+		err = ufshcd_mcq_sq_cleanup(hba, task_tag, &result);
+		if (err || result) {
+			dev_err(hba->dev, "%s: failed tag=%d. err=%d, result=%d\n",
+				__func__, task_tag, err, result);
+			return FAILED;
+		}
+		return 0;
+	}
+
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_utrl_clear(hba, mask);
@@ -7384,6 +7419,20 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 			 */
 			dev_err(hba->dev, "%s: cmd at tag %d not pending in the device.\n",
 				__func__, tag);
+			if (is_mcq_enabled(hba)) {
+				/* MCQ mode */
+				if (ufshcd_cmd_inflight(lrbp->cmd)) {
+					/* sleep for max. 200us same delay as in SDB mode */
+					usleep_range(100, 200);
+					continue;
+				}
+				/* command completed already */
+				dev_err(hba->dev, "%s: cmd at tag=%d is cleared.\n",
+					__func__, tag);
+				goto out;
+			}
+
+			/* Single Doorbell Mode */
 			reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 			if (reg & (1 << tag)) {
 				/* sleep for max. 200us to stabilize */
@@ -7450,8 +7499,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 
 	ufshcd_hold(hba, false);
 	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	/* If command is already aborted/completed, return FAILED. */
-	if (!(test_bit(tag, &hba->outstanding_reqs))) {
+	if (!is_mcq_enabled(hba) && !test_bit(tag, &hba->outstanding_reqs)) {
+		/* If command is already aborted/completed, return FAILED. */
 		dev_err(hba->dev,
 			"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
 			__func__, tag, hba->outstanding_reqs, reg);
@@ -7480,7 +7529,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	}
 	hba->req_abort_count++;
 
-	if (!(reg & (1 << tag))) {
+	if (!is_mcq_enabled(hba) && !(reg & (1 << tag))) {
+		/* only execute this code in single doorbell mode */
 		dev_err(hba->dev,
 		"%s: cmd was completed, but without a notifying intr, tag = %d",
 		__func__, tag);
-- 
2.7.4

