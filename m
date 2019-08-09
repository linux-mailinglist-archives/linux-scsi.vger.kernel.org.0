Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6481B86FF4
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2019 05:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405241AbfHIDD2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Aug 2019 23:03:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39168 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404934AbfHIDD1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Aug 2019 23:03:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so41228080pfn.6
        for <linux-scsi@vger.kernel.org>; Thu, 08 Aug 2019 20:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+ac2Sb9l+bsr/bcRPgSlS9i0yoq+4jHTcwBlueYCFY=;
        b=fDCHP09G5CNXQ8NnyDsEU/I9G2xpgGAMAXIUe9bJ+ypEkRIbvGq2BTIxQsIt6JM9r/
         LRdrTHcJ8eu0VGQVwcvwrccSvTF+WKDLlKX1dM+vMk2sQHV6jhbCSP6aGPxxSBSO4PgZ
         2OQ0giADgYNyHWPni4vmJUR0vhjNpNT6UKMXA2u+9sOpCFYrpZfLS5NLPse/SOMB/jDG
         xqI8GuxzUEsZm/PU4oA0mkDwMY7kew5tF2Ziw9Pze9rRaY/oqpZ7nO89r9kp1bCqLSkn
         0Ypl0LhIqWzMtR72mtpEf21rg2stwA1HmVR+SlUTwfWnw8J5xF0Rid/+vYfZUWcqlhpB
         tbgg==
X-Gm-Message-State: APjAAAWTMOlrpCnNxlQvb7aHMQM32wNvlEyjGSSZzSa2UkCVyiCbaOm+
        xrNpeW38gQ7KnT9Mg+V9kH0=
X-Google-Smtp-Source: APXvYqw7zUWjrrspGgfdf3xMQbGM1yBur6yKLnVrTLhsTQfCYBOQijlR0L9Mv1FSkPHIE15KPDgyrA==
X-Received: by 2002:a17:90a:d817:: with SMTP id a23mr7062961pjv.54.1565319806062;
        Thu, 08 Aug 2019 20:03:26 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4001:6530:8f02:649d:771a:4703])
        by smtp.gmail.com with ESMTPSA id g2sm111787580pfi.26.2019.08.08.20.03.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:03:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: [PATCH v2 37/58] qla2xxx: Introduce the be_id_t and le_id_t data types for FC src/dst IDs
Date:   Thu,  8 Aug 2019 20:01:58 -0700
Message-Id: <20190809030219.11296-38-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809030219.11296-1-bvanassche@acm.org>
References: <20190809030219.11296-1-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h     |  71 ++++++++++++++--
 drivers/scsi/qla2xxx/qla_gs.c      |  62 ++++----------
 drivers/scsi/qla2xxx/qla_nvme.h    |   2 +-
 drivers/scsi/qla2xxx/qla_target.c  | 126 ++++++++++-------------------
 drivers/scsi/qla2xxx/qla_target.h  |  33 +++-----
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |  23 ++----
 6 files changed, 144 insertions(+), 173 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 8c8279ef3e32..779bf3fcab0f 100644
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
@@ -2746,7 +2805,7 @@ struct ct_sns_req {
 		/* GA_NXT, GPN_ID, GNN_ID, GFT_ID, GFPN_ID */
 		struct {
 			uint8_t reserved;
-			uint8_t port_id[3];
+			be_id_t port_id;
 		} port_id;
 
 		struct {
@@ -2765,13 +2824,13 @@ struct ct_sns_req {
 
 		struct {
 			uint8_t reserved;
-			uint8_t port_id[3];
+			be_id_t port_id;
 			uint8_t fc4_types[32];
 		} rft_id;
 
 		struct {
 			uint8_t reserved;
-			uint8_t port_id[3];
+			be_id_t port_id;
 			uint16_t reserved2;
 			uint8_t fc4_feature;
 			uint8_t fc4_type;
@@ -2779,7 +2838,7 @@ struct ct_sns_req {
 
 		struct {
 			uint8_t reserved;
-			uint8_t port_id[3];
+			be_id_t port_id;
 			uint8_t node_name[8];
 		} rnn_id;
 
@@ -2866,7 +2925,7 @@ struct ct_rsp_hdr {
 
 struct ct_sns_gid_pt_data {
 	uint8_t control_byte;
-	uint8_t port_id[3];
+	be_id_t port_id;
 };
 
 /* It's the same for both GPN_FT and GNN_FT */
@@ -2896,7 +2955,7 @@ struct ct_sns_rsp {
 	union {
 		struct {
 			uint8_t port_type;
-			uint8_t port_id[3];
+			be_id_t port_id;
 			uint8_t port_name[8];
 			uint8_t sym_port_name_len;
 			uint8_t sym_port_name[255];
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 33e0cf210332..18117b5f32bc 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -226,9 +226,7 @@ qla2x00_ga_nxt(scsi_qla_host_t *vha, fc_port_t *fcport)
 	ct_rsp = &ha->ct_sns->p.rsp;
 
 	/* Prepare CT arguments -- port_id */
-	ct_req->req.port_id.port_id[0] = fcport->d_id.b.domain;
-	ct_req->req.port_id.port_id[1] = fcport->d_id.b.area;
-	ct_req->req.port_id.port_id[2] = fcport->d_id.b.al_pa;
+	ct_req->req.port_id.port_id = port_id_to_be_id(fcport->d_id);
 
 	/* Execute MS IOCB */
 	rval = qla2x00_issue_iocb(vha, ha->ms_iocb, ha->ms_iocb_dma,
@@ -242,9 +240,7 @@ qla2x00_ga_nxt(scsi_qla_host_t *vha, fc_port_t *fcport)
 		rval = QLA_FUNCTION_FAILED;
 	} else {
 		/* Populate fc_port_t entry. */
-		fcport->d_id.b.domain = ct_rsp->rsp.ga_nxt.port_id[0];
-		fcport->d_id.b.area = ct_rsp->rsp.ga_nxt.port_id[1];
-		fcport->d_id.b.al_pa = ct_rsp->rsp.ga_nxt.port_id[2];
+		fcport->d_id = be_to_port_id(ct_rsp->rsp.ga_nxt.port_id);
 
 		memcpy(fcport->node_name, ct_rsp->rsp.ga_nxt.node_name,
 		    WWN_SIZE);
@@ -337,9 +333,7 @@ qla2x00_gid_pt(scsi_qla_host_t *vha, sw_info_t *list)
 		/* Set port IDs in switch info list. */
 		for (i = 0; i < ha->max_fibre_devices; i++) {
 			gid_data = &ct_rsp->rsp.gid_pt.entries[i];
-			list[i].d_id.b.domain = gid_data->port_id[0];
-			list[i].d_id.b.area = gid_data->port_id[1];
-			list[i].d_id.b.al_pa = gid_data->port_id[2];
+			list[i].d_id = be_to_port_id(gid_data->port_id);
 			memset(list[i].fabric_port_name, 0, WWN_SIZE);
 			list[i].fp_speed = PORT_SPEED_UNKNOWN;
 
@@ -403,9 +397,7 @@ qla2x00_gpn_id(scsi_qla_host_t *vha, sw_info_t *list)
 		ct_rsp = &ha->ct_sns->p.rsp;
 
 		/* Prepare CT arguments -- port_id */
-		ct_req->req.port_id.port_id[0] = list[i].d_id.b.domain;
-		ct_req->req.port_id.port_id[1] = list[i].d_id.b.area;
-		ct_req->req.port_id.port_id[2] = list[i].d_id.b.al_pa;
+		ct_req->req.port_id.port_id = port_id_to_be_id(list[i].d_id);
 
 		/* Execute MS IOCB */
 		rval = qla2x00_issue_iocb(vha, ha->ms_iocb, ha->ms_iocb_dma,
@@ -472,9 +464,7 @@ qla2x00_gnn_id(scsi_qla_host_t *vha, sw_info_t *list)
 		ct_rsp = &ha->ct_sns->p.rsp;
 
 		/* Prepare CT arguments -- port_id */
-		ct_req->req.port_id.port_id[0] = list[i].d_id.b.domain;
-		ct_req->req.port_id.port_id[1] = list[i].d_id.b.area;
-		ct_req->req.port_id.port_id[2] = list[i].d_id.b.al_pa;
+		ct_req->req.port_id.port_id = port_id_to_be_id(list[i].d_id);
 
 		/* Execute MS IOCB */
 		rval = qla2x00_issue_iocb(vha, ha->ms_iocb, ha->ms_iocb_dma,
@@ -639,9 +629,7 @@ static int qla_async_rftid(scsi_qla_host_t *vha, port_id_t *d_id)
 	ct_req = qla2x00_prep_ct_req(ct_sns, RFT_ID_CMD, RFT_ID_RSP_SIZE);
 
 	/* Prepare CT arguments -- port_id, FC-4 types */
-	ct_req->req.rft_id.port_id[0] = vha->d_id.b.domain;
-	ct_req->req.rft_id.port_id[1] = vha->d_id.b.area;
-	ct_req->req.rft_id.port_id[2] = vha->d_id.b.al_pa;
+	ct_req->req.rft_id.port_id = port_id_to_be_id(vha->d_id);
 	ct_req->req.rft_id.fc4_types[2] = 0x01;		/* FCP-3 */
 
 	if (vha->flags.nvme_enabled)
@@ -737,9 +725,7 @@ static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
 	ct_req = qla2x00_prep_ct_req(ct_sns, RFF_ID_CMD, RFF_ID_RSP_SIZE);
 
 	/* Prepare CT arguments -- port_id, FC-4 feature, FC-4 type */
-	ct_req->req.rff_id.port_id[0] = d_id->b.domain;
-	ct_req->req.rff_id.port_id[1] = d_id->b.area;
-	ct_req->req.rff_id.port_id[2] = d_id->b.al_pa;
+	ct_req->req.rff_id.port_id = port_id_to_be_id(*d_id);
 	ct_req->req.rff_id.fc4_feature = fc4feature;
 	ct_req->req.rff_id.fc4_type = fc4type;		/* SCSI - FCP */
 
@@ -830,9 +816,7 @@ static int qla_async_rnnid(scsi_qla_host_t *vha, port_id_t *d_id,
 	ct_req = qla2x00_prep_ct_req(ct_sns, RNN_ID_CMD, RNN_ID_RSP_SIZE);
 
 	/* Prepare CT arguments -- port_id, node_name */
-	ct_req->req.rnn_id.port_id[0] = vha->d_id.b.domain;
-	ct_req->req.rnn_id.port_id[1] = vha->d_id.b.area;
-	ct_req->req.rnn_id.port_id[2] = vha->d_id.b.al_pa;
+	ct_req->req.rnn_id.port_id = port_id_to_be_id(vha->d_id);
 	memcpy(ct_req->req.rnn_id.node_name, vha->node_name, WWN_SIZE);
 
 	sp->u.iocb_cmd.u.ctarg.req_size = RNN_ID_REQ_SIZE;
@@ -2728,9 +2712,7 @@ qla2x00_gfpn_id(scsi_qla_host_t *vha, sw_info_t *list)
 		ct_rsp = &ha->ct_sns->p.rsp;
 
 		/* Prepare CT arguments -- port_id */
-		ct_req->req.port_id.port_id[0] = list[i].d_id.b.domain;
-		ct_req->req.port_id.port_id[1] = list[i].d_id.b.area;
-		ct_req->req.port_id.port_id[2] = list[i].d_id.b.al_pa;
+		ct_req->req.port_id.port_id = port_id_to_be_id(list[i].d_id);
 
 		/* Execute MS IOCB */
 		rval = qla2x00_issue_iocb(vha, ha->ms_iocb, ha->ms_iocb_dma,
@@ -2934,9 +2916,7 @@ qla2x00_gff_id(scsi_qla_host_t *vha, sw_info_t *list)
 		ct_rsp = &ha->ct_sns->p.rsp;
 
 		/* Prepare CT arguments -- port_id */
-		ct_req->req.port_id.port_id[0] = list[i].d_id.b.domain;
-		ct_req->req.port_id.port_id[1] = list[i].d_id.b.area;
-		ct_req->req.port_id.port_id[2] = list[i].d_id.b.al_pa;
+		ct_req->req.port_id.port_id = port_id_to_be_id(list[i].d_id);
 
 		/* Execute MS IOCB */
 		rval = qla2x00_issue_iocb(vha, ha->ms_iocb, ha->ms_iocb_dma,
@@ -3293,20 +3273,18 @@ static void qla2x00_async_gpnid_sp_done(void *s, int res)
 	if (res)
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
 		    "Async done-%s fail res %x rscn gen %d ID %3phC. %8phC\n",
-		    sp->name, res, sp->gen1, ct_req->req.port_id.port_id,
+		    sp->name, res, sp->gen1, &ct_req->req.port_id.port_id,
 		    ct_rsp->rsp.gpn_id.port_name);
 	else
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
 		    "Async done-%s good rscn gen %d ID %3phC. %8phC\n",
-		    sp->name, sp->gen1, ct_req->req.port_id.port_id,
+		    sp->name, sp->gen1, &ct_req->req.port_id.port_id,
 		    ct_rsp->rsp.gpn_id.port_name);
 
 	memset(&ea, 0, sizeof(ea));
 	memcpy(ea.port_name, ct_rsp->rsp.gpn_id.port_name, WWN_SIZE);
 	ea.sp = sp;
-	ea.id.b.domain = ct_req->req.port_id.port_id[0];
-	ea.id.b.area = ct_req->req.port_id.port_id[1];
-	ea.id.b.al_pa = ct_req->req.port_id.port_id[2];
+	ea.id = be_to_port_id(ct_req->req.port_id.port_id);
 	ea.rc = res;
 	ea.event = FCME_GPNID_DONE;
 
@@ -3417,9 +3395,7 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 	ct_req = qla2x00_prep_ct_req(ct_sns, GPN_ID_CMD, GPN_ID_RSP_SIZE);
 
 	/* GPN_ID req */
-	ct_req->req.port_id.port_id[0] = id->b.domain;
-	ct_req->req.port_id.port_id[1] = id->b.area;
-	ct_req->req.port_id.port_id[2] = id->b.al_pa;
+	ct_req->req.port_id.port_id = port_id_to_be_id(*id);
 
 	sp->u.iocb_cmd.u.ctarg.req_size = GPN_ID_REQ_SIZE;
 	sp->u.iocb_cmd.u.ctarg.rsp_size = GPN_ID_RSP_SIZE;
@@ -3430,7 +3406,7 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 
 	ql_dbg(ql_dbg_disc, vha, 0x2067,
 	    "Async-%s hdl=%x ID %3phC.\n", sp->name,
-	    sp->handle, ct_req->req.port_id.port_id);
+	    sp->handle, &ct_req->req.port_id.port_id);
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS)
@@ -4332,9 +4308,7 @@ int qla24xx_async_gnnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	    GNN_ID_RSP_SIZE);
 
 	/* GNN_ID req */
-	ct_req->req.port_id.port_id[0] = fcport->d_id.b.domain;
-	ct_req->req.port_id.port_id[1] = fcport->d_id.b.area;
-	ct_req->req.port_id.port_id[2] = fcport->d_id.b.al_pa;
+	ct_req->req.port_id.port_id = port_id_to_be_id(fcport->d_id);
 
 
 	/* req & rsp use the same buffer */
@@ -4464,9 +4438,7 @@ int qla24xx_async_gfpnid(scsi_qla_host_t *vha, fc_port_t *fcport)
 	    GFPN_ID_RSP_SIZE);
 
 	/* GFPN_ID req */
-	ct_req->req.port_id.port_id[0] = fcport->d_id.b.domain;
-	ct_req->req.port_id.port_id[1] = fcport->d_id.b.area;
-	ct_req->req.port_id.port_id[2] = fcport->d_id.b.al_pa;
+	ct_req->req.port_id.port_id = port_id_to_be_id(fcport->d_id);
 
 
 	/* req & rsp use the same buffer */
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index 67bb4a2a3742..68a8d09a36ef 100644
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
index d20e0c21710e..3dd897d3e400 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -188,18 +188,19 @@ static inline int qlt_issue_marker(struct scsi_qla_host *vha, int vha_locked)
 
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
@@ -357,9 +358,9 @@ static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
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
@@ -1285,7 +1286,7 @@ static void qlt_clear_tgt_db(struct qla_tgt *tgt)
 	/* At this point tgt could be already dead */
 }
 
-static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
+static int qla24xx_get_loop_id(struct scsi_qla_host *vha, be_id_t s_id,
 	uint16_t *loop_id)
 {
 	struct qla_hw_data *ha = vha->hw;
@@ -1316,9 +1317,9 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
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
@@ -1769,12 +1770,8 @@ static int qlt_build_abts_resp_iocb(struct qla_tgt_mgmt_cmd *mcmd)
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
@@ -1845,19 +1842,11 @@ static void qlt_24xx_send_abts_resp(struct qla_qpair *qpair,
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
@@ -1924,18 +1913,14 @@ static void qlt_24xx_retry_term_exchange(struct scsi_qla_host *vha,
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
@@ -1969,8 +1954,7 @@ static void qlt_24xx_retry_term_exchange(struct scsi_qla_host *vha,
  * XXX does not go through the list of other port (which may have cmds
  *     for the same lun)
  */
-static void abort_cmds_for_lun(struct scsi_qla_host *vha,
-			        u64 lun, uint8_t *s_id)
+static void abort_cmds_for_lun(struct scsi_qla_host *vha, u64 lun, be_id_t s_id)
 {
 	struct qla_tgt_sess_op *op;
 	struct qla_tgt_cmd *cmd;
@@ -2146,7 +2130,7 @@ static void qlt_24xx_handle_abts(struct scsi_qla_host *vha,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess;
 	uint32_t tag = abts->exchange_addr_to_abort;
-	uint8_t s_id[3];
+	be_id_t s_id;
 	int rc;
 	unsigned long flags;
 
@@ -2170,13 +2154,11 @@ static void qlt_24xx_handle_abts(struct scsi_qla_host *vha,
 
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
@@ -2240,9 +2222,7 @@ static void qlt_24xx_send_task_mgmt_ctio(struct qla_qpair *qpair,
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
@@ -2299,9 +2279,7 @@ void qlt_send_resp_ctio(struct qla_qpair *qpair, struct qla_tgt_cmd *cmd,
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
@@ -2602,9 +2580,7 @@ static int qlt_24xx_build_ctio_pkt(struct qla_qpair *qpair,
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
@@ -3117,9 +3093,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
 	pkt->handle |= CTIO_COMPLETION_HANDLE_MARK;
 	pkt->nport_handle = cpu_to_le16(prm->cmd->loop_id);
 	pkt->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
-	pkt->initiator_id[0] = atio->u.isp24.fcp_hdr.s_id[2];
-	pkt->initiator_id[1] = atio->u.isp24.fcp_hdr.s_id[1];
-	pkt->initiator_id[2] = atio->u.isp24.fcp_hdr.s_id[0];
+	pkt->initiator_id = be_id_to_le(atio->u.isp24.fcp_hdr.s_id);
 	pkt->exchange_addr   = atio->u.isp24.exchange_addr;
 
 	/* silence compile warning */
@@ -3669,9 +3643,7 @@ static int __qlt_send_term_exchange(struct qla_qpair *qpair,
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
@@ -4347,9 +4319,7 @@ static int qlt_handle_cmd_for_atio(struct scsi_qla_host *vha,
 		return -ENODEV;
 	}
 
-	id.b.al_pa = atio->u.isp24.fcp_hdr.s_id[2];
-	id.b.area = atio->u.isp24.fcp_hdr.s_id[1];
-	id.b.domain = atio->u.isp24.fcp_hdr.s_id[0];
+	id = be_to_port_id(atio->u.isp24.fcp_hdr.s_id);
 	if (IS_SW_RESV_ADDR(id))
 		return -EBUSY;
 
@@ -5305,10 +5275,7 @@ static int __qlt_send_busy(struct qla_qpair *qpair,
 	u16 temp;
 	port_id_t id;
 
-	id.b.al_pa = atio->u.isp24.fcp_hdr.s_id[2];
-	id.b.area = atio->u.isp24.fcp_hdr.s_id[1];
-	id.b.domain = atio->u.isp24.fcp_hdr.s_id[0];
-	id.b.rsvd_1 = 0;
+	id = be_to_port_id(atio->u.isp24.fcp_hdr.s_id);
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	sess = qla2x00_find_fcport_by_nportid(vha, &id, 1);
@@ -5336,9 +5303,7 @@ static int __qlt_send_busy(struct qla_qpair *qpair,
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
@@ -6124,21 +6089,21 @@ static fc_port_t *qlt_get_port_database(struct scsi_qla_host *vha,
 
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
 
@@ -6155,13 +6120,12 @@ static struct fc_port *qlt_make_local_sess(struct scsi_qla_host *vha,
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
@@ -6200,7 +6164,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess = NULL;
 	unsigned long flags = 0, flags2 = 0;
-	uint8_t s_id[3];
+	be_id_t s_id;
 	int rc;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags2);
@@ -6208,9 +6172,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	if (tgt->tgt_stop)
 		goto out_term2;
 
-	s_id[0] = prm->abts.fcp_hdr_le.s_id[2];
-	s_id[1] = prm->abts.fcp_hdr_le.s_id[1];
-	s_id[2] = prm->abts.fcp_hdr_le.s_id[0];
+	s_id = le_id_to_be(prm->abts.fcp_hdr_le.s_id);
 
 	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
 	if (!sess) {
@@ -6264,7 +6226,7 @@ static void qlt_tmr_work(struct qla_tgt *tgt,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess;
 	unsigned long flags;
-	uint8_t *s_id = NULL; /* to hide compiler warnings */
+	be_id_t s_id;
 	int rc;
 	u64 unpacked_lun;
 	int fn;
@@ -6806,7 +6768,7 @@ qlt_24xx_process_atio_queue(struct scsi_qla_host *vha, uint8_t ha_locked)
 			 */
 			ql_log(ql_log_warn, vha, 0xd03c,
 			    "corrupted fcp frame SID[%3phN] OXID[%04x] EXCG[%x] %64phN\n",
-			    pkt->u.isp24.fcp_hdr.s_id,
+			    &pkt->u.isp24.fcp_hdr.s_id,
 			    be16_to_cpu(pkt->u.isp24.fcp_hdr.ox_id),
 			    le32_to_cpu(pkt->u.isp24.exchange_addr), pkt);
 
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 29d98757acff..d006f0a97b8c 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -247,9 +247,9 @@ struct ctio_to_2xxx {
 
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
@@ -261,9 +261,9 @@ struct fcp_hdr {
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
@@ -402,7 +402,7 @@ struct ctio7_to_24xx {
 	uint16_t dseg_count;		    /* Data segment count. */
 	uint8_t  vp_index;
 	uint8_t  add_flags;
-	uint8_t  initiator_id[3];
+	le_id_t  initiator_id;
 	uint8_t  reserved;
 	uint32_t exchange_addr;
 	union {
@@ -498,7 +498,7 @@ struct ctio_crc2_to_fw {
 	uint8_t  add_flags;		/* additional flags */
 #define CTIO_CRC2_AF_DIF_DSD_ENA BIT_3
 
-	uint8_t  initiator_id[3];	/* initiator ID */
+	le_id_t  initiator_id;		/* initiator ID */
 	uint8_t  reserved1;
 	uint32_t exchange_addr;		/* rcv exchange address */
 	uint16_t reserved2;
@@ -682,7 +682,7 @@ struct qla_tgt_func_tmpl {
 	struct fc_port *(*find_sess_by_loop_id)(struct scsi_qla_host *,
 						const uint16_t);
 	struct fc_port *(*find_sess_by_s_id)(struct scsi_qla_host *,
-						const uint8_t *);
+					     const be_id_t);
 	void (*clear_nacl_from_fcport_map)(struct fc_port *);
 	void (*put_sess)(struct fc_port *);
 	void (*shutdown_sess)(struct fc_port *);
@@ -1030,22 +1030,11 @@ static inline bool qla_dual_mode_enabled(struct scsi_qla_host *ha)
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
index d15412d3d9bd..963c220f8ba8 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1136,9 +1136,8 @@ static struct se_portal_group *tcm_qla2xxx_npiv_make_tpg(struct se_wwn *wwn,
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
@@ -1181,7 +1180,7 @@ static void tcm_qla2xxx_set_sess_by_s_id(
 	struct tcm_qla2xxx_nacl *nacl,
 	struct se_session *se_sess,
 	struct fc_port *fc_port,
-	uint8_t *s_id)
+	be_id_t s_id)
 {
 	u32 key;
 	void *slot;
@@ -1348,14 +1347,9 @@ static void tcm_qla2xxx_clear_sess_lookup(struct tcm_qla2xxx_lport *lport,
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
@@ -1401,19 +1395,14 @@ static int tcm_qla2xxx_session_cb(struct se_portal_group *se_tpg,
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
2.22.0

