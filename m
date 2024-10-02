Return-Path: <linux-scsi+bounces-8617-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAC98E281
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Oct 2024 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF0F1F2564D
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Oct 2024 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C5215F70;
	Wed,  2 Oct 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="QhdCaw2f"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91777215F4F;
	Wed,  2 Oct 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893833; cv=none; b=KEVETUj4Ln8hIuTRcVHU5lgoaSnrsUCavBiZFUmbrzlcUA/32VtsjXgU2lVEMY9k6xz1JiwiedLtvZ9SLG/GuBcYppc+SMkLBmzAytkbKBGFhcwbuRwyzYHaXT1t76nNlpnUyLxhUaaI9rcYZh3x8mQQSdoerrBA/4vYNQnRCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893833; c=relaxed/simple;
	bh=za9mRmFtYCpfipWUQjIdQzNGqacgx0dGYVHRBgxlRXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhs1rMQgTC6hLj0dTCjk32tl0U/iuHgt6DQd9lQx5o2Yvob3nR4oImfPE0UNy2eOpOuvNDc/5MBWz3Y2XG9psUGo6j6kSn605y21LR+pHV2M4Y+AZuyepRlw8vBVrdGPxuTTnMgMEtbgP7TRocVfJQIwHRnMGor5KG/pBIdyWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=QhdCaw2f; arc=none smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=24030; q=dns/txt;
  s=iport; t=1727893830; x=1729103430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2q0knVkS+8YksJ9pnBBhgmxX5pYW7sN01BzHPBM3BPc=;
  b=QhdCaw2fSm4nYQYcu8NxBUZeJPzlqq7vwC+U+3kSYqONRglvaS5DpLM7
   k4Aoe1wFIhsd0uOGYlVavHjHqCEV/VXRkr38YcQce4JHKnSlKtjtRi66s
   gcQOL/uYjq+6LLhV8LK1C0DsTvmNdrTedhskjumHQmIrJy4hEhhxC2Ncj
   o=;
X-CSE-ConnectionGUID: 85q4HT7FQsKgVNL75F+uhw==
X-CSE-MsgGUID: SO7La2meQAqMVcS6Y6XzUA==
X-IronPort-AV: E=Sophos;i="6.11,172,1725321600"; 
   d="scan'208";a="269112447"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 18:30:29 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPSA id 492IOHQu009807
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 2 Oct 2024 18:30:28 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, aeasi@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v4 11/14] scsi: fnic: Add stats and related functionality
Date: Wed,  2 Oct 2024 11:24:07 -0700
Message-Id: <20241002182410.68093-12-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241002182410.68093-1-kartilak@cisco.com>
References: <20241002182410.68093-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-8.cisco.com

Add statistics and related functionality for FDLS.
Add supporting functions to display stats.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
----
Changes between v2 and v3:
    Replace fnic->host with fnic->lport->host to prevent compilation
    errors.
---
 drivers/scsi/fnic/fdls_disc.c  | 33 +++++++++++---
 drivers/scsi/fnic/fnic.h       |  2 +
 drivers/scsi/fnic/fnic_fdls.h  |  6 ++-
 drivers/scsi/fnic/fnic_main.c  | 37 +++++++++++++++-
 drivers/scsi/fnic/fnic_scsi.c  | 19 +++++++-
 drivers/scsi/fnic/fnic_stats.h | 46 ++++++++++++++++++-
 drivers/scsi/fnic/fnic_trace.c | 81 +++++++++++++++++++++++++++++-----
 7 files changed, 200 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 2623aa011cd6..0ff4ce683dcb 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -843,6 +843,7 @@ static void fdls_send_fabric_flogi(struct fnic_iport_s *iport)
 
 	fnic_send_fcoe_frame(iport, &flogi, sizeof(struct fc_std_flogi));
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	atomic64_inc(&iport->iport_stats.fabric_flogi_sent);
 	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
 }
 
@@ -877,6 +878,7 @@ static void fdls_send_fabric_plogi(struct fnic_iport_s *iport)
 		 "0x%x: FDLS send fabric PLOGI with oxid:%x", iport->fcid,
 		 oxid);
 
+	atomic64_inc(&iport->iport_stats.fabric_plogi_sent);
 	fnic_send_fcoe_frame(iport, &plogi, sizeof(struct fc_std_flogi));
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
 	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
@@ -979,7 +981,7 @@ static void fdls_send_scr(struct fnic_iport_s *iport)
 	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 		 "0x%x: FDLS send SCR with oxid:%x", iport->fcid, oxid);
 
-
+	atomic64_inc(&iport->iport_stats.fabric_scr_sent);
 	fnic_send_fcoe_frame(iport, &scr, sizeof(struct fc_std_scr));
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
 	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
@@ -1056,7 +1058,7 @@ fdls_send_tgt_adisc(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				 "sending ADISC to tgt fcid: 0x%x", tport->fcid);
 
-
+	atomic64_inc(&iport->iport_stats.tport_adisc_sent);
 	fnic_send_fcoe_frame(iport, &adisc, sizeof(struct fc_std_els_adisc));
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
 	fdls_start_tport_timer(iport, tport, 2 * iport->e_d_tov);
@@ -1162,7 +1164,7 @@ fdls_send_tgt_plogi(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	timeout = max(2 * iport->e_d_tov, iport->plogi_timeout);
 
-
+	atomic64_inc(&iport->iport_stats.tport_plogi_sent);
 	fnic_send_fcoe_frame(iport, &plogi, sizeof(struct fc_std_flogi));
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
 	fdls_start_tport_timer(iport, tport, timeout);
@@ -1297,7 +1299,7 @@ fdls_send_tgt_prli(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	timeout = max(2 * iport->e_d_tov, iport->plogi_timeout);
 
-
+	atomic64_inc(&iport->iport_stats.tport_prli_sent);
 	fnic_send_fcoe_frame(iport, &prli, sizeof(struct fc_std_els_prli));
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
 	fdls_start_tport_timer(iport, tport, timeout);
@@ -1391,7 +1393,7 @@ void fdls_tgt_logout(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 	FNIC_STD_SET_NPORT_NAME(&logo.els.fl_n_port_wwn,
 				le64_to_cpu(iport->wwpn));
 
-
+	atomic64_inc(&iport->iport_stats.tport_logo_sent);
 	fnic_send_fcoe_frame(iport, &logo, sizeof(struct fc_std_logo));
 }
 
@@ -2098,6 +2100,7 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 
 	switch (adisc_rsp->els.adisc_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.tport_adisc_ls_accepts);
 		if (tport->timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 						 "tport 0x%p Canceling fabric disc timer\n",
@@ -2120,6 +2123,7 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 		break;
 
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.tport_adisc_ls_rejects);
 		if (((els_rjt->u.rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->u.rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
@@ -2193,11 +2197,13 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 
 	switch (plogi_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.tport_plogi_ls_accepts);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PLOGI accepted by target: 0x%x", tgt_fcid);
 		break;
 
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.tport_plogi_ls_rejects);
 		if (((els_rjt->u.rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->u.rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < iport->max_plogi_retries)) {
@@ -2215,6 +2221,7 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 		return;
 
 	default:
+		atomic64_inc(&iport->iport_stats.tport_plogi_misc_rejects);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PLOGI not accepted from target fcid: 0x%x",
 					 tgt_fcid);
@@ -2319,6 +2326,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 
 	switch (prli_rsp->els_prli.prli_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.tport_prli_ls_accepts);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PRLI accepted from target: 0x%x", tgt_fcid);
 
@@ -2335,6 +2343,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 		}
 		break;
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.tport_prli_ls_rejects);
 		if (((els_rjt->u.rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->u.rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
@@ -2358,6 +2367,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 		break;
 
 	default:
+		atomic64_inc(&iport->iport_stats.tport_prli_misc_rejects);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PRLI not accepted from target: 0x%x", tgt_fcid);
 		return;
@@ -2636,6 +2646,7 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 
 	switch (scr_rsp->scr.scr_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.fabric_scr_ls_accepts);
 		if (iport->fabric.timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 						 "Canceling fabric disc timer %p\n", iport);
@@ -2647,6 +2658,7 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 		break;
 
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.fabric_scr_ls_rejects);
 		if (((els_rjt->u.rej.er_reason == ELS_RJT_BUSY)
 	     || (els_rjt->u.rej.er_reason == ELS_RJT_UNAB))
 			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
@@ -2671,6 +2683,7 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 		break;
 
 	default:
+		atomic64_inc(&iport->iport_stats.fabric_scr_misc_rejects);
 		break;
 	}
 }
@@ -2976,6 +2989,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 
 	switch (flogi_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.fabric_flogi_ls_accepts);
 		if (iport->fabric.timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 						 "iport fcid: 0x%x Canceling fabric disc timer\n",
@@ -3049,6 +3063,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 		break;
 
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.fabric_flogi_ls_rejects);
 		if (fabric->retry_counter < iport->max_flogi_retries) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				 "FLOGI returned ELS_LS_RJT BUSY. Retry from timer routine %p",
@@ -3076,6 +3091,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "FLOGI response not accepted: 0x%x",
 		     flogi_rsp->els.fl_cmd);
+		atomic64_inc(&iport->iport_stats.fabric_flogi_misc_rejects);
 		break;
 	}
 }
@@ -3100,6 +3116,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 
 	switch (plogi_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.fabric_plogi_ls_accepts);
 		if (iport->fabric.timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				 "iport fcid: 0x%x fabric PLOGI response: Accepted\n",
@@ -3112,6 +3129,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 		fdls_send_rpn_id(iport);
 		break;
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.fabric_plogi_ls_rejects);
 		if (((els_rjt->u.rej.er_reason == ELS_RJT_BUSY)
 	     || (els_rjt->u.rej.er_reason == ELS_RJT_UNAB))
 			&& (iport->fabric.retry_counter < iport->max_plogi_retries)) {
@@ -3137,6 +3155,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PLOGI response not accepted: 0x%x",
 		     plogi_rsp->els.fl_cmd);
+		atomic64_inc(&iport->iport_stats.fabric_plogi_misc_rejects);
 		break;
 	}
 }
@@ -3465,6 +3484,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			 "Dropping unsupported ELS with illegal frame bits 0x%x\n",
 			 d_id);
+		atomic64_inc(&iport->iport_stats.unsupported_frames_dropped);
 		return;
 	}
 
@@ -3473,6 +3493,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			 "Dropping unsupported ELS request in iport state: %d",
 			 iport->state);
+		atomic64_inc(&iport->iport_stats.unsupported_frames_dropped);
 		return;
 	}
 
@@ -3877,6 +3898,8 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 	struct fnic *fnic = iport->fnic;
 	uint16_t rscn_payload_len;
 
+	atomic64_inc(&iport->iport_stats.num_rscns);
+
 	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				 "FDLS process RSCN %p", iport);
 
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 58d864b59c89..33256d99023a 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -532,5 +532,7 @@ unsigned int fnic_count_lun_ioreqs(struct fnic *fnic,
 					   struct scsi_device *device);
 void fnic_scsi_unload(struct fnic *fnic);
 void fnic_scsi_unload_cleanup(struct fnic *fnic);
+int fnic_get_debug_info(struct stats_debug_info *info,
+					struct fnic *fnic);
 
 #endif /* _FNIC_H_ */
diff --git a/drivers/scsi/fnic/fnic_fdls.h b/drivers/scsi/fnic/fnic_fdls.h
index d2c3ebce3209..27366d320639 100644
--- a/drivers/scsi/fnic/fnic_fdls.h
+++ b/drivers/scsi/fnic/fnic_fdls.h
@@ -300,10 +300,12 @@ struct fnic_iport_s {
 	uint16_t max_payload_size;
 	spinlock_t deleted_tport_lst_lock;
 	struct completion *flogi_reg_done;
+	struct fnic_iport_stats iport_stats;
 	char str_wwpn[20];
 	char str_wwnn[20];
-	};
-	struct rport_dd_data_s {
+};
+
+struct rport_dd_data_s {
 	struct fnic_tport_s *tport;
 	struct fnic_iport_s *iport;
 };
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index e18bc9916e55..a1c7f666093b 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -162,7 +162,7 @@ static struct fc_function_template fnic_fc_functions = {
 	.show_rport_dev_loss_tmo = 1,
 	.set_rport_dev_loss_tmo = fnic_set_rport_dev_loss_tmo,
 	.issue_fc_host_lip = fnic_issue_fc_host_lip,
-	.get_fc_host_stats = NULL,
+	.get_fc_host_stats = fnic_get_stats,
 	.reset_fc_host_stats = fnic_reset_host_stats,
 	.dd_fcrport_size = sizeof(struct rport_dd_data_s),
 	.terminate_rport_io = fnic_terminate_rport_io,
@@ -173,9 +173,11 @@ static void fnic_get_host_speed(struct Scsi_Host *shost)
 {
 	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
 	u32 port_speed = vnic_dev_port_speed(fnic->vdev);
+	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 
 	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				  "port_speed: %d Mbps", port_speed);
+	atomic64_set(&fnic_stats->misc_stats.port_speed_in_mbps, port_speed);
 
 	/* Add in other values as they get defined in fw */
 	switch (port_speed) {
@@ -233,7 +235,38 @@ static void fnic_get_host_speed(struct Scsi_Host *shost)
 /* Placeholder function */
 static struct fc_host_statistics *fnic_get_stats(struct Scsi_Host *host)
 {
-	struct fc_host_statistics *stats;
+	int ret;
+	struct fnic *fnic = *((struct fnic **) shost_priv(host));
+	struct fc_host_statistics *stats = &fnic->fnic_stats.host_stats;
+	struct vnic_stats *vs;
+	unsigned long flags;
+
+	if (time_before
+		(jiffies, fnic->stats_time + HZ / FNIC_STATS_RATE_LIMIT))
+		return stats;
+	fnic->stats_time = jiffies;
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	ret = vnic_dev_stats_dump(fnic->vdev, &fnic->stats);
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+	if (ret) {
+		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+					  "fnic: Get vnic stats failed: 0x%x", ret);
+		return stats;
+	}
+	vs = fnic->stats;
+	stats->tx_frames = vs->tx.tx_unicast_frames_ok;
+	stats->tx_words = vs->tx.tx_unicast_bytes_ok / 4;
+	stats->rx_frames = vs->rx.rx_unicast_frames_ok;
+	stats->rx_words = vs->rx.rx_unicast_bytes_ok / 4;
+	stats->error_frames = vs->tx.tx_errors + vs->rx.rx_errors;
+	stats->dumped_frames = vs->tx.tx_drops + vs->rx.rx_drop;
+	stats->invalid_crc_count = vs->rx.rx_crc_errors;
+	stats->seconds_since_last_reset =
+		(jiffies - fnic->stats_reset_time) / HZ;
+	stats->fcp_input_megabytes = div_u64(fnic->fcp_input_bytes, 1000000);
+	stats->fcp_output_megabytes = div_u64(fnic->fcp_output_bytes, 1000000);
 	return stats;
 }
 
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 21bb5d92f04f..aa463ed652c0 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -503,6 +503,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	if (ret) {
 		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
 				"rport is not ready\n");
+		atomic64_inc(&fnic_stats->misc_stats.tport_not_ready);
 		sc->result = ret;
 		done(sc);
 		return 0;
@@ -1138,6 +1139,15 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 		  jiffies_to_msecs(jiffies - start_time)),
 		  desc, cmd_trace, fnic_flags_and_state(sc));
 
+	if (sc->sc_data_direction == DMA_FROM_DEVICE) {
+		fnic_stats->host_stats.fcp_input_requests++;
+		fnic->fcp_input_bytes += xfer_len;
+	} else if (sc->sc_data_direction == DMA_TO_DEVICE) {
+		fnic_stats->host_stats.fcp_output_requests++;
+		fnic->fcp_output_bytes += xfer_len;
+	} else
+		fnic_stats->host_stats.fcp_control_requests++;
+
 	/* Call SCSI completion function to complete the IO */
 	scsi_done(sc);
 
@@ -1986,8 +1996,8 @@ void fnic_scsi_unload_cleanup(struct fnic *fnic)
 {
 	int hwq = 0;
 
-	fc_remove_host(fnic->host);
-	scsi_remove_host(fnic->host);
+	fc_remove_host(fnic->lport->host);
+	scsi_remove_host(fnic->lport->host);
 	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
 		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 }
@@ -2066,6 +2076,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 				  fnic_priv(sc)->flags);
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
+		atomic64_inc(&fnic_stats->misc_stats.iport_not_ready);
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					  "iport NOT in READY state");
 		ret = FAILED;
@@ -2149,6 +2160,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	if (fc_remote_port_chkready(rport) == 0)
 		task_req = FCPIO_ITMF_ABT_TASK;
 	else {
+		atomic64_inc(&fnic_stats->misc_stats.tport_not_ready);
 		task_req = FCPIO_ITMF_ABT_TASK_TERM;
 	}
 
@@ -2586,6 +2598,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	}
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
+		atomic64_inc(&fnic_stats->misc_stats.iport_not_ready);
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					  "iport NOT in READY state");
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -2603,6 +2616,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 
 	/* Check if remote port up */
 	if (fc_remote_port_chkready(rport)) {
+		atomic64_inc(&fnic_stats->misc_stats.tport_not_ready);
 		goto fnic_device_reset_end;
 	}
 
@@ -3080,6 +3094,7 @@ void fnic_scsi_fcpio_reset(struct fnic *fnic)
 				  "FW reset completion timed out after %d ms)\n",
 				  FNIC_FW_RESET_TIMEOUT);
 		}
+		atomic64_inc(&fnic->fnic_stats.reset_stats.fw_reset_timeouts);
 	}
 	fnic->fw_reset_done = NULL;
 }
diff --git a/drivers/scsi/fnic/fnic_stats.h b/drivers/scsi/fnic/fnic_stats.h
index 1f1a1ec90a23..ef7cdc909940 100644
--- a/drivers/scsi/fnic/fnic_stats.h
+++ b/drivers/scsi/fnic/fnic_stats.h
@@ -63,6 +63,7 @@ struct reset_stats {
 	atomic64_t fw_resets;
 	atomic64_t fw_reset_completions;
 	atomic64_t fw_reset_failures;
+	atomic64_t fw_reset_timeouts;
 	atomic64_t fnic_resets;
 	atomic64_t fnic_reset_completions;
 	atomic64_t fnic_reset_failures;
@@ -102,10 +103,51 @@ struct misc_stats {
 	atomic64_t no_icmnd_itmf_cmpls;
 	atomic64_t check_condition;
 	atomic64_t queue_fulls;
-	atomic64_t rport_not_ready;
+	atomic64_t tport_not_ready;
+	atomic64_t iport_not_ready;
 	atomic64_t frame_errors;
 	atomic64_t current_port_speed;
 	atomic64_t intx_dummy;
+	atomic64_t port_speed_in_mbps;
+};
+
+struct fnic_iport_stats {
+	atomic64_t num_linkdn;
+	atomic64_t num_linkup;
+	atomic64_t link_failure_count;
+	atomic64_t num_rscns;
+	atomic64_t rscn_redisc;
+	atomic64_t rscn_not_redisc;
+	atomic64_t frame_err;
+	atomic64_t num_rnid;
+	atomic64_t fabric_flogi_sent;
+	atomic64_t fabric_flogi_ls_accepts;
+	atomic64_t fabric_flogi_ls_rejects;
+	atomic64_t fabric_flogi_misc_rejects;
+	atomic64_t fabric_plogi_sent;
+	atomic64_t fabric_plogi_ls_accepts;
+	atomic64_t fabric_plogi_ls_rejects;
+	atomic64_t fabric_plogi_misc_rejects;
+	atomic64_t fabric_scr_sent;
+	atomic64_t fabric_scr_ls_accepts;
+	atomic64_t fabric_scr_ls_rejects;
+	atomic64_t fabric_scr_misc_rejects;
+	atomic64_t fabric_logo_sent;
+	atomic64_t tport_alive;
+	atomic64_t tport_plogi_sent;
+	atomic64_t tport_plogi_ls_accepts;
+	atomic64_t tport_plogi_ls_rejects;
+	atomic64_t tport_plogi_misc_rejects;
+	atomic64_t tport_prli_sent;
+	atomic64_t tport_prli_ls_accepts;
+	atomic64_t tport_prli_ls_rejects;
+	atomic64_t tport_prli_misc_rejects;
+	atomic64_t tport_adisc_sent;
+	atomic64_t tport_adisc_ls_accepts;
+	atomic64_t tport_adisc_ls_rejects;
+	atomic64_t tport_logo_sent;
+	atomic64_t unsupported_frames_ls_rejects;
+	atomic64_t unsupported_frames_dropped;
 };
 
 struct fnic_stats {
@@ -116,6 +158,7 @@ struct fnic_stats {
 	struct reset_stats reset_stats;
 	struct fw_stats fw_stats;
 	struct vlan_stats vlan_stats;
+	struct fc_host_statistics host_stats;
 	struct misc_stats misc_stats;
 };
 
@@ -127,4 +170,5 @@ struct stats_debug_info {
 };
 
 int fnic_get_stats_data(struct stats_debug_info *, struct fnic_stats *);
+const char *fnic_role_to_str(unsigned int role);
 #endif /* _FNIC_STATS_H_ */
diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index d717886808df..6729b988c541 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -8,6 +8,7 @@
 #include <linux/kallsyms.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
+#include <scsi/scsi_transport_fc.h>
 #include "fnic_io.h"
 #include "fnic.h"
 
@@ -29,6 +30,17 @@ int fnic_fc_tracing_enabled = 1;
 int fnic_fc_trace_cleared = 1;
 static DEFINE_SPINLOCK(fnic_fc_trace_lock);
 
+const char *fnic_role_str[] = {
+	[FNIC_ROLE_FCP_INITIATOR] = "FCP_Initiator",
+};
+
+const char *fnic_role_to_str(unsigned int role)
+{
+	if (role >= ARRAY_SIZE(fnic_role_str) || !fnic_role_str[role])
+		return "Unknown";
+
+	return fnic_role_str[role];
+}
 
 /*
  * fnic_trace_get_buf - Give buffer pointer to user to fill up trace information
@@ -423,7 +435,8 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
 		  "Number of Check Conditions encountered: %lld\n"
 		  "Number of QUEUE Fulls: %lld\n"
 		  "Number of rport not ready: %lld\n"
-		  "Number of receive frame errors: %lld\n",
+		 "Number of receive frame errors: %lld\n"
+		 "Port speed (in Mbps): %lld\n",
 		  (u64)stats->misc_stats.last_isr_time,
 		  (s64)val1.tv_sec, val1.tv_nsec,
 		  (u64)stats->misc_stats.last_ack_time,
@@ -446,13 +459,9 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
 		  (u64)atomic64_read(&stats->misc_stats.no_icmnd_itmf_cmpls),
 		  (u64)atomic64_read(&stats->misc_stats.check_condition),
 		  (u64)atomic64_read(&stats->misc_stats.queue_fulls),
-		  (u64)atomic64_read(&stats->misc_stats.rport_not_ready),
-		  (u64)atomic64_read(&stats->misc_stats.frame_errors));
-
-	len += scnprintf(debug->debug_buffer + len, buf_size - len,
-			"Firmware reported port speed: %llu\n",
-			(u64)atomic64_read(
-				&stats->misc_stats.current_port_speed));
+		  (u64)atomic64_read(&stats->misc_stats.tport_not_ready),
+		  (u64)atomic64_read(&stats->misc_stats.frame_errors),
+		  (u64)atomic64_read(&stats->misc_stats.port_speed_in_mbps));
 
 	return len;
 
@@ -460,8 +469,56 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
 
 int fnic_get_debug_info(struct stats_debug_info *info, struct fnic *fnic)
 {
-	/* Placeholder function */
-	return 0;
+	struct fnic_iport_s *iport = &fnic->iport;
+	int buf_size = info->buf_size;
+	int len = info->buffer_len;
+	struct fnic_tport_s *tport, *next;
+	unsigned long flags;
+
+	len += snprintf(info->debug_buffer + len, buf_size - len,
+					"------------------------------------------\n"
+					"\t\t Debug Info\n"
+					"------------------------------------------\n");
+	len += snprintf(info->debug_buffer + len, buf_size - len,
+					"fnic Name:%s number:%d Role:%s State:%s\n",
+					fnic->name, fnic->fnic_num,
+					fnic_role_to_str(fnic->role),
+					fnic_state_to_str(fnic->state));
+	len +=
+		snprintf(info->debug_buffer + len, buf_size - len,
+			 "iport State:%d Flags:0x%x vlan_id:%d fcid:0x%x\n",
+			 iport->state, iport->flags, iport->vlan_id, iport->fcid);
+	len +=
+		snprintf(info->debug_buffer + len, buf_size - len,
+			 "usefip:%d fip_state:%d fip_flogi_retry:%d\n",
+			 iport->usefip, iport->fip.state, iport->fip.flogi_retry);
+	len +=
+		snprintf(info->debug_buffer + len, buf_size - len,
+				 "fpma %02x:%02x:%02x:%02x:%02x:%02x",
+				 iport->fpma[5], iport->fpma[4], iport->fpma[3],
+				 iport->fpma[2], iport->fpma[1], iport->fpma[0]);
+	len +=
+		snprintf(info->debug_buffer + len, buf_size - len,
+				"fcfmac %02x:%02x:%02x:%02x:%02x:%02x\n",
+				iport->fcfmac[5], iport->fcfmac[4], iport->fcfmac[3],
+				iport->fcfmac[2], iport->fcfmac[1], iport->fcfmac[0]);
+	len +=
+		snprintf(info->debug_buffer + len, buf_size - len,
+		 "fabric state:%d flags:0x%x retry_counter:%d e_d_tov:%d r_a_tov:%d\n",
+		 iport->fabric.state, iport->fabric.flags,
+		 iport->fabric.retry_counter, iport->e_d_tov,
+		 iport->r_a_tov);
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
+		len += snprintf(info->debug_buffer + len, buf_size - len,
+		"tport fcid:0x%x state:%d flags:0x%x inflight:%d retry_counter:%d\n",
+		tport->fcid, tport->state, tport->flags,
+		atomic_read(&tport->in_flight),
+		tport->retry_counter);
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	return len;
 }
 
 /*
@@ -694,7 +751,7 @@ int fnic_fc_trace_set_data(u32 host_no, u8 frame_type,
 	 */
 	if (frame_type == FNIC_FC_RECV) {
 		eth_fcoe_hdr_len = sizeof(struct ethhdr) +
-					sizeof(struct fcoe_hdr);
+							sizeof(struct fnic_fcoe_hdr_s);
 		memset((char *)fc_trace, 0xff, eth_fcoe_hdr_len);
 		/* Copy the rest of data frame */
 		memcpy((char *)(fc_trace + eth_fcoe_hdr_len), (void *)frame,
@@ -800,7 +857,7 @@ void copy_and_format_trace_data(struct fc_trace_hdr *tdata,
 {
 	int j, i = 1, len;
 	int ethhdr_len = sizeof(struct ethhdr) - 1;
-	int fcoehdr_len = sizeof(struct fcoe_hdr);
+	int fcoehdr_len = sizeof(struct fnic_fcoe_hdr_s);
 	int fchdr_len = sizeof(struct fc_frame_header);
 	int max_size = fnic_fc_trace_max_pages * PAGE_SIZE * 3;
 	char *fc_trace;
-- 
2.31.1


