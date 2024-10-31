Return-Path: <linux-scsi+bounces-9418-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D79B8603
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2024 23:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A835B21D91
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2024 22:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3359419D089;
	Thu, 31 Oct 2024 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqZ9puGI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A91CCEE8
	for <linux-scsi@vger.kernel.org>; Thu, 31 Oct 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412955; cv=none; b=ck95IdWXKVbqrWtybhd27nLJKinYhb3nRMoDapg3Q8N6K5Ui/4Pc+S0RyP5esBYplRW+WgtYwRXj+pV4W3N5mktz3AjJuvs6WfAAyl+i2ZdFiJg9L7GaLBRANWIsoODD8kq6ojg4Fdn+dWaOM0rQal8B5SS7pyuR/wUmWaxKz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412955; c=relaxed/simple;
	bh=4SBz78pkaF4yk3gxSBJxvc/WQlQcV+SvAMRwSolvQvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tsV0ATmZRdcX14lTmjfEbN/Hi3BQ9D1OmfMr1KInScC9iJKCX0KbODEaSBkHFmJqKeluuaCKLNccxSbUCvsCZaF4RPJuHJETFEXN9iS0wROg4ut1vUBGQXnM4JpxNupSZaas5sMd/xTdbsrThUR+2rtYZZHu34mWWD+lpNtpqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqZ9puGI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so1095729a91.3
        for <linux-scsi@vger.kernel.org>; Thu, 31 Oct 2024 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412939; x=1731017739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl20tqivcfn4DOfQvzemy/kAmmrI7nx4anGMksULo3o=;
        b=jqZ9puGI1otN5c/boBwN2mo4gYcep7pwk4fvAn28Iv4LXCEYAoBQdQJCputBCTI+nm
         O252oYu0u/VPFhnspoO6S9ifGS2tyF9HKF3UjoJ1tBQyXIAB39g/zItbpzVgeqvsjPU4
         AWqkajiMkM3GkVK0UeM0DFIejcDwvFmBqrEOB9s7q6V7bnyR2cs4gkXRR/u03aRhp9n3
         WcFKOTlDXtay6ycN4l/NXYf7WFezm9/uHieNn76+wboofLQx131Hm5nPz6QpK1nqDZmz
         fg0LwjrAPXDl+CfWRYVDTAfCge9OS2h4R2IQBnxYCN/6vCELEbgMwu9JzPZLiyVWzrHK
         eMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412939; x=1731017739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gl20tqivcfn4DOfQvzemy/kAmmrI7nx4anGMksULo3o=;
        b=TnD44efmFyRCJmQxuhPS4Zt/IW2yo+WPBHWYHPbPlApafXVnSS6MufUALlgBcler+o
         LxiqZ51ua4ONHkkgBRdFrjADXIrKvJv9gn68L5jnOAG8i78HceiYc5bsptnHV4LIrj4V
         FmKuKYRQinuxahU8Pw+kMbWn3I1yTzs+p7s+1Rac+/1pNNvA2yzHekaGXAn9RDzv1nyV
         AK8EMt+q57KuuwFP7fhAo4xJ3a7uK2wYUL3gV8zRNa+hxbFgDxdp2dG978RYO0YsPh4Y
         nQRzpVi01Va1Oo24kMEQAppEazypbkwMw5T3SdQeZ6R8tBt08BCEsCbdaatvujYvWIcX
         6CQw==
X-Gm-Message-State: AOJu0Yy3a/Xkt3ziwA4vr9D5xuKvgBs0vxgIBrU7/j7mu+ZSqKgiE40y
	j1TILIrH3NZUhnDHZ2Jr8wzaH6jqk/l5aXYlrz/gMY6ugBi3d2kU8ofVyQ==
X-Google-Smtp-Source: AGHT+IFbt5wSekoMGb5wP542ERaMoe0pF5o4nvFPpl2jjtAj/JWWLLz2MmomvkbqyhT7r7HfKS71kg==
X-Received: by 2002:a17:90b:5243:b0:2e2:cf6d:33fd with SMTP id 98e67ed59e1d1-2e93c1d3945mr5921195a91.31.1730412937599;
        Thu, 31 Oct 2024 15:15:37 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa25742sm3916528a91.19.2024.10.31.15.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 15:15:37 -0700 (PDT)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart2021@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH 09/11] lpfc: Change lpfc_nodelist nlp_flag member into a bitmask
Date: Thu, 31 Oct 2024 15:32:17 -0700
Message-Id: <20241031223219.152342-10-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20241031223219.152342-1-justintee8345@gmail.com>
References: <20241031223219.152342-1-justintee8345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In attempt to reduce the amount of unnecessary ndlp->lock acquisitions
in the lpfc driver, change nlpa_flag into an unsigned long bitmask and use
clear_bit/test_bit bitwise atomic APIs instead of reliance on ndlp->lock
for synchronization.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c       |   6 +-
 drivers/scsi/lpfc/lpfc_ct.c        |  18 +-
 drivers/scsi/lpfc/lpfc_debugfs.c   |   4 +-
 drivers/scsi/lpfc/lpfc_disc.h      |  59 ++---
 drivers/scsi/lpfc/lpfc_els.c       | 405 ++++++++++++-----------------
 drivers/scsi/lpfc/lpfc_hbadisc.c   | 225 +++++++---------
 drivers/scsi/lpfc/lpfc_init.c      |  24 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c | 329 ++++++++++-------------
 drivers/scsi/lpfc/lpfc_nvme.c      |   9 +-
 drivers/scsi/lpfc/lpfc_nvmet.c     |   2 +-
 drivers/scsi/lpfc/lpfc_scsi.c      |   8 +-
 drivers/scsi/lpfc/lpfc_sli.c       |  42 ++-
 drivers/scsi/lpfc/lpfc_vport.c     |   6 +-
 13 files changed, 476 insertions(+), 661 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 85059b83ea6b..1c6b024160da 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -398,7 +398,11 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 	/* in case no data is transferred */
 	bsg_reply->reply_payload_rcv_len = 0;
 
-	if (ndlp->nlp_flag & NLP_ELS_SND_MASK)
+	if (test_bit(NLP_PLOGI_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_PRLI_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_ADISC_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_LOGO_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_RNID_SND, &ndlp->nlp_flag))
 		return -ENODEV;
 
 	/* allocate our bsg tracking structure */
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index ce3a1f42713d..30891ad17e2a 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -735,7 +735,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "0238 Process x%06x NameServer Rsp "
-					 "Data: x%x x%x x%x x%lx x%x\n", Did,
+					 "Data: x%lx x%x x%x x%lx x%x\n", Did,
 					 ndlp->nlp_flag, ndlp->nlp_fc4_type,
 					 ndlp->nlp_state, vport->fc_flag,
 					 vport->fc_rscn_id_cnt);
@@ -744,7 +744,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
 			 * state of ndlp hit devloss, change state to
 			 * allow rediscovery.
 			 */
-			if (ndlp->nlp_flag & NLP_NPR_2B_DISC &&
+			if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag) &&
 			    ndlp->nlp_state == NLP_STE_UNUSED_NODE) {
 				lpfc_nlp_set_state(vport, ndlp,
 						   NLP_STE_NPR_NODE);
@@ -832,12 +832,10 @@ lpfc_ns_rsp_audit_did(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
 			if (ndlp->nlp_type != NLP_NVME_INITIATOR ||
 			    ndlp->nlp_state != NLP_STE_UNMAPPED_NODE)
 				continue;
-			spin_lock_irq(&ndlp->lock);
 			if (ndlp->nlp_DID == Did)
-				ndlp->nlp_flag &= ~NLP_NVMET_RECOV;
+				clear_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag);
 			else
-				ndlp->nlp_flag |= NLP_NVMET_RECOV;
-			spin_unlock_irq(&ndlp->lock);
+				set_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag);
 		}
 	}
 }
@@ -894,13 +892,11 @@ lpfc_ns_rsp(struct lpfc_vport *vport, struct lpfc_dmabuf *mp, uint8_t fc4_type,
 	 */
 	if (vport->phba->nvmet_support) {
 		list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
-			if (!(ndlp->nlp_flag & NLP_NVMET_RECOV))
+			if (!test_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag))
 				continue;
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RECOVERY);
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NVMET_RECOV;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag);
 		}
 	}
 
@@ -1440,7 +1436,7 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	if (ndlp) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "0242 Process x%x GFF "
-				 "NameServer Rsp Data: x%x x%lx x%x\n",
+				 "NameServer Rsp Data: x%lx x%lx x%x\n",
 				 did, ndlp->nlp_flag, vport->fc_flag,
 				 vport->fc_rscn_id_cnt);
 	} else {
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index a2d2b02b3418..3fd1aa5cc78c 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -870,8 +870,8 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 				wwn_to_u64(ndlp->nlp_nodename.u.wwn));
 		len += scnprintf(buf+len, size-len, "RPI:x%04x ",
 				 ndlp->nlp_rpi);
-		len +=  scnprintf(buf+len, size-len, "flag:x%08x ",
-			ndlp->nlp_flag);
+		len += scnprintf(buf+len, size-len, "flag:x%08lx ",
+				 ndlp->nlp_flag);
 		if (!ndlp->nlp_type)
 			len += scnprintf(buf+len, size-len, "UNKNOWN_TYPE ");
 		if (ndlp->nlp_type & NLP_FC_NODE)
diff --git a/drivers/scsi/lpfc/lpfc_disc.h b/drivers/scsi/lpfc/lpfc_disc.h
index 5d6eabaeb094..af5d5bd75642 100644
--- a/drivers/scsi/lpfc/lpfc_disc.h
+++ b/drivers/scsi/lpfc/lpfc_disc.h
@@ -102,7 +102,7 @@ struct lpfc_nodelist {
 
 	spinlock_t	lock;			/* Node management lock */
 
-	uint32_t         nlp_flag;		/* entry flags */
+	unsigned long    nlp_flag;		/* entry flags */
 	uint32_t         nlp_DID;		/* FC D_ID of entry */
 	uint32_t         nlp_last_elscmd;	/* Last ELS cmd sent */
 	uint16_t         nlp_type;
@@ -182,36 +182,37 @@ struct lpfc_node_rrq {
 #define lpfc_ndlp_check_qdepth(phba, ndlp) \
 	(ndlp->cmd_qdepth < phba->sli4_hba.max_cfg_param.max_xri)
 
-/* Defines for nlp_flag (uint32) */
-#define NLP_IGNR_REG_CMPL  0x00000001 /* Rcvd rscn before we cmpl reg login */
-#define NLP_REG_LOGIN_SEND 0x00000002   /* sent reglogin to adapter */
-#define NLP_SUPPRESS_RSP   0x00000010	/* Remote NPort supports suppress rsp */
-#define NLP_PLOGI_SND      0x00000020	/* sent PLOGI request for this entry */
-#define NLP_PRLI_SND       0x00000040	/* sent PRLI request for this entry */
-#define NLP_ADISC_SND      0x00000080	/* sent ADISC request for this entry */
-#define NLP_LOGO_SND       0x00000100	/* sent LOGO request for this entry */
-#define NLP_RNID_SND       0x00000400	/* sent RNID request for this entry */
-#define NLP_ELS_SND_MASK   0x000007e0	/* sent ELS request for this entry */
-#define NLP_NVMET_RECOV    0x00001000   /* NVMET auditing node for recovery. */
-#define NLP_UNREG_INP      0x00008000	/* UNREG_RPI cmd is in progress */
-#define NLP_DROPPED        0x00010000	/* Init ref count has been dropped */
-#define NLP_DELAY_TMO      0x00020000	/* delay timeout is running for node */
-#define NLP_NPR_2B_DISC    0x00040000	/* node is included in num_disc_nodes */
-#define NLP_RCV_PLOGI      0x00080000	/* Rcv'ed PLOGI from remote system */
-#define NLP_LOGO_ACC       0x00100000	/* Process LOGO after ACC completes */
-#define NLP_TGT_NO_SCSIID  0x00200000	/* good PRLI but no binding for scsid */
-#define NLP_ISSUE_LOGO     0x00400000	/* waiting to issue a LOGO */
-#define NLP_IN_DEV_LOSS    0x00800000	/* devloss in progress */
-#define NLP_ACC_REGLOGIN   0x01000000	/* Issue Reg Login after successful
+/* nlp_flag mask bits */
+enum lpfc_nlp_flag {
+	NLP_IGNR_REG_CMPL  = 0,         /* Rcvd rscn before we cmpl reg login */
+	NLP_REG_LOGIN_SEND = 1,         /* sent reglogin to adapter */
+	NLP_SUPPRESS_RSP   = 4,         /* Remote NPort supports suppress rsp */
+	NLP_PLOGI_SND      = 5,         /* sent PLOGI request for this entry */
+	NLP_PRLI_SND       = 6,         /* sent PRLI request for this entry */
+	NLP_ADISC_SND      = 7,         /* sent ADISC request for this entry */
+	NLP_LOGO_SND       = 8,         /* sent LOGO request for this entry */
+	NLP_RNID_SND       = 10,        /* sent RNID request for this entry */
+	NLP_NVMET_RECOV    = 12,        /* NVMET auditing node for recovery. */
+	NLP_UNREG_INP      = 15,        /* UNREG_RPI cmd is in progress */
+	NLP_DROPPED        = 16,        /* Init ref count has been dropped */
+	NLP_DELAY_TMO      = 17,        /* delay timeout is running for node */
+	NLP_NPR_2B_DISC    = 18,        /* node is included in num_disc_nodes */
+	NLP_RCV_PLOGI      = 19,        /* Rcv'ed PLOGI from remote system */
+	NLP_LOGO_ACC       = 20,        /* Process LOGO after ACC completes */
+	NLP_TGT_NO_SCSIID  = 21,        /* good PRLI but no binding for scsid */
+	NLP_ISSUE_LOGO     = 22,        /* waiting to issue a LOGO */
+	NLP_IN_DEV_LOSS    = 23,        /* devloss in progress */
+	NLP_ACC_REGLOGIN   = 24,        /* Issue Reg Login after successful
 					   ACC */
-#define NLP_NPR_ADISC      0x02000000	/* Issue ADISC when dq'ed from
+	NLP_NPR_ADISC      = 25,        /* Issue ADISC when dq'ed from
 					   NPR list */
-#define NLP_RM_DFLT_RPI    0x04000000	/* need to remove leftover dflt RPI */
-#define NLP_NODEV_REMOVE   0x08000000	/* Defer removal till discovery ends */
-#define NLP_TARGET_REMOVE  0x10000000   /* Target remove in process */
-#define NLP_SC_REQ         0x20000000	/* Target requires authentication */
-#define NLP_FIRSTBURST     0x40000000	/* Target supports FirstBurst */
-#define NLP_RPI_REGISTERED 0x80000000	/* nlp_rpi is valid */
+	NLP_RM_DFLT_RPI    = 26,        /* need to remove leftover dflt RPI */
+	NLP_NODEV_REMOVE   = 27,        /* Defer removal till discovery ends */
+	NLP_TARGET_REMOVE  = 28,        /* Target remove in process */
+	NLP_SC_REQ         = 29,        /* Target requires authentication */
+	NLP_FIRSTBURST     = 30,        /* Target supports FirstBurst */
+	NLP_RPI_REGISTERED = 31         /* nlp_rpi is valid */
+};
 
 /* There are 4 different double linked lists nodelist entries can reside on.
  * The Port Login (PLOGI) list and Address Discovery (ADISC) list are used
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2c64f8d0a7bd..37f0a930d469 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -725,11 +725,9 @@ lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		list_for_each_entry_safe(np, next_np,
 					&vport->fc_nodes, nlp_listp) {
 			if ((np->nlp_state != NLP_STE_NPR_NODE) ||
-				   !(np->nlp_flag & NLP_NPR_ADISC))
+			    !test_bit(NLP_NPR_ADISC, &np->nlp_flag))
 				continue;
-			spin_lock_irq(&np->lock);
-			np->nlp_flag &= ~NLP_NPR_ADISC;
-			spin_unlock_irq(&np->lock);
+			clear_bit(NLP_NPR_ADISC, &np->nlp_flag);
 			lpfc_unreg_rpi(vport, np);
 		}
 		lpfc_cleanup_pending_mbox(vport);
@@ -864,9 +862,7 @@ lpfc_cmpl_els_flogi_nport(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		       sizeof(struct lpfc_name));
 		/* Set state will put ndlp onto node list if not already done */
 		lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 		mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 		if (!mbox)
@@ -1018,7 +1014,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * registered with the SCSI transport, remove the initial
 		 * reference to trigger node release.
 		 */
-		if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS) &&
+		if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag) &&
 		    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD))
 			lpfc_nlp_put(ndlp);
 
@@ -1548,7 +1544,7 @@ lpfc_initial_flogi(struct lpfc_vport *vport)
 		 * Otherwise, decrement node reference to trigger release.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
-		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+		    !test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 			lpfc_nlp_put(ndlp);
 		return 0;
 	}
@@ -1597,7 +1593,7 @@ lpfc_initial_fdisc(struct lpfc_vport *vport)
 		 * Otherwise, decrement node reference to trigger release.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
-		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+		    !test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 			lpfc_nlp_put(ndlp);
 		return 0;
 	}
@@ -1675,9 +1671,9 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 	struct lpfc_nodelist *new_ndlp;
 	struct serv_parm *sp;
 	uint8_t  name[sizeof(struct lpfc_name)];
-	uint32_t keepDID = 0, keep_nlp_flag = 0;
+	uint32_t keepDID = 0;
 	int rc;
-	uint32_t keep_new_nlp_flag = 0;
+	unsigned long keep_nlp_flag = 0, keep_new_nlp_flag = 0;
 	uint16_t keep_nlp_state;
 	u32 keep_nlp_fc4_type = 0;
 	struct lpfc_nvme_rport *keep_nrport = NULL;
@@ -1704,8 +1700,8 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 	}
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_NODE,
-			 "3178 PLOGI confirm: ndlp x%x x%x x%x: "
-			 "new_ndlp x%x x%x x%x\n",
+			 "3178 PLOGI confirm: ndlp x%x x%lx x%x: "
+			 "new_ndlp x%x x%lx x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag,  ndlp->nlp_fc4_type,
 			 (new_ndlp ? new_ndlp->nlp_DID : 0),
 			 (new_ndlp ? new_ndlp->nlp_flag : 0),
@@ -1769,48 +1765,48 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 	new_ndlp->nlp_flag = ndlp->nlp_flag;
 
 	/* if new_ndlp had NLP_UNREG_INP set, keep it */
-	if (keep_new_nlp_flag & NLP_UNREG_INP)
-		new_ndlp->nlp_flag |= NLP_UNREG_INP;
+	if (test_bit(NLP_UNREG_INP, &keep_new_nlp_flag))
+		set_bit(NLP_UNREG_INP, &new_ndlp->nlp_flag);
 	else
-		new_ndlp->nlp_flag &= ~NLP_UNREG_INP;
+		clear_bit(NLP_UNREG_INP, &new_ndlp->nlp_flag);
 
 	/* if new_ndlp had NLP_RPI_REGISTERED set, keep it */
-	if (keep_new_nlp_flag & NLP_RPI_REGISTERED)
-		new_ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	if (test_bit(NLP_RPI_REGISTERED, &keep_new_nlp_flag))
+		set_bit(NLP_RPI_REGISTERED, &new_ndlp->nlp_flag);
 	else
-		new_ndlp->nlp_flag &= ~NLP_RPI_REGISTERED;
+		clear_bit(NLP_RPI_REGISTERED, &new_ndlp->nlp_flag);
 
 	/*
 	 * Retain the DROPPED flag. This will take care of the init
 	 * refcount when affecting the state change
 	 */
-	if (keep_new_nlp_flag & NLP_DROPPED)
-		new_ndlp->nlp_flag |= NLP_DROPPED;
+	if (test_bit(NLP_DROPPED, &keep_new_nlp_flag))
+		set_bit(NLP_DROPPED, &new_ndlp->nlp_flag);
 	else
-		new_ndlp->nlp_flag &= ~NLP_DROPPED;
+		clear_bit(NLP_DROPPED, &new_ndlp->nlp_flag);
 
 	ndlp->nlp_flag = keep_new_nlp_flag;
 
 	/* if ndlp had NLP_UNREG_INP set, keep it */
-	if (keep_nlp_flag & NLP_UNREG_INP)
-		ndlp->nlp_flag |= NLP_UNREG_INP;
+	if (test_bit(NLP_UNREG_INP, &keep_nlp_flag))
+		set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 	else
-		ndlp->nlp_flag &= ~NLP_UNREG_INP;
+		clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 
 	/* if ndlp had NLP_RPI_REGISTERED set, keep it */
-	if (keep_nlp_flag & NLP_RPI_REGISTERED)
-		ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	if (test_bit(NLP_RPI_REGISTERED, &keep_nlp_flag))
+		set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	else
-		ndlp->nlp_flag &= ~NLP_RPI_REGISTERED;
+		clear_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 
 	/*
 	 * Retain the DROPPED flag. This will take care of the init
 	 * refcount when affecting the state change
 	 */
-	if (keep_nlp_flag & NLP_DROPPED)
-		ndlp->nlp_flag |= NLP_DROPPED;
+	if (test_bit(NLP_DROPPED, &keep_nlp_flag))
+		set_bit(NLP_DROPPED, &ndlp->nlp_flag);
 	else
-		ndlp->nlp_flag &= ~NLP_DROPPED;
+		clear_bit(NLP_DROPPED, &ndlp->nlp_flag);
 
 	spin_unlock_irq(&new_ndlp->lock);
 	spin_unlock_irq(&ndlp->lock);
@@ -1888,7 +1884,7 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 			     phba->active_rrq_pool);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_NODE,
-			 "3173 PLOGI confirm exit: new_ndlp x%x x%x x%x\n",
+			 "3173 PLOGI confirm exit: new_ndlp x%x x%lx x%x\n",
 			 new_ndlp->nlp_DID, new_ndlp->nlp_flag,
 			 new_ndlp->nlp_fc4_type);
 
@@ -2009,7 +2005,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp, *free_ndlp;
 	struct lpfc_dmabuf *prsp;
-	int disc;
+	bool disc;
 	struct serv_parm *sp = NULL;
 	u32 ulp_status, ulp_word4, did, iotag;
 	bool release_node = false;
@@ -2044,10 +2040,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* Since ndlp can be freed in the disc state machine, note if this node
 	 * is being used during discovery.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	disc = (ndlp->nlp_flag & NLP_NPR_2B_DISC);
-	ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-	spin_unlock_irq(&ndlp->lock);
+	disc = test_and_clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 	/* PLOGI completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
@@ -2060,9 +2053,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Check to see if link went down during discovery */
 	if (lpfc_els_chk_latt(vport)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		goto out;
 	}
 
@@ -2070,11 +2061,8 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Check for retry */
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb)) {
 			/* ELS command is being retried */
-			if (disc) {
-				spin_lock_irq(&ndlp->lock);
-				ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-				spin_unlock_irq(&ndlp->lock);
-			}
+			if (disc)
+				set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			goto out;
 		}
 		/* Warn PLOGI status Don't print the vport to vport rjts */
@@ -2097,7 +2085,8 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * with the reglogin process.
 		 */
 		spin_lock_irq(&ndlp->lock);
-		if ((ndlp->nlp_flag & (NLP_ACC_REGLOGIN | NLP_RCV_PLOGI)) &&
+		if ((test_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag) ||
+		     test_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag)) &&
 		    ndlp->nlp_state == NLP_STE_REG_LOGIN_ISSUE) {
 			spin_unlock_irq(&ndlp->lock);
 			goto out;
@@ -2108,8 +2097,8 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * start the device remove process.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+			if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 				release_node = true;
 		}
 		spin_unlock_irq(&ndlp->lock);
@@ -2212,12 +2201,13 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
 	 * outstanding UNREG_RPI mbox command completes, unless we
 	 * are going offline. This logic does not apply for Fabric DIDs
 	 */
-	if ((ndlp->nlp_flag & (NLP_IGNR_REG_CMPL | NLP_UNREG_INP)) &&
+	if ((test_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag) ||
+	     test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) &&
 	    ((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
 	    !test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "4110 Issue PLOGI x%x deferred "
-				 "on NPort x%x rpi x%x flg x%x Data:"
+				 "on NPort x%x rpi x%x flg x%lx Data:"
 				 " x%px\n",
 				 ndlp->nlp_defer_did, ndlp->nlp_DID,
 				 ndlp->nlp_rpi, ndlp->nlp_flag, ndlp);
@@ -2335,10 +2325,10 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 	ulp_word4 = get_job_word4(phba, rspiocb);
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_PRLI_SND;
+	clear_bit(NLP_PRLI_SND, &ndlp->nlp_flag);
 
 	/* Driver supports multiple FC4 types.  Counters matter. */
+	spin_lock_irq(&ndlp->lock);
 	vport->fc_prli_sent--;
 	ndlp->fc4_prli_sent--;
 	spin_unlock_irq(&ndlp->lock);
@@ -2379,7 +2369,7 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Warn PRLI status */
 		lpfc_printf_vlog(vport, mode, LOG_ELS,
 				 "2754 PRLI DID:%06X Status:x%x/x%x, "
-				 "data: x%x x%x x%x\n",
+				 "data: x%x x%x x%lx\n",
 				 ndlp->nlp_DID, ulp_status,
 				 ulp_word4, ndlp->nlp_state,
 				 ndlp->fc4_prli_sent, ndlp->nlp_flag);
@@ -2396,10 +2386,10 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if ((ndlp->nlp_state >= NLP_STE_PLOGI_ISSUE &&
 		     ndlp->nlp_state <= NLP_STE_REG_LOGIN_ISSUE) ||
 		    (ndlp->nlp_state == NLP_STE_NPR_NODE &&
-		     ndlp->nlp_flag & NLP_DELAY_TMO)) {
-			lpfc_printf_vlog(vport, KERN_WARNING, LOG_NODE,
+		     test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag))) {
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
 					 "2784 PRLI cmpl: Allow Node recovery "
-					 "DID x%06x nstate x%x nflag x%x\n",
+					 "DID x%06x nstate x%x nflag x%lx\n",
 					 ndlp->nlp_DID, ndlp->nlp_state,
 					 ndlp->nlp_flag);
 			goto out;
@@ -2420,8 +2410,8 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
 		    !ndlp->fc4_prli_sent) {
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+			if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 				release_node = true;
 		}
 		spin_unlock_irq(&ndlp->lock);
@@ -2496,7 +2486,8 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_type &= ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
 	ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
 	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-	ndlp->nlp_flag &= ~(NLP_FIRSTBURST | NLP_NPR_2B_DISC);
+	clear_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	ndlp->nvme_fb_size = 0;
 
  send_next_prli:
@@ -2627,8 +2618,8 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * the ndlp is used to track outstanding PRLIs for different
 	 * FC4 types.
 	 */
+	set_bit(NLP_PRLI_SND, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_PRLI_SND;
 	vport->fc_prli_sent++;
 	ndlp->fc4_prli_sent++;
 	spin_unlock_irq(&ndlp->lock);
@@ -2789,7 +2780,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_vport *vport = cmdiocb->vport;
 	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp;
-	int  disc;
+	bool  disc;
 	u32 ulp_status, ulp_word4, tmo, iotag;
 	bool release_node = false;
 
@@ -2818,10 +2809,8 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* Since ndlp can be freed in the disc state machine, note if this node
 	 * is being used during discovery.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	disc = (ndlp->nlp_flag & NLP_NPR_2B_DISC);
-	ndlp->nlp_flag &= ~(NLP_ADISC_SND | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	disc = test_and_clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+	clear_bit(NLP_ADISC_SND, &ndlp->nlp_flag);
 	/* ADISC completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0104 ADISC completes to NPort x%x "
@@ -2832,9 +2821,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Check to see if link went down during discovery */
 	if (lpfc_els_chk_latt(vport)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		goto out;
 	}
 
@@ -2843,9 +2830,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb)) {
 			/* ELS command is being retried */
 			if (disc) {
-				spin_lock_irq(&ndlp->lock);
-				ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-				spin_unlock_irq(&ndlp->lock);
+				set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 				lpfc_set_disctmo(vport);
 			}
 			goto out;
@@ -2864,8 +2849,8 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 */
 		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+			if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 				release_node = true;
 		}
 		spin_unlock_irq(&ndlp->lock);
@@ -2938,9 +2923,7 @@ lpfc_issue_els_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	phba->fc_stat.elsXmitADISC++;
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_adisc;
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_ADISC_SND;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_ADISC_SND, &ndlp->nlp_flag);
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp) {
 		lpfc_els_free_iocb(phba, elsiocb);
@@ -2961,9 +2944,7 @@ lpfc_issue_els_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	return 0;
 
 err:
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_ADISC_SND;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_ADISC_SND, &ndlp->nlp_flag);
 	return 1;
 }
 
@@ -2985,7 +2966,6 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp = cmdiocb->ndlp;
 	struct lpfc_vport *vport = ndlp->vport;
 	IOCB_t *irsp;
-	unsigned long flags;
 	uint32_t skip_recovery = 0;
 	int wake_up_waiter = 0;
 	u32 ulp_status;
@@ -3007,8 +2987,8 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		iotag = irsp->ulpIoTag;
 	}
 
+	clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_LOGO_SND;
 	if (ndlp->save_flags & NLP_WAIT_FOR_LOGO) {
 		wake_up_waiter = 1;
 		ndlp->save_flags &= ~NLP_WAIT_FOR_LOGO;
@@ -3023,7 +3003,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0105 LOGO completes to NPort x%x "
-			 "IoTag x%x refcnt %d nflags x%x xflags x%x "
+			 "IoTag x%x refcnt %d nflags x%lx xflags x%x "
 			 "Data: x%x x%x x%x x%x\n",
 			 ndlp->nlp_DID, iotag,
 			 kref_read(&ndlp->kref), ndlp->nlp_flag,
@@ -3061,10 +3041,8 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* The driver sets this flag for an NPIV instance that doesn't want to
 	 * log into the remote port.
 	 */
-	if (ndlp->nlp_flag & NLP_TARGET_REMOVE) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_TARGET_REMOVE, &ndlp->nlp_flag)) {
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 					NLP_EVT_DEVICE_RM);
 		goto out_rsrc_free;
@@ -3087,9 +3065,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	if (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET) &&
 	    skip_recovery == 0) {
 		lpfc_cancel_retry_delay_tmo(vport, ndlp);
-		spin_lock_irqsave(&ndlp->lock, flags);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irqrestore(&ndlp->lock, flags);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3187 LOGO completes to NPort x%x: Start "
@@ -3111,9 +3087,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	 * register with the transport.
 	 */
 	if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 					NLP_EVT_DEVICE_RM);
 	}
@@ -3154,12 +3128,8 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	uint16_t cmdsize;
 	int rc;
 
-	spin_lock_irq(&ndlp->lock);
-	if (ndlp->nlp_flag & NLP_LOGO_SND) {
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_LOGO_SND, &ndlp->nlp_flag))
 		return 0;
-	}
-	spin_unlock_irq(&ndlp->lock);
 
 	cmdsize = (2 * sizeof(uint32_t)) + sizeof(struct lpfc_name);
 	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
@@ -3178,10 +3148,8 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	phba->fc_stat.elsXmitLOGO++;
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_logo;
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_SND;
-	ndlp->nlp_flag &= ~NLP_ISSUE_LOGO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
+	clear_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp) {
 		lpfc_els_free_iocb(phba, elsiocb);
@@ -3206,9 +3174,7 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	return 0;
 
 err:
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_LOGO_SND;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	return 1;
 }
 
@@ -3284,13 +3250,13 @@ lpfc_cmpl_els_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 static int
 lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 {
-	int rc = 0;
+	int rc;
 	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_nodelist *ns_ndlp;
 	LPFC_MBOXQ_t *mbox;
 
-	if (fc_ndlp->nlp_flag & NLP_RPI_REGISTERED)
-		return rc;
+	if (test_bit(NLP_RPI_REGISTERED, &fc_ndlp->nlp_flag))
+		return 0;
 
 	ns_ndlp = lpfc_findnode_did(vport, NameServer_DID);
 	if (!ns_ndlp)
@@ -3307,7 +3273,7 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 	if (!mbox) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
 				 "0936 %s: no memory for reg_login "
-				 "Data: x%x x%x x%x x%x\n", __func__,
+				 "Data: x%x x%x x%lx x%x\n", __func__,
 				 fc_ndlp->nlp_DID, fc_ndlp->nlp_state,
 				 fc_ndlp->nlp_flag, fc_ndlp->nlp_rpi);
 		return -ENOMEM;
@@ -3319,7 +3285,7 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 		goto out;
 	}
 
-	fc_ndlp->nlp_flag |= NLP_REG_LOGIN_SEND;
+	set_bit(NLP_REG_LOGIN_SEND, &fc_ndlp->nlp_flag);
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_fc_reg_login;
 	mbox->ctx_ndlp = lpfc_nlp_get(fc_ndlp);
 	if (!mbox->ctx_ndlp) {
@@ -3343,7 +3309,7 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 	lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
 			 "0938 %s: failed to format reg_login "
-			 "Data: x%x x%x x%x x%x\n", __func__,
+			 "Data: x%x x%x x%lx x%x\n", __func__,
 			 fc_ndlp->nlp_DID, fc_ndlp->nlp_state,
 			 fc_ndlp->nlp_flag, fc_ndlp->nlp_rpi);
 	return rc;
@@ -4382,11 +4348,8 @@ lpfc_cancel_retry_delay_tmo(struct lpfc_vport *vport, struct lpfc_nodelist *nlp)
 {
 	struct lpfc_work_evt *evtp;
 
-	if (!(nlp->nlp_flag & NLP_DELAY_TMO))
+	if (!test_and_clear_bit(NLP_DELAY_TMO, &nlp->nlp_flag))
 		return;
-	spin_lock_irq(&nlp->lock);
-	nlp->nlp_flag &= ~NLP_DELAY_TMO;
-	spin_unlock_irq(&nlp->lock);
 	del_timer_sync(&nlp->nlp_delayfunc);
 	nlp->nlp_last_elscmd = 0;
 	if (!list_empty(&nlp->els_retry_evt.evt_listp)) {
@@ -4395,10 +4358,7 @@ lpfc_cancel_retry_delay_tmo(struct lpfc_vport *vport, struct lpfc_nodelist *nlp)
 		evtp = &nlp->els_retry_evt;
 		lpfc_nlp_put((struct lpfc_nodelist *)evtp->evt_arg1);
 	}
-	if (nlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&nlp->lock);
-		nlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-		spin_unlock_irq(&nlp->lock);
+	if (test_and_clear_bit(NLP_NPR_2B_DISC, &nlp->nlp_flag)) {
 		if (vport->num_disc_nodes) {
 			if (vport->port_state < LPFC_VPORT_READY) {
 				/* Check if there are more ADISCs to be sent */
@@ -4478,14 +4438,11 @@ lpfc_els_retry_delay_handler(struct lpfc_nodelist *ndlp)
 	spin_lock_irq(&ndlp->lock);
 	cmd = ndlp->nlp_last_elscmd;
 	ndlp->nlp_last_elscmd = 0;
+	spin_unlock_irq(&ndlp->lock);
 
-	if (!(ndlp->nlp_flag & NLP_DELAY_TMO)) {
-		spin_unlock_irq(&ndlp->lock);
+	if (!test_and_clear_bit(NLP_DELAY_TMO, &ndlp->nlp_flag))
 		return;
-	}
 
-	ndlp->nlp_flag &= ~NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
 	/*
 	 * If a discovery event readded nlp_delayfunc after timer
 	 * firing and before processing the timer, cancel the
@@ -5008,9 +4965,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			/* delay is specified in milliseconds */
 			mod_timer(&ndlp->nlp_delayfunc,
 				jiffies + msecs_to_jiffies(delay));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 
 			ndlp->nlp_prev_state = ndlp->nlp_state;
 			if ((cmd == ELS_CMD_PRLI) ||
@@ -5070,7 +5025,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "0108 No retry ELS command x%x to remote "
 				 "NPORT x%x Retried:%d Error:x%x/%x "
-				 "IoTag x%x nflags x%x\n",
+				 "IoTag x%x nflags x%lx\n",
 				 cmd, did, cmdiocb->retry, ulp_status,
 				 ulp_word4, cmdiocb->iotag,
 				 (ndlp ? ndlp->nlp_flag : 0));
@@ -5237,7 +5192,7 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* ACC to LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0109 ACC to LOGO completes to NPort x%x refcnt %d "
-			 "last els x%x Data: x%x x%x x%x\n",
+			 "last els x%x Data: x%lx x%x x%x\n",
 			 ndlp->nlp_DID, kref_read(&ndlp->kref),
 			 ndlp->nlp_last_elscmd, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -5252,16 +5207,14 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto out;
 
 	if (ndlp->nlp_state == NLP_STE_NPR_NODE) {
-		if (ndlp->nlp_flag & NLP_RPI_REGISTERED)
+		if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag))
 			lpfc_unreg_rpi(vport, ndlp);
 
 		/* If came from PRLO, then PRLO_ACC is done.
 		 * Start rediscovery now.
 		 */
 		if (ndlp->nlp_last_elscmd == ELS_CMD_PRLO) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			ndlp->nlp_prev_state = ndlp->nlp_state;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -5298,7 +5251,7 @@ lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (ndlp) {
 		lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-				 "0006 rpi x%x DID:%x flg:%x %d x%px "
+				 "0006 rpi x%x DID:%x flg:%lx %d x%px "
 				 "mbx_cmd x%x mbx_flag x%x x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 				 kref_read(&ndlp->kref), ndlp, mbx_cmd,
@@ -5309,11 +5262,9 @@ lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * first on an UNREG_LOGIN and then release the final
 		 * references.
 		 */
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+		clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 		if (mbx_cmd == MBX_UNREG_LOGIN)
-			ndlp->nlp_flag &= ~NLP_UNREG_INP;
-		spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 		lpfc_nlp_put(ndlp);
 		lpfc_drop_node(ndlp->vport, ndlp);
 	}
@@ -5379,23 +5330,23 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* ELS response tag <ulpIoTag> completes */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0110 ELS response tag x%x completes "
-			 "Data: x%x x%x x%x x%x x%x x%x x%x x%x %p %p\n",
+			 "Data: x%x x%x x%x x%x x%lx x%x x%x x%x %p %p\n",
 			 iotag, ulp_status, ulp_word4, tmo,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi, kref_read(&ndlp->kref), mbox, ndlp);
 	if (mbox) {
-		if (ulp_status == 0
-		    && (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
+		if (ulp_status == 0 &&
+		    test_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag)) {
 			if (!lpfc_unreg_rpi(vport, ndlp) &&
 			    !test_bit(FC_PT2PT, &vport->fc_flag)) {
-				if (ndlp->nlp_state ==  NLP_STE_PLOGI_ISSUE ||
+				if (ndlp->nlp_state == NLP_STE_PLOGI_ISSUE ||
 				    ndlp->nlp_state ==
 				     NLP_STE_REG_LOGIN_ISSUE) {
 					lpfc_printf_vlog(vport, KERN_INFO,
 							 LOG_DISCOVERY,
 							 "0314 PLOGI recov "
 							 "DID x%x "
-							 "Data: x%x x%x x%x\n",
+							 "Data: x%x x%x x%lx\n",
 							 ndlp->nlp_DID,
 							 ndlp->nlp_state,
 							 ndlp->nlp_rpi,
@@ -5412,18 +5363,17 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				goto out_free_mbox;
 
 			mbox->vport = vport;
-			if (ndlp->nlp_flag & NLP_RM_DFLT_RPI) {
+			if (test_bit(NLP_RM_DFLT_RPI, &ndlp->nlp_flag)) {
 				mbox->mbox_flag |= LPFC_MBX_IMED_UNREG;
 				mbox->mbox_cmpl = lpfc_mbx_cmpl_dflt_rpi;
-			}
-			else {
+			} else {
 				mbox->mbox_cmpl = lpfc_mbx_cmpl_reg_login;
 				ndlp->nlp_prev_state = ndlp->nlp_state;
 				lpfc_nlp_set_state(vport, ndlp,
 					   NLP_STE_REG_LOGIN_ISSUE);
 			}
 
-			ndlp->nlp_flag |= NLP_REG_LOGIN_SEND;
+			set_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT)
 			    != MBX_NOT_FINISHED)
 				goto out;
@@ -5432,12 +5382,12 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 * set for this failed mailbox command.
 			 */
 			lpfc_nlp_put(ndlp);
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+			clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 
 			/* ELS rsp: Cannot issue reg_login for <NPortid> */
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0138 ELS rsp: Cannot issue reg_login for x%x "
-				"Data: x%x x%x x%x\n",
+				"Data: x%lx x%x x%x\n",
 				ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 				ndlp->nlp_rpi);
 		}
@@ -5446,11 +5396,9 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 out:
 	if (ndlp && shost) {
-		spin_lock_irq(&ndlp->lock);
 		if (mbox)
-			ndlp->nlp_flag &= ~NLP_ACC_REGLOGIN;
-		ndlp->nlp_flag &= ~NLP_RM_DFLT_RPI;
-		spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
+		clear_bit(NLP_RM_DFLT_RPI, &ndlp->nlp_flag);
 	}
 
 	/* An SLI4 NPIV instance wants to drop the node at this point under
@@ -5528,9 +5476,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize, oldiocb->retry,
 					     ndlp, ndlp->nlp_DID, ELS_CMD_ACC);
 		if (!elsiocb) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_LOGO_ACC;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 			return 1;
 		}
 
@@ -5558,7 +5504,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		pcmd += sizeof(uint32_t);
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			"Issue ACC:       did:x%x flg:x%x",
+			"Issue ACC:       did:x%x flg:x%lx",
 			ndlp->nlp_DID, ndlp->nlp_flag, 0);
 		break;
 	case ELS_CMD_FLOGI:
@@ -5637,7 +5583,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		}
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			"Issue ACC FLOGI/PLOGI: did:x%x flg:x%x",
+			"Issue ACC FLOGI/PLOGI: did:x%x flg:x%lx",
 			ndlp->nlp_DID, ndlp->nlp_flag, 0);
 		break;
 	case ELS_CMD_PRLO:
@@ -5675,7 +5621,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		els_pkt_ptr->un.prlo.acceptRspCode = PRLO_REQ_EXECUTED;
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			"Issue ACC PRLO:  did:x%x flg:x%x",
+			"Issue ACC PRLO:  did:x%x flg:x%lx",
 			ndlp->nlp_DID, ndlp->nlp_flag, 0);
 		break;
 	case ELS_CMD_RDF:
@@ -5720,12 +5666,10 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 	default:
 		return 1;
 	}
-	if (ndlp->nlp_flag & NLP_LOGO_ACC) {
-		spin_lock_irq(&ndlp->lock);
-		if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED ||
-			ndlp->nlp_flag & NLP_REG_LOGIN_SEND))
-			ndlp->nlp_flag &= ~NLP_LOGO_ACC;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_LOGO_ACC, &ndlp->nlp_flag)) {
+		if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag) &&
+		    !test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag))
+			clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 		elsiocb->cmd_cmpl = lpfc_cmpl_els_logo_acc;
 	} else {
 		elsiocb->cmd_cmpl = lpfc_cmpl_els_rsp;
@@ -5748,7 +5692,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 	/* Xmit ELS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0128 Xmit ELS ACC response Status: x%x, IoTag: x%x, "
-			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
+			 "XRI: x%x, DID: x%x, nlp_flag: x%lx nlp_state: x%x "
 			 "RPI: x%x, fc_flag x%lx refcnt %d\n",
 			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -5823,13 +5767,13 @@ lpfc_els_rsp_reject(struct lpfc_vport *vport, uint32_t rejectError,
 	/* Xmit ELS RJT <err> response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0129 Xmit ELS RJT x%x response tag x%x "
-			 "xri x%x, did x%x, nlp_flag x%x, nlp_state x%x, "
+			 "xri x%x, did x%x, nlp_flag x%lx, nlp_state x%x, "
 			 "rpi x%x\n",
 			 rejectError, elsiocb->iotag,
 			 get_job_ulpcontext(phba, elsiocb), ndlp->nlp_DID,
 			 ndlp->nlp_flag, ndlp->nlp_state, ndlp->nlp_rpi);
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Issue LS_RJT:    did:x%x flg:x%x err:x%x",
+		"Issue LS_RJT:    did:x%x flg:x%lx err:x%x",
 		ndlp->nlp_DID, ndlp->nlp_flag, rejectError);
 
 	phba->fc_stat.elsXmitLSRJT++;
@@ -5920,7 +5864,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		lpfc_format_edc_lft_desc(phba, tlv);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			      "Issue EDC ACC:      did:x%x flg:x%x refcnt %d",
+			      "Issue EDC ACC:      did:x%x flg:x%lx refcnt %d",
 			      ndlp->nlp_DID, ndlp->nlp_flag,
 			      kref_read(&ndlp->kref));
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_rsp;
@@ -5942,7 +5886,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	/* Xmit ELS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0152 Xmit EDC ACC response Status: x%x, IoTag: x%x, "
-			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
+			 "XRI: x%x, DID: x%x, nlp_flag: x%lx nlp_state: x%x "
 			 "RPI: x%x, fc_flag x%lx\n",
 			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -6011,7 +5955,7 @@ lpfc_els_rsp_adisc_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	/* Xmit ADISC ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0130 Xmit ADISC ACC response iotag x%x xri: "
-			 "x%x, did x%x, nlp_flag x%x, nlp_state x%x rpi x%x\n",
+			 "x%x, did x%x, nlp_flag x%lx, nlp_state x%x rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -6027,7 +5971,7 @@ lpfc_els_rsp_adisc_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	ap->DID = be32_to_cpu(vport->fc_myDID);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC ADISC: did:x%x flg:x%x refcnt %d",
+		      "Issue ACC ADISC: did:x%x flg:x%lx refcnt %d",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6133,7 +6077,7 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	/* Xmit PRLI ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0131 Xmit PRLI ACC response tag x%x xri x%x, "
-			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x\n",
+			 "did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -6204,7 +6148,7 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 				 "6015 NVME issue PRLI ACC word1 x%08x "
-				 "word4 x%08x word5 x%08x flag x%x, "
+				 "word4 x%08x word5 x%08x flag x%lx, "
 				 "fcp_info x%x nlp_type x%x\n",
 				 npr_nvme->word1, npr_nvme->word4,
 				 npr_nvme->word5, ndlp->nlp_flag,
@@ -6219,7 +6163,7 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 				 ndlp->nlp_DID);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC PRLI:  did:x%x flg:x%x",
+		      "Issue ACC PRLI:  did:x%x flg:x%lx",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6333,7 +6277,7 @@ lpfc_els_rsp_rnid_acc(struct lpfc_vport *vport, uint8_t format,
 	}
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC RNID:  did:x%x flg:x%x refcnt %d",
+		      "Issue ACC RNID:  did:x%x flg:x%lx refcnt %d",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6390,7 +6334,7 @@ lpfc_els_clear_rrq(struct lpfc_vport *vport,
 			get_job_ulpcontext(phba, iocb));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Clear RRQ:  did:x%x flg:x%x exchg:x%.08x",
+		"Clear RRQ:  did:x%x flg:x%lx exchg:x%.08x",
 		ndlp->nlp_DID, ndlp->nlp_flag, rrq->rrq_exchg);
 	if (vport->fc_myDID == be32_to_cpu(bf_get(rrq_did, rrq)))
 		xri = bf_get(rrq_oxid, rrq);
@@ -6467,7 +6411,7 @@ lpfc_els_rsp_echo_acc(struct lpfc_vport *vport, uint8_t *data,
 	memcpy(pcmd, data, cmdsize - sizeof(uint32_t));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC ECHO:  did:x%x flg:x%x refcnt %d",
+		      "Issue ACC ECHO:  did:x%x flg:x%lx refcnt %d",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6517,14 +6461,12 @@ lpfc_els_disc_adisc(struct lpfc_vport *vport)
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 
 		if (ndlp->nlp_state != NLP_STE_NPR_NODE ||
-		    !(ndlp->nlp_flag & NLP_NPR_ADISC))
+		    !test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag))
 			continue;
 
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 
-		if (!(ndlp->nlp_flag & NLP_NPR_2B_DISC)) {
+		if (!test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 			/* This node was marked for ADISC but was not picked
 			 * for discovery. This is possible if the node was
 			 * missing in gidft response.
@@ -6582,9 +6524,9 @@ lpfc_els_disc_plogi(struct lpfc_vport *vport)
 	/* go thru NPR nodes and issue any remaining ELS PLOGIs */
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 		if (ndlp->nlp_state == NLP_STE_NPR_NODE &&
-				(ndlp->nlp_flag & NLP_NPR_2B_DISC) != 0 &&
-				(ndlp->nlp_flag & NLP_DELAY_TMO) == 0 &&
-				(ndlp->nlp_flag & NLP_NPR_ADISC) == 0) {
+		    test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag) &&
+		    !test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag) &&
+		    !test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = ndlp->nlp_state;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -7080,7 +7022,7 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			"2171 Xmit RDP response tag x%x xri x%x, "
-			"did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x",
+			"did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x",
 			elsiocb->iotag, ulp_context,
 			ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			ndlp->nlp_rpi);
@@ -8054,7 +7996,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	 */
 	if (vport->port_state <= LPFC_NS_QRY) {
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RSCN ignore: did:x%x/ste:x%x flg:x%x",
+			"RCV RSCN ignore: did:x%x/ste:x%x flg:x%lx",
 			ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
 
 		lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
@@ -8084,7 +8026,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 					 vport->fc_flag, payload_len,
 					 *lp, vport->fc_rscn_id_cnt);
 			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-				"RCV RSCN vport:  did:x%x/ste:x%x flg:x%x",
+				"RCV RSCN vport:  did:x%x/ste:x%x flg:x%lx",
 				ndlp->nlp_DID, vport->port_state,
 				ndlp->nlp_flag);
 
@@ -8121,7 +8063,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	if (test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
 	    test_bit(FC_NDISC_ACTIVE, &vport->fc_flag)) {
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RSCN defer:  did:x%x/ste:x%x flg:x%x",
+			"RCV RSCN defer:  did:x%x/ste:x%x flg:x%lx",
 			ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
 
 		set_bit(FC_RSCN_DEFERRED, &vport->fc_flag);
@@ -8177,7 +8119,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		return 0;
 	}
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-		"RCV RSCN:        did:x%x/ste:x%x flg:x%x",
+		"RCV RSCN:        did:x%x/ste:x%x flg:x%lx",
 		ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
 
 	set_bit(FC_RSCN_MODE, &vport->fc_flag);
@@ -8683,7 +8625,7 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	/* Xmit ELS RLS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_ELS,
 			 "2874 Xmit ELS RLS ACC response tag x%x xri x%x, "
-			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x\n",
+			 "did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -8845,7 +8787,7 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	/* Xmit ELS RLS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_ELS,
 			 "2875 Xmit ELS RTV ACC response tag x%x xri x%x, "
-			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x, "
+			 "did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x, "
 			 "Data: x%x x%x x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -9042,7 +8984,7 @@ lpfc_els_rsp_rpl_acc(struct lpfc_vport *vport, uint16_t cmdsize,
 	/* Xmit ELS RPL ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0120 Xmit ELS RPL ACC response tag x%x "
-			 "xri x%x, did x%x, nlp_flag x%x, nlp_state x%x, "
+			 "xri x%x, did x%x, nlp_flag x%lx, nlp_state x%x, "
 			 "rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -10397,14 +10339,11 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	 * Do not process any unsolicited ELS commands
 	 * if the ndlp is in DEV_LOSS
 	 */
-	spin_lock_irq(&ndlp->lock);
-	if (ndlp->nlp_flag & NLP_IN_DEV_LOSS) {
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag)) {
 		if (newnode)
 			lpfc_nlp_put(ndlp);
 		goto dropit;
 	}
-	spin_unlock_irq(&ndlp->lock);
 
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp)
@@ -10433,7 +10372,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	switch (cmd) {
 	case ELS_CMD_PLOGI:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PLOGI:       did:x%x/ste:x%x flg:x%x",
+			"RCV PLOGI:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPLOGI++;
@@ -10472,9 +10411,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			}
 		}
 
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_TARGET_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_TARGET_REMOVE, &ndlp->nlp_flag);
 
 		lpfc_disc_state_machine(vport, ndlp, elsiocb,
 					NLP_EVT_RCV_PLOGI);
@@ -10482,7 +10419,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FLOGI:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FLOGI:       did:x%x/ste:x%x flg:x%x",
+			"RCV FLOGI:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFLOGI++;
@@ -10509,7 +10446,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_LOGO:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV LOGO:        did:x%x/ste:x%x flg:x%x",
+			"RCV LOGO:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvLOGO++;
@@ -10526,7 +10463,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_PRLO:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PRLO:        did:x%x/ste:x%x flg:x%x",
+			"RCV PRLO:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPRLO++;
@@ -10555,7 +10492,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_ADISC:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV ADISC:       did:x%x/ste:x%x flg:x%x",
+			"RCV ADISC:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		lpfc_send_els_event(vport, ndlp, payload);
@@ -10570,7 +10507,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_PDISC:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PDISC:       did:x%x/ste:x%x flg:x%x",
+			"RCV PDISC:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPDISC++;
@@ -10584,7 +10521,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FARPR:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FARPR:       did:x%x/ste:x%x flg:x%x",
+			"RCV FARPR:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFARPR++;
@@ -10592,7 +10529,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FARP:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FARP:        did:x%x/ste:x%x flg:x%x",
+			"RCV FARP:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFARP++;
@@ -10600,7 +10537,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FAN:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FAN:         did:x%x/ste:x%x flg:x%x",
+			"RCV FAN:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFAN++;
@@ -10609,7 +10546,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	case ELS_CMD_PRLI:
 	case ELS_CMD_NVMEPRLI:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PRLI:        did:x%x/ste:x%x flg:x%x",
+			"RCV PRLI:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPRLI++;
@@ -10623,7 +10560,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_LIRR:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV LIRR:        did:x%x/ste:x%x flg:x%x",
+			"RCV LIRR:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvLIRR++;
@@ -10634,7 +10571,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RLS:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RLS:         did:x%x/ste:x%x flg:x%x",
+			"RCV RLS:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRLS++;
@@ -10645,7 +10582,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RPL:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RPL:         did:x%x/ste:x%x flg:x%x",
+			"RCV RPL:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRPL++;
@@ -10656,7 +10593,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RNID:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RNID:        did:x%x/ste:x%x flg:x%x",
+			"RCV RNID:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRNID++;
@@ -10667,7 +10604,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RTV:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RTV:        did:x%x/ste:x%x flg:x%x",
+			"RCV RTV:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 		phba->fc_stat.elsRcvRTV++;
 		lpfc_els_rcv_rtv(vport, elsiocb, ndlp);
@@ -10677,7 +10614,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RRQ:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RRQ:         did:x%x/ste:x%x flg:x%x",
+			"RCV RRQ:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRRQ++;
@@ -10688,7 +10625,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_ECHO:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV ECHO:        did:x%x/ste:x%x flg:x%x",
+			"RCV ECHO:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvECHO++;
@@ -10704,7 +10641,8 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FPIN:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-				      "RCV FPIN:       did:x%x/ste:x%x flg:x%x",
+				      "RCV FPIN:       did:x%x/ste:x%x "
+				      "flg:x%lx",
 				      did, vport->port_state, ndlp->nlp_flag);
 
 		lpfc_els_rcv_fpin(vport, (struct fc_els_fpin *)payload,
@@ -11212,9 +11150,7 @@ lpfc_retry_pport_discovery(struct lpfc_hba *phba)
 		return;
 
 	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000));
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 	ndlp->nlp_last_elscmd = ELS_CMD_FLOGI;
 	phba->pport->port_state = LPFC_FLOGI;
 	return;
@@ -11345,11 +11281,9 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		list_for_each_entry_safe(np, next_np,
 			&vport->fc_nodes, nlp_listp) {
 			if ((np->nlp_state != NLP_STE_NPR_NODE) ||
-			    !(np->nlp_flag & NLP_NPR_ADISC))
+			    !test_bit(NLP_NPR_ADISC, &np->nlp_flag))
 				continue;
-			spin_lock_irq(&ndlp->lock);
-			np->nlp_flag &= ~NLP_NPR_ADISC;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_NPR_ADISC, &np->nlp_flag);
 			lpfc_unreg_rpi(vport, np);
 		}
 		lpfc_cleanup_pending_mbox(vport);
@@ -11552,7 +11486,7 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* NPIV LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "2928 NPIV LOGO completes to NPort x%x "
-			 "Data: x%x x%x x%x x%x x%x x%x x%x\n",
+			 "Data: x%x x%x x%x x%x x%x x%lx x%x\n",
 			 ndlp->nlp_DID, ulp_status, ulp_word4,
 			 tmo, vport->num_disc_nodes,
 			 kref_read(&ndlp->kref), ndlp->nlp_flag,
@@ -11568,8 +11502,9 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Wake up lpfc_vport_delete if waiting...*/
 		if (ndlp->logo_waitq)
 			wake_up(ndlp->logo_waitq);
+		clear_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
+		clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~(NLP_ISSUE_LOGO | NLP_LOGO_SND);
 		ndlp->save_flags &= ~NLP_WAIT_FOR_LOGO;
 		spin_unlock_irq(&ndlp->lock);
 	}
@@ -11619,13 +11554,11 @@ lpfc_issue_els_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	memcpy(pcmd, &vport->fc_portname, sizeof(struct lpfc_name));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
-		"Issue LOGO npiv  did:x%x flg:x%x",
+		"Issue LOGO npiv  did:x%x flg:x%lx",
 		ndlp->nlp_DID, ndlp->nlp_flag, 0);
 
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_npiv_logo;
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_SND;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp) {
 		lpfc_els_free_iocb(phba, elsiocb);
@@ -11641,9 +11574,7 @@ lpfc_issue_els_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	return 0;
 
 err:
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_LOGO_SND;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	return 1;
 }
 
@@ -12124,7 +12055,7 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"3094 Start rport recovery on shost id 0x%x "
 			"fc_id 0x%06x vpi 0x%x rpi 0x%x state 0x%x "
-			"flags 0x%x\n",
+			"flag 0x%lx\n",
 			shost->host_no, ndlp->nlp_DID,
 			vport->vpi, ndlp->nlp_rpi, ndlp->nlp_state,
 			ndlp->nlp_flag);
@@ -12134,8 +12065,8 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 	 */
 	spin_lock_irqsave(&ndlp->lock, flags);
 	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-	ndlp->nlp_flag |= NLP_ISSUE_LOGO;
 	spin_unlock_irqrestore(&ndlp->lock, flags);
+	set_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 	lpfc_unreg_rpi(vport, ndlp);
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index af1fdecf5341..4036a9838bb5 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -143,7 +143,7 @@ lpfc_terminate_rport_io(struct fc_rport *rport)
 	ndlp = rdata->pnode;
 	vport = ndlp->vport;
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-			      "rport terminate: sid:x%x did:x%x flg:x%x",
+			      "rport terminate: sid:x%x did:x%x flg:x%lx",
 			      ndlp->nlp_sid, ndlp->nlp_DID, ndlp->nlp_flag);
 
 	if (ndlp->nlp_sid != NLP_NO_SID)
@@ -171,11 +171,11 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	phba  = vport->phba;
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-		"rport devlosscb: sid:x%x did:x%x flg:x%x",
+		"rport devlosscb: sid:x%x did:x%x flg:x%lx",
 		ndlp->nlp_sid, ndlp->nlp_DID, ndlp->nlp_flag);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			 "3181 dev_loss_callbk x%06x, rport x%px flg x%x "
+			 "3181 dev_loss_callbk x%06x, rport x%px flg x%lx "
 			 "load_flag x%lx refcnt %u state %d xpt x%x\n",
 			 ndlp->nlp_DID, ndlp->rport, ndlp->nlp_flag,
 			 vport->load_flag, kref_read(&ndlp->kref),
@@ -214,18 +214,13 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			spin_unlock_irqrestore(&ndlp->lock, iflags);
 		}
 
-		spin_lock_irqsave(&ndlp->lock, iflags);
-
 		/* Only 1 thread can drop the initial node reference.  If
 		 * another thread has set NLP_DROPPED, this thread is done.
 		 */
-		if (nvme_reg || (ndlp->nlp_flag & NLP_DROPPED)) {
-			spin_unlock_irqrestore(&ndlp->lock, iflags);
+		if (nvme_reg || test_bit(NLP_DROPPED, &ndlp->nlp_flag))
 			return;
-		}
 
-		ndlp->nlp_flag |= NLP_DROPPED;
-		spin_unlock_irqrestore(&ndlp->lock, iflags);
+		set_bit(NLP_DROPPED, &ndlp->nlp_flag);
 		lpfc_nlp_put(ndlp);
 		return;
 	}
@@ -253,14 +248,14 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		return;
 	}
 
-	spin_lock_irqsave(&ndlp->lock, iflags);
-	ndlp->nlp_flag |= NLP_IN_DEV_LOSS;
+	set_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 
+	spin_lock_irqsave(&ndlp->lock, iflags);
 	/* If there is a PLOGI in progress, and we are in a
 	 * NLP_NPR_2B_DISC state, don't turn off the flag.
 	 */
 	if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE)
-		ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 	/*
 	 * The backend does not expect any more calls associated with this
@@ -289,15 +284,13 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	} else {
 		lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
 				 "3188 worker thread is stopped %s x%06x, "
-				 " rport x%px flg x%x load_flag x%lx refcnt "
+				 " rport x%px flg x%lx load_flag x%lx refcnt "
 				 "%d\n", __func__, ndlp->nlp_DID,
 				 ndlp->rport, ndlp->nlp_flag,
 				 vport->load_flag, kref_read(&ndlp->kref));
 		if (!(ndlp->fc4_xpt_flags & NVME_XPT_REGD)) {
-			spin_lock_irqsave(&ndlp->lock, iflags);
 			/* Node is in dev loss.  No further transaction. */
-			ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-			spin_unlock_irqrestore(&ndlp->lock, iflags);
+			clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RM);
 		}
@@ -430,7 +423,7 @@ lpfc_check_nlp_post_devloss(struct lpfc_vport *vport,
 		lpfc_nlp_get(ndlp);
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY | LOG_NODE,
 				 "8438 Devloss timeout reversed on DID x%x "
-				 "refcnt %d ndlp %p flag x%x "
+				 "refcnt %d ndlp %p flag x%lx "
 				 "port_state = x%x\n",
 				 ndlp->nlp_DID, kref_read(&ndlp->kref), ndlp,
 				 ndlp->nlp_flag, vport->port_state);
@@ -473,7 +466,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 			      ndlp->nlp_DID, ndlp->nlp_type, ndlp->nlp_sid);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			 "3182 %s x%06x, nflag x%x xflags x%x refcnt %d\n",
+			 "3182 %s x%06x, nflag x%lx xflags x%x refcnt %d\n",
 			 __func__, ndlp->nlp_DID, ndlp->nlp_flag,
 			 ndlp->fc4_xpt_flags, kref_read(&ndlp->kref));
 
@@ -487,9 +480,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 				 *(name+4), *(name+5), *(name+6), *(name+7),
 				 ndlp->nlp_DID);
 
-		spin_lock_irqsave(&ndlp->lock, iflags);
-		ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-		spin_unlock_irqrestore(&ndlp->lock, iflags);
+		clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 		return fcf_inuse;
 	}
 
@@ -517,7 +508,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 			}
 			break;
 		case Fabric_Cntl_DID:
-			if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
+			if (test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag))
 				recovering = true;
 			break;
 		case FDMI_DID:
@@ -545,15 +536,13 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		 * the following lpfc_nlp_put is necessary after fabric node is
 		 * recovered.
 		 */
-		spin_lock_irqsave(&ndlp->lock, iflags);
-		ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-		spin_unlock_irqrestore(&ndlp->lock, iflags);
+		clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 		if (recovering) {
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_DISCOVERY | LOG_NODE,
 					 "8436 Devloss timeout marked on "
 					 "DID x%x refcnt %d ndlp %p "
-					 "flag x%x port_state = x%x\n",
+					 "flag x%lx port_state = x%x\n",
 					 ndlp->nlp_DID, kref_read(&ndlp->kref),
 					 ndlp, ndlp->nlp_flag,
 					 vport->port_state);
@@ -570,7 +559,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 					 LOG_DISCOVERY | LOG_NODE,
 					 "8437 Devloss timeout ignored on "
 					 "DID x%x refcnt %d ndlp %p "
-					 "flag x%x port_state = x%x\n",
+					 "flag x%lx port_state = x%x\n",
 					 ndlp->nlp_DID, kref_read(&ndlp->kref),
 					 ndlp, ndlp->nlp_flag,
 					 vport->port_state);
@@ -590,7 +579,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0203 Devloss timeout on "
 				 "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
-				 "NPort x%06x Data: x%x x%x x%x refcnt %d\n",
+				 "NPort x%06x Data: x%lx x%x x%x refcnt %d\n",
 				 *name, *(name+1), *(name+2), *(name+3),
 				 *(name+4), *(name+5), *(name+6), *(name+7),
 				 ndlp->nlp_DID, ndlp->nlp_flag,
@@ -600,15 +589,13 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_TRACE_EVENT,
 				 "0204 Devloss timeout on "
 				 "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
-				 "NPort x%06x Data: x%x x%x x%x\n",
+				 "NPort x%06x Data: x%lx x%x x%x\n",
 				 *name, *(name+1), *(name+2), *(name+3),
 				 *(name+4), *(name+5), *(name+6), *(name+7),
 				 ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->nlp_state, ndlp->nlp_rpi);
 	}
-	spin_lock_irqsave(&ndlp->lock, iflags);
-	ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-	spin_unlock_irqrestore(&ndlp->lock, iflags);
+	clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 
 	/* If we are devloss, but we are in the process of rediscovering the
 	 * ndlp, don't issue a NLP_EVT_DEVICE_RM event.
@@ -1373,7 +1360,7 @@ lpfc_linkup_cleanup_nodes(struct lpfc_vport *vport)
 			if (ndlp->nlp_DID != Fabric_DID)
 				lpfc_unreg_rpi(vport, ndlp);
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-		} else if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+		} else if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			/* Fail outstanding IO now since device is
 			 * marked for PLOGI.
 			 */
@@ -3882,14 +3869,13 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	pmb->ctx_ndlp = NULL;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI | LOG_NODE | LOG_DISCOVERY,
-			 "0002 rpi:%x DID:%x flg:%x %d x%px\n",
+			 "0002 rpi:%x DID:%x flg:%lx %d x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp);
-	if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
-		ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+	clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 
-	if (ndlp->nlp_flag & NLP_IGNR_REG_CMPL ||
+	if (test_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag) ||
 	    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
 		/* We rcvd a rscn after issuing this
 		 * mbox reg login, we may have cycled
@@ -3899,16 +3885,14 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * there is another reg login in
 		 * process.
 		 */
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 
 		/*
 		 * We cannot leave the RPI registered because
 		 * if we go thru discovery again for this ndlp
 		 * a subsequent REG_RPI will fail.
 		 */
-		ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+		set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 		lpfc_unreg_rpi(vport, ndlp);
 	}
 
@@ -4221,7 +4205,7 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 
@@ -4352,9 +4336,7 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * reference.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			lpfc_nlp_put(ndlp);
 		}
 
@@ -4375,11 +4357,11 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_DISCOVERY,
-			 "0003 rpi:%x DID:%x flg:%x %d x%px\n",
+			 "0003 rpi:%x DID:%x flg:%lx %d x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp);
@@ -4471,8 +4453,8 @@ lpfc_mbx_cmpl_fc_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			 __func__, ndlp->nlp_DID, ndlp->nlp_rpi,
 			 ndlp->nlp_state);
 
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
-	ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
+	clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 
@@ -4506,7 +4488,7 @@ lpfc_register_remote_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-			      "rport add:       did:x%x flg:x%x type x%x",
+			      "rport add:       did:x%x flg:x%lx type x%x",
 			      ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	/* Don't add the remote port if unloading. */
@@ -4574,7 +4556,7 @@ lpfc_unregister_remote_port(struct lpfc_nodelist *ndlp)
 		return;
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-		"rport delete:    did:x%x flg:x%x type x%x",
+		"rport delete:    did:x%x flg:x%lx type x%x",
 		ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
@@ -4690,7 +4672,7 @@ lpfc_nlp_unreg_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_INFO,
 				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
 				 "0999 %s Not regd: ndlp x%px rport x%px DID "
-				 "x%x FLG x%x XPT x%x\n",
+				 "x%x FLG x%lx XPT x%x\n",
 				  __func__, ndlp, ndlp->rport, ndlp->nlp_DID,
 				  ndlp->nlp_flag, ndlp->fc4_xpt_flags);
 		return;
@@ -4706,7 +4688,7 @@ lpfc_nlp_unreg_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	} else if (!ndlp->rport) {
 		lpfc_printf_vlog(vport, KERN_INFO,
 				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
-				 "1999 %s NDLP in devloss x%px DID x%x FLG x%x"
+				 "1999 %s NDLP in devloss x%px DID x%x FLG x%lx"
 				 " XPT x%x refcnt %u\n",
 				 __func__, ndlp, ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->fc4_xpt_flags,
@@ -4751,7 +4733,7 @@ lpfc_handle_adisc_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		ndlp->nlp_type |= NLP_FC_NODE;
 		fallthrough;
 	case NLP_STE_MAPPED_NODE:
-		ndlp->nlp_flag &= ~NLP_NODEV_REMOVE;
+		clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		lpfc_nlp_reg_node(vport, ndlp);
 		break;
 
@@ -4762,7 +4744,7 @@ lpfc_handle_adisc_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * backend, attempt it now
 	 */
 	case NLP_STE_NPR_NODE:
-		ndlp->nlp_flag &= ~NLP_RCV_PLOGI;
+		clear_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 		fallthrough;
 	default:
 		lpfc_nlp_unreg_node(vport, ndlp);
@@ -4783,13 +4765,13 @@ lpfc_nlp_state_cleanup(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 
 	if (new_state == NLP_STE_UNMAPPED_NODE) {
-		ndlp->nlp_flag &= ~NLP_NODEV_REMOVE;
+		clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		ndlp->nlp_type |= NLP_FC_NODE;
 	}
 	if (new_state == NLP_STE_MAPPED_NODE)
-		ndlp->nlp_flag &= ~NLP_NODEV_REMOVE;
+		clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 	if (new_state == NLP_STE_NPR_NODE)
-		ndlp->nlp_flag &= ~NLP_RCV_PLOGI;
+		clear_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 
 	/* Reg/Unreg for FCP and NVME Transport interface */
 	if ((old_state == NLP_STE_MAPPED_NODE ||
@@ -4797,7 +4779,7 @@ lpfc_nlp_state_cleanup(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		/* For nodes marked for ADISC, Handle unreg in ADISC cmpl
 		 * if linkup. In linkdown do unreg_node
 		 */
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC) ||
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag) ||
 		    !lpfc_is_link_up(vport->phba))
 			lpfc_nlp_unreg_node(vport, ndlp);
 	}
@@ -4817,9 +4799,7 @@ lpfc_nlp_state_cleanup(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	    (!ndlp->rport ||
 	     ndlp->rport->scsi_target_id == -1 ||
 	     ndlp->rport->scsi_target_id >= LPFC_MAX_TARGET)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_TGT_NO_SCSIID;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_TGT_NO_SCSIID, &ndlp->nlp_flag);
 		lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	}
 }
@@ -4851,7 +4831,7 @@ lpfc_nlp_set_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		   int state)
 {
 	int  old_state = ndlp->nlp_state;
-	int node_dropped = ndlp->nlp_flag & NLP_DROPPED;
+	bool node_dropped = test_bit(NLP_DROPPED, &ndlp->nlp_flag);
 	char name1[16], name2[16];
 	unsigned long iflags;
 
@@ -4867,7 +4847,7 @@ lpfc_nlp_set_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	if (node_dropped && old_state == NLP_STE_UNUSED_NODE &&
 	    state != NLP_STE_UNUSED_NODE) {
-		ndlp->nlp_flag &= ~NLP_DROPPED;
+		clear_bit(NLP_DROPPED, &ndlp->nlp_flag);
 		lpfc_nlp_get(ndlp);
 	}
 
@@ -4875,7 +4855,7 @@ lpfc_nlp_set_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	    state != NLP_STE_NPR_NODE)
 		lpfc_cancel_retry_delay_tmo(vport, ndlp);
 	if (old_state == NLP_STE_UNMAPPED_NODE) {
-		ndlp->nlp_flag &= ~NLP_TGT_NO_SCSIID;
+		clear_bit(NLP_TGT_NO_SCSIID, &ndlp->nlp_flag);
 		ndlp->nlp_type &= ~NLP_FC_NODE;
 	}
 
@@ -4972,14 +4952,8 @@ lpfc_drop_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	 * reference from lpfc_nlp_init.  If set, don't drop it again and
 	 * introduce an imbalance.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	if (!(ndlp->nlp_flag & NLP_DROPPED)) {
-		ndlp->nlp_flag |= NLP_DROPPED;
-		spin_unlock_irq(&ndlp->lock);
+	if (!test_and_set_bit(NLP_DROPPED, &ndlp->nlp_flag))
 		lpfc_nlp_put(ndlp);
-		return;
-	}
-	spin_unlock_irq(&ndlp->lock);
 }
 
 /*
@@ -5094,9 +5068,9 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 	} else if (pring->ringno == LPFC_FCP_RING) {
 		/* Skip match check if waiting to relogin to FCP target */
 		if ((ndlp->nlp_type & NLP_FCP_TARGET) &&
-		    (ndlp->nlp_flag & NLP_DELAY_TMO)) {
+		    test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag))
 			return 0;
-		}
+
 		if (ulp_context == ndlp->nlp_rpi)
 			return 1;
 	}
@@ -5166,7 +5140,7 @@ lpfc_no_rpi(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	 * Everything that matches on txcmplq will be returned
 	 * by firmware with a no rpi error.
 	 */
-	if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+	if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
 		if (phba->sli_rev != LPFC_SLI_REV4)
 			lpfc_sli3_dequeue_nport_iocbs(phba, ndlp, &completions);
 		else
@@ -5200,21 +5174,19 @@ lpfc_nlp_logo_unreg(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lpfc_issue_els_logo(vport, ndlp, 0);
 
 	/* Check to see if there are any deferred events to process */
-	if ((ndlp->nlp_flag & NLP_UNREG_INP) &&
-	    (ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING)) {
+	if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag) &&
+	    ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1434 UNREG cmpl deferred logo x%x "
 				 "on NPort x%x Data: x%x x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_defer_did, ndlp);
 
-		ndlp->nlp_flag &= ~NLP_UNREG_INP;
+		clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 		ndlp->nlp_defer_did = NLP_EVT_NOTHING_PENDING;
 		lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
 	} else {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_UNREG_INP;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 	}
 
 	/* The node has an outstanding reference for the unreg. Now
@@ -5241,9 +5213,8 @@ lpfc_set_unreg_login_mbx_cmpl(struct lpfc_hba *phba, struct lpfc_vport *vport,
 	if (!mbox->ctx_ndlp)
 		return;
 
-	if (ndlp->nlp_flag & NLP_ISSUE_LOGO) {
+	if (test_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag)) {
 		mbox->mbox_cmpl = lpfc_nlp_logo_unreg;
-
 	} else if (phba->sli_rev == LPFC_SLI_REV4 &&
 		   !test_bit(FC_UNLOADING, &vport->load_flag) &&
 		    (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
@@ -5272,13 +5243,13 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	int rc, acc_plogi = 1;
 	uint16_t rpi;
 
-	if (ndlp->nlp_flag & NLP_RPI_REGISTERED ||
-	    ndlp->nlp_flag & NLP_REG_LOGIN_SEND) {
-		if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
+	if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag) ||
+	    test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag)) {
+		if (test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag))
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "3366 RPI x%x needs to be "
-					 "unregistered nlp_flag x%x "
+					 "unregistered nlp_flag x%lx "
 					 "did x%x\n",
 					 ndlp->nlp_rpi, ndlp->nlp_flag,
 					 ndlp->nlp_DID);
@@ -5286,11 +5257,11 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		/* If there is already an UNREG in progress for this ndlp,
 		 * no need to queue up another one.
 		 */
-		if (ndlp->nlp_flag & NLP_UNREG_INP) {
+		if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) {
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "1436 unreg_rpi SKIP UNREG x%x on "
-					 "NPort x%x deferred x%x  flg x%x "
+					 "NPort x%x deferred x%x flg x%lx "
 					 "Data: x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_defer_did,
@@ -5318,19 +5289,19 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				acc_plogi = 0;
 
 			if (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag))
-				ndlp->nlp_flag |= NLP_UNREG_INP;
+				set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "1433 unreg_rpi UNREG x%x on "
-					 "NPort x%x deferred flg x%x "
+					 "NPort x%x deferred flg x%lx "
 					 "Data:x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp);
 
 			rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 			if (rc == MBX_NOT_FINISHED) {
-				ndlp->nlp_flag &= ~NLP_UNREG_INP;
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				mempool_free(mbox, phba->mbox_mem_pool);
 				acc_plogi = 1;
 				lpfc_nlp_put(ndlp);
@@ -5340,7 +5311,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 					 LOG_NODE | LOG_DISCOVERY,
 					 "1444 Failed to allocate mempool "
 					 "unreg_rpi UNREG x%x, "
-					 "DID x%x, flag x%x, "
+					 "DID x%x, flag x%lx, "
 					 "ndlp x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp);
@@ -5350,7 +5321,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 			 * not unloading.
 			 */
 			if (!test_bit(FC_UNLOADING, &vport->load_flag)) {
-				ndlp->nlp_flag &= ~NLP_UNREG_INP;
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				lpfc_issue_els_logo(vport, ndlp, 0);
 				ndlp->nlp_prev_state = ndlp->nlp_state;
 				lpfc_nlp_set_state(vport, ndlp,
@@ -5363,13 +5334,13 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 out:
 		if (phba->sli_rev != LPFC_SLI_REV4)
 			ndlp->nlp_rpi = 0;
-		ndlp->nlp_flag &= ~NLP_RPI_REGISTERED;
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
+		clear_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 		if (acc_plogi)
-			ndlp->nlp_flag &= ~NLP_LOGO_ACC;
+			clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 		return 1;
 	}
-	ndlp->nlp_flag &= ~NLP_LOGO_ACC;
+	clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	return 0;
 }
 
@@ -5397,7 +5368,7 @@ lpfc_unreg_hba_rpis(struct lpfc_hba *phba)
 	for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 		spin_lock_irqsave(&vports[i]->fc_nodes_list_lock, iflags);
 		list_for_each_entry(ndlp, &vports[i]->fc_nodes, nlp_listp) {
-			if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+			if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
 				/* The mempool_alloc might sleep */
 				spin_unlock_irqrestore(&vports[i]->fc_nodes_list_lock,
 						       iflags);
@@ -5485,7 +5456,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	/* Cleanup node for NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
 			 "0900 Cleanup node for NPort x%x "
-			 "Data: x%x x%x x%x\n",
+			 "Data: x%lx x%x x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag,
 			 ndlp->nlp_state, ndlp->nlp_rpi);
 	lpfc_dequeue_node(vport, ndlp);
@@ -5530,9 +5501,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
 	lpfc_els_abort(phba, ndlp);
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 
 	ndlp->nlp_last_elscmd = 0;
 	del_timer_sync(&ndlp->nlp_delayfunc);
@@ -5614,7 +5583,7 @@ __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 				 );
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE_VERBOSE,
 					 "0929 FIND node DID "
-					 "Data: x%px x%x x%x x%x x%x x%px\n",
+					 "Data: x%px x%x x%lx x%x x%x x%px\n",
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1, ndlp->nlp_rpi,
 					 ndlp->active_rrqs_xri_bitmap);
@@ -5661,7 +5630,7 @@ lpfc_findnode_mapped(struct lpfc_vport *vport)
 					       iflags);
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE_VERBOSE,
 					 "2025 FIND node DID MAPPED "
-					 "Data: x%px x%x x%x x%x x%px\n",
+					 "Data: x%px x%x x%lx x%x x%px\n",
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1,
 					 ndlp->active_rrqs_xri_bitmap);
@@ -5695,13 +5664,11 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "6453 Setup New Node 2B_DISC x%x "
-				 "Data:x%x x%x x%lx\n",
+				 "Data:x%lx x%x x%lx\n",
 				 ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->nlp_state, vport->fc_flag);
 
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		return ndlp;
 	}
 
@@ -5720,7 +5687,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "6455 Setup RSCN Node 2B_DISC x%x "
-					 "Data:x%x x%x x%lx\n",
+					 "Data:x%lx x%x x%lx\n",
 					 ndlp->nlp_DID, ndlp->nlp_flag,
 					 ndlp->nlp_state, vport->fc_flag);
 
@@ -5738,13 +5705,11 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 							NLP_EVT_DEVICE_RECOVERY);
 			}
 
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		} else {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "6456 Skip Setup RSCN Node x%x "
-					 "Data:x%x x%x x%lx\n",
+					 "Data:x%lx x%x x%lx\n",
 					 ndlp->nlp_DID, ndlp->nlp_flag,
 					 ndlp->nlp_state, vport->fc_flag);
 			ndlp = NULL;
@@ -5752,7 +5717,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 	} else {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "6457 Setup Active Node 2B_DISC x%x "
-				 "Data:x%x x%x x%lx\n",
+				 "Data:x%lx x%x x%lx\n",
 				 ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->nlp_state, vport->fc_flag);
 
@@ -5763,7 +5728,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 		if (ndlp->nlp_state == NLP_STE_ADISC_ISSUE ||
 		    ndlp->nlp_state == NLP_STE_PLOGI_ISSUE ||
 		    (!vport->phba->nvmet_support &&
-		     ndlp->nlp_flag & NLP_RCV_PLOGI))
+		     test_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag)))
 			return NULL;
 
 		if (vport->phba->nvmet_support)
@@ -5773,10 +5738,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 		 * allows for rediscovery
 		 */
 		lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	}
 	return ndlp;
 }
@@ -6147,7 +6109,7 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 				/* Clean up the ndlp on Fabric connections */
 				lpfc_drop_node(vport, ndlp);
 
-			} else if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+			} else if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 				/* Fail outstanding IO now since device
 				 * is marked for PLOGI.
 				 */
@@ -6360,11 +6322,11 @@ lpfc_mbx_cmpl_fdmi_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_DISCOVERY,
-			 "0004 rpi:%x DID:%x flg:%x %d x%px\n",
+			 "0004 rpi:%x DID:%x flg:%lx %d x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp);
@@ -6414,7 +6376,7 @@ __lpfc_find_node(struct lpfc_vport *vport, node_filter filter, void *param)
 		if (filter(ndlp, param)) {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE_VERBOSE,
 					 "3185 FIND node filter %ps DID "
-					 "ndlp x%px did x%x flg x%x st x%x "
+					 "ndlp x%px did x%x flg x%lx st x%x "
 					 "xri x%x type x%x rpi x%x\n",
 					 filter, ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp->nlp_state,
@@ -6552,7 +6514,7 @@ lpfc_nlp_init(struct lpfc_vport *vport, uint32_t did)
 		lpfc_printf_vlog(vport, KERN_INFO,
 				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
 				 "0007 Init New ndlp x%px, rpi:x%x DID:x%x "
-				 "flg:x%x refcnt:%d\n",
+				 "flg:x%lx refcnt:%d\n",
 				 ndlp, ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_flag, kref_read(&ndlp->kref));
 
@@ -6584,7 +6546,7 @@ lpfc_nlp_release(struct kref *kref)
 	struct lpfc_vport *vport = ndlp->vport;
 
 	lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-		"node release:    did:x%x flg:x%x type:x%x",
+		"node release:    did:x%x flg:x%lx type:x%x",
 		ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
@@ -6630,7 +6592,7 @@ lpfc_nlp_get(struct lpfc_nodelist *ndlp)
 
 	if (ndlp) {
 		lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-			"node get:        did:x%x flg:x%x refcnt:x%x",
+			"node get:        did:x%x flg:x%lx refcnt:x%x",
 			ndlp->nlp_DID, ndlp->nlp_flag,
 			kref_read(&ndlp->kref));
 
@@ -6662,7 +6624,7 @@ lpfc_nlp_put(struct lpfc_nodelist *ndlp)
 {
 	if (ndlp) {
 		lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-				"node put:        did:x%x flg:x%x refcnt:x%x",
+				"node put:        did:x%x flg:x%lx refcnt:x%x",
 				ndlp->nlp_DID, ndlp->nlp_flag,
 				kref_read(&ndlp->kref));
 	} else {
@@ -6715,11 +6677,12 @@ lpfc_fcf_inuse(struct lpfc_hba *phba)
 				spin_unlock_irqrestore(&vports[i]->fc_nodes_list_lock,
 						       iflags);
 				goto out;
-			} else if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+			} else if (test_bit(NLP_RPI_REGISTERED,
+					    &ndlp->nlp_flag)) {
 				ret = 1;
 				lpfc_printf_log(phba, KERN_INFO,
 						LOG_NODE | LOG_DISCOVERY,
-						"2624 RPI %x DID %x flag %x "
+						"2624 RPI %x DID %x flag %lx "
 						"still logged in\n",
 						ndlp->nlp_rpi, ndlp->nlp_DID,
 						ndlp->nlp_flag);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 006e22506ae8..7f57397d91a9 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3093,7 +3093,8 @@ lpfc_cleanup(struct lpfc_vport *vport)
 				lpfc_printf_vlog(ndlp->vport, KERN_ERR,
 						 LOG_DISCOVERY,
 						 "0282 did:x%x ndlp:x%px "
-						 "refcnt:%d xflags x%x nflag x%x\n",
+						 "refcnt:%d xflags x%x "
+						 "nflag x%lx\n",
 						 ndlp->nlp_DID, (void *)ndlp,
 						 kref_read(&ndlp->kref),
 						 ndlp->fc4_xpt_flags,
@@ -3414,7 +3415,7 @@ lpfc_sli4_node_rpi_restore(struct lpfc_hba *phba)
 						 LOG_NODE | LOG_DISCOVERY,
 						 "0099 RPI alloc error for "
 						 "ndlp x%px DID:x%06x "
-						 "flg:x%x\n",
+						 "flg:x%lx\n",
 						 ndlp, ndlp->nlp_DID,
 						 ndlp->nlp_flag);
 				continue;
@@ -3423,7 +3424,7 @@ lpfc_sli4_node_rpi_restore(struct lpfc_hba *phba)
 			lpfc_printf_vlog(ndlp->vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "0009 Assign RPI x%x to ndlp x%px "
-					 "DID:x%06x flg:x%x\n",
+					 "DID:x%06x flg:x%lx\n",
 					 ndlp->nlp_rpi, ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag);
 		}
@@ -3827,15 +3828,12 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
 						 &vports[i]->fc_nodes,
 						 nlp_listp) {
 
-				spin_lock_irq(&ndlp->lock);
-				ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-				spin_unlock_irq(&ndlp->lock);
-
+				clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 				if (offline || hba_pci_err) {
-					spin_lock_irq(&ndlp->lock);
-					ndlp->nlp_flag &= ~(NLP_UNREG_INP |
-							    NLP_RPI_REGISTERED);
-					spin_unlock_irq(&ndlp->lock);
+					clear_bit(NLP_UNREG_INP,
+						  &ndlp->nlp_flag);
+					clear_bit(NLP_RPI_REGISTERED,
+						  &ndlp->nlp_flag);
 				}
 
 				if (ndlp->nlp_type & NLP_FABRIC) {
@@ -6912,9 +6910,7 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 			 */
 			mod_timer(&ndlp->nlp_delayfunc,
 				  jiffies + msecs_to_jiffies(1000));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 			ndlp->nlp_last_elscmd = ELS_CMD_FDISC;
 			vport->port_state = LPFC_FDISC;
 		} else {
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 4574716c8764..4d88cfe71cae 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -65,7 +65,7 @@ lpfc_check_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		 struct lpfc_name *nn, struct lpfc_name *pn)
 {
 	/* First, we MUST have a RPI registered */
-	if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED))
+	if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag))
 		return 0;
 
 	/* Compare the ADISC rsp WWNN / WWPN matches our internal node
@@ -239,7 +239,7 @@ lpfc_els_abort(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	/* Abort outstanding I/O on NPort <nlp_DID> */
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_DISCOVERY,
 			 "2819 Abort outstanding I/O on NPort x%x "
-			 "Data: x%x x%x x%x\n",
+			 "Data: x%lx x%x x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
 	/* Clean up all fabric IOs first.*/
@@ -340,7 +340,7 @@ lpfc_defer_plogi_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *login_mbox)
 
 	/* Now process the REG_RPI cmpl */
 	lpfc_mbx_cmpl_reg_login(phba, login_mbox);
-	ndlp->nlp_flag &= ~NLP_ACC_REGLOGIN;
+	clear_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
 	kfree(save_iocb);
 }
 
@@ -404,7 +404,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	/* PLOGI chkparm OK */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "0114 PLOGI chkparm OK Data: x%x x%x x%x "
+			 "0114 PLOGI chkparm OK Data: x%x x%x x%lx "
 			 "x%x x%x x%lx\n",
 			 ndlp->nlp_DID, ndlp->nlp_state, ndlp->nlp_flag,
 			 ndlp->nlp_rpi, vport->port_state,
@@ -429,7 +429,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* if already logged in, do implicit logout */
 	switch (ndlp->nlp_state) {
 	case  NLP_STE_NPR_NODE:
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC))
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag))
 			break;
 		fallthrough;
 	case  NLP_STE_REG_LOGIN_ISSUE:
@@ -449,7 +449,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
 			ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
 			ndlp->nlp_nvme_info &= ~NLP_NVME_NSLER;
-			ndlp->nlp_flag &= ~NLP_FIRSTBURST;
+			clear_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 
 			lpfc_els_rsp_acc(vport, ELS_CMD_PLOGI, cmdiocb,
 					 ndlp, NULL);
@@ -480,7 +480,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
 	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
 	ndlp->nlp_nvme_info &= ~NLP_NVME_NSLER;
-	ndlp->nlp_flag &= ~NLP_FIRSTBURST;
+	clear_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 
 	login_mbox = NULL;
 	link_mbox = NULL;
@@ -552,13 +552,13 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		lpfc_can_disctmo(vport);
 	}
 
-	ndlp->nlp_flag &= ~NLP_SUPPRESS_RSP;
+	clear_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 	if ((phba->sli.sli_flag & LPFC_SLI_SUPPRESS_RSP) &&
 	    sp->cmn.valid_vendor_ver_level) {
 		vid = be32_to_cpu(sp->un.vv.vid);
 		flag = be32_to_cpu(sp->un.vv.flags);
 		if ((vid == LPFC_VV_EMLX_ID) && (flag & LPFC_VV_SUPPRESS_RSP))
-			ndlp->nlp_flag |= NLP_SUPPRESS_RSP;
+			set_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 	}
 
 	login_mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
@@ -627,10 +627,9 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			 * this ELS request. The only way to do this is
 			 * to register, then unregister the RPI.
 			 */
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= (NLP_RM_DFLT_RPI | NLP_ACC_REGLOGIN |
-					   NLP_RCV_PLOGI);
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_RM_DFLT_RPI, &ndlp->nlp_flag);
+			set_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
+			set_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 		}
 
 		stat.un.b.lsRjtRsnCode = LSRJT_INVALID_CMD;
@@ -665,9 +664,8 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	login_mbox->ctx_u.save_iocb = save_iocb; /* For PLOGI ACC */
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= (NLP_ACC_REGLOGIN | NLP_RCV_PLOGI);
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
+	set_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 
 	/* Start the ball rolling by issuing REG_LOGIN here */
 	rc = lpfc_sli_issue_mbox(phba, login_mbox, MBX_NOWAIT);
@@ -797,7 +795,7 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		 */
 		if (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET)) {
 			if ((ndlp->nlp_state != NLP_STE_MAPPED_NODE) &&
-			    !(ndlp->nlp_flag & NLP_NPR_ADISC))
+			    !test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag))
 				lpfc_nlp_set_state(vport, ndlp,
 						   NLP_STE_MAPPED_NODE);
 		}
@@ -814,9 +812,7 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* 1 sec timeout */
 	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000));
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 	ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
@@ -835,9 +831,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* Only call LOGO ACC for first LOGO, this avoids sending unnecessary
 	 * PLOGIs during LOGO storms from a device.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	if (els_cmd == ELS_CMD_PRLO)
 		lpfc_els_rsp_acc(vport, ELS_CMD_PRLO, cmdiocb, ndlp, NULL);
 	else
@@ -890,9 +884,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			 */
 			mod_timer(&ndlp->nlp_delayfunc,
 				  jiffies + msecs_to_jiffies(1000));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 			ndlp->nlp_last_elscmd = ELS_CMD_FDISC;
 			vport->port_state = LPFC_FDISC;
 		} else {
@@ -915,14 +907,12 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		     ndlp->nlp_state <= NLP_STE_PRLI_ISSUE)) {
 			mod_timer(&ndlp->nlp_delayfunc,
 				  jiffies + msecs_to_jiffies(1000 * 1));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 			ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_ELS | LOG_DISCOVERY,
 					 "3204 Start nlpdelay on DID x%06x "
-					 "nflag x%x lastels x%x ref cnt %u",
+					 "nflag x%lx lastels x%x ref cnt %u",
 					 ndlp->nlp_DID, ndlp->nlp_flag,
 					 ndlp->nlp_last_elscmd,
 					 kref_read(&ndlp->kref));
@@ -935,9 +925,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 	/* The driver has to wait until the ACC completes before it continues
 	 * processing the LOGO.  The action will resume in
 	 * lpfc_cmpl_els_logo_acc routine. Since part of processing includes an
@@ -978,7 +966,7 @@ lpfc_rcv_prli_support_check(struct lpfc_vport *vport,
 out:
 	lpfc_printf_vlog(vport, KERN_WARNING, LOG_DISCOVERY,
 			 "6115 Rcv PRLI (%x) check failed: ndlp rpi %d "
-			 "state x%x flags x%x port_type: x%x "
+			 "state x%x flags x%lx port_type: x%x "
 			 "npr->initfcn: x%x npr->tgtfcn: x%x\n",
 			 cmd, ndlp->nlp_rpi, ndlp->nlp_state,
 			 ndlp->nlp_flag, vport->port_type,
@@ -1020,7 +1008,7 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			if (npr->prliType == PRLI_NVME_TYPE)
 				ndlp->nlp_type |= NLP_NVME_TARGET;
 			if (npr->writeXferRdyDis)
-				ndlp->nlp_flag |= NLP_FIRSTBURST;
+				set_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 		}
 		if (npr->Retry && ndlp->nlp_type &
 					(NLP_FCP_INITIATOR | NLP_FCP_TARGET))
@@ -1057,7 +1045,7 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			roles |= FC_RPORT_ROLE_FCP_TARGET;
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-			"rport rolechg:   role:x%x did:x%x flg:x%x",
+			"rport rolechg:   role:x%x did:x%x flg:x%lx",
 			roles, ndlp->nlp_DID, ndlp->nlp_flag);
 
 		if (vport->cfg_enable_fc4_type != LPFC_ENABLE_NVME)
@@ -1068,10 +1056,8 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 static uint32_t
 lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 {
-	if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+	if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 		return 0;
 	}
 
@@ -1081,16 +1067,12 @@ lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		    (test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
 		    ((ndlp->nlp_fcp_info & NLP_FCP_2_DEVICE) &&
 		     (ndlp->nlp_type & NLP_FCP_TARGET)))) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_NPR_ADISC;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 			return 1;
 		}
 	}
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 	lpfc_unreg_rpi(vport, ndlp);
 	return 0;
 }
@@ -1115,10 +1097,10 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
 	/* If there is already an UNREG in progress for this ndlp,
 	 * no need to queue up another one.
 	 */
-	if (ndlp->nlp_flag & NLP_UNREG_INP) {
+	if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1435 release_rpi SKIP UNREG x%x on "
-				 "NPort x%x deferred x%x  flg x%x "
+				 "NPort x%x deferred x%x  flg x%lx "
 				 "Data: x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_defer_did,
@@ -1143,11 +1125,11 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
 
 		if (((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
 		    (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag)))
-			ndlp->nlp_flag |= NLP_UNREG_INP;
+			set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1437 release_rpi UNREG x%x "
-				 "on NPort x%x flg x%x\n",
+				 "on NPort x%x flg x%lx\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag);
 
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
@@ -1175,7 +1157,7 @@ lpfc_disc_illegal(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0271 Illegal State Transition: node x%x "
-			 "event x%x, state x%x Data: x%x x%x\n",
+			 "event x%x, state x%x Data: x%x x%lx\n",
 			 ndlp->nlp_DID, evt, ndlp->nlp_state, ndlp->nlp_rpi,
 			 ndlp->nlp_flag);
 	return ndlp->nlp_state;
@@ -1190,13 +1172,12 @@ lpfc_cmpl_plogi_illegal(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * working on the same NPortID, do nothing for this thread
 	 * to stop it.
 	 */
-	if (!(ndlp->nlp_flag & NLP_RCV_PLOGI)) {
+	if (!test_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0272 Illegal State Transition: node x%x "
-				 "event x%x, state x%x Data: x%x x%x\n",
+				 "event x%x, state x%x Data: x%x x%lx\n",
 				  ndlp->nlp_DID, evt, ndlp->nlp_state,
 				  ndlp->nlp_rpi, ndlp->nlp_flag);
-	}
 	return ndlp->nlp_state;
 }
 
@@ -1230,9 +1211,7 @@ lpfc_rcv_logo_unused_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_iocbq *cmdiocb = (struct lpfc_iocbq *) arg;
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
 
 	return ndlp->nlp_state;
@@ -1290,11 +1269,9 @@ lpfc_rcv_plogi_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			NULL);
 	} else {
 		if (lpfc_rcv_plogi(vport, ndlp, cmdiocb) &&
-		    (ndlp->nlp_flag & NLP_NPR_2B_DISC) &&
-		    (vport->num_disc_nodes)) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+		    test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag) &&
+		    vport->num_disc_nodes) {
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			/* Check if there are more PLOGIs to be sent */
 			lpfc_more_plogi(vport);
 			if (vport->num_disc_nodes == 0) {
@@ -1356,9 +1333,7 @@ lpfc_rcv_els_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	/* Put ndlp in npr state set plogi timer for 1 sec */
 	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000 * 1));
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 	ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 	ndlp->nlp_prev_state = NLP_STE_PLOGI_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
@@ -1389,7 +1364,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (ndlp->nlp_flag & NLP_ACC_REGLOGIN) {
+	if (test_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag)) {
 		/* Recovery from PLOGI collision logic */
 		return ndlp->nlp_state;
 	}
@@ -1418,7 +1393,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 		goto out;
 	/* PLOGI chkparm OK */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "0121 PLOGI chkparm OK Data: x%x x%x x%x x%x\n",
+			 "0121 PLOGI chkparm OK Data: x%x x%x x%lx x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_state,
 			 ndlp->nlp_flag, ndlp->nlp_rpi);
 	if (vport->cfg_fcp_class == 2 && (sp->cls2.classValid))
@@ -1446,14 +1421,14 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 			ed_tov = (phba->fc_edtov + 999999) / 1000000;
 		}
 
-		ndlp->nlp_flag &= ~NLP_SUPPRESS_RSP;
+		clear_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 		if ((phba->sli.sli_flag & LPFC_SLI_SUPPRESS_RSP) &&
 		    sp->cmn.valid_vendor_ver_level) {
 			vid = be32_to_cpu(sp->un.vv.vid);
 			flag = be32_to_cpu(sp->un.vv.flags);
 			if ((vid == LPFC_VV_EMLX_ID) &&
 			    (flag & LPFC_VV_SUPPRESS_RSP))
-				ndlp->nlp_flag |= NLP_SUPPRESS_RSP;
+				set_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 		}
 
 		/*
@@ -1476,7 +1451,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 						 LOG_TRACE_EVENT,
 						 "0133 PLOGI: no memory "
 						 "for config_link "
-						 "Data: x%x x%x x%x x%x\n",
+						 "Data: x%x x%x x%lx x%x\n",
 						 ndlp->nlp_DID, ndlp->nlp_state,
 						 ndlp->nlp_flag, ndlp->nlp_rpi);
 				goto out;
@@ -1500,7 +1475,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 	if (!mbox) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0018 PLOGI: no memory for reg_login "
-				 "Data: x%x x%x x%x x%x\n",
+				 "Data: x%x x%x x%lx x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
 				 ndlp->nlp_flag, ndlp->nlp_rpi);
 		goto out;
@@ -1520,7 +1495,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 			mbox->mbox_cmpl = lpfc_mbx_cmpl_fdmi_reg_login;
 			break;
 		default:
-			ndlp->nlp_flag |= NLP_REG_LOGIN_SEND;
+			set_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			mbox->mbox_cmpl = lpfc_mbx_cmpl_reg_login;
 		}
 
@@ -1535,8 +1510,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 					   NLP_STE_REG_LOGIN_ISSUE);
 			return ndlp->nlp_state;
 		}
-		if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+		clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 		/* decrement node reference count to the failed mbox
 		 * command
 		 */
@@ -1544,7 +1518,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 		lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0134 PLOGI: cannot issue reg_login "
-				 "Data: x%x x%x x%x x%x\n",
+				 "Data: x%x x%x x%lx x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
 				 ndlp->nlp_flag, ndlp->nlp_rpi);
 	} else {
@@ -1552,7 +1526,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0135 PLOGI: cannot format reg_login "
-				 "Data: x%x x%x x%x x%x\n",
+				 "Data: x%x x%x x%lx x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
 				 ndlp->nlp_flag, ndlp->nlp_rpi);
 	}
@@ -1605,18 +1579,15 @@ static uint32_t
 lpfc_device_rm_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			   void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		/* software abort outstanding PLOGI */
-		lpfc_els_abort(vport->phba, ndlp);
-
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	/* software abort outstanding PLOGI */
+	lpfc_els_abort(vport->phba, ndlp);
+
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 static uint32_t
@@ -1636,9 +1607,8 @@ lpfc_device_recov_plogi_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_PLOGI_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 	return ndlp->nlp_state;
 }
@@ -1656,10 +1626,7 @@ lpfc_rcv_plogi_adisc_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	cmdiocb = (struct lpfc_iocbq *) arg;
 
 	if (lpfc_rcv_plogi(vport, ndlp, cmdiocb)) {
-		if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+		if (test_and_clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 			if (vport->num_disc_nodes)
 				lpfc_more_adisc(vport);
 		}
@@ -1748,9 +1715,7 @@ lpfc_cmpl_adisc_adisc_issue(struct lpfc_vport *vport,
 		/* 1 sec timeout */
 		mod_timer(&ndlp->nlp_delayfunc,
 			  jiffies + msecs_to_jiffies(1000));
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_DELAY_TMO;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 		ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 
 		ndlp->nlp_prev_state = NLP_STE_ADISC_ISSUE;
@@ -1789,18 +1754,15 @@ static uint32_t
 lpfc_device_rm_adisc_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			   void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		/* software abort outstanding ADISC */
-		lpfc_els_abort(vport->phba, ndlp);
-
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	/* software abort outstanding ADISC */
+	lpfc_els_abort(vport->phba, ndlp);
+
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 static uint32_t
@@ -1820,9 +1782,8 @@ lpfc_device_recov_adisc_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_ADISC_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -1856,7 +1817,7 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc_vport *vport,
 		 * transition to UNMAPPED provided the RPI has completed
 		 * registration.
 		 */
-		if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+		if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
 			lpfc_rcv_prli(vport, ndlp, cmdiocb);
 			lpfc_els_rsp_prli_acc(vport, cmdiocb, ndlp);
 		} else {
@@ -1895,7 +1856,7 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	if ((mb = phba->sli.mbox_active)) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   (ndlp == mb->ctx_ndlp)) {
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+			clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			lpfc_nlp_put(ndlp);
 			mb->ctx_ndlp = NULL;
 			mb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
@@ -1906,7 +1867,7 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	list_for_each_entry_safe(mb, nextmb, &phba->sli.mboxq, list) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   (ndlp == mb->ctx_ndlp)) {
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+			clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			lpfc_nlp_put(ndlp);
 			list_del(&mb->list);
 			phba->sli.mboxq_cnt--;
@@ -1976,9 +1937,7 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 		/* Put ndlp in npr state set plogi timer for 1 sec */
 		mod_timer(&ndlp->nlp_delayfunc,
 			  jiffies + msecs_to_jiffies(1000 * 1));
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_DELAY_TMO;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 		ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 
 		lpfc_issue_els_logo(vport, ndlp, 0);
@@ -1989,7 +1948,7 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
 
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 
 	/* Only if we are not a fabric nport do we issue PRLI */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
@@ -2061,15 +2020,12 @@ lpfc_device_rm_reglogin_issue(struct lpfc_vport *vport,
 			      void *arg,
 			      uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 static uint32_t
@@ -2084,17 +2040,16 @@ lpfc_device_recov_reglogin_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_REG_LOGIN_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
 
 	/* If we are a target we won't immediately transition into PRLI,
 	 * so if REG_LOGIN already completed we don't need to ignore it.
 	 */
-	if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED) ||
+	if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag) ||
 	    !vport->phba->nvmet_support)
-		ndlp->nlp_flag |= NLP_IGNR_REG_CMPL;
+		set_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -2228,7 +2183,8 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			if (npr->targetFunc) {
 				ndlp->nlp_type |= NLP_FCP_TARGET;
 				if (npr->writeXferRdyDis)
-					ndlp->nlp_flag |= NLP_FIRSTBURST;
+					set_bit(NLP_FIRSTBURST,
+						&ndlp->nlp_flag);
 			}
 			if (npr->Retry)
 				ndlp->nlp_fcp_info |= NLP_FCP_2_DEVICE;
@@ -2272,7 +2228,7 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				/* Both sides support FB. The target's first
 				 * burst size is a 512 byte encoded value.
 				 */
-				ndlp->nlp_flag |= NLP_FIRSTBURST;
+				set_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 				ndlp->nvme_fb_size = bf_get_be32(prli_fb_sz,
 								 nvpr);
 
@@ -2287,7 +2243,7 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 				 "6029 NVME PRLI Cmpl w1 x%08x "
-				 "w4 x%08x w5 x%08x flag x%x, "
+				 "w4 x%08x w5 x%08x flag x%lx, "
 				 "fcp_info x%x nlp_type x%x\n",
 				 be32_to_cpu(nvpr->word1),
 				 be32_to_cpu(nvpr->word4),
@@ -2299,9 +2255,7 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	    (vport->port_type == LPFC_NPIV_PORT) &&
 	     vport->cfg_restrict_login) {
 out:
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_TARGET_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_TARGET_REMOVE, &ndlp->nlp_flag);
 		lpfc_issue_els_logo(vport, ndlp, 0);
 
 		ndlp->nlp_prev_state = NLP_STE_PRLI_ISSUE;
@@ -2353,18 +2307,15 @@ static uint32_t
 lpfc_device_rm_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			  void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		/* software abort outstanding PLOGI */
-		lpfc_els_abort(vport->phba, ndlp);
-
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	/* software abort outstanding PLOGI */
+	lpfc_els_abort(vport->phba, ndlp);
+
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 
@@ -2401,9 +2352,8 @@ lpfc_device_recov_prli_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_PRLI_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -2442,9 +2392,7 @@ lpfc_rcv_logo_logo_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_iocbq *cmdiocb = (struct lpfc_iocbq *)arg;
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
 	return ndlp->nlp_state;
 }
@@ -2483,9 +2431,8 @@ lpfc_cmpl_logo_logo_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	ndlp->nlp_prev_state = NLP_STE_LOGO_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -2591,8 +2538,9 @@ lpfc_device_recov_unmap_node(struct lpfc_vport *vport,
 {
 	ndlp->nlp_prev_state = NLP_STE_UNMAPPED_NODE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
 	ndlp->nlp_fc4_type &= ~(NLP_FC4_FCP | NLP_FC4_NVME);
 	spin_unlock_irq(&ndlp->lock);
 	lpfc_disc_set_adisc(vport, ndlp);
@@ -2653,9 +2601,7 @@ lpfc_rcv_prlo_mapped_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	lpfc_sli_abort_iocb(vport, ndlp->nlp_sid, 0, LPFC_CTX_TGT);
 
 	/* Send PRLO_ACC */
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	lpfc_els_rsp_acc(vport, ELS_CMD_PRLO, cmdiocb, ndlp, NULL);
 
 	/* Save ELS_CMD_PRLO as the last elscmd and then set to NPR.
@@ -2665,7 +2611,7 @@ lpfc_rcv_prlo_mapped_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_ELS | LOG_DISCOVERY,
-			 "3422 DID x%06x nflag x%x lastels x%x ref cnt %u\n",
+			 "3422 DID x%06x nflag x%lx lastels x%x ref cnt %u\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag,
 			 ndlp->nlp_last_elscmd,
 			 kref_read(&ndlp->kref));
@@ -2685,8 +2631,9 @@ lpfc_device_recov_mapped_node(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_MAPPED_NODE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
 	ndlp->nlp_fc4_type &= ~(NLP_FC4_FCP | NLP_FC4_NVME);
 	spin_unlock_irq(&ndlp->lock);
 	return ndlp->nlp_state;
@@ -2699,16 +2646,16 @@ lpfc_rcv_plogi_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	struct lpfc_iocbq *cmdiocb  = (struct lpfc_iocbq *) arg;
 
 	/* Ignore PLOGI if we have an outstanding LOGO */
-	if (ndlp->nlp_flag & (NLP_LOGO_SND | NLP_LOGO_ACC))
+	if (test_bit(NLP_LOGO_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_LOGO_ACC, &ndlp->nlp_flag))
 		return ndlp->nlp_state;
 	if (lpfc_rcv_plogi(vport, ndlp, cmdiocb)) {
 		lpfc_cancel_retry_delay_tmo(vport, ndlp);
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~(NLP_NPR_ADISC | NLP_NPR_2B_DISC);
-		spin_unlock_irq(&ndlp->lock);
-	} else if (!(ndlp->nlp_flag & NLP_NPR_2B_DISC)) {
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+	} else if (!test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 		/* send PLOGI immediately, move to PLOGI issue state */
-		if (!(ndlp->nlp_flag & NLP_DELAY_TMO)) {
+		if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = NLP_STE_NPR_NODE;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -2729,14 +2676,14 @@ lpfc_rcv_prli_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	stat.un.b.lsRjtRsnCodeExp = LSEXP_NOTHING_MORE;
 	lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb, ndlp, NULL);
 
-	if (!(ndlp->nlp_flag & NLP_DELAY_TMO)) {
+	if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag)) {
 		/*
 		 * ADISC nodes will be handled in regular discovery path after
 		 * receiving response from NS.
 		 *
 		 * For other nodes, Send PLOGI to trigger an implicit LOGO.
 		 */
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = NLP_STE_NPR_NODE;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -2767,15 +2714,15 @@ lpfc_rcv_padisc_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * or discovery in progress for this node. Starting discovery
 	 * here will affect the counting of discovery threads.
 	 */
-	if (!(ndlp->nlp_flag & NLP_DELAY_TMO) &&
-	    !(ndlp->nlp_flag & NLP_NPR_2B_DISC)) {
+	if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag) &&
+	    !test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 		/*
 		 * ADISC nodes will be handled in regular discovery path after
 		 * receiving response from NS.
 		 *
 		 * For other nodes, Send PLOGI to trigger an implicit LOGO.
 		 */
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = NLP_STE_NPR_NODE;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -2790,24 +2737,18 @@ lpfc_rcv_prlo_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_iocbq *cmdiocb = (struct lpfc_iocbq *) arg;
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 
 	lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
 
-	if ((ndlp->nlp_flag & NLP_DELAY_TMO) == 0) {
+	if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag)) {
 		mod_timer(&ndlp->nlp_delayfunc,
 			  jiffies + msecs_to_jiffies(1000 * 1));
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_DELAY_TMO;
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 		ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 	} else {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 	}
 	return ndlp->nlp_state;
 }
@@ -2844,7 +2785,7 @@ lpfc_cmpl_prli_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (ulp_status && (ndlp->nlp_flag & NLP_NODEV_REMOVE)) {
+	if (ulp_status && test_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag)) {
 		lpfc_drop_node(vport, ndlp);
 		return NLP_STE_FREED_NODE;
 	}
@@ -2877,7 +2818,7 @@ lpfc_cmpl_adisc_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (ulp_status && (ndlp->nlp_flag & NLP_NODEV_REMOVE)) {
+	if (ulp_status && test_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag)) {
 		lpfc_drop_node(vport, ndlp);
 		return NLP_STE_FREED_NODE;
 	}
@@ -2896,12 +2837,11 @@ lpfc_cmpl_reglogin_npr_node(struct lpfc_vport *vport,
 		/* SLI4 ports have preallocated logical rpis. */
 		if (vport->phba->sli_rev < LPFC_SLI_REV4)
 			ndlp->nlp_rpi = mb->un.varWords[0];
-		ndlp->nlp_flag |= NLP_RPI_REGISTERED;
-		if (ndlp->nlp_flag & NLP_LOGO_ACC) {
+		set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
+		if (test_bit(NLP_LOGO_ACC, &ndlp->nlp_flag))
 			lpfc_unreg_rpi(vport, ndlp);
-		}
 	} else {
-		if (ndlp->nlp_flag & NLP_NODEV_REMOVE) {
+		if (test_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag)) {
 			lpfc_drop_node(vport, ndlp);
 			return NLP_STE_FREED_NODE;
 		}
@@ -2913,10 +2853,8 @@ static uint32_t
 lpfc_device_rm_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
 	}
 	lpfc_drop_node(vport, ndlp);
@@ -2932,8 +2870,9 @@ lpfc_device_recov_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		return ndlp->nlp_state;
 
 	lpfc_cancel_retry_delay_tmo(vport, ndlp);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
 	ndlp->nlp_fc4_type &= ~(NLP_FC4_FCP | NLP_FC4_NVME);
 	spin_unlock_irq(&ndlp->lock);
 	return ndlp->nlp_state;
@@ -3146,7 +3085,7 @@ lpfc_disc_state_machine(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* DSM in event <evt> on NPort <nlp_DID> in state <cur_state> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 			 "0211 DSM in event x%x on NPort x%x in "
-			 "state %d rpi x%x Data: x%x x%x\n",
+			 "state %d rpi x%x Data: x%lx x%x\n",
 			 evt, ndlp->nlp_DID, cur_state, ndlp->nlp_rpi,
 			 ndlp->nlp_flag, data1);
 
@@ -3163,12 +3102,12 @@ lpfc_disc_state_machine(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			((uint32_t)ndlp->nlp_type));
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 			 "0212 DSM out state %d on NPort x%x "
-			 "rpi x%x Data: x%x x%x\n",
+			 "rpi x%x Data: x%lx x%x\n",
 			 rc, ndlp->nlp_DID, ndlp->nlp_rpi, ndlp->nlp_flag,
 			 data1);
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_DSM,
-			"DSM out:         ste:%d did:x%x flg:x%x",
+			"DSM out:         ste:%d did:x%x flg:x%lx",
 			rc, ndlp->nlp_DID, ndlp->nlp_flag);
 		/* Decrement the ndlp reference count held for this function */
 		lpfc_nlp_put(ndlp);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 4f628e00d1c1..6e0b27460c24 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1232,7 +1232,7 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 
 			/* Word 5 */
 			if ((phba->cfg_nvme_enable_fb) &&
-			    (pnode->nlp_flag & NLP_FIRSTBURST)) {
+			    test_bit(NLP_FIRSTBURST, &pnode->nlp_flag)) {
 				req_len = lpfc_ncmd->nvmeCmd->payload_length;
 				if (req_len < pnode->nvme_fb_size)
 					wqe->fcp_iwrite.initial_xfer_len =
@@ -2651,14 +2651,11 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				 * reference. Check if another thread has set
 				 * NLP_DROPPED.
 				 */
-				spin_lock_irq(&ndlp->lock);
-				if (!(ndlp->nlp_flag & NLP_DROPPED)) {
-					ndlp->nlp_flag |= NLP_DROPPED;
-					spin_unlock_irq(&ndlp->lock);
+				if (!test_and_set_bit(NLP_DROPPED,
+						      &ndlp->nlp_flag)) {
 					lpfc_nlp_put(ndlp);
 					return;
 				}
-				spin_unlock_irq(&ndlp->lock);
 			}
 		}
 	}
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 0cef5d089f34..3b29d57d77ac 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -2854,7 +2854,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 			/* In template ar=1 wqes=0 sup=0 irsp=0 irsplen=0 */
 
 			if (rsp->rsplen == LPFC_NVMET_SUCCESS_LEN) {
-				if (ndlp->nlp_flag & NLP_SUPPRESS_RSP)
+				if (test_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag))
 					bf_set(wqe_sup,
 					       &wqe->fcp_tsend.wqe_com, 1);
 			} else {
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 0eaede8275da..908b2f7dd70c 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4629,7 +4629,7 @@ static int lpfc_scsi_prep_cmnd_buf_s3(struct lpfc_vport *vport,
 			iocb_cmd->ulpCommand = CMD_FCP_IWRITE64_CR;
 			iocb_cmd->ulpPU = PARM_READ_CHECK;
 			if (vport->cfg_first_burst_size &&
-			    (pnode->nlp_flag & NLP_FIRSTBURST)) {
+			    test_bit(NLP_FIRSTBURST, &pnode->nlp_flag)) {
 				u32 xrdy_len;
 
 				fcpdl = scsi_bufflen(scsi_cmnd);
@@ -5829,7 +5829,7 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct fc_rport *rport,
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
 			 "0702 Issue %s to TGT %d LUN %llu "
-			 "rpi x%x nlp_flag x%x Data: x%x x%x\n",
+			 "rpi x%x nlp_flag x%lx Data: x%x x%x\n",
 			 lpfc_taskmgmt_name(task_mgmt_cmd), tgt_id, lun_id,
 			 pnode->nlp_rpi, pnode->nlp_flag, iocbq->sli4_xritag,
 			 iocbq->cmd_flag);
@@ -6094,8 +6094,8 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0722 Target Reset rport failure: rdata x%px\n", rdata);
 		if (pnode) {
+			clear_bit(NLP_NPR_ADISC, &pnode->nlp_flag);
 			spin_lock_irqsave(&pnode->lock, flags);
-			pnode->nlp_flag &= ~NLP_NPR_ADISC;
 			pnode->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
 			spin_unlock_irqrestore(&pnode->lock, flags);
 		}
@@ -6124,7 +6124,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 		    !pnode->logo_waitq) {
 			pnode->logo_waitq = &waitq;
 			pnode->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-			pnode->nlp_flag |= NLP_ISSUE_LOGO;
+			set_bit(NLP_ISSUE_LOGO, &pnode->nlp_flag);
 			pnode->save_flags |= NLP_WAIT_FOR_LOGO;
 			spin_unlock_irqrestore(&pnode->lock, flags);
 			lpfc_unreg_rpi(vport, pnode);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c1ce05646e72..874644b31a3e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2913,14 +2913,14 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				vport,
 				KERN_INFO, LOG_MBOX | LOG_DISCOVERY,
 				"1438 UNREG cmpl deferred mbox x%x "
-				"on NPort x%x Data: x%x x%x x%px x%lx x%x\n",
+				"on NPort x%x Data: x%lx x%x x%px x%lx x%x\n",
 				ndlp->nlp_rpi, ndlp->nlp_DID,
 				ndlp->nlp_flag, ndlp->nlp_defer_did,
 				ndlp, vport->load_flag, kref_read(&ndlp->kref));
 
-			if ((ndlp->nlp_flag & NLP_UNREG_INP) &&
-			    (ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING)) {
-				ndlp->nlp_flag &= ~NLP_UNREG_INP;
+			if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag) &&
+			    ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING) {
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				ndlp->nlp_defer_did = NLP_EVT_NOTHING_PENDING;
 				lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
 			}
@@ -2970,7 +2970,7 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport  *vport = pmb->vport;
 	struct lpfc_nodelist *ndlp;
-	u32 unreg_inp;
+	bool unreg_inp;
 
 	ndlp = pmb->ctx_ndlp;
 	if (pmb->u.mb.mbxCommand == MBX_UNREG_LOGIN) {
@@ -2983,7 +2983,7 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 					 vport, KERN_INFO,
 					 LOG_MBOX | LOG_SLI | LOG_NODE,
 					 "0010 UNREG_LOGIN vpi:x%x "
-					 "rpi:%x DID:%x defer x%x flg x%x "
+					 "rpi:%x DID:%x defer x%x flg x%lx "
 					 "x%px\n",
 					 vport->vpi, ndlp->nlp_rpi,
 					 ndlp->nlp_DID, ndlp->nlp_defer_did,
@@ -2993,11 +2993,9 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				/* Cleanup the nlp_flag now that the UNREG RPI
 				 * has completed.
 				 */
-				spin_lock_irq(&ndlp->lock);
-				unreg_inp = ndlp->nlp_flag & NLP_UNREG_INP;
-				ndlp->nlp_flag &=
-					~(NLP_UNREG_INP | NLP_LOGO_ACC);
-				spin_unlock_irq(&ndlp->lock);
+				unreg_inp = test_and_clear_bit(NLP_UNREG_INP,
+							       &ndlp->nlp_flag);
+				clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 
 				/* Check to see if there are any deferred
 				 * events to process
@@ -14342,9 +14340,7 @@ lpfc_sli4_sp_handle_mbox_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 			 * an unsolicited PLOGI from the same NPortId from
 			 * starting another mailbox transaction.
 			 */
-			spin_lock_irqsave(&ndlp->lock, iflags);
-			ndlp->nlp_flag |= NLP_UNREG_INP;
-			spin_unlock_irqrestore(&ndlp->lock, iflags);
+			set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 			lpfc_unreg_login(phba, vport->vpi,
 					 pmbox->un.varWords[0], pmb);
 			pmb->mbox_cmpl = lpfc_mbx_cmpl_dflt_rpi;
@@ -19093,9 +19089,9 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	 * to free ndlp when transmit completes
 	 */
 	if (ndlp->nlp_state == NLP_STE_UNUSED_NODE &&
-	    !(ndlp->nlp_flag & NLP_DROPPED) &&
+	    !test_bit(NLP_DROPPED, &ndlp->nlp_flag) &&
 	    !(ndlp->fc4_xpt_flags & (NVME_XPT_REGD | SCSI_XPT_REGD))) {
-		ndlp->nlp_flag |= NLP_DROPPED;
+		set_bit(NLP_DROPPED, &ndlp->nlp_flag);
 		lpfc_nlp_put(ndlp);
 	}
 }
@@ -21113,11 +21109,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 				/* Unregister the RPI when mailbox complete */
 				mb->mbox_flag |= LPFC_MBX_IMED_UNREG;
 				restart_loop = 1;
-				spin_unlock_irq(&phba->hbalock);
-				spin_lock(&ndlp->lock);
-				ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-				spin_unlock(&ndlp->lock);
-				spin_lock_irq(&phba->hbalock);
+				clear_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 				break;
 			}
 		}
@@ -21132,9 +21124,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 			ndlp = mb->ctx_ndlp;
 			mb->ctx_ndlp = NULL;
 			if (ndlp) {
-				spin_lock(&ndlp->lock);
-				ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-				spin_unlock(&ndlp->lock);
+				clear_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 				lpfc_nlp_put(ndlp);
 			}
 		}
@@ -21143,9 +21133,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 
 	/* Release the ndlp with the cleaned-up active mailbox command */
 	if (act_mbx_ndlp) {
-		spin_lock(&act_mbx_ndlp->lock);
-		act_mbx_ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-		spin_unlock(&act_mbx_ndlp->lock);
+		clear_bit(NLP_IGNR_REG_CMPL, &act_mbx_ndlp->nlp_flag);
 		lpfc_nlp_put(act_mbx_ndlp);
 	}
 }
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index 7a4d4d8e2ad5..9e0e35763377 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -496,7 +496,7 @@ lpfc_send_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	    !ndlp->logo_waitq) {
 		ndlp->logo_waitq = &waitq;
 		ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-		ndlp->nlp_flag |= NLP_ISSUE_LOGO;
+		set_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 		ndlp->save_flags |= NLP_WAIT_FOR_LOGO;
 	}
 	spin_unlock_irq(&ndlp->lock);
@@ -515,8 +515,8 @@ lpfc_send_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	}
 
 	/* Error - clean up node flags. */
+	clear_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_ISSUE_LOGO;
 	ndlp->save_flags &= ~NLP_WAIT_FOR_LOGO;
 	spin_unlock_irq(&ndlp->lock);
 
@@ -708,7 +708,7 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_VPORT | LOG_ELS,
 					 "1829 DA_ID issue status %d. "
-					 "SFlag x%x NState x%x, NFlag x%x "
+					 "SFlag x%x NState x%x, NFlag x%lx "
 					 "Rpi x%x\n",
 					 rc, ndlp->save_flags, ndlp->nlp_state,
 					 ndlp->nlp_flag, ndlp->nlp_rpi);
-- 
2.38.0


