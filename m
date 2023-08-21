Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72C07829C3
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Aug 2023 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjHUNBB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Aug 2023 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjHUNBA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Aug 2023 09:01:00 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC40E6
        for <linux-scsi@vger.kernel.org>; Mon, 21 Aug 2023 06:00:53 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KNxrdl023600
        for <linux-scsi@vger.kernel.org>; Mon, 21 Aug 2023 06:00:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Ycyw9d2YFnPgEzWVk4tnCPK59oGMHibDtalqECKLYwQ=;
 b=GxjEzUayFgBKOHk56lB33XRspJVj0uiu/+HR5VK186QGJOEetW/n/8i9Q1Sa6rNI6pwN
 v/tsgXpBHHoVnrIetTwZV/jcz6yyZ0lBeqTF8Tp+MzWGHx1j+F208yij80kbVTQfuhWr
 2ddrJUZKThHzbFwY0WQPMMcBoc5+gKUphUFqRjJbEGrsp1PELiUH7fKpr52TlpsFWboI
 nl9A7oEdLTzJP6Ga2vQ6s/mEbXqD7ZoTkh4iQhMbtA8rAh969QgdZXILAaKNrtk3wGUx
 p0Qfy5UZ39OUgudmW7FIwWgZi7N4yLiAuWhDYEOR+E05eyh8lnIZtEdhTgS+njy3gywG jw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sju3qmyjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 21 Aug 2023 06:00:53 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 21 Aug
 2023 06:00:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 21 Aug 2023 06:00:51 -0700
Received: from localhost.marvell.com (unknown [10.30.46.195])
        by maili.marvell.com (Postfix) with ESMTP id 70D8C3F7092;
        Mon, 21 Aug 2023 06:00:49 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH v3 1/9] qla2xxx: Add Unsolicited LS Request and Response Support for NVMe
Date:   Mon, 21 Aug 2023 18:30:37 +0530
Message-ID: <20230821130045.34850-2-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20230821130045.34850-1-njavali@marvell.com>
References: <20230821130045.34850-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Z0dCXKbvOjZA7ejSqUe2wmvSTwEprxps
X-Proofpoint-ORIG-GUID: Z0dCXKbvOjZA7ejSqUe2wmvSTwEprxps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Manish Rangankar <mrangankar@marvell.com>

Introduce infrastructure in the driver to support the processing
of unsolicited LS (Link Service) requests. This will involve the
utilization of a new pass-up of unsolicited FC-NVMe request iocb
interface. Unsolicited requests will be submitted to the NVMe
transport layer through nvme_fc_rcv_ls_req(). Any received LS
responses, which are sent using xmt_ls_rsp(), will be forwarded
to the firmware through the existing Pass-Through IOCB interface,
responsible for sending FC-NVMe Link Service requests and responses.

Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
v3:
- Change description of the patch based on review comments
  from Christoph Hellwig
v2:
- Remove extra line from qla_iocb.c
- Fix comment style for qla2xxx_process_purls_pkt()
- Add Reviewed-by tag

 drivers/scsi/qla2xxx/qla_dbg.c  |   5 +-
 drivers/scsi/qla2xxx/qla_dbg.h  |   1 +
 drivers/scsi/qla2xxx/qla_def.h  |  34 ++-
 drivers/scsi/qla2xxx/qla_gbl.h  |  14 +-
 drivers/scsi/qla2xxx/qla_init.c |   1 +
 drivers/scsi/qla2xxx/qla_iocb.c |  27 ++-
 drivers/scsi/qla2xxx/qla_isr.c  | 146 +++++++++++-
 drivers/scsi/qla2xxx/qla_nvme.c | 401 +++++++++++++++++++++++++++++++-
 drivers/scsi/qla2xxx/qla_nvme.h |  17 +-
 drivers/scsi/qla2xxx/qla_os.c   |  24 +-
 include/linux/nvme-fc-driver.h  |   6 +-
 11 files changed, 642 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index d7e8454304ce..4d104425146b 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -12,9 +12,8 @@
  * ----------------------------------------------------------------------
  * | Module Init and Probe        |       0x0199       |                |
  * | Mailbox commands             |       0x1206       | 0x11a5-0x11ff	|
- * | Device Discovery             |       0x2134       | 0x210e-0x2115  |
- * |                              |                    | 0x211c-0x2128  |
- * |                              |                    | 0x212c-0x2134  |
+ * | Device Discovery             |       0x2134       | 0x2112-0x2115  |
+ * |                              |                    | 0x2127-0x2128  |
  * | Queue Command and IO tracing |       0x3074       | 0x300b         |
  * |                              |                    | 0x3027-0x3028  |
  * |                              |                    | 0x303d-0x3041  |
diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 70482b55d240..54f0a412226f 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -368,6 +368,7 @@ ql_log_qp(uint32_t, struct qla_qpair *, int32_t, const char *fmt, ...);
 #define ql_dbg_tgt_tmr	0x00001000 /* Target mode task management */
 #define ql_dbg_tgt_dif  0x00000800 /* Target mode dif */
 #define ql_dbg_edif	0x00000400 /* edif and purex debug */
+#define ql_dbg_unsol	0x00000100 /* Unsolicited path debug */
 
 extern int qla27xx_dump_mpi_ram(struct qla_hw_data *, uint32_t, uint32_t *,
 	uint32_t, void **);
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index b3b1df34afd3..806d08f4f310 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -346,6 +346,12 @@ struct name_list_extended {
 	u8			sent;
 };
 
+struct qla_nvme_fc_rjt {
+	struct fcnvme_ls_rjt *c;
+	dma_addr_t  cdma;
+	u16 size;
+};
+
 struct els_reject {
 	struct fc_els_ls_rjt *c;
 	dma_addr_t  cdma;
@@ -503,6 +509,20 @@ struct ct_arg {
 	port_id_t	id;
 };
 
+struct qla_nvme_lsrjt_pt_arg {
+	struct fc_port *fcport;
+	u8 opcode;
+	u8 vp_idx;
+	u8 reason;
+	u8 explanation;
+	__le16 nport_handle;
+	u16 control_flags;
+	__le16 ox_id;
+	__le32 xchg_address;
+	u32 tx_byte_count, rx_byte_count;
+	dma_addr_t tx_addr, rx_addr;
+};
+
 /*
  * SRB extensions.
  */
@@ -611,13 +631,16 @@ struct srb_iocb {
 			void *desc;
 
 			/* These are only used with ls4 requests */
-			int cmd_len;
-			int rsp_len;
+			__le32 cmd_len;
+			__le32 rsp_len;
 			dma_addr_t cmd_dma;
 			dma_addr_t rsp_dma;
 			enum nvmefc_fcp_datadir dir;
 			uint32_t dl;
 			uint32_t timeout_sec;
+			__le32 exchange_address;
+			__le16 nport_handle;
+			__le16 ox_id;
 			struct	list_head   entry;
 		} nvme;
 		struct {
@@ -707,6 +730,10 @@ typedef struct srb {
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
 	unsigned int start_timer:1;
+	unsigned int abort:1;
+	unsigned int aborted:1;
+	unsigned int completed:1;
+	unsigned int unsol_rsp:1;
 
 	uint32_t handle;
 	uint16_t flags;
@@ -2542,6 +2569,7 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
+	struct list_head unsol_ctx_head;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -4801,6 +4829,7 @@ struct qla_hw_data {
 	struct els_reject elsrej;
 	u8 edif_post_stop_cnt_down;
 	struct qla_vp_map *vp_map;
+	struct qla_nvme_fc_rjt lsrjt;
 };
 
 #define RX_ELS_SIZE (roundup(sizeof(struct enode) + ELS_MAX_PAYLOAD, SMP_CACHE_BYTES))
@@ -4833,6 +4862,7 @@ struct active_regions {
  * is variable) starting at "iocb".
  */
 struct purex_item {
+	void *purls_context;
 	struct list_head list;
 	struct scsi_qla_host *vha;
 	void (*process_item)(struct scsi_qla_host *vha,
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 33fba9d62969..911e9adf41d3 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -611,7 +611,11 @@ qla2xxx_msix_rsp_q_hs(int irq, void *dev_id);
 fc_port_t *qla2x00_find_fcport_by_loopid(scsi_qla_host_t *, uint16_t);
 fc_port_t *qla2x00_find_fcport_by_wwpn(scsi_qla_host_t *, u8 *, u8);
 fc_port_t *qla2x00_find_fcport_by_nportid(scsi_qla_host_t *, port_id_t *, u8);
-void __qla_consume_iocb(struct scsi_qla_host *vha, void **pkt, struct rsp_que **rsp);
+void qla24xx_queue_purex_item(scsi_qla_host_t *, struct purex_item *,
+			      void (*process_item)(struct scsi_qla_host *,
+			      struct purex_item *));
+void __qla_consume_iocb(struct scsi_qla_host *, void **, struct rsp_que **);
+void qla2xxx_process_purls_iocb(void **pkt, struct rsp_que **rsp);
 
 /*
  * Global Function Prototypes in qla_sup.c source file.
@@ -674,9 +678,11 @@ extern int qla2xxx_get_vpd_field(scsi_qla_host_t *, char *, char *, size_t);
 extern void qla2xxx_flash_npiv_conf(scsi_qla_host_t *);
 extern int qla24xx_read_fcp_prio_cfg(scsi_qla_host_t *);
 extern int qla2x00_mailbox_passthru(struct bsg_job *bsg_job);
-int __qla_copy_purex_to_buffer(struct scsi_qla_host *vha, void **pkt,
-	struct rsp_que **rsp, u8 *buf, u32 buf_len);
-
+int qla2x00_sys_ld_info(struct bsg_job *bsg_job);
+int __qla_copy_purex_to_buffer(struct scsi_qla_host *, void **,
+	struct rsp_que **, u8 *, u32);
+struct purex_item *qla27xx_copy_multiple_pkt(struct scsi_qla_host *vha,
+	void **pkt, struct rsp_que **rsp, bool is_purls, bool byte_order);
 int qla_mailbox_passthru(scsi_qla_host_t *vha, uint16_t *mbx_in,
 			 uint16_t *mbx_out);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 059175f2c8f5..2a9fbb3e12c9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5554,6 +5554,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
+	INIT_LIST_HEAD(&fcport->unsol_ctx_head);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 1c6e300ed3ab..5124907a5d8f 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3766,21 +3766,28 @@ qla_nvme_ls(srb_t *sp, struct pt_ls4_request *cmd_pkt)
 	nvme = &sp->u.iocb_cmd;
 	cmd_pkt->entry_type = PT_LS4_REQUEST;
 	cmd_pkt->entry_count = 1;
-	cmd_pkt->control_flags = cpu_to_le16(CF_LS4_ORIGINATOR << CF_LS4_SHIFT);
-
 	cmd_pkt->timeout = cpu_to_le16(nvme->u.nvme.timeout_sec);
-	cmd_pkt->nport_handle = cpu_to_le16(sp->fcport->loop_id);
 	cmd_pkt->vp_index = sp->fcport->vha->vp_idx;
 
+	if (sp->unsol_rsp) {
+		cmd_pkt->control_flags =
+				cpu_to_le16(CF_LS4_RESPONDER << CF_LS4_SHIFT);
+		cmd_pkt->nport_handle = nvme->u.nvme.nport_handle;
+		cmd_pkt->exchange_address = nvme->u.nvme.exchange_address;
+	} else {
+		cmd_pkt->control_flags =
+				cpu_to_le16(CF_LS4_ORIGINATOR << CF_LS4_SHIFT);
+		cmd_pkt->nport_handle = cpu_to_le16(sp->fcport->loop_id);
+		cmd_pkt->rx_dseg_count = cpu_to_le16(1);
+		cmd_pkt->rx_byte_count = nvme->u.nvme.rsp_len;
+		cmd_pkt->dsd[1].length  = nvme->u.nvme.rsp_len;
+		put_unaligned_le64(nvme->u.nvme.rsp_dma, &cmd_pkt->dsd[1].address);
+	}
+
 	cmd_pkt->tx_dseg_count = cpu_to_le16(1);
-	cmd_pkt->tx_byte_count = cpu_to_le32(nvme->u.nvme.cmd_len);
-	cmd_pkt->dsd[0].length = cpu_to_le32(nvme->u.nvme.cmd_len);
+	cmd_pkt->tx_byte_count = nvme->u.nvme.cmd_len;
+	cmd_pkt->dsd[0].length = nvme->u.nvme.cmd_len;
 	put_unaligned_le64(nvme->u.nvme.cmd_dma, &cmd_pkt->dsd[0].address);
-
-	cmd_pkt->rx_dseg_count = cpu_to_le16(1);
-	cmd_pkt->rx_byte_count = cpu_to_le32(nvme->u.nvme.rsp_len);
-	cmd_pkt->dsd[1].length = cpu_to_le32(nvme->u.nvme.rsp_len);
-	put_unaligned_le64(nvme->u.nvme.rsp_dma, &cmd_pkt->dsd[1].address);
 }
 
 static void
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 1f42a413b598..867025c89909 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -823,6 +823,135 @@ qla83xx_handle_8200_aen(scsi_qla_host_t *vha, uint16_t *mb)
 	}
 }
 
+/**
+ * qla27xx_copy_multiple_pkt() - Copy over purex/purls packets that can
+ * span over multiple IOCBs.
+ * @vha: SCSI driver HA context
+ * @pkt: ELS packet
+ * @rsp: Response queue
+ * @is_purls: True, for Unsolicited Received FC-NVMe LS rsp IOCB
+ *            false, for Unsolicited Received ELS IOCB
+ * @byte_order: True, to change the byte ordering of iocb payload
+ */
+struct purex_item *
+qla27xx_copy_multiple_pkt(struct scsi_qla_host *vha, void **pkt,
+			  struct rsp_que **rsp, bool is_purls,
+			  bool byte_order)
+{
+	struct purex_entry_24xx *purex = NULL;
+	struct pt_ls4_rx_unsol *purls = NULL;
+	struct rsp_que *rsp_q = *rsp;
+	sts_cont_entry_t *new_pkt;
+	uint16_t no_bytes = 0, total_bytes = 0, pending_bytes = 0;
+	uint16_t buffer_copy_offset = 0, payload_size = 0;
+	uint16_t entry_count, entry_count_remaining;
+	struct purex_item *item;
+	void *iocb_pkt = NULL;
+
+	if (is_purls) {
+		purls = *pkt;
+		total_bytes = (le16_to_cpu(purls->frame_size) & 0x0FFF) -
+			      PURX_ELS_HEADER_SIZE;
+		entry_count = entry_count_remaining = purls->entry_count;
+		payload_size = sizeof(purls->payload);
+	} else {
+		purex = *pkt;
+		total_bytes = (le16_to_cpu(purex->frame_size) & 0x0FFF) -
+			      PURX_ELS_HEADER_SIZE;
+		entry_count = entry_count_remaining = purex->entry_count;
+		payload_size = sizeof(purex->els_frame_payload);
+	}
+
+	pending_bytes = total_bytes;
+	no_bytes = (pending_bytes > payload_size) ? payload_size :
+		   pending_bytes;
+	ql_dbg(ql_dbg_async, vha, 0x509a,
+	       "%s LS, frame_size 0x%x, entry count %d\n",
+	       (is_purls ? "PURLS" : "FPIN"), total_bytes, entry_count);
+
+	item = qla24xx_alloc_purex_item(vha, total_bytes);
+	if (!item)
+		return item;
+
+	iocb_pkt = &item->iocb;
+
+	if (is_purls)
+		memcpy(iocb_pkt, &purls->payload[0], no_bytes);
+	else
+		memcpy(iocb_pkt, &purex->els_frame_payload[0], no_bytes);
+	buffer_copy_offset += no_bytes;
+	pending_bytes -= no_bytes;
+	--entry_count_remaining;
+
+	if (is_purls)
+		((response_t *)purls)->signature = RESPONSE_PROCESSED;
+	else
+		((response_t *)purex)->signature = RESPONSE_PROCESSED;
+	wmb();
+
+	do {
+		while ((total_bytes > 0) && (entry_count_remaining > 0)) {
+			if (rsp_q->ring_ptr->signature == RESPONSE_PROCESSED) {
+				ql_dbg(ql_dbg_async, vha, 0x5084,
+				       "Ran out of IOCBs, partial data 0x%x\n",
+				       buffer_copy_offset);
+				cpu_relax();
+				continue;
+			}
+
+			new_pkt = (sts_cont_entry_t *)rsp_q->ring_ptr;
+			*pkt = new_pkt;
+
+			if (new_pkt->entry_type != STATUS_CONT_TYPE) {
+				ql_log(ql_log_warn, vha, 0x507a,
+				       "Unexpected IOCB type, partial data 0x%x\n",
+				       buffer_copy_offset);
+				break;
+			}
+
+			rsp_q->ring_index++;
+			if (rsp_q->ring_index == rsp_q->length) {
+				rsp_q->ring_index = 0;
+				rsp_q->ring_ptr = rsp_q->ring;
+			} else {
+				rsp_q->ring_ptr++;
+			}
+			no_bytes = (pending_bytes > sizeof(new_pkt->data)) ?
+				sizeof(new_pkt->data) : pending_bytes;
+			if ((buffer_copy_offset + no_bytes) <= total_bytes) {
+				memcpy(((uint8_t *)iocb_pkt + buffer_copy_offset),
+				       new_pkt->data, no_bytes);
+				buffer_copy_offset += no_bytes;
+				pending_bytes -= no_bytes;
+				--entry_count_remaining;
+			} else {
+				ql_log(ql_log_warn, vha, 0x5044,
+				       "Attempt to copy more that we got, optimizing..%x\n",
+				       buffer_copy_offset);
+				memcpy(((uint8_t *)iocb_pkt + buffer_copy_offset),
+				       new_pkt->data,
+				       total_bytes - buffer_copy_offset);
+			}
+
+			((response_t *)new_pkt)->signature = RESPONSE_PROCESSED;
+			wmb();
+		}
+
+		if (pending_bytes != 0 || entry_count_remaining != 0) {
+			ql_log(ql_log_fatal, vha, 0x508b,
+			       "Dropping partial FPIN, underrun bytes = 0x%x, entry cnts 0x%x\n",
+			       total_bytes, entry_count_remaining);
+			qla24xx_free_purex_item(item);
+			return NULL;
+		}
+	} while (entry_count_remaining > 0);
+
+	if (byte_order)
+		host_to_fcp_swap((uint8_t *)&item->iocb, total_bytes);
+
+	return item;
+}
+
 int
 qla2x00_is_a_vp_did(scsi_qla_host_t *vha, uint32_t rscn_entry)
 {
@@ -958,7 +1087,7 @@ qla24xx_alloc_purex_item(scsi_qla_host_t *vha, uint16_t size)
 	return item;
 }
 
-static void
+void
 qla24xx_queue_purex_item(scsi_qla_host_t *vha, struct purex_item *pkt,
 			 void (*process_item)(struct scsi_qla_host *vha,
 					      struct purex_item *pkt))
@@ -3811,6 +3940,7 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 	struct qla_hw_data *ha = vha->hw;
 	struct purex_entry_24xx *purex_entry;
 	struct purex_item *pure_item;
+	struct pt_ls4_rx_unsol *p;
 	u16 rsp_in = 0, cur_ring_index;
 	int is_shadow_hba;
 
@@ -3983,7 +4113,19 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 			qla28xx_sa_update_iocb_entry(vha, rsp->req,
 				(struct sa_update_28xx *)pkt);
 			break;
-
+		case PT_LS4_UNSOL:
+			p = (void *)pkt;
+			if (qla_chk_cont_iocb_avail(vha, rsp, (response_t *)pkt, rsp_in)) {
+				rsp->ring_ptr = (response_t *)pkt;
+				rsp->ring_index = cur_ring_index;
+
+				ql_dbg(ql_dbg_init, vha, 0x2124,
+				       "Defer processing UNSOL LS req opcode %#x...\n",
+				       p->payload[0]);
+				return;
+			}
+			qla2xxx_process_purls_iocb((void **)&pkt, &rsp);
+			break;
 		default:
 			/* Type Not Supported. */
 			ql_dbg(ql_dbg_async, vha, 0x5042,
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 9941b38eac93..1a31e877e6cb 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -12,6 +12,26 @@
 #include <linux/blk-mq.h>
 
 static struct nvme_fc_port_template qla_nvme_fc_transport;
+static int qla_nvme_ls_reject_iocb(struct scsi_qla_host *vha,
+				   struct qla_qpair *qp,
+				   struct qla_nvme_lsrjt_pt_arg *a,
+				   bool is_xchg_terminate);
+
+struct qla_nvme_unsol_ctx {
+	struct list_head elem;
+	struct scsi_qla_host *vha;
+	struct fc_port *fcport;
+	struct srb *sp;
+	struct nvmefc_ls_rsp lsrsp;
+	struct nvmefc_ls_rsp *fd_rsp;
+	struct work_struct lsrsp_work;
+	struct work_struct abort_work;
+	__le32 exchange_address;
+	__le16 nport_handle;
+	__le16 ox_id;
+	int comp_status;
+	spinlock_t cmd_lock;
+};
 
 int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 {
@@ -216,6 +236,55 @@ static void qla_nvme_sp_ls_done(srb_t *sp, int res)
 	schedule_work(&priv->ls_work);
 }
 
+static void qla_nvme_release_lsrsp_cmd_kref(struct kref *kref)
+{
+	struct srb *sp = container_of(kref, struct srb, cmd_kref);
+	struct qla_nvme_unsol_ctx *uctx = sp->priv;
+	struct nvmefc_ls_rsp *fd_rsp;
+	unsigned long flags;
+
+	if (!uctx) {
+		qla2x00_rel_sp(sp);
+		return;
+	}
+
+	spin_lock_irqsave(&uctx->cmd_lock, flags);
+	uctx->sp = NULL;
+	sp->priv = NULL;
+	spin_unlock_irqrestore(&uctx->cmd_lock, flags);
+
+	fd_rsp = uctx->fd_rsp;
+
+	list_del(&uctx->elem);
+
+	fd_rsp->done(fd_rsp);
+	kfree(uctx);
+	qla2x00_rel_sp(sp);
+}
+
+static void qla_nvme_lsrsp_complete(struct work_struct *work)
+{
+	struct qla_nvme_unsol_ctx *uctx =
+		container_of(work, struct qla_nvme_unsol_ctx, lsrsp_work);
+
+	kref_put(&uctx->sp->cmd_kref, qla_nvme_release_lsrsp_cmd_kref);
+}
+
+static void qla_nvme_sp_lsrsp_done(srb_t *sp, int res)
+{
+	struct qla_nvme_unsol_ctx *uctx = sp->priv;
+
+	if (WARN_ON_ONCE(kref_read(&sp->cmd_kref) == 0))
+		return;
+
+	if (res)
+		res = -EINVAL;
+
+	uctx->comp_status = res;
+	INIT_WORK(&uctx->lsrsp_work, qla_nvme_lsrsp_complete);
+	schedule_work(&uctx->lsrsp_work);
+}
+
 /* it assumed that QPair lock is held. */
 static void qla_nvme_sp_done(srb_t *sp, int res)
 {
@@ -288,6 +357,92 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	kref_put(&sp->cmd_kref, sp->put_fn);
 }
 
+static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
+			       struct nvme_fc_remote_port *rport,
+			       struct nvmefc_ls_rsp *fd_resp)
+{
+	struct qla_nvme_unsol_ctx *uctx = container_of(fd_resp,
+				struct qla_nvme_unsol_ctx, lsrsp);
+	struct qla_nvme_rport *qla_rport = rport->private;
+	fc_port_t *fcport = qla_rport->fcport;
+	struct scsi_qla_host *vha = uctx->vha;
+	struct qla_hw_data *ha = vha->hw;
+	struct qla_nvme_lsrjt_pt_arg a;
+	struct srb_iocb *nvme;
+	srb_t *sp;
+	int rval = QLA_FUNCTION_FAILED;
+	uint8_t cnt = 0;
+
+	if (!fcport || fcport->deleted)
+		goto out;
+
+	if (!ha->flags.fw_started)
+		goto out;
+
+	/* Alloc SRB structure */
+	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
+	if (!sp)
+		goto out;
+
+	sp->type = SRB_NVME_LS;
+	sp->name = "nvme_ls";
+	sp->done = qla_nvme_sp_lsrsp_done;
+	sp->put_fn = qla_nvme_release_lsrsp_cmd_kref;
+	sp->priv = (void *)uctx;
+	sp->unsol_rsp = 1;
+	uctx->sp = sp;
+	spin_lock_init(&uctx->cmd_lock);
+	nvme = &sp->u.iocb_cmd;
+	uctx->fd_rsp = fd_resp;
+	nvme->u.nvme.desc = fd_resp;
+	nvme->u.nvme.dir = 0;
+	nvme->u.nvme.dl = 0;
+	nvme->u.nvme.timeout_sec = 0;
+	nvme->u.nvme.cmd_dma = fd_resp->rspdma;
+	nvme->u.nvme.cmd_len = fd_resp->rsplen;
+	nvme->u.nvme.rsp_len = 0;
+	nvme->u.nvme.rsp_dma = 0;
+	nvme->u.nvme.exchange_address = uctx->exchange_address;
+	nvme->u.nvme.nport_handle = uctx->nport_handle;
+	nvme->u.nvme.ox_id = uctx->ox_id;
+	dma_sync_single_for_device(&ha->pdev->dev, nvme->u.nvme.cmd_dma,
+				   le32_to_cpu(fd_resp->rsplen), DMA_TO_DEVICE);
+
+	ql_dbg(ql_dbg_unsol, vha, 0x2122,
+	       "Unsol lsreq portid=%06x %8phC exchange_address 0x%x ox_id 0x%x hdl 0x%x\n",
+	       fcport->d_id.b24, fcport->port_name, uctx->exchange_address,
+	       uctx->ox_id, uctx->nport_handle);
+retry:
+	rval = qla2x00_start_sp(sp);
+	switch (rval) {
+	case QLA_SUCCESS:
+		break;
+	case EAGAIN:
+		msleep(PURLS_MSLEEP_INTERVAL);
+		cnt++;
+		if (cnt < PURLS_RETRY_COUNT)
+			goto retry;
+
+		fallthrough;
+	default:
+		ql_dbg(ql_log_warn, vha, 0x2123,
+		       "Failed to xmit Unsol ls response = %d\n", rval);
+		rval = -EIO;
+		qla2x00_rel_sp(sp);
+		goto out;
+	}
+
+	return 0;
+out:
+	memset((void *)&a, 0, sizeof(a));
+	a.vp_idx = vha->vp_idx;
+	a.nport_handle = uctx->nport_handle;
+	a.xchg_address = uctx->exchange_address;
+	qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
+	kfree(uctx);
+	return rval;
+}
+
 static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
     struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
 {
@@ -355,7 +510,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	nvme->u.nvme.timeout_sec = fd->timeout;
 	nvme->u.nvme.cmd_dma = fd->rqstdma;
 	dma_sync_single_for_device(&ha->pdev->dev, nvme->u.nvme.cmd_dma,
-	    fd->rqstlen, DMA_TO_DEVICE);
+	    le32_to_cpu(fd->rqstlen), DMA_TO_DEVICE);
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
@@ -720,6 +875,7 @@ static struct nvme_fc_port_template qla_nvme_fc_transport = {
 	.ls_abort	= qla_nvme_ls_abort,
 	.fcp_io		= qla_nvme_post_cmd,
 	.fcp_abort	= qla_nvme_fcp_abort,
+	.xmt_ls_rsp	= qla_nvme_xmt_ls_rsp,
 	.map_queues	= qla_nvme_map_queues,
 	.max_hw_queues  = DEF_NVME_HW_QUEUES,
 	.max_sgl_segments = 1024,
@@ -924,3 +1080,246 @@ inline void qla_wait_nvme_release_cmd_kref(srb_t *orig_sp)
 		return;
 	kref_put(&orig_sp->cmd_kref, orig_sp->put_fn);
 }
+
+static void qla_nvme_fc_format_rjt(void *buf, u8 ls_cmd, u8 reason,
+				   u8 explanation, u8 vendor)
+{
+	struct fcnvme_ls_rjt *rjt = buf;
+
+	rjt->w0.ls_cmd = FCNVME_LSDESC_RQST;
+	rjt->desc_list_len = fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_rjt));
+	rjt->rqst.desc_tag = cpu_to_be32(FCNVME_LSDESC_RQST);
+	rjt->rqst.desc_len =
+		fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rqst));
+	rjt->rqst.w0.ls_cmd = ls_cmd;
+	rjt->rjt.desc_tag = cpu_to_be32(FCNVME_LSDESC_RJT);
+	rjt->rjt.desc_len = fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rjt));
+	rjt->rjt.reason_code = reason;
+	rjt->rjt.reason_explanation = explanation;
+	rjt->rjt.vendor = vendor;
+}
+
+static void qla_nvme_lsrjt_pt_iocb(struct scsi_qla_host *vha,
+				   struct pt_ls4_request *lsrjt_iocb,
+				   struct qla_nvme_lsrjt_pt_arg *a)
+{
+	lsrjt_iocb->entry_type = PT_LS4_REQUEST;
+	lsrjt_iocb->entry_count = 1;
+	lsrjt_iocb->sys_define = 0;
+	lsrjt_iocb->entry_status = 0;
+	lsrjt_iocb->handle = QLA_SKIP_HANDLE;
+	lsrjt_iocb->nport_handle = a->nport_handle;
+	lsrjt_iocb->exchange_address = a->xchg_address;
+	lsrjt_iocb->vp_index = a->vp_idx;
+
+	lsrjt_iocb->control_flags = cpu_to_le16(a->control_flags);
+
+	put_unaligned_le64(a->tx_addr, &lsrjt_iocb->dsd[0].address);
+	lsrjt_iocb->dsd[0].length = cpu_to_le32(a->tx_byte_count);
+	lsrjt_iocb->tx_dseg_count = cpu_to_le16(1);
+	lsrjt_iocb->tx_byte_count = cpu_to_le32(a->tx_byte_count);
+
+	put_unaligned_le64(a->rx_addr, &lsrjt_iocb->dsd[1].address);
+	lsrjt_iocb->dsd[1].length = 0;
+	lsrjt_iocb->rx_dseg_count = 0;
+	lsrjt_iocb->rx_byte_count = 0;
+}
+
+static int
+qla_nvme_ls_reject_iocb(struct scsi_qla_host *vha, struct qla_qpair *qp,
+			struct qla_nvme_lsrjt_pt_arg *a, bool is_xchg_terminate)
+{
+	struct pt_ls4_request *lsrjt_iocb;
+
+	lsrjt_iocb = __qla2x00_alloc_iocbs(qp, NULL);
+	if (!lsrjt_iocb) {
+		ql_log(ql_log_warn, vha, 0x210e,
+		       "qla2x00_alloc_iocbs failed.\n");
+		return QLA_FUNCTION_FAILED;
+	}
+
+	if (!is_xchg_terminate) {
+		qla_nvme_fc_format_rjt((void *)vha->hw->lsrjt.c, a->opcode,
+				       a->reason, a->explanation, 0);
+
+		a->tx_byte_count = sizeof(struct fcnvme_ls_rjt);
+		a->tx_addr = vha->hw->lsrjt.cdma;
+		a->control_flags = CF_LS4_RESPONDER << CF_LS4_SHIFT;
+
+		ql_dbg(ql_dbg_unsol, vha, 0x211f,
+		       "Sending nvme fc ls reject ox_id %04x op %04x\n",
+		       a->ox_id, a->opcode);
+		ql_dump_buffer(ql_dbg_unsol + ql_dbg_verbose, vha, 0x210f,
+			       vha->hw->lsrjt.c, sizeof(*vha->hw->lsrjt.c));
+	} else {
+		a->tx_byte_count = 0;
+		a->control_flags = CF_LS4_RESPONDER_TERM << CF_LS4_SHIFT;
+		ql_dbg(ql_dbg_unsol, vha, 0x2110,
+		       "Terminate nvme ls xchg 0x%x\n", a->xchg_address);
+	}
+
+	qla_nvme_lsrjt_pt_iocb(vha, lsrjt_iocb, a);
+	/* flush iocb to mem before notifying hw doorbell */
+	wmb();
+	qla2x00_start_iocbs(vha, qp->req);
+	return 0;
+}
+
+/*
+ * qla2xxx_process_purls_pkt() - Pass-up Unsolicited
+ * Received FC-NVMe Link Service pkt to nvme_fc_rcv_ls_req().
+ * LLDD need to provide memory for response buffer, which
+ * will be used to reference the exchange corresponding
+ * to the LS when issuing an ls response. LLDD will have to free
+ * response buffer in lport->ops->xmt_ls_rsp().
+ *
+ * @vha: SCSI qla host
+ * @item: ptr to purex_item
+ */
+static void
+qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
+{
+	struct qla_nvme_unsol_ctx *uctx = item->purls_context;
+	fc_port_t *fcport = uctx->fcport;
+	struct qla_nvme_lsrjt_pt_arg a;
+	int ret;
+
+	ret = nvme_fc_rcv_ls_req(fcport->nvme_remote_port, &uctx->lsrsp,
+				 &item->iocb, item->size);
+	if (ret) {
+		ql_dbg(ql_dbg_unsol, vha, 0x2125, "NVMe tranport ls_req failed\n");
+		memset((void *)&a, 0, sizeof(a));
+		a.vp_idx = vha->vp_idx;
+		a.nport_handle = uctx->nport_handle;
+		a.xchg_address = uctx->exchange_address;
+		qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a, true);
+		list_del(&uctx->elem);
+		kfree(uctx);
+	}
+}
+
+static scsi_qla_host_t *
+qla2xxx_get_vha_from_vp_idx(struct qla_hw_data *ha, uint16_t vp_index)
+{
+	scsi_qla_host_t *base_vha, *vha, *tvp;
+	unsigned long flags;
+
+	base_vha = pci_get_drvdata(ha->pdev);
+
+	if (!vp_index && !ha->num_vhosts)
+		return base_vha;
+
+	spin_lock_irqsave(&ha->vport_slock, flags);
+	list_for_each_entry_safe(vha, tvp, &ha->vp_list, list) {
+		if (vha->vp_idx == vp_index) {
+			spin_unlock_irqrestore(&ha->vport_slock, flags);
+			return vha;
+		}
+	}
+	spin_unlock_irqrestore(&ha->vport_slock, flags);
+
+	return NULL;
+}
+
+void qla2xxx_process_purls_iocb(void **pkt, struct rsp_que **rsp)
+{
+	struct nvme_fc_remote_port *rport;
+	struct qla_nvme_rport *qla_rport;
+	struct qla_nvme_lsrjt_pt_arg a;
+	struct pt_ls4_rx_unsol *p = *pkt;
+	struct qla_nvme_unsol_ctx *uctx;
+	struct rsp_que *rsp_q = *rsp;
+	struct qla_hw_data *ha;
+	scsi_qla_host_t	*vha;
+	fc_port_t *fcport = NULL;
+	struct purex_item *item;
+	port_id_t d_id = {0};
+	port_id_t id = {0};
+	u8 *opcode;
+	bool xmt_reject = false;
+
+	ha = rsp_q->hw;
+
+	vha = qla2xxx_get_vha_from_vp_idx(ha, p->vp_index);
+	if (!vha) {
+		ql_log(ql_log_warn, NULL, 0x2110, "Invalid vp index %d\n", p->vp_index);
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	memset((void *)&a, 0, sizeof(a));
+	opcode = (u8 *)&p->payload[0];
+	a.opcode = opcode[3];
+	a.vp_idx = p->vp_index;
+	a.nport_handle = p->nport_handle;
+	a.ox_id = p->ox_id;
+	a.xchg_address = p->exchange_address;
+
+	id.b.domain = p->s_id.domain;
+	id.b.area   = p->s_id.area;
+	id.b.al_pa  = p->s_id.al_pa;
+	d_id.b.domain = p->d_id[2];
+	d_id.b.area   = p->d_id[1];
+	d_id.b.al_pa  = p->d_id[0];
+
+	fcport = qla2x00_find_fcport_by_nportid(vha, &id, 0);
+	if (!fcport) {
+		ql_dbg(ql_dbg_unsol, vha, 0x211e,
+		       "Failed to find sid=%06x did=%06x\n",
+		       id.b24, d_id.b24);
+		a.reason = FCNVME_RJT_RC_INV_ASSOC;
+		a.explanation = FCNVME_RJT_EXP_NONE;
+		xmt_reject = true;
+		goto out;
+	}
+	rport = fcport->nvme_remote_port;
+	qla_rport = rport->private;
+
+	item = qla27xx_copy_multiple_pkt(vha, pkt, rsp, true, false);
+	if (!item) {
+		a.reason = FCNVME_RJT_RC_LOGIC;
+		a.explanation = FCNVME_RJT_EXP_NONE;
+		xmt_reject = true;
+		goto out;
+	}
+
+	uctx = kzalloc(sizeof(*uctx), GFP_ATOMIC);
+	if (!uctx) {
+		ql_log(ql_log_info, vha, 0x2126, "Failed allocate memory\n");
+		a.reason = FCNVME_RJT_RC_LOGIC;
+		a.explanation = FCNVME_RJT_EXP_NONE;
+		xmt_reject = true;
+		kfree(item);
+		goto out;
+	}
+
+	uctx->vha = vha;
+	uctx->fcport = fcport;
+	uctx->exchange_address = p->exchange_address;
+	uctx->nport_handle = p->nport_handle;
+	uctx->ox_id = p->ox_id;
+	qla_rport->uctx = uctx;
+	INIT_LIST_HEAD(&uctx->elem);
+	list_add_tail(&uctx->elem, &fcport->unsol_ctx_head);
+	item->purls_context = (void *)uctx;
+
+	ql_dbg(ql_dbg_unsol, vha, 0x2121,
+	       "PURLS OP[%01x] size %d xchg addr 0x%x portid %06x\n",
+	       item->iocb.iocb[3], item->size, uctx->exchange_address,
+	       fcport->d_id.b24);
+	/* +48    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
+	 * ----- -----------------------------------------------
+	 * 0000: 00 00 00 05 28 00 00 00 07 00 00 00 08 00 00 00
+	 * 0010: ab ec 0f cc 00 00 8d 7d 05 00 00 00 10 00 00 00
+	 * 0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+	 */
+	ql_dump_buffer(ql_dbg_unsol + ql_dbg_verbose, vha, 0x2120,
+		       &item->iocb, item->size);
+
+	qla24xx_queue_purex_item(vha, item, qla2xxx_process_purls_pkt);
+out:
+	if (xmt_reject) {
+		qla_nvme_ls_reject_iocb(vha, (*rsp)->qpair, &a, false);
+		__qla_consume_iocb(vha, pkt, rsp);
+	}
+}
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index d299478371b2..a253ac55171b 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -21,6 +21,7 @@
 #define Q2T_NVME_NUM_TAGS 2048
 #define QLA_MAX_FC_SEGMENTS 64
 
+struct qla_nvme_unsol_ctx;
 struct scsi_qla_host;
 struct qla_hw_data;
 struct req_que;
@@ -37,6 +38,7 @@ struct nvme_private {
 
 struct qla_nvme_rport {
 	struct fc_port *fcport;
+	struct qla_nvme_unsol_ctx *uctx;
 };
 
 #define COMMAND_NVME    0x88            /* Command Type FC-NVMe IOCB */
@@ -75,6 +77,9 @@ struct cmd_nvme {
 	struct dsd64 nvme_dsd;
 };
 
+#define PURLS_MSLEEP_INTERVAL	1
+#define PURLS_RETRY_COUNT	5
+
 #define PT_LS4_REQUEST 0x89	/* Link Service pass-through IOCB (request) */
 struct pt_ls4_request {
 	uint8_t entry_type;
@@ -118,21 +123,19 @@ struct pt_ls4_rx_unsol {
 	__le32	exchange_address;
 	uint8_t d_id[3];
 	uint8_t r_ctl;
-	be_id_t s_id;
+	le_id_t s_id;
 	uint8_t cs_ctl;
 	uint8_t f_ctl[3];
 	uint8_t type;
 	__le16	seq_cnt;
 	uint8_t df_ctl;
 	uint8_t seq_id;
-	__le16	rx_id;
-	__le16	ox_id;
-	__le32	param;
-	__le32	desc0;
+	__le16 rx_id;
+	__le16 ox_id;
+	__le32  desc0;
 #define PT_LS4_PAYLOAD_OFFSET 0x2c
 #define PT_LS4_FIRST_PACKET_LEN 20
-	__le32	desc_len;
-	__le32	payload[3];
+	__le32 payload[5];
 };
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 03bc3a0b45b6..d622d415a3c1 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4457,8 +4457,9 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 
 	ha->elsrej.size = sizeof(struct fc_els_ls_rjt) + 16;
 	ha->elsrej.c = dma_alloc_coherent(&ha->pdev->dev,
-	    ha->elsrej.size, &ha->elsrej.cdma, GFP_KERNEL);
-
+					  ha->elsrej.size,
+					  &ha->elsrej.cdma,
+					  GFP_KERNEL);
 	if (!ha->elsrej.c) {
 		ql_dbg_pci(ql_dbg_init, ha->pdev, 0xffff,
 		    "Alloc failed for els reject cmd.\n");
@@ -4467,8 +4468,21 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	ha->elsrej.c->er_cmd = ELS_LS_RJT;
 	ha->elsrej.c->er_reason = ELS_RJT_LOGIC;
 	ha->elsrej.c->er_explan = ELS_EXPL_UNAB_DATA;
+
+	ha->lsrjt.size = sizeof(struct fcnvme_ls_rjt);
+	ha->lsrjt.c = dma_alloc_coherent(&ha->pdev->dev, ha->lsrjt.size,
+			&ha->lsrjt.cdma, GFP_KERNEL);
+	if (!ha->lsrjt.c) {
+		ql_dbg_pci(ql_dbg_init, ha->pdev, 0xffff,
+			   "Alloc failed for nvme fc reject cmd.\n");
+		goto fail_lsrjt;
+	}
+
 	return 0;
 
+fail_lsrjt:
+	dma_free_coherent(&ha->pdev->dev, ha->elsrej.size,
+			  ha->elsrej.c, ha->elsrej.cdma);
 fail_elsrej:
 	dma_pool_destroy(ha->purex_dma_pool);
 fail_flt:
@@ -5000,6 +5014,12 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 		ha->elsrej.c = NULL;
 	}
 
+	if (ha->lsrjt.c) {
+		dma_free_coherent(&ha->pdev->dev, ha->lsrjt.size, ha->lsrjt.c,
+				  ha->lsrjt.cdma);
+		ha->lsrjt.c = NULL;
+	}
+
 	ha->init_cb = NULL;
 	ha->init_cb_dma = 0;
 
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 4109f1bd6128..f6ef8cf5d774 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -53,10 +53,10 @@
 struct nvmefc_ls_req {
 	void			*rqstaddr;
 	dma_addr_t		rqstdma;
-	u32			rqstlen;
+	__le32			rqstlen;
 	void			*rspaddr;
 	dma_addr_t		rspdma;
-	u32			rsplen;
+	__le32			rsplen;
 	u32			timeout;
 
 	void			*private;
@@ -120,7 +120,7 @@ struct nvmefc_ls_req {
 struct nvmefc_ls_rsp {
 	void		*rspbuf;
 	dma_addr_t	rspdma;
-	u16		rsplen;
+	__le32		rsplen;
 
 	void (*done)(struct nvmefc_ls_rsp *rsp);
 	void		*nvme_fc_private;	/* LLDD is not to access !! */
-- 
2.23.1

