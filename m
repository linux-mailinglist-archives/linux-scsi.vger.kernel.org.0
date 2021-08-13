Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075823EAE67
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 04:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhHMCJV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Aug 2021 22:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhHMCJS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Aug 2021 22:09:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01CDC061756
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l11so9912084plk.6
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUOzsLcGiD8nh/apNqbIikKBqN7y0dt2LgsSy1a5zXk=;
        b=APXMil7M61zHQNYryAUwbgnbuBvVa1UjiwK/7qO5O+Zeb99Yjp8h+3aso7uyKrFO7J
         zppYmbIkDSzEXPYI67P9xDzTkuSR93B/ynJ1esKpSusW2l2dZ+jDmbRN0C5I7jcjwyEO
         GXc/GhIKaE4kqHqygy52lRnCL8zRykLrH0HsYiimsEVOopl44vZOabVZfH3t7FlYZOdK
         ief4QAb7TMZcJUco1VS9i9zUGUz5XBRlYLudMiKJ5w6tnBuEnHLaTjM/l1Zyjdd5HY2Y
         Ae+Lh4Y2fPbvwgI0lEYPXBlsQoOl6Hednbp6s1f9HkyfAWqlWxNrMOkOX+KUjFMcvXy+
         VjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUOzsLcGiD8nh/apNqbIikKBqN7y0dt2LgsSy1a5zXk=;
        b=TBOCKg0DcqUH1DbUEto7ucCtLweIGG9IqZgaUemKOyB0o84kHydyHSvuVNz7Vw7w8B
         yXnKlc0usPxYLK3//vKEtCyQ8RFl0mylwCeGeYr50moNgxhRe2d5iPlLnrtkfCVMo8G7
         Bwi9bKZbqmkEqX8vQmcKFBUyJyp6+JtcbrvrSl8R81cY3VXutFjCdjiIMIRYyx6NJL2c
         xt7J9rjTmDnRGrn99tpLmOOZsVEUruz8coQzI0mdJMqVtZLcoesw/fXUz1tSNOy2UavC
         RBZz8X90Q2c1bT/sIuAGR2OTCGwU+Z86FgZ5AzEzsIBBWq0KSW0mIw1epUFmmsndQgZI
         i6Qw==
X-Gm-Message-State: AOAM531xt9wYpWqYR2uGLObOkuPlA+w9ZSBMRBe6Yz6j5Ji6juBu9ZM2
        DctD7XrtZyQDZt6fvGsviYBPIURtu8U=
X-Google-Smtp-Source: ABdhPJxa+0c6wbxDTIecmM2IUWoZgz0UKflEwFlGzEv4lA+LFONQuiECIFLYYhcoS+1Kvx4SJCG+kQ==
X-Received: by 2002:a17:90b:1018:: with SMTP id gm24mr105574pjb.86.1628820531857;
        Thu, 12 Aug 2021 19:08:51 -0700 (PDT)
Received: from localhost.localdomain (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id ca7sm102619pjb.11.2021.08.12.19.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 19:08:51 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 05/16] lpfc: Add EDC ELS support
Date:   Thu, 12 Aug 2021 19:08:01 -0700
Message-Id: <20210813020812.99014-6-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210813020812.99014-1-jsmart2021@gmail.com>
References: <20210813020812.99014-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When congestion management is enabled, issue EDC ELS to register
congestion signaling capabilities with the fabric. The response handling
will process the fabric parameters and set the reporting parameters.

Similarly, add support for receiving an EDC request from the fabric
generating a corresponding response.

Implement handlers for congestion signals from the fabric and maintain
statistics for them.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h         |  35 ++
 drivers/scsi/lpfc/lpfc_attr.c    |  27 ++
 drivers/scsi/lpfc/lpfc_crtn.h    |   6 +
 drivers/scsi/lpfc/lpfc_ct.c      |   2 +
 drivers/scsi/lpfc/lpfc_els.c     | 637 ++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_hbadisc.c |  19 +-
 drivers/scsi/lpfc/lpfc_hw.h      |   2 +
 drivers/scsi/lpfc/lpfc_hw4.h     |  58 +++
 drivers/scsi/lpfc/lpfc_init.c    |  86 ++++-
 drivers/scsi/lpfc/lpfc_sli.c     | 127 +++++-
 10 files changed, 988 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index dd3ddfa5f761..f23905b89ee3 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -403,6 +403,11 @@ struct lpfc_trunk_link  {
 				     link3;
 };
 
+struct lpfc_cgn_acqe_stat {
+	atomic64_t alarm;
+	atomic64_t warn;
+};
+
 struct lpfc_vport {
 	struct lpfc_hba *phba;
 	struct list_head listentry;
@@ -1343,6 +1348,36 @@ struct lpfc_hba {
 	uint64_t ktime_seg10_min;
 	uint64_t ktime_seg10_max;
 #endif
+	/* CMF objects */
+	u32 cmf_active_mode;
+#define LPFC_CFG_OFF		0
+
+	/* Signal / FPIN handling for Congestion Mgmt */
+	u8 cgn_reg_fpin;           /* Negotiated value from RDF */
+	u8 cgn_init_reg_fpin;      /* Initial value from READ_CONFIG */
+#define LPFC_CGN_FPIN_NONE	0x0
+#define LPFC_CGN_FPIN_WARN	0x1
+#define LPFC_CGN_FPIN_ALARM	0x2
+#define LPFC_CGN_FPIN_BOTH	(LPFC_CGN_FPIN_WARN | LPFC_CGN_FPIN_ALARM)
+
+	u8 cgn_reg_signal;          /* Negotiated value from EDC */
+	u8 cgn_init_reg_signal;     /* Initial value from READ_CONFIG */
+		/* cgn_reg_signal and cgn_init_reg_signal use
+		 * enum fc_edc_cg_signal_cap_types
+		 */
+	u16 cgn_fpin_frequency;
+#define LPFC_FPIN_INIT_FREQ	0xffff
+	u32 cgn_sig_freq;
+	u32 cgn_acqe_cnt;
+
+	/* Statistics counter for ACQE cgn alarms and warnings */
+	struct lpfc_cgn_acqe_stat cgn_acqe_stat;
+
+	/* Congestion buffer information */
+	atomic_t cgn_fabric_warn_cnt;   /* Total warning cgn events for info */
+	atomic_t cgn_fabric_alarm_cnt;  /* Total alarm cgn events for info */
+	atomic_t cgn_sync_warn_cnt;     /* Total warning events for SYNC wqe */
+	atomic_t cgn_sync_alarm_cnt;    /* Total alarm events for SYNC wqe */
 
 	struct hlist_node cpuhp;	/* used for cpuhp per hba callback */
 	struct timer_list cpuhp_poll_timer;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 869c2b6f1515..d16d3544084f 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -6150,6 +6150,19 @@ LPFC_ATTR_RW(ras_fwlog_func, 0, 0, 7, "Firmware Logging Enabled on Function");
  */
 LPFC_BBCR_ATTR_RW(enable_bbcr, 1, 0, 1, "Enable BBC Recovery");
 
+/* Signaling module parameters */
+int lpfc_fabric_cgn_frequency = 100; /* 100 ms default */
+module_param(lpfc_fabric_cgn_frequency, int, 0444);
+MODULE_PARM_DESC(lpfc_fabric_cgn_frequency, "Congestion signaling fabric freq");
+
+int lpfc_acqe_cgn_frequency = 10; /* 10 sec default */
+module_param(lpfc_acqe_cgn_frequency, int, 0444);
+MODULE_PARM_DESC(lpfc_acqe_cgn_frequency, "Congestion signaling ACQE freq");
+
+int lpfc_use_cgn_signal = 1; /* 0 - only use FPINs, 1 - Use signals if avail  */
+module_param(lpfc_use_cgn_signal, int, 0444);
+MODULE_PARM_DESC(lpfc_use_cgn_signal, "Use Congestion signaling if available");
+
 /*
  * lpfc_enable_dpp: Enable DPP on G7
  *       0  = DPP on G7 disabled
@@ -6915,6 +6928,9 @@ lpfc_get_stats(struct Scsi_Host *shost)
 	hs->invalid_crc_count = pmb->un.varRdLnk.crcCnt;
 	hs->error_frames = pmb->un.varRdLnk.crcCnt;
 
+	hs->cn_sig_warn = atomic64_read(&phba->cgn_acqe_stat.warn);
+	hs->cn_sig_alarm = atomic64_read(&phba->cgn_acqe_stat.alarm);
+
 	hs->link_failure_count -= lso->link_failure_count;
 	hs->loss_of_sync_count -= lso->loss_of_sync_count;
 	hs->loss_of_signal_count -= lso->loss_of_signal_count;
@@ -7026,6 +7042,12 @@ lpfc_reset_stats(struct Scsi_Host *shost)
 	else
 		lso->link_events = (phba->fc_eventTag >> 1);
 
+	atomic64_set(&phba->cgn_acqe_stat.warn, 0);
+	atomic64_set(&phba->cgn_acqe_stat.alarm, 0);
+
+	memset(&shost_to_fc_host(shost)->fpin_stats, 0,
+	       sizeof(shost_to_fc_host(shost)->fpin_stats));
+
 	psli->stats_start = ktime_get_seconds();
 
 	mempool_free(pmboxq, phba->mbox_mem_pool);
@@ -7459,6 +7481,11 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_enable_dpp_init(phba, lpfc_enable_dpp);
 	lpfc_enable_mi_init(phba, lpfc_enable_mi);
 
+	phba->cmf_active_mode = LPFC_CFG_OFF;
+	if (lpfc_fabric_cgn_frequency > EDC_CG_SIGFREQ_CNT_MAX ||
+	   lpfc_fabric_cgn_frequency < EDC_CG_SIGFREQ_CNT_MIN)
+		lpfc_fabric_cgn_frequency = 100; /* 100 ms default */
+
 	if (phba->sli_rev != LPFC_SLI_REV4) {
 		/* NVME only supported on SLI4 */
 		phba->nvmet_support = 0;
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 41e0d8ef015a..b1db01884990 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -74,6 +74,7 @@ int lpfc_init_iocb_list(struct lpfc_hba *phba, int cnt);
 void lpfc_free_iocb_list(struct lpfc_hba *phba);
 int lpfc_post_rq_buffer(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 			struct lpfc_queue *drq, int count, int idx);
+int lpfc_config_cgn_signal(struct lpfc_hba *phba);
 
 void lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_mbx_cmpl_reg_login(struct lpfc_hba *, LPFC_MBOXQ_t *);
@@ -143,6 +144,7 @@ int lpfc_issue_els_scr(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_issue_fabric_reglogin(struct lpfc_vport *);
 int lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry);
+int lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_els_free_iocb(struct lpfc_hba *, struct lpfc_iocbq *);
 int lpfc_ct_free_iocb(struct lpfc_hba *, struct lpfc_iocbq *);
 int lpfc_els_rsp_acc(struct lpfc_vport *, uint32_t, struct lpfc_iocbq *,
@@ -607,6 +609,10 @@ extern int lpfc_enable_nvmet_cnt;
 extern unsigned long long lpfc_enable_nvmet[];
 extern int lpfc_no_hba_reset_cnt;
 extern unsigned long lpfc_no_hba_reset[];
+extern int lpfc_acqe_cgn_frequency;
+extern int lpfc_fabric_cgn_frequency;
+extern int lpfc_use_cgn_signal;
+
 extern union lpfc_wqe128 lpfc_iread_cmd_template;
 extern union lpfc_wqe128 lpfc_iwrite_cmd_template;
 extern union lpfc_wqe128 lpfc_icmnd_cmd_template;
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 435349f893ad..dfcb7d4bd7fa 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2288,6 +2288,8 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			/* No retry on Vendor, RPA only done on physical port */
 			if (phba->link_flag & LS_CT_VEN_RPA) {
 				phba->link_flag &= ~LS_CT_VEN_RPA;
+				if (phba->cmf_active_mode == LPFC_CFG_OFF)
+					return;
 				lpfc_printf_log(phba, KERN_ERR,
 						LOG_DISCOVERY | LOG_ELS,
 						"6460 VEN FDMI RPA failure\n");
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 097f132fc35b..1b587fbfe233 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -56,6 +56,9 @@ static int lpfc_issue_els_fdisc(struct lpfc_vport *vport,
 				struct lpfc_nodelist *ndlp, uint8_t retry);
 static int lpfc_issue_fabric_iocb(struct lpfc_hba *phba,
 				  struct lpfc_iocbq *iocb);
+static void lpfc_cmpl_els_edc(struct lpfc_hba *phba,
+			      struct lpfc_iocbq *cmdiocb,
+			      struct lpfc_iocbq *rspiocb);
 static void lpfc_cmpl_els_uvem(struct lpfc_hba *, struct lpfc_iocbq *,
 			       struct lpfc_iocbq *);
 
@@ -3286,6 +3289,9 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			case ELS_CMD_SCR:
 				lpfc_issue_els_scr(vport, cmdiocb->retry);
 				break;
+			case ELS_CMD_EDC:
+				lpfc_issue_els_edc(vport, cmdiocb->retry);
+				break;
 			case ELS_CMD_RDF:
 				cmdiocb->context1 = NULL; /* save ndlp refcnt */
 				lpfc_issue_els_rdf(vport, cmdiocb->retry);
@@ -3295,6 +3301,11 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		}
 		phba->fc_stat.elsRetryExceeded++;
 	}
+	if (cmd == ELS_CMD_EDC) {
+		/* must be called before checking uplStatus and returning */
+		lpfc_cmpl_els_edc(phba, cmdiocb, rspiocb);
+		return;
+	}
 	if (irsp->ulpStatus) {
 		/* ELS discovery cmd completes with error */
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_ELS,
@@ -3751,6 +3762,425 @@ lpfc_els_rcv_rdf(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	return 0;
 }
 
+/**
+ * lpfc_least_capable_settings - helper function for EDC rsp processing
+ * @phba: pointer to lpfc hba data structure.
+ * @pcgd: pointer to congestion detection descriptor in EDC rsp.
+ *
+ * This helper routine determines the least capable setting for
+ * congestion signals, signal freq, including scale, from the
+ * congestion detection descriptor in the EDC rsp.  The routine
+ * sets @phba values in preparation for a set_featues mailbox.
+ **/
+static void
+lpfc_least_capable_settings(struct lpfc_hba *phba,
+			    struct fc_diag_cg_sig_desc *pcgd)
+{
+	u32 rsp_sig_cap = 0, drv_sig_cap = 0;
+	u32 rsp_sig_freq_cyc = 0, rsp_sig_freq_scale = 0;
+
+	/* Get rsp signal and frequency capabilities.  */
+	rsp_sig_cap = be32_to_cpu(pcgd->xmt_signal_capability);
+	rsp_sig_freq_cyc = be16_to_cpu(pcgd->xmt_signal_frequency.count);
+	rsp_sig_freq_scale = be16_to_cpu(pcgd->xmt_signal_frequency.units);
+
+	/* If the Fport does not support signals. Set FPIN only */
+	if (rsp_sig_cap == EDC_CG_SIG_NOTSUPPORTED)
+		goto out_no_support;
+
+	/* Apply the xmt scale to the xmt cycle to get the correct frequency.
+	 * Adapter default is 100 millisSeconds.  Convert all xmt cycle values
+	 * to milliSeconds.
+	 */
+	switch (rsp_sig_freq_scale) {
+	case EDC_CG_SIGFREQ_SEC:
+		rsp_sig_freq_cyc *= MSEC_PER_SEC;
+		break;
+	case EDC_CG_SIGFREQ_MSEC:
+		rsp_sig_freq_cyc = 1;
+		break;
+	default:
+		goto out_no_support;
+	}
+
+	/* Convenient shorthand. */
+	drv_sig_cap = phba->cgn_reg_signal;
+
+	/* Choose the least capable frequency. */
+	if (rsp_sig_freq_cyc > phba->cgn_sig_freq)
+		phba->cgn_sig_freq = rsp_sig_freq_cyc;
+
+	/* Should be some common signals support. Settle on least capable
+	 * signal and adjust FPIN values. Initialize defaults to ease the
+	 * decision.
+	 */
+	phba->cgn_reg_fpin = LPFC_CGN_FPIN_WARN | LPFC_CGN_FPIN_ALARM;
+	phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+	if (rsp_sig_cap == EDC_CG_SIG_WARN_ONLY &&
+	    (drv_sig_cap == EDC_CG_SIG_WARN_ONLY ||
+	     drv_sig_cap == EDC_CG_SIG_WARN_ALARM)) {
+		phba->cgn_reg_signal = EDC_CG_SIG_WARN_ONLY;
+		phba->cgn_reg_fpin &= ~LPFC_CGN_FPIN_WARN;
+	}
+	if (rsp_sig_cap == EDC_CG_SIG_WARN_ALARM) {
+		if (drv_sig_cap == EDC_CG_SIG_WARN_ALARM) {
+			phba->cgn_reg_signal = EDC_CG_SIG_WARN_ALARM;
+			phba->cgn_reg_fpin = LPFC_CGN_FPIN_NONE;
+		}
+		if (drv_sig_cap == EDC_CG_SIG_WARN_ONLY) {
+			phba->cgn_reg_signal = EDC_CG_SIG_WARN_ONLY;
+			phba->cgn_reg_fpin &= ~LPFC_CGN_FPIN_WARN;
+		}
+	}
+	return;
+
+out_no_support:
+	phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+	phba->cgn_sig_freq = 0;
+	phba->cgn_reg_fpin = LPFC_CGN_FPIN_ALARM | LPFC_CGN_FPIN_WARN;
+}
+
+DECLARE_ENUM2STR_LOOKUP(lpfc_get_tlv_dtag_nm, fc_ls_tlv_dtag,
+			FC_LS_TLV_DTAG_INIT);
+
+/**
+ * lpfc_cmpl_els_edc - Completion callback function for EDC
+ * @phba: pointer to lpfc hba data structure.
+ * @cmdiocb: pointer to lpfc command iocb data structure.
+ * @rspiocb: pointer to lpfc response iocb data structure.
+ *
+ * This routine is the completion callback function for issuing the Exchange
+ * Diagnostic Capabilities (EDC) command. The driver issues an EDC to
+ * notify the FPort of its Congestion and Link Fault capabilities.  This
+ * routine parses the FPort's response and decides on the least common
+ * values applicable to both FPort and NPort for Warnings and Alarms that
+ * are communicated via hardware signals.
+ **/
+static void
+lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		  struct lpfc_iocbq *rspiocb)
+{
+	IOCB_t *irsp;
+	struct fc_els_edc_resp *edc_rsp;
+	struct fc_tlv_desc *tlv;
+	struct fc_diag_cg_sig_desc *pcgd;
+	struct fc_diag_lnkflt_desc *plnkflt;
+	struct lpfc_dmabuf *pcmd, *prsp;
+	const char *dtag_nm;
+	u32 *pdata, dtag;
+	int desc_cnt = 0, bytes_remain;
+	bool rcv_cap_desc = false;
+	struct lpfc_nodelist *ndlp;
+
+	irsp = &rspiocb->iocb;
+	ndlp = cmdiocb->context1;
+
+	lpfc_debugfs_disc_trc(phba->pport, LPFC_DISC_TRC_ELS_CMD,
+			      "EDC cmpl:    status:x%x/x%x did:x%x",
+			      irsp->ulpStatus, irsp->un.ulpWord[4],
+			      irsp->un.elsreq64.remoteID);
+
+	/* ELS cmd tag <ulpIoTag> completes */
+	lpfc_printf_log(phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+			"4201 EDC cmd tag x%x completes Data: x%x x%x x%x\n",
+			irsp->ulpIoTag, irsp->ulpStatus,
+			irsp->un.ulpWord[4], irsp->ulpTimeout);
+
+	pcmd = (struct lpfc_dmabuf *)cmdiocb->context2;
+	if (!pcmd)
+		goto out;
+
+	pdata = (u32 *)pcmd->virt;
+	if (!pdata)
+		goto out;
+
+	/* Need to clear signal values, send features MB and RDF with FPIN. */
+	if (irsp->ulpStatus)
+		goto out;
+
+	prsp = list_get_first(&pcmd->list, struct lpfc_dmabuf, list);
+	if (!prsp)
+		goto out;
+
+	edc_rsp = prsp->virt;
+	if (!edc_rsp)
+		goto out;
+
+	/* ELS cmd tag <ulpIoTag> completes */
+	lpfc_printf_log(phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+			"4676 Fabric EDC Rsp: "
+			"0x%02x, 0x%08x\n",
+			edc_rsp->acc_hdr.la_cmd,
+			be32_to_cpu(edc_rsp->desc_list_len));
+
+	/*
+	 * Payload length in bytes is the response descriptor list
+	 * length minus the 12 bytes of Link Service Request
+	 * Information descriptor in the reply.
+	 */
+	bytes_remain = be32_to_cpu(edc_rsp->desc_list_len) -
+				   sizeof(struct fc_els_lsri_desc);
+	if (bytes_remain <= 0)
+		goto out;
+
+	tlv = edc_rsp->desc;
+
+	/*
+	 * cycle through EDC diagnostic descriptors to find the
+	 * congestion signaling capability descriptor
+	 */
+	while (bytes_remain) {
+		if (bytes_remain < FC_TLV_DESC_HDR_SZ) {
+			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6461 Truncated TLV hdr on "
+					"Diagnostic descriptor[%d]\n",
+					desc_cnt);
+			goto out;
+		}
+
+		dtag = be32_to_cpu(tlv->desc_tag);
+		switch (dtag) {
+		case ELS_DTAG_LNK_FAULT_CAP:
+			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
+			    FC_TLV_DESC_SZ_FROM_LENGTH(tlv) !=
+					sizeof(struct fc_diag_lnkflt_desc)) {
+				lpfc_printf_log(
+					phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6462 Truncated Link Fault Diagnostic "
+					"descriptor[%d]: %d vs %ld %ld\n",
+					desc_cnt, bytes_remain,
+					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
+					sizeof(struct fc_diag_cg_sig_desc));
+				goto out;
+			}
+			plnkflt = (struct fc_diag_lnkflt_desc *)tlv;
+			lpfc_printf_log(
+				phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+				"4617 Link Fault Desc Data: 0x%08x 0x%08x "
+				"0x%08x 0x%08x 0x%08x\n",
+				be32_to_cpu(plnkflt->desc_tag),
+				be32_to_cpu(plnkflt->desc_len),
+				be32_to_cpu(
+					plnkflt->degrade_activate_threshold),
+				be32_to_cpu(
+					plnkflt->degrade_deactivate_threshold),
+				be32_to_cpu(plnkflt->fec_degrade_interval));
+			break;
+		case ELS_DTAG_CG_SIGNAL_CAP:
+			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
+			    FC_TLV_DESC_SZ_FROM_LENGTH(tlv) !=
+					sizeof(struct fc_diag_cg_sig_desc)) {
+				lpfc_printf_log(
+					phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6463 Truncated Cgn Signal Diagnostic "
+					"descriptor[%d]: %d vs %ld %ld\n",
+					desc_cnt, bytes_remain,
+					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
+					sizeof(struct fc_diag_cg_sig_desc));
+				goto out;
+			}
+
+			pcgd = (struct fc_diag_cg_sig_desc *)tlv;
+			lpfc_printf_log(
+				phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+				"4616 CGN Desc Data: 0x%08x 0x%08x "
+				"0x%08x 0x%04x 0x%04x 0x%08x 0x%04x 0x%04x\n",
+				be32_to_cpu(pcgd->desc_tag),
+				be32_to_cpu(pcgd->desc_len),
+				be32_to_cpu(pcgd->xmt_signal_capability),
+				be32_to_cpu(pcgd->xmt_signal_frequency.count),
+				be32_to_cpu(pcgd->xmt_signal_frequency.units),
+				be32_to_cpu(pcgd->rcv_signal_capability),
+				be32_to_cpu(pcgd->rcv_signal_frequency.count),
+				be32_to_cpu(pcgd->rcv_signal_frequency.units));
+
+			/* Compare driver and Fport capabilities and choose
+			 * least common.
+			 */
+			lpfc_least_capable_settings(phba, pcgd);
+			rcv_cap_desc = true;
+			break;
+		default:
+			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
+			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+					"4919 unknown Diagnostic "
+					"Descriptor[%d]: tag x%x (%s)\n",
+					desc_cnt, dtag, dtag_nm);
+		}
+
+		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
+		tlv = fc_tlv_next_desc(tlv);
+		desc_cnt++;
+	}
+
+out:
+	if (!rcv_cap_desc) {
+		phba->cgn_reg_fpin = LPFC_CGN_FPIN_ALARM | LPFC_CGN_FPIN_WARN;
+		phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+		phba->cgn_sig_freq = 0;
+		lpfc_printf_log(phba, KERN_WARNING, LOG_ELS | LOG_CGN_MGMT,
+				"4202 EDC rsp error - sending RDF "
+				"for FPIN only.\n");
+	}
+
+	lpfc_config_cgn_signal(phba);
+
+	/* Check to see if link went down during discovery */
+	lpfc_els_chk_latt(phba->pport);
+	lpfc_debugfs_disc_trc(phba->pport, LPFC_DISC_TRC_ELS_CMD,
+			      "EDC Cmpl:     did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
+	lpfc_els_free_iocb(phba, cmdiocb);
+	lpfc_nlp_put(ndlp);
+}
+
+static void
+lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_diag_cg_sig_desc *cgd)
+{
+	/* We are assuming cgd was zero'ed before calling this routine */
+
+	/* Configure the congestion detection capability */
+	cgd->desc_tag = cpu_to_be32(ELS_DTAG_CG_SIGNAL_CAP);
+
+	/* Descriptor len doesn't include the tag or len fields. */
+	cgd->desc_len = cpu_to_be32(
+		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_diag_cg_sig_desc));
+
+	/* xmt_signal_capability already set to EDC_CG_SIG_NOTSUPPORTED.
+	 * xmt_signal_frequency.count already set to 0.
+	 * xmt_signal_frequency.units already set to 0.
+	 */
+
+	if (phba->cmf_active_mode == LPFC_CFG_OFF) {
+		/* rcv_signal_capability already set to EDC_CG_SIG_NOTSUPPORTED.
+		 * rcv_signal_frequency.count already set to 0.
+		 * rcv_signal_frequency.units already set to 0.
+		 */
+		phba->cgn_sig_freq = 0;
+		return;
+	}
+	switch (phba->cgn_reg_signal) {
+	case EDC_CG_SIG_WARN_ONLY:
+		cgd->rcv_signal_capability = cpu_to_be32(EDC_CG_SIG_WARN_ONLY);
+		break;
+	case EDC_CG_SIG_WARN_ALARM:
+		cgd->rcv_signal_capability = cpu_to_be32(EDC_CG_SIG_WARN_ALARM);
+		break;
+	default:
+		/* rcv_signal_capability left 0 thus no support */
+		break;
+	}
+
+	/* We start negotiation with lpfc_fabric_cgn_frequency, after
+	 * the completion we settle on the higher frequency.
+	 */
+	cgd->rcv_signal_frequency.count =
+		cpu_to_be16(lpfc_fabric_cgn_frequency);
+	cgd->rcv_signal_frequency.units =
+		cpu_to_be16(EDC_CG_SIGFREQ_MSEC);
+}
+
+ /**
+  * lpfc_issue_els_edc - Exchange Diagnostic Capabilities with the fabric.
+  * @vport: pointer to a host virtual N_Port data structure.
+  * @retry: retry counter for the command iocb.
+  *
+  * This routine issues an ELS EDC to the F-Port Controller to communicate
+  * this N_Port's support of hardware signals in its Congestion
+  * Capabilities Descriptor.
+  *
+  * Note: This routine does not check if one or more signals are
+  * set in the cgn_reg_signal parameter.  The caller makes the
+  * decision to enforce cgn_reg_signal as nonzero or zero depending
+  * on the conditions.  During Fabric requests, the driver
+  * requires cgn_reg_signals to be nonzero.  But a dynamic request
+  * to set the congestion mode to OFF from Monitor or Manage
+  * would correctly issue an EDC with no signals enabled to
+  * turn off switch functionality and then update the FW.
+  *
+  * Return code
+  *   0 - Successfully issued edc command
+  *   1 - Failed to issue edc command
+  **/
+int
+lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
+{
+	struct lpfc_hba  *phba = vport->phba;
+	struct lpfc_iocbq *elsiocb;
+	struct lpfc_els_edc_req *edc_req;
+	struct fc_diag_cg_sig_desc *cgn_desc;
+	u16 cmdsize;
+	struct lpfc_nodelist *ndlp;
+	u8 *pcmd = NULL;
+	u32 edc_req_size, cgn_desc_size;
+	int rc;
+
+	if (vport->port_type == LPFC_NPIV_PORT)
+		return -EACCES;
+
+	ndlp = lpfc_findnode_did(vport, Fabric_DID);
+	if (!ndlp || ndlp->nlp_state != NLP_STE_UNMAPPED_NODE)
+		return -ENODEV;
+
+	/* If HBA doesn't support signals, drop into RDF */
+	if (!phba->cgn_init_reg_signal)
+		goto try_rdf;
+
+	edc_req_size = sizeof(struct fc_els_edc);
+	cgn_desc_size = sizeof(struct fc_diag_cg_sig_desc);
+	cmdsize = edc_req_size + cgn_desc_size;
+	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
+				     ndlp->nlp_DID, ELS_CMD_EDC);
+	if (!elsiocb)
+		goto try_rdf;
+
+	/* Configure the payload for the supported Diagnostics capabilities. */
+	pcmd = (u8 *)(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
+	memset(pcmd, 0, cmdsize);
+	edc_req = (struct lpfc_els_edc_req *)pcmd;
+	edc_req->edc.desc_len = cpu_to_be32(cgn_desc_size);
+	edc_req->edc.edc_cmd = ELS_EDC;
+
+	cgn_desc = &edc_req->cgn_desc;
+
+	lpfc_format_edc_cgn_desc(phba, cgn_desc);
+
+	phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_CGN_MGMT,
+			 "4623 Xmit EDC to remote "
+			 "NPORT x%x reg_sig x%x reg_fpin:x%x\n",
+			 ndlp->nlp_DID, phba->cgn_reg_signal,
+			 phba->cgn_reg_fpin);
+
+	elsiocb->iocb_cmpl = lpfc_cmpl_els_disc_cmd;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		return -EIO;
+	}
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue EDC:     did:x%x refcnt %d",
+			      ndlp->nlp_DID, kref_read(&ndlp->kref), 0);
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR) {
+		/* The additional lpfc_nlp_put will cause the following
+		 * lpfc_els_free_iocb routine to trigger the rlease of
+		 * the node.
+		 */
+		lpfc_els_free_iocb(phba, elsiocb);
+		lpfc_nlp_put(ndlp);
+		goto try_rdf;
+	}
+	return 0;
+try_rdf:
+	phba->cgn_reg_fpin = LPFC_CGN_FPIN_WARN | LPFC_CGN_FPIN_ALARM;
+	phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+	rc = lpfc_issue_els_rdf(vport, 0);
+	return rc;
+}
+
 /**
  * lpfc_cancel_retry_delay_tmo - Cancel the timer with delayed iocb-cmd retry
  * @vport: pointer to a host virtual N_Port data structure.
@@ -4515,7 +4945,7 @@ lpfc_els_free_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *elsiocb)
 {
 	struct lpfc_dmabuf *buf_ptr, *buf_ptr1;
 
-	/* The I/O job is complete.  Clear the context1 data. */
+	/* The I/O iocb is complete.  Clear the context1 data. */
 	elsiocb->context1 = NULL;
 
 	/* context2  = cmd,  context2->next = rsp, context3 = bpl */
@@ -5162,6 +5592,86 @@ lpfc_els_rsp_reject(struct lpfc_vport *vport, uint32_t rejectError,
 	return 0;
 }
 
+ /**
+  * lpfc_issue_els_edc_rsp - Exchange Diagnostic Capabilities with the fabric.
+  * @vport: pointer to a host virtual N_Port data structure.
+  * @cmdiocb: pointer to the original lpfc command iocb data structure.
+  * @ndlp: NPort to where rsp is directed
+  *
+  * This routine issues an EDC ACC RSP to the F-Port Controller to communicate
+  * this N_Port's support of hardware signals in its Congestion
+  * Capabilities Descriptor.
+  *
+  * Return code
+  *   0 - Successfully issued edc rsp command
+  *   1 - Failed to issue edc rsp command
+  **/
+static int
+lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
+		       struct lpfc_nodelist *ndlp)
+{
+	struct lpfc_hba  *phba = vport->phba;
+	struct lpfc_els_edc_rsp *edc_rsp;
+	struct lpfc_iocbq *elsiocb;
+	IOCB_t *icmd, *cmd;
+	uint8_t *pcmd;
+	int cmdsize, rc;
+
+	cmdsize = sizeof(struct lpfc_els_edc_rsp);
+	elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize, cmdiocb->retry,
+				     ndlp, ndlp->nlp_DID, ELS_CMD_ACC);
+	if (!elsiocb)
+		return 1;
+
+	icmd = &elsiocb->iocb;
+	cmd = &cmdiocb->iocb;
+	icmd->ulpContext = cmd->ulpContext;     /* Xri / rx_id */
+	icmd->unsli3.rcvsli3.ox_id = cmd->unsli3.rcvsli3.ox_id;
+	pcmd = (((struct lpfc_dmabuf *)elsiocb->context2)->virt);
+	memset(pcmd, 0, cmdsize);
+
+	edc_rsp = (struct lpfc_els_edc_rsp *)pcmd;
+	edc_rsp->edc_rsp.acc_hdr.la_cmd = ELS_LS_ACC;
+	edc_rsp->edc_rsp.desc_list_len = cpu_to_be32(
+		FC_TLV_DESC_LENGTH_FROM_SZ(struct lpfc_els_edc_rsp));
+	edc_rsp->edc_rsp.lsri.desc_tag = cpu_to_be32(ELS_DTAG_LS_REQ_INFO);
+	edc_rsp->edc_rsp.lsri.desc_len = cpu_to_be32(
+		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_els_lsri_desc));
+	edc_rsp->edc_rsp.lsri.rqst_w0.cmd = ELS_EDC;
+	lpfc_format_edc_cgn_desc(phba, &edc_rsp->cgn_desc);
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
+			      "Issue EDC ACC:      did:x%x flg:x%x refcnt %d",
+			      ndlp->nlp_DID, ndlp->nlp_flag,
+			      kref_read(&ndlp->kref));
+	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
+
+	phba->fc_stat.elsXmitACC++;
+	elsiocb->context1 = lpfc_nlp_get(ndlp);
+	if (!elsiocb->context1) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		return 1;
+	}
+
+	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
+	if (rc == IOCB_ERROR) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		lpfc_nlp_put(ndlp);
+		return 1;
+	}
+
+	/* Xmit ELS ACC response tag <ulpIoTag> */
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+			 "0152 Xmit EDC ACC response Status: x%x, IoTag: x%x, "
+			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
+			 "RPI: x%x, fc_flag x%x\n",
+			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
+			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
+			 ndlp->nlp_rpi, vport->fc_flag);
+
+	return 0;
+}
+
 /**
  * lpfc_els_rsp_adisc_acc - Prepare and issue acc response to adisc iocb cmd
  * @vport: pointer to a virtual N_Port data structure.
@@ -8231,6 +8741,125 @@ lpfc_els_rcv_fan(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	return 0;
 }
 
+/**
+ * lpfc_els_rcv_edc - Process an unsolicited EDC iocb
+ * @vport: pointer to a host virtual N_Port data structure.
+ * @cmdiocb: pointer to lpfc command iocb data structure.
+ * @ndlp: pointer to a node-list data structure.
+ *
+ * Return code
+ *   0 - Successfully processed echo iocb (currently always return 0)
+ **/
+static int
+lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
+		 struct lpfc_nodelist *ndlp)
+{
+	struct lpfc_hba  *phba = vport->phba;
+	struct fc_els_edc *edc_req;
+	struct fc_tlv_desc *tlv;
+	uint8_t *payload;
+	uint32_t *ptr, dtag;
+	const char *dtag_nm;
+	int desc_cnt = 0, bytes_remain;
+	bool rcv_cap_desc = false;
+
+	payload = ((struct lpfc_dmabuf *)cmdiocb->context2)->virt;
+
+	edc_req = (struct fc_els_edc *)payload;
+	bytes_remain = be32_to_cpu(edc_req->desc_len);
+
+	ptr = (uint32_t *)payload;
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
+			 "3319 Rcv EDC payload len %d: x%x x%x x%x\n",
+			 bytes_remain, be32_to_cpu(*ptr),
+			 be32_to_cpu(*(ptr + 1)), be32_to_cpu(*(ptr + 2)));
+
+	/* No signal support unless there is a congestion descriptor */
+	phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+	phba->cgn_sig_freq = 0;
+	phba->cgn_reg_fpin = LPFC_CGN_FPIN_ALARM | LPFC_CGN_FPIN_WARN;
+
+	if (bytes_remain <= 0)
+		goto out;
+
+	tlv = edc_req->desc;
+
+	/*
+	 * cycle through EDC diagnostic descriptors to find the
+	 * congestion signaling capability descriptor
+	 */
+	while (bytes_remain && !rcv_cap_desc) {
+		if (bytes_remain < FC_TLV_DESC_HDR_SZ) {
+			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6464 Truncated TLV hdr on "
+					"Diagnostic descriptor[%d]\n",
+					desc_cnt);
+			goto out;
+		}
+
+		dtag = be32_to_cpu(tlv->desc_tag);
+		switch (dtag) {
+		case ELS_DTAG_LNK_FAULT_CAP:
+			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
+			    FC_TLV_DESC_SZ_FROM_LENGTH(tlv) !=
+				sizeof(struct fc_diag_lnkflt_desc)) {
+				lpfc_printf_log(
+					phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6465 Truncated Link Fault Diagnostic "
+					"descriptor[%d]: %d vs %ld %ld\n",
+					desc_cnt, bytes_remain,
+					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
+					sizeof(struct fc_diag_cg_sig_desc));
+				goto out;
+			}
+			/* No action for Link Fault descriptor for now */
+			break;
+		case ELS_DTAG_CG_SIGNAL_CAP:
+			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
+			    FC_TLV_DESC_SZ_FROM_LENGTH(tlv) !=
+				sizeof(struct fc_diag_cg_sig_desc)) {
+				lpfc_printf_log(
+					phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6466 Truncated cgn signal Diagnostic "
+					"descriptor[%d]: %d vs %ld %ld\n",
+					desc_cnt, bytes_remain,
+					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
+					sizeof(struct fc_diag_cg_sig_desc));
+				goto out;
+			}
+
+			phba->cgn_reg_fpin = phba->cgn_init_reg_fpin;
+			phba->cgn_reg_signal = phba->cgn_init_reg_signal;
+
+			/* We start negotiation with lpfc_fabric_cgn_frequency.
+			 * When we process the EDC, we will settle on the
+			 * higher frequency.
+			 */
+			phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
+
+			lpfc_least_capable_settings(
+				phba, (struct fc_diag_cg_sig_desc *)tlv);
+			rcv_cap_desc = true;
+			break;
+		default:
+			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
+			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6467 unknown Diagnostic "
+					"Descriptor[%d]: tag x%x (%s)\n",
+					desc_cnt, dtag, dtag_nm);
+		}
+		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
+		tlv = fc_tlv_next_desc(tlv);
+		desc_cnt++;
+	}
+out:
+	/* Need to send back an ACC */
+	lpfc_issue_els_edc_rsp(vport, cmdiocb, ndlp);
+
+	lpfc_config_cgn_signal(phba);
+	return 0;
+}
+
 /**
  * lpfc_els_timeout - Handler funciton to the els timer
  * @t: timer context used to obtain the vport.
@@ -8688,9 +9317,6 @@ lpfc_send_els_event(struct lpfc_vport *vport,
 }
 
 
-DECLARE_ENUM2STR_LOOKUP(lpfc_get_tlv_dtag_nm, fc_ls_tlv_dtag,
-			FC_LS_TLV_DTAG_INIT);
-
 DECLARE_ENUM2STR_LOOKUP(lpfc_get_fpin_li_event_nm, fc_fpin_li_event_types,
 			FC_FPIN_LI_EVT_TYPES_INIT);
 
@@ -9426,6 +10052,9 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 		/* There are no replies, so no rjt codes */
 		break;
+	case ELS_CMD_EDC:
+		lpfc_els_rcv_edc(vport, elsiocb, ndlp);
+		break;
 	case ELS_CMD_RDF:
 		phba->fc_stat.elsRcvRDF++;
 		/* Accept RDF only from fabric controller */
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 6da2daf7d9e3..95989230b47e 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4209,6 +4209,7 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
 	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
 	struct lpfc_vport *vport = pmb->vport;
+	int rc;
 
 	pmb->ctx_buf = NULL;
 	pmb->ctx_ndlp = NULL;
@@ -4284,9 +4285,23 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		/* Issue SCR just before NameServer GID_FT Query */
 		lpfc_issue_els_scr(vport, 0);
 
-		if (!phba->cfg_enable_mi ||
-		    phba->sli4_hba.pc_sli4_params.mi_ver < LPFC_MIB3_SUPPORT)
+		/* Link was bounced or a Fabric LOGO occurred.  Start EDC
+		 * with initial FW values provided the congestion mode is
+		 * not off.  Note that signals may or may not be supported
+		 * by the adapter but FPIN is provided by default for 1
+		 * or both missing signals support.
+		 */
+		if (phba->cmf_active_mode != LPFC_CFG_OFF) {
+			phba->cgn_reg_fpin = phba->cgn_init_reg_fpin;
+			phba->cgn_reg_signal = phba->cgn_init_reg_signal;
+			rc = lpfc_issue_els_edc(vport, 0);
+			lpfc_printf_log(phba, KERN_INFO,
+					LOG_INIT | LOG_ELS | LOG_DISCOVERY,
+					"4220 EDC issue error x%x, Data: x%x\n",
+					rc, phba->cgn_init_reg_signal);
+		} else {
 			lpfc_issue_els_rdf(vport, 0);
+		}
 	}
 
 	vport->fc_ns_retry = 0;
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index 4083764916a5..634f8fff7425 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -608,6 +608,7 @@ struct fc_vft_header {
 #define ELS_CMD_LIRR      0x7A000000
 #define ELS_CMD_LCB	  0x81000000
 #define ELS_CMD_FPIN	  0x16000000
+#define ELS_CMD_EDC	  0x17000000
 #define ELS_CMD_QFPA      0xB0000000
 #define ELS_CMD_UVEM      0xB1000000
 #else	/*  __LITTLE_ENDIAN_BITFIELD */
@@ -652,6 +653,7 @@ struct fc_vft_header {
 #define ELS_CMD_LIRR      0x7A
 #define ELS_CMD_LCB	  0x81
 #define ELS_CMD_FPIN	  ELS_FPIN
+#define ELS_CMD_EDC	  ELS_EDC
 #define ELS_CMD_QFPA      0xB0
 #define ELS_CMD_UVEM      0xB1
 #endif
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 65bb4a66ccf0..ebee1d302a49 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -2813,6 +2813,12 @@ struct lpfc_mbx_read_config {
 #define lpfc_mbx_rd_conf_extnts_inuse_SHIFT	31
 #define lpfc_mbx_rd_conf_extnts_inuse_MASK	0x00000001
 #define lpfc_mbx_rd_conf_extnts_inuse_WORD	word1
+#define lpfc_mbx_rd_conf_wcs_SHIFT		28	/* warning signaling */
+#define lpfc_mbx_rd_conf_wcs_MASK		0x00000001
+#define lpfc_mbx_rd_conf_wcs_WORD		word1
+#define lpfc_mbx_rd_conf_acs_SHIFT		27	/* alarm signaling */
+#define lpfc_mbx_rd_conf_acs_MASK		0x00000001
+#define lpfc_mbx_rd_conf_acs_WORD		word1
 	uint32_t word2;
 #define lpfc_mbx_rd_conf_lnk_numb_SHIFT		0
 #define lpfc_mbx_rd_conf_lnk_numb_MASK		0x0000003F
@@ -3393,6 +3399,7 @@ struct lpfc_sli4_parameters {
 
 #define LPFC_SET_UE_RECOVERY		0x10
 #define LPFC_SET_MDS_DIAGS		0x12
+#define LPFC_SET_CGN_SIGNAL		0x1f
 #define LPFC_SET_DUAL_DUMP		0x1e
 #define LPFC_SET_ENABLE_MI		0x21
 struct lpfc_mbx_set_feature {
@@ -3409,6 +3416,9 @@ struct lpfc_mbx_set_feature {
 #define lpfc_mbx_set_feature_mds_deep_loopbk_SHIFT  1
 #define lpfc_mbx_set_feature_mds_deep_loopbk_MASK   0x00000001
 #define lpfc_mbx_set_feature_mds_deep_loopbk_WORD   word6
+#define lpfc_mbx_set_feature_CGN_warn_freq_SHIFT 0
+#define lpfc_mbx_set_feature_CGN_warn_freq_MASK  0x0000ffff
+#define lpfc_mbx_set_feature_CGN_warn_freq_WORD  word6
 #define lpfc_mbx_set_feature_dd_SHIFT		0
 #define lpfc_mbx_set_feature_dd_MASK		0x00000001
 #define lpfc_mbx_set_feature_dd_WORD		word6
@@ -3431,6 +3441,13 @@ struct lpfc_mbx_set_feature {
 #define lpfc_mbx_set_feature_UESR_SHIFT 16
 #define lpfc_mbx_set_feature_UESR_MASK  0x0000ffff
 #define lpfc_mbx_set_feature_UESR_WORD  word7
+#define lpfc_mbx_set_feature_CGN_alarm_freq_SHIFT 0
+#define lpfc_mbx_set_feature_CGN_alarm_freq_MASK  0x0000ffff
+#define lpfc_mbx_set_feature_CGN_alarm_freq_WORD  word7
+	u32 word8;
+#define lpfc_mbx_set_feature_CGN_acqe_freq_SHIFT 0
+#define lpfc_mbx_set_feature_CGN_acqe_freq_MASK  0x000000ff
+#define lpfc_mbx_set_feature_CGN_acqe_freq_WORD  word8
 };
 
 
@@ -4173,6 +4190,19 @@ struct lpfc_acqe_misconfigured_event {
 #define LPFC_SLI_EVENT_STATUS_UNCERTIFIED	0x05
 };
 
+struct lpfc_acqe_cgn_signal {
+	u32 word0;
+#define lpfc_warn_acqe_SHIFT		0
+#define lpfc_warn_acqe_MASK		0x7FFFFFFF
+#define lpfc_warn_acqe_WORD		word0
+#define lpfc_imm_acqe_SHIFT		31
+#define lpfc_imm_acqe_MASK		0x1
+#define lpfc_imm_acqe_WORD		word0
+	u32 alarm_cnt;
+	u32 word2;
+	u32 trailer;
+};
+
 struct lpfc_acqe_sli {
 	uint32_t event_data1;
 	uint32_t event_data2;
@@ -4187,6 +4217,7 @@ struct lpfc_acqe_sli {
 #define LPFC_SLI_EVENT_TYPE_REMOTE_DPORT	0xA
 #define LPFC_SLI_EVENT_TYPE_MISCONF_FAWWN	0xF
 #define LPFC_SLI_EVENT_TYPE_EEPROM_FAILURE	0x10
+#define LPFC_SLI_EVENT_TYPE_CGN_SIGNAL		0x11
 };
 
 /*
@@ -4815,6 +4846,17 @@ struct lpfc_grp_hdr {
 #define LPFC_FW_RESET	2
 #define LPFC_DV_RESET	3
 
+/* On some kernels, enum fc_ls_tlv_dtag does not have
+ * these 2 enums defined, on other kernels it does.
+ * To get aound this we need to add these 2 defines here.
+ */
+#ifndef ELS_DTAG_LNK_FAULT_CAP
+#define ELS_DTAG_LNK_FAULT_CAP        0x0001000D
+#endif
+#ifndef ELS_DTAG_CG_SIGNAL_CAP
+#define ELS_DTAG_CG_SIGNAL_CAP        0x0001000F
+#endif
+
 /*
  * Initializer useful for decoding FPIN string table.
  */
@@ -4823,6 +4865,22 @@ struct lpfc_grp_hdr {
 	{ FPIN_CONGN_SEVERITY_ERROR,		"Alarm" },	\
 }
 
+/* EDC supports two descriptors.  When allocated, it is the
+ * size of this structure plus each supported descriptor.
+ */
+struct lpfc_els_edc_req {
+	struct fc_els_edc               edc;       /* hdr up to descriptors */
+	struct fc_diag_cg_sig_desc      cgn_desc;  /* 1st descriptor */
+};
+
+/* Minimum structure defines for the EDC response.
+ * Balance is in buffer.
+ */
+struct lpfc_els_edc_rsp {
+	struct fc_els_edc_resp          edc_rsp;   /* hdr up to descriptors */
+	struct fc_diag_cg_sig_desc      cgn_desc;  /* 1st descriptor */
+};
+
 /* Used for logging FPIN messages */
 #define LPFC_FPIN_WWPN_LINE_SZ  128
 #define LPFC_FPIN_WWPN_LINE_CNT 6
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 6e75471525eb..9e4446302855 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1243,7 +1243,8 @@ lpfc_idle_stat_delay_work(struct work_struct *work)
 		return;
 
 	if (phba->link_state == LPFC_HBA_ERROR ||
-	    phba->pport->fc_flag & FC_OFFLINE_MODE)
+	    phba->pport->fc_flag & FC_OFFLINE_MODE ||
+	    phba->cmf_active_mode != LPFC_CFG_OFF)
 		goto requeue;
 
 	for_each_present_cpu(i) {
@@ -5528,9 +5529,10 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 	uint8_t operational = 0;
 	struct temp_event temp_event_data;
 	struct lpfc_acqe_misconfigured_event *misconfigured;
+	struct lpfc_acqe_cgn_signal *cgn_signal;
 	struct Scsi_Host  *shost;
 	struct lpfc_vport **vports;
-	int rc, i;
+	int rc, i, cnt;
 
 	evt_type = bf_get(lpfc_trailer_type, acqe_sli);
 
@@ -5703,6 +5705,40 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 			     "Event Data1: x%08x Event Data2: x%08x\n",
 			     acqe_sli->event_data1, acqe_sli->event_data2);
 		break;
+	case LPFC_SLI_EVENT_TYPE_CGN_SIGNAL:
+		if (phba->cmf_active_mode == LPFC_CFG_OFF)
+			break;
+		cgn_signal = (struct lpfc_acqe_cgn_signal *)
+					&acqe_sli->event_data1;
+		phba->cgn_acqe_cnt++;
+
+		cnt = bf_get(lpfc_warn_acqe, cgn_signal);
+		atomic64_add(cnt, &phba->cgn_acqe_stat.warn);
+		atomic64_add(cgn_signal->alarm_cnt, &phba->cgn_acqe_stat.alarm);
+
+		/* no threshold for CMF, even 1 signal will trigger an event */
+
+		/* Alarm overrides warning, so check that first */
+		if (cgn_signal->alarm_cnt) {
+			if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM) {
+				/* Keep track of alarm cnt for cgn_info */
+				atomic_add(cgn_signal->alarm_cnt,
+					   &phba->cgn_fabric_alarm_cnt);
+				/* Keep track of alarm cnt for CMF_SYNC_WQE */
+				atomic_add(cgn_signal->alarm_cnt,
+					   &phba->cgn_sync_alarm_cnt);
+			}
+		} else if (cnt) {
+			/* signal action needs to be taken */
+			if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ONLY ||
+			    phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM) {
+				/* Keep track of warning cnt for cgn_info */
+				atomic_add(cnt, &phba->cgn_fabric_warn_cnt);
+				/* Keep track of warning cnt for CMF_SYNC_WQE */
+				atomic_add(cnt, &phba->cgn_sync_warn_cnt);
+			}
+		}
+		break;
 	default:
 		lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 				"3193 Unrecognized SLI event, type: 0x%x",
@@ -8702,6 +8738,52 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 		phba->max_vpi = (phba->sli4_hba.max_cfg_param.max_vpi > 0) ?
 				(phba->sli4_hba.max_cfg_param.max_vpi - 1) : 0;
 		phba->max_vports = phba->max_vpi;
+
+		/* Next decide on FPIN or Signal E2E CGN support
+		 * For congestion alarms and warnings valid combination are:
+		 * 1. FPIN alarms / FPIN warnings
+		 * 2. Signal alarms / Signal warnings
+		 * 3. FPIN alarms / Signal warnings
+		 * 4. Signal alarms / FPIN warnings
+		 *
+		 * Initialize the adapter frequency to 100 mSecs
+		 */
+		phba->cgn_reg_fpin = LPFC_CGN_FPIN_BOTH;
+		phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+		phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
+
+		if (lpfc_use_cgn_signal) {
+			if (bf_get(lpfc_mbx_rd_conf_wcs, rd_config)) {
+				phba->cgn_reg_signal = EDC_CG_SIG_WARN_ONLY;
+				phba->cgn_reg_fpin &= ~LPFC_CGN_FPIN_WARN;
+			}
+			if (bf_get(lpfc_mbx_rd_conf_acs, rd_config)) {
+				/* MUST support both alarm and warning
+				 * because EDC does not support alarm alone.
+				 */
+				if (phba->cgn_reg_signal !=
+				    EDC_CG_SIG_WARN_ONLY) {
+					/* Must support both or none */
+					phba->cgn_reg_fpin = LPFC_CGN_FPIN_BOTH;
+					phba->cgn_reg_signal =
+						EDC_CG_SIG_NOTSUPPORTED;
+				} else {
+					phba->cgn_reg_signal =
+						EDC_CG_SIG_WARN_ALARM;
+					phba->cgn_reg_fpin =
+						LPFC_CGN_FPIN_NONE;
+				}
+			}
+		}
+
+		/* Set the congestion initial signal and fpin values. */
+		phba->cgn_init_reg_fpin = phba->cgn_reg_fpin;
+		phba->cgn_init_reg_signal = phba->cgn_reg_signal;
+
+		lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+				"6446 READ_CONFIG reg_sig x%x reg_fpin:x%x\n",
+				phba->cgn_reg_signal, phba->cgn_reg_fpin);
+
 		lpfc_map_topology(phba, rd_config);
 		lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 				"2003 cfg params Extents? %d "
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 5489cc7d06d5..3b6576d3be6d 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6417,6 +6417,7 @@ lpfc_set_features(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox,
 		  uint32_t feature)
 {
 	uint32_t len;
+	u32 sig_freq = 0;
 
 	len = sizeof(struct lpfc_mbx_set_feature) -
 		sizeof(struct lpfc_sli4_cfg_mhdr);
@@ -6439,6 +6440,35 @@ lpfc_set_features(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox,
 		mbox->u.mqe.un.set_feature.feature = LPFC_SET_MDS_DIAGS;
 		mbox->u.mqe.un.set_feature.param_len = 8;
 		break;
+	case LPFC_SET_CGN_SIGNAL:
+		if (phba->cmf_active_mode == LPFC_CFG_OFF)
+			sig_freq = 0;
+		else
+			sig_freq = phba->cgn_sig_freq;
+
+		if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM) {
+			bf_set(lpfc_mbx_set_feature_CGN_alarm_freq,
+			       &mbox->u.mqe.un.set_feature, sig_freq);
+			bf_set(lpfc_mbx_set_feature_CGN_warn_freq,
+			       &mbox->u.mqe.un.set_feature, sig_freq);
+		}
+
+		if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ONLY)
+			bf_set(lpfc_mbx_set_feature_CGN_warn_freq,
+			       &mbox->u.mqe.un.set_feature, sig_freq);
+
+		if (phba->cmf_active_mode == LPFC_CFG_OFF ||
+		    phba->cgn_reg_signal == EDC_CG_SIG_NOTSUPPORTED)
+			sig_freq = 0;
+		else
+			sig_freq = lpfc_acqe_cgn_frequency;
+
+		bf_set(lpfc_mbx_set_feature_CGN_acqe_freq,
+		       &mbox->u.mqe.un.set_feature, sig_freq);
+
+		mbox->u.mqe.un.set_feature.feature = LPFC_SET_CGN_SIGNAL;
+		mbox->u.mqe.un.set_feature.param_len = 12;
+		break;
 	case LPFC_SET_DUAL_DUMP:
 		bf_set(lpfc_mbx_set_feature_dd,
 		       &mbox->u.mqe.un.set_feature, LPFC_ENABLE_DUAL_DUMP);
@@ -7445,6 +7475,91 @@ lpfc_post_rq_buffer(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 	return 1;
 }
 
+static void
+lpfc_mbx_cmpl_cgn_set_ftrs(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
+{
+	struct lpfc_vport *vport = pmb->vport;
+	union lpfc_sli4_cfg_shdr *shdr;
+	u32 shdr_status, shdr_add_status;
+	u32 sig, acqe;
+
+	/* Two outcomes. (1) Set featurs was successul and EDC negotiation
+	 * is done. (2) Mailbox failed and send FPIN support only.
+	 */
+	shdr = (union lpfc_sli4_cfg_shdr *)
+		&pmb->u.mqe.un.sli4_config.header.cfg_shdr;
+	shdr_status = bf_get(lpfc_mbox_hdr_status, &shdr->response);
+	shdr_add_status = bf_get(lpfc_mbox_hdr_add_status, &shdr->response);
+	if (shdr_status || shdr_add_status || pmb->u.mb.mbxStatus) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_INIT | LOG_CGN_MGMT,
+				"2516 CGN SET_FEATURE mbox failed with "
+				"status x%x add_status x%x, mbx status x%x "
+				"Reset Congestion to FPINs only\n",
+				shdr_status, shdr_add_status,
+				pmb->u.mb.mbxStatus);
+		/* If there is a mbox error, move on to RDF */
+		phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+		phba->cgn_reg_fpin = LPFC_CGN_FPIN_WARN | LPFC_CGN_FPIN_ALARM;
+		goto out;
+	}
+
+	/* Zero out Congestion Signal ACQE counter */
+	phba->cgn_acqe_cnt = 0;
+	atomic64_set(&phba->cgn_acqe_stat.warn, 0);
+	atomic64_set(&phba->cgn_acqe_stat.alarm, 0);
+
+	acqe = bf_get(lpfc_mbx_set_feature_CGN_acqe_freq,
+		      &pmb->u.mqe.un.set_feature);
+	sig = bf_get(lpfc_mbx_set_feature_CGN_warn_freq,
+		     &pmb->u.mqe.un.set_feature);
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+			"4620 SET_FEATURES Success: Freq: %ds %dms "
+			" Reg: x%x x%x\n", acqe, sig,
+			phba->cgn_reg_signal, phba->cgn_reg_fpin);
+out:
+	mempool_free(pmb, phba->mbox_mem_pool);
+
+	/* Register for FPIN events from the fabric now that the
+	 * EDC common_set_features has completed.
+	 */
+	lpfc_issue_els_rdf(vport, 0);
+}
+
+int
+lpfc_config_cgn_signal(struct lpfc_hba *phba)
+{
+	LPFC_MBOXQ_t *mboxq;
+	u32 rc;
+
+	mboxq = (LPFC_MBOXQ_t *)mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
+	if (!mboxq)
+		goto out_rdf;
+
+	lpfc_set_features(phba, mboxq, LPFC_SET_CGN_SIGNAL);
+	mboxq->vport = phba->pport;
+	mboxq->mbox_cmpl = lpfc_mbx_cmpl_cgn_set_ftrs;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+			"4621 SET_FEATURES: FREQ sig x%x acqe x%x: "
+			"Reg: x%x x%x\n",
+			phba->cgn_sig_freq, lpfc_acqe_cgn_frequency,
+			phba->cgn_reg_signal, phba->cgn_reg_fpin);
+
+	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
+	if (rc == MBX_NOT_FINISHED)
+		goto out;
+	return 0;
+
+out:
+	mempool_free(mboxq, phba->mbox_mem_pool);
+out_rdf:
+	/* If there is a mbox error, move on to RDF */
+	phba->cgn_reg_fpin = LPFC_CGN_FPIN_WARN | LPFC_CGN_FPIN_ALARM;
+	phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+	lpfc_issue_els_rdf(phba->pport, 0);
+	return -EIO;
+}
+
 /**
  * lpfc_init_idle_stat_hb - Initialize idle_stat tracking
  * @phba: pointer to lpfc hba data structure.
@@ -7476,7 +7591,8 @@ static void lpfc_init_idle_stat_hb(struct lpfc_hba *phba)
 		idle_stat->prev_idle = get_cpu_idle_time(i, &wall, 1);
 		idle_stat->prev_wall = wall;
 
-		if (phba->nvmet_support)
+		if (phba->nvmet_support ||
+		    phba->cmf_active_mode != LPFC_CFG_OFF)
 			cq->poll_mode = LPFC_QUEUE_WORK;
 		else
 			cq->poll_mode = LPFC_IRQ_POLL;
@@ -9947,6 +10063,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 			if (pcmd && (*pcmd == ELS_CMD_FLOGI ||
 				*pcmd == ELS_CMD_SCR ||
 				*pcmd == ELS_CMD_RDF ||
+				*pcmd == ELS_CMD_EDC ||
 				*pcmd == ELS_CMD_RSCN_XMT ||
 				*pcmd == ELS_CMD_FDISC ||
 				*pcmd == ELS_CMD_LOGO ||
@@ -14814,8 +14931,12 @@ static void lpfc_sli4_sched_cq_work(struct lpfc_hba *phba,
 
 	switch (cq->poll_mode) {
 	case LPFC_IRQ_POLL:
-		irq_poll_sched(&cq->iop);
-		break;
+		/* CGN mgmt is mutually exclusive from softirq processing */
+		if (phba->cmf_active_mode == LPFC_CFG_OFF) {
+			irq_poll_sched(&cq->iop);
+			break;
+		}
+		fallthrough;
 	case LPFC_QUEUE_WORK:
 	default:
 		if (is_kdump_kernel())
-- 
2.26.2

