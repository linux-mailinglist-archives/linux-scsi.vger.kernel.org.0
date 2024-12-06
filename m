Return-Path: <linux-scsi+bounces-10607-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28EC9E7A82
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 22:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7333E188742C
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 21:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096D206281;
	Fri,  6 Dec 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="R9/9iG2F"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDF213E75;
	Fri,  6 Dec 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519790; cv=none; b=EzbDkc2yEvBLWMCFCedN0YaFivSRKfYnMR50Gz/1zQj0v5bPRIRGSVuYSvbq9qQi5XO1Tv5PzuuBoMj9LIHdgxNIHhEEUE7zmbMgaXCeACa2YVu/bLGzNVUsUM2v95kKpLrZyO2kEAEAD+ONbGwIMhmvr2ctQWy12YoTq1uxUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519790; c=relaxed/simple;
	bh=q1H+liuBNKyKjIl4ygiPXNAEEEXmQM+5P/V9jJBy2a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0RIHh90dnUiC7/BOQxkGwKK8eP88+RGV4ueE93MTYNXNrY57k+n0WDDx8mexbwyxv96DN52Lu+UUDC8j6V+uB/Dhu5u4LOHZNr8XocOQPjl3iG+o95VmnvAivFIWzhgDZy/OG3SOu1qcp+hlTPGzEbLIB5QmoUVn6tq/izi5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=R9/9iG2F; arc=none smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=39595; q=dns/txt;
  s=iport; t=1733519788; x=1734729388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1aMslo4b8rSatMQsN1XI6jBx8Lg8bw1aEcn/DjGdi40=;
  b=R9/9iG2Fbd6/A8jR6Ouh9jtX5BNO6n9c3cY+0rFYMxBv2kvQMH41w6sb
   pWpWdL6y0CEE9pa1TYaMqcffc7PaTNFWO0LEFFUnKs2sgUCKwnbGU+IeM
   KVwyCLnthwvZaqCFOLetVG9WpRtfjhKRr4+2coYNiT018HEGF7zS1i9bY
   g=;
X-CSE-ConnectionGUID: RcHq4KkWQJecfn2ruchvzw==
X-CSE-MsgGUID: JqNESSgART62PPEnz6p26w==
X-IPAS-Result: =?us-ascii?q?A0AnAADjaFNn/4//Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBghsvdllDGS+McolRgRadBRSBEQNWDwEBAQ85CwQBAYUHAopoAiY0C?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4V7DYZbAgEDG?=
 =?us-ascii?q?gEMCwFGEDkBF1YZgilYAYJkAxGxZoF5M4EB3jOBZwaBSAGNSXCEdycVBoFJR?=
 =?us-ascii?q?IEUAYE7gTcHb4FSglhhAoV6BIM1gyN2JYETh22Bb4t8HTCCLow3SIEhA1khE?=
 =?us-ascii?q?QFVEw0KCwcFgXYDgk16K4ELgRc6gX6BE0qFDEY9gkppSzcCDQI2giR9gk2FG?=
 =?us-ascii?q?YRpYy8DAwMDgzyGJYI0QAMLGA1IESw3FBsGPm4HoUUBRoNSBxYnPhQrIAIuB?=
 =?us-ascii?q?HkXGQEVAR4FBjqSQB0HAgEHCpIRgTSfTYQkjBeOB4cmGjOqUZh7jgKWQoRmg?=
 =?us-ascii?q?Wc8gVkzGggbFTuCZxM/GQ+OLRaIbLk5JTICOgIHCwEBAwmTPoEbYAEB?=
IronPort-Data: A9a23:hybe0K5fRv4rd2T9/tEtsAxRtB7GchMFZxGqfqrLsTDasY5as4F+v
 mIXXGDQMqyCYTGgKt90OtzkphxSuMTVm9EwTlZt+Ho9Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoazhMtfrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eB4Y447pUAl531
 /ETJjZXdA2Ih/yk3+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGc6FSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEUUrsUIMpWcOOAhXDlbzxcoVG9rqss6G+Vxwt0uFToGICFJoLSGp8Owi50o
 Erk5kLUOSoVHeajl2C9yl+qlLHXx33kDdd6+LqQs6QCbEeo7mgQEDUXU0e2pb+yjUvWc9BSK
 UY8/isosLh09UauCNL6WnWQpXeeoh8aHcJdD+Ag8wyL4q3O6g2dCy4PSTspQNgnstImAD8nz
 FmEm/v3CjF19r6YU3SQ8vGTtzzaESwUK3ISIDQPVgot/dbuuscwgwjJQ9IlF7S65uAZAhnqy
 DyM6Sx7jLIJgItTieOw/EvMhHSnoZ2hohMJ2zg7l1mNtmtRDLNJraTygbQHxZ6s9Lqkc2Q=
IronPort-HdrOrdr: A9a23:L/VCBKHPMKIrbiZ5pLqEx8eALOsnbusQ8zAXPo5KJSC9Ffbo8/
 xG88506faZslwssTQb6LO90cq7MBbhHPxOgLX5VI3KNGLbUSmTXeNfBODZrAEIdReSysdtkY
 99bqlzD8DxB1Bmgcu/3BO1CL8bsb66GdiT5ds3CxxWPHhXg2YK1XYeNjqm
X-Talos-CUID: 9a23:FzUSm2AyM5wpejz6ExNs1FdIOcMaS1/Qx3nWeVWlAmZ3WqLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A4AT9nAyFOPxwlJ/rZn0y/B4H7K2aqIa3Lm02qpo?=
 =?us-ascii?q?vgfXabxRIFjGP0iztHJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="284607234"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Dec 2024 21:15:19 +0000
Received: from fedora.cisco.com (unknown [10.24.83.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id A47E918000254;
	Fri,  6 Dec 2024 21:15:17 +0000 (GMT)
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
	Karan Tilak Kumar <kartilak@cisco.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 09/15] scsi: fnic: Add functionality in fnic to support FDLS
Date: Fri,  6 Dec 2024 13:08:46 -0800
Message-ID: <20241206210852.3251-10-kartilak@cisco.com>
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

Add interfaces in fnic to use FDLS services.
Modify link up and link down functionality to use FDLS.
Replace existing interfaces to handle new functionality
provided by FDLS.
Modify data types of some data members to handle new
functionality.
Add processing of tports and handling of tports.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202409292037.ZYWZwIK6-lkp@
intel.com/

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Co-developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-developed-by: Arun Easi <aeasi@cisco.com>
Signed-off-by: Arun Easi <aeasi@cisco.com>
Co-developed-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v4 and v5:
    Incorporate review comments from Martin:
        Modify attribution appropriately.
        Remove placeholder start flogi call.
        Remove spurious newlines from the bottom of fdls_disc.c.
        Remove spurious newlines from the bottom of fnic_fcs.c.
        Remove spurious newlines from the bottom of fnic_scsi.c.

Changes between v3 and v4:
    Fix kernel test robot warnings.

Changes between v2 and v3:
    Refactor fnic_fdls_remove_tport to fix null pointer exception.
    Incorporate review comments from Hannes:
        Replace redundant definitions with standard definitions.

Changes between v1 and v2:
    Incorporate review comments from Hannes:
        Replace fnic_del_tport_timer_sync macro calls with function
        calls.
---
 drivers/scsi/fnic/fdls_disc.c |  75 +++++-
 drivers/scsi/fnic/fip.c       |  27 +-
 drivers/scsi/fnic/fnic.h      |  20 +-
 drivers/scsi/fnic/fnic_fcs.c  | 482 ++++++++++++++++++++++++----------
 drivers/scsi/fnic/fnic_main.c |  11 +-
 drivers/scsi/fnic/fnic_scsi.c | 127 +++++++--
 6 files changed, 568 insertions(+), 174 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 02fd69e72830..b81e05beb904 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -397,6 +397,13 @@ static bool fdls_is_oxid_tgt_req(uint16_t oxid)
 	return true;
 }
 
+static void fdls_reset_oxid_pool(struct fnic_iport_s *iport)
+{
+	struct fnic_oxid_pool_s *oxid_pool = &iport->oxid_pool;
+
+	oxid_pool->next_idx = 0;
+}
+
 void fnic_del_fabric_timer_sync(struct fnic *fnic)
 {
 	fnic->iport.fabric.del_timer_inprogress = 1;
@@ -2248,7 +2255,6 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 		}
 		break;
 	default:
-		fnic_fdls_start_flogi(iport);	/* Placeholder call */
 		break;
 	}
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -3471,6 +3477,12 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 
 		fnic_fdls_learn_fcoe_macs(iport, rx_frame, fcid);
 
+		if (fnic_fdls_register_portid(iport, iport->fcid, rx_frame) != 0) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "0x%x: FLOGI registration failed", iport->fcid);
+			break;
+		}
+
 		memcpy(&fcmac[3], fcid, 3);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 			 "Adding vNIC device MAC addr: %02x:%02x:%02x:%02x:%02x:%02x",
@@ -4448,6 +4460,30 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 		fdls_send_gpn_ft(iport, FDLS_STATE_RSCN_GPN_FT);
 		fdls_send_rscn_resp(iport, fchdr);
 }
+
+void fnic_fdls_disc_start(struct fnic_iport_s *iport)
+{
+	struct fnic *fnic = iport->fnic;
+
+	if (IS_FNIC_FCP_INITIATOR(fnic)) {
+		fc_host_fabric_name(iport->fnic->lport->host) = 0;
+		fc_host_post_event(iport->fnic->lport->host, fc_get_event_number(),
+						   FCH_EVT_LIPRESET, 0);
+	}
+
+	if (!iport->usefip) {
+		if (iport->flags & FNIC_FIRST_LINK_UP) {
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+			fnic_scsi_fcpio_reset(iport->fnic);
+			spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+
+			iport->flags &= ~FNIC_FIRST_LINK_UP;
+		}
+		fnic_fdls_start_flogi(iport);
+	} else
+		fnic_fdls_start_plogi(iport);
+}
+
 static void
 fdls_process_adisc_req(struct fnic_iport_s *iport,
 		       struct fc_frame_header *fchdr)
@@ -4878,3 +4914,40 @@ void fnic_fdls_recv_frame(struct fnic_iport_s *iport, void *rx_frame,
 		break;
 	}
 }
+
+void fnic_fdls_disc_init(struct fnic_iport_s *iport)
+{
+	fdls_reset_oxid_pool(iport);
+	fdls_set_state((&iport->fabric), FDLS_STATE_INIT);
+}
+
+void fnic_fdls_link_down(struct fnic_iport_s *iport)
+{
+	struct fnic_tport_s *tport, *next;
+	struct fnic *fnic = iport->fnic;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS processing link down", iport->fcid);
+
+	fdls_set_state((&iport->fabric), FDLS_STATE_LINKDOWN);
+	iport->fabric.flags = 0;
+
+	if (IS_FNIC_FCP_INITIATOR(fnic)) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+		fnic_scsi_fcpio_reset(iport->fnic);
+		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+		list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "removing rport: 0x%x", tport->fcid);
+			fdls_delete_tport(iport, tport);
+		}
+	}
+
+	if ((fnic_fdmi_support == 1) && (iport->fabric.fdmi_pending > 0)) {
+		del_timer_sync(&iport->fabric.fdmi_timer);
+		iport->fabric.fdmi_pending = 0;
+	}
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS finish processing link down", iport->fcid);
+}
diff --git a/drivers/scsi/fnic/fip.c b/drivers/scsi/fnic/fip.c
index 71b5ceff45db..31b3f3f6d192 100644
--- a/drivers/scsi/fnic/fip.c
+++ b/drivers/scsi/fnic/fip.c
@@ -534,6 +534,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
 				     fnic->fnic_num, "iport->state:%d\n",
 				     iport->state);
+			fnic_fdls_disc_start(iport);
 			if (!((iport->selected_fcf.ka_disabled)
 			      || (iport->selected_fcf.fka_adv_period == 0))) {
 				u64 tov;
@@ -617,6 +618,7 @@ void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph)
 	struct fip_cvl *cvl_msg = (struct fip_cvl *)fiph;
 	int i;
 	int found = false;
+	int max_count = 0;
 
 	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 		     "fnic 0x%p clear virtual link handler\n", fnic);
@@ -658,6 +660,26 @@ void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph)
 			return;
 		fnic_common_fip_cleanup(fnic);
 
+		while (fnic->reset_in_progress == IN_PROGRESS) {
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+			wait_for_completion_timeout(&fnic->reset_completion_wait,
+							msecs_to_jiffies(5000));
+			spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+			max_count++;
+			if (max_count >= FIP_FNIC_RESET_WAIT_COUNT) {
+				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Rthr waited too long. Skipping handle link event %p\n",
+					 fnic);
+				return;
+			}
+			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "fnic reset in progress. Link event needs to wait %p",
+				 fnic);
+		}
+		fnic->reset_in_progress = IN_PROGRESS;
+		fnic_fdls_link_down(iport);
+		fnic->reset_in_progress = NOT_IN_PROGRESS;
+		complete(&fnic->reset_completion_wait);
 		fnic_fcoe_send_vlan_req(fnic);
 	}
 }
@@ -717,8 +739,10 @@ void fnic_work_on_fip_timer(struct work_struct *work)
 			     "FCF Discovery timeout\n");
 		if (memcmp(iport->selected_fcf.fcf_mac, zmac, ETH_ALEN) != 0) {
 
-			if (iport->flags & FNIC_FIRST_LINK_UP)
+			if (iport->flags & FNIC_FIRST_LINK_UP) {
+				fnic_scsi_fcpio_reset(iport->fnic);
 				iport->flags &= ~FNIC_FIRST_LINK_UP;
+			}
 
 			fnic_fcoe_start_flogi(fnic);
 			if (!((iport->selected_fcf.ka_disabled)
@@ -961,6 +985,7 @@ void fnic_work_on_fcs_ka_timer(struct work_struct *work)
 
 	fnic_common_fip_cleanup(fnic);
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	fnic_fdls_link_down(iport);
 	iport->state = FNIC_IPORT_STATE_FIP;
 	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 64606fac14ea..0f92d57e0aac 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -84,6 +84,7 @@
 
 #define IS_FNIC_FCP_INITIATOR(fnic) (fnic->role == FNIC_ROLE_FCP_INITIATOR)
 
+#define FNIC_FW_RESET_TIMEOUT        60000	/* mSec   */
 /* Retry supported by rport (returned by PRLI service parameters) */
 #define FNIC_FC_RP_FLAGS_RETRY            0x1
 
@@ -205,6 +206,12 @@ static inline u64 fnic_flags_and_state(struct scsi_cmnd *cmd)
 #define fnic_clear_state_flags(fnicp, st_flags)  \
 	__fnic_set_state_flags(fnicp, st_flags, 1)
 
+enum reset_states {
+	NOT_IN_PROGRESS = 0,
+	IN_PROGRESS,
+	RESET_ERROR
+};
+
 extern unsigned int fnic_fdmi_support;
 extern unsigned int fnic_log_level;
 extern unsigned int io_completions;
@@ -357,6 +364,7 @@ struct fnic {
 	unsigned int wq_count;
 	unsigned int cq_count;
 
+	struct completion reset_completion_wait;
 	struct mutex sgreset_mutex;
 	spinlock_t sgreset_lock; /* lock for sgreset */
 	struct scsi_cmnd *sgreset_sc;
@@ -374,6 +382,8 @@ struct fnic {
 
 	struct completion *remove_wait; /* device remove thread blocks */
 
+	struct completion *fw_reset_done;
+	u32 reset_in_progress;
 	atomic_t in_flight;		/* io counter */
 	bool internal_reset_inprogress;
 	u32 _reserved;			/* fill hole */
@@ -387,6 +397,7 @@ struct fnic {
 	u64 fcp_input_bytes;		/* internal statistic */
 	u64 fcp_output_bytes;		/* internal statistic */
 	u32 link_down_cnt;
+	u32 soft_reset_count;
 	int link_status;
 
 	struct list_head list;
@@ -409,7 +420,7 @@ struct fnic {
 	struct work_struct link_work;
 	struct work_struct frame_work;
 	struct work_struct flush_work;
-	struct sk_buff_head frame_queue;
+	struct list_head frame_queue;
 	struct list_head tx_queue;
 	mempool_t *frame_pool;
 	mempool_t *frame_elem_pool;
@@ -471,6 +482,7 @@ int fnic_request_intr(struct fnic *fnic);
 int fnic_send(struct fc_lport *, struct fc_frame *);
 void fnic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf);
 void fnic_handle_frame(struct work_struct *work);
+void fnic_tport_event_handler(struct work_struct *work);
 void fnic_handle_link(struct work_struct *work);
 void fnic_handle_event(struct work_struct *work);
 void fdls_reclaim_oxid_handler(struct work_struct *work);
@@ -485,7 +497,8 @@ void fnic_update_mac_locked(struct fnic *, u8 *new);
 int fnic_queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
 int fnic_abort_cmd(struct scsi_cmnd *);
 int fnic_device_reset(struct scsi_cmnd *);
-int fnic_host_reset(struct scsi_cmnd *);
+int fnic_eh_host_reset_handler(struct scsi_cmnd *sc);
+int fnic_host_reset(struct Scsi_Host *shost);
 int fnic_reset(struct Scsi_Host *);
 void fnic_scsi_cleanup(struct fc_lport *);
 void fnic_scsi_abort_io(struct fc_lport *);
@@ -520,6 +533,9 @@ void fnic_dump_fchost_stats(struct Scsi_Host *, struct fc_host_statistics *);
 void fnic_free_txq(struct list_head *head);
 int fnic_get_desc_by_devid(struct pci_dev *pdev, char **desc,
 						   char **subsys_desc);
+void fnic_fdls_link_status_change(struct fnic *fnic, int linkup);
+void fnic_delete_fcp_tports(struct fnic *fnic);
+void fnic_flush_tport_event_list(struct fnic *fnic);
 
 struct fnic_scsi_iter_data {
 	struct fnic *fnic;
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 0194911898d9..65fb7ec6d504 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -25,6 +25,8 @@
 #include "cq_exch_desc.h"
 #include "fip.h"
 
+#define MAX_RESET_WAIT_COUNT    64
+
 extern struct workqueue_struct *fnic_fip_queue;
 struct workqueue_struct *fnic_event_queue;
 
@@ -61,6 +63,39 @@ static inline  void fnic_fdls_set_fcoe_dstmac(struct fnic *fnic,
 	memcpy(fnic->iport.fcfmac, dst_mac, 6);
 }
 
+void fnic_fdls_link_status_change(struct fnic *fnic, int linkup)
+{
+	struct fnic_iport_s *iport = &fnic->iport;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "link up: %d, usefip: %d", linkup, iport->usefip);
+
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+
+	if (linkup) {
+		if (iport->usefip) {
+			iport->state = FNIC_IPORT_STATE_FIP;
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "link up: %d, usefip: %d", linkup, iport->usefip);
+			fnic_fcoe_send_vlan_req(fnic);
+		} else {
+			iport->state = FNIC_IPORT_STATE_FABRIC_DISC;
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "iport->state: %d", iport->state);
+			fnic_fdls_disc_start(iport);
+		}
+	} else {
+		iport->state = FNIC_IPORT_STATE_LINK_WAIT;
+		if (!is_zero_ether_addr(iport->fpma))
+			vnic_dev_del_addr(fnic->vdev, iport->fpma);
+		fnic_common_fip_cleanup(fnic);
+		fnic_fdls_link_down(iport);
+
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+}
+
+
 /*
  * FPMA can be either taken from ethhdr(dst_mac) or flogi resp
  * or derive from FC_MAP and FCID combination. While it should be
@@ -106,149 +141,128 @@ void fnic_fdls_init(struct fnic *fnic, int usefip)
 
 	INIT_LIST_HEAD(&iport->tport_list);
 	INIT_LIST_HEAD(&iport->tport_list_pending_del);
+
+	fnic_fdls_disc_init(iport);
 }
 
 void fnic_handle_link(struct work_struct *work)
 {
 	struct fnic *fnic = container_of(work, struct fnic, link_work);
-	unsigned long flags;
 	int old_link_status;
 	u32 old_link_down_cnt;
-	u64 old_port_speed, new_port_speed;
+	int max_count = 0;
 
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	if (vnic_dev_get_intr_mode(fnic->vdev) != VNIC_DEV_INTR_MODE_MSI)
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Interrupt mode is not MSI\n");
 
-	fnic->link_events = 1;      /* less work to just set everytime*/
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 
 	if (fnic->stop_rx_link_events) {
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Stop link rx events\n");
+		return;
+	}
+
+	/* Do not process if the fnic is already in transitional state */
+	if ((fnic->state != FNIC_IN_ETH_MODE)
+		&& (fnic->state != FNIC_IN_FC_MODE)) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "fnic in transitional state: %d. link up: %d ignored",
+			 fnic->state, vnic_dev_link_status(fnic->vdev));
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Current link status: %d iport state: %d\n",
+			 fnic->link_status, fnic->iport.state);
 		return;
 	}
 
 	old_link_down_cnt = fnic->link_down_cnt;
 	old_link_status = fnic->link_status;
-	old_port_speed = atomic64_read(
-			&fnic->fnic_stats.misc_stats.current_port_speed);
-
 	fnic->link_status = vnic_dev_link_status(fnic->vdev);
 	fnic->link_down_cnt = vnic_dev_link_down_cnt(fnic->vdev);
 
-	new_port_speed = vnic_dev_port_speed(fnic->vdev);
-	atomic64_set(&fnic->fnic_stats.misc_stats.current_port_speed,
-			new_port_speed);
-	if (old_port_speed != new_port_speed)
+	while (fnic->reset_in_progress == IN_PROGRESS) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "fnic reset in progress. Link event needs to wait\n");
+
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "waiting for reset completion\n");
+		wait_for_completion_timeout(&fnic->reset_completion_wait,
+									msecs_to_jiffies(5000));
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "woken up from reset completion wait\n");
+		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+
+		max_count++;
+		if (max_count >= MAX_RESET_WAIT_COUNT) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Rstth waited for too long. Skipping handle link event\n");
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+			return;
+		}
+	}
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Marking fnic reset in progress\n");
+	fnic->reset_in_progress = IN_PROGRESS;
+
+	if ((vnic_dev_get_intr_mode(fnic->vdev) != VNIC_DEV_INTR_MODE_MSI) ||
+		(fnic->link_status != old_link_status)) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "old link status: %d link status: %d\n",
+					 old_link_status, (int) fnic->link_status);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-				"Current vnic speed set to: %llu\n",
-				new_port_speed);
-
-	switch (vnic_dev_port_speed(fnic->vdev)) {
-	case DCEM_PORTSPEED_10G:
-		fc_host_speed(fnic->lport->host)   = FC_PORTSPEED_10GBIT;
-		fnic->lport->link_supported_speeds = FC_PORTSPEED_10GBIT;
-		break;
-	case DCEM_PORTSPEED_20G:
-		fc_host_speed(fnic->lport->host)   = FC_PORTSPEED_20GBIT;
-		fnic->lport->link_supported_speeds = FC_PORTSPEED_20GBIT;
-		break;
-	case DCEM_PORTSPEED_25G:
-		fc_host_speed(fnic->lport->host)   = FC_PORTSPEED_25GBIT;
-		fnic->lport->link_supported_speeds = FC_PORTSPEED_25GBIT;
-		break;
-	case DCEM_PORTSPEED_40G:
-	case DCEM_PORTSPEED_4x10G:
-		fc_host_speed(fnic->lport->host)   = FC_PORTSPEED_40GBIT;
-		fnic->lport->link_supported_speeds = FC_PORTSPEED_40GBIT;
-		break;
-	case DCEM_PORTSPEED_100G:
-		fc_host_speed(fnic->lport->host)   = FC_PORTSPEED_100GBIT;
-		fnic->lport->link_supported_speeds = FC_PORTSPEED_100GBIT;
-		break;
-	default:
-		fc_host_speed(fnic->lport->host)   = FC_PORTSPEED_UNKNOWN;
-		fnic->lport->link_supported_speeds = FC_PORTSPEED_UNKNOWN;
-		break;
+					 "old down count %d down count: %d\n",
+					 old_link_down_cnt, (int) fnic->link_down_cnt);
 	}
 
 	if (old_link_status == fnic->link_status) {
 		if (!fnic->link_status) {
 			/* DOWN -> DOWN */
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-			fnic_fc_trace_set_data(fnic->lport->host->host_no,
-				FNIC_FC_LE, "Link Status: DOWN->DOWN",
-				strlen("Link Status: DOWN->DOWN"));
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-					"down->down\n");
+						 "down->down\n");
 		} else {
 			if (old_link_down_cnt != fnic->link_down_cnt) {
 				/* UP -> DOWN -> UP */
-				fnic->lport->host_stats.link_failure_count++;
-				spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-				fnic_fc_trace_set_data(
-					fnic->lport->host->host_no,
-					FNIC_FC_LE,
-					"Link Status:UP_DOWN_UP",
-					strlen("Link_Status:UP_DOWN_UP")
-					);
-				FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-					     "link down\n");
-				fcoe_ctlr_link_down(&fnic->ctlr);
-				if (fnic->config.flags & VFCF_FIP_CAPABLE) {
-					/* start FCoE VLAN discovery */
-					fnic_fc_trace_set_data(
-						fnic->lport->host->host_no,
-						FNIC_FC_LE,
-						"Link Status: UP_DOWN_UP_VLAN",
-						strlen(
-						"Link Status: UP_DOWN_UP_VLAN")
-						);
-					fnic_fcoe_send_vlan_req(fnic);
-					return;
-				}
+				spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-						"up->down->up: Link up\n");
-				fcoe_ctlr_link_up(&fnic->ctlr);
+							 "up->down. Link down\n");
+				fnic_fdls_link_status_change(fnic, 0);
+
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "down->up. Link up\n");
+				fnic_fdls_link_status_change(fnic, 1);
 			} else {
 				/* UP -> UP */
-				spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-				fnic_fc_trace_set_data(
-					fnic->lport->host->host_no, FNIC_FC_LE,
-					"Link Status: UP_UP",
-					strlen("Link Status: UP_UP"));
+				spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-						"up->up\n");
+							 "up->up\n");
 			}
 		}
 	} else if (fnic->link_status) {
 		/* DOWN -> UP */
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		if (fnic->config.flags & VFCF_FIP_CAPABLE) {
-			/* start FCoE VLAN discovery */
-			fnic_fc_trace_set_data(fnic->lport->host->host_no,
-					       FNIC_FC_LE, "Link Status: DOWN_UP_VLAN",
-					       strlen("Link Status: DOWN_UP_VLAN"));
-			fnic_fcoe_send_vlan_req(fnic);
-
-			return;
-		}
-
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-				"down->up: Link up\n");
-		fnic_fc_trace_set_data(fnic->lport->host->host_no, FNIC_FC_LE,
-				       "Link Status: DOWN_UP", strlen("Link Status: DOWN_UP"));
-		fcoe_ctlr_link_up(&fnic->ctlr);
+					 "down->up. Link up\n");
+		fnic_fdls_link_status_change(fnic, 1);
 	} else {
 		/* UP -> DOWN */
-		fnic->lport->host_stats.link_failure_count++;
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-				"up->down: Link down\n");
-		fnic_fc_trace_set_data(
-			fnic->lport->host->host_no, FNIC_FC_LE,
-			"Link Status: UP_DOWN",
-			strlen("Link Status: UP_DOWN"));
-		fcoe_ctlr_link_down(&fnic->ctlr);
+					 "up->down. Link down\n");
+		fnic_fdls_link_status_change(fnic, 0);
 	}
 
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	fnic->reset_in_progress = NOT_IN_PROGRESS;
+	complete(&fnic->reset_completion_wait);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Marking fnic reset completion\n");
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 }
 
 /*
@@ -257,35 +271,44 @@ void fnic_handle_link(struct work_struct *work)
 void fnic_handle_frame(struct work_struct *work)
 {
 	struct fnic *fnic = container_of(work, struct fnic, frame_work);
-	struct fc_lport *lp = fnic->lport;
-	unsigned long flags;
-	struct sk_buff *skb;
-	struct fc_frame *fp;
-
-	while ((skb = skb_dequeue(&fnic->frame_queue))) {
+	struct fnic_frame_list *cur_frame, *next;
+	int fchdr_offset = 0;
 
-		spin_lock_irqsave(&fnic->fnic_lock, flags);
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	list_for_each_entry_safe(cur_frame, next, &fnic->frame_queue, links) {
 		if (fnic->stop_rx_link_events) {
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-			dev_kfree_skb(skb);
+			list_del(&cur_frame->links);
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+			kfree(cur_frame->fp);
+			mempool_free(cur_frame, fnic->frame_elem_pool);
 			return;
 		}
-		fp = (struct fc_frame *)skb;
 
 		/*
 		 * If we're in a transitional state, just re-queue and return.
 		 * The queue will be serviced when we get to a stable state.
 		 */
 		if (fnic->state != FNIC_IN_FC_MODE &&
-		    fnic->state != FNIC_IN_ETH_MODE) {
-			skb_queue_head(&fnic->frame_queue, skb);
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			fnic->state != FNIC_IN_ETH_MODE) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Cannot process frame in transitional state\n");
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 			return;
 		}
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-		fc_exch_recv(lp, fp);
+		list_del(&cur_frame->links);
+
+		/* Frames from FCP_RQ will have ethhdrs stripped off */
+		fchdr_offset = (cur_frame->rx_ethhdr_stripped) ?
+			0 : FNIC_ETH_FCOE_HDRS_OFFSET;
+
+		fnic_fdls_recv_frame(&fnic->iport, cur_frame->fp,
+							 cur_frame->frame_len, fchdr_offset);
+
+		kfree(cur_frame->fp);
+		mempool_free(cur_frame, fnic->frame_elem_pool);
 	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 }
 
 void fnic_handle_fip_frame(struct work_struct *work)
@@ -484,9 +507,8 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	frame_elem =
-		kzalloc(sizeof(struct fnic_frame_list),
-						   GFP_ATOMIC);
+	frame_elem = mempool_alloc(fnic->frame_elem_pool,
+					GFP_ATOMIC | __GFP_ZERO);
 	if (!frame_elem) {
 		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					 "Unable to alloc frame element of size: %ld\n",
@@ -497,6 +519,10 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 	frame_elem->rx_ethhdr_stripped = ethhdr_stripped;
 	frame_elem->frame_len = bytes_written;
 
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	list_add_tail(&frame_elem->links, &fnic->frame_queue);
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
 	queue_work(fnic_event_queue, &fnic->frame_work);
 	return;
 
@@ -527,7 +553,7 @@ int fnic_rq_cmpl_handler(struct fnic *fnic, int rq_work_to_do)
 		cur_work_done = vnic_cq_service(&fnic->cq[i], rq_work_to_do,
 						fnic_rq_cmpl_handler_cont,
 						NULL);
-		if (cur_work_done) {
+		if (cur_work_done && fnic->stop_rx_link_events != 1) {
 			err = vnic_rq_fill(&fnic->rq[i], fnic_alloc_rq_frame);
 			if (err)
 				shost_printk(KERN_ERR, fnic->lport->host,
@@ -548,46 +574,43 @@ int fnic_rq_cmpl_handler(struct fnic *fnic, int rq_work_to_do)
 int fnic_alloc_rq_frame(struct vnic_rq *rq)
 {
 	struct fnic *fnic = vnic_dev_priv(rq->vdev);
-	struct sk_buff *skb;
+	void *buf;
 	u16 len;
 	dma_addr_t pa;
-	int r;
+	int ret;
 
-	len = FC_FRAME_HEADROOM + FC_MAX_FRAME + FC_FRAME_TAILROOM;
-	skb = dev_alloc_skb(len);
-	if (!skb) {
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-			     "Unable to allocate RQ sk_buff\n");
+	len = FNIC_FRAME_HT_ROOM;
+	buf = kmalloc(len, GFP_ATOMIC);
+	if (!buf) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Unable to allocate RQ buffer of size: %d\n", len);
 		return -ENOMEM;
 	}
-	skb_reset_mac_header(skb);
-	skb_reset_transport_header(skb);
-	skb_reset_network_header(skb);
-	skb_put(skb, len);
-	pa = dma_map_single(&fnic->pdev->dev, skb->data, len, DMA_FROM_DEVICE);
+
+	pa = dma_map_single(&fnic->pdev->dev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(&fnic->pdev->dev, pa)) {
-		r = -ENOMEM;
-		printk(KERN_ERR "PCI mapping failed with error %d\n", r);
-		goto free_skb;
+		ret = -ENOMEM;
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PCI mapping failed with error %d\n", ret);
+		goto free_buf;
 	}
 
-	fnic_queue_rq_desc(rq, skb, pa, len);
+	fnic_queue_rq_desc(rq, buf, pa, len);
 	return 0;
-
-free_skb:
-	kfree_skb(skb);
-	return r;
+free_buf:
+	kfree(buf);
+	return ret;
 }
 
 void fnic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
 {
-	struct fc_frame *fp = buf->os_buf;
+	void *rq_buf = buf->os_buf;
 	struct fnic *fnic = vnic_dev_priv(rq->vdev);
 
 	dma_unmap_single(&fnic->pdev->dev, buf->dma_addr, buf->len,
 			 DMA_FROM_DEVICE);
 
-	dev_kfree_skb(fp_skb(fp));
+	kfree(rq_buf);
 	buf->os_buf = NULL;
 }
 
@@ -818,13 +841,11 @@ static void fnic_wq_complete_frame_send(struct vnic_wq *wq,
 					struct cq_desc *cq_desc,
 					struct vnic_wq_buf *buf, void *opaque)
 {
-	struct sk_buff *skb = buf->os_buf;
-	struct fc_frame *fp = (struct fc_frame *)skb;
 	struct fnic *fnic = vnic_dev_priv(wq->vdev);
 
 	dma_unmap_single(&fnic->pdev->dev, buf->dma_addr, buf->len,
 			 DMA_TO_DEVICE);
-	dev_kfree_skb_irq(fp_skb(fp));
+	mempool_free(buf->os_buf, fnic->frame_pool);
 	buf->os_buf = NULL;
 }
 
@@ -862,13 +883,182 @@ int fnic_wq_cmpl_handler(struct fnic *fnic, int work_to_do)
 
 void fnic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf)
 {
-	struct fc_frame *fp = buf->os_buf;
 	struct fnic *fnic = vnic_dev_priv(wq->vdev);
 
 	dma_unmap_single(&fnic->pdev->dev, buf->dma_addr, buf->len,
 			 DMA_TO_DEVICE);
 
-	dev_kfree_skb(fp_skb(fp));
+	kfree(buf->os_buf);
 	buf->os_buf = NULL;
 }
 
+void
+fnic_fdls_add_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport,
+					unsigned long flags)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fc_rport *rport;
+	struct fc_rport_identifiers ids;
+	struct rport_dd_data_s *rdd_data;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Adding rport fcid: 0x%x", tport->fcid);
+
+	ids.node_name = tport->wwnn;
+	ids.port_name = tport->wwpn;
+	ids.port_id = tport->fcid;
+	ids.roles = FC_RPORT_ROLE_FCP_TARGET;
+
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	rport = fc_remote_port_add(fnic->lport->host, 0, &ids);
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	if (!rport) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Failed to add rport for tport: 0x%x", tport->fcid);
+		return;
+	}
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Added rport fcid: 0x%x", tport->fcid);
+
+	/* Mimic these assignments in queuecommand to avoid timing issues */
+	rport->maxframe_size = FNIC_FC_MAX_PAYLOAD_LEN;
+	rport->supported_classes = FC_COS_CLASS3 | FC_RPORT_ROLE_FCP_TARGET;
+	rdd_data = rport->dd_data;
+	rdd_data->tport = tport;
+	rdd_data->iport = iport;
+	tport->rport = rport;
+	tport->flags |= FNIC_FDLS_SCSI_REGISTERED;
+}
+
+void
+fnic_fdls_remove_tport(struct fnic_iport_s *iport,
+					   struct fnic_tport_s *tport, unsigned long flags)
+{
+	struct fnic *fnic = iport->fnic;
+	struct rport_dd_data_s *rdd_data;
+
+	struct fc_rport *rport;
+
+	if (!tport)
+		return;
+
+	fdls_set_tport_state(tport, FDLS_TGT_STATE_OFFLINE);
+	rport = tport->rport;
+
+	if (rport) {
+		/* tport resource release will be done
+		 * after fnic_terminate_rport_io()
+		 */
+		tport->flags |= FNIC_FDLS_TPORT_DELETED;
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+		/* Interface to scsi_fc_transport  */
+		fc_remote_port_delete(rport);
+
+		spin_lock_irqsave(&fnic->fnic_lock, flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "Deregistered and freed tport fcid: 0x%x from scsi transport fc",
+		 tport->fcid);
+
+		/*
+		 * the dd_data is allocated by fc transport
+		 * of size dd_fcrport_size
+		 */
+		rdd_data = rport->dd_data;
+		rdd_data->tport = NULL;
+		rdd_data->iport = NULL;
+		list_del(&tport->links);
+		kfree(tport);
+	} else {
+		fnic_del_tport_timer_sync(fnic, tport);
+		list_del(&tport->links);
+		kfree(tport);
+	}
+}
+
+void fnic_delete_fcp_tports(struct fnic *fnic)
+{
+	struct fnic_tport_s *tport, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	list_for_each_entry_safe(tport, next, &fnic->iport.tport_list, links) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "removing fcp rport fcid: 0x%x", tport->fcid);
+		fdls_set_tport_state(tport, FDLS_TGT_STATE_OFFLINING);
+		fnic_del_tport_timer_sync(fnic, tport);
+		fnic_fdls_remove_tport(&fnic->iport, tport, flags);
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+}
+
+/**
+ * fnic_tport_event_handler() - Handler for remote port events
+ * in the tport_event_queue.
+ *
+ * @work: Handle to the remote port being dequeued
+ */
+void fnic_tport_event_handler(struct work_struct *work)
+{
+	struct fnic *fnic = container_of(work, struct fnic, tport_work);
+	struct fnic_tport_event_s *cur_evt, *next;
+	unsigned long flags;
+	struct fnic_tport_s *tport;
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	list_for_each_entry_safe(cur_evt, next, &fnic->tport_event_list, links) {
+		tport = cur_evt->arg1;
+		switch (cur_evt->event) {
+		case TGT_EV_RPORT_ADD:
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Add rport event");
+			if (tport->state == FDLS_TGT_STATE_READY) {
+				fnic_fdls_add_tport(&fnic->iport,
+					(struct fnic_tport_s *) cur_evt->arg1, flags);
+			} else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Target not ready. Add rport event dropped: 0x%x",
+					 tport->fcid);
+			}
+			break;
+		case TGT_EV_RPORT_DEL:
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Remove rport event");
+			if (tport->state == FDLS_TGT_STATE_OFFLINING) {
+				fnic_fdls_remove_tport(&fnic->iport,
+					   (struct fnic_tport_s *) cur_evt->arg1, flags);
+			} else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "remove rport event dropped tport fcid: 0x%x",
+							 tport->fcid);
+			}
+			break;
+		case TGT_EV_TPORT_DELETE:
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Delete tport event");
+			fdls_delete_tport(tport->iport, tport);
+			break;
+		default:
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Unknown tport event");
+			break;
+		}
+		list_del(&cur_evt->links);
+		kfree(cur_evt);
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+}
+
+void fnic_flush_tport_event_list(struct fnic *fnic)
+{
+	struct fnic_tport_event_s *cur_evt, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	list_for_each_entry_safe(cur_evt, next, &fnic->tport_event_list, links) {
+		list_del(&cur_evt->links);
+		kfree(cur_evt);
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+}
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index b9374ccb4669..943f7d997d10 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -111,7 +111,7 @@ static const struct scsi_host_template fnic_host_template = {
 	.eh_timed_out = fc_eh_timed_out,
 	.eh_abort_handler = fnic_abort_cmd,
 	.eh_device_reset_handler = fnic_device_reset,
-	.eh_host_reset_handler = fnic_host_reset,
+	.eh_host_reset_handler = fnic_eh_host_reset_handler,
 	.slave_alloc = fnic_slave_alloc,
 	.change_queue_depth = scsi_change_queue_depth,
 	.this_id = -1,
@@ -936,9 +936,12 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&fnic->link_work, fnic_handle_link);
 	INIT_WORK(&fnic->frame_work, fnic_handle_frame);
+	INIT_WORK(&fnic->tport_work, fnic_tport_event_handler);
 	INIT_WORK(&fnic->flush_work, fnic_flush_tx);
-	skb_queue_head_init(&fnic->frame_queue);
+
+	INIT_LIST_HEAD(&fnic->frame_queue);
 	INIT_LIST_HEAD(&fnic->tx_queue);
+	INIT_LIST_HEAD(&fnic->tport_event_list);
 
 	fc_fabric_login(lp);
 
@@ -1032,7 +1035,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	 * be no event queued for this fnic device in the workqueue
 	 */
 	flush_workqueue(fnic_event_queue);
-	skb_queue_purge(&fnic->frame_queue);
+	fnic_free_txq(&fnic->frame_queue);
 	fnic_free_txq(&fnic->tx_queue);
 
 	if (fnic->config.flags & VFCF_FIP_CAPABLE) {
@@ -1070,8 +1073,6 @@ static void fnic_remove(struct pci_dev *pdev)
 	 */
 	fnic_cleanup(fnic);
 
-	BUG_ON(!skb_queue_empty(&fnic->frame_queue));
-
 	spin_lock_irqsave(&fnic_list_lock, flags);
 	list_del(&fnic->list);
 	spin_unlock_irqrestore(&fnic_list_lock, flags);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 295dcda4ec16..74298f9a34e5 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -183,7 +183,7 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 	/* indicate fwreset to io path */
 	fnic_set_state_flags(fnic, FNIC_FLAGS_FWRESET);
 
-	skb_queue_purge(&fnic->frame_queue);
+	fnic_free_txq(&fnic->frame_queue);
 	fnic_free_txq(&fnic->tx_queue);
 
 	/* wait for io cmpl */
@@ -2575,23 +2575,30 @@ int fnic_reset(struct Scsi_Host *shost)
  * host is offlined by SCSI.
  *
  */
-int fnic_host_reset(struct scsi_cmnd *sc)
+int fnic_host_reset(struct Scsi_Host *shost)
 {
-	int ret;
+	int ret = SUCCESS;
 	unsigned long wait_host_tmo;
-	struct Scsi_Host *shost = sc->device->host;
-	struct fc_lport *lp = shost_priv(shost);
-	struct fnic *fnic = lport_priv(lp);
+	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
 	unsigned long flags;
+	struct fnic_iport_s *iport = &fnic->iport;
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (!fnic->internal_reset_inprogress) {
-		fnic->internal_reset_inprogress = true;
+	if (fnic->reset_in_progress == NOT_IN_PROGRESS) {
+		fnic->reset_in_progress = IN_PROGRESS;
 	} else {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-			"host reset in progress skipping another host reset\n");
-		return SUCCESS;
+		wait_for_completion_timeout(&fnic->reset_completion_wait,
+									msecs_to_jiffies(10000));
+
+		spin_lock_irqsave(&fnic->fnic_lock, flags);
+		if (fnic->reset_in_progress == IN_PROGRESS) {
+			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			FNIC_SCSI_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
+			  "Firmware reset in progress. Skipping another host reset\n");
+			return SUCCESS;
+		}
+		fnic->reset_in_progress = IN_PROGRESS;
 	}
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
@@ -2600,23 +2607,33 @@ int fnic_host_reset(struct scsi_cmnd *sc)
 	 * scsi-ml tries to send a TUR to every device if host reset is
 	 * successful, so before returning to scsi, fabric should be up
 	 */
-	ret = (fnic_reset(shost) == 0) ? SUCCESS : FAILED;
-	if (ret == SUCCESS) {
+	fnic_reset(shost);
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	fnic->reset_in_progress = NOT_IN_PROGRESS;
+	complete(&fnic->reset_completion_wait);
+	fnic->soft_reset_count++;
+
+	/* wait till the link is up */
+	if (fnic->link_status) {
 		wait_host_tmo = jiffies + FNIC_HOST_RESET_SETTLE_TIME * HZ;
 		ret = FAILED;
 		while (time_before(jiffies, wait_host_tmo)) {
-			if ((lp->state == LPORT_ST_READY) &&
-			    (lp->link_up)) {
+			if (iport->state != FNIC_IPORT_STATE_READY
+				&& fnic->link_status) {
+				spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+				ssleep(1);
+				spin_lock_irqsave(&fnic->fnic_lock, flags);
+			} else {
 				ret = SUCCESS;
 				break;
 			}
-			ssleep(1);
 		}
 	}
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	fnic->internal_reset_inprogress = false;
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				  "host reset return status: %d\n", ret);
 	return ret;
 }
 
@@ -2809,3 +2826,75 @@ int fnic_is_abts_pending(struct fnic *fnic, struct scsi_cmnd *lr_sc)
 
 	return iter_data.ret;
 }
+
+/*
+ * SCSI Error handling calls driver's eh_host_reset if all prior
+ * error handling levels return FAILED. If host reset completes
+ * successfully, and if link is up, then Fabric login begins.
+ *
+ * Host Reset is the highest level of error recovery. If this fails, then
+ * host is offlined by SCSI.
+ *
+ */
+int fnic_eh_host_reset_handler(struct scsi_cmnd *sc)
+{
+	int ret = 0;
+	struct Scsi_Host *shost = sc->device->host;
+	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
+
+	FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				  "SCSI error handling: fnic host reset");
+
+	ret = fnic_host_reset(shost);
+	return ret;
+}
+
+
+void fnic_scsi_fcpio_reset(struct fnic *fnic)
+{
+	unsigned long flags;
+	enum fnic_state old_state;
+	struct fnic_iport_s *iport = &fnic->iport;
+	DECLARE_COMPLETION_ONSTACK(fw_reset_done);
+	int time_remain;
+
+	/* issue fw reset */
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	if (unlikely(fnic->state == FNIC_IN_FC_TRANS_ETH_MODE)) {
+		/* fw reset is in progress, poll for its completion */
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			  "fnic is in unexpected state: %d for fw_reset\n",
+			  fnic->state);
+		return;
+	}
+
+	old_state = fnic->state;
+	fnic->state = FNIC_IN_FC_TRANS_ETH_MODE;
+
+	fnic_update_mac_locked(fnic, iport->hwmac);
+	fnic->fw_reset_done = &fw_reset_done;
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				  "Issuing fw reset\n");
+	if (fnic_fw_reset_handler(fnic)) {
+		spin_lock_irqsave(&fnic->fnic_lock, flags);
+		if (fnic->state == FNIC_IN_FC_TRANS_ETH_MODE)
+			fnic->state = old_state;
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	} else {
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					  "Waiting for fw completion\n");
+		time_remain = wait_for_completion_timeout(&fw_reset_done,
+						  msecs_to_jiffies(FNIC_FW_RESET_TIMEOUT));
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					  "Woken up after fw completion timeout\n");
+		if (time_remain == 0) {
+			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				  "FW reset completion timed out after %d ms)\n",
+				  FNIC_FW_RESET_TIMEOUT);
+		}
+	}
+	fnic->fw_reset_done = NULL;
+}
-- 
2.47.0


