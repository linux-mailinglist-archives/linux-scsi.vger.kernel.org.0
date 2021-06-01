Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9B3955BE
	for <lists+linux-scsi@lfdr.de>; Mon, 31 May 2021 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEaHJ2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 May 2021 03:09:28 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37784 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230070AbhEaHJ1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 31 May 2021 03:09:27 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14V75gIf004716
        for <linux-scsi@vger.kernel.org>; Mon, 31 May 2021 00:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Q/TdWDnkhxHz/KHXW+4my4Y0v4OoYBsR7lNXti4MoJ0=;
 b=C/rSV0N+XIbwtCMDLfIaZTcxV1wQeEA1ZhaBDclQjnLO00R4SYQ8u0jbI6BFeNbbtNUl
 vSQPBCGssKhsajh0jnGTvwoGRcQu5I+DaEekW+FCwiR3g7NfUD2xKAEgbDXCEhumPOiv
 P35K7JtRpmcFebJvC+sK6NwIM6LobmAAKnvLrmd+z9qxIcMlge5a1IGKUNO5obnqGIOq
 vAGK/o79DuiexAXPnqtKB3ivOi3fb3aqNMPbQkKn9A+OeFRxoBj5r5E5qTxDS6E4vu75
 xCU8h0Q4XV+bqvKOHtGUkxpVn0nclN1gIWPEn2Q6g2bOZF1tdA95W0cWln9pWVRID2uA OQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 38vjqj14p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 31 May 2021 00:07:48 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 00:07:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 May 2021 00:07:46 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 6594B3F703F;
        Mon, 31 May 2021 00:07:46 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 14V77kF1032140;
        Mon, 31 May 2021 00:07:46 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 14V77kQI032131;
        Mon, 31 May 2021 00:07:46 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 04/10] qla2xxx: Add extraction of auth_els from the wire
Date:   Mon, 31 May 2021 00:05:39 -0700
Message-ID: <20210531070545.32072-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210531070545.32072-1-njavali@marvell.com>
References: <20210531070545.32072-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: G9Bk9zJLBWdcpyksK27sS2TdkEeIw3dQ
X-Proofpoint-ORIG-GUID: G9Bk9zJLBWdcpyksK27sS2TdkEeIw3dQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_04:2021-05-31,2021-05-31 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Latest FC adapter from Marvell has the ability to encrypt
data in flight (EDIF) feature. This feature require an
application (ex: ipsec, etc) to act as an authenticator.

This patch is a continuation of previous patch where
authentication messages sent from remote device has arrived.
Each message is extracted and placed in a buffer for application
to retrieve. The FC frame header will be stripped leaving
behind the AUTH ELS payload. It is up to the application
to strip the AUTH ELS header to get to the actual authentication
message.

Signed-off-by: Larry Wisneski <Larry.Wisneski@marvell.com>
Signed-off-by: Duane Grigsby <duane.grigsby@marvell.com>
Signed-off-by: Rick Hicksted Jr <rhicksted@marvell.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h    |   2 +-
 drivers/scsi/qla2xxx/qla_edif.c   | 191 ++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_gbl.h    |   7 +-
 drivers/scsi/qla2xxx/qla_isr.c    | 182 ++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_os.c     |  11 +-
 drivers/scsi/qla2xxx/qla_target.c |  36 +++---
 6 files changed, 404 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 517a4a4c178e..e47a7b3618d6 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3907,7 +3907,6 @@ struct qlt_hw_data {
 	int num_act_qpairs;
 #define DEFAULT_NAQP 2
 	spinlock_t atio_lock ____cacheline_aligned;
-	struct btree_head32 host_map;
 };
 
 #define MAX_QFULL_CMDS_ALLOC	8192
@@ -4682,6 +4681,7 @@ struct qla_hw_data {
 	struct qla_hw_data_stat stat;
 	pci_error_state_t pci_error_state;
 	struct dma_pool *purex_dma_pool;
+	struct btree_head32 host_map;
 	struct els_reject elsrej;
 };
 
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 4c788f4588ca..df8dff447c6a 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -684,6 +684,44 @@ qla_enode_stop(scsi_qla_host_t *vha)
  *  returns: enode pointer with buffers
  *           NULL on error
  */
+static struct enode *
+qla_enode_alloc(scsi_qla_host_t *vha, uint32_t ntype)
+{
+	struct enode		*node;
+	struct purexevent	*purex;
+
+	node = kzalloc(RX_ELS_SIZE, GFP_ATOMIC);
+	if (!node)
+		return NULL;
+
+	purex = &node->u.purexinfo;
+	purex->msgp = (u8 *)(node + 1);
+	purex->msgp_len = ELS_MAX_PAYLOAD;
+
+	node->dinfo.lstate = LSTATE_OFF;
+
+	node->ntype = ntype;
+	INIT_LIST_HEAD(&node->list);
+	return node;
+}
+
+/* adds a already alllocated enode to the linked list */
+static bool
+qla_enode_add(scsi_qla_host_t *vha, struct enode *ptr)
+{
+	unsigned long flags;
+
+	ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x9109,
+	    "%s add enode for type=%x, cnt=%x\n",
+	    __func__, ptr->ntype, ptr->dinfo.nodecnt);
+
+	spin_lock_irqsave(&vha->pur_cinfo.pur_lock, flags);
+	ptr->dinfo.lstate = LSTATE_ON;
+	list_add_tail(&ptr->list, &vha->pur_cinfo.head);
+	spin_unlock_irqrestore(&vha->pur_cinfo.pur_lock, flags);
+
+	return true;
+}
 
 static struct enode *
 qla_enode_find(scsi_qla_host_t *vha, uint32_t ntype, uint32_t p1, uint32_t p2)
@@ -783,6 +821,32 @@ qla_pur_get_pending(scsi_qla_host_t *vha, fc_port_t *fcport, struct bsg_job *bsg
 
 	return 0;
 }
+
+/* it is assume qpair lock is held */
+static int
+qla_els_reject_iocb(scsi_qla_host_t *vha, struct qla_qpair *qp,
+	struct qla_els_pt_arg *a)
+{
+	struct els_entry_24xx *els_iocb;
+
+	els_iocb = __qla2x00_alloc_iocbs(qp, NULL);
+	if (!els_iocb) {
+		ql_log(ql_log_warn, vha, 0x700c,
+		    "qla2x00_alloc_iocbs failed.\n");
+		return QLA_FUNCTION_FAILED;
+	}
+
+	qla_els_pt_iocb(vha, els_iocb, a);
+
+	ql_dbg(ql_dbg_edif, vha, 0x0183,
+	    "Sending ELS reject...\n");
+	ql_dump_buffer(ql_dbg_edif + ql_dbg_verbose, vha, 0x0185,
+	    vha->hw->elsrej.c, sizeof(*vha->hw->elsrej.c));
+	/* -- */
+	wmb();
+	qla2x00_start_iocbs(vha, qp->req);
+	return 0;
+}
 /* function called when app is stopping */
 
 void
@@ -796,6 +860,133 @@ qla_edb_stop(scsi_qla_host_t *vha)
 	}
 }
 
+void qla24xx_auth_els(scsi_qla_host_t *vha, void **pkt, struct rsp_que **rsp)
+{
+	struct purex_entry_24xx *p = *pkt;
+	struct enode		*ptr;
+	int		sid;
+	u16 totlen;
+	struct purexevent	*purex;
+	struct scsi_qla_host *host = NULL;
+	int rc;
+	struct fc_port *fcport;
+	struct qla_els_pt_arg a;
+	be_id_t beid;
+
+	memset(&a, 0, sizeof(a));
+
+	a.els_opcode = ELS_AUTH_ELS;
+	a.nport_handle = p->nport_handle;
+	a.rx_xchg_address = p->rx_xchg_addr;
+	a.did.b.domain = p->s_id[2];
+	a.did.b.area   = p->s_id[1];
+	a.did.b.al_pa  = p->s_id[0];
+	a.tx_byte_count = a.tx_len = sizeof(struct fc_els_ls_rjt);
+	a.tx_addr = vha->hw->elsrej.cdma;
+	a.vp_idx = vha->vp_idx;
+	a.control_flags = EPD_ELS_RJT;
+
+	sid = p->s_id[0] | (p->s_id[1] << 8) | (p->s_id[2] << 16);
+	/*
+	 * ql_dbg(ql_dbg_edif, vha, 0x09108,
+	 *	  "%s rec'vd sid=0x%x\n", __func__, sid);
+	 */
+
+	totlen = (le16_to_cpu(p->frame_size) & 0x0fff) - PURX_ELS_HEADER_SIZE;
+	if (le16_to_cpu(p->status_flags) & 0x8000) {
+		totlen = le16_to_cpu(p->trunc_frame_size);
+		qla_els_reject_iocb(vha, (*rsp)->qpair, &a);
+		__qla_consume_iocb(vha, pkt, rsp);
+		return;
+	}
+
+	if (totlen > MAX_PAYLOAD) {
+		ql_dbg(ql_dbg_edif, vha, 0x0910d,
+		    "%s WARNING: verbose ELS frame received (totlen=%x)\n",
+		    __func__, totlen);
+		qla_els_reject_iocb(vha, (*rsp)->qpair, &a);
+		__qla_consume_iocb(vha, pkt, rsp);
+		return;
+	}
+
+	if (!vha->hw->flags.edif_enabled) {
+		/* edif support not enabled */
+		ql_dbg(ql_dbg_edif, vha, 0x910e, "%s edif not enabled\n",
+		    __func__);
+		qla_els_reject_iocb(vha, (*rsp)->qpair, &a);
+		__qla_consume_iocb(vha, pkt, rsp);
+		return;
+	}
+
+	ptr = qla_enode_alloc(vha, N_PUREX);
+	if (!ptr) {
+		ql_dbg(ql_dbg_edif, vha, 0x09109,
+		    "WARNING: enode allloc failed for sid=%x\n",
+		    sid);
+		qla_els_reject_iocb(vha, (*rsp)->qpair, &a);
+		__qla_consume_iocb(vha, pkt, rsp);
+		return;
+	}
+
+	purex = &ptr->u.purexinfo;
+	purex->pur_info.pur_sid = a.did;
+	purex->pur_info.pur_pend = 0;
+	purex->pur_info.pur_bytes_rcvd = totlen;
+	purex->pur_info.pur_rx_xchg_address = le32_to_cpu(p->rx_xchg_addr);
+	purex->pur_info.pur_nphdl = le16_to_cpu(p->nport_handle);
+	purex->pur_info.pur_did.b.domain =  p->d_id[2];
+	purex->pur_info.pur_did.b.area =  p->d_id[1];
+	purex->pur_info.pur_did.b.al_pa =  p->d_id[0];
+	purex->pur_info.vp_idx = p->vp_idx;
+
+	rc = __qla_copy_purex_to_buffer(vha, pkt, rsp, purex->msgp,
+		purex->msgp_len);
+	if (rc) {
+		qla_els_reject_iocb(vha, (*rsp)->qpair, &a);
+		qla_enode_free(vha, ptr);
+		return;
+	}
+	/*
+	 * ql_dump_buffer(ql_dbg_edif, vha, 0x70e0,
+	 *   purex->msgp, purex->pur_info.pur_bytes_rcvd);
+	 */
+	beid.al_pa = purex->pur_info.pur_did.b.al_pa;
+	beid.area   = purex->pur_info.pur_did.b.area;
+	beid.domain = purex->pur_info.pur_did.b.domain;
+	host = qla_find_host_by_d_id(vha, beid);
+	if (!host) {
+		ql_log(ql_log_fatal, vha, 0x508b,
+		    "%s Drop ELS due to unable to find host %06x\n",
+		    __func__, purex->pur_info.pur_did.b24);
+
+		qla_els_reject_iocb(vha, (*rsp)->qpair, &a);
+		qla_enode_free(vha, ptr);
+		return;
+	}
+
+	fcport = qla2x00_find_fcport_by_pid(host, &purex->pur_info.pur_sid);
+
+	if (host->e_dbell.db_flags != EDB_ACTIVE ||
+	    (fcport && fcport->loop_id == FC_NO_LOOP_ID)) {
+		ql_dbg(ql_dbg_edif, host, 0x0910c, "%s e_dbell.db_flags =%x %06x\n",
+		    __func__, host->e_dbell.db_flags,
+		    fcport ? fcport->d_id.b24 : 0);
+
+		qla_els_reject_iocb(host, (*rsp)->qpair, &a);
+		qla_enode_free(host, ptr);
+		return;
+	}
+
+	/* add the local enode to the list */
+	qla_enode_add(host, ptr);
+
+	ql_dbg(ql_dbg_edif, host, 0x0910c,
+	    "%s COMPLETE purex->pur_info.pur_bytes_rcvd =%xh s:%06x -> d:%06x xchg=%xh\n",
+	    __func__, purex->pur_info.pur_bytes_rcvd,
+	    purex->pur_info.pur_sid.b24,
+	    purex->pur_info.pur_did.b24, p->rx_xchg_addr);
+}
+
 static void qla_parse_auth_els_ctl(struct srb *sp)
 {
 	struct qla_els_pt_arg *a = &sp->u.bsg_cmd.u.els_arg;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 7ff05aa10b2d..a4cb8092e97e 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -582,6 +582,7 @@ qla2xxx_msix_rsp_q_hs(int irq, void *dev_id);
 fc_port_t *qla2x00_find_fcport_by_loopid(scsi_qla_host_t *, uint16_t);
 fc_port_t *qla2x00_find_fcport_by_wwpn(scsi_qla_host_t *, u8 *, u8);
 fc_port_t *qla2x00_find_fcport_by_nportid(scsi_qla_host_t *, port_id_t *, u8);
+void __qla_consume_iocb(struct scsi_qla_host *vha, void **pkt, struct rsp_que **rsp);
 
 /*
  * Global Function Prototypes in qla_sup.c source file.
@@ -644,6 +645,8 @@ extern int qla2xxx_get_vpd_field(scsi_qla_host_t *, char *, char *, size_t);
 
 extern void qla2xxx_flash_npiv_conf(scsi_qla_host_t *);
 extern int qla24xx_read_fcp_prio_cfg(scsi_qla_host_t *);
+int __qla_copy_purex_to_buffer(struct scsi_qla_host *vha, void **pkt,
+	struct rsp_que **rsp, u8 *buf, u32 buf_len);
 
 /*
  * Global Function Prototypes in qla_dbg.c source file.
@@ -929,6 +932,7 @@ extern int qla_set_exchoffld_mem_cfg(scsi_qla_host_t *);
 extern void qlt_handle_abts_recv(struct scsi_qla_host *, struct rsp_que *,
 	response_t *);
 
+struct scsi_qla_host *qla_find_host_by_d_id(struct scsi_qla_host *vha, be_id_t d_id);
 int qla24xx_async_notify_ack(scsi_qla_host_t *, fc_port_t *,
 	struct imm_ntfy_from_isp *, int);
 void qla24xx_do_nack_work(struct scsi_qla_host *, struct qla_work_evt *);
@@ -941,7 +945,7 @@ extern struct fc_port *qlt_find_sess_invalidate_other(scsi_qla_host_t *,
 void qla24xx_delete_sess_fn(struct work_struct *);
 void qlt_unknown_atio_work_fn(struct work_struct *);
 void qlt_update_host_map(struct scsi_qla_host *, port_id_t);
-void qlt_remove_target_resources(struct qla_hw_data *);
+void qla_remove_hostmap(struct qla_hw_data *ha);
 void qlt_clr_qp_table(struct scsi_qla_host *vha);
 void qlt_set_mode(struct scsi_qla_host *);
 int qla2x00_set_data_rate(scsi_qla_host_t *vha, uint16_t mode);
@@ -961,6 +965,7 @@ void qla_edb_stop(scsi_qla_host_t *vha);
 int32_t qla_edif_app_mgmt(struct bsg_job *bsg_job);
 void qla_enode_init(scsi_qla_host_t *vha);
 void qla_enode_stop(scsi_qla_host_t *vha);
+void qla24xx_auth_els(scsi_qla_host_t *vha, void **pkt, struct rsp_que **rsp);
 void qla_handle_els_plogi_done(scsi_qla_host_t *vha, struct event_arg *ea);
 
 #define QLA2XX_HW_ERROR			BIT_0
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index a130a2db2cba..ea7635af03a8 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -169,6 +169,128 @@ qla24xx_process_abts(struct scsi_qla_host *vha, struct purex_item *pkt)
 	dma_free_coherent(&ha->pdev->dev, sizeof(*rsp_els), rsp_els, dma);
 }
 
+/* it is assumed pkt is the head iocb, not the continuation iocb */
+void __qla_consume_iocb(struct scsi_qla_host *vha,
+	void **pkt, struct rsp_que **rsp)
+{
+	struct rsp_que *rsp_q = *rsp;
+	response_t *new_pkt;
+	uint16_t entry_count_remaining;
+	struct purex_entry_24xx *purex = *pkt;
+
+	entry_count_remaining = purex->entry_count;
+	while (entry_count_remaining > 0) {
+		new_pkt = rsp_q->ring_ptr;
+		*pkt = new_pkt;
+
+		rsp_q->ring_index++;
+		if (rsp_q->ring_index == rsp_q->length) {
+			rsp_q->ring_index = 0;
+			rsp_q->ring_ptr = rsp_q->ring;
+		} else {
+			rsp_q->ring_ptr++;
+		}
+
+		new_pkt->signature = RESPONSE_PROCESSED;
+		// flush signature
+		wmb();
+		--entry_count_remaining;
+	}
+}
+
+int __qla_copy_purex_to_buffer(struct scsi_qla_host *vha,
+	void **pkt, struct rsp_que **rsp, u8 *buf, u32 buf_len)
+{
+	struct purex_entry_24xx *purex = *pkt;
+	struct rsp_que *rsp_q = *rsp;
+	sts_cont_entry_t *new_pkt;
+	uint16_t no_bytes = 0, total_bytes = 0, pending_bytes = 0;
+	uint16_t buffer_copy_offset = 0;
+	uint16_t entry_count_remaining;
+	u16 tpad;
+
+	entry_count_remaining = purex->entry_count;
+	total_bytes = (le16_to_cpu(purex->frame_size) & 0x0FFF)
+		- PURX_ELS_HEADER_SIZE;
+
+	/* end of payload may not end in 4bytes boundary.  Need to
+	 * round up / pad for room to swap, before saving data
+	 */
+	tpad = roundup(total_bytes, 4);
+
+	if (buf_len < tpad) {
+		ql_dbg(ql_dbg_async, vha, 0x5084,
+		    "%s buffer is too small %d < %d\n",
+		    __func__, buf_len, tpad);
+		__qla_consume_iocb(vha, pkt, rsp);
+		return -EIO;
+	}
+
+	pending_bytes = total_bytes = tpad;
+	no_bytes = (pending_bytes > sizeof(purex->els_frame_payload))  ?
+	sizeof(purex->els_frame_payload) : pending_bytes;
+
+	memcpy(buf, &purex->els_frame_payload[0], no_bytes);
+	buffer_copy_offset += no_bytes;
+	pending_bytes -= no_bytes;
+	--entry_count_remaining;
+
+	((response_t *)purex)->signature = RESPONSE_PROCESSED;
+	// flush signature
+	wmb();
+
+	do {
+		while ((total_bytes > 0) && (entry_count_remaining > 0)) {
+			new_pkt = (sts_cont_entry_t *)rsp_q->ring_ptr;
+			*pkt = new_pkt;
+
+			if (new_pkt->entry_type != STATUS_CONT_TYPE) {
+				ql_log(ql_log_warn, vha, 0x507a,
+				    "Unexpected IOCB type, partial data 0x%x\n",
+				    buffer_copy_offset);
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
+			    sizeof(new_pkt->data) : pending_bytes;
+			if ((buffer_copy_offset + no_bytes) <= total_bytes) {
+				memcpy((buf + buffer_copy_offset), new_pkt->data,
+				    no_bytes);
+				buffer_copy_offset += no_bytes;
+				pending_bytes -= no_bytes;
+				--entry_count_remaining;
+			} else {
+				ql_log(ql_log_warn, vha, 0x5044,
+				    "Attempt to copy more that we got, optimizing..%x\n",
+				    buffer_copy_offset);
+				memcpy((buf + buffer_copy_offset), new_pkt->data,
+				    total_bytes - buffer_copy_offset);
+			}
+
+			((response_t *)new_pkt)->signature = RESPONSE_PROCESSED;
+			// flush signature
+			wmb();
+		}
+
+		if (pending_bytes != 0 || entry_count_remaining != 0) {
+			ql_log(ql_log_fatal, vha, 0x508b,
+			    "Dropping partial Data, underrun bytes = 0x%x, entry cnts 0x%x\n",
+			    total_bytes, entry_count_remaining);
+			return -EIO;
+		}
+	} while (entry_count_remaining > 0);
+
+	be32_to_cpu_array((u32 *)buf, (__be32 *)buf, total_bytes >> 2);
+	return 0;
+}
+
 /**
  * qla2100_intr_handler() - Process interrupts for the ISP2100 and ISP2200.
  * @irq: interrupt number
@@ -1727,6 +1849,8 @@ qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
 	srb_t *sp;
 	uint16_t index;
 
+	if (pkt->handle == QLA_SKIP_HANDLE)
+		return NULL;
 	index = LSW(pkt->handle);
 	if (index >= req->num_outstanding_cmds) {
 		ql_log(ql_log_warn, vha, 0x5031,
@@ -3530,6 +3654,55 @@ void qla24xx_nvme_ls4_iocb(struct scsi_qla_host *vha,
 	sp->done(sp, comp_status);
 }
 
+/* check for all continuation iocbs are available. */
+static int qla_chk_cont_iocb_avail(struct scsi_qla_host *vha,
+	struct rsp_que *rsp, response_t *pkt)
+{
+	int start_pkt_ring_index, end_pkt_ring_index, n_ring_index;
+	response_t *end_pkt;
+	int rc = 0;
+	u32 rsp_q_in;
+
+	if (pkt->entry_count == 1)
+		return rc;
+
+	/* ring_index was pre-increment. set it back to current pkt */
+	if (rsp->ring_index == 0)
+		start_pkt_ring_index = rsp->length - 1;
+	else
+		start_pkt_ring_index = rsp->ring_index - 1;
+
+	if ((start_pkt_ring_index + pkt->entry_count) >= rsp->length)
+		end_pkt_ring_index = start_pkt_ring_index + pkt->entry_count -
+			rsp->length - 1;
+	else
+		end_pkt_ring_index = start_pkt_ring_index + pkt->entry_count - 1;
+
+	end_pkt = rsp->ring + end_pkt_ring_index;
+
+	//  next pkt = end_pkt + 1
+	n_ring_index = end_pkt_ring_index + 1;
+	if (n_ring_index >= rsp->length)
+		n_ring_index = 0;
+
+	rsp_q_in = rsp->qpair->use_shadow_reg ? *rsp->in_ptr :
+		rd_reg_dword(rsp->rsp_q_in);
+
+	/* rsp_q_in is either wrapped or pointing beyond endpkt */
+	if ((rsp_q_in < start_pkt_ring_index && rsp_q_in < n_ring_index) ||
+			rsp_q_in >= n_ring_index)
+		// all IOCBs arrived.
+		rc = 0;
+	else
+		rc = -EIO;
+
+	ql_dbg(ql_dbg_init + ql_dbg_verbose, vha, 0x5091,
+		"%s - ring %p pkt %p end pkt %p entry count %#x rsp_q_in %d rc %d\n",
+		__func__, rsp->ring, pkt, end_pkt, pkt->entry_count,
+		rsp_q_in, rc);
+	return rc;
+}
+
 /**
  * qla24xx_process_response_queue() - Process response queue entries.
  * @vha: SCSI driver HA context
@@ -3670,6 +3843,15 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 						 qla27xx_process_purex_fpin);
 				break;
 
+			case ELS_AUTH_ELS:
+				if (qla_chk_cont_iocb_avail(vha, rsp, (response_t *)pkt)) {
+					ql_dbg(ql_dbg_init, vha, 0x5091,
+					    "Defer processing ELS opcode %#x...\n",
+					    purex_entry->els_frame_payload[3]);
+					return;
+				}
+				qla24xx_auth_els(vha, (void **)&pkt, &rsp);
+				break;
 			default:
 				ql_log(ql_log_warn, vha, 0x509c,
 				       "Discarding ELS Request opcode 0x%x\n",
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 5e39977af9ba..6be06b994c43 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3797,7 +3797,6 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	qla2x00_free_sysfs_attr(base_vha, true);
 
 	fc_remove_host(base_vha->host);
-	qlt_remove_target_resources(ha);
 
 	scsi_remove_host(base_vha->host);
 
@@ -3974,15 +3973,20 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	struct req_que **req, struct rsp_que **rsp)
 {
 	char	name[16];
+	int rc;
 
 	ha->init_cb = dma_alloc_coherent(&ha->pdev->dev, ha->init_cb_size,
 		&ha->init_cb_dma, GFP_KERNEL);
 	if (!ha->init_cb)
 		goto fail;
 
-	if (qlt_mem_alloc(ha) < 0)
+	rc = btree_init32(&ha->host_map);
+	if (rc)
 		goto fail_free_init_cb;
 
+	if (qlt_mem_alloc(ha) < 0)
+		goto fail_free_btree;
+
 	ha->gid_list = dma_alloc_coherent(&ha->pdev->dev,
 		qla2x00_gid_list_size(ha), &ha->gid_list_dma, GFP_KERNEL);
 	if (!ha->gid_list)
@@ -4386,6 +4390,8 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	ha->gid_list_dma = 0;
 fail_free_tgt_mem:
 	qlt_mem_free(ha);
+fail_free_btree:
+	btree_destroy32(&ha->host_map);
 fail_free_init_cb:
 	dma_free_coherent(&ha->pdev->dev, ha->init_cb_size, ha->init_cb,
 	ha->init_cb_dma);
@@ -4802,6 +4808,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	ha->dif_bundl_pool = NULL;
 
 	qlt_mem_free(ha);
+	qla_remove_hostmap(ha);
 
 	if (ha->init_cb)
 		dma_free_coherent(&ha->pdev->dev, ha->init_cb_size,
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index abf18b88579c..365e64ebef8b 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -197,7 +197,7 @@ struct scsi_qla_host *qla_find_host_by_d_id(struct scsi_qla_host *vha,
 
 	key = be_to_port_id(d_id).b24;
 
-	host = btree_lookup32(&vha->hw->tgt.host_map, key);
+	host = btree_lookup32(&vha->hw->host_map, key);
 	if (!host)
 		ql_dbg(ql_dbg_tgt_mgt + ql_dbg_verbose, vha, 0xf005,
 		    "Unable to find host %06x\n", key);
@@ -6442,15 +6442,15 @@ int qlt_remove_target(struct qla_hw_data *ha, struct scsi_qla_host *vha)
 	return 0;
 }
 
-void qlt_remove_target_resources(struct qla_hw_data *ha)
+void qla_remove_hostmap(struct qla_hw_data *ha)
 {
 	struct scsi_qla_host *node;
 	u32 key = 0;
 
-	btree_for_each_safe32(&ha->tgt.host_map, key, node)
-		btree_remove32(&ha->tgt.host_map, key);
+	btree_for_each_safe32(&ha->host_map, key, node)
+		btree_remove32(&ha->host_map, key);
 
-	btree_destroy32(&ha->tgt.host_map);
+	btree_destroy32(&ha->host_map);
 }
 
 static void qlt_lport_dump(struct scsi_qla_host *vha, u64 wwpn,
@@ -7078,8 +7078,7 @@ qlt_modify_vp_config(struct scsi_qla_host *vha,
 void
 qlt_probe_one_stage1(struct scsi_qla_host *base_vha, struct qla_hw_data *ha)
 {
-	int rc;
-
+	mutex_init(&base_vha->vha_tgt.tgt_mutex);
 	if (!QLA_TGT_MODE_ENABLED())
 		return;
 
@@ -7092,7 +7091,6 @@ qlt_probe_one_stage1(struct scsi_qla_host *base_vha, struct qla_hw_data *ha)
 		ISP_ATIO_Q_OUT(base_vha) = &ha->iobase->isp24.atio_q_out;
 	}
 
-	mutex_init(&base_vha->vha_tgt.tgt_mutex);
 	mutex_init(&base_vha->vha_tgt.tgt_host_action_mutex);
 
 	INIT_LIST_HEAD(&base_vha->unknown_atio_list);
@@ -7101,11 +7099,6 @@ qlt_probe_one_stage1(struct scsi_qla_host *base_vha, struct qla_hw_data *ha)
 
 	qlt_clear_mode(base_vha);
 
-	rc = btree_init32(&ha->tgt.host_map);
-	if (rc)
-		ql_log(ql_log_info, base_vha, 0xd03d,
-		    "Unable to initialize ha->host_map btree\n");
-
 	qlt_update_vp_map(base_vha, SET_VP_IDX);
 }
 
@@ -7226,21 +7219,20 @@ qlt_update_vp_map(struct scsi_qla_host *vha, int cmd)
 	u32 key;
 	int rc;
 
-	if (!QLA_TGT_MODE_ENABLED())
-		return;
-
 	key = vha->d_id.b24;
 
 	switch (cmd) {
 	case SET_VP_IDX:
+		if (!QLA_TGT_MODE_ENABLED())
+			return;
 		vha->hw->tgt.tgt_vp_map[vha->vp_idx].vha = vha;
 		break;
 	case SET_AL_PA:
-		slot = btree_lookup32(&vha->hw->tgt.host_map, key);
+		slot = btree_lookup32(&vha->hw->host_map, key);
 		if (!slot) {
 			ql_dbg(ql_dbg_tgt_mgt, vha, 0xf018,
 			    "Save vha in host_map %p %06x\n", vha, key);
-			rc = btree_insert32(&vha->hw->tgt.host_map,
+			rc = btree_insert32(&vha->hw->host_map,
 				key, vha, GFP_ATOMIC);
 			if (rc)
 				ql_log(ql_log_info, vha, 0xd03e,
@@ -7250,17 +7242,19 @@ qlt_update_vp_map(struct scsi_qla_host *vha, int cmd)
 		}
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf019,
 		    "replace existing vha in host_map %p %06x\n", vha, key);
-		btree_update32(&vha->hw->tgt.host_map, key, vha);
+		btree_update32(&vha->hw->host_map, key, vha);
 		break;
 	case RESET_VP_IDX:
+		if (!QLA_TGT_MODE_ENABLED())
+			return;
 		vha->hw->tgt.tgt_vp_map[vha->vp_idx].vha = NULL;
 		break;
 	case RESET_AL_PA:
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf01a,
 		   "clear vha in host_map %p %06x\n", vha, key);
-		slot = btree_lookup32(&vha->hw->tgt.host_map, key);
+		slot = btree_lookup32(&vha->hw->host_map, key);
 		if (slot)
-			btree_remove32(&vha->hw->tgt.host_map, key);
+			btree_remove32(&vha->hw->host_map, key);
 		vha->d_id.b24 = 0;
 		break;
 	}
-- 
2.19.0.rc0

