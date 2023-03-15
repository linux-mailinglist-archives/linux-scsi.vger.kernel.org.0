Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E16BAA5F
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Mar 2023 09:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCOIEI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Mar 2023 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCOIEG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Mar 2023 04:04:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8FAC14B;
        Wed, 15 Mar 2023 01:04:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F1vN4U010611;
        Wed, 15 Mar 2023 07:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=EBmFRKF3cukwatNtZYWHrNuIzVocFYfwaITHZFB934c=;
 b=k2Y2MzojHTuT4MrbjW/FDCMSy8ohTF6GhfxW0+0sB8a+VSZ7nckFnRFkbzV/yAf90YdT
 WTsPHpl+cXQYZE4/cnnavBbIWPqs3I8DX6kYOsEPA1dFWC+Ee3lUg2qTR/azG/NazEg+
 5zHTWoFrprLAOAtt/WO5l7HOm4g7RgNjCxbVsL9X8uORz/1gkjL+iX3O3FheXMgGzIyN
 2yQkb9hgfKGy57JP6dz7NSP0L03A71YFm7z8RcSC3Vt7aLjFbWyKZsgsErRQWe/G+gSk
 OM14xBGp1n62xMLadi9sphDBGR8VRnMWqr4swUl1cCQMmUr1xNRndjze4LrwZl/EJnUr 6A== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2by8uqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:32:17 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32F7WFNJ008232;
        Wed, 15 Mar 2023 07:32:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqmaw7q-1;
        Wed, 15 Mar 2023 07:32:15 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32F7WF03008225;
        Wed, 15 Mar 2023 07:32:15 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 32F7WEaY008220;
        Wed, 15 Mar 2023 07:32:15 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id DB8B8452A; Wed, 15 Mar 2023 15:32:13 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] scsi: ufs: core: print trs for pending requests in MCQ mode
Date:   Wed, 15 Mar 2023 15:31:52 +0800
Message-Id: <1678865517-43139-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HqVpwE1lbo2FWOfQd2K_lSWj7lx9RjW8
X-Proofpoint-GUID: HqVpwE1lbo2FWOfQd2K_lSWj7lx9RjW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_03,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150063
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We don't have outstanding_reqs bitmap in MCQ mode. And in consideration
of the queue depth may increase beyond 64 in the future, we reworked
ufshcd_print_trs() to get rid of usage of bitmap so that we can print
trs for pending requests in both SDB and MCQ mode.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>

---
Changes to v2:
- Removed null pointer check.

Changes to v1:
- Use blk_mq_tagset_busy_iter() to iterate over pending requests.
---
 drivers/ufs/core/ufshcd.c | 96 ++++++++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 39 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1d58cb2..9b36d69 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -542,48 +542,66 @@ static void ufshcd_print_evt_hist(struct ufs_hba *hba)
 }
 
 static
-void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
+void ufshcd_print_tr(struct ufs_hba *hba, int tag, bool pr_prdt)
 {
 	const struct ufshcd_lrb *lrbp;
 	int prdt_length;
-	int tag;
 
-	for_each_set_bit(tag, &bitmap, hba->nutrs) {
-		lrbp = &hba->lrb[tag];
+	lrbp = &hba->lrb[tag];
 
-		dev_err(hba->dev, "UPIU[%d] - issue time %lld us\n",
-				tag, div_u64(lrbp->issue_time_stamp_local_clock, 1000));
-		dev_err(hba->dev, "UPIU[%d] - complete time %lld us\n",
-				tag, div_u64(lrbp->compl_time_stamp_local_clock, 1000));
-		dev_err(hba->dev,
-			"UPIU[%d] - Transfer Request Descriptor phys@0x%llx\n",
-			tag, (u64)lrbp->utrd_dma_addr);
-
-		ufshcd_hex_dump("UPIU TRD: ", lrbp->utr_descriptor_ptr,
-				sizeof(struct utp_transfer_req_desc));
-		dev_err(hba->dev, "UPIU[%d] - Request UPIU phys@0x%llx\n", tag,
-			(u64)lrbp->ucd_req_dma_addr);
-		ufshcd_hex_dump("UPIU REQ: ", lrbp->ucd_req_ptr,
-				sizeof(struct utp_upiu_req));
-		dev_err(hba->dev, "UPIU[%d] - Response UPIU phys@0x%llx\n", tag,
-			(u64)lrbp->ucd_rsp_dma_addr);
-		ufshcd_hex_dump("UPIU RSP: ", lrbp->ucd_rsp_ptr,
-				sizeof(struct utp_upiu_rsp));
-
-		prdt_length = le16_to_cpu(
-			lrbp->utr_descriptor_ptr->prd_table_length);
-		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
-			prdt_length /= ufshcd_sg_entry_size(hba);
+	dev_err(hba->dev, "UPIU[%d] - issue time %lld us\n",
+			tag, div_u64(lrbp->issue_time_stamp_local_clock, 1000));
+	dev_err(hba->dev, "UPIU[%d] - complete time %lld us\n",
+			tag, div_u64(lrbp->compl_time_stamp_local_clock, 1000));
+	dev_err(hba->dev,
+		"UPIU[%d] - Transfer Request Descriptor phys@0x%llx\n",
+		tag, (u64)lrbp->utrd_dma_addr);
+
+	ufshcd_hex_dump("UPIU TRD: ", lrbp->utr_descriptor_ptr,
+			sizeof(struct utp_transfer_req_desc));
+	dev_err(hba->dev, "UPIU[%d] - Request UPIU phys@0x%llx\n", tag,
+		(u64)lrbp->ucd_req_dma_addr);
+	ufshcd_hex_dump("UPIU REQ: ", lrbp->ucd_req_ptr,
+			sizeof(struct utp_upiu_req));
+	dev_err(hba->dev, "UPIU[%d] - Response UPIU phys@0x%llx\n", tag,
+		(u64)lrbp->ucd_rsp_dma_addr);
+	ufshcd_hex_dump("UPIU RSP: ", lrbp->ucd_rsp_ptr,
+			sizeof(struct utp_upiu_rsp));
+
+	prdt_length = le16_to_cpu(
+		lrbp->utr_descriptor_ptr->prd_table_length);
+	if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
+		prdt_length /= ufshcd_sg_entry_size(hba);
 
-		dev_err(hba->dev,
-			"UPIU[%d] - PRDT - %d entries  phys@0x%llx\n",
-			tag, prdt_length,
-			(u64)lrbp->ucd_prdt_dma_addr);
+	dev_err(hba->dev,
+		"UPIU[%d] - PRDT - %d entries  phys@0x%llx\n",
+		tag, prdt_length,
+		(u64)lrbp->ucd_prdt_dma_addr);
 
-		if (pr_prdt)
-			ufshcd_hex_dump("UPIU PRDT: ", lrbp->ucd_prdt_ptr,
-				ufshcd_sg_entry_size(hba) * prdt_length);
-	}
+	if (pr_prdt)
+		ufshcd_hex_dump("UPIU PRDT: ", lrbp->ucd_prdt_ptr,
+			ufshcd_sg_entry_size(hba) * prdt_length);
+}
+
+static bool ufshcd_print_tr_iter(struct request *req, void *priv)
+{
+	struct scsi_device *sdev = req->q->queuedata;
+	struct Scsi_Host *shost = sdev->host;
+	struct ufs_hba *hba = shost_priv(shost);
+
+	ufshcd_print_tr(hba, req->tag, *(bool *)priv);
+
+	return true;
+}
+
+/**
+ * ufshcd_print_trs_all - print trs for all started requests.
+ * @hba: per-adapter instance.
+ * @pr_prdt: need to print prdt or not.
+ */
+static void ufshcd_print_trs_all(struct ufs_hba *hba, bool pr_prdt)
+{
+	blk_mq_tagset_busy_iter(&hba->host->tag_set, ufshcd_print_tr_iter, &pr_prdt);
 }
 
 static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
@@ -5332,7 +5350,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
 
 	if ((host_byte(result) != DID_OK) &&
 	    (host_byte(result) != DID_REQUEUE) && !hba->silence_err_logs)
-		ufshcd_print_trs(hba, 1 << lrbp->task_tag, true);
+		ufshcd_print_tr(hba, lrbp->task_tag, true);
 	return result;
 }
 
@@ -6406,7 +6424,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 		ufshcd_print_pwr_info(hba);
 		ufshcd_print_evt_hist(hba);
 		ufshcd_print_tmrs(hba, hba->outstanding_tasks);
-		ufshcd_print_trs(hba, hba->outstanding_reqs, pr_prdt);
+		ufshcd_print_trs_all(hba, pr_prdt);
 		spin_lock_irqsave(hba->host->host_lock, flags);
 	}
 
@@ -7435,9 +7453,9 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		ufshcd_print_evt_hist(hba);
 		ufshcd_print_host_state(hba);
 		ufshcd_print_pwr_info(hba);
-		ufshcd_print_trs(hba, 1 << tag, true);
+		ufshcd_print_tr(hba, tag, true);
 	} else {
-		ufshcd_print_trs(hba, 1 << tag, false);
+		ufshcd_print_tr(hba, tag, false);
 	}
 	hba->req_abort_count++;
 
-- 
2.7.4

