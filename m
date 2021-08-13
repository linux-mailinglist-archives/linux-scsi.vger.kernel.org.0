Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08573EAE6B
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 04:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbhHMCJ0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Aug 2021 22:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbhHMCJV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Aug 2021 22:09:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C9C0613D9
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so125828pjb.3
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8aSmKu2UwQ4IQFlJYV3YEdLSP1WIQv6SOWwKjFpeAEk=;
        b=XSLxLPxArDvHp3PD5bNSBpANNgLx4qP2iuXi1OiJCSYNUOZkwWCQecsoAuHkNoepSr
         faYQZ+Z6dEGiS/t/n4O7KR8ya0lTDQhoX1hUMwDtbFxWdYJpI2tz6iZ9ODvH73S9sCP6
         OgCtJ5UOUwb/7qSmAkLu+Hknhl303dHO+PB3rmZbDs5yyCg+8gBAjUcUFw0ypijWA3WN
         0r57N7RHTGr4EMr1iDWpePTNFP9XFP9r+cTHVQJLiIRX31hf6GZQqrnhi2EH2DH3KfVq
         rnCPvNlC3vdpjB02u6LsY2F0SRNRASFHdUSxk94W0rrpGjzOehrwUP2keteeHa9yg7Cw
         NkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8aSmKu2UwQ4IQFlJYV3YEdLSP1WIQv6SOWwKjFpeAEk=;
        b=oXwS63KDzZH7LT55ILCkfYzVlKXxYSDZesr4w+R2wqC+mJ1iR5JjaOOS8L2jCY8Alf
         3XgtAKW58ERpQ1KHETtArkONVhCO6yanOeGYrK688mkxNz7i7LUIUwg0VSYQrsQK9DZl
         5E5EqePWCj04DYSfSxABLgj0RRSoEOIheDANHSXVS3qlygKh0sIpbXxUPoT6TugkFIup
         4d2j/HsrhjB99CGWdTpavZxl1dZZXLM/4BkV1DK4tsZq/XgToqxFjUQ4fddKKPtVZyEh
         W9O3DSLcyifEUSOUiETrvYGEFRCaANK3bIaO6yOKreesZ2+Svi11F1SN7NhS5eQNWzfM
         DcHQ==
X-Gm-Message-State: AOAM53256C+fOvyyFrcnPU7JOSYDqTN3EORYkbgUlCgVwWZEnQAGri4x
        2OxuovT0Fdny+QOGpXANyuZEip00hXA=
X-Google-Smtp-Source: ABdhPJwINkoIaBTcLG9pCeAT463zvb4ETGF1hMoUHY1kFPIEu19wOo+9jTKO+vneQ+6ZuWbuPFmVQA==
X-Received: by 2002:a63:2243:: with SMTP id t3mr81592pgm.114.1628820534703;
        Thu, 12 Aug 2021 19:08:54 -0700 (PDT)
Received: from localhost.localdomain (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id ca7sm102619pjb.11.2021.08.12.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 19:08:54 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 09/16] lpfc: Add support for the CM framework
Date:   Thu, 12 Aug 2021 19:08:05 -0700
Message-Id: <20210813020812.99014-10-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210813020812.99014-1-jsmart2021@gmail.com>
References: <20210813020812.99014-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch completes the enablement of the cm framework feature in the
adapter.

The patch performs the following:
- Detects the presence of the congestion management framework feature

When the cm framework is present:
- Issues the SET_FEATURE command to enable the feature
- Registers the cm statistics buffer with the adapter
- Reads the cm enablement buffer to determine the cm framework state
  for cm management.

When cm management is enabled:
- Monitors all FPIN and congestion signalling events, incrementing
  counters.
- Regularly syncs with the adapter to communicate congestion events and
  to receive an rx request limit.
- Monitors requests for rx data and ensures that no more than the
  adapter prescribed limit is issued on the link. If the limit is
  exceeded, scsi and/or nvme traffic is temporarily suspended.
- Maintains the minute, hourly, daily statistics buffer.
- Monitors for congestion enablement change events, causing a reread of
  the enablement buffer and acting on any change in enablement.

And
- Adds teardown logic, including buffer deregistration, on adapter
  detachment or reset.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h         |  33 ++-
 drivers/scsi/lpfc/lpfc_attr.c    |   1 +
 drivers/scsi/lpfc/lpfc_crtn.h    |  10 +
 drivers/scsi/lpfc/lpfc_els.c     |  73 +++++-
 drivers/scsi/lpfc/lpfc_hbadisc.c |   4 +
 drivers/scsi/lpfc/lpfc_init.c    | 391 ++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_mem.c     |   9 +
 drivers/scsi/lpfc/lpfc_nvme.c    |  44 +++-
 drivers/scsi/lpfc/lpfc_scsi.c    | 185 ++++++++++++++-
 drivers/scsi/lpfc/lpfc_sli.c     | 192 ++++++++++++++-
 drivers/scsi/lpfc/lpfc_sli.h     |   1 +
 drivers/scsi/lpfc/lpfc_sli4.h    |   1 +
 12 files changed, 910 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 12972bfed923..298b908e9126 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -550,6 +550,14 @@ struct lpfc_cgn_info {
 #define LPFC_CGN_INFO_SZ	(sizeof(struct lpfc_cgn_info) -  \
 				sizeof(uint32_t))
 
+struct lpfc_cgn_stat {
+	atomic64_t total_bytes;
+	atomic64_t rcv_bytes;
+	atomic64_t rx_latency;
+#define LPFC_CGN_NOT_SENT	0xFFFFFFFFFFFFFFFFLL
+	atomic_t rx_io_cnt;
+};
+
 struct lpfc_cgn_acqe_stat {
 	atomic64_t alarm;
 	atomic64_t warn;
@@ -1021,7 +1029,10 @@ struct lpfc_hba {
 					 * capability
 					 */
 #define HBA_FLOGI_ISSUED	0x100000 /* FLOGI was issued */
+#define HBA_CGN_RSVD1		0x200000 /* Reserved CGN flag */
+#define HBA_CGN_DAY_WRAP	0x400000 /* HBA Congestion info day wraps */
 #define HBA_DEFER_FLOGI		0x800000 /* Defer FLOGI till read_sparm cmpl */
+#define HBA_SETUP		0x1000000 /* Signifies HBA setup is completed */
 #define HBA_NEEDS_CFG_PORT	0x2000000 /* SLI3 - needs a CONFIG_PORT mbox */
 #define HBA_HBEAT_INP		0x4000000 /* mbox HBEAT is in progress */
 #define HBA_HBEAT_TMO		0x8000000 /* HBEAT initiated after timeout */
@@ -1272,6 +1283,7 @@ struct lpfc_hba {
 	uint32_t total_iocbq_bufs;
 	struct list_head active_rrq_list;
 	spinlock_t hbalock;
+	struct work_struct  unblock_request_work; /* SCSI layer unblock IOs */
 
 	/* dma_mem_pools */
 	struct dma_pool *lpfc_sg_dma_buf_pool;
@@ -1496,12 +1508,25 @@ struct lpfc_hba {
 	uint64_t ktime_seg10_max;
 #endif
 	/* CMF objects */
-	u32 cmf_active_mode;
-#define LPFC_CFG_OFF		0
-
+	struct lpfc_cgn_stat __percpu *cmf_stat;
+	uint32_t cmf_interval_rate;  /* timer interval limit in ms */
+	uint32_t cmf_timer_cnt;
 #define LPFC_CMF_INTERVAL 90
+	uint64_t cmf_link_byte_count;
+	uint64_t cmf_max_line_rate;
+	uint64_t cmf_max_bytes_per_interval;
+	uint64_t cmf_last_sync_bw;
 #define  LPFC_CMF_BLK_SIZE 512
+	struct hrtimer cmf_timer;
+	atomic_t cmf_bw_wait;
+	atomic_t cmf_busy;
+	atomic_t cmf_stop_io;      /* To block request and stop IO's */
+	uint32_t cmf_active_mode;
+	uint32_t cmf_info_per_interval;
 #define LPFC_MAX_CMF_INFO 32
+	struct timespec64 cmf_latency;  /* Interval congestion timestamp */
+	uint32_t cmf_last_ts;   /* Interval congestion time (ms) */
+	uint32_t cmf_active_info;
 
 	/* Signal / FPIN handling for Congestion Mgmt */
 	u8 cgn_reg_fpin;           /* Negotiated value from RDF */
@@ -1521,6 +1546,8 @@ struct lpfc_hba {
 	u32 cgn_sig_freq;
 	u32 cgn_acqe_cnt;
 
+	uint64_t rx_block_cnt;
+
 	/* Congestion parameters from flash */
 	struct lpfc_cgn_param cgn_p;
 
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 449409cad60d..b41891aefa64 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -7476,6 +7476,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_enable_dpp_init(phba, lpfc_enable_dpp);
 	lpfc_enable_mi_init(phba, lpfc_enable_mi);
 
+	phba->cgn_p.cgn_param_mode = LPFC_CFG_OFF;
 	phba->cmf_active_mode = LPFC_CFG_OFF;
 	if (lpfc_fabric_cgn_frequency > EDC_CG_SIGFREQ_CNT_MAX ||
 	   lpfc_fabric_cgn_frequency < EDC_CG_SIGFREQ_CNT_MIN)
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 3621acf9437d..3addb163c2cd 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -59,6 +59,7 @@ int lpfc_sli4_mbox_rsrc_extent(struct lpfc_hba *, struct lpfcMboxq *,
 			   uint16_t, uint16_t, bool);
 int lpfc_get_sli4_parameters(struct lpfc_hba *, LPFC_MBOXQ_t *);
 int lpfc_reg_congestion_buf(struct lpfc_hba *phba);
+int lpfc_unreg_congestion_buf(struct lpfc_hba *phba);
 struct lpfc_vport *lpfc_find_vport_by_did(struct lpfc_hba *, uint32_t);
 void lpfc_cleanup_rcv_buffers(struct lpfc_vport *);
 void lpfc_rcv_seq_check_edtov(struct lpfc_vport *);
@@ -75,11 +76,17 @@ int lpfc_init_iocb_list(struct lpfc_hba *phba, int cnt);
 void lpfc_free_iocb_list(struct lpfc_hba *phba);
 int lpfc_post_rq_buffer(struct lpfc_hba *phba, struct lpfc_queue *hrq,
 			struct lpfc_queue *drq, int count, int idx);
+uint32_t lpfc_calc_cmf_latency(struct lpfc_hba *phba);
+void lpfc_cmf_signal_init(struct lpfc_hba *phba);
+void lpfc_cmf_start(struct lpfc_hba *phba);
+void lpfc_cmf_stop(struct lpfc_hba *phba);
 void lpfc_init_congestion_stat(struct lpfc_hba *phba);
 void lpfc_init_congestion_buf(struct lpfc_hba *phba);
 int lpfc_sli4_cgn_params_read(struct lpfc_hba *phba);
 int lpfc_config_cgn_signal(struct lpfc_hba *phba);
 int lpfc_issue_cmf_sync_wqe(struct lpfc_hba *phba, u32 ms, u64 total);
+void lpfc_unblock_requests(struct lpfc_hba *phba);
+void lpfc_block_requests(struct lpfc_hba *phba);
 
 void lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_mbx_cmpl_reg_login(struct lpfc_hba *, LPFC_MBOXQ_t *);
@@ -471,6 +478,9 @@ void lpfc_free_fast_evt(struct lpfc_hba *, struct lpfc_fast_path_event *);
 void lpfc_create_static_vport(struct lpfc_hba *);
 void lpfc_stop_hba_timers(struct lpfc_hba *);
 void lpfc_stop_port(struct lpfc_hba *);
+int lpfc_update_cmf_cmd(struct lpfc_hba *phba, uint32_t sz);
+int lpfc_update_cmf_cmpl(struct lpfc_hba *phba, uint64_t val, uint32_t sz,
+			 struct Scsi_Host *shost);
 void __lpfc_sli4_stop_fcf_redisc_wait_timer(struct lpfc_hba *);
 void lpfc_sli4_stop_fcf_redisc_wait_timer(struct lpfc_hba *);
 void lpfc_parse_fcoe_conf(struct lpfc_hba *, uint8_t *, uint32_t);
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 1b587fbfe233..e2542305ba12 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -3333,9 +3333,11 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_ELS | LOG_CGN_MGMT,
 					 "4677 Fabric RDF Notification Grant "
-					 "Data: 0x%08x\n",
+					 "Data: 0x%08x Reg: %x %x\n",
 					 be32_to_cpu(
-						prdf->reg_d1.desc_tags[i]));
+						prdf->reg_d1.desc_tags[i]),
+					 phba->cgn_reg_signal,
+					 phba->cgn_reg_fpin);
 	}
 
 out:
@@ -3702,9 +3704,11 @@ lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry)
 	prdf->reg_d1.desc_tags[3] = cpu_to_be32(ELS_DTAG_CONGESTION);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
-			 "6444 Xmit RDF to remote NPORT x%x\n",
-			 ndlp->nlp_DID);
+			 "6444 Xmit RDF to remote NPORT x%x Reg: %x %x\n",
+			 ndlp->nlp_DID, phba->cgn_reg_signal,
+			 phba->cgn_reg_fpin);
 
+	phba->cgn_fpin_frequency = LPFC_FPIN_INIT_FREQ;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_disc_cmd;
 	elsiocb->context1 = lpfc_nlp_get(ndlp);
 	if (!elsiocb->context1) {
@@ -3778,6 +3782,8 @@ lpfc_least_capable_settings(struct lpfc_hba *phba,
 {
 	u32 rsp_sig_cap = 0, drv_sig_cap = 0;
 	u32 rsp_sig_freq_cyc = 0, rsp_sig_freq_scale = 0;
+	struct lpfc_cgn_info *cp;
+	u16 sig_freq;
 
 	/* Get rsp signal and frequency capabilities.  */
 	rsp_sig_cap = be32_to_cpu(pcgd->xmt_signal_capability);
@@ -3832,6 +3838,24 @@ lpfc_least_capable_settings(struct lpfc_hba *phba,
 			phba->cgn_reg_fpin &= ~LPFC_CGN_FPIN_WARN;
 		}
 	}
+
+	if (!phba->cgn_i)
+		return;
+
+	/* Update signal frequency in congestion info buffer */
+	cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
+
+	/* Frequency (in ms) Signal Warning/Signal Congestion Notifications
+	 * are received by the HBA
+	 */
+	sig_freq = phba->cgn_sig_freq;
+
+	if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ONLY)
+		cp->cgn_warn_freq = cpu_to_le16(sig_freq);
+	if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM) {
+		cp->cgn_alarm_freq = cpu_to_le16(sig_freq);
+		cp->cgn_warn_freq = cpu_to_le16(sig_freq);
+	}
 	return;
 
 out_no_support:
@@ -9508,11 +9532,13 @@ lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 static int
 lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 {
+	struct lpfc_cgn_info *cp;
 	struct fc_fn_congn_desc *cgn = (struct fc_fn_congn_desc *)tlv;
 	const char *cgn_evt_str;
 	u32 cgn_evt;
 	const char *cgn_sev_str;
 	u32 cgn_sev;
+	uint16_t value;
 	bool nm_log = false;
 	int rc = 1;
 
@@ -9540,9 +9566,48 @@ lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 		switch (cgn_sev) {
 		case FPIN_CONGN_SEVERITY_ERROR:
 			/* Take action here for an Alarm event */
+			if (phba->cmf_active_mode != LPFC_CFG_OFF) {
+				if (phba->cgn_reg_fpin & LPFC_CGN_FPIN_ALARM) {
+					/* Track of alarm cnt for cgn_info */
+					atomic_inc(&phba->cgn_fabric_alarm_cnt);
+					/* Track of alarm cnt for SYNC_WQE */
+					atomic_inc(&phba->cgn_sync_alarm_cnt);
+				}
+				goto cleanup;
+			}
 			break;
 		case FPIN_CONGN_SEVERITY_WARNING:
 			/* Take action here for a Warning event */
+			if (phba->cmf_active_mode != LPFC_CFG_OFF) {
+				if (phba->cgn_reg_fpin & LPFC_CGN_FPIN_WARN) {
+					/* Track of warning cnt for cgn_info */
+					atomic_inc(&phba->cgn_fabric_warn_cnt);
+					/* Track of warning cnt for SYNC_WQE */
+					atomic_inc(&phba->cgn_sync_warn_cnt);
+				}
+cleanup:
+				/* Save frequency in ms */
+				phba->cgn_fpin_frequency =
+					be32_to_cpu(cgn->event_period);
+				value = phba->cgn_fpin_frequency;
+				if (phba->cgn_i) {
+					cp = (struct lpfc_cgn_info *)
+						phba->cgn_i->virt;
+					if (phba->cgn_reg_fpin &
+						LPFC_CGN_FPIN_ALARM)
+						cp->cgn_alarm_freq =
+							cpu_to_le16(value);
+					if (phba->cgn_reg_fpin &
+						LPFC_CGN_FPIN_WARN)
+						cp->cgn_warn_freq =
+							cpu_to_le16(value);
+				}
+
+				/* Don't deliver to upper layer since
+				 * driver took action on this tlv.
+				 */
+				rc = 0;
+			}
 			break;
 		}
 		break;
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 95989230b47e..7195ca0275f9 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -3647,6 +3647,10 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 					phba->wait_4_mlo_maint_flg);
 		}
 		lpfc_mbx_process_link_up(phba, la);
+
+		if (phba->cmf_active_mode != LPFC_CFG_OFF)
+			lpfc_cmf_signal_init(phba);
+
 	} else if (attn_type == LPFC_ATT_LINK_DOWN ||
 		   attn_type == LPFC_ATT_UNEXP_WWPN) {
 		phba->fc_stat.LinkDown++;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a34f667e1cd0..65d5ee9b3e30 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -93,6 +93,7 @@ static uint32_t lpfc_sli4_enable_intr(struct lpfc_hba *, uint32_t);
 static void lpfc_sli4_oas_verify(struct lpfc_hba *phba);
 static uint16_t lpfc_find_cpu_handle(struct lpfc_hba *, uint16_t, int);
 static void lpfc_setup_bg(struct lpfc_hba *, struct Scsi_Host *);
+static int lpfc_sli4_cgn_parm_chg_evt(struct lpfc_hba *);
 
 static struct scsi_transport_template *lpfc_transport_template = NULL;
 static struct scsi_transport_template *lpfc_vport_transport_template = NULL;
@@ -3020,6 +3021,123 @@ lpfc_sli4_stop_fcf_redisc_wait_timer(struct lpfc_hba *phba)
 	spin_unlock_irq(&phba->hbalock);
 }
 
+/**
+ * lpfc_cmf_stop - Stop CMF processing
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * This is called when the link goes down or if CMF mode is turned OFF.
+ * It is also called when going offline or unloaded just before the
+ * congestion info buffer is unregistered.
+ **/
+void
+lpfc_cmf_stop(struct lpfc_hba *phba)
+{
+	int cpu;
+	struct lpfc_cgn_stat *cgs;
+
+	/* We only do something if CMF is enabled */
+	if (!phba->sli4_hba.pc_sli4_params.cmf)
+		return;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+			"6221 Stop CMF / Cancel Timer\n");
+
+	/* Cancel the CMF timer */
+	hrtimer_cancel(&phba->cmf_timer);
+
+	/* Zero CMF counters */
+	atomic_set(&phba->cmf_busy, 0);
+	for_each_present_cpu(cpu) {
+		cgs = per_cpu_ptr(phba->cmf_stat, cpu);
+		atomic64_set(&cgs->total_bytes, 0);
+		atomic64_set(&cgs->rcv_bytes, 0);
+		atomic_set(&cgs->rx_io_cnt, 0);
+		atomic64_set(&cgs->rx_latency, 0);
+	}
+	atomic_set(&phba->cmf_bw_wait, 0);
+
+	/* Resume any blocked IO - Queue unblock on workqueue */
+	queue_work(phba->wq, &phba->unblock_request_work);
+}
+
+static inline uint64_t
+lpfc_get_max_line_rate(struct lpfc_hba *phba)
+{
+	uint64_t rate = lpfc_sli_port_speed_get(phba);
+
+	return ((((unsigned long)rate) * 1024 * 1024) / 10);
+}
+
+void
+lpfc_cmf_signal_init(struct lpfc_hba *phba)
+{
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+			"6223 Signal CMF init\n");
+
+	/* Use the new fc_linkspeed to recalculate */
+	phba->cmf_interval_rate = LPFC_CMF_INTERVAL;
+	phba->cmf_max_line_rate = lpfc_get_max_line_rate(phba);
+	phba->cmf_link_byte_count = (phba->cmf_max_line_rate *
+		phba->cmf_interval_rate) / 1000;
+	phba->cmf_max_bytes_per_interval = phba->cmf_link_byte_count;
+
+	/* This is a signal to firmware to sync up CMF BW with link speed */
+	lpfc_issue_cmf_sync_wqe(phba, 0, 0);
+}
+
+/**
+ * lpfc_cmf_start - Start CMF processing
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * This is called when the link comes up or if CMF mode is turned OFF
+ * to Monitor or Managed.
+ **/
+void
+lpfc_cmf_start(struct lpfc_hba *phba)
+{
+	struct lpfc_cgn_stat *cgs;
+	int cpu;
+
+	/* We only do something if CMF is enabled */
+	if (!phba->sli4_hba.pc_sli4_params.cmf ||
+	    phba->cmf_active_mode == LPFC_CFG_OFF)
+		return;
+
+	/* Reinitialize congestion buffer info */
+	lpfc_init_congestion_buf(phba);
+
+	atomic_set(&phba->cgn_fabric_warn_cnt, 0);
+	atomic_set(&phba->cgn_fabric_alarm_cnt, 0);
+	atomic_set(&phba->cgn_sync_alarm_cnt, 0);
+	atomic_set(&phba->cgn_sync_warn_cnt, 0);
+
+	atomic_set(&phba->cmf_busy, 0);
+	for_each_present_cpu(cpu) {
+		cgs = per_cpu_ptr(phba->cmf_stat, cpu);
+		atomic64_set(&cgs->total_bytes, 0);
+		atomic64_set(&cgs->rcv_bytes, 0);
+		atomic_set(&cgs->rx_io_cnt, 0);
+		atomic64_set(&cgs->rx_latency, 0);
+	}
+	phba->cmf_latency.tv_sec = 0;
+	phba->cmf_latency.tv_nsec = 0;
+
+	lpfc_cmf_signal_init(phba);
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+			"6222 Start CMF / Timer\n");
+
+	phba->cmf_timer_cnt = 0;
+	hrtimer_start(&phba->cmf_timer,
+		      ktime_set(0, LPFC_CMF_INTERVAL * 1000000),
+		      HRTIMER_MODE_REL);
+	/* Setup for latency check in IO cmpl routines */
+	ktime_get_real_ts64(&phba->cmf_latency);
+
+	atomic_set(&phba->cmf_bw_wait, 0);
+	atomic_set(&phba->cmf_stop_io, 0);
+}
+
 /**
  * lpfc_stop_hba_timers - Stop all the timers associated with an HBA
  * @phba: pointer to lpfc hba data structure.
@@ -5286,6 +5404,165 @@ lpfc_async_link_speed_to_read_top(struct lpfc_hba *phba, uint8_t speed_code)
 	return port_speed;
 }
 
+/**
+ * lpfc_calc_cmf_latency - latency from start of rxate timer interval
+ * @phba: The Hba for which this call is being executed.
+ *
+ * The routine calculates the latency from the beginning of the CMF timer
+ * interval to the current point in time. It is called from IO completion
+ * when we exceed our Bandwidth limitation for the time interval.
+ */
+uint32_t
+lpfc_calc_cmf_latency(struct lpfc_hba *phba)
+{
+	struct timespec64 cmpl_time;
+	uint32_t msec = 0;
+
+	ktime_get_real_ts64(&cmpl_time);
+
+	/* This routine works on a ms granularity so sec and usec are
+	 * converted accordingly.
+	 */
+	if (cmpl_time.tv_sec == phba->cmf_latency.tv_sec) {
+		msec = (cmpl_time.tv_nsec - phba->cmf_latency.tv_nsec) /
+			NSEC_PER_MSEC;
+	} else {
+		if (cmpl_time.tv_nsec >= phba->cmf_latency.tv_nsec) {
+			msec = (cmpl_time.tv_sec -
+				phba->cmf_latency.tv_sec) * MSEC_PER_SEC;
+			msec += ((cmpl_time.tv_nsec -
+				  phba->cmf_latency.tv_nsec) / NSEC_PER_MSEC);
+		} else {
+			msec = (cmpl_time.tv_sec - phba->cmf_latency.tv_sec -
+				1) * MSEC_PER_SEC;
+			msec += (((NSEC_PER_SEC - phba->cmf_latency.tv_nsec) +
+				 cmpl_time.tv_nsec) / NSEC_PER_MSEC);
+		}
+	}
+	return msec;
+}
+
+/**
+ * lpfc_cmf_timer -  This is the timer function for one congestion
+ * rate interval.
+ * @timer: Pointer to the high resolution timer that expired
+ */
+static enum hrtimer_restart
+lpfc_cmf_timer(struct hrtimer *timer)
+{
+	struct lpfc_hba *phba = container_of(timer, struct lpfc_hba,
+					     cmf_timer);
+	uint32_t io_cnt;
+	uint64_t total, rcv, lat, mbpi;
+	int timer_interval = LPFC_CMF_INTERVAL;
+	struct lpfc_cgn_stat *cgs;
+	int cpu;
+
+	/* Only restart the timer if congestion mgmt is on */
+	if (phba->cmf_active_mode == LPFC_CFG_OFF ||
+	    !phba->cmf_latency.tv_sec) {
+		lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+				"6224 CMF timer exit: %d %lld\n",
+				phba->cmf_active_mode,
+				(uint64_t)phba->cmf_latency.tv_sec);
+		return HRTIMER_NORESTART;
+	}
+
+	/* If pport is not ready yet, just exit and wait for
+	 * the next timer cycle to hit.
+	 */
+	if (!phba->pport)
+		goto skip;
+
+	/* Do not block SCSI IO while in the timer routine since
+	 * total_bytes will be cleared
+	 */
+	atomic_set(&phba->cmf_stop_io, 1);
+
+	/* Immediately after we calculate the time since the last
+	 * timer interrupt, set the start time for the next
+	 * interrupt
+	 */
+	ktime_get_real_ts64(&phba->cmf_latency);
+
+	phba->cmf_link_byte_count =
+		(phba->cmf_max_line_rate * LPFC_CMF_INTERVAL) / 1000;
+
+	/* Collect all the stats from the prior timer interval */
+	total = 0;
+	io_cnt = 0;
+	lat = 0;
+	rcv = 0;
+	for_each_present_cpu(cpu) {
+		cgs = per_cpu_ptr(phba->cmf_stat, cpu);
+		total += atomic64_xchg(&cgs->total_bytes, 0);
+		io_cnt += atomic_xchg(&cgs->rx_io_cnt, 0);
+		lat += atomic64_xchg(&cgs->rx_latency, 0);
+		rcv += atomic64_xchg(&cgs->rcv_bytes, 0);
+	}
+
+	/* Before we issue another CMF_SYNC_WQE, retrieve the BW
+	 * returned from the last CMF_SYNC_WQE issued, from
+	 * cmf_last_sync_bw. This will be the target BW for
+	 * this next timer interval.
+	 */
+	if (phba->cmf_active_mode == LPFC_CFG_MANAGED &&
+	    phba->link_state != LPFC_LINK_DOWN &&
+	    phba->hba_flag & HBA_SETUP) {
+		mbpi = phba->cmf_last_sync_bw;
+		phba->cmf_last_sync_bw = 0;
+		lpfc_issue_cmf_sync_wqe(phba, LPFC_CMF_INTERVAL, total);
+	} else {
+		/* For Monitor mode or link down we want mbpi
+		 * to be the full link speed
+		 */
+		mbpi = phba->cmf_link_byte_count;
+	}
+	phba->cmf_timer_cnt++;
+
+	if (io_cnt) {
+		/* Update congestion info buffer latency in us */
+		atomic_add(io_cnt, &phba->cgn_latency_evt_cnt);
+		atomic64_add(lat, &phba->cgn_latency_evt);
+	}
+
+	/* Calculate MBPI for the next timer interval */
+	if (mbpi) {
+		if (mbpi > phba->cmf_link_byte_count ||
+		    phba->cmf_active_mode == LPFC_CFG_MONITOR)
+			mbpi = phba->cmf_link_byte_count;
+
+		/* Change max_bytes_per_interval to what the prior
+		 * CMF_SYNC_WQE cmpl indicated.
+		 */
+		if (mbpi != phba->cmf_max_bytes_per_interval)
+			phba->cmf_max_bytes_per_interval = mbpi;
+	}
+
+	if (phba->cmf_active_mode == LPFC_CFG_MONITOR) {
+		/* If Monitor mode, check if we are oversubscribed
+		 * against the full line rate.
+		 */
+		if (mbpi && total > mbpi)
+			atomic_inc(&phba->cgn_driver_evt_cnt);
+	}
+	phba->rx_block_cnt += (rcv / 512);  /* save 512 byte block cnt */
+
+	/* Since total_bytes has already been zero'ed, its okay to unblock
+	 * after max_bytes_per_interval is setup.
+	 */
+	if (atomic_xchg(&phba->cmf_bw_wait, 0))
+		queue_work(phba->wq, &phba->unblock_request_work);
+
+	/* SCSI IO is now unblocked */
+	atomic_set(&phba->cmf_stop_io, 0);
+
+skip:
+	hrtimer_forward_now(timer,
+			    ktime_set(0, timer_interval * NSEC_PER_MSEC));
+	return HRTIMER_RESTART;
+}
+
 #define trunk_link_status(__idx)\
 	bf_get(lpfc_acqe_fc_la_trunk_config_port##__idx, acqe_fc) ?\
 	       ((phba->trunk_link.link##__idx.state == LPFC_LINK_UP) ?\
@@ -5348,6 +5625,9 @@ lpfc_update_trunk_link_status(struct lpfc_hba *phba,
 			trunk_link_status(0), trunk_link_status(1),
 			trunk_link_status(2), trunk_link_status(3));
 
+	if (phba->cmf_active_mode != LPFC_CFG_OFF)
+		lpfc_cmf_signal_init(phba);
+
 	if (port_fault)
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3202 trunk error:0x%x (%s) seen on port0:%s "
@@ -5688,6 +5968,10 @@ lpfc_sli4_async_sli_evt(struct lpfc_hba *phba, struct lpfc_acqe_sli *acqe_sli)
 				"Event Data1:x%08x Event Data2: x%08x\n",
 				acqe_sli->event_data1, acqe_sli->event_data2);
 		break;
+	case LPFC_SLI_EVENT_TYPE_PORT_PARAMS_CHG:
+		/* Call FW to obtain active parms */
+		lpfc_sli4_cgn_parm_chg_evt(phba);
+		break;
 	case LPFC_SLI_EVENT_TYPE_MISCONF_FAWWN:
 		/* Misconfigured WWN. Reports that the SLI Port is configured
 		 * to use FA-WWN, but the attached device doesn’t support it.
@@ -6113,6 +6397,21 @@ lpfc_sli4_async_grp5_evt(struct lpfc_hba *phba,
 			phba->sli4_hba.link_state.logical_speed);
 }
 
+/**
+ * lpfc_sli4_async_cmstat_evt - Process the asynchronous cmstat event
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * This routine is to handle the SLI4 asynchronous cmstat event. A cmstat event
+ * is an asynchronous notification of a request to reset CM stats.
+ **/
+static void
+lpfc_sli4_async_cmstat_evt(struct lpfc_hba *phba)
+{
+	if (!phba->cgn_i)
+		return;
+	lpfc_init_congestion_stat(phba);
+}
+
 /**
  * lpfc_cgn_params_val - Validate FW congestion parameters.
  * @phba: pointer to lpfc hba data structure.
@@ -6200,6 +6499,7 @@ lpfc_cgn_params_parse(struct lpfc_hba *phba,
 		case LPFC_CFG_OFF:
 			if (phba->cgn_p.cgn_param_mode != LPFC_CFG_OFF) {
 				/* Turning CMF on */
+				lpfc_cmf_start(phba);
 
 				if (phba->link_state >= LPFC_LINK_UP) {
 					phba->cgn_reg_fpin =
@@ -6214,6 +6514,7 @@ lpfc_cgn_params_parse(struct lpfc_hba *phba,
 			switch (phba->cgn_p.cgn_param_mode) {
 			case LPFC_CFG_OFF:
 				/* Turning CMF off */
+				lpfc_cmf_stop(phba);
 				if (phba->link_state >= LPFC_LINK_UP)
 					lpfc_issue_els_edc(phba->pport, 0);
 				break;
@@ -6221,6 +6522,12 @@ lpfc_cgn_params_parse(struct lpfc_hba *phba,
 				lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
 						"4661 Switch from MANAGED to "
 						"`MONITOR mode\n");
+				phba->cmf_max_bytes_per_interval =
+					phba->cmf_link_byte_count;
+
+				/* Resume blocked IO - unblock on workqueue */
+				queue_work(phba->wq,
+					   &phba->unblock_request_work);
 				break;
 			}
 			break;
@@ -6228,6 +6535,7 @@ lpfc_cgn_params_parse(struct lpfc_hba *phba,
 			switch (phba->cgn_p.cgn_param_mode) {
 			case LPFC_CFG_OFF:
 				/* Turning CMF off */
+				lpfc_cmf_stop(phba);
 				if (phba->link_state >= LPFC_LINK_UP)
 					lpfc_issue_els_edc(phba->pport, 0);
 				break;
@@ -6235,6 +6543,7 @@ lpfc_cgn_params_parse(struct lpfc_hba *phba,
 				lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
 						"4662 Switch from MONITOR to "
 						"MANAGED mode\n");
+				lpfc_cmf_signal_init(phba);
 				break;
 			}
 			break;
@@ -6301,6 +6610,51 @@ lpfc_sli4_cgn_params_read(struct lpfc_hba *phba)
 	return ret;
 }
 
+/**
+ * lpfc_sli4_cgn_parm_chg_evt - Process a FW congestion param change event
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * The FW generated Async ACQE SLI event calls this routine when
+ * the event type is an SLI Internal Port Event and the Event Code
+ * indicates a change to the FW maintained congestion parameters.
+ *
+ * This routine executes a Read_Object mailbox call to obtain the
+ * current congestion parameters maintained in FW and corrects
+ * the driver's active congestion parameters.
+ *
+ * The acqe event is not passed because there is no further data
+ * required.
+ *
+ * Returns nonzero error if event processing encountered an error.
+ * Zero otherwise for success.
+ **/
+static int
+lpfc_sli4_cgn_parm_chg_evt(struct lpfc_hba *phba)
+{
+	int ret = 0;
+
+	if (!phba->sli4_hba.pc_sli4_params.cmf) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_CGN_MGMT | LOG_INIT,
+				"4664 Cgn Evt when E2E off. Drop event\n");
+		return -EACCES;
+	}
+
+	/* If the event is claiming an empty object, it's ok.  A write
+	 * could have cleared it.  Only error is a negative return
+	 * status.
+	 */
+	ret = lpfc_sli4_cgn_params_read(phba);
+	if (ret < 0) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_CGN_MGMT | LOG_INIT,
+				"4667 Error reading Cgn Params (%d)\n",
+				ret);
+	} else if (!ret) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_CGN_MGMT | LOG_INIT,
+				"4673 CGN Event empty object.\n");
+	}
+	return ret;
+}
+
 /**
  * lpfc_sli4_async_event_proc - Process all the pending asynchronous event
  * @phba: pointer to lpfc hba data structure.
@@ -6349,6 +6703,9 @@ void lpfc_sli4_async_event_proc(struct lpfc_hba *phba)
 		case LPFC_TRAILER_CODE_SLI:
 			lpfc_sli4_async_sli_evt(phba, &cq_event->cqe.acqe_sli);
 			break;
+		case LPFC_TRAILER_CODE_CMSTAT:
+			lpfc_sli4_async_cmstat_evt(phba);
+			break;
 		default:
 			lpfc_printf_log(phba, KERN_ERR,
 					LOG_TRACE_EVENT,
@@ -6633,6 +6990,15 @@ lpfc_sli_probe_sriov_nr_virtfn(struct lpfc_hba *phba, int nr_vfn)
 	return rc;
 }
 
+static void
+lpfc_unblock_requests_work(struct work_struct *work)
+{
+	struct lpfc_hba *phba = container_of(work, struct lpfc_hba,
+					     unblock_request_work);
+
+	lpfc_unblock_requests(phba);
+}
+
 /**
  * lpfc_setup_driver_resource_phase1 - Phase1 etup driver internal resources.
  * @phba: pointer to lpfc hba data structure.
@@ -6708,7 +7074,7 @@ lpfc_setup_driver_resource_phase1(struct lpfc_hba *phba)
 
 	INIT_DELAYED_WORK(&phba->idle_stat_delay_work,
 			  lpfc_idle_stat_delay_work);
-
+	INIT_WORK(&phba->unblock_request_work, lpfc_unblock_requests_work);
 	return 0;
 }
 
@@ -6939,6 +7305,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	/* FCF rediscover timer */
 	timer_setup(&phba->fcf.redisc_wait, lpfc_sli4_fcf_redisc_wait_tmo, 0);
 
+	/* CMF congestion timer */
+	hrtimer_init(&phba->cmf_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	phba->cmf_timer.function = lpfc_cmf_timer;
+
 	/*
 	 * Control structure for handling external multi-buffer mailbox
 	 * command pass-through.
@@ -7387,6 +7757,14 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	}
 #endif
 
+	phba->cmf_stat = alloc_percpu(struct lpfc_cgn_stat);
+	if (!phba->cmf_stat) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
+				"3331 Failed allocating per cpu cgn stats\n");
+		rc = -ENOMEM;
+		goto out_free_hba_hdwq_info;
+	}
+
 	/*
 	 * Enable sr-iov virtual functions if supported and configured
 	 * through the module parameter.
@@ -7406,6 +7784,8 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 
 	return 0;
 
+out_free_hba_hdwq_info:
+	free_percpu(phba->sli4_hba.c_stat);
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 out_free_hba_idle_stat:
 	kfree(phba->sli4_hba.idle_stat);
@@ -7453,6 +7833,7 @@ lpfc_sli4_driver_resource_unset(struct lpfc_hba *phba)
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	free_percpu(phba->sli4_hba.c_stat);
 #endif
+	free_percpu(phba->cmf_stat);
 	kfree(phba->sli4_hba.idle_stat);
 
 	/* Free memory allocated for msi-x interrupt vector to CPU mapping */
@@ -12352,6 +12733,8 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
 	struct pci_dev *pdev = phba->pcidev;
 
 	lpfc_stop_hba_timers(phba);
+	hrtimer_cancel(&phba->cmf_timer);
+
 	if (phba->pport)
 		phba->sli4_hba.intr_enable = 0;
 
@@ -12422,7 +12805,6 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
 		phba->pport->work_port_events = 0;
 }
 
-
 void
 lpfc_init_congestion_buf(struct lpfc_hba *phba)
 {
@@ -12519,9 +12901,10 @@ __lpfc_reg_congestion_buf(struct lpfc_hba *phba, int reg)
 	return 0;
 }
 
-static int
+int
 lpfc_unreg_congestion_buf(struct lpfc_hba *phba)
 {
+	lpfc_cmf_stop(phba);
 	return __lpfc_reg_congestion_buf(phba, 0);
 }
 
@@ -13763,6 +14146,8 @@ lpfc_pci_remove_one_s4(struct pci_dev *pdev)
 	spin_lock_irq(&phba->hbalock);
 	vport->load_flag |= FC_UNLOADING;
 	spin_unlock_irq(&phba->hbalock);
+	if (phba->cgn_i)
+		lpfc_unreg_congestion_buf(phba);
 
 	lpfc_free_sysfs_attr(vport);
 
diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index be54fbf5146f..bbb181ab334b 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -335,6 +335,15 @@ lpfc_mem_free_all(struct lpfc_hba *phba)
 	dma_pool_destroy(phba->lpfc_cmd_rsp_buf_pool);
 	phba->lpfc_cmd_rsp_buf_pool = NULL;
 
+	/* Free Congestion Data buffer */
+	if (phba->cgn_i) {
+		dma_free_coherent(&phba->pcidev->dev,
+				  sizeof(struct lpfc_cgn_info),
+				  phba->cgn_i->virt, phba->cgn_i->phys);
+		kfree(phba->cgn_i);
+		phba->cgn_i = NULL;
+	}
+
 	/* Free the iocb lookup array */
 	kfree(psli->iocbq_lookup);
 	psli->iocbq_lookup = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index f36294e9b5dd..73a3568ff17e 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -931,6 +931,8 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	uint32_t code, status, idx;
 	uint16_t cid, sqhd, data;
 	uint32_t *ptr;
+	uint32_t lat;
+	bool call_done = false;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	int cpu;
 #endif
@@ -1135,10 +1137,21 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 		freqpriv = nCmd->private;
 		freqpriv->nvme_buf = NULL;
 		lpfc_ncmd->nvmeCmd = NULL;
-		spin_unlock(&lpfc_ncmd->buf_lock);
+		call_done = true;
+	}
+	spin_unlock(&lpfc_ncmd->buf_lock);
+
+	/* Check if IO qualified for CMF */
+	if (phba->cmf_active_mode != LPFC_CFG_OFF &&
+	    nCmd->io_dir == NVMEFC_FCP_READ &&
+	    nCmd->payload_length) {
+		/* Used when calculating average latency */
+		lat = ktime_get_ns() - lpfc_ncmd->rx_cmd_start;
+		lpfc_update_cmf_cmpl(phba, lat, nCmd->payload_length, NULL);
+	}
+
+	if (call_done)
 		nCmd->done(nCmd);
-	} else
-		spin_unlock(&lpfc_ncmd->buf_lock);
 
 	/* Call release with XB=1 to queue the IO into the abort list. */
 	lpfc_release_nvme_buf(phba, lpfc_ncmd);
@@ -1212,6 +1225,10 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 			/* Word 5 */
 			wqe->fcp_iread.rsrvd5 = 0;
 
+			/* For a CMF Managed port, iod must be zero'ed */
+			if (phba->cmf_active_mode == LPFC_CFG_MANAGED)
+				bf_set(wqe_iod, &wqe->fcp_iread.wqe_com,
+				       LPFC_WQE_IOD_NONE);
 			cstat->input_requests++;
 		}
 	} else {
@@ -1562,6 +1579,19 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 			expedite = 1;
 	}
 
+	/* Check if IO qualifies for CMF */
+	if (phba->cmf_active_mode != LPFC_CFG_OFF &&
+	    pnvme_fcreq->io_dir == NVMEFC_FCP_READ &&
+	    pnvme_fcreq->payload_length) {
+		ret = lpfc_update_cmf_cmd(phba, pnvme_fcreq->payload_length);
+		if (ret) {
+			ret = -EBUSY;
+			goto out_fail;
+		}
+		/* Get start time for IO latency */
+		start = ktime_get_ns();
+	}
+
 	/* The node is shared with FCP IO, make sure the IO pending count does
 	 * not exceed the programmed depth.
 	 */
@@ -1576,7 +1606,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 					 ndlp->cmd_qdepth);
 			atomic_inc(&lport->xmt_fcp_qdepth);
 			ret = -EBUSY;
-			goto out_fail;
+			goto out_fail1;
 		}
 	}
 
@@ -1596,7 +1626,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 				 "idx %d DID %x\n",
 				 lpfc_queue_info->index, ndlp->nlp_DID);
 		ret = -EBUSY;
-		goto out_fail;
+		goto out_fail1;
 	}
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (start) {
@@ -1606,6 +1636,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 		lpfc_ncmd->ts_cmd_start = 0;
 	}
 #endif
+	lpfc_ncmd->rx_cmd_start = start;
 
 	/*
 	 * Store the data needed by the driver to issue, abort, and complete
@@ -1687,6 +1718,9 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	} else
 		cstat->control_requests--;
 	lpfc_release_nvme_buf(phba, lpfc_ncmd);
+ out_fail1:
+	lpfc_update_cmf_cmpl(phba, LPFC_CGN_NOT_SENT,
+			     pnvme_fcreq->payload_length, NULL);
  out_fail:
 	return ret;
 }
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index ee4ff4855866..11f26582e68c 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -3853,6 +3853,141 @@ lpfc_scsi_unprep_dma_buf(struct lpfc_hba *phba, struct lpfc_io_buf *psb)
 				psb->pCmd->sc_data_direction);
 }
 
+/**
+ * lpfc_unblock_requests - allow further commands to be queued.
+ * @phba: pointer to phba object
+ *
+ * For single vport, just call scsi_unblock_requests on physical port.
+ * For multiple vports, send scsi_unblock_requests for all the vports.
+ */
+void
+lpfc_unblock_requests(struct lpfc_hba *phba)
+{
+	struct lpfc_vport **vports;
+	struct Scsi_Host  *shost;
+	int i;
+
+	if (phba->sli_rev == LPFC_SLI_REV4 &&
+	    !phba->sli4_hba.max_cfg_param.vpi_used) {
+		shost = lpfc_shost_from_vport(phba->pport);
+		scsi_unblock_requests(shost);
+		return;
+	}
+
+	vports = lpfc_create_vport_work_array(phba);
+	if (vports != NULL)
+		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
+			shost = lpfc_shost_from_vport(vports[i]);
+			scsi_unblock_requests(shost);
+		}
+	lpfc_destroy_vport_work_array(phba, vports);
+}
+
+/**
+ * lpfc_block_requests - prevent further commands from being queued.
+ * @phba: pointer to phba object
+ *
+ * For single vport, just call scsi_block_requests on physical port.
+ * For multiple vports, send scsi_block_requests for all the vports.
+ */
+void
+lpfc_block_requests(struct lpfc_hba *phba)
+{
+	struct lpfc_vport **vports;
+	struct Scsi_Host  *shost;
+	int i;
+
+	if (atomic_read(&phba->cmf_stop_io))
+		return;
+
+	if (phba->sli_rev == LPFC_SLI_REV4 &&
+	    !phba->sli4_hba.max_cfg_param.vpi_used) {
+		shost = lpfc_shost_from_vport(phba->pport);
+		scsi_block_requests(shost);
+		return;
+	}
+
+	vports = lpfc_create_vport_work_array(phba);
+	if (vports != NULL)
+		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
+			shost = lpfc_shost_from_vport(vports[i]);
+			scsi_block_requests(shost);
+		}
+	lpfc_destroy_vport_work_array(phba, vports);
+}
+
+/**
+ * lpfc_update_cmf_cmpl - Adjust CMF counters for IO completion
+ * @phba: The HBA for which this call is being executed.
+ * @time: The latency of the IO that completed (in ns)
+ * @size: The size of the IO that completed
+ * @shost: SCSI host the IO completed on (NULL for a NVME IO)
+ *
+ * The routine adjusts the various Burst and Bandwidth counters used in
+ * Congestion management and E2E. If time is set to LPFC_CGN_NOT_SENT,
+ * that means the IO was never issued to the HBA, so this routine is
+ * just being called to cleanup the counter from a previous
+ * lpfc_update_cmf_cmd call.
+ */
+int
+lpfc_update_cmf_cmpl(struct lpfc_hba *phba,
+		     uint64_t time, uint32_t size, struct Scsi_Host *shost)
+{
+	struct lpfc_cgn_stat *cgs;
+
+	if (time != LPFC_CGN_NOT_SENT) {
+		/* lat is ns coming in, save latency in us */
+		if (time < 1000)
+			time = 1;
+		else
+			time = (time + 500) / 1000; /* round it */
+
+		cgs = this_cpu_ptr(phba->cmf_stat);
+		atomic64_add(size, &cgs->rcv_bytes);
+		atomic64_add(time, &cgs->rx_latency);
+		atomic_inc(&cgs->rx_io_cnt);
+	}
+	return 0;
+}
+
+/**
+ * lpfc_update_cmf_cmd - Adjust CMF counters for IO submission
+ * @phba: The HBA for which this call is being executed.
+ * @size: The size of the IO that will be issued
+ *
+ * The routine adjusts the various Burst and Bandwidth counters used in
+ * Congestion management and E2E.
+ */
+int
+lpfc_update_cmf_cmd(struct lpfc_hba *phba, uint32_t size)
+{
+	uint64_t total;
+	struct lpfc_cgn_stat *cgs;
+	int cpu;
+
+	/* At this point we are either LPFC_CFG_MANAGED or LPFC_CFG_MONITOR */
+	if (phba->cmf_active_mode == LPFC_CFG_MANAGED) {
+		total = 0;
+		for_each_present_cpu(cpu) {
+			cgs = per_cpu_ptr(phba->cmf_stat, cpu);
+			total += atomic64_read(&cgs->total_bytes);
+		}
+		if (total >= phba->cmf_max_bytes_per_interval) {
+			if (!atomic_xchg(&phba->cmf_bw_wait, 1)) {
+				lpfc_block_requests(phba);
+				phba->cmf_last_ts =
+					lpfc_calc_cmf_latency(phba);
+			}
+			atomic_inc(&phba->cmf_busy);
+			return -EBUSY;
+		}
+	}
+
+	cgs = this_cpu_ptr(phba->cmf_stat);
+	atomic64_add(size, &cgs->total_bytes);
+	return 0;
+}
+
 /**
  * lpfc_handle_fcp_err - FCP response handler
  * @vport: The virtual port for which this call is being executed.
@@ -4063,6 +4198,7 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	u32 logit = LOG_FCP;
 	u32 status, idx;
 	unsigned long iflags = 0;
+	u32 lat;
 	u8 wait_xb_clr = 0;
 
 	/* Sanity check on return of outstanding command */
@@ -4351,10 +4487,21 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 		lpfc_io_ktime(phba, lpfc_cmd);
 	}
 #endif
+	if (likely(!wait_xb_clr))
+		lpfc_cmd->pCmd = NULL;
+	spin_unlock(&lpfc_cmd->buf_lock);
+
+	/* Check if IO qualified for CMF */
+	if (phba->cmf_active_mode != LPFC_CFG_OFF &&
+	    cmd->sc_data_direction == DMA_FROM_DEVICE &&
+	    (scsi_sg_count(cmd))) {
+		/* Used when calculating average latency */
+		lat = ktime_get_ns() - lpfc_cmd->rx_cmd_start;
+		lpfc_update_cmf_cmpl(phba, lat, scsi_bufflen(cmd), shost);
+	}
+
 	if (wait_xb_clr)
 		goto out;
-	lpfc_cmd->pCmd = NULL;
-	spin_unlock(&lpfc_cmd->buf_lock);
 
 	/* The sdev is not guaranteed to be valid post scsi_done upcall. */
 	cmd->scsi_done(cmd);
@@ -4367,8 +4514,8 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	lpfc_cmd->cur_iocbq.iocb_flag &= ~LPFC_DRIVER_ABORTED;
 	if (lpfc_cmd->waitq)
 		wake_up(lpfc_cmd->waitq);
-out:
 	spin_unlock(&lpfc_cmd->buf_lock);
+out:
 	lpfc_release_scsi_buf(phba, lpfc_cmd);
 }
 
@@ -4775,6 +4922,11 @@ static int lpfc_scsi_prep_cmnd_buf_s4(struct lpfc_vport *vport,
 			fcp_cmnd->fcpCntl3 = READ_DATA;
 			if (hdwq)
 				hdwq->scsi_cstat.input_requests++;
+
+			/* For a CMF Managed port, iod must be zero'ed */
+			if (phba->cmf_active_mode == LPFC_CFG_MANAGED)
+				bf_set(wqe_iod, &wqe->fcp_iread.wqe_com,
+				       LPFC_WQE_IOD_NONE);
 		}
 	} else {
 		/* From the icmnd template, initialize words 4 - 11 */
@@ -5458,7 +5610,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	if (phba->ktime_on)
 		start = ktime_get_ns();
 #endif
-
+	start = ktime_get_ns();
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 
 	/* sanity check on references */
@@ -5489,7 +5641,18 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	 * transport is still transitioning.
 	 */
 	if (!ndlp)
-		goto out_tgt_busy;
+		goto out_tgt_busy1;
+
+	/* Check if IO qualifies for CMF */
+	if (phba->cmf_active_mode != LPFC_CFG_OFF &&
+	    cmnd->sc_data_direction == DMA_FROM_DEVICE &&
+	    (scsi_sg_count(cmnd))) {
+		/* Latency start time saved in rx_cmd_start later in routine */
+		err = lpfc_update_cmf_cmd(phba, scsi_bufflen(cmnd));
+		if (err)
+			goto out_tgt_busy1;
+	}
+
 	if (lpfc_ndlp_check_qdepth(phba, ndlp)) {
 		if (atomic_read(&ndlp->cmd_pending) >= ndlp->cmd_qdepth) {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP_ERROR,
@@ -5517,7 +5680,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 					 ndlp->nlp_portname.u.wwn[5],
 					 ndlp->nlp_portname.u.wwn[6],
 					 ndlp->nlp_portname.u.wwn[7]);
-			goto out_tgt_busy;
+			goto out_tgt_busy2;
 		}
 	}
 
@@ -5530,6 +5693,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 				 "IO busied\n");
 		goto out_host_busy;
 	}
+	lpfc_cmd->rx_cmd_start = start;
 
 	/*
 	 * Store the midlayer's command structure for the completion phase
@@ -5674,13 +5838,20 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
  out_host_busy_release_buf:
 	lpfc_release_scsi_buf(phba, lpfc_cmd);
  out_host_busy:
+	lpfc_update_cmf_cmpl(phba, LPFC_CGN_NOT_SENT, scsi_bufflen(cmnd),
+			     shost);
 	return SCSI_MLQUEUE_HOST_BUSY;
 
- out_tgt_busy:
+ out_tgt_busy2:
+	lpfc_update_cmf_cmpl(phba, LPFC_CGN_NOT_SENT, scsi_bufflen(cmnd),
+			     shost);
+ out_tgt_busy1:
 	return SCSI_MLQUEUE_TARGET_BUSY;
 
  out_fail_command_release_buf:
 	lpfc_release_scsi_buf(phba, lpfc_cmd);
+	lpfc_update_cmf_cmpl(phba, LPFC_CGN_NOT_SENT, scsi_bufflen(cmnd),
+			     shost);
 
  out_fail_command:
 	cmnd->scsi_done(cmnd);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 4d1c190823d1..6d256a509ea3 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1439,7 +1439,7 @@ __lpfc_sli_release_iocbq_s4(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 	memset((char *)iocbq + start_clean, 0, sizeof(*iocbq) - start_clean);
 	iocbq->sli4_lxritag = NO_XRI;
 	iocbq->sli4_xritag = NO_XRI;
-	iocbq->iocb_flag &= ~(LPFC_IO_NVME | LPFC_IO_NVMET |
+	iocbq->iocb_flag &= ~(LPFC_IO_NVME | LPFC_IO_NVMET | LPFC_IO_CMF |
 			      LPFC_IO_NVME_LS);
 	list_add_tail(&iocbq->list, &phba->lpfc_iocb_list);
 }
@@ -1785,9 +1785,11 @@ lpfc_cmf_sync_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 {
 	union lpfc_wqe128 *wqe;
 	uint32_t status, info;
-	uint64_t bw;
+	uint64_t bw, bwdif, slop;
+	uint64_t pcent, bwpcent;
 	int asig, afpin, sigcnt, fpincnt;
-	int cg, tdp;
+	int wsigmax, wfpinmax, cg, tdp;
+	char *s;
 
 	/* First check for error */
 	status = bf_get(lpfc_wcqe_c_status, cmf_cmpl);
@@ -1806,6 +1808,14 @@ lpfc_cmf_sync_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Gather congestion information on a successful cmpl */
 	info = cmf_cmpl->parameter;
+	phba->cmf_active_info = info;
+
+	/* See if firmware info count is valid or has changed */
+	if (info > LPFC_MAX_CMF_INFO || phba->cmf_info_per_interval == info)
+		info = 0;
+	else
+		phba->cmf_info_per_interval = info;
+
 	tdp = bf_get(lpfc_wcqe_c_cmf_bw, cmf_cmpl);
 	cg = bf_get(lpfc_wcqe_c_cmf_cg, cmf_cmpl);
 
@@ -1824,7 +1834,65 @@ lpfc_cmf_sync_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	afpin = bf_get(cmf_sync_afpin, &wqe->cmf_sync);
 	fpincnt = bf_get(cmf_sync_wfpincnt, &wqe->cmf_sync);
 	sigcnt = bf_get(cmf_sync_wsigcnt, &wqe->cmf_sync);
+	if (phba->cmf_max_bytes_per_interval != bw ||
+	    (asig || afpin || sigcnt || fpincnt)) {
+		/* Are we increasing or decreasing BW */
+		if (phba->cmf_max_bytes_per_interval <  bw) {
+			bwdif = bw - phba->cmf_max_bytes_per_interval;
+			s = "Increase";
+		} else {
+			bwdif = phba->cmf_max_bytes_per_interval - bw;
+			s = "Decrease";
+		}
+
+		/* What is the change percentage */
+		slop = (phba->cmf_link_byte_count / 200);  /* For rounding */
+		pcent = ((bwdif * 100) + slop) / phba->cmf_link_byte_count;
+		bwpcent = ((bw * 100) + slop) / phba->cmf_link_byte_count;
+		if (asig) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+					"6237 BW Threshold %lld%% (%lld): "
+					"%lld%% %s: Signal Alarm: cg:%d "
+					"Info:%u\n",
+					bwpcent, bw, pcent, s, cg,
+					phba->cmf_active_info);
+		} else if (afpin) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+					"6238 BW Threshold %lld%% (%lld): "
+					"%lld%% %s: FPIN Alarm: cg:%d "
+					"Info:%u\n",
+					bwpcent, bw, pcent, s, cg,
+					phba->cmf_active_info);
+		} else if (sigcnt) {
+			wsigmax = bf_get(cmf_sync_wsigmax, &wqe->cmf_sync);
+			lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+					"6239 BW Threshold %lld%% (%lld): "
+					"%lld%% %s: Signal Warning: "
+					"Cnt %d Max %d: cg:%d Info:%u\n",
+					bwpcent, bw, pcent, s, sigcnt,
+					wsigmax, cg, phba->cmf_active_info);
+		} else if (fpincnt) {
+			wfpinmax = bf_get(cmf_sync_wfpinmax, &wqe->cmf_sync);
+			lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+					"6240 BW Threshold %lld%% (%lld): "
+					"%lld%% %s: FPIN Warning: "
+					"Cnt %d Max %d: cg:%d Info:%u\n",
+					bwpcent, bw, pcent, s, fpincnt,
+					wfpinmax, cg, phba->cmf_active_info);
+		} else {
+			lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+					"6241 BW Threshold %lld%% (%lld): "
+					"CMF %lld%% %s: cg:%d Info:%u\n",
+					bwpcent, bw, pcent, s, cg,
+					phba->cmf_active_info);
+		}
+	} else if (info) {
+		lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+				"6246 Info Threshold %u\n", info);
+	}
 
+	/* Save BW change to be picked up during next timer interrupt */
+	phba->cmf_last_sync_bw = bw;
 out:
 	lpfc_sli_release_iocbq(phba, cmdiocb);
 }
@@ -4645,6 +4713,7 @@ lpfc_sli_brdready_s4(struct lpfc_hba *phba, uint32_t mask)
 	} else
 		phba->sli4_hba.intr_enable = 0;
 
+	phba->hba_flag &= ~HBA_SETUP;
 	return retval;
 }
 
@@ -4965,6 +5034,7 @@ lpfc_sli4_brdreset(struct lpfc_hba *phba)
 	phba->link_events = 0;
 	phba->pport->fc_myDID = 0;
 	phba->pport->fc_prevDID = 0;
+	phba->hba_flag &= ~HBA_SETUP;
 
 	spin_lock_irq(&phba->hbalock);
 	psli->sli_flag &= ~(LPFC_PROCESS_LA);
@@ -6663,8 +6733,14 @@ lpfc_set_features(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox,
 		bf_set(lpfc_mbx_set_feature_mi, &mbox->u.mqe.un.set_feature,
 		       phba->sli4_hba.pc_sli4_params.mi_ver);
 		break;
+	case LPFC_SET_ENABLE_CMF:
+		bf_set(lpfc_mbx_set_feature_dd, &mbox->u.mqe.un.set_feature, 1);
+		mbox->u.mqe.un.set_feature.feature = LPFC_SET_ENABLE_CMF;
+		mbox->u.mqe.un.set_feature.param_len = 4;
+		bf_set(lpfc_mbx_set_feature_cmf,
+		       &mbox->u.mqe.un.set_feature, 1);
+		break;
 	}
-
 	return;
 }
 
@@ -7813,10 +7889,11 @@ lpfc_cmf_setup(struct lpfc_hba *phba)
 {
 	LPFC_MBOXQ_t *mboxq;
 	struct lpfc_mqe *mqe;
+	struct lpfc_dmabuf *mp;
 	struct lpfc_pc_sli4_params *sli4_params;
 	struct lpfc_sli4_parameters *mbx_sli4_parameters;
 	int length;
-	int rc, mi_ver;
+	int rc, cmf, mi_ver;
 
 	mboxq = (LPFC_MBOXQ_t *)mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!mboxq)
@@ -7836,10 +7913,11 @@ lpfc_cmf_setup(struct lpfc_hba *phba)
 		return rc;
 	}
 
-	/* Gather info on MI support */
+	/* Gather info on CMF and MI support */
 	sli4_params = &phba->sli4_hba.pc_sli4_params;
 	mbx_sli4_parameters = &mqe->un.get_sli4_parameters.sli4_parameters;
 	sli4_params->mi_ver = bf_get(cfg_mi_ver, mbx_sli4_parameters);
+	sli4_params->cmf = bf_get(cfg_cmf, mbx_sli4_parameters);
 
 	/* Are we forcing MI off via module parameter? */
 	if (!phba->cfg_enable_mi)
@@ -7886,9 +7964,95 @@ lpfc_cmf_setup(struct lpfc_hba *phba)
 	if (sli4_params->mi_ver)
 		phba->cfg_fdmi_on = LPFC_FDMI_SUPPORT;
 
+	/* Always try to enable CMF feature if we can */
+	if (sli4_params->cmf) {
+		lpfc_set_features(phba, mboxq, LPFC_SET_ENABLE_CMF);
+		rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
+		cmf = bf_get(lpfc_mbx_set_feature_cmf,
+			     &mboxq->u.mqe.un.set_feature);
+		if (rc == MBX_SUCCESS && cmf) {
+			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+					"6218 CMF is enabled: mode %d\n",
+					phba->cmf_active_mode);
+		} else {
+			lpfc_printf_log(phba, KERN_WARNING,
+					LOG_CGN_MGMT | LOG_INIT,
+					"6219 Enable CMF Mailbox x%x (x%x/x%x) "
+					"failed, rc:x%x dd:x%x\n",
+					bf_get(lpfc_mqe_command, &mboxq->u.mqe),
+					lpfc_sli_config_mbox_subsys_get
+						(phba, mboxq),
+					lpfc_sli_config_mbox_opcode_get
+						(phba, mboxq),
+					rc, cmf);
+			sli4_params->cmf = 0;
+			phba->cmf_active_mode = LPFC_CFG_OFF;
+			goto no_cmf;
+		}
+
+		/* Allocate Congestion Information Buffer */
+		if (!phba->cgn_i) {
+			mp = kmalloc(sizeof(*mp), GFP_KERNEL);
+			if (mp)
+				mp->virt = dma_alloc_coherent
+						(&phba->pcidev->dev,
+						sizeof(struct lpfc_cgn_info),
+						&mp->phys, GFP_KERNEL);
+			if (!mp || !mp->virt) {
+				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+						"2640 Failed to alloc memory "
+						"for Congestion Info\n");
+				kfree(mp);
+				sli4_params->cmf = 0;
+				phba->cmf_active_mode = LPFC_CFG_OFF;
+				goto no_cmf;
+			}
+			phba->cgn_i = mp;
+
+			/* initialize congestion buffer info */
+			lpfc_init_congestion_buf(phba);
+			lpfc_init_congestion_stat(phba);
+		}
+
+		rc = lpfc_sli4_cgn_params_read(phba);
+		if (rc < 0) {
+			lpfc_printf_log(phba, KERN_ERR, LOG_CGN_MGMT | LOG_INIT,
+					"6242 Error reading Cgn Params (%d)\n",
+					rc);
+			/* Ensure CGN Mode is off */
+			sli4_params->cmf = 0;
+		} else if (!rc) {
+			lpfc_printf_log(phba, KERN_ERR, LOG_CGN_MGMT | LOG_INIT,
+					"6243 CGN Event empty object.\n");
+			/* Ensure CGN Mode is off */
+			sli4_params->cmf = 0;
+		}
+	} else {
+no_cmf:
+		lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+				"6220 CMF is disabled\n");
+	}
+
+	/* Only register congestion buffer with firmware if BOTH
+	 * CMF and E2E are enabled.
+	 */
+	if (sli4_params->cmf && sli4_params->mi_ver) {
+		rc = lpfc_reg_congestion_buf(phba);
+		if (rc) {
+			dma_free_coherent(&phba->pcidev->dev,
+					  sizeof(struct lpfc_cgn_info),
+					  phba->cgn_i->virt, phba->cgn_i->phys);
+			kfree(phba->cgn_i);
+			phba->cgn_i = NULL;
+			/* Ensure CGN Mode is off */
+			phba->cmf_active_mode = LPFC_CFG_OFF;
+			return 0;
+		}
+	}
 	lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-			"6470 Setup MI version %d\n",
-			sli4_params->mi_ver);
+			"6470 Setup MI version %d CMF %d mode %d\n",
+			sli4_params->mi_ver, sli4_params->cmf,
+			phba->cmf_active_mode);
 
 	mempool_free(mboxq, phba->mbox_mem_pool);
 
@@ -7901,6 +8065,7 @@ lpfc_cmf_setup(struct lpfc_hba *phba)
 	atomic_set(&phba->cgn_latency_evt_cnt, 0);
 	atomic64_set(&phba->cgn_latency_evt, 0);
 
+	phba->cmf_interval_rate = LPFC_CMF_INTERVAL;
 	return 0;
 }
 
@@ -8042,8 +8207,6 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_INIT,
 			"6468 Set host date / time: Status x%x:\n", rc);
 
-	lpfc_cmf_setup(phba);
-
 	/*
 	 * Continue initialization with default values even if driver failed
 	 * to read FCoE param config regions, only read parameters if the
@@ -8571,6 +8734,9 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Indicate device interrupt mode */
 	phba->sli4_hba.intr_enable = 1;
 
+	/* Setup CMF after HBA is initialized */
+	lpfc_cmf_setup(phba);
+
 	if (!(phba->hba_flag & HBA_FCOE_MODE) &&
 	    (phba->hba_flag & LINK_DISABLED)) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
@@ -8592,7 +8758,10 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		}
 	}
 	mempool_free(mboxq, phba->mbox_mem_pool);
+
+	phba->hba_flag |= HBA_SETUP;
 	return rc;
+
 out_io_buff_free:
 	/* Free allocated IO Buffers */
 	lpfc_io_free(phba);
@@ -21104,8 +21273,7 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 	}
 
 	/* NVME_FCREQ and NVME_ABTS requests */
-	if (pwqe->iocb_flag & LPFC_IO_NVME ||
-	    pwqe->iocb_flag & LPFC_IO_FCP) {
+	if (pwqe->iocb_flag & (LPFC_IO_NVME | LPFC_IO_FCP | LPFC_IO_CMF)) {
 		/* Get the IO distribution (hba_wqidx) for WQ assignment. */
 		wq = qp->io_wq;
 		pring = wq->pring;
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index dc7cc2f37089..5161ccacea3e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -463,4 +463,5 @@ struct lpfc_io_buf {
 	uint64_t ts_isr_cmpl;
 	uint64_t ts_data_io;
 #endif
+	uint64_t rx_cmd_start;
 };
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index f250b666ac57..99c5d1e4da5e 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -557,6 +557,7 @@ struct lpfc_pc_sli4_params {
 	uint16_t mi_value;
 #define LPFC_DFLT_MIB_VAL	2
 	uint8_t mib_bde_cnt;
+	uint8_t cmf;
 	uint8_t cqv;
 	uint8_t mqv;
 	uint8_t wqv;
-- 
2.26.2

