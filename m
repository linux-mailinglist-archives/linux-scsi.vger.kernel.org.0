Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76E915B2FF
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Feb 2020 22:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgBLVrU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Feb 2020 16:47:20 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32650 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbgBLVrU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Feb 2020 16:47:20 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CLeuJm001683;
        Wed, 12 Feb 2020 13:45:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=J+ALhMZwp8ni/wZ/8AdHAC4Bjl9wuTNh/hdbmte6DUc=;
 b=kJksXCIex/oAbDJ0Jp2WOnkx2xTlxwWKWo70aNDtTmRiiAgDRBDZIbcnyYHukzE1nfW0
 JA1QfWo0VzIpvPc7Qj8moqA+BGUaFz8Ywb+TOL2B2Fx+g1fZiENXG65VKAwDX8RoiuSC
 t1Pjw/P19nx0A1KMNtABRh6iSIu56WHndtHhAmUUhIQNuIrnfL3BdB0IqdtYb3ezjeFm
 6g7xrZBD260797TtvwwEhNwNLA0TJpUC3TgTgOgI2RcqH5MboHCJxjckcHwyO6lPROQv
 9ciKLVNzgyNkNGwadnN66Yu0pwqicfcVTw2gTCvRSEarBEEZmjkjnaEZrv41PB4+KyxK VQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2y4j5jt4yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 13:45:17 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 13:45:15 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Feb 2020 13:45:15 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 4E2323F7044;
        Wed, 12 Feb 2020 13:45:15 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 01CLjFAQ025628;
        Wed, 12 Feb 2020 13:45:15 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 01CLjF92025627;
        Wed, 12 Feb 2020 13:45:15 -0800
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 13/25] qla2xxx: Add deferred queue for processing ABTS and RDP
Date:   Wed, 12 Feb 2020 13:44:24 -0800
Message-ID: <20200212214436.25532-14-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200212214436.25532-1-hmadhani@marvell.com>
References: <20200212214436.25532-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_10:2020-02-12,2020-02-12 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Joe Carnuccio <joe.carnuccio@cavium.com>

This patch adds deferred queue for processing aborts and RDP
in the driver.

Signed-off-by: Joe Carnuccio <joe.carnuccio@cavium.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h |  15 +++-
 drivers/scsi/qla2xxx/qla_fw.h  |  91 ++++++++++++++++++++++--
 drivers/scsi/qla2xxx/qla_gbl.h |   2 +
 drivers/scsi/qla2xxx/qla_isr.c | 154 +++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/qla2xxx/qla_mid.c |   7 ++
 drivers/scsi/qla2xxx/qla_os.c  |  62 ++++++++++++-----
 6 files changed, 304 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 09853b624aff..7f25066d1bbf 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4473,6 +4473,15 @@ struct active_regions {
 #define QLA_SET_DATA_RATE_NOLR	1
 #define QLA_SET_DATA_RATE_LR	2 /* Set speed and initiate LR */
 
+struct purex_item {
+	struct list_head list;
+	struct scsi_qla_host *vha;
+	void (*process_item)(struct scsi_qla_host *vha, void *pkt);
+	struct {
+		uint8_t iocb[64];
+	} iocb;
+};
+
 /*
  * Qlogic scsi host structure
  */
@@ -4663,7 +4672,11 @@ typedef struct scsi_qla_host {
 	uint16_t ql2xexchoffld;
 	uint16_t ql2xiniexchg;
 
-	void	*purex_data;
+	struct purex_list {
+		struct list_head head;
+		spinlock_t lock;
+	} purex_list;
+
 	struct name_list_extended gnl;
 	/* Count of active session/fcport */
 	int fcport_count;
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index f7a40dcda7ce..8af5bc4e2cc6 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -727,7 +727,7 @@ struct ct_entry_24xx {
  * ISP queue - PUREX IOCB entry structure definition
  */
 #define PUREX_IOCB_TYPE		0x51	/* CT Pass Through IOCB entry */
-typedef struct purex_entry_24xx {
+struct purex_entry_24xx {
 	uint8_t entry_type;		/* Entry type. */
 	uint8_t entry_count;		/* Entry count. */
 	uint8_t sys_define;		/* System defined. */
@@ -763,9 +763,7 @@ typedef struct purex_entry_24xx {
 	uint32_t param;
 
 	uint8_t els_frame_payload[20];
-} purex_entry_24xx_t;
-
-#define PUREX_ENTRY_SIZE	(sizeof(purex_entry_24xx_t))
+};
 
 /*
  * ISP queue - ELS Pass-Through entry structure definition.
@@ -1000,6 +998,91 @@ struct abort_entry_24xx {
 	uint8_t reserved_2[12];
 };
 
+#define ABTS_RCV_TYPE		0x54
+#define ABTS_RSP_TYPE		0x55
+struct abts_entry_24xx {
+	uint8_t entry_type;
+	uint8_t entry_count;
+	uint8_t handle_count;
+	uint8_t entry_status;
+
+	uint32_t handle;		/* type 0x55 only */
+
+	uint16_t comp_status;		/* type 0x55 only */
+	uint16_t nport_handle;		/* type 0x54 only */
+
+	uint16_t control_flags;		/* type 0x55 only */
+	uint8_t vp_idx;
+	uint8_t sof_type;		/* sof_type is upper nibble */
+
+	uint32_t rx_xch_addr;
+
+	uint8_t d_id[3];
+	uint8_t r_ctl;
+
+	uint8_t s_id[3];
+	uint8_t cs_ctl;
+
+	uint8_t f_ctl[3];
+	uint8_t type;
+
+	uint16_t seq_cnt;
+	uint8_t df_ctl;
+	uint8_t seq_id;
+
+	uint16_t rx_id;
+	uint16_t ox_id;
+
+	uint32_t param;
+
+	union {
+		struct {
+			uint32_t subcode3;
+			uint32_t rsvd;
+			uint32_t subcode1;
+			uint32_t subcode2;
+		} error;
+		struct {
+			uint16_t rsrvd1;
+			uint8_t last_seq_id;
+			uint8_t seq_id_valid;
+			uint16_t aborted_rx_id;
+			uint16_t aborted_ox_id;
+			uint16_t high_seq_cnt;
+			uint16_t low_seq_cnt;
+		} ba_acc;
+		struct {
+			uint8_t vendor_unique;
+			uint8_t explanation;
+			uint8_t reason;
+		} ba_rjt;
+	} payload;
+
+	uint32_t rx_xch_addr_to_abort;
+} __packed;
+
+/* ABTS payload explanation values */
+#define BA_RJT_EXP_NO_ADDITIONAL	0
+#define BA_RJT_EXP_INV_OX_RX_ID		3
+#define BA_RJT_EXP_SEQ_ABORTED		5
+
+/* ABTS payload reason values */
+#define BA_RJT_RSN_INV_CMD_CODE		1
+#define BA_RJT_RSN_LOGICAL_ERROR	3
+#define BA_RJT_RSN_LOGICAL_BUSY		5
+#define BA_RJT_RSN_PROTOCOL_ERROR	7
+#define BA_RJT_RSN_UNABLE_TO_PERFORM	9
+#define BA_RJT_RSN_VENDOR_SPECIFIC	0xff
+
+/* FC_F values */
+#define FC_TYPE_BLD		0x000		/* Basic link data */
+#define FC_F_CTL_RSP_CNTXT	0x800000	/* Responder of exchange */
+#define FC_F_CTL_LAST_SEQ	0x100000	/* Last sequence */
+#define FC_F_CTL_END_SEQ	0x80000		/* Last sequence */
+#define FC_F_CTL_SEQ_INIT	0x010000	/* Sequence initiative */
+#define FC_ROUTING_BLD		0x80		/* Basic link data frame */
+#define FC_R_CTL_BLD_BA_ACC	0x04		/* BA_ACC (basic accept) */
+
 /*
  * ISP I/O Register Set structure definitions.
  */
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index cdd8d7947fa8..c056df820ab9 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -230,6 +230,7 @@ void qla2x00_handle_login_done_event(struct scsi_qla_host *, fc_port_t *,
 int qla24xx_post_gnl_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_post_relogin_work(struct scsi_qla_host *vha);
 void qla2x00_wait_for_sess_deletion(scsi_qla_host_t *);
+void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt);
 
 /*
  * Global Functions in qla_mid.c source file.
@@ -928,6 +929,7 @@ void qlt_remove_target_resources(struct qla_hw_data *);
 void qlt_clr_qp_table(struct scsi_qla_host *vha);
 void qlt_set_mode(struct scsi_qla_host *);
 int qla2x00_set_data_rate(scsi_qla_host_t *vha, uint16_t mode);
+extern void qla24xx_process_purex_list(struct purex_list *);
 
 /* nvme.c */
 void qla_nvme_unregister_remote_port(struct fc_port *fcport);
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index a274872ff15d..1089db774bd1 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -31,13 +31,144 @@ const char *const port_state_str[] = {
 	"ONLINE"
 };
 
-static void qla24xx_purex_iocb(scsi_qla_host_t *vha, struct req_que *req,
-    struct sts_entry_24xx *pkt)
+static void qla24xx_purex_iocb(scsi_qla_host_t *vha, void *pkt,
+    void (*process_item)(struct scsi_qla_host *vha, void *pkt))
 {
-	memcpy(vha->purex_data, pkt, PUREX_ENTRY_SIZE);
+	struct purex_list *list = &vha->purex_list;
+	struct purex_item *item;
+	ulong flags;
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (!item) {
+		ql_log(ql_log_warn, vha, 0x5092,
+		    ">> Failed allocate purex list item.\n");
+		return;
+	}
+
+	item->vha = vha;
+	item->process_item = process_item;
+	memcpy(&item->iocb, pkt, sizeof(item->iocb));
+
+	spin_lock_irqsave(&list->lock, flags);
+	list_add_tail(&item->list, &list->head);
+	spin_unlock_irqrestore(&list->lock, flags);
+
 	set_bit(PROCESS_PUREX_IOCB, &vha->dpc_flags);
 }
 
+static void
+qla24xx_process_abts(struct scsi_qla_host *vha, void *pkt)
+{
+	struct abts_entry_24xx *abts = pkt;
+	struct qla_hw_data *ha = vha->hw;
+	struct els_entry_24xx *rsp_els;
+	struct abts_entry_24xx *abts_rsp;
+	dma_addr_t dma;
+	uint32_t fctl;
+	int rval;
+
+	ql_dbg(ql_dbg_init, vha, 0x0286, "%s: entered.\n", __func__);
+
+	ql_log(ql_log_warn, vha, 0x0287,
+	    "Processing ABTS xchg=%#x oxid=%#x rxid=%#x seqid=%#x seqcnt=%#x\n",
+	    abts->rx_xch_addr_to_abort, abts->ox_id, abts->rx_id,
+	    abts->seq_id, abts->seq_cnt);
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0287,
+	    "-------- ABTS RCV -------\n");
+	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0287,
+	    (uint8_t *)abts, sizeof(*abts));
+
+	rsp_els = dma_alloc_coherent(&ha->pdev->dev, sizeof(*rsp_els), &dma,
+	    GFP_KERNEL);
+	if (!rsp_els) {
+		ql_log(ql_log_warn, vha, 0x0287,
+		    "Failed allocate dma buffer ABTS/ELS RSP.\n");
+		return;
+	}
+
+	/* terminate exchange */
+	memset(rsp_els, 0, sizeof(*rsp_els));
+	rsp_els->entry_type = ELS_IOCB_TYPE;
+	rsp_els->entry_count = 1;
+	rsp_els->nport_handle = ~0;
+	rsp_els->rx_xchg_address = abts->rx_xch_addr_to_abort;
+	rsp_els->control_flags = EPD_RX_XCHG;
+	ql_dbg(ql_dbg_init, vha, 0x0283,
+	    "Sending ELS Response to terminate exchange %#x...\n",
+	    abts->rx_xch_addr_to_abort);
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0283,
+	    "-------- ELS RSP -------\n");
+	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x0283,
+	    (uint8_t *)rsp_els, sizeof(*rsp_els));
+	rval = qla2x00_issue_iocb(vha, rsp_els, dma, 0);
+	if (rval) {
+		ql_log(ql_log_warn, vha, 0x0288,
+		    "%s: iocb failed to execute -> %x\n", __func__, rval);
+	} else if (rsp_els->comp_status) {
+		ql_log(ql_log_warn, vha, 0x0289,
+		    "%s: iocb failed to complete -> completion=%#x subcode=(%#x,%#x)\n",
+		    __func__, rsp_els->comp_status,
+		    rsp_els->error_subcode_1, rsp_els->error_subcode_2);
+	} else {
+		ql_dbg(ql_dbg_init, vha, 0x028a,
+		    "%s: abort exchange done.\n", __func__);
+	}
+
+	/* send ABTS response */
+	abts_rsp = (void *)rsp_els;
+	memset(abts_rsp, 0, sizeof(*abts_rsp));
+	abts_rsp->entry_type = ABTS_RSP_TYPE;
+	abts_rsp->entry_count = 1;
+	abts_rsp->nport_handle = abts->nport_handle;
+	abts_rsp->vp_idx = abts->vp_idx;
+	abts_rsp->sof_type = abts->sof_type & 0xf0;
+	abts_rsp->rx_xch_addr = abts->rx_xch_addr;
+	abts_rsp->d_id[0] = abts->s_id[0];
+	abts_rsp->d_id[1] = abts->s_id[1];
+	abts_rsp->d_id[2] = abts->s_id[2];
+	abts_rsp->r_ctl = FC_ROUTING_BLD | FC_R_CTL_BLD_BA_ACC;
+	abts_rsp->s_id[0] = abts->d_id[0];
+	abts_rsp->s_id[1] = abts->d_id[1];
+	abts_rsp->s_id[2] = abts->d_id[2];
+	abts_rsp->cs_ctl = abts->cs_ctl;
+	/* include flipping bit23 in fctl */
+	fctl = ~(abts->f_ctl[2] | 0x7F) << 16 |
+	    FC_F_CTL_LAST_SEQ | FC_F_CTL_END_SEQ | FC_F_CTL_SEQ_INIT;
+	abts_rsp->f_ctl[0] = fctl >> 0 & 0xff;
+	abts_rsp->f_ctl[1] = fctl >> 8 & 0xff;
+	abts_rsp->f_ctl[2] = fctl >> 16 & 0xff;
+	abts_rsp->type = FC_TYPE_BLD;
+	abts_rsp->rx_id = abts->rx_id;
+	abts_rsp->ox_id = abts->ox_id;
+	abts_rsp->payload.ba_acc.aborted_rx_id = abts->rx_id;
+	abts_rsp->payload.ba_acc.aborted_ox_id = abts->ox_id;
+	abts_rsp->payload.ba_acc.high_seq_cnt = ~0;
+	abts_rsp->rx_xch_addr_to_abort = abts->rx_xch_addr_to_abort;
+	ql_dbg(ql_dbg_init, vha, 0x028b,
+	    "Sending BA ACC response to ABTS %#x...\n",
+	    abts->rx_xch_addr_to_abort);
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x028b,
+	    "-------- ELS RSP -------\n");
+	ql_dump_buffer(ql_dbg_init + ql_dbg_verbose, vha, 0x028b,
+	    (uint8_t *)abts_rsp, sizeof(*abts_rsp));
+	rval = qla2x00_issue_iocb(vha, abts_rsp, dma, 0);
+	if (rval) {
+		ql_log(ql_log_warn, vha, 0x028c,
+		    "%s: iocb failed to execute -> %x\n", __func__, rval);
+	} else if (abts_rsp->comp_status) {
+		ql_log(ql_log_warn, vha, 0x028d,
+		    "%s: iocb failed to complete -> completion=%#x subcode=(%#x,%#x)\n",
+		    __func__, abts_rsp->comp_status,
+		    abts_rsp->payload.error.subcode1,
+		    abts_rsp->payload.error.subcode2);
+	} else {
+		ql_dbg(ql_dbg_init, vha, 0x028ea,
+		    "%s: done.\n", __func__);
+	}
+
+	dma_free_coherent(&ha->pdev->dev, sizeof(*rsp_els), rsp_els, dma);
+}
+
 /**
  * qla2100_intr_handler() - Process interrupts for the ISP2100 and ISP2200.
  * @irq: interrupt number
@@ -3097,6 +3228,11 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 			qla24xx_els_ct_entry(vha, rsp->req, pkt, ELS_IOCB_TYPE);
 			break;
 		case ABTS_RECV_24XX:
+			if (qla_ini_mode_enabled(vha)) {
+				qla24xx_purex_iocb(vha, pkt,
+				    qla24xx_process_abts);
+				break;
+			}
 			if (IS_QLA83XX(ha) || IS_QLA27XX(ha) ||
 			    IS_QLA28XX(ha)) {
 				/* ensure that the ATIO queue is empty */
@@ -3142,8 +3278,18 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 			    (struct vp_ctrl_entry_24xx *)pkt);
 			break;
 		case PUREX_IOCB_TYPE:
-			qla24xx_purex_iocb(vha, rsp->req, pkt);
+		{
+			struct purex_entry_24xx *purex = (void *)pkt;
+
+			if (purex->els_frame_payload[3] != ELS_COMMAND_RDP) {
+				ql_dbg(ql_dbg_init, vha, 0x5091,
+				    "Discarding ELS Request opcode %#x...\n",
+				    purex->els_frame_payload[3]);
+				break;
+			}
+			qla24xx_purex_iocb(vha, pkt, qla24xx_process_purex_rdp);
 			break;
+		}
 		default:
 			/* Type Not Supported. */
 			ql_dbg(ql_dbg_async, vha, 0x5042,
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index d211f803c699..e86c94f78196 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -361,6 +361,13 @@ qla2x00_do_dpc_vp(scsi_qla_host_t *vha)
 		}
 	}
 
+	if (test_bit(PROCESS_PUREX_IOCB, &vha->dpc_flags)) {
+		if (atomic_read(&vha->loop_state) == LOOP_READY) {
+			qla24xx_process_purex_list(&vha->purex_list);
+			clear_bit(PROCESS_PUREX_IOCB, &vha->dpc_flags);
+		}
+	}
+
 	if (test_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags)) {
 		ql_dbg(ql_dbg_dpc, vha, 0x4016,
 		    "FCPort update scheduled.\n");
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 295c7fec0918..1aad4b9ce4b6 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3285,11 +3285,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto probe_failed;
 	}
 
-	base_vha->purex_data = kzalloc(PUREX_ENTRY_SIZE, GFP_KERNEL);
-	if (!base_vha->purex_data)
-		ql_log(ql_log_warn, base_vha, 0x7118,
-		    "Failed to allocate memory for PUREX data\n");
-
 	if (IS_QLAFX00(ha))
 		host->can_queue = QLAFX00_MAX_CANQUEUE;
 	else
@@ -3471,7 +3466,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 probe_failed:
-	kfree(base_vha->purex_data);
 	if (base_vha->gnl.l) {
 		dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
 				base_vha->gnl.l, base_vha->gnl.ldma);
@@ -3788,8 +3782,6 @@ qla2x00_remove_one(struct pci_dev *pdev)
 
 	qla84xx_put_chip(base_vha);
 
-	kfree(base_vha->purex_data);
-
 	/* Disable timer */
 	if (base_vha->timer_active)
 		qla2x00_stop_timer(base_vha);
@@ -3831,6 +3823,20 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static inline void
+qla24xx_free_purex_list(struct purex_list *list)
+{
+	struct list_head *item, *next;
+	ulong flags;
+
+	spin_lock_irqsave(&list->lock, flags);
+	list_for_each_safe(item, next, &list->head) {
+		list_del(item);
+		kfree(list_entry(item, struct purex_item, list));
+	}
+	spin_unlock_irqrestore(&list->lock, flags);
+}
+
 static void
 qla2x00_free_device(scsi_qla_host_t *vha)
 {
@@ -3863,6 +3869,8 @@ qla2x00_free_device(scsi_qla_host_t *vha)
 	}
 
 
+	qla24xx_free_purex_list(&vha->purex_list);
+
 	qla2x00_mem_free(ha);
 
 	qla82xx_md_free(vha);
@@ -4836,6 +4844,9 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	INIT_LIST_HEAD(&vha->gpnid_list);
 	INIT_WORK(&vha->iocb_work, qla2x00_iocb_work_fn);
 
+	INIT_LIST_HEAD(&vha->purex_list.head);
+	spin_lock_init(&vha->purex_list.lock);
+
 	spin_lock_init(&vha->work_lock);
 	spin_lock_init(&vha->cmd_list_lock);
 	init_waitqueue_head(&vha->fcport_waitQ);
@@ -5858,7 +5869,7 @@ qla25xx_rdp_port_speed_currently(struct qla_hw_data *ha)
  * vha:	SCSI qla host
  * purex: RDP request received by HBA
  */
-static int qla24xx_process_purex_iocb(struct scsi_qla_host *vha, void *pkt)
+void qla24xx_process_purex_rdp(struct scsi_qla_host *vha, void *pkt)
 {
 	struct qla_hw_data *ha = vha->hw;
 	struct purex_entry_24xx *purex = pkt;
@@ -5874,7 +5885,7 @@ static int qla24xx_process_purex_iocb(struct scsi_qla_host *vha, void *pkt)
 	struct buffer_credit_24xx *bbc = NULL;
 	uint8_t *sfp = NULL;
 	uint16_t sfp_flags = 0;
-	int rval = -ENOMEM;
+	int rval;
 
 	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x0180,
 	    "%s: Enter\n", __func__);
@@ -6299,8 +6310,23 @@ static int qla24xx_process_purex_iocb(struct scsi_qla_host *vha, void *pkt)
 	if (rsp_els)
 		dma_free_coherent(&ha->pdev->dev, sizeof(*rsp_els),
 		    rsp_els, rsp_els_dma);
+}
 
-	return rval;
+void qla24xx_process_purex_list(struct purex_list *list)
+{
+	struct list_head head = LIST_HEAD_INIT(head);
+	struct purex_item *item, *next;
+	ulong flags;
+
+	spin_lock_irqsave(&list->lock, flags);
+	list_splice_init(&list->head, &head);
+	spin_unlock_irqrestore(&list->lock, flags);
+
+	list_for_each_entry_safe(item, next, &head, list) {
+		list_del(&item->list);
+		item->process_item(item->vha, &item->iocb);
+		kfree(item);
+	}
 }
 
 void
@@ -6650,8 +6676,6 @@ qla2x00_disable_board_on_pci_error(struct work_struct *work)
 
 	base_vha->flags.online = 0;
 
-	kfree(base_vha->purex_data);
-
 	qla2x00_destroy_deferred_work(ha);
 
 	/*
@@ -6875,11 +6899,13 @@ qla2x00_do_dpc(void *data)
 			}
 		}
 
-		if (test_bit(PROCESS_PUREX_IOCB, &base_vha->dpc_flags) &&
-		   (atomic_read(&base_vha->loop_state) == LOOP_READY)) {
-			qla24xx_process_purex_iocb(base_vha,
-			   base_vha->purex_data);
-			clear_bit(PROCESS_PUREX_IOCB, &base_vha->dpc_flags);
+		if (test_bit(PROCESS_PUREX_IOCB, &base_vha->dpc_flags)) {
+			if (atomic_read(&base_vha->loop_state) == LOOP_READY) {
+				qla24xx_process_purex_list
+					(&base_vha->purex_list);
+				clear_bit(PROCESS_PUREX_IOCB,
+				    &base_vha->dpc_flags);
+			}
 		}
 
 		if (test_and_clear_bit(FCPORT_UPDATE_NEEDED,
-- 
2.12.0

