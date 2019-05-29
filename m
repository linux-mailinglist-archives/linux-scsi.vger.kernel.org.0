Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7E2E627
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE2U3C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:29:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39254 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U3C (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:29:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so1533837plm.6
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yykm2+VoWAXGTnunh6+wrH8zsd4Ddf7lpJlm/Op1AeY=;
        b=eP6Nm6G18qShR/1JmXopWYG1ZsOYhtszf989p6SuxVX3Re2VL7hL7ZEwsdeR5Z14Hp
         9webIxmAyg9qrIWGzuKmmAwW/w+PBhOOPCtrFrThNI9Yg1100sEvgESHoL5nRXmIJ1vV
         t5gn+NT7QtsP8AUxdhbDWraePfHmq/b0GBlH+mcbxF/SIPubWn2mBnojxQSYbKWP4DmD
         FoZsgHBH+Wz+Rr32aL5ZK3VrKjbBW8mD7xox4oXHA2EvilaIV+x2Mm1t4QeUEVbEUZ+J
         OpJz3uJC1lN9BiqMLCMMA6wvQpUhjevNj29oxivDC8I2jQymsWwEP8aRX1xGZ6RSUred
         hytw==
X-Gm-Message-State: APjAAAUIJiIt0VFlcqMaIJBkSqfKp3SiisRLYmSh17dH99/toVI3eUhD
        8S0qUPHPqb/YzgpnAG1fQUQ=
X-Google-Smtp-Source: APXvYqwsld1PR2pdM53mReHDSzq/UsKVi5xXqAk6wedf9UhnBhuqmqhssrNwPn6BVZ/3v9T9+5kc0g==
X-Received: by 2002:a17:902:b949:: with SMTP id h9mr97265810pls.50.1559161740814;
        Wed, 29 May 2019 13:29:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:29:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 19/20] qla2xxx: Introduce the be_id_t and le_id_t data types for FC src/dst IDs
Date:   Wed, 29 May 2019 13:28:25 -0700
Message-Id: <20190529202826.204499-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce the be_id_t and le_id_t data types for Fibre Channel source and
destination ID formats supported by the firmware instead of using an
uint8_t[3] array. Introduce functions for converting from and to the
port_id_t data types. This patch does not change the behavior of the
qla2xxx driver but improves source code readability and also allows the
compiler to verify the endianness of Fibre Channel IDs.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h     |  59 ++++++++++++++
 drivers/scsi/qla2xxx/qla_nvme.h    |   2 +-
 drivers/scsi/qla2xxx/qla_target.c  | 126 ++++++++++-------------------
 drivers/scsi/qla2xxx/qla_target.h  |  33 +++-----
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |  23 ++----
 5 files changed, 121 insertions(+), 122 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 8edca0a00586..af933444a362 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -34,6 +34,20 @@
 #include <scsi/scsi_transport_fc.h>
 #include <scsi/scsi_bsg_fc.h>
 
+/* Big endian Fibre Channel S_ID (source ID) or D_ID (destination ID). */
+typedef struct {
+	uint8_t domain;
+	uint8_t area;
+	uint8_t al_pa;
+} be_id_t;
+
+/* Little endian Fibre Channel S_ID (source ID) or D_ID (destination ID). */
+typedef struct {
+	uint8_t al_pa;
+	uint8_t area;
+	uint8_t domain;
+} le_id_t;
+
 #include "qla_bsg.h"
 #include "qla_dsd.h"
 #include "qla_nx.h"
@@ -343,6 +357,51 @@ typedef union {
 } port_id_t;
 #define INVALID_PORT_ID	0xFFFFFF
 
+static inline le_id_t be_id_to_le(be_id_t id)
+{
+	le_id_t res;
+
+	res.domain = id.domain;
+	res.area   = id.area;
+	res.al_pa  = id.al_pa;
+
+	return res;
+}
+
+static inline be_id_t le_id_to_be(le_id_t id)
+{
+	be_id_t res;
+
+	res.domain = id.domain;
+	res.area   = id.area;
+	res.al_pa  = id.al_pa;
+
+	return res;
+}
+
+static inline port_id_t be_to_port_id(be_id_t id)
+{
+	port_id_t res;
+
+	res.b.domain = id.domain;
+	res.b.area   = id.area;
+	res.b.al_pa  = id.al_pa;
+	res.b.rsvd_1 = 0;
+
+	return res;
+}
+
+static inline be_id_t port_id_to_be_id(port_id_t port_id)
+{
+	be_id_t res;
+
+	res.domain = port_id.b.domain;
+	res.area   = port_id.b.area;
+	res.al_pa  = port_id.b.al_pa;
+
+	return res;
+}
+
 struct els_logo_payload {
 	uint8_t opcode;
 	uint8_t rsvd[3];
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index d3b8a6440113..55ebb0fefa74 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -119,7 +119,7 @@ struct pt_ls4_rx_unsol {
 	uint32_t exchange_address;
 	uint8_t d_id[3];
 	uint8_t r_ctl;
-	uint8_t s_id[3];
+	be_id_t s_id;
 	uint8_t cs_ctl;
 	uint8_t f_ctl[3];
 	uint8_t type;
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 4c922ca33f60..17d6443c20c9 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -197,18 +197,19 @@ static inline int qlt_issue_marker(struct scsi_qla_host *vha, int vha_locked)
 
 static inline
 struct scsi_qla_host *qlt_find_host_by_d_id(struct scsi_qla_host *vha,
-	uint8_t *d_id)
+					    be_id_t d_id)
 {
 	struct scsi_qla_host *host;
 	uint32_t key = 0;
 
-	if ((vha->d_id.b.area == d_id[1]) && (vha->d_id.b.domain == d_id[0]) &&
-	    (vha->d_id.b.al_pa == d_id[2]))
+	if (vha->d_id.b.area == d_id.area &&
+	    vha->d_id.b.domain == d_id.domain &&
+	    vha->d_id.b.al_pa == d_id.al_pa)
 		return vha;
 
-	key  = (uint32_t)d_id[0] << 16;
-	key |= (uint32_t)d_id[1] <<  8;
-	key |= (uint32_t)d_id[2];
+	key  = d_id.domain << 16;
+	key |= d_id.area << 8;
+	key |= d_id.al_pa;
 
 	host = btree_lookup32(&vha->hw->tgt.host_map, key);
 	if (!host)
@@ -366,9 +367,9 @@ static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
 			ql_dbg(ql_dbg_tgt, vha, 0xe03e,
 			    "qla_target(%d): Received ATIO_TYPE7 "
 			    "with unknown d_id %x:%x:%x\n", vha->vp_idx,
-			    atio->u.isp24.fcp_hdr.d_id[0],
-			    atio->u.isp24.fcp_hdr.d_id[1],
-			    atio->u.isp24.fcp_hdr.d_id[2]);
+			    atio->u.isp24.fcp_hdr.d_id.domain,
+			    atio->u.isp24.fcp_hdr.d_id.area,
+			    atio->u.isp24.fcp_hdr.d_id.al_pa);
 
 
 			qlt_queue_unknown_atio(vha, atio, ha_locked);
@@ -1295,7 +1296,7 @@ static void qlt_clear_tgt_db(struct qla_tgt *tgt)
 	/* At this point tgt could be already dead */
 }
 
-static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
+static int qla24xx_get_loop_id(struct scsi_qla_host *vha, be_id_t s_id,
 	uint16_t *loop_id)
 {
 	struct qla_hw_data *ha = vha->hw;
@@ -1326,9 +1327,9 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
 	gid = gid_list;
 	res = -ENOENT;
 	for (i = 0; i < entries; i++) {
-		if ((gid->al_pa == s_id[2]) &&
-		    (gid->area == s_id[1]) &&
-		    (gid->domain == s_id[0])) {
+		if (gid->al_pa == s_id.al_pa &&
+		    gid->area == s_id.area &&
+		    gid->domain == s_id.domain) {
 			*loop_id = le16_to_cpu(gid->loop_id);
 			res = 0;
 			break;
@@ -1779,12 +1780,8 @@ static int qlt_build_abts_resp_iocb(struct qla_tgt_mgmt_cmd *mcmd)
 	resp->fcp_hdr_le.f_ctl[1] = *p++;
 	resp->fcp_hdr_le.f_ctl[2] = *p;
 
-	resp->fcp_hdr_le.d_id[0] = abts->fcp_hdr_le.s_id[0];
-	resp->fcp_hdr_le.d_id[1] = abts->fcp_hdr_le.s_id[1];
-	resp->fcp_hdr_le.d_id[2] = abts->fcp_hdr_le.s_id[2];
-	resp->fcp_hdr_le.s_id[0] = abts->fcp_hdr_le.d_id[0];
-	resp->fcp_hdr_le.s_id[1] = abts->fcp_hdr_le.d_id[1];
-	resp->fcp_hdr_le.s_id[2] = abts->fcp_hdr_le.d_id[2];
+	resp->fcp_hdr_le.d_id = abts->fcp_hdr_le.s_id;
+	resp->fcp_hdr_le.s_id = abts->fcp_hdr_le.d_id;
 
 	resp->exchange_addr_to_abort = abts->exchange_addr_to_abort;
 	if (mcmd->fc_tm_rsp == FCP_TMF_CMPL) {
@@ -1855,19 +1852,11 @@ static void qlt_24xx_send_abts_resp(struct qla_qpair *qpair,
 	resp->fcp_hdr_le.f_ctl[1] = *p++;
 	resp->fcp_hdr_le.f_ctl[2] = *p;
 	if (ids_reversed) {
-		resp->fcp_hdr_le.d_id[0] = abts->fcp_hdr_le.d_id[0];
-		resp->fcp_hdr_le.d_id[1] = abts->fcp_hdr_le.d_id[1];
-		resp->fcp_hdr_le.d_id[2] = abts->fcp_hdr_le.d_id[2];
-		resp->fcp_hdr_le.s_id[0] = abts->fcp_hdr_le.s_id[0];
-		resp->fcp_hdr_le.s_id[1] = abts->fcp_hdr_le.s_id[1];
-		resp->fcp_hdr_le.s_id[2] = abts->fcp_hdr_le.s_id[2];
+		resp->fcp_hdr_le.d_id = abts->fcp_hdr_le.d_id;
+		resp->fcp_hdr_le.s_id = abts->fcp_hdr_le.s_id;
 	} else {
-		resp->fcp_hdr_le.d_id[0] = abts->fcp_hdr_le.s_id[0];
-		resp->fcp_hdr_le.d_id[1] = abts->fcp_hdr_le.s_id[1];
-		resp->fcp_hdr_le.d_id[2] = abts->fcp_hdr_le.s_id[2];
-		resp->fcp_hdr_le.s_id[0] = abts->fcp_hdr_le.d_id[0];
-		resp->fcp_hdr_le.s_id[1] = abts->fcp_hdr_le.d_id[1];
-		resp->fcp_hdr_le.s_id[2] = abts->fcp_hdr_le.d_id[2];
+		resp->fcp_hdr_le.d_id = abts->fcp_hdr_le.s_id;
+		resp->fcp_hdr_le.s_id = abts->fcp_hdr_le.d_id;
 	}
 	resp->exchange_addr_to_abort = abts->exchange_addr_to_abort;
 	if (status == FCP_TMF_CMPL) {
@@ -1934,18 +1923,14 @@ static void qlt_24xx_retry_term_exchange(struct scsi_qla_host *vha,
 	tmp = (CTIO7_FLAGS_STATUS_MODE_1 | CTIO7_FLAGS_TERMINATE);
 
 	if (mcmd) {
-		ctio->initiator_id[0] = entry->fcp_hdr_le.s_id[0];
-		ctio->initiator_id[1] = entry->fcp_hdr_le.s_id[1];
-		ctio->initiator_id[2] = entry->fcp_hdr_le.s_id[2];
+		ctio->initiator_id = entry->fcp_hdr_le.s_id;
 
 		if (mcmd->flags & QLA24XX_MGMT_ABORT_IO_ATTR_VALID)
 			tmp |= (mcmd->abort_io_attr << 9);
 		else if (qpair->retry_term_cnt & 1)
 			tmp |= (0x4 << 9);
 	} else {
-		ctio->initiator_id[0] = entry->fcp_hdr_le.d_id[0];
-		ctio->initiator_id[1] = entry->fcp_hdr_le.d_id[1];
-		ctio->initiator_id[2] = entry->fcp_hdr_le.d_id[2];
+		ctio->initiator_id = entry->fcp_hdr_le.d_id;
 
 		if (qpair->retry_term_cnt & 1)
 			tmp |= (0x4 << 9);
@@ -1979,8 +1964,7 @@ static void qlt_24xx_retry_term_exchange(struct scsi_qla_host *vha,
  * XXX does not go through the list of other port (which may have cmds
  *     for the same lun)
  */
-static void abort_cmds_for_lun(struct scsi_qla_host *vha,
-			        u64 lun, uint8_t *s_id)
+static void abort_cmds_for_lun(struct scsi_qla_host *vha, u64 lun, be_id_t s_id)
 {
 	struct qla_tgt_sess_op *op;
 	struct qla_tgt_cmd *cmd;
@@ -2156,7 +2140,7 @@ static void qlt_24xx_handle_abts(struct scsi_qla_host *vha,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess;
 	uint32_t tag = abts->exchange_addr_to_abort;
-	uint8_t s_id[3];
+	be_id_t s_id;
 	int rc;
 	unsigned long flags;
 
@@ -2180,13 +2164,11 @@ static void qlt_24xx_handle_abts(struct scsi_qla_host *vha,
 
 	ql_dbg(ql_dbg_tgt_mgt, vha, 0xf011,
 	    "qla_target(%d): task abort (s_id=%x:%x:%x, "
-	    "tag=%d, param=%x)\n", vha->vp_idx, abts->fcp_hdr_le.s_id[2],
-	    abts->fcp_hdr_le.s_id[1], abts->fcp_hdr_le.s_id[0], tag,
+	    "tag=%d, param=%x)\n", vha->vp_idx, abts->fcp_hdr_le.s_id.domain,
+	    abts->fcp_hdr_le.s_id.area, abts->fcp_hdr_le.s_id.al_pa, tag,
 	    le32_to_cpu(abts->fcp_hdr_le.parameter));
 
-	s_id[0] = abts->fcp_hdr_le.s_id[2];
-	s_id[1] = abts->fcp_hdr_le.s_id[1];
-	s_id[2] = abts->fcp_hdr_le.s_id[0];
+	s_id = le_id_to_be(abts->fcp_hdr_le.s_id);
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
@@ -2250,9 +2232,7 @@ static void qlt_24xx_send_task_mgmt_ctio(struct qla_qpair *qpair,
 	ctio->nport_handle = mcmd->sess->loop_id;
 	ctio->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
 	ctio->vp_index = ha->vp_idx;
-	ctio->initiator_id[0] = atio->u.isp24.fcp_hdr.s_id[2];
-	ctio->initiator_id[1] = atio->u.isp24.fcp_hdr.s_id[1];
-	ctio->initiator_id[2] = atio->u.isp24.fcp_hdr.s_id[0];
+	ctio->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
 	ctio->exchange_addr = atio->u.isp24.exchange_addr;
 	temp = (atio->u.isp24.attr << 9)|
 		CTIO7_FLAGS_STATUS_MODE_1 | CTIO7_FLAGS_SEND_STATUS;
@@ -2309,9 +2289,7 @@ void qlt_send_resp_ctio(struct qla_qpair *qpair, struct qla_tgt_cmd *cmd,
 	ctio->nport_handle = cmd->sess->loop_id;
 	ctio->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
 	ctio->vp_index = vha->vp_idx;
-	ctio->initiator_id[0] = atio->u.isp24.fcp_hdr.s_id[2];
-	ctio->initiator_id[1] = atio->u.isp24.fcp_hdr.s_id[1];
-	ctio->initiator_id[2] = atio->u.isp24.fcp_hdr.s_id[0];
+	ctio->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
 	ctio->exchange_addr = atio->u.isp24.exchange_addr;
 	temp = (atio->u.isp24.attr << 9) |
 	    CTIO7_FLAGS_STATUS_MODE_1 | CTIO7_FLAGS_SEND_STATUS;
@@ -2612,9 +2590,7 @@ static int qlt_24xx_build_ctio_pkt(struct qla_qpair *qpair,
 	pkt->handle |= CTIO_COMPLETION_HANDLE_MARK;
 	pkt->nport_handle = cpu_to_le16(prm->cmd->loop_id);
 	pkt->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
-	pkt->initiator_id[0] = atio->u.isp24.fcp_hdr.s_id[2];
-	pkt->initiator_id[1] = atio->u.isp24.fcp_hdr.s_id[1];
-	pkt->initiator_id[2] = atio->u.isp24.fcp_hdr.s_id[0];
+	pkt->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
 	pkt->exchange_addr = atio->u.isp24.exchange_addr;
 	temp = atio->u.isp24.attr << 9;
 	pkt->u.status0.flags |= cpu_to_le16(temp);
@@ -3127,9 +3103,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
 	pkt->handle |= CTIO_COMPLETION_HANDLE_MARK;
 	pkt->nport_handle = cpu_to_le16(prm->cmd->loop_id);
 	pkt->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
-	pkt->initiator_id[0] = atio->u.isp24.fcp_hdr.s_id[2];
-	pkt->initiator_id[1] = atio->u.isp24.fcp_hdr.s_id[1];
-	pkt->initiator_id[2] = atio->u.isp24.fcp_hdr.s_id[0];
+	pkt->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
 	pkt->exchange_addr   = atio->u.isp24.exchange_addr;
 
 	/* silence compile warning */
@@ -3679,9 +3653,7 @@ static int __qlt_send_term_exchange(struct qla_qpair *qpair,
 	ctio24->nport_handle = CTIO7_NHANDLE_UNRECOGNIZED;
 	ctio24->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
 	ctio24->vp_index = vha->vp_idx;
-	ctio24->initiator_id[0] = atio->u.isp24.fcp_hdr.s_id[2];
-	ctio24->initiator_id[1] = atio->u.isp24.fcp_hdr.s_id[1];
-	ctio24->initiator_id[2] = atio->u.isp24.fcp_hdr.s_id[0];
+	ctio24->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
 	ctio24->exchange_addr = atio->u.isp24.exchange_addr;
 	temp = (atio->u.isp24.attr << 9) | CTIO7_FLAGS_STATUS_MODE_1 |
 		CTIO7_FLAGS_TERMINATE;
@@ -4357,9 +4329,7 @@ static int qlt_handle_cmd_for_atio(struct scsi_qla_host *vha,
 		return -ENODEV;
 	}
 
-	id.b.al_pa = atio->u.isp24.fcp_hdr.s_id[2];
-	id.b.area = atio->u.isp24.fcp_hdr.s_id[1];
-	id.b.domain = atio->u.isp24.fcp_hdr.s_id[0];
+	id = be_to_port_id(atio->u.isp24.fcp_hdr.s_id);
 	if (IS_SW_RESV_ADDR(id))
 		return -EBUSY;
 
@@ -5313,10 +5283,7 @@ static int __qlt_send_busy(struct qla_qpair *qpair,
 	u16 temp;
 	port_id_t id;
 
-	id.b.al_pa = atio->u.isp24.fcp_hdr.s_id[2];
-	id.b.area = atio->u.isp24.fcp_hdr.s_id[1];
-	id.b.domain = atio->u.isp24.fcp_hdr.s_id[0];
-	id.b.rsvd_1 = 0;
+	id = be_to_port_id(atio->u.isp24.fcp_hdr.s_id);
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	sess = qla2x00_find_fcport_by_nportid(vha, &id, 1);
@@ -5344,9 +5311,7 @@ static int __qlt_send_busy(struct qla_qpair *qpair,
 	ctio24->nport_handle = sess->loop_id;
 	ctio24->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
 	ctio24->vp_index = vha->vp_idx;
-	ctio24->initiator_id[0] = atio->u.isp24.fcp_hdr.s_id[2];
-	ctio24->initiator_id[1] = atio->u.isp24.fcp_hdr.s_id[1];
-	ctio24->initiator_id[2] = atio->u.isp24.fcp_hdr.s_id[0];
+	ctio24->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
 	ctio24->exchange_addr = atio->u.isp24.exchange_addr;
 	temp = (atio->u.isp24.attr << 9) |
 		CTIO7_FLAGS_STATUS_MODE_1 | CTIO7_FLAGS_SEND_STATUS |
@@ -6132,21 +6097,21 @@ static fc_port_t *qlt_get_port_database(struct scsi_qla_host *vha,
 
 /* Must be called under tgt_mutex */
 static struct fc_port *qlt_make_local_sess(struct scsi_qla_host *vha,
-	uint8_t *s_id)
+					   be_id_t s_id)
 {
 	struct fc_port *sess = NULL;
 	fc_port_t *fcport = NULL;
 	int rc, global_resets;
 	uint16_t loop_id = 0;
 
-	if ((s_id[0] == 0xFF) && (s_id[1] == 0xFC)) {
+	if (s_id.domain == 0xFF && s_id.area == 0xFC) {
 		/*
 		 * This is Domain Controller, so it should be
 		 * OK to drop SCSI commands from it.
 		 */
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf042,
 		    "Unable to find initiator with S_ID %x:%x:%x",
-		    s_id[0], s_id[1], s_id[2]);
+		    s_id.domain, s_id.area, s_id.al_pa);
 		return NULL;
 	}
 
@@ -6163,13 +6128,12 @@ static struct fc_port *qlt_make_local_sess(struct scsi_qla_host *vha,
 		ql_log(ql_log_info, vha, 0xf071,
 		    "qla_target(%d): Unable to find "
 		    "initiator with S_ID %x:%x:%x",
-		    vha->vp_idx, s_id[0], s_id[1],
-		    s_id[2]);
+		    vha->vp_idx, s_id.domain, s_id.area, s_id.al_pa);
 
 		if (rc == -ENOENT) {
 			qlt_port_logo_t logo;
 
-			sid_to_portid(s_id, &logo.id);
+			logo.id = be_to_port_id(s_id);
 			logo.cmd_count = 1;
 			qlt_send_first_logo(vha, &logo);
 		}
@@ -6208,7 +6172,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess = NULL;
 	unsigned long flags = 0, flags2 = 0;
-	uint8_t s_id[3];
+	be_id_t s_id;
 	int rc;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags2);
@@ -6216,9 +6180,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	if (tgt->tgt_stop)
 		goto out_term2;
 
-	s_id[0] = prm->abts.fcp_hdr_le.s_id[2];
-	s_id[1] = prm->abts.fcp_hdr_le.s_id[1];
-	s_id[2] = prm->abts.fcp_hdr_le.s_id[0];
+	s_id = le_id_to_be(prm->abts.fcp_hdr_le.s_id);
 
 	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
 	if (!sess) {
@@ -6275,7 +6237,7 @@ static void qlt_tmr_work(struct qla_tgt *tgt,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess;
 	unsigned long flags;
-	uint8_t *s_id = NULL; /* to hide compiler warnings */
+	be_id_t s_id;
 	int rc;
 	u64 unpacked_lun;
 	int fn;
@@ -6812,7 +6774,7 @@ qlt_24xx_process_atio_queue(struct scsi_qla_host *vha, uint8_t ha_locked)
 			 */
 			ql_log(ql_log_warn, vha, 0xd03c,
 			    "corrupted fcp frame SID[%3phN] OXID[%04x] EXCG[%x] %64phN\n",
-			    pkt->u.isp24.fcp_hdr.s_id,
+			    &pkt->u.isp24.fcp_hdr.s_id.domain,
 			    be16_to_cpu(pkt->u.isp24.fcp_hdr.ox_id),
 			    le32_to_cpu(pkt->u.isp24.exchange_addr), pkt);
 
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 8e820182a301..ee3f7cca60f4 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -256,9 +256,9 @@ struct ctio_to_2xxx {
 
 struct fcp_hdr {
 	uint8_t  r_ctl;
-	uint8_t  d_id[3];
+	be_id_t  d_id;
 	uint8_t  cs_ctl;
-	uint8_t  s_id[3];
+	be_id_t  s_id;
 	uint8_t  type;
 	uint8_t  f_ctl[3];
 	uint8_t  seq_id;
@@ -270,9 +270,9 @@ struct fcp_hdr {
 } __packed;
 
 struct fcp_hdr_le {
-	uint8_t  d_id[3];
+	le_id_t  d_id;
 	uint8_t  r_ctl;
-	uint8_t  s_id[3];
+	le_id_t  s_id;
 	uint8_t  cs_ctl;
 	uint8_t  f_ctl[3];
 	uint8_t  type;
@@ -411,7 +411,7 @@ struct ctio7_to_24xx {
 	uint16_t dseg_count;		    /* Data segment count. */
 	uint8_t  vp_index;
 	uint8_t  add_flags;
-	uint8_t  initiator_id[3];
+	le_id_t  initiator_id;
 	uint8_t  reserved;
 	uint32_t exchange_addr;
 	union {
@@ -507,7 +507,7 @@ struct ctio_crc2_to_fw {
 	uint8_t  add_flags;		/* additional flags */
 #define CTIO_CRC2_AF_DIF_DSD_ENA BIT_3
 
-	uint8_t  initiator_id[3];	/* initiator ID */
+	le_id_t  initiator_id;		/* initiator ID */
 	uint8_t  reserved1;
 	uint32_t exchange_addr;		/* rcv exchange address */
 	uint16_t reserved2;
@@ -691,7 +691,7 @@ struct qla_tgt_func_tmpl {
 	struct fc_port *(*find_sess_by_loop_id)(struct scsi_qla_host *,
 						const uint16_t);
 	struct fc_port *(*find_sess_by_s_id)(struct scsi_qla_host *,
-						const uint8_t *);
+					     const be_id_t);
 	void (*clear_nacl_from_fcport_map)(struct fc_port *);
 	void (*put_sess)(struct fc_port *);
 	void (*shutdown_sess)(struct fc_port *);
@@ -1039,22 +1039,11 @@ static inline bool qla_dual_mode_enabled(struct scsi_qla_host *ha)
 	return (ha->host->active_mode == MODE_DUAL);
 }
 
-static inline uint32_t sid_to_key(const uint8_t *s_id)
+static inline uint32_t sid_to_key(const be_id_t s_id)
 {
-	uint32_t key;
-
-	key = (((unsigned long)s_id[0] << 16) |
-	       ((unsigned long)s_id[1] << 8) |
-	       (unsigned long)s_id[2]);
-	return key;
-}
-
-static inline void sid_to_portid(const uint8_t *s_id, port_id_t *p)
-{
-	memset(p, 0, sizeof(*p));
-	p->b.domain = s_id[0];
-	p->b.area = s_id[1];
-	p->b.al_pa = s_id[2];
+	return s_id.domain << 16 |
+		s_id.area << 8 |
+		s_id.al_pa;
 }
 
 /*
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index ec9f1996b417..52a3e948ef49 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1144,9 +1144,8 @@ static struct se_portal_group *tcm_qla2xxx_npiv_make_tpg(struct se_wwn *wwn,
 /*
  * Expected to be called with struct qla_hw_data->tgt.sess_lock held
  */
-static struct fc_port *tcm_qla2xxx_find_sess_by_s_id(
-	scsi_qla_host_t *vha,
-	const uint8_t *s_id)
+static struct fc_port *tcm_qla2xxx_find_sess_by_s_id(scsi_qla_host_t *vha,
+						     const be_id_t s_id)
 {
 	struct tcm_qla2xxx_lport *lport;
 	struct se_node_acl *se_nacl;
@@ -1189,7 +1188,7 @@ static void tcm_qla2xxx_set_sess_by_s_id(
 	struct tcm_qla2xxx_nacl *nacl,
 	struct se_session *se_sess,
 	struct fc_port *fc_port,
-	uint8_t *s_id)
+	be_id_t s_id)
 {
 	u32 key;
 	void *slot;
@@ -1356,14 +1355,9 @@ static void tcm_qla2xxx_clear_sess_lookup(struct tcm_qla2xxx_lport *lport,
 		struct tcm_qla2xxx_nacl *nacl, struct fc_port *sess)
 {
 	struct se_session *se_sess = sess->se_sess;
-	unsigned char be_sid[3];
-
-	be_sid[0] = sess->d_id.b.domain;
-	be_sid[1] = sess->d_id.b.area;
-	be_sid[2] = sess->d_id.b.al_pa;
 
 	tcm_qla2xxx_set_sess_by_s_id(lport, NULL, nacl, se_sess,
-				sess, be_sid);
+				     sess, port_id_to_be_id(sess->d_id));
 	tcm_qla2xxx_set_sess_by_loop_id(lport, NULL, nacl, se_sess,
 				sess, sess->loop_id);
 }
@@ -1409,19 +1403,14 @@ static int tcm_qla2xxx_session_cb(struct se_portal_group *se_tpg,
 	struct fc_port *qlat_sess = p;
 	uint16_t loop_id = qlat_sess->loop_id;
 	unsigned long flags;
-	unsigned char be_sid[3];
-
-	be_sid[0] = qlat_sess->d_id.b.domain;
-	be_sid[1] = qlat_sess->d_id.b.area;
-	be_sid[2] = qlat_sess->d_id.b.al_pa;
 
 	/*
 	 * And now setup se_nacl and session pointers into HW lport internal
 	 * mappings for fabric S_ID and LOOP_ID.
 	 */
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-	tcm_qla2xxx_set_sess_by_s_id(lport, se_nacl, nacl,
-				     se_sess, qlat_sess, be_sid);
+	tcm_qla2xxx_set_sess_by_s_id(lport, se_nacl, nacl, se_sess, qlat_sess,
+				     port_id_to_be_id(qlat_sess->d_id));
 	tcm_qla2xxx_set_sess_by_loop_id(lport, se_nacl, nacl,
 					se_sess, qlat_sess, loop_id);
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
-- 
2.22.0.rc1

