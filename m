Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95045F5E3A
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Oct 2022 03:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJFBHI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Oct 2022 21:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJFBG4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Oct 2022 21:06:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D587F71705;
        Wed,  5 Oct 2022 18:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665018414; x=1696554414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uhunrmKWqO1oYTm1YBXeITcRh6Ge8bkGJ1TRtb0IJl0=;
  b=NLklpB9CQvsFE/quZYIsKCr1MRYvZ1Mpp8jxEXhkUO3FTGunh1x2ZC/l
   4H8aBtx53KBFqVq+K2sRduU1cwB2K7SvxMzHiPjMYDdZX+AsuXvalqLyW
   x+Z7HUKr3DO3AIEmDSZ5WEBnJnDAZAdVwEtaxOJuEPv0bEdnGGnZNq88p
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Oct 2022 18:06:54 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 18:06:54 -0700
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 18:06:53 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_bhaskarv@quicinc.com>,
        <quic_richardp@quicinc.com>, <linux-scsi@vger.kernel.org>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>
Subject: [PATCH v2 14/17] ufs: mcq: Add completion support of a cqe
Date:   Wed, 5 Oct 2022 18:06:13 -0700
Message-ID: <799f3f56cbb214d67d14a5c0a021e05c759511c2.1665017636.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1665017636.git.quic_asutoshd@quicinc.com>
References: <cover.1665017636.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add support for completing requests from Completion Queue.
Some HC support vendor specific registers that provide a
bit-map of all CQ's which have at least one completed CQE.
Add this support.
The MCQ specification doesn't provide the Task Tag or its
equivalent in the Completion Queue Entry.
So use an indirect method to find the Task Tag from the
Completion Queue Entry.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 55 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h | 43 +++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c      | 37 ++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c    | 16 ++++++++++++
 drivers/ufs/host/ufs-qcom.h    |  4 +++
 include/ufs/ufshcd.h           |  7 ++++++
 include/ufs/ufshci.h           |  3 +++
 7 files changed, 165 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index cd668fa..1ae398e 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -28,6 +28,7 @@
 	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
 #define MCQ_QCFG_SIZE	0x40
 #define MCQ_ENTRY_SIZE_IN_DWORD	8
+#define CQE_UCD_BA GENMASK(63, 7)
 
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
 {
@@ -321,6 +322,60 @@ static void __iomem *mcq_opr_base(struct ufs_hba *hba,
 	return opr->base + opr->stride * i;
 }
 
+u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
+{
+	return readl(mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
+}
+
+void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
+{
+	writel(val, mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
+}
+
+static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
+				     struct ufs_hw_queue *hwq,
+				     struct cq_entry *cqe)
+{
+	dma_addr_t dma_addr;
+
+	/* sizeof(struct utp_transfer_cmd_desc) must be a multiple of 128 */
+	BUILD_BUG_ON(sizeof(struct utp_transfer_cmd_desc) & GENMASK(6, 0));
+
+	/* Bits 63:7 UCD base address, 6:5 are reserved, 4:0 is SQ ID */
+	dma_addr = le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA;
+
+	return (dma_addr - hba->ucdl_dma_addr) /
+		sizeof(struct utp_transfer_cmd_desc);
+}
+
+static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
+					    struct ufs_hw_queue *hwq)
+{
+	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
+	int tag;
+
+	tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
+	ufshcd_compl_one_cqe(hba, tag, cqe);
+}
+
+unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq)
+{
+	unsigned long completed_reqs = 0;
+
+	ufshcd_mcq_update_cq_tail_slot(hwq);
+	while (!ufshcd_mcq_is_cq_empty(hwq)) {
+		ufshcd_mcq_process_cqe(hba, hwq);
+		ufshcd_mcq_inc_cq_head_slot(hwq);
+		completed_reqs++;
+	}
+
+	if (completed_reqs)
+		ufshcd_mcq_update_cq_head(hwq);
+
+	return completed_reqs;
+}
+
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 {
 	struct ufs_hw_queue *hwq;
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 62ae7e51..417e2ca 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -58,6 +58,10 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
 void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
+u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
+void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
+unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq);
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					   struct request *req);
 
@@ -242,6 +246,15 @@ static inline int ufshcd_mcq_vops_op_runtime_config(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_vops_get_outstanding_cqs(struct ufs_hba *hba,
+						  unsigned long *ocqs)
+{
+	if (hba->vops && hba->vops->get_outstanding_cqs)
+		return hba->vops->get_outstanding_cqs(hba, ocqs);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
@@ -332,4 +345,34 @@ static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
 	writel(val, q->mcq_sq_tail);
 }
 
+static inline void ufshcd_mcq_update_cq_tail_slot(struct ufs_hw_queue *q)
+{
+	u32 val = readl(q->mcq_cq_tail);
+
+	q->cq_tail_slot = val / sizeof(struct cq_entry);
+}
+
+static inline bool ufshcd_mcq_is_cq_empty(struct ufs_hw_queue *q)
+{
+	return q->cq_head_slot == q->cq_tail_slot;
+}
+
+static inline void ufshcd_mcq_inc_cq_head_slot(struct ufs_hw_queue *q)
+{
+	q->cq_head_slot++;
+	if (q->cq_head_slot == q->max_entries)
+		q->cq_head_slot = 0;
+}
+
+static inline void ufshcd_mcq_update_cq_head(struct ufs_hw_queue *q)
+{
+	writel(q->cq_head_slot * sizeof(struct cq_entry), q->mcq_cq_head);
+}
+
+static inline struct cq_entry *ufshcd_mcq_cur_cqe(struct ufs_hw_queue *q)
+{
+	struct cq_entry *cqe = q->cqe_base_addr;
+
+	return cqe + q->cq_head_slot;
+}
 #endif /* _UFSHCD_PRIV_H_ */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ac3b498..908692d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6652,6 +6652,40 @@ static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
 }
 
 /**
+ * ufshcd_handle_mcq_cq_events - handle MCQ completion queue events
+ * @hba: per adapter instance
+ *
+ * Returns IRQ_HANDLED if interrupt is handled
+ */
+static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	unsigned long outstanding_cqs;
+	unsigned int nr_queues;
+	int i, ret;
+	u32 events;
+
+	ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
+	if (ret)
+		outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
+
+	/* Exclude the poll queues */
+	nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	for_each_set_bit(i, &outstanding_cqs, nr_queues) {
+		hwq = &hba->uhq[i];
+
+		events = ufshcd_mcq_read_cqis(hba, i);
+		if (events)
+			ufshcd_mcq_write_cqis(hba, events, i);
+
+		if (events & UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS)
+			ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
  * ufshcd_sl_intr - Interrupt service routine
  * @hba: per adapter instance
  * @intr_status: contains interrupts generated by the controller
@@ -6676,6 +6710,9 @@ static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
 	if (intr_status & UTP_TRANSFER_REQ_COMPL)
 		retval |= ufshcd_transfer_req_compl(hba);
 
+	if (intr_status & MCQ_CQ_EVENT_STATUS)
+		retval |= ufshcd_handle_mcq_cq_events(hba);
+
 	return retval;
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 59e892c..36c40210 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1454,6 +1454,21 @@ static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
 	return MAX_SUPP_MAC;
 }
 
+static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
+					unsigned long *ocqs)
+{
+	u32 cqis_vs;
+	struct ufshcd_res_info *mcq_vs_res = &hba->res[RES_MCQ_VS];
+
+	if (!mcq_vs_res->base)
+		return -EINVAL;
+
+	cqis_vs = readl(mcq_vs_res->base + UFS_MEM_CQIS_VS);
+	*ocqs = cqis_vs;
+
+	return 0;
+}
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1479,6 +1494,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.program_key		= ufs_qcom_ice_program_key,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
 	.op_runtime_config	= ufs_qcom_op_runtime_config,
+	.get_outstanding_cqs	= ufs_qcom_get_outstanding_cqs,
 };
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 44466a3..7769f03 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -72,6 +72,10 @@ enum {
 	UFS_UFS_DBG_RD_EDTL_RAM			= 0x1900,
 };
 
+enum {
+	UFS_MEM_CQIS_VS		= 0x8,
+};
+
 #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 2625b4c..28b2d12 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -296,6 +296,7 @@ struct ufs_pwr_mode_info {
  * @event_notify: called to notify important events
  * @get_hba_mac: called to get vendor specific mac value
  * @op_runtime_config: called to config Operation and runtime regs Pointers
+ * @get_outstanding_cqs: called to get outstanding completion queues
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -336,6 +337,8 @@ struct ufs_hba_variant_ops {
 				enum ufs_event_type evt, void *data);
 	int	(*get_hba_mac)(struct ufs_hba *hba);
 	int	(*op_runtime_config)(struct ufs_hba *hba);
+	int	(*get_outstanding_cqs)(struct ufs_hba *hba,
+				       unsigned long *ocqs);
 };
 
 /* clock gating state  */
@@ -1057,6 +1060,8 @@ struct ufs_hba {
  * @id: hardware queue ID
  * @sq_tp_slot: current slot to which SQ tail pointer is pointing
  * @sq_lock: serialize submission queue access
+ * @cq_tail_slot: current slot to which CQ tail pointer is pointing
+ * @cq_head_slot: current slot to which CQ head pointer is pointing
  */
 struct ufs_hw_queue {
 	void __iomem *mcq_sq_head;
@@ -1072,6 +1077,8 @@ struct ufs_hw_queue {
 	u32 id;
 	u32 sq_tail_slot;
 	spinlock_t sq_lock;
+	u32 cq_tail_slot;
+	u32 cq_head_slot;
 };
 
 static inline bool is_mcq_enabled(struct ufs_hba *hba)
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 3d455e1..f3b3f42 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -266,6 +266,9 @@ enum {
 /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
 #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
+/* CQISy - CQ y Interrupt Status Register  */
+#define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
+
 /* UICCMD - UIC Command */
 #define COMMAND_OPCODE_MASK		0xFF
 #define GEN_SELECTOR_INDEX_MASK		0xFFFF
-- 
2.7.4

