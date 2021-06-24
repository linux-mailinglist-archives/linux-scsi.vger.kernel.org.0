Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4420D3B26C4
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Jun 2021 07:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFXFax (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Jun 2021 01:30:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:9872 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230091AbhFXFaw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 24 Jun 2021 01:30:52 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O5FgA1024112
        for <linux-scsi@vger.kernel.org>; Wed, 23 Jun 2021 22:28:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=XIGWhxZy5D7HOeuFoiXJ5dPjvF8yOYM6hbWeda6sPwk=;
 b=Pn6XsGas8wSL2uW3mcpklvJVoi31sPRU5UTaz6hwX0YtG5O9pfzk2NpIfiZEPC3UPGSM
 U5Yalv9NNjoUD3BeQ0ZMm9a3jNNaaSMPvq9az6MZjLsXVGlY3vcv/IEMK8PgHqzXptZn
 626mOChwOLLJBo5FL74Rs9lYtLnmSe8IIvg830kj900Mf9bPNrlP/SWvA4i4++WaJxKa
 xQlkPc/h7YFyHhzjGRokN0AZsUrZO4aIpMWMKlewFEBKsHwl9NYdBqhfGJwGrGctOzgd
 vnnHbKBWT+CeOZkqr2fMHlzxVtixwkm5BEASyrWtByRKBbpBD/BlrjQ4v9p38dcgf/1I GA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 39cgc88r2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 23 Jun 2021 22:28:33 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Jun
 2021 22:28:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 23 Jun 2021 22:28:31 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id EEE0C5B6951;
        Wed, 23 Jun 2021 22:28:31 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 15O5SVSN021684;
        Wed, 23 Jun 2021 22:28:31 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 15O5SVjh021683;
        Wed, 23 Jun 2021 22:28:31 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v4 05/11] qla2xxx: Add key update
Date:   Wed, 23 Jun 2021 22:26:00 -0700
Message-ID: <20210624052606.21613-6-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210624052606.21613-1-njavali@marvell.com>
References: <20210624052606.21613-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BfEM3iTSPZpcLG57Aq80S7WQElVZeECx
X-Proofpoint-GUID: BfEM3iTSPZpcLG57Aq80S7WQElVZeECx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_03:2021-06-23,2021-06-24 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Latest FC adapter from Marvell has the ability to encrypt
data in flight (EDIF) feature. This feature require an
application (ex: ipsec, etc) to act as an authenticator.

As part of the authentication process, the authentication
application will generate a SADB entry (Security Association/SA,
key, SPI value, etc). This SADB is then pass to driver
to be programmed into hardware. There will be a pair of
SADB's (Tx and Rx) for each connection.

After some period, the application can choose to change the
key. At that time, a new set of SADB pair is given to driver.
The old set of SADB will be deleted.

This patch add a new bsg call (QL_VND_SC_SA_UPDATE) to allow
application to allow add | delete of SADB.  Driver will not
keep the key in memory. It will pass it to HW.

It is assume that application will assign a unique SPI value
to this SADB(SA + key). Driver + HW will assign a handle
to track this unique SPI/SADB.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Larry Wisneski <Larry.Wisneski@marvell.com>
Signed-off-by: Duane Grigsby <duane.grigsby@marvell.com>
Signed-off-by: Rick Hicksted Jr <rhicksted@marvell.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h    |   69 ++
 drivers/scsi/qla2xxx/qla_edif.c   | 1480 ++++++++++++++++++++++++++++-
 drivers/scsi/qla2xxx/qla_edif.h   |   61 ++
 drivers/scsi/qla2xxx/qla_fw.h     |    1 +
 drivers/scsi/qla2xxx/qla_gbl.h    |   21 +
 drivers/scsi/qla2xxx/qla_init.c   |   10 +
 drivers/scsi/qla2xxx/qla_iocb.c   |    6 +
 drivers/scsi/qla2xxx/qla_isr.c    |    8 +
 drivers/scsi/qla2xxx/qla_os.c     |   17 +
 drivers/scsi/qla2xxx/qla_target.h |    2 +-
 10 files changed, 1668 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 485e427c1ff1..3e4c4cfbf7d4 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -401,6 +401,7 @@ struct srb_cmd {
 #define SRB_CRC_CTX_DSD_VALID		BIT_5	/* DIF: dsd_list valid */
 #define SRB_WAKEUP_ON_COMP		BIT_6
 #define SRB_DIF_BUNDL_DMA_VALID		BIT_7   /* DIF: DMA list valid */
+#define SRB_EDIF_CLEANUP_DELETE		BIT_9
 
 /* To identify if a srb is of T10-CRC type. @sp => srb_t pointer */
 #define IS_PROT_IO(sp)	(sp->flags & SRB_CRC_CTX_DSD_VALID)
@@ -595,6 +596,10 @@ struct srb_iocb {
 			u16 cmd;
 			u16 vp_index;
 		} ctrlvp;
+		struct {
+			struct edif_sa_ctl	*sa_ctl;
+			struct qla_sa_update_frame sa_frame;
+		} sa_update;
 	} u;
 
 	struct timer_list timer;
@@ -2616,7 +2621,12 @@ typedef struct fc_port {
 		uint32_t	app_stop:2;
 		uint32_t	app_started:1;
 		uint32_t	secured_login:1;
+		uint32_t	aes_gmac:1;
 		uint32_t	app_sess_online:1;
+		uint32_t	tx_sa_set:1;
+		uint32_t	rx_sa_set:1;
+		uint32_t	tx_sa_pending:1;
+		uint32_t	rx_sa_pending:1;
 		uint32_t	tx_rekey_cnt;
 		uint32_t	rx_rekey_cnt;
 		uint64_t	tx_bytes;
@@ -2624,6 +2634,12 @@ typedef struct fc_port {
 		uint8_t		non_secured_login;
 		uint8_t		auth_state;
 		uint16_t	rekey_cnt;
+		struct list_head edif_indx_list;
+		spinlock_t  indx_list_lock;
+
+		struct list_head tx_sa_list;
+		struct list_head rx_sa_list;
+		spinlock_t	sa_list_lock;
 	} edif;
 } fc_port_t;
 
@@ -2679,6 +2695,7 @@ static const char * const port_dstate_str[] = {
 #define FCF_CONF_COMP_SUPPORTED BIT_4
 #define FCF_ASYNC_ACTIVE	BIT_5
 #define FCF_FCSP_DEVICE		BIT_6
+#define FCF_EDIF_DELETE		BIT_7
 
 /* No loop ID flag. */
 #define FC_NO_LOOP_ID		0x1000
@@ -3449,6 +3466,7 @@ enum qla_work_type {
 	QLA_EVT_SP_RETRY,
 	QLA_EVT_IIDMA,
 	QLA_EVT_ELS_PLOGI,
+	QLA_EVT_SA_REPLACE,
 };
 
 
@@ -3507,6 +3525,11 @@ struct qla_work_evt {
 			u8 fc4_type;
 			srb_t *sp;
 		} gpnft;
+		struct {
+			struct edif_sa_ctl	*sa_ctl;
+			fc_port_t *fcport;
+			uint16_t nport_handle;
+		} sa_update;
 	 } u;
 };
 
@@ -4684,6 +4707,16 @@ struct qla_hw_data {
 	u64 prev_cmd_cnt;
 	struct dma_pool *purex_dma_pool;
 	struct btree_head32 host_map;
+
+#define EDIF_NUM_SA_INDEX	512
+#define EDIF_TX_SA_INDEX_BASE	EDIF_NUM_SA_INDEX
+	void *edif_rx_sa_id_map;
+	void *edif_tx_sa_id_map;
+	spinlock_t sadb_fp_lock;
+
+	struct list_head sadb_tx_index_list;
+	struct list_head sadb_rx_index_list;
+	spinlock_t sadb_lock;	/* protects list */
 	struct els_reject elsrej;
 };
 
@@ -5160,7 +5193,43 @@ enum nexus_wait_type {
 	WAIT_LUN,
 };
 
+#define INVALID_EDIF_SA_INDEX	0xffff
+#define RX_DELETE_NO_EDIF_SA_INDEX	0xfffe
+
 #define QLA_SKIP_HANDLE QLA_TGT_SKIP_HANDLE
+
+/* edif hash element */
+struct edif_list_entry {
+	uint16_t handle;			/* nport_handle */
+	uint32_t update_sa_index;
+	uint32_t delete_sa_index;
+	uint32_t count;				/* counter for filtering sa_index */
+#define EDIF_ENTRY_FLAGS_CLEANUP	0x01	/* this index is being cleaned up */
+	uint32_t flags;				/* used by sadb cleanup code */
+	fc_port_t *fcport;			/* needed by rx delay timer function */
+	struct timer_list timer;		/* rx delay timer */
+	struct list_head next;
+};
+
+#define EDIF_TX_INDX_BASE 512
+#define EDIF_RX_INDX_BASE 0
+#define EDIF_RX_DELETE_FILTER_COUNT 3	/* delay queuing rx delete until this many */
+
+/* entry in the sa_index free pool */
+
+struct sa_index_pair {
+	uint16_t sa_index;
+	uint32_t spi;
+};
+
+/* edif sa_index data structure */
+struct edif_sa_index_entry {
+	struct sa_index_pair sa_pair[2];
+	fc_port_t *fcport;
+	uint16_t handle;
+	struct list_head next;
+};
+
 /* Refer to SNIA SFF 8247 */
 struct sff_8247_a0 {
 	u8 txid;	/* transceiver id */
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index e50f8d7d9d94..15f9e10ac257 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -11,6 +11,12 @@
 #include <linux/delay.h>
 #include <scsi/scsi_tcq.h>
 
+static struct edif_sa_index_entry *qla_edif_sadb_find_sa_index_entry(uint16_t nport_handle,
+		struct list_head *sa_list);
+static uint16_t qla_edif_sadb_get_sa_index(fc_port_t *fcport,
+		struct qla_sa_update_frame *sa_frame);
+static int qla_edif_sadb_delete_sa_index(fc_port_t *fcport, uint16_t nport_handle,
+		uint16_t sa_index);
 static int qla_pur_get_pending(scsi_qla_host_t *, fc_port_t *, struct bsg_job *);
 
 static struct els_sub_cmd {
@@ -35,14 +41,151 @@ const char *sc_to_str(uint16_t cmd)
 	return "unknown";
 }
 
+static struct edif_list_entry *qla_edif_list_find_sa_index(fc_port_t *fcport,
+		uint16_t handle)
+{
+	struct edif_list_entry *entry;
+	struct edif_list_entry *tentry;
+	struct list_head *indx_list = &fcport->edif.edif_indx_list;
+
+	list_for_each_entry_safe(entry, tentry, indx_list, next) {
+		if (entry->handle == handle)
+			return entry;
+	}
+	return NULL;
+}
+
+/* timeout called when no traffic and delayed rx sa_index delete */
+static void qla2x00_sa_replace_iocb_timeout(struct timer_list *t)
+{
+	struct edif_list_entry *edif_entry = from_timer(edif_entry, t, timer);
+	fc_port_t *fcport = edif_entry->fcport;
+	struct scsi_qla_host *vha = fcport->vha;
+	struct  edif_sa_ctl *sa_ctl;
+	uint16_t nport_handle;
+	unsigned long flags = 0;
+
+	ql_dbg(ql_dbg_edif, vha, 0x3069,
+	    "%s:  nport_handle 0x%x,  SA REPL Delay Timeout, %8phC portid=%06x\n",
+	    __func__, edif_entry->handle, fcport->port_name, fcport->d_id.b24);
+
+	/*
+	 * if delete_sa_index is valid then no one has serviced this
+	 * delayed delete
+	 */
+	spin_lock_irqsave(&fcport->edif.indx_list_lock, flags);
+
+	/*
+	 * delete_sa_index is invalidated when we find the new sa_index in
+	 * the incoming data stream.  If it is not invalidated then we are
+	 * still looking for the new sa_index because there is no I/O and we
+	 * need to just force the rx delete and move on.  Otherwise
+	 * we could get another rekey which will result in an error 66.
+	 */
+	if (edif_entry->delete_sa_index != INVALID_EDIF_SA_INDEX) {
+		uint16_t delete_sa_index = edif_entry->delete_sa_index;
+
+		edif_entry->delete_sa_index = INVALID_EDIF_SA_INDEX;
+		nport_handle = edif_entry->handle;
+		spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+
+		sa_ctl = qla_edif_find_sa_ctl_by_index(fcport,
+		    delete_sa_index, 0);
+
+		if (sa_ctl) {
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: sa_ctl: %p, delete index %d, update index: %d, lid: 0x%x\n",
+			    __func__, sa_ctl, delete_sa_index, edif_entry->update_sa_index,
+			    nport_handle);
+
+			sa_ctl->flags = EDIF_SA_CTL_FLG_DEL;
+			set_bit(EDIF_SA_CTL_REPL, &sa_ctl->state);
+			qla_post_sa_replace_work(fcport->vha, fcport,
+			    nport_handle, sa_ctl);
+
+		} else {
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: sa_ctl not found for delete_sa_index: %d\n",
+			    __func__, edif_entry->delete_sa_index);
+		}
+	} else {
+		spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+	}
+}
+
+/*
+ * create a new list entry for this nport handle and
+ * add an sa_update index to the list - called for sa_update
+ */
+static int qla_edif_list_add_sa_update_index(fc_port_t *fcport,
+		uint16_t sa_index, uint16_t handle)
+{
+	struct edif_list_entry *entry;
+	unsigned long flags = 0;
+
+	/* if the entry exists, then just update the sa_index */
+	entry = qla_edif_list_find_sa_index(fcport, handle);
+	if (entry) {
+		entry->update_sa_index = sa_index;
+		entry->count = 0;
+		return 0;
+	}
+
+	/*
+	 * This is the normal path - there should be no existing entry
+	 * when update is called.  The exception is at startup
+	 * when update is called for the first two sa_indexes
+	 * followed by a delete of the first sa_index
+	 */
+	entry = kzalloc((sizeof(struct edif_list_entry)), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&entry->next);
+	entry->handle = handle;
+	entry->update_sa_index = sa_index;
+	entry->delete_sa_index = INVALID_EDIF_SA_INDEX;
+	entry->count = 0;
+	entry->flags = 0;
+	timer_setup(&entry->timer, qla2x00_sa_replace_iocb_timeout, 0);
+	spin_lock_irqsave(&fcport->edif.indx_list_lock, flags);
+	list_add_tail(&entry->next, &fcport->edif.edif_indx_list);
+	spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+	return 0;
+}
+
+/* remove an entry from the list */
+static void qla_edif_list_delete_sa_index(fc_port_t *fcport, struct edif_list_entry *entry)
+{
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&fcport->edif.indx_list_lock, flags);
+	list_del(&entry->next);
+	spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+}
+
+int qla_post_sa_replace_work(struct scsi_qla_host *vha,
+	 fc_port_t *fcport, uint16_t nport_handle, struct edif_sa_ctl *sa_ctl)
+{
+	struct qla_work_evt *e;
+
+	e = qla2x00_alloc_work(vha, QLA_EVT_SA_REPLACE);
+	if (!e)
+		return QLA_FUNCTION_FAILED;
+
+	e->u.sa_update.fcport = fcport;
+	e->u.sa_update.sa_ctl = sa_ctl;
+	e->u.sa_update.nport_handle = nport_handle;
+	fcport->flags |= FCF_ASYNC_ACTIVE;
+	return qla2x00_post_work(vha, e);
+}
+
 static void
 qla_edif_sa_ctl_init(scsi_qla_host_t *vha, struct fc_port  *fcport)
 {
 	ql_dbg(ql_dbg_edif, vha, 0x2058,
-		"Init SA_CTL List for fcport - nn %8phN pn %8phN portid=%02x%02x%02x.\n",
-		fcport->node_name, fcport->port_name,
-		fcport->d_id.b.domain, fcport->d_id.b.area,
-		fcport->d_id.b.al_pa);
+	    "Init SA_CTL List for fcport - nn %8phN pn %8phN portid=%06x.\n",
+	    fcport->node_name, fcport->port_name, fcport->d_id.b24);
 
 	fcport->edif.tx_rekey_cnt = 0;
 	fcport->edif.rx_rekey_cnt = 0;
@@ -60,13 +203,11 @@ fc_port_t *fcport)
 	    (struct qla_bsg_auth_els_request *)bsg_job->request;
 
 	if (!vha->hw->flags.edif_enabled) {
-		/* edif support not enabled */
 		ql_dbg(ql_dbg_edif, vha, 0x9105,
 		    "%s edif not enabled\n", __func__);
 		goto done;
 	}
 	if (vha->e_dbell.db_flags != EDB_ACTIVE) {
-		/* doorbell list not enabled */
 		ql_dbg(ql_dbg_edif, vha, 0x09102,
 		    "%s doorbell not enabled\n", __func__);
 		goto done;
@@ -195,6 +336,167 @@ static void qla_edif_reset_auth_wait(struct fc_port *fcport, int state,
 	}
 }
 
+static void
+qla_edif_free_sa_ctl(fc_port_t *fcport, struct edif_sa_ctl *sa_ctl,
+	int index)
+{
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&fcport->edif.sa_list_lock, flags);
+	list_del(&sa_ctl->next);
+	spin_unlock_irqrestore(&fcport->edif.sa_list_lock, flags);
+	if (index >= 512)
+		fcport->edif.tx_rekey_cnt--;
+	else
+		fcport->edif.rx_rekey_cnt--;
+	kfree(sa_ctl);
+}
+
+/* return an index to the freepool */
+static void qla_edif_add_sa_index_to_freepool(fc_port_t *fcport, int dir,
+		uint16_t sa_index)
+{
+	void *sa_id_map;
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags = 0;
+	u16 lsa_index = sa_index;
+
+	ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x3063,
+	    "%s: entry\n", __func__);
+
+	if (dir) {
+		sa_id_map = ha->edif_tx_sa_id_map;
+		lsa_index -= EDIF_TX_SA_INDEX_BASE;
+	} else {
+		sa_id_map = ha->edif_rx_sa_id_map;
+	}
+
+	spin_lock_irqsave(&ha->sadb_fp_lock, flags);
+	clear_bit(lsa_index, sa_id_map);
+	spin_unlock_irqrestore(&ha->sadb_fp_lock, flags);
+	ql_dbg(ql_dbg_edif, vha, 0x3063,
+	    "%s: index %d added to free pool\n", __func__, sa_index);
+}
+
+static void __qla2x00_release_all_sadb(struct scsi_qla_host *vha,
+	struct fc_port *fcport, struct edif_sa_index_entry *entry,
+	int pdir)
+{
+	struct edif_list_entry *edif_entry;
+	struct  edif_sa_ctl *sa_ctl;
+	int i, dir;
+	int key_cnt = 0;
+
+	for (i = 0; i < 2; i++) {
+		if (entry->sa_pair[i].sa_index == INVALID_EDIF_SA_INDEX)
+			continue;
+
+		if (fcport->loop_id != entry->handle) {
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: ** WARNING %d** entry handle: 0x%x, lid: 0x%x, sa_index: %d\n",
+			    __func__, i, entry->handle, fcport->loop_id,
+			    entry->sa_pair[i].sa_index);
+		}
+
+		/* release the sa_ctl */
+		sa_ctl = qla_edif_find_sa_ctl_by_index(fcport,
+				entry->sa_pair[i].sa_index, pdir);
+		if (sa_ctl &&
+		    qla_edif_find_sa_ctl_by_index(fcport, sa_ctl->index, pdir)) {
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: freeing sa_ctl for index %d\n", __func__, sa_ctl->index);
+			qla_edif_free_sa_ctl(fcport, sa_ctl, sa_ctl->index);
+		} else {
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: sa_ctl NOT freed, sa_ctl: %p\n", __func__, sa_ctl);
+		}
+
+		/* Release the index */
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+			"%s: freeing sa_index %d, nph: 0x%x\n",
+			__func__, entry->sa_pair[i].sa_index, entry->handle);
+
+		dir = (entry->sa_pair[i].sa_index <
+			EDIF_TX_SA_INDEX_BASE) ? 0 : 1;
+		qla_edif_add_sa_index_to_freepool(fcport, dir,
+			entry->sa_pair[i].sa_index);
+
+		/* Delete timer on RX */
+		if (pdir != SAU_FLG_TX) {
+			edif_entry =
+				qla_edif_list_find_sa_index(fcport, entry->handle);
+			if (edif_entry) {
+				ql_dbg(ql_dbg_edif, vha, 0x5033,
+				    "%s: remove edif_entry %p, update_sa_index: 0x%x, delete_sa_index: 0x%x\n",
+				    __func__, edif_entry, edif_entry->update_sa_index,
+				    edif_entry->delete_sa_index);
+				qla_edif_list_delete_sa_index(fcport, edif_entry);
+				/*
+				 * valid delete_sa_index indicates there is a rx
+				 * delayed delete queued
+				 */
+				if (edif_entry->delete_sa_index !=
+						INVALID_EDIF_SA_INDEX) {
+					del_timer(&edif_entry->timer);
+
+					/* build and send the aen */
+					fcport->edif.rx_sa_set = 1;
+					fcport->edif.rx_sa_pending = 0;
+				}
+				ql_dbg(ql_dbg_edif, vha, 0x5033,
+				    "%s: release edif_entry %p, update_sa_index: 0x%x, delete_sa_index: 0x%x\n",
+				    __func__, edif_entry, edif_entry->update_sa_index,
+				    edif_entry->delete_sa_index);
+
+				kfree(edif_entry);
+			}
+		}
+		key_cnt++;
+	}
+	ql_dbg(ql_dbg_edif, vha, 0x3063,
+	    "%s: %d %s keys released\n",
+	    __func__, key_cnt, pdir ? "tx" : "rx");
+}
+
+/* find an release all outstanding sadb sa_indicies */
+void qla2x00_release_all_sadb(struct scsi_qla_host *vha, struct fc_port *fcport)
+{
+	struct edif_sa_index_entry *entry, *tmp;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags;
+
+	ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x3063,
+	    "%s: Starting...\n", __func__);
+
+	spin_lock_irqsave(&ha->sadb_lock, flags);
+
+	list_for_each_entry_safe(entry, tmp, &ha->sadb_rx_index_list, next) {
+		if (entry->fcport == fcport) {
+			list_del(&entry->next);
+			spin_unlock_irqrestore(&ha->sadb_lock, flags);
+			__qla2x00_release_all_sadb(vha, fcport, entry, 0);
+			kfree(entry);
+			spin_lock_irqsave(&ha->sadb_lock, flags);
+			break;
+		}
+	}
+
+	list_for_each_entry_safe(entry, tmp, &ha->sadb_tx_index_list, next) {
+		if (entry->fcport == fcport) {
+			list_del(&entry->next);
+			spin_unlock_irqrestore(&ha->sadb_lock, flags);
+
+			__qla2x00_release_all_sadb(vha, fcport, entry, SAU_FLG_TX);
+
+			kfree(entry);
+			spin_lock_irqsave(&ha->sadb_lock, flags);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&ha->sadb_lock, flags);
+}
+
 /**
  * qla_edif_app_start:  application has announce its present
  * @vha: host adapter pointer
@@ -576,6 +878,10 @@ qla_edif_app_mgmt(struct bsg_job *bsg_job)
 	}
 
 	switch (vnd_sc) {
+	case QL_VND_SC_SA_UPDATE:
+		done = false;
+		rval = qla24xx_sadb_update(bsg_job);
+		break;
 	case QL_VND_SC_APP_START:
 		rval = qla_edif_app_start(vha, bsg_job);
 		break;
@@ -609,6 +915,438 @@ qla_edif_app_mgmt(struct bsg_job *bsg_job)
 	return rval;
 }
 
+static struct edif_sa_ctl *
+qla_edif_add_sa_ctl(fc_port_t *fcport, struct qla_sa_update_frame *sa_frame,
+	int dir)
+{
+	struct	edif_sa_ctl *sa_ctl;
+	struct qla_sa_update_frame *sap;
+	int	index = sa_frame->fast_sa_index;
+	unsigned long flags = 0;
+
+	sa_ctl = kzalloc(sizeof(*sa_ctl), GFP_KERNEL);
+	if (!sa_ctl) {
+		/* couldn't get space */
+		ql_dbg(ql_dbg_edif, fcport->vha, 0x9100,
+		    "unable to allocate SA CTL\n");
+		return NULL;
+	}
+
+	/*
+	 * need to allocate sa_index here and save it
+	 * in both sa_ctl->index and sa_frame->fast_sa_index;
+	 * If alloc fails then delete sa_ctl and return NULL
+	 */
+	INIT_LIST_HEAD(&sa_ctl->next);
+	sap = &sa_ctl->sa_frame;
+	*sap = *sa_frame;
+	sa_ctl->index = index;
+	sa_ctl->fcport = fcport;
+	sa_ctl->flags = 0;
+	sa_ctl->state = 0L;
+	ql_dbg(ql_dbg_edif, fcport->vha, 0x9100,
+	    "%s: Added sa_ctl %p, index %d, state 0x%lx\n",
+	    __func__, sa_ctl, sa_ctl->index, sa_ctl->state);
+	spin_lock_irqsave(&fcport->edif.sa_list_lock, flags);
+	if (dir == SAU_FLG_TX)
+		list_add_tail(&sa_ctl->next, &fcport->edif.tx_sa_list);
+	else
+		list_add_tail(&sa_ctl->next, &fcport->edif.rx_sa_list);
+	spin_unlock_irqrestore(&fcport->edif.sa_list_lock, flags);
+
+	return sa_ctl;
+}
+
+void
+qla_edif_flush_sa_ctl_lists(fc_port_t *fcport)
+{
+	struct edif_sa_ctl *sa_ctl, *tsa_ctl;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&fcport->edif.sa_list_lock, flags);
+
+	list_for_each_entry_safe(sa_ctl, tsa_ctl, &fcport->edif.tx_sa_list,
+	    next) {
+		list_del(&sa_ctl->next);
+		kfree(sa_ctl);
+	}
+
+	list_for_each_entry_safe(sa_ctl, tsa_ctl, &fcport->edif.rx_sa_list,
+	    next) {
+		list_del(&sa_ctl->next);
+		kfree(sa_ctl);
+	}
+
+	spin_unlock_irqrestore(&fcport->edif.sa_list_lock, flags);
+}
+
+struct edif_sa_ctl *
+qla_edif_find_sa_ctl_by_index(fc_port_t *fcport, int index, int dir)
+{
+	struct edif_sa_ctl *sa_ctl, *tsa_ctl;
+	struct list_head *sa_list;
+
+	if (dir == SAU_FLG_TX)
+		sa_list = &fcport->edif.tx_sa_list;
+	else
+		sa_list = &fcport->edif.rx_sa_list;
+
+	list_for_each_entry_safe(sa_ctl, tsa_ctl, sa_list, next) {
+		if (test_bit(EDIF_SA_CTL_USED, &sa_ctl->state) &&
+		    sa_ctl->index == index)
+			return sa_ctl;
+	}
+	return NULL;
+}
+
+/* add the sa to the correct list */
+static int
+qla24xx_check_sadb_avail_slot(struct bsg_job *bsg_job, fc_port_t *fcport,
+	struct qla_sa_update_frame *sa_frame)
+{
+	struct edif_sa_ctl *sa_ctl = NULL;
+	int dir;
+	uint16_t sa_index;
+
+	dir = (sa_frame->flags & SAU_FLG_TX);
+
+	/* map the spi to an sa_index */
+	sa_index = qla_edif_sadb_get_sa_index(fcport, sa_frame);
+	if (sa_index == RX_DELETE_NO_EDIF_SA_INDEX) {
+		/* process rx delete */
+		ql_dbg(ql_dbg_edif, fcport->vha, 0x3063,
+		    "%s: rx delete for lid 0x%x, spi 0x%x, no entry found\n",
+		    __func__, fcport->loop_id, sa_frame->spi);
+
+		/* build and send the aen */
+		fcport->edif.rx_sa_set = 1;
+		fcport->edif.rx_sa_pending = 0;
+
+		/* force a return of good bsg status; */
+		return RX_DELETE_NO_EDIF_SA_INDEX;
+	} else if (sa_index == INVALID_EDIF_SA_INDEX) {
+		ql_dbg(ql_dbg_edif, fcport->vha, 0x9100,
+		    "%s: Failed to get sa_index for spi 0x%x, dir: %d\n",
+		    __func__, sa_frame->spi, dir);
+		return INVALID_EDIF_SA_INDEX;
+	}
+
+	ql_dbg(ql_dbg_edif, fcport->vha, 0x9100,
+	    "%s: index %d allocated to spi 0x%x, dir: %d, nport_handle: 0x%x\n",
+	    __func__, sa_index, sa_frame->spi, dir, fcport->loop_id);
+
+	/* This is a local copy of sa_frame. */
+	sa_frame->fast_sa_index = sa_index;
+	/* create the sa_ctl */
+	sa_ctl = qla_edif_add_sa_ctl(fcport, sa_frame, dir);
+	if (!sa_ctl) {
+		ql_dbg(ql_dbg_edif, fcport->vha, 0x9100,
+		    "%s: Failed to add sa_ctl for spi 0x%x, dir: %d, sa_index: %d\n",
+		    __func__, sa_frame->spi, dir, sa_index);
+		return -1;
+	}
+
+	set_bit(EDIF_SA_CTL_USED, &sa_ctl->state);
+
+	if (dir == SAU_FLG_TX)
+		fcport->edif.tx_rekey_cnt++;
+	else
+		fcport->edif.rx_rekey_cnt++;
+
+	ql_dbg(ql_dbg_edif, fcport->vha, 0x9100,
+	    "%s: Found sa_ctl %p, index %d, state 0x%lx, tx_cnt %d, rx_cnt %d, nport_handle: 0x%x\n",
+	    __func__, sa_ctl, sa_ctl->index, sa_ctl->state,
+	    fcport->edif.tx_rekey_cnt,
+	    fcport->edif.rx_rekey_cnt, fcport->loop_id);
+
+	return 0;
+}
+
+#define QLA_SA_UPDATE_FLAGS_RX_KEY      0x0
+#define QLA_SA_UPDATE_FLAGS_TX_KEY      0x2
+
+int
+qla24xx_sadb_update(struct bsg_job *bsg_job)
+{
+	struct	fc_bsg_reply	*bsg_reply = bsg_job->reply;
+	struct Scsi_Host *host = fc_bsg_to_shost(bsg_job);
+	scsi_qla_host_t *vha = shost_priv(host);
+	fc_port_t		*fcport = NULL;
+	srb_t			*sp = NULL;
+	struct edif_list_entry *edif_entry = NULL;
+	int			found = 0;
+	int			rval = 0;
+	int result = 0;
+	struct qla_sa_update_frame sa_frame;
+	struct srb_iocb *iocb_cmd;
+
+	ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x911d,
+	    "%s entered, vha: 0x%p\n", __func__, vha);
+
+	sg_copy_to_buffer(bsg_job->request_payload.sg_list,
+	    bsg_job->request_payload.sg_cnt, &sa_frame,
+	    sizeof(struct qla_sa_update_frame));
+
+	/* Check if host is online */
+	if (!vha->flags.online) {
+		ql_log(ql_log_warn, vha, 0x70a1, "Host is not online\n");
+		rval = -EIO;
+		SET_DID_STATUS(bsg_reply->result, DID_ERROR);
+		goto done;
+	}
+
+	if (vha->e_dbell.db_flags != EDB_ACTIVE) {
+		ql_log(ql_log_warn, vha, 0x70a1, "App not started\n");
+		rval = -EIO;
+		SET_DID_STATUS(bsg_reply->result, DID_ERROR);
+		goto done;
+	}
+
+	fcport = qla2x00_find_fcport_by_pid(vha, &sa_frame.port_id);
+	if (fcport) {
+		found = 1;
+		if (sa_frame.flags == QLA_SA_UPDATE_FLAGS_TX_KEY)
+			fcport->edif.tx_bytes = 0;
+		if (sa_frame.flags == QLA_SA_UPDATE_FLAGS_RX_KEY)
+			fcport->edif.rx_bytes = 0;
+	}
+
+	if (!found) {
+		ql_dbg(ql_dbg_edif, vha, 0x70a3, "Failed to find port= %06x\n",
+		    sa_frame.port_id.b24);
+		rval = -EINVAL;
+		SET_DID_STATUS(bsg_reply->result, DID_TARGET_FAILURE);
+		goto done;
+	}
+
+	/* make sure the nport_handle is valid */
+	if (fcport->loop_id == FC_NO_LOOP_ID) {
+		ql_dbg(ql_dbg_edif, vha, 0x70e1,
+		    "%s: %8phN lid=FC_NO_LOOP_ID, spi: 0x%x, DS %d, returning NO_CONNECT\n",
+		    __func__, fcport->port_name, sa_frame.spi,
+		    fcport->disc_state);
+		rval = -EINVAL;
+		SET_DID_STATUS(bsg_reply->result, DID_NO_CONNECT);
+		goto done;
+	}
+
+	/* allocate and queue an sa_ctl */
+	result = qla24xx_check_sadb_avail_slot(bsg_job, fcport, &sa_frame);
+
+	/* failure of bsg */
+	if (result == INVALID_EDIF_SA_INDEX) {
+		ql_dbg(ql_dbg_edif, vha, 0x70e1,
+		    "%s: %8phN, skipping update.\n",
+		    __func__, fcport->port_name);
+		rval = -EINVAL;
+		SET_DID_STATUS(bsg_reply->result, DID_ERROR);
+		goto done;
+
+	/* rx delete failure */
+	} else if (result == RX_DELETE_NO_EDIF_SA_INDEX) {
+		ql_dbg(ql_dbg_edif, vha, 0x70e1,
+		    "%s: %8phN, skipping rx delete.\n",
+		    __func__, fcport->port_name);
+		SET_DID_STATUS(bsg_reply->result, DID_OK);
+		goto done;
+	}
+
+	ql_dbg(ql_dbg_edif, vha, 0x70e1,
+	    "%s: %8phN, sa_index in sa_frame: %d flags %xh\n",
+	    __func__, fcport->port_name, sa_frame.fast_sa_index,
+	    sa_frame.flags);
+
+	/* looking for rx index and delete */
+	if (((sa_frame.flags & SAU_FLG_TX) == 0) &&
+	    (sa_frame.flags & SAU_FLG_INV)) {
+		uint16_t nport_handle = fcport->loop_id;
+		uint16_t sa_index = sa_frame.fast_sa_index;
+
+		/*
+		 * make sure we have an existing rx key, otherwise just process
+		 * this as a straight delete just like TX
+		 * This is NOT a normal case, it indicates an error recovery or key cleanup
+		 * by the ipsec code above us.
+		 */
+		edif_entry = qla_edif_list_find_sa_index(fcport, fcport->loop_id);
+		if (!edif_entry) {
+			ql_dbg(ql_dbg_edif, vha, 0x911d,
+			    "%s: WARNING: no active sa_index for nport_handle 0x%x, forcing delete for sa_index 0x%x\n",
+			    __func__, fcport->loop_id, sa_index);
+			goto force_rx_delete;
+		}
+
+		/*
+		 * if we have a forced delete for rx, remove the sa_index from the edif list
+		 * and proceed with normal delete.  The rx delay timer should not be running
+		 */
+		if ((sa_frame.flags & SAU_FLG_FORCE_DELETE) == SAU_FLG_FORCE_DELETE) {
+			qla_edif_list_delete_sa_index(fcport, edif_entry);
+			ql_dbg(ql_dbg_edif, vha, 0x911d,
+			    "%s: FORCE DELETE flag found for nport_handle 0x%x, sa_index 0x%x, forcing DELETE\n",
+			    __func__, fcport->loop_id, sa_index);
+			kfree(edif_entry);
+			goto force_rx_delete;
+		}
+
+		/*
+		 * delayed rx delete
+		 *
+		 * if delete_sa_index is not invalid then there is already
+		 * a delayed index in progress, return bsg bad status
+		 */
+		if (edif_entry->delete_sa_index != INVALID_EDIF_SA_INDEX) {
+			struct edif_sa_ctl *sa_ctl;
+
+			ql_dbg(ql_dbg_edif, vha, 0x911d,
+			    "%s: delete for lid 0x%x, delete_sa_index %d is pending\n",
+			    __func__, edif_entry->handle, edif_entry->delete_sa_index);
+
+			/* free up the sa_ctl that was allocated with the sa_index */
+			sa_ctl = qla_edif_find_sa_ctl_by_index(fcport, sa_index,
+			    (sa_frame.flags & SAU_FLG_TX));
+			if (sa_ctl) {
+				ql_dbg(ql_dbg_edif, vha, 0x3063,
+				    "%s: freeing sa_ctl for index %d\n",
+				    __func__, sa_ctl->index);
+				qla_edif_free_sa_ctl(fcport, sa_ctl, sa_ctl->index);
+			}
+
+			/* release the sa_index */
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: freeing sa_index %d, nph: 0x%x\n",
+			    __func__, sa_index, nport_handle);
+			qla_edif_sadb_delete_sa_index(fcport, nport_handle, sa_index);
+
+			rval = -EINVAL;
+			SET_DID_STATUS(bsg_reply->result, DID_ERROR);
+			goto done;
+		}
+
+		fcport->edif.rekey_cnt++;
+
+		/* configure and start the rx delay timer */
+		edif_entry->fcport = fcport;
+		edif_entry->timer.expires = jiffies + RX_DELAY_DELETE_TIMEOUT * HZ;
+
+		ql_dbg(ql_dbg_edif, vha, 0x911d,
+		    "%s: adding timer, entry: %p, delete sa_index %d, lid 0x%x to edif_list\n",
+		    __func__, edif_entry, sa_index, nport_handle);
+
+		/*
+		 * Start the timer when we queue the delayed rx delete.
+		 * This is an activity timer that goes off if we have not
+		 * received packets with the new sa_index
+		 */
+		add_timer(&edif_entry->timer);
+
+		/*
+		 * sa_delete for rx key with an active rx key including this one
+		 * add the delete rx sa index to the hash so we can look for it
+		 * in the rsp queue.  Do this after making any changes to the
+		 * edif_entry as part of the rx delete.
+		 */
+
+		ql_dbg(ql_dbg_edif, vha, 0x911d,
+		    "%s: delete sa_index %d, lid 0x%x to edif_list. bsg done ptr %p\n",
+		    __func__, sa_index, nport_handle, bsg_job);
+
+		edif_entry->delete_sa_index = sa_index;
+
+		bsg_job->reply_len = sizeof(struct fc_bsg_reply);
+		bsg_reply->result = DID_OK << 16;
+
+		goto done;
+
+	/*
+	 * rx index and update
+	 * add the index to the list and continue with normal update
+	 */
+	} else if (((sa_frame.flags & SAU_FLG_TX) == 0) &&
+	    ((sa_frame.flags & SAU_FLG_INV) == 0)) {
+		/* sa_update for rx key */
+		uint32_t nport_handle = fcport->loop_id;
+		uint16_t sa_index = sa_frame.fast_sa_index;
+		int result;
+
+		/*
+		 * add the update rx sa index to the hash so we can look for it
+		 * in the rsp queue and continue normally
+		 */
+
+		ql_dbg(ql_dbg_edif, vha, 0x911d,
+		    "%s:  adding update sa_index %d, lid 0x%x to edif_list\n",
+		    __func__, sa_index, nport_handle);
+
+		result = qla_edif_list_add_sa_update_index(fcport, sa_index,
+		    nport_handle);
+		if (result) {
+			ql_dbg(ql_dbg_edif, vha, 0x911d,
+			    "%s: SA_UPDATE failed to add new sa index %d to list for lid 0x%x\n",
+			    __func__, sa_index, nport_handle);
+		}
+	}
+	if (sa_frame.flags & SAU_FLG_GMAC_MODE)
+		fcport->edif.aes_gmac = 1;
+	else
+		fcport->edif.aes_gmac = 0;
+
+force_rx_delete:
+	/*
+	 * sa_update for both rx and tx keys, sa_delete for tx key
+	 * immediately process the request
+	 */
+	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
+	if (!sp) {
+		rval = -ENOMEM;
+		SET_DID_STATUS(bsg_reply->result, DID_IMM_RETRY);
+		goto done;
+	}
+
+	sp->type = SRB_SA_UPDATE;
+	sp->name = "bsg_sa_update";
+	sp->u.bsg_job = bsg_job;
+	/* sp->free = qla2x00_bsg_sp_free; */
+	sp->free = qla2x00_rel_sp;
+	sp->done = qla2x00_bsg_job_done;
+	iocb_cmd = &sp->u.iocb_cmd;
+	iocb_cmd->u.sa_update.sa_frame  = sa_frame;
+
+	rval = qla2x00_start_sp(sp);
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_dbg_edif, vha, 0x70e3,
+		    "qla2x00_start_sp failed=%d.\n", rval);
+
+		qla2x00_rel_sp(sp);
+		rval = -EIO;
+		SET_DID_STATUS(bsg_reply->result, DID_IMM_RETRY);
+		goto done;
+	}
+
+	ql_dbg(ql_dbg_edif, vha, 0x911d,
+	    "%s:  %s sent, hdl=%x, portid=%06x.\n",
+	    __func__, sp->name, sp->handle, fcport->d_id.b24);
+
+	fcport->edif.rekey_cnt++;
+	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
+	SET_DID_STATUS(bsg_reply->result, DID_OK);
+
+	return 0;
+
+/*
+ * send back error status
+ */
+done:
+	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
+	ql_dbg(ql_dbg_edif, vha, 0x911d,
+	    "%s:status: FAIL, result: 0x%x, bsg ptr done %p\n",
+	    __func__, bsg_reply->result, bsg_job);
+	bsg_job_done(bsg_job, bsg_reply->result,
+	    bsg_reply->reply_payload_rcv_len);
+
+	return 0;
+}
+
 static void
 qla_enode_free(scsi_qla_host_t *vha, struct enode *node)
 {
@@ -850,6 +1588,198 @@ qla_edb_stop(scsi_qla_host_t *vha)
 	}
 }
 
+static void qla_noop_sp_done(srb_t *sp, int res)
+{
+	sp->free(sp);
+}
+
+/*
+ * Called from work queue
+ * build and send the sa_update iocb to delete an rx sa_index
+ */
+int
+qla24xx_issue_sa_replace_iocb(scsi_qla_host_t *vha, struct qla_work_evt *e)
+{
+	srb_t *sp;
+	fc_port_t	*fcport = NULL;
+	struct srb_iocb *iocb_cmd = NULL;
+	int rval = QLA_SUCCESS;
+	struct	edif_sa_ctl *sa_ctl = e->u.sa_update.sa_ctl;
+	uint16_t nport_handle = e->u.sa_update.nport_handle;
+
+	ql_dbg(ql_dbg_edif, vha, 0x70e6,
+	    "%s: starting,  sa_ctl: %p\n", __func__, sa_ctl);
+
+	if (!sa_ctl) {
+		ql_dbg(ql_dbg_edif, vha, 0x70e6,
+		    "sa_ctl allocation failed\n");
+		return -ENOMEM;
+	}
+
+	fcport = sa_ctl->fcport;
+
+	/* Alloc SRB structure */
+	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
+	if (!sp) {
+		ql_dbg(ql_dbg_edif, vha, 0x70e6,
+		 "SRB allocation failed\n");
+		return -ENOMEM;
+	}
+
+	fcport->flags |= FCF_ASYNC_SENT;
+	iocb_cmd = &sp->u.iocb_cmd;
+	iocb_cmd->u.sa_update.sa_ctl = sa_ctl;
+
+	ql_dbg(ql_dbg_edif, vha, 0x3073,
+	    "Enter: SA REPL portid=%06x, sa_ctl %p, index %x, nport_handle: 0x%x\n",
+	    fcport->d_id.b24, sa_ctl, sa_ctl->index, nport_handle);
+	/*
+	 * if this is a sadb cleanup delete, mark it so the isr can
+	 * take the correct action
+	 */
+	if (sa_ctl->flags & EDIF_SA_CTL_FLG_CLEANUP_DEL) {
+		/* mark this srb as a cleanup delete */
+		sp->flags |= SRB_EDIF_CLEANUP_DELETE;
+		ql_dbg(ql_dbg_edif, vha, 0x70e6,
+		    "%s: sp 0x%p flagged as cleanup delete\n", __func__, sp);
+	}
+
+	sp->type = SRB_SA_REPLACE;
+	sp->name = "SA_REPLACE";
+	sp->fcport = fcport;
+	sp->free = qla2x00_rel_sp;
+	sp->done = qla_noop_sp_done;
+
+	rval = qla2x00_start_sp(sp);
+
+	if (rval != QLA_SUCCESS)
+		rval = QLA_FUNCTION_FAILED;
+
+	return rval;
+}
+
+void qla24xx_sa_update_iocb(srb_t *sp, struct sa_update_28xx *sa_update_iocb)
+{
+	int	itr = 0;
+	struct	scsi_qla_host		*vha = sp->vha;
+	struct	qla_sa_update_frame	*sa_frame =
+		&sp->u.iocb_cmd.u.sa_update.sa_frame;
+	u8 flags = 0;
+
+	switch (sa_frame->flags & (SAU_FLG_INV | SAU_FLG_TX)) {
+	case 0:
+		ql_dbg(ql_dbg_edif, vha, 0x911d,
+		    "%s: EDIF SA UPDATE RX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, sa_frame->fast_sa_index);
+		break;
+	case 1:
+		ql_dbg(ql_dbg_edif, vha, 0x911d,
+		    "%s: EDIF SA DELETE RX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, sa_frame->fast_sa_index);
+		flags |= SA_FLAG_INVALIDATE;
+		break;
+	case 2:
+		ql_dbg(ql_dbg_edif, vha, 0x911d,
+		    "%s: EDIF SA UPDATE TX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, sa_frame->fast_sa_index);
+		flags |= SA_FLAG_TX;
+		break;
+	case 3:
+		ql_dbg(ql_dbg_edif, vha, 0x911d,
+		    "%s: EDIF SA DELETE TX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, sa_frame->fast_sa_index);
+		flags |= SA_FLAG_TX | SA_FLAG_INVALIDATE;
+		break;
+	}
+
+	sa_update_iocb->entry_type = SA_UPDATE_IOCB_TYPE;
+	sa_update_iocb->entry_count = 1;
+	sa_update_iocb->sys_define = 0;
+	sa_update_iocb->entry_status = 0;
+	sa_update_iocb->handle = sp->handle;
+	sa_update_iocb->u.nport_handle = cpu_to_le16(sp->fcport->loop_id);
+	sa_update_iocb->vp_index = sp->fcport->vha->vp_idx;
+	sa_update_iocb->port_id[0] = sp->fcport->d_id.b.al_pa;
+	sa_update_iocb->port_id[1] = sp->fcport->d_id.b.area;
+	sa_update_iocb->port_id[2] = sp->fcport->d_id.b.domain;
+
+	sa_update_iocb->flags = flags;
+	sa_update_iocb->salt = cpu_to_le32(sa_frame->salt);
+	sa_update_iocb->spi = cpu_to_le32(sa_frame->spi);
+	sa_update_iocb->sa_index = cpu_to_le16(sa_frame->fast_sa_index);
+
+	sa_update_iocb->sa_control |= SA_CNTL_ENC_FCSP;
+	if (sp->fcport->edif.aes_gmac)
+		sa_update_iocb->sa_control |= SA_CNTL_AES_GMAC;
+
+	if (sa_frame->flags & SAU_FLG_KEY256) {
+		sa_update_iocb->sa_control |= SA_CNTL_KEY256;
+		for (itr = 0; itr < 32; itr++)
+			sa_update_iocb->sa_key[itr] = sa_frame->sa_key[itr];
+
+		ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x921f, "%s 256 sa key=%32phN\n",
+		    __func__, sa_update_iocb->sa_key);
+	} else {
+		sa_update_iocb->sa_control |= SA_CNTL_KEY128;
+		for (itr = 0; itr < 16; itr++)
+			sa_update_iocb->sa_key[itr] = sa_frame->sa_key[itr];
+
+		ql_dbg(ql_dbg_edif +  ql_dbg_verbose, vha, 0x921f, "%s 128 sa key=%16phN\n",
+		    __func__, sa_update_iocb->sa_key);
+	}
+
+	ql_dbg(ql_dbg_edif, vha, 0x921d,
+	    "%s SAU Port ID = %02x%02x%02x, flags=%xh, index=%u, ctl=%xh, SPI 0x%x flags 0x%x hdl=%x gmac %d\n",
+	    __func__, sa_update_iocb->port_id[2], sa_update_iocb->port_id[1],
+	    sa_update_iocb->port_id[0], sa_update_iocb->flags, sa_update_iocb->sa_index,
+	    sa_update_iocb->sa_control, sa_update_iocb->spi, sa_frame->flags, sp->handle,
+	    sp->fcport->edif.aes_gmac);
+
+	if (sa_frame->flags & SAU_FLG_TX)
+		sp->fcport->edif.tx_sa_pending = 1;
+	else
+		sp->fcport->edif.rx_sa_pending = 1;
+
+	sp->fcport->vha->qla_stats.control_requests++;
+}
+
+void
+qla24xx_sa_replace_iocb(srb_t *sp, struct sa_update_28xx *sa_update_iocb)
+{
+	struct	scsi_qla_host		*vha = sp->vha;
+	struct srb_iocb *srb_iocb = &sp->u.iocb_cmd;
+	struct	edif_sa_ctl		*sa_ctl = srb_iocb->u.sa_update.sa_ctl;
+	uint16_t nport_handle = sp->fcport->loop_id;
+
+	sa_update_iocb->entry_type = SA_UPDATE_IOCB_TYPE;
+	sa_update_iocb->entry_count = 1;
+	sa_update_iocb->sys_define = 0;
+	sa_update_iocb->entry_status = 0;
+	sa_update_iocb->handle = sp->handle;
+
+	sa_update_iocb->u.nport_handle = cpu_to_le16(nport_handle);
+
+	sa_update_iocb->vp_index = sp->fcport->vha->vp_idx;
+	sa_update_iocb->port_id[0] = sp->fcport->d_id.b.al_pa;
+	sa_update_iocb->port_id[1] = sp->fcport->d_id.b.area;
+	sa_update_iocb->port_id[2] = sp->fcport->d_id.b.domain;
+
+	/* Invalidate the index. salt, spi, control & key are ignore */
+	sa_update_iocb->flags = SA_FLAG_INVALIDATE;
+	sa_update_iocb->salt = 0;
+	sa_update_iocb->spi = 0;
+	sa_update_iocb->sa_index = cpu_to_le16(sa_ctl->index);
+	sa_update_iocb->sa_control = 0;
+
+	ql_dbg(ql_dbg_edif, vha, 0x921d,
+	    "%s SAU DELETE RX Port ID = %02x:%02x:%02x, lid %d flags=%xh, index=%u, hdl=%x\n",
+	    __func__, sa_update_iocb->port_id[2], sa_update_iocb->port_id[1],
+	    sa_update_iocb->port_id[0], nport_handle, sa_update_iocb->flags,
+	    sa_update_iocb->sa_index, sp->handle);
+
+	sp->fcport->vha->qla_stats.control_requests++;
+}
+
 void qla24xx_auth_els(scsi_qla_host_t *vha, void **pkt, struct rsp_que **rsp)
 {
 	struct purex_entry_24xx *p = *pkt;
@@ -968,6 +1898,544 @@ void qla24xx_auth_els(scsi_qla_host_t *vha, void **pkt, struct rsp_que **rsp)
 	    purex->pur_info.pur_did.b24, p->rx_xchg_addr);
 }
 
+static uint16_t  qla_edif_get_sa_index_from_freepool(fc_port_t *fcport, int dir)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	void *sa_id_map;
+	unsigned long flags = 0;
+	u16 sa_index;
+
+	ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x3063,
+	    "%s: entry\n", __func__);
+
+	if (dir)
+		sa_id_map = ha->edif_tx_sa_id_map;
+	else
+		sa_id_map = ha->edif_rx_sa_id_map;
+
+	spin_lock_irqsave(&ha->sadb_fp_lock, flags);
+	sa_index = find_first_zero_bit(sa_id_map, EDIF_NUM_SA_INDEX);
+	if (sa_index >=  EDIF_NUM_SA_INDEX) {
+		spin_unlock_irqrestore(&ha->sadb_fp_lock, flags);
+		return INVALID_EDIF_SA_INDEX;
+	}
+	set_bit(sa_index, sa_id_map);
+	spin_unlock_irqrestore(&ha->sadb_fp_lock, flags);
+
+	if (dir)
+		sa_index += EDIF_TX_SA_INDEX_BASE;
+
+	ql_dbg(ql_dbg_edif, vha, 0x3063,
+	    "%s: index retrieved from free pool %d\n", __func__, sa_index);
+
+	return sa_index;
+}
+
+/* find an sadb entry for an nport_handle */
+static struct edif_sa_index_entry *
+qla_edif_sadb_find_sa_index_entry(uint16_t nport_handle,
+		struct list_head *sa_list)
+{
+	struct edif_sa_index_entry *entry;
+	struct edif_sa_index_entry *tentry;
+	struct list_head *indx_list = sa_list;
+
+	list_for_each_entry_safe(entry, tentry, indx_list, next) {
+		if (entry->handle == nport_handle)
+			return entry;
+	}
+	return NULL;
+}
+
+/* remove an sa_index from the nport_handle and return it to the free pool */
+static int qla_edif_sadb_delete_sa_index(fc_port_t *fcport, uint16_t nport_handle,
+		uint16_t sa_index)
+{
+	struct edif_sa_index_entry *entry;
+	struct list_head *sa_list;
+	int dir = (sa_index < EDIF_TX_SA_INDEX_BASE) ? 0 : 1;
+	int slot = 0;
+	int free_slot_count = 0;
+	scsi_qla_host_t *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags = 0;
+
+	ql_dbg(ql_dbg_edif, vha, 0x3063,
+	    "%s: entry\n", __func__);
+
+	if (dir)
+		sa_list = &ha->sadb_tx_index_list;
+	else
+		sa_list = &ha->sadb_rx_index_list;
+
+	entry = qla_edif_sadb_find_sa_index_entry(nport_handle, sa_list);
+	if (!entry) {
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: no entry found for nport_handle 0x%x\n",
+		    __func__, nport_handle);
+		return -1;
+	}
+
+	spin_lock_irqsave(&ha->sadb_lock, flags);
+	/*
+	 * each tx/rx direction has up to 2 sa indexes/slots. 1 slot for in flight traffic
+	 * the other is use at re-key time.
+	 */
+	for (slot = 0; slot < 2; slot++) {
+		if (entry->sa_pair[slot].sa_index == sa_index) {
+			entry->sa_pair[slot].sa_index = INVALID_EDIF_SA_INDEX;
+			entry->sa_pair[slot].spi = 0;
+			free_slot_count++;
+			qla_edif_add_sa_index_to_freepool(fcport, dir, sa_index);
+		} else if (entry->sa_pair[slot].sa_index == INVALID_EDIF_SA_INDEX) {
+			free_slot_count++;
+		}
+	}
+
+	if (free_slot_count == 2) {
+		list_del(&entry->next);
+		kfree(entry);
+	}
+	spin_unlock_irqrestore(&ha->sadb_lock, flags);
+
+	ql_dbg(ql_dbg_edif, vha, 0x3063,
+	    "%s: sa_index %d removed, free_slot_count: %d\n",
+	    __func__, sa_index, free_slot_count);
+
+	return 0;
+}
+
+void
+qla28xx_sa_update_iocb_entry(scsi_qla_host_t *v, struct req_que *req,
+	struct sa_update_28xx *pkt)
+{
+	const char *func = "SA_UPDATE_RESPONSE_IOCB";
+	srb_t *sp;
+	struct edif_sa_ctl *sa_ctl;
+	int old_sa_deleted = 1;
+	uint16_t nport_handle;
+	struct scsi_qla_host *vha;
+
+	sp = qla2x00_get_sp_from_handle(v, func, req, pkt);
+
+	if (!sp) {
+		ql_dbg(ql_dbg_edif, v, 0x3063,
+			"%s: no sp found for pkt\n", __func__);
+		return;
+	}
+	/* use sp->vha due to npiv */
+	vha = sp->vha;
+
+	switch (pkt->flags & (SA_FLAG_INVALIDATE | SA_FLAG_TX)) {
+	case 0:
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: EDIF SA UPDATE RX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, pkt->sa_index);
+		break;
+	case 1:
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: EDIF SA DELETE RX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, pkt->sa_index);
+		break;
+	case 2:
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: EDIF SA UPDATE TX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, pkt->sa_index);
+		break;
+	case 3:
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: EDIF SA DELETE TX IOCB  vha: 0x%p  index: %d\n",
+		    __func__, vha, pkt->sa_index);
+		break;
+	}
+
+	/*
+	 * dig the nport handle out of the iocb, fcport->loop_id can not be trusted
+	 * to be correct during cleanup sa_update iocbs.
+	 */
+	nport_handle = sp->fcport->loop_id;
+
+	ql_dbg(ql_dbg_edif, vha, 0x3063,
+	    "%s: %8phN comp status=%x old_sa_info=%x new_sa_info=%x lid %d, index=0x%x pkt_flags %xh hdl=%x\n",
+	    __func__, sp->fcport->port_name, pkt->u.comp_sts, pkt->old_sa_info, pkt->new_sa_info,
+	    nport_handle, pkt->sa_index, pkt->flags, sp->handle);
+
+	/* if rx delete, remove the timer */
+	if ((pkt->flags & (SA_FLAG_INVALIDATE | SA_FLAG_TX)) ==  SA_FLAG_INVALIDATE) {
+		struct edif_list_entry *edif_entry;
+
+		sp->fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+
+		edif_entry = qla_edif_list_find_sa_index(sp->fcport, nport_handle);
+		if (edif_entry) {
+			ql_dbg(ql_dbg_edif, vha, 0x5033,
+			    "%s: removing edif_entry %p, new sa_index: 0x%x\n",
+			    __func__, edif_entry, pkt->sa_index);
+			qla_edif_list_delete_sa_index(sp->fcport, edif_entry);
+			del_timer(&edif_entry->timer);
+
+			ql_dbg(ql_dbg_edif, vha, 0x5033,
+			    "%s: releasing edif_entry %p, new sa_index: 0x%x\n",
+			    __func__, edif_entry, pkt->sa_index);
+
+			kfree(edif_entry);
+		}
+	}
+
+	/*
+	 * if this is a delete for either tx or rx, make sure it succeeded.
+	 * The new_sa_info field should be 0xffff on success
+	 */
+	if (pkt->flags & SA_FLAG_INVALIDATE)
+		old_sa_deleted = (le16_to_cpu(pkt->new_sa_info) == 0xffff) ? 1 : 0;
+
+	/* Process update and delete the same way */
+
+	/* If this is an sadb cleanup delete, bypass sending events to IPSEC */
+	if (sp->flags & SRB_EDIF_CLEANUP_DELETE) {
+		sp->fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: nph 0x%x, sa_index %d removed from fw\n",
+		    __func__, sp->fcport->loop_id, pkt->sa_index);
+
+	} else if ((pkt->entry_status == 0) && (pkt->u.comp_sts == 0) &&
+	    old_sa_deleted) {
+		/*
+		 * Note: Wa are only keeping track of latest SA,
+		 * so we know when we can start enableing encryption per I/O.
+		 * If all SA's get deleted, let FW reject the IOCB.
+
+		 * TODO: edif: don't set enabled here I think
+		 * TODO: edif: prli complete is where it should be set
+		 */
+		ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x3063,
+			"SA(%x)updated for s_id %02x%02x%02x\n",
+			pkt->new_sa_info,
+			pkt->port_id[2], pkt->port_id[1], pkt->port_id[0]);
+		sp->fcport->edif.enable = 1;
+		if (pkt->flags & SA_FLAG_TX) {
+			sp->fcport->edif.tx_sa_set = 1;
+			sp->fcport->edif.tx_sa_pending = 0;
+		} else {
+			sp->fcport->edif.rx_sa_set = 1;
+			sp->fcport->edif.rx_sa_pending = 0;
+		}
+	} else {
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: %8phN SA update FAILED: sa_index: %d, new_sa_info %d, %02x%02x%02x\n",
+		    __func__, sp->fcport->port_name, pkt->sa_index, pkt->new_sa_info,
+		    pkt->port_id[2], pkt->port_id[1], pkt->port_id[0]);
+	}
+
+	/* for delete, release sa_ctl, sa_index */
+	if (pkt->flags & SA_FLAG_INVALIDATE) {
+		/* release the sa_ctl */
+		sa_ctl = qla_edif_find_sa_ctl_by_index(sp->fcport,
+		    le16_to_cpu(pkt->sa_index), (pkt->flags & SA_FLAG_TX));
+		if (sa_ctl &&
+		    qla_edif_find_sa_ctl_by_index(sp->fcport, sa_ctl->index,
+			(pkt->flags & SA_FLAG_TX)) != NULL) {
+			ql_dbg(ql_dbg_edif + ql_dbg_verbose, vha, 0x3063,
+			    "%s: freeing sa_ctl for index %d\n",
+			    __func__, sa_ctl->index);
+			qla_edif_free_sa_ctl(sp->fcport, sa_ctl, sa_ctl->index);
+		} else {
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: sa_ctl NOT freed, sa_ctl: %p\n",
+			    __func__, sa_ctl);
+		}
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: freeing sa_index %d, nph: 0x%x\n",
+		    __func__, le16_to_cpu(pkt->sa_index), nport_handle);
+		qla_edif_sadb_delete_sa_index(sp->fcport, nport_handle,
+		    le16_to_cpu(pkt->sa_index));
+	/*
+	 * check for a failed sa_update and remove
+	 * the sadb entry.
+	 */
+	} else if (pkt->u.comp_sts) {
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: freeing sa_index %d, nph: 0x%x\n",
+		    __func__, pkt->sa_index, nport_handle);
+		qla_edif_sadb_delete_sa_index(sp->fcport, nport_handle,
+		    le16_to_cpu(pkt->sa_index));
+	}
+
+	sp->done(sp, 0);
+}
+
+/******************
+ * SADB functions *
+ ******************/
+
+/* allocate/retrieve an sa_index for a given spi */
+static uint16_t qla_edif_sadb_get_sa_index(fc_port_t *fcport,
+		struct qla_sa_update_frame *sa_frame)
+{
+	struct edif_sa_index_entry *entry;
+	struct list_head *sa_list;
+	uint16_t sa_index;
+	int dir = sa_frame->flags & SAU_FLG_TX;
+	int slot = 0;
+	int free_slot = -1;
+	scsi_qla_host_t *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags = 0;
+	uint16_t nport_handle = fcport->loop_id;
+
+	ql_dbg(ql_dbg_edif, vha, 0x3063,
+	    "%s: entry  fc_port: %p, nport_handle: 0x%x\n",
+	    __func__, fcport, nport_handle);
+
+	if (dir)
+		sa_list = &ha->sadb_tx_index_list;
+	else
+		sa_list = &ha->sadb_rx_index_list;
+
+	entry = qla_edif_sadb_find_sa_index_entry(nport_handle, sa_list);
+	if (!entry) {
+		if ((sa_frame->flags & (SAU_FLG_TX | SAU_FLG_INV)) == SAU_FLG_INV) {
+			ql_dbg(ql_dbg_edif, vha, 0x3063,
+			    "%s: rx delete request with no entry\n", __func__);
+			return RX_DELETE_NO_EDIF_SA_INDEX;
+		}
+
+		/* if there is no entry for this nport, add one */
+		entry = kzalloc((sizeof(struct edif_sa_index_entry)), GFP_ATOMIC);
+		if (!entry)
+			return INVALID_EDIF_SA_INDEX;
+
+		sa_index = qla_edif_get_sa_index_from_freepool(fcport, dir);
+		if (sa_index == INVALID_EDIF_SA_INDEX) {
+			kfree(entry);
+			return INVALID_EDIF_SA_INDEX;
+		}
+
+		INIT_LIST_HEAD(&entry->next);
+		entry->handle = nport_handle;
+		entry->fcport = fcport;
+		entry->sa_pair[0].spi = sa_frame->spi;
+		entry->sa_pair[0].sa_index = sa_index;
+		entry->sa_pair[1].spi = 0;
+		entry->sa_pair[1].sa_index = INVALID_EDIF_SA_INDEX;
+		spin_lock_irqsave(&ha->sadb_lock, flags);
+		list_add_tail(&entry->next, sa_list);
+		spin_unlock_irqrestore(&ha->sadb_lock, flags);
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: Created new sadb entry for nport_handle 0x%x, spi 0x%x, returning sa_index %d\n",
+		    __func__, nport_handle, sa_frame->spi, sa_index);
+
+		return sa_index;
+	}
+
+	spin_lock_irqsave(&ha->sadb_lock, flags);
+
+	/* see if we already have an entry for this spi */
+	for (slot = 0; slot < 2; slot++) {
+		if (entry->sa_pair[slot].sa_index == INVALID_EDIF_SA_INDEX) {
+			free_slot = slot;
+		} else {
+			if (entry->sa_pair[slot].spi == sa_frame->spi) {
+				spin_unlock_irqrestore(&ha->sadb_lock, flags);
+				ql_dbg(ql_dbg_edif, vha, 0x3063,
+				    "%s: sadb slot %d entry for lid 0x%x, spi 0x%x found, sa_index %d\n",
+				    __func__, slot, entry->handle, sa_frame->spi,
+				    entry->sa_pair[slot].sa_index);
+				return entry->sa_pair[slot].sa_index;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&ha->sadb_lock, flags);
+
+	/* both slots are used */
+	if (free_slot == -1) {
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: WARNING: No free slots in sadb for nport_handle 0x%x, spi: 0x%x\n",
+		    __func__, entry->handle, sa_frame->spi);
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: Slot 0  spi: 0x%x  sa_index: %d,  Slot 1  spi: 0x%x  sa_index: %d\n",
+		    __func__, entry->sa_pair[0].spi, entry->sa_pair[0].sa_index,
+		    entry->sa_pair[1].spi, entry->sa_pair[1].sa_index);
+
+		return INVALID_EDIF_SA_INDEX;
+	}
+
+	/* there is at least one free slot, use it */
+	sa_index = qla_edif_get_sa_index_from_freepool(fcport, dir);
+	if (sa_index == INVALID_EDIF_SA_INDEX) {
+		ql_dbg(ql_dbg_edif, fcport->vha, 0x3063,
+		    "%s: empty freepool!!\n", __func__);
+		return INVALID_EDIF_SA_INDEX;
+	}
+
+	spin_lock_irqsave(&ha->sadb_lock, flags);
+	entry->sa_pair[free_slot].spi = sa_frame->spi;
+	entry->sa_pair[free_slot].sa_index = sa_index;
+	spin_unlock_irqrestore(&ha->sadb_lock, flags);
+	ql_dbg(ql_dbg_edif, fcport->vha, 0x3063,
+	    "%s: sadb slot %d entry for nport_handle 0x%x, spi 0x%x added, returning sa_index %d\n",
+	    __func__, free_slot, entry->handle, sa_frame->spi, sa_index);
+
+	return sa_index;
+}
+
+/* release any sadb entries -- only done at teardown */
+void qla_edif_sadb_release(struct qla_hw_data *ha)
+{
+	struct list_head *pos;
+	struct list_head *tmp;
+	struct edif_sa_index_entry *entry;
+
+	list_for_each_safe(pos, tmp, &ha->sadb_rx_index_list) {
+		entry = list_entry(pos, struct edif_sa_index_entry, next);
+		list_del(&entry->next);
+		kfree(entry);
+	}
+
+	list_for_each_safe(pos, tmp, &ha->sadb_tx_index_list) {
+		entry = list_entry(pos, struct edif_sa_index_entry, next);
+		list_del(&entry->next);
+		kfree(entry);
+	}
+}
+
+/**************************
+ * sadb freepool functions
+ **************************/
+
+/* build the rx and tx sa_index free pools -- only done at fcport init */
+int qla_edif_sadb_build_free_pool(struct qla_hw_data *ha)
+{
+	ha->edif_tx_sa_id_map =
+	    kcalloc(BITS_TO_LONGS(EDIF_NUM_SA_INDEX), sizeof(long), GFP_KERNEL);
+
+	if (!ha->edif_tx_sa_id_map) {
+		ql_log_pci(ql_log_fatal, ha->pdev, 0x0009,
+		    "Unable to allocate memory for sadb tx.\n");
+		return -ENOMEM;
+	}
+
+	ha->edif_rx_sa_id_map =
+	    kcalloc(BITS_TO_LONGS(EDIF_NUM_SA_INDEX), sizeof(long), GFP_KERNEL);
+	if (!ha->edif_rx_sa_id_map) {
+		kfree(ha->edif_tx_sa_id_map);
+		ha->edif_tx_sa_id_map = NULL;
+		ql_log_pci(ql_log_fatal, ha->pdev, 0x0009,
+		    "Unable to allocate memory for sadb rx.\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* release the free pool - only done during fcport teardown */
+void qla_edif_sadb_release_free_pool(struct qla_hw_data *ha)
+{
+	kfree(ha->edif_tx_sa_id_map);
+	ha->edif_tx_sa_id_map = NULL;
+	kfree(ha->edif_rx_sa_id_map);
+	ha->edif_rx_sa_id_map = NULL;
+}
+
+static void __chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha,
+		fc_port_t *fcport, uint32_t handle, uint16_t sa_index)
+{
+	struct edif_list_entry *edif_entry;
+	struct edif_sa_ctl *sa_ctl;
+	uint16_t delete_sa_index = INVALID_EDIF_SA_INDEX;
+	unsigned long flags = 0;
+	uint16_t nport_handle = fcport->loop_id;
+	uint16_t cached_nport_handle;
+
+	spin_lock_irqsave(&fcport->edif.indx_list_lock, flags);
+	edif_entry = qla_edif_list_find_sa_index(fcport, nport_handle);
+	if (!edif_entry) {
+		spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+		return;		/* no pending delete for this handle */
+	}
+
+	/*
+	 * check for no pending delete for this index or iocb does not
+	 * match rx sa_index
+	 */
+	if (edif_entry->delete_sa_index == INVALID_EDIF_SA_INDEX ||
+	    edif_entry->update_sa_index != sa_index) {
+		spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+		return;
+	}
+
+	/*
+	 * wait until we have seen at least EDIF_DELAY_COUNT transfers before
+	 * queueing RX delete
+	 */
+	if (edif_entry->count++ < EDIF_RX_DELETE_FILTER_COUNT) {
+		spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+		return;
+	}
+
+	ql_dbg(ql_dbg_edif, vha, 0x5033,
+	    "%s: invalidating delete_sa_index,  update_sa_index: 0x%x sa_index: 0x%x, delete_sa_index: 0x%x\n",
+	    __func__, edif_entry->update_sa_index, sa_index, edif_entry->delete_sa_index);
+
+	delete_sa_index = edif_entry->delete_sa_index;
+	edif_entry->delete_sa_index = INVALID_EDIF_SA_INDEX;
+	cached_nport_handle = edif_entry->handle;
+	spin_unlock_irqrestore(&fcport->edif.indx_list_lock, flags);
+
+	/* sanity check on the nport handle */
+	if (nport_handle != cached_nport_handle) {
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: POST SA DELETE nport_handle mismatch: lid: 0x%x, edif_entry nph: 0x%x\n",
+		    __func__, nport_handle, cached_nport_handle);
+	}
+
+	/* find the sa_ctl for the delete and schedule the delete */
+	sa_ctl = qla_edif_find_sa_ctl_by_index(fcport, delete_sa_index, 0);
+	if (sa_ctl) {
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: POST SA DELETE sa_ctl: %p, index recvd %d\n",
+		    __func__, sa_ctl, sa_index);
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "delete index %d, update index: %d, nport handle: 0x%x, handle: 0x%x\n",
+		    delete_sa_index,
+		    edif_entry->update_sa_index, nport_handle, handle);
+
+		sa_ctl->flags = EDIF_SA_CTL_FLG_DEL;
+		set_bit(EDIF_SA_CTL_REPL, &sa_ctl->state);
+		qla_post_sa_replace_work(fcport->vha, fcport,
+		    nport_handle, sa_ctl);
+	} else {
+		ql_dbg(ql_dbg_edif, vha, 0x3063,
+		    "%s: POST SA DELETE sa_ctl not found for delete_sa_index: %d\n",
+		    __func__, delete_sa_index);
+	}
+}
+
+void qla_chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha,
+		srb_t *sp, struct sts_entry_24xx *sts24)
+{
+	fc_port_t *fcport = sp->fcport;
+	/* sa_index used by this iocb */
+	struct scsi_cmnd *cmd = GET_CMD_SP(sp);
+	uint32_t handle;
+
+	handle = (uint32_t)LSW(sts24->handle);
+
+	/* find out if this status iosb is for a scsi read */
+	if (cmd->sc_data_direction != DMA_FROM_DEVICE)
+		return;
+
+	return __chk_edif_rx_sa_delete_pending(vha, fcport, handle,
+	   le16_to_cpu(sts24->edif_sa_index));
+}
+
+void qlt_chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha, fc_port_t *fcport,
+		struct ctio7_from_24xx *pkt)
+{
+	__chk_edif_rx_sa_delete_pending(vha, fcport,
+	    pkt->handle, le16_to_cpu(pkt->edif_sa_index));
+}
+
 static void qla_parse_auth_els_ctl(struct srb *sp)
 {
 	struct qla_els_pt_arg *a = &sp->u.bsg_cmd.u.els_arg;
diff --git a/drivers/scsi/qla2xxx/qla_edif.h b/drivers/scsi/qla2xxx/qla_edif.h
index 93c423227d82..1cff02e5bd43 100644
--- a/drivers/scsi/qla2xxx/qla_edif.h
+++ b/drivers/scsi/qla2xxx/qla_edif.h
@@ -9,6 +9,27 @@
 struct qla_scsi_host;
 #define EDIF_APP_ID 0x73730001
 
+#define EDIF_MAX_INDEX	2048
+struct edif_sa_ctl {
+	struct list_head next;
+	uint16_t	del_index;
+	uint16_t	index;
+	uint16_t	slot;
+	uint16_t	flags;
+#define	EDIF_SA_CTL_FLG_REPL		BIT_0
+#define	EDIF_SA_CTL_FLG_DEL		BIT_1
+#define EDIF_SA_CTL_FLG_CLEANUP_DEL BIT_4
+	// Invalidate Index bit and mirrors QLA_SA_UPDATE_FLAGS_DELETE
+	unsigned long   state;
+#define EDIF_SA_CTL_USED	1	/* Active Sa update  */
+#define EDIF_SA_CTL_PEND	2	/* Waiting for slot */
+#define EDIF_SA_CTL_REPL	3	/* Active Replace and Delete */
+#define EDIF_SA_CTL_DEL		4	/* Delete Pending */
+	struct fc_port	*fcport;
+	struct bsg_job *bsg_job;
+	struct qla_sa_update_frame sa_frame;
+};
+
 enum enode_flags_t {
 	ENODE_ACTIVE = 0x1,
 };
@@ -30,6 +51,46 @@ struct edif_dbell {
 	struct	completion	dbell;
 };
 
+#define SA_UPDATE_IOCB_TYPE            0x71    /* Security Association Update IOCB entry */
+struct sa_update_28xx {
+	uint8_t entry_type;             /* Entry type. */
+	uint8_t entry_count;            /* Entry count. */
+	uint8_t sys_define;             /* System Defined. */
+	uint8_t entry_status;           /* Entry Status. */
+
+	uint32_t handle;                /* IOCB System handle. */
+
+	union {
+		__le16 nport_handle;  /* in: N_PORT handle. */
+		__le16 comp_sts;              /* out: completion status */
+#define CS_PORT_EDIF_SUPP_NOT_RDY 0x64
+#define CS_PORT_EDIF_INV_REQ      0x66
+	} u;
+	uint8_t vp_index;
+	uint8_t reserved_1;
+	uint8_t port_id[3];
+	uint8_t flags;
+#define SA_FLAG_INVALIDATE BIT_0
+#define SA_FLAG_TX	   BIT_1 // 1=tx, 0=rx
+
+	uint8_t sa_key[32];     /* 256 bit key */
+	__le32 salt;
+	__le32 spi;
+	uint8_t sa_control;
+#define SA_CNTL_ENC_FCSP        (1 << 3)
+#define SA_CNTL_ENC_OPD         (2 << 3)
+#define SA_CNTL_ENC_MSK         (3 << 3)  // mask bits 4,3
+#define SA_CNTL_AES_GMAC	(1 << 2)
+#define SA_CNTL_KEY256          (2 << 0)
+#define SA_CNTL_KEY128          0
+
+	uint8_t reserved_2;
+	__le16 sa_index;   // reserve: bit 11-15
+	__le16 old_sa_info;
+	__le16 new_sa_info;
+};
+
+#define        NUM_ENTRIES     256
 #define        MAX_PAYLOAD     1024
 #define        PUR_GET         1
 
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index 49df418030e4..c067cd202dc4 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -611,6 +611,7 @@ struct sts_entry_24xx {
 	union {
 		__le16 reserved_1;
 		__le16	nvme_rsp_pyld_len;
+		__le16 edif_sa_index;	 /* edif sa_index used for initiator read data */
 	};
 
 	__le16	state_flags;		/* State flags. */
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index d19f5ec24d8c..e7c5143c66ef 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -130,6 +130,13 @@ void qla24xx_free_purex_item(struct purex_item *item);
 extern bool qla24xx_risc_firmware_invalid(uint32_t *);
 void qla_init_iocb_limit(scsi_qla_host_t *);
 
+void qla_edif_sadb_release(struct qla_hw_data *ha);
+int qla_edif_sadb_build_free_pool(struct qla_hw_data *ha);
+void qla_edif_sadb_release_free_pool(struct qla_hw_data *ha);
+void qla_chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha,
+		srb_t *sp, struct sts_entry_24xx *sts24);
+void qlt_chk_edif_rx_sa_delete_pending(scsi_qla_host_t *vha, fc_port_t *fcport,
+		struct ctio7_from_24xx *ctio);
 int qla_edif_process_els(scsi_qla_host_t *vha, struct bsg_job *bsgjob);
 const char *sc_to_str(uint16_t cmd);
 
@@ -238,6 +245,8 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 			       struct purex_item *pkt);
 void qla_pci_set_eeh_busy(struct scsi_qla_host *);
 void qla_schedule_eeh_work(struct scsi_qla_host *);
+struct edif_sa_ctl *qla_edif_find_sa_ctl_by_index(fc_port_t *fcport,
+						  int index, int dir);
 
 /*
  * Global Functions in qla_mid.c source file.
@@ -313,6 +322,8 @@ extern int qla24xx_walk_and_build_prot_sglist(struct qla_hw_data *, srb_t *,
 	struct dsd64 *, uint16_t, struct qla_tgt_cmd *);
 extern int qla24xx_get_one_block_sg(uint32_t, struct qla2_sgx *, uint32_t *);
 extern int qla24xx_configure_prot_mode(srb_t *, uint16_t *);
+extern int qla24xx_issue_sa_replace_iocb(scsi_qla_host_t *vha,
+	struct qla_work_evt *e);
 
 /*
  * Global Function Prototypes in qla_mbx.c source file.
@@ -885,6 +896,9 @@ extern int qla2x00_issue_iocb_timeout(scsi_qla_host_t *, void *,
 	dma_addr_t, size_t, uint32_t);
 extern int qla2x00_get_idma_speed(scsi_qla_host_t *, uint16_t,
 	uint16_t *, uint16_t *);
+extern int qla24xx_sadb_update(struct bsg_job *bsg_job);
+extern int qla_post_sa_replace_work(struct scsi_qla_host *vha,
+	 fc_port_t *fcport, uint16_t nport_handle, struct edif_sa_ctl *sa_ctl);
 
 /* 83xx related functions */
 void qla83xx_fw_dump(scsi_qla_host_t *vha);
@@ -957,12 +971,19 @@ extern void qla_nvme_abort_process_comp_status
 
 /* nvme.c */
 void qla_nvme_unregister_remote_port(struct fc_port *fcport);
+
+/* qla_edif.c */
 fc_port_t *qla2x00_find_fcport_by_pid(scsi_qla_host_t *vha, port_id_t *id);
 void qla_edb_stop(scsi_qla_host_t *vha);
 int32_t qla_edif_app_mgmt(struct bsg_job *bsg_job);
 void qla_enode_init(scsi_qla_host_t *vha);
 void qla_enode_stop(scsi_qla_host_t *vha);
+void qla_edif_flush_sa_ctl_lists(fc_port_t *fcport);
+void qla24xx_sa_update_iocb(srb_t *sp, struct sa_update_28xx *sa_update_iocb);
+void qla24xx_sa_replace_iocb(srb_t *sp, struct sa_update_28xx *sa_update_iocb);
 void qla24xx_auth_els(scsi_qla_host_t *vha, void **pkt, struct rsp_que **rsp);
+void qla28xx_sa_update_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
+		struct sa_update_28xx *pkt);
 void qla_handle_els_plogi_done(scsi_qla_host_t *vha, struct event_arg *ea);
 
 #define QLA2XX_HW_ERROR			BIT_0
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index f8f471157109..663182f16471 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5071,6 +5071,16 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
 
+	spin_lock_init(&fcport->edif.sa_list_lock);
+	INIT_LIST_HEAD(&fcport->edif.tx_sa_list);
+	INIT_LIST_HEAD(&fcport->edif.rx_sa_list);
+
+	if (vha->e_dbell.db_flags == EDB_ACTIVE)
+		fcport->edif.app_started = 1;
+
+	spin_lock_init(&fcport->edif.indx_list_lock);
+	INIT_LIST_HEAD(&fcport->edif.edif_indx_list);
+
 	return fcport;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index e5aaf9dd7181..64ec66307bda 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3892,6 +3892,12 @@ qla2x00_start_sp(srb_t *sp)
 	case SRB_PRLO_CMD:
 		qla24xx_prlo_iocb(sp, pkt);
 		break;
+	case SRB_SA_UPDATE:
+		qla24xx_sa_update_iocb(sp, pkt);
+		break;
+	case SRB_SA_REPLACE:
+		qla24xx_sa_replace_iocb(sp, pkt);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index a64b990fd947..657fe0d9ee21 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3191,6 +3191,8 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 	sp->qpair->cmd_completion_cnt++;
 
 	/* Fast path completion. */
+	qla_chk_edif_rx_sa_delete_pending(vha, sp, sts24);
+
 	if (comp_status == CS_COMPLETE && scsi_status == 0) {
 		qla2x00_process_completed_request(vha, req, handle);
 
@@ -3585,6 +3587,7 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, sts_entry_t *pkt)
 		}
 		break;
 
+	case SA_UPDATE_IOCB_TYPE:
 	case ABTS_RESP_24XX:
 	case CTIO_TYPE7:
 	case CTIO_CRC2:
@@ -3883,6 +3886,11 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 				       purex_entry->els_frame_payload[3]);
 			}
 			break;
+		case SA_UPDATE_IOCB_TYPE:
+			qla28xx_sa_update_iocb_entry(vha, rsp->req,
+				(struct sa_update_28xx *)pkt);
+			break;
+
 		default:
 			/* Type Not Supported. */
 			ql_dbg(ql_dbg_async, vha, 0x5042,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b7e1d7437d81..0ae4d0fd622f 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2835,6 +2835,17 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&ha->tgt.sess_lock);
 	spin_lock_init(&ha->tgt.atio_lock);
 
+	spin_lock_init(&ha->sadb_lock);
+	INIT_LIST_HEAD(&ha->sadb_tx_index_list);
+	INIT_LIST_HEAD(&ha->sadb_rx_index_list);
+
+	spin_lock_init(&ha->sadb_fp_lock);
+
+	if (qla_edif_sadb_build_free_pool(ha)) {
+		kfree(ha);
+		goto  disable_device;
+	}
+
 	atomic_set(&ha->nvme_active_aen_cnt, 0);
 
 	/* Clear our data area */
@@ -3868,6 +3879,9 @@ qla2x00_free_device(scsi_qla_host_t *vha)
 
 	qla82xx_md_free(vha);
 
+	qla_edif_sadb_release_free_pool(ha);
+	qla_edif_sadb_release(ha);
+
 	qla2x00_free_queues(ha);
 }
 
@@ -5375,6 +5389,9 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 			qla24xx_els_dcmd2_iocb(vha, ELS_DCMD_PLOGI,
 			    e->u.fcport.fcport, false);
 			break;
+		case QLA_EVT_SA_REPLACE:
+			qla24xx_issue_sa_replace_iocb(vha, e);
+			break;
 		}
 
 		if (rc == EAGAIN) {
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 01620f3eab39..8a319b78cdf6 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -446,7 +446,7 @@ struct ctio7_from_24xx {
 	uint8_t  vp_index;
 	uint8_t  reserved1[5];
 	__le32	exchange_address;
-	__le16	reserved2;
+	__le16	edif_sa_index;
 	__le16	flags;
 	__le32	residual;
 	__le16	ox_id;
-- 
2.19.0.rc0

