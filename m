Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5C1D4026
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2020 23:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgENVgQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 May 2020 17:36:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44436 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgENVgQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 May 2020 17:36:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id b8so49681plm.11
        for <linux-scsi@vger.kernel.org>; Thu, 14 May 2020 14:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtwsxIssxw8DvUtpJyJsslZG6KXuAFM+B+3uWPXp0cI=;
        b=am/7aZ3Vscvb+sqA4ONXVjKjyYPS2jsDEWSm0OPEtc7qJWlrEjDEwx04+29r7qSwvT
         ZIieKgDmTGdFlRkr6zeC2RQHRb8ZhQY9CtVOmInZQx02720QtuQP+0mdVxpvL4IsDnix
         UEQhynUuhXPJ9TuH1rX/MD1VX8inckNTeUzcVQSkI2shEHGZQPVGI51o0xTnagvjb5/E
         G0pFI4FMUem9QE0lof+VBS/PsjyARILuRBz9U5bkVmupp3p3RGHl9BP+iATeM462py6C
         ZwtX7TbG2qz7Uxo9ry3MyQmHYrMfP7FZdL1vkrJ/oz85VdRVlf6A+lepYDs6mSN+mEZo
         2RDg==
X-Gm-Message-State: AGi0PuYf8EUrQK/Uf98FG9gKoZeZaAb18NrVW8JE1afH/7NSO/7XjlFP
        ci/61sdHugFUWRPpBNyaXmI=
X-Google-Smtp-Source: APiQypI7c6aUq+2wNC33LWHJFRH/TnQDlVdN7a1VnFN5IzGy1yhXBoDHERTwZKnMCanPMGsmNllICg==
X-Received: by 2002:a17:90a:a50b:: with SMTP id a11mr42585893pjq.143.1589492174656;
        Thu, 14 May 2020 14:36:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:6c16:7f27:8c37:e02d])
        by smtp.gmail.com with ESMTPSA id a142sm145754pfa.6.2020.05.14.14.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:36:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Arun Easi <aeasi@marvell.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Nilesh Javali <njavali@marvell.com>,
        Daniel Wagner <dwagner@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v6 12/15] qla2xxx: Cast explicitly to uint16_t / uint32_t
Date:   Thu, 14 May 2020 14:35:13 -0700
Message-Id: <20200514213516.25461-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514213516.25461-1-bvanassche@acm.org>
References: <20200514213516.25461-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Casting a pointer to void * and relying on an implicit cast from void *
to uint16_t or uint32_t suppresses sparse warnings about endianness. Hence
cast explicitly to uint16_t and uint32_t. Additionally, remove superfluous
void * casts.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Arun Easi <aeasi@marvell.com>
Cc: Nilesh Javali <njavali@marvell.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_dbg.c    |  4 ++--
 drivers/scsi/qla2xxx/qla_init.c   | 26 +++++++++++++-------------
 drivers/scsi/qla2xxx/qla_mbx.c    |  6 +++---
 drivers/scsi/qla2xxx/qla_mid.c    |  4 ++--
 drivers/scsi/qla2xxx/qla_mr.c     |  4 ++--
 drivers/scsi/qla2xxx/qla_nvme.c   |  4 ++--
 drivers/scsi/qla2xxx/qla_nx2.c    |  4 ++--
 drivers/scsi/qla2xxx/qla_os.c     | 10 +++++-----
 drivers/scsi/qla2xxx/qla_sup.c    | 12 ++++++------
 drivers/scsi/qla2xxx/qla_target.c |  4 ++--
 10 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index fbd8cb5647b6..d020c23a5106 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -115,7 +115,7 @@ qla27xx_dump_mpi_ram(struct qla_hw_data *ha, uint32_t addr, uint32_t *ram,
 {
 	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
 	dma_addr_t dump_dma = ha->gid_list_dma;
-	uint32_t *chunk = (void *)ha->gid_list;
+	uint32_t *chunk = (uint32_t *)ha->gid_list;
 	uint32_t dwords = qla2x00_gid_list_size(ha) / 4;
 	uint32_t stat;
 	ulong i, j, timer = 6000000;
@@ -195,7 +195,7 @@ qla24xx_dump_ram(struct qla_hw_data *ha, uint32_t addr, uint32_t *ram,
 	int rval = QLA_FUNCTION_FAILED;
 	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
 	dma_addr_t dump_dma = ha->gid_list_dma;
-	uint32_t *chunk = (void *)ha->gid_list;
+	uint32_t *chunk = (uint32_t *)ha->gid_list;
 	uint32_t dwords = qla2x00_gid_list_size(ha) / 4;
 	uint32_t stat;
 	ulong i, j, timer = 6000000;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 02614e28451b..135440f4a922 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -992,7 +992,7 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 
 		ql_dbg(ql_dbg_disc, vha, 0x20e8,
 		    "%s %8phC %02x:%02x:%02x CLS %x/%x lid %x \n",
-		    __func__, (void *)&wwn, e->port_id[2], e->port_id[1],
+		    __func__, &wwn, e->port_id[2], e->port_id[1],
 		    e->port_id[0], e->current_login_state, e->last_login_state,
 		    (loop_id & 0x7fff));
 	}
@@ -1343,7 +1343,7 @@ int qla24xx_async_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport, u8 opt)
 	mb[9] = vha->vp_idx;
 	mb[10] = opt;
 
-	mbx->u.mbx.in = (void *)pd;
+	mbx->u.mbx.in = pd;
 	mbx->u.mbx.in_dma = pd_dma;
 
 	sp->done = qla24xx_async_gpdb_sp_done;
@@ -4128,7 +4128,7 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
 		req = ha->req_q_map[que];
 		if (!req || !test_bit(que, ha->req_qid_map))
 			continue;
-		req->out_ptr = (void *)(req->ring + req->length);
+		req->out_ptr = (uint16_t *)(req->ring + req->length);
 		*req->out_ptr = 0;
 		for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++)
 			req->outstanding_cmds[cnt] = NULL;
@@ -4145,7 +4145,7 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
 		rsp = ha->rsp_q_map[que];
 		if (!rsp || !test_bit(que, ha->rsp_qid_map))
 			continue;
-		rsp->in_ptr = (void *)(rsp->ring + rsp->length);
+		rsp->in_ptr = (uint16_t *)(rsp->ring + rsp->length);
 		*rsp->in_ptr = 0;
 		/* Initialize response queue entries */
 		if (IS_QLAFX00(ha))
@@ -7446,7 +7446,7 @@ qla27xx_check_image_status_signature(struct qla27xx_image_status *image_status)
 static ulong
 qla27xx_image_status_checksum(struct qla27xx_image_status *image_status)
 {
-	uint32_t *p = (void *)image_status;
+	uint32_t *p = (uint32_t *)image_status;
 	uint n = sizeof(*image_status) / sizeof(*p);
 	uint32_t sum = 0;
 
@@ -7509,7 +7509,7 @@ qla28xx_get_aux_images(
 		goto check_sec_image;
 	}
 
-	qla24xx_read_flash_data(vha, (void *)&pri_aux_image_status,
+	qla24xx_read_flash_data(vha, (uint32_t *)&pri_aux_image_status,
 	    ha->flt_region_aux_img_status_pri,
 	    sizeof(pri_aux_image_status) >> 2);
 	qla27xx_print_image(vha, "Primary aux image", &pri_aux_image_status);
@@ -7542,7 +7542,7 @@ qla28xx_get_aux_images(
 		goto check_valid_image;
 	}
 
-	qla24xx_read_flash_data(vha, (void *)&sec_aux_image_status,
+	qla24xx_read_flash_data(vha, (uint32_t *)&sec_aux_image_status,
 	    ha->flt_region_aux_img_status_sec,
 	    sizeof(sec_aux_image_status) >> 2);
 	qla27xx_print_image(vha, "Secondary aux image", &sec_aux_image_status);
@@ -7607,7 +7607,7 @@ qla27xx_get_active_image(struct scsi_qla_host *vha,
 		goto check_sec_image;
 	}
 
-	if (qla24xx_read_flash_data(vha, (void *)(&pri_image_status),
+	if (qla24xx_read_flash_data(vha, (uint32_t *)&pri_image_status,
 	    ha->flt_region_img_status_pri, sizeof(pri_image_status) >> 2) !=
 	    QLA_SUCCESS) {
 		WARN_ON_ONCE(true);
@@ -7714,7 +7714,7 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 	ql_dbg(ql_dbg_init, vha, 0x008b,
 	    "FW: Loading firmware from flash (%x).\n", faddr);
 
-	dcode = (void *)req->ring;
+	dcode = (uint32_t *)req->ring;
 	qla24xx_read_flash_data(vha, dcode, faddr, 8);
 	if (qla24xx_risc_firmware_invalid(dcode)) {
 		ql_log(ql_log_fatal, vha, 0x008c,
@@ -7727,7 +7727,7 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 		return QLA_FUNCTION_FAILED;
 	}
 
-	dcode = (void *)req->ring;
+	dcode = (uint32_t *)req->ring;
 	*srisc_addr = 0;
 	segments = FA_RISC_CODE_SEGMENTS;
 	for (j = 0; j < segments; j++) {
@@ -7778,7 +7778,7 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 		fwdt->template = NULL;
 		fwdt->length = 0;
 
-		dcode = (void *)req->ring;
+		dcode = (uint32_t *)req->ring;
 		qla24xx_read_flash_data(vha, dcode, faddr, 7);
 		risc_size = be32_to_cpu(dcode[2]);
 		ql_dbg(ql_dbg_init, vha, 0x0161,
@@ -7970,7 +7970,7 @@ qla24xx_load_risc_blob(scsi_qla_host_t *vha, uint32_t *srisc_addr)
 		return QLA_FUNCTION_FAILED;
 	}
 
-	fwcode = (void *)blob->fw->data;
+	fwcode = (uint32_t *)blob->fw->data;
 	dcode = fwcode;
 	if (qla24xx_risc_firmware_invalid(dcode)) {
 		ql_log(ql_log_fatal, vha, 0x0093,
@@ -7982,7 +7982,7 @@ qla24xx_load_risc_blob(scsi_qla_host_t *vha, uint32_t *srisc_addr)
 		return QLA_FUNCTION_FAILED;
 	}
 
-	dcode = (void *)req->ring;
+	dcode = (uint32_t *)req->ring;
 	*srisc_addr = 0;
 	segments = FA_RISC_CODE_SEGMENTS;
 	for (j = 0; j < segments; j++) {
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 985cae37a8f8..e6ab5f07406d 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3038,7 +3038,7 @@ qla2x00_get_link_status(scsi_qla_host_t *vha, uint16_t loop_id,
 	int rval;
 	mbx_cmd_t mc;
 	mbx_cmd_t *mcp = &mc;
-	uint32_t *iter = (void *)stats;
+	uint32_t *iter = (uint32_t *)stats;
 	ushort dwords = offsetof(typeof(*stats), link_up_cnt)/sizeof(*iter);
 	struct qla_hw_data *ha = vha->hw;
 
@@ -3097,7 +3097,7 @@ qla24xx_get_isp_stats(scsi_qla_host_t *vha, struct link_statistics *stats,
 	int rval;
 	mbx_cmd_t mc;
 	mbx_cmd_t *mcp = &mc;
-	uint32_t *iter = (void *)stats;
+	uint32_t *iter = (uint32_t *)stats;
 	ushort dwords = sizeof(*stats)/sizeof(*iter);
 
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1088,
@@ -4736,7 +4736,7 @@ qla82xx_set_driver_version(scsi_qla_host_t *vha, char *version)
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x117b,
 	    "Entered %s.\n", __func__);
 
-	str = (void *)version;
+	str = (uint16_t *)version;
 	len = strlen(version);
 
 	mcp->mb[0] = MBC_SET_RNID_PARAMS;
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index d82e92da529a..15efe2f04b86 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -770,7 +770,7 @@ qla25xx_create_req_que(struct qla_hw_data *ha, uint16_t options,
 	req->req_q_in = &reg->isp25mq.req_q_in;
 	req->req_q_out = &reg->isp25mq.req_q_out;
 	req->max_q_depth = ha->req_q_map[0]->max_q_depth;
-	req->out_ptr = (void *)(req->ring + req->length);
+	req->out_ptr = (uint16_t *)(req->ring + req->length);
 	mutex_unlock(&ha->mq_lock);
 	ql_dbg(ql_dbg_multiq, base_vha, 0xc004,
 	    "ring_ptr=%p ring_index=%d, "
@@ -884,7 +884,7 @@ qla25xx_create_rsp_que(struct qla_hw_data *ha, uint16_t options,
 	reg = ISP_QUE_REG(ha, que_id);
 	rsp->rsp_q_in = &reg->isp25mq.rsp_q_in;
 	rsp->rsp_q_out = &reg->isp25mq.rsp_q_out;
-	rsp->in_ptr = (void *)(rsp->ring + rsp->length);
+	rsp->in_ptr = (uint16_t *)(rsp->ring + rsp->length);
 	mutex_unlock(&ha->mq_lock);
 	ql_dbg(ql_dbg_multiq, base_vha, 0xc00b,
 	    "options=%x id=%d rsp_q_in=%p rsp_q_out=%p\n",
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index c5be5163b663..908594c1541e 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -3212,7 +3212,7 @@ qlafx00_tm_iocb(srb_t *sp, struct tsk_mgmt_entry_fx00 *ptm_iocb)
 		    sizeof(struct scsi_lun));
 	}
 
-	memcpy((void *)ptm_iocb, &tm_iocb,
+	memcpy(ptm_iocb, &tm_iocb,
 	    sizeof(struct tsk_mgmt_entry_fx00));
 	wmb();
 }
@@ -3234,7 +3234,7 @@ qlafx00_abort_iocb(srb_t *sp, struct abort_iocb_entry_fx00 *pabt_iocb)
 	abt_iocb.tgt_id_sts = cpu_to_le16(sp->fcport->tgt_id);
 	abt_iocb.req_que_no = cpu_to_le16(req->id);
 
-	memcpy((void *)pabt_iocb, &abt_iocb,
+	memcpy(pabt_iocb, &abt_iocb,
 	    sizeof(struct abort_iocb_entry_fx00));
 	wmb();
 }
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index ad3aa1947e7d..6f20e20559bb 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -295,7 +295,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	sp->name = "nvme_ls";
 	sp->done = qla_nvme_sp_ls_done;
 	sp->put_fn = qla_nvme_release_ls_cmd_kref;
-	sp->priv = (void *)priv;
+	sp->priv = priv;
 	priv->sp = sp;
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
@@ -560,7 +560,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	init_waitqueue_head(&sp->nvme_ls_waitq);
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
-	sp->priv = (void *)priv;
+	sp->priv = priv;
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
 	sp->name = "nvme_cmd";
diff --git a/drivers/scsi/qla2xxx/qla_nx2.c b/drivers/scsi/qla2xxx/qla_nx2.c
index a46830a99968..50e57603ce3d 100644
--- a/drivers/scsi/qla2xxx/qla_nx2.c
+++ b/drivers/scsi/qla2xxx/qla_nx2.c
@@ -2965,7 +2965,7 @@ qla8044_minidump_pex_dma_read(struct scsi_qla_host *vha,
 
 		/* Prepare: Write pex-dma descriptor to MS memory. */
 		rval = qla8044_ms_mem_write_128b(vha,
-		    m_hdr->desc_card_addr, (void *)&dma_desc,
+		    m_hdr->desc_card_addr, (uint32_t *)&dma_desc,
 		    (sizeof(struct qla8044_pex_dma_descriptor)/16));
 		if (rval) {
 			ql_log(ql_log_warn, vha, 0xb14a,
@@ -2987,7 +2987,7 @@ qla8044_minidump_pex_dma_read(struct scsi_qla_host *vha,
 		read_size += chunk_size;
 	}
 
-	*d_ptr = (void *)data_ptr;
+	*d_ptr = (uint32_t *)data_ptr;
 
 error_exit:
 	if (rdmem_buffer)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2aa8ea6e1ceb..85c369fed9c5 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5915,7 +5915,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
 	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0181,
 	    "-------- ELS REQ -------\n");
 	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0182,
-	    (void *)purex, sizeof(*purex));
+	    purex, sizeof(*purex));
 
 	if (qla25xx_rdp_rsp_reduce_size(vha, purex)) {
 		rsp_payload_length =
@@ -6031,7 +6031,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
 		memset(sfp, 0, SFP_RTDI_LEN);
 		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa2, 0x60, 10, 0);
 		if (!rval) {
-			uint16_t *trx = (void *)sfp; /* already be16 */
+			uint16_t *trx = (uint16_t *)sfp; /* already be16 */
 			rsp_payload->sfp_diag_desc.temperature = trx[0];
 			rsp_payload->sfp_diag_desc.vcc = trx[1];
 			rsp_payload->sfp_diag_desc.tx_bias = trx[2];
@@ -6140,7 +6140,7 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
 		memset(sfp, 0, SFP_RTDI_LEN);
 		rval = qla2x00_read_sfp(vha, sfp_dma, sfp, 0xa2, 0, 64, 0);
 		if (!rval) {
-			uint16_t *trx = (void *)sfp; /* already be16 */
+			uint16_t *trx = (uint16_t *)sfp; /* already be16 */
 
 			/* Optical Element Descriptor, Temperature */
 			rsp_payload->optical_elmt_desc[0].high_alarm = trx[0];
@@ -6266,11 +6266,11 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
 	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0184,
 	    "-------- ELS RSP -------\n");
 	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0185,
-	    (void *)rsp_els, sizeof(*rsp_els));
+	    rsp_els, sizeof(*rsp_els));
 	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0186,
 	    "-------- ELS RSP PAYLOAD -------\n");
 	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0187,
-	    (void *)rsp_payload, rsp_payload_length);
+	    rsp_payload, rsp_payload_length);
 
 	rval = qla2x00_issue_iocb(vha, rsp_els, rsp_els_dma, 0);
 
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index da984d7552d5..749b0c197d31 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -553,7 +553,7 @@ qla2xxx_find_flt_start(scsi_qla_host_t *vha, uint32_t *start)
 	struct qla_hw_data *ha = vha->hw;
 	struct req_que *req = ha->req_q_map[0];
 	struct qla_flt_location *fltl = (void *)req->ring;
-	uint32_t *dcode = (void *)req->ring;
+	uint32_t *dcode = (uint32_t *)req->ring;
 	uint8_t *buf = (void *)req->ring, *bcode,  last_image;
 
 	/*
@@ -610,7 +610,7 @@ qla2xxx_find_flt_start(scsi_qla_host_t *vha, uint32_t *start)
 	if (memcmp(fltl->sig, "QFLT", 4))
 		goto end;
 
-	wptr = (void *)req->ring;
+	wptr = (uint16_t *)req->ring;
 	cnt = sizeof(*fltl) / sizeof(*wptr);
 	for (chksum = 0; cnt--; wptr++)
 		chksum += le16_to_cpu(*wptr);
@@ -682,7 +682,7 @@ qla2xxx_get_flt_info(scsi_qla_host_t *vha, uint32_t flt_addr)
 
 	ha->flt_region_flt = flt_addr;
 	wptr = (uint16_t *)ha->flt;
-	ha->isp_ops->read_optrom(vha, (void *)flt, flt_addr << 2,
+	ha->isp_ops->read_optrom(vha, flt, flt_addr << 2,
 	    (sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE));
 
 	if (le16_to_cpu(*wptr) == 0xffff)
@@ -949,7 +949,7 @@ qla2xxx_get_fdt_info(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	struct req_que *req = ha->req_q_map[0];
 	uint16_t cnt, chksum;
-	uint16_t *wptr = (void *)req->ring;
+	uint16_t *wptr = (uint16_t *)req->ring;
 	struct qla_fdt_layout *fdt = (struct qla_fdt_layout *)req->ring;
 	uint8_t	man_id, flash_id;
 	uint16_t mid = 0, fid = 0;
@@ -2610,7 +2610,7 @@ qla24xx_read_optrom_data(struct scsi_qla_host *vha, void *buf,
 	set_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
 
 	/* Go with read. */
-	qla24xx_read_flash_data(vha, (void *)buf, offset >> 2, length >> 2);
+	qla24xx_read_flash_data(vha, buf, offset >> 2, length >> 2);
 
 	/* Resume HBA. */
 	clear_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
@@ -3528,7 +3528,7 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
 
 	memset(ha->gold_fw_version, 0, sizeof(ha->gold_fw_version));
 	faddr = ha->flt_region_gold_fw;
-	qla24xx_read_flash_data(vha, (void *)dcode, ha->flt_region_gold_fw, 8);
+	qla24xx_read_flash_data(vha, dcode, ha->flt_region_gold_fw, 8);
 	if (qla24xx_risc_firmware_invalid(dcode)) {
 		ql_log(ql_log_warn, vha, 0x0056,
 		    "Unrecognized golden fw at %#x.\n", faddr);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index f7425875f4f9..77f976555159 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3885,7 +3885,7 @@ static void *qlt_ctio_to_cmd(struct scsi_qla_host *vha,
 			return NULL;
 		}
 
-		cmd = (void *) req->outstanding_cmds[h];
+		cmd = req->outstanding_cmds[h];
 		if (unlikely(cmd == NULL)) {
 			ql_dbg(ql_dbg_async, vha, 0xe053,
 			    "qla_target(%d): Suspicious: unable to find the command with handle %x req->id %d rsp->id %d\n",
@@ -5932,7 +5932,7 @@ void qlt_async_event(uint16_t code, struct scsi_qla_host *vha,
 		    le16_to_cpu(mailbox[2]), le16_to_cpu(mailbox[3]));
 		if (tgt->link_reinit_iocb_pending) {
 			qlt_send_notify_ack(ha->base_qpair,
-			    (void *)&tgt->link_reinit_iocb,
+			    &tgt->link_reinit_iocb,
 			    0, 0, 0, 0, 0, 0);
 			tgt->link_reinit_iocb_pending = 0;
 		}
