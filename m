Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E509B20FF83
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2020 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgF3Vum (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jun 2020 17:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgF3Vuj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jun 2020 17:50:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE33C061755
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2020 14:50:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so18628122wrw.1
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2020 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igB58xNP1p2Xt3Q6fzpb9ASN1onySb80+rfHRu5+TtM=;
        b=ThpY6h+bWaAavuTtIMFvddu856gx95JbNl18aeMRbr75eny+7mMMeIUf5XRus8qZgw
         +VZekd+cNAYJE61qvT67X8fU4fiYWmWiNu+D2PoaYQ81DnyvyY/ETMsE+IWATZ+j3f78
         QSQym8KcKAPAOSYyQeG0e2tChIzKYibqphpks4g1Ig4mSbM0ODLAOVYz/PabXBJKMxrr
         cCKFak+TlBuyhBVPMWJ9PM1ruC5vROUOTsWMoJu8+byRToEjikz210mZfufAG5lPuBoh
         yTnnn3GBW41xd568s/M8f7BahuXOrqEHcrpqmiYyE3X5jrThhvxv9aOl4tEVkILbOwQE
         50UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igB58xNP1p2Xt3Q6fzpb9ASN1onySb80+rfHRu5+TtM=;
        b=Fbqni7B0FcIb6H3ZubD/M2VJ8vAywJMA9J8uWZZ6nzymIaGo7Fv79pCjytjd7tS2gw
         TxAMoGTVvHBtFTU3h5utWqQeWyNIyaQEITCvFiK1vU/FgaLh9XuUBCffGmwTSNd+rfUB
         8khRf08CLlBtNWHZS/oJMdlZ8LVDNONGT4FztFvRSCwVwF/Wxr9qjekhnGp5VKmBfD2Y
         oQGGlZtARpRj7QLoOJyn6GvLyDfnB/4VQ5utpi8ys21XeyfcmuEvD/pdJNxjvIzm71rO
         mqH/2HrGPvlK3NoRBi7HCM1TzKb8/PEBk0YuKCxMAHUHGmrQivp9oSC2+k/NO6sSylW2
         XSOg==
X-Gm-Message-State: AOAM533Uj1Qx4zhh9Xm3nFn5pby9/TiAFPJ1xWzDxdLBL4t5LSY6arob
        KXboguf9BA+BeAzBVVSJ76tLQd/5
X-Google-Smtp-Source: ABdhPJysHcW+obmtNa2KtFiT0PHWxon2nde/1ymBzo0OjSixRPyXPHBi6VAMACqFdXaHctn1es2DyA==
X-Received: by 2002:adf:aa90:: with SMTP id h16mr23848168wrc.356.1593553834113;
        Tue, 30 Jun 2020 14:50:34 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f14sm5518551wro.90.2020.06.30.14.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:50:33 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 13/14] lpfc: Add an internal trace log buffer
Date:   Tue, 30 Jun 2020 14:50:00 -0700
Message-Id: <20200630215001.70793-14-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200630215001.70793-1-jsmart2021@gmail.com>
References: <20200630215001.70793-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current logging methods typically end up requesting a reproduction
with a different logging level set to figure out what happened. This was
mainly by design to not close the kernel log messages with things that
were typically no interesting and the messages themselves could cause
other issues.

When looking to make a better system, it was seen that in many cases
when more data was wanted was when another message, usually at KERN_ERR
level, was logged.  And in most cases, what the additional logging that
was then enabled was typically. Most of these areas fell into the
discovery machine.

Based on this summary, the following design has been put in place:
The driver will maintain an internal log (256 elements of 256 bytes).
The "additional logging" messages that are usually enabled in a
reproduction will be changed to now log all the time to the internal log.
A new logging level is defined - LOG_TRACE_EVENT.  When this level is set
(it is not by default) and a message marked as KERN_ERR is logged, all
the messages in the internal log will be dumped to the kernel log before
the KERN_ERR message is logged.

There is a timestamp on each message added to the internal log. However,
this timestamp is not converted to wall time when logged. The value of the
timestamp is solely to give a crude time reference for the messages.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h           |  12 +
 drivers/scsi/lpfc/lpfc_crtn.h      |   2 +-
 drivers/scsi/lpfc/lpfc_ct.c        |  16 +-
 drivers/scsi/lpfc/lpfc_els.c       | 131 +++----
 drivers/scsi/lpfc/lpfc_hbadisc.c   | 216 +++++------
 drivers/scsi/lpfc/lpfc_init.c      | 565 +++++++++++++++++------------
 drivers/scsi/lpfc/lpfc_logmsg.h    |  24 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c |  51 +--
 drivers/scsi/lpfc/lpfc_nvme.c      |  67 ++--
 drivers/scsi/lpfc/lpfc_nvmet.c     |  96 +++--
 drivers/scsi/lpfc/lpfc_scsi.c      | 125 +++----
 drivers/scsi/lpfc/lpfc_sli.c       | 355 +++++++++---------
 drivers/scsi/lpfc/lpfc_vport.c     |  60 +--
 13 files changed, 928 insertions(+), 792 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 2ddcdedfdb8c..549adfaa97ce 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -627,6 +627,14 @@ struct lpfc_ras_fwlog {
 	enum ras_state state;    /* RAS logging running state */
 };
 
+#define DBG_LOG_STR_SZ 256
+#define DBG_LOG_SZ 256
+
+struct dbg_log_ent {
+	char log[DBG_LOG_STR_SZ];
+	u64     t_ns;
+};
+
 enum lpfc_irq_chann_mode {
 	/* Assign IRQs to all possible cpus that have hardware queues */
 	NORMAL_MODE,
@@ -1240,6 +1248,10 @@ struct lpfc_hba {
 	struct scsi_host_template port_template;
 	/* SCSI host template information - for all vports */
 	struct scsi_host_template vport_template;
+	atomic_t dbg_log_idx;
+	atomic_t dbg_log_cnt;
+	atomic_t dbg_log_dmping;
+	struct dbg_log_ent dbg_log[DBG_LOG_SZ];
 };
 
 static inline struct Scsi_Host *
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index c832a7d26e86..1511300c837f 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -386,7 +386,7 @@ void lpfc_rq_buf_free(struct lpfc_hba *phba, struct lpfc_dmabuf *mp);
 int lpfc_link_reset(struct lpfc_vport *vport);
 
 /* Function prototypes. */
-int lpfc_check_pci_resettable(const struct lpfc_hba *phba);
+int lpfc_check_pci_resettable(struct lpfc_hba *phba);
 const char* lpfc_info(struct Scsi_Host *);
 int lpfc_scan_finished(struct Scsi_Host *, unsigned long);
 
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 69d4710d95a0..701f2405cf02 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -750,7 +750,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if (vport->fc_flag & FC_RSCN_MODE)
 			lpfc_els_flush_rscn(vport);
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0257 GID_FT Query error: 0x%x 0x%x\n",
 				 irsp->ulpStatus, vport->fc_ns_retry);
 	} else {
@@ -811,7 +811,7 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		} else {
 			/* NameServer Rsp Error */
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					"0241 NameServer Rsp Error "
 					"Data: x%x x%x x%x x%x\n",
 					CTrsp->CommandResponse.bits.CmdRsp,
@@ -951,7 +951,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if (vport->fc_flag & FC_RSCN_MODE)
 			lpfc_els_flush_rscn(vport);
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "4103 GID_FT Query error: 0x%x 0x%x\n",
 				 irsp->ulpStatus, vport->fc_ns_retry);
 	} else {
@@ -1012,7 +1012,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			}
 		} else {
 			/* NameServer Rsp Error */
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "4109 NameServer Rsp Error "
 					 "Data: x%x x%x x%x x%x\n",
 					 CTrsp->CommandResponse.bits.CmdRsp,
@@ -1143,7 +1143,7 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				}
 			}
 		}
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0267 NameServer GFF Rsp "
 				 "x%x Error (%d %d) Data: x%x x%x\n",
 				 did, irsp->ulpStatus, irsp->un.ulpWord[4],
@@ -1271,7 +1271,7 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			}
 		}
 	} else
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "3065 GFT_ID failed x%08x\n", irsp->ulpStatus);
 
 	lpfc_ct_free_iocb(phba, cmdiocb);
@@ -1320,7 +1320,7 @@ lpfc_cmpl_ct(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		irsp->ulpStatus, irsp->un.ulpWord[4], cmdcode);
 
 	if (irsp->ulpStatus) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0268 NS cmd x%x Error (x%x x%x)\n",
 				 cmdcode, irsp->ulpStatus, irsp->un.ulpWord[4]);
 
@@ -1843,7 +1843,7 @@ lpfc_ns_cmd(struct lpfc_vport *vport, int cmdcode,
 ns_cmd_free_mp:
 	kfree(mp);
 ns_cmd_exit:
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0266 Issue NameServer Req x%x err %d Data: x%x x%x\n",
 			 cmdcode, rc, vport->fc_flag, vport->fc_rscn_id_cnt);
 	return 1;
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index a7bbe628bc52..8b10a468ef3f 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -100,7 +100,7 @@ lpfc_els_chk_latt(struct lpfc_vport *vport)
 		return 0;
 
 	/* Pending Link Event during Discovery */
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0237 Pending Link Event during "
 			 "Discovery: State x%x\n",
 			 phba->pport->port_state);
@@ -440,8 +440,9 @@ lpfc_issue_fabric_reglogin(struct lpfc_vport *vport)
 
 fail:
 	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
-		"0249 Cannot issue Register Fabric login: Err %d\n", err);
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+			 "0249 Cannot issue Register Fabric login: Err %d\n",
+			 err);
 	return -ENXIO;
 }
 
@@ -524,8 +525,8 @@ lpfc_issue_reg_vfi(struct lpfc_vport *vport)
 	}
 
 	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
-		"0289 Issue Register VFI failed: Err %d\n", rc);
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+			 "0289 Issue Register VFI failed: Err %d\n", rc);
 	return rc;
 }
 
@@ -550,7 +551,7 @@ lpfc_issue_unreg_vfi(struct lpfc_vport *vport)
 
 	mboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY|LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2556 UNREG_VFI mbox allocation failed"
 				"HBA state x%x\n", phba->pport->port_state);
 		return -ENOMEM;
@@ -562,7 +563,7 @@ lpfc_issue_unreg_vfi(struct lpfc_vport *vport)
 
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY|LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2557 UNREG_VFI issue mbox failed rc x%x "
 				"HBA state x%x\n",
 				rc, phba->pport->port_state);
@@ -1041,18 +1042,18 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if (!(irsp->ulpStatus == IOSTAT_LOCAL_REJECT &&
 		      ((irsp->un.ulpWord[4] & IOERR_PARAM_MASK) ==
 					IOERR_LOOP_OPEN_FAILURE)))
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
-					"2858 FLOGI failure Status:x%x/x%x "
-					"TMO:x%x Data x%x x%x\n",
-					irsp->ulpStatus, irsp->un.ulpWord[4],
-					irsp->ulpTimeout, phba->hba_flag,
-					phba->fcf.fcf_flag);
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+					 "2858 FLOGI failure Status:x%x/x%x TMO"
+					 ":x%x Data x%x x%x\n",
+					 irsp->ulpStatus, irsp->un.ulpWord[4],
+					 irsp->ulpTimeout, phba->hba_flag,
+					 phba->fcf.fcf_flag);
 
 		/* Check for retry */
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb))
 			goto out;
 
-		lpfc_printf_vlog(vport, KERN_WARNING, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_WARNING, LOG_TRACE_EVENT,
 				 "0150 FLOGI failure Status:x%x/x%x "
 				 "xri x%x TMO:x%x\n",
 				 irsp->ulpStatus, irsp->un.ulpWord[4],
@@ -1132,8 +1133,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		else if (!(phba->hba_flag & HBA_FCOE_MODE))
 			rc = lpfc_cmpl_els_flogi_nport(vport, ndlp, sp);
 		else {
-			lpfc_printf_vlog(vport, KERN_ERR,
-				LOG_FIP | LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"2831 FLOGI response with cleared Fabric "
 				"bit fcf_index 0x%x "
 				"Switch Name %02x%02x%02x%02x%02x%02x%02x%02x "
@@ -1934,7 +1934,7 @@ lpfc_cmpl_els_rrq(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	ndlp = lpfc_findnode_did(vport, irsp->un.elsreq64.remoteID);
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp) || ndlp != rrq->ndlp) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2882 RRQ completes to NPort x%x "
 				 "with no ndlp. Data: x%x x%x x%x\n",
 				 irsp->un.elsreq64.remoteID,
@@ -1957,10 +1957,11 @@ lpfc_cmpl_els_rrq(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			(((irsp->un.ulpWord[4]) >> 16 != LSRJT_INVALID_CMD) &&
 			((irsp->un.ulpWord[4]) >> 16 != LSRJT_UNABLE_TPC)) ||
 			(phba)->pport->cfg_log_verbose & LOG_ELS)
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
-				 "2881 RRQ failure DID:%06X Status:x%x/x%x\n",
-				 ndlp->nlp_DID, irsp->ulpStatus,
-				 irsp->un.ulpWord[4]);
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+					 "2881 RRQ failure DID:%06X Status:"
+					 "x%x/x%x\n",
+					 ndlp->nlp_DID, irsp->ulpStatus,
+					 irsp->un.ulpWord[4]);
 	}
 out:
 	if (rrq)
@@ -2010,7 +2011,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	ndlp = lpfc_findnode_did(vport, irsp->un.elsreq64.remoteID);
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0136 PLOGI completes to NPort x%x "
 				 "with no ndlp. Data: x%x x%x x%x\n",
 				 irsp->un.elsreq64.remoteID,
@@ -2059,7 +2060,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			(((irsp->un.ulpWord[4]) >> 16 != LSRJT_INVALID_CMD) &&
 			((irsp->un.ulpWord[4]) >> 16 != LSRJT_UNABLE_TPC)) ||
 			(phba)->pport->cfg_log_verbose & LOG_ELS)
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2753 PLOGI failure DID:%06X Status:x%x/x%x\n",
 				 ndlp->nlp_DID, irsp->ulpStatus,
 				 irsp->un.ulpWord[4]);
@@ -2237,6 +2238,7 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp;
 	char *mode;
+	u32 loglevel;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2278,13 +2280,16 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * could be expected.
 		 */
 		if ((vport->fc_flag & FC_FABRIC) ||
-		    (vport->cfg_enable_fc4_type != LPFC_ENABLE_BOTH))
+		    (vport->cfg_enable_fc4_type != LPFC_ENABLE_BOTH)) {
 			mode = KERN_ERR;
-		else
+			loglevel =  LOG_TRACE_EVENT;
+		} else {
 			mode = KERN_INFO;
+			loglevel =  LOG_ELS;
+		}
 
 		/* PRLI failed */
-		lpfc_printf_vlog(vport, mode, LOG_ELS,
+		lpfc_printf_vlog(vport, mode, loglevel,
 				 "2754 PRLI failure DID:%06X Status:x%x/x%x, "
 				 "data: x%x\n",
 				 ndlp->nlp_DID, irsp->ulpStatus,
@@ -2697,7 +2702,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			goto out;
 		}
 		/* ADISC failed */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2755 ADISC failure DID:%06X Status:x%x/x%x\n",
 				 ndlp->nlp_DID, irsp->ulpStatus,
 				 irsp->un.ulpWord[4]);
@@ -2855,7 +2860,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	 */
 	if (irsp->ulpStatus) {
 		/* LOGO failed */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2756 LOGO failure, No Retry DID:%06X Status:x%x/x%x\n",
 				 ndlp->nlp_DID, irsp->ulpStatus,
 				 irsp->un.ulpWord[4]);
@@ -3736,7 +3741,7 @@ lpfc_link_reset(struct lpfc_vport *vport)
 			 "2851 Attempt link reset\n");
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2852 Failed to allocate mbox memory");
 		return 1;
 	}
@@ -3758,7 +3763,7 @@ lpfc_link_reset(struct lpfc_vport *vport)
 	mbox->vport = vport;
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 	if ((rc != MBX_BUSY) && (rc != MBX_SUCCESS)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2853 Failed to issue INIT_LINK "
 				"mbox command, rc:x%x\n", rc);
 		mempool_free(mbox, phba->mbox_mem_pool);
@@ -3862,7 +3867,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			break;
 
 		case IOERR_ILLEGAL_COMMAND:
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0124 Retry illegal cmd x%x "
 					 "retry:x%x delay:x%x\n",
 					 cmd, cmdiocb->retry, delay);
@@ -3972,7 +3977,8 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			if ((phba->sli3_options & LPFC_SLI3_NPIV_ENABLED) &&
 			  (cmd == ELS_CMD_FDISC) &&
 			  (stat.un.b.lsRjtRsnCodeExp == LSEXP_OUT_OF_RESOURCE)){
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+				lpfc_printf_vlog(vport, KERN_ERR,
+						 LOG_TRACE_EVENT,
 						 "0125 FDISC Failed (x%x). "
 						 "Fabric out of resources\n",
 						 stat.un.lsRjtError);
@@ -4011,7 +4017,8 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 						LSEXP_NOTHING_MORE) {
 				vport->fc_sparam.cmn.bbRcvSizeMsb &= 0xf;
 				retry = 1;
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+				lpfc_printf_vlog(vport, KERN_ERR,
+						 LOG_TRACE_EVENT,
 						 "0820 FLOGI Failed (x%x). "
 						 "BBCredit Not Supported\n",
 						 stat.un.lsRjtError);
@@ -4024,7 +4031,8 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			  ((stat.un.b.lsRjtRsnCodeExp == LSEXP_INVALID_PNAME) ||
 			  (stat.un.b.lsRjtRsnCodeExp == LSEXP_INVALID_NPORT_ID))
 			  ) {
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+				lpfc_printf_vlog(vport, KERN_ERR,
+						 LOG_TRACE_EVENT,
 						 "0122 FDISC Failed (x%x). "
 						 "Fabric Detected Bad WWN\n",
 						 stat.un.lsRjtError);
@@ -4202,7 +4210,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 	/* No retry ELS command <elsCmd> to remote NPORT <did> */
 	if (logerr) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0137 No retry ELS command x%x to remote "
 			 "NPORT x%x: Out of Resources: Error:x%x/%x\n",
 			 cmd, did, irsp->ulpStatus,
@@ -4501,7 +4509,7 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	irsp = &rspiocb->iocb;
 
 	if (!vport) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_ELS,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3177 ELS response failed\n");
 		goto out;
 	}
@@ -4607,7 +4615,7 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
 
 			/* ELS rsp: Cannot issue reg_login for <NPortid> */
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0138 ELS rsp: Cannot issue reg_login for x%x "
 				"Data: x%x x%x x%x\n",
 				ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -6413,8 +6421,8 @@ lpfc_els_rcv_lcb(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	lcb_context->rx_id = cmdiocb->iocb.ulpContext;
 	lcb_context->ndlp = lpfc_nlp_get(ndlp);
 	if (lpfc_sli4_set_beacon(vport, lcb_context, state)) {
-		lpfc_printf_vlog(ndlp->vport, KERN_ERR,
-				 LOG_ELS, "0193 failed to send mail box");
+		lpfc_printf_vlog(ndlp->vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "0193 failed to send mail box");
 		kfree(lcb_context);
 		lpfc_nlp_put(ndlp);
 		rjt_err = LSRJT_UNABLE_TPC;
@@ -6623,7 +6631,7 @@ lpfc_send_rscn_event(struct lpfc_vport *vport,
 	rscn_event_data = kmalloc(sizeof(struct lpfc_rscn_event_header) +
 		payload_len, GFP_KERNEL);
 	if (!rscn_event_data) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0147 Failed to allocate memory for RSCN event\n");
 		return;
 	}
@@ -7000,7 +7008,7 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 		/* An FLOGI ELS command <elsCmd> was received from DID <did> in
 		   Loop Mode */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0113 An FLOGI ELS command x%x was "
 				 "received from DID x%x in Loop Mode\n",
 				 cmd, did);
@@ -7990,7 +7998,7 @@ lpfc_els_timeout_handler(struct lpfc_vport *vport)
 
 	list_for_each_entry_safe(piocb, tmp_iocb, &abort_list, dlist) {
 		cmd = &piocb->iocb;
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0127 ELS timeout Data: x%x x%x x%x "
 			 "x%x\n", els_command,
 			 remote_ID, cmd->ulpCommand, cmd->ulpIoTag);
@@ -8100,7 +8108,7 @@ lpfc_els_flush_cmd(struct lpfc_vport *vport)
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	}
 	if (!list_empty(&abort_list))
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "3387 abort list for txq not empty\n");
 	INIT_LIST_HEAD(&abort_list);
 
@@ -8271,7 +8279,7 @@ lpfc_send_els_event(struct lpfc_vport *vport,
 	if (*payload == ELS_CMD_LOGO) {
 		logo_data = kmalloc(sizeof(struct lpfc_logo_event), GFP_KERNEL);
 		if (!logo_data) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0148 Failed to allocate memory "
 				"for LOGO event\n");
 			return;
@@ -8281,7 +8289,7 @@ lpfc_send_els_event(struct lpfc_vport *vport,
 		els_data = kmalloc(sizeof(struct lpfc_els_event_header),
 			GFP_KERNEL);
 		if (!els_data) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0149 Failed to allocate memory "
 				"for ELS event\n");
 			return;
@@ -8398,7 +8406,7 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, struct fc_els_fpin *fpin,
 			break;
 		default:
 			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "4678  skipped FPIN descriptor[%d]: "
 					 "tag x%x (%s)\n",
 					 desc_cnt, dtag, dtag_nm);
@@ -8813,7 +8821,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		rjt_exp = LSEXP_NOTHING_MORE;
 
 		/* Unknown ELS command <elsCmd> received from NPORT <did> */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0115 Unknown ELS command x%x "
 				 "received from NPORT x%x\n", cmd, did);
 		if (newnode)
@@ -8858,7 +8866,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 dropit:
 	if (vport && !(vport->load_flag & FC_UNLOADING))
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0111 Dropping received ELS cmd "
 			"Data: x%x x%x x%x\n",
 			icmd->ulpStatus, icmd->un.ulpWord[4], icmd->ulpTimeout);
@@ -9008,7 +9016,7 @@ lpfc_do_scr_ns_plogi(struct lpfc_hba *phba, struct lpfc_vport *vport)
 	spin_lock_irq(shost->host_lock);
 	if (vport->fc_flag & FC_DISC_DELAYED) {
 		spin_unlock_irq(shost->host_lock);
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3334 Delay fc port discovery for %d seconds\n",
 				phba->fc_ratov);
 		mod_timer(&vport->delayed_disc_tmo,
@@ -9026,7 +9034,7 @@ lpfc_do_scr_ns_plogi(struct lpfc_hba *phba, struct lpfc_vport *vport)
 				return;
 			}
 			lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0251 NameServer login: no memory\n");
 			return;
 		}
@@ -9038,7 +9046,7 @@ lpfc_do_scr_ns_plogi(struct lpfc_hba *phba, struct lpfc_vport *vport)
 				return;
 			}
 			lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					"0348 NameServer login: node freed\n");
 			return;
 		}
@@ -9049,7 +9057,7 @@ lpfc_do_scr_ns_plogi(struct lpfc_hba *phba, struct lpfc_vport *vport)
 
 	if (lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0)) {
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0252 Cannot issue NameServer login\n");
 		return;
 	}
@@ -9086,7 +9094,7 @@ lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	spin_unlock_irq(shost->host_lock);
 
 	if (mb->mbxStatus) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0915 Register VPI failed : Status: x%x"
 				" upd bit: x%x \n", mb->mbxStatus,
 				 mb->un.varRegVpi.upd);
@@ -9116,8 +9124,8 @@ lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			rc = lpfc_sli_issue_mbox(phba, pmb,
 				MBX_NOWAIT);
 			if (rc == MBX_NOT_FINISHED) {
-				lpfc_printf_vlog(vport,
-					KERN_ERR, LOG_MBOX,
+				lpfc_printf_vlog(vport, KERN_ERR,
+						 LOG_TRACE_EVENT,
 					"2732 Failed to issue INIT_VPI"
 					" mailbox command\n");
 			} else {
@@ -9205,12 +9213,12 @@ lpfc_register_new_vport(struct lpfc_hba *phba, struct lpfc_vport *vport,
 			lpfc_nlp_put(ndlp);
 			mempool_free(mbox, phba->mbox_mem_pool);
 
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0253 Register VPI: Can't send mbox\n");
 			goto mbox_err_exit;
 		}
 	} else {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0254 Register VPI: no memory\n");
 		goto mbox_err_exit;
 	}
@@ -9372,7 +9380,7 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb))
 			goto out;
 		/* FDISC failed */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0126 FDISC failed. (x%x/x%x)\n",
 				 irsp->ulpStatus, irsp->un.ulpWord[4]);
 		goto fdisc_failed;
@@ -9494,7 +9502,7 @@ lpfc_issue_els_fdisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				     ELS_CMD_FDISC);
 	if (!elsiocb) {
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0255 Issue FDISC: no IOCB\n");
 		return 1;
 	}
@@ -9548,7 +9556,7 @@ lpfc_issue_els_fdisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (rc == IOCB_ERROR) {
 		lpfc_els_free_iocb(phba, elsiocb);
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0256 Issue FDISC: Cannot send IOCB\n");
 		return 1;
 	}
@@ -10129,8 +10137,7 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 				"rport in state 0x%x\n", ndlp->nlp_state);
 		return;
 	}
-	lpfc_printf_log(phba, KERN_ERR,
-			LOG_ELS | LOG_FCP_ERROR | LOG_NVME_IOERR,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"3094 Start rport recovery on shost id 0x%x "
 			"fc_id 0x%06x vpi 0x%x rpi 0x%x state 0x%x "
 			"flags 0x%x\n",
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 47259970907d..66979f6312a4 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -155,17 +155,17 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		return;
 
 	if (rport->port_name != wwn_to_u64(ndlp->nlp_portname.u.wwn))
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
-				"6789 rport name %llx != node port name %llx",
-				rport->port_name,
-				wwn_to_u64(ndlp->nlp_portname.u.wwn));
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "6789 rport name %llx != node port name %llx",
+				 rport->port_name,
+				 wwn_to_u64(ndlp->nlp_portname.u.wwn));
 
 	evtp = &ndlp->dev_loss_evt;
 
 	if (!list_empty(&evtp->evt_listp)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
-				"6790 rport name %llx dev_loss_evt pending",
-				rport->port_name);
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "6790 rport name %llx dev_loss_evt pending",
+				 rport->port_name);
 		return;
 	}
 
@@ -295,7 +295,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 	}
 
 	if (warn_on) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0203 Devloss timeout on "
 				 "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
 				 "NPort x%06x Data: x%x x%x x%x\n",
@@ -304,7 +304,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 				 ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->nlp_state, ndlp->nlp_rpi);
 	} else {
-		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_TRACE_EVENT,
 				 "0204 Devloss timeout on "
 				 "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
 				 "NPort x%06x Data: x%x x%x x%x\n",
@@ -755,7 +755,7 @@ lpfc_do_work(void *p)
 					 || kthread_should_stop()));
 		/* Signal wakeup shall terminate the worker thread */
 		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_ELS,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0433 Wakeup on signal: rc=x%x\n", rc);
 			break;
 		}
@@ -1092,7 +1092,7 @@ lpfc_mbx_cmpl_clear_la(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	/* Check for error */
 	if ((mb->mbxStatus) && (mb->mbxStatus != 0x1601)) {
 		/* CLEAR_LA mbox error <mbxStatus> state <hba_state> */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0320 CLEAR_LA mbxStatus error x%x hba "
 				 "state x%x\n",
 				 mb->mbxStatus, vport->port_state);
@@ -1180,7 +1180,7 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	return;
 
 out:
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0306 CONFIG_LINK mbxStatus error x%x "
 			 "HBA state x%x\n",
 			 pmb->u.mb.mbxStatus, vport->port_state);
@@ -1188,7 +1188,7 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	lpfc_linkdown(phba);
 
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0200 CONFIG_LINK bad hba state x%x\n",
 			 vport->port_state);
 
@@ -1224,10 +1224,10 @@ lpfc_mbx_cmpl_reg_fcfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	struct lpfc_vport *vport = mboxq->vport;
 
 	if (mboxq->u.mb.mbxStatus) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
-			 "2017 REG_FCFI mbxStatus error x%x "
-			 "HBA state x%x\n",
-			 mboxq->u.mb.mbxStatus, vport->port_state);
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "2017 REG_FCFI mbxStatus error x%x "
+				 "HBA state x%x\n", mboxq->u.mb.mbxStatus,
+				 vport->port_state);
 		goto fail_out;
 	}
 
@@ -1848,7 +1848,7 @@ lpfc_sli4_fcf_rec_mbox_parse(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq,
 	 */
 	lpfc_sli4_mbx_sge_get(mboxq, 0, &sge);
 	if (unlikely(!mboxq->sge_array)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2524 Failed to get the non-embedded SGE "
 				"virtual address\n");
 		return NULL;
@@ -1864,11 +1864,12 @@ lpfc_sli4_fcf_rec_mbox_parse(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq,
 	if (shdr_status || shdr_add_status) {
 		if (shdr_status == STATUS_FCF_TABLE_EMPTY ||
 					if_type == LPFC_SLI_INTF_IF_TYPE_2)
-			lpfc_printf_log(phba, KERN_ERR, LOG_FIP,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"2726 READ_FCF_RECORD Indicates empty "
 					"FCF table.\n");
 		else
-			lpfc_printf_log(phba, KERN_ERR, LOG_FIP,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2521 READ_FCF_RECORD mailbox failed "
 					"with status x%x add_status x%x, "
 					"mbx\n", shdr_status, shdr_add_status);
@@ -2246,7 +2247,7 @@ lpfc_mbx_cmpl_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	new_fcf_record = lpfc_sli4_fcf_rec_mbox_parse(phba, mboxq,
 						      &next_fcf_index);
 	if (!new_fcf_record) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_FIP,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2765 Mailbox command READ_FCF_RECORD "
 				"failed to retrieve a FCF record.\n");
 		/* Let next new FCF event trigger fast failover */
@@ -2290,7 +2291,8 @@ lpfc_mbx_cmpl_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 		    new_fcf_record, LPFC_FCOE_IGNORE_VID)) {
 			if (bf_get(lpfc_fcf_record_fcf_index, new_fcf_record) !=
 			    phba->fcf.current_rec.fcf_indx) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_FIP,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 					"2862 FCF (x%x) matches property "
 					"of in-use FCF (x%x)\n",
 					bf_get(lpfc_fcf_record_fcf_index,
@@ -2360,7 +2362,7 @@ lpfc_mbx_cmpl_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 						phba->pport->fc_flag);
 				goto out;
 			} else
-				lpfc_printf_log(phba, KERN_ERR, LOG_FIP,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2863 New FCF (x%x) matches "
 					"property of in-use FCF (x%x)\n",
 					bf_get(lpfc_fcf_record_fcf_index,
@@ -2774,10 +2776,9 @@ lpfc_init_vfi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	    (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) !=
 			LPFC_SLI_INTF_IF_TYPE_0) &&
 	    mboxq->u.mb.mbxStatus != MBX_VFI_IN_USE) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-				LOG_MBOX,
-				"2891 Init VFI mailbox failed 0x%x\n",
-				mboxq->u.mb.mbxStatus);
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "2891 Init VFI mailbox failed 0x%x\n",
+				 mboxq->u.mb.mbxStatus);
 		mempool_free(mboxq, phba->mbox_mem_pool);
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 		return;
@@ -2805,7 +2806,7 @@ lpfc_issue_init_vfi(struct lpfc_vport *vport)
 	mboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
 		lpfc_printf_vlog(vport, KERN_ERR,
-			LOG_MBOX, "2892 Failed to allocate "
+			LOG_TRACE_EVENT, "2892 Failed to allocate "
 			"init_vfi mailbox\n");
 		return;
 	}
@@ -2813,8 +2814,8 @@ lpfc_issue_init_vfi(struct lpfc_vport *vport)
 	mboxq->mbox_cmpl = lpfc_init_vfi_cmpl;
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-			LOG_MBOX, "2893 Failed to issue init_vfi mailbox\n");
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "2893 Failed to issue init_vfi mailbox\n");
 		mempool_free(mboxq, vport->phba->mbox_mem_pool);
 	}
 }
@@ -2834,10 +2835,9 @@ lpfc_init_vpi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 
 	if (mboxq->u.mb.mbxStatus) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-				LOG_MBOX,
-				"2609 Init VPI mailbox failed 0x%x\n",
-				mboxq->u.mb.mbxStatus);
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "2609 Init VPI mailbox failed 0x%x\n",
+				 mboxq->u.mb.mbxStatus);
 		mempool_free(mboxq, phba->mbox_mem_pool);
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 		return;
@@ -2851,7 +2851,7 @@ lpfc_init_vpi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 			ndlp = lpfc_findnode_did(vport, Fabric_DID);
 			if (!ndlp)
 				lpfc_printf_vlog(vport, KERN_ERR,
-					LOG_DISCOVERY,
+					LOG_TRACE_EVENT,
 					"2731 Cannot find fabric "
 					"controller node\n");
 			else
@@ -2864,7 +2864,7 @@ lpfc_init_vpi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 		lpfc_initial_fdisc(vport);
 	else {
 		lpfc_vport_set_state(vport, FC_VPORT_NO_FABRIC_SUPP);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2606 No NPIV Fabric support\n");
 	}
 	mempool_free(mboxq, phba->mbox_mem_pool);
@@ -2887,8 +2887,7 @@ lpfc_issue_init_vpi(struct lpfc_vport *vport)
 	if ((vport->port_type != LPFC_PHYSICAL_PORT) && (!vport->vpi)) {
 		vpi = lpfc_alloc_vpi(vport->phba);
 		if (!vpi) {
-			lpfc_printf_vlog(vport, KERN_ERR,
-					 LOG_MBOX,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "3303 Failed to obtain vport vpi\n");
 			lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 			return;
@@ -2899,7 +2898,7 @@ lpfc_issue_init_vpi(struct lpfc_vport *vport)
 	mboxq = mempool_alloc(vport->phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
 		lpfc_printf_vlog(vport, KERN_ERR,
-			LOG_MBOX, "2607 Failed to allocate "
+			LOG_TRACE_EVENT, "2607 Failed to allocate "
 			"init_vpi mailbox\n");
 		return;
 	}
@@ -2908,8 +2907,8 @@ lpfc_issue_init_vpi(struct lpfc_vport *vport)
 	mboxq->mbox_cmpl = lpfc_init_vpi_cmpl;
 	rc = lpfc_sli_issue_mbox(vport->phba, mboxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-			LOG_MBOX, "2608 Failed to issue init_vpi mailbox\n");
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "2608 Failed to issue init_vpi mailbox\n");
 		mempool_free(mboxq, vport->phba->mbox_mem_pool);
 	}
 }
@@ -2953,7 +2952,7 @@ lpfc_start_fdiscs(struct lpfc_hba *phba)
 				lpfc_vport_set_state(vports[i],
 						     FC_VPORT_NO_FABRIC_SUPP);
 				lpfc_printf_vlog(vports[i], KERN_ERR,
-						 LOG_ELS,
+						 LOG_TRACE_EVENT,
 						 "0259 No NPIV "
 						 "Fabric support\n");
 			}
@@ -2977,10 +2976,10 @@ lpfc_mbx_cmpl_reg_vfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	    (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) !=
 			LPFC_SLI_INTF_IF_TYPE_0) &&
 	    mboxq->u.mb.mbxStatus != MBX_VFI_IN_USE) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
-			 "2018 REG_VFI mbxStatus error x%x "
-			 "HBA state x%x\n",
-			 mboxq->u.mb.mbxStatus, vport->port_state);
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "2018 REG_VFI mbxStatus error x%x "
+				 "HBA state x%x\n",
+				 mboxq->u.mb.mbxStatus, vport->port_state);
 		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
 			/* FLOGI failed, use loop map to make discovery list */
 			lpfc_disc_list_loopmap(vport);
@@ -3067,7 +3066,7 @@ lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	/* Check for error */
 	if (mb->mbxStatus) {
 		/* READ_SPARAM mbox error <mbxStatus> state <hba_state> */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0319 READ_SPARAM mbxStatus error x%x "
 				 "hba state x%x>\n",
 				 mb->mbxStatus, vport->port_state);
@@ -3286,7 +3285,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 					GFP_KERNEL);
 			if (unlikely(!fcf_record)) {
 				lpfc_printf_log(phba, KERN_ERR,
-					LOG_MBOX | LOG_SLI,
+					LOG_TRACE_EVENT,
 					"2554 Could not allocate memory for "
 					"fcf record\n");
 				rc = -ENODEV;
@@ -3298,7 +3297,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 			rc = lpfc_sli4_add_fcf_record(phba, fcf_record);
 			if (unlikely(rc)) {
 				lpfc_printf_log(phba, KERN_ERR,
-					LOG_MBOX | LOG_SLI,
+					LOG_TRACE_EVENT,
 					"2013 Could not manually add FCF "
 					"record 0, status %d\n", rc);
 				rc = -ENODEV;
@@ -3344,7 +3343,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 	return;
 out:
 	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0263 Discovery Mailbox error: state: 0x%x : x%px x%px\n",
 			 vport->port_state, sparam_mbox, cfglink_mbox);
 	lpfc_issue_clear_la(phba, vport);
@@ -3617,7 +3616,7 @@ lpfc_mbx_cmpl_unreg_vpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		break;
 	/* If VPI is busy, reset the HBA */
 	case 0x9700:
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"2798 Unreg_vpi failed vpi 0x%x, mb status = 0x%x\n",
 			vport->vpi, mb->mbxStatus);
 		if (!(phba->pport->load_flag & FC_UNLOADING))
@@ -3655,7 +3654,7 @@ lpfc_mbx_unreg_vpi(struct lpfc_vport *vport)
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_unreg_vpi;
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX | LOG_VPORT,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "1800 Could not issue unreg_vpi\n");
 		mempool_free(mbox, phba->mbox_mem_pool);
 		vport->unreg_vpi_cmpl = VPORT_ERROR;
@@ -3742,7 +3741,7 @@ lpfc_create_static_vport(struct lpfc_hba *phba)
 
 	pmb = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!pmb) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0542 lpfc_create_static_vport failed to"
 				" allocate mailbox memory\n");
 		return;
@@ -3752,7 +3751,7 @@ lpfc_create_static_vport(struct lpfc_hba *phba)
 
 	vport_info = kzalloc(sizeof(struct static_vport_info), GFP_KERNEL);
 	if (!vport_info) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0543 lpfc_create_static_vport failed to"
 				" allocate vport_info\n");
 		mempool_free(pmb, phba->mbox_mem_pool);
@@ -3813,11 +3812,12 @@ lpfc_create_static_vport(struct lpfc_hba *phba)
 	if ((le32_to_cpu(vport_info->signature) != VPORT_INFO_SIG) ||
 		((le32_to_cpu(vport_info->rev) & VPORT_INFO_REV_MASK)
 			!= VPORT_INFO_REV)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-			"0545 lpfc_create_static_vport bad"
-			" information header 0x%x 0x%x\n",
-			le32_to_cpu(vport_info->signature),
-			le32_to_cpu(vport_info->rev) & VPORT_INFO_REV_MASK);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"0545 lpfc_create_static_vport bad"
+				" information header 0x%x 0x%x\n",
+				le32_to_cpu(vport_info->signature),
+				le32_to_cpu(vport_info->rev) &
+				VPORT_INFO_REV_MASK);
 
 		goto out;
 	}
@@ -3881,7 +3881,7 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	pmb->ctx_buf = NULL;
 
 	if (mb->mbxStatus) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0258 Register Fabric login error: 0x%x\n",
 				 mb->mbxStatus);
 		lpfc_mbuf_free(phba, mp->virt, mp->phys);
@@ -3954,7 +3954,8 @@ lpfc_issue_gidft(struct lpfc_vport *vport)
 			/* Cannot issue NameServer FCP Query, so finish up
 			 * discovery
 			 */
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_SLI,
+			lpfc_printf_vlog(vport, KERN_ERR,
+					 LOG_TRACE_EVENT,
 					 "0604 %s FC TYPE %x %s\n",
 					 "Failed to issue GID_FT to ",
 					 FC_TYPE_FCP,
@@ -3970,7 +3971,8 @@ lpfc_issue_gidft(struct lpfc_vport *vport)
 			/* Cannot issue NameServer NVME Query, so finish up
 			 * discovery
 			 */
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_SLI,
+			lpfc_printf_vlog(vport, KERN_ERR,
+					 LOG_TRACE_EVENT,
 					 "0605 %s FC_TYPE %x %s %d\n",
 					 "Failed to issue GID_FT to ",
 					 FC_TYPE_NVME,
@@ -4002,7 +4004,7 @@ lpfc_issue_gidpt(struct lpfc_vport *vport)
 		/* Cannot issue NameServer FCP Query, so finish up
 		 * discovery
 		 */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_SLI,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0606 %s Port TYPE %x %s\n",
 				 "Failed to issue GID_PT to ",
 				 GID_PT_N_PORT,
@@ -4032,7 +4034,7 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	vport->gidft_inp = 0;
 
 	if (mb->mbxStatus) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0260 Register NameServer error: 0x%x\n",
 				 mb->mbxStatus);
 
@@ -4348,7 +4350,7 @@ lpfc_nlp_state_cleanup(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 					 GFP_KERNEL);
 
 		if (!ndlp->lat_data)
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0286 lpfc_nlp_state_cleanup failed to "
 				"allocate statistical data buffer DID "
 				"0x%x\n", ndlp->nlp_DID);
@@ -5017,8 +5019,8 @@ lpfc_unreg_hba_rpis(struct lpfc_hba *phba)
 
 	vports = lpfc_create_vport_work_array(phba);
 	if (!vports) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY,
-			"2884 Vport array allocation failed \n");
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2884 Vport array allocation failed \n");
 		return;
 	}
 	for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
@@ -5061,9 +5063,10 @@ lpfc_unreg_all_rpis(struct lpfc_vport *vport)
 			mempool_free(mbox, phba->mbox_mem_pool);
 
 		if ((rc == MBX_TIMEOUT) || (rc == MBX_NOT_FINISHED))
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX | LOG_VPORT,
-				"1836 Could not issue "
-				"unreg_login(all_rpis) status %d\n", rc);
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+					 "1836 Could not issue "
+					 "unreg_login(all_rpis) status %d\n",
+					 rc);
 	}
 }
 
@@ -5090,7 +5093,7 @@ lpfc_unreg_default_rpis(struct lpfc_vport *vport)
 			mempool_free(mbox, phba->mbox_mem_pool);
 
 		if ((rc == MBX_TIMEOUT) || (rc == MBX_NOT_FINISHED))
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX | LOG_VPORT,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "1815 Could not issue "
 					 "unreg_did (default rpis) status %d\n",
 					 rc);
@@ -5911,7 +5914,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 	case LPFC_FLOGI:
 	/* port_state is identically LPFC_FLOGI while waiting for FLOGI cmpl */
 		/* Initial FLOGI timeout */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_TRACE_EVENT,
 				 "0222 Initial %s timeout\n",
 				 vport->vpi ? "FDISC" : "FLOGI");
 
@@ -5929,7 +5933,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 	case LPFC_FABRIC_CFG_LINK:
 	/* hba_state is identically LPFC_FABRIC_CFG_LINK while waiting for
 	   NameServer login */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_TRACE_EVENT,
 				 "0223 Timeout while waiting for "
 				 "NameServer login\n");
 		/* Next look for NameServer ndlp */
@@ -5942,7 +5947,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 
 	case LPFC_NS_QRY:
 	/* Check for wait for NameServer Rsp timeout */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_TRACE_EVENT,
 				 "0224 NameServer Query timeout "
 				 "Data: x%x x%x\n",
 				 vport->fc_ns_retry, LPFC_MAX_NS_RETRY);
@@ -5975,7 +5981,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 		/* Setup and issue mailbox INITIALIZE LINK command */
 		initlinkmbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 		if (!initlinkmbox) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+			lpfc_printf_vlog(vport, KERN_ERR,
+					 LOG_TRACE_EVENT,
 					 "0206 Device Discovery "
 					 "completion error\n");
 			phba->link_state = LPFC_HBA_ERROR;
@@ -5997,7 +6004,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 
 	case LPFC_DISC_AUTH:
 	/* Node Authentication timeout */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_TRACE_EVENT,
 				 "0227 Node Authentication timeout\n");
 		lpfc_disc_flush_list(vport);
 
@@ -6017,7 +6025,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 
 	case LPFC_VPORT_READY:
 		if (vport->fc_flag & FC_RSCN_MODE) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+			lpfc_printf_vlog(vport, KERN_ERR,
+					 LOG_TRACE_EVENT,
 					 "0231 RSCN timeout Data: x%x "
 					 "x%x\n",
 					 vport->fc_ns_retry, LPFC_MAX_NS_RETRY);
@@ -6031,7 +6040,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 		break;
 
 	default:
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_TRACE_EVENT,
 				 "0273 Unexpected discovery timeout, "
 				 "vport State x%x\n", vport->port_state);
 		break;
@@ -6040,7 +6050,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 	switch (phba->link_state) {
 	case LPFC_CLEAR_LA:
 				/* CLEAR LA timeout */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_TRACE_EVENT,
 				 "0228 CLEAR LA timeout\n");
 		clrlaerr = 1;
 		break;
@@ -6054,7 +6065,8 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 	case LPFC_INIT_MBX_CMDS:
 	case LPFC_LINK_DOWN:
 	case LPFC_HBA_ERROR:
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_TRACE_EVENT,
 				 "0230 Unexpected timeout, hba link "
 				 "state x%x\n", phba->link_state);
 		clrlaerr = 1;
@@ -6245,9 +6257,9 @@ lpfc_find_vport_by_vpid(struct lpfc_hba *phba, uint16_t vpi)
 		}
 
 		if (i >= phba->max_vpi) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_ELS,
-					 "2936 Could not find Vport mapped "
-					 "to vpi %d\n", vpi);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"2936 Could not find Vport mapped "
+					"to vpi %d\n", vpi);
 			return NULL;
 		}
 	}
@@ -6551,10 +6563,10 @@ lpfc_unregister_vfi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 
 	if (mboxq->u.mb.mbxStatus) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY|LOG_MBOX,
-			"2555 UNREG_VFI mbxStatus error x%x "
-			"HBA state x%x\n",
-			mboxq->u.mb.mbxStatus, vport->port_state);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2555 UNREG_VFI mbxStatus error x%x "
+				"HBA state x%x\n",
+				mboxq->u.mb.mbxStatus, vport->port_state);
 	}
 	spin_lock_irq(shost->host_lock);
 	phba->pport->fc_flag &= ~FC_VFI_REGISTERED;
@@ -6576,10 +6588,10 @@ lpfc_unregister_fcfi_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	struct lpfc_vport *vport = mboxq->vport;
 
 	if (mboxq->u.mb.mbxStatus) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY|LOG_MBOX,
-			"2550 UNREG_FCFI mbxStatus error x%x "
-			"HBA state x%x\n",
-			mboxq->u.mb.mbxStatus, vport->port_state);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2550 UNREG_FCFI mbxStatus error x%x "
+				"HBA state x%x\n",
+				mboxq->u.mb.mbxStatus, vport->port_state);
 	}
 	mempool_free(mboxq, phba->mbox_mem_pool);
 	return;
@@ -6668,7 +6680,7 @@ lpfc_sli4_unregister_fcf(struct lpfc_hba *phba)
 
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY|LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2551 UNREG_FCFI mbox allocation failed"
 				"HBA state x%x\n", phba->pport->port_state);
 		return -ENOMEM;
@@ -6679,7 +6691,7 @@ lpfc_sli4_unregister_fcf(struct lpfc_hba *phba)
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2552 Unregister FCFI command failed rc x%x "
 				"HBA state x%x\n",
 				rc, phba->pport->port_state);
@@ -6703,7 +6715,7 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	/* Preparation for unregistering fcf */
 	rc = lpfc_unregister_fcf_prep(phba);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2748 Failed to prepare for unregistering "
 				"HBA's FCF record: rc=%d\n", rc);
 		return;
@@ -6739,7 +6751,7 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 		spin_lock_irq(&phba->hbalock);
 		phba->fcf.fcf_flag &= ~FCF_INIT_DISC;
 		spin_unlock_irq(&phba->hbalock);
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY|LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2553 lpfc_unregister_unused_fcf failed "
 				"to read FCF record HBA state x%x\n",
 				phba->pport->port_state);
@@ -6761,7 +6773,7 @@ lpfc_unregister_fcf(struct lpfc_hba *phba)
 	/* Preparation for unregistering fcf */
 	rc = lpfc_unregister_fcf_prep(phba);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2749 Failed to prepare for unregistering "
 				"HBA's FCF record: rc=%d\n", rc);
 		return;
@@ -6848,9 +6860,9 @@ lpfc_read_fcf_conn_tbl(struct lpfc_hba *phba,
 		conn_entry = kzalloc(sizeof(struct lpfc_fcf_conn_entry),
 			GFP_KERNEL);
 		if (!conn_entry) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-				"2566 Failed to allocate connection"
-				" table entry\n");
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"2566 Failed to allocate connection"
+					" table entry\n");
 			return;
 		}
 
@@ -6994,7 +7006,7 @@ lpfc_parse_fcoe_conf(struct lpfc_hba *phba,
 
 	/* Check the region signature first */
 	if (memcmp(buff, LPFC_REGION23_SIGNATURE, 4)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2567 Config region 23 has bad signature\n");
 		return;
 	}
@@ -7003,8 +7015,8 @@ lpfc_parse_fcoe_conf(struct lpfc_hba *phba,
 
 	/* Check the data structure version */
 	if (buff[offset] != LPFC_REGION23_VERSION) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-			"2568 Config region 23 has bad version\n");
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2568 Config region 23 has bad version\n");
 		return;
 	}
 	offset += 4;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index e7aecbe3cb84..33d334ac8d20 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -153,7 +153,7 @@ lpfc_config_port_prep(struct lpfc_hba *phba)
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_POLL);
 
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0324 Config Port initialization "
 					"error, mbxCmd x%x READ_NVPARM, "
 					"mbxStatus x%x\n",
@@ -177,7 +177,7 @@ lpfc_config_port_prep(struct lpfc_hba *phba)
 	lpfc_read_rev(phba, pmb);
 	rc = lpfc_sli_issue_mbox(phba, pmb, MBX_POLL);
 	if (rc != MBX_SUCCESS) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0439 Adapter failed to init, mbxCmd x%x "
 				"READ_REV, mbxStatus x%x\n",
 				mb->mbxCommand, mb->mbxStatus);
@@ -192,7 +192,7 @@ lpfc_config_port_prep(struct lpfc_hba *phba)
 	 */
 	if (mb->un.varRdRev.rr == 0) {
 		vp->rev.rBit = 0;
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0440 Adapter failed to init, READ_REV has "
 				"missing revision information.\n");
 		mempool_free(pmb, phba->mbox_mem_pool);
@@ -444,7 +444,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 
 	pmb->vport = vport;
 	if (lpfc_sli_issue_mbox(phba, pmb, MBX_POLL) != MBX_SUCCESS) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0448 Adapter failed init, mbxCmd x%x "
 				"READ_SPARM mbxStatus x%x\n",
 				mb->mbxCommand, mb->mbxStatus);
@@ -498,7 +498,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 	lpfc_read_config(phba, pmb);
 	pmb->vport = vport;
 	if (lpfc_sli_issue_mbox(phba, pmb, MBX_POLL) != MBX_SUCCESS) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0453 Adapter failed to init, mbxCmd x%x "
 				"READ_CONFIG, mbxStatus x%x\n",
 				mb->mbxCommand, mb->mbxStatus);
@@ -547,7 +547,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 		}
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_POLL);
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0352 Config MSI mailbox command "
 					"failed, mbxCmd x%x, mbxStatus x%x\n",
 					pmb->u.mb.mbxCommand,
@@ -598,17 +598,15 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 		  jiffies + msecs_to_jiffies(1000 * phba->eratt_poll_interval));
 
 	if (phba->hba_flag & LINK_DISABLED) {
-		lpfc_printf_log(phba,
-			KERN_ERR, LOG_INIT,
-			"2598 Adapter Link is disabled.\n");
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2598 Adapter Link is disabled.\n");
 		lpfc_down_link(phba, pmb);
 		pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
 		if ((rc != MBX_SUCCESS) && (rc != MBX_BUSY)) {
-			lpfc_printf_log(phba,
-			KERN_ERR, LOG_INIT,
-			"2599 Adapter failed to issue DOWN_LINK"
-			" mbox command rc 0x%x\n", rc);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"2599 Adapter failed to issue DOWN_LINK"
+					" mbox command rc 0x%x\n", rc);
 
 			mempool_free(pmb, phba->mbox_mem_pool);
 			return -EIO;
@@ -632,9 +630,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 	rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
 
 	if ((rc != MBX_BUSY) && (rc != MBX_SUCCESS)) {
-		lpfc_printf_log(phba,
-				KERN_ERR,
-				LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0456 Adapter failed to issue "
 				"ASYNCEVT_ENABLE mbox status x%x\n",
 				rc);
@@ -654,7 +650,8 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 	rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
 
 	if ((rc != MBX_BUSY) && (rc != MBX_SUCCESS)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT, "0435 Adapter failed "
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"0435 Adapter failed "
 				"to get Option ROM version status x%x\n", rc);
 		mempool_free(pmb, phba->mbox_mem_pool);
 	}
@@ -732,10 +729,10 @@ lpfc_hba_init_link_fc_topology(struct lpfc_hba *phba, uint32_t fc_topology,
 	    ((phba->cfg_link_speed == LPFC_USER_LINK_SPEED_64G) &&
 	     !(phba->lmt & LMT_64Gb))) {
 		/* Reset link speed to auto */
-		lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
-			"1302 Invalid speed for this board:%d "
-			"Reset link speed to auto.\n",
-			phba->cfg_link_speed);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"1302 Invalid speed for this board:%d "
+				"Reset link speed to auto.\n",
+				phba->cfg_link_speed);
 			phba->cfg_link_speed = LPFC_USER_LINK_SPEED_AUTO;
 	}
 	lpfc_init_link(phba, pmb, fc_topology, phba->cfg_link_speed);
@@ -744,10 +741,10 @@ lpfc_hba_init_link_fc_topology(struct lpfc_hba *phba, uint32_t fc_topology,
 		lpfc_set_loopback_flag(phba);
 	rc = lpfc_sli_issue_mbox(phba, pmb, flag);
 	if ((rc != MBX_BUSY) && (rc != MBX_SUCCESS)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-			"0498 Adapter failed to init, mbxCmd x%x "
-			"INIT_LINK, mbxStatus x%x\n",
-			mb->mbxCommand, mb->mbxStatus);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"0498 Adapter failed to init, mbxCmd x%x "
+				"INIT_LINK, mbxStatus x%x\n",
+				mb->mbxCommand, mb->mbxStatus);
 		if (phba->sli_rev <= LPFC_SLI_REV3) {
 			/* Clear all interrupt enable conditions */
 			writel(0, phba->HCregaddr);
@@ -793,17 +790,15 @@ lpfc_hba_down_link(struct lpfc_hba *phba, uint32_t flag)
 		return -ENOMEM;
 	}
 
-	lpfc_printf_log(phba,
-		KERN_ERR, LOG_INIT,
-		"0491 Adapter Link is disabled.\n");
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+			"0491 Adapter Link is disabled.\n");
 	lpfc_down_link(phba, pmb);
 	pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 	rc = lpfc_sli_issue_mbox(phba, pmb, flag);
 	if ((rc != MBX_SUCCESS) && (rc != MBX_BUSY)) {
-		lpfc_printf_log(phba,
-		KERN_ERR, LOG_INIT,
-		"2522 Adapter failed to issue DOWN_LINK"
-		" mbox command rc 0x%x\n", rc);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2522 Adapter failed to issue DOWN_LINK"
+				" mbox command rc 0x%x\n", rc);
 
 		mempool_free(pmb, phba->mbox_mem_pool);
 		return -EIO;
@@ -1609,11 +1604,11 @@ lpfc_handle_deferred_eratt(struct lpfc_hba *phba)
 		return;
 	}
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-		"0479 Deferred Adapter Hardware Error "
-		"Data: x%x x%x x%x\n",
-		phba->work_hs,
-		phba->work_status[0], phba->work_status[1]);
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+			"0479 Deferred Adapter Hardware Error "
+			"Data: x%x x%x x%x\n",
+			phba->work_hs, phba->work_status[0],
+			phba->work_status[1]);
 
 	spin_lock_irq(&phba->hbalock);
 	psli->sli_flag &= ~LPFC_SLI_ACTIVE;
@@ -1764,7 +1759,7 @@ lpfc_handle_eratt_s3(struct lpfc_hba *phba)
 		temp_event_data.event_code = LPFC_CRIT_TEMP;
 		temp_event_data.data = (uint32_t)temperature;
 
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0406 Adapter maximum temperature exceeded "
 				"(%ld), taking this port offline "
 				"Data: x%x x%x x%x\n",
@@ -1788,7 +1783,7 @@ lpfc_handle_eratt_s3(struct lpfc_hba *phba)
 		 * failure is a value other than FFER6. Do not call the offline
 		 * twice. This is the adapter hardware error path.
 		 */
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0457 Adapter Hardware Error "
 				"Data: x%x x%x x%x\n",
 				phba->work_hs,
@@ -1836,7 +1831,7 @@ lpfc_sli4_port_sta_fn_reset(struct lpfc_hba *phba, int mbx_action,
 
 	/* need reset: attempt for port recovery */
 	if (en_rn_msg)
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2887 Reset Needed: Attempting Port "
 				"Recovery...\n");
 	lpfc_offline_prep(phba, mbx_action);
@@ -1846,14 +1841,14 @@ lpfc_sli4_port_sta_fn_reset(struct lpfc_hba *phba, int mbx_action,
 	lpfc_sli4_disable_intr(phba);
 	rc = lpfc_sli_brdrestart(phba);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6309 Failed to restart board\n");
 		return rc;
 	}
 	/* request and enable interrupt */
 	intr_mode = lpfc_sli4_enable_intr(phba, phba->intr_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3175 Failed to enable interrupt\n");
 		return -EIO;
 	}
@@ -1892,7 +1887,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 	 * we cannot communicate with the pci card anyway.
 	 */
 	if (pci_channel_offline(phba->pcidev)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3166 pci channel is offline\n");
 		lpfc_sli4_offline_eratt(phba);
 		return;
@@ -1915,7 +1910,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 			lpfc_sli4_offline_eratt(phba);
 			return;
 		}
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"7623 Checking UE recoverable");
 
 		for (i = 0; i < phba->sli4_hba.ue_to_sr / 1000; i++) {
@@ -1932,7 +1927,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 			msleep(1000);
 		}
 
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"4827 smphr_port_status x%x : Waited %dSec",
 				smphr_port_status, i);
 
@@ -1950,14 +1945,14 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 						LPFC_MBX_NO_WAIT, en_rn_msg);
 					if (rc == 0)
 						return;
-					lpfc_printf_log(phba,
-						KERN_ERR, LOG_INIT,
+					lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"4215 Failed to recover UE");
 					break;
 				}
 			}
 		}
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"7624 Firmware not ready: Failing UE recovery,"
 				" waited %dSec", i);
 		phba->link_state = LPFC_HBA_ERROR;
@@ -1970,7 +1965,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 				&portstat_reg.word0);
 		/* consider PCI bus read error as pci_channel_offline */
 		if (pci_rd_rc1 == -EIO) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3151 PCI bus read access failure: x%x\n",
 				readl(phba->sli4_hba.u.if_type2.STATUSregaddr));
 			lpfc_sli4_offline_eratt(phba);
@@ -1979,10 +1974,10 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 		reg_err1 = readl(phba->sli4_hba.u.if_type2.ERR1regaddr);
 		reg_err2 = readl(phba->sli4_hba.u.if_type2.ERR2regaddr);
 		if (bf_get(lpfc_sliport_status_oti, &portstat_reg)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-				"2889 Port Overtemperature event, "
-				"taking port offline Data: x%x x%x\n",
-				reg_err1, reg_err2);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"2889 Port Overtemperature event, "
+					"taking port offline Data: x%x x%x\n",
+					reg_err1, reg_err2);
 
 			phba->sfp_alarm |= LPFC_TRANSGRESSION_HIGH_TEMPERATURE;
 			temp_event_data.event_type = FC_REG_TEMPERATURE_EVENT;
@@ -2004,17 +1999,17 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 		}
 		if (reg_err1 == SLIPORT_ERR1_REG_ERR_CODE_2 &&
 		    reg_err2 == SLIPORT_ERR2_REG_FW_RESTART) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3143 Port Down: Firmware Update "
 					"Detected\n");
 			en_rn_msg = false;
 		} else if (reg_err1 == SLIPORT_ERR1_REG_ERR_CODE_2 &&
 			 reg_err2 == SLIPORT_ERR2_REG_FORCED_DUMP)
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3144 Port Down: Debug Dump\n");
 		else if (reg_err1 == SLIPORT_ERR1_REG_ERR_CODE_2 &&
 			 reg_err2 == SLIPORT_ERR2_REG_FUNC_PROVISON)
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3145 Port Down: Provisioning\n");
 
 		/* If resets are disabled then leave the HBA alone and return */
@@ -2033,7 +2028,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 				break;
 		}
 		/* fall through for not able to recover */
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3152 Unrecoverable error\n");
 		phba->link_state = LPFC_HBA_ERROR;
 		break;
@@ -2151,8 +2146,8 @@ lpfc_handle_latt(struct lpfc_hba *phba)
 	lpfc_linkdown(phba);
 	phba->link_state = LPFC_HBA_ERROR;
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
-		     "0300 LATT: Cannot issue READ_LA: Data:%d\n", rc);
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+			"0300 LATT: Cannot issue READ_LA: Data:%d\n", rc);
 
 	return;
 }
@@ -2901,12 +2896,13 @@ lpfc_cleanup(struct lpfc_vport *vport)
 	 */
 	while (!list_empty(&vport->fc_nodes)) {
 		if (i++ > 3000) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+			lpfc_printf_vlog(vport, KERN_ERR,
+					 LOG_TRACE_EVENT,
 				"0233 Nodelist not empty\n");
 			list_for_each_entry_safe(ndlp, next_ndlp,
 						&vport->fc_nodes, nlp_listp) {
 				lpfc_printf_vlog(ndlp->vport, KERN_ERR,
-						LOG_NODE,
+						LOG_TRACE_EVENT,
 						"0282 did:x%x ndlp:x%px "
 						"usgmap:x%x refcnt:%d\n",
 						ndlp->nlp_DID, (void *)ndlp,
@@ -3014,7 +3010,7 @@ lpfc_stop_hba_timers(struct lpfc_hba *phba)
 		lpfc_sli4_stop_fcf_redisc_wait_timer(phba);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0297 Invalid device group (x%x)\n",
 				phba->pci_dev_grp);
 		break;
@@ -3061,10 +3057,10 @@ lpfc_block_mgmt_io(struct lpfc_hba *phba, int mbx_action)
 		/* Check active mailbox complete status every 2ms */
 		msleep(2);
 		if (time_after(jiffies, timeout)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
-				"2813 Mgmt IO is Blocked %x "
-				"- mbox cmd %x still active\n",
-				phba->sli.sli_flag, actcmd);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"2813 Mgmt IO is Blocked %x "
+					"- mbox cmd %x still active\n",
+					phba->sli.sli_flag, actcmd);
 			break;
 		}
 	}
@@ -3409,7 +3405,7 @@ lpfc_online(struct lpfc_hba *phba)
 				!phba->nvmet_support) {
 			error = lpfc_nvme_create_localport(phba->pport);
 			if (error)
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6132 NVME restore reg failed "
 					"on nvmei error x%x\n", error);
 		}
@@ -3749,7 +3745,8 @@ lpfc_sli4_els_sgl_update(struct lpfc_hba *phba)
 			sglq_entry = kzalloc(sizeof(struct lpfc_sglq),
 					     GFP_KERNEL);
 			if (sglq_entry == NULL) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"2562 Failure to allocate an "
 						"ELS sgl entry:%d\n", i);
 				rc = -ENOMEM;
@@ -3760,7 +3757,8 @@ lpfc_sli4_els_sgl_update(struct lpfc_hba *phba)
 							   &sglq_entry->phys);
 			if (sglq_entry->virt == NULL) {
 				kfree(sglq_entry);
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"2563 Failure to allocate an "
 						"ELS mbuf:%d\n", i);
 				rc = -ENOMEM;
@@ -3815,7 +3813,8 @@ lpfc_sli4_els_sgl_update(struct lpfc_hba *phba)
 				 &phba->sli4_hba.lpfc_els_sgl_list, list) {
 		lxri = lpfc_sli4_next_xritag(phba);
 		if (lxri == NO_XRI) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"2400 Failed to allocate xri for "
 					"ELS sgl\n");
 			rc = -ENOMEM;
@@ -3870,7 +3869,8 @@ lpfc_sli4_nvmet_sgl_update(struct lpfc_hba *phba)
 			sglq_entry = kzalloc(sizeof(struct lpfc_sglq),
 					     GFP_KERNEL);
 			if (sglq_entry == NULL) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"6303 Failure to allocate an "
 						"NVMET sgl entry:%d\n", i);
 				rc = -ENOMEM;
@@ -3881,7 +3881,8 @@ lpfc_sli4_nvmet_sgl_update(struct lpfc_hba *phba)
 							   &sglq_entry->phys);
 			if (sglq_entry->virt == NULL) {
 				kfree(sglq_entry);
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"6304 Failure to allocate an "
 						"NVMET buf:%d\n", i);
 				rc = -ENOMEM;
@@ -3937,7 +3938,8 @@ lpfc_sli4_nvmet_sgl_update(struct lpfc_hba *phba)
 				 &phba->sli4_hba.lpfc_nvmet_sgl_list, list) {
 		lxri = lpfc_sli4_next_xritag(phba);
 		if (lxri == NO_XRI) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"6307 Failed to allocate xri for "
 					"NVMET sgl\n");
 			rc = -ENOMEM;
@@ -4111,7 +4113,8 @@ lpfc_sli4_io_sgl_update(struct lpfc_hba *phba)
 				 &io_sgl_list, list) {
 		lxri = lpfc_sli4_next_xritag(phba);
 		if (lxri == NO_XRI) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"6075 Failed to allocate xri for "
 					"nvme buffer\n");
 			rc = -ENOMEM;
@@ -4181,7 +4184,8 @@ lpfc_new_io_buf(struct lpfc_hba *phba, int num_to_alloc)
 			if ((phba->sli3_options & LPFC_SLI3_BG_ENABLED) &&
 			    (((unsigned long)(lpfc_ncmd->data) &
 			    (unsigned long)(SLI4_PAGE_SIZE - 1)) != 0)) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"3369 Memory alignment err: "
 						"addr=%lx\n",
 						(unsigned long)lpfc_ncmd->data);
@@ -4210,7 +4214,7 @@ lpfc_new_io_buf(struct lpfc_hba *phba, int num_to_alloc)
 			dma_pool_free(phba->lpfc_sg_dma_buf_pool,
 				      lpfc_ncmd->data, lpfc_ncmd->dma_handle);
 			kfree(lpfc_ncmd);
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6121 Failed to allocate IOTAG for"
 					" XRI:0x%x\n", lxri);
 			lpfc_sli4_free_xri(phba, lxri);
@@ -4261,7 +4265,7 @@ lpfc_get_wwpn(struct lpfc_hba *phba)
 	lpfc_read_nv(phba, mboxq);
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 	if (rc != MBX_SUCCESS) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6019 Mailbox failed , mbxCmd x%x "
 				"READ_NV, mbxStatus x%x\n",
 				bf_get(lpfc_mqe_command, &mboxq->u.mqe),
@@ -4321,7 +4325,8 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 
 	for (i = 0; i < lpfc_no_hba_reset_cnt; i++) {
 		if (wwn == lpfc_no_hba_reset[i]) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"6020 Setting use_no_reset port=%llx\n",
 					wwn);
 			use_no_reset_hba = true;
@@ -4766,7 +4771,7 @@ lpfc_sli4_parse_latt_fault(struct lpfc_hba *phba,
 	case LPFC_ASYNC_LINK_FAULT_LR_LRR:
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0398 Unknown link fault code: x%x\n",
 				bf_get(lpfc_acqe_link_fault, acqe_link));
 		break;
@@ -4802,7 +4807,7 @@ lpfc_sli4_parse_latt_type(struct lpfc_hba *phba,
 		att_type = LPFC_ATT_LINK_UP;
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0399 Invalid link attention type: x%x\n",
 				bf_get(lpfc_acqe_link_status, acqe_link));
 		att_type = LPFC_ATT_RESERVED;
@@ -4974,19 +4979,19 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	phba->fcoe_eventtag = acqe_link->event_tag;
 	pmb = (LPFC_MBOXQ_t *)mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!pmb) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0395 The mboxq allocation failed\n");
 		return;
 	}
 	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
 	if (!mp) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0396 The lpfc_dmabuf allocation failed\n");
 		goto out_free_pmb;
 	}
 	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
 	if (!mp->virt) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0397 The mbuf allocation failed\n");
 		goto out_free_dmabuf;
 	}
@@ -5187,7 +5192,7 @@ lpfc_update_trunk_link_status(struct lpfc_hba *phba,
 		phba->trunk_link.link3.fault = port_fault & 0x8 ? err : 0;
 	}
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2910 Async FC Trunking Event - Speed:%d\n"
 			"\tLogical speed:%d "
 			"port0: %s port1: %s port2: %s port3: %s\n",
@@ -5197,7 +5202,7 @@ lpfc_update_trunk_link_status(struct lpfc_hba *phba,
 			trunk_link_status(2), trunk_link_status(3));
 
 	if (port_fault)
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3202 trunk error:0x%x (%s) seen on port0:%s "
 				/*
 				 * SLI-4: We have only 0xA error codes
@@ -5231,7 +5236,7 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 
 	if (bf_get(lpfc_trailer_type, acqe_fc) !=
 	    LPFC_FC_LA_EVENT_TYPE_FC_LINK) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2895 Non FC link Event detected.(%d)\n",
 				bf_get(lpfc_trailer_type, acqe_fc));
 		return;
@@ -5279,19 +5284,19 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 			phba->sli4_hba.link_state.fault);
 	pmb = (LPFC_MBOXQ_t *)mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!pmb) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2897 The mboxq allocation failed\n");
 		return;
 	}
 	mp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
 	if (!mp) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2898 The lpfc_dmabuf allocation failed\n");
 		goto out_free_pmb;
 	}
 	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
 	if (!mp->virt) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2899 The mbuf allocation failed\n");
 		goto out_free_dmabuf;
 	}
@@ -5458,7 +5463,7 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 					&misconfigured->theEvent);
 			break;
 		default:
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3296 "
 					"LPFC_SLI_EVENT_TYPE_MISCONFIGURED "
 					"event: Invalid link %d",
@@ -5510,7 +5515,8 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 		rc = lpfc_sli4_read_config(phba);
 		if (rc) {
 			phba->lmt = 0;
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"3194 Unable to retrieve supported "
 					"speeds, rc = 0x%x\n", rc);
 		}
@@ -5662,8 +5668,7 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 	case LPFC_FIP_EVENT_TYPE_NEW_FCF:
 	case LPFC_FIP_EVENT_TYPE_FCF_PARAM_MOD:
 		if (event_type == LPFC_FIP_EVENT_TYPE_NEW_FCF)
-			lpfc_printf_log(phba, KERN_ERR, LOG_FIP |
-					LOG_DISCOVERY,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2546 New FCF event, evt_tag:x%x, "
 					"index:x%x\n",
 					acqe_fip->event_tag,
@@ -5716,23 +5721,24 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 		rc = lpfc_sli4_fcf_scan_read_fcf_rec(phba,
 						     LPFC_FCOE_FCF_GET_FIRST);
 		if (rc)
-			lpfc_printf_log(phba, KERN_ERR, LOG_FIP | LOG_DISCOVERY,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2547 Issue FCF scan read FCF mailbox "
 					"command failed (x%x)\n", rc);
 		break;
 
 	case LPFC_FIP_EVENT_TYPE_FCF_TABLE_FULL:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
-			"2548 FCF Table full count 0x%x tag 0x%x\n",
-			bf_get(lpfc_acqe_fip_fcf_count, acqe_fip),
-			acqe_fip->event_tag);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2548 FCF Table full count 0x%x tag 0x%x\n",
+				bf_get(lpfc_acqe_fip_fcf_count, acqe_fip),
+				acqe_fip->event_tag);
 		break;
 
 	case LPFC_FIP_EVENT_TYPE_FCF_DEAD:
 		phba->fcoe_cvl_eventtag = acqe_fip->event_tag;
-		lpfc_printf_log(phba, KERN_ERR, LOG_FIP | LOG_DISCOVERY,
-			"2549 FCF (x%x) disconnected from network, "
-			"tag:x%x\n", acqe_fip->index, acqe_fip->event_tag);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2549 FCF (x%x) disconnected from network, "
+				 "tag:x%x\n", acqe_fip->index,
+				 acqe_fip->event_tag);
 		/*
 		 * If we are in the middle of FCF failover process, clear
 		 * the corresponding FCF bit in the roundrobin bitmap.
@@ -5769,7 +5775,7 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 		rc = lpfc_sli4_redisc_fcf_table(phba);
 		if (rc) {
 			lpfc_printf_log(phba, KERN_ERR, LOG_FIP |
-					LOG_DISCOVERY,
+					LOG_TRACE_EVENT,
 					"2772 Issue FCF rediscover mailbox "
 					"command failed, fail through to FCF "
 					"dead event\n");
@@ -5793,7 +5799,8 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 		break;
 	case LPFC_FIP_EVENT_TYPE_CVL:
 		phba->fcoe_cvl_eventtag = acqe_fip->event_tag;
-		lpfc_printf_log(phba, KERN_ERR, LOG_FIP | LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR,
+				LOG_TRACE_EVENT,
 			"2718 Clear Virtual Link Received for VPI 0x%x"
 			" tag 0x%x\n", acqe_fip->index, acqe_fip->event_tag);
 
@@ -5860,7 +5867,7 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 			rc = lpfc_sli4_redisc_fcf_table(phba);
 			if (rc) {
 				lpfc_printf_log(phba, KERN_ERR, LOG_FIP |
-						LOG_DISCOVERY,
+						LOG_TRACE_EVENT,
 						"2774 Issue FCF rediscover "
 						"mailbox command failed, "
 						"through to CVL event\n");
@@ -5881,9 +5888,9 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 		}
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
-			"0288 Unknown FCoE event type 0x%x event tag "
-			"0x%x\n", event_type, acqe_fip->event_tag);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"0288 Unknown FCoE event type 0x%x event tag "
+				"0x%x\n", event_type, acqe_fip->event_tag);
 		break;
 	}
 }
@@ -5900,7 +5907,7 @@ lpfc_sli4_async_dcbx_evt(struct lpfc_hba *phba,
 			 struct lpfc_acqe_dcbx *acqe_dcbx)
 {
 	phba->fc_eventTag = acqe_dcbx->event_tag;
-	lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0290 The SLI4 DCBX asynchronous event is not "
 			"handled yet\n");
 }
@@ -5977,7 +5984,8 @@ void lpfc_sli4_async_event_proc(struct lpfc_hba *phba)
 			lpfc_sli4_async_sli_evt(phba, &cq_event->cqe.acqe_sli);
 			break;
 		default:
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"1804 Invalid asynchronous event code: "
 					"x%x\n", bf_get(lpfc_trailer_code,
 					&cq_event->cqe.mcqe_cmpl));
@@ -6013,7 +6021,7 @@ void lpfc_sli4_fcf_redisc_event_proc(struct lpfc_hba *phba)
 			"2777 Start post-quiescent FCF table scan\n");
 	rc = lpfc_sli4_fcf_scan_read_fcf_rec(phba, LPFC_FCOE_FCF_GET_FIRST);
 	if (rc)
-		lpfc_printf_log(phba, KERN_ERR, LOG_FIP | LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2747 Issue FCF scan read FCF mailbox "
 				"command failed 0x%x\n", rc);
 }
@@ -6084,7 +6092,7 @@ static void lpfc_log_intr_mode(struct lpfc_hba *phba, uint32_t intr_mode)
 				"0480 Enabled MSI-X interrupt mode.\n");
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0482 Illegal interrupt mode.\n");
 		break;
 	}
@@ -6132,7 +6140,7 @@ lpfc_enable_pci_dev(struct lpfc_hba *phba)
 out_disable_device:
 	pci_disable_device(pdev);
 out_error:
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"1401 Failed to enable pci device\n");
 	return -ENODEV;
 }
@@ -6233,7 +6241,7 @@ lpfc_sli_probe_sriov_nr_virtfn(struct lpfc_hba *phba, int nr_vfn)
 
 	max_nr_vfn = lpfc_sli_sriov_nr_virtfn_get(phba);
 	if (nr_vfn > max_nr_vfn) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3057 Requested vfs (%d) greater than "
 				"supported vfs (%d)", nr_vfn, max_nr_vfn);
 		return -EINVAL;
@@ -6272,6 +6280,9 @@ lpfc_setup_driver_resource_phase1(struct lpfc_hba *phba)
 	 * Driver resources common to all SLI revisions
 	 */
 	atomic_set(&phba->fast_event_count, 0);
+	atomic_set(&phba->dbg_log_idx, 0);
+	atomic_set(&phba->dbg_log_cnt, 0);
+	atomic_set(&phba->dbg_log_dmping, 0);
 	spin_lock_init(&phba->hbalock);
 
 	/* Initialize ndlp management spinlock */
@@ -6699,7 +6710,8 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		lpfc_read_nv(phba, mboxq);
 		rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"6016 Mailbox failed , mbxCmd x%x "
 					"READ_NV, mbxStatus x%x\n",
 					bf_get(lpfc_mqe_command, &mboxq->u.mqe),
@@ -6728,11 +6740,13 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 
 				phba->nvmet_support = 1; /* a match */
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"6017 NVME Target %016llx\n",
 						wwn);
 #else
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"6021 Can't enable NVME Target."
 						" NVME_TARGET_FC infrastructure"
 						" is not in kernel\n");
@@ -6792,9 +6806,9 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 				&phba->sli4_hba.sli_intf);
 		if (phba->sli4_hba.extents_in_use &&
 		    phba->sli4_hba.rpi_hdrs_in_use) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-				"2999 Unsupported SLI4 Parameters "
-				"Extents and RPI headers enabled.\n");
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"2999 Unsupported SLI4 Parameters "
+					"Extents and RPI headers enabled.\n");
 			if (if_type == LPFC_SLI_INTF_IF_TYPE_0 &&
 			    if_fam ==  LPFC_SLI_INTF_FAMILY_BE2) {
 				mempool_free(mboxq, phba->mbox_mem_pool);
@@ -6954,13 +6968,13 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	/* Allocate and initialize active sgl array */
 	rc = lpfc_init_active_sgl_array(phba);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1430 Failed to initialize sgl list.\n");
 		goto out_destroy_cq_event_pool;
 	}
 	rc = lpfc_sli4_init_rpi_hdrs(phba);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1432 Failed to initialize rpi headers.\n");
 		goto out_free_active_sgl;
 	}
@@ -6970,7 +6984,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	phba->fcf.fcf_rr_bmask = kcalloc(longs, sizeof(unsigned long),
 					 GFP_KERNEL);
 	if (!phba->fcf.fcf_rr_bmask) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2759 Failed allocate memory for FCF round "
 				"robin failover bmask\n");
 		rc = -ENOMEM;
@@ -6981,7 +6995,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 					    sizeof(struct lpfc_hba_eq_hdl),
 					    GFP_KERNEL);
 	if (!phba->sli4_hba.hba_eq_hdl) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2572 Failed allocate memory for "
 				"fast-path per-EQ handle array\n");
 		rc = -ENOMEM;
@@ -6992,7 +7006,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 					sizeof(struct lpfc_vector_map_info),
 					GFP_KERNEL);
 	if (!phba->sli4_hba.cpu_map) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3327 Failed allocate memory for msi-x "
 				"interrupt vector mapping\n");
 		rc = -ENOMEM;
@@ -7001,7 +7015,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 
 	phba->sli4_hba.eq_info = alloc_percpu(struct lpfc_eq_intr_info);
 	if (!phba->sli4_hba.eq_info) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3321 Failed allocation for per_cpu stats\n");
 		rc = -ENOMEM;
 		goto out_free_hba_cpu_map;
@@ -7011,7 +7025,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 					   sizeof(*phba->sli4_hba.idle_stat),
 					   GFP_KERNEL);
 	if (!phba->sli4_hba.idle_stat) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3390 Failed allocation for idle_stat\n");
 		rc = -ENOMEM;
 		goto out_free_hba_eq_info;
@@ -7020,7 +7034,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	phba->sli4_hba.c_stat = alloc_percpu(struct lpfc_hdwq_stat);
 	if (!phba->sli4_hba.c_stat) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3332 Failed allocating per cpu hdwq stats\n");
 		rc = -ENOMEM;
 		goto out_free_hba_idle_stat;
@@ -7168,7 +7182,7 @@ lpfc_init_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->lpfc_stop_port = lpfc_stop_port_s4;
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1431 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
@@ -7463,7 +7477,7 @@ lpfc_sli4_init_rpi_hdrs(struct lpfc_hba *phba)
 
 	rpi_hdr = lpfc_sli4_create_rpi_hdr(phba);
 	if (!rpi_hdr) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0391 Error during rpi post operation\n");
 		lpfc_sli4_remove_rpis(phba);
 		rc = -ENODEV;
@@ -7775,7 +7789,7 @@ lpfc_setup_bg(struct lpfc_hba *phba, struct Scsi_Host *shost)
 		if (phba->cfg_prot_mask && phba->cfg_prot_guard) {
 			if ((old_mask != phba->cfg_prot_mask) ||
 				(old_guard != phba->cfg_prot_guard))
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"1475 Registering BlockGuard with the "
 					"SCSI layer: mask %d  guard %d\n",
 					phba->cfg_prot_mask,
@@ -7784,7 +7798,7 @@ lpfc_setup_bg(struct lpfc_hba *phba, struct Scsi_Host *shost)
 			scsi_host_set_prot(shost, phba->cfg_prot_mask);
 			scsi_host_set_guard(shost, phba->cfg_prot_guard);
 		} else
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1479 Not Registering BlockGuard with the SCSI "
 				"layer, Bad protection parameters: %d %d\n",
 				old_mask, old_guard);
@@ -8015,7 +8029,7 @@ lpfc_sli4_post_status_check(struct lpfc_hba *phba)
 	 * other register reads as the data may not be valid.  Just exit.
 	 */
 	if (port_error) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"1408 Port Failed POST - portsmphr=0x%x, "
 			"perr=x%x, sfi=x%x, nip=x%x, ipc=x%x, scr1=x%x, "
 			"scr2=x%x, hscratch=x%x, pstatus=x%x\n",
@@ -8064,7 +8078,8 @@ lpfc_sli4_post_status_check(struct lpfc_hba *phba)
 				readl(phba->sli4_hba.u.if_type0.UERRHIregaddr);
 			if ((~phba->sli4_hba.ue_mask_lo & uerrlo_reg.word0) ||
 			    (~phba->sli4_hba.ue_mask_hi & uerrhi_reg.word0)) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"1422 Unrecoverable Error "
 						"Detected during POST "
 						"uerr_lo_reg=0x%x, "
@@ -8091,7 +8106,7 @@ lpfc_sli4_post_status_check(struct lpfc_hba *phba)
 				phba->work_status[1] =
 					readl(phba->sli4_hba.u.if_type2.
 					      ERR2regaddr);
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2888 Unrecoverable port error "
 					"following POST: port status reg "
 					"0x%x, port_smphr reg 0x%x, "
@@ -8485,7 +8500,7 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 
 	pmb = (LPFC_MBOXQ_t *) mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!pmb) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2011 Unable to allocate memory for issuing "
 				"SLI_CONFIG_SPECIAL mailbox command\n");
 		return -ENOMEM;
@@ -8495,11 +8510,11 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 
 	rc = lpfc_sli_issue_mbox(phba, pmb, MBX_POLL);
 	if (rc != MBX_SUCCESS) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
-			"2012 Mailbox failed , mbxCmd x%x "
-			"READ_CONFIG, mbxStatus x%x\n",
-			bf_get(lpfc_mqe_command, &pmb->u.mqe),
-			bf_get(lpfc_mqe_status, &pmb->u.mqe));
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"2012 Mailbox failed , mbxCmd x%x "
+				"READ_CONFIG, mbxStatus x%x\n",
+				bf_get(lpfc_mqe_command, &pmb->u.mqe),
+				bf_get(lpfc_mqe_status, &pmb->u.mqe));
 		rc = -EIO;
 	} else {
 		rd_config = &pmb->u.mqe.un.rd_config;
@@ -8609,7 +8624,7 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 		/* Check to see if there is enough for NVME */
 		if ((phba->cfg_irq_chann > qmin) ||
 		    (phba->cfg_hdw_queue > qmin)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2005 Reducing Queues: "
 					"WQ %d CQ %d EQ %d: min %d: "
 					"IRQ %d HDWQ %d\n",
@@ -8675,7 +8690,8 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 					LPFC_USER_LINK_SPEED_AUTO;
 				break;
 			default:
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
 						"0047 Unrecognized link "
 						"speed : %d\n",
 						forced_link_speed);
@@ -8712,7 +8728,7 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (rc2 || shdr_status || shdr_add_status) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3026 Mailbox failed , mbxCmd x%x "
 				"GET_FUNCTION_CONFIG, mbxStatus x%x\n",
 				bf_get(lpfc_mqe_command, &pmb->u.mqe),
@@ -8749,7 +8765,7 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 				"vf_number:%d\n", phba->sli4_hba.iov.pf_number,
 				phba->sli4_hba.iov.vf_number);
 	else
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3028 GET_FUNCTION_CONFIG: failed to find "
 				"Resource Descriptor:x%x\n",
 				LPFC_RSRC_DESC_TYPE_FCFCOE);
@@ -8786,7 +8802,7 @@ lpfc_setup_endian_order(struct lpfc_hba *phba)
 		mboxq = (LPFC_MBOXQ_t *) mempool_alloc(phba->mbox_mem_pool,
 						       GFP_KERNEL);
 		if (!mboxq) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0492 Unable to allocate memory for "
 					"issuing SLI_CONFIG_SPECIAL mailbox "
 					"command\n");
@@ -8801,7 +8817,7 @@ lpfc_setup_endian_order(struct lpfc_hba *phba)
 		memcpy(&mboxq->u.mqe, &endian_mb_data, sizeof(endian_mb_data));
 		rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0493 SLI_CONFIG_SPECIAL mailbox "
 					"failed with status x%x\n",
 					rc);
@@ -8881,8 +8897,9 @@ lpfc_alloc_io_wq_cq(struct lpfc_hba *phba, int idx)
 					      phba->sli4_hba.cq_esize,
 					      phba->sli4_hba.cq_ecount, cpu);
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-			"0499 Failed allocate fast-path IO CQ (%d)\n", idx);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"0499 Failed allocate fast-path IO CQ (%d)\n",
+				idx);
 		return 1;
 	}
 	qdesc->qe_valid = 1;
@@ -8904,7 +8921,7 @@ lpfc_alloc_io_wq_cq(struct lpfc_hba *phba, int idx)
 					      phba->sli4_hba.wq_ecount, cpu);
 
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0503 Failed allocate fast-path IO WQ (%d)\n",
 				idx);
 		return 1;
@@ -8960,7 +8977,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 			phba->cfg_hdw_queue, sizeof(struct lpfc_sli4_hdw_queue),
 			GFP_KERNEL);
 		if (!phba->sli4_hba.hdwq) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6427 Failed allocate memory for "
 					"fast-path Hardware Queue array\n");
 			goto out_error;
@@ -8992,7 +9009,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					sizeof(struct lpfc_queue *),
 					GFP_KERNEL);
 			if (!phba->sli4_hba.nvmet_cqset) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3121 Fail allocate memory for "
 					"fast-path CQ set array\n");
 				goto out_error;
@@ -9002,7 +9019,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					sizeof(struct lpfc_queue *),
 					GFP_KERNEL);
 			if (!phba->sli4_hba.nvmet_mrq_hdr) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3122 Fail allocate memory for "
 					"fast-path RQ set hdr array\n");
 				goto out_error;
@@ -9012,7 +9029,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					sizeof(struct lpfc_queue *),
 					GFP_KERNEL);
 			if (!phba->sli4_hba.nvmet_mrq_data) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3124 Fail allocate memory for "
 					"fast-path RQ set data array\n");
 				goto out_error;
@@ -9040,7 +9057,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					      phba->sli4_hba.eq_esize,
 					      phba->sli4_hba.eq_ecount, cpu);
 		if (!qdesc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0497 Failed allocate EQ (%d)\n",
 					cpup->hdwq);
 			goto out_error;
@@ -9094,7 +9111,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 						      phba->sli4_hba.cq_ecount,
 						      cpu);
 			if (!qdesc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3142 Failed allocate NVME "
 						"CQ Set (%d)\n", idx);
 				goto out_error;
@@ -9116,7 +9133,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				      phba->sli4_hba.cq_esize,
 				      phba->sli4_hba.cq_ecount, cpu);
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0500 Failed allocate slow-path mailbox CQ\n");
 		goto out_error;
 	}
@@ -9128,7 +9145,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				      phba->sli4_hba.cq_esize,
 				      phba->sli4_hba.cq_ecount, cpu);
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0501 Failed allocate slow-path ELS CQ\n");
 		goto out_error;
 	}
@@ -9147,7 +9164,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				      phba->sli4_hba.mq_esize,
 				      phba->sli4_hba.mq_ecount, cpu);
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0505 Failed allocate slow-path MQ\n");
 		goto out_error;
 	}
@@ -9163,7 +9180,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				      phba->sli4_hba.wq_esize,
 				      phba->sli4_hba.wq_ecount, cpu);
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0504 Failed allocate slow-path ELS WQ\n");
 		goto out_error;
 	}
@@ -9177,7 +9194,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					      phba->sli4_hba.cq_esize,
 					      phba->sli4_hba.cq_ecount, cpu);
 		if (!qdesc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6079 Failed allocate NVME LS CQ\n");
 			goto out_error;
 		}
@@ -9190,7 +9207,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 					      phba->sli4_hba.wq_esize,
 					      phba->sli4_hba.wq_ecount, cpu);
 		if (!qdesc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6080 Failed allocate NVME LS WQ\n");
 			goto out_error;
 		}
@@ -9208,7 +9225,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				      phba->sli4_hba.rq_esize,
 				      phba->sli4_hba.rq_ecount, cpu);
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0506 Failed allocate receive HRQ\n");
 		goto out_error;
 	}
@@ -9219,7 +9236,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 				      phba->sli4_hba.rq_esize,
 				      phba->sli4_hba.rq_ecount, cpu);
 	if (!qdesc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0507 Failed allocate receive DRQ\n");
 		goto out_error;
 	}
@@ -9237,7 +9254,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 						      LPFC_NVMET_RQE_DEF_COUNT,
 						      cpu);
 			if (!qdesc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3146 Failed allocate "
 						"receive HRQ\n");
 				goto out_error;
@@ -9250,7 +9267,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 						   GFP_KERNEL,
 						   cpu_to_node(cpu));
 			if (qdesc->rqbp == NULL) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6131 Failed allocate "
 						"Header RQBP\n");
 				goto out_error;
@@ -9266,7 +9283,7 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 						      LPFC_NVMET_RQE_DEF_COUNT,
 						      cpu);
 			if (!qdesc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3156 Failed allocate "
 						"receive DRQ\n");
 				goto out_error;
@@ -9457,7 +9474,7 @@ lpfc_create_wq_cq(struct lpfc_hba *phba, struct lpfc_queue *eq,
 	int rc;
 
 	if (!eq || !cq || !wq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6085 Fast-path %s (%d) not allocated\n",
 			((eq) ? ((cq) ? "WQ" : "CQ") : "EQ"), qidx);
 		return -ENOMEM;
@@ -9467,9 +9484,9 @@ lpfc_create_wq_cq(struct lpfc_hba *phba, struct lpfc_queue *eq,
 	rc = lpfc_cq_create(phba, cq, eq,
 			(qtype == LPFC_MBOX) ? LPFC_MCQ : LPFC_WCQ, qtype);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-			"6086 Failed setup of CQ (%d), rc = 0x%x\n",
-			qidx, (uint32_t)rc);
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"6086 Failed setup of CQ (%d), rc = 0x%x\n",
+				qidx, (uint32_t)rc);
 		return rc;
 	}
 
@@ -9485,7 +9502,7 @@ lpfc_create_wq_cq(struct lpfc_hba *phba, struct lpfc_queue *eq,
 		/* create the wq */
 		rc = lpfc_wq_create(phba, wq, cq, qtype);
 		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"4618 Fail setup fastpath WQ (%d), rc = 0x%x\n",
 				qidx, (uint32_t)rc);
 			/* no need to tear down cq - caller will do so */
@@ -9503,9 +9520,9 @@ lpfc_create_wq_cq(struct lpfc_hba *phba, struct lpfc_queue *eq,
 	} else {
 		rc = lpfc_mq_create(phba, wq, cq, LPFC_MBOX);
 		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-				"0539 Failed setup of slow-path MQ: "
-				"rc = 0x%x\n", rc);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"0539 Failed setup of slow-path MQ: "
+					"rc = 0x%x\n", rc);
 			/* no need to tear down cq - caller will do so */
 			return rc;
 		}
@@ -9578,7 +9595,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	/* Check for dual-ULP support */
 	mboxq = (LPFC_MBOXQ_t *)mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3249 Unable to allocate memory for "
 				"QUERY_FW_CFG mailbox command\n");
 		return -ENOMEM;
@@ -9596,7 +9613,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3250 QUERY_FW_CFG mailbox failed with status "
 				"x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -9627,7 +9644,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 
 	/* Set up HBA event queue */
 	if (!qp) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3147 Fast-path EQs not allocated\n");
 		rc = -ENOMEM;
 		goto out_error;
@@ -9651,7 +9668,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 			rc = lpfc_eq_create(phba, qp[cpup->hdwq].hba_eq,
 					    phba->cfg_fcp_imax);
 			if (rc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"0523 Failed setup of fast-path"
 						" EQ (%d), rc = 0x%x\n",
 						cpup->eq, (uint32_t)rc);
@@ -9683,7 +9700,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 				       qidx,
 				       LPFC_IO);
 		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0535 Failed to setup fastpath "
 					"IO WQ/CQ (%d), rc = 0x%x\n",
 					qidx, (uint32_t)rc);
@@ -9698,7 +9715,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	/* Set up slow-path MBOX CQ/MQ */
 
 	if (!phba->sli4_hba.mbx_cq || !phba->sli4_hba.mbx_wq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0528 %s not allocated\n",
 				phba->sli4_hba.mbx_cq ?
 				"Mailbox WQ" : "Mailbox CQ");
@@ -9711,14 +9728,14 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 			       phba->sli4_hba.mbx_wq,
 			       NULL, 0, LPFC_MBOX);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0529 Failed setup of mailbox WQ/CQ: rc = 0x%x\n",
 			(uint32_t)rc);
 		goto out_destroy;
 	}
 	if (phba->nvmet_support) {
 		if (!phba->sli4_hba.nvmet_cqset) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3165 Fast-path NVME CQ Set "
 					"array not allocated\n");
 			rc = -ENOMEM;
@@ -9730,7 +9747,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 					qp,
 					LPFC_WCQ, LPFC_NVMET);
 			if (rc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3164 Failed setup of NVME CQ "
 						"Set, rc = 0x%x\n",
 						(uint32_t)rc);
@@ -9742,7 +9759,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 					    qp[0].hba_eq,
 					    LPFC_WCQ, LPFC_NVMET);
 			if (rc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6089 Failed setup NVMET CQ: "
 						"rc = 0x%x\n", (uint32_t)rc);
 				goto out_destroy;
@@ -9759,7 +9776,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 
 	/* Set up slow-path ELS WQ/CQ */
 	if (!phba->sli4_hba.els_cq || !phba->sli4_hba.els_wq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0530 ELS %s not allocated\n",
 				phba->sli4_hba.els_cq ? "WQ" : "CQ");
 		rc = -ENOMEM;
@@ -9770,7 +9787,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 			       phba->sli4_hba.els_wq,
 			       NULL, 0, LPFC_ELS);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0525 Failed setup of ELS WQ/CQ: rc = 0x%x\n",
 				(uint32_t)rc);
 		goto out_destroy;
@@ -9783,7 +9800,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
 		/* Set up NVME LS Complete Queue */
 		if (!phba->sli4_hba.nvmels_cq || !phba->sli4_hba.nvmels_wq) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6091 LS %s not allocated\n",
 					phba->sli4_hba.nvmels_cq ? "WQ" : "CQ");
 			rc = -ENOMEM;
@@ -9794,7 +9811,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 				       phba->sli4_hba.nvmels_wq,
 				       NULL, 0, LPFC_NVME_LS);
 		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0526 Failed setup of NVVME LS WQ/CQ: "
 					"rc = 0x%x\n", (uint32_t)rc);
 			goto out_destroy;
@@ -9814,7 +9831,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 		if ((!phba->sli4_hba.nvmet_cqset) ||
 		    (!phba->sli4_hba.nvmet_mrq_hdr) ||
 		    (!phba->sli4_hba.nvmet_mrq_data)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6130 MRQ CQ Queues not "
 					"allocated\n");
 			rc = -ENOMEM;
@@ -9827,7 +9844,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 					     phba->sli4_hba.nvmet_cqset,
 					     LPFC_NVMET);
 			if (rc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6098 Failed setup of NVMET "
 						"MRQ: rc = 0x%x\n",
 						(uint32_t)rc);
@@ -9841,7 +9858,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 					    phba->sli4_hba.nvmet_cqset[0],
 					    LPFC_NVMET);
 			if (rc) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6057 Failed setup of NVMET "
 						"Receive Queue: rc = 0x%x\n",
 						(uint32_t)rc);
@@ -9860,7 +9877,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	}
 
 	if (!phba->sli4_hba.hdr_rq || !phba->sli4_hba.dat_rq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0540 Receive Queue not allocated\n");
 		rc = -ENOMEM;
 		goto out_destroy;
@@ -9869,7 +9886,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 	rc = lpfc_rq_create(phba, phba->sli4_hba.hdr_rq, phba->sli4_hba.dat_rq,
 			    phba->sli4_hba.els_cq, LPFC_USOL);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0541 Failed setup of Receive Queue: "
 				"rc = 0x%x\n", (uint32_t)rc);
 		goto out_destroy;
@@ -9897,7 +9914,7 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 		phba->sli4_hba.cq_lookup = kcalloc((phba->sli4_hba.cq_max + 1),
 			sizeof(struct lpfc_queue *), GFP_KERNEL);
 		if (!phba->sli4_hba.cq_lookup) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0549 Failed setup of CQ Lookup table: "
 					"size 0x%x\n", phba->sli4_hba.cq_max);
 			rc = -ENOMEM;
@@ -10197,7 +10214,7 @@ lpfc_pci_function_reset(struct lpfc_hba *phba)
 		mboxq = (LPFC_MBOXQ_t *) mempool_alloc(phba->mbox_mem_pool,
 						       GFP_KERNEL);
 		if (!mboxq) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0494 Unable to allocate memory for "
 					"issuing SLI_FUNCTION_RESET mailbox "
 					"command\n");
@@ -10217,7 +10234,7 @@ lpfc_pci_function_reset(struct lpfc_hba *phba)
 		if (rc != MBX_TIMEOUT)
 			mempool_free(mboxq, phba->mbox_mem_pool);
 		if (shdr_status || shdr_add_status || rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0495 SLI_FUNCTION_RESET mailbox "
 					"failed with status x%x add_status x%x,"
 					" mbx status x%x\n",
@@ -10249,7 +10266,7 @@ lpfc_pci_function_reset(struct lpfc_hba *phba)
 				phba->sli4_hba.u.if_type2.ERR1regaddr);
 			phba->work_status[1] = readl(
 				phba->sli4_hba.u.if_type2.ERR2regaddr);
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2890 Port not ready, port status reg "
 					"0x%x error 1=0x%x, error 2=0x%x\n",
 					reg_data.word0,
@@ -10291,7 +10308,7 @@ lpfc_pci_function_reset(struct lpfc_hba *phba)
 out:
 	/* Catch the not-ready port failure after a port reset. */
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3317 HBA not functional: IP Reset Failed "
 				"try: echo fw_reset > board_mode\n");
 		rc = -ENODEV;
@@ -10341,7 +10358,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 	/* There is no SLI3 failback for SLI4 devices. */
 	if (bf_get(lpfc_sli_intf_valid, &phba->sli4_hba.sli_intf) !=
 	    LPFC_SLI_INTF_VALID) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2894 SLI_INTF reg contents invalid "
 				"sli_intf reg 0x%x\n",
 				phba->sli4_hba.sli_intf.word0);
@@ -10616,7 +10633,7 @@ lpfc_sli_enable_msix(struct lpfc_hba *phba)
 
 	if (!pmb) {
 		rc = -ENOMEM;
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0474 Unable to allocate memory for issuing "
 				"MBOX_CONFIG_MSI command\n");
 		goto mem_fail_out;
@@ -11597,7 +11614,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 	}
 
 	if (vectors != phba->cfg_irq_chann) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3238 Reducing IO channels to match number of "
 				"MSI-X vectors, requested %d got %d\n",
 				phba->cfg_irq_chann, vectors);
@@ -11870,17 +11887,17 @@ lpfc_sli4_xri_exchange_busy_wait(struct lpfc_hba *phba)
 	while (!els_xri_cmpl || !io_xri_cmpl || !nvmet_xri_cmpl) {
 		if (wait_time > LPFC_XRI_EXCH_BUSY_WAIT_TMO) {
 			if (!nvmet_xri_cmpl)
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6424 NVMET XRI exchange busy "
 						"wait time: %d seconds.\n",
 						wait_time/1000);
 			if (!io_xri_cmpl)
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6100 IO XRI exchange busy "
 						"wait time: %d seconds.\n",
 						wait_time/1000);
 			if (!els_xri_cmpl)
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"2878 ELS XRI exchange busy "
 						"wait time: %d seconds.\n",
 						wait_time/1000);
@@ -12374,14 +12391,14 @@ lpfc_pci_probe_one_s3(struct pci_dev *pdev, const struct pci_device_id *pid)
 		/* Configure and enable interrupt */
 		intr_mode = lpfc_sli_enable_intr(phba, cfg_mode);
 		if (intr_mode == LPFC_INTR_ERROR) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0431 Failed to enable interrupt.\n");
 			error = -ENODEV;
 			goto out_free_sysfs_attr;
 		}
 		/* SLI-3 HBA setup */
 		if (lpfc_sli_hba_setup(phba)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"1477 Failed to set up hba\n");
 			error = -ENODEV;
 			goto out_remove_device;
@@ -12639,7 +12656,7 @@ lpfc_pci_resume_one_s3(struct pci_dev *pdev)
 	/* Configure and enable interrupt */
 	intr_mode = lpfc_sli_enable_intr(phba, phba->intr_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0430 PM resume Failed to enable interrupt\n");
 		return -EIO;
 	} else
@@ -12665,7 +12682,7 @@ lpfc_pci_resume_one_s3(struct pci_dev *pdev)
 static void
 lpfc_sli_prep_dev_for_recover(struct lpfc_hba *phba)
 {
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2723 PCI channel I/O abort preparing for recovery\n");
 
 	/*
@@ -12686,7 +12703,7 @@ lpfc_sli_prep_dev_for_recover(struct lpfc_hba *phba)
 static void
 lpfc_sli_prep_dev_for_reset(struct lpfc_hba *phba)
 {
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2710 PCI channel disable preparing for reset\n");
 
 	/* Block any management I/Os to the device */
@@ -12717,7 +12734,7 @@ lpfc_sli_prep_dev_for_reset(struct lpfc_hba *phba)
 static void
 lpfc_sli_prep_dev_for_perm_failure(struct lpfc_hba *phba)
 {
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2711 PCI channel permanent disable for failure\n");
 	/* Block all SCSI devices' I/Os on the host */
 	lpfc_scsi_dev_block(phba);
@@ -12768,7 +12785,7 @@ lpfc_io_error_detected_s3(struct pci_dev *pdev, pci_channel_state_t state)
 		return PCI_ERS_RESULT_DISCONNECT;
 	default:
 		/* Unknown state, prepare and request slot reset */
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0472 Unknown PCI error state: x%x\n", state);
 		lpfc_sli_prep_dev_for_reset(phba);
 		return PCI_ERS_RESULT_NEED_RESET;
@@ -12826,7 +12843,7 @@ lpfc_io_slot_reset_s3(struct pci_dev *pdev)
 	/* Configure and enable interrupt */
 	intr_mode = lpfc_sli_enable_intr(phba, phba->intr_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0427 Cannot re-enable interrupt after "
 				"slot reset.\n");
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -12929,7 +12946,7 @@ lpfc_log_write_firmware_error(struct lpfc_hba *phba, uint32_t offset,
 	     magic_number != MAGIC_NUMBER_G6) ||
 	    (phba->pcidev->device == PCI_DEVICE_ID_LANCER_G7_FC &&
 	     magic_number != MAGIC_NUMBER_G7)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3030 This firmware version is not supported on"
 				" this HBA model. Device:%x Magic:%x Type:%x "
 				"ID:%x Size %d %zd\n",
@@ -12937,7 +12954,7 @@ lpfc_log_write_firmware_error(struct lpfc_hba *phba, uint32_t offset,
 				fsize, fw->size);
 		rc = -EINVAL;
 	} else if (offset == ADD_STATUS_FW_DOWNLOAD_HW_DISABLED) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3021 Firmware downloads have been prohibited "
 				"by a system configuration setting on "
 				"Device:%x Magic:%x Type:%x ID:%x Size %d "
@@ -12946,7 +12963,7 @@ lpfc_log_write_firmware_error(struct lpfc_hba *phba, uint32_t offset,
 				fsize, fw->size);
 		rc = -EACCES;
 	} else {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3022 FW Download failed. Add Status x%x "
 				"Device:%x Magic:%x Type:%x ID:%x Size %d "
 				"%zd\n",
@@ -12991,7 +13008,7 @@ lpfc_write_firmware(const struct firmware *fw, void *context)
 	INIT_LIST_HEAD(&dma_buffer_list);
 	lpfc_decode_firmware_rev(phba, fwrev, 1);
 	if (strncmp(fwrev, image->revision, strnlen(image->revision, 16))) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3023 Updating Firmware, Current Version:%s "
 				"New Version:%s\n",
 				fwrev, image->revision);
@@ -13041,7 +13058,7 @@ lpfc_write_firmware(const struct firmware *fw, void *context)
 		}
 		rc = offset;
 	} else
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3029 Skipped Firmware update, Current "
 				"Version:%s New Version:%s\n",
 				fwrev, image->revision);
@@ -13056,10 +13073,10 @@ lpfc_write_firmware(const struct firmware *fw, void *context)
 	release_firmware(fw);
 out:
 	if (rc < 0)
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3062 Firmware update error, status %d.\n", rc);
 	else
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3024 Firmware update success: size %d.\n", rc);
 }
 
@@ -13188,7 +13205,7 @@ lpfc_pci_probe_one_s4(struct pci_dev *pdev, const struct pci_device_id *pid)
 	/* Configure and enable interrupt */
 	intr_mode = lpfc_sli4_enable_intr(phba, cfg_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0426 Failed to enable interrupt.\n");
 		error = -ENODEV;
 		goto out_unset_driver_resource;
@@ -13223,7 +13240,7 @@ lpfc_pci_probe_one_s4(struct pci_dev *pdev, const struct pci_device_id *pid)
 
 	/* Set up SLI-4 HBA */
 	if (lpfc_sli4_hba_setup(phba)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1421 Failed to set up hba\n");
 		error = -ENODEV;
 		goto out_free_sysfs_attr;
@@ -13248,7 +13265,7 @@ lpfc_pci_probe_one_s4(struct pci_dev *pdev, const struct pci_device_id *pid)
 			 */
 			error = lpfc_nvme_create_localport(vport);
 			if (error) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6004 NVME registration "
 						"failed, error x%x\n",
 						error);
@@ -13482,7 +13499,7 @@ lpfc_pci_resume_one_s4(struct pci_dev *pdev)
 	/* Configure and enable interrupt */
 	intr_mode = lpfc_sli4_enable_intr(phba, phba->intr_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0294 PM resume Failed to enable interrupt\n");
 		return -EIO;
 	} else
@@ -13508,7 +13525,7 @@ lpfc_pci_resume_one_s4(struct pci_dev *pdev)
 static void
 lpfc_sli4_prep_dev_for_recover(struct lpfc_hba *phba)
 {
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2828 PCI channel I/O abort preparing for recovery\n");
 	/*
 	 * There may be errored I/Os through HBA, abort all I/Os on txcmplq
@@ -13528,7 +13545,7 @@ lpfc_sli4_prep_dev_for_recover(struct lpfc_hba *phba)
 static void
 lpfc_sli4_prep_dev_for_reset(struct lpfc_hba *phba)
 {
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2826 PCI channel disable preparing for reset\n");
 
 	/* Block any management I/Os to the device */
@@ -13560,7 +13577,7 @@ lpfc_sli4_prep_dev_for_reset(struct lpfc_hba *phba)
 static void
 lpfc_sli4_prep_dev_for_perm_failure(struct lpfc_hba *phba)
 {
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2827 PCI channel permanent disable for failure\n");
 
 	/* Block all SCSI devices' I/Os on the host */
@@ -13610,7 +13627,7 @@ lpfc_io_error_detected_s4(struct pci_dev *pdev, pci_channel_state_t state)
 		return PCI_ERS_RESULT_DISCONNECT;
 	default:
 		/* Unknown state, prepare and request slot reset */
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2825 Unknown PCI error state: x%x\n", state);
 		lpfc_sli4_prep_dev_for_reset(phba);
 		return PCI_ERS_RESULT_NEED_RESET;
@@ -13668,7 +13685,7 @@ lpfc_io_slot_reset_s4(struct pci_dev *pdev)
 	/* Configure and enable interrupt */
 	intr_mode = lpfc_sli4_enable_intr(phba, phba->intr_mode);
 	if (intr_mode == LPFC_INTR_ERROR) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2824 Cannot re-enable interrupt after "
 				"slot reset.\n");
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -13773,7 +13790,7 @@ lpfc_pci_remove_one(struct pci_dev *pdev)
 		lpfc_pci_remove_one_s4(pdev);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1424 Invalid PCI device group: 0x%x\n",
 				phba->pci_dev_grp);
 		break;
@@ -13810,7 +13827,7 @@ lpfc_pci_suspend_one(struct pci_dev *pdev, pm_message_t msg)
 		rc = lpfc_pci_suspend_one_s4(pdev, msg);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1425 Invalid PCI device group: 0x%x\n",
 				phba->pci_dev_grp);
 		break;
@@ -13846,7 +13863,7 @@ lpfc_pci_resume_one(struct pci_dev *pdev)
 		rc = lpfc_pci_resume_one_s4(pdev);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1426 Invalid PCI device group: 0x%x\n",
 				phba->pci_dev_grp);
 		break;
@@ -13884,7 +13901,7 @@ lpfc_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 		rc = lpfc_io_error_detected_s4(pdev, state);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1427 Invalid PCI device group: 0x%x\n",
 				phba->pci_dev_grp);
 		break;
@@ -13921,7 +13938,7 @@ lpfc_io_slot_reset(struct pci_dev *pdev)
 		rc = lpfc_io_slot_reset_s4(pdev);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1428 Invalid PCI device group: 0x%x\n",
 				phba->pci_dev_grp);
 		break;
@@ -13953,7 +13970,7 @@ lpfc_io_resume(struct pci_dev *pdev)
 		lpfc_io_resume_s4(pdev);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1429 Invalid PCI device group: 0x%x\n",
 				phba->pci_dev_grp);
 		break;
@@ -14109,6 +14126,86 @@ lpfc_init(void)
 	return error;
 }
 
+void lpfc_dmp_dbg(struct lpfc_hba *phba)
+{
+	unsigned int start_idx;
+	unsigned int dbg_cnt;
+	unsigned int temp_idx;
+	int i;
+	int j = 0;
+	unsigned long rem_nsec;
+
+	if (phba->cfg_log_verbose)
+		return;
+
+	if (atomic_cmpxchg(&phba->dbg_log_dmping, 0, 1) != 0)
+		return;
+
+	start_idx = (unsigned int)atomic_read(&phba->dbg_log_idx) % DBG_LOG_SZ;
+	dbg_cnt = (unsigned int)atomic_read(&phba->dbg_log_cnt);
+	temp_idx = start_idx;
+	if (dbg_cnt >= DBG_LOG_SZ) {
+		dbg_cnt = DBG_LOG_SZ;
+		temp_idx -= 1;
+	} else {
+		if ((start_idx + dbg_cnt) > (DBG_LOG_SZ - 1)) {
+			temp_idx = (start_idx + dbg_cnt) % DBG_LOG_SZ;
+		} else {
+			if ((start_idx - dbg_cnt) < 0) {
+				start_idx = DBG_LOG_SZ - (dbg_cnt - start_idx);
+				temp_idx = 0;
+			} else {
+				start_idx -= dbg_cnt;
+			}
+		}
+	}
+	dev_info(&phba->pcidev->dev, "start %d end %d cnt %d\n",
+		 start_idx, temp_idx, dbg_cnt);
+
+	for (i = 0; i < dbg_cnt; i++) {
+		if ((start_idx + i) < DBG_LOG_SZ)
+			temp_idx = (start_idx + i) % (DBG_LOG_SZ - 1);
+		else
+			temp_idx = j++;
+		rem_nsec = do_div(phba->dbg_log[temp_idx].t_ns, NSEC_PER_SEC);
+		dev_info(&phba->pcidev->dev, "%d: [%5lu.%06lu] %s",
+			 temp_idx,
+			 (unsigned long)phba->dbg_log[temp_idx].t_ns,
+			 rem_nsec / 1000,
+			 phba->dbg_log[temp_idx].log);
+	}
+	atomic_set(&phba->dbg_log_cnt, 0);
+	atomic_set(&phba->dbg_log_dmping, 0);
+}
+
+void lpfc_dbg_print(struct lpfc_hba *phba, const char *fmt, ...)
+{
+	unsigned int idx;
+	va_list args;
+	int dbg_dmping = atomic_read(&phba->dbg_log_dmping);
+	struct va_format vaf;
+
+
+	va_start(args, fmt);
+	if (unlikely(dbg_dmping)) {
+		vaf.fmt = fmt;
+		vaf.va = &args;
+		dev_info(&phba->pcidev->dev, "%pV", &vaf);
+		va_end(args);
+		return;
+	}
+	idx = (unsigned int)atomic_fetch_add(1, &phba->dbg_log_idx) %
+		DBG_LOG_SZ;
+
+	atomic_inc(&phba->dbg_log_cnt);
+
+	vscnprintf(phba->dbg_log[idx].log,
+		   sizeof(phba->dbg_log[idx].log), fmt, args);
+	va_end(args);
+
+	phba->dbg_log[idx].t_ns = local_clock();
+}
+
 /**
  * lpfc_exit - lpfc module removal routine
  *
diff --git a/drivers/scsi/lpfc/lpfc_logmsg.h b/drivers/scsi/lpfc/lpfc_logmsg.h
index 148d02a27b58..5660a8729462 100644
--- a/drivers/scsi/lpfc/lpfc_logmsg.h
+++ b/drivers/scsi/lpfc/lpfc_logmsg.h
@@ -44,7 +44,11 @@
 #define LOG_NVME_DISC   0x00200000      /* NVME Discovery/Connect events. */
 #define LOG_NVME_ABTS   0x00400000      /* NVME ABTS events. */
 #define LOG_NVME_IOERR  0x00800000      /* NVME IO Error events. */
-#define LOG_ALL_MSG	0xffffffff	/* LOG all messages */
+#define LOG_TRACE_EVENT 0x80000000	/* Dmp the DBG log on this err */
+#define LOG_ALL_MSG	0x7fffffff	/* LOG all messages */
+
+void lpfc_dmp_dbg(struct lpfc_hba *phba);
+void lpfc_dbg_print(struct lpfc_hba *phba, const char *fmt, ...);
 
 /* generate message by verbose log setting or severity */
 #define lpfc_vlog_msg(vport, level, mask, fmt, arg...) \
@@ -65,9 +69,15 @@ do { \
 
 #define lpfc_printf_vlog(vport, level, mask, fmt, arg...) \
 do { \
-	{ if (((mask) & (vport)->cfg_log_verbose) || (level[1] <= '3')) \
+	{ if (((mask) & (vport)->cfg_log_verbose) || (level[1] <= '3')) { \
+		if ((mask) & LOG_TRACE_EVENT) \
+			lpfc_dmp_dbg((vport)->phba); \
 		dev_printk(level, &((vport)->phba->pcidev)->dev, "%d:(%d):" \
-			   fmt, (vport)->phba->brd_no, vport->vpi, ##arg); } \
+			   fmt, (vport)->phba->brd_no, vport->vpi, ##arg);  \
+		} else if (!(vport)->cfg_log_verbose) \
+			lpfc_dbg_print((vport)->phba, "%d:(%d):" fmt, \
+				(vport)->phba->brd_no, (vport)->vpi, ##arg); \
+	} \
 } while (0)
 
 #define lpfc_printf_log(phba, level, mask, fmt, arg...) \
@@ -75,8 +85,12 @@ do { \
 	{ uint32_t log_verbose = (phba)->pport ? \
 				 (phba)->pport->cfg_log_verbose : \
 				 (phba)->cfg_log_verbose; \
-	  if (((mask) & log_verbose) || (level[1] <= '3')) \
+	if (((mask) & log_verbose) || (level[1] <= '3')) { \
+		if ((mask) & LOG_TRACE_EVENT) \
+			lpfc_dmp_dbg(phba); \
 		dev_printk(level, &((phba)->pcidev)->dev, "%d:" \
-			   fmt, phba->brd_no, ##arg); \
+			fmt, phba->brd_no, ##arg); \
+	} else  if (!(phba)->cfg_log_verbose)\
+		lpfc_dbg_print(phba, "%d:" fmt, phba->brd_no, ##arg); \
 	} \
 } while (0)
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 057af32f498d..033cebdbf335 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -152,7 +152,7 @@ lpfc_check_sparm(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	memcpy(&ndlp->nlp_portname, &sp->portName, sizeof (struct lpfc_name));
 	return 1;
 bad_service_param:
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0207 Device %x "
 			 "(%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x) sent "
 			 "invalid service parameters.  Ignoring device.\n",
@@ -301,7 +301,7 @@ lpfc_defer_pt2pt_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *link_mbox)
 
 	/* Check for CONFIG_LINK error */
 	if (mb->mbxStatus) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"4575 CONFIG_LINK fails pt2pt discovery: %x\n",
 				mb->mbxStatus);
 		mempool_free(login_mbox, phba->mbox_mem_pool);
@@ -316,7 +316,7 @@ lpfc_defer_pt2pt_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *link_mbox)
 	rc = lpfc_els_rsp_acc(link_mbox->vport, ELS_CMD_PLOGI,
 			      save_iocb, ndlp, login_mbox);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"4576 PLOGI ACC fails pt2pt discovery: %x\n",
 				rc);
 		mempool_free(login_mbox, phba->mbox_mem_pool);
@@ -361,7 +361,7 @@ lpfc_defer_acc_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lpfc_sli4_unreg_rpi_cmpl_clr(phba, pmb);
 
 	if (!piocb) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY | LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "4578 PLOGI ACC fail\n");
 		if (mbox)
 			mempool_free(mbox, phba->mbox_mem_pool);
@@ -370,7 +370,7 @@ lpfc_defer_acc_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	rc = lpfc_els_rsp_acc(vport, ELS_CMD_PLOGI, piocb, ndlp, mbox);
 	if (rc) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY | LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "4579 PLOGI ACC fail %x\n", rc);
 		if (mbox)
 			mempool_free(mbox, phba->mbox_mem_pool);
@@ -405,7 +405,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	lp = (uint32_t *) pcmd->virt;
 	sp = (struct serv_parm *) ((uint8_t *) lp + sizeof (uint32_t));
 	if (wwn_to_u64(sp->portName.u.wwn) == 0) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0140 PLOGI Reject: invalid nname\n");
 		stat.un.b.lsRjtRsnCode = LSRJT_UNABLE_TPC;
 		stat.un.b.lsRjtRsnCodeExp = LSEXP_INVALID_PNAME;
@@ -414,7 +414,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		return 0;
 	}
 	if (wwn_to_u64(sp->nodeName.u.wwn) == 0) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0141 PLOGI Reject: invalid pname\n");
 		stat.un.b.lsRjtRsnCode = LSRJT_UNABLE_TPC;
 		stat.un.b.lsRjtRsnCodeExp = LSEXP_INVALID_NNAME;
@@ -481,7 +481,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		}
 		if (nlp_portwwn != 0 &&
 		    nlp_portwwn != wwn_to_u64(sp->portName.u.wwn))
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0143 PLOGI recv'd from DID: x%x "
 					 "WWPN changed: old %llx new %llx\n",
 					 ndlp->nlp_DID,
@@ -689,7 +689,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	return 1;
 out:
 	if (defer_acc)
-		lpfc_printf_log(phba, KERN_ERR, LOG_DISCOVERY,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"4577 discovery failure: %p %p %p\n",
 				save_iocb, link_mbox, login_mbox);
 	kfree(save_iocb);
@@ -1097,8 +1097,8 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
 	pmb = (LPFC_MBOXQ_t *) mempool_alloc(phba->mbox_mem_pool,
 			GFP_KERNEL);
 	if (!pmb)
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
-			"2796 mailbox memory allocation failed \n");
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "2796 mailbox memory allocation failed \n");
 	else {
 		lpfc_unreg_login(phba, vport->vpi, rpi, pmb);
 		pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
@@ -1136,7 +1136,7 @@ lpfc_disc_illegal(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		rpi = pmb->u.mb.un.varWords[0];
 		lpfc_release_rpi(phba, vport, ndlp, rpi);
 	}
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0271 Illegal State Transition: node x%x "
 			 "event x%x, state x%x Data: x%x x%x\n",
 			 ndlp->nlp_DID, evt, ndlp->nlp_state, ndlp->nlp_rpi,
@@ -1154,11 +1154,11 @@ lpfc_cmpl_plogi_illegal(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * to stop it.
 	 */
 	if (!(ndlp->nlp_flag & NLP_RCV_PLOGI)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
-			 "0272 Illegal State Transition: node x%x "
-			 "event x%x, state x%x Data: x%x x%x\n",
-			 ndlp->nlp_DID, evt, ndlp->nlp_state, ndlp->nlp_rpi,
-			 ndlp->nlp_flag);
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "0272 Illegal State Transition: node x%x "
+				 "event x%x, state x%x Data: x%x x%x\n",
+				  ndlp->nlp_DID, evt, ndlp->nlp_state,
+				  ndlp->nlp_rpi, ndlp->nlp_flag);
 	}
 	return ndlp->nlp_state;
 }
@@ -1378,7 +1378,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 	if ((ndlp->nlp_DID != FDMI_DID) &&
 		(wwn_to_u64(sp->portName.u.wwn) == 0 ||
 		wwn_to_u64(sp->nodeName.u.wwn) == 0)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0142 PLOGI RSP: Invalid WWN.\n");
 		goto out;
 	}
@@ -1440,7 +1440,8 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 		} else {
 			mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 			if (!mbox) {
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+				lpfc_printf_vlog(vport, KERN_ERR,
+						 LOG_TRACE_EVENT,
 						 "0133 PLOGI: no memory "
 						 "for config_link "
 						 "Data: x%x x%x x%x x%x\n",
@@ -1465,7 +1466,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0018 PLOGI: no memory for reg_login "
 				 "Data: x%x x%x x%x x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
@@ -1505,7 +1506,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 		kfree(mp);
 		mempool_free(mbox, phba->mbox_mem_pool);
 
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0134 PLOGI: cannot issue reg_login "
 				 "Data: x%x x%x x%x x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
@@ -1513,7 +1514,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 	} else {
 		mempool_free(mbox, phba->mbox_mem_pool);
 
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0135 PLOGI: cannot format reg_login "
 				 "Data: x%x x%x x%x x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
@@ -1524,7 +1525,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 out:
 	if (ndlp->nlp_DID == NameServer_DID) {
 		lpfc_vport_set_state(vport, FC_VPORT_FAILED);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0261 Cannot Register NameServer login\n");
 	}
 
@@ -1946,8 +1947,8 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 
 	if (mb->mbxStatus) {
 		/* RegLogin failed */
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_DISCOVERY,
-				"0246 RegLogin failed Data: x%x x%x x%x x%x "
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "0246 RegLogin failed Data: x%x x%x x%x x%x "
 				 "x%x\n",
 				 did, mb->mbxStatus, vport->port_state,
 				 mb->un.varRegLogin.vpi,
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index b16c087ba272..fdfca02704dc 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -498,7 +498,7 @@ __lpfc_nvme_ls_req_cmp(struct lpfc_hba *phba,  struct lpfc_vport *vport,
 	if (pnvme_lsreq->done)
 		pnvme_lsreq->done(pnvme_lsreq, status);
 	else
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6046 NVMEx cmpl without done call back? "
 				 "Data %px DID %x Xri: %x status %x\n",
 				pnvme_lsreq, ndlp ? ndlp->nlp_DID : 0,
@@ -647,7 +647,7 @@ lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 
 	rc = lpfc_sli4_issue_wqe(phba, &phba->sli4_hba.hdwq[0], genwqe);
 	if (rc) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC | LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6045 Issue GEN REQ WQE to NPORT x%x "
 				 "Data: x%x x%x  rc x%x\n",
 				 ndlp->nlp_DID, genwqe->iotag,
@@ -693,8 +693,7 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	uint16_t ntype, nstate;
 
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-				 LOG_NVME_DISC | LOG_NODE | LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6051 NVMEx LS REQ: Bad NDLP x%px, Failing "
 				 "LS Req\n",
 				 ndlp);
@@ -705,8 +704,7 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	nstate = ndlp->nlp_state;
 	if ((ntype & NLP_NVME_TARGET && nstate != NLP_STE_MAPPED_NODE) ||
 	    (ntype & NLP_NVME_INITIATOR && nstate != NLP_STE_UNMAPPED_NODE)) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-				 LOG_NVME_DISC | LOG_NODE | LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6088 NVMEx LS REQ: Fail DID x%06x not "
 				 "ready for IO. Type x%x, State x%x\n",
 				 ndlp->nlp_DID, ntype, nstate);
@@ -727,9 +725,7 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	bmp = kmalloc(sizeof(*bmp), GFP_KERNEL);
 	if (!bmp) {
-
-		lpfc_printf_vlog(vport, KERN_ERR,
-				 LOG_NVME_DISC | LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6044 NVMEx LS REQ: Could not alloc LS buf "
 				 "for DID %x\n",
 				 ndlp->nlp_DID);
@@ -738,8 +734,7 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	bmp->virt = lpfc_mbuf_alloc(vport->phba, MEM_PRI, &(bmp->phys));
 	if (!bmp->virt) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-				 LOG_NVME_DISC | LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6042 NVMEx LS REQ: Could not alloc mbuf "
 				 "for DID %x\n",
 				 ndlp->nlp_DID);
@@ -774,8 +769,7 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				pnvme_lsreq, gen_req_cmp, ndlp, 2,
 				LPFC_NVME_LS_TIMEOUT, 0);
 	if (ret != WQE_SUCCESS) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-				 LOG_NVME_DISC | LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6052 NVMEx REQ: EXIT. issue ls wqe failed "
 				 "lsreq x%px Status %x DID %x\n",
 				 pnvme_lsreq, ret, ndlp->nlp_DID);
@@ -853,9 +847,7 @@ __lpfc_nvme_ls_abort(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	bool foundit = false;
 
 	if (!ndlp) {
-		lpfc_printf_log(phba, KERN_ERR,
-				LOG_NVME_DISC | LOG_NODE |
-					LOG_NVME_IOERR | LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"6049 NVMEx LS REQ Abort: Bad NDLP x%px DID "
 				"x%06x, Failing LS Req\n",
 				ndlp, ndlp ? ndlp->nlp_DID : 0);
@@ -1099,8 +1091,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 
 	/* Sanity check on return of outstanding command */
 	if (!lpfc_ncmd) {
-		lpfc_printf_vlog(vport, KERN_ERR,
-				 LOG_NODE | LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6071 Null lpfc_ncmd pointer. No "
 				 "release, skip completion\n");
 		return;
@@ -1111,7 +1102,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 
 	if (!lpfc_ncmd->nvmeCmd) {
 		spin_unlock(&lpfc_ncmd->buf_lock);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6066 Missing cmpl ptrs: lpfc_ncmd x%px, "
 				 "nvmeCmd x%px\n",
 				 lpfc_ncmd, lpfc_ncmd->nvmeCmd);
@@ -1144,7 +1135,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	 */
 	ndlp = lpfc_ncmd->ndlp;
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6062 Ignoring NVME cmpl.  No ndlp\n");
 		goto out_err;
 	}
@@ -1215,7 +1206,7 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 			/* Sanity check */
 			if (nCmd->rcv_rsplen == LPFC_NVME_ERSP_LEN)
 				break;
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "6081 NVME Completion Protocol Error: "
 					 "xri %x status x%x result x%x "
 					 "placed x%x\n",
@@ -1459,7 +1450,7 @@ lpfc_nvme_prep_io_dma(struct lpfc_vport *vport,
 		first_data_sgl = sgl;
 		lpfc_ncmd->seg_cnt = nCmd->sg_cnt;
 		if (lpfc_ncmd->seg_cnt > lpfc_nvme_template.max_sgl_segments) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6058 Too many sg segments from "
 					"NVME Transport.  Max %d, "
 					"nvmeIO sg_cnt %d\n",
@@ -1482,7 +1473,7 @@ lpfc_nvme_prep_io_dma(struct lpfc_vport *vport,
 		j = 2;
 		for (i = 0; i < nseg; i++) {
 			if (data_sg == NULL) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6059 dptr err %d, nseg %d\n",
 						i, nseg);
 				lpfc_ncmd->seg_cnt = 0;
@@ -1583,7 +1574,7 @@ lpfc_nvme_prep_io_dma(struct lpfc_vport *vport,
 		 * and sg_cnt must zero.
 		 */
 		if (nCmd->payload_length != 0) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6063 NVME DMA Prep Err: sg_cnt %d "
 					"payload_length x%x\n",
 					nCmd->sg_cnt, nCmd->payload_length);
@@ -1946,7 +1937,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	/* driver queued commands are in process of being flushed */
 	if (phba->hba_flag & HBA_IOQ_FLUSH) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6139 Driver in reset cleanup - flushing "
 				 "NVME Req now.  hba_flag x%x\n",
 				 phba->hba_flag);
@@ -1956,13 +1947,13 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	lpfc_nbuf = freqpriv->nvme_buf;
 	if (!lpfc_nbuf) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6140 NVME IO req has no matching lpfc nvme "
 				 "io buffer.  Skipping abort req.\n");
 		return;
 	} else if (!lpfc_nbuf->nvmeCmd) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6141 lpfc NVME IO req has no nvme_fcreq "
 				 "io buffer.  Skipping abort req.\n");
 		return;
@@ -1980,7 +1971,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	 * has not seen it yet.
 	 */
 	if (lpfc_nbuf->nvmeCmd != pnvme_fcreq) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6143 NVME req mismatch: "
 				 "lpfc_nbuf x%px nvmeCmd x%px, "
 				 "pnvme_fcreq x%px.  Skipping Abort xri x%x\n",
@@ -1991,7 +1982,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 
 	/* Don't abort IOs no longer on the pending queue. */
 	if (!(nvmereq_wqe->iocb_flag & LPFC_IO_ON_TXCMPLQ)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6142 NVME IO req x%px not queued - skipping "
 				 "abort req xri x%x\n",
 				 pnvme_fcreq, nvmereq_wqe->sli4_xritag);
@@ -2005,7 +1996,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 
 	/* Outstanding abort is in progress */
 	if (nvmereq_wqe->iocb_flag & LPFC_DRIVER_ABORTED) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6144 Outstanding NVME I/O Abort Request "
 				 "still pending on nvme_fcreq x%px, "
 				 "lpfc_ncmd %px xri x%x\n",
@@ -2016,7 +2007,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 
 	abts_buf = __lpfc_sli_get_iocbq(phba);
 	if (!abts_buf) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6136 No available abort wqes. Skipping "
 				 "Abts req for nvme_fcreq x%px xri x%x\n",
 				 pnvme_fcreq, nvmereq_wqe->sli4_xritag);
@@ -2037,7 +2028,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	spin_unlock(&lpfc_nbuf->buf_lock);
 	spin_unlock_irqrestore(&phba->hbalock, flags);
 	if (ret_val) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6137 Failed abts issue_wqe with status x%x "
 				 "for nvme_fcreq x%px.\n",
 				 ret_val, pnvme_fcreq);
@@ -2310,7 +2301,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 				if (pring->txcmplq_cnt)
 					pending += pring->txcmplq_cnt;
 			}
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "6176 Lport x%px Localport x%px wait "
 					 "timed out. Pending %d. Renewing.\n",
 					 lport, vport->localport, pending);
@@ -2528,7 +2519,7 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				 ndlp, prev_ndlp);
 	} else {
 		lpfc_printf_vlog(vport, KERN_ERR,
-				 LOG_NVME_DISC | LOG_NODE,
+				 LOG_TRACE_EVENT,
 				 "6031 RemotePort Registration failed "
 				 "err: %d, DID x%06x\n",
 				 ret, ndlp->nlp_DID);
@@ -2574,7 +2565,7 @@ lpfc_nvme_rescan_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	    ndlp->nlp_state == NLP_STE_MAPPED_NODE) {
 		nvme_fc_rescan_remoteport(remoteport);
 
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6172 NVME rescanned DID x%06x "
 				 "port_state x%x\n",
 				 ndlp->nlp_DID, remoteport->port_state);
@@ -2657,7 +2648,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		ret = nvme_fc_unregister_remoteport(remoteport);
 		if (ret != 0) {
 			lpfc_nlp_put(ndlp);
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "6167 NVME unregister failed %d "
 					 "port_state x%x\n",
 					 ret, remoteport->port_state);
@@ -2667,7 +2658,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
  input_err:
 #endif
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "6168 State error: lport x%px, rport x%px FCID x%06x\n",
 			 vport->localport, ndlp->rport, ndlp->nlp_DID);
 }
@@ -2752,7 +2743,7 @@ lpfc_nvme_wait_for_io_drain(struct lpfc_hba *phba)
 			 * dump a message.  Something is wrong.
 			 */
 			if ((wait_cnt % 1000) == 0) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"6178 NVME IO not empty, "
 						"cnt %d\n", wait_cnt);
 			}
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 88760416a8cb..a4430aeeb04a 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -303,7 +303,7 @@ __lpfc_nvme_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	result = wcqe->parameter;
 
 	if (axchg->state != LPFC_NVME_STE_LS_RSP || axchg->entry_cnt != 2) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6410 NVMEx LS cmpl state mismatch IO x%x: "
 				"%d %d\n",
 				axchg->oxid, axchg->state, axchg->entry_cnt);
@@ -395,7 +395,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 	unsigned long iflag;
 
 	if (ctxp->state == LPFC_NVME_STE_FREE) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6411 NVMET free, already free IO x%x: %d %d\n",
 				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
 	}
@@ -474,7 +474,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 
 		if (!queue_work(phba->wq, &ctx_buf->defer_work)) {
 			atomic_inc(&tgtp->rcv_fcp_cmd_drop);
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6181 Unable to queue deferred work "
 					"for oxid x%x. "
 					"FCP Drop IO [x%x x%x x%x]\n",
@@ -879,7 +879,7 @@ __lpfc_nvme_xmt_ls_rsp(struct lpfc_async_xchg_ctx *axchg,
 			"6023 NVMEx LS rsp oxid x%x\n", axchg->oxid);
 
 	if (axchg->state != LPFC_NVME_STE_LS_RCV || axchg->entry_cnt != 1) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6412 NVMEx LS rsp state mismatch "
 				"oxid x%x: %d %d\n",
 				axchg->oxid, axchg->state, axchg->entry_cnt);
@@ -891,8 +891,7 @@ __lpfc_nvme_xmt_ls_rsp(struct lpfc_async_xchg_ctx *axchg,
 	nvmewqeq = lpfc_nvmet_prep_ls_wqe(phba, axchg, ls_rsp->rspdma,
 					 ls_rsp->rsplen);
 	if (nvmewqeq == NULL) {
-		lpfc_printf_log(phba, KERN_ERR,
-				LOG_NVME_DISC | LOG_NVME_IOERR | LOG_NVME_ABTS,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6150 NVMEx LS Drop Rsp x%x: Prep\n",
 				axchg->oxid);
 		rc = -ENOMEM;
@@ -936,8 +935,7 @@ __lpfc_nvme_xmt_ls_rsp(struct lpfc_async_xchg_ctx *axchg,
 		return 0;
 	}
 
-	lpfc_printf_log(phba, KERN_ERR,
-			LOG_NVME_DISC | LOG_NVME_IOERR | LOG_NVME_ABTS,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6151 NVMEx LS RSP x%x: failed to transmit %d\n",
 			axchg->oxid, rc);
 
@@ -1058,7 +1056,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	if ((ctxp->flag & LPFC_NVME_ABTS_RCV) ||
 	    (ctxp->state == LPFC_NVME_STE_ABORT)) {
 		atomic_inc(&lpfc_nvmep->xmt_fcp_drop);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6102 IO oxid x%x aborted\n",
 				ctxp->oxid);
 		rc = -ENXIO;
@@ -1068,7 +1066,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	nvmewqeq = lpfc_nvmet_prep_fcp_wqe(phba, ctxp);
 	if (nvmewqeq == NULL) {
 		atomic_inc(&lpfc_nvmep->xmt_fcp_drop);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6152 FCP Drop IO x%x: Prep\n",
 				ctxp->oxid);
 		rc = -ENXIO;
@@ -1116,7 +1114,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 
 	/* Give back resources */
 	atomic_inc(&lpfc_nvmep->xmt_fcp_drop);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6153 FCP Drop IO x%x: Issue: %d\n",
 			ctxp->oxid, rc);
 
@@ -1216,7 +1214,7 @@ lpfc_nvmet_xmt_fcp_release(struct nvmet_fc_target_port *tgtport,
 				ctxp->flag, ctxp->oxid);
 	else if (ctxp->state != LPFC_NVME_STE_DONE &&
 		 ctxp->state != LPFC_NVME_STE_ABORT)
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6413 NVMET release bad state %d %d oxid x%x\n",
 				ctxp->state, ctxp->entry_cnt, ctxp->oxid);
 
@@ -1395,7 +1393,7 @@ lpfc_nvmet_discovery_event(struct nvmet_fc_target_port *tgtport)
 	phba = tgtp->phba;
 
 	rc = lpfc_issue_els_rscn(phba->pport, 0);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6420 NVMET subsystem change: Notification %s\n",
 			(rc) ? "Failed" : "Sent");
 }
@@ -1493,7 +1491,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		phba->sli4_hba.num_possible_cpu * phba->cfg_nvmet_mrq,
 		sizeof(struct lpfc_nvmet_ctx_info), GFP_KERNEL);
 	if (!phba->sli4_hba.nvmet_ctx_info) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6419 Failed allocate memory for "
 				"nvmet context lists\n");
 		return -ENOMEM;
@@ -1551,7 +1549,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 	for (i = 0; i < phba->sli4_hba.nvmet_xri_cnt; i++) {
 		ctx_buf = kzalloc(sizeof(*ctx_buf), GFP_KERNEL);
 		if (!ctx_buf) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6404 Ran out of memory for NVMET\n");
 			return -ENOMEM;
 		}
@@ -1560,7 +1558,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 					   GFP_KERNEL);
 		if (!ctx_buf->context) {
 			kfree(ctx_buf);
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6405 Ran out of NVMET "
 					"context memory\n");
 			return -ENOMEM;
@@ -1572,7 +1570,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		if (!ctx_buf->iocbq) {
 			kfree(ctx_buf->context);
 			kfree(ctx_buf);
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6406 Ran out of NVMET iocb/WQEs\n");
 			return -ENOMEM;
 		}
@@ -1591,7 +1589,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 			lpfc_sli_release_iocbq(phba, ctx_buf->iocbq);
 			kfree(ctx_buf->context);
 			kfree(ctx_buf);
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6407 Ran out of NVMET XRIs\n");
 			return -ENOMEM;
 		}
@@ -1670,7 +1668,7 @@ lpfc_nvmet_create_targetport(struct lpfc_hba *phba)
 	error = -ENOENT;
 #endif
 	if (error) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6025 Cannot register NVME targetport x%x: "
 				"portnm %llx nodenm %llx segs %d qs %d\n",
 				error,
@@ -2114,7 +2112,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 		nvmet_fc_unregister_targetport(phba->targetport);
 		if (!wait_for_completion_timeout(tgtp->tport_unreg_cmp,
 					msecs_to_jiffies(LPFC_NVMET_WAIT_TMO)))
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6179 Unreg targetport x%px timeout "
 					"reached.\n", phba->targetport);
 		lpfc_nvmet_cleanup_io_context(phba);
@@ -2187,7 +2185,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 	unsigned long iflags;
 
 	if (!nvmebuf) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6159 process_rcv_fcp_req, nvmebuf is NULL, "
 			"oxid: x%x flg: x%x state: x%x\n",
 			ctxp->oxid, ctxp->flag, ctxp->state);
@@ -2200,7 +2198,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 	}
 
 	if (ctxp->flag & LPFC_NVME_ABTS_RCV) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6324 IO oxid x%x aborted\n",
 				ctxp->oxid);
 		return;
@@ -2264,7 +2262,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 	}
 	ctxp->flag &= ~LPFC_NVME_TNOTIFY;
 	atomic_inc(&tgtp->rcv_fcp_cmd_drop);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2582 FCP Drop IO x%x: err x%x: x%x x%x x%x\n",
 			ctxp->oxid, rc,
 			atomic_read(&tgtp->rcv_fcp_cmd_in),
@@ -2383,7 +2381,7 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 
 	ctx_buf = NULL;
 	if (!nvmebuf || !phba->targetport) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6157 NVMET FCP Drop IO\n");
 		if (nvmebuf)
 			lpfc_rq_buf_free(phba, &nvmebuf->hbuf);
@@ -2456,7 +2454,7 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 	list_add_tail(&ctxp->list, &phba->sli4_hba.t_active_ctx_list);
 	spin_unlock_irqrestore(&phba->sli4_hba.t_active_list_lock, iflag);
 	if (ctxp->state != LPFC_NVME_STE_FREE) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6414 NVMET Context corrupt %d %d oxid x%x\n",
 				ctxp->state, ctxp->entry_cnt, ctxp->oxid);
 	}
@@ -2498,7 +2496,7 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 
 	if (!queue_work(phba->wq, &ctx_buf->defer_work)) {
 		atomic_inc(&tgtp->rcv_fcp_cmd_drop);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6325 Unable to queue work for oxid x%x. "
 				"FCP Drop IO [x%x x%x x%x]\n",
 				ctxp->oxid,
@@ -2535,7 +2533,7 @@ lpfc_nvmet_unsol_fcp_event(struct lpfc_hba *phba,
 			   uint8_t cqflag)
 {
 	if (!nvmebuf) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3167 NVMET FCP Drop IO\n");
 		return;
 	}
@@ -2581,7 +2579,7 @@ lpfc_nvmet_prep_ls_wqe(struct lpfc_hba *phba,
 	union lpfc_wqe128 *wqe;
 
 	if (!lpfc_is_link_up(phba)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6104 NVMET prep LS wqe: link err: "
 				"NPORT x%x oxid:x%x ste %d\n",
 				ctxp->sid, ctxp->oxid, ctxp->state);
@@ -2591,7 +2589,7 @@ lpfc_nvmet_prep_ls_wqe(struct lpfc_hba *phba,
 	/* Allocate buffer for  command wqe */
 	nvmewqe = lpfc_sli_get_iocbq(phba);
 	if (nvmewqe == NULL) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6105 NVMET prep LS wqe: No WQE: "
 				"NPORT x%x oxid x%x ste %d\n",
 				ctxp->sid, ctxp->oxid, ctxp->state);
@@ -2602,7 +2600,7 @@ lpfc_nvmet_prep_ls_wqe(struct lpfc_hba *phba,
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp) ||
 	    ((ndlp->nlp_state != NLP_STE_UNMAPPED_NODE) &&
 	    (ndlp->nlp_state != NLP_STE_MAPPED_NODE))) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6106 NVMET prep LS wqe: No ndlp: "
 				"NPORT x%x oxid x%x ste %d\n",
 				ctxp->sid, ctxp->oxid, ctxp->state);
@@ -2711,7 +2709,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 	int xc = 1;
 
 	if (!lpfc_is_link_up(phba)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6107 NVMET prep FCP wqe: link err:"
 				"NPORT x%x oxid x%x ste %d\n",
 				ctxp->sid, ctxp->oxid, ctxp->state);
@@ -2722,7 +2720,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp) ||
 	    ((ndlp->nlp_state != NLP_STE_UNMAPPED_NODE) &&
 	     (ndlp->nlp_state != NLP_STE_MAPPED_NODE))) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6108 NVMET prep FCP wqe: no ndlp: "
 				"NPORT x%x oxid x%x ste %d\n",
 				ctxp->sid, ctxp->oxid, ctxp->state);
@@ -2730,7 +2728,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 	}
 
 	if (rsp->sg_cnt > lpfc_tgttemplate.max_sgl_segments) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6109 NVMET prep FCP wqe: seg cnt err: "
 				"NPORT x%x oxid x%x ste %d cnt %d\n",
 				ctxp->sid, ctxp->oxid, ctxp->state,
@@ -2745,7 +2743,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 		/* Allocate buffer for  command wqe */
 		nvmewqe = ctxp->ctxbuf->iocbq;
 		if (nvmewqe == NULL) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6110 NVMET prep FCP wqe: No "
 					"WQE: NPORT x%x oxid x%x ste %d\n",
 					ctxp->sid, ctxp->oxid, ctxp->state);
@@ -2763,7 +2761,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 	    (ctxp->state == LPFC_NVME_STE_DATA)) {
 		wqe = &nvmewqe->wqe;
 	} else {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6111 Wrong state NVMET FCP: %d  cnt %d\n",
 				ctxp->state, ctxp->entry_cnt);
 		return NULL;
@@ -3136,7 +3134,7 @@ lpfc_nvmet_unsol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 
 	/* Sanity check */
 	if (ctxp->state != LPFC_NVME_STE_ABORT) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6112 ABTS Wrong state:%d oxid x%x\n",
 				ctxp->state, ctxp->oxid);
 	}
@@ -3210,7 +3208,7 @@ lpfc_nvmet_xmt_ls_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 			result, wcqe->word3);
 
 	if (!ctxp) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6415 NVMET LS Abort No ctx: WCQE: "
 				 "%08x %08x %08x %08x\n",
 				wcqe->word0, wcqe->total_data_placed,
@@ -3221,7 +3219,7 @@ lpfc_nvmet_xmt_ls_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	}
 
 	if (ctxp->state != LPFC_NVME_STE_LS_ABORT) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6416 NVMET LS abort cmpl state mismatch: "
 				"oxid x%x: %d %d\n",
 				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
@@ -3256,7 +3254,7 @@ lpfc_nvmet_unsol_issue_abort(struct lpfc_hba *phba,
 	    (ndlp->nlp_state != NLP_STE_MAPPED_NODE))) {
 		if (tgtp)
 			atomic_inc(&tgtp->xmt_abort_rsp_error);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6134 Drop ABTS - wrong NDLP state x%x.\n",
 				(ndlp) ? ndlp->nlp_state : NLP_STE_MAX_STATE);
 
@@ -3353,7 +3351,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 	    ((ndlp->nlp_state != NLP_STE_UNMAPPED_NODE) &&
 	    (ndlp->nlp_state != NLP_STE_MAPPED_NODE))) {
 		atomic_inc(&tgtp->xmt_abort_rsp_error);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6160 Drop ABORT - wrong NDLP state x%x.\n",
 				(ndlp) ? ndlp->nlp_state : NLP_STE_MAX_STATE);
 
@@ -3369,7 +3367,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 	spin_lock_irqsave(&ctxp->ctxlock, flags);
 	if (!ctxp->abort_wqeq) {
 		atomic_inc(&tgtp->xmt_abort_rsp_error);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6161 ABORT failed: No wqeqs: "
 				"xri: x%x\n", ctxp->oxid);
 		/* No failure to an ABTS request. */
@@ -3396,7 +3394,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 	if (phba->hba_flag & HBA_IOQ_FLUSH) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
 		atomic_inc(&tgtp->xmt_abort_rsp_error);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6163 Driver in reset cleanup - flushing "
 				"NVME Req now. hba_flag x%x oxid x%x\n",
 				phba->hba_flag, ctxp->oxid);
@@ -3411,7 +3409,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 	if (abts_wqeq->iocb_flag & LPFC_DRIVER_ABORTED) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
 		atomic_inc(&tgtp->xmt_abort_rsp_error);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6164 Outstanding NVME I/O Abort Request "
 				"still pending on oxid x%x\n",
 				ctxp->oxid);
@@ -3449,7 +3447,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 	ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 	lpfc_sli_release_iocbq(phba, abts_wqeq);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6166 Failed ABORT issue_wqe with status x%x "
 			"for oxid x%x.\n",
 			rc, ctxp->oxid);
@@ -3474,7 +3472,7 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 	}
 
 	if (ctxp->state == LPFC_NVME_STE_FREE) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6417 NVMET ABORT ctx freed %d %d oxid x%x\n",
 				ctxp->state, ctxp->entry_cnt, ctxp->oxid);
 		rc = WQE_BUSY;
@@ -3512,7 +3510,7 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 
 	atomic_inc(&tgtp->xmt_abort_rsp_error);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6135 Failed to Issue ABTS for oxid x%x. Status x%x "
 			"(%x)\n",
 			ctxp->oxid, rc, released);
@@ -3544,7 +3542,7 @@ lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 		ctxp->state = LPFC_NVME_STE_LS_ABORT;
 		ctxp->entry_cnt++;
 	} else {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6418 NVMET LS abort state mismatch "
 				"IO x%x: %d %d\n",
 				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
@@ -3558,7 +3556,7 @@ lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 		/* Issue ABTS for this WQE based on iotag */
 		ctxp->wqeq = lpfc_sli_get_iocbq(phba);
 		if (!ctxp->wqeq) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6068 Abort failed: No wqeqs: "
 					"xri: x%x\n", xri);
 			/* No failure to an ABTS request. */
@@ -3590,7 +3588,7 @@ lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 	abts_wqeq->context2 = NULL;
 	abts_wqeq->context3 = NULL;
 	lpfc_sli_release_iocbq(phba, abts_wqeq);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6056 Failed to Issue ABTS. Status x%x\n", rc);
 	return 1;
 }
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index a003b7bf000b..81155753cd69 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -867,11 +867,11 @@ lpfc_scsi_prep_dma_buf_s3(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 
 		lpfc_cmd->seg_cnt = nseg;
 		if (lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
-				"9064 BLKGRD: %s: Too many sg segments from "
-			       "dma_map_sg.  Config %d, seg_cnt %d\n",
-			       __func__, phba->cfg_sg_seg_cnt,
-			       lpfc_cmd->seg_cnt);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"9064 BLKGRD: %s: Too many sg segments"
+					" from dma_map_sg.  Config %d, seg_cnt"
+					" %d\n", __func__, phba->cfg_sg_seg_cnt,
+					lpfc_cmd->seg_cnt);
 			WARN_ON_ONCE(lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt);
 			lpfc_cmd->seg_cnt = 0;
 			scsi_dma_unmap(scsi_cmnd);
@@ -1061,7 +1061,8 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 					 * inserted in middle of the IO.
 					 */
 
-					lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+					lpfc_printf_log(phba, KERN_ERR,
+							LOG_TRACE_EVENT,
 					"9076 BLKGRD: Injecting reftag error: "
 					"write lba x%lx + x%x oldrefTag x%x\n",
 					(unsigned long)lba, blockoff,
@@ -1111,7 +1112,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				}
 				rc = BG_ERR_TGT | BG_ERR_CHECK;
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9078 BLKGRD: Injecting reftag error: "
 					"write lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1132,7 +1133,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				}
 				rc = BG_ERR_INIT;
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9077 BLKGRD: Injecting reftag error: "
 					"write lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1159,7 +1160,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				}
 				rc = BG_ERR_INIT;
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9079 BLKGRD: Injecting reftag error: "
 					"read lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1181,7 +1182,8 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 					 * inserted in middle of the IO.
 					 */
 
-					lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+					lpfc_printf_log(phba, KERN_ERR,
+							LOG_TRACE_EVENT,
 					"9080 BLKGRD: Injecting apptag error: "
 					"write lba x%lx + x%x oldappTag x%x\n",
 					(unsigned long)lba, blockoff,
@@ -1230,7 +1232,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				}
 				rc = BG_ERR_TGT | BG_ERR_CHECK;
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0813 BLKGRD: Injecting apptag error: "
 					"write lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1251,7 +1253,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				}
 				rc = BG_ERR_INIT;
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0812 BLKGRD: Injecting apptag error: "
 					"write lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1278,7 +1280,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				}
 				rc = BG_ERR_INIT;
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0814 BLKGRD: Injecting apptag error: "
 					"read lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1313,7 +1315,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				rc |= BG_ERR_TGT | BG_ERR_SWAP;
 				/* Signals the caller to swap CRC->CSUM */
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0817 BLKGRD: Injecting guard error: "
 					"write lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1335,7 +1337,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				rc = BG_ERR_INIT | BG_ERR_SWAP;
 				/* Signals the caller to swap CRC->CSUM */
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0816 BLKGRD: Injecting guard error: "
 					"write lba x%lx\n", (unsigned long)lba);
 				break;
@@ -1363,7 +1365,7 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				rc = BG_ERR_INIT | BG_ERR_SWAP;
 				/* Signals the caller to swap CRC->CSUM */
 
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0818 BLKGRD: Injecting guard error: "
 					"read lba x%lx\n", (unsigned long)lba);
 			}
@@ -1413,7 +1415,7 @@ lpfc_sc_to_bg_opcodes(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 		case SCSI_PROT_NORMAL:
 		default:
-			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"9063 BLKGRD: Bad op/guard:%d/IP combination\n",
 					scsi_get_prot_op(sc));
 			ret = 1;
@@ -1442,7 +1444,7 @@ lpfc_sc_to_bg_opcodes(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 		case SCSI_PROT_NORMAL:
 		default:
-			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"9075 BLKGRD: Bad op/guard:%d/CRC combination\n",
 					scsi_get_prot_op(sc));
 			ret = 1;
@@ -1728,7 +1730,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	sgde = scsi_sglist(sc);
 
 	if (!sgpe || !sgde) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"9020 Invalid s/g entry: data=x%px prot=x%px\n",
 				sgpe, sgde);
 		return 0;
@@ -1840,7 +1842,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				return num_bde + 1;
 
 			if (!sgde) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9065 BLKGRD:%s Invalid data segment\n",
 						__func__);
 				return 0;
@@ -1903,8 +1905,8 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 			reftag += protgrp_blks;
 		} else {
 			/* if we're here, we have a bug */
-			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
-				"9054 BLKGRD: bug in %s\n", __func__);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"9054 BLKGRD: bug in %s\n", __func__);
 		}
 
 	} while (!alldone);
@@ -2154,7 +2156,7 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	sgde = scsi_sglist(sc);
 
 	if (!sgpe || !sgde) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"9082 Invalid s/g entry: data=x%px prot=x%px\n",
 				sgpe, sgde);
 		return 0;
@@ -2307,7 +2309,7 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 				return num_sge + 1;
 
 			if (!sgde) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9086 BLKGRD:%s Invalid data segment\n",
 						__func__);
 				return 0;
@@ -2412,8 +2414,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 			reftag += protgrp_blks;
 		} else {
 			/* if we're here, we have a bug */
-			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
-				"9085 BLKGRD: bug in %s\n", __func__);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"9085 BLKGRD: bug in %s\n", __func__);
 		}
 
 	} while (!alldone);
@@ -2453,7 +2455,7 @@ lpfc_prot_group_type(struct lpfc_hba *phba, struct scsi_cmnd *sc)
 		break;
 	default:
 		if (phba)
-			lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9021 Unsupported protection op:%d\n",
 					op);
 		break;
@@ -2616,7 +2618,7 @@ lpfc_bg_scsi_prep_dma_buf_s3(struct lpfc_hba *phba,
 			scsi_dma_unmap(scsi_cmnd);
 			lpfc_cmd->seg_cnt = 0;
 
-			lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9022 Unexpected protection group %i\n",
 					prot_group_type);
 			return 2;
@@ -2660,7 +2662,7 @@ lpfc_bg_scsi_prep_dma_buf_s3(struct lpfc_hba *phba,
 			     scsi_prot_sg_count(scsi_cmnd),
 			     scsi_cmnd->sc_data_direction);
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"9023 Cannot setup S/G List for HBA"
 			"IO segs %d/%d BPL %d SCSI %d: %d %d\n",
 			lpfc_cmd->seg_cnt, lpfc_cmd->prot_seg_cnt,
@@ -3084,11 +3086,12 @@ lpfc_scsi_prep_dma_buf_s4(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 		lpfc_cmd->seg_cnt = nseg;
 		if (!phba->cfg_xpsgl &&
 		    lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_BG, "9074 BLKGRD:"
-				" %s: Too many sg segments from "
-				"dma_map_sg.  Config %d, seg_cnt %d\n",
-				__func__, phba->cfg_sg_seg_cnt,
-			       lpfc_cmd->seg_cnt);
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+					"9074 BLKGRD:"
+					" %s: Too many sg segments from "
+					"dma_map_sg.  Config %d, seg_cnt %d\n",
+					__func__, phba->cfg_sg_seg_cnt,
+					lpfc_cmd->seg_cnt);
 			WARN_ON_ONCE(lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt);
 			lpfc_cmd->seg_cnt = 0;
 			scsi_dma_unmap(scsi_cmnd);
@@ -3364,7 +3367,7 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 			scsi_dma_unmap(scsi_cmnd);
 			lpfc_cmd->seg_cnt = 0;
 
-			lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"9083 Unexpected protection group %i\n",
 					prot_group_type);
 			return 2;
@@ -3420,7 +3423,7 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 			     scsi_prot_sg_count(scsi_cmnd),
 			     scsi_cmnd->sc_data_direction);
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"9084 Cannot setup S/G List for HBA"
 			"IO segs %d/%d SGL %d SCSI %d: %d %d\n",
 			lpfc_cmd->seg_cnt, lpfc_cmd->prot_seg_cnt,
@@ -3630,17 +3633,17 @@ lpfc_handle_fcp_err(struct lpfc_vport *vport, struct lpfc_io_buf *lpfc_cmd,
 	if (resp_info & RSP_LEN_VALID) {
 		rsplen = be32_to_cpu(fcprsp->rspRspLen);
 		if (rsplen != 0 && rsplen != 4 && rsplen != 8) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
-				 "2719 Invalid response length: "
-				 "tgt x%x lun x%llx cmnd x%x rsplen x%x\n",
-				 cmnd->device->id,
-				 cmnd->device->lun, cmnd->cmnd[0],
-				 rsplen);
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+					 "2719 Invalid response length: "
+					 "tgt x%x lun x%llx cmnd x%x rsplen "
+					 "x%x\n", cmnd->device->id,
+					 cmnd->device->lun, cmnd->cmnd[0],
+					 rsplen);
 			host_status = DID_ERROR;
 			goto out;
 		}
 		if (fcprsp->rspInfo3 != RSP_NO_FAILURE) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2757 Protocol failure detected during "
 				 "processing of FCP I/O op: "
 				 "tgt x%x lun x%llx cmnd x%x rspInfo3 x%x\n",
@@ -3810,7 +3813,7 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 	/* Sanity check on return of outstanding command */
 	cmd = lpfc_cmd->pCmd;
 	if (!cmd || !phba) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2621 IO completion: Not an active IO\n");
 		spin_unlock(&lpfc_cmd->buf_lock);
 		return;
@@ -4273,7 +4276,7 @@ lpfc_scsi_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->lpfc_get_scsi_buf = lpfc_get_scsi_buf_s4;
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1418 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
@@ -4320,7 +4323,7 @@ lpfc_tskmgmt_def_cmpl(struct lpfc_hba *phba,
  *      0,    successful
  */
 int
-lpfc_check_pci_resettable(const struct lpfc_hba *phba)
+lpfc_check_pci_resettable(struct lpfc_hba *phba)
 {
 	const struct pci_dev *pdev = phba->pcidev;
 	struct pci_dev *ptr = NULL;
@@ -4524,7 +4527,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	if ((scsi_get_prot_op(cmnd) != SCSI_PROT_NORMAL) &&
 		(!(phba->sli3_options & LPFC_SLI3_BG_ENABLED))) {
 
-		lpfc_printf_log(phba, KERN_ERR, LOG_BG,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"9058 BLKGRD: ERROR: rcvd protected cmd:%02x"
 				" op:%02x str=%s without registering for"
 				" BlockGuard - Rejecting command\n",
@@ -5163,7 +5166,7 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 
 	if (lpfc_cmd->pCmd == cmnd) {
 		ret = FAILED;
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0748 abort handler timed out waiting "
 				 "for aborting I/O (xri:x%x) to complete: "
 				 "ret %#x, ID %d, LUN %llu\n",
@@ -5356,7 +5359,7 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
 	    (iocbqrsp->iocb.ulpStatus != IOSTAT_SUCCESS)) {
 		if (status != IOCB_SUCCESS ||
 		    iocbqrsp->iocb.ulpStatus != IOSTAT_FCP_RSP_ERROR)
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0727 TMF %s to TGT %d LUN %llu "
 					 "failed (%d, %d) iocb_flag x%x\n",
 					 lpfc_taskmgmt_name(task_mgmt_cmd),
@@ -5471,7 +5474,7 @@ lpfc_reset_flush_io_context(struct lpfc_vport *vport, uint16_t tgt_id,
 		cnt = lpfc_sli_sum_iocb(vport, tgt_id, lun_id, context);
 	}
 	if (cnt) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0724 I/O flush failure for context %s : cnt x%x\n",
 			((context == LPFC_CTX_LUN) ? "LUN" :
 			 ((context == LPFC_CTX_TGT) ? "TGT" :
@@ -5507,7 +5510,7 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 	if (!rdata || !rdata->pnode) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0798 Device Reset rdata failure: rdata x%px\n",
 				 rdata);
 		return FAILED;
@@ -5519,7 +5522,7 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 
 	status = lpfc_chk_tgt_mapped(vport, cmnd);
 	if (status == FAILED) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0721 Device Reset rport failure: rdata x%px\n", rdata);
 		return FAILED;
 	}
@@ -5536,7 +5539,7 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 	status = lpfc_send_taskmgmt(vport, cmnd, tgt_id, lun_id,
 						FCP_LUN_RESET);
 
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0713 SCSI layer issued Device Reset (%d, %llu) "
 			 "return x%x\n", tgt_id, lun_id, status);
 
@@ -5578,7 +5581,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 	if (!rdata || !rdata->pnode) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0799 Target Reset rdata failure: rdata x%px\n",
 				 rdata);
 		return FAILED;
@@ -5590,7 +5593,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 
 	status = lpfc_chk_tgt_mapped(vport, cmnd);
 	if (status == FAILED) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0722 Target Reset rport failure: rdata x%px\n", rdata);
 		if (pnode) {
 			spin_lock_irq(shost->host_lock);
@@ -5615,7 +5618,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 	status = lpfc_send_taskmgmt(vport, cmnd, tgt_id, lun_id,
 					FCP_TARGET_RESET);
 
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0723 SCSI layer issued Target Reset (%d, %llu) "
 			 "return x%x\n", tgt_id, lun_id, status);
 
@@ -5696,7 +5699,7 @@ lpfc_bus_reset_handler(struct scsi_cmnd *cmnd)
 					i, 0, FCP_TARGET_RESET);
 
 		if (status != SUCCESS) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0700 Bus Reset on target %d failed\n",
 					 i);
 			ret = FAILED;
@@ -5713,7 +5716,7 @@ lpfc_bus_reset_handler(struct scsi_cmnd *cmnd)
 	if (status != SUCCESS)
 		ret = FAILED;
 
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0714 SCSI layer issued Bus Reset Data: x%x\n", ret);
 	return ret;
 }
@@ -5742,7 +5745,7 @@ lpfc_host_reset_handler(struct scsi_cmnd *cmnd)
 	struct lpfc_hba *phba = vport->phba;
 	int rc, ret = SUCCESS;
 
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "3172 SCSI layer issued Host Reset Data:\n");
 
 	lpfc_offline_prep(phba, LPFC_MBX_WAIT);
@@ -5759,7 +5762,7 @@ lpfc_host_reset_handler(struct scsi_cmnd *cmnd)
 
 	return ret;
 error:
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "3323 Failed host reset\n");
 	lpfc_unblock_mgmt_io(phba);
 	return FAILED;
@@ -5870,7 +5873,7 @@ lpfc_slave_alloc(struct scsi_device *sdev)
 	}
 	num_allocated = lpfc_new_scsi_buf_s3(vport, num_to_alloc);
 	if (num_to_alloc != num_allocated) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0708 Allocation request of %d "
 					 "command buffers did not succeed.  "
 					 "Allocated %d buffers.\n",
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index a341af0ebb03..a9cb692899a0 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1567,7 +1567,7 @@ lpfc_sli_ring_map(struct lpfc_hba *phba)
 		lpfc_config_ring(phba, i, pmb);
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_POLL);
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0446 Adapter failed to init (%d), "
 					"mbxCmd x%x CFG_RING, mbxStatus x%x, "
 					"ring %d\n",
@@ -1676,7 +1676,7 @@ lpfc_sli_next_iocb_slot (struct lpfc_hba *phba, struct lpfc_sli_ring *pring)
 		pring->sli.sli3.local_getidx = le32_to_cpu(pgp->cmdGetInx);
 
 		if (unlikely(pring->sli.sli3.local_getidx >= max_cmd_idx)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0315 Ring %d issue: portCmdGet %d "
 					"is bigger than cmd ring %d\n",
 					pring->ringno,
@@ -1962,8 +1962,7 @@ lpfc_sli_next_hbq_slot(struct lpfc_hba *phba, uint32_t hbqno)
 		hbqp->local_hbqGetIdx = getidx;
 
 		if (unlikely(hbqp->local_hbqGetIdx >= hbqp->entry_count)) {
-			lpfc_printf_log(phba, KERN_ERR,
-					LOG_SLI | LOG_VPORT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"1802 HBQ %d: local_hbqGetIdx "
 					"%u is > than hbqp->entry_count %u\n",
 					hbqno, hbqp->local_hbqGetIdx,
@@ -2302,7 +2301,7 @@ lpfc_sli_hbqbuf_find(struct lpfc_hba *phba, uint32_t tag)
 		}
 	}
 	spin_unlock_irq(&phba->hbalock);
-	lpfc_printf_log(phba, KERN_ERR, LOG_SLI | LOG_VPORT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"1803 Bad hbq tag. Data: x%x x%x\n",
 			tag, phba->hbqs[tag >> 16].buffer_count);
 	return NULL;
@@ -2556,7 +2555,7 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	/* Check security permission status on INIT_LINK mailbox command */
 	if ((pmb->u.mb.mbxCommand == MBX_INIT_LINK) &&
 	    (pmb->u.mb.mbxStatus == MBXERR_SEC_NO_PERMISSION))
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2860 SLI authentication is required "
 				"for INIT_LINK but has not done yet\n");
 
@@ -2692,7 +2691,7 @@ lpfc_sli_handle_mb_event(struct lpfc_hba *phba)
 		if (lpfc_sli_chk_mbx_command(pmbox->mbxCommand) ==
 		    MBX_SHUTDOWN) {
 			/* Unknown mailbox command compl */
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"(%d):0323 Unknown Mailbox command "
 					"x%x (x%x/x%x) Cmpl\n",
 					pmb->vport ? pmb->vport->vpi :
@@ -2850,7 +2849,7 @@ lpfc_nvme_unsol_ls_handler(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
 	}
 
 	if (unlikely(failwhy)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6154 Drop NVME LS: SID %06X OXID x%X: %s\n",
 				sid, oxid, failwhy);
 		goto out_fail;
@@ -2890,7 +2889,7 @@ lpfc_nvme_unsol_ls_handler(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
 	if (!ret)
 		return;
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"6155 Drop NVME LS from DID %06X: SID %06X OXID x%X "
 			"NVMe%s handler failed %d\n",
 			did, sid, oxid,
@@ -3173,7 +3172,7 @@ lpfc_sli_iocbq_lookup(struct lpfc_hba *phba,
 	}
 
 	spin_unlock_irqrestore(temp_lock, iflag);
-	lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0317 iotag x%x is out of "
 			"range: max iotag x%x wd0 x%x\n",
 			iotag, phba->sli.last_iotag,
@@ -3220,7 +3219,7 @@ lpfc_sli_iocbq_lookup_by_tag(struct lpfc_hba *phba,
 	}
 
 	spin_unlock_irqrestore(temp_lock, iflag);
-	lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0372 iotag x%x lookup error: max iotag (x%x) "
 			"iocb_flag x%x\n",
 			iotag, phba->sli.last_iotag,
@@ -3396,7 +3395,7 @@ lpfc_sli_rsp_pointers_error(struct lpfc_hba *phba, struct lpfc_sli_ring *pring)
 	 * Ring <ringno> handler: portRspPut <portRspPut> is bigger than
 	 * rsp ring <portRspMax>
 	 */
-	lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0312 Ring %d handler: portRspPut %d "
 			"is bigger than rsp ring %d\n",
 			pring->ringno, le32_to_cpu(pgp->rspPutInx),
@@ -3615,7 +3614,7 @@ lpfc_sli_handle_fast_ring_event(struct lpfc_hba *phba,
 					 phba->brd_no, adaptermsg);
 			} else {
 				/* Unknown IOCB command */
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"0334 Unknown IOCB command "
 						"Data: x%x, x%x x%x x%x x%x\n",
 						type, irsp->ulpCommand,
@@ -3813,7 +3812,7 @@ lpfc_sli_sp_handle_rspiocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 					 phba->brd_no, adaptermsg);
 			} else {
 				/* Unknown IOCB command */
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"0335 Unknown IOCB "
 						"command Data: x%x "
 						"x%x x%x x%x\n",
@@ -3893,7 +3892,7 @@ lpfc_sli_handle_slow_ring_event_s3(struct lpfc_hba *phba,
 		 * Ring <ringno> handler: portRspPut <portRspPut> is bigger than
 		 * rsp ring <portRspMax>
 		 */
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0303 Ring %d handler: portRspPut %d "
 				"is bigger than rsp ring %d\n",
 				pring->ringno, portRspPut, portRspMax);
@@ -4265,7 +4264,7 @@ lpfc_sli_brdready_s3(struct lpfc_hba *phba, uint32_t mask)
 
 	/* Check to see if any errors occurred during init */
 	if ((status & HS_FFERM) || (i >= 20)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2751 Adapter failed to restart, "
 				"status reg x%x, FW Data: A8 x%x AC x%x\n",
 				status,
@@ -4487,7 +4486,7 @@ lpfc_sli_brdkill(struct lpfc_hba *phba)
 	if (retval != MBX_SUCCESS) {
 		if (retval != MBX_BUSY)
 			mempool_free(pmb, phba->mbox_mem_pool);
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2752 KILL_BOARD command failed retval %d\n",
 				retval);
 		spin_lock_irq(&phba->hbalock);
@@ -4839,7 +4838,7 @@ lpfc_sli_chipset_init(struct lpfc_hba *phba)
 		if (i++ >= 200) {
 			/* Adapter failed to init, timeout, status reg
 			   <status> */
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0436 Adapter failed to init, "
 					"timeout, status reg x%x, "
 					"FW Data: A8 x%x AC x%x\n", status,
@@ -4854,7 +4853,7 @@ lpfc_sli_chipset_init(struct lpfc_hba *phba)
 			/* ERROR: During chipset initialization */
 			/* Adapter failed to init, chipset, status reg
 			   <status> */
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0437 Adapter failed to init, "
 					"chipset, status reg x%x, "
 					"FW Data: A8 x%x AC x%x\n", status,
@@ -4885,7 +4884,7 @@ lpfc_sli_chipset_init(struct lpfc_hba *phba)
 	if (status & HS_FFERM) {
 		/* ERROR: During chipset initialization */
 		/* Adapter failed to init, chipset, status reg <status> */
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0438 Adapter failed to init, chipset, "
 				"status reg x%x, "
 				"FW Data: A8 x%x AC x%x\n", status,
@@ -5108,7 +5107,7 @@ lpfc_sli_config_port(struct lpfc_hba *phba, int sli_mode)
 					LPFC_SLI3_CRP_ENABLED |
 					LPFC_SLI3_DSS_ENABLED);
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0442 Adapter failed to init, mbxCmd x%x "
 				"CONFIG_PORT, mbxStatus x%x Data: x%x\n",
 				pmb->u.mb.mbxCommand, pmb->u.mb.mbxStatus, 0);
@@ -5158,7 +5157,7 @@ lpfc_sli_config_port(struct lpfc_hba *phba, int sli_mode)
 			if (pmb->u.mb.un.varCfgPort.gbg == 0) {
 				phba->cfg_enable_bg = 0;
 				phba->sli3_options &= ~LPFC_SLI3_BG_ENABLED;
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"0443 Adapter did not grant "
 						"BlockGuard\n");
 			}
@@ -5197,7 +5196,7 @@ lpfc_sli_hba_setup(struct lpfc_hba *phba)
 	switch (phba->cfg_sli_mode) {
 	case 2:
 		if (phba->cfg_enable_npiv) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_VPORT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1824 NPIV enabled: Override sli_mode "
 				"parameter (%d) to auto (0).\n",
 				phba->cfg_sli_mode);
@@ -5209,7 +5208,7 @@ lpfc_sli_hba_setup(struct lpfc_hba *phba)
 	case 3:
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1819 Unrecognized sli_mode parameter: %d.\n",
 				phba->cfg_sli_mode);
 
@@ -5220,7 +5219,7 @@ lpfc_sli_hba_setup(struct lpfc_hba *phba)
 	rc = lpfc_sli_config_port(phba, mode);
 
 	if (rc && phba->cfg_sli_mode == 3)
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1820 Unable to select SLI-3.  "
 				"Not supported by adapter.\n");
 	if (rc && mode != 2)
@@ -5314,7 +5313,7 @@ lpfc_sli_hba_setup(struct lpfc_hba *phba)
 
 lpfc_sli_hba_setup_error:
 	phba->link_state = LPFC_HBA_ERROR;
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0445 Firmware initialization failed\n");
 	return rc;
 }
@@ -5511,7 +5510,7 @@ lpfc_sli4_get_ctl_attr(struct lpfc_hba *phba)
 			LPFC_SLI4_MBX_NEMBED);
 
 	if (alloclen < reqlen) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3084 Allocated DMA memory size (%d) is "
 				"less than the requested DMA memory size "
 				"(%d)\n", alloclen, reqlen);
@@ -5771,7 +5770,7 @@ lpfc_sli4_get_avail_extnt_rsrc(struct lpfc_hba *phba, uint16_t type,
 	rsrc_info = &mbox->u.mqe.un.rsrc_extent_info;
 	if (bf_get(lpfc_mbox_hdr_status,
 		   &rsrc_info->header.cfg_shdr.response)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2930 Failed to get resource extents "
 				"Status 0x%x Add'l Status 0x%x\n",
 				bf_get(lpfc_mbox_hdr_status,
@@ -5909,7 +5908,7 @@ lpfc_sli4_cfg_post_extnts(struct lpfc_hba *phba, uint16_t extnt_cnt,
 				     LPFC_MBOX_OPCODE_ALLOC_RSRC_EXTENT,
 				     req_len, *emb);
 	if (alloc_len < req_len) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2982 Allocated DMA memory size (x%x) is "
 			"less than the requested DMA memory "
 			"size (x%x)\n", alloc_len, req_len);
@@ -5965,7 +5964,7 @@ lpfc_sli4_alloc_extent(struct lpfc_hba *phba, uint16_t type)
 		return -EIO;
 
 	if ((rsrc_cnt == 0) || (rsrc_size == 0)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"3009 No available Resource Extents "
 			"for resource type 0x%x: Count: 0x%x, "
 			"Size 0x%x\n", type, rsrc_cnt,
@@ -6216,7 +6215,7 @@ lpfc_sli4_dealloc_extent(struct lpfc_hba *phba, uint16_t type)
 	dealloc_rsrc = &mbox->u.mqe.un.dealloc_rsrc_extents;
 	if (bf_get(lpfc_mbox_hdr_status,
 		   &dealloc_rsrc->header.cfg_shdr.response)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2919 Failed to release resource extents "
 				"for type %d - Status 0x%x Add'l Status 0x%x. "
 				"Resource memory not released.\n",
@@ -6410,7 +6409,7 @@ lpfc_sli4_ras_dma_alloc(struct lpfc_hba *phba,
 					    &ras_fwlog->lwpd.phys,
 					    GFP_KERNEL);
 	if (!ras_fwlog->lwpd.virt) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6185 LWPD Memory Alloc Failed\n");
 
 		return -ENOMEM;
@@ -6471,7 +6470,7 @@ lpfc_sli4_ras_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 
 	if (mb->mbxStatus != MBX_SUCCESS || shdr_status) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6188 FW LOG mailbox "
 				"completed with status x%x add_status x%x,"
 				" mbx status x%x\n",
@@ -6539,7 +6538,7 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
 	/* Setup Mailbox command */
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6190 RAS MBX Alloc Failed");
 		rc = -ENOMEM;
 		goto mem_free;
@@ -6587,7 +6586,7 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6191 FW-Log Mailbox failed. "
 				"status %d mbxStatus : x%x", rc,
 				bf_get(lpfc_mqe_status, &mbox->u.mqe));
@@ -6723,7 +6722,7 @@ lpfc_sli4_alloc_resource_identifiers(struct lpfc_hba *phba)
 		/* RPIs. */
 		count = phba->sli4_hba.max_cfg_param.max_rpi;
 		if (count <= 0) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3279 Invalid provisioning of "
 					"rpi:%d\n", count);
 			rc = -EINVAL;
@@ -6751,7 +6750,7 @@ lpfc_sli4_alloc_resource_identifiers(struct lpfc_hba *phba)
 		/* VPIs. */
 		count = phba->sli4_hba.max_cfg_param.max_vpi;
 		if (count <= 0) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3280 Invalid provisioning of "
 					"vpi:%d\n", count);
 			rc = -EINVAL;
@@ -6778,7 +6777,7 @@ lpfc_sli4_alloc_resource_identifiers(struct lpfc_hba *phba)
 		/* XRIs. */
 		count = phba->sli4_hba.max_cfg_param.max_xri;
 		if (count <= 0) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3281 Invalid provisioning of "
 					"xri:%d\n", count);
 			rc = -EINVAL;
@@ -6807,7 +6806,7 @@ lpfc_sli4_alloc_resource_identifiers(struct lpfc_hba *phba)
 		/* VFIs. */
 		count = phba->sli4_hba.max_cfg_param.max_vfi;
 		if (count <= 0) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3282 Invalid provisioning of "
 					"vfi:%d\n", count);
 			rc = -EINVAL;
@@ -6985,7 +6984,7 @@ lpfc_sli4_get_allocated_extnts(struct lpfc_hba *phba, uint16_t type,
 				     LPFC_MBOX_OPCODE_GET_ALLOC_RSRC_EXTENT,
 				     req_len, emb);
 	if (alloc_len < req_len) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2983 Allocated DMA memory size (x%x) is "
 			"less than the requested DMA memory "
 			"size (x%x)\n", alloc_len, req_len);
@@ -7028,7 +7027,7 @@ lpfc_sli4_get_allocated_extnts(struct lpfc_hba *phba, uint16_t type,
 	}
 
 	if (bf_get(lpfc_mbox_hdr_status, &shdr->response)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2984 Failed to read allocated resources "
 			"for type %d - Status 0x%x Add'l Status 0x%x.\n",
 			type,
@@ -7183,7 +7182,7 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 		spin_unlock(&phba->sli4_hba.sgl_list_lock);
 		spin_unlock_irq(&phba->hbalock);
 	} else {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3161 Failure to post sgl to port.\n");
 		return -EIO;
 	}
@@ -7280,7 +7279,7 @@ lpfc_post_rq_buffer(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 		drqe.address_hi = putPaddrHigh(rqb_buffer->dbuf.phys);
 		rc = lpfc_sli4_rq_put(hrq, drq, &hrqe, &drqe);
 		if (rc < 0) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6421 Cannot post to HRQ %d: %x %x %x "
 					"DRQ %x %x\n",
 					hrq->queue_id,
@@ -7355,7 +7354,7 @@ static void lpfc_sli4_dip(struct lpfc_hba *phba)
 			return;
 
 		if (bf_get(lpfc_sliport_status_dip, &reg_data))
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2904 Firmware Dump Image Present"
 					" on Adapter");
 	}
@@ -7441,7 +7440,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	phba->hba_flag &= ~HBA_IOQ_FLUSH;
 
 	if (phba->sli_rev != LPFC_SLI_REV4) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0376 READ_REV Error. SLI Level %d "
 			"FCoE enabled %d\n",
 			phba->sli_rev, phba->hba_flag & HBA_FCOE_MODE);
@@ -7483,7 +7482,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	 */
 	rc = lpfc_parse_vpd(phba, vpd, vpd_size);
 	if (unlikely(!rc)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0377 Error %d parsing vpd. "
 				"Using defaults.\n", rc);
 		rc = 0;
@@ -7622,7 +7621,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 	dd = bf_get(lpfc_mbx_set_feature_dd, &mboxq->u.mqe.un.set_feature);
 	if ((rc == MBX_SUCCESS) && (dd == LPFC_ENABLE_DUAL_DUMP))
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI | LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 				"6448 Dual Dump is enabled\n");
 	else
 		lpfc_printf_log(phba, KERN_INFO, LOG_SLI | LOG_INIT,
@@ -7640,7 +7639,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	 */
 	rc = lpfc_sli4_alloc_resource_identifiers(phba);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2920 Failed to alloc Resource IDs "
 				"rc = x%x\n", rc);
 		goto out_free_mbox;
@@ -7679,7 +7678,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	kfree(mp);
 	mboxq->ctx_buf = NULL;
 	if (unlikely(rc)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0382 READ_SPARAM command failed "
 				"status %d, mbxStatus x%x\n",
 				rc, bf_get(lpfc_mqe_status, mqe));
@@ -7697,7 +7696,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Create all the SLI4 queues */
 	rc = lpfc_sli4_queue_create(phba);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3089 Failed to allocate queues\n");
 		rc = -ENODEV;
 		goto out_free_mbox;
@@ -7705,7 +7704,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Set up all the queues to the device */
 	rc = lpfc_sli4_queue_setup(phba);
 	if (unlikely(rc)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0381 Error %d during queue setup.\n ", rc);
 		goto out_stop_timers;
 	}
@@ -7716,7 +7715,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* update host els xri-sgl sizes and mappings */
 	rc = lpfc_sli4_els_sgl_update(phba);
 	if (unlikely(rc)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1400 Failed to update xri-sgl size and "
 				"mapping: %d\n", rc);
 		goto out_destroy_queue;
@@ -7726,7 +7725,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	rc = lpfc_sli4_repost_sgl_list(phba, &phba->sli4_hba.lpfc_els_sgl_list,
 				       phba->sli4_hba.els_xri_cnt);
 	if (unlikely(rc < 0)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0582 Error %d during els sgl post "
 				"operation\n", rc);
 		rc = -ENODEV;
@@ -7738,7 +7737,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		/* update host nvmet xri-sgl sizes and mappings */
 		rc = lpfc_sli4_nvmet_sgl_update(phba);
 		if (unlikely(rc)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6308 Failed to update nvmet-sgl size "
 					"and mapping: %d\n", rc);
 			goto out_destroy_queue;
@@ -7750,7 +7749,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 			&phba->sli4_hba.lpfc_nvmet_sgl_list,
 			phba->sli4_hba.nvmet_xri_cnt);
 		if (unlikely(rc < 0)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3117 Error %d during nvmet "
 					"sgl post\n", rc);
 			rc = -ENODEV;
@@ -7767,7 +7766,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		/* update host common xri-sgl sizes and mappings */
 		rc = lpfc_sli4_io_sgl_update(phba);
 		if (unlikely(rc)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6082 Failed to update nvme-sgl size "
 					"and mapping: %d\n", rc);
 			goto out_destroy_queue;
@@ -7776,7 +7775,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		/* register the allocated common sgl pool to the port */
 		rc = lpfc_sli4_repost_io_sgl_list(phba);
 		if (unlikely(rc)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6116 Error %d during nvme sgl post "
 					"operation\n", rc);
 			/* Some NVME buffers were moved to abort nvme list */
@@ -7797,7 +7796,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 				cnt);
 		rc = lpfc_init_iocb_list(phba, cnt);
 		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"1413 Failed to init iocb list.\n");
 			goto out_destroy_queue;
 		}
@@ -7826,7 +7825,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Post the rpi header region to the device. */
 	rc = lpfc_sli4_post_all_rpi_hdrs(phba);
 	if (unlikely(rc)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0393 Error %d during rpi post operation\n",
 				rc);
 		rc = -ENODEV;
@@ -7970,12 +7969,12 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 
 	if (!(phba->hba_flag & HBA_FCOE_MODE) &&
 	    (phba->hba_flag & LINK_DISABLED)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3103 Adapter Link is disabled.\n");
 		lpfc_down_link(phba, mboxq);
 		rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3104 Adapter failed to issue "
 					"DOWN_LINK mbox cmd, rc:x%x\n", rc);
 			goto out_io_buff_free;
@@ -8182,7 +8181,7 @@ lpfc_mbox_timeout_handler(struct lpfc_hba *phba)
 	}
 
 	/* Mbox cmd <mbxCommand> timeout */
-	lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0310 Mailbox command x%x timeout Data: x%x x%x x%px\n",
 			mb->mbxCommand,
 			phba->pport->port_state,
@@ -8204,7 +8203,7 @@ lpfc_mbox_timeout_handler(struct lpfc_hba *phba)
 
 	lpfc_sli_abort_fcp_rings(phba);
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0345 Resetting board due to mailbox timeout\n");
 
 	/* Reset the HBA device */
@@ -8302,7 +8301,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 		spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
 
 		/* Mbox command <mbxCommand> cannot issue */
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"(%d):0311 Mailbox command x%x cannot "
 				"issue Data: x%x x%x\n",
 				pmbox->vport ? pmbox->vport->vpi : 0,
@@ -8314,7 +8313,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 		if (lpfc_readl(phba->HCregaddr, &hc_copy) ||
 			!(hc_copy & HC_MBINT_ENA)) {
 			spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"(%d):2528 Mailbox command x%x cannot "
 				"issue Data: x%x x%x\n",
 				pmbox->vport ? pmbox->vport->vpi : 0,
@@ -8333,7 +8332,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
 
 			/* Mbox command <mbxCommand> cannot issue */
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"(%d):2529 Mailbox command x%x "
 					"cannot issue Data: x%x x%x\n",
 					pmbox->vport ? pmbox->vport->vpi : 0,
@@ -8345,7 +8344,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 		if (!(psli->sli_flag & LPFC_SLI_ACTIVE)) {
 			spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
 			/* Mbox command <mbxCommand> cannot issue */
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"(%d):2530 Mailbox command x%x "
 					"cannot issue Data: x%x x%x\n",
 					pmbox->vport ? pmbox->vport->vpi : 0,
@@ -8398,7 +8397,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			psli->sli_flag &= ~LPFC_SLI_MBOX_ACTIVE;
 			spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
 			/* Mbox command <mbxCommand> cannot issue */
-			lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"(%d):2531 Mailbox command x%x "
 					"cannot issue Data: x%x x%x\n",
 					pmbox->vport ? pmbox->vport->vpi : 0,
@@ -8789,7 +8788,7 @@ lpfc_sli4_post_sync_mbox(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	if (psli->sli_flag & LPFC_SLI_MBOX_ACTIVE) {
 		spin_unlock_irqrestore(&phba->hbalock, iflag);
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"(%d):2532 Mailbox command x%x (x%x/x%x) "
 				"cannot issue Data: x%x x%x\n",
 				mboxq->vport ? mboxq->vport->vpi : 0,
@@ -8910,7 +8909,7 @@ lpfc_sli_issue_mbox_s4(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq,
 
 	rc = lpfc_mbox_dev_check(phba);
 	if (unlikely(rc)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"(%d):2544 Mailbox command x%x (x%x/x%x) "
 				"cannot issue Data: x%x x%x\n",
 				mboxq->vport ? mboxq->vport->vpi : 0,
@@ -8987,7 +8986,7 @@ lpfc_sli_issue_mbox_s4(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq,
 	/* Now, interrupt mode asynchronous mailbox command */
 	rc = lpfc_mbox_cmd_check(phba, mboxq);
 	if (rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"(%d):2543 Mailbox command x%x (x%x/x%x) "
 				"cannot issue Data: x%x x%x\n",
 				mboxq->vport ? mboxq->vport->vpi : 0,
@@ -9055,7 +9054,7 @@ lpfc_sli4_post_async_mbox(struct lpfc_hba *phba)
 	}
 	if (unlikely(phba->sli.mbox_active)) {
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0384 There is pending active mailbox cmd\n");
 		return MBX_NOT_FINISHED;
 	}
@@ -9116,7 +9115,7 @@ lpfc_sli4_post_async_mbox(struct lpfc_hba *phba)
 	/* Post the mailbox command to the port */
 	rc = lpfc_sli4_mq_put(phba->sli4_hba.mbx_wq, mqe);
 	if (rc != MBX_SUCCESS) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"(%d):2533 Mailbox command x%x (x%x/x%x) "
 				"cannot issue Data: x%x x%x\n",
 				mboxq->vport ? mboxq->vport->vpi : 0,
@@ -9192,7 +9191,7 @@ lpfc_mbox_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->lpfc_sli_brdready = lpfc_sli_brdready_s4;
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1420 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
@@ -9293,8 +9292,7 @@ __lpfc_sli_issue_iocb_s3(struct lpfc_hba *phba, uint32_t ring_number,
 	if (piocb->iocb_cmpl && (!piocb->vport) &&
 	   (piocb->iocb.ulpCommand != CMD_ABORT_XRI_CN) &&
 	   (piocb->iocb.ulpCommand != CMD_CLOSE_XRI_CN)) {
-		lpfc_printf_log(phba, KERN_ERR,
-				LOG_SLI | LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1807 IOCB x%x failed. No vport\n",
 				piocb->iocb.ulpCommand);
 		dump_stack();
@@ -9591,7 +9589,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 		else
 			ndlp = (struct lpfc_nodelist *)iocbq->context1;
 		if (!iocbq->iocb.ulpLe) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2007 Only Limited Edition cmd Format"
 				" supported 0x%x\n",
 				iocbq->iocb.ulpCommand);
@@ -9917,7 +9915,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 		/* word6 context tag copied in memcpy */
 		if (iocbq->iocb.ulpCt_h  || iocbq->iocb.ulpCt_l) {
 			ct = ((iocbq->iocb.ulpCt_h << 1) | iocbq->iocb.ulpCt_l);
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2015 Invalid CT %x command 0x%x\n",
 				ct, iocbq->iocb.ulpCommand);
 			return IOCB_ERROR;
@@ -10096,7 +10094,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 	case CMD_FCP_TRSP64_CX: /* Target mode rcv */
 	case CMD_FCP_AUTO_TRSP_CX: /* Auto target rsp */
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2014 Invalid command 0x%x\n",
 				iocbq->iocb.ulpCommand);
 		return IOCB_ERROR;
@@ -10259,7 +10257,7 @@ lpfc_sli_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->__lpfc_sli_release_iocbq = __lpfc_sli_release_iocbq_s4;
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1419 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
@@ -10519,13 +10517,13 @@ lpfc_sli_async_event_handler(struct lpfc_hba * phba,
 		temp_event_data.event_type = FC_REG_TEMPERATURE_EVENT;
 		if (evt_code == ASYNC_TEMP_WARN) {
 			temp_event_data.event_code = LPFC_THRESHOLD_TEMP;
-			lpfc_printf_log(phba, KERN_ERR, LOG_TEMP,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0347 Adapter is very hot, please take "
 				"corrective action. temperature : %d Celsius\n",
 				(uint32_t) icmd->ulpContext);
 		} else {
 			temp_event_data.event_code = LPFC_NORMAL_TEMP;
-			lpfc_printf_log(phba, KERN_ERR, LOG_TEMP,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0340 Adapter temperature is OK now. "
 				"temperature : %d Celsius\n",
 				(uint32_t) icmd->ulpContext);
@@ -10542,7 +10540,7 @@ lpfc_sli_async_event_handler(struct lpfc_hba * phba,
 		break;
 	default:
 		iocb_w = (uint32_t *) icmd;
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0346 Ring %d handler: unexpected ASYNC_STATUS"
 			" evt_code 0x%x\n"
 			"W0  0x%08x W1  0x%08x W2  0x%08x W3  0x%08x\n"
@@ -11216,7 +11214,7 @@ lpfc_sli_ring_taggedbuf_get(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	}
 
 	spin_unlock_irq(&phba->hbalock);
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0402 Cannot find virtual addr for buffer tag on "
 			"ring %d Data x%lx x%px x%px x%x\n",
 			pring->ringno, (unsigned long) tag,
@@ -11260,7 +11258,7 @@ lpfc_sli_ringpostbuf_get(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	}
 
 	spin_unlock_irq(&phba->hbalock);
-	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0410 Cannot find virtual addr for mapped buf on "
 			"ring %d Data x%llx x%px x%px x%x\n",
 			pring->ringno, (unsigned long long)phys,
@@ -12154,12 +12152,12 @@ lpfc_sli_issue_iocb_wait(struct lpfc_hba *phba,
 			 * completed. Not that it completed successfully.
 			 * */
 		} else if (timeleft == 0) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0338 IOCB wait timeout error - no "
 					"wake response Data x%x\n", timeout);
 			retval = IOCB_TIMEDOUT;
 		} else {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0330 IOCB wake NOT set, "
 					"Data x%x x%lx\n",
 					timeout, (timeleft / jiffies));
@@ -12421,7 +12419,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 		}
 		if ((~phba->sli4_hba.ue_mask_lo & uerr_sta_lo) ||
 		    (~phba->sli4_hba.ue_mask_hi & uerr_sta_hi)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"1423 HBA Unrecoverable error: "
 					"uerr_lo_reg=0x%x, uerr_hi_reg=0x%x, "
 					"ue_mask_lo_reg=0x%x, "
@@ -12452,7 +12450,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 				readl(phba->sli4_hba.u.if_type2.ERR1regaddr);
 			phba->work_status[1] =
 				readl(phba->sli4_hba.u.if_type2.ERR2regaddr);
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2885 Port Status Event: "
 					"port status reg 0x%x, "
 					"port smphr reg 0x%x, "
@@ -12468,7 +12466,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 		break;
 	case LPFC_SLI_INTF_IF_TYPE_1:
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2886 HBA Error Attention on unsupported "
 				"if type %d.", if_type);
 		return 1;
@@ -12532,7 +12530,7 @@ lpfc_sli_check_eratt(struct lpfc_hba *phba)
 		ha_copy = lpfc_sli4_eratt_read(phba);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0299 Invalid SLI revision (%d)\n",
 				phba->sli_rev);
 		ha_copy = 0;
@@ -12765,8 +12763,7 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 				 * Stray Mailbox Interrupt, mbxCommand <cmd>
 				 * mbxStatus <status>
 				 */
-				lpfc_printf_log(phba, KERN_ERR, LOG_MBOX |
-						LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"(%d):0304 Stray Mailbox "
 						"Interrupt mbxCommand x%x "
 						"mbxStatus x%x\n",
@@ -12826,7 +12823,7 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 						if (rc != MBX_BUSY)
 							lpfc_printf_log(phba,
 							KERN_ERR,
-							LOG_MBOX | LOG_SLI,
+							LOG_TRACE_EVENT,
 							"0350 rc should have"
 							"been MBX_BUSY\n");
 						if (rc != MBX_NOT_FINISHED)
@@ -12855,8 +12852,9 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 							 MBX_NOWAIT);
 			} while (rc == MBX_NOT_FINISHED);
 			if (rc != MBX_SUCCESS)
-				lpfc_printf_log(phba, KERN_ERR, LOG_MBOX |
-						LOG_SLI, "0349 rc should be "
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
+						"0349 rc should be "
 						"MBX_SUCCESS\n");
 		}
 
@@ -13283,7 +13281,7 @@ lpfc_cq_event_setup(struct lpfc_hba *phba, void *entry, int size)
 	/* Allocate a new internal CQ_EVENT entry */
 	cq_event = lpfc_sli4_cq_event_alloc(phba);
 	if (!cq_event) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0602 Failed to alloc CQ_EVENT entry\n");
 		return NULL;
 	}
@@ -13358,7 +13356,7 @@ lpfc_sli4_sp_handle_mbox_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	pmb = phba->sli.mbox_active;
 	if (unlikely(!pmb)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_MBOX,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1832 No pending MBOX command to handle\n");
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 		goto out_no_mqe_complete;
@@ -13407,8 +13405,9 @@ lpfc_sli4_sp_handle_mbox_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 			pmb->vport = vport;
 			rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
 			if (rc != MBX_BUSY)
-				lpfc_printf_log(phba, KERN_ERR, LOG_MBOX |
-						LOG_SLI, "0385 rc should "
+				lpfc_printf_log(phba, KERN_ERR,
+						LOG_TRACE_EVENT,
+						"0385 rc should "
 						"have been MBX_BUSY\n");
 			if (rc != MBX_NOT_FINISHED)
 				goto send_current_mbox;
@@ -13515,7 +13514,7 @@ lpfc_sli4_sp_handle_els_wcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 			txq_cnt++;
 		if (!list_empty(&pring->txcmplq))
 			txcmplq_cnt++;
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0387 NO IOCBQ data: txq_cnt=%d iocb_cnt=%d "
 			"els_txcmplq_cnt=%d\n",
 			txq_cnt, phba->iocb_cnt,
@@ -13606,7 +13605,7 @@ lpfc_sli4_sp_handle_abort_xri_wcqe(struct lpfc_hba *phba,
 		workposted = true;
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0603 Invalid CQ subtype %d: "
 				"%08x %08x %08x %08x\n",
 				cq->subtype, wcqe->word0, wcqe->parameter,
@@ -13654,7 +13653,7 @@ lpfc_sli4_sp_handle_rcqe(struct lpfc_hba *phba, struct lpfc_rcqe *rcqe)
 	status = bf_get(lpfc_rcqe_status, rcqe);
 	switch (status) {
 	case FC_STATUS_RQ_BUF_LEN_EXCEEDED:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2537 Receive Frame Truncated!!\n");
 		/* fall through */
 	case FC_STATUS_RQ_SUCCESS:
@@ -13691,7 +13690,7 @@ lpfc_sli4_sp_handle_rcqe(struct lpfc_hba *phba, struct lpfc_rcqe *rcqe)
 	case FC_STATUS_INSUFF_BUF_FRM_DISC:
 		if (phba->nvmet_support) {
 			tgtp = phba->targetport->private;
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI | LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6402 RQE Error x%x, posted %d err_cnt "
 					"%d: %x %x %x\n",
 					status, hrq->RQ_buf_posted,
@@ -13763,7 +13762,7 @@ lpfc_sli4_sp_handle_cqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 				(struct lpfc_rcqe *)&cqevt);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0388 Not a valid WCQE code: x%x\n",
 				bf_get(lpfc_cqe_code, &cqevt));
 		break;
@@ -13803,7 +13802,7 @@ lpfc_sli4_sp_handle_eqe(struct lpfc_hba *phba, struct lpfc_eqe *eqe,
 	}
 	if (unlikely(!cq)) {
 		if (phba->sli.sli_flag & LPFC_SLI_ACTIVE)
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0365 Slow-path CQ identifier "
 					"(%d) does not exist\n", cqid);
 		return;
@@ -13818,7 +13817,7 @@ lpfc_sli4_sp_handle_eqe(struct lpfc_hba *phba, struct lpfc_eqe *eqe,
 		ret = queue_work_on(cq->chann, phba->wq, &cq->spwork);
 
 	if (!ret)
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0390 Cannot schedule queue work "
 				"for CQ eqcqid=%d, cqid=%d on CPU %d\n",
 				cqid, cq->queue_id, raw_smp_processor_id());
@@ -13956,7 +13955,7 @@ __lpfc_sli4_sp_process_cq(struct lpfc_queue *cq)
 						&delay, LPFC_QUEUE_WORK);
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0370 Invalid completion queue type (%d)\n",
 				cq->type);
 		return;
@@ -13970,7 +13969,7 @@ __lpfc_sli4_sp_process_cq(struct lpfc_queue *cq)
 			ret = queue_delayed_work_on(cq->chann, phba->wq,
 						&cq->sched_spwork, delay);
 		if (!ret)
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0394 Cannot schedule queue work "
 				"for cqid=%d on CPU %d\n",
 				cq->queue_id, cq->chann);
@@ -14180,7 +14179,7 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 	status = bf_get(lpfc_rcqe_status, rcqe);
 	switch (status) {
 	case FC_STATUS_RQ_BUF_LEN_EXCEEDED:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6126 Receive Frame Truncated!!\n");
 		/* fall through */
 	case FC_STATUS_RQ_SUCCESS:
@@ -14220,7 +14219,7 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 	case FC_STATUS_INSUFF_BUF_FRM_DISC:
 		if (phba->nvmet_support) {
 			tgtp = phba->targetport->private;
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI | LOG_NVME,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"6401 RQE Error x%x, posted %d err_cnt "
 					"%d: %x %x %x\n",
 					status, hrq->RQ_buf_posted,
@@ -14294,7 +14293,7 @@ lpfc_sli4_fp_handle_cqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 		}
 		break;
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0144 Not a valid CQE code: x%x\n",
 				bf_get(lpfc_wcqe_c_code, &wcqe));
 		break;
@@ -14332,7 +14331,7 @@ static void lpfc_sli4_sched_cq_work(struct lpfc_hba *phba,
 		else
 			ret = queue_work_on(cq->chann, phba->wq, &cq->irqwork);
 		if (!ret)
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0383 Cannot schedule queue work "
 					"for CQ eqcqid=%d, cqid=%d on CPU %d\n",
 					cqid, cq->queue_id,
@@ -14361,7 +14360,7 @@ lpfc_sli4_hba_handle_eqe(struct lpfc_hba *phba, struct lpfc_queue *eq,
 	uint16_t cqid, id;
 
 	if (unlikely(bf_get_le32(lpfc_eqe_major_code, eqe) != 0)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0366 Not a valid completion "
 				"event: majorcode=x%x, minorcode=x%x\n",
 				bf_get_le32(lpfc_eqe_major_code, eqe),
@@ -14404,7 +14403,7 @@ lpfc_sli4_hba_handle_eqe(struct lpfc_hba *phba, struct lpfc_queue *eq,
 
 process_cq:
 	if (unlikely(cqid != cq->queue_id)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0368 Miss-matched fast-path completion "
 				"queue identifier: eqcqid=%d, fcpcqid=%d\n",
 				cqid, cq->queue_id);
@@ -14458,7 +14457,7 @@ __lpfc_sli4_hba_process_cq(struct lpfc_queue *cq,
 			ret = queue_delayed_work_on(cq->chann, phba->wq,
 						&cq->sched_irqwork, delay);
 		if (!ret)
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"0367 Cannot schedule queue work "
 					"for cqid=%d on CPU %d\n",
 					cq->queue_id, cq->chann);
@@ -14989,7 +14988,7 @@ lpfc_modify_hba_eq_delay(struct lpfc_hba *phba, uint32_t startq,
 
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_FCP | LOG_NVME,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6428 Failed allocating mailbox cmd buffer."
 				" EQ delay was not set.\n");
 		return;
@@ -15031,7 +15030,7 @@ lpfc_modify_hba_eq_delay(struct lpfc_hba *phba, uint32_t startq,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2512 MODIFY_EQ_DELAY mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -15108,7 +15107,7 @@ lpfc_eq_create(struct lpfc_hba *phba, struct lpfc_queue *eq, uint32_t imax)
 	       dmult);
 	switch (eq->entry_count) {
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0360 Unsupported EQ count. (%d)\n",
 				eq->entry_count);
 		if (eq->entry_count < 256) {
@@ -15152,7 +15151,7 @@ lpfc_eq_create(struct lpfc_hba *phba, struct lpfc_queue *eq, uint32_t imax)
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2500 EQ_CREATE mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -15257,7 +15256,7 @@ lpfc_cq_create(struct lpfc_hba *phba, struct lpfc_queue *cq,
 		}
 		/* fall through */
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0361 Unsupported CQ count: "
 				"entry cnt %d sz %d pg cnt %d\n",
 				cq->entry_count, cq->entry_size,
@@ -15293,7 +15292,7 @@ lpfc_cq_create(struct lpfc_hba *phba, struct lpfc_queue *cq,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2501 CQ_CREATE mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -15380,7 +15379,7 @@ lpfc_cq_create_set(struct lpfc_hba *phba, struct lpfc_queue **cqp,
 			LPFC_MBOX_OPCODE_FCOE_CQ_CREATE_SET, length,
 			LPFC_SLI4_MBX_NEMBED);
 	if (alloclen < length) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3098 Allocated DMA memory size (%d) is "
 				"less than the requested DMA memory size "
 				"(%d)\n", alloclen, length);
@@ -15434,7 +15433,7 @@ lpfc_cq_create_set(struct lpfc_hba *phba, struct lpfc_queue **cqp,
 				}
 				/* fall through */
 			default:
-				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3118 Bad CQ count. (%d)\n",
 						cq->entry_count);
 				if (cq->entry_count < 256) {
@@ -15552,7 +15551,7 @@ lpfc_cq_create_set(struct lpfc_hba *phba, struct lpfc_queue **cqp,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3119 CQ_CREATE_SET mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -15710,7 +15709,7 @@ lpfc_mq_create(struct lpfc_hba *phba, struct lpfc_queue *mq,
 		       cq->queue_id);
 	switch (mq->entry_count) {
 	default:
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0362 Unsupported MQ count. (%d)\n",
 				mq->entry_count);
 		if (mq->entry_count < 16) {
@@ -15766,7 +15765,7 @@ lpfc_mq_create(struct lpfc_hba *phba, struct lpfc_queue *mq,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2502 MQ_CREATE mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -15915,7 +15914,7 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2503 WQ_CREATE mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -15942,7 +15941,7 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 					       &wq_create->u.response);
 			if ((wq->db_format != LPFC_DB_LIST_FORMAT) &&
 			    (wq->db_format != LPFC_DB_RING_FORMAT)) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3265 WQ[%d] doorbell format "
 						"not supported: x%x\n",
 						wq->queue_id, wq->db_format);
@@ -15954,7 +15953,7 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 			bar_memmap_p = lpfc_dual_chute_pci_bar_map(phba,
 								   pci_barset);
 			if (!bar_memmap_p) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3263 WQ[%d] failed to memmap "
 						"pci barset:x%x\n",
 						wq->queue_id, pci_barset);
@@ -15964,7 +15963,7 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 			db_offset = wq_create->u.response.doorbell_offset;
 			if ((db_offset != LPFC_ULP0_WQ_DOORBELL) &&
 			    (db_offset != LPFC_ULP1_WQ_DOORBELL)) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3252 WQ[%d] doorbell offset "
 						"not supported: x%x\n",
 						wq->queue_id, db_offset);
@@ -15988,7 +15987,7 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 			bar_memmap_p = lpfc_dual_chute_pci_bar_map(phba,
 								   pci_barset);
 			if (!bar_memmap_p) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3267 WQ[%d] failed to memmap "
 						"pci barset:x%x\n",
 						wq->queue_id, pci_barset);
@@ -16004,7 +16003,7 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 			bar_memmap_p = lpfc_dual_chute_pci_bar_map(phba,
 								   dpp_barset);
 			if (!bar_memmap_p) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+				lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 						"3268 WQ[%d] failed to memmap "
 						"pci barset:x%x\n",
 						wq->queue_id, dpp_barset);
@@ -16128,7 +16127,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 	} else {
 		switch (hrq->entry_count) {
 		default:
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2535 Unsupported RQ count. (%d)\n",
 					hrq->entry_count);
 			if (hrq->entry_count < 512) {
@@ -16179,7 +16178,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2504 RQ_CREATE mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16197,7 +16196,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 					&rq_create->u.response);
 		if ((hrq->db_format != LPFC_DB_LIST_FORMAT) &&
 		    (hrq->db_format != LPFC_DB_RING_FORMAT)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3262 RQ [%d] doorbell format not "
 					"supported: x%x\n", hrq->queue_id,
 					hrq->db_format);
@@ -16209,7 +16208,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 				    &rq_create->u.response);
 		bar_memmap_p = lpfc_dual_chute_pci_bar_map(phba, pci_barset);
 		if (!bar_memmap_p) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3269 RQ[%d] failed to memmap pci "
 					"barset:x%x\n", hrq->queue_id,
 					pci_barset);
@@ -16220,7 +16219,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 		db_offset = rq_create->u.response.doorbell_offset;
 		if ((db_offset != LPFC_ULP0_RQ_DOORBELL) &&
 		    (db_offset != LPFC_ULP1_RQ_DOORBELL)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"3270 RQ[%d] doorbell offset not "
 					"supported: x%x\n", hrq->queue_id,
 					db_offset);
@@ -16265,7 +16264,7 @@ lpfc_rq_create(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 	} else {
 		switch (drq->entry_count) {
 		default:
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2536 Unsupported RQ count. (%d)\n",
 					drq->entry_count);
 			if (drq->entry_count < 512) {
@@ -16402,7 +16401,7 @@ lpfc_mrq_create(struct lpfc_hba *phba, struct lpfc_queue **hrqp,
 				    LPFC_MBOX_OPCODE_FCOE_RQ_CREATE, length,
 				    LPFC_SLI4_MBX_NEMBED);
 	if (alloclen < length) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3099 Allocated DMA memory size (%d) is "
 				"less than the requested DMA memory size "
 				"(%d)\n", alloclen, length);
@@ -16512,7 +16511,7 @@ lpfc_mrq_create(struct lpfc_hba *phba, struct lpfc_queue **hrqp,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3120 RQ_CREATE mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16582,7 +16581,7 @@ lpfc_eq_destroy(struct lpfc_hba *phba, struct lpfc_queue *eq)
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2505 EQ_DESTROY mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16637,7 +16636,7 @@ lpfc_cq_destroy(struct lpfc_hba *phba, struct lpfc_queue *cq)
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2506 CQ_DESTROY mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16691,7 +16690,7 @@ lpfc_mq_destroy(struct lpfc_hba *phba, struct lpfc_queue *mq)
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2507 MQ_DESTROY mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16744,7 +16743,7 @@ lpfc_wq_destroy(struct lpfc_hba *phba, struct lpfc_queue *wq)
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2508 WQ_DESTROY mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16801,7 +16800,7 @@ lpfc_rq_destroy(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2509 RQ_DESTROY mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16817,7 +16816,7 @@ lpfc_rq_destroy(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
 	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2510 RQ_DESTROY mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -16865,7 +16864,7 @@ lpfc_sli4_post_sgl(struct lpfc_hba *phba,
 	union lpfc_sli4_cfg_shdr *shdr;
 
 	if (xritag == NO_XRI) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0364 Invalid param:\n");
 		return -EINVAL;
 	}
@@ -16906,7 +16905,7 @@ lpfc_sli4_post_sgl(struct lpfc_hba *phba,
 	if (rc != MBX_TIMEOUT)
 		mempool_free(mbox, phba->mbox_mem_pool);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2511 POST_SGL mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -17037,7 +17036,7 @@ lpfc_sli4_post_sgl_list(struct lpfc_hba *phba,
 	reqlen = post_cnt * sizeof(struct sgl_page_pairs) +
 		 sizeof(union lpfc_sli4_cfg_shdr) + sizeof(uint32_t);
 	if (reqlen > SLI4_PAGE_SIZE) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2559 Block sgl registration required DMA "
 				"size (%d) great than a page\n", reqlen);
 		return -ENOMEM;
@@ -17053,7 +17052,7 @@ lpfc_sli4_post_sgl_list(struct lpfc_hba *phba,
 			 LPFC_SLI4_MBX_NEMBED);
 
 	if (alloclen < reqlen) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"0285 Allocated DMA memory size (%d) is "
 				"less than the requested DMA memory "
 				"size (%d)\n", alloclen, reqlen);
@@ -17101,7 +17100,7 @@ lpfc_sli4_post_sgl_list(struct lpfc_hba *phba,
 	if (rc != MBX_TIMEOUT)
 		lpfc_sli4_mbox_cmd_free(phba, mbox);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2513 POST_SGL_BLOCK mailbox command failed "
 				"status x%x add_status x%x mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -17149,7 +17148,7 @@ lpfc_sli4_post_io_sgl_block(struct lpfc_hba *phba, struct list_head *nblist,
 	}
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6119 Failed to allocate mbox cmd memory\n");
 		return -ENOMEM;
 	}
@@ -17160,7 +17159,7 @@ lpfc_sli4_post_io_sgl_block(struct lpfc_hba *phba, struct list_head *nblist,
 				    reqlen, LPFC_SLI4_MBX_NEMBED);
 
 	if (alloclen < reqlen) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6120 Allocated DMA memory size (%d) is "
 				"less than the requested DMA memory "
 				"size (%d)\n", alloclen, reqlen);
@@ -17214,7 +17213,7 @@ lpfc_sli4_post_io_sgl_block(struct lpfc_hba *phba, struct list_head *nblist,
 	if (rc != MBX_TIMEOUT)
 		lpfc_sli4_mbox_cmd_free(phba, mbox);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6125 POST_SGL_BLOCK mailbox command failed "
 				"status x%x add_status x%x mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -17798,7 +17797,7 @@ lpfc_sli4_seq_abort_rsp_cmpl(struct lpfc_hba *phba,
 
 	/* Failure means BLS ABORT RSP did not get delivered to remote node*/
 	if (rsp_iocbq && rsp_iocbq->iocb.ulpStatus)
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"3154 BLS ABORT RSP failed, data:  x%x/x%x\n",
 			rsp_iocbq->iocb.ulpStatus,
 			rsp_iocbq->iocb.un.ulpWord[4]);
@@ -17960,7 +17959,7 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, ctiocb, 0);
 	if (rc == IOCB_ERROR) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "2925 Failed to issue CT ABTS RSP x%x on "
 				 "xri x%x, Data x%x\n",
 				 icmd->un.xseq64.w5.hcsw.Rctl, oxid,
@@ -18210,7 +18209,7 @@ lpfc_sli4_send_seq_to_ulp(struct lpfc_vport *vport,
 	fc_hdr = (struct fc_frame_header *)seq_dmabuf->hbuf.virt;
 	iocbq = lpfc_prep_seq(vport, seq_dmabuf);
 	if (!iocbq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2707 Ring %d handler: Failed to allocate "
 				"iocb Rctl x%x Type x%x received\n",
 				LPFC_ELS_RING,
@@ -18221,7 +18220,7 @@ lpfc_sli4_send_seq_to_ulp(struct lpfc_vport *vport,
 				      phba->sli4_hba.els_wq->pring,
 				      iocbq, fc_hdr->fh_r_ctl,
 				      fc_hdr->fh_type))
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2540 Ring %d handler: unexpected Rctl "
 				"x%x Type x%x received\n",
 				LPFC_ELS_RING,
@@ -18486,7 +18485,7 @@ lpfc_sli4_post_all_rpi_hdrs(struct lpfc_hba *phba)
 
 		rc = lpfc_sli4_post_rpi_hdr(phba, rpi_page);
 		if (rc != MBX_SUCCESS) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2008 Error %d posting all rpi "
 					"headers\n", rc);
 			rc = -EIO;
@@ -18532,7 +18531,7 @@ lpfc_sli4_post_rpi_hdr(struct lpfc_hba *phba, struct lpfc_rpi_hdr *rpi_page)
 	/* The port is notified of the header region via a mailbox command. */
 	mboxq = (LPFC_MBOXQ_t *) mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2001 Unable to allocate memory for issuing "
 				"SLI_CONFIG_SPECIAL mailbox command\n");
 		return -ENOMEM;
@@ -18562,7 +18561,7 @@ lpfc_sli4_post_rpi_hdr(struct lpfc_hba *phba, struct lpfc_rpi_hdr *rpi_page)
 	if (rc != MBX_TIMEOUT)
 		mempool_free(mboxq, phba->mbox_mem_pool);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2514 POST_RPI_HDR mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -18652,7 +18651,7 @@ lpfc_sli4_alloc_rpi(struct lpfc_hba *phba)
 	if (rpi_remaining < LPFC_RPI_LOW_WATER_MARK) {
 		rpi_hdr = lpfc_sli4_create_rpi_hdr(phba);
 		if (!rpi_hdr) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2002 Error Could not grow rpi "
 					"count\n");
 		} else {
@@ -18754,7 +18753,7 @@ lpfc_sli4_resume_rpi(struct lpfc_nodelist *ndlp,
 	mboxq->vport = ndlp->vport;
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2010 Resume RPI Mailbox failed "
 				"status %d, mbxStatus x%x\n", rc,
 				bf_get(lpfc_mqe_status, &mboxq->u.mqe));
@@ -18789,7 +18788,7 @@ lpfc_sli4_init_vpi(struct lpfc_vport *vport)
 	mbox_tmo = lpfc_mbox_tmo_val(phba, mboxq);
 	rc = lpfc_sli_issue_mbox_wait(phba, mboxq, mbox_tmo);
 	if (rc != MBX_SUCCESS) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_SLI,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"2022 INIT VPI Mailbox failed "
 				"status %d, mbxStatus x%x\n", rc,
 				bf_get(lpfc_mqe_status, &mboxq->u.mqe));
@@ -18825,7 +18824,7 @@ lpfc_mbx_cmpl_add_fcf_record(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 
 	if ((shdr_status || shdr_add_status) &&
 		(shdr_status != STATUS_FCF_IN_USE))
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2558 ADD_FCF_RECORD mailbox failed with "
 			"status x%x add_status x%x\n",
 			shdr_status, shdr_add_status);
@@ -18855,7 +18854,7 @@ lpfc_sli4_add_fcf_record(struct lpfc_hba *phba, struct fcf_record *fcf_record)
 
 	mboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2009 Failed to allocate mbox for ADD_FCF cmd\n");
 		return -ENOMEM;
 	}
@@ -18868,7 +18867,7 @@ lpfc_sli4_add_fcf_record(struct lpfc_hba *phba, struct fcf_record *fcf_record)
 				     LPFC_MBOX_OPCODE_FCOE_ADD_FCF,
 				     req_len, LPFC_SLI4_MBX_NEMBED);
 	if (alloc_len < req_len) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2523 Allocated DMA memory size (x%x) is "
 			"less than the requested DMA memory "
 			"size (x%x)\n", alloc_len, req_len);
@@ -18901,7 +18900,7 @@ lpfc_sli4_add_fcf_record(struct lpfc_hba *phba, struct fcf_record *fcf_record)
 	mboxq->mbox_cmpl = lpfc_mbx_cmpl_add_fcf_record;
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2515 ADD_FCF_RECORD mailbox failed with "
 			"status 0x%x\n", rc);
 		lpfc_sli4_mbox_cmd_free(phba, mboxq);
@@ -18974,7 +18973,7 @@ lpfc_sli4_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, uint16_t fcf_index)
 	phba->fcoe_cvl_eventtag_attn = phba->fcoe_cvl_eventtag;
 	mboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2000 Failed to allocate mbox for "
 				"READ_FCF cmd\n");
 		error = -ENOMEM;
@@ -19417,7 +19416,7 @@ lpfc_sli4_redisc_fcf_table(struct lpfc_hba *phba)
 
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mbox) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2745 Failed to allocate mbox for "
 				"requesting FCF rediscover.\n");
 		return -ENOMEM;
@@ -19492,7 +19491,7 @@ lpfc_sli_get_config_region23(struct lpfc_hba *phba, char *rgn23_data)
 
 	pmb = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!pmb) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2600 failed to allocate mailbox memory\n");
 		return 0;
 	}
@@ -19551,7 +19550,7 @@ lpfc_sli4_get_config_region23(struct lpfc_hba *phba, char *rgn23_data)
 
 	mboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3105 failed to allocate mailbox memory\n");
 		return 0;
 	}
@@ -19615,7 +19614,7 @@ lpfc_sli_read_link_ste(struct lpfc_hba *phba)
 
 	/* Check the region signature first */
 	if (memcmp(&rgn23_data[offset], LPFC_REGION23_SIGNATURE, 4)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2619 Config region 23 has bad signature\n");
 			goto out;
 	}
@@ -19623,7 +19622,7 @@ lpfc_sli_read_link_ste(struct lpfc_hba *phba)
 
 	/* Check the data structure version */
 	if (rgn23_data[offset] != LPFC_REGION23_VERSION) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"2620 Config region 23 has bad version\n");
 		goto out;
 	}
@@ -19800,7 +19799,7 @@ lpfc_wr_object(struct lpfc_hba *phba, struct list_head *dmabuf_list,
 	if (rc != MBX_TIMEOUT)
 		mempool_free(mbox, phba->mbox_mem_pool);
 	if (shdr_status || shdr_add_status || rc) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3025 Write Object mailbox failed with "
 				"status x%x add_status x%x, mbx status x%x\n",
 				shdr_status, shdr_add_status, rc);
@@ -19980,7 +19979,7 @@ lpfc_drain_txq(struct lpfc_hba *phba)
 		piocbq = lpfc_sli_ringtx_get(phba, pring);
 		if (!piocbq) {
 			spin_unlock_irqrestore(&pring->ring_lock, iflags);
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2823 txq empty and txq_cnt is %d\n ",
 				txq_cnt);
 			break;
@@ -20009,7 +20008,7 @@ lpfc_drain_txq(struct lpfc_hba *phba)
 
 		if (fail_msg) {
 			/* Failed means we can't issue and need to cancel */
-			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"2822 IOCB failed %s iotag 0x%x "
 					"xri 0x%x\n",
 					fail_msg,
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index d0296f7cf45f..aa4e451d5dc1 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -145,7 +145,7 @@ lpfc_vport_sparm(struct lpfc_hba *phba, struct lpfc_vport *vport)
 	rc = lpfc_sli_issue_mbox_wait(phba, pmb, phba->fc_ratov * 2);
 	if (rc != MBX_SUCCESS) {
 		if (signal_pending(current)) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT | LOG_VPORT,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "1830 Signal aborted mbxCmd x%x\n",
 					 mb->mbxCommand);
 			lpfc_mbuf_free(phba, mp->virt, mp->phys);
@@ -154,7 +154,7 @@ lpfc_vport_sparm(struct lpfc_hba *phba, struct lpfc_vport *vport)
 				mempool_free(pmb, phba->mbox_mem_pool);
 			return -EINTR;
 		} else {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT | LOG_VPORT,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "1818 VPort failed init, mbxCmd x%x "
 					 "READ_SPARM mbxStatus x%x, rc = x%x\n",
 					 mb->mbxCommand, mb->mbxStatus, rc);
@@ -190,7 +190,7 @@ lpfc_valid_wwn_format(struct lpfc_hba *phba, struct lpfc_name *wwn,
 	      ((wwn->u.wwn[0] & 0xf) != 0 || (wwn->u.wwn[1] & 0xf) != 0)))
 		return 1;
 
-	lpfc_printf_log(phba, KERN_ERR, LOG_VPORT,
+	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"1822 Invalid %s: %02x:%02x:%02x:%02x:"
 			"%02x:%02x:%02x:%02x\n",
 			name_type,
@@ -284,11 +284,11 @@ static void lpfc_discovery_wait(struct lpfc_vport *vport)
 	}
 
 	if (time_after(jiffies, wait_time_max))
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
-				"1835 Vport discovery quiesce failed:"
-				" state x%x fc_flags x%x wait msecs x%x\n",
-				vport->port_state, vport->fc_flag,
-				jiffies_to_msecs(jiffies - start_time));
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+				 "1835 Vport discovery quiesce failed:"
+				 " state x%x fc_flags x%x wait msecs x%x\n",
+				 vport->port_state, vport->fc_flag,
+				 jiffies_to_msecs(jiffies - start_time));
 }
 
 int
@@ -305,7 +305,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 	int status;
 
 	if ((phba->sli_rev < 3) || !(phba->cfg_enable_npiv)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1808 Create VPORT failed: "
 				"NPIV is not enabled: SLImode:%d\n",
 				phba->sli_rev);
@@ -315,7 +315,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 
 	/* NPIV is not supported if HBA has NVME Target enabled */
 	if (phba->nvmet_support) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3189 Create VPORT failed: "
 				"NPIV is not supported on NVME Target\n");
 		rc = VPORT_INVAL;
@@ -324,7 +324,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 
 	vpi = lpfc_alloc_vpi(phba);
 	if (vpi == 0) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1809 Create VPORT failed: "
 				"Max VPORTs (%d) exceeded\n",
 				phba->max_vpi);
@@ -334,7 +334,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 
 	/* Assign an unused board number */
 	if ((instance = lpfc_get_instance()) < 0) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1810 Create VPORT failed: Cannot get "
 				"instance number\n");
 		lpfc_free_vpi(phba, vpi);
@@ -344,7 +344,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 
 	vport = lpfc_create_port(phba, instance, &fc_vport->dev);
 	if (!vport) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_VPORT,
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"1811 Create VPORT failed: vpi x%x\n", vpi);
 		lpfc_free_vpi(phba, vpi);
 		rc = VPORT_NORESOURCES;
@@ -356,11 +356,11 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 
 	if ((status = lpfc_vport_sparm(phba, vport))) {
 		if (status == -EINTR) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "1831 Create VPORT Interrupted.\n");
 			rc = VPORT_ERROR;
 		} else {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "1813 Create VPORT failed. "
 					 "Cannot get sparam\n");
 			rc = VPORT_NORESOURCES;
@@ -378,7 +378,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 
 	if (!lpfc_valid_wwn_format(phba, &vport->fc_sparam.nodeName, "WWNN") ||
 	    !lpfc_valid_wwn_format(phba, &vport->fc_sparam.portName, "WWPN")) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "1821 Create VPORT failed. "
 				 "Invalid WWN format\n");
 		lpfc_free_vpi(phba, vpi);
@@ -388,7 +388,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 	}
 
 	if (!lpfc_unique_wwpn(phba, vport)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "1823 Create VPORT failed. "
 				 "Duplicate WWN on HBA\n");
 		lpfc_free_vpi(phba, vpi);
@@ -426,7 +426,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 	    (pport->fc_flag & FC_VFI_REGISTERED)) {
 		rc = lpfc_sli4_init_vpi(vport);
 		if (rc) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_VPORT,
+			lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 					"1838 Failed to INIT_VPI on vpi %d "
 					"status %d\n", vpi, rc);
 			rc = VPORT_NORESOURCES;
@@ -469,7 +469,7 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 			lpfc_initial_fdisc(vport);
 		} else {
 			lpfc_vport_set_state(vport, FC_VPORT_NO_FABRIC_SUPP);
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0262 No NPIV Fabric support\n");
 		}
 	} else {
@@ -478,8 +478,8 @@ lpfc_vport_create(struct fc_vport *fc_vport, bool disable)
 	rc = VPORT_OK;
 
 out:
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
-			"1825 Vport Created.\n");
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
+			 "1825 Vport Created.\n");
 	lpfc_host_attrib_init(lpfc_shost_from_vport(vport));
 error_out:
 	return rc;
@@ -534,7 +534,7 @@ disable_vport(struct fc_vport *fc_vport)
 	}
 
 	lpfc_vport_set_state(vport, FC_VPORT_DISABLED);
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "1826 Vport Disabled.\n");
 	return VPORT_OK;
 }
@@ -575,7 +575,7 @@ enable_vport(struct fc_vport *fc_vport)
 			lpfc_initial_fdisc(vport);
 		} else {
 			lpfc_vport_set_state(vport, FC_VPORT_NO_FABRIC_SUPP);
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0264 No NPIV Fabric support\n");
 		}
 	} else {
@@ -583,7 +583,7 @@ enable_vport(struct fc_vport *fc_vport)
 	}
 
 out:
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "1827 Vport Enabled.\n");
 	return VPORT_OK;
 }
@@ -609,7 +609,7 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	bool ns_ndlp_referenced = false;
 
 	if (vport->port_type == LPFC_PHYSICAL_PORT) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "1812 vport_delete failed: Cannot delete "
 				 "physical host\n");
 		return VPORT_ERROR;
@@ -618,7 +618,7 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	/* If the vport is a static vport fail the deletion. */
 	if ((vport->vport_flag & STATIC_VPORT) &&
 		!(phba->pport->load_flag & FC_UNLOADING)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "1837 vport_delete failed: Cannot delete "
 				 "static vport.\n");
 		return VPORT_ERROR;
@@ -807,7 +807,7 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	spin_lock_irq(&phba->port_list_lock);
 	list_del_init(&vport->listentry);
 	spin_unlock_irq(&phba->port_list_lock);
-	lpfc_printf_vlog(vport, KERN_ERR, LOG_VPORT,
+	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "1828 Vport Deleted.\n");
 	scsi_host_put(shost);
 	return VPORT_OK;
@@ -828,7 +828,8 @@ lpfc_create_vport_work_array(struct lpfc_hba *phba)
 		if (port_iterator->load_flag & FC_UNLOADING)
 			continue;
 		if (!scsi_host_get(lpfc_shost_from_vport(port_iterator))) {
-			lpfc_printf_vlog(port_iterator, KERN_ERR, LOG_VPORT,
+			lpfc_printf_vlog(port_iterator, KERN_ERR,
+					 LOG_TRACE_EVENT,
 					 "1801 Create vport work array FAILED: "
 					 "cannot do scsi_host_get\n");
 			continue;
@@ -898,7 +899,8 @@ lpfc_alloc_bucket(struct lpfc_vport *vport)
 					 GFP_ATOMIC);
 
 			if (!ndlp->lat_data)
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
+				lpfc_printf_vlog(vport, KERN_ERR,
+					LOG_TRACE_EVENT,
 					"0287 lpfc_alloc_bucket failed to "
 					"allocate statistical data buffer DID "
 					"0x%x\n", ndlp->nlp_DID);
-- 
2.25.0

