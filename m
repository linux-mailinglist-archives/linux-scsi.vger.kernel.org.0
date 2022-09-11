Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530045B5183
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Sep 2022 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIKWPq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 11 Sep 2022 18:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiIKWP1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 11 Sep 2022 18:15:27 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B964014021
        for <linux-scsi@vger.kernel.org>; Sun, 11 Sep 2022 15:15:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d15so4889228qka.9
        for <linux-scsi@vger.kernel.org>; Sun, 11 Sep 2022 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yQ7lPIKhFAS1YviAvz0yNJiWIXbkhXZT7R9TxxX4np0=;
        b=IT5//ng9FXoQ062FI6ZIHoOh5qmU2fw1N+q+pSi4n8yUn6TbuKKlVPvKAE+bvGvO7O
         p3kSV3ju3iP3IOHlBoe/4CIDqH0PbpTYmUSKi2Cn1F4H0dTXymTB1OMXnjN2Qbn9S683
         pssiJWK7fBzSEBLhwsrFz1bEmnBUtxSkbk4lcgFCD1gtxdQlOUKb+/zUYd7Xn4zBUfl6
         DgIiEjauwxQIO7XDASp+Oze5x7cczD92z/Sof32Ye13sX9v0yJ/81Y4zI3j7P2ezUuqj
         pORDca3RRnO/8Zps5aP2SvKHAftjvjWMaXz5K3dtAxc/k+s+PiQjLqvHvriOe9k05zfC
         sBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yQ7lPIKhFAS1YviAvz0yNJiWIXbkhXZT7R9TxxX4np0=;
        b=yfIarJE0Z4j2I38Mjk9nJrYxMICaLcvjrZ3Y2uygS2SL3snxBBtlCsBg1hhE+KVu4m
         cyb7iBtuT89jckK4logqC7AL3b5DGm8xFeILQJg71NVZ1jsVMIhREr9ujGAvTVUS69tF
         aP8/A6iaKeX7wAhVUNKTz7Nk3KVN03x9u54LkU8c7DV/bmmgbeXZgVmEuiZqJ0n/V4fz
         LZdU7Xn49bkcC6v8V3poD3tTHXysYBd4Kg+rxGR6ZafSToNh7pAkKzUi93n6qPuLR1TO
         xh4heALKqGWnESILf16Icnh8rwVmshUh4eNd+mAQBr6tEwAetGXjePLu0azxuAF41He0
         yo0g==
X-Gm-Message-State: ACgBeo3UaDwA5zvCRPoriMqGQMp+dIOPphDkrMx90dA7C7xtSuzwfKdA
        rEbV9NA9kpY78miTLwdkOK42FEa8oKs=
X-Google-Smtp-Source: AA6agR6eoMpyQ33G8vVR9IpQWBhkBCqjjmtEGr37BpTnjseOCHN374tB0pX8vu1EJPXTN996XtucAg==
X-Received: by 2002:a05:620a:b8a:b0:6ce:1589:7de8 with SMTP id k10-20020a05620a0b8a00b006ce15897de8mr4009655qkh.444.1662934520565;
        Sun, 11 Sep 2022 15:15:20 -0700 (PDT)
Received: from localhost.localdomain (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id x8-20020a05622a000800b0035a70d82d7bsm5324305qtw.47.2022.09.11.15.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 15:15:20 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 11/13] lpfc: Add reporting capability for Link Degrade Signaling
Date:   Sun, 11 Sep 2022 15:15:03 -0700
Message-Id: <20220911221505.117655-12-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220911221505.117655-1-jsmart2021@gmail.com>
References: <20220911221505.117655-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Firmware reports link degrade signaling via ACQES.

Handlers and new additions to the SET_FEATURES mbox command are
implemented so that link degrade parameters for 64GB capable links
are reported through EDC ELS frames.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h         |   6 ++
 drivers/scsi/lpfc/lpfc_crtn.h    |   1 +
 drivers/scsi/lpfc/lpfc_els.c     | 154 ++++++++++++++++++++++---------
 drivers/scsi/lpfc/lpfc_hbadisc.c |  10 +-
 drivers/scsi/lpfc/lpfc_hw4.h     |  30 +++---
 drivers/scsi/lpfc/lpfc_init.c    |  26 +++++-
 drivers/scsi/lpfc/lpfc_logmsg.h  |   2 +-
 drivers/scsi/lpfc/lpfc_sli.c     |  63 ++++++++++++-
 8 files changed, 224 insertions(+), 68 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 68b3bd70dd52..9ad233b40a9e 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -403,6 +403,7 @@ struct lpfc_trunk_link  {
 				     link1,
 				     link2,
 				     link3;
+	u32 phy_lnk_speed;
 };
 
 /* Format of congestion module parameters */
@@ -1596,6 +1597,11 @@ struct lpfc_hba {
 
 	char os_host_name[MAXHOSTNAMELEN];
 
+	/* LD Signaling */
+	u32 degrade_activate_threshold;
+	u32 degrade_deactivate_threshold;
+	u32 fec_degrade_interval;
+
 	atomic_t dbg_log_idx;
 	atomic_t dbg_log_cnt;
 	atomic_t dbg_log_dmping;
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 84880b567dbb..d2d207791056 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -78,6 +78,7 @@ int lpfc_init_iocb_list(struct lpfc_hba *phba, int cnt);
 void lpfc_free_iocb_list(struct lpfc_hba *phba);
 int lpfc_post_rq_buffer(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 			struct lpfc_queue *drq, int count, int idx);
+int lpfc_read_lds_params(struct lpfc_hba *phba);
 uint32_t lpfc_calc_cmf_latency(struct lpfc_hba *phba);
 void lpfc_cmf_signal_init(struct lpfc_hba *phba);
 void lpfc_cmf_start(struct lpfc_hba *phba);
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 642d90af4f09..863b2125fed6 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -3988,7 +3988,8 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto out;
 
 	/* ELS cmd tag <ulpIoTag> completes */
-	lpfc_printf_log(phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+	lpfc_printf_log(phba, KERN_INFO,
+			LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
 			"4676 Fabric EDC Rsp: "
 			"0x%02x, 0x%08x\n",
 			edc_rsp->acc_hdr.la_cmd,
@@ -4025,18 +4026,18 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
 			    FC_TLV_DESC_SZ_FROM_LENGTH(tlv) !=
 					sizeof(struct fc_diag_lnkflt_desc)) {
-				lpfc_printf_log(
-					phba, KERN_WARNING, LOG_CGN_MGMT,
+				lpfc_printf_log(phba, KERN_WARNING,
+					LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
 					"6462 Truncated Link Fault Diagnostic "
 					"descriptor[%d]: %d vs 0x%zx 0x%zx\n",
 					desc_cnt, bytes_remain,
 					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
-					sizeof(struct fc_diag_cg_sig_desc));
+					sizeof(struct fc_diag_lnkflt_desc));
 				goto out;
 			}
 			plnkflt = (struct fc_diag_lnkflt_desc *)tlv;
-			lpfc_printf_log(
-				phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+			lpfc_printf_log(phba, KERN_INFO,
+				LOG_ELS | LOG_LDS_EVENT,
 				"4617 Link Fault Desc Data: 0x%08x 0x%08x "
 				"0x%08x 0x%08x 0x%08x\n",
 				be32_to_cpu(plnkflt->desc_tag),
@@ -4116,8 +4117,26 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 }
 
 static void
-lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_diag_cg_sig_desc *cgd)
+lpfc_format_edc_lft_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 {
+	struct fc_diag_lnkflt_desc *lft = (struct fc_diag_lnkflt_desc *)tlv;
+
+	lft->desc_tag = cpu_to_be32(ELS_DTAG_LNK_FAULT_CAP);
+	lft->desc_len = cpu_to_be32(
+		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_diag_lnkflt_desc));
+
+	lft->degrade_activate_threshold =
+		cpu_to_be32(phba->degrade_activate_threshold);
+	lft->degrade_deactivate_threshold =
+		cpu_to_be32(phba->degrade_deactivate_threshold);
+	lft->fec_degrade_interval = cpu_to_be32(phba->fec_degrade_interval);
+}
+
+static void
+lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+{
+	struct fc_diag_cg_sig_desc *cgd = (struct fc_diag_cg_sig_desc *)tlv;
+
 	/* We are assuming cgd was zero'ed before calling this routine */
 
 	/* Configure the congestion detection capability */
@@ -4161,6 +4180,23 @@ lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_diag_cg_sig_desc *cgd)
 		cpu_to_be16(EDC_CG_SIGFREQ_MSEC);
 }
 
+static bool
+lpfc_link_is_lds_capable(struct lpfc_hba *phba)
+{
+	if (!(phba->lmt & LMT_64Gb))
+		return false;
+	if (phba->sli_rev != LPFC_SLI_REV4)
+		return false;
+
+	if (phba->sli4_hba.conf_trunk) {
+		if (phba->trunk_link.phy_lnk_speed == LPFC_USER_LINK_SPEED_64G)
+			return true;
+	} else if (phba->fc_linkspeed == LPFC_LINK_SPEED_64GHZ) {
+		return true;
+	}
+	return false;
+}
+
  /**
   * lpfc_issue_els_edc - Exchange Diagnostic Capabilities with the fabric.
   * @vport: pointer to a host virtual N_Port data structure.
@@ -4188,12 +4224,12 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
 {
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_iocbq *elsiocb;
-	struct lpfc_els_edc_req *edc_req;
-	struct fc_diag_cg_sig_desc *cgn_desc;
+	struct fc_els_edc *edc_req;
+	struct fc_tlv_desc *tlv;
 	u16 cmdsize;
 	struct lpfc_nodelist *ndlp;
 	u8 *pcmd = NULL;
-	u32 edc_req_size, cgn_desc_size;
+	u32 cgn_desc_size, lft_desc_size;
 	int rc;
 
 	if (vport->port_type == LPFC_NPIV_PORT)
@@ -4203,13 +4239,17 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
 	if (!ndlp || ndlp->nlp_state != NLP_STE_UNMAPPED_NODE)
 		return -ENODEV;
 
-	/* If HBA doesn't support signals, drop into RDF */
-	if (!phba->cgn_init_reg_signal)
+	cgn_desc_size = (phba->cgn_init_reg_signal) ?
+				sizeof(struct fc_diag_cg_sig_desc) : 0;
+	lft_desc_size = (lpfc_link_is_lds_capable(phba)) ?
+				sizeof(struct fc_diag_lnkflt_desc) : 0;
+	cmdsize = cgn_desc_size + lft_desc_size;
+
+	/* Skip EDC if no applicable descriptors */
+	if (!cmdsize)
 		goto try_rdf;
 
-	edc_req_size = sizeof(struct fc_els_edc);
-	cgn_desc_size = sizeof(struct fc_diag_cg_sig_desc);
-	cmdsize = edc_req_size + cgn_desc_size;
+	cmdsize += sizeof(struct fc_els_edc);
 	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
 				     ndlp->nlp_DID, ELS_CMD_EDC);
 	if (!elsiocb)
@@ -4218,15 +4258,19 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
 	/* Configure the payload for the supported Diagnostics capabilities. */
 	pcmd = (u8 *)elsiocb->cmd_dmabuf->virt;
 	memset(pcmd, 0, cmdsize);
-	edc_req = (struct lpfc_els_edc_req *)pcmd;
-	edc_req->edc.desc_len = cpu_to_be32(cgn_desc_size);
-	edc_req->edc.edc_cmd = ELS_EDC;
-
-	cgn_desc = &edc_req->cgn_desc;
+	edc_req = (struct fc_els_edc *)pcmd;
+	edc_req->desc_len = cpu_to_be32(cgn_desc_size + lft_desc_size);
+	edc_req->edc_cmd = ELS_EDC;
+	tlv = edc_req->desc;
 
-	lpfc_format_edc_cgn_desc(phba, cgn_desc);
+	if (cgn_desc_size) {
+		lpfc_format_edc_cgn_desc(phba, tlv);
+		phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
+		tlv = fc_tlv_next_desc(tlv);
+	}
 
-	phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
+	if (lft_desc_size)
+		lpfc_format_edc_lft_desc(phba, tlv);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
 			 "4623 Xmit EDC to remote "
@@ -5780,14 +5824,21 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		       struct lpfc_nodelist *ndlp)
 {
 	struct lpfc_hba  *phba = vport->phba;
-	struct lpfc_els_edc_rsp *edc_rsp;
+	struct fc_els_edc_resp *edc_rsp;
+	struct fc_tlv_desc *tlv;
 	struct lpfc_iocbq *elsiocb;
 	IOCB_t *icmd, *cmd;
 	union lpfc_wqe128 *wqe;
+	u32 cgn_desc_size, lft_desc_size;
+	u16 cmdsize;
 	uint8_t *pcmd;
-	int cmdsize, rc;
+	int rc;
 
-	cmdsize = sizeof(struct lpfc_els_edc_rsp);
+	cmdsize = sizeof(struct fc_els_edc_resp);
+	cgn_desc_size = sizeof(struct fc_diag_cg_sig_desc);
+	lft_desc_size = (lpfc_link_is_lds_capable(phba)) ?
+				sizeof(struct fc_diag_lnkflt_desc) : 0;
+	cmdsize += cgn_desc_size + lft_desc_size;
 	elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize, cmdiocb->retry,
 				     ndlp, ndlp->nlp_DID, ELS_CMD_ACC);
 	if (!elsiocb)
@@ -5809,15 +5860,19 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	pcmd = elsiocb->cmd_dmabuf->virt;
 	memset(pcmd, 0, cmdsize);
 
-	edc_rsp = (struct lpfc_els_edc_rsp *)pcmd;
-	edc_rsp->edc_rsp.acc_hdr.la_cmd = ELS_LS_ACC;
-	edc_rsp->edc_rsp.desc_list_len = cpu_to_be32(
-		FC_TLV_DESC_LENGTH_FROM_SZ(struct lpfc_els_edc_rsp));
-	edc_rsp->edc_rsp.lsri.desc_tag = cpu_to_be32(ELS_DTAG_LS_REQ_INFO);
-	edc_rsp->edc_rsp.lsri.desc_len = cpu_to_be32(
+	edc_rsp = (struct fc_els_edc_resp *)pcmd;
+	edc_rsp->acc_hdr.la_cmd = ELS_LS_ACC;
+	edc_rsp->desc_list_len = cpu_to_be32(sizeof(struct fc_els_lsri_desc) +
+						cgn_desc_size + lft_desc_size);
+	edc_rsp->lsri.desc_tag = cpu_to_be32(ELS_DTAG_LS_REQ_INFO);
+	edc_rsp->lsri.desc_len = cpu_to_be32(
 		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_els_lsri_desc));
-	edc_rsp->edc_rsp.lsri.rqst_w0.cmd = ELS_EDC;
-	lpfc_format_edc_cgn_desc(phba, &edc_rsp->cgn_desc);
+	edc_rsp->lsri.rqst_w0.cmd = ELS_EDC;
+	tlv = edc_rsp->desc;
+	lpfc_format_edc_cgn_desc(phba, tlv);
+	tlv = fc_tlv_next_desc(tlv);
+	if (lft_desc_size)
+		lpfc_format_edc_lft_desc(phba, tlv);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
 			      "Issue EDC ACC:      did:x%x flg:x%x refcnt %d",
@@ -9082,7 +9137,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	uint32_t *ptr, dtag;
 	const char *dtag_nm;
 	int desc_cnt = 0, bytes_remain;
-	bool rcv_cap_desc = false;
+	struct fc_diag_lnkflt_desc *plnkflt;
 
 	payload = cmdiocb->cmd_dmabuf->virt;
 
@@ -9090,7 +9145,8 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	bytes_remain = be32_to_cpu(edc_req->desc_len);
 
 	ptr = (uint32_t *)payload;
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+	lpfc_printf_vlog(vport, KERN_INFO,
+			 LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
 			 "3319 Rcv EDC payload len %d: x%x x%x x%x\n",
 			 bytes_remain, be32_to_cpu(*ptr),
 			 be32_to_cpu(*(ptr + 1)), be32_to_cpu(*(ptr + 2)));
@@ -9109,9 +9165,10 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	 * cycle through EDC diagnostic descriptors to find the
 	 * congestion signaling capability descriptor
 	 */
-	while (bytes_remain && !rcv_cap_desc) {
+	while (bytes_remain) {
 		if (bytes_remain < FC_TLV_DESC_HDR_SZ) {
-			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+			lpfc_printf_log(phba, KERN_WARNING,
+					LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
 					"6464 Truncated TLV hdr on "
 					"Diagnostic descriptor[%d]\n",
 					desc_cnt);
@@ -9124,16 +9181,27 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
 			    FC_TLV_DESC_SZ_FROM_LENGTH(tlv) !=
 				sizeof(struct fc_diag_lnkflt_desc)) {
-				lpfc_printf_log(
-					phba, KERN_WARNING, LOG_CGN_MGMT,
+				lpfc_printf_log(phba, KERN_WARNING,
+					LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
 					"6465 Truncated Link Fault Diagnostic "
 					"descriptor[%d]: %d vs 0x%zx 0x%zx\n",
 					desc_cnt, bytes_remain,
 					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
-					sizeof(struct fc_diag_cg_sig_desc));
+					sizeof(struct fc_diag_lnkflt_desc));
 				goto out;
 			}
-			/* No action for Link Fault descriptor for now */
+			plnkflt = (struct fc_diag_lnkflt_desc *)tlv;
+			lpfc_printf_log(phba, KERN_INFO,
+				LOG_ELS | LOG_LDS_EVENT,
+				"4626 Link Fault Desc Data: x%08x len x%x "
+				"da x%x dd x%x interval x%x\n",
+				be32_to_cpu(plnkflt->desc_tag),
+				be32_to_cpu(plnkflt->desc_len),
+				be32_to_cpu(
+					plnkflt->degrade_activate_threshold),
+				be32_to_cpu(
+					plnkflt->degrade_deactivate_threshold),
+				be32_to_cpu(plnkflt->fec_degrade_interval));
 			break;
 		case ELS_DTAG_CG_SIGNAL_CAP:
 			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
@@ -9160,11 +9228,11 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 			lpfc_least_capable_settings(
 				phba, (struct fc_diag_cg_sig_desc *)tlv);
-			rcv_cap_desc = true;
 			break;
 		default:
 			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
-			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+			lpfc_printf_log(phba, KERN_WARNING,
+					LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
 					"6467 unknown Diagnostic "
 					"Descriptor[%d]: tag x%x (%s)\n",
 					desc_cnt, dtag, dtag_nm);
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 24d533c0b729..2b79351dfd11 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -1242,6 +1242,8 @@ lpfc_linkdown(struct lpfc_hba *phba)
 			phba->trunk_link.link1.state = 0;
 			phba->trunk_link.link2.state = 0;
 			phba->trunk_link.link3.state = 0;
+			phba->trunk_link.phy_lnk_speed =
+						LPFC_LINK_SPEED_UNKNOWN;
 			phba->sli4_hba.link_state.logical_speed =
 						LPFC_LINK_SPEED_UNKNOWN;
 		}
@@ -3794,6 +3796,9 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		if (phba->cmf_active_mode != LPFC_CFG_OFF)
 			lpfc_cmf_signal_init(phba);
 
+		if (phba->lmt & LMT_64Gb)
+			lpfc_read_lds_params(phba);
+
 	} else if (attn_type == LPFC_ATT_LINK_DOWN ||
 		   attn_type == LPFC_ATT_UNEXP_WWPN) {
 		phba->fc_stat.LinkDown++;
@@ -4393,8 +4398,11 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			rc = lpfc_issue_els_edc(vport, 0);
 			lpfc_printf_log(phba, KERN_INFO,
 					LOG_INIT | LOG_ELS | LOG_DISCOVERY,
-					"4220 EDC issue error x%x, Data: x%x\n",
+					"4220 Issue EDC status x%x Data x%x\n",
 					rc, phba->cgn_init_reg_signal);
+		} else if (phba->lmt & LMT_64Gb) {
+			/* may send link fault capability descriptor */
+			lpfc_issue_els_edc(vport, 0);
 		} else {
 			lpfc_issue_els_rdf(vport, 0);
 		}
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index ca49679e87b9..5288fc69908a 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -3484,9 +3484,10 @@ struct lpfc_sli4_parameters {
 
 #define LPFC_SET_UE_RECOVERY		0x10
 #define LPFC_SET_MDS_DIAGS		0x12
-#define LPFC_SET_CGN_SIGNAL		0x1f
 #define LPFC_SET_DUAL_DUMP		0x1e
+#define LPFC_SET_CGN_SIGNAL		0x1f
 #define LPFC_SET_ENABLE_MI		0x21
+#define LPFC_SET_LD_SIGNAL		0x23
 #define LPFC_SET_ENABLE_CMF		0x24
 struct lpfc_mbx_set_feature {
 	struct mbox_header header;
@@ -3517,13 +3518,17 @@ struct lpfc_mbx_set_feature {
 #define lpfc_mbx_set_feature_cmf_SHIFT		0
 #define lpfc_mbx_set_feature_cmf_MASK		0x00000001
 #define lpfc_mbx_set_feature_cmf_WORD		word6
+#define lpfc_mbx_set_feature_lds_qry_SHIFT	0
+#define lpfc_mbx_set_feature_lds_qry_MASK	0x00000001
+#define lpfc_mbx_set_feature_lds_qry_WORD	word6
+#define LPFC_QUERY_LDS_OP		1
 #define lpfc_mbx_set_feature_mi_SHIFT		0
 #define lpfc_mbx_set_feature_mi_MASK		0x0000ffff
 #define lpfc_mbx_set_feature_mi_WORD		word6
 #define lpfc_mbx_set_feature_milunq_SHIFT	16
 #define lpfc_mbx_set_feature_milunq_MASK	0x0000ffff
 #define lpfc_mbx_set_feature_milunq_WORD	word6
-	uint32_t word7;
+	u32 word7;
 #define lpfc_mbx_set_feature_UERP_SHIFT 0
 #define lpfc_mbx_set_feature_UERP_MASK  0x0000ffff
 #define lpfc_mbx_set_feature_UERP_WORD  word7
@@ -3537,6 +3542,8 @@ struct lpfc_mbx_set_feature {
 #define lpfc_mbx_set_feature_CGN_acqe_freq_SHIFT 0
 #define lpfc_mbx_set_feature_CGN_acqe_freq_MASK  0x000000ff
 #define lpfc_mbx_set_feature_CGN_acqe_freq_WORD  word8
+	u32 word9;
+	u32 word10;
 };
 
 
@@ -4314,7 +4321,7 @@ struct lpfc_acqe_cgn_signal {
 struct lpfc_acqe_sli {
 	uint32_t event_data1;
 	uint32_t event_data2;
-	uint32_t reserved;
+	uint32_t event_data3;
 	uint32_t trailer;
 #define LPFC_SLI_EVENT_TYPE_PORT_ERROR		0x1
 #define LPFC_SLI_EVENT_TYPE_OVER_TEMP		0x2
@@ -4327,6 +4334,7 @@ struct lpfc_acqe_sli {
 #define LPFC_SLI_EVENT_TYPE_MISCONF_FAWWN	0xF
 #define LPFC_SLI_EVENT_TYPE_EEPROM_FAILURE	0x10
 #define LPFC_SLI_EVENT_TYPE_CGN_SIGNAL		0x11
+#define LPFC_SLI_EVENT_TYPE_RD_SIGNAL           0x12
 };
 
 /*
@@ -5050,22 +5058,6 @@ struct lpfc_grp_hdr {
 	{ FPIN_CONGN_SEVERITY_ERROR,		"Alarm" },	\
 }
 
-/* EDC supports two descriptors.  When allocated, it is the
- * size of this structure plus each supported descriptor.
- */
-struct lpfc_els_edc_req {
-	struct fc_els_edc               edc;       /* hdr up to descriptors */
-	struct fc_diag_cg_sig_desc      cgn_desc;  /* 1st descriptor */
-};
-
-/* Minimum structure defines for the EDC response.
- * Balance is in buffer.
- */
-struct lpfc_els_edc_rsp {
-	struct fc_els_edc_resp          edc_rsp;   /* hdr up to descriptors */
-	struct fc_diag_cg_sig_desc      cgn_desc;  /* 1st descriptor */
-};
-
 /* Used for logging FPIN messages */
 #define LPFC_FPIN_WWPN_LINE_SZ  128
 #define LPFC_FPIN_WWPN_LINE_CNT 6
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index b170e9e9f167..511220aa43f5 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -6185,6 +6185,7 @@ lpfc_update_trunk_link_status(struct lpfc_hba *phba,
 {
 	uint8_t port_fault = bf_get(lpfc_acqe_fc_la_trunk_linkmask, acqe_fc);
 	uint8_t err = bf_get(lpfc_acqe_fc_la_trunk_fault, acqe_fc);
+	u8 cnt = 0;
 
 	phba->sli4_hba.link_state.speed =
 		lpfc_sli4_port_speed_parse(phba, LPFC_TRAILER_CODE_FC,
@@ -6203,26 +6204,36 @@ lpfc_update_trunk_link_status(struct lpfc_hba *phba,
 			bf_get(lpfc_acqe_fc_la_trunk_link_status_port0, acqe_fc)
 			? LPFC_LINK_UP : LPFC_LINK_DOWN;
 		phba->trunk_link.link0.fault = port_fault & 0x1 ? err : 0;
+		cnt++;
 	}
 	if (bf_get(lpfc_acqe_fc_la_trunk_config_port1, acqe_fc)) {
 		phba->trunk_link.link1.state =
 			bf_get(lpfc_acqe_fc_la_trunk_link_status_port1, acqe_fc)
 			? LPFC_LINK_UP : LPFC_LINK_DOWN;
 		phba->trunk_link.link1.fault = port_fault & 0x2 ? err : 0;
+		cnt++;
 	}
 	if (bf_get(lpfc_acqe_fc_la_trunk_config_port2, acqe_fc)) {
 		phba->trunk_link.link2.state =
 			bf_get(lpfc_acqe_fc_la_trunk_link_status_port2, acqe_fc)
 			? LPFC_LINK_UP : LPFC_LINK_DOWN;
 		phba->trunk_link.link2.fault = port_fault & 0x4 ? err : 0;
+		cnt++;
 	}
 	if (bf_get(lpfc_acqe_fc_la_trunk_config_port3, acqe_fc)) {
 		phba->trunk_link.link3.state =
 			bf_get(lpfc_acqe_fc_la_trunk_link_status_port3, acqe_fc)
 			? LPFC_LINK_UP : LPFC_LINK_DOWN;
 		phba->trunk_link.link3.fault = port_fault & 0x8 ? err : 0;
+		cnt++;
 	}
 
+	if (cnt)
+		phba->trunk_link.phy_lnk_speed =
+			phba->sli4_hba.link_state.logical_speed / (cnt * 1000);
+	else
+		phba->trunk_link.phy_lnk_speed = LPFC_LINK_SPEED_UNKNOWN;
+
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2910 Async FC Trunking Event - Speed:%d\n"
 			"\tLogical speed:%d "
@@ -6300,7 +6311,7 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 	if (bf_get(lpfc_acqe_fc_la_att_type, acqe_fc) ==
 	    LPFC_FC_LA_TYPE_LINK_DOWN)
 		phba->sli4_hba.link_state.logical_speed = 0;
-	else if	(!phba->sli4_hba.conf_trunk)
+	else if (!phba->sli4_hba.conf_trunk)
 		phba->sli4_hba.link_state.logical_speed =
 				bf_get(lpfc_acqe_fc_la_llink_spd, acqe_fc) * 10;
 
@@ -6418,7 +6429,7 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 			"2901 Async SLI event - Type:%d, Event Data: x%08x "
 			"x%08x x%08x x%08x\n", evt_type,
 			acqe_sli->event_data1, acqe_sli->event_data2,
-			acqe_sli->reserved, acqe_sli->trailer);
+			acqe_sli->event_data3, acqe_sli->trailer);
 
 	port_name = phba->Port[0];
 	if (port_name == 0x00)
@@ -6447,7 +6458,7 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 		temp_event_data.event_code = LPFC_NORMAL_TEMP;
 		temp_event_data.data = (uint32_t)acqe_sli->event_data1;
 
-		lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
+		lpfc_printf_log(phba, KERN_INFO, LOG_SLI | LOG_LDS_EVENT,
 				"3191 Normal Temperature:%d Celsius - Port Name %c\n",
 				acqe_sli->event_data1, port_name);
 
@@ -6625,6 +6636,15 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 			}
 		}
 		break;
+	case LPFC_SLI_EVENT_TYPE_RD_SIGNAL:
+		/* May be accompanied by a temperature event */
+		lpfc_printf_log(phba, KERN_INFO,
+				LOG_SLI | LOG_LINK_EVENT | LOG_LDS_EVENT,
+				"2902 Remote Degrade Signaling: x%08x x%08x "
+				"x%08x\n",
+				acqe_sli->event_data1, acqe_sli->event_data2,
+				acqe_sli->event_data3);
+		break;
 	default:
 		lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 				"3193 Unrecognized SLI event, type: 0x%x",
diff --git a/drivers/scsi/lpfc/lpfc_logmsg.h b/drivers/scsi/lpfc/lpfc_logmsg.h
index 4d455da9cd69..b39cefcd8703 100644
--- a/drivers/scsi/lpfc/lpfc_logmsg.h
+++ b/drivers/scsi/lpfc/lpfc_logmsg.h
@@ -35,7 +35,7 @@
 #define LOG_FCP_ERROR	0x00001000	/* log errors, not underruns */
 #define LOG_LIBDFC	0x00002000	/* Libdfc events */
 #define LOG_VPORT	0x00004000	/* NPIV events */
-#define LOG_SECURITY	0x00008000	/* Security events */
+#define LOG_LDS_EVENT	0x00008000	/* Link Degrade Signaling events */
 #define LOG_EVENT	0x00010000	/* CT,TEMP,DUMP, logging */
 #define LOG_FIP		0x00020000	/* FIP events */
 #define LOG_FCP_UNDER	0x00040000	/* FCP underruns errors */
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 002794975cd9..06987d4013d5 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6830,8 +6830,13 @@ lpfc_set_features(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox,
 		bf_set(lpfc_mbx_set_feature_mi, &mbox->u.mqe.un.set_feature,
 		       phba->sli4_hba.pc_sli4_params.mi_ver);
 		break;
+	case LPFC_SET_LD_SIGNAL:
+		mbox->u.mqe.un.set_feature.feature = LPFC_SET_LD_SIGNAL;
+		mbox->u.mqe.un.set_feature.param_len = 16;
+		bf_set(lpfc_mbx_set_feature_lds_qry,
+		       &mbox->u.mqe.un.set_feature, LPFC_QUERY_LDS_OP);
+		break;
 	case LPFC_SET_ENABLE_CMF:
-		bf_set(lpfc_mbx_set_feature_dd, &mbox->u.mqe.un.set_feature, 1);
 		mbox->u.mqe.un.set_feature.feature = LPFC_SET_ENABLE_CMF;
 		mbox->u.mqe.un.set_feature.param_len = 4;
 		bf_set(lpfc_mbx_set_feature_cmf,
@@ -7826,6 +7831,62 @@ lpfc_post_rq_buffer(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 	return 1;
 }
 
+static void
+lpfc_mbx_cmpl_read_lds_params(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
+{
+	union lpfc_sli4_cfg_shdr *shdr;
+	u32 shdr_status, shdr_add_status;
+
+	shdr = (union lpfc_sli4_cfg_shdr *)
+		&pmb->u.mqe.un.sli4_config.header.cfg_shdr;
+	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
+	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
+	if (shdr_status || shdr_add_status || pmb->u.mb.mbxStatus) {
+		lpfc_printf_log(phba, KERN_INFO, LOG_LDS_EVENT | LOG_MBOX,
+				"4622 SET_FEATURE (x%x) mbox failed, "
+				"status x%x add_status x%x, mbx status x%x\n",
+				LPFC_SET_LD_SIGNAL, shdr_status,
+				shdr_add_status, pmb->u.mb.mbxStatus);
+		phba->degrade_activate_threshold = 0;
+		phba->degrade_deactivate_threshold = 0;
+		phba->fec_degrade_interval = 0;
+		goto out;
+	}
+
+	phba->degrade_activate_threshold = pmb->u.mqe.un.set_feature.word7;
+	phba->degrade_deactivate_threshold = pmb->u.mqe.un.set_feature.word8;
+	phba->fec_degrade_interval = pmb->u.mqe.un.set_feature.word10;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_LDS_EVENT,
+			"4624 Success: da x%x dd x%x interval x%x\n",
+			phba->degrade_activate_threshold,
+			phba->degrade_deactivate_threshold,
+			phba->fec_degrade_interval);
+out:
+	mempool_free(pmb, phba->mbox_mem_pool);
+}
+
+int
+lpfc_read_lds_params(struct lpfc_hba *phba)
+{
+	LPFC_MBOXQ_t *mboxq;
+	int rc;
+
+	mboxq = (LPFC_MBOXQ_t *)mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
+	if (!mboxq)
+		return -ENOMEM;
+
+	lpfc_set_features(phba, mboxq, LPFC_SET_LD_SIGNAL);
+	mboxq->vport = phba->pport;
+	mboxq->mbox_cmpl = lpfc_mbx_cmpl_read_lds_params;
+	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
+	if (rc == MBX_NOT_FINISHED) {
+		mempool_free(mboxq, phba->mbox_mem_pool);
+		return -EIO;
+	}
+	return 0;
+}
+
 static void
 lpfc_mbx_cmpl_cgn_set_ftrs(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
-- 
2.35.3

