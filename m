Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62986653B5B
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Dec 2022 05:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiLVEj4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Dec 2022 23:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiLVEjp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Dec 2022 23:39:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AF21A20C
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:44 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM1SDgK018335
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=f2x2kIEo/XJUfeuHxSeP0RXgiecw62+q7fPk+OxZOu4=;
 b=AWEwpeE+l2gpRQJ/ORPBZNOgxsotb/5xkfcAssBJxJ8nIgpdrqOjncWF/oBmvTj3EHDC
 nZZMMVD82pEJGpceOuxVE7TVUVGl4hJ0x3k2DRh3yl5AzCQNRfmm+4m9eBpXeoKuPy7K
 HZ94iLnp8u7RdGI3dYmvfZ21mbJvIdHKuaVNtoPfY8iyeQAa6EF7QZ63IE0vBI5I2R2P
 bDnzKA5ciBzADVMqjNn2OLfbKh8Rau6drlTFf5bwZEv6XFd9jd39nwDAIBOyZdAf5kq3
 hLjZIU91oGXojLPrZpa9YsDJZNg+Tx6uaNvDuiJVJSVDO7PjrAqVW4H4tBC5i+qGUIJE 7A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mm79c2j8t-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 21 Dec 2022 20:39:43 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Dec
 2022 20:39:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 21 Dec 2022 20:39:41 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 12ECB5B694C;
        Wed, 21 Dec 2022 20:39:41 -0800 (PST)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <bhazarika@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH 05/10] qla2xxx: edif - Fix performance dip due to lock contention
Date:   Wed, 21 Dec 2022 20:39:28 -0800
Message-ID: <20221222043933.2825-6-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20221222043933.2825-1-njavali@marvell.com>
References: <20221222043933.2825-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: csCYQMoyk_8axeFfZGYzGpPhxipYoN_D
X-Proofpoint-GUID: csCYQMoyk_8axeFfZGYzGpPhxipYoN_D
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

User experienced performance dip on measuring IOPS while
EDIF enabled. During IO time, driver uses dma_pool_zalloc call
to allocate a chunk of memory. This call contains a lock behind the
scene which contribute to lock contention.
Save the allocated memory for reuse and avoid the lock.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |  22 +++++-
 drivers/scsi/qla2xxx/qla_edif.c |  29 ++------
 drivers/scsi/qla2xxx/qla_gbl.h  |   5 +-
 drivers/scsi/qla2xxx/qla_init.c |  12 ++++
 drivers/scsi/qla2xxx/qla_iocb.c |  10 +--
 drivers/scsi/qla2xxx/qla_mid.c  | 116 ++++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_os.c   |  12 ++--
 7 files changed, 170 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 4bf167c00569..6f6190404939 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -384,6 +384,13 @@ struct els_reject {
 struct req_que;
 struct qla_tgt_sess;
 
+struct qla_buf_dsc {
+	u16 tag;
+#define TAG_FREED 0xffff
+	void *buf;
+	dma_addr_t buf_dma;
+};
+
 /*
  * SCSI Request Block
  */
@@ -392,14 +399,16 @@ struct srb_cmd {
 	uint32_t request_sense_length;
 	uint32_t fw_sense_length;
 	uint8_t *request_sense_ptr;
-	struct ct6_dsd *ct6_ctx;
 	struct crc_context *crc_ctx;
+	struct ct6_dsd ct6_ctx;
+	struct qla_buf_dsc buf_dsc;
 };
 
 /*
  * SRB flag definitions
  */
 #define SRB_DMA_VALID			BIT_0	/* Command sent to ISP */
+#define SRB_GOT_BUF			BIT_1
 #define SRB_FCP_CMND_DMA_VALID		BIT_12	/* DIF: DSD List valid */
 #define SRB_CRC_CTX_DMA_VALID		BIT_2	/* DIF: context DMA valid */
 #define SRB_CRC_PROT_DMA_VALID		BIT_4	/* DIF: prot DMA valid */
@@ -3722,6 +3731,16 @@ struct qla_fw_resources {
 
 #define QLA_IOCB_PCT_LIMIT 95
 
+struct  qla_buf_pool {
+	u16 num_bufs;
+	u16 num_active;
+	u16 max_used;
+	u16 reserved;
+	unsigned long *buf_map;
+	void **buf_array;
+	dma_addr_t *dma_array;
+};
+
 /*Queue pair data structure */
 struct qla_qpair {
 	spinlock_t qp_lock;
@@ -3775,6 +3794,7 @@ struct qla_qpair {
 	struct qla_tgt_counters tgt_counters;
 	uint16_t cpuid;
 	struct qla_fw_resources fwres ____cacheline_aligned;
+	struct  qla_buf_pool buf_pool;
 	u32	cmd_cnt;
 	u32	cmd_completion_cnt;
 	u32	prev_completion_cnt;
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index d17ba6275b68..8374cbe8993b 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -3007,26 +3007,16 @@ qla28xx_start_scsi_edif(srb_t *sp)
 			goto queuing_error;
 	}
 
-	ctx = sp->u.scmd.ct6_ctx =
-	    mempool_alloc(ha->ctx_mempool, GFP_ATOMIC);
-	if (!ctx) {
-		ql_log(ql_log_fatal, vha, 0x3010,
-		    "Failed to allocate ctx for cmd=%p.\n", cmd);
-		goto queuing_error;
-	}
-
-	memset(ctx, 0, sizeof(struct ct6_dsd));
-	ctx->fcp_cmnd = dma_pool_zalloc(ha->fcp_cmnd_dma_pool,
-	    GFP_ATOMIC, &ctx->fcp_cmnd_dma);
-	if (!ctx->fcp_cmnd) {
+	if (qla_get_buf(vha, sp->qpair, &sp->u.scmd.buf_dsc)) {
 		ql_log(ql_log_fatal, vha, 0x3011,
-		    "Failed to allocate fcp_cmnd for cmd=%p.\n", cmd);
+		    "Failed to allocate buf for fcp_cmnd for cmd=%p.\n", cmd);
 		goto queuing_error;
 	}
 
-	/* Initialize the DSD list and dma handle */
-	INIT_LIST_HEAD(&ctx->dsd_list);
-	ctx->dsd_use_cnt = 0;
+	sp->flags |= SRB_GOT_BUF;
+	ctx = &sp->u.scmd.ct6_ctx;
+	ctx->fcp_cmnd = sp->u.scmd.buf_dsc.buf;
+	ctx->fcp_cmnd_dma = sp->u.scmd.buf_dsc.buf_dma;
 
 	if (cmd->cmd_len > 16) {
 		additional_cdb_len = cmd->cmd_len - 16;
@@ -3145,7 +3135,6 @@ qla28xx_start_scsi_edif(srb_t *sp)
 	cmd_pkt->fcp_cmnd_dseg_len = cpu_to_le16(ctx->fcp_cmnd_len);
 	put_unaligned_le64(ctx->fcp_cmnd_dma, &cmd_pkt->fcp_cmnd_dseg_address);
 
-	sp->flags |= SRB_FCP_CMND_DMA_VALID;
 	cmd_pkt->byte_count = cpu_to_le32((uint32_t)scsi_bufflen(cmd));
 	/* Set total data segment count. */
 	cmd_pkt->entry_count = (uint8_t)req_cnt;
@@ -3177,15 +3166,11 @@ qla28xx_start_scsi_edif(srb_t *sp)
 	return QLA_SUCCESS;
 
 queuing_error_fcp_cmnd:
-	dma_pool_free(ha->fcp_cmnd_dma_pool, ctx->fcp_cmnd, ctx->fcp_cmnd_dma);
 queuing_error:
 	if (tot_dsds)
 		scsi_dma_unmap(cmd);
 
-	if (sp->u.scmd.ct6_ctx) {
-		mempool_free(sp->u.scmd.ct6_ctx, ha->ctx_mempool);
-		sp->u.scmd.ct6_ctx = NULL;
-	}
+	qla_put_buf(sp->qpair, &sp->u.scmd.buf_dsc);
 	qla_put_fw_resources(sp->qpair, &sp->iores);
 	spin_unlock_irqrestore(lock, flags);
 
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 958892766321..d802d37fe739 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -1015,5 +1015,8 @@ int qla2xxx_enable_port(struct Scsi_Host *shost);
 
 uint64_t qla2x00_get_num_tgts(scsi_qla_host_t *vha);
 uint64_t qla2x00_count_set_bits(u32 num);
-
+int qla_create_buf_pool(struct scsi_qla_host *, struct qla_qpair *);
+void qla_free_buf_pool(struct qla_qpair *);
+int qla_get_buf(struct scsi_qla_host *, struct qla_qpair *, struct qla_buf_dsc *);
+void qla_put_buf(struct qla_qpair *, struct qla_buf_dsc *);
 #endif /* _QLA_GBL_H */
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index fc540bd13a90..ce9e28b4d339 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9442,6 +9442,13 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 			goto fail_mempool;
 		}
 
+		if (qla_create_buf_pool(vha, qpair)) {
+			ql_log(ql_log_warn, vha, 0xd036,
+			    "Failed to initialize buf pool for qpair %d\n",
+			    qpair->id);
+			goto fail_bufpool;
+		}
+
 		/* Mark as online */
 		qpair->online = 1;
 
@@ -9457,7 +9464,10 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 	}
 	return qpair;
 
+fail_bufpool:
+	mempool_destroy(qpair->srb_mempool);
 fail_mempool:
+	qla25xx_delete_req_que(vha, qpair->req);
 fail_req:
 	qla25xx_delete_rsp_que(vha, qpair->rsp);
 fail_rsp:
@@ -9483,6 +9493,8 @@ int qla2xxx_delete_qpair(struct scsi_qla_host *vha, struct qla_qpair *qpair)
 
 	qpair->delete_in_progress = 1;
 
+	qla_free_buf_pool(qpair);
+
 	ret = qla25xx_delete_req_que(vha, qpair->req);
 	if (ret != QLA_SUCCESS)
 		goto fail;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 9a7cc0ba5f58..b9b3e6f80ea9 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -623,7 +623,7 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
 	}
 
 	cur_seg = scsi_sglist(cmd);
-	ctx = sp->u.scmd.ct6_ctx;
+	ctx = &sp->u.scmd.ct6_ctx;
 
 	while (tot_dsds) {
 		avail_dsds = (tot_dsds > QLA_DSDS_PER_IOCB) ?
@@ -3459,13 +3459,7 @@ qla82xx_start_scsi(srb_t *sp)
 				goto queuing_error;
 		}
 
-		ctx = sp->u.scmd.ct6_ctx =
-		    mempool_alloc(ha->ctx_mempool, GFP_ATOMIC);
-		if (!ctx) {
-			ql_log(ql_log_fatal, vha, 0x3010,
-			    "Failed to allocate ctx for cmd=%p.\n", cmd);
-			goto queuing_error;
-		}
+		ctx = &sp->u.scmd.ct6_ctx;
 
 		memset(ctx, 0, sizeof(struct ct6_dsd));
 		ctx->fcp_cmnd = dma_pool_zalloc(ha->fcp_cmnd_dma_pool,
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 274d2ba70b81..5976a2f036e6 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -1080,3 +1080,119 @@ void qla_update_host_map(struct scsi_qla_host *vha, port_id_t id)
 		qla_update_vp_map(vha, SET_AL_PA);
 	}
 }
+
+int qla_create_buf_pool(struct scsi_qla_host *vha, struct qla_qpair *qp)
+{
+	int sz;
+
+	qp->buf_pool.num_bufs = qp->req->length;
+
+	sz = BITS_TO_LONGS(qp->req->length);
+	qp->buf_pool.buf_map   = kcalloc(sz, sizeof(long), GFP_KERNEL);
+	if (!qp->buf_pool.buf_map) {
+		ql_log(ql_log_warn, vha, 0x0186,
+		    "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
+		return -ENOMEM;
+	}
+	sz = qp->req->length * sizeof(void *);
+	qp->buf_pool.buf_array = kcalloc(qp->req->length, sizeof(void *), GFP_KERNEL);
+	if (!qp->buf_pool.buf_array) {
+		ql_log(ql_log_warn, vha, 0x0186,
+		    "Failed to allocate buf_array(%d).\n", sz);
+		kfree(qp->buf_pool.buf_map);
+		return -ENOMEM;
+	}
+	sz = qp->req->length * sizeof(dma_addr_t);
+	qp->buf_pool.dma_array = kcalloc(qp->req->length, sizeof(dma_addr_t), GFP_KERNEL);
+	if (!qp->buf_pool.dma_array) {
+		ql_log(ql_log_warn, vha, 0x0186,
+		    "Failed to allocate dma_array(%d).\n", sz);
+		kfree(qp->buf_pool.buf_map);
+		kfree(qp->buf_pool.buf_array);
+		return -ENOMEM;
+	}
+	set_bit(0, qp->buf_pool.buf_map);
+	return 0;
+}
+
+void qla_free_buf_pool(struct qla_qpair *qp)
+{
+	int i;
+	struct qla_hw_data *ha = qp->vha->hw;
+
+	for (i = 0; i < qp->buf_pool.num_bufs; i++) {
+		if (qp->buf_pool.buf_array[i] && qp->buf_pool.dma_array[i])
+			dma_pool_free(ha->fcp_cmnd_dma_pool, qp->buf_pool.buf_array[i],
+			    qp->buf_pool.dma_array[i]);
+		qp->buf_pool.buf_array[i] = NULL;
+		qp->buf_pool.dma_array[i] = 0;
+	}
+
+	kfree(qp->buf_pool.dma_array);
+	kfree(qp->buf_pool.buf_array);
+	kfree(qp->buf_pool.buf_map);
+}
+
+/* it is assume qp->qp_lock is held at this point */
+int qla_get_buf(struct scsi_qla_host *vha, struct qla_qpair *qp, struct qla_buf_dsc *dsc)
+{
+	u16 tag, i = 0;
+	void *buf;
+	dma_addr_t buf_dma;
+	struct qla_hw_data *ha = vha->hw;
+
+	dsc->tag = TAG_FREED;
+again:
+	tag = find_first_zero_bit(qp->buf_pool.buf_map, qp->buf_pool.num_bufs);
+	if (tag >= qp->buf_pool.num_bufs) {
+		ql_dbg(ql_dbg_io, vha, 0x00e2,
+		    "qp(%d) ran out of buf resource.\n", qp->id);
+		return  -EIO;
+	}
+	if (tag == 0) {
+		set_bit(0, qp->buf_pool.buf_map);
+		i++;
+		if (i == 5) {
+			ql_dbg(ql_dbg_io, vha, 0x00e3,
+			    "qp(%d) unable to get tag.\n", qp->id);
+			return -EIO;
+		}
+		goto again;
+	}
+
+	if (!qp->buf_pool.buf_array[tag]) {
+		buf = dma_pool_zalloc(ha->fcp_cmnd_dma_pool, GFP_ATOMIC, &buf_dma);
+		if (!buf) {
+			ql_log(ql_log_fatal, vha, 0x13b1,
+			    "Failed to allocate buf.\n");
+			return -ENOMEM;
+		}
+
+		dsc->buf = qp->buf_pool.buf_array[tag] = buf;
+		dsc->buf_dma = qp->buf_pool.dma_array[tag] = buf_dma;
+	} else {
+		dsc->buf = qp->buf_pool.buf_array[tag];
+		dsc->buf_dma = qp->buf_pool.dma_array[tag];
+		memset(dsc->buf, 0, FCP_CMND_DMA_POOL_SIZE);
+	}
+
+	qp->buf_pool.num_active++;
+	if (qp->buf_pool.num_active > qp->buf_pool.max_used)
+		qp->buf_pool.max_used = qp->buf_pool.num_active;
+
+	dsc->tag = tag;
+	set_bit(tag, qp->buf_pool.buf_map);
+	return 0;
+}
+
+
+/* it is assume qp->qp_lock is held at this point */
+void qla_put_buf(struct qla_qpair *qp, struct qla_buf_dsc *dsc)
+{
+	if (dsc->tag == TAG_FREED)
+		return;
+
+	clear_bit(dsc->tag, qp->buf_pool.buf_map);
+	qp->buf_pool.num_active--;
+	dsc->tag = TAG_FREED;
+}
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index ac3d0bc1b230..f8758cea11d6 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -733,15 +733,17 @@ void qla2x00_sp_free_dma(srb_t *sp)
 	}
 
 	if (sp->flags & SRB_FCP_CMND_DMA_VALID) {
-		struct ct6_dsd *ctx1 = sp->u.scmd.ct6_ctx;
+		struct ct6_dsd *ctx1 = &sp->u.scmd.ct6_ctx;
 
 		dma_pool_free(ha->fcp_cmnd_dma_pool, ctx1->fcp_cmnd,
 		    ctx1->fcp_cmnd_dma);
 		list_splice(&ctx1->dsd_list, &ha->gbl_dsd_list);
 		ha->gbl_dsd_inuse -= ctx1->dsd_use_cnt;
 		ha->gbl_dsd_avail += ctx1->dsd_use_cnt;
-		mempool_free(ctx1, ha->ctx_mempool);
 	}
+
+	if (sp->flags & SRB_GOT_BUF)
+		qla_put_buf(sp->qpair, &sp->u.scmd.buf_dsc);
 }
 
 void qla2x00_sp_compl(srb_t *sp, int res)
@@ -817,14 +819,13 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 	}
 
 	if (sp->flags & SRB_FCP_CMND_DMA_VALID) {
-		struct ct6_dsd *ctx1 = sp->u.scmd.ct6_ctx;
+		struct ct6_dsd *ctx1 = &sp->u.scmd.ct6_ctx;
 
 		dma_pool_free(ha->fcp_cmnd_dma_pool, ctx1->fcp_cmnd,
 		    ctx1->fcp_cmnd_dma);
 		list_splice(&ctx1->dsd_list, &ha->gbl_dsd_list);
 		ha->gbl_dsd_inuse -= ctx1->dsd_use_cnt;
 		ha->gbl_dsd_avail += ctx1->dsd_use_cnt;
-		mempool_free(ctx1, ha->ctx_mempool);
 		sp->flags &= ~SRB_FCP_CMND_DMA_VALID;
 	}
 
@@ -834,6 +835,9 @@ void qla2xxx_qpair_sp_free_dma(srb_t *sp)
 		dma_pool_free(ha->dl_dma_pool, ctx0, ctx0->crc_ctx_dma);
 		sp->flags &= ~SRB_CRC_CTX_DMA_VALID;
 	}
+
+	if (sp->flags & SRB_GOT_BUF)
+		qla_put_buf(sp->qpair, &sp->u.scmd.buf_dsc);
 }
 
 void qla2xxx_qpair_sp_compl(srb_t *sp, int res)
-- 
2.19.0.rc0

