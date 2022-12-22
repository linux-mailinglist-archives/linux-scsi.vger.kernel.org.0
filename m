Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4784653B5C
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Dec 2022 05:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiLVEkB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Dec 2022 23:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiLVEjp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Dec 2022 23:39:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8441A204
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM1SDgI018335
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=GQGNPom8kgHOsS0LlASm3LzC3cvR5CEbsQ0v79hjkxE=;
 b=DkAmA9d1Pot8b+X8cWpgwNpPn/qVe0NNM0750FFqmGdr0WTTc7iXkveM/1oINcL/IPCI
 eMkyZ4j5WxzgNK3iZSjWX/P9YRuQvVBqneIsvjGWHjoB8ehS46KaOpea4TRFdPDQCqCV
 +B0TEkKQ8L8bnxmY0HMB+b/NwWIjbxm/Yn5vzySpTwYG/xdf506a1AD/hjE4+eMOMkMJ
 JZ+0l5osv+Xex9pIdzpOrnZAz7Oyu1/QqIEKbljVDSO1i1y9xpHs5iEujnWeKNFzOk0T
 ZV/aMXCRh24P27vOcLPjGIAo7EIGn/bsFTo0Zgqw6tjsCRVOog4ydJdIIw5BHuz7TPli hw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mm79c2j8t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Dec
 2022 20:39:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 21 Dec 2022 20:39:41 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id D21E15B694B;
        Wed, 21 Dec 2022 20:39:40 -0800 (PST)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <bhazarika@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH 04/10] qla2xxx: relocate/rename vp map
Date:   Wed, 21 Dec 2022 20:39:27 -0800
Message-ID: <20221222043933.2825-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20221222043933.2825-1-njavali@marvell.com>
References: <20221222043933.2825-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ha3S9Nc5MZ152eXwOtJ1_TytcvRqNtdA
X-Proofpoint-GUID: ha3S9Nc5MZ152eXwOtJ1_TytcvRqNtdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_01,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

There is no functional change in this patch.
VP map resource is renamed and relocated so
it is not viewed as just a target mode resource.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h    |   4 +-
 drivers/scsi/qla2xxx/qla_edif.h   |   2 +
 drivers/scsi/qla2xxx/qla_gbl.h    |   5 +-
 drivers/scsi/qla2xxx/qla_init.c   |   4 +-
 drivers/scsi/qla2xxx/qla_mbx.c    |   8 +--
 drivers/scsi/qla2xxx/qla_mid.c    |  83 ++++++++++++++++++++++--
 drivers/scsi/qla2xxx/qla_os.c     |  13 +++-
 drivers/scsi/qla2xxx/qla_target.c | 103 +++---------------------------
 drivers/scsi/qla2xxx/qla_target.h |   1 -
 9 files changed, 113 insertions(+), 110 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 2ed04f71cfc5..4bf167c00569 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3935,7 +3935,6 @@ struct qlt_hw_data {
 	__le32 __iomem *atio_q_out;
 
 	const struct qla_tgt_func_tmpl *tgt_ops;
-	struct qla_tgt_vp_map *tgt_vp_map;
 
 	int saved_set;
 	__le16	saved_exchange_count;
@@ -4759,6 +4758,7 @@ struct qla_hw_data {
 	spinlock_t sadb_lock;	/* protects list */
 	struct els_reject elsrej;
 	u8 edif_post_stop_cnt_down;
+	struct qla_vp_map *vp_map;
 };
 
 #define RX_ELS_SIZE (roundup(sizeof(struct enode) + ELS_MAX_PAYLOAD, SMP_CACHE_BYTES))
@@ -5059,7 +5059,7 @@ struct qla27xx_image_status {
 #define SET_AL_PA	2
 #define RESET_VP_IDX	3
 #define RESET_AL_PA	4
-struct qla_tgt_vp_map {
+struct qla_vp_map {
 	uint8_t	idx;
 	scsi_qla_host_t *vha;
 };
diff --git a/drivers/scsi/qla2xxx/qla_edif.h b/drivers/scsi/qla2xxx/qla_edif.h
index 7cdb89ccdc6e..aa566cdb77e5 100644
--- a/drivers/scsi/qla2xxx/qla_edif.h
+++ b/drivers/scsi/qla2xxx/qla_edif.h
@@ -145,4 +145,6 @@ struct enode {
 	(qla_ini_mode_enabled(_s->vha) && (_s->disc_state == DSC_DELETE_PEND || \
 	 _s->disc_state == DSC_DELETED))
 
+#define EDIF_CAP(_ha) (ql2xsecenable && IS_QLA28XX(_ha))
+
 #endif	/* __QLA_EDIF_H */
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 08ea8dc6c6bb..958892766321 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -257,6 +257,7 @@ struct edif_sa_ctl *qla_edif_find_sa_ctl_by_index(fc_port_t *fcport,
 /*
  * Global Functions in qla_mid.c source file.
  */
+extern void qla_update_vp_map(struct scsi_qla_host *, int);
 extern struct scsi_host_template qla2xxx_driver_template;
 extern struct scsi_transport_template *qla2xxx_transport_vport_template;
 extern void qla2x00_timer(struct timer_list *);
@@ -955,7 +956,7 @@ extern struct fc_port *qlt_find_sess_invalidate_other(scsi_qla_host_t *,
 	uint64_t wwn, port_id_t port_id, uint16_t loop_id, struct fc_port **);
 void qla24xx_delete_sess_fn(struct work_struct *);
 void qlt_unknown_atio_work_fn(struct work_struct *);
-void qlt_update_host_map(struct scsi_qla_host *, port_id_t);
+void qla_update_host_map(struct scsi_qla_host *, port_id_t);
 void qla_remove_hostmap(struct qla_hw_data *ha);
 void qlt_clr_qp_table(struct scsi_qla_host *vha);
 void qlt_set_mode(struct scsi_qla_host *);
@@ -968,6 +969,8 @@ extern void qla_nvme_abort_set_option
 		(struct abort_entry_24xx *abt, srb_t *sp);
 extern void qla_nvme_abort_process_comp_status
 		(struct abort_entry_24xx *abt, srb_t *sp);
+struct scsi_qla_host *qla_find_host_by_vp_idx(struct scsi_qla_host *vha,
+	uint16_t vp_idx);
 
 /* nvme.c */
 void qla_nvme_unregister_remote_port(struct fc_port *fcport);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a23cb2e5ab58..fc540bd13a90 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4822,9 +4822,9 @@ qla2x00_configure_hba(scsi_qla_host_t *vha)
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	if (vha->hw->flags.edif_enabled) {
 		if (topo != 2)
-			qlt_update_host_map(vha, id);
+			qla_update_host_map(vha, id);
 	} else if (!(topo == 2 && ha->flags.n2n_bigger))
-		qlt_update_host_map(vha, id);
+		qla_update_host_map(vha, id);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 	if (!vha->flags.init_done)
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 359595a64664..254fd4c64262 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4010,7 +4010,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 		    rptid_entry->port_id[2], rptid_entry->port_id[1],
 		    rptid_entry->port_id[0]);
 		ha->current_topology = ISP_CFG_NL;
-		qlt_update_host_map(vha, id);
+		qla_update_host_map(vha, id);
 
 	} else if (rptid_entry->format == 1) {
 		/* fabric */
@@ -4126,7 +4126,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 					    WWN_SIZE);
 				}
 
-				qlt_update_host_map(vha, id);
+				qla_update_host_map(vha, id);
 			}
 
 			set_bit(REGISTER_FC4_NEEDED, &vha->dpc_flags);
@@ -4153,7 +4153,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 			if (!found)
 				return;
 
-			qlt_update_host_map(vp, id);
+			qla_update_host_map(vp, id);
 
 			/*
 			 * Cannot configure here as we are still sitting on the
@@ -4184,7 +4184,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 
 		ha->flags.n2n_ae = 1;
 		spin_lock_irqsave(&ha->vport_slock, flags);
-		qlt_update_vp_map(vha, SET_AL_PA);
+		qla_update_vp_map(vha, SET_AL_PA);
 		spin_unlock_irqrestore(&ha->vport_slock, flags);
 
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 5fff17da0202..274d2ba70b81 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -52,7 +52,7 @@ qla24xx_allocate_vp_id(scsi_qla_host_t *vha)
 	spin_unlock_irqrestore(&ha->vport_slock, flags);
 
 	spin_lock_irqsave(&ha->hardware_lock, flags);
-	qlt_update_vp_map(vha, SET_VP_IDX);
+	qla_update_vp_map(vha, SET_VP_IDX);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 	mutex_unlock(&ha->vport_lock);
@@ -80,7 +80,7 @@ qla24xx_deallocate_vp_id(scsi_qla_host_t *vha)
 		spin_lock_irqsave(&ha->vport_slock, flags);
 		if (atomic_read(&vha->vref_count) == 0) {
 			list_del(&vha->list);
-			qlt_update_vp_map(vha, RESET_VP_IDX);
+			qla_update_vp_map(vha, RESET_VP_IDX);
 			bailout = 1;
 		}
 		spin_unlock_irqrestore(&ha->vport_slock, flags);
@@ -95,7 +95,7 @@ qla24xx_deallocate_vp_id(scsi_qla_host_t *vha)
 			"vha->vref_count=%u timeout\n", vha->vref_count.counter);
 		spin_lock_irqsave(&ha->vport_slock, flags);
 		list_del(&vha->list);
-		qlt_update_vp_map(vha, RESET_VP_IDX);
+		qla_update_vp_map(vha, RESET_VP_IDX);
 		spin_unlock_irqrestore(&ha->vport_slock, flags);
 	}
 
@@ -187,7 +187,7 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 
 	/* Remove port id from vp target map */
 	spin_lock_irqsave(&vha->hw->hardware_lock, flags);
-	qlt_update_vp_map(vha, RESET_AL_PA);
+	qla_update_vp_map(vha, RESET_AL_PA);
 	spin_unlock_irqrestore(&vha->hw->hardware_lock, flags);
 
 	qla2x00_mark_vp_devices_dead(vha);
@@ -1005,3 +1005,78 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 	return rval;
 }
+
+struct scsi_qla_host *qla_find_host_by_vp_idx(struct scsi_qla_host *vha, uint16_t vp_idx)
+{
+	struct qla_hw_data *ha = vha->hw;
+
+	if (vha->vp_idx == vp_idx)
+		return vha;
+
+	BUG_ON(ha->vp_map == NULL);
+	if (likely(test_bit(vp_idx, ha->vp_idx_map)))
+		return ha->vp_map[vp_idx].vha;
+
+	return NULL;
+}
+
+/* vport_slock to be held by the caller */
+void
+qla_update_vp_map(struct scsi_qla_host *vha, int cmd)
+{
+	void *slot;
+	u32 key;
+	int rc;
+
+	if (!vha->hw->vp_map)
+		return;
+
+	key = vha->d_id.b24;
+
+	switch (cmd) {
+	case SET_VP_IDX:
+		vha->hw->vp_map[vha->vp_idx].vha = vha;
+		break;
+	case SET_AL_PA:
+		slot = btree_lookup32(&vha->hw->host_map, key);
+		if (!slot) {
+			ql_dbg(ql_dbg_disc, vha, 0xf018,
+			    "Save vha in host_map %p %06x\n", vha, key);
+			rc = btree_insert32(&vha->hw->host_map,
+			    key, vha, GFP_ATOMIC);
+			if (rc)
+				ql_log(ql_log_info, vha, 0xd03e,
+				    "Unable to insert s_id into host_map: %06x\n",
+				    key);
+			return;
+		}
+		ql_dbg(ql_dbg_disc, vha, 0xf019,
+		    "replace existing vha in host_map %p %06x\n", vha, key);
+		btree_update32(&vha->hw->host_map, key, vha);
+		break;
+	case RESET_VP_IDX:
+		vha->hw->vp_map[vha->vp_idx].vha = NULL;
+		break;
+	case RESET_AL_PA:
+		ql_dbg(ql_dbg_disc, vha, 0xf01a,
+		    "clear vha in host_map %p %06x\n", vha, key);
+		slot = btree_lookup32(&vha->hw->host_map, key);
+		if (slot)
+			btree_remove32(&vha->hw->host_map, key);
+		vha->d_id.b24 = 0;
+		break;
+	}
+}
+
+void qla_update_host_map(struct scsi_qla_host *vha, port_id_t id)
+{
+
+	if (!vha->d_id.b24) {
+		vha->d_id = id;
+		qla_update_vp_map(vha, SET_AL_PA);
+	} else if (vha->d_id.b24 != id.b24) {
+		qla_update_vp_map(vha, RESET_AL_PA);
+		vha->d_id = id;
+		qla_update_vp_map(vha, SET_AL_PA);
+	}
+}
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index c0ac6bfeeafe..ac3d0bc1b230 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4118,10 +4118,16 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	char	name[16];
 	int rc;
 
+	if (QLA_TGT_MODE_ENABLED() || EDIF_CAP(ha)) {
+		ha->vp_map = kcalloc(MAX_MULTI_ID_FABRIC, sizeof(struct qla_vp_map), GFP_KERNEL);
+		if (!ha->vp_map)
+			goto fail;
+	}
+
 	ha->init_cb = dma_alloc_coherent(&ha->pdev->dev, ha->init_cb_size,
 		&ha->init_cb_dma, GFP_KERNEL);
 	if (!ha->init_cb)
-		goto fail;
+		goto fail_free_vp_map;
 
 	rc = btree_init32(&ha->host_map);
 	if (rc)
@@ -4540,6 +4546,8 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	ha->init_cb_dma);
 	ha->init_cb = NULL;
 	ha->init_cb_dma = 0;
+fail_free_vp_map:
+	kfree(ha->vp_map);
 fail:
 	ql_log(ql_log_fatal, NULL, 0x0030,
 	    "Memory allocation failure.\n");
@@ -4981,6 +4989,9 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	ha->sf_init_cb = NULL;
 	ha->sf_init_cb_dma = 0;
 	ha->loop_id_map = NULL;
+
+	kfree(ha->vp_map);
+	ha->vp_map = NULL;
 }
 
 struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 548f22705ddc..dbd6660c0bf8 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -198,22 +198,6 @@ struct scsi_qla_host *qla_find_host_by_d_id(struct scsi_qla_host *vha,
 	return host;
 }
 
-static inline
-struct scsi_qla_host *qlt_find_host_by_vp_idx(struct scsi_qla_host *vha,
-	uint16_t vp_idx)
-{
-	struct qla_hw_data *ha = vha->hw;
-
-	if (vha->vp_idx == vp_idx)
-		return vha;
-
-	BUG_ON(ha->tgt.tgt_vp_map == NULL);
-	if (likely(test_bit(vp_idx, ha->vp_idx_map)))
-		return ha->tgt.tgt_vp_map[vp_idx].vha;
-
-	return NULL;
-}
-
 static inline void qlt_incr_num_pend_cmds(struct scsi_qla_host *vha)
 {
 	unsigned long flags;
@@ -371,7 +355,7 @@ static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
 
 		if ((entry->u.isp24.vp_index != 0xFF) &&
 		    (entry->u.isp24.nport_handle != cpu_to_le16(0xFFFF))) {
-			host = qlt_find_host_by_vp_idx(vha,
+			host = qla_find_host_by_vp_idx(vha,
 			    entry->u.isp24.vp_index);
 			if (unlikely(!host)) {
 				ql_dbg(ql_dbg_tgt, vha, 0xe03f,
@@ -395,7 +379,7 @@ static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
 	{
 		struct abts_recv_from_24xx *entry =
 			(struct abts_recv_from_24xx *)atio;
-		struct scsi_qla_host *host = qlt_find_host_by_vp_idx(vha,
+		struct scsi_qla_host *host = qla_find_host_by_vp_idx(vha,
 			entry->vp_index);
 		unsigned long flags;
 
@@ -438,7 +422,7 @@ void qlt_response_pkt_all_vps(struct scsi_qla_host *vha,
 	case CTIO_TYPE7:
 	{
 		struct ctio7_from_24xx *entry = (struct ctio7_from_24xx *)pkt;
-		struct scsi_qla_host *host = qlt_find_host_by_vp_idx(vha,
+		struct scsi_qla_host *host = qla_find_host_by_vp_idx(vha,
 		    entry->vp_index);
 		if (unlikely(!host)) {
 			ql_dbg(ql_dbg_tgt, vha, 0xe041,
@@ -457,7 +441,7 @@ void qlt_response_pkt_all_vps(struct scsi_qla_host *vha,
 		struct imm_ntfy_from_isp *entry =
 		    (struct imm_ntfy_from_isp *)pkt;
 
-		host = qlt_find_host_by_vp_idx(vha, entry->u.isp24.vp_index);
+		host = qla_find_host_by_vp_idx(vha, entry->u.isp24.vp_index);
 		if (unlikely(!host)) {
 			ql_dbg(ql_dbg_tgt, vha, 0xe042,
 			    "qla_target(%d): Response pkt (IMMED_NOTIFY_TYPE) "
@@ -475,7 +459,7 @@ void qlt_response_pkt_all_vps(struct scsi_qla_host *vha,
 		struct nack_to_isp *entry = (struct nack_to_isp *)pkt;
 
 		if (0xFF != entry->u.isp24.vp_index) {
-			host = qlt_find_host_by_vp_idx(vha,
+			host = qla_find_host_by_vp_idx(vha,
 			    entry->u.isp24.vp_index);
 			if (unlikely(!host)) {
 				ql_dbg(ql_dbg_tgt, vha, 0xe043,
@@ -495,7 +479,7 @@ void qlt_response_pkt_all_vps(struct scsi_qla_host *vha,
 	{
 		struct abts_recv_from_24xx *entry =
 		    (struct abts_recv_from_24xx *)pkt;
-		struct scsi_qla_host *host = qlt_find_host_by_vp_idx(vha,
+		struct scsi_qla_host *host = qla_find_host_by_vp_idx(vha,
 		    entry->vp_index);
 		if (unlikely(!host)) {
 			ql_dbg(ql_dbg_tgt, vha, 0xe044,
@@ -512,7 +496,7 @@ void qlt_response_pkt_all_vps(struct scsi_qla_host *vha,
 	{
 		struct abts_resp_to_24xx *entry =
 		    (struct abts_resp_to_24xx *)pkt;
-		struct scsi_qla_host *host = qlt_find_host_by_vp_idx(vha,
+		struct scsi_qla_host *host = qla_find_host_by_vp_idx(vha,
 		    entry->vp_index);
 		if (unlikely(!host)) {
 			ql_dbg(ql_dbg_tgt, vha, 0xe045,
@@ -7145,7 +7129,7 @@ qlt_probe_one_stage1(struct scsi_qla_host *base_vha, struct qla_hw_data *ha)
 
 	qlt_clear_mode(base_vha);
 
-	qlt_update_vp_map(base_vha, SET_VP_IDX);
+	qla_update_vp_map(base_vha, SET_VP_IDX);
 }
 
 irqreturn_t
@@ -7224,17 +7208,10 @@ qlt_mem_alloc(struct qla_hw_data *ha)
 	if (!QLA_TGT_MODE_ENABLED())
 		return 0;
 
-	ha->tgt.tgt_vp_map = kcalloc(MAX_MULTI_ID_FABRIC,
-				     sizeof(struct qla_tgt_vp_map),
-				     GFP_KERNEL);
-	if (!ha->tgt.tgt_vp_map)
-		return -ENOMEM;
-
 	ha->tgt.atio_ring = dma_alloc_coherent(&ha->pdev->dev,
 	    (ha->tgt.atio_q_length + 1) * sizeof(struct atio_from_isp),
 	    &ha->tgt.atio_dma, GFP_KERNEL);
 	if (!ha->tgt.atio_ring) {
-		kfree(ha->tgt.tgt_vp_map);
 		return -ENOMEM;
 	}
 	return 0;
@@ -7253,70 +7230,6 @@ qlt_mem_free(struct qla_hw_data *ha)
 	}
 	ha->tgt.atio_ring = NULL;
 	ha->tgt.atio_dma = 0;
-	kfree(ha->tgt.tgt_vp_map);
-	ha->tgt.tgt_vp_map = NULL;
-}
-
-/* vport_slock to be held by the caller */
-void
-qlt_update_vp_map(struct scsi_qla_host *vha, int cmd)
-{
-	void *slot;
-	u32 key;
-	int rc;
-
-	key = vha->d_id.b24;
-
-	switch (cmd) {
-	case SET_VP_IDX:
-		if (!QLA_TGT_MODE_ENABLED())
-			return;
-		vha->hw->tgt.tgt_vp_map[vha->vp_idx].vha = vha;
-		break;
-	case SET_AL_PA:
-		slot = btree_lookup32(&vha->hw->host_map, key);
-		if (!slot) {
-			ql_dbg(ql_dbg_tgt_mgt, vha, 0xf018,
-			    "Save vha in host_map %p %06x\n", vha, key);
-			rc = btree_insert32(&vha->hw->host_map,
-				key, vha, GFP_ATOMIC);
-			if (rc)
-				ql_log(ql_log_info, vha, 0xd03e,
-				    "Unable to insert s_id into host_map: %06x\n",
-				    key);
-			return;
-		}
-		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf019,
-		    "replace existing vha in host_map %p %06x\n", vha, key);
-		btree_update32(&vha->hw->host_map, key, vha);
-		break;
-	case RESET_VP_IDX:
-		if (!QLA_TGT_MODE_ENABLED())
-			return;
-		vha->hw->tgt.tgt_vp_map[vha->vp_idx].vha = NULL;
-		break;
-	case RESET_AL_PA:
-		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf01a,
-		   "clear vha in host_map %p %06x\n", vha, key);
-		slot = btree_lookup32(&vha->hw->host_map, key);
-		if (slot)
-			btree_remove32(&vha->hw->host_map, key);
-		vha->d_id.b24 = 0;
-		break;
-	}
-}
-
-void qlt_update_host_map(struct scsi_qla_host *vha, port_id_t id)
-{
-
-	if (!vha->d_id.b24) {
-		vha->d_id = id;
-		qlt_update_vp_map(vha, SET_AL_PA);
-	} else if (vha->d_id.b24 != id.b24) {
-		qlt_update_vp_map(vha, RESET_AL_PA);
-		vha->d_id = id;
-		qlt_update_vp_map(vha, SET_AL_PA);
-	}
 }
 
 static int __init qlt_parse_ini_mode(void)
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 7df86578214f..354fca2e7feb 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -1017,7 +1017,6 @@ extern void qlt_fc_port_added(struct scsi_qla_host *, fc_port_t *);
 extern void qlt_fc_port_deleted(struct scsi_qla_host *, fc_port_t *, int);
 extern int __init qlt_init(void);
 extern void qlt_exit(void);
-extern void qlt_update_vp_map(struct scsi_qla_host *, int);
 extern void qlt_free_session_done(struct work_struct *);
 /*
  * This macro is used during early initializations when host->active_mode
-- 
2.19.0.rc0

