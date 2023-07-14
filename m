Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A760475326E
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jul 2023 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjGNHBU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jul 2023 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjGNHBS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Jul 2023 03:01:18 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D902708
        for <linux-scsi@vger.kernel.org>; Fri, 14 Jul 2023 00:01:17 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DL45di017666
        for <linux-scsi@vger.kernel.org>; Fri, 14 Jul 2023 00:01:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=4OTbTDTohh19XRNfqYpXe72aPdwi1jaK5kTMaa+rqvA=;
 b=G2HUx13OB7Q8nXDLb5nAS2oMot6Zj5mqFsoqx9V6MiVHbrHq0a2yPHgVXOjw0YgxVmaL
 k5EWgVL4ywCsxqrTf3ocOoJXXVGoW0RpPJ9FzmmfdF4GLwDyGkz9nbl5+WSI5dauV5b8
 8bn07hTO85AD6ql+evkylvxhXMQgHMzXxRMq3BQFGJAgOl2Ta8Zv0HMoMaw8rojj9IZc
 YFAujqRnBcm92NMzXu4iuwq8tw/hrckAnH0VPcOKgNY3XSlkUSC0jJURrskx4SxGkgL4
 cc87YseNMgnCW22RHPyHFYQY9fo/G1VasyCyxciDHS78/ryDCsRfylqAWgj6l9DA6dLZ xQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rtrux9mgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Fri, 14 Jul 2023 00:01:16 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 00:01:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Jul 2023 00:01:14 -0700
Received: from localhost.marvell.com (unknown [10.30.46.195])
        by maili.marvell.com (Postfix) with ESMTP id 169E23F7067;
        Fri, 14 Jul 2023 00:01:12 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH v2 03/10] qla2xxx: Limit TMF to 8 per function
Date:   Fri, 14 Jul 2023 12:30:57 +0530
Message-ID: <20230714070104.40052-4-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20230714070104.40052-1-njavali@marvell.com>
References: <20230714070104.40052-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cKopcILiSvK95VWILVqsU7cfZDxjDoCl
X-Proofpoint-ORIG-GUID: cKopcILiSvK95VWILVqsU7cfZDxjDoCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Per FW recommendation, 8 TMF's can be outstanding for each
function. Previously, it allowed 8 per target.

Limit TMF to 8 per function.

Cc: stable@vger.kernel.org
Fixes: 6a87679626b5 ("scsi: qla2xxx: Fix task management cmd fail due to unavailable resource")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |  9 +++---
 drivers/scsi/qla2xxx/qla_init.c | 55 ++++++++++++++++++++-------------
 drivers/scsi/qla2xxx/qla_os.c   |  2 ++
 3 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 95a12b4e0484..03d94e024bdd 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -466,6 +466,7 @@ static inline be_id_t port_id_to_be_id(port_id_t port_id)
 }
 
 struct tmf_arg {
+	struct list_head tmf_elem;
 	struct qla_qpair *qpair;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
@@ -2541,7 +2542,6 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
-	struct list_head tmf_pending;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -2562,9 +2562,6 @@ typedef struct fc_port {
 	unsigned int do_prli_nvme:1;
 
 	uint8_t nvme_flag;
-	uint8_t active_tmf;
-#define MAX_ACTIVE_TMF 8
-
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
 	port_id_t d_id;
@@ -4656,6 +4653,8 @@ struct qla_hw_data {
 		uint32_t	flt_region_aux_img_status_sec;
 	};
 	uint8_t         active_image;
+	uint8_t active_tmf;
+#define MAX_ACTIVE_TMF 8
 
 	/* Needed for BEACON */
 	uint16_t        beacon_blink_led;
@@ -4670,6 +4669,8 @@ struct qla_hw_data {
 
 	struct qla_msix_entry *msix_entries;
 
+	struct list_head tmf_pending;
+	struct list_head tmf_active;
 	struct list_head        vp_list;        /* list of VP */
 	unsigned long   vp_idx_map[(MAX_MULTI_ID_FABRIC / 8) /
 			sizeof(unsigned long)];
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 60dd0e415351..5ec6f01ca635 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2192,30 +2192,42 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 	return rval;
 }
 
-static void qla_put_tmf(fc_port_t *fcport)
+static void qla_put_tmf(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-	fcport->active_tmf--;
+	ha->active_tmf--;
+	list_del(&arg->tmf_elem);
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 }
 
 static
-int qla_get_tmf(fc_port_t *fcport)
+int qla_get_tmf(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
+	fc_port_t *fcport = arg->fcport;
 	int rc = 0;
-	LIST_HEAD(tmf_elem);
+	struct tmf_arg *t;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-	list_add_tail(&tmf_elem, &fcport->tmf_pending);
+	list_for_each_entry(t, &ha->tmf_active, tmf_elem) {
+		if (t->fcport == arg->fcport && t->lun == arg->lun) {
+			/* reject duplicate TMF */
+			ql_log(ql_log_warn, vha, 0x802c,
+			       "found duplicate TMF.  Nexus=%ld:%06x:%llu.\n",
+			       vha->host_no, fcport->d_id.b24, arg->lun);
+			spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+			return -EINVAL;
+		}
+	}
 
-	while (fcport->active_tmf >= MAX_ACTIVE_TMF) {
+	list_add_tail(&arg->tmf_elem, &ha->tmf_pending);
+	while (ha->active_tmf >= MAX_ACTIVE_TMF) {
 		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
 		msleep(1);
@@ -2227,15 +2239,17 @@ int qla_get_tmf(fc_port_t *fcport)
 			rc = EIO;
 			break;
 		}
-		if (fcport->active_tmf < MAX_ACTIVE_TMF &&
-		    list_is_first(&tmf_elem, &fcport->tmf_pending))
+		if (ha->active_tmf < MAX_ACTIVE_TMF &&
+		    list_is_first(&arg->tmf_elem, &ha->tmf_pending))
 			break;
 	}
 
-	list_del(&tmf_elem);
+	list_del(&arg->tmf_elem);
 
-	if (!rc)
-		fcport->active_tmf++;
+	if (!rc) {
+		ha->active_tmf++;
+		list_add_tail(&arg->tmf_elem, &ha->tmf_active);
+	}
 
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
@@ -2257,15 +2271,18 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 	a.vha = fcport->vha;
 	a.fcport = fcport;
 	a.lun = lun;
+	a.flags = flags;
+	INIT_LIST_HEAD(&a.tmf_elem);
+
 	if (flags & (TCF_LUN_RESET|TCF_ABORT_TASK_SET|TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
 		a.modifier = MK_SYNC_ID_LUN;
-
-		if (qla_get_tmf(fcport))
-			return QLA_FUNCTION_FAILED;
 	} else {
 		a.modifier = MK_SYNC_ID;
 	}
 
+	if (qla_get_tmf(&a))
+		return QLA_FUNCTION_FAILED;
+
 	if (vha->hw->mqenable) {
 		for (i = 0; i < vha->hw->num_qpairs; i++) {
 			qpair = vha->hw->queue_pair_map[i];
@@ -2291,13 +2308,10 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 		goto bailout;
 
 	a.qpair = vha->hw->base_qpair;
-	a.flags = flags;
 	rval = __qla2x00_async_tm_cmd(&a);
 
 bailout:
-	if (a.modifier == MK_SYNC_ID_LUN)
-		qla_put_tmf(fcport);
-
+	qla_put_tmf(&a);
 	return rval;
 }
 
@@ -5526,7 +5540,6 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
-	INIT_LIST_HEAD(&fcport->tmf_pending);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 877e4f446709..47bbc8b321f8 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3009,6 +3009,8 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	atomic_set(&ha->num_pend_mbx_stage3, 0);
 	atomic_set(&ha->zio_threshold, DEFAULT_ZIO_THRESHOLD);
 	ha->last_zio_threshold = DEFAULT_ZIO_THRESHOLD;
+	INIT_LIST_HEAD(&ha->tmf_pending);
+	INIT_LIST_HEAD(&ha->tmf_active);
 
 	/* Assign ISP specific operations. */
 	if (IS_QLA2100(ha)) {
-- 
2.23.1

