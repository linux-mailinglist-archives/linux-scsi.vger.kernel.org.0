Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35DB63E624
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Dec 2022 01:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiLAAHR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Nov 2022 19:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiLAAFN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 30 Nov 2022 19:05:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AFE92A36;
        Wed, 30 Nov 2022 16:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669852936; x=1701388936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=K/TDgFRGKW5DhwC7pWS4O1f/elYqF2/2a8/3RnUeogY=;
  b=ciXgl2SI5A+vI6MZOc8Fc9lskIrkrvoj7RbBYgWzM5hmclc1L2HEdh4Q
   Upx/dNsj4V7eR2uiNyojs2f+lvXMZB3rIsVpYEWO0sgDz4XMc0OBiISN4
   6ny1icC1Wp09SGr21Knqzk60NL8IZc+raE/RSLT6w7J/dwfL/JJBbYdYF
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Nov 2022 16:02:15 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:02:15 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 16:02:14 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 11/16] ufs: core: Prepare ufshcd_send_command for mcq
Date:   Wed, 30 Nov 2022 15:50:43 -0800
Message-ID: <6291524ff4be9646554caf1827994c40ad95d11b.1669850856.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669850856.git.quic_asutoshd@quicinc.com>
References: <cover.1669850856.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add support to send commands using multiple submission
queues in MCQ mode.
Modify the functions that use ufshcd_send_command().

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c     |  1 +
 drivers/ufs/core/ufshcd-priv.h | 10 ++++++++++
 drivers/ufs/core/ufshcd.c      | 36 ++++++++++++++++++++++++++----------
 include/ufs/ufshcd.h           |  5 +++++
 4 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index cffec4c..0c40fe2 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -309,6 +309,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	for (i = 0; i < hba->nr_hw_queues; i++) {
 		hwq = &hba->uhq[i];
 		hwq->max_entries = hba->nutrs;
+		spin_lock_init(&hwq->sq_lock);
 	}
 
 	/* The very first HW queue serves device commands */
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 0e35cfa..d295be4 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -332,4 +332,14 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8
 	return lun == UFS_UPIU_RPMB_WLUN || (lun < dev_info->max_lu_supported);
 }
 
+static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
+{
+	u32 mask = q->max_entries - 1;
+	u32 val;
+
+	q->sq_tail_slot = (q->sq_tail_slot + 1) & mask;
+	val = q->sq_tail_slot * sizeof(struct utp_transfer_req_desc);
+	writel(val, q->mcq_sq_tail);
+}
+
 #endif /* _UFSHCD_PRIV_H_ */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 965e844..1639a97 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2182,9 +2182,11 @@ static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *
  * ufshcd_send_command - Send SCSI or device management commands
  * @hba: per adapter instance
  * @task_tag: Task tag of the command
+ * @hwq: pointer to hardware queue instance
  */
 static inline
-void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
+void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
+			 struct ufs_hw_queue *hwq)
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
 	unsigned long flags;
@@ -2198,12 +2200,24 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
 		ufshcd_start_monitor(hba, lrbp);
 
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	if (hba->vops && hba->vops->setup_xfer_req)
-		hba->vops->setup_xfer_req(hba, task_tag, !!lrbp->cmd);
-	__set_bit(task_tag, &hba->outstanding_reqs);
-	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	if (is_mcq_enabled(hba)) {
+		int utrd_size = sizeof(struct utp_transfer_req_desc);
+
+		spin_lock(&hwq->sq_lock);
+		memcpy(hwq->sqe_base_addr + (hwq->sq_tail_slot * utrd_size),
+		       lrbp->utr_descriptor_ptr, utrd_size);
+		ufshcd_inc_sq_tail(hwq);
+		spin_unlock(&hwq->sq_lock);
+	} else {
+		spin_lock_irqsave(&hba->outstanding_lock, flags);
+		if (hba->vops && hba->vops->setup_xfer_req)
+			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+						  !!lrbp->cmd);
+		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
+		ufshcd_writel(hba, 1 << lrbp->task_tag,
+			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	}
 }
 
 /**
@@ -2822,6 +2836,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	int tag = scsi_cmd_to_rq(cmd)->tag;
 	struct ufshcd_lrb *lrbp;
 	int err = 0;
+	struct ufs_hw_queue *hwq = NULL;
 
 	WARN_ONCE(tag < 0 || tag >= hba->nutrs, "Invalid tag %d\n", tag);
 
@@ -2906,7 +2921,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		goto out;
 	}
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, tag, hwq);
 
 out:
 	rcu_read_unlock();
@@ -3101,10 +3116,11 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		goto out;
 
 	hba->dev_cmd.complete = &wait;
+	hba->dev_cmd.cqe = NULL;
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
@@ -6952,7 +6968,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
-	ufshcd_send_command(hba, tag);
+	ufshcd_send_command(hba, tag, hba->dev_cmd_queue);
 	/*
 	 * ignore the returning value here - ufshcd_check_query_response is
 	 * bound to fail since dev_cmd.query and dev_cmd.type were left empty.
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ac46d36..ae20697 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -222,6 +222,7 @@ struct ufs_dev_cmd {
 	struct mutex lock;
 	struct completion *complete;
 	struct ufs_query query;
+	struct cq_entry *cqe;
 };
 
 /**
@@ -1064,6 +1065,8 @@ struct ufs_hba {
  * @cqe_dma_addr: completion queue dma address
  * @max_entries: max number of slots in this hardware queue
  * @id: hardware queue ID
+ * @sq_tp_slot: current slot to which SQ tail pointer is pointing
+ * @sq_lock: serialize submission queue access
  */
 struct ufs_hw_queue {
 	void __iomem *mcq_sq_head;
@@ -1077,6 +1080,8 @@ struct ufs_hw_queue {
 	dma_addr_t cqe_dma_addr;
 	u32 max_entries;
 	u32 id;
+	u32 sq_tail_slot;
+	spinlock_t sq_lock;
 };
 
 static inline bool is_mcq_enabled(struct ufs_hba *hba)
-- 
2.7.4

