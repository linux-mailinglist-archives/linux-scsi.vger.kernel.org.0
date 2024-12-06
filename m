Return-Path: <linux-scsi+bounces-10610-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873D9E7A8C
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 22:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79EA16ABF6
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45221AAA24;
	Fri,  6 Dec 2024 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dww6Qy9d"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CC213E97;
	Fri,  6 Dec 2024 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519861; cv=none; b=oy2Ew3ED41U5fNTg4MfPMtCwg76/P0yYczJHwA7UqzdJRyiw9WTgoe8xvCjCgxWdRlY5JEnAWIcxe7iAdTtqDnWIBnygVQmA6bJ0guBkRWLAxoglLU/JTkKJV+3TsEFbwhYEiHDYzdpq10K85ViimhdVZKii2Rhi9GE+HKuycNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519861; c=relaxed/simple;
	bh=rhj6kbxWalJKn2oUjkWi7SZ+ytEwnKyQd8PRo7KOnmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmfnmXq2QU6dI4bWRp5TOS1LeO0D6z6hzhSiO8pC/Lk98Z3uxYx3OKuI3QzsYBgsGyfSgvMZYcMMbPVSJb/vgso7fEpKmDuhXSYeB8V0LWEW4uiu1Y1X8dFqDAH+5aWLKseqn4sduH3ZAKhiiRPpkyWQMLqihcFULhQELJAQOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=dww6Qy9d; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=22198; q=dns/txt;
  s=iport; t=1733519859; x=1734729459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qiopzEiLtl2+jRfJQ71GszwqHaOEz5XIyyC6TNySlG0=;
  b=dww6Qy9dA45lKaoqxmYF3rrlNaz6ogilGWYssohTl22kMvpNINU2LplE
   4FMxgDd3Jqw8/0Inx+mIwYyPve2/S2xpeREznnPi+0GvjuYoC2M6s+yYu
   noSOgviYKGMzv1SZG96trSr2/q1px6MihFEURCTPO/fYKzu8eSkFsgcOR
   4=;
X-CSE-ConnectionGUID: l3a3HMyuR9CvPV3sJ9FRgA==
X-CSE-MsgGUID: HGX0vY99RoCQThjtipg+Vw==
X-IPAS-Result: =?us-ascii?q?A0ANAADjaFNn/4//Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgkqBT0MZL4xyiVGBFp0FFIERA1YPAQEBD0QEAQGFBwKKa?=
 =?us-ascii?q?AImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbA?=
 =?us-ascii?q?gEDGg0LAUYQUVYZgwGCZQOxd4F5M4EB3jOBbYFIAY1JcIR3JxUGgUlEgRWBO?=
 =?us-ascii?q?4E3doFSgliGXQSCPHmEGSWBE4dtgW+LfB0wgi6MN0iBIQNZIREBVRMNCgsHB?=
 =?us-ascii?q?YF2A4JNeiuBC4EXOoF+gRNKhQxGPYJKaUs3Ag0CNoIkfYJNhRmEaWMvAwMDA?=
 =?us-ascii?q?4M8hiWCNEADCxgNSBEsNxQbBj5uB6FGRoNKCAcBFRtBHYEwPgoXBCweFpMMC?=
 =?us-ascii?q?QEHj3uCIIE0n02EJKFEGjOqUZh7o3RQhGaBZzyBWTMaCBsVgyJSGQ+OLRbCJ?=
 =?us-ascii?q?SUyPAIHCwEBAwmGS4xxBAGBeAEB?=
IronPort-Data: A9a23:WBAz3KAsAd2uABVW/zjiw5YqxClBgxIJ4kV8jS/XYbTApDhx0mcBm
 GBKCziEP/rZZ2Knf40lOYrl9hhVsMTQmNFmOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eDYQX9hWYvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEx65nV2ETLJAiq81pOV8V7
 t5JBgoCR0XW7w626OrTpuhEnM8vKozveYgYoHwllW+fBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY0BPjDS0Un1lM/C5skgOasj3rXeDxDo1XTrq0yi4TW5FYgiui0b4uJJrRmQ+11sXbAu
 FOXrl7+KSgmNN6DyCKKsUyz07qncSTTHdh6+KeD3vxngle7wm0VFQ1QVFG+5/K+jyaWXttFN
 00SvDIjsaUo70GtZt7nVha8rTiPuRt0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC/
 luImc75QCdkq7y9V32Q7PGXoCm0NCxTKnUNDRLoViMf6NXl5YV2hRXVQ5M7Tui+j8b+Hnf7x
 DXiQDUCuoj/RPUjj82TlW0rSRr1znQVZmbZPjnqY18=
IronPort-HdrOrdr: A9a23:MnkNyKrqhgG/Kh2F+GN6wiEaV5oEeYIsimQD101hICG9vPb1qy
 nIpoV+6faaslgssR0b8+xofZPwIk80lqQFhLX5X43CYOCOggLBR72Kr7GSoQEIcBeQygcy78
 pdWpk7IMHsDFR8kMbx6BS1HpId2tWdmZrY4ts2t00McemvAJsQljuQzW2gYytLeDU=
X-Talos-CUID: 9a23:fbqb+2/C7l0zyM/M4s2Vv0pPE5sFV2zA9ib7PXeGUn1LGZOvRnbFrQ==
X-Talos-MUID: 9a23:hokbSgb4blaO5uBTlxDc3C9TZZZS5I+XNEAPjZQetIq6Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="292817944"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Dec 2024 21:17:37 +0000
Received: from fedora.cisco.com (unknown [10.24.83.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id B013118000264;
	Fri,  6 Dec 2024 21:17:36 +0000 (GMT)
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com,
	djhawar@cisco.com,
	gcboffa@cisco.com,
	mkai2@cisco.com,
	satishkh@cisco.com,
	aeasi@cisco.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v6 12/15] scsi: fnic: Add stats and related functionality
Date: Fri,  6 Dec 2024 13:08:49 -0800
Message-ID: <20241206210852.3251-13-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206210852.3251-1-kartilak@cisco.com>
References: <20241206210852.3251-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.24.83.168, [10.24.83.168]
X-Outbound-Node: rcdn-l-core-06.cisco.com

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
 drivers/scsi/fnic/fdls_disc.c  | 32 +++++++++++++-
 drivers/scsi/fnic/fnic_fdls.h  |  6 ++-
 drivers/scsi/fnic/fnic_main.c  | 34 ++++++++++++++-
 drivers/scsi/fnic/fnic_scsi.c  | 19 +++++++-
 drivers/scsi/fnic/fnic_stats.h | 45 ++++++++++++++++++-
 drivers/scsi/fnic/fnic_trace.c | 79 +++++++++++++++++++++++++++++-----
 6 files changed, 196 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index b81e05beb904..3c77e975aa70 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -877,6 +877,7 @@ static void fdls_send_fabric_flogi(struct fnic_iport_s *iport)
 		 oxid);
 
 	fnic_send_fcoe_frame(iport, frame, frame_size);
+	atomic64_inc(&iport->iport_stats.fabric_flogi_sent);
 err_out:
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
 	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
@@ -919,6 +920,7 @@ static void fdls_send_fabric_plogi(struct fnic_iport_s *iport)
 		 oxid);
 
 	fnic_send_fcoe_frame(iport, frame, frame_size);
+	atomic64_inc(&iport->iport_stats.fabric_plogi_sent);
 
 err_out:
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
@@ -1080,6 +1082,7 @@ static void fdls_send_scr(struct fnic_iport_s *iport)
 		 oxid);
 
 	fnic_send_fcoe_frame(iport, frame, frame_size);
+	atomic64_inc(&iport->iport_stats.fabric_scr_sent);
 
 err_out:
 	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
@@ -1201,6 +1204,8 @@ fdls_send_tgt_adisc(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 				 "0x%x: FDLS send ADISC to tgt fcid: 0x%x",
 				 iport->fcid, tport->fcid);
 
+	atomic64_inc(&iport->iport_stats.tport_adisc_sent);
+
 	fnic_send_fcoe_frame(iport, frame, frame_size);
 
 err_out:
@@ -1310,6 +1315,7 @@ fdls_send_tgt_plogi(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 				 iport->fcid, tport->fcid, oxid);
 
 	fnic_send_fcoe_frame(iport, frame, frame_size);
+	atomic64_inc(&iport->iport_stats.tport_plogi_sent);
 
 err_out:
 	timeout = max(2 * iport->e_d_tov, iport->plogi_timeout);
@@ -1515,6 +1521,7 @@ fdls_send_tgt_prli(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 			iport->fcid, tport->fcid, oxid);
 
 	fnic_send_fcoe_frame(iport, frame, frame_size);
+	atomic64_inc(&iport->iport_stats.tport_prli_sent);
 
 err_out:
 	timeout = max(2 * iport->e_d_tov, iport->plogi_timeout);
@@ -1626,6 +1633,8 @@ void fdls_tgt_logout(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 		 iport->fcid, oxid);
 
 	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+	atomic64_inc(&iport->iport_stats.tport_logo_sent);
 }
 
 static void fdls_tgt_discovery_start(struct fnic_iport_s *iport)
@@ -2515,6 +2524,7 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 
 	switch (adisc_rsp->els.adisc_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.tport_adisc_ls_accepts);
 		if (tport->timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 						 "tport 0x%p Canceling fabric disc timer\n",
@@ -2537,6 +2547,7 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 		break;
 
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.tport_adisc_ls_rejects);
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
@@ -2608,11 +2619,13 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 
 	switch (plogi_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.tport_plogi_ls_accepts);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PLOGI accepted by target: 0x%x", tgt_fcid);
 		break;
 
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.tport_plogi_ls_rejects);
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < iport->max_plogi_retries)) {
@@ -2630,6 +2643,7 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 		return;
 
 	default:
+		atomic64_inc(&iport->iport_stats.tport_plogi_misc_rejects);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PLOGI not accepted from target fcid: 0x%x",
 					 tgt_fcid);
@@ -2733,6 +2747,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 
 	switch (prli_rsp->els_prli.prli_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.tport_prli_ls_accepts);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PRLI accepted from target: 0x%x", tgt_fcid);
 
@@ -2749,6 +2764,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 		}
 		break;
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.tport_prli_ls_rejects);
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
@@ -2772,6 +2788,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 		break;
 
 	default:
+		atomic64_inc(&iport->iport_stats.tport_prli_misc_rejects);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PRLI not accepted from target: 0x%x", tgt_fcid);
 		return;
@@ -3075,6 +3092,7 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 
 	switch (scr_rsp->scr.scr_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.fabric_scr_ls_accepts);
 		if (iport->fabric.timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 						 "Canceling fabric disc timer %p\n", iport);
@@ -3086,7 +3104,7 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 		break;
 
 	case ELS_LS_RJT:
-
+		atomic64_inc(&iport->iport_stats.fabric_scr_ls_rejects);
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 	     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
@@ -3111,6 +3129,7 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 		break;
 
 	default:
+		atomic64_inc(&iport->iport_stats.fabric_scr_misc_rejects);
 		break;
 	}
 }
@@ -3434,6 +3453,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 
 	switch (flogi_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.fabric_flogi_ls_accepts);
 		if (iport->fabric.timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 						 "iport fcid: 0x%x Canceling fabric disc timer\n",
@@ -3507,6 +3527,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 		break;
 
 	case ELS_LS_RJT:
+		atomic64_inc(&iport->iport_stats.fabric_flogi_ls_rejects);
 		if (fabric->retry_counter < iport->max_flogi_retries) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				 "FLOGI returned ELS_LS_RJT BUSY. Retry from timer routine %p",
@@ -3534,6 +3555,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "FLOGI response not accepted: 0x%x",
 		     flogi_rsp->els.fl_cmd);
+		atomic64_inc(&iport->iport_stats.fabric_flogi_misc_rejects);
 		break;
 	}
 }
@@ -3564,6 +3586,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 
 	switch (plogi_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
+		atomic64_inc(&iport->iport_stats.fabric_plogi_ls_accepts);
 		if (iport->fabric.timer_pending) {
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				 "iport fcid: 0x%x fabric PLOGI response: Accepted\n",
@@ -3576,7 +3599,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 		fdls_send_rpn_id(iport);
 		break;
 	case ELS_LS_RJT:
-
+		atomic64_inc(&iport->iport_stats.fabric_plogi_ls_rejects);
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 	     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (iport->fabric.retry_counter < iport->max_plogi_retries)) {
@@ -3602,6 +3625,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "PLOGI response not accepted: 0x%x",
 		     plogi_rsp->els.fl_cmd);
+		atomic64_inc(&iport->iport_stats.fabric_plogi_misc_rejects);
 		break;
 	}
 }
@@ -3945,6 +3969,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			 "Dropping unsupported ELS with illegal frame bits 0x%x\n",
 			 d_id);
+		atomic64_inc(&iport->iport_stats.unsupported_frames_dropped);
 		return;
 	}
 
@@ -3953,6 +3978,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			 "Dropping unsupported ELS request in iport state: %d",
 			 iport->state);
+		atomic64_inc(&iport->iport_stats.unsupported_frames_dropped);
 		return;
 	}
 
@@ -4381,6 +4407,8 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 	struct fnic *fnic = iport->fnic;
 	uint16_t rscn_payload_len;
 
+	atomic64_inc(&iport->iport_stats.num_rscns);
+
 	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				 "FDLS process RSCN %p", iport);
 
diff --git a/drivers/scsi/fnic/fnic_fdls.h b/drivers/scsi/fnic/fnic_fdls.h
index 943506dba858..8e610b65ad57 100644
--- a/drivers/scsi/fnic/fnic_fdls.h
+++ b/drivers/scsi/fnic/fnic_fdls.h
@@ -305,10 +305,12 @@ struct fnic_iport_s {
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
index 44cbb04b2421..628c9e5902a2 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -163,7 +163,7 @@ static struct fc_function_template fnic_fc_functions = {
 	.show_rport_dev_loss_tmo = 1,
 	.set_rport_dev_loss_tmo = fnic_set_rport_dev_loss_tmo,
 	.issue_fc_host_lip = fnic_issue_fc_host_lip,
-	.get_fc_host_stats = NULL,
+	.get_fc_host_stats = fnic_get_stats,
 	.reset_fc_host_stats = fnic_reset_host_stats,
 	.dd_fcrport_size = sizeof(struct rport_dd_data_s),
 	.terminate_rport_io = fnic_terminate_rport_io,
@@ -174,9 +174,11 @@ static void fnic_get_host_speed(struct Scsi_Host *shost)
 {
 	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
 	u32 port_speed = vnic_dev_port_speed(fnic->vdev);
+	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 
 	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 				  "port_speed: %d Mbps", port_speed);
+	atomic64_set(&fnic_stats->misc_stats.port_speed_in_mbps, port_speed);
 
 	/* Add in other values as they get defined in fw */
 	switch (port_speed) {
@@ -234,8 +236,38 @@ static void fnic_get_host_speed(struct Scsi_Host *shost)
 /* Placeholder function */
 static struct fc_host_statistics *fnic_get_stats(struct Scsi_Host *host)
 {
+	int ret;
 	struct fnic *fnic = *((struct fnic **) shost_priv(host));
 	struct fc_host_statistics *stats = &fnic->fnic_stats.host_stats;
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
index 09d0ad597b3a..e464c677e9da 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -490,6 +490,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	if (ret) {
 		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
 				"rport is not ready\n");
+		atomic64_inc(&fnic_stats->misc_stats.tport_not_ready);
 		sc->result = ret;
 		done(sc);
 		return 0;
@@ -1128,6 +1129,15 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
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
 
@@ -1977,8 +1987,8 @@ void fnic_scsi_unload_cleanup(struct fnic *fnic)
 {
 	int hwq = 0;
 
-	fc_remove_host(fnic->host);
-	scsi_remove_host(fnic->host);
+	fc_remove_host(fnic->lport->host);
+	scsi_remove_host(fnic->lport->host);
 	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
 		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 }
@@ -2057,6 +2067,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 				  fnic_priv(sc)->flags);
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
+		atomic64_inc(&fnic_stats->misc_stats.iport_not_ready);
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					  "iport NOT in READY state");
 		ret = FAILED;
@@ -2140,6 +2151,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	if (fc_remote_port_chkready(rport) == 0)
 		task_req = FCPIO_ITMF_ABT_TASK;
 	else {
+		atomic64_inc(&fnic_stats->misc_stats.tport_not_ready);
 		task_req = FCPIO_ITMF_ABT_TASK_TERM;
 	}
 
@@ -2577,6 +2589,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	}
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
+		atomic64_inc(&fnic_stats->misc_stats.iport_not_ready);
 		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					  "iport NOT in READY state");
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -2594,6 +2607,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 
 	/* Check if remote port up */
 	if (fc_remote_port_chkready(rport)) {
+		atomic64_inc(&fnic_stats->misc_stats.tport_not_ready);
 		goto fnic_device_reset_end;
 	}
 
@@ -3071,6 +3085,7 @@ void fnic_scsi_fcpio_reset(struct fnic *fnic)
 				  "FW reset completion timed out after %d ms)\n",
 				  FNIC_FW_RESET_TIMEOUT);
 		}
+		atomic64_inc(&fnic->fnic_stats.reset_stats.fw_reset_timeouts);
 	}
 	fnic->fw_reset_done = NULL;
 }
diff --git a/drivers/scsi/fnic/fnic_stats.h b/drivers/scsi/fnic/fnic_stats.h
index 817b27c7d023..8ddd20401a59 100644
--- a/drivers/scsi/fnic/fnic_stats.h
+++ b/drivers/scsi/fnic/fnic_stats.h
@@ -64,6 +64,7 @@ struct reset_stats {
 	atomic64_t fw_resets;
 	atomic64_t fw_reset_completions;
 	atomic64_t fw_reset_failures;
+	atomic64_t fw_reset_timeouts;
 	atomic64_t fnic_resets;
 	atomic64_t fnic_reset_completions;
 	atomic64_t fnic_reset_failures;
@@ -103,10 +104,51 @@ struct misc_stats {
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
@@ -129,4 +171,5 @@ struct stats_debug_info {
 };
 
 int fnic_get_stats_data(struct stats_debug_info *, struct fnic_stats *);
+const char *fnic_role_to_str(unsigned int role);
 #endif /* _FNIC_STATS_H_ */
diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index d717886808df..420a25332cef 100644
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
 
+static const char * const fnic_role_str[] = {
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
+							sizeof(struct fcoe_hdr);
 		memset((char *)fc_trace, 0xff, eth_fcoe_hdr_len);
 		/* Copy the rest of data frame */
 		memcpy((char *)(fc_trace + eth_fcoe_hdr_len), (void *)frame,
-- 
2.47.0


