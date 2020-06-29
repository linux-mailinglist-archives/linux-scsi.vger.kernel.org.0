Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3F20D334
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2020 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgF2S4m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jun 2020 14:56:42 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:16510 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgF2S4l (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Jun 2020 14:56:41 -0400
Received: from fcoe-test11.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 05TGfM5D011309;
        Mon, 29 Jun 2020 09:41:23 -0700
From:   Varun Prakash <varun@chelsio.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, dt@chelsio.com,
        ganji.aravind@chelsio.com, varun@chelsio.com
Subject: [PATCH] scsi: cxgb4i: add support for iSCSI segmentation offload
Date:   Mon, 29 Jun 2020 22:11:11 +0530
Message-Id: <1593448871-2972-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T5/T6 adapters support iSCSI segmentation offload.
To transmit iSCSI PDUs using ISO driver provides iSCSI
header and data scatterlist to the adapter,
adapter forms multiple iSCSI PDUs and transmits them.

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c |   4 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 246 ++++++++++----
 drivers/scsi/cxgbi/libcxgbi.c      | 665 +++++++++++++++++++++++++++----------
 drivers/scsi/cxgbi/libcxgbi.h      |  46 ++-
 4 files changed, 728 insertions(+), 233 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index ec7d01f..f2714c5 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -361,7 +361,7 @@ static inline void make_tx_data_wr(struct cxgbi_sock *csk, struct sk_buff *skb,
 	/* len includes the length of any HW ULP additions */
 	req->len = htonl(len);
 	/* V_TX_ULP_SUBMODE sets both the mode and submode */
-	req->flags = htonl(V_TX_ULP_SUBMODE(cxgbi_skcb_ulp_mode(skb)) |
+	req->flags = htonl(V_TX_ULP_SUBMODE(cxgbi_skcb_tx_ulp_mode(skb)) |
 			   V_TX_SHOVE((skb_peek(&csk->write_queue) ? 0 : 1)));
 	req->sndseq = htonl(csk->snd_nxt);
 	req->param = htonl(V_TX_PORT(l2t->smt_idx));
@@ -442,7 +442,7 @@ static int push_tx_frames(struct cxgbi_sock *csk, int req_completion)
 				req_completion = 1;
 				csk->wr_una_cred = 0;
 			}
-			len += cxgbi_ulp_extra_len(cxgbi_skcb_ulp_mode(skb));
+			len += cxgbi_ulp_extra_len(cxgbi_skcb_tx_ulp_mode(skb));
 			make_tx_data_wr(csk, skb, len, req_completion);
 			csk->snd_nxt += len;
 			cxgbi_skcb_clear_flag(skb, SKCBF_TX_NEED_HDR);
diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 8ce8592..56629a0 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -197,7 +197,10 @@ static inline bool is_ofld_imm(const struct sk_buff *skb)
 	if (likely(cxgbi_skcb_test_flag(skb, SKCBF_TX_NEED_HDR)))
 		len += sizeof(struct fw_ofld_tx_data_wr);
 
-	return len <= MAX_IMM_TX_PKT_LEN;
+	if  (likely(cxgbi_skcb_test_flag((struct sk_buff *)skb, SKCBF_TX_ISO)))
+		len += sizeof(struct cpl_tx_data_iso);
+
+	return (len <= MAX_IMM_OFLD_TX_DATA_WR_LEN);
 }
 
 static void send_act_open_req(struct cxgbi_sock *csk, struct sk_buff *skb,
@@ -641,7 +644,10 @@ static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
 	flowc->mnemval[8].mnemonic = 0;
 	flowc->mnemval[8].val = 0;
 	flowc->mnemval[8].mnemonic = FW_FLOWC_MNEM_TXDATAPLEN_MAX;
-	flowc->mnemval[8].val = 16384;
+	if (csk->cdev->skb_iso_txhdr)
+		flowc->mnemval[8].val = cpu_to_be32(CXGBI_MAX_ISO_DATA_IN_SKB);
+	else
+		flowc->mnemval[8].val = cpu_to_be32(16128);
 #ifdef CONFIG_CHELSIO_T4_DCB
 	flowc->mnemval[9].mnemonic = FW_FLOWC_MNEM_DCBPRIO;
 	if (vlan == CPL_L2T_VLAN_NONE) {
@@ -667,38 +673,86 @@ static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
 	return flowclen16;
 }
 
-static inline void make_tx_data_wr(struct cxgbi_sock *csk, struct sk_buff *skb,
-				   int dlen, int len, u32 credits, int compl)
+static void
+cxgb4i_make_tx_iso_cpl(struct sk_buff *skb, struct cpl_tx_data_iso *cpl)
+{
+	struct cxgbi_iso_info *info = (struct cxgbi_iso_info *)skb->head;
+	u32 imm_en = !!(info->flags & CXGBI_ISO_INFO_IMM_ENABLE);
+	u32 fslice = !!(info->flags & CXGBI_ISO_INFO_FSLICE);
+	u32 lslice = !!(info->flags & CXGBI_ISO_INFO_LSLICE);
+	u32 pdu_type = (info->op == ISCSI_OP_SCSI_CMD) ? 0 : 1;
+	u32 submode = cxgbi_skcb_tx_ulp_mode(skb) & 0x3;
+
+	cpl->op_to_scsi = cpu_to_be32(CPL_TX_DATA_ISO_OP_V(CPL_TX_DATA_ISO) |
+				CPL_TX_DATA_ISO_FIRST_V(fslice) |
+				CPL_TX_DATA_ISO_LAST_V(lslice) |
+				CPL_TX_DATA_ISO_CPLHDRLEN_V(0) |
+				CPL_TX_DATA_ISO_HDRCRC_V(submode & 1) |
+				CPL_TX_DATA_ISO_PLDCRC_V(((submode >> 1) & 1)) |
+				CPL_TX_DATA_ISO_IMMEDIATE_V(imm_en) |
+				CPL_TX_DATA_ISO_SCSI_V(pdu_type));
+
+	cpl->ahs_len = info->ahs;
+	cpl->mpdu = cpu_to_be16(DIV_ROUND_UP(info->mpdu, 4));
+	cpl->burst_size = cpu_to_be32(info->burst_size);
+	cpl->len = cpu_to_be32(info->len);
+	cpl->reserved2_seglen_offset =
+	     cpu_to_be32(CPL_TX_DATA_ISO_SEGLEN_OFFSET_V(info->segment_offset));
+	cpl->datasn_offset = cpu_to_be32(info->datasn_offset);
+	cpl->buffer_offset = cpu_to_be32(info->buffer_offset);
+	cpl->reserved3 = cpu_to_be32(0);
+	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
+		  "iso: flags 0x%x, op %u, ahs %u, num_pdu %u, mpdu %u, "
+		  "burst_size %u, iso_len %u\n",
+		  info->flags, info->op, info->ahs, info->num_pdu,
+		  info->mpdu, info->burst_size << 2, info->len);
+}
+
+static void
+cxgb4i_make_tx_data_wr(struct cxgbi_sock *csk, struct sk_buff *skb, int dlen,
+		       int len, u32 credits, int compl)
 {
+	struct cxgbi_device *cdev = csk->cdev;
+	struct cxgb4_lld_info *lldi = cxgbi_cdev_priv(cdev);
 	struct fw_ofld_tx_data_wr *req;
-	unsigned int submode = cxgbi_skcb_ulp_mode(skb) & 3;
-	unsigned int wr_ulp_mode = 0, val;
-	bool imm = is_ofld_imm(skb);
-
-	req = __skb_push(skb, sizeof(*req));
-
-	if (imm) {
-		req->op_to_immdlen = htonl(FW_WR_OP_V(FW_OFLD_TX_DATA_WR) |
-					FW_WR_COMPL_F |
-					FW_WR_IMMDLEN_V(dlen));
-		req->flowid_len16 = htonl(FW_WR_FLOWID_V(csk->tid) |
-						FW_WR_LEN16_V(credits));
-	} else {
-		req->op_to_immdlen =
-			cpu_to_be32(FW_WR_OP_V(FW_OFLD_TX_DATA_WR) |
-					FW_WR_COMPL_F |
-					FW_WR_IMMDLEN_V(0));
-		req->flowid_len16 =
-			cpu_to_be32(FW_WR_FLOWID_V(csk->tid) |
-					FW_WR_LEN16_V(credits));
+	struct cpl_tx_data_iso *cpl;
+	u32 submode = cxgbi_skcb_tx_ulp_mode(skb) & 0x3;
+	u32 wr_ulp_mode = 0;
+	u32 hdr_size = sizeof(*req);
+	u32 opcode = FW_OFLD_TX_DATA_WR;
+	u32 immlen = 0;
+	u32 force = is_t5(lldi->adapter_type) ? TX_FORCE_V(!submode) :
+						T6_TX_FORCE_F;
+
+	if (cxgbi_skcb_test_flag(skb, SKCBF_TX_ISO)) {
+		hdr_size += sizeof(struct cpl_tx_data_iso);
+		opcode = FW_ISCSI_TX_DATA_WR;
+		immlen += sizeof(struct cpl_tx_data_iso);
+		submode |= 8;
 	}
+
+	if (is_ofld_imm(skb))
+		immlen += dlen;
+
+	req = (struct fw_ofld_tx_data_wr *)__skb_push(skb, hdr_size);
+	req->op_to_immdlen = cpu_to_be32(FW_WR_OP_V(opcode) |
+					 FW_WR_COMPL_V(compl) |
+					 FW_WR_IMMDLEN_V(immlen));
+	req->flowid_len16 = cpu_to_be32(FW_WR_FLOWID_V(csk->tid) |
+					FW_WR_LEN16_V(credits));
+	req->plen = cpu_to_be32(len);
+	cpl =  (struct cpl_tx_data_iso *)(req + 1);
+
+	if (likely(cxgbi_skcb_test_flag(skb, SKCBF_TX_ISO)))
+		cxgb4i_make_tx_iso_cpl(skb, cpl);
+
 	if (submode)
 		wr_ulp_mode = FW_OFLD_TX_DATA_WR_ULPMODE_V(ULP2_MODE_ISCSI) |
-				FW_OFLD_TX_DATA_WR_ULPSUBMODE_V(submode);
-	val = skb_peek(&csk->write_queue) ? 0 : 1;
-	req->tunnel_to_proxy = htonl(wr_ulp_mode |
-				     FW_OFLD_TX_DATA_WR_SHOVE_V(val));
-	req->plen = htonl(len);
+			      FW_OFLD_TX_DATA_WR_ULPSUBMODE_V(submode);
+
+	req->tunnel_to_proxy = cpu_to_be32(wr_ulp_mode | force |
+					   FW_OFLD_TX_DATA_WR_SHOVE_V(1U));
+
 	if (!cxgbi_sock_flag(csk, CTPF_TX_DATA_SENT))
 		cxgbi_sock_set_flag(csk, CTPF_TX_DATA_SENT);
 }
@@ -716,30 +770,34 @@ static int push_tx_frames(struct cxgbi_sock *csk, int req_completion)
 	if (unlikely(csk->state < CTP_ESTABLISHED ||
 		csk->state == CTP_CLOSE_WAIT_1 || csk->state >= CTP_ABORTING)) {
 		log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_SOCK |
-			 1 << CXGBI_DBG_PDU_TX,
-			"csk 0x%p,%u,0x%lx,%u, in closing state.\n",
-			csk, csk->state, csk->flags, csk->tid);
+			  1 << CXGBI_DBG_PDU_TX,
+			  "csk 0x%p,%u,0x%lx,%u, in closing state.\n",
+			  csk, csk->state, csk->flags, csk->tid);
 		return 0;
 	}
 
-	while (csk->wr_cred && (skb = skb_peek(&csk->write_queue)) != NULL) {
-		int dlen = skb->len;
-		int len = skb->len;
-		unsigned int credits_needed;
-		int flowclen16 = 0;
+	while (csk->wr_cred && ((skb = skb_peek(&csk->write_queue)) != NULL)) {
+		struct cxgbi_iso_info *iso_cpl;
+		u32 dlen = skb->len;
+		u32 len = skb->len;
+		u32 iso_cpl_len = 0;
+		u32 flowclen16 = 0;
+		u32 credits_needed;
+		u32 num_pdu = 1, hdr_len;
+
+		if (cxgbi_skcb_test_flag(skb, SKCBF_TX_ISO))
+			iso_cpl_len = sizeof(struct cpl_tx_data_iso);
 
-		skb_reset_transport_header(skb);
 		if (is_ofld_imm(skb))
-			credits_needed = DIV_ROUND_UP(dlen, 16);
+			credits_needed = DIV_ROUND_UP(dlen + iso_cpl_len, 16);
 		else
-			credits_needed = DIV_ROUND_UP(
-						8 * calc_tx_flits_ofld(skb),
-						16);
+			credits_needed =
+				DIV_ROUND_UP((8 * calc_tx_flits_ofld(skb)) +
+					     iso_cpl_len, 16);
 
 		if (likely(cxgbi_skcb_test_flag(skb, SKCBF_TX_NEED_HDR)))
-			credits_needed += DIV_ROUND_UP(
-					sizeof(struct fw_ofld_tx_data_wr),
-					16);
+			credits_needed +=
+			   DIV_ROUND_UP(sizeof(struct fw_ofld_tx_data_wr), 16);
 
 		/*
 		 * Assumes the initial credits is large enough to support
@@ -754,14 +812,19 @@ static int push_tx_frames(struct cxgbi_sock *csk, int req_completion)
 
 		if (csk->wr_cred < credits_needed) {
 			log_debug(1 << CXGBI_DBG_PDU_TX,
-				"csk 0x%p, skb %u/%u, wr %d < %u.\n",
-				csk, skb->len, skb->data_len,
-				credits_needed, csk->wr_cred);
+				  "csk 0x%p, skb %u/%u, wr %d < %u.\n",
+				  csk, skb->len, skb->data_len,
+				  credits_needed, csk->wr_cred);
+
+			csk->no_tx_credits++;
 			break;
 		}
+
+		csk->no_tx_credits = 0;
+
 		__skb_unlink(skb, &csk->write_queue);
 		set_wr_txq(skb, CPL_PRIORITY_DATA, csk->port_id);
-		skb->csum = credits_needed + flowclen16;
+		skb->csum = (__force __wsum)(credits_needed + flowclen16);
 		csk->wr_cred -= credits_needed;
 		csk->wr_una_cred += credits_needed;
 		cxgbi_sock_enqueue_wr(csk, skb);
@@ -771,25 +834,42 @@ static int push_tx_frames(struct cxgbi_sock *csk, int req_completion)
 			csk, skb->len, skb->data_len, credits_needed,
 			csk->wr_cred, csk->wr_una_cred);
 
+		if (!req_completion &&
+		    ((csk->wr_una_cred >= (csk->wr_max_cred / 2)) ||
+		     after(csk->write_seq, (csk->snd_una + csk->snd_win / 2))))
+			req_completion = 1;
+
 		if (likely(cxgbi_skcb_test_flag(skb, SKCBF_TX_NEED_HDR))) {
-			len += cxgbi_ulp_extra_len(cxgbi_skcb_ulp_mode(skb));
-			make_tx_data_wr(csk, skb, dlen, len, credits_needed,
-					req_completion);
+			u32 ulp_mode = cxgbi_skcb_tx_ulp_mode(skb);
+
+			if (cxgbi_skcb_test_flag(skb, SKCBF_TX_ISO)) {
+				iso_cpl = (struct cxgbi_iso_info *)skb->head;
+				num_pdu = iso_cpl->num_pdu;
+				hdr_len = cxgbi_skcb_tx_iscsi_hdrlen(skb);
+				len += (cxgbi_ulp_extra_len(ulp_mode) * num_pdu) +
+				       (hdr_len * (num_pdu - 1));
+			} else {
+				len += cxgbi_ulp_extra_len(ulp_mode);
+			}
+
+			cxgb4i_make_tx_data_wr(csk, skb, dlen, len,
+					       credits_needed, req_completion);
 			csk->snd_nxt += len;
 			cxgbi_skcb_clear_flag(skb, SKCBF_TX_NEED_HDR);
 		} else if (cxgbi_skcb_test_flag(skb, SKCBF_TX_FLAG_COMPL) &&
 			   (csk->wr_una_cred >= (csk->wr_max_cred / 2))) {
-			struct cpl_close_con_req *req =
-				(struct cpl_close_con_req *)skb->data;
-			req->wr.wr_hi |= htonl(FW_WR_COMPL_F);
+				struct cpl_close_con_req *req =
+					(struct cpl_close_con_req *)skb->data;
+
+				req->wr.wr_hi |= cpu_to_be32(FW_WR_COMPL_F);
 		}
+
 		total_size += skb->truesize;
 		t4_set_arp_err_handler(skb, csk, arp_failure_skb_discard);
 
 		log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_PDU_TX,
-			"csk 0x%p,%u,0x%lx,%u, skb 0x%p, %u.\n",
-			csk, csk->state, csk->flags, csk->tid, skb, len);
-
+			  "csk 0x%p,%u,0x%lx,%u, skb 0x%p, %u.\n",
+			  csk, csk->state, csk->flags, csk->tid, skb, len);
 		cxgb4_l2t_send(csk->cdev->ports[csk->port_id], skb, csk->l2t);
 	}
 	return total_size;
@@ -2111,10 +2191,30 @@ static int cxgb4i_ddp_init(struct cxgbi_device *cdev)
 	return 0;
 }
 
+static bool is_memfree(struct adapter *adap)
+{
+	u32 io;
+
+	io = t4_read_reg(adap, MA_TARGET_MEM_ENABLE_A);
+	if (is_t5(adap->params.chip)) {
+		if ((io & EXT_MEM0_ENABLE_F) || (io & EXT_MEM1_ENABLE_F))
+			return false;
+	} else if (io & EXT_MEM_ENABLE_F) {
+		return false;
+	}
+
+	return true;
+}
+
 static void *t4_uld_add(const struct cxgb4_lld_info *lldi)
 {
 	struct cxgbi_device *cdev;
 	struct port_info *pi;
+	struct net_device *ndev;
+	struct adapter *adap;
+	struct tid_info *t;
+	u32 max_cmds = CXGB4I_SCSI_HOST_QDEPTH;
+	u32 max_conn = CXGBI_MAX_CONN;
 	int i, rc;
 
 	cdev = cxgbi_device_register(sizeof(*lldi), lldi->nports);
@@ -2154,14 +2254,40 @@ static void *t4_uld_add(const struct cxgb4_lld_info *lldi)
 		pr_info("t4 0x%p ddp init failed %d.\n", cdev, rc);
 		goto err_out;
 	}
+
+	ndev = cdev->ports[0];
+	adap = netdev2adap(ndev);
+	if (adap) {
+		t = &adap->tids;
+		if (t->ntids <= CXGBI_MAX_CONN)
+			max_conn = t->ntids;
+
+		if (is_memfree(adap)) {
+			cdev->flags |=	CXGBI_FLAG_DEV_ISO_OFF;
+			max_cmds = CXGB4I_SCSI_HOST_QDEPTH >> 2;
+
+			pr_info("%s: 0x%p, tid %u, SO adapter.\n",
+				ndev->name, cdev, t->ntids);
+		}
+	} else {
+		pr_info("%s, 0x%p, NO adapter struct.\n", ndev->name, cdev);
+	}
+
+	/* ISO is enabled in T5/T6 firmware version >= 1.13.43.0 */
+	if (!is_t4(lldi->adapter_type) &&
+	    (lldi->fw_vers >= 0x10d2b00) &&
+	    !(cdev->flags & CXGBI_FLAG_DEV_ISO_OFF))
+		cdev->skb_iso_txhdr = sizeof(struct cpl_tx_data_iso);
+
 	rc = cxgb4i_ofld_init(cdev);
 	if (rc) {
 		pr_info("t4 0x%p ofld init failed.\n", cdev);
 		goto err_out;
 	}
 
-	rc = cxgbi_hbas_add(cdev, CXGB4I_MAX_LUN, CXGBI_MAX_CONN,
-				&cxgb4i_host_template, cxgb4i_stt);
+	cxgb4i_host_template.can_queue = max_cmds;
+	rc = cxgbi_hbas_add(cdev, CXGB4I_MAX_LUN, max_conn,
+			    &cxgb4i_host_template, cxgb4i_stt);
 	if (rc)
 		goto err_out;
 
diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 4bc794d..1fb101c 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -359,13 +359,15 @@ int cxgbi_hbas_add(struct cxgbi_device *cdev, u64 max_lun,
 		shost->max_lun = max_lun;
 		shost->max_id = max_id;
 		shost->max_channel = 0;
-		shost->max_cmd_len = 16;
+		shost->max_cmd_len = SCSI_MAX_VARLEN_CDB_SIZE;
 
 		chba = iscsi_host_priv(shost);
 		chba->cdev = cdev;
 		chba->ndev = cdev->ports[i];
 		chba->shost = shost;
 
+		shost->can_queue = sht->can_queue - ISCSI_MGMT_CMDS_MAX;
+
 		log_debug(1 << CXGBI_DBG_DEV,
 			"cdev 0x%p, p#%d %s: chba 0x%p.\n",
 			cdev, i, cdev->ports[i]->name, chba);
@@ -1136,82 +1138,6 @@ void cxgbi_sock_check_wr_invariants(const struct cxgbi_sock *csk)
 }
 EXPORT_SYMBOL_GPL(cxgbi_sock_check_wr_invariants);
 
-static int cxgbi_sock_send_pdus(struct cxgbi_sock *csk, struct sk_buff *skb)
-{
-	struct cxgbi_device *cdev = csk->cdev;
-	struct sk_buff *next;
-	int err, copied = 0;
-
-	spin_lock_bh(&csk->lock);
-
-	if (csk->state != CTP_ESTABLISHED) {
-		log_debug(1 << CXGBI_DBG_PDU_TX,
-			"csk 0x%p,%u,0x%lx,%u, EAGAIN.\n",
-			csk, csk->state, csk->flags, csk->tid);
-		err = -EAGAIN;
-		goto out_err;
-	}
-
-	if (csk->err) {
-		log_debug(1 << CXGBI_DBG_PDU_TX,
-			"csk 0x%p,%u,0x%lx,%u, EPIPE %d.\n",
-			csk, csk->state, csk->flags, csk->tid, csk->err);
-		err = -EPIPE;
-		goto out_err;
-	}
-
-	if (csk->write_seq - csk->snd_una >= csk->snd_win) {
-		log_debug(1 << CXGBI_DBG_PDU_TX,
-			"csk 0x%p,%u,0x%lx,%u, FULL %u-%u >= %u.\n",
-			csk, csk->state, csk->flags, csk->tid, csk->write_seq,
-			csk->snd_una, csk->snd_win);
-		err = -ENOBUFS;
-		goto out_err;
-	}
-
-	while (skb) {
-		int frags = skb_shinfo(skb)->nr_frags +
-				(skb->len != skb->data_len);
-
-		if (unlikely(skb_headroom(skb) < cdev->skb_tx_rsvd)) {
-			pr_err("csk 0x%p, skb head %u < %u.\n",
-				csk, skb_headroom(skb), cdev->skb_tx_rsvd);
-			err = -EINVAL;
-			goto out_err;
-		}
-
-		if (frags >= SKB_WR_LIST_SIZE) {
-			pr_err("csk 0x%p, frags %d, %u,%u >%u.\n",
-				csk, skb_shinfo(skb)->nr_frags, skb->len,
-				skb->data_len, (uint)(SKB_WR_LIST_SIZE));
-			err = -EINVAL;
-			goto out_err;
-		}
-
-		next = skb->next;
-		skb->next = NULL;
-		cxgbi_skcb_set_flag(skb, SKCBF_TX_NEED_HDR);
-		cxgbi_sock_skb_entail(csk, skb);
-		copied += skb->len;
-		csk->write_seq += skb->len +
-				cxgbi_ulp_extra_len(cxgbi_skcb_ulp_mode(skb));
-		skb = next;
-	}
-
-	if (likely(skb_queue_len(&csk->write_queue)))
-		cdev->csk_push_tx_frames(csk, 1);
-done:
-	spin_unlock_bh(&csk->lock);
-	return copied;
-
-out_err:
-	if (copied == 0 && err == -EPIPE)
-		copied = csk->err ? csk->err : -EPIPE;
-	else
-		copied = err;
-	goto done;
-}
-
 static inline void
 scmd_get_params(struct scsi_cmnd *sc, struct scatterlist **sgl,
 		unsigned int *sgcnt, unsigned int *dlen,
@@ -1284,8 +1210,6 @@ EXPORT_SYMBOL_GPL(cxgbi_ddp_set_one_ppod);
  * APIs interacting with open-iscsi libraries
  */
 
-static unsigned char padding[4];
-
 int cxgbi_ddp_ppm_setup(void **ppm_pp, struct cxgbi_device *cdev,
 			struct cxgbi_tag_format *tformat,
 			unsigned int iscsi_size, unsigned int llimit,
@@ -1833,9 +1757,10 @@ static int sgl_seek_offset(struct scatterlist *sgl, unsigned int sgcnt,
 	return -EFAULT;
 }
 
-static int sgl_read_to_frags(struct scatterlist *sg, unsigned int sgoffset,
-				unsigned int dlen, struct page_frag *frags,
-				int frag_max)
+static int
+sgl_read_to_frags(struct scatterlist *sg, unsigned int sgoffset,
+		  unsigned int dlen, struct page_frag *frags,
+		  int frag_max, u32 *dlimit)
 {
 	unsigned int datalen = dlen;
 	unsigned int sglen = sg->length - sgoffset;
@@ -1867,6 +1792,7 @@ static int sgl_read_to_frags(struct scatterlist *sg, unsigned int sgoffset,
 			if (i >= frag_max) {
 				pr_warn("too many pages %u, dlen %u.\n",
 					frag_max, dlen);
+				*dlimit = dlen - datalen;
 				return -EINVAL;
 			}
 
@@ -1883,38 +1809,220 @@ static int sgl_read_to_frags(struct scatterlist *sg, unsigned int sgoffset,
 	return i;
 }
 
-int cxgbi_conn_alloc_pdu(struct iscsi_task *task, u8 opcode)
+static void cxgbi_task_data_sgl_check(struct iscsi_task *task)
 {
-	struct iscsi_tcp_conn *tcp_conn = task->conn->dd_data;
+	struct scsi_cmnd *sc = task->sc;
+	struct cxgbi_task_data *tdata = iscsi_task_cxgbi_data(task);
+	struct scatterlist *sg, *sgl = NULL;
+	u32 sgcnt = 0;
+	int i;
+
+	tdata->flags = CXGBI_TASK_SGL_CHECKED;
+	if (!sc)
+		return;
+
+	scmd_get_params(sc, &sgl, &sgcnt, &tdata->dlen, 0);
+	if (!sgl || !sgcnt) {
+		tdata->flags |= CXGBI_TASK_SGL_COPY;
+		return;
+	}
+
+	for_each_sg(sgl, sg, sgcnt, i) {
+		if (page_count(sg_page(sg)) < 1) {
+			tdata->flags |= CXGBI_TASK_SGL_COPY;
+			return;
+		}
+	}
+}
+
+static int
+cxgbi_task_data_sgl_read(struct iscsi_task *task, u32 offset, u32 count,
+			 u32 *dlimit)
+{
+	struct scsi_cmnd *sc = task->sc;
+	struct cxgbi_task_data *tdata = iscsi_task_cxgbi_data(task);
+	struct scatterlist *sgl = NULL;
+	struct scatterlist *sg;
+	u32 dlen = 0;
+	u32 sgcnt;
+	int err;
+
+	if (!sc)
+		return 0;
+
+	scmd_get_params(sc, &sgl, &sgcnt, &dlen, 0);
+	if (!sgl || !sgcnt)
+		return 0;
+
+	err = sgl_seek_offset(sgl, sgcnt, offset, &tdata->sgoffset, &sg);
+	if (err < 0) {
+		pr_warn("tpdu max, sgl %u, bad offset %u/%u.\n",
+			sgcnt, offset, tdata->dlen);
+		return err;
+	}
+	err = sgl_read_to_frags(sg, tdata->sgoffset, count,
+				tdata->frags, MAX_SKB_FRAGS, dlimit);
+	if (err < 0) {
+		log_debug(1 << CXGBI_DBG_ISCSI,
+			  "sgl max limit, sgl %u, offset %u, %u/%u, dlimit %u.\n",
+			  sgcnt, offset, count, tdata->dlen, *dlimit);
+		return err;
+	}
+	tdata->offset = offset;
+	tdata->count = count;
+	tdata->nr_frags = err;
+	tdata->total_count = count;
+	tdata->total_offset = offset;
+
+	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
+		  "%s: offset %u, count %u,\n"
+		  "err %u, total_count %u, total_offset %u\n",
+		  __func__, offset, count, err,  tdata->total_count, tdata->total_offset);
+
+	return 0;
+}
+
+int cxgbi_conn_alloc_pdu(struct iscsi_task *task, u8 op)
+{
+	struct iscsi_conn *conn = task->conn;
+	struct iscsi_session *session = task->conn->session;
+	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 	struct cxgbi_conn *cconn = tcp_conn->dd_data;
 	struct cxgbi_device *cdev = cconn->chba->cdev;
-	struct iscsi_conn *conn = task->conn;
+	struct cxgbi_sock *csk = (cconn && cconn->cep) ? cconn->cep->csk : NULL;
 	struct iscsi_tcp_task *tcp_task = task->dd_data;
 	struct cxgbi_task_data *tdata = iscsi_task_cxgbi_data(task);
 	struct scsi_cmnd *sc = task->sc;
-	struct cxgbi_sock *csk = cconn->cep->csk;
-	struct net_device *ndev = cdev->ports[csk->port_id];
-	int headroom = SKB_TX_ISCSI_PDU_HEADER_MAX;
+	u32 headroom = SKB_TX_ISCSI_PDU_HEADER_MAX;
+	u32 max_txdata_len = conn->max_xmit_dlength;
+	u32 iso_tx_rsvd = 0, local_iso_info = 0;
+	u32 last_tdata_offset, last_tdata_count;
+	int err = 0;
+
+	if (!tcp_task || !tdata) {
+		pr_err("task 0x%p, tcp_task 0x%p, tdata 0x%p.\n",
+		       task, tcp_task, tdata);
+		return -ENOMEM;
+	}
+	if (!csk) {
+		pr_err("task 0x%p, csk gone.\n", task);
+		return -EPIPE;
+	}
+
+	op &= ISCSI_OPCODE_MASK;
 
 	tcp_task->dd_data = tdata;
 	task->hdr = NULL;
 
-	if (SKB_MAX_HEAD(cdev->skb_tx_rsvd) > (512 * MAX_SKB_FRAGS) &&
-	    (opcode == ISCSI_OP_SCSI_DATA_OUT ||
-	     (opcode == ISCSI_OP_SCSI_CMD &&
-	      sc->sc_data_direction == DMA_TO_DEVICE)))
-		/* data could goes into skb head */
-		headroom += min_t(unsigned int,
-				SKB_MAX_HEAD(cdev->skb_tx_rsvd),
-				conn->max_xmit_dlength);
+	last_tdata_count = tdata->count;
+	last_tdata_offset = tdata->offset;
 
-	tdata->skb = alloc_skb(cdev->skb_tx_rsvd + headroom, GFP_ATOMIC);
+	if ((op == ISCSI_OP_SCSI_DATA_OUT) ||
+	    ((op == ISCSI_OP_SCSI_CMD) &&
+	     (sc->sc_data_direction == DMA_TO_DEVICE))) {
+		u32 remaining_data_tosend, dlimit = 0;
+		u32 max_pdu_size, max_num_pdu, num_pdu;
+		u32 count;
+
+		/* Preserve conn->max_xmit_dlength because it can get updated to
+		 * ISO data size.
+		 */
+		if (task->state == ISCSI_TASK_PENDING)
+			tdata->max_xmit_dlength = conn->max_xmit_dlength;
+
+		if (!tdata->offset)
+			cxgbi_task_data_sgl_check(task);
+
+		remaining_data_tosend =
+			tdata->dlen - tdata->offset - tdata->count;
+
+recalculate_sgl:
+		max_txdata_len = tdata->max_xmit_dlength;
+		log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
+			  "tdata->dlen %u, remaining to send %u "
+			  "conn->max_xmit_dlength %u, "
+			  "tdata->max_xmit_dlength %u\n",
+			  tdata->dlen, remaining_data_tosend,
+			  conn->max_xmit_dlength, tdata->max_xmit_dlength);
+
+		if (cdev->skb_iso_txhdr && !csk->disable_iso &&
+		    (remaining_data_tosend > tdata->max_xmit_dlength) &&
+		    !(remaining_data_tosend % 4)) {
+			u32 max_iso_data;
+
+			if ((op == ISCSI_OP_SCSI_CMD) &&
+			    session->initial_r2t_en)
+				goto no_iso;
+
+			max_pdu_size = tdata->max_xmit_dlength +
+				       ISCSI_PDU_NONPAYLOAD_LEN;
+			max_iso_data = rounddown(CXGBI_MAX_ISO_DATA_IN_SKB,
+						 csk->advmss);
+			max_num_pdu = max_iso_data / max_pdu_size;
+
+			num_pdu = (remaining_data_tosend +
+				   tdata->max_xmit_dlength - 1) /
+				  tdata->max_xmit_dlength;
+
+			if (num_pdu > max_num_pdu)
+				num_pdu = max_num_pdu;
+
+			conn->max_xmit_dlength = tdata->max_xmit_dlength * num_pdu;
+			max_txdata_len = conn->max_xmit_dlength;
+			iso_tx_rsvd = cdev->skb_iso_txhdr;
+			local_iso_info = sizeof(struct cxgbi_iso_info);
+
+			log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
+				  "max_pdu_size %u, max_num_pdu %u, "
+				  "max_txdata %u, num_pdu %u\n",
+				  max_pdu_size, max_num_pdu,
+				  max_txdata_len, num_pdu);
+		}
+no_iso:
+		count  = min_t(u32, max_txdata_len, remaining_data_tosend);
+		err = cxgbi_task_data_sgl_read(task,
+					       tdata->offset + tdata->count,
+					       count, &dlimit);
+		if (unlikely(err < 0)) {
+			log_debug(1 << CXGBI_DBG_ISCSI,
+				  "task 0x%p, tcp_task 0x%p, tdata 0x%p, "
+				  "sgl err %d, count %u, dlimit %u\n",
+				  task, tcp_task, tdata, err, count, dlimit);
+			if (dlimit) {
+				remaining_data_tosend =
+					rounddown(dlimit,
+						  tdata->max_xmit_dlength);
+				if (!remaining_data_tosend)
+					remaining_data_tosend = dlimit;
+
+				dlimit = 0;
+
+				conn->max_xmit_dlength = remaining_data_tosend;
+				goto recalculate_sgl;
+			}
+
+			pr_err("task 0x%p, tcp_task 0x%p, tdata 0x%p, "
+				"sgl err %d\n",
+				task, tcp_task, tdata, err);
+			goto ret_err;
+		}
+
+		if ((tdata->flags & CXGBI_TASK_SGL_COPY) ||
+		    (tdata->nr_frags > MAX_SKB_FRAGS))
+			headroom += conn->max_xmit_dlength;
+	}
+
+	tdata->skb = alloc_skb(local_iso_info + cdev->skb_tx_rsvd +
+			       iso_tx_rsvd + headroom, GFP_ATOMIC);
 	if (!tdata->skb) {
-		ndev->stats.tx_dropped++;
-		return -ENOMEM;
+		tdata->count = last_tdata_count;
+		tdata->offset = last_tdata_offset;
+		err = -ENOMEM;
+		goto ret_err;
 	}
 
-	skb_reserve(tdata->skb, cdev->skb_tx_rsvd);
+	skb_reserve(tdata->skb, local_iso_info + cdev->skb_tx_rsvd +
+		    iso_tx_rsvd);
 
 	if (task->sc) {
 		task->hdr = (struct iscsi_hdr *)tdata->skb->data;
@@ -1923,25 +2031,100 @@ int cxgbi_conn_alloc_pdu(struct iscsi_task *task, u8 opcode)
 		if (!task->hdr) {
 			__kfree_skb(tdata->skb);
 			tdata->skb = NULL;
-			ndev->stats.tx_dropped++;
 			return -ENOMEM;
 		}
 	}
-	task->hdr_max = SKB_TX_ISCSI_PDU_HEADER_MAX; /* BHS + AHS */
+
+	task->hdr_max = SKB_TX_ISCSI_PDU_HEADER_MAX;
+
+	if (iso_tx_rsvd)
+		cxgbi_skcb_set_flag(tdata->skb, SKCBF_TX_ISO);
 
 	/* data_out uses scsi_cmd's itt */
-	if (opcode != ISCSI_OP_SCSI_DATA_OUT)
+	if (op != ISCSI_OP_SCSI_DATA_OUT)
 		task_reserve_itt(task, &task->hdr->itt);
 
 	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
-		"task 0x%p, op 0x%x, skb 0x%p,%u+%u/%u, itt 0x%x.\n",
-		task, opcode, tdata->skb, cdev->skb_tx_rsvd, headroom,
-		conn->max_xmit_dlength, ntohl(task->hdr->itt));
+		  "task 0x%p, op 0x%x, skb 0x%p,%u+%u/%u, itt 0x%x.\n",
+		  task, op, tdata->skb, cdev->skb_tx_rsvd, headroom,
+		  conn->max_xmit_dlength, be32_to_cpu(task->hdr->itt));
 
 	return 0;
+
+ret_err:
+	conn->max_xmit_dlength = tdata->max_xmit_dlength;
+	return err;
 }
 EXPORT_SYMBOL_GPL(cxgbi_conn_alloc_pdu);
 
+static int
+cxgbi_prep_iso_info(struct iscsi_task *task, struct sk_buff *skb,
+		    u32 count)
+{
+	struct cxgbi_iso_info *iso_info = (struct cxgbi_iso_info *)skb->head;
+	struct iscsi_r2t_info *r2t;
+	struct cxgbi_task_data *tdata = iscsi_task_cxgbi_data(task);
+	struct iscsi_conn *conn = task->conn;
+	struct iscsi_session *session = conn->session;
+	struct iscsi_tcp_task *tcp_task = task->dd_data;
+	u32 burst_size = 0, r2t_dlength = 0, dlength;
+	u32 max_pdu_len = tdata->max_xmit_dlength;
+	u32 segment_offset = 0;
+	u32 num_pdu;
+
+	if (unlikely(!cxgbi_skcb_test_flag(skb, SKCBF_TX_ISO)))
+		return 0;
+
+	memset(iso_info, 0, sizeof(struct cxgbi_iso_info));
+
+	if (task->hdr->opcode == ISCSI_OP_SCSI_CMD && session->imm_data_en) {
+		iso_info->flags |= CXGBI_ISO_INFO_IMM_ENABLE;
+		burst_size = count;
+	}
+
+	dlength = ntoh24(task->hdr->dlength);
+	dlength = min(dlength, max_pdu_len);
+	hton24(task->hdr->dlength, dlength);
+
+	num_pdu = (count + max_pdu_len - 1) / max_pdu_len;
+
+	if (iscsi_task_has_unsol_data(task))
+		r2t = &task->unsol_r2t;
+	else
+		r2t = tcp_task->r2t;
+
+	if (r2t) {
+		log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
+			  "count %u, tdata->count %u, num_pdu %u,"
+			  "task->hdr_len %u, r2t->data_length %u, r2t->sent %u\n",
+			  count, tdata->count, num_pdu, task->hdr_len,
+			  r2t->data_length, r2t->sent);
+
+		r2t_dlength = r2t->data_length - r2t->sent;
+		segment_offset = r2t->sent;
+		r2t->datasn += num_pdu - 1;
+	}
+
+	if (!r2t || !r2t->sent)
+		iso_info->flags |= CXGBI_ISO_INFO_FSLICE;
+
+	if (task->hdr->flags & ISCSI_FLAG_CMD_FINAL)
+		iso_info->flags |= CXGBI_ISO_INFO_LSLICE;
+
+	task->hdr->flags &= ~ISCSI_FLAG_CMD_FINAL;
+
+	iso_info->op = task->hdr->opcode;
+	iso_info->ahs = task->hdr->hlength;
+	iso_info->num_pdu = num_pdu;
+	iso_info->mpdu = max_pdu_len;
+	iso_info->burst_size = (burst_size + r2t_dlength) >> 2;
+	iso_info->len = count + task->hdr_len;
+	iso_info->segment_offset = segment_offset;
+
+	cxgbi_skcb_tx_iscsi_hdrlen(skb) = task->hdr_len;
+	return 0;
+}
+
 static inline void tx_skb_setmode(struct sk_buff *skb, int hcrc, int dcrc)
 {
 	if (hcrc || dcrc) {
@@ -1951,133 +2134,259 @@ static inline void tx_skb_setmode(struct sk_buff *skb, int hcrc, int dcrc)
 			submode |= 1;
 		if (dcrc)
 			submode |= 2;
-		cxgbi_skcb_ulp_mode(skb) = (ULP2_MODE_ISCSI << 4) | submode;
+		cxgbi_skcb_tx_ulp_mode(skb) = (ULP2_MODE_ISCSI << 4) | submode;
 	} else
-		cxgbi_skcb_ulp_mode(skb) = 0;
+		cxgbi_skcb_tx_ulp_mode(skb) = 0;
 }
 
+static struct page *rsvd_page;
+
 int cxgbi_conn_init_pdu(struct iscsi_task *task, unsigned int offset,
 			      unsigned int count)
 {
 	struct iscsi_conn *conn = task->conn;
+	struct iscsi_tcp_task *tcp_task = task->dd_data;
 	struct cxgbi_task_data *tdata = iscsi_task_cxgbi_data(task);
 	struct sk_buff *skb = tdata->skb;
-	unsigned int datalen = count;
-	int i, padlen = iscsi_padding(count);
+	struct scsi_cmnd *sc = task->sc;
+	u32 expected_count, expected_offset;
+	u32 datalen = count, dlimit = 0;
+	u32 i, padlen = iscsi_padding(count);
 	struct page *pg;
+	int err;
+
+	if (!tcp_task || !tdata || tcp_task->dd_data != tdata) {
+		pr_err("task 0x%p,0x%p, tcp_task 0x%p, tdata 0x%p/0x%p.\n",
+		       task, task->sc, tcp_task,
+		       tcp_task ? tcp_task->dd_data : NULL, tdata);
+		return -EINVAL;
+	}
 
 	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
-		"task 0x%p,0x%p, skb 0x%p, 0x%x,0x%x,0x%x, %u+%u.\n",
-		task, task->sc, skb, (*skb->data) & ISCSI_OPCODE_MASK,
-		ntohl(task->cmdsn), ntohl(task->hdr->itt), offset, count);
+		  "task 0x%p,0x%p, skb 0x%p, 0x%x,0x%x,0x%x, %u+%u.\n",
+		  task, task->sc, skb, (*skb->data) & ISCSI_OPCODE_MASK,
+		  be32_to_cpu(task->cmdsn), be32_to_cpu(task->hdr->itt), offset, count);
 
 	skb_put(skb, task->hdr_len);
 	tx_skb_setmode(skb, conn->hdrdgst_en, datalen ? conn->datadgst_en : 0);
-	if (!count)
+	if (!count) {
+		tdata->count = count;
+		tdata->offset = offset;
+		tdata->nr_frags = 0;
+		tdata->total_offset = 0;
+		tdata->total_count = 0;
+		if (tdata->max_xmit_dlength)
+			conn->max_xmit_dlength = tdata->max_xmit_dlength;
+		cxgbi_skcb_clear_flag(skb, SKCBF_TX_ISO);
 		return 0;
+	}
 
-	if (task->sc) {
-		struct scsi_data_buffer *sdb = &task->sc->sdb;
-		struct scatterlist *sg = NULL;
-		int err;
+	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
+		  "cxgbi_conn_init_pdu: tdata->total_count %u, "
+		  "tdata->total_offset %u\n",
+		  tdata->total_count, tdata->total_offset);
 
-		tdata->offset = offset;
-		tdata->count = count;
-		err = sgl_seek_offset(
-					sdb->table.sgl, sdb->table.nents,
-					tdata->offset, &tdata->sgoffset, &sg);
-		if (err < 0) {
-			pr_warn("tpdu, sgl %u, bad offset %u/%u.\n",
-				sdb->table.nents, tdata->offset, sdb->length);
-			return err;
-		}
-		err = sgl_read_to_frags(sg, tdata->sgoffset, tdata->count,
-					tdata->frags, MAX_PDU_FRAGS);
+	expected_count = tdata->total_count;
+	expected_offset = tdata->total_offset;
+
+	if ((count != expected_count) ||
+	    (offset != expected_offset)) {
+		err = cxgbi_task_data_sgl_read(task, offset, count, &dlimit);
 		if (err < 0) {
-			pr_warn("tpdu, sgl %u, bad offset %u + %u.\n",
-				sdb->table.nents, tdata->offset, tdata->count);
+			pr_err("task 0x%p,0x%p, tcp_task 0x%p, tdata 0x%p/0x%p "
+			       "dlimit %u, sgl err %d.\n", task, task->sc,
+			       tcp_task, tcp_task ? tcp_task->dd_data : NULL,
+			       tdata, dlimit, err);
 			return err;
 		}
-		tdata->nr_frags = err;
+	}
+
+	/* Restore original value of conn->max_xmit_dlength because
+	 * it can get updated to ISO data size.
+	 */
+	conn->max_xmit_dlength = tdata->max_xmit_dlength;
+
+	if (sc) {
+		struct page_frag *frag = tdata->frags;
 
-		if (tdata->nr_frags > MAX_SKB_FRAGS ||
-		    (padlen && tdata->nr_frags == MAX_SKB_FRAGS)) {
+		if ((tdata->flags & CXGBI_TASK_SGL_COPY) ||
+		    (tdata->nr_frags > MAX_SKB_FRAGS) ||
+		    (padlen && (tdata->nr_frags ==
+					MAX_SKB_FRAGS))) {
 			char *dst = skb->data + task->hdr_len;
-			struct page_frag *frag = tdata->frags;
 
 			/* data fits in the skb's headroom */
 			for (i = 0; i < tdata->nr_frags; i++, frag++) {
 				char *src = kmap_atomic(frag->page);
 
-				memcpy(dst, src+frag->offset, frag->size);
+				memcpy(dst, src + frag->offset, frag->size);
 				dst += frag->size;
 				kunmap_atomic(src);
 			}
+
 			if (padlen) {
 				memset(dst, 0, padlen);
 				padlen = 0;
 			}
 			skb_put(skb, count + padlen);
 		} else {
-			/* data fit into frag_list */
-			for (i = 0; i < tdata->nr_frags; i++) {
-				__skb_fill_page_desc(skb, i,
-						tdata->frags[i].page,
-						tdata->frags[i].offset,
-						tdata->frags[i].size);
-				skb_frag_ref(skb, i);
+			for (i = 0; i < tdata->nr_frags; i++, frag++) {
+				get_page(frag->page);
+				skb_fill_page_desc(skb, i, frag->page,
+						   frag->offset, frag->size);
 			}
-			skb_shinfo(skb)->nr_frags = tdata->nr_frags;
+
 			skb->len += count;
 			skb->data_len += count;
 			skb->truesize += count;
 		}
-
 	} else {
-		pg = virt_to_page(task->data);
-
+		pg = virt_to_head_page(task->data);
 		get_page(pg);
-		skb_fill_page_desc(skb, 0, pg, offset_in_page(task->data),
-					count);
+		skb_fill_page_desc(skb, 0, pg,
+				   task->data - (char *)page_address(pg),
+				   count);
 		skb->len += count;
 		skb->data_len += count;
 		skb->truesize += count;
 	}
 
 	if (padlen) {
-		i = skb_shinfo(skb)->nr_frags;
+		get_page(rsvd_page);
 		skb_fill_page_desc(skb, skb_shinfo(skb)->nr_frags,
-				virt_to_page(padding), offset_in_page(padding),
-				padlen);
+				   rsvd_page, 0, padlen);
 
 		skb->data_len += padlen;
 		skb->truesize += padlen;
 		skb->len += padlen;
 	}
 
+	if (likely(count > tdata->max_xmit_dlength))
+		cxgbi_prep_iso_info(task, skb, count);
+	else
+		cxgbi_skcb_clear_flag(skb, SKCBF_TX_ISO);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cxgbi_conn_init_pdu);
 
+static int cxgbi_sock_tx_queue_up(struct cxgbi_sock *csk, struct sk_buff *skb)
+{
+	struct cxgbi_device *cdev = csk->cdev;
+	struct cxgbi_iso_info *iso_cpl;
+	u32 frags = skb_shinfo(skb)->nr_frags;
+	u32 extra_len, num_pdu, hdr_len;
+	u32 iso_tx_rsvd = 0;
+
+	if (csk->state != CTP_ESTABLISHED) {
+		log_debug(1 << CXGBI_DBG_PDU_TX,
+			  "csk 0x%p,%u,0x%lx,%u, EAGAIN.\n",
+			  csk, csk->state, csk->flags, csk->tid);
+		return -EPIPE;
+	}
+
+	if (csk->err) {
+		log_debug(1 << CXGBI_DBG_PDU_TX,
+			  "csk 0x%p,%u,0x%lx,%u, EPIPE %d.\n",
+			  csk, csk->state, csk->flags, csk->tid, csk->err);
+		return -EPIPE;
+	}
+
+	if ((cdev->flags & CXGBI_FLAG_DEV_T3) &&
+	    before((csk->snd_win + csk->snd_una), csk->write_seq)) {
+		log_debug(1 << CXGBI_DBG_PDU_TX,
+			  "csk 0x%p,%u,0x%lx,%u, FULL %u-%u >= %u.\n",
+			  csk, csk->state, csk->flags, csk->tid, csk->write_seq,
+			  csk->snd_una, csk->snd_win);
+		return -ENOBUFS;
+	}
+
+	if (cxgbi_skcb_test_flag(skb, SKCBF_TX_ISO))
+		iso_tx_rsvd = cdev->skb_iso_txhdr;
+
+	if (unlikely(skb_headroom(skb) < (cdev->skb_tx_rsvd + iso_tx_rsvd))) {
+		pr_err("csk 0x%p, skb head %u < %u.\n",
+		       csk, skb_headroom(skb), cdev->skb_tx_rsvd);
+		return -EINVAL;
+	}
+
+	if (skb->len != skb->data_len)
+		frags++;
+
+	if (frags >= SKB_WR_LIST_SIZE) {
+		pr_err("csk 0x%p, frags %u, %u,%u >%lu.\n",
+		       csk, skb_shinfo(skb)->nr_frags, skb->len,
+		       skb->data_len, SKB_WR_LIST_SIZE);
+		return -EINVAL;
+	}
+
+	cxgbi_skcb_set_flag(skb, SKCBF_TX_NEED_HDR);
+	skb_reset_transport_header(skb);
+	cxgbi_sock_skb_entail(csk, skb);
+
+	extra_len = cxgbi_ulp_extra_len(cxgbi_skcb_tx_ulp_mode(skb));
+
+	if (likely(cxgbi_skcb_test_flag(skb, SKCBF_TX_ISO))) {
+		iso_cpl = (struct cxgbi_iso_info *)skb->head;
+		num_pdu = iso_cpl->num_pdu;
+		hdr_len = cxgbi_skcb_tx_iscsi_hdrlen(skb);
+		extra_len = (cxgbi_ulp_extra_len(cxgbi_skcb_tx_ulp_mode(skb)) *
+			     num_pdu) +	(hdr_len * (num_pdu - 1));
+	}
+
+	csk->write_seq += (skb->len + extra_len);
+
+	return 0;
+}
+
+static int cxgbi_sock_send_skb(struct cxgbi_sock *csk, struct sk_buff *skb)
+{
+	struct cxgbi_device *cdev = csk->cdev;
+	int len = skb->len;
+	int err;
+
+	spin_lock_bh(&csk->lock);
+	err = cxgbi_sock_tx_queue_up(csk, skb);
+	if (err < 0) {
+		spin_unlock_bh(&csk->lock);
+		return err;
+	}
+
+	if (likely(skb_queue_len(&csk->write_queue)))
+		cdev->csk_push_tx_frames(csk, 0);
+	spin_unlock_bh(&csk->lock);
+	return len;
+}
+
 int cxgbi_conn_xmit_pdu(struct iscsi_task *task)
 {
 	struct iscsi_tcp_conn *tcp_conn = task->conn->dd_data;
 	struct cxgbi_conn *cconn = tcp_conn->dd_data;
+	struct iscsi_tcp_task *tcp_task = task->dd_data;
 	struct cxgbi_task_data *tdata = iscsi_task_cxgbi_data(task);
 	struct cxgbi_task_tag_info *ttinfo = &tdata->ttinfo;
 	struct sk_buff *skb = tdata->skb;
 	struct cxgbi_sock *csk = NULL;
-	unsigned int datalen;
+	u32 pdulen = 0;
+	u32 datalen;
 	int err;
 
+	if (!tcp_task || !tdata || (tcp_task->dd_data != tdata)) {
+		pr_err("task 0x%p,0x%p, tcp_task 0x%p, tdata 0x%p/0x%p.\n",
+		       task, task->sc, tcp_task,
+		       tcp_task ? tcp_task->dd_data : NULL, tdata);
+		return -EINVAL;
+	}
+
 	if (!skb) {
 		log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
-			"task 0x%p\n", task);
+			  "task 0x%p, skb NULL.\n", task);
 		return 0;
 	}
 
 	if (cconn && cconn->cep)
 		csk = cconn->cep->csk;
+
 	if (!csk) {
 		log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
 			  "task 0x%p, csk gone.\n", task);
@@ -2101,13 +2410,12 @@ int cxgbi_conn_xmit_pdu(struct iscsi_task *task)
 	if (!task->sc)
 		memcpy(skb->data, task->hdr, SKB_TX_ISCSI_PDU_HEADER_MAX);
 
-	err = cxgbi_sock_send_pdus(cconn->cep->csk, skb);
+	err = cxgbi_sock_send_skb(csk, skb);
 	if (err > 0) {
-		int pdulen = err;
+		pdulen += err;
 
-		log_debug(1 << CXGBI_DBG_PDU_TX,
-			"task 0x%p,0x%p, skb 0x%p, len %u/%u, rv %d.\n",
-			task, task->sc, skb, skb->len, skb->data_len, err);
+		log_debug(1 << CXGBI_DBG_PDU_TX, "task 0x%p,0x%p, rv %d.\n",
+			  task, task->sc, err);
 
 		if (task->conn->hdrdgst_en)
 			pdulen += ISCSI_DIGEST_SIZE;
@@ -2116,24 +2424,42 @@ int cxgbi_conn_xmit_pdu(struct iscsi_task *task)
 			pdulen += ISCSI_DIGEST_SIZE;
 
 		task->conn->txdata_octets += pdulen;
+
+		if (unlikely(cxgbi_is_iso_config(csk) && cxgbi_is_iso_disabled(csk))) {
+			if (time_after(jiffies, csk->prev_iso_ts + HZ)) {
+				csk->disable_iso = false;
+				csk->prev_iso_ts = 0;
+				log_debug(1 << CXGBI_DBG_PDU_TX,
+					  "enable iso: csk 0x%p\n", csk);
+			}
+		}
+
 		return 0;
 	}
 
 	if (err == -EAGAIN || err == -ENOBUFS) {
 		log_debug(1 << CXGBI_DBG_PDU_TX,
-			"task 0x%p, skb 0x%p, len %u/%u, %d EAGAIN.\n",
-			task, skb, skb->len, skb->data_len, err);
+			  "task 0x%p, skb 0x%p, len %u/%u, %d EAGAIN.\n",
+			  task, skb, skb->len, skb->data_len, err);
 		/* reset skb to send when we are called again */
 		tdata->skb = skb;
+
+		if (cxgbi_is_iso_config(csk) && !cxgbi_is_iso_disabled(csk) &&
+		    (csk->no_tx_credits++ >= 2)) {
+			csk->disable_iso = true;
+			csk->prev_iso_ts = jiffies;
+			log_debug(1 << CXGBI_DBG_PDU_TX,
+				  "disable iso:csk 0x%p, ts:%lu\n",
+				  csk, csk->prev_iso_ts);
+		}
+
 		return err;
 	}
 
-	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
-		"itt 0x%x, skb 0x%p, len %u/%u, xmit err %d.\n",
-		task->itt, skb, skb->len, skb->data_len, err);
-
 	__kfree_skb(skb);
-
+	log_debug(1 << CXGBI_DBG_ISCSI | 1 << CXGBI_DBG_PDU_TX,
+		  "itt 0x%x, skb 0x%p, len %u/%u, xmit err %d.\n",
+		  task->itt, skb, skb->len, skb->data_len, err);
 	iscsi_conn_printk(KERN_ERR, task->conn, "xmit err %d.\n", err);
 	iscsi_conn_failure(task->conn, ISCSI_ERR_XMIT_FAILED);
 	return err;
@@ -2749,12 +3075,17 @@ static int __init libcxgbi_init_module(void)
 
 	BUILD_BUG_ON(sizeof_field(struct sk_buff, cb) <
 		     sizeof(struct cxgbi_skb_cb));
+	rsvd_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!rsvd_page)
+		return -ENOMEM;
+
 	return 0;
 }
 
 static void __exit libcxgbi_exit_module(void)
 {
 	cxgbi_device_unregister_all(0xFF);
+	put_page(rsvd_page);
 	return;
 }
 
diff --git a/drivers/scsi/cxgbi/libcxgbi.h b/drivers/scsi/cxgbi/libcxgbi.h
index 84b96af..fc7255f 100644
--- a/drivers/scsi/cxgbi/libcxgbi.h
+++ b/drivers/scsi/cxgbi/libcxgbi.h
@@ -76,6 +76,14 @@ do {									\
 #define ULP2_MAX_PDU_PAYLOAD	\
 	(ULP2_MAX_PKT_SIZE - ISCSI_PDU_NONPAYLOAD_LEN)
 
+#define CXGBI_ULP2_MAX_ISO_PAYLOAD	65535
+
+#define CXGBI_MAX_ISO_DATA_IN_SKB	\
+	min_t(u32, MAX_SKB_FRAGS << PAGE_SHIFT, CXGBI_ULP2_MAX_ISO_PAYLOAD)
+
+#define cxgbi_is_iso_config(csk)	((csk)->cdev->skb_iso_txhdr)
+#define cxgbi_is_iso_disabled(csk)	((csk)->disable_iso)
+
 /*
  * For iscsi connections HW may inserts digest bytes into the pdu. Those digest
  * bytes are not sent by the host but are part of the TCP payload and therefore
@@ -162,6 +170,10 @@ struct cxgbi_sock {
 	u32 write_seq;
 	u32 snd_win;
 	u32 rcv_win;
+
+	bool disable_iso;
+	u32 no_tx_credits;
+	unsigned long prev_iso_ts;
 };
 
 /*
@@ -203,6 +215,8 @@ struct cxgbi_skb_tx_cb {
 	void *handle;
 	void *arp_err_handler;
 	struct sk_buff *wr_next;
+	u16 iscsi_hdr_len;
+	u8 ulp_mode;
 };
 
 enum cxgbi_skcb_flags {
@@ -218,6 +232,7 @@ enum cxgbi_skcb_flags {
 	SKCBF_RX_HCRC_ERR,	/* header digest error */
 	SKCBF_RX_DCRC_ERR,	/* data digest error */
 	SKCBF_RX_PAD_ERR,	/* padding byte error */
+	SKCBF_TX_ISO,		/* iso cpl in tx skb */
 };
 
 struct cxgbi_skb_cb {
@@ -225,18 +240,18 @@ struct cxgbi_skb_cb {
 		struct cxgbi_skb_rx_cb rx;
 		struct cxgbi_skb_tx_cb tx;
 	};
-	unsigned char ulp_mode;
 	unsigned long flags;
 	unsigned int seq;
 };
 
 #define CXGBI_SKB_CB(skb)	((struct cxgbi_skb_cb *)&((skb)->cb[0]))
 #define cxgbi_skcb_flags(skb)		(CXGBI_SKB_CB(skb)->flags)
-#define cxgbi_skcb_ulp_mode(skb)	(CXGBI_SKB_CB(skb)->ulp_mode)
 #define cxgbi_skcb_tcp_seq(skb)		(CXGBI_SKB_CB(skb)->seq)
 #define cxgbi_skcb_rx_ddigest(skb)	(CXGBI_SKB_CB(skb)->rx.ddigest)
 #define cxgbi_skcb_rx_pdulen(skb)	(CXGBI_SKB_CB(skb)->rx.pdulen)
 #define cxgbi_skcb_tx_wr_next(skb)	(CXGBI_SKB_CB(skb)->tx.wr_next)
+#define cxgbi_skcb_tx_iscsi_hdrlen(skb)	(CXGBI_SKB_CB(skb)->tx.iscsi_hdr_len)
+#define cxgbi_skcb_tx_ulp_mode(skb)	(CXGBI_SKB_CB(skb)->tx.ulp_mode)
 
 static inline void cxgbi_skcb_set_flag(struct sk_buff *skb,
 					enum cxgbi_skcb_flags flag)
@@ -458,6 +473,7 @@ struct cxgbi_ports_map {
 #define CXGBI_FLAG_IPV4_SET		0x10
 #define CXGBI_FLAG_USE_PPOD_OFLDQ       0x40
 #define CXGBI_FLAG_DDP_OFF		0x100
+#define CXGBI_FLAG_DEV_ISO_OFF		0x400
 
 struct cxgbi_device {
 	struct list_head list_head;
@@ -477,6 +493,7 @@ struct cxgbi_device {
 	unsigned int pfvf;
 	unsigned int rx_credit_thres;
 	unsigned int skb_tx_rsvd;
+	u32 skb_iso_txhdr;
 	unsigned int skb_rx_extra;	/* for msg coalesced mode */
 	unsigned int tx_max_size;
 	unsigned int rx_max_size;
@@ -523,20 +540,41 @@ struct cxgbi_endpoint {
 	struct cxgbi_sock *csk;
 };
 
-#define MAX_PDU_FRAGS	((ULP2_MAX_PDU_PAYLOAD + 512 - 1) / 512)
 struct cxgbi_task_data {
+#define CXGBI_TASK_SGL_CHECKED	0x1
+#define CXGBI_TASK_SGL_COPY	0x2
+	u8 flags;
 	unsigned short nr_frags;
-	struct page_frag frags[MAX_PDU_FRAGS];
+	struct page_frag frags[MAX_SKB_FRAGS];
 	struct sk_buff *skb;
 	unsigned int dlen;
 	unsigned int offset;
 	unsigned int count;
 	unsigned int sgoffset;
+	u32 total_count;
+	u32 total_offset;
+	u32 max_xmit_dlength;
 	struct cxgbi_task_tag_info ttinfo;
 };
 #define iscsi_task_cxgbi_data(task) \
 	((task)->dd_data + sizeof(struct iscsi_tcp_task))
 
+struct cxgbi_iso_info {
+#define CXGBI_ISO_INFO_FSLICE		0x1
+#define CXGBI_ISO_INFO_LSLICE		0x2
+#define CXGBI_ISO_INFO_IMM_ENABLE	0x4
+	u8 flags;
+	u8 op;
+	u8 ahs;
+	u8 num_pdu;
+	u32 mpdu;
+	u32 burst_size;
+	u32 len;
+	u32 segment_offset;
+	u32 datasn_offset;
+	u32 buffer_offset;
+};
+
 static inline void *cxgbi_alloc_big_mem(unsigned int size,
 					gfp_t gfp)
 {
-- 
2.0.2

