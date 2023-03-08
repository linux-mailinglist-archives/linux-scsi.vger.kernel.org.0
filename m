Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2A6AFDB6
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Mar 2023 05:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCHEEY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Mar 2023 23:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCHEEF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Mar 2023 23:04:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4BD5CC24;
        Tue,  7 Mar 2023 20:04:02 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3282bhJs031723;
        Wed, 8 Mar 2023 04:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8lLAK8Acp1MkXbdacmEzJO/cMgeF3hITkmgbQ6E2DjQ=;
 b=OsLoUvWjNbN2sgE8OURFuiLh3aDV9tZrBNcme95mZan0+I2U2VxgGOTAe+1z0eaPsEVO
 bRyL3CE51rhTwwo7nRPsYpXeli6rVTQHAaqQjDaXpyXq16+W2dM2JQCIr/KQXkw8IRE5
 ghujW7Gq6krqZr0xh/g8LyhSjqXt1RXgMHYZkM7rNYmWgNzyF1zuuCAgkvF1lUR/Iiax
 r3jywvAOafQz+IpDYZZXmR3oaJiraWF+cgHhCL7aC2W667JdFE19f2DovvxJE4JvhF6y
 3mgQ3QYXo37j4GXvKzp7VesxeZxUzfdkX7aUXsP5EGxqQreD+Y3NURhbySmSU5YSAdIY WQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fga0g07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 04:03:28 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32843RWS024009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 04:03:27 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 7 Mar 2023 20:03:27 -0800
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
Subject: [RFC PATCH v1 3/4] ufs: mcq: Add support for clean up mcq resources
Date:   Tue, 7 Mar 2023 20:01:43 -0800
Message-ID: <392b790072c2307d366ac80b7552d5f09ae25dfc.1678247309.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1678247309.git.quic_nguyenb@quicinc.com>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k75NpJsotz9JjY94a2Je6f9XPJCDa2si
X-Proofpoint-ORIG-GUID: k75NpJsotz9JjY94a2Je6f9XPJCDa2si
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=877 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/ufs/core/ufshcd.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7e52af6..408c16c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2988,7 +2988,26 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 mask)
 {
 	unsigned long flags;
+	int err, result, tag;
 
+	if (is_mcq_enabled(hba)) {
+		/*
+		 * MCQ mode. Clean up the MCQ resources similar to
+		 * what the ufshcd_utrl_clear() does for SDB mode.
+		 */
+		flags = (unsigned long)mask;
+		for_each_set_bit(tag, &flags, hba->nutrs) {
+			err = ufshcd_mcq_sq_cleanup(hba, tag, &result);
+			if (err || result) {
+				dev_err(hba->dev, "%s: failed tag=%d. err=%d, result=%d\n",
+					__func__, tag, err, result);
+				return FAILED;
+			}
+		}
+		return 0;
+	}
+
+	/* Single Doorbell Mode */
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_utrl_clear(hba, mask);
@@ -7344,6 +7363,20 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 			 */
 			dev_err(hba->dev, "%s: cmd at tag %d not pending in the device.\n",
 				__func__, tag);
+			if (is_mcq_enabled(hba)) {
+				/* mcq mode */
+				if (!lrbp->cmd) {
+					/* command completed already */
+					dev_err(hba->dev, "%s: cmd at tag=%d is cleared.\n",
+						__func__, tag);
+					goto out;
+				}
+				/* sleep for max. 200us to stabilize */
+				usleep_range(100, 200);
+				continue;
+			}
+
+			/* single door bell mode */
 			reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 			if (reg & (1 << tag)) {
 				/* sleep for max. 200us to stabilize */
@@ -7410,8 +7443,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 
 	ufshcd_hold(hba, false);
 	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	/* If command is already aborted/completed, return FAILED. */
-	if (!(test_bit(tag, &hba->outstanding_reqs))) {
+	if (!is_mcq_enabled(hba) && !(test_bit(tag, &hba->outstanding_reqs))) {
+		/* If command is already aborted/completed, return FAILED. */
 		dev_err(hba->dev,
 			"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
 			__func__, tag, hba->outstanding_reqs, reg);
@@ -7440,7 +7473,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
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

